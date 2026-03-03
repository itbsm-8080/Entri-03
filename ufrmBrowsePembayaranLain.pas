unit ufrmBrowsePembayaranLain;

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
  TfrmBrowsePembayaranLain = class(TfrmCxBrowse)
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
  frmBrowsePembayaranLain: TfrmBrowsePembayaranLain;

implementation
   uses ufrmPembayaranLain,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowsePembayaranLain.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := ' select jur_no Nomor,jur_tanggal Tanggal, jur_keterangan Keterangan,if(jur_isclosed =1,"Sudah","Belum") IsClosed, '
                  + ' sum(jurd_debet) Nilai '
                  + ' from tjurnal '
                  + ' inner join tjurnalitem on jurd_jur_no =jur_no'
                  + ' where jur_tipetransaksi='+quot('Pembayaran Lain')
                  + ' and jur_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by jur_no '
                  + ' order by jur_no ';

  Self.SQLDetail := 'select JUR_NO Nomor,JURD_REK_KODE Account,rek_nama AccountName, jurd_debet Debet,jurd_kredit Kredit,jurd_keterangan Keterangan,cc_nama CostCenter from tjurnal'
                    + ' inner join tjurnalitem on jur_no=jurd_jur_no'
                    + ' inner join trekening on rek_kode=jurd_rek_KODE'
                    + ' LEFT JOIN tcostcenter on cc_kode=jurd_cc_kode'
                    + ' where jur_tipetransaksi='+ quot('Pembayaran Lain')
                    + ' and jur_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by JUR_NO ,jurd_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=100;

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;
    cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';

end;

procedure TfrmBrowsePembayaranLain.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowsePembayaranLain.cxButton2Click(Sender: TObject);
var
  frmPembayaranLain: TfrmPembayaranLain;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pembayaran Lain lain' then
   begin
      frmPembayaranLain  := frmmenu.ShowForm(TfrmPembayaranLain) as TfrmPembayaranLain;
      if frmPembayaranLain.FLAGEDIT = False then
      frmPembayaranLain.edtNomor.Text := frmPembayaranLain.getmaxkode;
   end;
   frmPembayaranLain.Show;
end;

procedure TfrmBrowsePembayaranLain.cxButton1Click(Sender: TObject);
var
  frmPembayaranLain: TfrmPembayaranLain;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pembayaran Lain lain' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPembayaranLain  := frmmenu.ShowForm(TfrmPembayaranLain) as TfrmPembayaranLain;
      frmPembayaranLain.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmPembayaranLain.FLAGEDIT := True;
      frmPembayaranLain.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmPembayaranLain.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      if CDSMaster.FieldByname('IsClosed').AsString = 'Sudah' then
      begin
        ShowMessage('Transaksi ini sudah tutup Periode,Tidak dapat di edit');
        frmPembayaranLain.cxButton2.Enabled :=False;
        frmPembayaranLain.cxButton1.Enabled :=False;
      end;
   end;
   frmPembayaranLain.Show;
end;

procedure TfrmBrowsePembayaranLain.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowsePembayaranLain.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmPembayaranLain.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
