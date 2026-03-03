unit ufrmBrowsePO;

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
  TfrmBrowsePO = class(TfrmCxBrowse)
    frxDotMatrixExport1: TfrxDotMatrixExport;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    function cekreceipt(anomor:string) : integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowsePO: TfrmBrowsePO;

implementation
   uses ufrmPO,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowsePO.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select po_nomor Nomor,po_tanggal Tanggal ,po_Memo Memo ,sup_nama  Supplier,if(po_isclosed=0,"Belum","Sudah") Closed, '
                  + ' po_amount Total,po_taxamount Ppn,if(po_status_rec=0,"Belum","Sudah") Receipt'
                  + ' from tpo_hdr'
                  + ' inner join tsupplier on sup_kode=po_sup_kode'
                  + ' inner join tpo_dtl on pod_po_nomor=po_nomor'
                  + ' where po_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by po_nomor ,po_tanggal ,po_memo ,sup_nama ';

  Self.SQLDetail := 'select po_nomor Nomor,brg_kode Kode , brg_nama Nama,pod_brg_satuan Satuan,pod_qty Jumlah,pod_harga Harga,pod_discpr Disc,'
                    + ' (pod_harga*pod_qty*(100-pod_discpr)/100) Nilai,'
                    + ' pod_qty_terima Terima'
                    + ' from tpo_dtl'
                    + ' inner join tpo_hdr on pod_po_nomor =po_nomor'
                    + ' inner join tbarang on pod_brg_kode=brg_kode'
                    + ' where po_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;
    cxGrdMaster.Columns[5].Width :=80;
    cxGrdMaster.Columns[6].Width :=70;
    cxGrdMaster.Columns[6].Width :=100;

    cxGrdMaster.Columns[6].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[6].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[5].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[5].Summary.FooterFormat:='###,###,###,###';


    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowsePO.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowsePO.cxButton2Click(Sender: TObject);
var
  frmPO: TfrmPO;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'PO' then
   begin
      frmPO  := frmmenu.ShowForm(TfrmPO) as TfrmPO;
      frmPO.edtNomor.Text := frmPO.getmaxkode;
   end;
   frmPO.Show;
end;

procedure TfrmBrowsePO.cxButton1Click(Sender: TObject);
var
  frmPO: TfrmPO;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'PO' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPO  := frmmenu.ShowForm(TfrmPO) as TfrmPO;
      frmPO.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmPO.FLAGEDIT := True;
      frmPO.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmPO.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
//      if cekreceipt(CDSMaster.FieldByname('Nomor').AsString) = 1 then
//      begin
//        ShowMessage('Transaksi ini sudah ada Receipt Barang,Tidak dapat di edit');
//        frmPO.cxButton2.Enabled :=False;
//        frmPO.cxButton1.Enabled :=False;
//      end;
   end;
   frmPO.Show;
end;

procedure TfrmBrowsePO.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowsePO.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmPO.doslipPO(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowsePO.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekedit(frmMenu.KDUSER,'frmPO') then
      begin
         MessageDlg('Anda tidak berhak EDIT  PO',mtWarning, [mbOK],0);
         Exit;
      End;
     if CDSMaster.FieldByname('closed').AsString = 'Belum' then
     begin
      if MessageDlg('Yakin Closed PO ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tpo_hdr set po_isclosed=1 '
        + ' where po_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
     end
     else
     begin
       if MessageDlg('Yakin Buka PO ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tpo_hdr set po_isclosed=0 '
        + ' where po_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
     end;


   except
     MessageDlg('Gagal Closed',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
   btnRefreshClick(self);
end;

function TfrmBrowsePO.cekreceipt(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select po_status_rec from tpo_hdr where po_nomor =' + Quot(anomor) ;
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

end.
