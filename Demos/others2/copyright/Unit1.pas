{ ------------------------------------------------------------------- }
{ Copyright Unit }
{ ImageEn by HiComponents }
{ ------------------------------------------------------------------- }

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, ShellCtrls, IEView,
  ImageENView, ImageEnProc, ImageEnIO, hyiedefs, hyieutils, IEOpenSaveDlg, XPMan,
  ievect;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button3: TButton;
    FontDialog: TFontDialog;
    ProgressBar: TProgressBar;
    StatusBar: TStatusBar;
    ColorDialogText: TColorDialog;
    ColorDialogShadow: TColorDialog;
    XPManifest1: TXPManifest;
    SaveImageEnDialog1: TSaveImageEnDialog;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    ShellListView1: TShellListView;
    GroupBox1: TGroupBox;
    CopyrightEdit: TLabeledEdit;
    CheckBoxAddFrame: TCheckBox;
    ButtonAddCopyright: TButton;
    CheckBoxCopyrightInMargin: TCheckBox;
    ShellTreeView1: TShellTreeView;
    Panel5: TPanel;
    Splitter1: TSplitter;
    ButtonSaveAs: TButton;
    Label1: TLabel;
    CheckBoxAddSoftShadow: TCheckBox;
    ColorBoxTextColor: TColorBox;
    CheckBoxUseObjects: TCheckBox;
    ImageEnVect: TImageEnVect;
    Splitter2: TSplitter;
    SelectRadioGroup: TRadioGroup;
    ButtonMerge: TButton;
    CheckBoxAntialiasText: TCheckBox;
    Panel7: TPanel;
    Panel8: TPanel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure ButtonAddCopyrightClick(Sender: TObject);
    procedure ButtonSaveAsClick(Sender: TObject);
    procedure ShellListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ImageEnVectProgress(Sender: TObject; per: Integer);
    procedure SelectRadioGroupClick(Sender: TObject);
    procedure ButtonMergeClick(Sender: TObject);
    procedure CheckBoxUseObjectsClick(Sender: TObject);
    procedure ImageEnVectVectorialChanged(Sender: TObject);
    procedure ImageEnVectImageChange(Sender: TObject);
    procedure ImageEnVectClick(Sender: TObject);
    procedure ImageEnVectZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnVectZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ColorBoxTextColorChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CheckBoxAddSoftShadowClick(Sender: TObject);
    procedure CopyrightEditChange(Sender: TObject);
  private
    { Private declarations }
    FFilePath: string;
    procedure UseObjects;
    procedure UseGDI;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses GifLZW, TIFLZW, INIFiles;

{$R *.dfm}

// FormCreate

procedure TForm1.FormCreate(Sender: TObject);
var
  MyIniFile: TIniFile;
begin
  MyIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    Left := MyIniFile.ReadInteger('Copyright Form', 'Left', 0);
    Top := MyIniFile.ReadInteger('Copyright Form', 'Top', 0);
    Width := MyIniFile.ReadInteger('Copyright Form', 'Width', 1032);
    Height := MyIniFile.ReadInteger('Copyright Form', 'Height', 746);
    WindowState := TWindowState(MyIniFile.ReadInteger('Copyright Form', 'Window State', 0));
    CopyrightEdit.Text := MyIniFile.ReadString('Copyright Form', 'Copyright', 'Copyright © 2004 William Miller, All Rights Reserved');
  finally MyIniFile.Free;
  end;
  // set ImageEn options
  DefGIF_LZWDECOMPFUNC := GIFLZWDecompress;
  DefGIF_LZWCOMPFUNC := GIFLZWCompress;
  DefTIFF_LZWDECOMPFUNC := TIFFLZWDecompress;
  DefTIFF_LZWCOMPFUNC := TIFFLZWCompress;
  ImageEnVect.SetChessboardStyle(6, bsSolid);
  // mouse wheel will scroll image of 15 % of component height
  ImageEnVect.MouseWheelParams.Action := iemwVScroll;
  ImageEnVect.MouseWheelParams.Variation := iemwPercentage;
  ImageEnVect.MouseWheelParams.Value := 15;
  // set scrollbar params to match wheel
  ImageEnVect.HScrollBarParams.LineStep := 15;
  ImageEnVect.VScrollBarParams.LineStep := 15;
  ImageEnVect.Blank;
