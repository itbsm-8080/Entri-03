inherited frmBrowseCustomer: TfrmBrowseCustomer
  Left = 230
  Top = 157
  Caption = 'Browse Customer'
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
      Visible = False
    end
    inherited cxButton4: TcxButton
      OnClick = cxButton4Click
    end
    inherited cxButton6: TcxButton
      Visible = False
    end
  end
  inherited AdvPanel2: TAdvPanel
    FullHeight = 0
    inherited Label1: TLabel
      Visible = False
    end
    inherited Label2: TLabel
      Visible = False
    end
    inherited startdate: TDateTimePicker
      Visible = False
    end
    inherited enddate: TDateTimePicker
      Visible = False
    end
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
      OnClick = UpdatestatusLocked1Click
    end
    object Open1: TMenuItem
      Caption = 'Open'
      OnClick = Open1Click
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
end
