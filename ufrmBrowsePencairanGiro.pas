unit ufrmBrowsePencairanGiro;

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
  TfrmBrowsePencairanGiro = class(TfrmCxBrowse)
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
  frmBrowsePencairanGiro: TfrmBrowsePencairanGiro;

implementation
   uses ufrmPencairanGiro,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowsePencairanGiro.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select cg_nomor Nomor,cg_tanggal Tanggal,cg_gironumber GiroNumber,cg_tanggalcair TglCair, '
          + ' cg_nilai Nilai ,rek_nama Bank from tpencairangiro inner join trekening on rek_kode=cg_rek_bank '
          + ' where cg_tanggal  between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime);
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
end;

procedure TfrmBrowsePencairanGiro.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  startdate.DateTime :=Date;
  enddate.DateTime :=Date ;
  btnRefreshClick(Self);
end;

procedure TfrmBrowsePencairanGiro.cxButton2Click(Sender: TObject);
var
  frmPencairanGiro: TfrmPencairanGiro;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Cost Center' then
   begin
      frmPencairanGiro  := frmmenu.ShowForm(TfrmPencairanGiro) as TfrmPencairanGiro;
      frmpencairangiro.refreshdata;
      frmPencairanGiro.dtTanggal.SetFocus;
   end;
   frmPencairanGiro.Show;
end;

procedure TfrmBrowsePencairanGiro.cxButton1Click(Sender: TObject);
var
  frmPencairanGiro: TfrmPencairanGiro;
begin
  inherited;
  If CDSMaster.FieldByname('nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Pencairan Giro' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPencairanGiro  := frmmenu.ShowForm(TfrmPencairanGiro) as TfrmPencairanGiro;
      frmPencairanGiro.ID := CDSMaster.FieldByname('nomor').AsString;
      frmPencairanGiro.FLAGEDIT := True;
      frmPencairanGiro.edtNomor.Text := CDSMaster.FieldByname('nomor').AsString;
      frmPencairanGiro.loaddata(CDSMaster.FieldByname('nomor').AsString);
      frmPencairanGiro.edtnomor.Enabled := False;
      frmPencairanGiro.dtTanggal.Enabled := False;

   end;
   frmPencairanGiro.Show;
end;

procedure TfrmBrowsePencairanGiro.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowsePencairanGiro.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmPencairanGiro') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tpencairangiro '
        + ' where cg_nomor = ' + quot(CDSMaster.FieldByname('nomor').AsString) + ';' ;
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
