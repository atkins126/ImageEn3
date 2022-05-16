object dlgGetSelection: TdlgGetSelection
  Left = 562
  Top = 227
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Selection Rect'
  ClientHeight = 396
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ieSelect: TImageEnView
    Left = 32
    Top = 52
    Width = 404
    Height = 304
    ParentCtl3D = False
    SelectionOptions = [iesoAnimated, iesoSizeable, iesoMoveable, iesoMarkOuter, iesoCanScroll]
    MouseInteract = [miSelect]
    SelectionBase = iesbBitmap
    OnSelectionChange = ieSelectSelectionChange
    AutoStretch = True
    AutoShrink = True
    ImageEnVersion = '2.1.9'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 361
    Top = 363
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object OK: TButton
    Left = 281
    Top = 363
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object rdbWholeImage: TRadioButton
    Left = 8
    Top = 8
    Width = 113
    Height = 17
    Caption = 'Entire Image'
    TabOrder = 3
    OnClick = rdbWholeImageClick
  end
  object rdbSelImage: TRadioButton
    Left = 8
    Top = 30
    Width = 113
    Height = 17
    Caption = 'Image Selection'
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = rdbWholeImageClick
  end
  object chkLockAR: TCheckBox
    Left = 32
    Top = 368
    Width = 217
    Height = 17
    Caption = 'Lock selection to display ratio'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = chkLockARClick
  end
end
