unit ufrmReturJual;

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
  cxCalendar, cxCheckBox, cxButtonEdit, MyAccess;

type
  TfrmReturJual = class(TForm)
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
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    AdvPanel5: TAdvPanel;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    edtmemo: TMemo;
    Label10: TLabel;
    clSatuan: TcxGridDBColumn;
    Label5: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    edtNomorfaktur: TAdvEditBtn;
    chkPajak: TCheckBox;
    edtDiscpr: TAdvEdit;
    edtDisc: TAdvEdit;
    edtPPN: TAdvEdit;
    edtTotal: TAdvEdit;
    edtDiscFaktur: TAdvEdit;
    clHarga: TcxGridDBColumn;
    clDisc: TcxGridDBColumn;
    cxLookupGudang: TcxExtLookupComboBox;
    clexpired: TcxGridDBColumn;
    chkCN: TCheckBox;
    edtCN: TAdvEdit;
    clCN: TcxGridDBColumn;
    clNilaiCN: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
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
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);

    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataall(akode : string);
    procedure hitung;


    procedure edtNomorfakturClickBtn(Sender: TObject);
    procedure bantuansku;
    procedure edtDiscprExit(Sender: TObject);
    procedure edtDiscExit(Sender: TObject);
    procedure clDiscPropertiesChange(Sender: TObject);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clSKUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure chkCNClick(Sender: TObject);
    procedure doslipRet(anomor : string );
    procedure Insertketampungan(anomor:string);
    procedure doslip2(anomor : string );
    function getpajak(anomor : string): Integer;
    function cekfaktur(anomor:string):Boolean;
    procedure edtNomorfakturExit(Sender: TObject);
    procedure HapusRecord1Click(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSGudang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
       atanggalold : TDateTime;
    function GetCDScustomer: TClientDataset;
    function GetCDSGudang: TClientDataset;



    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmReturJual: TfrmReturJual;
const
   NOMERATOR = 'RETJ';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmCetak;

{$R *.dfm}

procedure TfrmReturJual.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;

  chkPajak.Checked := true;
  edtnomor.Text := getmaxkode(apajak);
  cxLookupcustomer.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  edtNomorfaktur.SetFocus;
  initgrid;

end;
procedure TfrmReturJual.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmReturJual.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmReturJual.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmReturJual.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(retj_nomor,4)) from tretj_hdr '
  + ' where retj_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and retj_istax=1 ';
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
    s:='select max(right(retj_nomor,3)) from tretj_hdr '
  + ' where retj_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and retj_istax=0 ';

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+fields[0].AsInteger+1),4);

//         showmessage(result);
    finally
      free;
    end;
  end;
  end;
end;

procedure TfrmReturJual.cxButton1Click(Sender: TObject);
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

procedure TfrmReturJual.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmReturJual.cxButton2Click(Sender: TObject);
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

procedure TfrmReturJual.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;

  with TcxExtLookupHelper(cxLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);


     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmReturJual.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'NamaBarang', ftString, False,100);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Harga', ftFloat, False);
    zAddField(FCDS, 'Disc', ftFloat, False);
    zAddField(FCDS, 'Total', ftFloat, False);
    zAddField(FCDS, 'expired', ftDate, False, 255);
    zAddField(FCDS, 'CN', ftFloat, False);
    zAddField(FCDS, 'NilaiCN', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmReturJual.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_telp'
        +' from tcustomer';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;
function TfrmReturJual.GetCDSGudang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSGudang) then
  begin
    S := 'select gdg_nama as Gudang, gdg_kode Kode '
        +' from tGUDANG';


    FCDSGudang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSGudang;
end;

procedure TfrmReturJual.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmReturJual.cxLookupcustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDScustomer.Fields[2].AsString;

end;

procedure TfrmReturJual.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmReturJual.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmReturJual.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
  anomorold := edtNomor.Text;
  anomornew := getmaxkode(apajak);
  if FLAGEDIT then
  begin
    if Copy(anomornew,1,13) <> Copy(anomorold,1,13)then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.Date :=atanggalold;
    end;
  end;

end;


procedure TfrmReturJual.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aistax : integer;
begin
  if chkPajak.Checked then
    aistax :=  1
  else
    aistax := 0;
