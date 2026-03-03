unit ufrmNeracaSaldo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, SqlExpr, Ulib, cxGraphics, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkSide, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinPumpkin, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinsdxStatusBarPainter,
  cxControls, dxStatusBar, te_controls, Menus, cxLookAndFeelPainters,
  cxButtons, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxGridCustomView, cxGrid ,uGTSUICommonDlg,
  Grids, BaseGrid, AdvGrid, AdvCGrid, ComCtrls, Mask, ImgList, ExtDlgs,
  cxLookAndFeels;

type
  TfrmNeracaSaldo = class(TForm)
    tscrlbx1: TTeScrollBox;
    TePanel1: TTePanel;
    TePanel2: TTePanel;
    tlbPelatihanKatagori: TTeToolBar;
    btnExit: TTeSpeedButton;
    btnRefresh: TTeSpeedButton;
    sbPrint: TTeSpeedButton;
    ilMenu: TImageList;
    ilToolbar: TImageList;
    AdvColumnGrid1: TAdvColumnGrid;
    TeLabel3: TTeLabel;
    btnTampil: TcxButton;
    TeSpeedButton1: TTeSpeedButton;
    SaveDialog1: TSaveDialog;
    cbbBulan: TTeComboBox;
    edtTahun: TTeEdit;
    TeLabel1: TTeLabel;
    TeLabel2: TTeLabel;
    TePanel3: TTePanel;
    TeLabel4: TTeLabel;
    AdvColumnGrid2: TAdvColumnGrid;
    TeLabel5: TTeLabel;
    edtselisih: TTeEdit;
    procedure btnExitClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnTampilClick(Sender: TObject);
    procedure sbPrintClick(Sender: TObject);
    Procedure loaddata(atipe : string = '');
    procedure FormShow(Sender: TObject);
    procedure autonumber(aGrid : TAdvColumnGrid);
    procedure TeSpeedButton1Click(Sender: TObject);
    procedure showdata;
    procedure SumGridJurnal;
    procedure SumGridJurnal2;
    function cektutupperiode(abulan:Integer;atahun:Integer): Boolean;

  private
    xtotal,xtotal2 : double;
    { Private declarations }

  public
    procedure refreshdata;

    { Public declarations }
  end;

var

  frmNeracaSaldo: TfrmNeracaSaldo;

implementation
   uses MAIN,uModuleConnection, DB, uReport;
{$R *.dfm}





procedure TfrmNeracaSaldo.btnExitClick(Sender: TObject);
begin
if CommonDlg.Confirm('Apakah ingin keluar dari Modul ') = mrYes then
      Release;
end;

procedure TfrmNeracaSaldo.btnRefreshClick(Sender: TObject);
begin
refreshdata;
end;

procedure TfrmNeracaSaldo.btnTampilClick(Sender: TObject);
begin
  loaddata ;
end;

procedure TfrmNeracaSaldo.refreshdata;
begin
    cClearGrid(AdvColumnGrid1,False);
    cbbBulan.ItemIndex := 0 ;
    edtTahun.Text := '2012';
    // TODO -cMM: TfrmListpegawai.refreshdata default body inserted
end;

procedure TfrmNeracaSaldo.sbPrintClick(Sender: TObject);
begin
loaddata('Printer');

end;

procedure TfrmNeracaSaldo.loaddata(atipe : string = '');
var
  s, ssql , afilter1,  acompany : string;
  ftsreport : TTSReport;
  z,i,x : Integer;
  tsql : TMyQuery;
  tt : TStrings;
begin
     cClearGrid(AdvColumnGrid1,False);
     cClearGrid(AdvColumnGrid2,False);
     AdvColumnGrid1.FloatingFooter.Visible := False;
     AdvColumnGrid2.FloatingFooter.Visible := false;
     if atipe = '' then
     begin
       acompany := '';
     end
     else
     begin
       acompany := GetCompanyLineSQL ;
       acompany :=  acompany + Quot(cbbBulan.Text) + 'Periode ,'+ Quot(edtTahun.Text) + ' Tahun,' ;
     end;

   afilter1 := ' and sarek_periode = '+ IntToStr(cbbBulan.itemindex +1) + ' and sarek_tahun = ' + edtTahun.Text ;

