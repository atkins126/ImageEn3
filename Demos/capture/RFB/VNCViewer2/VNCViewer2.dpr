program VNCViewer2;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  unewconnection in 'unewconnection.pas' {NewConnectionForm},
  uconnectionform in 'uconnectionform.pas' {ConnectionForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TNewConnectionForm, NewConnectionForm);
  //Application.CreateForm(TConnectionForm, ConnectionForm);
  Application.Run;
end.
