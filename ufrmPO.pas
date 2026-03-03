unit ufrmPO;

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
  cxGridDBTableView, cxGrid, cxSpinEdit, cxCurrencyEdit, cxButtonEdit,
  frxClass, frxDMPExport, MyAccess;

type
  TfrmPO = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    Label4: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupSupplier: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSKU: TcxGridDBColumn;
    clNamaBarang: TcxGridDBColumn;
    clHarga: TcxGridDBColumn;
    clQTY: TcxGridDBColumn;
    clTotal: TcxGridDBColumn;
    clKet: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    edtTelp: TAdvEdit;
    chkPajak: TCheckBox;
    AdvPanel5: TAdvPanel;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    edtmemo: TMemo;
    Label7: TLabel;
    edtDiscpr: TAdvEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtDiscFaktur: TAdvEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtPPN: TAdvEdit;
    edtTotal: TAdvEdit;
    clDisc: TcxGridDBColumn;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    edtDisc: TAdvEdit;
    Label13: TLabel;
    clSatuan: TcxGridDBColumn;
    cxButton3: TcxButton;
    Label5: TLabel;
    dtDateline: TDateTimePicker;
    Label14: TLabel;
    edtPemesan: TAdvEdit;
    clOtorisasi: TcxGridDBColumn;
    frxDotMatrixExport1: TfrxDotMatrixExport;
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
    procedure cxLookupsupplierPropertiesChange(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
   procedure initViewSKU;
    procedure clQTYPropertiesEditValueChanged(Sender: TObject);
    procedure HapusRecord1Click(Sender: TObject);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure clKetPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxGrdMainDataControllerSummaryAfterSummary(
      ASender: TcxDataSummary);
    procedure hitung;  
    procedure edtDiscprExit(Sender: TObject);
    procedure edtDiscFakturExit(Sender: TObject);
    procedure chkPajakClick(Sender: TObject);
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataall(akode : string);
    procedure clSKUPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure doslippo(anomor : string );
    procedure doslipPO2(anomor : string );
    procedure insertketampungan(anomor:string);
    procedure cxGrdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxButton3Click(Sender: TObject);
    procedure clHargaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    function cekLastCost(akode:integer;anilai:Double) : boolean;
  private
    FCDSSupplier: TClientDataset;
    FCDSSKU : TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSSupplier: TClientDataset;


    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDSSupplier: TClientDataset read GetCDSSupplier write FCDSSupplier;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmPO: TfrmPO;
const
   NOMERATOR = 'PO';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,UfrmOtorisasi;

{$R *.dfm}

procedure TfrmPO.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  dtDateline.DateTime := Date;
  chkPajak.Checked := True;
  chkPajak.Enabled := True;
  edtnomor.Text := getmaxkode;
  cxLookupsupplier.EditValue := '';
  edtAlamat.Clear;
  edtmemo.Clear;
  edtTelp.Clear;
  edtPemesan.Clear;
  cxLookupsupplier.SetFocus;
  initgrid;

end;
procedure TfrmPO.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.FieldByName('Harga').AsInteger  := 0;
  CDS.FieldByName('Total').AsInteger  := 0;
  CDS.Post;

end;
procedure TfrmPO.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmPO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmPO.getmaxkode:string;
var
  s:string;
begin
  if chkPajak.Checked then
  begin
  s:='select max(right(po_nomor,4)) from tpo_hdr where po_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and po_istax=1 ';
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
  end
  else
  begin
    s:='select max(right(po_nomor,3)) from tpo_hdr where po_nomor like ' + quot(NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
      + ' and po_istax =0 ';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+1),4)
      else
         result:= NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+fields[0].AsInteger+1),4);


    finally
      free;
    end;
  end;
  end;
end;

procedure TfrmPO.cxButton1Click(Sender: TObject);
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

procedure TfrmPO.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmPO.cxButton2Click(Sender: TObject);
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

procedure TfrmPO.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupSupplier.Properties) do
    LoadFromCDS(CDSSupplier, 'Kode','supplier',['Kode'],Self);
     TcxExtLookupHelper(cxLookupSupplier.Properties).SetMultiPurposeLookup;

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
     initViewSKU;
