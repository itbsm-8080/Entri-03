unit ufrmMutasiCabang2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  AdvPanel, AdvCGrid, BaseGrid,SqlExpr, DBAdvGrd, DB, DBClient, Provider,
  FMTBcd, RAWPrinter, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxSpinEdit, cxCalendar, Menus, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxButtonEdit, AdvEdBtn, MyAccess;

type
  TfrmMutasiCabang2 = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label4: TLabel;
    dttanggal: TDateTimePicker;
    AdvPanel3: TAdvPanel;
    Label1: TLabel;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    cxLookupCabangTujuan: TcxExtLookupComboBox;
    cxLookupCabangAsal: TcxExtLookupComboBox;
    edtNomor: TAdvEdit;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clSatuan: TcxGridDBColumn;
    clExpired: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    clKeterangan: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    Label6: TLabel;
    cxLookupGudang: TcxExtLookupComboBox;
    clharga: TcxGridDBColumn;
    Label3: TLabel;
    edtNomorMutasi: TAdvEditBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomorExit(Sender: TObject);
    procedure refreshdata;
    procedure simpandata;
    procedure loaddataall(akode : string);
    procedure doslipmutasi(anomor : string );
    function GetCDS: TClientDataSet;

    function getmaxkode:string;
    procedure FormCreate(Sender: TObject);
    procedure insertketampungan;
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    function cekdata:Boolean;

    procedure initgrid;
    procedure HapusRecord1Click(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: String);
    procedure cxLookupGudangAsalPropertiesEditValueChanged(
      Sender: TObject);
    procedure clQTYPropertiesEditValueChanged(Sender: TObject);
    procedure cxLookupGudangAsalPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure clSKUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure bantuansku;
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure edtNomorMutasiClickBtn(Sender: TObject);
    procedure loaddataMutasi(akode : string);
    private
     buttonSelected  : integer;
     FID : STRING;
     FCDSSKU : TClientDataset;
     FCDSGudang: TClientDataset;
     FCDSCabang: TClientDataset;
        FFLAGEDIT: Boolean;
     xtotal : Double;
         function GetCDSGudang: TClientDataset;
         function GetCDSCabang: TClientDataset;

         procedure initViewSKU;
      { Private declarations }
     protected
    FCDS: TClientDataSet;
  public
      property CDS: TClientDataSet read GetCDS write FCDS;
          property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
       property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
        property CDSCabang: TClientDataset read GetCDSCabang write FCDSCabang;
          property ID: string read FID write FID;
            property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    { Public declarations }
  end;
 const

    NOMERATOR = 'MTCI';

var
  frmMutasiCabang2: TfrmMutasiCabang2;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmMutasiCabang2.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmMutasiCabang2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmMutasiCabang2.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmMutasiCabang2.edtNomorExit(Sender: TObject);
begin
   edtNomor.Enabled := False;
   loaddataall(edtNomor.Text);
end;


procedure TfrmMutasiCabang2.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  dttanggal.DateTime := Date;
  edtnomormutasi.clear ;
  edtNomor.Text := getmaxkode;
   cxLookupCabangAsal.EditValue := frmMenu.KDCABANG;
   cxLookupCabangTujuan.EditValue := '';
   cxLookupGudang.EditValue := '';
   edtNomorMutasi.SetFocus;
  initgrid;
end;

procedure TfrmMutasiCabang2.simpandata;
var
  s:string;
  i:integer;
  tt : TStrings;
  anomor : string;
