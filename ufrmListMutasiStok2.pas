unit ufrmListMutasiStok2;

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
  TfrmListMutasiStok2 = class(TForm)
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
    procedure FormCreate(Sender: TObject);


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
    function GetPivotChartLink: TcxPivotGridChartConnection;

    function GetCDSGudang: TClientDataset;
  public

    procedure loaddata;
    procedure refreshdata;
    property PivotChartLink: TcxPivotGridChartConnection read GetPivotChartLink
        write FPivotChartLink;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    { Public declarations }
  end;

var

  frmListMutasiStok2: TfrmListMutasiStok2;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmListMutasiStok2.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListMutasiStok2.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListMutasiStok2.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListMutasiStok2.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListMutasiStok2.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListMutasiStok2.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListMutasiStok2.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListMutasiStok2.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
begin

      s:= 'select brg_kode Kode,brg_nama Nama,Kategori, '
+ ' ifnull(Hsaldoawal,0) HAwal,ifnull(saldoawal,0) Awal,'
+ ' ifnull(qty_RI,0) qty_RI,ifnull(H_RI,0) H_RI,'
+ ' ifnull(qty_Ret,0) qty_Ret,ifnull(H_Ret,0) H_Ret,'
+ ' ifnull(qty_Ret_Jual,0) qty_Ret_Jual,ifnull(H_Ret_Jual,0) H_Ret_Jual,'
+ ' ifnull(qty_kor,0) qty_kor,ifnull(H_kor,0) H_kor,'
+ ' ifnull(qty_mintabahan,0) qty_mintabahan,ifnull(H_mintabahan,0) H_mintabahan,'
+ ' ifnull(qty_returbahan,0) qty_returbahan,ifnull(H_returbahan,0) H_returbahan,'
+ ' ifnull(qty_stbj,0) qty_stbj,ifnull(H_stbj,0) H_stbj,'
+ ' ifnull(qty_mts,0) qty_mts,ifnull(H_mts,0) H_mts,'
+ ' ifnull(qty_mus,0) qty_Mus,ifnull(H_mus,0) H_Mus,'
+ ' ifnull(qty_jual,0) qty_jual,ifnull(H_jual,0) H_jual,'
+ ' ifnull(akhir,0) Akhir,ifnull(HAkhir,0) Hakhir'
+ ' from ( select brg_kode,brg_nama,ktg_nama kategori,brg_hrgbeli,'
+ ' (select sum(mst_stok_in-mst_stok_out)'
+ ' from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal < '+quotd(startdate.Date)+') saldoawal,'
+ ' (select sum((mst_stok_in-mst_stok_out) *(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli)))'
+ ' from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal < '+quotd(startdate.Date)+') Hsaldoawal,'
+ ' (select sum(mst_stok_in) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RI%")  qty_RI,'
+ ' (select sum(mst_stok_in*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+' and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RI%")  H_RI,'
+ ' (select sum(mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RET.%")  qty_Ret,'
+ ' (select sum(mst_stok_out*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RET.%")  H_Ret,'
+ ' (select sum(mst_stok_in) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RETJ%")  qty_Ret_Jual,'
+ ' (select sum(mst_stok_in*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RETJ%")  H_Ret_Jual,'
+ ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%KOR%")  qty_Kor,'
+ ' (select sum((mst_stok_in-mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%KOR%")  H_Kor,'
+ ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%MTB%")  qty_MintaBahan,'
+ ' (select sum((mst_stok_in-mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%MTB%")  H_MintaBahan,'
+ ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RTB%")  qty_ReturBahan,'
+ ' (select sum((mst_stok_in-mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%RTB%")  H_ReturBahan,'
+ ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%STB%")  qty_STBJ,'
+ ' (select sum((mst_stok_in-mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%STB%")  H_STBJ,'
+ ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%MTG%")  qty_Mts,'
+ ' (select sum((mst_stok_in-mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%MTG%")  H_Mts,'
+ ' (select sum(mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%MUS%")  qty_Mus,'
+ ' (select sum((mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%MUS%")  H_Mus,'
+ ' (select sum(mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%DO%")  qty_Jual,'
+ ' (select sum(mst_stok_out*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal between '+quotd(startdate.Date)+' and '+quotd(enddate.Date)+' and mst_noreferensi like "%DO%")  H_Jual,'
+ ' (select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal <= '+quotd(enddate.Date)+') akhir,'
+ ' (select sum((mst_stok_in-mst_stok_out)*(if(mst_avgcost > 0 ,mst_avgcost,mst_hargabeli))) from tmasterstok where mst_brg_kode=a.brg_kode and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')+'  and mst_tanggal <= '+quotd(enddate.Date)+') Hakhir'
+ ' from tbarang a  left join tkategori on ktg_kode=brg_ktg_kode ) final ';



  ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Kode,Nama,Kategori,Awal,HAwal,Qty_RI,H_RI,Qty_Ret,H_Ret,Qty_Ret_Jual,H_Ret_Jual,Qty_Kor,H_Kor,Qty_Mintabahan,H_Mintabahan,Qty_ReturBahan,H_ReturBahan,Qty_stbj,H_Stbj,Qty_Mts,H_Mts,Qty_Mus,H_Mus,Qty_Jual,H_Jual,Akhir,HAkhir';
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
         Label4.Caption := IntToStr(ds3.RecordCount);
        cxGrid1DBTableView1.Columns[4].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[4].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[10].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[10].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[12].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[12].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[14].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[14].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[16].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[16].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[18].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[18].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[20].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[20].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[22].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[22].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[24].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[24].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[26].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[26].Summary.FooterFormat:='###,###,###,###';


//  hitung;
//          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
//           SetPivotColumns(['Bulan']);
//           SetPivotRow (['Salesman']);
//           SetPivotData(['Nilai']);

end;

procedure TfrmListMutasiStok2.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListMutasiStok2.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListMutasiStok2.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListMutasiStok2.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListMutasiStok2.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListMutasiStok2.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListMutasiStok2.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListMutasiStok2.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListMutasiStok2.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListMutasiStok2.cxGrid1DBTableView1DataControllerFilterChanged(
  Sender: TObject);
begin
Label4.Caption := IntToStr(cxGrid1DBTableView1.DataController.FilteredRecordCount);
end;

function TfrmListMutasiStok2.GetCDSGudang: TClientDataset;
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


procedure TfrmListMutasiStok2.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupGudangAsal.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);

end;

end.
