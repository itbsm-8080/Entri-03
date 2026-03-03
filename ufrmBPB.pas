unit ufrmBPB;

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
  dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, MyAccess;

type
  TfrmBPB = class(TForm)
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
    edtNomorPO: TAdvEditBtn;
    cxLookupGudang: TcxExtLookupComboBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    chkStokOpname: TCheckBox;
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
    procedure loaddatapo(akode : string);
    procedure loaddataall(akode : string);
    function getqtyPO(anomor:string;asku:integer): integer;
    function getstatusexpired(asku:integer): integer;
    function getqtyterima(anomor:string;asku:integer): integer;

    procedure Floa(Sender: TObject);
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure doslipBPB(anomor : string );
    procedure insertketampungan(anomor:string);
  private
    FCDSSupplier: TClientDataset;
    FCDSSKU : TClientDataset;
    FCDSGudang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    atanggalold : TDateTime;
    function GetCDSSupplier: TClientDataset;
    function GetCDSGudang: TClientDataset;



    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDSSupplier: TClientDataset read GetCDSSupplier write FCDSSupplier;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmBPB: TfrmBPB;
const
   NOMERATOR = 'RI';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmBPB.refreshdata;
begin
  FID:='';
  apajak:=1;
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;

  edtnomor.Text := getmaxkode(apajak);
  cxLookupsupplier.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  cxLookupGudang.EditValue := '';
  
  edtNomorPO.SetFocus;
  initgrid;

end;
procedure TfrmBPB.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmBPB.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmBPB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmBPB.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(bpb_nomor,4)) from tbpb_hdr inner join tpo_hdr on po_nomor=bpb_po_nomor where bpb_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and po_istax=1 ';
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
   s:='select max(right(bpb_nomor,3)) from tbpb_hdr inner join tpo_hdr on po_nomor=bpb_po_nomor where bpb_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
   + ' and po_istax=0 ';
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

procedure TfrmBPB.cxButton1Click(Sender: TObject);
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

procedure TfrmBPB.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmBPB.cxButton2Click(Sender: TObject);
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

procedure TfrmBPB.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupSupplier.Properties) do
    LoadFromCDS(CDSSupplier, 'Kode','supplier',['Kode'],Self);
     TcxExtLookupHelper(cxLookupSupplier.Properties).SetMultiPurposeLookup;

   with TcxExtLookupHelper(cxLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     initViewSKU;
end;

function TfrmBPB.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftFloat, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Sudah', ftFloat, False);
    zAddField(FCDS, 'Kurang', ftFloat, False);
    zAddField(FCDS, 'Expired', ftDate, False, 255);
    zAddField(FCDS, 'Closed', ftInteger, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmBPB.GetCDSSupplier: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSSupplier) then
  begin
    S := 'select sup_nama as supplier, sup_kode Kode, sup_alamat Alamat,sup_telp'
        +' from tsupplier';


    FCDSSupplier := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSSupplier;
end;

procedure TfrmBPB.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmBPB.cxLookupsupplierPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDSsupplier.Fields[2].AsString;

end;

procedure TfrmBPB.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmBPB.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan from Tbarang '
  + ' inner join tpo_dtl on pod_brg_kode=brg_kode and pod_po_nomor =' + Quot(edtNomorPO.Text);


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);
  

end;
procedure TfrmBPB.clQTYPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;
  
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
 
end;
procedure TfrmBPB.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmBPB.clSKUPropertiesEditValueChanged(Sender: TObject);
begin

 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;

end;

