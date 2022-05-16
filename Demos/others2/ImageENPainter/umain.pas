//------------------------------------------------------------------------------
  //  ImageEN Painter    : Version 1.0
  //  Copyright (c) 2007 : Adirondack Software & Graphics
  //  Created            : 05-25-2007
  //  Last Modification  : 05-25-2007
  //  Description        : Main Unit
//------------------------------------------------------------------------------

unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ExtCtrls, StdCtrls, Buttons, ComCtrls, ImgList,
  ToolWin, ExtDlgs, ieopensavedlg, IniFiles, ActnList;

type
  TFrmMain = class ( TForm )
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    ScrollBar1: TScrollBar;
    ColorDialog1: TColorDialog;
    PageControl1: TPageControl;
    PaintTab: TTabSheet;
    DrawTab: TTabSheet;
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    PageControl2: TPageControl;
    FileTab2: TTabSheet;
    FileToolBar: TToolBar;
    New1: TToolButton;
    Open2: TToolButton;
    Save1: TToolButton;
    SaveAs: TToolButton;
    ToolButton5: TToolButton;
    Exit: TToolButton;
    EditTab2: TTabSheet;
    SelectTab2: TTabSheet;
    HelpTab2: TTabSheet;
    EditToolBar: TToolBar;
    Undo1: TToolButton;
    Redo1: TToolButton;
    Cut1: TToolButton;
    SelectToolBar: TToolBar;
    SelectRectangle1: TToolButton;
    SelectEllipse1: TToolButton;
    SelectNone1: TToolButton;
    ConvertTab2: TTabSheet;
    ConvertToolBar: TToolBar;
    ConvertTo32Bit1: TToolButton;
    ConvertTo24Bit1: TToolButton;
    ConvertTo8Bit1: TToolButton;
    ConvertTo4Bit1: TToolButton;
    HelpToolBar: TToolBar;
    About1: TToolButton;
    HomePage1: TToolButton;
    SelectZoom1: TToolButton;
    Copy1: TToolButton;
    Paste1: TToolButton;
    ToolButton7: TToolButton;
    Resize1: TToolButton;
    Resample1: TToolButton;
    Crop1: TToolButton;
    Rotate1: TToolButton;
    Flip1: TToolButton;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    ToolButton2: TToolButton;
    SelectLasso1: TToolButton;
    ToolBar8: TToolBar;
    Undo2: TToolButton;
    Redo2: TToolButton;
    ToolButton6: TToolButton;
    ImageList2: TImageList;
    ToolBar9: TToolBar;
    ImageList3: TImageList;
    SelectPolygon1: TToolButton;
    SelectMagicWand1: TToolButton;
    GroupBox2: TGroupBox;
    MagicWandTolerance1: TEdit;
    Label10: TLabel;
    UpDown2: TUpDown;
    IEMagicWandMode1: TComboBox;
    Label11: TLabel;
    MagicWandMaxFilter1: TCheckBox;
    TabSheet7: TTabSheet;
    GroupBox3: TGroupBox;
    DisplayGrid1: TCheckBox;
    BMP_HandleTransparency1: TCheckBox;
    EnableAlphaChannel1: TCheckBox;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    PaintColor: TPanel;
    Label1: TLabel;
    TransparentColor: TPanel;
    Filled1: TCheckBox;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    FillTolerance1: TEdit;
    Updown7: TUpDown;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Label2: TLabel;
    BrushSize: TEdit;
    UpDown1: TUpDown;
    Label3: TLabel;
    BrushColor: TPanel;
    Label4: TLabel;
    Transparency: TEdit;
    Label5: TLabel;
    Operation: TComboBox;
    Antialias: TCheckBox;
    ViewTab2: TTabSheet;
    ViewToolBar: TToolBar;
    N100: TToolButton;
    Fit1: TToolButton;
    DrawTab2: TTabSheet;
    PaintTab2: TTabSheet;
    SaveImageEnDialog1: TSaveImageEnDialog;
    Transparent1: TCheckBox;
    Opacity1: TEdit;
    Label12: TLabel;
    UpDown3: TUpDown;
    SaveSelection1: TToolButton;
    RestoreSelection1: TToolButton;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    NewWidth1: TEdit;
    NewHeight1: TEdit;
    DrawToolBar: TToolBar;
    PaintPoint: TToolButton;
    PaintLine: TToolButton;
    PaintEllipse: TToolButton;
    PaintRectangle: TToolButton;
    PickColor1: TToolButton;
    PickTransparent1: TToolButton;
    Erase1: TToolButton;
    Fill1: TToolButton;
    ToolBar1: TToolBar;
    RectangleButton: TToolButton;
    CircleButton: TToolButton;
    PointsButton: TToolButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    ToolButton1: TToolButton;
    TabSheet2: TTabSheet;
    ImageEnView2: TImageEnView;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    UndoLimit1: TEdit;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    Panel1: TPanel;
    Label14: TLabel;
    FillColor: TPanel;
    Help1: TToolButton;
    AutoFitOnLoad1: TCheckBox;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    UpDown8: TUpDown;
    DrawBorderOpague1: TCheckBox;
    ToolButton8: TToolButton;
    PopupMenuMRU: TPopupMenu;
    RecentFiles1: TMenuItem;
    Clear1: TMenuItem;
    BackGroundColor: TPanel;
    Label15: TLabel;
    procedure Open1Click ( Sender: TObject );
    procedure Exit1Click ( Sender: TObject );
    procedure ScrollBar1Change ( Sender: TObject );
    procedure BrushColorClick ( Sender: TObject );
    procedure FormCreate ( Sender: TObject );
    procedure ImageEnView1MouseMove ( Sender: TObject; Shift: TShiftState; X,
      Y: Integer );
    procedure CreateBrush ( Sender: TObject );
    procedure ImageEnView1MouseDown ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure DisplayGrid1Click ( Sender: TObject );
    procedure PaintColorClick ( Sender: TObject );
    procedure PageControl1Change ( Sender: TObject );
    procedure New1Click ( Sender: TObject );
    procedure About1Click ( Sender: TObject );
    procedure ConvertTo32Bit1Click ( Sender: TObject );
    procedure ConvertTo24Bit1Click ( Sender: TObject );
    procedure ConvertTo8Bit1Click ( Sender: TObject );
    procedure ConvertTo4Bit1Click ( Sender: TObject );
    procedure PickTransparent1Click ( Sender: TObject );
    procedure Resize1Click ( Sender: TObject );
    procedure Resample1Click ( Sender: TObject );
    procedure Rotate1Click ( Sender: TObject );
    procedure Flip1Click ( Sender: TObject );
    procedure TransparentColorClick ( Sender: TObject );
    procedure SaveAsClick ( Sender: TObject );
    procedure Fill1Click ( Sender: TObject );
    procedure ImageEnView1MouseUp ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure PointsButtonClick ( Sender: TObject );
    procedure PickColor1Click ( Sender: TObject );
    procedure Undo1Click ( Sender: TObject );
    procedure Redo1Click ( Sender: TObject );
    procedure Cut1Click ( Sender: TObject );
    procedure Copy1Click ( Sender: TObject );
    procedure Paste1Click ( Sender: TObject );
    procedure Crop1Click ( Sender: TObject );
    procedure SelectNone1Click ( Sender: TObject );
    procedure SelectRectangle1Click ( Sender: TObject );
    procedure SelectEllipse1Click ( Sender: TObject );
    procedure SelectZoom1Click ( Sender: TObject );
    procedure ToolButton2Click ( Sender: TObject );
    procedure SelectLasso1Click ( Sender: TObject );
    procedure RectangleButtonClick ( Sender: TObject );
    procedure CircleButtonClick ( Sender: TObject );
    procedure EnableAlphaChannel1Click ( Sender: TObject );
    procedure HomePage1Click ( Sender: TObject );
    procedure Erase1Click ( Sender: TObject );
    procedure BMP_HandleTransparency1Click ( Sender: TObject );
    procedure SelectPolygon1Click ( Sender: TObject );
    procedure SelectMagicWand1Click ( Sender: TObject );
    procedure MagicWandTolerance1Change ( Sender: TObject );
    procedure IEMagicWandMode1Change ( Sender: TObject );
    procedure MagicWandMaxFilter1Click ( Sender: TObject );
    procedure PaintPointClick ( Sender: TObject );
    procedure PaintLineClick ( Sender: TObject );
    procedure Fit1Click ( Sender: TObject );
    procedure N100Click ( Sender: TObject );
    procedure ImageEnView1ViewChange ( Sender: TObject; Change: Integer );
    procedure FormResize ( Sender: TObject );
    procedure ImageEnView1ImageChange ( Sender: TObject );
    procedure PageControl2Change ( Sender: TObject );
    procedure Transparent1Click ( Sender: TObject );
    procedure Opacity1Change ( Sender: TObject );
    procedure SaveSelection1Click ( Sender: TObject );
    procedure RestoreSelection1Click ( Sender: TObject );
    procedure PaintEllipseClick ( Sender: TObject );
    procedure PaintRectangleClick ( Sender: TObject );
    procedure UndoLimit1Change ( Sender: TObject );
    procedure FillColorClick ( Sender: TObject );
    procedure Help1Click ( Sender: TObject );
    procedure Save1Click ( Sender: TObject );
    procedure FormDestroy ( Sender: TObject );
    procedure xx1Click ( Sender: TObject );
    procedure FormActivate ( Sender: TObject );
    procedure Clear1Click ( Sender: TObject );
    procedure PopupMenuMRUChange ( Sender: TObject; Source: TMenuItem;
      Rebuild: Boolean );
    procedure BackGroundColorClick ( Sender: TObject );
  private
    { Private declarations }
    startX, startY: integer;
    lastX, lastY: integer;
    FilePath: string;
    OldPaintColor: TColor;
    FConfig: TIniFile;
    MRUFiles: TStringList;
    procedure UpdateStatusBar;
    procedure UpdateUndoMenu;
    procedure MRUItemClick ( Sender: TObject );
  public
    { Public declarations }
    Alpha: integer;
    procedure SetTransparent;
  end;

