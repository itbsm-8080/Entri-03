unit ufrmBrowseGudang;

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
  TfrmBrowseGudang = class(TfrmCxBrowse)
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
  frmBrowseGudang: TfrmBrowseGudang;

implementation
   uses ufrmGudang,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseGudang.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select gdg_kode Kode ,gdg_nama Nama,gdg_penanggungjawab '
  + ' Penanggungjawab,gdg_keterangan Keterangan from tgudang';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseGudang.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseGudang.cxButton2Click(Sender: TObject);
var
  frmGudang: TfrmGudang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
      frmGudang  := frmmenu.ShowForm(TfrmGudang) as TfrmGudang;
      frmGudang.edtKode.Text := frmGudang.getmaxkode;
   end;
   frmGudang.Show;
end;

procedure TfrmBrowseGudang.cxButton1Click(Sender: TObject);
var
  frmGudang: TfrmGudang;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmGudang  := frmmenu.ShowForm(TfrmGudang) as TfrmGudang;
      frmGudang.ID := CDSMaster.FieldByname('KODE').AsString;
      frmGudang.FLAGEDIT := True;
      frmGudang.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmGudang.loaddata(CDSMaster.FieldByname('KODE').AsString);

   end;
   frmGudang.Show;
end;

procedure TfrmBrowseGudang.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseGudang.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmGudang') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tgudang '
        + ' where gdg_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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
