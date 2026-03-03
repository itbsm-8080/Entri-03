unit ufrmJurnalUmum;

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
  cxGridCustomView, cxGrid, cxButtonEdit, MyAccess;

type
  TfrmJurnalUmum = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    Label4: TLabel;
    dttanggal: TDateTimePicker;
    AdvPanel3: TAdvPanel;
    Label3: TLabel;
    edtKeterangan: TAdvEdit;
    RAWPrinter1: TRAWPrinter;
    edtNomor: TAdvEdit;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clAccount: TcxGridDBColumn;
    clAccountName: TcxGridDBColumn;
    clDebet: TcxGridDBColumn;
    clMemo: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    clCostCenter: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clKredit: TcxGridDBColumn;
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
    procedure bantuanaccount;
    procedure clAccountPropertiesEditValueChanged(Sender: TObject);
    private
     buttonSelected  : integer;
     FID : STRING;
     FCDSCostCenter: TClientDataset;
     FCDSAccount: TClientDataset;
        FFLAGEDIT: Boolean;
     xtotal : Double;
         function GetCDSAccount: TClientDataset;
         procedure initViewCostCenter;
      { Private declarations }
     protected
    FCDS: TClientDataSet;
  public
      property CDS: TClientDataSet read GetCDS write FCDS;
          property CDSCostCenter: TClientDataSet read FCDSCostCenter write FCDSCostCenter;
       property CDSAccount: TClientDataset read GetCDSAccount write FCDSAccount;
          property ID: string read FID write FID;
            property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    { Public declarations }
  end;
 const

    NOMERATOR = 'JUR';

var
  frmJurnalUmum: TfrmJurnalUmum;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmJurnalUmum.FormShow(Sender: TObject);
begin
  refreshdata;
 end;

procedure TfrmJurnalUmum.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmJurnalUmum.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;

procedure TfrmJurnalUmum.edtNomorExit(Sender: TObject);
begin
   edtNomor.Enabled := False;
   loaddataall(edtNomor.Text);
end;


procedure TfrmJurnalUmum.refreshdata;
begin
  FID:='';
  FLAGEDIT :=False;
  dttanggal.DateTime := Date;
  edtKeterangan.Clear;
  dttanggal.SetFocus;
  initgrid;
end;

procedure TfrmJurnalUmum.simpandata;
var
  s:string;
  i:integer;
  tt : TStrings;
  anomor : string;
begin
   if flagedit then
   begin
   anomor := edtNomor.Text;
      s:= 'update tjurnal set  '
         + ' jur_tanggal = ' + QuotD(dttanggal.DateTime)+','
         + ' jur_keterangan = ' + Quot(edtKeterangan.Text) + ','
         + ' jur_tipetransaksi = ' + quot('Jurnal Umum') +','
         + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
         + ' user_modified = ' + Quot(frmMenu.KDUSER)
         + ' where jur_no = ' + Quot(edtNomor.Text) ;
   end
   else
   begin
     anomor := getmaxkode;
     edtNomor.Text := anomor;
      s:= ' insert into tjurnal '
         + '( jur_no,jur_tanggal,jur_keterangan,jur_tipetransaksi,date_create,user_create) values ( '
         + Quot(anomor) + ','
         + Quotd(dttanggal.DateTime)+','
         + Quot(edtKeterangan.Text) + ','
         + Quot('Jurnal Umum')+','
         + QuotD(cGetServerTime,True) + ','
         + Quot(frmMenu.KDUSER)+')';
   end;
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   tt := TStringList.Create;
   s:= ' delete from tjurnalitem '
      + ' where  jurd_jur_no =' + quot(FID) ;
   tt.Append(s);
   i:=1;
   // insert detail di header
