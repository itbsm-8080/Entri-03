unit ufrmLapBiayaBulanan;

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
  cxCurrencyEdit, cxGridDBBandedTableView, dxPScxGrid6Lnk, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, AdvEdit, MyAccess, MemDS, DBAccess;

type
  TfrmLapBiayaBulanan = class(TForm)
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
    Label3: TLabel;
    cxExtLookupCabang: TcxExtLookupComboBox;
    TePanel6: TTePanel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    edtbulaninilalu: TAdvEdit;
    edtbulaninilaluratio: TAdvEdit;
    edtbulanini: TAdvEdit;
    edtbulaniniratio: TAdvEdit;
    edtsdbulaninilalu: TAdvEdit;
    edtsdbulaninilaluratio: TAdvEdit;
    edtsdbulanini: TAdvEdit;
    edtsdbulaniniratio: TAdvEdit;
    Label7: TLabel;
    edtLabaBersih: TAdvEdit;
    sqlqry1: TMyQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure cxGrid1DBBandedTableView1Column10CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column10CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column13CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column13CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawCell(Sender:
        TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(Sender:
        TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
        TcxGridColumnHeaderViewInfo; var ADone: Boolean);
    procedure
        cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems11GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);

  private
    FCDSPabrik: TClientDataset;
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
    function GetCDSPabrik: TClientDataset;
    function GetPivotChartLink: TcxPivotGridChartConnection;
  public

    procedure loaddata;
    procedure refreshdata;
    property CDSPabrik: TClientDataset read GetCDSPabrik write FCDSPabrik;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmLapBiayaBulanan: TfrmLapBiayaBulanan;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmLapBiayaBulanan.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxExtLookupCabang.Properties) do
    LoadFromCDS(CDSPabrik, 'Kode','Nama',['Kode'],Self);

end;

procedure TfrmLapBiayaBulanan.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapBiayaBulanan.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapBiayaBulanan.refreshdata;
begin
  cxExtLookupCabang.EditValue := '00';
  edttahun.text :=  FormatDateTime('yyyy',Date);
end;

procedure TfrmLapBiayaBulanan.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmLapBiayaBulanan.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;





procedure TfrmLapBiayaBulanan.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmLapBiayaBulanan.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapBiayaBulanan.loaddata;
var
  ssql:string;
  capaibulanini : double;
  tsql : TMyQuery;
  sfilter3,sfilter2,sfilter : string;
  abulaninilalu,abulanini,asdbulaninilalu,asdbulanini : double;
  abulaninilaluratio,abulaniniratio,asdbulaninilaluratio,asdbulaniniratio : double;
begin
if cxExtLookupCabang.EditValue = '00' then
begin
ssql:=' select rek_nama Keterangan,cast(0 as decimal) bulaninilalu,cast(0 as decimal) bulanini,cast(0 as decimal(5,2)) ratio,'
    + ' cast(0 as decimal) sdbulaninilalu,cast(0 as decimal) sdbulanini,cast(0 as decimal(10,2)) ratio2 from trekening where rek_kol_id in (13,12) '
    + ' order  by rek_nama';
sfilter := '';
sfilter2 := '';

end
else
begin
ssql := 'select distinct rek_nama Keterangan ,'
    + ' cast(0 as decimal) bulaninilalu,cast(0 as decimal) bulanini,cast(0 as decimal(5,2)) ratio,'
    + ' cast(0 as decimal) sdbulaninilalu,cast(0 as decimal) sdbulanini,cast(0 as decimal(10,2)) ratio2 '
    + ' from tjurnalitem '
	  + ' inner join tcostcenter on jurd_cc_kode=cc_kode '
    + ' and cc_cabang='+Quot(cxExtLookupCabang.EditValue)
    + ' inner join trekening on rek_kode=jurd_rek_kode and rek_kol_id in (12,13)';
sfilter := ' inner join tcostcenter on cc_kode=cc and cc_cabang= '+Quot(cxExtLookupCabang.EditValue);
sfilter2 := 'jurd_jur_no like "'+cxExtLookupCabang.EditValue+'%" and ';
end;
if ComboBox1.Text = 'Omzet' then
  sfilter3 := 'rek_nama in ("PENJUALAN BARANG","POTONGAN PENJUALAN","RETUR PENJUALAN","BIAYA SAMPLE")'
