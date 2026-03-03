unit ufrmBrowseCustomer;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, dxSkinDarkRoom,
  dxSkinFoggy, dxSkinSeven, dxSkinSharp;

type
  TfrmBrowseCustomer = class(TfrmCxBrowse)
    PopupMenu1: TPopupMenu;
    UpdatestatusLocked1: TMenuItem;
    Open1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure UpdatestatusLocked1Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseCustomer: TfrmBrowseCustomer;

implementation
   uses ufrmCustomer,Ulib, MAIN, uModuleConnection, UfrmOtorisasi;
{$R *.dfm}

procedure TfrmBrowseCustomer.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select cus_kode Kode ,cus_nama Nama,cus_alamat '
  + ' Alamat,gc_nama Golongan,cus_kota Kota,cus_Telp Telp,cus_fax Fax,cus_CP Contact,'
  + ' cus_npwp NPWP,cus_namanpwp NAMANPWP,cus_alamatnpwp ALAMATNPWP, '
  + ' (select  byc_tanggal from tbayarcus_hdr where byc_cus_kode=cus_kode order by byc_tanggal desc limit 1) last_paid,cus_top Top ,if(cus_locked=0,"Open","Locked") Locked'
  + ' from tCustomer left join tgolongancustomer on cus_gc_kode=gc_kode where cus_cabang ='+Quot(frmMenu.KDCABANG);
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
//    cxGrdMaster.Columns[8].Summary.FooterKind:=skSum;
//    cxGrdMaster.Columns[8].Summary.FooterFormat:='###,###,###,###';

end;

procedure TfrmBrowseCustomer.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseCustomer.cxButton2Click(Sender: TObject);
var
  frmCustomer: TfrmCustomer;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master Customer' then
   begin
      frmCustomer  := frmmenu.ShowForm(TfrmCustomer) as TfrmCustomer;
//      frmCustomer.edtKode.Text := frmCustomer.getmaxkode;
      frmCustomer.edtkode.setfocus;
   end;
   frmCustomer.Show;
end;

procedure TfrmBrowseCustomer.cxButton1Click(Sender: TObject);
var
  frmCustomer: TfrmCustomer;
begin
  inherited;
  If CDSMaster.FieldByname('KODE').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master Gudang' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmCustomer  := frmmenu.ShowForm(TfrmCustomer) as TfrmCustomer;
      frmCustomer.ID := CDSMaster.FieldByname('KODE').AsString;
      frmCustomer.FLAGEDIT := True;
      frmCustomer.edtKode.Text := CDSMaster.FieldByname('KODE').AsString;
      frmCustomer.loaddata(CDSMaster.FieldByname('KODE').AsString);

   end;
   frmCustomer.Show;
end;

procedure TfrmBrowseCustomer.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseCustomer.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmCustomer') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;
      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
       s:='delete from tCustomer '
        + ' where cus_kode = ' + quot(CDSMaster.FieldByname('KODE').AsString) + ';' ;
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

procedure TfrmBrowseCustomer.Open1Click(Sender: TObject);
begin
  inherited;
          Application.CreateForm(TfrmOtorisasi,frmOtorisasi);
          frmOtorisasi.ShowModal;
          if frmMenu.otorisasi then
          begin
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, 'update tcustomer set cus_locked=0 where cus_kode='+Quot(CDSMaster.FieldByname('KODE').AsString)+';');
            // xExecQuery('update tcustomer set cus_locked=0 where cus_kode='+Quot(CDSMaster.FieldByname('KODE').AsString)+';',frmMenu.conn);
            // xCommit(frmMenu.conn);
            If CDSMaster.State <> dsEdit then CDSMaster.Edit;
                CDSMaster.FieldByname('Locked').AsString:='Open';
                CDSMaster.Post;
          end;

end;

procedure TfrmBrowseCustomer.UpdatestatusLocked1Click(Sender: TObject);
var
  s:string;
begin
  inherited;
  EnsureConnected(frmMenu.conn);
  ExecSQLDirect(frmMenu.conn, 'update tcustomer set cus_locked=1 where cus_kode='+Quot(CDSMaster.FieldByname('KODE').AsString)+';');
  // xExecQuery('update tcustomer set cus_locked=1 where cus_kode='+Quot(CDSMaster.FieldByname('KODE').AsString)+';',frmMenu.conn);
  // xCommit(frmMenu.conn);
    If CDSMaster.State <> dsEdit then CDSMaster.Edit;
          CDSMaster.FieldByname('Locked').AsString:='Locked';
          CDSMaster.Post;
end;

procedure TfrmBrowseCustomer.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  AColumn : TcxCustomGridTableItem;
begin
  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Locked');

  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (VarToStr(ARecord.Values[AColumn.Index]) ='Locked') then
    AStyle := cxStyle1;
end;


end.
