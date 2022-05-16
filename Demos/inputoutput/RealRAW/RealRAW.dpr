program RealRAW;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  uraw in 'uraw.pas' {fRAW},
  uconvert in 'uconvert.pas' {fConvert};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfRAW, fRAW);
  Application.CreateForm(TfConvert, fConvert);
  Application.Run;
end.