//           s:='insert into tjurnalitem '
//          + ' (jurd_jur_no,jurd_rek_kode,jurd_kredit,jurd_debet,jurd_cc_kode,jurd_keterangan,jurd_nourut) values ( '
//          +  Quot(anomor) + ','
//          +  Quot(VarToStr(cxLookupAccount.EditValue)) + ','
//          +  floattostr(cStrToFloat(edtNilai.Text)) + ',0,'
//          +  Quot('') + ','
//          +  Quot(edtKeterangan.text) +',0'
//          +');';
//       tt.Append(s);

  CDS.First;
  while not CDS.Eof do
  begin
   if (CDS.FieldByName('Debet').AsFloat >  0) and (CDS.FieldByName('account').AsString <> '') then
   begin
        s:='insert into tjurnalitem '
          + ' (jurd_jur_no,jurd_rek_kode,jurd_kredit,jurd_debet,jurd_cc_kode,jurd_keterangan,jurd_nourut) values ( '
          +  Quot(anomor) + ','
          +  Quot(CDS.FieldByName('account').AsString) + ',0,'
          +  floattostr(CDS.FieldByName('Debet').AsFloat) + ','
          +  Quot(CDS.FieldByName('costcenter').Asstring) + ','
          + Quot(CDS.FieldByName('memo').Asstring)+','
          +  IntToStr(i)
          +');';
       tt.Append(s);
     end;
       if (CDS.FieldByName('kredit').AsFloat >  0) and (CDS.FieldByName('account').AsString <> '') then
   begin
        s:='insert into tjurnalitem '
          + ' (jurd_jur_no,jurd_rek_kode,jurd_debet,jurd_kredit,jurd_cc_kode,jurd_keterangan,jurd_nourut) values ( '
          +  Quot(anomor) + ','
          +  Quot(CDS.FieldByName('account').AsString) + ',0,'
          +  floattostr(CDS.FieldByName('kredit').AsFloat) + ','
          +  Quot(CDS.FieldByName('costcenter').Asstring) + ','
          + Quot(CDS.FieldByName('memo').Asstring)+','
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
procedure TfrmJurnalUmum.loaddataall(akode : string);
var
  s: string ;
  tsql,tsql2 : TMyQuery;
  i:Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select jur_no,jur_tanggal,jur_keterangan,jurd_debet,jurd_rek_kode,'
     + ' jurd_kredit,jurd_keterangan,jurd_cc_kode,rek_nama '
     + ' from tjurnal a'
     + ' inner join tjurnalitem d on a.jur_no=d.jurd_jur_no '
     + ' inner join trekening b on d.jurd_rek_kode = b.rek_kode '
     + ' where a.jur_no = '+ Quot(akode)
     + ' and jurd_Kredit > 0 ';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('jur_no').AsString;
            edtNomor.Text   := fieldbyname('jur_no').AsString;
            dttanggal.DateTime := fieldbyname('jur_tanggal').AsDateTime;
            edtketerangan.Text := fieldbyname('jur_keterangan').AsString;

            s := ' select jur_no,jur_tanggal,jur_keterangan,jurd_debet,jurd_rek_kode,'
                 + ' jurd_kredit,jurd_keterangan,jurd_cc_kode,rek_nama '
                 + ' from tjurnal a'
                 + ' inner join tjurnalitem d on a.jur_no=d.jurd_jur_no '
                 + ' inner join trekening b on d.jurd_rek_kode = b.rek_kode '
                 + ' where a.jur_no = '+ Quot(akode)
                 + ' order by jurd_nourut';
                tsql := xOpenQuery(s,frmMenu.conn) ;

           i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;

                      CDS.FieldByName('account').AsString  := fieldbyname('jurd_rek_kode').AsString;
                      CDS.fieldbyname('accountname').AsString  := fieldbyname('rek_nama').AsString;
                      CDS.FieldByName('DEBET').AsFloat   := fieldbyname('jurd_debet').AsFloat;
                      CDS.FieldByName('KREDIT').AsFloat   := fieldbyname('jurd_kredit').AsFloat;

                      CDS.FieldByName('memo').AsString := fieldbyname('jurd_keterangan').AsString;
                      CDS.FieldByName('costcenter').AsString  :=  fieldbyname('jurd_cc_kode').AsString;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;

        end
        else
        begin
          ShowMessage('Nomor Jurnal tidak di temukan');
          edtNomor.Enabled:= true;
          edtNomor.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;
end;


procedure TfrmJurnalUmum.doslipmutasi(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'JURNALUMUM';

          s:= ' select '
       + ' *,'
       + ' (select rek_nama from tjurnalitem a ,trekening b  where a.jurd_jur_no=jur_no and jurd_kredit > 0  and rek_kode=jurd_rek_kode) rekkredit,'
       + '(select sum(jurd_kredit) from tjurnalitem a where a.jurd_jur_no=jur_no) kredit, '
       + ' terbilang((select sum(jurd_kredit) from tjurnalitem a where a.jurd_jur_no=jur_no)) bilang '
       + ' from tjurnal a inner join tjurnalitem b on a.jur_no = b.jurd_jur_no '
       + ' inner join trekening c on c.rek_kode= b.jurd_rek_kode '
       + ' left join  tcostcenter d on cc_kode=jurd_cc_kode '
       + ' where '
       + ' jur_no=' + quot(anomor)
       + ' and jurd_debet > 0 ';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmJurnalUmum.insertketampungan(anomor:String);
var
  s:string;
  tsql : TMyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=8;
  s:='delete from tampung ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  s := 'select jurd_rek_kode from tjurnalitem where jurd_jur_no =' + Quot(anomor) ;
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

function TfrmJurnalUmum.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(jur_no,4)) from tjurnal  where jur_no like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%') ;

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


