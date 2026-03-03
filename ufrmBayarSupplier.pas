unit ufrmBayarSupplier;

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
  cxCalendar, cxCheckBox, frxClass, frxDMPExport, MyAccess;

type
  TfrmBayarSupplier = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupSupplier: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clInvoice: TcxGridDBColumn;
    clTglInvoice: TcxGridDBColumn;
    clTerbayar: TcxGridDBColumn;
    clJthTempo: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    clBayar: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    clNilai: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    cxLookupRekening: TcxExtLookupComboBox;
    Label4: TLabel;
    Label10: TLabel;
    edtmemo: TMemo;
    Label5: TLabel;
    dtTglCair: TDateTimePicker;
    Label7: TLabel;
    edtGiro: TAdvEdit;
    Label8: TLabel;
    edtNilai: TAdvEdit;
    clNobukti: TcxGridDBColumn;
    chkPajak: TCheckBox;
    clPajak: TcxGridDBColumn;
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
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure chkPajakClick(Sender: TObject);
    procedure loaddataInvoice(akode : string);
    procedure loaddataall(akode : string);
    procedure cxLookupSupplierPropertiesEditValueChanged(Sender: TObject);
    procedure clStatusPropertiesEditValueChanged(Sender: TObject);
    procedure clBayarPropertiesEditValueChanged(Sender: TObject);
    procedure hitung;
    procedure cxGrdMainDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure clBayarPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure doslip(anomor : string );
    procedure doslip2(anomor : string );
  private
    FCDSSupplier: TClientDataset;
    FCDSRekening: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    atanggalold:TDateTime;
    function GetCDSSupplier: TClientDataset;
    function GetCDSRekening: TClientDataset;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSupplier: TClientDataset read GetCDSSupplier write FCDSSupplier;
    property CDSRekening: TClientDataset read GetCDSRekening write FCDSRekening;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmBayarSupplier: TfrmBayarSupplier;
const
   NOMERATOR = 'VP';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,ureport,ufrmInvoice;

{$R *.dfm}

procedure TfrmBayarSupplier.refreshdata;
begin
  FID:='';
  
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  dtTglCair.datetime :=date;
  edtnomor.Text := getmaxkode;
  cxLookupsupplier.EditValue := '';
  cxLookupRekening.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  
  
  cxLookupSupplier.SetFocus;
  initgrid;

end;
procedure TfrmBayarSupplier.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('bayar').AsCurrency    := 0;
  CDS.Post;

end;
procedure TfrmBayarSupplier.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmBayarSupplier.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmBayarSupplier.getmaxkode:string;
var
  s:string;
begin
 s:='select max(right(bys_nomor,4)) from tbayarsup_hdr where bys_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
end;

procedure TfrmBayarSupplier.cxButton1Click(Sender: TObject);
begin
    try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
    
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

procedure TfrmBayarSupplier.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmBayarSupplier.cxButton2Click(Sender: TObject);
begin

   try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
   
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

procedure TfrmBayarSupplier.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupSupplier.Properties) do
    LoadFromCDS(CDSSupplier, 'Kode','supplier',['Kode'],Self);
     TcxExtLookupHelper(cxLookupSupplier.Properties).SetMultiPurposeLookup;

    with TcxExtLookupHelper(cxLookupRekening.Properties) do
    LoadFromCDS(CDSRekening, 'Kode','Rekening',['Kode'],Self);


     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmBayarSupplier.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Invoice', ftString, False,20);
    zAddField(FCDS, 'Nobukti', ftString, False,20);
    zAddField(FCDS, 'NoPajak', ftString, False,50);
    zAddField(FCDS, 'Tanggal', ftDate, False);
    zAddField(FCDS, 'JthTempo', ftDate, False, 10);
    zAddField(FCDS, 'Nilai', ftFloat, False);
    zAddField(FCDS, 'Terbayar', ftFloat, False);
    zAddField(FCDS, 'Bayar', ftFloat, False);
    zAddField(FCDS, 'pay', ftInteger, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmBayarSupplier.GetCDSSupplier: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSSupplier) then
  begin
    S := 'select sup_nama as supplier, sup_kode Kode, sup_alamat Alamat,sup_telp'
        +' from tsupplier order by sup_nama';


    FCDSSupplier := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSSupplier;
