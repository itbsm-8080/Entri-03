inherited frmBrowseSTBJ: TfrmBrowseSTBJ
  Left = 394
  Top = 139
  Caption = 'Browse STBJ'
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
      Left = 281
      OnClick = cxButton3Click
    end
    inherited cxButton4: TcxButton
      Width = 105
      OnClick = cxButton4Click
    end
    inherited cxButton7: TcxButton
      Left = 368
    end
    inherited cxButton6: TcxButton
      Left = 455
    end
  end
  inherited AdvPanel2: TAdvPanel
    FullHeight = 0
  end
  inherited AdvPanel3: TAdvPanel
    FullHeight = 0
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clAqua
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
end
