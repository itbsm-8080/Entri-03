unit ufrmFP;

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
  cxCalendar, cxCheckBox, cxButtonEdit, frxClass, frxExportPDF,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinDarkRoom, dxSkinFoggy,
  dxSkinSeven, dxSkinSharp, frxDMPExport, MyAccess;

type
  TfrmFP = class(TForm)
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
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    edtBiayaRp: TAdvEdit;
    Label19: TLabel;
    edtBiaya: TAdvEdit;
    edtBiayaPr: TAdvEdit;
    Label20: TLabel;
    edtsalesman: TAdvEdit;
    Label21: TLabel;
    edtTotal2: TAdvEdit;
    tipecash: TCheckBox;
    clHrgMin: TcxGridDBColumn;
    clOtorisasi: TcxGridDBColumn;
    cbDTP: TCheckBox;
    edtTelp: TAdvEdit;
    chkKatalog: TCheckBox;
    chkeceran: TCheckBox;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode(aispajak:Integer=1):string;
    function getnilairetur(anomor:String):double;
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
    function issample(akode : string):boolean;
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
    procedure doslip4(anomor : string );
    procedure doslip5(anomor : string );
    procedure doslip22(anomor : string );
    procedure cxButton3Click(Sender: TObject);
    function gettop(akode:String):integer;

    procedure edtBiayaPrExit(Sender: TObject);

    function getdisccn(akodebarang : Integer ; akode:String):double;
    function gethargamin(akodebarang : Integer ):double;
    function getlastcost(akodebarang : Integer ; atanggal:TDateTime ; anomordo :string ):double;    
    function getnilairetur2(anomor:String):double;
    procedure clDiscPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
      function ambildiscsales(akodebrg:string):double;
      function cekcetak(anomor:string):Boolean;
      function cekdolama(abulan : Integer ; atahun : Integer):Boolean;
    procedure clHargaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
   procedure doslip3(anomor : string );
   function getminimalmargin(akodebarang : Integer ):double;
   procedure doslipbatch(anomor : string );
  private
    FCDScustomer: TClientDataset;
    FCDSSKU : TClientDataset;

    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    atanggalold : TDateTime;
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
  frmFP: TfrmFP;  
const
   NOMERATOR = 'FP';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmcetak,
  UfrmOtorisasi;

{$R *.dfm}

procedure TfrmFP.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtNomordo.Enabled :=True;
  edtNomorDO.Clear;
  dtTglJT.DateTime := Date;
  chkPajak.Checked := true;
  chkKatalog.Checked := false;
  tipecash.Checked := False;
  edtTotal.Text := '0.00';
  edtPPN.Text := '0.00';
  edtFreight.Text := '0.00';
  edtCN.Text := '0.00';
  edtDP.Text := '0.00';
  cbDTP.Checked := False;
  edtsalesman.Clear;
  edtnomor.Text := getmaxkode(1);
  cxLookupcustomer.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  edtNomorDO.SetFocus;
  initgrid;

end;
procedure TfrmFP.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmFP.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmFP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmFP.getmaxkode(aispajak:integer=1):string;
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

procedure TfrmFP.cxButton1Click(Sender: TObject);
begin
    try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;

      // if not cekTanggal(dtTanggal.DateTime) then Exit;


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
     
     Exit;
   end;
end;

procedure TfrmFP.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmFP.cxButton2Click(Sender: TObject);
begin
   try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
    // if (not FLAGEDIT) and (not cekTanggal(dtTanggal.DateTime)) then Exit;
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
     
     Exit;
   end;
    
    Release;
end;

procedure TfrmFP.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;



     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmFP.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    //zAddField(FCDS, 'idbatch', ftString, False, 50);
    zAddField(FCDS, 'Harga', ftFloat, False);
    zAddField(FCDS, 'Disc', ftFloat, False);
    zAddField(FCDS, 'Total', ftFloat, False);
    zAddField(FCDS, 'expired', ftDate, False, 255);
    zAddField(FCDS, 'kurang', ftFloat, False);
    zAddField(FCDS, 'CN', ftFloat, False);
    zAddField(FCDS, 'NilaiCN', ftFloat, False);
    zAddField(FCDS, 'Gudang', ftString, False,255);
    zAddField(FCDS, 'hrg_min', ftFloat, False);
    zAddField(FCDS, 'otorisasi', ftInteger, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmFP.GetCDScustomer: TClientDataset;
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

procedure TfrmFP.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmFP.cxLookupcustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDScustomer.Fields[2].AsString;

end;

procedure TfrmFP.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmFP.clSKUPropertiesEditValueChanged(Sender: TObject);
begin

 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;
 CDS.FieldByName('brg_hrg_min').AsFloat := CDSSKU.Fields[3].AsFloat;

end;

procedure TfrmFP.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmFP.dtTanggalChange(Sender: TObject);
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
  dtTglJT.DateTime :=  dtTanggal.DateTime+getTop(cxLookupCustomer.EditValue);
end;


procedure TfrmFP.simpandata;
var
  s:string;
  aiseceran,i:integer;
  tt:TStrings;
  aDTP,atipecash,aistax,aiskat : integer;
begin
  if chkPajak.Checked then
    aistax :=  1
  else
    aistax := 0;
  if chkKatalog.Checked then
    aiskat :=  1
  else
    aiskat := 0;
  if chkeceran.Checked then
    aiseceran :=  1
  else
    aiseceran := 0;


   if tipecash.Checked then
    atipecash :=  1
  else
    atipecash := 0;

  if cbDTP.Checked then
    aDTP :=  1
  else
    aDTP := 0;

if FLAGEDIT then
begin
  s:='update tfp_hdr set '
    + ' fp_cus_kode = ' + Quot(cxLookupcustomer.EditValue) + ','
    + ' fp_do_nomor =' +Quot(edtNomorDO.Text)+','
    + ' fp_memo = ' + Quot(edtmemo.Text) + ','
    + ' fp_isecer = '+ IntToStr(aiseceran) + ','
    + ' fp_disc_faktur =' + floattostr(cStrToFloat(edtDisc.Text))+ ','
    + ' fp_disc_fakturpr = '+ floattostr(cStrToFloat(edtDiscpr.Text))+ ','
    + ' fp_biayapr =' + floattostr(cStrToFloat(edtBiayaPr.Text))+ ','
    + ' fp_biayarp = '+ floattostr(cStrToFloat(edtBiayaRp.Text))+ ','
    + ' fp_freight = ' + FloatToStr(cStrToFloat(edtFreight.text)) + ','
    + ' fp_amount = '+ floattostr(cstrtoFloat(edtTotal.Text))+ ','
    + ' fp_taxamount = '+ floattostr(cStrToFloat(edtPPN.Text))+ ','
    + ' fp_istax = ' + IntToStr(aistax)+  ','
    + ' fp_jthtempo='+ quotd(dttGLjt.datetime)+','
    + ' fp_dp = ' + floattostr(cstrtoFloat(edtDP.Text))+ ','
    + ' fp_cn = ' + floattostr(cstrtoFloat(edtCN.Text))+ ','
    + ' fp_isDTP = ' + IntToStr(aDTP) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where fp_nomor = ' + quot(FID) + ';';
    edtNomor.text:=fid;
end
else
begin
  if chkpajak.Checked then
  edtNomor.Text := getmaxkode(1)
  else
  edtNomor.Text := getmaxkode(0);

  s :=  ' insert into tfp_hdr '
             + ' (fp_nomor,fp_do_nomor,fp_tanggal,fp_jthtempo,fp_memo,fp_cus_kode,fp_disc_faktur,'
             + ' fp_disc_fakturpr,fp_biayapr,fp_biayarp,fp_amount,fp_taxamount,fp_freight,fp_istax,fp_dp,fp_cn,fp_isDTP,fp_isecer,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quot(edtNomorDO.Text)+','
             + Quotd(dtTanggal.Date) + ','
             + quotd(dttGLjt.datetime)+','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupcustomer.EditValue) + ','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtBiayaPr.Text))+ ','
             + floattostr(cStrToFloat(edtBiayaRp.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + FloatToStr(cStrToFloat(edtFreight.text))+','
             + IntToStr(aistax)+  ','
             + floattostr(cstrtoFloat(edtDP.Text))+ ','
             + floattostr(cstrtoFloat(edtCN.Text))+ ','
             + IntToStr(aDTP) + ','
             + IntToStr(aiseceran) + ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from tfp_dtl '
      + ' where  fpd_fp_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
    S:='insert into tfp_dtl (fpd_fp_nomor,fpd_brg_kode,fpd_brg_satuan,fpd_qty,fpd_discpr,fpd_harga,fpd_nourut,fpd_expired, '
    + ' fpd_cn,fpd_gdg_kode,fpd_hrg_min) values ';
  while not CDS.Eof do
  begin

     s:=s+'('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + IntToStr(CDS.FieldByName('QTY').AsInteger) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('DISC').AsFloat))+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('harga').AsFloat))+','
      + IntToStr(i)  +','
      + QuotD(CDS.FieldByName('expired').AsDateTime)+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('cn').AsFloat))+','
      + Quot(CDS.FieldByName('gudang').AsString) + ','
      + FloatToStr(cVarToFloat(CDS.FieldByName('hrg_min').AsFloat))
      + ')';


    CDS.Next;
    if not cds.eof then
       s:=s+','
    else
      s:=s+';';
         
    Inc(i);
  end;

  tt.Append((s));
