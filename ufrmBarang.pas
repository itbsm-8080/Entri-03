unit ufrmBarang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox,DBClient, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxSpinEdit,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxButtonEdit,
  MyAccess;

type
  TfrmBarang = class(TForm)
    AdvPanel1: TAdvPanel;
    Label2: TLabel;
    edtKode: TAdvEdit;
    Label3: TLabel;
    edtNama: TAdvEdit;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edtSatuan: TAdvEdit;
    edtHargaBeli: TAdvEdit;
    edtHargaJual: TAdvEdit;
    cxLookupJenisGroup: TcxExtLookupComboBox;
    cxExtLookupGudang: TcxExtLookupComboBox;
    cxExtLookupSupplier: TcxExtLookupComboBox;
    cxExtLookupKategori: TcxExtLookupComboBox;
    Label10: TLabel;
    chkAktif: TCheckBox;
    chkStok: TCheckBox;
    chkExpired: TCheckBox;
    AdvPanel4: TAdvPanel;
    Label13: TLabel;
    edtMerk: TAdvEdit;
    chkProdukfocus: TCheckBox;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clkodeJenis: TcxGridDBColumn;
    clJenisCustomer: TcxGridDBColumn;
    clHargaJual: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure refreshdata;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure loaddata(akode:string) ;
    procedure simpandata;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure edtKodeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxGridDBColumn2PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure HapusRecord1Click(Sender: TObject);

  private
    FCDSJenisGroup: TClientDataset;
    FCDSSupplier: TClientDataset;
    FCDSKategori: TClientDataset;
    FCDSGudang: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSJenisGroup: TClientDataset;
    function GetCDSSupplier: TClientDataset;
    function GetCDSKategori: TClientDataset;
    function GetCDSGudang: TClientDataset;
    function GetCDS: TClientDataSet;
    function GetCDS2: TClientDataSet;
    procedure initgrid;

       protected
    FCDS: TClientDataSet;
    FCDS2: TClientDataSet;

    { Private declarations }
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDS2: TClientDataSet read GetCDS2 write FCDS2;
    property CDSJenisGroup: TClientDataset read GetCDSJenisGroup write
        FCDSJenisGroup;
    property CDSSupplier: TClientDataset read GetCDSSupplier write FCDSSupplier;
    property CDSKategori: TClientDataset read GetCDSKategori write FCDSKategori;
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
        function getmaxkode:integer;
    { Public declarations }
  end;

var
  frmBarang: TfrmBarang;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib;

{$R *.dfm}

procedure TfrmBarang.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
 If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmBarang.refreshdata;
begin
  FID:='';
  edtKode.Enabled := True;
  edtKode.Text := IntToStr(getmaxkode);
  edtNama.Clear;
  edtHargaBeli.Text := '0';
  edtHargaJual.Text := '0';
  cxExtLookupGudang.Clear;
  cxExtLookupSupplier.Clear;
  cxExtLookupKategori.Clear;
  cxLookupJenisGroup.EditValue := 1;
  chkAktif.Checked := False;
  chkStok.Checked := false;
  chkExpired.Checked := False;
  edtSatuan.Clear;
  edtnama.SetFocus;
end;
procedure TfrmBarang.FormKeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmBarang.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;

