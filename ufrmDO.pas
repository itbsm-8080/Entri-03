unit ufrmDO;

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
  MyAccess;

type
  TfrmDO = class(TForm)
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
    clSudah: TcxGridDBColumn;
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
    clKurang: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clSatuan: TcxGridDBColumn;
    Label5: TLabel;
    edtNomorSO: TAdvEditBtn;
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
   procedure initViewSKU;
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
    function getstatusexpired(asku:integer): integer;
    function getqtykirim(anomor:string;asku:integer): integer;
    function getqtydo(asku:integer;anomor:string): integer;
    function getqtydo2(asku:integer;anomor:string;atgl:tdatetime): integer;

    procedure edtNomorSOClickBtn(Sender: TObject);
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
   procedure bantuansku;
    procedure clSKUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure loaddataSO(akode : string);
    procedure doslip(anomor : string );
    procedure insertketampungan(anomor:string);
    function getstok(aid:Integer;atgl:TDateTime):integer;
    procedure doslip2(anomor : string );
    procedure cxButton3Click(Sender: TObject);
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
  frmDO: TfrmDO;
const
   NOMERATOR = 'DO';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmCetak;

{$R *.dfm}

procedure TfrmDO.refreshdata;
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
  edtNomorSO.Clear;
  edtNomorSO.SetFocus;
  initgrid;

end;
procedure TfrmDO.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmDO.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmDO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmDO.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(do_nomor,4)) from tdo_hdr inner join tso_hdr on so_nomor=do_so_nomor where do_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
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
   s:='select max(right(do_nomor,3)) from tdo_hdr inner join tso_hdr on so_nomor=do_so_nomor where do_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
   + ' and so_istax=0 ';
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

procedure TfrmDO.cxButton1Click(Sender: TObject);
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

procedure TfrmDO.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmDO.cxButton2Click(Sender: TObject);
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

procedure TfrmDO.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;

   with TcxExtLookupHelper(cxLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
   
end;

function TfrmDO.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'Namabarang', ftstring, False,100);

    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Sudah', ftFloat, False);
    zAddField(FCDS, 'Kurang', ftFloat, False);
    zAddField(FCDS, 'Expired', ftDate, False, 255);
    zAddField(FCDS, 'Closed', ftInteger, False);
    zAddField(FCDS, 'Gudang', ftString, False, 10);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmDO.GetCDScustomer: TClientDataset;
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

procedure TfrmDO.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmDO.cxLookupcustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDScustomer.Fields[2].AsString;
edtShipAddress.Text := CDScustomer.Fields[3].AsString;
end;

procedure TfrmDO.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmDO.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan from Tbarang '
  + ' inner join tso_dtl on sod_brg_kode=brg_kode and sod_so_nomor =' + Quot(edtNomorSO.Text);


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);


end;
procedure TfrmDO.clQTYPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;

 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;

end;
procedure TfrmDO.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmDO.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
 bantuansku;
end;

procedure TfrmDO.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmDO.dtTanggalChange(Sender: TObject);
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


procedure TfrmDO.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;

begin

if FLAGEDIT then
  s:='update Tdo_HDR set '
    + ' do_gdg_kode = ' + Quot(cxLookupGudang.EditValue) + ','
    + ' do_memo = ' + Quot(edtmemo.Text) + ','
    + ' do_tanggal = ' + Quotd(dtTanggal.Date)+','
    + ' do_shipaddress = ' + quot(edtshipaddress.text)+','
    + ' do_cus_kode = ' + quot(cxLookupCustomer.EditValue) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where do_nomor = ' + quot(FID) + ';'
