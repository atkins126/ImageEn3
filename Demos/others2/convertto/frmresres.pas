//------------------------------------------------------------------------------
//  ImageEN Convert To  & Lossless Transform Demo: 1.0
//------------------------------------------------------------------------------

unit frmresres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ImageEnView, ImageEn, ImageEnIO, ImageEnProc, HYIEDefs, ExtCtrls,
  IEView, Buttons;

type
  TfResize = class ( TForm )
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    ResetBtn: TButton;
    ImageEnView1: TImageEnView;
    PeviewButton: TButton;
    SpeedButtonLockPreview: TSpeedButton;
    ImageEnView2: TImageEnView;
    Label4: TLabel;
    Label5: TLabel;
    ViewRadioGroup: TRadioGroup;
    procedure FormActivate ( Sender: TObject );
    procedure Edit1Change ( Sender: TObject );
    procedure Edit2Change ( Sender: TObject );
    procedure ResetBtnClick ( Sender: TObject );
    procedure FormCreate ( Sender: TObject );
    procedure FormShow ( Sender: TObject );
    procedure ImageEnView1MouseDown ( Sender: TObject;Button: TMouseButton;
      Shift: TShiftState;X, Y: Integer );
    procedure PeviewButtonClick ( Sender: TObject );
    procedure ImageEnView2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
    procedure ViewRadioGroupClick(Sender: TObject);
    procedure ImageEnView1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEnView2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageEnView1ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView1ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView2ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView2ZoomOut(Sender: TObject; var NewZoom: Double);
  private
    { Private declarations }
    DontChange: boolean;
    procedure Preview;
  public
    { Public declarations }
    OrgWidth, OrgHeight: integer;
    Resize: Boolean;
    Resample: Boolean;
  end;

var
  fResize: TfResize;

implementation

uses frmMain;

{$R *.DFM}

procedure TfResize.FormCreate ( Sender: TObject );
begin
  ImageEnView1.MouseInteract := [miZoom, miScroll];
  ImageEnView1.Cursor := 1779;
  ImageEnView1.Scrollbars := ssBoth;
  ImageEnView1.ZoomFilter := rfNone;
  ImageEnView1.BackgroundStyle := iebsChessboard;
  ImageEnView1.SetChessboardStyle ( 6, bsSolid );
  ImageEnView1.BackGround := clWhite;
  ImageEnView2.MouseInteract := [miZoom, miScroll];
  ImageEnView2.Cursor := 1779;
  ImageEnView2.Scrollbars := ssBoth;
  ImageEnView2.ZoomFilter := rfNone;
  ImageEnView2.BackgroundStyle := iebsChessboard;
  ImageEnView2.SetChessboardStyle ( 6, bsSolid );
  ImageEnView2.BackGround := clWhite;
end;

procedure TfResize.FormActivate ( Sender: TObject );
begin
  ImageEnView2.Assign(ImageEnView1);
  Edit1.Text := IntToStr ( OrgWidth );
  Edit2.Text := IntToStr ( OrgHeight );
  DontChange := False;
  ComboBox1.ItemIndex := 0;
  Edit1.SetFocus;
end;

procedure TfResize.Edit1Change ( Sender: TObject );
begin
  if CheckBox1.Checked and not DontChange then
  begin
    DontChange := True;
    Edit2.Text := IntToStr ( Round ( OrgHeight * StrToIntDef ( Edit1.Text, 0 ) / OrgWidth ) );
    DontChange := False;
  end;
end;

procedure TfResize.Edit2Change ( Sender: TObject );
begin
  if CheckBox1.Checked and not DontChange then
  begin
    DontChange := True;
    Edit1.Text := IntToStr ( Round ( OrgWidth * StrToIntDef ( Edit2.Text, 0 ) / OrgHeight ) );
    DontChange := False;
  end;
end;

procedure TfResize.Preview;
var
  w, h: integer;
