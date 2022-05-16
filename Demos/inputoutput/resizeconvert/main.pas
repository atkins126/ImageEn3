{----------------------------------------------------------------------------
| TImageENView Image Batch Conversion Demo
| Description: Demonstrate TImageEnView
| Known Problems: None
|---------------------------------------------------------------------------}

unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, FileCtrl, ShellCtrls, Buttons,
  ExtDlgs, IEView, ImageEnView, HYIEDefs, ImageEnIO, ImageEnProc, XPMan, IEOpenSaveDlg;

type
  TForm1 = class ( TForm )
    Panel1: TPanel;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    edtOutputFolder: TEdit;
    btnBrowse: TButton;
    cmbOutputColor: TComboBox;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    edtWidth: TEdit;
    edtHeight: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    cbResizeOutput: TCheckBox;
    cmbFilter: TComboBox;
    cbAspectRatio: TCheckBox;
    cbDither: TCheckBox;
    cbQuantize: TCheckBox;
    cmbOutputTypeFilter: TFilterComboBox;
    DestImageEnView: TImageEnView;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    edtInputFilename: TEdit;
    btnSelectAll: TButton;
    SourceImageEnView: TImageEnView;
    btnStart: TButton;
    btnClose: TButton;
    XPManifest1: TXPManifest;
    GroupBox5: TGroupBox;
    Button1: TButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    cbSaveLogFile: TCheckBox;
    Button2: TButton;
    ShellListView1: TShellListView;
    ShellComboBox1: TShellComboBox;
    InputFolderLabel: TLabel;
    SelectedFilesLabel: TLabel;
    GroupBox6: TGroupBox;
    TrackBar2: TTrackBar;
    Label2: TLabel;
    cmbTIFF_Compression: TComboBox;
    Label7: TLabel;
    cmbPNG_Compression: TComboBox;
    Label10: TLabel;
    cmbJPEG_Quality: TComboBox;
    GroupBox8: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox7: TGroupBox;
    cbRotate90: TCheckBox;
    ContrastRadioGroup: TRadioGroup;
    BrightnessRadioGroup: TRadioGroup;
    GroupBox9: TGroupBox;
    Edit1: TEdit;
    UpDownAmount: TUpDown;
    Label11: TLabel;
    procedure btnCloseClick ( Sender: TObject );
    procedure btnSelectAllClick ( Sender: TObject );
    procedure btnBrowseClick ( Sender: TObject );
    procedure FormCreate ( Sender: TObject );
    procedure btnStartClick ( Sender: TObject );
    procedure edtWidthChange ( Sender: TObject );
    procedure edtHeightChange ( Sender: TObject );
    procedure FormActivate ( Sender: TObject );
    procedure Button1Click ( Sender: TObject );
    procedure edtOutputFolderChange ( Sender: TObject );
    procedure Button2Click ( Sender: TObject );
    procedure ShellListView1Change ( Sender: TObject;Item: TListItem;
      Change: TItemChange );
    procedure ShellListView1Click ( Sender: TObject );
    procedure FormDestroy ( Sender: TObject );
    procedure TrackBar2Change ( Sender: TObject );
  private
    { Private declarations }
    DontChange: boolean;
    procedure ConvertImage;
  public
    { Public declarations }
    InputPath: string;
    OutputPath: string;
    InputFilename: string;
    OutputFilename: string;
    SourceGraphic: TGraphic;
    DestGraphic: TGraphic;
    OrgWidth, OrgHeight: integer;
  end;

var
  Form1: TForm1;

implementation

uses GifLZW, TIFLZW, INIFiles, ConvertForm, View, ViewLog;

{$R *.dfm}

function AddBackSlash ( Dir: string ): string;
begin
  if Copy ( Dir, Length ( Dir ), 1 ) = '\' then
    Result := Dir
  else
    Result := Dir + '\';
end;

function EllipsifyText
  ( PathToMince: string;InSpace: Integer ): string;