begin
   if flagedit then
   begin
   anomor := edtNomor.Text;
      s:= 'update tmutcabin_hdr set  '
         + ' mutci_tanggal = ' + QuotD(dttanggal.DateTime)+','
         + ' mutci_gdg_kode = ' + Quot(cxLookupGudang.EditValue)+','
         + ' mutci_cbg_asal = ' + Quot(cxLookupCabangAsal.EditValue)+','
         + ' mutci_cbg_tujuan = ' + Quot(cxLookupCabangTujuan.EditValue)+','
         + ' mutci_nomormutasi  = ' + Quot(edtNomorMutasi.Text) + ','
         + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
         + ' user_modified = ' + Quot(frmMenu.KDUSER)
         + ' where mutci_nomor = ' + Quot(edtNomor.Text) ;
   end
   else
   begin
     anomor := getmaxkode;
     edtNomor.Text := anomor;
      s:= ' insert into tmutcabin_hdr '
         + '( mutci_nomor,mutci_tanggal,mutci_nomormutasi,mutci_cbg_asal,mutci_cbg_tujuan,mutci_gdg_kode,date_create,user_create) values ( '
         + Quot(anomor) + ','
         + Quotd(dttanggal.DateTime)+','
          + Quot(edtNomorMutasi.Text) + ','
         + Quot(cxLookupCabangAsal.EditValue)+','
         + Quot(cxLookupCabangTujuan.EditValue)+','
         + Quot(cxLookupGudang.EditValue) + ','
         + QuotD(cGetServerTime,True) + ','
         + Quot(frmMenu.KDUSER)+')';
   end;
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   tt := TStringList.Create;
   s:= ' delete from tmutcabin_dtl '
      + ' where  mutcid_mutci_nomor =' + quot(FID) ;
   tt.Append(s);
   i:=1;
    CDS.First;
while not CDS.Eof do
  begin
   if (CDS.FieldByName('qty').AsInteger >  0) and (CDS.FieldByName('sku').AsInteger >  0) then
   begin
        s:='insert into tmutcabin_dtl '
          + ' (mutcid_mutci_nomor,mutcid_brg_kode,mutcid_qty,mutcid_harga,mutcid_keterangan,mutcid_expired,mutcid_nourut) values ( '
          +  Quot(anomor) + ','
          +  IntToStr(CDS.FieldByName('SKU').AsInteger) + ','
          +  IntToStr(CDS.FieldByName('qty').AsInteger) + ','
          + FloatToStr(CDS.FieldByName('harga').AsFloat) + ','
          +  Quot(CDS.FieldByName('keterangan').Asstring) + ','
          + QuotD(CDS.FieldByName('expired').Asdatetime) +','
          +  IntToStr(i)
          +');';
       tt.Append(s);
     end;
     CDS.next;
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
procedure TfrmMutasiCabang2.loaddataall(akode : string);
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
  s := ' select mutci_nomor,mutci_tanggal,mutci_nomormutasi,mutci_cbg_asal,gdg_nama,mutci_cbg_tujuan,'
     + ' mutcid_brg_kode,brg_nama,brg_satuan,mutcid_qty,mutcid_harga,mutcid_expired,mutci_gdg_kode,'
     + ' mutcid_keterangan'
     + ' from tmutcabin_hdr a'
     + ' inner join tmutcabin_dtl d on a.mutci_nomor=d.mutcid_mutci_nomor '
     + ' inner join tbarang b on d.mutcid_brg_kode = b.brg_kode '
     + ' left join tgudang on mutci_gdg_kode=gdg_kode '
     + ' where a.mutci_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('mutci_nomor').AsString;
            edtNomor.Text   := fieldbyname('mutci_nomor').AsString;
            dttanggal.DateTime := fieldbyname('mutci_tanggal').AsDateTime;
            edtNomorMutasi.Text := fieldbyname('mutci_nomormutasi').AsString;
             cxLookupCabangAsal.EditValue := fieldbyname('mutci_cbg_asal').AsString;
           cxLookupGudang.EditValue := fieldbyname('mutci_gdg_kode').AsString;
           cxLookupCabangTujuan.EditValue := fieldbyname('mutci_cbg_tujuan').AsString;
            i:=1;

             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;

                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('mutcid_brg_kode').AsInteger;
                      CDS.fieldbyname('NamaBarang').AsString  := fieldbyname('brg_nama').AsString;
                      CDS.fieldbyname('satuan').AsString  := fieldbyname('brg_satuan').AsString;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('mutcid_qty').AsInteger;
                      CDS.FieldByName('harga').AsFloat        := fieldbyname('mutcid_harga').AsFloat;
                      CDS.FieldByName('expired').AsDateTime := fieldbyname('mutcid_expired').AsDateTime;
                      CDS.FieldByName('keterangan').AsString  :=  fieldbyname('mutcid_keterangan').AsString;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;

        end
        else
        begin
          ShowMessage('Nomor Mutasi tidak di temukan');
          edtNomor.Enabled:= true;
          edtNomor.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;
