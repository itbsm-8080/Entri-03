unit ufrmKomisiMarketing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, cxCurrencyEdit, MyAccess;

type
  TfrmKomisiMarketing = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    edtKode: TAdvEditBtn;
    Label1: TLabel;
    startdate: TDateTimePicker;
    Label4: TLabel;
    enddate: TDateTimePicker;
    cxButton7: TcxButton;
    SaveDialog1: TSaveDialog;
    AdvPanel5: TAdvPanel;
    Label5: TLabel;
    edtPersentase: TAdvEdit;
    Label6: TLabel;
    edtPengali: TAdvEdit;
    Label7: TLabel;
    edtKomisiValue: TAdvEdit;
    Label8: TLabel;
    edtValue: TAdvEdit;
    Label9: TLabel;
    edtQty: TAdvEdit;
    Label10: TLabel;
    edtTotalKomisi: TAdvEdit;
    cxButton3: TcxButton;
    PopupMenu1: TPopupMenu;
    LihatDetail1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    clTarget: TcxGridDBColumn;
    clRealisasi: TcxGridDBColumn;
    clcapai: TcxGridDBColumn;
    clHet: TcxGridDBColumn;
    clPenjualan: TcxGridDBColumn;
    clPresentase: TcxGridDBColumn;
    clPengali: TcxGridDBColumn;
    clInsentif: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrdMain2: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    Pencapaian1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton8Click(Sender: TObject);
    function GetCDS: TClientDataSet;
    function GetCDS2: TClientDataSet;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxButton1Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);
    procedure
        cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
        Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
        AText: string);
        function getkomisijual(apersen:double) : double;
    procedure cxButton3Click(Sender: TObject);
    procedure LihatDetail1Click(Sender: TObject);
    procedure Pencapaian1Click(Sender: TObject);

  private
    FFLAGEDIT: Boolean;
    FID: string;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
    FCDS2: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDS2: TClientDataSet read GetCDS2 write FCDS2;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmKomisiMarketing: TfrmKomisiMarketing;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxgridExportlink,uReport;

{$R *.dfm}

procedure TfrmKomisiMarketing.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     TcxDBGridHelper(cxGrdMain2).LoadFromCDS(CDS2, False, False);
end;

procedure TfrmKomisiMarketing.refreshdata;
begin
  FID:='';
  edtKode.Clear;
  edtNama.Clear;
  startdate.DateTime :=Date;
  enddate.DateTime := Date;
  initgrid;
end;
procedure TfrmKomisiMarketing.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;

procedure TfrmKomisiMarketing.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


end;

procedure TfrmKomisiMarketing.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmKomisiMarketing.loaddata;
var
  s,ss: string;
  tsql,tsql2 : TMyQuery;
  i:Integer;
