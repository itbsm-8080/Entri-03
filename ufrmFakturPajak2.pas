unit ufrmFakturPajak2;

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
  cxCalendar, cxCheckBox, cxButtonEdit, frxClass, frxExportPDF, MyAccess;

type
  TfrmFakturPajak2 = class(TForm)
    PANEL: TAdvPanel;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    AdvPanel4: TAdvPanel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    dttanggal2: TDateTimePicker;
    cxButton3: TcxButton;
    Label16: TLabel;
    edtPajak: TAdvEdit;
    Label17: TLabel;
    dtTanggalPajak: TDateTimePicker;
    btnRefresh: TcxButton;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clSalesman: TcxGridDBColumn;
    clInvoice: TcxGridDBColumn;
    clTglInvoice: TcxGridDBColumn;
    clPPN: TcxGridDBColumn;
    clNilai: TcxGridDBColumn;
    clStatus: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    clNoPajak: TcxGridDBColumn;
    clNegri: TcxGridDBColumn;
    clTanggalPajak: TcxGridDBColumn;
    clCustomer: TcxGridDBColumn;
    cxButton4: TcxButton;
    cxGrdMainColumn1: TcxGridDBColumn;
    cxGrdMainColumn2: TcxGridDBColumn;
    chkManual: TCheckBox;
    PopupMenu1: TPopupMenu;
    CheckAllStatus1: TMenuItem;
    UncheckAllStatus1: TMenuItem;
    clManual: TcxGridDBColumn;
    cxGrdMainColumn3: TcxGridDBColumn;
    cxGrdMainColumn4: TcxGridDBColumn;
    procedure refreshdata;
   procedure initgrid;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function getmaxkode(aispajak:Integer=1):string;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function GetCDS: TClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);
    procedure simpandata;
    procedure cxButton3Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure CheckAllStatus1Click(Sender: TObject);
    procedure UncheckAllStatus1Click(Sender: TObject);
  private
    FCDSSKU : TClientDataset;

    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;





    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;


    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmFakturPajak2: TfrmFakturPajak2;
const
   NOMERATOR = 'FP';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmcetak;

{$R *.dfm}

procedure TfrmFakturPajak2.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;

end;
procedure TfrmFakturPajak2.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.FieldByName('QTY').AsInteger    := 0;
  CDS.Post;

end;
procedure TfrmFakturPajak2.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmFakturPajak2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmFakturPajak2.getmaxkode(aispajak:integer=1):string;
var
  s:string;
begin
  if aispajak=1 then
  begin
  s:='select max(right(fp_nomor,4)) from tfp_hdr '
  + ' where fp_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and fp_istax=1 ';
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
  end
  else
  begin
  s:='select max(right(fp_nomor,3)) from tfp_hdr '
  + ' where fp_nomor like ' + quot(frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.%')
  + ' and fp_istax=0 ';

  with xOpenQuery(s,frmMenu.conn) do
  begin
    try
      if Fields[0].AsString = '' then
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+1),4)
      else
         result:= frmMenu.kdcabang + '-' +NOMERATOR+'.'+FormatDateTime('yymm',dtTanggal.Date)+'.'+RightStr(IntToStr(15000+fields[0].AsInteger+1),4);

    finally
      free;
    end;
  end;
  end;
end;

procedure TfrmFakturPajak2.cxButton1Click(Sender: TObject);
begin
    try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;


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

procedure TfrmFakturPajak2.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmFakturPajak2.cxButton2Click(Sender: TObject);
begin
   try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;



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

