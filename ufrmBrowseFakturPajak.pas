unit ufrmBrowseFakturPajak;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmCxBrowse, Menus, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
   dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, frxClass,
  frxExportPDF, MyAccess;

type
  TfrmBrowseFakturPajak = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    SaveDialog1: TSaveDialog;
    cxButton9: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseFakturPajak: TfrmBrowseFakturPajak;

implementation
   uses ufrmFakturPajak2,ufrmFakturPajak,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseFakturPajak.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select fp_nomor Nomor,fp_tanggal Tanggal ,fp_Memo Memo ,sls_nama Salesman,cus_nama  Customer, '
                  + ' fp_amount Total,fp_taxamount Ppn, '
                  + ' ((Fp_disc_fakturpr*(((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100))/100) + fp_disc_faktur  Disc_Faktur'
                  + ' , fp_fakturpajak FakturPajak , fp_tanggalpajak TglPajak,Ismanual,tfakturpajak_hdr.date_create'
                  + ' from tfakturpajak_hdr'
                  + ' inner join tcustomer on cus_kode=fp_cus_kode'
                  + ' left join tdo_hdr on fp_do_nomor=do_nomor '
                  + ' left join tso_hdr on do_so_nomor=so_nomor '
                  + ' left JOIN Tsalesman on sls_kode=so_sls_kode'
                  + ' where tfakturpajak_hdr.date_create between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by fp_nomor ,fp_tanggal ,fp_memo ,cus_nama '
                  + ' order by fp_fakturpajak';


  Self.SQLDetail := 'select fp_nomor Nomor,brg_kode Kode , brg_nama Nama,fpd_brg_satuan Satuan,fpd_qty Jumlah,fpd_harga Harga,fpd_discpr Disc,'
                    + ' (fpd_harga*fpd_qty*(100-fpd_discpr)/100) Nilai'
                    + ' from tfakturpajak_dtl'
                    + ' inner join tfakturpajak_hdr on fpd_fp_nomor =fp_nomor'
                    + ' inner join tbarang on fpd_brg_kode=brg_kode'
                    + ' where tfakturpajak_hdr.date_create between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' and fpd_qty > 0 '
                    + ' order by fp_nomor ' ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=200;



    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseFakturPajak.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;                                                   
  enddate.DateTime :=enddate.DateTime +1 ;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseFakturPajak.cxButton2Click(Sender: TObject);
var
  frmFakturPajak: TfrmFakturPajak;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Faktur Pajak ' then
   begin
      frmFakturPajak  := frmmenu.ShowForm(TfrmFakturPajak) as TfrmFakturPajak;

   end;
   frmFakturPajak.Show;
end;

procedure TfrmBrowseFakturPajak.cxButton1Click(Sender: TObject);
var
  frmFakturPajak: TfrmFakturPajak;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Faktur Pajak' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFakturPajak  := frmmenu.ShowForm(TfrmFakturPajak) as TfrmFakturPajak;
      frmFakturPajak.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmFakturPajak.FLAGEDIT := True;
      frmFakturPajak.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      IF CDSMaster.FieldByName('ismanual').AsInteger= 1 then
       frmFakturPajak.chkManual.Checked := true;
      frmFakturPajak.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
   end;
   frmFakturPajak.Show;
end;

procedure TfrmBrowseFakturPajak.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseFakturPajak.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmFakturPajak') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tfakturpajak_dtl '
        + ' where fpd_fp_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

       s:='delete from tfakturpajak_hdr '
        + ' where fp_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


      CDSMaster.Delete;
   except
     MessageDlg('Gagal Hapus',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);

end;


