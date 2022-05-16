program histogram;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  ushowdata in 'ushowdata.pas' {FShowValues};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFShowValues, FShowValues);
  Application.Run;
end.
