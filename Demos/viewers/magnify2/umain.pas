unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    TrackBar2: TTrackBar;
    Label4: TLabel;
    TrackBar3: TTrackBar;
    procedure Open1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Open1Click(Sender: TObject);
begin
  // we want resizeable/moveable layers
  ImageEnView1.LayersSync := false;

  // load background
  ImageEnView1.LayersCurrent := 0;
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));

  if ImageEnView1.LayersCount = 1 then
  begin
    // create magnify layer
    ImageEnView1.LayersAdd;
    with ImageEnView1.Layers[1] do
    begin
      Width := 200;
      Height := 200;
      Magnify.Enabled := true;
      Magnify.Source:=iemBackgroundLayer;
    end;
  end;

  // allows user to move and resize layers
  ImageEnView1.MouseInteract := [miMoveLayers, miResizeLayers];

  // enable controls
  GroupBox1.Enabled := true;
end;

// Show Borders checkbox

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  ImageEnView1.Layers[1].VisibleBox := CheckBox1.Checked;
  ImageEnView1.Update;
end;

// Shape

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  ImageEnView1.Layers[1].Magnify.Style := TIEMagnifyStyle(ComboBox1.ItemIndex);
  ImageEnView1.Update;
end;

// rate

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Layers[1].Magnify.Rate := TrackBar1.Position / 10;
  ImageEnView1.Update;
end;

// transparency

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  ImageEnView1.Layers[1].Transparency := TrackBar2.Position;
  ImageEnView1.Update;
end;

// Zoom

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
  ImageEnView1.Zoom := TrackBar3.Position / 100;
end;

end.
