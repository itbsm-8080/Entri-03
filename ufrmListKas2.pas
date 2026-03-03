unit ufrmListKas2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinPumpkin,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox;

type
  TfrmListKas2 = class(TfrmCxBrowse)
    cxLookupRekeningCash: TcxExtLookupComboBox;
    Label3: TLabel;
    PopupMenu1: TPopupMenu;
    LihatFakturPenjualan1: TMenuItem;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LihatFakturPenjualan1Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
  private
  FCDSRekeningCash: TClientDataset;
  function GetCDSRekeningCash: TClientDataset;
    { Private declarations }
  public
  property CDSRekeningCash: TClientDataset read GetCDSRekeningCash write
      FCDSRekeningCash;
    { Public declarations }
  end;

var
  frmListKas2: TfrmListKas2;

implementation
   uses Ulib, MAIN, uModuleConnection,ufrmPembayaranLain,ufrmFP,ufrmBayarCustomer,ufrmPenerimaanLain,
  ufrmPencairanGiro, ufrmJurnalUmum, ufrmBayarSupplier,uReport;
{$R *.dfm}

procedure TfrmListKas2.btnRefreshClick(Sender: TObject);
var
  xdebet,xkredit,xsaldo : Double;
  i:integer;
begin

  Self.SQLMaster :='SELECT "Saldo Awal" Keterangan,0 Debet, 0 Kredit, '
                + ' IFNULL(SUM(jurd_debet-jurd_kredit),0) Saldo '
                + ' FROM tjurnalitem '
                + ' INNER JOIN tjurnal ON jurd_jur_no=jur_no '
                + ' WHERE jurd_rek_kode= '+quot(VarToStr(cxlookupRekeningcash.editvalue))+' AND jur_tanggal < '+QuotD(startdate.DateTime)
                + ' union '
                + ' select IFNULL(sls_nama,jur_keterangan) Keterangan,sum(jurd_debet) Debet,sum(jurd_kredit) Kredit,0 Saldo from tjurnalitem '
                + ' inner join tjurnal on jur_no=jurd_jur_no '
                + ' left join pembayaran on jur_no=nomor '
                + ' left join tsalesman on sls_kode=salesman '
                + ' where '
                + ' jurd_rek_kode= '+quot(VarToStr(cxlookupRekeningcash.editvalue))+' AND jur_tanggal = '+QuotD(startdate.DateTime)
                + ' group by IFNULL(sls_nama,jur_keterangan)';


   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=200;

    cxGrdMaster.Columns[1].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[1].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[2].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[2].Summary.FooterFormat:='###,###,###,###';
    cdsmaster.First;
    xsaldo:=0;
    i:=0;
    while not CDSMaster.Eof do
    begin
      if  i > 0 then
      begin
          If CDSMaster.State <> dsEdit then CDSMaster.Edit;
      CDSMaster.FieldByName('saldo').AsFloat := xsaldo + CDSMaster.FieldByName('Debet').AsFloat - CDSMaster.FieldByName('kredit').AsFloat;
      end;
      xsaldo :=CDSMaster.FieldByName('saldo').AsFloat;
      i:=i+1;
      CDSMaster.Next;
    end;


end;

procedure TfrmListKas2.FormShow(Sender: TObject);
begin
  ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmListKas2.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

function TfrmListKas2.GetCDSRekeningCash: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningCash) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening'
        + ' WHERE rek_nama like '+ quot('KAS%');


    FCDSRekeningCash := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningCash;
end;

procedure TfrmListKas2.FormCreate(Sender: TObject);
begin
  inherited;
    with TcxExtLookupHelper(cxLookupRekeningCash.Properties) do
    LoadFromCDS(CDSRekeningCash, 'Kode','Rekening',['Kode'],Self);

end;

procedure TfrmListKas2.LihatFakturPenjualan1Click(Sender: TObject);
begin
  inherited;
  if pos(UpperCase('KK'),UpperCase(CDSMaster.FieldByname('NOMOR').AsString)) > 0  then
  begin
    if ActiveMDIChild.Caption <> 'Pembayaran Lain' then
     begin

        frmPembayaranLain  := frmmenu.ShowForm(TfrmPembayaranLain) as TfrmPembayaranLain;
        frmPembayaranLain.ID := CDSMaster.FieldByname('Nomor').AsString;
        frmPembayaranLain.FLAGEDIT := True;
        frmPembayaranLain.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
        frmPembayaranLain.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

     end;
     frmPembayaranLain.Show;
   end;
   if pos(UpperCase('CG'),UpperCase(CDSMaster.FieldByname('NOMOR').AsString)) > 0  then
  begin

   if ActiveMDIChild.Caption <> 'Pencairan Giro' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPencairanGiro  := frmmenu.ShowForm(TfrmPencairanGiro) as TfrmPencairanGiro;
      frmPencairanGiro.ID := CDSMaster.FieldByname('nomor').AsString;
      frmPencairanGiro.FLAGEDIT := True;
      frmPencairanGiro.edtNomor.Text := CDSMaster.FieldByname('nomor').AsString;
      frmPencairanGiro.loaddata(CDSMaster.FieldByname('nomor').AsString);
      frmPencairanGiro.edtnomor.Enabled := False;
      frmPencairanGiro.dtTanggal.Enabled := False;

   end;
   frmPencairanGiro.Show;
  end;
  if pos(UpperCase('KM'),UpperCase(CDSMaster.FieldByname('NOMOR').AsString)) > 0  then
  begin
    if ActiveMDIChild.Caption <> 'Penerimaan Lain' then
     begin

        frmPenerimaanLain  := frmmenu.ShowForm(TfrmPenerimaanLain) as TfrmPenerimaanLain;
        frmPenerimaanLain.ID := CDSMaster.FieldByname('Nomor').AsString;
        frmPenerimaanLain.FLAGEDIT := True;
        frmPenerimaanLain.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
        frmPenerimaanLain.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

     end;
     frmPenerimaanLain.Show;
   end;

  if pos(UpperCase('FP'),UpperCase(CDSMaster.FieldByname('NOMOR').AsString)) > 0  then
  begin
  if ActiveMDIChild.Caption <> 'Faktur Penjualan' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFP  := frmmenu.ShowForm(TfrmFP) as TfrmFP;
      frmFP.ID := CDSMaster.FieldByname('Nomor').AsString;;
      frmFP.FLAGEDIT := True;
      frmFP.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;;
      frmFP.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
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
  if pos(UpperCase('CR'),UpperCase(CDSMaster.FieldByname('NOMOR').AsString)) > 0  then
  begin
  if ActiveMDIChild.Caption <> 'Pembayaran Customer' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBayarCustomer  := frmmenu.ShowForm(TfrmBayarCustomer) as TfrmBayarCustomer;
      frmBayarCustomer.ID := CDSMaster.FieldByname('Nomor').AsString;;
      frmBayarCustomer.FLAGEDIT := True;
      frmBayarCustomer.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmBayarCustomer.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
