unit ufrmSTBJ;

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
  TfrmSTBJ = class(TForm)
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
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    Label5: TLabel;
    edtNomorSpk: TAdvEditBtn;
    Label6: TLabel;
    edtnama: TAdvEdit;
    Label7: TLabel;
    edtnamabarang: TAdvEdit;
    Label8: TLabel;
    edtjumlah: TAdvEdit;
    edtkodebarang: TAdvEdit;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clqtySudah: TcxGridDBColumn;
    clSatuan: TcxGridDBColumn;
    clKeterangan: TcxGridDBColumn;
    clgudang: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    Label9: TLabel;
    edtharga: TAdvEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomorExit(Sender: TObject);
    procedure refreshdata;
    procedure simpandata;
    procedure loaddataall(akode : string);
    function gethpp(anomorspk:string):double;
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
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clQTYPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure edtNomorSpkClickBtn(Sender: TObject);
    function getqtysudah(anomorspk,akode:String):double;
    function getqtyretur(anomorspk,akode:String):double;
    procedure edtjumlahExit(Sender: TObject);
    procedure cxGrdMainStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
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

    NOMERATOR = 'STB';

var
  frmSTBJ: TfrmSTBJ;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmSTBJ.FormShow(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmSTBJ.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmSTBJ.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmSTBJ.edtNomorExit(Sender: TObject);
begin
   edtNomor.Enabled := False;
   loaddataall(edtNomor.Text);
end;


procedure TfrmSTBJ.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  dttanggal.DateTime := Date;
  edtKeterangan.Clear;
  cxLookupGudangAsal.EditValue := '';
  cxLookupGudangAsal.SetFocus;
  initgrid;
end;

procedure TfrmSTBJ.simpandata;
var
  s:string;
  i:integer;
  tt : TStrings;
  anomor : string;
begin
   if flagedit then
   begin
   anomor := edtNomor.Text;
      s:= 'update tstbj set  '
         + ' stbj_tanggal = '  + QuotD(dttanggal.DateTime)+','
         + ' stbj_keterangan = ' + Quot(edtKeterangan.Text) + ','
         + ' stbj_gdg_kode = ' + Quot(cxLookupGudangAsal.EditValue)+','
         + ' stbj_spk_nomor= '+ Quot(edtNomorSpk.Text) +','
         + ' stbj_brg_kode='+ Quot(edtkodebarang.Text) + ','
         + ' stbj_jumlah ='+ StringReplace(edtjumlah.Text,',','',[rfReplaceAll]) + ','
         + ' stbj_harga ='+ StringReplace(edtharga.Text,',','',[rfReplaceAll]) + ','
         + ' date_modify  = ' + QuotD(cGetServerTime,True) + ','
         + ' user_modify = ' + Quot(frmMenu.KDUSER)
         + ' where stbj_nomor = ' + Quot(edtNomor.Text) ;
   end
   else
   begin
     anomor := getmaxkode;
     edtNomor.Text := anomor;
      s:= ' insert into tstbj'
         + '( stbj_nomor,stbj_tanggal,stbj_keterangan,stbj_gdg_kode,stbj_spk_nomor,date_create,user_create,'
         + ' stbj_brg_kode,stbj_jumlah,stbj_harga) values ( '
         + Quot(anomor) + ','
         + Quotd(dttanggal.DateTime)+','
         + Quot(edtKeterangan.Text) + ','
         + Quot(cxLookupGudangAsal.EditValue)+','
         + Quot(edtNomorSpk.Text)+','
         + QuotD(cGetServerTime,True) + ','
         + Quot(frmMenu.KDUSER) +','
         + Quot(edtkodebarang.Text)+','
         + StringReplace(edtjumlah.Text,',','',[rfReplaceAll])+','
         + StringReplace(edtharga.Text,',','',[rfReplaceAll])
         +')';
   end;
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
end;
procedure TfrmSTBJ.loaddataall(akode : string);
var
  s: string ;
  tsql3,tsql2,tsql : TMyQuery;
  i:Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select stbj_nomor,stbj_tanggal,stbj_keterangan,stbj_gdg_kode,gdg_nama,'
     + ' stbj_brg_kode,brg_nama,brg_satuan,stbj_jumlah,'
     + ' stbj_keterangan,stbj_gdg_kode,stbj_spk_nomor'
     + ' from tstbj a'
     + ' inner join tbarang b on stbj_brg_kode = b.brg_kode '
     + ' left join tgudang on stbj_gdg_kode=gdg_kode '
     + ' where a.stbj_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('stbj_nomor').AsString;
            edtNomor.Text   := fieldbyname('stbj_nomor').AsString;
            dttanggal.DateTime := fieldbyname('stbj_tanggal').AsDateTime;
           cxLookupGudangAsal.EditValue := fieldbyname('stbj_gdg_kode').AsString;
            edtketerangan.Text := fieldbyname('stbj_keterangan').AsString;
            edtNomorSpk.Text := fieldbyname('stbj_spk_nomor').AsString;
            edtjumlah.text := fieldbyname('stbj_jumlah').AsString;
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
                 s:='select bk_bhn_kode,brg_nama,brg_satuan,bk_qty from tbarangkomposisi inner join tbarang on brg_kode=bk_bhn_kode where bk_brg_kode= '+ Quot(edtkodebarang.Text) ;
           tsql3 := xOpenQuery(s,frmmenu.conn);
           with tsql3 do
           begin
             try
                  CDS.EmptyDataSet;
                 while not Eof do
                  begin
                    cds.Append;
                    CDS.FieldByName('SKU').AsString := Fields[0].AsString;
                    CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
                    CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
                    CDS.FieldByName('qTY').asfloat :=Fields[3].Asfloat* strtofloat(edtjumlah.Text);
                    CDS.FieldByName('qTYsudah').asfloat :=getqtysudah(edtnomorspk.text,fields[0].asstring)-getqtyretur(edtnomorspk.text,fields[0].asstring);
                    CDS.FieldByName('gudang').asstring :=cxLookupGudangAsal.EditValue;
                    CDS.Post;
                    Next;

                  end


             finally
               free;
             end;
           end;

        end
        else
        begin
          ShowMessage('Nomor tidak di temukan');
          edtNomor.Enabled:= true;
          edtNomor.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;
   edtharga.Text := formatfloat('###,###,###',gethpp(edtNomorSpk.text)/strtofloat(edtjumlah.Text));
end;

function TfrmSTBJ.gethpp(anomorspk:string):double;
var
  s:String;
  tsql:TMyQuery;
begin
  result:=0;
  s:='select sum((mst_stok_out-mst_stok_in)*mst_hargabeli) from tmasterstok '
  + ' left join (select mb_nomor from tmintabahan_hdr where mb_spk_nomor='+Quot(anomorspk)+') a on mb_nomor=mst_noreferensi '
  + ' left join (select retb_nomor from treturbahan_hdr where retb_spk_nomor='+Quot(anomorspk)+ ') b on retb_nomor=mst_noreferensi '
  + ' WHERE mb_nomor is NOT NULL  OR retb_nomor is NOT null ';
  tsql := xOpenQuery(s,frmmenu.conn);
  with tsql do
  begin
     try
       if not eof then
          result := fields[0].asfloat;
     finally
       free;
      end;
  end;

end;


procedure TfrmSTBJ.doslipmutasi(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'mintabahan';

          s:= ' select '
       + ' *,(select gdg_nama from tgudang where gdg_kode=a.stbj_gdg_kode) Gudang_asal '
       + ' from tstbj_hdr a '
       + ' inner join tampung e on e.nomor =a.stbj_nomor '
       + ' left join  tstbj_dtl b on stbj_nomor=stbjd_stbj_nomor and e.tam_nama=b.stbjd_brg_kode and stbjd_expired=expired'
       + ' left join tbarang c on b.stbjd_brg_kode=c.brg_kode '
       + ' where '
       + ' a.stbj_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmSTBJ.insertketampungan(anomor:String);
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
  s := 'select stbjd_BRG_kode from tstbj_dtl where stbjd_stbj_nomor =' + Quot(anomor) ;
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

function TfrmSTBJ.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(stbj_nomor,4)) from tstbj  where stbj_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%') ;

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


function TfrmSTBJ.getlastcost(akode:integer):double;
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

procedure TfrmSTBJ.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupGudangAsal.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
//     initViewSKU;
end;

function TfrmSTBJ.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftString, False,255);
    zAddField(FCDS, 'NamaBarang', ftString, False,100);
    zAddField(FCDS, 'Satuan', ftString, False,10);
    zAddField(FCDS, 'QTY', ftfloat, False);
    zAddField(FCDS, 'QTYsudah', ftfloat, False);
    zAddField(FCDS, 'Keterangan', ftString, False,255);
    zAddField(FCDS, 'gudang', ftString, False,100);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmSTBJ.GetCDSGudang: TClientDataset;
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


 procedure TfrmSTBJ.initViewSKU;
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

