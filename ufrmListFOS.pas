unit ufrmListFOS;

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
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue, MemDS, DBAccess, MyAccess;

type
  TfrmListFOS = class(TForm)
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
    cxButton3: TcxButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    PopupMenu1: TPopupMenu;
    LihatFakturPenjualan1: TMenuItem;
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
    procedure cxButton3Click(Sender: TObject);
    procedure cxGrid1DBTableView1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
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

  frmListFOS: TfrmListFOS;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink,uReport,ufrmFP;
{$R *.dfm}



procedure TfrmListFOS.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmListFOS.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmListFOS.refreshdata;
begin
  startdate.DateTime := Date;
  enddate.DateTime := Date ;
  startdate.setfocus;

end;

procedure TfrmListFOS.sbNewClick(Sender: TObject);
begin
   refreshdata;
   startdate.SetFocus;
//   sbdelete.Enabled := False;
end;




procedure TfrmListFOS.FormShow(Sender: TObject);
begin
  flagedit := False;
  startdate.DateTime := Date;
  enddate.DateTime := Date;
  refreshdata;
end;





procedure TfrmListFOS.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmListFOS.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmListFOS.loaddata;
var
  skolom,s: string ;
  afilter : string ;
  i:integer;
begin

      s:= ' select Nomor,Tanggal,JthTempo,Salesman,Tax,Customer,Total Total,CN_User Biaya_Promosi,'
        + ' Kontrak,DP,Bayar,ifnull(Retur,0) Retur,Sisa_Piutang-ifnull(Retur,0) Sisa_piutang,Overdue,'
        + ' (case when overdue < 0 then " Belum" when overdue >= 0  and overdue <=30  then "0 sd 30" when overdue >= 31  and overdue <=60 then "31 s/d 60" '
        + ' when overdue >= 61  and overdue <=90 then "61 s/d 90" when overdue >= 91  and overdue <=120 then "91 s/d 120" else "x > 120" end ) Range_overdue '
        + ' from '
        + ' (select FP_nomor Nomor,fp_tanggal Tanggal ,fp_jthtempo JthTempo, fp_Memo Memo ,'
        + ' sls_nama Salesman,if(fp_istax=1,"PPN","Non PPN") Tax,cus_nama  Customer,  fp_amount Total,'
        + ' (fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp CN_user,'
        + ' fp_cn Kontrak,fp_DP DP,fp_bayar Bayar,fp_istax,'
        + ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor =z.fp_nomor) Retur, '
        + ' (FP_AMOUNT-fp_dp-fp_bayar) Sisa_Piutang,'
        + ' DATEDIFF('+quotd(startdate.DateTime)+',fp_jthtempo) AS OVERDUE '
        + ' from tfp_hdr z inner join tcustomer on cus_kode=fp_cus_kode left join'
        + ' tdo_hdr on fp_do_nomor=do_nomor  left join tso_hdr on do_so_nomor=so_nomor'
        + ' left JOIN tsalesman on sls_kode=so_sls_kode'
        + ' where (FP_AMOUNT-fp_dp-fp_bayar) > 0 '
        + ' group by fp_nomor ,fp_tanggal ,fp_memo ,cus_nama ) a'
        + ' where (sisa_piutang-ifnull(Retur,0)) > 1  and tanggal <= '+quotd(enddate.DateTime)+' order by Overdue';

  ds3.Close;
        sqlqry1.Connection := frmmenu.conn;
        sqlqry1.SQL.Text := s;
        ds3.open;

//
        Skolom :='Nomor,Tanggal,JthTempo,Salesman,Tax,Customer,Total,Biaya_Promosi,Kontrak,DP,Bayar,Retur,Sisa_Piutang,Overdue,Range_Overdue';
        QueryToDBGrid(cxGrid1DBTableView1, s,skolom ,ds2);
           cxGrid1DBTableView1.Columns[0].MinWidth := 60;
           cxGrid1DBTableView1.Columns[1].MinWidth := 60;
           cxGrid1DBTableView1.Columns[2].MinWidth := 60;
           cxGrid1DBTableView1.Columns[3].MinWidth := 100;
           cxGrid1DBTableView1.Columns[4].MinWidth := 100;
           cxGrid1DBTableView1.Columns[5].MinWidth := 100;
           cxGrid1DBTableView1.Columns[6].MinWidth := 100;
           cxGrid1DBTableView1.Columns[7].MinWidth := 100;
           cxGrid1DBTableView1.Columns[8].MinWidth := 100;
           cxGrid1DBTableView1.Columns[9].MinWidth := 100;
           cxGrid1DBTableView1.Columns[10].MinWidth := 100;

        for i:=0 To cxGrid1DBTableView1.ColumnCount -1 do
        begin
          if ds3.Fields[i].DataType = ftFloat then
          begin
             ds3.Fields[i].Alignment := taRightJustify;
             TFloatField(ds3.Fields[i]).DisplayFormat := '###,###,###';
          end;

        end;

        cxGrid1DBTableView1.Columns[9].Summary.groupFooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.groupFooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[6].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[6].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[7].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[7].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[8].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[8].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[9].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[9].Summary.FooterFormat:='###,###,###,###';

        cxGrid1DBTableView1.Columns[10].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[10].Summary.FooterFormat:='###,###,###,###';
                cxGrid1DBTableView1.Columns[11].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[11].Summary.FooterFormat:='###,###,###,###';
                cxGrid1DBTableView1.Columns[12].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[12].Summary.FooterFormat:='###,###,###,###';
        cxGrid1DBTableView1.Columns[13].Summary.FooterKind:=skSum;
        cxGrid1DBTableView1.Columns[13].Summary.FooterFormat:='###,###,###,###';