var
  FrmMain: TFrmMain;

implementation

uses HYIEDefs, HYIEUtils, ImageENIO, ImageENProc, Clipbrd, ShellAPI, ActiveX,
  ShlObj, StrUtils, uAbout, uMsg, upick, uResize, uRotate, uPaste, uFlip, uHelp;

{$R *.DFM}

// Add a thousand separator to a string

function AddThousandSeparator ( S: string; Chr: Char ): string;
var
  I: Integer;
begin
  Result := S;
  I := Length ( S ) - 2;
  while I > 1 do
  begin
    Insert ( Chr, Result, I );
    I := I - 3;
  end;
end;

function PathToDir ( const Path: string ): string;
begin
  Result := Path;
  if ( Path <> '' ) and ( Path [ Length ( Path ) ] = '\' ) then
    Delete ( Result, Length ( Result ), 1 );
end;

// Returns true if given name is a valid directory and false
// otherwise. DirName can be any file system name (with or
// without trailing path delimiter).

function IsDirectory ( const DirName: string ): Boolean;
var
  Attr: Integer; // directory's file attributes
begin
  Attr := SysUtils.FileGetAttr ( DirName );
  Result := ( Attr <> -1 ) and ( Attr and SysUtils.faDirectory
    = SysUtils.faDirectory );
end;

// Ensures that the given folder and its sub folders exist, and creates them if  they do not. Uses recursion.

procedure EnsureFolders ( Path: string );
var
  SlashPos: Integer; // position of last backslash in path
  SubPath: string; // immediate parent folder of given path
begin
  // Check there's a path to create
  if Length ( Path ) = 0 then
    Exit;
  // Remove any trailing '\'
  Path := PathToDir ( Path );
  // Check if folder exists and quit if it does - we're done
  if IsDirectory ( Path ) then
    Exit;
  // Recursively call routine on immediate parent folder
  // remove bottomost folder from path - ie move up to parent folder
  SubPath := Path;
  SlashPos := Length ( SubPath );
  while ( SlashPos > 2 ) and ( SubPath [ SlashPos ] <> '\' ) do
    Dec ( SlashPos );
  Delete ( SubPath, SlashPos, Length ( Path ) - SlashPos + 1 );
  // do recursive call - ensures that parent folder of current path exist
  EnsureFolders ( SubPath );
  // Create this current folder now we know parent folder exists
  SysUtils.CreateDir ( Path );
end;

procedure SetSquarePen ( Canvas: TCanvas; Color: TColor; Width: integer );
var
  LogBrush: TLOGBRUSH;
begin
  if Width > 1 then
  begin
    LogBrush.lbStyle := BS_Solid;
    LogBrush.lbColor := Color;
    LogBrush.lbHatch := 0;
    Canvas.Pen.Handle := ExtCreatePen ( PS_Geometric or PS_Solid or
      PS_ENDCAP_SQUARE, Width, LogBrush, 0, nil );
  end
  else
  begin
    Canvas.Pen.Color := Color;
    Canvas.Pen.Width := Width;
    Canvas.Pen.Style := psSolid;
  end;
end;

//FormCreate

procedure TFrmMain.FormActivate ( Sender: TObject );
begin
  Open2.Enabled := True;
  Open2.Indeterminate := False;
end;

procedure TFrmMain.FormCreate ( Sender: TObject );
var
  Path: string;
  Allocator: IMalloc;
  SpecialDir: PItemIdList;
  FBuf: array [ 0..MAX_PATH ] of Char;
  Item: TMenuItem;
  i: integer;
begin
  with ImageENView1 do begin
    EnableAlphaChannel := True;
    LayersSync := false;
    MinBitmapSize := 1;
    DisplayGrid := true;
    Proc.Fill ( CreateRGB ( 255, 255, 255 ) );
    Proc.AutoUndo := False;
    Proc.UndoLimit := 25;
    BackGroundStyle := iebsChessboard;
    SetChessboardStyle ( 6, bsSolid );
    Proc.Clear;
    Proc.ImageResize ( StrToIntDef ( NewWidth1.Text, 640 ), StrToIntDef ( NewHeight1.Text, 480 ), iehLeft, ievTop );
    Proc.CastColor ( 0, 0, TColor2TRGB ( clGradientActiveCaption ), 1 );
    TransparentColor.Color := clGradientActiveCaption;
    Proc.ClearUndo;
    IO.Params.Width := IEBitmap.Width;
    IO.Params.Height := IEBitmap.Height;
    Bitmap.Modified := False;
    SetNavigator ( ImageEnView2 );
  end;
  Operation.ItemIndex := 0;
  OldPaintColor := clBlack;
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  MRUFiles := TStringList.Create;
  MRUFiles.Capacity := 8;
  UpdateUndoMenu;
  Undo1.Enabled := false;
  UpdateStatusBar;
  // Load Application Settings from ini file
  if SHGetMalloc ( Allocator ) = NOERROR then
  begin
    SHGetSpecialFolderLocation ( FrmMain.Handle, CSIDL_LOCAL_APPDATA, SpecialDir );
    SHGetPathFromIDList ( SpecialDir, @FBuf [ 0 ] );
    Allocator.Free ( SpecialDir );
    Path := string ( FBuf ) + '\ImageENPainter';
    // Create folder
    EnsureFolders ( Path );
  end;

  FConfig := TIniFile.Create ( Path + '\ImageENPainter.INI' );
  try
    FrmMain.Left := FConfig.ReadInteger ( 'Settings', 'Left', 0 );
    FrmMain.Top := FConfig.ReadInteger ( 'Settings', 'Top', 0 );
    FrmMain.Height := FConfig.ReadInteger ( 'Settings', 'Height', 600 );
    FrmMain.Width := FConfig.ReadInteger ( 'Settings', 'Width', 800 );
    DisplayGrid1.Checked := FConfig.ReadBool ( 'Settings', 'Display Grid', False );
    BMP_HandleTransparency1.Checked := FConfig.ReadBool ( 'Settings', 'BMP HandleTransparency', True );
    EnableAlphaChannel1.Checked := FConfig.ReadBool ( 'Settings', 'Enable AlphaChannel', False );
    AutoFitOnLoad1.Checked := FConfig.ReadBool ( 'Settings', 'AutoFitOnLoad', True );
    NewWidth1.Text := FConfig.ReadString ( 'Settings', 'New Image Width', '640' );
    NewHeight1.Text := FConfig.ReadString ( 'Settings', 'New Image Height', '480' );
    BackGroundColor.Color := FConfig.ReadInteger ( 'Settings', 'New Image BackGround Color', clBtnFace );
    UndoLimit1.Text := FConfig.ReadString ( 'Settings', 'Undo Limit', '25' );
  finally; FConfig.Free; end;
  if FileExists ( Path + '\ImageENPainterMRU.txt' ) then
  begin
    MRUFiles.LoadFromFile ( Path + '\ImageENPainterMRU.txt' );
    for i := 0 to MRUFiles.Count - 1 do begin
      Item := TMenuItem.Create ( PopupMenuMRU );
      Item.Caption := MRUFiles.Strings [ i ];
      Item.OnClick := MRUItemClick;
      PopupMenuMRU.Items.Add ( Item );
    end;
  end;
end;

procedure TFrmMain.FormDestroy ( Sender: TObject );
var
  Path: string;
  Allocator: IMalloc;
  SpecialDir: PItemIdList;
  FBuf: array [ 0..MAX_PATH ] of Char;
begin
  // Save Application Settings to ini file
  if SHGetMalloc ( Allocator ) = NOERROR then
  begin
    SHGetSpecialFolderLocation ( FrmMain.Handle, CSIDL_LOCAL_APPDATA, SpecialDir );
    SHGetPathFromIDList ( SpecialDir, @FBuf [ 0 ] );
    Allocator.Free ( SpecialDir );
    Path := string ( FBuf ) + '\ImageENPainter';
    // Create folder
    EnsureFolders ( Path );
  end;

  FConfig := TIniFile.Create ( Path + '\ImageENPainter.ini' );
  try
    FConfig.WriteInteger ( 'Settings', 'Left', FrmMain.Left );
    FConfig.WriteInteger ( 'Settings', 'Top', FrmMain.Top );
    FConfig.WriteInteger ( 'Settings', 'Height', FrmMain.Height );
    FConfig.WriteInteger ( 'Settings', 'Width', FrmMain.Width );
    FConfig.WriteBool ( 'Settings', 'Display Grid', DisplayGrid1.Checked );
    FConfig.WriteBool ( 'Settings', 'BMP HandleTransparency', BMP_HandleTransparency1.Checked );
    FConfig.WriteBool ( 'Settings', 'Enable AlphaChannel', EnableAlphaChannel1.Checked );
    FConfig.WriteBool ( 'Settings', 'AutoFitOnLoad', AutoFitOnLoad1.Checked );
    FConfig.WriteString ( 'Settings', 'New Image Width', NewWidth1.Text );
    FConfig.WriteString ( 'Settings', 'New Image Height', NewHeight1.Text );
    FConfig.WriteInteger ( 'Settings', 'New Image BackGround Color', BackGroundColor.Color );
    FConfig.WriteString ( 'Settings', 'Undo Limit', UndoLimit1.Text );
  finally; FConfig.Free; end;
  MRUFiles.SaveToFile ( Path + '\ImageENPainterMRU.txt' );
  MRUFiles.Free;
end;

//FormResize

procedure TFrmMain.FormResize ( Sender: TObject );
begin
  if Fit1.Down then begin
    ImageENView1.Fit;
    UpdateStatusBar;
  end;
end;

procedure TFrmMain.MRUItemClick ( Sender: TObject );
var
  fExt: string;
  fTransparentColor: TColor;
  RGB: TRGB;
  Item: TMenuItem;
begin
  ImageEnView1.LayersCurrent := 0;
  Item := Sender as TMenuItem;
  FilePath := Item.Caption;
  if FileExists ( FilePath ) then
  begin
    Screen.Cursor := crHourglass;
    try
      FrmMain.Caption := ExtractFileName ( FilePath ) + '- ImageEN Painter';
      with ImageENView1 do
      begin
        IO.LoadFromFile ( FilePath );

        RGB := IEBitmap.Pixels [ 0, IEBitmap.Height - 1 ];
        fTransparentColor := TRGB2TColor ( RGB );
        IO.Params.BMP_HandleTransparency := BMP_HandleTransparency1.Checked;

        fExt := LowerCase ( ExtractFileExt ( FilePath ) );
        if fExt = '.cur' then
          IO.Params.CUR_Background := TColor2TRGB ( fTransparentColor );
        if fExt = '.ico' then
          IO.Params.ICO_Background := TColor2TRGB ( fTransparentColor );
        if ( fExt = '.gif' ) and ( IO.Params.GIF_FlagTranspColor ) then
        begin
          IO.Params.GIF_FlagTranspColor := True;
          IO.Params.GIF_TranspColor := TColor2TRGB ( fTransparentColor );
        end;
        if fExt = '.png' then
          IO.Params.PNG_Background := TColor2TRGB ( fTransparentColor );
        if fExt = '.tga' then
          IO.Params.TGA_Background := TColor2TRGB ( fTransparentColor );

        TransparentColor.Color := fTransparentColor;
        if ( IO.Params.BitsPerSample = 8 ) and ( IO.Params.SamplesPerPixel = 4 ) then
          Proc.SetTransparentColors ( RGB, RGB, 0 );

        ScrollBar1.Position := Round ( Zoom );
        Update;
        Bitmap.Modified := False;
        if AutoFitOnLoad1.Checked then begin
          Fit;
          Fit1.Down := True;
        end;
        UpdateStatusBar;
      end;
    finally; Screen.Cursor := crDefault; end;
  end;
end;

// open internet explorer and load HomePage

procedure TFrmMain.HomePage1Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'http://www.hicomponents.com' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

// File | Open

procedure TFrmMain.Open1Click ( Sender: TObject );
var
  fExt: string;
  fTransparentColor: TColor;
  RGB: TRGB;
  Item: TMenuItem;
begin
  ImageEnView1.LayersCurrent := 0;
  OpenPictureDialog1.Filter := OpenImageEnDialog1.Filter;
  OpenPictureDialog1.FilterIndex := 0;
  OpenPictureDialog1.FileName := '';
  OpenPictureDialog1.DefaultExt := '.jpg';
  if OpenPictureDialog1.Execute then
  begin
    Screen.Cursor := crHourglass;
    try
      FilePath := OpenPictureDialog1.FileName;
      MRUFiles.Add ( FilePath );
      Item := TMenuItem.Create ( PopupMenuMRU );
      Item.Caption := FilePath;
      Item.OnClick := MRUItemClick;
      PopupMenuMRU.Items.Add ( Item );
      //Item.Free;
      FrmMain.Caption := ExtractFileName ( FilePath ) + '- ImageEN Painter';
      with ImageENView1 do
      begin
        IO.LoadFromFile ( FilePath );

        RGB := IEBitmap.Pixels [ 0, IEBitmap.Height - 1 ];
        fTransparentColor := TRGB2TColor ( RGB );
        IO.Params.BMP_HandleTransparency := BMP_HandleTransparency1.Checked;

        fExt := LowerCase ( ExtractFileExt ( FilePath ) );
        if fExt = '.cur' then
          IO.Params.CUR_Background := TColor2TRGB ( fTransparentColor );
        if fExt = '.ico' then
          IO.Params.ICO_Background := TColor2TRGB ( fTransparentColor );
        if ( fExt = '.gif' ) and ( IO.Params.GIF_FlagTranspColor ) then
        begin
          IO.Params.GIF_FlagTranspColor := True;
          IO.Params.GIF_TranspColor := TColor2TRGB ( fTransparentColor );
        end;
        if fExt = '.png' then
          IO.Params.PNG_Background := TColor2TRGB ( fTransparentColor );
        if fExt = '.tga' then
          IO.Params.TGA_Background := TColor2TRGB ( fTransparentColor );

        TransparentColor.Color := fTransparentColor;
        if ( IO.Params.BitsPerSample = 8 ) and ( IO.Params.SamplesPerPixel = 4 ) then
          Proc.SetTransparentColors ( RGB, RGB, 0 );

        ScrollBar1.Position := Round ( Zoom );
        Update;
        Bitmap.Modified := False;
        if AutoFitOnLoad1.Checked then begin
          Fit;
          Fit1.Down := True;
        end;
        UpdateStatusBar;
      end;
    finally; Screen.Cursor := crDefault; end;
  end;
end;

// EnableAlphaChannel

procedure TFrmMain.MagicWandMaxFilter1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    with ImageENView1 do begin
      MagicWandMaxFilter := MagicWandMaxFilter1.Checked;
    end;
end;

//MagicWandTolerance

procedure TFrmMain.MagicWandTolerance1Change ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    with ImageENView1 do begin
      MagicWandTolerance := StrToIntDef ( MagicWandTolerance1.Text, 15 );
    end;
end;

//Opacity1Change

procedure TFrmMain.Opacity1Change ( Sender: TObject );
begin
  Alpha := ( StrToInt ( Opacity1.Text ) * 255 ) div 100;
end;

//EnableAlphaChannel

procedure TFrmMain.UndoLimit1Change ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then begin
    ImageENView1.Proc.UndoLimit := StrToInt ( UndoLimit1.Text );
    UpdateStatusBar;
  end;
end;

procedure TFrmMain.EnableAlphaChannel1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    with ImageENView1 do begin
      EnableAlphaChannel := EnableAlphaChannel1.Checked;
      if EnableAlphaChannel1.Checked then
      begin
        BackGroundStyle := iebsChessboard;
        SetChessboardStyle ( 6, bsSolid );
      end
      else
        BackGroundStyle := iebsSolid;
    end;
end;

// Erase pixel

procedure TFrmMain.Erase1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    with ImageENView1 do
    begin
      SelectNone1.Click;
      if Erase1.Down then
        Cursor := 1781
      else
        Cursor := 1784;
    end;
end;

// Exit

procedure TFrmMain.Exit1Click ( Sender: TObject );
begin
  Close;
end;

// Save

procedure TFrmMain.Save1Click ( Sender: TObject );
var
  fExt: string;
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    if FileExists ( FilePath ) then begin
      begin
        with ImageENView1 do
        begin
          Screen.Cursor := crHourglass;
          try
            fExt := LowerCase ( ExtractFileExt ( FilePath ) );
            Proc.SaveUndo;
            // previews
            IO.Params.BMP_HandleTransparency := True;
            IO.Params.BMP_Version := ioBMP_BM3;
            IO.Params.FileType := IEExtToFileFormat ( fExt );
            if fExt <> '.ico' then
            begin
              IO.PreviewsParams := [ ioppDefaultLockPreview ];
              if IO.DoPreviews ( [ ppAUTO ] ) then
              // save to disk
                IO.SaveToFile ( FilePath );
            end
            else
            // save to disk
              IO.SaveToFile ( FilePath );
            FrmMain.Caption := ExtractFileName ( FilePath ) + '- ImageEN Painter';
            Bitmap.Modified := True;
            Proc.ClearUndo;
            Proc.ClearRedo;
            UpdateStatusbar;
          finally; Screen.Cursor := crDefault; end;
        end;
      end;
    end;
end;

// SaveAs

procedure TFrmMain.SaveAsClick ( Sender: TObject );
var
  fExt: string;
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    with ImageENView1 do
    begin
      SavePictureDialog1.Filter := SaveImageEnDialog1.Filter;
      SavePictureDialog1.FilterIndex := 1;
      SavePictureDialog1.InitialDir := ExtractFileDir ( IO.Params.FileName );
      SavePictureDialog1.FileName := ExtractFilename ( IO.Params.FileName );
      if SavePictureDialog1.Execute then
      begin
        FilePath := SavePictureDialog1.FileName;
        if FilePath <> '' then
        begin
          Screen.Cursor := crHourglass;
          try
            fExt := LowerCase ( ExtractFileExt ( FilePath ) );
            Proc.SaveUndo;
            // previews
            IO.Params.BMP_HandleTransparency := True;
            IO.Params.BMP_Version := ioBMP_BM3;
            IO.Params.FileType := IEExtToFileFormat ( fExt );
            if fExt <> '.ico' then
            begin
              IO.PreviewsParams := [ ioppDefaultLockPreview ];
              if IO.DoPreviews ( [ ppAUTO ] ) then
              // save to disk
                IO.SaveToFile ( FilePath );
            end
            else
            // save to disk
              IO.SaveToFile ( FilePath );
            FrmMain.Caption := FilePath;
            Bitmap.Modified := True;
            Proc.ClearUndo;
            Proc.ClearRedo;
            UpdateStatusbar;
          finally; Screen.Cursor := crDefault; end;
        end;
      end;
    end;
end;

// Change Zoom

procedure TFrmMain.ScrollBar1Change ( Sender: TObject );
begin
  ImageEnView1.Zoom := ScrollBar1.Position;
  UpdateStatusbar;
end;

// Select Ellipse

procedure TFrmMain.SelectEllipse1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1804;
      MouseInteract := [ miSelectCircle ];
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintEllipse.Down := False;
      PickColor1.Down := False;
      PickTransparent1.Down := False;
      Fill1.Down := False;
    end;
  end;
end;

// Select Lasso

procedure TFrmMain.SelectLasso1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1804;
      MouseInteract := [ miSelectLasso ];
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintEllipse.Down := False;
      PickColor1.Down := False;
      PickTransparent1.Down := False;
      Fill1.Down := False;
    end;
  end;
end;

procedure TFrmMain.SelectMagicWand1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1808;
      MouseInteract := [ miSelectMagicWand ];
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintEllipse.Down := False;
      PickColor1.Down := False;
      PickTransparent1.Down := False;
      Fill1.Down := False;
    end;
  end;
end;

// Select None

procedure TFrmMain.SelectNone1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1784;
      MouseInteract := [ ];
      Deselect;
    end;
  end;
end;

// Select Polygon

procedure TFrmMain.SelectPolygon1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1803;
      MouseInteract := [ miSelectPolygon ];
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintEllipse.Down := False;
      PickColor1.Down := False;
      PickTransparent1.Down := False;
      Fill1.Down := False;
    end;
  end;
end;

// Select Rectangle

procedure TFrmMain.SelectRectangle1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1808;
      MouseInteract := [ miSelect ];
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintEllipse.Down := False;
      PickColor1.Down := False;
      PickTransparent1.Down := False;
      Fill1.Down := False;
    end;
  end;
end;

// Select Zoom

procedure TFrmMain.SelectZoom1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1779;
      MouseInteract := [ miZoom ];
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintEllipse.Down := False;
      PickColor1.Down := False;
      PickTransparent1.Down := False;
      Fill1.Down := False;
    end;
  end;
end;

// Select zoom

procedure TFrmMain.ToolButton2Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      Cursor := 1779;
      MouseInteract := [ miSelectZoom ];
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintPoint.Down := False;
      PaintLine.Down := False;
      PaintEllipse.Down := False;
      PickColor1.Down := False;
      PickTransparent1.Down := False;
      Fill1.Down := False;
    end;
  end;
end;

procedure TFrmMain.Help1Click ( Sender: TObject );
begin
  FrmHelp := TFrmHelp.Create ( Self );
  try
    FrmHelp.ShowModal;
  finally; FrmHelp.Free; end;
end;

// Save Selection

procedure TFrmMain.SaveSelection1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    ImageENView1.SaveSelection;
end;

// Restore Selection

procedure TFrmMain.RestoreSelection1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    ImageENView1.RestoreSelection;
end;

// Zoom to 100%

procedure TFrmMain.N100Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then begin
    if N100.Down then
      ImageENView1.Zoom := 100;
    UpdateStatusBar;
  end;
end;

// Fit

procedure TFrmMain.Fit1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then begin
    if Fit1.Down then
      ImageENView1.Fit;
    UpdateStatusBar;
  end;
end;

// Set Transparent Color

procedure TFrmMain.Transparent1Click ( Sender: TObject );
begin
  if Transparent1.Checked then
  begin
    Opacity1.Text := '0';
    Alpha := 0;
    OldPaintColor := PaintColor.Color;
    PaintColor.Color := TRGB2TColor ( ImageENView1.IO.IEBitmap.Pixels [ 0, ImageENView1.IEBitmap.Height - 1 ] );
  end
  else
  begin
    Opacity1.Text := '100';
    Alpha := 100;
    PaintColor.Color := OldPaintColor;
  end;
end;

// Transparent Color

procedure TFrmMain.TransparentColorClick ( Sender: TObject );
var
  RGB: TRGB;
begin
  ColorDialog1.Color := TransparentColor.Color;
  if ColorDialog1.Execute then begin
    TransparentColor.Color := ColorDialog1.Color;
    RGB := TColor2TRGB ( ColorDialog1.Color );
    ImageENView1.Proc.SetTransparentColors ( RGB, RGB, 0 );
  end;
end;

// ConvertTo32Bit

procedure TFrmMain.ConvertTo32Bit1Click ( Sender: TObject );
var
  RGB: TRGB;
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    FrmMsg := TFrmMsg.Create ( Self );
    try
      FrmMsg.Msg1.Caption := 'Converting To 32-bit...';
      FrmMsg.Show;
      FrmMsg.Msg1.Update;
      Sleep ( 1000 );
      with ImageENView1 do
      begin
        Proc.SaveUndoCaptioned ( 'Convert To 32-bit ' + IntToStr ( Proc.UndoCount ) );
        Undo1.Hint := 'Convert To 32-bit ' + IntToStr ( Proc.UndoCount + 1 );
        Proc.ClearAllRedo;
        IO.Params.BitsPerSample := 8;
        IO.Params.SamplesPerPixel := 4;
        EnableAlphaChannel := True;
        with Proc do
        begin
          RGB := IEBitmap.Pixels [ 0, IEBitmap.Height - 1 ];
          SetTransparentColors ( RGB, RGB, 0 );
        end;
        Update;
      end;
    finally; FrmMsg.Free; end;
  end;
  ImageEnView1.Update;
  UpdateUndoMenu;
  UpdateStatusbar;
end;

// About

procedure TFrmMain.About1Click ( Sender: TObject );
begin
  FrmAbout := TFrmAbout.Create ( Self );
  try
    FrmAbout.ShowModal;
  finally; FrmAbout.Free; end;
end;

//New

procedure TFrmMain.New1Click ( Sender: TObject );
begin
  with ImageENView1 do
  begin
    if PageControl1.ActivePage = DrawTab then
      ImageENView1.LayersRemove ( 1 );
    Blank;
    Proc.ImageResize ( StrToIntDef ( NewWidth1.Text, 640 ), StrToIntDef ( NewHeight1.Text, 480 ), iehLeft, ievTop );
    Proc.CastColor ( 0, 0, TColor2TRGB ( BackGroundColor.Color ), 1 );
    Proc.ClearUndo;
    Proc.ClearRedo;
    IO.Params.Width := IEBitmap.Width;
    IO.Params.Height := IEBitmap.Height;
    Cursor := 1785;
    PointsButton.Down := False;
  end;
  Undo1.Enabled := false;
  if AutoFitOnLoad1.Checked then
    ImageEnView1.Fit;
  UpdateStatusBar;
end;

// Fill

procedure TFrmMain.Fill1Click ( Sender: TObject );
begin
  if Fill1.Down then
  begin
    if Assigned ( ImageENView1.IEBitmap ) then
    begin
      with ImageENView1 do
      begin
        Cursor := 1799;
        MouseInteract := [ ];
        DeSelect;
      end;
    end
    else
      Cursor := 1784;
  end;
end;

procedure TFrmMain.FillColorClick ( Sender: TObject );
begin
  ColorDialog1.Color := FillColor.Color;
  if ColorDialog1.Execute then
    FillColor.Color := ColorDialog1.Color;
end;

// Flip

procedure TFrmMain.Flip1Click ( Sender: TObject );
begin
  frmFlip := TfrmFlip.Create ( Self );
  try
    with ImageENView1 do
    begin
      Proc.SaveUndoCaptioned ( 'Flip ' + IntToStr ( Proc.UndoCount ) );
      frmFlip.ImageEnView1.IEBitmap.Assign ( IEBitmap );
      frmFlip.ImageEnView1.Update;
      if frmFlip.ShowModal = mrOk then
      begin
        Screen.Cursor := crHourglass;
        try
          FrmMsg := TFrmMsg.Create ( Self );
          try
            FrmMsg.Msg1.Caption := 'Flipping the Picture...';
            FrmMsg.Show;
            FrmMsg.Msg1.Update;
            Proc.SaveUndoCaptioned ( 'Flip ' + IntToStr ( Proc.UndoCount ) );
            Undo1.Hint := 'Flip ' + IntToStr ( Proc.UndoCount + 1 );
            Proc.ClearAllRedo;
            if frmFlip.RadioGroup1.ItemIndex = 0 then
              Proc.Flip ( fdHorizontal )
            else
              Proc.Flip ( fdVertical );
            Update;
            UpdateUndoMenu;
            UpdateStatusbar;
            Sleep ( 1000 );
          finally; FrmMsg.Free; end;
        finally; Screen.Cursor := crDefault; end;
      end;
    end;
  finally; frmFlip.Free; end;
  UpdateUndoMenu;
  UpdateStatusBar;
end;

// Pick Color

procedure TFrmMain.PickColor1Click ( Sender: TObject );
begin
  if PickColor1.Down then
  begin
    if Assigned ( ImageENView1.IEBitmap ) then
    begin
      with ImageENView1 do
      begin
        Cursor := 1806;
        Transparent1.Checked := False;
        Opacity1.Text := '100';
        Alpha := 100;
        PaintColor.Color := OldPaintColor;
        SelectNone1.Down := True;
        MouseInteract := [ ];
        DeSelect;
      end;
    end
    else
      Cursor := 1784;
  end;
end;

// Pick Transparent Color

procedure TFrmMain.PickTransparent1Click ( Sender: TObject );
begin
  if PickTransparent1.Down then
  begin
    PickDialog := TPickDialog.Create ( Self );
    ImageENView1.Cursor := 1806;
    SelectNone1.Down := True;
    ImageENView1.MouseInteract := [ ];
    ImageENView1.DeSelect;
    PickTransparent1.Down := True;
    PickDialog.Show;
  end
  else
    ImageENView1.Cursor := 1784;
end;

//PointsButton

procedure TFrmMain.PointsButtonClick ( Sender: TObject );
begin
  DisplayGrid1.Checked := False;
  with ImageENView1 do
  begin
    DisplayGrid := False;
    if Assigned ( IEBitmap ) then
    begin
      Cursor := 1797;
      CreateBrush ( Self );
    end
    else
      Cursor := 1785;
  end;
end;

procedure TFrmMain.PopupMenuMRUChange ( Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean );
begin
  Open2.Enabled := True;
  Open2.Indeterminate := False;
end;

// Create Rectangle brush

procedure TFrmMain.RectangleButtonClick ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    if PaintPoint.Down then begin
      ImageENView1.Cursor := 1783;
      DisplayGrid1.Checked := False;
      ImageEnView1.DisplayGrid := False;
      Antialias.Checked := not RectangleButton.Down;
      CreateBrush ( Self );
    end
    else begin
      ImageENView1.Cursor := 1785;
      CreateBrush ( Self );
    end;
end;

// Redo

procedure TFrmMain.Redo1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      with Proc do
      begin
        SaveUndoCaptioned ( RedoCaptions [ 0 ], ieuImage );
        Redo;
        ClearRedo;
      end;
      IO.Params.Width := IEBitmap.Width;
      IO.Params.Height := IEBitmap.Height;
      Bitmap.Modified := True;
      Update;
      UpdateUndoMenu;
      UpdateStatusBar;
      Fit;
      if Proc.UndoCount = 0 then
        Bitmap.Modified := False;
    end;
  end;
end;

// Resample

procedure TFrmMain.Resample1Click ( Sender: TObject );
var
  w, h: integer;
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      frmResize := TfrmResize.Create ( Self );
      try
        frmResize.OrgWidth := Bitmap.Width;
        frmResize.OrgHeight := Bitmap.Height;
        frmResize.Caption := 'Resample';
        frmResize.Caption := ' Resample image';
        frmResize.Resize := False;
        frmResize.Resample := True;
        frmResize.ImageEnView1.Assign ( Bitmap );
        frmResize.ImageEnView1.Fit;
        if frmResize.ShowModal = mrOK then
        begin
          FrmMsg := TFrmMsg.Create ( Self );
          try
            FrmMsg.Msg1.Caption := 'Resamping the Picture...';
            FrmMsg.Show;
            FrmMsg.Msg1.Update;
            Proc.SaveUndoCaptioned ( 'Resample ' + IntToStr ( Proc.UndoCount ) );
            Undo1.Hint := 'Resample ' + IntToStr ( Proc.UndoCount + 1 );
            Proc.ClearAllRedo;
            w := StrToIntDef ( frmResize.Edit1.Text, 0 );
            h := StrToIntDef ( frmResize.Edit2.Text, 0 );
            Proc.Resample ( w, h, TResampleFilter ( frmResize.ComboBox1.ItemIndex ) );
            Invalidate;
            Bitmap.Modified := true;
            IO.Params.Width := IEBitmap.Width;
            IO.Params.Height := IEBitmap.Height;
            Update;
            UpdateUndoMenu;
            UpdateStatusbar;
            Sleep ( 1000 );
          finally; FrmMsg.Free; end;
        end;
      finally frmResize.Free; end;
    end;
  end;
end;

// Resize

procedure TFrmMain.Resize1Click ( Sender: TObject );
var
  w, h: integer;
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      frmResize := TfrmResize.Create ( Self );
      try
        frmResize.OrgWidth := Bitmap.Width;
        frmResize.OrgHeight := Bitmap.Height;
        frmResize.Caption := 'Resize';
        frmResize.Caption := ' Resize Image';
        frmResize.Resize := True;
        frmResize.Resample := False;
        frmResize.ImageEnView1.Assign ( Bitmap );
        frmResize.ImageEnView1.Fit;
        if frmResize.ShowModal = mrOK then
        begin
          FrmMsg := TFrmMsg.Create ( Self );
          try
            FrmMsg.Msg1.Caption := 'Resizing the Picture...';
            FrmMsg.Show;
            FrmMsg.Msg1.Update;
            Proc.ClearAllRedo;
            Proc.SaveUndoCaptioned ( 'Resize ' + IntToStr ( Proc.UndoCount ) );
            Undo1.Hint := 'Resize ' + IntToStr ( Proc.UndoCount + 1 );
            w := StrToIntDef ( frmResize.Edit1.Text, 0 );
            h := StrToIntDef ( frmResize.Edit2.Text, 0 );
            Proc.ImageResize ( w, h );
            Invalidate;
            Bitmap.Modified := true;
            IO.Params.Width := IEBitmap.Width;
            IO.Params.Height := IEBitmap.Height;
            Update;
            UpdateUndoMenu;
            UpdateStatusbar;
            Sleep ( 1000 );
          finally; FrmMsg.Free; end;
        end;
      finally frmResize.Free; end;
    end;
  end;
end;

// Rotate

procedure TFrmMain.Rotate1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      frmRotate := TfrmRotate.Create ( Self );
      try
        frmRotate.ImageENView1.IEBitmap.Assign ( IEBitmap );
        frmRotate.ImageENView1.Update;
        if frmRotate.ShowModal = mrOk then
        begin
          Screen.Cursor := crHourglass;
          try
            FrmMsg := TFrmMsg.Create ( Self );
            try
              FrmMsg.Msg1.Caption := 'Rotating the Picture...';
              FrmMsg.Show;
              try
                FrmMsg.Msg1.Update;
                Sleep ( 1000 );
                Proc.SaveUndoCaptioned ( 'Rotate ' + IntToStr ( Proc.UndoCount ) );
                Proc.ClearAllRedo;
                Undo1.Hint := 'Rotate ' + IntToStr ( Proc.UndoCount + 1 );
                Proc.Rotate ( StrToIntDef ( frmRotate.Edit1.Text, 90 ) );
                Update;
                Fit;
                Bitmap.Modified := True;
                UpdateUndoMenu;
                UpdateStatusbar;
              finally; FrmMsg.Free; end;
            finally; Screen.Cursor := crDefault; end;
          finally; FrmMsg.Hide; end;
        end;
      finally; frmRotate.Free; end;
    end;
  end;
end;

// BMP_HandleTransparency

procedure TFrmMain.BackGroundColorClick ( Sender: TObject );
begin
  ColorDialog1.Color := BackGroundColor.Color;
  if ColorDialog1.Execute then
    BackGroundColor.Color := ColorDialog1.Color;
end;

procedure TFrmMain.BMP_HandleTransparency1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
      IO.Params.BMP_HandleTransparency := BMP_HandleTransparency1.Checked;
  end;
end;

// Select brush color

procedure TFrmMain.BrushColorClick ( Sender: TObject );
begin
  ColorDialog1.Color := BrushColor.Color;
  if ColorDialog1.Execute then
    BrushColor.Color := ColorDialog1.Color;
  CreateBrush ( Self );
end;

// ImageEnView1ImageChange

procedure TFrmMain.ImageEnView1ImageChange ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
      Bitmap.Modified := True;
  end;
end;

// ImageEnView1MouseDown

procedure TFrmMain.ImageEnView1MouseDown ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  Transparency: integer;
begin
  startX := X;
  startY := Y;
  if ( PageControl2.ActivePage = DrawTab2 ) and PaintPoint.Down then
  begin
    // Paint Point
    with ImageENView1 do
    begin
      Proc.SaveUndo ( ieuImage );
      X := XScr2Bmp ( X );
      Y := YScr2Bmp ( Y );
      Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
      IEBitmap.Canvas.Pixels [ X, Y ] := PaintColor.Color;
      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Pixels [ X, Y ] := PaintColor.Color;
      IEBitmap.Alpha [ X, Y ] := Transparency;
      Update;
    end;
    UpdateUndoMenu;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PaintLine.Down then
  begin
    // Begin paint line
    ImageEnView1.Proc.SaveUndo ( ieuImage );
    UpdateUndoMenu;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PaintRectangle.Down then
  begin
    // Begin paint Rectangle
    ImageEnView1.Proc.SaveUndo ( ieuImage );
    UpdateUndoMenu;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PaintEllipse.Down then
  begin
    // Begin paint ellipse
    ImageEnView1.Proc.SaveUndo ( ieuImage );
    UpdateUndoMenu;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and Fill1.Down then
  begin
    // fill
    with ImageENView1 do
    begin
      Proc.SaveUndo ( ieuImage );
      Proc.CastColor ( CurrentLayer.ConvXScr2Bmp ( X ), CurrentLayer.ConvYScr2Bmp ( Y ), TColor2TRGB ( FillColor.Color ), StrToInt ( FillTolerance1.Text ) );
      Update;
      UpdateUndoMenu;
    end;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PickColor1.Down and ImageEnView1.MouseCapture then
  begin
    // pick color
    with ImageENView1 do
    begin
      PaintColor.Color := IEBitmap.Canvas.Pixels [ CurrentLayer.ConvXScr2Bmp ( X ), CurrentLayer.ConvYScr2Bmp ( Y ) ];
      BrushColor.Color := IEBitmap.Canvas.Pixels [ CurrentLayer.ConvXScr2Bmp ( X ), CurrentLayer.ConvYScr2Bmp ( Y ) ];
    end;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and Erase1.Down then
  begin
    // erase
    with ImageENView1 do
    begin
      X := XScr2Bmp ( X );
      Y := YScr2Bmp ( Y );
      if ( IO.Params.BitsPerSample = 8 ) and ( IO.Params.SamplesPerPixel = 4 ) then
        Transparency := 0
      else
        Transparency := 255;
      IEBitmap.Canvas.Pixels [ X, Y ] := TransparentColor.Color;
      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Pixels [ X, Y ] := TransparentColor.Color;
      IEBitmap.Alpha [ X, Y ] := Transparency;
      Update;
    end;
    UpdateUndoMenu;
  end
  else if ( PageControl2.ActivePage = PaintTab ) then begin
    // paint
    ImageEnView1.Proc.SaveUndo ( ieuImage );
    UpdateUndoMenu;
    ImageEnView1MouseMove ( self, Shift, X, Y );
  end;
end;

// moving mouse (move the brush layer)

procedure TFrmMain.ImageEnView1MouseMove ( Sender: TObject;
  Shift: TShiftState; X, Y: Integer );
var
  px, py: integer;
  bx, by: integer;
  op: TIERenderOperation;
  Transparency: integer;
  cl_rgb: TRGB;
begin
  if ( PageControl2.ActivePage = DrawTab2 ) and PaintPoint.Down and ImageEnView1.MouseCapture then
  begin
    // Paint Point
    with ImageENView1 do
    begin
      X := XScr2Bmp ( X );
      Y := YScr2Bmp ( Y );
      Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
      IEBitmap.Canvas.Pixels [ X, Y ] := PaintColor.Color;
      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Pixels [ X, Y ] := PaintColor.Color;
      IEBitmap.Alpha [ X, Y ] := Transparency;
      Update;
    end;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PaintLine.Down and ImageEnView1.MouseCapture then
  begin
    // Paint Line
    with ImageEnView1 do
    begin
      Proc.UndoRect ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( lastX ), YScr2Bmp ( lastY ) );
      SetSquarePen ( IEBitmap.Canvas, PaintColor.Color, 1 );
      Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
      IEBitmap.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.Canvas.MoveTo ( XScr2Bmp ( startX ), YScr2Bmp ( startY ) );
      IEBitmap.Canvas.LineTo ( XScr2Bmp ( X ), YScr2Bmp ( Y ) );
      IEBitmap.Canvas.LineTo ( XScr2Bmp ( startX ), YScr2Bmp ( startY ) );
      //IEBitmap.Alpha [ XScr2Bmp ( X ), YScr2Bmp ( Y ) ] := Transparency;
      if ( IO.Params.BitsPerSample = 8 ) and ( IO.Params.SamplesPerPixel = 4 ) then
        SetSquarePen ( IEBitmap.AlphaChannel.Canvas, $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 ), 1 )
      else
        SetSquarePen ( IEBitmap.AlphaChannel.Canvas, $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 ), 1 );
      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.MoveTo ( XScr2Bmp ( startX ), YScr2Bmp ( startY ) );
      IEBitmap.AlphaChannel.Canvas.LineTo ( XScr2Bmp ( X ), YScr2Bmp ( Y ) );
      IEBitmap.AlphaChannel.Canvas.LineTo ( XScr2Bmp ( startX ), YScr2Bmp ( startY ) );
      //IEBitmap.Alpha [ XScr2Bmp ( X ), YScr2Bmp ( Y ) ] := Transparency;
      Update;
    end;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PaintEllipse.Down and ImageEnView1.MouseCapture then
  begin
    // Paint Ellipse
    with ImageEnView1 do
    begin
      Proc.UndoRect ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( lastX ), YScr2Bmp ( lastY ) );
      IEBitmap.Canvas.Pen.Color := PaintColor.Color;
      if not Filled1.Checked then begin
        IEBitmap.Canvas.Brush.Style := bsClear;
        IEBitmap.Canvas.Ellipse ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( X ), YScr2Bmp ( Y ) );
      end
      else
      begin
        if DrawBorderOpague1.Checked then
          Transparency := 255
        else
          Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
        IEBitmap.Canvas.Ellipse ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( X ), YScr2Bmp ( Y ) );
        IEBitmap.Canvas.Pen.Color := PaintColor.Color;
        IEBitmap.Canvas.Brush.Color := FillColor.Color;
        IEBitmap.AlphaChannel.Canvas.Brush.Color := FillColor.Color;
        IEBitmap.Canvas.Brush.Style := bsSolid;
        IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
        Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
        IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
        if DrawBorderOpague1.Checked then
          Transparency := 255
        else
          Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
        IEBitmap.AlphaChannel.Canvas.Ellipse ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( X ), YScr2Bmp ( Y ) );
      end;
      Update;
    end;
    Update;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PaintRectangle.Down and ImageEnView1.MouseCapture then
  begin
    // Paint Rectangle
    with ImageEnView1 do
    begin
      Proc.UndoRect ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( lastX ), YScr2Bmp ( lastY ) );
      IEBitmap.Canvas.Pen.Color := PaintColor.Color;
      if not Filled1.Checked then begin
        IEBitmap.Canvas.Brush.Style := bsClear;
        IEBitmap.Canvas.Rectangle ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( X ), YScr2Bmp ( Y ) );
      end
      else
      begin
        if DrawBorderOpague1.Checked then
          Transparency := 255
        else
          Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
        IEBitmap.Canvas.Rectangle ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( X ), YScr2Bmp ( Y ) );
        IEBitmap.Canvas.Pen.Color := PaintColor.Color;
        IEBitmap.Canvas.Brush.Color := FillColor.Color;
        IEBitmap.AlphaChannel.Canvas.Brush.Color := FillColor.Color;
        IEBitmap.Canvas.Brush.Style := bsSolid;
        IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
        Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
        IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
        if DrawBorderOpague1.Checked then
          Transparency := 255
        else
          Transparency := ( ( StrToInt ( Opacity1.Text ) * 255 ) div 100 );
        IEBitmap.AlphaChannel.Canvas.Rectangle ( XScr2Bmp ( startX ), YScr2Bmp ( startY ), XScr2Bmp ( X ), YScr2Bmp ( Y ) );
      end;
      Update;
    end;
    Update;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PickColor1.Down then
  begin
    //Pick Color
    with ImageENView1 do
    begin
      Cursor := 1798;
      PaintColor.Color := IEBitmap.Canvas.Pixels [ CurrentLayer.ConvXScr2Bmp ( X ), CurrentLayer.ConvYScr2Bmp ( Y ) ];
      BrushColor.Color := IEBitmap.AlphaChannel.Canvas.Pixels [ CurrentLayer.ConvXScr2Bmp ( X ), CurrentLayer.ConvYScr2Bmp ( Y ) ];
    end;
  end
  else if ( PageControl2.ActivePage = DrawTab2 ) and PickTransparent1.Down then
    //PickTransparent
    with ImageENView1 do
    begin
      // transform client coorindates to bitmap ones
      X := XScr2Bmp ( X );
      Y := YScr2Bmp ( Y );
      // check limits
      if ( X >= 0 ) and ( X < IEBitmap.Width ) and
        ( Y >= 0 ) and ( Y < IEBitmap.Height ) then
      begin
        cl_rgb := IEBitmap.Pixels [ X, Y ];
        PickDialog.ColorUnderCursor1.Color := TRGB2TColor ( cl_rgb );
        Application.ProcessMessages;
        PickDialog.ColorUnderCursor1.Invalidate;
        with cl_rgb do
          PickDialog.Label3.Caption := 'RGB: ' + IntToStr ( r ) + ',' + IntToStr ( g ) + ',' + IntToStr ( b );
        PickDialog.Label4.Caption := 'Color: ' + ColorToString ( PickDialog.ColorUnderCursor1.Color );
      end;
      if ( ssLeft in Shift ) and ( PickTransparent1.Down ) then
      begin
        PickDialog.PickColor.Color := TRGB2TColor ( cl_rgb );
        SetTransparent;
        Cursor := 1784;
        PickTransparent1.Down := False;
        PickDialog.Free;
      end;
    end
  else if ( PageControl2.ActivePage = DrawTab2 ) and Erase1.Down and ImageEnView1.MouseCapture then
  begin
    // Erase
    with ImageENView1 do
    begin
      X := XScr2Bmp ( X );
      Y := YScr2Bmp ( Y );
      if ( IO.Params.BitsPerSample = 8 ) and ( IO.Params.SamplesPerPixel = 4 ) then
        Transparency := 0
      else
        Transparency := 255;
      IEBitmap.Canvas.Pixels [ X, Y ] := TransparentColor.Color;
      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Pixels [ X, Y ] := TransparentColor.Color;
      IEBitmap.Alpha [ X, Y ] := Transparency;
      Update;
    end;
  end
  else if ( PageControl2.ActivePage = PaintTab2 ) then
  begin
    // Paint
    op := TIERenderOperation ( Self.Operation.ItemIndex );
    with ImageEnView1 do
      if LayersCount = 2 then
      begin
        with Layers [ 1 ] do
        begin
          bx := Bitmap.Width;
          by := Bitmap.Height;
          if Antialias.Checked then
          begin
            Width := bx div 2;
            Height := by div 2;
          end;
          px := XScr2Bmp ( X ) - Width div 2;
          py := YScr2Bmp ( Y ) - Height div 2;
          PosX := px;
          PosY := py;
          Operation := op;
        end;
        if MouseCapture then // paint the layer (the brush...)
        begin
          ImageEnView1.Proc.SaveUndo ( ieuImage );
          if Antialias.Checked then
            Layers [ 1 ].Bitmap.RenderToTIEBitmapEx ( Layers [ 0 ].Bitmap, px, py, bx div 2, by div 2, 0, 0, bx, by, 255, rfFastLinear, op )
          else
            Layers [ 1 ].Bitmap.RenderToTIEBitmapEx ( Layers [ 0 ].Bitmap, px, py, bx, by, 0, 0, bx, by, 255, rfNone, op );
          Layers [ 1 ].Bitmap.MergeAlphaRectTo ( Layers [ 0 ].Bitmap, 0, 0, px, py, bx, by );
        end;
        Update;
      end;
  end;
  lastX := X;
  lastY := Y;
