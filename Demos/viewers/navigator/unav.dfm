object fnav: Tfnav
  Left = 656
  Top = 243
  Width = 220
  Height = 191
  BorderIcons = []
  BorderStyle = bsSizeToolWin
  Caption = 'Nav'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 0
    Width = 212
    Height = 157
    ParentCtl3D = False
    BorderStyle = bsNone
    SelectionOptions = [iesoMoveable, iesoCanScroll]
    MouseInteract = [miSelect]
    AutoFit = True
    SelectionBase = iesbBitmap
    ImageEnVersion = '3.0.2'
    EnableInteractionHints = True
    FlatScrollBars = True
    Align = alClient
    TabOrder = 0
  end
end
