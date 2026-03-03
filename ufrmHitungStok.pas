unit ufrmHitungStok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, DBClient, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSpinEdit, cxCurrencyEdit, cxButtonEdit,
  cxCalendar, MyAccess;

type
  TfrmHitungStok = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupGudang: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clExpired: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    Label6: TLabel;
    edtlokasi: TAdvEdit;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clSatuan: TcxGridDBColumn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
   procedure initViewSKU;
    procedure HapusRecord1Click(Sender: TObject);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataall(akode : string);
    procedure clSKUPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FCDSGudang: TClientDataset;
    FCDSSKU : TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSGudang: TClientDataset;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmHitungStok: TfrmHitungStok;
const
   NOMERATOR = 'HT';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmHitungStok.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtnomor.Text := getmaxkode;
  cxLookupGudang.EditValue := '';
  edtlokasi.Clear;
  cxLookupGudang.SetFocus;
  initgrid;

end;
procedure TfrmHitungStok.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;

  CDS.Post;

end;
procedure TfrmHitungStok.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmHitungStok.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmHitungStok.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(hit_nomor,4)) from thitungstok where hit_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;

  end;
end;

procedure TfrmHitungStok.cxButton1Click(Sender: TObject);
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

procedure TfrmHitungStok.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmHitungStok.cxButton2Click(Sender: TObject);
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

procedure TfrmHitungStok.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','gudang',['Kode'],Self);
     TcxExtLookupHelper(cxLookupGudang.Properties).SetMultiPurposeLookup;

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     initViewSKU;
end;

function TfrmHitungStok.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'expired', ftDate, False, 255);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmHitungStok.GetCDSGudang: TClientDataset;
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

procedure TfrmHitungStok.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmHitungStok.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmHitungStok.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_hrgbeli HrgBeli,'
      + ' brg_satuan Satuan from Tbarang ORDER BY brg_nama';


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);
  

end;
procedure TfrmHitungStok.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmHitungStok.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[3].Asstring;
end;



procedure TfrmHitungStok.clKetPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  var
    i:integer ;
begin
   i := cxGrdMain.DataController.FocusedRecordIndex;

 If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index])=0) then
 begin
    Error :=True;
    ErrorText := 'Sku Belum Diinput';

 end;
end;

procedure TfrmHitungStok.dtTanggalChange(Sender: TObject);
begin
edtNomor.Text := getmaxkode;
end;


procedure TfrmHitungStok.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aistax : integer;
begin

if FLAGEDIT then
  s:='update thitungstok set '
    + ' HIT_gdg_kode = ' + Quot(cxLookupGudang.EditValue) + ','
    + ' HIT_lokasi = ' + Quot(edtlokasi.Text) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where HIT_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into thitungstok '
             + ' (HIT_nomor,HIT_tanggal,HIT_lokasi,HIT_gdg_kode,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(edtlokasi.Text)+','
             + Quot(cxLookupGudang.EditValue) + ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from thitungstok_dtl '
      + ' where  HITD_HIT_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
     i:=1;
  while not CDS.Eof do
  begin

    S:='insert into thitungstok_dtl (HITD_HIT_nomor,HITD_brg_kode,HITD_satuan,HITD_qty,HITD_EXPIRED,HITD_nourut) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + quotd(CDS.FieldByName('expired').AsDateTime) +','
      + IntToStr(i)
      + ');';
    tt.Append(s);
    CDS.Next;
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


function TfrmHitungStok.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
   If cxLookupGudang.EditValue = '' then
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

    If CDS.FieldByName('QTY').AsInteger = 0 then
    begin
      ShowMessage('QTY Baris : ' + inttostr(i) + ' Belum diisi');
      result:=false;
      Exit;
    end;
    inc(i);
    CDS.Next;
  end;
end;

procedure TfrmHitungStok.loaddataall(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select HIT_nomor,HIT_tanggal,HIT_GDG_kode,'
     + ' HIT_LOKASI,'
     + ' HITD_brg_kode,HITD_satuan,HITD_qty,HITD_EXPIRED '
     + ' from thitungstok a'
     + ' LEFT join thitungstok_dtl d on a.HIT_nomor=d.HITD_HIT_nomor '
     + ' where a.HIT_nomor = '+ Quot(akode)
     + ' ORDER BY HITD_nourut';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('HIT_nomor').AsString;
            edtNomor.Text   := fieldbyname('HIT_nomor').AsString;
            dttanggal.DateTime := fieldbyname('HIT_tanggal').AsDateTime;
            edtlokasi.Text := fieldbyname('HIT_lokasi').AsString;
            cxLookupGudang.EditValue  := fieldbyname('HIT_gdg_kode').AsString;


            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin


                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('HITD_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('HITD_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('HITD_qty').AsInteger;
                      CDS.FieldByName('expired').AsString  := fieldbyname('HITD_expired').AsString;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
        end
        else
        begin
          ShowMessage('Nomor tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;


   end;

end;

procedure TfrmHitungStok.clSKUPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
begin
    for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin
      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = DisplayValue) and (cxGrdMain.DataController.FocusedRecordIndex <> i) then
      begin
        if MessageDlg('Kode barang sudah ada di baris ' + IntToStr(i+1) + ' Lanjut ? ',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
          then
          begin

            error := true;
            ErrorText :='Pilih Kode lain ';
            exit;
          end
          else
          exit;
      end;
    end;
end;

procedure TfrmHitungStok.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;
end.
