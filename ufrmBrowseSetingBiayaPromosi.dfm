inherited frmBrowseSetingBiayaPromosi: TfrmBrowseSetingBiayaPromosi
  Left = 370
  Top = 143
  Caption = 'Browse Setting Biaya Promosi'
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
    inherited cxButton4: TcxButton
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
    FullHeight = 0
    inherited cxGrid: TcxGrid
      inherited cxGrdMaster: TcxGridDBTableView
        OptionsView.Footer = True
      end
    end
  end
end
