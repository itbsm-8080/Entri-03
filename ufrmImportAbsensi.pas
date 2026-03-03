unit ufrmImportAbsensi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, DBClient, cxControls, cxContainer,
  cxEdit, AdvEdBtn, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBExtLookupComboBox, cxSpinEdit, cxTimeEdit, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxButtonEdit,
  cxCheckBox, cxCurrencyEdit, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, AdvCombo,
  cxGridBandedTableView, cxGridDBBandedTableView, ADODB, dxSkinDarkRoom,
  dxSkinFoggy, dxSkinSeven, dxSkinSharp, MyAccess;

type
  TfrmImportAbsensi = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    Label3: TLabel;
    cxExtLookupPabrik: TcxExtLookupComboBox;
    cxButton7: TcxButton;
    savedlg: TSaveDialog;
    startdate: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    AdvPanel4: TAdvPanel;
    ADOQuery1: TADOQuery;
    ADOQuery1ID: TAutoIncField;
    ADOQuery1NIK: TWideStringField;
    ADOQuery1CHECKTIME: TDateTimeField;
    ADOQuery1CHECKTYPE: TWideStringField;
    ADOQuery1TANGGAL: TDateTimeField;
    ADOConnection1: TADOConnection;
    Label4: TLabel;
    enddate: TDateTimePicker;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxExtLookupPabrikPropertiesEditValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    FCDSPabrik: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    function GetCDSPabrik: TClientDataset;

    { Private declarations }
  protected
    FCDSLembur: TClientDataSet;
  public
    property CDSPabrik: TClientDataset read GetCDSPabrik write FCDSPabrik;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmImportAbsensi: TfrmImportAbsensi;

implementation
uses MAIN,uModuleConnection,uFrmbantuan,cxGridExportLink,Ulib;

{$R *.dfm}

procedure TfrmImportAbsensi.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;


procedure TfrmImportAbsensi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;


procedure TfrmImportAbsensi.cxButton1Click(Sender: TObject);
var cdir, database, pass :string;
  s:string;
  ss,sss:string;
  tsql : TMyQuery;
