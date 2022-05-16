program pdfbuilder;

uses
  Forms,
  umain in 'umain.pas' {mainform};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
