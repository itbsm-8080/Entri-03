unit ufrmInvoice;

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
  TfrmInvoice = class(TForm)
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
    cxLookupSupplier: TcxExtLookupComboBox;
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
    edtNomorBPB: TAdvEditBtn;
    chkPajak: TCheckBox;
    edtDiscpr: TAdvEdit;
    edtDisc: TAdvEdit;
    edtPPN: TAdvEdit;
    edtTotal: TAdvEdit;
    edtDiscFaktur: TAdvEdit;
    clHarga: TcxGridDBColumn;
    clDisc: TcxGridDBColumn;
    Label15: TLabel;
    edtFreight: TAdvEdit;
    Label16: TLabel;
    edtNobukti: TAdvEdit;
    clOtorisasi: TcxGridDBColumn;
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
    procedure cxLookupsupplierPropertiesChange(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);

    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataBPB(akode : string);
    procedure loaddataall(akode : string);
    procedure hitung;
    procedure initViewSKU;

    procedure edtNomorBPBClickBtn(Sender: TObject);
    procedure edtDiscprExit(Sender: TObject);
    procedure edtDiscExit(Sender: TObject);
    procedure clDiscPropertiesChange(Sender: TObject);
    procedure doslipInv(anomor : string );
    procedure insertketampungan(anomor:string);
    procedure clHargaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  function gettop(akode:String):integer;
    procedure edtFreightExit(Sender: TObject);
    procedure edtNobuktiExit(Sender: TObject);
    function cekLastCost(akode:integer;anilai:Double):boolean;
    function gettoleransihbl:Double;
  private
    FCDSSupplier: TClientDataset;
    FCDSSKU : TClientDataset;

    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    atanggalold:TDateTime;
    function GetCDSSupplier: TClientDataset;




    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDSSupplier: TClientDataset read GetCDSSupplier write FCDSSupplier;

    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmInvoice: TfrmInvoice;
const
   NOMERATOR = 'INV';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ureport,UfrmOtorisasi;

{$R *.dfm}

procedure TfrmInvoice.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  dtTglJT.DateTime := Date;
  chkPajak.Checked := true;
  edtnomor.Text := getmaxkode(1);
  cxLookupsupplier.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  edtNobukti.Clear;
  edtFreight.Text := '0';
  edtDiscpr.Text := '0';
  edtPPN.Text := '0';
  edtTotal.Text := '0';
  edtDisc.Text := '0';
  edtDiscFaktur.Text := '0';

  edtNomorBPB.SetFocus;
  initgrid;

end;
procedure TfrmInvoice.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmInvoice.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmInvoice.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmInvoice.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(inv_nomor,4)) from tINV_hdr '
  + ' where inv_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and inv_istax=1 ';
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
  end
  else
  begin
    s:='select max(right(inv_nomor,3)) from tINV_hdr '
  + ' where inv_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and inv_istax=0 ';

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+1),4)
      else
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
  end;
end;

procedure TfrmInvoice.cxButton1Click(Sender: TObject);
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

procedure TfrmInvoice.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmInvoice.cxButton2Click(Sender: TObject);
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

procedure TfrmInvoice.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupSupplier.Properties) do
    LoadFromCDS(CDSSupplier, 'Kode','supplier',['Kode'],Self);
     TcxExtLookupHelper(cxLookupSupplier.Properties).SetMultiPurposeLookup;



     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmInvoice.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftFloat, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Harga', ftFloat, False);
    zAddField(FCDS, 'Disc', ftFloat, False);
    zAddField(FCDS, 'Total', ftFloat, False);
    zAddField(FCDS, 'expired', ftDate, False, 255);
    zAddField(FCDS, 'otorisasi', ftInteger, False);    
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmInvoice.GetCDSSupplier: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSSupplier) then
  begin
    S := 'select sup_nama as supplier, sup_kode Kode, sup_alamat Alamat,sup_telp'
        +' from tsupplier order by sup_nama';


    FCDSSupplier := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSSupplier;
end;

procedure TfrmInvoice.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmInvoice.cxLookupsupplierPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDSsupplier.Fields[2].AsString;

end;

procedure TfrmInvoice.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmInvoice.clSKUPropertiesEditValueChanged(Sender: TObject);
begin

 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;