//      if cekbayar(CDS.FieldByname('Invoice').AsString) = 1 then
//      begin
//        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
        frmBayarCustomer.cxButton2.Enabled :=False;
        frmBayarCustomer.cxButton1.Enabled :=False;

//      end;
   end;
   frmBayarCustomer.Show;
 end;
  if pos(UpperCase('JUR'),UpperCase(CDSMaster.FieldByname('NOMOR').AsString)) > 0  then
  begin

   if ActiveMDIChild.Caption <> 'Jurnal Umum' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmjurnalumum  := frmmenu.ShowForm(Tfrmjurnalumum) as Tfrmjurnalumum;
      frmjurnalumum.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmjurnalumum.FLAGEDIT := True;
      frmjurnalumum.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmjurnalumum.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      if CDSMaster.FieldByname('IsClosed').AsString = 'Sudah' then
      begin
        ShowMessage('Transaksi ini sudah tutup Periode,Tidak dapat di edit');
        frmjurnalumum.cxButton2.Enabled :=False;
        frmjurnalumum.cxButton1.Enabled :=False;
      end;
   end;
   frmjurnalumum.Show;
 END;
  if pos(UpperCase('VP'),UpperCase(CDSMaster.FieldByname('NOMOR').AsString)) > 0  then
  begin

   if ActiveMDIChild.Caption <> 'Pembayaran Supplier' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBayarSupplier  := frmmenu.ShowForm(TfrmBayarSupplier) as TfrmBayarSupplier;
      frmBayarSupplier.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmBayarSupplier.FLAGEDIT := True;
      frmBayarSupplier.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmBayarSupplier.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmBayarSupplier.Show;
  END;
end;

procedure TfrmListKas2.cxButton3Click(Sender: TObject);
  var
  s: string ;
  ftsreport : TTSReport;
   tt:TStrings;
   i:integer;
begin
s:='delete from tampungkasharian';
// xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
  CDSMaster.First;
  tt := TStringList.Create;
  i:=1;
  while not CDSMaster.Eof do
  begin
    S:='insert into tampungkasharian (no,keterangan,debet,kredit,saldo) values ('
      + IntToStr(i) + ','
      + Quot(CDSMaster.FieldByName('keterangan').AsString) +','
      + FloatToStr(cVarToFloat(CDSMaster.FieldByName('debet').AsFloat))+','
      + FloatToStr(cVarToFloat(CDSMaster.FieldByName('kredit').AsFloat))+','
      + FloatToStr(cVarToFloat(CDSMaster.FieldByName('saldo').AsFloat))
      + ');';
    tt.Append(s);
    inc(i);
    CDSMaster.Next;

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

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'KASHARIAN';
          s:= 'select '
          + Quot(VarToStr(cxLookupRekeningCash.Text)) + ' as filter ,'
          + Quot(FormatDateTime('dd/mm/yyyy',startdate.DateTime)) + ' as tgl , '
          + ' keterangan,debet,kredit,saldo from tampungkasharian where keterangan ='+quot('Saldo Awal');
    ftsreport.AddSQL(s);
          s:= 'select '
          + Quot(VarToStr(cxLookupRekeningCash.Text)) + ' as filter ,'
          + Quot(FormatDateTime('dd/mm/yyyy',startdate.DateTime)) + ' as tgl , '
          + ' keterangan,debet,kredit,saldo from tampungkasharian where debet > 0 ';
    ftsreport.AddSQL(s);
          s:= 'select '
          + Quot(VarToStr(cxLookupRekeningCash.Text)) + ' as filter ,'
          + Quot(FormatDateTime('dd/mm/yyyy',startdate.DateTime)) + ' as tgl , '
          + ' keterangan,debet,kredit,saldo from tampungkasharian where kredit > 0 ';
    ftsreport.AddSQL(s);
          s:= 'select '
          + Quot(VarToStr(cxLookupRekeningCash.Text)) + ' as filter ,'
          + Quot(FormatDateTime('dd/mm/yyyy',startdate.DateTime)) + ' as tgl , '
          + ' keterangan,debet,kredit,saldo from tampungkasharian order by no desc limit 1 ';
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;


end.
