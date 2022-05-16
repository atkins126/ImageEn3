object Form1: TForm1
  Left = 155
  Top = 149
  Width = 1036
  Height = 536
  Caption = 'VMR Video'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1028
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 11
      Width = 228
      Height = 16
      Caption = 'Rendering a multimedia file on overlay'
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
    Top = 433
    Width = 1028
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
  end
  object ImageEnView1: TImageEnView
    Left = 180
    Top = 41
    Width = 848
    Height = 392
    ParentCtl3D = False
    ImageEnVersion = '2.2.9'
    Align = alClient
    TabOrder = 2
  end
  object ImageEnMView1: TImageEnMView
    Left = 0
    Top = 41
    Width = 180
    Height = 392
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
      object Open1: TMenuItem
        Caption = 'Open...'
        OnClick = Open1Click
      end
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
end
