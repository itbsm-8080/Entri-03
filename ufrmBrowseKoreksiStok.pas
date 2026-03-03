unit ufrmBrowseKoreksiStok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseKoreksiStok = class(TfrmCxBrowse)
    cxButton5: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseKoreksiStok: TfrmBrowseKoreksiStok;

implementation
   uses ufrmKoreksiStok,ufrmKoreksiStok2,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseKoreksiStok.btnRefreshClick(Sender: TObject);
var
  afieldnilai2,afieldnilai:string;
begin
  if UpperCase(frmMenu.KDUSER)='FINANCE' then
  begin
     afieldnilai :=',if (korh_notes="PRODUKSI",(SELECT kord_nilai FROM tkor_dtl WHERE kord_korh_nomor =korh_nomor AND kord_qty > 0 limit 1),0) Nilai_Produksi ';
     afieldnilai2 :=' ,kord_nilai Nilai';
  end
  else
  begin
     afieldnilai := '';
     afieldnilai2 := '';
  end;

  Self.SQLMaster := 'select korh_nomor Nomor,korh_Tanggal Tanggal ,b.gdg_nama Gudang,'
                  + ' korh_notes Keterangan,korh_total Total,korh_idbatch Idbatch,korh_expired Expired,korh_produksi Produksi,korh_memo Memo,'
                  + ' if (korh_notes="PRODUKSI",(SELECT kord_qty FROM tkor_dtl WHERE kord_korh_nomor =korh_nomor AND kord_qty > 0 limit 1),0) Qty_Produksi,user_create,date_create'
                  + afieldnilai
                  + ' from tkor_hdr  a '
                  + ' left join  tgudang b on b.gdg_kode=a.korh_gdg_kode '
                  + ' where korh_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by korh_nomor ,korh_tanggal ,korh_notes ';

  Self.SQLDetail := 'select korh_nomor Nomor,kord_brg_kode Kode , brg_nama Nama,kord_expired Expired,'
                    + ' kord_satuan Satuan,kord_qty QtyKorksi'
                    + afieldnilai2
                    + ' from tkor_dtl'
                    + ' inner join tkor_hdr on korh_nomor=kord_korh_nomor'
                    + ' inner join tbarang on kord_brg_kode=brg_kode'
                    + ' where korh_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by korh_nomor ,kord_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;
    cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';
    if UpperCase(frmMenu.KDUSER) ='FINANCE' then
    BEGIN
    cxGrdMaster.Columns[10].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[10].Summary.FooterFormat:='###,###,###,###';
    END;

end;

procedure TfrmBrowseKoreksiStok.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;


procedure TfrmBrowseKoreksiStok.cxButton2Click(Sender: TObject);
var
  frmKoreksiStok: TfrmKoreksiStok;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Koreksi Stok' then
   begin
      frmkoreksiStok  := frmmenu.ShowForm(TfrmKoreksiStok) as TfrmKoreksiStok;
      frmKoreksiStok.edtNomor.Text := frmKoreksiStok.getmaxkode;
   end;
   frmKoreksiStok.Show;
end;

procedure TfrmBrowseKoreksiStok.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseKoreksiStok.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmKoreksiStok.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseKoreksiStok.cxButton5Click(Sender: TObject);
var
  frmKoreksiStok2: TfrmKoreksiStok2;
begin
  inherited;
  if ActiveMDIChild.Caption <> 'Produksi' then
   begin
      frmkoreksiStok2  := frmmenu.ShowForm(TfrmKoreksiStok2) as TfrmKoreksiStok2;
      frmKoreksiStok2.edtNomor.Text := frmKoreksiStok2.getmaxkode;
   end;
   frmKoreksiStok2.Show;
end;

end.
