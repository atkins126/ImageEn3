object frmMain: TfrmMain
  Left = 699
  Top = 140
  Width = 441
  Height = 615
  Caption = 'PanZoom Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 389
    Width = 25
    Height = 13
    Caption = 'Start:'
  end
  object Label2: TLabel
    Left = 16
    Top = 421
    Width = 22
    Height = 13
    Caption = 'End:'
  end
  object Label3: TLabel
    Left = 16
    Top = 453
    Width = 45
    Height = 13
    Caption = 'Seconds:'
  end
  object Label4: TLabel
    Left = 132
    Top = 453
    Width = 34
    Height = 13
    Caption = 'Timing:'
  end
  object ieDisplay: TImageEnView
    Left = 16
    Top = 40
    Width = 401
    Height = 305
    ParentCtl3D = False
    ZoomFilter = rfLanczos3
    ScrollBars = ssNone
    ImageEnVersion = '2.2.1a'
    TabOrder = 0
  end
  object btnViewEffect: TButton
    Left = 291
    Top = 472
    Width = 129
    Height = 25
    Caption = 'View Effect'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnViewEffectClick
  end
  object spnStartX1: TSpinEdit
    Left = 68
    Top = 384
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 1038
  end
  object spnStartY1: TSpinEdit
    Left = 124
    Top = 384
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 65
  end
  object spnStartX2: TSpinEdit
    Left = 180
    Top = 384
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 1338
  end
  object spnStartY2: TSpinEdit
    Left = 236
    Top = 384
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 365
  end
  object spnEndY2: TSpinEdit
    Left = 236
    Top = 416
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 870
  end
  object spnEndX2: TSpinEdit
    Left = 180
    Top = 416
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 470
  end
  object spnEndY1: TSpinEdit
    Left = 124
    Top = 416
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 250
  end
  object spnEndX1: TSpinEdit
    Left = 68
    Top = 416
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 9
    Value = 50
  end
  object spnSeconds: TSpinEdit
    Left = 68
    Top = 448
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 10
    Value = 5
  end
  object Memo1: TMemo
    Left = 16
    Top = 512
    Width = 404
    Height = 61
    TabOrder = 11
  end
  object btnBrowseFile: TButton
    Left = 344
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Browse...'
    TabOrder = 12
    OnClick = btnBrowseFileClick
  end
  object cmbPZEffect: TComboBox
    Left = 16
    Top = 352
    Width = 297
    Height = 21
    Style = csDropDownList
    Enabled = False
    ItemHeight = 13
    TabOrder = 13
    OnChange = cmbPZEffectChange
    Items.Strings = (
      'Zoom In (25%)'
      'Zoom In (50%)'
      'Zoom Out (25%)'
      'Zoom Out (50%)'
      'Slide'
      'Reverse Slide'
      'Custom...')
  end
  object cmbFilename: TComboBox
    Left = 16
    Top = 8
    Width = 321
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 14
    OnChange = cmbFilenameChange
  end
  object btnSelectStart: TButton
    Left = 291
    Top = 383
    Width = 61
    Height = 25
    Caption = 'Select'
    TabOrder = 15
    OnClick = btnSelectStartClick
  end
  object bnSelectEnd: TButton
    Left = 291
    Top = 415
    Width = 61
    Height = 25
    Caption = 'Select'
    TabOrder = 16
    OnClick = bnSelectEndClick
  end
  object btnViewStart: TButton
    Left = 359
    Top = 383
    Width = 61
    Height = 25
    Caption = 'View'
    TabOrder = 17
    OnClick = btnViewStartClick
  end
  object btnViewEnd: TButton
    Left = 359
    Top = 415
    Width = 61
    Height = 25
    Caption = 'View'
    TabOrder = 18
    OnClick = btnViewStartClick
  end
  object chkTransitionRectMaintainAspectRatio: TCheckBox
    Left = 16
    Top = 480
    Width = 217
    Height = 17
    Caption = 'Maintain Aspect Ratio'
    Checked = True
    State = cbChecked
    TabOrder = 19
  end
  object cmbTiming: TComboBox
    Left = 172
    Top = 449
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 20
    Items.Strings = (
      'Constant'
      'Exponential'
      'Logarithmic')
  end
  object OpenImageEnDialog1: TOpenImageEnDialog
    Filter = 
      'Common Graphic Files|*.tif;*.gif;*.jpg;*.pcx;*.bmp;*.ico;*.cur;*' +
      '.png;*.wmf;*.emf;*.tga;*.pxm;*.wbmp;*.jp2;*.j2k;*.dcx;*.crw;;*.a' +
      'vi|All Files|*.*|TIFF Bitmap (TIF;TIFF;FAX;G3N;G3F;XIF)|*.tif;*.' +
      'tiff;*.fax;*.g3n;*.g3f;*.xif|CompuServe Bitmap (GIF)|*.gif|JPEG ' +
      'Bitmap (JPG;JPEG;JPE)|*.jpg;*.jpeg;*.jpe|PaintBrush (PCX)|*.pcx|' +
      'Windows Bitmap (BMP;DIB;RLE)|*.bmp;*.dib;*.rle|Windows Icon (ICO' +
      ')|*.ico|Windows Cursor (CUR)|*.cur|Portable Network Graphics (PN' +
      'G)|*.png|Windows Metafile (WMF)|*.wmf|Enhanced Windows Metafile ' +
      '(EMF)|*.emf|Targa Bitmap (TGA;TARGA;VDA;ICB;VST;PIX)|*.tga;*.tar' +
      'ga;*.vda;*.icb;*.vst;*.pix|Portable Pixmap, GrayMap, BitMap (PXM' +
      ';PPM;PGM;PBM)|*.pxm;*.ppm;*.pgm;*.pbm|Wireless Bitmap (WBMP)|*.w' +
      'bmp|JPEG2000 (JP2)|*.jp2|JPEG2000 Code Stream (J2K;JPC;J2C)|*.j2' +
      'k;*.jpc;*.j2c|Multipage PCX (DCX)|*.dcx|Camera RAW (CRW;CR2;NEF;' +
      'RAW;PEF;RAF;X3F;BAY;ORF;SRF;MRW;DCR)|*.crw;*.cr2;*.nef;*.raw;*.p' +
      'ef;*.raf;*.x3f;*.bay;*.orf;*.srf;*.mrw;*.dcr|Video for Windows (' +
      'AVI)|*.avi'
    Left = 680
    Top = 16
  end
end
