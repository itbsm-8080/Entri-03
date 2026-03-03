unit ufrmLapBulanan2;

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
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, AdvCombo,
  cxCurrencyEdit, cxGridDBBandedTableView,DateUtils, dxPScxGrid6Lnk, MemDS,
  DBAccess, MyAccess;

type
  TfrmLapBulanan2 = class(TForm)
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
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cbbBulan: TAdvComboBox;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    clsalesman: TcxGridDBBandedColumn;
    clTarget: TcxGridDBBandedColumn;
    clRealisasi: TcxGridDBBandedColumn;
    clTargetPiutang: TcxGridDBBandedColumn;
    clTunai: TcxGridDBBandedColumn;
    clRealisasiPiutang: TcxGridDBBandedColumn;
    clPersenJual: TcxGridDBBandedColumn;
    clPersenPiutang: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    Label2: TLabel;
    edtTahun: TComboBox;
    clTotalTarget: TcxGridDBBandedColumn;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure clPersenJualCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
        TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure clPersenJualCustomDrawFooterCell(Sender: TcxGridTableView; ACanvas:
        TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure clPersenPiutangCustomDrawCell(Sender: TcxCustomGridTableView;
        ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone:
        Boolean);
    procedure clPersenPiutangCustomDrawFooterCell(Sender: TcxGridTableView;
        ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo; var ADone:
        Boolean);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);

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

  frmLapBulanan2: TfrmLapBulanan2;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmLapBulanan2.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapBulanan2.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapBulanan2.refreshdata;
begin
  edttahun.text :=  FormatDateTime('yyyy',Date);
end;

procedure TfrmLapBulanan2.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmLapBulanan2.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;





procedure TfrmLapBulanan2.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmLapBulanan2.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapBulanan2.loaddata;
var
  ssql:string;
  capaibulanini : double;
  akhir,akhir2 : TDateTime;
begin
  if  cbbBulan.itemindex <> 0 then
begin
akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex )+'/01/'+edttahun.Text));
akhir2 := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1 )+'/01/'+edttahun.Text));
end
else
begin
  akhir := EndOfTheMonth(StrToDate('12/01/'+inttostr(StrToInt(edtTahun.text)-1)));
  akhir2 := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1 )+'/01/'+edttahun.Text));
end;
ssql:= 'select Salesman,sls_nama Nama,'
+ ' (select st_targetsales from tsalesmantarget  where st_periode='+IntToStr(cbbBulan.itemindex +1)+' and st_tahun='+ edtTahun.Text + ' and  st_sls_kode=a.salesman) Target_Jual,'
+ ' (select sum(total-biaya_promosi-kontrak-retur)'
+ ' from transaksi_harian'
+ ' where month(tanggal)='+IntToStr(cbbBulan.itemindex +1)+' and year(tanggal)='+ edtTahun.Text + ' and salesman=a.salesman ) Realisasi_Jual,'
+ ' (select sum(total-biaya_promosi-kontrak-retur)'
+ ' from transaksi_harian'
+ ' where month(tanggal)='+IntToStr(cbbBulan.itemindex +1)+' and year(tanggal)='+ edtTahun.Text + ' and salesman=a.salesman )/'
+ ' (select st_targetsales from tsalesmantarget  where st_periode='+IntToStr(cbbBulan.itemindex +1)+' and st_tahun='+ edtTahun.Text + ' and  st_sls_kode=a.salesman)*100 Presentase2,'
+ ' piutang Piutang,ifnull(tunai,0)+ifnull(tunai2,0) Tunai,(Piutang+ifnull(tunai,0)+ifnull(tunai2,0)) Target_Piutang,'
+ ' ifnull(inkaso,0) Realisasi,inkaso/(Piutang+ifnull(tunai,0)+ifnull(tunai2,0))*100 Persentase'
+ '  from ('
+ ' select salesman, '
+ ' sum(IF ((select count(*) from tjatuhtempofp where jt_fp_nomor=nomor) > 0 ,'
+ ' (select sum(jt_nilai) from tjatuhtempofp where jt_fp_nomor=nomor and jt_tanggaljt <= '+quotd(akhir2)+') , total)) -  '
+ ' ifnull((select sum(bayar_cash+bayar_transfer+giro+potongan+ppn+pph- '
+ ' ifnull((select sum(bycd_bayar) from tbayarcus_dtl '
+ ' inner join tfp_hdr on fp_nomor=bycd_fp_nomor '
+ ' where bycd_byc_nomor=xx.nomor and fp_jthtempo > '+quotd(akhir2)+'),0)) '
+ ' from pembayaran xx where salesman=a.salesman and tanggal <= '+quotd(akhir)+'),0) -'
+ ' ifnull((select sum(retur) from retur where salesman=a.salesman and tanggal <= '+quotd(akhir)+'),0) piutang,'

