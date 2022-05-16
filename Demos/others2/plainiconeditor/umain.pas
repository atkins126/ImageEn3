unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls, Buttons, ComCtrls, ImgList, ToolWin, XPMan,
  IEView, IEOpenSaveDlg, ImageENView, ImageEnIO, ImageEnProc, HYIEutils, HYIEdefs,
  StdActns, ActnList;

type
  TMainForm = class ( TForm )
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileOpen1: TMenuItem;
    N1: TMenuItem;
    FileExit1: TMenuItem;
    ColorDialog1: TColorDialog;
    CheckBox1: TCheckBox;
    PaintPoint: TSpeedButton;
    PaintLine: TSpeedButton;
    PaintEllipse: TSpeedButton;
    PaintRect: TSpeedButton;
    GroupBox1: TGroupBox;
    SidePanel1: TPanel;
    Preview: TImageEnView;
    ListViewFrames: TListView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    SaveImageEnDialog1: TSaveImageEnDialog;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    FileSave1: TMenuItem;
    FileSaveAs1: TMenuItem;
    PageControl1: TPageControl;
    FileClose1: TMenuItem;
    N2: TMenuItem;
    Edit1: TMenuItem;
    EditCut1: TMenuItem;
    EditCopy1: TMenuItem;
    EditPaste1: TMenuItem;
    EditPaste2: TMenuItem;
    EditPasteIntoSelection1: TMenuItem;
    Select1: TMenuItem;
    SelectNone1: TMenuItem;
    SelectRectangle1: TMenuItem;
    SelectEllipse1: TMenuItem;
    SelectZoom1: TMenuItem;
    SelectMagicWand1: TMenuItem;
    SelectPolygon1: TMenuItem;
    SelectLasso1: TMenuItem;
    SelectInvertSelection1: TMenuItem;
    SelectMagicWandOptions1: TMenuItem;
    EditUndo1: TMenuItem;
    EditRedo1: TMenuItem;
    N3: TMenuItem;
    MakeXPIcon1: TButton;
    FillAdjacentForeground: TSpeedButton;
    FillAdjacentBackground: TSpeedButton;
    PickAlpha: TSpeedButton;
    PickColor: TSpeedButton;
    AddSoftShadow1: TButton;
    AddInsideShadow1: TButton;
    ImageList2: TImageList;
    SelectIcon1: TMenuItem;
    Options1: TMenuItem;
    MarkOuter1: TMenuItem;
    PopupMenu1: TPopupMenu;
    FileClose2: TMenuItem;
    N4: TMenuItem;
    FileSave2: TMenuItem;
    FileSaveAs2: TMenuItem;
    N5: TMenuItem;
    EditUndo2: TMenuItem;
    EditRedo2: TMenuItem;
    N6: TMenuItem;
    EditCut2: TMenuItem;
    EditCopy2: TMenuItem;
    EditPaste3: TMenuItem;
    EditPaste4: TMenuItem;
    EditPasteIntoSelection2: TMenuItem;
    Select2: TMenuItem;
    SelectNone2: TMenuItem;
    SelectRectangle2: TMenuItem;
    SelectEllipse2: TMenuItem;
    SelectZoom2: TMenuItem;
    SelectMagicWand2: TMenuItem;
    SelectPolygon2: TMenuItem;
    SelectLasso2: TMenuItem;
    SelectMagicWandOptions2: TMenuItem;
    SelectIcon2: TMenuItem;
    SelectInvertSelection2: TMenuItem;
    MarkOuter2: TMenuItem;
    PaintAlpha: TSpeedButton;
    Panel6: TPanel;
    Up1: TSpeedButton;
    Down1: TSpeedButton;
    N7: TMenuItem;
    N9: TMenuItem;
    N8: TMenuItem;
    EditCrop1: TMenuItem;
    N10: TMenuItem;
    Resize1: TMenuItem;
    Resample1: TMenuItem;
    Crop2: TMenuItem;
    Resize2: TMenuItem;
    Resample2: TMenuItem;
    ImageList3: TImageList;
    CoolBar2: TCoolBar;
    ToolBar1: TToolBar;
    NewButton1: TToolButton;
    OpenButton1: TToolButton;
    ToolButton3: TToolButton;
    SaveButton1: TToolButton;
    SaveAsButton1: TToolButton;
    ToolButton8: TToolButton;
    CloseButton1: TToolButton;
    CutButton1: TToolButton;
    CopyButton1: TToolButton;
    PasteButton1: TToolButton;
    UndoButton1: TToolButton;
    ToolButton16: TToolButton;
    RedoButton1: TToolButton;
    ToolButton19: TToolButton;
    CropButton1: TToolButton;
    ToolButton21: TToolButton;
    ExitButton1: TToolButton;
    GroupBox2: TGroupBox;
    TrackBarZoom: TTrackBar;
    XPManifest1: TXPManifest;
    Delete1: TButton;
    Import1: TButton;
    Export1: TButton;
    PaintTransparency: TEdit;
    UpDownAlpha: TUpDown;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    EditFillTolerance: TEdit;
    UpDownFillTolerance: TUpDown;
    LabelAlpha: TLabel;
    CheckBoxEnableAlpha: TCheckBox;
    LabelPenWidth: TLabel;
    EditPenWidth: TEdit;
    UpDownPenWidth: TUpDown;
    PaintFilledRect: TSpeedButton;
    PaintFilledEllipse: TSpeedButton;
    PaintRoundRect: TSpeedButton;
    PaintFilledRoundRect: TSpeedButton;
    Panel7: TPanel;
    Fit1: TSpeedButton;
    Extent1: TSpeedButton;
    Help1: TMenuItem;
    About1: TMenuItem;
    ImageList1: TImageList;
    GrayScale1: TButton;
    Negative1: TButton;
    PopupMenu2: TPopupMenu;
    Paste1: TMenuItem;
    PasteIntoSelection1: TMenuItem;
    Paste2: TMenuItem;
    SelectButton1: TToolButton;
    ToolButton2: TToolButton;
    PopupMenu3: TPopupMenu;
    Select3: TMenuItem;
    InvertSelection1: TMenuItem;
    Icon3: TMenuItem;
    MagicWandOptions1: TMenuItem;
    Lasso1: TMenuItem;
    Polygon1: TMenuItem;
    MagicWand1: TMenuItem;
    Zoom1: TMenuItem;
    Ellipse1: TMenuItem;
    Rectangle1: TMenuItem;
    None1: TMenuItem;
    SetAlpha: TBitBtn;
    OpacityLabel: TLabel;
    PaintOpacity: TEdit;
    UpDownOpacity: TUpDown;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    ActionList1: TActionList;
    FileExit: TFileExit;
    EditCut: TEditCut;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    EditUndo: TEditUndo;
    FileNew: TAction;
    FileSave: TAction;
    SelectRect: TAction;
    SelectEllipse: TAction;
    SelectMagicwand: TAction;
    SelectIcon: TAction;
    SelectNone: TAction;
    SelectZoom: TAction;
    SelectPolygon: TAction;
    SelectLasso: TAction;
    FileSaveAs: TAction;
    FileClose: TAction;
    EditRedo: TAction;
    EditCrop: TAction;
    EditPasteIntoSelection: TAction;
    EditResize: TAction;
    EditResample: TAction;
    FileOpen: TAction;
    New1: TMenuItem;
    SelectMagicWandOptions: TAction;
    SelectInvertSelection: TAction;
    PickAlphaColor: TSpeedButton;
    ForeColor: TShape;
    BackColor: TShape;
    CurrentFore: TShape;
    CurrentBack: TShape;
    LabelAlpha1: TLabel;
    Sort1: TButton;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    About: TAction;
    Help: TAction;
    Help2: TMenuItem;
    procedure FileExit1Click ( Sender: TObject );
    procedure TrackBarZoomChange ( Sender: TObject );
    procedure FormCreate ( Sender: TObject );
    procedure CheckBox1Click ( Sender: TObject );
    procedure ListViewFramesSelectItem ( Sender: TObject; Item: TListItem;
      Selected: Boolean );
    procedure FileSaveAs1Click ( Sender: TObject );
    procedure PageControl1Change ( Sender: TObject );
    procedure Delete1Click ( Sender: TObject );
    procedure Import1Click ( Sender: TObject );
    procedure SetAlphaClick ( Sender: TObject );
    procedure MakeXPIcon1Click ( Sender: TObject );
    procedure CheckBoxEnableAlphaClick ( Sender: TObject );
    procedure FillAdjacentForegroundClick ( Sender: TObject );
    procedure UpDownAlphaClick ( Sender: TObject; Button: TUDBtnType );
    procedure TrackBar1Change ( Sender: TObject );
    procedure PickAlphaClick ( Sender: TObject );
    procedure PickColorClick ( Sender: TObject );
    procedure Export1Click ( Sender: TObject );
    procedure AddSoftShadow1Click ( Sender: TObject );
    procedure AddInsideShadow1Click ( Sender: TObject );
    procedure FillAdjacentBackgroundClick ( Sender: TObject );
    procedure MarkOuter2Click ( Sender: TObject );
    procedure Up1Click ( Sender: TObject );
    procedure Down1Click ( Sender: TObject );
    procedure PageControl1MouseDown ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure PageControl1DragDrop ( Sender, Source: TObject; X, Y: Integer );
    procedure PageControl1DragOver ( Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean );
    procedure ListViewFramesClick ( Sender: TObject );
    procedure Fit1Click ( Sender: TObject );
    procedure Extent1Click ( Sender: TObject );
    procedure GrayScale1Click ( Sender: TObject );
    procedure Negative1Click ( Sender: TObject );
    procedure Select1Click ( Sender: TObject );
    procedure PaintPointClick ( Sender: TObject );
    procedure PaintLineClick ( Sender: TObject );
    procedure PaintRectClick ( Sender: TObject );
    procedure PaintRoundRectClick ( Sender: TObject );
    procedure PaintEllipseClick ( Sender: TObject );
    procedure PaintFilledRectClick ( Sender: TObject );
    procedure PaintFilledRoundRectClick ( Sender: TObject );
    procedure PaintFilledEllipseClick ( Sender: TObject );
    procedure PaintAlphaClick ( Sender: TObject );
    procedure UpDownPenWidthClick ( Sender: TObject; Button: TUDBtnType );
    procedure UpDownOpacityChanging ( Sender: TObject;
      var AllowChange: Boolean );
    procedure SelectNoneExecute ( Sender: TObject );
    procedure SelectRectExecute ( Sender: TObject );
    procedure SelectEllipseExecute ( Sender: TObject );
    procedure SelectZoomExecute ( Sender: TObject );
    procedure SelectMagicwandExecute ( Sender: TObject );
    procedure SelectPolygonExecute ( Sender: TObject );
    procedure SelectLassoExecute ( Sender: TObject );
    procedure SelectIconExecute ( Sender: TObject );
    procedure FileNewExecute ( Sender: TObject );
    procedure FileOpenBeforeExecute ( Sender: TObject );
    procedure FileSaveExecute ( Sender: TObject );
    procedure FileSaveAsBeforeExecute ( Sender: TObject );
    procedure FileSaveAsExecute ( Sender: TObject );
    procedure FileCloseExecute ( Sender: TObject );
    procedure EditCutExecute ( Sender: TObject );
    procedure EditCopyExecute ( Sender: TObject );
    procedure EditPasteExecute ( Sender: TObject );
    procedure EditUndoExecute ( Sender: TObject );
    procedure EditRedoExecute ( Sender: TObject );
    procedure EditCropExecute ( Sender: TObject );
    procedure EditPasteIntoSelectionExecute ( Sender: TObject );
    procedure FileOpenExecute ( Sender: TObject );
    procedure SelectMagicWandOptionsExecute ( Sender: TObject );
    procedure SelectInvertSelectionExecute ( Sender: TObject );
    procedure PickAlphaColorClick ( Sender: TObject );
    procedure ForeColorMouseDown ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure BackColorMouseDown ( Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Sort1Click ( Sender: TObject );
    procedure AboutExecute(Sender: TObject);
    procedure HelpExecute(Sender: TObject);
  private
    { Private declarations }
    TabSheet: TTabSheet;
    Image: TImageENView;
    startX, startY: integer;
    lastX, lastY: integer;
    AlphaChanging: boolean;
    OpacityChanging: boolean;
    Loading: boolean;
    Moving: boolean;
    procedure AddTabsheet;
    procedure UpdateMenu;
    procedure ClearStatusbar;
    procedure ImageEnViewMouseMove ( Sender: TObject; Shift: TShiftState; X,
      Y: Integer );
    procedure ImageEnViewMouseDown ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure ImageEnViewMouseUp ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure ImageEnViewSelectionChange ( Sender: TObject );
    procedure ImageEnViewMouseInSel ( Sender: TObject );
    procedure ImageEnViewProgress(Sender: TObject; per: Integer);
  protected
    procedure WMDropFiles ( var Msg: TMessage ); message wm_DropFiles;
    procedure AppOnMsg ( var Msg: TMsg; var Handled: Boolean );
    procedure MyUndo(ie:TImageEnView); // fdv
  public
    { Public declarations }
    FilePath: string;
    ImageENView: TImageENView;
  end;

  { Commands to pass to HtmlHelp() }

const
  HH_DISPLAY_TOPIC        = $0000;
  HH_HELP_FINDER          = $0000;  // WinHelp equivalent
  HH_DISPLAY_TOC          = $0001;  // not currently implemented
  HH_DISPLAY_INDEX        = $0002;  // not currently implemented
  HH_DISPLAY_SEARCH       = $0003;  // not currently implemented
  HH_SET_WIN_TYPE         = $0004;
  HH_GET_WIN_TYPE         = $0005;
  HH_GET_WIN_HANDLE       = $0006;
  HH_ENUM_INFO_TYPE       = $0007;  // Get Info type name, call repeatedly to enumerate, -1 at end
  HH_SET_INFO_TYPE        = $0008;  // Add Info type to filter.
  HH_SYNC                 = $0009;
  HH_RESERVED1            = $000A;
  HH_RESERVED2            = $000B;
  HH_RESERVED3            = $000C;
  HH_KEYWORD_LOOKUP       = $000D;
  HH_DISPLAY_TEXT_POPUP   = $000E;  // display string resource id or text in a popup window
  HH_HELP_CONTEXT         = $000F;  // display mapped numeric value in dwData
  HH_TP_HELP_CONTEXTMENU  = $0010;  // text popup help, same as WinHelp HELP_CONTEXTMENU
  HH_TP_HELP_WM_HELP      = $0011;  // text popup help, same as WinHelp HELP_WM_HELP
  HH_CLOSE_ALL            = $0012;  // close all windows opened directly or indirectly by the caller
  HH_ALINK_LOOKUP         = $0013;  // ALink version of HH_KEYWORD_LOOKUP
  HH_GET_LAST_ERROR       = $0014;  // not currently implemented // See HHERROR.h
  HH_ENUM_CATEGORY        = $0015;	// Get category name, call repeatedly to enumerate, -1 at end
  HH_ENUM_CATEGORY_IT     = $0016;  // Get category info type members, call repeatedly to enumerate, -1 at end
  HH_RESET_IT_FILTER      = $0017;  // Clear the info type filter of all info types.
  HH_SET_INCLUSIVE_FILTER = $0018;  // set inclusive filtering method for untyped topics to be included in display
  HH_SET_EXCLUSIVE_FILTER = $0019;  // set exclusive filtering method for untyped topics to be excluded from display
  HH_INITIALIZE           = $001C;  // Initializes the help system.
  HH_UNINITIALIZE         = $001D;  // Uninitializes the help system.
  HH_PRETRANSLATEMESSAGE  = $00fd;  // Pumps messages. (NULL, NULL, MSG*).
  HH_SET_GLOBAL_PROPERTY  = $00fc;  // Set a global property. (NULL, NULL, HH_GPROP)

var
  MainForm: TMainForm;

implementation

uses Clipbrd, ShellAPI, uSelectionProperties, uImport, uAbout, uSplash;

{$R *.DFM}

// global
function GetTempFile ( const Extension: string ): string;
var
  Buffer: array [ 0..MAX_PATH ] of Char;
begin
  repeat
    GetTempPath ( SizeOf ( Buffer ) - 1, Buffer );
    GetTempFileName ( Buffer, '', 0, Buffer );
    Result := ChangeFileExt ( Buffer, Extension );
  until not FileExists ( Result );
end;

function ColorToHex ( Color: TColor ): string;
begin
  Result := IntToHex ( GetRValue ( Color ), 2 ) + IntToHex ( GetGValue ( Color ), 2 ) + IntToHex ( GetBValue ( Color ), 2 );
end;

procedure TMainForm.WMDropFiles ( var Msg: TMessage );
var
  Filename: array [ 0..256 ] of Char;
  i: integer;
  w, h: integer;
  Frames: integer;
  ListItem: TListItem;
  fBitCount: integer;
  fBitsPerSample: integer;
  fSamplesPerPixel: integer;
  Filter: TResampleFilter;
begin
  Screen.Cursor := crHourglass;
  try
    DragQueryFile ( THandle ( Msg.WParam ), 0, Filename, Sizeof ( Filename ) );
    FilePath := Filename;
    PageControl1.Visible := False;
    // close all pages
    if PageControl1.PageCount > 0 then
      for i := PageControl1.PageCount - 1 downto 0 do
        PageControl1.Pages [ i ].Free;
    FilePath := FileName;
    Frames := IEGetFileFramesCount ( FilePath );
    if Frames > 1 then
    begin
      ListViewFrames.Clear;
      Preview.Clear;
      ProgressBar1.Max := Frames;
      Loading := True;
      for i := 0 to Frames - 1 do
      begin
        AddTabsheet;
        ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
        with ImageENView do
        begin
          Cursor := 1784;
          IO.Params.ICO_ImageIndex := i;
          IO.LoadFromFile ( FilePath );
          ListItem := ListViewFrames.Items.Add;
          ListItem.Caption := IntToStr ( i + 1 );
          ListItem.SubItems.Add ( IntToStr ( IEBitmap.Width ) + ' pixels x ' + IntToStr ( IEBitmap.Height ) + ' pixels' );
          ListItem.SubItems.Add ( IntToStr ( IO.Params.SamplesPerPixel * IO.Params.BitsPerSample ) + ' bit' );
          PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( i + 1 ) + ' ' + IntToStr ( IEBitmap.Width ) + ' pixels x ' + IntToStr ( IEBitmap.Height ) + ' pixels' + ' ' + IntToStr ( IO.Params.SamplesPerPixel * IO.Params.BitsPerSample ) + ' bit';
          ListItem.Selected := True;
          ListViewFrames.ItemIndex := i;
          ProgressBar1.Position := i;
          Bitmap.Modified := False;
        end;
      end;
      ImageEnView.Proc.ClearAllUndo;
      ImageEnView.Proc.ClearAllRedo;
      StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( FilePath );
      StatusBar1.Panels [ 1 ].Text := ExtractFileName ( FilePath );
      StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
      StatusBar1.Panels [ 5 ].Text := IntToStr ( ImageEnView.IO.Params.SamplesPerPixel * ImageEnView.IO.Params.BitsPerSample ) + ' bit';
      BackColor.Brush.Color := TRGB2TColor ( ImageEnView.AlphaChannel.Pixels [ 0, ImageEnView.Bitmap.Height - 1 ] );
      CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
      TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      ProgressBar1.Position := 0;
      PageControl1.Visible := True;
      UpdateMenu;
      Loading := False;
    end
    else // load single frame image
    begin
      ListViewFrames.Clear;
      Preview.Clear;
      ProgressBar1.Max := Frames;
      Loading := True;
      AddTabsheet;
      ImageENView := TImageENView ( PageControl1.Pages [ 0 ].Controls [ 0 ] );
      ImageENView.IO.LoadFromFile ( FilePath );
      ImageEnView.Proc.ClearAllUndo;
      ImageEnView.Proc.ClearAllRedo;
      if ( MessageDlg ( 'Resample the image?', mtConfirmation, [ mbYes, mbNo ], 0 ) = mrYes ) then
      begin
        with ImageENView.Proc do
        begin
          SaveUndoCaptioned ( 'Resample ' + IntToStr ( UndoCount ) );
          ClearAllRedo;
          ClearUndo;
        end;
        frmImport := TfrmImport.Create ( Self );
        try
          if frmImport.ShowModal = mrOk then
          begin
            w := frmImport.fIconWidth;
            h := frmImport.fIconHeight;
            fBitCount := frmImport.fBitCount;
            fBitsPerSample := frmImport.fBitsPerSample;
            fSamplesPerPixel := frmImport.fSamplesPerPixel;
            Filter := TResampleFilter ( frmImport.ComboBox1.ItemIndex );
            ImageENView.Proc.Resample ( w, h, Filter );
            ImageENView.IO.Params.Width := w;
            ImageENView.IO.Params.Height := h;
            ImageENView.IO.Params.ICO_BitCount [ PageControl1.ActivePageIndex ] := fBitCount;
            ImageENView.IO.Params.BitsPerSample := fBitsPerSample;
            ImageENView.IO.Params.SamplesPerPixel := fSamplesPerPixel;
            PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( PageControl1.ActivePageIndex + 1 ) + ' ' + IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels ' + IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit';
            ListItem := ListViewFrames.Items.Add;
            ListItem.Caption := IntToStr ( PageControl1.ActivePageIndex + 1 );
            ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels' );
            ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit' );
            ImageENView.Bitmap.Modified := True;
          end;
        finally; frmImport.Free; end;
      end
      else
      begin
        PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( PageControl1.ActivePageIndex + 1 ) + ' ' + IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels ' + IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit';
        ListItem := ListViewFrames.Items.Add;
        ListItem.Caption := IntToStr ( PageControl1.ActivePageIndex + 1 );
        ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels' );
        ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit' );
        ImageENView.Bitmap.Modified := True;
      end;
    end;
    StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( FilePath );
    StatusBar1.Panels [ 1 ].Text := ExtractFileName ( FilePath );
    StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
    StatusBar1.Panels [ 5 ].Text := IntToStr ( ImageEnView.IO.Params.SamplesPerPixel * ImageEnView.IO.Params.BitsPerSample ) + ' bit';
    BackColor.Brush.Color := TRGB2TColor ( ImageEnView.AlphaChannel.Pixels [ 0, ImageEnView.Bitmap.Height - 1 ] );
    CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
    TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
    ImageENView.Fit;
    Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
    Preview.Update;
    ProgressBar1.Position := 0;
    PageControl1.Visible := True;
    UpdateMenu;
    ListViewFrames.Items.Item [ ListViewFrames.Items.Count - 1 ].Selected := True;
    Loading := False;
  finally; Screen.Cursor := crDefault; end;
end;

procedure TMainForm.AppOnMsg ( var Msg: TMsg; var Handled: Boolean );
var
  Filename: array [ 0..256 ] of Char;
begin
  with Application do
    if ( Msg.Message = wm_DropFiles ) and ( IsIconic ( Handle ) ) then
    begin
      Screen.Cursor := crHourglass;
      try
        Loading := True;
        PageControl1.Visible := False;
        DragQueryFile ( THandle ( Msg.WParam ), 0, Filename, Sizeof ( Filename ) );
        AddTabsheet;
        ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
        ImageENView.Cursor := 1784;
        FilePath := FileName;
        PageControl1.ActivePage.Caption := FilePath;
        ImageENView.IO.LoadFromFile ( FilePath );
        PageControl1.ActivePageIndex := PageControl1.PageCount - 1;
        TrackBarZoom.Hint := 'Zoom: ' + FloatToStrF ( ImageENView.Zoom, ffFixed, 10, 1 ) + '%';
        ImageENView.Fit;
        UpdateMenu;
        ImageEnView.Proc.ClearAllUndo;
        ImageEnView.Proc.ClearAllRedo;
        StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( FilePath );
        StatusBar1.Panels [ 1 ].Text := ExtractFileName ( FilePath );
        StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
        StatusBar1.Panels [ 5 ].Text := IntToStr ( ImageEnView.IO.Params.SamplesPerPixel * ImageEnView.IO.Params.BitsPerSample ) + ' bit';
        BackColor.Brush.Color := TRGB2TColor ( ImageEnView.AlphaChannel.Pixels [ 0, ImageEnView.Bitmap.Height - 1 ] );
        CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
        TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
        ImageENView.Fit;
        Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
        Preview.Update;
        DragFinish ( THandle ( Msg.WParam ) );
        PageControl1.Visible := True;
        ListViewFrames.Items.Item [ ListViewFrames.Items.Count - 1 ].Selected := True;
        Loading := False;
      finally; Screen.Cursor := crDefault; end;
    end;
end;

procedure TMainForm.FormCreate ( Sender: TObject );
begin
  frmSplash.Progress := 20;
  Sleep ( 150 );
  DragAcceptFiles ( Handle, True );
  Application.OnMessage := AppOnMsg;
  frmSplash.Progress := 40;
  Sleep ( 150 );
  ForeColor.Brush.Color := clRed;
  Preview.SetChessboardStyle ( 6, bsSolid );
  frmSplash.Progress := 60;
  Sleep ( 150 );
  UpdateMenu;
  Loading := False;
  Moving := False;
  frmSplash.Progress := 80;
  Sleep ( 150 );
  OpacityChanging := False;
  AlphaChanging := False;
  frmSplash.Progress := 100;
  Application.HelpFile := ExtractFilePath(Application.ExeName) + 'plainiconeditor.chm';
  Sleep ( 300 );
end;

procedure TMainForm.AddTabsheet;
begin
  // create a new tabsheet
  with PageControl1 do
    TabSheet := TTabSheet.Create ( Self );
  // set the tabsheet.pagecontrol to PageControl1
  TabSheet.PageControl := PageControl1;
  // set the activepage to tabsheet
  PageControl1.ActivePage := TabSheet;
  with Tabsheet do
  begin
  // create an ImageENView component
    Image := TImageENView.Create ( Self );
    Image.Parent := Tabsheet;
    Image.Align := alClient;
    Image.Visible := True;
    Image.ZoomFilter := rfNone;
    Image.SetChessboardStyle ( 6, bsSolid );
    Image.SetSelectionGripStyle ( clwhite, clred, bsSolid, 3, true );
    Image.DelayDisplaySelection := True;
    Image.IEBitmap.AlphaChannel.Location := ieTBitmap; // handle the alpha channel as TBitmap
    Image.SelectionBase := iesbBitmap;
    Image.Proc.AutoUndo := False;
    Image.Proc.UndoLimit := 15;
    Image.Background := $00FFF4F4;
    Image.Zoom := 1000;
    Image.AutoFit := False;
    Image.DisplayGrid := True;
    Image.BorderStyle := bsSingle;
    Image.MouseInteract := [ ];
    Image.Cursor := 1784;
    Image.OnProgress := ImageEnViewProgress;
    Image.OnMouseDown := ImageEnViewMouseDown;
    Image.OnMouseMove := ImageEnViewMouseMove;
    Image.OnMouseUp := ImageEnViewMouseUp;
    //Image.OnImageChange := ImageEnViewImageChange;
    Image.OnSelectionChange := ImageEnViewSelectionChange;
    Image.OnMouseInSel := ImageEnViewMouseInSel;
    Image.Tag := 0;
    Image.SelColor1 := clRed;
    Image.SelColor2 := clWhite;
    Image.BackgroundStyle := iebsChessboard;
    Image.EnableAlphaChannel := True;
    Image.Proc.AttachedImageEn := Image;
    // mouse wheel will scroll image of 15 % of component height
    Image.MouseWheelParams.Action := iemwVScroll;
    Image.MouseWheelParams.Variation := iemwPercentage;
    Image.MouseWheelParams.Value := 15;
    // set scrollbar params to match wheel
    Image.HScrollBarParams.LineStep := 15;
    Image.VScrollBarParams.LineStep := 15;
    // the folowing two lines are the key to referencing the components later
    // set tag to monitor image change - 0 = false, 1 = true
    TabSheet.Tag := Integer ( Image );
  end;
end;

procedure TMainForm.UpdateMenu;
var
  e: boolean;
begin
  e := PageControl1.PageCount >= 1;
  FileClose1.Enabled := e;
  FileSave1.Enabled := e;
  FileSaveAs1.Enabled := e;
  SelectButton1.Enabled := e;
  Edit1.Enabled := e;
  EditFillTolerance.Enabled := e;
  EditCopy1.Enabled := e;
  EditPaste1.Enabled := ( Clipboard.HasFormat ( CF_PICTURE ) ) and ( e );
  EditPasteIntoSelection1.Enabled := ( Clipboard.HasFormat ( CF_PICTURE ) ) and ( e );
  Select1.Enabled := e;
  SelectNone1.Enabled := e;
  SelectRectangle1.Enabled := e;
  SelectEllipse1.Enabled := e;
  SelectZoom1.Enabled := e;
  SelectMagicWand1.Enabled := e;
  SelectPolygon1.Enabled := e;
  SelectLasso1.Enabled := e;
  SelectMagicWandOptions1.Enabled := e;
  SelectInvertSelection1.Enabled := e;
  SidePanel1.Enabled := e;
  ListViewFrames.Enabled := e;
  GroupBox1.Enabled := e;
  ForeColor.Enabled := e;
  CurrentFore.Enabled := e;
  CurrentBack.Enabled := e;
  PaintTransparency.Enabled := e;
  UpDownAlpha.Enabled := e;
  UpDownFillTolerance.Enabled := e;
  Label2.Enabled := e;
  LabelAlpha.Enabled := e;
  OpacityLabel.Enabled := e;
  PaintOpacity.Enabled := e;
  UpDownOpacity.Enabled := e;
  LabelPenWidth.Enabled := e;
  EditPenWidth.Enabled := e;
  UpDownPenWidth.Enabled := e;
  TrackBarZoom.Enabled := e;
  Up1.Enabled := e;
  Down1.Enabled := e;
  Delete1.Enabled := e;
  Sort1.Enabled := e;
  Import1.Enabled := e;
  Export1.Enabled := e;
  PaintPoint.Enabled := e;
  PaintRect.Enabled := e;
  PaintRoundRect.Enabled := e;
  PaintEllipse.Enabled := e;
  PaintFilledRect.Enabled := e;
  PaintFilledRoundRect.Enabled := e;
  PaintFilledEllipse.Enabled := e;
  PaintLine.Enabled := e;
  PickAlpha.Enabled := e;
  PaintAlpha.Enabled := e;
  PickColor.Enabled := e;
  PickAlphaColor.Enabled := e;
  FillAdjacentForeground.Enabled := e;
  FillAdjacentBackground.Enabled := e;
  SetAlpha.Enabled := e;
  MakeXPIcon1.Enabled := e;
  AddSoftShadow1.Enabled := e;
  AddInsideShadow1.Enabled := e;
  CheckBoxEnableAlpha.Enabled := e;
  CheckBox1.Enabled := e;
  ProgressBar1.Enabled := e;
  TrackBar1.Enabled := e;
  SaveButton1.Enabled := e;
  SaveAsButton1.Enabled := e;
  CloseButton1.Enabled := e;
  CopyButton1.Enabled := e;
  EditCut1.Enabled := e;
  CutButton1.Enabled := e;
  EditCrop1.Enabled := e;
  CropButton1.Enabled := e;
  EditUndo1.Enabled := e;
  EditUndo2.Enabled := e;
  UndoButton1.Enabled := e;
  EditRedo1.Enabled := e;
  EditRedo2.Enabled := e;
  RedoButton1.Enabled := e;
  GrayScale1.Enabled := e;
  Negative1.Enabled := e;
  Fit1.Enabled := e;
  Extent1.Enabled := e;
  if ListViewFrames.Items.Count > 0 then
  begin
    if assigned(ListViewFrames.Selected) then // fdv
    begin
      Down1.Enabled := ListViewFrames.Selected.Index < ListViewFrames.Items.Count-1;
      Up1.Enabled := ListViewFrames.Selected.Index > 0;
    end;
  end;
  PasteButton1.Enabled := ( Clipboard.HasFormat ( CF_PICTURE ) );
  if PageControl1.PageCount <> 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    EditCut1.Enabled := ( e ) and ( ImageENView.Selected );
    CutButton1.Enabled := ( e ) and ( ImageENView.Selected );
    EditCrop1.Enabled := ( e ) and ( ImageENView.Selected );
    CropButton1.Enabled := ( e ) and ( ImageENView.Selected );
    EditUndo1.Enabled := ( e ) and ( ImageENView.Proc.CanUndo );
    EditUndo2.Enabled := ( e ) and ( ImageENView.Proc.CanUndo );
    UndoButton1.Enabled := ( e ) and ( ImageENView.Proc.CanUndo );
    EditRedo1.Enabled := ( e ) and ( ImageENView.Proc.CanRedo );
    EditRedo2.Enabled := ( e ) and ( ImageENView.Proc.CanRedo );
    RedoButton1.Enabled := ( e ) and ( ImageENView.Proc.CanRedo );
  end
end;

procedure TMainForm.ClearStatusbar;
begin
  StatusBar1.Panels [ 0 ].Text := '';
  StatusBar1.Panels [ 1 ].Text := '';
  StatusBar1.Panels [ 2 ].Text := '';
  StatusBar1.Panels [ 3 ].Text := '';
  StatusBar1.Panels [ 4 ].Text := '';
  StatusBar1.Panels [ 5 ].Text := '';
  StatusBar1.Panels [ 6 ].Text := '';
end;

procedure TMainForm.FileExit1Click ( Sender: TObject );
begin
  Close;
end;

procedure TMainForm.TrackBarZoomChange ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageEnView.Zoom := TrackBarZoom.Position;
    TrackBarZoom.Hint := 'Zoom: ' + FloatToStrF ( ImageEnView.Zoom, ffFixed, 10, 1 ) + '%';
    Application.ActivateHint ( Mouse.CursorPos );
    ImageENView.Update;
  end;
end;

procedure SetGrayPal ( hdc: integer );
var
  pe: array [ 0..255 ] of TRGBQuad;
  i: integer;
begin
  for i := 0 to 255 do
    with pe [ i ] do
    begin
      rgbRed := i;
      rgbGreen := i;
      rgbBlue := i;
      rgbReserved := 0;
    end;
  SetDibColorTable ( hdc, 0, 256, pe );
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
    Canvas.Pen.Handle := ExtCreatePen ( PS_Geometric or PS_Solid or PS_ENDCAP_SQUARE, Width, LogBrush, 0, nil );
  end
  else
  begin
    Canvas.Pen.Color := Color;
    Canvas.Pen.Width := Width;
    Canvas.Pen.Style := psSolid;
  end;
end;

procedure TMainForm.ImageEnViewMouseDown ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  BX, BY: integer;
  RGBColor: TRGB;
  o: single;
  Opacity: integer;
  Transparency: integer;
  P1: TPoint;
  PenWidth: integer;
  x1, y1, x2, y2: integer;
begin
  ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );

  PenWidth := UpDownPenWidth.Position;

  with ImageENView do
  begin
    if MouseInteract <> [ miZoom ] then
      if Button = mbRight then
      begin
        GetCursorPos ( P1 );
        PopupMenu1.Popup ( P1.x, P1.y );
      end;
    SetFocus;
  end;

  // we need to draw on alphachannel using GDI (Canvas), then it must be ieTBitmap and pf8bit
  with ImageEnView do
  begin
    BX := XScr2Bmp ( X );
    BY := YScr2Bmp ( Y );
    startX := XScr2Bmp ( X );
    startY := YScr2Bmp ( Y );
    IEBitmap.Canvas.Pen.Width := PenWidth;
    IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
    IEBitmap.AlphaChannel.Location := ieTBitmap;
    IEBitmap.AlphaChannel.PixelFormat := ie8g;
    IEBitmap.AlphaChannel.VclBitmap.PixelFormat := pf8bit;
    SetGrayPal ( IEBitmap.AlphaChannel.VclBitmap.Canvas.Handle );
  end;

  if PaintPoint.Down then
  begin
    // Paint Point- with lineto
    with ImageEnView do
    begin
      MyUndo(ImageEnView); // fdv
      SetSquarePen ( IEBitmap.Canvas, ForeColor.Brush.Color, PenWidth );
      IEBitmap.Canvas.MoveTo ( startX, startY );
      IEBitmap.Canvas.LineTo ( BX, BY );
      IEBitmap.Canvas.LineTo ( startX, startY );
      Transparency := UpDownAlpha.Position;
      SetSquarePen ( IEBitmap.AlphaChannel.Canvas, $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 ), PenWidth );
      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.MoveTo ( startX, startY );
      IEBitmap.AlphaChannel.Canvas.LineTo ( BX, BY );
      IEBitmap.AlphaChannel.Canvas.LineTo ( startX, startY );
      Update;

      // Paint last pixel Point
      with ImageEnView do
      begin
        BX := XScr2Bmp ( X );
        BY := YScr2Bmp ( Y );
        IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
        IEBitmap.Canvas.Pen.Width := PenWidth;
        IEBitmap.Canvas.Pixels [ BX, BY ] := ForeColor.Brush.Color;
        Transparency := UpDownAlpha.Position;
        IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
        IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
        IEBitmap.AlphaChannel.Canvas.Pixels [ BX, BY ] := ForeColor.Brush.Color;
        IEBitmap.Alpha [ BX, BY ] := UpDownAlpha.Position;
        Update;
      end;
    end;
  end
  else
    if PaintAlpha.Down then
    begin
    // Paint Alpha
      with ImageENView do
      begin
        Proc.SaveUndo ( ieuImage );
        IEBitmap.AlphaChannel.Canvas.Pen.Color := ForeColor.Brush.Color;
        IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
        IEBitmap.AlphaChannel.Canvas.Pixels [ BX, BY ] := ForeColor.Brush.Color;
        IEBitmap.Alpha [ BX, BY ] := UpDownAlpha.Position;
        Update;
      end;
      UpdateMenu;
    end
    else
      if PaintLine.Down then
      begin
    // Begin paint line
        with ImageENView do
        begin
          Proc.SaveUndo ( ieuImage );
        end;
        UpdateMenu;
      end
      else
        if PaintEllipse.Down then
        begin
    // Begin paint ellipse
          with ImageENView do
          begin
            Proc.SaveUndo ( ieuImage );
          end;
          UpdateMenu;
        end
        else
          if PaintRect.Down then
          begin
    // Begin paint rect
            with ImageENView do
            begin
              Proc.SaveUndo ( ieuImage );
              UpdateMenu;
              MyUndo(ImageEnView); // fdv
              IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
              IEBitmap.Canvas.Pen.Width := PenWidth;
              IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
              IEBitmap.Canvas.Brush.Style := bsClear;
              Transparency := UpDownAlpha.Position;
              IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
              IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
              IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
              IEBitmap.AlphaChannel.Canvas.Brush.Style := bsClear;
            end;
          end
          else
            if PaintRoundRect.Down then
            begin
  // Begin paint round rect
              with ImageENView do
              begin
                Proc.SaveUndo ( ieuImage );
                UpdateMenu;
                MyUndo(ImageEnView); // fdv
                IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                IEBitmap.Canvas.Pen.Width := PenWidth;
                IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
                IEBitmap.Canvas.Brush.Style := bsClear;
                Transparency := UpDownAlpha.Position;
                IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                IEBitmap.AlphaChannel.Canvas.Brush.Style := bsClear;
              end;
            end
            else
              if PaintFilledRect.Down and ImageEnView.MouseCapture then
              begin
  // Begin paint filled rect
                with ImageENView do
                begin
                  Proc.SaveUndo ( ieuImage );
                  UpdateMenu;
                  IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                  IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
                  IEBitmap.Canvas.Pen.Width := PenWidth;
                  IEBitmap.Canvas.Brush.Style := bsSolid;
                  Transparency := UpDownAlpha.Position;
                  IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                  IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                  IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                end;
              end
              else
                if PaintFilledRoundRect.Down and ImageEnView.MouseCapture then
                begin
    // Paint Filled Round Rect
                  with ImageEnView do
                  begin
                    Proc.SaveUndo ( ieuImage );
                    UpdateMenu;
                    MyUndo(ImageEnView); // fdv
                    IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                    IEBitmap.Canvas.Pen.Width := PenWidth;
                    IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
                    IEBitmap.Canvas.Brush.Style := bsSolid;
                    Transparency := UpDownAlpha.Position;
                    IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                    IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                    IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                    IEBitmap.AlphaChannel.Canvas.Brush.Style := bsSolid;
                    Update;
                  end;
                end
                else
                  if PaintFilledEllipse.Down and ImageEnView.MouseCapture then
                  begin
    // Paint Filled Ellipse
                    with ImageEnView do
                    begin
                      Proc.SaveUndo ( ieuImage );
                      UpdateMenu;
                      MyUndo(ImageEnView); // fdv
                      IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                      IEBitmap.Canvas.Pen.Width := PenWidth;
                      IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
                      IEBitmap.Canvas.Brush.Style := bsSolid;
                      Transparency := UpDownAlpha.Position;
                      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                      IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                      IEBitmap.AlphaChannel.Canvas.Brush.Style := bsSolid;
                      Update;
                    end;
                  end
                  else
                    if FillAdjacentForeground.Down then
                    begin
                      with ImageENView.Proc do
                      begin
                        SaveUndo ( ieuImage );
                        RGBColor := TColor2TRGB ( ForeColor.Brush.Color );
                        CastAlpha ( BX, BY, UpDownAlpha.Position, UpDownFillTolerance.Position );
                        CastColor ( BX, BY, RGBColor, UpDownFillTolerance.Position );
                      end;
                      UpdateMenu;
                    end
                    else
                      if FillAdjacentBackground.Down then
                      begin
                        with ImageENView.Proc do
                        begin
                          SaveUndo ( ieuImage );
                          RGBColor := TColor2TRGB ( BackColor.Brush.Color );
                          CastAlpha ( BX, BY, UpDownAlpha.Position, UpDownFillTolerance.Position );
                          CastColor ( BX, BY, RGBColor, UpDownFillTolerance.Position );
                        end;
                        UpdateMenu;
                      end
                      else
                        if PickAlpha.Down and ImageEnView.MouseCapture then
                        begin
                          UpDownAlpha.Position := ImageEnView.IEBitmap.Alpha [ BX, BY ];
                          o := ( UpDownOpacity.Position / 255 ) * 100;
                          Opacity := Trunc ( o );
                          UpDownOpacity.Position := Opacity;
                          PickAlpha.Down := False;
                          ImageENView.Cursor := 1784;
                        end
                        else
                          if PickColor.Down and ImageEnView.MouseCapture then
                          begin
                            ForeColor.Brush.Color := ImageEnView.IEBitmap.Canvas.Pixels [ BX, BY ];
                            PickColor.Down := False;
                            ImageENView.Cursor := 1784;
                          end
                          else
                            if PickAlphaColor.Down and ImageEnView.MouseCapture then
                            begin
                              UpDownAlpha.Position := ImageEnView.IEBitmap.Alpha [ BX, BY ];
                              o := ( UpDownOpacity.Position / 255 ) * 100;
                              Opacity := Trunc ( o );
                              UpDownOpacity.Position := Opacity;
                              BackColor.Brush.Color := ImageEnView.IEBitmap.Canvas.Pixels [ BX, BY ];
                              PickAlphaColor.Down := False;
                              ImageENView.Cursor := 1784;
                            end;
