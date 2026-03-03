inherited frmBrowseTandaTerima: TfrmBrowseTandaTerima
  Left = 477
  Top = 142
  Caption = 'Browse Tanda Terima'
  ClientWidth = 805
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited AdvPanel1: TAdvPanel
    Width = 805
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
      OnClick = cxButton4Click
    end
    inherited cxButton8: TcxButton
      Left = 716
    end
  end
  inherited AdvPanel2: TAdvPanel
    Width = 805
    FullHeight = 0
    inherited btnRefresh: TcxButton
      Left = 716
    end
  end
  inherited AdvPanel3: TAdvPanel
    Width = 805
    FullHeight = 0
    inherited cxGrid: TcxGrid
      Width = 801
      PopupMenu = PopupMenu1
      inherited cxGrdMaster: TcxGridDBTableView
        Styles.OnGetContentStyle = cxGrdMasterStylesGetContentStyle
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 273
    object UpdateStatusKembali1: TMenuItem
      Caption = 'Update Status Kembali'
      OnClick = UpdateStatusKembali1Click
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 216
    Top = 185
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clAqua
    end
    object cxStyle2: TcxStyle
    end
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    GraphicFrames = False
    PageBreaks = False
    SaveToFile = False
    UseIniSettings = True
    Left = 320
    Top = 185
  end
end
