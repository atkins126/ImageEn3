unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, imageenio, iewia;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// Select WIA device
procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnView1.IO.SelectAcquireSource(ieaWIA);
end;

// Take photo
procedure TForm1.Button2Click(Sender: TObject);
begin
  if ImageEnView1.IO.WIAParams.Device=nil then
    ImageEnView1.IO.WIAParams.ConnectTo(0);
  ImageEnView1.IO.WIAParams.TakePicture:=true;
  ImageEnView1.IO.WIAParams.DeleteTakenPicture:=true;
  ImageEnView1.IO.Acquire(ieaWIA);
end;

end.
