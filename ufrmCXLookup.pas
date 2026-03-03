unit ufrmCXLookup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Menus, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, StdCtrls,
  cxButtons, cxGroupBox, DBClient, uModuleConnection, cxCheckBox, cxCurrencyEdit,
  cxGridDBDataDefinitions, cxMemo, cxTL, cxTLdxBarBuiltInMenu,
  cxInplaceContainer, cxTLData, cxDBTL, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter;

type
  TfrmCXLookup = class(TForm)
    pnPeriode: TcxGroupBox;
    btnRefresh: TcxButton;
    cxLabel1: TcxLabel;
    StartDate: TcxDateEdit;
    EndDate: TcxDateEdit;
    cxLabel2: TcxLabel;
    sdBoxButton: TcxGroupBox;
    btnOK: TcxButton;
    btnTutup: TcxButton;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    pmSelect: TPopupMenu;
    CheckSelected1: TMenuItem;
    UnCheckSelected1: TMenuItem;
    N1: TMenuItem;
    CheckAll1: TMenuItem;
    UncheckAll1: TMenuItem;
    cxBrowseStyle: TcxStyleRepository;
    styleRowMoney: TcxStyle;
    styleInfoBlk: TcxStyle;
    styleSkyBlue: TcxStyle;
    styleSilver: TcxStyle;
    cxMemoGrid: TcxMemo;
    cxTreeData: TcxDBTreeList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTutupClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure CheckAll1Click(Sender: TObject);
    procedure CheckSelected1Click(Sender: TObject);
    procedure cxGrdMainCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo:
        TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
        var AHandled: Boolean);
    procedure UncheckAll1Click(Sender: TObject);
    procedure UnCheckSelected1Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cxGrdMainKeyPress(Sender: TObject; var Key: Char);
    procedure cxTreeDataCollapsed(Sender: TcxCustomTreeList; ANode:
        TcxTreeListNode);
    procedure cxTreeDataExpanded(Sender: TcxCustomTreeList; ANode: TcxTreeListNode);
  private
    FCDS: TClientDataset;
    FResultData: TClientDataset;
    FDCMain: TcxGridDBDataController;
    FMultiSelect: Boolean;
    FPrefixSQL: string;
    FSQLWithParam: String;
    FTreeViewMode: Boolean;
    function GetDCMain: TcxGridDBDataController;
    function ProcessSQL(ASQL: String): String;
    procedure RefreshDataSet;
    procedure SetCheckSelected(IsChecked: Boolean = True; IsSelectAll: Boolean =
        False);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetResultSet;
    procedure SetTreeViewMode(const Value: Boolean);
    procedure WriteToGrid;
    { Private declarations }
  public
    procedure HideColumn(ACols: Array Of String);
    class function LookupData(ACaption, ASQL: String; InitStartDate: TDateTime = 0;
        InitEndDate: TDateTime = 0; DoMultiSelect: Boolean = True; sPrefixSQL:
        string = ''): TfrmCXLookup; overload;
    class function LookupData(ASQL: String): TfrmCXLookup; overload;
    class function LookupData(ASQL, TreeKey, ParentKey: String): TfrmCXLookup;
        overload;
    class function LookupData(ASQL: String; DoMultiSelect: Boolean): TfrmCXLookup;
        overload;
    procedure RefreshData;
    property CDS: TClientDataset read FCDS write FCDS;
    property ResultData: TClientDataset read FResultData write FResultData;
    property DCMain: TcxGridDBDataController read GetDCMain write FDCMain;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect;
    property PrefixSQL: string read FPrefixSQL write FPrefixSQL;
    property SQLWithParam: String read FSQLWithParam write FSQLWithParam;
    property TreeViewMode: Boolean read FTreeViewMode write SetTreeViewMode;
    { Public declarations }
  end;

var
  frmCXLookup: TfrmCXLookup;

const
  check_flag : String = 'check_flag';

implementation

uses DateUtils,  Provider;

{$R *.dfm}

procedure TfrmCXLookup.FormCreate(Sender: TObject);
begin
  Self.TreeViewMode := False;
  cxGrid.Align      := alClient;
  cxTreeData.Align  := alClient;
end;

procedure TfrmCXLookup.btnOKClick(Sender: TObject);
begin
  SetResultSet;