else if ComboBox1.Text = 'Hpp' then
  sfilter3 := 'rek_nama in ("BPP","POTONGAN PEMBELIAN")'
else
  sfilter3 := 'rek_nama in ("PENJUALAN BARANG","POTONGAN PENJUALAN","RETUR PENJUALAN","BPP","POTONGAN PEMBELIAN","BIAYA SAMPLE")';


            ds3.Close;
            sqlqry1.Connection := frmMenu.conn;
            sqlqry1.SQL.Text := ssql;
            ds3.open;
 // tahun lalu
 ssql := 'SELECT accountName Keterangan,sum(DEBET-KREDIT) nilai from alljurnal '
         + ' inner join trekening on rek_kode=account '
         + ' inner join tkelompok on kol_id=rek_kol_id'
         + sfilter
         + ' where month(tanggal)='+IntToStr(cbbBulan.ItemIndex+1)
         + ' and year(tanggal)='+IntToStr(StrToInt(edttahun.Text)-1)
         + ' and kol_id in (13,12)'
         + ' GROUP BY accountName '
         + ' order by rek_urutan';
          tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin
             if ds3.Locate('keterangan',FieldByName('keterangan').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('bulaninilalu').AsFloat := FieldByName('nilai').AsFloat;
             end;
              Next;
            end;
          finally
            free;
          end;
        end;
// tahun ini
 ssql := ' SELECT accountName Keterangan,sum(DEBET-KREDIT) nilai from alljurnal '
         + ' inner join trekening on rek_kode=account '
         + ' inner join tkelompok on kol_id=rek_kol_id'
         + sfilter
         + ' where month(tanggal)='+IntToStr(cbbBulan.ItemIndex+1)
         + ' and year(tanggal)='+IntToStr(StrToInt(edttahun.Text))
         + ' and kol_id in (13,12)'
         + ' GROUP BY accountName '
         + ' order by rek_urutan';

        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin
             if ds3.Locate('keterangan',FieldByName('keterangan').AsString,[loCaseInsensitive]) then
             begin

               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('bulanini').AsFloat := FieldByName('nilai').AsFloat;
                if ds3.FieldByName('bulaninilalu').AsFloat > 0 then
                ds3.FieldByName('ratio').AsFloat := FieldByName('nilai').AsFloat/ds3.FieldByName('bulaninilalu').AsFloat*100;

             end;
              Next;
            end;
          finally
            free;
          end;
        end;

 // tahun lalu
 ssql := 'SELECT accountName Keterangan,sum(DEBET-KREDIT) nilai from alljurnal '
         + ' inner join trekening on rek_kode=account '
         + ' inner join tkelompok on kol_id=rek_kol_id'
         + sfilter
         + ' where month(tanggal)<='+IntToStr(cbbBulan.ItemIndex+1)
         + ' and year(tanggal)='+IntToStr(StrToInt(edttahun.Text)-1)
         + ' and kol_id in (13,12)'
         + ' GROUP BY accountName '
         + ' order by rek_urutan';
          tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin
             if ds3.Locate('keterangan',FieldByName('keterangan').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('sdbulaninilalu').AsFloat := FieldByName('nilai').AsFloat;
             end;
              Next;
            end;
          finally
            free;
          end;
        end;
// tahun ini
 ssql := ' SELECT accountName Keterangan,sum(DEBET-KREDIT) nilai from alljurnal '
         + ' inner join trekening on rek_kode=account '
         + ' inner join tkelompok on kol_id=rek_kol_id'
         + sfilter
         + ' where month(tanggal) <= '+IntToStr(cbbBulan.ItemIndex+1)
         + ' and year(tanggal)='+IntToStr(StrToInt(edttahun.Text))
         + ' and kol_id in (13,12)'
         + ' GROUP BY accountName '
         + ' order by rek_urutan';

        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin
             if ds3.Locate('keterangan',FieldByName('keterangan').AsString,[loCaseInsensitive]) then
             begin
               If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('sdbulanini').AsFloat := FieldByName('nilai').AsFloat;
                if ds3.FieldByName('sdbulaninilalu').AsFloat > 0 then
                ds3.FieldByName('ratio2').AsFloat := FieldByName('nilai').AsFloat/ds3.FieldByName('sdbulaninilalu').AsFloat*100;
                ds3.post;
             end;
              Next;
            end;
          finally
            free;
          end;
        end;
        ds3.First;
        while not ds3.Eof do
        begin
          if (ds3.FieldByName('sdbulanini').AsFloat+ds3.FieldByName('sdbulaninilalu').AsFloat) = 0 then
          begin
                  If ds3.State <> dsEdit then ds3.Edit;
                  ds3.Delete;
          end;
          ds3.Next;
        end;
// if omzet
      ssql := 'select  sum(jurd_kredit-jurd_debet) Nilai from tjurnalitem inner join tjurnal on jur_no=jurd_jur_no '
      + ' inner join trekening on rek_kode=jurd_rek_kode '
      + ' where ' + sfilter2 //(jurd_jur_no like "%FP%" or jurd_jur_no like "%RETJ%") and  '
      + ' year(jur_tanggal)='+ IntToStr(StrToInt(edttahun.Text)-1)
      + ' and month(jur_tanggal)='+IntToStr(cbbBulan.ItemIndex+1)
      + ' and '+Sfilter3;
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try


            abulaninilalu :=Fields[0].asfloat;
            if ComboBox1.Text = 'Hpp' then
            abulaninilalu := abulaninilalu *-1;
            edtbulaninilalu.Text := formatfloat('###,###,###,###',abulaninilalu);
            IF abulaninilalu = 0 then
              abulaninilaluratio := 0
            else
            abulaninilaluratio := cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('bulaninilalu'))/abulaninilalu*100;
            edtbulaninilaluratio.Text :=formatfloat('###.##',abulaninilaluratio);
          finally
            free;
          end;
        end;
      ssql := 'select  sum(jurd_kredit-jurd_debet) Nilai from tjurnalitem inner join tjurnal on jur_no=jurd_jur_no '
      + ' inner join trekening on rek_kode=jurd_rek_kode '
      + ' where ' + sfilter2 //(jurd_jur_no like "%FP%" or jurd_jur_no like "%RETJ%") and  '
      + ' year(jur_tanggal)='+ IntToStr(StrToInt(edttahun.Text))
      + ' and month(jur_tanggal)='+IntToStr(cbbBulan.ItemIndex+1)
      + ' and '+Sfilter3;
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            abulanini :=Fields[0].asfloat;
            if ComboBox1.Text = 'Hpp' then
            abulanini := abulanini *-1;
            edtbulanini.Text := formatfloat('###,###,###,###',abulanini);
            abulaniniratio := cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('bulanini'))/abulanini*100;

            edtbulaniniratio.Text :=formatfloat('###.##',abulaniniratio);
            if ComboBox1.Text = 'Margin' then
            edtLabaBersih.Text := FormatFloat('###,###,###,###',abulanini- cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('bulanini')))
            else
            edtLabaBersih.Clear;

          finally
            free;
          end;
        end;

      ssql := 'select  sum(jurd_kredit-jurd_debet) Nilai from tjurnalitem inner join tjurnal on jur_no=jurd_jur_no '
      + ' inner join trekening on rek_kode=jurd_rek_kode '
      + ' where ' + sfilter2 //(jurd_jur_no like "%FP%" or jurd_jur_no like "%RETJ%") and  '
      + ' year(jur_tanggal)='+ IntToStr(StrToInt(edttahun.Text)-1)
      + ' and month(jur_tanggal)<='+IntToStr(cbbBulan.ItemIndex+1)
      + ' and '+Sfilter3;
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            asdbulaninilalu :=Fields[0].asfloat;
            if ComboBox1.Text = 'Hpp' then
            asdbulaninilalu := asdbulaninilalu *-1;
            edtsdbulaninilalu.Text := formatfloat('###,###,###,###',asdbulaninilalu);
            if asdbulaninilalu = 0 then
            asdbulaninilaluratio := 0
            else
            asdbulaninilaluratio := cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('sdbulaninilalu'))/asdbulaninilalu*100;
            edtsdbulaninilaluratio.Text :=formatfloat('###.##',asdbulaninilaluratio);
          finally
            free;
          end;
        end;
      ssql := 'select  sum(jurd_kredit-jurd_debet) Nilai from tjurnalitem inner join tjurnal on jur_no=jurd_jur_no '
      + ' inner join trekening on rek_kode=jurd_rek_kode '
      + ' where ' + sfilter2 //(jurd_jur_no like "%FP%" or jurd_jur_no like "%RETJ%") and  '
      + ' year(jur_tanggal)='+ IntToStr(StrToInt(edttahun.Text))
      + ' and month(jur_tanggal)<='+IntToStr(cbbBulan.ItemIndex+1)
      + ' and '+Sfilter3;
        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            asdbulanini :=Fields[0].asfloat;
            if ComboBox1.Text = 'Hpp' then
            asdbulanini := asdbulanini *-1;

            edtsdbulanini.Text := formatfloat('###,###,###,###',asdbulanini);
            asdbulaniniratio := cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('sdbulanini'))/asdbulanini*100;
            edtsdbulaniniratio.Text :=formatfloat('###.##',asdbulaniniratio);

          finally
            free;
          end;
        end;



