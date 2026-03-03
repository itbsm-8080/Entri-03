unit ufrmkomisisalesman;

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
  cxCurrencyEdit, cxGridDBBandedTableView,DateUtils, dxPScxGrid6Lnk,
  cxTextEdit, MyAccess, MemDS, DBAccess;

type
  TfrmKomisisalesman = class(TForm)
    tscrlbx1: TTeScrollBox;
    TePanel4: TTePanel;
    ilMenu: TImageList;
    TePanel1: TTePanel;
    ilToolbar: TImageList;
    TeLabel1: TTeLabel;
    SaveDialog1: TSaveDialog;
    TePanel3: TTePanel;
    dtstprvdr1: TDataSetProvider;
    sqlqry3: TSQLQuery;
    ds2: TDataSource;
    ds3: TClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxstyl1: TcxStyle;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
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
    clTotalTarget: TcxGridDBBandedColumn;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    TePanel6: TTePanel;
    Label3: TLabel;
    Label4: TLabel;
    cxButton1: TcxButton;
    cbbbulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxGrid2: TcxGrid;
    cxgridKomisi: TcxGridDBBandedTableView;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    cxGridDBBandedColumn6: TcxGridDBBandedColumn;
    cxGridDBBandedColumn8: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    cxgridKomisiColumn1: TcxGridDBBandedColumn;
    cxgridKomisiColumn2: TcxGridDBBandedColumn;
    cxgridKomisiColumn3: TcxGridDBBandedColumn;
    cxgridKomisiColumn4: TcxGridDBBandedColumn;
    sqlqry4: TSQLQuery;
    ds22: TDataSource;
    dtstprvdr2: TDataSetProvider;
    ds32: TClientDataSet;
    cxgridKomisiColumn5: TcxGridDBBandedColumn;
    cxButton2: TcxButton;
    cxgridKomisiColumn6: TcxGridDBBandedColumn;
    cxgridKomisiColumn7: TcxGridDBBandedColumn;
    cxgridKomisiColumn8: TcxGridDBBandedColumn;
    cxgridKomisiColumn9: TcxGridDBBandedColumn;
    cxgridKomisiColumn10: TcxGridDBBandedColumn;
    cxgridKomisiColumn11: TcxGridDBBandedColumn;
    cxgridKomisiColumn12: TcxGridDBBandedColumn;
    cxgridKomisiColumn17: TcxGridDBBandedColumn;
    cxgridKomisiColumn18: TcxGridDBBandedColumn;
    cxgridKomisiColumn19: TcxGridDBBandedColumn;
    cxgridKomisiColumn20: TcxGridDBBandedColumn;
    cxButton3: TcxButton;
    clPF: TcxGridDBBandedColumn;
    clratiopf: TcxGridDBBandedColumn;
    cxgridKomisiColumn13: TcxGridDBBandedColumn;
    sqlqry1: TMyQuery;
    sqlqry2: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
   function getkomisijual(apersen:double) : double;
   function getkomisipf(asalesman:string) : double;
   function getperseninkaso(apersen:double) : double;
   function getperseninkaso2(apersen:double) : double;
   function getperseninkaso3(apersen:double) : double;
   function getperseninkaso4(apersen:double) : double;
    procedure cxButton3Click(Sender: TObject);
    procedure clPFPropertiesEditValueChanged(Sender: TObject);
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

  frmKomisisalesman: TfrmKomisisalesman;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport;
{$R *.dfm}



procedure TfrmKomisisalesman.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmKomisisalesman.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmKomisisalesman.refreshdata;
begin

end;

procedure TfrmKomisisalesman.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmKomisisalesman.FormShow(Sender: TObject);
begin
  flagedit := False;
  edttahun.Text := FormatDateTime('yyyy',date);
  cbbBulan.ItemIndex :=StrToInt(FormatDateTime('mm',date))-1;
  refreshdata;
end;





