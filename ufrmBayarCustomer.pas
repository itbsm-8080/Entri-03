unit ufrmBayarCustomer;

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
  cxGridDBTableView, cxGrid, cxSpinEdit, cxCurrencyEdit, AdvEdBtn,DateUtils,
  cxCalendar, cxCheckBox, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, MyAccess;

type
  TfrmBayarCustomer = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupCustomer: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clInvoice: TcxGridDBColumn;
    clTglInvoice: TcxGridDBColumn;
    clTerbayar: TcxGridDBColumn;
    clJthTempo: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    clBayar: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    clNilai: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    cxLookupRekeningCash: TcxExtLookupComboBox;
    Label10: TLabel;
    edtmemo: TMemo;
    Label5: TLabel;
    dtTglCair: TDateTimePicker;
    Label7: TLabel;
    edtGiro: TAdvEdit;
    Label8: TLabel;
    edtNilaiCash: TAdvEdit;
    chkCash: TCheckBox;
    chkTransfer: TCheckBox;
    cxLookupRekeningTransfer: TcxExtLookupComboBox;
    Label4: TLabel;
    edtNilaiTransfer: TAdvEdit;
    chkPotongan: TCheckBox;
    cxLookupRekeningPotongan: TcxExtLookupComboBox;
    lbpotongan: TLabel;
    chkGiro: TCheckBox;
    cxLookupRekeningGiro: TcxExtLookupComboBox;
    lbgiro: TLabel;
    edtNilaiGiro: TAdvEdit;
    LihatFakturPenjualan1: TMenuItem;
    clKontrak: TcxGridDBColumn;
    clPPN: TcxGridDBColumn;
    chkPajak: TCheckBox;
    chkPPN: TCheckBox;
    cxLookupRekPPN: TcxExtLookupComboBox;
    chkPPH: TCheckBox;
    cxLookupRekeningPPH: TcxExtLookupComboBox;
    Label9: TLabel;
    edtPPN: TAdvEdit;
    Label11: TLabel;
    edtPPH: TAdvEdit;
    clSalesman: TcxGridDBColumn;
    edtNilaiPotongan: TAdvEdit;
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
    procedure HapusRecord1Click(Sender: TObject);
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure chkPPNClick(Sender: TObject);
    procedure loaddataInvoice(akode : string);
    procedure loaddataall(akode : string);
    procedure cxLookupcustomerPropertiesEditValueChanged(Sender: TObject);
    procedure clStatusPropertiesEditValueChanged(Sender: TObject);
    procedure clBayarPropertiesEditValueChanged(Sender: TObject);
    procedure hitung;
    procedure cxGrdMainDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure clBayarPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure chkCashClick(Sender: TObject);
    procedure chkTransferClick(Sender: TObject);
    procedure chkPotonganClick(Sender: TObject);
    procedure chkGiroClick(Sender: TObject);
    procedure LihatFakturPenjualan1Click(Sender: TObject);
    procedure chkPajakClick(Sender: TObject);
    procedure chkPPHClick(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSRekeningCash: TClientDataset;
    FCDSRekeningGiro: TClientDataset;
    FCDSRekeningTransfer: TClientDataset;
    FCDSRekeningPotongan: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    atanggalold:TDateTime;
    FCDSRekeningppn: TClientDataset;
    FCDSRekeningPPH: TClientDataset;

    function GetCDScustomer: TClientDataset;
    function GetCDSRekeningCash: TClientDataset;
    function GetCDSRekeningGiro: TClientDataset;
    function GetCDSRekeningTransfer: TClientDataset;
    function GetCDSRekeningPotongan: TClientDataset;
    function GetCDSRekeningppn: TClientDataset;
    function GetCDSRekeningPPH: TClientDataset;



    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;
    property CDSRekeningCash: TClientDataset read GetCDSRekeningCash write
        FCDSRekeningCash;
    property CDSRekeningGiro: TClientDataset read GetCDSRekeningGiro write
        FCDSRekeningGiro;
    property CDSRekeningTransfer: TClientDataset read GetCDSRekeningTransfer write
        FCDSRekeningTransfer;
    property CDSRekeningPotongan: TClientDataset read GetCDSRekeningPotongan write
        FCDSRekeningPotongan;
    property CDSRekeningppn: TClientDataset read GetCDSRekeningppn write
        FCDSRekeningppn;
    property CDSRekeningPPH: TClientDataset read GetCDSRekeningPPH write
        FCDSRekeningPPH;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
        procedure doslip(anomor : string );
    { Public declarations }
  end;

var
  frmBayarCustomer: TfrmBayarCustomer;
const
   NOMERATOR = 'CR';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmfp;

{$R *.dfm}

procedure TfrmBayarCustomer.refreshdata;
begin
  FID:='';
  
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  dtTglCair.datetime :=date;
  edtnomor.Text := getmaxkode;
  cxLookupcustomer.EditValue := '';
  cxLookupRekeningCash.EditValue := '';
  cxLookupRekeningTransfer.EditValue := '';
  cxLookupRekeningPotongan.EditValue := '';
  cxLookupRekeningGiro.EditValue := '';
  edtNilaiCash.Text := '0';
  edtNilaiTransfer.Text := '0';
  edtNilaiPotongan.Text := '0';
  edtNilaiGiro.Text := '0';
  edtGiro.Clear;
  edtAlamat.Clear;
  edtmemo.Clear;
  if (frmMenu.KDUSER = 'FINANCE') OR (UpperCase(frmMenu.KDUSER) ='PIUTANG') Then
  begin
   chkPPN.Enabled := True;
   chkPPH.Enabled := True;
  end
  else
  begin
   chkPPN.Enabled := false;
   chkPPH.Enabled := false;
  end;
  
  cxLookupcustomer.SetFocus;
  initgrid;

end;
procedure TfrmBayarCustomer.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('bayar').AsCurrency    := 0;
  CDS.Post;

end;
procedure TfrmBayarCustomer.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmBayarCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmBayarCustomer.getmaxkode:string;
var
  s:string;
begin
 s:='select max(right(byc_nomor,4)) from tbayarcus_hdr where byc_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
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

procedure TfrmBayarCustomer.cxButton1Click(Sender: TObject);
begin
    try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
    
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

procedure TfrmBayarCustomer.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmBayarCustomer.cxButton2Click(Sender: TObject);
begin
   try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
   
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

procedure TfrmBayarCustomer.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;

    with TcxExtLookupHelper(cxLookupRekeningCash.Properties) do
    LoadFromCDS(CDSRekeningCash, 'Kode','Rekening',['Kode'],Self);

    with TcxExtLookupHelper(cxLookupRekeningTransfer.Properties) do
    LoadFromCDS(CDSRekeningTransfer, 'Kode','Rekening',['Kode'],Self);

    with TcxExtLookupHelper(cxLookupRekeningPotongan.Properties) do
    LoadFromCDS(CDSRekeningPotongan, 'Kode','Rekening',['Kode'],Self);

    with TcxExtLookupHelper(cxLookupRekeningGiro.Properties) do
    LoadFromCDS(CDSRekeningGiro, 'Kode','Rekening',['Kode'],Self);

    with TcxExtLookupHelper(cxLookupRekPPN.Properties) do
    LoadFromCDS(CDSRekeningppn, 'Kode','Rekening',['Kode'],Self);

    with TcxExtLookupHelper(cxLookupRekeningPPH.Properties) do
    LoadFromCDS(CDSRekeningPPH, 'Kode','Rekening',['Kode'],Self);

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmBayarCustomer.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Salesman', ftString, False,50);    
    zAddField(FCDS, 'Invoice', ftString, False,20);
    zAddField(FCDS, 'Tanggal', ftDate, False);
    zAddField(FCDS, 'JthTempo', ftDate, False, 10);
    zAddField(FCDS, 'Retur', ftFloat, False);
    zAddField(FCDS, 'PPN', ftFloat, False);
    zAddField(FCDS, 'Nilai', ftFloat, False);
    zAddField(FCDS, 'Terbayar', ftFloat, False);
    zAddField(FCDS, 'Bayar', ftFloat, False);
    zAddField(FCDS, 'pay', ftInteger, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmBayarCustomer.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_telp'
        +' from tcustomer order by cus_nama ';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;

procedure TfrmBayarCustomer.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmBayarCustomer.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmBayarCustomer.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;


procedure TfrmBayarCustomer.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
  anomorold := edtNomor.Text;
  anomornew := getmaxkode;
  if FLAGEDIT then
  begin
    if Copy(anomornew,1,11) <> Copy(anomorold,1,11)then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.Date :=atanggalold;
    end;
  end;
end;


procedure TfrmBayarCustomer.simpandata;
var
  s:string;
  atax,i:integer;
  tt:TStrings;

begin
  if chkPajak.Checked then
   atax :=1
  else
   atax := 0;

if FLAGEDIT then
  s:='update tbayarcus_HDR set '
    + ' byc_cus_kode = ' + Quot(cxLookupcustomer.EditValue) + ','
    + ' byc_memo = ' + Quot(edtmemo.Text) + ','
    + ' byc_tanggal = ' + Quotd(dtTanggal.Date)+','
    + ' byc_cash = ' + FloatToStr(cStrToFloat(edtNilaiCash.Text))+','
    + ' byc_rek_cash =  '+ Quot(VarToStr(cxLookupRekeningCash.EditValue)) + ','
    + ' byc_transfer = '+ FloatToStr(cStrToFloat(edtNilaiTransfer.Text))+','
    + ' byc_rek_transfer =  '+ Quot(VarToStr(cxLookupRekeningTransfer.EditValue)) + ','
    + ' byc_potongan = '+ FloatToStr(cStrToFloat(edtNilaiPotongan.Text))+','
    + ' byc_rek_potongan =  ' + Quot(VarToStr(cxLookupRekeningPotongan.EditValue)) + ','
    + ' byc_giro = '+ FloatToStr(cStrToFloat(edtNilaiGiro.Text))+','
    + ' byc_rek_giro = '+ Quot(VarToStr(cxLookupRekeningGiro.EditValue)) + ','
    + ' byc_nogiro = ' + Quot(edtGiro.Text) + ','
    + ' byc_tglcair = ' + QuotD(dtTglCair.DateTime)+','
    + ' byc_istax = '+ IntToStr(atax)+','
    + ' byc_ppn = ' + FloatToStr(cStrToFloat(edtPPN.Text))+','
    + ' byc_rek_ppn = ' + Quot(VarToStr(cxLookupRekPPN.EditValue)) + ','
    + ' byc_pph = ' + FloatToStr(cStrToFloat(edtPPH.Text))+','
    + ' byc_rek_pph = ' + Quot(VarToStr(cxLookupRekeningPPH.EditValue)) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where byc_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
    s :=  ' insert into tbayarcus_HDR '
             + ' (byc_nomor,byc_tanggal,byc_cus_kode,'
             + ' byc_memo,byc_cash,byc_rek_cash,byc_transfer,byc_rek_transfer '
             + ' ,byc_potongan,byc_rek_potongan,byc_giro,byc_rek_giro,byc_nogiro,byc_tglcair,byc_istax '
             + ' ,byc_ppn,byc_rek_ppn,byc_pph,byc_rek_pph,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(cxLookupcustomer.EditValue)+','
             + Quot(edtmemo.Text)+','
             + FloatToStr(cStrToFloat(edtNilaiCash.Text))+','
             + Quot(VarToStr(cxLookupRekeningCash.EditValue)) + ','
             + FloatToStr(cStrToFloat(edtNilaiTransfer.Text))+','
             + Quot(VarToStr(cxLookupRekeningTransfer.EditValue)) + ','
             + FloatToStr(cStrToFloat(edtNilaiPotongan.Text))+','
             + Quot(VarToStr(cxLookupRekeningPotongan.EditValue)) + ','
             + FloatToStr(cStrToFloat(edtNilaiGiro.Text))+','
             + Quot(VarToStr(cxLookupRekeningGiro.EditValue)) + ','
             + Quot(edtGiro.Text) + ','
             + QuotD(dtTglCair.DateTime)+','
             + IntToStr(atax) + ','
             + FloatToStr(cStrToFloat(edtPPN.Text))+','
             + Quot(VarToStr(cxLookupRekPPN.EditValue)) + ','
             + FloatToStr(cStrToFloat(edtPPH.Text))+','
             + Quot(VarToStr(cxLookupRekeningPPH.EditValue)) + ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from tbayarcus_DTL '
      + ' where  bycd_byc_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('bayar').AsFloat >  0 then
   begin
    S:='insert into tbayarcus_DTL (bycd_byc_nomor,bycd_fp_nomor,bycd_bayar) values ('
      + Quot(edtNomor.Text) +','
      + quot(CDS.FieldByName('INVOICE').AsString) +','
      + FloatToStr(CDS.FieldByName('bayar').AsFloat)
      + ');';
    tt.Append(s);
   end;
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


function TfrmBayarCustomer.cekdata:Boolean;
var
  i:integer;
  abayar,atotal : double;
  asalesman : string;
begin
  result:=true;
   i := 1;
     If cxLookupcustomer.EditValue = '' then
    begin
      ShowMessage('customer belum di pilih');
      result:=false;
      Exit;

    end;

    if (MonthOf(dtTanggal.DateTime) <> MonthOf(cGetServerTime)) then
    begin
      if (StrToInt(FormatDateTime('dd',cGetServerTime))> getbatas('CR')) then
      begin
        ShowMessage('Sudah Tidak bisa diedit pembayaran beda periode');
        result:=false;
         Exit;
      end;
    end;

   If (chkCash.Checked) and (cxLookupRekeningCash.EditValue = '') then
    begin
      ShowMessage('Rekening Cash belum di pilih');
      result:=false;
      Exit;
    end;

       If (chkTransfer.Checked) and (cxLookupRekeningTransfer.EditValue = '') then
    begin
      ShowMessage('Rekening Transfer belum di pilih');
      result:=false;
      Exit;
    end;
    If (chkGiro.Checked) and (cxLookupRekeningGiro.EditValue = '') then
    begin
      ShowMessage('Rekening Giro belum di pilih');
      result:=false;
      Exit;
      if edtGiro.Text  = '' then
      begin
          ShowMessage('Nomor Giro belum di isi');
          result:=false;
          Exit;

      end;
    end;
       If (chkPotongan.Checked) and (cxLookupRekeningPotongan.EditValue = '') then
    begin
      ShowMessage('Rekening Potongan belum di pilih');
      result:=false;
      Exit;
    end;

    If (chkPPN.Checked) and (cxLookupRekPPN.EditValue = '') then
    begin
      ShowMessage('Rekening ppn belum di pilih');
      result:=false;
      Exit;
    end;

    If (chkPPH.Checked) and (cxLookupRekeningPPH.EditValue = '') then
    begin
      ShowMessage('Rekening ppH belum di pilih');
      result:=false;
      Exit;
    end;


  CDS.First;
  While not CDS.Eof do
  begin

    If (CDS.FieldByName('pay').AsInteger = 1)  and (CDS.FieldByName('bayar').AsFloat = 0) then
    begin
      ShowMessage('Baris : ' + inttostr(i) + ' Pembayaran masih nol');
      result:=false;
      Exit;
    end;

    inc(i);
    CDS.Next;
  end;
    CDS.First;
    i:=1;

  While not CDS.Eof do
  begin

    If (CDS.FieldByName('pay').AsInteger = 1)  then
    begin
      if i=1 then
      asalesman := CDS.FieldByName('salesman').AsString ;
      if (i<> 1) and (CDS.FieldByName('salesman').AsString <> asalesman) then
      begin
        showmessage('TIDAK BISA SIMPAN , ADA SALESMAN BERBEDA');
        result := false;
        Exit;
      end;
      inc(i);
    end;

    CDS.Next;
  end;


  atotal := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('bayar'));
  abayar := cStrToFloat(edtNilaiCash.Text) + cStrToFloat(edtNilaiTransfer.Text) + cStrToFloat(edtNilaiPotongan.Text)+ cStrToFloat(edtNilaiGiro.Text)+ cStrToFloat(edtPPN.Text)+ cStrToFloat(edtPPH.Text);
    if ((atotal - abayar) > 10) or ((atotal - abayar) < -10) then
  begin
      ShowMessage('Pembayaran dengan Total '+floattostr(atotal)+' yang di bayar Beda '+floattostr(abayar));
      result:=false;
      Exit;
  end;



end;

procedure TfrmBayarCustomer.chkPPNClick(Sender: TObject);
begin
  if  chkPPN.Checked then
  begin
    cxLookupRekPPN.Enabled := True;
    edtPPN.Enabled := True;

  end
  else
  begin
    cxLookupRekPPN.Enabled := False;
    edtPPN.Enabled := false;
    edtPPN.Text := '0';

  end;

end;

procedure TfrmBayarCustomer.loaddataInvoice(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin

if chkPajak.Checked then
  s := ' select sls_nama Salesman,fp_nomor,fp_tanggal,fp_jthtempo,fp_taxamount,fp_amount,((fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp) Biaya_Promosi,FP_DP, '
      + ' ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur, '
      + ' ifnull((select sum(retj_cn) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur_cn, '
      + ' ifnull(fp_bayar,0) Bayar '
      + ' from tfp_hdr '
      + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
      + ' inner join tso_hdr on so_nomor=do_so_nomor '
      + ' left join tsalesman on sls_kode=so_sls_kode '
     + ' where fp_cus_kode = '+ Quot(akode)
     + ' and fp_istax = 1 '
else
  s := ' select sls_nama Salesman,fp_nomor,fp_tanggal,fp_jthtempo,fp_taxamount,fp_amount,((fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp) Biaya_Promosi,FP_DP, '
      + ' ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur, '
      + ' ifnull((select sum(retj_cn) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur_cn, '
      + ' ifnull(fp_bayar,0) Bayar '
      + ' from tfp_hdr '
      + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
      + ' inner join tso_hdr on so_nomor=do_so_nomor '
      + ' left join tsalesman on sls_kode=so_sls_kode '
     + ' where fp_cus_kode = '+ Quot(akode)
     + ' and fp_istax <> 1 ' ;



     if FLAGEDIT = False then
    s := s + ' having (fp_amount-(retur)-fp_dp)- bayar > 1 ' ;

     s:= s + ' order by fp_tanggal ';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
             CDS.EmptyDataSet;
          if not eof then
         begin

            i:=1;

            while  not Eof do
             begin

                      CDS.Append;
                      CDS.FieldByName('salesman').AsString        := fieldbyname('salesman').AsString;
                      CDS.FieldByName('invoice').AsString        := fieldbyname('fp_nomor').AsString;
                      CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('fp_tanggal').AsDateTime;
                      CDS.FieldByName('JthTempo').AsDateTime      := fieldbyname('fp_jthtempo').AsDateTime;
                      CDS.FieldByName('Retur').AsFloat      := fieldbyname('Retur').AsFloat  ;
                      CDS.FieldByName('PPN').AsFloat      := fieldbyname('fp_taxamount').AsFloat;
                      CDS.FieldByName('nilai').AsFloat      := fieldbyname('fp_amount').AsFloat-(fieldbyname('retur').AsFloat) -fieldbyname('fp_dp').AsFloat;
                      CDS.FieldByName('terbayar').AsFloat        := fieldbyname('bayar').AsFloat;
                      CDS.FieldByName('bayar').AsFloat       := 0;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
        end
        else
        begin
          cxLookupcustomer.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;

end;


procedure TfrmBayarCustomer.loaddataall(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtyterima : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select '
     + ' byc_nomor,byc_tanggal,byc_cus_kode,byc_memo,byc_nogiro,byc_tglcair,byc_rek_cash,byc_cash,'
     + ' byc_transfer,byc_rek_transfer,byc_potongan,byc_rek_potongan,byc_giro,byc_rek_giro,byc_istax,'
     + ' bycd_fp_nomor,bycd_bayar,byc_ppn,byc_rek_ppn,byc_pph,byc_rek_pph '
     + ' from tbayarcus_hdr inner join tbayarcus_dtl a on byc_nomor=bycd_byc_nomor'
     + ' where byc_nomor = '+ Quot(akode);

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('byc_nomor').AsString;
            edtnomor.Text := fieldbyname('byc_nomor').AsString;
            dttanggal.DateTime := fieldbyname('byc_tanggal').AsDateTime;
            atanggalold := fieldbyname('byc_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('byc_memo').AsString;
            cxLookupcustomer.EditValue  := fieldbyname('byc_cus_kode').AsString;
            if fieldbyname('byc_istax').AsString = '1' then
               chkpajak.Checked := True
            else
               chkPajak.Checked := False;
            if fieldbyname('byc_rek_cash').AsString <> ''  then
            begin
              cxLookupRekeningCash.EditValue := fieldbyname('byc_rek_cash').AsString;
              chkCash.Checked :=True;
              edtNilaiCash.Text :=  fieldbyname('byc_cash').AsString;
            end;
            if fieldbyname('byc_rek_transfer').AsString <> '' then
            begin
              cxLookupRekeningTransfer.EditValue := fieldbyname('byc_rek_transfer').AsString;
              chkTransfer.Checked := True;
              edtNilaiTransfer.Text  := fieldbyname('byc_transfer').AsString;
            end;
            if fieldbyname('byc_rek_potongan').AsString <> '' then
            begin
            cxLookupRekeningPotongan.EditValue := fieldbyname('byc_rek_potongan').AsString;
            chkPotongan.Checked := true;
            edtNilaiPotongan.Text  := fieldbyname('byc_potongan').AsString;
            end;
            if fieldbyname('byc_rek_ppn').AsString <> '' then
            begin
            cxLookupRekPPN.EditValue := fieldbyname('byc_rek_ppn').AsString;
            chkPPN.Checked := true;
            edtppn.Text  := fieldbyname('byc_ppn').AsString;
            end;
            if fieldbyname('byc_rek_pph').AsString <> '' then
            begin
            cxLookupRekeningPPH.EditValue := fieldbyname('byc_rek_pph').AsString;
            chkPPH.Checked := true;
            edtpph.Text  := fieldbyname('byc_pph').AsString;
            end;
            if fieldbyname('byc_rek_giro').AsString <> '' then
            begin
            chkGiro.Checked := True;
            cxLookupRekeningGiro.EditValue := fieldbyname('byc_rek_giro').AsString;
            edtNilaiGiro.Text :=  fieldbyname('byc_giro').AsString;
            end;

            edtGiro.Text := fieldbyname('byc_nogiro').AsString;
            dtTglCair.DateTime := fieldbyname('byc_tglcair').AsDateTime;
            

            i:=1;

            while  not Eof do
            begin
                CDS.first;


                while not CDS.Eof do
                begin
                 if CDS.FieldByName('invoice').AsString = FieldByName('bycd_fp_nomor').AsString then
                 begin
                    If CDS.State <> dsEdit then CDS.Edit;
                    CDS.FieldByName('terbayar').AsFloat := CDS.FieldByName('terbayar').AsFloat - fieldbyname('bycd_bayar').AsFloat;
                    CDS.FieldByName('bayar').AsFloat :=fieldbyname('bycd_bayar').AsFloat;
                    CDS.FieldByName('pay').AsInteger := 1;
                    CDS.Post;
                 end;
                  CDS.Next;
                  Inc(i);

                end;
              next;
            end ;
             CDS.first;
             while not CDS.Eof do
             begin
               if CDS.FieldByName('terbayar').AsFloat =CDS.FieldByName('nilai').AsFloat then
                  CDS.Delete
                else
                   CDS.next;
             end;




        end
        else
        begin
          ShowMessage('Nomor  tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;


   end;

end;

procedure TfrmBayarCustomer.cxLookupcustomerPropertiesEditValueChanged(
  Sender: TObject);
begin
  loaddataInvoice(cxLookupcustomer.EditValue);
  edtAlamat.Text := CDScustomer.Fields[2].AsString;
end;

function TfrmBayarCustomer.GetCDSRekeningCash: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningCash) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening where rek_kol_id=1 and rek_isaktif=1 and rek_nama like '+ Quot('KAS%');;


    FCDSRekeningCash := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningCash;
end;

procedure TfrmBayarCustomer.clStatusPropertiesEditValueChanged(
  Sender: TObject);
begin
   CDS.Post;
   If CDS.State <> dsEdit then CDS.Edit;
  if CDS.FieldByName('pay').AsInteger = 1 then
     CDS.FieldByName('bayar').AsFloat :=CDS.FieldByName('nilai').AsFloat-CDS.FieldByName('terbayar').AsFloat
  else
     CDS.FieldByName('bayar').AsFloat := 0;
  cds.post;

end;

procedure TfrmBayarCustomer.clBayarPropertiesEditValueChanged(
  Sender: TObject);
begin
 CDS.Post;

end;

procedure TfrmBayarCustomer.hitung;
var
  asubtotal : Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('bayar'));
end;

procedure TfrmBayarCustomer.cxGrdMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
begin
hitung;
end;

procedure TfrmBayarCustomer.clBayarPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
   i:integer;
  akurang:double;
begin

  akurang :=0;

    i:=cxGrdMain.DataController.FocusedRecordIndex;


    if cVarTofloat(DisplayValue)+ cVarTofloat(cxGrdMain.DataController.Values[i,clterbayar.index]) >  cVarTofloat(cxGrdMain.DataController.Values[i,clNilai.index]) then
    begin
      error := true;
        ErrorText :='Pembayarana melebihi kurang Bayar';
        exit;
    end;

end;


procedure TfrmBayarCustomer.chkCashClick(Sender: TObject);
begin
  if  chkCash.Checked then
  begin
    cxLookupRekeningCash.Enabled := True;
    edtNilaiCash.Enabled := True;

  end
  else
  begin
    cxLookupRekeningCash.Enabled := False;
    edtNilaiCash.Enabled := false;
    edtNilaiCash.Text := '0';

  end;

end;

procedure TfrmBayarCustomer.chkTransferClick(Sender: TObject);
begin
  if  chkTransfer.Checked then
  begin
    cxLookupRekeningTransfer.Enabled := True;
    edtNilaiTransfer.Enabled := True;

  end
  else
  begin
    cxLookupRekeningTransfer.Enabled := False;
    edtNilaiTransfer.Enabled := false;
    edtNilaiTransfer.Text := '0';

  end;

end;

procedure TfrmBayarCustomer.chkPotonganClick(Sender: TObject);
begin
  if  chkPotongan.Checked then
  begin
    cxLookupRekeningPotongan.Enabled := True;
    edtNilaiPotongan.Enabled := True;

  end
  else
  begin
    cxLookupRekeningPotongan.Enabled := False;
    edtNilaiPotongan.Enabled := false;
    edtNilaiPotongan.Text := '0';

  end;

end;

procedure TfrmBayarCustomer.chkGiroClick(Sender: TObject);
begin
  if  chkGiro.Checked then
  begin
    cxLookupRekeningGiro.Enabled := True;
    edtNilaiGiro.Enabled := True;

  end
  else
  begin
    cxLookupRekeningGiro.Enabled := False;
    edtNilaiGiro.Enabled := false;
    edtNilaiGiro.Text := '0';

  end;

end;

function TfrmBayarCustomer.GetCDSRekeningGiro: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningGiro) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening WHERE rek_isaktif=1 and rek_nama like '+ Quot('%giro%');;


    FCDSRekeningGiro := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningGiro;
end;

function TfrmBayarCustomer.GetCDSRekeningTransfer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningTransfer) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening where rek_kol_id=1 and rek_isaktif=1 and rek_nama like '+ Quot('B%');;


    FCDSRekeningTransfer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningTransfer;
end;

function TfrmBayarCustomer.GetCDSRekeningPotongan: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningPotongan) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening where rek_isaktif=1';


    FCDSRekeningPotongan := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningPotongan;
