unit ufrmBrowseBayarCustomer;

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
  TfrmBrowseBayarCustomer = class(TfrmCxBrowse)
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
  frmBrowseBayarCustomer: TfrmBrowseBayarCustomer;

implementation
   uses ufrmBayarcustomer,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseBayarCustomer.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select byc_nomor Nomor,byc_tanggal Tanggal ,if(byc_istax=1,"PPN","Non PPN") Status,cus_kode Kode_Cust,cus_nama  Customer, '
                  + ' (select distinct sls_nama from tbayarcus_dtl '
                  + ' inner join tfp_hdr on bycd_fp_nomor=fp_nomor '
                  + ' inner join tsalesman on sls_kode=fp_sls_kode '
                  + ' where bycd_byc_nomor=a.byc_nomor limit 1) Salesman,'
                  + ' byc_Cash Cash,byc_transfer Transfer ,BYC_POTOngan Potongan, byc_giro Giro,byc_nogiro GiroNumber,byc_tglcair TglCair,'
                  + ' (select rek_nama from trekening where rek_kode=a.byc_rek_cash) Rekening_Cash ,'
                  + ' (select rek_nama from trekening where rek_kode=a.byc_rek_transfer) Rekening_Transfer, '
                  + ' byc_ppn PPN, byc_pph PPH '
                  + ' from Tbayarcus_hdr a'
                  + ' inner join tcustomer on cus_kode=byc_cus_kode'
                  + ' where byc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);



  Self.SQLDetail := 'select byc_nomor Nomor,bycd_fp_nomor Invoice , fp_tanggal Tgl_Invoice,fp_jthtempo JthTempo,fp_amount Nilai,bycd_bayar Bayar'
                    + ' from Tbayarcus_dtl'
                    + ' inner join Tbayarcus_hdr on bycd_byc_nomor =byc_nomor'
                    + ' inner join tfp_hdr on bycd_fp_nomor=fp_nomor'
                    + ' where byc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by byc_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=80;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=200;
    cxGrdMaster.Columns[6].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[6].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[7].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[7].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[8].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[8].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[9].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[9].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[14].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[14].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[15].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[15].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[5].Width :=80;
    cxGrdMaster.Columns[6].Width :=80;
    cxGrdMaster.Columns[7].Width :=80;
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseBayarCustomer.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBayarCustomer.cxButton2Click(Sender: TObject);
var
  frmBayarcustomer: TfrmBayarcustomer;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pembayaran Customer' then
   begin
      frmBayarcustomer  := frmmenu.ShowForm(TfrmBayarcustomer) as TfrmBayarcustomer;
      if frmBayarcustomer.FLAGEDIT =False then
      frmBayarcustomer.edtNomor.Text := frmBayarcustomer.getmaxkode;
   end;
   frmBayarcustomer.Show;
end;

procedure TfrmBrowseBayarCustomer.cxButton1Click(Sender: TObject);
var
  frmBayarcustomer: TfrmBayarcustomer;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pembayaran Customer' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBayarcustomer  := frmmenu.ShowForm(TfrmBayarcustomer) as TfrmBayarcustomer;
      frmBayarcustomer.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmBayarcustomer.FLAGEDIT := True;
      frmBayarcustomer.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmBayarcustomer.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmBayarcustomer.Show;
end;

procedure TfrmBrowseBayarCustomer.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBayarCustomer.cxButton3Click(Sender: TObject);
begin
  inherited;
 frmBayarCustomer.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
