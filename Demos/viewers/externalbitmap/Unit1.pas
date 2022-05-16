unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, ieview, imageenview, hyiedefs, XPMan,
  ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Navigator1: TImageEnView;
    ImageEnView1: TImageEnView;
    ImageEnView2: TImageEnView;
    ImageEnView3: TImageEnView;
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Splitter1: TSplitter;
    Splitter3: TSplitter;
    Panel8: TPanel;
    Splitter4: TSplitter;
    ImageEnView4: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    Open1: TMenuItem;
    Panel10: TPanel;
    Panel11: TPanel;
    Splitter6: TSplitter;
    MainView1: TImageEnView;
    Splitter2: TSplitter;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel9: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    XPManifest1: TXPManifest;
    cbZoomFilter1: TComboBox;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Panel17: TPanel;
    Panel18: TPanel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ImageEnView1ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView2ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView3ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView4ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure MainView1ZoomIn(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView1ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView2ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView3ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure ImageEnView4ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure MainView1ZoomOut(Sender: TObject; var NewZoom: Double);
    procedure cbZoomFilter1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Navigator1Progress(Sender: TObject; per: Integer);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure ImageEnView2Progress(Sender: TObject; per: Integer);
    procedure ImageEnView3Progress(Sender: TObject; per: Integer);
    procedure ImageEnView4Progress(Sender: TObject; per: Integer);
    procedure MainView1Progress(Sender: TObject; per: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  INIFiles;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  FIniFile: TIniFile;
begin
  FIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    // get & set form position & state
    Left := FIniFile.ReadInteger('Form', 'Left', 65);
    Top := FIniFile.ReadInteger('Form', 'Top', 10);
    Width := FIniFile.ReadInteger('Form', 'Width', 600);
    Height := FIniFile.ReadInteger('Form', 'Height', 460);
    WindowState := TWindowState(FIniFile.ReadInteger('Form', 'Window State', 0));
    Panel3.Width := FIniFile.ReadInteger('Panel 1', 'Width', 319);
    Panel3.Height := FIniFile.ReadInteger('Panel 1', 'Height', 189);
    Panel13.Width := FIniFile.ReadInteger('Panel 2', 'Width', 319);
    Panel13.Height := FIniFile.ReadInteger('Panel 2', 'Height', 189);
    Panel6.Width := FIniFile.ReadInteger('Panel 3', 'Width', 319);
    Panel6.Height := FIniFile.ReadInteger('Panel 3', 'Height', 189);
    Panel4.Width := FIniFile.ReadInteger('Panel 4', 'Width', 319);
    Panel4.Height := FIniFile.ReadInteger('Panel 4', 'Height', 189);
    Panel11.Width := FIniFile.ReadInteger('Main Panel', 'Width', 650);
    Panel11.Height := FIniFile.ReadInteger('Main Panel', 'Height', 252);
    Panel1.Width := FIniFile.ReadInteger('Nav Panel', 'Width', 214);
    Panel1.Height := FIniFile.ReadInteger('Nav Panel ', 'Height', 679);
  finally FIniFile.Free;
  end;
  ImageEnView1.SetExternalBitmap(MainView1.IEBitmap);
  ImageEnView2.SetExternalBitmap(MainView1.IEBitmap);
  ImageEnView3.SetExternalBitmap(MainView1.IEBitmap);
  ImageEnView4.SetExternalBitmap(MainView1.IEBitmap);
  MainView1.SetNavigator(Navigator1);
  ImageEnView1.Clear;
  ImageEnView2.Clear;
  ImageEnView3.Clear;
  ImageEnView4.Clear;
  Navigator1.Clear;
  MainView1.Clear;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  FIniFile: TIniFile;
begin
  FIniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    // save form position & state
    FIniFile.WriteInteger('Form', 'Left', Left);
    FIniFile.WriteInteger('Form', 'Top', Top);
    FIniFile.WriteInteger('Form', 'Width', Width);
    FIniFile.WriteInteger('Form', 'Height', Height);
    FIniFile.WriteInteger('Form', 'Window State', Integer(TWindowState(WindowState)));
    FIniFile.WriteInteger('Panel 1', 'Width', Panel3.Width);
    FIniFile.WriteInteger('Panel 1', 'Height', Panel3.Height);
    FIniFile.WriteInteger('Panel 2', 'Width', Panel13.Width);
    FIniFile.WriteInteger('Panel 2', 'Height', Panel13.Height);
    FIniFile.WriteInteger('Panel 3', 'Width', Panel6.Width);
    FIniFile.WriteInteger('Panel 3', 'Height', Panel6.Height);
    FIniFile.WriteInteger('Panel 4', 'Width', Panel4.Width);
    FIniFile.WriteInteger('Panel 4', 'Height', Panel4.Height);
    FIniFile.WriteInteger('Main Panel', 'Width', Panel11.Width);
    FIniFile.WriteInteger('Main Panel', 'Height', Panel11.Height);
    FIniFile.WriteInteger('Nav Panel', 'Width', Panel1.Width);
    FIniFile.WriteInteger('Nav Panel ', 'Height', Panel1.Height);
  finally FIniFile.Free;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ImageEnView1.SetExternalBitmap(nil);
  ImageEnView2.SetExternalBitmap(nil);
  ImageEnView3.SetExternalBitmap(nil);
  ImageEnView4.SetExternalBitmap(nil);
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  try
    ProgressBar1.Visible := true;
    MainView1.IO.LoadFromFile(MainView1.IO.ExecuteOpenDialog);
    ImageEnView1.Zoom := 10;
    ImageEnView2.Zoom := 25;
    ImageEnView3.Zoom := 50;
    ImageEnView4.Zoom := 75;
    ImageEnView1.Update;
    ImageEnView2.Update;
    ImageEnView3.Update;
    ImageEnView4.Update;
    ProgressBar1.Position := 0;
    ProgressBar1.Visible := false;
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.ImageEnView1ZoomIn(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView1.Cursor := 1779;
    Label1.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView1.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ImageEnView2ZoomIn(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView2.Cursor := 1779;
    Label2.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView2.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ImageEnView3ZoomIn(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView3.Cursor := 1779;
    Label3.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView3.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ImageEnView4ZoomIn(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView4.Cursor := 1779;
    Label4.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView4.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.MainView1ZoomIn(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    MainView1.Cursor := 1779;
    Label6.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    MainView1.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ImageEnView1ZoomOut(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView1.Cursor := 1778;
    Label1.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView1.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ImageEnView2ZoomOut(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView2.Cursor := 1778;
    Label2.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView2.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ImageEnView3ZoomOut(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView3.Cursor := 1778;
    Label3.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView3.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.ImageEnView4ZoomOut(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    ImageENView4.Cursor := 1778;
    Label4.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    ImageENView4.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.MainView1ZoomOut(Sender: TObject; var NewZoom: Double);
begin
  Screen.Cursor := crHourglass;
  try
    MainView1.Cursor := 1778;
    Label6.Caption := ' Zoom - ' + FloatToStr(NewZoom) + '%';
    MainView1.Hint := 'Zoom - ' + FloatToStr(NewZoom) + '%';
    Application.ActivateHint(Mouse.CursorPos);
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.cbZoomFilter1Change(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  try
    ImageEnView1.ZoomFilter := TResampleFilter(cbZoomFilter1.Itemindex);
    ImageEnView2.ZoomFilter := TResampleFilter(cbZoomFilter1.Itemindex);
    ImageEnView3.ZoomFilter := TResampleFilter(cbZoomFilter1.Itemindex);
    ImageEnView4.ZoomFilter := TResampleFilter(cbZoomFilter1.Itemindex);
    MainView1.ZoomFilter := TResampleFilter(cbZoomFilter1.Itemindex);
    Navigator1.ZoomFilter := TResampleFilter(cbZoomFilter1.Itemindex);
    ImageEnView1.Update;
    ImageEnView2.Update;
    ImageEnView3.Update;
    ImageEnView4.Update;
    Navigator1.Update;
  finally;
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.Navigator1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

procedure TForm1.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

procedure TForm1.ImageEnView2Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

procedure TForm1.ImageEnView3Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

procedure TForm1.ImageEnView4Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

procedure TForm1.MainView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  imageenview1.IO.DoPreviews();
end;

end.
