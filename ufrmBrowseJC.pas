unit ufrmBrowseJC;

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
  TfrmBrowseJC = class(TfrmCxBrowse)
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
  frmBrowseJC: TfrmBrowseJC;

implementation
   uses ufrmJC,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseJC.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select jc_kode Kode ,jc_nama Nama from tjeniscustomer';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowseJC.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseJC.cxButton2Click(Sender: TObject);
var
  frmJC: TfrmJC;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Cost Center' then
   begin
      frmJC  := frmmenu.ShowForm(TfrmJC) as TfrmJC;
      frmJC.edtKode.Text := frmJC.getmaxkode;
      frmJC.edtKode.Enabled :=false;
      frmjc.edtnama.setfocus;
   end;
   frmJC.Show;
end;

procedure TfrmBrowseJC.cxButton1Click(Sender: TObject);
var
  frmjeniscustomer: TfrmJC;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Jenis Customer' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmjeniscustomer  := frmmenu.ShowForm(TfrmJC) as TfrmJC;
      frmjeniscustomer.ID := CDSMaster.FieldByname('KODE').AsString;
      frmjeniscustomer.FLAGEDIT := True;
      frmjeniscustomer.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmjeniscustomer.loaddata(CDSMaster.FieldByname('KODE').AsString);
      frmjeniscustomer.edtKode.Enabled := False;
      frmjeniscustomer.edtnama.setfocus;
   end;
   frmjeniscustomer.Show;
end;

procedure TfrmBrowseJC.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseJC.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmJC') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tjeniscustomer '
        + ' where jc_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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