end;

procedure TfrmInvoice.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmInvoice.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
  anomorold := edtNomor.Text;
  anomornew := getmaxkode(apajak);
  if FLAGEDIT then
  begin
    if Copy(anomornew,1,9) <> Copy(anomorold,1,9)then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.Date :=atanggalold;
    end;
  end;

   dtTglJT.DateTime :=  dtTanggal.DateTime+getTop(cxLookupSupplier.EditValue);
end;


procedure TfrmInvoice.simpandata;
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
  s:='update TInv_HDR set '
    + ' Inv_sup_kode = ' + Quot(cxLookupsupplier.EditValue) + ','
    + ' inv_bpb_nomor =' +Quot(edtNomorBPB.Text)+','
    + ' Inv_memo = ' + Quot(edtmemo.Text) + ','
    + ' inv_nobukti = ' + Quot(edtnobukti.Text)+','
    + ' Inv_disc_faktur =' + floattostr(cStrToFloat(edtDisc.Text))+ ','
    + ' Inv_disc_fakturpr = '+ floattostr(cStrToFloat(edtDiscpr.Text))+ ','
    + ' Inv_amount = '+ floattostr(cstrtoFloat(edtTotal.Text))+ ','
    + ' Inv_taxamount = '+ floattostr(cStrToFloat(edtPPN.Text))+ ','
    + ' Inv_istax = ' + IntToStr(aistax)+  ','
    + ' inv_jthtempo='+ quotd(dttGLjt.datetime)+','
    + ' inv_freight = ' +  floattostr(cStrToFloat(edtFreight.Text))+ ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where Inv_nomor = ' + quot(FID) + ';'
else
begin

  edtNomor.Text := getmaxkode(aistax);
  s :=  ' insert into TInv_HDR '
             + ' (Inv_nomor,inv_bpb_nomor,inv_nobukti,Inv_tanggal,inv_jthtempo,Inv_memo,Inv_sup_kode,Inv_disc_faktur,'
             + ' Inv_disc_fakturpr,Inv_amount,Inv_taxamount,Inv_istax,inv_freight,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quot(edtNomorBPB.Text)+','
             + Quot(edtNobukti.Text) +','
             + Quotd(dtTanggal.Date) + ','
             + quotd(dttGLjt.datetime)+','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupsupplier.EditValue) + ','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + IntToStr(aistax)+  ','
            +   floattostr(cStrToFloat(edtFreight.Text))+ ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from tinv_dtl '
      + ' where  invd_inv_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
   begin
    S:='insert into tinv_dtl (invd_inv_nomor,invd_brg_kode,invd_brg_satuan,invd_qty,invd_discpr,invd_harga,invd_nourut,invd_otorisasi,invd_expired) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + FloatToStr(CDS.FieldByName('QTY').AsFloat) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('DISC').AsFloat))+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('harga').AsFloat))+','
      + IntToStr(i)  +','
      + IntToStr(CDS.FieldByName('otorisasi').AsInteger) +','
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


function TfrmInvoice.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
     If cxLookupsupplier.EditValue = '' then
    begin
      ShowMessage('supplier belum di pilih');
      result:=false;
      Exit;
    end;
  CDS.First;
  While not CDS.Eof do
  begin

    if (CDS.FieldByName('otorisasi').AsInteger <> 1) and
    (not ceklastcost(CDS.FieldByName('SKU').AsInteger,(100 - CDS.FieldByName('Disc').AsFloat)/100*CDS.FieldByName('Harga').AsFloat)) then
    begin
      if MessageDlg('Net Harga Beli Baris : ' + inttostr(i) + ' Berubah',mtCustom,
                            [mbYes,mbNo], 0)= mrNo then
       begin
              result:=false;
              Exit;
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

