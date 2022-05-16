object Form1: TForm1
  Left = 545
  Top = 136
  Width = 445
  Height = 457
  Caption = 'Example for use of ImageEn-package'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView1: TImageEnView
    Left = 8
    Top = 0
    Width = 409
    Height = 369
    ParentCtl3D = False
    ImageEnVersion = '2.1.8'
    TabOrder = 0
  end
  object BitBtn_OpenImage: TBitBtn
    Left = 32
    Top = 376
    Width = 75
    Height = 25
    Caption = '&Open Image'
    TabOrder = 1
    OnClick = BitBtn_OpenImageClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 404
    Width = 437
    Height = 19
    Panels = <
      item
        Text = 'Imasge-CROPping made easy'
        Width = 50
      end>
  end
  object BitBtn_crop: TBitBtn
    Left = 112
    Top = 376
    Width = 75
    Height = 25
    Caption = '&Crop'
    TabOrder = 3
    OnClick = BitBtn_cropClick
  end
  object CheckBox_fit: TCheckBox
    Left = 208
    Top = 376
    Width = 33
    Height = 17
    Caption = '&Fit'
    TabOrder = 4
    OnClick = CheckBox_fitClick
  end
  object TrackBar_ImageEn_Zoom: TTrackBar
    Left = 256
    Top = 376
    Width = 161
    Height = 25
    Max = 100
    TabOrder = 5
    OnChange = TrackBar_ImageEn_ZoomChange
  end
end
