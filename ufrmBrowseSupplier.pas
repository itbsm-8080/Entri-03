unit ufrmBrowseSupplier;

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
  TfrmBrowseSupplier = class(TfrmCxBrowse)
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
  frmBrowseSupplier: TfrmBrowseSupplier;

implementation
   uses ufrmsupplier,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseSupplier.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select sup_kode Kode ,sup_nama Nama,sup_alamat '
  + ' Alamat,sup_kota Kota,sup_Telp Telp,sup_fax Fax,sup_CP Contact,sup_top TOP from tsupplier';
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
//    cxGrdMaster.Columns[7].Summary.FooterKind:=skSum;
//    cxGrdMaster.Columns[7].Summary.FooterFormat:='###,###,###,###';

end;

procedure TfrmBrowseSupplier.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSupplier.cxButton2Click(Sender: TObject);
var
  frmsupplier: Tfrmsupplier;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master supplier' then
   begin
      frmsupplier  := frmmenu.ShowForm(Tfrmsupplier) as Tfrmsupplier;
//      frmsupplier.edtKode.Text := frmsupplier.getmaxkode;
      frmsupplier.edtKode.setfocus;
   end;
   frmsupplier.Show;
end;

procedure TfrmBrowseSupplier.cxButton1Click(Sender: TObject);
var
  frmsupplier: Tfrmsupplier;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmsupplier  := frmmenu.ShowForm(Tfrmsupplier) as Tfrmsupplier;
      frmsupplier.ID := CDSMaster.FieldByname('KODE').AsString;
      frmsupplier.FLAGEDIT := True;
      frmsupplier.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmsupplier.loaddata(CDSMaster.FieldByname('KODE').AsString);

   end;
   frmsupplier.Show;
end;

procedure TfrmBrowseSupplier.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSupplier.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmsupplier') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tsupplier '
        + ' where sup_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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
