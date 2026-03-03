unit ufrmBrowseMintaBahan;

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
  TfrmBrowseMintaBahan = class(TfrmCxBrowse)
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
  frmBrowseMintaBahan: TfrmBrowseMintaBahan;

implementation
   uses ufrmMintaBahan,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseMintaBahan.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select mb_nomor Nomor,mb_tanggal Tanggal,mb_keterangan Keterangan,mb_spk_nomor SPK,'
                  + ' spk_nama Nama,gdg_nama Gudang '
                  + ' from tmintabahan_hdr  a '
                  + ' inner join tspk b on a.mb_spk_nomor=b.spk_nomor'
                  + ' inner join  tgudang c on c.gdg_kode=a.mb_gdg_kode '
                  + ' where mb_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by mb_nomor ';

  Self.SQLDetail := 'select mb_nomor Nomor,mbd_brg_kode Kode,brg_nama Nama,mbd_jumlah Jumlah,mbd_satuan Satuan'
                    + ' from tmintabahan_dtl'
                    + ' inner join tmintabahan_hdr on mb_nomor=mbd_mb_nomor'
                    + ' inner join tbarang on mbd_brg_kode=brg_kode'
                    + ' where mb_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by mb_nomor ';
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

procedure TfrmBrowseMintaBahan.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseMintaBahan.cxButton2Click(Sender: TObject);
var
  frmmintabahan: Tfrmmintabahan;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Permintaan Bahan' then
   begin
      frmmintabahan  := frmmenu.ShowForm(Tfrmmintabahan) as Tfrmmintabahan;
      if frmmintabahan.FLAGEDIT = false then 
      frmmintabahan.edtNomor.Text := frmmintabahan.getmaxkode;
   end;
   frmmintabahan.Show;
end;

procedure TfrmBrowseMintaBahan.cxButton1Click(Sender: TObject);
var
  frmmintabahan: Tfrmmintabahan;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Mutasi Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmmintabahan  := frmmenu.ShowForm(Tfrmmintabahan) as Tfrmmintabahan;
      frmmintabahan.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmmintabahan.FLAGEDIT := True;
      frmmintabahan.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmmintabahan.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmmintabahan.Show;
end;
procedure TfrmBrowseMintaBahan.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseMintaBahan.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmmintabahan.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
