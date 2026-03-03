inherited frmBrowseBarang: TfrmBrowseBarang
  Top = 147
  Caption = 'Browse Barang'
  OldCreateOrder = True
  WindowState = wsNormal
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
      Width = 114
      Caption = '&Cetak Barcode'
      OnClick = cxButton3Click
    end
    inherited cxButton4: TcxButton
      OnClick = cxButton4Click
    end
    inherited cxButton7: TcxButton
      Left = 377
    end
    inherited cxButton6: TcxButton
      Left = 464
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
        OnDblClick = cxButton1Click
      end
    end
  end
end
