unit ufrmBrowseMutasiCabang2;

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
  TfrmBrowseMutasiCabang2 = class(TfrmCxBrowse)
    OpenDialog1: TOpenDialog;
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
  frmBrowseMutasiCabang2: TfrmBrowseMutasiCabang2;

implementation
   uses ufrmMutasiCabang2,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseMutasiCabang2.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select mutci_nomor Nomor,mutci_Tanggal Tanggal ,c.cbg_nama Asal,b.cbg_nama Tujuan,gdg_nama Gudang, mutci_nomormutasi Nomor_Mutasi'
                  + ' from tmutcabin_hdr  a '
                  + ' inner join  tcabang b on b.cbg_kode=a.mutci_cbg_tujuan '
                  + ' inner join tcabang c on c.cbg_kode =a.mutci_cbg_asal '
                  + ' inner join tgudang d on d.gdg_kode= a.mutci_gdg_kode '
                  + ' where mutci_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' AND a.mutci_cbg_tujuan = ' + Quot(frmMenu.KDCABANG)
                  + ' group by mutci_nomor ,mutci_tanggal ,mutci_nomormutasi ';

  Self.SQLDetail := 'select mutci_nomor Nomor,mutcid_brg_kode Kode , brg_nama Nama,mutcid_qty Jumlah,'
                    + ' mutcid_expired Expired,mutcid_keterangan Keterangan'
                    + ' from tmutcabin_dtl'
                    + ' inner join tmutcabin_hdr on mutci_nomor=mutcid_mutci_nomor'
                    + ' inner join tbarang on mutcid_brg_kode=brg_kode'
                    + ' where mutci_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' order by mutci_nomor ,mutcid_nourut';
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=200;
    cxGrdMaster.Columns[3].Width :=200;
    cxGrdMaster.Columns[4].Width :=100;
    cxGrdMaster.Columns[5].Width :=100;

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseMutasiCabang2.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseMutasiCabang2.cxButton2Click(Sender: TObject);
var
  frmMutasiCabang2: TfrmMutasiCabang2;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Mutasi Cabang In' then
   begin
      frmMutasiCabang2  := frmmenu.ShowForm(TfrmMutasiCabang2) as TfrmMutasiCabang2;
      if frmMutasiCabang2.FLAGEDIT = False then
      frmMutasiCabang2.edtNomor.Text := frmMutasiCabang2.getmaxkode;
   end;
   frmMutasiCabang2.Show;
end;

procedure TfrmBrowseMutasiCabang2.cxButton1Click(Sender: TObject);
var
  frmMutasiCabang2: TfrmMutasiCabang2;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Mutasi Cabang In' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmMutasiCabang2  := frmmenu.ShowForm(TfrmMutasiCabang2) as TfrmMutasiCabang2;
      frmMutasiCabang2.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmMutasiCabang2.FLAGEDIT := True;
      frmMutasiCabang2.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmMutasiCabang2.loaddataALL(CDSMaster.FieldByname('Nomor').AsString);
//      if CDSMaster.FieldByname('realisasi').AsString = 'Sudah' then
//      begin
//        ShowMessage('Transaksi ini sudah Realisasi,Tidak dapat di edit');
//        frmMutasiCabang2.cxButton2.Enabled :=False;
//        frmMutasiCabang2.cxButton1.Enabled :=False;
//      end;
   end;
   frmMutasiCabang2.Show;
end;

procedure TfrmBrowseMutasiCabang2.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseMutasiCabang2.cxButton3Click(Sender: TObject);
begin
  inherited;
//  frmMutasiCabang2.doslipPO(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseMutasiCabang2.cxButton4Click(Sender: TObject);
var
  s:string;
  tt :TStrings;
   i:integer;
begin
  inherited;
  if OpenDialog1.Execute then
  begin
  tt:=TStringList.Create;
  tt.LoadFromFile(OpenDialog1.FileName);
   try
    try
        for i:=0 to tt.Count -1 do
        begin
            // xExecQuery(tt[i],frmMenu.conn);
            EnsureConnected(frmMenu.conn);
            ExecSQLDirect(frmMenu.conn, tt[i]);
        end;
      finally
        tt.Free;
      end;
   except
     ShowMessage('gagal import');
     // xRollback(frmMenu.conn);
     Exit;
   end;

    // xCommit(frmMenu.conn);
    ShowMessage('Import data berhasil');

  end;
end;
end.
