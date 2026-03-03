unit ufrmBrowseBayarSupplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseBayarSupplier = class(TfrmCxBrowse)
    cxButton5: TcxButton;
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
  frmBrowseBayarSupplier: TfrmBrowseBayarSupplier;

implementation
   uses ufrmBayarSupplier,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseBayarSupplier.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select bys_nomor Nomor,bys_tanggal Tanggal ,bys_Memo Memo ,if(bys_istax=1,"PPN","Non PPN") Tax,sup_kode Kode,sup_nama  Supplier,  bys_Nilai Total,bys_nogiro Giro,bys_tglcair TglCair ,'
                  + ' rek_nama Rekening '
                  + ' from tbayarsup_hdr inner join tsupplier on sup_kode=bys_sup_kode '
                  + ' left join trekening on bys_rek_kode=rek_kode'
                  + ' where bys_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);



  Self.SQLDetail := 'select bys_nomor Nomor,bysd_inv_nomor Invoice , inv_nobukti Nobukti,inv_tanggal Tgl_Invoice,inv_jthtempo JthTempo,inv_amount Nilai,'
                    + ' ifnull((select sum(ret_amount) from tret_hdr where ret_inv_nomor=inv_nomor),0) Retur,'
                    + ' bysd_bayar Bayar'
                    + ' from tbayarsup_dtl'
                    + ' inner join tbayarsup_hdr on bysd_bys_nomor =bys_nomor'
                    + ' inner join tinv_hdr on bysd_inv_nomor=inv_nomor'
                    + ' where bys_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by bys_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;

     cxGrdMaster.Columns[6].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[6].Summary.FooterFormat:='###,###,###,###';


    cxGrdMaster.Columns[5].Width :=80;
    cxGrdMaster.Columns[6].Width :=80;

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseBayarSupplier.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBayarSupplier.cxButton2Click(Sender: TObject);
var
  frmBayarSupplier: TfrmBayarSupplier;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pembayaran Supplier' then
   begin
      frmBayarSupplier  := frmmenu.ShowForm(TfrmBayarSupplier) as TfrmBayarSupplier;
      if frmBayarSupplier.FLAGEDIT = False then 
      frmBayarSupplier.edtNomor.Text := frmBayarSupplier.getmaxkode;
   end;
   frmBayarSupplier.Show;
end;

procedure TfrmBrowseBayarSupplier.cxButton1Click(Sender: TObject);
var
  frmBayarSupplier: TfrmBayarSupplier;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pembayaran Supplier' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBayarSupplier  := frmmenu.ShowForm(TfrmBayarSupplier) as TfrmBayarSupplier;
      frmBayarSupplier.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmBayarSupplier.FLAGEDIT := True;
      frmBayarSupplier.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmBayarSupplier.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmBayarSupplier.Show;
end;

procedure TfrmBrowseBayarSupplier.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBayarSupplier.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmBayarSupplier.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
