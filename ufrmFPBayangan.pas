unit ufrmFPBayangan;

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
  TfrmFPBayangan = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
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
    edtNomorDO: TAdvEditBtn;
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
    edtNomor: TAdvEdit;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clIDBatch: TcxGridDBColumn;
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

    procedure edtNomorDOClickBtn(Sender: TObject);
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
    function cariNomor(anomor:string): Boolean;
    procedure HapusRecord1Click(Sender: TObject);
    procedure chkPajakClick(Sender: TObject);
    procedure doslip3(anomor : string );
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
  frmFPBayangan: TfrmFPBayangan;
const
   NOMERATOR = 'FP';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmcetak;

{$R *.dfm}

procedure TfrmFPBayangan.refreshdata;
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
  edtnomor.Text := frmMenu.KDCABANG+'.'+FormatDateTime('yymm.',dtTanggal.DateTime);
  cxLookupcustomer.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  edtNomorDO.SetFocus;
  initgrid;

end;
procedure TfrmFPBayangan.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmFPBayangan.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmFPBayangan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmFPBayangan.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(fp_nomor,4)) from tfp_hdr_bayangan '
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
  s:='select max(right(fp_nomor,3)) from tfp_hdr_bayangan '
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

procedure TfrmFPBayangan.cxButton1Click(Sender: TObject);
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

procedure TfrmFPBayangan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmFPBayangan.cxButton2Click(Sender: TObject);
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

procedure TfrmFPBayangan.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;



     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmFPBayangan.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Namabarang', ftString, False, 30);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'IDBatch', ftString, False, 50);
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

function TfrmFPBayangan.GetCDScustomer: TClientDataset;
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

procedure TfrmFPBayangan.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmFPBayangan.cxLookupcustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDScustomer.Fields[2].AsString;

end;

procedure TfrmFPBayangan.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmFPBayangan.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
  CDS.FieldByName('NAMABARANG').AsString := CDSSKU.Fields[1].Asstring;
 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;

end;

procedure TfrmFPBayangan.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmFPBayangan.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
begin
   anomorold := edtNomor.Text;
//  edtNomor.Text := getmaxkode(apajak);
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


procedure TfrmFPBayangan.simpandata;
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
begin
  s:='update tfp_hdr_bayangan set '
    + ' fp_cus_kode = ' + Quot(cxLookupcustomer.EditValue) + ','
    + ' fp_tanggal = ' + quotd(dtTanggal.DateTime) + ','
    + ' fp_do_nomor =' +Quot(edtNomorDO.Text)+','
    + ' fp_memo = ' + Quot(edtmemo.Text) + ','
    + ' fp_disc_faktur =' + floattostr(cStrToFloat(edtDisc.Text))+ ','
    + ' fp_disc_fakturpr = '+ floattostr(cStrToFloat(edtDiscpr.Text))+ ','
    + ' fp_freight = ' + FloatToStr(cStrToFloat(edtFreight.text)) + ','
    + ' fp_amount = '+ floattostr(cstrtoFloat(edtTotal.Text))+ ','
    + ' fp_taxamount = '+ floattostr(cStrToFloat(edtPPN.Text))+ ','
    + ' fp_istax = ' + IntToStr(aistax)+  ','
    + ' fp_jthtempo='+ quotd(dttGLjt.datetime)+','
    + ' fp_dp = ' + floattostr(cstrtoFloat(edtDP.Text))+ ','
    + ' fp_cn = ' + floattostr(cstrtoFloat(edtCN.Text))+ ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where fp_nomor = ' + quot(FID) + ';';
    edtNomor.text:=fid;
end
else
begin
//  if chkpajak.Checked then
//  edtNomor.Text := getmaxkode(1)
//  else
//  edtNomor.Text := getmaxkode(0);

  s :=  ' insert into tfp_hdr_bayangan '
             + ' (fp_nomor,fp_do_nomor,fp_tanggal,fp_jthtempo,fp_memo,fp_cus_kode,fp_disc_faktur,'
             + ' fp_disc_fakturpr,fp_amount,fp_taxamount,fp_freight,fp_istax,fp_dp,fp_cn,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quot(edtNomorDO.Text)+','
             + Quotd(dtTanggal.Date) + ','
             + quotd(dttGLjt.datetime)+','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupcustomer.EditValue) + ','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + FloatToStr(cStrToFloat(edtFreight.text))+','
             + IntToStr(aistax)+  ','
             + floattostr(cstrtoFloat(edtDP.Text))+ ','
             + floattostr(cstrtoFloat(edtCN.Text))+ ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from tfp_dtl_bayangan '
      + ' where  fpd_fp_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin

    S:='insert into tfp_dtl_bayangan (fpd_fp_nomor,fpd_brg_kode,fpd_brg_nama,fpd_brg_satuan,fpd_idbatch,'
    + ' fpd_qty,fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_kode) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('namabarang').AsString) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + Quot(CDS.FieldByName('idbatch').AsString) +','
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


function TfrmFPBayangan.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
//   if carinomor(edtNomor.Text) then
//   begin
//     ShowMessage('Nomor ini sudah di pakai');
//     Result:=False;
//   end;
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