var TotalLength, FLength: Integer;
begin
  TotalLength := Length ( PathToMince );
  if TotalLength > InSpace then
  begin
    FLength := ( Inspace div 2 ) - 2;
    Result := Copy ( PathToMince, 0, fLength )
      + '...'
      + Copy ( PathToMince,
      TotalLength - fLength,
      TotalLength );
  end
  else
    Result := PathToMince;
end;

function GetcColorString ( iBitsPerPixel: integer ): string;
begin
  case iBitsPerPixel of
    1: result := '2';
    2: result := '4';
    3: result := '16';
    4: result := '8';
    5: result := '32';
    6: result := '64';
    7: result := '128';
    8: result := '256';
    16: result := '65,536';
    24: result := '16 Million';
    32: result := '32 Million';
  else
    result := 'Unknown';
  end;
end;

procedure TForm1.FormCreate ( Sender: TObject );
var
  FIniFile: TIniFile;
begin
  cmbOutputTypeFilter.ItemIndex := 4;
  edtInputFilename.Text := '*.bmp';
  InputPath := 'C:\';
  OutputPath := 'C:\';
  InputFolderLabel.Caption := 'Source Folder: ' + InputPath;
  DontChange := True;
  OrgWidth := 640;
  OrgHeight := 480;
  // Set ImageEn file compression options
  DefGIF_LZWDECOMPFUNC := GIFLZWDecompress;
  DefGIF_LZWCOMPFUNC := GIFLZWCompress;
  DefTIFF_LZWDECOMPFUNC := TIFFLZWDecompress;
  DefTIFF_LZWCOMPFUNC := TIFFLZWCompress;
  SourceImageEnView.SetChessboardStyle ( 4, bsSolid );
  DestImageEnView.SetChessboardStyle ( 4, bsSolid );
  SourceImageEnView.Blank;
  DestImageEnView.Blank;
  FIniFile := TIniFile.Create ( ChangeFileExt ( Application.ExeName, '.ini' ) );
  try
    Left := FIniFile.ReadInteger ( 'Form', 'Left', 10 );
    Top := FIniFile.ReadInteger ( 'Form', 'Top', 10 );
    WindowState := TWindowState ( FIniFile.ReadInteger ( 'Form', 'Window State', 0 ) );
    cbAspectRatio.Checked := FIniFile.ReadBool ( 'Configure', 'Aspect Ratio', true );
    cbDither.Checked := FIniFile.ReadBool ( 'Configure', 'Dither', true );
    cbQuantize.Checked := FIniFile.ReadBool ( 'Configure', 'Quantize', true );
    cbResizeOutput.Checked := FIniFile.ReadBool ( 'Configure', 'Resize Output', true );
    cmbOutputColor.ItemIndex := FIniFile.ReadInteger ( 'Configure', 'OutputColor', 0 );
    UpDown1.Position := FIniFile.ReadInteger ( 'Configure', 'Dimensions Width', 360 );
    UpDown2.Position := FIniFile.ReadInteger ( 'Configure', 'Dimensions Height', 480 );
    edtOutputFolder.Text := FIniFile.ReadString ( 'Configure', 'Output Folder', 'c:\temp' );
  finally FIniFile.Free; end;
end;

procedure TForm1.FormActivate ( Sender: TObject );
begin
  DontChange := False;
end;

procedure TForm1.FormDestroy ( Sender: TObject );
var
  FIniFile: TIniFile;
