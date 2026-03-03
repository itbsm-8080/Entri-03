unit ufrmPesanan;

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
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinDarkRoom, dxSkinFoggy,
  dxSkinSeven, dxSkinSharp, MemDS, DBAccess, MyAccess;

type
  TfrmPesanan = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    Label4: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupSales: TcxExtLookupComboBox;
    cxLookupCustomer: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clHarga: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clTotal: TcxGridDBColumn;
    clKet: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    edtShip: TAdvEdit;
    Label5: TLabel;
    chkPajak: TCheckBox;
    AdvPanel5: TAdvPanel;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    edtmemo: TMemo;
    Label7: TLabel;
    edtDiscpr: TAdvEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtDiscFaktur: TAdvEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtPPN: TAdvEdit;
    edtTotal: TAdvEdit;
    clDisc: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    edtDisc: TAdvEdit;
    Label13: TLabel;
    Label14: TLabel;
    edtDP: TAdvEdit;
    clSatuan: TcxGridDBColumn;
    Label15: TLabel;
    cxLookupRekening: TcxExtLookupComboBox;
    Button1: TButton;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    MyQuery1: TMyQuery;
    chkProforma: TCheckBox;
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
    procedure cxLookupCustomerPropertiesChange(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
   procedure initViewSKU;
    procedure clQTYPropertiesEditValueChanged(Sender: TObject);
    procedure HapusRecord1Click(Sender: TObject);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure rorte(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  procedure cxGrdMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);

    procedure hitung;
    procedure ubahharga;
    procedure DoslipSO2 (anomor : string );
    procedure DoslipSO4 (anomor : string );
    function ceklocked(akode:string):boolean;

    procedure edtDiscprExit(Sender: TObject);
    procedure edtDiscFakturExit(Sender: TObject);
    procedure chkPajakClick(Sender: TObject);
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataall(akode : string);
    procedure doslipSO(anomor : string );
    procedure insertketampungan(anomor:string);
    procedure Button1Click(Sender: TObject);
    procedure clHargaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure clDiscPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    function ambildiscsales(akodebrg:string):double;
    procedure clHargaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxLookupCustomerExit(Sender: TObject);
   procedure doslipSO3(anomor : string );

  private
    FCDSSalesman: TClientDataset;
    FCDSCustomer: TClientDataset;
    FCDSRekening: TClientDataset;
    FCDSSKU : TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    Floaddataall: Boolean;
    function GetCDSSalesman: TClientDataset;
    function GetCDSCustomer: TClientDataset;
    function GetCDSRekening: TClientDataset;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDSSalesman: TClientDataset read GetCDSSalesman write FCDSSalesman;
    property CDSCustomer: TClientDataset read GetCDSCustomer write FCDSCustomer;
    property CDSRekening: TClientDataset read GetCDSRekening write FCDSRekening;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmPesanan: TfrmPesanan;
const
  nomerator = 'SO';

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ureport,ufrmCetak,uFrmbantuan2;

{$R *.dfm}

procedure TfrmPesanan.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  Floaddataall :=False;
  dtTanggal.DateTime := Date;
  chkPajak.Checked := True;
  chkPajak.Enabled := True;
  edtnomor.Text := getmaxkode;
  cxLookupSales.EditValue := '';
  cxLookupCustomer.EditValue := '';
  cxLookupRekening.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  edtShip.Clear;
  edtDP.Text :='0';
  cxLookupCustomer.SetFocus;
  initgrid;

end;
procedure Tfrmpesanan.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.FieldByName('Harga').AsInteger  := 0;
  CDS.FieldByName('Total').AsInteger  := 0;
  CDS.Post;

end;
procedure TfrmPesanan.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmPesanan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmPesanan.getmaxkode:string;
var
  s:string;
begin
  if chkPajak.Checked then
  begin
  s:='select max(right(so_nomor,4)) from tso_hdr where so_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and so_istax=1 ';
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
  end
  else
  begin
    s:='select max(right(so_nomor,3)) from tso_hdr where so_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
      + ' and so_istax =0 ';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
  end;
end;

procedure TfrmPesanan.cxButton1Click(Sender: TObject);
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

procedure TfrmPesanan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmPesanan.cxButton2Click(Sender: TObject);
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

function TfrmPesanan.GetCDSSalesman: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSSalesman) then
  begin
    S := 'select sls_nama as salesman, sls_kode Kode'
        +' from tsalesman';
    FCDSSalesman := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSSalesman;
end;

procedure TfrmPesanan.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupSales.Properties) do
    LoadFromCDS(CDSSalesman, 'Kode','Salesman',['Kode'],Self);
  with TcxExtLookupHelper(cxLookupCustomer.Properties) do
    LoadFromCDS(CDSCustomer, 'Kode','Customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupCustomer.Properties).SetMultiPurposeLookup;
      with TcxExtLookupHelper(cxLookupRekening.Properties) do
    LoadFromCDS(CDSRekening, 'Kode','Rekening',['Kode'],Self);


     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     initViewSKU;
end;

function TfrmPesanan.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Harga', ftFloat, False);
    zAddField(FCDS, 'Disc', ftFloat, False);
    zAddField(FCDS, 'Total', ftFloat, False);
    zAddField(FCDS, 'Keterangan', ftString, False, 255);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmPesanan.GetCDSCustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSCustomer) then
  begin
    S := 'select cus_nama as Customer, cus_kode Kode, Cus_alamat Alamat,cus_shipaddress,cus_jc_kode jenis'
        +' from tCustomer';


    FCDSCustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSCustomer;