if FLAGEDIT then
  s:='update Tretj_HDR set '
    + ' retj_cus_kode = ' + Quot(cxLookupcustomer.EditValue) + ','
    + ' retj_tanggal = ' + quotd(dtTanggal.DateTime) + ','
    + ' retj_fp_nomor =' +Quot(edtNomorfaktur.Text)+','
    + ' retj_memo = ' + Quot(edtmemo.Text) + ','
    + ' retj_disc_faktur =' + floattostr(cStrToFloat(edtDisc.Text))+ ','
    + ' retj_disc_fakturpr = '+ floattostr(cStrToFloat(edtDiscpr.Text))+ ','
    + ' retj_amount = '+ floattostr(cstrtoFloat(edtTotal.Text))+ ','
    + ' retj_taxamount = '+ floattostr(cStrToFloat(edtPPN.Text))+ ','
    + ' retj_istax = ' + IntToStr(aistax)+  ','
    + ' retj_gdg_kode='+ Quot(cxLookupgudang.EditValue)+','
    + ' retj_cn = ' + floattostr(cStrToFloat(edtcn.Text))+ ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where retj_nomor = ' + quot(FID) + ';'
else
begin
   edtNomor.Text := getmaxkode(aistax);
   s :=  ' insert into Tretj_HDR '
             + ' (retj_nomor,retj_fp_nomor,retj_tanggal,retj_gdg_kode,retj_memo,retj_cus_kode,retj_disc_faktur,'
             + ' retj_disc_fakturpr,retj_amount,retj_taxamount,retj_istax,retj_cn,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quot(edtNomorfaktur.Text)+','
             + Quotd(dtTanggal.Date) + ','
             + Quot(cxLookupGudang.EditValue)+','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupcustomer.EditValue) + ','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + IntToStr(aistax)+  ','
             +floattostr(cStrToFloat(edtcn.Text))+','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from tretj_dtl '
      + ' where  retjd_retj_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
   begin
    S:='insert into tretj_dtl (retjd_retj_nomor,retjd_brg_kode,retjd_brg_satuan,retjd_qty,retjd_discpr,retjd_harga,retjd_nourut,retjd_expired) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('DISC').AsFloat))+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('harga').AsFloat))+','
      + IntToStr(i)  +','
      + QuotD(CDS.FieldByName('expired').AsDateTime)
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


function TfrmReturJual.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
     If cxLookupcustomer.EditValue = '' then
    begin
      ShowMessage('customer belum di pilih');
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

procedure TfrmReturJual.edtNomorfakturClickBtn(Sender: TObject);
var
    SQLbantuan :string;
    aispajak : integer;
begin
 sqlbantuan := ' SELECT fp_NOMOR Nomor,fp_cus_kode Kode,cus_NAMA customer,fp_TANGGAL Tanggal,fp_amount Total from tfp_HDR inner join '
            + ' tcustomer on cus_kode=fp_cus_kode where fp_isbayar=0';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin

    aispajak := getpajak(varglobal);
    if FLAGEDIT  then
    begin
      if (aispajak =1) and (not chkPajak.Checked) then
      begin
          ShowMessage('Nomor yang di edit nomor bukan pajak tidak bisa di pakai nomor kena pajak');
          Exit
      end;
      if (aispajak =0) and (chkPajak.Checked) then
      begin
          ShowMessage('Nomor yang di edit nomor pajak tidak bisa di pakai nomor tidak kena pajak');
          Exit
      end;
    end;

    edtNomorfaktur.Text := varglobal;
    cxLookupcustomer.EditValue := varglobal1;

    if aispajak =1 then
       chkPajak.Checked := True
    else
       chkPajak.Checked := false;
   edtNomor.Text := getmaxkode(aispajak);
//   showmessage(edtnomor.text);
  end;

end;

