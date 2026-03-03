unit uFrmbantuan2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, Grids, BaseGrid, AdvGrid, DBAdvGrd, ExtCtrls,
  AdvPanel, FMTBcd, DB, DBClient, Provider, SqlExpr, AdvCombo, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Menus, cxButtons,cxCurrencyEdit, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, DBAccess, MyAccess, MemDS;

type
  TfrmBantuan2 = class(TForm)
    AdvPanel4: TAdvPanel;
    AdvPanel5: TAdvPanel;
    SQLQuery1: TSQLQuery;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    ds2: TDataSource;
    btnOK: TcxButton;
    btnTutup: TcxButton;
    cxGrid: TcxGrid;
    cxGrdMaster: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    procedure FormShow(Sender: TObject);
    procedure loadbantuan(afilter : string='') ;
    procedure dbgridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTutupClick(Sender: TObject);
    procedure cxGrdMasterKeyPress(Sender: TObject; var Key: Char);
    procedure bacafile2;
  private
    { Private declarations }
     Fanamaform: string;
    FCDSMaster: TClientDataset;
  public
    SQLMaster : string;
    aHost2,aDatabase2,auser2,apassword2 : string;
//    conn2: TSQLConnection;
     property anamaform: string read Fanamaform write Fanamaform;
    property CDSMaster: TClientDataset read FCDSMaster write FCDSMaster;
    { Public declarations }
  end;

var
  frmBantuan2: TfrmBantuan2;

implementation
  uses MAIN,ulib,uModuleConnection,ufrmBrowsePesanan;
{$R *.dfm}

procedure TfrmBantuan2.FormShow(Sender: TObject);
begin
  bacafile2;
  with MyConnection1 do
  begin
   LoginPrompt := False;
   Server := aHost2;
   Database := aDatabase2;
   Username := auser2;
   Password := apassword2;
   Connected := True;
  end;

//    conn2 := xCreateConnection(ctMySQL,aHost2,aDatabase2,auser2,apassword2);
    loadbantuan;

end;

procedure TfrmBantuan2.loadbantuan(afilter : string='') ;
var
  i:integer;

begin

    If sqlbantuan <> '' then
    begin
      MyQuery1.Close;
      MyQuery1.SQL.Text := sqlbantuan;
      MyQuery1.Open;
      ClientDataSet1.Open;
    end;

   If not Assigned(cxGrdmaster.DataController.DataSource) then
    begin
      cxGrdmaster.DataController.DataSource := TDataSource.Create(Self);
    end;
    cxGrdmaster.DataController.DataSource.DataSet := ClientDataSet1;
    cxGrdmaster.DataController.CreateAllItems(True);

     for i:=0 to cxGrdMaster.ColumnCount-1 do
  begin
    if (cxGrdMaster.Columns[i].DataBinding.ValueType = 'Float')
    or (cxGrdMaster.Columns[i].DataBinding.ValueType = 'Currency')
    then
    begin
      cxGrdMaster.Columns[i].PropertiesClass := TcxCurrencyEditProperties;
      TcxCurrencyEditProperties(cxGrdMaster.Columns[i].Properties).DisplayFormat := ',0.00;(,0.00)'
    end;
  end;
end;

procedure TfrmBantuan2.dbgridDblClick(Sender: TObject);
begin

    varglobal:=ClientDataSet1.Fields[0].AsString;
    varglobal1:=ClientDataSet1.Fields[1].AsString;
//   varglobal2:=ClientDataSet1.Fields[2].AsString;
    close;
end;

procedure TfrmBantuan2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
end;

procedure TfrmBantuan2.btnTutupClick(Sender: TObject);
begin
      varglobal := '';
      varglobal1 := '';
//      varglobal2 := '';

      Close;
end;

procedure TfrmBantuan2.cxGrdMasterKeyPress(Sender: TObject; var Key: Char);
begin
   if Key=Chr(13) then
   begin
   varglobal:=ClientDataSet1.Fields[0].AsString;
    varglobal1:=ClientDataSet1.Fields[1].AsString;
//   varglobal2:=ClientDataSet1.Fields[2].AsString;
    close;
   end;
end;

procedure TfrmBantuan2.bacafile2;
 var
 ltemp : TStringList;

 begin
 ltemp := TStringList.Create;
 ltemp.loadfromfile(ExtractFileDir(application.ExeName) + '\' + 'default2.cfg');
   aHost2     := ltemp[0];
   aDatabase2 := ltemp[1];
   auser2     := ltemp[2];
   apassword2 := ltemp [3];

   ltemp.free;
 end;




end.