end;

procedure TMainForm.ImageEnViewMouseMove ( Sender: TObject;
  Shift: TShiftState; X, Y: Integer );
var
  SLeft: integer;
  STop: integer;
  SRight: integer;
  SBottom: integer;
  SHeight: integer;
  SWidth: integer;
  Transparency: integer;
  BX, BY: integer;
  PenWidth: integer;
  x1, y1, x2, y2: integer;
begin
  ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
  PenWidth:=UpDownPenWidth.Position;
  with ImageENView do
  begin
    BX := XScr2Bmp ( X );
    BY := YScr2Bmp ( Y );
    SLeft := SelX1;
    STop := SelY1;
    SRight := SelX2;
    SBottom := SelY2;
    SHeight := SBottom - STop;
    SWidth := SRight - SLeft;
  end;
  if ( ImageENView.Selected ) then
  begin
    StatusBar1.Panels [ 4 ].Text := 'Selected: ' + IntToStr ( SWidth + 1 ) + ' x ' + IntToStr ( SHeight + 1 ) + ' pixels ';
    if ( not ImageENView.IsPointInsideSelection ( X, Y ) ) and ( MarkOuter1.Checked ) then
    begin
      if ( iesoMarkOuter in ImageENView.SelectionOptions ) then
        ImageENView.SelectionOptions := ImageENView.SelectionOptions - [ iesoMarkOuter ];
    end
    else
    begin
      if not ( iesoMarkOuter in ImageENView.SelectionOptions ) then
        if MarkOuter1.Checked then
          ImageENView.SelectionOptions := ImageENView.SelectionOptions + [ iesoMarkOuter ];
    end;
  end;
  if ( BY + 1 <= ImageEnView.Bitmap.Height ) and
    ( BY + 1 >= 1 ) then
  begin
    StatusBar1.Panels [ 2 ].Text := 'Row: ' + IntToStr ( BY + 1 );
    StatusBar1.Panels [ 3 ].Text := 'Column: ' + IntToStr ( BX + 1 )
  end
  else
  begin
    StatusBar1.Panels [ 2 ].Text := '';
    StatusBar1.Panels [ 3 ].Text := '';
  end;
  if ( BX + 1 >= 1 ) and
    ( BX + 1 <= ImageEnView.Bitmap.Width ) then
  begin
    StatusBar1.Panels [ 2 ].Text := 'Row: ' + IntToStr ( BY + 1 );
    StatusBar1.Panels [ 3 ].Text := 'Column: ' + IntToStr ( BX + 1 );
  end
  else
  begin
    StatusBar1.Panels [ 2 ].Text := '';
    StatusBar1.Panels [ 3 ].Text := '';
  end;
  if ( BX + 1 > ImageEnView.Bitmap.Width ) or
    ( BY + 1 > ImageEnView.Bitmap.Height ) or
    ( BX + 1 <= 0 ) or ( BY + 1 <= 0 ) then
  begin
    StatusBar1.Panels [ 2 ].Text := '';
    StatusBar1.Panels [ 3 ].Text := '';
    exit;
  end;

  // show current color and alpha values
  CurrentFore.Brush.Color := ImageEnView.IEBitmap.Canvas.Pixels [ BX, BY ];
  CurrentBack.Brush.Color := ImageEnView.IEBitmap.AlphaChannel.Canvas.Pixels [ BX, BY ];
  LabelAlpha1.Caption := 'Alpha: ' + IntToStr ( ImageEnView.IEBitmap.Alpha [ BX, BY ] );

  if PaintPoint.Down and ImageEnView.MouseCapture then
  begin
    // Paint Point
    with ImageEnView do
    begin
      MyUndo(ImageEnView); // fdv
      IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
      IEBitmap.Canvas.Pen.Width := PenWidth;
      IEBitmap.Canvas.MoveTo ( startX, startY );
      IEBitmap.Canvas.LineTo ( BX, BY );
      IEBitmap.Canvas.LineTo ( startX, startY );
      Transparency := UpDownAlpha.Position;
      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.MoveTo ( startX, startY );
      IEBitmap.AlphaChannel.Canvas.LineTo ( BX, BY );
      IEBitmap.AlphaChannel.Canvas.LineTo ( startX, startY );
      Update;
    end;
  end
  else
    if PaintAlpha.Down and ImageEnView.MouseCapture then
    begin
    // Paint Alpha
      with ImageEnView do
      begin
        IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
        IEBitmap.AlphaChannel.Canvas.Pen.Color := ForeColor.Brush.Color;
        IEBitmap.AlphaChannel.Canvas.Pixels [ BX, BY ] := ForeColor.Brush.Color;
        IEBitmap.Alpha [ BX, BY ] := UpDownAlpha.Position;
        Update;
      end;
    end
    else
      if PaintLine.Down and ImageEnView.MouseCapture then
      begin
  // Paint Line
        with ImageEnView do
        begin
          MyUndo(ImageEnView); // fdv
          SetSquarePen ( IEBitmap.Canvas, ForeColor.Brush.Color, PenWidth );
          IEBitmap.Canvas.MoveTo ( startX, startY );
          IEBitmap.Canvas.LineTo ( BX, BY );
          IEBitmap.Canvas.LineTo ( startX, startY );
          Transparency := UpDownAlpha.Position;
          SetSquarePen ( IEBitmap.AlphaChannel.Canvas, $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 ), PenWidth );
          IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
          IEBitmap.AlphaChannel.Canvas.MoveTo ( startX, startY );
          IEBitmap.AlphaChannel.Canvas.LineTo ( BX, BY );
          IEBitmap.AlphaChannel.Canvas.LineTo ( startX, startY );
          Update;
        end;
      end
      else
        if PaintEllipse.Down and ImageEnView.MouseCapture then
        begin
    // Paint Ellipse
          with ImageEnView do
          begin
            MyUndo(ImageEnView); // fdv
            IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
            IEBitmap.Canvas.Pen.Width := PenWidth;
            IEBitmap.Canvas.Brush.Style := bsClear;
            IEBitmap.Canvas.Ellipse ( startX, startY, BX, BY );
            Transparency := UpDownAlpha.Position;
            IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
            IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
            IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
            IEBitmap.AlphaChannel.Canvas.Brush.Style := bsClear;
            IEBitmap.AlphaChannel.Canvas.Ellipse ( startX, startY, BX, BY );
            Update;
          end;
        end
        else
          if PaintRect.Down and ImageEnView.MouseCapture then
          begin
    // Paint Rect
            with ImageEnView do
            begin
              MyUndo(ImageEnView); // fdv
              IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
              IEBitmap.Canvas.Pen.Width := PenWidth;
              IEBitmap.Canvas.Brush.Style := bsClear;
              IEBitmap.Canvas.Rectangle ( startX, startY, BX, BY );
              Transparency := UpDownAlpha.Position;
              IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
              IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
              IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
              IEBitmap.AlphaChannel.Canvas.Brush.Style := bsClear;
              IEBitmap.AlphaChannel.Canvas.Rectangle ( startX, startY, BX, BY );
              Update;
            end;
          end
          else
            if PaintRoundRect.Down and ImageEnView.MouseCapture then
            begin
    // Paint Round Rect
              with ImageEnView do
              begin
                MyUndo(ImageEnView); // fdv
                IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                IEBitmap.Canvas.Pen.Width := PenWidth;
                IEBitmap.Canvas.Brush.Style := bsClear;
                IEBitmap.Canvas.RoundRect ( startX, startY, BX, BY, 5, 5 );
                Transparency := UpDownAlpha.Position;
                IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                IEBitmap.AlphaChannel.Canvas.Brush.Style := bsClear;
                IEBitmap.AlphaChannel.Canvas.RoundRect ( startX, startY, BX, BY, 5, 5 );
                Update;
              end;
            end
            else
              if PaintFilledRect.Down and ImageEnView.MouseCapture then
              begin
    // Paint Filled Rect
                with ImageEnView do
                begin
                  MyUndo(ImageEnView); // fdv
                  IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                  IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
                  IEBitmap.Canvas.Pen.Width := PenWidth;
                  IEBitmap.Canvas.Brush.Style := bsSolid;
                  IEBitmap.Canvas.Rectangle ( startX, startY, BX, BY );
                  Transparency := UpDownAlpha.Position;
                  IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                  IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                  IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                  IEBitmap.AlphaChannel.Canvas.Brush.Style := bsSolid;
                  IEBitmap.AlphaChannel.Canvas.Rectangle ( startX, startY, BX, BY );
                  Update;
                end;
              end
              else
                if PaintFilledRoundRect.Down and ImageEnView.MouseCapture then
                begin
    // Paint Filled Round Rect
                  with ImageEnView do
                  begin
                    MyUndo(ImageEnView); // fdv
                    IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                    IEBitmap.Canvas.Pen.Width := PenWidth;
                    IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
                    IEBitmap.Canvas.Brush.Style := bsSolid;
                    IEBitmap.Canvas.RoundRect ( startX, startY, BX, BY, 5, 5 );
                    Transparency := UpDownAlpha.Position;
                    IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                    IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                    IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                    IEBitmap.AlphaChannel.Canvas.Brush.Style := bsSolid;
                    IEBitmap.AlphaChannel.Canvas.RoundRect ( startX, startY, BX, BY, 5, 5 );
                    Update;
                  end;
                end
                else
                  if PaintFilledEllipse.Down and ImageEnView.MouseCapture then
                  begin
    // Paint Filled Ellipse
                    with ImageEnView do
                    begin
                      MyUndo(ImageEnView); // fdv
                      IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
                      IEBitmap.Canvas.Pen.Width := PenWidth;
                      IEBitmap.Canvas.Brush.Color := BackColor.Brush.Color;
                      IEBitmap.Canvas.Brush.Style := bsSolid;
                      IEBitmap.Canvas.Ellipse ( startX, startY, BX, BY );
                      Transparency := UpDownAlpha.Position;
                      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                      IEBitmap.AlphaChannel.Canvas.Pen.Width := PenWidth;
                      IEBitmap.AlphaChannel.Canvas.Brush.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
                      IEBitmap.AlphaChannel.Canvas.Brush.Style := bsSolid;
                      IEBitmap.AlphaChannel.Canvas.Ellipse ( startX, startY, BX, BY );
                      Update;
                    end;
                  end;
  with ImageEnView do
  begin
    lastX := XScr2Bmp ( X );
    lastY := YScr2Bmp ( Y );
  end;
