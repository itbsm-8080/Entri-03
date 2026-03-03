unit ufrmFakturPajak;

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
  cxCalendar, cxCheckBox, cxButtonEdit, frxClass, frxExportPDF, MyAccess;

type
  TfrmFakturPajak = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomordo: TAdvEdit;
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
    dtTglJT: TDateTimePicker;
    edtNomor: TAdvEditBtn;
    chkPajak: TCheckBox;
    edtDiscpr: TAdvEdit;
    edtDisc: TAdvEdit;
    edtPPN: TAdvEdit;
    edtTotal: TAdvEdit;
    edtDiscFaktur: TAdvEdit;
    clHarga: TcxGridDBColumn;
    clDisc: TcxGridDBColumn;
    clKurang: TcxGridDBColumn;
    edtDP: TAdvEdit;
    edtCN: TAdvEdit;
    chkDP: TCheckBox;
    chkCN: TCheckBox;
    clCN: TcxGridDBColumn;
    clNilaiCN: TcxGridDBColumn;
    cxButton3: TcxButton;
    Label15: TLabel;
    edtFreight: TAdvEdit;
    clgudang: TcxGridDBColumn;
    Label16: TLabel;
    edtPajak: TAdvEdit;
    Label17: TLabel;
    dtTanggalPajak: TDateTimePicker;
    chkManual: TCheckBox;
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
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);

    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataDO(akode : string);
    procedure loaddataall(akode : string);
    procedure hitung;
    procedure initViewSKU;

    procedure edtNomorClickBtn(Sender: TObject);
    procedure edtDiscprExit(Sender: TObject);
    procedure edtDiscExit(Sender: TObject);
    procedure clDiscPropertiesChange(Sender: TObject);
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure chkDPClick(Sender: TObject);
    procedure chkCNClick(Sender: TObject);
    procedure clHargaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure doslip(anomor : string );
    procedure insertketampungan(anomor:string);
    procedure doslip2(anomor : string );
    procedure cxButton3Click(Sender: TObject);
    function gettop(akode:String):integer;
  private
    FCDScustomer: TClientDataset;
    FCDSSKU : TClientDataset;

    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    function GetCDScustomer: TClientDataset;




    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;

    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmFakturPajak: TfrmFakturPajak;
const
   NOMERATOR = 'FP';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmcetak;

{$R *.dfm}

procedure TfrmFakturPajak.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtNomorDO.Clear;
  dtTglJT.DateTime := Date;
  chkPajak.Checked := true;
  edtTotal.Text := '0.00';
  edtPPN.Text := '0.00';
  edtFreight.Text := '0.00';
  edtCN.Text := '0.00';
  edtDP.Text := '0.00';
  edtnomor.Text := getmaxkode(1);
  cxLookupcustomer.EditValue := '';
  edtAlamat.Clear;
  edtnomor.clear;
  edtmemo.Clear;
  edtNomor.SetFocus;
  initgrid;

end;
procedure TfrmFakturPajak.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmFakturPajak.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmFakturPajak.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmFakturPajak.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(fp_nomor,4)) from tfp_hdr '
  + ' where fp_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and fp_istax=1 ';
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
  s:='select max(right(fp_nomor,3)) from tfp_hdr '
  + ' where fp_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and fp_istax=0 ';

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

procedure TfrmFakturPajak.cxButton1Click(Sender: TObject);
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

procedure TfrmFakturPajak.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmFakturPajak.cxButton2Click(Sender: TObject);
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

procedure TfrmFakturPajak.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;



     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmFakturPajak.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'Namabarang', ftString, False, 30);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Harga', ftFloat, False);
    zAddField(FCDS, 'Disc', ftFloat, False);
    zAddField(FCDS, 'Total', ftFloat, False);
    zAddField(FCDS, 'expired', ftDate, False, 255);
    zAddField(FCDS, 'kurang', ftFloat, False);
    zAddField(FCDS, 'CN', ftFloat, False);
    zAddField(FCDS, 'NilaiCN', ftFloat, False);
    zAddField(FCDS, 'Gudang', ftString, False,255);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmFakturPajak.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_telp'
        +' from tcustomer order by cus_nama';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;

