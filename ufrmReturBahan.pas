unit ufrmReturBahan;

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
  cxGridCustomView, cxGrid, cxButtonEdit, AdvEdBtn, cxCurrencyEdit,
  MyAccess;

type
  TfrmReturBahan = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label4: TLabel;
    dttanggal: TDateTimePicker;
    AdvPanel3: TAdvPanel;
    Label3: TLabel;
    edtKeterangan: TAdvEdit;
    Label1: TLabel;
    RAWPrinter1: TRAWPrinter;
    cxLookupGudangAsal: TcxExtLookupComboBox;
    edtNomor: TAdvEdit;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clSatuan: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    clKeterangan: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clgudang: TcxGridDBColumn;
    Label5: TLabel;
    edtNomorSpk: TAdvEditBtn;
    Label6: TLabel;
    edtnama: TAdvEdit;
    Label7: TLabel;
    edtnamabarang: TAdvEdit;
    Label8: TLabel;
    edtjumlah: TAdvEdit;
    edtkodebarang: TAdvEdit;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxGrdMainColumn1: TcxGridDBColumn;
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
    function getlastcost(akode:integer):double;
    procedure FormCreate(Sender: TObject);
    procedure insertketampungan(anomor:string);
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
    procedure clSKUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure bantuansku;
    function getqtyambil(akode,anomorspk : string): double ;
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure edtNomorSpkClickBtn(Sender: TObject);
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    private
     buttonSelected  : integer;
     FID : STRING;
     FCDSSKU : TClientDataset;
     FCDSGudang: TClientDataset;
        FFLAGEDIT: Boolean;
     xtotal : Double;
         function GetCDSGudang: TClientDataset;
         procedure initViewSKU;
      { Private declarations }
     protected
    FCDS: TClientDataSet;
  public
      property CDS: TClientDataSet read GetCDS write FCDS;
          property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
       property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
          property ID: string read FID write FID;
            property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    { Public declarations }
  end;
 const

    NOMERATOR = 'RTB';

var
  frmReturBahan: TfrmReturBahan;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmReturBahan.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmReturBahan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmReturBahan.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmReturBahan.edtNomorExit(Sender: TObject);
begin
   edtNomor.Enabled := False;
   loaddataall(edtNomor.Text);
end;


procedure TfrmReturBahan.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  dttanggal.DateTime := Date;
  edtKeterangan.Clear;
  cxLookupGudangAsal.EditValue := '';
  cxLookupGudangAsal.SetFocus;
  initgrid;
end;

procedure TfrmReturBahan.simpandata;
var
  s:string;
  i:integer;
  tt : TStrings;
  anomor : string;
begin
   if flagedit then
   begin
   anomor := edtNomor.Text;
      s:= 'update treturbahan_hdr set  '
         + ' retb_tanggal = '  + QuotD(dttanggal.DateTime)+','
         + ' retb_keterangan = ' + Quot(edtKeterangan.Text) + ','
         + ' retb_gdg_kode = ' + Quot(cxLookupGudangAsal.EditValue)+','
         + ' retb_spk_nomor= '+ Quot(edtNomorSpk.Text) +','
         + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
         + ' user_modified = ' + Quot(frmMenu.KDUSER)
         + ' where retb_nomor = ' + Quot(edtNomor.Text) ;
   end
   else
   begin
     anomor := getmaxkode;
     edtNomor.Text := anomor;
      s:= ' insert into treturbahan_hdr '
         + '( retb_nomor,retb_tanggal,retb_keterangan,retb_gdg_kode,retb_spk_nomor,date_create,user_create) values ( '
         + Quot(anomor) + ','
         + Quotd(dttanggal.DateTime)+','
         + Quot(edtKeterangan.Text) + ','
         + Quot(cxLookupGudangAsal.EditValue)+','
         + Quot(edtNomorSpk.Text)+','
         + QuotD(cGetServerTime,True) + ','
         + Quot(frmMenu.KDUSER)+')';
   end;
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   tt := TStringList.Create;
   s:= ' delete from treturbahan_dtl '
      + ' where  retbd_retb_nomor =' + quot(FID) ;
   tt.Append(s);
   i:=1;
    CDS.First;
