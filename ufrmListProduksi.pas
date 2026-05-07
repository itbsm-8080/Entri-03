unit ufrmListProduksi;

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
  dxPSEdgePatterns,  cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPScxPageControlProducer,
  dxPScxEditorProducers, dxPScxExtEditorProducers, dxPScxCommon, dxPSCore,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, dxPScxGrid6Lnk,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  MemDS, DBAccess, MyAccess;


type
  TfrmListProduksi = class(TForm)
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

  frmListProduksi: TfrmListProduksi;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport;
{$R *.dfm}



procedure TfrmListProduksi.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListProduksi.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListProduksi.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListProduksi.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListProduksi.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListProduksi.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListProduksi.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListProduksi.loaddata;
var
  skolom,s,smargin: string ;
  afilter : string ;
  i,jmlkolom:integer;
begin
  s := 'SELECT KORH_NOMOR Nomor, KORH_TANGGAL Tanggal, month(KORH_TANGGAL) Bulan,year(KORH_TANGGAL) Tahun, brg_nama Nama, gdg_jenis_barang Tipe, '
     + '    CASE '
     + '          WHEN kord_gdg_kode <> "GJ-01" '
     + '            THEN kord_qty * -1 '
     + '           ELSE kord_qty '
     + '       END AS Qty, KORD_HARGA Harga, '
     + '        CASE '
     + '            WHEN kord_gdg_kode <> "GJ-01" '
     + '            THEN KORD_NILAI * -1 '
     + '            ELSE KORD_NILAI '
     + '        END AS Nilai, '
     + '       korh_memo Keterangan '
     + '   FROM tkor_hdr '
     + '   INNER JOIN tkor_dtl ON KORH_NOMOR = KORD_KORH_NOMOR '
     + '   INNER JOIN tbarang ON brg_kode = KORD_BRG_KODE '
     + '   INNER JOIN tgudang ON gdg_kode  = kord_gdg_kode '
     + ' where KORH_TANGGAL between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
     + '   ORDER BY KORH_NOMOR ';
      ds3.Close;
      sqlqry1.Connection := frmmenu.conn;
      sqlqry1.SQL.Text := s;
      ds3.open;


       Skolom :='Nomor,Tanggal,Bulan,Tahun,Nama,Tipe, Qty, Harga, Nilai, Keterangan';
       QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);

       cxGrid1DBTableView1.Columns[0].MinWidth := 70;
       cxGrid1DBTableView1.Columns[1].MinWidth := 100;
       cxGrid1DBTableView1.Columns[2].MinWidth := 100;
       cxGrid1DBTableView1.Columns[3].MinWidth := 100;
       cxGrid1DBTableView1.Columns[4].MinWidth := 100;
       cxGrid1DBTableView1.Columns[5].MinWidth := 100;
       cxGrid1DBTableView1.Columns[6].MinWidth := 100;
       cxGrid1DBTableView1.Columns[7].MinWidth := 100;
        cxGrid1DBTableView1.Columns[8].MinWidth := 100;
         cxGrid1DBTableView1.Columns[9].MinWidth := 100;

           jmlkolom :=cxGrid1DBTableView1.ColumnCount-1;

        for i:=0 To jmlkolom do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;

        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';

        //  hitung;

       TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
       SetPivotColumns(['Bulan']);
       SetPivotRow (['Nama']);
       SetPivotData(['Qty']);

end;

procedure TfrmListProduksi.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListProduksi.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListProduksi.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListProduksi.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListProduksi.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListProduksi.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListProduksi.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListProduksi.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListProduksi.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListProduksi.cxButton3Click(Sender: TObject);
var
  s:string;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'kontrak';

          s:= ' SELECT fp_nomor Nomor,fp_tanggal Tanggal,month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,'
          + ' sls_nama Salesman,cus_nama Outlet,brg_kode Kode,brg_nama Nama,brg_merk Merk,KTG_NAMA KATEGORI,BRG_DIVISI Divisi, fpd_brg_satuan Satuan,fpd_cn ,'
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-ifnull(retjd_qty,0)))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) Nilai,'
          + ' sum(mst_stok_out*mst_hargabeli) hpp, '
          + ' sum((fpd_qty-ifnull(retjd_qty,0))) Qty,sum((100-fpd_discpr)*(fpd_harga*(fpd_qty-retjd_qty))/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) -'
          + ' sum(mst_stok_out*mst_hargabeli) Margin, '
          + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*(fpd_qty-retjd_qty)/100) Kontrak FROM tfp_dtl inner join'
          + ' tfp_hdr on fpd_fp_nomor=fp_nomor'
          + ' inner join tbarang on fpd_brg_kode=brg_kode'
          + ' inner join tcustomer on fp_cus_kode=cus_kode'
          + ' LEFT JOIN tretj_hdr on retj_fp_nomor=fp_nomor '
          + ' left join tretj_dtl on retjd_retj_nomor=retj_nomor '          
          + ' left join tdo_hdr on fp_do_nomor=do_nomor '
          + ' left join tso_hdr on do_so_nomor=so_nomor '
          + ' left join tmasterstok on mst_noreferensi=do_nomor and fpd_brg_kode=mst_brg_kode and fpd_expired=mst_expired_date '
          + ' left join tsalesman on sls_kode = so_sls_kode'
          + ' lEFT join tkategori on ktg_kode=brg_ktg_kode '
          + ' where fpd_cn > 0 and fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + 'group by  cus_nama ,brg_kode '
          + ' having ' + cxGrid1DBTableView1.DataController.Filter.FilterText ;
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;

end;

procedure TfrmListProduksi.cxButton1Click(Sender: TObject);
begin
  With cxPivot.GetFieldByName('Nama') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Qty')
    else
      SortBySummaryInfo.Field := nil;
  end;
end;

end.