//  tt.SaveToFile('s.txt');
     try
        for i:=0 to tt.Count -1 do
        begin
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;
end;


function TfrmFP.cekdata:Boolean;
var
  i:integer;
  s,ss:string;
  tsql,tsql2:TmyQuery;
  anetharga : Double;
  ahet : double ;
  alastcost : Double;
  abiayapromosi,abiayapromosi2 : Double;

begin
  result:=true;
   i := 1;
//  if cStrToFloat(edtBiaya.Text) > 0  then
//  begin
//        s:= ' select Nomor,month(tanggal) Bulan,year(tanggal) Tahun,Tanggal,JthTempo,Salesman,Customer,Total,ifnull(CN,0) Kontrak,ifnull(Biaya_promosi,0) Biaya_Promosi,'
//        + ' Total-ifnull(Biaya_promosi,0)-ifnull(CN,0) Riil,Net,Hpp,net-hpp Margin'
//        + '  from ( '
//        + ' select fp_nomor Nomor,fp_tanggal Tanggal ,fp_jthtempo JthTempo, fp_Memo Memo ,'
//        + ' sls_nama Salesman,cus_nama  Customer,  fp_amount Total,'
//        + ' fp_cn CN,ifnull((fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp,0) Biaya_Promosi ,fp_DP DP,fp_bayar Bayar,'
//        + ' fp_amount-fp_taxamount-ifnull((fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp,0)-ifnull(fp_cn,0)-ifnull(fp_freight,0) net,'
//        + '  sum(mst_stok_out*mst_hargabeli) hpp '
//        + ' from tfp_hdr z inner join tcustomer on cus_kode=fp_cus_kode  inner join tmasterstok on mst_noreferensi = fp_do_nomor left join'
//        + ' tdo_hdr on fp_do_nomor=do_nomor  left join tso_hdr on do_so_nomor=so_nomor'
//        + ' left JOIN Tsalesman on sls_kode=so_sls_kode'
//        + ' where fp_nomor='+ Quot(edtNomor.Text)
//        + ' group by fp_nomor ,fp_tanggal ,cus_nama ) a ';
//   tsql := xOpenQuery(s,frmMenu.conn);
//  with tsql do
//  begin
//    try
//       if (cStrToFloat(edtBiaya.Text)/FieldByName('margin').AsFloat)*100 > 30 then
//       begin
//          if MessageDlg('Biaya Promosi Melebihi batas normal ingin lanjut ? ',mtCustom,
//          [mbYes,mbNo], 0)= mrNo then
//          begin
//              result:=false;
//              Exit;
//          end;
//       end;
//    finally
//      free;
//    end;
//  end;
// end;
    If cxLookupcustomer.EditValue = '' then
    begin
      ShowMessage('customer belum di pilih');
      result:=false;
      Exit;
    end;
    CDS.First;
  While not CDS.Eof do
  begin

    if (CDS.FieldByName('otorisasi').AsInteger <> 1) AND (edtsalesman.Text <> 'INTERNAL' )  then
    begin
      IF edtsalesman.Text = 'N3' then
         Exit;

       anetharga := CDS.fieldbyname('harga').AsFloat*(100-CDS.fieldbyname('Disc').AsFloat)/100;

//   ambil biaya promosi
       ss:= ' select bpd_persen,bpd_rupiah from tbiayapromosi_dtl inner join '
          + ' tbiayapromosi_hdr on bph_nomor=bpd_bph_nomor '
          + ' where bph_cus_kode = ' + Quot(cxLookupCustomer.EditValue)
          + ' and bpd_brg_kode = ' + inttostr(cds.fieldbyname('sku').asinteger);
          abiayapromosi :=0;
          abiayapromosi2:=0;
       tsql2 := xOpenQuery(ss,frmMenu.conn);
       with tsql2 do
       begin
         try
           if not eof then
           begin
             abiayapromosi:=Fields[0].AsFloat/100*anetharga;
             abiayapromosi2 := Fields[1].AsFloat;
           end;
         finally
           Free;
         end;
       end;

//----------------------
       anetharga := anetharga * (100-CDS.fieldbyname('cn').AsFloat)/100;
       anetharga := anetharga - abiayapromosi - abiayapromosi2 ;

       alastcost := getlastcost(CDS.fieldbyname('sku').asinteger,CDS.fieldbyname('expired').asdatetime,edtNomorDO.Text);
       ahet := gethargamin(CDS.fieldbyname('sku').asinteger);
