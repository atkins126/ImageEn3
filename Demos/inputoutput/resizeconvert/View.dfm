object frmView: TfrmView
  Left = 185
  Top = 122
  Width = 551
  Height = 343
  Caption = 'View'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ImageEnView: TImageEnView
    Left = 0
    Top = 0
    Width = 543
    Height = 309
    ParentCtl3D = False
    BackgroundStyle = iebsChessboard
    EnableAlphaChannel = True
    Align = alClient
    TabOrder = 0
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
    Left = 36
    Top = 36
  end
end