end;

// FormDestroy

procedure TForm1.FormDestroy(Sender: TObject);
var
  MyIniFile: TIniFile;
begin
  MyIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    MyIniFile.WriteInteger('Copyright Form', 'Left', Left);
    MyIniFile.WriteInteger('Copyright Form', 'Top', Top);
    MyIniFile.WriteInteger('Copyright Form', 'Width', Width);
    MyIniFile.WriteInteger('Copyright Form', 'Height', Height);
    MyIniFile.WriteInteger('Copyright Form', 'Window State', Integer(TWindowState(WindowState)));
    MyIniFile.WriteString('Copyright Form', 'Copyright', CopyrightEdit.Text);
  finally MyIniFile.Free;
  end;
end;

// FormShow

procedure TForm1.FormShow(Sender: TObject);
begin
  ButtonAddCopyright.Enabled := not ImageEnVect.IsEmpty;
  ButtonMerge.Enabled := ImageEnVect.ObjectsCount > 0;
  ButtonSaveAs.Enabled := not ImageEnVect.IsEmpty;
  ActiveControl := ShellTreeView1;
end;

// FormActivate - show message

procedure TForm1.FormActivate(Sender: TObject);
begin
  ImageEnVect.MaxSelectionDistance := 32;
  ShowMessage('This demoinstrates how to add text and frames to an image using GDI or vectorial objects.' + #10#13 +
    'The demo optionally adds several frames (using FrameRect GDI) around the image and' + #10#13 +
    'optionally places copyright text in the margin of the image or on the image itself.' + #10#13 + #10#13 +
    '"Copyright text" added with oubects may also have shadowed text and may be antialiased.' + #10#13 +
    'If "Use Objects" is checked then the copyright is added using a vectotial text object.  The text' + #10#13 +
    'may be resized and placed anywhere on the image.  If you merge the text into the image' + #10#13 +
    'it may no longer be edited.');
end;

// FormKeyDown - trap ESC and DEL keys

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_ESCAPE then
  begin
    Close;
  end;
  if Key = vk_DELETE then
    while ImageENVect.SelObjectsCount > 0 do
      ImageENVect.RemoveObject(ImageENVect.SelObjects[0]);
end;

// Close

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;

// UseObjects

procedure TForm1.UseObjects;
var
  rc: TRect;
  ow, oh: integer;
