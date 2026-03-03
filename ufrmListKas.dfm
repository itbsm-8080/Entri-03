inherited frmListKas: TfrmListKas
  Top = 139
  Caption = 'Buku Bank'
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    FullHeight = 0
    inherited cxButton1: TcxButton
      Visible = False
    end
    inherited cxButton2: TcxButton
      Visible = False
    end
    inherited cxButton3: TcxButton
      Visible = False
    end
    inherited cxButton4: TcxButton
      Visible = False
    end
    inherited cxButton6: TcxButton
      Visible = False
    end
  end
  inherited AdvPanel2: TAdvPanel
    Height = 57
    FullHeight = 0
    object Label3: TLabel [2]
      Left = 9
      Top = 32
      Width = 46
      Height = 13
      Caption = 'Rekening'
    end
    inherited btnRefresh: TcxButton
      Height = 55
    end
    object cxLookupRekeningCash: TcxExtLookupComboBox
      Left = 97
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
    Height = 383
    FullHeight = 0
    inherited cxGrid: TcxGrid
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
