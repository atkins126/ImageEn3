object MainForm: TMainForm
  Left = 97
  Top = 197
  Width = 1143
  Height = 370
  Caption = 'Multi VNC Viewer (RFB protocol) - by HiComponents'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object MultiViewer: TImageEnMView
    Left = 0
    Top = 0
    Width = 1135
    Height = 295
    Hint = 'Double click to control'
    ParentCtl3D = False
    StoreType = ietThumb
    ThumbWidth = 220
    ThumbHeight = 220
    Style = iemsFlat
    ThumbnailsBorderColor = clBlack
    ImageEnVersion = '3.0.6a'
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnMouseDown = MultiViewerMouseDown
  end
  object Panel1: TPanel
    Left = 0
    Top = 295
    Width = 1135
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Label5: TLabel
      Left = 464
      Top = 16
      Width = 307
      Height = 13
      Caption = 'Please disable EIERFBError exceptions from the Delphi debugger'
    end
    object NewConnectionButton: TButton
      Left = 8
      Top = 10
      Width = 129
      Height = 25
      Caption = 'New Connection'
      TabOrder = 0
      OnClick = NewConnectionButtonClick
    end
    object DeleteConnectionButton: TButton
      Left = 160
      Top = 10
      Width = 129
      Height = 25
      Caption = 'Delete Connection'
      TabOrder = 1
      OnClick = DeleteConnectionButtonClick
    end
    object HiQualityCheck: TCheckBox
      Left = 352
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Hi Quality'
      TabOrder = 2
      OnClick = HiQualityCheckClick
    end
  end
  object XPManifest1: TXPManifest
    Left = 456
    Top = 40
  end
end
