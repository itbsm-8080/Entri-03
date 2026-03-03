unit ufrmUpload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,
  AdvPanel, DB, MemDS, DBAccess, MyAccess, ComCtrls,SqlExpr;

type
  TfrmUpload = class(TForm)
    AdvPanel2: TAdvPanel;
    lbljudul: TLabel;
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    cxButton1: TcxButton;
    AdvPanel1: TAdvPanel;
    chkjurnal: TCheckBox;
    MyQuery1: TMyQuery;
    Label1: TLabel;
    dtTanggal: TDateTimePicker;

    procedure cxButton1Click(Sender: TObject);
    procedure cxButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    conn2 : TSQLConnection;
    aHost2,aDatabase2,auser2,apassword2 : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUpload: TfrmUpload;

implementation
uses MAIN,Ulib,uModuleConnection;

{$R *.dfm}


procedure TfrmUpload.cxButton1Click(Sender: TObject);
var
 ss,s,anoreferensi:String;
  tt : TStrings;
  i:integer;
  tsql:TMyQuery;
begin

//  IF chkjual.Checked THen
//  begin
//  tt := TStringList.Create;
//
//  s:='SELECT so_nomor,so_tanggal,so_cus_kode,so_disc_faktur,so_disc_fakturpr,so_amount,so_taxamount,'
//      + 'so_bayar,so_kembali,so_card,so_no_card,so_bank_card,so_voucher,so_no_voucher,so_piutang,date_create,so_dp,so_user_kasir,'
//      + 'so_status_bayar,so_ongkir FROM tso_hdr WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal.DateTime+1)+')'
//  +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal.DateTime+1)+')';
//
//  tsql := xOpenQuery(s,frmMenu.conn);
//    with tsql do
//    begin
//
//    while not eof do
//    begin
//      ss:='delete from tso_hdr  where so_nomor ='+ Quot(Fields[0].AsString)+';';
//      tt.Append(ss);
//      ss:='delete from tso_dtl  where sod_so_nomor ='+ Quot(Fields[0].AsString)+';';
//      tt.Append(ss);
//
////      xExecQuery(ss,frmMenu.conn);
//      ss:='insert ignore into tso_hdr (so_nomor,so_tanggal,so_cus_kode,so_disc_faktur,so_disc_fakturpr,'
//      + ' so_amount,so_taxamount,'
//      + ' so_bayar,so_kembali,so_card,so_no_card,so_bank_card,so_voucher,'
//      + ' so_no_voucher,so_piutang,date_create,so_dp,so_user_kasir,'
//      + ' so_status_bayar,so_ongkir,so_cbg_kode'
//      + ' ) values ('
//      + Quot(Fields[0].AsString) +','
//      + Quotd(Fields[1].AsDateTime) +','
//      + Quot(Fields[2].AsString) +','
//      + FloatToStr(Fields[3].AsFloat) +','
//      + FloatToStr(Fields[4].AsFloat) +','
//      + FloatToStr(Fields[5].AsFloat) +','
//      + FloatToStr(Fields[6].AsFloat) +','
//      + FloatToStr(Fields[7].AsFloat) +','
//      + FloatToStr(Fields[8].AsFloat) +','
//      + FloatToStr(Fields[9].AsFloat) +','
//      + Quot(Fields[10].AsString) +','
//      + Quot(Fields[11].AsString) +','
//      + FloatToStr(Fields[12].AsFloat) +','
//      + Quot(Fields[13].AsString) +','
//      + FloatToStr(Fields[14].AsFloat) +','
//      + Quotd(Fields[15].AsDateTime) +','
//      + FloatToStr(Fields[16].AsFloat) +','
//      + Quot(Fields[17].AsString) +','
//      + intToStr(Fields[18].AsInteger) +','
//      + FloatToStr(Fields[19].AsFloat)  + ','
//      + Quot(frmMenu.KDCABANG)+');';
////      xExecQuery(ss,frmMenu.conn2);
//     tt.append(ss);
//      Next;
//    end;
//      tsql.Free;
//   end;
//    s:='SELECT sod_so_nomor,sod_brg_kode,sod_brg_satuan,sod_qty,sod_discpr,'
//      + ' sod_harga,sod_nourut,sod_discrp,sod_ktg_kode,sod_brg_avgcost,sod_qtykasir,'
//      + ' sod_hargakasir,sod_tipeharga'
//      + ' FROM tso_dtl inner join tso_hdr on so_nomor=sod_so_nomor'
//      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal.DateTime+1)+')'
//      +' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal.DateTime+1)+')';
//
//  tsql := xOpenQuery(s,frmMenu.conn);
//    with tsql do
//    begin
//
//    while not eof do
//    begin
//
//      ss:='insert ignore into tso_dtl (sod_so_nomor,sod_brg_kode,sod_brg_satuan,sod_qty,sod_discpr,'
//      + ' sod_harga,sod_nourut,sod_discrp,sod_ktg_kode,sod_brg_avgcost,sod_qtykasir,'
//      + ' sod_hargakasir,sod_tipeharga'
//      + ' ) values ('
//      + Quot(Fields[0].AsString) +','
//      + Quot(Fields[1].Asstring) +','
//      + Quot(Fields[2].AsString) +','
//      + FloatToStr(Fields[3].AsFloat) +','
//      + FloatToStr(Fields[4].AsFloat) +','
//      + FloatToStr(Fields[5].AsFloat) +','
//      + FloatToStr(Fields[6].AsFloat) +','
//      + FloatToStr(Fields[7].AsFloat) +','
//      + Quot(Fields[8].Asstring) +','
//      + FloatToStr(Fields[9].AsFloat) +','
//      + FloatToStr(fields[10].AsFloat) +','
//      + FloatToStr(fields[11].AsFloat) +','
//      + intToStr(Fields[12].Asinteger) +');';
//
//     tt.append(ss);
//      Next;
//    end;
//      tsql.Free;
//   end;
//
//
//
//       try
//        for i:=0 to tt.Count -1 do
//        begin
//            xExecQuery(tt[i],conn2);
//         end;
//      finally
//        tt.Free;
//      end;
//  end;
//
//  IF chkstok.Checked THen
//  begin
//    tt := TStringList.Create;
//    s:='SELECT mst_brg_kode,mst_gdg_kode,mst_stok_in,mst_stok_out,mst_noreferensi,'
//    + ' mst_hargabeli,mst_tanggal,date_create from tmasterstok where '
//    + ' (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal.DateTime+1)+')';
//
//  tsql := xOpenQuery(s,frmMenu.conn);
//    with tsql do
//    begin
//      anoreferensi:='';
//      while not eof do
//      begin
//        if anoreferensi <> Fields[4].AsString then
//        begin
//          ss:='delete from tmasterstokcabang where mst_noreferensi='+Quot(Fields[4].AsString)
//            +' and mst_cbg_kode ='+ Quot(frmMenu.KDCABANG)+';';
//          tt.Append(ss);
//        end;
//
//        ss:='insert ignore into tmasterstokcabang ('
//          + ' mst_brg_kode,mst_gdg_kode,mst_stok_in,mst_stok_out,mst_noreferensi,'
//          + ' mst_hargabeli,mst_tanggal,mst_cbg_kode) values ('
//          + Quot(Fields[0].AsString)+ ','
//          + Quot(Fields[1].AsString)+ ','
//          + floattostr(Fields[2].AsFloat)+ ','
//          + floattostr(Fields[3].AsFloat)+ ','
//          + Quot(Fields[4].AsString)+ ','
//          + floattostr(Fields[5].AsFloat)+ ','
//          + QuotD(Fields[6].AsDateTime)+ ','
//          + Quot(frmMenu.KDCABANG)+ ');';
//       tt.Append(ss);
//
//
//
//        Next;
//        anoreferensi := Fields[4].AsString;
//      end;
//      tsql.Free;
//    end;
//       try
//        for i:=0 to tt.Count -1 do
//        begin
//            xExecQuery(tt[i],conn2);
//         end;
//      finally
//        tt.Free;
//      end;
//  end;

    IF chkjurnal.Checked THen
  begin
  tt := TStringList.Create;



  s:='SELECT jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed FROM tjurnal WHERE '
  + ' (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal.DateTime+1)+')'
  + ' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal.DateTime+1)+')'
  + ' OR (jur_tanggal= '+quotd(dtTanggal.DateTime)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin
      ss:='delete from tjurnal  where jur_no ='+ Quot(Fields[2].AsString)+';';
      tt.Append(ss);
      ss:='delete from tjurnalitem  where jurd_jur_no ='+ Quot(Fields[2].AsString)+';';
      tt.Append(ss);

