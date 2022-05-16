object fPreviews: TfPreviews
  Left = 731
  Top = 199
  Width = 536
  Height = 421
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Previews'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 528
    Height = 387
    Align = alClient
  end
  object Label1: TLabel
    Left = 8
    Top = 1
    Width = 37
    Height = 13
    Caption = 'Source:'
    Transparent = True
  end
  object Label2: TLabel
    Left = 231
    Top = 1
    Width = 33
    Height = 13
    Caption = 'Result:'
    Transparent = True
  end
  object OkButton: TButton
    Left = 432
    Top = 15
    Width = 87
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 432
    Top = 44
    Width = 87
    Height = 23
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 162
    Width = 513
    Height = 207
    ActivePage = TabSheet12
    Anchors = []
    HotTrack = True
    TabOrder = 2
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Tag = 1
      Caption = 'Contrast'
      object Label3: TLabel
        Left = 8
        Top = 12
        Width = 42
        Height = 13
        Caption = '&Contrast:'
        FocusControl = Edit1
      end
      object Label22: TLabel
        Left = 8
        Top = 52
        Width = 52
        Height = 13
        Caption = '&Brightness:'
        FocusControl = Edit21
      end
      object Edit1: TEdit
        Left = 69
        Top = 9
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit1Change
      end
      object TrackBar1: TTrackBar
        Left = 104
        Top = 6
        Width = 345
        Height = 29
        Max = 100
        Min = -100
        Frequency = 10
        TabOrder = 1
        OnChange = TrackBar1Change
      end
      object Edit21: TEdit
        Left = 69
        Top = 49
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '0'
        OnChange = Edit1Change
      end
      object TrackBar12: TTrackBar
        Left = 104
        Top = 46
        Width = 345
        Height = 29
        Max = 100
        Min = -100
        Frequency = 10
        TabOrder = 3
        OnChange = TrackBar1Change
      end
    end
    object TabSheet5: TTabSheet
      Tag = 5
      Caption = 'HSV'
      object Label10: TLabel
        Left = 8
        Top = 12
        Width = 40
        Height = 13
        Caption = '&Hue (H):'
        FocusControl = Edit19
      end
      object Label11: TLabel
        Left = 8
        Top = 40
        Width = 67
        Height = 13
        Caption = '&Saturation (S):'
        FocusControl = Edit18
      end
      object Label12: TLabel
        Left = 8
        Top = 68
        Width = 46
        Height = 13
        Caption = '&Value (V):'
        FocusControl = Edit17
      end
      object Label13: TLabel
        Left = 143
        Top = 93
        Width = 53
        Height = 13
        Caption = 'Base color:'
        ParentShowHint = False
        ShowHint = True
      end
      object Label14: TLabel
        Left = 288
        Top = 93
        Width = 51
        Height = 13
        Caption = 'New color:'
      end
      object Edit17: TEdit
        Left = 92
        Top = 65
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '0'
        OnChange = Edit19Change
      end
      object Edit18: TEdit
        Left = 92
        Top = 37
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = Edit19Change
      end
      object Edit19: TEdit
        Left = 92
        Top = 9
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit19Change
      end
      object TrackBar9: TTrackBar
        Left = 131
        Top = 6
        Width = 320
        Height = 27
        Max = 180
        Min = -180
        Frequency = 10
        TabOrder = 3
        OnChange = TrackBar9Change
      end
      object TrackBar10: TTrackBar
        Left = 131
        Top = 34
        Width = 320
        Height = 27
        Max = 100
        Min = -100
        Frequency = 10
        TabOrder = 4
        OnChange = TrackBar9Change
      end
      object TrackBar11: TTrackBar
        Left = 131
        Top = 62
        Width = 320
        Height = 27
        Max = 100
        Min = -100
        Frequency = 10
        TabOrder = 5
        OnChange = TrackBar9Change
      end
      object Panel3: TPanel
        Left = 142
        Top = 110
        Width = 97
        Height = 59
        BevelOuter = bvLowered
        TabOrder = 6
        object HSVBox3: THSVBox
          Left = 1
          Top = 1
          Width = 95
          Height = 57
          OnChange = HSVBox3Change
          Align = alClient
        end
      end
      object Panel4: TPanel
        Left = 288
        Top = 110
        Width = 98
        Height = 60
        BevelOuter = bvLowered
        TabOrder = 7
        object HSVBox1: THSVBox
          Left = 1
          Top = 1
          Width = 96
          Height = 58
          OnChange = HSVBox3Change
          Align = alClient
        end
      end
    end
    object TabSheet2: TTabSheet
      Tag = 2
      Caption = 'HSL'
      object Label4: TLabel
        Left = 8
        Top = 12
        Width = 40
        Height = 13
        Caption = '&Hue (H):'
        FocusControl = Edit4
      end
      object Label5: TLabel
        Left = 8
        Top = 44
        Width = 67
        Height = 13
        Caption = '&Saturation (S):'
        FocusControl = Edit2
      end
      object Label6: TLabel
        Left = 8
        Top = 76
        Width = 67
        Height = 13
        Caption = '&Luminosity (L):'
        FocusControl = Edit3
      end
      object Edit3: TEdit
        Left = 101
        Top = 73
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '0'
        OnChange = Edit4Change
      end
      object Edit2: TEdit
        Left = 101
        Top = 41
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = Edit4Change
      end
      object Edit4: TEdit
        Left = 101
        Top = 9
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit4Change
      end
      object TrackBar2: TTrackBar
        Left = 139
        Top = 6
        Width = 312
        Height = 29
        Max = 180
        Min = -180
        Frequency = 10
        TabOrder = 3
        OnChange = TrackBar2Change
      end
      object TrackBar3: TTrackBar
        Left = 139
        Top = 38
        Width = 312
        Height = 29
        Max = 100
        Min = -100
        Frequency = 10
        TabOrder = 4
        OnChange = TrackBar2Change
      end
      object TrackBar5: TTrackBar
        Left = 139
        Top = 70
        Width = 312
        Height = 29
        Max = 100
        Min = -100
        Frequency = 10
        TabOrder = 5
        OnChange = TrackBar2Change
      end
    end
    object TabSheet3: TTabSheet
      Tag = 3
      Caption = 'RGB'
      object Label7: TLabel
        Left = 8
        Top = 12
        Width = 40
        Height = 13
        Caption = '&Red (R):'
        FocusControl = Edit7
      end
      object Label8: TLabel
        Left = 8
        Top = 44
        Width = 49
        Height = 13
        Caption = '&Green (G):'
        FocusControl = Edit6
      end
      object Label9: TLabel
        Left = 8
        Top = 76
        Width = 40
        Height = 13
        Caption = '&Blue (B):'
        FocusControl = Edit5
      end
      object Edit5: TEdit
        Left = 72
        Top = 73
        Width = 33
        Height = 21
        TabOrder = 2
        Text = '0'
        OnChange = Edit7Change
      end
      object Edit6: TEdit
        Left = 72
        Top = 41
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = Edit7Change
      end
      object Edit7: TEdit
        Left = 72
        Top = 9
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit7Change
      end
      object TrackBar6: TTrackBar
        Left = 110
        Top = 6
        Width = 333
        Height = 28
        Max = 255
        Min = -255
        Frequency = 10
        TabOrder = 3
        OnChange = TrackBar6Change
      end
      object TrackBar7: TTrackBar
        Left = 110
        Top = 38
        Width = 333
        Height = 28
        Max = 255
        Min = -255
        Frequency = 10
        TabOrder = 4
        OnChange = TrackBar6Change
      end
      object TrackBar8: TTrackBar
        Left = 110
        Top = 70
        Width = 333
        Height = 28
        Max = 255
        Min = -255
        Frequency = 10
        TabOrder = 5
        OnChange = TrackBar6Change
      end
    end
    object TabSheet4: TTabSheet
      Tag = 4
      Caption = 'User filter'
      object GroupBox1: TGroupBox
        Left = 12
        Top = 4
        Width = 357
        Height = 155
        Caption = ' Filter values'
        TabOrder = 0
        object Label15: TLabel
          Left = 208
          Top = 32
          Width = 35
          Height = 13
          Caption = 'Divisor:'
        end
        object Edit8: TEdit
          Left = 10
          Top = 21
          Width = 33
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = Edit8Change
        end
        object Edit9: TEdit
          Tag = 3
          Left = 10
          Top = 48
          Width = 33
          Height = 21
          TabOrder = 1
          Text = '0'
          OnChange = Edit8Change
        end
        object Edit10: TEdit
          Tag = 6
          Left = 10
          Top = 75
          Width = 33
          Height = 21
          TabOrder = 2
          Text = '0'
          OnChange = Edit8Change
        end
        object Edit11: TEdit
          Tag = 1
          Left = 77
          Top = 21
          Width = 33
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = Edit8Change
        end
        object Edit12: TEdit
          Tag = 4
          Left = 77
          Top = 48
          Width = 33
          Height = 21
          TabOrder = 4
          Text = '1'
          OnChange = Edit8Change
        end
        object Edit13: TEdit
          Tag = 7
          Left = 77
          Top = 75
          Width = 33
          Height = 21
          TabOrder = 5
          Text = '0'
          OnChange = Edit8Change
        end
        object Edit14: TEdit
          Tag = 2
          Left = 144
          Top = 21
          Width = 33
          Height = 21
          TabOrder = 6
          Text = '0'
          OnChange = Edit8Change
        end
        object Edit15: TEdit
          Tag = 5
          Left = 144
          Top = 48
          Width = 33
          Height = 21
          TabOrder = 7
          Text = '0'
          OnChange = Edit8Change
        end
        object Edit16: TEdit
          Tag = 8
          Left = 144
          Top = 75
          Width = 33
          Height = 21
          TabOrder = 8
          Text = '0'
          OnChange = Edit8Change
        end
        object UpDown1: TUpDown
          Left = 43
          Top = 21
          Width = 16
          Height = 21
          Associate = Edit8
          Min = -100
          TabOrder = 10
          Thousands = False
        end
        object UpDown2: TUpDown
          Left = 43
          Top = 48
          Width = 16
          Height = 21
          Associate = Edit9
          Min = -100
          TabOrder = 11
          Thousands = False
        end
        object UpDown3: TUpDown
          Left = 43
          Top = 75
          Width = 16
          Height = 21
          Associate = Edit10
          Min = -100
          TabOrder = 12
          Thousands = False
        end
        object UpDown4: TUpDown
          Left = 110
          Top = 21
          Width = 16
          Height = 21
          Associate = Edit11
          Min = -100
          TabOrder = 13
          Thousands = False
        end
        object UpDown5: TUpDown
          Left = 110
          Top = 48
          Width = 16
          Height = 21
          Associate = Edit12
          Min = -100
          Position = 1
          TabOrder = 14
          Thousands = False
        end
        object UpDown6: TUpDown
          Left = 110
          Top = 75
          Width = 16
          Height = 21
          Associate = Edit13
          Min = -100
          TabOrder = 15
          Thousands = False
        end
        object UpDown7: TUpDown
          Left = 177
          Top = 21
          Width = 16
          Height = 21
          Associate = Edit14
          Min = -100
          TabOrder = 16
          Thousands = False
        end
        object UpDown8: TUpDown
          Left = 177
          Top = 48
          Width = 16
          Height = 21
          Associate = Edit15
          Min = -100
          TabOrder = 17
          Thousands = False
        end
        object UpDown9: TUpDown
          Left = 177
          Top = 75
          Width = 16
          Height = 21
          Associate = Edit16
          Min = -100
          TabOrder = 18
          Thousands = False
        end
        object Button4: TButton
          Left = 10
          Top = 118
          Width = 70
          Height = 21
          Caption = '&Load'
          TabOrder = 19
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 90
          Top = 118
          Width = 70
          Height = 21
          Caption = '&Save'
          TabOrder = 20
          OnClick = Button5Click
        end
        object Edit20: TEdit
          Tag = 9
          Left = 208
          Top = 48
          Width = 33
          Height = 21
          TabOrder = 9
          Text = '0'
          OnChange = Edit8Change
        end
        object UpDown10: TUpDown
          Left = 241
          Top = 48
          Width = 16
          Height = 21
          Associate = Edit20
          Min = -100
          TabOrder = 21
          Thousands = False
        end
      end
      object GroupBox3: TGroupBox
        Left = 376
        Top = 4
        Width = 113
        Height = 155
        Caption = ' Presets'
        TabOrder = 1
        object ListBox1: TListBox
          Left = 8
          Top = 18
          Width = 97
          Height = 127
          ItemHeight = 13
          TabOrder = 0
          OnClick = ListBox1Click
        end
      end
    end
    object TabSheet6: TTabSheet
      Tag = 6
      Caption = 'Equalization'
      object Label16: TLabel
        Left = 8
        Top = 148
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label17: TLabel
        Left = 280
        Top = 148
        Width = 18
        Height = 13
        Caption = '255'
      end
      object Label18: TLabel
        Left = 120
        Top = 148
        Width = 47
        Height = 13
        Caption = 'Threshold'
      end
      object Label19: TLabel
        Left = 120
        Top = 4
        Width = 57
        Height = 13
        Caption = 'Equalization'
      end
      object Label20: TLabel
        Left = 8
        Top = 5
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label21: TLabel
        Left = 280
        Top = 5
        Width = 18
        Height = 13
        Caption = '255'
      end
      object SpeedButton3: TSpeedButton
        Left = 326
        Top = 119
        Width = 73
        Height = 25
        AllowAllUp = True
        GroupIndex = 1
        Caption = 'Equalize'
        OnClick = SpeedButton3Click
      end
      object Panel5: TPanel
        Left = 8
        Top = 20
        Width = 293
        Height = 123
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 0
        object RulerBox2: TRulerBox
          Left = 0
          Top = 0
          Width = 289
          Height = 13
          Background = clSilver
          GripsDir = gdDown
          Ruler = False
          DotPerUnit = 1.133333333333333000
          Frequency = 16.000000000000000000
          LabelFreq = 32.000000000000000000
          RulerColor = clGray
          ViewMax = 255.000000000000000000
          MaxGripHeight = 15
          OnRulerPosChange = RulerBox2RulerPosChange
          FitInView = True
          GripsCount = 2
          Align = alTop
        end
        object RulerBox1: TRulerBox
          Left = 0
          Top = 87
          Width = 289
          Height = 32
          Background = clSilver
          DotPerUnit = 1.133333333333330000
          Frequency = 16.000000000000000000
          LabelFreq = 32.000000000000000000
          RulerColor = clSilver
          ViewMax = 255.000000000000000000
          MaxGripHeight = 15
          OnRulerPosChange = RulerBox1RulerPosChange
          GripsCount = 2
          Align = alBottom
        end
        object HistogramBox1: THistogramBox
          Left = 0
          Top = 14
          Width = 289
          Height = 67
          Background = clSilver
          Labels = []
        end
      end
      object GroupBox4: TGroupBox
        Left = 325
        Top = 14
        Width = 74
        Height = 88
        Caption = ' Histogram '
        TabOrder = 1
        object CheckListBox1: TCheckListBox
          Left = 8
          Top = 21
          Width = 57
          Height = 56
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = True
          ItemHeight = 13
          Items.Strings = (
            'Red'
            'Green'
            'Blue'
            'Gray')
          ParentCtl3D = False
          TabOrder = 0
          OnClick = CheckListBox1Click
        end
      end
    end
    object TabSheet7: TTabSheet
      Tag = 7
      Caption = 'Bump map'
      object Label25: TLabel
        Left = 16
        Top = 144
        Width = 125
        Height = 13
        Caption = 'Source image quantity (%):'
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 8
        Width = 481
        Height = 123
        Caption = ' Light '
        TabOrder = 0
        object Label23: TLabel
          Left = 11
          Top = 70
          Width = 31
          Height = 13
          Caption = 'Width:'
        end
        object Label24: TLabel
          Left = 11
          Top = 95
          Width = 34
          Height = 13
          Caption = 'Height:'
        end
        object Label26: TLabel
          Left = 153
          Top = 16
          Width = 27
          Height = 13
          Caption = 'Color:'
        end
        object Label27: TLabel
          Left = 11
          Top = 22
          Width = 21
          Height = 13
          Caption = 'Left:'
        end
        object Label28: TLabel
          Left = 11
          Top = 46
          Width = 22
          Height = 13
          Caption = 'Top:'
        end
        object Panel1: TPanel
          Left = 154
          Top = 34
          Width = 134
          Height = 77
          BevelOuter = bvLowered
          TabOrder = 0
          object HSVBox2: THSVBox
            Left = 1
            Top = 1
            Width = 132
            Height = 75
            OnChange = HSVBox2Change
            Align = alClient
          end
        end
        object Edit22: TEdit
          Left = 67
          Top = 19
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '0'
          OnChange = Edit22Change
        end
        object UpDown11: TUpDown
          Left = 108
          Top = 19
          Width = 16
          Height = 21
          Associate = Edit22
          Max = 32767
          Increment = 10
          TabOrder = 2
          Thousands = False
        end
        object UpDown12: TUpDown
          Left = 108
          Top = 43
          Width = 16
          Height = 21
          Associate = Edit23
          Max = 32767
          Increment = 10
          TabOrder = 3
          Thousands = False
        end
        object Edit23: TEdit
          Left = 67
          Top = 43
          Width = 41
          Height = 21
          TabOrder = 4
          Text = '0'
          OnChange = Edit22Change
        end
        object Edit24: TEdit
          Left = 67
          Top = 67
          Width = 41
          Height = 21
          TabOrder = 5
          Text = '0'
          OnChange = Edit22Change
        end
        object UpDown13: TUpDown
          Left = 108
          Top = 67
          Width = 16
          Height = 21
          Associate = Edit24
          Max = 32767
          Increment = 10
          TabOrder = 6
          Thousands = False
        end
        object Edit25: TEdit
          Left = 67
          Top = 91
          Width = 41
          Height = 21
          TabOrder = 7
          Text = '0'
          OnChange = Edit22Change
        end
        object UpDown14: TUpDown
          Left = 108
          Top = 91
          Width = 16
          Height = 21
          Associate = Edit25
          Max = 32767
          Increment = 10
          TabOrder = 8
          Thousands = False
        end
      end
      object Edit26: TEdit
        Left = 162
        Top = 141
        Width = 32
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = Edit22Change
      end
      object UpDown15: TUpDown
        Left = 194
        Top = 141
        Width = 16
        Height = 21
        Associate = Edit26
        Increment = 10
        TabOrder = 2
        Thousands = False
      end
    end
    object TabSheet8: TTabSheet
      Tag = 8
      Caption = 'Lens'
      object GroupBox5: TGroupBox
        Left = 8
        Top = 8
        Width = 481
        Height = 129
        Caption = ' Lens '
        TabOrder = 0
        object Label29: TLabel
          Left = 11
          Top = 70
          Width = 31
          Height = 13
          Caption = 'Width:'
        end
        object Label30: TLabel
          Left = 11
          Top = 95
          Width = 34
          Height = 13
          Caption = 'Height:'
        end
        object Label32: TLabel
          Left = 11
          Top = 22
          Width = 21
          Height = 13
          Caption = 'Left:'
        end
        object Label33: TLabel
          Left = 11
          Top = 46
          Width = 22
          Height = 13
          Caption = 'Top:'
        end
        object Label31: TLabel
          Left = 147
          Top = 22
          Width = 52
          Height = 13
          Caption = 'Refraction:'
        end
        object Edit27: TEdit
          Left = 67
          Top = 19
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = Edit27Change
        end
        object UpDown16: TUpDown
          Left = 108
          Top = 19
          Width = 16
          Height = 21
          Associate = Edit27
          Max = 32767
          Increment = 10
          TabOrder = 1
          Thousands = False
        end
        object UpDown17: TUpDown
          Left = 108
          Top = 43
          Width = 16
          Height = 21
          Associate = Edit28
          Max = 32767
          Increment = 10
          TabOrder = 2
          Thousands = False
        end
        object Edit28: TEdit
          Left = 67
          Top = 43
          Width = 41
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = Edit27Change
        end
        object Edit29: TEdit
          Left = 67
          Top = 67
          Width = 41
          Height = 21
          TabOrder = 4
          Text = '0'
          OnChange = Edit27Change
        end
        object UpDown18: TUpDown
          Left = 108
          Top = 67
          Width = 16
          Height = 21
          Associate = Edit29
          Max = 32767
          Increment = 10
          TabOrder = 5
          Thousands = False
        end
        object Edit30: TEdit
          Left = 67
          Top = 91
          Width = 41
          Height = 21
          TabOrder = 6
          Text = '0'
          OnChange = Edit27Change
        end
        object UpDown19: TUpDown
          Left = 108
          Top = 91
          Width = 16
          Height = 21
          Associate = Edit30
          Max = 32767
          Increment = 10
          TabOrder = 7
          Thousands = False
        end
        object UpDown20: TUpDown
          Left = 250
          Top = 19
          Width = 16
          Height = 21
          Associate = Edit31
          Max = 32767
          TabOrder = 8
          Thousands = False
        end
        object Edit31: TEdit
          Left = 209
          Top = 19
          Width = 41
          Height = 21
          TabOrder = 9
          Text = '0'
          OnChange = Edit27Change
        end
      end
    end
    object TabSheet9: TTabSheet
      Tag = 9
      Caption = 'Wave'
      object GroupBox6: TGroupBox
        Left = 8
        Top = 8
        Width = 481
        Height = 150
        Caption = ' Wave '
        TabOrder = 0
        object Label34: TLabel
          Left = 12
          Top = 22
          Width = 49
          Height = 13
          Caption = 'Amplitude:'
        end
        object Label35: TLabel
          Left = 12
          Top = 54
          Width = 64
          Height = 13
          Caption = 'Wave length:'
        end
        object Label36: TLabel
          Left = 12
          Top = 86
          Width = 33
          Height = 13
          Caption = 'Phase:'
        end
        object Edit32: TEdit
          Left = 128
          Top = 19
          Width = 41
          Height = 21
          TabOrder = 0
          Text = '0'
          OnChange = Edit32Change
        end
        object UpDown21: TUpDown
          Left = 169
          Top = 19
          Width = 16
          Height = 21
          Associate = Edit32
          Max = 32767
          TabOrder = 1
          Thousands = False
        end
        object UpDown22: TUpDown
          Left = 169
          Top = 51
          Width = 16
          Height = 21
          Associate = Edit33
          Max = 32767
          TabOrder = 2
          Thousands = False
        end
        object Edit33: TEdit
          Left = 128
          Top = 51
          Width = 41
          Height = 21
          TabOrder = 3
          Text = '0'
          OnChange = Edit32Change
        end
        object Edit34: TEdit
          Left = 128
          Top = 83
          Width = 41
          Height = 21
          TabOrder = 4
          Text = '0'
          OnChange = Edit32Change
        end
        object UpDown23: TUpDown
          Left = 169
          Top = 83
          Width = 16
          Height = 21
          Associate = Edit34
          Max = 359
          TabOrder = 5
          Thousands = False
        end
        object CheckBox2: TCheckBox
          Left = 10
          Top = 118
          Width = 129
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Reflective'
          TabOrder = 6
          OnClick = Edit32Change
        end
      end
    end
    object TabSheet10: TTabSheet
      Tag = 10
      Caption = 'Morph filters'
      object GroupBox7: TGroupBox
        Left = 8
        Top = 8
        Width = 481
        Height = 161
        Caption = ' Morph filters '
        TabOrder = 0
        object Label37: TLabel
          Left = 8
          Top = 24
          Width = 25
          Height = 13
          Caption = 'Filter:'
        end
        object Label38: TLabel
          Left = 184
          Top = 24
          Width = 63
          Height = 13
          Caption = 'Window size:'
        end
        object ListBox2: TListBox
          Left = 56
          Top = 24
          Width = 113
          Height = 81
          ItemHeight = 13
          TabOrder = 0
          OnClick = Edit35Change
        end
        object Edit35: TEdit
          Left = 280
          Top = 21
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '1'
          OnChange = Edit35Change
        end
        object UpDown24: TUpDown
          Left = 321
          Top = 21
          Width = 16
          Height = 21
          Associate = Edit35
          Min = 1
          Max = 64
          Position = 1
          TabOrder = 2
          Thousands = False
        end
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Rotate'
      object LabelRotate: TLabel
        Left = 8
        Top = 23
        Width = 35
        Height = 13
        Caption = '&Rotate:'
        FocusControl = EditRotate
      end
      object Label46: TLabel
        Left = 8
        Top = 68
        Width = 19
        Height = 13
        Caption = 'Flip:'
      end
      object TrackBarRotate: TTrackBar
        Left = 128
        Top = 17
        Width = 312
        Height = 31
        Max = 18000
        Min = -18000
        Frequency = 500
        TabOrder = 0
        OnChange = TrackBarRotateChange
      end
      object EditRotate: TEdit
        Left = 77
        Top = 20
        Width = 52
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = EditRotateChange
      end
      object CheckBox3: TCheckBox
        Left = 78
        Top = 68
        Width = 109
        Height = 17
        Caption = 'Horizontally'
        TabOrder = 2
        OnClick = SpeedButtonFlipHorClick
      end
      object CheckBox4: TCheckBox
        Left = 78
        Top = 93
        Width = 109
        Height = 17
        Caption = 'Vertically'
        TabOrder = 3
        OnClick = SpeedButtonFlipHorClick
      end
    end
    object TabSheet12: TTabSheet
      Caption = 'FFT'
      object GroupBox8: TGroupBox
        Left = 8
        Top = 8
        Width = 233
        Height = 163
        Caption = ' Frequency domain image '
        TabOrder = 0
        object ImageEnView1: TImageEnView
          Left = 2
          Top = 15
          Width = 229
          Height = 136
          ParentCtl3D = False
          BorderStyle = bsNone
          MouseInteract = [miZoom, miSelect]
          SelectionBase = iesbBitmap
          ImageEnVersion = '3.1.1'
          EnableInteractionHints = True
          Align = alClient
          TabOrder = 0
        end
        object ProgressBar1: TProgressBar
          Left = 2
          Top = 151
          Width = 229
          Height = 10
          Align = alBottom
          TabOrder = 1
        end
      end
      object Clear: TButton
        Left = 249
        Top = 13
        Width = 75
        Height = 25
        Caption = 'Clear'
        TabOrder = 1
        OnClick = ClearClick
      end
      object Button7: TButton
        Left = 249
        Top = 45
        Width = 75
        Height = 25
        Caption = 'Reset'
        TabOrder = 2
        OnClick = Button7Click
      end
      object CheckBox1: TCheckBox
        Left = 251
        Top = 85
        Width = 97
        Height = 17
        Caption = 'Gray scale'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = CheckBox1Click
      end
    end
    object tabGamma: TTabSheet
      Caption = 'Gamma Correction'
      object Label39: TLabel
        Left = 8
        Top = 28
        Width = 90
        Height = 13
        Caption = 'Gamma Correction:'
        FocusControl = edtGamma
      end
      object Label41: TLabel
        Left = 461
        Top = 60
        Width = 18
        Height = 13
        Caption = '255'
      end
      object Label42: TLabel
        Left = 111
        Top = 153
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label40: TLabel
        Left = 120
        Top = 61
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label43: TLabel
        Left = 100
        Top = 75
        Width = 18
        Height = 13
        Caption = '255'
      end
      object GroupBox9: TGroupBox
        Left = 8
        Top = 72
        Width = 74
        Height = 83
        Caption = 'Channels'
        TabOrder = 0
        object cbxGamma: TCheckListBox
          Left = 8
          Top = 24
          Width = 57
          Height = 44
          BorderStyle = bsNone
          Color = clBtnFace
          Ctl3D = True
          ItemHeight = 13
          Items.Strings = (
            'Red'
            'Green'
            'Blue')
          ParentCtl3D = False
          TabOrder = 0
          OnClick = cbxGammaClick
        end
      end
      object edtGamma: TEdit
        Left = 104
        Top = 24
        Width = 41
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
        Text = '0'
      end
      object trkGamma: TTrackBar
        Left = 147
        Top = 24
        Width = 334
        Height = 29
        Max = 100
        Min = 1
        Frequency = 10
        Position = 1
        TabOrder = 2
        OnChange = trkGammaChange
      end
      object ImageEnView2: TImageEnView
        Left = 120
        Top = 77
        Width = 361
        Height = 90
        Ctl3D = False
        ParentCtl3D = False
        ImageEnVersion = '3.1.1'
        EnableInteractionHints = True
        TabOrder = 3
      end
    end
    object TabSheet14: TTabSheet
      Caption = 'Sharpen'
      object Label44: TLabel
        Left = 8
        Top = 12
        Width = 49
        Height = 13
        Caption = 'Amplitude:'
        FocusControl = Edit36
      end
      object Label45: TLabel
        Left = 8
        Top = 74
        Width = 63
        Height = 13
        Caption = 'Window size:'
      end
      object Edit36: TEdit
        Left = 8
        Top = 32
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit36Change
      end
      object TrackBar4: TTrackBar
        Left = 47
        Top = 34
        Width = 442
        Height = 28
        Max = 50
        Min = 1
        Position = 1
        TabOrder = 1
        OnChange = TrackBar4Change
      end
      object Edit37: TEdit
        Left = 7
        Top = 92
        Width = 41
        Height = 21
        TabOrder = 2
        Text = '1'
        OnChange = TrackBar4Change
      end
      object UpDown25: TUpDown
        Left = 48
        Top = 92
        Width = 16
        Height = 21
        Associate = Edit37
        Min = 1
        Max = 64
        Position = 1
        TabOrder = 3
        Thousands = False
      end
    end
  end
  object ResultToSourceButton: TButton
    Left = 207
    Top = 70
    Width = 21
    Height = 25
    Hint = 'Copy Result to Source'
    Caption = '<<'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = ResultToSourceButtonClick
  end
  object PreviewButton: TButton
    Left = 432
    Top = 84
    Width = 87
    Height = 23
    Anchors = [akTop, akRight]
    Caption = '&Preview'
    TabOrder = 4
    OnClick = PreviewButtonClick
  end
  object ImageEn1: TImageEnView
    Left = 9
    Top = 17
    Width = 191
    Height = 135
    Cursor = 1782
    ParentCtl3D = False
    OnViewChange = ImageEn1ViewChange
    MouseInteract = [miZoom, miScroll]
    ImageEnVersion = '3.1.1'
    EnableInteractionHints = True
    TabOrder = 5
  end
  object ImageEn2: TImageEnView
    Left = 233
    Top = 17
    Width = 191
    Height = 135
    Cursor = 1780
    ParentCtl3D = False
    ImageEnVersion = '3.1.1'
    EnableInteractionHints = True
    TabOrder = 6
    OnMouseDown = ImageEn2MouseUp
    OnMouseUp = ImageEn2MouseUp
  end
  object chkLockPreview: TCheckBox
    Left = 11
    Top = 369
    Width = 211
    Height = 17
    Hint = 
      'Automatically updates your preview with the changes you have sel' +
      'ected'
    Anchors = [akLeft, akBottom]
    Caption = 'Lock Preview'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = SpeedButton1Click
  end
  object ResetButton: TButton
    Left = 432
    Top = 113
    Width = 87
    Height = 23
    Anchors = [akTop, akRight]
    Caption = 'Reset'
    TabOrder = 8
    OnClick = ResetButtonClick
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'flt'
    Filter = 'Filter (*.flt)|*.flt'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist]
    Title = 'Load filter'
    Left = 336
    Top = 59
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'flt'
    Filter = 'Filter (*.flt)|*.flt'
    Options = [ofHideReadOnly, ofPathMustExist]
    Title = 'Save filter'
    Left = 264
    Top = 58
  end
  object ImageEnProc2: TImageEnProc
    AttachedImageEn = ImageEnView1
    Background = clBtnFace
    OnProgress = ImageEnProc2Progress
    PreviewsParams = [prppShowResetButton, prppHardReset]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clWindowText
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    Left = 260
    Top = 264
  end
end