procedure TfrmSTBJ.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSTBJ.cxButton2Click(Sender: TObject);
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

procedure TfrmSTBJ.cxButton1Click(Sender: TObject);
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


function TfrmSTBJ.cekdata:Boolean;
var
  i:integer;
  abaris:string;
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
  abaris:='';
  While not CDS.Eof do
  begin



    If CDS.FieldByName('SKU').AsInteger = 0 then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;

    If CDS.FieldByName('qty').asfloat  - CDS.FieldByName('qtysudah').asfloat > 0.01 then
    begin
      abaris := abaris + inttostr(i) +','
    end;
    inc(i);
    CDS.Next;
  end;
  if abaris <> '' then 
  showmessage('Baris '+ leftstr(abaris,length(abaris)-1)+ ' realisasi kurang');
end;



procedure TfrmSTBJ.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.FIELDBYname('keterangan').asstring := '';
  CDS.Post;

end;



procedure TfrmSTBJ.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmSTBJ.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSTBJ.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmSTBJ.clQTYPropertiesEditValueChanged(
  Sender: TObject);
begin
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
end;

procedure TfrmSTBJ.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
 bantuansku;

end;

procedure TfrmSTBJ.bantuansku;
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangAsal.EditValue))
  + ' group by brg_kode , brg_nama , brg_satuan ,mst_expired_date ';

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
      CDS.FieldByName('expired').AsDateTime := strtodate(varglobal1);

       s:='select brg_kode Sku, mst_expired_date Expired,brg_nama NamaBarang, brg_satuan Satuan,sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangAsal.EditValue))
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

