unit ufrmProsesGaji;

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
  AdvCombo, MyAccess;

type
  TfrmProsesGaji = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    AdvPanel3: TAdvPanel;
    Label3: TLabel;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    cltmakan: TcxGridDBColumn;
    clSatuan: TcxGridDBColumn;
    clGapok: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    clTjabatan: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clBpjs: TcxGridDBColumn;
    clbpjstk: TcxGridDBColumn;
    clkoperasi: TcxGridDBColumn;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxButton3: TcxButton;
    cltotal: TcxGridDBColumn;
    clCicilan: TcxGridDBColumn;
    clSewa: TcxGridDBColumn;
    clLuarKota: TcxGridDBColumn;
    cljabatan: TcxGridDBColumn;
    clkompetensi: TcxGridDBColumn;
    cllain: TcxGridDBColumn;
    cxButton4: TcxButton;
    Label1: TLabel;
    cbbPerusahaan: TAdvComboBox;
    clPunishment: TcxGridDBColumn;
    clHariKerja: TcxGridDBColumn;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure refreshdata;
    procedure simpandata;
    procedure dosliP(anomor : string );
    function GetCDS: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure insertketampungan(anomor:string);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);

    procedure initgrid;
    procedure HapusRecord1Click(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure cxLookupGudangAsalPropertiesEditValueChanged(
      Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure loaddataall;
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    private
     buttonSelected  : integer;
     FID : STRING;
     FCDSSKU : TClientDataset;
     FCDSGudang: TClientDataset;
        FFLAGEDIT: Boolean;
     xtotal : Double;
         function GetCDSGudang: TClientDataset;

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
  frmProsesGaji: TfrmProsesGaji;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmProsesGaji.Button1Click(Sender: TObject);
begin
loaddataall;
end;

procedure TfrmProsesGaji.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmProsesGaji.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmProsesGaji.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmProsesGaji.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  initgrid;
end;

procedure TfrmProsesGaji.simpandata;
var
  s:string;
  i:integer;
  tt : TStrings;
  anomor : string;

begin

   tt := TStringList.Create;
   s:= ' delete from tgajibulanan '
      + ' where  gb_periode =' + IntToStr(cbbBulan.ItemIndex+1)
      + ' and gb_tahun = ' + edtTahun.Text
      + ' And gb_perusahaan = '+ Quot(cbbPerusahaan.Text);
   tt.Append(s);
   i:=1;
    CDS.First;
while not CDS.Eof do
  begin
   if CDS.FieldByName('nik').AsString <> '' then
   begin
        s:='insert into tgajibulanan '
          + ' (gb_perusahaan,gb_periode,gb_tahun,gb_nik,gb_nama,gb_dept,gb_gapok,'
          + ' gb_tunjanganmakan,gb_tunjanganjabatan,gb_bpjs,gb_bpjstk,gb_koperasi,gb_angsuran,'
          + ' gb_punishment,gb_harikerja,'
          + ' gb_sewakendaraan,gb_luarkota,gb_jabatan,gb_kompetensi,gb_lainlain) values ( '
          + Quot(cbbPerusahaan.Text) + ','
          +  IntToStr(cbbBulan.ItemIndex+1) + ','
          + edtTahun.Text + ','
          +  quot(CDS.FieldByName('nik').AsString) + ','
          +  quot(CDS.FieldByName('nama').AsString) + ','
          +  quot(CDS.FieldByName('departemen').AsString) + ','
          +  floatToStr(CDS.FieldByName('gapok').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('tmakan').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('tjabatan').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('bpjs').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('bpjstk').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('koperasi').Asfloat)+','
          +  floatToStr(CDS.FieldByName('angsuran').Asfloat)+','
          +  floatToStr(CDS.FieldByName('punishment').Asfloat)+','
          +  floatToStr(CDS.FieldByName('harikerja').Asfloat)+','
          +  floatToStr(CDS.FieldByName('sewa').Asfloat)+','
          +  floatToStr(CDS.FieldByName('luar').Asfloat)+','
          +  floatToStr(CDS.FieldByName('jabatan').Asfloat)+','
          +  floatToStr(CDS.FieldByName('kompetensi').Asfloat)+','
          +  floatToStr(CDS.FieldByName('lain').Asfloat)
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
procedure TfrmProsesGaji.doslip(anomor : string );
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


procedure TfrmProsesGaji.insertketampungan(anomor:String);
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

procedure TfrmProsesGaji.FormCreate(Sender: TObject);
begin

  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
//     initViewSKU;
end;

function TfrmProsesGaji.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Nik', ftString, False,255);
    zAddField(FCDS, 'Nama', ftString, False,100);
    zAddField(FCDS, 'Departemen', ftString, False,40);
    zAddField(FCDS, 'Gapok', ftFloat, False);
    zAddField(FCDS, 'tmakan', ftFloat,  False);
    zAddField(FCDS, 'tjabatan', ftFloat, False);
    zAddField(FCDS, 'bpjs', ftFloat, False);
    zAddField(FCDS, 'bpjstk', ftfloat, False);
    zAddField(FCDS, 'koperasi', ftfloat, False);
    zAddField(FCDS, 'angsuran', ftfloat, False);
    zAddField(FCDS, 'Punishment', ftfloat, False);
    zAddField(FCDS, 'HariKerja', ftfloat, False);
    zAddField(FCDS, 'total', ftfloat, False);
    zAddField(FCDS, 'kompetensi', ftfloat, False);
    zAddField(FCDS, 'luar', ftfloat, False);
    zAddField(FCDS, 'sewa', ftfloat, False);
    zAddField(FCDS, 'lain', ftfloat, False);
    zAddField(FCDS, 'jabatan', ftfloat, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmProsesGaji.GetCDSGudang: TClientDataset;
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



procedure TfrmProsesGaji.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmProsesGaji.cxButton2Click(Sender: TObject);
begin
  try


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

procedure TfrmProsesGaji.cxButton1Click(Sender: TObject);
begin
 try


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


procedure TfrmProsesGaji.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;



procedure TfrmProsesGaji.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmProsesGaji.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmProsesGaji.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmProsesGaji.Button2Click(Sender: TObject);
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
         if Excel.Cells[6+i,2].text <> '' then
         begin


                   cds.Append;
                    CDS.FieldByName('NIK').AsString := Excel.Cells[6+i,2].text;
                    CDS.FieldByName('Nama').AsString := Excel.Cells[6+i,3].text;
                    CDS.FieldByName('departemen').AsString := Excel.Cells[6+i,4].text;
                    CDS.FieldByName('gapok').AsString := floattostr(cstrtoFloat(Excel.Cells[6+i,7].text));
                    CDS.FieldByName('tmakan').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,8].text));
                    CDS.FieldByName('tjabatan').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,9].text));
                    CDS.FieldByName('bpjs').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,11].text));
                    CDS.FieldByName('bpjstk').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,12].text));
                    CDS.FieldByName('Koperasi').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,13].text));
                    CDS.FieldByName('angsuran').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,14].text));
                    CDS.FieldByName('Punishment').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,15].text));
                    CDS.FieldByName('HariKerja').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,16].text));
                    CDS.FieldByName('Total').AsString :=floattostr((cstrtoFloat(Excel.Cells[6+i,7].text)+cstrtoFloat(Excel.Cells[6+i,8].text)+cstrtoFloat(Excel.Cells[6+i,9].text))-
                    (cstrtoFloat(Excel.Cells[6+i,11].text)+cstrtoFloat(Excel.Cells[6+i,12].text)+cstrtoFloat(Excel.Cells[6+i,13].text)+cstrtoFloat(Excel.Cells[6+i,14].text)+cstrtoFloat(Excel.Cells[6+i,15].text)+cstrtoFloat(Excel.Cells[6+i,16].text)));
                    CDS.FieldByName('sewa').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,19].text));
                    CDS.FieldByName('luar').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,20].text));
                    CDS.FieldByName('jabatan').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,21].text));
                    CDS.FieldByName('kompetensi').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,22].text));
                    CDS.FieldByName('lain').AsString :=floattostr(cstrtoFloat(Excel.Cells[6+i,23].text));
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