procedure TfrmBarang.loaddata(akode:string) ;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select *  from tbarang where brg_kode = ' + Quot(akode) ;
tsql := xOpenQuery(s,frmMenu.conn);
with tsql do
begin
  try
    if not Eof then
    begin
      FLAGEDIT := True;
      edtKode.Enabled := False;
      edtNama.Text := fieldbyname('brg_nama').AsString;
       cxLookupJenisGroup.EditValue  := fieldbyname('BRG_GR_KODE').AsString;
       cxExtLookupGudang.EditValue := fieldbyname('BRG_Gdg_default').AsString;
       cxExtLookupSupplier.EditValue := fieldbyname('BRG_sup_KODE').AsString;
       cxExtLookupKategori.EditValue := fieldbyname('BRG_ktg_KODE').AsString;
       edtHargaBeli.Text := fieldbyname('brg_hrgbeli').AsString;
       edtHargaJual.Text := fieldbyname('brg_hrgjual').AsString;
       edtSatuan.Text := fieldbyname('brg_satuan').AsString;
       if fieldbyname('brg_isaktif').AsString = '1' then
          chkAktif.Checked :=True ;
       if fieldbyname('brg_isstok').AsString = '1' then
          chkStok.Checked :=True ;
      if fieldbyname('brg_isexpired').AsString = '1' then
          chkExpired.Checked :=True ;

      FID :=fieldbyname('brg_kode').Asstring;

    end
    else
     FLAGEDIT := False;

     initgrid ;
  finally
    Free;
  end;
end;

end;


procedure TfrmBarang.simpandata;
var
  s:string;
  isprodukfocus,i,isaktif,isstok,isexpired : integer;
  tt:TStrings;

begin
      if chkProdukfocus.Checked then
     isprodukfocus := 1
  else
    isprodukfocus := 0;

  if chkAktif.Checked then
     isaktif := 1
  else
    isaktif := 0;

  if chkStok.Checked then
     isstok := 1
  else
     isstok := 0;
  if chkExpired.Checked then
     isexpired:=1
  else
     isexpired := 0;
if FLAGEDIT then
  s:='update tbarang set '
    + ' brg_nama = ' + Quot(edtNama.Text) + ','
    + ' brg_gr_kode = ' +IntToStr(cVarToInt(cxLookupJenisGroup.EditValue))+ ','
    + ' brg_satuan = '+ Quot(edtSatuan.Text)+','
    + ' brg_ktg_kode = ' + Quot(cxExtLookupKategori.EditValue)+ ','
    + ' brg_gdg_default = ' + Quot(cxExtLookupGudang.EditValue)+ ','
    + ' brg_sup_kode = ' + Quot(cxExtLookupSupplier.EditValue)+ ','
    + ' brg_merk = ' + Quot(edtMerk.Text) + ','
    + ' brg_hrgjual = ' + StringReplace(edtHargaJual.Text,',','',[rfReplaceAll])+','
    + ' brg_hrgbeli = ' + StringReplace(edtHargaBeli.Text,',','',[rfReplaceAll])+','
    + ' brg_isaktif = ' + IntToStr(isaktif) + ','
    + ' brg_isstok = ' + IntToStr(isstok) + ','
    + ' brg_isproductfocus = ' + IntToStr(isprodukfocus) + ','
    + ' brg_isexpired = ' + IntToStr(isexpired) + ','
    + ' date_modified  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modified = ' + Quot(frmMenu.KDUSER)
    + ' where brg_kode = ' + quot(FID) + ';'
