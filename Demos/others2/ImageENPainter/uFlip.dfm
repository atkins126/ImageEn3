object FrmFlip: TFrmFlip
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Flip'
  ClientHeight = 322
  ClientWidth = 273
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 7
    Width = 30
    Height = 13
    Caption = 'Result'
  end
  object RadioGroup1: TRadioGroup
    Left = 15
    Top = 217
    Width = 120
    Height = 53
    Caption = 'Flip'
    Items.Strings = (
      'Horzontal'
      'Vertical')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object ImageEnView1: TImageEnView
    Left = 15
    Top = 24
    Width = 245
    Height = 187
    Cursor = 1779
    Background = clWhite
    ParentCtl3D = False
    ScrollBars = ssNone
    MouseInteract = [miZoom]
    AutoFit = True
    BackgroundStyle = iebsChessboard
    EnableAlphaChannel = True
    ImageEnVersion = '2.2.9'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object MergeAlpha1: TCheckBox
    Left = 147
    Top = 224
    Width = 91
    Height = 16
    Caption = 'Merge Alpha'
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 281
    Width = 273
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    ExplicitLeft = 6
    ExplicitTop = 306
    ExplicitWidth = 185
    object Button1: TButton
      Left = 7
      Top = 6
      Width = 70
      Height = 24
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 83
      Top = 6
      Width = 70
      Height = 24
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
