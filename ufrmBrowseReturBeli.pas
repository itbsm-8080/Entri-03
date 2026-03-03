unit ufrmBrowseReturBeli;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, MyAccess;

type
  TfrmBrowseReturBeli = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekbayar(anomor:String): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseReturBeli: TfrmBrowseReturBeli;

implementation
   uses ufrmReturBeli,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseReturBeli.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select ret_nomor Nomor,ret_tanggal Tanggal ,ret_Memo Memo ,sup_nama  Supplier, '
                  + ' ret_amount Total,ret_taxamount Ppn,ret_inv_nomor Invoice '
                  + ' from tret_hdr'
                  + ' INNER join tinv_hdr on inv_nomor=ret_inv_nomor '
                  + ' inner join tsupplier on sup_kode=inv_sup_kode'
                  + ' inner join tret_dtl on retd_ret_nomor=ret_nomor'
                  + ' where ret_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by ret_nomor ,ret_tanggal ,ret_memo ,sup_nama ';


  Self.SQLDetail := 'select ret_nomor Nomor,brg_kode Kode , brg_nama Nama,retd_brg_satuan Satuan,retd_qty Jumlah,retd_harga Harga,retd_discpr Disc,'
                    + ' (retd_harga*retd_qty*(100-retd_discpr)/100) Nilai'
                    + ' from tret_dtl'
                    + ' inner join tret_hdr on retd_ret_nomor =ret_nomor'
                    + ' inner join tbarang on retd_brg_kode=brg_kode'
                    + ' where ret_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;
    cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[5].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[5].Summary.FooterFormat:='###,###,###,###';


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseReturBeli.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseReturBeli.cxButton2Click(Sender: TObject);
var
  frmReturBeli: TfrmReturBeli;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Retur Beli' then
   begin
      frmReturBeli  := frmmenu.ShowForm(TfrmReturBeli) as TfrmReturBeli;
      frmReturBeli.edtNomor.Text := frmReturBeli.getmaxkode;
   end;
   frmReturBeli.Show;
end;

procedure TfrmBrowseReturBeli.cxButton1Click(Sender: TObject);
var
  frmReturBeli: TfrmReturBeli;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Retur Beli' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmReturBeli  := frmmenu.ShowForm(TfrmReturBeli) as TfrmReturBeli;
      frmReturBeli.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmReturBeli.FLAGEDIT := True;
      frmReturBeli.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmReturBeli.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
     if cekbayar(CDSMaster.FieldByname('Invoice').AsString) then
      begin
        ShowMessage('Transaksi ini sudah ada potong Pembayaran,Tidak dapat di edit');
        frmReturBeli.cxButton2.Enabled :=False;
        frmReturBeli.cxButton1.Enabled :=False;
      end;
   end;
   frmReturBeli.Show;
end;

procedure TfrmBrowseReturBeli.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseReturBeli.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmReturBeli.doslipret(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowseReturBeli.cekbayar(anomor:String): Boolean;
var
  s:string;
  tsql:TMyQuery;

begin
  Result :=False;
  s:='select inv_isbayar from tinv_hdr where inv_nomor='+ Quot(anomor);
  tsql :=xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
       if Fields[0].AsInteger=1 then
          Result:= True;

    finally
      Free;
    end;
  end;
end;
end.
