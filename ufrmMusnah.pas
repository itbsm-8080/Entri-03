unit ufrmMusnah;

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
  cxGridCustomView, cxGrid, cxButtonEdit, cxCurrencyEdit,ExcelXP,ComObj,
  MyAccess;

type
  TfrmMusnah = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label4: TLabel;
    dttanggal: TDateTimePicker;
    AdvPanel3: TAdvPanel;
    Label3: TLabel;
    edtKeterangan: TAdvEdit;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    cxLookupGudangTujuan: TcxExtLookupComboBox;
    edtNomor: TAdvEdit;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQty: TcxGridDBColumn;
    clSatuan: TcxGridDBColumn;
    clExpired: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clHarga: TcxGridDBColumn;
    clNilai: TcxGridDBColumn;
    OpenDialog1: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure refreshdata;
    procedure simpandata;
    procedure dosliP(anomor : string );
    function GetCDS: TClientDataSet;

    function getmaxkode:string;
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
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clExpiredPropertiesEditValueChanged(Sender: TObject);
    procedure loaddataall(akode : string);
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

    NOMERATOR = 'MUS';

var
  frmMusnah: TfrmMusnah;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmMusnah.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmMusnah.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmMusnah.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmMusnah.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  dttanggal.DateTime := Date;
  edtKeterangan.Clear;
   cxLookupGudangTujuan.EditValue := '';
  cxLookupGudangTujuan.SetFocus;
  initgrid;
end;

procedure TfrmMusnah.simpandata;
var
  s:string;
  i:integer;
  tt : TStrings;
  anomor : string;
  asubtotal : Double;
begin
    asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('nilai'));
   if flagedit then
   begin
   anomor := edtNomor.Text;
      s:= 'update tmus_hdr set  '
         + ' mus_tanggal = ' + QuotD(dttanggal.DateTime)+','
         + ' mus_notes = ' + Quot(edtKeterangan.Text) + ','
         + ' mus_gdg_kode = ' + Quot(cxLookupGudangTujuan.EditValue)+','
         + ' mus_total = ' + FloatToStr(asubtotal)+','
         + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
         + ' user_modified = ' + Quot(frmMenu.KDUSER)
         + ' where mus_nomor = ' + Quot(edtNomor.Text) ;
   end
   else
   begin
     anomor := getmaxkode;
     edtNomor.Text := anomor;
      s:= ' insert into tmus_hdr '
         + '( mus_nomor,mus_tanggal,mus_notes,mus_gdg_kode,mus_total,date_create,user_create) values ( '
         + Quot(anomor) + ','
         + Quotd(dttanggal.DateTime)+','
         + Quot(edtKeterangan.Text) + ','
         + Quot(cxLookupGudangTujuan.EditValue)+','
         + FloatToStr(asubtotal)+','
         + QuotD(cGetServerTime,True) + ','
         + Quot(frmMenu.KDUSER)+')';
   end;
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   tt := TStringList.Create;
   s:= ' delete from tmus_dtl '
      + ' where  musd_mus_nomor =' + quot(FID) ;
   tt.Append(s);
   i:=1;
    CDS.First;
while not CDS.Eof do
  begin
   if CDS.FieldByName('sku').AsInteger >  0 then
   begin
        s:='insert into tmus_dtl '
          + ' (musd_mus_nomor,musd_brg_kode,musd_brg_satuan,musd_tgl_expired,musd_qty,musd_harga,musd_nourut) values ( '
          +  Quot(anomor) + ','
          +  IntToStr(CDS.FieldByName('SKU').AsInteger) + ','
          +  quot(CDS.FieldByName('satuan').AsString) + ','
          + QuotD(CDS.FieldByName('expired').Asdatetime) +','
          +  floatToStr(CDS.FieldByName('qty').Asfloat) + ','
          +  floatToStr(CDS.FieldByName('harga').Asfloat) + ','
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
procedure TfrmMusnah.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'musnah';

          s:= ' select '
       + ' *'
       + ' from tmus_hdr a '
       + ' inner join tampung e on e.nomor =a.mus_nomor '
       + ' left join  tmus_dtl b on mus_nomor=musd_mus_nomor and e.tam_nama=b.musd_brg_kode and e.expired=b.musd_expired'
       + ' left join tbarang c on b.musd_brg_kode=c.brg_kode '
       + ' LEFT join tgudang d on gdg_kode=mus_gdg_kode'
       + ' where '
       + ' a.mus_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmMusnah.insertketampungan(anomor:String);
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
  s := 'select musd_BRG_kode,musd_expired from tmus_dtl where musd_mus_nomor =' + Quot(anomor) ;
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

function TfrmMusnah.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(mus_nomor,4)) from tmus_hdr  where mus_nomor like ' + quot(frmMenu.kdcabang + '-'+ NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%') ;

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
end;