procedure TfrmSTBJ.clSKUPropertiesEditValueChanged(
  Sender: TObject);
begin
   bantuansku
end;

procedure TfrmSTBJ.clQTYPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
  aqtystok:integer;
  s:string;
  tsql:TMyQuery;
begin
  aqtystok:=0;
  s:='select sum(mst_stok_in-mst_stok_out) stok from Tbarang '
  + ' inner join tmasterstok  on mst_brg_kode=brg_kode and mst_gdg_kode= '+ Quot(vartostr(cxLookupGudangAsal.EditValue))
  + ' where brg_kode = ' + Quot(CDS.Fieldbyname('sku').AsString)
  + ' and mst_expired_date = ' + QuotD(CDS.Fieldbyname('expired').AsDateTime);

    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        if not Eof then
          aqtystok := Fields[0].AsInteger;
      finally
          free;
      end;
    end;

    if cVarToInt(DisplayValue)> aqtyStok then
    begin
      error := true;
        ErrorText :='Qty melebihi Stok di Gudang';
        exit;
    end;

end;

procedure TfrmSTBJ.edtNomorSpkClickBtn(Sender: TObject);
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

     s:='select bk_bhn_kode,brg_nama,brg_satuan,bk_qty from tbarangkomposisi inner join tbarang on brg_kode=bk_bhn_kode where bk_brg_kode= '+ Quot(edtkodebarang.Text) ;
     tsql := xOpenQuery(s,frmmenu.conn);
     with tsql do
     begin
       try
            CDS.EmptyDataSet;
           while not Eof do
            begin
              cds.Append;
              CDS.FieldByName('SKU').AsString := Fields[0].AsString;
              CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
              CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
              CDS.FieldByName('qTY').asfloat :=Fields[3].Asfloat* strtofloat(edtjumlah.Text);
              CDS.FieldByName('qTYsudah').asfloat :=getqtysudah(edtnomorspk.text,fields[0].asstring)-getqtyretur(edtnomorspk.text,fields[0].asstring);
              CDS.FieldByName('gudang').asstring :=cxLookupGudangAsal.EditValue;
              CDS.Post;
              Next;

            end


       finally
         free;
       end;
     end;

  end;
  edtharga.Text := formatfloat('###,###,###',gethpp(edtNomorSpk.text)/strtofloat(edtjumlah.Text));