// isi kas dan bank
         ssql:= ' SELECT rek_nama,sarek_akhir,' + Quot('Aktiva Lancar') + ' Kelompok  from tsarekening , trekening where sarek_kode=rek_kode and rek_tingkat=4 '
              + ' and (rek_kode like ' + quot('10.01%') + ' or rek_kode like '+ quot('10.02%') + ')'
              + afilter1 ;

       i := 0;
       tsql := xOpenQuery(ssql,MainForm.conIntrbs);
       tt := TStringList.Create;
       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := Fields[0].AsString;
                 Floats[2,i] := Fields[1].AsFloat;
                 Cells[3,i] := Fields[2].AsString;


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;


// piutang
          ssql:= ' SELECT sum(sarek_akhir) from tsarekening , trekening where sarek_kode=rek_kode and rek_tingkat=4  '
              + ' and rek_kode like ' + quot('10.03%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := 'Biaya Dimuka';
                 Floats[2,i] := Fields[0].AsFloat;
                 Cells[3,i] := 'Aktiva Lancar';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;

//Uang Muka PEMBELIAN
         ssql:= ' SELECT rek_nama,sarek_akhir,' + Quot('Aktiva Lancar') + ' Kelompok  from tsarekening , trekening where sarek_kode=rek_kode and rek_tingkat=4  '
              + ' and rek_kode like ' + quot('10.04%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);
       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := Fields[0].AsString;
                 Floats[2,i] := Fields[1].AsFloat;
                 Cells[3,i] := Fields[2].AsString;


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Piutang Usaha')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;

// PERSEDIAAN bARANG DAGANGGAN
          ssql:= ' SELECT sum(sarek_akhir) from tsarekening , trekening where sarek_kode=rek_kode  and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('10.05%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := 'Piutang Lain lain';
                 Floats[2,i] := Fields[0].AsFloat;
                 Cells[3,i] := 'Aktiva Lancar';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;
       ssql:= ' SELECT sum(sarek_akhir) from tsarekening , trekening where sarek_kode=rek_kode  and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('10.06%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := 'Piutang Pajak';
                 Floats[2,i] := Fields[0].AsFloat;
                 Cells[3,i] := 'Aktiva Lancar';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;

       ssql:= ' SELECT sum(sarek_akhir) from tsarekening , trekening where sarek_kode=rek_kode  and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('10.07%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := 'PPN Masukan';
                 Floats[2,i] := Fields[0].AsFloat;
                 Cells[3,i] := 'Aktiva Lancar';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;
       ssql:= ' SELECT sum(sarek_akhir) from tsarekening , trekening where sarek_kode=rek_kode and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('10.08%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := 'Persediaan Bahan Baku';
                 Floats[2,i] := Fields[0].AsFloat;
                 Cells[3,i] := 'Aktiva Lancar';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;

       ssql:= ' SELECT sum(sarek_akhir) from tsarekening , trekening where sarek_kode=rek_kode and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('10.09%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := 'Beban di bayar dimuka';
                 Floats[2,i] := Fields[0].AsFloat;
                 Cells[3,i] := 'Aktiva Lancar';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;
 // aktiva tetap
          ssql:= ' SELECT rek_nama, sarek_akhir  from tsarekening , trekening where sarek_kode=rek_kode  and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('11%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := 'PPN';
                 Floats[2,i] := Fields[1].AsFloat;
                 Cells[3,i] := 'Aktiva Tetap';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;

                 ssql:= ' SELECT rek_nama, sarek_akhir  from tsarekening , trekening where sarek_kode=rek_kode and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('12%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := fields[0].AsString;
                 Floats[2,i] := Fields[1].AsFloat;
                 Cells[3,i] := 'Aktiva Tetap';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;
                 ssql:= ' SELECT rek_nama, sarek_akhir  from tsarekening , trekening where sarek_kode=rek_kode and rek_tingkat=4 '
              + ' and rek_kode like ' + quot('13%')
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try

           with AdvColumnGrid1 do
           begin

              while not Eof do
              begin

                 i := i +1 ;
                 Cells[0,i] := IntToStr(i);
                 Cells[1,i] := fields[0].AsString;
                 Floats[2,i] := Fields[1].AsFloat;
                 Cells[3,i] := 'Aktiva Tetap';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,i]) + ','
                  +  FloatToStr(floats[2,i]) + ','
                  +  Quot(Cells[3,i]) + ','
                  +  Quot('Aktiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid1.AutoSize := True ;
              AdvColumnGrid1.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;


       // PASIVA
          ssql:= ' SELECT rek_nama, sarek_akhir  from tsarekening , trekening where sarek_kode=rek_kode  and rek_tingkat=4 '
              + ' and (rek_kode like ' + quot('2%') + ' or  rek_kode like ' + quot('3%') + ')'
              + afilter1 ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);
       x := 0;
       with tsql do
       begin
         try

           with AdvColumnGrid2 do
           begin

              while not Eof do
              begin

                 x := x +1 ;
                 Cells[0,x] := IntToStr(x);
                 Cells[1,x] := Fields[0].AsString;
                 Floats[2,x] := Fields[1].AsFloat;
                 Cells[3,x] := 'Pasiva';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,x]) + ','
                  +  FloatToStr(floats[2,x]) + ','
                  +  Quot(Cells[3,x]) + ','
                  +  Quot('Pasiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid2.AutoSize := True ;
              AdvColumnGrid2.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;
      if not cektutupperiode(cbbBulan.ItemIndex + 1,StrToInt(edtTahun.Text)) then
      begin
        ssql := ' select sum(sarek_debet-sarek_kredit) from tsarekening inner join trekening on rek_kode=sarek_Kode and rek_tingkat=4 '
        + ' where (sarek_kode like ' + quot('4%')
        + ' or sarek_kode like ' + quot('5%')
        + ' or sarek_kode like ' + quot('6%')
        + ' or sarek_kode like ' + quot('7%')
        + ' or sarek_kode like ' + quot('8%')
        + ' ) AND ((SAREK_PERIODE <= ' + IntToStr(cbbBulan.ItemIndex + 1)
        + ' AND SAREK_TAHUN <= ' + edtTahun.Text+ ')  OR (SAREK_TAHUN < '+edtTahun.Text+'))' ;


       tsql := xOpenQuery(ssql,MainForm.conIntrbs);

       with tsql do
       begin
         try
           with AdvColumnGrid2 do
           begin
              while not Eof do
              begin

                 x := x +1 ;
                 Cells[0,x] := IntToStr(x);
                 Cells[1,x] := 'LABA RUGI TAMPUNGAN ';
                 Floats[2,x] := Fields[0].AsFloat;
                 Cells[3,x] := 'Pasiva';


                 s:= 'insert into temp_table (char1,num1,char2,char3) values ('
                  +  Quot(cells[1,x]) + ','
                  +  FloatToStr(floats[2,x]) + ','
                  +  Quot(Cells[3,x]) + ','
                  +  Quot('Pasiva')
                  + ');';
                  tt.Append(s);
                 tsql.Next;
                 AddRow;
              end;
              AdvColumnGrid2.AutoSize := True ;
              AdvColumnGrid2.Columns[0].Width :=40;

           end;
         finally
           free;
         end;
       end;

     end;

       SumGridJurnal;
       SumGridJurnal2;
       edtselisih.Text :=  formatfloat('###,###,###,###',xtotal+xtotal2);
       try
              s:= 'delete from temp_table ;';
              xExecQuery(s,MainForm.conIntrbs);
              xCommit(MainForm.conIntrbs);
              for z:=0 to tt.Count -1 do
              begin
                  xExecQuery(tt[z],MainForm.conIntrbs);
              end;
            finally
              tt.Free;
            end;


//
     if atipe <> '' then
      begin
       ssql := 'select ' + acompany
              + ' char1 Perkiraan,num1 Nomor,char2 Kelompok,char3 gol'
              + ' from temp_table ' ;
       ftsreport := TTSReport.Create(nil);
       ftsreport.Nama := 'cetakNeracaSaldo';
       try
        ftsreport.AddSQL(ssql);
        ftsreport.ShowReport;
       finally
         ftsreport.Free;
        end;
      end;



end;

procedure TfrmNeracaSaldo.FormShow(Sender: TObject);
begin
   refreshdata;
  showdata;
end;

procedure TfrmNeracaSaldo.autonumber(aGrid : TAdvColumnGrid);
var
 i : integer;
begin
   for i := 1 to agrid.rowcount-1 do
   begin
     agrid.Cells[0,i] := IntToStr(i);
   end;
  // TODO -cMM: TfrmBarang.autonumber default body inserted
end;



procedure TfrmNeracaSaldo.TeSpeedButton1Click(Sender: TObject);
var
  s: string;
begin
//   if SaveDialog1.Execute then
//  begin
//  with SaveDialog1 do
//  begin
//     if not (trim(FileName)='') then
//    begin
//      s:=FileName;
//       if SaveAsExcelFile(AdvColumnGrid1, s) then
//    CommonDlg.ShowMessage('Data Tersimpan di ' + s);
//    end;
//
//
//  end;
// end;
savetoexcelnew(AdvColumnGrid1);
savetoexcelnew(AdvColumnGrid2);
end;

procedure TfrmNeracaSaldo.showdata;
var
  s:string;
  tsql : TMyQuery;
begin
  s:= ' select * from TPERIODEAKTIF';
  tsql := xOpenQuery(s,MainForm.conIntrbs);
  with tsql do
    begin
        try
           cbbBulan.ItemIndex :=  StrToInt(Fields[0].AsString) - 1;
           edtTahun.Text := Fields[1].AsString;
           cbbBulan.SetFocus;
        finally
          Free;
       end;
    End;
end;

procedure TfrmNeracaSaldo.SumGridJurnal;
var
  i: Integer;
begin
  with AdvColumnGrid1 do
  begin
    AddRow;
    FloatingFooter.Visible:= True;
    MergeCells(0, RowCount-1, 2, 1);
    Cells[0, RowCount-1] := 'G R A N D   T O T A L';
    for i := 2 to 2 do
    begin
         Floats[i, RowCount-1] := ColumnSum(i, FixedRows, RowCount-2);
         xtotal := ColumnSum(i, FixedRows, RowCount-2);
    end;
  end;
end;

procedure Tfrmneracasaldo.SumGridJurnal2;
var
  i: Integer;
begin
  with AdvColumnGrid2 do
  begin
    AddRow;
    FloatingFooter.Visible:= True;
    MergeCells(0, RowCount-1, 2, 1);
    Cells[0, RowCount-1] := 'G R A N D   T O T A L';
    for i := 2 to 2 do
    begin
         Floats[i, RowCount-1] := ColumnSum(i, FixedRows, RowCount-2);
         xtotal2 := ColumnSum(i, FixedRows, RowCount-2);
    end;
  end;
end;

function Tfrmneracasaldo.cektutupperiode(abulan:Integer;atahun:Integer): Boolean;
var
  s: string ;
  tsql : TMyQuery;
begin
  s := 'select * from ttutupperiode where tutup_bulan = ' + IntToStr(abulan)
      + ' and  tutup_tahun = ' + IntToStr(atahun);
  tsql := xOpenQuery(s,MainForm.conIntrbs);
  with tsql do
  begin
      if Eof then
         Result := false
      else
      begin
        Result := true;
     end;
  end;
end;
end.



