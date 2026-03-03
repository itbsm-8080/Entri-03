unit ufrmBrowseReturJual;

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
  TfrmBrowseReturJual = class(TfrmCxBrowse)
    cxButton5: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekbayar(anomor:string) : integer;
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseReturJual: TfrmBrowseReturJual;

implementation
   uses ufrmReturJual,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseReturJual.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select retj_nomor Nomor,retj_tanggal Tanggal ,retj_Memo Memo ,cus_nama  Customer, sls_nama Salesman,'
                  + ' retj_amount Total,retj_taxamount Ppn,retj_cn Retur_CN,retj_fp_nomor Nomor_Faktur'
                  + ' from tretj_hdr'
                  + ' INNER join tfp_hdr on fp_nomor=retj_fp_nomor '
                  + ' left join tsalesman on sls_kode=fp_sls_kode'
                  + ' inner join tcustomer on cus_kode=fp_cus_kode'
                  + ' inner join tretj_dtl on retjd_retj_nomor=retj_nomor'
                  + ' where retj_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by retj_nomor ,retj_tanggal ,retj_memo ,cus_nama ';


  Self.SQLDetail := 'select retj_nomor Nomor,brg_kode Kode , brg_nama Nama,retjd_brg_satuan Satuan,retjd_qty Jumlah,retjd_harga Harga,retjd_discpr Disc,'
                    + ' (retjd_harga*retjd_qty*(100-retjd_discpr)/100) Nilai'
                    + ' from tretj_dtl'
                    + ' inner join tretj_hdr on retjd_retj_nomor =retj_nomor'
                    + ' inner join tbarang on retjd_brg_kode=brg_kode'
                    + ' where retj_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;
    cxGrdMaster.Columns[5].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[5].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[6].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[6].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[7].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[7].Summary.FooterFormat:='###,###,###,###';


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseReturJual.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseReturJual.cxButton2Click(Sender: TObject);
var
  frmReturJual: TfrmReturJual;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Retur Jual' then
   begin
      frmReturJual  := frmmenu.ShowForm(TfrmReturJual) as TfrmReturJual;
      if frmReturJual.FLAGEDIT = false then
      frmReturJual.edtNomor.Text := frmReturJual.getmaxkode;
   end;
   frmReturJual.Show;
end;

procedure TfrmBrowseReturJual.cxButton1Click(Sender: TObject);
var
  frmReturJual: TfrmReturJual;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Retur Jual' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmReturJual  := frmmenu.ShowForm(TfrmReturJual) as TfrmReturJual;
      frmReturJual.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmReturJual.FLAGEDIT := True;
      frmReturJual.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmReturJual.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
      if cekbayar(CDSMaster.FieldByname('Nomor_Faktur').AsString) = 1 then
      begin
        ShowMessage('Transaksi ini sudah di Potong pembayaran,Tidak dapat di edit');
        frmReturJual.cxButton2.Enabled :=False;
        frmReturJual.cxButton1.Enabled :=False;
      end;

   end;
   frmReturJual.Show;
end;

procedure TfrmBrowseReturJual.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseReturJual.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmReturJual.doslipRet(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowseReturJual.cekbayar(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select fp_isbayar from tfp_hdr where fp_nomor =' + Quot(anomor) ;
  tsql:=xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsInteger;

    finally
      Free;
    end;
  end;
end;


procedure TfrmBrowseReturJual.cxButton5Click(Sender: TObject);
begin
  inherited;
    frmReturJual.doslip2(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
