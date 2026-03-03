unit ufrmBrowseMutasiGudang;

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
  frxDMPExport;

type
  TfrmBrowseMutasiGudang = class(TfrmCxBrowse)
    frxDotMatrixExport1: TfrxDotMatrixExport;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseMutasiGudang: TfrmBrowseMutasiGudang;

implementation
   uses ufrmMutasiGudang,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseMutasiGudang.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select mut_nomor Nomor,mut_Tanggal Tanggal ,c.gdg_nama Asal,b.gdg_nama Tujuan,mut_keterangan Keterangan,'
                  + ' if(mut_status_realisasi=1,"Sudah","Belum") Realisasi '
                  + ' from tmutasi_hdr  a '
                  + ' inner join  tgudang b on b.gdg_kode=a.mut_gdg_tujuan '
                  + ' inner join tgudang c on c.gdg_kode =a.mut_gdg_asal '
                  + ' where mut_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by mut_nomor ,mut_tanggal ,mut_keterangan ';

  Self.SQLDetail := 'select mut_nomor Nomor,mutd_brg_kode Kode , brg_nama Nama,mutd_qty Jumlah,'
                    + ' mutd_expired Expired,mutd_keterangan Keterangan'
                    + ' from tmutasi_dtl'
                    + ' inner join tmutasi_hdr on mut_nomor=mutd_mut_nomor'
                    + ' inner join tbarang on mutd_brg_kode=brg_kode'
                    + ' where mut_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by mut_nomor ,mutd_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;
    cxGrdMaster.Columns[5].Width :=80;
   
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseMutasiGudang.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseMutasiGudang.cxButton2Click(Sender: TObject);
var
  frmMutasiGudang: TfrmMutasiGudang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Mutasi Gudang' then
   begin
      frmMutasiGudang  := frmmenu.ShowForm(TfrmMutasiGudang) as TfrmMutasiGudang;
      if frmMutasiGudang.FLAGEDIT = false then 
      frmMutasiGudang.edtNomor.Text := frmMutasiGudang.getmaxkode;
   end;
   frmMutasiGudang.Show;
end;

procedure TfrmBrowseMutasiGudang.cxButton1Click(Sender: TObject);
var
  frmMutasiGudang: TfrmMutasiGudang;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Mutasi Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmMutasiGudang  := frmmenu.ShowForm(TfrmMutasiGudang) as TfrmMutasiGudang;
      frmMutasiGudang.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmMutasiGudang.FLAGEDIT := True;
      frmMutasiGudang.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmMutasiGudang.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      if CDSMaster.FieldByname('realisasi').AsString = 'Sudah' then
      begin
        ShowMessage('Transaksi ini sudah Realisasi,Tidak dapat di edit');
        frmMutasiGudang.cxButton2.Enabled :=False;
        frmMutasiGudang.cxButton1.Enabled :=False;
      end;
   end;
   frmMutasiGudang.Show;
end;

procedure TfrmBrowseMutasiGudang.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseMutasiGudang.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmMutasiGudang.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseMutasiGudang.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
  try
       if not cekedit(frmMenu.KDUSER,'frmMutasiGudang') then
      begin
         MessageDlg('Anda tidak berhak EDIT ',mtWarning, [mbOK],0);
         Exit;
      End;
     if CDSMaster.FieldByname('realisasi').AsString = 'Belum' then
     begin
      if MessageDlg('Yakin Realisasi Mutasi Gudang ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tmutasi_hdr set mut_status_realisasi=1 '
        + ' where mut_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
        // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
     end
     else
     begin
       if MessageDlg('Yakin Membatalkan Realisasi  ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tmutasi_hdr set mut_status_realisasi=0 '
        + ' where mut_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
     end;


   except
     MessageDlg('Gagal Realisasi',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
   btnRefreshClick(self);
end;
end.