while not CDS.Eof do
  begin
   if (CDS.FieldByName('qty').AsFloat >  0) and (CDS.FieldByName('sku').AsInteger >  0) then
   begin
        s:='insert into treturbahan_dtl '
          + ' (retbd_retb_nomor,retbd_brg_kode,retbd_jumlah,retbd_satuan,retbd_harga,retbd_keterangan,retbd_nourut,retbd_gdg_kode) values ( '
          +  Quot(anomor) + ','
          +  IntToStr(CDS.FieldByName('SKU').AsInteger) + ','
          +  floatToStr(CDS.FieldByName('QTY').asfloat) + ','
          +  Quot(CDS.FieldByName('satuan').Asstring) + ','
          + floattostr(getlastcost(CDS.FieldByName('SKU').AsInteger))+','
          +  Quot(CDS.FieldByName('keterangan').Asstring) + ','
          +  IntToStr(i)+','
          + quot(CDS.FieldByName('gudang').Asstring)
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
procedure TfrmReturBahan.loaddataall(akode : string);
var
  s: string ;
  tsql2,tsql : TMyQuery;
  i:Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select retb_nomor,retb_tanggal,retb_keterangan,retb_gdg_kode,gdg_nama,'
     + ' retbd_brg_kode,brg_nama,brg_satuan,retbd_jumlah,'
     + ' retbd_keterangan,retbd_gdg_kode,retb_spk_nomor'
     + ' from treturbahan_hdr a'
     + ' inner join treturbahan_dtl d on a.retb_nomor=d.retbd_retb_nomor '
     + ' inner join tbarang b on d.retbd_brg_kode = b.brg_kode '
     + ' left join tgudang on retb_gdg_kode=gdg_kode '
     + ' left join tspk on spk_nomor=retb_spk_nomor '
     + ' where a.retb_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('retb_nomor').AsString;
            edtNomor.Text   := fieldbyname('retb_nomor').AsString;
            dttanggal.DateTime := fieldbyname('retb_tanggal').AsDateTime;
           cxLookupGudangAsal.EditValue := fieldbyname('retb_gdg_kode').AsString;
            edtketerangan.Text := fieldbyname('retb_keterangan').AsString;
            edtNomorSpk.Text := fieldbyname('retb_spk_nomor').AsString;

             s:='select * from tspk inner join tbarang on brg_kode=spk_brg_kode where spk_nomor ='+ Quot(edtNomorSpk.Text);
             tsql2 := xOpenQuery(s,frmmenu.conn);
             with tsql2 do
             begin
               try
                 if not eof then
                 begin
                   edtnama.Text := fieldbyname('spk_nama').AsString;
                   edtkodebarang.Text := fieldbyname('brg_kode').AsString;
                   edtnamabarang.Text := fieldbyname('brg_nama').AsString;
                   edtjumlah.Text :=inttostr(fieldbyname('spk_jumlah').AsInteger);
                 end;
               finally
                 tsql2.free;
               end;
             end;
//           cxLookupGudangTujuan.EditValue := fieldbyname('retb_gdg_tujuan').AsString;
            i:=1;

             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;

                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('retbd_brg_kode').AsInteger;
                      CDS.fieldbyname('NamaBarang').AsString  := fieldbyname('brg_nama').AsString;
                      CDS.fieldbyname('satuan').AsString  := fieldbyname('brg_satuan').AsString;
                      CDS.FieldByName('QTY').asfloat        := fieldbyname('retbd_jumlah').Asfloat;
                      CDS.FieldByName('keterangan').AsString  :=  fieldbyname('retbd_keterangan').AsString;
                      CDS.FieldByName('gudang').AsString  :=  fieldbyname('retbd_gdg_kode').AsString;
                      cds.fieldbyname('qtyambil').asfloat  := getqtyambil(fieldbyname('retbd_brg_kode').asstring,edtnomorspk.Text);
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


