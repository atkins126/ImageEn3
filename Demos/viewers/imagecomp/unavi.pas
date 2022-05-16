unit unavi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, ExtCtrls, ComCtrls;

type
  TfNavi = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    Splitter1: TSplitter;
    ImageEnView2: TImageEnView;
    TrackBar1: TTrackBar;
    procedure TrackBar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fNavi: TfNavi;

implementation

uses umain;

{$R *.DFM}

procedure TfNavi.TrackBar1Change(Sender: TObject);
begin
  umain.MainForm.ImageEnView1.Zoom:=TrackBar1.Position;
  umain.MainForm.ImageEnView2.Zoom:=TrackBar1.Position;
end;

end.