end;

// ImageEnView1MouseUp

procedure TFrmMain.ImageEnView1MouseUp ( Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer );
begin
  if PickColor1.Down then
  begin
  // Reset PickColor
    PickColor1.Down := False;
    PaintPoint.Down := True;
    ImageEnView1.Cursor := 1797;
  end
  else if Fill1.Down then
  begin
    // Reset Fill
    Fill1.Down := False;
    ImageENView1.Cursor := 1797;
  end;
  UpdateStatusBar;
end;

//ImageEnView1ViewChange

procedure TFrmMain.ImageEnView1ViewChange ( Sender: TObject; Change: Integer );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
      Bitmap.Modified := True;
  end;
end;

// CreateBrush

procedure TFrmMain.CreateBrush ( Sender: TObject );
var
  brushsiz: integer;
  c: TColor;
  transpvalue: integer;
  i: integer;
  x, y: integer;
begin
  if ImageEnView1.LayersCount = 1 then
    ImageEnView1.LayersAdd;
  ImageEnView1.LayersCurrent := 1;
  brushsiz := StrToIntDef ( BrushSize.Text, 1 );
  if brushsiz = 1 then
    Antialias.Checked := false;
  if Antialias.Checked then
    brushsiz := brushsiz * 2;
  ImageEnView1.Proc.ImageResize ( brushsiz, brushsiz, iehLeft, ievTop );
  // prepare main color
  ImageEnView1.IEBitmap.Canvas.Brush.Color := BrushColor.Color;
  ImageEnView1.IEBitmap.Canvas.Pen.Color := BrushColor.Color;
  // prepare alpha channel
  ImageEnView1.AlphaChannel.Fill ( 0 );
  with ImageEnView1.AlphaChannel.Canvas do
  begin
    transpvalue := StrToIntDef ( Transparency.Text, 255 );
    c := $02000000 or ( transpvalue ) or ( transpvalue shl 8 ) or ( transpvalue shl 16 );
    Brush.Color := c;
    Pen.Color := c;
  end;
  // draws a rectangle brush
  if RectangleButton.Down then
  begin
    // draw the shape
    ImageEnView1.IEBitmap.Canvas.Rectangle ( 0, 0, brushsiz + 1, brushsiz + 1 );
    // draw the shape alpha channel
    ImageEnView1.AlphaChannel.Canvas.Rectangle ( 0, 0, brushsiz + 1, brushsiz + 1 );
  end
  // draws a circle brush
  else if CircleButton.Down then
  begin
    // draw the shape
    ImageEnView1.IEBitmap.Canvas.Ellipse ( 0, 0, brushsiz + 1, brushsiz + 1 );
    // draw the shape alpha channel
    ImageEnView1.AlphaChannel.Canvas.Ellipse ( 0, 0, brushsiz + 1, brushsiz + 1 );
  end
  // draws random points brush (should be a "spray"...)
  else if PointsButton.Down and ( brushsiz > 1 ) then
  begin
    for i := 0 to brushsiz * 3 do // change "3" to adjust the spary intensity
    begin
      repeat
        x := random ( brushsiz );
        y := random ( brushsiz );
      until sqr ( x - brushsiz div 2 ) + sqr ( y - brushsiz div 2 ) < sqr ( brushsiz div 2 ); // repeat until (x,y) is inside a circle!
      ImageEnView1.IEBitmap.Canvas.Pixels [ x, y ] := BrushColor.Color;
      ImageEnView1.AlphaChannel.Canvas.Pixels [ x, y ] := c;
    end;
  end;
  ImageEnView1MouseMove ( self, [ ], 0, 0 ); // refresh current brush
