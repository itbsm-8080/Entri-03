unit ufrmBrowsestbj;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseSTBJ = class(TfrmCxBrowse)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
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
  frmBrowseSTBJ: TfrmBrowseSTBJ;

implementation
   uses ufrmSTBJ,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSTBJ.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select stbj_nomor Nomor,stbj_tanggal Tanggal,stbj_keterangan Keterangan,stbj_spk_nomor SPK,'
                  + ' spk_nama NamaSpk,brg_nama NamaBarang,stbj_jumlah Jumlah,gdg_nama Gudang '
                  + ' from tstbj  a '
                  + ' inner join tspk b on a.stbj_spk_nomor=b.spk_nomor'
                  + ' inner join  tgudang c on c.gdg_kode=a.stbj_gdg_kode '
                  + ' inner join tbarang on brg_kode=stbj_brg_kode'
                  + ' where stbj_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by stbj_nomor ';
//
//  Self.SQLDetail := 'select stbj_nomor Nomor,mbd_brg_kode Kode,brg_nama Nama,mbd_jumlah Jumlah,mbd_satuan Satuan'
//                    + ' from tmintabahan_dtl'
//                    + ' inner join tstbj_hdr on stbj_nomor=mbd_stbj_nomor'
//                    + ' inner join tbarang on mbd_brg_kode=brg_kode'
//                    + ' where stbj_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
//                    + ' order by stbj_nomor ';
// Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=200;
    cxGrdMaster.Columns[5].Width :=200;
    cxGrdMaster.Columns[6].Width :=100;


end;

procedure TfrmBrowseSTBJ.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSTBJ.cxButton2Click(Sender: TObject);
var
  frmSTBJ: TfrmSTBJ;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Permintaan Bahan' then
   begin
      frmSTBJ  := frmmenu.ShowForm(TfrmSTBJ) as TfrmSTBJ;
      if frmSTBJ.FLAGEDIT = false then 
      frmSTBJ.edtNomor.Text := frmSTBJ.getmaxkode;
   end;
   frmSTBJ.Show;
end;

procedure TfrmBrowseSTBJ.cxButton1Click(Sender: TObject);
var
  frmSTBJ: TfrmSTBJ;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Mutasi Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmSTBJ  := frmmenu.ShowForm(TfrmSTBJ) as TfrmSTBJ;
      frmSTBJ.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmSTBJ.FLAGEDIT := True;
      frmSTBJ.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmSTBJ.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
//      if CDSMaster.FieldByname('realisasi').AsString = 'Sudah' then
//      begin
//        ShowMessage('Transaksi ini sudah Realisasi,Tidak dapat di edit');
//        frmSTBJ.cxButton2.Enabled :=False;
//        frmSTBJ.cxButton1.Enabled :=False;
//      end;
   end;
   frmSTBJ.Show;
end;

procedure TfrmBrowseSTBJ.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSTBJ.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmSTBJ.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseSTBJ.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
  try
       if not cekdelete(frmMenu.KDUSER,'frmSTBJ') then
      begin
         MessageDlg('Anda tidak berhak Hapus',mtWarning, [mbOK],0);
         Exit;
      End;
//     if CDSMaster.FieldByname('realisasi').AsString = 'Belum' then
//     begin
//      if MessageDlg('Yakin Realisasi Mutasi Gudang ?',mtCustom,
//                                  [mbYes,mbNo], 0)= mrNo
//      then Exit ;
//       s:='UPDATE tmutasi_hdr set mut_status_realisasi=1 '
//        + ' where mut_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
//        xExecQuery(s,frmmenu.conn);
//     end
//     else
//     begin
//       if MessageDlg('Yakin Membatalkan Realisasi  ?',mtCustom,
//                                  [mbYes,mbNo], 0)= mrNo
//      then Exit ;
       s:='delete from tstbj where '
        + ' stbj_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
//     end;


   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
   showmessage('Berhasil hapus data') ;
    // xCommit(frmMenu.conn);
   btnRefreshClick(self);
end;
end.