procedure TfrmKomisisalesman.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmKomisisalesman.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmKomisisalesman.loaddata;
var
  ssql:string;
  capaibulanini : double;
  akhir,akhir2 : TDateTime;
  arealisasijual,arealisasiinkaso : Double;
  tsql,tsql2 : TMyQuery;
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
ssql:= 'select Salesman,sls_nama Nama,cast(0 as decimal(5,2)) ratiopf,'
      + ' (select st_targetsales from tsalesmantarget  where st_periode='+IntToStr(cbbBulan.itemindex +1)+' and st_tahun='+ edtTahun.Text + ' and  st_sls_kode=a.salesman) Target_Jual,'
      + ' (select sum(total-biaya_promosi-kontrak-retur)'
      + ' from transaksi_harian'
      + ' where month(tanggal)='+IntToStr(cbbBulan.itemindex +1)+' and year(tanggal)='+ edtTahun.Text + ' and salesman=a.salesman ) Realisasi_Jual,'
      + ' (select sum(total-biaya_promosi-kontrak-retur)'
      + ' from transaksi_harian'
      + ' where month(tanggal)='+IntToStr(cbbBulan.itemindex +1)+' and year(tanggal)='+ edtTahun.Text + ' and salesman=a.salesman )/'
      + ' (select st_targetsales from tsalesmantarget  where st_periode='+IntToStr(cbbBulan.itemindex +1)+' and st_tahun='+ edtTahun.Text + ' and  st_sls_kode=a.salesman)*100 Presentase2,'
      + ' piutang Piutang,ifnull(tunai,0)+ifnull(tunai2,0) Tunai,(ifnull(tunai2,0)) Target_Piutang,'
      + ' ifnull(inkaso,0) Realisasi,inkaso/(Piutang+ifnull(tunai,0)+ifnull(tunai2,0))*100 Persentase,'
      + ' (select '
      + '  sum((100-fpd_discpr)*(fpd_harga*fpd_qty)/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) - '
      + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) -'
      + ' sum(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+sum(fpd_bp_rp*fpd_qty) Nilai'
      + ' from tfp_dtl inner join tfp_hdr on fp_nomor=fpd_fp_nomor'
      + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
      + ' inner join tso_hdr on so_nomor =do_so_nomor'
      + ' inner join tbarang on brg_kode=fpd_brg_kode'
      + ' and month(fp_tanggal)='+inttostr(cbbbulan.itemindex+1)+' and year(fP_tanggal)='+edttahun.text
      + ' and brg_isproductfocus=1 where so_sls_kode=a.salesman) pf'
      + '  from ('
      + ' select salesman, '
      + ' sum(IF ((select count(*) from tjatuhtempofp where jt_fp_nomor=nomor) > 0 ,'
      + ' (select sum(jt_nilai) from tjatuhtempofp where jt_fp_nomor=nomor and jt_tanggaljt <= '+quotd(akhir2)+') , total)) -  '
        + ' ifnull((select sum(bayar_cash+bayar_transfer+giro+potongan+ppn+pph- '
      + ' ifnull((select sum(bycd_bayar) from tbayarcus_dtl '
      + ' inner join tfp_hdr on fp_nomor=bycd_fp_nomor '
      + ' where bycd_byc_nomor=xx.nomor and fp_jthtempo > '+quotd(akhir2)+'),0)) '
      + ' from pembayaran xx where salesman=a.salesman and tanggal <= '+quotd(akhir)+'),0) -'
      + ' ifnull((select sum(retur) from retur inner join tfp_hdr on fp_nomor=retj_fp_nomor where fp_jthtempo <= '+quotd(akhir)+' and salesman=a.salesman and tanggal <= '+quotd(akhir)+'),0) piutang,'
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
      + ' where fp_jthtempo <= '+quotd(akhir2) // +' and tanggal <= '+quotd(akhir)
      + ' group by salesman) a inner join tsalesman on a.salesman=sls_kode and sls_insentif=1';

        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;

                ssql := 'SELECT sls_nama salesman,sum(piutang-IFNULL(bayar,0)-retur) sisa FROM ( '
          + ' SELECT so_sls_kode,fp_amount piutang,fp_bayar,(select IFNULL(SUM(IFNULL(bycd_bayar,0)),0)  FROM tbayarcus_dtl'
          + ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
          + ' WHERE byc_tanggal <= '+quotd(akhir)+' AND  bycd_fp_nomor=fp_nomor  GROUP BY bycd_fp_nomor) bayar,'
          + ' (SELECT ifnull(sum(retj_amount),0) FROM tretj_hdr WHERE retj_fp_nomor=fp_nomor) retur'
          + ' from tfp_hdr INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
          + ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
          + ' WHERE fp_jthtempo <= '+ quotd(akhir2) /// + ' AND fp_tanggal <= '+ quotd(akhir)
          + ' ) final'
          + ' INNER JOIN tsalesman ON sls_kode=so_sls_kode'
          + ' GROUP BY so_sls_kode'
          + ' HAVING sisa <> 0';
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin
   //          showmessage(FieldByName('salesman').AsString);
             if ds3.Locate('nama',FieldByName('salesman').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('piutang').AsFloat :=FieldByName('sisa').AsFloat;
                ds3.FieldByName('target_piutang').AsFloat := ds3.FieldByName('target_piutang').AsFloat + FieldByName('sisa').AsFloat;
                ds3.FieldByName('Persentase').AsFloat :=ds3.FieldByName('Realisasi').AsFloat/ds3.FieldByName('target_piutang').AsFloat*100;
                ds3.Post;
             end;

//             totaltarget := totaltarget +(FieldByName('target').AsFloat/1000);
             Next;
             end;
           finally
            free;
          end;
        end;




//        capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasi_jual'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('target_jual'))*100;

 ssql:= 'SELECT salesman,batas,'
+ ' (riil+riil2+riil3+riil4) riil,'
+ ' (riil+IFNULL(girolalu,0)-batas-kontrak-biaya_promosi) pengali,'
+ ' (riil2+IFNULL(girolalu2,0)-kontrak2-biaya_promosi2) pengali2,'
+ ' (riil3+IFNULL(girolalu3,0)-kontrak3-biaya_promosi3) pengali3,'
+ ' (riil4+IFNULL(girolalu4,0)-kontrak4-biaya_promosi4) pengali4,'
+ ' riil komisi_jual,riil2 persen,riil3 nilai,riil4 total,riil2 persen2,riil3 nilai2,riil2 persen3,riil3 nilai3,riil2 persen4,riil3 nilai4,cast(0 as decimal) komisipf,'
+ ' IFNULL(girolalu,0) +IFNULL(girolalu2,0) +IFNULL(girolalu3,0) +IFNULL(girolalu4,0) girolalu,'
+ ' IFNULL(kontrak,0) +IFNULL(kontrak2,0) +IFNULL(kontrak3,0) +IFNULL(kontrak4,0) kontrak,'
+ ' IFNULL(biaya_promosi,0) +IFNULL(biaya_promosi2,0) +IFNULL(biaya_promosi3,0) +IFNULL(biaya_promosi4,0) biaya_promosi'
+ ' FROM ('
+ ' SELECT salesman, SUM(ifnull(riil,0)) riil, SUM(ifnull(riil2,0)) riil2, SUM(ifnull(riil3,0)) riil3, SUM(ifnull(riil4,0)) riil4,'
+ ' SUM(biaya_promosi) biaya_promosi, SUM(kontrak) kontrak,'
+ ' SUM(biaya_promosi2) biaya_promosi2, SUM(kontrak2) kontrak2,'
+ ' SUM(biaya_promosi3) biaya_promosi3, SUM(kontrak3) kontrak3,'
+ ' SUM(biaya_promosi4) biaya_promosi4, SUM(kontrak4) kontrak4,'
+ ' ('
+ ' SELECT ksh_batas_inkaso'
+ ' FROM tkomisisales_hdr'
+ ' LIMIT 1) Batas, ('
+ ' SELECT SUM(bycd_bayar* IF(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1))'
+ ' FROM tpencairangiro a'
+ ' INNER JOIN tbayarcus_hdr ON byc_nogiro=cg_gironumber'
+ ' INNER JOIN tbayarcus_dtl ON byc_nomor=bycd_byc_nomor'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
+ ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
+ ' WHERE MONTH(byc_tanggal) <> MONTH(cg_tanggalcair) AND cg_gironumber'
+ ' <> "" AND MONTH(cg_tanggalcair)='+ IntToStr(cbbBulan.itemindex +1)+' AND YEAR(cg_tanggalcair)='+edttahun.text+' AND so_sls_kode=sls_kode'
+ ' and datediff(cg_tanggalcair,fp_tanggal)>7 and datediff(cg_tanggalcair,fp_tanggal)<=40'
+ ' ) girolalu,'
+ ' ('
+ ' SELECT SUM(bycd_bayar* IF(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1))'
+ ' FROM tpencairangiro a'
+ ' INNER JOIN tbayarcus_hdr ON byc_nogiro=cg_gironumber'
+ ' INNER JOIN tbayarcus_dtl ON byc_nomor=bycd_byc_nomor'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
+ ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
+ ' WHERE MONTH(byc_tanggal) <> MONTH(cg_tanggalcair) AND cg_gironumber'
+ ' <> "" AND MONTH(cg_tanggalcair)='+IntToStr(cbbBulan.itemindex +1)+' AND YEAR(cg_tanggalcair)='+edttahun.text+' AND so_sls_kode=sls_kode'
+ ' and datediff(cg_tanggalcair,fp_tanggal)>40 and datediff(cg_tanggalcair,fp_tanggal)<=60'
+ ' ) girolalu2,'
+ ' ('
+ ' SELECT SUM(bycd_bayar* IF(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1))'
+ ' FROM tpencairangiro a'
+ ' INNER JOIN tbayarcus_hdr ON byc_nogiro=cg_gironumber'
+ ' INNER JOIN tbayarcus_dtl ON byc_nomor=bycd_byc_nomor'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
+ ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
+ ' WHERE MONTH(byc_tanggal) <> MONTH(cg_tanggalcair) AND cg_gironumber'
+ ' <> "" AND MONTH(cg_tanggalcair)='+IntToStr(cbbBulan.itemindex +1)+' AND YEAR(cg_tanggalcair)='+edttahun.text+' AND so_sls_kode=sls_kode'
+ ' and datediff(cg_tanggalcair,fp_tanggal)>60'
+ ' ) girolalu3,'
+ ' ('
+ ' SELECT SUM(bycd_bayar* IF(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1))'
+ ' FROM tpencairangiro a'
+ ' INNER JOIN tbayarcus_hdr ON byc_nogiro=cg_gironumber'
+ ' INNER JOIN tbayarcus_dtl ON byc_nomor=bycd_byc_nomor'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
+ ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
+ ' WHERE MONTH(byc_tanggal) <> MONTH(cg_tanggalcair) AND cg_gironumber'
+ ' <> "" AND MONTH(cg_tanggalcair)='+IntToStr(cbbBulan.itemindex +1)+' AND YEAR(cg_tanggalcair)='+edttahun.text+' AND so_sls_kode=sls_kode'
+ ' and datediff(cg_tanggalcair,fp_tanggal)<=7'
+ ' ) girolalu4'
+ ' FROM ('
+ ' SELECT sls_kode,sls_nama salesman,nomor,TANGGAL,'
+ ' ((select sum(bycd_bayar) from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' where bycd_byc_nomor=nomor and datediff(tanggal,fp_tanggal)>7 and datediff(tanggal,fp_tanggal)<=40) -'
+ ' IF(('
+ ' SELECT COUNT(*)'
+ ' FROM tbayarcus_hdr'
+ ' INNER JOIN tpencairangiro ON cg_gironumber=byc_nogiro'
+ ' WHERE byc_nomor=nomor AND cg_tanggalcair <= '+quotd(akhir2)+')>0,0,'
+ ' (select ifnull(sum(bycd_bayar)/(bayar_cash+bayar_transfer+giro+hutang_internal+um_penjualan+ppn_keluaran+pph_22),0)'
+ ' from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' inner join tpencairangiro  ON cg_gironumber=byc_nogiro'
+ ' where bycd_byc_nomor=nomor  and datediff(cg_tanggalcair,fp_tanggal)>7 and datediff(cg_tanggalcair,fp_tanggal)<=40)*giro))'
+ ' / IF(tax="PPN",if(fp_tanggal<"2022/04/01",1.1,1.11),1) riil,'
+ ' ((select sum(bycd_bayar) from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' where bycd_byc_nomor=nomor and datediff(tanggal,fp_tanggal)>40 and datediff(tanggal,fp_tanggal)<=60) -'
+ ' IF(('
+ ' SELECT COUNT(*)'
+ ' FROM tbayarcus_hdr'
+ ' INNER JOIN tpencairangiro ON cg_gironumber=byc_nogiro'
+ ' WHERE byc_nomor=nomor AND cg_tanggalcair <= '+quotd(akhir2)+')>0,0,'
+ ' (select ifnull(sum(bycd_bayar)/(bayar_cash+bayar_transfer+giro+hutang_internal+um_penjualan+ppn_keluaran+pph_22) ,0)'
+ ' from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' inner join tpencairangiro  ON cg_gironumber=byc_nogiro'
+ ' where bycd_byc_nomor=nomor  and datediff(cg_tanggalcair,fp_tanggal)>40 and datediff(cg_tanggalcair,fp_tanggal)<=60)*giro))'
+ ' / IF(tax="PPN",if(fp_tanggal<"2022/04/01",1.1,1.11),1) riil2,'
+ ' ((select sum(bycd_bayar) from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' where bycd_byc_nomor=nomor and datediff(tanggal,fp_tanggal)>=60) -'
+ ' IF(('
+ ' SELECT COUNT(*)'
+ ' FROM tbayarcus_hdr'
+ ' INNER JOIN tpencairangiro ON cg_gironumber=byc_nogiro'
+ ' WHERE byc_nomor=nomor AND cg_tanggalcair <= '+quotd(akhir2)+')>0,0,'
+ ' (select ifnull(sum(bycd_bayar)/(bayar_cash+bayar_transfer+giro+hutang_internal+um_penjualan+ppn_keluaran+pph_22) ,0)'
+ ' from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' inner join tpencairangiro  ON cg_gironumber=byc_nogiro'
+ ' where bycd_byc_nomor=nomor and datediff(cg_tanggalcair,fp_tanggal)>=60)*giro))'
+ ' / IF(tax="PPN",if(fp_tanggal<"2022/04/01",1.1,1.11),1) riil3,'
+ ' ((select sum(bycd_bayar) from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' where bycd_byc_nomor=nomor and datediff(tanggal,fp_tanggal)<=7) -'
+ ' IF(('
+ ' SELECT COUNT(*)'
+ ' FROM tbayarcus_hdr'
+ ' INNER JOIN tpencairangiro ON cg_gironumber=byc_nogiro'
+ ' WHERE byc_nomor=nomor AND cg_tanggalcair <= '+quotd(akhir2)+')>0,0,'
+ ' (select ifnull(sum(bycd_bayar)/(bayar_cash+bayar_transfer+giro+hutang_internal+um_penjualan+ppn_keluaran+pph_22) ,0)'
+ ' from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' inner join tpencairangiro  ON cg_gironumber=byc_nogiro'
+ ' where bycd_byc_nomor=nomor  and datediff(cg_tanggalcair,fp_tanggal)<=7)*giro))'
+ ' / IF(tax="PPN",if(fp_tanggal<"2022/04/01",1.1,1.11),1) riil4,'
+ ' (SELECT SUM((Fp_biayapr*((fp_amount-fp_taxamount- IFNULL(('
+ ' SELECT SUM(retj_amount)'
+ ' FROM tretj_hdr'
+ ' WHERE retj_fp_nomor = fp_nomor),0)))/100) + fp_biayarp)'
+ ' FROM tbayarcus_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor and datediff(byc_tanggal,fp_tanggal) > 7 and datediff(byc_tanggal,fp_tanggal) <=40) Biaya_Promosi,'
+ ' (SELECT SUM((Fp_biayapr*((fp_amount-fp_taxamount- IFNULL(('
+ ' SELECT SUM(retj_amount)'
+ ' FROM tretj_hdr'
+ ' WHERE retj_fp_nomor = fp_nomor),0)))/100) + fp_biayarp)'
+ ' FROM tbayarcus_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor and datediff(byc_tanggal,fp_tanggal) > 40 and datediff(byc_tanggal,fp_tanggal) <=60) Biaya_Promosi2,'
+ ' (SELECT SUM((Fp_biayapr*((fp_amount-fp_taxamount- IFNULL(('
+ ' SELECT SUM(retj_amount)'
+ ' FROM tretj_hdr'
+ ' WHERE retj_fp_nomor = fp_nomor),0)))/100) + fp_biayarp)'
+ ' FROM tbayarcus_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor and datediff(byc_tanggal,fp_tanggal) > 60 ) Biaya_Promosi3,'
+ ' (SELECT SUM((Fp_biayapr*((fp_amount-fp_taxamount- IFNULL(('
+ ' SELECT SUM(retj_amount)'
+ ' FROM tretj_hdr'
+ ' WHERE retj_fp_nomor = fp_nomor),0)))/100) + fp_biayarp)'
+ ' FROM tbayarcus_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor and datediff(byc_tanggal,fp_tanggal) <= 7 ) Biaya_Promosi4,'
+ ' (SELECT SUM(fp_cn)'
+ ' FROM tbayarcus_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor'
+ ' and datediff(byc_tanggal,fp_tanggal) > 7 and datediff(byc_tanggal,fp_tanggal) <=40'
+ ' ) Kontrak,'
+ ' (SELECT SUM(fp_cn)'
+ ' FROM tbayarcus_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor'
+ ' and datediff(byc_tanggal,fp_tanggal) > 40 and datediff(byc_tanggal,fp_tanggal) <=60'
+ ' ) Kontrak2,'
+ ' (SELECT SUM(fp_cn)'
+ ' FROM tbayarcus_dtl '
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor'
+ ' and datediff(byc_tanggal,fp_tanggal) > 60'
+ ' ) Kontrak3,'
+ ' (SELECT SUM(fp_cn)'
+ ' FROM tbayarcus_dtl'
+ ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
+ ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
+ ' WHERE bycd_byc_nomor=nomor'
+ ' and datediff(byc_tanggal,fp_tanggal) <= 7'
+ ' ) Kontrak4'
+ ' FROM transaksi_harian a'
+ ' INNER JOIN tsalesman b ON salesman=sls_kode AND sls_insentif=1'
+ ' WHERE MONTH(tanggal)= '+IntToStr(cbbBulan.itemindex +1)+' AND YEAR (tanggal) = '+edttahun.text+' AND nomor LIKE "%CR%") a'
+ ' GROUP BY salesman) final';


