program imagecomp;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  unavi in 'unavi.pas' {fNavi};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfNavi, fNavi);
  Application.Run;
end.
