unit ufrmLapYTD;

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
  cxCurrencyEdit, cxGridDBBandedTableView, cxTextEdit, dxPScxGrid6Lnk,
  MemDS, DBAccess, MyAccess;

type
  TfrmLapYTD = class(TForm)
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
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1DBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column2: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column3: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column4: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column5: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    Label2: TLabel;
    edtTahun: TComboBox;
    Label1: TLabel;
    cbbBulan: TAdvComboBox;
    cxGrid1DBBandedTableView1Column6: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column7: TcxGridDBBandedColumn;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure TeSpeedButton1Click(Sender: TObject);

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

  frmLapYTD: TfrmLapYTD;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmLapYTD.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapYTD.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapYTD.refreshdata;
begin
  edttahun.text :=  FormatDateTime('yyyy',Date);
end;

procedure TfrmLapYTD.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmLapYTD.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;
procedure TfrmLapYTD.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmLapYTD.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapYTD.loaddata;
var
  ssql:string;
  capaibulanini : double;
begin
ssql:= ' seLECT st_tahun Tahun,case st_periode when 1 then "Januari" when 2 then "Februari" when 3 then "Maret" '
+ '  when 4 then "April" when 5 then "Mei" when 6 then "Juni" when 7 then "Juli" when 8 then "Agustus" when 9 then "September" '
+ '  when 10 then "Oktober" when 11 then "November" '
+ '  else "Desember" end Bulan,'
+ '  target,pencapaian,pencapaian/target*100 presentase,PencapaianLalu,pencapaian/pencapaianLalu*100 Growth FROM ('
+ '  select ST_TAHUN,st_periode,sum(st_targetsales) target,'
+ '  (SELECT realisasi-kontrak-biaya_promosi-retur riil FROM ('
+ '  select month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,sum(fp_amount) Realisasi ,  sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp) Biaya_promosi ,  sum(fp_cn) Kontrak ,'
+ '  (select ifnull(sum(ifnull(retj_amount,0)),0) from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
+ '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
+ '  inner join tsalesman on sls_kode=so_sls_kode'
+ '  where year(retj_tanggal)=year(zzz.fp_tanggal) and month(retj_tanggal)=month(zzz.fp_tanggal) and sls_nama NOT IN  ("KANTOR" ,"INTERNAL" )) Retur'
+ '  fROM TFP_hdr zzz inner join tdo_hdr  on fp_do_nomor=do_nomor'
+ '  inner join tso_hdr zz on so_nomor=do_so_nomor  right join tsalesman z on sls_kode=so_sls_kode'
+ '  where sls_nama  NOT IN  ("KANTOR" ,"INTERNAL" )'
+ '  group by month(fp_tanggal),year(fp_tanggal)  ) A where Bulan=st_periode and Tahun=st_tahun)   pencapaian,'
+ '  (SELECT realisasi-kontrak-biaya_promosi-retur riil FROM ('
+ '  select month(fp_tanggal) Bulan,year(fp_tanggal) Tahun,sum(fp_amount) Realisasi ,  sum((Fp_biayapr*(fp_amount-fp_taxamount)/100) + fp_biayarp) Biaya_promosi ,  sum(fp_cn) Kontrak ,'
+ '  (select ifnull(sum(ifnull(retj_amount,0)),0) from tretj_hdr inner join tfp_hdr on retj_fp_nomor=fp_nomor'
+ '  inner join tdo_hdr on do_nomor=fp_do_nomor inner join tso_hdr on so_nomor=do_so_nomor'
+ '  inner join tsalesman on sls_kode=so_sls_kode'
+ '  where year(retj_tanggal)=year(zzz.fp_tanggal) and month(retj_tanggal)=month(zzz.fp_tanggal) and sls_nama NOT IN  ("KANTOR" ,"INTERNAL" )) Retur'
+ '  fROM TFP_hdr zzz inner join tdo_hdr  on fp_do_nomor=do_nomor'
+ '  inner join tso_hdr zz on so_nomor=do_so_nomor '
+ '  right join tsalesman z on sls_kode=so_sls_kode'
+ '  where sls_nama  NOT IN  ("KANTOR" ,"INTERNAL" ,"KONTRAK", "ONLINE")'
+ '  group by month(fp_tanggal),year(fp_tanggal)  ) A where Bulan=st_periode and Tahun=st_tahun-1)   pencapaianLalu'
+ '  from tsalesmantarget f'
+ '  where st_tahun='+edtTahun.Text+' and st_periode <= '+ IntToStr(cbbBulan.itemindex +1)
+ '  group by st_periode ) final';

        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;
//        capaibulanini := cVarToFloat(TcxDBGridHelper(cxGrid1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1).GetFooterSummary('targetbulanini'));
//TcxGridDBTableSummaryItem(cxGrid1).Column[0].Caption := '00';

end;

procedure TfrmLapYTD.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure
    TfrmLapYTD.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Target')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('pencapaian'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Target'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure
    TfrmLapYTD.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems4GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
    growth :double;
begin
  growth := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Pencapaianlalu')) > 0  then
            growth :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('pencapaian'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('pencapaianlalu'))*100;
    AText := FormatFloat('###.##',growth);
  except
  end;
end;


procedure TfrmLapYTD.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapYTD.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

end.
