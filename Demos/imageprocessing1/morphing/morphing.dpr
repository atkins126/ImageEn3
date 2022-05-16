program morphing;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  umsg in 'umsg.pas' {fmsg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(Tfmsg, fmsg);
  Application.Run;
end.