// select salesman,riil,biaya_promosi,kontrak,batas,(riil+ifnull(girolalu,0))-biaya_promosi-kontrak-batas Pengali,riil komisi_jual,riil persen,riil nilai,riil total ,'
//      + ' ifnull(girolalu,0) girolalu '
//      + ' from (select salesman,sum(riil) riil,sum(biaya_promosi) biaya_promosi,sum(kontrak) kontrak ,'
//      + ' (select ksh_batas_inkaso from tkomisisales_hdr limit 1) Batas,'
//      + ' (select sum(bycd_bayar*if(fp_istax=1,1.1,1)) from tpencairangiro a'
//      + ' inner join tbayarcus_hdr on byc_nogiro=cg_gironumber'
//      + ' inner join tbayarcus_dtl on byc_nomor=bycd_byc_nomor'
//      + ' inner join tfp_hdr on fp_nomor=bycd_fp_nomor'
//      + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
//      + ' inner join tso_hdr on so_nomor=do_so_nomor'
//      + ' where month(byc_tanggal) <> month(cg_tanggalcair)'
//      + ' and cg_gironumber <> "" '
//      + ' and month(cg_tanggalcair)='+IntToStr(cbbBulan.itemindex +1)+' and year(cg_tanggalcair)='+edttahun.text
//      + ' and so_sls_kode=sls_kode) girolalu'
//      + ' from ('
//      + ' select sls_kode,sls_nama salesman,nomor,TANGGAL,'
//      + ' (bayar_cash+bayar_transfer+IF((select count(*) from tbayarcus_hdr inner join tpencairangiro on cg_gironumber=byc_nogiro where byc_nomor=nomor and cg_tanggalcair <= '+quotd(akhir2)+' )>0,giro,0)'
//      + ' +hutang_internal+um_penjualan)/if(tax="PPN",1.1,1) riil,'
//      + ' (select sum((Fp_biayapr*((fp_amount-fp_taxamount-ifnull((select sum(retj_amount) from tretj_hdr'
//      + ' where retj_fp_nomor = fp_nomor),0) ))/100) + fp_biayarp) from tbayarcus_dtl inner join'
//      + ' tfp_hdr on fp_nomor=bycd_fp_nomor where bycd_byc_nomor=nomor ) Biaya_Promosi,'
//      + ' (select sum(fp_cn) from tbayarcus_dtl inner join'
//      + ' tfp_hdr on fp_nomor=bycd_fp_nomor where bycd_byc_nomor=nomor ) Kontrak'
//      + ' from transaksi_harian a'
//      + ' inner join tsalesman b on salesman=sls_kode and sls_insentif=1'
//      + ' where month(tanggal)= '+IntToStr(cbbBulan.itemindex +1)
//      + ' and year (tanggal) = '+ edttahun.text
//      + ' and nomor like "%CR%") a'
//      + ' group  by salesman) final';
        ds32.Close;
        sqlqry2.Connection := frmMenu.conn;
        sqlqry2.SQL.Text := ssql;
        ds32.open;

         ds3.First;
        while not ds3.eof do
        begin
          if ds3.fieldbyname('pf').AsFloat > 0 then
          begin
            If ds3.State <> dsEdit then ds3.Edit;
            ds3.FieldByName('ratiopf').asfloat :=ds3.fieldbyname('pf').AsFloat/ds3.fieldbyname('target_jual').AsFloat*100;
          end;
          ds3.Next;
        end;

        ssql := 'SELECT  sls_nama salesman,SUM((100-fpd_discpr)/100*fpd_harga*fpd_qty) total,'
              + ' if(s < 7,"Cash",if(s<41,"40 Hari",if(s < 60,"60 Hari","lebih dari 60"))) overdue FROM ('
              + ' SELECT  sls_nama,fp_tanggal,byc_tanggal,DATEDIFF(byc_tanggal,fp_tanggal) s,fpd_brg_kode,fpd_qty,'
              + ' fpd_harga,fpd_discpr,(100-fpd_cn)/100*((100-fpd_discpr)*fpd_harga/100) net,mst_hargabeli FROM tBAYARcus_dtl '
              + ' INNER JOIN tbayarcus_hdr ON byc_nomor=bycd_byc_nomor'
              + ' INNER JOIN tfp_hdr ON fp_nomor=bycd_fp_nomor'
              + ' INNER JOIN tfp_dtl ON fpd_fp_nomor=fp_nomor'
              + ' INNER JOIN tmasterstok ON mst_noreferensi=fp_do_nomor AND fpd_brg_kode=mst_brg_kode'
              + ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
              + ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
              + ' INNER JOIN tsalesman ON sls_kode=so_sls_kode'
              + ' WHERE month(byc_tanggal)='+IntToStr(cbbBulan.itemindex +1)+' AND year(byc_tanggal)='+ edttahun.text
              + ' and sls_insentif=1) final WHERE (net-mst_hargabeli)/mst_hargabeli*100 < 5'
              + ' GROUP BY sls_nama,overdue ' ;
      tsql2 :=  xOpenQuery(ssql,frmMenu.conn);
      with tsql2 do
      begin
        try
          while not tsql2.Eof do
          begin
            ds32.First;
            ds32.Locate('Salesman',fieldbyname('salesman').AsString,[loCaseInsensitive]);
              If ds32.State <> dsEdit then ds32.Edit;
              if FieldByName('overdue').AsString = 'Cash' then
                ds32.FieldByName('pengali4').asfloat := ds32.FieldByName('pengali4').asfloat -FieldByName('total').asfloat
              else if FieldByName('overdue').AsString = '40 Hari' then
                ds32.FieldByName('pengali').asfloat := ds32.FieldByName('pengali').asfloat -FieldByName('total').asfloat
              else if FieldByName('overdue').AsString = '60 Hari' then
                ds32.FieldByName('pengali2').asfloat := ds32.FieldByName('pengali2').asfloat -FieldByName('total').asfloat
              else if FieldByName('overdue').AsString = 'lebih dari 60' then
                ds32.FieldByName('pengali3').asfloat := ds32.FieldByName('pengali3').asfloat -FieldByName('total').asfloat;

            Next;
          end;
        finally
          free;
        end;
      end;

        ds32.First;
        while not ds32.eof do
        begin
          ds3.First;
           ds3.Locate('nama',ds32.FieldByName('salesman').AsString,[loCaseInsensitive]);
