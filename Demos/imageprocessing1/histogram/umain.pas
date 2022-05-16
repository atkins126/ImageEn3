unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, ExtCtrls, Menus, histogrambox, StdCtrls, Buttons;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    HistogramBoxGray: THistogramBox;
    Label1: TLabel;
    Label2: TLabel;
    HistogramBoxRed: THistogramBox;
    Label3: TLabel;
    HistogramBoxGreen: THistogramBox;
    Label4: TLabel;
    HistogramBoxBlue: THistogramBox;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Button1: TButton;
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageEnView1SelectionChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses ushowdata;

{$R *.DFM}

// File | Open
procedure TMainForm.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog('','',false,1,'') );
  HistogramBoxGray.Update;
  HistogramBoxRed.Update;
  HistogramBoxGreen.Update;
  HistogramBoxBlue.Update;
end;

// File | Close
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  HistogramBoxGray.AttachedImageEnProc:=ImageEnView1.Proc;
  HistogramBoxRed.AttachedImageEnProc:=ImageEnView1.Proc;
  HistogramBoxGreen.AttachedImageEnProc:=ImageEnView1.Proc;
  HistogramBoxBlue.AttachedImageEnProc:=ImageEnView1.Proc;
end;

procedure TMainForm.ImageEnView1SelectionChange(Sender: TObject);
begin
  HistogramBoxGray.Update;
  HistogramBoxRed.Update;
  HistogramBoxGreen.Update;
  HistogramBoxBlue.Update;
end;

// rectangle selection
procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
    ImageEnView1.MouseInteract:=[miSelect];
end;

// ellipse selection
procedure TMainForm.SpeedButton2Click(Sender: TObject);
begin
  if SpeedButton2.Down then
    ImageEnView1.MouseInteract:=[miSelectCircle];
end;

// polygon selection
procedure TMainForm.SpeedButton3Click(Sender: TObject);
begin
  if SpeedButton3.Down then
    ImageEnView1.MouseInteract:=[miSelectPolygon];
end;

// Show Values
procedure TMainForm.Button1Click(Sender: TObject);
begin
  FShowValues.ShowModal;
end;

end.