procedure TfrmJurnalUmum.FormCreate(Sender: TObject);
begin
  TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     initViewCostCenter;
end;

function TfrmJurnalUmum.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Account', ftString, False,8);
    zAddField(FCDS, 'AccountName', ftString, False,80);
    zAddField(FCDS, 'Debet', ftFloat, False,18);
    zAddField(FCDS, 'Kredit', ftFloat, False,18);
    zAddField(FCDS, 'Memo', ftString, False,255);
    zAddField(FCDS, 'CostCenter', ftString, False,5);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmJurnalUmum.GetCDSAccount: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSAccount) then
  begin
    S := 'select rek_nama AccountName,rek_kode Kode'
        +' from trekening where rek_isaktif=1 and rek_kol_id=1';


    FCDSAccount := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSAccount;
end;


 procedure TfrmJurnalUmum.initViewCostCenter;
var
  S: string;
begin
  if Assigned(FCDSCostCenter) then FCDSCostCenter.Free;
  S := 'select cc_kode CostCenter,cc_nama Nama from Tcostcenter ';

  FCDSCostCenter := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clCostCenter.Properties) do
  begin
    LoadFromCDS(CDSCostCenter, 'CostCenter','CostCenter',['CostCenter'],Self);
    SetMultiPurposeLookup;
  end;


end;

procedure TfrmJurnalUmum.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmJurnalUmum.cxButton2Click(Sender: TObject);
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

procedure TfrmJurnalUmum.cxButton1Click(Sender: TObject);
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


function TfrmJurnalUmum.cekdata:Boolean;
var
  i:integer;
  ATOTAL : DOUBLE;
begin
  atotal := 0;
  result:=true;
   i := 1;
      CDS.First;
  While not CDS.Eof do
  begin

    If (CDS.FieldByName('debet').asfloat > 0) and (CDS.FieldByName('kredit').asfloat > 0) then
    begin
      ShowMessage('Nilai debet dan kredit tidak boleh terisi dua duanya');
      result:=false;
      Exit;

    end;
    inc(i);
    CDS.Next;
  end;
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('debet')) <> cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('kredit')) then
    begin
          ShowMessage('Nilai debet dan kredit tidak sama');
          result:=false;
          Exit;
    end;
end;



procedure TfrmJurnalUmum.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('debet').AsInteger    := 0;
  CDS.FieldByName('kredit').AsInteger    := 0;

  CDS.FIELDBYname('memo').asstring := '';
  CDS.Post;

end;



procedure TfrmJurnalUmum.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmJurnalUmum.clNoGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: String);
begin
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmJurnalUmum.cxLookupGudangAsalPropertiesEditValueChanged(
  Sender: TObject);
begin
//initViewSKU;
end;

procedure TfrmJurnalUmum.clQTYPropertiesEditValueChanged(
  Sender: TObject);
begin
 If CDS.State <> dsEdit then
   CDS.Edit;
  cxGrdMain.DataController.Post;
end;

procedure TfrmJurnalUmum.clSKUPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
 bantuanAccount;
end;

procedure TfrmJurnalUmum.bantuanaccount;
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select rek_kode Account, rek_nama AccountName from Trekening where rek_isaktif=1';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
   If CDS.State <> dsEdit then
   CDS.Edit;

      CDS.FieldByName('account').AsString := varglobal;
      CDS.FieldByName('accountName').AsString := varglobal1;



  end;
end;


procedure TfrmJurnalUmum.clAccountPropertiesEditValueChanged(
  Sender: TObject);
  var
    s:string;
    tsql:TMyQuery;
    i:integer;
begin
   cxGrdMain.DataController.Post;
   i := cxGrdMain.DataController.FocusedRecordIndex;
  s:= 'select rek_kode,rek_nama from trekening where rek_isaktif=1 and rek_kode='
  + Quot(cxGrdMain.DataController.Values[i, claccount.Index]);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not eof then
      begin
         If CDS.State <> dsEdit then
           CDS.Edit;

          CDS.FieldByName('account').AsString := Fields[0].AsString;
          CDS.FieldByName('accountName').AsString := Fields[1].AsString;

      end
      else
      bantuanaccount;
    finally
      Free;
    end;
  end;

end;



end.
