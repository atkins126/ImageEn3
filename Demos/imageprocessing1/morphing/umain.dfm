object MainForm: TMainForm
  Left = 216
  Top = 78
  Width = 800
  Height = 600
  Caption = 'Morphing demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 13
    Width = 34
    Height = 13
    Caption = 'Source'
  end
  object Label2: TLabel
    Left = 292
    Top = 11
    Width = 31
    Height = 13
    Caption = 'Target'
  end
  object Label3: TLabel
    Left = 129
    Top = 311
    Width = 68
    Height = 13
    Caption = 'Frames Count:'
  end
  object AddLinesButton: TSpeedButton
    Left = 571
    Top = 36
    Width = 73
    Height = 22
    GroupIndex = 1
    Caption = 'Add lines'
    OnClick = AddLinesButtonClick
  end
  object EditLinesButton: TSpeedButton
    Left = 572
    Top = 65
    Width = 73
    Height = 22
    GroupIndex = 1
    Caption = 'Edit Lines'
    OnClick = EditLinesButtonClick
  end
  object Label4: TLabel
    Left = 494
    Top = 299
    Width = 32
    Height = 13
    Caption = 'Frame:'
  end
  object SourceView: TImageEnVect
    Left = 13
    Top = 38
    Width = 260
    Height = 253
    ParentCtl3D = False
    AutoFit = True
    ImageEnVersion = '3.0.1'
    EnableInteractionHints = True
    TabOrder = 0
    OnKeyDown = SourceViewKeyDown
    OnSelectObject = SourceViewSelectObject
    OnNewObject = SourceViewNewObject
  end
  object ImageEnMView1: TImageEnMView
    Left = 14
    Top = 348
    Width = 505
    Height = 204
    ParentCtl3D = False
    ThumbWidth = 130
    ThumbHeight = 175
    SelectionWidth = 3
    SelectionColor = clRed
    Style = iemsFlat
    ThumbnailsBorderColor = clBlack
    ImageEnVersion = '3.0.1'
    TabOrder = 1
  end
  object TargetView: TImageEnVect
    Left = 291
    Top = 37
    Width = 260
    Height = 253
    ParentCtl3D = False
    AutoFit = True
    ImageEnVersion = '3.0.1'
    EnableInteractionHints = True
    TabOrder = 2
    OnKeyDown = SourceViewKeyDown
    OnSelectObject = TargetViewSelectObject
    OnNewObject = TargetViewNewObject
  end
  object LoadSourceButton: TButton
    Left = 56
    Top = 11
    Width = 31
    Height = 17
    Hint = 'Load Source Image'
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = LoadSourceButtonClick
  end
  object LoadTargetButton: TButton
    Left = 329
    Top = 10
    Width = 31
    Height = 17
    Hint = 'Load Target Image'
    Caption = '...'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = LoadTargetButtonClick
  end
  object SaveLinesButton: TButton
    Left = 572
    Top = 113
    Width = 75
    Height = 25
    Caption = 'Save lines'
    TabOrder = 5
    OnClick = SaveLinesButtonClick
  end
  object CreateSequenceButton: TButton
    Left = 12
    Top = 306
    Width = 103
    Height = 25
    Caption = 'Create sequence'
    TabOrder = 6
    OnClick = CreateSequenceButtonClick
  end
  object Edit1: TEdit
    Left = 205
    Top = 308
    Width = 39
    Height = 21
    TabOrder = 7
    Text = '16'
  end
  object FramesCount: TUpDown
    Left = 244
    Top = 308
    Width = 16
    Height = 21
    Associate = Edit1
    Min = 2
    Position = 16
    TabOrder = 8
  end
  object ImageEnView1: TImageEnView
    Left = 532
    Top = 316
    Width = 253
    Height = 242
    ParentCtl3D = False
    AutoFit = True
    ImageEnVersion = '3.0.1'
    EnableInteractionHints = True
    TabOrder = 9
  end
  object CurrentFrame: TScrollBar
    Left = 533
    Top = 298
    Width = 253
    Height = 17
    PageSize = 0
    TabOrder = 10
    OnChange = CurrentFrameChange
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 538
    Top = 329
  end
  object XPManifest1: TXPManifest
    Left = 667
    Top = 94
  end
end
