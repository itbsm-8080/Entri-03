unit ufrmLapBulanan3;

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
  cxCurrencyEdit, cxGridDBBandedTableView, dxPScxGrid6Lnk,DateUtils,
  MyAccess, MemDS, DBAccess;

type
  TfrmLapBulanan3 = class(TForm)
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
    cxGrid1DBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column2: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column3: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column4: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column5: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column6: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column7: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column8: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column9: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column10: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    Label2: TLabel;
    edtTahun: TComboBox;
    cxGrid1DBBandedTableView1Column11: TcxGridDBBandedColumn;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxGrid1DBBandedTableView1Column12: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column13: TcxGridDBBandedColumn;
    growth: TcxGridDBBandedColumn;
    growth2: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column16: TcxGridDBBandedColumn;
    cxStyleRepository3: TcxStyleRepository;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxGrid1DBBandedTableView1Column14: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column15: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column17: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column18: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column19: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column20: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column21: TcxGridDBBandedColumn;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxGrid1DBBandedTableView1Column10CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column10CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure growthCustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure growthCustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems14GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure growth2CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas:
        TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure growth2CustomDrawFooterCell(Sender: TcxGridTableView; ACanvas:
        TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems16GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrid1DBBandedTableView1Column19CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column19CustomDrawFooterCell(
      Sender: TcxGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column21CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column21CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems19GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems21GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);

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

  frmLapBulanan3: TfrmLapBulanan3;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmLapBulanan3.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapBulanan3.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapBulanan3.refreshdata;
begin
  cbbBulan.ItemIndex :=StrToInt(FormatDateTime('mm',date))-1;
  edttahun.text :=  FormatDateTime('yyyy',Date);
end;

procedure TfrmLapBulanan3.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmLapBulanan3.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;





procedure TfrmLapBulanan3.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmLapBulanan3.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapBulanan3.loaddata;
var
  ssql:string;
  capaibulanini : double;
  totaltarget : double;
  tsql : TMyQuery;
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
//  totaltarget := 0;
ssql:= ' select *,cast(0 as decimal(5,2)) pfratio,cast(0 as decimal(5,2)) growth,cast(0 as decimal(5,2)) growth2,cast(0 as decimal) riilbulaninilalu,'
        + ' cast(0 as decimal) riilsdbulaniniLalu,cast(0 as decimal) targettahunan,cast(0 as decimal(5,2)) ratio,'
        + ' cast(0 as decimal(5,2)) ratiopiutang,cast(0 as decimal) targetpiutang,cast(0 as decimal) realisasipiutang,'
        + ' (ifnull(realisasi,0)-ifnull(kontrak,0)-ifnull(biaya_promosi,0)-ifnull(retur,0)) riilbulanini,'
        + ' (ifnull(realisasi,0)-ifnull(kontrak,0)-ifnull(biaya_promosi,0)-ifnull(retur,0))/targetbulanini *100 persenbulanini,'
        + ' riilsdbulanini/targetsdbulanini*100 persensdbulanini ,'
        + ' (select '
        + ' sum((100-fpd_discpr)*(fpd_harga*fpd_qty)/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) - '
        + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) - '
        + ' sum(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+sum(fpd_bp_rp*fpd_qty) Nilai '
        + ' from tfp_dtl inner join tfp_hdr on fp_nomor=fpd_fp_nomor '
        + ' inner join tdo_hdr on do_nomor=fp_do_nomor '
        + ' inner join tso_hdr on so_nomor =do_so_nomor '
        + ' inner join tbarang on brg_kode=fpd_brg_kode '
        + ' and month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ edtTahun.Text
        + ' and brg_isproductfocus=1 where so_sls_kode=final.sls_kode)/1000 PF '
        + '  from ('
        + '  select sls_kode,sls_nama salesman,ifnull(st_targetsales,0)/1000 targetbulanini,'
        + '  (select ifnull(sum(st_targetsales),0)/1000 from tsalesmantarget where st_sls_kode=sls_kode and st_periode<= '+ IntToStr(cbbBulan.itemindex +1)+' and st_tahun='+ edtTahun.Text+') targetsdbulanini,'
        + '  sum(fp_amount)/1000 Realisasi ,'
        + '  sum((fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp)/1000 Biaya_promosi ,'
        + '  sum(fp_cn)/1000 Kontrak ,'
        + '  (select sum(ifnull(retj_amount,0))/1000 from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
        + '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
        + '  where so_sls_kode = z.sls_kode  and month(retj_tanggal)=month(zzz.fp_tanggal) and year(retj_tanggal)=year(zzz.fp_tanggal)'
        + '  group by so_sls_kode) Retur,'
        + '  (select IFNULL(realisasi,0)- IFNULL(kontrak,0)- IFNULL(biaya_promosi,0)- IFNULL(retur,0) from'
        + '  (select sls_kode,'
        + '  sum(fp_amount)/1000 Realisasi ,'
        + '  sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp)/1000 Biaya_promosi ,'
        + '  sum(fp_cn)/1000 Kontrak ,'
        + '  (select sum(ifnull(retj_amount,0))/1000 from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
        + '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
        + '  where so_sls_kode = z2.sls_kode  and month(retj_tanggal)<=' + IntToStr(cbbBulan.itemindex +1) + ' and year(retj_tanggal)='+ edtTahun.Text
        + '  group by so_sls_kode) Retur'
        + '  fROM tfp_hdr zzz2 inner join tdo_hdr  on fp_do_nomor=do_nomor'
        + '  inner join tso_hdr zz2 on so_nomor=do_so_nomor'
        + '  right join tsalesman z2 on sls_kode=so_sls_kode'
        + '  where  year(fP_tanggal)='+ edtTahun.Text+' and month(fp_tanggal) <= '+ IntToStr(cbbBulan.itemindex +1)
        + '  group by so_sls_kode,year(fp_tanggal)) sdbulanini where sls_kode=z.sls_kode) riilsdbulanini'
        + '  fROM tfp_hdr zzz inner join tdo_hdr  on fp_do_nomor=do_nomor'
        + ' inner join tso_hdr zz on so_nomor=do_so_nomor'
        + '  right join tsalesman z on sls_kode=so_sls_kode'
        + '  left join tsalesmantarget x on z.sls_kode=x.st_sls_Kode and st_tahun='+ edtTahun.Text+' and st_periode='+ IntToStr(cbbBulan.itemindex +1)
        + '  where month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ edtTahun.Text
        + '  group by so_sls_kode,month(fp_tanggal),year(fp_tanggal)'
        + '  ) final where salesman NOT IN  ("KONTRAK","ONLINE","SEWA","KANTOR" ,"INTERNAL" ) order by riilsdbulanini desc';

        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;
