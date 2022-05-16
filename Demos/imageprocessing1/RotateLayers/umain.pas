unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, imageenproc, StdCtrls, hyieutils;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ImageEnView1: TImageEnView;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Layers1: TMenuItem;
    Add1: TMenuItem;
    Rotate1: TMenuItem;
    MoveResize1: TMenuItem;
    Save1: TMenuItem;
    View1: TMenuItem;
    Fit1: TMenuItem;
    Actualsize1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Rotate1Click(Sender: TObject);
    procedure MoveResize1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Fit1Click(Sender: TObject);
    procedure Actualsize1Click(Sender: TObject);
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
var
  filename:string;
begin
  // open dialog
  filename:=ImageEnView1.IO.ExecuteOpenDialog;

  // load as multilayer file
  if ExtractFileExt(filename)='.lyr' then
    ImageEnView1.LayersLoadFromFile( filename )

  // load as psd (with layers)
  else if ExtractFileExt(filename)='.psd' then
  begin
    ImageEnView1.IO.Params.PSD_LoadLayers:=true;
    ImageEnView1.IO.LoadFromFile( filename );
  end

  // generic file
  else
    ImageEnView1.IO.LoadFromFile( filename );
end;

// File | Save
procedure TMainForm.Save1Click(Sender: TObject);
var
  filename:string;
begin
  // save dialog
  filename:=ImageEnView1.IO.ExecuteSaveDialog;

  // save as multilayer file
  if ExtractFileExt(filename)='.lyr' then
    ImageenView1.LayersSaveToFile( filename )

  // save as psd multilayer
  else if ExtractFileExt(filename)='.psd' then
    ImageEnView1.IO.SaveToFile( filename )
  else

  // merge layers and save as generic file
  begin
    ImageEnView1.LayersMergeAll;
    ImageEnView1.IO.SaveToFile( filename );
  end;
end;

// Layers | Add
procedure TMainForm.Add1Click(Sender: TObject);
begin
  // add a new layer
  ImageEnView1.LayersAdd;

  // fill with white background
  ImageEnView1.Proc.Fill(clWhite);

  // enable layers resizing and moving
  ImageEnView1.MouseInteract:=[miResizeLayers,miMoveLayers];
end;

// Layers | Rotate
procedure TMainForm.Rotate1Click(Sender: TObject);
begin
  Rotate1.Checked:=true;

  // enable layers resizing and moving
  ImageEnView1.MouseInteract:=[miRotateLayers,miMoveLayers];
end;

// Layers | MoveResize
procedure TMainForm.MoveResize1Click(Sender: TObject);
begin
  MoveResize1.Checked:=true;

  // enable layers rotate and moving
  ImageEnView1.MouseInteract:=[miResizeLayers,miMoveLayers];
end;


// View | Fit
procedure TMainForm.Fit1Click(Sender: TObject);
begin
  ImageEnView1.Fit;
end;

// View | actual size
procedure TMainForm.Actualsize1Click(Sender: TObject);
begin
  ImageEnView1.Zoom:=100;
end;

end.