end;

procedure TfrmCXLookup.btnRefreshClick(Sender: TObject);
begin
  RefreshData;
end;

procedure TfrmCXLookup.btnTutupClick(Sender: TObject);
begin
  inherited;
  Self.close;
end;

procedure TfrmCXLookup.CheckAll1Click(Sender: TObject);
begin
  SetCheckSelected(True, True);
end;

procedure TfrmCXLookup.CheckSelected1Click(Sender: TObject);
begin
  SetCheckSelected(True);
end;

procedure TfrmCXLookup.cxGrdMainCellDblClick(Sender: TcxCustomGridTableView;
    ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift:
    TShiftState; var AHandled: Boolean);
begin
  If not Self.MultiSelect then
  begin
    btnOK.Click;
  end else
  begin
    CDS.Edit;
    CDS.FieldByName(check_flag).AsBoolean := not CDS.FieldByName(check_flag).AsBoolean;
    CDS.Post;
  end;
end;

procedure TfrmCXLookup.cxGrdMainKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
    btnOK.Click;
end;

procedure TfrmCXLookup.cxTreeDataCollapsed(Sender: TcxCustomTreeList; ANode:
    TcxTreeListNode);
begin
  cxTreeData.ApplyBestFit;
end;

procedure TfrmCXLookup.cxTreeDataExpanded(Sender: TcxCustomTreeList; ANode:
    TcxTreeListNode);
begin
  cxTreeData.ApplyBestFit;
end;

procedure TfrmCXLookup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(ResultData) then
    ResultData.Free;
end;

function TfrmCXLookup.GetDCMain: TcxGridDBDataController;
begin
  Result := cxGrdMain.DataController;
end;

procedure TfrmCXLookup.HideColumn(ACols: Array Of String);
begin
  If not TreeViewMode then
    TcxDBGridHelper(Self.cxGrdMain).SetVisibleColumns(ACols, False)
  else
    TcxDBTreeHelper(Self.cxTreeData).SetVisibleColumns(ACols, False);
end;

class function TfrmCXLookup.LookupData(ACaption, ASQL: String; InitStartDate:
    TDateTime = 0; InitEndDate: TDateTime = 0; DoMultiSelect: Boolean = True;
    sPrefixSQL: string = ''): TfrmCXLookup;
begin
  Result := TfrmCXLookup.Create(nil);
  Result.PrefixSQL := sPrefixSQL;
  //utk awalan query spt declare variable , dsb

  If ACaption='' then ACaption := 'Lookup Data';
  Result.Caption := ACaption;

  If (InitStartDate=0) and (InitEndDate=0) then
    Result.pnPeriode.Visible := False;

  If InitStartDate = 0 then InitStartDate := StartOfTheMonth(now());
  If InitEndDate = 0 then InitEndDate := EndOfTheMonth(now());

  Result.StartDate.Date := InitStartDate;
  Result.EndDate.Date := InitEndDate;

  Result.SQLWithParam := ASQL;
  Result.RefreshData;

  Result.MultiSelect := DoMultiSelect;
end;

class function TfrmCXLookup.LookupData(ASQL: String): TfrmCXLookup;
begin
  Result := TfrmCXLookup.LookupData('Lookup Data',ASQL, 0,0, False);
end;

class function TfrmCXLookup.LookupData(ASQL, TreeKey, ParentKey: String):
    TfrmCXLookup;
var
  ACaption: string;
  i: Integer;
begin
  If ACaption='' then ACaption := 'Lookup Data';

  Result                    := TfrmCXLookup.Create(nil);
  Result.TreeViewMode       := True;
  Result.Caption            := ACaption;
  Result.pnPeriode.Visible  := False;
  Result.SQLWithParam       := ASQL;

  cShowWaitWindow();
  Application.ProcessMessages;
  Try
    Result.RefreshDataSet;
    Result.CDS.First;
    TcxDBTreeHelper(Result.cxTreeData).LoadFromCDS(
      Result.CDS, TreeKey, ParentKey, True);

    Result.MultiSelect  := False;
    for i:=1 to Result.cxTreeData.ColumnCount-1 do
    begin
