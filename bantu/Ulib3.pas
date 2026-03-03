unit Ulib;

interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SqlExpr ,uModuleConnection,  Menus, DBXpress, DB, ComCtrls,
  StdCtrls, AdvCGrid,StrUtils, ExtCtrls, grids,DBClient,Provider,DBAdvGrd,
  Math, IBQuery,
  OleServer, ExcelXP,printers,WinSpool,DBGrids;
type
 Tbutton1 = class(Tbutton)
  public
    procedure Click; override;
  end;

  TCDS = class(TClientDataSet)
  private

  public

  end;


 Tedit1 = class(TEdit)
  public
    procedure KeyPress(var Key: Char); override;
  end;
  TDBAdvStringGrid1 = class(TDBgrid)
  public
    procedure KeyPress(var Key: Char); override;
  end;
procedure autonumber(aGrid : TAdvColumnGrid);
procedure hapusbaris(agrid: TAdvColumnGrid);
procedure cClearGrid(aGrd : TAdvColumnGrid; aClearFirstRow : boolean);
procedure buatbutton(frm:TForm);
procedure SetResult;
function cLookUp(afrm:TForm):TStrings;overload;
procedure GetCompanyLine(var CL1 : String; var CL2 : String; var CL3 : String ; var CL4 : String ; var CL5 : String ;var CL6 : String ;var CL7 : STRING;var CL8 : STRING;var CL9 : STRING; var CL10 : STRING );
procedure savetoexcelnew(agrid : TAdvColumnGrid;aket:string='');
function StrPadcenter(const S: String; Len: Integer; C: Char): String;
function StrPadRight(const S: String; Len: Integer; C: Char): String;
function StrPadLeft(const S: String; Len: Integer; C: Char): String;
procedure cShowWaitWindow(aCaption : String = 'Mohon Ditunggu ...';
    AIsHarusShow : Boolean  = True);
procedure cCloseWaitWindow;
function cOpenCDS(AQuery: string; AOwner: TComponent = nil): TCDS;
procedure cSetShowWaitWindowCaption(aCaption : String = 'Mohon Ditunggu ...');
function gShowForm(aFormClass : TFormClass) : TForm;
function parsing(char,str:string;count:integer):string;
function cLookUp(afrm:TForm;atitle:string):TStrings;overload;
function hitungqty(agrid : TAdvColumnGrid) : double ;
function cekKodeBayar(akode:string;akolom : string) :Boolean;
function cekKodeAccount(akode:string;akolom : string) : Boolean ;
function adaKodebayar(akode:string) : Boolean ;
function adaKodeVoucher(akode:string) : Boolean ;
function adaKodecenter(akode:string) : Boolean ;
function cekdetailaccount(akode:string):Boolean;
function getmaxid(atable : string; akode : string): Integer;
function cekedit(akodeuser:string;anamaform:string) : Boolean;
function cekinsert(akodeuser:string;anamaform:string) : Boolean;
function cekdelete(akodeuser:string;anamaform:string) : Boolean;
function GetCompanyLineSQL: String;
procedure cpreparehelp(afrm:TForm ; atitle :string);
procedure cCLOsehelp;
function getjumlah(kdbarang : string ; asatuan : string) : Double ;
function cekdatakonversi(akode:string;asatuan : string):boolean;
function cekdatakonversi2(akode:string;asatuan : string;asatuan2 : string):boolean;
function loadnilai(akode:string;asatuan : string;asatuan2 : string):Double;
function cekdataPO(akode:string):boolean;
function cekdatamutasi(akode:string):boolean;
function cekdatamutasi2(akode:string):boolean;
function cekdatamutasikode(akode:string):boolean;
function cekdataPO2(akode:string):boolean;
function cekdataapprovalPO(akode:string):boolean;
function cekdataapprovalPO2(akode:string):boolean;
function ceksatuan(asatuan:string):boolean;
function cekstatussuplier(akode:string):boolean;
function carigrid(aGrid : TAdvColumnGrid; akode : string ; acol : Integer =1): Boolean;
function getnomor(akode:string;tahun:integer) : string;
function cGetReportPath: String;
function cGetServerTime: TDateTime;
function HitungKarakter(const teks: Char; kalimat: String;
  caseSensitive: Boolean): Integer;