begin
  s:= 'SELECT pmh_nama Nama,qty Realisasi, Target, QTY/TARGET*100 capai,Het_Bawah HET,HNA,hna * qty Penjualan_hna,target*HNA Target_value, '
    + ' (hna*qty) / (target*HNA) * 100 Presentase,'
    + ' penjualan_riil,pengali,'
    + ' if((hna*qty) / (target*HNA) * 100 >= 100 ,(select pmh_insentif from tprodukmarketing_hdr where pmh_nomor=a.pmh_nomor),0) insentif '
    + ' FROM ('
    + ' SELECT pmh_nomor,pmh_nama,pmh_insentif, SUM(fpd_qty) qty,'
    + ' pmh_het_bawah Het_Bawah,'
    + ' PMH_HNA HNA,'
    + ' (select pmd2_target from tprodukmarketing_dtl2 where pmd2_pmh_nomor=pmh_nomor and pmd2_salesman='+Quot(edtKode.Text)+') target,'
    + ' sum(((100-fpd_discpr)*fpd_harga/100)*fpd_qty) Penjualan_Riil,'
    + ' sum(if((100-fpd_discpr)*fpd_harga/100 >= pmh_het_bawah , ((100-fpd_discpr)*fpd_harga/100)*fpd_qty,0)) Pengali'
    + ' FROM tfp_dtl'
    + ' INNER JOIN tfp_hdr ON fp_nomor=fpd_fp_nomor'
    + ' INNER JOIN tdo_hdr ON do_nomor =fp_do_nomor'
    + ' INNER JOIN tso_hdr ON so_nomor=do_so_nomor'
    + ' INNER JOIN tsalesman on sls_kode=so_sls_kode'
    + ' INNER JOIN tprodukmarketing_dtl ON fpd_brg_kode=pmd_brg_kode'
    + ' INNER JOIN tprodukmarketing_hdr ON pmh_nomor=pmd_pmh_nomor'
    + ' INNER JOIN tsalescustomer ON sc_cus_kode=fp_cus_kode'
    + ' WHERE fp_tanggal between '+QuotD(startdate.DateTime)+' and '+QuotD(enddate.DateTime)
    + ' and sls_nama <> "KANTOR"'
    + ' and sc_sls_kode='+Quot(edtKode.Text)
    + ' GROUP BY pmh_nama) a order by pmh_nama' ;


  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try

    CDS.EmptyDataSet;
    while  not Eof do
    begin
      CDS.Append;
      CDS.FieldByName('nama').AsString  := fieldbyname('nama').AsString;
      CDS.FieldByName('target').Asfloat  := fieldbyname('target').AsFloat;
      CDS.FieldByName('realisasi').AsFloat  := fieldbyname('realisasi').AsFloat;
      CDS.FieldByName('capai').AsFloat  := fieldbyname('capai').AsFloat;
      CDS.FieldByName('penjualan_hna').AsFloat  := fieldbyname('penjualan_hna').AsFloat;
      CDS.FieldByName('target_value').AsFloat  := fieldbyname('target_value').AsFloat;
      CDS.FieldByName('presentase').AsFloat  := fieldbyname('Presentase').AsFloat;
      CDS.FieldByName('pengali').AsFloat := fieldbyname('pengali').AsFloat;
      CDS.FieldByName('insentif').AsFloat := fieldbyname('insentif').AsFloat;
      CDS.Post;
      i:=i+1;
      next;
    end;

   finally
    Free;
   end;

  end;

  // list detail---------------------------------------
  ss:='select cus_nama customer,pmh_nama Nama,fp_nomor Nomor,fp_tanggal Tanggal,fpd_qty QTY,(100-fpd_discpr)/100*fpd_harga *(100-fpd_cn)/100 NetJual from tfp_dtl'
