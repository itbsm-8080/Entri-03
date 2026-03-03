unit ufrmBrowseSalesman;

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
  TfrmBrowseSalesman = class(TfrmCxBrowse)
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
  frmBrowseSalesman: TfrmBrowseSalesman;

implementation
   uses ufrmSalesman,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSalesman.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select sls_kode Kode ,sls_nama Nama,sls_alamat '
  + ' Alamat,sls_kota Kota,sls_Telp Telp,sls_tglmasuk TglMasuk,if(sls_isaktif=1,"Aktif","Tidak Aktif") Status from tsalesman where sls_cabang='+ Quot(frmMenu.KDCABANG);
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[2].Width :=300;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=100;
    cxGrdMaster.Columns[5].Width :=100;
end;

procedure TfrmBrowseSalesman.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSalesman.cxButton2Click(Sender: TObject);
var
  frmSalesman: TfrmSalesman;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
      frmSalesman  := frmmenu.ShowForm(TfrmSalesman) as TfrmSalesman;
      frmSalesman.edtKode.Text := frmSalesman.getmaxkode;
      frmsalesman.edtnama.setfocus;
      frmsalesman.loadtogrid;
   end;
   frmSalesman.Show;
end;

procedure TfrmBrowseSalesman.cxButton1Click(Sender: TObject);
var
  frmSalesman: TfrmSalesman;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmSalesman  := frmmenu.ShowForm(TfrmSalesman) as TfrmSalesman;
      frmSalesman.ID := CDSMaster.FieldByname('KODE').AsString;
      frmSalesman.FLAGEDIT := True;
      frmSalesman.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmSalesman.loaddata(CDSMaster.FieldByname('KODE').AsString);

   end;
   frmSalesman.Show;
end;

procedure TfrmBrowseSalesman.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSalesman.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmSalesman') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tsalesman '
        + ' where sls_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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
