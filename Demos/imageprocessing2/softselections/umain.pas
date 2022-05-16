unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ieview, imageenview, ExtCtrls, imageenproc,
  Buttons;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    SelIntensity: TTrackBar;
    GroupBox2: TGroupBox;
    Button1: TButton;
    GroupBox3: TGroupBox;
    RectangleShape: TSpeedButton;
    EllipseShape: TSpeedButton;
    PolygonShape: TSpeedButton;
    MagicWandShape: TSpeedButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    UpDown1: TUpDown;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure SelIntensityChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RectangleShapeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// File | Exit

procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open

procedure TMainForm.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));
end;

// change selection intensity

procedure TMainForm.SelIntensityChange(Sender: TObject);
begin
  Label2.Caption := IntToStr(SelIntensity.Position);
  ImageEnView1.SelectionIntensity := SelIntensity.Position;
end;

// effects button

procedure TMainForm.Button1Click(Sender: TObject);
begin
  ImageEnView1.Proc.PreviewsParams := [prppDefaultLockPreview];
  ImageEnView1.Proc.DoPreviews([peAll]);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ImageEnView1.SelectionMaskDepth := 8;
  ImageEnView1.SelectionIntensity := 255;
end;

// selection shape buttons

procedure TMainForm.RectangleShapeClick(Sender: TObject);
begin
  if RectangleShape.Down then
    ImageEnView1.MouseInteract := [miSelect]
  else if EllipseShape.Down then
    ImageEnView1.MouseInteract := [miSelectCircle]
  else if PolygonShape.Down then
    ImageEnView1.MouseInteract := [miSelectPolygon]
  else if MagicWandShape.Down then
    ImageEnView1.MouseInteract := [miSelectMagicWand];
end;

// negative button

procedure TMainForm.Button2Click(Sender: TObject);
begin
  ImageEnView1.Proc.Negative;
end;

// blur button

procedure TMainForm.Button3Click(Sender: TObject);
begin
  ImageEnView1.Proc.Blur(3);
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  ImageEnView1.MakeSelectionFeather(UpDown1.Position);
end;

end.