end;

function TfrmSTBJ.getqtysudah(anomorspk,akode:String):double;
var
  s:string;
  tsql:TMyQuery;
begin
result :=0;
s:='select sum(mbd_jumlah) from tmintabahan_hdr inner join tmintabahan_dtl on mbd_mb_nomor=mb_nomor '
  + ' where mb_spk_nomor='+Quot(anomorspk)
  + ' and mbd_brg_kode='+Quot(akode) ;
  tsql := xopenquery(s,frmmenu.conn);
  with tsql do
  begin
    try
      if not eof then
         result := fields[0].asfloat;
    finally
      free;
    end;
  end;

end;

function TfrmSTBJ.getqtyretur(anomorspk,akode:String):double;
var
  s:string;
  tsql:TMyQuery;
begin
result :=0;
s:='select sum(retbd_jumlah) from treturbahan_hdr inner join treturbahan_dtl on retbd_retb_nomor=retb_nomor '
  + ' where retb_spk_nomor='+Quot(anomorspk)
  + ' and retbd_brg_kode='+Quot(akode) ;
  tsql := xopenquery(s,frmmenu.conn);
  with tsql do
  begin
    try
      if not eof then
         result := fields[0].asfloat;
    finally
      free;
    end;
  end;

end;
procedure TfrmSTBJ.edtjumlahExit(Sender: TObject);
var
  s:String;
  tsql:TMyQuery;
begin
  s:='select bk_bhn_kode,brg_nama,brg_satuan,bk_qty from tbarangkomposisi inner join tbarang on brg_kode=bk_bhn_kode where bk_brg_kode= '+ Quot(edtkodebarang.Text) ;
     tsql := xOpenQuery(s,frmmenu.conn);
     with tsql do
     begin
       try
            CDS.EmptyDataSet;
           while not Eof do
            begin
              cds.Append;
              CDS.FieldByName('SKU').AsString := Fields[0].AsString;
              CDS.FieldByName('NamaBarang').AsString := Fields[1].AsString;
              CDS.FieldByName('Satuan').AsString := Fields[2].AsString;
              CDS.FieldByName('qTY').asfloat :=Fields[3].Asfloat* strtofloat(edtjumlah.Text);
              CDS.FieldByName('gudang').asstring :=cxLookupGudangAsal.EditValue;
              CDS.Post;
              Next;

            end


       finally
         free;
       end;
     end;
end;

procedure TfrmSTBJ.cxGrdMainStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
  AColumn2 : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('qty');
  AColumn2 := (Sender as TcxGridDBTableView).GetColumnByFieldName('qtysudah');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn2.Index]) > 0 ) then
    AStyle := cxStyle3;

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn2.Index]) >= cVarToFloat(ARecord.Values[AColumn.Index])) then
    AStyle := cxStyle2;




end;

end.
