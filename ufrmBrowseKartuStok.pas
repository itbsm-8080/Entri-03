unit ufrmBrowseKartuStok;

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
  dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox;

type
  TfrmBrowseKartuStok = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    Label5: TLabel;
    cxLookupGudangAsal: TcxExtLookupComboBox;
    procedure FormCreate(Sender: TObject);
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    FCDSGudang: TClientDataset;
    function GetCDSGudang: TClientDataset;
    { Private declarations }
  public
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    { Public declarations }
  end;

var
  frmBrowseKartuStok: TfrmBrowseKartuStok;

implementation
   uses ufrmbarang,Ulib, MAIN, uModuleConnection,uFrmLihatGambar;
{$R *.dfm}

procedure TfrmBrowseKartuStok.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupGudangAsal.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);

end;

procedure TfrmBrowseKartuStok.btnRefreshClick(Sender: TObject);
begin

Self.SQLMaster := 'select brg_kode Kode,brg_nama Nama,Kategori,'
          + ' brg_hrgbeli Hbeli,'
          + ' ifnull(saldoawal,0) _Awal,ifnull(qty_in,0) _In,ifnull(qty_out,0) _Out,'
          + ' ifnull(saldoawal,0) + ifnull(qty_in,0) - ifnull(qty_out,0) _Akhir'
          + '  from ('
          + ' select brg_kode,brg_nama,ktg_nama kategori,(select mst_hargabeli from tmasterstok where mst_noreferensi like "RI%" And mst_brg_kode=brg_kode order by mst_tanggal desc limit 1 )  brg_hrgbeli,'
          + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_tanggal < ' + QuotD(startdate.DateTime)
          + ' and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+' ) saldoawal,'
          + ' (select sum(mst_stok_in) from tmasterstok where mst_brg_kode=a.brg_kode and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+' )  qty_in,'
          + ' (select sum(mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
          + ' and mst_gdg_kode like '+Quot(VarToStr(cxLookupGudangAsal.EditValue)+'%')+ ')  qty_out,'
          + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_tanggal <= ' + QuotD(enddate.DateTime)
          + ' and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+' ) akhir'
          + '  from tbarang a  inner join tkategori on ktg_kode=brg_ktg_kode '
          + '  ) final '
          + ' where ifnull(saldoawal,0) > 0 or ifnull(qty_in,0) > 0 or ifnull(qty_OUT,0) > 0 '
          + ' order by brg_kode' ;


Self.SQLDetail := 'select mst_brg_kode Kode,mst_noreferensi Nomor,mst_tanggal Tanggal,'
              + ' if(mst_noreferensi like "%MTG%","Mutasi Gudang",if(mst_noreferensi like "%DO%","Penjualan",if(mst_noreferensi like "%RI%","Pembelian",'
              + ' if (mst_noreferensi like "%RETJ%","Retur Penjualan",if (mst_noreferensi like "%KOR%","Koreksi",if (mst_noreferensi like "%MUS%","Pemusnahan",if (mst_noreferensi like "%MTB%","Permintaan Bahan",if (mst_noreferensi like "%RTB%","Retur Bahan",'
              + ' if(mst_noreferensi like "%MTB%","Permintaan Bahan",if(mst_noreferensi like "%STB%","Serah Terima Barang Jadi","Penjualan")))))))))) Keterangan ,'
              + ' gdg_nama Gudang,mst_stok_in _IN,mst_stok_out _OUT,mst_expired_date Expired,mst_hargabeli Hargabeli  from tmasterstok '
              + ' inner join tgudang on gdg_kode=mst_gdg_kode '
              + ' where mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
              + ' and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')
              + ' order by mst_brg_kode,mst_tanggal' ;
   Self.MasterKeyField := 'Kode';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=80;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[3].Width :=150;
    cxGrdMaster.Columns[5].Width :=80;
    cxGrdMaster.Columns[6].Width :=60;
    cxGrdDetail.Columns[3].Width :=200;

end;

procedure TfrmBrowseKartuStok.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseKartuStok.cxButton2Click(Sender: TObject);
var
  frmBarang: TfrmBarang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Barang' then
   begin
      frmBarang  := frmmenu.ShowForm(TfrmBarang) as TfrmBarang;
      frmBarang.edtKode.SetFocus;
      frmBarang.edtKode.Text := IntToStr(frmBarang.getmaxkode);
      frmBarang.cxLookupJenisGroup.EditValue := 1;
   end;
   frmBarang.Show;
end;

procedure TfrmBrowseKartuStok.cxButton1Click(Sender: TObject);
var
  frmBarang: TfrmBarang;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master CostCenter' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBarang  := frmmenu.ShowForm(TfrmBarang) as TfrmBarang;
      frmBarang.ID := CDSMaster.FieldByname('KODE').AsString;
      frmBarang.FLAGEDIT := True;
      frmBarang.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmBarang.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmBarang.edtKode.Enabled := False;
   end;
   frmBarang.Show;
end;

procedure TfrmBrowseKartuStok.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseKartuStok.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmBarang') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tbarang '
        + ' where brg_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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

procedure TfrmBrowseKartuStok.cxButton5Click(Sender: TObject);
var
  KODEBARANG : string;
begin
  inherited;
  Application.CreateForm(TfrmLihatGambar,frmLihatGambar);
  frmLihatGambar.KODEBARANG := CDSMaster.FieldByname('KODE').AsString;
  frmLihatGambar.ShowModal;
end;

function TfrmBrowseKartuStok.GetCDSGudang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSGudang) then
  begin
    S := 'select gdg_nama as Gudang, gdg_kode Kode '
        +' from tgudang';


    FCDSGudang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSGudang;
end;

end.
