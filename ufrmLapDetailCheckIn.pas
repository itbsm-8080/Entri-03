unit ufrmLapDetailCheckIn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
   dxSkinsDefaultPainters, DBClient, cxControls, cxContainer,
  cxEdit, AdvEdBtn, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, cxSpinEdit, cxTimeEdit, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxButtonEdit,
  cxCheckBox, cxCurrencyEdit, AdvCombo, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinDarkRoom, dxSkinFoggy,
  dxSkinSeven, dxSkinSharp, MyAccess;

type
  TfrmLapDetailCheckIn = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel4: TAdvPanel;
    cxGrid1: TcxGrid;
    cxGridLembur: TcxGridDBTableView;
    clNama: TcxGridDBColumn;
    clTanggal: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    Label1: TLabel;
    clcustomer: TcxGridDBColumn;
    Button1: TButton;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    clCabang: TcxGridDBColumn;
    clcus_kode: TcxGridDBColumn;
    clJam: TcxGridDBColumn;
    cxGridLemburColumn1: TcxGridDBColumn;
    cxGridLemburColumn2: TcxGridDBColumn;
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure loaddataall ;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDSLembur: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
  private

    FFLAGEDIT: Boolean;
    FID: string;

    { Private declarations }
  protected
    FCDSLembur: TClientDataSet;
  public
    property CDSLembur: TClientDataSet read GetCDSLembur write FCDSLembur;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmLapDetailCheckIn: TfrmLapDetailCheckIn;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxGridExportLink,uReport;

{$R *.dfm}

procedure TfrmLapDetailCheckIn.refreshdata;
begin
StartDate.DateTime := StrToDate(FormatDateTime('mm',Now)+'/01/'+FormatDateTime('yyyy',Now));
  EndDate.DateTime := Date;
  CDSLembur.EmptyDataSet;
  CDSLembur.Append;
  CDSLembur.Post;
end;
procedure TfrmLapDetailCheckIn.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


end;

procedure TfrmLapDetailCheckIn.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmLapDetailCheckIn.loaddataall ;
var
  s: string;
  i:integer;
  tsql : TMyQuery;
  aterjadwal,atidakterjadwal : Integer;
begin
  s:= 'SELECT USER Nama,tanggal Tanggal,cus_kode,latitude,longitude,'
    + ' (select cus_nama from tcustomer where cus_kode=a.cus_kode)  customer,'
    + ' time_format(tanggal,"%H:%i:%s") Jam'
    + ' FROM tkunjungan a  '
    + ' where '
    + ' tanggal between  '+QuotD(startdate.DateTime)+' and '+QuotD(enddate.DateTime)
    + ' having customer <> "" ';

aterjadwal :=0;
atidakterjadwal:=0;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
             i:=1;
             CDSLembur.EmptyDataSet;
             CDSLembur.Append;
            while  not Eof do
             begin

                      CDSLembur.Append;
                      CDSLembur.fieldbyname('nama').AsString := fieldbyname('nama').AsString;
                      CDSLembur.fieldbyname('tanggal').AsDateTime := fieldbyname('tanggal').AsDateTime;
                      CDSLembur.fieldbyname('customer').AsString  := fieldbyname('customer').asstring;
                      CDSLembur.fieldbyname('cus_kode').asstring  := fieldbyname('cus_kode').AsString;
                      CDSLembur.fieldbyname('jam').asstring  := fieldbyname('jam').AsString;
                      CDSLembur.fieldbyname('Latitude').asstring  := fieldbyname('Latitude').AsString;
                      CDSLembur.fieldbyname('Longitude').asstring  := fieldbyname('Longitude').AsString;
                      CDSLembur.Post;

                   i:=i+1;
                   next;
               end;

  finally
    Free;
  end;


end;

end;

procedure TfrmLapDetailCheckIn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;


procedure TfrmLapDetailCheckIn.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmLapDetailCheckIn.FormShow(Sender: TObject);
begin
refreshdata ;
end;

function TfrmLapDetailCheckIn.GetCDSLembur: TClientDataSet;
begin
  If not Assigned(FCDSLembur) then
  begin
    FCDSLembur := TClientDataSet.Create(Self);
    zAddField(FCDSLembur, 'nama', ftString, False,100);
    zAddField(FCDSLembur, 'tanggal', ftDate, False);
    zAddField(FCDSLembur, 'customer', ftString, False,100);
    zAddField(FCDSLembur, 'cus_kode', ftString, False,30);
    zAddField(FCDSLembur, 'Cabang', ftString, False,20);
    zAddField(FCDSLembur, 'Jam', ftString, False,20);
    zAddField(FCDSLembur, 'Latitude', ftString, False,30);
    zAddField(FCDSLembur, 'Longitude', ftString, False,30);

    FCDSLembur.CreateDataSet;
  end;
  Result := FCDSLembur;
end;

procedure TfrmLapDetailCheckIn.FormCreate(Sender: TObject);
begin

   TcxDBGridHelper(cxGridLembur).LoadFromCDS(CDSLembur, False, False);
end;

procedure TfrmLapDetailCheckIn.RefreshClick(Sender: TObject);
begin
loaddataall;
end;

procedure TfrmLapDetailCheckIn.Button1Click(Sender: TObject);
begin
loaddataall;
end;

procedure TfrmLapDetailCheckIn.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid1);

  cxGridLembur.DataController.CollapseDetails;
end;


end.
