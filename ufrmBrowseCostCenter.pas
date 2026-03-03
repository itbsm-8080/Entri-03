unit ufrmBrowseCostCenter;

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
  TfrmBrowseCostCenter = class(TfrmCxBrowse)
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
  frmBrowseCostCenter: TfrmBrowseCostCenter;

implementation
   uses ufrmCostCenter,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseCostCenter.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select cc_kode Kode ,cc_nama Nama from tcostcenter';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseCostCenter.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseCostCenter.cxButton2Click(Sender: TObject);
var
  frmCostCenter: TfrmCostCenter;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Cost Center' then
   begin
      frmCostCenter  := frmmenu.ShowForm(TfrmCostCenter) as TfrmCostCenter;
      frmCostCenter.edtKode.SetFocus;
   end;
   frmCostCenter.Show;
end;

procedure TfrmBrowseCostCenter.cxButton1Click(Sender: TObject);
var
  frmCostCenter: TfrmCostCenter;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master CostCenter' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmCostCenter  := frmmenu.ShowForm(TfrmCostCenter) as TfrmCostCenter;
      frmCostCenter.ID := CDSMaster.FieldByname('KODE').AsString;
      frmCostCenter.FLAGEDIT := True;
      frmCostCenter.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmCostCenter.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmCostCenter.edtKode.Enabled := False;
   end;
   frmCostCenter.Show;
end;

procedure TfrmBrowseCostCenter.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseCostCenter.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmCostCenter') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tCostCenter '
        + ' where cc_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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