procedure TfrmFakturPajak.FormShow(Sender: TObject);
begin
refreshdata;
dtTanggalPajak.DateTime :=date;
end;

procedure TfrmFakturPajak.cxLookupcustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDScustomer.Fields[2].AsString;

end;

procedure TfrmFakturPajak.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmFakturPajak.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
  CDS.FieldByName('NAMABARANG').AsString := CDSSKU.Fields[1].Asstring;
 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;

end;

procedure TfrmFakturPajak.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmFakturPajak.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
begin
   anomorold := edtNomor.Text;
  edtNomor.Text := getmaxkode(apajak);
  if FLAGEDIT then
  begin
    if edtNomor.Text <> anomorold then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.date := Date;

    end;
  end;
  dtTglJT.DateTime :=  dtTanggal.DateTime+getTop(cxLookupCustomer.EditValue);
end;


procedure TfrmFakturPajak.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aismanual,aistax : integer;
begin
  if chkManual.Checked then
    aismanual :=  1
  else
    aismanual := 0;

  if chkPajak.Checked then
    aistax :=  1
  else
    aistax := 0;
  s:='delete from Tfakturpajak_HDR  '
    + ' where fp_nomor = ' + quot(edtnomor.text) + ';';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  s :=  ' insert into Tfakturpajak_HDR '
             + ' (fp_nomor,fp_do_nomor,fp_tanggal,fp_jthtempo,fp_memo,fp_fakturpajak,fp_tanggalpajak,fp_cus_kode,fp_disc_faktur,'
             + ' fp_disc_fakturpr,fp_amount,fp_taxamount,fp_istax,ismanual,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quot(edtNomorDO.Text)+','
             + Quotd(dtTanggal.Date) + ','
             + quotd(dttGLjt.datetime)+','
             + Quot(edtmemo.Text)+','
             + Quot(edtPajak.Text) + ','
             + quotd(dtTanggalPajak.DateTime)+','
             + Quot(cxLookupcustomer.EditValue) + ','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + IntToStr(aistax)+  ','
             + IntToStr(aismanual)+  ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';

  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from tfakturpajak_dtl '
      + ' where  fpd_fp_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin

    S:='insert into tfakturpajak_dtl (fpd_fp_nomor,fpd_brg_kode,fpd_brg_nama,fpd_brg_satuan,fpd_qty,fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_kode) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('NamaBarang').AsString) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('DISC').AsFloat))+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('harga').AsFloat))+','
      + IntToStr(i)  +','
      + QuotD(CDS.FieldByName('expired').AsDateTime)+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('cn').AsFloat))+','
      + Quot(CDS.FieldByName('gudang').AsString)
      + ');';
    tt.Append(s);

    CDS.Next;
    Inc(i);
  end;
      tt.SaveToFile('ss.txt');
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


function TfrmFakturPajak.cekdata:Boolean;
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

