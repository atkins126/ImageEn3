object frmImport: TfrmImport
  Left = 360
  Top = 167
  BorderStyle = bsDialog
  Caption = 'Import'
  ClientHeight = 211
  ClientWidth = 380
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 6
    Top = 3
    Width = 178
    Height = 82
    Caption = 'Color Depth'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Win XP'
      'True Color'
      '256 Color'
      '16 Color'
      'Monochrome')
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 193
    Top = 2
    Width = 178
    Height = 196
    Caption = 'Size'
    TabOrder = 1
    object RzLabel1: TLabel
      Left = 95
      Top = 160
      Width = 7
      Height = 13
      Caption = 'X'
    end
    object RadioButton1: TRadioButton
      Left = 18
      Top = 18
      Width = 115
      Height = 17
      Caption = '16 x 16'
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 18
      Top = 38
      Width = 115
      Height = 17
      Caption = '32 x 32'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioButton2Click
    end
    object RadioButton3: TRadioButton
      Left = 18
      Top = 58
      Width = 115
      Height = 17
      Caption = '48 x 48'
      TabOrder = 2
      OnClick = RadioButton3Click
    end
    object RadioButton4: TRadioButton
      Left = 18
      Top = 78
      Width = 115
      Height = 17
      Caption = '64 x 64'
      TabOrder = 3
      OnClick = RadioButton4Click
    end
    object RadioButton5: TRadioButton
      Left = 18
      Top = 98
      Width = 115
      Height = 17
      Caption = '72 x 72'
      TabOrder = 4
      OnClick = RadioButton5Click
    end
    object RadioButton6: TRadioButton
      Left = 18
      Top = 118
      Width = 115
      Height = 17
      Caption = '128 x 128'
      TabOrder = 5
      OnClick = RadioButton6Click
    end
    object RadioButton7: TRadioButton
      Left = 18
      Top = 138
      Width = 115
      Height = 17
      Caption = 'Other'
      TabOrder = 6
      OnClick = RadioButton7Click
    end
    object SpinEdit1: TSpinEdit
      Left = 36
      Top = 156
      Width = 52
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 7
      Value = 0
    end
    object SpinEdit2: TSpinEdit
      Left = 108
      Top = 156
      Width = 52
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 8
      Value = 0
    end
  end
  object Button1: TButton
    Left = 9
    Top = 162
    Width = 67
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 84
    Top = 162
    Width = 67
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 7
    Top = 89
    Width = 177
    Height = 67
    Caption = 'Filter'
    TabOrder = 4
    object Label3: TLabel
      Left = 10
      Top = 19
      Width = 22
      Height = 13
      Caption = 'Filter'
    end
    object ComboBox1: TComboBox
      Left = 9
      Top = 33
      Width = 160
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'None'
      Items.Strings = (
        'None'
        'Triangle'
        'Hermite'
        'Bell'
        'BSpline'
        'Lanczos3'
        'Mitchell')
    end
  end
end
