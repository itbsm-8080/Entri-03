unit ufrmBrowseSerahTerimaFaktur;

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
  TfrmBrowseSerahTerimaFaktur = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    function cekrealisasi(akode:string):boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSerahTerimaFaktur: TfrmBrowseSerahTerimaFaktur;

implementation
   uses Ulib, MAIN, uModuleConnection, ufrmserahterimafaktur;
{$R *.dfm}

procedure TfrmBrowseSerahTerimaFaktur.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select sth_nomor Nomor,sth_tanggal Tanggal,sth_serah Serah,sth_terima Terima,'
                  + 'if(sth_realisasi=0,"Belum","Sudah") Realisasi '
                  + ' from tserahterimafaktur_hdr '
                  + ' where sth_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);

  Self.SQLDetail := 'select std_sth_nomor Nomor,std_fp_nomor Faktur, fp_tanggal Tanggal ,fp_jthtempo JthTempo,fp_amount Nilai,cus_nama Customer'
                    + ' from Tserahterimafaktur_dtl'
                    + ' inner join tserahterimafaktur_hdr on sth_nomor=std_sth_nomor'
                    + ' inner join tfp_hdr on std_fp_nomor=fp_nomor'
                    + ' inner join tcustomer on cus_kode=fp_cus_kode'
                    + ' where sth_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by std_sth_nomor ';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=80;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseSerahTerimaFaktur.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSerahTerimaFaktur.cxButton2Click(Sender: TObject);
var
  frmserahterimafaktur: Tfrmserahterimafaktur;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Pembayaran Customer' then
   begin
      frmserahterimafaktur  := frmmenu.ShowForm(Tfrmserahterimafaktur) as Tfrmserahterimafaktur;
      if frmserahterimafaktur.FLAGEDIT = False then
      frmserahterimafaktur.edtNomor.Text := frmserahterimafaktur.getmaxkode;
   end;
   frmserahterimafaktur.Show;
end;

procedure TfrmBrowseSerahTerimaFaktur.cxButton1Click(Sender: TObject);
var
  frmserahterimafaktur: Tfrmserahterimafaktur;
begin
  inherited;
  IF Cekrealisasi(CDSMaster.FieldByname('Nomor').AsString) then
  begin
    ShowMessage('Nomor ini sudah di realisasi , tidak dapat di edit');
    Exit;
  end;
  if CDSMaster.FieldByname('SERAH').AsString <> frmMenu.KDUSER Then
  begin
    ShowMessage('Anda tidak berhak edit transaksi ini');
    Exit;
  end;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Serah Terima Faktur' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmserahterimafaktur  := frmmenu.ShowForm(Tfrmserahterimafaktur) as Tfrmserahterimafaktur;
      frmserahterimafaktur.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmserahterimafaktur.FLAGEDIT := True;
      frmserahterimafaktur.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmserahterimafaktur.loaddataall(CDSMaster.FieldByname('Nomor').AsString);

   end;
   frmserahterimafaktur.Show;
end;

procedure TfrmBrowseSerahTerimaFaktur.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSerahTerimaFaktur.cxButton3Click(Sender: TObject);
begin
  inherited;
 if CDSMaster.FieldByname('serah').AsString <> frmMenu.KDUSER Then
  begin
    ShowMessage('Anda tidak berhak Cetak transaksi ini');
    Exit;
  end;
 frmserahterimafaktur.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseSerahTerimaFaktur.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
  if CDSMaster.FieldByname('TERIMA').AsString <> frmMenu.KDUSER Then
  begin
    ShowMessage('Anda tidak berhak Realisasi transaksi ini');
    Exit;
  end;
       if MessageDlg('Yakin Realisasi Serah terima ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='UPDATE tserahterimafaktur_hdr set sth_realisasi=1 '
        + ' where sth_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
      // xCommit(frmMenu.conn);
      btnRefreshClick(self);

end;

function TfrmBrowseSerahTerimaFaktur.cekrealisasi(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select sth_realisasi from '
        + ' tserahterimafaktur_hdr'
        + '  WHERE sth_nomor = ' + Quot(akode) ;
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if Fields[0].AsInteger = 1  then
         Result := True
     finally
       free;
     end;
   end;
end;


end.