begin
  Screen.Cursor := crHourglass;
  try
    ow := ImageEnVect.IEBitmap.Width;
    oh := ImageEnVect.IEBitmap.Height;
    StatusBar.Panels[2].Text := IntToStr(ImageEnVect.IEBitmap.Width) + ' x ' +
      IntToStr(ImageEnVect.IEBitmap.Height);
    StatusBar.Panels[1].Text := 'Drawing...';
    StatusBar.Update;
    if CheckBoxAddFrame.Checked then
    begin
      StatusBar.Panels[1].Text := 'Resizing the image...';
      StatusBar.Update;
      ImageEnVect.Proc.ImageResize(ImageEnVect.IEBitmap.Width + 160, ImageEnVect.IEBitmap.Height + 160, iehCenter, ievCenter);
      // draw a rect
      with ImageEnVect do
      begin
        // white rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clWhite;
        IEBitmap.Canvas.Brush.Color := clWhite;
        rc := Rect(80, 80, ow + 80, oh + 80);
        IEBitmap.Canvas.FrameRect(rc);
        // white rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clWhite;
        IEBitmap.Canvas.Brush.Color := clWhite;
        rc := Rect(79, 79, ow + 81, oh + 81);
        IEBitmap.Canvas.FrameRect(rc);
        // white rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clWhite;
        IEBitmap.Canvas.Brush.Color := clWhite;
        rc := Rect(78, 78, ow + 82, oh + 82);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(77, 77, ow + 83, oh + 83);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(76, 76, ow + 84, oh + 84);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(75, 75, ow + 85, oh + 85);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(74, 74, ow + 86, oh + 86);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(73, 73, ow + 87, oh + 87);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(72, 72, ow + 88, oh + 88);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(71, 71, ow + 89, oh + 89);
        IEBitmap.Canvas.FrameRect(rc);
        // black rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clBlack;
        IEBitmap.Canvas.Brush.Color := clBlack;
        rc := Rect(70, 70, ow + 90, oh + 90);
        IEBitmap.Canvas.FrameRect(rc);
        // white rect
        IEBitmap.Canvas.Pen.Width := 10;
        IEBitmap.Canvas.Pen.Color := clWhite;
        IEBitmap.Canvas.Brush.Color := clWhite;
        rc := Rect(69, 69, ow + 91, oh + 91);
        IEBitmap.Canvas.FrameRect(rc);
      end;
    end;
    ProgressBar.Visible := True;
    if ow > 2000 then
      ImageEnVect.Bitmap.Canvas.Font.Size := 48
    else
      ImageEnVect.Bitmap.Canvas.Font.Size := 14;
    StatusBar.Panels[1].Text := 'Adding Copyright...';
    StatusBar.Update;
    if CopyrightEdit.Text = '' then
      CopyrightEdit.Text := 'Copyright © 2004, William Miller';
    ImageEnVect.MouseInteractVt := ImageEnVect.MouseInteractVt + [miObjectSelect];
    ImageEnVect.UseCentralGrip := false;
    // set ObjKind to putText
    ImageEnVect.ObjKind[-1] := iekTEXT;
    SelectRadioGroup.ItemIndex := 2;
    if CheckBoxCopyrightInMargin.Checked then
    begin
      ImageEnVect.ObjLeft[-1] := 80;
      ImageEnVect.ObjHeight[-1] := 32;
      ImageEnVect.ObjWidth[-1] := ow - 160;
      ImageEnVect.ObjTop[-1] := ImageEnVect.IEBitmap.Height - 60;
      ImageEnVect.ObjTextAutoSize[-1] := True;
    end
    else
    begin
      ImageEnVect.ObjLeft[-1] := 110;
      ImageEnVect.ObjTop[-1] := 110;
      ImageEnVect.ObjWidth[-1] := ow - 160;
      ImageEnVect.ObjHeight[-1] := 60;
      ImageEnVect.ObjTextAutoSize[-1] := True;
    end;
    ImageEnVect.ObjText[-1] := CopyrightEdit.Text;
    StatusBar.Panels[1].Text := 'Setting up object...';
    StatusBar.Update;
    // set transparency
    ImageEnVect.ObjTransparency[-1] := 255;
    // set brush colors
    ImageEnVect.ObjPenColor[-1] := ColorBoxTextColor.Selected;
    ImageEnVect.ObjBrushColor[-1] := ColorBoxTextColor.Selected;
    ImageEnVect.ObjBrushStyle[-1] := bsClear;
    ImageEnVect.ObjPenStyle[-1] := psClear;
    StatusBar.Panels[1].Text := 'Setting up Text...';
    StatusBar.Update;
    FontDialog.Font.Name := 'Times New Roman';
    FontDialog.Font.Size := 0;
    FontDialog.Font.Color := ColorBoxTextColor.Selected;
    FontDialog.Font.Style := FontDialog.Font.Style + [fsItalic];
    ImageEnVect.SetObjFont(-1, FontDialog.Font);
    StatusBar.Panels[1].Text := 'Setting object font...';
    StatusBar.Update;
    // add a softshadow
    if CheckBoxAddSoftShadow.Checked then
    begin
      ImageEnVect.ObjGraphicRender := true;
      ImageEnVect.ObjSoftShadow[-1].Enabled := True;
    end;
    // set object witdh to width of bitmap
    ImageEnVect.ObjWidth[-1] := ImageEnVect.IEBitmap.Width - Length(ExtractFilename(FFilePath));
    StatusBar.Panels[1].Text := 'Adding New Object...';
    StatusBar.Update;
    ImageEnVect.AddNewObject;
    ProgressBar.Visible := False;
    ImageEnVect.Update;
    StatusBar.Panels[1].Text := '';
    StatusBar.Panels[2].Text := IntToStr(ImageEnVect.IEBitmap.Width) + ' x ' +
      IntToStr(ImageEnVect.IEBitmap.Height);
    StatusBar.Update;
    StatusBar.Panels[1].Text := '';
    StatusBar.Update;
  finally Screen.Cursor := crDefault;
  end;
