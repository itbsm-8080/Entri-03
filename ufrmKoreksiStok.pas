unit ufrmKoreksiStok;

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
  MyAccess;

type
  TfrmKoreksiStok = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label4: TLabel;
    dttanggal: TDateTimePicker;
    AdvPanel3: TAdvPanel;
    Label3: TLabel;
    edtKeterangan: TAdvEdit;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    cxLookupGudangTujuan: TcxExtLookupComboBox;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clExpiredPropertiesEditValueChanged(Sender: TObject);
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
  frmKoreksiStok: TfrmKoreksiStok;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmKoreksiStok.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmKoreksiStok.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmKoreksiStok.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmKoreksiStok.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  dttanggal.DateTime := Date;
  edtKeterangan.Clear;
   cxLookupGudangTujuan.EditValue := '';
  cxLookupGudangTujuan.SetFocus;
  initgrid;
end;

procedure TfrmKoreksiStok.simpandata;
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
         + ' korh_notes = ' + Quot(edtKeterangan.Text) + ','
         + ' korh_gdg_kode = ' + Quot(cxLookupGudangTujuan.EditValue)+','
         + ' korh_total = ' + FloatToStr(asubtotal)+','
         + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
         + ' user_modified = ' + Quot(frmMenu.KDUSER)
         + ' where korh_nomor = ' + Quot(edtNomor.Text) ;
   end
   else
   begin
     anomor := getmaxkode;
     edtNomor.Text := anomor;
      s:= ' insert into tkor_hdr '
         + '( korh_nomor,korh_tanggal,korh_notes,korh_gdg_kode,korh_total,date_create,user_create) values ( '
         + Quot(anomor) + ','
         + Quotd(dttanggal.DateTime)+','
         + Quot(edtKeterangan.Text) + ','
         + Quot(cxLookupGudangTujuan.EditValue)+','
         + FloatToStr(asubtotal)+','
         + QuotD(cGetServerTime,True) + ','
         + Quot(frmMenu.KDUSER)+')';
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
          + ' (kord_korh_nomor,kord_brg_kode,kord_satuan,kord_expired,kord_qty,kord_harga,kord_nilai,kord_stok,kord_nourut) values ( '
          +  Quot(anomor) + ','
          +  IntToStr(CDS.FieldByName('SKU').AsInteger) + ','
          +  quot(CDS.FieldByName('satuan').AsString) + ','
          + QuotD(CDS.FieldByName('expired').Asdatetime) +','
          +  floatToStr(CDS.FieldByName('qty').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('harga').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('nilai').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('fisik').Asfloat) + ','
          +  IntToStr(i)
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
procedure TfrmKoreksiStok.doslip(anomor : string );
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


procedure TfrmKoreksiStok.insertketampungan(anomor:String);
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

function TfrmKoreksiStok.getmaxkode:string;
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


