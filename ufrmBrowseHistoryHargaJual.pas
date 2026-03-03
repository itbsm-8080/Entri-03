unit ufrmBrowseHistoryHargaJual;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, AdvCombo;

type
  TfrmBrowseHistoryHargaJual = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    Label3: TLabel;
    cbbBulan: TAdvComboBox;
    Label4: TLabel;
    edtTahun: TComboBox;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseHistoryHargaJual: TfrmBrowseHistoryHargaJual;

implementation
   uses ufrmbarang,Ulib, MAIN, uModuleConnection,uFrmLihatGambar;
{$R *.dfm}

procedure TfrmBrowseHistoryHargaJual.btnRefreshClick(Sender: TObject);
begin

  Self.SQLMaster := 'select distinct brg_kode Kode,brg_nama Nama,brg_satuan Satuan,ktg_nama Kategori,brg_merk Merk from tbarang '
+ ' inner join tfp_dtl on fpd_brg_kode=brg_kode'
+ ' inner join tkategori on ktg_kode=brg_ktg_kode'
+ ' inner join tfp_hdr on fpd_fp_nomor=fp_nomor '
+ ' WHERE month(fp_tanggal)='+IntToStr(cbbBulan.itemindex +1)+' and  year(fp_tanggal)='+edtTahun.Text;


Self.SQLDetail := 'select distinct fpd_brg_kode Kode,cus_nama Customer,fpd_harga Harga,fpd_discpr Disc,fpd_cn Kontrak,'
+ ' ((100-fpd_cn)/100*((100-fpd_discpr)*fpd_harga/100)) HargaNet,sls_nama Salesman,if(fp_istax=1,"PPN","Non PPN") Status'
+ ' from tfp_dtl inner join tfp_hdr on fpd_fp_nomor=fp_nomor'
+ ' inner join tcustomer on cus_kode=fp_cus_kode'
+ ' left join tdo_hdr on do_nomor =fp_do_nomor'
+ ' left join tso_hdr on so_nomor =do_so_nomor'
+ ' inner join tsalesman on sls_kode=so_sls_kode '
+ ' where month(fp_tanggal)='+IntToStr(cbbBulan.itemindex +1)+' and  year(fp_tanggal)='+edtTahun.Text
+ ' order by fpd_brg_kode,cus_nama' ;
 Self.MasterKeyField := 'Kode';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=80;
    cxGrdMaster.Columns[1].Width :=200;
        cxGrdMaster.Columns[3].Width :=150;

end;

procedure TfrmBrowseHistoryHargaJual.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  cbbBulan.ItemIndex := StrToInt(FormatDateTime('mm',Date))-1;
  edtTahun.Text :=FormatDateTime('yyyy',Date);
  btnRefreshClick(Self);
end;

procedure TfrmBrowseHistoryHargaJual.cxButton2Click(Sender: TObject);
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

procedure TfrmBrowseHistoryHargaJual.cxButton1Click(Sender: TObject);
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

procedure TfrmBrowseHistoryHargaJual.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseHistoryHargaJual.cxButton4Click(Sender: TObject);
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

procedure TfrmBrowseHistoryHargaJual.cxButton5Click(Sender: TObject);
var
  KODEBARANG : string;
begin
  inherited;
  Application.CreateForm(TfrmLihatGambar,frmLihatGambar);
  frmLihatGambar.KODEBARANG := CDSMaster.FieldByname('KODE').AsString;
  frmLihatGambar.ShowModal;
end;

end.