end;

// UseGDI

procedure TForm1.UseGDI;
var
  rc: TRect;
  ow, oh: integer;
begin
  if (FileExists(FFilePath)) and (not ImageEnVect.IsEmpty) then
  begin
    Screen.Cursor := crHourglass;
    try
      ow := ImageEnVect.IEBitmap.Width;
      oh := ImageEnVect.IEBitmap.Height;
      StatusBar.Panels[2].Text := IntToStr(ImageEnVect.IEBitmap.Width) + ' x ' +
        IntToStr(ImageEnVect.IEBitmap.Height);
      StatusBar.Panels[1].Text := 'Drawing...';
      StatusBar.Update;
      if CheckBoxAddFrame.Checked then
      begin
        StatusBar.Panels[1].Text := 'Resizing the image...';
        StatusBar.Update;
        ImageEnVect.Proc.ImageResize(ImageEnVect.IEBitmap.Width + 160, ImageEnVect.IEBitmap.Height + 160, iehCenter, ievCenter);
        // draw a rect
        with ImageEnVect do
        begin
          // white rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clWhite;
          IEBitmap.Canvas.Brush.Color := clWhite;
          rc := Rect(80, 80, ow + 80, oh + 80);
          IEBitmap.Canvas.FrameRect(rc);
          // white rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clWhite;
          IEBitmap.Canvas.Brush.Color := clWhite;
          rc := Rect(79, 79, ow + 81, oh + 81);
          IEBitmap.Canvas.FrameRect(rc);
          // white rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clWhite;
          IEBitmap.Canvas.Brush.Color := clWhite;
          rc := Rect(78, 78, ow + 82, oh + 82);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(77, 77, ow + 83, oh + 83);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(76, 76, ow + 84, oh + 84);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(75, 75, ow + 85, oh + 85);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(74, 74, ow + 86, oh + 86);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(73, 73, ow + 87, oh + 87);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(72, 72, ow + 88, oh + 88);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(71, 71, ow + 89, oh + 89);
          IEBitmap.Canvas.FrameRect(rc);
          // black rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clBlack;
          IEBitmap.Canvas.Brush.Color := clBlack;
          rc := Rect(70, 70, ow + 90, oh + 90);
          IEBitmap.Canvas.FrameRect(rc);
          // white rect
          IEBitmap.Canvas.Pen.Width := 10;
          IEBitmap.Canvas.Pen.Color := clWhite;
          IEBitmap.Canvas.Brush.Color := clWhite;
          rc := Rect(69, 69, ow + 91, oh + 91);
          IEBitmap.Canvas.FrameRect(rc);
        end;
      end;
      StatusBar.Panels[1].Text := 'Adding Layer...';
      StatusBar.Update;
      ProgressBar.Visible := True;
      ImageEnVect.LayersAdd; // add a new layer
      ImageEnVect.Bitmap.Canvas.Pen.Color := ColorBoxTextColor.Selected;
      ImageEnVect.Bitmap.Canvas.Font.Name := 'Times New Roman';
      if ow > 2000 then
        ImageEnVect.Bitmap.Canvas.Font.Size := 48
      else
        ImageEnVect.Bitmap.Canvas.Font.Size := 24;
      StatusBar.Panels[1].Text := 'Adding Copyright...';
      StatusBar.Update;
      if CopyrightEdit.Text = '' then
        CopyrightEdit.Text := 'Copyright © 2004, William Miller';
      ImageEnVect.Bitmap.Canvas.Font.Color := ColorBoxTextColor.Selected;
      ImageEnVect.Bitmap.Canvas.Font.Style := FontDialog.Font.Style + [fsItalic, fsBold];
      if CheckBoxCopyrightInMargin.Checked then
        ImageEnVect.Bitmap.Canvas.TextOut(70, ImageEnVect.Bitmap.Height - 60, CopyrightEdit.Text)
      else
        ImageEnVect.Bitmap.Canvas.TextOut(100, 80, CopyrightEdit.Text);
      ImageEnVect.Proc.SetTransparentColors(CreateRGB(255, 255, 255), CreateRGB(255,
        255, 255), 0); // remove the white, making it as transparent
      StatusBar.Panels[1].Text := 'Merging Layer 2...';
      StatusBar.Update;
      ImageEnVect.LayersMerge(0, 1);
      ProgressBar.Visible := False;
      ImageEnVect.Update;
      StatusBar.Panels[1].Text := '';
      StatusBar.Panels[2].Text := IntToStr(ImageEnVect.IEBitmap.Width) + ' x ' +
        IntToStr(ImageEnVect.IEBitmap.Height);
      StatusBar.Update;
      StatusBar.Panels[1].Text := '';
      StatusBar.Update;
    finally Screen.Cursor := crDefault;
    end;
  end;