end;

function TfrmPO.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'SKU', ftInteger, False);
    zAddField(FCDS, 'QTY', ftFloat, False);
    zAddField(FCDS, 'Satuan', ftString, False, 10);
    zAddField(FCDS, 'Harga', ftFloat, False);
    zAddField(FCDS, 'Disc', ftFloat, False);
    zAddField(FCDS, 'Total', ftFloat, False);
    zAddField(FCDS, 'Keterangan', ftString, False, 255);
    zAddField(FCDS, 'otorisasi', ftInteger, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmPO.GetCDSSupplier: TClientDataset;
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

procedure TfrmPO.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmPO.cxLookupsupplierPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDSsupplier.Fields[2].AsString;
edtTelp.Text :=  CDSsupplier.Fields[3].AsString;
end;

procedure TfrmPO.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmPO.initViewSKU;
var
  S: string;
begin
  if Assigned(FCDSSKU) then FCDSSKU.Free;
  S := 'select brg_kode sku, brg_nama NamaBarang, brg_hrgbeli HrgBeli,'
      + ' brg_satuan Satuan from Tbarang ORDER BY brg_nama';


  FCDSSKU := TConextMain.cOpenCDS(S, nil);

  with TcxExtLookupHelper(clSKU.Properties) do
  begin
    LoadFromCDS(CDSSKU, 'SKU','SKU',['SKU'],Self);
    SetMultiPurposeLookup;
  end;

  with TcxExtLookupHelper(clNamaBarang.Properties) do
    LoadFromCDS(CDSSKU, 'SKU','NamaBarang',['SKU'],Self);


end;
procedure TfrmPO.clQTYPropertiesEditValueChanged(Sender: TObject);
var
  i: Integer;
  lVal: Double;
begin
  inherited;
  cxGrdMain.DataController.Post;

  i := cxGrdMain.DataController.FocusedRecordIndex;
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] *  cxGrdMain.DataController.Values[i, clHarga.Index]*(cvartofloat(cxGrdMain.DataController.Values[i,cldisc.Index])/100);
  lVal := cxGrdMain.DataController.Values[i, clQTY.Index] * cxGrdMain.DataController.Values[i, clHarga.Index] - lVal;

  If CDS.State <> dsEdit then CDS.Edit;
  CDS.FieldByName('Total').AsFloat := lVal;
  CDS.Post;


end;
procedure TfrmPO.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;

procedure TfrmPO.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
 CDS.FieldByName('harga').AsFloat := CDSSKU.Fields[2].AsFloat;
 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[3].Asstring;

end;



procedure TfrmPO.clKetPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  var
    i:integer ;
begin
   i := cxGrdMain.DataController.FocusedRecordIndex;

 If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index])=0) then
 begin
    Error :=True;
    ErrorText := 'Sku Belum Diinput';

 end;
end;

procedure TfrmPO.cxGrdMainDataControllerSummaryAfterSummary(
  ASender: TcxDataSummary);

begin
  Hitung;
end;

procedure TfrmPO.hitung;
var
  asubtotal : Double;
  adisc:Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
  edtDiscFaktur.Text := FloatToStr((cStrToFloat(edtDiscpr.text)/100*asubtotal)+cStrToFloat(edtDisc.text)) ;
  asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
  if chkPajak.Checked then
  begin
    edtTotal.Text :=FloatToStr(asubtotal*getangkappn(dtTanggal.DateTime));
    edtPPN.Text := FloatToStr(asubtotal *getangkappn2(dtTanggal.DateTime));
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal);
    edtPPN.Text := '0';
  end;

end;
procedure TfrmPO.edtDiscprExit(Sender: TObject);
begin
 if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmPO.edtDiscFakturExit(Sender: TObject);
begin
  if edtDiscFaktur.Text = '' then
    edtDiscFaktur.Text :='0';
  hitung;  
end;

procedure TfrmPO.chkPajakClick(Sender: TObject);
begin
hitung;
edtnomor.text := getmaxkode;
end;