//       if ((anetharga < ahet) and (ahet > 0)  then
//       begin
//          if MessageDlg('Harga Jual '+getnama('tbarang','brg_kode',cds.fieldbyname('sku').AsString,'brg_nama')+' Dibawah Batas Harga',mtCustom,
//            [mbYes,mbNo], 0)= mrNo then
//             begin
//                    result:=false;
//                    Exit;
//             end
//            else
//            begin
//                Application.CreateForm(TfrmOtorisasi,frmOtorisasi);
//                frmOtorisasi.ShowModal;
//                if frmMenu.otorisasi then
//                begin
//                   If CDS.State <> dsEdit then CDS.Edit;
//                   CDS.FieldByName('otorisasi').AsInteger := 1;
//                end
//                else
//                begin
//                  result:=false;
//                  exit;
//                end;
//            end;
//       end;
     {if not issample(cxLookupCustomer.EditValue) then
     begin
       if (((anetharga-alastcost)/alastcost)*100 < getminimalmargin(CDS.fieldbyname('sku').asinteger))
        or (((anetharga < ahet) and (ahet > 0)))
       then
       begin

            if MessageDlg('Harga Jual '+getnama('tbarang','brg_kode',cds.fieldbyname('sku').AsString,'brg_nama')+' Terlalu Kecil /Dibawah HET',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo then
             begin
                    result:=false;
                    Exit;
             end
            else
            begin
               if anetharga < alastcost then
               begin
                 Application.CreateForm(TfrmOtorisasi2,frmOtorisasi2);
                frmOtorisasi2.ShowModal;
                if frmMenu.otorisasi then
                begin
                   If CDS.State <> dsEdit then CDS.Edit;
                   CDS.FieldByName('otorisasi').AsInteger := 1;
                end
                else
                begin
                  result:=false;
                  exit;
                end;
               end
               else
               begin
                Application.CreateForm(TfrmOtorisasi,frmOtorisasi);
                frmOtorisasi.ShowModal;
                if frmMenu.otorisasi then
                begin
                   If CDS.State <> dsEdit then CDS.Edit;
                   CDS.FieldByName('otorisasi').AsInteger := 1;
                end
                else
                begin
                  result:=false;
                  exit;
                end;
               end;


            end;
        end;
     end;   }
    end;


    If CDS.FieldByName('SKU').AsInteger = 0 then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;

//    If CDS.FieldByName('hrg_min').asfloat > ((CDS.FieldByName('harga').AsFloat*(100-CDS.FieldByName('disc').AsFloat)/100)*(100-CDS.FieldByName('cn').asfloat)/100)  then
//    begin
//      ShowMessage('SKU Baris : ' + inttostr(i) + ' Harga di bawah HET ');
//      result:=false;
//      Exit;
//    end;

    inc(i);
    CDS.Next;
  end;
end;
function TfrmFP.issample(akode : string):boolean;
var
  s:String;
  tsql:TmyQuery;
begin
  result:=false;
  s:='select count(*) from tcustomer '
  + ' where cus_nama like '+ Quot('%sample%')+' and cus_kode like '+ Quot(akode)+';';
  TSQL := xOpenQuery(s,frmmenu.conn);
  with tsql do
  begin
    try
      if fields[0].AsInteger > 0 then
         result := true;
    finally
      free;
    end;
  end;
end;

procedure TfrmFP.loaddataDO(akode : string);
var
  s: string ;
  tsql : TmyQuery;
  aisecer,i:Integer;
  ahna,lval : double;
begin


  s := ' select do_nomor,do_tanggal,so_cus_kode,so_istax,cus_top,'
     + ' so_DISC_faktur,so_disc_fakturpr,so_istax,sod_keterangan,'
     + ' dod_brg_kode,dod_bRG_satuan,(dod_qty-dod_qty_invoice) dod_qty,dod_tgl_expired expired,'
     + ' sod_harga,sod_discpr,((dod_qty-dod_qty_invoice)*sod_harga*(100-sod_discpr)/100) nilai,dod_gdg_kode,sls_nama,cus_nama,cus_alamat,cus_telp'
     + ' from tdo_hdr inner join tso_hdr a on do_so_nomor = so_nomor'
     + ' inner join tdo_dtl on dod_do_nomor = do_nomor '
     + ' inner join tcustomer on cus_kode =so_cus_kode '
     + ' left join tsalesman on sls_kode=so_sls_kode '
     + ' LEFT join tso_dtl d on a.so_nomor=d.sod_so_nomor  and dod_brg_kode = sod_brg_kode  '
     + ' where do_nomor = '+ Quot(akode)
     + ' order by dod_nourut';
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

//            aisecer := fieldbyname('do_isecer').AsInteger;
//            if aisecer = 1 then
//               chkeceran.Checked := True
//            else
//               chkeceran.Checked := false;

            edtNomor.Text := getmaxkode(apajak);
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
            edtAlamat.Text := fieldbyname('cus_alamat').AsString;
            edtTelp.Text :=   fieldbyname('cus_telp').AsString;

            edtsalesman.Text := fieldbyname('sls_nama').AsString;
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
                      CDS.fieldbyname('nilaicn').asfloat           := CDS.FieldByName('cn').asfloat*fieldbyname('nilai').AsFloat/100;
                      CDS.FieldByName('Hrg_min').asfloat := gethargamin(fieldbyname('dod_brg_kode').AsInteger);


//                        if cekProductFocus(fieldbyname('dod_brg_kode').AsString) then
//                        begin
//                           ahna := gethna(fieldbyname('dod_brg_kode').AsString);
//                           if ahna > CDS.FieldByName('Harga').AsFloat  then
//                           begin
//                             lVal := ahna  - CDS.FieldByName('Harga').AsFloat;
//                             lVal := lVal / ahna *  100;
//                             If CDS.State <> dsEdit then CDS.Edit;
//                             CDS.FieldByName('harga').AsFloat := ahna;
//                             CDS.FieldByName('disc').AsFloat := lval;
//                           end;
//                        end;
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

procedure TfrmFP.edtNomorDOClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT do_NOMOR Nomor,do_TANGGAL Tanggal,cus_NAMA customer from tdo_HDR '
            + ' inner join tcustomer on cus_kode=do_cus_kode where do_isclosed=0';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
    edtNomorDO.Text := varglobal;
    if (MonthOf(StrToDate(varglobal1)) = MonthOf(cGetServerTime)) then
    begin
      if (cekdolama(MonthOf(cGetServerTime), YearOf(cGetServerTime))) and (StrToInt(FormatDateTime('dd',cGetServerTime))> getbatas('FP')) then
      begin
        ShowMessage('DO Bulan lalu masih ada yang belum di proses');
         Exit;
      end;
    end;
  end;
  loaddataDO(edtNomorDO.Text);
end;



procedure TfrmFP.loaddataall(akode : string);
var
  s: string ;
  tsql : TmyQuery;
  acatalog,a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtyterima : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
//  ShowMessage(akode);
  s := ' select fp_NOMOr,fp_tanggal,do_nomor,fp_memo,so_cus_kode,fp_istax,fp_jthtempo,FP_CN,FP_DP,'
     + ' fpd_brg_kode,fpd_bRG_satuan,fpd_qty,fpd_harga,fpd_discpr,(fpd_qty*fpd_harga*(100-fpd_discpr)/100) nilai,'
     + ' fpd_expired,fp_disc_faktur,fp_disc_fakturpr,dod_qty-dod_qty_invoice kurang,fpd_cn,fp_freight,fpd_gdg_kode ,'
     + ' fp_biayapr,fp_biayarp,sls_nama,fpd_hrg_min,fp_isDTP'
     + ' from tfp_hdr inner join tdo_hdr on do_nomor =fp_do_nomor '
     + ' left join tso_hdr a on do_so_nomor=so_nomor'
     + ' left join tsalesman on sls_kode=so_sls_kode '
     + ' left join tfp_dtl on fpd_fp_nomor=fp_nomor'
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
            edtNomordo.Enabled :=true;
            apajak :=fieldbyname('fp_istax').AsInteger;
            if apajak =1 then
               chkPajak.Checked := True
            else
               chkPajak.Checked := False;

             if acatalog =1 then
               chkKatalog.Checked := True
            else
               chkKatalog.Checked := False;
            IF fieldbyname('fp_isDTP').AsInteger = 1 then
              cbDTP.Checked := True
            else
              cbDTP.Checked := False;
            FID :=fieldbyname('fp_nomor').AsString;
            edtnomor.Text := fieldbyname('fp_nomor').AsString;
            edtNomorDO.Text   := fieldbyname('do_nomor').AsString;
            dttanggal.DateTime := fieldbyname('fp_tanggal').AsDateTime;
            atanggalold := fieldbyname('fp_tanggal').AsDateTime;
            dtTglJT.DateTime  :=  fieldbyname('fp_jthtempo').AsDateTime;
            edtmemo.Text := fieldbyname('fp_memo').AsString;
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
            edtAlamat.Text := CDScustomer.Fields[2].AsString;
            edtsalesman.Text := fieldbyname('sls_nama').AsString;
            edtDiscpr.Text :=fieldbyname('fp_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('fp_disc_faktur').AsString;
            edtbiayapr.text := fieldbyname('fp_biayapr').AsString;
            edtbiayarp.text := fieldbyname('fp_biayarp').AsString;
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
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('fpd_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('fpd_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('fpd_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('fpd_expired').AsDateTime;
                      CDS.FieldByName('kurang').asfloat      := fieldbyname('kurang').asfloat+fieldbyname('fpd_qty').asfloat;
//                      CDS.fieldbyname('cn').asfloat           := fieldbyname('fpd_cn').AsFloat;
//                      CDS.fieldbyname('cn').asfloat           := getdisccn(fieldbyname('fpd_brg_kode').AsInteger,cxLookupcustomer.EditValue);
//                      CDS.fieldbyname('nilaicn').asfloat           := fieldbyname('fpd_cn').AsFloat*fieldbyname('nilai').AsFloat/100;
//                      CDS.fieldbyname('nilaicn').asfloat           := CDS.FieldByName('cn').asfloat*fieldbyname('nilai').AsFloat/100;
                      CDS.FieldByName('gudang').AsString      := fieldbyname('fpd_gdg_kode').Asstring;
                      CDS.FieldByName('hrg_min').AsFloat        := fieldbyname('fpd_hrg_min').AsFloat;


                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
           hitung;
           edtBiayaPrExit(Self);
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

procedure TfrmFP.hitung;
var
  asubtotal : Double;
  aretur : double ;
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
    aretur := ((asubtotal*getangkappn(dtTanggal.DateTime))+cStrToFloat(edtFreight.text))-getnilairetur(edtNomor.text);
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal+cStrToFloat(edtFreight.text));
    edtPPN.Text := '0';
    edtCN.Text := FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('NilaiCN')));
    aretur := ((asubtotal)+cStrToFloat(edtFreight.text))-getnilairetur(edtNomor.text);
  end;

    edtTotal2.Text :=FloatToStr(aretur);



end;


procedure TfrmFP.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan,brg_harga_min from tbarang '
  + ' inner join tdo_dtl on dod_brg_kode=brg_kode and dod_do_nomor =' + Quot(edtNomorDO.Text);


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);


end;

procedure TfrmFP.edtDiscprExit(Sender: TObject);
begin
if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmFP.edtDiscExit(Sender: TObject);
begin
if edtDisc.Text = '' then
    edtDisc.Text :='0';
hitung;
end;

procedure TfrmFP.clDiscPropertiesChange(Sender: TObject);
var
  i:integer;
  lVal: Double;
  ahna : Double;
begin
 cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
//  if cekProductFocus(cxGrdMain.DataController.Values[i, clSKU.Index]) then
//  begin
//     ahna := gethna(cxGrdMain.DataController.Values[i, clSKU.Index]);
//     if ahna > cxGrdMain.DataController.Values[i, clHarga.Index]  then
//     begin
//       lVal := ahna  - cxGrdMain.DataController.Values[i, clHarga.Index] ;
//       lVal := lVal / ahna *  100;
//       If CDS.State <> dsEdit then CDS.Edit;
//       CDS.FieldByName('harga').AsFloat := ahna;
//       CDS.FieldByName('disc').AsFloat := lval;
//     end
//     else
//     begin
//       If CDS.State <> dsEdit then CDS.Edit;
//       CDS.FieldByName('disc').AsFloat := 0;
//     end;
//  end;


  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index]*(cvartofloat(cxGrdMain.DataController.Values[i,cldisc.Index])/100);
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] * cxGrdMain.DataController.Values[i, clHarga.Index] - lVal;


  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Total').AsFloat := lVal;
  CDS.FieldByName('NilaiCN').AsFloat := CDS.FieldByName('CN').AsFloat /100 * lVal;
  CDS.Post;
  hitung;
end;

