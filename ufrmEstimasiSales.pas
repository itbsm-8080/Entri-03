unit ufrmEstimasiSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, Grids, BaseGrid, AdvGrid, AdvCGrid,
  DBClient, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxSpinEdit, cxButtonEdit, cxTextEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, AdvEdBtn, AdvCombo, cxCurrencyEdit,
  DateUtils, MyAccess;

type
  TfrmEstimasiSales = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    clNamaCustomer: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    edtKode: TAdvEditBtn;
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
    Label5: TLabel;
    edtTarget: TAdvEdit;
    btnRefresh: TcxButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure refreshdata;
    procedure initgrid;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtKodeClickBtn(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure clCustomerPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    function gettarget(akode:string): double;
    function cekdata(atahun:string;abulan:string;akode:string):Boolean;
    function cekada(atahun:string;abulan:string;akode:string):Boolean;
    procedure cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant;
      AIsFooter: Boolean; var AText: String);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxButton7Click(Sender: TObject);

  private
    FFLAGEDIT: Boolean;
    FID: string;


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
  frmEstimasiSales: TfrmEstimasiSales;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,cxGridExportLink;

{$R *.dfm}

procedure TfrmEstimasiSales.FormCreate(Sender: TObject);
begin
     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
end;

procedure TfrmEstimasiSales.refreshdata;
begin
  FID:='';
  edtKode.Clear;
  edtNama.Clear;
  edtTahun.Text := FormatDateTime('yyyy',Date);
  initgrid;
end;
procedure TfrmEstimasiSales.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;
end;

procedure TfrmEstimasiSales.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F8 then
  begin
      Release;
  end;


  if Key= VK_F10 then
  begin
    try
      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;
      
      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
  end;
end;

procedure TfrmEstimasiSales.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmEstimasiSales.loaddata(akode:string) ;
var
  ssql,s: string;
  tsql2,tsql : TMyQuery;
  i:Integer;
  akhir,awal : TDateTime;
begin
    akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text));
    awal  :=StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text);

  if cekada(edtTahun.Text,IntToStr(cbbBulan.ItemIndex+1),akode) then
  s:= ' select cus_kode,cus_nama,esd_targetsales targetsales,esd_estimasisales estimasisales,esd_realisasisales realisasisales,CAST(0 AS DECIMAL) ratiosales ,'
    + ' esd_targetinkaso targetinkaso,esd_estimasiinkaso estimasiinkaso,esd_realisasiinkaso realisasiinkaso,CAST(0 AS DECIMAL) ratioinkaso from testimasisales_hdr '
    + ' inner join testimasisales_dtl on esd_esh_id=esh_id '
    + ' inner join tcustomer on cus_kode=esd_cus_kode '
    + ' where esh_sls_kode='+Quot(edtKode.Text)
    + ' and esh_periode = ' + IntToStr(cbbBulan.ItemIndex+1)
    + ' and esh_tahun = ' + edtTahun.Text
  else
  s:= 'select distinct cus_kode,cus_nama, '
    + ' CAST(0 AS DECIMAL) targetsales,CAST(0 AS DECIMAL) estimasisales,'
    + ' CAST(0 AS DECIMAL) realisasisales , CAST(0 AS DECIMAL) ratiosales ,'
    + ' CAST(0 AS DECIMAL) targetinkaso,CAST(0 AS DECIMAL) estimasiinkaso,'
    + ' CAST(0 AS DECIMAL) realisasiinkaso , CAST(0 AS DECIMAL) ratioinkaso '
    + ' from '
    + ' tso_hdr inner join tcustomer on cus_kode=so_cus_kode '
    + ' where so_sls_kode = ' + Quot(akode) ;
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
      CDS.FieldByName('kode').AsString := fieldbyname('cus_kode').AsString;
      CDS.FieldByName('nama').AsString  := fieldbyname('cus_nama').AsString;
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

           ssql:= 'SELECT customer,SUM(total-biaya_promosi-kontrak-retur) realisasisales '
                  + ' FROM penjualan'
                  + ' WHERE MONTH(tanggal)='+inttostr(cbbBulan.ItemIndex+1)+' AND YEAR(tanggal)='+edttahun.text+' AND salesman='+quot(edtkode.Text)
                  + ' group by customer ';

        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin

             if cds.Locate('kode',FieldByName('customer').AsString,[loCaseInsensitive]) then
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

            s:=' SELECT  cus_kode customer, IF(piutang<0,0,PIUTANG) piutang, ifnull(inkaso,0)+ifnull(tunai2,0) inkaso'
              + ' FROM ('
              + ' SELECT customer, SUM(IF (('
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
              + ' AND salesman = ' + Quot(edtKode.Text)
              + ' AND tanggal < '+quotd(awal)+'),0) - IFNULL(('
              + ' SELECT SUM(retur)'
              + ' FROM  retur'
              + ' WHERE customer=a.customer'
              + ' AND salesman = ' + Quot(edtKode.Text)
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
              + ' AND a.salesman = ' + Quot(edtKode.Text)
              + ' GROUP BY customer'
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

             if cds.Locate('kode',FieldByName('customer').AsString,[loCaseInsensitive]) then
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


