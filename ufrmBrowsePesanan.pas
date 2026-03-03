unit ufrmBrowsePesanan;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels,
  MyAccess, MemDS, DBAccess;

type
  TfrmBrowsePesanan = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    cxButton9: TcxButton;
    OpenDialog1: TOpenDialog;
    cxButton10: TcxButton;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    MyQuery2: TMyQuery;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekkirim(anomor:string) : integer;
    procedure cxButton10Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton9Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure bacafile;
  private
    { Private declarations }
        aDatabase2: string;
    aHost2: string;
    apassword2: string;
    auser2: string;

  public
    { Public declarations }
  end;

var
  frmBrowsePesanan: TfrmBrowsePesanan;

implementation
   uses ufrmPesanan,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowsePesanan.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select so_nomor Nomor,so_tanggal Tanggal ,so_Memo Memo ,cus_nama  Customer,if(so_isclosed=0,"Belum","Sudah") Closed, '
                  + ' so_amount Total,so_taxamount Ppn,sls_nama Salesman,if(so_iskirim=0,"Belum","Sudah") Kirim,'
                  + ' tso_hdr.User_create,tso_hdr.date_create '
                  + ' from tso_hdr'
                  + ' inner join tcustomer on trim(cus_kode)=trim(so_cus_kode)'
                  + ' left join tsalesman on sls_kode=so_sls_kode '
                  + ' where so_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by so_nomor ,so_tanggal ,so_memo ,cus_nama ';

  Self.SQLDetail := 'select so_nomor Nomor,brg_kode Kode , brg_nama Nama,sod_brg_satuan Satuan,sod_qty Jumlah,sod_harga Harga,sod_discpr Disc,'
                    + ' (sod_harga*sod_qty*(100-sod_discpr)/100) Nilai,'
                    + ' sod_qty_kirim Terkirim'
                    + ' from tso_dtl'
                    + ' inner join tso_hdr on sod_so_nomor =so_nomor'
                    + ' inner join tbarang on sod_brg_kode=brg_kode'
                    + ' where so_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by so_nomor ';

 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=80;
    cxGrdMaster.Columns[5].Width :=80;
    cxGrdMaster.Columns[6].Width :=70;
    cxGrdMaster.Columns[6].Width :=100;

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowsePesanan.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowsePesanan.cxButton2Click(Sender: TObject);
var
  frmPesanan: TfrmPesanan;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pesanan Barang' then
   begin
      frmPesanan  := frmmenu.ShowForm(TfrmPesanan) as TfrmPesanan;
      if frmPesanan.FLAGEDIT = False then
      frmPesanan.edtNomor.Text := frmPesanan.getmaxkode;
   end;
   frmPesanan.Show;
end;

procedure TfrmBrowsePesanan.cxButton1Click(Sender: TObject);
var
  frmPesanan: TfrmPesanan;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pesanan Barang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPesanan  := frmmenu.ShowForm(TfrmPesanan) as TfrmPesanan;
      frmPesanan.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmPesanan.FLAGEDIT := True;
      frmPesanan.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmPesanan.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      if cekkirim(CDSMaster.FieldByname('Nomor').AsString) = 1 then
      begin
        ShowMessage('Transaksi ini sudah ada Pengiriman,Tidak dapat di edit');
        frmPesanan.cxButton2.Enabled :=False;
        frmPesanan.cxButton1.Enabled :=False;
        frmPesanan.cxButton3.Enabled :=False;
      end;

   end;
   frmPesanan.Show;
end;