procedure TfrmPO.dtTanggalChange(Sender: TObject);
begin
edtNomor.Text := getmaxkode;

end;


procedure TfrmPO.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aistax : integer;
begin
  if chkPajak.Checked then
    aistax :=  1
  else
    aistax := 0;
if FLAGEDIT then
  s:='update Tpo_HDR set '
    + ' po_sup_kode = ' + Quot(cxLookupsupplier.EditValue) + ','
    + ' po_memo = ' + Quot(edtmemo.Text) + ','
    + ' po_disc_faktur =' + floattostr(cStrToFloat(edtDisc.Text))+ ','
    + ' po_disc_fakturpr = '+ floattostr(cStrToFloat(edtDiscpr.Text))+ ','
    + ' po_amount = '+ floattostr(cstrtoFloat(edtTotal.Text))+ ','
    + ' po_taxamount = '+ floattostr(cStrToFloat(edtPPN.Text))+ ','
    + ' po_istax = ' + IntToStr(aistax)+  ','
    + ' po_dateline= ' + QuotD(dtDateline.DateTime) + ','
    + ' po_pemesan = ' + Quot(edtPemesan.Text) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where po_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
  s :=  ' insert into Tpo_HDR '
             + ' (po_nomor,po_tanggal,po_memo,po_sup_kode,po_disc_faktur,'
             + ' po_disc_fakturpr,po_amount,po_taxamount,po_istax,po_dateline,po_pemesan,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(edtmemo.Text)+','
             + Quot(cxLookupsupplier.EditValue) + ','
             + floattostr(cStrToFloat(edtDisc.Text))+ ','
             + floattostr(cStrToFloat(edtDiscpr.Text))+ ','
             + floattostr(cStrToFloat(edtTotal.Text))+ ','
             + floattostr(cStrToFloat(edtPPN.Text))+ ','
             + IntToStr(aistax)+  ','
             + QuotD(dtDateline.DateTime) + ','
             + Quot(edtPemesan.Text) + ','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from Tpo_DTL '
      + ' where  pod_po_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
     i:=1;
  while not CDS.Eof do
  begin

    S:='insert into tpo_DTL (pod_po_nomor,pod_brg_kode,pod_brg_satuan,pod_qty,pod_discpr,pod_harga,pod_keterangan,pod_nourut) values ('
      + Quot(edtNomor.Text) +','
      + IntToStr(CDS.FieldByName('SKU').AsInteger) +','
      + Quot(CDS.FieldByName('satuan').AsString) +','
      + FloatToStr(CDS.FieldByName('QTY').asfloat) +','
      + FloatToStr(cVarToFloat(CDS.FieldByName('DISC').AsFloat))+','
      + FloatToStr(cVarToFloat(CDS.FieldByName('harga').AsFloat))+','
      + quot(CDS.FieldByName('keterangan').AsString) +','
      + IntToStr(i)
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


function TfrmPO.cekdata:Boolean;
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
  CDS.First;
  While not CDS.Eof do
  begin

//    if (CDS.FieldByName('otorisasi').AsInteger <> 1) and
//    (not ceklastcost(CDS.FieldByName('SKU').AsInteger,(100 - CDS.FieldByName('Disc').AsFloat)/100*CDS.FieldByName('Harga').AsFloat)) then
//    begin
//      if MessageDlg('Net Harga Beli Baris : ' + inttostr(i) + ' Berubah',mtCustom,
//                            [mbYes,mbNo], 0)= mrNo then
//       begin
//              result:=false;
//              Exit;
//       end
//      else
//      begin
//          Application.CreateForm(TfrmOtorisasi,frmOtorisasi);
//          frmOtorisasi.ShowModal;
//          if frmMenu.otorisasi then
//          begin
//             If CDS.State <> dsEdit then CDS.Edit;
//             CDS.FieldByName('otorisasi').AsInteger := 1;
//          end;
//      end;
//    end;

    If CDS.FieldByName('SKU').AsInteger = 0 then
    begin
      ShowMessage('SKU Baris : ' + inttostr(i) + ' Belum dipilih');
      result:=false;
      Exit;
    end;

    If CDS.FieldByName('QTY').AsInteger = 0 then
    begin
      ShowMessage('QTY Baris : ' + inttostr(i) + ' Belum diisi');
      result:=false;
      Exit;
    end;
    inc(i);
    CDS.Next;
  end;
