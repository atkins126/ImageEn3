unit upick;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TPickDialog = class(TForm)
    Label1: TLabel;
    PickColor: TPanel;
    Label2: TLabel;
    ColorDialog1: TColorDialog;
    Button1: TButton;
    Label3: TLabel;
    procedure PickColorClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PickDialog: TPickDialog;

implementation

uses umain, imageenproc, hyiedefs;

{$R *.DFM}

procedure TPickDialog.PickColorClick(Sender: TObject);
begin
  ColorDialog1.Color:=PickColor.Color;
  if ColorDialog1.Execute then
  begin
    PickColor.Color:=ColorDialog1.Color;
    with TColor2TRGB( PickColor.Color ) do
      Label3.Caption := IntToStr(r)+','+IntToStr(g)+','+IntToStr(b);
  end;
end;

procedure TPickDialog.Button1Click(Sender: TObject);
begin
  MainForm.SetTransparent;
end;

end.
