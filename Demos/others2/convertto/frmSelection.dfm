object SelectionDialog: TSelectionDialog
  Left = 326
  Top = 215
  BorderStyle = bsDialog
  Caption = 'Selection'
  ClientHeight = 230
  ClientWidth = 458
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object OKBtn: TButton
    Left = 372
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OKBtnClick
  end
  object CancelBtn: TButton
    Left = 372
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 12
    Width = 183
    Height = 197
    Caption = 'Grip'
    TabOrder = 2
    object Label2: TLabel
      Left = 16
      Top = 17
      Width = 19
      Height = 13
      Caption = 'Size'
    end
    object Label3: TLabel
      Left = 20
      Top = 67
      Width = 34
      Height = 13
      Caption = 'Color 1'
    end
    object Label4: TLabel
      Left = 22
      Top = 117
      Width = 34
      Height = 13
      Caption = 'Color 2'
    end
    object Edit1: TEdit
      Left = 20
      Top = 32
      Width = 45
      Height = 21
      TabOrder = 0
      Text = '3'
    end
    object UpDownSize: TUpDown
      Left = 65
      Top = 32
      Width = 16
      Height = 21
      Associate = Edit1
      Position = 3
      TabOrder = 1
      OnChanging = UpDownSizeChanging
    end
    object ColorBoxColor1: TColorBox
      Left = 20
      Top = 82
      Width = 80
      Height = 22
      DefaultColorColor = clWhite
      NoneColorColor = clWhite
      Selected = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 2
      OnChange = ColorBoxColor1Change
    end
    object ColorBoxColor2: TColorBox
      Left = 20
      Top = 134
      Width = 80
      Height = 22
      NoneColorColor = clRed
      Selected = clRed
      ItemHeight = 16
      TabOrder = 3
      OnChange = ColorBoxColor2Change
    end
    object CheckBoxExtendedSelectionDrawing: TCheckBox
      Left = 16
      Top = 168
      Width = 221
      Height = 17
      Caption = 'Extended Selection Drawing'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = CheckBoxExtendedSelectionDrawingClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 206
    Top = 12
    Width = 149
    Height = 191
    Caption = 'Rubberband'
    TabOrder = 3
    object Label1: TLabel
      Left = 12
      Top = 22
      Width = 34
      Height = 13
      Caption = 'Color 1'
    end
    object Label5: TLabel
      Left = 12
      Top = 71
      Width = 34
      Height = 13
      Caption = 'Color 2'
    end
    object ColorBox1: TColorBox
      Left = 12
      Top = 38
      Width = 80
      Height = 22
      DefaultColorColor = clWhite
      NoneColorColor = clWhite
      Selected = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Shell Dlg 2'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      TabOrder = 0
      OnChange = ColorBox1Change
    end
    object ColorBox2: TColorBox
      Left = 12
      Top = 86
      Width = 80
      Height = 22
      NoneColorColor = clRed
      Selected = clRed
      ItemHeight = 16
      TabOrder = 1
      OnChange = ColorBox2Change
    end
  end
end
