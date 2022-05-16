program imagesdiff;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  uchild in 'uchild.pas' {fchild};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(Tfchild, diffs);
  Application.CreateForm(Tfchild, image1);
  Application.CreateForm(Tfchild, image2);
  Application.Run;
end.
