unit ufrmLapAbsensi;

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
  TfrmLapAbsensi = class(TfrmCxBrowse)
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
  procedure btnRefreshClick(Sender: TObject);
  procedure FormShow(Sender: TObject);
  procedure cxButton6Click(Sender: TObject);
    procedure cxGrdMasterStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLapAbsensi: TfrmLapAbsensi;

implementation
   uses ufrmBayarSupplier,Ulib, MAIN, uModuleConnection;
{$R *.dfm}

procedure TfrmLapAbsensi.btnRefreshClick(Sender: TObject);
begin
  Self.SQLMaster := 'SELECT Nik,Tanggal, '
+ ' if(dayname(Tanggal)="Monday","Senin",if(dayname(Tanggal)="Tuesday","Selasa",if(dayname(Tanggal)="Wednesday","Rabu",'
+ ' if(dayname(Tanggal)="Thursday","Kamis",if(dayname(Tanggal)="Friday","Jumat",if(dayname(Tanggal)="Saturday","Sabtu","Minggu")))))) Hari,'
+ ' kar_nama Nama,Scan1 _IN,Scan2 _Out FROM tabsensi INNER JOIN tkaryawan ON kar_nik=nik '
+ ' where tanggal BETWEEN '+ quotd(startdate.datetime)
+ ' AND '+ quotd(enddate.datetime);
   inherited;
    cxGrdMaster.ApplyBestFit();
    cxGrdMaster.Columns[0].Width :=100;
    cxGrdMaster.Columns[1].Width :=100;
    cxGrdMaster.Columns[2].Width :=100;
    cxGrdMaster.Columns[3].Width :=170;
    cxGrdMaster.Columns[4].Width :=100;
    cxGrdMaster.Columns[5].Width :=100;    
end;

procedure TfrmLapAbsensi.FormShow(Sender: TObject);
begin
    ShowWindowAsync(Handle, SW_MAXIMIZE);
  inherited;
  btnRefreshClick(Self);
end;

procedure TfrmLapAbsensi.cxButton6Click(Sender: TObject);
begin
  inherited;
  refreshdata;
end;

procedure TfrmLapAbsensi.cxGrdMasterStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  var
      AColumn : TcxCustomGridTableItem;
      AColumn2 : TcxCustomGridTableItem;
begin
  inherited;

  AColumn := (Sender as TcxGridDBTableView).GetColumnByFieldName('_IN');
  AColumn2 := (Sender as TcxGridDBTableView).GetColumnByFieldName('_OUT');



  if (AColumn <> nil)  and ((ARecord.Values[AColumn.Index]) = '00:00:00')
  and ((ARecord.Values[AColumn2.Index]) = '00:00:00') then
    AStyle := cxStyle2;

end;

end.