procedure TfrmBrowseFakturPajak.cxButton3Click(Sender: TObject);
var
newFile : TextFile;
tsql : TMyQuery;
tsql2 : TMyQuery;
s : string ;
anamanpwp,aalamatnpwp : string;
begin
  if SaveDialog1.Execute then
  begin
    System.AssignFile(newFile, SaveDialog1.FileName);
    System.Rewrite(newFile);
    WriteLn(newFile, '"FK","KD_JENIS_TRANSAKSI","FG_PENGGANTI","NOMOR_FAKTUR","MASA_PAJAK","TAHUN_PAJAK","TANGGAL_FAKTUR","NPWP","NAMA","ALAMAT_LENGKAP","JUMLAH_DPP","JUMLAH_PPN","JUMLAH_PPNBM","ID_KETERANGAN_TAMBAHAN","FG_UANG_MUKA",'
    + '"UANG_MUKA_DPP","UANG_MUKA_PPN","UANG_MUKA_PPNBM","REFERENSI","KODE_DOKUMEN_PENDUKUNG"');
    WriteLn(newFile, '"LT","NPWP","NAMA","JALAN","BLOK","NOMOR","RT","RW","KECAMATAN","KELURAHAN","KABUPATEN","PROPINSI","KODE_POS","NOMOR_TELEPON"');
    WriteLn(newFile, '"OF","KODE_OBJEK","NAMA","HARGA_SATUAN","JUMLAH_BARANG","HARGA_TOTAL","DISKON","DPP","PPN","TARIF_PPNBM","PPNBM"');
  CDSMaster.Filter := cxGrdMaster.DataController.Filter.FilterText;
  CDSMaster.Filtered := True;
  CDSMaster.First;

  while not CDSMaster.EOF do
  begin

  s:= 'select perush_npwp,perush_nama_NPWP,PERUSH_ALNPWP FROM TPERUSAHAAN ';
  tsql2:=xOpenQuery(s,frmMenu.conn);
  with tsql2 do
  begin
    try
      if not eof then
      begin
        anamanpwp := fieldbyname('perush_nama_npwp').AsString;
        aalamatnpwp := fieldbyname('perush_alnpwp').AsString;
      end;
    finally
      free;
    end;
  end;
 if CDSMaster.FieldByname('ismanual').AsString = '1' then
 begin
    S:= ' select cast("FK" as char(30)) AS FK,'
      + ' cast(LEFT(REPLACE(FP_FAKTURPAJAK,".",""),2) as char(30)) AS KD_JENIS_TRANSAKSI,'
      + ' cast(substr(REPLACE(FP_FAKTURPAJAK,".",""),3,1) as char(30)) AS FG_PENGGANTI,'
      + ' cast(REPLACE(FP_FAKTURPAJAK,".","") aS CHAR(60)) AS NOMOR_FAKTUR,'
      + ' EXTRACT(MONTH FROM FP_TANGGALPAJAK) AS MASA_PAJAK,EXTRACT(YEAR FROM FP_TANGGALPAJAK) AS TAHUN_PAJAK,'
      + ' date_format(FP_tanggalPAJAK,"%d/%m/%Y") AS TANGGAL_FAKTUR,'
      + ' replace(replace(CUS_NPWP,".",""),"-","") NPWP,replace(replace(CUS_NPWP,".",""),"-","") NPWP2,cus_namanpwp NAMA,CUS_ALAMATNPWP AS ALAMAT_LENGKAP,0 AS JUMLAH_PPNBM,'
      + ' cast(if(SUBSTR(FP_FAKTURPAJAK,1,3)<>"070","","5") as char(30)) AS ID_KETERANGAN_TAMBAHAN,'
      + ' 0 AS FG_UANG_MUKA,0 AS UANG_MUKA_DPP,0 AS UANG_MUKA_PPN,0 AS UANG_MUKA_PPNBM,'
      + ' CAST(if(SUBSTR(FP_FAKTURPAJAK,1,3)<>"070",fp_NOMOR,CONCAT(FP_NOMOR," PPN DITANGGUNG PEMERINTAH EKSEKUSI PMK NOMOR 226/PMK.03/2021"))  AS CHAR(80)) AS REFERENSI,'
      + ' CAST("0" AS CHAR(80)) AS KODE_DOKUMEN_PENDUKUNG,'
      + ' cast("FAPR" as char(30)) AS LT,'
      + ' cast("0" as char(30)) AS JALAN,cast("" as char(30)) AS BLOK,cast("" as char(30)) AS NOMOR,'
      + ' cast("" as char(30)) AS RT,cast("" as char(30)) AS RW,cast("0" as char(30)) AS KECAMATAN,'
      + ' cast("0" as char(30)) AS KELURAHAN,'
      + ' cast("0" as char(30)) AS KABUPATEN,cast("0" as char(30)) AS PROPINSI,'
      + ' cast("0" as char(30)) AS KODE_POS, cast("0" as char(30)) AS NOMOR_TELEPON, cast("OF" as char(30)) AS "OF",'
      + ' CAST(fpd_brg_kode AS CHAR(30)) AS KODE_OBJEK,'
      + ' CAST(ifnull(fpd_brg_nama ,brg_nama) AS CHAR(40)) AS NAMABARANG,CAST(fpD_HARGA AS DECIMAL(16,3))AS HARGA_SATUAN,'
      + ' CAST(fpD_qty*fpD_HARGA AS DECIMAL(16,3)) AS HARGA_TOTAL,CAST((fpd_discpr*(fpd_harga*fpd_qty)/100)  AS DECIMAL(16,3)) AS DISKON,'
      + ' (select floor(fp_amount)/if(fp_tanggal<"2022/04/01",1.1,1.11) FROM Tfp_hdr_bayangan WHERE fp_nomor=Z.fp_nomor)  AS DPP,'
      + ' (select floor(fp_taxamount) FROM Tfp_hdr_bayangan WHERE fp_nomor=Z.fp_nomor)  AS PPNTOTAL,'
      + ' CAST(if(fp_tanggal<"2022/04/01",0.1,0.11) * (fpD_qty* fpD_HARGA)*(100-fpd_discpr)/100  AS DECIMAL(16,3)) AS PPN,'
      + ' CAST(fpD_qty*fpD_HARGA*(100-fpd_discpr)/100 AS DECIMAL(16,3)) AS HARGA_TOTAL2,'
      + ' CAST(0 AS DECIMAL) AS TARIF_PPNBM,'
      + ' CAST(0 AS DECIMAL) AS PPNBM,'
      + ' CAST(fpD_qty AS DECIMAL) AS JUMLAH_BARANG'
      + ' from'
      + ' tFAKTURPAJAK_hdr Z'
      + ' inner join tcustomer on cus_kode=fp_cus_kode'
      + ' inner join tfakturpajak_dtl on fpd_fp_nomor=fp_nomor'
      + ' left join tbarang on brg_kode=fpd_brg_kode'
      + ' WHERE fp_nomor = ' + Quot(CDSMaster.FieldByname('Nomor').AsString);
   end
   else
   begin
     S:= ' select cast("FK" as char(30)) AS FK,'
      + ' cast(LEFT(REPLACE(FP_FAKTURPAJAK,".",""),2) as char(30)) AS KD_JENIS_TRANSAKSI,'
      + ' cast(substr(REPLACE(FP_FAKTURPAJAK,".",""),3,1) as char(30)) AS FG_PENGGANTI,'
      + ' cast(REPLACE(FP_FAKTURPAJAK,".","") aS CHAR(60)) AS NOMOR_FAKTUR,'
      + ' EXTRACT(MONTH FROM FP_TANGGALPAJAK) AS MASA_PAJAK,EXTRACT(YEAR FROM FP_TANGGALPAJAK) AS TAHUN_PAJAK,'
      + ' date_format(FP_tanggalPAJAK,"%d/%m/%Y") AS TANGGAL_FAKTUR,'
      + ' replace(replace(CUS_NPWP,".",""),"-","") NPWP,replace(replace(CUS_NPWP,".",""),"-","") NPWP2,cus_namanpwp NAMA,CUS_ALAMATNPWP AS ALAMAT_LENGKAP,0 AS JUMLAH_PPNBM,'
      + ' cast(if(SUBSTR(FP_FAKTURPAJAK,1,3)<>"070","","5") as char(30)) AS ID_KETERANGAN_TAMBAHAN,'
      + ' 0 AS FG_UANG_MUKA,0 AS UANG_MUKA_DPP,0 AS UANG_MUKA_PPN,0 AS UANG_MUKA_PPNBM,'
      + ' CAST(if(SUBSTR(FP_FAKTURPAJAK,1,3)<>"070",fp_NOMOR,CONCAT(FP_NOMOR," PPN DITANGGUNG PEMERINTAH EKSEKUSI PMK NOMOR 226/PMK.03/2021"))  AS CHAR(80)) AS REFERENSI,'
      + ' CAST("0" AS CHAR(80)) AS KODE_DOKUMEN_PENDUKUNG,'
      + ' cast("FAPR" as char(30)) AS LT,'
      + ' cast("0" as char(30)) AS JALAN,cast("" as char(30)) AS BLOK,cast("" as char(30)) AS NOMOR,'
      + ' cast("" as char(30)) AS RT,cast("" as char(30)) AS RW,cast("0" as char(30)) AS KECAMATAN,'
      + ' cast("0" as char(30)) AS KELURAHAN,'
      + ' cast("0" as char(30)) AS KABUPATEN,cast("0" as char(30)) AS PROPINSI,'
      + ' cast("0" as char(30)) AS KODE_POS, cast("0" as char(30)) AS NOMOR_TELEPON, cast("OF" as char(30)) AS "OF",'
      + ' CAST(fpd_brg_kode AS CHAR(30)) AS KODE_OBJEK,'
      + ' CAST(ifnull(fpd_brg_nama ,brg_nama) AS CHAR(40)) AS NAMABARANG,CAST(fpD_HARGA AS DECIMAL(16,3))AS HARGA_SATUAN,'
      + ' CAST(fpD_qty*fpD_HARGA AS DECIMAL(16,3)) AS HARGA_TOTAL,CAST((fpd_discpr*(fpd_harga*fpd_qty)/100)  AS DECIMAL(16,3)) AS DISKON,'
      + ' floor(fp_amount/if(fp_tanggal<"2022/04/01",1.1,1.11) )  as DPP,'
      + ' floor(fp_taxamount )  as ppntotal,'
