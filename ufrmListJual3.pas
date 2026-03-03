unit ufrmListJual3;

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
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, MemDS, DBAccess, MyAccess;

type
  TfrmListJual3 = class(TForm)
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
    Label3: TLabel;
    Label4: TLabel;
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
    procedure cxGrid1DBTableView1DataControllerFilterChanged(
      Sender: TObject);
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

  frmListJual3: TfrmListJual3;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmListJual3.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListJual3.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListJual3.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListJual3.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListJual3.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListJual3.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListJual3.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListJual3.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
begin

        s:= ' select Salesman,Customer,Golongan,month(tanggal) Bulan,year(tanggal) Tahun,sum(Total) Total,sum(ifnull(Retur,0)) Retur,sum(IFNULL(CN,0)) Kontrak,sum(ifnull(Biaya_Promosi,0)) Biaya_promosi,'
        + ' SUM(Total-IFNULL(CN,0)-IFNULL(biaya_promosi,0)-ifnull(Retur,0)) Riil'
        + '  from ( '
        + ' select fp_nomor Nomor,fp_tanggal Tanggal ,fp_jthtempo JthTempo, fp_Memo Memo ,'
        + ' sls_nama Salesman,cus_nama  Customer, gc_nama Golongan, sum(fp_amount) Total,'
        + ' sum(fp_cn) CN,sum(fp_DP) DP,sum(fp_bayar) Bayar,'
        + ' sum(((fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp)) Biaya_Promosi,'
        + ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor=z.fp_nomor  ) Retur '
        + ' from tfp_hdr z inner join tcustomer on cus_kode=fp_cus_kode '
        + ' left join tgolongancustomer on gc_kode=cus_gc_kode '
        + ' left join tdo_hdr on fp_do_nomor=do_nomor  left join tso_hdr on do_so_nomor=so_nomor'
        + ' left JOIN Tsalesman on sls_kode=so_sls_kode'
        + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)

        + ' group by fp_nomor '
        + ' )  a group by year(tanggal),month(tanggal) ,Customer  order by Riil';
  ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;


        Skolom :='Salesman,Customer,Golongan,Bulan,Tahun,Total,Retur,Kontrak,Biaya_promosi,Riil';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 100;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           cxGrid1DBTableView1.Columns[7].MinWidth := 100;

        for i:=0 To cxGrid1DBTableView1.ColumnCount -1 do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;
        cxGrid1DBTableView1.Columns[1].Summary.GroupFooterKind:=skCount;
        cxGrid1DBTableView1.Columns[1].Summary.GroupFooterFormat:='####';
        cxGrid1DBTableView1.Columns[9].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.GroupFooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[8].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[5].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[5].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[6].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[9].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[5].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[5].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.FooterFormat:='###,###,###,###';

//  hitung;
          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Bulan']);
           SetPivotRow (['Customer']);
           SetPivotData(['Riil']);
           Label4.Caption := IntToStr(ds3.RecordCount);

end;

procedure TfrmListJual3.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListJual3.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListJual3.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListJual3.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListJual3.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListJual3.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListJual3.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListJual3.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListJual3.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListJual3.cxGrid1DBTableView1DataControllerFilterChanged(
  Sender: TObject);
begin
Label4.Caption := IntToStr(cxGrid1DBTableView1.DataController.FilteredRecordCount);
end;

procedure TfrmListJual3.cxButton1Click(Sender: TObject);
begin
With cxPivot.GetFieldByName('Salesman') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Riil')
    else
      SortBySummaryInfo.Field := nil;
  end;

With cxPivot.GetFieldByName('Customer') do
  begin
    if SortBySummaryInfo.Field = nil then
      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Riil')
    else
      SortBySummaryInfo.Field := nil;
  end;

end;

end.
