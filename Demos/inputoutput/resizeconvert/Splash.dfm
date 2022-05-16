object frmSplash: TfrmSplash
  Left = 273
  Top = 199
  BorderStyle = bsNone
  Caption = 'frmSplash'
  ClientHeight = 177
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClient: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 177
    Align = alClient
    TabOrder = 0
    object Bevel1: TBevel
      Left = 8
      Top = 8
      Width = 337
      Height = 161
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 24
      Top = 120
      Width = 305
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Starting application... please wait...'
    end
    object Label2: TLabel
      Left = 14
      Top = 24
      Width = 323
      Height = 33
      Alignment = taCenter
      AutoSize = False
      Caption = 'ImageEN Image Batch Converter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 72
      Width = 305
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Version 1.0'
    end
    object Label4: TLabel
      Left = 24
      Top = 88
      Width = 305
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Copyright '#169' 2003 William Miller. All rights reserved.'
    end
    object Label5: TLabel
      Left = 10
      Top = 48
      Width = 333
      Height = 23
      Alignment = taCenter
      AutoSize = False
      Caption = 'BETA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ProgressBar: TProgressBar
      Left = 24
      Top = 136
      Width = 305
      Height = 17
      Step = 1
      TabOrder = 0
    end
  end
end
