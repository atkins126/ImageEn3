object fmain: Tfmain
  Left = 255
  Top = 89
  Width = 798
  Height = 598
  Caption = 'Navigator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 0
    Width = 790
    Height = 544
    ParentCtl3D = False
    BorderStyle = bsNone
    MouseInteract = [miZoom, miScroll, miMovingScroll]
    ImageEnVersion = '3.0.2'
    EnableInteractionHints = True
    FlatScrollBars = True
    Align = alClient
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 134
    Top = 43
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open...'
        OnClick = Open1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
  end
end
