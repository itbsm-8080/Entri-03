unit ufrmBrowsePenerimaanLain;

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
  TfrmBrowsePenerimaanLain = class(TfrmCxBrowse)
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowsePenerimaanLain: TfrmBrowsePenerimaanLain;

implementation
   uses ufrmPenerimaanLain,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowsePenerimaanLain.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := ' select jur_no Nomor,jur_tanggal Tanggal, jur_keterangan Keterangan,if(jur_isclosed =1,"Sudah","Belum") IsClosed ,'
                  + ' sum(jurd_debet) Nilai '
                  + ' from tjurnal '
                  + ' inner join tjurnalitem on jurd_jur_no =jur_no'
                  + ' where jur_tipetransaksi='+quot('Penerimaan Lain')
                  + ' and jur_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by jur_no '
                  + ' order by jur_no ';

  Self.SQLDetail := 'select JUR_NO Nomor,JURD_REK_KODE Account,rek_nama AccountName, jurd_debet Debet,jurd_kredit Kredit,cc_nama CostCenter from tjurnal'
                    + ' inner join tjurnalitem on jur_no=jurd_jur_no'
                    + ' inner join trekening on rek_kode=jurd_rek_KODE'
                    + ' LEFT JOIN tcostcenter on cc_kode=jurd_cc_kode'
                    + ' where jur_tipetransaksi='+ quot('Penerimaan Lain')
                    + ' and jur_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by JUR_NO ,jurd_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=100;

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowsePenerimaanLain.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowsePenerimaanLain.cxButton2Click(Sender: TObject);
var
  frmPenerimaanLain: TfrmPenerimaanLain;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Penerimaan Lain lain' then
   begin
      frmPenerimaanLain  := frmmenu.ShowForm(TfrmPenerimaanLain) as TfrmPenerimaanLain;
      if frmPenerimaanLain.FLAGEDIT= False then
      frmPenerimaanLain.edtNomor.Text := frmPenerimaanLain.getmaxkode;
   end;
   frmPenerimaanLain.Show;
end;

procedure TfrmBrowsePenerimaanLain.cxButton1Click(Sender: TObject);
var
  frmPenerimaanLain: TfrmPenerimaanLain;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Penerimaan Lain lain' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmPenerimaanLain  := frmmenu.ShowForm(TfrmPenerimaanLain) as TfrmPenerimaanLain;
      frmPenerimaanLain.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmPenerimaanLain.FLAGEDIT := True;
      frmPenerimaanLain.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmPenerimaanLain.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
      if CDSMaster.FieldByname('IsClosed').AsString = 'Sudah' then
      begin
        ShowMessage('Transaksi ini sudah tutup Periode,Tidak dapat di edit');
        frmPenerimaanLain.cxButton2.Enabled :=False;
        frmPenerimaanLain.cxButton1.Enabled :=False;
      end;
   end;
   frmPenerimaanLain.Show;
end;

procedure TfrmBrowsePenerimaanLain.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowsePenerimaanLain.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmPenerimaanLain.doslipmutasi(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowsePenerimaanLain.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmPenerimaanLain') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
     s:='delete from tjurnalitem '
        + ' where jurd_jur_no = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

     s:='delete from tjurnal '
        + ' where jur_no = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
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
