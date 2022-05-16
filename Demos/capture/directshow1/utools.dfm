object ftools: Tftools
  Left = 796
  Top = 144
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Tools'
  ClientHeight = 503
  ClientWidth = 212
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 153
    Caption = ' Zoom '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 26
      Width = 18
      Height = 13
      Caption = '100'
    end
    object Label7: TLabel
      Left = 8
      Top = 120
      Width = 52
      Height = 13
      Caption = 'Zoom Filter'
    end
    object TrackBar1: TTrackBar
      Left = 34
      Top = 21
      Width = 143
      Height = 45
      Max = 3000
      Min = 1
      Frequency = 100
      Position = 1
      TabOrder = 0
      OnChange = TrackBar1Change
    end
    object Button1: TButton
      Left = 56
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Fit'
      TabOrder = 1
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 78
      Top = 115
      Width = 103
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'None'
      OnChange = ComboBox1Change
      Items.Strings = (
        'None'
        'Triangle'
        'Hermite'
        'Bell'
        'BSpline'
        'Lanczos3'
        'Mitchell'
        'Nearest'
        'Linear'
        'FastLinear'
        'Bilinear'
        'Bicubic')
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 169
    Width = 193
    Height = 177
    Caption = ' Channels '
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 20
      Height = 13
      Caption = 'Red'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 29
      Height = 13
      Caption = 'Green'
    end
    object Label4: TLabel
      Left = 16
      Top = 120
      Width = 21
      Height = 13
      Caption = 'Blue'
    end
    object TrackBar2: TTrackBar
      Left = 8
      Top = 40
      Width = 150
      Height = 34
      Max = 255
      Min = -255
      Frequency = 16
      TabOrder = 0
      OnChange = TrackBar2Change
    end
    object TrackBar3: TTrackBar
      Left = 8
      Top = 88
      Width = 150
      Height = 34
      Max = 255
      Min = -255
      Frequency = 16
      TabOrder = 1
      OnChange = TrackBar3Change
    end
    object TrackBar4: TTrackBar
      Left = 8
      Top = 136
      Width = 150
      Height = 34
      Max = 255
      Min = -255
      Frequency = 16
      TabOrder = 2
      OnChange = TrackBar4Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 353
    Width = 193
    Height = 137
    Caption = ' Adjust '
    TabOrder = 2
    object Label5: TLabel
      Left = 16
      Top = 24
      Width = 49
      Height = 13
      Caption = 'Luminosity'
    end
    object Label6: TLabel
      Left = 16
      Top = 80
      Width = 39
      Height = 13
      Caption = 'Contrast'
    end
    object TrackBar5: TTrackBar
      Left = 8
      Top = 40
      Width = 150
      Height = 34
      Max = 255
      Min = -255
      Frequency = 16
      TabOrder = 0
      OnChange = TrackBar5Change
    end
    object TrackBar6: TTrackBar
      Left = 8
      Top = 96
      Width = 150
      Height = 34
      Max = 100
      Min = -100
      Frequency = 16
      TabOrder = 1
      OnChange = TrackBar6Change
    end
  end
end
