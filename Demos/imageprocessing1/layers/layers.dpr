program layers;

uses
  Forms,
  main in 'main.pas' {fmain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.Run;
end.