begin
  if CheckBox1.Checked and not DontChange then
  begin
    DontChange := true;
    w := StrToIntDef ( Edit1.Text, 0 );
    h := StrToIntDef ( Edit2.Text, 0 );
    if ( w > 0 ) and ( h > 0 ) then
    begin
      if Resize then
        ImageEnView2.Proc.ImageResize ( w, h );
      if Resample then
        ImageEnView2.Proc.Resample ( w, h, TResampleFilter ( fResize.ComboBox1.ItemIndex ) );
      ImageEnView2.Update;
    end;
    DontChange := False;
  end
  else
  begin
    DontChange := true;
    w := StrToIntDef ( Edit1.Text, 0 );
    h := StrToIntDef ( Edit2.Text, 0 );
    if ( w > 0 ) and ( h > 0 ) then
    begin
      if Resize then
        ImageEnView2.Proc.ImageResize ( w, h );
      if Resample then
        ImageEnView2.Proc.Resample ( w, h, TResampleFilter ( fResize.ComboBox1.ItemIndex ) );
      ImageEnView2.Update;
    end;
    DontChange := False;
  end;
    // Show image dimensions
  FormMain.StatusBar1.Panels[1].Text := ' Height: ' + IntToStr ( ImageENView2.Bitmap.Height ) +
        ' pixels' + '  Width: ' + IntToStr ( ImageENView2.Bitmap.Width ) + ' pixels ';
end;

procedure TfResize.ResetBtnClick ( Sender: TObject );
begin
  ImageEnView1.Assign ( FormMain.ImageENView1.Bitmap );
  ImageEnView2.Blank;
  ImageEnView2.Assign(ImageEnView1);
  Edit1.Text := IntToStr ( OrgWidth );
  Edit2.Text := IntToStr ( OrgHeight );
  DontChange := False;
  ComboBox1.ItemIndex := 0;
  OrgWidth := ImageENView1.Bitmap.Width;
  OrgHeight := ImageENView1.Bitmap.Height;
  Edit1.Text := IntToStr ( OrgWidth );
  Edit2.Text := IntToStr ( OrgHeight );
  Edit1.SetFocus;
end;

procedure TfResize.FormShow ( Sender: TObject );
begin
  // save undo file
  ImageEnView2.Proc.SaveUndo;
end;

procedure TfResize.ImageEnView1MouseDown ( Sender: TObject;
  Button: TMouseButton;Shift: TShiftState;X, Y: Integer );
begin
  if ImageEnView1.MouseInteract = [miZoom, miScroll] then
    ImageEnView1.Cursor := 1779
  else
    ImageEnView1.Cursor := 1782;
end;

procedure TfResize.PeviewButtonClick ( Sender: TObject );
begin
  Preview;
end;

procedure TfResize.ImageEnView2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ImageEnView2.MouseInteract = [miZoom, miScroll] then
    ImageEnView2.Cursor := 1779
  else
    ImageEnView2.Cursor := 1782;
end;

procedure TfResize.UpDown1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if SpeedButtonLockPreview.Down then
    Preview;
end;

procedure TfResize.UpDown2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if SpeedButtonLockPreview.Down then
    Preview;
end;

procedure TfResize.ComboBox1Change(Sender: TObject);
begin
  UpDown1.SetFocus;
end;

procedure TfResize.ViewRadioGroupClick(Sender: TObject);
begin
  case ViewRadioGroup.Itemindex of
    0: begin // Zoom
        ImageEnView1.AutoFit := False;
        ImageEnView1.MouseInteract := [miZoom, miScroll];
        ImageEnView1.Update;
        ImageEnView1.Cursor := 1779;
        ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
        ImageEnView2.AutoFit := False;
        ImageEnView2.MouseInteract := [miZoom, miScroll];
        ImageEnView2.Update;
        ImageEnView2.Cursor := 1779;
        ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
      end;
    1: begin // AutoFit
        ImageEnView1.AutoFit := True;
        ImageEnView1.MouseInteract := [miScroll];
        ImageEnView1.Update;
        ImageEnView1.Cursor := crDefault;
        ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
        ImageEnView2.AutoFit := True;
        ImageEnView2.MouseInteract := [miScroll];
        ImageEnView2.Update;
        ImageEnView2.Cursor := crDefault;
        ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
      end;
  end; // case
end;

procedure TfResize.ImageEnView1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageEnView2.Zoom := ImageEnView1.Zoom;
  ImageEnView1.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
  ImageEnView2.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
end;

procedure TfResize.ImageEnView2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageEnView1.Zoom := ImageEnView2.Zoom;
  ImageEnView1.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
  ImageEnView2.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
end;

procedure TfResize.ImageEnView1ZoomIn(Sender: TObject;
  var NewZoom: Double);
begin
  ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
end;

procedure TfResize.ImageEnView1ZoomOut(Sender: TObject;
  var NewZoom: Double);
begin
  ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
end;

procedure TfResize.ImageEnView2ZoomIn(Sender: TObject;
  var NewZoom: Double);
begin
  ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
end;

procedure TfResize.ImageEnView2ZoomOut(Sender: TObject;
  var NewZoom: Double);
begin
  ViewRadioGroup.Items[0] := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
end;

end.

