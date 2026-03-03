unit ufrmBrowseEstimasiSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, AdvCombo, cxCurrencyEdit,DateUtils,
  MemDS, DBAccess, MyAccess;

type
  TfrmBrowseEstimasiSales = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    clTarget: TcxGridDBColumn;
    Label1: TLabel;
    Label4: TLabel;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    clEstimasi: TcxGridDBColumn;
    clRealisasi: TcxGridDBColumn;
    clTargetInkaso: TcxGridDBColumn;
    clEstimasiInkaso: TcxGridDBColumn;
    clRealisasiInkaso: TcxGridDBColumn;
    clRatio: TcxGridDBColumn;
    clRatio2: TcxGridDBColumn;
    btnRefresh: TcxButton;
    clSalesman: TcxGridDBColumn;
    clKodeSalesman: TcxGridDBColumn;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    clKunjunganSales: TcxGridDBColumn;
    clKunjunganMarketing: TcxGridDBColumn;
    cxButton1: TcxButton;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    clMarketing: TcxGridDBColumn;
    CLpf: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata ;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clCustomerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function gettarget(akode:string): double;
    function cekdata(atahun:string;abulan:string;akode:string):Boolean;
    procedure cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure bacafile;
  private

    FFLAGEDIT: Boolean;
    FID: string;
    aDatabase2: string;
    aHost2: string;
    apassword2: string;
    auser2: string;



    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmBrowseEstimasiSales: TfrmBrowseEstimasiSales;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxGridExportLink,ufrmbantuan2;

{$R *.dfm}

procedure TfrmBrowseEstimasiSales.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmBrowseEstimasiSales.refreshdata;
begin
  FID:='';
  initgrid;

  edtTahun.Text := FormatDateTime('yyyy',Date);
end;
procedure TfrmBrowseEstimasiSales.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;

procedure TfrmBrowseEstimasiSales.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


end;

procedure TfrmBrowseEstimasiSales.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmBrowseEstimasiSales.loaddata ;
var
  ssql,s: string;
  tsql2,tsql : TMyQuery;
  i:Integer;
  akhir,awal : TDateTime;
begin
    akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text));
    awal  :=StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text);

  s:= ' select sls_kode,sls_nama Salesman,'
    + ' (SELECT sls_nama FROM tsalescustomer inner join tsalesman on sls_kode=sc_sls_kode'
    + ' WHERE sc_cus_kode=x.cus_kode) marketing,'
    + ' (select sum((100-fpd_discpr)*(fpd_harga*fpd_qty)/100*if(fp_istax=1,if(fp_tanggal<"2022/04/01",1.1,1.11),1)) - '
    + ' sum(fpd_cn*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100) - '
    + ' sum(fpd_bp_pr*((100-fpd_discpr)*fpd_harga/100)*fpd_qty/100)+sum(fpd_bp_rp*fpd_qty) Nilai'
    + '  from tfp_dtl inner join tfp_hdr on fp_nomor=fpd_fp_nomor '
    + '  inner join tdo_hdr on do_nomor=fp_do_nomor '
    + '  inner join tso_hdr on so_nomor =do_so_nomor '
    + '  inner join tbarang on brg_kode=fpd_brg_kode '
    + '  and month(fp_tanggal)='+ IntToStr(cbbBulan.itemindex +1)+' and year(fP_tanggal)='+ edtTahun.Text
    + '  and brg_isproductfocus=1 where fp_cus_kode=x.cus_kode and so_sls_kode=final.sls_kode) pf,'
    + ' cus_kode,cus_nama,esd_targetsales targetsales,esd_estimasisales estimasisales,esd_realisasisales realisasisales,CAST(0 AS DECIMAL) ratiosales ,'
    + ' esd_targetinkaso targetinkaso,esd_estimasiinkaso estimasiinkaso,esd_realisasiinkaso realisasiinkaso,CAST(0 AS DECIMAL) ratioinkaso from testimasisales_hdr '
    + ' inner join testimasisales_dtl on esd_esh_id=esh_id '
    + ' inner join tcustomer x on cus_kode=esd_cus_kode '
    + ' inner join tsalesman final on sls_kode=esh_sls_kode '
    + ' where '
    + ' esh_periode = ' + IntToStr(cbbBulan.ItemIndex+1)
    + ' and esh_tahun = ' + edtTahun.Text;

tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('kode_salesman').AsString := fieldbyname('sls_kode').AsString+fieldbyname('cus_kode').AsString;
      CDS.FieldByName('salesman').AsString := fieldbyname('salesman').AsString;
      CDS.FieldByName('marketing').AsString := fieldbyname('marketing').AsString;
      CDS.FieldByName('kode').AsString := fieldbyname('cus_kode').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('cus_nama').AsString;
      CDS.FieldByName('pf').asfloat  := fieldbyname('pf').AsFloat;      
      CDS.FieldByName('targetsales').asfloat  := fieldbyname('targetsales').AsFloat;
      CDS.FieldByName('estimasisales').asfloat  := fieldbyname('estimasisales').AsFloat;
      CDS.FieldByName('realisasisales').asfloat  := fieldbyname('realisasisales').AsFloat;
      CDS.FieldByName('ratiosales').asfloat  := fieldbyname('ratiosales').AsFloat;
      CDS.FieldByName('targetinkaso').asfloat  := fieldbyname('targetinkaso').AsFloat;
      CDS.FieldByName('estimasiinkaso').asfloat  := fieldbyname('estimasiinkaso').AsFloat;
      CDS.FieldByName('realisasiinkaso').asfloat  := fieldbyname('realisasiinkaso').AsFloat;
      CDS.FieldByName('ratioinkaso').asfloat  := fieldbyname('ratioinkaso').AsFloat;

      CDS.Post;
      i:=i+1;
      next;
    end;
   end;
  finally
    Free;
  end;



end;
// masukkan realisasi sales

           ssql:= 'SELECT salesman,customer,SUM(total-biaya_promosi-kontrak-retur) realisasisales '
                  + ' FROM penjualan'
                  + ' WHERE MONTH(tanggal)='+inttostr(cbbBulan.ItemIndex+1)+' AND YEAR(tanggal)='+edttahun.text
                  + ' group by salesman,customer ';

        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin

             if cds.Locate('kode_salesman',FieldByName('salesman').AsString+FieldByName('customer').AsString,[loCaseInsensitive]) then
             begin
               If cds.State <> dsEdit then CDS.Edit;
                cds.FieldByName('realisasisales').AsFloat := FieldByName('realisasisales').AsFloat;
                if cds.FieldByName('targetsales').AsFloat > 0 then
                cds.FieldByName('ratiosales').AsFloat := FieldByName('realisasisales').AsFloat/cds.FieldByName('targetsales').AsFloat *100;

                cds.Post;
             end ;
              Next;
            end;
          finally
            free;
          end;
        end;

 // Masukkan target piutan dan realisasi piutang

            s:=' SELECT  salesman,cus_kode customer, IF(piutang<0,0,PIUTANG) piutang, ifnull(inkaso,0) inkaso'
              + ' FROM ('
              + ' SELECT salesman,customer, SUM(IF (('
              + ' SELECT COUNT(*)'
              + ' FROM  tjatuhtempofp'
              + ' WHERE jt_fp_nomor=nomor) > 0, ('
              + ' SELECT SUM(jt_nilai)'
              + ' FROM  tjatuhtempofp'
              + ' WHERE jt_fp_nomor=nomor AND jt_tanggaljt <= '+quotd(akhir)+'), total)) - IFNULL(('
              + ' SELECT SUM(bayar_cash+bayar_transfer+giro+potongan+ppn+pph- IFNULL(('
              + ' SELECT SUM(bycd_bayar)'
              + ' FROM  tbayarcus_dtl'
              + ' INNER JOIN  tfp_hdr ON fp_nomor=bycd_fp_nomor'
              + ' WHERE bycd_byc_nomor=xx.nomor AND fp_jthtempo > '+quotd(akhir)+'),0))'
              + ' FROM  pembayaran xx'
              + ' WHERE customer=a.customer '
              + ' AND salesman = a.salesman'
              + ' AND tanggal < '+quotd(awal)+'),0) - IFNULL(('
              + ' SELECT SUM(retur)'
              + ' FROM  retur'
              + ' WHERE customer=a.customer'
              + ' AND salesman = a.salesman'
              + ' AND tanggal < '+quotd(awal)+'),0) piutang, ('
              + ' SELECT SUM(bycd_bayar)'
              + ' FROM  tbayarcus_dtl'
              + ' INNER JOIN  tbayarcus_hdr ON byc_nomor=bycd_byc_nomor'
              + ' INNER JOIN  tfp_hdr ON fp_nomor=bycd_fp_nomor'
              + ' WHERE fp_cus_kode=a.customer '
              + ' AND fp_tanggal < '+quotd(awal)+' AND fp_jthtempo > '+quotd(akhir)+' AND MONTH(byc_tanggal)='+IntToStr(cbbBulan.itemindex+1)+') tunai2, ('
              + ' SELECT SUM(IFNULL(bayar_cash,0)+ IFNULL(bayar_transfer,0)+ IFNULL(giro,0)+ IFNULL(potongan,0)+ IFNULL(pph,0)+ IFNULL(ppn,0))'
              + ' FROM  pembayaran'
              + ' WHERE MONTH(tanggal)='+IntToStr(cbbBulan.itemindex+1)+' AND YEAR(tanggal)= '+edttahun.text+' AND customer=a.customer and salesman=a.salesman) inkaso'
              + ' FROM  penjualan a'
              + ' INNER JOIN  tfp_hdr ON fp_nomor=nomor'
              + ' WHERE tanggal < '+quotd(awal)+' AND fp_jthtempo <= '+quotd(akhir)
              + ' GROUP BY salesman,customer'
              + ' ) a inner join  tcustomer on customer =cus_kode'
              + ' where ifnull(inkaso,0) > 1 or ifnull(piutang,0) > 1 ';
