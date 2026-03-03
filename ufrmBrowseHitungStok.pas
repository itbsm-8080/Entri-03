unit ufrmBrowseHitungStok;

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
  TfrmBrowseHitungStok = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    SaveDialog1: TSaveDialog;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseHitungStok: TfrmBrowseHitungStok;

implementation
   uses ufrmHitungStok,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseHitungStok.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select hit_nomor Nomor,hit_tanggal Tanggal ,gdg_nama Gudang,hit_lokasi Lokasi '
                  + ' from thitungstok'
                  + ' inner join tgudang on hit_gdg_kode=gdg_kode'
                  + ' where hit_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by hit_nomor ';

  Self.SQLDetail := 'select hitd_hit_nomor Nomor,hitd_brg_kode Kode , brg_nama Nama,hitd_qty Jumlah,hitd_satuan Satuan,hitd_expired Expired'
                    + ' from thitungstok_dtl'
                    + ' inner join thitungstok on hitd_hit_nomor =hit_nomor'
                    + ' inner join tbarang on hitd_brg_kode=brg_kode'
                    + ' where hit_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by hitd_hit_nomor,hitd_nourut ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;



    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseHitungStok.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseHitungStok.cxButton2Click(Sender: TObject);
var
  frmHitungstok: TfrmHitungstok;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'HITUNG STOK' then
   begin
      frmHitungstok  := frmmenu.ShowForm(TfrmHitungstok) as TfrmHitungstok;
      if frmHitungstok.FLAGEDIT= False then 
      frmHitungstok.edtNomor.Text := frmHitungstok.getmaxkode;
   end;
   frmHitungstok.Show;
end;

procedure TfrmBrowseHitungStok.cxButton1Click(Sender: TObject);
var
  frmHitungstok: TfrmHitungstok;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'HITUNGSTOK' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmHitungstok  := frmmenu.ShowForm(TfrmHitungstok) as TfrmHitungstok;
      frmHitungstok.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmHitungstok.FLAGEDIT := True;
      frmHitungstok.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmHitungstok.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
   end;
   frmHitungstok.Show;
end;

procedure TfrmBrowseHitungStok.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;


procedure TfrmBrowseHitungStok.cxButton4Click(Sender: TObject);
var
  s:string;
begin
     try
       if not cekdelete(frmMenu.KDUSER,'frmHitungStok') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from thitungstok '
        + ' where hit_nomor = ' + quot(CDSMaster.FieldByname('nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

       s:='delete from thitungstok_dtl '
        + ' where hitd_hit_nomor = ' + quot(CDSMaster.FieldByname('nomor').AsString) + ';' ;
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
procedure TfrmBrowseHitungStok.cxButton5Click(Sender: TObject);
var
  s:string;
  tt :TStrings;
  tsql :TMyQuery;
begin
  inherited;
  if SaveDialog1.Execute then
  begin


  s:= 'select * from thitungstok inner join thitungstok_dtl on hit_nomor=hitd_hit_nomor and hit_nomor = ' + Quot(CDSMaster.FieldByname('Nomor').AsString);
  tsql:= xOpenQuery(s,frmMenu.conn);
  tt:=TStringList.Create;
  with tsql do
  begin
     try
       if not Eof then
          s:= ' insert into thitungstok '
             + ' (HIT_nomor,HIT_tanggal,HIT_lokasi,HIT_gdg_kode) '
             + ' values ( '
            + Quot(fieldbyname('hit_nomor').AsString+'-'+frmMenu.KDUSER) + ','
            + Quotd(fieldbyname('hit_tanggal').AsDateTime) + ','
            + Quot(fieldbyname('hit_lokasi').AsString) + ','
            + Quot(fieldbyname('hit_gdg_kode').AsString)  + ');' ;
         tt.Append(s);
         while not Eof do
         begin
           s:= 'insert into thitungstok_dtl (HITD_HIT_nomor,HITD_brg_kode,HITD_satuan,HITD_qty,HITD_EXPIRED,HITD_nourut) values ('
            + Quot(fieldbyname('hit_nomor').AsString+'-'+frmMenu.KDUSER) + ','
            + Quot(fieldbyname('hitd_brg_kode').AsString) + ','
            + Quot(fieldbyname('hitd_satuan').AsString) + ','
            + fieldbyname('hitd_qty').AsString + ','
            + Quotd(fieldbyname('hitd_expired').AsDateTime)+','
            + fieldbyname('hitd_nourut').AsString
            + ');'  ;
         tt.Append(s);

          Next;
         end;


       finally
         free;
     end;
     tt.SaveToFile(SaveDialog1.FileName);
  end;
  end;
end;

end.
