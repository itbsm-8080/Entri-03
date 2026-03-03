unit ufrmListIOS;

interface             

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SqlExpr,  cxGraphics,
  cxControls, dxStatusBar, te_controls, Menus, cxLookAndFeelPainters,
  cxButtons, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid ,
  Grids, BaseGrid, AdvGrid, AdvCGrid, ComCtrls, Mask, ImgList, FMTBcd,
  Provider, DB, DBClient, DBGrids, cxLookAndFeels, cxDBData,
  cxGridBandedTableView, cxGridDBTableView,
  cxGridChartView, cxCustomPivotGrid, cxDBPivotGrid, cxPC,
  cxPivotGridChartConnection, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPScxPageControlProducer,
  dxPScxEditorProducers, dxPScxExtEditorProducers, dxPScxCommon, dxPSCore,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, dxPScxGrid6Lnk,
  MemDS, DBAccess, MyAccess;

type
  TfrmListIOS = class(TForm)
    tscrlbx1: TTeScrollBox;
    TePanel4: TTePanel;
    ilMenu: TImageList;
    TePanel1: TTePanel;
    ilToolbar: TImageList;
    TePanel2: TTePanel;
    TeLabel1: TTeLabel;
    SaveDialog1: TSaveDialog;
    TePanel3: TTePanel;
    dtstprvdr1: TDataSetProvider;
    sqlqry2: TSQLQuery;
    ds2: TDataSource;
    ds3: TClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxstyl1: TcxStyle;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cxChart: TcxGrid;
    cxGrdChart: TcxGridChartView;
    lvlChart: TcxGridLevel;
    cxPivot: TcxDBPivotGrid;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    cxGrid11Level1: TcxGridLevel;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cxButton3: TcxButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    PopupMenu1: TPopupMenu;
    LihatFakturPenjualan1: TMenuItem;
    cxButton1: TcxButton;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxPageControl1Click(Sender: TObject);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure dttanggalChange(Sender: TObject);
    procedure TeSpeedButton2Click(Sender: TObject);
    procedure SetPivotColumns(ColumnSets: Array Of String);
    procedure SetPivotData(ColumnSets: Array Of String);
    procedure SetPivotRow(ColumnSets: Array Of String);
    procedure cxButton3Click(Sender: TObject);
    procedure cxGrid1DBTableView1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure LihatFakturPenjualan1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);

  private
    flagedit : Boolean;
    fid : integer;
    fnomorjual : string ;
    FPivotChartLink: TcxPivotGridChartConnection;
    xtotal,xhpp : Double;
    iskupon : Integer;
    ntotalpremium , ntotalsolar , ntotalpertamax, ntotalpertamaxplus , ntotalpenjualan : double;
    ntotaljpremium , ntotaljsolar , ntotaljpertamax, ntotaljpertamaxplus  : double;
    ntotalbayar : double;
    xhppPremium,xhppsolar,xhpppertamaxplus,xhpppertamax : double ;
    function GetPivotChartLink: TcxPivotGridChartConnection;
  public

    procedure loaddata;
    procedure refreshdata;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmListIOS: TfrmListIOS;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport,ufrmInvoice;
{$R *.dfm}



procedure TfrmListIOS.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListIOS.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListIOS.refreshdata;
begin
  startdate.DateTime := Date;
  enddate.DateTime := Date ;
  startdate.setfocus;

end;

