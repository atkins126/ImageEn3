object MainForm: TMainForm
  Left = 243
  Top = 114
  Width = 999
  Height = 527
  Caption = 'Compares two images'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 0
    Width = 477
    Height = 388
    ParentCtl3D = False
    OnViewChange = ImageEnView1ViewChange
    ImageEnVersion = '3.0.3'
    EnableInteractionHints = True
    TabOrder = 0
    OnMouseMove = ImageEnView1MouseMove
  end
  object ImageEnView2: TImageEnView
    Left = 495
    Top = -1
    Width = 477
    Height = 388
    ParentCtl3D = False
    OnViewChange = ImageEnView2ViewChange
    ImageEnVersion = '3.0.3'
    EnableInteractionHints = True
    TabOrder = 1
    OnMouseMove = ImageEnView1MouseMove
  end
  object Panel1: TPanel
    Left = 0
    Top = 397
    Width = 991
    Height = 81
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 11
      Top = 11
      Width = 74
      Height = 13
      Caption = 'Left pixel value:'
    end
    object Label2: TLabel
      Left = 105
      Top = 11
      Width = 18
      Height = 13
      Caption = '------'
    end
    object Label3: TLabel
      Left = 11
      Top = 32
      Width = 81
      Height = 13
      Caption = 'Right pixel value:'
    end
    object Label4: TLabel
      Left = 105
      Top = 32
      Width = 18
      Height = 13
      Caption = '------'
    end
    object Label5: TLabel
      Left = 11
      Top = 53
      Width = 37
      Height = 13
      Caption = 'Position'
    end
    object Label6: TLabel
      Left = 105
      Top = 53
      Width = 18
      Height = 13
      Caption = '------'
    end
  end
  object MainMenu1: TMainMenu
    Left = 169
    Top = 63
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = 'Open &Left...'
        OnClick = Open1Click
      end
      object OpenRight1: TMenuItem
        Caption = 'Open &Right...'
        OnClick = OpenRight1Click
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