end;

procedure TMainForm.ImageEnViewMouseUp ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  BX, BY: integer;
  Transparency: integer;
begin
  ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
  if PaintPoint.Down then
  begin
    // Paint last pixel Point
    with ImageEnView do
    begin
      BX := XScr2Bmp ( X );
      BY := YScr2Bmp ( Y );
      IEBitmap.Canvas.Pen.Color := ForeColor.Brush.Color;
      IEBitmap.Canvas.Pen.Width := UpDownPenWidth.Position;
      IEBitmap.Canvas.Pixels [ BX, BY ] := ForeColor.Brush.Color;
      Transparency := UpDownAlpha.Position;
      IEBitmap.AlphaChannel.Canvas.Pen.Color := $02000000 or ( Transparency ) or ( Transparency shl 8 ) or ( Transparency shl 16 );
      IEBitmap.AlphaChannel.Canvas.Pen.Width := UpDownPenWidth.Position;
      IEBitmap.AlphaChannel.Canvas.Pixels [ BX, BY ] := ForeColor.Brush.Color;
      IEBitmap.Alpha [ BX, BY ] := UpDownAlpha.Position;
      Update;
    end;
  end;
end;

procedure TMainForm.CheckBox1Click ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageEnView.DisplayGrid := CheckBox1.Checked;
  end;