end;

// Crop

procedure TFrmMain.Crop1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      if Selected then
      begin
        FrmMsg := TFrmMsg.Create ( Self );
        try
          FrmMsg.Msg1.Caption := 'Cropping the Picture...';
          FrmMsg.Show;
          FrmMsg.Msg1.Update;
          Proc.SaveUndoCaptioned ( 'Crop ' + IntToStr ( Proc.UndoCount ) );
          Undo1.Hint := 'Crop ' + IntToStr ( Proc.UndoCount + 1 );
          Proc.ClearAllRedo;
          Proc.CropSel;
          DeSelect;
          IO.Params.Width := IEBitmap.Width;
          IO.Params.Height := IEBitmap.Height;
          Bitmap.Modified := True;
          Update;
          UpdateUndoMenu;
          UpdateStatusBar;
          Sleep ( 1000 );
        finally; FrmMsg.Free; end;
      end
      else
        TaskMessageDlg ( 'Error', 'Please select an area of the image to crop.', mtError, [ mbOK ], 0 );
    end;
  end;
end;

//Cut

procedure TFrmMain.Cut1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      if Selected then begin
        Proc.SaveUndoCaptioned ( 'Cut ' + IntToStr ( Proc.UndoCount ) );
        Undo1.Hint := 'Cut ' + IntToStr ( Proc.UndoCount + 1 );
        Proc.ClearAllRedo;
        Proc.SelCutToClip;
        UpdateUndoMenu;
        UpdateStatusbar;
      end
      else
        TaskMessageDlg ( 'Error', 'Please select an area of the image to crop.', mtError, [ mbOK ], 0 );
      Paste1.Enabled := ( Clipboard.HasFormat ( IERAWCLIPFORMAT ) ) or ( Clipboard.HasFormat ( CF_PICTURE ) );
    end;
  end;
