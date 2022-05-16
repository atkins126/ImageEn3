object LosslessTransform: TLosslessTransform
  Left = 232
  Top = 170
  Width = 659
  Height = 478
  Caption = 'Lossless Transform'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 16
    Top = 12
    Width = 36
    Height = 13
    Caption = 'Original'
  end
  object Label5: TLabel
    Left = 290
    Top = 10
    Width = 30
    Height = 13
    Caption = 'Result'
  end
  object TransformationRadioGroup: TRadioGroup
    Left = 14
    Top = 236
    Width = 327
    Height = 197
    Caption = 'Transformation'
    ItemIndex = 6
    Items.Strings = (
      'None: No transformation.'
      'Cut: Cuts out part of the image.'
      'HorizFlip: Mirror image horizontally (left-right).'
      'VertFlip: Mirror image vertically (top-bottom).'
      'Transpose: Transpose image (across UL-to-LR axis).'
      'Transverse: Transverse transpose (across UR-to-LL axis).'
      'Rotate90: Rotate image 90 degrees clockwise.'
      'Rotate180: Rotate image 180 degrees.'
      'Rotate270: Rotate image 270 degrees clockwise (or 90 ccw).')
    TabOrder = 0
  end
  object ImageEnView1: TImageEnView
    Left = 14
    Top = 28
    Width = 263
    Height = 200
    Background = clWhite
    ParentCtl3D = False
    ScrollBars = ssNone
    AutoFit = True
    BackgroundStyle = iebsChessboard
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnMouseDown = ImageEnView1MouseDown
    OnMouseMove = ImageEnView1MouseMove
  end
  object ImageEnView2: TImageEnView
    Left = 290
    Top = 28
    Width = 263
    Height = 200
    Background = clWhite
    ParentCtl3D = False
    ScrollBars = ssNone
    AutoFit = True
    BackgroundStyle = iebsChessboard
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnMouseDown = ImageEnView2MouseDown
    OnMouseMove = ImageEnView2MouseMove
  end
  object Button1: TButton
    Left = 562
    Top = 86
    Width = 69
    Height = 25
    Hint = 'Ok'
    Caption = 'OK'
    Default = True
    ModalResult = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object Button2: TButton
    Left = 562
    Top = 116
    Width = 69
    Height = 25
    Hint = 'Cancel'
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object PeviewButton: TButton
    Left = 562
    Top = 28
    Width = 69
    Height = 25
    Hint = 'Transform'
    Caption = 'Transform'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = PeviewButtonClick
  end
  object ViewRadioGroup: TRadioGroup
    Left = 350
    Top = 315
    Width = 141
    Height = 53
    Hint = 'View'
    Caption = 'View'
    ItemIndex = 1
    Items.Strings = (
      'Zoom'
      'Auto Fit')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = ViewRadioGroupClick
  end
  object CopyMarkersRadioGroup: TRadioGroup
    Left = 350
    Top = 236
    Width = 281
    Height = 73
    Caption = 'Copy Markers'
    ItemIndex = 2
    Items.Strings = (
      'CopyNone: Copy no extra markers from source file.'
      'CopyComments: Copy only comment markers.'
      'CopyAll: Copy all extra markers.')
    TabOrder = 7
  end
  object CheckBoxGrayScale: TCheckBox
    Left = 496
    Top = 318
    Width = 151
    Height = 17
    Caption = 'Force grayscale output'
    TabOrder = 8
  end
  object ResetBtn: TButton
    Left = 562
    Top = 57
    Width = 69
    Height = 25
    Hint = 'Reset to original image'
    Caption = 'Reset'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnClick = ResetBtnClick
  end
  object Memo1: TMemo
    Left = 352
    Top = 374
    Width = 271
    Height = 61
    Color = 16244694
    Lines.Strings = (
      'Lossless transform requires saving the image to a disk '
      'file.  This procedure will create a backup file located in '
      'the source folder with "_LosslessTransform" '
      'appended to the filename.')
    TabOrder = 10
  end
end