end;

procedure TfrmPesanan.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmPesanan.cxLookupCustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDSCustomer.Fields[2].AsString;
edtShip.Text :=  CDSCustomer.Fields[3].AsString;
end;

procedure TfrmPesanan.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmPesanan.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_stok Stok,ifnull(hjj_hargajual,brg_hrgJual) HrgJual,'
      + ' brg_satuan Satuan from Tbarang '
      + ' left join thargajualjenis on hjj_brg_kode=brg_kode and hjj_jc_kode = ' +quot(CDSCustomer.Fields[4].AsString)
      + ' order by brg_nama ';


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);


end;
procedure TfrmPesanan.clQTYPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;
  cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index]*(cvartofloat(cxGrdMain.DataController.Values[i,cldisc.Index])/100);
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] * cxGrdMain.DataController.Values[i, clHarga.Index] - lVal;

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Total').AsFloat := lVal;
  CDS.Post;


end;
procedure TfrmPesanan.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmPesanan.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
 if chkPajak.Checked then
 CDS.FieldByName('harga').AsFloat := CDSSKU.Fields[3].AsFloat
 else
 CDS.FieldByName('harga').AsFloat := CDSSKU.Fields[3].AsFloat*getangkappn(dtTanggal.DateTime);

 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[4].Asstring;
end;

procedure TfrmPesanan.rorte(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  var
  i:integer;
begin
    for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin
      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = DisplayValue) and (cxGrdMain.DataController.FocusedRecordIndex <> i) then
      begin
        error := true;
        ErrorText :='Sku sudah ada';
        exit;
      end;
    end;
end;

procedure TfrmPesanan.clKetPropertiesValidate(Sender: TObject;
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

procedure TfrmPesanan.cxGrdMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);

begin
  Hitung;
end;

procedure TfrmPesanan.hitung;
var
  asubtotal : Double;
  adisc:Double;
  i:integer;
begin
//      for i := 0 to cxGrdMain.DataController.RecordCount-1 do

//If cxGrdMain.DataController.RecordCount-1 > 0 then
//begin
//  if chkPajak.Checked then
//  begin
//    for i := 0 to cxGrdMain.DataController.RecordCount-1 do
//    begin
//      cxGrdMain.DataController.Values[i, clHarga.Index] := cxGrdMain.DataController.Values[i, clHarga.Index]/getangkappn(dtTanggal.DateTime);
//    end;
//  end
//  else
//  begin
//    for i := 0 to cxGrdMain.DataController.RecordCount-1 do
//    begin
//      cxGrdMain.DataController.Values[i, clHarga.Index] := cxGrdMain.DataController.Values[i, clHarga.Index]*getangkappn(dtTanggal.DateTime);
//    end;
//
//  end;
//end;
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
  edtDiscFaktur.Text := FloatToStr((cStrToFloat(edtDiscpr.text)/100*asubtotal)+cStrToFloat(edtDisc.text)) ;
  asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
  if chkPajak.Checked then
  begin
    edtTotal.Text :=FloatToStr(asubtotal*getangkappn(dtTanggal.DateTime));
    edtPPN.Text := FloatToStr(asubtotal *getangkappn2(dtTanggal.DateTime));
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal);
    edtPPN.Text := '0';
  end;

end;
procedure TfrmPesanan.edtDiscprExit(Sender: TObject);
begin
 if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
if not Floaddataall then
hitung;
end;

procedure TfrmPesanan.edtDiscFakturExit(Sender: TObject);
begin
  if edtDiscFaktur.Text = '' then
    edtDiscFaktur.Text :='0';
if not Floaddataall then    
  hitung;
end;

procedure TfrmPesanan.chkPajakClick(Sender: TObject);
begin
if not Floaddataall then
begin
//ubahharga;
initgrid;
hitung;
end;
edtnomor.text := getmaxkode;
end;

procedure TfrmPesanan.dtTanggalChange(Sender: TObject);
begin
edtNomor.Text := getmaxkode;
end;


procedure TfrmPesanan.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aisproforma,aistax : integer;
begin
  if chkProforma.Checked then
    aisproforma :=  1
  else
    aisproforma := 0;

  if chkPajak.Checked then
    aistax :=  1
  else
    aistax := 0;
