inherited frmListKas2: TfrmListKas2
  Left = 298
  Top = 180
  Caption = 'Kas Harian'
  ClientWidth = 936
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    Width = 936
    FullHeight = 0
    inherited cxButton1: TcxButton
      Visible = False
    end
    inherited cxButton2: TcxButton
      Visible = False
    end
    inherited cxButton3: TcxButton
      OnClick = cxButton3Click
    end
    inherited cxButton4: TcxButton
      Visible = False
    end
    inherited cxButton6: TcxButton
      Visible = False
    end
    inherited cxButton8: TcxButton
      Left = 847
    end
  end
  inherited AdvPanel2: TAdvPanel
    Width = 936
    Height = 57
    FullHeight = 0
    inherited Label1: TLabel
      Width = 44
      Caption = 'Periode'
    end
    inherited Label2: TLabel
      Visible = False
    end
    object Label3: TLabel [2]
      Left = 13
      Top = 32
      Width = 55
      Height = 13
      Caption = 'Rekening'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited btnRefresh: TcxButton
      Left = 848
      Height = 55
    end
    inherited enddate: TDateTimePicker
      Visible = False
    end
    object cxLookupRekeningCash: TcxExtLookupComboBox
      Left = 109
      Top = 28
      Properties.ImmediatePost = True
      Style.Color = clWindow
      Style.LookAndFeel.Kind = lfFlat
      Style.TransparentBorder = True
      StyleDisabled.LookAndFeel.Kind = lfFlat
      StyleFocused.LookAndFeel.Kind = lfFlat
      StyleHot.LookAndFeel.Kind = lfFlat
      TabOrder = 3
      Width = 440
    end
  end
  inherited AdvPanel3: TAdvPanel
    Top = 57
    Width = 936
    Height = 383
    FullHeight = 0
    inherited cxGrid: TcxGrid
      Width = 932
      Height = 379
      inherited cxGrdMaster: TcxGridDBTableView
        PopupMenu = PopupMenu1
        OptionsView.Footer = True
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 217
    object LihatFakturPenjualan1: TMenuItem
      Caption = 'Lihat Detail'
      OnClick = LihatFakturPenjualan1Click
    end
  end
end
