unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ieview, imageenview, ieds, StdCtrls, ExtCtrls, ComCtrls,
  Menus, XPMan, ieopensavedlg;

type
  Tfmain = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Saveframe1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    XPManifest1: TXPManifest;
    N2: TMenuItem;
    Print1: TMenuItem;
    View1: TMenuItem;
    ools2: TMenuItem;
    Controls2: TMenuItem;
    SelectInput1: TMenuItem;
    SelectOutput1: TMenuItem;
    N3: TMenuItem;
    procedure FormDestroy(Sender: TObject);
    procedure Input1Click(Sender: TObject);
    procedure Output1Click(Sender: TObject);
    procedure Saveframe1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Print1Click(Sender: TObject);
    procedure Controls2Click(Sender: TObject);
    procedure ools2Click(Sender: TObject);
    procedure ImageEnView1DShowEvent(Sender: TObject);
    procedure ImageEnView1DShowNewFrame(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmain: Tfmain;

implementation

uses uselectinput, uselectoutput, utools, ucontrol;

{$R *.dfm}

procedure Tfmain.FormDestroy(Sender: TObject);
begin
end;

// select input

procedure Tfmain.Input1Click(Sender: TObject);
begin
  fselectinput.ShowModal;
  ImageEnView1.IO.DShowParams.Disconnect;
end;

// select output

procedure Tfmain.Output1Click(Sender: TObject);
begin
  fselectoutput.ShowModal;
  ImageEnView1.IO.DShowParams.Disconnect;
end;

// Save frame...

procedure Tfmain.Saveframe1Click(Sender: TObject);
begin
  ImageEnView1.IO.SaveToFile(ImageEnView1.IO.ExecuteSaveDialog());
end;

procedure Tfmain.Exit1Click(Sender: TObject);
begin
  close;
end;

// Print...

procedure Tfmain.Print1Click(Sender: TObject);
begin
  ImageEnView1.IO.DoPrintPreviewDialog();
end;

// controls

procedure Tfmain.Controls2Click(Sender: TObject);
begin
  fcontrol.Show;
end;

// tools

procedure Tfmain.ools2Click(Sender: TObject);
begin
  ftools.Show;
end;

procedure Tfmain.ImageEnView1DShowEvent(Sender: TObject);
begin
  fcontrol.Event;
end;

procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
begin
  fcontrol.NewFrame;
end;

end.