//      xExecQuery(ss,frmMenu.conn);
      ss:='insert ignore into tjurnal (jur_tanggal,jur_tipetransaksi,jur_no,jur_keterangan,jur_isclosed '
      + ' ) values ('
      + Quotd(Fields[0].AsDateTime) +','
      + Quot(Fields[1].AsString) +','
      + Quot(Fields[2].AsString) +','
      + Quot(Fields[3].AsString) +','
      + intToStr(Fields[4].AsInteger)
      +');';
//      xExecQuery(ss,frmMenu.conn2);
     tt.append(ss);
      Next;
    end;
      tsql.Free;
   end;
    s:='SELECT jurd_jur_no,jurd_rek_kode,jurd_debet,jurd_kredit,jurd_nourut,'+quotedstr(frmmenu.KDCABANG)+' jurd_cc_kode'
      + ' FROM tjurnalitem inner join tjurnal on jurd_jur_no =jur_no'
      + ' WHERE (date_create between '+Quotd(dtTanggal.DateTime) +' and '+Quotd(dtTanggal.DateTime+1)+')'
      + ' OR (date_modified between '+quotd(dttanggal.datetime)+' and '+Quotd(dtTanggal.DateTime+1)+')'
      + ' OR (jur_tanggal= '+quotd(dtTanggal.DateTime)+')';

  tsql := xOpenQuery(s,frmMenu.conn);
    with tsql do
    begin

    while not eof do
    begin

      ss:='insert ignore into tjurnalitem ('
      + ' jurd_jur_no,jurd_rek_kode,jurd_debet,jurd_kredit,jurd_nourut,jurd_cc_kode'
      + ' ) values ('
      + Quot(Fields[0].AsString) +','
      + Quot(Fields[1].Asstring) +','
      + FloatToStr(Fields[2].AsFloat) +','
      + FloatToStr(Fields[3].AsFloat) +','
      + FloatToStr(Fields[4].AsFloat) +','
      + Quot(Fields[5].Asstring) +');';

     tt.append(ss);
      Next;
    end;
      tsql.Free;
   end;



       try
        for i:=0 to tt.Count -1 do
        begin
            xExecQuery(tt[i],conn2);
         end;
      finally
        tt.Free;
      end;
  end;

  showmessage('Upload selesai');
end;

procedure TfrmUpload.cxButton8Click(Sender: TObject);
begin
release;
end;

procedure TfrmUpload.FormShow(Sender: TObject);
begin
dtTanggal.datetime :=date ;
conn2 := xCreateConnection(ctMySQL,frmMenu.aHost2,frmMenu.aDatabase2,frmMenu.auser2,frmMenu.apassword2);
end;

end.
