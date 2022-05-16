unit fplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, iemview;

type
  Tffplay = class(TForm)
    ImageEnMView1: TImageEnMView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ffplay: Tffplay;

implementation

{$R *.DFM}

procedure Tffplay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ImageEnMView1.Clear;
end;

procedure Tffplay.FormResize(Sender: TObject);
begin
  ImageEnMView1.ThumbWidth := ImageEnMView1.Width;
  ImageEnMView1.ThumbHeight := ImageEnMView1.Height;
end;

end.