procedure TfrmProsesGaji.loaddataall;
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin
  s := ' select *,((gb_gapok+gb_tunjanganjabatan+gb_tunjanganmakan)-(gb_bpjs+gb_bpjstk+gb_koperasi+gb_angsuran)) total from tgajibulanan where'
     + ' gb_periode = '+ inttostr(cbbBulan.ItemIndex+1)
     + ' and gb_tahun = '+ edtTahun.Text
     + ' and gb_perusahaan = '+ Quot(cbbPerusahaan.Text)
     + ';';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
            flagedit := True;
            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                    CDS.Append;
                    CDS.FieldByName('NIK').AsString := Fieldbyname('gb_nik').AsString;
                    CDS.FieldByName('Nama').AsString := Fieldbyname('gb_nama').AsString;
                    CDS.FieldByName('departemen').AsString := Fieldbyname('gb_dept').AsString;
                    CDS.FieldByName('gapok').AsString := Fieldbyname('gb_gapok').AsString;
                    CDS.FieldByName('tmakan').AsString :=Fieldbyname('gb_tunjanganmakan').AsString;
                    CDS.FieldByName('tjabatan').AsString :=Fieldbyname('gb_tunjanganjabatan').AsString;
                    CDS.FieldByName('bpjs').AsString :=Fieldbyname('gb_bpjs').AsString;
                    CDS.FieldByName('bpjstk').AsString :=Fieldbyname('gb_bpjstk').AsString;
                    CDS.FieldByName('Koperasi').AsString :=Fieldbyname('gb_koperasi').AsString;
                    CDS.FieldByName('angsuran').AsString :=Fieldbyname('gb_angsuran').AsString;
                    CDS.FieldByName('punishment').AsString :=Fieldbyname('gb_punishment').AsString;
                    CDS.FieldByName('Harikerja').AsString :=Fieldbyname('gb_harikerja').AsString;

                    CDS.FieldByName('Total').Asfloat :=Fieldbyname('total').asfloat;
                    CDS.FieldByName('sewa').Asfloat :=Fieldbyname('gb_sewakendaraan').asfloat;
                    CDS.FieldByName('luar').Asfloat :=Fieldbyname('gb_luarkota').asfloat;
                    CDS.FieldByName('jabatan').Asfloat :=Fieldbyname('gb_jabatan').asfloat;
                    CDS.FieldByName('kompetensi').Asfloat :=Fieldbyname('gb_kompetensi').asfloat;
                    CDS.FieldByName('lain').Asfloat :=Fieldbyname('gb_lainlain').asfloat;


                      CDS.Post;
                   i:=i+1;
                   next;
            end ;



      end;
   finally
     tsql.Free;


   end;

