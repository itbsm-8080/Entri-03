unit ufrmtutupperiode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  AdvPanel, AdvCGrid, BaseGrid,SqlExpr, DBAdvGrd, DB, DBClient, Provider,
  FMTBcd, RAWPrinter, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxSpinEdit, cxCalendar, Menus, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxButtonEdit, cxCurrencyEdit,ExcelXP,ComObj,
  AdvCombo,DateUtils, cxPC, MyAccess;

type
  TfrmTutupPeriode = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label3: TLabel;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    Button2: TButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    MainMenu1: TMainMenu;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton8Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    private
      { Private declarations }
     protected
  public
    { Public declarations }
  end;

var
  frmTutupPeriode: TfrmTutupPeriode;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmTutupPeriode.Button1Click(Sender: TObject);
var
s:string;
Anilai :double;
tsql :TMyQuery;
akhir:TDateTime;
begin
    akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text));
   s:='call jurnal_lr('+inttostr(cbbBulan.itemindex+1)+','+edttahun.Text+','+QuotD(akhir)+');';
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   // xCommit(frmMenu.conn);


//if cbbBulan.ItemIndex+1 = 1 THEN
//begin
//S:= 'select sum(jurd_debet-jurd_kredit) from '
//    + ' TJURNAL inner join tjurnalitem on jurd_jur_no =jur_no '
//    + ' inner join trekening on rek_kode=jurd_rek_kode '
//    + ' inner join tkelompok on kol_id=rek_kol_id '
//    + ' where '
//    + ' year(jur_tanggal)='+ inttostr(strtoinT(edtTahun.Text)-1)
//    + ' And isneraca=0';
//    tsql := xOpenQuery(s,frmMenu.conn);
//    with tsql do
//    begin
//      try
//        if not eof then
//           Anilai := Fields[0].AsFloat;
//      finally
//        free;
//      end;
//    end;
//s:='delete from tjurnal where jur_no = ' +Quot('LBD'+ inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text) ;
//   xExecQuery(s,frmMenu.conn);
//s:='delete from tjurnalitem where jurd_jur_no =' +Quot('LBD'+ inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text) ;
//   xExecQuery(s,frmMenu.conn);
//
//s:='insert into tjurnal (jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed) '
// + ' values ('
// + QuotD(akhir) + ',"LABA DITAHAN",'
// +Quot('LBD' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text)
// + ',"LR TAHUNAN",1)';
//   xExecQuery(s,frmMenu.conn);
//s:='insert into tjurnalitem (jurd_jur_no,jurd_rek_kode,jurd_kredit,jurd_debet)'
// + ' values ('
// +Quot('LBD' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text)
// + ',"20.004",'
// + FloatToStr(Anilai) + ',0);';
//   xExecQuery(s,frmMenu.conn);
//s:='insert into tjurnalitem (jurd_jur_no,jurd_rek_kode,jurd_kredit,jurd_debet)'
// + ' values ('
// +Quot('LBD' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text)
// + ',"20.002",0,'
// + FloatToStr(Anilai) + ');';
//    xExecQuery(s,frmMenu.conn);
//
//end;
//
//
//  S:= 'select sum(jurd_debet-jurd_kredit) from '
//+ ' TJURNAL inner join tjurnalitem on jurd_jur_no =jur_no '
//+ ' inner join trekening on rek_kode=jurd_rek_kode '
//+ ' inner join tkelompok on kol_id=rek_kol_id '
//+ ' where month(jur_tanggal)= '
//+ inttostr(cbbBulan.ItemIndex+1)
//+ ' and year(jur_tanggal)='+ edtTahun.Text
//+ ' And isneraca=0';
//tsql := xOpenQuery(s,frmMenu.conn);
//with tsql do
//begin
//  try
//    if not eof then
//       Anilai := Fields[0].AsFloat;
//  finally
//    free;
//  end;
//end;
//s:='delete from tjurnal where jur_no = ' +Quot('LBT' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text) ;
//   xExecQuery(s,frmMenu.conn);
//s:='delete from tjurnalitem where jurd_jur_no =' +Quot('LBT' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text) ;
//   xExecQuery(s,frmMenu.conn);
//
//s:='insert into tjurnal (jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed) '
// + ' values ('
// + QuotD(akhir) + ',"LABA RUGI",'
// +Quot('LBT' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text)
// + ',"LR",1)';
//   xExecQuery(s,frmMenu.conn);
//s:='insert into tjurnalitem (jurd_jur_no,jurd_rek_kode,jurd_kredit,jurd_debet)'
// + ' values ('
// +Quot('LBT' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text)
// + ',"27.001",'
// + FloatToStr(Anilai) + ',0);';
//   xExecQuery(s,frmMenu.conn);
//s:='insert into tjurnalitem (jurd_jur_no,jurd_rek_kode,jurd_kredit,jurd_debet)'
// + ' values ('
// +Quot('LBT' + inttostr(cbbBulan.ItemIndex+1)+edtTahun.Text)
// + ',"20.004",0,'
// + FloatToStr(Anilai) + ');';
//    xExecQuery(s,frmMenu.conn);
//
//
//
//
    s:='insert ignore into ttutupperiode (tutup_bulan,tutup_tahun) values ('
   + inttostr(cbbBulan.ItemIndex+1) + ','
   + edttahun.Text + ');';
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   // xCommit(frmMenu.conn);
  ShowMessage('Tutup Periode Berhasil');
end;

procedure TfrmTutupPeriode.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmTutupPeriode.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;



procedure TfrmTutupPeriode.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmTutupPeriode.Button2Click(Sender: TObject);
var
  s:string;
begin
  s:='delete from ttutupperiode '
   + 'where tutup_bulan =' + inttostr(cbbBulan.ItemIndex+1) + ' and tutup_tahun = '
   + edttahun.Text + ';';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  ShowMessage('Buka Periode Berhasil');
end;








procedure TfrmTutupPeriode.FormShow(Sender: TObject);
begin
edttahun.Text := FormatDateTime('yyyy',date);
cbbBulan.ItemIndex :=StrToInt(FormatDateTime('mm',date))-1;
end;

end.
