unit ufrmBrowseFP;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, frxClass,
  frxExportPDF, frxDMPExport, MyAccess;

type
  TfrmBrowseFP = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    PopupMenu1: TPopupMenu;
    HistoryPembayaran1: TMenuItem;
    cxButton9: TcxButton;
    UpdateStatusKembali1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxButton10: TcxButton;
    frxDotMatrixExport1: TfrxDotMatrixExport;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekbayar(anomor:string) : integer;
    procedure cxButton5Click(Sender: TObject);
    procedure HistoryPembayaran1Click(Sender: TObject);
    procedure cxButton9Click(Sender: TObject);
    procedure UpdateStatusKembali1Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxButton10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseFP: TfrmBrowseFP;

implementation
   uses ufrmFP,Ulib, MAIN, uModuleConnection,uFrmbantuan,ufrmBayarCustomer,ufrmEditJT;
{$R *.dfm}

procedure TfrmBrowseFP.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select fp_nomor Nomor,fp_tanggal Tanggal ,fp_jthtempo JthTempo, fp_Memo Memo ,if(fp_istax=1,"PPn","Non Ppn") Tax,sls_nama Salesman,cus_kode Kode_Cust,cus_nama  Customer, '
                  + ' fp_amount Total,fp_taxamount Ppn, '
                  + ' ((Fp_disc_fakturpr*(((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100))/100) + fp_disc_faktur  Disc_Faktur,'
                  + ' ((Fp_biayapr*((fp_amount-fp_taxamount-ifnull((select sum(retj_amount) from tretj_hdr  where retj_fp_nomor = fp_nomor),0) ))/100) + fp_biayarp)  Biaya_Promosi,'
                  + ' fp_cn Kontrak,fp_freight Freight,fp_bayar Bayar,if(fp_isbayar=0,"Belum","Sudah") Status_Bayar,'
                  + ' fp_iskembali Kembali,'
                  + ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor=fp_nomor) Retur ,'
                  + ' if ((select count(*) from tjatuhtempofp where jt_fp_nomor =fp_nomor ) > 0,"Angsur","") Keterangan '
                  + ' , fp_status_faktur status_faktur '
                  + ' from tfp_hdr'
                  + ' left join tsalesman on sls_kode=fp_sls_kode'
                  + ' inner join tcustomer on cus_kode=fp_cus_kode'
                  + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by fp_nomor ,fp_tanggal ,fp_memo ,cus_nama ';


  Self.SQLDetail := 'select fp_nomor Nomor,brg_kode Kode , brg_nama Nama,fpd_brg_satuan Satuan,fpd_qty Jumlah,fpd_harga Harga,fpd_discpr Disc,'
                    + ' (fpd_harga*fpd_qty*(100-fpd_discpr)/100) Nilai,fpd_cn Kontrak'
                    + ' from tfp_dtl'
                    + ' inner join tfp_hdr on fpd_fp_nomor =fp_nomor'
                    + ' inner join tbarang on fpd_brg_kode=brg_kode'
                    + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' and fpd_qty > 0 '
                    + ' order by fp_nomor ' ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=60;

    cxGrdMaster.Columns[8].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[8].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[9].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[9].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[10].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[10].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[11].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[11].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[12].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[12].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[13].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[13].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[17].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[17].Summary.FooterFormat:='###,###,###,###';

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseFP.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseFP.cxButton2Click(Sender: TObject);
var
  frmFP: TfrmFP;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Faktur Penjualan' then
   begin
      frmFP  := frmmenu.ShowForm(TfrmFP) as TfrmFP;
      if frmFP.FLAGEDIT = false then
      frmFP.edtNomor.Text := frmFP.getmaxkode;
   end;
   frmFP.Show;
end;

procedure TfrmBrowseFP.cxButton1Click(Sender: TObject);
var
  frmFP: TfrmFP;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Edit Jatuh Tempo' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFP  := frmmenu.ShowForm(TfrmFP) as TfrmFP;
      frmFP.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmFP.FLAGEDIT := True;
      frmFP.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmFP.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
   end;
     if cekbayar(CDSMaster.FieldByname('Nomor').AsString) = 1 then
      begin
        ShowMessage('Transaksi ini sudah ada Pembayaran,Tidak dapat di edit');
        frmFP.cxButton2.Enabled :=False;
        frmFP.cxButton1.Enabled :=False;
        frmFP.cxButton3.Enabled :=False;
      end;

   frmFP.Show;
end;

procedure TfrmBrowseFP.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseFP.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmFP.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmbrowseFP.cekbayar(anomor:string) : integer;
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

procedure TfrmBrowseFP.cxButton5Click(Sender: TObject);
begin
  inherited;
     frmFP.doslip22(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseFP.HistoryPembayaran1Click(Sender: TObject);
var
    SQLbantuan :string;
    frmBayarcustomer: TfrmBayarcustomer;
begin
 sqlbantuan := ' select bycd_byc_nomor Nomor,byc_tanggal Tanggal,bycd_fp_nomor NomorFP,BYCD_bayar Bayar'
+ ' from tbayarcus_dtl inner join tfp_hdr on bycd_fp_nomor=fp_nomor '
+ ' inner join tbayarcus_hdr on bycd_byc_nomor=byc_nomor '
+ ' where bycd_fp_nomor ='+ quot(CDSMaster.FieldByname('Nomor').AsString) ;
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
      if ActiveMDIChild.Caption <> 'Pembayaran Customer' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBayarcustomer  := frmmenu.ShowForm(TfrmBayarcustomer) as TfrmBayarcustomer;
      frmBayarcustomer.ID := varglobal;
      frmBayarcustomer.FLAGEDIT := True;
      frmBayarcustomer.edtnOMOR.Text := varglobal;
      frmBayarcustomer.loaddataall(varglobal);

   end;
   frmBayarcustomer.Show;

  end;
end;

procedure TfrmBrowseFP.cxButton9Click(Sender: TObject);
var
  frmEditJT: TfrmEditJT;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Edit Jatuh Tempo' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmEditJT  := frmmenu.ShowForm(TfrmEditJT) as TfrmEditJT;
      frmEditJT.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmEditJT.FLAGEDIT := True;
      frmEditJT.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmEditJT.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
   end;
   frmEditJT.Show;
end;

procedure TfrmBrowseFP.UpdateStatusKembali1Click(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
begin
    If CDSMaster.FieldByname('Nomor').IsNull then exit;
   if CDSMaster.FieldByname('kembali').AsString='0' then
   begin
     s:= 'Update tfp_hdr set fp_iskembali=1 where fp_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
       If CDSMaster.State <> dsEdit then CDSMaster.Edit;
          CDSMaster.FieldByname('kembali').asinteger:=1;
          CDSMaster.Post;
   end
   else
   begin
     s:= 'Update tfp_hdr set fp_iskembali=0 where fp_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
     If CDSMaster.State <> dsEdit then CDSMaster.Edit;
     CDSMaster.FieldByname('kembali').AsInteger:=0;
     CDSMaster.Post;
   end;

   // xExecQuery(s,frmMenu.conn);
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
   // xCommit(frmMenu.conn);

     ShowMessage('Update Status Berhasil');




end;

procedure TfrmBrowseFP.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Kembali');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) > 0) then
    AStyle := cxStyle1;
end;


procedure TfrmBrowseFP.cxButton10Click(Sender: TObject);
begin
  inherited;
      frmFP.doslip3(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