end;

// Add Copyright

procedure TForm1.ButtonAddCopyrightClick(Sender: TObject);
begin
  if (FileExists(FFilePath)) and (not ImageEnVect.IsEmpty) then
  begin
    if CheckBoxUseObjects.Checked then
      UseObjects
    else
      UseGDI;
    ButtonMerge.Enabled := ImageEnVect.ObjectsCount > 0;
    ButtonAddCopyright.Enabled := not ImageEnVect.IsEmpty;
    ButtonSaveAs.Enabled := not ImageEnVect.IsEmpty;
  end;
end;

// SaveAs

procedure TForm1.ButtonSaveAsClick(Sender: TObject);
var
  ex: string;
  save: boolean;
begin
  if SaveImageEnDialog1.Execute then
  begin
    // Get file type from image file
    ex := Lowercase(ExtractFileExt(SaveImageEnDialog1.FileName));
    with ImageENVect.IO do
    begin
      Save := False;
      if (ex = '.gif') then
        save := DoPreviews([ppGIF]);
      if (ex = '.jp2') or (ex = '.jp2000') then
        save := DoPreviews([ppJ2000]);
      if (ex = '.jpg') or (ex = '.jpeg') then
        save := DoPreviews([ppJPEG]);
      if (ex = '.tif') then
        save := DoPreviews([ppTIFF]);
      if (ex = '.bmp') then
        save := DoPreviews([ppBMP]);
      if (ex = '.gif') then
        save := DoPreviews([ppGIF]);
      if (ex = '.pcx') then
        save := DoPreviews([ppPCX]);
      if (ex = '.png') then
        save := DoPreviews([ppPNG]);
      if (ex = '.wmf') then
      begin
        MessageDlg('Can not save to WMF file format.', mtInformation, [mbOK],
          0);
        save := false;
      end;
      if (ex = '.emf') then
      begin
        MessageDlg('Can not save to EMF file format.', mtInformation, [mbOK],
          0);
        save := false;
      end;
      if (ex = '.ico') then
      begin
        MessageDlg('Can not save to Icon file format.', mtInformation, [mbOK],
          0);
        save := false;
      end;
      if (ex = '.cur') then
      begin
        MessageDlg('Can not save to Cursor file format.', mtInformation, [mbOK],
          0);
        save := False;
      end;
      if save then
      begin
        ImageEnVect.IO.SaveToFile(SaveImageEnDialog1.FileName);
        StatusBar.Panels[0].Text := ExtractFileName(SaveImageEnDialog1.FileName);
      end;
    end;
  end;
