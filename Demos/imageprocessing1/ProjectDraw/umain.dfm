object MainForm: TMainForm
  Left = 26
  Top = 38
  Width = 1185
  Height = 710
  Caption = 'ProjectDraw demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 73
    Width = 1177
    Height = 608
    ParentCtl3D = False
    ImageEnVersion = '3.0.6a'
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1177
    Height = 73
    Align = alTop
    TabOrder = 1
    object Test1Button: TSpeedButton
      Left = 24
      Top = 16
      Width = 81
      Height = 33
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Test1'
      OnClick = Test1ButtonClick
    end
    object Test2Button: TSpeedButton
      Left = 136
      Top = 16
      Width = 81
      Height = 33
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Test2'
      OnClick = Test2ButtonClick
    end
  end
end