else
begin
 if apajak=1  then
  edtNomor.Text := getmaxkode(1)
  else
  edtNomor.Text := getmaxkode(0);
  s :=  ' insert into Tdo_HDR '
             + ' (do_nomor,do_tanggal,do_gdg_kode,do_so_nomor,do_cus_kode,do_shipaddress,do_memo,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(cxLookupGudang.EditValue) + ','
             + Quot(edtNomorSO.Text)+','
             + Quot(cxLookupCustomer.EditValue)+','
             + quot(edtshipaddress.text)+','
             + Quot(edtmemo.Text)+','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from Tdo_DTL '
      + ' where  dod_do_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
   begin
    S:='insert into tdo_DTL (dod_do_nomor,dod_brg_kode,dod_brg_satuan,dod_qty,dod_tgl_expired,dod_nourut,dod_status,dod_gdg_kode) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + quotd(CDS.FieldByName('expired').AsDateTime) +','
      + IntToStr(i)  +','
      + IntToStr(CDS.FieldByName('closed').AsInteger)+','
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


function TfrmDO.cekdata:Boolean;
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

procedure TfrmDO.edtNomorSOClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT so_NOMOR Nomor,so_TANGGAL Tanggal,cus_NAMA customer from tso_hdr '
            + ' inner join tcustomer on cus_kode=so_cus_kode where so_isclosed=0'
            + ' order by so_tanggal desc';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtNomorSO.Text := varglobal;
    loaddataSO(edtNomorSO.Text);

end;

function TfrmDO.GetCDSGudang: TClientDataset;
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


procedure TfrmDO.loaddataall(akode : string);
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
  s := ' select do_NOMOr,do_tanggal,so_nomor,do_memo,so_cus_kode,do_gdg_kode,do_shipaddress,'
     + ' dod_brg_kode,dod_bRG_satuan,brg_nama,dod_qty,dod_tgl_expired,dod_status,dod_gdg_kode'
     + ' from tdo_hdr inner join tso_hdr a on do_so_nomor=so_nomor'
     + ' left join tdo_dtl on dod_do_nomor=do_nomor'
     + ' left join tbarang on brg_kode=dod_brg_kode '
     + ' where do_nomor = '+ Quot(akode)
     + ' order by dod_nourut ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('do_nomor').AsString;
            edtnomor.Text := fieldbyname('do_nomor').AsString;
            edtNomorSO.Text   := fieldbyname('so_nomor').AsString;
            dttanggal.DateTime := fieldbyname('do_tanggal').AsDateTime;
            atanggalold := fieldbyname('do_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('do_memo').AsString;
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
            edtShipAddress.Text := fieldbyname('do_shipaddress').AsString;
            cxLookupGudang.EditValue := fieldbyname('do_gdg_kode').AsString;

            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                        aketemu:=False;
                        for a := 0 to cxGrdMain.DataController.RecordCount-1 do
                        begin
                          If (cVarToInt(cxGrdMain.DataController.Values[a, clSKU.Index]) = fieldbyname('dod_brg_kode').AsInteger) and (cxGrdMain.DataController.FocusedRecordIndex <> a) then
                          begin
                            aketemu := True;
                          end;
                        end;
                        if not aketemu then
                        begin
                          aqtypo :=  getqtypo(fieldbyname('so_nomor').AsString,fieldbyname('dod_brg_kode').AsInteger);
                          qtykirim := getqtykirim(fieldbyname('so_nomor').AsString,fieldbyname('dod_brg_kode').AsInteger);
                        end;
                      CDS.FieldByName('no').AsInteger        := i;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('dod_brg_kode').AsInteger;
                      CDS.FieldByName('Namabarang').AsString  := fieldbyname('brg_nama').AsString;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('dod_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('dod_qty').AsInteger;
                      if not aketemu then
                      CDS.FieldByName('sudah').AsInteger        := qtykirim-getqtydo(fieldbyname('dod_brg_kode').AsInteger,edtnomor.text);
                      if not aketemu then
                      CDS.FieldByName('kurang').AsInteger        := aqtypo-qtykirim+getqtydo(fieldbyname('dod_brg_kode').AsInteger,edtnomor.text);

                      CDS.FieldByName('expired').AsDateTime := fieldbyname('dod_tgl_expired').AsDateTime;
                      CDS.FieldByName('closed').AsInteger  :=  fieldbyname('dod_status').AsInteger;
                      CDS.FieldByName('gudang').AsString  :=  fieldbyname('dod_gdg_kode').AsString;

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

function TfrmDO.getqtyPO(anomor:string;asku:integer): integer;
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

function TfrmDO.getstatusexpired(asku:integer): integer;
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

function TfrmDO.getqtykirim(anomor:string;asku:integer): integer;
var
  s:string  ;
  tsql:TMyQuery  ;
begin
  Result :=0;
  s:='select sod_qty_kirim from tso_dtl where sod_so_nomor ='+Quot(anomor)
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
function TfrmDO.getqtydo(asku:integer;anomor:string): integer;
var
  s:string  ;
  tsql:TMyQuery  ;
begin
  Result :=0;
  s:='select sum(dod_qty) from tdo_dtl where dod_do_nomor ='+Quot(anomor)
   + ' and dod_brg_kode='+inttostr(asku) ;
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

function TfrmDO.getqtydo2(asku:integer;anomor:string;atgl:tdatetime): integer;
var
  s:string  ;
  tsql:TMyQuery  ;
begin
  Result :=0;
  s:='select sum(dod_qty) from tdo_dtl where dod_do_nomor ='+Quot(anomor)
   + ' and dod_brg_kode='+inttostr(asku)
   + ' and dod_tgl_expired='+quotd(atgl);
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

procedure TfrmDO.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aqtykurang,aqtylain:integer;
begin
  aqtylain := 0;
  aqtykurang :=0;
  cxGrdMain.DataController.Post;

    for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin
      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = (cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index])))
      and (cxGrdMain.DataController.FocusedRecordIndex <> i) then
      begin
        aqtylain  := aqtylain + cVarToInt(cxGrdMain.DataController.Values[i, clQTY.Index]);
      end;
      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = (cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index]))) then
      begin
        aqtykurang :=aqtykurang+ cVarToInt(cxGrdMain.DataController.Values[i, clKurang.Index]);
      end;
    end;
    if cVarToInt(DisplayValue)+aqtylain > aqtykurang then
    begin
      error := true;
        ErrorText :='Qty melebihi qty kurang';
        exit;
    end;

    if (cVarToInt(DisplayValue) > getstok(cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index]),cVarTodate(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clExpired.Index]))) then
    begin
