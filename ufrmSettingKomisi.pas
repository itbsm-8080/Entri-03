unit ufrmSettingKomisi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, cxCurrencyEdit, MyAccess;

type
  TfrmSettingKomisi = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtTarget: TAdvEdit;
    edtHpp: TAdvEdit;
    edtHETBawah: TAdvEdit;
    edtHETAtas: TAdvEdit;
    edtHNA: TAdvEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrdMain1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    clSalesman: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    cxGridDBTableView2: TcxGridDBTableView;
    lvmaster1: TcxGridLevel;
    clTarget: TcxGridDBColumn;
    edtNomor: TAdvEditBtn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clCustomerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure edtNomorClickBtn(Sender: TObject);
    procedure edtNomorExit(Sender: TObject);
    function GetCDS1: TClientDataSet;
    function Getmaxkode:string;
    procedure cxGridDBColumn2PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure HapusRecord1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
    FCDS1: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDS1: TClientDataSet read GetCDS1 write FCDS1;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmSettingKomisi: TfrmSettingKomisi;
 const
     NOMERATOR = 'SK';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmSettingKomisi.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     TcxDBGridHelper(cxGrdMain1).LoadFromCDS(CDS1, False, False);
end;

procedure TfrmSettingKomisi.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  edtNomor.Text := Getmaxkode;
  edtNama.Clear;
  edtTarget.Text := '0';
  edtHpp.Text := '0';
  edtHETBawah.Text := '0';
  edtHETAtas.Text := '0';
  edtHNA.Text := '0';

    initgrid;
end;
procedure TfrmSettingKomisi.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
  CDS1.EmptyDataSet;
  CDS1.Append;
  CDS1.Post;

end;

procedure TfrmSettingKomisi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


  if Key= VK_F10 then
  begin
    try
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
end;

procedure TfrmSettingKomisi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSettingKomisi.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
  i:Integer;
begin
  s:= 'select * from '
    + ' tprodukmarketing_hdr '
    + ' left join tprodukmarketing_dtl  on pmh_nomor=pmd_pmh_nomor '
    + ' left join tbarang on brg_kode=pmd_brg_kode '
    + ' where pmh_nomor = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtNama.Text := fieldbyname('pmh_nama').AsString;
      edtTarget.Text := fieldbyname('pmh_insentif').AsString;
      edtHpp.Text := fieldbyname('pmh_hpp').AsString;
      edtHETBawah.Text := fieldbyname('pmh_het_bawah').AsString;
      edtHETAtas.Text := fieldbyname('pmh_het_atas').AsString;
      edtHNA.Text := fieldbyname('pmh_hna').AsString;

      FID :=fieldbyname('pmh_nomor').Asstring;

    CDS.EmptyDataSet;
    i:=1;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('no').AsString := IntToStr(i);
      CDS.FieldByName('kode').AsString  := fieldbyname('pmd_brg_kode').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('brg_nama').AsString;
      CDS.Post;
      i:=i+1;
      next;
    end;


   end;
  finally
    Free;
  end;
 end;
  s:= 'select * from '
  + ' tprodukmarketing_hdr '
  + ' left join tprodukmarketing_dtl2  on pmh_nomor=pmd2_pmh_nomor '
  + ' where pmh_nomor = ' + Quot(akode) ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
  try
    CDS1.EmptyDataSet;
    i:=1;
    while  not Eof do
    begin
      CDS1.Append;
      CDS1.FieldByName('no').AsString := IntToStr(i);
      CDS1.FieldByName('salesman').asstring  := fieldbyname('pmd2_salesman').asstring;
      CDS1.FieldByName('nama').asstring  := fieldbyname('pmd2_nama').asstring;
      CDS1.FieldByName('target').AsFloat  := fieldbyname('pmd2_target').AsFloat;
      CDS1.Post;
      i:=i+1;
      next;
    end;
  finally
    free;
  end;
 end;

end;


