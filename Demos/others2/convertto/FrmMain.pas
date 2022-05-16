//------------------------------------------------------------------------------
//  ImageEN Convert To  & Lossless Transform Demo: 1.0
//------------------------------------------------------------------------------

unit FrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  ExtCtrls, Dialogs, Buttons, ImgList, StdActns, ActnList, Menus, ComCtrls, Printers,
  ToolWin, XPMan,

  IEView, IEOpenSaveDlg, ImageENView, ImageEnIO, ImageEnProc, HYIEutils,
  HYIEdefs;

type
  TFormMain = class ( TForm )
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileClose1: TWindowClose;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    EditCrop1: TAction;
    EditUndo1: TAction;
    ProgressBar1: TProgressBar;
    EditCut1: TAction;
    OpenImageEnDialog1: TOpenImageEnDialog;
    SaveImageEnDialog1: TSaveImageEnDialog;
    SelectZoom1: TAction;
    SelectRect1: TAction;
    SelectMove1: TAction;
    SelectCircle1: TAction;
    SelectPolygon1: TAction;
    SelectNone1: TAction;
    ImageGrayScale1: TAction;
    Image16Color1: TAction;
    Image256Color1: TAction;
    ImageTrueColor1: TAction;
    ImageBW1: TAction;
    ImageEffects1: TAction;
    ImageBrightness1: TAction;
    ImageCalcColors1: TAction;
    ImageResize1: TAction;
    ImageResample1: TAction;
    ViewFullScreen1: TAction;
    ImageVertFlip1: TAction;
    ImageHorzFlip1: TAction;
    ImageRotateRight1: TAction;
    ImageRotateLeft1: TAction;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintSetup1: TAction;
    Print1: TAction;
    EditPasteSelection1: TAction;
    EditPasteNew1: TAction;
    FileProperties1: TAction;
    ImageProperties1: TAction;
    PrintPreview1: TAction;
    SelectMagicWand1: TAction;
    SelectLasso1: TAction;
    ImageList1: TImageList;
    PrinterSetupDialog2: TPrinterSetupDialog;
    ViewReset1: TAction;
    ViewFit1: TAction;
    EditResetUndo1: TAction;
    FontDialog1: TFontDialog;
    ColorDialog1: TColorDialog;
    TrackBarZoom: TTrackBar;
    XPManifest1: TXPManifest;
    EditPaste2: TAction;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    Select1: TMenuItem;
    View1: TMenuItem;
    Colors1: TMenuItem;
    Image1: TMenuItem;
    Help1: TMenuItem;
    New2: TMenuItem;
    Open2: TMenuItem;
    N1: TMenuItem;
    Close2: TMenuItem;
    N2: TMenuItem;
    Save2: TMenuItem;
    SaveAs2: TMenuItem;
    N3: TMenuItem;
    Properties2: TMenuItem;
    N4: TMenuItem;
    PrintPreview2: TMenuItem;
    Print2: TMenuItem;
    PrintSetup2: TMenuItem;
    N5: TMenuItem;
    Exit2: TMenuItem;
    Copy2: TMenuItem;
    Paste1: TMenuItem;
    Pastetoselection2: TMenuItem;
    Pasteclipboardintonewimage2: TMenuItem;
    Pasteclipboardtoactiveimage2: TMenuItem;
    Crop1: TMenuItem;
    Undo1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    SelectAll1: TMenuItem;
    UnSelectAll1: TMenuItem;
    SelectNone11: TMenuItem;
    SelectRect12: TMenuItem;
    SelectCircle11: TMenuItem;
    Polygon1: TMenuItem;
    MagicWand1: TMenuItem;
    Lasso1: TMenuItem;
    Move1: TMenuItem;
    Zoom1: TMenuItem;
    N8: TMenuItem;
    WandTolerance1: TMenuItem;
    Fit1: TMenuItem;
    Reset1: TMenuItem;
    FullScreen1: TMenuItem;
    N9: TMenuItem;
    Properties3: TMenuItem;
    BlackWhite1: TMenuItem;
    GrayScale2: TMenuItem;
    N16Color2: TMenuItem;
    N256Color1: TMenuItem;
    rueColor1: TMenuItem;
    N10: TMenuItem;
    CalculateNumberofImageColors1: TMenuItem;
    About1: TMenuItem;
    ToolButton47: TToolButton;
    SelectPopupMenu: TPopupMenu;
    FlipPopupMenu1: TPopupMenu;
    RotatePopupMenu1: TPopupMenu;
    PopupMenu1: TPopupMenu;
    Rectangle1: TMenuItem;
    Circle1: TMenuItem;
    Polygon3: TMenuItem;
    MagicWand2: TMenuItem;
    Lasso2: TMenuItem;
    N13: TMenuItem;
    Move2: TMenuItem;
    Zoom2: TMenuItem;
    N14: TMenuItem;
    SelectNone2: TMenuItem;
    Vertical2: TMenuItem;
    Horzontal2: TMenuItem;
    Left3: TMenuItem;
    Right2: TMenuItem;
    Close3: TMenuItem;
    N15: TMenuItem;
    Cut1: TMenuItem;
    Copy3: TMenuItem;
    Pasteclipboardtoactiveimage3: TMenuItem;
    Pasteclipboardintonewimage3: TMenuItem;
    Pastetoselection3: TMenuItem;
    Undo3: TMenuItem;
    N16: TMenuItem;
    Open3: TMenuItem;
    Save3: TMenuItem;
    SaveAs3: TMenuItem;
    N17: TMenuItem;
    Properties4: TMenuItem;
    Effects2: TMenuItem;
    Color1: TMenuItem;
    Brightness1: TMenuItem;
    N18: TMenuItem;
    Exit3: TMenuItem;
    StatusBar1: TStatusBar;
    EditRedo1: TAction;
    EditResetRedo1: TAction;
    Crop2: TMenuItem;
    ToolButton37: TToolButton;
    PopupMenu2: TPopupMenu;
    Pastetoselection1: TMenuItem;
    Pasteclipboardintonewimage1: TMenuItem;
    Pasteclipboardtoactiveimage1: TMenuItem;
    Image256IEOrdered1: TAction;
    ransparentColor1: TMenuItem;
    SelectWandTolerance1: TAction;
    N11: TMenuItem;
    Select2: TMenuItem;
    Rectangle2: TMenuItem;
    Circle2: TMenuItem;
    Polygon4: TMenuItem;
    MagicWand3: TMenuItem;
    Lasso3: TMenuItem;
    Zoom3: TMenuItem;
    N12: TMenuItem;
    None1: TMenuItem;
    ImageColorAdjust1: TAction;
    ImageColorAdjust2: TMenuItem;
    Effects1: TMenuItem;
    PopupMenuUndo: TPopupMenu;
    Undo2: TMenuItem;
    PopupMenuRedo: TPopupMenu;
    EditRedo12: TMenuItem;
    Redo1: TMenuItem;
    N20: TMenuItem;
    ImageEnView1: TImageEnView;
    ImageImageConvertTo24Bit1: TAction;
    ImageConvertTo8Bit1: TAction;
    Convertto8bitImage1: TMenuItem;
    ImageConvertto24bitImage1: TMenuItem;
    N21: TMenuItem;
    ImageDoPreviews1: TAction;
    ImageDoPreviews2: TMenuItem;
    SelectionProperties1: TAction;
    SelectionProperties11: TMenuItem;
    N22: TMenuItem;
    ImageRotate1: TAction;
    N19: TMenuItem;
    Rotate1: TMenuItem;
    Rotate2: TMenuItem;
    Left1: TMenuItem;
    Right1: TMenuItem;
    ResizeImage1: TMenuItem;
    ResizeImage2: TMenuItem;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ImageLosslessTransform1: TAction;
    LosslessTransform1: TMenuItem;
    procedure FileNew1Execute ( Sender: TObject );
    procedure FileOpen1Execute ( Sender: TObject );
    procedure FileSave1Execute ( Sender: TObject );
    procedure FileSaveAs1Execute ( Sender: TObject );
    procedure EditCopy1Execute ( Sender: TObject );
    procedure EditCrop1Execute ( Sender: TObject );
    procedure EditUndo1Execute ( Sender: TObject );
    procedure FileExit1Execute ( Sender: TObject );
    procedure FormCreate ( Sender: TObject );
    procedure HelpAbout1Execute ( Sender: TObject );
    procedure ImageEnViewProgress ( Sender: TObject;per: Integer );
    procedure EditCut1Execute ( Sender: TObject );
    procedure SelectPolygon1Execute ( Sender: TObject );
    procedure SelectNone1Execute ( Sender: TObject );
    procedure ImageTrueColor1Execute ( Sender: TObject );
    procedure Image256Color1Execute ( Sender: TObject );
    procedure Image16Color1Execute ( Sender: TObject );
    procedure ImageBW1Execute ( Sender: TObject );
    procedure ColorAdjust1Click ( Sender: TObject );
    procedure ImageEffects1Execute ( Sender: TObject );
    procedure ImageBrightness1Execute ( Sender: TObject );
    procedure ImageCalcColors1Execute ( Sender: TObject );
    procedure ImageResize1Execute ( Sender: TObject );
    procedure ImageResample1Execute ( Sender: TObject );
    procedure ViewFullScreen1Execute ( Sender: TObject );
    procedure ImageVertFlip1Execute ( Sender: TObject );
    procedure ImageHorzFlip1Execute ( Sender: TObject );
    procedure ImageRotateRight1Execute ( Sender: TObject );
    procedure ImageRotateLeft1Execute ( Sender: TObject );
    procedure PrintSetup1Execute ( Sender: TObject );
    procedure Print1Execute ( Sender: TObject );
    procedure EditPasteSelection1Execute ( Sender: TObject );
    procedure EditPasteNew1Execute ( Sender: TObject );
    procedure FileProperties1Execute ( Sender: TObject );
    procedure PrintPreview1Execute ( Sender: TObject );
    procedure FormKeyDown ( Sender: TObject;var Key: Word;
      Shift: TShiftState );
    procedure SelectMagicWand1Execute ( Sender: TObject );
    procedure FormDestroy ( Sender: TObject );
    procedure BlackandWhite1Click ( Sender: TObject );
    procedure Properties12Click ( Sender: TObject );
    procedure Setup1Click ( Sender: TObject );
    procedure TrackBarZoomChange ( Sender: TObject );
    procedure ViewReset1Execute ( Sender: TObject );
    procedure EditResetUndo1Execute ( Sender: TObject );
    procedure EditPaste2Execute ( Sender: TObject );
    procedure OptionsSelection1Execute ( Sender: TObject );
    procedure Rectangle1Click ( Sender: TObject );
    procedure Circle1Click ( Sender: TObject );
    procedure Polygon3Click ( Sender: TObject );
    procedure MagicWand2Click ( Sender: TObject );
    procedure Lasso2Click ( Sender: TObject );
    procedure Move2Click ( Sender: TObject );
    procedure Zoom2Click ( Sender: TObject );
    procedure SelectRect1Execute ( Sender: TObject );
    procedure SelectCircle1Execute ( Sender: TObject );
    procedure SelectLasso1Execute ( Sender: TObject );
    procedure SelectMove1Execute ( Sender: TObject );
    procedure SelectZoom1Execute ( Sender: TObject );
    procedure Button7Click ( Sender: TObject );
    procedure ImageGrayScale1Execute ( Sender: TObject );
    procedure SelectWandTolerance1Execute ( Sender: TObject );
    procedure ImageColorAdjust1Execute ( Sender: TObject );
    procedure ToolButton19Click ( Sender: TObject );
    procedure EditRedo1Execute ( Sender: TObject );
    procedure ImageEnView1DblClick ( Sender: TObject );
    procedure ImageEnView1ViewChange ( Sender: TObject;Change: Integer );
    procedure ImageEnView1MouseDown ( Sender: TObject;Button: TMouseButton;
      Shift: TShiftState;X, Y: Integer );
    procedure ImageEnView1ImageChange ( Sender: TObject );
    procedure Image256IEOrdered1Execute ( Sender: TObject );
    procedure ImageConvertTo8Bit1Execute ( Sender: TObject );
    procedure ImageImageConvertTo24Bit1Execute ( Sender: TObject );
    procedure ImageDoPreviews1Execute ( Sender: TObject );
    procedure SelectionProperties1Execute ( Sender: TObject );
    procedure FormShow ( Sender: TObject );
    procedure ImageRotate1Execute(Sender: TObject);
    procedure ImageLosslessTransform1Execute(Sender: TObject);
  private
    { Private declarations }
    Image: TImageENView;
    fDefaultExtension: string;
    fFilename: string;
    fSaveAs: boolean;
    fMsgLanguage: TMsgLanguage;
    procedure ShowHint ( Sender: TObject );
    procedure ShowIOParams ( Params: TIOParamsVals ); // get image info from file
    procedure ShowPropertyIOParams ( params: TIOParamsVals );
    procedure UpdateUndoMenu;
  public
    { Public declarations }
    fPathFilename: string;
    fDefaultFolder: string;
  end;

