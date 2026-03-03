unit ufrmSettingKomisi2;

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
  TfrmSettingKomisi2 = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtbatasinkaso: TAdvEdit;
    edtkomisibatasinkaso: TAdvEdit;
    edtbatasJual: TAdvEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid1: TcxGrid;
    cxGrdMain1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBTableView2: TcxGridDBTableView;
    lvmaster1: TcxGridLevel;
    cxGrdMain1Column1: TcxGridDBColumn;
    Label1: TLabel;
    cxGrid2: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrdMain1Column2: TcxGridDBColumn;
    cxGrdMain1Column3: TcxGridDBColumn;
    cxGrdMain1Column4: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    function GetCDS1: TClientDataSet;
    function GetCDS2: TClientDataSet;

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  protected
    FCDS1: TClientDataSet;
    FCDS2: TClientDataSet;
  public
    property CDS1: TClientDataSet read GetCDS1 write FCDS1;
    property CDS2: TClientDataSet read GetCDS2 write FCDS2;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmSettingKomisi2: TfrmSettingKomisi2;
 const
     NOMERATOR = 'SK';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmSettingKomisi2.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS1, False, False);
     TcxDBGridHelper(cxGrdMain1).LoadFromCDS(CDS2, False, False);
end;

procedure TfrmSettingKomisi2.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  edtbatasinkaso.Text := '0';
  edtbatasJual.Text := '0';
  edtkomisibatasinkaso.Text := '0';

    initgrid;
end;
procedure TfrmSettingKomisi2.initgrid;
begin
  CDS1.EmptyDataSet;
  CDS1.Append;
  CDS1.Post;
  CDS2.EmptyDataSet;
  CDS2.Append;
  CDS2.Post;

end;

procedure TfrmSettingKomisi2.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmSettingKomisi2.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSettingKomisi2.loaddata;
var
  s: string;
  tsql : TMyQuery;
  i:Integer;
begin
  s:= 'select * from '
    + ' tkomisisales_hdr ';
tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtbatasinkaso.Text := fieldbyname('ksh_batas_inkaso').AsString;
      edtkomisibatasinkaso.Text := fieldbyname('ksh_komisi_batas_inkaso').AsString;
      edtbatasJual.Text := fieldbyname('ksh_batas_penjualan').AsString;
    end;
  finally
    free;
  end;

 end;
   s:= 'select * from '
    + ' tkomisisales_inkaso ';
tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
  try

    CDS2.EmptyDataSet;
    i:=1;
    while  not Eof do
    begin
      CDS2.Append;
      CDS2.FieldByName('batasbawah2').AsFloat  := fieldbyname('ksj_bawah').AsFloat;
      CDS2.FieldByName('batasatas2').AsFloat  := fieldbyname('ksj_atas').AsFloat;
      CDS2.FieldByName('komisi2').AsFloat  := fieldbyname('ksj_komisi').AsFloat;
      CDS2.FieldByName('komisi2a').AsFloat  := fieldbyname('ksj_komisi2').AsFloat;
      CDS2.FieldByName('komisi2b').AsFloat  := fieldbyname('ksj_komisi3').AsFloat;
      CDS2.FieldByName('komisi2c').AsFloat  := fieldbyname('ksj_komisi4').AsFloat;
      CDS2.Post;
      i:=i+1;
      next;
    end;
  finally
    free;
  end;

 end;

   s:= 'select * from '
    + ' tkomisisales_jual ';
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
      CDS1.FieldByName('batasbawah').AsFloat  := fieldbyname('ksj_bawah').AsFloat;
      CDS1.FieldByName('batasatas').AsFloat  := fieldbyname('ksj_atas').AsFloat;
      CDS1.FieldByName('komisi').AsFloat  := fieldbyname('ksj_komisi').AsFloat;
      CDS1.Post;
      i:=i+1;
      next;

    end;
  finally
    free;
  end;

 end;

end;


