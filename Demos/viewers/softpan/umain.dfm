object Form1: TForm1
  Left = 294
  Top = 110
  Width = 870
  Height = 500
  Caption = 'Soft pan test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 0
    Width = 862
    Height = 446
    ParentCtl3D = False
    MouseInteract = [miMovingScroll]
    ImageEnVersion = '3.0.0'
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 64
    Top = 40
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open...'
        OnClick = Open1Click
      end
    end
  end
end