begin
  FIniFile := TIniFile.Create ( ChangeFileExt ( Application.ExeName, '.INI' ) );
  try
    FIniFile.WriteInteger ( 'Form', 'Left', Left );
    FIniFile.WriteInteger ( 'Form', 'Top', Top );
    FIniFile.WriteInteger ( 'Form', 'Window State', Integer ( TWindowState ( WindowState ) ) );
    FIniFile.WriteBool ( 'Configure', 'Aspect Ratio', cbAspectRatio.Checked );
    FIniFile.WriteBool ( 'Configure', 'Dither', cbDither.Checked );
    FIniFile.WriteBool ( 'Configure', 'Quantize', cbQuantize.Checked );
    FIniFile.WriteBool ( 'Configure', 'Resize Output', cbResizeOutput.Checked );
    FIniFile.WriteInteger ( 'Configure', 'OutputColor', cmbOutputColor.ItemIndex );
    FIniFile.WriteInteger ( 'Configure', 'Dimensions Width', UpDown1.Position );
    FIniFile.WriteInteger ( 'Configure', 'Dimensions Height', UpDown2.Position );
    FIniFile.WriteString ( 'Configure', 'Output Folder', edtOutputFolder.Text );
  finally FIniFile.Free; end;
end;

procedure TForm1.btnCloseClick ( Sender: TObject );
begin
  Close;
end;

procedure TForm1.btnSelectAllClick ( Sender: TObject );
begin
  ShellListView1.SelectAll;
end;