//      + ' (select floor(fp_amount-ifnull(retj_amount))/if(fp_tanggal<"2022/04/01",1.1,1.11) FROM Tfp_hdr left join tretj_hdr on retj_fp_nomor=fp_nomor WHERE fp_nomor=Z.fp_nomor)  AS DPP,'
  //    + ' (select floor(fp_taxamount) FROM Tfp_hdr WHERE fp_nomor=Z.fp_nomor)  AS PPNTOTAL,'
      + ' CAST(if(fp_tanggal<"2022/04/01",0.1,0.11) * (fpD_qty* fpD_HARGA)*(100-fpd_discpr)/100  AS DECIMAL(16,3)) AS PPN,'
      + ' CAST(fpD_qty*fpD_HARGA*(100-fpd_discpr)/100 AS DECIMAL(16,3)) AS HARGA_TOTAL2,'
      + ' CAST(0 AS DECIMAL) AS TARIF_PPNBM,'
      + ' CAST(0 AS DECIMAL) AS PPNBM,'
      + ' CAST(fpD_qty AS DECIMAL) AS JUMLAH_BARANG'
      + ' from'
      + ' tFAKTURPAJAK_hdr Z'
      + ' inner join tcustomer on cus_kode=fp_cus_kode'
      + ' inner join tfakturpajak_dtl on fpd_fp_nomor=fp_nomor'
      + ' left join tbarang on brg_kode=fpd_brg_kode'
      + ' WHERE fp_nomor = ' + Quot(CDSMaster.FieldByname('Nomor').AsString);
   end;

      tsql :=xOpenQuery(s,frmMenu.conn);
      with tsql do
      begin
        try
          if not tsql.eof then
          begin
            WriteLn(newFile, '"'+fieldbyname('FK').asstring + '","'+ fieldbyname('KD_JENIS_TRANSAKSI').asstring + '","'
            + fieldbyname('FG_PENGGANTI').asstring+'","'+COPY(fieldbyname('NOMOR_FAKTUR').asstring,4,Length(fieldbyname('NOMOR_FAKTUR').asstring)-3) + '","'
            + fieldbyname('MASA_PAJAK').asstring + '","' + fieldbyname('TAHUN_PAJAK').asstring + '","' +fieldbyname('TANGGAL_FAKTUR').asstring +'","'
            + fieldbyname('NPWP').asstring + '","' +fieldbyname('NAMA').asstring+'","' + FieldByName('ALAMAT_LENGKAP').AsString +'","'
            + formatfloat('##########',fieldByName('DPP').asfloat) +'","' + formatfloat('#########',FieldByName('PPNTOTAL').asfloat)+'","'
            + FieldByName('JUMLAH_PPNBM').AsString+'","'+ FieldByName('ID_KETERANGAN_TAMBAHAN').AsString + '","'
            + FieldByName('FG_UANG_MUKA').AsString+'","'+fieldbyname('UANG_MUKA_DPP').AsString+'","'
            + FieldByName('UANG_MUKA_PPN').AsString+'","'+fieldbyname('UANG_MUKA_PPNBM').AsString+'","'+fieldbyname('REFERENSI').AsString +'","0"');


            WriteLn(newFile,'"'+ fieldbyname('LT').asstring + '","'
            + anamanpwp+'","'+aalamatnpwp+ '",'
            + fieldbyname('BLOK').asstring + ',' + fieldbyname('NOMOR').asstring + ',' +fieldbyname('RT').asstring +','
            + fieldbyname('RW').asstring);

          end;
          tsql.First;
          while not tsql.eof do
          begin

            WriteLn(newFile,'"'+ fieldbyname('OF').asstring + '","'+ fieldbyname('KODE_OBJEK').asstring + '","'
            + fieldbyname('NAMABARANG').asstring+'","'+fieldbyname('HARGA_SATUAN').asstring + '","'
            + fieldbyname('JUMLAH_BARANG').asstring + '","' + fieldbyname('HARGA_TOTAL').asstring + '","' +fieldbyname('DISKON').asstring +'","'
            + fieldbyname('HARGA_TOTAL2').asstring + '","' +fieldbyname('PPN').asstring+'","' + FieldByName('TARIF_PPNBM').AsString +'","'
            + FieldByName('PPNBM').AsString+'"');



            next;
          end;
        finally
          free;
        end;


    end;
    CDSMaster.Next;
    end;
      System.CloseFile(newFile);
  end;
end;

procedure TfrmBrowseFakturPajak.cxButton9Click(Sender: TObject);
var
  frmFakturPajak2: TfrmFakturPajak2;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Faktur Pajak Versi 2' then
   begin
      frmFakturPajak2  := frmmenu.ShowForm(TfrmFakturPajak2) as TfrmFakturPajak2;

   end;
   frmFakturPajak2.Show;
end;

end.
