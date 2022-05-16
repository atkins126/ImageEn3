object MainForm: TMainForm
  Left = 192
  Top = 135
  Width = 863
  Height = 545
  Caption = 'TWain load/save properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 156
    Height = 516
    Align = alLeft
    TabOrder = 0
    object Button1: TButton
      Left = 24
      Top = 36
      Width = 113
      Height = 25
      Caption = 'Set TWain settings'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button4: TButton
      Left = 40
      Top = 116
      Width = 75
      Height = 25
      Caption = 'Acquire'
      TabOrder = 1
      OnClick = Button4Click
    end
  end
  object ImageEnView1: TImageEnView
    Left = 156
    Top = 0
    Width = 699
    Height = 516
    ParentCtl3D = False
    ImageEnVersion = '3.0.3'
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 1
  end
end