//              + ' union '
//              + ' select KETERANGAN,TARGET,INKASO  FROM ('
//              + ' select "Piutang Solo" GRUP,cus_nama KETERANGAN,0 TARGET,'
//              + ' ('
//              + ' SELECT SUM(IFNULL(bayar_cash,0)+ IFNULL(bayar_transfer,0)+ IFNULL(giro,0)+ IFNULL(potongan,0)+ IFNULL(pph,0)+ IFNULL(ppn,0))'
//              + ' FROM  pembayaran'
//              + ' WHERE MONTH(tanggal)='+IntToStr(cbbBulan.itemindex+1)+' AND YEAR(tanggal)= '+edttahun.text+' AND customer=a.cus_kode and salesman ='+Quot(edtKode.Text)+') inkaso,0 STATUS'
//              + ' from  tcustomer a'
//              + ' where cus_kode not in (select distinct customer from  penjualan'
//              + ' WHERE tanggal < '+quotd(awal)+' ) ) A WHERE IFNULL(INKASO ,0) > 0';

        tsql2 :=xOpenQuery(s,frmMenu.conn);
        with tsql2 do
        begin
          try
            while not Eof do
            begin

             if cds.Locate('kode_salesman',FieldByName('salesman').AsString+FieldByName('customer').AsString,[loCaseInsensitive]) then
             begin
               If cds.State <> dsEdit then CDS.Edit;
                cds.FieldByName('realisasiinkaso').AsFloat := FieldByName('inkaso').AsFloat;
                cds.FieldByName('targetinkaso').AsFloat := FieldByName('piutang').AsFloat;
                if FieldByName('piutang').AsFloat > 0 then
                cds.FieldByName('ratioinkaso').AsFloat := FieldByName('inkaso').AsFloat/FieldByName('piutang').AsFloat*100;
                cds.Post;
             end ;
              Next;
            end;
          finally
            free;
          end;
        end;


end;


procedure TfrmBrowseEstimasiSales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmBrowseEstimasiSales.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmBrowseEstimasiSales.FormShow(Sender: TObject);
begin
bacafile;

refreshdata;
end;