procedure TfrmReturBahan.doslipmutasi(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'mintabahan';

          s:= ' select '
       + ' *,(select gdg_nama from tgudang where gdg_kode=a.retb_gdg_kode) Gudang_asal '
       + ' from treturbahan_hdr a '
       + ' inner join tampung e on e.nomor =a.retb_nomor '
       + ' left join  treturbahan_dtl b on retb_nomor=retbd_retb_nomor and e.tam_nama=b.retbd_brg_kode and retbd_expired=expired'
       + ' left join tbarang c on b.retbd_brg_kode=c.brg_kode '
       + ' where '
       + ' a.retb_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmReturBahan.insertketampungan(anomor:String);
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
  s := 'select retbd_BRG_kode from treturbahan_dtl where retbd_retb_nomor =' + Quot(anomor) ;
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
                  + Quot(anomor) + ','
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

function TfrmReturBahan.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(retb_nomor,4)) from treturbahan_hdr  where retb_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%') ;

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
end;


function TfrmReturBahan.getlastcost(akode:integer):double;
var
  s:string;
begin
  result := 0;
  s:='select brg_lastcost from tbarang  where brg_kode = ' + inttostr(akode) ;

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if not eof then
        result := fields[0].asfloat;
    finally
      free;
    end;
  end;
end;

procedure TfrmReturBahan.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupGudangAsal.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
//     initViewSKU;
end;

function TfrmReturBahan.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftString, False,255);
    zAddField(FCDS, 'NamaBarang', ftString, False,100);
    zAddField(FCDS, 'Satuan', ftString, False,10);
    zAddField(FCDS, 'QTY', ftfloat, False);
    zAddField(FCDS, 'QTYambil', ftfloat, False); 

    zAddField(FCDS, 'Keterangan', ftString, False,255);
    zAddField(FCDS, 'gudang', ftString, False,100);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmReturBahan.GetCDSGudang: TClientDataset;
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


 procedure TfrmReturBahan.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan,mst_expired_date expired,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangAsal.EditValue))
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

procedure TfrmReturBahan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmReturBahan.cxButton2Click(Sender: TObject);
begin
  try
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

procedure TfrmReturBahan.cxButton1Click(Sender: TObject);
begin
 try
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


function TfrmReturBahan.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
   If cxLookupGudangAsal.EditValue = '' then
    begin
      ShowMessage('Gudang Asal belum di pilih');
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



procedure TfrmReturBahan.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.FIELDBYname('keterangan').asstring := '';
  CDS.Post;

end;



procedure TfrmReturBahan.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmReturBahan.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmReturBahan.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmReturBahan.clQTYPropertiesEditValueChanged(
  Sender: TObject);
begin
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
end;

procedure TfrmReturBahan.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
 bantuansku;

end;

procedure TfrmReturBahan.bantuansku;
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode ,brg_nama,sum(mbd_jumlah) qty '
  + ' from tmintabahan_dtl inner join tmintabahan_hdr '
  + ' on mb_nomor=mbd_mb_nomor '
  + ' inner join tbarang on brg_kode=mbd_brg_kode '
  + ' where mb_spk_nomor='+Quot(edtNomorSpk.Text)
  + ' group by brg_kode,brg_nama ';

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

        ShowMessage('Sku dan expired ada yang sama dengan baris '+ IntToStr(i+1));
        CDS.Cancel;
        exit;
      end;
    end;
 If CDS.State <> dsEdit then
   CDS.Edit;

      CDS.FieldByName('sku').AsInteger := StrToInt(varglobal);
      CDS.FieldByName('NamaBarang').asstring := varglobal1;
      CDS.FieldByName('Qtyambil').AsFloat := getqtyambil(varglobal,edtnomorspk.text);

       s:='select brg_kode Sku, brg_nama NamaBarang, brg_satuan Satuan from tbarang '  ;
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
          CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
          CDS.FieldByName('gudang').AsString := cxLookupGudangAsal.EditValue;

        end
        else
          bantuansku;
        finally
          free;
      end;
    end;
  end;
