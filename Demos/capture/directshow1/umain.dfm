object fmain: Tfmain
  Left = 197
  Top = 162
  Width = 649
  Height = 544
  Caption = 'Sample Grabber'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 0
    Width = 641
    Height = 490
    ParentCtl3D = False
    ImageEnVersion = '2.1.9'
    OnDShowNewFrame = ImageEnView1DShowNewFrame
    OnDShowEvent = ImageEnView1DShowEvent
    Align = alClient
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 120
    Top = 256
    object File1: TMenuItem
      Caption = '&File'
      object SelectInput1: TMenuItem
        Caption = 'Select Input'
        OnClick = Input1Click
      end
      object SelectOutput1: TMenuItem
        Caption = 'Select Output'
        OnClick = Output1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Saveframe1: TMenuItem
        Caption = 'Save frame...'
        OnClick = Saveframe1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = '&Print...'
        OnClick = Print1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
    object View1: TMenuItem
      Caption = '&View'
      object Controls2: TMenuItem
        Caption = '&Controls'
        OnClick = Controls2Click
      end
      object ools2: TMenuItem
        Caption = '&Tools'
        OnClick = ools2Click
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 464
    Top = 40
  end
end
