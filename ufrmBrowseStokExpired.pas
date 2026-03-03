unit ufrmBrowseStokExpired;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox;

type
  TfrmBrowseStokExpired = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    Label5: TLabel;
    cxLookupGudangAsal: TcxExtLookupComboBox;
    procedure FormCreate(Sender: TObject);
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton5Click(Sender: TObject);
  private
    FCDSGudang: TClientDataset;
    function GetCDSGudang: TClientDataset;
    { Private declarations }
  public
    property CDSGudang: TClientDataset read GetCDSGudang write FCDSGudang;
    { Public declarations }
  end;

var
  frmBrowseStokExpired: TfrmBrowseStokExpired;

implementation
   uses ufrmbarang,Ulib, MAIN, uModuleConnection,uFrmLihatGambar;
{$R *.dfm}

procedure TfrmBrowseStokExpired.FormCreate(Sender: TObject);
begin
  inherited;
  with TcxExtLookupHelper(cxLookupGudangAsal.Properties) do
    LoadFromCDS(CDSGudang, 'Kode','Gudang',['Kode'],Self);

end;

procedure TfrmBrowseStokExpired.btnRefreshClick(Sender: TObject);
begin

  Self.SQLMaster := 'select mst_brg_kode Kode,brg_nama Nama,mst_expired_date Expired,mst_hargabeli HargaBeli,'
        + ' sum(mst_stok_in-mst_stok_out) Stok'
        + ' from tmasterstok inner join tbarang on brg_kode=mst_brg_kode '
        + ' where mst_expired_date < '+quotd(startdate.DateTime)+' and mst_expired_date > "2000-01-01"'
        + ' and mst_gdg_kode like '+Quot(vartostr(cxLookupGudangAsal.EditValue)+'%')
        + ' group by mst_brg_kode,mst_expired_date'
        + ' having stok > 0'
        + ' order by mst_brg_kode' ;


   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=80;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[3].Width :=150;


end;

procedure TfrmBrowseStokExpired.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseStokExpired.cxButton2Click(Sender: TObject);
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

procedure TfrmBrowseStokExpired.cxButton1Click(Sender: TObject);
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

procedure TfrmBrowseStokExpired.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseStokExpired.cxButton4Click(Sender: TObject);
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

procedure TfrmBrowseStokExpired.cxButton5Click(Sender: TObject);
var
  KODEBARANG : string;
begin
  inherited;
  Application.CreateForm(TfrmLihatGambar,frmLihatGambar);
  frmLihatGambar.KODEBARANG := CDSMaster.FieldByname('KODE').AsString;
  frmLihatGambar.ShowModal;
end;

function TfrmBrowseStokExpired.GetCDSGudang: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSGudang) then
  begin
    S := 'select gdg_nama as Gudang, gdg_kode Kode '
        +' from tgudang';


    FCDSGudang := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSGudang;
end;

end.