function getnama (atable : string; afielkunci : string ;afilter :string; afieldambil : string  ): string;
function getbarisslip (anama: string  ): integer;
function getid (atable : string; afielkunci : string ;afilter :string;   afieldambil : string ;afielkunci2 : string ='';afilter2 :string = ''): integer;
function getnominal (atable : string; afielkunci : string ;afilter :string; afieldambil : string  ): double;
function QuotD(aDate : TDateTime; aTambahJam235959 : Boolean = false): String;
function Quot(aString : String) : String;

var
  lResult    : TStrings;
  A:TPANEL;
  D:TPanel;
  C:TDBAdvStringGrid1;
//  B:TButton1;
  E:TEdit1;
  F:TLabel;
  G:TComboBox;
  SQLQuery1: TMyQuery;
  ds2: TDataSource;
  cds1 : TClientDataSet;
  DSP1 : TDataSetProvider;
//  RETURN : TObject;
implementation
  uses MAIN,uFrmbantuan ;
  

function QuotD(aDate : TDateTime; aTambahJam235959 : Boolean = false): String;
begin
    if not aTambahJam235959 then
    begin
         result := Quot(FormatDateTime('yyyy/mm/dd', aDate));
    end else
    begin
        result := Quot(FormatDateTime('yyyy-mm-dd hh:nn:ss', aDate));
    end;
end;
function Quot(aString : String) : String;
begin
    result := QuotedSTr(trim(Astring));
end;

function getnama (atable : string; afielkunci : string ;afilter :string; afieldambil : string  ): string;
var
  s : string ;
begin
  s := 'select  '+ afieldambil+ '  from  ' + atable + ' where ' + afielkunci + ' = ' + QuotedStr(afilter) ;
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      Result := Fields[0].AsString;
    finally
        Free;
     end;
  end;
end;

function getbarisslip (anama: string  ): integer;
var
  s : string ;
begin
  s := 'select  baris from  barisslip where Nama  = ' + QuotedStr(anama) ;
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      Result := Fields[0].AsInteger;
    finally
        Free;
     end;
  end;
end;


function getid (atable : string; afielkunci : string ;afilter :string;   afieldambil : string ;afielkunci2 : string ='';afilter2 :string = ''): integer;
var
  s : string ;
begin
  if afielkunci2 <> '' then
   s := 'select  '+ afieldambil+ '  from  ' + atable
   + ' where ' + afielkunci + ' = ' + QuotedStr(afilter)
   + ' and ' + afielkunci2 + ' = ' + QuotedStr(afilter2)
 else
  s := 'select  '+ afieldambil+ '  from  ' + atable + ' where ' + afielkunci + ' = ' + QuotedStr(afilter) ;
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      Result := Fields[0].AsInteger;
    finally
        Free;
     end;
  end;
end;


function getnominal (atable : string; afielkunci : string ;afilter :string; afieldambil : string  ): double;
var
  s : string ;
begin
  s := 'select  '+ afieldambil+ '  from  ' + atable + ' where ' + afielkunci + ' = ' + QuotedStr(afilter) ;
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      Result := Fields[0].Asfloat;
    finally
        Free;
     end;
  end;
end;

procedure autonumber(aGrid : TAdvColumnGrid);
var
 i : integer;
begin
   for i := 1 to agrid.rowcount-1 do
   begin
     agrid.Cells[0,i] := IntToStr(i);
   end;
  // TODO -cMM: TfrmBarang.autonumber default body inserted
end;

procedure hapusbaris(agrid: TAdvColumnGrid);
begin
  if (agrid.RowCount -1 <> 1) then
  begin
     agrid.RemoveRows(agrid.Row,1);
     autonumber(agrid);
  end
   else if agrid.RowCount-1 = 1 then
     cClearGrid(agrid,False);

end;

procedure cClearGrid(aGrd : TAdvColumnGrid; aClearFirstRow : boolean);
var
   i : INteger;
begin
   for i := aGrd.FixedRows to agrd.RowCount - 1 do
   begin
        aGrd.rows[i].Clear;
   end;

   if aClearFirstRow then
   begin
     aGrd.rows[0].Clear;
   end;

   agrd.RowCount := aGrd.FixedRows + 1;

end;

function carigrid(aGrid : TAdvColumnGrid; akode : string; acol : Integer =1): Boolean;
var
  u : integer;
begin
  Result := false;
   for u := 1 to aGrid.RowCount-1 do
   begin

       if (akode = aGrid.Cells[acol,u]) then
       begin
          Result := true;
          Exit;
       end;

   end;
end;


function getnomor(akode:string;tahun:integer) : string;
var
  ss,s: string;
  tsql : TMyQuery;

