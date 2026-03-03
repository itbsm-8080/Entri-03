unit ufrmLapNeraca;

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
  TfrmLapNeraca = class(TForm)
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
    cxGrid1Level1: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    dtstprvdr1: TDataSetProvider;
    ds2: TDataSource;
    ds3: TClientDataSet;
    sqlqry2: TSQLQuery;
    cxStyle3: TcxStyle;
    clPasiva: TcxGridDBBandedColumn;
    clNilaiPasiva: TcxGridDBBandedColumn;
    Label1: TLabel;
    cbbBulan: TAdvComboBox;
    cxGrid2: TcxGrid;
    cxGridDBBandedTableView1: TcxGridDBBandedTableView;
    cxGridDBBandedColumn1: TcxGridDBBandedColumn;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    DataSetProvider1: TDataSetProvider;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    SQLQuery2: TSQLQuery;
    MainMenu2: TMainMenu;
    sqlqry1: TMyQuery;
    SQLQuery1: TMyQuery;
    procedure Button2Click(Sender: TObject);
    procedure loaddata ;
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
  frmLapNeraca: TfrmLapNeraca;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,cxgridExportlink;

{$R *.dfm}


procedure TfrmLapNeraca.Button2Click(Sender: TObject);
begin
loaddata;
end;

procedure TfrmLapNeraca.loaddata ;
var
  ssql :string;
  tsql : TMyQuery;
  i:integer;
  atotal :Double;
begin
  ssql := 'select year(jur_tanggal) Tahun,month(jur_tanggal) bulan,'
+ ' kol_id,rek_kode ,keterangan,rek_nama Akun,sum(ifnull(jurd_debet,0)-ifnull(jurd_kredit,0)) Nilai from  tjurnal inner join tjurnalitem'
+ ' on jur_no =jurd_jur_no'
+ ' inner join trekening on rek_kode=jurd_rek_kode'
+ ' inner join tkelompok on kol_id=rek_kol_id'
+ ' where isneraca=1 and (year(jur_tanggal)<'+ edtTahun.Text
+ ' OR (month(jur_tanggal)<='+IntToStr(cbbBulan.ItemIndex+1)
+ ' AND year(jur_tanggal)='+ edtTahun.Text+ ' )) and keterangan ="D"'
+ ' group by '
+ ' rek_kode,kol_id'
+ ' order by kol_id,rek_nama';
        ds3.Close;
        sqlqry1.Connection := frmMenu.conn;
        sqlqry1.SQL.Text := ssql;
        ds3.open;

  ssql := 'select year(jur_tanggal) Tahun,month(jur_tanggal) bulan,'
+ ' kol_id,rek_kode ,keterangan,rek_nama Akun,sum(ifnull(jurd_debet,0)-ifnull(jurd_kredit,0)) Nilai from  tjurnal inner join tjurnalitem'
+ ' on jur_no =jurd_jur_no'
+ ' inner join trekening on rek_kode=jurd_rek_kode'
+ ' inner join tkelompok on kol_id=rek_kol_id'
+ ' where isneraca=1 and (year(jur_tanggal)<'+ edtTahun.Text
+ ' OR (month(jur_tanggal)<='+IntToStr(cbbBulan.ItemIndex+1)
+ ' AND year(jur_tanggal)='+ edtTahun.Text+ ' )) and keterangan ="K"'
+ ' group by '
+ ' rek_kode,kol_id'
+ ' order by kol_id,rek_nama';
        ClientDataSet1.Close;
        SQLQuery1.Connection := frmMenu.conn;
        SQLQuery1.SQL.Text := ssql;
        ClientDataSet1.open;


end;

procedure TfrmLapNeraca.cxButton7Click(Sender: TObject);
var
  Save_Cursor:TCursor;
  XLApp: Variant;
  Sheet: Variant;
  i,acol, iCol,jRow : Integer;
  v   : Variant;
  S:string;

begin
  acol:=0;
   Save_Cursor := Screen.Cursor;
   Screen.Cursor := crHourglass;
   try
      XLApp := CreateOLEObject('Excel.Application');
      XLApp.Visible := True;
      XLApp.Workbooks.Add[XLWBatWorksheet];
      XLApp.Workbooks[1].Worksheets[1].Name := 'Sheet1';
      Sheet := XLApp.Workbooks[1].Worksheets['Sheet1'];
      // aktiva
      jRow := 1;
         Sheet.Cells[1,1] := Self.Caption;
         Sheet.Cells[2,1] := 'Periode     :' + cbbBulan.Text + ' Tahun : ' + edtTahun.Text ;
         Sheet.Cells[3,1] := 'AKTIVA';
         Sheet.Cells[3,4] := 'PASIVA';




         for i:=5 to ds3.FieldList.Count-1 do
         begin
            Sheet.Cells[4,i-4] := ds3.FieldList.Fields[i].FieldName;
         end;
      ds3.First;

      jRow:=5;

      while not ds3.EOF do
      begin
         for iCol := 6 to ds3.FieldCount do
         begin
            v := ds3.Fields[iCol-1].Text;
            Sheet.Cells[jRow, iCol-5] := v;
         end;
         Inc(jRow);
         ds3.Next;
      end;
      if acol =0 then
         acol :=i;
            Sheet.Range[Sheet.cells[4,1],Sheet.cells[jrow-1,acol-5]].Borders.Weight := 2;
       for i := 1 to acol do
         XLApp.Workbooks[1].WorkSheets['Sheet1'].Columns[i].EntireColumn.Autofit;

    // pasiva
      jRow := 1;

         for i:=5 to ClientDataSet1.FieldList.Count-1 do
         begin
            Sheet.Cells[4,i-1] := ClientDataSet1.FieldList.Fields[i].FieldName;
         end;
      ClientDataSet1.First;

      jRow:=5;

      while not ClientDataSet1.EOF do
      begin
         for iCol := 6 to ClientDataSet1.FieldCount do
         begin
            v := ClientDataSet1.Fields[iCol-1].Text;
            Sheet.Cells[jRow, iCol-2] := v;
         end;
         Inc(jRow);
         ClientDataSet1.Next;
      end;
      if acol =0 then
         acol :=i;
            Sheet.Range[Sheet.cells[4,4],Sheet.cells[jrow-1,acol-2]].Borders.Weight := 2;
       for i := 1 to acol do
         XLApp.Workbooks[1].WorkSheets['Sheet1'].Columns[i].EntireColumn.Autofit;


   finally
      Screen.Cursor := Save_Cursor;
   end;
end;



procedure TfrmLapNeraca.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmLapNeraca.FormShow(Sender: TObject);
begin
edtTahun.Text := FormatDateTime('yyyy',date);
cbbBulan.ItemIndex :=StrToInt(FormatDateTime('mm',date))-1;
end;

end.