if FLAGEDIT then
  s:='update TSO_HDR set '
    + ' so_cus_kode = ' + Quot(cxLookupCustomer.EditValue) + ','
    + ' so_memo = ' + Quot(edtmemo.Text) + ','
    + ' so_shipaddress = ' + Quot(edtShip.Text)+','
    + ' so_sls_kode = ' + Quot(cxLookupSales.EditValue) + ','
    + ' so_disc_faktur =' + floattostr(cStrToFloat(edtDisc.Text))+ ','
    + ' so_disc_fakturpr = '+ floattostr(cStrToFloat(edtDiscpr.Text))+ ','
    + ' so_amount = '+ floattostr(cstrtoFloat(edtTotal.Text))+ ','
    + ' so_taxamount = '+ floattostr(cStrToFloat(edtPPN.Text))+ ','
    + ' so_istax = ' + IntToStr(aistax)+  ','
    + ' so_DP = ' +floattostr(cStrToFloat(edtDp.Text))+ ','
    + ' so_rek_dp = ' + Quot(VarToStr(cxLookupRekening.EditValue))+','
    + ' so_isproforma = ' + IntToStr(aisproforma) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where so_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into TSO_HDR '
             + ' (so_nomor,so_tanggal,so_memo,so_cus_kode,so_shipaddress,so_sls_kode,so_disc_faktur,'
             + ' so_disc_fakturpr,so_amount,so_taxamount,so_DP,so_rek_dp,so_istax,so_isproforma,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupCustomer.EditValue) + ','
             + Quot(edtShip.Text)  + ','
             + Quot(cxLookupSales.EditValue)+','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + floattostr(cStrToFloat(edtDP.Text))+ ','
             + Quot(VarToStr(cxLookupRekening.EditValue))+','
             + IntToStr(aistax)+  ','
             + IntToStr(aisproforma)+  ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from TSO_DTL '
      + ' where  sod_so_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
  while not CDS.Eof do
  begin
    i:=1;
    S:='insert into tso_DTL (sod_so_nomor,sod_brg_kode,sod_brg_satuan,sod_qty,sod_discpr,sod_harga,sod_keterangan,sod_nourut) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('DISC').AsFloat))+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('harga').AsFloat))+','
      + quot(CDS.FieldByName('keterangan').AsString) +','
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


function TfrmPesanan.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
   If cxLookupCustomer.EditValue = '' then
    begin
      ShowMessage('Customer belum di pilih');
      result:=false;
      Exit;
    end;
     If cxLookupSales.EditValue = '' then
    begin
      ShowMessage('Salesman belum di pilih');
      result:=false;
      Exit;
    end;
  CDS.First;
  if CDS.Eof then
    begin
      ShowMessage('Belum ada detail tidak dapat disimpan');
      result:=false;
      Exit;
    end;
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

  if cStrToFloat(edtDP.Text)> 0  then
  begin
    if VarToStr(cxLookupRekening.EditValue) = '' then
    begin
      ShowMessage('Rekening DP belum di isi ');
      result:=false;
      Exit;
    end;
  end;

end;

