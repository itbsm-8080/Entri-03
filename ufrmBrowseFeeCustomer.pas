unit ufrmBrowseFeeCustomer;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseFeeCustomer = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseFeeCustomer: TfrmBrowseFeeCustomer;

implementation
   uses ufrmFeeCustomer,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseFeeCustomer.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select cn_nomor Nomor,cn_tanggal Tanggal,cus_nama Customer,cus_alamat Alamat,'
  + ' cn_startdate Stardate,cn_enddate Enddate,cn_nilai_fee Nilai,cn_potong_invoice Presentase_Potong ,cn_targetjual Target '
  + ' from tpiutangcn inner join tCustomer on cn_cus_kode=cus_kode where cn_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[2].Width :=300;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=100;
    cxGrdMaster.Columns[5].Width :=100;
    cxGrdMaster.Columns[6].Width :=100;
    cxGrdMaster.Columns[7].Width :=100;
end;

procedure TfrmBrowseFeeCustomer.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseFeeCustomer.cxButton2Click(Sender: TObject);
var
  frmFeeCustomer: TfrmFeeCustomer;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Fee Customer' then
   begin
      frmFeeCustomer  := frmmenu.ShowForm(TfrmFeeCustomer) as TfrmFeeCustomer;
      frmFeeCustomer.edtNomor.Text := frmFeeCustomer.getmaxkode;
      frmFeeCustomer.dtTanggal.setfocus;
   end;
   frmFeeCustomer.Show;
end;

procedure TfrmBrowseFeeCustomer.cxButton1Click(Sender: TObject);
var
  frmFeeCustomer: TfrmFeeCustomer;
begin
  inherited;
  If CDSMaster.FieldByname('nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFeeCustomer  := frmmenu.ShowForm(TfrmFeeCustomer) as TfrmFeeCustomer;
      frmFeeCustomer.ID := CDSMaster.FieldByname('nomor').AsString;
      frmFeeCustomer.FLAGEDIT := True;
      frmFeeCustomer.edtNomor.Text := CDSMaster.FieldByname('nomor').AsString;
      frmFeeCustomer.loaddata(CDSMaster.FieldByname('nomor').AsString);

   end;
   frmFeeCustomer.Show;
end;

procedure TfrmBrowseFeeCustomer.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseFeeCustomer.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmFeeCustomer') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tpiutangcn '
        + ' where cn_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
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

end.
