unit ufrmTandaTerima;

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
  cxCalendar, cxCheckBox, cxButtonEdit, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  frxClass, frxDMPExport, MyAccess;

type
  TfrmTandaTerima = class(TForm)
    PANEL: TAdvPanel;
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
    cxLookupCustomer: TcxExtLookupComboBox;
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
    AdvPanel5: TAdvPanel;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    edtmemo: TMemo;
    Label10: TLabel;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clSatuan: TcxGridDBColumn;
    cxLookupGudang: TcxExtLookupComboBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    Label7: TLabel;
    edtShipAddress: TAdvEdit;
    clgudang: TcxGridDBColumn;
    cxButton3: TcxButton;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    Label5: TLabel;
    edtNomorSo: TAdvEditBtn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode(aispajak:Integer=1):string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure cxLookupcustomerPropertiesChange(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);

    procedure clQTYPropertiesEditValueChanged(Sender: TObject);
    procedure HapusRecord1Click(Sender: TObject);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);

    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;

    procedure loaddataall(akode : string);
    function getqtyPO(anomor:string;asku:integer): integer;
    function cari(anomor:string): Boolean;
    function getstatusexpired(asku:integer): integer;
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
   procedure bantuansku;
    procedure clSKUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure doslip(anomor : string );
    function getstok(aid:Integer;atgl:TDateTime):integer;
    procedure cxButton3Click(Sender: TObject);
    procedure cxLookupCustomerExit(Sender: TObject);
    procedure edtNomorSoClickBtn(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSSKU : TClientDataset;
    FCDSGudang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    atanggalold:TDateTime;
    function GetCDScustomer: TClientDataset;
    function GetCDSGudang: TClientDataset;



    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmTandaTerima: TfrmTandaTerima;
const
   NOMERATOR = 'TT';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmCetak;

{$R *.dfm}

procedure TfrmTandaTerima.refreshdata;
begin
  FID:='';
  apajak:=1;
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;

  edtnomor.Text := getmaxkode(apajak);
  cxLookupcustomer.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  cxLookupGudang.EditValue := '';
  initgrid;

end;
procedure TfrmTandaTerima.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmTandaTerima.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmTandaTerima.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmTandaTerima.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin

  s:='select max(right(tt_nomor,4)) from ttt_hdr where tt_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
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

procedure TfrmTandaTerima.cxButton1Click(Sender: TObject);
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

procedure TfrmTandaTerima.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmTandaTerima.cxButton2Click(Sender: TObject);
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

procedure TfrmTandaTerima.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;

   with TcxExtLookupHelper(cxLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
   
end;

function TfrmTandaTerima.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'Namabarang', ftstring, False,100);

    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Expired', ftDate, False, 255);
    zAddField(FCDS, 'Closed', ftInteger, False);
    zAddField(FCDS, 'Gudang', ftString, False, 10);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmTandaTerima.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_shipaddress Ship,cus_telp'
        +' from tcustomer';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;

procedure TfrmTandaTerima.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmTandaTerima.cxLookupcustomerPropertiesChange(Sender: TObject);
begin

edtalamat.Text := getnama('tcustomer','cus_kode',cxLookupCustomer.EditValue,'cus_alamat');
edtShipAddress.Text := getnama('tcustomer','cus_kode',cxLookupCustomer.EditValue,'cus_shipaddress');

end;

procedure TfrmTandaTerima.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;


procedure TfrmTandaTerima.clQTYPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;

 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;

end;
procedure TfrmTandaTerima.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmTandaTerima.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
 bantuansku;
end;

procedure TfrmTandaTerima.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmTandaTerima.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
   anomorold := edtNomor.Text;
  anomornew := getmaxkode(apajak);
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


procedure TfrmTandaTerima.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;

begin

if FLAGEDIT then
  s:='update Ttt_HDR set '
    + ' tt_gdg_kode = ' + Quot(cxLookupGudang.EditValue) + ','
    + ' tt_memo = ' + Quot(edtmemo.Text) + ','
    + ' tt_tanggal = ' + Quotd(dtTanggal.Date)+','
    + ' tt_shipaddress = ' + quot(edtshipaddress.text)+','
    + ' tt_cus_kode = ' + quot(cxLookupCustomer.EditValue) + ','
    + ' tt_so_nomor = ' + Quot(edtNomorSo.Text) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where tt_nomor = ' + quot(FID) + ';'
else
begin
 if apajak=1  then
  edtNomor.Text := getmaxkode(1)
  else
  edtNomor.Text := getmaxkode(0);
  s :=  ' insert into Ttt_HDR '
             + ' (tt_nomor,tt_tanggal,tt_gdg_kode,tt_cus_kode,tt_shipaddress,tt_memo,tt_so_nomor,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(cxLookupGudang.EditValue) + ','
             + Quot(cxLookupCustomer.EditValue)+','
             + quot(edtshipaddress.text)+','
             + Quot(edtmemo.Text)+','
             + Quot(edtNomorSo.Text) + ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from Ttt_DTL '
      + ' where  ttd_tt_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
   begin
    S:='insert into ttt_DTL (ttd_tt_nomor,ttd_brg_kode,ttd_brg_satuan,ttd_qty,ttd_tgl_expired,ttd_nourut,ttd_gdg_kode) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + quotd(CDS.FieldByName('expired').AsDateTime) +','
      + IntToStr(i)  +','
      + Quot(CDS.FieldByName('gudang').AsString)
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


function TfrmTandaTerima.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
//   If cxLookupGudang.EditValue = '' then
//    begin
//      ShowMessage('Gudang belum di pilih');
//      result:=false;
//      Exit;
//    end;
     If cxLookupcustomer.EditValue = '' then
    begin
      ShowMessage('customer belum di pilih');
      result:=false;
      Exit;
    end;
    if not cari(edtNomorSo.Text)  then
    begin
      ShowMessage('Nomor So tidak di temukan');
      result:=false;
      Exit;
    end;
  CDS.First;
  While not CDS.Eof do
  begin

    If CDS.FieldByName('GUDANG').AsString = '' then
    begin
      ShowMessage('Gudang Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;


    If CDS.FieldByName('SKU').AsInteger = 0 then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;

    If (CDS.FieldByName('qty').AsInteger > 0 ) and (CDS.FieldByName('expired').AsString = '') and (getstatusexpired(CDS.FieldByName('SKU').AsInteger)=1) then
    begin
      ShowMessage('Expired Baris : ' + inttostr(i) + ' Belum diisi');
      result:=false;
      Exit;

    end;
    inc(i);
    CDS.Next;
  end;
end;

function TfrmTandaTerima.GetCDSGudang: TClientDataset;
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


procedure TfrmTandaTerima.loaddataall(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtykirim : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select tt_NOMOr,tt_tanggal,tt_memo,TT_cus_kode,tt_gdg_kode,tt_shipaddress,tt_so_nomor,'
     + ' ttd_brg_kode,ttd_bRG_satuan,brg_nama,ttd_qty,ttd_tgl_expired,ttd_gdg_kode'
     + ' from ttt_hdr '
     + ' left join ttt_dtl on ttd_tt_nomor=tt_nomor'
     + ' left join tbarang on brg_kode=ttd_brg_kode '
     + ' where tt_nomor = '+ Quot(akode)
     + ' order by ttd_nourut ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('tt_nomor').AsString;
            edtnomor.Text := fieldbyname('tt_nomor').AsString;
            edtnomorso.text := fieldbyname('tt_so_nomor').AsString;
            dttanggal.DateTime := fieldbyname('tt_tanggal').AsDateTime;
            atanggalold := fieldbyname('tt_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('tt_memo').AsString;
            cxLookupcustomer.EditValue  := fieldbyname('TT_cus_kode').AsString;
            edtShipAddress.Text := fieldbyname('tt_shipaddress').AsString;
            cxLookupGudang.EditValue := fieldbyname('tt_gdg_kode').AsString;

            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                      CDS.FieldByName('no').AsInteger        := i;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('ttd_brg_kode').AsInteger;
                      CDS.FieldByName('Namabarang').AsString  := fieldbyname('brg_nama').AsString;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('ttd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('ttd_qty').AsInteger;
                      CDS.FieldByName('expired').AsDateTime := fieldbyname('ttd_tgl_expired').AsDateTime;
                      CDS.FieldByName('gudang').AsString  :=  fieldbyname('ttd_gdg_kode').AsString;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;


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

end;

function TfrmTandaTerima.getqtyPO(anomor:string;asku:integer): integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result :=0;
  s:='select sod_qty from tso_dtl where sod_so_nomor ='+Quot(anomor)
   + ' and sod_brg_kode='+inttostr(asku) ;
   tsql := xOpenQuery(s,frmMenu.conn);
   with tsql do
   begin
     try
       if not eof then
          Result := Fields[0].AsInteger;
     finally
       free;
     end;
   end;

end;

function TfrmTandaTerima.cari(anomor:string): Boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result :=False;
  s:='select so_nomor from tso_hdr where so_nomor ='+Quot(anomor);
   tsql := xOpenQuery(s,frmMenu.conn);
   with tsql do
   begin
     try
       if not eof then
          Result := True;
     finally
       free;
     end;
   end;

end;

function TfrmTandaTerima.getstatusexpired(asku:integer): integer;
var
  s:string  ;
  tsql:TMyQuery  ;
begin
    Result :=0;
  s:='select brg_isexpired from tbarang where brg_kode ='+inttostr(asku);

   tsql := xOpenQuery(s,frmMenu.conn);
   with tsql do
   begin
     try
       if not eof then
          Result := Fields[0].AsInteger;
     finally
       free;
     end;
   end;
end;

procedure TfrmTandaTerima.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aqtykurang,aqtylain:integer;
begin
  aqtylain := 0;
  aqtykurang :=0;
  cxGrdMain.DataController.Post;

    if (cVarToInt(DisplayValue) > getstok(cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index]),cVarTodate(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clExpired.Index]))) then
    begin
      if MessageDlg('Qty melebihi stok gudang, Lanjut?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo then
      begin
      error := true;
       exit;
      end;
    end;

end;

procedure TfrmTandaTerima.bantuansku;
  var
    s:string;
    tsql2,tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku, mst_expired_date  Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tso_dtl on sod_brg_kode=brg_kode and sod_so_nomor='+ Quot(edtNomorSo.Text)
  + ' left join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
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
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
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
          CDS.FieldByName('expired').Asdatetime := Fields[1].asdatetime;

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


              end
              ELSE
              bantuansku;
            finally
              Free;
            end;
          end;
        end;

       CDS.FieldByName('gudang').Asstring := VarToStr(cxLookupGudang.EditValue);
        finally
          free;
      end;
    end;
  end;
end;
procedure TfrmTandaTerima.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
bantuansku;
end;

procedure TfrmTandaTerima.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'TT';

          s:= ' select '
       + ' *,if(ttd_nourut is null ,1000,ttd_nourut) nourut '
       + ' from ttt_hdr '
       + ' inner join tcustomer on trim(tt_cus_kode)=trim(cus_kode) '
       + ' left join  ttt_dtl on tt_nomor=ttd_tt_nomor '
       + ' left join tbarang on ttd_brg_kode=brg_kode '
       + ' left join tgudang on gdg_kode=ttd_gdg_kode '
       + ' where '
       + ' tt_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

function TfrmTandaTerima.getstok(aid:Integer;atgl:TDateTime):integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result:=0;
  s:='select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_expired_date ='+QuotD(atgl)
  + ' and mst_brg_kode =' + IntToStr(aid)
  + ' and mst_gdg_kode =' + Quot(vartostr(cxLookupGudang.EditValue))
  + ' and mst_noreferensi <> ' + quot(edtNomor.Text);
tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].Asinteger;
    finally
      free;
    end;
  end;
  result := result; // + getqtydo2(aid,edtnomor.text,atgl);
end;

procedure TfrmTandaTerima.cxButton3Click(Sender: TObject);
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
      doslip(edtNomor.Text);
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;

procedure TfrmTandaTerima.cxLookupCustomerExit(Sender: TObject);
begin
  if ceklocked(cxLookupCustomer.EditValue) then
  begin
    ShowMessage('Customer ini terkunci');
    cxLookupCustomer.SetFocus;
    Exit;
  end;
end;

procedure TfrmTandaTerima.edtNomorSoClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT so_NOMOR Nomor,cus_kode,so_TANGGAL Tanggal,cus_NAMA customer from tso_hdr '
            + ' inner join tcustomer on cus_kode=so_cus_kode where so_isclosed=0'
            + ' order by so_tanggal desc';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
    edtNomorSO.Text := varglobal;
    cxLookupCustomer.EditValue := varglobal1;
  end;

end;

end.
