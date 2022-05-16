//------------------------------------------------------------------------------
  //  ImageEN Painter    : Version 1.0
  //  Copyright (c) 2007 : Adirondack Software & Graphics
  //  Created            : 05-25-2007
  //  Last Modification  : 05-25-2007
  //  Description        : Resize/Resample Unit
//------------------------------------------------------------------------------

unit uResize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ImageEnView, ImageEn, ImageEnIO, ImageEnProc,
  HYIEDefs, ExtCtrls, IEView, Buttons;

type
  TfrmResize = class ( TForm )
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ImageEnProc1: TImageEnProc;
    ImageEnIO1: TImageEnIO;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    ResetBtn: TButton;
    ImageEnView1: TImageEnView;
    PeviewButton: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    SpeedButtonLockPreview: TSpeedButton;
    LockPreview1: TCheckBox;
    OriginalWidth1: TLabel;
    OriginalHeight1: TLabel;
    NewHeight1: TLabel;
    NewWidth1: TLabel;
    EnableAlphChannel1: TCheckBox;
    Background1: TComboBox;
    Label4: TLabel;
    RadioGroup1: TRadioGroup;
    procedure FormActivate ( Sender: TObject );
    procedure Edit1Change ( Sender: TObject );
    procedure Edit2Change ( Sender: TObject );
    procedure ResetBtnClick ( Sender: TObject );
    procedure FormCreate ( Sender: TObject );
    procedure FormShow ( Sender: TObject );
    procedure ImageEnView1MouseDown ( Sender: TObject;Button: TMouseButton;
      Shift: TShiftState;X, Y: Integer );
    procedure PeviewButtonClick ( Sender: TObject );
    procedure LockPreview1Click(Sender: TObject);
    procedure SpeedButtonLockPreviewClick(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EnableAlphChannel1Click(Sender: TObject);
    procedure Background1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
    DontChange: Boolean;
    procedure Preview;
  public
    { Public declarations }
    OrgWidth, OrgHeight: Integer;
    Resize: Boolean;
    Resample: Boolean;
  end;

var
  frmResize: TfrmResize;

implementation

uses uMain;

{$R *.DFM}

procedure TfrmResize.FormCreate ( Sender: TObject );
begin
  ImageEnView1.MouseInteract := [ miZoom, miScroll ];
  ImageEnView1.Cursor := 1779;
  ImageEnView1.ScrollBars := ssBoth;
  ImageEnView1.ZoomFilter := rfNone;
  ImageEnView1.BackGround := clWhite;
  ImageEnIO1.AttachedImageEn := ImageEnView1;
  ImageEnProc1.AttachedImageEn := ImageEnView1;
  ImageEnProc1.AttachedBitmap := ImageEnView1.Bitmap;
  ImageEnView1.SetChessboardStyle( 6 );
end;

procedure TfrmResize.FormActivate ( Sender: TObject );
begin
  if Resample then
    Caption := 'Resample Image (With Stretching)'
  else
    Caption := 'Resize Canvas (With Cropping)';
  Edit1.Text := IntToStr ( OrgWidth );
  Edit2.Text := IntToStr ( OrgHeight );
  OriginalWidth1.Caption := 'Original Width: ' + IntToStr ( OrgWidth ) + ' pixels';
  OriginalHeight1.Caption := 'Original Height: ' + IntToStr ( OrgHeight ) + ' pixels';
  DontChange := false;
  ComboBox1.ItemIndex := 0;
  Edit1.SetFocus;
  Edit1.SelectAll;
  Edit2.SelectAll;
end;

procedure TfrmResize.EnableAlphChannel1Click(Sender: TObject);
begin
  ImageEnView1.EnableAlphaChannel := EnableAlphChannel1.Checked;
end;

procedure TfrmResize.Background1Change(Sender: TObject);
begin
  ImageEnView1.BackgroundStyle := TIEBackgroundStyle( Background1.ItemIndex );
end;

procedure TfrmResize.Edit1Change ( Sender: TObject );
begin
  if CheckBox1.Checked and not DontChange then
  begin
    DontChange := true;
    if CheckBox1.Checked then
      Edit2.Text := '-1';
    //Edit2.Text := IntToStr ( Round ( OrgHeight * StrToIntDef ( Edit1.Text, 0 ) / OrgWidth ) );
    DontChange := false;
  end;
end;

procedure TfrmResize.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ( Key = VK_RETURN ) and ( SpeedButtonLockPreview.Down )then
    Preview;
end;

procedure TfrmResize.Edit2Change ( Sender: TObject );
begin
  if CheckBox1.Checked and not DontChange then
  begin
    DontChange := true;
     if CheckBox1.Checked then
      Edit1.Text := '-1';
    //Edit1.Text := IntToStr ( Round ( OrgWidth * StrToIntDef ( Edit2.Text, 0 ) / OrgHeight ) );
    DontChange := false;
  end;
end;

procedure TfrmResize.Edit2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ( Key = VK_RETURN ) and ( SpeedButtonLockPreview.Down )then
    Preview;
end;

procedure TfrmResize.Preview;
var
  w, h: Integer;
begin
  if ImageEnProc1.AttachedBitmap <> nil then
  begin
      w := StrToIntDef ( Edit1.Text, 0 );
      h := StrToIntDef ( Edit2.Text, 0 );
        if Resize then
          ImageEnProc1.ImageResize ( w, h );
        if Resample then
          ImageEnProc1.Resample ( w, h, TResampleFilter ( ComboBox1.ItemIndex ) );
        ImageEnView1.Update;
        NewWidth1.Caption := 'New Width: ' + IntToStr( ImageEnProc1.AttachedBitmap.Width ) + ' pixels';
        NewHeight1.Caption := 'New Height: ' + IntToStr( ImageEnProc1.AttachedBitmap.Height ) + ' pixels';
      end;
end;

procedure TfrmResize.RadioGroup1Click(Sender: TObject);
begin
  OrgWidth := ImageEnView1.IEBitmap.Width;
  OrgHeight := ImageEnView1.IEBitmap.Height;
  Edit1.Text := IntToStr( OrgWidth );
  Edit2.Text := IntToStr( OrgHeight );
  case RadioGroup1.ItemIndex of
    0:
      begin
        Edit1.Text := '16';
        Edit2.Text := '16';
      end;
    1:
      begin
        Edit1.Text := '24';
        Edit2.Text := '24';
      end;
    2:
      begin
        Edit1.Text := '28';
        Edit2.Text := '28';
      end;
    3:
      begin
        Edit1.Text := '32';
        Edit2.Text := '32';
      end;
    4:
      begin
        Edit1.Text := '64';
        Edit2.Text := '64';
      end;
     5:
      begin
        Edit1.Text := '640';
        Edit2.Text := '480';
      end;
      6:
      begin
        Edit1.Text := '800';
        Edit2.Text := '600';
      end;
       7:
      begin
        Edit1.Text := '1024';
        Edit2.Text := '768';
      end;
  end; // case
  NewWidth1.Caption := 'New Width: ' + Edit1.Text + ' pixels';
  NewHeight1.Caption := 'New Height: ' + Edit2.Text + ' pixels';
  if SpeedButtonLockPreview.Down then
    Preview;
  ImageEnView1.Fit;
end;

procedure TfrmResize.ResetBtnClick ( Sender: TObject );
begin
  ImageEnView1.Assign ( FrmMain.ImageENView1 );
  Edit1.Text := IntToStr ( OrgWidth );
  Edit2.Text := IntToStr ( OrgHeight );
  DontChange := false;
  ComboBox1.ItemIndex := 0;
  OrgWidth := ImageENView1.Bitmap.Width;
  OrgHeight := ImageENView1.Bitmap.Height;
  Edit1.Text := IntToStr ( OrgWidth );
  Edit2.Text := IntToStr ( OrgHeight );
  OriginalWidth1.Caption := 'Original Width: ' + IntToStr ( OrgWidth ) + ' pixels';
  OriginalHeight1.Caption := 'Original Height: ' + IntToStr ( OrgHeight ) + ' pixels';
  NewWidth1.Caption := 'New Width:';
  NewHeight1.Caption := 'New Height:';
  Edit1.SetFocus;
end;

procedure TfrmResize.SpeedButtonLockPreviewClick(Sender: TObject);
begin
  PeviewButton.Enabled := not SpeedButtonLockPreview.Down;
end;

procedure TfrmResize.FormShow ( Sender: TObject );
begin
  // save undo file
  ImageEnProc1.SaveUndo;
end;

procedure TfrmResize.ImageEnView1MouseDown ( Sender: TObject;
  Button: TMouseButton;Shift: TShiftState;X, Y: Integer );
begin
  if ImageEnView1.MouseInteract = [ miZoom, miScroll ] then
    ImageEnView1.Cursor := 1779
  else
    ImageEnView1.Cursor := 1782;
end;

procedure TfrmResize.LockPreview1Click(Sender: TObject);
begin
  SpeedButtonLockPreview.Down := LockPreview1.Checked;
end;

procedure TfrmResize.PeviewButtonClick ( Sender: TObject );
begin
  Preview;
end;

end.

