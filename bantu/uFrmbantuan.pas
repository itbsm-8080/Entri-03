unit uFrmbantuan;

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
  dxSkinValentine, dxSkinXmas2008Blue;

type
  TfrmBantuan = class(TForm)
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
    procedure FormShow(Sender: TObject);
    procedure loadbantuan(afilter : string='') ;
    procedure dbgridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTutupClick(Sender: TObject);
    procedure cxGrdMasterKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
     Fanamaform: string;
    FCDSMaster: TClientDataset;
  public
    SQLMaster : string;
     property anamaform: string read Fanamaform write Fanamaform;
    property CDSMaster: TClientDataset read FCDSMaster write FCDSMaster;
    { Public declarations }
  end;

var
  frmBantuan: TfrmBantuan;

implementation
  uses MAIN,ulib;
{$R *.dfm}

procedure TfrmBantuan.FormShow(Sender: TObject);
begin
    loadbantuan;
end;

procedure TfrmBantuan.loadbantuan(afilter : string='') ;
var

  i:integer;
begin

    If SQLMaster <> '' then
    CDSMaster := cOpenCDS(SQLMaster,Self);

   If not Assigned(cxGrdmaster.DataController.DataSource) then
    begin
      cxGrdmaster.DataController.DataSource := TDataSource.Create(Self);
    end;
    cxGrdmaster.DataController.DataSource.DataSet := CDSMaster;
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

procedure TfrmBantuan.dbgridDblClick(Sender: TObject);
begin
    varglobal:=CDSMaster.Fields[0].AsString;
    varglobal1:=CDSMaster.Fields[1].AsString;
//   varglobal2:=ClientDataSet1.Fields[2].AsString;
    close;
end;

procedure TfrmBantuan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
end;

procedure TfrmBantuan.btnTutupClick(Sender: TObject);
begin
      varglobal := '';
      varglobal1 := '';
//      varglobal2 := '';

      Close;
end;

procedure TfrmBantuan.cxGrdMasterKeyPress(Sender: TObject; var Key: Char);
begin
   if Key=Chr(13) then
   begin
   varglobal:=CDSMaster.Fields[0].AsString;
    varglobal1:=CDSMaster.Fields[1].AsString;
//   varglobal2:=ClientDataSet1.Fields[2].AsString;
    close;
   end;
end;

end.
