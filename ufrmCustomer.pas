unit ufrmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  AdvEdBtn, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox,
  DBClient, MyAccess;

type
  TfrmCustomer = class(TForm)
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
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtNamaNPWP: TAdvEdit;
    edtAlamatNPWP: TAdvEdit;
    edtKotaNPWP: TAdvEdit;
    Label11: TLabel;
    edtNPWP: TAdvEdit;
    CheckBox1: TCheckBox;
    edtfax: TAdvEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtEmail: TAdvEdit;
    edtTOP: TAdvEdit;
    Label15: TLabel;
    edtCP: TAdvEdit;
    cxLookupJenisCustomer: TcxExtLookupComboBox;
    Label16: TLabel;
    edtShipAddres: TAdvEdit;
    Label17: TLabel;
    cxExtgolongan: TcxExtLookupComboBox;
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
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtKodeExit(Sender: TObject);

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
  frmCustomer: TfrmCustomer;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmCustomer.refreshdata;
begin
  FID:='';
  flagedit:= false;
  edtKode.Text := '';
  edtKode.enabled:=True;

  edtNama.Clear;
  edtKota.Clear;
  edtAlamat.Clear;
  edtTelp.Clear;
  edtfax.clear;
  edttop.text := '0';
  edtcp.clear;
  edtemail.clear;
  cxLookupJenisCustomer.Clear;
  edtShipAddres.Clear;
//  edtjeniscustomer.clear;
//  edtnamajenis.clear;
  edtnpwp.clear;
  edtkotanpwp.clear;
  edtalamatnpwp.clear;
  edtnamanpwp.clear;
  edtkode.SetFocus;