end;


procedure TfrmMutasiCabang2.doslipmutasi(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan;
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'mutasi';

          s:= ' select '
       + ' *,(select gdg_nama from tgudang where gdg_kode=a.mutci_gdg_asal) asal ,'
       + ' (select gdg_nama from tgudang where gdg_kode=a.mutci_gdg_tujuan) tujuan'
       + ' from tmutcabin_hdr a '
       + ' inner join tampung e on e.nomor =a.mutci_nomor '
       + ' left join  tmutcabin_dtl b on mutci_nomor=mutcid_mutci_nomor and e.tam_nama=b.mutcid_brg_kode '
       + ' left join tbarang c on b.mutcid_brg_kode=c.brg_kode '
       + ' where '
       + ' a.mutci_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmMutasiCabang2.insertketampungan;
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
  s := 'select mutcid_BRG_kode from tmutcabin_dtl where mutcid_mutci_nomor =' + Quot(edtNomor.Text) ;
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
                  + Quot(edtnomor.Text) + ','
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
            + Quot(edtnomor.Text) + ','
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

function TfrmMutasiCabang2.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(mutci_nomor,4)) from tmutcabin_hdr  where mutci_nomor like ' + quot(frmMenu.kdcabang + '-' + NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%') ;

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' + NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= frmMenu.kdcabang + '-' + NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
end;


procedure TfrmMutasiCabang2.FormCreate(Sender: TObject);
begin
 with TcxExtLookupHelper(cxLookupCabangTujuan.Properties) do
    LoadFromCDS(CDSCabang, 'Kode','Cabang',['Kode'],Self);
  with TcxExtLookupHelper(cxLookupCabangAsal.Properties) do
    LoadFromCDS(CDSCabang, 'Kode','Cabang',['Kode'],Self);
   with TcxExtLookupHelper(cxLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
//     initViewSKU;
end;

function TfrmMutasiCabang2.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftString, False,255);
    zAddField(FCDS, 'NamaBarang', ftString, False,100);
    zAddField(FCDS, 'Satuan', ftString, False,10);
    zAddField(FCDS, 'QTY', ftInteger, False);
    zAddField(FCDS, 'expired', ftDate, False,255);
    zAddField(FCDS, 'Keterangan', ftString, False,255);
    zAddField(FCDS, 'harga', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmMutasiCabang2.GetCDSGudang: TClientDataset;
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

function TfrmMutasiCabang2.GetCDSCabang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSCabang) then
  begin
    S := 'select cbg_nama as Cabang, cbg_kode Kode '
        +' from tcabang';


    FCDSCabang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSCabang;
