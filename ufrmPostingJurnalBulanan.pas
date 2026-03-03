unit ufrmPostingJurnalBulanan;

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
  AdvCombo,DateUtils, cxPC;

type
  TfrmPostingJurnalBulanan = class(TForm)
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
    OpenDialog1: TOpenDialog;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    MainMenu1: TMainMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    private
      { Private declarations }
     protected
  public
    { Public declarations }
  end;

var
  frmPostingJurnalBulanan: TfrmPostingJurnalBulanan;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmPostingJurnalBulanan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmPostingJurnalBulanan.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;



procedure TfrmPostingJurnalBulanan.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmPostingJurnalBulanan.cxButton1Click(Sender: TObject);
var
  s:string;
  akhir : TDateTime;
begin
akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text));
s:= ' CALL jurnal_bdp('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

s:= ' CALL jurnal_Koreksi('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

s:= ' CALL jurnal_mintabahan('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
s:= ' CALL jurnal_returbahan('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
s:= ' CALL jurnal_stbj('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
s:= ' call jurnal_pembelian('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
s:= ' call jurnal_Pemusnahan('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


s:= ' call jurnal_penjualan('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

s:= ' call jurnal_returpembelian('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

s:= ' call jurnal_returpenjualan('+IntToStr(cbbBulan.itemindex+1)+','+edttahun.Text+','+quotd(akhir)+');';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


// xCommit(frmMenu.conn);
ShowMessage('Proses posting jurnal selesai');

end;

procedure TfrmPostingJurnalBulanan.FormShow(Sender: TObject);
begin
edttahun.Text := FormatDateTime('yyyy',date);
cbbBulan.ItemIndex :=StrToInt(FormatDateTime('mm',date))-1;
end;

end.