end;

// DisplayGrid

procedure TFrmMain.DisplayGrid1Click ( Sender: TObject );
begin
  ImageEnView1.DisplayGrid := DisplayGrid1.Checked;
end;

// Create round brush

procedure TFrmMain.CircleButtonClick ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    if CircleButton.Down then begin
      ImageENView1.Cursor := 1783;
      DisplayGrid1.Checked := False;
      ImageEnView1.DisplayGrid := False;
      Antialias.Checked := not CircleButton.Down;
      CreateBrush ( Self );
    end
    else begin
      ImageENView1.Cursor := 1785;
      CreateBrush ( Self );
    end;
end;

procedure TFrmMain.Clear1Click ( Sender: TObject );
var
  i, j: integer;
begin
  for i := PopupMenuMRU.Items.Count - 1 downto 2 do
    PopupMenuMRU.Items.Delete ( i );
  for j := MRUFiles.Count - 1 downto 0 do
    MRUFiles.Delete ( j );
end;

// select paint color

procedure TFrmMain.PaintColorClick ( Sender: TObject );
begin
  ColorDialog1.Color := PaintColor.Color;
  if ColorDialog1.Execute then
    PaintColor.Color := ColorDialog1.Color;
end;

//PaintEllipse

procedure TFrmMain.PaintEllipseClick ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    if PaintEllipse.Down then
      ImageENView1.Cursor := 1783
    else
      ImageENView1.Cursor := 1785;