procedure TfrmFP.clQTYPropertiesValidate(Sender: TObject;
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

//  aqtykurang :=cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clKurang.Index]);
//
//    if cVarToInt(DisplayValue) > aqtykurang then
//    begin
      error := true;
        ErrorText :='Qty melebihi qty kurang';
        exit;
    end;

end;
procedure TfrmFP.chkDPClick(Sender: TObject);
var
  s:string;
  tsql :TmyQuery ;
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

procedure TfrmFP.chkCNClick(Sender: TObject);
var
  s:string;
  tsql :TmyQuery ;
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

procedure TfrmFP.clHargaPropertiesButtonClick(Sender: TObject;
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

procedure TfrmFP.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
//  frxDotMatrixExport1.Start;

  // insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'FP';

          s:= ' select '
       + ' *,(((fp_amount-fp_freight)-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 net,'
       + ' if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(round(fp_amount)) Terbilang'
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
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmFP.insertketampungan(anomor:string);
var
  s:string;
  tsql : TmyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=8;
  s:='delete from tampung ';
    EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
  
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
        EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, tt[i]);
    end;
  finally
    tt.Free;
  end;


end;


procedure TfrmFP.doslip2(anomor : string );
var
  s: string ;
  tsqlheader,tsql2,tsql : TmyQuery;
  abaris,i,a:Integer;
  arekening,anamabarang,TERBILANG : String;
  anilaipiutang:double;
  afreight,adiscfaktur,adp,atotal,anilai,appn : Double;
  apj,apjno : string;

begin
 if not cekcetak(anomor) then
 begin
   s:='update tfp_hdr set fp_iscetak=1 where fp_nomor = '+ Quot(anomor);
     EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
   
 end
 else
 begin
      if MessageDlg('Sudah pernah di cetak ,Yakin ingin cetak lagi ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

 end;

 Application.CreateForm(TfrmCetak,frmCetak);
 abaris := getbarisslip('FP');
 with frmCetak do
 begin
    memo.Clear;
      memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp,perush_pak,perush_pj,perush_pj_no '
      + ' from tperusahaan ';

  tsqlheader := xOpenQuery(s, frmMenu.conn);
  with tsqlheader do
  begin
    try
      apj :=Fields[6].AsString;
      apjno := Fields[7].AsString;
      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString ,60, ' '));
//      memo.lines.add(StrPadRight(Fields[3].AsString, 60, ' '));
//      memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 60, ' '));
//      memo.lines.add('PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));

    finally

    end;
  end;

      s:= ' select '
       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(fp_amount) terbilang ,'
       + ' ((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett ,cus_top top,'
       + ' (select cbg_rekening from tcabang where cbg_aktif=1) Rekening '
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
          anilai := fieldbyname('FP_amount').AsFloat-fieldbyname('FP_taxamount').AsFloat-fieldbyname('FP_freight').AsFloat;
          appn := fieldbyname('FP_taxamount').AsFloat;
          atotal := fieldbyname('FP_amount').AsFloat;
          afreight := fieldbyname('FP_freight').AsFloat;
          adp :=fieldbyname('FP_dp').AsFloat;
          arekening := fieldbyname('rekening').asstring;
          adiscfaktur :=  ((fieldbyname('FP_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('FP_disc_faktur').asfloat;
      memo.lines.add('Telp : ' + StrPadRight(tsqlheader.Fields[3].AsString, 32, ' ')+StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 35, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 45, ' '));
      memo.Lines.Add('NPWP : ' + StrPadRight(tsqlheader.Fields[4].AsString, 32, ' ')+StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 35, ' ')+ ' ' + StrPadRight(copy(fieldbyname('cus_alamat').AsString,1,40), 45, ' '));
      if fieldbyname('top').asinteger > 30 then
      memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime+30), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '))
      else
      memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '));
      memo.lines.add(StrPadRight('', 39, ' ')+ StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 36, ' ')+ StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 20, ' '));
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
           s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp , PERUSH_PAK'
          + ' from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
//                memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 30, ' ')+ ' PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));
//                memo.Lines.Add('');
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));
          memo.lines.add('Telp : ' + StrPadRight(tsqlheader.Fields[3].AsString, 32, ' ')+StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 35, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 45, ' '));
          memo.Lines.Add('NPWP : ' + StrPadRight(tsqlheader.Fields[4].AsString, 32, ' ')+StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 35, ' ')+ ' ' + StrPadRight(copy(fieldbyname('cus_alamat').AsString,1,40), 45, ' '));
          if fieldbyname('top').asinteger > 30 then
          memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime+30), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '))
          else
          memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '));
          memo.lines.add(StrPadRight('', 39, ' ')+ StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 36, ' ')+ StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 20, ' '));

//      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 60, ' '));

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
                          +StrPadRight('Total     :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
                           + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
                          );
if appn > 0 then
begin
    memo.Lines.Add(StrPadRight('Mohon Pembayaran ditransfer ke BANK SYARIAH INDONESIA ', 82, ' ')
                  +StrPadRight('Freight       :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' '));
    memo.Lines.Add(StrPadRight('Norek : '+arekening, 82, ' ')
                  +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' '));

    memo.Lines.Add(StrPadRight('A/n   : PT Bumi Sarana Maju', 82, ' '));
end
else
begin
    memo.Lines.Add(StrPadRight('', 82, ' ')
                  +StrPadRight('Freight       :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' '));
    memo.Lines.Add(StrPadRight('', 82, ' ')
                  +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' '));

    memo.Lines.Add(StrPadRight('', 82, ' '));
end;



    memo.Lines.Add('');

    memo.Lines.Add(
    StrPadRight('  Di cek Oleh', 20, ' ')
    +StrPadRight('      Disetujui', 35, ' ')
    +StrPadRight('   Diantar', 25, ' ')
    +StrPadRight('   Diterima', 25, ' ')
    +StrPadRight('* Retur Max 7 Hari ', 30, ' '));
    memo.Lines.Add('');
    memo.Lines.Add('');
          memo.Lines.Add(
                          StrPadRight('(               )', 20, ' ')
                          +StrPadRight('(PJ:'+apj+')', 35, ' ')+' '
                          +StrPadRight('(              )', 22, ' ')
                          +StrPadRight('(              )', 22, ' ')
                          +StrPadRight('', 30, ' ')
                          );
//          memo.Lines.Add(  StrPadRight('                 ', 20, ' ')
//                          +StrPadRight('PJ:'+apj, 35, ' '));
       memo.Lines.Add(
                          StrPadRight('                 ', 20, ' ')
                          +StrPadRight('  No:'+apjno+'', 35, ' ')+' '
                          +StrPadRight('               ', 25, ' ')
                          +StrPadRight('', 30, ' '));
//       memo.Lines.Add('Note : Retur barang maksimal 7 (tujuh) hari (konfirmasi terlebih dahulu)');

    nomor :=anomor;
    memo.Lines.Add('');
    memo.Lines.Add('');




  finally
    tsqlheader.free;
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;

procedure TfrmFP.doslip4(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
//  frxDotMatrixExport1.Start;

  // insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'FPRET';

          s:= ' select '
       + ' *,(((fp_amount-fp_freight)-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 net,'
       + ' if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(round(fp_amount)) Terbilang'
       + ' from tfp_hdr '
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on so_cus_kode=cus_kode '
       + ' inner join tsalesman on sls_kode=so_sls_kode '
       + ' left join  tfp_dtl on fp_nomor=fpd_fp_nomor '
       + ' left join tbarang on fpd_brg_kode=brg_kode '
       + ' LEFT JOIN tretj_hdr ON retj_fp_nomor=fp_nomor'
       + ' LEFT JOIN tretj_dtl ON retj_nomor=retjd_retj_nomor AND retjd_brg_kode=fpd_brg_kode'
       + ' where '
       + ' fp_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
END;

procedure TfrmFP.doslip5(anomor : string );
var
  s: string ;
  tsqlheader,tsql2,tsql : TmyQuery;
  abaris,i,a:Integer;
  arekening,anamabarang,TERBILANG : String;
  anilaipiutang:double;
  afreight,adiscfaktur,adp,atotal,anilai,appn : Double;
  apj,apjno : string;

begin
   if not cekcetak(anomor) then
 begin
   s:='update tfp_hdr set fp_iscetak=1 where fp_nomor = '+ Quot(anomor);
     EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
   
 end
 else
 begin
      if MessageDlg('Sudah pernah di cetak ,Yakin ingin cetak lagi ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

 end;

//
//  insertketampungan(anomor);
//  ftsreport := TTSReport.Create(nil);
//  try
//    ftsreport.Nama := 'FPDTP';
//          s:= ' select '
//       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(fp_amount-fp_taxamount-ifnull(retj_amount,0)) terbilang ,'
//       + ' ((fp_amount-retj_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett ,cus_top top,'
//       + ' (select cbg_rekening from tcabang where cbg_aktif=1) Rekening,(select count(*) from tfp_dtl where fpd_fp_nomor=fp_nomor) jmlitem '
//       + ' from tfp_hdr '
//       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
//       + ' inner join tso_hdr on so_nomor=do_so_nomor'
//       + ' inner join tcustomer on so_cus_kode=cus_kode '
//       + ' inner join tsalesman on sls_kode=so_sls_kode '
//       + ' left join  tfp_dtl on fp_nomor=fpd_fp_nomor '
//       + ' left join tbarang on fpd_brg_kode=brg_kode '
//       + ' LEFT JOIN tretj_hdr ON retj_fp_nomor=fp_nomor'
//       + ' LEFT JOIN tretj_dtl ON retj_nomor=retjd_retj_nomor AND retjd_brg_kode=fpd_brg_kode'
//       + ' AND retjd_expired=fpd_expired'
//       + ' where '
//       + ' fp_nomor=' + quot(anomor)
//       + ' order by nourut';
//
//
//    ftsreport.AddSQL(s);
//    ftsreport.ShowReport;
//  finally
//     ftsreport.Free;
//  end;

 Application.CreateForm(TfrmCetak,frmCetak);
 abaris := getbarisslip('FP');
 with frmCetak do
 begin
    memo.Clear;
      memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp,perush_pak,perush_pj,perush_pj_no '
      + ' from tperusahaan ';

  tsqlheader := xOpenQuery(s, frmMenu.conn);
  with tsqlheader do
  begin
    try
      apj :=Fields[6].AsString;
      apjno := Fields[7].AsString;
      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString ,60, ' '));
//      memo.lines.add(StrPadRight(Fields[3].AsString, 60, ' '));
//      memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 60, ' '));
//      memo.lines.add('PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));

    finally

    end;
  end;

      s:= ' select '
       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(fp_amount-fp_taxamount) terbilang ,'
       + ' ((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett ,cus_top top,'
       + ' (select cbg_rekening from tcabang where cbg_aktif=1) Rekening '
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
          anilai := fieldbyname('FP_amount').AsFloat-fieldbyname('FP_taxamount').AsFloat-fieldbyname('FP_freight').AsFloat;
          appn := fieldbyname('FP_taxamount').AsFloat;
          atotal := anilai+fieldbyname('FP_freight').AsFloat;//fieldbyname('FP_amount').AsFloat;
          afreight := fieldbyname('FP_freight').AsFloat;
          adp :=fieldbyname('FP_dp').AsFloat;
          arekening := fieldbyname('rekening').asstring;
          adiscfaktur :=  ((fieldbyname('FP_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('FP_disc_faktur').asfloat;
      memo.lines.add('Telp : ' + StrPadRight(tsqlheader.Fields[3].AsString, 32, ' ')+StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 35, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 45, ' '));
      memo.Lines.Add('NPWP : ' + StrPadRight(tsqlheader.Fields[4].AsString, 32, ' ')+StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 35, ' ')+ ' ' + StrPadRight(copy(fieldbyname('cus_alamat').AsString,1,40), 45, ' '));
      if fieldbyname('top').asinteger > 30 then
      memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime+30), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '))
      else
      memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '));
      memo.lines.add(StrPadRight('', 39, ' ')+ StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 36, ' ')+ StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 20, ' '));
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
           s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp , PERUSH_PAK'
          + ' from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
