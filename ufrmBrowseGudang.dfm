inherited frmBrowseGudang: TfrmBrowseGudang
  Left = 304
  Top = 157
  Caption = 'Browse Gudang'
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
      inherited cxGrdMaster: TcxGridDBTableView
        OnDblClick = cxButton1Click
      end
    end
  end
end
