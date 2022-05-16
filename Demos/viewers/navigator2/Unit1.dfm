object Form1: TForm1
  Left = 202
  Top = 200
  Width = 785
  Height = 478
  ActiveControl = Button1
  Caption = 'Image EN Navigator Demo 1999-2009 (c) by HiComponents'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 274
    Top = 0
    Width = 9
    Height = 410
    ResizeStyle = rsUpdate
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 410
    Width = 777
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 250
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 274
    Height = 410
    Align = alLeft
    Constraints.MaxWidth = 274
    Constraints.MinWidth = 100
    TabOrder = 1
    DesignSize = (
      274
      410)
    object Label2: TLabel
      Left = 16
      Top = 362
      Width = 26
      Height = 13
      Caption = 'Zoom'
    end
    object Button1: TButton
      Left = 15
      Top = 314
      Width = 75
      Height = 25
      Caption = 'Open'
      TabOrder = 0
      OnClick = Open1Click
    end
    object Button2: TButton
      Left = 105
      Top = 314
      Width = 75
      Height = 25
      Caption = 'Exit'
      TabOrder = 1
      OnClick = Exit1Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 6
      Width = 254
      Height = 172
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Navigator'
      TabOrder = 2
      DesignSize = (
        254
        172)
      object Navigator: TImageEnView
        Left = 9
        Top = 15
        Width = 239
        Height = 148
        ParentCtl3D = False
        BorderStyle = bsNone
        ZoomFilter = rfFastLinear
        BackgroundStyle = iebsCropShadow
        ImageEnVersion = '3.0.3'
        Anchors = [akLeft, akTop, akRight]
        EnableInteractionHints = True
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 186
      Width = 254
      Height = 121
      Caption = 'WARNING'
      TabOrder = 3
      object Panel3: TPanel
        Left = 6
        Top = 18
        Width = 244
        Height = 91
        Alignment = taLeftJustify
        Color = clInfoBk
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 6
          Top = 3
          Width = 235
          Height = 85
          AutoSize = False
          Caption = 
            'Do NOT assign an image to the Navigator... The image in the navi' +
            'gator is automatically assigned from ImageENView2. '#13#10#13#10'See TForm' +
            '1.OnCreate in the pas file:'#13#10'ImageEnView2.SetNavigator ( ImageEn' +
            'View1 );'
          WordWrap = True
        end
      end
    end
    object TrackBar1: TTrackBar
      Left = 56
      Top = 360
      Width = 201
      Height = 33
      Max = 1000
      Min = 10
      Frequency = 50
      Position = 100
      TabOrder = 4
      OnChange = TrackBar1Change
    end
  end
  object Panel2: TPanel
    Left = 283
    Top = 0
    Width = 494
    Height = 410
    Align = alClient
    TabOrder = 2
    object ImageEnView2: TImageEnView
      Left = 1
      Top = 1
      Width = 492
      Height = 408
      ParentCtl3D = False
      MouseInteract = [miZoom, miScroll]
      BackgroundStyle = iebsCropShadow
      OnZoomIn = ImageEnView2ZoomIn
      OnZoomOut = ImageEnView2ZoomOut
      ImageEnVersion = '3.0.3'
      EnableInteractionHints = True
      Align = alClient
      TabOrder = 0
    end
  end
  object OpenImageEnDialog1: TOpenImageEnDialog
    Filter = 
      'All graphics|*.tif;*.tiff;*.fax;*.g3n;*.g3f;*.gif;*.jpg;*.jpeg;*' +
      '.jpe;*.pcx;*.bmp;*.dib;*.rle;*.ico;*.cur;*.png;*.wmf;*.emf;*.tga' +
      ';*.targa;*.vda;*.icb;*.vst;*.pix;*.pxm;*.ppm;*.pgm;*.pbm;*.wbmp;' +
      '*.jp2;*.j2k;*.jpc;*.j2c;*.dcx;*.avi|TIFF Bitmap (TIF;TIFF;FAX;G3' +
      'N;G3F)|*.tif;*.tiff;*.fax;*.g3n;*.g3f|CompuServe Bitmap (GIF)|*.' +
      'gif|JPEG Bitmap (JPG;JPEG;JPE)|*.jpg;*.jpeg;*.jpe|PaintBrush (PC' +
      'X)|*.pcx|Windows Bitmap (BMP;DIB;RLE)|*.bmp;*.dib;*.rle|Windows ' +
      'Icon (ICO)|*.ico|Windows Cursor (CUR)|*.cur|Portable Network Gra' +
      'phics (PNG)|*.png|Windows Metafile (WMF)|*.wmf|Enhanced Windows ' +
      'Metafile (EMF)|*.emf|Targa Bitmap (TGA;TARGA;VDA;ICB;VST;PIX)|*.' +
      'tga;*.targa;*.vda;*.icb;*.vst;*.pix|Portable Pixmap, GrayMap, Bi' +
      'tMap (PXM;PPM;PGM;PBM)|*.pxm;*.ppm;*.pgm;*.pbm|Wireless Bitmap (' +
      'WBMP)|*.wbmp|JPEG2000 (JP2)|*.jp2|JPEG2000 Code Stream (J2K;JPC;' +
      'J2C)|*.j2k;*.jpc;*.j2c|Multipage PCX (DCX)|*.dcx|Video for Windo' +
      'ws (AVI)|*.avi'
    Left = 14
    Top = 87
  end
  object MainMenu1: TMainMenu
    Left = 13
    Top = 60
    object File1: TMenuItem
      Caption = '&File'
      object Open1: TMenuItem
        Caption = '&Open...'
        OnClick = Open1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
  end
  object XPManifest1: TXPManifest
    Left = 13
    Top = 33
  end
end
