object Form1: TForm1
  Left = 164
  Top = 159
  Width = 1142
  Height = 656
  Caption = 'VMR Capture'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1134
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 11
      Width = 410
      Height = 16
      Caption = 
        'Rendering a camera on overlay. Capture frames and save an AVI fi' +
        'le.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 578
    Width = 1134
    Height = 49
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 11
      Top = 14
      Width = 62
      Height = 13
      Caption = 'Zoom (100%)'
    end
    object TrackBar1: TTrackBar
      Left = 83
      Top = 8
      Width = 150
      Height = 29
      Max = 3000
      Min = 1
      Frequency = 100
      Position = 100
      TabOrder = 0
      OnChange = TrackBar1Change
    end
  end
  object ImageEnView1: TImageEnView
    Left = 180
    Top = 41
    Width = 585
    Height = 537
    ParentCtl3D = False
    ImageEnVersion = '3.0.6a'
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 2
  end
  object Panel3: TPanel
    Left = 765
    Top = 41
    Width = 369
    Height = 537
    Align = alRight
    TabOrder = 3
    object SpeedButton1: TSpeedButton
      Left = 120
      Top = 221
      Width = 129
      Height = 44
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Show Video'
      OnClick = SpeedButton1Click
    end
    object Label4: TLabel
      Left = 37
      Top = 343
      Width = 80
      Height = 13
      Caption = 'Output file name:'
    end
    object GroupBox1: TGroupBox
      Left = 9
      Top = 8
      Width = 354
      Height = 201
      Caption = ' Source '
      TabOrder = 0
      object Label3: TLabel
        Left = 9
        Top = 24
        Width = 54
        Height = 13
        Caption = 'Video Input'
      end
      object Label5: TLabel
        Left = 8
        Top = 56
        Width = 37
        Height = 13
        Caption = 'Formats'
      end
      object Label8: TLabel
        Left = 8
        Top = 126
        Width = 64
        Height = 13
        Caption = 'Video Source'
      end
      object Label9: TLabel
        Left = 5
        Top = 160
        Width = 69
        Height = 13
        Caption = 'Tuner channel'
      end
      object Label10: TLabel
        Left = 145
        Top = 164
        Width = 3
        Height = 13
        Caption = '-'
      end
      object ComboBox1: TComboBox
        Left = 80
        Top = 21
        Width = 240
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox1Change
      end
      object ListBox1: TListBox
        Left = 80
        Top = 53
        Width = 265
        Height = 63
        ItemHeight = 13
        TabOrder = 1
      end
      object ComboBox2: TComboBox
        Left = 80
        Top = 123
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = ComboBox2Change
      end
      object Edit4: TEdit
        Left = 323
        Top = 21
        Width = 22
        Height = 21
        TabOrder = 3
        Text = '0'
      end
      object Edit3: TEdit
        Left = 80
        Top = 156
        Width = 41
        Height = 21
        TabOrder = 4
        Text = '0'
        OnChange = Edit3Change
      end
      object UpDown1: TUpDown
        Left = 121
        Top = 156
        Width = 16
        Height = 21
        Associate = Edit3
        Max = 1000
        TabOrder = 5
      end
    end
    object Button1: TButton
      Left = 148
      Top = 285
      Width = 75
      Height = 25
      Caption = 'Get Frame'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 129
      Top = 339
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'c:\test.avi'
    end
  end
  object ImageEnMView1: TImageEnMView
    Left = 0
    Top = 41
    Width = 180
    Height = 537
    ParentCtl3D = False
    OnImageSelect = ImageEnMView1ImageSelect
    GridWidth = 1
    SelectionWidth = 3
    SelectionColor = clRed
    ThumbnailsBorderColor = clBlack
    ImageEnVersion = '3.0.6a'
    Align = alLeft
    TabOrder = 4
  end
end
