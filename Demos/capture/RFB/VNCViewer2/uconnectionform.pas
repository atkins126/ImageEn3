unit uconnectionform;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, hyieutils, ieview, imageenview;

type
  TConnectionForm = class(TForm)
    Viewer: TImageEnView;
    procedure ViewerVirtualKey(Sender: TObject; VirtualKey,
      KeyData: Cardinal; KeyDown: Boolean);
    procedure ViewerSpecialKey(Sender: TObject; CharCode: Word;
      Shift: TShiftState; var Handled: Boolean);
    procedure ViewerMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MouseDownUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    rfb:TIERFBClient;
    procedure OnRFBUpdate(Sender:TObject);
  end;

implementation

{$R *.dfm}

procedure TConnectionForm.FormShow(Sender: TObject);
begin
  Caption := rfb.ScreenName;
  Viewer.SetExternalBitmap(rfb.FrameBuffer);
  rfb.OnUpdate := OnRFBUpdate;
end;

procedure TConnectionForm.OnRFBUpdate(Sender:TObject);
begin
  Viewer.Update;
end;

procedure TConnectionForm.ViewerVirtualKey(Sender: TObject; VirtualKey,
  KeyData: Cardinal; KeyDown: Boolean);
begin
  rfb.SendKeyEvent(Virtualkey, KeyData, KeyDown);
end;

procedure TConnectionForm.ViewerSpecialKey(Sender: TObject; CharCode: Word;
  Shift: TShiftState; var Handled: Boolean);
begin
  Handled := true;
end;

procedure TConnectionForm.ViewerMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  rfb.SendPointerEvent(Viewer.XScr2Bmp(X), Viewer.YScr2Bmp(Y), ssLeft in Shift, ssMiddle in Shift, ssRight in Shift);
  Viewer.Update;
end;

procedure TConnectionForm.MouseDownUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  rfb.SendPointerEvent(Viewer.XScr2Bmp(X), Viewer.YScr2Bmp(Y), ssLeft in Shift, ssMiddle in Shift, ssRight in Shift);
end;


procedure TConnectionForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