procedure TfrmFakturPajak2.FormCreate(Sender: TObject);
begin

     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmFakturPajak2.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'Salesman', ftString, False,50);
    zAddField(FCDS, 'Customer', ftString, False,100);
    zAddField(FCDS, 'kode_cust', ftString, False,100);
    zAddField(FCDS, 'do_nomor', ftString, False,100);
    zAddField(FCDS, 'Invoice', ftString, False,20);
    zAddField(FCDS, 'Tanggal', ftDate, False);
    zAddField(FCDS, 'PPN', ftFloat, False);
    zAddField(FCDS, 'Nilai', ftFloat, False);
    zAddField(FCDS, 'status', ftInteger, False);
    zAddField(FCDS, 'negri', ftInteger, False);
    zAddField(FCDS, 'ismanual', ftInteger, False);
    zAddField(FCDS, 'nopajak',  ftString, False,50);
    zAddField(FCDS, 'Tanggal_pajak', ftDate, False);
    zAddField(FCDS, 'isDTP', ftInteger, False);
    zAddField(FCDS, 'adaRetur', ftInteger, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;


procedure TfrmFakturPajak2.FormShow(Sender: TObject);
begin
refreshdata;
dtTanggalPajak.DateTime :=date;
dttanggal2.DateTime :=Date;
end;

procedure TfrmFakturPajak2.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmFakturPajak2.clSKUPropertiesEditValueChanged(Sender: TObject);
begin
  CDS.FieldByName('NAMABARANG').AsString := CDSSKU.Fields[1].Asstring;
 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;

end;

procedure TfrmFakturPajak2.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;

begin
cds.first;
i:=1;
while not CDS.Eof do
begin
   if CDS.FieldByName('status').AsFloat >  0 then
   begin

       s:='delete from Tfakturpajak_HDR  '
          + ' where fp_nomor = ' + quot(CDS.FieldByName('Invoice').asstring) + ';';
        // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);
        s :=  ' insert into Tfakturpajak_HDR '
                   + ' (fp_nomor,fp_do_nomor,fp_tanggal,fp_fakturpajak,fp_tanggalpajak,fp_cus_kode,fp_disc_faktur,'
                   + ' fp_disc_fakturpr,fp_amount,fp_taxamount,fp_istax,ismanual,date_create,user_create) '
                   + ' values ( '
                   + Quot(CDS.FieldByName('Invoice').asstring) + ','
                   + Quot(CDS.FieldByName('do_nomor').asstring) + ','
                   + Quotd(CDS.FieldByName('tanggal').asdatetime) + ','
                   + Quot(CDS.FieldByName('nopajak').asstring) + ','
                   + quotd(CDS.FieldByName('tanggal_pajak').asdatetime)+','
                   + Quot(CDS.FieldByName('kode_cust').asstring) + ','
                   + '0,'
                   + '0,'
                   + floattostr(CDS.FieldByName('nilai').asfloat)+ ','
                   + floattostr(CDS.FieldByName('ppn').asfloat)+ ','
                   +  '1,'
                   +  inttostr(CDS.FieldByName('ismanual').asinteger)+','
                   + QuotD(cGetServerTime,True) + ','
                   + Quot(frmMenu.KDUSER)+')';

        // xExecQuery(s,frmMenu.conn);
EnsureConnected(frmMenu.conn);
ExecSQLDirect(frmMenu.conn, s);

           tt := TStringList.Create;
         s:= ' delete from tfakturpajak_dtl '
            + ' where  fpd_fp_nomor =' + quot(CDS.FieldByName('Invoice').asstring);

         tt.Append(s);

          if chkManual.Checked then
          S:='insert into tfakturpajak_dtl (fpd_fp_nomor,fpd_brg_kode,fpd_brg_nama,fpd_brg_satuan,fpd_qty,fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_kode) '
          + ' select fpd_fp_nomor,fpd_brg_kode,brg_nama,fpd_brg_satuan,fpd_qty,fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_Kode from '
          + ' tfp_dtl_bayangan inner join tbarang on brg_kode=fpd_brg_kode where fpd_fp_nomor='+ quot(CDS.FieldByName('Invoice').asstring)
          else
          if CDS.FieldByName('ismanual').AsInteger = 1 then
          S:='insert into tfakturpajak_dtl (fpd_fp_nomor,fpd_brg_kode,fpd_brg_nama,fpd_brg_satuan,fpd_qty,fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_kode) '
          + ' select fpd_fp_nomor,fpd_brg_kode,brg_nama,fpd_brg_satuan,fpd_qty,fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_Kode from '
          + ' tfp_dtl_bayangan inner join tbarang on brg_kode=fpd_brg_kode where fpd_fp_nomor='+ quot(CDS.FieldByName('Invoice').asstring)
          else
          S:='insert into tfakturpajak_dtl (fpd_fp_nomor,fpd_brg_kode,fpd_brg_nama,fpd_brg_satuan,fpd_qty ,'
          + ' fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_kode) '
          + ' select fpd_fp_nomor,fpd_brg_kode,brg_nama,fpd_brg_satuan,fpd_qty-'
          + ' (select ifnull(SUM(retjd_qty),0) FROM tretj_dtl INNER JOIN tretj_hdr ON retj_nomor=retjd_retj_nomor WHERE retj_fp_nomor=fpd_fp_nomor AND retjd_brg_kode=fpd_brg_kode) qty ,'
          + ' fpd_discpr,fpd_harga,fpd_nourut,fpd_expired,fpd_cn,fpd_gdg_Kode from '
          + ' tfp_dtl inner join tbarang on brg_kode=fpd_brg_kode where fpd_fp_nomor='+ quot(CDS.FieldByName('Invoice').asstring) ;

          tt.Append(s);

            tt.SaveToFile('ss.txt');
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
   CDS.Next;
end;
end;


procedure TfrmFakturPajak2.cxButton3Click(Sender: TObject);
begin
      try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;



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

procedure TfrmFakturPajak2.btnRefreshClick(Sender: TObject);
var
  s:string;
  tsql:TMyQuery;
  i:Integer;
begin
  if chkManual.Checked then
    s := ' select a.fp_do_nomor,sls_nama Salesman,cus_kode,cus_nama Customer,a.fp_nomor,a.fp_tanggal,a.fp_jthtempo,a.fp_taxamount,a.fp_amount,a.FP_DP, '
      + ' ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor=a.fp_nomor),0) retur, '
      + ' ifnull((select sum(retj_cn) from tretj_hdr where retj_fp_nomor=a.fp_nomor),0) retur_cn, '
      + ' ifnull(a.fp_bayar,0) Bayar ,1 ismanual,fp_isDTP'
      + ' from tfp_hdr_bayangan a'
      + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
      + ' inner join tso_hdr on so_nomor=do_so_nomor '
      + ' left join tsalesman on sls_kode=so_sls_kode '
      + ' left join tfakturpajak_hdr x on a.fp_nomor=x.fp_nomor '
      + ' left join tcustomer on cus_kode=a.fp_cus_kode '
      + ' where  a.fp_istax = 1 '
      + ' and a.fp_tanggal between '+ quotd(dttanggal.datetime) + ' and ' + quotd(dttanggal2.datetime)
      + ' and fp_fakturpajak is null'
      + ' order by a.fp_nomor '

  else

  s := ' select a.fp_do_nomor,sls_nama Salesman,cus_kode,cus_nama Customer,a.fp_nomor,a.fp_tanggal,a.fp_jthtempo,a.fp_taxamount,a.fp_amount,a.FP_DP, '
      + ' ifnull((select sum(retj_amount) from tretj_hdr where retj_fp_nomor=a.fp_nomor),0) retur, '
      + ' ifnull((select sum(retj_taxamount) from tretj_hdr where retj_fp_nomor=a.fp_nomor),0) returtax, '
      + ' ifnull((select sum(retj_cn) from tretj_hdr where retj_fp_nomor=a.fp_nomor),0) retur_cn, '
      + ' ifnull(a.fp_bayar,0) Bayar, '
      + ' (select count(*) from tfp_hdr_bayangan where fp_Nomor=a.fp_nomor) ismanual ,FP_ISDTP'
      + ' from tfp_hdr a'
      + ' inner join tdo_hdr on fp_do_nomor=do_nomor '
      + ' inner join tso_hdr on so_nomor=do_so_nomor '
      + ' left join tsalesman on sls_kode=so_sls_kode '
      + ' left join tfakturpajak_hdr x on a.fp_nomor=x.fp_nomor '
      + ' left join tcustomer on cus_kode=a.fp_cus_kode '
      + ' where  a.fp_istax = 1 '
      + ' and a.fp_isecer = 0 '
      + ' and a.fp_tanggal between '+ quotd(dttanggal.datetime) + ' and ' + quotd(dttanggal2.datetime)
      + ' and fp_fakturpajak is null'
      + ' order by fp_nomor ';
        tsql := xOpenQuery(s,frmMenu.conn) ;
      try

       with  tsql do
       begin
             CDS.EmptyDataSet;

            i:=1;

            while  not Eof do
             begin

                      CDS.Append;
                      CDS.FieldByName('salesman').AsString        := fieldbyname('salesman').AsString;
                      CDS.FieldByName('kode_cust').AsString        := fieldbyname('cus_kode').AsString;
                      CDS.FieldByName('do_nomor').AsString        := fieldbyname('fp_do_nomor').AsString;
                      CDS.FieldByName('Customer').AsString        := fieldbyname('Customer').AsString;
                      CDS.FieldByName('invoice').AsString        := fieldbyname('fp_nomor').AsString;
                      CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('fp_tanggal').AsDateTime;
                      CDS.FieldByName('PPN').AsFloat      := fieldbyname('fp_taxamount').AsFloat-fieldbyname('returtax').AsFloat;
                      CDS.FieldByName('nilai').AsFloat      := fieldbyname('fp_amount').AsFloat-fieldbyname('retur').AsFloat;
                      if fieldbyname('ismanual').asinteger > 0 then
                         CDS.FieldByName('ismanual').asinteger      := 1
                      else
                         CDS.FieldByName('ismanual').asinteger      := 0;
                      if fieldbyname('FP_ISDTP').asinteger > 0 then
                         CDS.FieldByName('isDTP').asinteger      := 1
                      else
                         CDS.FieldByName('isDTP').asinteger      := 0;
                      if fieldbyname('retur').asfloat > 0 then
                         CDS.FieldByName('adaretur').asinteger      := 1
                      else
                         CDS.FieldByName('adaretur').asinteger      := 0;

                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
      end;
   finally
     tsql.Free;
   end;

end;

procedure TfrmFakturPajak2.cxButton4Click(Sender: TObject);
var
  anegri,s:string;
  i:integer;
begin
  cds.first;
  i:=1;
  while not CDS.Eof do
  begin
   if CDS.FieldByName('status').AsFloat >  0 then
   begin
     if CDS.FieldByName('negri').AsFloat >  0 then
        anegri := '020'
     else
     if CDS.FieldByName('isDTP').AsFloat >  0 then
       anegri := '070'
     else
       anegri := '010';
    If CDS.State <> dsEdit then CDS.Edit;
      CDS.FieldByName('noPajak').AsString        := anegri+'.'+LeftStr(edtpajak.Text,Length(edtpajak.Text)-8)+rightstr(inttostr(100000000+StrToInt(RightStr(edtPajak.Text,8))+i),8);
      CDS.FieldByName('tanggal_pajak').AsDateTime  := dtTanggalPajak.DateTime;
      CDS.post;
    Inc(i);
   end;
    CDS.Next;

  end;
//       while  not cds.Eof do
//       begin
//
//                CDS.Append;
//                CDS.FieldByName('salesman').AsString        := fieldbyname('salesman').AsString;
//                CDS.FieldByName('Customer').AsString        := fieldbyname('Customer').AsString;
//                CDS.FieldByName('invoice').AsString        := fieldbyname('fp_nomor').AsString;
//                CDS.FieldByName('tanggal').AsDateTime  := fieldbyname('fp_tanggal').AsDateTime;
//                CDS.FieldByName('PPN').AsFloat      := fieldbyname('fp_taxamount').AsFloat;
//                CDS.FieldByName('nilai').AsFloat      := fieldbyname('fp_amount').AsFloat;
//
//                CDS.Post;
//             i:=i+1;
//             next;
//      end ;

end;

procedure TfrmFakturPajak2.CheckAllStatus1Click(Sender: TObject);
begin
   cds.first;
  while not CDS.Eof do
  begin
    If CDS.State <> dsEdit then CDS.Edit;
      CDS.FieldByName('status').AsFloat := 1;
      CDS.post;
    CDS.Next;

  end;

end;

procedure TfrmFakturPajak2.UncheckAllStatus1Click(Sender: TObject);
begin
   cds.first;
  while not CDS.Eof do
  begin
    If CDS.State <> dsEdit then CDS.Edit;
      CDS.FieldByName('status').AsFloat := 0;
      CDS.post;
    CDS.Next;

  end;

end;

end.
