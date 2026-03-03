unit ufrmListKas;

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
  TfrmListKas = class(TfrmCxBrowse)
    cxLookupRekeningCash: TcxExtLookupComboBox;
    Label3: TLabel;
    PopupMenu1: TPopupMenu;
    LihatFakturPenjualan1: TMenuItem;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LihatFakturPenjualan1Click(Sender: TObject);
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
  frmListKas: TfrmListKas;

implementation
   uses Ulib, MAIN, uModuleConnection,ufrmPembayaranLain,ufrmFP,ufrmBayarCustomer,ufrmPenerimaanLain,
  ufrmPencairanGiro, ufrmJurnalUmum, ufrmBayarSupplier;
{$R *.dfm}

procedure TfrmListKas.btnRefreshClick(Sender: TObject);
var
  xdebet,xkredit,xsaldo : Double;
  i:integer;
begin

// Self.SQLMaster :='select "" Nomor,'+quot(FormatDateTime('yyyy-mm-dd',startdate.datetime)) +' Tanggal,"Saldo Awal" Keterangan,"" Rekening,0 Debet, 0 Kredit, ifnull(sum(jurd_debet-jurd_kredit),0) Saldo,"" Memo '
//                  + ' from tjurnalitem inner join tjurnal'
//                  + ' on jurd_jur_no=jur_no where '
//                  + ' jurd_rek_kode= '+quot(vartostr(cxlookupRekeningcash.editvalue))+' and jur_tanggal < '+quotd(startdate.DateTime)
//                  + ' union'
//                  + ' select nomor,tanggal,Keterangan,Rekening,Debet,kredit,saldo,Memo from ('
//                  + ' SELECT jurd_jur_no Nomor, DATE_FORMAT(tanggal,"%Y-%m-%d") Tanggal, jurd_keterangan Keterangan,rek_nama Rekening,'
//                  + ' jurd_kredit Debet,jurd_debet Kredit, 0 Saldo,cc Memo,'
//                  + ' case when debet > 0 then (select count(*) from tjurnalitem where jurd_jur_no=a.nomor and jurd_debet>0)'
//                  + ' else (select count(*) from tjurnalitem where jurd_jur_no=a.nomor  and jurd_kredit>0) end sendiri'
//                  + ' FROM tjurnalitem b'
//                  + ' INNER JOIN ('
//                  + ' SELECT jurd_jur_no nomor,jur_tanggal tanggal,jur_tipetransaksi,jur_keterangan,jurd_debet debet,jurd_kredit kredit,jurd_cc_kode cc'
//                  + ' FROM tjurnalitem'
//                  + ' INNER JOIN tjurnal ON jurd_jur_no=jur_no'
//                  + ' WHERE jurd_rek_kode= '+ quot(VarToStr(cxlookupRekeningcash.editvalue))+ ' AND jur_tanggal BETWEEN '+quotd(startdate.DateTime)+' and '+quotd(enddate.DateTime)+ ') a ON b.jurd_jur_no=a.nomor'
//                  + ' INNER JOIN trekening ON rek_kode=jurd_rek_kode'
//                  + ' LEFT JOIN tbayarcus_hdr ON byc_nomor=jurd_jur_no'
//                  + ' LEFT JOIN tcustomer ON byc_cus_kode=cus_kode'
//                  + ' WHERE jurd_rek_kode <> ' + quot(VarToStr(cxlookupRekeningcash.editvalue))
//                  + ' having   sendiri = 1'
//                  + ' union'
//                  + ' SELECT DISTINCT jurd_jur_no Nomor, DATE_FORMAT(tanggal,"%Y-%m-%d") Tanggal, jur_keterangan Keterangan,'
//                  + ' (case when a.debet > 0'
//                  + ' then'
//                  + ' (select rek_nama from tjurnalitem inner join trekening on rek_kode=jurd_rek_kode where jurd_jur_no=b.jurd_jur_no and jurd_kredit > 0  limit 1) else'
//                  + ' (select rek_nama from tjurnalitem inner join trekening on rek_kode=jurd_rek_kode where jurd_jur_no=b.jurd_jur_no and jurd_debet > 0  limit 1) end'
//                  + ' ) Rekening,'
//                  + ' case when a.debet > 0 then  a.debet else 0 end Kredit,'
//                  + ' case when a.kredit > 0 then  a.kredit else 0 end Debet,'
//                  + ' 0 Saldo,cc Memo,'
//                  + ' case when debet > 0 then (select count(*) from tjurnalitem where jurd_jur_no=a.nomor and jurd_debet>0)'
//                  + ' else (select count(*) from tjurnalitem where jurd_jur_no=a.nomor  and jurd_kredit>0) end sendiri'
//                  + ' FROM tjurnalitem b'
//                  + ' INNER JOIN ('
//                  + ' SELECT jurd_jur_no nomor,jur_tanggal tanggal,jur_tipetransaksi,jur_keterangan,jurd_debet debet,jurd_kredit kredit,jurd_cc_kode cc'
//                  + ' FROM tjurnalitem'
//                  + ' INNER JOIN tjurnal ON jurd_jur_no=jur_no'
//                  + ' WHERE jurd_rek_kode= ' + quot(VarToStr(cxlookupRekeningcash.editvalue)) + ' AND jur_tanggal BETWEEN '+quotd(startdate.DateTime)+' and '+quotd(enddate.DateTime)+ ') a ON b.jurd_jur_no=a.nomor'
//                  + ' INNER JOIN trekening ON rek_kode=jurd_rek_kode'
//                  + ' LEFT JOIN tbayarcus_hdr ON byc_nomor=jurd_jur_no'
//                  + ' LEFT JOIN tcustomer ON byc_cus_kode=cus_kode'
//                  + ' WHERE jurd_rek_kode <> ' + quot(VarToStr(cxlookupRekeningcash.editvalue))
//                  + ' having sendiri > 1) final order by tanggal,nomor ';

 Self.SQLMaster :='select "" Nomor,'+quot(FormatDateTime('yyyy-mm-dd',startdate.datetime)) +' Tanggal,"Saldo Awal" Keterangan,"" Rekening,0 Debet, 0 Kredit, ifnull(sum(jurd_debet-jurd_kredit),0) Saldo,"" Memo '
                  + ' from tjurnalitem inner join tjurnal'
                  + ' on jurd_jur_no=jur_no where '
                  + ' jurd_rek_kode= '+quot(vartostr(cxlookupRekeningcash.editvalue))+' and jur_tanggal < '+quotd(startdate.DateTime)
                  + ' union'
                  + ' select nomor,tanggal,Keterangan,Rekening,Debet,kredit,saldo,'
                  + ' if(nomor like "VP%",(select sup_nama from tbayarsup_hdr inner join tsupplier on sup_kode=bys_sup_kode where bys_nomor=nomor),'
                  + ' if(nomor like "%CR%",(SELECT cus_nama from tbayarcus_hdr inner join tcustomer on cus_kode=byc_cus_kode where byc_nomor=nomor),Memo)) Memo'
                  + ' from ('
                  + ' SELECT jurd_jur_no Nomor, DATE_FORMAT(tanggal,"%Y-%m-%d") Tanggal, jurd_keterangan Keterangan,rek_nama Rekening,'
                  + ' jurd_kredit Debet,jurd_debet Kredit, 0 Saldo,cc Memo,'
                  + ' case when debet <> 0 then (select count(*) from tjurnalitem where jurd_jur_no=a.nomor and jurd_debet <> 0)'
                  + ' else (select count(*) from tjurnalitem where jurd_jur_no=a.nomor  and jurd_kredit <> 0) end sendiri'
                  + ' FROM tjurnalitem b'
                  + ' INNER JOIN ('
                  + ' SELECT jurd_jur_no nomor,jur_tanggal tanggal,jur_tipetransaksi,jur_keterangan,jurd_debet debet,jurd_kredit kredit,(select sup_nama from tsupplier where  jurd_cus_kode=sup_kode limit 1) cc '
                  + ' FROM tjurnalitem'
                  + ' INNER JOIN tjurnal ON jurd_jur_no=jur_no'
                  + ' WHERE jurd_rek_kode= '+ quot(VarToStr(cxlookupRekeningcash.editvalue))+ ' AND jur_tanggal BETWEEN '+quotd(startdate.DateTime)+' and '+quotd(enddate.DateTime)+ ') a ON b.jurd_jur_no=a.nomor'
                  + ' INNER JOIN trekening ON rek_kode=jurd_rek_kode'
                  + ' LEFT JOIN tbayarcus_hdr ON byc_nomor=jurd_jur_no'
                  + ' LEFT JOIN tcustomer ON byc_cus_kode=cus_kode'
                  + ' WHERE jurd_rek_kode <> ' + quot(VarToStr(cxlookupRekeningcash.editvalue))
                  + ' having   sendiri = 1'
                  + ' union'
                  + ' SELECT DISTINCT jurd_jur_no Nomor, DATE_FORMAT(tanggal,"%Y-%m-%d") Tanggal, jur_keterangan Keterangan,'
                  + ' (case when a.debet > 0'
                  + ' then'
                  + ' (select rek_nama from tjurnalitem inner join trekening on rek_kode=jurd_rek_kode where jurd_jur_no=b.jurd_jur_no and jurd_kredit > 0  limit 1) else'
                  + ' (select rek_nama from tjurnalitem inner join trekening on rek_kode=jurd_rek_kode where jurd_jur_no=b.jurd_jur_no and jurd_debet > 0  limit 1) end'
                  + ' ) Rekening,'
                  + ' case when a.debet > 0 then  a.debet else 0 end Kredit,'
                  + ' case when a.kredit > 0 then  a.kredit else 0 end Debet,'
                  + ' 0 Saldo,cc Memo,'
                  + ' case when debet > 0 then (select count(*) from tjurnalitem where jurd_jur_no=a.nomor and jurd_debet>0)'
                  + ' else (select count(*) from tjurnalitem where jurd_jur_no=a.nomor  and jurd_kredit>0) end sendiri'
                  + ' FROM tjurnalitem b'
                  + ' INNER JOIN ('
                  + ' SELECT jurd_jur_no nomor,jur_tanggal tanggal,jur_tipetransaksi,jur_keterangan,jurd_debet debet,jurd_kredit kredit,(SELECT sup_nama FROM tsupplier WHERE jurd_cus_kode=sup_kode LIMIT 1)  cc '
                  + ' FROM tjurnalitem'
                  + ' INNER JOIN tjurnal ON jurd_jur_no=jur_no'
                  + ' WHERE jurd_rek_kode= ' + quot(VarToStr(cxlookupRekeningcash.editvalue)) + ' AND jur_tanggal BETWEEN '+quotd(startdate.DateTime)+' and '+quotd(enddate.DateTime)+ ') a ON b.jurd_jur_no=a.nomor'
                  + ' INNER JOIN trekening ON rek_kode=jurd_rek_kode'
                  + ' LEFT JOIN tbayarcus_hdr ON byc_nomor=jurd_jur_no'
                  + ' LEFT JOIN tcustomer ON byc_cus_kode=cus_kode'
                  + ' WHERE jurd_rek_kode <> ' + quot(VarToStr(cxlookupRekeningcash.editvalue))
                  + ' having sendiri > 1) final order by tanggal,nomor ';


   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=100;
    cxGrdMaster.Columns[5].Width :=100;
    cxGrdMaster.Columns[6].Width :=100;
    cxGrdMaster.Columns[5].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[5].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[4].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[4].Summary.FooterFormat:='###,###,###,###';
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

procedure TfrmListKas.FormShow(Sender: TObject);
begin
  ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmListKas.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

function TfrmListKas.GetCDSRekeningCash: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSRekeningCash) then
  begin
    S := 'select rek_nama as Rekening, rek_kode Kode '
        +' from trekening WHERE rek_nama not like '+QuotedStr('%Laba%');


    FCDSRekeningCash := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSRekeningCash;
end;

procedure TfrmListKas.FormCreate(Sender: TObject);
begin
  inherited;
    with TcxExtLookupHelper(cxLookupRekeningCash.Properties) do
    LoadFromCDS(CDSRekeningCash, 'Kode','Rekening',['Kode'],Self);

end;

procedure TfrmListKas.LihatFakturPenjualan1Click(Sender: TObject);
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

end.
