unit ufrmKoreksiStok2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  AdvPanel, AdvCGrid, BaseGrid,SqlExpr, DBAdvGrd, DB, DBClient, Provider,
  FMTBcd, RAWPrinter, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxSpinEdit, cxCalendar, Menus, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxButtonEdit, cxCurrencyEdit,ExcelXP,ComObj,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  AdvEdBtn, MyAccess;

type
  TfrmKoreksiStok2 = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label4: TLabel;
    dttanggal: TDateTimePicker;
    AdvPanel3: TAdvPanel;
    edtNomor: TAdvEdit;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clfisik: TcxGridDBColumn;
    clSatuan: TcxGridDBColumn;
    clExpired: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    clstoksystem: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clQtyKoreksi: TcxGridDBColumn;
    clHarga: TcxGridDBColumn;
    clNilai: TcxGridDBColumn;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Button3: TButton;
    Label1: TLabel;
    edtKodeBarang: TAdvEditBtn;
    edtQty: TAdvEdit;
    Label6: TLabel;
    edtNamaBarang: TAdvEdit;
    Button4: TButton;
    clGudang: TcxGridDBColumn;
    clNamaGudang: TcxGridDBColumn;
    Button5: TButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Label3: TLabel;
    Label5: TLabel;
    dtExpired: TDateTimePicker;
    edtIdBatch: TAdvEdit;
    Label7: TLabel;
    edtMemo: TAdvEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure refreshdata;
    procedure simpandata;
    procedure dosliP(anomor : string );
    function GetCDS: TClientDataSet;

    function getmaxkode:string;
    procedure FormCreate(Sender: TObject);
    procedure insertketampungan(anomor:string);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    function cekdata:Boolean;

    procedure initgrid;
    procedure HapusRecord1Click(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure cxLookupGudangAsalPropertiesEditValueChanged(
      Sender: TObject);
    procedure clQTYPropertiesEditValueChanged(Sender: TObject);
    procedure clSKUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure bantuansku;
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure edtKodeBarangClickBtn(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure clGudangPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure Button5Click(Sender: TObject);
    procedure clQtyKoreksiPropertiesEditValueChanged(Sender: TObject);
    private
     buttonSelected  : integer;
     FID : STRING;
     FCDSSKU : TClientDataset;
     FCDSGudang: TClientDataset;
        FFLAGEDIT: Boolean;
     xtotal : Double;
         function GetCDSGudang: TClientDataset;
         procedure initViewSKU;
      { Private declarations }
     protected
    FCDS: TClientDataSet;
  public
      property CDS: TClientDataSet read GetCDS write FCDS;
          property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
       property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
          property ID: string read FID write FID;
            property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    { Public declarations }
  end;
 const

    NOMERATOR = 'KOR';

var
  frmKoreksiStok2: TfrmKoreksiStok2;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmKoreksiStok2.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmKoreksiStok2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmKoreksiStok2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmKoreksiStok2.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  dttanggal.DateTime := Date;


  initgrid;
end;

procedure TfrmKoreksiStok2.simpandata;
var
  s:string;
  i:integer;
  tt : TStrings;
  anomor : string;
  asubtotal : Double;
begin
    asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('nilai'));
   if flagedit then
   begin
   anomor := edtNomor.Text;
      s:= 'update tkor_hdr set  '
         + ' korh_tanggal = ' + QuotD(dttanggal.DateTime)+','
         + ' korh_notes = ' + Quot('PRODUKSI ') + ','
         + ' korh_gdg_kode = ' + Quot('')+','
         + ' korh_total = ' + FloatToStr(asubtotal)+','
         + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
         + ' user_modified = ' + Quot(frmMenu.KDUSER)+','
         + ' korh_produksi = '+ quot(edtnamabarang.text) + ','
         + ' korh_expired = ' + quotd(dtexpired.Date) + ','
         + ' korh_idbatch='+ Quot(edtIdBatch.Text)+','
         + ' korh_memo = '+ Quot(edtmemo.Text)
         + ' where korh_nomor = ' + Quot(edtNomor.Text) ;
   end
   else
   begin
     anomor := getmaxkode;
     edtNomor.Text := anomor;
      s:= ' insert into tkor_hdr '
         + '( korh_nomor,korh_tanggal,korh_notes,korh_gdg_kode,korh_total,date_create,user_create,'
         + ' korh_expired,korh_idbatch,korh_produksi,korh_memo) values ( '
         + Quot(anomor) + ','
         + Quotd(dttanggal.DateTime)+','
         + Quot('PRODUKSI') + ','
         + Quot('')+','
         + FloatToStr(asubtotal)+','
         + QuotD(cGetServerTime,True) + ','
         + Quot(frmMenu.KDUSER) + ','
         + quotd(dtExpired.Date) + ','
         + Quot(edtIdBatch.text) + ','
         + Quot(edtNamaBarang.Text)+','
         + Quot(edtmemo.Text)
         +')';
   end;
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   tt := TStringList.Create;
   s:= ' delete from tkor_dtl '
      + ' where  kord_korh_nomor =' + quot(FID) ;
   tt.Append(s);
   i:=1;
    CDS.First;
while not CDS.Eof do
  begin
   if CDS.FieldByName('sku').AsInteger >  0 then
   begin
        s:='insert into tkor_dtl '
          + ' (kord_korh_nomor,kord_brg_kode,kord_satuan,kord_expired,kord_qty,kord_harga,kord_nilai,kord_stok,kord_nourut,kord_gdg_kode) values ( '
          +  Quot(anomor) + ','
          +  IntToStr(CDS.FieldByName('SKU').AsInteger) + ','
          +  quot(CDS.FieldByName('satuan').AsString) + ','
          + QuotD(CDS.FieldByName('expired').Asdatetime) +','
          +  floatToStr(CDS.FieldByName('qty').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('harga').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('nilai').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('fisik').Asfloat) + ','
          +  IntToStr(i) + ','
          + Quot(cds.fieldbyname('gudang').asstring)
          +');';
       tt.Append(s);
     end;
     CDS.next;
       Inc(i);
   end;

     try
        for i:=0 to tt.Count -1 do
        begin
            // xExecQuery(tt[i],frmMenu.conn);
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tt[i]);
         end;
      finally
        tt.Free;
      end;
