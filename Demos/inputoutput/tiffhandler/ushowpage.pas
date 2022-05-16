unit ushowpage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview;

type
  Tfshowpage = class(TForm)
    ImageEnView1: TImageEnView;
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fshowpage: Tfshowpage;

implementation

uses umain;

{$R *.DFM}

procedure Tfshowpage.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  MainForm.ProgressBar1.Position:=per;
end;

end.
