unit ufrmListStokCabang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SqlExpr,  cxGraphics,
  cxControls, dxStatusBar, te_controls, Menus, cxLookAndFeelPainters,
  cxButtons, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid ,
  Grids, BaseGrid, AdvGrid, AdvCGrid, ComCtrls, Mask, ImgList, FMTBcd,
  Provider, DB, DBClient, DBGrids, cxLookAndFeels, cxDBData,
  cxGridBandedTableView, cxGridDBTableView,
  cxGridChartView, cxCustomPivotGrid, cxDBPivotGrid, cxPC,
  cxPivotGridChartConnection, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPScxPageControlProducer,
  dxPScxEditorProducers, dxPScxExtEditorProducers, dxPScxCommon, dxPSCore,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, dxPScxGrid6Lnk,
  AdvCombo;

type
  TfrmListStokCabang = class(TForm)
    tscrlbx1: TTeScrollBox;
    TePanel4: TTePanel;
    ilMenu: TImageList;
    TePanel1: TTePanel;
    ilToolbar: TImageList;
    TePanel2: TTePanel;
    TeLabel1: TTeLabel;
    SaveDialog1: TSaveDialog;
    TePanel3: TTePanel;
    dtstprvdr1: TDataSetProvider;
    sqlqry1: TSQLQuery;
    ds2: TDataSource;
    ds3: TClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxstyl1: TcxStyle;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    cxGrid11Level1: TcxGridLevel;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cbbCabang: TAdvComboBox;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);

  private
    conn3:TSQLConnection;
    flagedit : Boolean;
    fid : integer;
    fnomorjual : string ;
    FPivotChartLink: TcxPivotGridChartConnection;
    xtotal,xhpp : Double;
    iskupon : Integer;
    ntotalpremium , ntotalsolar , ntotalpertamax, ntotalpertamaxplus , ntotalpenjualan : double;
    ntotaljpremium , ntotaljsolar , ntotaljpertamax, ntotaljpertamaxplus  : double;
    ntotalbayar : double;
    xhppPremium,xhppsolar,xhpppertamaxplus,xhpppertamax : double ;
    function GetPivotChartLink: TcxPivotGridChartConnection;
  public

    procedure loaddata;
    procedure refreshdata;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmListStokCabang: TfrmListStokCabang;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmListStokCabang.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListStokCabang.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListStokCabang.refreshdata;
begin

end;

procedure TfrmListStokCabang.sbNewClick(Sender: TObject);
begin
   refreshdata;

//   sbdelete.Enabled := False;
end;




procedure TfrmListStokCabang.FormShow(Sender: TObject);
begin
  conn3 := xCreateConnection(ctMySQL,'192.168.194.41','bsm','root','Zainal_12345');

  flagedit := False;

  refreshdata;
end;





procedure TfrmListStokCabang.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListStokCabang.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListStokCabang.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
  adbase:string;
begin
  if cbbCabang.ItemIndex=0 then
     adbase :='bsmcabang.tmasterstok'
  else
  if cbbCabang.ItemIndex=1 then
     adbase:='bsmcabang2.tmasterstok'
  else
  if cbbCabang.ItemIndex=2 then
       adbase:='bsmcabang3.tmasterstok'
  else
  if cbbCabang.ItemIndex=3 then
       adbase:='bsmcabang4.tmasterstok'
  else
  if cbbCabang.ItemIndex=4 then
       adbase:='bsmcabang5.tmasterstok'
  else
  if cbbCabang.ItemIndex=5 then
       adbase:='bsmcabang6.tmasterstok'
  else
  if cbbCabang.ItemIndex=6 then
     adbase:='bsmcabang7.tmasterstok'
  else
  if cbbCabang.ItemIndex=7 then
     adbase:='tmasterstokpusat';




      s:= 'SELECT brg_kode Kode,brg_nama Nama,SUM(mst_stok_in-mst_stok_out) stok FROM tbarangpusat'
+ ' INNER JOIN '+adbase+' ON mst_brg_kode=brg_kode'
+ ' and tbarangpusat.brg_sup_kode="PKRT N3"'
+ ' GROUP BY brg_kode ';

  ds3.Close;
        sqlqry1.SQLConnection := conn3;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Kode,Nama,Stok';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 160;
           cxGrid1DBTableView1.Columns[2].MinWidth := 80;
        for i:=0 To cxGrid1DBTableView1.ColumnCount -1 do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;


end;

procedure TfrmListStokCabang.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

function TfrmListStokCabang.GetPivotChartLink: TcxPivotGridChartConnection;
begin
end;

procedure TfrmListStokCabang.cxButton7Click(Sender: TObject);
begin
 if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;
end;

end.
