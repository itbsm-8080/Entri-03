unit ufrmBrowseSPK;

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
  TfrmBrowseSPK = class(TfrmCxBrowse)
    PopupMenu1: TPopupMenu;
    UpdatestatusLocked1: TMenuItem;
    Open1: TMenuItem;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrowseSPK: TfrmBrowseSPK;

implementation
   uses ufrmSPK, MAIN,ulib, uModuleConnection, UfrmOtorisasi,ureport;
{$R *.dfm}

procedure TfrmBrowseSPK.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'select spk_nomor Nomor,spk_nama Nama,spk_tanggal Tanggal,spk_IDBatch IdBatch, '
                  + ' spk_brg_kode Kode,Brg_nama Nama_Barang,spk_Jumlah Jumlah ,spk_jumlah_jadi Jadi'
                  + ' from '
                  + ' tspk '
                  + ' inner join tbarang on brg_kode=spk_brg_kode '
                  + ' where spk_tanggal between '+ QuotD(startdate.DateTime) + ' and ' +QuotD(enddate.DateTime);
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=200;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=100;
    cxGrdMaster.Columns[4].Width :=100;
    cxGrdMaster.Columns[5].Width :=200;
    cxGrdMaster.Columns[6].Width :=100;
    cxGrdMaster.Columns[7].Width :=100;

end;

procedure TfrmBrowseSPK.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
//  StartDate.DateTime := StrToDate(FormatDateTime('mm',Now)+'/01/'+FormatDateTime('yyyy',Now));
//  enddate.DateTime := Date;
  btnRefreshClick(Self);
end;

procedure TfrmBrowseSPK.cxButton2Click(Sender: TObject);
var
  frmspk: Tfrmspk;
begin
  inherited;
    if ActiveMDIChild.Caption <> 'Master SPK' then
   begin
      frmspk  := frmmenu.ShowForm(Tfrmspk) as Tfrmspk;
      frmspk.edtnomorspk.Text := frmspk.getmaxkode;
      frmspk.edtNamaspk.setfocus;
   end;
   frmspk.Show;
end;

procedure TfrmBrowseSPK.cxButton1Click(Sender: TObject);
var
  frmspk: TfrmSPK;
begin
  inherited;
  If CDSMaster.FieldByname('Nomor').IsNull then exit;
  if ActiveMDIChild.Caption <> 'Master SPK' then
   begin
//      ShowForm(TfrmBrowseBarang).Show;
      frmspk  := frmmenu.ShowForm(Tfrmspk) as Tfrmspk;
      frmspk.ID := CDSMaster.FieldByname('nomor').AsString;
      frmspk.FLAGEDIT := True;
      frmspk.edtnomorspk.Text := CDSMaster.FieldByname('nomor').AsString;
      frmspk.loaddata(CDSMaster.FieldByname('nomor').AsString);

   end;
   frmspk.Show;
end;

procedure TfrmBrowseSPK.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmBrowseSPK.cxButton3Click(Sender: TObject);
var
  s: string ;
  ftsreport : TTSReport;
begin
  ftsreport := TTSReport.Create(nil);
  try

       ftsreport.Nama := 'spk';

          s:= ' select '
       + ' * '
       + ' from tspk '
       + ' left join tcustomer on cus_kode=spk_cus_kode'
       + ' left join tbarang on brg_kode=spk_brg_kode '
       + ' where '
       + ' spk_nomor=' + quot(CDSMaster.FieldByname('Nomor').AsString);
    ftsreport.AddSQL(s);

    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;

procedure TfrmBrowseSPK.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  var
      AColumn : TcxCustomGridTableItem;
begin
  inherited;
 AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('Jadi');


  if (AColumn <> nil)  and (ARecord <> nil) and (AItem <> nil) and
     (cVarToFloat(ARecord.Values[AColumn.Index]) > 0 ) then
    AStyle := cxStyle2;

end;

end.