var
  FormMain: TFormMain;

implementation

uses
  INIFiles, GifLZW, TIFLZW, ImageEn, frmFullscrn, Clipbrd, ShellApi, Math, frmConvBW,
  frmresres, frmPropDlg, frmSelection, frmRotate, frmLosslessTransform;

{$R *.DFM}

function PixelFormatToColors ( PixelFormat: TPixelFormat ): string;
begin
  case PixelFormat of
    pf1bit: Result := '2 color';
    pf4bit: Result := '16 color';
    pf8bit: Result := '256 color';
    pf15bit: Result := '15 Bit (High color)';
    pf16bit: Result := '16 Bit (High color)';
    pf24bit: Result := '24 Bit (True color)';
    pf32bit: Result := '32 Bit (True color)';
  else
    Result := 'Unknown';
  end;
end;

procedure TFormMain.FormCreate ( Sender: TObject );
var
  MyIniFile: TIniFile;
begin
  // set ImageEn file compression options
  DefGIF_LZWDECOMPFUNC := GIFLZWDecompress;
  DefGIF_LZWCOMPFUNC := GIFLZWCompress;
  DefTIFF_LZWDECOMPFUNC := TIFFLZWDecompress;
  DefTIFF_LZWCOMPFUNC := TIFFLZWCompress;
  OpenImageEnDialog1.Filename := '';
  OpenImageEnDialog1.FilterIndex := 1;
  Application.OnHint := ShowHint;
  // Get form state from ini file
  MyIniFile := TIniFile.Create ( ChangeFileExt ( Application.ExeName, '.ini' ) );
  fDefaultFolder := ExtractFilePath ( Application.EXEName );
  try
    Left := MyIniFile.ReadInteger ( 'Main Form', 'Left', 0 );
    Top := MyIniFile.ReadInteger ( 'Main Form', 'Top', 0 );
    Width := MyIniFile.ReadInteger ( 'Main Form', 'Width', 700 );
    Height := MyIniFile.ReadInteger ( 'Main Form', 'Height', 500 );
    WindowState := TWindowState ( MyIniFile.ReadInteger ( 'Main Form', 'Window State', 0 ) );
  finally MyIniFile.Free; end;
  // Set Chessboard style
  ImageEnView1.SetChessboardStyle ( 6, bsSolid );
  // mouse wheel will scroll image of 15 % of component height
  ImageEnView1.MouseWheelParams.Action := iemwVScroll;
  ImageEnView1.MouseWheelParams.Variation := iemwPercentage;
  ImageEnView1.MouseWheelParams.Value := 15;
  // set scrollbar params to match wheel
  ImageEnView1.HScrollBarParams.LineStep := 15;
  ImageEnView1.VScrollBarParams.LineStep := 15;
  ImageEnView1.IO.OnProgress := ImageEnViewProgress;
  ImageEnView1.Blank;
end;

