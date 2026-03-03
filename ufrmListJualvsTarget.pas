unit ufrmListJualvsTarget;

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
  TfrmListJualvsTarget = class(TForm)
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

  frmListJualvsTarget: TfrmListJualvsTarget;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmListJualvsTarget.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListJualvsTarget.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListJualvsTarget.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListJualvsTarget.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListJualvsTarget.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListJualvsTarget.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListJualvsTarget.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListJualvsTarget.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
begin

      s:= ' select *,(Inkaso / (inkaso+jthtempo)*100) Pencapaian from (select Bulan,Tahun ,sls_kode Kode,sls_nama Salesman, Actual/1000 Actual, Kontrak/1000 Kontrak, Biaya_promosi/1000 Biaya_Promosi,'
          + ' ifnull(Retur/1000,0) Retur,(Actual/1000)-ifnull(Retur/1000,0)-ifnull(biaya_promosi/1000,0)-ifnull(kontrak/1000,0) Riil, ifnull(Target/1000,0) Target,'
          + ' ((Actual/1000)-ifnull(Retur/1000,0)-ifnull(biaya_promosi/1000,0)-ifnull(kontrak/1000,0)) / (ifnull(Target/1000,0)) * 100 Presentase,'
          + ' ifnull(JthTempo/1000,0) JthTempo,ifnull(BlmJthTempo/1000,0) BlmJthTempo,ifnull(Inkaso/1000,0) Inkaso from ( '
          + ' SELECT month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,sls_kode,sls_nama, '
          + ' sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp) Biaya_promosi, '
          + ' sum(fp_cn) Kontrak ,'
          + ' sum(fp_amount) Actual , '
          + '  (select sum(retj_amount) from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor '
          + '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
          + '  where so_sls_kode = z.sls_kode ' //and retj_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' and month(retj_tanggal)=month(zzz.fp_tanggal) '
          + '  group by so_sls_kode) Retur, '
          + ' (select st_targetsales from tsalesmantarget where st_periode=month(fp_tanggal) and st_tahun=year(fp_tanggal) and st_sls_kode=sls_kode) Target, '
         + ' (select sum(fp_amount-ifnull(fp_dp,0)-(select ifnull(sum(bycd_bayar),0) from tbayarcus_dtl inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor '
         + ' where bycd_fp_nomor=x.fp_nomor and month(byc_tglcair) <= month(zzz.fp_tanggal) )- '
         + ' (select ifnull(sum(retj_amount),0) from tretj_hdr where retj_fp_nomor=x.fp_nomor  )) Piutang'
         + ' from tfp_hdr x inner join tdo_hdr on do_nomor=fp_do_nomor'
         + ' left join tso_hdr on so_nomor=do_so_nomor where x.fp_jthtempo <= case when last_day(zzz.fp_tanggal) < ' + QuotD(enddate.DateTime) + ' then last_day(zzz.fp_tanggal) else ' + QuotD(enddate.DateTime) + ' end '
         +'  and so_sls_kode=z.sls_kode'
//         + ' and  month(fp_tanggal)=month(zzz.fp_tanggal) '
         + '  ) jthTempo,'
         + ' (select sum(fp_amount-ifnull(fp_dp,0)- '
         + ' (select ifnull(sum(bycd_bayar),0) from tbayarcus_dtl inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor where bycd_fp_nomor=x.fp_nomor and month(byc_tglcair) <= month(zzz.fp_tanggal)  ) - '
         + ' (select ifnull(sum(retj_amount),0) from tretj_hdr where retj_fp_nomor=x.fp_nomor '
         + '  ) ) Piutang'
         + ' from tfp_hdr x inner join tdo_hdr on do_nomor=fp_do_nomor'
         + ' left join tso_hdr on so_nomor=do_so_nomor  where x.fp_jthtempo > case when last_day(zzz.fp_tanggal) < ' + QuotD(enddate.DateTime) + ' then last_day(zzz.fp_tanggal) else ' + QuotD(enddate.DateTime) + ' end '
         +'  AND so_sls_kode=z.sls_kode'
         + ' and  month(fp_tanggal) <= month(zzz.fp_tanggal) '
         + '  ) BlmjthTempo ,'
         + '  (select sum(ifnull(bycd_bayar,0)) Inkaso from tbayarcus_hdr INNER join tbayarcus_dtl on'
         + '  byc_nomor=bycd_byc_nomor'
         + '  inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
         + '  inner join tcustomer on cus_kode = fp_cus_kode'
         + '  left join tdo_hdr on do_nomor= fp_do_nomor'
         + '  left join tso_hdr on do_so_nomor=so_nomor'
         + '  left join tsalesman on so_sls_kode=sls_kode'
         + '  where so_sls_kode=z.sls_kode'
         + ' and ' //byc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
         + ' month(byc_tanggal)=month(zzz.fp_tanggal) '
         + '  ) Inkaso '
          + ' FROM TFP_hdr zzz inner join tdo_hdr '
          + ' on fp_do_nomor=do_nomor '
          + ' inner join tso_hdr zz on so_nomor=do_so_nomor '
          + ' right join tsalesman z on sls_kode=so_sls_kode '
          + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' group by so_sls_kode,month(fp_tanggal),year(fp_tanggal)) a) final';

  ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Bulan,Tahun,Kode,Salesman,Actual,Kontrak,Biaya_Promosi,Retur,Riil,Target,Presentase,JthTempo,BlmJthTempo,Inkaso,Pencapaian';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 100;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           cxGrid1DBTableView1.Columns[7].MinWidth := 100;
           cxGrid1DBTableView1.Columns[8].MinWidth := 100;
           cxGrid1DBTableView1.Columns[9].MinWidth := 100;
           cxGrid1DBTableView1.Columns[10].MinWidth := 100;
           cxGrid1DBTableView1.Columns[11].MinWidth := 100;

        for i:=0 To cxGrid1DBTableView1.ColumnCount -1 do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;
//          if (i =10) or (i=14) then
//          begin
//            ds3.Fields[i].Alignment := taRightJustify;
//             TFloatField(ds3.Fields[i]).DisplayFormat := '###.##';
//          end

        end;


       cxGrid1DBTableView1.Columns[4].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[4].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[5].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[5].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[7].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';


        cxGrid1DBTableView1.Columns[9].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.FooterFormat:='###,###,###,###';

                cxGrid1DBTableView1.Columns[13].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[13].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[11].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[11].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[12].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[12].Summary.FooterFormat:='###,###,###,###';

//  hitung;
          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Bulan']);
           SetPivotRow (['Salesman']);
           SetPivotData(['Riil','Target','Presentase','JthTempo','BlmJthTempo','Inkaso','Pencapaian']);

end;

procedure TfrmListJualvsTarget.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListJualvsTarget.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListJualvsTarget.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListJualvsTarget.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListJualvsTarget.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListJualvsTarget.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListJualvsTarget.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListJualvsTarget.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListJualvsTarget.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


end.