end;

procedure TfrmBayarSupplier.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmBayarSupplier.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmBayarSupplier.HapusRecord1Click(Sender: TObject);
begin
  If CDS.FieldByname('Invoice').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Invoice' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frminvoice  := frmmenu.ShowForm(Tfrminvoice) as Tfrminvoice;
      frminvoice.ID := CDS.FieldByname('Invoice').AsString;
      frminvoice.FLAGEDIT := True;
      frminvoice.edtnOMOR.Text := CDS.FieldByname('Invoice').AsString;
      frminvoice.loaddataall(CDS.FieldByname('Invoice').AsString);
//      if cekbayar(CDS.FieldByname('Invoice').AsString) = 1 then
//      begin
//        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
//        frminvoice.cxButton2.Enabled :=False;
//        frminvoice.cxButton1.Enabled :=False;
//        frminvoice.cxButton3.Enabled := False;
//      end;
   end;
   frminvoice.Show;

end;


procedure TfrmBayarSupplier.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
  anomorold := edtNomor.Text;
  anomornew := getmaxkode;
  if FLAGEDIT then
  begin
    if Copy(anomornew,1,9) <> Copy(anomorold,1,9)then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.Date :=atanggalold;
    end;
  end;

end;


procedure TfrmBayarSupplier.simpandata;
var
  s:string;
  atax,i:integer;
  tt:TStrings;

begin
  if chkPajak.Checked then
   atax :=1
  else
   atax := 0;

if FLAGEDIT then
  s:='update Tbayarsup_HDR set '
    + ' bys_sup_kode = ' + Quot(cxLookupSupplier.EditValue) + ','
    + ' bys_memo = ' + Quot(edtmemo.Text) + ','
    + ' bys_tanggal = ' + Quotd(dtTanggal.Date)+','
    + ' bys_rek_kode = '+ Quot(VarToStr(cxLookupRekening.EditValue)) +','
    + ' bys_nogiro = ' + Quot(edtGiro.Text) + ','
    + ' bys_tglcair = ' + QuotD(dtTglCair.DateTime)+','
    + ' bys_nilai = ' + StringReplace(edtNilai.Text,',','',[rfReplaceAll])+','
    + ' bys_istax = '+ IntToStr(atax)+','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where bys_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into Tbayarsup_HDR '
             + ' (bys_nomor,bys_tanggal,bys_sup_kode,bys_rek_kode,'
             + ' bys_memo,bys_nogiro,bys_tglcair,bys_nilai,bys_istax,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(cxLookupSupplier.EditValue)+','
             + Quot(VarToStr(cxLookupRekening.EditValue))+','
             + Quot(edtmemo.Text)+','
             + Quot(edtGiro.Text) + ','
             + QuotD(dtTglCair.DateTime)+','
             + StringReplace(edtNilai.Text,',','',[rfReplaceAll])+','
             + IntToStr(atax)+','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from Tbayarsup_DTL '
      + ' where  bysd_bys_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('bayar').AsFloat >  0 then
   begin
    S:='insert into tbayarsup_DTL (bysd_bys_nomor,bysd_inv_nomor,bysd_bayar) values ('
      + Quot(edtNomor.Text) +','
      + quot(CDS.FieldByName('INVOICE').AsString) +','
      + FloatToStr(CDS.FieldByName('bayar').AsFloat)
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


function TfrmBayarSupplier.cekdata:Boolean;
var
  i:integer;
begin
  result:=true;
   i := 1;
     If cxLookupsupplier.EditValue = '' then
    begin
      ShowMessage('supplier belum di pilih');
      result:=false;
      Exit;

    end;

   If cxLookupRekening.EditValue = '' then
    begin
      ShowMessage('Rekening belum di pilih');
      result:=false;
      Exit;
    end;

  CDS.First;
  While not CDS.Eof do
  begin

    If (CDS.FieldByName('pay').AsInteger = 1)  and (CDS.FieldByName('bayar').AsFloat = 0) then
    begin
      ShowMessage('Baris : ' + inttostr(i) + ' Pembayaran masih nol');
      result:=false;
      Exit;
    end;

    inc(i);
    CDS.Next;
  end;
