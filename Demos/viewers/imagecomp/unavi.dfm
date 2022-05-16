object fNavi: TfNavi
  Left = 641
  Top = 221
  Width = 275
  Height = 220
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsSizeToolWin
  Caption = 'Navigator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 133
    Top = 0
    Width = 3
    Height = 133
    Cursor = crHSplit
  end
  object Panel1: TPanel
    Left = 0
    Top = 133
    Width = 267
    Height = 53
    Align = alBottom
    TabOrder = 0
    object TrackBar1: TTrackBar
      Left = 7
      Top = 7
      Width = 255
      Height = 37
      Max = 2000
      Min = 1
      Orientation = trHorizontal
      Frequency = 100
      Position = 1
      SelEnd = 0
      SelStart = 0
      TabOrder = 0
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBar1Change
    end
  end
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 0
    Width = 133
    Height = 133
    ParentCtl3D = False
    ImageEnVersion = '2.3.1'
    Align = alLeft
    TabOrder = 1
  end
  object ImageEnView2: TImageEnView
    Left = 136
    Top = 0
    Width = 131
    Height = 133
    ParentCtl3D = False
    ImageEnVersion = '2.3.1'
    Align = alClient
    TabOrder = 2
  end
end
