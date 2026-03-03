unit ufrmSupplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  MyAccess;

type
  TfrmSupplier = class(TForm)
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
    edtAlamat: TAdvEdit;
    Label4: TLabel;
    edtKota: TAdvEdit;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label5: TLabel;
    edtTelp: TAdvEdit;
    Label6: TLabel;
    AdvPanel4: TAdvPanel;
    Label7: TLabel;
    edtFax: TAdvEdit;
    Label8: TLabel;
    edtemail: TAdvEdit;
    Label9: TLabel;
    edtCP: TAdvEdit;
    Label10: TLabel;
    edtTop: TAdvEdit;
    Label11: TLabel;
    edtrekening: TAdvEdit;
    Label12: TLabel;
    edtBank: TAdvEdit;
    Label13: TLabel;
    edtCabang: TAdvEdit;
    Label14: TLabel;
    edtAtasnama: TAdvEdit;
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
  frmSupplier: TfrmSupplier;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmSupplier.refreshdata;
begin
  FID:='';
  edtKode.Text := '';
  edtKode.Enabled := True;

  edtNama.Clear;
  edtKota.Clear;
  edtAlamat.Clear;
  edtTelp.Clear;
  edtfax.clear;
  edttop.text := '0';
  edtcp.clear;
  edtemail.clear;

  edtbank.clear;
  edtrekening.clear;
  edtatasnama.clear;
  edtcabang.clear;
  edtKode.SetFocus;
end;
procedure TfrmSupplier.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


  if Key= VK_F10 then
  begin
    try
      if edtKode.Text = '' then
       begin
         MessageDlg('Kode Belum diisi',mtWarning, [mbOK],0);
         Exit;
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
end;

procedure TfrmSupplier.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSupplier.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select * from tsupplier where sup_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtKode.Enabled:=False;
      edtNama.Text := fieldbyname('sup_nama').AsString;
      edtkota.Text := fieldbyname('sup_kota').AsString;
      edtAlamat.Text := fieldbyname('sup_alamat').AsString;
      edtTelp.Text := fieldbyname('sup_telp').AsString;
      edtfax.text :=  fieldbyname('sup_fax').AsString;
      edtcp.text := fieldbyname('sup_cp').AsString;
      edtemail.text := fieldbyname('sup_email').AsString;
//      edthutang.text :=formatfloat('###,###,###.##',fieldbyname('sup_hutang').Asfloat);
      edttop.Text := fieldbyname('sup_top').AsString;
      edtrekening.text := fieldbyname('sup_rekening').AsString;
      edtbank.text := fieldbyname('sup_bank').AsString;
      edtcabang.text :=  fieldbyname('sup_cabang').AsString;
      edtatasnama.text :=  fieldbyname('sup_atasnama').AsString;
      FID :=fieldbyname('sup_kode').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmSupplier.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tsupplier set '
    + ' sup_nama = ' + Quot(edtNama.Text) + ','
    + ' sup_kota = ' + Quot(edtKota.Text) + ','
    + ' sup_alamat = ' + Quot(edtAlamat.Text)+','
    + ' sup_telp = ' + Quot(edtTelp.Text) + ','
    + ' sup_fax =' + Quot(edtFax.Text) + ','
    + ' sup_cp = ' + Quot(edtCP.Text) + ','
    + ' sup_email = ' + quot(edtemail.text) + ','
    + ' sup_top = ' + edttop.text + ','
    + ' sup_rekening = ' + quot(edtrekening.text) + ','
    +' sup_bank = ' + quot(edtbank.text) + ','
    + ' sup_cabang = ' + quot(edtcabang.text)+','
    + ' sup_atasnama = ' + quot(edtatasnama.text) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where sup_kode = ' + quot(FID) + ';'
else
begin
//  edtKode.Text := getmaxkode;
  s :=  ' insert into tsupplier '
             + ' (sup_kode,sup_nama,sup_kota,sup_alamat,sup_telp,sup_fax,sup_cp,sup_email,sup_top,'
             + ' sup_rekening,sup_bank,sup_cabang,sup_atasnama,date_create,user_create) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text) + ','
             + Quot(edtkota.Text)+','
             + Quot(edtAlamat.Text) + ','
             + Quot(edtTelp.Text)  + ','
             + Quot(edtfax.text)+','
             + Quot(edtcp.text) + ','
             + Quot(edtemail.text) + ','
             + edttop.text + ','
             + Quot(edtrekening.text) + ','
             + Quot(edtbank.text)+','
             + Quot(edtcabang.text)+','
             + Quot(edtatasnama.text)+','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmSupplier.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmSupplier.getmaxkode:string;
var
  s:string;
begin
  s:='select max(SUBSTR(sup_kode,2,3)) from tsupplier';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= 'S'+RightStr(IntToStr(1000+1),3)
      else
         result:= 'S'+RightStr(IntToStr(1000+fields[0].AsInteger+1),3);

    finally
      free;
    end;
  end;
end;

procedure TfrmSupplier.cxButton1Click(Sender: TObject);
begin
    try
      if edtKode.Text = '' then
       begin
         MessageDlg('Kode Belum diisi',mtWarning, [mbOK],0);
         Exit;
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

procedure TfrmSupplier.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSupplier.cxButton2Click(Sender: TObject);
begin
   try
     if edtKode.Text = '' then
       begin
         MessageDlg('Kode Belum diisi',mtWarning, [mbOK],0);
         Exit;
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
    Release;
end;

procedure TfrmSupplier.edtKodeExit(Sender: TObject);
begin
loaddata(edtkode.Text);
end;

end.
