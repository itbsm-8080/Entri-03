inherited frmBrowseFeeCustomer: TfrmBrowseFeeCustomer
  Left = 304
  Top = 157
  Caption = 'Browse Fee Customer'
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
  end
  inherited AdvPanel3: TAdvPanel
    FullHeight = 407
    inherited cxGrid: TcxGrid
      inherited cxGrdMaster: TcxGridDBTableView
        OnDblClick = cxButton1Click
      end
    end
  end
end
