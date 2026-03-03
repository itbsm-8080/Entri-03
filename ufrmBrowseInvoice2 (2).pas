unit ufrmBrowseInvoice;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels,
  dxSkinsDefaultPainters;

type
  TfrmBrowseInvoice = class(TfrmCxBrowse)
    PopupMenu1: TPopupMenu;
    HistoryPembayaran1: TMenuItem;
    PopupMenu2: TPopupMenu;
    UpdateStatusKembali1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekbayar(anomor:string) : integer;
    procedure HistoryPembayaran1Click(Sender: TObject);
    procedure UpdateStatusKembali1Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseInvoice: TfrmBrowseInvoice;

implementation
   uses ufrmInvoice,Ulib, MAIN, uModuleConnection, uFrmbantuan,
  ufrmBayarSupplier;
{$R *.dfm}

procedure TfrmBrowseInvoice.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select inv_nomor Nomor,inv_nobukti Nobukti,inv_tanggal Tanggal ,inv_jthtempo Jthtempo,inv_Memo Memo ,sup_nama  Supplier, '
                  + ' inv_amount Total,inv_taxamount Ppn,inv_bayar Bayar,if(inv_isbayar=0,"Belum","Sudah") Status_Bayar,inv_ispajak=1 Pajak'
                  + ' from tinv_hdr'
                  + ' INNER join tbpb_hdr on bpb_nomor=inv_bpb_nomor '
                  + ' inner join tpo_hdr on po_nomor=bpb_po_nomor'
                  + ' inner join tsupplier on sup_kode=po_sup_kode'
                  + ' inner join tinv_dtl on invd_inv_nomor=inv_nomor'
                  + ' where inv_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by inv_nomor ,inv_tanggal ,inv_memo ,sup_nama ';




  Self.SQLDetail := 'select inv_nomor Nomor,brg_kode Kode , brg_nama Nama,invd_brg_satuan Satuan,invd_qty Jumlah,invd_harga Harga,invd_discpr Disc,'
                    + ' (invd_harga*invd_qty*(100-invd_discpr)/100) Nilai'
                    + ' from tinv_dtl'
                    + ' inner join tinv_hdr on invd_inv_nomor =inv_nomor'
                    + ' inner join tbarang on invd_brg_kode=brg_kode'
                    + ' where inv_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=200;
    cxGrdMaster.Columns[5].Width :=200;
    cxGrdMaster.Columns[6].Width :=100;



    cxGrdMaster.Columns[8].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[8].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[6].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[6].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[7].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[7].Summary.FooterFormat:='###,###,###,###';


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseInvoice.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseInvoice.cxButton2Click(Sender: TObject);
var
  frmInvoice: TfrmInvoice;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Invoice' then
   begin
      frmInvoice  := frmmenu.ShowForm(TfrmInvoice) as TfrmInvoice;
      if frmInvoice.FLAGEDIT = false then 
      frmInvoice.edtNomor.Text := frmInvoice.getmaxkode;
   end;
   frmInvoice.Show;
end;

procedure TfrmBrowseInvoice.cxButton1Click(Sender: TObject);
var
  frmInvoice: TfrmInvoice;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Invoice' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmInvoice  := frmmenu.ShowForm(TfrmInvoice) as TfrmInvoice;
      frmInvoice.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmInvoice.FLAGEDIT := True;
      frmInvoice.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmInvoice.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
      if cekbayar(CDSMaster.FieldByname('Nomor').AsString)=1 then
      begin
        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
        frmInvoice.cxButton2.Enabled :=False;
        frmInvoice.cxButton1.Enabled :=False;
      end;
   end;
   frmInvoice.Show;
end;

procedure TfrmBrowseInvoice.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseInvoice.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmInvoice.doslipInv(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowseInvoice.cekbayar(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select inv_isbayar from tinv_hdr where inv_nomor =' + Quot(anomor) ;
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


procedure TfrmBrowseInvoice.HistoryPembayaran1Click(Sender: TObject);
var
    SQLbantuan :string;
    frmBayarsupplier: TfrmBayarsupplier;
begin
 sqlbantuan := ' select bysd_bys_nomor Nomor,bysd_inv_nomor NomorInv,bysD_bayar Bayar,bys_nilai Nilai '
+ ' from tbayarsup_dtl inner join tinv_hdr on bysd_inv_nomor=inv_nomor '
+ ' inner join tbayarsup_hdr on bysd_bys_nomor=bys_nomor '
+ ' where bysd_inv_nomor ='+ quot(CDSMaster.FieldByname('Nomor').AsString) ;
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
      if ActiveMDIChild.Caption <> 'Pembayaran Supplier' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmbayarsupplier  := frmmenu.ShowForm(Tfrmbayarsupplier) as Tfrmbayarsupplier;
      frmbayarsupplier.ID := varglobal;
      frmbayarsupplier.FLAGEDIT := True;
      frmbayarsupplier.edtnOMOR.Text := varglobal;
      frmbayarsupplier.loaddataall(varglobal);

   end;
   frmbayarsupplier.Show;

  end;
end;

procedure TfrmBrowseInvoice.UpdateStatusKembali1Click(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
begin
    If CDSMaster.FieldByname('Nomor').IsNull then exit;
   if CDSMaster.FieldByname('pajak').AsString='0' then
   begin
     s:= 'Update tinv_hdr set inv_ispajak=1 where inv_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
       If CDSMaster.State <> dsEdit then CDSMaster.Edit;
          CDSMaster.FieldByname('pajak').AsString:='1';
          CDSMaster.Post;
   end
   else
   begin
     s:= 'Update tinv_hdr set inv_ispajak=0 where inv_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
     If CDSMaster.State <> dsEdit then CDSMaster.Edit;
     CDSMaster.FieldByname('pajak').AsString:='0';
     CDSMaster.Post;
   end;

   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   // xCommit(frmMenu.conn);
   ShowMessage('Update Status Berhasil');


end;


procedure TfrmBrowseInvoice.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Pajak');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) > 0) then
    AStyle := cxStyle1;
end;


end.
