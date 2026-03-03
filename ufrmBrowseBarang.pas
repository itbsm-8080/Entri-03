unit ufrmBrowseBarang;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseBarang = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseBarang: TfrmBrowseBarang;

implementation
   uses ufrmbarang,Ulib, MAIN, uModuleConnection,ureport;
{$R *.dfm}

procedure TfrmBrowseBarang.btnRefreshClick(Sender: TObject);
begin

  Self.SQLMaster := ' select brg_kode Kode ,brg_nama Nama,brg_satuan Satuan,ktg_nama Kategori,'
                  + ' gr_nama Tipe,'
                  + ' (SELECT mst_hargabeli FROM tmasterstok WHERE mst_brg_kode=brg_kode AND mst_noreferensi LIKE "%KOR%" AND mst_gdg_kode LIKE "GJ%" order by mst_tanggal desc LIMIT 1) Hpp_Terakhir,'
                  + ' brg_hrgjual HargaJual,(select sum(mst_stok_in-mst_stok_out) from tmasterstok where mst_brg_kode=brg_kode) Stok ,'
                  + ' brg_lastcost Lastcost,brg_hrgbeli HargaBeli,sup_nama Supplier,'
                  + ' ifnull(totalbahan,0) Adakomposisi '
                  + ' from tbarang '
                  + ' inner join tkategori on ktg_kode=brg_ktg_kode'
                  + ' inner join tgroup on gr_kode=brg_gr_kode'
                  + ' left join tsupplier on sup_kode=brg_sup_kode'
                  + ' LEFT JOIN ( SELECT bk_brg_kode,COUNT(bk_bhn_kode) totalbahan FROM tbarangkomposisi'
                  + ' GROUP BY bk_brg_kode) a ON brg_kode=bk_brg_kode '
                  ;

//  Self.SQLMaster := 'select brg_kode Kode ,brg_nama Nama,brg_satuan Satuan,ktg_nama Kategori,'
//  + ' gr_nama Tipe,brg_hrgjual HargaJual,brg_Stok Stok '
//  + ' from tbarang '
//  + ' inner join tkategori on ktg_kode=brg_ktg_kode'
//  + ' inner join tgroup on gr_kode=brg_gr_kode';

Self.SQLDetail := ' select distinct invd_brg_kode Kode,invd_inv_nomor Nomor, inv_tanggal Tanggal,'
                + ' inv_sup_kode Kode_Sup , Sup_nama Supplier,invd_qty Qty,invd_harga Harga,invd_discpr Disc,(100-invd_discpr)*invd_harga/100 Harga_Net'
                + ' from tinv_dtl '
                + ' inner join tinv_hdr on inv_nomor=invd_inv_nomor'
                + ' inner join tsupplier on sup_kode=inv_sup_kode'
                + ' order by invd_brg_kode,invd_inv_nomor ' ;
 Self.MasterKeyField := 'Kode';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=80;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[3].Width :=150;
    cxGrdMaster.Columns[5].Width :=80;
    cxGrdMaster.Columns[6].Width :=80;

end;

procedure TfrmBrowseBarang.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseBarang.cxButton2Click(Sender: TObject);
var
  frmBarang: TfrmBarang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Barang' then
   begin
      frmBarang  := frmmenu.ShowForm(TfrmBarang) as TfrmBarang;
      frmBarang.edtKode.SetFocus;
      frmBarang.edtKode.Text := IntToStr(frmBarang.getmaxkode);
      frmBarang.cxLookupJenisGroup.EditValue := 1;
   end;
   frmBarang.Show;
end;

procedure TfrmBrowseBarang.cxButton1Click(Sender: TObject);
var
  frmBarang: TfrmBarang;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master CostCenter' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmBarang  := frmmenu.ShowForm(TfrmBarang) as TfrmBarang;
      frmBarang.ID := CDSMaster.FieldByname('KODE').AsString;
      frmBarang.FLAGEDIT := True;
      frmBarang.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmBarang.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmBarang.edtKode.Enabled := False;
   end;
   frmBarang.Show;
end;

procedure TfrmBrowseBarang.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseBarang.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmBarang') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tbarang '
        + ' where brg_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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

procedure TfrmBrowseBarang.cxButton3Click(Sender: TObject);

var
  tt:TStrings;
  s: string ;
  ftsreport : TTSReport;
  i:integer;
begin
  //insert temp barcode
//  tt := TStringList.Create;
//    s:= 'delete from temp_cetak_bar2 ;' ;
//      tt.Append(s);
// CDSMaster.first;
//  while not CDSMaster.Eof do
//  begin
//   if CDSmaster.FieldByName('kode').AsInteger >  0 then
//   begin
//                   s:='insert into temp_cetak_bar2 (temp_prd_kode,temp_namabarang,temp_barcode,temp_tanggal,temp_harga,temp_sat) values ('
//                  + Quot(CDSmaster.fieldbyname('kode').AsString) + ','
//                  + Quot(CDSmaster.fieldbyname('nama').AsString) + ','
//                  + Quot(CDSmaster.fieldbyname('kode').AsString) + ','
//                  + 'now(),'
//                  + FloatToStr(CDSmaster.fieldbyname('hargabeli').asfloat) + ','
//                  + Quot(CDSmaster.fieldbyname('satuan').asstring) + ');';
//               tt.Append(s);
//   end;
//    CDSmaster.Next;
//  end;
//
//      try
//        TT.SaveToFile('aa.txt');
//        for i:=0 to tt.Count -1 do
//        begin
//            xExecQuery(tt[i],frmMenu.conn);
//        end;
//      finally
//        tt.Free;
//      end;
  //---------
  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'kodebarcode2';
    showmessage(cxGrdMaster.DataController.Filter.FilterText);
    s:= ' select brg_kode ,brg_nama,brg_satuan,now(),brg_hrgbeli from tbarang limit 10' ;
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;



end.