procedure TfrmKoreksiStok.FormCreate(Sender: TObject);
begin
 with TcxExtLookupHelper(cxLookupGudangTujuan.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
//     initViewSKU;
end;

function TfrmKoreksiStok.GetCDS: TClientDataSet;
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
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmKoreksiStok.GetCDSGudang: TClientDataset;
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


 procedure TfrmKoreksiStok.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan,mst_expired_date expired,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
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

procedure TfrmKoreksiStok.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmKoreksiStok.cxButton2Click(Sender: TObject);
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

procedure TfrmKoreksiStok.cxButton1Click(Sender: TObject);
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


function TfrmKoreksiStok.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
     If cxLookupGudangTujuan.EditValue = '' then
    begin
      ShowMessage('Gudang belum di pilih');
      result:=false;
      Exit;
    end;
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



procedure TfrmKoreksiStok.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').asfloat  := 0;
  CDS.FieldByName('harga').asfloat  := 0;
  CDS.FieldByName('nilai').asfloat  := 0;
  CDS.Post;

end;



procedure TfrmKoreksiStok.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmKoreksiStok.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmKoreksiStok.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmKoreksiStok.clQTYPropertiesEditValueChanged(
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

procedure TfrmKoreksiStok.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
 bantuansku;

end;

procedure TfrmKoreksiStok.bantuansku;
  var
    s:string;
    tsql2,tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku, mst_expired_date  Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' left join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
     for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = StrToInt(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
       and (StrToDate(varglobal1)= cVarTodate(cxGrdMain.DataController.Values[i, clexpired.Index])) then
      begin

        ShowMessage('Sku dan expired ada yang sama dengan baris '+ IntToStr(i+1));
        CDS.Cancel;
        exit;
      end;
    end;
 If CDS.State <> dsEdit then
   CDS.Edit;

      CDS.FieldByName('sku').AsInteger := StrToInt(varglobal);
      CDS.FieldByName('expired').AsDateTime := cVarTodate(varglobal1);

  s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok , '
  + ' mst_hargabeli hargabeli from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
  + ' and mst_expired_date = ' + QuotD(CDS.Fieldbyname('expired').AsDateTime)
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date';
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

procedure TfrmKoreksiStok.Button1Click(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
begin
  s:='select brg_kode Kode,brg_nama Nama,brg_satuan Satuan,mst_expired_date Expired,'
      + ' gdg_nama Gudang,sum(mst_stok_in - mst_stok_out) Stok, '
      + ' ifnull((select mst_hargabeli from tmasterstok where mst_noreferensi like "%RI%" and mst_brg_kode=brg_kode order by mst_tanggal desc limit 1),0) HRGBELI'
      + ' from tbarang '
      + ' inner join tmasterstok on mst_brg_kode=brg_kode  '
      + ' inner join tgudang on gdg_kode=mst_gdg_kode '
      + ' where mst_gdg_kode = ' + quot(cxLookupGudangTujuan.EditValue)
      + ' group by '
      + ' mst_gdg_kode,brg_kode,mst_expired_date,gdg_nama '
      + ' HAVING STOK <> 0 '
      + ' order by brg_kode';
tsql := xOpenQuery(s,frmMenu.conn) ;
with tsql do
begin
  try
    CDS.EmptyDataSet;
       while not Eof do
        begin
         cds.Append;
          CDS.FieldByName('SKU').AsString := Fields[0].AsString;
          CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
          CDS.FieldByName('EXPIRED').Asdatetime := Fields[3].AsDateTime;
          CDS.FieldByName('FISIK').asfloat :=0;
          CDS.FieldByName('system').asfloat :=Fields[5].Asfloat;
          CDS.FieldByName('qTY').asfloat :=Fields[5].Asfloat*-1;
          CDS.FieldByName('harga').asfloat :=Fields[6].Asfloat;
          CDS.FieldByName('NILAI').asfloat :=Fields[6].Asfloat*Fields[5].Asfloat*-1;

         CDS.Post;
          Next;

        end

  finally
    free;
  end;
end;
end;

procedure TfrmKoreksiStok.Button2Click(Sender: TObject);
var
  s:string;
  tt :TStrings;
  cols,rows,failure,i:integer;
  Excel, XLSheet: Variant;
begin
  inherited;
  if OpenDialog1.Execute then
  begin

  failure:=0;
  try
    Excel:=CreateOleObject('Excel.Application');
  except
    failure:=1;
  end;
  if failure = 0 then
  begin
    Excel.Visible:=False;
    Excel.WorkBooks.Open(OpenDialog1.FileName);
    XLSheet := Excel.Worksheets[1];
    Cols := XLSheet.UsedRange.Columns.Count;
    Rows := XLSheet.UsedRange.Rows.Count;

  tt:=TStringList.Create;
  CDS.EmptyDataSet;
         i:=0;
        while Rows > 0 do
        begin
         if Excel.Cells[2+i,1].text <> '' then
         begin


                   cds.Append;
                    CDS.FieldByName('SKU').AsString := Excel.Cells[2+i,1].text;
                    CDS.FieldByName('NamaBarang').AsString := Excel.Cells[2+i,2].text;
                    CDS.FieldByName('Satuan').AsString := 'PCS';
                    if Excel.Cells[2+i,4].text <> '' then
                    CDS.FieldByName('EXPIRED').AsString := Excel.Cells[2+i,4].text;
                    CDS.FieldByName('FISIK').AsString :=Excel.Cells[2+i,3].text;
                    CDS.FieldByName('system').asfloat :=0;
                    CDS.FieldByName('qTY').AsString :=Excel.Cells[2+i,3].text;
                    CDS.FieldByName('harga').AsString :=Excel.Cells[2+i,5].text;
                    CDS.FieldByName('NILAI').AsString :=Excel.Cells[2+i,6].text;

                   CDS.Post;




//            tt.Append('delete from tabsensi where nik='+quot(Excel.Cells[3+i,2].text) + ' and tanggal ='
//                  + quotd(strtodate(copy(Excel.Cells[3+i,6].text,4,2)+'/'+LeftStr(Excel.Cells[3+i,6].text,2)+'/'+rightstr(Excel.Cells[3+i,6].text,4)))+ ';');
//            tt.Append('insert ignore into tabsensi (nik,tanggal,masuk,scan1,keluar,scan2) values ('
//                 + quot(Excel.Cells[3+i,2].text) + ','
//                 + quotd(strtodate(copy(Excel.Cells[3+i,6].text,4,2)+'/'+LeftStr(Excel.Cells[3+i,6].text,2)+'/'+rightstr(Excel.Cells[3+i,6].text,4))) + ','
//                 + quot(Excel.Cells[3+i,11].text) + ','
//                 + quot(Excel.Cells[3+i,12].text) + ','
//                 + quot(Excel.Cells[3+i,14].text) + ','
//                 + quot(Excel.Cells[3+i,15].text)
//                 + ');' );
         end;
            i:= i+1;
         Dec(Rows);
         end;
        Excel.Workbooks.Close;
        Excel.Quit;
        Excel:=Unassigned;


  end;
end;
end;


procedure TfrmKoreksiStok.clSKUPropertiesEditValueChanged(
  Sender: TObject);
begin
   bantuansku
end;

procedure TfrmKoreksiStok.clExpiredPropertiesEditValueChanged(
  Sender: TObject);
  var
    tsql:TMyQuery;
    s:string;
    i:integer;
begin
     i := cxGrdMain.DataController.FocusedRecordIndex;
      cxGrdMain.DataController.Post;
  s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok , '
  + ' mst_hargabeli hargabeli from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
  + ' and mst_expired_date = ' + QuotD( cVarTodate(cxGrdMain.DataController.Values[i, clExpired.Index]))
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date,mst_hargabeli ';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
           If CDS.State <> dsEdit then
   CDS.Edit;

          CDS.FieldByName('NamaBarang').AsString := Fields[2].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[3].AsString;
          CDS.FieldByName('system').asfloat :=Fields[4].Asfloat;
          CDS.FieldByName('harga').asfloat :=Fields[5].Asfloat;

        end
        else
        begin
           If CDS.State <> dsEdit then
           CDS.Edit;
          CDS.FieldByName('system').asfloat :=0;
        end;


      finally
      free;
      end;
    end

end;

end.
