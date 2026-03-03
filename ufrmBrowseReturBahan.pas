unit ufrmBrowseReturBahan;

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
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseReturBahan = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseReturBahan: TfrmBrowseReturBahan;

implementation
   uses ufrmreturbahan,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseReturBahan.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select retb_nomor Nomor,retb_tanggal Tanggal,retb_keterangan Keterangan,retb_spk_nomor SPK,'
                  + ' spk_nama Nama,gdg_nama Gudang '
                  + ' from treturbahan_hdr  a '
                  + ' inner join tspk b on a.retb_spk_nomor=b.spk_nomor'
                  + ' inner join  tgudang c on c.gdg_kode=a.retb_gdg_kode '
                  + ' where retb_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by retb_nomor ';

  Self.SQLDetail := 'select retb_nomor Nomor,retbd_brg_kode Kode,brg_nama Nama,retbd_jumlah Jumlah,retbd_satuan Satuan'
                    + ' from treturbahan_dtl'
                    + ' inner join treturbahan_hdr on retb_nomor=retbd_retb_nomor'
                    + ' inner join tbarang on retbd_brg_kode=brg_kode'
                    + ' where retb_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by retb_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=200;
    cxGrdMaster.Columns[5].Width :=130;
   
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseReturBahan.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseReturBahan.cxButton2Click(Sender: TObject);
var
  frmreturbahan: Tfrmreturbahan;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Retur Bahan' then
   begin
      frmreturbahan  := frmmenu.ShowForm(Tfrmreturbahan) as Tfrmreturbahan;
      if frmreturbahan.FLAGEDIT = false then 
      frmreturbahan.edtNomor.Text := frmreturbahan.getmaxkode;
   end;
   frmreturbahan.Show;
end;

procedure TfrmBrowseReturBahan.cxButton1Click(Sender: TObject);
var
  frmreturbahan: Tfrmreturbahan;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Mutasi Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmreturbahan  := frmmenu.ShowForm(Tfrmreturbahan) as Tfrmreturbahan;
      frmreturbahan.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmreturbahan.FLAGEDIT := True;
      frmreturbahan.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmreturbahan.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
//      if CDSMaster.FieldByname('realisasi').AsString = 'Sudah' then
//      begin
//        ShowMessage('Transaksi ini sudah Realisasi,Tidak dapat di edit');
//        frmreturbahan.cxButton2.Enabled :=False;
//        frmreturbahan.cxButton1.Enabled :=False;
//      end;
   end;
   frmreturbahan.Show;
end;

procedure TfrmBrowseReturBahan.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseReturBahan.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmreturbahan.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