procedure TfrmMusnah.FormCreate(Sender: TObject);
begin
 with TcxExtLookupHelper(cxLookupGudangTujuan.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
//     initViewSKU;
end;

function TfrmMusnah.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftString, False,255);
    zAddField(FCDS, 'NamaBarang', ftString, False,100);
    zAddField(FCDS, 'Satuan', ftString, False,10);
    zAddField(FCDS, 'QTY', ftFloat, False);
    zAddField(FCDS, 'expired', ftDate, False,255);
    zAddField(FCDS, 'harga', ftfloat, False);
    zAddField(FCDS, 'nilai', ftfloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmMusnah.GetCDSGudang: TClientDataset;
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


 procedure TfrmMusnah.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_satuan Satuan,mst_expired_date expired,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
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

procedure TfrmMusnah.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmMusnah.cxButton2Click(Sender: TObject);
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

procedure TfrmMusnah.cxButton1Click(Sender: TObject);
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


function TfrmMusnah.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
     If cxLookupGudangTujuan.EditValue = '' then
    begin
      ShowMessage('Gudang belum di pilih');
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



procedure TfrmMusnah.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').asfloat  := 0;
  CDS.FieldByName('harga').asfloat  := 0;
  CDS.FieldByName('nilai').asfloat  := 0;
  CDS.Post;

end;



procedure TfrmMusnah.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmMusnah.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmMusnah.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmMusnah.clQTYPropertiesEditValueChanged(
  Sender: TObject);
  var
    i:integer;
    lVal : double;
begin
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
   i := cxGrdMain.DataController.FocusedRecordIndex;
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index];

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('nilai').AsFloat := lVal;
  CDS.Post;

end;

procedure TfrmMusnah.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
 bantuansku;

end;

procedure TfrmMusnah.bantuansku;
  var
    s:string;
    tsql2,tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku, brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' left join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
  + ' group by brg_kode , brg_nama , brg_satuan ';

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
//      CDS.FieldByName('expired').AsDateTime := cVarTodate(varglobal1);

  s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok , '
  + ' mst_hargabeli hargabeli from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
//  + ' and mst_expired_date = ' + QuotD(CDS.Fieldbyname('expired').AsDateTime)
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
          CDS.FieldByName('NamaBarang').AsString := Fields[2].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[3].AsString;
          CDS.FieldByName('harga').asfloat :=Fields[5].Asfloat;

        end
        ELSE
        begin
          s:='select brg_nama,brg_satuan,0,brg_hrgbeli from tbarang where brg_kode = '+Quot(CDS.Fieldbyname('sku').AsString);
          tsql2 := xOpenQuery(s,frmMenu.conn);
          with tsql2 do
          begin
            try
              if not Eof then
              begin
                CDS.FieldByName('NamaBarang').AsString := Fields[0].AsString;
                CDS.FieldByName('Satuan').AsString := Fields[1].AsString;
                CDS.FieldByName('harga').asfloat :=Fields[3].Asfloat;

              end
              ELSE
              bantuansku;
            finally
              Free;
            end;
          end;
        end;


        finally
          free;
      end;
    end;
  end;
end;

procedure TfrmMusnah.clSKUPropertiesEditValueChanged(
  Sender: TObject);
begin
   bantuansku
end;

procedure TfrmMusnah.clExpiredPropertiesEditValueChanged(
  Sender: TObject);
  var
    tsql:TMyQuery;
    s:string;
    i:integer;
begin
     i := cxGrdMain.DataController.FocusedRecordIndex;
      cxGrdMain.DataController.Post;
  s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok , '
  + ' mst_hargabeli hargabeli from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangTujuan.EditValue))
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
  + ' and mst_expired_date = ' + QuotD( cVarTodate(cxGrdMain.DataController.Values[i, clExpired.Index]))
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date,mst_hargabeli ';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
        begin
           If CDS.State <> dsEdit then
   CDS.Edit;

          CDS.FieldByName('NamaBarang').AsString := Fields[2].AsString;
          CDS.FieldByName('Satuan').AsString := Fields[3].AsString;
          CDS.FieldByName('system').asfloat :=Fields[4].Asfloat;
          CDS.FieldByName('harga').asfloat :=Fields[5].Asfloat;

        end
        else
        begin
           If CDS.State <> dsEdit then
           CDS.Edit;
          CDS.FieldByName('system').asfloat :=0;
        end;


      finally
      free;
      end;
    end

end;

procedure TfrmMusnah.loaddataall(akode : string);
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
  s := ' select mus_NOMOr,mus_tanggal,mus_notes,mus_gdg_kode,'
     + ' musd_brg_kode,musd_bRG_satuan,brg_nama,musd_qty,musd_tgl_expired,musd_harga'
     + ' from tmus_hdr '
     + ' left join tmus_dtl on musd_mus_nomor=mus_nomor'
     + ' left join tbarang on brg_kode=musd_brg_kode '
     + ' where mus_nomor = '+ Quot(akode)
     + ' order by musd_nourut ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('mus_nomor').AsString;
            edtnomor.Text := fieldbyname('mus_nomor').AsString;
            dttanggal.DateTime := fieldbyname('mus_tanggal').AsDateTime;
            edtKeterangan.Text := fieldbyname('mus_notes').AsString;
            cxLookupGudangTujuan.EditValue := fieldbyname('mus_gdg_kode').AsString;


            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('musd_brg_kode').AsInteger;
                      CDS.FieldByName('Namabarang').AsString  := fieldbyname('brg_nama').AsString;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('musd_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('musd_qty').AsInteger;
                      CDS.FieldByName('expired').AsDateTime := fieldbyname('musd_tgl_expired').AsDateTime;
                      CDS.FieldByName('harga').asfloat       := fieldbyname('musd_harga').asfloat;
                      CDS.FieldByName('nilai').asfloat       := fieldbyname('musd_harga').asfloat*fieldbyname('musd_qty').asfloat;

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


end.