end;

procedure TfrmLapBiayaBulanan.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmLapBiayaBulanan.ComboBox1Change(Sender: TObject);
begin
  label5.Caption := ComboBox1.Text;
end;

procedure TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1Column10CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
 if StrToFloatDef(StringReplace(AViewInfo.Text,',','',[rfReplaceAll]),0) > 100 then
      ACanvas.font.Color := clred
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];


end;

procedure TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1Column10CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
 if StrToFloatDef(StringReplace(AViewInfo.Text,',','',[rfReplaceAll]),0) > 100 then
      ACanvas.font.Color := clred
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];


end;

procedure TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1Column13CustomDrawCell(
    Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
 if StrToFloatDef(StringReplace(AViewInfo.Text,',','',[rfReplaceAll]),0) > 100 then
      ACanvas.font.Color := clred
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];

end;

procedure
    TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1Column13CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
 if StrToFloatDef(StringReplace(AViewInfo.Text,',','',[rfReplaceAll]),0) > 100 then
      ACanvas.font.Color := clred
    else
      ACanvas.font.Color := clgreen;
        ACanvas.font.Style := [fsbold];

end;

procedure TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1Column8CustomDrawCell(Sender:
    TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(StringReplace(AViewInfo.Text,',','',[rfReplaceAll]),0) < 100 then
      ACanvas.font.Color := clgreen
    else
      ACanvas.font.Color := clred;
        ACanvas.font.Style := [fsbold];


end;

procedure TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1Column8CustomDrawFooterCell(
    Sender: TcxGridTableView; ACanvas: TcxCanvas; AViewInfo:
    TcxGridColumnHeaderViewInfo; var ADone: Boolean);
begin
  if StrToFloatDef(StringReplace(AViewInfo.Text,',','',[rfReplaceAll]),0) < 100 then
      ACanvas.font.Color := clgreen
    else
      ACanvas.font.Color := clred;
        ACanvas.font.Style := [fsbold];

end;

procedure
    TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems11GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('BulanIniLalu')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('bulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('Bulaninilalu'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;


procedure TfrmLapBiayaBulanan.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapBiayaBulanan.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmLapBiayaBulanan.cxGrid1DBBandedTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems8GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('sdbulaninilalu')) > 0  then
            capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('sdbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1DBBandedTableView1).GetFooterSummary('sdbulaninilalu'))*100;
            
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

function TfrmLapBiayaBulanan.GetCDSPabrik: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSPabrik) then
  begin
    S := 'select cbg_nama as Nama, cbg_kode Kode'
        +' from tcabang';

    FCDSPabrik := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSPabrik;
end;

end.
