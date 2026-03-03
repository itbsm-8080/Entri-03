unit ufrmSubBarang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox,DBClient, MyAccess;

type
  TfrmSubBarang = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtKode: TAdvEdit;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label1: TLabel;
    cxLookupSubKode: TcxExtLookupComboBox;
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
    procedure edtKodeExit(Sender: TObject);
    procedure initview;
    procedure cxLookupSubKodePropertiesChange(Sender: TObject);
    

  private
    FCDSSubBarang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    FTingkat : Integer;
    function GetCDSSubBarang: TClientDataset;

    { Private declarations }
  public
    property CDSSubBarang: TClientDataset read GetCDSSubBarang write FCDSSubBarang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    property Tingkat: Integer read FTingkat write FTingkat;
    { Public declarations }
  end;

var
  frmSubBarang: TfrmSubBarang;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmSubBarang.refreshdata;
begin
  FID:='';
  flagedit := false;
  cxLookupSubKode.Enabled := true;
  edtNama.Clear;
  edtNama.SetFocus;
end;
procedure TfrmSubBarang.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmSubBarang.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSubBarang.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select ktg_kode,ktg_nama from tkategori where ktg_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtKode.Enabled := False;
      edtNama.Text := fieldbyname('ktg_nama').AsString;
      FID :=fieldbyname('ktg_kode').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmSubBarang.simpandata;
var
  s:string;
begin
if FLAGEDIT then
begin

  s:='update tkategori set '
    + ' ktg_nama = ' + Quot(edtNama.Text)
    + ' where ktg_kode = ' + quot(FID) + ';';
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s); 
end
else
begin

  s :=  ' insert into tkategori '
             + ' (ktg_kode,ktg_nama,ktg_tingkat) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text) + ' ,'
             + IntToStr(FTingkat)
             + ');';
    // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
    edtkode.Text := getmaxkode;
end;


end;


procedure TfrmSubBarang.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmSubBarang.getmaxkode:string;
var
  s:string;
begin
if FTingkat =1 then
begin
   s:= 'select  max(ktg_kode) from tkategori where ktg_tingkat='+IntToStr(FTingkat);
   with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= '1'
      else
         result:= vartostr(IntToStr(fields[0].AsInteger+1));

    finally
      free;
    end;
  end;
end
else
if  FTingkat =2 then
begin
  s:=' SELECT substr(ktg_kode,3,length(ktg_kode)-'+IntToStr(FTingkat)+') jml FROM  TKATEGORI where ktg_kode like '+quot(cxLookupSubKode.EditValue+'%')
  +  ' and ktg_tingkat='+ IntToStr(FTingkat)+' order by length(ktg_kode) desc, ktg_kode desc limit  1';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= vartostr(cxLookupSubKode.EditValue)+'.1'
      else
         result:= vartostr(cxLookupSubKode.EditValue)+'.'+IntToStr(fields[0].AsInteger+1);

    finally
      free;
    end;
  end;
end
else
begin
  s:=' SELECT substr(ktg_kode,'+IntToStr(FTingkat+2)+',length(ktg_kode)-'+IntToStr(FTingkat+1)+') jml FROM  TKATEGORI where ktg_kode like '+quot(cxLookupSubKode.EditValue+'%')
  +  ' and ktg_tingkat='+ IntToStr(FTingkat)+' order by length(ktg_kode) desc, ktg_kode desc limit  1';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= vartostr(cxLookupSubKode.EditValue)+'.1'
      else
         result:= vartostr(cxLookupSubKode.EditValue)+'.'+IntToStr(fields[0].AsInteger+1);

    finally
      free;
    end;
  end;
end;
end;

procedure TfrmSubBarang.cxButton1Click(Sender: TObject);
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

procedure TfrmSubBarang.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSubBarang.cxButton2Click(Sender: TObject);
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

procedure TfrmSubBarang.edtKodeExit(Sender: TObject);
begin
loaddata(edtKode.Text);
end;

function TfrmSubBarang.GetCDSSubBarang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSSubBarang) then
  begin
    S := 'select ktg_nama as Nama, ktg_kode Kode'
        +' from tkategori where ktg_tingkat ='+ inttostr(ftingkat-1);


    FCDSSubBarang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSSubBarang;
end;

procedure TfrmSubBarang.initview;
begin
  with TcxExtLookupHelper(cxLookupSubKode.Properties) do
    LoadFromCDS(CDSSubBarang, 'Kode','Nama',['Kode'],Self);
end;


procedure TfrmSubBarang.cxLookupSubKodePropertiesChange(Sender: TObject);
begin
edtkode.text := getmaxkode;
end;

end.