procedure TfrmFakturPajak.loaddataDO(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin


  s := ' select do_nomor,do_tanggal,so_cus_kode,so_istax,cus_top,'
     + ' so_DISC_faktur,so_disc_fakturpr,so_istax,sod_keterangan,'
     + ' dod_brg_kode,dod_bRG_satuan,(dod_qty-dod_qty_invoice) dod_qty,dod_tgl_expired expired,'
     + ' sod_harga,sod_discpr,((dod_qty-dod_qty_invoice)*sod_harga*(100-sod_discpr)/100) nilai,dod_gdg_kode'
     + ' from tdo_hdr inner join tso_hdr a on do_so_nomor = so_nomor'
     + ' inner join tdo_dtl on dod_do_nomor = do_nomor '
     + ' inner join tcustomer on cus_kode =so_cus_kode '
     + ' LEFT join tso_dtl d on a.so_nomor=d.sod_so_nomor  and dod_brg_kode = sod_brg_kode  '
     + ' where do_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin

            edtNomorDO.Text   := fieldbyname('do_nomor').AsString;
            apajak := fieldbyname('so_istax').AsInteger;
            if apajak = 1 then
               chkpajak.Checked := True
            else
               chkpajak.Checked := false;

            edtNomor.Text := getmaxkode(apajak);
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
            edtDiscpr.Text := fieldbyname('so_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('so_disc_faktur').AsString;
            dtTglJT.DateTime := dtTanggal.DateTime+fieldbyname('cus_top').AsInteger;
            i:=1;
            initViewSKU;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('dod_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('dod_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('dod_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('sod_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('sod_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('expired').AsDateTime;
                      CDS.FieldByName('kurang').AsFloat        := fieldbyname('dod_qty').AsFloat;
                      CDS.FieldByName('gudang').AsString      :=  fieldbyname('dod_gdg_kode').AsString;
                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
            hitung;
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

procedure TfrmFakturPajak.edtNomorClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
  if chkManual.Checked = False then
 sqlbantuan := ' SELECT fp_NOMOR Nomor,fp_TANGGAL Tanggal,cus_NAMA customer from tfp_HDR '
            + ' inner join tcustomer on cus_kode=fp_cus_kode '
 else
 sqlbantuan := ' SELECT fp_NOMOR Nomor,fp_TANGGAL Tanggal,cus_NAMA customer from tfp_HDR_bayangan '
            + ' inner join tcustomer on cus_kode=fp_cus_kode ';

 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtNomor.Text := varglobal;
  loaddataall(edtNomor.Text);
end;



procedure TfrmFakturPajak.loaddataall(akode : string);
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
  if chkmanual.checked = False then
  s := ' select fp_NOMOr,fp_tanggal,do_nomor,fp_memo,so_cus_kode,fp_istax,fp_jthtempo,FP_CN,FP_DP,'
     + ' fpd_brg_kode,fpd_bRG_satuan,fpd_qty,fpd_harga,fpd_discpr,(fpd_qty*fpd_harga*(100-fpd_discpr)/100) nilai,'
     + ' fpd_expired,fp_disc_faktur,fp_disc_fakturpr,dod_qty-dod_qty_invoice kurang,fpd_cn,fp_freight,fpd_gdg_kode,brg_nama fpd_brg_nama'
     + ' from tfp_hdr inner join tdo_hdr on do_nomor =fp_do_nomor '
     + ' left join tso_hdr a on do_so_nomor=so_nomor'
     + ' left join tfp_dtl on fpd_fp_nomor=fp_nomor'
     + ' left join tdo_dtl on dod_brg_kode=fpd_brg_kode and dod_do_nomor=fp_do_nomor and dod_tgl_expired=fpd_expired and fpd_gdg_kode=dod_gdg_kode'
     + ' left join tbarang on brg_kode=fpd_brg_kode '
     + ' where fp_nomor = '+ Quot(akode)
     + ' order by fpd_nourut '
  else
    s := ' select fp_NOMOr,fp_tanggal,do_nomor,fp_memo,so_cus_kode,fp_istax,fp_jthtempo,FP_CN,FP_DP,'
     + ' fpd_brg_kode,fpd_bRG_satuan,fpd_qty,fpd_harga,fpd_discpr,(fpd_qty*fpd_harga*(100-fpd_discpr)/100) nilai,'
     + ' fpd_expired,fp_disc_faktur,fp_disc_fakturpr,dod_qty-dod_qty_invoice kurang,fpd_cn,fp_freight,fpd_gdg_kode,FPD_BRG_NAMA'
     + ' from tfp_hdr_bayangan inner join tdo_hdr on do_nomor =fp_do_nomor '
     + ' left join tso_hdr a on do_so_nomor=so_nomor'
     + ' left join tfp_dtl_bayangan on fpd_fp_nomor=fp_nomor'
     + ' left join tdo_dtl on dod_brg_kode=fpd_brg_kode and dod_do_nomor=fp_do_nomor and dod_tgl_expired=fpd_expired and fpd_gdg_kode=dod_gdg_kode'
     + ' where fp_nomor = '+ Quot(akode)
     + ' order by fpd_nourut ';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            apajak :=fieldbyname('fp_istax').AsInteger;
            if apajak =1 then
               chkPajak.Checked := True
            else
               chkPajak.Checked := False;
            FID :=fieldbyname('fp_nomor').AsString;
            edtnomor.Text := fieldbyname('fp_nomor').AsString;
            edtNomorDO.Text   := fieldbyname('do_nomor').AsString;
            dttanggal.DateTime := fieldbyname('fp_tanggal').AsDateTime;
            dtTglJT.DateTime  :=  fieldbyname('fp_jthtempo').AsDateTime;
            edtmemo.Text := fieldbyname('fp_memo').AsString;
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
//            edtDiscpr.Text :=0;
//            edtDisc.Text :=  '0;
            edtFreight.Text := fieldbyname('fp_freight').AsString;

            edtPajak.Text := getnama('tfakturpajak_hdr','fp_nomor',fieldbyname('fp_nomor').AsString,'fp_fakturpajak');
            if FieldByName('fp_dp').AsFloat > 0 then
            begin
              chkDP.Checked := True;
              edtDP.Text := FloatToStr(FieldByName('fp_dp').AsFloat);
            end;
            if FieldByName('fp_cn').AsFloat > 0 then
            begin
              chkCN.Checked := True;
              edtCN.Text := FloatToStr(FieldByName('fp_cn').AsFloat);
            end;

            initViewSKU;
            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;


                     CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('fpd_brg_kode').AsInteger;
                      CDS.FieldByName('namabarang').AsString      := fieldbyname('fpd_brg_nama').Asstring;
//                      CDS.FieldByName('namabarang').AsString      := fieldbyname('brg_nama').Asstring;

                      CDS.FieldByName('satuan').AsString      := fieldbyname('fpd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('fpd_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('fpd_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('fpd_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('fpd_expired').AsDateTime;
                      CDS.FieldByName('kurang').asfloat      := fieldbyname('kurang').asfloat+fieldbyname('fpd_qty').asfloat;
                      CDS.fieldbyname('cn').asfloat           := fieldbyname('fpd_cn').AsFloat;
                      CDS.fieldbyname('nilaicn').asfloat           := fieldbyname('fpd_cn').AsFloat*fieldbyname('nilai').AsFloat/100;
                      CDS.FieldByName('gudang').AsString      := fieldbyname('fpd_gdg_kode').Asstring;

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

procedure TfrmFakturPajak.hitung;
var
  asubtotal : Double;
  adisc:Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
  edtDiscFaktur.Text := FloatToStr((cStrToFloat(edtDiscpr.text)/100*asubtotal)+cStrToFloat(edtDisc.text)) ;
  asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
  if chkPajak.Checked then
  begin
    edtTotal.Text :=FloatToStr((asubtotal*getangkappn(dtTanggal.DateTime))+cStrToFloat(edtFreight.text));
    edtPPN.Text := FloatToStr(asubtotal *getangkappn2(dtTanggal.DateTime));
    edtCN.Text := FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('NilaiCN')));
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal+cStrToFloat(edtFreight.text));
    edtPPN.Text := '0';
    edtCN.Text := FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('NilaiCN')));
  end;


end;


procedure TfrmFakturPajak.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan from Tbarang '
  + ' inner join tdo_dtl on dod_brg_kode=brg_kode and dod_do_nomor =' + Quot(edtNomorDO.Text);


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

//  with TcxExtLookupHelper(clNamaBarang.Properties) do
//    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);


end;

procedure TfrmFakturPajak.edtDiscprExit(Sender: TObject);
begin
if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmFakturPajak.edtDiscExit(Sender: TObject);
begin
if edtDisc.Text = '' then
    edtDisc.Text :='0';
hitung;
end;

procedure TfrmFakturPajak.clDiscPropertiesChange(Sender: TObject);
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

procedure TfrmFakturPajak.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  i:integer;
  aqtykurang,aqtylain:integer;
begin
  aqtykurang :=cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clKurang.Index]);

    if cVarToInt(DisplayValue) > aqtykurang then
    begin
      error := true;
        ErrorText :='Qty melebihi qty kurang';
        exit;
    end;