end;

procedure TfrmBayarSupplier.chkPajakClick(Sender: TObject);
begin
loaddataInvoice(cxLookupSupplier.EditValue);
end;

procedure TfrmBayarSupplier.loaddataInvoice(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin

 if chkPajak.Checked then
  s := ' select inv_nomor,inv_nobukti Nobukti,inv_nopajak NoPajak,inv_tanggal,inv_jthtempo,inv_amount, '
      + ' ifnull((select SUM(ret_amount) from tret_hdr where ret_inv_nomor=inv_nomor),0) retur, '
      + ' ifnull(inv_bayar,0) Bayar '
      + ' from tinv_hdr '
      + ' inner join tbpb_hdr on inv_bpb_nomor=bpb_nomor '
      + ' inner join tpo_hdr on po_nomor=bpb_po_nomor '
      + ' where po_sup_kode = '+ Quot(akode)
      + ' and inv_istax = 1 '
  else
  s := ' select inv_nomor,inv_nobukti Nobukti,inv_nopajak NoPajak,inv_tanggal,inv_jthtempo,inv_amount, '
      + ' ifnull((select SUM(ret_amount) from tret_hdr where ret_inv_nomor=inv_nomor),0) retur, '
      + ' ifnull(inv_bayar,0) Bayar '
      + ' from tinv_hdr '
      + ' inner join tbpb_hdr on inv_bpb_nomor=bpb_nomor '
      + ' inner join tpo_hdr on po_nomor=bpb_po_nomor '
      + ' where po_sup_kode = '+ Quot(akode)
      + ' and inv_istax = 0 ';


     if FLAGEDIT = False then
     s := s + ' having (inv_amount-retur) > bayar ' ;

     s:= s  + ' order by inv_tanggal ';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
             CDS.EmptyDataSet;
         if not eof then
         begin

            i:=1;

            while  not Eof do
             begin

                      CDS.Append;
                      CDS.FieldByName('invoice').AsString        := fieldbyname('inv_nomor').AsString;
                      CDS.FieldByName('Nobukti').AsString        := fieldbyname('nobukti').AsString;
                      CDS.FieldByName('NoPajak').AsString        := fieldbyname('nopajak').AsString;
                      CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('inv_tanggal').AsDateTime;
                      CDS.FieldByName('JthTempo').AsDateTime      := fieldbyname('inv_jthtempo').AsDateTime;
                      CDS.FieldByName('nilai').AsFloat      := fieldbyname('inv_amount').AsFloat-fieldbyname('retur').AsFloat;
                      CDS.FieldByName('terbayar').AsFloat        := fieldbyname('bayar').AsFloat;
                      CDS.FieldByName('bayar').AsFloat       := 0;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
        end
        else
        begin
          cxLookupSupplier.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;

end;


procedure TfrmBayarSupplier.loaddataall(akode : string);
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
  s := ' select '
     + ' bys_nomor,bys_tanggal,bys_sup_kode,bys_memo,bys_nilai,bys_nogiro,bys_tglcair,bys_rek_kode,'
     + ' bysd_inv_nomor,bysd_bayar,BYS_ISTAX '
     + ' from tbayarsup_hdr inner join tbayarsup_dtl a on bys_nomor=bysd_bys_nomor'
     + ' where bys_nomor = '+ Quot(akode);

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('bys_nomor').AsString;
            edtnomor.Text := fieldbyname('bys_nomor').AsString;
            dttanggal.DateTime := fieldbyname('bys_tanggal').AsDateTime;
            atanggalold := fieldbyname('bys_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('bys_memo').AsString;
            cxLookupsupplier.EditValue  := fieldbyname('bys_sup_kode').AsString;
            cxLookupRekening.EditValue := fieldbyname('bys_rek_kode').AsString;
            edtGiro.Text := fieldbyname('bys_nogiro').AsString;
            dtTglCair.DateTime := fieldbyname('bys_tglcair').AsDateTime;
            edtNilai.Text := fieldbyname('bys_nilai').AsString;
            if fieldbyname('byS_istax').AsString = '1' then
               chkpajak.Checked := True
            else
               chkPajak.Checked := False;

            i:=1;

            while  not Eof do
            begin
                CDS.first;


                while not CDS.Eof do
                begin
                 if CDS.FieldByName('invoice').AsString = FieldByName('bysd_inv_nomor').AsString then
                 begin
                    If CDS.State <> dsEdit then CDS.Edit;
                    CDS.FieldByName('terbayar').AsFloat := CDS.FieldByName('terbayar').AsFloat - fieldbyname('bysd_bayar').AsFloat;
                    CDS.FieldByName('bayar').AsFloat :=fieldbyname('bysd_bayar').AsFloat;
                    CDS.FieldByName('pay').AsInteger := 1;
                    CDS.Post;
                 end;
                  CDS.Next;
                  Inc(i);

                end;
              next;
            end ;
             CDS.first;
             while not CDS.Eof do
             begin
               if CDS.FieldByName('terbayar').AsFloat =CDS.FieldByName('nilai').AsFloat then
                  CDS.Delete
                else
                   CDS.next;
             end;




        end
        else
        begin
          ShowMessage('Nomor  tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;


   end;

end;

procedure TfrmBayarSupplier.cxLookupSupplierPropertiesEditValueChanged(
  Sender: TObject);
begin
  loaddataInvoice(cxLookupSupplier.EditValue);
  edtAlamat.Text := CDSsupplier.Fields[2].AsString;
end;

function TfrmBayarSupplier.GetCDSRekening: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekening) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening';


    FCDSRekening := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekening;
end;

procedure TfrmBayarSupplier.clStatusPropertiesEditValueChanged(
  Sender: TObject);
begin
   CDS.Post;
   If CDS.State <> dsEdit then CDS.Edit;
  if CDS.FieldByName('pay').AsInteger = 1 then
  CDS.FieldByName('bayar').AsFloat :=CDS.FieldByName('nilai').AsFloat-CDS.FieldByName('terbayar').AsFloat
  else
  CDS.FieldByName('bayar').AsFloat := 0;
  cds.post;

end;

procedure TfrmBayarSupplier.clBayarPropertiesEditValueChanged(
  Sender: TObject);
begin
 CDS.Post;

end;

procedure TfrmBayarSupplier.hitung;
var
  asubtotal : Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('bayar'));
  edtnilai.Text :=FloatToStr(asubtotal);

end;

procedure TfrmBayarSupplier.cxGrdMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);
begin
hitung;
end;