//                memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 30, ' ')+ ' PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));
//                memo.Lines.Add('');
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));
          memo.lines.add('Telp : ' + StrPadRight(tsqlheader.Fields[3].AsString, 32, ' ')+StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 35, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 45, ' '));
          memo.Lines.Add('NPWP : ' + StrPadRight(tsqlheader.Fields[4].AsString, 32, ' ')+StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 35, ' ')+ ' ' + StrPadRight(copy(fieldbyname('cus_alamat').AsString,1,40), 45, ' '));
          if fieldbyname('top').asinteger > 30 then
          memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime+30), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '))
          else
          memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '));
          memo.lines.add(StrPadRight('', 39, ' ')+ StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 36, ' ')+ StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 20, ' '));

//      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 60, ' '));

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
                          +StrPadRight('Total     :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
                           + StrPadLeft( '0', 21, ' ')+ ' '
                          );
if appn > 0 then
begin
    memo.Lines.Add(StrPadRight('Mohon Pembayaran ditransfer ke BANK SYARIAH INDONESIA', 82, ' ')
                  +StrPadRight('Freight       :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' '));
    memo.Lines.Add(StrPadRight('Norek : '+arekening, 82, ' ')
                  +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' '));

    memo.Lines.Add(StrPadRight('A/n   : PT Bumi Sarana Maju', 82, ' '));
end
else
begin
    memo.Lines.Add(StrPadRight('', 82, ' ')
                  +StrPadRight('Freight       :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' '));
    memo.Lines.Add(StrPadRight('', 82, ' ')
                  +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' '));

    memo.Lines.Add(StrPadRight('', 82, ' '));
end;


//                          +StrPadRight('Grand Total   :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' ')+ ' ');

//    memo.Lines.Add(   StrPadRight('  Disiapkan', 27, ' ')+' '
//                          +StrPadRight(' Disetujui,', 30, ' ')+' '
//                          +StrPadRight(' Penerima,', 22, ' ') +' '
//                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
//                          );
//
//     memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('Freight       :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' ')+ ' '
//                          );
//
//                          anilaipiutang :=atotal-
//                          StrToFloat(StringReplace(getdebet(anomor),',','',[rfReplaceAll]));
//      memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('DP        :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('###,###,###',ADP), 21, ' ')+ ' '
//                          );
//     memo.Lines.Add(      StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('Grand Total   :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' ')+ ' '
//                          );

//    memo.Lines.Add(
//                          );


    memo.Lines.Add('');

    memo.Lines.Add(StrPadRight('* Retur Max 7 Hari ', 30, ' ')
    +StrPadRight('  Di cek Oleh', 20, ' ')
    +StrPadRight('      Disetujui', 35, ' ')
    +StrPadRight('   Diantar', 25, ' ')
    +StrPadRight('   Diterima', 25, ' '));
    memo.Lines.Add('');
    memo.Lines.Add('');
          memo.Lines.Add(  StrPadRight('', 30, ' ')
                          +StrPadRight('(               )', 20, ' ')
                          +StrPadRight('(PJ:'+apj+')', 35, ' ')+' '
                          +StrPadRight('(              )', 22, ' ')
                          +StrPadRight('(              )', 22, ' ')
                          );
//          memo.Lines.Add(  StrPadRight('                 ', 20, ' ')
//                          +StrPadRight('PJ:'+apj, 35, ' '));
       memo.Lines.Add(StrPadRight('', 30, ' ')
                          + StrPadRight('                 ', 20, ' ')
                          +StrPadRight('  No:'+apjno+'', 35, ' ')+' '
                          +StrPadRight('               ', 25, ' '));
//       memo.Lines.Add('Note : Retur barang maksimal 7 (tujuh) hari (konfirmasi terlebih dahulu)');

    nomor :=anomor;
    memo.Lines.Add('');
    memo.Lines.Add('');




  finally
    tsqlheader.free;
     free;
  end
  end;
  end;
    frmCetak.ShowModal;

end;

//var
//  s: string ;
//  tsql2,tsql : TmyQuery;
//  abaris,i,a:Integer;
//  anamabarang,TERBILANG : String;
//  anilaipiutang:double;
//  afreight,adiscfaktur,adp,atotal,anilai,appn : Double;
//  apjno,apj : string;
//
//begin
// if not cekcetak(anomor) then
// begin
//   s:='update tfp_hdr set fp_iscetak=1 where fp_nomor = '+ Quot(anomor);
//     EnsureConnected(frmMenu.conn);
//  ExecSQLDirect(frmMenu.conn, s);
//   xCommit(frmMenu.conn);
// end
// else
// begin
//      if MessageDlg('Sudah pernah di cetak ,Yakin ingin cetak lagi ?',mtCustom,
//                                  [mbYes,mbNo], 0)= mrNo
//      then Exit ;
//
// end;
//
// Application.CreateForm(TfrmCetak,frmCetak);
// abaris := getbarisslip('FP');
// with frmCetak do
// begin
//    memo.Clear;
//      memo.Lines.Add('');
//
//       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp,perush_pak,perush_pj,perush_pj_no '
//      + ' from tperusahaan ';
//
//  tsql := xOpenQuery(s, frmMenu.conn);
//  with tsql do
//  begin
//    try
//      apj :=Fields[6].AsString;
//      apjno := Fields[7].AsString;
//      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
//      memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
//      memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 30, ' ')+ ' PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));
//
//    finally
//      Free;
//    end;
//  end;
//
//      s:= ' select '
//       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(fp_amount-fp_taxamount-ifnull(retj_amount,0)) terbilang ,'
//       + ' ((fp_amount-retj_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett ,cus_top top'
//       + ' from tfp_hdr '
//       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
//       + ' inner join tso_hdr on so_nomor=do_so_nomor'
//       + ' inner join tcustomer on so_cus_kode=cus_kode '
//       + ' inner join tsalesman on sls_kode=so_sls_kode '
//       + ' left join  tfp_dtl on fp_nomor=fpd_fp_nomor '
//       + ' left join tbarang on fpd_brg_kode=brg_kode '
//       + ' LEFT JOIN tretj_hdr ON retj_fp_nomor=fp_nomor'
//       + ' LEFT JOIN tretj_dtl ON retj_nomor=retjd_retj_nomor AND retjd_brg_kode=fpd_brg_kode'
//       + ' AND retjd_expired=fpd_expired'
//       + ' where '
//       + ' fp_nomor=' + quot(anomor)
//       + ' order by nourut';
//
//  tsql := xOpenQuery(s,frmMenu.conn);
//  with tsql do
//  begin
//  try
//
//    if not Eof then
//    begin
//      TERBILANG := fieldbyname('terbilang').AsString;
//          anilai := fieldbyname('FP_amount').AsFloat-fieldbyname('retj_amount').AsFloat - fieldbyname('FP_taxamount').AsFloat;
//          appn := 0;
//          atotal := anilai;
//          afreight := fieldbyname('FP_freight').AsFloat;
//          adp :=fieldbyname('FP_dp').AsFloat;
//          adiscfaktur :=  ((fieldbyname('FP_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('FP_disc_faktur').asfloat;
//      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
//      if fieldbyname('top').asinteger > 30 then
//      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime+30), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 30, ' ')+' ' + StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 28, ' '))
//      else
//      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 30, ' ')+' ' + StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 28, ' '));
//
//      memo.Lines.Add(StrPadRight('', 120, '-'));
//      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
//                          +StrPadRight('Kode', 8, ' ')+' '
//                          +StrPadRight('Nama', 44, ' ')+' '
//                          +StrPadRight('Satuan', 10, ' ')+' '
//                          +StrPadLeft('Jumlah', 10, ' ')+' '
//                          +StrPadLeft('Disc(%)', 10, ' ')+' '
//                          +StrPadLeft('Harga', 14, ' ')+' '
//                          +StrPadLeft('Total', 15, ' ')+' '
//                          );
//       memo.Lines.Add(StrPadRight('', 120, '-'));
//    end;
//    i:=1;
//     while not eof do
//     begin
//         if strtoint(formatdatetime('yyyy',fieldbyname('fpd_expired').AsDateTime)) > 2000 then
//         anamabarang :=FieldByName('brg_nama').AsString + ' / '+FormatDateTime('mm.yyyy',fieldbyname('fpd_expired').AsDateTime)
//         else
//         anamabarang :=FieldByName('brg_nama').AsString;
//
//
//       if fieldbyname('fpd_qty').Asfloat-fieldbyname('retjd_qty').Asfloat > 0  then
//       begin
//
//             memo.Lines.Add(StrPadRight(IntToStr(i), 3, ' ')+' '
//                          +StrPadRight(fieldbyname('fpd_brg_kode').AsString, 8, ' ')+' '
//                          +StrPadRight(anamabarang, 44, ' ')+' '
//                          +StrPadRight(fieldbyname('fpd_brg_satuan').AsString, 10, ' ')+' '
//                          +StrPadLeft(FormatFloat('##,###',fieldbyname('fpd_qty').Asfloat-fieldbyname('retjd_qty').Asfloat), 10, ' ')+' '
//                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('fpd_discpr').Asfloat), 10, ' ')+' '
//                          +StrPadLeft(FormatFloat('#,###,###.##',fieldbyname('fpd_harga').Asfloat), 14, ' ')+' '
//                          +StrPadLeft(FormatFloat('##,###,###.##',(100-fieldbyname('fpd_discpr').Asfloat)/100*fieldbyname('fpd_harga').Asfloat*fieldbyname('fpd_qty').Asfloat), 15, ' ')+' '
//                          );
//                       i:=i+1;
//       end;
//       Next;
//       if (i mod abaris =0) and (not eof) then
//       begin
//         memo.Lines.Add(StrPadRight('', 120, '-'));
//            for a:=1 to 10 do
//            begin
//              memo.Lines.Add('');
//            end;
//           s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp , PERUSH_PAK'
//          + ' from tperusahaan ';
//
//            tsql2 := xOpenQuery(s, frmMenu.conn);
//            with tsql2 do
//            begin
//              try
//                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
//                memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
//                memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 30, ' ')+ ' PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));
//                memo.Lines.Add('');
//              finally
//                Free;
//              end;
//            end;
////            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));
//
//      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 60, ' '));
//
//            memo.Lines.Add(StrPadRight('', 120, '-'));
//            memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
//                          +StrPadRight('Kode', 12, ' ')+' '
//                          +StrPadRight('Nama', 40, ' ')+' '
//                          +StrPadRight('Satuan', 10, ' ')+' '
//                          +StrPadLeft('Jumlah', 10, ' ')+' '
//                          +StrPadLeft('Disc(%)', 10, ' ')+' '
//                          +StrPadLeft('Harga', 14, ' ')+' '
//                          +StrPadLeft('Total', 15, ' ')+' '
//                          );
//
//                   memo.Lines.Add(StrPadRight('', 120, '-'));
//       end;
//     end;
//    if  i mod abaris <> 0 then
//    begin
//      for a:=1 to (abaris - (i mod abaris)) do
//      begin
//        memo.Lines.Add('');
//      end;
//    end;
//    memo.Lines.Add(StrPadRight('', 120, '-'));
//
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',1,80), 81, ' ')+' '
//                          +StrPadRight('Disc faktur   :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',adiscfaktur), 21, ' ')+ ' '
//                          );
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
//                          +StrPadRight('Total         :', 15, ' ')+ ' '
//                           + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
//                          );
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',161,240), 81, ' ')+' '
//                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
//                          );
//     memo.Lines.Add(      StrPadRight('  Disiapkan', 27, ' ')+' '
//                          +StrPadRight(' Disetujui,', 30, ' ')+' '
//                          +StrPadRight(' Penerima,', 23, ' ')
//
//                          +StrPadRight('Freight       :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' ')+ ' '
//                          );
////
////                          anilaipiutang :=atotal-
////                          StrToFloat(StringReplace(getdebet(anomor),',','',[rfReplaceAll]));
////      memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
////                          +StrPadRight('DP        :', 15, ' ')+ ' '
////                          + StrPadLeft( FormatFloat('###,###,###',ADP), 21, ' ')+ ' '
////                          );
//     memo.Lines.Add(      StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('Grand Total   :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' ')+ ' '
//                          );
//
////    memo.Lines.Add(
////                          );
//    memo.Lines.Add('');
//    memo.Lines.Add('');
//    memo.Lines.Add('');
//          memo.Lines.Add(  StrPadRight('(               )', 20, ' ')
//                          +StrPadRight('(PJ:'+apj+')', 35, ' ')+' '
//                          +StrPadRight('(               )', 25, ' ')
//                          );
////          memo.Lines.Add(  StrPadRight('                 ', 20, ' ')
////                          +StrPadRight('PJ:'+apj, 35, ' '));
//       memo.Lines.Add(StrPadRight('                 ', 20, ' ')
//                          +StrPadRight('  No:'+apjno+'', 35, ' ')+' '
//                          +StrPadRight('               ', 25, ' '));
//
//       memo.Lines.Add('');
//       memo.Lines.Add('');
//    nomor :=anomor;
//
//
//
//  finally
//     free;
//  end
//  end;
//  end;
//    frmCetak.ShowModal;
//END;

procedure TfrmFP.cxButton3Click(Sender: TObject);
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
     
     Exit;
   end;
    
end;

function TfrmFP.gettop(akode:String):integer;
var
  s:string;
  tsql:TmyQuery;
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


procedure TfrmFP.edtBiayaPrExit(Sender: TObject);
var
  asubtotal : double;
begin
  asubtotal := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
    asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
    asubtotal := asubtotal - getnilairetur2(edtNomor.Text);
  edtBiaya.Text := FloatToStr((cStrToFloat(edtBiayaPr.text)/100*asubtotal)+cStrToFloat(edtBiayaRp.text)) ;
end;

function TfrmFP.getnilairetur(anomor:String):double;
var
  s:string;
  tsql:TmyQuery;
begin
  result := 0;
  s:='select sum(retj_amount) from tretj_hdr  where retj_fp_nomor = '+ Quot(anomor) ;
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

function TfrmFP.getdisccn(akodebarang : Integer ; akode:String):double;
var
  s:string;
  tsql:TmyQuery;
begin
  result := 0;
  s:='select fpd_cn from tfp_hdr inner join tfp_dtl on fpd_fp_nomor=fp_nomor '
  + ' inner join tpiutangcn on cn_cus_kode=fp_cus_kode '
  + ' where fp_cus_kode = '+ Quot(akode)
  + ' and fpd_brg_kode='+ IntToStr(akodebarang)
  + ' and fpd_cn > 0 '
  + ' and cn_startdate <= '+quotd(dtTanggal.Date)+' and '
  + ' cn_enddate >= ' + QuotD(dtTanggal.Date)
  + ' order by fp_tanggal desc limit 1 ';
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if not Eof then
       result := fields[0].asfloat;
   finally
     Free;
   end;
  end;
end;


function TfrmFP.gethargamin(akodebarang : Integer ):double;
var
  s:string;
  tsql:TmyQuery;
begin
  result := 0;
  s:='select brg_harga_min from tbarang where '
  + ' brg_kode='+ IntToStr(akodebarang) ;

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if fields[0].asfloat > 0 then
       result := fields[0].asfloat;
   finally
     Free;
   end;
  end;
end;

function TfrmFP.getlastcost(akodebarang : Integer ; atanggal:TDateTime ; anomordo :string ):double;
var
  s:string;
  tsql:TmyQuery;
begin
  result := 0;
  s:='select mst_hargabeli from tmasterstok where '
  + ' mst_brg_kode='+ IntToStr(akodebarang)
  + ' and mst_expired_date = ' + QuotD(atanggal)
  + ' and mst_noreferensi = ' + Quot(anomordo) ;

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if not Eof then
       result := fields[0].asfloat;
   finally
     Free;
   end;
  end;
end;

function TfrmFP.getnilairetur2(anomor:String):double;
var
  s:string;
  tsql:TmyQuery;
begin
  result := 0;
  s:='select sum(retj_amount) from tretj_hdr  where retj_fp_nomor = '+ Quot(anomor) ;
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


procedure TfrmFP.clDiscPropertiesValidate(Sender: TObject;
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

function TfrmFP.ambildiscsales(akodebrg:string):double;
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


function TfrmFP.cekcetak(anomor:string):Boolean;
var
  s:string;
begin
  result :=false;
  s:='select fp_nomor from tfp_hdr where fp_iscetak = 1 and fp_nomor ='+ Quot(anomor) ;

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if not eof then
         Result := True;

    finally
      free;
    end;
  end;
end;

function TfrmFP.cekdolama(abulan : Integer ; atahun : Integer):Boolean;
var
  s:string;
begin
  result :=false;
  s:='select * from tdo_hdr where (do_isinvoice = 0  and month(do_tanggal) < '+ IntToStr(abulan)
    + '  and year(do_tanggal) = ' + IntToStr(atahun)+ ' ) or (do_isinvoice=0 and year(do_tanggal)  < ' + IntToStr(atahun)+ ' )';

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if not eof then
         Result :=true;

    finally
      free;
    end;
  end;
end;

procedure TfrmFP.clHargaPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aharga:Double;
  s:string;
  tsql:TmyQuery;
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
      ShowMessage('Harga ini terlalu kecil ');
      error := False;
    end;

end;


procedure TfrmFP.doslip3(anomor : string );
var
  s: string ;
  tsql2,tsql : TmyQuery;
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
       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(fp_amount) terbilang ,'
       + ' ((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett ,cus_top top'
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
                          +StrPadRight(fieldbyname('FPd_brg_kode').AsString, 12, ' ')+' '
                          +StrPadRight(anamabarang, 40, ' ')+' '
                          +StrPadRight(fieldbyname('FPd_brg_satuan').AsString, 10, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('fpd_qty').Asfloat), 10, ' ')+' '
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

END;

function TfrmFP.getminimalmargin(akodebarang : Integer ):double;
var
  s,s2:string;
  tsql,tsql2:TmyQuery;
begin
  result := 0;

    s2:='select * from tbarangkhusus where brg_kode='+ IntToStr(akodebarang);
    tsql2 := xOpenQuery(s2,frmMenu.conn) ;
    with tsql2 do
    begin
      try
        if not Eof then
           exit ;
      finally
        free;
      end;
    end;

    s:='select SET_TGL from tsetting where '
    + ' set_kode="MRG"' ;

    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
     try
       if not Eof then
         result := fields[0].asfloat;
     finally
       Free;
     end;
    end;

end;

procedure TfrmFP.doslip22(anomor : string );
var
  s: string ;
  tsqlheader,tsql2,tsql : TMyQuery;
  abaris,i,a:Integer;
  arekening,anamabarang,TERBILANG : String;
  anilaipiutang:double;
  afreight,adiscfaktur,adp,atotal,anilai,appn : Double;
  apj,apjno : string;

begin

 Application.CreateForm(TfrmCetak,frmCetak);
 abaris := getbarisslip('FP');
 with frmCetak do
 begin
    memo.Clear;
      memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp,perush_pak '
      + ' from tperusahaan ';

  tsqlheader := xOpenQuery(s, frmMenu.conn);
  with tsqlheader do
  begin
    try
      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString ,60, ' '));
