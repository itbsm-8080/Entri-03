inherited frmBrowseInvoice: TfrmBrowseInvoice
  Left = 499
  Top = 142
  Caption = 'Browse Invoice'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    FullHeight = 0
    inherited cxButton1: TcxButton
      OnClick = cxButton1Click
    end
    inherited cxButton2: TcxButton
      OnClick = cxButton2Click
    end
    inherited cxButton3: TcxButton
      OnClick = cxButton3Click
    end
    inherited cxButton4: TcxButton
      Visible = False
    end
  end
  inherited AdvPanel2: TAdvPanel
    FullHeight = 0
  end
  inherited AdvPanel3: TAdvPanel
    FullHeight = 0
    inherited cxGrid: TcxGrid
      PopupMenu = PopupMenu2
      inherited cxGrdMaster: TcxGridDBTableView
        OptionsView.Footer = True
        Styles.OnGetContentStyle = cxGrdMasterStylesGetContentStyle
      end
    end
  end
  object AdvPanel4: TAdvPanel [3]
    Left = 352
    Top = 192
    Width = 283
    Height = 137
    TabOrder = 3
    UseDockManager = True
    Visible = False
    AnchorHint = False
    AutoSize.Enabled = False
    AutoSize.Height = True
    AutoSize.Width = True
    AutoHideChildren = True
    BackgroundPosition = bpTopLeft
    BorderColor = clBlack
    BorderShadow = False
    Buffered = True
    CanMove = False
    CanSize = False
    Caption.ButtonPosition = cbpRight
    Caption.Color = clHighlight
    Caption.ColorTo = clNone
    Caption.CloseColor = clBtnFace
    Caption.CloseButton = False
    Caption.CloseButtonColor = clWhite
    Caption.Flat = False
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clHighlightText
    Caption.Font.Height = -11
    Caption.Font.Name = 'MS Sans Serif'
    Caption.Font.Style = []
    Caption.Height = 20
    Caption.Indent = 0
    Caption.MinMaxButton = False
    Caption.MinMaxButtonColor = clWhite
    Caption.ShadeLight = 200
    Caption.ShadeGrain = 32
    Caption.ShadeType = stNormal
    Caption.Shape = csRectangle
    Caption.TopIndent = 0
    Caption.Visible = False
    Collaps = False
    CollapsColor = clGray
    CollapsDelay = 20
    CollapsSteps = 0
    ColorTo = clNone
    FixedTop = False
    FixedLeft = False
    FixedHeight = False
    FixedWidth = False
    FreeOnClose = False
    Hover = False
    HoverColor = clNone
    HoverFontColor = clNone
    Indent = 0
    LineSpacing = 0
    Position.Save = False
    Position.Location = clRegistry
    ShadowColor = clGray
    ShadowOffset = 2
    ShowMoveCursor = False
    TextVAlign = tvaTop
    TopIndent = 0
    URLColor = clBlue
    FullHeight = 0
    object AdvPanel5: TAdvPanel
      Left = 1
      Top = 1
      Width = 281
      Height = 41
      Align = alTop
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      UseDockManager = True
      AnchorHint = False
      AutoSize.Enabled = False
      AutoSize.Height = True
      AutoSize.Width = True
      AutoHideChildren = True
      BackgroundPosition = bpCenter
      BorderColor = clBlack
      BorderShadow = False
      Buffered = True
      CanMove = False
      CanSize = False
      Caption.ButtonPosition = cbpRight
      Caption.Color = clHighlight
      Caption.ColorTo = clNone
      Caption.CloseColor = clBtnFace
      Caption.CloseButton = False
      Caption.CloseButtonColor = clWhite
      Caption.Flat = False
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clHighlightText
      Caption.Font.Height = -11
      Caption.Font.Name = 'MS Sans Serif'
      Caption.Font.Style = []
      Caption.Height = 20
      Caption.Indent = 0
      Caption.MinMaxButton = False
      Caption.MinMaxButtonColor = clWhite
      Caption.ShadeLight = 200
      Caption.ShadeGrain = 32
      Caption.ShadeType = stNormal
      Caption.Shape = csRectangle
      Caption.TopIndent = 0
      Caption.Visible = False
      Collaps = False
      CollapsColor = clGray
      CollapsDelay = 20
      CollapsSteps = 0
      ColorTo = clNone
      FixedTop = False
      FixedLeft = False
      FixedHeight = False
      FixedWidth = False
      FreeOnClose = False
      Hover = False
      HoverColor = clNone
      HoverFontColor = clNone
      Indent = 0
      LineSpacing = 0
      Position.Save = False
      Position.Location = clRegistry
      ShadowColor = clOlive
      ShadowOffset = 2
      ShowMoveCursor = False
      TextVAlign = tvaCenter
      TopIndent = 0
      URLColor = clBlue
      FullHeight = 0
      object cxLabel3: TcxLabel
        Left = 60
        Top = 8
        Caption = 'Input Nomor Pajak'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -19
        Style.Font.Name = 'Modern No. 20'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
      end
    end
    object AdvPanel6: TAdvPanel
      Left = 1
      Top = 104
      Width = 281
      Height = 32
      Align = alBottom
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      UseDockManager = True
      AnchorHint = False
      AutoSize.Enabled = False
      AutoSize.Height = True
      AutoSize.Width = True
      AutoHideChildren = True
      BackgroundPosition = bpCenter
      BorderColor = clBlack
      BorderShadow = False
      Buffered = True
      CanMove = False
      CanSize = False
      Caption.ButtonPosition = cbpRight
      Caption.Color = clHighlight
      Caption.ColorTo = clNone
      Caption.CloseColor = clBtnFace
      Caption.CloseButton = False
      Caption.CloseButtonColor = clWhite
      Caption.Flat = False
      Caption.Font.Charset = DEFAULT_CHARSET
      Caption.Font.Color = clHighlightText
      Caption.Font.Height = -11
      Caption.Font.Name = 'MS Sans Serif'
      Caption.Font.Style = []
      Caption.Height = 20
      Caption.Indent = 0
      Caption.MinMaxButton = False
      Caption.MinMaxButtonColor = clWhite
      Caption.ShadeLight = 200
      Caption.ShadeGrain = 32
      Caption.ShadeType = stNormal
      Caption.Shape = csRectangle
      Caption.TopIndent = 0
      Caption.Visible = False
      Collaps = False
      CollapsColor = clGray
      CollapsDelay = 20
      CollapsSteps = 0
      ColorTo = clNone
      FixedTop = False
      FixedLeft = False
      FixedHeight = False
      FixedWidth = False
      FreeOnClose = False
      Hover = False
      HoverColor = clNone
      HoverFontColor = clNone
      Indent = 0
      LineSpacing = 0
      Position.Save = False
      Position.Location = clRegistry
      ShadowColor = clOlive
      ShadowOffset = 2
      ShowMoveCursor = False
      TextVAlign = tvaCenter
      TopIndent = 0
      URLColor = clBlue
      FullHeight = 0
      object cxButton5: TcxButton
        Left = 193
        Top = 1
        Width = 87
        Height = 30
        Caption = '&Ok'
        TabOrder = 0
        OnClick = cxButton5Click
        Align = alRight
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FF00FF00DEE7
          E700ADB5BD00ADB5BD00ADB5BD00ADB5BD00ADB5BD00ADB5BD00ADB5BD00ADB5
          BD00ADB5BD00ADB5BD00ADB5BD00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00FFFFFF00FFFFFF00DEE7FF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00FFFFFF005A6B9C00A5B5D600FFFFFF00F7FFFF00F7FF
          FF00F7FFFF00F7FFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00FFFFFF00738CB500849CC60094ADDE00FFFFFF00F7FF
          FF00F7FFFF00F7FFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00FFFFFF009CC6F700D6F7FF0073A5E70094A5D600FFFF
          FF00F7FFFF00F7FFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00FFFFFF007BCEF70063E7FF005AD6FF005A9CE700FFFF
          FF00F7FFFF00F7FFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00FFFFFF009CE7FF0042E7FF0042CEFF004AA5F700A5C6
          EF00FFFFFF00F7FFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00E7F7FF0021CEFF0039CEFF0031B5FF005A8C
          DE00EFF7FF00F7FFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00F7FFFF0073D6FF0021D6FF0029BDFF00107B
          EF00C6D6EF00F7FFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00FFFFFF00ADDEFF0018DEFF0018BDFF0021A5
          FF003963C600FFFFFF00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00FFFFFF0031C6F70008CEFF0010A5
          FF001073F700C6C6D600FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00FFFFFF00BDD6F70000D6FF0000B5
          FF000084FF004A6BCE00FFFFFF00ADB5BD00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00FFFFFF0000B5F70000C6
          FF00009CFF00185AE700BDB5BD00FF00FF00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00FFFFFF00BDEFFF0000C6
          FF0000A5FF00007BFF000031C600FF00FF00FF00FF00FF00FF00FF00FF00DEE7
          E700FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00EFF7FF0031D6
          FF0010C6FF007BCEFF002963EF00FF00FF00FF00FF00FF00FF00FF00FF00DEE7
          E700DEE7E700D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600E7DED6006BB5
          DE0052A5E7004A6BCE00FF00FF00FF00FF00FF00FF00FF00FF00}
        LookAndFeel.Kind = lfStandard
        LookAndFeel.SkinName = 'LondonLiquidSky'
      end
    end
    object cxLabel1: TcxLabel
      Left = 12
      Top = 75
      Caption = 'No Pajak'
    end
    object edtNopajak: TcxTextEdit
      Left = 72
      Top = 74
      TabOrder = 3
      Width = 193
    end
    object cxLabel2: TcxLabel
      Left = 12
      Top = 51
      Caption = 'Invoice'
    end
    object edtInvoice: TcxTextEdit
      Left = 72
      Top = 50
      Enabled = False
      TabOrder = 5
      Width = 193
    end
  end
  inherited ldsp: TDataSetProvider
    Left = 567
    Top = 216
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 273
    object HistoryPembayaran1: TMenuItem
      Caption = 'History Pembayaran'
      OnClick = HistoryPembayaran1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 360
    Top = 273
    object UpdateStatusKembali1: TMenuItem
      Caption = 'Update Status Pajak'
      OnClick = UpdateStatusKembali1Click
    end
    object InputNoPajak1: TMenuItem
      Caption = 'Input NoPajak'
      OnClick = InputNoPajak1Click
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 216
    Top = 185
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
    object cxStyle2: TcxStyle
    end
  end
end