function TfrmBrowseEstimasiSales.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'kode_Salesman', ftString, False,100);
    zAddField(FCDS, 'Salesman', ftString, False,100);
    zAddField(FCDS, 'Marketing', ftString, False,100);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'PF', ftFloat, False);    
    zAddField(FCDS, 'TargetSales', ftFloat, False);
    zAddField(FCDS, 'EstimasiSales', ftFloat, False);
    zAddField(FCDS, 'realisasiSales', ftFloat, False);
    zAddField(FCDS, 'RatioSales', ftFloat, False);
    zAddField(FCDS, 'TargetInkaso', ftFloat, False);
    zAddField(FCDS, 'EstimasiInkaso', ftFloat, False);
    zAddField(FCDS, 'realisasiInkaso', ftFloat, False);
    zAddField(FCDS, 'RatioInkaso', ftFloat, False);
    zAddField(FCDS, 'ksalesman', ftFloat, False);
    zAddField(FCDS, 'kmarketing', ftFloat, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmBrowseEstimasiSales.clCustomerPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    i:integer;
begin
     sqlbantuan := ' SELECT cus_kode Kode,cus_nama Nama,gc_nama Golongan,cus_piutang Piutang from tcustomer '
                  + ' inner join tgolongancustomer on cus_gc_kode=gc_kode';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
   for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin

      If (VarToStr(cxGrdMain.DataController.Values[i, clCustomer.Index]) = VarToStr(varglobal)) and (cxGrdMain.DataController.FocusedRecordIndex <> i)
       then
      begin
          ShowMessage('Customer ada yang sama dengan baris '+ IntToStr(i+1));
          CDS.Cancel;
          exit;
      end;
    end;
   If CDS.State <> dsEdit then
         CDS.Edit;

      CDS.FieldByName('kode').AsString := varglobal;
      CDS.FieldByName('nama').AsString := varglobal1;

  end;

end;

procedure TfrmBrowseEstimasiSales.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmBrowseEstimasiSales.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

function TfrmBrowseEstimasiSales.gettarget(akode:string): double;
var
  s: string ;
  tsql : TMyQuery;
begin
  Result := 0;
  s := 'select st_targetsales from tsalesmantarget where st_sls_kode = ' + Quot(akode)
    + ' and st_periode = '+ IntToStr(cbbBulan.ItemIndex+1)
    + ' and st_tahun = ' + edtTahun.Text;

  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
     Result := Fields[0].AsFloat;
  end;
end;


function TfrmBrowseEstimasiSales.cekdata(atahun:string;abulan:string;akode:string):Boolean;
var
  i:integer;
  s:string;
  tsql:TMyQuery;
begin
  result:=true;
        s:= ' select * from testimasisales_hdr where esh_sls_kode='+ Quot(akode)
          + ' and esh_tahun ='+ atahun
          + ' and esh_periode='+ abulan
          + ' and esh_lock = 1 ';
   tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
              if not eof then
              begin
                ShowMessage('sudah di Lock, tidak bisa edit');
                result:=false;
                Exit;
              end;


    finally
      free;
    end;
  end;


end;


procedure TfrmBrowseEstimasiSales.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('targetsales')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Realisasisales'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Targetsales'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmBrowseEstimasiSales.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: String);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('targetinkaso')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Realisasiinkaso'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Targetinkaso'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

procedure TfrmBrowseEstimasiSales.btnRefreshClick(Sender: TObject);
begin

loaddata;
end;

procedure TfrmBrowseEstimasiSales.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,false,True,True);

  cxGrdMain.DataController.CollapseDetails;
end;

procedure TfrmBrowseEstimasiSales.cxButton1Click(Sender: TObject);
var
  s:string;
begin
  MyConnection1.Database := aDatabase2;
  MyConnection1.Username := auser2;
  MyConnection1.Password := apassword2;
  MyConnection1.Server := aHost2;
  MyConnection1.Connected := True;
  s:='SELECT count(DISTINCT DATE_FORMAT(tanggal,"%d/%m/%y")) jml,cus_kode,user,sls_kode ,'
    + ' (SELECT COUNT(DISTINCT DATE_FORMAT(tanggal,"%d/%m/%y")) FROM bsm.tkunjungan INNER JOIN bsm.tkaryawan ON kar_nama=USER AND kar_jabatan="MARKETING" '
    + ' WHERE cus_kode=a.cus_kode AND YEAR(tanggal) ='+edtTahun.Text+' AND MONTH(tanggal)='+IntToStr(cbbBulan.ItemIndex+1)+') mkt '
    + ' FROM bsm.tkunjungan a'
    + ' inner join '+ frmmenu.aDatabase + '.tsalesman on sls_nama=user '
    + ' where  year(tanggal) ='+ edtTahun.Text
    + ' and month(tanggal)='+ IntToStr(cbbBulan.ItemIndex+1)
    + ' GROUP BY USER,cus_kode';
  MyQuery1.Close;
  MyQuery1.SQL.Add(s);
  MyQuery1.Open;
  while not MyQuery1.Eof do
  begin
    if cds.Locate('kode_salesman',MyQuery1.FieldByName('sls_kode').AsString+MyQuery1.FieldByName('cus_kode').AsString,[loCaseInsensitive]) then
    begin
       If cds.State <> dsEdit then CDS.Edit;
          cds.FieldByName('ksalesman').AsFloat := MyQuery1.Fields[0].AsFloat;
          cds.FieldByName('kmarketing').AsFloat := MyQuery1.Fields[4].AsFloat;

    end;
    MyQuery1.Next;
  end;

end;

procedure TfrmBrowseEstimasiSales.bacafile;
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
