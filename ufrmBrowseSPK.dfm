inherited frmBrowseSPK: TfrmBrowseSPK
  Left = 231
  Top = 158
  Caption = 'Browse SPK'
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
    inherited cxButton6: TcxButton
      Visible = False
    end
  end
  inherited AdvPanel2: TAdvPanel
    FullHeight = 0
  end
  inherited AdvPanel3: TAdvPanel
    FullHeight = 407
    inherited cxGrid: TcxGrid
      PopupMenu = PopupMenu1
      inherited cxGrdMaster: TcxGridDBTableView
        OnDblClick = cxButton1Click
        OptionsView.Footer = True
        Styles.OnGetContentStyle = cxGrdMasterStylesGetContentStyle
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 160
    Top = 121
    object UpdatestatusLocked1: TMenuItem
      Caption = 'Locked'
    end
    object Open1: TMenuItem
      Caption = 'Open'
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 336
    Top = 161
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
  object cxStyleRepository2: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clAqua
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor]
      Color = clYellow
    end
  end
end
