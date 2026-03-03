unit uModuleConnection;

interface

uses
  SysUtils, StrUtils, Classes, DBXpress, FMTBcd, DB, SqlExpr, DBClient,
  cxGrid,cxGridDBTableView, cxTreeView,  Math, cxGridExportLink, cxExportPivotGridLink,
  cxGridDBBandedTableView, cxDBPivotGrid, cxCurrencyEdit, cxCustomPivotGrid,
  cxGridBandedTableView, cxDBExtLookupComboBox, cxCustomData,
  cxGridCustomTableView, cxDBTL, cxTLExportLink,Dialogs, MyAccess;


type
  TConnectionType = (ctInterbase, ctMSSQL, ctMySQL, ctOracle);

   TcxDBPivotHelper = class(TcxDBPivotGrid)
public
     procedure ExportToXLS(ExpandAll: Boolean = True; sFileName: String = '';
         DoShowInfo: Boolean = True);
     procedure LoadFromCDS(ACDS: TClientDataSet; ExpandAll: Boolean = True;
         ReCreateAllItem: Boolean = True);
     procedure SetAllUpperCaseColumn;
     procedure SetColColumns(ColumnSets: Array Of String);
     procedure SetColumnsCaption(ColumnSets, ColumnCaption: Array Of String);
     procedure SetColumnsWidth(ColumnSets: Array Of String; Widths: Array Of
         Integer); overload;
     procedure SetDataColumns(ColumnSets: Array Of String);
     procedure SetRowColumns(ColumnSets: Array Of String); overload;
     procedure SetVisibleColumns(ColumnSets: Array Of String; IsVisible: Boolean);
end;

var
  conDBX: TSQLConnection;
  transDBX: TTransactionDesc;

  function xCreateMyConnection(aConnection: TConnectionType; aHost: string;
    aDatabase: string; aUserName: string; aPassword: string; aPort: Integer = 3306): TMyConnection;
  function xOpenQuery(aSQL: string; out RecCount: Integer; aMyConn: TMyConnection = nil): TMyQuery; overload;
  function xOpenQuery(aSQL: string; aMyConn: TMyConnection = nil): TMyQuery; overload;
  procedure EnsureConnected(AConn: TMyConnection);
  function ExecSQLDirect(AConnection: TMyConnection; const ASQL: string): Integer;

function xCreateConnection(aConnection: TConnectionType; aHost: string;
  aDatabase: string; aUserName: string; aPassword: string): TSQLConnection;
function xOpenQuery(aSQL: string; aSQLConnection: TSQLConnection = nil): TSQLQuery; overload;
function xOpenQuery(aSQL: string; out RecCount: Integer; aSQLConnection: TSQLConnection = nil): TSQLQuery; overload;
procedure xExecQuery(aSQL: string; aSQLConnection: TSQLConnection = nil); overload;
procedure xExecQuery(aSQL: string; out aTransactionID: TTransactionDesc; aSQLConnection: TSQLConnection = nil); overload;
procedure xCommit(aSQLConnection: TSQLConnection = nil); overload;
procedure xCommit(aTransactionID: TTransactionDesc; aSQLConnection: TSQLConnection = nil); overload;
procedure xRollback(aSQLConnection: TSQLConnection = nil); overload;
procedure xRollback(aTransactionID: TTransactionDesc; aSQLConnection: TSQLConnection = nil); overload;


implementation

{* MyDAC Connection *}

function xCreateMyConnection(aConnection: TConnectionType; aHost: string;
  aDatabase: string; aUserName: string; aPassword: string; aPort: Integer = 3306): TMyConnection;
begin
  Result := TMyConnection.Create(nil);
  with Result do
  begin
    if aConnection = ctMySQL then
    begin
      Username := aUserName;
      Password := aPassword;
      Database := aDatabase;
      Server   := aHost;
      Port     := aPort;
     // LoginPrompt := False;
      Connected := True;
    end;
  end;
end;

function xOpenQuery(aSQL: string; out RecCount: Integer; aMyConn: TMyConnection = nil): TMyQuery;
begin
  Result := TMyQuery.Create(nil);
  RecCount := 0;

  if (UpperCase(LeftStr(aSQL,6)) <> 'SELECT') and (Length(Trim(aSQL)) = 0) then
  begin
    FreeAndNil(Result);
    Exit;
  end;

  with Result do
  begin
    EnsureConnected(aMyConn);
    Connection := aMyConn;

    SQL.Text := aSQL;
    try
      Open;
      First;
      while not Eof do
      begin
        Inc(RecCount);
        Next;
      end;
      First;
    except
      FreeAndNil(Result);
    end;
  end;
end;

