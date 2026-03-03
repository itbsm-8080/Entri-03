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