// Save form state to ini file
procedure TFormMain.FormDestroy ( Sender: TObject );
var
  MyIniFile: TIniFile;
begin
  MyIniFile := TIniFile.Create ( ChangeFileExt ( Application.ExeName, '.ini' ) );
  try
    MyIniFile.WriteInteger ( 'Main Form', 'Left', Left );
    MyIniFile.WriteInteger ( 'Main Form', 'Top', Top );
    MyIniFile.WriteInteger ( 'Main Form', 'Width', Width );
    MyIniFile.WriteInteger ( 'Main Form', 'Height', Height );
    MyIniFile.WriteInteger ( 'Main Form', 'Window State', Integer ( TWindowState ( WindowState ) ) );
  finally MyIniFile.Free; end;
end;

// setup selection styles
procedure TFormMain.FormShow ( Sender: TObject );
begin
  ImageENView1.SetSelectionGripStyle ( SelectionDialog.ColorBoxColor1.Selected,
    SelectionDialog.ColorBoxColor2.Selected, bsSolid, SelectionDialog.UpDownSize.Position, SelectionDialog.CheckBoxExtendedSelectionDrawing.Checked );
  ImageENView1.SelColor1 := SelectionDialog.ColorBoxColor1.Selected;
  ImageENView1.SelColor2 := SelectionDialog.ColorBoxColor2.Selected;
end;

// undo
procedure TFormMain.EditUndo1Execute ( Sender: TObject );
begin
  // Undo
  with ImageENView1.Proc do begin
    SaveRedoCaptioned ( UndoCaptions[0] ); // saves in Redo list
    Undo;
    ClearUndo;
  end;
  UpdateUndoMenu;
  ImageENView1.Refresh;
end;

// new file
procedure TFormMain.FileNew1Execute ( Sender: TObject );
begin
  try
    ImageENView1.Proc.ClearUndo;
    ImageENView1.Blank;
    // Show image dimensions
    StatusBar1.Panels[1].Text := ' Height: ' + IntToStr ( ImageENView1.Bitmap.Height ) +
      ' pixels' + '  Width: ' + IntToStr ( ImageENView1.Bitmap.Width ) + ' pixels ';
  finally StatusBar1.Panels[1].Text := '   '; end;
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

procedure TFormMain.ShowHint ( Sender: TObject );
begin
  if Application.Hint <> '' then
    StatusBar1.Panels[0].Text := Application.Hint
  else
    StatusBar1.Panels[0].Text := '';
end;

// get file params
procedure TFormMain.ShowIOParams ( Params: TIOParamsVals );
var
  ss: string;
  BitsPerPixel: integer;
begin
  // Initalize string variable and filesize
  ss := '';
  with Params do
  begin
    StatusBar1.Panels[1].Text := ' Height: ' + IntToStr ( ImageENView1.Bitmap.Height ) +
        ' pixels' + '  Width: ' + IntToStr ( ImageENView1.Bitmap.Width ) + ' pixels ';
    ss := 'ColorMapCount: ' + IntToStr ( ColorMapCount ) + ' ';
    StatusBar1.Panels[2].Text := ss;
    ss := 'BitsPerSample: ' + IntToStr ( BitsPerSample ) + ' ';
    StatusBar1.Panels[3].Text := ss;
    BitsPerPixel := BitsPerSample * SamplesPerPixel;
    ss := GetcColorString ( BitsPerPixel ) + ' colors';
    StatusBar1.Panels[4].Text := ss;
    ss := 'FileType: ' + FileTypeStr + ' ';
    StatusBar1.Panels[5].Text := ss;
  end;
end;

// open file
procedure TFormMain.FileOpen1Execute ( Sender: TObject );
begin
  OpenImageEnDialog1.FileName := '';
  OpenImageEnDialog1.InitialDir := fDefaultFolder;
  OpenImageEnDialog1.DefaultExt := 'bmp';
  // Open an image file
  if OpenImageEnDialog1.Execute then
  begin
    ImageENView1.Proc.ClearAllUndo;
    ImageENView1.Proc.ClearAllRedo;

    ImageENView1.Cursor := 1785;
    // Set MouseInteract
    ImageENView1.MouseInteract := ImageENView1.MouseInteract + [miSelect];
    // Set filename and path
    fFilename := ExtractFilename ( OpenImageEnDialog1.Filename );
    fPathFilename := OpenImageEnDialog1.FileName;
    fDefaultFolder := ExtractFileDir ( fPathFilename );
    // If file exists then load it
    if FileExists ( fPathFilename ) then
    begin
      // Show progress bar
      ProgressBar1.Visible := True;
      // Load the file
      ImageENView1.IO.LoadFromFile ( fPathFilename );
      // Set progress bar position to 0 and hide it
      ProgressBar1.Position := 0;
      ProgressBar1.Visible := False;
      ImageENView1.IO.ParamsFromFile ( fPathFilename );
      if ImageENView1.IO.Params.FileType <> ioUnknown then
        ShowIOParams ( ImageENView1.IO.Params );
    end;
  end;
end;

// save file
procedure TFormMain.FileSave1Execute ( Sender: TObject );
var
  ex: string;
  save: boolean;
begin
  ProgressBar1.Visible := True;
  if fSaveAs then
  begin
    // Set filename
    fFilename := SaveImageEnDialog1.FileName;
    fPathFilename := SaveImageEnDialog1.FileName;
  end;
  // Get file type from image file
  ex := Lowercase ( ExtractFileExt ( fPathFilename ) );
  if ( ex = '.gif' ) then
  begin
    if ImageENView1.IO.DoPreviews ( [ppGIF] ) then
    begin
      ImageENView1.IO.SaveToFileGif ( fPathFilename );
    end;
  end
  else
    // do io previews to set compression and color depth
    with ImageENView1.IO do
    begin
      Save := False;
      if ( ex = '.jp2' ) or ( ex = '.jp2000' ) then
        save := DoPreviews ( [ppJ2000] );
      if ( ex = '.jpg' ) or ( ex = '.jpeg' ) then
        save := DoPreviews ( [ppJPEG] );
      if ( ex = '.tif' ) then
        save := DoPreviews ( [ppTIFF] );
      if ( ex = '.bmp' ) then
        save := DoPreviews ( [ppBMP] );
      if ( ex = '.gif' ) then
        save := DoPreviews ( [ppGIF] );
      if ( ex = '.pcx' ) then
        save := DoPreviews ( [ppPCX] );
      if ( ex = '.png' ) then
        save := DoPreviews ( [ppPNG] );
      if ( ex = '.wmf' ) then
      begin
        MessageDlg ( 'Can not save to WMF file format.', mtInformation, [mbOK],
          0 );
        save := false;
      end;
      if ( ex = '.emf' ) then
      begin
        MessageDlg ( 'Can not save to EMF file format.', mtInformation, [mbOK],
          0 );
        save := false;
      end;
      if ( ex = '.ico' ) then
      begin
        MessageDlg ( 'Can not save to Icon file format.', mtInformation, [mbOK],
          0 );
        save := false;
      end;
      if ( ex = '.cur' ) then
      begin
        MessageDlg ( 'Can not save to Cursor file format.', mtInformation, [mbOK],
          0 );
        save := False;
      end;
      if save then
      begin
        // Save image to file
        SaveToFile ( fPathFilename );
        // Set statusbar
        Statusbar1.Panels[0].Text := ' ' + ExtractFilename ( fPathFilename ) + ' ';
      end;
      ProgressBar1.Position := 0;
      ProgressBar1.Visible := False;
    end;
end;

// save as a new file
procedure TFormMain.FileSaveAs1Execute ( Sender: TObject );
begin
  SaveImageEnDialog1.FileName := '';
  SaveImageEnDialog1.DefaultExt := fDefaultExtension;
  SaveImageEnDialog1.InitialDir := fDefaultFolder;
  // Launch save image dialog
  if SaveImageEnDialog1.Execute then
  begin
    fSaveAs := True;
    // Set filename
    fFilename := SaveImageEnDialog1.FileName;
    fPathFilename := SaveImageEnDialog1.FileName;
    fDefaultFolder := ExtractFileDir ( SaveImageEnDialog1.FileName );
    // Execute filesave
    FileSave1Execute ( Self );
  end;