else
begin

  s :=  ' insert into tbarang '
             + ' (brg_kode,brg_nama,brg_satuan,brg_gr_kode,brg_ktg_kode,brg_gdg_DEFAULT,brg_sup_kode ,brg_merk,'
             + ' brg_hrgjual,brg_hrgbeli,brg_lastcost,brg_isaktif,brg_isstok,brg_isexpired,brg_isproductfocus,date_create,user_create'
             + ' ) '
             + ' values ( '
             + Quot(edtKode.Text) + ','
             + Quot(edtNama.Text) + ','
             + Quot(edtSatuan.Text) + ','
             + IntToStr(cVarToInt(cxLookupJenisGroup.EditValue)) + ','
             + Quot(VarToStr(cxExtLookupKategori.EditValue)) + ','
             + Quot(VarToStr(cxExtLookupGudang.EditValue)) + ','
             + Quot(VarToStr(cxExtLookupSupplier.EditValue)) + ','
             + Quot(edtMerk.Text)+','
             + StringReplace(edtHargaJual.Text,',','',[rfReplaceAll]) + ','
             + StringReplace(edtHargaBeli.Text,',','',[rfReplaceAll]) + ','
             + StringReplace(edtHargaBeli.Text,',','',[rfReplaceAll]) + ','
             + IntToStr(isaktif) + ','
             + IntToStr(isstok)+ ','
             + IntToStr(isexpired)+ ','
             + IntToStr(isprodukfocus)+ ','             
              + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

     tt := TStringList.Create;
   s:= ' delete from Thargajualjenis '
      + ' where  hjj_brg_kode =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('hargajual').AsFloat >  0 then
   begin
    S:='insert into thargajualjenis (hjj_brg_kode,hjj_jc_kode,hjj_hargajual) values ('
      + Quot(edtKode.Text) +','
      + IntToStr(CDS.FieldByName('kode').AsInteger) +','
      + floatToStr(CDS.FieldByName('hargajual').Asfloat)
      + ');';
    tt.Append(s);
   end;
    CDS.Next;
    Inc(i);
  end;

   tt := TStringList.Create;
   s:= ' delete from tbarangkomposisi '
      + ' where  bk_brg_kode =' + quot(FID);

   tt.Append(s);
   CDS2.First;
    i:=1;
  while not CDS2.Eof do
  begin
   if CDS2.FieldByName('qty').AsFloat >  0 then
   begin
    S:='insert into tbarangkomposisi (bk_brg_kode,bk_bhn_kode,bk_qty,bk_satuan,bk_nourut) values ('
      + Quot(edtKode.Text) +','
      + IntToStr(CDS2.FieldByName('kode').AsInteger) +','
      + floatToStr(CDS2.FieldByName('qty').Asfloat)+','
      + Quot(CDS2.FieldByName('satuan').asstring)+','
      + inttostr(i)
      + ');';
    tt.Append(s);
   end;
    CDS2.Next;
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


procedure TfrmBarang.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;


procedure TfrmBarang.cxButton1Click(Sender: TObject);
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
      MessageDlg('Gagal Simpan',mtWarning, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;

procedure TfrmBarang.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmBarang.cxButton2Click(Sender: TObject);
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
    Release;
end;

procedure TfrmBarang.edtKodeExit(Sender: TObject);
begin
loaddata(edtKode.Text);
end;

procedure TfrmBarang.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupJenisGroup.Properties) do
    LoadFromCDS(CDSJenisGroup, 'Kode','Nama',['Kode'],Self);
  with TcxExtLookupHelper(cxExtLookupGudang.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Nama',['Kode'],Self);
   with TcxExtLookupHelper(cxExtLookupSupplier.Properties) do
    LoadFromCDS(CDSSupplier, 'Kode','Nama',['Kode'],Self);
    with TcxExtLookupHelper(cxExtLookupKategori.Properties) do
    LoadFromCDS(CDSKategori, 'Kode','Nama',['Kode'],Self);
   TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);
   TcxDBGridHelper(cxGridDBTableView1).LoadFromCDS(CDS2, False, False);

end;

function TfrmBarang.GetCDSJenisGroup: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSJenisGroup) then
  begin
    S := 'select gr_nama as Nama, gr_kode Kode'
        +' from tgroup';


    FCDSJenisGroup := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSJenisGroup;
end;

function TfrmBarang.GetCDSSupplier: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSSupplier) then
  begin
    S := 'select sup_nama as Nama, sup_kode Kode'
        +' from tsupplier';


    FCDSSupplier := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSSupplier;
end;

function TfrmBarang.GetCDSKategori: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSKategori) then
  begin
    S := 'select ktg_nama as Nama, ktg_kode Kode'
        +' from tkategori WHERE Ktg_tingkat=3';


    FCDSKategori := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSKategori;
end;

function TfrmBarang.GetCDSGudang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSgudang) then
  begin
    S := 'select gdg_nama as Nama, gdg_kode Kode'
        +' from tgudang';


    FCDSgudang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSgudang;
end;