procedure TfrmListIOS.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListIOS.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListIOS.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListIOS.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListIOS.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
begin

      s:= ' select Nomor,Tanggal,JthTempo,Kode,Supplier,Tax,'
           + ' NoBukti,Total,ifnull(retur,0) Retur,ifnull(bayar,0) Bayar,Sisa_Hutang-ifnull(retur,0) Sisa_Hutang,'
           + ' Range_overdue,Overdue from '
           + ' (select *,(case when overdue < 0 then " Belum" when overdue >= 0  and overdue <=30  then "0 sd 30" '
           + ' when overdue >= 31  and overdue <=60 then "31 s/d 60"  when overdue >= 61  and overdue <=90 then "61 s/d 90" '
           + ' when overdue >= 91  and overdue <=120 then "91 s/d 120" else "x > 120" end ) Range_overdue   from ( '
           + ' select inv_Nomor Nomor,inv_tanggal Tanggal,inv_jthtempo JthTempo,if(inv_istax=1,"PPN","Non PPN") Tax ,inv_sup_kode Kode,sup_nama Supplier,'
           + ' inv_nobukti NoBukti,inv_amount Total,inv_bayar Bayar,inv_amount-inv_bayar Sisa_Hutang, '
           + ' (select sum(ret_amount) from tret_hdr where ret_inv_nomor =z.inv_nomor) Retur, '
           + ' datediff('+quotd(startdate.date)+',inv_jthtempo) Overdue'
           + ' from tinv_hdr z'
           + ' inner join tsupplier on inv_sup_kode=sup_kode  '
           + ' and  (inv_amount-inv_bayar) > 1 ) final) final2'
           + ' where Sisa_Hutang-ifnull(retur,0) > 0 and tanggal <= '+quotd(enddate.DateTime);


  ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Nomor,Tanggal,JthTempo,Supplier,Tax,Nobukti,Total,Bayar,Retur,Sisa_Hutang,Overdue,Range_Overdue';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 60;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           cxGrid1DBTableView1.Columns[7].MinWidth := 100;
           cxGrid1DBTableView1.Columns[8].MinWidth := 100;
           cxGrid1DBTableView1.Columns[9].MinWidth := 100;
        for i:=0 To cxGrid1DBTableView1.ColumnCount -1 do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;

        cxGrid1DBTableView1.Columns[6].Summary.groupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.groupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[8].Summary.groupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.groupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.groupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.groupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[9].Summary.groupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.groupFooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[9].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.FooterFormat:='###,###,###,###';


//  hitung;

          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Range_Overdue']);
           SetPivotRow (['Supplier']);
           SetPivotData(['Sisa_Hutang']);

end;

procedure TfrmListIOS.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListIOS.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListIOS.TeSpeedButton1Click(Sender: TObject);
begin

  IF PageControl1.Pages[1].Visible  then
     TcxDBPivotHelper(cxPivot).ExportToXLS
  else
  begin
     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;
 end;


end;


procedure TfrmListIOS.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListIOS.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListIOS.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListIOS.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListIOS.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListIOS.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListIOS.cxButton3Click(Sender: TObject);



  var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'IOS';

          s:= ' select ' + quot(cxGrid1DBTableView1.DataController.Filter.FilterText) + ' as filter, '
          + Quot(FormatDateTime('dd/mm/yyyy',enddate.DateTime)) + ' as tgl , '
        + ' *,(case when overdue < 0 then " Belum" when overdue >= 0  and overdue <=30  then "0 sd 30" '
           + ' when overdue >= 31  and overdue <=60 then "31 s/d 60"  when overdue >= 61  and overdue <=90 then "61 s/d 90" '
           + ' when overdue >= 91  and overdue <=120 then "91 s/d 120" else "x > 120" end ) Range_overdue   from ( '
           + ' select inv_Nomor Nomor,inv_tanggal Tanggal,inv_jthtempo JthTempo,inv_sup_kode Kode,sup_nama Supplier,'
           + ' inv_nobukti NoBukti,inv_amount Total,inv_amount-inv_bayar Sisa_Hutang,datediff('+quotd(startdate.date)+',inv_jthtempo) Overdue'
           + ' from tinv_hdr'
           + ' inner join tsupplier on inv_sup_kode=sup_kode'
           + ' and  (inv_amount-inv_bayar) > 1 ) where tanggal <= '+quotd(enddate.DateTime)+'  final' ;

    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;



procedure TfrmListIOS.cxGrid1DBTableView1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Overdue');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) > 0) then
    AStyle := cxStyle2;
end;

procedure TfrmListIOS.LihatFakturPenjualan1Click(Sender: TObject);
var
  frmInvoice: TfrmInvoice;
begin
  inherited;
  If ds3.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Invoice' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmInvoice  := frmmenu.ShowForm(TfrmInvoice) as TfrmInvoice;
      frmInvoice.ID := ds3.FieldByname('Nomor').AsString;
      frmInvoice.FLAGEDIT := True;
      frmInvoice.edtnOMOR.Text := ds3.FieldByname('Nomor').AsString;
      frmInvoice.loaddataall(ds3.FieldByname('Nomor').AsString);

   end;
   frmInvoice.Show;
end;
procedure TfrmListIOS.cxButton1Click(Sender: TObject);
begin
With cxPivot.GetFieldByName('Supplier') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Sisa_Hutang')
    else
      SortBySummaryInfo.Field := nil;
  end;

end;

end.
