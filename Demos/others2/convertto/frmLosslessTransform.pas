//------------------------------------------------------------------------------
//  ImageEN Convert To & Lossless Transform Demo: 1.0
//------------------------------------------------------------------------------

unit frmLosslessTransform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IEView, ImageENView, ImageEnIO, ExtCtrls;

type
  TLosslessTransform = class ( TForm )
    TransformationRadioGroup: TRadioGroup;
    Label4: TLabel;
    ImageEnView1: TImageEnView;
    Label5: TLabel;
    ImageEnView2: TImageEnView;
    Button1: TButton;
    Button2: TButton;
    PeviewButton: TButton;
    ViewRadioGroup: TRadioGroup;
    CopyMarkersRadioGroup: TRadioGroup;
    CheckBoxGrayScale: TCheckBox;
    ResetBtn: TButton;
    Memo1: TMemo;
    procedure ImageEnView1MouseDown ( Sender: TObject;Button: TMouseButton;
      Shift: TShiftState;X, Y: Integer );
    procedure ImageEnView2MouseDown ( Sender: TObject;Button: TMouseButton;
      Shift: TShiftState;X, Y: Integer );
    procedure ImageEnView1MouseMove ( Sender: TObject;Shift: TShiftState;X,
      Y: Integer );
    procedure ImageEnView2MouseMove ( Sender: TObject;Shift: TShiftState;X,
      Y: Integer );
    procedure ViewRadioGroupClick ( Sender: TObject );
    procedure PeviewButtonClick ( Sender: TObject );
    procedure FormActivate ( Sender: TObject );
    procedure ResetBtnClick ( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LosslessTransform: TLosslessTransform;

implementation

uses FileCtrl, FrmMain;

{$R *.dfm}

procedure TLosslessTransform.ImageEnView1MouseDown ( Sender: TObject;
  Button: TMouseButton;Shift: TShiftState;X, Y: Integer );
begin
  if ImageEnView1.MouseInteract = [miZoom, miScroll] then
    ImageEnView1.Cursor := 1779
  else
    ImageEnView1.Cursor := 1782;
end;

procedure TLosslessTransform.ImageEnView2MouseDown ( Sender: TObject;
  Button: TMouseButton;Shift: TShiftState;X, Y: Integer );
begin
  if ImageEnView2.MouseInteract = [miZoom, miScroll] then
    ImageEnView2.Cursor := 1779
  else
    ImageEnView2.Cursor := 1782;
end;

procedure TLosslessTransform.ImageEnView1MouseMove ( Sender: TObject;
  Shift: TShiftState;X, Y: Integer );
begin
  ImageEnView2.Zoom := ImageEnView1.Zoom;
  ImageEnView1.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
  ImageEnView2.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
end;

procedure TLosslessTransform.ImageEnView2MouseMove ( Sender: TObject;
  Shift: TShiftState;X, Y: Integer );
begin
  ImageEnView1.Zoom := ImageEnView2.Zoom;
  ImageEnView1.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView1.Zoom] ) + '%)';
  ImageEnView2.Hint := 'Zoom (' + Format ( '%-4.2f', [ImageEnView2.Zoom] ) + '%)';
end;

procedure TLosslessTransform.ViewRadioGroupClick ( Sender: TObject );
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

function ExtractName ( const Filename: string ): string;
var
  aExt: string;
  aPos: Integer;
begin
  aExt := ExtractFileExt ( Filename );
  Result := ExtractFileName ( Filename );
  if aExt <> '' then
  begin
    aPos := Pos ( aExt, Result );
    if aPos > 0 then
      Delete ( Result, aPos, Length ( aExt ) );
  end;
end;

procedure TLosslessTransform.PeviewButtonClick ( Sender: TObject );
var
  SourceFile: string;
  DestPath: string;
  DestFile: string;
  DestFilename: string;
  Ext: string;
  Transformation: TIEJpegTransform;
  GrayScale: boolean;
  CopyMarkers: TIEJpegCopyMarkers;
  CutRect: TRect;
  Result: boolean;
  Reply: word;
begin
  SourceFile := FormMain.fPathFilename;
  DestPath := ExtractFilePath ( FormMain.fPathFilename );
  Ext := ExtractFileExt ( FormMain.fPathFilename );
  DestFilename := ExtractName ( FormMain.fPathFilename );
  DestFile := DestPath + DestFilename + '_LosslessTransform' + Ext;

  if FileExists ( DestFile ) then
    Reply := MessageDlg ( DestFile + ' exists.'+ #10#13 +  'Replace the file?', mtConfirmation, [mbYes, mbNo, mbCancel], 0 );
  if Reply = mrYes then
  begin
    case TransformationRadioGroup.ItemIndex of
      0: Transformation := jtNone;
      1: Transformation := jtCut;
      2: Transformation := jtHorizFlip;
      3: Transformation := jtVertFlip;
      4: Transformation := jtTranspose;
      5: Transformation := jtTransverse;
      6: Transformation := jtRotate90;
      7: Transformation := jtRotate180;
      8: Transformation := jtRotate270;
    end; // case

    GrayScale := CheckBoxGrayScale.Checked;

    case CopyMarkersRadioGroup.ItemIndex of
      0: CopyMarkers := jcCopyNone;
      1: CopyMarkers := jcCopyComments;
      2: CopyMarkers := jcCopyAll;
    end; // case

    Result := JpegLosslessTransform ( SourceFile, DestFile, Transformation, GrayScale, CopyMarkers, CutRect );

    if Result then
    begin
      FormMain.fPathFilename := DestFile;
      ImageEnView2.IO.LoadFromFile ( DestFile );
      ImageEnView2.Update;
    end;

  end
  else
    if Reply = mrNo then
      MessageDlg ( 'Jpeg Lossless Transform Aborted', mtInformation, [mbOk], 0 )
    else
      if Reply = mrCancel then
        MessageDlg ( 'Jpeg Lossless Transform Canceled', mtInformation, [mbOk], 0 );
end;

procedure TLosslessTransform.FormActivate ( Sender: TObject );
begin
  ImageEnView2.Assign ( ImageEnView1 );
end;

procedure TLosslessTransform.ResetBtnClick ( Sender: TObject );
begin
  ImageEnView2.Assign ( ImageEnView1 );
end;

end.

