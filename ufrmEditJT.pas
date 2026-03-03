unit ufrmEditJT;

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
  TfrmEditJT = class(TForm)
    PANEL: TAdvPanel;
    Label2: TLabel;
    edtNomor: TAdvEdit;
    Label3: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    AdvPanel2: TAdvPanel;
    Label1: TLabel;
    Label4: TLabel;
    cxButton2: TcxButton;
    cxButton1: TcxButton;
    cxLookupCustomer: TcxExtLookupComboBox;
    AdvPanel4: TAdvPanel;
    cxGrid: TcxGrid;
    cxGrdMain: TcxGridDBTableView;
    clNo: TcxGridDBColumn;
    clTanggal: TcxGridDBColumn;
    cxGrdDetail: TcxGridDBTableView;
    lvMaster: TcxGridLevel;
    lbljudul: TLabel;
    dtTanggal: TDateTimePicker;
    AdvPanel5: TAdvPanel;
    Label6: TLabel;
    edtAlamat: TAdvEdit;
    Label5: TLabel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle2: TcxStyle;
    dtTglJT: TDateTimePicker;
    edtNomorDO: TAdvEditBtn;
    chkPajak: TCheckBox;
    edtDiscpr: TAdvEdit;
    edtDisc: TAdvEdit;
    edtPPN: TAdvEdit;
    edtTotal: TAdvEdit;
    edtDiscFaktur: TAdvEdit;
    edtDP: TAdvEdit;
    edtCN: TAdvEdit;
    chkDP: TCheckBox;
    chkCN: TCheckBox;
    cxButton3: TcxButton;
    Label15: TLabel;
    edtFreight: TAdvEdit;
    Label20: TLabel;
    edtsalesman: TAdvEdit;
    Label21: TLabel;
    edtTotal2: TAdvEdit;
    PopupMenu1: TPopupMenu;
    HapusRecord1: TMenuItem;
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
    procedure cxLookupcustomerPropertiesChange(Sender: TObject);
    procedure clNoGetDisplayText(Sender: TcxCustomGridTableItem; ARecord:
        TcxCustomGridRecord; var AText: string);
    procedure clSKUPropertiesEditValueChanged(Sender: TObject);

    procedure dtTanggalChange(Sender: TObject);
    procedure simpandata;
    procedure loaddataDO(akode : string);
    procedure loaddataall(akode : string);
    procedure hitung;

    procedure edtNomorDOClickBtn(Sender: TObject);
    procedure edtDiscprExit(Sender: TObject);
    procedure edtDiscExit(Sender: TObject);
    procedure chkDPClick(Sender: TObject);
    procedure chkCNClick(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    function gettop(akode:String):integer;
    procedure edtBiayaPrExit(Sender: TObject);
    function getnilairetur(anomor:String):double;
    function getdisccn(akodebarang : Integer ; akode:String):double;
    function getnilairetur2(anomor:String):double;
    procedure HapusRecord1Click(Sender: TObject);
  private
    FCDScustomer: TClientDataset;
    FCDSSKU : TClientDataset;

    FFLAGEDIT: Boolean;
    FID: string;
    apajak :Integer ;
    function GetCDScustomer: TClientDataset;




    { Private declarations }
  protected
    FCDS: TClientDataSet;
  public
    property CDS: TClientDataSet read GetCDS write FCDS;
    property CDSSKU: TClientDataSet read FCDSSKU write FCDSSKU;
    property CDScustomer: TClientDataset read GetCDScustomer write FCDScustomer;

    property FLAGEDIT: Boolean read FFLAGEDIT write FFLAGEDIT;
    property ID: string read FID write FID;
    { Public declarations }
  end;

var
  frmEditJT: TfrmEditJT;
const
   NOMERATOR = 'FP';
implementation
uses MAIN,uModuleConnection,uFrmbantuan,Ulib,uReport,ufrmcetak;

{$R *.dfm}

procedure TfrmEditJT.refreshdata;
begin
  FID:='';
  FLAGEDIT := False;
  dtTanggal.DateTime := Date;
  edtNomorDO.Clear;
  dtTglJT.DateTime := Date;
  chkPajak.Checked := true;
  edtTotal.Text := '0.00';
  edtPPN.Text := '0.00';
  edtFreight.Text := '0.00';
  edtCN.Text := '0.00';
  edtDP.Text := '0.00';
  edtsalesman.Clear;
  edtnomor.Text := getmaxkode(1);
  cxLookupcustomer.EditValue := '';
  edtAlamat.Clear;

  edtNomorDO.SetFocus;
  initgrid;

end;
procedure TfrmEditJT.initgrid;
begin
  CDS.EmptyDataSet;
  CDS.Append;
  CDS.Post;

end;
procedure TfrmEditJT.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
      SelectNext(ActiveControl,True,True);
end;



procedure TfrmEditJT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   Release;
end;

function TfrmEditJT.getmaxkode(aispajak:integer=1):string;
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

procedure TfrmEditJT.cxButton1Click(Sender: TObject);
begin
    try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
        if ((cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total')) -
           cstrtoFloat(edtTotal.Text)) > 100) or ((cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total')) -
           cstrtoFloat(edtTotal.Text) < -100))   then
        begin
          ShowMessage('Total faktur dengan total angsurang selisih'  );
           Exit;

        end;



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

procedure TfrmEditJT.cxButton8Click(Sender: TObject);
begin
Release;
end;

procedure TfrmEditJT.cxButton2Click(Sender: TObject);
begin
   try
      if cekTutupPeriode(dtTanggal.Date) then
      Exit;
        if ((cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total')) -
           cstrtoFloat(edtTotal.Text)) > 100) or ((cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total')) -
           cstrtoFloat(edtTotal.Text) < -100))   then
        begin
          ShowMessage('Total faktur dengan total angsurang selisih'  );
           Exit;

        end;



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

procedure TfrmEditJT.FormCreate(Sender: TObject);
begin
  with TcxExtLookupHelper(cxLookupcustomer.Properties) do
    LoadFromCDS(CDScustomer, 'Kode','customer',['Kode'],Self);
     TcxExtLookupHelper(cxLookupcustomer.Properties).SetMultiPurposeLookup;



     TcxDBGridHelper(cxGrdMain).LoadFromCDS(CDS, False, False);

end;

function TfrmEditJT.GetCDS: TClientDataSet;
begin
  If not Assigned(FCDS) then
  begin
    FCDS := TClientDataSet.Create(Self);
    zAddField(FCDS, 'No', ftInteger, False);
    zAddField(FCDS, 'TanggalJT', ftDate, False);
    zAddField(FCDS, 'Total', ftFloat, False);

    FCDS.CreateDataSet;
  end;
  Result := FCDS;
end;

function TfrmEditJT.GetCDScustomer: TClientDataset;
var s:String;
begin
  If not Assigned(FCDScustomer) then
  begin
    S := 'select cus_nama as customer, cus_kode Kode, cus_alamat Alamat,cus_telp'
        +' from tcustomer order by cus_nama';


    FCDScustomer := TConextMain.cOpenCDS(S,nil);
  end;
  Result := FCDScustomer;
end;

procedure TfrmEditJT.FormShow(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmEditJT.cxLookupcustomerPropertiesChange(Sender: TObject);
begin
edtAlamat.Text := CDScustomer.Fields[2].AsString;

end;

procedure TfrmEditJT.clNoGetDisplayText(Sender: TcxCustomGridTableItem;
    ARecord: TcxCustomGridRecord; var AText: string);
begin
  inherited;
  If Assigned(ARecord) then
  begin
    AText := Inttostr(ARecord.Index+1);
  end;
end;

procedure TfrmEditJT.clSKUPropertiesEditValueChanged(Sender: TObject);
begin

 CDS.FieldByName('satuan').AsString := CDSSKU.Fields[2].Asstring;

end;

procedure TfrmEditJT.dtTanggalChange(Sender: TObject);
var
  anomorold:string;
begin
   anomorold := edtNomor.Text;
  edtNomor.Text := getmaxkode(apajak);
  if FLAGEDIT then
  begin
    if edtNomor.Text <> anomorold then
    begin
      showmessage('Perubahan tanggal tidak bisa beda bulan dan tahun');
      edtNomor.Text := anomorold;
      dtTanggal.date := Date;

    end;
  end;
  dtTglJT.DateTime :=  dtTanggal.DateTime+getTop(cxLookupCustomer.EditValue);
end;


procedure TfrmEditJT.simpandata;
var
  s:string;
  i:integer;
  tt:TStrings;
  aistax : integer;
begin

     tt := TStringList.Create;
   s:= ' delete from tJatuhtempofp '
      + ' where  jt_fp_nomor =' + quot(FID);

   tt.Append(s);
   CDS.First;
    i:=1;
  while not CDS.Eof do
  begin
      if CDS.FieldByName('total').AsFloat > 0 then
      begin
          S:='insert into tjatuhtempofp (jt_fp_nomor,jt_tanggaljt,jt_nilai) values ('
            + Quot(edtNomor.Text) +','
            + quotd(CDS.FieldByName('TanggalJT').AsDateTime) +','
            + FloatToStr(cVarToFloat(CDS.FieldByName('total').AsFloat))
            + ');';
          tt.Append(s);
      end;
    CDS.Next;
    Inc(i);
  end;
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


procedure TfrmEditJT.loaddataDO(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  i:Integer;
begin


  s := ' select do_nomor,do_tanggal,so_cus_kode,so_istax,cus_top,'
     + ' so_DISC_faktur,so_disc_fakturpr,so_istax,sod_keterangan,'
     + ' dod_brg_kode,dod_bRG_satuan,(dod_qty-dod_qty_invoice) dod_qty,dod_tgl_expired expired,'
     + ' sod_harga,sod_discpr,((dod_qty-dod_qty_invoice)*sod_harga*(100-sod_discpr)/100) nilai,dod_gdg_kode,sls_nama'
     + ' from tdo_hdr inner join tso_hdr a on do_so_nomor = so_nomor'
     + ' inner join tdo_dtl on dod_do_nomor = do_nomor '
     + ' inner join tcustomer on cus_kode =so_cus_kode '
     + ' left join tsalesman on sls_kode=so_sls_kode '
     + ' LEFT join tso_dtl d on a.so_nomor=d.sod_so_nomor  and dod_brg_kode = sod_brg_kode  '
     + ' where do_nomor = '+ Quot(akode);
    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin

            edtNomorDO.Text   := fieldbyname('do_nomor').AsString;
            apajak := fieldbyname('so_istax').AsInteger;
            if apajak = 1 then
               chkpajak.Checked := True
            else
               chkpajak.Checked := false;

            edtNomor.Text := getmaxkode(apajak);
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
            edtsalesman.Text := fieldbyname('sls_nama').AsString;
            edtDiscpr.Text := fieldbyname('so_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('so_disc_faktur').AsString;
            dtTglJT.DateTime := dtTanggal.DateTime+fieldbyname('cus_top').AsInteger;
            i:=1;

             CDS.EmptyDataSet;
            while  not Eof do
             begin
                      CDS.Append;
                      CDS.FieldByName('SKU').AsInteger        := fieldbyname('dod_brg_kode').AsInteger;
                      CDS.FieldByName('satuan').AsString      := fieldbyname('dod_brg_satuan').Asstring;
                      CDS.FieldByName('QTY').AsInteger        := fieldbyname('dod_qty').AsInteger;
                      CDS.FieldByName('Harga').AsFloat        := fieldbyname('sod_harga').AsFloat;
                      CDS.FieldByName('disc').AsFloat        := fieldbyname('sod_discpr').AsFloat;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('nilai').AsFloat;
                      CDS.FieldByName('expired').AsDateTime  := fieldbyname('expired').AsDateTime;
                      CDS.FieldByName('kurang').AsFloat        := fieldbyname('dod_qty').AsFloat;
                      CDS.FieldByName('gudang').AsString      :=  fieldbyname('dod_gdg_kode').AsString;
                      CDS.FieldByName('cn').asfloat      :=  getdisccn(fieldbyname('dod_brg_kode').AsInteger,cxLookupcustomer.EditValue);
                      CDS.fieldbyname('nilaicn').asfloat           := CDS.FieldByName('cn').asfloat*fieldbyname('nilai').AsFloat/100;
                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
            hitung;
        end
        else
        begin
          ShowMessage('Nomor tidak di temukan');
          dttanggal.SetFocus;
        end;
      end;
   finally
     tsql.Free;
   end;

end;

procedure TfrmEditJT.edtNomorDOClickBtn(Sender: TObject);
var
    SQLbantuan :string;
begin
 sqlbantuan := ' SELECT do_NOMOR Nomor,do_TANGGAL Tanggal,cus_NAMA customer from tdo_HDR '
            + ' inner join tcustomer on cus_kode=do_cus_kode where do_isclosed=0';
 Application.CreateForm(Tfrmbantuan,frmbantuan);
 frmBantuan.SQLMaster := SQLbantuan;
  frmBantuan.ShowModal;
   if varglobal <> '' then
  edtNomorDO.Text := varglobal;
  loaddataDO(edtNomorDO.Text);
end;



procedure TfrmEditJT.loaddataall(akode : string);
var
  s: string ;
  tsql : TMyQuery;
  a,i:Integer;
  aketemu:Boolean;
  aqtypo,qtyterima : Integer;
begin
  if akode = '' then
  begin
    flagedit := false;
    Exit ;
  end;
  s := ' select fp_NOMOr,fp_tanggal,do_nomor,fp_memo,so_cus_kode,fp_istax,fp_jthtempo,FP_CN,FP_DP,'
     + ' fp_amount,fp_taxamount,fp_freight,fp_disc_faktur,fp_disc_fakturpr,jt_tanggaljt,jt_nilai,'
     + ' fp_biayapr,fp_biayarp,sls_nama'
     + ' from tfp_hdr inner join tdo_hdr on do_nomor =fp_do_nomor '
     + ' left join tso_hdr a on do_so_nomor=so_nomor'
     + ' left join tsalesman on sls_kode=so_sls_kode '
     + ' left join tjatuhtempofp on jt_fp_nomor=fp_nomor'
     + ' where fp_nomor = '+ Quot(akode) ;

    tsql := xOpenQuery(s,frmMenu.conn) ;
   try

       with  tsql do
       begin
         if not eof then
         begin
            flagedit := True;
            apajak :=fieldbyname('fp_istax').AsInteger;
            if apajak =1 then
               chkPajak.Checked := True
            else
               chkPajak.Checked := False;
            FID :=fieldbyname('fp_nomor').AsString;
            edtnomor.Text := fieldbyname('fp_nomor').AsString;
            edtNomorDO.Text   := fieldbyname('do_nomor').AsString;
            dttanggal.DateTime := fieldbyname('fp_tanggal').AsDateTime;
            dtTglJT.DateTime  :=  fieldbyname('fp_jthtempo').AsDateTime;
            cxLookupcustomer.EditValue  := fieldbyname('so_cus_kode').AsString;
            edtAlamat.Text := CDScustomer.Fields[2].AsString;
            edtsalesman.Text := fieldbyname('sls_nama').AsString;
            edtDiscpr.Text :=fieldbyname('fp_disc_fakturpr').AsString;
            edtDisc.Text :=  fieldbyname('fp_disc_faktur').AsString;
            edtFreight.Text := fieldbyname('fp_freight').AsString;
            if FieldByName('fp_dp').AsFloat > 0 then
            begin
              chkDP.Checked := True;
              edtDP.Text := FloatToStr(FieldByName('fp_dp').AsFloat);
            end;
            if FieldByName('fp_cn').AsFloat > 0 then
            begin
              chkCN.Checked := True;
              edtCN.Text := FloatToStr(FieldByName('fp_cn').AsFloat);
            end;
            edtTotal.Text :=FloatToStr(FieldByName('fp_amount').AsFloat);
            edtPPN.Text := FloatToStr(FieldByName('fp_taxamount').AsFloat);


            i:=1;
             CDS.EmptyDataSet;
            while  not Eof do
             begin

                     CDS.Append;
                      CDS.FieldByName('tanggaljt').AsDateTime  := fieldbyname('jt_tanggaljt').AsDateTime;
                      CDS.FieldByName('total').AsFloat        := fieldbyname('jt_nilai').AsFloat;
                      CDS.Post;
                   i:=i+1;
                   next;
            end ;
//           hitung;
           edtBiayaPrExit(Self);
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

procedure TfrmEditJT.hitung;
var
  asubtotal : Double;
  aretur : double ;
  adisc:Double;
begin
  asubtotal :=cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
  edtDiscFaktur.Text := FloatToStr((cStrToFloat(edtDiscpr.text)/100*asubtotal)+cStrToFloat(edtDisc.text)) ;
  asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
  if chkPajak.Checked then
  begin
    edtTotal.Text :=FloatToStr((asubtotal*getangkappn(dtTanggal.DateTime))+cStrToFloat(edtFreight.text));
    edtPPN.Text := FloatToStr(asubtotal *getangkappn2(dtTanggal.DateTime));
    edtCN.Text := FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('NilaiCN')));
    aretur := ((asubtotal*getangkappn(dtTanggal.DateTime))+cStrToFloat(edtFreight.text))-getnilairetur(edtNomor.text);
  end
  else
  begin
    edtTotal.Text :=FloatToStr(asubtotal+cStrToFloat(edtFreight.text));
    edtPPN.Text := '0';
    edtCN.Text := FloatToStr(cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('NilaiCN')));
    aretur := ((asubtotal)+cStrToFloat(edtFreight.text))-getnilairetur(edtNomor.text);
  end;

    edtTotal2.Text :=FloatToStr(aretur);



end;


procedure TfrmEditJT.edtDiscprExit(Sender: TObject);
begin
if edtDiscpr.Text = '' then
    edtDiscpr.Text :='0';
hitung;
end;

procedure TfrmEditJT.edtDiscExit(Sender: TObject);
begin
if edtDisc.Text = '' then
    edtDisc.Text :='0';
hitung;
end;

procedure TfrmEditJT.chkDPClick(Sender: TObject);
var
  s:string;
  tsql :TMyQuery ;
  adp,ainvdp :double;
  anomorso :string;
begin
  anomorso:='';
  adp := 0;
 if chkDP.Checked then
 begin
  s:='select so_nomor,so_dp from tso_hdr inner join tdo_hdr on so_nomor=do_so_nomor '
   + ' where do_nomor =' + Quot(edtNomorDO.Text) ;
 tsql := xOpenQuery(s,frmMenu.conn);
 with tsql do
 begin
   try
     if not Eof then
     begin
       adp :=fields[1].asfloat;
       anomorso :=fields[0].asstring;
    end;
   finally
     free;
   end;
 end;
  s:='select sum(fp_dp) from tfp_hdr inner join tdo_hdr on fp_do_nomor=do_nomor '
    + ' inner join tso_hdr on so_nomor=do_so_nomor '
    + ' where so_nomor =' + Quot(anomorso)
    + ' AND fp_nomor <> ' + Quot(edtNomor.Text);
 tsql := xOpenQuery(s,frmMenu.conn);
 with tsql do
 begin
   try
     if not Eof then
       ainvdp :=fields[0].asfloat;
   finally
     free;
   end;
 end;
 edtDP.Text := FloatToStr(adp-ainvdp);
 end
 else
 edtDP.Text := '0';


end;

procedure TfrmEditJT.chkCNClick(Sender: TObject);
var
  s:string;
  tsql :TMyQuery ;
  acn : Double;
  apotong : double;

begin
 IF cStrToFloat(edtCN.Text) > 0 then
 begin
   ShowMessage('CN ini menggunakan metode per ITem');
   chkCN.Checked := False;
   Exit;
 end;
 if chkCN.Checked then
 begin
  s:='select cn_potong_invoice from tpiutangcn '
   + ' where cn_cus_kode =' + Quot(cxLookupCustomer.EditValue)
   + ' and cn_startdate <= ' + QuotD(dtTanggal.Date)
   + ' and cn_enddate >= ' + QuotD(dtTanggal.Date);
 tsql := xOpenQuery(s,frmMenu.conn);
 with tsql do
 begin
   try
     if not Eof then
     begin
       apotong:=fields[0].asfloat;
    end;
   finally
     free;
   end;
 end;
 if chkPajak.Checked then
 edtCN.Text := FloatToStr(apotong/100*(cStrToFloat(edtTotal.Text)/getangkappn(dtTanggal.DateTime)))
 else
 edtCN.Text := FloatToStr(apotong/100*(cStrToFloat(edtTotal.Text)));

 end
 else
 edtCN.Text := '0';


end;

procedure TfrmEditJT.cxButton3Click(Sender: TObject);
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

function TfrmEditJT.gettop(akode:String):integer;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select cus_top from tcustomer where cus_kode='+ Quot(akode) ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if not Eof then
       result := fields[0].asinteger;
   finally
     Free;
   end;
  end;
end;


procedure TfrmEditJT.edtBiayaPrExit(Sender: TObject);
var
  asubtotal : double;
begin
  asubtotal := cVarToFloat(TcxDBGridHelper(cxGrdMain).GetFooterSummary('Total'));
    asubtotal := asubtotal - cStrToFloat(edtDiscFaktur.Text);
    asubtotal := asubtotal - getnilairetur2(edtNomor.Text);

end;

function TfrmEditJT.getnilairetur(anomor:String):double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select sum(retj_amount) from tretj_hdr  where retj_fp_nomor = '+ Quot(anomor) ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if not Eof then
       result := fields[0].asinteger;
   finally
     Free;
   end;
  end;
end;

function TfrmEditJT.getdisccn(akodebarang : Integer ; akode:String):double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select fpd_cn from tfp_hdr inner join tfp_dtl on fpd_fp_nomor=fp_nomor '
  + ' inner join tpiutangcn on cn_cus_kode=fp_cus_kode '
  + ' where fp_cus_kode = '+ Quot(akode)
  + ' and fpd_brg_kode='+ IntToStr(akodebarang)
  + ' and fpd_cn > 0 '
  + ' and cn_startdate <= '+quotd(dtTanggal.Date)+' and '
  + ' cn_enddate >= ' + QuotD(dtTanggal.Date)
  + ' order by fp_tanggal desc limit 1 ';
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if not Eof then
       result := fields[0].asfloat;
   finally
     Free;
   end;
  end;
end;

function TfrmEditJT.getnilairetur2(anomor:String):double;
var
  s:string;
  tsql:TMyQuery;
begin
  result := 0;
  s:='select sum(retj_amount) from tretj_hdr  where retj_fp_nomor = '+ Quot(anomor) ;
  tsql := xOpenQuery(s,frmMenu.conn);
  with tsql do
  begin
   try
     if not Eof then
       result := fields[0].asinteger;
   finally
     Free;
   end;
  end;
end;


procedure TfrmEditJT.HapusRecord1Click(Sender: TObject);
begin
 If CDS.Eof then exit;
  CDS.Delete;
  If CDS.Eof then initgrid;

end;

end.
