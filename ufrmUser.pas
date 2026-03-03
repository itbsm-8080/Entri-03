unit ufrmUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Grids,
  BaseGrid, AdvGrid, AdvCGrid, Menus, cxLookAndFeelPainters, cxButtons,
  cxGraphics, cxLookAndFeels, dxSkinsCore, dxSkinsDefaultPainters, MyAccess;

type
  TfrmUser = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    Label2: TLabel;
    edtKode: TAdvEdit;
    Label3: TLabel;
    edtNama: TAdvEdit;
    Label1: TLabel;
    AdvPanel3: TAdvPanel;
    GridDetail: TAdvColumnGrid;
    edtPassword: TEdit;
    AdvPanel4: TAdvPanel;
    cxButton1: TcxButton;
    cxButton8: TcxButton;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtKodeExit(Sender: TObject);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure hapusdata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure loadmenu;
    procedure simpandetailuser;
    procedure FormShow(Sender: TObject);
    procedure Loadcekbox;
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);

  private
    FLAGEDIT : Boolean;
    FID : string;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  frmUser: TfrmUser;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmUser.refreshdata;
begin
  edtKode.Clear;
  edtNama.Clear;
  edtPassword.Clear;
  LoadMenu;
  edtKode.SetFocus;
end;
procedure TfrmUser.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key =VK_F1) AND (Sender=edtKode) then
  begin
       sqlbantuan := 'select User_Kode Kode,user_nama Nama'
                  + ' from tuser' ;
      sqlfilter := 'Kode,Nama';
      Application.CreateForm(Tfrmbantuan,frmbantuan);
      frmBantuan.SQLMaster := sqlbantuan;
      frmBantuan.ShowModal;
        if varglobal <> '' then
      edtkode.Text := varglobal;
  end;

  if Key = VK_F8 then
  begin
     if  MessageDlg('Ingin Keluar dari Modul ?',mtCustom,
                                  [mbYes,mbNo], 0) = mrYes
     then Release;
  end;

  if Key = VK_F7 then
  begin
      if MessageDlg('Ingin membatalkan transaksi ?',mtCustom,
                                  [mbYes,mbNo], 0) = mrYes
      then refreshdata;
  end;
  if Key = VK_F5 then
  begin
     try
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      hapusdata;
      refreshdata;
   except
     ShowMessage('Gagal hapus');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
  end;


  if Key= VK_F10 then
  begin
    if edtKode.Text = '' then
    begin
        ShowMessage('Kode Kosong, tidak dapat disimpan');
        edtKode.SetFocus;
        Exit;
    end;


    try
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

procedure TfrmUser.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmUser.edtKodeExit(Sender: TObject);
begin

   loaddata(edtKODE.Text);
   Loadcekbox;
end;
procedure TfrmUser.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select user_kode,user_nama,user_password,user_edit from tuser where user_kode= ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      FID :=Fields[0].Asstring;
      edtNama.Text := fieldbyname('user_nama').AsString;
      edtPassword.Text := fieldbyname('user_password').AsString;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmUser.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tuser set '
    + ' user_nama = ' + Quot(edtNama.Text) + ','
    + ' user_password = ' + Quot(edtPassword.Text)
    + ' where user_kode = ' + quot(FID) + ';'
else
begin
  s :=  ' insert into tuser'
             + ' (user_kode,user_nama,user_password) '
             + ' values ( '
             + Quot(edtkode.Text) + ','
             + Quot(edtNama.Text) + ','
             + Quot(edtPassword.Text)
             + ');';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
simpandetailuser;
end;


procedure TfrmUser.hapusdata;
var
  s:string;
begin
  s:='delete from tuser'
    + ' where user_kode= ' + Quot(edtkode.Text) + ';' ;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;
procedure TfrmUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;


procedure TfrmUser.loadmenu;
var
  s: string;
  tsql : TMyQuery;
  i : integer;
begin
  cClearGrid(GridDetail,false);
  i:= 0 ;
  s := 'select * from tmenu where men_modul=1 order by men_keterangan';
  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
   try
    while not Eof do
    begin
      i:=i + 1;
      if i > 1 then
      GridDetail.AddRow;
      GridDetail.Cells[0,i] := IntToStr(i);
      GridDetail.Cells[1,i] := Fields[0].AsString;
      GridDetail.Cells[2,i] := Fields[1].AsString;
      GridDetail.Cells[3,i] := Fields[2].AsString;
      Next;
    end
   finally
     free;
   end;
  end;
  GridDetail.AutoSize := true;
end;

procedure TfrmUser.simpandetailuser;
var
  s:string ;
  tsqlsimpan : TStrings ;
  i : Integer ;
begin

  tsqlsimpan := TStringList.Create;

    s := 'delete from tHAKuser where hak_user_kode= ' + Quot(FID)
     + ' and hak_men_id in ( select men_id from tmenu where men_modul=1) ';
    tsqlsimpan.Add(s);
    for i := 1 to GridDetail.RowCount - 1 do
    begin
      with GridDetail do
      begin

       if Cells[1,i] <> '' then
       begin

         if (GridDetail.cells[4,i] = 'Y') then
         BEGIN
         s:= ' insert into thakuser (HAK_user_kode,HAK_men_id,hak_men_insert,hak_men_edit,hak_men_delete) values ('
           +  quot(fid) + ','
           +  QUOT(cells[1,i]) + ','
           + QUOT(Cells[5,i]) + ','
           + QUOT(Cells[6,i]) + ','
           + QUOT(Cells[7,i])
           + ');';
           tsqlsimpan.Add(s);
         end;
        end;
      end;

    end;

  try
        for i:=0 to tsqlsimpan.Count -1 do
        begin
            // xExecQuery(tsqlsimpan[i],frmMenu.conn)
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tsqlsimpan[i]);
        end;

  finally
   tsqlsimpan.Free ;
  end;
  // TODO -cMM: TfrmDataPribadi.simpandetailanak default body inserted
end;
procedure TfrmUser.FormShow(Sender: TObject);
begin
  ShowWindowAsync(Handle, SW_MAXIMIZE);
  refreshdata;
end;
procedure TfrmUser.Loadcekbox;
var
  s: string;
  tsql : TMyQuery;
  k : integer;
begin
  for k := 1 to GridDetail.RowCount-1 do
  begin
       GridDetail.Cells[4,k] := 'N' ;
       GridDetail.Cells[5,k] := 'N';
       GridDetail.Cells[6,k] := 'N';
       GridDetail.Cells[7,k] := 'N';
  end;
  s := 'select hak_user_kode,hak_men_id,hak_men_insert,hak_men_edit,hak_men_delete from thakuser where hak_user_kode =  ' + quot(FID);
  tsql := xOpenQuery(s, frmMenu.conn);
  with tsql do
  begin
    try
    while not Eof do
    begin

      for k := 1 to GridDetail.RowCount-1 do
      begin
         IF GridDetail.Cells[1,k] = Fields[1].AsString then
         begin
           GridDetail.Cells[4,k] := 'Y' ;
           GridDetail.Cells[5,k] := Fields[2].AsString;
           GridDetail.Cells[6,k] := Fields[3].AsString;
           GridDetail.Cells[7,k] := Fields[4].AsString;
           break;
         End

      end;
      Next;
    end

   finally
     free;
   end;  
  end;
end;


procedure TfrmUser.cxButton8Click(Sender: TObject);
begin
 release;
end;

procedure TfrmUser.cxButton1Click(Sender: TObject);
begin
      if edtKode.Text = '' then
    begin
        ShowMessage('Kode Kosong, tidak dapat disimpan');
        edtKode.SetFocus;
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

    try
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

end.