end;
procedure TfrmCustomer.FormKeyDown(Sender: TObject; var Key: Word;
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
         MessageDlg('Kode Customer Belum diisi',mtWarning, [mbOK],0);
         Exit;
       end;
        If cxExtgolongan.EditValue = '' then
        begin
          ShowMessage('golongan belum di pilih');
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

procedure TfrmCustomer.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmCustomer.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select * from tcustomer where cus_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtkode.enabled := false;
      edtNama.Text := fieldbyname('cus_nama').AsString;
      edtkota.Text := fieldbyname('cus_kota').AsString;
      edtAlamat.Text := fieldbyname('cus_alamat').AsString;
      edtTelp.Text := fieldbyname('cus_telp').AsString;
      edtfax.text :=  fieldbyname('cus_fax').AsString;
      edtcp.text := fieldbyname('cus_cp').AsString;
      edtShipAddres.Text := fieldbyname('cus_shipaddress').AsString;
      edtemail.text := fieldbyname('cus_email').AsString;
      cxLookupJenisCustomer.EditValue  := fieldbyname('cus_jc_kode').AsString;
     cxExtgolongan.EditValue  := fieldbyname('cus_gc_kode').AsString;
//      CDSJenisCustomer.FieldByName('Kode').Asstring :=fieldbyname('cus_jc_kode').AsString;
//      edtpiutang.text :=formatfloat('###,###,###.##',fieldbyname('cus_piutang').Asfloat);
//      edtjeniscustomer.text := fieldbyname('cus_jc_kode').AsString;
//      edtnamajenis.text := getnama('tjeniscustomer','jc_kode',edtjeniscustomer.text,'jc_nama');
      edttop.Text := fieldbyname('cus_top').AsString;
      edtnpwp.text :=  fieldbyname('cus_npwp').AsString;
      edtnamanpwp.text :=  fieldbyname('cus_namanpwp').AsString;
      edtalamatnpwp.Text :=  fieldbyname('cus_alamatnpwp').AsString;
      edtkotanpwp.text :=  fieldbyname('cus_kotanpwp').AsString;
      FID :=fieldbyname('cus_kode').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmCustomer.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tcustomer set '
    + ' cus_nama = ' + Quot(edtNama.Text) + ','
    + ' cus_kota = ' + Quot(edtKota.Text) + ','
    + ' cus_alamat = ' + Quot(edtAlamat.Text)+','
    + ' cus_telp = ' + Quot(edtTelp.Text) + ','
    + ' cus_fax =' + Quot(edtFax.Text) + ','
    + ' cus_cp = ' + Quot(edtCP.Text) + ','
    + ' cus_jc_kode = '+ IntToStr(cVarToInt(cxLookupJenisCustomer.EditValue)) + ','
    + ' cus_email = ' + quot(edtemail.text) + ','
    + ' cus_top = ' + edttop.text + ','
    + ' cus_shipaddress = ' + Quot(edtShipAddres.Text) + ','
    + ' cus_npwp = ' + quot(edtnpwp.text) + ','
    +' cus_namanpwp = ' + quot(edtnamanpwp.text) + ','
    + ' cus_alamatnpwp = ' + quot(edtalamatnpwp.text)+','
    + ' cus_kotanpwp = ' + quot(edtkotanpwp.text) + ','
    + ' cus_gc_kode = ' + Quot(VarToStr(cxExtgolongan.EditValue)) + ','
    + ' cus_cabang = '+ Quot(frmMenu.KDCABANG)+','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where cus_kode = ' + quot(FID) + ';'
else
begin
//  edtKode.Text := getmaxkode;
  s :=  ' insert into tcustomer '
             + ' (cus_kode,cus_nama,cus_kota,cus_alamat,cus_telp,cus_fax,cus_cp,cus_email,cus_jc_kode,cus_top,'
             + ' cus_shipaddress,cus_npwp,cus_namanpwp,cus_alamatnpwp,cus_kotanpwp,cus_gc_kode,cus_cabang,date_create,user_create) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text) + ','
             + Quot(edtkota.Text)+','
             + Quot(edtAlamat.Text) + ','
             + Quot(edtTelp.Text)  + ','
             + Quot(edtfax.text)+','
             + Quot(edtcp.text) + ','
             + Quot(edtemail.text) + ','
             + IntToStr(cVarToInt(cxLookupJenisCustomer.EditValue)) +','
             + edttop.text + ','
             + Quot(edtShipAddres.Text) + ','
             + Quot(edtnpwp.text) + ','
             + Quot(edtnamanpwp.text)+','
             + Quot(edtalamatnpwp.text)+','
             + Quot(edtkotanpwp.text)+','
             + Quot(VarToStr(cxExtgolongan.EditValue))+','
             + Quot(frmMenu.KDCABANG)+','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmCustomer.getmaxkode:string;
var
  s:string;
begin
  s:='select max(SUBSTR(cus_kode,2,3)) from tcustomer';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= 'C'+RightStr(IntToStr(1000+1),3)
      else
         result:= 'C'+RightStr(IntToStr(1000+fields[0].AsInteger+1),3);

    finally
      free;
    end;
  end;
end;

procedure TfrmCustomer.cxButton1Click(Sender: TObject);
begin
    try
       if edtKode.Text = '' then
       begin
         MessageDlg('Kode Customer Belum diisi',mtWarning, [mbOK],0);
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

procedure TfrmCustomer.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmCustomer.cxButton2Click(Sender: TObject);
begin
   try
   
     if edtKode.Text = '' then
       begin
         MessageDlg('Kode Customer Belum diisi',mtWarning, [mbOK],0);
         Exit;
       end;
   If cxExtgolongan.EditValue = '' then
    begin
      ShowMessage('golongan belum di pilih');
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

procedure TfrmCustomer.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    edtNamaNPWP.Text := edtNama.Text ;
    edtAlamatNPWP.Text := edtAlamat.Text;
    edtKotaNPWP.Text := edtKota.Text;
  end;
end;

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupJenisCustomer.Properties) do
    LoadFromCDS(CDSJenisCustomer, 'Kode','Nama',['Kode'],Self);
  with TcxExtLookupHelper(cxExtgolongan.Properties) do
    LoadFromCDS(CDSGolonganCustomer, 'Kode','Nama',['Kode'],Self);


end;

function TfrmCustomer.GetCDSJenisCustomer: TClientDataset;
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

procedure TfrmCustomer.edtKodeExit(Sender: TObject);
begin
  loaddata(edtKode.Text);
end;

function TfrmCustomer.GetCDSGolonganCustomer: TClientDataset;
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

end.