end;

// ShellListView1Change

procedure TForm1.ShellListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if ShellListView1.SelCount = 1 then
  begin
    ButtonAddCopyright.Enabled := not ImageEnVect.IsEmpty;
    ButtonSaveAs.Enabled := not ImageEnVect.IsEmpty;
    FFilePath := ShellListView1.SelectedFolder.PathName;
    Screen.Cursor := crHourglass;
    Caption := 'Add Copyright - ' + ExtractFilePath(FFilePath);
    StatusBar.Panels[0].Text := ExtractFileName(FFilePath);
    try
      if FileExists(FFilePath) then
      begin
        ProgressBar.Visible := True;
        ImageEnVect.IO.LoadFromFile(FFilePath);
        ImageEnVect.Fit;
        ButtonAddCopyright.Enabled := not ImageEnVect.IsEmpty;
        ButtonSaveAs.Enabled := not ImageEnVect.IsEmpty;
        StatusBar.Panels[2].Text := IntToStr(ImageEnVect.IEBitmap.Width) + ' x ' +
          IntToStr(ImageEnVect.IEBitmap.Height);
        ProgressBar.Visible := False;
      end;
    finally Screen.Cursor := crDefault;
    end;
  end;
end;

// ImageEnVectProgress

procedure TForm1.ImageEnVectProgress(Sender: TObject; per: Integer);
begin
  Progressbar.Position := per;
  if per > 99 then
    Progressbar.Position := 0;
end;

// SelectRadioGroupClick

procedure TForm1.SelectRadioGroupClick(Sender: TObject);
begin
  case SelectRadioGroup.Itemindex of
    0:
      begin // Zoom
        ImageEnVect.AutoFit := False;
        ImageEnVect.MouseInteract := [miZoom, miScroll];
        ImageEnVect.MouseInteractVt := [];
        ImageEnVect.Update;
        ImageEnVect.Cursor := 1779;
        SelectRadioGroup.Items[0] := 'Zoom (' + Format('%-4.2f', [ImageEnVect.Zoom]) + '%)';
      end;
    1:
      begin // AutoFit
        ImageEnVect.AutoFit := True;
        ImageEnVect.MouseInteract := [miScroll];
        ImageEnVect.MouseInteractVt := ImageEnVect.MouseInteractVt + [miObjectSelect];
        ImageEnVect.Update;
        ImageEnVect.Cursor := crDefault;
        SelectRadioGroup.Items[0] := 'Zoom (' + Format('%-4.2f', [ImageEnVect.Zoom]) + '%)';
      end;
    2:
      begin // SelectObject
        ImageEnVect.Cursor := 1782; // hand
        ImageEnVect.MouseInteractVt := ImageEnVect.MouseInteractVt + [miObjectSelect];
      end;
  end; // case
end;

// ButtonMergeClick- merge object

