program dshowcap;

uses
  Forms,
  umain in 'umain.pas' {fmain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.Run;
end.
