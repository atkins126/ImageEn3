object fselectinput: Tfselectinput
  Left = 193
  Top = 110
  Width = 393
  Height = 339
  Caption = 'Select input'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 360
    Height = 49
    Caption = ' Input from File '
    TabOrder = 0
    object Edit1: TEdit
      Left = 8
      Top = 16
      Width = 297
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
    end
    object Button1: TButton
      Left = 316
      Top = 15
      Width = 31
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 64
    Width = 361
    Height = 185
    Caption = ' Input from Video/Audio Capture '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 27
      Height = 13
      Caption = 'Video'
    end
    object Label2: TLabel
      Left = 8
      Top = 104
      Width = 27
      Height = 13
      Caption = 'Audio'
    end
    object ListBox1: TListBox
      Left = 8
      Top = 40
      Width = 337
      Height = 57
      ItemHeight = 13
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object ListBox2: TListBox
      Left = 8
      Top = 120
      Width = 337
      Height = 57
      ItemHeight = 13
      TabOrder = 1
      OnClick = ListBox2Click
    end
  end
  object Button2: TButton
    Left = 152
    Top = 264
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object OpenDialog1: TOpenDialog
    Left = 168
    Top = 16
  end
end