end;



procedure TfrmProsesGaji.cxButton3Click(Sender: TObject);
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    if cbbPerusahaan.ItemIndex = 1 then
    ftsreport.Nama := 'Gajian2'
    else
    ftsreport.Nama := 'Gajian';

          s:= 'select '
            + Quot(cbbPerusahaan.Text) + ' Perusahaan, '+Quot(cbbBulan.Text) + ' Bulan, '+ Quot(edtTahun.Text) + ' Tahun,'
            + ' a.* ,'
            + ' terbilang((gb_gapok+gb_tunjanganmakan+gb_tunjanganjabatan)-(gb_bpjs+gb_bpjstk+gb_koperasi+gb_angsuran+gb_punishment+gb_harikerja)) bilang'
            + ' from tgajibulanan a'
            + ' where gb_gapok > 0 and gb_periode=' + IntToStr(cbbBulan.itemindex +1) + ' and gb_tahun='+ edtTahun.Text
            + ' AND gb_perusahaan= ' + quot(cbbPerusahaan.Text)
            + ' order by gb_nama  ';

    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmProsesGaji.cxButton4Click(Sender: TObject);
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    if cbbPerusahaan.ItemIndex =1  then
     ftsreport.Nama := 'tandaterima2'
    else
     ftsreport.Nama := 'tandaterima';

          s:= 'select '
            + Quot(cbbBulan.Text) + ' Bulan, '+ Quot(edtTahun.Text) + ' Tahun,'
            + ' a.* ,'
            + ' terbilang((gb_sewakendaraan+gb_lainlain+gb_kompetensi+gb_jabatan+gb_luarkota)) bilang'
            + ' from tgajibulanan a'
            + ' where gb_gapok > 0 and gb_periode=' + IntToStr(cbbBulan.itemindex +1) + ' and gb_tahun='+ edtTahun.Text
            + ' AND gb_perusahaan= ' + quot(cbbPerusahaan.Text)            
            + ' order by gb_nama  ';

    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;

end;

end.