procedure TfrmReturJual.bantuansku;
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku, fpd_expired Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode '
  + ' inner join tfp_dtl on fpd_brg_kode =brg_kode and fpd_fp_nomor = '+ quot(edtNomorfaktur.text)
  + ' and fpd_qty > 0 '
  + ' group by brg_kode , brg_nama , brg_satuan  ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
     for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = StrToInt(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
      then
      begin

        ShowMessage('Sku ada yang sama dengan baris '+ IntToStr(i+1));
        CDS.Cancel;
        exit;
      end;
    end;
       If CDS.State <> dsEdit then
           CDS.Edit;

      CDS.FieldByName('sku').AsInteger := StrToInt(varglobal);


  s:='select brg_kode Sku, brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok,fpd_harga,fpd_discpr from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode '
  + ' inner join tfp_dtl on mst_brg_kode=fpd_brg_kode and fpd_fp_nomor = '+ quot(edtNomorfaktur.text)
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
  + ' group by brg_kode , brg_nama , brg_satuan ';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
          CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
          CDS.FieldByName('HARGA').AsFloat := Fields[4].AsFloat;
          CDS.FieldByName('disc').AsFloat := Fields[5].AsFloat;


        end
        else
          bantuansku;
        finally
          free;
      end;
    end;
  end;
end;




procedure TfrmReturJual.loaddataall(akode : string);
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
  s := ' select retj_NOMOr,retj_tanggal,fp_nomor,retj_memo,fp_cus_kode,retj_istax,'
     + ' retjd_brg_kode,retjd_bRG_satuan,retjd_qty,retjd_harga,retjd_discpr,(retjd_qty*retjd_harga*(100-retjd_discpr)/100) nilai,'
     + ' retjd_expired,retj_disc_faktur,retj_disc_fakturpr,retj_cus_kode,retj_GDG_KODE , brg_nama'
     + ' from tretj_hdr inner join tfp_hdr on fp_nomor =retj_fp_nomor '
     + ' inner join tretj_dtl on retjd_retj_nomor=retj_nomor'
     + ' inner join tbarang on brg_kode=retjd_brg_kode '
     + ' where retj_nomor = '+ Quot(akode)
     + ' order by retjd_nourut ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            apajak :=fieldbyname('retj_istax').AsInteger;
            if apajak =1 then
               chkPajak.Checked := True
            else
               chkPajak.Checked := False;
            FID :=fieldbyname('retj_nomor').AsString;
            edtnomor.Text := fieldbyname('retj_nomor').AsString;
            edtNomorfaktur.Text   := fieldbyname('fp_nomor').AsString;
            dttanggal.DateTime := fieldbyname('retj_tanggal').AsDateTime;
            atanggalold := fieldbyname('retj_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('retj_memo').AsString;
            cxLookupcustomer.EditValue  := fieldbyname('retj_cus_kode').AsString;
            cxLookupGudang.EditValue :=fieldbyname('retj_gdg_kode').AsString;
            edtDiscpr.Text :=fieldbyname('retj_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('retj_disc_faktur').AsString;

            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;


                     CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('retjd_brg_kode').AsInteger;
                      CDS.FieldByName('NamaBarang').AsString      := fieldbyname('brg_nama').Asstring;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('retjd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('retjd_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('retjd_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('retjd_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('retjd_expired').AsDateTime;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
           hitung;

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

procedure TfrmReturJual.hitung;
var
  asubtotal : Double;
  adisc:Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
  edtDiscFaktur.Text := FloatToStr((cStrToFloat(edtDiscpr.text)/100*asubtotal)+cStrToFloat(edtDisc.text)) ;
  asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
  if chkPajak.Checked then
  begin
    edtTotal.Text :=FloatToStr(asubtotal*getangkappn(dtTanggal.DateTime));
    edtPPN.Text := FloatToStr(asubtotal *getangkappn2(dtTanggal.DateTime));
    edtCN.Text := FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('NilaiCN'))*getangkappn(dtTanggal.DateTime));
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal);
    edtPPN.Text := '0';
   edtCN.Text := FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('NilaiCN')));
  end;

end;


procedure TfrmReturJual.edtDiscprExit(Sender: TObject);
begin
if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmReturJual.edtDiscExit(Sender: TObject);
begin
if edtDisc.Text = '' then
    edtDisc.Text :='0';
hitung;
end;

procedure TfrmReturJual.clDiscPropertiesChange(Sender: TObject);
var
  i:integer;
  lVal: Double;
