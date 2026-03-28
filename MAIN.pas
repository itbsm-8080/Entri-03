
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}                           
{$WARN UNIT_DEPRECATED ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}           
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
unit MAIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, SqlExpr, ComCtrls, jpeg, ExtCtrls, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxLookAndFeels, dxSkinsForm,
  dxGDIPlusClasses, dxSkinsdxBarPainter, cxGraphics, cxControls,
  cxLookAndFeelPainters, dxRibbonSkins, cxClasses, dxRibbon, dxBar,
    dxNavBarCollns,
  dxNavBarBase, dxNavBar, dxBarDBNav,
  dxSkinsdxRibbonPainter,
   cxPC, dxDockControl,
  dxDockPanel, dxSkinsdxNavBar2Painter ,ShellAPI, ImgList, MyAccess;

type
  TfrmMenu = class(TForm)
    dxSkinController1: TdxSkinController;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    User1: TMenuItem;
    IdentitasPerusahaan1: TMenuItem;
    Relogin1: TMenuItem;
    Daftar1: TMenuItem;
    Persediaan1: TMenuItem;
    Penjualan1: TMenuItem;
    Barang1: TMenuItem;
    Katagori1: TMenuItem;
    Gudang1: TMenuItem;
    PenyesuaianStok1: TMenuItem;
    MutasiAntarGudang1: TMenuItem;
    Invoice1: TMenuItem;
    PenerimaanCustomer1: TMenuItem;
    ReturPenjualan1: TMenuItem;
    KasBank1: TMenuItem;
    PenerimaanLainlain1: TMenuItem;
    PembayaranLainlain1: TMenuItem;
    Bukubank1: TMenuItem;
    Utility1: TMenuItem;
    utupPeriode1: TMenuItem;
    Costcenter1: TMenuItem;
    Salesman1: TMenuItem;
    Customer1: TMenuItem;
    JenisCustomer1: TMenuItem;
    Laporan1: TMenuItem;
    ListFakturOutstanding1: TMenuItem;
    ListPenjualanFakturRiil1: TMenuItem;
    ListPenjualanperOutletRiil1: TMenuItem;
    N1: TMenuItem;
    ListPenjualanperItemAkumulatif1: TMenuItem;
    ListInkaso1: TMenuItem;
    N2: TMenuItem;
    MutasiStok1: TMenuItem;
    ListPenjualanperFakturwMargin1: TMenuItem;
    Jurnal1: TMenuItem;
    ListJurnal1: TMenuItem;
    N3: TMenuItem;
    LaporanYTD1: TMenuItem;
    HistoryHargaJual1: TMenuItem;
    KartuStok1: TMenuItem;
    Rekening1: TMenuItem;
    LaporanTransakskHarian1: TMenuItem;
    LaporanTransaksiHarianbyCustomer1: TMenuItem;
    LaporanSaldoPiutang1: TMenuItem;
    HistoryStok1: TMenuItem;
    dxDockSite1: TdxDockSite;
    dxNavBar2: TdxNavBar;
    dxNavBarGroup1: TdxNavBarGroup;
    dxNavBarGroup2: TdxNavBarGroup;
    dxNavBarGroup3: TdxNavBarGroup;
    dxNavBar2Group4: TdxNavBarGroup;
    dxUser: TdxNavBarItem;
    dxIdentitas: TdxNavBarItem;
    dxRelogin: TdxNavBarItem;
    dxDockPanel1: TdxDockPanel;
    dxLayoutDockSite1: TdxLayoutDockSite;
    dxCostcenter: TdxNavBarItem;
    dxSalesman: TdxNavBarItem;
    dxCustomer: TdxNavBarItem;
    dxSupplier: TdxNavBarItem;
    dxJenisCustomer: TdxNavBarItem;
    dxBarang: TdxNavBarItem;
    dxGudang: TdxNavBarItem;
    dxKategori: TdxNavBarItem;
    dxPenyesuaianStok: TdxNavBarItem;
    dxmutasigudang: TdxNavBarItem;
    dxFakturJual: TdxNavBarItem;
    dxPenerimaan: TdxNavBarItem;
    dxReturPenjualan: TdxNavBarItem;
    dxPesananBeli: TdxNavBarItem;
    dxPenerimaanBarang: TdxNavBarItem;
    dxFakturBeli: TdxNavBarItem;
    dxPembayaransup: TdxNavBarItem;
    dxReturBeli: TdxNavBarItem;
    dxBukuBank: TdxNavBarItem;
    dxPenerimaanlain: TdxNavBarItem;
    dxPembayaralain: TdxNavBarItem;
    dxJurnalUmum: TdxNavBarItem;
    dxlistJual: TdxNavBarItem;
    dxListPersediaan: TdxNavBarItem;
    dxFakturPajak: TdxNavBarItem;
    dxListJurnal: TdxNavBarItem;
    dxPencairanGiro: TdxNavBarItem;
    dxNavBar2Group1: TdxNavBarGroup;
    dxNavBar2Group2: TdxNavBarGroup;
    dxBukuBesar: TdxNavBarItem;
    LaporanItemterlarisStok1: TMenuItem;
    dxMusnah: TdxNavBarItem;
    LaporanSalesBulananvsTahunLalu1: TMenuItem;
    LaporanPencapaianSalesvsTahunLalu1: TMenuItem;
    Pembelian1: TMenuItem;
    PO1: TMenuItem;
    PenerimaanBarang1: TMenuItem;
    Invoice2: TMenuItem;
    PembayaranSupplier1: TMenuItem;
    ReturPembelian1: TMenuItem;
    dxNavBar2Group3: TdxNavBarGroup;
    N4: TMenuItem;
    LapUmurHutang1: TMenuItem;
    ProsesJurnalBulanan1: TMenuItem;
    LapBiayaBulanan1: TMenuItem;
    LaporanLabaRugi1: TMenuItem;
    LaporanNeraca1: TMenuItem;
    LapSaldoHutang1: TMenuItem;
    LaporanAnggaran1: TMenuItem;
    ImageList1: TImageList;
    Image1: TImage;
    dxNavBar2Group5: TdxNavBarGroup;
    dxSPK: TdxNavBarItem;
    dxmintabahan: TdxNavBarItem;
    dxreturbahan: TdxNavBarItem;
    dxSTBJ: TdxNavBarItem;
    dxHitungStok: TdxNavBarItem;
    KirimdatakePusat1: TMenuItem;
    ProsesAvgcost1: TMenuItem;
    ImportAbsensi1: TMenuItem;
    dxAbsensi: TdxNavBarItem;
    LaporanStokCabang1: TMenuItem;
    dxPesananJual: TdxNavBarItem;
    dxPengiriman: TdxNavBarItem;
    procedure FileExit1Execute(Sender: TObject);
    function ShowForm(AFormClass: TFormClass): TForm;
    procedure Maximized1Click(Sender: TObject);

    procedure FormShow(Sender: TObject);
    procedure bacafile;

    procedure Exit1Click(Sender: TObject);
    procedure frmUserClick(Sender: TObject);
    procedure frmRELoginClick(Sender: TObject);
    procedure dxNavBar1Item1Click(Sender: TObject);
    procedure dxGudangClick(Sender: TObject);
    procedure dxCostcenterClick(Sender: TObject);
    procedure dxSalesmanClick(Sender: TObject);
    procedure dxCustomerClick(Sender: TObject);
    procedure dxSupplierClick(Sender: TObject);
    procedure dxJenisCustomerClick(Sender: TObject);
    procedure dxReloginClick(Sender: TObject);
    procedure dxKategoriClick(Sender: TObject);
    procedure dxPesananJualClick(Sender: TObject);
    procedure dxBarangClick(Sender: TObject);
    procedure dxPesananBeliClick(Sender: TObject);
    procedure dxPenerimaanBarangClick(Sender: TObject);
    procedure dxFakturBeliClick(Sender: TObject);
    procedure dxFakturJualClick(Sender: TObject);
    procedure dxMutasiCabang2Click(Sender: TObject);
    procedure dxMutasiCabangClick(Sender: TObject);
    procedure dxmutasigudangClick(Sender: TObject);
    procedure dxPembayaransupClick(Sender: TObject);
    procedure dxPengirimanClick(Sender: TObject);
    procedure dxReturBeliClick(Sender: TObject);
    procedure dxfeeCustomerClick(Sender: TObject);
    procedure dxPenerimaanClick(Sender: TObject);
    procedure dxReturPenjualanClick(Sender: TObject);
    procedure dxPenerimaanlainClick(Sender: TObject);
    procedure dxPembayaralainClick(Sender: TObject);
    procedure dxhitungstokClick(Sender: TObject);
    procedure dxlistJualClick(Sender: TObject);
    procedure dxPenyesuaianStokClick(Sender: TObject);
    procedure dxListPersediaanClick(Sender: TObject);
    procedure dxFakturBayanganClick(Sender: TObject);
    procedure ListPenjualanPerItem1Click(Sender: TObject);
    procedure ListPenjualanvsTarget1Click(Sender: TObject);
    procedure ListFakturOutstanding1Click(Sender: TObject);
    procedure ListPenjualanFakturRiil1Click(Sender: TObject);
    procedure ListPenjualanperOutletRiil1Click(Sender: TObject);
    procedure ListPenjualanperItemAkumulatif1Click(Sender: TObject);
    procedure ListInkaso1Click(Sender: TObject);
    procedure MutasiStok1Click(Sender: TObject);
    procedure ListPenjualanperFakturwMargin1Click(Sender: TObject);
    procedure dxBukuBankClick(Sender: TObject);
    procedure dxFakturPajakClick(Sender: TObject);
    procedure dxJurnalUmumClick(Sender: TObject);
    procedure dxListJurnalClick(Sender: TObject);
    procedure User1Click(Sender: TObject);
    procedure IdentitasPerusahaan1Click(Sender: TObject);
    procedure Relogin1Click(Sender: TObject);
    procedure dxIdentitasClick(Sender: TObject);
    procedure Costcenter1Click(Sender: TObject);
    procedure Salesman1Click(Sender: TObject);
    procedure Customer1Click(Sender: TObject);
    procedure JenisCustomer1Click(Sender: TObject);
    procedure Barang1Click(Sender: TObject);
    procedure Katagori1Click(Sender: TObject);
    procedure Gudang1Click(Sender: TObject);
    procedure PenyesuaianStok1Click(Sender: TObject);
    procedure MutasiAntarGudang1Click(Sender: TObject);
    procedure MutasiantarCabang1Click(Sender: TObject);
    procedure MutasiCabangIn1Click(Sender: TObject);
    procedure PesananPenjuaalan1Click(Sender: TObject);
    procedure Pengiriman1Click(Sender: TObject);
    procedure Invoice1Click(Sender: TObject);
    procedure PenerimaanCustomer1Click(Sender: TObject);
    procedure ReturPenjualan1Click(Sender: TObject);
    procedure PenerimaanLainlain1Click(Sender: TObject);
    procedure PembayaranLainlain1Click(Sender: TObject);
    procedure Bukubank1Click(Sender: TObject);
    procedure Jurnal1Click(Sender: TObject);
    procedure ListJurnal1Click(Sender: TObject);
    procedure LaporanSalesBulanan1Click(Sender: TObject);
    procedure LaporanYTD1Click(Sender: TObject);
    procedure HistoryHargaJual1Click(Sender: TObject);
    procedure LaporanInkasoperSalesman1Click(Sender: TObject);
    procedure KartuStok1Click(Sender: TObject);
    procedure Rekening1Click(Sender: TObject);
    procedure LaporanTransakskHarian1Click(Sender: TObject);
    procedure dxPencairanGiroClick(Sender: TObject);
    procedure LaporanTransaksiHarianbyCustomer1Click(Sender: TObject);
    procedure LaporanTargetvsRealisasi1Click(Sender: TObject);
    procedure LaporanSaldoPiutang1Click(Sender: TObject);
    procedure HistoryStok1Click(Sender: TObject);
    procedure LaporanItemMarginMinusLastcost1Click(Sender: TObject);
    procedure StokExpired1Click(Sender: TObject);
    procedure dxDockPanel1AutoHideChanged(Sender: TdxCustomDockControl);
    procedure dxbayarbiayapromosiClick(Sender: TObject);
    procedure dxMusnahClick(Sender: TObject);
    procedure dxSetingBiayapromosiClick(Sender: TObject);
    procedure frmListKas2Click(Sender: TObject);
    procedure KomisiMarketing1Click(Sender: TObject);
    procedure KomisiSalesman1Click(Sender: TObject);
    procedure LaporanItemterlarisStok1Click(Sender: TObject);
    procedure LaporanPencapaianSalesvsTahunLalu1Click(Sender: TObject);
    procedure LaporanSalesBulananvsTahunLalu1Click(Sender: TObject);
    procedure SerahTerimaFaktur1Click(Sender: TObject);
    procedure SetingCustomer1Click(Sender: TObject);
    procedure SettingKomisi1Click(Sender: TObject);
    procedure SettingKomisi2Click(Sender: TObject);
    procedure utupPeriode1Click(Sender: TObject);
    procedure ProsesBiayaPromosi1Click(Sender: TObject);
    procedure SetingEstimasiSalesman1Click(Sender: TObject);
    procedure LaporanEstimasisalesmanvsRealisasi1Click(Sender: TObject);
    procedure LapUmurHutang1Click(Sender: TObject);
    procedure dxTandaTerimaClick(Sender: TObject);
    procedure ProsesJurnalBulanan1Click(Sender: TObject);
    procedure LapBiayaBulanan1Click(Sender: TObject);
    procedure ProsesGaji1Click(Sender: TObject);
    procedure LaporanLabaRugi1Click(Sender: TObject);
    procedure LaporanNeraca1Click(Sender: TObject);
    procedure ProsesAvgcost1Click(Sender: TObject);
    procedure LapSaldoHutang1Click(Sender: TObject);
    procedure LaporanAnggaran1Click(Sender: TObject);
    procedure dxSPKClick(Sender: TObject);
    procedure dxmintabahanClick(Sender: TObject);
    procedure KirimdatakePusat1Click(Sender: TObject);
    procedure dxSTBJClick(Sender: TObject);
    procedure ImportAbsensi1Click(Sender: TObject);
    procedure dxAbsensiClick(Sender: TObject);
    procedure LaporanStokCabang1Click(Sender: TObject);
    procedure dxreturbahanClick(Sender: TObject);


  private
    { Private declarations }

    FaDatabase2: string;
    FaHost2: string;
    Fapassword2: string;
    Fauser2: string;
    Faport: Integer;
    FaDatabase: string;
    FaHost: string;
    Fapassword: string;
    Fauser: string;
    Fapathimage : string;

  public
    { Public declarations }
    // conn: TSQLConnection;
    // conn2 : TSQLConnection;
    conn: TMyConnection;
    conn2: TMyConnection;
        KDUSER,NMUSER,KDCABANG,NMCABANG : String;
        otorisasi : Boolean;
      property aDatabase: string read FaDatabase write FaDatabase;
      property aHost: string read FaHost write FaHost;
      property apassword: string read Fapassword write Fapassword;
      property apathimage: string read Fapathimage write Fapathimage;
      property auser: string read Fauser write Fauser;
      property aport: Integer read Faport write Faport;
      property aDatabase2: string read FaDatabase2 write FaDatabase2;
      property aHost2: string read FaHost2 write FaHost2;
      property apassword2: string read Fapassword2 write Fapassword2;
      property auser2: string read Fauser2 write Fauser2;
  end;

