object frmLapDetailCheckIn: TfrmLapDetailCheckIn
  Left = -7
  Top = 181
  Width = 1038
  Height = 398
  Caption = 'Laporan Detail CheckIn'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 41
    Width = 1022
    Height = 51
    Align = alTop
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 0
    UseDockManager = True
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
    Caption.Font.Name = 'Tahoma'
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
    object Label1: TLabel
      Left = 16
      Top = 14
      Width = 38
      Height = 13
      Caption = 'Tanggal'
    end
    object Label2: TLabel
      Left = 222
      Top = 16
      Width = 11
      Height = 13
      Caption = 'sd'
    end
    object Button1: TButton
      Left = 408
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = Button1Click
    end
    object startdate: TDateTimePicker
      Left = 70
      Top = 11
      Width = 145
      Height = 21
      Date = 42350.468570856480000000
      Time = 42350.468570856480000000
      TabOrder = 1
    end
    object enddate: TDateTimePicker
      Left = 246
      Top = 11
      Width = 145
      Height = 21
      Date = 42350.468570856480000000
      Time = 42350.468570856480000000
      TabOrder = 2
    end
  end
  object AdvPanel3: TAdvPanel
    Left = 0
    Top = 324
    Width = 1022
    Height = 35
    Align = alBottom
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 1
    UseDockManager = True
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
    Caption.Font.Name = 'Tahoma'
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
    object cxButton8: TcxButton
      Left = 933
      Top = 2
      Width = 87
      Height = 31
      Caption = '&Tutup'
      TabOrder = 0
      OnClick = cxButton8Click
      Align = alRight
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
    object cxButton7: TcxButton
      Left = 2
      Top = 2
      Width = 87
      Height = 31
      Caption = '&Export'
      TabOrder = 1
      OnClick = cxButton7Click
      Align = alLeft
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00CE8C6300C6845200D68C6300E78C
        6B00DE8C6B00DE8C6B00D68C6B00CE8C6B00AD6B4200A55A2900FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00C6845200EFCEBD00DEFFFF0084EF
        C600A5F7D600A5F7D6008CEFC600E7FFFF00DEA58400AD6B3900DEB59400D69C
        7300D6946300CE946300CE8C5A00CE8C5A00C67B5200EFB59C00EFF7EF0052BD
        84006BCE940073CE9C0052BD8400E7F7EF00DE9C7B00AD6B3900D6A57300FFF7
        EF00F7F7EF00F7EFE700F7EFE700F7E7DE00C6845200EFB59400F7F7EF00EFF7
        E700EFF7E700EFF7E700EFF7E700F7F7EF00D69C7B00AD6B4200DEA57B00FFF7
        EF00EFD6BD00FFFFFF00EFD6BD00FFFFFF00CE8C6300E7B59400E7A58400E7A5
        8400DEA57B00DEA57B00DE9C7B00DE9C7300D69C7300BD7B5200DEA57B00FFF7
        EF00EFD6BD00EFD6BD00EFD6BD00EFD6BD00CE8C6300EFB59C00DEA57B00DEA5
        7B00DEA57B00DE9C7B00DE9C7B00DE9C7300DE9C7300BD845A00DEAD8400FFF7
        EF00EFCEB500FFFFFF00EFD6BD00FFFFFF00CE845A00EFBDA500FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEA58400C67B5200E7AD8400FFF7
        F700EFCEB500EFCEB500EFCEB500EFCEB500C6845A00EFBD9C00FFFFFF00CE94
        6B00FFFFFF00FFFFFF00FFFFF700FFFFF700E7AD8C00C68C6300E7B58C00FFF7
        F700EFCEAD00FFFFFF00EFCEAD00FFFFFF00CE8C6300F7CEAD00FFFFFF00E7C6
        B500FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFBDA500CE8C5A00E7B58C00FFF7
        F700EFC6AD00EFC6AD00EFC6AD00EFC6AD00D6946B00D69C7B00D6947300D6A5
        8400CE8C6300CE8C6B00D69C7300D69C7300CE8C6300EFDECE00E7B59400FFF7
        F700EFC6A500FFFFFF00EFC6AD00FFFFFF00FFFFFF00FFFFFF00EFC6AD00FFFF
        FF00FFFFFF00FFFFFF00F7F7EF00CE8C5A00FF00FF00FF00FF00EFBD9400FFF7
        F700EFC6A500EFC6A500EFC6A500EFC6A500EFC6A500EFC6A500EFC6A500EFC6
        A500EFC6A500EFC6A500FFF7F700CE946300FF00FF00FF00FF00EFBD9C00FFF7
        F700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFF7F700D6946B00FF00FF00FF00FF00EFBD9C00FFF7
        F7009CD6A50094D6A50094D69C008CCE94008CCE940084CE8C0084C68C007BC6
        84007BC67B0073BD7B00FFF7F700D69C6B00FF00FF00FF00FF00EFC6A500FFF7
        F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
        F700FFF7F700FFF7F700FFF7F700DEA57300FF00FF00FF00FF00F7E7D600F7C6
        AD00EFBD9C00EFBD9C00EFBD9C00EFBD9400E7B59400E7B58C00E7B58C00E7AD
        8400E7AD8400DEAD7B00DEA57B00E7B59400FF00FF00FF00FF00}
      LookAndFeel.Kind = lfStandard
      LookAndFeel.SkinName = 'LondonLiquidSky'
    end
  end
  object AdvPanel2: TAdvPanel
    Left = 0
    Top = 0
    Width = 1022
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 2
    UseDockManager = True
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
    object lbljudul: TLabel
      Left = 15
      Top = 11
      Width = 196
      Height = 19
      Caption = 'Laporan  Detail CheckIn'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object AdvPanel4: TAdvPanel
    Left = 0
    Top = 92
    Width = 1022
    Height = 232
    Align = alClient
    BevelInner = bvRaised
    Color = clWhite
    TabOrder = 3
    UseDockManager = True
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
    object cxGrid1: TcxGrid
      Left = 2
      Top = 2
      Width = 1018
      Height = 228
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object cxGridLembur: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Filter.Active = True
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Appending = True
        OptionsView.GroupByBox = False
        object clNama: TcxGridDBColumn
          Caption = 'Nama'
          DataBinding.FieldName = 'nama'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.ReadOnly = True
          Options.Editing = False
          Width = 123
        end
        object clTanggal: TcxGridDBColumn
          Caption = 'Tanggal'
          DataBinding.FieldName = 'tanggal'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 88
        end
        object clcus_kode: TcxGridDBColumn
          Caption = 'Kode Customer'
          DataBinding.FieldName = 'cus_kode'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 88
        end
        object clcustomer: TcxGridDBColumn
          Caption = 'Customer'
          DataBinding.FieldName = 'customer'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 272
        end
        object clCabang: TcxGridDBColumn
          Caption = 'Cabang'
          DataBinding.FieldName = 'cabang'
          PropertiesClassName = 'TcxTextEditProperties'
          Options.Editing = False
          Width = 76
        end
        object clJam: TcxGridDBColumn
          Caption = 'Jam'
          DataBinding.FieldName = 'jam'
          Options.Editing = False
        end
        object cxGridLemburColumn1: TcxGridDBColumn
          Caption = 'Latitude'
          DataBinding.FieldName = 'latitude'
          Width = 100
        end
        object cxGridLemburColumn2: TcxGridDBColumn
          DataBinding.FieldName = 'Longitude'
          Width = 110
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGridLembur
      end
    end
  end
  object savedlg: TSaveDialog
    Left = 256
    Top = 80
  end
end