//      memo.lines.add(StrPadRight(Fields[3].AsString, 60, ' '));
//      memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 60, ' '));
//      memo.lines.add('PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));

    finally

    end;
  end;

      s:= ' select '
       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(fp_amount) terbilang ,'
       + ' ((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett ,cus_top top,'
       + ' (select cbg_rekening from tcabang where cbg_aktif=1) Rekening '
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
          anilai := fieldbyname('FP_amount').AsFloat-fieldbyname('FP_taxamount').AsFloat-fieldbyname('FP_freight').AsFloat;
          appn := fieldbyname('FP_taxamount').AsFloat;
          atotal := fieldbyname('FP_amount').AsFloat;
          afreight := fieldbyname('FP_freight').AsFloat;
          adp :=fieldbyname('FP_dp').AsFloat;
          arekening := fieldbyname('rekening').asstring;
          adiscfaktur :=  ((fieldbyname('FP_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('FP_disc_faktur').asfloat;
      memo.lines.add('Telp : ' + StrPadRight(tsqlheader.Fields[3].AsString, 32, ' ')+StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 35, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 45, ' '));
      memo.Lines.Add('NPWP : ' + StrPadRight(tsqlheader.Fields[4].AsString, 32, ' ')+StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 35, ' ')+ ' ' + StrPadRight(copy(fieldbyname('cus_alamat').AsString,1,40), 45, ' '));
      if fieldbyname('top').asinteger > 30 then
      memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime+30), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '))
      else
      memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '));
      memo.lines.add(StrPadRight('', 39, ' ')+ StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 36, ' ')+ StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 20, ' '));
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
           s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp , PERUSH_PAK'
          + ' from tperusahaan ';

            tsql2 := xOpenQuery(s, frmMenu.conn);
            with tsql2 do
            begin
              try
                memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
                memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
