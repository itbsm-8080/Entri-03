unit ufrmGudang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, MyAccess;

type
  TfrmGudang = class(TForm)
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
    edtPenanggungjawab: TAdvEdit;
    Label4: TLabel;
    edtKeterangan: TAdvEdit;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  public
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmGudang: TfrmGudang;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmGudang.refreshdata;
begin
  FID:='';
  edtKode.Text := getmaxkode;
  edtNama.Clear;
  edtKeterangan.clear;
  edtPenanggungjawab.Clear;
  edtNama.SetFocus;
end;
procedure TfrmGudang.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmGudang.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmGudang.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select gdg_kode,gdg_nama,gdg_keterangan,gdg_penanggungjawab from tgudang where gdg_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtNama.Text := fieldbyname('gdg_nama').AsString;
      edtKeterangan.Text := fieldbyname('gdg_keterangan').AsString;
      edtPenanggungjawab.Text := fieldbyname('gdg_penanggungjawab').AsString;
      FID :=fieldbyname('gdg_kode').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmGudang.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tgudang set '
    + ' gdg_nama = ' + Quot(edtNama.Text) + ','
    + ' gdg_keterangan = ' + Quot(edtKeterangan.Text) + ','
    + ' gdg_penanggungjawab = ' + Quot(edtPenanggungjawab.Text)
    + ' where gdg_kode = ' + quot(FID) + ';'
else
begin
  edtKode.Text := getmaxkode;
  s :=  ' insert into tgudang '
             + ' (gdg_kode,gdg_nama,gdg_penanggungjawab,gdg_keterangan) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text) + ','
             + Quot(edtPenanggungjawab.Text)+','
             + Quot(edtKeterangan.Text)
             + ');';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmGudang.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmGudang.getmaxkode:string;
var
  s:string;
begin
  s:='select max(SUBSTR(gdg_kode,4,2)) from tgudang WHERE gdg_kode <> "WH-99"';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= 'WH-'+RightStr(IntToStr(100+1),2)
      else
         result:= 'WH-'+RightStr(IntToStr(100+fields[0].AsInteger+1),2);

    finally
      free;
    end;
  end;
end;

procedure TfrmGudang.cxButton1Click(Sender: TObject);
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

procedure TfrmGudang.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmGudang.cxButton2Click(Sender: TObject);
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

end.