end;

procedure TMainForm.ImageEnViewSelectionChange ( Sender: TObject );
begin
  UpdateMenu;
end;

procedure TMainForm.ImageEnViewMouseInSel ( Sender: TObject );
var
  SLeft: integer;
  STop: integer;
  SRight: integer;
  SBottom: integer;
  SHeight: integer;
  SWidth: integer;
begin
  with ImageENView do
  begin
    SLeft := SelX1;
    STop := SelY1;
    SRight := SelX2;
    SBottom := SelY2;
    SHeight := SBottom - STop;
    SWidth := SRight - SLeft;
  end;
  StatusBar1.Panels [ 4 ].Text := 'Selected: ' + IntToStr ( SWidth + 1 ) + ' x ' + IntToStr ( SHeight + 1 ) + ' pixels ';
end;

procedure TMainForm.ListViewFramesSelectItem ( Sender: TObject;
  Item: TListItem; Selected: Boolean );
begin
  if not Moving then
  begin
    if ( not loading ) and ( PageControl1.PageCount > 0 ) and ( PageControl1.PageCount = ListViewFrames.Items.Count ) then
    begin
      if PageControl1.ActivePageIndex <> Item.Index then
        PageControl1.ActivePageIndex := Item.Index;
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      case ImageENView.Bitmap.Width of
        16: ImageENView.Zoom := 3071;
        24: ImageENView.Zoom := 2034;
        32: ImageENView.Zoom := 1510;
        64: ImageENView.Zoom := 760;
        72: ImageENView.Zoom := 679;
        96: ImageENView.Zoom := 504;
        128: ImageENView.Zoom := 510;
      end; // case
      CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      Down1.Enabled := Item.Index < ListViewFrames.Items.Count-1;
      Up1.Enabled := Item.Index > 0;
    end;
  end;