//        ds3.Active := True;
        ds3.First;
        with ds3 do
        begin
          while not eof do
          begin
            If ds3.State <> dsEdit then ds3.Edit;
               ds3.FieldByName('pfratio').AsFloat := ds3.FieldByName('pf').AsFloat/ds3.FieldByName('targetbulanini').AsFloat*100;
            Next;
          end;
        end;

           ssql:= ' select *,'
        + '  (select sum(st_targetsales) target from tsalesmantarget where st_sls_kode=sls_kode '
        + '  and st_tahun='+edttahun.Text + ') Target '
        + '  ,ifnull(realisasi,0)-ifnull(kontrak,0)-ifnull(biaya_promosi,0)-ifnull(retur,0) riilbulanini,'
        + '  (ifnull(realisasi,0)-ifnull(kontrak,0)-ifnull(biaya_promosi,0)-ifnull(retur,0))/targetbulanini *100 persenbulanini,'
        + '  riilsdbulanini/targetsdbulanini*100 persensdbulanini ,'
        + '  (select '
        + ' sum((100-fpd_discpr)*(fpd_harga*fpd_qty)/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) - '
        + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) - '
        + ' sum(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+sum(fpd_bp_rp*fpd_qty) Nilai '
        + '  from tfp_dtl inner join tfp_hdr on fp_nomor=fpd_fp_nomor '
        + '  inner join tdo_hdr on do_nomor=fp_do_nomor '
        + '  inner join tso_hdr on so_nomor =do_so_nomor '
        + '  inner join tbarang on brg_kode=fpd_brg_kode '
        + '  and month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ edtTahun.Text
        + '  and brg_isproductfocus=1 where so_sls_kode=final.sls_kode) PF '
        + '  from ('
        + '  select sls_kode,sls_nama salesman,ifnull(st_targetsales,0) targetbulanini,'
        + '  (select ifnull(sum(st_targetsales),0) from tsalesmantarget where st_sls_kode=sls_kode and st_periode<= '+ IntToStr(cbbBulan.itemindex +1)+' and st_tahun='+ edtTahun.Text+') targetsdbulanini,'
        + '  sum(fp_amount) Realisasi ,'
        + '  sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp) Biaya_promosi ,'
        + '  sum(fp_cn) Kontrak ,'
        + '  (select sum(ifnull(retj_amount,0)) from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
        + '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
        + '  where so_sls_kode = z.sls_kode  and month(retj_tanggal)=month(zzz.fp_tanggal) and year(retj_tanggal)=year(zzz.fp_tanggal)'
        + '  group by so_sls_kode) Retur,'
        + '  (select IFNULL(realisasi,0)- IFNULL(kontrak,0)- IFNULL(biaya_promosi,0)- IFNULL(retur,0) from'
        + '  (select sls_kode,'
        + '  sum(fp_amount) Realisasi ,'
        + '  sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp) Biaya_promosi ,'
        + '  sum(fp_cn) Kontrak ,'
        + '  (select sum(ifnull(retj_amount,0)) from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
        + '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
        + '  where so_sls_kode = z2.sls_kode  and month(retj_tanggal)<=' + IntToStr(cbbBulan.itemindex +1) + ' and year(retj_tanggal)='+ inttostr(strtoint(edtTahun.Text)-1)
        + '  group by so_sls_kode) Retur'
        + '  fROM  tfp_hdr zzz2 inner join tdo_hdr  on fp_do_nomor=do_nomor'
        + '  inner join tso_hdr zz2 on so_nomor=do_so_nomor'
        + '  right join tsalesman z2 on sls_kode=so_sls_kode'
        + '  where  year(fP_tanggal)='+ inttostr(strtoint(edtTahun.Text)-1)+' and month(fp_tanggal) <= '+ IntToStr(cbbBulan.itemindex +1)
        + '  group by so_sls_kode,year(fp_tanggal)) sdbulanini where sls_kode=z.sls_kode) riilsdbulanini'
        + '  fROM tfp_hdr zzz inner join tdo_hdr  on fp_do_nomor=do_nomor'
        + '  inner join tso_hdr zz on so_nomor=do_so_nomor'
        + '  right join tsalesman z on sls_kode=so_sls_kode'
        + '  left join tsalesmantarget x on z.sls_kode=x.st_sls_Kode and st_tahun='+ edtTahun.Text+' and st_periode='+ IntToStr(cbbBulan.itemindex +1)
        + '  where month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ inttostr(strtoint(edtTahun.Text)-1)
        + '  group by so_sls_kode,month(fp_tanggal),year(fp_tanggal)'
        + '  ) final where salesman NOT IN  ("KONTRAK","ONLINE","SEWA","KANTOR" ,"INTERNAL" ) order by riilsdbulanini desc';
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin

             if ds3.Locate('salesman',FieldByName('salesman').AsString,[loCaseInsensitive]) then
             begin

               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('riilbulaninilalu').AsFloat := FieldByName('riilbulanini').AsFloat/1000;
                ds3.FieldByName('riilsdbulaniniLalu').AsFloat := FieldByName('riilsdbulanini').AsFloat/1000;
                if FieldByName('riilbulanini').AsFloat > 0 then
                ds3.FieldByName('growth').AsFloat :=ds3.FieldByName('riilbulanini').AsFloat/(FieldByName('riilbulanini').AsFloat/1000)*100;
                if FieldByName('riilsdbulanini').AsFloat > 0 then
                ds3.FieldByName('growth2').AsFloat :=ds3.FieldByName('riilsdbulanini').AsFloat/(FieldByName('riilsdbulanini').AsFloat/1000)*100;
                ds3.FieldByName('targettahunan').AsFloat := 0;
                ds3.FieldByName('ratio').AsFloat := 0;
                ds3.FieldByName('targettahunan').AsFloat := 0;
                ds3.FieldByName('ratio').AsFloat := 0;
                ds3.FieldByName('targetpiutang').AsFloat := 0;
                ds3.FieldByName('realisasipiutang').AsFloat := 0;
                ds3.FieldByName('ratiopiutang').AsFloat := 0;
                ds3.FieldByName('pfratio').AsFloat := ds3.FieldByName('pf').AsFloat/ds3.FieldByName('targetbulanini').AsFloat*100


             end
             else
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.Append;
                ds3.FieldByName('sls_kode').AsString :=FieldByName('sls_kode').AsString;
                ds3.FieldByName('salesman').AsString :=FieldByName('salesman').AsString;
                ds3.FieldByName('TargetBulanini').asfloat := 0;
                ds3.FieldByName('Targetsdbulanini').asfloat := 0;
                ds3.FieldByName('riilbulanini').AsFloat := 0;
                ds3.FieldByName('riilsdbulanini').AsFloat := 0;
                ds3.FieldByName('riilbulaninilalu').AsFloat := FieldByName('riilbulanini').AsFloat/1000;
                ds3.FieldByName('growth').AsFloat :=0;
                ds3.FieldByName('riilsdbulaniniLalu').AsFloat := FieldByName('riilsdbulanini').AsFloat/1000;
                ds3.FieldByName('growth2').AsFloat :=0;
                ds3.FieldByName('targettahunan').AsFloat := 0;
                ds3.FieldByName('ratio').AsFloat := 0;
                ds3.FieldByName('targetpiutang').AsFloat := 0;
                ds3.FieldByName('realisasipiutang').AsFloat := 0;
                ds3.FieldByName('ratiopiutang').AsFloat := 0;
                ds3.FieldByName('pfratio').AsFloat := 0;
                ds3.Post;
             end;
              Next;
            end;
          finally
            free;
          end;
        end;
        // retur pf jika ada
        ssql := 'SELECT so_sls_kode,sls_nama salesman ,'
            + ' SUM((100-ifnull(retjd_discpr,0))*(ifnull(retjd_harga,0)*ifnull(retjd_qty,0))/100*if(retj_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) nilai'
            + ' FROM tretj_dtl INNER JOIN tretj_hdr ON retj_nomor=retjd_retj_nomor'
            + ' INNER JOIN tfp_hdr ON fp_nomor=retj_fp_nomor'
            + ' INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
            + ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
            + ' inner join tsalesman on sls_kode=so_sls_kode'
            + ' INNER JOIN tbarang ON brg_Kode=retjd_brg_kode'
            + ' WHERE brg_isproductfocus=1'
            + ' and month(retj_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(retj_tanggal)='+ edtTahun.Text
            + ' GROUP BY so_sls_kode ';
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin

             if ds3.Locate('salesman',FieldByName('salesman').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('pf').AsFloat := ds3.FieldByName('pf').AsFloat - (FieldByName('nilai').AsFloat/1000);
                ds3.FieldByName('pfratio').AsFloat := ds3.FieldByName('pf').AsFloat/ds3.FieldByName('targetbulanini').AsFloat*100;
                ds3.Post;
             end;
             Next
           end;
         finally
            free;
         end;
       end;
        ssql := 'select st_sls_kode,sls_nama salesman,sum(st_targetsales) target from tsalesmantarget inner join tsalesman on sls_kode=st_sls_kode '
              + ' where st_tahun='+edttahun.Text
              + ' group by st_sls_kode' ;
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin

             if ds3.Locate('salesman',FieldByName('salesman').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('targettahunan').AsFloat := FieldByName('target').AsFloat/1000;
                ds3.FieldByName('ratio').AsFloat := ds3.FieldByName('riilsdbulanini').AsFloat/(FieldByName('target').AsFloat/1000)*100;
                ds3.Post;
             end;
//             else
//             begin
//                 If ds3.State <> dsEdit then ds3.Edit;
//                    ds3.FieldByName('targettahunan').AsFloat := 0;
//                    ds3.FieldByName('ratio').AsFloat := 0;
//             end;

//             totaltarget := totaltarget +(FieldByName('target').AsFloat/1000);
             Next;
             end;
           finally
            free;
          end;
        end;
        ssql := 'SELECT sls_nama salesman,sum(piutang-IFNULL(bayar,0)-retur) sisa FROM ( '
          + ' SELECT so_sls_kode,fp_amount piutang,fp_bayar,(select IFNULL(SUM(IFNULL(bycd_bayar,0)),0)  FROM tbayarcus_dtl'
          + ' inner join tbayarcus_hdr on byc_nomor=bycd_byc_nomor'
          + ' WHERE byc_tanggal <= '+quotd(akhir)+' AND  bycd_fp_nomor=fp_nomor  GROUP BY bycd_fp_nomor) bayar,'
          + ' (SELECT ifnull(sum(retj_amount),0) FROM tretj_hdr WHERE retj_fp_nomor=fp_nomor) retur'
          + ' from tfp_hdr INNER JOIN tdo_hdr ON do_nomor=fp_do_nomor'
          + ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
          + ' WHERE fp_jthtempo <= '+ quotd(akhir2)  // + ' AND fp_tanggal <= '+ quotd(akhir)
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
             if ds3.Locate('salesman',FieldByName('salesman').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('targetpiutang').AsFloat := FieldByName('sisa').AsFloat/1000;
                ds3.Post;
             end;

//             totaltarget := totaltarget +(FieldByName('target').AsFloat/1000);
             Next;
             end;
           finally
            free;
          end;
        end;

        ssql:= 'select sls_nama Salesman,'
            + ' (ifnull(tunai2,0)) Target_Piutang,'
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
            + ' ifnull((select sum(retur) from retur inner join tfp_hdr on fp_nomor=retj_fp_nomor where fp_jthtempo <= '+quotd(akhir)+'  and salesman=a.salesman and tanggal <= '+quotd(akhir)+'),0) piutang,'
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
            + ' where fp_jthtempo <= '+quotd(akhir2) //' + and  tanggal <= '+quotd(akhir)
            + ' group by salesman) a inner join tsalesman on a.salesman=sls_kode';

        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin
   //          showmessage(FieldByName('salesman').AsString);
             if ds3.Locate('salesman',FieldByName('salesman').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('targetpiutang').AsFloat := ds3.FieldByName('targetpiutang').AsFloat+(FieldByName('target_piutang').AsFloat/1000);
                ds3.FieldByName('realisasipiutang').AsFloat := FieldByName('realisasi').AsFloat/1000;
                ds3.FieldByName('ratiopiutang').AsFloat := ds3.FieldByName('realisasipiutang').AsFloat / ds3.FieldByName('targetpiutang').AsFloat * 100;
                ds3.Post;
             end;

//             totaltarget := totaltarget +(FieldByName('target').AsFloat/1000);
             Next;
             end;
           finally
            free;
          end;
        end;

        

end;

procedure TfrmLapBulanan3.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1Column10CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.font.Color := clpurple
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];
end;

procedure
    TfrmLapBulanan3.cxGrid1DBBandedTableView1Column10CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.font.Color := clpurple
    else
      ACanvas.font.Color := clgreen;
      ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan3.growthCustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 100 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure
    TfrmLapBulanan3.growthCustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 100 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1Column8CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.Font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.Font.Color := clpurple
    else
      ACanvas.Font.Color := clGreen;
       ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 70 then
      ACanvas.Font.Color := clRed
    else if StrToFloatDef(AViewInfo.Text,0) < 100 then
        ACanvas.Font.Color := clpurple
    else
      ACanvas.Font.Color := clGreen;
       ACanvas.Font.Style := [fsbold];
end;

procedure
    TfrmLapBulanan3.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems12GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulaninilalu')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulaninilalu'))*100;
    AText := FormatFloat('###.##',capaibulanini);


  except
  end;
end;

procedure
    TfrmLapBulanan3.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems14GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulaninilalu')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulaninilalu'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmLapBulanan3.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapBulanan3.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetsdbulanini')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetsdbulanini'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems9GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetbulanini')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targetbulanini'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmLapBulanan3.growth2CustomDrawCell(Sender: TcxCustomGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone:
    Boolean);
begin

  if StrToFloatDef(AViewInfo.Text,0) < 100 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan3.growth2CustomDrawFooterCell(Sender: TcxGridTableView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridColumnHeaderViewInfo; var ADone:
    Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 100 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];
end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems16GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Targettahunan')) > 0  then
        capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('riilsdbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('targettahunan'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;


procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1Column19CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];

end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1Column19CustomDrawFooterCell(
  Sender: TcxGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin

  if StrToFloatDef(AViewInfo.Text,0) < 70 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];

end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1Column21CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 20 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];


end;

procedure
    TfrmLapBulanan3.cxGrid1DBBandedTableView1Column21CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(AViewInfo.Text,0) < 20 then
  begin
      ACanvas.Font.Color := clRed;

  end
    else
      ACanvas.Font.Color := clGreen;
        ACanvas.Font.Style := [fsbold];


end;

procedure TfrmLapBulanan3.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems19GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasipiutang')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('realisasipiutang'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('targetpiutang'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure
    TfrmLapBulanan3.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems21GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('pf')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('pf'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('TargetBulanini'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

end.