end;
procedure TfrmFakturPajak.chkDPClick(Sender: TObject);
var
  s:string;
  tsql :TMyQuery ;
  adp,ainvdp :double;
  anomorso :string;
begin
  anomorso:='';
  adp := 0;
 if chkDP.Checked then
 begin
  s:='select so_nomor,so_dp from tso_hdr inner join tdo_hdr on so_nomor=do_so_nomor '
   + ' where do_nomor =' + Quot(edtNomorDO.Text) ;
 tsql := xOpenQuery(s,frmMenu.conn);
 with tsql do
 begin
   try
     if not Eof then
     begin
       adp :=fields[1].asfloat;
       anomorso :=fields[0].asstring;
    end;
   finally
     free;
   end;
 end;
  s:='select sum(fp_dp) from tfp_hdr inner join tdo_hdr on fp_do_nomor=do_nomor '
    + ' inner join tso_hdr on so_nomor=do_so_nomor '
    + ' where so_nomor =' + Quot(anomorso)
    + ' AND fp_nomor <> ' + Quot(edtNomor.Text);
 tsql := xOpenQuery(s,frmMenu.conn);
 with tsql do
 begin
   try
     if not Eof then
       ainvdp :=fields[0].asfloat;
   finally
     free;
   end;
 end;
 edtDP.Text := FloatToStr(adp-ainvdp);
 end
 else
 edtDP.Text := '0';


