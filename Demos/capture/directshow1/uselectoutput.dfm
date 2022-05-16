object fselectoutput: Tfselectoutput
  Left = 278
  Top = 188
  Width = 396
  Height = 365
  Caption = 'Select Output'
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
    Caption = ' Output to File '
    TabOrder = 0
    object Edit1: TEdit
      Left = 8
      Top = 16
      Width = 297
      Height = 21
      TabOrder = 0
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
    Height = 217
    Caption = ' Compression filter '
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
      Top = 117
      Width = 27
      Height = 13
      Caption = 'Audio'
    end
    object ListBox1: TListBox
      Left = 8
      Top = 41
      Width = 337
      Height = 60
      ItemHeight = 13
      TabOrder = 0
    end
    object ListBox2: TListBox
      Left = 8
      Top = 134
      Width = 337
      Height = 60
      ItemHeight = 13
      TabOrder = 1
    end
  end
  object Button2: TButton
    Left = 144
    Top = 296
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object SaveDialog1: TSaveDialog
    Left = 56
    Top = 32
  end
end
