unit ufrmBrowseSubBarang;

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
  TfrmBrowseSubBarang = class(TfrmCxBrowse)
    Label3: TLabel;
    ComboBox1: TComboBox;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSubBarang: TfrmBrowseSubBarang;

implementation
   uses ufrmSubBarang,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSubBarang.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select ktg_kode Kode ,ktg_nama Nama from tkategori where ktg_tingkat='+ IntToStr(ComboBox1.ItemIndex+1);
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseSubBarang.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  combobox1.ItemIndex := 2;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSubBarang.cxButton2Click(Sender: TObject);
var
  frmSubBarang: TfrmSubBarang;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master SubBarang' then
   begin
      frmSubBarang  := frmmenu.ShowForm(TfrmSubBarang) as TfrmSubBarang;
      frmSubBarang.cxLookupSubKode.SetFocus;
      frmSubBarang.Tingkat := ComboBox1.ItemIndex+1;
      if ComboBox1.ItemIndex+1 =1 then
      begin
        frmSubBarang.edtKode.Text := frmSubBarang.getmaxkode;
      end;
      frmsubbarang.initview;
   end;
   frmSubBarang.Show;
end;

procedure TfrmBrowseSubBarang.cxButton1Click(Sender: TObject);
var
  frmSubBarang: TfrmSubBarang;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master SubBarang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmSubBarang  := frmmenu.ShowForm(TfrmSubBarang) as TfrmSubBarang;
      frmSubBarang.ID := CDSMaster.FieldByname('KODE').AsString;
      frmSubBarang.FLAGEDIT := True;
      frmSubBarang.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmSubBarang.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmSubBarang.edtKode.Enabled := False;
      frmSubBarang.Tingkat := ComboBox1.ItemIndex+1;
      frmSubBarang.cxLookupSubKode.Enabled := False;
       frmsubbarang.initview;
//      frmSubBarang.cxLookupSubKode.EditValue
   end;
   frmSubBarang.Show;
end;

procedure TfrmBrowseSubBarang.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSubBarang.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmSubBarang') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tkategori '
        + ' where ktg_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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

procedure TfrmBrowseSubBarang.ComboBox1Change(Sender: TObject);
begin
  inherited;
  btnRefreshClick(Self);
end;

end.
