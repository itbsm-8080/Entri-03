unit ufrmCxBrowse;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ComCtrls, ExtCtrls, Shader, ImgList, DBClient,
  cxCustomPivotGrid, cxPivotGrid, 
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, Menus, FMTBcd, Provider, SqlExpr,
  StdCtrls, cxButtons, AdvPanel,
  cxCurrencyEdit,ExcelXP,ComObj, dxGDIPlusClasses, cxContainer, cxImage ;

type
  TfrmCxBrowse = class(TForm)
    AdvPanel1: TAdvPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    cxButton7: TcxButton;
    AdvPanel2: TAdvPanel;
    btnRefresh: TcxButton;
    Label1: TLabel;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    savedlg: TSaveDialog;
    SQLQuery1: TSQLQuery;
    ldsp: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    cxButton6: TcxButton;
    cxButton8: TcxButton;
    AdvPanel3: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMaster: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lvDetail: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure RefreshData;
    procedure WriteMasterDetailGrid;
//    function cOpenCDS(AQuery: string):
//    TClientDataSet;
    procedure btnRefreshClick(Sender: TObject);
    procedure cxButton6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RefreshDataSet;
    procedure cxButton8Click(Sender: TObject);
  private
    FCDSDetail: TClientDataset;
    FCDSMaster: TClientDataset;
    FDetailKeyField: String;
    FMasterKeyField: String;
    FSQLDetail: String;
    FSQLMaster: String;
    { Private declarations }
  public
    property CDSDetail: TClientDataset read FCDSDetail write FCDSDetail;
    property CDSMaster: TClientDataset read FCDSMaster write FCDSMaster;
    property DetailKeyField: String read FDetailKeyField write FDetailKeyField;
    property MasterKeyField: String read FMasterKeyField write FMasterKeyField;
    property SQLDetail: String read FSQLDetail write FSQLDetail;
    property SQLMaster: String read FSQLMaster write FSQLMaster;
    { Public declarations }
  end;

var
  frmCxBrowse: TfrmCxBrowse;

implementation
  uses cxGridExportLink,MAIN,Ulib;
{$R *.dfm}

procedure TfrmCxBrowse.FormShow(Sender: TObject);
begin

  StartDate.DateTime := StrToDate(FormatDateTime('mm',Now)+'/01/'+FormatDateTime('yyyy',Now));
  EndDate.DateTime := Date;

end;

procedure TfrmCxBrowse.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,false,True,True);

  cxGrdMaster.DataController.CollapseDetails;
end;

