unit ufrmListTransaksiHarian2;

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
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, AdvEdit,
  AdvEdBtn, dxPScxGrid6Lnk, MemDS, DBAccess, MyAccess;

type
  TfrmListTransaksiHarian2 = class(TForm)
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
    Label5: TLabel;
    edtCustomer: TAdvEditBtn;
    edtCusNama: TAdvEdit;
    cxPivot: TcxDBPivotGrid;
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
    procedure cxButton1Click(Sender: TObject);
    procedure edtCustomerClickBtn(Sender: TObject);
    procedure LihatFakturPenjualan1Click(Sender: TObject);

  private
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

  frmListTransaksiHarian2: TfrmListTransaksiHarian2;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink, uFrmbantuan, ufrmFP, ufrmBayarCustomer;
{$R *.dfm}



procedure TfrmListTransaksiHarian2.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListTransaksiHarian2.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListTransaksiHarian2.refreshdata;
begin
  startdate.DateTime := Date;
  startdate.setfocus;

end;

procedure TfrmListTransaksiHarian2.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListTransaksiHarian2.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListTransaksiHarian2.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListTransaksiHarian2.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListTransaksiHarian2.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
begin


        s:= ' select Tanggal,sls_nama Salesman,Customer,cus_nama Nama,Tax,sum(Bruto) Bruto,sum(Disc)Disc,sum(Dpp) Dpp,sum(Pajak) Pajak,sum(Total) Total'
        + ' ,sum(Biaya_Promosi) Biaya_Promosi,sum(Kontrak) Kontrak,sum(freight) Freight,'
        + ' sum(Retur) Retur,sum(Bayar_Cash) Bayar_Cash,sum(Bayar_Transfer) Bayar_Transfer,sum(Giro) Giro,sum(Deposit) Deposit,sum(koreksi_lr) Koreksi_LR,'
        + ' sum(Hutang_Internal) Hutang_Internal,sum(UM_Penjualan) UM_Penjualan,sum(Ppn_keluaran) PPn_Keluaran,sum(pph_22) PPh_22,sum(Potongan) Potongan'
        + ' from transaksi_harian A inner join tcustomer on cus_kode=customer '
        + ' inner join tsalesman C on a.salesman=c.sls_kode '
        + ' where tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
        + ' and customer like '+ quot(edtcustomer.text+'%')
        +' group by Tanggal,customer,cus_nama,Tax '
        + ' order by Tanggal';

        ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;


        Skolom :='Tanggal,Salesman,Customer,Nama,Tax,Bruto,Disc,Dpp,Pajak,Total,Freight,Biaya_Promosi,Kontrak,Retur,Bayar_Cash,Bayar_Transfer,Giro,Deposit,Hutang_Internal,Koreksi_LR,UM_Penjualan,PPn_Keluaran,PPh_22,Potongan';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 100;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           cxGrid1DBTableView1.Columns[7].MinWidth := 100;
           cxGrid1DBTableView1.Columns[8].MinWidth := 100;
           cxGrid1DBTableView1.Columns[9].MinWidth := 100;
        for i:=0 To cxGrid1DBTableView1.ColumnCount -1 do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;
        cxGrid1DBTableView1.Columns[1].Summary.GroupFooterKind:=skCount;
        cxGrid1DBTableView1.Columns[1].Summary.GroupFooterFormat:='####';
        cxGrid1DBTableView1.Columns[10].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[10].Summary.GroupFooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[9].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[5].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[5].Summary.GroupFooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[5].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[5].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[6].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.GroupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.GroupFooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[9].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[5].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[5].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[11].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[11].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[12].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[12].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[13].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[13].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[14].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[14].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[15].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[15].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[16].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[16].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[17].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[17].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[18].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[18].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[19].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[19].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[20].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[20].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[21].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[21].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[22].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[22].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[23].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[23].Summary.FooterFormat:='###,###,###,###';

//  hitung;
          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Bulan']);
           SetPivotRow (['Salesman']);
           SetPivotData(['Bayar_Cash','Bayar_Transfer','Giro','Hutang_Internal','um_Penjualan']);


end;

procedure TfrmListTransaksiHarian2.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListTransaksiHarian2.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListTransaksiHarian2.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListTransaksiHarian2.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListTransaksiHarian2.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListTransaksiHarian2.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListTransaksiHarian2.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListTransaksiHarian2.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListTransaksiHarian2.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListTransaksiHarian2.cxButton1Click(Sender: TObject);
begin
//With cxPivot.GetFieldByName('Salesman') do
//  begin
//    if SortBySummaryInfo.Field = nil then
//      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Riil')
//    else
//      SortBySummaryInfo.Field := nil;
//  end;
//
//With cxPivot.GetFieldByName('Customer') do
//  begin
//    if SortBySummaryInfo.Field = nil then
//      SortBySummaryInfo.Field := cxPivot.GetFieldByName('Riil')
//    else
//      SortBySummaryInfo.Field := nil;
//  end;

end;

procedure TfrmListTransaksiHarian2.edtCustomerClickBtn(Sender: TObject);
begin
  sqlbantuan := ' select cus_kode Kode,cus_nama Nama from tcustomer  ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
 begin
  edtcustomer.Text := varglobal;
  edtCusNama.Text :=  varglobal1;
 end;

end;

procedure TfrmListTransaksiHarian2.LihatFakturPenjualan1Click(
  Sender: TObject);
var
  frmFP: TfrmFP;
  frmbayarcustomer : TfrmBayarCustomer;
begin
  inherited;
   If ds3.FieldByname('Nomor').IsNull then exit;
  if pos(UpperCase('FP'),UpperCase(ds3.FieldByname('Nomor').AsString)) > 0  then
  begin
  if ActiveMDIChild.Caption <> 'Faktur Penjualan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFP  := frmmenu.ShowForm(TfrmFP) as TfrmFP;
      frmFP.ID := ds3.FieldByname('Nomor').AsString;
      frmFP.FLAGEDIT := True;
      frmFP.edtnOMOR.Text := ds3.FieldByname('Nomor').AsString;
      frmFP.loaddataall(ds3.FieldByname('Nomor').AsString);
//      if cekbayar(CDS.FieldByname('Invoice').AsString) = 1 then
//      begin
//        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
        frmFP.cxButton2.Enabled :=False;
        frmFP.cxButton1.Enabled :=False;
        frmFP.cxButton3.Enabled := False;
//      end;
   end;
   frmFP.Show;
 end;
   if pos(UpperCase('CR'),UpperCase(ds3.FieldByname('Nomor').AsString)) > 0  then
  begin
  if ActiveMDIChild.Caption <> 'Faktur Penjualan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBayarCustomer  := frmmenu.ShowForm(TfrmBayarCustomer) as TfrmBayarCustomer;
      frmBayarCustomer.ID := ds3.FieldByname('Nomor').AsString;
      frmBayarCustomer.FLAGEDIT := True;
      frmBayarCustomer.edtnOMOR.Text := ds3.FieldByname('Nomor').AsString;
      frmBayarCustomer.loaddataall(ds3.FieldByname('Nomor').AsString);
//      if cekbayar(CDS.FieldByname('Invoice').AsString) = 1 then
//      begin
//        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
        frmBayarCustomer.cxButton2.Enabled :=False;
        frmBayarCustomer.cxButton1.Enabled :=False;

//      end;
   end;
   frmBayarCustomer.Show;
 end;
end;


end.