//      if MessageDlg('Qty melebihi stok gudang, Lanjut?',mtCustom,
//                                  [mbYes,mbNo], 0)= mrNo then
//      begin
      error := true;
      ErrorText :='Qty melebihi stok gudang';
      exit;
//      end;
    end;


end;

procedure TfrmDO.bantuansku;
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
      a:Integer;
  aketemu:Boolean;
  aqtypo,qtykirim : Integer;
begin
      sqlbantuan := 'select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
  + ' inner join tso_dtl on sod_brg_kode=brg_kode and sod_so_nomor =' + Quot(edtNomorSO.Text)
  + ' where mst_noreferensi <> ' + quot(edtNomor.text)
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date '
  + ' having sum(mst_stok_in-mst_stok_out) <> 0 '
  + ' union select brg_kode Sku,null Expired,brg_nama,brg_satuan Satuan, 0 stok fROM tbarang '
  + ' inner join tso_dtl on sod_brg_kode=brg_kode and sod_so_nomor ='+ Quot(edtNomorSO.Text)
  + ' and brg_kode not in (select brg_kode from Tbarang '
  + ' inner join tso_dtl on sod_brg_kode=brg_kode and sod_so_nomor ='+ Quot(edtNomorSO.Text)
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
  + ' where mst_noreferensi <> '+ quot(edtNomor.text)
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date '
  + ' having sum(mst_stok_in-mst_stok_out) <> 0)';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
     for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = StrToInt(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
       and (StrToDate(varglobal1)= cVarTodate(cxGrdMain.DataController.Values[i, clexpired.Index]))
       then
      begin
        if cxGrdMain.DataController.Values[i, clgudang.Index] = cxLookupGudang.EditValue then
        begin
          ShowMessage('Sku dan expired ada yang sama dengan baris '+ IntToStr(i+1));
          CDS.Cancel;
          exit;
        end;
      end;
    end;
      If CDS.State <> dsEdit then
         CDS.Edit;
      CDS.FieldByName('sku').AsInteger := StrToInt(varglobal);
      CDS.FieldByName('expired').AsDateTime := strtodate(varglobal1);

             s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok, '
        + ' sod_qty_kirim sudah,sod_qty-sod_qty_kirim kurang,sod_isclosed '
        + '  from Tbarang '
        + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
        + ' left join tso_dtl on sod_brg_kode=brg_kode and sod_so_nomor = ' + Quot(edtNomorSO.Text)
        + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
        + ' and mst_expired_date = ' + QuotD(CDS.Fieldbyname('expired').AsDateTime)
        + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date ';

    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
          CDS.FieldByName('NamaBarang').AsString := Fields[2].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[3].AsString;

                        for a := 0 to cxGrdMain.DataController.RecordCount-1 do
                        begin
                          If (cVarToInt(cxGrdMain.DataController.Values[a, clSKU.Index]) = StrToInt(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> a) then
                          begin
                            aketemu := True;
                          end;
                        end;
                        if not aketemu then
                        begin
                          aqtypo :=  getqtypo(edtNomorSO.Text,StrToInt(varglobal));
//                          qtykirim := getqtykirim(edtNomorSO.Text,StrToInt(varglobal));
                        end;

          if FLAGEDIT = false then
          begin

           CDS.FieldByName('sudah').AsFloat := Fields[5].AsFloat;

          END
          else

           CDS.FieldByName('sudah').AsFloat := 0;

           CDS.FieldByName('kurang').AsFloat := aqtypo-CDS.FieldByName('sudah').AsFloat;


           CDS.FieldByName('gudang').Asstring := VarToStr(cxLookupGudang.EditValue);

        end
        else
          bantuansku;
        finally
          free;
      end;
    end;
  end;
end;

procedure TfrmDO.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
bantuansku;
end;

procedure TfrmDO.loaddataSO(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin


  s := ' select so_nomor,so_tanggal,so_cus_kode,so_istax,'
     + ' sod_brg_kode,sod_bRG_satuan,sod_qty,sod_qty_kirim sudah,sod_qty-sod_qty_kirim kurang,sod_isclosed,brg_nama'
     + ' from tso_hdr a'
     + ' LEFT join tso_dtl d on a.so_nomor=d.sod_so_nomor '
     + ' LEFT join tbarang on sod_brg_kode=brg_kode'
     + ' where a.so_nomor = '+ Quot(akode)
     + ' order by sod_nourut';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin

            edtNomorSO.Text   := fieldbyname('so_nomor').AsString;
            apajak := fieldbyname('so_istax').AsInteger;
            edtNomor.Text := getmaxkode(apajak);
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;


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

procedure TfrmDO.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'DO';

          s:= ' select '
       + ' *,if(DOd_nourut is null ,1000,DOd_nourut) nourut '
       + ' from tDO_hdr '
       + ' inner join tso_hdr on so_nomor=DO_so_nomor'
       + ' inner join tampung on nomor=DO_nomor '
       + ' inner join tcustomer on trim(so_cus_kode)=trim(cus_kode) '
       + ' left join  tDO_dtl on DO_nomor=DOd_DO_nomor and tam_nama = DOd_brg_kode and dod_tgl_expired=expired'
       + ' left join tbarang on DOd_brg_kode=brg_kode '
       + ' left join tgudang on gdg_kode=DOd_gdg_kode '       
       + ' where '
       + ' DO_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmDO.insertketampungan(anomor:string);
var
  s:string;
  tsql : TMyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=getbarisslip('DO');;
  s:='delete from tampung ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  s := 'select DOd_brg_kode,dod_tgl_expired from tDO_dtl where DOd_DO_nomor =' + Quot(anomor) ;
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


function TfrmDO.getstok(aid:Integer;atgl:TDateTime):integer;
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

procedure TfrmDO.doslip2(anomor : string );
var
  s: string ;
  tsql2,tsql : TMyQuery;
  abaris,i,a:Integer;
  anamabarang: String;


begin
    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := getbarisslip('DO');
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
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' S U R A T   J A L A N ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
      memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
    finally
      Free;
    end;
  end;

          s:= ' select '
       + ' *,if(DOd_nourut is null ,1000,DOd_nourut) nourut '
       + ' from tDO_hdr '
       + ' inner join tso_hdr on so_nomor=DO_so_nomor'
       + ' inner join tcustomer on trim(so_cus_kode)=trim(cus_kode) '

///       + ' inner join tgudang on gdg_kode=DO_gdg_kode '
       + ' left join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tDO_dtl on DO_nomor=DOd_DO_nomor '
       + ' left join tbarang on DOd_brg_kode=brg_kode '
       + ' left join tgudang on gdg_kode=dod_gdg_kode '
       + ' where '
       + ' DO_nomor=' + quot(anomor)
       + ' order by nourut';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try

    if not Eof then
    begin
      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('DO_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('do_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Kirim ke   :'+fieldbyname('do_shipaddress').AsString, 60, ' ')+ StrPadRight(' Salesman : '+fieldbyname('sls_nama').AsString, 60, ' '));

      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 8, ' ')+' '
                          +StrPadRight('Nama', 44, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')
                          );
       memo.Lines.Add(StrPadRight('', 120, '-'));
    end;
     while not eof do
     begin
         if strtoint(formatdatetime('yyyy',fieldbyname('dod_tgl_expired').AsDateTime)) > 2000 then
         anamabarang :=FieldByName('brg_nama').AsString + ' / '+FormatDateTime('dd/mm/yy',fieldbyname('dod_tgl_expired').AsDateTime)
         else
         anamabarang :=FieldByName('brg_nama').AsString;

       i:=i+1;
       memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
                          +StrPadRight(fieldbyname('dod_brg_kode').AsString, 8, ' ')+' '
                          +StrPadRight(anamabarang, 44, ' ')+' '
                          +StrPadRight(fieldbyname('dod_brg_satuan').AsString, 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###',fieldbyname('dod_qty').Asfloat), 10, ' ')+' '
                          + StrPadRight(fieldbyname('gdg_nama').AsString, 10, ' ')
                          );
       Next;
       if (i mod abaris =0) and (not eof) then
       begin
         memo.Lines.Add(StrPadRight('', 120, '-'));
            for a:=1 to 7 do
            begin
              memo.Lines.Add('');
            end;
                        s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' S U R A T   J A L A N ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
                memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));

            memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('DO_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('do_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('Kirim ke   :'+fieldbyname('do_shipaddress').AsString, 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_telp').AsString+'/'+fieldbyname('cus_fax').AsString, 60, ' '));

            memo.Lines.Add(StrPadRight('', 120, '-'));
            memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 12, ' ')+' '
                          +StrPadRight('Nama', 40, ' ')+' '
                          +StrPadRight('Satuan', 10, ' ')+' '
                          +StrPadLeft('Jumlah', 10, ' ')
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

//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',1,80), 81, ' ')+' '
//                          +StrPadRight('Disc faktur   :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###',adiscfaktur), 21, ' ')+ ' '
//                          );
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
//                          +StrPadRight('Total         :', 15, ' ')+ ' '
//                           + StrPadLeft( FormatFloat('##,###,###',anilai), 21, ' ')+ ' '
//                          );
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',161,240), 81, ' ')+' '
//                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###',appn), 21, ' ')+ ' '
//                          );
     memo.Lines.Add(      StrPadRight('', 20, ' ')+' '
                          +StrPadRight('DiSiapkan oleh,', 32, ' ')+' '
                          +StrPadRight('Pengirim ,  ', 32, ' ')
                          +StrPadRight('Penerima ,  ', 30, ' ')

                          );
//


    memo.Lines.Add('');
    memo.Lines.Add('');
    memo.Lines.Add(  StrPadRight('', 21, ' ')
                          +StrPadRight('(               )', 32, ' ')+' '
                          +StrPadRight('(               )', 32, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')                          
                          );

    memo.Lines.Add('');
    memo.Lines.Add('');
    nomor := anomor;
  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;



procedure TfrmDO.cxButton3Click(Sender: TObject);
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
      doslip2(edtNomor.Text);
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;

end.
