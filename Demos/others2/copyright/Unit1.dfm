object Form1: TForm1
  Left = 60
  Top = 11
  Width = 896
  Height = 699
  Caption = 'Add Copyright'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 433
    Top = 0
    Width = 6
    Height = 596
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 439
    Top = 0
    Width = 449
    Height = 596
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 0
    object ImageEnVect: TImageEnVect
      Left = 1
      Top = 1
      Width = 447
      Height = 594
      ParentCtl3D = False
      OnImageChange = ImageEnVectImageChange
      BackgroundStyle = iebsChessboard
      EnableAlphaChannel = True
      OnZoomIn = ImageEnVectZoomIn
      OnZoomOut = ImageEnVectZoomOut
      OnProgress = ImageEnVectProgress
      Align = alClient
      TabOrder = 0
      OnClick = ImageEnVectClick
      OnVectorialChanged = ImageEnVectVectorialChanged
      ObjAntialias = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 613
    Width = 888
    Height = 33
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 1
    object Button3: TButton
      Left = 8
      Top = 4
      Width = 77
      Height = 25
      Hint = 'Close'
      Caption = 'Close'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button3Click
    end
    object ButtonSaveAs: TButton
      Left = 92
      Top = 4
      Width = 77
      Height = 25
      Hint = 'SaveAs...'
      Caption = 'SaveAs...'
      TabOrder = 1
      OnClick = ButtonSaveAsClick
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 596
    Width = 888
    Height = 17
    Align = alBottom
    TabOrder = 2
    Visible = False
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 646
    Width = 888
    Height = 19
    Panels = <
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
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 433
    Height = 596
    Align = alLeft
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 4
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 431
      Height = 406
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object GroupBox2: TGroupBox
        Left = 11
        Top = 5
        Width = 410
        Height = 394
        Caption = 'Source'
        TabOrder = 0
        object Panel5: TPanel
          Left = 12
          Top = 18
          Width = 385
          Height = 369
          BevelOuter = bvNone
          Caption = 'Panel5'
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 194
            Top = 0
            Height = 369
          end
          object ShellTreeView1: TShellTreeView
            Left = 0
            Top = 0
            Width = 194
            Height = 369
            ObjectTypes = [otFolders]
            Root = 'rfDesktop'
            ShellListView = ShellListView1
            UseShellImages = True
            Align = alLeft
            Anchors = [akLeft, akTop, akRight, akBottom]
            AutoRefresh = False
            Indent = 19
            ParentColor = False
            RightClickSelect = True
            ShowRoot = False
            TabOrder = 0
          end
          object ShellListView1: TShellListView
            Left = 197
            Top = 0
            Width = 188
            Height = 369
            ObjectTypes = [otFolders, otNonFolders]
            Root = 'rfDesktop'
            ShellTreeView = ShellTreeView1
            Sorted = True
            Align = alClient
            ReadOnly = False
            HideSelection = False
            MultiSelect = True
            OnChange = ShellListView1Change
            TabOrder = 1
            ViewStyle = vsReport
          end
        end
      end
    end
    object Panel8: TPanel
      Left = 1
      Top = 407
      Width = 431
      Height = 188
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 11
        Top = 0
        Width = 410
        Height = 227
        Caption = 'Copyright'
        TabOrder = 0
        DesignSize = (
          410
          227)
        object CopyrightEdit: TLabeledEdit
          Left = 10
          Top = 32
          Width = 291
          Height = 21
          Hint = 'Edit Copyright EXIF'
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 47
          EditLabel.Height = 13
          EditLabel.Caption = 'Copyright'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnChange = CopyrightEditChange
        end
        object ButtonAddCopyright: TButton
          Left = 306
          Top = 30
          Width = 87
          Height = 25
          Hint = 'Add Copyright'
          Caption = 'Add Copyright'
          TabOrder = 1
          OnClick = ButtonAddCopyrightClick
        end
        object SelectRadioGroup: TRadioGroup
          Left = 9
          Top = 150
          Width = 188
          Height = 67
          Hint = 'View'
          Caption = 'Select'
          ItemIndex = 1
          Items.Strings = (
            'Zoom'
            'Auto Fit'
            'Text')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = SelectRadioGroupClick
        end
        object GroupBox3: TGroupBox
          Left = 208
          Top = 58
          Width = 191
          Height = 87
          Caption = 'Object Options'
          TabOrder = 3
          object CheckBoxUseObjects: TCheckBox
            Left = 8
            Top = 16
            Width = 111
            Height = 17
            Hint = 'Use Objects or GDI Drawing'
            Caption = 'Use Objects'
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 0
            OnClick = CheckBoxUseObjectsClick
          end
          object CheckBoxAddSoftShadow: TCheckBox
            Left = 8
            Top = 34
            Width = 109
            Height = 17
            Caption = 'Add soft shadow'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = CheckBoxAddSoftShadowClick
          end
          object CheckBoxAntialiasText: TCheckBox
            Left = 8
            Top = 52
            Width = 97
            Height = 17
            Hint = 'Antialias Text'
            Caption = 'Antialias Text'
            Checked = True
            ParentShowHint = False
            ShowHint = True
            State = cbChecked
            TabOrder = 2
          end
          object ButtonMerge: TButton
            Left = 118
            Top = 56
            Width = 63
            Height = 25
            Hint = 'Merge'
            Caption = 'Merge'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = ButtonMergeClick
          end
        end
        object GroupBox4: TGroupBox
          Left = 10
          Top = 58
          Width = 187
          Height = 87
          Caption = 'General Options'
          TabOrder = 4
          object Label1: TLabel
            Left = 6
            Top = 60
            Width = 50
            Height = 13
            Caption = 'Text Color'
          end
          object CheckBoxAddFrame: TCheckBox
            Left = 10
            Top = 16
            Width = 157
            Height = 17
            Caption = 'Add frame around the image'
            Checked = True
            State = cbChecked
            TabOrder = 0
          end
          object CheckBoxCopyrightInMargin: TCheckBox
            Left = 10
            Top = 34
            Width = 159
            Height = 17
            Hint = 'Place copyright in the margin'
            Caption = 'Place copyright in the margin'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object ColorBoxTextColor: TColorBox
            Left = 62
            Top = 57
            Width = 111
            Height = 22
            Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbPrettyNames]
            ItemHeight = 16
            TabOrder = 2
            OnChange = ColorBoxTextColorChange
          end
        end
        object Memo1: TMemo
          Left = 208
          Top = 162
          Width = 191
          Height = 49
          Alignment = taCenter
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'MS Shell Dlg 2'
          Font.Style = []
          Lines.Strings = (
            ''
            'Add frame around the image increases'
            'the image width and height by 200 pixels')
          ParentFont = False
          TabOrder = 5
        end
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [fdTrueTypeOnly, fdEffects]
    Left = 28
    Top = 146
  end
  object ColorDialogText: TColorDialog
    Left = 60
    Top = 146
  end
  object ColorDialogShadow: TColorDialog
    Left = 92
    Top = 146
  end
  object XPManifest1: TXPManifest
    Left = 28
    Top = 118
  end
  object SaveImageEnDialog1: TSaveImageEnDialog
    Filter = 
      'JPEG Bitmap (JPG)|*.jpg|TIFF Bitmap (TIF)|*.tif|PaintBrush (PCX)' +
      '|*.pcx|Portable Network Graphics (PNG)|*.png|Windows Bitmap (BMP' +
      ')|*.bmp|OS/2 Bitmap (BMP)|*.bmp|Targa Bitmap (TGA)|*.tga|Portabl' +
      'e PixMap (PXM)|*.pxm|Portable PixMap (PPM)|*.ppm|Portable GreyMa' +
      'p (PGM)|*.pgm|Portable Bitmap (PBM)|*.pbm|JPEG2000 (JP2)|*.jp2|J' +
      'PEG2000 Code Stream (J2K)|*.j2k'
    ExOptions = [sdShowPreview, sdShowAdvanced]
    Left = 60
    Top = 118
  end
end
