unit ufrmPencairanGiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, AdvEdBtn, cxControls, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, DBClient, MyAccess;

type
  TfrmPencairanGiro = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    edtNogiro: TAdvEditBtn;
    Label1: TLabel;
    dtTanggal: TDateTimePicker;
    Label4: TLabel;
    dttanggalcair: TDateTimePicker;
    Label5: TLabel;
    edtNilaiCash: TAdvEdit;
    cxLookupRekening: TcxExtLookupComboBox;
    Label6: TLabel;
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
    procedure dtTanggalChange(Sender: TObject);
    procedure edtNomorExit(Sender: TObject);
    procedure edtNogiroClickBtn(Sender: TObject);
    procedure FormCreate(Sender: TObject);


  private
    FCDSRekening: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSRekening: TClientDataset;


    { Private declarations }
  public
    property CDSRekening: TClientDataset read GetCDSRekening write FCDSRekening;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmPencairanGiro: TfrmPencairanGiro;
const
     NOMERATOR = 'CG';

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib, DB;

{$R *.dfm}

procedure TfrmPencairanGiro.refreshdata;
begin
  FID:='';
  dtTanggal.DateTime :=Date;
  dttanggalcair.datetime :=  date ;
  edtNomor.text :=  getmaxkode;
  dtTanggal.Enabled := True;
  edtNogiro.Clear;
  dtTanggal.SetFocus;
end;
procedure TfrmPencairanGiro.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmPencairanGiro.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmPencairanGiro.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select cg_nomor,cg_gironumber,cg_tanggal,cg_tanggalcair,cg_nilai,cg_rek_bank,rek_nama '
  + ' from tpencairangiro inner join trekening on rek_kode=cg_rek_bank where cg_nomor = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtNomor.Enabled := False;
      edtNomor.Text := Fields[0].AsString;
      dtTanggal.DateTime := Fields[2].AsDateTime;
      edtNogiro.Text := Fields[1].AsString;
      dttanggalcair.DateTime :=Fields[3].AsDateTime;
      edtNilaiCash.Text := Fields[4].AsString;
      cxLookupRekening.EditValue := Fields[5].AsString;
//      edtNama.Text := fieldbyname('cc_nama').AsString;
      FID :=Fields[0].AsString;
    end
    else
     FLAGEDIT := False;

  finally
    Free;
  end;
end;

end;


procedure TfrmPencairanGiro.simpandata;
var
  s:string;
begin
if FLAGEDIT then
  s:='update tpencairangiro set '
    + ' cg_gironumber = ' + Quot(edtNogiro.Text)
    + ' , cg_tanggal = ' + QuotD(dtTanggal.DateTime)
    + ' , cg_tanggalcair = ' + Quotd(dttanggalcair.DateTime)
    + ' , cg_nilai = ' + FloatToStr(cStrToFloat(edtNilaiCash.Text)) +','
    + ' cg_rek_bank = ' + Quot(cxLookupRekening.EditValue)
    + ' where cg_nomor = ' + quot(FID) + ';'
else
begin

  s :=  ' insert into tpencairangiro '
             + ' (cg_nomor,cg_gironumber,cg_tanggal,cg_tanggalcair,cg_nilai,cg_rek_bank) '
             + ' values ( '
             + Quot(edtnomor.Text) + ','
             + Quot(edtNogiro.Text)+','
             + QuotD(dtTanggal.DateTime) + ','
             + QuotD(dttanggalcair.DateTime) + ','
             + FloatToStr(cStrToFloat(edtNilaiCash.Text)) +','
             + Quot(cxLookupRekening.EditValue)
             + ');';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

end;


procedure TfrmPencairanGiro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmPencairanGiro.getmaxkode:string;
var
  s:string;
begin
  s:='select max(right(cg_nomor,4)) from tpencairangiro where cg_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
end;

procedure TfrmPencairanGiro.cxButton1Click(Sender: TObject);
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

procedure TfrmPencairanGiro.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmPencairanGiro.cxButton2Click(Sender: TObject);
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

procedure TfrmPencairanGiro.dtTanggalChange(Sender: TObject);
begin
edtNomor.Text := getmaxkode;
end;

procedure TfrmPencairanGiro.edtNomorExit(Sender: TObject);
begin
loaddata(edtNomor.Text);
end;



procedure TfrmPencairanGiro.edtNogiroClickBtn(Sender: TObject);
begin
  sqlbantuan := ' SELECT byc_nogiro Nogiro,byc_giro Nilai,byc_tanggal Tanggal,byc_cus_kode Kode,cus_nama Nama'
      + ' FROM tbayarcus_hdr '
      + ' inner join tcustomer on cus_kode=byc_cus_kode '
      + ' WHERE byc_nogiro <> "" and byc_giro > 0 and byc_rek_giro="13.001"'
      + ' and byc_nogiro not in (select cg_gironumber from tpencairangiro) ';

  sqlfilter := 'Nogiro,Nama,Kode';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtNogiro.Text := varglobal;
  edtNilaiCash.Text := varglobal1;
  end;




end;

function TfrmPencairanGiro.GetCDSRekening: TClientDataset;
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

procedure TfrmPencairanGiro.FormCreate(Sender: TObject);
begin
    with TcxExtLookupHelper(cxLookupRekening.Properties) do
    LoadFromCDS(CDSRekening, 'Kode','Rekening',['Kode'],Self);

end;

end.