//  hitung;

          TcxDBPivotHelper(cxPivot).LoadFromCDS(ds3);
           SetPivotColumns(['Range_Overdue']);
           SetPivotRow (['Salesman']);
           SetPivotData(['Sisa_Piutang']);

end;

procedure TfrmListFOS.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmListFOS.cxPageControl1Click(Sender: TObject);
begin
IF PageControl1.Pages[2].Visible  then
begin
  PivotChartLink.GridChartView := cxGrdChart;
  PivotChartLink.PivotGrid := cxPivot;
end;
end;

procedure TfrmListFOS.TeSpeedButton1Click(Sender: TObject);
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


procedure TfrmListFOS.dttanggalChange(Sender: TObject);
begin
  enddate.DateTime := startdate.DateTime;
end;

function TfrmListFOS.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

procedure TfrmListFOS.TeSpeedButton2Click(Sender: TObject);
begin
//  IF PageControl1.Pages[1].Visible  then
//     cxVCLPrinterPivot.Preview
//  else
//  if PageControl1.Pages[2].Visible  then
//    cxVCLPrinterChart.Preview;
end;

procedure TfrmListFOS.SetPivotRow(ColumnSets: Array Of String);
begin
  TcxDBPivotHelper(cxPivot).SetRowColumns(ColumnSets);
end;

procedure TfrmListFOS.SetPivotColumns(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetColColumns(ColumnSets);
end;

procedure TfrmListFOS.SetPivotData(ColumnSets: Array Of String);
begin

  TcxDBPivotHelper(cxPivot).SetDataColumns(ColumnSets);
end;


procedure TfrmListFOS.cxButton3Click(Sender: TObject);
  var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'FOS';

          s:= ' select ' + quot(cxGrid1DBTableView1.DataController.Filter.FilterText) + ' as filter, '
          + Quot(FormatDateTime('dd/mm/yyyy',enddate.DateTime)) + ' as tgl , '
        + ' Nomor,Tanggal,JthTempo,Salesman,Customer,Total Total,CN_User Biaya_Promosi,'
        + ' Kontrak,DP,Bayar,ifnull(Retur,0) Retur,Sisa_Piutang-ifnull(Retur,0) Sisa_piutang,Overdue,'
        + ' (case when overdue < 0 then " Belum" when overdue >= 0  and overdue <=30  then "0 sd 30" when overdue >= 31  and overdue <=60 then "31 s/d 60" '
        + ' when overdue >= 61  and overdue <=90 then "61 s/d 90" when overdue >= 91  and overdue <=120 then "91 s/d 120" else "x > 120" end ) Range_overdue '
        + ' from '
        + ' (select fp_nomor Nomor,fp_tanggal Tanggal ,fp_jthtempo JthTempo, fp_Memo Memo ,'
        + ' sls_nama Salesman,cus_nama  Customer,  fp_amount Total,'
        + ' (fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp CN_user,'
        + ' fp_cn Kontrak,fp_DP DP,fp_bayar Bayar,fp_istax,'
        + ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor =z.fp_nomor) Retur, '
        + ' (FP_AMOUNT-fp_dp-fp_bayar) Sisa_Piutang,'
        + ' DATEDIFF('+quotd(startdate.DateTime)+',fp_jthtempo) AS OVERDUE '
        + ' from tfp_hdr z inner join tcustomer on cus_kode=fp_cus_kode left join'
        + ' tdo_hdr on fp_do_nomor=do_nomor  left join tso_hdr on do_so_nomor=so_nomor'
        + ' left JOIN tsalesman on sls_kode=so_sls_kode'
        + ' where (FP_AMOUNT-fp_dp-fp_bayar) > 0 '
        + ' group by fp_nomor ,fp_tanggal ,fp_memo ,cus_nama ) a'
        + ' where (sisa_piutang-ifnull(Retur,0)) > 1  and tanggal <= '+quotd(enddate.DateTime)
        + ' AND ' + cxGrid1DBTableView1.DataController.Filter.FilterText
        +' order by customer,tanggal ';



    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;



procedure TfrmListFOS.cxGrid1DBTableView1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Overdue');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) > 0) then
    AStyle := cxStyle2;
end;

procedure TfrmListFOS.LihatFakturPenjualan1Click(Sender: TObject);
var
  frmFP: TfrmFP;
begin
  inherited;
  If ds3.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Faktur Penjualan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFP  := frmmenu.ShowForm(TfrmFP) as TfrmFP;
      frmFP.ID := ds3.FieldByname('Nomor').AsString;
      frmFP.FLAGEDIT := True;
      frmFP.edtnOMOR.Text := frmMenu.KDCABANG+'-SO'+copy(ds3.FieldByname('Nomor').AsString,6,Length(ds3.FieldByname('Nomor').AsString));
      frmFP.loaddataall(frmFP.edtnOMOR.Text);
        frmFP.cxButton2.Enabled :=False;
        frmFP.cxButton1.Enabled :=False;
        frmFP.cxButton3.Enabled := False;
   end;
   frmFP.Show;
end;


end.
