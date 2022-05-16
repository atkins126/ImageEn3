unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  imageenview, ieview, iemview, StdCtrls, ExtCtrls, imageenproc, hyiedefs;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    ImageEnMView1: TImageEnMView;
    ImageEnView1: TImageEnView;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

// Open
procedure TMainForm.Button1Click(Sender: TObject);
var
  FileName:String;
begin
  FileName:=ImageEnView1.IO.ExecuteOpenDialog;
  if FileName<>'' then
  begin
    ImageEnMView1.Clear;
    ImageEnView1.Blank;
    ImageEnView1.IO.LoadFromFile( FileName );

    ImageEnMView1.SetIEBitmap( ImageEnMView1.AppendImage, ImageenView1.IEBitmap );

  end;
end;

// Separate
procedure TMainForm.Button2Click(Sender: TObject);
var
  rects:TList;
  i:integer;
  d:double;
  quality:integer;
begin
  Screen.Cursor := crHourGlass;
  try

  // leave only the first image
  for i:=1 to ImageEnMView1.ImageCount-1 do
    ImageEnMView1.DeleteImage(1);

  ImageEnView1.DeSelect;

  if CheckBox2.Checked then
    quality := 1  // quick process
  else
    quality := 4; // quality process

  rects := ImageEnView1.Proc.SeparateObjects(quality,CheckBox3.Checked);

  for i:=0 to rects.Count-1 do
  begin
    with PRect(rects[i])^ do
    begin
      if (Right-Left>10) and (Bottom-Top>10) then // removes little objects
      begin
        // draw boxes
        if CheckBox1.Checked then
          with ImageEnView1.IEBitmap.Canvas do
          begin
            Pen.Color:=clRed;
            Brush.Style:=bsClear;
            Rectangle(Left,Top,Right+1,Bottom+1);
          end
        else
          ImageEnMView1.SetImageRect( ImageEnMView1.AppendImage, ImageEnView1.IEBitmap, Left,Top,Right,Bottom );
      end;
    end;
    dispose(PRect(rects[i]));
  end;
  rects.free;
  ImageEnView1.Update;

  if CheckBox1.Checked then
    exit;

  // Deskew
  if Checkbox4.Checked then
    for i:=1 to ImageEnMView1.ImageCount-1 do
    begin
      ImageEnMView1.CopyToIEBitmap(i, ImageEnView1.IEBitmap);
      ImageEnView1.Update;
      application.processmessages;
      d:=ImageEnView1.Proc.SkewDetection;
      ImageEnView1.Proc.RotateAndCrop(d);
      ImageEnMView1.SetIEBitmap(i,ImageEnView1.IEBitmap);
      ImageEnView1.Update;
      application.processmessages;
    end;

  finally
    Screen.Cursor:=crDefault;
  end;
end;

// Selected an image in left multiview
procedure TMainForm.ImageEnMView1ImageSelect(Sender: TObject;
  idx: Integer);
begin
  ImageEnMView1.CopyToIEBitmap(idx, ImageEnView1.IEBitmap);
  ImageEnView1.Update;
end;

end.
