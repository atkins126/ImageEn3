unit unav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ieview, imageenview;

type
  Tfnav = class(TForm)
    ImageEnView1: TImageEnView;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fnav: Tfnav;

implementation

uses umain;

{$R *.dfm}

procedure Tfnav.FormCreate(Sender: TObject);
begin
  ImageEnView1.SelColor1 := ClRed;
  ImageEnView1.SelColor2 := ClYellow;
end;

end.