end;

procedure TMainForm.FileSaveAs1Click ( Sender: TObject );
var
  i: integer;
  Frames: array of TObject;
  FT: TIOFileType;
begin
  if PageControl1.PageCount > 0 then
  begin
    SaveImageEnDialog1.FileName := '';
    SaveImageEnDialog1.FilterIndex := 5;
    SaveImageEnDialog1.DefaultExt := '.bmp';
    if SaveImageEnDialog1.Execute then
    begin
      Screen.Cursor := crHourglass;
      try
        ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
        FT := ImageENView.IO.Params.FileType;
        if FT = 6 then // icon
        begin
          SetLength ( Frames, PageControl1.PageCount );
          ProgressBar1.Max := PageControl1.PageCount - 1;
          for i := PageControl1.PageCount - 1 downto 0 do
          begin
            ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
            Frames [ i ] := ImageENView;
            ImageENView.IO.Params.ICO_ImageIndex := i;
            ProgressBar1.Position := i;
          end;
        // save the icon
          IEWriteICOImages ( SaveImageEnDialog1.FileName, Frames );
          ImageENView.Bitmap.Modified := False;
          ProgressBar1.Position := 0;
          UpdateMenu;
        end
        else // not icon
        begin
          ImageENView.IO.DoPreviews ( );
          ImageENView.IO.SaveToFile ( SaveImageEnDialog1.FileName );
          ImageENView.Bitmap.Modified := False;
          ProgressBar1.Position := 0;
          UpdateMenu;
        end;
      finally Screen.Cursor := crDefault; end;
    end;
  end;
end;

procedure TMainForm.PageControl1Change ( Sender: TObject );
begin
  if not Moving then
    ListViewFrames.ItemIndex := PageControl1.ActivePageIndex;
  ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
  ImageENView.Fit;
end;

procedure TMainForm.Delete1Click ( Sender: TObject );
var
  ListItem: TListItem;
begin
  Moving := False;
  if MessageBox ( 0, 'Delete selected frame?', 'Delete', MB_ICONQUESTION or MB_YESNO ) = mrYes then
  begin
    if ListViewFrames.SelCount > 0 then
    begin
      ListItem := ListViewFrames.Selected;
      ListItem.Delete;
      ListViewFrames.Invalidate;
      PageControl1.ActivePage.Free;
      PageControl1.SelectNextPage ( False );
    end;
  end;
end;

procedure TMainForm.Import1Click ( Sender: TObject );
var
  fIconWidth: integer;
  fIconHeight: integer;
  fBitCount: integer;
  fBitsPerSample: integer;
  fSamplesPerPixel: integer;
  ListItem: TListItem;
  Filter: TResampleFilter;
begin
  OpenImageEnDialog1.FileName := '';
  OpenImageEnDialog1.AutoSetFilter := true;
  OpenImageEnDialog1.Title := 'Import Icon...';
  if OpenImageEnDialog1.Execute then
  begin
    Screen.Cursor := crHourglass;
    try
      Moving := False;
      frmImport := TfrmImport.Create ( Self );
      try
        if frmImport.ShowModal = mrOk then
        begin
          AddTabsheet;
          ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
          ImageENView.IO.LoadFromFile ( OpenImageEnDialog1.FileName );
          fIconWidth := frmImport.fIconWidth;
          fIconHeight := frmImport.fIconHeight;
          fBitCount := frmImport.fBitCount;
          fBitsPerSample := frmImport.fBitsPerSample;
          fSamplesPerPixel := frmImport.fSamplesPerPixel;
          Filter := TResampleFilter ( frmImport.ComboBox1.ItemIndex );
          ImageENView.Proc.Resample ( fIconWidth, fIconHeight, Filter );
          ImageENView.IO.Params.Width := fIconWidth;
          ImageENView.IO.Params.Height := fIconHeight;
          ImageENView.IO.Params.ICO_BitCount [ PageControl1.ActivePageIndex ] := fBitCount;
          ImageENView.IO.Params.BitsPerSample := fBitsPerSample;
          ImageENView.IO.Params.SamplesPerPixel := fSamplesPerPixel;
          PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( PageControl1.ActivePageIndex + 1 ) + ' ' + IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels ' + IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit';
          ListItem := ListViewFrames.Items.Add;
          ListItem.Caption := IntToStr ( PageControl1.ActivePageIndex + 1 );
          ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels' );
          ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit' );
          ImageENView.Bitmap.Modified := True;
        end;
      finally; frmImport.Free; end;
    finally Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.SetAlphaClick ( Sender: TObject );
var
  RGB: TRGB;
  BitCount: integer;