var

  frmMenu: TfrmMenu;

//  for help / bantuan...
  varglobal : string;
  varglobal1 : string;
  varglobal2 : string;
  sqlbantuan : string;
  sqlfilter : string;
    zVersi:string;

implementation
 uses Ulib,uModuleConnection,ufrmUser, UfrmLogin,ufrmBrowseGudang,ufrmBrowseCostCenter,
 ufrmBrowseSalesman,ufrmBrowseCustomer,ufrmBrowseSupplier,ufrmBrowseJC,ufrmBrowseSubBarang,
 ufrmBrowsePesanan,ufrmBrowseBarang,ufrmBrowsePO,ufrmBrowseBPB,ufrmBrowseInvoice,
 ufrmBrowseMutasiGudang,ufrmBrowseBayarSupplier,ufrmBrowseMutasiCabang,ufrmBrowseReturBeli,ufrmBrowseMutasiCabang2,
 ufrmBrowseDO,ufrmBrowseFP,ufrmBrowseFeeCustomer,ufrmBrowseBayarCustomer,ufrmBrowseReturJual,ufrmBrowsePenerimaanLain,
 ufrmBrowsePembayaranLain,ufrmBrowseHitungStok,ufrmListJual,ufrmBrowseKoreksiStok,
 ufrmLapPersediaan,ufrmListJualvsTarget,ufrmListFOS,ufrmListJual2,ufrmlistjual3,ufrmListJual4,
 ufrmListInkaso,ufrmListMutasiStok,ufrmListJual5,ufrmBrowseFPBayangan,ufrmListKas,ufrmBrowseFakturPajak,
 ufrmBrowseJurnalUmum,ufrmBrowseJurnal,ufrmBrowseJurnal2,ufrmperusahaan,ufrmLapBulanan,ufrmLapYTD,ufrmBrowseHistoryHargaJual,
 ufrmLapBulananInkaso,ufrmBrowseKartuStok,ufrmBrowseRekening,ufrmListTransaksiHarian,ufrmBrowsePencairanGiro,
 ufrmListTransaksiHarian2,ufrmLapBulanan2,ufrmListSaldoPiutang,ufrmListMutasiStok2,ufrmListItemMinus,
 ufrmBrowseStokExpired,ufrmBrowseBayarBiayaPromosi,ufrmLapStokItemTerlaris,ufrmSalesMarketing,
 ufrmSettingKomisi,ufrmKomisiMarketing,ufrmSettingKomisi2,ufrmKomisiSalesman,ufrmListKas2,ufrmtutupperiode,
 ufrmBrowseMusnah,ufrmBrowseSerahTerimaFaktur,ufrmBrowseSetingBiayaPromosi,ufrmLapBulanan3,
 ufrmLapPencapaianSales,ufrmProsesBiayaPromosi,ufrmEstimasiSales,ufrmBrowseEstimasiSales,ufrmListIOS,ufrmBrowseTandaTerima,
 ufrmPostingJurnalBulanan,ufrmLapBiayaBulanan,ufrmProsesGaji,ufrmLapLabaRugi,ufrmLapNeraca,ufrmProsesAvgcost,
 ufrmListSaldoHutang,ufrmLapAnggaran,
 ufrmBrowseSPK,ufrmbrowsemintabahan,ufrmUpload,ufrmbrowsestbj,
 ufrmimportabsensi,ufrmlapabsensi,ufrmliststokcabang,ufrmbrowsereturbahan;
{$R *.dfm}


