unit ufrmBrowseDO;

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
  TfrmBrowseDO = class(TfrmCxBrowse)
    cxButton5: TcxButton;
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
  frmBrowseDO: TfrmBrowseDO;

implementation
   uses ufrmDO,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseDO.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select do_nomor Nomor,do_tanggal Tanggal ,do_so_nomor Nomor_SO,sls_nama Salesman,cus_nama  Customer,if(do_isInvoice =0,"Belum","Sudah") Invoiced , do_iskembali Kembali'
                  + ' from tdo_hdr'
                  + ' inner join tso_hdr on so_nomor=do_so_nomor'
                  + ' inner join tsalesman on sls_kode=so_sls_kode '
                  + ' inner join tcustomer on cus_kode=so_cus_kode'
                  + ' where do_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by do_nomor ,do_tanggal ,cus_nama ';

  Self.SQLDetail := 'select do_nomor Nomor,brg_kode Kode , brg_nama Nama,dod_brg_satuan Satuan,dod_qty Jumlah,dod_qty_invoice Jumlah_Invoiced,'
                    + ' dod_tgl_expired Expired'
                    + ' from tdo_dtl'
                    + ' inner join tdo_hdr on dod_do_nomor =do_nomor'
                    + ' inner join tbarang on dod_brg_kode=brg_kode'
                    + ' where do_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by do_nomor' ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=200;


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseDO.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseDO.cxButton2Click(Sender: TObject);
var
  frmDO: TfrmDO;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pengiriman Barang' then
   begin
      frmDO  := frmmenu.ShowForm(TfrmDO) as TfrmDO;
      if frmDO.FLAGEDIT = False then 
      frmDO.edtNomor.Text := frmDO.getmaxkode;
   end;
   frmDO.Show;
end;

procedure TfrmBrowseDO.cxButton1Click(Sender: TObject);
var
  frmDO: TfrmDO;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pengiriman Barang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmDO  := frmmenu.ShowForm(TfrmDO) as TfrmDO;
      frmDO.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmDO.FLAGEDIT := True;
      frmDO.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmDO.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
     if cekinvoice(CDSMaster.FieldByname('Nomor').AsString) = 1 then
      begin
        ShowMessage('Transaksi ini sudah ada Invoice,Tidak dapat di edit');
        frmDO.cxButton2.Enabled :=False;
        frmDO.cxButton1.Enabled :=False;
        frmDO.cxButton3.Enabled :=False;
      end;
   end;
   frmDO.Show;
end;

procedure TfrmBrowseDO.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseDO.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmDO.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowseDO.cekinvoice(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select do_isinvoice from tdo_hdr where do_nomor =' + Quot(anomor) ;
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
procedure TfrmBrowseDO.cxButton5Click(Sender: TObject);
begin
  inherited;
    frmDO.doslip2(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseDO.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmDO') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if cekinvoice(CDSMaster.FieldByname('Nomor').AsString) = 1 then
      begin
        MessageDlg('Transaksi ini sudah ada Invoice,Tidak dapat di hapus',mtWarning, [mbOK],0);
        Exit;
      end;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tdo_dtl '
        + ' where dod_do_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

       s:='delete from tdo_hdr '
        + ' where do_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
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

procedure TfrmBrowseDO.UpdateStatusKembali1Click(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
begin
   If CDSMaster.FieldByname('Nomor').IsNull then exit;
   If CDSMaster.FieldByname('kembali').AsString='0' then
   begin
     s:= 'Update tdo_hdr set do_iskembali=1 where do_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
       If CDSMaster.State <> dsEdit then CDSMaster.Edit;
          CDSMaster.FieldByname('kembali').AsString:='1';
          CDSMaster.Post;
   end
   else
   begin
     s:= 'Update tdo_hdr set do_iskembali=0 where do_nomor='+ Quot(CDSMaster.FieldByname('Nomor').AsString)+';';
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

procedure TfrmBrowseDO.cxGrdMasterStylesGetContentStyle(
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
