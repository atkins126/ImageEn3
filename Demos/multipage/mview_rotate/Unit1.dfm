object MainForm: TMainForm
  Left = 192
  Top = 110
  Width = 829
  Height = 272
  Caption = 'TImageEnMView image processing demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 17
    Top = 194
    Width = 99
    Height = 33
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Rotate'
    OnClick = SpeedButton1Click
  end
  object ImageEnMView1: TImageEnMView
    Left = 11
    Top = 19
    Width = 779
    Height = 164
    ParentCtl3D = False
    SelectionWidth = 3
    SelectionColor = clRed
    ThumbnailsBorderColor = clBlack
    ImageEnVersion = '2.3.1'
    TabOrder = 0
  end
end
