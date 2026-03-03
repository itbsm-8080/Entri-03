unit ufrmSalesman;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  MyAccess;

type
  TfrmSalesman = class(TForm)
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
    dtTanggal: TDateTimePicker;
    AdvPanel4: TAdvPanel;
    Label7: TLabel;
    Label8: TLabel;
    cbbTahun: TComboBox;
    AdvColumnGrid1: TAdvColumnGrid;
    Label9: TLabel;
    cbAktif: TCheckBox;
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
    procedure loadtogrid;
    procedure cbbTahunChange(Sender: TObject);

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
  frmSalesman: TfrmSalesman;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmSalesman.refreshdata;
begin
  FID:='';
  edtKode.Text := getmaxkode;
  edtNama.Clear;
  edtKota.Clear;
  edtAlamat.Clear;
  edtTelp.Clear;
  dtTanggal.Date := Date;
  cbAktif.Checked := false;
  edtNama.SetFocus;
  loadtogrid;
end;
procedure TfrmSalesman.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmSalesman.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSalesman.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select * from tsalesman where sls_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtNama.Text := fieldbyname('sls_nama').AsString;
      edtkota.Text := fieldbyname('sls_kota').AsString;
      edtAlamat.Text := fieldbyname('sls_alamat').AsString;
      edtTelp.Text := fieldbyname('sls_telp').AsString;
      dtTanggal.DateTime := fieldbyname('sls_tglmasuk').AsDateTime;
      if fieldbyname('sls_isaktif').AsInteger = 1  then
        cbAktif.Checked := True
      else
        cbAktif.Checked := false;

      FID :=fieldbyname('sls_kode').Asstring;
      loadtogrid;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmSalesman.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aisaktif:integer;
begin
  if cbAktif.Checked then
    aisaktif := 1
  else
    aisaktif :=0;
if FLAGEDIT then
  s:='update tsalesman set '
    + ' sls_nama = ' + Quot(edtNama.Text) + ','
    + ' sls_kota = ' + Quot(edtKota.Text) + ','
    + ' sls_alamat = ' + Quot(edtAlamat.Text)+','
    + ' sls_telp = ' + Quot(edtTelp.Text) + ','
    + ' sls_tglmasuk =' + QuotD(dtTanggal.Date)+ ','
    + ' sls_cabang ='+ Quot(frmMenu.KDCABANG)+','
    + ' sls_isaktif = ' + IntToStr(aisaktif) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where sls_kode = ' + quot(FID) + ';'
else
begin
  edtKode.Text := getmaxkode;
  s :=  ' insert into tsalesman '
             + ' (sls_kode,sls_nama,sls_kota,sls_alamat,sls_telp,sls_tglmasuk,sls_cabang,sls_isaktif,date_create,user_create) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text) + ','
             + Quot(edtkota.Text)+','
             + Quot(edtAlamat.Text) + ','
             + Quot(edtTelp.Text)  + ','
             + QuotD(dtTanggal.Date)+','
             + Quot(frmMenu.KDCABANG)+','
             + IntToStr(aisaktif)+ ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from tsalesmantarget '
      + ' where  st_sls_kode =' + quot(FID)
      + ' and st_tahun = ' + cbbTahun.Text;
   tt.Append(s);
   for i := 1 to AdvColumnGrid1.rowcount-1 do
   begin
     if AdvColumnGrid1.Cells[2,i] <> '' then
     begin
        s:='insert into tsalesmantarget '
          + ' (st_sls_kode,st_periode,st_tahun,st_targetsales) values ( '
          +  Quot(FID) + ','
          +  AdvColumnGrid1.Cells[3,i] + ','
          +  cbbTahun.Text + ','
          +  FloatToStr(AdvColumnGrid1.Floats[2,i])
          +');';
       tt.Append(s);
     end;
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


procedure TfrmSalesman.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmSalesman.getmaxkode:string;
var
  s:string;
begin
  s:='select max(sls_kode) from tsalesman';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= '1'
      else
         result:= IntToStr(fields[0].AsInteger+1);

    finally
      free;
    end;
  end;
end;

procedure TfrmSalesman.cxButton1Click(Sender: TObject);
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

procedure TfrmSalesman.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSalesman.cxButton2Click(Sender: TObject);
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
procedure TfrmSalesman.loadtogrid;
var
  s:string;
  tsql:TMyQuery;
  i : Integer;
begin
  cClearGrid(AdvColumnGrid1,false);
  s:='select ID,NAMA,IFNULL(St_TARGETSALES,0) TARGET from tbulan left join tsalesmantarget on '
    + ' id=st_periode and st_tahun = ' + cbbtahun.text
    + ' and st_sls_kode = ' + Quot(edtkode.text) ;
 tsql := xOpenQuery(s,frmMenu.conn);
 i:=0;
 with tsql do
 begin
   try
      while not Eof do
      begin
        i:=i+1;
        AdvColumnGrid1.Cells[0,i] := IntToStr(i);
        AdvColumnGrid1.Cells[1,i] := Fields[1].AsString;
        AdvColumnGrid1.Floats[2,i] := Fields[2].AsFloat;
        AdvColumnGrid1.Cells[3,i] := Fields[0].AsString;
        AdvColumnGrid1.AddRow;
        Next;
      end;
      AdvColumnGrid1.RemoveRows(AdvColumnGrid1.RowCount-1,1);
   finally
     free;
   end;
 end;

end;

procedure TfrmSalesman.cbbTahunChange(Sender: TObject);
begin
loadtogrid;
end;

end.
