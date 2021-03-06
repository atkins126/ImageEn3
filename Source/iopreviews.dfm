object fIOPreviews: TfIOPreviews
  Left = 518
  Top = 336
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Parameters preview'
  ClientHeight = 425
  ClientWidth = 527
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
    Width = 527
    Height = 425
    Align = alClient
  end
  object Label1: TLabel
    Left = 5
    Top = 1
    Width = 37
    Height = 13
    Caption = 'Source:'
    Transparent = True
  end
  object Label2: TLabel
    Left = 227
    Top = 1
    Width = 33
    Height = 13
    Caption = 'Result:'
    Transparent = True
  end
  object Button1: TButton
    Left = 432
    Top = 15
    Width = 87
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 432
    Top = 43
    Width = 87
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 172
    Width = 417
    Height = 217
    ActivePage = TabSheetTIFF1
    HotTrack = True
    TabOrder = 2
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    object TabSheetJPEG1: TTabSheet
      Caption = 'JPEG'
      object Label23: TLabel
        Left = 16
        Top = 8
        Width = 35
        Height = 13
        Caption = '&Quality:'
        FocusControl = Edit22
      end
      object Label24: TLabel
        Left = 208
        Top = 141
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label25: TLabel
        Left = 209
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label3: TLabel
        Left = 16
        Top = 141
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label4: TLabel
        Left = 16
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Edit22: TEdit
        Left = 77
        Top = 5
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit22Change
      end
      object TrackBar13: TTrackBar
        Left = 128
        Top = 6
        Width = 275
        Height = 19
        Max = 100
        Frequency = 5
        TabOrder = 1
        OnChange = TrackBar13Change
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 43
        Width = 388
        Height = 84
        Caption = ' Advanced '
        TabOrder = 2
        object Label26: TLabel
          Left = 8
          Top = 20
          Width = 63
          Height = 13
          Caption = '&DCT method:'
        end
        object Label27: TLabel
          Left = 8
          Top = 48
          Width = 83
          Height = 13
          Caption = '&Smoothing factor:'
        end
        object Label57: TLabel
          Left = 240
          Top = 20
          Width = 59
          Height = 13
          Caption = 'P&hotometric:'
        end
        object CheckBox2: TCheckBox
          Left = 238
          Top = 42
          Width = 121
          Height = 17
          Alignment = taLeftJustify
          Caption = '&Optimal Huffman'
          TabOrder = 0
          OnClick = TrackBar13Change
        end
        object ComboBox1: TComboBox
          Left = 114
          Top = 17
          Width = 109
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
          OnChange = TrackBar13Change
          Items.Strings = (
            'ISLOW'
            'IFAST'
            'FLOAT')
        end
        object Edit23: TEdit
          Left = 114
          Top = 45
          Width = 37
          Height = 21
          TabOrder = 2
          Text = '0'
          OnChange = Edit22Change
        end
        object UpDown11: TUpDown
          Left = 151
          Top = 45
          Width = 16
          Height = 21
          Associate = Edit23
          TabOrder = 3
        end
        object CheckBox3: TCheckBox
          Left = 238
          Top = 60
          Width = 121
          Height = 17
          Alignment = taLeftJustify
          Caption = 'P&rogressive'
          TabOrder = 4
          OnClick = TrackBar13Change
        end
        object ComboBox13: TComboBox
          Left = 306
          Top = 17
          Width = 78
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 5
          OnChange = TrackBar13Change
          Items.Strings = (
            'RGB'
            'GrayScale'
            'YCbCr'
            'CMYK'
            'YCbCrK')
        end
      end
    end
    object TabSheetJPEG2: TTabSheet
      Caption = 'JPEG'
      object Label72: TLabel
        Left = 16
        Top = 8
        Width = 35
        Height = 13
        Caption = '&Quality:'
        FocusControl = Edit16
      end
      object Label73: TLabel
        Left = 16
        Top = 61
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label74: TLabel
        Left = 16
        Top = 77
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label75: TLabel
        Left = 208
        Top = 61
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label76: TLabel
        Left = 209
        Top = 77
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Edit16: TEdit
        Left = 77
        Top = 5
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit16Change
      end
      object TrackBar2: TTrackBar
        Left = 128
        Top = 6
        Width = 275
        Height = 19
        Max = 100
        Frequency = 5
        TabOrder = 1
        OnChange = TrackBar2Change
      end
    end
    object TabSheetTIFF1: TTabSheet
      Caption = 'TIFF'
      object Label5: TLabel
        Left = 15
        Top = 8
        Width = 63
        Height = 13
        Caption = '&Compression:'
      end
      object Label6: TLabel
        Left = 236
        Top = 8
        Width = 60
        Height = 13
        Caption = '&Image index:'
      end
      object Label7: TLabel
        Left = 15
        Top = 32
        Width = 59
        Height = 13
        Caption = 'P&hotometric:'
      end
      object Label19: TLabel
        Left = 236
        Top = 32
        Width = 32
        Height = 13
        Caption = 'C&olors:'
      end
      object Label9: TLabel
        Left = 16
        Top = 149
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label11: TLabel
        Left = 16
        Top = 165
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label17: TLabel
        Left = 208
        Top = 149
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label18: TLabel
        Left = 209
        Top = 165
        Width = 9
        Height = 13
        Caption = '---'
      end
      object ComboBox2: TComboBox
        Left = 95
        Top = 5
        Width = 127
        Height = 21
        Style = csDropDownList
        Ctl3D = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 0
        OnChange = ComboBox2Click
      end
      object Edit1: TEdit
        Left = 324
        Top = 5
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = ComboBox2Click
      end
      object UpDown1: TUpDown
        Left = 357
        Top = 5
        Width = 16
        Height = 21
        Associate = Edit1
        Max = 1000
        TabOrder = 2
        Thousands = False
      end
      object ComboBox3: TComboBox
        Left = 95
        Top = 30
        Width = 127
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 3
        OnChange = ComboBox2Click
        Items.Strings = (
          'WHITEISZERO/Gray'
          'BLACKISZERO/Gray'
          'RGB'
          'RGBPALETTE'
          'TRANSPMASK'
          'CMYK'
          'YCBCR'
          'CIELAB')
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 55
        Width = 401
        Height = 91
        Caption = ' Scanned document info '
        TabOrder = 4
        object Label8: TLabel
          Left = 8
          Top = 67
          Width = 99
          Height = 13
          Caption = 'H&oriz. Position (inch):'
        end
        object Label10: TLabel
          Left = 182
          Top = 67
          Width = 94
          Height = 13
          Caption = '&Vert. Position (inch):'
        end
        object Label12: TLabel
          Left = 8
          Top = 19
          Width = 31
          Height = 13
          Caption = '&Name:'
        end
        object Label13: TLabel
          Left = 182
          Top = 19
          Width = 56
          Height = 13
          Caption = '&Description:'
        end
        object Label14: TLabel
          Left = 8
          Top = 44
          Width = 57
          Height = 13
          Caption = 'P&age name:'
        end
        object Label15: TLabel
          Left = 182
          Top = 44
          Width = 68
          Height = 13
          Caption = 'Page N&umber:'
        end
        object Label16: TLabel
          Left = 334
          Top = 44
          Width = 9
          Height = 13
          Caption = 'o&f'
        end
        object Edit2: TEdit
          Left = 124
          Top = 64
          Width = 49
          Height = 21
          TabOrder = 5
          OnChange = ComboBox2Click
        end
        object Edit3: TEdit
          Left = 292
          Top = 63
          Width = 49
          Height = 21
          TabOrder = 6
          OnChange = ComboBox2Click
        end
        object Edit4: TEdit
          Left = 68
          Top = 16
          Width = 105
          Height = 21
          TabOrder = 0
          OnChange = ComboBox2Click
        end
        object Edit5: TEdit
          Left = 251
          Top = 15
          Width = 139
          Height = 21
          TabOrder = 1
          OnChange = ComboBox2Click
        end
        object Edit6: TEdit
          Left = 97
          Top = 40
          Width = 76
          Height = 21
          TabOrder = 2
          OnChange = ComboBox2Click
        end
        object Edit7: TEdit
          Left = 292
          Top = 40
          Width = 33
          Height = 21
          TabOrder = 3
          OnChange = ComboBox2Click
        end
        object Edit8: TEdit
          Left = 357
          Top = 40
          Width = 33
          Height = 21
          TabOrder = 4
          OnChange = ComboBox2Click
        end
      end
      object ComboBox4: TComboBox
        Left = 324
        Top = 30
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnChange = ComboBox2Click
        Items.Strings = (
          'B/W'
          '16'
          '256'
          '65536'
          '16M')
      end
    end
    object TabSheetTIFF2: TTabSheet
      Caption = 'TIFF'
      object Label77: TLabel
        Left = 16
        Top = 61
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label78: TLabel
        Left = 16
        Top = 77
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label79: TLabel
        Left = 208
        Top = 61
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label80: TLabel
        Left = 209
        Top = 77
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label81: TLabel
        Left = 15
        Top = 8
        Width = 63
        Height = 13
        Caption = '&Compression:'
      end
      object Label82: TLabel
        Left = 15
        Top = 34
        Width = 32
        Height = 13
        Caption = 'C&olors:'
      end
      object ComboBox16: TComboBox
        Left = 95
        Top = 5
        Width = 127
        Height = 21
        Style = csDropDownList
        Ctl3D = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 0
        OnChange = ComboBox16Change
        Items.Strings = (
          '')
      end
      object ComboBox17: TComboBox
        Left = 95
        Top = 32
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = ComboBox16Change
        Items.Strings = (
          '2'
          '16'
          '256'
          '16777216')
      end
    end
    object TabSheetGIF1: TTabSheet
      Caption = 'GIF'
      object Label20: TLabel
        Left = 216
        Top = 8
        Width = 60
        Height = 13
        Caption = '&Image index:'
      end
      object Label21: TLabel
        Left = 30
        Top = 8
        Width = 32
        Height = 13
        Caption = '&Colors:'
      end
      object Label34: TLabel
        Left = 216
        Top = 32
        Width = 86
        Height = 13
        Caption = 'T&ransparent color:'
      end
      object Label35: TLabel
        Left = 216
        Top = 53
        Width = 61
        Height = 13
        Caption = '&Background:'
      end
      object Label22: TLabel
        Left = 16
        Top = 150
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label28: TLabel
        Left = 16
        Top = 166
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label29: TLabel
        Left = 208
        Top = 150
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label30: TLabel
        Left = 209
        Top = 166
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Edit9: TEdit
        Left = 319
        Top = 5
        Width = 33
        Height = 21
        TabOrder = 1
        Text = '0'
        OnChange = ComboBox5Click
      end
      object UpDown2: TUpDown
        Left = 352
        Top = 5
        Width = 16
        Height = 21
        Associate = Edit9
        Max = 1000
        TabOrder = 2
        Thousands = False
      end
      object ComboBox5: TComboBox
        Left = 101
        Top = 6
        Width = 65
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox5Click
        Items.Strings = (
          'B/W'
          '4'
          '8'
          '16'
          '32'
          '64'
          '128'
          '256')
      end
      object Panel3: TPanel
        Left = 319
        Top = 31
        Width = 34
        Height = 17
        BevelOuter = bvLowered
        TabOrder = 3
        OnClick = Panel3Click
      end
      object CheckBox4: TCheckBox
        Left = 28
        Top = 32
        Width = 86
        Height = 17
        Alignment = taLeftJustify
        Caption = '&Transparent:'
        TabOrder = 4
        OnClick = ComboBox5Click
      end
      object CheckBox5: TCheckBox
        Left = 28
        Top = 53
        Width = 86
        Height = 17
        Alignment = taLeftJustify
        Caption = 'I&nterlaced:'
        TabOrder = 5
        OnClick = ComboBox5Click
      end
      object Panel4: TPanel
        Left = 319
        Top = 53
        Width = 34
        Height = 17
        BevelOuter = bvLowered
        TabOrder = 6
        OnClick = Panel4Click
      end
      object GroupBox2: TGroupBox
        Left = 16
        Top = 74
        Width = 385
        Height = 74
        Caption = ' Advanced '
        TabOrder = 7
        object Label33: TLabel
          Left = 202
          Top = 20
          Width = 52
          Height = 13
          Caption = '&Delay time:'
        end
        object Label31: TLabel
          Left = 14
          Top = 20
          Width = 70
          Height = 13
          Caption = '&Horiz. Position:'
        end
        object Label32: TLabel
          Left = 15
          Top = 47
          Width = 65
          Height = 13
          Caption = '&Vert. Position:'
        end
        object Label36: TLabel
          Left = 340
          Top = 20
          Width = 37
          Height = 13
          Caption = '1/100 s'
        end
        object Edit12: TEdit
          Left = 286
          Top = 16
          Width = 48
          Height = 21
          TabOrder = 0
          OnChange = ComboBox5Click
        end
        object Edit10: TEdit
          Left = 94
          Top = 16
          Width = 43
          Height = 21
          TabOrder = 1
          OnChange = ComboBox5Click
        end
        object Edit11: TEdit
          Left = 94
          Top = 44
          Width = 43
          Height = 21
          TabOrder = 2
          OnChange = ComboBox5Click
        end
      end
    end
    object TabSheetGIF2: TTabSheet
      Caption = 'GIF'
      object Label83: TLabel
        Left = 16
        Top = 61
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label84: TLabel
        Left = 16
        Top = 77
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label85: TLabel
        Left = 208
        Top = 61
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label86: TLabel
        Left = 209
        Top = 77
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label87: TLabel
        Left = 15
        Top = 8
        Width = 32
        Height = 13
        Caption = '&Colors:'
      end
      object ComboBox18: TComboBox
        Left = 85
        Top = 6
        Width = 65
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox18Change
        Items.Strings = (
          'B/W'
          '4'
          '8'
          '16'
          '32'
          '64'
          '128'
          '256')
      end
    end
    object TabSheetBMP1: TTabSheet
      Caption = 'BMP'
      object Label37: TLabel
        Left = 16
        Top = 8
        Width = 63
        Height = 13
        Caption = '&Compression:'
      end
      object Label38: TLabel
        Left = 16
        Top = 37
        Width = 32
        Height = 13
        Caption = 'C&olors:'
      end
      object Label39: TLabel
        Left = 16
        Top = 141
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label40: TLabel
        Left = 16
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label41: TLabel
        Left = 208
        Top = 141
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label42: TLabel
        Left = 209
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object ComboBox6: TComboBox
        Left = 96
        Top = 5
        Width = 127
        Height = 21
        Style = csDropDownList
        Ctl3D = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 0
        OnChange = ComboBox6Change
        Items.Strings = (
          'UNCOMPRESSED'
          'RLE')
      end
      object ComboBox7: TComboBox
        Left = 96
        Top = 35
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = ComboBox6Change
        Items.Strings = (
          'B/W'
          '16'
          '256'
          '16M'
          '16M (32bit)')
      end
    end
    object TabSheetPCX1: TTabSheet
      Caption = 'PCX'
      object Label43: TLabel
        Left = 16
        Top = 8
        Width = 63
        Height = 13
        Caption = '&Compression:'
      end
      object Label44: TLabel
        Left = 16
        Top = 37
        Width = 32
        Height = 13
        Caption = 'C&olors:'
      end
      object Label45: TLabel
        Left = 16
        Top = 141
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label46: TLabel
        Left = 16
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label47: TLabel
        Left = 208
        Top = 141
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label48: TLabel
        Left = 209
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object ComboBox8: TComboBox
        Left = 96
        Top = 5
        Width = 127
        Height = 21
        Style = csDropDownList
        Ctl3D = True
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 0
        OnChange = ComboBox8Change
        Items.Strings = (
          'UNCOMPRESSED'
          'RLE')
      end
      object ComboBox9: TComboBox
        Left = 96
        Top = 35
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = ComboBox8Change
        Items.Strings = (
          'B/W'
          '16'
          '256'
          '16M')
      end
    end
    object TabSheetPNG1: TTabSheet
      Caption = 'PNG'
      object Label49: TLabel
        Left = 16
        Top = 8
        Width = 32
        Height = 13
        Caption = 'C&olors:'
      end
      object Label54: TLabel
        Left = 216
        Top = 8
        Width = 61
        Height = 13
        Caption = '&Background:'
      end
      object Label50: TLabel
        Left = 16
        Top = 141
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label51: TLabel
        Left = 16
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label52: TLabel
        Left = 208
        Top = 141
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label53: TLabel
        Left = 209
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object ComboBox10: TComboBox
        Left = 96
        Top = 5
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox10Change
        Items.Strings = (
          'B/W'
          '256'
          '16M')
      end
      object Panel1: TPanel
        Left = 311
        Top = 7
        Width = 34
        Height = 17
        BevelOuter = bvLowered
        TabOrder = 1
        OnClick = Panel1Click
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 42
        Width = 388
        Height = 74
        Caption = ' Advanced '
        TabOrder = 2
        object Label55: TLabel
          Left = 10
          Top = 20
          Width = 22
          Height = 13
          Caption = '&Filter'
        end
        object Label56: TLabel
          Left = 195
          Top = 20
          Width = 60
          Height = 13
          Caption = 'Co&mpression'
        end
        object ComboBox11: TComboBox
          Left = 88
          Top = 17
          Width = 89
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnChange = ComboBox10Change
          Items.Strings = (
            'None'
            'Sub'
            'Paeth')
        end
        object CheckBox6: TCheckBox
          Left = 10
          Top = 47
          Width = 91
          Height = 17
          Alignment = taLeftJustify
          Caption = 'I&nterlaced:'
          TabOrder = 1
          OnClick = ComboBox10Change
        end
        object ComboBox12: TComboBox
          Left = 272
          Top = 17
          Width = 109
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          OnChange = ComboBox10Change
          Items.Strings = (
            'None'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            'Max')
        end
      end
    end
    object TabSheetTGA1: TTabSheet
      Caption = 'TGA'
      object Label62: TLabel
        Left = 16
        Top = 8
        Width = 32
        Height = 13
        Caption = 'C&olors:'
      end
      object Label63: TLabel
        Left = 216
        Top = 8
        Width = 61
        Height = 13
        Caption = '&Background:'
      end
      object Label64: TLabel
        Left = 16
        Top = 59
        Width = 31
        Height = 13
        Caption = '&Name:'
      end
      object Label65: TLabel
        Left = 16
        Top = 91
        Width = 56
        Height = 13
        Caption = '&Description:'
      end
      object Label58: TLabel
        Left = 16
        Top = 141
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label59: TLabel
        Left = 16
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label60: TLabel
        Left = 208
        Top = 141
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label61: TLabel
        Left = 209
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object ComboBox14: TComboBox
        Left = 96
        Top = 5
        Width = 77
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnClick = ComboBox14Click
        Items.Strings = (
          'B/W'
          '256'
          '16M')
      end
      object Panel5: TPanel
        Left = 311
        Top = 7
        Width = 34
        Height = 17
        BevelOuter = bvLowered
        TabOrder = 1
        OnClick = Panel5Click
      end
      object CheckBox1: TCheckBox
        Left = 14
        Top = 32
        Width = 95
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Compression:'
        TabOrder = 2
        OnClick = ComboBox14Click
      end
      object Edit13: TEdit
        Left = 95
        Top = 56
        Width = 298
        Height = 21
        TabOrder = 3
        OnChange = ComboBox14Click
      end
      object Edit14: TEdit
        Left = 95
        Top = 87
        Width = 298
        Height = 21
        TabOrder = 4
        OnChange = ComboBox14Click
      end
    end
    object TabSheetJ20001: TTabSheet
      Caption = 'JPEG2000'
      object Label66: TLabel
        Left = 11
        Top = 8
        Width = 26
        Height = 13
        Caption = '&Rate:'
        FocusControl = Edit15
      end
      object Label67: TLabel
        Left = 16
        Top = 141
        Width = 59
        Height = 13
        Caption = 'Original size:'
      end
      object Label68: TLabel
        Left = 16
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label69: TLabel
        Left = 208
        Top = 141
        Width = 82
        Height = 13
        Caption = 'Compressed size:'
      end
      object Label70: TLabel
        Left = 209
        Top = 157
        Width = 9
        Height = 13
        Caption = '---'
      end
      object Label71: TLabel
        Left = 11
        Top = 44
        Width = 59
        Height = 13
        Caption = 'P&hotometric:'
      end
      object Edit15: TEdit
        Left = 77
        Top = 5
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit15Change
      end
      object TrackBar1: TTrackBar
        Left = 128
        Top = 6
        Width = 275
        Height = 19
        Max = 1000
        Frequency = 20
        TabOrder = 1
        OnChange = TrackBar1Change
      end
      object ComboBox15: TComboBox
        Left = 77
        Top = 41
        Width = 78
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnChange = TrackBar1Change
        Items.Strings = (
          'GrayScale'
          'RGB'
          'YCbCr')
      end
    end
  end
  object Button3: TButton
    Left = 432
    Top = 76
    Width = 87
    Height = 23
    Caption = '&Preview'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 432
    Top = 106
    Width = 87
    Height = 23
    Caption = '&Apply'
    TabOrder = 4
    OnClick = Button4Click
  end
  object chkLockPreview: TCheckBox
    Left = 12
    Top = 398
    Width = 365
    Height = 17
    Hint = 
      'Automatically updates your preview with the changes you have sel' +
      'ected'
    Caption = 'Lock Preview'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 5
    OnClick = SpeedButton1Click
  end
  object ImageEn1: TImageEnView
    Left = 6
    Top = 17
    Width = 191
    Height = 135
    Cursor = 1782
    Background = clWhite
    ParentCtl3D = False
    OnViewChange = ImageEn1ViewChange
    MouseInteract = [miZoom, miScroll]
    OnProgress = ImageEn1Progress
    ImageEnVersion = '3.0.3'
    EnableInteractionHints = True
    TabOrder = 6
  end
  object ImageEn2: TImageEnView
    Left = 227
    Top = 17
    Width = 191
    Height = 135
    Cursor = 1780
    Background = clWhite
    ParentCtl3D = False
    OnProgress = ImageEn1Progress
    ImageEnVersion = '3.0.3'
    EnableInteractionHints = True
    TabOrder = 7
  end
  object ProgressBar1: TProgressBar
    Left = 6
    Top = 157
    Width = 412
    Height = 10
    TabOrder = 8
  end
  object ColorDialog1: TColorDialog
    Left = 432
    Top = 176
  end
end
