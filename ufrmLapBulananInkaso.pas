unit ufrmLapBulananInkaso;

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
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter, AdvCombo,
  cxCurrencyEdit, cxGridDBBandedTableView, dxPScxGrid6Lnk, MemDS, DBAccess,
  MyAccess;

type
  TfrmLapBulananInkaso = class(TForm)
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
    cxVCLPrinter: TdxComponentPrinter;
    cxVCLPrinterChart: TdxGridReportLink;
    btnRefresh: TcxButton;
    Label1: TLabel;
    TePanel5: TTePanel;
    cxButton8: TcxButton;
    cxButton7: TcxButton;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    cxGrid1DBBandedTableView1Column1: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column3: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column4: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column5: TcxGridDBBandedColumn;
    cxGrid1DBBandedTableView1Column8: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    startdate: TDateTimePicker;
    Label2: TLabel;
    enddate: TDateTimePicker;
    sqlqry1: TMyQuery;
    procedure FormDblClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure sbNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure sbPrintClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure TeSpeedButton1Click(Sender: TObject);

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

  frmLapBulananInkaso: TfrmLapBulananInkaso;

implementation
   uses Ulib, MAIN, uModuleConnection, cxgridExportlink;
{$R *.dfm}



procedure TfrmLapBulananInkaso.FormDblClick(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TfrmLapBulananInkaso.btnExitClick(Sender: TObject);
begin
      Release;
end;

procedure TfrmLapBulananInkaso.refreshdata;
begin
  startdate.DateTime :=date;
  enddate.DateTime :=Date;
end;

procedure TfrmLapBulananInkaso.sbNewClick(Sender: TObject);
begin
   refreshdata;

end;




procedure TfrmLapBulananInkaso.FormShow(Sender: TObject);
begin
  flagedit := False;
  refreshdata;
end;





procedure TfrmLapBulananInkaso.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
      SelectNext(ActiveControl,True,True);

end;


procedure TfrmLapBulananInkaso.sbPrintClick(Sender: TObject);
begin
  refreshdata;
end;

procedure TfrmLapBulananInkaso.loaddata;
var
  ssql:string;
  capaibulanini : double;
begin
ssql:= 'select *,ifnull(jatuhtempo,0)+ifnull(inkaso,0) target,(inkaso/(ifnull(jatuhtempo,0)+ifnull(inkaso,0))*100) persen'
+ ' from (select sls_nama Salesman,sum(ifnull(bycd_bayar,0)) Inkaso,('
+ ' select'
+ ' sum(Sisa_Piutang-ifnull(Retur,0)) Sisa_piutang'
+ ' from  (select sls_kode,fp_nomor Nomor,fp_tanggal Tanggal ,fp_jthtempo JthTempo, fp_Memo Memo ,'
+ ' sls_nama Salesman,cus_nama  Customer,  fp_amount Total,'
+ ' (fp_biayapr*(fp_amount-fp_taxamount)/100)+fp_biayarp CN_user, fp_cn Kontrak,fp_DP DP,fp_bayar Bayar,fp_istax,'
+ ' (select sum(retj_amount) from tretj_hdr where retj_fp_nomor =z.fp_nomor) Retur,'
+ ' (FP_AMOUNT-FP_cn-fp_dp-fp_bayar) Sisa_Piutang, DATEDIFF('+QuotD(enddate.DateTime)+',fp_jthtempo) AS OVERDUE'
+ ' from tfp_hdr z inner join tcustomer on cus_kode=fp_cus_kode'
+ ' left join tdo_hdr on fp_do_nomor=do_nomor  left join tso_hdr on do_so_nomor=so_nomor'
+ ' left JOIN Tsalesman on sls_kode=so_sls_kode where (FP_AMOUNT-FP_cn-fp_dp-fp_bayar) > 0  ) a'
+ ' where (sisa_piutang-ifnull(Retur,0)) > 1  and tanggal <= '+QuotD(enddate.DateTime)+' and  overdue >= 0 and sls_kode =z.sls_kode'
+ ' group by sls_kode'
+ ' ) jatuhtempo'
+ ' from tbayarcus_hdr INNER join tbayarcus_dtl on byc_nomor=bycd_byc_nomor'
+ ' inner join tfp_hdr zzz on bycd_fp_nomor=fp_nomor'
+ ' inner join tcustomer on cus_kode = fp_cus_kode'
+ ' left join tdo_hdr on do_nomor= fp_do_nomor'
+ ' left join tso_hdr on do_so_nomor=so_nomor'
+ ' left join tsalesman z on so_sls_kode=sls_kode'
+ ' where byc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
+ ' group by sls_nama) final';

        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;
//        capaibulanini := cVarToFloat(TcxDBGridHelper(cxGrid1).GetFooterSummary('riilbulanini'))/ cVarToFloat(TcxDBGridHelper(cxGrid1).GetFooterSummary('targetbulanini'));
//TcxGridDBTableSummaryItem(cxGrid1).Column[0].Caption := '00';

end;

procedure TfrmLapBulananInkaso.btnTampilClick(Sender: TObject);
begin
    loaddata;

end;

procedure TfrmLapBulananInkaso.TeSpeedButton1Click(Sender: TObject);
begin

     if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;


function TfrmLapBulananInkaso.GetPivotChartLink: TcxPivotGridChartConnection;
begin
  If not Assigned(FPivotChartLink) then
    FPivotChartLink := TcxPivotGridChartConnection.Create(Self);
  Result := FPivotChartLink;
end;

end.