procedure TfrmBrowsePesanan.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowsePesanan.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmPesanan.doslipSO(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowsePesanan.cekkirim(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select so_iskirim from tso_hdr where so_nomor =' + Quot(anomor) ;
  tsql:=xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsInteger;

    finally
      Free;
    end;
  end;
end;

procedure TfrmBrowsePesanan.cxButton10Click(Sender: TObject);
begin
  inherited;
    frmPesanan.doslipSO3(CDSMaster.FieldByname('Nomor').AsString);
end;


procedure TfrmBrowsePesanan.cxButton5Click(Sender: TObject);
begin
  inherited;
  frmPesanan.doslipSO2(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowsePesanan.cxButton9Click(Sender: TObject);
var
  ss,s:string;
  tt,ttt :TStrings;
  a,ii,i:integer;
  tsql :TMyQuery;
  acabang :string;
begin
  inherited;
    tsql := xOpenQuery('select ucase(cbg_nama) from '+frmmenu.aDatabase+'.tcabang where cbg_aktif=1',frmMenu.conn);
  with tsql do
  begin
    try
      if not eof then
         acabang:=tsql.Fields[0].AsString;
    finally
      free;
    end;
  end;
  bacafile;
  with MyConnection1 do
  begin
   LoginPrompt := False;
   Server := aHost2;
   Database := aDatabase2;
   Username := auser2;
   Password := apassword2;
   Connected := True;
  end;
  MyQuery1.Close;
  MyQuery1.SQL.Text := ' select a.so_nomor,a.so_cus_kode,a.so_sls_kode,a.so_tanggal from tso_hdr a'
                      + ' WHERE a.so_tanggal >= CURDATE()-1 and so_issimpan=1 and so_cabang ='+ Quot(acabang);
  MyQuery1.Open;
   tt:=TStringList.Create;
  while not MyQuery1.Eof do
  begin
    s:='insert ignore into t_salesh (nomor_sal,kode_outlet,kode_sales,tanggal) values ('
      + Quot(MyQuery1.Fields[0].AsString) + ','
      + Quot(MyQuery1.Fields[1].AsString) + ','
      + Quot(MyQuery1.Fields[2].AsString) + ','
      + Quotd(MyQuery1.Fields[3].AsDateTime) + ');';
    tt.Append(s);
    ss := 'select sod_so_nomor,sod_brg_kode,sod_qty,sod_harga,sod_discpr from tso_dtl where sod_so_nomor ='+ Quot(MyQuery1.Fields[0].AsString);
    MyQuery2.Close;
    MyQuery2.SQL.Text := ss;
    MyQuery2.Open;
    while not MyQuery2.Eof do
    begin
      s:='insert ignore into t_salesd (nomor_sal,id_barang,qty,harga_sat,discpr) values ('
      + Quot(MyQuery2.Fields[0].AsString) + ','
      + IntToStr(MyQuery2.Fields[1].asinteger) + ','
      + IntToStr(MyQuery2.Fields[2].Asinteger) + ','
      + FloatToStr(MyQuery2.Fields[3].AsFloat) + ','
      + FloatToStr(MyQuery2.Fields[4].AsFloat)
      + ');';
      tt.Append(s);
      MyQuery2.Next;
    end;

    MyQuery1.Next;
    MyConnection1.ExecSQL('update tso_hdr set so_issimpan=2 where so_nomor='+quot(MyQuery2.Fields[0].AsString),[]);
  end;

   try
        for i :=0 to tt.Count-1 do
        begin
          // xExecQuery(tt[i],frmMenu.conn);
          EnsureConnected(frmMenu.conn);
          ExecSQLDirect(frmMenu.conn, tt[i]);
        end;

      finally
        tt.Free;
      end;
    // xCommit(frmMenu.conn);
    ShowMessage('Import data berhasil');

//  if OpenDialog1.Execute then
//  begin
//   tt:=TStringList.Create;
//   tt.LoadFromFile(OpenDialog1.FileName);
//;
//   try
//    try
//        ii:=HitungKarakter(';',tt[0],False);
//        for a :=1 to ii+1 do
//        begin
//          IF (Parsing(';',tt[i],a)) <> '' THEN
//          xExecQuery(Parsing(';',tt[i],a),frmMenu.conn);
//        end;
//
//      finally
//        tt.Free;
//      end;
//   except
//     ShowMessage('gagal import');
//     xRollback(frmMenu.conn);
//     Exit;
//   end;

//    xCommit(frmMenu.conn);
//    ShowMessage('Import data berhasil');


end;

procedure TfrmBrowsePesanan.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
  try
       if not cekedit(frmMenu.KDUSER,'frmPesanan') then
      begin
         MessageDlg('Anda tidak berhak EDIT ',mtWarning, [mbOK],0);
         Exit;
      End;
     if CDSMaster.FieldByname('closed').AsString = 'Belum' then
     begin
      if MessageDlg('Yakin Closed So ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tSO_hdr set SO_ISCLOSED=1 '
        + ' where SO_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
        EnsureConnected(frmMenu.conn);
        ExecSQLDirect(frmMenu.conn, s);
     end
     else
     begin
       if MessageDlg('Yakin Membatalkan Closed SO ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tSO_hdr set SO_ISCLOSED=0 '
        + ' where SO_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
      EnsureConnected(frmMenu.conn);
      ExecSQLDirect(frmMenu.conn, s);
     end;


   except
     MessageDlg('Gagal Closed SO',mtError, [mbOK],0);
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
   btnRefreshClick(self);
end;

procedure TfrmBrowsepesanan.bacafile;
 var
 ltemp : TStringList;

 begin
 ltemp := TStringList.Create;
 ltemp.loadfromfile(ExtractFileDir(application.ExeName) + '\' + 'default2.cfg');
   aHost2     := ltemp[0];
   aDatabase2 := ltemp[1];
   auser2     := ltemp[2];
   apassword2 := ltemp [3];
   ltemp.free;
 end;



end.
