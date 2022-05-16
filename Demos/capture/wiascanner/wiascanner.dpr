program wiascanner;

uses
  Forms,
  umain in 'umain.pas' {fmain},
  uselitem in 'uselitem.pas' {fselitem};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.CreateForm(Tfselitem, fselitem);
  Application.Run;
end.
