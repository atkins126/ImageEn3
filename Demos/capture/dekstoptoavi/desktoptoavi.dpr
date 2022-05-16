program desktoptoavi;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  fplay in 'fplay.pas' {ffplay};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tffplay, ffplay);
  Application.Run;
end.
