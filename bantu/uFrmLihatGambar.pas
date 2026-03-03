unit ufrmLihatGambar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, Grids, BaseGrid, AdvGrid, DBAdvGrd, ExtCtrls,
  AdvPanel, FMTBcd, DB, DBClient, Provider, SqlExpr, AdvCombo, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Menus, cxButtons,cxCurrencyEdit;

type
  TfrmLihatGambar = class(TForm)
    AdvPanel4: TAdvPanel;
    AdvPanel5: TAdvPanel;
    btnOK: TcxButton;
    btnTutup: TcxButton;
    Image1: TImage;
    procedure dbgridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTutupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
     Fanamaform: string;
    FCDSMaster: TClientDataset;
  public
    KODEBARANG : string;
     property anamaform: string read Fanamaform write Fanamaform;
    property CDSMaster: TClientDataset read FCDSMaster write FCDSMaster;
    { Public declarations }
  end;

var
  frmLihatGambar: TfrmLihatGambar;

implementation
  uses MAIN,ulib;
{$R *.dfm}

procedure TfrmLihatGambar.dbgridDblClick(Sender: TObject);
begin
    close;
end;

procedure TfrmLihatGambar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
end;

procedure TfrmLihatGambar.btnTutupClick(Sender: TObject);
begin
      Close;
end;

procedure TfrmLihatGambar.FormShow(Sender: TObject);
begin
if FileExists(frmMenu.apathimage+'\'+KODEBARANG+'.jpg') then
      Image1.Picture.LoadFromFile(frmMenu.apathimage+'\'+KODEBARANG+'.jpg');
end;

end.