procedure TfrmBayarSupplier.clBayarPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
   i:integer;
  akurang:double;
begin

  akurang :=0;

    i:=cxGrdMain.DataController.FocusedRecordIndex;


    if cVarTofloat(DisplayValue)+ cVarTofloat(cxGrdMain.DataController.Values[i,clterbayar.index]) >  cVarTofloat(cxGrdMain.DataController.Values[i,clNilai.index]) then
    begin
      error := true;
        ErrorText :='Pembayarana melebihi kurang Bayar';
        exit;
    end;

end;

procedure TfrmBayarSupplier.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'BYS';

          s:= ' select '
       + ' * ,terbilang(bys_nilai) terbilang '
       + ' from tbayarsup_hdr '
       + ' inner join tbayarsup_dtl on bys_nomor=bysd_bys_nomor'
       + ' inner join tinv_hdr on inv_nomor=bysd_inv_nomor'
       + ' inner join tsupplier on bys_sup_kode=sup_kode '
       + ' inner join trekening on rek_kode=bys_rek_kode '
       + ' where '
       + ' bys_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


procedure TfrmBayarSupplier.doslip2(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'cekslip';

          s:= ' select '
       + ' * ,terbilang(bys_nilai) terbilang '
       + ' from tbayarsup_hdr '
       + ' inner join tbayarsup_dtl on bys_nomor=bysd_bys_nomor'
       + ' inner join tinv_hdr on inv_nomor=bysd_inv_nomor'
       + ' inner join tsupplier on bys_sup_kode=sup_kode '
       + ' inner join trekening on rek_kode=bys_rek_kode '
       + ' where '
       + ' bys_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

end.
