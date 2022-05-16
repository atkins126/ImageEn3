object Form1: TForm1
  Left = 106
  Top = 38
  Width = 817
  Height = 673
  Caption = 'ImageEn Transparency and Layer Textout Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 809
    Height = 41
    Align = alTop
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 646
      Top = 10
      Width = 155
      Height = 25
      AllowAllUp = True
      GroupIndex = 2
      Down = True
      Caption = 'Enable Transparency'
      Transparent = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 474
      Top = 10
      Width = 167
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Pick Transparent Color'
      Transparent = False
      OnClick = SpeedButton2Click
    end
    object Label2: TLabel
      Left = 272
      Top = 3
      Width = 27
      Height = 14
      Caption = 'Zoom'
    end
    object Button1: TButton
      Left = 94
      Top = 10
      Width = 75
      Height = 25
      Caption = 'TextOut'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 6
      Top = 10
      Width = 83
      Height = 25
      Caption = 'Open Image'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 178
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 2
      OnClick = Button3Click
    end
    object TrackBar2: TTrackBar
      Left = 266
      Top = 15
      Width = 201
      Height = 18
      Max = 3000
      Min = 1
      ParentShowHint = False
      Frequency = 100
      Position = 100
      ShowHint = True
      TabOrder = 3
      OnChange = TrackBar2Change
    end
  end
  object ImageEnView1: TImageEnView
    Left = 0
    Top = 41
    Width = 586
    Height = 579
    ParentCtl3D = False
    BackgroundStyle = iebsChessboard
    EnableAlphaChannel = True
    ImageEnVersion = '2.2.0'
    Align = alClient
    TabOrder = 1
    OnMouseDown = ImageEnView1MouseDown
    OnMouseMove = ImageEnView1MouseMove
  end
  object Panel2: TPanel
    Left = 586
    Top = 41
    Width = 223
    Height = 579
    Align = alRight
    TabOrder = 2
    object Panel9: TPanel
      Left = 1
      Top = 332
      Width = 221
      Height = 246
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Panel10: TPanel
        Left = 0
        Top = 0
        Width = 221
        Height = 18
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Caption = ' Color:'
        Color = clGradientActiveCaption
        ParentBackground = False
        TabOrder = 0
      end
      object HSVBox1: THSVBox
        Left = 12
        Top = 32
        Width = 191
        Height = 89
      end
      object GroupBox2: TGroupBox
        Left = 116
        Top = 128
        Width = 101
        Height = 89
        Caption = 'Selected Color'
        TabOrder = 2
        object Label4: TLabel
          Left = 10
          Top = 14
          Width = 22
          Height = 11
          Caption = 'Color'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object SelectedColorPanel: TPanel
          Left = 4
          Top = 29
          Width = 89
          Height = 38
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 130
        Width = 101
        Height = 101
        Caption = 'Current Color'
        TabOrder = 3
        object Label5: TLabel
          Left = 8
          Top = 18
          Width = 10
          Height = 11
          Caption = 'R:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object L_R: TLabel
          Left = 29
          Top = 18
          Width = 9
          Height = 11
          Caption = 'R:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 8
          Top = 29
          Width = 10
          Height = 11
          Caption = 'G:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object L_G: TLabel
          Left = 29
          Top = 29
          Width = 9
          Height = 11
          Caption = 'R:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 8
          Top = 41
          Width = 10
          Height = 11
          Caption = 'B:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object L_B: TLabel
          Left = 29
          Top = 41
          Width = 9
          Height = 11
          Caption = 'R:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ActiveColorPanel: TPanel
          Left = 4
          Top = 56
          Width = 89
          Height = 33
          BevelOuter = bvNone
          BorderStyle = bsSingle
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
        end
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 221
      Height = 18
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = ' Layer:'
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 30
      Width = 201
      Height = 293
      Caption = 'Layers:'
      TabOrder = 2
      object ImageEnMView1: TImageEnMView
        Left = 8
        Top = 24
        Width = 117
        Height = 173
        Background = clGray
        ParentCtl3D = False
        BorderStyle = bsNone
        StoreType = ietThumb
        ThumbWidth = 90
        ThumbHeight = 90
        OnImageSelect = ImageEnMView1ImageSelect
        GridWidth = 1
        SelectionWidth = 3
        SelectionColor = clRed
        Style = iemsFlat
        ThumbnailsBackground = clGray
        EnableMultiSelect = True
        ThumbnailsBorderColor = clBlack
        TabOrder = 0
      end
      object Button5: TButton
        Left = 134
        Top = 26
        Width = 60
        Height = 25
        Hint = 'Add new layer'
        Caption = 'Add'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Button5Click
      end
      object Button10: TButton
        Left = 134
        Top = 51
        Width = 60
        Height = 25
        Hint = 'Insert new layer'
        Caption = 'Ins'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button10Click
      end
      object Button6: TButton
        Left = 134
        Top = 76
        Width = 60
        Height = 25
        Hint = 'Remove layer'
        Caption = 'Del'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 134
        Top = 107
        Width = 60
        Height = 25
        Hint = 'Merge selected layers'
        Caption = 'Merge'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 134
        Top = 153
        Width = 60
        Height = 25
        Hint = 'Move Up'
        Caption = 'Up'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 134
        Top = 178
        Width = 60
        Height = 25
        Hint = 'Move Down'
        Caption = 'Down'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Button9Click
      end
      object GroupBox4: TGroupBox
        Left = 10
        Top = 206
        Width = 166
        Height = 75
        Caption = ' Selected Layer '
        TabOrder = 7
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 68
          Height = 14
          Caption = 'Transparency'
        end
        object TrackBar1: TTrackBar
          Left = 80
          Top = 23
          Width = 74
          Height = 18
          Max = 255
          Frequency = 16
          TabOrder = 0
          OnChange = TrackBar1Change
        end
        object CheckBox1: TCheckBox
          Left = 10
          Top = 50
          Width = 88
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visible'
          TabOrder = 1
          OnClick = CheckBox1Click
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 620
    Width = 809
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 200
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object OpenImageEnDialog1: TOpenImageEnDialog
    Filter = 
      'All graphics|*.tif;*.tiff;*.fax;*.g3n;*.g3f;*.jpg;*.jpeg;*.jpe;*' +
      '.pcx;*.bmp;*.dib;*.rle;*.ico;*.cur;*.png;*.wmf;*.emf;*.tga;*.tar' +
      'ga;*.vda;*.icb;*.vst;*.pix;*.pxm;*.ppm;*.pgm;*.pbm;*.jp2;*.j2k;*' +
      '.jpc;*.j2c;*.avi|TIFF Bitmap (TIF;TIFF;FAX;G3N;G3F)|*.tif;*.tiff' +
      ';*.fax;*.g3n;*.g3f|JPEG Bitmap (JPG;JPEG;JPE)|*.jpg;*.jpeg;*.jpe' +
      '|PaintBrush (PCX)|*.pcx|Windows Bitmap (BMP;DIB;RLE)|*.bmp;*.dib' +
      ';*.rle|Windows Icon (ICO)|*.ico|Windows Cursor (CUR)|*.cur|Porta' +
      'ble Network Graphics (PNG)|*.png|Windows Metafile (WMF)|*.wmf|En' +
      'hanced Windows Metafile (EMF)|*.emf|Targa Bitmap (TGA;TARGA;VDA;' +
      'ICB;VST;PIX)|*.tga;*.targa;*.vda;*.icb;*.vst;*.pix|Portable Pixm' +
      'ap, GreyMap, BitMap (PXM;PPM;PGM;PBM)|*.pxm;*.ppm;*.pgm;*.pbm|JP' +
      'EG2000 (JP2)|*.jp2|JPEG2000 Code Stream (J2K;JPC;J2C)|*.j2k;*.jp' +
      'c;*.j2c|Video for Windows (AVI)|*.avi'
    Left = 26
    Top = 95
  end
end
