unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, ieview, imageenview, hyieutils,
  XPMan, Menus;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    SpeedButton1: TSpeedButton;
    VNCView: TImageEnView;
    Button1: TButton;
    XPManifest1: TXPManifest;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Saveframeas1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Panel2: TPanel;
    VNCNavi: TImageEnView;
    Label4: TLabel;
    Label5: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VNCViewVirtualKey(Sender: TObject; VirtualKey,
      KeyData: Cardinal; KeyDown: Boolean);
    procedure VNCViewSpecialKey(Sender: TObject; CharCode: Word;
      Shift: TShiftState; var Handled: Boolean);
    procedure VNCViewMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure VNCViewMouseDownUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Saveframeas1Click(Sender: TObject);
  private
    { Private declarations }
    RFB:TIERFBClient;
    procedure OnRFBUpdate(Sender:TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // setup navigator
  VNCView.SetNavigator(VNCNavi, [ienoMOUSEWHEELZOOM]);

  // setup VNC (RFB) bitmap and events (you can also allow TIERFBClient to create its own frame buffer)
  RFB := TIERFBClient.Create(VNCView.IEBitmap);
  RFB.OnUpdate := OnRFBUpdate;
end;

// RFB.Free also closes connection
procedure TMainForm.FormDestroy(Sender: TObject);
begin
  RFB.Free;
end;

// whenever the framebuffer is updated OnRFBUpdate is called, and the screen needs to refreshed
procedure TMainForm.OnRFBUpdate(Sender:TObject);
begin
  VNCView.Update;
end;

// Connect/Disconnect
procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
  begin
    try
      // setup connection with Address, Port and optional Password
      RFB.Connect(Edit1.Text, StrToIntDef(Edit2.Text, 5900), Edit3.Text);
    except
      on E:Exception do
      begin
        SpeedButton1.Down := false;
        ShowMessage(E.Message);
      end;
    end;
    SpeedButton1.Caption := 'Disconnect';
  end
  else
  begin
    RFB.Disconnect();
    SpeedButton1.Caption := 'Connect';
  end;
end;

// a very primitive and buggy keyboard sender. Some combinations could not work (ie CTRL-C, ALTR-?...)
procedure TMainForm.VNCViewVirtualKey(Sender: TObject; VirtualKey,
  KeyData: Cardinal; KeyDown: Boolean);
begin
  if RFB.Connected then
    RFB.SendKeyEvent(Virtualkey, KeyData, KeyDown);
end;

// we need to handle TABS and ARROWS
procedure TMainForm.VNCViewSpecialKey(Sender: TObject; CharCode: Word;
  Shift: TShiftState; var Handled: Boolean);
begin
  Handled := true;
end;

// mouse moved here: communicate the new coords to the server
procedure TMainForm.VNCViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if RFB.Connected then
  begin
    RFB.SendPointerEvent(VNCView.XScr2Bmp(X), VNCView.YScr2Bmp(Y), ssLeft in Shift, ssMiddle in Shift, ssRight in Shift);
    VNCView.Update;
  end;
end;

// mouse down/up: communicate the info to the server
procedure TMainForm.VNCViewMouseDownUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if RFB.Connected then
    RFB.SendPointerEvent(VNCView.XScr2Bmp(X), VNCView.YScr2Bmp(Y), ssLeft in Shift, ssMiddle in Shift, ssRight in Shift);
end;

// send CTRL-ALT-DEL
procedure TMainForm.Button1Click(Sender: TObject);
begin
  if RFB.Connected then
  begin
    RFB.SendKeyEvent(VK_CONTROL, 0, true);
    RFB.SendKeyEvent(VK_MENU, 0, true);
    RFB.SendKeyEvent(VK_DELETE, 0, true);
    RFB.SendKeyEvent(VK_DELETE, 0, false);
    RFB.SendKeyEvent(VK_MENU, 0, false);
    RFB.SendKeyEvent(VK_CONTROL, 0, false);
  end;
end;


// File | Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Save frame as...
// We have to suspend (not lock) the frame buffer updates.
procedure TMainForm.Saveframeas1Click(Sender: TObject);
begin
  RFB.Suspended := true;
  VNCView.IO.SaveToFile( VNCView.IO.ExecuteSaveDialog );
  RFB.Suspended := false;
end;

end.