procedure TfrmEstimasiSales.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  fid : integer;
begin

  fid := getmaxid('testimasisales_hdr','esh_id');

   s:= ' delete from testimasisales_hdr'
      + ' where  esh_periode =' + inttostr(cbbBulan.ItemIndex+1)
      + ' and esh_tahun = ' + edtTahun.Text
      + ' and esh_sls_kode = ' + Quot(edtKode.Text)
      + ' and esh_lock=0 ';
       // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
       // xCommit(frmMenu.conn);

   tt := TStringList.Create;
   s:='insert into testimasisales_hdr (esh_id,esh_sls_kode,esh_periode,esh_tahun)'
    + ' values ('
    + IntToStr(fid)  + ','
    + Quot(edtKode.Text) + ','
    + IntToStr(cbbBulan.ItemIndex+1) + ','
    + edtTahun.Text + ');';
   tt.Append(s);
    CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if not CDS.FieldByName('kode').IsNull then
   begin
    S:='insert into testimasisales_dtl '
      + '(esd_esh_id,esd_cus_kode,esd_targetsales,esd_estimasisales,esd_realisasisales,'
      + ' esd_targetinkaso,esd_estimasiinkaso,esd_realisasiinkaso'
      + ') values ('
      + IntToStr(fid) +','
      + quot(CDS.FieldByName('kode').Asstring) + ','
      + FloatToStr(CDS.FieldByName('targetsales').AsFloat) + ','
      + FloatToStr(CDS.FieldByName('estimasisales').AsFloat) + ','
      + FloatToStr(CDS.FieldByName('realisasisales').AsFloat) + ','
      + FloatToStr(CDS.FieldByName('targetinkaso').AsFloat) + ','
      + FloatToStr(CDS.FieldByName('estimasiinkaso').AsFloat) + ','
      + FloatToStr(CDS.FieldByName('realisasiinkaso').AsFloat)
      + ');';
    tt.Append(s);
   end;
    CDS.Next;
    Inc(i);
  end;

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
end;


procedure TfrmEstimasiSales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

procedure TfrmEstimasiSales.cxButton1Click(Sender: TObject);
begin
    try
      If not cekdata(edtTahun.Text,IntToStr(cbbBulan.ItemIndex+1),edtKode.Text) then exit;
      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;

procedure TfrmEstimasiSales.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmEstimasiSales.cxButton2Click(Sender: TObject);
begin
   try
      If not cekdata(edtTahun.Text,IntToStr(cbbBulan.ItemIndex+1),edtKode.Text) then exit;
      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
    Release;
end;
procedure TfrmEstimasiSales.edtKodeClickBtn(Sender: TObject);
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
  edtTarget.Text := formatfloat('###,###,###,###',gettarget(edtkode.Text));
  end;

end;

procedure TfrmEstimasiSales.FormShow(Sender: TObject);
begin
refreshdata;
end;

function TfrmEstimasiSales.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftstring, False,100);
    zAddField(FCDS, 'TargetSales', ftFloat, False);
    zAddField(FCDS, 'EstimasiSales', ftFloat, False);
    zAddField(FCDS, 'realisasiSales', ftFloat, False);
    zAddField(FCDS, 'RatioSales', ftFloat, False);
    zAddField(FCDS, 'TargetInkaso', ftFloat, False);
    zAddField(FCDS, 'EstimasiInkaso', ftFloat, False);
    zAddField(FCDS, 'realisasiInkaso', ftFloat, False);
    zAddField(FCDS, 'RatioInkaso', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

procedure TfrmEstimasiSales.clCustomerPropertiesButtonClick(
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

procedure TfrmEstimasiSales.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmEstimasiSales.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;

function TfrmEstimasiSales.gettarget(akode:string): double;
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


function TfrmEstimasiSales.cekdata(atahun:string;abulan:string;akode:string):Boolean;
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

     If edtKode.Text = '' then
    begin
      ShowMessage('Salesman belum di pilih');
      result:=false;
      Exit;
    end;
end;


function TfrmEstimasiSales.cekada(atahun:string;abulan:string;akode:string):Boolean;
var
  i:integer;
  s:string;
  tsql:TMyQuery;
begin
  result:=false;
        s:= ' select * from testimasisales_hdr where esh_sls_kode='+ Quot(akode)
          + ' and esh_tahun ='+ atahun
          + ' and esh_periode='+ abulan;

   tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
        if not eof then
        begin
          result:=true;
          Exit;
        end;
    finally
      free;
    end;
  end;


end;

procedure TfrmEstimasiSales.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems6GetText(
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

procedure TfrmEstimasiSales.cxGrdMainTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems7GetText(
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

procedure TfrmEstimasiSales.btnRefreshClick(Sender: TObject);
begin
  if edtkode.text <> '' then
loaddata(edtKode.Text);
end;

procedure TfrmEstimasiSales.cxButton7Click(Sender: TObject);
begin
  if SaveDlg.Execute then
    ExportGridToExcel(SaveDlg.FileName, cxGrid,True,True,True);

  cxGrdMain.DataController.CollapseDetails;

end;

end.
