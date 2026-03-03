inherited frmBrowsePO: TfrmBrowsePO
  Left = 394
  Top = 139
  Caption = 'Browse PO'
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
      Caption = '&Update Status'
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
  object frxDotMatrixExport1: TfrxDotMatrixExport
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 304
    Top = 137
  end
end
