object Form1: TForm1
  Left = 73
  Top = 42
  Width = 1074
  Height = 621
  Caption = 'VMR DVD'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1066
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 11
      Width = 554
      Height = 16
      Caption = 
        'Playing a DVD on overlay (if you are inside Delphi IDE, please d' +
        'isable Integrated Debugging)'
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
    Top = 518
    Width = 1066
    Height = 49
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 11
      Top = 16
      Width = 62
      Height = 13
      Caption = 'Zoom (100%)'
    end
    object Label3: TLabel
      Left = 961
      Top = 17
      Width = 57
      Height = 13
      Caption = '00:00:00:00'
    end
    object Label4: TLabel
      Left = 511
      Top = 16
      Width = 53
      Height = 13
      Caption = 'Select Title'
    end
    object Label5: TLabel
      Left = 641
      Top = 16
      Width = 70
      Height = 13
      Caption = 'Select Chapter'
    end
    object Label6: TLabel
      Left = 250
      Top = 14
      Width = 102
      Height = 13
      Caption = 'Speed (<0 backward)'
    end
    object Label7: TLabel
      Left = 787
      Top = 16
      Width = 27
      Height = 13
      Caption = 'Menu'
    end
    object TrackBar1: TTrackBar
      Left = 83
      Top = 10
      Width = 150
      Height = 29
      Max = 3000
      Min = 1
      Orientation = trHorizontal
      Frequency = 100
      Position = 100
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
    object ComboBox1: TComboBox
      Left = 571
      Top = 14
      Width = 55
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      OnChange = ComboBox1Change
    end
    object ComboBox2: TComboBox
      Left = 714
      Top = 14
      Width = 55
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBox2Change
    end
    object Edit1: TEdit
      Left = 362
      Top = 11
      Width = 48
      Height = 21
      TabOrder = 3
      Text = '1'
    end
    object UpDown1: TUpDown
      Left = 410
      Top = 11
      Width = 17
      Height = 21
      Min = -50
      Max = 50
      Position = 10
      TabOrder = 4
      Wrap = False
      OnClick = UpDown1Click
    end
    object ComboBox3: TComboBox
      Left = 823
      Top = 14
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      OnChange = ComboBox3Change
      Items.Strings = (
        'Title'
        'Root'
        'SubPicture'
        'Audio'
        'Angle'
        'Chapter')
    end
  end
  object ImageEnView1: TImageEnView
    Left = 180
    Top = 41
    Width = 886
    Height = 477
    ParentCtl3D = False
    ImageEnVersion = '2.2.9'
    Align = alClient
    TabOrder = 2
    OnMouseDown = ImageEnView1MouseDown
    OnMouseMove = ImageEnView1MouseMove
  end
  object ImageEnMView1: TImageEnMView
    Left = 0
    Top = 41
    Width = 180
    Height = 477
    ParentCtl3D = False
    OnImageSelect = ImageEnMView1ImageSelect
    GridWidth = 1
    SelectionWidth = 3
    SelectionColor = clRed
    ThumbnailsBorderColor = clBlack
    ImageEnVersion = '2.2.9'
    Align = alLeft
    TabOrder = 3
  end
  object OpenImageEnDialog1: TOpenImageEnDialog
    Filter = 'Multimedia files|*.avi;*.mpeg;*.mpg;*.wmv'
    AutoSetFilter = False
    Left = 846
    Top = 73
  end
  object MainMenu1: TMainMenu
    Left = 178
    Top = 97
    object File1: TMenuItem
      Caption = '&File'
      object Saveframe1: TMenuItem
        Caption = '&Save frame...'
        OnClick = Saveframe1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
      end
    end
    object Stop1: TMenuItem
      Caption = '&Control'
      object Play1: TMenuItem
        Caption = '&Play'
        OnClick = Play1Click
      end
      object Pause1: TMenuItem
        Caption = 'Pause'
        OnClick = Pause1Click
      end
      object Stop2: TMenuItem
        Caption = '&Stop'
        OnClick = Stop2Click
      end
    end
    object Getframe1: TMenuItem
      Caption = '&Get frame'
      OnClick = Getframe1Click
    end
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 536
    Top = 81
  end
end