procedure TfrmBPB.clKetPropertiesValidate(Sender: TObject;
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


procedure TfrmBPB.dtTanggalChange(Sender: TObject);
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
end;


procedure TfrmBPB.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;

begin

if FLAGEDIT then
  s:='update Tbpb_HDR set '
    + ' bpb_gdg_kode = ' + Quot(cxLookupGudang.EditValue) + ','
    + ' bpb_memo = ' + Quot(edtmemo.Text) + ','
    + ' bpb_tanggal = ' + Quotd(dtTanggal.Date)+','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where bpb_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode(apajak);
  s :=  ' insert into Tbpb_HDR '
             + ' (bpb_nomor,bpb_tanggal,bpb_po_nomor,bpb_memo,bpb_gdg_kode,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(edtNomorPO.Text)+','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupgudang.EditValue) + ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from Tbpb_DTL '
      + ' where  bpbd_bpb_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('qty').AsInteger >  0 then
   begin
    S:='insert into tbpb_DTL (bpbd_bpb_nomor,bpbd_brg_kode,bpbd_brg_satuan,bpbd_qty,bpbd_tgl_expired,bpbd_nourut,bpbd_status) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + FloatToStr(CDS.FieldByName('QTY').asfloat) +','
      + quotd(CDS.FieldByName('expired').AsDateTime) +','
      + IntToStr(i)  +','
      + IntToStr(CDS.FieldByName('closed').AsInteger) 
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


function TfrmBPB.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
   If cxLookupGudang.EditValue = '' then
    begin
      ShowMessage('Gudang belum di pilih');
      result:=false;
      Exit;
    end;
     If cxLookupsupplier.EditValue = '' then
    begin
      ShowMessage('supplier belum di pilih');
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

procedure TfrmBPB.loaddataPO(akode : string);
var
  s: string ;
  tsql2,tsql : TMyQuery;
  i:Integer;
begin

//if chkStokOpname.Checked then
//    s:='select hitd_brg_kode,hitd_satuan,hitd_expired,sum(hitd_qty) qty,brg_hrgbeli from thitungstok_dtl inner join thitungstok on '
//          + ' hitd_hit_nomor=hit_nomor'
//          + ' inner join tbarang on brg_kode=hitd_brg_kode'
//          + ' where hit_gdg_kode ='+quot(cxLookupGudang.EditValue)
//          + ' group by hitd_brg_kode,hitd_satuan,hitd_expired';
//else
  s := ' select po_nomor,po_tanggal,po_sup_kode,po_istax,'
     + ' pod_brg_kode,pod_bRG_satuan,pod_qty,pod_qty_terima sudah,pod_qty-pod_qty_terima kurang,pod_isclosed'
     + ' from tpo_hdr a'
     + ' LEFT join tpo_dtl d on a.po_nomor=d.pod_po_nomor '
     + ' where a.po_nomor = '+ Quot(akode)
     + ' order by pod_nourut';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin

            edtNomorPO.Text   := fieldbyname('po_nomor').AsString;
            apajak := fieldbyname('po_istax').AsInteger;
            edtNomor.Text := getmaxkode(apajak);
            cxLookupsupplier.EditValue  := fieldbyname('po_sup_kode').AsString;

            i:=1;
             CDS.EmptyDataSet;
         if chkStokOpname.Checked then
         begin
            s:='select hitd_brg_kode,hitd_satuan,hitd_expired,sum(hitd_qty) qty,brg_hrgbeli from thitungstok_dtl inner join thitungstok on '
              + ' hitd_hit_nomor=hit_nomor'
              + ' inner join tbarang on brg_kode=hitd_brg_kode'
              + ' where hit_gdg_kode ='+quot(cxLookupGudang.EditValue)
              + ' group by hitd_brg_kode,hitd_satuan,hitd_expired';
            tsql2 := xOpenQuery(s,frmMenu.conn) ;
              try
                with tsql2 do
                begin
                  while  not Eof do
                  begin
                            CDS.Append;
                            CDS.FieldByName('SKU').AsInteger        := fieldbyname('hitd_brg_kode').AsInteger;
                            CDS.FieldByName('satuan').AsString      := fieldbyname('hitd_satuan').Asstring;
                            CDS.FieldByName('QTY').Asfloat        := fieldbyname('qty').Asfloat;
                            CDS.FieldByName('sudah').AsFloat        := 0;
                            CDS.FieldByName('kurang').AsFloat       := 0;
                            CDS.FieldByName('expired').AsDateTime   :=fieldbyname('hitd_expired').AsDateTime;
                            CDS.Post;
                         i:=i+1;
                         next;
                  end ;
                end;
              finally
                tsql2.free;
              end;

         end
         else
         begin
            while  not Eof do
            begin
                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('pod_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('pod_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsFloat        := fieldbyname('kurang').AsFloat;
                      CDS.FieldByName('sudah').AsFloat        := fieldbyname('sudah').AsFloat;
                      CDS.FieldByName('kurang').AsFloat       := fieldbyname('kurang').AsFloat;
                      cds.fieldbyname('closed').AsInteger     := fieldbyname('pod_isclosed').AsInteger;
                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
         end;
        end
        else
        begin
          ShowMessage('Nomor po tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;                            
   end;

end;

procedure TfrmBPB.Floa(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT PO_NOMOR Nomor,PO_TANGGAL Tanggal,SUP_NAMA Supplier from tpo_hdr '
            + ' inner join tsupplier on sup_kode=po_sup_kode where po_isclosed=0';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtnomorPO.Text := varglobal;
  loaddatapo(edtNomorPO.Text);
  initViewSKU;
end;

function TfrmBPB.GetCDSGudang: TClientDataset;
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


procedure TfrmBPB.loaddataall(akode : string);
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
  s := ' select BPB_NOMOr,bpb_tanggal,po_nomor,bpb_memo,po_sup_kode,bpb_gdg_kode,'
     + ' bpbd_brg_kode,bpbd_bRG_satuan,bpbd_qty,bpbd_tgl_expired,bpbd_status,po_istax'
     + ' from tbpb_hdr inner join tpo_hdr a on bpb_po_nomor=po_nomor'
     + ' inner join tbpb_dtl on bpbd_bpb_nomor=bpb_nomor'

     + ' where bpb_nomor = '+ Quot(akode)
     + ' order by bpbd_nourut ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('bpb_nomor').AsString;
            apajak := fieldbyname('po_istax').AsInteger;
            edtnomor.Text := fieldbyname('bpb_nomor').AsString;
            edtNomorpo.Text   := fieldbyname('po_nomor').AsString;
            dttanggal.DateTime := fieldbyname('bpb_tanggal').AsDateTime;
            atanggalold := fieldbyname('bpb_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('bpb_memo').AsString;
            cxLookupsupplier.EditValue  := fieldbyname('po_sup_kode').AsString;
            cxLookupGudang.EditValue := fieldbyname('bpb_gdg_kode').AsString;
                initViewSKU;
            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                        aketemu:=False;
                        for a := 0 to cxGrdMain.DataController.RecordCount-1 do
                        begin
                          If (cVarToInt(cxGrdMain.DataController.Values[a, clSKU.Index]) = fieldbyname('bpbd_brg_kode').AsInteger) and (cxGrdMain.DataController.FocusedRecordIndex <> a) then
                          begin
                            aketemu := True;
                          end;
                        end;
                        if not aketemu then
                        begin
                          aqtypo :=  getqtypo(fieldbyname('po_nomor').AsString,fieldbyname('bpbd_brg_kode').AsInteger);
                          qtyterima := getqtyterima(fieldbyname('po_nomor').AsString,fieldbyname('bpbd_brg_kode').AsInteger);
                        end;

                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('bpbd_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('bpbd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').Asfloat        := fieldbyname('bpbd_qty').Asfloat;
                      CDS.FieldByName('sudah').AsInteger        := qtyterima-fieldbyname('bpbd_qty').AsInteger;
                      CDS.FieldByName('kurang').AsInteger        := aqtypo-qtyterima+fieldbyname('bpbd_qty').AsInteger;

                      CDS.FieldByName('expired').AsDateTime := fieldbyname('bpbd_tgl_expired').AsDateTime;
                      CDS.FieldByName('closed').AsInteger  :=  fieldbyname('bpbd_status').AsInteger;

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

function TfrmBPB.getqtyPO(anomor:string;asku:integer): integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result :=0;
  s:='select pod_qty from tpo_dtl where pod_po_nomor ='+Quot(anomor)
   + ' and pod_brg_kode='+inttostr(asku) ;
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

function TfrmBPB.getstatusexpired(asku:integer): integer;
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

function TfrmBPB.getqtyterima(anomor:string;asku:integer): integer;
var
  s:string  ;
  tsql:TMyQuery  ;
begin
  Result :=0;
  s:='select pod_qty_terima from tpo_dtl where pod_po_nomor ='+Quot(anomor)
   + ' and pod_brg_kode='+inttostr(asku) ;
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

procedure TfrmBPB.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aqtykurang,aqtylain:integer;
begin
  aqtylain := 0;
  aqtykurang :=0;
    for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin
      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = (cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index])))
      and (cxGrdMain.DataController.FocusedRecordIndex <> i) then
      begin
        aqtylain  := aqtylain + cVarToInt(cxGrdMain.DataController.Values[i, clQTY.Index]);
      end;
      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = (cVarToInt(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index]))) then
      begin
        aqtykurang :=aqtykurang++ cVarToInt(cxGrdMain.DataController.Values[i, clKurang.Index]);
      end;
    end;
    if cVarToInt(DisplayValue)+aqtylain > aqtykurang then
    begin
      error := true;
        ErrorText :='Qty melebihi qty kurang';
        exit;
    end;

end;

procedure Tfrmbpb.doslipBPB(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'BPB';

          s:= ' select '
       + ' *,if(bpbd_nourut is null ,1000,bpbd_nourut) nourut '
       + ' from tbpb_hdr '
       + ' inner join tpo_hdr on po_nomor=bpb_po_nomor'
       + ' inner join tampung on nomor=bpb_nomor '
       + ' inner join tsupplier on po_sup_kode=sup_kode '
       + ' inner join tgudang on gdg_kode=bpb_gdg_kode '
       + ' left join  tbpb_dtl on bpb_nomor=bpbd_bpb_nomor and tam_nama = bpbd_brg_kode and bpbd_tgl_expired=expired'
       + ' left join tbarang on bpbd_brg_kode=brg_kode '
       + ' where '
       + ' bpb_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure Tfrmbpb.insertketampungan(anomor:string);
var
  s:string;
  tsql : TMyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=14;
  s:='delete from tampung ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  s := 'select bpbd_brg_kode,bpbd_tgl_expired from tbpb_dtl where bpbd_bpb_nomor =' + Quot(anomor) ;
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
                  + Quot(Fields[0].Asstring)+ ','
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


end.