procedure TfrmInvoice.loaddataBPB(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin


  s := ' select bpb_nomor,bpb_tanggal,po_sup_kode,po_istax,sup_top,'
     + ' po_DISC_faktur,po_disc_fakturpr,po_istax,pod_keterangan,'
     + ' bpbd_brg_kode,bpbd_bRG_satuan,bpbd_qty,bpbd_tgl_expired expired,'
     + ' pod_harga,pod_discpr,(bpbd_qty*pod_harga*(100-pod_discpr)/100) nilai'
     + ' from tbpb_hdr inner join tpo_hdr a on bpb_po_nomor = po_nomor'
     + ' inner join tbpb_dtl on bpbd_bpb_nomor = bpb_nomor '
     + ' inner join tsupplier on sup_kode =po_sup_kode '
     + ' LEFT join tpo_dtl d on a.po_nomor=d.pod_po_nomor  and bpbd_brg_kode = pod_brg_kode  '
     + ' where bpb_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin

            edtNomorBPB.Text   := fieldbyname('bpb_nomor').AsString;
            apajak := fieldbyname('po_istax').AsInteger;
            if apajak = 1 then
               chkpajak.Checked := True
            else
               chkpajak.Checked := false;

            edtNomor.Text := getmaxkode(apajak);
            cxLookupsupplier.EditValue  := fieldbyname('po_sup_kode').AsString;
            edtDiscpr.Text := fieldbyname('po_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('po_disc_faktur').AsString;
            dtTglJT.DateTime := dtTanggal.DateTime+fieldbyname('sup_top').AsInteger;
            i:=1;
            initViewSKU;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('bpbd_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('bpbd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsFloat        := fieldbyname('bpbd_qty').AsFloat;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('pod_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('pod_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('expired').AsDateTime;
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

procedure TfrmInvoice.edtNomorBPBClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT bpb_NOMOR Nomor,bpb_TANGGAL Tanggal,SUP_NAMA Supplier from tbpb_HDR inner join tpo_hdr on po_nomor=bpb_po_nomor'
            + ' inner join tsupplier on sup_kode=po_sup_kode where bpb_isinvoice=0';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtNomorBPB.Text := varglobal;
  loaddataBPB(edtNomorBPB.Text);
end;



procedure TfrmInvoice.loaddataall(akode : string);
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
  s := ' select inv_NOMOr,inv_nobukti,inv_tanggal,bpb_nomor,inv_memo,po_sup_kode,inv_istax,inv_jthtempo,'
     + ' invd_brg_kode,invd_bRG_satuan,invd_qty,invd_harga,invd_discpr,(invd_qty*invd_harga*(100-invd_discpr)/100) nilai,'
     + ' invd_expired,inv_disc_faktur,inv_disc_fakturpr,inv_freight '
     + ' from tinv_hdr inner join tbpb_hdr on bpb_nomor =inv_bpb_nomor '
     + ' inner join tpo_hdr a on bpb_po_nomor=po_nomor'
     + ' inner join tinv_dtl on invd_inv_nomor=inv_nomor'
     + ' where inv_nomor = '+ Quot(akode)
     + ' order by invd_nourut ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            apajak :=fieldbyname('inv_istax').AsInteger;
            if apajak =1 then
               chkPajak.Checked := True
            else
               chkPajak.Checked := False;
            FID :=fieldbyname('inv_nomor').AsString;
            edtnomor.Text := fieldbyname('inv_nomor').AsString;
            edtNobukti.Text := fieldbyname('inv_nobukti').AsString;
            edtNomorBPB.Text   := fieldbyname('bpb_nomor').AsString;
            dttanggal.DateTime := fieldbyname('inv_tanggal').AsDateTime;
            dtTglJT.DateTime :=  fieldbyname('inv_jthtempo').AsDateTime;
            atanggalold:= fieldbyname('inv_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('inv_memo').AsString;
            cxLookupsupplier.EditValue  := fieldbyname('po_sup_kode').AsString;
            edtDiscpr.Text :=fieldbyname('inv_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('inv_disc_faktur').AsString;
            edtFreight.Text := fieldbyname('inv_freight').AsString;
            initViewSKU;
            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;


                     CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('invd_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('invd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsFloat        := fieldbyname('invd_qty').AsFloat;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('invd_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('invd_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('invd_expired').AsDateTime;

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

procedure TfrmInvoice.hitung;
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
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal+cStrToFloat(edtFreight.text));
    edtPPN.Text := '0';
  end;

end;


procedure TfrmInvoice.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan from Tbarang '
  + ' inner join tbpb_dtl on bpbd_brg_kode=brg_kode and bpbd_bpb_nomor =' + Quot(edtNomorbpb.Text);


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);
  

end;

procedure TfrmInvoice.edtDiscprExit(Sender: TObject);
begin
if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmInvoice.edtDiscExit(Sender: TObject);
begin
if edtDisc.Text = '' then
    edtDisc.Text :='0';
hitung;
end;

procedure TfrmInvoice.clDiscPropertiesChange(Sender: TObject);
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
  CDS.Post;
hitung;
end;


procedure TfrmInvoice.doslipInv(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'INV';

          s:= ' select '
       + ' *,if(invd_nourut is null ,1000,invd_nourut) nourut ,terbilang(inv_amount) terbilang '
       + ' from tinv_hdr '
       + ' inner join tampung on nomor=inv_nomor '
       + ' inner join tbpb_hdr on bpb_nomor=inv_bpb_nomor'
       + ' inner join tpo_hdr on po_nomor=bpb_po_nomor'
       + ' inner join tsupplier on po_sup_kode=sup_kode '
       + ' left join  tinv_dtl on inv_nomor=invd_inv_nomor and tam_nama = invd_brg_kode and invd_expired=expired'
       + ' left join tbarang on invd_brg_kode=brg_kode '
       + ' where '
       + ' inv_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmInvoice.insertketampungan(anomor:string);
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
  s := 'select invd_brg_kode,invd_expired from tinv_dtl where invd_inv_nomor =' + Quot(anomor) ;
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



procedure TfrmInvoice.clHargaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  sqlbantuan := 'select brg_nama Nama,invd_harga Harga,invd_discpr Disc,invd_expired Expired,'
                  + ' inv_tanggal Tanggal, invd_qty Qty from '
                  + ' tinv_dtl inner join tbarang on brg_kode=invd_brg_kode '
                  + ' inner join tinv_hdr on invd_inv_nomor=inv_nomor '
                  + ' where inv_nomor <> ' + Quot(edtNomor.Text)
                  + ' AND brg_kode = ' +  VarToStr(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index])
                  + ' and inv_sup_kode= ' + Quot(cxLookupSupplier.EditValue);

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  frmBantuan.btnOK.Visible := False;

   if varglobal <> '' then
   begin
     If CDS.State <> dsEdit then
         CDS.Edit;
      CDS.FieldByName('harga').asfloat := StrTofloat(varglobal1);
      cds.post;

   end;

end;

function TfrmInvoice.gettop(akode:String):integer;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select sup_top from tsupplier where sup_kode='+ Quot(akode) ;
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



procedure TfrmInvoice.edtFreightExit(Sender: TObject);
begin
hitung;
end;

procedure TfrmInvoice.edtNobuktiExit(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
begin
  s:='select inv_nobukti from tinv_hdr where inv_nobukti='+ Quot(edtNobukti.Text)+';';
  tsql:=xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
      begin
          if MessageDlg('Nomor bukti sudah ada,Yakin ingin Lanjut ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
          then
          begin
            edtNobukti.Clear;
            edtNobukti.SetFocus ;
          end;
      end;
    finally
      free;
    end;
  end;
end;

function TfrmInvoice.cekLastCost(akode:integer;anilai:Double):boolean;
var
  s:string;
  tsql :TMyQuery;
  abatashargalama : Double;
begin
  Result :=  True;
  s:='SELECT mst_hargabeli from tmasterstok where mst_noreferensi like "RI%" AND '
    + ' mst_brg_kode= ' + inttostr(akode)
    + ' ORDER BY mst_tanggal desc limit 1 ';
  tsql := xOpenQuery(s,frmMenu.conn);


  with tsql do
  begin
    try
      if not Eof then
      begin
        abatashargalama := gettoleransihbl/100*Fields[0].AsFloat;

        if ((Fields[0].AsFloat - anilai ) > abatashargalama ) or ((anilai-Fields[0].AsFloat) > abatashargalama ) then
        begin
          Result := False;
        end;
      end;
    finally
      free;
    end;
  end;


end;

function TfrmInvoice.gettoleransihbl:Double;
var
  s:string;
  tsql: TMyQuery;
begin

    s:='select SET_TGL from tsetting where '
    + ' set_kode="INV"' ;

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
end.
