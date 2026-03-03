unit ufrmSerahTerimaFaktur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, StdCtrls, AdvEdit,SqlExpr, Menus,
  cxLookAndFeelPainters, cxButtons,StrUtils, cxGraphics, cxLookAndFeels,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBExtLookupComboBox, DBClient, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxSpinEdit, cxCurrencyEdit, AdvEdBtn,DateUtils,
  cxCalendar, cxCheckBox, MyAccess;

type
  TfrmSerahTerimaFaktur = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clInvoice: TcxGridDBColumn;
    clTglInvoice: TcxGridDBColumn;
    clTerbayar: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    clNilai: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    clStatus: TcxGridDBColumn;
    Label10: TLabel;
    edtmemo: TMemo;
    clPPN: TcxGridDBColumn;
    clSalesman: TcxGridDBColumn;
    Label1: TLabel;
    Label4: TLabel;
    edtPenyerah: TEdit;
    cxLookupUser: TcxExtLookupComboBox;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode:string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure HapusRecord1Click(Sender: TObject);
    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    function cekdata:Boolean;
    procedure loaddataInvoice(akode : string);
    procedure loaddataall(akode : string);

  private
    FCDSuser: TClientDataset;
    FFLAGEDIT: Boolean;
    FID: string;
    atanggalold:TDateTime;
    function GetCDSuser: TClientDataset;
    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSuser: TClientDataset read GetCDSuser write FCDSuser;
    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
        procedure doslip(anomor : string );
    { Public declarations }
  end;

var
  frmSerahTerimaFaktur: TfrmSerahTerimaFaktur;
const
   NOMERATOR = 'ST';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmfp;

{$R *.dfm}

procedure TfrmSerahTerimaFaktur.refreshdata;
begin
  FID:='';

  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtPenyerah.Text := frmMenu.KDUSER;
  edtnomor.Text := getmaxkode;
  cxLookupUser.EditValue := '';
  edtmemo.Clear;
  dtTanggal.SetFocus;
  initgrid;
  loaddataInvoice(edtpenyerah.text);
end;
procedure TfrmSerahTerimaFaktur.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;
procedure TfrmSerahTerimaFaktur.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmSerahTerimaFaktur.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmSerahTerimaFaktur.getmaxkode:string;
var
  s:string;