end;

//PaintLine

procedure TFrmMain.PaintLineClick ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    if PaintLine.Down then
      ImageENView1.Cursor := 1783
    else
      ImageENView1.Cursor := 1785;
end;

//PaintPoint

procedure TFrmMain.PaintPointClick ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    if PaintPoint.Down then
      ImageENView1.Cursor := 1783
    else
      ImageENView1.Cursor := 1785;
end;

// PaintRectangle

procedure TFrmMain.PaintRectangleClick ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    if PaintRectangle.Down then
      ImageENView1.Cursor := 1783
    else
      ImageENView1.Cursor := 1785;
end;

// Paste

procedure TFrmMain.Paste1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      frmPaste := TfrmPaste.Create ( Self );
      try
        frmPaste.PopupParent := Self;
        if frmPaste.ShowModal = mrOk then
        begin
          if ( Clipboard.HasFormat ( IERAWCLIPFORMAT ) ) or
            ( Clipboard.HasFormat ( CF_PICTURE ) ) then
          begin
            if ( Clipboard.HasFormat ( CF_PICTURE ) ) or ( Clipboard.HasFormat ( IERAWCLIPFORMAT ) ) then
              case frmPaste.PasteTypeRadioGroup1.ItemIndex of
                0:
                  begin
                    Proc.SaveUndoCaptioned ( 'Paste ' + IntToStr ( Proc.UndoCount ) );
                    Undo1.Hint := 'Paste ' + IntToStr ( Proc.UndoCount + 1 );
                    Proc.ClearAllRedo;
                    Proc.PasteFromClipboard;
                    Update;
                    Bitmap.Modified := True;
                    UpdateUndoMenu;
                    UpdateStatusbar;
                  end;
                1:
                  begin
                    if VisibleSelection then
                    begin
                      with Proc do
                      begin
                        SaveUndoCaptioned ( 'PasteFromClipStretch ' + IntToStr ( UndoCount ) );
                        Undo1.Hint := 'PasteFromClipStretch ' + IntToStr ( UndoCount + 1 );
                        SelPasteFromClipStretch;
                        Update;
                        Bitmap.Modified := True;
                        UpdateStatusBar;
                      end;
                    end;
                  end;
              end;
          end;
        end;
      finally; frmPaste.Free; end;
    end;
  end;
