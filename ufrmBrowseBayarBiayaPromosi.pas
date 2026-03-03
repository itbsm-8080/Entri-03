unit ufrmBrowseBayarBiayaPromosi;

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
  TfrmBrowseBayarBiayaPromosi = class(TfrmCxBrowse)
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
  frmBrowseBayarBiayaPromosi: TfrmBrowseBayarBiayaPromosi;

implementation
   uses ufrmbayarbiayapromosi,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseBayarBiayaPromosi.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select byb_nomor Nomor,byb_tanggal Tanggal ,cus_nama  Customer, '
                  + ' (select distinct sls_nama from tbayarbp_dtl '
                  + ' inner join tfp_hdr on bybd_fp_nomor=fp_nomor '
                  + ' inner join tdo_hdr on do_nomor=fp_do_nomor '
                  + ' inner join tso_hdr on do_so_nomor=so_nomor '
                  + ' inner join tsalesman on sls_kode=so_sls_kode '
                  + ' where bybd_byb_nomor=a.byb_nomor limit 1) Salesman,'
                  + ' byb_nilai Nilai,'
                  + ' (select rek_nama from trekening where rek_kode=a.byb_rek_kode) Rekening, '
                  + ' byb_keterangan Keterangan '
                  + ' from Tbayarbp_hdr a'
                  + ' inner join tcustomer on cus_kode=byb_cus_kode'
                  + ' where byb_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);



  Self.SQLDetail := 'select byb_nomor Nomor,bybd_fp_nomor Invoice , fp_tanggal Tgl_Invoice,fp_jthtempo JthTempo,bybd_bayar Bayar'
                    + ' from Tbayarbp_dtl'
                    + ' inner join Tbayarbp_hdr on bybd_byb_nomor =byb_nomor'
                    + ' inner join tfp_hdr on bybd_fp_nomor=fp_nomor'
                    + ' where byb_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by byb_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=80;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=200;
    cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[5].Width :=80;
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;
    cxGrdMaster.Columns[6].Width :=200;

end;

procedure TfrmBrowseBayarBiayaPromosi.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBayarBiayaPromosi.cxButton2Click(Sender: TObject);
var
  frmbayarbiayapromosi: Tfrmbayarbiayapromosi;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pembayaran Biaya Promosi' then
   begin
      frmbayarbiayapromosi  := frmmenu.ShowForm(Tfrmbayarbiayapromosi) as Tfrmbayarbiayapromosi;
      if frmbayarbiayapromosi.FLAGEDIT =False then 
      frmbayarbiayapromosi.edtNomor.Text := frmbayarbiayapromosi.getmaxkode;
   end;
   frmbayarbiayapromosi.Show;
end;

procedure TfrmBrowseBayarBiayaPromosi.cxButton1Click(Sender: TObject);
var
  frmbayarbiayapromosi: Tfrmbayarbiayapromosi;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pembayaran Biaya Promosi' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmbayarbiayapromosi  := frmmenu.ShowForm(Tfrmbayarbiayapromosi) as Tfrmbayarbiayapromosi;
      frmbayarbiayapromosi.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmbayarbiayapromosi.FLAGEDIT := True;
      frmbayarbiayapromosi.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmbayarbiayapromosi.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmbayarbiayapromosi.Show;
end;

procedure TfrmBrowseBayarBiayaPromosi.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBayarBiayaPromosi.cxButton3Click(Sender: TObject);
begin
  inherited;
 frmbayarbiayapromosi.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
