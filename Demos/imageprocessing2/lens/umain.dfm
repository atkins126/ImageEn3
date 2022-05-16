object Form1: TForm1
  Left = 255
  Top = 144
  Width = 870
  Height = 500
  Caption = 'Lens method test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 177
      Top = 14
      Width = 23
      Height = 13
      Caption = 'Lens'
    end
    object Button1: TButton
      Left = 12
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Open...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 210
      Top = 11
      Width = 55
      Height = 21
      TabOrder = 1
      Text = '1'
      OnChange = Edit1Change
    end
    object TrackBar1: TTrackBar
      Left = 282
      Top = 4
      Width = 210
      Height = 35
      LineSize = 10
      Max = 200
      Min = -200
      Orientation = trHorizontal
      Frequency = 10
      Position = 50
      SelEnd = 50
      SelStart = -50
      TabOrder = 2
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
  end
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 41
    Width = 862
    Height = 425
    ParentCtl3D = False
    ImageEnVersion = '2.3.1'
    Align = alClient
    TabOrder = 1
  end
end
