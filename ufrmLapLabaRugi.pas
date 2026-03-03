unit ufrmLapLabaRugi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,  AdvGrid, ComCtrls, StdCtrls, AdvEdit, ExtCtrls,
  AdvPanel, AdvCGrid, BaseGrid,SqlExpr, DBAdvGrd, DB, DBClient, Provider,
  FMTBcd, RAWPrinter, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBExtLookupComboBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxSpinEdit, cxCalendar, Menus, cxButtons, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxButtonEdit, cxCurrencyEdit,ExcelXP,ComObj,
  AdvCombo,DateUtils, cxPC, cxGridBandedTableView, cxGridDBBandedTableView,
  MyAccess, MemDS, DBAccess;

type
  TfrmLapLabaRugi = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    AdvPanel3: TAdvPanel;
    Label3: TLabel;
    RAWPrinter1: TRAWPrinter;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    OpenDialog1: TOpenDialog;
    edtTahun: TComboBox;
    Button2: TButton;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    MainMenu1: TMainMenu;
    cxButton7: TcxButton;
    SaveDialog1: TSaveDialog;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    clKeterangan: TcxGridDBBandedColumn;
    clJan: TcxGridDBBandedColumn;
    clFeb: TcxGridDBBandedColumn;
    clMei: TcxGridDBBandedColumn;
    clJuni: TcxGridDBBandedColumn;
    clJuli: TcxGridDBBandedColumn;
    clApr: TcxGridDBBandedColumn;
    clAgustus: TcxGridDBBandedColumn;
    clMar: TcxGridDBBandedColumn;
    cxGrid1Level1: TcxGridLevel;
    clSept: TcxGridDBBandedColumn;
    clOkt: TcxGridDBBandedColumn;
    clNov: TcxGridDBBandedColumn;
    clDes: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    clTotal: TcxGridDBBandedColumn;
    dtstprvdr1: TDataSetProvider;
    ds2: TDataSource;
    ds3: TClientDataSet;
    sqlqry2: TSQLQuery;
    cxStyle3: TcxStyle;
    sqlqry1: TMyQuery;
    procedure Button2Click(Sender: TObject);
    procedure loaddata ;
    function gettotal(abulan:integer;akol:string) : double;
    procedure cxGrid1DBBandedTableView1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxButton7Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    private
     buttonSelected  : integer;
     FID : STRING;
     FFLAGEDIT: Boolean;
     xtotal : Double;
      { Private declarations }
     protected
  public
    property ID: string read FID write FID;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    { Public declarations }
  end;

var
  frmLapLabaRugi: TfrmLapLabaRugi;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,cxgridExportlink;

{$R *.dfm}


procedure TfrmLapLabaRugi.Button2Click(Sender: TObject);
begin
loaddata;
end;

procedure TfrmLapLabaRugi.loaddata ;
var
  ssql :string;
  tsql : TMyQuery;
  i:integer;
  atotal :Double;
