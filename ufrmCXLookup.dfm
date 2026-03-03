object frmCXLookup: TfrmCXLookup
  Left = 457
  Top = 283
  Width = 737
  Height = 450
  BorderIcons = [biMaximize]
  Caption = 'frmCXLookup'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cxTreeData: TcxDBTreeList
    Left = 8
    Top = 64
    Width = 309
    Height = 249
    Bands = <
      item
      end>
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    OptionsBehavior.ExpandOnIncSearch = True
    OptionsCustomizing.DynamicSizing = True
    OptionsCustomizing.NodeSizing = True
    OptionsView.DynamicIndent = True
    OptionsView.ExtPaintStyle = True
    OptionsView.Indicator = True
    OptionsView.PaintStyle = tlpsCategorized
    OptionsView.SimpleCustomizeBox = True
    PopupMenus.ColumnHeaderMenu.UseBuiltInMenu = True
    PopupMenus.FooterMenu.UseBuiltInMenu = True
    PopupMenus.GroupFooterMenu.UseBuiltInMenu = True
    RootValue = -1
    Styles.ContentEven = styleInfoBlk
    TabOrder = 3
    OnCollapsed = cxTreeDataCollapsed
    OnExpanded = cxTreeDataExpanded
  end
  object pnPeriode: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    Ctl3D = False
    PanelStyle.Active = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    DesignSize = (
      721
      35)
    Height = 35
    Width = 721
    object btnRefresh: TcxButton
      Left = 639
      Top = 2
      Width = 80
      Height = 31
      Caption = '&Refresh'
      TabOrder = 0
      OnClick = btnRefreshClick
      Align = alRight
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000202
        0103000000000000000001010001030303050000000000000000000000000000
        0000020202040202010300000000000000000000000000000000000000000000
        00000A0B0A140404030700000000000000000F0F0E1C22241F4022231E3F1010
        0F1E000000000000000001010102000000000000000000000000000000002B2E
        265079855FCF000000000F100E1D5E684BA390A070F498AA75FF98A975FF92A1
        71F6687253B420221D3C0000000000000001000000000000000000000000727C
        5DC885916AE61F201B3988976AE698A975FF98A875FF7E8A63D7808D64D996A7
        75FE97A875FF96A772FB3A3E336A00000000000000010000000000000000666E
        55B590A070F489976BE997A875FF5960499C0F0F0E1D0000000002020204191A
        1730626B50AB97A775FF98A974FF27292247000000000202010300000000636A
        53B095A674FC93A273FB78845FCE1E1F1C3921211F3F0707060D000000000000
        0000000000005F674DA496A674FD79865FCF0202020401010102000000006E77
        5BC299AC74FF97A975FF97A875FF99AB74FF5E664DA40505050A000000010202
        0204000001010C0C0B1796A672FB99AC74FF2326204200000000000000001B1C
        19342728244A2A2C275031332D5C2B2D27500000000000000000000000000000
        00000000000000000000222320412D2F29551111102000000000000000001A1A
        19322728234910100F1E00000000000000000000000000000000000000000000
        00000A0A09130B0B0B160404040802020204000001010000000000000000575F
        47999AAC73FF76825DCA000000000404040801010001000000010707070E626B
        50AC97A874FF8F9E71F58D9D70F293A372F832342E5E00000000000000001B1C
        183293A472F993A372F931352A590000000001010102010101021E1F1C395156
        46934B5040868B9A6BEA95A475FE98A974FF34362F6100000000020202040000
        00005961489B97A775FF90A06FF3373A2F630303020500000000000000000000
        00004348387695A473FB94A473FB95A674FC33352F6000000000010100010000
        00010606060C6D7955BA97A875FF97A875FF7E8B63D7626A50AB6B7456B98D9D
        6DEE98A974FF879569E43E43336D97A974FF3639316500000000000000000000
        00000000000002020103464C3A7C859368E298A975FF99AB74FF99AB74FF94A5
        73FA616B4EA90F0F0E1C1A1B1933839166DF0F100F1E00000001000000000000
        00000000000000000000000000000707060D23241F4131332D5C292B254C1011
        0F1F000000000000000014141326141513270000000001010001000000000000
        0000000000000101000103030305000000000000000000000000000000000000
        0000010102030202010300000000000000000101010200000000}
    end
    object cxLabel1: TcxLabel
      Left = 263
      Top = 9
      Anchors = [akTop, akRight]
      Caption = 'Filter Periode : '
      Properties.Alignment.Vert = taVCenter
      AnchorY = 18
    end
    object StartDate: TcxDateEdit
      Left = 364
      Top = 7
      Hint = 'Tanggal Awal'
      Anchors = [akTop, akRight]
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.InputKind = ikMask
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.UseLeftAlignmentOnEditing = False
      Style.LookAndFeel.NativeStyle = False
      Style.ButtonStyle = btsUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 2
      Width = 100
    end
    object EndDate: TcxDateEdit
      Left = 520
      Top = 7
      Hint = 'Tanggal Awal'
      Anchors = [akTop, akRight]
      Properties.Alignment.Horz = taCenter
      Properties.Alignment.Vert = taVCenter
      Properties.InputKind = ikMask
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.UseLeftAlignmentOnEditing = False
      Style.LookAndFeel.NativeStyle = False
      Style.ButtonStyle = btsUltraFlat
      StyleDisabled.LookAndFeel.NativeStyle = False
      StyleFocused.LookAndFeel.NativeStyle = False
      StyleHot.LookAndFeel.NativeStyle = False
      TabOrder = 3
      Width = 100
    end
    object cxLabel2: TcxLabel
      Left = 484
      Top = 9
      Anchors = [akTop, akRight]
      Caption = 's/d'
      Properties.Alignment.Vert = taVCenter
      AnchorY = 18
    end
  end
  object sdBoxButton: TcxGroupBox
    Left = 0
    Top = 374
    Align = alBottom
    Ctl3D = False
    PanelStyle.Active = True
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 1
    Height = 38
    Width = 721
    object btnOK: TcxButton
      Left = 564
      Top = 2
      Width = 80
      Height = 34
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOKClick
      Align = alRight
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000101000102020103000000000000000000000000000000000000
        0000000000000202010301010001000000000000000000000000000000000000
        00000101000100000000000000001E211B3A48503884606A4CB1606A4CB14850
        38841E211B3A0000000000000000010100010000000000000000000000000000
        0000000000000A0B09145F6B47AC90A566FF91A667FF91A667FF90A566FF90A5
        66FF90A566FF5F6B47AC0A0B0914000000000000000000000000010101020000
        00000B0B0A15768755D38FA466FF8DA068FA899D61FA8A9D61FB8EA168FB8CA0
        66FA8C9F66FA90A466FF768755D30B0B0A150000000001010001010102030000
        0000616D49AF8FA465FF8C9F67F8889D5FFEA3B483FFA2B281FE889D5FFE91A4
        69FF8EA267FE8A9E65F890A466FF616D49AF0000000001010103000000001E20
        1A3990A566FF8DA067FA899E60FD98AA73FFF3F5EFFEF1F3ECFF94A76EFF8BA0
        64FE90A469FF8EA266FD8C9F66FA90A566FF1D1F193700000000000000004B53
        3B8A8FA566FE8A9E64F993A66EFEE8EBE0FEFFFFFFFFFFFFFFFFE2E7D8FF8EA2
        65FF8DA166FE8FA368FE8B9E65F98EA466FE4A523A8800000000000000005E68
        4BAE90A567FE84995BFAD2D9C1FFFFFFFFFFB2BF96FFBFCAA8FFFFFFFFFFD2DA
        C2FF889D5EFF90A468FF8CA066FA8EA465FE5F684BAF00000000000000005E68
        4BAE8FA566FE889C61FAA3B483FFB7C49DFF899E5FFF899E5EFFD4DCC5FFFFFF
        FFFFC3CDADFF869C5BFF8DA067FA8FA466FE5F684BAF00000000000000004B53
        3B8A8EA465FE8C9F66F98BA063FE889E5FFE91A56AFF8EA266FF8FA366FFE5E9
        DBFFFEFEFEFEB2C097FE879B5FF990A567FE4A523A8800000000000000001E20
        1A3990A566FF8B9F65FA8FA367FD91A569FF8EA267FE90A469FF8CA062FF96A8
        71FEF4F6F0FFF5F6F2FD8DA168FA8FA464FF1D1F193700000000010102030000
        0000606C48AE90A466FF8A9E65F88FA367FE8FA468FF8EA267FE90A369FE899E
        5FFFA3B483FEA4B488F88DA262FF616C48AE0000000001010103010101020000
        00000B0B0A15768655D290A466FF8C9F66FA8CA066FA8DA066FB8DA066FB8EA1
        68FA889C61FA8AA05FFF778655D20B0B0A150000000001010001000000000000
        0000000000000A0B09145F6B46AB90A566FF90A566FF90A666FF90A666FF90A5
        66FF90A667FF5F6B48AB0A0B0914000000000000000000000000000000000000
        000001010001000000000000000020221C3C485039855F684BAF5F684BAF4850
        398520221C3C0000000000000000010100010000000000000000000000000000
        0000000000000101010200000101000000000000000000000000000000000000
        0000000000000000010101010102000000000000000000000000}
    end
    object btnTutup: TcxButton
      Left = 644
      Top = 2
      Width = 75
      Height = 34
      Caption = '&Close'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnTutupClick
      Align = alRight
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000010101010203000000000000000000000000000000000000
        0000000000000101020300000101000000000000000000000000000000000000
        0000000001010000000000000000171A263A2B3763843B4A84B13B4A84B12B37
        6384171A263A0000000000000000000001010000000000000000000000000000
        00000000000009090C1433458BAC4161DDFF4061DDFF4061DDFF4061DDFF4061
        DDFF4161DDFF33458BAC09090C14000000000000000000000000010101020000
        0000090A0C153751B3D3385AD9FF3A59CEF94361D3FB4462D2FA4462D2FA4361
        D3FB3A59CEF9385AD9FF3751B3D3090A0C150000000000000101020201030000
        000033468DAF385AD9FF7A8CD1EBA4B1DFEF3A59D1FA4362D7FF4362D7FF3A59
        D1FAA4B1DFEF7A8CD1EB385AD9FF33468DAF0000000001010203000000001719
        25394161DDFF3958CFFA8A9BD7ECFAFAFAFAA8B3E0F03758D2FC3758D2FCA8B4
        E0F0FAFAFAFA8A9BD7EC3958CFFA4161DDFF1619243700000000000000002D39
        688A4060DBFE4462D2FA3455D2FC91A0D9EDF9F9F9F99FACDDEF9FACDDEFF9F9
        F9F991A0D9ED3455D2FC4462D2FA4060DBFE2C39668800000000000000003A49
        81AE4061DBFE4261D1F94463D6FE3657D2FC97A5DAEDFAFAFAFAF9F9F9F997A5
        DAED3657D2FC4463D6FE4261D1F94061DBFE3A4982AF00000000000000003A49
        81AE4061DBFE4261D1F94564D7FE3456D2FC8D9DD9EDFAFAFAFAFBFBFBFB8D9D
        D9ED3456D2FC4564D7FE4261D1F94061DBFE3A4982AF00000000000000002D39
        688A3F60DBFE4562D2FA3454D2FD8899D8EEFBFBFBFBA6B2DFEFA6B2DFEFFBFB
        FBFB8899D8EE3454D2FD4562D2FA3F60DBFE2C39668800000000000000001719
        25394161DDFF3A59CFFA8697D7EDFBFBFBFBB0BAE3F13959D2FB3959D2FBB0BA
        E3F1FBFBFBFB8697D7ED3A59CFFA4161DDFF1619243700000000020201030000
        000033468DAE3759D8FF8293D2EBADB7E0EE3C5BD1F94261D7FF4261D7FF3C5B
        D1F9ADB7E0EE8293D2EB3759D8FF33468DAE0000000001010203010101020000
        0000090A0C153751B2D2385AD9FF3B59CDF84360D3FB4462D2FA4462D2FA4360
        D3FB3B59CDF8385AD9FF3751B2D2090A0C150000000000000101000000000000
        00000000000009090C1432448AAB4061DCFF4061DDFF4061DDFF4061DDFF4061
        DDFF4061DCFF32448AAB09090C14000000000000000000000000000000000000
        0000000001010000000000000000181B273C2B3764853A4982AF3A4982AF2B37
        6485181B273C0000000000000000000001010000000000000000000000000000
        0000000000000101010201010001000000000000000000000000000000000000
        0000000000000101000101010102000000000000000000000000}
    end
    object cxMemoGrid: TcxMemo
      Left = 2
      Top = 2
      Align = alLeft
      Lines.Strings = (
        'Gunakan CLTR + Click untuk memilih beberapa baris sekaligus'
        
          'Klik Kanan untuk mengakses Opsi Check, Enter untuk selesai memil' +
          'ih')
      ParentFont = False
      Properties.ReadOnly = True
      Style.BorderStyle = ebsNone
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clInactiveCaptionText
      Style.Font.Height = -9
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.Shadow = False
      Style.TransparentBorder = True
      Style.IsFontAssigned = True
      TabOrder = 2
      Height = 34
      Width = 319
    end
  end
  object cxGrid: TcxGrid
    Left = 344
    Top = 64
    Width = 328
    Height = 205
    BorderStyle = cxcbsNone
    PopupMenu = pmSelect
    TabOrder = 2
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.NativeStyle = False
    object cxGrdMain: TcxGridDBTableView
      OnKeyPress = cxGrdMainKeyPress
      OnCellDblClick = cxGrdMainCellDblClick
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.AutoDataSetFilter = True
      DataController.Filter.TranslateBetween = True
      DataController.Filter.TranslateIn = True
      DataController.Filter.TranslateLike = True
      DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsBehavior.PostponedSynchronization = False
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsView.CellAutoHeight = True
      Styles.ContentEven = styleInfoBlk
      object cxGrdMainColumn1: TcxGridDBColumn
        PropertiesClassName = 'TcxCheckBoxProperties'
      end
    end
    object cxGrdDetail: TcxGridDBTableView
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
    end
    object lvMaster: TcxGridLevel
      Caption = 'Master Data'
      GridView = cxGrdMain
    end
  end
  object pmSelect: TPopupMenu
    Left = 280
    Top = 192
    object CheckSelected1: TMenuItem
      Caption = 'Check Selected'
      OnClick = CheckSelected1Click
    end
    object UnCheckSelected1: TMenuItem
      Caption = 'Uncheck Selected'
      OnClick = UnCheckSelected1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CheckAll1: TMenuItem
      Caption = 'Check All'
      OnClick = CheckAll1Click
    end
    object UncheckAll1: TMenuItem
      Caption = 'Uncheck All'
      OnClick = UncheckAll1Click
    end
  end
  object cxBrowseStyle: TcxStyleRepository
    Left = 139
    Top = 129
    PixelsPerInch = 96
    object styleRowMoney: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object styleInfoBlk: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
    object styleSkyBlue: TcxStyle
      AssignedValues = [svColor]
      Color = clSkyBlue
    end
    object styleSilver: TcxStyle
      AssignedValues = [svColor]
      Color = clSilver
    end
  end
end