begin
 cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index]*(cvartofloat(cxGrdMain.DataController.Values[i,cldisc.Index])/100);
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] * cxGrdMain.DataController.Values[i, clHarga.Index] - lVal;

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Total').AsFloat := lVal;
  CDS.FieldByName('NilaiCN').AsFloat := CDS.FieldByName('CN').AsFloat /100 * lVal;
  CDS.Post;
  hitung;
end;

procedure TfrmReturJual.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
  bantuansku;
end;

procedure TfrmReturJual.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  bantuansku;
end;

procedure TfrmReturJual.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  aqtyfaktur:integer;
  s:string;
  tsql:TMyQuery;
  i:integer;
begin
  aqtyfaktur := 0;
  i:=cxGrdMain.DataController.FocusedRecordIndex;
    s:='select sum(fpd_qty) from tfp_dtl where fpd_fp_nomor ='+quot(edtNomorfaktur.Text)
    + ' and fpd_brg_kode = ' + quot(cxGrdMain.DataController.Values[i, clSKU.Index]);
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not eof then
        aqtyfaktur := Fields[0].AsInteger;
      finally
        free;
      end;
    end;
    if cVarToInt(DisplayValue) > aqtyfaktur then
    begin
      error := true;
        ErrorText :='Qty melebihi qty faktur';
        exit;
    end;

end;

procedure TfrmReturJual.chkCNClick(Sender: TObject);
var
  s:string;
    tsql :TMyQuery ;
  acn : Double;
  apotong : double;

begin
 if chkCN.Checked then
 begin
  s:='select cn_potong_invoice from tpiutangcn '
   + ' where cn_cus_kode =' + Quot(cxLookupCustomer.EditValue)
   + ' and cn_startdate <= ' + QuotD(dtTanggal.Date)
   + ' and cn_enddate >= ' + QuotD(dtTanggal.Date);
 tsql := xOpenQuery(s,frmMenu.conn);
 with tsql do
 begin
   try
     if not Eof then
     begin
       apotong:=fields[0].asfloat;
    end;
   finally
     free;
   end;
 end;
 if chkPajak.Checked then
 edtCN.Text := FloatToStr(apotong/100*(cStrToFloat(edtTotal.Text)/getangkappn(dtTanggal.DateTime)))
 else
 edtCN.Text := FloatToStr(apotong/100*(cStrToFloat(edtTotal.Text)));

 end
 else
 edtCN.Text := '0';



end;


