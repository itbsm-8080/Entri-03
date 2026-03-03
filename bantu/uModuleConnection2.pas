unit uModuleConnection;

interface

uses
  SysUtils, StrUtils, Classes, DBXpress, FMTBcd, DB, SqlExpr;

type
  TConnectionType = (ctInterbase, ctMSSQL, ctMySQL, ctOracle);

var
  conDBX: TSQLConnection;
  transDBX: TTransactionDesc;

  


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






end.

