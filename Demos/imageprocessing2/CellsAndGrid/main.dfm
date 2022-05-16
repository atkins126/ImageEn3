object Form1: TForm1
  Left = 165
  Top = 78
  Width = 702
  Height = 624
  Caption = 'Draw Grid and Selected/Deselected Cells'
  Color = clBtnFace
  TransparentColorValue = clFuchsia
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 238
    Top = 0
    Width = 5
    Height = 590
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 238
    Height = 590
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      238
      590)
    object Button2: TButton
      Left = 6
      Top = 354
      Width = 127
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Load Background Image'
      TabOrder = 0
      OnClick = Button2Click
    end
    object GroupBox1: TGroupBox
      Left = 9
      Top = 12
      Width = 214
      Height = 331
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Options'
      TabOrder = 1
      DesignSize = (
        214
        331)
      object Label1: TLabel
        Left = 9
        Top = 18
        Width = 26
        Height = 13
        Caption = 'Rows'
      end
      object Label2: TLabel
        Left = 9
        Top = 60
        Width = 40
        Height = 13
        Caption = 'Columns'
      end
      object Label3: TLabel
        Left = 9
        Top = 105
        Width = 47
        Height = 13
        Caption = 'Grid Color'
      end
      object Label6: TLabel
        Left = 9
        Top = 255
        Width = 39
        Height = 13
        Caption = 'Column:'
      end
      object Label7: TLabel
        Left = 9
        Top = 270
        Width = 25
        Height = 13
        Caption = 'Row:'
      end
      object Bevel1: TBevel
        Left = 75
        Top = 42
        Width = 10
        Height = 43
        Shape = bsRightLine
      end
      object Label5: TLabel
        Left = 9
        Top = 219
        Width = 39
        Height = 13
        Caption = 'Column:'
      end
      object Label8: TLabel
        Left = 9
        Top = 234
        Width = 25
        Height = 13
        Caption = 'Row:'
      end
      object Label9: TLabel
        Left = 9
        Top = 309
        Width = 70
        Height = 13
        Caption = 'Selected Cells:'
      end
      object Bevel2: TBevel
        Left = 51
        Top = 42
        Width = 31
        Height = 10
        Shape = bsTopLine
      end
      object Bevel3: TBevel
        Left = 51
        Top = 75
        Width = 31
        Height = 10
        Shape = bsBottomLine
      end
      object Label4: TLabel
        Left = 9
        Top = 294
        Width = 26
        Height = 13
        Caption = 'Cells:'
      end
      object Label10: TLabel
        Left = 12
        Top = 153
        Width = 44
        Height = 13
        Caption = 'Font Size'
      end
      object Label11: TLabel
        Left = 72
        Top = 156
        Width = 22
        Height = 13
        Caption = 'Font'
      end
      object Edit1: TEdit
        Left = 9
        Top = 33
        Width = 49
        Height = 21
        TabOrder = 0
        Text = '6'
        OnChange = Edit1Change
      end
      object UpDownRows: TUpDown
        Left = 58
        Top = 33
        Width = 16
        Height = 21
        Associate = Edit1
        Min = 2
        Position = 6
        TabOrder = 1
      end
      object Edit2: TEdit
        Left = 9
        Top = 75
        Width = 49
        Height = 21
        TabOrder = 2
        Text = '6'
        OnChange = Edit2Change
      end
      object UpDownColumns: TUpDown
        Left = 58
        Top = 75
        Width = 16
        Height = 21
        Associate = Edit2
        Min = 2
        Position = 6
        TabOrder = 3
      end
      object ColorBoxGrid: TColorBox
        Left = 9
        Top = 120
        Width = 163
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 16
        TabOrder = 4
        OnChange = ColorBoxGridChange
      end
      object CheckBoxProportional: TCheckBox
        Left = 78
        Top = 54
        Width = 79
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Proportional'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object FontSizeEdit: TEdit
        Left = 12
        Top = 168
        Width = 37
        Height = 21
        TabOrder = 6
        Text = '60'
      end
      object FontSizeUpDown: TUpDown
        Left = 49
        Top = 168
        Width = 16
        Height = 21
        Associate = FontSizeEdit
        Min = 8
        Max = 400
        Position = 60
        TabOrder = 7
      end
      object FontComboBox: TComboBox
        Left = 72
        Top = 168
        Width = 127
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 8
      end
      object NegativeCheckBox: TCheckBox
        Left = 9
        Top = 198
        Width = 97
        Height = 17
        Caption = 'Negative'
        TabOrder = 9
      end
    end
    object Button3: TButton
      Left = 9
      Top = 384
      Width = 75
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Clear'
      TabOrder = 2
      OnClick = Button3Click
    end
    object ImageENView2: TImageEnView
      Left = 9
      Top = 417
      Width = 217
      Height = 163
      ParentCtl3D = False
      AutoFit = True
      ImageEnVersion = '2.1.8'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object Button4: TButton
      Left = 90
      Top = 384
      Width = 75
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Save'
      TabOrder = 4
      OnClick = Button4Click
    end
  end
  object ImageENView1: TImageEnView
    Left = 243
    Top = 0
    Width = 451
    Height = 590
    Hint = 'Left Click: Select'#13#10'Right Click: Deselect'
    ParentCtl3D = False
    Center = False
    AutoFit = True
    SelectionBase = iesbBitmap
    OnDrawBackBuffer = ImageENView1DrawBackBuffer
    ImageEnVersion = '2.1.8'
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnMouseDown = ImageENView1MouseDown
    OnMouseMove = ImageENView1MouseMove
    OnMouseUp = ImageENView1MouseUp
  end
  object OpenImageEnDialog1: TOpenImageEnDialog
    Filter = 
      'All graphics|*.tif;*.tiff;*.fax;*.g3n;*.g3f;*.gif;*.jpg;*.jpeg;*' +
      '.jpe;*.pcx;*.bmp;*.dib;*.rle;*.ico;*.cur;*.png;*.wmf;*.emf;*.tga' +
      ';*.targa;*.vda;*.icb;*.vst;*.pix;*.pxm;*.ppm;*.pgm;*.pbm;*.wbmp;' +
      '*.jp2;*.j2k;*.jpc;*.j2c;*.dcx;*.crw;*.cr2;*.nef;*.raw;*.pef;*.ra' +
      'f;*.x3f;*.bay;*.orf;*.mrw;*.srf;*.mrw;*.avi|TIFF Bitmap (TIF;TIF' +
      'F;FAX;G3N;G3F)|*.tif;*.tiff;*.fax;*.g3n;*.g3f|CompuServe Bitmap ' +
      '(GIF)|*.gif|JPEG Bitmap (JPG;JPEG;JPE)|*.jpg;*.jpeg;*.jpe|PaintB' +
      'rush (PCX)|*.pcx|Windows Bitmap (BMP;DIB;RLE)|*.bmp;*.dib;*.rle|' +
      'Windows Icon (ICO)|*.ico|Windows Cursor (CUR)|*.cur|Portable Net' +
      'work Graphics (PNG)|*.png|Windows Metafile (WMF)|*.wmf|Enhanced ' +
      'Windows Metafile (EMF)|*.emf|Targa Bitmap (TGA;TARGA;VDA;ICB;VST' +
      ';PIX)|*.tga;*.targa;*.vda;*.icb;*.vst;*.pix|Portable Pixmap, Gra' +
      'yMap, BitMap (PXM;PPM;PGM;PBM)|*.pxm;*.ppm;*.pgm;*.pbm|Wireless ' +
      'Bitmap (WBMP)|*.wbmp|JPEG2000 (JP2)|*.jp2|JPEG2000 Code Stream (' +
      'J2K;JPC;J2C)|*.j2k;*.jpc;*.j2c|Multipage PCX (DCX)|*.dcx|Camera ' +
      'RAW (CRW;CR2;NEF;RAW;PEF;RAF;X3F;BAY;ORF;MRW;SRF;MRW)|*.crw;*.cr' +
      '2;*.nef;*.raw;*.pef;*.raf;*.x3f;*.bay;*.orf;*.mrw;*.srf;*.mrw|Vi' +
      'deo for Windows (AVI)|*.avi'
    Options = [ofHideReadOnly, ofEnableSizing]
    Left = 48
    Top = 444
  end
  object XPManifest1: TXPManifest
    Left = 15
    Top = 444
  end
  object SaveImageEnDialog1: TSaveImageEnDialog
    Filter = 
      'JPEG Bitmap (JPG)|*.jpg|CompuServe Bitmap (GIF)|*.gif|TIFF Bitma' +
      'p (TIF)|*.tif|PaintBrush (PCX)|*.pcx|Portable Network Graphics (' +
      'PNG)|*.png|Windows Bitmap (BMP)|*.bmp|OS/2 Bitmap (BMP)|*.bmp|Ta' +
      'rga Bitmap (TGA)|*.tga|Portable PixMap (PXM)|*.pxm|Portable PixM' +
      'ap (PPM)|*.ppm|Portable GreyMap (PGM)|*.pgm|Portable Bitmap (PBM' +
      ')|*.pbm|JPEG2000 (JP2)|*.jp2|JPEG2000 Code Stream (J2K)|*.j2k|Mu' +
      'ltipage PCX (DCX)|*.dcx'
    ExOptions = [sdShowPreview, sdShowAdvanced]
    Left = 82
    Top = 444
  end
end