begin
  if PageControl1.ActivePage <> nil then
  begin
    Screen.Cursor := crHourglass;
    try
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      BitCount := ImageENView.IO.Params.ICO_BitCount [ 0 ];
      if BitCount <> 32 then
      begin
        with ImageENView.Proc do
        begin
          SaveUndo;
          ClearAllRedo;
        end;
        ImageENView.IO.Params.ICO_BitCount [ 0 ] := 32;
        ImageENView.IO.Params.BitsPerSample := 8;
        ImageENView.IO.Params.SamplesPerPixel := 4;
        ImageENView.Update;
      end;
      UpDownAlpha.Position := 0;
      if ColorDialog1.Execute then
      begin
        BackColor.Brush.Color := ColorDialog1.Color;
        RGB := TColor2TRGB ( BackColor.Brush.Color );
        with ImageENView.Proc do
        begin
          SaveUndo;
          ClearAllRedo;
          SetTransparentColors ( rgb, rgb, UpDownAlpha.Position );
        end;
        ImageEnView.Update;
      end;
      ImageENView.Bitmap.Modified := True;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      UpdateMenu;
    finally; Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.MakeXPIcon1Click ( Sender: TObject );
var
  RGB: TRGB;
  BX, BY: integer;
  ListItem: TListItem;
begin
  if PageControl1.ActivePage <> nil then
  begin
    Screen.Cursor := crHourglass;
    try
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      with ImageENView.Proc do
      begin
        SaveUndo;
        ClearAllRedo;
        ImageENView.IO.Params.ICO_BitCount [ ListViewFrames.ItemIndex ] := 32;
        ImageENView.IO.Params.BitsPerSample := 8;
        ImageENView.IO.Params.SamplesPerPixel := 4;
        ImageENView.Update;
      end;
      with ImageENView.Proc do
      begin
        SaveUndo;
        ClearAllRedo;
        BX := 0;
        BY := ImageENView.IEBitmap.Height - 1;
        RGB := ImageENView.IEBitmap.Pixels [ BX, BY ];
        SetTransparentColors ( RGB, RGB, 0 );
        BackColor.Brush.Color := TRGB2TColor ( RGB );
        ImageEnView.Update;
        ImageENView.Bitmap.Modified := True;
      end;
      if ListViewFrames.ItemIndex <> -1 then
      begin
        ListItem := ListViewFrames.Items.Item [ ListViewFrames.ItemIndex ];
        ListItem.Caption := IntToStr ( ListViewFrames.ItemIndex + 1 );
        ListItem.SubItems.Strings [ 0 ] := IntToStr ( ImageENView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageENView.IEBitmap.Height ) + ' pixels';
        ListItem.SubItems.Strings [ 1 ] := ( IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit' );
      end;
      if PageControl1.ActivePageIndex <> -1 then
        PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( PageControl1.ActivePageIndex + 1 ) + ' ' + IntToStr ( ImageENView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageENView.IEBitmap.Height ) + ' pixels' + ' ' + IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit';
      CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
    finally; Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.CheckBoxEnableAlphaClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.EnableAlphaChannel := CheckBoxEnableAlpha.Checked;
    Preview.EnableAlphaChannel := CheckBoxEnableAlpha.Checked;
    ImageEnView.Update;
  end;
end;

procedure TMainForm.FillAdjacentForegroundClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    with ImageENView.Proc do
    begin
      SaveUndo;
      ClearAllRedo;
    end;
    if FillAdjacentForeground.Down then
    begin
      SelectNone1.Click;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      UpdateMenu;
      ImageENView.Cursor := 1799;
    end
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.UpDownAlphaClick ( Sender: TObject; Button: TUDBtnType );
var
  o: single;
  Opacity: integer;
begin
  o := ( UpDownAlpha.Position / 255 ) * 100;
  Opacity := Trunc ( o );
  UpDownOpacity.Position := Opacity;
end;

procedure TMainForm.TrackBar1Change ( Sender: TObject );
begin
  UpDownAlpha.Increment := TrackBar1.Position;
  TrackBar1.Hint := 'Increment: ' + FloatToStrF ( TrackBar1.Position, ffFixed, 10, 1 );
  Application.ActivateHint ( Mouse.CursorPos );
end;

procedure TMainForm.PickAlphaClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    if PickAlpha.Down then
      ImageENView.Cursor := 1798
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PickColorClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    if PickColor.Down then
      ImageENView.Cursor := 1798
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.Export1Click ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    Moving := False;
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SaveImageEnDialog1.FileName := '';
    SaveImageEnDialog1.Title := 'Export image...';
    if SaveImageEnDialog1.Execute then
    begin
      Screen.Cursor := crHourglass;
      try
        ImageENView.IO.SaveToFile ( SaveImageEnDialog1.FileName );
      finally Screen.Cursor := crDefault; end;
    end;
  end;
end;

procedure TMainForm.AddSoftShadow1Click ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    Screen.Cursor := crHourglass;
    try
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      with ImageENView.Proc do
      begin
        SaveUndo;
        ClearAllRedo;
        AddSoftShadow ( 3, 2, 2, false, clBlack );
      end;
      ImageENView.Bitmap.Modified := True;
      StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      UpdateMenu;
    finally Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.AddInsideShadow1Click ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    Screen.Cursor := crHourglass;
    try
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      with ImageENView.Proc do
      begin
        SaveUndo;
        ClearAllRedo;
        AddInnerShadow ( 3, 2, 2 );
      end;
      ImageENView.Bitmap.Modified := True;
      StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      UpdateMenu;
    finally Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.FillAdjacentBackgroundClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    with ImageENView.Proc do
    begin
      SaveUndo;
      ClearAllRedo;
    end;
    if FillAdjacentBackground.Down then
    begin
      SelectNone1.Click;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      UpdateMenu;
      ImageENView.Cursor := 1799;
    end
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.MarkOuter2Click ( Sender: TObject );
begin
  MarkOuter1.Checked := MarkOuter1.Checked;
end;

procedure ExchangeItems ( LV: TListView; const i, j: Integer );
var
  TempLI: TListItem;
begin
  LV.Items.BeginUpdate;
  try
    TempLI := TListItem.Create ( LV.Items );
    TempLI.Assign ( LV.Items.Item [ i ] );
    LV.Items.Item [ i ].Assign ( LV.Items.Item [ j ] );
    LV.Items.Item [ j ].Assign ( TempLI );
    TempLI.Free;
  finally
    LV.Items.EndUpdate
  end;
end;

procedure TMainForm.Up1Click ( Sender: TObject );
var
  ListItem: TListItem;
  i: integer;
  IconName: string;
  IconSize: string;
  IconBitdepth: string;
begin
  Moving := True;
  ListItem := ListViewFrames.Selected;
  if ListItem.Index <> 0 then
  begin
    ExchangeItems ( ListViewFrames, ListViewFrames.ItemIndex, ListItem.Index - 1 );
    ListViewFrames.ItemIndex := ListViewFrames.ItemIndex - 1;
    Tabsheet := PageControl1.ActivePage;
    PageControl1.ActivePage.PageIndex := PageControl1.ActivePage.PageIndex - 1;
  end;
  for i := 0 to ListViewFrames.Items.Count - 1 do
  begin
    ListItem := ListViewFrames.Items.Item [ i ];
    ListItem.Caption := IntToStr ( i + 1 );
    PageControl1.Pages [ i ] .PageIndex := i;
    IconName := 'Icon ' + IntToStr ( i + 1 ) + ' ';
    IconSize := ListItem.SubItems.Strings [ 0 ] + ' ';
    IconBitdepth := ListItem.SubItems.Strings [ 1 ];
    PageControl1.Pages [ i ].Caption := IconName +  Iconsize + IconBitdepth;
  end;
  Moving := False;
  Down1.Enabled := ListViewFrames.Selected.Index < ListViewFrames.Items.Count-1;
  Up1.Enabled := ListViewFrames.Selected.Index > 0;
end;

procedure TMainForm.Down1Click ( Sender: TObject );
var
  ListItem: TListItem;
  i: integer;
  IconName: string;
  IconSize: string;
  IconBitdepth: string;
begin
  Moving := True;
  ListItem := ListViewFrames.Selected;
  if ListItem.Index <> ListViewFrames.Items.Count - 1 then
  begin
    ExchangeItems ( ListViewFrames, ListViewFrames.ItemIndex, ListItem.Index + 1 );
    ListViewFrames.ItemIndex := ListViewFrames.ItemIndex + 1;
    Tabsheet := PageControl1.ActivePage;
    PageControl1.ActivePage.PageIndex := PageControl1.ActivePage.PageIndex + 1;
  end;
  for i := 0 to ListViewFrames.Items.Count - 1 do
  begin
    ListItem := ListViewFrames.Items.Item [ i ];
    ListItem.Caption := IntToStr ( i + 1 );
    PageControl1.Pages [ i ] .PageIndex := i;
    IconName := 'Icon ' + IntToStr ( i + 1 ) + ' ';
    IconSize := ListItem.SubItems.Strings [ 0 ] + ' ';
    IconBitdepth := ListItem.SubItems.Strings [ 1 ];
    PageControl1.Pages [ i ].Caption := IconName +  Iconsize + IconBitdepth;
  end;
  Moving := False;
  Down1.Enabled := ListViewFrames.Selected.Index < ListViewFrames.Items.Count-1;
  Up1.Enabled := ListViewFrames.Selected.Index > 0;
end;

procedure TMainForm.PageControl1MouseDown ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
  PageControl1.BeginDrag ( False );
  Moving := False;
end;

procedure TMainForm.PageControl1DragDrop ( Sender, Source: TObject; X,
  Y: Integer );
const
  TCM_GETITEMRECT = $130A;
var
  i: Integer;
  r: TRect;
begin
  if not ( Sender is TPageControl ) then
    Exit;
  with PageControl1 do
  begin
    for i := 0 to PageCount - 1 do
    begin
      Perform ( TCM_GETITEMRECT, i, lParam ( @r ) );
      if PtInRect ( r, Point ( X, Y ) ) then
      begin
        if i <> ActivePage.PageIndex then
          ActivePage.PageIndex := i;
        Exit;
      end;
    end;
  end;
end;

procedure TMainForm.PageControl1DragOver ( Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean );
begin
  if Sender is TPageControl then
    Accept := True;
end;

procedure TMainForm.ListViewFramesClick ( Sender: TObject );
begin
  Moving := False;
  if PageControl1.ActivePageIndex <> ListViewFrames.Selected.Index then
    PageControl1.ActivePageIndex := ListViewFrames.Selected.Index;
  ImageENView.Fit;
end;

procedure TMainForm.Fit1Click ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    if Fit1.Down then
    begin
      ImageENView.AutoFit := True;
      ImageENView.Fit;
      TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
      TrackBarZoom.Hint := 'Zoom: ' + FloatToStrF ( ImageEnView.Zoom, ffFixed, 10, 1 ) + '%';
    end
    else
    begin
      ImageENView.AutoFit := False;
      ImageENView.Zoom := 100;
      TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
      TrackBarZoom.Hint := 'Zoom: ' + FloatToStrF ( ImageEnView.Zoom, ffFixed, 10, 1 ) + '%';
    end;
  end;
end;

procedure TMainForm.Extent1Click ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    if Extent1.Down then
    begin
      ImageENView.AutoFit := False;
      ImageENView.Zoom := 100;
      TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
      TrackBarZoom.Hint := 'Zoom: ' + FloatToStrF ( ImageEnView.Zoom, ffFixed, 10, 1 ) + '%';
    end
    else
    begin
      TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
      TrackBarZoom.Hint := 'Zoom: ' + FloatToStrF ( ImageEnView.Zoom, ffFixed, 10, 1 ) + '%';
      ImageENView.Fit;
    end;
  end;
end;

procedure TMainForm.GrayScale1Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    with ImageENView.Proc do
    begin
      SaveUndo;
      ClearAllRedo;
    end;
    ImageENView.Proc.ConvertToGray;
    Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
    Preview.Update;
    UpdateMenu;
  finally Screen.Cursor := crDefault; end;
end;

procedure TMainForm.Negative1Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    with ImageENView.Proc do
    begin
      SaveUndo;
      ClearAllRedo;
    end;
    ImageENView.Proc.Negative;
    Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
    Preview.Update;
    UpdateMenu;
  finally Screen.Cursor := crDefault; end;
end;

procedure TMainForm.Select1Click ( Sender: TObject );
begin
  PaintPoint.Down := False;
  PaintLine.Down := False;
  PaintRect.Down := False;
  PaintRoundRect.Down := False;
  PaintEllipse.Down := False;
  PaintFilledRect.Down := False;
  PaintFilledRoundRect.Down := False;
  PaintFilledEllipse.Down := False;
  FillAdjacentForeground.Down := False;
  FillAdjacentBackground.Down := False;
end;

procedure TMainForm.PaintPointClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintPoint.Down then
      ImageENView.Cursor := 1797
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PaintLineClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintLine.Down then
      ImageENView.Cursor := 1797
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PaintRectClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintRect.Down then
      ImageENView.Cursor := 1808
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PaintRoundRectClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintRoundRect.Down then
      ImageENView.Cursor := 1808
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PaintEllipseClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintEllipse.Down then
      ImageENView.Cursor := 1808
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PaintFilledRectClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintFilledRect.Down then
      ImageENView.Cursor := 1808
    else
      ImageENView.Cursor := 1784;
    SelectNone1.Checked := True;
  end;
end;

procedure TMainForm.PaintFilledRoundRectClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintFilledRoundRect.Down then
      ImageENView.Cursor := 1808
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PaintFilledEllipseClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    SelectNone1.Click;
    if PaintFilledEllipse.Down then
      ImageENView.Cursor := 1808
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.PaintAlphaClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    if PaintAlpha.Down then
      ImageENView.Cursor := 1797
    else
    begin
      PaintAlpha.Down := False;
      ImageENView.Cursor := 1784;
    end;
  end;
end;

procedure TMainForm.UpDownPenWidthClick ( Sender: TObject;
  Button: TUDBtnType );
begin
  with ImageEnView do
  begin
    IEBitmap.Canvas.Pen.Width := UpDownPenWidth.Position;
    IEBitmap.AlphaChannel.Canvas.Pen.Width := UpDownPenWidth.Position;
  end;
end;

procedure TMainForm.UpDownOpacityChanging ( Sender: TObject;
  var AllowChange: Boolean );
var
  Alpha1: integer;
  Opacity1: integer;
begin
  OpacityChanging := True;
  if not AlphaChanging then
  begin
    // convert opacity value to alpha value
    Opacity1 := Trunc ( UpDownOpacity.Position );
    Alpha1 := Trunc ( ( Opacity1 * 255 ) / 100 );
    UpDownAlpha.Position := Alpha1;
  end;
  OpacityChanging := False;
end;

procedure TMainForm.SelectNoneExecute ( Sender: TObject );
begin
  // select none
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.MouseInteract := [ ];
    ImageENView.Cursor := 1785;
    ImageENView.DeSelect;
  end;
end;

procedure TMainForm.SelectRectExecute ( Sender: TObject );
begin
  // select rect
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.MouseInteract := [ miSelect ];
    ImageENView.Cursor := 1808;
  end;
end;

procedure TMainForm.SelectEllipseExecute ( Sender: TObject );
begin
  // select circle
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.MouseInteract := [ miSelectCircle ];
    ImageENView.Cursor := 1808;
  end;
end;

procedure TMainForm.SelectZoomExecute ( Sender: TObject );
begin
  // select zoom
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.MouseInteract := [ miZoom ];
    ImageENView.Cursor := 1779;
  end;
end;

procedure TMainForm.SelectMagicwandExecute ( Sender: TObject );
begin
  // select magic wand
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    case frmSelectionProperties.cbMagicWandMode.ItemIndex of
      0: ImageENView.MagicWandMode := iewInclusive;
      1: ImageENView.MagicWandMode := iewExclusive;
      2: ImageENView.MagicWandMode := iewGlobal;
    end; //case
    ImageENView.MouseInteract := [ miSelectMagicWand ];
    ImageENView.Cursor := 1802;
  end;
end;

procedure TMainForm.SelectPolygonExecute ( Sender: TObject );
begin
  // select polygon
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.MouseInteract := [ miSelectPolygon ];
    ImageENView.Cursor := 1804;
  end;
end;

procedure TMainForm.SelectLassoExecute ( Sender: TObject );
begin
  // Select Lasso
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.MouseInteract := [ miSelectLasso ];
    ImageENView.Cursor := 1785;
  end;
end;

procedure TMainForm.SelectIconExecute ( Sender: TObject );
var
  x, y, x2, y2: integer;
begin
  if PageControl1.ActivePage <> nil then
  begin
    Screen.Cursor := crHourglass;
    try
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      ImageENView.Cursor := 1784;
      ImageENView.SelectCustom;
      x := 0;
      y := 0;
      x2 := x + 32;
      y2 := y + 32;
      ImageENView.Select ( x, y, x2, y2 );
      ImageENView.MouseInteract := [ miSelect ];
    finally; Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.FileNewExecute ( Sender: TObject );
var
  fIconWidth: integer;
  fIconHeight: integer;
  fBitCount: integer;
  fBitsPerSample: integer;
  fSamplesPerPixel: integer;
  ListItem: TListItem;
  RGB: TRGB;
  BX, BY: integer;
begin
  Screen.Cursor := crHourglass;
  try
    Moving := False;
    frmImport := TfrmImport.Create ( Self );
    try
      if frmImport.ShowModal = mrOk then
      begin
        AddTabsheet;
        ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
        fIconWidth := frmImport.fIconWidth;
        fIconHeight := frmImport.fIconHeight;
        fBitCount := frmImport.fBitCount;
        fBitsPerSample := frmImport.fBitsPerSample;
        fSamplesPerPixel := frmImport.fSamplesPerPixel;
        ImageEnView.Proc.ImageResize ( fIconWidth, fIconHeight, iehLeft, ievTop );
        ImageEnView.Clear;
        BX := 0;
        BY := ImageENView.IEBitmap.Height - 1;
        RGB := ImageENView.IEBitmap.Pixels [ BX, BY ];
        ImageENView.Proc.SetTransparentColors ( RGB, RGB, 0 );
        BackColor.Brush.Color := TRGB2TColor ( RGB );
        ImageEnView.Update;
        ImageENView.IO.Params.Width := fIconWidth;
        ImageENView.IO.Params.Height := fIconHeight;
        ImageENView.IO.Params.ICO_BitCount [ PageControl1.ActivePageIndex ] := fBitCount;
        ImageENView.IO.Params.BitsPerSample := fBitsPerSample;
        ImageENView.IO.Params.SamplesPerPixel := fSamplesPerPixel;
        PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( PageControl1.ActivePageIndex + 1 ) + ' ' + IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels ' + IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit';
        ListItem := ListViewFrames.Items.Add;
        ListItem.Caption := IntToStr ( PageControl1.ActivePageIndex + 1 );
        ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels' );
        ListItem.SubItems.Add ( IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit' );
        ImageENView.Bitmap.Modified := False;
        FilePath := ExtractFilePath ( Application.ExeName ) + '\' + 'New Icon.ico';
        StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( Application.ExeName );
        StatusBar1.Panels [ 1 ].Text := 'New Icon.ico';
        StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
        StatusBar1.Panels [ 5 ].Text := IntToStr ( ImageEnView.IO.Params.SamplesPerPixel * ImageEnView.IO.Params.BitsPerSample ) + ' bit';
        ImageEnView.IO.Params.ICO_Background := TColor2TRGB ( BackColor.Brush.Color );
        CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
        TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
        ImageENView.Fit;
        Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
        Preview.Update;
        ProgressBar1.Position := 0;
        PageControl1.Visible := True;
        UpdateMenu;
        Loading := False;
      end;
    finally; frmImport.Free; end;
  finally Screen.Cursor := crDefault; end;
end;

procedure TMainForm.FileOpenBeforeExecute ( Sender: TObject );
var
  Frames: integer;
  ListItem: TListItem;
  i: integer;
begin
  OpenImageEnDialog1.Title := 'Open Icon...';
  OpenImageEnDialog1.AutoSetFilter := False;
  OpenImageEnDialog1.Filter := 'Windows Icon (ICO)|*.ico';
  if OpenImageEnDialog1.Execute then
  begin
    Screen.Cursor := crHourglass;
    try
      PageControl1.Visible := False;
    // close all pages
      if PageControl1.PageCount > 0 then
        for i := PageControl1.PageCount - 1 downto 0 do
          PageControl1.Pages [ i ].Free;
      FilePath := OpenImageEnDialog1.FileName;
      Frames := IEGetFileFramesCount ( FilePath );
      ListViewFrames.Clear;
      Preview.Clear;
      ProgressBar1.Max := Frames;
      loading := true;
      for i := 0 to Frames - 1 do
      begin
        AddTabsheet;
        ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
        with ImageENView do
        begin
          Cursor := 1784;
          IO.Params.ICO_ImageIndex := i;
          IO.LoadFromFile ( FilePath );
          ListItem := ListViewFrames.Items.Add;
          ListItem.Caption := IntToStr ( i + 1 );
          ListItem.SubItems.Add ( IntToStr ( IEBitmap.Width ) + ' pixels x ' + IntToStr ( IEBitmap.Height ) + ' pixels' );
          ListItem.SubItems.Add ( IntToStr ( IO.Params.SamplesPerPixel * IO.Params.BitsPerSample ) + ' bit' );
          PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( i + 1 ) + ' ' + IntToStr ( IEBitmap.Width ) + ' pixels x ' + IntToStr ( IEBitmap.Height ) + ' pixels' + ' ' + IntToStr ( IO.Params.SamplesPerPixel * IO.Params.BitsPerSample ) + ' bit';
          ListItem.Selected := True;
          ListViewFrames.ItemIndex := i;
          ProgressBar1.Position := i;
          Bitmap.Modified := False;
        end;
      end;
      ImageEnView.Proc.ClearAllUndo;
      ImageEnView.Proc.ClearAllRedo;
      StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( FilePath );
      StatusBar1.Panels [ 1 ].Text := ExtractFileName ( FilePath );
      StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
      StatusBar1.Panels [ 5 ].Text := IntToStr ( ImageEnView.IO.Params.SamplesPerPixel * ImageEnView.IO.Params.BitsPerSample ) + ' bit';
      ImageEnView.IO.Params.ICO_Background := TColor2TRGB ( BackColor.Brush.Color );
      CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
      TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
      ImageENView.Fit;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      ProgressBar1.Position := 0;
      PageControl1.Visible := True;
      UpdateMenu;
      loading := false;
    finally; Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.FileSaveExecute ( Sender: TObject );
var
  i: integer;
  Frames: array of TObject;
begin
  if PageControl1.PageCount > 0 then
  begin
    Screen.Cursor := crHourglass;
    ProgressBar1.Max := PageControl1.PageCount - 1;
    try
      SetLength ( Frames, PageControl1.PageCount );
      for i := 0 to PageControl1.PageCount - 1 do
      begin
        ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
        Frames [ i ] := ImageENView;
        ImageENView.IO.Params.ICO_ImageIndex := i;
        ProgressBar1.Position := i;
        // saving is too fast... slow it down
        Sleep(100);
      end;
      IEWriteICOImages ( FilePath, Frames );
      ProgressBar1.Position := 0;
      UpdateMenu;
    finally Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.FileSaveAsBeforeExecute ( Sender: TObject );
var
  i: integer;
  Frames: array of TObject;
  FT: TIOFileType;
begin
  if PageControl1.PageCount > 0 then
  begin
    SaveImageEnDialog1.FileName := '';
    SaveImageEnDialog1.FilterIndex := 5;
    SaveImageEnDialog1.DefaultExt := '.bmp';
    if SaveImageEnDialog1.Execute then
    begin
      Screen.Cursor := crHourglass;
      try
        ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
        FT := ImageENView.IO.Params.FileType;
        if FT = 6 then // icon
        begin
          SetLength ( Frames, PageControl1.PageCount );
          ProgressBar1.Max := PageControl1.PageCount - 1;
          for i := PageControl1.PageCount - 1 downto 0 do
          begin
            ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
            Frames [ i ] := ImageENView;
            ImageENView.IO.Params.ICO_ImageIndex := i;
            ProgressBar1.Position := i;
          end;
          // save the icon
          IEWriteICOImages ( SaveImageEnDialog1.FileName, Frames );
          ImageENView.Bitmap.Modified := False;
          ProgressBar1.Position := 0;
          UpdateMenu;
        end
        else // not icon
        begin
          ImageENView.IO.DoPreviews ( );
          ImageENView.IO.SaveToFile ( SaveImageEnDialog1.FileName );
          ImageENView.Bitmap.Modified := False;
          ProgressBar1.Position := 0;
          UpdateMenu;
        end;
      finally Screen.Cursor := crDefault; end;
    end;
  end;
end;

procedure TMainForm.FileSaveAsExecute ( Sender: TObject );
var
  i: integer;
  Frames: array of TObject;
  FT: TIOFileType;
begin
  if PageControl1.PageCount > 0 then
  begin
    SaveImageEnDialog1.FileName := '';
    SaveImageEnDialog1.FilterIndex := 5;
    SaveImageEnDialog1.DefaultExt := '.bmp';
    if SaveImageEnDialog1.Execute then
    begin
      Screen.Cursor := crHourglass;
      try
        FilePath := SaveImageEnDialog1.FileName;
        ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
        FT := ImageENView.IO.Params.FileType;
        if FT = 6 then // icon
        begin
          SetLength ( Frames, PageControl1.PageCount );
          ProgressBar1.Max := PageControl1.PageCount - 1;
          for i := 0 to PageControl1.PageCount - 1 do
          begin
            ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
            Frames [ i ] := ImageENView;
            ImageENView.IO.Params.ICO_ImageIndex := i;
            ProgressBar1.Position := i;
            // saving is too fast... slow it down
            Sleep(100);
          end;
        // save the icon
          IEWriteICOImages ( FilePath, Frames );
          ImageENView.Bitmap.Modified := False;
          ProgressBar1.Position := 0;
          UpdateMenu;
        end
        else // not icon
        begin
          ImageENView.IO.PreviewsParams := [ ioppDefaultLockPreview ];
          ImageENView.IO.DoPreviews ( );
          ImageENView.IO.SaveToFile ( FilePath );
          ImageENView.Bitmap.Modified := False;
          ProgressBar1.Position := 0;
          UpdateMenu;
        end;
      finally Screen.Cursor := crDefault; end;
    end;
    StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( FilePath );
    StatusBar1.Panels [ 1 ].Text := ExtractFileName ( FilePath );
    StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
    StatusBar1.Panels [ 5 ].Text := IntToStr ( ImageEnView.IO.Params.SamplesPerPixel * ImageEnView.IO.Params.BitsPerSample ) + ' bit';
  end;
end;

procedure TMainForm.FileCloseExecute ( Sender: TObject );
var
  i: integer;
begin
  // close all pages
  if PageControl1.PageCount > 0 then
    for i := PageControl1.PageCount - 1 downto 0 do
      PageControl1.Pages [ i ].Free;
  ListViewFrames.Clear;
  ClearStatusbar;
  Preview.Blank;
  UpdateMenu;
end;

procedure TMainForm.EditCutExecute ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    // save undo file
    ImageENView.Proc.SaveUndo;
    ImageENView.Proc.ClearAllRedo;
    // cut selection to clipboard
    ImageENView.Proc.SelCutToClip;
    UpdateMenu;
  end;
end;

procedure TMainForm.EditCopyExecute ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    if ImageENView.VisibleSelection then
    // copy selection to clipboard
      ImageENView.Proc.SelCopyToClip
    else
      ImageENView.Proc.CopyToClipboard;
    UpdateMenu;
  end;
end;

procedure TMainForm.EditPasteExecute ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    if Clipboard.HasFormat ( CF_PICTURE ) then
    begin
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      ImageENView.Proc.SaveUndo;
      ImageENView.Proc.ClearAllRedo;
      // paste from clipboard
      ImageENView.Proc.PasteFromClipboard;
      ImageENView.Update;
      UpdateMenu;
    end
    else
      MessageDlg ( 'There is no image in the Clipboard.', mtInformation, [ mbOK ], 0 );
  end;
end;

procedure TMainForm.EditUndoExecute ( Sender: TObject );
begin
  ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
  with ImageEnView.Proc do
  begin
    SaveRedo; // save in Redo list
    Undo;
    ClearUndo;
  end;
  UpdateMenu;
  Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
  Preview.Update;
  if ImageENView.Proc.UndoCount = 0 then
    ImageENView.Bitmap.Modified := False;
end;

procedure TMainForm.EditRedoExecute ( Sender: TObject );
begin
  ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
  with ImageEnView.Proc do
  begin
    SaveUndo; // save in Undo List
    Redo;
    ClearRedo;
  end;
  UpdateMenu;
  Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
  Preview.Update;
end;

procedure TMainForm.EditCropExecute ( Sender: TObject );
begin
  ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
  with ImageENView.Proc do
  begin
    if ImageENView.Selected then
    begin
      SaveUndo;
      ClearAllRedo;
      CropSel;
      StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
      ImageENView.Bitmap.Modified := True;
      Update;
      UpdateMenu;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
    end
    else
      MessageDlg ( 'Please select an area of the image to crop.', mtInformation, [ mbOK ], 0 );
  end;
end;

procedure TMainForm.EditPasteIntoSelectionExecute ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    if Clipboard.HasFormat ( CF_PICTURE ) then
    begin
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      ImageENView.Proc.SaveUndo;
      ImageENView.Proc.ClearAllRedo;
      // paste from clipboard
      ImageENView.Proc.SelPasteFromClipStretch;
      ImageENView.Update;
      UpdateMenu;
    end
    else
      MessageDlg ( 'There is no image in the Clipboard.', mtInformation, [ mbOK ], 0 );
  end;
end;

procedure TMainForm.FileOpenExecute ( Sender: TObject );
var
  Frames: integer;
  ListItem: TListItem;
  i: integer;
begin
  OpenImageEnDialog1.Title := 'Open Icon...';
  OpenImageEnDialog1.AutoSetFilter := False;
  OpenImageEnDialog1.Filter := 'Windows Icon (ICO)|*.ico';
  if OpenImageEnDialog1.Execute then
  begin
    Screen.Cursor := crHourglass;
    try
      PageControl1.Visible := False;
      // close all pages
      if PageControl1.PageCount > 0 then
        for i := PageControl1.PageCount - 1 downto 0 do
          PageControl1.Pages [ i ].Free;
      FilePath := OpenImageEnDialog1.FileName;
      Frames := IEGetFileFramesCount ( FilePath );
      ListViewFrames.Clear;
      Preview.Clear;
      ProgressBar1.Max := Frames;
      loading := true;
      for i := 0 to Frames - 1 do
      begin
        AddTabsheet;
        ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
        with ImageENView do
        begin
          Cursor := 1784;
          IO.Params.ICO_ImageIndex := i;
          IO.LoadFromFile ( FilePath );
          ListItem := ListViewFrames.Items.Add;
          ListItem.Caption := IntToStr ( i + 1 );
          ListItem.SubItems.Add ( IntToStr ( IEBitmap.Width ) + ' pixels x ' + IntToStr ( IEBitmap.Height ) + ' pixels' );
          ListItem.SubItems.Add ( IntToStr ( IO.Params.SamplesPerPixel * IO.Params.BitsPerSample ) + ' bit' );
          PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( i + 1 ) + ' ' + IntToStr ( IEBitmap.Width ) + ' pixels x ' + IntToStr ( IEBitmap.Height ) + ' pixels' + ' ' + IntToStr ( IO.Params.SamplesPerPixel * IO.Params.BitsPerSample ) + ' bit';
          ListItem.Selected := True;
          ListViewFrames.ItemIndex := i;
          ProgressBar1.Position := i;
          Bitmap.Modified := False;
        end;
      end;
      ImageEnView.Proc.ClearAllUndo;
      ImageEnView.Proc.ClearAllRedo;
      StatusBar1.Panels [ 0 ].Text := ExtractFilePath ( FilePath );
      StatusBar1.Panels [ 1 ].Text := ExtractFileName ( FilePath );
      StatusBar1.Panels [ 4 ].Text := IntToStr ( ImageEnView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageEnView.IEBitmap.Height ) + ' pixels';
      StatusBar1.Panels [ 5 ].Text := IntToStr ( ImageEnView.IO.Params.SamplesPerPixel * ImageEnView.IO.Params.BitsPerSample ) + ' bit';
      ImageEnView.IO.Params.ICO_Background := TColor2TRGB ( BackColor.Brush.Color );
      CheckBoxEnableAlpha.Checked := ImageEnView.HasAlphaChannel;
      TrackBarZoom.Position := Trunc ( ImageEnView.Zoom );
      ImageENView.Fit;
      Preview.IEBitmap.Assign ( ImageEnView.IEBitmap );
      Preview.Update;
      ProgressBar1.Position := 0;
      PageControl1.Visible := True;
      UpdateMenu;
      ListViewFrames.ItemIndex := 0;
      PageControl1.ActivePageIndex := 0;
      loading := false;
      Fit1Click ( Sender );
    finally; Screen.Cursor := crDefault; end;
  end;
end;

procedure TMainForm.SelectMagicWandOptionsExecute ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    if frmSelectionProperties.Execute then
    begin
      ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
      ImageENView.SelectionIntensity := StrToInt ( frmSelectionProperties.SelectionIntensityEdit.Text );
      ImageENView.MagicWandTolerance := StrToInt ( frmSelectionProperties.MagicWandToleranceEdit.Text );
      case frmSelectionProperties.cbMagicWandMode.ItemIndex of
        0: ImageENView.MagicWandMode := iewInclusive;
        1: ImageENView.MagicWandMode := iewExclusive;
        2: ImageENView.MagicWandMode := iewGlobal;
      end; //case
    end;
  end;
end;

procedure TMainForm.SelectInvertSelectionExecute ( Sender: TObject );
begin
  if PageControl1.PageCount > 0 then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    ImageENView.InvertSelection;
  end;
end;

procedure TMainForm.PickAlphaColorClick ( Sender: TObject );
begin
  if PageControl1.ActivePage <> nil then
  begin
    ImageENView := TImageENView ( PageControl1.ActivePage.Controls [ 0 ] );
    if PickAlphaColor.Down then
      ImageENView.Cursor := 1798
    else
      ImageENView.Cursor := 1784;
  end;
end;

procedure TMainForm.ForeColorMouseDown ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
  ColorDialog1.Color := ForeColor.Brush.Color;
  if ColorDialog1.Execute then
    ForeColor.Brush.Color := ColorDialog1.Color;
end;

procedure TMainForm.BackColorMouseDown ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin
  ColorDialog1.Color := BackColor.Brush.Color;
  if ColorDialog1.Execute then
    BackColor.Brush.Color := ColorDialog1.Color;
end;

procedure TMainForm.Sort1Click ( Sender: TObject );
var
  i: integer;
  ListItem: TListItem;
begin
  if PageControl1.PageCount > 0 then
  begin
    PageControl1.ActivePageIndex := 0;
    for i := PageControl1.PageCount - 1 downto 0 do
    begin
      PageControl1.ActivePage.PageIndex := I;
      ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
      PageControl1.ActivePage.Caption := 'Icon ' + IntToStr ( PageControl1.ActivePageIndex + 1 ) + ' ' + IntToStr ( ImageENView.IO.Params.Width ) + ' pixels x ' + IntToStr ( ImageENView.IO.Params.Height ) + ' pixels ' + IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit';
      PageControl1.ActivePageIndex := 0;
    end;
      // sort the listview
    for i := 0 to ListViewFrames.Items.Count - 1 do
    begin
      ImageENView := TImageENView ( PageControl1.Pages [ i ].Controls [ 0 ] );
      ListItem := ListViewFrames.Items.Item [ I ];
      ListItem.Caption := IntToStr ( I + 1 );
      ListItem.SubItems.Strings [ 0 ] := IntToStr ( ImageENView.IEBitmap.Width ) + ' pixels x ' + IntToStr ( ImageENView.IEBitmap.Height ) + ' pixels';
      ListItem.SubItems.Strings [ 1 ] := ( IntToStr ( ImageENView.IO.Params.SamplesPerPixel * ImageENView.IO.Params.BitsPerSample ) + ' bit' );
    end;
  end;
end;

procedure TMainForm.ImageENViewProgress(Sender: TObject; per: Integer);
begin
  Progressbar1.Position := per;
end;

procedure TMainForm.AboutExecute(Sender: TObject);
begin
  frmAbout := TfrmAbout.Create ( Self );
  try
    frmAbout.ShowModal;
  finally; frmAbout.Free; end;
end;

function HtmlHelp(hwndCaller: THandle; pszFile: PChar; uCommand: cardinal;
dwData: longint): THandle; stdcall; external 'hhctrl.ocx' name 'HtmlHelpA';

procedure TMainForm.HelpExecute(Sender: TObject);
begin
  HtmlHelp ( GetDesktopWindow, 'plainiconeditor.chm', HH_DISPLAY_TOPIC, 0 );
end;

// fdv
procedure TMainForm.MyUndo(ie:TImageEnView);
var
  x1,y1,x2,y2:integer;
begin
  x1 := startX; y1 := startY; x2 := lastX; y2 := lastY;
  OrdCor ( x1, y1, x2, y2 );
  ie.Proc.UndoRect ( x1 - UpDownPenWidth.Position, y1 - UpDownPenWidth.Position, x2 + UpDownPenWidth.Position, y2 + UpDownPenWidth.Position );
end;

end.