end;

//PageControl1Change

procedure TFrmMain.PageControl1Change ( Sender: TObject );
begin
  if PageControl1.ActivePage <> PaintTab then begin
    ImageENView1.LayersRemove ( 1 );
    ImageEnView1.DisplayGrid := DisplayGrid1.Checked;
  end;
  if PageControl1.ActivePage = DrawTab then begin
    PageControl2.ActivePage := DrawTab2;
  end
  else if PageControl1.ActivePage = PaintTab then begin
    PageControl2.ActivePage := PaintTab2;
    ImageEnView1.DisplayGrid := False;
    CreateBrush ( Self );
  end
  else
    ImageEnView1.DisplayGrid := DisplayGrid1.Checked;
end;

// PageControl2Change

procedure TFrmMain.PageControl2Change ( Sender: TObject );
begin
  if PageControl2.ActivePage <> PaintTab2 then begin
    ImageENView1.LayersRemove ( 1 );
    ImageEnView1.DisplayGrid := DisplayGrid1.Checked;
  end;
  if PageControl2.ActivePage = DrawTab2 then begin
    PageControl1.ActivePage := DrawTab;
  end
  else if PageControl2.ActivePage = PaintTab2 then begin
    PageControl1.ActivePage := PaintTab;
    ImageEnView1.DisplayGrid := False;
    CreateBrush ( Self );
  end;