procedure TForm1.ButtonMergeClick(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  try
    ImageEnVect.CopyObjectsToBack(CheckBoxAntialiasText.Checked);
    ImageEnVect.RemoveObject(ImageEnVect.SelObjects[-1]);
  finally Screen.Cursor := crDefault;
  end;
end;

// CheckBoxUseObjectsClick

procedure TForm1.CheckBoxUseObjectsClick(Sender: TObject);
begin
  ButtonMerge.Enabled := CheckBoxUseObjects.Checked;
end;

// ImageEnVectVectorialChanged

procedure TForm1.ImageEnVectVectorialChanged(Sender: TObject);
begin
  ButtonMerge.Enabled := ImageEnVect.ObjectsCount > 0;
  ButtonAddCopyright.Enabled := not ImageEnVect.IsEmpty;
  ButtonSaveAs.Enabled := not ImageEnVect.IsEmpty;
end;

// ImageEnVectImageChange

procedure TForm1.ImageEnVectImageChange(Sender: TObject);
begin
  ButtonMerge.Enabled := ImageEnVect.ObjectsCount > 0;
  ButtonAddCopyright.Enabled := not ImageEnVect.IsEmpty;
  ButtonSaveAs.Enabled := not ImageEnVect.IsEmpty;
end;

// ImageEnVectClick

procedure TForm1.ImageEnVectClick(Sender: TObject);
begin
  ButtonMerge.Enabled := ImageEnVect.ObjectsCount > 0;
  ButtonAddCopyright.Enabled := not ImageEnVect.IsEmpty;
  ButtonSaveAs.Enabled := not ImageEnVect.IsEmpty;
end;

// ImageEnVectZoomIn

procedure TForm1.ImageEnVectZoomIn(Sender: TObject; var NewZoom: Double);
begin
  ImageEnVect.Cursor := 1779;
  SelectRadioGroup.Items[0] := 'Zoom (' + Format('%-4.2f', [ImageEnVect.Zoom]) + '%)';
end;

// ImageEnVectZoomOut

procedure TForm1.ImageEnVectZoomOut(Sender: TObject; var NewZoom: Double);
begin
  ImageEnVect.Cursor := 1778;
  SelectRadioGroup.Items[0] := 'Zoom (' + Format('%-4.2f', [ImageEnVect.Zoom]) + '%)';
end;

// ColorBoxTextColorChange

procedure TForm1.ColorBoxTextColorChange(Sender: TObject);
var
  q, obj: integer;
begin
  obj := -1; // -1 is next object (new object to insert)
  with ImageEnVect do
    for q := -1 to SelObjectsCount - 1 do
    begin
      if q >= 0 then
        obj := SelObjects[q];
      ObjText[obj] := CopyrightEdit.Text;
      SetObjFont(obj, FontDialog.Font);
      ObjPenColor[obj] := ColorBoxTextColor.Selected;
      ObjSoftShadow[obj].Enabled := CheckBoxAddSoftShadow.Checked;
      if CheckBoxAddSoftShadow.Checked and not ObjGraphicRender then
        ObjGraphicRender := true;
    end;
end;

// CheckBoxAddSoftShadowClick

procedure TForm1.CheckBoxAddSoftShadowClick(Sender: TObject);
var
  q, obj: integer;
begin
  obj := -1; // -1 is next object (new object to insert)
  with ImageEnVect do
    for q := -1 to SelObjectsCount - 1 do
    begin
      if q >= 0 then
        obj := SelObjects[q];
      ObjText[obj] := CopyrightEdit.Text;
      SetObjFont(obj, FontDialog.Font);
      ObjPenColor[obj] := ColorBoxTextColor.Selected;
      ObjSoftShadow[obj].Enabled := CheckBoxAddSoftShadow.Checked;
      if CheckBoxAddSoftShadow.Checked and not ObjGraphicRender then
        ObjGraphicRender := true;
    end;
end;

// CopyrightEditChange

procedure TForm1.CopyrightEditChange(Sender: TObject);
var
  q, obj: integer;
begin
  obj := -1; // -1 is next object (new object to insert)
  with ImageEnVect do
    for q := -1 to SelObjectsCount - 1 do
    begin
      if q >= 0 then
        obj := SelObjects[q];
      ObjText[obj] := CopyrightEdit.Text;
      SetObjFont(obj, FontDialog.Font);
      ObjPenColor[obj] := ColorBoxTextColor.Selected;
      ObjSoftShadow[obj].Enabled := CheckBoxAddSoftShadow.Checked;
      if CheckBoxAddSoftShadow.Checked and not ObjGraphicRender then
        ObjGraphicRender := true;
    end;
end;

end.