end;
procedure TfrmKoreksiStok2.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'koreksi';

          s:= ' select '
       + ' *'
       + ' from tkor_hdr a '
       + ' inner join tampung e on e.nomor =a.korh_nomor '
       + ' left join  tkor_dtl b on korh_nomor=kord_korh_nomor and e.tam_nama=b.kord_brg_kode and e.expired=b.kord_expired'
       + ' left join tbarang c on b.kord_brg_kode=c.brg_kode '
       + ' LEFT join tgudang d on gdg_kode=korh_gdg_kode'
       + ' where '
       + ' a.korh_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmKoreksiStok2.insertketampungan(anomor:String);
var
  s:string;
  tsql : TMyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=14;
  s:='delete from tampung ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  s := 'select kord_BRG_kode,kord_expired from tkor_dtl where kord_korh_nomor =' + Quot(anomor) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;
  x:=0;
  tt:=TStringList.Create;

    with tsql do
    begin
      try
       while not Eof do
       begin
         x:=x+1;
          s :=   'insert  into tampung '
                  + '(nomor,tam_nama,expired'
                  + ')values ('
                  + Quot(anomor) + ','
                  + Quot(Fields[0].Asstring)+','
                  + quotd(Fields[1].AsDateTime)
                  + ');';
          tt.Append(s);
        Next
       end;
       finally
          free;
      end;
    end;


  for i := x to a do
   begin


        s :='insert  into tampung '
            + '(nomor,tam_nama'
            + ')values ('
            + Quot(anomor) + ','
            + Quot('-')
            + ');';
        tt.Append(s);

   end;
   try
    for i:=0 to tt.Count -1 do
    begin
        // xExecQuery(tt[i],frmMenu.conn);
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tt[i]);
    end;
  finally
    tt.Free;
  end;
    // xCommit(frmMenu.conn);

end;

function TfrmKoreksiStok2.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(korh_nomor,4)) from tkor_hdr  where korh_nomor like ' + quot(frmMenu.kdcabang + '-'+ NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%') ;

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
end;


procedure TfrmKoreksiStok2.FormCreate(Sender: TObject);
begin
//     initViewSKU;
 TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