procedure TForm1.btnBrowseClick ( Sender: TObject );
begin
  if SelectDirectory ( OutputPath, 'C:\', OutputPath ) then
  begin
    edtOutputFolder.Text := AddBackSlash ( OutputPath );
    if InputPath = OutputPath then
      ShowMessage ( 'Input path and output path are the same.  Output files will overright input files!' );
  end;
end;

procedure TForm1.ConvertImage;
var
  i: integer;
  w, h: integer;
  Ext: string;
  NewExtension: string;
  FT: TIOFileType;
  TIFF_Compression: string;
begin
  frmStatus.ProgressBar1.Position := 0;
  InputPath := ExtractFilePath ( ShellListView1.SelectedFolder.PathName );
  InputFilename := ShellListView1.SelectedFolder.PathName;
  if InputPath = OutputPath then
  begin
    ShowMessage ( 'Input path and output path are the same.  Output files will overwrite input files!' );
    exit;
  end;

  // hide images if more than one selected;
  if ShellListView1.SelCount > 1 then
  begin
    SourceImageEnView.Visible := False;
    DestImageEnView.Visible := False;
  end
  else
  begin
    SourceImageEnView.Visible := True;
    DestImageEnView.Visible := True;
  end;

  // Setup and Show Status Form
  frmStatus.Memo1.Clear;
  frmStatus.ProgressBar1.Max := ShellListView1.SelCount - 1;
  frmStatus.Show;
  frmStatus.OKBtn.Update;
  frmStatus.Update;

  NewExtension := ExtractFileExt ( cmbOutputTypeFilter.Mask );

  // cycle through selected items  to process each image
  for i := 0 to Pred ( ShellListView1.Items.Count - 1 ) do
  begin
    if ShellListView1.Items[i].Selected then
    begin
      InputFilename := ShellListView1.Folders[i].PathName;
      if FileExists ( InputFilename ) then
      begin
        frmStatus.Memo1.Lines.Add ( 'Reading ' + InputFilename + ' ...' );
        frmStatus.Memo1.Update;
        DestImageEnView.Clear;

        if ( FileExists ( InputFilename ) ) and ( IsKnownFormat ( InputFilename ) ) then
        begin
          SourceImageEnView.IO.LoadFromFile ( InputFilename );
          try
            DestImageEnView.Assign ( SourceImageEnView );
            DestImageEnView.Invalidate;
          except
            begin
              frmStatus.Memo1.Lines.Add ( 'Error reading ' + ExtractFilename ( InputFilename ) + ' ...' );
              frmStatus.Memo1.Lines.Add ( '' );
            end;
          end;

        // set destination filename
          OutputPath := edtOutputFolder.Text;
          OutputFilename := AddBackSlash ( OutputPath ) +
            ExtractFilename ( ChangeFileExt ( InputFilename, NewExtension ) );

          FT := FindFileFormat ( OutputFilename, false );

        // change image colors
          case cmbOutputColor.ItemIndex of
            0: // Black & White
              begin
                DestImageEnView.Proc.ConvertToBWOrdered;
                DestImageEnView.IO.Params.BitsPerSample := 1;
                DestImageEnView.IO.Params.SamplesPerPixel := 1;
                if FT = ioICO then
                  DestImageEnView.IO.Params.ICO_BitCount[0] := 2;
                frmStatus.Memo1.Lines.Add ( 'Converting to black & white ordered ...' );
              end;
            1: // 16 color grayscale
              begin
                DestImageEnView.Proc.ConvertToGray;
                DestImageEnView.Proc.ConvertTo ( 16 );
                if FT = ioICO then
                  DestImageEnView.IO.Params.ICO_BitCount[0] := 4;
                DestImageEnView.IO.Params.BitsPerSample := 4;
                DestImageEnView.IO.Params.SamplesPerPixel := 1;
                DestImageEnView.Invalidate;
                frmStatus.Memo1.Lines.Add ( 'Converting to 16 shades of gray ...' );
              end;
            2: // 256 color grayscale
              begin
                DestImageEnView.Proc.ConvertToGray;
                DestImageEnView.Proc.ConvertTo ( 256 );
                DestImageEnView.IO.Params.BitsPerSample := 8;
                DestImageEnView.IO.Params.SamplesPerPixel := 1;
                if FT = ioICO then
                  DestImageEnView.IO.Params.ICO_BitCount[0] := 8;
                if FT = ioJPEG then
                  DestImageEnView.IO.Params.JPEG_ColorSpace := ioJPEG_GRAYLEV;
                DestImageEnView.Invalidate;
                frmStatus.Memo1.Lines.Add ( 'Converting to 256 shades of gray ...' );
              end;
            3: // 16 color
              begin
                DestImageEnView.Proc.ConvertTo ( 16 );
                DestImageEnView.IO.Params.BitsPerSample := 4;
                DestImageEnView.IO.Params.SamplesPerPixel := 1;
                if FT = ioICO then
                  DestImageEnView.IO.Params.ICO_BitCount[0] := 4;
                DestImageEnView.Invalidate;
                frmStatus.Memo1.Lines.Add ( 'Converting to 16 colors ...' );
              end;
            4: // 256 color
              begin
                DestImageEnView.Proc.ConvertTo ( 256 );
                DestImageEnView.IO.Params.BitsPerSample := 8;
                DestImageEnView.IO.Params.SamplesPerPixel := 1;
                if FT = ioICO then
                  DestImageEnView.IO.Params.ICO_BitCount[0] := 8;
                DestImageEnView.Invalidate;
                frmStatus.Memo1.Lines.Add ( 'Converting to 256 colors ...' );
              end;
            5: // 24 bit
              begin
                DestImageEnView.Proc.ConvertTo24Bit;
                DestImageEnView.IO.Params.BitsPerSample := 8;
                DestImageEnView.IO.Params.SamplesPerPixel := 3;
                if FT = ioICO then
                  DestImageEnView.IO.Params.ICO_BitCount[0] := 24;
                DestImageEnView.Invalidate;
                frmStatus.Memo1.Lines.Add ( 'Converting to 24 bit  ...' );
              end;
            6: // 32 bit
              begin
                DestImageEnView.IO.Params.BitsPerSample := 8;
                DestImageEnView.IO.Params.SamplesPerPixel := 4;
                if FT = ioICO then
                  DestImageEnView.IO.Params.ICO_BitCount[0] := 32;
                DestImageEnView.Invalidate;
                frmStatus.Memo1.Lines.Add ( 'Converting to 32 bit  ...' );
              end;
          end; // case

          if FT = ioTIFF then
          // set TIFF Compression
            case cmbTIFF_Compression.ItemIndex of
              0: DestImageEnView.IO.Params.TIFF_Compression := ioTIFF_UNCOMPRESSED;
              1: DestImageEnView.IO.Params.TIFF_Compression := ioTIFF_CCITT1D;
              2: DestImageEnView.IO.Params.TIFF_Compression := ioTIFF_G3FAX1D;
              3: DestImageEnView.IO.Params.TIFF_Compression := ioTIFF_G3FAX2D;
              4: DestImageEnView.IO.Params.TIFF_Compression := ioTIFF_G4FAX;
              5: DestImageEnView.IO.Params.TIFF_Compression := ioTIFF_LZW;
              6: DestImageEnView.IO.Params.TIFF_Compression := ioTIFF_PACKBITS;
            end; // case

          if FT = ioPNG then
            // set PNG Compression
            DestImageEnView.IO.Params.PNG_Compression := cmbPNG_Compression.ItemIndex;

          if FT = ioJPEG then
          // set JPEG_Quality
            case cmbJPEG_Quality.ItemIndex of
              0: DestImageEnView.IO.Params.JPEG_Quality := 0;
              1: DestImageEnView.IO.Params.JPEG_Quality := 5;
              2: DestImageEnView.IO.Params.JPEG_Quality := 6;
              3: DestImageEnView.IO.Params.JPEG_Quality := 7;
              4: DestImageEnView.IO.Params.JPEG_Quality := 8;
              5: DestImageEnView.IO.Params.JPEG_Quality := 9;
              6: DestImageEnView.IO.Params.JPEG_Quality := 10;
              7: DestImageEnView.IO.Params.JPEG_Quality := 15;
              8: DestImageEnView.IO.Params.JPEG_Quality := 20;
              9: DestImageEnView.IO.Params.JPEG_Quality := 25;
              10: DestImageEnView.IO.Params.JPEG_Quality := 30;
              11: DestImageEnView.IO.Params.JPEG_Quality := 35;
              12: DestImageEnView.IO.Params.JPEG_Quality := 40;
              13: DestImageEnView.IO.Params.JPEG_Quality := 45;
              14: DestImageEnView.IO.Params.JPEG_Quality := 50;
              15: DestImageEnView.IO.Params.JPEG_Quality := 55;
              16: DestImageEnView.IO.Params.JPEG_Quality := 60;
              17: DestImageEnView.IO.Params.JPEG_Quality := 65;
              18: DestImageEnView.IO.Params.JPEG_Quality := 70;
              19: DestImageEnView.IO.Params.JPEG_Quality := 75;
              20: DestImageEnView.IO.Params.JPEG_Quality := 80;
              21: DestImageEnView.IO.Params.JPEG_Quality := 85;
              22: DestImageEnView.IO.Params.JPEG_Quality := 90;
              23: DestImageEnView.IO.Params.JPEG_Quality := 95;
              24: DestImageEnView.IO.Params.JPEG_Quality := 100;
            end; // case

        // resize file
          if ( cbResizeOutput.Checked ) and ( cmbFilter.Itemindex <> -1 ) then
          begin
            frmStatus.Memo1.Lines.Add ( 'Resizing output file ...' );
            frmStatus.Memo1.Update;
            w := StrToIntDef ( edtWidth.Text, 0 );
            h := StrToIntDef ( edtHeight.Text, 0 );
            // set filter
            if cmbFilter.Itemindex <> -1 then
              if ( w > 0 ) and ( h > 0 ) then
                DestImageEnView.Proc.Resample ( w, h,
                  TResampleFilter ( cmbFilter.Itemindex ) );

            if FT = ioICO then
            begin
              DestImageEnView.IO.Params.ICO_Sizes[0].cx := w;
              DestImageEnView.IO.Params.ICO_Sizes[0].cy := h;
            end;

            frmStatus.Memo1.Lines.Add ( 'Image resized sucessfully ...' );
          end;

          if cbRotate90.Checked then begin
            DestImageEnView.Proc.Rotate( 90 );
            frmStatus.Memo1.Lines.Add ( 'Image rotated 90 degrees ...' );
          end;

          case BrightnessRadioGroup.ItemIndex of
            0: begin
                 DestImageEnView.Proc.IntensityRGBall( UpDownAmount.Position, UpDownAmount.Position, UpDownAmount.Position );
                 frmStatus.Memo1.Lines.Add ( 'Increasing image brightness ...' );
               end;
            1: begin
                 DestImageEnView.Proc.IntensityRGBall( - UpDownAmount.Position, - UpDownAmount.Position, - UpDownAmount.Position );
                 frmStatus.Memo1.Lines.Add ( 'Decreasing image brightness ...' );
               end;
          end; // case

          case ContrastRadioGroup.ItemIndex of
            0: begin
                 DestImageEnView.Proc.Contrast( UpDownAmount.Position );
                 frmStatus.Memo1.Lines.Add ( 'Increasing image contrast ...' );
               end;
            1: begin
                 DestImageEnView.Proc.Contrast(- UpDownAmount.Position );
                 frmStatus.Memo1.Lines.Add ( 'Decreasing image contrast ...' );
               end;
            end;// case

          // write destination file
          frmStatus.Memo1.Lines.Add ( 'Writing ' + OutputFilename + ' ...' );
          DestImageEnView.IO.SaveToFile ( OutputFilename );
          if FileExists ( OutputFilename ) then
            frmStatus.Memo1.Lines.Add ( 'File written sucessfully ...' )
          else
            frmStatus.Memo1.Lines.Add ( 'Error writing file ...' );

            // get file params
          DestImageEnView.IO.ParamsFromFile ( OutputFilename );

          frmStatus.Memo1.Lines.Add ( 'FileType: ' +
            DestImageEnView.IO.Params.FileTypeStr + ' ...' );

          DestImageEnView.Hint := 'FileType: ' + DestImageEnView.IO.Params.FileTypeStr
            + #10#13 +
            'Dimensions: ' + IntToStr ( DestImageEnView.IO.Params.Width ) + ' x ' +
            IntToStr ( DestImageEnView.IO.Params.Height ) + ' pixels' + #10#13 +
            'Color: ' + GetcColorString ( DestImageEnView.IO.Params.BitsPerSample *
            DestImageEnView.IO.Params.SamplesPerPixel ) + ' colors';

          frmStatus.Memo1.Lines.Add ( 'Dimensions: ' +
            IntToStr ( DestImageEnView.IO.Params.Width ) + ' x ' +
            IntToStr ( DestImageEnView.IO.Params.Height ) + ' pixels ...' );

          frmStatus.Memo1.Lines.Add ( 'DPI: ' + IntToStr ( DestImageEnView.IO.Params.Dpi ) + ' ...' );

          frmStatus.Memo1.Lines.Add ( 'Color: ' +
            GetcColorString ( DestImageEnView.IO.Params.BitsPerSample *
            DestImageEnView.IO.Params.SamplesPerPixel ) + ' colors ...' );

          frmStatus.Memo1.Lines.Add ( 'BitsPerSample: ' + IntToStr ( DestImageEnView.IO.Params.BitsPerSample ) + ' ...' );
          frmStatus.Memo1.Lines.Add ( 'SamplesPerPixel: ' + IntToStr ( DestImageEnView.IO.Params.SamplesPerPixel ) + ' ...' );
          frmStatus.Memo1.Lines.Add ( 'ColorMapCount: ' + IntToStr ( DestImageEnView.IO.Params.ColorMapCount ) + ' ...' );

          if FileExists ( OutputFilename ) then begin
            FT := FindFileFormat ( OutputFilename, false );
            if FT = ioPNG then
              frmStatus.Memo1.Lines.Add ( 'PNG Compression: ' + IntToStr ( DestImageEnView.IO.Params.PNG_Compression ) + ' ...' );
            if FT = ioJPEG then
              frmStatus.Memo1.Lines.Add ( 'JPEG Quality: ' + IntToStr ( DestImageEnView.IO.Params.JPEG_Quality ) + ' ...' );
            if FT = ioTIFF then
            begin
              case DestImageEnView.IO.Params.TIFF_Compression of
                ioTIFF_UNCOMPRESSED: TIFF_Compression := 'Uncompressed TIFF';
                ioTIFF_CCITT1D: TIFF_Compression := 'TIFF_CCITT1D Bilevel Huffman compression';
                ioTIFF_G3FAX1D: TIFF_Compression := 'Bilevel Group 3 CCITT compression, monodimensional';
                ioTIFF_G3FAX2D: TIFF_Compression := 'Bilevel Group 3 CCITT compression, bidimensional';
                ioTIFF_G4FAX: TIFF_Compression := 'Bilevel Group 4 CCITT compression, bidimensional';
                ioTIFF_LZW: TIFF_Compression := 'LZW compression';
                ioTIFF_PACKBITS: TIFF_Compression := 'RLE compression';
              end; // case
              frmStatus.Memo1.Lines.Add ( 'TIFF Compression: ' + TIFF_Compression + ' ...' );
              frmStatus.Memo1.Lines.Add ( 'TIFF JPEGQuality: ' + IntToStr ( DestImageEnView.IO.Params.TIFF_JPEGQuality ) + ' ...' );
            end;
          end;
          frmStatus.Memo1.Lines.Add ( '' );
          frmStatus.Memo1.Update;
          frmStatus.ProgressBar1.Position := I;
        end
        else begin
          Ext := ExtractFileExt ( InputFilename );
          frmStatus.Memo1.Lines.Add ( 'Error reading ' + ExtractFilename ( InputFilename ) + ' ...' );
          frmStatus.Memo1.Lines.Add ( UpperCase ( Ext ) + ' files are not supported ...' );
          frmStatus.Memo1.Lines.Add ( '' );
          frmStatus.Memo1.Update;
        end;
      end;
    end;
  end;
  Application.ProcessMessages;
  frmStatus.ProgressBar1.Position := 0;
  if cbSaveLogFile.Checked then begin
    if FileExists ( ChangeFileExt ( Application.ExeName, '.log' ) )
      then
      DeleteFile ( ChangeFileExt ( Application.ExeName, '.log' ) );
    frmStatus.Memo1.Lines.Add ( 'Saving Log File as ' + ChangeFileExt ( Application.ExeName, '.log' ) );
    frmStatus.Memo1.Lines.SaveToFile ( ChangeFileExt ( Application.ExeName, '.log' ) );
  end;
  if frmStatus.Visible then
    frmStatus.Hide;
end;

procedure TForm1.btnStartClick ( Sender: TObject );
begin
  ConvertImage;
end;

procedure TForm1.edtWidthChange ( Sender: TObject );
begin
  if OrgWidth = 0 then
    OrgWidth := 640;
  if OrgHeight = 0 then
    OrgHeight := 480;
  if cbAspectRatio.Checked and not DontChange then
  begin
    DontChange := true;
    edtHeight.Text := IntToStr ( Round ( OrgHeight * StrToIntDef ( edtWidth.Text, 0 ) /
      OrgWidth ) );
    DontChange := false;
  end;
end;

procedure TForm1.edtHeightChange ( Sender: TObject );
begin
  if cbAspectRatio.Checked and not DontChange then
  begin
    DontChange := true;
    edtWidth.Text := IntToStr ( Round ( OrgWidth * StrToIntDef ( edtHeight.Text, 0 ) /
      OrgHeight ) );
    DontChange := false;
  end;
end;

procedure TForm1.Button1Click ( Sender: TObject );
begin
  OpenImageEnDialog1.InitialDir := Form1.OutputPath;
  OpenImageEnDialog1.FileName := '';
  if OpenImageEnDialog1.Execute then
    if FileExists ( OpenImageEnDialog1.FileName ) then
    begin
      frmView.ImageEnView.IO.LoadFromFile ( OpenImageEnDialog1.FileName );
      frmView.ShowModal;
    end;
end;

procedure TForm1.edtOutputFolderChange ( Sender: TObject );
begin
  if DirectoryExists ( edtOutputFolder.Text ) then
    OutputPath := edtOutputFolder.Text;
end;

procedure TForm1.Button2Click ( Sender: TObject );
begin
  ViewLogFile.ShowModal;
end;

procedure TForm1.ShellListView1Change ( Sender: TObject;Item: TListItem;
  Change: TItemChange );
begin

  // hide images if more than one selected;
  if ShellListView1.SelCount > 1 then
  begin
    SourceImageEnView.Visible := False;
    DestImageEnView.Visible := False;
  end
  else
  begin
    SourceImageEnView.Visible := True;
    DestImageEnView.Visible := True;
  end;

  SourceImageEnView.Clear;
  DestImageEnView.Clear;

  if ShellListView1.SelCount > 1 then
  begin
    edtInputFilename.Text := '*.*';
    InputFolderLabel.Caption := 'Source Folder: ' + IntToStr ( ShellListView1.SelCount )
      + ' files selected';
  end
  else
  begin
    if ShellListView1.SelCount = 1 then begin
      edtInputFilename.Text :=
        ExtractFilename ( ShellListView1.SelectedFolder.PathName + '\' + ShellListView1.SelectedFolder.DisplayName );
      InputFilename := ShellListView1.SelectedFolder.PathName;
    end;
    InputFolderLabel.Caption := 'Source Folder: ' + InputPath;
  end;

  if ( FileExists ( InputFilename ) ) and ( IsKnownFormat ( InputFilename ) ) then begin
    SourceImageEnView.IO.LoadFromFile ( InputFilename );
    SourceImageEnView.IO.ParamsFromFile ( InputFilename );
    OrgWidth := SourceImageEnView.IO.Params.Width;
    OrgHeight := SourceImageEnView.IO.Params.Height;
    Updown1.Position := SourceImageEnView.IO.Params.Width;
    Updown2.Position := SourceImageEnView.IO.Params.Height;
    SourceImageEnView.Hint := 'FileType: ' + SourceImageEnView.IO.Params.FileTypeStr +
      #10#13 +
      'Dimensions: ' + IntToStr ( SourceImageEnView.IO.Params.Width ) + ' x ' +
      IntToStr ( SourceImageEnView.IO.Params.Height ) + ' pixels' + #10#13 +
      'Color: ' + GetcColorString ( SourceImageEnView.IO.Params.BitsPerSample *
      SourceImageEnView.IO.Params.SamplesPerPixel ) + ' colors' + #10#13 +
      'ColorMapCount: ' + IntToStr ( SourceImageEnView.IO.Params.ColorMapCount );
  end;
end;

procedure TForm1.ShellListView1Click ( Sender: TObject );
begin
  if ShellListView1.SelCount > 0 then
  begin
    if ShellListView1.SelectedFolder.IsFolder then
      InputPath := ExtractFilePath ( ShellListView1.SelectedFolder.PathName );
    InputFolderLabel.Caption := EllipsifyText ( 'Source Folder: ' + ExtractFileDir ( ShellListView1.SelectedFolder.PathName ), 70 );
    if not ShellListView1.SelectedFolder.IsFolder then
      SelectedFilesLabel.Caption := 'Selected files: ' + IntToStr ( ShellListView1.SelCount );
  end;
end;

procedure TForm1.TrackBar2Change ( Sender: TObject );
begin
  TrackBar2.Hint := IntToStr ( TrackBar2.Position );
  Application.ActivateHint ( Mouse.CursorPos );
  UpDown1.Increment := TrackBar2.Position;
  UpDown2.Increment := TrackBar2.Position;
end;

end.