procedure TfrmFPBayangan.loaddataDO(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin


  s := ' select do_nomor,do_tanggal,so_cus_kode,so_istax,cus_top,'
     + ' so_DISC_faktur,so_disc_fakturpr,so_istax,sod_keterangan,'
     + ' dod_brg_kode,dod_bRG_satuan, dod_qty,dod_tgl_expired expired,'
     + ' sod_harga,sod_discpr,(dod_qty*sod_harga*(100-sod_discpr)/100) nilai,dod_gdg_kode'
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

//            edtNomor.Text := getmaxkode(apajak);
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
                      CDS.FieldByName('namabarang').AsString      := getnama('tbarang','brg_KODE',fieldbyname('dod_brg_kode').Asstring,'brg_nama');
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

procedure TfrmFPBayangan.edtNomorDOClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT do_NOMOR Nomor,do_TANGGAL Tanggal,cus_NAMA customer from tdo_HDR '
            + ' inner join tcustomer on cus_kode=do_cus_kode ';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtNomorDO.Text := varglobal;
  loaddataDO(edtNomorDO.Text);
end;



procedure TfrmFPBayangan.loaddataall(akode : string);
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
  s := ' select fp_NOMOr,fp_tanggal,do_nomor,fp_memo,so_cus_kode,fp_istax,fp_jthtempo,FP_CN,FP_DP,'
     + ' fpd_brg_kode,FPD_BRG_NAMA,fpd_bRG_satuan,fpd_idbatch,fpd_qty,fpd_harga,fpd_discpr,(fpd_qty*fpd_harga*(100-fpd_discpr)/100) nilai,'
     + ' fpd_expired,fp_disc_faktur,fp_disc_fakturpr,dod_qty-dod_qty_invoice kurang,fpd_cn,fp_freight,fpd_gdg_kode '
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
            edtDiscpr.Text :=fieldbyname('fp_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('fp_disc_faktur').AsString;
            edtFreight.Text := fieldbyname('fp_freight').AsString;
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
                      CDS.FieldByName('satuan').AsString      := fieldbyname('fpd_brg_satuan').Asstring;
                      CDS.FieldByName('idbatch').AsString      := fieldbyname('fpd_idBatch').Asstring;

                      CDS.FieldByName('namabarang').AsString      := fieldbyname('fpd_brg_nama').Asstring;

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

procedure TfrmFPBayangan.hitung;
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


procedure TfrmFPBayangan.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan from Tbarang ';



  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;


end;

procedure TfrmFPBayangan.edtDiscprExit(Sender: TObject);
begin
if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmFPBayangan.edtDiscExit(Sender: TObject);
begin
if edtDisc.Text = '' then
    edtDisc.Text :='0';
hitung;
end;

procedure TfrmFPBayangan.clDiscPropertiesChange(Sender: TObject);
var
  i:integer;
  lVal: Double;
begin
 cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] *  cvartofloat(cxGrdMain.DataController.Values[i, clHarga.Index])*(cvartofloat(cxGrdMain.DataController.Values[i,cldisc.Index])/100);
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] * cvartofloat(cxGrdMain.DataController.Values[i, clHarga.Index]) - lVal;

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Total').AsFloat := lVal;
  CDS.FieldByName('NilaiCN').AsFloat := CDS.FieldByName('CN').AsFloat /100 * lVal;
  CDS.Post;
  hitung;
end;

procedure TfrmFPBayangan.clQTYPropertiesValidate(Sender: TObject;
   var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  i:integer;
  aqtykurang,aqtylain:integer;
begin
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

end;
procedure TfrmFPBayangan.chkDPClick(Sender: TObject);
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
  s:='select sum(fp_dp) from tfp_hdr_bayangan inner join tdo_hdr on fp_do_nomor=do_nomor '
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

procedure TfrmFPBayangan.chkCNClick(Sender: TObject);
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

procedure TfrmFPBayangan.clHargaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
           sqlbantuan := 'select brg_nama Nama,fpd_harga Harga,fpd_discpr Disc,fpd_expired Expired,'
                  + ' fp_tanggal Tanggal, fpd_qty Qty from '
                  + ' tfp_dtl_bayangan inner join tbarang on brg_kode=fpd_brg_kode '
                  + ' inner join tfp_hdr_bayangan on fpd_fp_nomor=fp_nomor '
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

procedure TfrmFPBayangan.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'FPB';

          s:= ' select '
       + ' *,(((fp_amount-fp_freight)-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 net,'
       + ' if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(round(fp_amount)) Terbilang'
       + ' from tfp_hdr_bayangan '
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on so_cus_kode=cus_kode '
       + ' inner join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tfp_dtl_bayangan on fp_nomor=fpd_fp_nomor '
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

procedure TfrmFPBayangan.insertketampungan(anomor:string);
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
  s := 'select fpd_brg_kode,fpd_expired from tfp_dtl_bayangan where fpd_fp_nomor =' + Quot(anomor) ;
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


procedure TfrmFPBayangan.doslip2(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'FPB2';

          s:= ' select '
       + ' *,(((fp_amount-fp_freight)-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 net,'
       + ' if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(round(fp_amount)) Terbilang'
       + ' from tfp_hdr_bayangan '
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on so_cus_kode=cus_kode '
       + ' inner join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tfp_dtl_bayangan on fp_nomor=fpd_fp_nomor '
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

procedure TfrmFPBayangan.cxButton3Click(Sender: TObject);
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

function TfrmFPBayangan.gettop(akode:String):integer;
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

function TfrmFPBayangan.cariNomor(anomor:string): Boolean;
var
  s: string ;
  tsql : TMyQuery;
begin
  s := 'select * from tfp_hdr_bayangan where fp_nomor='+quot(anomor);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
      if Eof then
         Result := false
      else
      begin
        Result := true;
     end;
  end;
end;


procedure TfrmFPBayangan.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmFPBayangan.chkPajakClick(Sender: TObject);
begin
hitung;

end;

procedure TfrmFPBayangan.doslip3(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'FPB3';

          s:= ' select '
       + ' *,(((fp_amount-fp_freight)-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 net,'
       + ' if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(round(fp_amount)) Terbilang'
       + ' from tfp_hdr_bayangan '
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on so_cus_kode=cus_kode '
       + ' inner join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tfp_dtl_bayangan on fp_nomor=fpd_fp_nomor '
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


end.
