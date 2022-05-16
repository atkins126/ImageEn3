object Form1: TForm1
  Left = 194
  Top = 110
  Width = 870
  Height = 500
  Caption = 'RedEye removal example'
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
    MouseInteract = [miSelectCircle]
    ImageEnVersion = '2.2.6'
    Align = alClient
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 114
    Top = 61
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open...'
        OnClick = Open1Click
      end
    end
    object RemoveRedEyes1: TMenuItem
      Caption = 'Remove Red Eyes'
      OnClick = RemoveRedEyes1Click
    end
  end
end
