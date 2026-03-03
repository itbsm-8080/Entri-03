unit ufrmSPK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  AdvEdBtn, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox,DBClient,
  MyAccess;

type
  TfrmSPK = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtnomorspk: TAdvEdit;
    Label3: TLabel;
    edtNamaspk: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    Label4: TLabel;
    edtNamaBarang: TAdvEdit;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label5: TLabel;
    Label6: TLabel;
    AdvPanel4: TAdvPanel;
    Label13: TLabel;
    edtJumlah: TAdvEdit;
    Label16: TLabel;
    edtKeterangan: TAdvEdit;
    edtKodeBarang: TAdvEditBtn;
    dtTanggal: TDateTimePicker;
    dtDateline: TDateTimePicker;
    OpenDialog1: TOpenDialog;
    Label1: TLabel;
    edtIDBatch: TAdvEdit;
    Label7: TLabel;
    edtcuskode: TAdvEditBtn;
    edtnamacus: TAdvEdit;
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
    procedure edtnomorspkExit(Sender: TObject);
    procedure edtKodeBarangClickBtn(Sender: TObject);
    procedure edtcuskodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FCDSJenisCustomer: TClientDataset;
    FCDSGolonganCustomer: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSJenisCustomer: TClientDataset;
    function GetCDSGolonganCustomer: TClientDataset;


    { Private declarations }
  public
    property CDSJenisCustomer: TClientDataset read GetCDSJenisCustomer write
        FCDSJenisCustomer;
    property CDSGolonganCustomer: TClientDataset read GetCDSGolonganCustomer write
        FCDSGolonganCustomer;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmSPK: TfrmSPK;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmSPK.refreshdata;
begin
  FID:='';
  flagedit:= false;
  dttanggal.Date := date;
  dtDateline.date := date;
  edtnomorspk.Text := getmaxkode;
  edtnomorspk.enabled:=False;
  edtNamaspk.Clear;
  edtNamaspk.SetFocus;
end;
procedure TfrmSPK.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmSPK.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmSPK.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select * from tspk where spk_nomor = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
//      edtnomorspk.enabled := false;
      edtNamaspk.Text := fieldbyname('spk_nama').AsString;
      edtIDBatch.Text :=fieldbyname('spk_IDBatch').AsString;
      dtTanggal.DateTime := fieldbyname('spk_tanggal').AsDateTime;
      dtDateline.DateTime := fieldbyname('spk_dateline').AsDateTime;
      edtKeterangan.Text := fieldbyname('spk_keterangan').AsString;
      edtJumlah.Text := fieldbyname('spk_jumlah').AsString;
      edtKodeBarang.Text := fieldbyname('spk_brg_kode').AsString;
      edtNamaBarang.Text := getnama('tbarang','brg_kode',edtKodeBarang.Text,'brg_nama');
      edtcuskode.text := fieldbyname('spk_cus_kode').AsString;
      edtnamacus.Text := getnama('tcustomer','cus_kode',edtcuskode.Text,'cus_nama');

      FID :=fieldbyname('spk_nomor').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmSPK.simpandata;
var
  s:string;
begin
if edtJumlah.Text = ''  then
   edtjumlah.Text := '0';

if FLAGEDIT then
  s:='update tspk set '
    + ' spk_nama = ' + Quot(edtNamaspk.Text) + ','
    + ' spk_tanggal = ' + Quotd(dttanggal.date) + ','
    + ' spk_brg_kode = ' + Quot(edtkodebarang.text) + ','
    + ' spk_cus_kode = ' + Quot(edtcuskode.text) + ','
    + ' spk_keterangan = ' + Quot(edtketerangan.text) + ','
    + ' spk_IDBatch = ' + Quot(edtIDBatch.text) + ','
    + ' spk_jumlah  = ' + edtJumlah.Text + ','
    + ' spk_dateline = ' + quotd(dtdateline.date)
    + ' where spk_nomor = ' + quot(FID) + ';'
else
begin
  edtnomorspk.Text := getmaxkode;
  s :=  ' insert into tspk '
             + ' (spk_nomor,spk_nama,spk_tanggal,spk_dateline,spk_jumlah,'
             + ' spk_brg_kode,spk_cus_kode,spk_keterangan,spk_IDBatch) '
             + ' values ( '
             + Quot(edtnomorspk.Text) + ','
             + Quot(edtNamaspk.Text) + ','
             + Quotd(dttanggal.date)+','
             + Quotd(dtdateline.date) + ','
             + edtjumlah.text + ','
             + quot(edtkodebarang.text)+ ','
             + quot(edtcuskode.Text)+','
             + quot(edtketerangan.text)+','
             + quot(edtIDbatch.text)
             +')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmSPK.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmSPK.getmaxkode:string;
var
  s:string;
begin
  s:=' select max(SUBSTR(spk_nomor,12,3)) from tspk'
    + ' where month(spk_tanggal)='+FormatDateTime('mm',dtTanggal.DateTime)
    + ' and year(spk_tanggal)='+formatdatetime('yyyy',dtTanggal.DateTime);
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= 'SPK.'+formatdatetime('yyyymm',dtTanggal.DateTime)+'.'+RightStr(IntToStr(1000+1),3)
      else
         result:= 'SPK.'+formatdatetime('yyyymm',dtTanggal.DateTime)+'.'+RightStr(IntToStr(1000+fields[0].AsInteger+1),3);
    finally
      free;
    end;
  end;
end;

procedure TfrmSPK.cxButton1Click(Sender: TObject);
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

procedure TfrmSPK.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSPK.cxButton2Click(Sender: TObject);
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

function TfrmSPK.GetCDSJenisCustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSJenisCustomer) then
  begin
    S := 'select jc_nama as Nama, jc_kode Kode'
        +' from tjenisCustomer';


    FCDSJenisCustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSJenisCustomer;
end;

procedure TfrmSPK.edtnomorspkExit(Sender: TObject);
begin
  loaddata(edtnomorspk.Text);
end;

function TfrmSPK.GetCDSGolonganCustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSGolonganCustomer) then
  begin
    S := 'select gc_nama as Nama, gc_kode Kode'
        +' from tgolonganCustomer';


    FCDSGolonganCustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSGolonganCustomer;
end;

procedure TfrmSPK.edtKodeBarangClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT BRG_kode,brg_nama from tbarang where brg_gr_kode=1 ';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
 frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
     edtkodebarang.Text := varglobal;
     edtnamabarang.Text := varglobal1;
   end;


end;

procedure TfrmSPK.edtcuskodeClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT cus_kode Kode,cus_nama from tcustomer ';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
 frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
     edtcuskode.Text := varglobal;
     edtnamacus.Text := varglobal1;
   end;


end;

procedure TfrmSPK.FormShow(Sender: TObject);
begin
refreshdata;
end;

end.