end;

procedure TfrmPO.loaddataall(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select po_nomor,po_tanggal,po_memo,po_sup_kode,po_pemesan,'
     + ' po_DISC_faktur,po_disc_fakturpr,po_istax,pod_keterangan,'
     + ' pod_brg_kode,pod_bRG_satuan,pod_qty,pod_harga,pod_discPR,(pod_qty*pod_harga*(100-pod_discpr)/100) nilai'
     + ' from tpo_hdr a'
     + ' LEFT join tpo_dtl d on a.po_nomor=d.pod_po_nomor '
     + ' where a.po_nomor = '+ Quot(akode)
     + ' ORDER BY pod_nourut';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('po_nomor').AsString;
            if fieldbyname('po_istax').AsInteger =1 then
               chkPajak.Checked := True
            else
              chkPajak.Checked := False;
            chkpajak.Enabled := False;
            edtNomor.Text   := fieldbyname('po_nomor').AsString;
            dttanggal.DateTime := fieldbyname('po_tanggal').AsDateTime;
            edtmemo.Text := fieldbyname('po_memo').AsString;
            edtPemesan.Text := fieldbyname('po_pemesan').AsString;
            cxLookupsupplier.EditValue  := fieldbyname('po_sup_kode').AsString;
            edtDiscpr.Text := fieldbyname('po_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('po_disc_faktur').AsString;


            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin


                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('pod_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('pod_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsFloat        := fieldbyname('pod_qty').AsFloat;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('pod_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('pod_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('keterangan').AsString  := fieldbyname('pod_keterangan').AsString;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
            hitung;

        end
        else
        begin
          ShowMessage('Nomor so tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;


   end;
   hitung;
end;

procedure TfrmPO.clSKUPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
 var
  i:integer;
begin
    for i := 0 to cxGrdMain.DataController.RecordCount-1 do
    begin
      If (cVarToInt(cxGrdMain.DataController.Values[i, clSKU.Index]) = DisplayValue) and (cxGrdMain.DataController.FocusedRecordIndex <> i) then
      begin
        error := true;
        ErrorText :='Sku sudah ada';
//        if MessageDlg('Kode barang sudah ada di baris ' + IntToStr(i+1) + ' Lanjut ? ',mtCustom,
//                                  [mbYes,mbNo], 0)= mrNo
//          then
//          begin
//
//            error := true;
//            ErrorText :='Pilih Kode lain ';
//            exit;
//          end
//          else
//          exit;

      end;
    end;
end;

procedure TfrmPO.doslipPO(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'PO';

          s:= ' select '
       + ' *,if(pod_nourut is null ,1000,pod_nourut) nourut ,terbilang(po_amount) terbilang '
       + ' from tPO_hdr '
       + ' inner join tampung on nomor=po_nomor '
       + ' inner join tsupplier on po_sup_kode=sup_kode '
       + ' left join  tpo_dtl on po_nomor=pod_po_nomor and tam_nama = pod_brg_kode '
       + ' left join tbarang on pod_brg_kode=brg_kode '
       + ' where '
       + ' po_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmPO.doslipPO2(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin
  insertketampungan(anomor);
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'POGudang';

          s:= ' select '
       + ' *,if(pod_nourut is null ,1000,pod_nourut) nourut ,terbilang(po_amount) terbilang '
       + ' from tPO_hdr '
       + ' inner join tampung on nomor=po_nomor '
       + ' inner join tsupplier on po_sup_kode=sup_kode '
       + ' left join  tpo_dtl on po_nomor=pod_po_nomor and tam_nama = pod_brg_kode '
       + ' left join tbarang on pod_brg_kode=brg_kode '
       + ' where '
       + ' po_nomor=' + quot(anomor)
       + ' order by nourut';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmPO.insertketampungan(anomor:string);
var
  s:string;
  tsql : TMyQuery;
  a,i,x:integer;
  tt : TStrings;
begin
  a:=9;
  s:='delete from tampung ';
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  // xCommit(frmMenu.conn);
  s := 'select POD_brg_kode from tpo_dtl where pod_po_nomor =' + Quot(anomor) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;
  x:=0;
  tt:=TStringList.Create;

    with tsql do
    begin
      try
       while not Eof do
       begin
         x:=x+1;
          s :=   'insert  into tampung '
                  + '(nomor,tam_nama'
                  + ')values ('
                  + Quot(anomor) + ','
                  + Quot(Fields[0].Asstring)
                  + ');';
          tt.Append(s);
        Next
       end;
       finally
          free;
      end;
    end;


  for i := x to a do
   begin


        s :='insert  into tampung '
            + '(nomor,tam_nama'
            + ')values ('
            + Quot(anomor) + ','
            + Quot('-')
            + ');';
        tt.Append(s);

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
    // xCommit(frmMenu.conn);

end;



procedure TfrmPO.cxGrdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = VK_DELETE then
begin
  If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;
end;
procedure TfrmPO.cxButton3Click(Sender: TObject);
  var
    s:string;
    tsql:TMyQuery;
    i:Integer;
begin
    sqlbantuan := 'select gdg_kode Kode,gdg_nama Nama from Tgudang ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  if varglobal <> '' then
   begin
       s:='select hitd_brg_kode,hitd_satuan,sum(hitd_qty) qty,brg_hrgbeli from thitungstok_dtl inner join thitungstok on '
          + ' hitd_hit_nomor=hit_nomor'
          + ' inner join tbarang on brg_kode=hitd_brg_kode'
          + ' where hit_gdg_kode ='+quot(varglobal)
          + ' group by hitd_brg_kode,hitd_satuan';
    tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin
      try
        cds.emptydataset;
        while not Eof do
        begin
          If CDS.State <> dsEdit then CDS.Edit;
          cds.append;
          cds.FieldByName('sku').AsInteger := Fields[0].AsInteger;
          CDS.FieldByName('Satuan').AsString := Fields[1].AsString;
          CDS.FieldByName('qty').AsFloat := Fields[2].AsFloat;
          CDS.FieldByName('harga').AsFloat := Fields[3].AsFloat;
          clQTYPropertiesEditValueChanged(self);
          next;
        end;
        finally
          free;
      end;
      hitung;
    end;
  end;
end;

procedure TfrmPO.clHargaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  sqlbantuan := 'select brg_nama Nama,invd_harga Harga,invd_discpr Disc,invd_expired Expired,'
                  + ' inv_tanggal Tanggal, invd_qty Qty from '
                  + ' tinv_dtl inner join tbarang on brg_kode=invd_brg_kode '
                  + ' inner join tinv_hdr on invd_inv_nomor=inv_nomor '
                  + ' where inv_nomor <> ' + Quot(edtNomor.Text)
                  + ' AND brg_kode = ' +  VarToStr(cxGrdMain.DataController.Values[cxGrdMain.DataController.FocusedRecordIndex, clSKU.Index])
                  + ' and inv_sup_kode= ' + Quot(cxLookupSupplier.EditValue);

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
  frmBantuan.btnOK.Visible := False;

end;

function TfrmPO.cekLastCost(akode:integer;anilai:Double):boolean;
var
  s:string;
  tsql :TMyQuery;
begin
  Result :=  True;
  s:='SELECT mst_hargabeli from tmasterstok where mst_noreferensi like "RI%" AND '
    + ' mst_brg_kode= ' + inttostr(akode)
    + ' ORDER BY mst_tanggal desc limit 1 ';
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
      begin
        if ((Fields[0].AsFloat - anilai ) > 100 ) or ((anilai-Fields[0].AsFloat) > 100 ) then
        begin
          Result := False;
        end;
      end;
    finally
      free;
    end;
  end;


end;

end.
