unit ufrmFeeCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  AdvEdBtn, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox,DBClient,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, MyAccess;

type
  TfrmFeeCustomer = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
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
    AdvPanel4: TAdvPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtNilai: TAdvEdit;
    cxLookupCustomer: TcxExtLookupComboBox;
    Label3: TLabel;
    edtNomor: TAdvEdit;
    startdate: TDateTimePicker;
    Label6: TLabel;
    enddate: TDateTimePicker;
    edtPotong: TAdvEdit;
    Label12: TLabel;
    edtTarget: TAdvEdit;
    Label7: TLabel;
    dtTanggal: TDateTimePicker;
    Label13: TLabel;
    cxLookupRekening: TcxExtLookupComboBox;
    function cekdata: Boolean;
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
    procedure FormCreate(Sender: TObject);
    procedure dtTanggalChange(Sender: TObject);
    procedure cxLookupCustomerPropertiesChange(Sender: TObject);

  private
    FCDSCustomer: TClientDataset;
    FCDSRekening: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSCustomer: TClientDataset;
    function GetCDSRekening: TClientDataset;

    { Private declarations }
  public
    property CDSCustomer: TClientDataset read GetCDSCustomer write FCDSCustomer;
    property CDSRekening: TClientDataset read GetCDSRekening write FCDSRekening;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmFeeCustomer: TfrmFeeCustomer;

const
  nomerator = 'CN';

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;


{$R *.dfm}

function TfrmFeeCustomer.cekdata: Boolean;
begin
  result:=true;
     If VarToStr(cxLookupCustomer.EditValue) = '' then
    begin
      ShowMessage('customer belum di pilih');
      result:=false;
      Exit;

    end;

   If VarToStr(cxLookupRekening.EditValue) = '' then
    begin
      ShowMessage('Rekening belum di pilih');
      result:=false;
      Exit;
    end;
  if edtNilai.Text = ''  then edtnilai.text := '0';
  if cStrToFloat(edtNilai.Text)=0 then
  begin
      ShowMessage('Nilai belum di isi');
      result:=false;
      Exit;
  end;
end;

procedure TfrmFeeCustomer.refreshdata;
begin
  FID:='';
  edtnomor.Text := getmaxkode;
  edtKota.Clear;
  edtAlamat.Clear;
  edtTelp.Clear;
  cxLookupCustomer.SetFocus;
  cxLookupRekening.EditValue := '';
  cxLookupCustomer.EditValue := '';
  edtNilai.Text := '0';
  edtPotong.Text := '0';
  startdate.Date := date;
  enddate.Date := date;
  dtTanggal.Date := Date;
  edtTarget.Text := '0';
end;
procedure TfrmFeeCustomer.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmFeeCustomer.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmFeeCustomer.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select * from tpiutangcn where cn_nomor = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      cxLookupCustomer.EditValue := fieldbyname('cn_cus_kode').AsString;
      cxLookupRekening.EditValue := fieldbyname('cn_rek_kode').AsString;
      edtNomor.Text := fieldbyname('cn_nomor').Asstring;
      dtTanggal.Date := fieldbyname('cn_tanggal').AsDateTime;
      edtNilai.Text := fieldbyname('cn_nilai_fee').Asstring;
      startdate.Date  := fieldbyname('cn_startdate').AsDateTime;
      enddate.Date  := fieldbyname('cn_enddate').AsDateTime;
      edtPotong.Text := fieldbyname('cn_potong_invoice').Asstring;
      edtTarget.Text := fieldbyname('cn_targetjual').Asstring;

      FID :=fieldbyname('cn_nomor').Asstring;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmFeeCustomer.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tpiutangcn set '
    + ' cn_tanggal = ' + Quotd(dtTanggal.DateTime) + ','
    + ' cn_cus_kode = ' + Quot(cxLookupCustomer.EditValue)+','
    + ' cn_nilai_fee = ' + StringReplace(edtNilai.Text,',','',[rfReplaceAll]) + ','
    + ' cn_startdate =' + Quotd(startdate.DateTime) + ','
    + ' cn_enddate = ' + Quotd(enddate.DateTime) + ','
    + ' cn_potong_invoice = '+ StringReplace(edtPotong.Text,',','',[rfReplaceAll]) + ','
    + ' cn_targetjual = ' + StringReplace(edtTarget.Text,',','',[rfReplaceAll]) + ','
    + ' cn_rek_kode = ' +  Quot(cxLookupRekening.EditValue) +','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where cn_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into tpiutangcn '
             + ' (cn_nomor,cn_tanggal,cn_cus_kode,cn_nilai_fee,cn_startdate,cn_enddate,cn_potong_invoice,cn_targetjual'
             + ' ,cn_rek_kode,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.DateTime) + ','
             + Quot(cxLookupCustomer.EditValue)+','
             + StringReplace(edtNilai.Text,',','',[rfReplaceAll]) + ','
             + Quotd(startdate.DateTime)  + ','
             + Quotd(enddate.DateTime)+','
             + StringReplace(edtPotong.Text,',','',[rfReplaceAll]) + ','
             + StringReplace(edtTarget.Text,',','',[rfReplaceAll]) + ','
             + Quot(cxLookupRekening.EditValue) +','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmFeeCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function Tfrmfeecustomer.getmaxkode:string;
var
  s:string;
begin
    s:='select max(right(cn_nomor,4)) from tPIUTANGcn where cn_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang+'-'+ NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)


      else
         result:= frmMenu.kdcabang + '-' + NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
end;

procedure TfrmFeeCustomer.cxButton1Click(Sender: TObject);
begin
    try
            If not cekdata then exit;
            
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;

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

procedure TfrmFeeCustomer.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmFeeCustomer.cxButton2Click(Sender: TObject);
begin
   try
           If not cekdata then exit;
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
   
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

procedure TfrmFeeCustomer.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupCustomer.Properties) do
    LoadFromCDS(CDSCustomer, 'Kode','Customer',['Kode'],Self);
    with TcxExtLookupHelper(cxLookupRekening.Properties) do
    LoadFromCDS(CDSRekening, 'Kode','Rekening',['Kode'],Self);

end;

function TfrmFeeCustomer.GetCDSCustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSCustomer) then
  begin
    S := 'select cus_nama as Customer, cus_kode Kode, Cus_alamat Alamat,cus_kota Kota,cus_telp Telp'
        +' from tCustomer';


    FCDSCustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSCustomer;
end;

procedure TfrmFeeCustomer.dtTanggalChange(Sender: TObject);
begin
edtNomor.Text := getmaxkode;
end;

procedure TfrmFeeCustomer.cxLookupCustomerPropertiesChange(
  Sender: TObject);
begin
edtAlamat.Text := CDSCustomer.Fields[2].AsString;
edtKota.Text   := CDSCustomer.Fields[3].AsString;
edtTelp.Text   := CDSCustomer.Fields[4].AsString;
end;

function TfrmFeeCustomer.GetCDSRekening: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekening) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening';


    FCDSRekening := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekening;
end;

end.
