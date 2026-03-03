unit ufrmBrowseFPBayangan;

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
  cxButtons, ExtCtrls, AdvPanel, DBClient, cxLookAndFeels, frxClass,
  frxExportPDF, MyAccess;

type
  TfrmBrowseFPBayangan = class(TfrmCxBrowse)
    cxButton5: TcxButton;
    frxPDFExport1: TfrxPDFExport;
    cxButton10: TcxButton;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function cekbayar(anomor:string) : integer;
    procedure cxButton5Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure cxButton10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseFPBayangan: TfrmBrowseFPBayangan;

implementation
   uses ufrmFPBayangan,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmBrowseFPBayangan.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select fp_nomor Nomor,fp_tanggal Tanggal ,fp_jthtempo JthTempo, fp_Memo Memo ,sls_nama Salesman,cus_nama  Customer, '
                  + ' fp_amount Total,fp_taxamount Ppn, '
                  + ' ((Fp_disc_fakturpr*(((fp_amount-fp_taxamount)+fp_disc_faktur)/(100-fp_disc_fakturpr)*100))/100) + fp_disc_faktur  Disc_Faktur,'
                  + ' fp_cn CN,fp_freight Freight,fp_bayar Bayar,if(fp_isbayar=0,"Belum","Sudah") Status_Bayar'
                  + ' from tfp_hdr_Bayangan'
                  + ' inner join tcustomer on cus_kode=fp_cus_kode'
                  + ' left join tdo_hdr on fp_do_nomor=do_nomor '
                  + ' left join tso_hdr on do_so_nomor=so_nomor '
                  + ' left JOIN Tsalesman on sls_kode=so_sls_kode'
                  + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                  + ' group by fp_nomor ,fp_tanggal ,fp_memo ,cus_nama ';


  Self.SQLDetail := 'select fp_nomor Nomor,brg_kode Kode , fpd_brg_nama Nama,fpd_brg_satuan Satuan,fpd_qty Jumlah,fpd_harga Harga,fpd_discpr Disc,'
                    + ' (fpd_harga*fpd_qty*(100-fpd_discpr)/100) Nilai'
                    + ' from tfp_dtl_Bayangan'
                    + ' inner join tfp_hdr_Bayangan on fpd_fp_nomor =fp_nomor'
                    + ' inner join tbarang on fpd_brg_kode=brg_kode'
                    + ' where fp_tanggal between ' + QuotD(startdate.DateTime) + ' and ' + QuotD(enddate.DateTime)
                    + ' and fpd_qty > 0 '
                    + ' order by fp_nomor ' ;
 Self.MasterKeyField := 'Nomor';
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=200;

    cxGrdMaster.Columns[9].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[9].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[11].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[11].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[6].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[6].Summary.FooterFormat:='###,###,###,###';

    cxGrdMaster.Columns[7].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[7].Summary.FooterFormat:='###,###,###,###';
    cxGrdMaster.Columns[8].Summary.FooterKind:=skSum;
    cxGrdMaster.Columns[8].Summary.FooterFormat:='###,###,###,###';

    cxGrdDetail.Columns[2].Width :=200;
    cxGrdDetail.Columns[3].Width :=80;

end;

procedure TfrmBrowseFPBayangan.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseFPBayangan.cxButton2Click(Sender: TObject);
var
  frmFPBayangan: TfrmFPBayangan;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Faktur Penjualan Manual' then
   begin
      frmFPBayangan := frmmenu.ShowForm(TfrmFPBayangan) as TfrmFPBayangan;
      if frmFPBayangan.FLAGEDIT = false then
      frmFPBayangan.edtNomor.Text := frmFPBayangan.getmaxkode;
   end;
   frmFPBayangan.Show;
end;

procedure TfrmBrowseFPBayangan.cxButton1Click(Sender: TObject);
var
  frmFPBayangan: TfrmFPBayangan;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Faktur Penjualan Manual' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmFPBayangan := frmmenu.ShowForm(TfrmFPBayangan) as TfrmFPBayangan;
      frmFPBayangan.ID := CDSMaster.FieldByname('Nomor').AsString;
      frmFPBayangan.FLAGEDIT := True;
      frmFPBayangan.edtnOMOR.Text := CDSMaster.FieldByname('Nomor').AsString;
      frmFPBayangan.loaddataall(CDSMaster.FieldByname('Nomor').AsString);
      if cekbayar(CDSMaster.FieldByname('Nomor').AsString) = 1 then
      begin
        ShowMessage('Transaksi ini sudah ada pembayaran,Tidak dapat di edit');
        frmFPBayangan.cxButton2.Enabled :=False;
        frmFPBayangan.cxButton1.Enabled :=False;
        frmFPBayangan.cxButton3.Enabled := False;
      end;
   end;
   frmFPBayangan.Show;
end;

procedure TfrmBrowseFPBayangan.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseFPBayangan.cxButton3Click(Sender: TObject);
begin
  inherited;
  frmFPBayangan.doslip(CDSMaster.FieldByname('Nomor').AsString);
end;

function TfrmBrowseFPBayangan.cekbayar(anomor:string) : integer;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select fp_isbayar from tfp_hdr where fp_nomor =' + Quot(anomor) ;
  tsql:=xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      if not Eof then
         Result := Fields[0].AsInteger;

    finally
      Free;
    end;
  end;
end;

procedure TfrmBrowseFPBayangan.cxButton5Click(Sender: TObject);
begin
  inherited;
     frmFPBayangan.doslip2(CDSMaster.FieldByname('Nomor').AsString);
end;

procedure TfrmBrowseFPBayangan.cxButton4Click(Sender: TObject);
var
  s:string;
begin
  inherited;
     try
       if not cekdelete(frmMenu.KDUSER,'frmfpBayangan') then
      begin
         MessageDlg('Anda tidak berhak Menghapus di Modul ini',mtWarning, [mbOK],0);
         Exit;
      End;

      if MessageDlg('Yakin ingin hapus ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;
     s:='delete from tfp_dtl_bayangan '
        + ' where fpd_fp_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
      // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

       s:='delete from tfp_hdr_bayangan '
        + ' where fp_nomor = ' + quot(CDSMaster.FieldByname('Nomor').AsString) + ';' ;
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

procedure TfrmBrowseFPBayangan.cxButton10Click(Sender: TObject);
begin
  inherited;
 frmFPBayangan.doslip3(CDSMaster.FieldByname('Nomor').AsString);
end;

end.
