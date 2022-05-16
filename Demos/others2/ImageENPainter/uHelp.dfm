object FrmHelp: TFrmHelp
  Left = 0
  Top = 0
  Caption = 'Help'
  ClientHeight = 517
  ClientWidth = 612
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  DesignSize = (
    612
    517)
  PixelsPerInch = 96
  TextHeight = 13
  object RichEdit1: TRichEdit
    Left = 12
    Top = 13
    Width = 585
    Height = 452
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 476
    Width = 612
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = 9
    ExplicitTop = 474
    ExplicitWidth = 185
    object Button1: TButton
      Left = 269
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
    end
  end
end
