unit ufrmBrowseTandaTerima;

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
  frxDMPExport, MyAccess;

type
  TfrmBrowseTandaTerima = class(TfrmCxBrowse)
    PopupMenu1: TPopupMenu;
    UpdateStatusKembali1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    frxDotMatrixExport1: TfrxDotMatrixExport;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekinvoice(anomor:string) : integer;
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
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
  frmBrowseTandaTerima: TfrmBrowseTandaTerima;

implementation
   uses ufrmTandaTerima,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseTandaTerima.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select tt_nomor Nomor,tt_tanggal Tanggal ,cus_nama  Customer,if(tt_isclosed =0,"Belum","Sudah") Status_SO ,'
                  + ' tt_so_nomor Nomor_SO,'
                  + ' if(so_iskirim=1,"Sudah","Belum") Status' 
                  + ' from ttt_hdr'
                  + ' inner join tcustomer on cus_kode=tt_cus_kode'
                  + ' inner join tso_hdr on so_nomor=tt_so_nomor'
                  + ' where tt_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by tt_nomor ,tt_tanggal ,cus_nama ';

  Self.SQLDetail := 'select tt_nomor Nomor,brg_kode Kode , brg_nama Nama,ttd_brg_satuan Satuan,ttd_qty Jumlah,'
                    + ' ttd_tgl_expired Expired'
                    + ' from ttt_dtl'
                    + ' inner join ttt_hdr on ttd_tt_nomor =tt_nomor'
                    + ' inner join tbarang on ttd_brg_kode=brg_kode'
                    + ' where tt_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by tt_nomor' ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseTandaTerima.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseTandaTerima.cxButton2Click(Sender: TObject);
var
  frmTandaTerima: TfrmTandaTerima;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Tanda Terima' then
   begin
      frmTandaTerima  := frmmenu.ShowForm(TfrmTandaTerima) as TfrmTandaTerima;
      if frmTandaTerima.FLAGEDIT = False then
      frmTandaTerima.edtNomor.Text := frmTandaTerima.getmaxkode;
   end;
   frmTandaTerima.Show;
end;

procedure TfrmBrowseTandaTerima.cxButton1Click(Sender: TObject);
var
  frmTandaTerima: TfrmTandaTerima;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pengiriman Barang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmTandaTerima  := frmmenu.ShowForm(TfrmTandaTerima) as TfrmTandaTerima;
      frmTandaTerima.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmTandaTerima.FLAGEDIT := True;
      frmTandaTerima.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmTandaTerima.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
     if cekinvoice(CDSMaster.FieldByname('Nomor').AsString) = 1 then
      begin
        ShowMessage('Transaksi ini sudah ada Invoice,Tidak dapat di edit');
        frmTandaTerima.cxButton2.Enabled :=False;
        frmTandaTerima.cxButton1.Enabled :=False;
        frmTandaTerima.cxButton3.Enabled :=False;
      end;
   end;
   frmTandaTerima.Show;
end;

procedure TfrmBrowseTandaTerima.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseTandaTerima.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmTandaTerima.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowseTandaTerima.cekinvoice(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select tt_isclosed from ttt_hdr where tt_nomor =' + Quot(anomor) ;
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
procedure TfrmBrowseTandaTerima.cxButton5Click(Sender: TObject);
begin
  inherited;
    frmTandaTerima.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseTandaTerima.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmTandaTerima') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if cekinvoice(CDSMaster.FieldByname('Nomor').AsString) = 1 then
      begin
        MessageDlg('Transaksi ini sudah di SO kan ,Tidak dapat di hapus',mtWarning, [mbOK],0);
        Exit;
      end;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from ttt_dtl '
        + ' where ttd_tt_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

       s:='delete from ttt_hdr '
        + ' where tt_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);

end;

procedure TfrmBrowseTandaTerima.UpdateStatusKembali1Click(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
begin
   If CDSMaster.FieldByname('Nomor').IsNull then exit;
   If CDSMaster.FieldByname('kembali').AsString='0' then
   begin
     s:= 'Update ttt_hdr set tt_iskembali=1 where tt_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
       If CDSMaster.State <> dsEdit then CDSMaster.Edit;
          CDSMaster.FieldByname('kembali').AsString:='1';
          CDSMaster.Post;
   end
   else
   begin
     s:= 'Update ttt_hdr set tt_iskembali=0 where tt_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
     If CDSMaster.State <> dsEdit then CDSMaster.Edit;
     CDSMaster.FieldByname('kembali').AsString:='0';
     CDSMaster.Post;
   end;

   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   // xCommit(frmMenu.conn);
   ShowMessage('Update Status Berhasil');




end;

procedure TfrmBrowseTandaTerima.cxGrdMasterStylesGetContentStyle(
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

end.