begin
 s:='select max(right(sth_nomor,4)) from tserahterimafaktur_hdr where sth_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%');
  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(10000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
end;

procedure TfrmSerahTerimaFaktur.cxButton1Click(Sender: TObject);
begin
    try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
    
      If not cekdata then exit;

      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
end;

procedure TfrmSerahTerimaFaktur.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmSerahTerimaFaktur.cxButton2Click(Sender: TObject);
begin
   try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
   
     If not cekdata then exit;

      if (FLAGEDIT) and ( not cekedit(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Edit di Modul ini',mtWarning, [mbOK],0);
           Exit;
        End;
         if (not FLAGEDIT) and ( not cekinsert(frmMenu.KDUSER,self.name)) then
        begin
           MessageDlg('Anda tidak berhak Insert di Modul ini',mtWarning, [mbOK],0);;
           Exit;
        End;

      if MessageDlg('Yakin ingin simpan ?',mtCustom,
                                  [mbYes,mbNo], 0)= mrNo
      then Exit ;

      simpandata;
      refreshdata;
   except
     ShowMessage('Gagal Simpan');
     // xRollback(frmMenu.conn);
     Exit;
   end;
    // xCommit(frmMenu.conn);
    Release;
end;

procedure TfrmSerahTerimaFaktur.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupuser.Properties) do
    LoadFromCDS(CDSuser, 'Kode','nama',['Kode'],Self);
     TcxExtLookupHelper(cxLookupuser.Properties).SetMultiPurposeLookup;

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmSerahTerimaFaktur.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Salesman', ftString, False,50);
    zAddField(FCDS, 'Faktur', ftString, False,20);
    zAddField(FCDS, 'Tanggal', ftDate, False);
    zAddField(FCDS, 'PPN', ftFloat, False);
    zAddField(FCDS, 'Nilai', ftFloat, False);
    zAddField(FCDS, 'Customer', ftstring, False,200);
    zAddField(FCDS, 'check', ftInteger, False);
    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmSerahTerimaFaktur.GetCDSuser: TClientDataset;
var s:String;
begin
  If not Assigned(FCDSuser) then
  begin
    S := 'select user_kode kode,user_nama nama'
        +' from tuser order by user_nama ';


    FCDSuser := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDSuser;
end;

procedure TfrmSerahTerimaFaktur.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmSerahTerimaFaktur.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmSerahTerimaFaktur.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;
end;


procedure TfrmSerahTerimaFaktur.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
  anomornew:string;
begin
  anomorold := edtNomor.Text;
  anomornew := getmaxkode;
  if FLAGEDIT then
  begin
    if Copy(anomornew,1,11) <> Copy(anomorold,1,11)then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.Date :=atanggalold;
    end;
  end;
end;


procedure TfrmSerahTerimaFaktur.simpandata;
var
  s:string;
  atax,i:integer;
  tt:TStrings;

begin

if FLAGEDIT then
  s:='update tserahterimafaktur_HDR set '
    + ' sth_terima = ' + Quot(cxLookupuser.EditValue) + ','
    + ' sth_memo = ' + Quot(edtmemo.Text) + ','
    + ' sth_tanggal = ' + Quotd(dtTanggal.Date)+','
    + ' sth_serah = ' + Quot(edtpenyerah.Text) + ','
    + ' date_modify  = ' + QuotD(cGetServerTime,True) + ','
    + ' user_modify = ' + Quot(frmMenu.KDUSER)
    + ' where STH_nomor = ' + quot(FID) + ';'
else
begin
  edtNomor.Text := getmaxkode;
    s :=  ' insert into tSERAHTERIMAfaktur_HDR '
             + ' (sth_nomor,sth_tanggal,sth_serah,sth_terima,sth_memo,date_create,user_create) '
             + ' values ( '
             + Quot(edtNomor.Text) + ','
             + Quotd(dtTanggal.Date) + ','
             + Quot(edtPenyerah.Text) + ','
             + Quot(cxLookupuser.EditValue)+','
             + Quot(edtmemo.Text)+','
             + QuotD(cGetServerTime,True) + ','
             + Quot(frmMenu.KDUSER)+')';
end;
  // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);


     tt := TStringList.Create;
   s:= ' delete from tserahterimafaktur_DTL '
      + ' where  std_sth_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('check').AsInteger = 1 then
   begin
    S:='insert into tserahterimafaktur_DTL (std_sth_nomor,std_fp_nomor) values ('
      + Quot(edtNomor.Text) +','
      + quot(CDS.FieldByName('faktur').AsString)
      + ');';
    tt.Append(s);
   end;
    CDS.Next;
    Inc(i);
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
end;


function TfrmSerahTerimaFaktur.cekdata:Boolean;
var
  i:integer;
  abayar,atotal : double;
begin
  result:=true;
   i := 1;
     If cxLookupuser.EditValue = '' then
    begin
      ShowMessage('Penerima belum di pilih');
      result:=false;
      Exit;

    end;

end;

procedure TfrmSerahTerimaFaktur.loaddataInvoice(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin

   s := ' select sls_nama salesman,fp_nomor,fp_tanggal,fp_jthtempo,fp_taxamount,fp_amount,FP_DP, '
      + ' ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur, '
      + ' ifnull((select sum(retj_cn) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur_cn, '
      + ' ifnull(fp_bayar,0) Bayar ,cus_nama'
      + ' from tfp_hdr '
      + ' inner join tcustomer on cus_kode=fp_cus_kode'
      + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
      + ' inner join tso_hdr on so_nomor=do_so_nomor '
      + ' left join tsalesman on sls_kode=so_sls_kode '
      + ' where fp_status_faktur = '+ Quot(akode);

//     s := s + ' having (fp_amount-(retur)-fp_dp)- bayar > 1 ' ;

     s:= s + ' order by fp_tanggal,fp_nomor ';

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
             CDS.EmptyDataSet;
          if not eof then
         begin

            i:=1;

            while  not Eof do
             begin

                      CDS.Append;
                      CDS.FieldByName('salesman').AsString        := fieldbyname('salesman').AsString;
                      CDS.FieldByName('faktur').AsString        := fieldbyname('fp_nomor').AsString;
                      CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('fp_tanggal').AsDateTime;
                      CDS.FieldByName('PPN').AsFloat      := fieldbyname('fp_taxamount').AsFloat;
                      CDS.FieldByName('nilai').AsFloat      := fieldbyname('fp_amount').AsFloat;
                      CDS.FieldByName('customer').Asstring        := fieldbyname('cus_nama').asstring;
                      CDS.FieldByName('check').AsInteger      := 0;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
        end
        else
        begin
          cxLookupuser.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;

end;


procedure TfrmSerahTerimaFaktur.loaddataall(akode : string);
var
  s: string ;
  tsql,tsql2 : TMyQuery;
  a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtyterima : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select '
     + ' sth_nomor,sth_tanggal,sth_terima,sth_serah,sth_memo'
     + ' from tserahterimafaktur_hdr '
     + ' where sth_nomor = '+ Quot(akode);

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            FID :=fieldbyname('sth_nomor').AsString;
            edtnomor.Text := fieldbyname('sth_nomor').AsString;
            dttanggal.DateTime := fieldbyname('sth_tanggal').AsDateTime;

            edtmemo.Text := fieldbyname('sth_memo').AsString;
            edtpenyerah.text := fieldbyname('sth_serah').AsString;
            cxLookupuser.EditValue  := fieldbyname('sth_terima').AsString;

            i:=1;
             s := ' select sls_nama Salesman,fp_nomor,fp_tanggal,fp_jthtempo,fp_taxamount,fp_amount,FP_DP, '
              + ' ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur, '
              + ' ifnull((select sum(retj_cn) from tretj_hdr where retj_fp_nomor=fp_nomor),0) retur_cn, '
              + ' ifnull(fp_bayar,0) Bayar,std_sth_nomor,cus_nama '
              + ' from tfp_hdr '
              + ' inner join tcustomer on cus_kode=fp_cus_kode'
              + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
              + ' inner join tso_hdr on so_nomor=do_so_nomor '
              + ' left join tsalesman on sls_kode=so_sls_kode '
              + ' left join tserahterimafaktur_dtl on std_fp_nomor=fp_nomor'
              + ' and std_sth_nomor ='+quot(akode) 
              + ' where fp_status_faktur = '+ Quot(frmMenu.KDUSER) ;

             s := s + ' having (fp_amount-(retur)-fp_dp)- bayar > 1 ' ;
             s:= s + ' order by fp_tanggal,FP_NOMOR ';
             tsql2 := xOpenQuery(s,frmMenu.conn);
             cds.EmptyDataSet;
           with tsql2 do
           begin
            try
                while  not Eof do
                begin
                    CDS.first;


                          CDS.Append;
                          CDS.FieldByName('salesman').AsString        := fieldbyname('salesman').AsString;
                          CDS.FieldByName('faktur').AsString        := fieldbyname('fp_nomor').AsString;
                          CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('fp_tanggal').AsDateTime;
                          CDS.FieldByName('PPN').AsFloat      := fieldbyname('fp_taxamount').AsFloat;
                          CDS.FieldByName('nilai').AsFloat      := fieldbyname('fp_amount').AsFloat;
                          CDS.FieldByName('customer').Asstring        := fieldbyname('cus_nama').asstring;
                          if FieldByName('std_sth_nomor').Asstring <> '' then
                             CDS.FieldByName('check').AsInteger      := 1
                          else
                          CDS.FieldByName('check').AsInteger      := 0;

                        CDS.Post;

                      Inc(i);


                  next;
                end ;
            finally
             tsql2.Free;
            end;
           end;


        end
        else
        begin
          ShowMessage('Nomor  tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;


   end;

end;


procedure TfrmSerahTerimaFaktur.doslip(anomor : string );
var
  s: string ;
  ftsreport : TTSReport;
begin

  ftsreport := TTSReport.Create(nil);
  try
    ftsreport.Nama := 'ST';

          s:= ' select '
       + ' * '
       + ' from tserahterimafaktur_hdr '
       + ' inner join tserahterimafaktur_dtl on std_sth_nomor=sth_nomor'
       + ' inner join tfp_hdr on fp_nomor=std_fp_nomor'
       + ' inner join tdo_hdr on do_nomor=fp_do_nomor'
       + ' inner join tso_hdr on so_nomor=do_so_nomor'
       + ' inner join tcustomer on fp_cus_kode=cus_kode '
       + ' inner join tsalesman on so_sls_kode=sls_kode'
       + ' where '
       + ' sth_nomor=' + quot(anomor);
    ftsreport.AddSQL(s);
    ftsreport.ShowReport;
  finally
     ftsreport.Free;
  end;
end;




end.