end;

procedure TfrmBayarCustomer.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'BYC';

          s:= ' select '
       + ' * ,'
       + ' ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur, '
       + ' terbilang(byc_cash+byc_transfer+byc_giro+byc_potongan+byc_ppn+byc_pph) terbilang '
       + ' from tbayarcus_hdr '
       + ' inner join tbayarcus_dtl on byc_nomor=bycd_byc_nomor'
       + ' inner join tfp_hdr on fp_nomor=bycd_fp_nomor'
       + ' inner join tcustomer on byc_cus_kode=cus_kode '
       + ' LEFT join trekening a on a.rek_kode=byc_rek_cash '
       + ' LEFT join trekening b on b.rek_kode=byc_rek_transfer '
        + ' LEFT join trekening c on c.rek_kode=byc_rek_giro '
        + ' LEFT join trekening d on d.rek_kode=byc_rek_potongan '
       + ' where '
       + ' byc_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmBayarCustomer.LihatFakturPenjualan1Click(Sender: TObject);
var
  frmFP: TfrmFP;
begin
  inherited;
  If CDS.FieldByname('Invoice').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Faktur Penjualan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFP  := frmmenu.ShowForm(TfrmFP) as TfrmFP;
      frmFP.ID := CDS.FieldByname('Invoice').AsString;
      frmFP.FLAGEDIT := True;
      frmFP.edtnOMOR.Text :=frmMenu.KDCABANG+'-SO'+copy(CDS.FieldByname('Invoice').AsString,6,Length(CDS.FieldByname('Invoice').AsString));

      frmFP.loaddataall(frmFP.edtnOMOR.Text);