//      Result.cxTreeData.Columns[i].Properties.ReadOnly  := True;
      Result.cxTreeData.Columns[i].Options.Editing      := False;
      Result.cxTreeData.Columns[i].Caption.Text         := UpperCase(Result.cxTreeData.Columns[i].Caption.Text);
      Result.cxTreeData.Columns[i].Options.Editing      := False;
      If Result.cxTreeData.Columns[i].PropertiesClass = TcxCurrencyEditProperties then
      begin
        TcxCurrencyEditProperties( Result.cxTreeData.Columns[i].Properties).DisplayFormat := ',0.00;(,0.00)';
        TcxCurrencyEditProperties( Result.cxTreeData.Columns[i].Properties).Alignment.Horz := taRightJustify;
      end;
    end;
  Finally
    cCloseWaitWindow;
  end;
end;

class function TfrmCXLookup.LookupData(ASQL: String; DoMultiSelect: Boolean):
    TfrmCXLookup;
begin
  Result := TfrmCXLookup.LookupData('Lookup Data',ASQL, 0,0, DoMultiSelect);
end;

function TfrmCXLookup.ProcessSQL(ASQL: String): String;
var
  iPos: Integer;
  iPos2: Integer;
begin
  iPos := Pos('SELECT DISTINCT', Uppercase(aSQL) );
  iPos2 := Pos('SELECT', Uppercase(aSQL) );

  if (iPos > 0) and (iPos=iPos2) then //hanya berlaku utk karakter pertama, contoh ada subquery
  begin
    aSQL := Copy(aSQL, Length('SELECT DISTINCT') + iPos , Length(aSQL));
    aSQL := 'SELECT DISTINCT CAST(0 as Bit) as ' + check_flag  +',' + Asql;
  end else
  begin
    iPos := Pos('SELECT', Uppercase(aSQL) );
    if iPos >0 then
    begin
      aSQL := Copy(aSQL, Length('SELECT') + iPos , Length(aSQL));
      aSQL := 'SELECT CAST(0 as Bit) as ' + check_flag  +',' + Asql;
    end;
  end;
  Result :=  aSQL;
end;

procedure TfrmCXLookup.RefreshData;
begin
  cShowWaitWindow();
  Application.ProcessMessages;
  Try
    RefreshDataSet;
    WriteToGrid;
  Finally
    cCloseWaitWindow;
  end;
end;

procedure TfrmCXLookup.RefreshDataSet;
var
  LDSP: TDataSetProvider;
  LSQLQuery: TADQuery;
begin
  If SQLWithParam = '' then exit;

  CDS := TClientDataSet.Create(Self);
  LDSP := TDataSetProvider.Create(CDS);
  LSQLQuery := TADQuery.Create(LDSP);

  try
    LSQLQuery.Connection := cADConnection;
    If PrefixSQL<>'' then lSQLQuery.SQL.Append(PrefixSQL);
    LSQLQuery.SQL.Append(ProcessSQL(SQLWithParam));
    If LSQLQuery.Params.Count > 1 then
    begin
      LSQLQuery.Params[0].AsDateTime := StartDate.Date;
      LSQLQuery.Params[1].AsDateTime := EndDate.Date;
    end;

    cSetFDQueryProperty(LSQLQuery);

    LDSP.DataSet := LSQLQuery;
    CDS.SetProvider(LDSP);
    CDS.Open;
  except
    on E: Exception do
      begin
        MessageDlg('Open ClientDataset Failed. Check your Query!' + #13 +
          E.Message, mtError, [mbOK], 0);
      end;
  end;
end;

procedure TfrmCXLookup.SetCheckSelected(IsChecked: Boolean = True; IsSelectAll:
    Boolean = False);
var
  i: Integer;
begin
  cxGrdMain.DataController.BeginUpdate;
  Try
    If not Assigned(cxGrdMain.GetColumnByFieldName(check_flag)) then exit;
    If IsSelectAll then DCMain.SelectAll;
    for i := 0 to cxGrdMain.Controller.SelectedRecordCount-1 do
    begin
      cxGrdMain.Controller.SelectedRecords[i].Focused := True;
      With cxGrdMain.DataController.DataSource.DataSet do
      begin
        Edit;
        FieldByName(check_flag).AsBoolean := IsChecked;
        Post;
      end;
    end;
  Finally
    cxGrdMain.DataController.EndUpdate;
  End;
end;