function TfrmBarang.getmaxkode:integer;
var
  s:string;
begin
  s:='select max(brg_kode) from tbarang';
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= 10001
      else
         result:= fields[0].AsInteger+1;

    finally
      free;
    end;
  end;
end;


function TfrmBarang.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Kode', ftInteger, False);
    zAddField(FCDS, 'nama', ftstring, False,30);
    zAddField(FCDS, 'hargajual', ftfloat, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmBarang.GetCDS2: TClientDataSet;
begin
  If not Assigned(FCDS2) then
  begin
    FCDS2 := TClientDataSet.Create(Self);
    zAddField(FCDS2, 'No', ftInteger, False);
    zAddField(FCDS2, 'Kode', ftInteger, False);
    zAddField(FCDS2, 'nama', ftstring, False,30);
    zAddField(FCDS2, 'Qty', ftfloat, False);
    zAddField(FCDS2, 'satuan', ftstring, False,30);
    FCDS2.CreateDataSet;
  end;
  Result := FCDS2
end;

procedure TfrmBarang.initgrid;
var
  s:string;
  tsql:TMyQuery;

begin
  CDS.EmptyDataSet;
  s:=' select jc_kode kode,jc_nama nama,ifnull(hjj_hargajual,0) hargajual from tjeniscustomer'
    + ' left join thargajualjenis on hjj_jc_kode=jc_kode and hjj_brg_kode='+ Quot(edtKode.Text);
 tsql := xOpenQuery(s,frmMenu.conn) ;
 with tsql do
 begin
   try
     while not Eof do
     begin
        CDS.Append;
        CDS.FieldByName('kode').AsInteger    := Fields[0].AsInteger;
        CDS.FieldByName('nama').AsString     := Fields[1].AsString;
        CDS.FieldByName('hargajual').AsFloat  := Fields[2].AsFloat;
        CDS.Post;

       Next;
     end;
   finally
     free;
   end;
 end;

 cds2.EmptyDataSet;
   s:=' select bk_bhn_kode,brg_nama ,bk_qty,bk_satuan from tbarangkomposisi inner join '
     + ' tbarang on brg_kode=bk_bhn_kode '
     + ' where bk_brg_kode='+ Quot(edtKode.Text)
     + ' order by bk_nourut ';

 tsql := xOpenQuery(s,frmMenu.conn) ;
 with tsql do
 begin
   try
     while not Eof do
     begin
        CDS2.Append;
        CDS2.FieldByName('kode').AsInteger    := Fields[0].AsInteger;
        CDS2.FieldByName('nama').AsString     := Fields[1].AsString;
        CDS2.FieldByName('qty').AsFloat       := Fields[2].AsFloat;
        CDS2.FieldByName('satuan').AsString   := Fields[3].AsString;

        CDS2.Post;

       Next;
     end;
   finally
     free;
   end;
 end;

end;

procedure TfrmBarang.cxGridDBColumn2PropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  var
    s:string;
    tsql:TMyQuery;
begin
 sqlbantuan := 'select brg_kode Kode, brg_nama NamaBarang, brg_satuan Satuan from tbarang where brg_gr_kode in (3,2) ';

  Application.CreateForm(Tfrmbantuan,frmbantuan);
  frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
   begin
     s:='select brg_kode,brg_nama,brg_satuan from tbarang where brg_kode='+quot(varglobal);
     tsql := xOpenQuery(s,frmMenu.conn);
     with tsql do
     begin
       if not eof then
       begin
       If CDS2.State <> dsEdit then CDS2.Edit;
         CDS2.FieldByName('kode').AsString := Fields[0].AsString;
         CDS2.FieldByName('nama').AsString := Fields[1].AsString;
         CDS2.FieldByName('satuan').AsString := Fields[2].AsString;

       end;
     end;
   end;
end;

procedure TfrmBarang.HapusRecord1Click(Sender: TObject);
begin
 If CDS2.Eof then exit;
  CDS2.Delete;

end;

end.