//          while not ds3.Eof do
//          begin
//             if ds3.FieldByName('nama').AsString = ds32.FieldByName('salesman').AsString then
//             begin
             arealisasijual := ds3.fieldbyname('Presentase2').AsFloat;
             arealisasiinkaso :=ds3.fieldbyname('Persentase').AsFloat;
//             ds3.Last;
//             end;
//             ds3.Next
//          end;
          If ds32.State <> dsEdit then ds32.Edit;
          ds32.FieldByName('komisi_jual').asfloat :=getkomisijual(arealisasijual);
          if ds32.FieldByName('komisi_jual').asfloat > 0 then
          begin
             ds32.FieldByName('persen').asfloat :=getperseninkaso(arealisasiinkaso);
             ds32.FieldByName('nilai').asfloat :=getperseninkaso(arealisasiinkaso)*ds32.FieldByName('pengali').AsFloat/100;

             ds32.FieldByName('persen2').asfloat :=getperseninkaso2(arealisasiinkaso);
             ds32.FieldByName('nilai2').asfloat :=getperseninkaso2(arealisasiinkaso)*ds32.FieldByName('pengali2').AsFloat/100;

             ds32.FieldByName('persen3').asfloat :=getperseninkaso3(arealisasiinkaso);
             ds32.FieldByName('nilai3').asfloat :=getperseninkaso3(arealisasiinkaso)*ds32.FieldByName('pengali3').AsFloat/100;

             ds32.FieldByName('persen4').asfloat :=getperseninkaso4(arealisasiinkaso);
             ds32.FieldByName('nilai4').asfloat :=getperseninkaso4(arealisasiinkaso)*ds32.FieldByName('pengali4').AsFloat/100;

          end
          else
          begin
             ds32.FieldByName('persen').asfloat := 0 ;
             ds32.FieldByName('nilai').asfloat :=0;

             ds32.FieldByName('persen2').asfloat := 0 ;
             ds32.FieldByName('nilai2').asfloat :=0;

             ds32.FieldByName('persen3').asfloat := 0 ;
             ds32.FieldByName('nilai3').asfloat :=0;

             ds32.FieldByName('persen4').asfloat := 0 ;
             ds32.FieldByName('nilai4').asfloat :=0;

          end;
          if ds3.FieldByName('ratiopf').asfloat > 0 then
          begin
            if (ds32.FieldByName('komisi_jual').asfloat > 0) and (ds3.FieldByName('ratiopf').asfloat > 20) then
            ds32.FieldByName('komisipf').asfloat :=getkomisipf(ds3.FieldByName('salesman').AsString);
            ds32.FieldByName('total').asfloat :=ds32.FieldByName('komisi_jual').asfloat+ds32.FieldByName('nilai').asfloat+ds32.FieldByName('nilai2').asfloat+ds32.FieldByName('nilai3').asfloat+ds32.FieldByName('nilai4').asfloat+ds32.FieldByName('komisipf').asfloat;
          end
          else
          ds32.FieldByName('total').asfloat :=ds32.FieldByName('komisi_jual').asfloat;

         ds32.Next;
       end;