end;

// close the app
procedure TFormMain.FileExit1Execute ( Sender: TObject );
begin
  Close;
end;

// copy
procedure TFormMain.EditCopy1Execute ( Sender: TObject );
begin
  if ImageENView1.VisibleSelection then
    // Copy selection to clipboard
    ImageENView1.Proc.SelCopyToClip
  else
    ImageENView1.Proc.CopyToClipboard;
end;

// crop
procedure TFormMain.EditCrop1Execute ( Sender: TObject );
var
  ABitmap: TBitmap;
begin
  if ImageENView1.Selected then
  begin
    // Save undo file
    ImageENView1.Proc.SaveUndoCaptioned ( 'Crop ' + IntToStr ( ImageENView1.Proc.UndoCount ) );
    ImageENView1.Proc.ClearAllRedo;
    // Create a temp bitmap
    ABitmap := TBitmap.Create;
    try
      // Assign selection (crop) to Abitmap
      ImageENView1.AssignSelTo ( ABitmap );
      // Copy the bitmap back to the Image component
      ImageENView1.Assign ( ABitmap );
      ImageENView1.Refresh;
    finally ABitmap.Free; end;
    UpdateUndoMenu;
    // Show image dimensions
    StatusBar1.Panels[1].Text := ' Height: ' + IntToStr ( ImageENView1.Bitmap.Height ) +
      ' pixels' + '  Width: ' + IntToStr ( ImageENView1.Bitmap.Width ) + ' pixels ';
    if ImageENView1.Proc.UndoCount > 0 then
      StatusBar1.Panels[5].Text := 'Undo: ' +
        IntToStr ( ImageENView1.Proc.UndoCount )
    else
      StatusBar1.Panels[5].Text := '';
    ImageENView1.Invalidate;
  end
  else
    MessageDlg ( 'Please select an area of the image to crop.', mtInformation,
      [mbOK], 0 );
end;

// show help about
procedure TFormMain.HelpAbout1Execute ( Sender: TObject );
begin
  ShellAbout ( Application.Handle, 'ImageEn Convert To Demo',
    'More info at: http://www.hicomponents.com',
    Application.Icon.Handle );
end;

// show progress bar position
procedure TFormMain.ImageEnViewProgress ( Sender: TObject;per: Integer );
begin
  // Show progressbar position
  ProgressBar1.Position := per;
end;

// cut
procedure TFormMain.EditCut1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Cut ' + IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Cut selection to clipboard
  ImageENView1.Proc.SelCutToClip;
  if ImageENView1.Proc.UndoCount > 0 then
    StatusBar1.Panels[5].Text := 'Undo: ' +
      IntToStr ( ImageENView1.Proc.UndoCount )
  else
    StatusBar1.Panels[5].Text := '';
  if ImageENView1.Bitmap.Modified then
    StatusBar1.Panels[6].Text := 'Modified'
  else
    StatusBar1.Panels[6].Text := '';
end;

// show file properties
procedure TFormMain.ShowPropertyIOParams ( params: TIOParamsVals );
var
  ss: string;
  mdim, bitcount: integer;
  fFileSize: integer;
  fFrames: integer;
begin
  if assigned ( Params ) then
  begin
    with Params, PropertiesDlg do
    begin
      txtFilename.Caption := '';
      txtSize.Caption := '';
      txtColors.Caption := '';
      txtMem.Caption := '';
      txtFileType.Caption := '';
      txtDPI.Caption := '';
      txtDPIY.Caption := '';
      txtColorMapCount.Caption := '';
      ss := ExtractFilename ( fPathFilename );
      txtFilename.Caption := ss;
      // Width X height pixel (frames)
      ss := IntToStr ( Params.Width ) + ' x ' + IntToStr ( Params.Height ) + ' pixel';
      txtSize.Caption := ss;
      // Dpi
      ss := inttostr ( DpiX ) + ' x ' + inttostr ( DpiY ) + ' dpi';
      txtDPI.Caption := ss;
      // Xxx colors
      if ( SamplesPerPixel = 4 ) and ( BitsPerSample = 8 ) then
        ss := ' 16 million colors '
      else
        ss := IntToStr ( 1 shl ( SamplesPerPixel * BitsPerSample ) );
      ss := ss + ' ' + iemsg ( IEMSG_COLORS, fMsgLanguage ) + ' (';
      ss := ss + IntToStr ( SamplesPerPixel * BitsPerSample ) + ' bit)';
      txtColors.caption := ss;
      // File size
      fFileSize := IEGetFileSize ( fPathFilename );
      if fFilesize <> -1 then
        if fFileSize < 1024 then
          ss := 'File: ' + inttostr ( fFileSize ) + ' bytes'
        else
          ss := 'File: ' + inttostr ( fFileSize div 1024 ) + ' Kb';
      // Memory size
      if ( SamplesPerPixel = 1 ) and ( BitsPerSample = 1 ) then
        bitcount := 1
      else
        bitcount := 24;
      fFrames := 1;
      mdim := ( ( ( Width * BitCount ) + 31 ) div 32 ) * 4 * height * fFrames;
      if mdim < 1024 then
        ss := ss + '   Mem: ' + inttostr ( mdim ) + ' bytes'
      else
        ss := ss + '   Mem: ' + inttostr ( mdim div 1024 ) + ' Kb';
      //
      txtMem.Caption := ss;
      // Compression
      ss := FileTypeStr;
      txtFileType.Caption := ss;
    end;
  end
  else
  begin
    with PropertiesDlg do
    begin
      txtFilename.Caption := '';
      txtSize.Caption := '';
      txtColors.Caption := '';
      txtMem.Caption := '';
      txtFileType.Caption := '';
      txtDPI.Caption := '';
      txtDPIY.Caption := '';
      txtColorMapCount.Caption := '';
    end;
  end;
end;

// Select Polygon
procedure TFormMain.SelectPolygon1Execute ( Sender: TObject );
begin
  // Select polygon
  ImageENView1.MouseInteract :=
    [miSelectPolygon];
  ImageENView1.Cursor := 1785;
end;

// Select MagicWand
procedure TFormMain.SelectMagicWand1Execute ( Sender: TObject );
begin
  // Select magic wand
  ImageENView1.MouseInteract :=
    [miSelectMagicWand];
  ImageENView1.Cursor := 1785;
end;

// Select None
procedure TFormMain.SelectNone1Execute ( Sender: TObject );
begin
  // Select none
  with ImageENView1 do
  begin
    DeSelect;
    Cursor := crHandPoint;
      // Set mouseinteract
    MouseInteract := MouseInteract + [miScroll];
  end;
end;

// ConvertTo24Bit
procedure TFormMain.ImageTrueColor1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'True Color ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progressbar
  ProgressBar1.Visible := True;
  // convert image
  ImageENView1.Proc.ConvertTo24Bit;
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := 'True Color ' +
    PixelFormatToColors ( ImageENView1.Bitmap.PixelFormat );
  UpdateUndoMenu;
end;

