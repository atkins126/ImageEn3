program maketransparent;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  upick in 'upick.pas' {PickDialog};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TPickDialog, PickDialog);
  Application.Run;
end.