//        cxGrid1DBBandedTableView1.DataController.Summary.FooterSummaryItems[9].SummaryItems. := FloatToStr(capaibulanini);

end;

procedure TfrmKomisisalesman.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmKomisisalesman.cxButton2Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid2);
     end;

end;

procedure TfrmKomisisalesman.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmKomisisalesman.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmKomisisalesman.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
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

procedure TfrmKomisisalesman.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
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
function TfrmKomisisalesman.getkomisijual(apersen:double) : double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select ksj_komisi from tkomisisales_jual where ksj_bawah <= '+ FloatToStr(apersen)
  + ' and ksj_atas >= '+ floattostr(apersen);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;

function TfrmKomisisalesman.getkomisipf(asalesman:string) : double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select sum((if(harga>brg_harga_min,harga,0)*qty)*brg_insentif/100) from ('
    + ' select fpd_brg_kode,'
    + ' ((100-fpd_discpr)*(fpd_harga)/100) -'
    + ' (fpd_cn*((100-fpd_discpr)*fpd_harga/100)/100) -'
    + ' (fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)/100)+(fpd_bp_rp) harga,fpd_qty qty,brg_harga_min,brg_insentif'
    + ' from tfp_dtl inner join tfp_hdr on fp_nomor=fpd_fp_nomor'
    + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
    + ' inner join tso_hdr on so_nomor =do_so_nomor '
    + ' inner join tbarang on brg_kode=fpd_brg_kode'
    + ' and month(fp_tanggal)='+inttostr(cbbbulan.ItemIndex+1)+' and year(fP_tanggal)='+ edttahun.text
    + ' and brg_isproductfocus=1 where so_sls_kode='+Quot(asalesman)+') a ';
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;

function TfrmKomisisalesman.getperseninkaso(apersen:double) : double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select ksj_komisi from tkomisisales_inkaso where ksj_bawah <= '+ FloatToStr(apersen)
  + ' and ksj_atas >= '+ floattostr(apersen);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;

function TfrmKomisisalesman.getperseninkaso2(apersen:double) : double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select ksj_komisi2 from tkomisisales_inkaso where ksj_bawah <= '+ FloatToStr(apersen)
  + ' and ksj_atas >= '+ floattostr(apersen);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;
function TfrmKomisisalesman.getperseninkaso3(apersen:double) : double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select ksj_komisi3 from tkomisisales_inkaso where ksj_bawah <= '+ FloatToStr(apersen)
  + ' and ksj_atas >= '+ floattostr(apersen);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;
function TfrmKomisisalesman.getperseninkaso4(apersen:double) : double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select ksj_komisi4 from tkomisisales_inkaso where ksj_bawah <= '+ FloatToStr(apersen)
  + ' and ksj_atas >= '+ floattostr(apersen);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;

procedure TfrmKomisisalesman.cxButton3Click(Sender: TObject);
var
  s : string;
  tt:TStrings;
  i:Integer;
  ftsreport : TTSReport;
begin
    ftsreport := TTSReport.Create(nil);
    tt := TStringList.Create;
   s:= ' delete from tcetakkomisi '
      + ' where  ck_periode =' + IntToStr(cbbbulan.ItemIndex+1)
      + ' and ck_tahun='+ edtTahun.Text;
   tt.Append(s);

   ds32.First;
    i:=1;
  while not ds32.Eof do
  begin
    ds3.Locate('nama',ds32.FieldByName('salesman').AsString,[loCaseInsensitive]);
    s:= ' INSERT INTO tcetakkomisi (ck_salesman, ck_PERIODE, ck_tahun, ck_targetjual, ck_realisasijual, ck_persentasejual, ck_komisijual, '
      + ' ck_targetinkaso, ck_realisasiinkaso, ck_persentaseinkaso, ck_riilinkaso7, ck_presentase7, ck_komisiinkaso7, ck_riilinkaso740, '
      + ' ck_presentase740, ck_komisiinkaso740, ck_riilinkaso4060, ck_presentase4060, ck_komisiinkaso4060, ck_riilinkaso60, ck_presentase60, ck_komisiinkaso60,ck_Komisipf,ck_presentasepf)'
      + ' VALUES ('
      + Quot(ds32.Fields[0].AsString)+ ','
      + IntToStr(cbbbulan.ItemIndex+1)+ ','
      + edtTahun.Text + ','
      + floattostr(ds3.fieldbyname('target_jual').AsFloat) + ','
      + floattostr(ds3.fieldbyname('realisasi_jual').AsFloat) + ','
      + floattostr(ds3.fieldbyname('Presentase2').AsFloat) + ','
      + floattostr(ds32.fieldbyname('komisi_jual').asfloat) +','
      + floattostr(ds3.fieldbyname('target_piutang').AsFloat) + ','
      + floattostr(ds3.fieldbyname('realisasi').AsFloat) + ','
      + floattostr(ds3.fieldbyname('Persentase').AsFloat) + ','
      + floattostr(ds32.fieldbyname('pengali4').asfloat) + ','
      + floattostr(ds32.fieldbyname('persen4').asfloat) + ','
      + floattostr(ds32.fieldbyname('nilai4').asfloat) + ','
      + floattostr(ds32.fieldbyname('pengali').asfloat) + ','
      + floattostr(ds32.fieldbyname('persen').asfloat) + ','
      + floattostr(ds32.fieldbyname('nilai').asfloat) + ','
      + floattostr(ds32.fieldbyname('pengali2').asfloat) + ','
      + floattostr(ds32.fieldbyname('persen2').asfloat) + ','
      + floattostr(ds32.fieldbyname('nilai2').asfloat) + ','
      + floattostr(ds32.fieldbyname('pengali3').asfloat) + ','
      + floattostr(ds32.fieldbyname('persen3').asfloat) + ','
      + floattostr(ds32.fieldbyname('nilai3').asfloat) + ','
      + floattostr(ds32.fieldbyname('komisipf').asfloat) +','
      + floattostr(ds3.fieldbyname('ratiopf').asfloat)
      + ');';
      tt.Append(s);
      ds32.Next;
  end;

       try
        for i:=0 to tt.Count -1 do
        begin
            // xExecQuery(tt[i],frmMenu.conn);
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;
      // xCommit(frmMenu.conn);
   try
    ftsreport.Nama := 'cetakkomisi';

       s:= ' select '
       + ' * '
       + ' from tcetakkomisi '
       + ' where '
       + ' ck_periode=' + IntToStr(cbbbulan.ItemIndex+1)
       + ' and ck_tahun = ' + edtTahun.Text
       + ' and ck_komisijual > 0 ';

    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmKomisisalesman.clPFPropertiesEditValueChanged(
  Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;
  cxGrid1DBBandedTableView1.DataController.Post;

  i := cxGrid1DBBandedTableView1.DataController.FocusedRecordIndex;
  lVal := cxGrid1DBBandedTableView1.DataController.Values[i, clpf.Index] /  cxGrid1DBBandedTableView1.DataController.Values[i, clTarget.Index]*100;

  If ds3.State <> dsEdit then ds3.Edit;
  ds3.FieldByName('pfratio').AsFloat := lVal;
  ds3.Post;


end;

end.
