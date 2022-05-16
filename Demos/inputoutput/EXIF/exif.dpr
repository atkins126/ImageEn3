program exif;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  umakernote in 'umakernote.pas' {fMakerNote};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TfMakerNote, fMakerNote);
  Application.Run;
end.
