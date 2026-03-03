unit uReport;

interface

uses
  Classes, DB, frxDesgn, frxClass,frxDBSet , frxDCtrl, frxChart,
  frxRich, frxBarcode, ImgList, ComCtrls, ExtCtrls,
  FMTBcd, DateUtils, DBClient, Provider, Forms,SqlExpr,
  Controls, ComObj,Ulib,AdvCGrid,Dialogs, MyAccess;

type
  TDBDatasets = array of TfrxDBDataset;

type
  TSQLQueriyItem = class(TCollectionItem)
  private
    FDataSetProvider: TDataSetProvider;
    FQ: TClientDataSet;
    FSQLQuery: TMyQuery;
  public
    constructor Create(aCollection : TCollection); override;
    destructor Destroy; override;
    property DataSetProvider: TDataSetProvider read FDataSetProvider write
        FDataSetProvider;
    property Q: TClientDataSet read FQ write FQ;
    property SQLQuery: TMyQuery read FSQLQuery write FSQLQuery;
  end;

  TSQLQueriyItems = class(TCollection)
  private
    function GetSQLQueriyItem(Index: Integer): TSQLQueriyItem;
    procedure SetSQLQueriyItem(Index: Integer; const Value: TSQLQueriyItem);
  public
    function Add: TSQLQueriyItem;
    property SQLQueriyItem[Index: Integer]: TSQLQueriyItem read GetSQLQueriyItem write
        SetSQLQueriyItem; default;
  end;

  TTSReport = class(TComponent)
  private
    FDBDatasets: TDBDatasets;
    FFrxReport: TfrxReport;
    FNama: string;
    FQueries: TSQLQueriyItems;
//    function GetQueryPerusahaan: TSQLQuery;
    procedure SetNama(const Value: string);
    procedure SettingFrxDatasets;



  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FreeDataset;
    procedure ShowReport;


    procedure AddSQL(ASQL : String);
    procedure ClearSQL;

    property DBDatasets: TDBDatasets read FDBDatasets write FDBDatasets;
    property Queries: TSQLQueriyItems read FQueries write FQueries;
    property FrxReport: TfrxReport read FFrxReport write FFrxReport;
    property Nama: string read FNama write SetNama;
  end;

implementation

uses
  SysUtils,MAIN;


function TSQLQueriyItems.Add: TSQLQueriyItem;
begin
  Result := TSQLQueriyItem(inherited  Add);
end;

function TSQLQueriyItems.GetSQLQueriyItem(Index: Integer): TSQLQueriyItem;
begin
  Result := (Inherited Items[Index]) AS TSQLQueriyItem;
end;

procedure TSQLQueriyItems.SetSQLQueriyItem(Index: Integer; const Value:
    TSQLQueriyItem);
begin
  Items[Index].Assign(Value);
end;

constructor TSQLQueriyItem.Create(aCollection : TCollection);
begin
  inherited;
  Q                       := TClientDataSet.Create(Application);
  DataSetProvider         := TDataSetProvider.Create(Application);
  FSQLQuery               := TMyQuery.Create(Application);

  SQLQuery.Connection  := frmmenu.conn;
  DataSetProvider.DataSet := SQLQuery;

  Q.SetProvider(DataSetProvider);
end;

destructor TSQLQueriyItem.Destroy;
begin
  inherited;
  Q.Free;
  SQLQuery.Free;
  DataSetProvider.Free;
end;

constructor TTSReport.Create(AOwner: TComponent);
begin
  Queries   := TSQLQueriyItems.Create(TSQLQueriyItem);
  FrxReport := TfrxReport.Create(AOwner);
  inherited Create(AOwner);
end;

destructor TTSReport.Destroy;
begin
  FreeAndNil(FQueries);
  FreeAndNil(FFrxReport);
  inherited Destroy;
end;

procedure TTSReport.FreeDataset;
var
  i: Integer;
begin
  for i := 0 to Queries.Count -1 do
    FDBDatasets[i].Free;

  SetLength(FDBDatasets, 0);
  Queries.Clear;
end;

procedure TTSReport.SetNama(const Value: string);
begin
  FNama := Value;
end;

procedure TTSReport.SettingFrxDatasets;
var
  i: Integer;
begin
  AddSQL('select * from tperusahaan;');
  SetLength(FDBDatasets, Queries.Count);

  FrxReport.Datasets.Clear;
  for i := 0 to Queries.Count - 1 do
  begin
    try
        Queries[i].Q.Active := True;
//      Queries[i].Q.FetchAll;
    except
       raise;
    end;

    DBDatasets[i]           := TfrxdbDataSet.Create(nil);
    DBDatasets[i].DataSet   := Queries[i].Q;

    if i = Queries.Count - 1 then
      DBDatasets[i].Name      := 'QPerusahaan'
    else
      DBDatasets[i].Name      := 'Q' + IntToStr(i);

    FrxReport.Datasets.Add(DBDatasets[i]);
  end;
end;

procedure TTSReport.ClearSQL;
begin
  Queries.Clear;
end;

procedure TTSReport.AddSQL(ASQL : String);
begin
  Queries.Add.SQLQuery.SQL.Append(ASQL);
end;


procedure TTSReport.ShowReport;

begin
  SettingFrxDatasets;
  with FrxReport do
  begin
    try
      FileName := cgetreportpath + Nama + '.fr3';

      if not LoadFromFile(cgetreportpath  + Nama + '.fr3') then
      begin

        FrxReport.DesignReport;
      end else begin
        if True then
        begin
//          if MainForm.IDUSER = 1 then
//          begin
          if  MessageDlg('apakah ingin desain report ?',mtCustom,
                                  [mbYes,mbNo], 0) =  mrYes then
          begin
            FrxReport.DesignReport;
          end else begin
            FrxReport.ShowReport;
          end;
//          end
//          else
//            FrxReport.ShowReport;

        end;
      end;

    finally
       FreeDataset;
    end;
  end;

end;



end.
