unit ufrmRealisasiTandaTerima;

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
  frxClass, frxDMPExport;

type
  TfrmRealisasiTandaTerima = class(TForm)
    PANEL: TAdvPanel;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    cxButton1: TcxButton;
    cxLookupCustomer: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clNomor: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clExpired: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    Label7: TLabel;
    edtShipAddress: TAdvEdit;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    cxGrdMainColumn1: TcxGridDBColumn;
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
    procedure HapusRecord1Click(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure simpandata;
    function cekdata:Boolean;

    procedure loaddataall(akode : string);
    procedure cxButton3Click(Sender: TObject);
    procedure cxLookupCustomerExit(Sender: TObject);
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
  frmRealisasiTandaTerima: TfrmRealisasiTandaTerima;
const

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmCetak;

{$R *.dfm}

procedure TfrmRealisasiTandaTerima.refreshdata;
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
procedure TfrmRealisasiTandaTerima.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmRealisasiTandaTerima.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmRealisasiTandaTerima.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;


procedure TfrmRealisasiTandaTerima.cxButton1Click(Sender: TObject);
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

procedure TfrmRealisasiTandaTerima.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmRealisasiTandaTerima.cxButton2Click(Sender: TObject);
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

procedure TfrmRealisasiTandaTerima.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;

   with TcxExtLookupHelper(cxLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
   
end;

function TfrmRealisasiTandaTerima.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Nomor', ftstring, False,30);
    zAddField(FCDS, 'Customer', ftstring, False,100);
    zAddField(FCDS, 'Tanggal', ftDate, False, 255);
    zAddField(FCDS, 'SO', ftInteger, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmRealisasiTandaTerima.GetCDScustomer: TClientDataset;
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

procedure TfrmRealisasiTandaTerima.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmRealisasiTandaTerima.cxLookupcustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDScustomer.Fields[2].AsString;
edtShipAddress.Text := CDScustomer.Fields[3].AsString;
loadTT;
end;

procedure TfrmRealisasiTandaTerima.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;


procedure TfrmRealisasiTandaTerima.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;



procedure TfrmRealisasiTandaTerima.simpandata;
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
             + ' (tt_nomor,tt_tanggal,tt_gdg_kode,tt_cus_kode,tt_shipaddress,tt_memo,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(cxLookupGudang.EditValue) + ','
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


function TfrmRealisasiTandaTerima.cekdata:Boolean;
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
end;



procedure TfrmRealisasiTandaTerima.loaddataall(akode : string);
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
  s := ' select tt_NOMOr,tt_tanggal,tt_memo,TT_cus_kode,tt_gdg_kode,tt_shipaddress,'
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

procedure TfrmRealisasiTandaTerima.cxButton3Click(Sender: TObject);
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

procedure TfrmRealisasiTandaTerima.cxLookupCustomerExit(Sender: TObject);
begin
  if ceklocked(cxLookupCustomer.EditValue) then
  begin
    ShowMessage('Customer ini terkunci');
    cxLookupCustomer.SetFocus;
    Exit;
  end;
end;

end.
