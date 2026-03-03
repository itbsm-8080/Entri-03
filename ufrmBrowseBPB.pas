unit ufrmBrowseBPB;

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
  TfrmBrowseBPB = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekinvoice(anomor:string) : integer;
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseBPB: TfrmBrowseBPB;

implementation
   uses ufrmBPB,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseBPB.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select BPB_nomor Nomor,BPB_tanggal Tanggal ,bpb_po_nomor Nomor_PO,sup_nama  Supplier,if(BPB_isInvoice =0,"Belum","Sudah") Invoiced ,'
                  + ' gdg_nama Gudang'
                  + ' from tBPB_hdr'
                  + ' inner join tpo_hdr on po_nomor=bpb_po_nomor'
                  + ' inner join tsupplier on sup_kode=po_sup_kode'
                  + ' left join tgudang on gdg_kode=bpb_gdg_kode '
                  + ' where BPB_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by BPB_nomor ,BPB_tanggal ,sup_nama ';

  Self.SQLDetail := 'select BPB_nomor Nomor,brg_kode Kode , brg_nama Nama,bpbd_brg_satuan Satuan,bpbd_qty Jumlah,'
                    + ' bpbd_tgl_expired Expired'
                    + ' from tBPB_dtl'
                    + ' inner join tBPB_hdr on bpbd_BPB_nomor =BPB_nomor'
                    + ' inner join tbarang on bpbd_brg_kode=brg_kode'
                    + ' where BPB_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by bpb_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseBPB.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBPB.cxButton2Click(Sender: TObject);
var
  frmBPB: TfrmBPB;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Penerimaan Barang' then
   begin
      frmBPB  := frmmenu.ShowForm(TfrmBPB) as TfrmBPB;
      frmBPB.edtNomor.Text := frmBPB.getmaxkode;
   end;
   frmBPB.Show;
end;

procedure TfrmBrowseBPB.cxButton1Click(Sender: TObject);
var
  frmBPB: TfrmBPB;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Penerimaan Barang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBPB  := frmmenu.ShowForm(TfrmBPB) as TfrmBPB;
      frmBPB.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmBPB.FLAGEDIT := True;
      frmBPB.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmBPB.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
     if cekinvoice(CDSMaster.FieldByname('Nomor').AsString)=1  then
      begin
        ShowMessage('Transaksi ini sudah ada Invoice,Tidak dapat di edit');
        frmBPB.cxButton2.Enabled :=False;
        frmBPB.cxButton1.Enabled :=False;
      end;
   end;
   frmBPB.Show;
end;

procedure TfrmBrowseBPB.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBPB.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmBPB.doslipBPB(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowseBPB.cekinvoice(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select bpb_isinvoice from tbpb_hdr where bpb_nomor =' + Quot(anomor) ;
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


procedure TfrmBrowseBPB.cxButton4Click(Sender: TObject);
VAR
  S:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmBPB') then
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
       s:='delete from tbpb_dtl '
        + ' where bpbd_bpb_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

       s:='delete from tbpb_hdr '
        + ' where bpb_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
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

end.
