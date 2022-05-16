object MainForm: TMainForm
  Left = 373
  Top = 246
  Width = 798
  Height = 598
  Caption = 'DICOM sample - by HiComponents'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 183
    Top = 122
    Height = 406
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 790
    Height = 122
    Align = alTop
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 11
      Top = 87
      Width = 75
      Height = 25
      AllowAllUp = True
      GroupIndex = 1
      Caption = 'Animate'
      OnClick = SpeedButton1Click
    end
    object Button1: TButton
      Left = 11
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Open...'
      TabOrder = 0
      OnClick = Button1Click
    end
    object GroupBox1: TGroupBox
      Left = 104
      Top = 9
      Width = 501
      Height = 105
      Caption = ' DICOM info '
      TabOrder = 1
      object Label2: TLabel
        Left = 13
        Top = 17
        Width = 59
        Height = 13
        Caption = 'Image Type:'
      end
      object Label3: TLabel
        Left = 138
        Top = 17
        Width = 9
        Height = 13
        Caption = '--'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 138
        Top = 35
        Width = 9
        Height = 13
        Caption = '--'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 13
        Top = 35
        Width = 80
        Height = 13
        Caption = 'Acquisition Date:'
      end
      object Label6: TLabel
        Left = 13
        Top = 53
        Width = 80
        Height = 13
        Caption = 'Acquisition Time:'
      end
      object Label7: TLabel
        Left = 138
        Top = 53
        Width = 9
        Height = 13
        Caption = '--'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 13
        Top = 70
        Width = 116
        Height = 13
        Caption = 'Anatomic Region / code'
      end
      object Label9: TLabel
        Left = 138
        Top = 70
        Width = 9
        Height = 13
        Caption = '--'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 138
        Top = 87
        Width = 9
        Height = 13
        Caption = '--'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 13
        Top = 87
        Width = 71
        Height = 13
        Caption = 'Patient'#39's Name'
      end
    end
    object Button2: TButton
      Left = 11
      Top = 41
      Width = 75
      Height = 25
      Caption = 'Save...'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object ImageEnMView1: TImageEnMView
    Left = 0
    Top = 122
    Width = 183
    Height = 406
    ParentCtl3D = False
    ThumbWidth = 150
    ThumbHeight = 150
    OnImageSelect = ImageEnMView1ImageSelect
    GridWidth = -1
    SelectionWidth = 3
    SelectionColor = clRed
    ThumbnailsBorderColor = clBlack
    OnProgress = ImageEnMView1Progress
    OnFinishWork = ImageEnMView1FinishWork
    OnPlayFrame = ImageEnMView1PlayFrame
    ImageEnVersion = '3.1.1'
    Align = alLeft
    TabOrder = 1
  end
  object ImageEnView1: TImageEnView
    Left = 186
    Top = 122
    Width = 604
    Height = 406
    ParentCtl3D = False
    LegacyBitmap = False
    ZoomFilter = rfTriangle
    ImageEnVersion = '3.1.1'
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 0
    Top = 528
    Width = 790
    Height = 41
    Align = alBottom
    TabOrder = 3
    object Label1: TLabel
      Left = 15
      Top = 11
      Width = 27
      Height = 13
      Caption = 'Zoom'
    end
    object TrackBar1: TTrackBar
      Left = 49
      Top = 6
      Width = 150
      Height = 30
      Max = 2000
      Min = 1
      Frequency = 100
      Position = 1
      TabOrder = 0
      OnChange = TrackBar1Change
    end
    object CheckBox1: TCheckBox
      Left = 219
      Top = 12
      Width = 97
      Height = 17
      Caption = 'Filtered'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object ProgressBar1: TProgressBar
      Left = 328
      Top = 8
      Width = 457
      Height = 25
      TabOrder = 2
    end
  end
  object OpenImageEnDialog1: TOpenImageEnDialog
    Filter = 
      'File grafici comuni (*.tif;*.gif;*.jpg;*.pcx;*.bmp;*.ico;*.cur;*' +
      '.png;*.dcm;*.wmf;*.emf;*.tga;*.pxm;*.wbmp;*.jp2;*.j2k;*.dcx;*.cr' +
      'w;*.psd;*.iev;*.lyr;*.all;*.avi;*.mpg;*.wmv)|*.tif;*.gif;*.jpg;*' +
      '.pcx;*.bmp;*.ico;*.cur;*.png;*.dcm;*.wmf;*.emf;*.tga;*.pxm;*.wbm' +
      'p;*.jp2;*.j2k;*.dcx;*.crw;*.psd;*.iev;*.lyr;*.all;*.avi;*.mpg;*.' +
      'wmv|Tutti (*.*)|*.*|TIFF Bitmap (*.tif;*.tiff;*.fax;*.g3n;*.g3f;' +
      '*.xif)|*.tif;*.tiff;*.fax;*.g3n;*.g3f;*.xif|CompuServe Bitmap (*' +
      '.gif)|*.gif|JPEG Bitmap (*.jpg;*.jpeg;*.jpe;*.jif)|*.jpg;*.jpeg;' +
      '*.jpe;*.jif|PaintBrush (*.pcx)|*.pcx|Windows Bitmap (*.bmp;*.dib' +
      ';*.rle)|*.bmp;*.dib;*.rle|Windows Icon (*.ico)|*.ico|Windows Cur' +
      'sor (*.cur)|*.cur|Portable Network Graphics (*.png)|*.png|DICOM ' +
      'Bitmap (*.dcm;*.dic;*.dicom)|*.dcm;*.dic;*.dicom|Windows Metafil' +
      'e (*.wmf)|*.wmf|Enhanced Windows Metafile (*.emf)|*.emf|Targa Bi' +
      'tmap (*.tga;*.targa;*.vda;*.icb;*.vst;*.pix)|*.tga;*.targa;*.vda' +
      ';*.icb;*.vst;*.pix|Portable Pixmap, GrayMap, BitMap (*.pxm;*.ppm' +
      ';*.pgm;*.pbm)|*.pxm;*.ppm;*.pgm;*.pbm|Wireless Bitmap (*.wbmp)|*' +
      '.wbmp|JPEG2000 (*.jp2)|*.jp2|JPEG2000 Code Stream (*.j2k;*.jpc;*' +
      '.j2c)|*.j2k;*.jpc;*.j2c|Multipage PCX (*.dcx)|*.dcx|Camera RAW (' +
      '*.crw;*.cr2;*.nef;*.raw;*.pef;*.raf;*.x3f;*.bay;*.orf;*.srf;*.mr' +
      'w;*.dcr;*.sr2)|*.crw;*.cr2;*.nef;*.raw;*.pef;*.raf;*.x3f;*.bay;*' +
      '.orf;*.srf;*.mrw;*.dcr;*.sr2|Photoshop PSD (*.psd)|*.psd|Vectori' +
      'al objects (*.iev)|*.iev|Layers (*.lyr)|*.lyr|Layers and objects' +
      ' (*.all)|*.all|Video for Windows (*.avi)|*.avi|Mpeg (*.mpeg;*.mp' +
      'g)|*.mpeg;*.mpg|Windows Media Video (*.wmv)|*.wmv'
    FilterIndex = 2
    OnPreviewFile = OpenImageEnDialog1PreviewFile
    Left = 650
    Top = 20
  end
end