end;
function TfrmReturBahan.getqtyambil(akode,anomorspk : string): double ;
var
  s:String;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select sum(mbd_jumlah) from tmintabahan_dtl inner join tmintabahan_hdr on mb_nomor=mbd_mb_nomor'
  + ' where mb_spk_nomor='+Quot(anomorspk)
  + ' and mbd_brg_kode= '+ Quot(akode) ;
  tsql:= xOpenQuery(s,frmmenu.conn);
  with tsql do
  begin
    try
      if not eof then
        Result := fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;

procedure TfrmReturBahan.clSKUPropertiesEditValueChanged(
  Sender: TObject);
begin
   bantuansku
end;

procedure TfrmReturBahan.edtNomorSpkClickBtn(Sender: TObject);
var
  s:String;
  akodebarang : string;
  tsql:TMyQuery;
begin
      sqlbantuan := 'select spk_nomor,spk_nama,brg_kode from tspk inner join tbarang on brg_kode=spk_brg_kode'
      + ' order by spk_tanggal desc ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
     edtNomorSpk.Text := varglobal;
     edtnama.Text := varglobal1;
     s:='select * from tspk inner join tbarang on brg_kode=spk_brg_kode where spk_nomor ='+ Quot(edtNomorSpk.Text);
     tsql := xOpenQuery(s,frmmenu.conn);
     with tsql do
     begin
       try
         if not eof then
         begin
           edtkodebarang.Text := fieldbyname('brg_kode').AsString;
           edtnamabarang.Text := fieldbyname('brg_nama').AsString;
           edtjumlah.Text :=inttostr(fieldbyname('spk_jumlah').AsInteger);
         end;
       finally
         free;
       end;
     end;
//     s:='select bk_bhn_kode,brg_nama,brg_satuan,bk_qty,IFNULL(qty,0) sudah '
//     + ' from tbarangkomposisi inner join tbarang on brg_kode=bk_bhn_kode '
//     + ' LEFT JOIN ( '
//     + ' SELECT retbd_brg_kode,SUM(retbd_jumlah) qty FROM tspk INNER JOIN treturbahan_hdr ON retb_spk_nomor =spk_nomor'
//     + ' INNER JOIN treturbahan_dtl ON retbd_retb_nomor=retb_nomor'
//     + ' WHERE spk_nomor LIKE '+ Quot(edtnomorspk.Text)
//     + ' GROUP BY retbd_brg_kode) a ON brg_kode=retbd_brg_kode'
//     + ' where bk_brg_kode= '+ Quot(edtkodebarang.Text) ;
//     tsql := xOpenQuery(s,frmmenu.conn);
//     with tsql do
//     begin
//       try
//            CDS.EmptyDataSet;
//           while not Eof do
//            begin
//              cds.Append;
//              CDS.FieldByName('SKU').AsString := Fields[0].AsString;
//              CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
//              CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
//              CDS.FieldByName('qTY').asfloat :=Fields[3].Asfloat;
//              CDS.FieldByName('gudang').asstring :=cxLookupGudangAsal.EditValue;
//              CDS.Post;
//              Next;
//
//            end
//
//
//       finally
//         free;
//       end;
//     end;



   end;

end;

procedure TfrmReturBahan.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
    if cVarToFloat(DisplayValue) > cds.FieldByName('qtyambil').AsFloat then
    begin
      ShowMessage('Qty Melebihi Qty Ambil');
      DisplayValue  := '';

      error := False;
    end;
end;

end.
