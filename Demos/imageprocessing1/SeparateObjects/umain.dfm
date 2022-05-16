object MainForm: TMainForm
  Left = 195
  Top = 104
  Width = 965
  Height = 585
  Caption = 'SeparateObjects demo by HiComponents'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 957
    Height = 94
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 15
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Open...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 121
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Separate'
      TabOrder = 1
      OnClick = Button2Click
    end
    object CheckBox1: TCheckBox
      Left = 381
      Top = 8
      Width = 240
      Height = 21
      Caption = 'Only draw boxes around detected objects'
      TabOrder = 2
    end
    object CheckBox2: TCheckBox
      Left = 381
      Top = 31
      Width = 97
      Height = 17
      Caption = 'Quick process'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object CheckBox3: TCheckBox
      Left = 381
      Top = 50
      Width = 163
      Height = 17
      Caption = 'Merge Common Areas'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object CheckBox4: TCheckBox
      Left = 382
      Top = 71
      Width = 97
      Height = 17
      Caption = 'Deskew'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object ImageEnMView1: TImageEnMView
    Left = 0
    Top = 94
    Width = 180
    Height = 457
    ParentCtl3D = False
    ThumbWidth = 120
    ThumbHeight = 120
    HorizBorder = 14
    VertBorder = 14
    OnImageSelect = ImageEnMView1ImageSelect
    GridWidth = 1
    SelectionWidth = 3
    SelectionColor = clRed
    Style = iemsFlat
    ThumbnailsBorderColor = clBlack
    ThumbnailsBackgroundStyle = iebsSoftShadow
    Align = alLeft
    TabOrder = 1
  end
  object ImageEnView1: TImageEnView
    Left = 180
    Top = 94
    Width = 777
    Height = 457
    ParentCtl3D = False
    MouseInteract = [miSelectMagicWand]
    SelectionBase = iesbBitmap
    ImageEnVersion = '2.2.5'
    Align = alClient
    TabOrder = 2
  end
end
