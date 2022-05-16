program navigator;

uses
  Forms,
  umain in 'umain.pas' {fmain},
  unav in 'unav.pas' {fnav};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.CreateForm(Tfnav, fnav);
  Application.Run;
end.
