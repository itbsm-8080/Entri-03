unit ufrmSetingBiayaPromosi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, DBClient, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSpinEdit, cxCurrencyEdit, AdvEdBtn,DateUtils,
  cxCalendar, cxCheckBox, Buttons, cxButtonEdit, MyAccess;

type
  TfrmSetingBiayaPromosi = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupCustomer: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    te: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clKode: TcxGridDBColumn;
    clNama: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    clRupiah: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clpersen: TcxGridDBColumn;
    edtPersen: TAdvEdit;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure HapusRecord1Click(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;

    procedure loaddataall(akode : string);
    procedure cxLookupcustomerPropertiesEditValueChanged(Sender: TObject);
    procedure clStatusPropertiesEditValueChanged(Sender: TObject);
    procedure clBayarPropertiesEditValueChanged(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure clKodePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure bantuansku;
    procedure BitBtn2Click(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSRekeningCash: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;

    function GetCDScustomer: TClientDataset;
    function GetCDSRekeningCash: TClientDataset;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;
    property CDSRekeningCash: TClientDataset read GetCDSRekeningCash write
        FCDSRekeningCash;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;

    { Public declarations }
  end;

var
  frmSetingBiayaPromosi: TfrmSetingBiayaPromosi;
const
   NOMERATOR = 'CB';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmfp;

{$R *.dfm}

procedure TfrmSetingBiayaPromosi.refreshdata;
begin
  FID:='';

  FLAGEDIT := False;

  edtnomor.Text := getmaxkode;
  cxLookupcustomer.EditValue := '';
  edtAlamat.Clear;

  cxLookupcustomer.SetFocus;
  initgrid;

end;
procedure TfrmSetingBiayaPromosi.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;
procedure TfrmSetingBiayaPromosi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmSetingBiayaPromosi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmSetingBiayaPromosi.getmaxkode:string;
var
  s:string;
begin
 s:='select max(cast(bph_nomor AS DECIMAL)) from tbiayapromosi_hdr ' ;
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= RightStr(IntToStr(1000+1),3)
      else
         result:= RightStr(IntToStr(1000+fields[0].AsInteger+1),3);

    finally
      free;
    end;
  end;
end;

procedure TfrmSetingBiayaPromosi.cxButton1Click(Sender: TObject);
begin
    try

      If not cekdata then exit;

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

procedure TfrmSetingBiayaPromosi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSetingBiayaPromosi.cxButton2Click(Sender: TObject);
begin
   try

     If not cekdata then exit;

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

procedure TfrmSetingBiayaPromosi.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmSetingBiayaPromosi.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftString, False,20);
    zAddField(FCDS, 'Nama', ftString, False,100);
    zAddField(FCDS, 'Persen', ftFloat, False);
    zAddField(FCDS, 'Rupiah', ftFloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmSetingBiayaPromosi.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_telp'
        +' from tcustomer order by cus_nama ';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;

procedure TfrmSetingBiayaPromosi.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmSetingBiayaPromosi.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSetingBiayaPromosi.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;


procedure TfrmSetingBiayaPromosi.simpandata;
var
  s:string;
  atax,i:integer;
  tt:TStrings;

begin

if FLAGEDIT then
  s:='update tbiayapromosi_HDR set '
    + ' bph_cus_kode = ' + Quot(cxLookupcustomer.EditValue)
    + ' where bph_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into tbiayapromosi_HDR '
             + ' (bph_nomor,bph_cus_kode'
             + ' ) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quot(cxLookupcustomer.EditValue)+');';

end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from tbiayapromosi_DTL '
      + ' where  bpd_bph_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
    S:='insert into tbiayapromosi_DTL (bpd_bph_nomor,bpd_brg_kode,bpd_persen,bpd_rupiah) values ('
      + Quot(edtNomor.Text) +','
      + quot(CDS.FieldByName('kode').AsString) +','
     + FloatToStr(CDS.FieldByName('persen').AsFloat)+','
      + FloatToStr(CDS.FieldByName('rupiah').AsFloat)
      + ');';
    tt.Append(s);
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


function TfrmSetingBiayaPromosi.cekdata:Boolean;
var
  i:integer;
  abayar,atotal : double;
begin
  result:=true;
   i := 1;
     If cxLookupcustomer.EditValue = '' then
    begin
      ShowMessage('customer belum di pilih');
      result:=false;
      Exit;

    end;


end;



procedure TfrmSetingBiayaPromosi.loaddataall(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtyterima : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' SELECT bph_nomor,bph_cus_kode,cus_nama,cus_alamat, '
+ ' bpd_brg_kode kode,brg_nama nama,bpd_persen persen,bpd_rupiah rupiah '
+ ' FROM tbiayapromosi_hdr '
+ ' INNER JOIN tbiayapromosi_dtl a ON bph_nomor=bpd_bph_nomor '
+ ' inner join tcustomer on cus_kode=bph_cus_kode '
+ ' inner join tbarang on brg_kode=bpd_brg_kode '
+ ' WHERE bph_nomor = '+ Quot(akode);


    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('bph_nomor').AsString;
            edtnomor.Text := fieldbyname('bph_nomor').AsString;
            cxLookupcustomer.EditValue  := fieldbyname('bph_cus_kode').AsString;
            edtAlamat.Text := fieldbyname('cus_alamat').AsString;
            i:=1;
            CDS.EmptyDataSet;
            while  not Eof do
            begin
                   CDS.Append;
                    If CDS.State <> dsEdit then CDS.Edit;
                    CDS.FieldByName('kode').AsString :=fieldbyname('kode').Asstring;
                    CDS.FieldByName('nama').AsString :=fieldbyname('nama').Asstring;
                    CDS.FieldByName('persen').AsFloat :=fieldbyname('persen').AsFloat;
                    CDS.FieldByName('rupiah').AsFloat :=FieldByName('rupiah').AsFloat;
                    CDS.Post;
                    Inc(i);
                    next;
            end ;
        end
        else
        begin
          ShowMessage('Nomor  tidak di temukan');
        end;
      end;
   finally
     tsql.Free;


   end;

end;

procedure TfrmSetingBiayaPromosi.cxLookupcustomerPropertiesEditValueChanged(
  Sender: TObject);
begin

  edtAlamat.Text := CDScustomer.Fields[2].AsString;
end;

function TfrmSetingBiayaPromosi.GetCDSRekeningCash: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningCash) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening';


    FCDSRekeningCash := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningCash;
end;

procedure TfrmSetingBiayaPromosi.clStatusPropertiesEditValueChanged(
  Sender: TObject);
begin
   CDS.Post;
   If CDS.State <> dsEdit then CDS.Edit;
  if CDS.FieldByName('pay').AsInteger = 1 then
     CDS.FieldByName('bayar').AsFloat :=CDS.FieldByName('biaya_promosi').AsFloat
  else
     CDS.FieldByName('bayar').AsFloat := 0;
  cds.post;

end;

procedure TfrmSetingBiayaPromosi.clBayarPropertiesEditValueChanged(
  Sender: TObject);
begin
 CDS.Post;

end;

procedure TfrmSetingBiayaPromosi.BitBtn1Click(Sender: TObject);
var
  awal,akhir :string;
  i:Integer;
begin
  CDS.First;
  i:=0 ;
  while not CDS.Eof do
  begin

          CDS.Edit;
          CDS.fieldbyname('persen').AsFloat  := StrToFloat(edtPersen.Text);

          CDS.Post;

     CDS.next;
     Inc(i);
   end;

end;

procedure TfrmSetingBiayaPromosi.clKodePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
 bantuansku;
end;

procedure TfrmSetingBiayaPromosi.bantuansku;
  var
    s:string;
    tsql2,tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select brg_kode Kode, brg_nama NamaBarang, brg_satuan Satuan from Tbarang ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
  begin
    If CDS.State <> dsEdit then
       CDS.Edit;
    CDS.FieldByName('kode').AsString := varglobal;
    CDS.FieldByName('Nama').AsString := varglobal1;

  end;
end;



procedure TfrmSetingBiayaPromosi.BitBtn2Click(Sender: TObject);
var
  s:string;
  tsql: TMyQuery;
begin
  s:=' SELECT distinct brg_kode kode,brg_nama nama,BRG_SATUAN '
    + ' FROM tbarang INNER JOIN tfp_dtl  ON '
    + ' fpd_Brg_kode =brg_kode  '
    + ' inner join tfp_hdr on fp_nomor=fpd_fp_nomor '
    + ' WHERE brg_satuan NOT IN ("UNT","UNIT","UNI","SET")'
    + ' and fp_cus_kode = ' + Quot(cxLookupCustomer.EditValue);
tsql := xOpenQuery(s,frmMenu.conn);

    with tsql do
    begin
            CDS.EmptyDataSet;
            while  not Eof do
            begin
                   CDS.Append;
                    If CDS.State <> dsEdit then CDS.Edit;
                    CDS.FieldByName('kode').AsString :=fieldbyname('kode').Asstring;
                    CDS.FieldByName('nama').AsString :=fieldbyname('nama').Asstring;
                    CDS.FieldByName('persen').AsFloat :=0;
                    CDS.FieldByName('rupiah').AsFloat :=0;
                    CDS.Post;

                    next;
            end ;
    end;
end;

end.