begin
 sss:='select distinct pab_path from tpabrik';
 tsql := xOpenQuery(sss,frmMenu.conn);
 with tsql do
 begin
   while not Eof do
   begin
     ShowMessage(Fields[0].AsString);
      cdir := Fields[0].AsString ;
      database:= 'absensi.mdb';
       pass :='';
       with ADOConnection1 do
       begin
       try
       Connected:=False;
       ConnectionString:=
       'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+cdir+'\'+database+';'+
       'Persist Security Info=False;'+
       'Jet OLEDB:Database Password='+pass;
       Connected:=True;
       Mode := cmShareExclusive ;
       except
       on E: Exception do
       begin
       MessageDlg('Pesan Kesalahan : '#13''+ E.Message, mtError, [mbOK], 0);
       end;
       end;
       end;


         s:='select * from checkinout where tanggal between '+ '#'+FormatDateTime('mm/dd/yyyy',startdate.DateTime)+'#'
        + ' and ' + '#'+FormatDateTime('mm/dd/yyyy',enddate.DateTime+1)+'#'
        + ' order by checktype ' ;
        ADOQuery1.SQL.Text := s;
        ADOQuery1.Open;
        ADOQuery1.First;
        with ADOQuery1  do
        begin
          while not Eof do
          begin

               
            if Fields[3].AsString = 'I' then
            ss:='INSERT IGNORE INTO tabsensi2 (nik,tanggal,scan1,scan2) VALUES ('
                + Quot(Fields[1].AsString) + ','
                + QuotD(Fields[4].AsDateTime) + ','
                + QuotD(Fields[2].AsDateTime,True)+',"00:00:00");'
            else
            ss:='INSERT INTO tabsensi2 (nik,tanggal,scan1,scan2) VALUES ('
                + Quot(Fields[1].AsString) + ','
                + QuotD(Fields[4].AsDateTime) + ',"00:00:00",'
                + QuotD(Fields[2].AsDateTime,True)+') on duplicate key update scan2 = '+QuotD(Fields[2].AsDateTime,True)
                + ';';
             // xExecQuery(ss,frmMenu.conn);
             EnsureConnected(frmMenu.conn);
             ExecSQLDirect(frmMenu.conn, ss);
            Next;
          end;
        end;
          ADOQuery1.Close;
        // xCommit(frmMenu.conn);

     Next;
   end;
 end;
 ShowMessage('Ambil data berhasil');
// cdir := Edit1.Text ;

end;

procedure TfrmImportAbsensi.cxButton2Click(Sender: TObject);
var
  s:string;
  ss:string;
  tt:TStrings;
  i:integer;
  tsql :TMyQuery;

  adate : TDate;
begin
  tt := TStringList.Create;
  s:='select kar_kode_absensi,tanggal,scan1,scan2,nik from tkaryawan left join  tabsensi2 on kar_nik=nik '
   + ' and tanggal between ' + QuotD(startdate.DateTime) +' and '+ QuotD(enddate.DateTime)
   + ' where kar_kode_absensi <> 0 '
   + ' and kar_status_aktif=1 ';
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
    try
      while not eof do
      begin
       ss:= 'delete from tabsensi where nik= ' + Quot(Fields[0].AsString)
       + ' and tanggal = '+ QuotD(Fields[1].AsDateTime) + ';' ;
       tt.Append(ss);
       if Fields[4].AsString <> '' then
       begin
       ss:='insert into tabsensi (nik,tanggal,scan1,scan2) values ('
         + Quot(Fields[0].AsString) + ','
         + QuotD(Fields[1].AsDateTime) + ','
         + QuotD(Fields[2].AsDateTime,True) + ','
         + QuotD(Fields[3].AsDateTime,True) + ');';
       end
       else
       begin
          ss:='insert ignore into tabsensi (nik,tanggal,scan1,scan2) values ('
         + Quot(Fields[0].AsString) + ','
         + QuotD(Fields[1].AsDateTime) + ','
         + Quot('00:00:00') + ','
         + Quot('00:00:00') + ');';
       end;
       tt.Append(ss);
        Next;
      end;
    finally
      free;
    end;
  end;


// proses yang tidak masuk / atau tidak absen
  adate := startdate.Date ;
   while adate < enddate.DateTime+1 do
   begin
     ss:='insert into tabsensi '
        + ' select kar_kode_absensi,'+quotd(adate)+',"00:00:00","00:00:00","00:00:00","00:00:00",0,0,now(),null'
        + ' from tkaryawan LEFT join tabsensi on kar_kode_absensi=nik '
        + ' and tanggal='+quotd(adate)
        + ' where KAR_status_aktif=1'
        + ' AND NIK IS NULL and kar_kode_absensi <> ""';
     tt.append(ss);
     adate:=adate +1
   end;


      tt.SaveToFile('d:\tt.txt');
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
      // xcommit(frmMenu.conn) ;
  Showmessage('Import berhasil')

end;

procedure TfrmImportAbsensi.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmImportAbsensi.FormCreate(Sender: TObject);
begin
    with TcxExtLookupHelper(cxExtLookupPabrik.Properties) do
    LoadFromCDS(CDSPabrik, 'Kode','Nama',['Kode'],Self);


end;

function TfrmImportAbsensi.GetCDSPabrik: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSPabrik) then
  begin
    S := 'select pab_nama as Nama, pab_kode Kode,pab_path '
        +' from tpabrik';
    FCDSPabrik := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSPabrik;
end;

procedure TfrmImportAbsensi.cxExtLookupPabrikPropertiesEditValueChanged(
  Sender: TObject);
begin
  Edit1.Text := CDSPabrik.Fields[2].AsString ;
  
end;

procedure TfrmImportAbsensi.FormShow(Sender: TObject);
begin
startdate.DateTime := Date;
enddate.DateTime := Date;
end;

end.
