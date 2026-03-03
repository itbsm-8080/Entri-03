unit ufrmCetak;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, cxLookAndFeelPainters, AdvMemo, StdCtrls, cxButtons,
  ExtCtrls, AdvPanel, RAWPrinter, cxGraphics, cxLookAndFeels, dxSkinsCore,
  dxSkinsDefaultPainters;

type
  TfrmCetak = class(TForm)
    AdvPanel3: TAdvPanel;
    cxButton8: TcxButton;
    cxButton3: TcxButton;
    memo: TAdvMemo;
    RAWPrinter1: TRAWPrinter;
    procedure cxButton8Click(Sender: TObject);
    procedure cxButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    nomor :string;
    { Public declarations }
  end;

var
  frmCetak: TfrmCetak;

implementation
  uses Ulib,MAIN,uModuleConnection;
{$R *.dfm}

procedure TfrmCetak.cxButton8Click(Sender: TObject);
begin
close;
end;

procedure TfrmCetak.cxButton3Click(Sender: TObject);
begin
  if nomor = '' then
    nomor := 'nota';
  memo.Lines.SaveToFile(frmMenu.apathimage+nomor+'.txt');
  CetakFile( frmMenu.apathimage+nomor+'.txt');
//  RAWPrinter1.PrinterName := '';
//  RAWPrinter1.FontName := rfnCourier;
//  RAWPrinter1.FontPitch := rfpCondensed;
//  RAWPrinter1.BeginDoc;  // start printing
//  RAWPrinter1.WriteList(memo.Lines, true);  // print memo text
//  RAWPrinter1.EndDoc;  // stop printing
//  RAWPrinter1.EjectOnFinish:=False;
close;
end;

procedure TfrmCetak.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=caFree;
end;

end.
