object frmOtorisasi: TfrmOtorisasi
  Left = 726
  Top = 245
  Width = 358
  Height = 204
  BorderIcons = []
  Caption = 'Otorisasi'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 33
    Width = 342
    Height = 132
    Align = alClient
    Color = clWhite
    TabOrder = 0
    UseDockManager = True
    AnchorHint = False
    AutoSize.Enabled = False
    AutoSize.Height = True
    AutoSize.Width = True
    AutoHideChildren = True
    BackgroundPosition = bpTopLeft
    BorderColor = 15447636
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
    object TeLabel12: TLabel
      Left = 20
      Top = 22
      Width = 28
      Height = 14
      Caption = 'Kode'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 20
      Top = 44
      Width = 45
      Height = 14
      Caption = 'Otorisasi'
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object edtUser: TAdvEditBtn
      Left = 128
      Top = 18
      Width = 137
      Height = 21
      AutoFocus = False
      EditAlign = eaLeft
      EditType = etString
      ErrorMarkerPos = 0
      ErrorMarkerLen = 0
      ErrorColor = clRed
      ErrorFontColor = clWhite
      ExcelStyleDecimalSeparator = False
      Flat = False
      FlatLineColor = clBlack
      FlatParentColor = True
      FocusAlign = eaDefault
      FocusBorder = False
      FocusColor = clWindow
      FocusFontColor = clWindowText
      FocusLabel = False
      FocusWidthInc = 0
      ModifiedColor = clHighlight
      DisabledColor = clSilver
      URLColor = clBlue
      ReturnIsTab = False
      LengthLimit = 0
      TabOnFullLength = False
      Precision = 0
      LabelPosition = lpLeftTop
      LabelMargin = 4
      LabelTransparent = False
      LabelAlwaysEnabled = False
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.CaseSensitive = False
      Lookup.Color = clWindow
      Lookup.DisplayCount = 4
      Lookup.Enabled = False
      Lookup.History = False
      Lookup.NumChars = 2
      Lookup.Multi = False
      Lookup.Separator = ';'
      Persistence.Enable = False
      Persistence.Location = plInifile
      Color = clSkyBlue
      Enabled = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      HintShowLargeText = False
      ParentFont = False
      OleDropTarget = False
      OleDropSource = False
      ReadOnly = True
      Signed = False
      TabOrder = 0
      Transparent = False
      Visible = True
      OnKeyDown = edtUserKeyDown
      OnKeyPress = edtUserKeyPress
      ButtonWidth = 16
      Etched = False
      OnClickBtn = edtuserButtonClick
    end
    object edtPassword: TEdit
      Left = 128
      Top = 40
      Width = 137
      Height = 21
      TabOrder = 1
      OnKeyPress = edtUserKeyPress
    end
    object cxButton8: TcxButton
      Left = 239
      Top = 92
      Width = 89
      Height = 37
      Caption = '&Keluar'
      TabOrder = 3
      OnClick = cxButton1Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001D63
        9B1619609839145D9562105A92880D5890A4135C92FC0C578FED999999FF7171
        71FF545454FF515151FF4F4F4FFF4C4C4CFF4A4A4AFF474747FF454545FF2567
        9DFF3274A8FF3D7CAFFF4784B5FF4E8ABAFF3E7EADFF0C578FEAFFFFFF00FFFF
        FF00585858FFA2A2A2FFA2A2A2FFA3A3A3FFA4A4A4FFA4A4A4FFA5A5A5FF2F6F
        A5FF78ABD2FF78ABD3FF73A7D1FF69A0CDFF407FAEFF0F5991EAFFFFFF00FFFF
        FF005C5C5CFFA1A1A1FF3C7340FFA0A1A1FFA3A3A3FFA3A3A3FFA4A4A4FF3674
        AAFF7DAFD4FF5B9AC9FF5495C7FF5896C8FF4180AEFF135C94EAFFFFFF00FFFF
        FF00606060FFA0A0A0FF3D7641FF367139FFA2A2A2FFA2A2A2FFA3A3A3FF3D79
        B0FF82B3D7FF629FCCFF5A9AC9FF5E9BCAFF4381AFFF196098EA37823EFF347E
        3BFF317937FF2E7534FF499150FF468F4CFF39733DFFA1A1A1FFA2A2A2FF457E
        B4FF88B7D9FF67A3CFFF619ECCFF639FCCFF4583B1FF1F649CEA3B8742FF89CB
        92FF84C88DFF80C688FF7BC383FF77C17FFF478F4DFF3B743FFFA1A1A1FF4C84
        BAFF8DBBDBFF6EA8D1FF66A6D1FF5FB4DFFF4785B1FF2569A1EA3E8B46FF8FCE
        99FF7DC687FF78C381FF73C07CFF74C07CFF79C281FF49904FFF547F57FF5489
        BFFF94BFDDFF75ADD4FF63B8E1FF4BD4FFFF428BB8FF2C6EA6EA41904AFF94D2
        9FFF91D09AFF8DCD96FF89CB92FF84C88DFF519858FF417C46FF9F9F9FFF5A8E
        C4FF98C3E0FF7CB3D7FF74AFD6FF5EC4EDFF4B88B3FF3473ABEA44944DFF4291
        4BFF3F8D48FF3D8945FF5DA465FF5AA061FF45834BFF9E9E9EFF9E9E9EFF6092
        C9FF9EC7E2FF83B8DAFF7DB4D7FF7EB3D7FF4F89B4FF3B79B1EAFFFFFF00FFFF
        FF00777777FF9A9A9AFF3D8A45FF498A4FFF9C9C9CFF9D9D9DFF9D9D9DFF6696
        CCFFA2CBE3FF89BDDCFF83B9DAFF84B9DAFF518BB5FF437EB6EAFFFFFF00FFFF
        FF007A7A7AFF999999FF529159FF999A99FF9B9B9BFF9C9C9CFF9C9C9CFF6C9A
        D0FFA7CEE5FF8FC1DFFF89BDDCFF8BBDDCFF538DB6FF4B84BCEAFFFFFF00FFFF
        FF007D7D7DFF999999FF999999FF9A9A9AFF9A9A9AFF9B9B9BFF9B9B9BFF6F9D
        D3FFAAD1E7FFABD1E7FF98C7E1FF91C2DEFF568FB7FF5289C1EAFFFFFF00FFFF
        FF00808080FF7E7E7EFF7C7C7CFF7A7A7AFF777777FF757575FF727272FF719E
        D4FF6F9ED6FF87B2DCFFABD3E8FFA9D0E6FF5890B8FF598EC6EAFFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00709ED6DB6D9CD4FF85B1DAFF5A91B9FF6093CBEAFFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF006D9CD4896A9AD2FB6697CFEE}
      LookAndFeel.Kind = lfStandard
      LookAndFeel.SkinName = 'LondonLiquidSky'
    end
    object cxButton1: TcxButton
      Left = 142
      Top = 92
      Width = 89
      Height = 37
      Caption = '&Otorisasi'
      TabOrder = 2
      OnClick = cxButton2Click
      Glyph.Data = {
        9A050000424D9A05000000000000360000002800000014000000170000000100
        1800000000006405000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0F1C6C6C4B4B3B0B0B2
        AFB6B6B2B8B8B4B8B8B4B7B8B4B7B8B3B8B8B5B7B8B4B8B8B4B7B7B4B3B4B1B5
        B5B0BCBCB8E5E5E4FFFFFFFFFFFFFFFFFFEAEBEA8B8D86909285A5A79A959788
        8E91859093878F91869091859092869093869092869192869FA1929FA194797C
        72CDCDCBFFFFFFFFFFFFFFFFFFF2F0ECA2937EBBA587D7CEBAB6B8ABADA594B6
        9D86B2A593ACB0A4B0AA99B49E86B0A28EB0B0A2CBCBBDD6BDA69A8E77DAD9D5
        FFFFFFFFFFFFFFFFFFE3ECF1478EBD2CB8F35E95A4644430506B7035BDEE478F
        A862473454616036B9E7419ABA6051436F5F5142CAF32674A1B2B5B6FFFFFFFF
        FFFFFFFFFFDDEFF9288BD91273A64F361D2A4A5400ADE40A94C0352A222F3333
        00ACE606A0CE2F323235312D1DA2CA0BB8DA000719A19B97FFFFFFFFFFFFFFFF
        FFDFEBF22A4B6448270A6C736B0BCEFF168EB246261635454A03BFF912A0C842
        2C1F3A3B3807ACE62DC0E4645341000000A5AFB8FFFFFFFFFFFFFFFFFFDCD9D9
        1E1614234B5936D7FF0965801C0B0116415200B2FB0083B4240B001C333800A7
        F20091C6484430544F35005AAA9ACBEFFFFFFFFFFFFFFFFFFFEEEDEB7F7E76A9
        C5C6DCF3EFAC9A889D988DA4BBBCA7BCBBA49487A0988BA4B6B7A4BDBFAFA696
        D5CBB2CFDED572949FD0D5D6FFFFFFFFFFFFFFFFFFF1F1F0919189B5B09DE1DA
        C8C0C2B6B3B5A9B6B2A3B6AE9FB8B6ABB8B9AEB6B3A4B5AD9CB5B5A8D4D7CBD8
        D6C67E7665D9D6D1FFFFFFFFFFFFFFFFFFF1F1F0919087BDBFB0F0F2E2C1C2B7
        B1B2A9B7B8AEB6B8AEB6B7AEB6B7ADB6B8AEB4B6ACB9BAB0E1E3D4E6E8D87E7F
        75D9DAD6FFFFFFFFFFFFFFFFFFF0F0EF8A8C84B2B2A5E0E4D0BBBDB1AEAFA7B4
        B5ABB3B3ABB3B4ABB3B4ABB3B4ABB2B3A9B5B5ABD5D6C6D8DAC872746BD6D7D3
        FFFFFFFFFFFFFFFFFFEEEEED929486D5D4CAFFFFFFD5D7CAC6C7BBCBCDC0CACC
        BFCACDBFCACBBFCBCCBFC8C9BED0D1C5F6F8EDF9F9F78A8B7BD0D1CBFFFFFFFF
        FFFFFFFFFFFFFEFEC9C9C4CCCDC4C9CAC2F1F1E9F2F3E7F0F0E5F0F1E5F0F1E6
        F0F1E6F0F0E6F3F5E9E6E8DDE5E6DDC3C4BDC8C7C0F2F3F1FFFFFFFFFFFFFFFF
        FFFFFFFFCCCDC9D6D8C68A8B7BFFFFFFF9F9FAF8F7F9F8F7F9F8F7F9F8F7F9F7
        F7F8FDFCFFD9DAD9D4D6C48C8E7FEDEDEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        CCCCC9DDDFD1929487FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFE1E0DFDBDBCC9C9D90EBEAE7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0CFCCCC
        CDBF919386FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDDFDC
        D8D8CA9FA294E8E7E6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7D7D4BABAAE9596
        8AE9E9E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D6D3C2C3B59E
        9F93FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F4F4BABAB19E9E92B7B9AF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8B5B5ACB2B4A5A6A79DFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD3D4CFB9B9ACA0A395C6C6BFF5
        F4F4FFFFFFFFFFFFFDFDFEF1F2F0BABBB4A6A698AEAF9FECEDEBFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFECDCEC7BDBFAEB0B1A4ADAFA5CDCE
        C6D6D7D1CBCCC4A9AAA0AEAFA1BEC0B0D4D4CDFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDEDEDAD0D2C3D7D8C9C2C3B6C7C8BE
        C2C4B5D9DBCBD3D4C6E8E8E4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      LookAndFeel.Kind = lfStandard
      LookAndFeel.SkinName = 'LondonLiquidSky'
    end
  end
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 0
    Width = 342
    Height = 33
    Align = alTop
    Color = clWhite
    TabOrder = 1
    UseDockManager = True
    AnchorHint = False
    AutoSize.Enabled = False
    AutoSize.Height = True
    AutoSize.Width = True
    AutoHideChildren = True
    BackgroundPosition = bpTopLeft
    BorderColor = 15447636
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
    ShadowColor = clBlack
    ShadowOffset = 2
    ShowMoveCursor = False
    TextVAlign = tvaTop
    TopIndent = 0
    URLColor = clBlue
    FullHeight = 0
    object Label2: TLabel
      Left = 114
      Top = 7
      Width = 107
      Height = 22
      Caption = 'OTORISASI'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Algerian'
      Font.Style = []
      ParentFont = False
    end
  end
end
