unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, ieview, imageenview, ievect, StdCtrls, ComCtrls, Menus;

type
  TForm1 = class(TForm)
    ImageEnVect1: TImageEnVect;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    UpDown1: TUpDown;
    GroupBox2: TGroupBox;
    CheckBox2: TCheckBox;
    Label3: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label4: TLabel;
    Panel2: TPanel;
    ColorDialog1: TColorDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    LoadBackground1: TMenuItem;
    Button1: TButton;
    Label5: TLabel;
    Button2: TButton;
    FontDialog1: TFontDialog;
    Label6: TLabel;
    TrackBar1: TTrackBar;
    Label7: TLabel;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Label8: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure LoadBackground1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    lastobj: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin
  ImageEnVect1.ObjFontHeight[-1] := 35;
  ImageEnVect1.MouseInteractVt := [miPutText];
  lastobj := -1;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miPutText];
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  ImageEnVect1.MouseInteractVt := [miObjectSelect];
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  q, obj: integer;
begin
  obj := -1;
  for q := -1 to ImageEnVect1.SelObjectsCount - 1 do
  begin
    if q >= 0 then
      obj := ImageEnVect1.SelObjects[q];
    // curve
    if ComboBox1.Text = 'FromCurve' then
    begin
      ShowMessage('Please draw a curve');
      ImageEnVect1.MouseInteractVt := [miPutPolyline];
    end
    else
    begin
      ImageEnVect1.SetObjTextCurveShape(obj, TIECurve(ComboBox1.ItemIndex), strtointdef(edit1.text, 0), checkbox1.checked);
    end;
    ImageEnVect1.ObjTextCurveCharRot[obj] := strtointdef(edit3.text, -1);
    // shadow
    ImageEnVect1.ObjSoftShadow[obj].Enabled := CheckBox2.Checked;
    // transparency
    ImageEnVect1.ObjTransparency[obj] := strtointdef(edit2.text, 255);
    // color
    ImageEnVect1.ObjPenColor[obj] := Panel2.Color;
  end;
end;

// select color

procedure TForm1.Panel2Click(Sender: TObject);
begin
  if ColorDialog1.execute then
  begin
    Panel2.color := colorDialog1.Color;
    ComboBox1Change(self);
  end;
end;

// Load Background

procedure TForm1.LoadBackground1Click(Sender: TObject);
begin
  ImageEnVect1.IO.LoadFromFile(ImageEnVect1.IO.ExecuteOpenDialog('', '', false, 1, ''));
end;

// merge objects

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnVect1.CopyObjectsToBack(true);
  ImageEnVect1.RemoveAllObjects;
end;

// select font

procedure TForm1.Button2Click(Sender: TObject);
var
  q, obj: integer;
begin
  if FontDialog1.Execute then
  begin
    obj := -1;
    for q := -1 to ImageEnVect1.SelObjectsCount - 1 do
    begin
      if q >= 0 then
        obj := ImageEnVect1.SelObjects[q];
      ImageEnVect1.SetObjFont(obj, FontDialog1.Font);
    end;
    ComboBox1Change(self);
  end;
end;

procedure TForm1.ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
var
  rc: trect;
begin
  if ImageEnVect1.ObjKind[hobj] = iekPOLYLINE then
  begin
    ImageEnVect1.GetObjRect(hobj, rc);
    ImageEnVect1.SetObjRect(lastobj, rc);
    ImageEnVect1.SetObjTextCurveFromPolyline(lastobj, hobj);
    ImageEnVect1.RemoveObject(hobj);

    ImageEnVect1.MouseInteractVt := [miPutText];
  end
  else
    lastobj := hobj;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ImageEnVect1.Zoom := TrackBar1.Position;
end;

end.