begin
  ssql := 'select 1 no,rek_nama Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun, '
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id=10'
          + ' union '
          + ' select * from ('
          + ' select 2 no,"TOTAL PENJUALAN" Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun,'
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id=10 limit 1) aa'
          + ' union '
          + ' select 3 no,rek_nama Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun,'
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id=9'
          + ' union '
          + ' select * from ('
          + ' select 4 no,"LABA KOTOR" Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun,'
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id=10 limit 1) bb'
          + ' union '
          + ' select * from (select 5 no,rek_nama Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun,'
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id in (12,13) order by rek_urutan ) a '
          + ' union '
          + ' select * from ('
          + ' select 6 no ,"TOTAL BIAYA" Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun, '
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id=10 LIMIT 1) cc'
          + ' union '
          + ' select 7 no,rek_nama Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun,'
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id in (11,14)'
          + ' union '
          + ' select * from ('
          + ' select 8 no,"TOTAL PENDAPATAN" Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun,'
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok '
          + ' on kol_id=rek_kol_id'
          + ' where kol_id=9 LIMIT 1) dd'
          + ' union '
          + ' select 9 no,"LABA BERSIH" Keterangan,'
          + ' cast(0 as decimal) Jan,cast(0 as decimal) Feb,cast(0 as decimal) Mar,'
          + ' cast(0 as decimal) Apr,cast(0 as decimal) Mei,cast(0 as decimal) Jun,'
          + ' cast(0 as decimal) Jul,cast(0 as decimal) Agust,cast(0 as decimal) Sept,'
          + ' cast(0 as decimal) Okt,cast(0 as decimal) Nov,cast(0 as decimal) Des,cast(0 as decimal) Total'
          + ' from trekening inner join tkelompok'
          + ' on kol_id=rek_kol_id'
          + ' where kol_id=9';
        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;

        ssql := 'select month(jur_tanggal) bulan,'
            + ' rek_nama keterangan,sum(ifnull(jurd_kredit,0)-ifnull(jurd_debet,0)) nilai from  tjurnal inner join tjurnalitem'
            + ' on jur_no =jurd_jur_no'
            + ' inner join trekening on rek_kode=jurd_rek_kode'
            + ' inner join tkelompok on kol_id=rek_kol_id'
            + ' where isneraca=0 and year(jur_tanggal)='+edtTahun.Text
            + ' group by month(jur_tanggal) , '
            + ' rek_kode,kol_id '
            + ' order by month(jur_tanggal) ,kol_id,rek_nama';

        tsql :=xOpenQuery(ssql,frmMenu.conn);
        with tsql do
        begin
          try
            while not Eof do
            begin
            if ds3.Locate('keterangan',FieldByName('keterangan').AsString,[loCaseInsensitive]) then
            begin
              if FieldByName('bulan').Asinteger = 1 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('jan').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 2 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('feb').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 3 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('mar').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 4 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('apr').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 5 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('mei').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 6 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('jun').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 7 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('jul').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 8 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('agust').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 9 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('sept').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 10 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('okt').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 11 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('nov').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;
              if FieldByName('bulan').Asinteger = 12 then
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.FieldByName('des').AsFloat := FieldByName('nilai').AsFloat/1000;
              end;

            end;
              Next;
            end;
            if ds3.Locate('keterangan','TOTAL PENJUALAN',[loCaseInsensitive]) then
            begin
              for i := 1 to 12 do
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.Fields[i+1].AsFloat := gettotal(i,'10')/1000 ;
              end;
            end;
            if ds3.Locate('keterangan','LABA KOTOR',[loCaseInsensitive]) then
            begin

              for i := 1 to 12 do
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.Fields[i+1].AsFloat := gettotal(i,'10,9')/1000 ;
              end;
            end;

            if ds3.Locate('keterangan','TOTAL BIAYA',[loCaseInsensitive]) then
            begin
              for i := 1 to 12 do
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.Fields[i+1].AsFloat := gettotal(i,'12,13')/1000 ;
              end;
            end;
            if ds3.Locate('keterangan','TOTAL PENDAPATAN',[loCaseInsensitive]) then
            begin
              for i := 1 to 12 do
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.Fields[i+1].AsFloat := gettotal(i,'11,14')/1000 ;
              end;
            end;
            if ds3.Locate('keterangan','LABA BERSIH',[loCaseInsensitive]) then
            begin
              for i := 1 to 12 do
              begin
                If ds3.State <> dsEdit then ds3.Edit;
                ds3.Fields[i+1].AsFloat := gettotal(i,'')/1000 ;
              end;
            end;
            ds3.First;
            while not ds3.eof do
            begin
              atotal := 0;
              for i := 1 to 12 do
              begin
                atotal := atotal + ds3.Fields[i+1].AsFloat ;
              end;
              If ds3.State <> dsEdit then ds3.Edit;
              ds3.FieldByName('total').AsFloat:=atotal;
              ds3.Next;
            end;

           finally
             free;
           end;
         end;

end;

function TfrmLapLabaRugi.gettotal(abulan:integer;akol:string) : double;
var
  s:string;
  tsql :TMyQuery;
begin
  Result := 0;
  IF AKOL <> ''  Then
        s := 'select '
            + ' sum(ifnull(jurd_kredit,0)-ifnull(jurd_debet,0)) nilai from  tjurnal inner join tjurnalitem'
            + ' on jur_no =jurd_jur_no'
            + ' inner join trekening on rek_kode=jurd_rek_kode'
            + ' inner join tkelompok on kol_id=rek_kol_id'
            + ' where isneraca=0 and year(jur_tanggal)='+edtTahun.Text
            + ' and month(jur_tanggal) = ' + IntToStr(abulan)
            + ' and kol_id  in ('+akol+')'
  else
          s := 'select '
            + ' sum(ifnull(jurd_kredit,0)-ifnull(jurd_debet,0)) nilai from  tjurnal inner join tjurnalitem'
            + ' on jur_no =jurd_jur_no'
            + ' inner join trekening on rek_kode=jurd_rek_kode'
            + ' inner join tkelompok on kol_id=rek_kol_id'
            + ' where isneraca=0 and year(jur_tanggal)='+edtTahun.Text
            + ' and month(jur_tanggal) = ' + IntToStr(abulan) ;

            tsql := xOpenQuery(s,frmMenu.conn);
      with tsql do
      begin
        if not eof then
           Result := Fields[0].AsFloat;
      end;

end;


procedure TfrmLapLabaRugi.cxGrid1DBBandedTableView1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
begin
if (ARecord <> nil) and (AItem <> nil) and (VarToStr(ARecord.Values[0]) = 'TOTAL PENJUALAN') then
    AStyle := cxStyle2;
if (ARecord <> nil) and (AItem <> nil) and (VarToStr(ARecord.Values[0]) = 'LABA KOTOR') then
    AStyle := cxStyle2;
if (ARecord <> nil) and (AItem <> nil) and (VarToStr(ARecord.Values[0]) = 'TOTAL BIAYA') then
    AStyle := cxStyle2;
if (ARecord <> nil) and (AItem <> nil) and (VarToStr(ARecord.Values[0]) = 'TOTAL PENDAPATAN') then
    AStyle := cxStyle2;
if (ARecord <> nil) and (AItem <> nil) and (VarToStr(ARecord.Values[0]) = 'LABA BERSIH') then
    AStyle := cxStyle3;

end;

procedure TfrmLapLabaRugi.cxButton7Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     begin
       ExportGridToExcel(SaveDialog1.FileName, cxGrid1);
     end;

end;

procedure TfrmLapLabaRugi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmLapLabaRugi.FormShow(Sender: TObject);
begin
edttahun.Text := FormatDateTime('yyyy',date);

end;

end.
