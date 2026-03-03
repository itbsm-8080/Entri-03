unit ufrmBrowseSetingBiayaPromosi;

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
  TfrmBrowseSetingBiayaPromosi = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSetingBiayaPromosi: TfrmBrowseSetingBiayaPromosi;

implementation
   uses ufrmsetingbiayapromosi,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSetingBiayaPromosi.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select bph_nomor Nomor,bph_cus_kode Kode ,cus_nama Customer '
                  + 'from tbiayapromosi_hdr inner join tcustomer on cus_kode=bph_cus_kode ';

  Self.SQLDetail := 'select bpd_bph_nomor Nomor,bpd_brg_kode Kode,brg_nama Nama,ktg_nama Kategori,bpd_persen Persen,bpd_rupiah Rupiah'
                    + ' from Tbiayapromosi_dtl'
                    + ' inner join tbarang on brg_kode=bpd_brg_kode '
                    + ' inner join tkategori on ktg_kode=brg_ktg_kode '
                    + ' order by bpd_bph_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=80;
    cxGrdMaster.Columns[1].Width :=80;
    cxGrdMaster.Columns[2].Width :=200;


end;

procedure TfrmBrowseSetingBiayaPromosi.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSetingBiayaPromosi.cxButton2Click(Sender: TObject);
var
  frmsetingbiayapromosi: Tfrmsetingbiayapromosi;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pemsetingan Biaya Promosi' then
   begin
      frmsetingbiayapromosi  := frmmenu.ShowForm(Tfrmsetingbiayapromosi) as Tfrmsetingbiayapromosi;
      frmsetingbiayapromosi.edtNomor.Text := frmsetingbiayapromosi.getmaxkode;
   end;
   frmsetingbiayapromosi.Show;
end;

procedure TfrmBrowseSetingBiayaPromosi.cxButton1Click(Sender: TObject);
var
  frmsetingbiayapromosi: Tfrmsetingbiayapromosi;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pemsetingan Biaya Promosi' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmsetingbiayapromosi  := frmmenu.ShowForm(Tfrmsetingbiayapromosi) as Tfrmsetingbiayapromosi;
      frmsetingbiayapromosi.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmsetingbiayapromosi.FLAGEDIT := True;
      frmsetingbiayapromosi.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmsetingbiayapromosi.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmsetingbiayapromosi.Show;
end;

procedure TfrmBrowseSetingBiayaPromosi.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

end.