+ ' inner join tfp_hdr on fp_nomor =fpd_fp_nomor'
+ ' inner join tsalescustomer on fp_cus_kode=SC_cus_kode'
+ ' inner join tcustomer on sc_cus_kode=cus_kode'
+ ' inner join tbarang on brg_kode=fpd_brg_kode'
+ ' INNER JOIN tprodukmarketing_dtl ON fpd_brg_kode=pmd_brg_kode'
+ ' INNER JOIN tprodukmarketing_hdr ON pmh_nomor=pmd_pmh_nomor'
+ ' where sc_sls_kode='+Quot(edtKode.Text)
+ ' and fp_tanggal between '+QuotD(startdate.DateTime)+' and '+QuotD(enddate.DateTime)
+ ' order by pmh_nama ';
  tsql2 := xOpenQuery(ss,frmMenu.conn);
  with tsql2 do
  begin
   try

    CDS2.EmptyDataSet;
    while  not Eof do
    begin
      CDS2.Append;
      CDS2.FieldByName('customer').AsString  := fieldbyname('customer').AsString;
      CDS2.FieldByName('nama').AsString  := fieldbyname('nama').AsString;
      CDS2.FieldByName('nomor').AsString  := fieldbyname('nomor').AsString;
      CDS2.FieldByName('tanggal').AsDateTime := fieldbyname('tanggal').AsDateTime;
      CDS2.FieldByName('qty').AsFloat := fieldbyname('qty').AsFloat;
      CDS2.FieldByName('net').AsFloat := fieldbyname('netjual').AsFloat;
      CDS2.Post;
      i:=i+1;
      next;
    end;

   finally
    Free;
   end;

  end;


  //--------------------------------------------

  s:='select pmh_nomor,pmh_nama,pmh_insentif,0,pmh_het_bawah,pmh_hna,'
  + ' (select pmd2_target from tprodukmarketing_dtl2 where pmd2_pmh_nomor=pmh_nomor and pmd2_salesman='+quot(edtkode.text)+') target,'
  + ' cast(0 as decimal) as  Riil,cast(0 as decimal) Pengali'
  + ' from tprodukmarketing_hdr ';
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     while not Eof do
     begin

       if not CDS.Locate('Nama',FieldByName('pmh_nama').AsString,[loCaseInsensitive]) then
       begin
          If CDS.State <> dsEdit then CDS.Edit;
          CDS.Append;
          CDS.FieldByName('nama').AsString  := fieldbyname('pmh_nama').AsString;
          CDS.FieldByName('target').Asfloat  := fieldbyname('target').AsFloat;
          CDS.FieldByName('realisasi').AsFloat  := 0;
          CDS.FieldByName('capai').AsFloat  := 0;
          CDS.FieldByName('penjualan_hna').AsFloat  := 0;
          CDS.FieldByName('target_value').AsFloat  := fieldbyname('pmh_hna').AsFloat*fieldbyname('target').AsFloat;
          CDS.FieldByName('presentase').AsFloat  := 0;
          CDS.FieldByName('pengali').AsFloat := 0;
          CDS.FieldByName('insentif').AsFloat := 0;

       end;
       next;
     end;
   finally
    Free;
   end;

  end;
end;


procedure TfrmKomisiMarketing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmKomisiMarketing.cxButton8Click(Sender: TObject);
begin
Release;
end;

function TfrmKomisiMarketing.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Nama', ftString, False,200);
    zAddField(FCDS, 'Target', ftFloat, False);
    zAddField(FCDS, 'Realisasi', ftFloat, False);
    zAddField(FCDS, 'Capai', ftFloat, False);
    zAddField(FCDS, 'penjualan_hna', ftFloat, False);
    zAddField(FCDS, 'Target_Value', ftFloat, False);
    zAddField(FCDS, 'Presentase', ftFloat, False);
    zAddField(FCDS, 'Pengali', ftFloat, False);
    zAddField(FCDS, 'insentif', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;
function TfrmKomisiMarketing.GetCDS2: TClientDataSet;
begin
  If not Assigned(FCDS2) then
  begin
    FCDS2 := TClientDataSet.Create(Self);
    zAddField(FCDS2, 'No', ftInteger, False);
    zAddField(FCDS2, 'customer', ftString, False,200);
    zAddField(FCDS2, 'nama', ftString, False,200);
    zAddField(FCDS2, 'Nomor', ftString, False,100);
    zAddField(FCDS2, 'Tanggal', ftDate, False,100);
    zAddField(FCDS2, 'Qty', ftFloat, False);
    zAddField(FCDS2, 'Net', ftFloat, False);
    FCDS2.CreateDataSet;
  end;
  Result := FCDS2;
end;


procedure TfrmKomisiMarketing.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmKomisiMarketing.cxButton1Click(Sender: TObject);
var
  apersen : double;
  akomisivalue : Double;
begin
loaddata;
apersen := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
edtPengali.Text :=  TcxDBGridHelper(cxGrdMain).GetFooterSummary('pengali');
edtPersentase.Text := FloatToStr(getkomisijual(apersen));
akomisivalue := cvartofloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('pengali'))*getkomisijual(apersen)/100;
edtKomisiValue.Text :=FloatToStr(akomisivalue);
edtQty.Text := TcxDBGridHelper(cxGrdMain).GetFooterSummary('insentif');
edtValue.Text :=FloatToStr(akomisivalue);
edtTotalKomisi.Text := FloatToStr(akomisivalue+ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('insentif')));

