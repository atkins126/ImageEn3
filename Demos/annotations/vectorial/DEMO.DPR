program demo;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  UGrayForce in 'UGrayForce.pas' {GrayForce};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TGrayForce, GrayForce);
  Application.Run;
end.