procedure TfrmMenu.FileExit1Execute(Sender: TObject);
begin
  application.terminate;
end;

function TfrmMenu.ShowForm(AFormClass: TFormClass): TForm;
var
  aForm: TForm;
  i: Integer;
begin
//  inherited;
  if ( not ceKVIEW(frmMenu.KDUSER,AFormClass.ClassName)) then
        begin
           MessageDlg('Anda tidak berhak Membuka di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
  for i := 0 to MDIChildCount - 1 do
  begin
    if MDIChildren[i].ClassName = AFormClass.ClassName then
    begin
      Result := MDIChildren[i];
      // mdiChildrenTabs.TabIndex := GetTabSetIndex(Result);
      Exit;
    end;
  end;

  aForm := AFormClass.Create(Application);
  aForm.FormStyle := fsMDIChild;
//  aForm.Position := poDefault;


//  aForm.WindowState := wsMaximized;
  Result := (aForm as AFormClass);

end;

procedure TfrmMenu.Maximized1Click(Sender: TObject);
begin
  if MDIChildCount <> 0 then
   ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TfrmMenu.FormShow(Sender: TObject);
var
   sql:string;
   tsql:TMyQuery;
    AppVersi,DbVersi:Double;
begin

      bacafile;
      StatusBar1.Panels[1].Text := 'Connected  to ' + aHost;
      StatusBar1.Panels[2].Text := 'Database  ' + aDatabase;
      // conn := xCreateConnection(ctMySQL,aHost,aDatabase,auser,apassword);
      conn := xCreateMyConnection(ctMySQL,aHost,aDatabase,auser,apassword, aport);
      ThousandSeparator:=',';
      ShortDateFormat := 'M/d/yyyy';
      DateSeparator   := '/';
      DecimalSeparator:= '.';
      zVersi:='5.0.20';
      StatusBar1.Panels[4].Text := 'Versi ' + zversi;
      Application.UpdateFormatSettings:=True;
// cek ver si
  sql:='select versi from tversi where aplikasi="ENTRI"';
  tsql := xOpenQuery(sql,frmmenu.conn);
  AppVersi:=StrToFloat(StringReplace(zVersi,'.','',[rfReplaceAll]));
  DbVersi:=StrToFloat(StringReplace(tsql.FieldByName('versi').AsString,'.','',[rfReplaceAll]));
  if AppVersi<dbVersi then
  begin
    ShowMessage('Program belum Update, Hubungi Programmer');
    Application.Terminate;
  end;
  frmLogin.Show;
end;

procedure TfrmMenu.bacafile;
 var
 ltemp : TStringList;

 begin
 ltemp := TStringList.Create;
 ltemp.loadfromfile(ExtractFileDir(application.ExeName) + '\' + 'default.cfg');
   aHost     := ltemp[0];
   aDatabase := ltemp[1];
   auser     := ltemp[2];
   apassword := ltemp [3];
   apathimage := ltemp [5];
   aport := StrToInt(ltemp[6]);
   ltemp.free;
 end;


procedure TfrmMenu.Exit1Click(Sender: TObject);
begin
 Close;
end;

procedure TfrmMenu.frmUserClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Master User' then
 begin
    ShowForm(TfrmUser).Show;
 end;
    ActiveMDIChild.WindowState := wsMaximized;

end;

procedure TfrmMenu.frmRELoginClick(Sender: TObject);
var
  i : Integer;
begin
   for i := 0 to MDIChildCount - 1 do
   begin
      MDIChildren[i].Release;
   end;
   Self.Enabled := False;
   frmlogin.edtuser.Clear;
   frmlogin.edtPassword.Clear;
   frmLogin.Show;
end;


procedure TfrmMenu.dxNavBar1Item1Click(Sender: TObject);
begin
frmUserClick(self);
end;

procedure TfrmMenu.dxGudangClick(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Browse Gudang' then
 begin
    ShowForm(TfrmBrowseGudang).Show;
 end;
//    ActiveMDIChild.WindowState := wsMaximized;

end;

procedure TfrmMenu.dxCostcenterClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Cost Center' then
 begin
    ShowForm(TfrmBrowseCostCenter).Show;
 end;
end;

procedure TfrmMenu.dxSalesmanClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Salesman' then
 begin
    ShowForm(TfrmBrowseSalesman).Show;
 end;

end;

procedure TfrmMenu.dxCustomerClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Customer' then
 begin
    ShowForm(TfrmBrowseCustomer).Show;
 end;

end;

procedure TfrmMenu.dxSupplierClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Supplier' then
 begin
    ShowForm(TfrmBrowseSupplier).Show;
 end;

end;

procedure TfrmMenu.dxJenisCustomerClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Jenis Customer' then
 begin
    ShowForm(TfrmBrowseJC).Show;
 end;

end;

procedure TfrmMenu.dxReloginClick(Sender: TObject);
var
  i : Integer;
begin
   for i := 0 to MDIChildCount - 1 do
  begin
      MDIChildren[i].Release;
  end;
   Self.Enabled := False;
   frmlogin.edtuser.Clear;
   frmlogin.edtPassword.Clear;
   frmLogin.Show;

end;


procedure TfrmMenu.dxKategoriClick(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Browse SubBarang' then
 begin
    ShowForm(TfrmBrowseSubBarang).Show;
 end;
end;

procedure TfrmMenu.dxPesananJualClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Pesanan' then
 begin
    ShowForm(TfrmBrowsePesanan).Show;
 end;
end;

procedure TfrmMenu.dxBarangClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Barang' then
 begin
    ShowForm(TfrmBrowseBarang).Show;
 end;
end;

procedure TfrmMenu.dxPesananBeliClick(Sender: TObject);
begin
      if ActiveMDIChild.Caption <> 'Browse PO' then
 begin
    ShowForm(TfrmBrowsePO).Show;
 end;
end;

procedure TfrmMenu.dxPenerimaanBarangClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse BPB' then
 begin
    ShowForm(TfrmBrowseBPB).Show;
 end;
end;

procedure TfrmMenu.dxFakturBeliClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Invoice' then
 begin
    ShowForm(TfrmBrowseInvoice).Show;
 end;

end;

procedure TfrmMenu.dxFakturJualClick(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Browse Faktur Penjualan' then
 begin
    ShowForm(TfrmBrowseFP).Show;
 end;
end;

procedure TfrmMenu.dxMutasiCabang2Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Mutasi Cabang In' then
 begin
    ShowForm(TfrmBrowseMutasiCabang2).Show;
 end;
end;

procedure TfrmMenu.dxMutasiCabangClick(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Browse Mutasi Cabang' then
 begin
    ShowForm(TfrmBrowseMutasiCabang).Show;
 end;

end;

procedure TfrmMenu.dxmutasigudangClick(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Browse Mutasi Gudang' then
 begin
    ShowForm(TfrmBrowseMutasiGudang).Show;
 end;
end;

procedure TfrmMenu.dxPembayaransupClick(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Browse Pembayaran Supplier' then
 begin
    ShowForm(TfrmBrowseBayarSupplier).Show;
 end;

end;

procedure TfrmMenu.dxPengirimanClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Pengiriman Barang' then
 begin
    ShowForm(TfrmBrowseDO).Show;
 end;
end;

procedure TfrmMenu.dxReturBeliClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Retur Beli' then
 begin
    ShowForm(TfrmBrowseReturBeli).Show;
 end;

end;

procedure TfrmMenu.dxfeeCustomerClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Fee Customer' then
 begin
    ShowForm(TfrmBrowseFeeCustomer).Show;
 end;

end;

procedure TfrmMenu.dxPenerimaanClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Pembayaran Customer' then
 begin
    ShowForm(TfrmBrowseBayarCustomer).Show;
 end;

end;

procedure TfrmMenu.dxReturPenjualanClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Retur Jual' then
 begin
    ShowForm(TfrmBrowseReturJual).Show;
 end;
end;

procedure TfrmMenu.dxPenerimaanlainClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Penerimaan Lain Lain' then
 begin
    ShowForm(TfrmBrowsePenerimaanLain).Show;
 end;

end;

procedure TfrmMenu.dxPembayaralainClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Browse Pembayaran Lain Lain' then
 begin
    ShowForm(TfrmBrowsePembayaranLain).Show;
 end;

end;

procedure TfrmMenu.dxhitungstokClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Hitung Stok' then
 begin
    ShowForm(TfrmBrowseHitungStok).Show;
 end;

end;

procedure TfrmMenu.dxlistJualClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Item' then
 begin
    ShowForm(TfrmListJual).Show;
 end;

end;

procedure TfrmMenu.dxPenyesuaianStokClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Koreksi Stok' then
 begin
    ShowForm(TfrmBrowseKoreksiStok).Show;
 end;

end;

procedure TfrmMenu.dxListPersediaanClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Persediaan' then
 begin
    ShowForm(TfrmLapPersediaan).Show;
 end;

end;

procedure TfrmMenu.dxFakturBayanganClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Faktur Penjualan Manual' then
 begin
    ShowForm(TfrmbrowsefpBAYANGAN).Show;
 end;


end;

procedure TfrmMenu.ListPenjualanPerItem1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Item' then
 begin
    ShowForm(TfrmListJual).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanvsTarget1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan vs Target' then
 begin
    ShowForm(TfrmListJualvsTarget).Show;
 end;

end;

procedure TfrmMenu.ListFakturOutstanding1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Faktur Outstanding' then
 begin
    ShowForm(TfrmListFOS).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanFakturRiil1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Faktur' then
 begin
    ShowForm(TfrmListJual2).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanperOutletRiil1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Outlet' then
 begin
    ShowForm(TfrmListJual3).Show;
 end;

end;

procedure TfrmMenu.ListPenjualanperItemAkumulatif1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Penjualan per Item (Akumulatif)' then
 begin
    ShowForm(TfrmListJual4).Show;
 end;

end;

procedure TfrmMenu.ListInkaso1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Inkaso' then
 begin
    ShowForm(TfrmListInkaso).Show;
 end;

end;

procedure TfrmMenu.MutasiStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Mutasi Stok' then
 begin
    ShowForm(TfrmListMutasiStok).Show;
 end;


end;

procedure TfrmMenu.ListPenjualanperFakturwMargin1Click(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'List Penjualan per Faktur (Margin)' then
 begin
    ShowForm(TfrmListJual5).Show;
 end;

end;

procedure TfrmMenu.dxBukuBankClick(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'Buku Bank' then
 begin
    ShowForm(TfrmlistKas).Show;
 end;

end;

procedure TfrmMenu.dxFakturPajakClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Faktur Pajak' then
 begin
    ShowForm(TfrmBrowseFakturPajak).Show;
 end;

end;

procedure TfrmMenu.dxJurnalUmumClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Jurnal Umum' then
 begin
    ShowForm(TfrmBrowseJurnalUmum).Show;
 end;

end;

procedure TfrmMenu.dxListJurnalClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Jurnal' then
 begin
    ShowForm(TfrmBrowseJurnal2).Show;
 end;

end;

procedure TfrmMenu.User1Click(Sender: TObject);
begin
frmUserClick(self);
  end;

procedure TfrmMenu.IdentitasPerusahaan1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Identitas Perusahaan' then
 begin
    ShowForm(TfrmPerusahaan).Show;
 end;
    ActiveMDIChild.WindowState := wsMaximized;

end;

procedure TfrmMenu.Relogin1Click(Sender: TObject);
var
  i : Integer;
begin
   for i := 0 to MDIChildCount - 1 do
  begin
      MDIChildren[i].Release;
  end;
   Self.Enabled := False;
   frmlogin.edtuser.Clear;
   frmlogin.edtPassword.Clear;
   frmLogin.Show;

end;

procedure TfrmMenu.dxIdentitasClick(Sender: TObject);
begin
 IdentitasPerusahaan1Click(Self);
end;

procedure TfrmMenu.Costcenter1Click(Sender: TObject);
begin
  dxCostcenterClick(Self)
end;

procedure TfrmMenu.Salesman1Click(Sender: TObject);
begin
  dxSalesmanClick(Self);
end;

procedure TfrmMenu.Customer1Click(Sender: TObject);
begin
  dxCustomerClick(Self);
end;

procedure TfrmMenu.JenisCustomer1Click(Sender: TObject);
begin
   dxJenisCustomerClick(Self);
end;

procedure TfrmMenu.Barang1Click(Sender: TObject);
begin
  dxBarangClick(Self);
end;

procedure TfrmMenu.Katagori1Click(Sender: TObject);
begin
   dxKategoriClick(Self);
end;

procedure TfrmMenu.Gudang1Click(Sender: TObject);
begin
  dxGudangClick(Self);
end;

procedure TfrmMenu.PenyesuaianStok1Click(Sender: TObject);
begin
   dxPenyesuaianStokClick(Self);
end;

procedure TfrmMenu.MutasiAntarGudang1Click(Sender: TObject);
begin
   dxmutasigudangClick(Self);
end;

procedure TfrmMenu.MutasiantarCabang1Click(Sender: TObject);
begin
    dxMutasiCabangClick(Self);
end;

procedure TfrmMenu.MutasiCabangIn1Click(Sender: TObject);
begin
dxMutasiCabang2Click(Self)
end;

procedure TfrmMenu.PesananPenjuaalan1Click(Sender: TObject);
begin
  dxPesananJualClick(Self);
end;

procedure TfrmMenu.Pengiriman1Click(Sender: TObject);
begin
  dxPengirimanClick(Self);
end;

procedure TfrmMenu.Invoice1Click(Sender: TObject);
begin
  dxFakturJualClick(Self);
end;

procedure TfrmMenu.PenerimaanCustomer1Click(Sender: TObject);
begin
  dxPenerimaanClick(Self);
end;

procedure TfrmMenu.ReturPenjualan1Click(Sender: TObject);
begin
  dxReturPenjualanClick(Self);
end;

procedure TfrmMenu.PenerimaanLainlain1Click(Sender: TObject);
begin
  dxPenerimaanlainClick(self);
end;

procedure TfrmMenu.PembayaranLainlain1Click(Sender: TObject);
begin
  dxPembayaralainClick(Self);
end;

procedure TfrmMenu.Bukubank1Click(Sender: TObject);
begin
   dxBukuBankClick(self);
end;

procedure TfrmMenu.Jurnal1Click(Sender: TObject);
begin
  dxJurnalUmumClick(Self);
end;

procedure TfrmMenu.ListJurnal1Click(Sender: TObject);
begin
   dxListJurnalClick(Self);
end;

procedure TfrmMenu.LaporanSalesBulanan1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Sales Bulanan' then
 begin
    ShowForm(TfrmLapBulanan).Show;
 end;

end;

procedure TfrmMenu.LaporanYTD1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan YTD' then
 begin
    ShowForm(TfrmLapYTD).Show;
 end;

end;

procedure TfrmMenu.HistoryHargaJual1Click(Sender: TObject);
begin

 if ActiveMDIChild.Caption <> 'Browse History Harga Jual' then
 begin
    ShowForm(TfrmBrowseHistoryHargaJual).Show;
 end;

end;

procedure TfrmMenu.LaporanInkasoperSalesman1Click(Sender: TObject);
begin

 if ActiveMDIChild.Caption <> 'Laporan Inkaso Bulanan' then
 begin
    ShowForm(TfrmLapbulananinkaso).Show;
 end;

end;

procedure TfrmMenu.KartuStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Kartu Stok' then
 begin
    ShowForm(TfrmBrowseKartuStok).Show;
 end;

end;

procedure TfrmMenu.Rekening1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Rekening' then
 begin
    ShowForm(TfrmBrowseRekening).Show;
 end;

end;

procedure TfrmMenu.LaporanTransakskHarian1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Transaksi Harian' then
 begin
    ShowForm(TfrmListTransaksiHarian).Show;
 end;

end;

procedure TfrmMenu.dxPencairanGiroClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Browse Pencairan Giro' then
 begin
    ShowForm(TfrmBrowsePencairanGiro).Show;
 end;

end;

procedure TfrmMenu.LaporanTransaksiHarianbyCustomer1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Transaksi Harian by Customer' then
 begin
    ShowForm(TfrmListTransaksiHarian2).Show;
 end;

end;

procedure TfrmMenu.LaporanTargetvsRealisasi1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Target vs Realisasi Bulanan' then
 begin
    ShowForm(TfrmLapBulanan2).Show;
 end;


end;

procedure TfrmMenu.LaporanSaldoPiutang1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Saldo Piutang' then
 begin
    ShowForm(TfrmListSaldoPiutang).Show;
 end;

end;

procedure TfrmMenu.HistoryStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'History Stok' then
 begin
    ShowForm(TfrmListMutasiStok2).Show;
 end;

end;

procedure TfrmMenu.LaporanItemMarginMinusLastcost1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'List Item Margin Minus' then
 begin
    ShowForm(TfrmListItemMinus).Show;
 end;

end;

procedure TfrmMenu.StokExpired1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Stok Expired' then
 begin
    ShowForm(TfrmBrowseStokExpired).Show;
 end;

end;

procedure TfrmMenu.dxDockPanel1AutoHideChanged(
  Sender: TdxCustomDockControl);
begin
  if dxDockPanel1.AutoHide then
     dxDockSite1.Width := 24
  else
     dxDockSite1.Width := 200;
end;

procedure TfrmMenu.dxbayarbiayapromosiClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Pembayaran Biaya Promosi' then
 begin
    ShowForm(TfrmBrowseBayarBiayapromosi).Show;
 end;
end;

procedure TfrmMenu.dxMusnahClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Pemusnahan' then
 begin
    ShowForm(TfrmBrowseMusnah).Show;
 end;

end;

procedure TfrmMenu.dxSetingBiayapromosiClick(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Seting Biaya Promosi' then
 begin
    ShowForm(TfrmBrowseSetingBiayaPromosi).Show;
 end;

end;

procedure TfrmMenu.frmListKas2Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Kas Harian' then
 begin
    ShowForm(TfrmListKas2).Show;
 end;

end;

procedure TfrmMenu.KomisiMarketing1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Komisi Marketing' then
 begin
    ShowForm(TfrmKomisiMarketing).Show;
 end;
end;

procedure TfrmMenu.KomisiSalesman1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Komisi Salesman' then
 begin
    ShowForm(TfrmKomisiSalesman).Show;
 end;

end;

procedure TfrmMenu.LaporanItemterlarisStok1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Stok Item terlaris' then
 begin
    ShowForm(TfrmLapStokItemterlaris).Show;
 end;
end;

procedure TfrmMenu.LaporanPencapaianSalesvsTahunLalu1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Laporan Pencapaian Sales New' then
 begin
    ShowForm(TfrmLapPencapaianSales).Show;
 end;
end;

procedure TfrmMenu.LaporanSalesBulananvsTahunLalu1Click(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'Laporan Sales Bulanan New' then
 begin
    ShowForm(TfrmLapBulanan3).Show;
 end;
end;

procedure TfrmMenu.SerahTerimaFaktur1Click(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'Browse Serah Terima Faktur' then
 begin
    ShowForm(TfrmBrowseSerahTerimaFaktur).Show;
 end;
end;

procedure TfrmMenu.SetingCustomer1Click(Sender: TObject);
begin
 if ActiveMDIChild.Caption <> 'Sales Marketing' then
 begin
    ShowForm(TfrmSalesMarketing).Show;
 end;
end;

procedure TfrmMenu.SettingKomisi1Click(Sender: TObject);
begin
   if ActiveMDIChild.Caption <> 'Setting Komisi' then
   begin
      ShowForm(TfrmSettingKomisi).Show;
   end;
end;

procedure TfrmMenu.SettingKomisi2Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Setting Komisi Salesman' then
   begin
      ShowForm(TfrmSettingKomisi2).Show;
   end;
end;

procedure TfrmMenu.utupPeriode1Click(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Tutup Periode' then
   begin
      ShowForm(TfrmTutupPeriode).Show;
   end;
end;

procedure TfrmMenu.ProsesBiayaPromosi1Click(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Proses Biaya promosi' then
   begin
      ShowForm(TfrmProsesBiayaPromosi).Show;
   end;

end;

procedure TfrmMenu.SetingEstimasiSalesman1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Estimasi Salesman' then
   begin
      ShowForm(TfrmEstimasiSales).Show;
   end;
end;

procedure TfrmMenu.LaporanEstimasisalesmanvsRealisasi1Click(
  Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Laporan Estimasi Salesman' then
   begin
      ShowForm(TfrmBrowseEstimasiSales).Show;
   end;

end;


procedure TfrmMenu.LapUmurHutang1Click(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Lap. Umur Hutang' then
   begin
      ShowForm(TfrmListIos).Show;
   end;


end;

procedure TfrmMenu.dxTandaTerimaClick(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Tanda Terima' then
   begin
      ShowForm(TfrmBrowseTandaterima).Show;
   end;

end;

procedure TfrmMenu.ProsesJurnalBulanan1Click(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Posting Jurnal Bulanan' then
   begin
      ShowForm(TfrmPostingJurnalBulanan).Show;
   end;

end;

procedure TfrmMenu.LapBiayaBulanan1Click(Sender: TObject);
begin
    if ActiveMDIChild.Caption <> 'Laporan Biaya Bulanan' then
   begin
      ShowForm(TfrmLapBiayaBulanan).Show;
   end;

end;

procedure TfrmMenu.ProsesGaji1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Proses Gaji' then
   begin
      ShowForm(TfrmProsesGAJI).Show;
   end;

end;

procedure TfrmMenu.LaporanLabaRugi1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Laba Rugi' then
   begin
      ShowForm(Tfrmlaplabarugi).Show;
   end;

end;

procedure TfrmMenu.LaporanNeraca1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Neraca' then
   begin
      ShowForm(TfrmlapNeraca).Show;
   end;

end;

procedure TfrmMenu.ProsesAvgcost1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Proses Avgcost' then
   begin
      ShowForm(TfrmProsesAvgcost).Show;
   end;

end;

procedure TfrmMenu.LapSaldoHutang1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Lap Saldo Hutang' then
   begin
      ShowForm(TfrmListSaldoHutang).Show;
   end;

end;

procedure TfrmMenu.LaporanAnggaran1Click(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Laporan Anggaran' then
   begin
      ShowForm(TfrmLapAnggaran).Show;
   end;

end;

procedure TfrmMenu.dxSPKClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'SPK' then
   begin
      ShowForm(TfrmBrowseSPK).Show;
   end;
end;

procedure TfrmMenu.dxmintabahanClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Permintaan Bahan' then
   begin
      ShowForm(TfrmBrowseMintaBahan).Show;
   end;

end;

procedure TfrmMenu.KirimdatakePusat1Click(Sender: TObject);
begin
     if ActiveMDIChild.Caption <> 'Kirim data ke pusat' then
   begin
      ShowForm(Tfrmupload).Show;
   end;

end;

procedure TfrmMenu.dxSTBJClick(Sender: TObject);
begin
        if ActiveMDIChild.Caption <> 'STBJ' then
   begin
      ShowForm(Tfrmbrowsestbj).Show;
   end;

end;

procedure TfrmMenu.ImportAbsensi1Click(Sender: TObject);
begin
        if ActiveMDIChild.Caption <> 'Import absensi' then
   begin
      ShowForm(Tfrmimportabsensi).Show;
   end;

end;

procedure TfrmMenu.dxAbsensiClick(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'Laporan Absensi' then
 begin
    ShowForm(TfrmLapAbsensi).Show;
   ActiveMDIChild.WindowState := wsMaximized;
 end;

end;

procedure TfrmMenu.LaporanStokCabang1Click(Sender: TObject);
begin
if ActiveMDIChild.Caption <> 'List Stok Cabang' then
 begin
    ShowForm(TfrmListStokCabang).Show;
   ActiveMDIChild.WindowState := wsMaximized;
 end;

end;

procedure TfrmMenu.dxreturbahanClick(Sender: TObject);
begin
  if ActiveMDIChild.Caption <> 'Browse Retur Bahan' then
 begin
    ShowForm(Tfrmbrowsereturbahan).Show;
   ActiveMDIChild.WindowState := wsMaximized;
 end;

end;

end.