procedure TfrmCxBrowse.btnRefreshClick(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmCxBrowse.cxButton6Click(Sender: TObject);
var
  Save_Cursor:TCursor;
  XLApp: Variant;
  Sheet: Variant;
  i,acol, iCol,jRow : Integer;
  v   : Variant;
  S:string;

begin
  acol:=0;
   Save_Cursor := Screen.Cursor;
   Screen.Cursor := crHourglass;
   try
      XLApp := CreateOLEObject('Excel.Application');
      XLApp.Visible := True;
      XLApp.Workbooks.Add[XLWBatWorksheet];
      XLApp.Workbooks[1].Worksheets[1].Name := 'Sheet1';
      Sheet := XLApp.Workbooks[1].Worksheets['Sheet1'];
      jRow := 1;
         Sheet.Cells[1,1] := Self.Caption;
         Sheet.Cells[2,1] := 'Tanggal     :' + FormatDateTime('dd/mm/yyyy',startdate.DateTime) + ' s.d ' + FormatDateTime('dd/mm/yyyy',enddate.DateTime);

         for i:=0 to CDSMaster.FieldList.Count-1 do
         begin
            Sheet.Cells[3,i+1] := CDSMaster.FieldList.Fields[i].FieldName;
         end;
         for i:=CDSMaster.FieldList.Count to CDSMaster.FieldList.Count+CDSDetail.FieldList.Count-1 do
         begin
            Sheet.Cells[3,i+1] := CDSDetail.FieldList.Fields[i-CDSMaster.FieldList.Count].FieldName;
         end;
      CDSMaster.Filter := cxGrdMaster.DataController.Filter.FilterText;
      CDSMaster.Filtered := True;

      CDSMaster.First;
      jRow:=3;
      Inc(jRow);
      while not CDSMaster.EOF do
      begin
         for iCol := 1 to CDSMaster.FieldCount do
         begin
            v := CDSMaster.Fields[iCol-1].Text;
            Sheet.Cells[jRow, iCol] := v;
         end;
       CDSDetail.Filter := MasterKeyField + '= ' +  Quot(CDSMaster.Fields[0].AsString) ;
       CDSDetail.Filtered := True;
       while not CDSDetail.EOF do
       begin

         for aCol := CDSMaster.FieldCount+1 to CDSMaster.FieldCount+CDSDetail.FieldCount do
         begin
            v := CDSDetail.Fields[aCol-1-CDSMaster.FieldCount].Text;
            Sheet.Cells[jRow, aCol] := v;
         end;


         Inc(jRow);  // move the next row on the sheet and the dataset
           CDSDetail.Next;
       END;
              CDSDetail.Filtered := False;
         CDSMaster.Next;
      end;
      if acol =0 then
         acol :=i;
            Sheet.Range[Sheet.cells[3,1],Sheet.cells[jrow-1,acol-1]].Borders.Weight := 2;
       for i := 1 to acol do
         XLApp.Workbooks[1].WorkSheets['Sheet1'].Columns[i].EntireColumn.Autofit;
   finally
      Screen.Cursor := Save_Cursor;
   end;
end;


procedure TfrmCXBrowse.RefreshDataSet;
begin
  If SQLMaster <> '' then
     CDSMaster := cOpenCDS(SQLMaster,Self);
  If SQLDetail <> '' then
    CDSDetail := cOpenCDS(SQLDetail,Self);
end;

procedure TfrmCXBrowse.RefreshData;
begin
//  cShowWaitWindow();
  Application.ProcessMessages;
  Try
    RefreshDataSet;
    WriteMasterDetailGrid;
  Finally
//    cCloseWaitWindow;
  end;
end;

procedure TfrmCXBrowse.WriteMasterDetailGrid;
var //i:Integer;
  lvl:TcxGridLevel;
  i : integer;
begin
  cxGrid.RootLevelOptions.DetailTabsPosition := dtpNone;
  lvl := cxGrid.Levels.Add;
  LvMaster.Options.DetailTabsPosition := dtpTop;

  lvl.GridView := cxGrdDetail;
  lvDetail.GridView := nil;

  Try
    If not Assigned(cxGrdmaster.DataController.DataSource) then
    begin
      cxGrdmaster.DataController.DataSource := TDataSource.Create(Self);
    end;
    cxGrdmaster.DataController.DataSource.DataSet := CDSMaster;
    cxGrdmaster.DataController.KeyFieldNames      := MasterKeyField ;
    cxGrdmaster.DataController.CreateAllItems(True);

    If not Assigned(cxGrdDetail.DataController.DataSource) then
    begin
      cxGrdDetail.DataController.DataSource := TDataSource.Create(Self);
    end;
    cxGrdDetail.DataController.DataSource.DataSet := CDSDetail;
    cxGrdDetail.DataController.MasterKeyFieldNames := MasterKeyField;
    cxGrdDetail.DataController.DetailKeyFieldNames := MasterKeyField;
    cxGrdDetail.DataController.CreateAllItems(True);

    lvDetail.GridView := cxGrdDetail;
       for i:=0 to cxGrdMaster.ColumnCount-1 do
  begin
    if (cxGrdMaster.Columns[i].DataBinding.ValueType = 'Float')
    or (cxGrdMaster.Columns[i].DataBinding.ValueType = 'Currency')
    then
    begin
      cxGrdMaster.Columns[i].PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(cxGrdMaster.Columns[i].Properties).DisplayFormat := ',0.00;(,0.00)'
    end;
  end;
  for i:=0 to cxGrdDetail.ColumnCount-1 do
  begin
    if (cxGrdDetail.Columns[i].DataBinding.ValueType = 'Float')
    or (cxGrdDetail.Columns[i].DataBinding.ValueType = 'Currency')
    then
    begin
      cxGrdDetail.Columns[i].PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(cxGrdDetail.Columns[i].Properties).DisplayFormat := ',0.00;(,0.00)'
    end;
  end;
  Finally
    lvl.Free;
    //cxGrid.RootLevelOptions.DetailTabsPosition := dtptop;
  end;

  If not Assigned(CDSDetail) then lvDetail.Visible := False;
end;

//function TfrmCXBrowse.cOpenCDS(AQuery: string):TClientDataSet;
//begin
//
//  try
//    ClientDataSet1.Close;
//    SQLQuery1.SQLConnection := frmMenu.conn;
//    SQLQuery1.SQL.Append(aQuery);
//
//    ldsp.DataSet            := SQLQuery1;
//    ClientDataSet1.SetProvider(ldsp);
//    ClientDataSet1.Open;
//  except
//    on E: Exception do
//    begin
//      MessageDlg('Open ClientDataset Failed. Check your Query!' + #13 + E.Message, mtError, [mbOK], 0);
//    end;
//  end;
//    Result      := ClientDataSet1;
//end;

procedure TfrmCxBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     action := caFree;
end;



procedure TfrmCxBrowse.cxButton8Click(Sender: TObject);
begin
  close;
end;


end.