end;

//IEMagicWandMode

procedure TFrmMain.IEMagicWandMode1Change ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
    with ImageENView1 do begin
      MagicWandMode := TIEMagicWandMode ( IEMagicWandMode1.ItemIndex );
    end;
end;

// ConvertTo24Bit

procedure TFrmMain.ConvertTo24Bit1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    FrmMsg := TFrmMsg.Create ( Self );
    try
      FrmMsg.Msg1.Caption := 'Converting To 24-bit...';
      FrmMsg.Show;
      FrmMsg.Msg1.Update;
      Sleep ( 1000 );
      with ImageENView1 do
      begin
        Proc.SaveUndoCaptioned ( 'Convert To 24-bit ' + IntToStr ( Proc.UndoCount ) );
        Undo1.Hint := 'Convert To 24-bit ' + IntToStr ( Proc.UndoCount + 1 );
        Proc.ClearAllRedo;
        IO.Params.BitsPerSample := 8;
        IO.Params.SamplesPerPixel := 3;
        RemoveAlphaChannel;
      end;
    finally; FrmMsg.Free; end;
  end;
  ImageEnView1.Update;
  UpdateUndoMenu;
  UpdateStatusbar;
end;

// ConvertTo8Bit

procedure TFrmMain.ConvertTo8Bit1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    FrmMsg := TFrmMsg.Create ( Self );
    try
      FrmMsg.Msg1.Caption := 'Converting To 8-bit...';
      FrmMsg.Show;
      FrmMsg.Msg1.Update;
      Sleep ( 1000 );
      with ImageENView1 do
      begin
        Proc.SaveUndoCaptioned ( 'Convert To 8-bit ' + IntToStr ( Proc.UndoCount ) );
        Undo1.Hint := 'Convert To 8-bit ' + IntToStr ( Proc.UndoCount + 1 );
        Proc.ClearAllRedo;
        Proc.ConvertTo ( 256, ieThreshold );
        IO.Params.BitsPerSample := 8;
        IO.Params.SamplesPerPixel := 1;
        RemoveAlphaChannel;
      end;
    finally; FrmMsg.Free; end;
  end;
  ImageEnView1.Update;
  UpdateUndoMenu;
  UpdateStatusbar;
end;

// Copy

procedure TFrmMain.Copy1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      if VisibleSelection then
        Proc.SelCopyToClip
      else
        Proc.CopyToClipboard;
      Paste1.Enabled := ( Clipboard.HasFormat ( IERAWCLIPFORMAT ) ) or ( Clipboard.HasFormat ( CF_PICTURE ) );
    end;
  end;
end;

// ConvertTo4Bit

procedure TFrmMain.ConvertTo4Bit1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    FrmMsg := TFrmMsg.Create ( Self );
    try
      FrmMsg.Msg1.Caption := 'Converting To 4-bit...';
      FrmMsg.Show;
      FrmMsg.Msg1.Update;
      Sleep ( 1000 );
      with ImageENView1 do
      begin
        Proc.SaveUndoCaptioned ( 'Convert To 4-bit ' + IntToStr ( Proc.UndoCount ) );
        Undo1.Hint := 'Convert To 4-bit ' + IntToStr ( Proc.UndoCount + 1 );
        Proc.ClearAllRedo;
        Proc.ConvertTo ( 16, ieThreshold );
        IO.Params.BitsPerSample := 4;
        IO.Params.SamplesPerPixel := 1;
        RemoveAlphaChannel;
      end;
    finally; FrmMsg.Free; end;
  end;
  ImageEnView1.Update;
  UpdateUndoMenu;
  UpdateStatusbar;
end;

// Undo

procedure TFrmMain.Undo1Click ( Sender: TObject );
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      with Proc do
      begin
        SaveRedoCaptioned ( UndoCaptions [ 0 ], ieuImage ); // saves in Redo list
        Undo;
        ClearUndo;
      end;
      UpdateUndoMenu;
      IO.Params.Width := ImageENView1.IEBitmap.Width;
      IO.Params.Height := ImageENView1.IEBitmap.Height;
      Bitmap.Modified := True;
      Update;
      UpdateStatusBar;
      if Proc.UndoCount = 0 then
        Bitmap.Modified := False;
    end;
  end;
end;

// UpdateStatusBar

procedure TFrmMain.UpdateStatusBar;
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      FilePath := IO.Params.FileName;
      StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( IO.Params.FileName );
      StatusBar1.Panels [ 1 ].Text := ExtractFileName ( IO.Params.FileName );
      StatusBar1.Panels [ 2 ].Text := IntToStr ( IO.Params.Width ) + ' x ' + IntToStr ( IO.Params.Height );
      StatusBar1.Panels [ 3 ].Text := IntToStr ( IO.Params.SamplesPerPixel * IO.Params.BitsPerSample ) + ' bit';
      StatusBar1.Panels [ 4 ].Text := 'Colors: ' + AddThousandSeparator ( IntToStr ( ImageENView1.Proc.CalcImageNumColors ), ',' );
      StatusBar1.Panels [ 5 ].Text := 'Zoom: ' + FloatToStrF ( Zoom, ffFixed, 10, 1 ) + '%';
      StatusBar1.Panels [ 6 ].Text := 'Undo Count: ' + IntToStr ( Proc.UndoCount );
      StatusBar1.Panels [ 7 ].Text := 'Undo Limit: ' + IntToStr ( Proc.UndoLimit );
      ScrollBar1.Hint := 'Zoom - ' + IntToStr ( Round ( Zoom ) ) + '%';
      ScrollBar1.Position := Round ( Zoom );
      if Bitmap.Modified then
        StatusBar1.Panels [ 8 ].Text := ' Modified'
      else
        StatusBar1.Panels [ 8 ].Text := '';
    end;
  end;
end;

// UpdateUndoMenu

procedure TFrmMain.UpdateUndoMenu;
begin
  if Assigned ( ImageENView1.IEBitmap ) then
  begin
    with ImageENView1 do
    begin
      with Proc do
      begin
    // Undo
        Undo1.Hint := 'Undo ';
        Undo2.Hint := 'Undo ';
        Undo1.Enabled := UndoCount > 0;
        Undo2.Enabled := UndoCount > 0;
        if UndoCount > 0 then begin
          Undo1.Hint := 'Undo ' + UndoCaptions [ 0 ];
          Undo2.Hint := 'Undo ' + UndoCaptions [ 0 ];
        end;
    // Redo
        Redo1.Hint := 'Redo ';
        Redo2.Hint := 'Redo ';
        Redo1.Enabled := RedoCount > 0;
        Redo2.Enabled := RedoCount > 0;
        if RedoCount > 0 then begin
          Redo1.Hint := 'Redo ' + RedoCaptions [ 0 ];
          Redo2.Hint := 'Redo ' + RedoCaptions [ 0 ];
        end;
      end;
    end;
  end;
end;

procedure TFrmMain.xx1Click ( Sender: TObject );
begin

end;

// SetTransparent

procedure TFrmMain.SetTransparent;
var
  cl_rgb: TRGB;
begin
  cl_rgb := TColor2TRGB ( PickDialog.PickColor.Color );
  ImageEnView1.Proc.SetTransparentColors ( cl_rgb, cl_rgb, 0 );
end;

// Spray

end.

