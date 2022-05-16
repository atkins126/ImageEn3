object MainForm: TMainForm
  Left = 244
  Top = 112
  Width = 870
  Height = 640
  Caption = 'Rotate layers demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 0
    Width = 862
    Height = 586
    ParentCtl3D = False
    MouseInteract = [miMoveLayers, miResizeLayers]
    EnableAlphaChannel = True
    ImageEnVersion = '2.3.1'
    Align = alClient
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 80
    Top = 87
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open...'
        OnClick = Open1Click
      end
      object Save1: TMenuItem
        Caption = '&Save..'
        OnClick = Save1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object Layers1: TMenuItem
      Caption = '&Layers'
      object Add1: TMenuItem
        Caption = '&Add'
        OnClick = Add1Click
      end
      object Rotate1: TMenuItem
        Caption = 'Rotate'
        GroupIndex = 1
        RadioItem = True
        OnClick = Rotate1Click
      end
      object MoveResize1: TMenuItem
        Caption = 'Move/Resize'
        Checked = True
        GroupIndex = 1
        RadioItem = True
        OnClick = MoveResize1Click
      end
    end
    object View1: TMenuItem
      Caption = '&View'
      object Fit1: TMenuItem
        Caption = '&Fit'
        OnClick = Fit1Click
      end
      object Actualsize1: TMenuItem
        Caption = '&Actual size'
        OnClick = Actualsize1Click
      end
    end
  end
end
