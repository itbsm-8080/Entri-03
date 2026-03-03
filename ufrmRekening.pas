unit ufrmRekening;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, DBClient, MyAccess;

type
  TfrmRekening = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtKode: TAdvEdit;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupKelompok: TcxExtLookupComboBox;
    chkAktif: TCheckBox;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FCDSKelompok: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSKelompok: TClientDataset;
    function cekKode(akode:string):boolean;


    { Private declarations }
  public
    property CDSKelompok: TClientDataset read GetCDSKelompok write FCDSKelompok;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmRekening: TfrmRekening;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmRekening.refreshdata;
begin
  FID:='';
  edtKode.clear;
  edtNama.Clear;
  edtKODE.SetFocus;
  chkAktif.Checked := False;
end;
procedure TfrmRekening.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmRekening.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmRekening.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select rek_kode,rek_nama,rek_kol_id,rek_isaktif from trekening where rek_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      cxLookupKelompok.EditValue :=FieldByName('REK_kol_id').AsInteger;
      EDTKODE.TEXT := fieldbyname('rek_kode').AsString;
      edtNama.Text := fieldbyname('rek_nama').AsString;
      if FieldByName('rek_isaktif').AsInteger = 1 then
         chkAktif.Checked :=True
      else
         chkAktif.Checked := false;

      FID :=fieldbyname('rek_kode').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmRekening.simpandata;
var
  s:string;
  isaktif :integer;
begin
    if chkAktif.Checked then
     isaktif := 1
  else
    isaktif := 0;

if FLAGEDIT then
  s:='update trekening set '
    + ' rek_nama = ' + Quot(edtNama.Text) + ','
    + ' rek_isaktif= ' + IntToStr(isaktif) + ','
    + ' rek_kol_id = ' + VarToStr(cxLookupKelompok.EditValue)
    + ' where rek_kode = ' + quot(FID) + ';'
else
begin

  s :=  ' insert into trekening '
             + ' (rek_kode,rek_nama,rek_kol_id,rek_isaktif) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text) + ','
             + VarToStr( cxLookupKelompok.EditValue)+','
             + IntToStr(isaktif)
             + ');';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmRekening.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmRekening.cxButton1Click(Sender: TObject);
begin
    try
      if edtkode.Text = '' then
      begin
         MessageDlg('Kode belum di isi',mtWarning, [mbOK],0);
        exit;
      end;
      if (cekKode(edtkode.Text)) and ( not FLAGEDIT) then
      begin
         MessageDlg('Kode Sudah ada',mtWarning, [mbOK],0);
        exit;
      end;

      if VarToStr(cxLookupKelompok.EditValue) = '' then
      begin
         MessageDlg('Kelompok belum di pilih',mtWarning, [mbOK],0);
        exit;
      end;
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

procedure TfrmRekening.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmRekening.cxButton2Click(Sender: TObject);
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

procedure TfrmRekening.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupKelompok.Properties) do
    LoadFromCDS(CDSKelompok, 'Kode','Nama',['Kode'],Self);

end;

function TfrmRekening.GetCDSKelompok: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSKelompok) then
  begin
    S := 'select kol_nama as Nama, kol_id Kode'
        +' from tkelompok';


    FCDSKelompok := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSKelompok;
end;

function TfrmRekening.cekKode(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
  s:='select * from trekening where rek_kode='+ quot(akode);
  tsql := xopenquery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not eof then
         Result := True;
    finally
      free;
    end;
  end;
end;


end.