function TfrmKoreksiStok2.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftString, False,255);
    zAddField(FCDS, 'NamaBarang', ftString, False,100);
    zAddField(FCDS, 'Satuan', ftString, False,10);
    zAddField(FCDS, 'QTY', ftFloat, False);
    zAddField(FCDS, 'expired', ftDate, False,255);
    zAddField(FCDS, 'fisik', ftFloat, False);
    zAddField(FCDS, 'system', ftFloat, False);
    zAddField(FCDS, 'harga', ftfloat, False);
    zAddField(FCDS, 'nilai', ftfloat, False);
    zAddField(FCDS, 'gudang', ftString, False,10);
    zAddField(FCDS, 'namagudang', ftString, False,40);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmKoreksiStok2.GetCDSGudang: TClientDataset;
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


 procedure TfrmKoreksiStok2.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan,mst_expired_date expired,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode '
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date ';

  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);

  with TcxExtLookupHelper(clSatuan.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','Satuan',['SKU','NamaBarang','expired'],Self);

end;

procedure TfrmKoreksiStok2.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmKoreksiStok2.cxButton2Click(Sender: TObject);
begin
  try
     If not cekdata then exit;

      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
    Release;
end;

procedure TfrmKoreksiStok2.cxButton1Click(Sender: TObject);
begin
 try
      If not cekdata then exit;

      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;


function TfrmKoreksiStok2.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;

  CDS.First;
  While not CDS.Eof do
  begin



    If CDS.FieldByName('SKU').AsInteger = 0 then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;


    inc(i);
    CDS.Next;
  end;
end;



procedure TfrmKoreksiStok2.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').asfloat  := 0;
  CDS.FieldByName('harga').asfloat  := 0;
  CDS.FieldByName('nilai').asfloat  := 0;
  CDS.Post;

end;



procedure TfrmKoreksiStok2.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmKoreksiStok2.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmKoreksiStok2.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmKoreksiStok2.clQTYPropertiesEditValueChanged(
  Sender: TObject);
  var
    i:integer;
    lVal : double;
begin
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
   i := cxGrdMain.DataController.FocusedRecordIndex;
  cxGrdMain.DataController.Values[i, clQTYkoreksi.Index] := cxGrdMain.DataController.Values[i, clfisik.Index]-cxGrdMain.DataController.Values[i, clstoksystem.Index];

  lVal := cxGrdMain.DataController.Values[i, clQTYkoreksi.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index];

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('qty').AsFloat := cxGrdMain.DataController.Values[i, clfisik.Index]-cxGrdMain.DataController.Values[i, clstoksystem.Index];
  CDS.FieldByName('nilai').AsFloat := lVal;
  CDS.Post;

end;

procedure TfrmKoreksiStok2.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
 bantuansku;

end;

procedure TfrmKoreksiStok2.bantuansku;
  var
    s:string;
    tsql2,tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku, brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' left join tmasterstok  on mst_brg_kode=brg_kode '
  + ' group by brg_kode , brg_nama , brg_satuan ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
     for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = StrToInt(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i) then
      begin

        ShowMessage('Sku ada yang sama dengan baris '+ IntToStr(i+1));
        CDS.Cancel;
        exit;
      end;
    end;
 If CDS.State <> dsEdit then
   CDS.Edit;

      CDS.FieldByName('sku').AsInteger := StrToInt(varglobal);
//      CDS.FieldByName('expired').AsDateTime := cVarTodate(varglobal1);

  s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok , '
  + ' mst_hargabeli hargabeli from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode '
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
  + ' group by brg_kode , brg_nama , brg_satuan ';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
          CDS.FieldByName('NamaBarang').AsString := Fields[2].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[3].AsString;
          CDS.FieldByName('system').asfloat :=Fields[4].Asfloat;
          CDS.FieldByName('harga').asfloat :=Fields[5].Asfloat;

        end
        ELSE
        begin
          s:='select brg_nama,brg_satuan,0,brg_hrgbeli from tbarang where brg_kode = '+Quot(CDS.Fieldbyname('sku').AsString);
          tsql2 := xOpenQuery(s,frmMenu.conn);
          with tsql2 do
          begin
            try
              if not Eof then
              begin
                CDS.FieldByName('NamaBarang').AsString := Fields[0].AsString;
                CDS.FieldByName('Satuan').AsString := Fields[1].AsString;
                CDS.FieldByName('system').asfloat :=Fields[2].Asfloat;
                CDS.FieldByName('harga').asfloat :=Fields[3].Asfloat;

              end
              ELSE
              bantuansku;
            finally
              Free;
            end;
          end;
        end;


        finally
          free;
      end;
    end;
  end;
end;

procedure TfrmKoreksiStok2.clSKUPropertiesEditValueChanged(
  Sender: TObject);
begin
   bantuansku
end;

procedure TfrmKoreksiStok2.edtKodeBarangClickBtn(Sender: TObject);
var
  s:String;
  tsql:TMyQuery;
  aqty : double;
begin

  sqlBantuan:='select brg_kode Kode,brg_nama Nama,brg_satuan Satuan from tbarang ';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
      edtkodebarang.text :=varglobal;
      edtNamaBarang.Text := varglobal1;
      dtexpired.date := Date+(365*5);

   end;
end;

procedure TfrmKoreksiStok2.Button4Click(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
  aqty : double;
begin
  aqty := strtofloat(edtqty.Text);
s:='select  brg_kode,brg_nama,brg_satuan,bk_qty,brg_lastcost ,'
      + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=bk_bhn_kode) sistem '
      + ' ,brg_gdg_default,gdg_nama from tbarangkomposisi inner join tbarang on brg_kode=bk_bhn_kode '
      + ' left join tgudang on gdg_kode=brg_gdg_default'
      + ' where bk_brg_kode='+ Quot(edtkodebarang.text);
      tsql:= xOpenQuery(s,frmmenu.conn);
      with tsql do
      begin
        try
          if not eof then
             cds.EmptyDataSet;
          while not eof do
          begin
              cds.Append;
              CDS.FieldByName('SKU').AsString := Fields[0].AsString;
              CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
              CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
              CDS.FieldByName('FISIK').asfloat :=(Fields[5].Asfloat-(Fields[3].Asfloat*aqty));
              CDS.FieldByName('system').asfloat :=Fields[5].Asfloat;
              CDS.FieldByName('qTY').asfloat :=Fields[3].Asfloat*-1*aqty;
              CDS.FieldByName('harga').asfloat :=Fields[4].Asfloat;
              CDS.FieldByName('NILAI').asfloat :=Fields[4].Asfloat*-1*Fields[3].Asfloat*aqty;
              CDS.FieldByName('gudang').AsString := Fields[6].AsString;
              CDS.FieldByName('namagudang').AsString := Fields[7].AsString;
              CDS.Post;

            next;
          end;
        finally
          free;
        end;
      end;
end;

procedure TfrmKoreksiStok2.clGudangPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  var
    s:string;
    tsql2,tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select gdg_kode Kode, gdg_nama NamaGudang from tgudang';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
     If CDS.State <> dsEdit then
     CDS.Edit;
     CDS.FieldByName('gudang').asstring := varglobal;
     CDS.FieldByName('NamaGudang').asstring := varglobal1;
     cds.post;
  end;


end;

procedure TfrmKoreksiStok2.Button5Click(Sender: TObject);
var
  s:String ;
  tsql :TMyQuery;
  aqty,aharga : double ;
begin
   aqty := strtofloat(edtqty.Text);
   aharga := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('nilai'))/aqty*-1;
  s:='select brg_kode,brg_nama,brg_satuan,ifnull(sum(mst_stok_in-mst_stok_out),0) Stok,brg_gdg_default,gdg_nama '
  + '  from tbarang left join tmasterstok on mst_brg_kode=brg_kode and mst_gdg_kode=brg_gdg_default'
  + ' left join tgudang on gdg_kode=brg_gdg_default '
  + ' where brg_kode = '+ Quot(edtKodeBarang.Text)
  + '  group by brg_kode ' ;
  tsql := xOpenQuery(s,frmmenu.conn);
  with tsql do
  begin
    try
               cds.Append;
              CDS.FieldByName('SKU').AsString := Fields[0].AsString;
              CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
              CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
              CDS.FieldByName('FISIK').asfloat :=Fields[3].Asfloat+aqty;
              CDS.FieldByName('system').asfloat :=Fields[3].Asfloat;
              CDS.FieldByName('qTY').asfloat :=aqty;
              CDS.FieldByName('harga').asfloat :=aharga;
              CDS.FieldByName('NILAI').asfloat :=aharga*aqty;
              CDS.FieldByName('gudang').AsString := Fields[4].AsString;
              CDS.FieldByName('namagudang').AsString := Fields[5].AsString;
              CDS.FieldByName('expired').asdatetime := dtExpired.Date;

              CDS.Post;
    finally
      free;
    end;

  end;

end;

procedure TfrmKoreksiStok2.clQtyKoreksiPropertiesEditValueChanged(
  Sender: TObject);
 var
    i:integer;
    lVal : double;
begin
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
   i := cxGrdMain.DataController.FocusedRecordIndex;

  cxGrdMain.DataController.Values[i, clfisik.Index]:=  cxGrdMain.DataController.Values[i, clQTYkoreksi.Index] +cxGrdMain.DataController.Values[i, clstoksystem.Index];
  lVal := cxGrdMain.DataController.Values[i, clQTYkoreksi.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index];

  If CDS.State <> dsEdit then CDS.Edit;
   CDS.FieldByName('fisik').AsFloat := cxGrdMain.DataController.Values[i, clQTYkoreksi.Index]+cxGrdMain.DataController.Values[i, clstoksystem.Index];
  CDS.FieldByName('nilai').AsFloat := lVal;
  CDS.Post;

end ;
end.
