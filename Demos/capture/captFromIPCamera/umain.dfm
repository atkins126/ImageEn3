object Form1: TForm1
  Left = 225
  Top = 88
  Width = 1043
  Height = 640
  Caption = 'Example of Capture from IP camera'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1035
    Height = 103
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 1033
      Height = 40
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'This example shows how capture from an IP camera which sends a s' +
        'tream of Jpeg images. Tested with Grand IP Camera III'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 89
      Height = 13
      Caption = 'Camera IP address'
    end
    object Label3: TLabel
      Left = 144
      Top = 48
      Width = 73
      Height = 13
      Caption = 'Stream address'
    end
    object Label4: TLabel
      Left = 266
      Top = 48
      Width = 22
      Height = 13
      Caption = 'User'
    end
    object Label5: TLabel
      Left = 330
      Top = 48
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object ButtonConnect: TSpeedButton
      Left = 414
      Top = 58
      Width = 97
      Height = 33
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Connect'
      OnClick = ButtonConnectClick
    end
    object EditIP: TEdit
      Left = 8
      Top = 64
      Width = 89
      Height = 21
      TabOrder = 0
      Text = '10.0.0.4'
    end
    object EditAddress: TEdit
      Left = 144
      Top = 64
      Width = 97
      Height = 21
      TabOrder = 1
      Text = '/video.cgi'
    end
    object EditUser: TEdit
      Left = 266
      Top = 64
      Width = 57
      Height = 21
      TabOrder = 2
      Text = 'user1'
    end
    object EditPassword: TEdit
      Left = 330
      Top = 64
      Width = 57
      Height = 21
      TabOrder = 3
      Text = 'user1'
    end
  end
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 103
    Width = 1035
    Height = 508
    ParentCtl3D = False
    ImageEnVersion = '3.1.1'
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 1
  end
end
