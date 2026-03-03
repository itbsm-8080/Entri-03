unit ufrmBrowseMusnah;

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
  TfrmBrowseMusnah = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseMusnah: TfrmBrowseMusnah;

implementation
   uses ufrmmusnah,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseMusnah.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select mus_nomor Nomor,mus_Tanggal Tanggal ,b.gdg_nama Gudang,'
                  + ' mus_notes Keterangan,mus_total Total'
                  + ' from tmus_hdr  a '
                  + ' inner join  tgudang b on b.gdg_kode=a.mus_gdg_kode '
                  + ' where mus_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by mus_nomor ,mus_tanggal ,mus_notes ';

  Self.SQLDetail := 'select mus_nomor Nomor,musd_brg_kode Kode , brg_nama Nama,musd_tgl_expired Expired,'
                    + ' musd_brg_satuan Satuan,musd_qty QtyMusnah,'
                    + ' musd_harga Harga'
                    + ' from tmus_dtl'
                    + ' inner join tmus_hdr on mus_nomor=musd_mus_nomor'
                    + ' inner join tbarang on musd_brg_kode=brg_kode'
                    + ' where mus_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by mus_nomor ,musd_nourut';
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

end;

procedure TfrmBrowseMusnah.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseMusnah.cxButton2Click(Sender: TObject);
var
  frmmusnah: Tfrmmusnah;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pemusnahan' then
   begin
      frmmusnah  := frmmenu.ShowForm(Tfrmmusnah) as Tfrmmusnah;
      if frmmusnah.FLAGEDIT =  False then
      frmmusnah.edtNomor.Text := frmmusnah.getmaxkode;
   end;
   frmmusnah.Show;
end;

procedure TfrmBrowseMusnah.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseMusnah.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmmusnah.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseMusnah.cxButton1Click(Sender: TObject);
var
  frmMusnah: TfrmMusnah;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pemusnahan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmMusnah  := frmmenu.ShowForm(TfrmMusnah) as TfrmMusnah;
      frmMusnah.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmMusnah.FLAGEDIT := True;
      frmMusnah.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmMusnah.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmMusnah.Show;
end;

end.