begin
  ss:='select * from nomerator where kode = '+ Quot(akode)
  + ' and tahun  = ' + IntToStr(tahun);
  tsql := xOpenQuery(ss,frmMenu.conn);
  with tsql do
  begin
    try
      if Eof then
      begin
        s:='insert into nomerator (kode,karakterawal,tahun,nomerator) values (' +Quot(akode)+','+quot(akode)+','+IntToStr(tahun)+', 0);';
        // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
        // xCommit(frmMenu.conn);
      end;
    finally
      free;
    end;
  end;

  s := 'select nomerator jml, karakterawal,kode from nomerator where kode =' + Quot(akode)
     + ' and tahun = ' + IntToStr(tahun);
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
     if  Fields[0].AsString = ''  then
      Result := Trim(Fields[1].AsString)+'/'+ Copy(IntToStr(100001),2,5)+'/'+inttostr(tahun)
      else
      Result := Trim(Fields[1].AsString)+'/'+ Copy(IntToStr(100001+ fieldbyname('jml').AsInteger),2,5)+'/'+inttostr(tahun);
    finally
        Free;
     end;
  end;
end;

function cGetReportPath: String;
 var
 ltemp : TStringList;

 begin

 ltemp := TStringList.Create;
 ltemp.loadfromfile(ExtractFileDir(application.ExeName) + '\' + 'default.cfg');
 Result :=  ltemp[4];
 ltemp.free;
 end;

function cGetServerTime: TDateTime;
var
    S: string;
begin
    S := 'Select now()';
    with xOpenQuery(S,frmMenu.conn) do
    begin
         Result := fields[0].AsDateTime;
         free;
    end;

end;

function Parsing(Char, Str: string; Count: Integer): string;
 var
   i: Integer;
   strResult: string;
begin
   if Str[Length(Str)] <> Char then
     Str := Str + Char;
   for i := 1 to Count do
   begin
     strResult := Copy(Str, 0, Pos(Char, Str) - 1);
     Str := Copy(Str, Pos(Char, Str) + 1, Length(Str));
  end;
   Result := strResult;
end;


function HitungKarakter(const teks: Char; kalimat: String;
  caseSensitive: Boolean): Integer;
var
  i,tmp: Integer;
begin
  i:= 0;
  tmp:= 0;
  while i <= Length(Kalimat) do
  begin
    if caseSensitive then
    begin
      if kalimat[i] = teks then Inc(tmp);
    end
    else
    begin
      if Lowercase(kalimat[i]) = Lowercase(teks) then Inc(tmp);
    end;
    Inc(i);
  end;
  Result:= tmp;
end;
procedure buatbutton(frm:TForm);
  var
  B: TButton;
  i: Integer;
begin
  for i := 0 to 9 do
  begin
    B := TButton.Create(frm);
    B.Caption := Format('Button %d', [i]);
    B.Parent := frm;
    B.Height := 23;
    B.Width := 100;
    B.Left := 10;
    B.Top := 10 + i * 25;
  end;
end;

function cekdatakonversi(akode:string;asatuan : string):boolean;
var
  s:string;
  tsql,tsql2:TMyQuery;
begin
  Result := False;
  s:='select * from bahan.master_konversi where kodebahan = '  + Quot(akode)
   + ' and (satuan1 = ' + Quot(asatuan) + ' or satuan2 = ' + Quot(asatuan)+ ')';
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if not Eof then
         Result := True
       else
       begin
         s:='select * from bahan.master_konversi where  '
          + ' (satuan1 = ' + Quot(asatuan) + ' or satuan2 = ' + Quot(asatuan)+ ')';
          tsql2:=xOpenQuery(s,frmMenu.conn);
          with tsql2 do
          begin
            try
               if not eof then
                  result:=True
                else
                     ShowMessage('Konversi ke satuan tersebut tidak ditemukan');
            finally
              free;
            end;
          end;
       end;



     finally
       tsql.free;
     end;
   end;
end;


function cekdatakonversi2(akode:string;asatuan : string;asatuan2 : string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
  s:='select * from bahan.master_konversi where kodebahan = '  + Quot(akode)
   + ' and satuan1 = ' + Quot(asatuan) + ' and satuan2 = ' + Quot(asatuan2 );
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if not Eof then
         Result := True
     finally
       tsql.free;
     end;
   end;
end;


function loadnilai(akode:string;asatuan : string;asatuan2 : string):Double;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := 0;
  s:='select jumlah from bahan.master_konversi where kodebahan = '  + Quot(akode)
   + ' and satuan1 = ' + Quot(asatuan) + ' and satuan2 = ' + Quot(asatuan2 );
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if not Eof then
         Result := Fields[0].AsFloat
     finally
       tsql.free;
     end;
   end;
end;

function cekdataPO(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select d.quantity qty_order from '
        + ' pembelian.mppb_header a '
        + ' inner join pembelian.mppb_detail b on a.nomor=b.nomor '
        + ' inner join bahan.master_bahan c on b.kodebahan=c.kode '
        + ' left join pembelian.po_detail d on d.id_mppb_detail=b.id and d.no_mppb=b.nomor'
        + '  WHERE a.nomor = ' + Quot(akode)
        + '  and d.quantity is null ';
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if eof  then
         Result := True
     finally
       free;
     end;
   end;
end;

function cekdatamutasi(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select approval from '
        + ' bahan.mutasi_keluar_header'
        + '  WHERE nomor = ' + Quot(akode) ;
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if Fields[0].AsString = 'True'  then
         Result := True
     finally
       free;
     end;
   end;
end;

function cekdatamutasi2(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select approval from '
        + ' bahan.mutasi_masuk_header'
        + '  WHERE nomor = ' + Quot(akode) ;
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if not Eof  then
         Result := True
     finally
       free;
     end;
   end;
end;


function cekdatamutasikode(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select * from '
        + ' bahan.mutasi_kode_header'
        + '  WHERE nomor = ' + Quot(akode) ;
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
        if not Eof  then
         Result := True
     finally
       free;
     end;
   end;
end;

function cekdataPO2(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select d.quantity qty_order from '
        + ' pembelian.mppbj_header a '
        + ' inner join pembelian.mppbj_detail b on a.nomor=b.nomor '
        + ' inner join barangjadi.master_barang c on b.kodebarang=c.kode '
        + ' left join pembelian.pobj_detail d on d.idmppb_detail=b.id and d.no_mppb=b.nomor'
        + '  WHERE a.nomor = ' + Quot(akode)
        + '  and d.quantity is null ';
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if eof  then
         Result := True
     finally
       free;
     end;
   end;
end;
function cekdataapprovalPO(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select approval from pembelian.po_header where nomor = ' + Quot(akode);
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try

       if Fields[0].AsBoolean  then
         Result := True
     finally
       free;
     end;
   end;
end;

function cekdataapprovalPO2(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select approval from pembelian.pobj_header where nomor = ' + Quot(akode);
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try

       if Fields[0].AsBoolean  then
         Result := True
     finally
       free;
     end;
   end;
end;

function ceksatuan(asatuan:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select * from bahan.master_satuan where satuan = ' + Quot(asatuan);
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if not eof  then
         Result := True
     finally
       free;
     end;
   end;
end;

function cekstatussuplier(akode:string):boolean;
var
  s:string;
  tsql:TMyQuery;
begin
  Result := False;
   S := 'select * from relasi.master_supplier where kode = ' + Quot(akode)
     + ' and status=1';
   tsql := xOpenQuery(s,frmMenu.conn) ;
   with tsql do
   begin
     try
       if not eof  then
         Result := True
     finally
       free;
     end;
   end;
end;



function getjumlah(kdbarang : string ; asatuan : string) : Double ;
var
  s: string;
  tsql2,tsql : TMyQuery;
begin
  result:=0;
  if asatuan = getnama('bahan.master_bahan','kode',kdbarang,'satuangudang') then
    Result := 1
  else
  begin
     s:= 'select jumlah from bahan.master_konversi  where kode = ' + Quot(kdbarang)
        + ' and satuan1 = ' + Quot(asatuan)
        + ' and satuan2 = '+ Quot(getnama('bahan.master_bahan','kode',kdbarang,'satuangudang')) ;
    tsql := xOpenQuery(s,frmMenu.conn) ;
    with tsql do
    begin
      try
        if not Eof then
          result := Fields[0].AsFloat
        else
        begin
           s:= 'select jumlah from bahan.master_konversi  where '
              + ' satuan1 = ' + Quot(asatuan)
              + ' and satuan2 = '+ Quot(getnama('bahan.master_bahan','kode',kdbarang,'satuangudang')) ;
          tsql2 := xOpenQuery(s,frmMenu.conn) ;
          with tsql2 do
          begin
            try
              if not Eof then
                result := Fields[0].AsFloat;
            finally
             tsql2.Free;
            end;
          end;
        end;
      finally
       tsql.Free;
      end;
    end;
  end;

end;

procedure cpreparehelp(afrm:TForm ; atitle :string );
var
  z,i:Integer;
begin
  cclosehelp;
//  RETURN := Sender;

      A := TPanel.Create(afrm);
      A.Caption := '';
      A.Height := 300;
      A.Width := 500;
      A.Left := 200;
      A.Top := 100;
      A.Parent := afrm;
      D := TPanel.Create(afrm);
      D.Caption := '';
      D.Height := 55;
      D.Parent := A;
      d.Color := clSilver;
      D.Align:= alTop;
//        B := TButton1.Create(afrm);
//        B.Caption := 'Cari';
//        B.Parent := D;
//        B.Height := 23;
//        B.Width := 60;
//        B.Left := 400;
//        B.toP := 27;

        E := TEdit1.Create(afrm);
//        E.Name := 'edtfilter';
        E.Text := '';
        E.Parent := D;
        E.Height := 23;
        E.Width := 300;
        E.Left := 80;
        E.toP := 27;
        e.TabOrder := 1;
        e.SetFocus;
        F := TLabel.Create(afrm);
        F.Caption := 'DAFTAR ' +atitle;
        F.Parent := D;
        F.Height := 23;
        F.Width := 400;
        F.Left := 80;
        F.toP := 10;
        G :=  TComboBox.Create(afrm);
//        G.Name := 'cbbfilter';

        G.Parent := D ;
        G.Height := 23;
        G.toP := 27;
        G.Width := 70;
        G.Left := 10;
        G.Clear;
        g.TabOrder := 0;
        i:=hitungkarakter(',',sqlfilter,False)+1;
        for z:=1 to i do
        begin
          G.AddItem(Parsing(',',sqlfilter,z),G);
          G.ItemIndex := 0;
        end;
      C := TDBAdvStringGrid1.Create(afrm);
      C.Parent := A;
      C.Align := alClient;
      C.Color := clSkyBlue;
      C.ReadOnly := False;

      SQLQuery1:= TMyQuery.Create(afrm);
      DSP1:= TDataSetProvider.Create(afrm);
      cds1:=TClientDataSet.Create(afrm);
      ds2:= TDataSource.Create(afrm);
      cds1.close;
      SQLQuery1.SQLConnection := frmMenu.conn;
      SQLQuery1.SQL.Text := sqlbantuan;
//    SQLQuery1:=xOpenQuery(sqlbantuan,frmMenu.conn);
      DSP1.DataSet := SQLQuery1;
      DSP1.Name := 'DSP1';

      cds1.ProviderName :='DSP1';
      cds1.Open;
      ds2.DataSet := cds1;
      c.DataSource := ds2;
      c.autosize := True;
      cds1.ReadOnly := True;
end;

procedure Tbutton1.Click;
begin
//  A.Hide;
cds1.close;
   SQLQuery1.sql.Text := sqlbantuan + ' where ' + G.text +' like ' + Quot(E.Text+'%');
cds1.open;


end;

procedure cCLOsehelp;
begin
   if C <> nil then
     FreeAndNil(C);
  if ds2 <> nil then
     FreeAndNil(ds2);
  if CDS1 <> nil then
     FreeAndNil(CDS1);
  if DSP1 <> nil then
     FreeAndNil(DSP1);
  if SQLQuery1 <> nil then
     FreeAndNil(SQLQuery1);
//  if B <> nil then
//     FreeAndNil(B);
  if E <> nil then
     FreeAndNil(E);
  if F <> nil then
     FreeAndNil(F);
  if G <> nil then
     FreeAndNil(G);
  if D <> nil then
     FreeAndNil(D);
  if A <> nil then
     FreeAndNil(A);
end;

procedure TEdit1.KeyPress(var key:Char);
begin
  if Key =#13 then
  begin
     cds1.close;
     SQLQuery1.sql.Text := sqlbantuan + ' where ' + G.text +' like ' + Quot(E.Text+'%');
     cds1.open;
  end;
  IF Key = #27 then
    a.Hide;
  IF Key = #40 then
    c.SetFocus;

end;

procedure TDBAdvStringGrid1.KeyPress(var key:Char);
begin
  if Key =#13 then
  begin
    setresult;
    varglobal:=Cds1.Fields[0].AsString;
//    varglobal1:=Cds1.Fields[1].AsString;
//    varglobal2:=Cds1.Fields[2].AsString;
    a.Hide;

    
  end;
  IF Key = #27 then
    a.Hide;


end;


procedure SetResult;
var
  i: Integer;
begin
  if assigned(lResult) then FreeandNil(lResult);
  lResult := TStringList.Create;
  
  lResult.Clear;
  
//  if lAdvColGrid.Row < lAdvColGrid.FixedRows then
//  begin
//    CommonDlg.ShowError('Pilih Datanya Dulu Dong. Kekekekekeek ...');
//    exit;
//  end;

  for i := 1 to cds1.FieldCount - 1 do
  begin
    lResult.Append(Cds1.Fields[0].AsString);
  end;
end;

function cLookUp(afrm:TForm):
    Tstrings;
begin
  result := cLookUp(afrm,'Pencarian');
end;
function cLookUp(afrm:TForm;atitle:string):
    Tstrings;
begin
    cpreparehelp(afrm,atitle);

//    screen.cursor := crDefault;
    if not Assigned(lResult) then
    begin
      lResult := TStringList.create;
    end;
    SetResult;
    result := lResult;

end;



function hitungqty(agrid : TAdvColumnGrid) : double ;
var
  i: integer;
  xjml :Double;
begin
   xjml :=0;
   with agrid do
   begin
        for i := 1 to RowCount -1 do
        begin
           xjml :=xjml + Floats[3,i];
        end;
   end;
   Result := xjml;
end;

function cekKodeBayar(akode:string;akolom : string) : Boolean ;
var
  tsql : TMyQuery;
  afilter,s:String;
  a,i:Integer;
begin
  result:= False;
  s:= 'select kolom from hutang.master_kodevoucher where kode = ' + Quot(akode) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;
  afilter := '';
  with tsql do
  begin
    try
      i:=HitungKarakter(',',fields[0].AsString,False);
      for a :=1 to i+1 do
      begin
        if a=1 then
          afilter := afilter + ' where (kode like ' + quot(Parsing(',',Fields[0].AsString,a))
        else
          afilter := afilter + ' or kode like ' + Quot(Parsing(',',Fields[0].AsString,a));
      end;
    finally
      free;
    end
  end;
  s:= 'select * from hutang.master_kodebayar '+  afilter + ') AND kode ='+Quot(akolom);
  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      if not Eof then
      Result := True;

    finally
      free;
    end;
  end;


end;


function cekKodeAccount(akode:string;akolom : string) : Boolean ;
var
  tsql : TMyQuery;
   s:String;

begin
  result:= False;
  s:= 'select * from master_account where kode like  ' + Quot(akode+'%')
     + ' and kode = '+ Quot(akolom) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;

  with tsql do
  begin
    try
      IF NOT Eof then
          Result := True;
    finally
      free;
    end
  end;

end;


function adaKodebayar(akode:string) : Boolean ;
var
  tsql : TMyQuery;
   s:String;

begin
  result:= False;
  s:= 'select * from hutang.master_kodebayar where kode like  ' + Quot(akode) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      IF NOT Eof then
          Result := True;
    finally
      free;
    end
  end;

end;

function adaKodecenter(akode:string) : Boolean ;
var
  tsql : TMyQuery;
   s:String;

begin
  result:= False;
  s:= 'select * from master_costcenter where kode like  ' + Quot(akode) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      IF NOT Eof then
          Result := True;
    finally
      free;
    end
  end;

end;
function adaKodeVoucher(akode:string) : Boolean ;
var
  tsql : TMyQuery;
   s:String;

begin
  result:= False;
  s:= 'select * from hutang.voucher_uang_muka_header where nomor like  ' + Quot(akode) ;
  tsql := xOpenQuery(s,frmMenu.conn) ;
  with tsql do
  begin
    try
      IF NOT Eof then
          Result := True;
    finally
      free;
    end
  end;

end;

function cekdetailaccount(akode:string):Boolean;
var
  s: string;
  tsql : TMyQuery;
begin
  s:= 'select COUNT(*) jml from master_account where kode LIKE ' + Quot(akode+'%') ;
tsql := xopenquery(s,frmmenu.conn);
with tsql do
begin
try
  if Fields[0].AsInteger=1 then
     Result := True
  else
     Result := False;
finally
  free;
end;
end;
end;

function getmaxid(atable : string; akode : string): Integer;
var
  S: string;
  tsql : TMyQuery ;
begin
//  result := 0;
   s:= 'select max(' + akode + ') as jml from '+ atable +';';
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try
     with tsql do
     begin
       Result := fieldbyname('jml').AsInteger +1 ;
     end;
   finally
     tsql.Free;
   end;
end;

function cekedit(akodeuser:string;anamaform:string) : Boolean;
var
  s: string;
  tsql : TMyQuery;
begin
  Result:= False;
  s:= ' select hak_men_edit from tuser a inner join thakuser  b on a.user_kode =b.hak_user_kode '
    + ' inner join tmenu c on c.men_id =b.hak_men_id '
    + ' where a.user_kode='+ Quot(akodeuser)
    + ' and c.men_nama = ' + Quot(anamaform) ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
    if Fields[0].AsString = 'Y' then
       Result := True;
   finally
    free;
   end;
  end;
end;
function cekinsert(akodeuser:string;anamaform:string) : Boolean;
var
  s: string;
  tsql : TMyQuery;
begin
  Result:= False;
  s:= ' select hak_men_insert from tuser a inner join thakuser  b on a.user_kode =b.hak_user_kode '
    + ' inner join tmenu c on c.men_id =b.hak_men_id '
    + ' where a.user_kode='+ Quot(akodeuser)
    + ' and c.men_nama = ' + Quot(anamaform)  ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
    if Fields[0].AsString = 'Y' then
       Result := True;
   finally
     free;
   end;
  end;
end;

function cekdelete(akodeuser:string;anamaform:string) : Boolean;
var
  s: string;
  tsql : TMyQuery;
begin
  Result:= False;
  s:= ' select hak_men_delete from tuser a inner join thakuser  b on a.user_kode =b.hak_user_kode'
    + ' inner join tmenu c on c.men_id =b.hak_men_id '
    + ' where a.user_kode='+ Quot(akodeuser)
    + ' and c.men_nama = ' + Quot(anamaform)   ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
    if Fields[0].AsString = 'Y' then
       Result := True;
   finally
     free;
   end;      
  end;
end;

function GetCompanyLineSQL: String;
var
   CL1, CL2, CL3, CL4, CL5,CL6,CL7, CL8, CL9, CL10 : String;
begin
     GetCompanyLine(CL1, CL2, CL3, CL4 , CL5,CL6,CL7,CL8,CL9,CL10);
     Result := ' ' + QuotedSTr(CL1) + ' as CL1, '
            + ' ' + QuotedSTr(CL2) + ' as CL2, '
            + ' ' + QuotedSTr(CL3) + ' as CL3, '
            + ' ' + QuotedSTr(CL4) + ' as CL4, '
            + ' ' + QuotedSTr(CL5) + ' as CL5, '
            + ' ' + QuotedSTr(CL6) + ' as CL6, '
            + ' ' + QuotedSTr(CL7) + ' as CL7, '
            + ' ' + QuotedSTr(CL8) + ' as CL8, '
            + ' ' + QuotedSTr(CL9) + ' as CL9, '
            + ' ' + QuotedSTr(CL10) + ' as CL10, '

end;

procedure GetCompanyLine(var CL1 : String; var CL2 : String; var CL3 : String ; var CL4 : String ; var CL5 : String ;var CL6 : String ;var CL7 : STRING;var CL8 : STRING;var CL9 : STRING; var CL10 : STRING );
var
   Q : TSQLQuery;
   S : String;
begin
     CL1 := '';
     CL2 := '';
     CL3 := '';
     CL4 := '';
     CL5 := '';
     CL6 := '';
     CL7 := '';
     CL8 := '';
     CL9 := '';
     CL10 := '';
     //BuatQueryIB(Q);
     S := 'Select perush_nama,perush_alamat,perush_kota,perush_telp,perush_fax,perush_npwp,perush_tglnpwp,perush_kdpos from tperusahaan' ;
     Q := xOpenQuery(S,frmmenu.conn);
     if not q.Eof then
     begin
          CL1  := q.Fields[0].AsString;
          CL2  := q.Fields[1].AsString;
          CL3  := q.Fields[2].AsString;
          CL4  := q.Fields[3].AsString;
          CL5  := q.Fields[4].AsString;
          CL6  := q.Fields[5].AsString;
          CL7  := FormatDateTime('dd-MMM-yyyy',q.Fields[6].AsDateTime);
          CL8  := q.Fields[7].AsString;

     end;
     FreeAndNil(Q);
end;

procedure savetoexcelnew(agrid : TAdvColumnGrid;aket:string='');
var
  j , i ,baris, kolom : Integer;
    objExcel : TExcelApplication ;
    objWB : _Workbook ;
begin
    baris:=agrid.RowCount; // number of rows
    kolom:=agrid.ColCount; // number of columns

    objExcel := TExcelApplication.Create(nil);
    objExcel.Visible[0] := TRUE;
    objWB := objExcel.Workbooks.Add(Null,1);

    for j:=1 to kolom do
    objWB.Worksheets.Application.Cells.Item[1,j]:=agrid.Cells[j-1,0];


    for i:=1 to baris do
    begin
    for j:=1 to kolom do
    objWB.Worksheets.Application.Cells.Item[i+1,j]:=agrid.cells[j-1,i];

    end;
    
    objExcel.Free;

end;
function StrPadcenter(const S: String; Len: Integer; C: Char): String;
var
  L, i: Integer;
  tmp : string;
begin
  L := Length(S);
  if L < Len then
  begin
    tmp:= '';
    for i:= 1 to (ROUND(Len/2)- Round(L/2)) do
    begin
      tmp:=  tmp + C;
    end;
    Result:= tmp + S;
  end;
end;
function StrPadRight(const S: String; Len: Integer; C: Char): String;
var
  L,i: Integer; temp: string;
begin
  L := Length(S);
  {modif by: didit @2007.11.02}
  if L < Len then
  begin
    temp:= S;
    for i:=1 to (Len-L) do
      temp := temp + C;
    Result := temp;
  end
  else if (L = Len) then
  begin
    Result := S;
  end
  else
  begin
    temp:= '';
    for i:=1 to Len do
      temp := temp + S[i];
    Result := temp;
  end;
end;

function StrPadLeft(const S: String; Len: Integer; C: Char): String;
var
  L, i: Integer;
  tmp : string;
begin
  L := Length(S);
  if L < Len then
  begin
    tmp:= S;
    for i:= 1 to (Len-L) do
    begin
      tmp:= C + tmp;
    end;
    Result:= tmp;
  end;
end;

var
   FWaitForm : TForm;

procedure cShowWaitWindow(aCaption : String = 'Mohon Ditunggu ...';
    AIsHarusShow : Boolean  = True);
begin
    // TODO -cMM: cShowWaitWindow default body inserted
    if not AIsHarusShow then
      Exit;

    if FWaitForm = nil then
    begin
        FWaitForm := TForm.Create(application);
        FWaitForm.BorderStyle := bsNone;
        FWaitForm.Width := Screen.Width div 3;
        FWaitForm.Height := Screen.Height div 10;
        FWaitForm.Position := poScreenCenter;
        FWaitForm.FormStyle := fsStayOnTop;

        with TPanel.Create(FWaitForm) do
        begin
            Parent := FWaitForm;
            Align := alClient;
            Font.Name := 'Verdana';
            Font.Size := 10;
            Font.Style := [fsBold];
            Font.Color := clBlue;
            Caption := aCaption;
            BevelInner := bvLowered;
            //Color := clYellow;
            Color := clGradientActiveCaption;
        end;
    end else
    begin
        cSetShowWaitWindowCaption(aCaption);
    end;
    FWaitForm.Show;
    screen.Cursor := crDefault;
end;

procedure cCloseWaitWindow;

begin
    // TODO -cMM: cCloseWaitWindow default body inserted
    if FWaitForm <> nil then
    begin
        FWaitForm.Release;
        //FWaitForm := nil;
        FreeAndNil(FWaitForm);
        Screen.Cursor := crDefault;
    end;
end;
function cOpenCDS(AQuery: string; AOwner: TComponent = nil):
    TCDS;
var
  LDSP: TDataSetProvider;
  LSQLQuery: TMyQuery;
begin
  Result      := TCDS.Create(AOwner);
  LDSP        := TDataSetProvider.Create(Result);
  LSQLQuery   := TMyQuery.Create(LDSP);
  try

    LSQLQuery.SQLConnection := frmMenu.conn;
    LSQLQuery.SQL.Append(aQuery);

    LDSP.DataSet            := LSQLQuery;
    Result.SetProvider(LDSP);
    Result.Open;
  except
    on E: Exception do
    begin
      MessageDlg('Open ClientDataset Failed. Check your Query!' + #13 + E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

procedure cSetShowWaitWindowCaption(aCaption : String = 'Mohon Ditunggu ...');
begin
    if FWaitForm <> nil then
    begin
        (FWaitForm.Components[0] as TPanel).Caption := aCaption;
    end;
end;
function gShowForm(aFormClass : TFormClass) : TForm;
var
  aForm : TForm;
begin
     aForm := aFormClass.Create(Application);
     aForm.FormStyle := fsMDIChild;
     aForm.Enabled := true;
     aForm.WindowState := wsNormal;

     result := (aForm as aFormClass);


end;
end.

