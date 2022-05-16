object Form1: TForm1
  Left = 115
  Top = 53
  Width = 882
  Height = 750
  ActiveControl = Navigator1
  Caption = 'Image EN SetExternalBitmap Demo 1999-2004 (c) by HiComponents'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter6: TSplitter
    Left = 214
    Top = 0
    Width = 5
    Height = 679
    Color = clBlack
    ParentColor = False
    ResizeStyle = rsUpdate
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 214
    Height = 679
    Align = alLeft
    BevelOuter = bvNone
    Color = 16244694
    ParentBackground = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    DesignSize = (
      214
      679)
    object GroupBox1: TGroupBox
      Left = 9
      Top = 12
      Width = 185
      Height = 166
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Navigator'
      TabOrder = 0
      DesignSize = (
        185
        166)
      object Navigator1: TImageEnView
        Left = 18
        Top = 18
        Width = 148
        Height = 135
        Background = 16244694
        ParentCtl3D = False
        ZoomFilter = rfFastLinear
        BackgroundStyle = iebsCropShadow
        OnProgress = Navigator1Progress
        ImageEnVersion = '2.2.0'
        Anchors = [akLeft, akTop, akRight, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 12
      Top = 186
      Width = 185
      Height = 61
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'ZoomFilter'
      TabOrder = 1
      DesignSize = (
        185
        61)
      object cbZoomFilter1: TComboBox
        Left = 12
        Top = 24
        Width = 145
        Height = 21
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
        Text = 'rfNone'
        OnChange = cbZoomFilter1Change
        Items.Strings = (
          'None'
          'Triangle'
          'Hermite'
          'Bell'
          'BSplin'
          'Lanczos'
          'Mitchell'
          'Nearest'
          'Linear'
          'FastLinear'
          'Bilinear'
          'Bicubic')
      end
    end
    object Button1: TButton
      Left = 72
      Top = 352
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object Panel10: TPanel
    Left = 219
    Top = 0
    Width = 655
    Height = 679
    Align = alClient
    BevelOuter = bvNone
    Color = 16244694
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    object Splitter3: TSplitter
      Left = 0
      Top = 417
      Width = 655
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Color = clBlack
      ParentColor = False
      ResizeStyle = rsUpdate
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 655
      Height = 417
      Align = alTop
      BevelOuter = bvNone
      Color = 16244694
      TabOrder = 0
      object Splitter2: TSplitter
        Left = 0
        Top = 189
        Width = 655
        Height = 5
        Cursor = crVSplit
        Align = alTop
        Color = clBlack
        ParentColor = False
        ResizeStyle = rsUpdate
      end
      object Panel5: TPanel
        Left = 0
        Top = 194
        Width = 655
        Height = 223
        Align = alClient
        BevelOuter = bvNone
        Color = 16244694
        TabOrder = 0
        object Splitter1: TSplitter
          Left = 318
          Top = 0
          Width = 5
          Height = 223
          Color = clBlack
          ParentColor = False
          ResizeStyle = rsUpdate
        end
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 318
          Height = 223
          Align = alLeft
          BevelOuter = bvNone
          Color = 16244694
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object Label3: TLabel
            Left = 0
            Top = 210
            Width = 318
            Height = 13
            Align = alBottom
            Caption = ' Zoom- 50%'
            Color = 16244694
            FocusControl = ImageEnView3
            ParentColor = False
            Transparent = False
          end
          object ImageEnView3: TImageEnView
            Left = 0
            Top = 0
            Width = 318
            Height = 210
            Background = 16244694
            ParentCtl3D = False
            BorderStyle = bsNone
            MouseInteract = [miZoom, miScroll]
            OnZoomIn = ImageEnView3ZoomIn
            OnZoomOut = ImageEnView3ZoomOut
            OnProgress = ImageEnView3Progress
            ImageEnVersion = '2.2.0'
            Align = alClient
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
        end
        object Panel7: TPanel
          Left = 323
          Top = 0
          Width = 332
          Height = 223
          Align = alClient
          BevelOuter = bvNone
          Color = 16244694
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object Panel9: TPanel
            Left = 327
            Top = 0
            Width = 5
            Height = 223
            Align = alRight
            Caption = 'Panel9'
            Color = clBlack
            ParentBackground = False
            TabOrder = 0
          end
          object Panel12: TPanel
            Left = 0
            Top = 0
            Width = 327
            Height = 223
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Label4: TLabel
              Left = 0
              Top = 210
              Width = 327
              Height = 13
              Align = alBottom
              Caption = ' Zoom- 75%'
              Color = 16244694
              FocusControl = ImageEnView4
              ParentColor = False
              Transparent = False
            end
            object ImageEnView4: TImageEnView
              Left = 0
              Top = 0
              Width = 327
              Height = 210
              Background = 16244694
              ParentCtl3D = False
              BorderStyle = bsNone
              MouseInteract = [miZoom, miScroll]
              OnZoomIn = ImageEnView4ZoomIn
              OnZoomOut = ImageEnView4ZoomOut
              OnProgress = ImageEnView4Progress
              ImageEnVersion = '2.2.0'
              Align = alClient
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
            end
          end
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 655
        Height = 189
        Align = alTop
        BevelOuter = bvNone
        Color = 16244694
        TabOrder = 1
        object Splitter4: TSplitter
          Left = 319
          Top = 0
          Width = 5
          Height = 189
          Align = alRight
          Color = clBlack
          ParentColor = False
          ResizeStyle = rsUpdate
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 319
          Height = 189
          Align = alClient
          BevelOuter = bvNone
          Color = 16244694
          TabOrder = 0
          object Label1: TLabel
            Left = 0
            Top = 176
            Width = 319
            Height = 13
            Align = alBottom
            Caption = ' Zoom- 10%'
            Color = 16244694
            FocusControl = ImageEnView1
            ParentColor = False
            Transparent = False
          end
          object ImageEnView1: TImageEnView
            Left = 0
            Top = 5
            Width = 319
            Height = 171
            Background = 16244694
            ParentCtl3D = False
            BorderStyle = bsNone
            MouseInteract = [miZoom, miScroll]
            OnZoomIn = ImageEnView1ZoomIn
            OnZoomOut = ImageEnView1ZoomOut
            OnProgress = ImageEnView1Progress
            ImageEnVersion = '2.2.0'
            Align = alClient
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
          end
          object Panel15: TPanel
            Left = 0
            Top = 0
            Width = 319
            Height = 5
            Align = alTop
            BevelOuter = bvNone
            Color = clBlack
            ParentBackground = False
            TabOrder = 1
          end
        end
        object Panel4: TPanel
          Left = 324
          Top = 0
          Width = 331
          Height = 189
          Align = alRight
          BevelOuter = bvNone
          Color = 16244694
          TabOrder = 1
          object Panel13: TPanel
            Left = 0
            Top = 0
            Width = 326
            Height = 189
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel13'
            TabOrder = 0
            object Label2: TLabel
              Left = 0
              Top = 176
              Width = 326
              Height = 13
              Align = alBottom
              Caption = ' Zoom- 25%'
              Color = 16244694
              FocusControl = ImageEnView2
              ParentColor = False
              Transparent = False
            end
            object ImageEnView2: TImageEnView
              Left = 0
              Top = 5
              Width = 326
              Height = 171
              Background = 16244694
              ParentCtl3D = False
              BorderStyle = bsNone
              MouseInteract = [miZoom, miScroll]
              OnZoomIn = ImageEnView2ZoomIn
              OnZoomOut = ImageEnView2ZoomOut
              OnProgress = ImageEnView2Progress
              ImageEnVersion = '2.2.0'
              Align = alClient
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
            end
            object Panel16: TPanel
              Left = 0
              Top = 0
              Width = 326
              Height = 5
              Align = alTop
              BevelOuter = bvNone
              Color = clBlack
              ParentBackground = False
              TabOrder = 1
            end
          end
          object Panel14: TPanel
            Left = 326
            Top = 0
            Width = 5
            Height = 189
            Align = alRight
            Color = clBlack
            ParentBackground = False
            TabOrder = 1
          end
        end
      end
    end
    object Panel11: TPanel
      Left = 0
      Top = 422
      Width = 650
      Height = 252
      Align = alClient
      BevelOuter = bvNone
      Color = 16244694
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object Label6: TLabel
        Left = 0
        Top = 239
        Width = 650
        Height = 13
        Align = alBottom
        Caption = ' Zoom- 100%'
        Color = 16244694
        FocusControl = ImageEnView4
        ParentColor = False
        Transparent = False
      end
      object MainView1: TImageEnView
        Left = 0
        Top = 0
        Width = 650
        Height = 239
        Background = 16244694
        ParentCtl3D = False
        BorderStyle = bsNone
        MouseInteract = [miZoom, miScroll]
        OnZoomIn = MainView1ZoomIn
        OnZoomOut = MainView1ZoomOut
        OnProgress = MainView1Progress
        ImageEnVersion = '2.2.0'
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object Panel17: TPanel
      Left = 650
      Top = 422
      Width = 5
      Height = 252
      Align = alRight
      Caption = 'Panel9'
      Color = clBlack
      ParentBackground = False
      TabOrder = 2
    end
    object Panel18: TPanel
      Left = 0
      Top = 674
      Width = 655
      Height = 5
      Align = alBottom
      BevelOuter = bvNone
      Color = clBlack
      ParentBackground = False
      TabOrder = 3
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 679
    Width = 874
    Height = 17
    Align = alBottom
    TabOrder = 2
    Visible = False
  end
  object MainMenu1: TMainMenu
    Left = 15
    Top = 249
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
    Left = 45
    Top = 249
  end
end
