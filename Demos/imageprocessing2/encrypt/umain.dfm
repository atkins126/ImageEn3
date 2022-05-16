object Form1: TForm1
  Left = 243
  Top = 110
  Width = 894
  Height = 658
  Caption = 'Encrypt demo'
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
    Width = 886
    Height = 79
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 15
      Top = 23
      Width = 75
      Height = 25
      Caption = 'Open...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object GroupBox1: TGroupBox
      Left = 224
      Top = 5
      Width = 149
      Height = 63
      Caption = ' Passkey '
      TabOrder = 1
      object Edit1: TEdit
        Left = 12
        Top = 24
        Width = 127
        Height = 21
        TabOrder = 0
        Text = 'Captiva'
      end
    end
    object Button2: TButton
      Left = 390
      Top = 23
      Width = 75
      Height = 25
      Caption = 'Save...'
      TabOrder = 2
      OnClick = Button2Click
    end
    object GroupBox2: TGroupBox
      Left = 102
      Top = 5
      Width = 110
      Height = 63
      Caption = ' Action '
      TabOrder = 3
      object Button3: TButton
        Left = 49
        Top = 10
        Width = 56
        Height = 22
        Caption = 'Encrypt'
        TabOrder = 0
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 49
        Top = 37
        Width = 56
        Height = 22
        Caption = 'Decrypt'
        TabOrder = 1
        OnClick = Button4Click
      end
    end
  end
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 79
    Width = 886
    Height = 545
    ParentCtl3D = False
    EnableAlphaChannel = True
    OnProgress = ImageEnView1Progress
    OnFinishWork = ImageEnView1FinishWork
    ImageEnVersion = '2.3.1'
    Align = alClient
    TabOrder = 1
    object StatusBar1: TStatusBar
      Left = 0
      Top = 522
      Width = 882
      Height = 19
      Panels = <>
      SimplePanel = True
    end
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 509
      Width = 882
      Height = 13
      Align = alBottom
      Min = 0
      Max = 100
      TabOrder = 1
    end
  end
end
