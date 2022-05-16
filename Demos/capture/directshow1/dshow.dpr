program dshow;

uses
  Forms,
  umain in 'umain.pas' {fmain},
  uselectinput in 'uselectinput.pas' {fselectinput},
  uselectoutput in 'uselectoutput.pas' {fselectoutput},
  utools in 'utools.pas' {ftools},
  ucontrol in 'ucontrol.pas' {fcontrol};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.CreateForm(Tfselectinput, fselectinput);
  Application.CreateForm(Tfselectoutput, fselectoutput);
  Application.CreateForm(Tftools, ftools);
  Application.CreateForm(Tfcontrol, fcontrol);
  Application.Run;
end.