procedure TfrmReturJual.doslipRet(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'RETJ';

          s:= ' select '
       + ' *,if(retjd_nourut is null ,1000,retjd_nourut) nourut ,terbilang(retj_amount) terbilang '
       + ' from tretj_hdr '
       + ' inner join tampung on nomor=retj_nomor '
       + ' inner join tcustomer on retj_cus_kode=cus_kode '
       + ' left join  tretj_dtl on retj_nomor=retjd_retj_nomor and tam_nama = retjd_brg_kode and expired=retjd_expired '
       + ' left join tbarang on retjd_brg_kode=brg_kode '
       + ' where '
       + ' retj_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmReturjUAL.insertketampungan(anomor:string);
var
  s:string;
  tsql : TMyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=9;
  s:='delete from tampung ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  s := 'select retjd_brg_kode,retjd_expired from tretj_dtl where retjd_retj_nomor =' + Quot(anomor) ;
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
                  + QuotD(Fields[1].AsDateTime)
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


procedure TfrmReturjUAL.doslip2(anomor : string );
var
  s: string ;
  tsql2,tsql : TMyQuery;
  abaris,i,a:Integer;
  anamabarang,TERBILANG : String;
  anilaipiutang:double;
  adiscfaktur,atotal,anilai,appn : Double;

begin
    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := getbarisslip('RETJ');
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
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' R E T U R   P E N J U A L A N ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
      memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
    finally
      Free;
    end;
  end;

      s:= ' select '
       + ' *,if(retjd_nourut is null ,1000,retjd_nourut) nourut ,terbilang(retj_amount) terbilang ,'
       + ' ((retj_amount-retj_taxamount)+retj_disc_faktur)/(100-retj_disc_fakturpr)*100 nett '
       + ' from tretj_hdr '
       + ' inner join tFP_hdr on FP_nomor=retj_FP_nomor'
       + ' inner join tcustomer on fp_cus_kode=cus_kode '
       + ' left join tdo_hdr on fp_do_nomor=do_nomor '
       + ' left join tso_hdr on so_nomor=do_so_nomor '
       + ' left join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tretj_dtl on retj_nomor=retjd_retj_nomor '
       + ' left join tbarang on retjd_brg_kode=brg_kode '
       + ' where '
       + ' retj_nomor=' + quot(anomor)
       + ' order by nourut';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try

    if not Eof then
    begin
      TERBILANG := fieldbyname('terbilang').AsString;
          anilai := fieldbyname('retj_amount').AsFloat-fieldbyname('retj_taxamount').AsFloat;
          appn := fieldbyname('retj_taxamount').AsFloat;
          atotal := fieldbyname('retj_amount').AsFloat;

          adiscfaktur :=  ((fieldbyname('retj_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('retj_disc_faktur').asfloat;
      memo.Lines.Add(StrPadRight('Nomor       : '+fieldbyname('retj_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal     : '+FormatDateTime('dd/mm/yyyy',fieldbyname('retj_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Atas Faktur : '+fieldbyname('fp_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 60, ' '));

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
                          +StrPadRight(fieldbyname('retjd_brg_kode').AsString, 12, ' ')+' '
                          +StrPadRight(anamabarang, 40, ' ')+' '
                          +StrPadRight(fieldbyname('retjd_brg_satuan').AsString, 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###',fieldbyname('retjd_qty').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###',fieldbyname('retjd_discpr').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('#,###,###',fieldbyname('retjd_harga').Asfloat), 14, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###,###',(100-fieldbyname('retjd_discpr').Asfloat)/100*fieldbyname('retjd_harga').Asfloat*fieldbyname('retjd_qty').Asfloat), 15, ' ')+' '
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
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' R E T U R   P E N J U A L A N ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString, 120, ' '));
                memo.Lines.Add(StrPadRight(Fields[3].AsString, 120, ' '));
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));

            memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('retj_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('retj_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
            memo.Lines.Add(StrPadRight('Atas Faktur : '+fieldbyname('fp_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 60, ' '));

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
                          + StrPadLeft( FormatFloat('##,###,###',adiscfaktur), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
                          +StrPadRight('Total         :', 15, ' ')+ ' '
                           + StrPadLeft( FormatFloat('##,###,###',anilai), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',161,240), 81, ' ')+' '
                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###',appn), 21, ' ')+ ' '
                          );
     memo.Lines.Add(      StrPadRight('', 20, ' ')+' '
                          +StrPadRight('Dibuat oleh,', 30, ' ')+' '
                          +StrPadRight('Mengetahui,', 30, ' ')

                          +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###',atotal), 21, ' ')+ ' '
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
//                          + StrPadLeft( FormatFloat('##,###,###',adp), 21, ' ')+ ' '
//                          );

//    memo.Lines.Add(
//                          );


    memo.Lines.Add('');
    memo.Lines.Add(  StrPadRight('', 21, ' ')
                          +StrPadRight('(               )', 30, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')
                          );

    memo.Lines.Add('');
  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;


function TfrmReturjual.getpajak(anomor : string): Integer;
var
  S: string;
  tsql : TMyQuery ;
begin
//  result := 0;
   s:= 'select fp_istax from tfp_hdr where fp_nomor ='+ Quot(anomor);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try
     with tsql do
     begin
       Result := fields[0].asinteger;
     end;
   finally
     tsql.Free;
   end;
end;

function TfrmReturJual.cekfaktur(anomor:string):Boolean;
var
 tsql:TMyQuery;
 s:string;
begin
  result:=False;
  s:= 'select * from tretj_hdr where retj_fp_nomor ='+ Quot(anomor) ;
  tsql :=xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      if not Eof then
         Result := True;
    finally
      Free;
    end;
  end;
end;



procedure TfrmReturJual.edtNomorfakturExit(Sender: TObject);
begin
       if not flagedit and cekfaktur(edtnomorfaktur.Text) then
     begin
       ShowMessage('Faktur ini sudah pernah di retur');
       exit;
     end;
end;

procedure TfrmReturJual.HapusRecord1Click(Sender: TObject);
begin
   If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
           hitung;
end;

end.