function xOpenQuery(aSQL: string; aMyConn: TMyConnection = nil): TMyQuery;
begin
  Result := TMyQuery.Create(nil);
  
  if (UpperCase(LeftStr(aSQL,6)) <> 'SELECT') and (Length(Trim(aSQL)) = 0) then
  begin
    FreeAndNil(Result);
    Exit;
  end;

  with Result do
  begin
    EnsureConnected(aMyConn);
    Connection := aMyConn;

    SQL.Text := aSQL;
    try
      Open;
      First;
    except
      FreeAndNil(Result);
    end;
  end;

end;

procedure EnsureConnected(AConn: TMyConnection);
var
  Retry: Integer;
begin
  if (AConn = nil) then Exit;

  // Kalau koneksi belum aktif
  if not AConn.Connected then
  begin
    Retry := 0;
    while Retry < 3 do
    begin
      try
        AConn.Connect;
        Exit;
      except
        Inc(Retry);
        Sleep(1000);
      end;
    end;
    raise Exception.Create('Gagal konek ke database setelah retry');
  end
  else
  begin
    try
      // Test koneksi
      AConn.Ping;
    except
      // Kalau Ping gagal, pastikan benar-benar disconnect
      if AConn.Connected then
      begin
        try
          AConn.Disconnect;
        except
          // abaikan kalau error disconnect
        end;
      end;

      // Coba reconnect
      Retry := 0;
      while Retry < 3 do
      begin
        try
          Sleep(1000);
          AConn.Connect;
          Exit;
        except
          Inc(Retry);
        end;
      end;
      raise Exception.Create('Koneksi database terputus dan gagal reconnect');
    end;
  end;
end;

function ExecSQLDirect(AConnection: TMyConnection; const ASQL: string): Integer;
var
  Q: TMyQuery;
begin
  Result := 0;
  Q := TMyQuery.Create(nil);
  try
    Q.Connection := AConnection;
    Q.SQL.Text := ASQL;
    Q.ExecSQL;
    Result := Q.RowsAffected; // kalau INSERT/UPDATE/DELETE akan return jumlah row
  finally
    Q.Free;
  end;
end;

{* DBExpress  *}
 
function xCreateConnection(aConnection: TConnectionType; aHost: string;
  aDatabase: string; aUserName: string; aPassword: string): TSQLConnection;
begin
  Result := TSQLConnection.Create(nil);
  with Result do
  begin
    if aConnection = ctMSSQL then
    begin
      DriverName := 'MSSQL';
      LibraryName := 'dbexpmss.dll';
      GetDriverFunc := 'getSQLDriverMSSQL';

       VendorLib := 'oledb';
      Params.Append('HostName=' + aHost);
      Params.Append('Database=' + aDatabase);
      Params.Append('User_Name=' + aUserName);
      Params.Append('Password=' + aPassword);
    end;
     if aConnection = ctMySQL then
    begin
      DriverName := 'MySQL';
//      LibraryName := 'dbexpmysql';
      LibraryName := 'dbxopenmysql50.dll';
      GetDriverFunc := 'getSQLDriverMYSQL50';

      VendorLib := 'libmysql.dll';
      Params.Append('HostName=' + aHost);
      Params.Append('Database=' + aDatabase);
      Params.Append('User_Name=' + aUserName);
      Params.Append('Password=' + aPassword);
    end;

    if ConnectionState = csStateClosed then
    begin
      try
        LoginPrompt := False;
        Connected := True;
      except
        on E: Exception do
        begin
          raise Exception.Create(E.Message);
        end;
      end;
    end;
  end;

end;

function xOpenQuery(aSQL: string; out RecCount: Integer; aSQLConnection: TSQLConnection = nil): TSQLQuery;
begin
  Result := TSQLQuery.Create(nil);
  RecCount := 0;
  if (UpperCase(LeftStr(aSQL,6)) <> 'SELECT') and (Length(Trim(aSQL)) = 0) then
  begin
    FreeAndNil(Result);
    Exit;
  end;

  with Result do
  begin
    if aSQLConnection = nil then
      SQLConnection := conDBX
    else
      SQLConnection := aSQLConnection;
    transDBX.IsolationLevel := xilDIRTYREAD;
    SQL.Clear;
    SQL.Add(aSQL);
    try
      Open;
      First;
      while not Eof do
      begin
        Inc(RecCount);
        Next;
      end;
      First;
    except
      FreeAndNil(Result);
    end;
  end;

end;

function xOpenQuery(aSQL: string; aSQLConnection: TSQLConnection = nil): TSQLQuery;
begin
  Result := TSQLQuery.Create(nil);
  if (UpperCase(LeftStr(aSQL,6)) <> 'SELECT') and (Length(Trim(aSQL)) = 0) then
  begin
    FreeAndNil(Result);
    Exit;
  end;

  with Result do
  begin
    if aSQLConnection = nil then
      SQLConnection := conDBX
    else
      SQLConnection := aSQLConnection;
    transDBX.IsolationLevel := xilDIRTYREAD;
    SQL.Clear;
    SQL.Add(aSQL);
    try
      Open;
      First;
    except
      FreeAndNil(Result);
    end;
  end;