procedure TfrmPesanan.loaddataall(akode : string);
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
  s := ' select so_nomor,so_tanggal,so_memo,SO_cus_kode,SO_sls_kode,'
     + ' SO_DISC_faktur,so_disc_fakturpr,so_istax,SO_DP,so_rek_dp,so_shipaddress,sod_keterangan,'
     + ' sod_brg_kode,sod_bRG_satuan,sod_qty,sod_harga,sod_discPR,(sod_qty*sod_harga*(100-sod_discpr)/100) nilai'
     + ' from tso_hdr a'
     + ' LEFT join tso_dtl d on a.so_nomor=d.sod_so_nomor '
     + ' where a.so_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            Floaddataall := True;
            CDS.EmptyDataSet;
            FID :=fieldbyname('so_nomor').AsString;
            if fieldbyname('so_istax').AsInteger =1 then
               chkPajak.Checked := True
            else
              chkPajak.Checked := False;
            chkpajak.Enabled := False;
            edtNomor.Text   := fieldbyname('so_nomor').AsString;
            dttanggal.DateTime := fieldbyname('so_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('so_memo').AsString;
            cxLookupSales.EditValue     := fieldbyname('so_sls_kode').AsString;
            cxLookupCustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
            edtShip.Text := fieldbyname('so_shipaddress').AsString;
            edtDiscpr.Text := fieldbyname('so_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('so_disc_faktur').AsString;
            edtDP.Text :=  fieldbyname('so_DP').AsString;
            cxLookupRekening.EditValue := fieldbyname('so_rek_dp').AsString;

            i:=1;

            while  not Eof do
             begin


                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('sod_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('sod_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('sod_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('sod_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('sod_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('keterangan').AsString  := fieldbyname('sod_keterangan').AsString;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
            Floaddataall := False;
            hitung;
        end
        else
        begin
          ShowMessage('Nomor so tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;
//   hitung;
end;

procedure TfrmPesanan.doslipSO(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'SO';

          s:= ' select '
       + ' *,if(sod_nourut is null ,1000,sod_nourut) nourut ,terbilang(so_amount) terbilang '
       + ' from tso_hdr '
       + ' inner join tampung on nomor=so_nomor '
       + ' inner join tcustomer on TRIM(so_cus_kode)=TRIM(cus_kode) '
       + ' inner join tsalesman on sls_kode=so_sls_kode'
       + ' left join  tso_dtl on so_nomor=sod_so_nomor and tam_nama = sod_brg_kode '
       + ' left join tbarang on sod_brg_kode=brg_kode '
       + ' where '
       + ' so_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

function TfrmPesanan.GetCDSRekening: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekening) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening';


    FCDSRekening := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekening;
end;

procedure TfrmPesanan.insertketampungan(anomor:string);
var
  s:string;
  tsql : TMyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  A:=getbarisslip('SO');
  s:='delete from tampung ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  s := 'select sod_brg_kode from tso_dtl where sod_so_nomor =' + Quot(anomor) ;
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
                  + '(nomor,tam_nama'
                  + ')values ('
                  + Quot(anomor) + ','
                  + Quot(Fields[0].Asstring)
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


procedure TfrmPesanan.ubahharga;
begin

If cds.RecordCount >0 then
begin
  if chkPajak.Checked then
  begin
    CDS.First;
    while not CDS.Eof do
    begin
       If CDS.State <> dsEdit then CDS.Edit;
       CDS.FieldByName('harga').AsFloat := CDS.FieldByName('harga').AsFloat/getangkappn(dtTanggal.DateTime);
         CDS.Post;
       cds.Next;
    end;
  end
  else
  begin
    CDS.First;
    while not CDS.Eof do
    begin
       If CDS.State <> dsEdit then CDS.Edit;
       CDS.FieldByName('harga').AsFloat := CDS.FieldByName('harga').AsFloat*getangkappn(dtTanggal.DateTime);
         CDS.Post;
       cds.Next;
    end;
  end;

end;
end;

procedure TfrmPesanan.doslipSO3(anomor : string );
var
  s: string ;
  tsql2,tsql : TMyQuery;
  abaris,i,a:Integer;
  anamabarang,TERBILANG : String;
  anilaipiutang:double;
  adiscfaktur,adp,atotal,anilai,appn : Double;

begin
    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := getbarisslip('SP');
 with frmCetak do
 begin
    memo.Clear;
        memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp '
      + ' from tperusahaan ';

  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
    try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' S U R A T  P E S A N A N', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
      memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
    finally
      Free;
    end;
  end;

          s:= ' select '
       + ' *,if(sod_nourut is null ,1000,sod_nourut) nourut ,terbilang(so_amount) terbilang ,'
       + ' ((so_amount-so_taxamount)+so_disc_faktur)/(100-so_disc_fakturpr)*100 nett '
       + ' from tso_hdr '
//       + ' inner join tampung on nomor=so_nomor '
       + ' inner join tcustomer on TRIM(so_cus_kode)=TRIM(cus_kode) '
       + ' inner join tsalesman on sls_kode=so_sls_kode'
       + ' left join  tso_dtl on so_nomor=sod_so_nomor '
       + ' left join tbarang on sod_brg_kode=brg_kode '
       + ' where '
       + ' so_nomor=' + quot(anomor)
       + ' order by nourut';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try

    if not Eof then
    begin
      TERBILANG := fieldbyname('terbilang').AsString;
          anilai := fieldbyname('SO_amount').AsFloat-fieldbyname('SO_taxamount').AsFloat;
          appn := fieldbyname('so_taxamount').AsFloat;
          atotal := fieldbyname('so_amount').AsFloat;
          adp :=fieldbyname('so_dp').AsFloat;
          adiscfaktur :=  ((fieldbyname('so_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('so_disc_faktur').asfloat;
//      memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));
//      memo.Lines.Add('');
      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('SO_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('SO_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('ShipAddress:'+fieldbyname('SO_shipaddress').AsString, 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_telp').AsString+'/'+fieldbyname('cus_fax').AsString, 60, ' '));

      memo.Lines.Add(StrPadRight('', 100, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 12, ' ')+' '
                          +StrPadRight('Nama', 40, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')+' '
                          );
       memo.Lines.Add(StrPadRight('', 100, '-'));
    end;
     while not eof do
     begin

         anamabarang :=FieldByName('brg_nama').AsString ;

       i:=i+1;
       memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
                          +StrPadRight(fieldbyname('sod_brg_kode').AsString, 12, ' ')+' '
                          +StrPadRight(anamabarang, 40, ' ')+' '
                          +StrPadRight(fieldbyname('sod_brg_satuan').AsString, 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('sod_qty').Asfloat), 10, ' ')+' '
                          );
       Next;
       if (i mod abaris =0) and (not eof) then
       begin
         memo.Lines.Add(StrPadRight('', 100, '-'));
            for a:=1 to 8 do
            begin
              memo.Lines.Add('');
            end;
                        s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' P R O F O R M A  I N V O I C E ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
                memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));

            memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('SO_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('so_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('ShipAddress:'+fieldbyname('SO_shipaddress').AsString, 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_telp').AsString+'/'+fieldbyname('cus_fax').AsString, 60, ' '));

            memo.Lines.Add(StrPadRight('', 100, '-'));
            memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 12, ' ')+' '
                          +StrPadRight('Nama', 40, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')+' '
                          );

                   memo.Lines.Add(StrPadRight('', 100, '-'));
       end;
     end;
    if  i mod abaris <> 0 then
    begin
      for a:=1 to (abaris - (i mod abaris)) do
      begin
        memo.Lines.Add('');
      end;
    end;
    memo.Lines.Add(StrPadRight('', 100, '-'));

     memo.Lines.Add(      StrPadRight('', 20, ' ')+' '
                          +StrPadRight('Dibuat oleh,', 30, ' ')+' '
                          +StrPadRight('Mengetahui,', 30, ' ')

                          );
//
//                          anilaipiutang :=atotal-
//                          StrToFloat(StringReplace(getdebet(anomor),',','',[rfReplaceAll]));
//      memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('DP        :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('###,###,###',ADP), 21, ' ')+ ' '
//                          );
//     memo.Lines.Add(      StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('Uang Muka     :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',adp), 21, ' ')+ ' '
//                          );

//    memo.Lines.Add(
//                          );


    memo.Lines.Add('');
    memo.Lines.Add(  StrPadRight('', 21, ' ')
                          +StrPadRight('(               )', 30, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')
                          );
       memo.Lines.Add('');
           memo.Lines.Add('');

    nomor :=anomor;
  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;

end;

procedure TfrmPesanan.Button1Click(Sender: TObject);
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
begin

sqlbantuan := ' SELECT so_nomor,cus_kode,cus_nama,so_tanggal,sls_nama Salesman FROM tso_hdr'
            + ' INNER JOIN '+frmmenu.aDatabase+'.tcustomer  ON cus_kode=so_cus_kode'
            + ' INNER JOIN '+frmmenu.aDatabase+'.tsalesman on sls_kode=so_sls_kode'
            + ' WHERE so_cabang='+Quot(frmMenu.StatusBar1.Panels[3].Text)
            + ' and so_tanggal > curdate()-7 '            
            + ' order by so_tanggal desc ';

//    sqlbantuan := 'select nomor_sal,kode_outlet,cus_nama Customer,Tanggal from t_salesh inner join tcustomer on cus_kode=kode_outlet'
//    + ' where tanggal > curdate()-2 '
//    + ' and kode_sales = '+ Quot(vartostr(cxLookupSales.EditValue)) ;
//
  Application.CreateForm(Tfrmbantuan2,frmbantuan2);
  frmBantuan2.SQLMaster := SQLbantuan;
  frmBantuan2.ShowModal;
  if varglobal <> '' then
   begin
     CDS.emptydataset;
     cxLookupCustomer.EditValue := varglobal1;
     if ceklocked(cxLookupCustomer.EditValue) then
      begin
        ShowMessage('Customer ini terkunci');
        cxLookupCustomer.SetFocus;
        Exit;
      end;
       s:='SELECT brg_satuan,sod_brg_kode,brg_nama,sod_qty,0 ,brg_hrgjual,so_sls_kode FROM '
        + ' tso_dtl INNER JOIN '+frmmenu.aDatabase+'.tbarang ON brg_kode=sod_brg_kode'
        + ' inner join tso_hdr on so_nomor=sod_so_nomor AND so_cabang=sod_so_cabang and so_cabang='+Quot(frmMenu.NMCABANG)
        + ' left JOIN '+frmmenu.aDatabase+'.tsalesman on sls_kode=so_sls_kode '
        + ' where sod_so_nomor = ' + Quot(varglobal) ;

//        + ' select BRG_SATUAN,id_barang,brg_nama namabarang,qty,disc,brg_hrgjual  from t_salesh a '
//          + ' INNER JOIN T_salesd b on a.nomor_sal=b.nomor_sal '
//          + ' inner join tbarang c on brg_kode=id_barang '
//          + ' and kode_sales = '+Quot(vartostr(cxLookupSales.EditValue))
//          +'  and a.nomor_sal ='+ Quot(varglobal) ;
    MyQuery1.Connection := frmBantuan2.MyConnection1;
    MyQuery1.close;
    MyQuery1.SQL.Text := s;
    MyQuery1.Open;
    with MyQuery1 do
    begin
      try
        if not eof then
           cxLookupSales.EditValue := fields[6].AsString;
        while not Eof do
        begin
          CDS.Append;
          CDS.FieldByName('SKU').AsString := Fields[1].AsString;
          CDS.FieldByName('qty').asfloat := Fields[3].asfloat;
          CDS.FieldByName('Satuan').AsString := Fields[0].AsString;
          if chkPajak.Checked then
          CDS.FieldByName('harga').asfloat := Fields[5].asfloat
          else
          CDS.FieldByName('harga').asfloat := Fields[5].asfloat*getangkappn(dtTanggal.DateTime);
          CDS.FieldByName('disc').asfloat := Fields[4].asfloat;
          if chkPajak.Checked then
          CDS.FieldByName('total').asfloat := ((100-Fields[4].asfloat)* (Fields[5].asfloat*Fields[3].asfloat)/100)
          else
          CDS.FieldByName('total').asfloat := (100-Fields[4].asfloat)* (Fields[5].asfloat*Fields[3].asfloat)/100*getangkappn(dtTanggal.DateTime);
          Next;
        end;
//         cds.Post;
        finally
          clQTYPropertiesEditValueChanged(self);
          hitung;
      end;
    end;
  end;
end;


procedure TfrmPesanan.clHargaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
           sqlbantuan := 'select brg_nama Nama,fpd_harga Harga,fpd_discpr Disc,fpd_expired Expired,'
                  + ' fp_tanggal Tanggal, fpd_qty Qty from '
                  + ' tfp_dtl inner join tbarang on brg_kode=fpd_brg_kode '
                  + ' inner join tfp_hdr on fpd_fp_nomor=fp_nomor '
                  + ' where fp_nomor <> ' + Quot(edtNomor.Text)
                  + ' AND brg_kode = ' +  VarToStr(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index])
                  + ' and fp_cus_kode= ' + Quot(cxLookupcustomer.EditValue);


  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
//  frmBantuan.btnOK.Visible := False;
  if varglobal <> '' then
   begin
     If CDS.State <> dsEdit then
         CDS.Edit;
      CDS.FieldByName('harga').asfloat := StrTofloat(varglobal1);
      cds.post;
      clQTYPropertiesEditValueChanged(self);
   end;


end;

procedure TfrmPesanan.cxButton3Click(Sender: TObject);
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
      DoslipSO2(edtNomor.Text);
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);

end;

procedure TfrmPesanan.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  try
  s:='update tso_hdr set so_sls_kode='+Quot(cxLookupSales.EditValue)
   + ' where so_nomor = ' + Quot(edtNomor.Text)+ ';';
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   finally
     ShowMessage('Update Id sales berhasil');
   // xCommit(frmMenu.conn);
  end;

end;

procedure TfrmPesanan.clDiscPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  i:integer;
  adisc:Double;
begin
  adisc :=cVarToFloat(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clDisc.Index]);

    if ambildiscsales(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index])  <  cVarToFloat(DisplayValue) then
    begin
     if MessageDlg('Disc Melebihi batas Yakin ingin Lanjut ?',mtCustom,
        [mbYes,mbNo], 0)= mrNo then
      begin
        error := true;
        ErrorText :='Disc Sales Melebihi Batas';
        exit;
      end ;





    end;

end;


function TfrmPesanan.ambildiscsales(akodebrg:string):double;
var
  s:string;
begin
  s:='select brg_disc_sales from tbarang where brg_kode = ' + quot(akodebrg) ;

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= 0
      else
         result:= Fields[0].AsFloat;

    finally
      free;
    end;
  end;
end;



procedure TfrmPesanan.clHargaPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aharga:Double;
  s:string;
  tsql:TMyQuery;
begin
  aharga:=0;
   s:='select ifnull(MST_HARGABELI,0) from tmasterstok where mst_brg_kode= ' + Quot(CDS.Fieldbyname('sku').AsString)
+ ' and mst_hargabeli > 1'
+ ' and (mst_noreferensi like "%MTCI%" or mst_noreferensi like "%KOR%") '
+ ' order by mst_tanggal desc LIMIT 1 ';
//  select sum(mst_stok_in-mst_stok_out) stok from Tbarang '
//  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
//  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
//  + ' and mst_expired_date = ' + QuotD(CDS.Fieldbyname('expired').AsDateTime);

    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
          aharga := Fields[0].AsInteger;
      finally
          free;
      end;
    end;

    if cVarToFloat(DisplayValue) < aharga then
    begin
      ShowMessage('Harga ini kurang dari Lastcost - > ' + FormatFloat('###,###,###.##',aharga));
      error := False;
    end;

end;

procedure TfrmPesanan.cxLookupCustomerExit(Sender: TObject);
begin
  if ceklocked(cxLookupCustomer.EditValue) then
  begin
    ShowMessage('Customer ini terkunci');
    cxLookupCustomer.SetFocus;
    Exit;
  end;
end;

procedure TfrmPesanan.doslipSO2(anomor : string );
var
  s: string ;
  tsql2,tsql : TMyQuery;
  abaris,i,a:Integer;
  anamabarang,TERBILANG : String;
  anilaipiutang:double;
  adiscfaktur,adp,atotal,anilai,appn : Double;

begin
    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := getbarisslip('SO');
 with frmCetak do
 begin
    memo.Clear;
        memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp '
      + ' from tperusahaan ';

  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
    try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' S A L E S   O R D E R ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
      memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
    finally
      Free;
    end;
  end;

          s:= ' select '
       + ' *,if(sod_nourut is null ,1000,sod_nourut) nourut ,terbilang(so_amount) terbilang ,'
       + ' ((so_amount-so_taxamount)+so_disc_faktur)/(100-so_disc_fakturpr)*100 nett '
       + ' from tso_hdr '
//       + ' inner join tampung on nomor=so_nomor '
       + ' inner join tcustomer on TRIM(so_cus_kode)=TRIM(cus_kode) '
       + ' inner join tsalesman on sls_kode=so_sls_kode'
       + ' left join  tso_dtl on so_nomor=sod_so_nomor '
       + ' left join tbarang on sod_brg_kode=brg_kode '
       + ' where '
       + ' so_nomor=' + quot(anomor)
       + ' order by nourut';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try

    if not Eof then
    begin
      TERBILANG := fieldbyname('terbilang').AsString;
          anilai := fieldbyname('SO_amount').AsFloat-fieldbyname('SO_taxamount').AsFloat;
          appn := fieldbyname('so_taxamount').AsFloat;
          atotal := fieldbyname('so_amount').AsFloat;
          adp :=fieldbyname('so_dp').AsFloat;
          adiscfaktur :=  ((fieldbyname('so_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('so_disc_faktur').asfloat;
//      memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));
//      memo.Lines.Add('');
      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('SO_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('SO_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('ShipAddress:'+fieldbyname('SO_shipaddress').AsString, 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_telp').AsString+'/'+fieldbyname('cus_fax').AsString, 60, ' '));

      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 12, ' ')+' '
                          +StrPadRight('Nama', 40, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')+' '
                          +StrPadLeft('Disc(%)', 10, ' ')+' '
                          +StrPadLeft('Harga', 14, ' ')+' '
                          +StrPadLeft('Total', 15, ' ')+' '
                          );
       memo.Lines.Add(StrPadRight('', 120, '-'));
    end;
     while not eof do
     begin

         anamabarang :=FieldByName('brg_nama').AsString ;

       i:=i+1;
       memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
                          +StrPadRight(fieldbyname('sod_brg_kode').AsString, 12, ' ')+' '
                          +StrPadRight(anamabarang, 40, ' ')+' '
                          +StrPadRight(fieldbyname('sod_brg_satuan').AsString, 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('sod_qty').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('sod_discpr').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('#,###,###.##',fieldbyname('sod_harga').Asfloat), 14, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###,###.##',(100-fieldbyname('sod_discpr').Asfloat)/100*fieldbyname('sod_harga').Asfloat*fieldbyname('sod_qty').Asfloat), 15, ' ')+' '
                          );
       Next;
       if (i mod abaris =0) and (not eof) then
       begin
         memo.Lines.Add(StrPadRight('', 120, '-'));
            for a:=1 to 13 do
            begin
              memo.Lines.Add('');
            end;
                        s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' S A L E S   O R D E R ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
                memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));

            memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('SO_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('so_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('ShipAddress:'+fieldbyname('SO_shipaddress').AsString, 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_telp').AsString+'/'+fieldbyname('cus_fax').AsString, 60, ' '));

            memo.Lines.Add(StrPadRight('', 120, '-'));
            memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 12, ' ')+' '
                          +StrPadRight('Nama', 40, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')+' '
                          +StrPadLeft('Disc(%)', 10, ' ')+' '
                          +StrPadLeft('Harga', 14, ' ')+' '
                          +StrPadLeft('Total', 15, ' ')+' '
                          );

                   memo.Lines.Add(StrPadRight('', 120, '-'));
       end;
     end;
    if  i mod abaris <> 0 then
    begin
      for a:=1 to (abaris - (i mod abaris)) do
      begin
        memo.Lines.Add('');
      end;
    end;
    memo.Lines.Add(StrPadRight('', 120, '-'));

    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',1,80), 81, ' ')+' '
                          +StrPadRight('Disc faktur   :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',adiscfaktur), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
                          +StrPadRight('Total         :', 15, ' ')+ ' '
                           + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',161,240), 81, ' ')+' '
                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
                          );
     memo.Lines.Add(      StrPadRight('', 20, ' ')+' '
                          +StrPadRight('Dibuat oleh,', 30, ' ')+' '
                          +StrPadRight('Mengetahui,', 30, ' ')

                          +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' ')+ ' '
                          );
//
//                          anilaipiutang :=atotal-
//                          StrToFloat(StringReplace(getdebet(anomor),',','',[rfReplaceAll]));
//      memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('DP        :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('###,###,###',ADP), 21, ' ')+ ' '
//                          );
     memo.Lines.Add(      StrPadRight('', 81, ' ')+' '
                          +StrPadRight('Uang Muka     :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',adp), 21, ' ')+ ' '
                          );

//    memo.Lines.Add(
//                          );


    memo.Lines.Add('');
    memo.Lines.Add(  StrPadRight('', 21, ' ')
                          +StrPadRight('(               )', 30, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')
                          );
       memo.Lines.Add('');
           memo.Lines.Add('');

    nomor :=anomor;
  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;

end;

function TfrmPesanan.ceklocked(akode:string):boolean;
var s:String;
tsql :TMyQuery;
begin
      Result := False;
    S := 'select * '
        +' from tcustomer where cus_kode='+ Quot(akode)
        + ' and cus_locked=1 ';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
          result := true;
      finally
        free;
      end;
    end;


end;
procedure TfrmPesanan.doslipSO4(anomor : string );
var
  s: string ;
  tsql2,tsql : TMyQuery;
  abaris,i,a:Integer;
  anamabarang,TERBILANG : String;
  anilaipiutang:double;
  adiscfaktur,adp,atotal,anilai,appn : Double;

begin
    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := getbarisslip('SO');
 with frmCetak do
 begin
    memo.Clear;
        memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp '
      + ' from tperusahaan ';

  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
    try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' P R O F O R M A  I N V O I C E ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
      memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
    finally
      Free;
    end;
  end;

          s:= ' select '
       + ' *,if(sod_nourut is null ,1000,sod_nourut) nourut ,terbilang(so_amount) terbilang ,'
       + ' ((so_amount-so_taxamount)+so_disc_faktur)/(100-so_disc_fakturpr)*100 nett '
       + ' from tso_hdr '
//       + ' inner join tampung on nomor=so_nomor '
       + ' inner join tcustomer on TRIM(so_cus_kode)=TRIM(cus_kode) '
       + ' inner join tsalesman on sls_kode=so_sls_kode'
       + ' left join  tso_dtl on so_nomor=sod_so_nomor '
       + ' left join tbarang on sod_brg_kode=brg_kode '
       + ' where '
       + ' so_nomor=' + quot(anomor)
       + ' order by nourut';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try

    if not Eof then
    begin
      TERBILANG := fieldbyname('terbilang').AsString;
          anilai := fieldbyname('SO_amount').AsFloat-fieldbyname('SO_taxamount').AsFloat;
          appn := fieldbyname('so_taxamount').AsFloat;
          atotal := fieldbyname('so_amount').AsFloat;
          adp :=fieldbyname('so_dp').AsFloat;
          adiscfaktur :=  ((fieldbyname('so_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('so_disc_faktur').asfloat;
//      memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));
//      memo.Lines.Add('');
            memo.Lines.Add(StrPadRight('Nomor      : '+StringReplace(fieldbyname('SO_nomor').AsString,'SO','PF',[rfReplaceAll]), 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('SO_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('ShipAddress:'+fieldbyname('SO_shipaddress').AsString, 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_telp').AsString+'/'+fieldbyname('cus_fax').AsString, 60, ' '));

      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 12, ' ')+' '
                          +StrPadRight('Nama', 40, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')+' '
                          +StrPadLeft('Disc(%)', 10, ' ')+' '
                          +StrPadLeft('Harga', 14, ' ')+' '
                          +StrPadLeft('Total', 15, ' ')+' '
                          );
       memo.Lines.Add(StrPadRight('', 120, '-'));
    end;
     while not eof do
     begin

         anamabarang :=FieldByName('brg_nama').AsString ;

       i:=i+1;
       memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
                          +StrPadRight(fieldbyname('sod_brg_kode').AsString, 12, ' ')+' '
                          +StrPadRight(anamabarang, 40, ' ')+' '
                          +StrPadRight(fieldbyname('sod_brg_satuan').AsString, 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('sod_qty').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('sod_discpr').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('#,###,###.##',fieldbyname('sod_harga').Asfloat), 14, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###,###.##',(100-fieldbyname('sod_discpr').Asfloat)/100*fieldbyname('sod_harga').Asfloat*fieldbyname('sod_qty').Asfloat), 15, ' ')+' '
                          );
       Next;
       if (i mod abaris =0) and (not eof) then
       begin
         memo.Lines.Add(StrPadRight('', 120, '-'));
            for a:=1 to 13 do
            begin
              memo.Lines.Add('');
            end;
                        s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' P R O F O R M A  I N V O I C E  ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
                memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));

            memo.Lines.Add(StrPadRight('Nomor      : '+StringReplace(fieldbyname('SO_nomor').AsString,'SO','PF',[rfReplaceAll]), 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('so_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('ShipAddress:'+fieldbyname('SO_shipaddress').AsString, 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_telp').AsString+'/'+fieldbyname('cus_fax').AsString, 60, ' '));

            memo.Lines.Add(StrPadRight('', 120, '-'));
            memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 12, ' ')+' '
                          +StrPadRight('Nama', 40, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')+' '
                          +StrPadLeft('Disc(%)', 10, ' ')+' '
                          +StrPadLeft('Harga', 14, ' ')+' '
                          +StrPadLeft('Total', 15, ' ')+' '
                          );

                   memo.Lines.Add(StrPadRight('', 120, '-'));
       end;
     end;
    if  i mod abaris <> 0 then
    begin
      for a:=1 to (abaris - (i mod abaris)) do
      begin
        memo.Lines.Add('');
      end;
    end;
    memo.Lines.Add(StrPadRight('', 120, '-'));

    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',1,80), 81, ' ')+' '
                          +StrPadRight('Disc faktur   :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',adiscfaktur), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
                          +StrPadRight('Total         :', 15, ' ')+ ' '
                           + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',161,240), 81, ' ')+' '
                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
                          );
     memo.Lines.Add(      StrPadRight('', 20, ' ')+' '
                          +StrPadRight('Dibuat oleh,', 30, ' ')+' '
                          +StrPadRight('Mengetahui,', 30, ' ')

                          +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' ')+ ' '
                          );
//
//                          anilaipiutang :=atotal-
//                          StrToFloat(StringReplace(getdebet(anomor),',','',[rfReplaceAll]));
//      memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('DP        :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('###,###,###',ADP), 21, ' ')+ ' '
//                          );
     memo.Lines.Add(      StrPadRight('', 81, ' ')+' '
                          +StrPadRight('Uang Muka     :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',adp), 21, ' ')+ ' '
                          );

//    memo.Lines.Add(
//                          );


    memo.Lines.Add('');
    memo.Lines.Add(  StrPadRight('', 21, ' ')
                          +StrPadRight('(               )', 30, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')
                          );
       memo.Lines.Add('');
           memo.Lines.Add('');

    nomor :=anomor;
  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;

end;



end.




