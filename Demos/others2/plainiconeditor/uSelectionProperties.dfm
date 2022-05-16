object frmSelectionProperties: TfrmSelectionProperties
  Left = 175
  Top = 157
  Width = 267
  Height = 236
  Caption = 'Selection Properties'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 10
    Width = 245
    Height = 153
    Caption = 'Selection'
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 20
      Width = 93
      Height = 13
      Caption = 'Selection Tolerance'
    end
    object Label1: TLabel
      Left = 8
      Top = 59
      Width = 108
      Height = 13
      Caption = 'Magic Wand Tolerance'
    end
    object Label3: TLabel
      Left = 8
      Top = 104
      Width = 87
      Height = 13
      Caption = 'Magic Wand Mode'
    end
    object UpDownSelectionTolerance: TUpDown
      Left = 37
      Top = 34
      Width = 16
      Height = 21
      Associate = SelectionIntensityEdit
      ArrowKeys = False
      Position = 1
      TabOrder = 0
    end
    object SelectionIntensityEdit: TEdit
      Left = 8
      Top = 34
      Width = 29
      Height = 21
      TabOrder = 1
      Text = '1'
    end
    object MagicWandToleranceUpDown: TUpDown
      Left = 37
      Top = 73
      Width = 16
      Height = 21
      Associate = MagicWandToleranceEdit
      Position = 15
      TabOrder = 2
    end
    object MagicWandToleranceEdit: TEdit
      Left = 8
      Top = 73
      Width = 29
      Height = 21
      TabOrder = 3
      Text = '15'
    end
    object cbMagicWandMode: TComboBox
      Left = 8
      Top = 118
      Width = 229
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Text = 'Inclusive: selection is a closed polygon (default)'
      Items.Strings = (
        'Inclusive: selection is a closed polygon (default)'
        
          'Exclusive: selection includes only points that mach initial pixe' +
          'l'
        'Global: selection includes all points that mach initial pixel')
    end
  end
  object Button1: TButton
    Left = 6
    Top = 171
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 90
    Top = 171
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