procedure TfrmSettingKomisi2.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
begin
     s:= ' delete from tkomisisales_hdr ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

      s:='insert into tkomisisales_hdr (ksh_batas_inkaso,ksh_komisi_batas_inkaso,ksh_batas_penjualan)'
      + ' values ('
      + floattostr(cStrToFloat(edtbatasinkaso.Text)) + ','
      + floattostr(cStrToFloat(edtkomisibatasinkaso.Text)) + ','
      + floattostr(cStrToFloat(edtbatasJual.Text)) + ');';

  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

   tt := TStringList.Create;
   s:= ' delete from tkomisisales_jual ';

   tt.Append(s);
   s:= ' delete from tkomisisales_inkaso ';

   tt.Append(s);

     CDS1.First;
    i:=1;
  while not CDS1.Eof do
  begin
   if not CDS1.FieldByName('batasbawah').IsNull then
   begin

    S:='insert into tkomisisales_jual (ksj_bawah,ksj_atas,ksj_komisi) values ('
      + FloatToStr(CDS1.FieldByName('batasbawah').AsFloat)+','
      + FloatToStr(CDS1.FieldByName('batasatas').AsFloat)+','
      + FloatToStr(CDS1.FieldByName('komisi').AsFloat)
      + ');';
    tt.Append(s);
   end;
    CDS1.Next;
    Inc(i);
  end;
  i:=1;
  CDS2.First;
  while not CDS2.Eof do
  begin
   if not CDS2.FieldByName('batasbawah2').IsNull then
   begin
    S:='insert into tkomisisales_inkaso (ksj_bawah,ksj_atas,ksj_komisi,ksj_komisi2,ksj_komisi3,ksj_komisi4) values ('
      + quot(CDS2.FieldByName('batasbawah2').Asstring)+','
      + quot(CDS2.FieldByName('batasatas2').Asstring)+','
      + quot(CDS2.FieldByName('komisi2').Asstring) + ','
      + quot(CDS2.FieldByName('komisi2a').Asstring) + ','
      + quot(CDS2.FieldByName('komisi2b').Asstring) + ','
      + quot(CDS2.FieldByName('komisi2c').Asstring)
      + ');';
    tt.Append(s);
   end;
    CDS2.Next;
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


procedure TfrmSettingKomisi2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmSettingKomisi2.cxButton1Click(Sender: TObject);
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

procedure TfrmSettingKomisi2.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSettingKomisi2.cxButton2Click(Sender: TObject);
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
procedure TfrmSettingKomisi2.FormShow(Sender: TObject);
begin
refreshdata;
loaddata;
end;

procedure TfrmSettingKomisi2.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

function TfrmSettingKomisi2.GetCDS1: TClientDataSet;
begin
  If not Assigned(FCDS1) then
  begin
    FCDS1 := TClientDataSet.Create(Self);
    zAddField(FCDS1, 'No', ftInteger, False);
    zAddField(FCDS1, 'Batasbawah', ftfloat, False);
    zAddField(FCDS1, 'Batasatas', ftfloat, False);
    zAddField(FCDS1, 'Komisi', ftfloat, False);
    FCDS1.CreateDataSet;
  end;
  Result := FCDS1;
end;

function TfrmSettingKomisi2.GetCDS2: TClientDataSet;
begin
  If not Assigned(FCDS2) then
  begin
    FCDS2 := TClientDataSet.Create(Self);
    zAddField(FCDS2, 'No', ftInteger, False);
    zAddField(FCDS2, 'Batasbawah2', ftfloat, False);
    zAddField(FCDS2, 'Batasatas2', ftfloat, False);
    zAddField(FCDS2, 'Komisi2', ftfloat, False);
    zAddField(FCDS2, 'Komisi2a', ftfloat, False);
    zAddField(FCDS2, 'Komisi2b', ftfloat, False);
    zAddField(FCDS2, 'Komisi2c', ftfloat, False);
    FCDS2.CreateDataSet;
  end;
  Result := FCDS2;
end;

end.