//      if cekbayar(CDS.FieldByname('Invoice').AsString) = 1 then
//      begin
//        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
//        frmFP.cxButton2.Enabled :=False;
//        frmFP.cxButton1.Enabled :=False;
//        frmFP.cxButton3.Enabled := False;
//      end;
   end;
   frmFP.Show;
end;


procedure TfrmBayarCustomer.chkPajakClick(Sender: TObject);
begin
loaddataInvoice(cxLookupCustomer.EditValue);
end;

procedure TfrmBayarCustomer.chkPPHClick(Sender: TObject);
begin
  if  chkPPH.Checked then
  begin
    cxLookupRekeningPPH.Enabled := True;
    edtPPH.Enabled := True;

  end
  else
  begin
    cxLookupRekeningPPH.Enabled := False;
    edtPPH.Enabled := false;
    edtPPH.Text := '0';

  end;

end;

function TfrmBayarCustomer.GetCDSRekeningppn: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningppn) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening where rek_isaktif=1 and rek_nama like '+ Quot('PPN%');


    FCDSRekeningppn := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningppn;
end;

function TfrmBayarCustomer.GetCDSRekeningPPH: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningPPH) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening where rek_isaktif=1 and rek_nama like '+ Quot('PPH%');


    FCDSRekeningPPH := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningPPH;
end;

end.
