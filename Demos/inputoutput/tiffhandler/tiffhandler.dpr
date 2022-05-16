program tiffhandler;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  utagedit in 'utagedit.pas' {ftagedit},
  ushowpage in 'ushowpage.pas' {fshowpage};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(Tftagedit, ftagedit);
  Application.CreateForm(Tfshowpage, fshowpage);
  Application.Run;
end.