//                memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 30, ' ')+ ' PAK : ' + StrPadRight(Fields[5].AsString, 60, ' '));
//                memo.Lines.Add('');
              finally
                Free;
              end;
            end;
//            memo.Lines.Add(StrPadcenter('S A L E S   O R D E R ', 120, ' '));
          memo.lines.add('Telp : ' + StrPadRight(tsqlheader.Fields[3].AsString, 32, ' ')+StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 35, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 45, ' '));
          memo.Lines.Add('NPWP : ' + StrPadRight(tsqlheader.Fields[4].AsString, 32, ' ')+StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 35, ' ')+ ' ' + StrPadRight(copy(fieldbyname('cus_alamat').AsString,1,40), 45, ' '));
          if fieldbyname('top').asinteger > 30 then
          memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime+30), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '))
          else
          memo.Lines.Add('PAK  : ' + StrPadRight(tsqlheader.Fields[5].AsString, 32, ' ')+StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 36, ' ')+ StrPadRight(copy(fieldbyname('cus_alamat').AsString,41,40), 45, ' '));
          memo.lines.add(StrPadRight('', 39, ' ')+ StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 36, ' ')+ StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 20, ' '));

//      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
//      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 60, ' '));

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
                          +StrPadRight('Total     :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
                           + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
                          );

    memo.Lines.Add(StrPadRight('Mohon Pembayaran ditransfer ke BANK SYARIAH INDONESIA ', 82, ' ')
                  +StrPadRight('Freight       :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' '));
    memo.Lines.Add(StrPadRight('Norek : '+arekening, 82, ' ')
                  +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' '));

    memo.Lines.Add(StrPadRight('A/n   : PT Entri Jaya Makmur', 82, ' '));



    memo.Lines.Add('');

    memo.Lines.Add(
    StrPadRight('  Disiapkan', 20, ' ')
    +StrPadRight('   Diantar', 25, ' ')
    +StrPadRight('   Diterima', 25, ' '));
    memo.Lines.Add('');
    memo.Lines.Add('');
          memo.Lines.Add(
                          StrPadRight('(               )', 20, ' ')
                          +StrPadRight('(              )', 22, ' ')
                          +StrPadRight('(              )', 22, ' ')
                          +StrPadRight('', 30, ' ')
                          );
//          memo.Lines.Add(  StrPadRight('                 ', 20, ' ')
//                          +StrPadRight('PJ:'+apj, 35, ' '));
       memo.Lines.Add(
                          StrPadRight('                 ', 20, ' ')
                          +StrPadRight('               ', 25, ' ')
                          +StrPadRight('', 30, ' '));
//       memo.Lines.Add('Note : Retur barang maksimal 7 (tujuh) hari (konfirmasi terlebih dahulu)');

    nomor :=anomor;
    memo.Lines.Add('');
    memo.Lines.Add('');




  finally
    tsqlheader.free;
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;

procedure TfrmFP.doslipbatch(anomor : string );
var
  s: string ;
  tsql2,tsql : TmyQuery;
  abaris,i,a:Integer;
  arekening,anamabarang,TERBILANG : String;
  anilaipiutang:double;
  afreight,adiscfaktur,adp,atotal,anilai,appn : Double;
 apj,apjno : string;
 aistax:integer;
begin

   if not cekcetak(anomor) then
 begin
   s:='update tfp_hdr set fp_iscetak=1 where fp_nomor = '+ Quot(anomor);
     EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, s);
   
 end
 else
 begin
      if MessageDlg('Sudah pernah di cetak ,Yakin ingin cetak lagi ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

 end;

    Application.CreateForm(TfrmCetak,frmCetak);
    abaris := getbarisslip('FP');
 with frmCetak do
 begin
    memo.Clear;
      memo.Lines.Add('');

       s := 'select perush_nama, perush_alamat , perush_kota , perush_NOtelp,perush_npwp,perush_pak,perush_pj,perush_pj_no'
      + ' from tperusahaan ';

  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
    try
      memo.Lines.Add(StrPadRight(Fields[0].AsString , 79 , ' ')+ ' '+StrPadRight(' F A K T U R   P E N J U A L A N ', 40 , ' '));
      memo.Lines.Add(StrPadRight(Fields[1].AsString+ ' ' + Fields[3].AsString, 120, ' '));
      memo.Lines.Add('NPWP : ' + StrPadRight(Fields[4].AsString, 120, ' '));
      apj :=Fields[6].AsString;
      apjno := Fields[7].AsString;

    finally
      Free;
    end;
  end;

      s:= ' select '
       + ' *,if(fpd_nourut is null ,1000,fpd_nourut) nourut ,terbilang(if(fp_isdtp=0,fp_amount,fp_amount-fp_taxamount)) terbilang ,'
       + ' ((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100 nett ,cus_top top,'
       + ' (select cbg_rekening from tcabang where cbg_aktif=1) Rekening '
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
          if FieldByName('fp_isdtp').AsInteger = 0 then
          begin
           appn := fieldbyname('FP_taxamount').AsFloat;
           atotal := fieldbyname('FP_amount').AsFloat;
          end
          else
          begin
           appn := 0;
           atotal := anilai+fieldbyname('FP_freight').AsFloat;
          end;
          afreight := fieldbyname('FP_freight').AsFloat;
          arekening :=fieldbyname('rekening').AsString;
          adp :=fieldbyname('FP_dp').AsFloat;
          aistax := fieldbyname('FP_istax').AsInteger;
          adiscfaktur :=  ((fieldbyname('FP_disc_fakturpr').asfloat*fieldbyname('nett').asfloat)/100) + fieldbyname('FP_disc_faktur').asfloat;
      memo.Lines.Add(StrPadRight('Nomor      : '+fieldbyname('FP_nomor').AsString, 60, ' ')+ ' ' + StrPadRight('Customer : '+ fieldbyname('cus_nama').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Tanggal    : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_tanggal').AsDateTime), 60, ' ')+ ' ' + StrPadRight(fieldbyname('cus_alamat').AsString, 60, ' '));
      memo.Lines.Add(StrPadRight('Jth Tempo  : '+FormatDateTime('dd/mm/yyyy',fieldbyname('FP_jthtempo').AsDateTime), 60, ' ')+ ' ' + StrPadRight('Salesman : '+ fieldbyname('sls_nama').AsString, 30, ' ')+' ' + StrPadRight('Memo : '+ fieldbyname('fp_memo').AsString, 28, ' '));

      memo.Lines.Add(StrPadRight('', 120, '-'));
      memo.Lines.Add(StrPadRight('No', 3, ' ')+' '
                          +StrPadRight('Kode', 8, ' ')+' '
                          +StrPadRight('Nama', 44, ' ')+' '
                          +StrPadRight('ID Batch', 10, ' ')+' '
                          +StrPadRight('Satuan', 6, ' ')+' '
                          +StrPadLeft('Jumlah', 7, ' ')+' '
                          +StrPadLeft('Disc(%)', 8, ' ')+' '
                          +StrPadLeft('Harga', 13, ' ')+' '
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
                          +StrPadRight(fieldbyname('fpd_idbatch').AsString, 10, ' ')+' '
                          +StrPadRight(fieldbyname('fpd_brg_satuan').AsString, 6, ' ')+' '

                          +StrPadLeft(FormatFloat('##,###',fieldbyname('fpd_qty').Asfloat), 7, ' ')+' '
                          +StrPadLeft(FormatFloat('##,###.##',fieldbyname('fpd_discpr').Asfloat), 8, ' ')+' '
                          +StrPadLeft(FormatFloat('#,###,###.##',fieldbyname('fpd_harga').Asfloat), 13, ' ')+' '
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
                          +StrPadRight('Total     :', 15, ' ')+ ' '
                          + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
                          );
    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
                           + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
                          );
if (aistax > 0) then
begin
    memo.Lines.Add(StrPadRight('Mohon Pembayaran ditransfer ke BANK SYARIAH INDONESIA ', 82, ' ')
                  +StrPadRight('Freight       :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' '));
    memo.Lines.Add(StrPadRight('Norek : '+arekening, 82, ' ')
                  +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' '));

    memo.Lines.Add(StrPadRight('A/n   : PT Bumi Sarana Maju', 82, ' '));
end
else
begin
    memo.Lines.Add(StrPadRight('', 82, ' ')
                  +StrPadRight('Freight       :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' '));
    memo.Lines.Add(StrPadRight('', 82, ' ')
                  +StrPadRight('Grand Total   :', 15, ' ')+ ' '
                  + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' '));

    memo.Lines.Add(StrPadRight('', 82, ' '));
end;



    memo.Lines.Add('');

    memo.Lines.Add(
    StrPadRight('  Di cek Oleh', 20, ' ')
    +StrPadRight('      Disetujui', 35, ' ')
    +StrPadRight('   Diantar', 25, ' ')
    +StrPadRight('   Diterima', 25, ' ')
    +StrPadRight('* Retur Max 7 Hari ', 30, ' '));
    memo.Lines.Add('');
    memo.Lines.Add('');
          memo.Lines.Add(
                          StrPadRight('(               )', 20, ' ')
                          +StrPadRight('(PJ:'+apj+')', 35, ' ')+' '
                          +StrPadRight('(              )', 22, ' ')
                          +StrPadRight('(              )', 22, ' ')
                          +StrPadRight('', 30, ' ')
                          );
//          memo.Lines.Add(  StrPadRight('                 ', 20, ' ')
//                          +StrPadRight('PJ:'+apj, 35, ' '));
       memo.Lines.Add(
                          StrPadRight('                 ', 20, ' ')
                          +StrPadRight('  No:'+apjno+'', 35, ' ')+' '
                          +StrPadRight('               ', 25, ' ')
                          +StrPadRight('', 30, ' '));
//       memo.Lines.Add('Note : Retur barang maksimal 7 (tujuh) hari (konfirmasi terlebih dahulu)');

    nomor :=anomor;
    memo.Lines.Add('');
    memo.Lines.Add('');

//
//
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',1,80), 81, ' ')+' '
//                          +StrPadRight('Disc faktur   :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',adiscfaktur), 21, ' ')+ ' '
//                          );
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',81,160), 81, ' ')+' '
//                          +StrPadRight('Total         :', 15, ' ')+ ' '
//                           + StrPadLeft( FormatFloat('##,###,###.##',anilai), 21, ' ')+ ' '
//                          );
//    memo.Lines.Add(   StrPadRight(Copy('Terbilang : ' + TERBILANG + ' RUPIAH',161,240), 81, ' ')+' '
//                          +StrPadRight('Ppn           :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',appn), 21, ' ')+ ' '
//                          );
//     memo.Lines.Add(      StrPadRight('  Disiapkan', 25, ' ')+' '
//                          +StrPadRight(' Disetujui,', 25, ' ')+' '
//                          +StrPadRight(' Penerima,', 30, ' ')
//
//                          +StrPadRight('Freight      :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',afreight), 21, ' ')+ ' '
//                          );
////
////                          anilaipiutang :=atotal-
////                          StrToFloat(StringReplace(getdebet(anomor),',','',[rfReplaceAll]));
////      memo.Lines.Add(   StrPadRight('', 81, ' ')+' '
////                          +StrPadRight('DP        :', 15, ' ')+ ' '
////                          + StrPadLeft( FormatFloat('###,###,###',ADP), 21, ' ')+ ' '
////                          );
//     memo.Lines.Add(      StrPadRight('', 81, ' ')+' '
//                          +StrPadRight('Grand Total  :', 15, ' ')+ ' '
//                          + StrPadLeft( FormatFloat('##,###,###.##',atotal), 21, ' ')+ ' '
//                          );
//
////    memo.Lines.Add(
////                          );
//
//
//    memo.Lines.Add('');
//          memo.Lines.Add(  StrPadRight('(               )', 25, ' ')
//                          +StrPadRight('(               )', 25, ' ')+' '
//                          +StrPadRight('(               )', 30, ' ')
//                          );
//       memo.Lines.Add('');
//
//    nomor :=anomor;

  finally
     free;
  end
  end;
  end;
    frmCetak.ShowModal;
END;
end.