end;

procedure xExecQuery(aSQL: string; aSQLConnection: TSQLConnection = nil);
var
  newQryDBX: TSQLQuery;
begin
  if (UpperCase(LeftStr(aSQL,6)) = 'SELECT') and (Length(Trim(aSQL)) = 0) then
  begin
    Exit;
  end;

  newQryDBX := TSQLQuery.Create(nil);
  with newQryDBX do
  begin
    SQL.Clear;
    SQL.Add(aSQL);
    if aSQLConnection = nil then
    begin
      SQLConnection := conDBX;
      if not ConDBX.InTransaction then
      begin
        transDBX.TransactionID := transDBX.TransactionID + 1;
        transDBX.IsolationLevel := xilREADCOMMITTED;
        ConDBX.StartTransaction(transDBX);
      end;
    end else
    begin
      SQLConnection := aSQLConnection;
      if not aSQLConnection.InTransaction then
      begin
        transDBX.TransactionID := transDBX.TransactionID + 1;
        transDBX.IsolationLevel := xilREADCOMMITTED;
        aSQLConnection.StartTransaction(transDBX);
      end;
    end;

    try
      ExecSQL();
    finally
      FreeAndNil(newQryDBX);
    {except
      on E: Exception do
      begin
        FreeAndNil(newQryDBX);
        //xCloseConnection(aSQLConnection);
        //raise Exception.Create(E.Message);
      end;}
    end;
  end;
  //FreeAndNil(newQryDBX);

end;

procedure xExecQuery(aSQL: string; out aTransactionID: TTransactionDesc; aSQLConnection: TSQLConnection = nil);
var
  newQryDBX: TSQLQuery;
begin
  if (UpperCase(LeftStr(aSQL,6)) = 'SELECT') and (Length(Trim(aSQL)) = 0) then
  begin
    Exit;
  end;

  newQryDBX := TSQLQuery.Create(nil);
  with newQryDBX do
  begin
    SQL.Clear;
    SQL.Add(aSQL);
    if aSQLConnection = nil then
    begin
      SQLConnection := conDBX;
      if not ConDBX.InTransaction then
      begin
        aTransactionID.TransactionID := aTransactionID.TransactionID + 1;
        aTransactionID.IsolationLevel := xilREADCOMMITTED;
        ConDBX.StartTransaction(aTransactionID);
      end;
    end else
    begin
      SQLConnection := aSQLConnection;
      if not aSQLConnection.InTransaction then
      begin
        aTransactionID.TransactionID := aTransactionID.TransactionID + 1;
        aTransactionID.IsolationLevel := xilREADCOMMITTED;
        aSQLConnection.StartTransaction(aTransactionID);
      end;
    end;

    try
      ExecSQL();
    except
      on E: Exception do
      begin
        FreeAndNil(newQryDBX);
        //xCloseConnection(aSQLConnection);
        raise Exception.Create(E.Message);
      end;
    end;
  end;
  FreeAndNil(newQryDBX);

end;

procedure xCommit(aSQLConnection: TSQLConnection = nil);
begin
  if aSQLConnection = nil then
  begin
    if conDBX.InTransaction then
    begin
      conDBX.Commit(transDBX);
      transDBX.TransactionID := 0;
    end;
  end else
  begin
    if aSQLConnection.InTransaction then
    begin
      aSQLConnection.Commit(transDBX);
      transDBX.TransactionID := 0;
    end;
  end;

end;

procedure xCommit(aTransactionID: TTransactionDesc; aSQLConnection: TSQLConnection = nil);
begin
  if aSQLConnection = nil then
  begin
    if conDBX.InTransaction then
    begin
      conDBX.Commit(aTransactionID);
      aTransactionID.TransactionID := 0;
    end;
  end else
  begin
    if aSQLConnection.InTransaction then
    begin
      aSQLConnection.Commit(aTransactionID);
      aTransactionID.TransactionID := 0;
    end;
  end;

end;

procedure xRollback(aSQLConnection: TSQLConnection = nil);
begin
  if aSQLConnection = nil then
  begin
    if conDBX.InTransaction then
    begin
      conDBX.Rollback(transDBX);
      transDBX.TransactionID := 0;
    end;
  end else
  begin
    if aSQLConnection.InTransaction then
    begin
      aSQLConnection.Rollback(transDBX);
      transDBX.TransactionID := 0;
    end;
  end;
end;

