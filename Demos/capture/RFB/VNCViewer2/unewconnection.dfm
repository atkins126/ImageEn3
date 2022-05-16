object NewConnectionForm: TNewConnectionForm
  Left = 159
  Top = 104
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'New Connection'
  ClientHeight = 182
  ClientWidth = 242
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
    Left = 8
    Top = 8
    Width = 225
    Height = 121
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 98
      Height = 13
      Caption = 'Address (IP or name)'
    end
    object Port: TLabel
      Left = 160
      Top = 16
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label2: TLabel
      Left = 8
      Top = 65
      Width = 88
      Height = 13
      Caption = 'Optional Password'
    end
    object AddressEdit: TEdit
      Left = 8
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object PortEdit: TEdit
      Left = 160
      Top = 32
      Width = 49
      Height = 21
      TabOrder = 1
      Text = '5900'
    end
    object PasswordEdit: TEdit
      Left = 8
      Top = 81
      Width = 89
      Height = 21
      MaxLength = 8
      TabOrder = 2
    end
  end
  object OKButton: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Add'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 160
    Top = 144
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