// ConvertTo 256
procedure TFormMain.Image256Color1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( '256 Color ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progressbar
  ProgressBar1.Visible := True;
  // Convert to 256 colors
  ImageENView1.Proc.ConvertTo ( 256, ieThreshold );
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := '256 Color ';
  UpdateUndoMenu;
end;

// ConvertTo 16
procedure TFormMain.Image16Color1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( '16 Color ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progressbar
  ProgressBar1.Visible := True;
  // Convert to 16 colors
  ImageENView1.Proc.ConvertTo ( 16 );
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := '16 color ';
  UpdateUndoMenu;
end;

// ConvertToBW
procedure TFormMain.ImageBW1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Black & White ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progressbar
  ProgressBar1.Visible := True;
  // Show BW Dialog and process image
    with fConvBW do
      if ShowModal = mrOK then
      begin
        Application.ProcessMessages;
        case RadioGroup1.ItemIndex of
          0:
            begin // Threshold
              if SpeedButton1.Down then
                ImageENView1.Proc.ConvertToBWThreshold ( -1 )
              else
                ImageENView1.Proc.ConvertToBWThreshold ( strtointdef ( Edit1.Text, 0 ) );
            end;
          1:
            begin // Ordered
              ImageENView1.Proc.ConvertToBWOrdered;
            end;
        end;
      end;
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := 'Black & White ' +
    PixelFormatToColors ( ImageENView1.Bitmap.PixelFormat );
  UpdateUndoMenu;
end;

// ColorAdjust
procedure TFormMain.ColorAdjust1Click ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Color Adjust ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progress bar
  ProgressBar1.Visible := True;
  // Show color adjust dialog
  ImageENView1.Proc.DoPreviews ( ppeColorAdjust );
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
end;

// ImageEffects
procedure TFormMain.ImageEffects1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Effects ' + IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  if ImageENView1.Proc.UndoCount > 0 then
    StatusBar1.Panels[5].Text := 'Undo: ' +
      IntToStr ( ImageENView1.Proc.UndoCount )
  else
    StatusBar1.Panels[5].Text := '';
  if ImageENView1.Bitmap.Modified then
    StatusBar1.Panels[6].Text := 'Modified'
  else
    StatusBar1.Panels[6].Text := '';
  // Show effects dialog
  if ImageENView1.Proc.DoPreviews ( ppeEffects ) = True then
  UpdateUndoMenu;
end;

// ImageBrightness
procedure TFormMain.ImageBrightness1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Brightness ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progress bar
  ProgressBar1.Visible := True;
  // Show color adjust dialog
  ImageENView1.Proc.DoPreviews ( ppeColorAdjust );
  // Set progress bar
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
end;

// CalcImageColors
procedure TFormMain.ImageCalcColors1Execute ( Sender: TObject );
var
  nc: integer;
begin
  // Calc # colors and show it
  nc := ImageENView1.Proc.CalcImageNumColors;
  MessageDlg ( 'The active image has ' + IntToStr ( nc ) + ' colors.', mtInformation,
    [mbOK], 0 );
end;

// ImageResize
procedure TFormMain.ImageResize1Execute ( Sender: TObject );
begin
    // Save undo file
    ImageENView1.Proc.SaveUndoCaptioned ( 'Resize Canvas ' + IntToStr ( ImageENView1.Proc.UndoCount ) );
    ImageENView1.Proc.ClearAllRedo;
    // Setup resize dialog
    fResize.OrgWidth :=
      ImageENView1.Bitmap.Width;
    fResize.OrgHeight :=
      ImageENView1.Bitmap.Height;
    fResize.Caption := 'Canvas';
    fResize.Caption := '  Canvas Size';
    fResize.Resize := True;
    fResize.SpeedButtonLockPreview.Down := True;
    // Copy images to resize dialog
    fResize.ImageEnView1.Assign ( ImageENView1.Bitmap );
    // Show resize dialog
    if fResize.ShowModal = mrOK then
    begin
      // Copy resized image back to main form
      ImageENView1.Bitmap.Assign ( fResize.ImageEnView2.Bitmap );
      ImageENView1.Update;
      StatusBar1.Panels[1].Text := ' Height: ' + IntToStr ( ImageENView1.Bitmap.Height ) +
        ' pixels' + '  Width: ' + IntToStr ( ImageENView1.Bitmap.Width ) + ' pixels ';
      if ImageENView1.IO.Params.FileType <> ioUnknown then
        ShowIOParams ( ImageENView1.IO.Params );
      if ImageENView1.Proc.UndoCount > 0 then
        StatusBar1.Panels[5].Text := 'Undo: ' +
          IntToStr ( ImageENView1.Proc.UndoCount )
      else
        StatusBar1.Panels[5].Text := '';
      if ImageENView1.Bitmap.Modified then
        StatusBar1.Panels[6].Text := 'Modified'
      else
        StatusBar1.Panels[6].Text := '';
    end;
end;

// ImageResample
procedure TFormMain.ImageResample1Execute ( Sender: TObject );
begin
    // Save undo file
    ImageENView1.Proc.SaveUndoCaptioned ( 'Resample ' + IntToStr ( ImageENView1.Proc.UndoCount ) );
    ImageENView1.Proc.ClearAllRedo;
    // Setup resize dialog
    fResize.OrgWidth :=
      ImageENView1.Bitmap.Width;
    fResize.OrgHeight :=
      ImageENView1.Bitmap.Height;
    fResize.Caption := 'Resize';
    fResize.Caption := '  Resize (Resample) image';
    fResize.Resize := False;
    fResize.Resample := True;
    fResize.Updown1.Position := ImageENView1.Bitmap.Width;
    fResize.Updown2.Position := ImageENView1.Bitmap.Height;
    fResize.SpeedButtonLockPreview.Down := True;
    // Copy images to resize dialog
    fResize.ImageEnView1.Assign ( ImageENView1.Bitmap );
    // Show resize dialog
    if fResize.ShowModal = mrOK then
    begin
      // Copy resized image back to main form
      ImageENView1.Bitmap.Assign ( fResize.ImageEnView2.Bitmap );
      ImageENView1.Update;
    end
    else
    begin
      // Reset progress bar, menu and status bar
      ProgressBar1.Position := 0;
      ProgressBar1.Visible := False;
    end;
    StatusBar1.Panels[1].Text := ' Height: ' + IntToStr ( ImageENView1.Bitmap.Height ) +
        ' pixels' + '  Width: ' + IntToStr ( ImageENView1.Bitmap.Width ) + ' pixels ';
    if ImageENView1.IO.Params.FileType <> ioUnknown then
        ShowIOParams ( ImageENView1.IO.Params );
    if ImageENView1.Proc.UndoCount > 0 then
      StatusBar1.Panels[5].Text := 'Undo: ' +
        IntToStr ( ImageENView1.Proc.UndoCount )
    else
      StatusBar1.Panels[5].Text := '';
    if ImageENView1.Bitmap.Modified then
      StatusBar1.Panels[6].Text := 'Modified'
    else
      StatusBar1.Panels[6].Text := '';
end;

// View FullScreen
procedure TFormMain.ViewFullScreen1Execute ( Sender: TObject );
begin
  FullScreen := TFullScreen.Create ( Self );
  try
    Screen.Cursor := crDefault;
      // Copy image to fullscreen image
    FullScreen.ImageEnView1.Bitmap.Assign ( ImageENView1.Bitmap );
      // Show the image fullscreen
    FullScreen.ShowModal;
    Screen.Cursor := crDefault;
  finally FullScreen.Free; end;
  Screen.Cursor := crDefault;
end;

// ImageVert Flip
procedure TFormMain.ImageVertFlip1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Vertical Flip ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // set Image to active page
  ImageENView1.IO.AttachedImageEn := ImageENView1;
  // Flip it
  ImageENView1.Proc.Flip ( fdVertical );
  if ImageENView1.Proc.UndoCount > 0 then
    StatusBar1.Panels[5].Text := 'Undo: ' +
      IntToStr ( ImageENView1.Proc.UndoCount )
  else
    StatusBar1.Panels[5].Text := '';
  if ImageENView1.Bitmap.Modified then
    StatusBar1.Panels[6].Text := 'Modified'
  else
    StatusBar1.Panels[6].Text := '';
end;

// ImageHorz Flip
procedure TFormMain.ImageHorzFlip1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Horzontal Flip ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Set image to active page
  ImageENView1.IO.AttachedImageEn := ImageENView1;
  // Flip it
  ImageENView1.Proc.Flip ( fdHorizontal );
  if ImageENView1.Proc.UndoCount > 0 then
    StatusBar1.Panels[5].Text := 'Undo: ' +
      IntToStr ( ImageENView1.Proc.UndoCount )
  else
    StatusBar1.Panels[5].Text := '';
  if ImageENView1.Bitmap.Modified then
    StatusBar1.Panels[6].Text := 'Modified'
  else
    StatusBar1.Panels[6].Text := '';
end;

// ImageRotate Right
procedure TFormMain.ImageRotateRight1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Rotate Right ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  ProgressBar1.Visible := True;
  // Rotate the image, with antialiasing
  ImageENView1.Proc.Rotate ( 90, true );
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  if ImageENView1.Proc.UndoCount > 0 then
    StatusBar1.Panels[5].Text := 'Undo: ' +
      IntToStr ( ImageENView1.Proc.UndoCount )
  else
    StatusBar1.Panels[5].Text := '';
  if ImageENView1.Bitmap.Modified then
    StatusBar1.Panels[6].Text := 'Modified'
  else
    StatusBar1.Panels[6].Text := '';
  UpdateUndoMenu;
end;

// ImageRotate Left
procedure TFormMain.ImageRotateLeft1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Rotate Left ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  ProgressBar1.Visible := True;
  // Rotate the image, with antialiasing
  ImageENView1.Proc.Rotate ( -90, true );
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  if ImageENView1.Proc.UndoCount > 0 then
    StatusBar1.Panels[5].Text := 'Undo: ' +
      IntToStr ( ImageENView1.Proc.UndoCount )
  else
    StatusBar1.Panels[5].Text := '';
  if ImageENView1.Bitmap.Modified then
    StatusBar1.Panels[6].Text := 'Modified'
  else
    StatusBar1.Panels[6].Text := '';
  UpdateUndoMenu;
end;

{================================== DrawImage =================================}
// DrawImage strechdraws an image on a canvas
// Since strechdraw spoils the colors we use StretchDIBits
{==============================================================================}

procedure DrawImage ( Canvas: TCanvas;DestRect: TRect;ABitmap: TBitmap );
var
  Header, Bits: Pointer;
  HeaderSize: DWORD; //Integer;
  BitsSize: DWORD; //Longint;
begin
  GetDIBSizes ( ABitmap.Handle, HeaderSize, BitsSize );
  Header := AllocMem ( HeaderSize );
  Bits := AllocMem ( BitsSize );
  try
    GetDIB ( ABitmap.Handle, ABitmap.Palette, Header^, Bits^ );
    StretchDIBits ( Canvas.Handle, DestRect.Left, DestRect.Top,
      DestRect.Right - DestRect.Left, DestRect.Bottom - DestRect.Top,
      0, 0, ABitmap.Width, ABitmap.Height, Bits, TBitmapInfo ( Header^ ),
      DIB_RGB_COLORS, SRCCOPY );
    { You might want to try DIB_PAL_COLORS instead, but this is well
      beyond the scope of my knowledge. }
  finally
    FreeMem ( Header, HeaderSize );
    FreeMem ( Bits, BitsSize );
  end;
end;

// PrintSetup
procedure TFormMain.PrintSetup1Execute ( Sender: TObject );
begin
  PrinterSetupDialog1.Execute;
end;

// Print
procedure TFormMain.Print1Execute ( Sender: TObject );
begin
  with Printer do
  begin
    BeginDoc;
    // Here we draw the image on the printercanvas, scaled up by a factor 2
    DrawImage ( Canvas, Rect ( 0, 0, 2 *
      ImageENView1.Bitmap.Width, 2 * ImageENView1.Bitmap.Height ),
      ImageENView1.Bitmap );
    EndDoc;
  end;
end;

// Paste Selection
procedure TFormMain.EditPasteSelection1Execute ( Sender: TObject );
begin
  if Clipboard.HasFormat ( CF_PICTURE ) then
  begin
    // Save Undo file
    ImageENView1.Proc.SaveUndoCaptioned ( 'Paste Selection ' +
      IntToStr ( ImageENView1.Proc.UndoCount ) );
    ImageENView1.Proc.ClearAllRedo;
    // Paste from clipboard
    ImageENView1.Proc.SelPasteFromClipStretch;
    if ImageENView1.Proc.UndoCount > 0 then
      StatusBar1.Panels[5].Text := 'Undo: ' +
        IntToStr ( ImageENView1.Proc.UndoCount )
    else
      StatusBar1.Panels[5].Text := '';
    if ImageENView1.Bitmap.Modified then
      StatusBar1.Panels[6].Text := 'Modified'
    else
      StatusBar1.Panels[6].Text := '';
    UpdateUndoMenu;
  end
  else
    MessageDlg ( 'There is no image in the Clipboard.', mtInformation, [mbOK], 0 );
end;

// PasteNew
procedure TFormMain.EditPasteNew1Execute ( Sender: TObject );
var
  Bitmap: TBitmap;
  BMH, BMW: integer;
begin
  if Clipboard.HasFormat ( CF_PICTURE ) then
  begin
    // Save Undo file
    ImageENView1.Proc.SaveUndoCaptioned ( 'Paste New ' +
      IntToStr ( ImageENView1.Proc.UndoCount ) );
    ImageENView1.Proc.ClearAllRedo;
    ImageENView1.Blank;
    // Paste
    Bitmap := TBitmap.Create;
    { create bitmap to hold the contents on the Clipboard }
    try
      Bitmap.Assign ( Clipboard ); { get the bitmap off the Clipboard }
      BMH := Bitmap.Height;
      BMW := Bitmap.Width;
      ImageENView1.Proc.ImageResize ( BMW, BMH );
      ImageENView1.Proc.PasteFromClipboard;
      ImageENView1.Refresh;
    finally Bitmap.Free; end;
    UpdateUndoMenu;
    if ImageENView1.Proc.UndoCount > 0 then
      StatusBar1.Panels[5].Text := 'Undo: ' +
        IntToStr ( ImageENView1.Proc.UndoCount )
    else
      StatusBar1.Panels[5].Text := '';
    if ImageENView1.Bitmap.Modified then
      StatusBar1.Panels[6].Text := 'Modified'
    else
      StatusBar1.Panels[6].Text := '';
  end
  else
    MessageDlg ( 'There is no image in the Clipboard.', mtInformation, [mbOK], 0 );
end;

// FileProperties
procedure TFormMain.FileProperties1Execute ( Sender: TObject );
begin
  with PropertiesDlg do
  begin
    ImageEn1.Assign ( ImageENView1.Bitmap );
    ShowPropertyIOParams ( ImageENView1.IO.Params );
    ShowModal;
  end;
end;

// PrintPreview
procedure TFormMain.PrintPreview1Execute ( Sender: TObject );
begin
  ImageEnView1.IO.DoPrintPreviewDialog ( iedtMaxi, '' );
end;

procedure TFormMain.FormKeyDown ( Sender: TObject;var Key: Word;
  Shift: TShiftState );
begin
  if Key = vk_ESCAPE then
  begin
    TrackBarZoom.Position := 100;
    ImageENView1.Zoom := 100;
  end;
end;

// BlackandWhite
procedure TFormMain.BlackandWhite1Click ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Black && White ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progressbar
  ProgressBar1.Visible := True;
  fConvBW := TfConvBW.Create ( Self );
  try
    // Show BW Dialog and process image
    with fConvBW do
      if ShowModal = mrOK then
      begin
        Application.ProcessMessages;
        case RadioGroup1.ItemIndex of
          0:
            begin // Threshold
              if SpeedButton1.Down then
                ImageENView1.Proc.ConvertToBWThreshold ( -1 )
              else
                ImageENView1.Proc.ConvertToBWThreshold ( strtointdef ( Edit1.Text, 0 ) );
            end;
          1:
            begin // Ordered
              ImageENView1.Proc.ConvertToBWOrdered;
            end;
        end;
      end;
  finally fConvBW.Free; end;
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
end;

// Properties
procedure TFormMain.Properties12Click ( Sender: TObject );
begin
  with PropertiesDlg do
  begin
    if FileExists ( fPathFilename ) then
    begin
      ImageEn1.Assign ( ImageENView1.Bitmap );
      ShowPropertyIOParams ( ImageENView1.IO.Params );
      ShowModal;
    end
    else
      MessageDlg ( 'Image must be opened from disk to enable properties dialog.',
        mtInformation, [mbOK], 0 );
  end;
end;

// SetupPrinter
procedure TFormMain.Setup1Click ( Sender: TObject );
begin
  PrinterSetupDialog1.Execute;
end;

// setup TrackBarZoom
procedure TFormMain.TrackBarZoomChange ( Sender: TObject );
begin
  // Show zoom change
  ImageENView1.Zoom :=
    TrackBarZoom.Position;
  // Show hint
  TrackBarZoom.Hint := 'Zoom - ' + IntToStr ( TrackBarZoom.Position ) + '%';
  Application.ActivateHint ( Mouse.CursorPos );
  ImageEnView1.SetFocus;
end;

// Reset Zoom
procedure TFormMain.ViewReset1Execute ( Sender: TObject );
begin
  TrackBarZoom.Position := 100;
  ImageENView1.Zoom := 100;
  ViewFit1.Checked := false;
end;

// ResetUndo
procedure TFormMain.EditResetUndo1Execute ( Sender: TObject );
begin
  ImageENView1.Proc.ClearAllUndo;
end;

// UpdateUndoMenu
procedure TFormMain.UpdateUndoMenu;
begin
  with ImageENView1.Proc do begin
    // Undo menu
    EditUndo1.Caption := '&Undo ';
    EditUndo1.Enabled := UndoCount > 0;
    if UndoCount > 0 then
      EditUndo1.Caption := '&Undo ' + UndoCaptions[0];
      // Redo menu
    EditRedo1.Caption := '&Redo ';
    EditRedo1.Enabled := RedoCount > 0;
    if RedoCount > 0 then
      EditRedo1.Caption := '&Redo ' + RedoCaptions[0];
  end;
end;

// Paste
procedure TFormMain.EditPaste2Execute ( Sender: TObject );
begin
  if Clipboard.HasFormat ( CF_PICTURE ) then
  begin
    // save Undo file
    ImageENView1.Proc.SaveUndoCaptioned ( 'Paste ' + IntToStr ( ImageENView1.Proc.UndoCount ) );
    ImageENView1.Proc.ClearAllRedo;
    // paste
    ImageENView1.Proc.PasteFromClipboard;
    if ImageENView1.Proc.UndoCount > 0 then
      StatusBar1.Panels[5].Text := 'Undo: ' +
        IntToStr ( ImageENView1.Proc.UndoCount )
    else
      StatusBar1.Panels[5].Text := '';
    if ImageENView1.Bitmap.Modified then
      StatusBar1.Panels[6].Text := 'Modified'
    else
      StatusBar1.Panels[6].Text := '';
  end
  else
    MessageDlg ( 'There is no image in the Clipboard.', mtInformation, [mbOK], 0 );
end;

// SelectionOptions
procedure TFormMain.OptionsSelection1Execute ( Sender: TObject );
begin
  SelectionDialog.ShowModal;
end;

// Select Rectangle
procedure TFormMain.Rectangle1Click ( Sender: TObject );
begin
  // Select rect
  ImageENView1.MouseInteract := [miSelect];
  ImageENView1.Cursor := 1785;
end;

// Select
procedure TFormMain.Circle1Click ( Sender: TObject );
begin
    // Select circle
  ImageENView1.MouseInteract := [miSelectCircle];
  ImageENView1.Cursor := 1785;
end;

// Select
procedure TFormMain.Polygon3Click ( Sender: TObject );
begin
    // Select polygon
  ImageENView1.MouseInteract := [miSelectPolygon];
  ImageENView1.Cursor := 1785;
end;

// Select
procedure TFormMain.MagicWand2Click ( Sender: TObject );
begin
  ImageENView1.MouseInteract := [miSelectMagicWand];
  ImageENView1.Cursor := 1785;
  PopupMenu1.AutoPopup := true;
end;

// Select
procedure TFormMain.Lasso2Click ( Sender: TObject );
begin
  ImageENView1.MouseInteract := [miSelectLasso];
  ImageENView1.Cursor := 1785;
  PopupMenu1.AutoPopup := true;
end;

// Select
procedure TFormMain.Move2Click ( Sender: TObject );
begin
  // Hand
  ImageENView1.MouseInteract := [miScroll];
  ImageENView1.Cursor := 1782;
end;

// Select
procedure TFormMain.Zoom2Click ( Sender: TObject );
begin
    // Zoom
  ImageENView1.MouseInteract := [miZoom, miScroll];
  ImageENView1.Cursor := 1779;
end;

// Select
procedure TFormMain.SelectRect1Execute ( Sender: TObject );
begin
  // Select rect
  ImageENView1.MouseInteract := [miSelect];
  ImageENView1.Cursor := 1785;
end;

// Select
procedure TFormMain.SelectCircle1Execute ( Sender: TObject );
begin
  // Select circle;
  ImageENView1.MouseInteract := [miSelectCircle];
  ImageENView1.Cursor := 1785;
end;

// Select
procedure TFormMain.SelectLasso1Execute ( Sender: TObject );
begin
  ImageENView1.MouseInteract := [miSelectLasso];
  ImageENView1.Cursor := 1785;
end;

// Select
procedure TFormMain.SelectMove1Execute ( Sender: TObject );
begin
  // Hand
  ImageENView1.MouseInteract := [miScroll];
  ImageENView1.Cursor := 1782;
end;

// Select
procedure TFormMain.SelectZoom1Execute ( Sender: TObject );
begin
  // Zoom
  ImageENView1.MouseInteract := [miZoom, miScroll];
  ImageENView1.Cursor := 1779;
end;

procedure TFormMain.Button7Click ( Sender: TObject );
begin
  OpenImageEnDialog1.FileName := '';
  OpenImageEnDialog1.InitialDir := '';
  OpenImageEnDialog1.DefaultExt := 'bmp';
  // Open an image file
  if OpenImageEnDialog1.Execute then
  begin
    ImageENView1.Cursor := crHandPoint;
    // Set MouseInteract
    ImageENView1.MouseInteract := ImageENView1.MouseInteract + [miSelect];
    // Set filename and path
    fFilename := ExtractFilename ( OpenImageEnDialog1.Filename );
    fPathFilename := OpenImageEnDialog1.FileName;
    // If file exists then load it
    if FileExists ( fPathFilename ) then
    begin
      // Show progress bar
      ProgressBar1.Visible := True;
      // Load the file
      ImageENView1.IO.LoadFromFile ( fPathFilename );
      // Set progress bar position to 0 and hide it
      ProgressBar1.Position := 0;
      ProgressBar1.Visible := False;
      ImageENView1.IO.ParamsFromFile ( fPathFilename );
      if ImageENView1.IO.Params.FileType <> ioUnknown then
        ShowIOParams ( ImageENView1.IO.Params );
      // Show image dimensions
      StatusBar1.Panels[1].Text := ' Height: ' + IntToStr ( ImageENView1.Bitmap.Height ) +
        ' pixels' + '  Width: ' + IntToStr ( ImageENView1.Bitmap.Width ) + ' pixels ';
      ImageENView1.Visible := True;
    end;
  end;
end;

// GrayScale Image
procedure TFormMain.ImageGrayScale1Execute ( Sender: TObject );
begin
  // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Convert to Grayscale ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  ProgressBar1.Visible := True;
  // Process image
  ImageENView1.Proc.ConvertToGray;
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := 'Grayscale ' +
    PixelFormatToColors ( ImageENView1.Bitmap.PixelFormat );
  UpdateUndoMenu;
end;

// Set magic wand tolerance
procedure TFormMain.SelectWandTolerance1Execute ( Sender: TObject );
var
  MagicWandTolerance: integer;
  MagicWandToleranceStr: string;
begin
  MagicWandToleranceStr := IntToStr ( ImageENView1.MagicWandTolerance );
  MagicWandToleranceStr := InputBox ( 'Selection Tolerance', 'Tolerance', MagicWandToleranceStr );
  MagicWandTolerance := StrToInt ( MagicWandToleranceStr );
  ImageENView1.MagicWandTolerance := MagicWandTolerance;
end;

// ImageColorAdjust
procedure TFormMain.ImageColorAdjust1Execute ( Sender: TObject );
begin
  ImageENView1.Proc.SaveUndoCaptioned ( 'Color Adjust ' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  ImageENView1.Proc.PreviewsParams := [prppDefaultLockPreview];
  ImageENView1.Proc.DoPreviews ( ppeColorAdjust );
  UpdateUndoMenu;
end;

// ToolButton19Click
procedure TFormMain.ToolButton19Click ( Sender: TObject );
begin
  with ImageENView1.Proc do begin
    SaveUndoCaptioned ( RedoCaptions[0] ); // saves in Undo List
    Redo;
    ClearRedo;
  end;
  UpdateUndoMenu;
end;

// EditRedo1Execute
procedure TFormMain.EditRedo1Execute ( Sender: TObject );
begin
  with ImageENView1.Proc do begin
    SaveUndoCaptioned ( RedoCaptions[0] ); // saves in Undo List
    Redo;
  end;
  UpdateUndoMenu;
end;

// FullScreen
procedure TFormMain.ImageEnView1DblClick ( Sender: TObject );
begin
  FullScreen := TFullScreen.Create ( Self );
  try
    Screen.Cursor := crDefault;
      // Copy image to fullscreen image
    FullScreen.ImageEnView1.Bitmap.Assign ( ImageENView1.Bitmap );
      // Show the image fullscreen
    FullScreen.Showmodal;
    Screen.Cursor := crDefault;
  except FullScreen.Free; end;
end;

// ImageEnView1ViewChange
procedure TFormMain.ImageEnView1ViewChange ( Sender: TObject;
  Change: Integer );
begin
  TrackBarZoom.Position := Round ( ImageENView1.Zoom );
end;

// ImageEnView1MouseDown
procedure TFormMain.ImageEnView1MouseDown ( Sender: TObject;
  Button: TMouseButton;Shift: TShiftState;X, Y: Integer );
var
  P1: TPoint;
begin
  ImageENView1.SetFocus;
  // if not in zoom mode then popupmenu
  if ImageENView1.MouseInteract <> [miZoom,
    miScroll] then
    if Button = mbRight then
    begin
      // get cursor position
      GetCursorPos ( P1 );
      PopupMenu1.Popup ( P1.x, P1.y );
    end;
end;

// ImageEnView1ImageChange
procedure TFormMain.ImageEnView1ImageChange ( Sender: TObject );
begin
  TrackBarZoom.Position := Round ( ImageENView1.Zoom );
end;

// Image256IEOrdered
procedure TFormMain.Image256IEOrdered1Execute ( Sender: TObject );
begin
    // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( '256 Color ieordered' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progressbar
  ProgressBar1.Visible := True;
  // Convert to 256 colors
  ImageENView1.Proc.ConvertTo ( 256, ieordered );
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := '256 Color IEOrdered';
  UpdateUndoMenu;
end;

// ImageConvertTo8Bit
procedure TFormMain.ImageConvertTo8Bit1Execute ( Sender: TObject );
begin
    // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( '8 Bit, 256 Color' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Convert to 256 colors
  ImageENView1.Proc.ConvertTo ( 256, ieordered );
  // prepair to save 256 colormapped bitmap
  ImageEnView1.IO.Params.BitsPerSample := 8;
  ImageEnView1.IO.Params.SamplesPerPixel := 1;
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := '8 Bit, 256 Color ';
  UpdateUndoMenu;
  SaveImageEnDialog1.FileName := '';
  SaveImageEnDialog1.DefaultExt := fDefaultExtension;
  SaveImageEnDialog1.InitialDir := fDefaultFolder;
  // Launch save image dialog
  if SaveImageEnDialog1.Execute then
  begin
    fSaveAs := True;
    // Show progressbar
    ProgressBar1.Visible := True;
    // Set filename
    fFilename := SaveImageEnDialog1.FileName;
    fPathFilename := SaveImageEnDialog1.FileName;
    fDefaultFolder := ExtractFileDir ( SaveImageEnDialog1.FileName );
    // Execute filesave
    ImageENView1.IO.SaveToFile ( fPathFilename );
    // Hide progressbar
    ProgressBar1.Visible := False;
  end;
end;

// ImageImageConvertTo24Bit
procedure TFormMain.ImageImageConvertTo24Bit1Execute ( Sender: TObject );
begin
    // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'True Color, 24 Bit' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  ImageENView1.Proc.ConvertTo24Bit;
  // prepairs to save 24 bit bitmap
  ImageEnView1.IO.Params.BitsPerSample := 8;
  ImageEnView1.IO.Params.SamplesPerPixel := 3;
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
  ImageENView1.Refresh;
  StatusBar1.Panels[4].Text := 'True Color, 24 Bit ';
  UpdateUndoMenu;
  SaveImageEnDialog1.FileName := '';
  SaveImageEnDialog1.DefaultExt := fDefaultExtension;
  SaveImageEnDialog1.InitialDir := fDefaultFolder;
  // Launch save image dialog
  if SaveImageEnDialog1.Execute then
  begin
    fSaveAs := True;
    // Show progressbar
    ProgressBar1.Visible := True;
    // Set filename
    fFilename := SaveImageEnDialog1.FileName;
    fPathFilename := SaveImageEnDialog1.FileName;
    fDefaultFolder := ExtractFileDir ( SaveImageEnDialog1.FileName );
    // Execute filesave
    ImageENView1.IO.SaveToFile ( fPathFilename );
    // Hide progressbar
    ProgressBar1.Visible := False;
  end;
end;

// ImageDoPreviews
procedure TFormMain.ImageDoPreviews1Execute ( Sender: TObject );
begin
     // Save undo file
  ImageENView1.Proc.SaveUndoCaptioned ( 'Do Previews' +
    IntToStr ( ImageENView1.Proc.UndoCount ) );
  ImageENView1.Proc.ClearAllRedo;
  // Show progressbar
  ProgressBar1.Visible := True;
  StatusBar1.Panels[4].Text := 'Do Previews ';
  UpdateUndoMenu;
  SaveImageEnDialog1.FileName := '';
  SaveImageEnDialog1.DefaultExt := fDefaultExtension;
  SaveImageEnDialog1.InitialDir := fDefaultFolder;
  // Launch save image dialog
  if SaveImageEnDialog1.Execute then
  begin
    // Set filename
    fFilename := SaveImageEnDialog1.FileName;
    fPathFilename := SaveImageEnDialog1.FileName;
    fDefaultFolder := ExtractFileDir ( SaveImageEnDialog1.FileName );
    ImageENView1.IO.PreviewsParams := [ioppDefaultLockPreview, ioppApplyButton];
    if ImageENView1.IO.DoPreviews ( [ppAll] ) then
    // Execute filesave
      ImageENView1.IO.SaveToFile ( fPathFilename );
  end;
end;

// SelectionProperties
procedure TFormMain.SelectionProperties1Execute ( Sender: TObject );
begin
  SelectionDialog.ShowModal;
end;

// ImageRotate
procedure TFormMain.ImageRotate1Execute(Sender: TObject);
begin
  fRotate.ImageEnView1.Assign(ImageENView1);
  ProgressBar1.Visible := True;
  // Show rotate dialog
  if fRotate.ShowModal = mrOK then
    ImageEnView1.Proc.Rotate(fRotate.Updown1.Position, fRotate.Checkbox1.Checked);
  ProgressBar1.Position := 0;
  ProgressBar1.Visible := False;
end;

procedure TFormMain.ImageLosslessTransform1Execute(Sender: TObject);
begin
  LosslessTransform.ImageEnView1.Assign(ImageEnView1);
  if LosslessTransform.ShowModal = mrOK then
    begin
       // Save undo file
      ImageENView1.Proc.SaveUndoCaptioned ( 'Lossless Transform' + IntToStr ( ImageENView1.Proc.UndoCount ) );
      ImageENView1.Proc.ClearAllRedo;
      ImageEnView1.Assign(LosslessTransform.ImageEnView2);
      ImageEnView1.Update;
    end;
end;

end.