procedure xRollback(aTransactionID: TTransactionDesc; aSQLConnection: TSQLConnection = nil);
begin
  if aSQLConnection = nil then
  begin
    if conDBX.InTransaction then
    begin
      conDBX.Rollback(aTransactionID);
      aTransactionID.TransactionID := 0;
    end;
  end else
  begin
    if aSQLConnection.InTransaction then
    begin
      aSQLConnection.Rollback(aTransactionID);
      aTransactionID.TransactionID := 0;
    end;
  end;

end;

procedure TcxDBPivotHelper.ExportToXLS(ExpandAll: Boolean = True; sFileName:
    String = ''; DoShowInfo: Boolean = True);
var
  DoSave: Boolean;
  lSaveDlg: TSaveDialog;
begin
  DoSave := True;
  If sFileName = '' then
  begin
    lSaveDlg := TSaveDialog.Create(nil);
    Try
      if lSaveDlg.Execute then
        sFileName := lSaveDlg.FileName
      else
        DoSave := False;
    Finally
      lSaveDlg.Free;
    End;
  end;

  If DoSave then
  begin
    Try
      cxExportPivotGridToExcel(sFileName, Self, ExpandAll);
      If DoShowInfo then ShowMessage('Data berhasil diexport ke: ' + sFileName);
    except
      If DoShowInfo then ShowMessage('Gagal menyimpan data ke excel');
    end;
  end;
end;

procedure TcxDBPivotHelper.LoadFromCDS(ACDS: TClientDataSet; ExpandAll: Boolean
    = True; ReCreateAllItem: Boolean = True);
var
  i: Integer;
begin
  if not Assigned(Self.DataSource) then
    Self.DataSource := TDataSource.Create(Self);
  Self.DataSource.DataSet := ACDS;

  If ReCreateAllItem then
  begin
    Self.DeleteAllFields;
    Self.CreateAllFields;
  end;

  for i:=0 to Self.FieldCount-1 do
  begin
    if AnsiMatchStr(Self.Fields[i].DataBinding.ValueType ,['Float','Currency']) then
    begin
      Self.Fields[i].PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(Self.fields[i].Properties).DisplayFormat := ',0;(,0)';
      TcxCurrencyEditProperties(Self.fields[i].Properties).ReadOnly := True;
    end;
    If ExpandAll then Self.Fields[i].ExpandAll;
  end;
  SetAllUpperCaseColumn;
end;

procedure TcxDBPivotHelper.SetAllUpperCaseColumn;
var
  i: Integer;
begin
  for i := 0 to Self.FieldCount-1 do
  begin
    Self.Fields[i].Caption := UpperCase(Self.Fields[i].Caption);
  end;
end;

procedure TcxDBPivotHelper.SetColColumns(ColumnSets: Array Of String);
var
  i: Integer;
begin
  for i := Low(ColumnSets) to High(ColumnSets) do
  begin
    If Assigned(Self.GetFieldByName(ColumnSets[i])) then
      Self.GetFieldByName(ColumnSets[i]).Area := faColumn;
  end;
end;

procedure TcxDBPivotHelper.SetColumnsCaption(ColumnSets, ColumnCaption: Array
    Of String);
var
  i: Integer;
begin
  for i := Low(ColumnSets) to High(ColumnSets) do
  begin
    If Assigned(Self.GetFieldByName(ColumnSets[i])) then
      Self.GetFieldByName(ColumnSets[i]).Caption := ColumnCaption[i];
  end;
end;

procedure TcxDBPivotHelper.SetColumnsWidth(ColumnSets: Array Of String; Widths:
    Array Of Integer);
var
  i: Integer;
begin
  for i := Low(ColumnSets) to High(ColumnSets) do
  begin
    If Assigned(Self.GetFieldByName(ColumnSets[i])) then
      Self.GetFieldByName(ColumnSets[i]).Width := Widths[i];
  end;
end;

procedure TcxDBPivotHelper.SetDataColumns(ColumnSets: Array Of String);
var
  i: Integer;
begin
  for i := Low(ColumnSets) to High(ColumnSets) do
  begin
    If Assigned(Self.GetFieldByName(ColumnSets[i])) then
      Self.GetFieldByName(ColumnSets[i]).Area := faData;
  end;
end;

procedure TcxDBPivotHelper.SetRowColumns(ColumnSets: Array Of String);
var
  i: Integer;
begin
  for i := Low(ColumnSets) to High(ColumnSets) do
  begin
    If Assigned(Self.GetFieldByName(ColumnSets[i])) then
      Self.GetFieldByName(ColumnSets[i]).Area := faRow;
  end;
end;

procedure TcxDBPivotHelper.SetVisibleColumns(ColumnSets: Array Of String;
    IsVisible: Boolean);
var
  i: Integer;
begin
  for i := Low(ColumnSets) to High(ColumnSets) do
  begin
    If Assigned(Self.GetFieldByName(ColumnSets[i])) then
      Self.GetFieldByName(ColumnSets[i]).Hidden := not IsVisible;
  end;
end;






end.

