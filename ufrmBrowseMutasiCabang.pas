unit ufrmBrowseMutasiCabang;

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
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, FMTBcd, Provider, SqlExpr, ImgList,
  ComCtrls, StdCtrls, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, MyAccess;

type
  TfrmBrowseMutasiCabang = class(TfrmCxBrowse)
    SaveDialog1: TSaveDialog;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseMutasiCabang: TfrmBrowseMutasiCabang;

implementation
   uses ufrmMutasiCabang,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseMutasiCabang.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select mutc_nomor Nomor,mutc_Tanggal Tanggal ,c.cbg_nama Asal,b.cbg_nama Tujuan,gdg_nama Gudang, mutc_keterangan Keterangan'
                  + ' from tmutcab_hdr  a '
                  + ' inner join  tcabang b on b.cbg_kode=a.mutc_cbg_tujuan '
                  + ' inner join tcabang c on c.cbg_kode =a.mutc_cbg_asal '
                  + ' inner join tgudang d on d.gdg_kode= a.mutc_gdg_kode '
                  + ' where mutc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' AND a.mutc_cbg_asal = ' + Quot(frmMenu.KDCABANG)
                  + ' group by mutc_nomor ,mutc_tanggal ,mutc_keterangan ';

  Self.SQLDetail := 'select mutc_nomor Nomor,mutcd_brg_kode Kode , brg_nama Nama,mutcd_qty Jumlah,'
                    + ' mutcd_expired Expired,mutcd_keterangan Keterangan,gdg_nama Gudang'
                    + ' from tmutcab_dtl'
                    + ' inner join tmutcab_hdr on mutc_nomor=mutcd_mutc_nomor'
                    + ' inner join tbarang on mutcd_brg_kode=brg_kode'
                    + ' inner join tgudang on gdg_kode=mutcd_gdg_kode'
                    + ' where mutc_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by mutc_nomor ,mutcd_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=100;
    cxGrdMaster.Columns[5].Width :=100;

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseMutasiCabang.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseMutasiCabang.cxButton2Click(Sender: TObject);
var
  frmMutasiCabang: TfrmMutasiCabang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Mutasi Cabang' then
   begin
      frmMutasiCabang  := frmmenu.ShowForm(TfrmMutasiCabang) as TfrmMutasiCabang;
      if frmMutasiCabang.FLAGEDIT = false then 
      frmMutasiCabang.edtNomor.Text := frmMutasiCabang.getmaxkode;
   end;
   frmMutasiCabang.Show;
end;

procedure TfrmBrowseMutasiCabang.cxButton1Click(Sender: TObject);
var
  frmMutasiCabang: TfrmMutasiCabang;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Mutasi Cabang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmMutasiCabang  := frmmenu.ShowForm(TfrmMutasiCabang) as TfrmMutasiCabang;
      frmMutasiCabang.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmMutasiCabang.FLAGEDIT := True;
      frmMutasiCabang.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmMutasiCabang.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
//      if CDSMaster.FieldByname('realisasi').AsString = 'Sudah' then
//      begin
//        ShowMessage('Transaksi ini sudah Realisasi,Tidak dapat di edit');
//        frmMutasiCabang.cxButton2.Enabled :=False;
//        frmMutasiCabang.cxButton1.Enabled :=False;
//      end;
   end;
   frmMutasiCabang.Show;
end;

procedure TfrmBrowseMutasiCabang.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseMutasiCabang.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmMutasiCabang.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseMutasiCabang.cxButton4Click(Sender: TObject);
var
  s:string;
  tt :TStrings;
  tsql :TMyQuery;
begin
  inherited;
  if SaveDialog1.Execute then
  begin
  s:= 'select * from tmutcab_hdr inner join tmutcab_dtl on mutc_nomor=mutcd_mutc_nomor and mutc_nomor = ' + Quot(CDSMaster.FieldByname('Nomor').AsString);
  tsql:= xOpenQuery(s,frmMenu.conn);
  tt:=TStringList.Create;
  with tsql do
  begin
     try
       if not Eof then
          s:= 'insert into tmutcab_hdr (mutc_nomor,mutc_tanggal,mutc_cbg_asal,mutc_cbg_tujuan,mutc_keterangan) values ('
            + Quot(fieldbyname('mutc_nomor').AsString) + ','
            + Quotd(fieldbyname('mutc_tanggal').AsDateTime) + ','
            + Quot(fieldbyname('mutc_cbg_asal').AsString) + ','
            + Quot(fieldbyname('mutc_cbg_tujuan').AsString) + ','
            + Quot(fieldbyname('mutc_keterangan').AsString) + ');' ;
         tt.Append(s);
         while not Eof do
         begin
           s:= 'insert into tmutcab_dtl (mutcd_mutc_nomor,mutcd_brg_kode,mutcd_qty,mutcd_expired,mutcd_keterangan,mutcd_harga,mutcd_nourut) values ('
            + Quot(fieldbyname('mutc_nomor').AsString) + ','
            + Quot(fieldbyname('mutcd_brg_kode').AsString) + ','
            + fieldbyname('mutcd_qty').AsString + ','
            + Quotd(fieldbyname('mutcd_expired').AsDateTime) + ','
            + Quot(fieldbyname('mutcd_keterangan').AsString) + ','
            + fieldbyname('mutcd_harga').AsString +','
            + fieldbyname('mutcd_nourut').AsString
            + ');'  ;
         tt.Append(s);

          Next;
         end;


       finally
         free;
     end;

            s:= 'select a.* from tbarang a inner join tmutcab_dtl on mutcd_brg_kode=brg_kode and mutcd_mutc_nomor = ' + Quot(CDSMaster.FieldByname('Nomor').AsString);
      tsql:= xOpenQuery(s,frmMenu.conn);

  with tsql do
  begin
     try
         while not Eof do
         begin
         s :=  ' insert ignore into tbarang '
             + ' (brg_kode,brg_nama,brg_satuan,brg_gr_kode,brg_ktg_kode,brg_gdg_DEFAULT,brg_sup_kode ,'
             + ' brg_hrgjual,brg_hrgbeli,brg_isaktif,brg_isstok,brg_isexpired,date_create,user_create'
             + ' ) '
             + ' values ( '
             + Quot(fieldbyname('brg_kode').AsString) + ','
             + Quot(fieldbyname('brg_nama').AsString) + ','
             + Quot(fieldbyname('brg_satuan').AsString) + ','
             + Quot(fieldbyname('brg_gr_kode').AsString) + ','
             + Quot(fieldbyname('brg_ktg_kode').AsString) + ','
             + Quot(fieldbyname('brg_gdg_default').AsString) + ','
             + Quot(fieldbyname('brg_sup_kode').AsString) + ','
             + FloatToStr(fieldbyname('brg_hrgjual').Asfloat) + ','
             + FloatToStr(fieldbyname('brg_hrgjual').Asfloat) + ',1,1,0,'
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+');';
         tt.Append(s);

          Next;
         end;


       finally
         free;
     end;


    
  end;

     tt.SaveToFile(SaveDialog1.FileName);
  end;
  s:='update tmutcab_hdr set mutc_status=1 where mutc_nomor ='+ Quot(CDSMaster.FieldByname('Nomor').AsString) + ';';
   // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
   // xCommit(frmMenu.conn);
  end;
end;
end.