+ ' (select sum(bycd_bayar) from tbayarcus_dtl inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor '
+ ' inner join  tfp_hdr on fp_nomor=bycd_fp_nomor'
+ ' inner join tdo_hdr on do_nomor=fp_do_nomor'
+ ' inner join tso_hdr on so_nomor=do_so_nomor'
+ ' where so_sls_kode=a.salesman and fp_tanggal > '+quotd(akhir)
+ ' and month(byc_tanggal)='+IntToStr(cbbBulan.itemindex +1)+' ) tunai,'
+ ' (select sum(bycd_bayar) from tbayarcus_dtl inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor '
+ ' inner join  tfp_hdr on fp_nomor=bycd_fp_nomor'
+ ' inner join tdo_hdr on do_nomor=fp_do_nomor'
+ ' inner join tso_hdr on so_nomor=do_so_nomor'
+ ' where so_sls_kode=a.salesman and fp_tanggal <= '+quotd(akhir)+' and fp_jthtempo > '+quotd(akhir2)
+ ' and month(byc_tanggal)='+IntToStr(cbbBulan.itemindex +1)+') tunai2,'
+ ' (select sum(ifnull(bayar_cash,0)+ifnull(bayar_transfer,0)+ifnull(giro,0)+ifnull(potongan,0)+ifnull(pph,0)+ifnull(ppn,0)) from pembayaran where month(tanggal)='+IntToStr(cbbBulan.itemindex +1)+' and year(tanggal)='+edttahun.Text
+ ' and salesman=a.salesman) inkaso'
+ ' from penjualan a'
+ ' inner join tfp_hdr on fp_nomor=nomor'
+ ' where tanggal <= '+quotd(akhir)+' and fp_jthtempo <= '+quotd(akhir2)
+ ' group by salesman) a inner join tsalesman on a.salesman=sls_kode';

//
//select *,ifnull(realisasi,0)-ifnull(kontrak,0)-ifnull(biaya_promosi,0)-ifnull(retur,0) riilbulanini,'
//        + ' (ifnull(realisasi,0)-ifnull(kontrak,0)-ifnull(biaya_promosi,0)-ifnull(retur,0))/targetbulanini *100 persenbulanini,'
//        + ' riilsdbulanini/targetsdbulanini*100 persensdbulanini '
//        + '  from ('
//        + '  select sls_kode,sls_nama salesman,ifnull(st_targetsales,0) targetbulanini,'
//        + '  (select ifnull(sum(st_targetsales),0) from tsalesmantarget where st_sls_kode=sls_kode and st_periode<= '+ IntToStr(cbbBulan.itemindex +1)+' and st_tahun='+ edtTahun.Text+') targetsdbulanini,'
//        + '  sum(fp_amount) Realisasi ,'
//        + '  sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp) Biaya_promosi ,'
//        + '  sum(fp_cn) Kontrak ,'
//        + '  (select sum(ifnull(retj_amount,0)) from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
//        + '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
//        + '  where so_sls_kode = z.sls_kode  and month(retj_tanggal)=month(zzz.fp_tanggal)'
//        + '  group by so_sls_kode) Retur,'
//        + '  (select Realisasi-ifnull(biaya_promosi,0)-ifnull(kontrak,0)-ifnull(retur,0) from'
//        + '  (select sls_kode,'
//        + '  sum(fp_amount) Realisasi ,'
//        + '  sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp) Biaya_promosi ,'
//        + '  sum(fp_cn) Kontrak ,'
//        + '  (select sum(ifnull(retj_amount,0)) from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
//        + '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
//        + '  where so_sls_kode = z2.sls_kode  and month(retj_tanggal)=month(zzz2.fp_tanggal)'
//        + '  group by so_sls_kode) Retur'
//        + '  fROM TFP_hdr zzz2 inner join tdo_hdr  on fp_do_nomor=do_nomor'
//        + '  inner join tso_hdr zz2 on so_nomor=do_so_nomor'
//        + '  right join tsalesman z2 on sls_kode=so_sls_kode'
//        + '  where  year(fP_tanggal)='+ edtTahun.Text+' and month(fp_tanggal) <= '+ IntToStr(cbbBulan.itemindex +1)
//        + '  group by so_sls_kode,year(fp_tanggal)) sdbulanini where sls_kode=z.sls_kode) riilsdbulanini'
//        + '  fROM TFP_hdr zzz inner join tdo_hdr  on fp_do_nomor=do_nomor'
//        + ' inner join tso_hdr zz on so_nomor=do_so_nomor'
//        + '  right join tsalesman z on sls_kode=so_sls_kode'
//        + '  left join tsalesmantarget x on z.sls_kode=x.st_sls_Kode and st_tahun='+ edtTahun.Text+' and st_periode='+ IntToStr(cbbBulan.itemindex +1)
//        + '  where month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ edtTahun.Text
//        + '  group by so_sls_kode,month(fp_tanggal),year(fp_tanggal)'
//        + '  ) final where salesman <> "KANTOR" order by riilsdbulanini desc';

        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;
        capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasi_jual'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('target_jual'))*100;
//        TcxDBGridHelper(cxGrid1DBBandedTableView1).Columns[6].Summary.Item.Caption :=FloatToStr(capaibulanini);
        //TcxDBGridHelper(cxGrid1DBBandedTableView1).Columns[6]. := FloatToStr(capaibulanini);
//        cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems[9].SummaryItems. := FloatToStr(capaibulanini);

end;

procedure TfrmLapBulanan2.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmLapBulanan2.clPersenJualCustomDrawCell(Sender:
    TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
 if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan2.clPersenJualCustomDrawFooterCell(Sender:
    TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan2.clPersenPiutangCustomDrawCell(Sender:
    TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan2.clPersenPiutangCustomDrawFooterCell(Sender:
    TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan2.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapBulanan2.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmLapBulanan2.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('target_jual')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasi_jual'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('target_jual'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmLapBulanan2.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Target_Piutang')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Realisasi'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Target_Piutang'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

end.