procedure TfrmSettingKomisi.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
begin
  if FLAGEDIT then
  begin
    s:=' update tprodukmarketing_hdr set '
     + ' pmh_nama = ' + Quot(edtNama.Text) +','
     + ' pmh_insentif = ' + floattostr(cStrToFloat(edtTarget.Text)) + ','
     + ' pmh_hpp = ' + floattostr(cStrToFloat(edtHpp.Text)) + ','
     + ' pmh_het_bawah = ' + floattostr(cStrToFloat(edtHETBawah.Text)) + ','
     + ' pmh_het_atas = ' + floattostr(cStrToFloat(edtHETAtas.Text)) + ','
     + ' pmh_hna = ' + floattostr(cStrToFloat(edtHNA.Text)) + ' where '
     + ' pmh_nomor = ' + Quot(edtNomor.Text) + ';';
  end
  else
  begin
      s:='insert into tprodukmarketing_hdr (pmh_nomor,pmh_nama,pmh_insentif,pmh_hpp,'
      + ' pmh_het_bawah,pmh_het_atas,pmh_hna)'
      + ' values ('
      + quot(edtNomor.Text) + ','
      + quot(edtNama.Text) + ','
      + floattostr(cStrToFloat(edtTarget.Text)) + ','
      + floattostr(cStrToFloat(edtHpp.Text)) + ','
      + floattostr(cStrToFloat(edtHETBawah.Text)) + ','
      + floattostr(cStrToFloat(edtHETAtas.Text)) + ','
      + floattostr(cStrToFloat(edthna.Text)) + ');';
  end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from tprodukmarketing_dtl '
      + ' where  PMD_pmh_nomor =' + quot(FID) ;
   tt.Append(s);
   s:= ' delete from tprodukmarketing_dtl2 '
      + ' where  pmd2_pmh_nomor =' + quot(FID) ;
   tt.Append(s);

      CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if not CDS.FieldByName('kode').IsNull then
   begin
    S:='insert into tprodukmarketing_dtl (pmd_pmh_nomor,pmd_brg_kode) values ('
      + Quot(edtNomor.Text) +','
      + quot(CDS.FieldByName('kode').Asstring)
      + ');';
    tt.Append(s);
   end;
    CDS.Next;
    Inc(i);
  end;
  i:=1;
  CDS1.First;
  while not CDS1.Eof do
  begin
   if not CDS1.FieldByName('salesman').IsNull then
   begin
    S:='insert into tprodukmarketing_dtl2 (pmd2_pmh_nomor,pmd2_salesman,pmd2_nama,pmd2_target) values ('
      + Quot(edtNomor.Text) +','
      + quot(CDS1.FieldByName('salesman').Asstring)+','
      + quot(CDS1.FieldByName('nama').Asstring)+','
      + quot(CDS1.FieldByName('target').Asstring)
      + ');';
    tt.Append(s);
   end;
    CDS1.Next;
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


procedure TfrmSettingKomisi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmSettingKomisi.cxButton1Click(Sender: TObject);
begin
    try
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

procedure TfrmSettingKomisi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSettingKomisi.cxButton2Click(Sender: TObject);
begin
   try
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
procedure TfrmSettingKomisi.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmSettingKomisi.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmSettingKomisi.clCustomerPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:integer;
begin
     sqlbantuan := ' SELECT brg_kode Kode,brg_nama Nama from tbarang ';

  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
   for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (VarToStr(cxGrdMain.DataController.Values[i, clCustomer.Index]) = VarToStr(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
       then
      begin
          ShowMessage('Kode ada yang sama dengan baris '+ IntToStr(i+1));
          CDS.Cancel;
          exit;
      end;
    end;
   If CDS.State <> dsEdit then
         CDS.Edit;

      CDS.FieldByName('kode').AsString := varglobal;
      CDS.FieldByName('nama').AsString := varglobal1;

  end;

end;

procedure TfrmSettingKomisi.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSettingKomisi.edtNomorClickBtn(Sender: TObject);
begin
     sqlbantuan := ' SELECT pmh_nomor Nomor,pmh_nama Nama,pmh_insentif Insentif from tprodukmarketing_hdr ';

  sqlfilter := 'Nomor,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
    edtNomor.Text := varglobal;
  end;

end;

procedure TfrmSettingKomisi.edtNomorExit(Sender: TObject);
begin
loaddata(edtNomor.Text);
end;

function TfrmSettingKomisi.GetCDS1: TClientDataSet;
begin
  If not Assigned(FCDS1) then
  begin
    FCDS1 := TClientDataSet.Create(Self);
    zAddField(FCDS1, 'No', ftInteger, False);
    zAddField(FCDS1, 'Salesman', ftString, False,20);
    zAddField(FCDS1, 'Nama', ftString, False,100);
    zAddField(FCDS1, 'Target', ftfloat, False);
    FCDS1.CreateDataSet;
  end;
  Result := FCDS1;
end;

function TfrmSettingKomisi.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(pmh_nomor,4)) from tprodukmarketing_hdr where pmh_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.%');
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
end;


procedure TfrmSettingKomisi.cxGridDBColumn2PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:Integer;
begin
     sqlbantuan := ' SELECT sls_kode Kode,sls_nama Nama from tsalesman ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
   for i := 0 to cxGrdMain1.DataController.RecordCount-1 do
    begin

      If (VarToStr(cxGrdMain1.DataController.Values[i, clsalesman.Index]) = VarToStr(varglobal)) and (cxGrdMain1.DataController.FocusedRecordIndex <> i)
       then
      begin
          ShowMessage('Salesman ada yang sama dengan baris '+ IntToStr(i+1));
          CDS1.Cancel;
          exit;
      end;
    end;
   If CDS1.State <> dsEdit then
         CDS1.Edit;

      CDS1.FieldByName('salesman').AsString := varglobal;
      CDS1.FieldByName('nama').AsString := varglobal1;

  end;


end;

procedure TfrmSettingKomisi.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmSettingKomisi.MenuItem1Click(Sender: TObject);
begin
 If CDS1.Eof then exit;
  CDS1.Delete;
  If CDS1.Eof then initgrid;
end;

end.
