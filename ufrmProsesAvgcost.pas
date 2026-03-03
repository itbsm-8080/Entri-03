unit ufrmProsesAvgcost;

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
  AdvCombo,DateUtils, cxPC, MyAccess;

type
  TfrmProsesAvgcost = class(TForm)
    AdvPanel1: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel2: TAdvPanel;
    Label3: TLabel;
    Label5: TLabel;
    RAWPrinter1: TRAWPrinter;
    AdvPanel4: TAdvPanel;
    cxButton8: TcxButton;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
    OpenDialog1: TOpenDialog;
    cbbBulan: TAdvComboBox;
    edtTahun: TComboBox;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    MainMenu1: TMainMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    private
      { Private declarations }
     protected
  public
    { Public declarations }
  end;

var
  frmProsesAvgcost: TfrmProsesAvgcost;

implementation

uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport;

{$R *.dfm}

procedure TfrmProsesAvgcost.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
end;

procedure TfrmProsesAvgcost.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
     SelectNext(ActiveControl,True,True);
end;



procedure TfrmProsesAvgcost.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmProsesAvgcost.cxButton1Click(Sender: TObject);
var
  ssql,s: string;
  tsql : TMyQuery;
  tt :TStrings;
  i:Integer;
  akhir,awal : TDateTime;
begin
    akhir := EndOfTheMonth(StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text));
    awal  :=StrToDate(IntToStr(cbbBulan.itemindex+1)+'/01/'+edttahun.Text);
  while awal < akhir do
  begin
    s:='SELECT mst_tanggal,mst_brg_kode,mst_noreferensi,'
      + ' (select sum(mst_hargabeli*(mst_stok_in-mst_stok_out))/sum(mst_stok_in-mst_stok_out)'
      + ' from tmasterstok'
      + ' where mst_brg_kode=x.mst_brg_kode'
      + ' and ((mst_tanggal < x.mst_tanggal) or (mst_tanggal=x.mst_tanggal and mst_stok_in>0))  AND mst_tanggal > "2020/01/01") avgcost,'
      + ' (select sum(if(mst_avgcost > 0,mst_avgcost,mst_hargabeli)*(mst_stok_in-mst_stok_out))/sum(mst_stok_in-mst_stok_out)'
      + ' from tmasterstok'
      + ' where mst_brg_kode=x.mst_brg_kode'
      + ' and ((mst_tanggal < x.mst_tanggal) or (mst_tanggal=x.mst_tanggal and mst_stok_in>0)) AND mst_tanggal > "2020/01/01") avgcost2'
      + ' FROM tmasterstok x WHERE mst_tanggal = '+quotd(awal)
      + ' AND mst_stok_out > 0'
      + ' HAVING avgcost2 > 0 ';

     tsql := xOpenQuery(  s,frmMenu.conn);
        tt := TStringList.Create;
     with tsql do begin
      try
        while  not Eof do
        begin

            s:='update tmasterstok set mst_avgcost='+floattostr(Fields[4].AsFloat)
            + ' where mst_noreferensi ='+ Quot(Fields[2].AsString)
            + ' and mst_brg_kode = ' + Quot(Fields[1].AsString);
            tt.Append(s);
          Next;
        end;
        finally
          Free;
      end;
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
          // xCommit(frmMenu.conn);

     end;

    awal := awal+1;
  end;

   showmessage('Proses Selesaai')
end;

end.
