object ConnectionForm: TConnectionForm
  Left = 138
  Top = 101
  Width = 1142
  Height = 656
  Caption = 'Caption'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Viewer: TImageEnView
    Left = 0
    Top = 0
    Width = 1134
    Height = 627
    ParentCtl3D = False
    OnSpecialKey = ViewerSpecialKey
    ImageEnVersion = '3.0.5'
    OnVirtualKey = ViewerVirtualKey
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 0
    OnMouseDown = MouseDownUp
    OnMouseMove = ViewerMouseMove
    OnMouseUp = MouseDownUp
  end
end
