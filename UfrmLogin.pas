unit UfrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus,uModuleConnection,Ulib,SqlExpr,AdvPanel,
  AdvEdBtn, AdvEdit, jpeg, cxLookAndFeelPainters, cxButtons, cxGraphics,
  cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, MyAccess;

type
  TfrmLogin = class(TForm)
    AdvPanel1: TAdvPanel;
    TeLabel12: TLabel;
    Label1: TLabel;
    edtUser: TAdvEditBtn;
    AdvPanel2: TAdvPanel;
    Label2: TLabel;
    edtPassword: TEdit;
    cxButton8: TcxButton;
    cxButton1: TcxButton;
    Label3: TLabel;
    edtCabang: TEdit;
    procedure cxButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtuserButtonClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtuserKeyPress(Sender: TObject; var Key: Char);
    procedure edtUserKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure getcabangaktif;  
  private
    { Private declarations }
  public
    procedure loadaksesmenu(aid : string);
        { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation
  uses MAIN, uFrmbantuan;

{$R *.dfm}

procedure TfrmLogin.cxButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormShow(Sender: TObject);

begin
  edtuser.SelectAll;
  edtuser.SetFocus;
  frmMenu.Enabled := False;
  getcabangaktif;
//for k :=0 to frmmenu.file1.Count - 1 do
//  begin
//        frmmenu.file1.Items[k].Enabled := True;
//  end;
//  for k :=0 to frmmenu.Master1.Count - 1 do
//  begin
//        frmmenu.Master1.Items[k].Enabled := True;
//  end;
//   for k :=0 to frmmenu.Piutang1.Count - 1 do
//  begin
//        frmmenu.Piutang1.Items[k].Enabled := True;
//  end;
//  for k :=0 to frmmenu.Pembayaran.Count - 1 do
//  begin
//        frmmenu.Pembayaran.Items[k].Enabled := True;
//  end;
//
//  for k :=0 to frmmenu.Transaksi1.Count - 1 do
//  begin
//        frmmenu.Transaksi1.Items[k].Enabled := True;
//  end;
//    for k :=0 to frmmenu.Laporan1.Count - 1 do
//  begin
//        frmmenu.Laporan1.Items[k].Enabled := True;
//  end;

end;

procedure TfrmLogin.edtuserButtonClick(Sender: TObject);
begin
  sqlbantuan := ' SELECT user_kode Kode,user_Nama Nama from tuser ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtUser.Text := varglobal;
  edtpassword.SetFocus;
end;

procedure TfrmLogin.cxButton2Click(Sender: TObject);
var
  sql, username, password: string;
  tsql : TMyQuery;
begin
  username := Trim(edtUser.Text);
  password := Trim(edtpassword.Text);

  if (username = '')  then
  begin
    MessageDlg('UserName harus disi ',mtInformation, [mbOK],0);
    edtUser.SelectAll;
    edtUser.SetFocus;
    Exit;
  end;

   if (edtCabang.Text = '')  then
  begin
    MessageDlg('Tidak ada cabang yang aktif harus di set dulu ',mtInformation, [mbOK],0);
    edtUser.SelectAll;
    edtUser.SetFocus;
    Exit;
  end;

    sql :=
      ' select user_kode,user_nama  ' +
      ' from tuser  ' +
      ' where ' +
      ' upper(user_kode) = ' + QuotedStr(username) +
      ' and user_password = ' + QuotedStr(password);
   tsql := xOpenQuery(sql,frmmenu.conn);
   with tsql do
   begin
   try
     if not eof then
     begin


         frmmenu.Enabled:=true;
         frmmenu.KDUSER := Fields[0].AsString;
         frmmenu.NMUSER := Fields[1].AsString;
//         loadaksesmenu(Fields[0].AsSTRING);
         frmMenu.StatusBar1.Panels[0].Text := frmMenu.NMUSER;
         self.Hide;

     end
     else
     begin

       MessageDlg('user atau password salah',mtWarning, [mbOK],0);
       edtpassword.Clear;
       edtuser.Clear;edtuser.SetFocus;
     end;

   finally
      Free;
    end;

 end;
end;



procedure TfrmLogin.edtuserKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
     begin
       SelectNext(ActiveControl,True,True);
     end;
end;



procedure TfrmLogin.loadaksesmenu(aid : string);

begin
//  s := 'select men_nama from tmenu where men_nama not in ( '
//    + ' select men_nama from tmenu,thakuser '
//    + ' where hak_men_id = men_id and hak_user_kode= ' + quot(aid) + ')';
//
//  tsql := xOpenQuery(s,frmmenu.conn);
//
//  with tsql do
//  begin
//    try
//      while not Eof do
//      begin
//            for k :=0 to frmmenu.file1.Count - 1 do
//            begin
//               if UpperCase(frmmenu.file1.Items[k].Name) = UpperCase(Fields[0].AsString) then
//                  frmmenu.file1.Items[k].Visible := False;
//
//            end;
//
//            for k :=0 to frmmenu.Transaksi1.Count - 1 do
//            begin
//               if UpperCase(frmmenu.Transaksi1.Items[k].Name) = UpperCase(Fields[0].AsString) then
//                  frmmenu.Transaksi1.Items[k].Visible := False;
//
//            end;
//
//            for k :=0 to frmmenu.Laporan1.Count - 1 do
//            begin
//               if UpperCase(frmmenu.Laporan1.Items[k].Name) = UpperCase(Fields[0].AsString) then
//                  frmmenu.Laporan1.Items[k].Visible := False;
//
//            end;
//
//            for k :=0 to frmmenu.master1.Count - 1 do
//            begin
//               if UpperCase(frmmenu.master1.Items[k].Name) = UpperCase(Fields[0].AsString) then
//                  frmmenu.master1.Items[k].Visible := False;
//
//            end;
//
//            for k :=0 to frmmenu.Piutang1.Count - 1 do
//            begin
//               if UpperCase(frmmenu.Piutang1.Items[k].Name) = UpperCase(Fields[0].AsString) then
//                  frmmenu.Piutang1.Items[k].Visible := False;
//
//            end;
//
//             for k :=0 to frmmenu.Pembayaran.Count - 1 do
//            begin
//               if UpperCase(frmmenu.Pembayaran.Items[k].Name) = UpperCase(Fields[0].AsString) then
//                  frmmenu.Pembayaran.Items[k].Visible := False;
//
//            end;
//            for k :=0 to frmmenu.Master1.Count - 1 do
//            begin
//               if UpperCase(frmmenu.Master1.Items[k].Name) = UpperCase(Fields[0].AsString) then
//                  frmmenu.Master1.Items[k].Visible := False;
//
//            end;
//
//        Next;
//      end;
//     finally
//     Free;
//    end
//  end;
//
end;

procedure TfrmLogin.edtUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key =VK_F1) AND (Sender=edtUser) then
  begin
  sqlbantuan := ' SELECT user_kode Kode,user_Nama Nama from tuser ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
      edtUser.Text := varglobal;
      edtpassword.SetFocus;
   end;
  end;

end;

procedure tfrmLogin.getcabangaktif;
var
  s:string;
  tsql :TMyQuery;
begin
  s:='select cbg_kode,cbg_nama from tcabang where cbg_aktif=1';
  tsql:=xOpenQuery(S,frmMenu.conn);
  with tsql do
  begin
    try
      if not eof then
      begin
        frmMenu.KDCABANG := Fields[0].AsString;
        frmMenu.NMCABANG := Fields[1].AsString;

        edtCabang.Text := Fields[1].AsString;
        frmMenu.StatusBar1.Panels[3].Text := Fields[1].AsString;
      end;
    finally
      free;
    end;
  end;
end;

end.
