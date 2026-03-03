unit ufrmBrowseRekening;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels;

type
  TfrmBrowseRekening = class(TfrmCxBrowse)
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
  frmBrowseRekening: TfrmBrowseRekening;

implementation
   uses ufrmRekening,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseRekening.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select rek_kode Kode ,rek_nama Nama,kol_nama Kelompok,if(rek_isaktif=1,"Aktif","Non Aktif") Status,'
  + ' (select sum(jurd_debet-jurd_kredit) from tjurnalitem inner join trekening on rek_kode=jurd_rek_kode where jurd_rek_kode=a.rek_kode and rek_kol_id=1) Saldo_Akhir '
  + ' from tREKENING a inner join tkelompok on kol_id=rek_kol_id ';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseRekening.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseRekening.cxButton2Click(Sender: TObject);
var
  frmrekening: Tfrmrekening;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Rekening' then
   begin
      frmrekening  := frmmenu.ShowForm(Tfrmrekening) as Tfrmrekening;
   end;
   frmrekening.Show;
end;

procedure TfrmBrowseRekening.cxButton1Click(Sender: TObject);
var
  frmrekening: Tfrmrekening;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmrekening  := frmmenu.ShowForm(Tfrmrekening) as Tfrmrekening;
      frmrekening.ID := CDSMaster.FieldByname('KODE').AsString;
      frmrekening.FLAGEDIT := True;
      frmrekening.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmrekening.loaddata(CDSMaster.FieldByname('KODE').AsString);

   end;
   frmrekening.Show;
end;

procedure TfrmBrowseRekening.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseRekening.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmrekening') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from trekening '
        + ' where rek_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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