procedure TfrmCXLookup.SetMultiSelect(const Value: Boolean);
begin
  FMultiSelect := Value;

  If not FMultiSelect then
  begin
    Self.cxGrid.PopupMenu := nil;
    If not TreeViewMode then
      TcxDBGridHelper(Self.cxGrdMain).SetVisibleColumns([check_flag], False)
    else
      TcxDBTreeHelper(Self.cxTreeData).SetVisibleColumns([check_flag], False);
  end;
  Self.cxGrdMain.OptionsSelection.MultiSelect := FMultiSelect;
end;

procedure TfrmCXLookup.SetResultSet;
begin
  CDS.DisableControls;

  If not Self.MultiSelect then
  begin
    CDS.Edit;
    CDS.FieldByName(check_flag).AsBoolean := True;
    CDS.Post;
  end;

  Try
    If Assigned(FResultData) then FResultData.Free;
//    FResultData := TClientDataSet.Create(nil);

//    FResultData.CloneCursor(CDS, True);
//
//    FResultData.Last;
//    while not FResultData.Bof do
//    begin
//      if FResultData.FieldByName(check_flag).AsBoolean = False then
//        FResultData.Delete
//      else
//        FResultData.Prior;
//    end;

    //[fma] optimize performance 7/20/2016
    CDS.First;
    CDS.Filtered  := True;
    CDS.Filter    := check_flag + ' = True';
    FResultData   := TCDS.CopyDataset(CDS);
  Finally
    CDS.EnableControls;
  End;
end;

procedure TfrmCXLookup.SetTreeViewMode(const Value: Boolean);
begin
  FTreeViewMode       := Value;
  cxTreeData.Visible  := Value;
  cxGrid.Visible      := not Value;
  cxMemoGrid.Visible  := not Value;
end;

procedure TfrmCXLookup.UncheckAll1Click(Sender: TObject);
begin
  SetCheckSelected(False, True);
end;

procedure TfrmCXLookup.UnCheckSelected1Click(Sender: TObject);
begin
  SetCheckSelected(False);
end;

procedure TfrmCXLookup.WriteToGrid;
var
  i: Integer;
begin
  If not Assigned(cxGrdMain.DataController.DataSource) then
  begin
    cxGrdMain.DataController.DataSource := TDataSource.Create(Self);
  end;
  cxGrdMain.DataController.DataSource.DataSet := CDS;
  cxGrdMain.DataController.CreateAllItems(True);

  for i := 0 to CDS.FieldCount-1 do
  begin
    If not Assigned(cxGrdMain.GetColumnByFieldName(CDS.Fields[i].FieldName)) then
      continue;
    with cxGrdMain.GetColumnByFieldName(CDS.Fields[i].FieldName) do
    begin
      If CDS.Fields[i].DataType = ftFloat then
        PropertiesClassName := 'TcxCurrencyEditProperties';
      DataBinding.ValueType := 'Float';
    end;
  end;

  for i:=0 to cxGrdMain.ColumnCount-1 do
  begin
    cxGrdMain.Columns[i].Caption := UpperCase(cxGrdMain.Columns[i].Caption);
    if cxGrdMain.Columns[i].DataBinding.FieldName = check_flag then continue;
    cxGrdMain.Columns[i].Options.Editing := False;
    If cxGrdMain.Columns[i].PropertiesClass = TcxCurrencyEditProperties then
    begin
      TcxCurrencyEditProperties( cxGrdMain.Columns[i].Properties).DisplayFormat := ',0.00;(,0.00)';
      TcxCurrencyEditProperties( cxGrdMain.Columns[i].Properties).Alignment.Horz := taRightJustify;
    end;
    If Assigned(cxGrdMain.Columns[i].Properties) then cxGrdMain.Columns[i].Properties.ReadOnly := True;
  end;
  cxGrdMain.OptionsBehavior.BestFitMaxRecordCount := 200;
  cxGrdMain.ApplyBestFit;

  with cxGrdMain.GetColumnByFieldName(check_flag) do
  begin
    PropertiesClassName := 'TcxCheckBoxProperties';
    HeaderAlignmentHorz := taCenter;
    Width := 20;
    Caption := 'V';
    Index := 0;
    TcxCheckBoxProperties(Properties).ImmediatePost := True;
  end;

end;

end.