end;

 procedure TfrmMutasiCabang2.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan,mst_expired_date expired,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date ';

  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);

  with TcxExtLookupHelper(clSatuan.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','Satuan',['SKU','NamaBarang','expired'],Self);
    
end;

procedure TfrmMutasiCabang2.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmMutasiCabang2.cxButton2Click(Sender: TObject);
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

procedure TfrmMutasiCabang2.cxButton1Click(Sender: TObject);
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


function TfrmMutasiCabang2.cekdata:Boolean;
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
//    If edtNomorMutasi.Text = '' then
//    begin
//      ShowMessage('Nomor Mutasi belum di pilih');
//      result:=false;
//      Exit;
//    end;
     If cxLookupCabangTujuan.EditValue = '' then
    begin
      ShowMessage('Cabang Tujuan belum di pilih');
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



procedure TfrmMutasiCabang2.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.FIELDBYname('keterangan').asstring := '';
  CDS.Post;

end;



procedure TfrmMutasiCabang2.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmMutasiCabang2.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmMutasiCabang2.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmMutasiCabang2.clQTYPropertiesEditValueChanged(
  Sender: TObject);
begin
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
end;

procedure TfrmMutasiCabang2.cxLookupGudangAsalPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
     if (cxLookupCabangTujuan.EditValue = cxLookupCabangAsal.EditValue) then
     begin
       Error:= true;
       ErrorText:= 'Cabang Asal tidak boleh sama dengan gudang Tujuan';
     end;
end;

procedure TfrmMutasiCabang2.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
 bantuansku;

end;

procedure TfrmMutasiCabang2.bantuansku;
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
//     for i := 0 to cxGrdMain.DataController.RecordCount-1 do
//    begin
//
////      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = StrToInt(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
////       and (StrToDate(varglobal1)= cVarTodate(cxGrdMain.DataController.Values[i, clexpired.Index])) then
////      begin
////
////        ShowMessage('Sku dan expired ada yang sama dengan baris '+ IntToStr(i+1));
////        CDS.Cancel;
////        exit;
////      end;
//    end;
       If CDS.State <> dsEdit then
           CDS.Edit;

      CDS.FieldByName('sku').AsInteger := StrToInt(varglobal);
      CDS.FieldByName('expired').AsDateTime := strtodate(varglobal1);

       s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok,sum((mst_hargabeli*(mst_stok_in-mst_stok_out)))/sum(mst_stok_in-mst_stok_out) hargabeli from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
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
          CDS.FieldByName('harga').AsFloat := Fields[5].AsFloat;
        end
        else
          bantuansku;
        finally
          free;
      end;
    end;
  end;
end;


procedure TfrmMutasiCabang2.clSKUPropertiesEditValueChanged(
  Sender: TObject);
begin
   bantuansku
end;

procedure TfrmMutasiCabang2.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aqtystok:integer;
  s:string;
  tsql:TMyQuery;
begin
//  aqtystok:=0;
//  s:='select sum(mst_stok_in-mst_stok_out) stok from Tbarang '
//  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudang.EditValue))
//  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
//  + ' and mst_expired_date = ' + QuotD(CDS.Fieldbyname('expired').AsDateTime);
//
//    tsql := xOpenQuery(s,frmMenu.conn);
//    with tsql do
//    begin
//      try
//        if not Eof then
//          aqtystok := Fields[0].AsInteger;
//      finally
//          free;
//      end;
//    end;

//    if cVarToInt(DisplayValue)> aqtyStok then
//    begin
//      error := true;
//        ErrorText :='Qty melebihi Stok di Gudang';
//        exit;
//    end;

end;

procedure TfrmMutasiCabang2.edtNomorMutasiClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT MUTC_NOMOR Nomor,MUTC_TANGGAL Tanggal,b.CBG_NAMA Asal,c.cbG_nama Tujuan from tmutcab_hdr a '
            + ' inner join tcabang b on a.mutc_cbg_asal=b.cbg_kode'
            + ' inner join tcabang c on a.mutc_cbg_tujuaN=c.cbg_kode'
            + ' left join tmutcabin_hdr d on a.mutc_nomor=mutci_nomormutasi '
            + ' where mutci_nomor is null '
            + ' and a.mutc_cbg_tujuan = ' + Quot(frmMenu.KDCABANG);
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtNomorMutasi.Text := varglobal;
  loaddataMutasi(edtNomorMutasi.Text);

end;


procedure TfrmMutasiCabang2.loaddataMutasi(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin

 
  s := ' select *'
     + ' from tMUTCAB_hdr a'
     + ' inner join tmutcab_dtl b on a.mutc_nomor=b.mutcd_mutc_nomor'
     + ' inner join tbarang c on B.mutcd_brg_kode=c.brg_kode '
     + ' where a.mutc_nomor = '+ Quot(akode)
     + ' order by mutcd_nourut';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin

            edtNomorMutasi.Text   := fieldbyname('mutc_nomor').AsString;
            edtNomor.Text := getmaxkode;
            cxLookupCabangTujuan.EditValue := fieldbyname('mutc_cbg_tujuan').AsString;
            cxLookupCabangAsal.EditValue := fieldbyname('mutc_cbg_asal').AsString;
            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin


                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('mutcd_brg_kode').AsInteger;
                      CDS.FieldByName('namabarang').AsString       := fieldbyname('brg_nama').AsString;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('mutcd_qty').AsInteger;
                      CDS.FieldByName('harga').AsFloat        := fieldbyname('mutcd_harga').AsFloat;
                      CDS.FieldByName('expired').AsDateTime := fieldbyname('mutcd_expired').AsDateTime;
                      CDS.FieldByName('keterangan').AsString  :=  fieldbyname('mutcd_keterangan').AsString;
                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
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

end.
