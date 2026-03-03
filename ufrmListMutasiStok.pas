unit ufrmListMutasiStok;

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
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, MemDS, DBAccess, MyAccess;

type
  TfrmListMutasiStok = class(TForm)
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
    sqlqry2: TSQLQuery;
    ds2: TDataSource;
    ds3: TClientDataSet;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxstyl1: TcxStyle;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    cxChart: TcxGrid;
    cxGrdChart: TcxGridChartView;
    lvlChart: TcxGridLevel;
    cxPivot: TcxDBPivotGrid;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrdDetail: TcxGridDBTableView;
    cxGrid11Level1: TcxGridLevel;
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    cxLookupGudangAsal: TcxExtLookupComboBox;
    sqlqry1: TMyQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure cxPageControl1Click(Sender: TObject);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure dttanggalChange(Sender: TObject);
    procedure TeSpeedButton2Click(Sender: TObject);
    procedure SetPivotColumns(ColumnSets: Array Of String);
    procedure SetPivotData(ColumnSets: Array Of String);
    procedure SetPivotRow(ColumnSets: Array Of String);
    procedure cxGrid1DBTableView1DataControllerFilterChanged(
      Sender: TObject);

  private
    FCDSGudang: TClientDataset;
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
    function GetCDSGudang: TClientDataset;
    function GetPivotChartLink: TcxPivotGridChartConnection;
  public

    procedure loaddata;
    procedure refreshdata;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;

    { Public declarations }
  end;

var

  frmListMutasiStok: TfrmListMutasiStok;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmListMutasiStok.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupGudangAsal.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);
end;

procedure TfrmListMutasiStok.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListMutasiStok.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListMutasiStok.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListMutasiStok.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListMutasiStok.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListMutasiStok.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListMutasiStok.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListMutasiStok.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
begin


      s:= 'select brg_kode Kode,brg_nama Nama,Kategori,ifnull(saldoawal,0) _Awal,ifnull(value_saldoawal,0) V_Awal,'
          + ' ifnull(qty_in,0) _In,ifnull(V_qty_in,0) V_In,ifnull(qty_out,0) _Out,ifnull(v_qty_out,0) V_Out,'
          + ' ifnull(saldoawal,0) + ifnull(qty_in,0) - ifnull(qty_out,0) _Akhir,'
          + ' ifnull(value_saldoawal,0) + ifnull(V_qty_in,0) - ifnull(V_qty_out,0) V_Akhir'
          + '  from ('
          + ' select brg_kode,brg_nama,ktg_nama kategori,'
          + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and '
          + '  mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%') +' and mst_tanggal < ' + QuotD(startdate.DateTime) + ') saldoawal,'
          + ' (select sum((mst_stok_in-mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and '
          + '  mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%') +' and mst_tanggal < ' + QuotD(startdate.DateTime) + ') Value_saldoawal,'
          + ' (select sum(mst_stok_in) from tmasterstok where mst_brg_kode=a.brg_kode and '
          + ' mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%') +' and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) + ')  qty_in,'
          + ' (select sum((mst_stok_in)*(IF(mst_avgcost > 0,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and '
          + ' mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%') +' and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) + ')  v_qty_in,'
          + ' (select sum(mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and '
          + ' mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%') +' and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) + ')  qty_out,'
          + ' (select sum((mst_stok_out)*(IF(mst_avgcost > 0,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and '
          + ' mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%') +' and mst_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime) + ')  v_qty_out,'
          + ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and '
          + ' mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%') +' and mst_tanggal <= ' + QuotD(enddate.DateTime) + ') akhir'
          + ' from tbarang a  inner join tkategori on ktg_kode=brg_ktg_kode ) final ';
//          + ' where ifnull(saldoawal,0) > 0 or ifnull(qty_in,0) > 0 or ifnull(qty_OUT,0) > 0 ' ;


  ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Kode,Nama,Kategori,_Awal,V_awal,_in,V_in,_out,V_out,_Akhir,V_Akhir';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 100;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 60;
           cxGrid1DBTableView1.Columns[5].MinWidth := 60;
           cxGrid1DBTableView1.Columns[6].MinWidth := 60;
           cxGrid1DBTableView1.Columns[7].MinWidth := 60;

        for i:=0 To cxGrid1DBTableView1.ColumnCount -1 do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;
            cxGrid1DBTableView1.Columns[4].Summary.FooterKind:=skSum;
            cxGrid1DBTableView1.Columns[4].Summary.FooterFormat:='###,###,###,###';
            cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
            cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';
            cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
            cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';
            cxGrid1DBTableView1.Columns[10].Summary.FooterKind:=skSum;
            cxGrid1DBTableView1.Columns[10].Summary.FooterFormat:='###,###,###,###';

         Label4.Caption := IntToStr(ds3.RecordCount);
end;

procedure TfrmListMutasiStok.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListMutasiStok.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListMutasiStok.TeSpeedButton1Click(Sender: TObject);
begin

  IF PageControl1.Pages[1].Visible  then
     TcxDBPivotHelper(cxPivot).ExportToXLS
  else
  begin
     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;
 end;


end;


procedure TfrmListMutasiStok.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListMutasiStok.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListMutasiStok.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListMutasiStok.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListMutasiStok.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListMutasiStok.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListMutasiStok.cxGrid1DBTableView1DataControllerFilterChanged(
  Sender: TObject);
begin
Label4.Caption := IntToStr(cxGrid1DBTableView1.DataController.FilteredRecordCount);
end;

function TfrmListMutasiStok.GetCDSGudang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSGudang) then
  begin
    S := 'select gdg_nama as Gudang, gdg_kode Kode '
        +' from tgudang';


    FCDSGudang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSGudang;
end;

end.