end;

procedure TfrmKomisiMarketing.edtKodeClickBtn(Sender: TObject);
begin
    sqlbantuan := ' SELECT sls_kode Kode,sls_nama Nama from tsalesman ';
  sqlfilter := 'Kode,Nama';
  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
  edtKode.Text := varglobal;
  edtNama.Text := varglobal1;
  end;

end;

procedure TfrmKomisiMarketing.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmKomisiMarketing.cxButton7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid);
     end;

end;

procedure
    TfrmKomisiMarketing.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
    Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var
    AText: string);
  var
    capaibulanini :double;
begin
  capaibulanini := 0;
  try
    if cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna')) > 0  then
       capaibulanini :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
    AText := FormatFloat('###.##',capaibulanini);
  except
  end;
end;

function TfrmKomisiMarketing.getkomisijual(apersen:double) : double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select ksj_komisi from tkomisimarketing_jual where ksj_bawah <= '+ FloatToStr(apersen)
  + ' and ksj_atas >= '+ floattostr(apersen);
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsFloat;
    finally
      free;
    end;
  end;

end;



procedure TfrmKomisiMarketing.cxButton3Click(Sender: TObject);
var
  s : string;
  tt:TStrings;
  i:Integer;
  ftsreport : TTSReport;
  apersen : Double;
begin
  apersen := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna'))/ cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value'))*100;
    ftsreport := TTSReport.Create(nil);
    tt := TStringList.Create;
   s:= ' delete from tcetakkomisi2 '
      + ' where  ck_periode =' + FormatDateTime('mm',startdate.DateTime)
      + ' and ck_tahun='+ FormatDateTime('yyyy',startdate.DateTime)
      + ' and ck_kode = ' + Quot(edtKode.Text);
   tt.Append(s);

    s:= ' INSERT INTO tcetakkomisi2 (ck_kode,ck_salesman, ck_PERIODE, ck_tahun, '
      + ' ck_targetjual, ck_realisasijual, ck_persentasejual, ck_komisijual, '
      + ' ck_komisiqty,ck_pengali,ck_persen)'
      + ' VALUES ('
      + Quot(edtkode.text)+ ','
      + Quot(edtNama.text)+ ','
      + FormatDateTime('mm',startdate.DateTime)+ ','
      + FormatDateTime('yyyy',startdate.DateTime) + ','
      + FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('target_value')))+ ','
      + FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('penjualan_hna')))+ ','
      + floattostr(apersen) + ','
      + StringReplace(edtValue.Text,',','',[rfReplaceAll]) +','
      + StringReplace(edtQty.Text,',','',[rfReplaceAll]) + ','
      + StringReplace(edtPengali.Text,',','',[rfReplaceAll]) + ','
      + StringReplace(edtPersentase.Text,',','',[rfReplaceAll])
      + ');';
      tt.Append(s);

       try
        for i:=0 to tt.Count -1 do
        begin
            // xExecQuery(tt[i],frmMenu.conn);
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;
      // xCommit(frmMenu.conn);
   try
    ftsreport.Nama := 'cetakkomisi2';

       s:= ' select '
       + ' * '
       + ' from tcetakkomisi2 '
       + ' where '
       + ' ck_periode=' + FormatDateTime('mm',startdate.DateTime)
       + ' and ck_tahun = ' + FormatDateTime('yyyy',startdate.DateTime)
       + ' and ck_kode = ' + quot(edtkode.text);


    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmKomisiMarketing.LihatDetail1Click(Sender: TObject);
var
  s:string;
begin
PageControl1.TabIndex:=1;
end;

procedure TfrmKomisiMarketing.Pencapaian1Click(Sender: TObject);
begin
PageControl1.TabIndex:=0;
end;

end.
