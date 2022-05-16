program advancedtext;

uses
  Forms,
  umain in 'umain.pas' {fmain},
  utext in 'utext.pas' {ftext};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.CreateForm(Tftext, ftext);
  Application.Run;
end.
