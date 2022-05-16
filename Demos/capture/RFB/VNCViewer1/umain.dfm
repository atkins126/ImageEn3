object MainForm: TMainForm
  Left = 275
  Top = 180
  Width = 870
  Height = 500
  Caption = 'Simple VNC (RFB protocol) viewer - by HiComponents'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 59
    Align = alTop
    TabOrder = 0
    DesignSize = (
      862
      59)
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 31
      Height = 13
      Caption = 'Server'
    end
    object Label2: TLabel
      Left = 184
      Top = 13
      Width = 19
      Height = 13
      Caption = 'Port'
    end
    object Label3: TLabel
      Left = 279
      Top = 13
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object SpeedButton1: TSpeedButton
      Left = 440
      Top = 8
      Width = 73
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Connect'
      OnClick = SpeedButton1Click
    end
    object Label5: TLabel
      Left = 8
      Top = 40
      Width = 307
      Height = 13
      Caption = 'Please disable EIERFBError exceptions from the Delphi debugger'
    end
    object Edit1: TEdit
      Left = 49
      Top = 9
      Width = 121
      Height = 21
      Hint = 'Insert server IP or name'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 211
      Top = 9
      Width = 46
      Height = 21
      TabOrder = 1
      Text = '5900'
    end
    object Edit3: TEdit
      Left = 332
      Top = 9
      Width = 84
      Height = 21
      Hint = 'Insert server IP or name'
      MaxLength = 8
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object Button1: TButton
      Left = 720
      Top = 8
      Width = 129
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Send CTRL-ALT-DEL'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object VNCView: TImageEnView
    Left = 137
    Top = 59
    Width = 725
    Height = 387
    ParentCtl3D = False
    ZoomFilter = rfFastLinear
    OnSpecialKey = VNCViewSpecialKey
    ImageEnVersion = '3.0.6a'
    OnVirtualKey = VNCViewVirtualKey
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 1
    OnMouseDown = VNCViewMouseDownUp
    OnMouseMove = VNCViewMouseMove
    OnMouseUp = VNCViewMouseDownUp
  end
  object Panel2: TPanel
    Left = 0
    Top = 59
    Width = 137
    Height = 387
    Align = alLeft
    TabOrder = 2
    object Label4: TLabel
      Left = 6
      Top = 123
      Width = 123
      Height = 28
      Alignment = taCenter
      AutoSize = False
      Caption = 'Rotate mouse wheel to zoom'
      WordWrap = True
    end
    object VNCNavi: TImageEnView
      Left = 8
      Top = 8
      Width = 121
      Height = 113
      ParentCtl3D = False
      ZoomFilter = rfFastLinear
      ImageEnVersion = '3.0.6a'
      EnableInteractionHints = True
      TabOrder = 0
    end
  end
  object XPManifest1: TXPManifest
    Left = 592
    Top = 65
  end
  object MainMenu1: TMainMenu
    Left = 104
    Top = 113
    object File1: TMenuItem
      Caption = '&File'
      object Saveframeas1: TMenuItem
        Caption = '&Save frame as...'
        OnClick = Saveframeas1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Exit'
        OnClick = Exit1Click
      end
    end
  end
end