end;

procedure TfrmFakturPajak.chkCNClick(Sender: TObject);
var
  s:string;
  tsql :TMyQuery ;
  acn : Double;
  apotong : double;

begin
 IF cStrToFloat(edtCN.Text) > 0 then
 begin
   ShowMessage('CN ini menggunakan metode per ITem');
   chkCN.Checked := False;
   Exit;
 end;
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

procedure TfrmFakturPajak.clHargaPropertiesButtonClick(Sender: TObject;
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
      clDiscPropertiesChange(self);
   end;


end;

procedure TfrmFakturPajak.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'FP';

          s:= ' select '
       + ' *,(((fp_amount-fp_freight)-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 net,'
       + ' if(fpd_nourut is null ,1000,fpd_nourut) nourut '
       + ' from tfp_hdr '
       + ' inner join tampung on nomor=fp_nomor '
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on so_cus_kode=cus_kode '
       + ' inner join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tfp_dtl on fp_nomor=fpd_fp_nomor and tam_nama = fpd_brg_kode and fpd_expired=expired'
       + ' left join tbarang on fpd_brg_kode=brg_kode '
       + ' where '
       + ' fp_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmFakturPajak.insertketampungan(anomor:string);
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
  s := 'select fpd_brg_kode,fpd_expired from tfp_dtl where fpd_fp_nomor =' + Quot(anomor) ;
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
                  + Quotd(Fields[1].AsDateTime)
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


procedure TfrmFakturPajak.doslip2(anomor : string );
var
  s: string ;
  tsql2,tsql : TMyQuery;
  abaris,i,a:Integer;
  anamabarang,TERBILANG : String;
  anilaipiutang:double;
  afreight,adiscfaktur,adp,atotal,anilai,appn : Double;

begin
    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := getbarisslip('FP');
 with frmCetak do
 begin
    memo.Clear;
      memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp '
      + ' from tperusahaan ';

  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
    try
      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
      memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 120, ' '));

    finally
      Free;
    end;
  end;

      s:= ' select '
       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(fp_amount) terbilang ,'
       + ' ((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett '
       + ' from tfp_hdr '
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on so_cus_kode=cus_kode '
       + ' inner join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tfp_dtl on fp_nomor=fpd_fp_nomor '
       + ' left join tbarang on fpd_brg_kode=brg_kode '
       + ' where '
       + ' fp_nomor=' + quot(anomor)
       + ' order by nourut';

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try

    if not Eof then
    begin
      TERBILANG := fieldbyname('terbilang').AsString;
          anilai := fieldbyname('FP_amount').AsFloat-fieldbyname('FP_taxamount').AsFloat;
          appn := fieldbyname('FP_taxamount').AsFloat;
          atotal := fieldbyname('FP_amount').AsFloat;
          afreight := fieldbyname('FP_freight').AsFloat;
          adp :=fieldbyname('FP_dp').AsFloat;
          adiscfaktur :=  ((fieldbyname('FP_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('FP_disc_faktur').asfloat;
      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 30, ' ')+' ' + StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 28, ' '));

      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 8, ' ')+' '
                          +StrPadRight('Nama', 44, ' ')+' '
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
         if strtoint(formatdatetime('yyyy',fieldbyname('fpd_expired').AsDateTime)) > 2000 then
         anamabarang :=FieldByName('brg_nama').AsString + ' / '+FormatDateTime('mm.yyyy',fieldbyname('fpd_expired').AsDateTime)
         else
         anamabarang :=FieldByName('brg_nama').AsString;

       i:=i+1;
       memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
                          +StrPadRight(fieldbyname('fpd_brg_kode').AsString, 8, ' ')+' '
                          +StrPadRight(anamabarang, 44, ' ')+' '
                          +StrPadRight(fieldbyname('fpd_brg_satuan').AsString, 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###',fieldbyname('fpd_qty').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('fpd_discpr').Asfloat), 10, ' ')+' '
                          +StrPadLeft(FormatFloat('#,###,###.##',fieldbyname('fpd_harga').Asfloat), 14, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###,###.##',(100-fieldbyname('fpd_discpr').Asfloat)/100*fieldbyname('fpd_harga').Asfloat*fieldbyname('fpd_qty').Asfloat), 15, ' ')+' '
                          );
       Next;
       if (i mod abaris =0) and (not eof) then
       begin
         memo.Lines.Add(StrPadRight('', 120, '-'));
            for a:=1 to 10 do
            begin
              memo.Lines.Add('');
            end;
           s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp '
          + ' from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
                memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 120, ' '));
                memo.Lines.Add('');
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));

      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 60, ' '));

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
     memo.Lines.Add(      StrPadRight('  Disiapkan', 25, ' ')+' '
                          +StrPadRight(' Disetujui,', 25, ' ')+' '
                          +StrPadRight(' Penerima,', 30, ' ')

                          +StrPadRight('Freight      :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' ')+ ' '
                          );
//
//                          anilaipiutang :=atotal-
//                          StrToFloat(StringReplace(getdebet(anomor),',','',[rfReplaceAll]));
//      memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('DP        :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('###,###,###',ADP), 21, ' ')+ ' '
//                          );
     memo.Lines.Add(      StrPadRight('', 81, ' ')+' '
                          +StrPadRight('Grand Total  :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' ')+ ' '
                          );

//    memo.Lines.Add(
//                          );


    memo.Lines.Add('');
          memo.Lines.Add(  StrPadRight('(               )', 25, ' ')
                          +StrPadRight('(               )', 25, ' ')+' '
                          +StrPadRight('(               )', 30, ' ')
                          );
       memo.Lines.Add('');

    nomor :=anomor;

  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;

procedure TfrmFakturPajak.cxButton3Click(Sender: TObject);
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

function TfrmFakturPajak.gettop(akode:String):integer;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select cus_top from tcustomer where cus_kode='+ Quot(akode) ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if not Eof then
       result := fields[0].asinteger;
   finally
     Free;
   end;
  end;
end;


end.
