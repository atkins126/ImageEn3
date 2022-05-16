program PlainIconEditor;

uses
  Forms,
  umain in 'umain.pas' {MainForm},
  uSelectionProperties in 'uSelectionProperties.pas' {frmSelectionProperties},
  uImport in 'uImport.pas' {frmImport},
  usplash in 'usplash.pas' {frmSplash},
  uAbout in 'uAbout.pas' {frmAbout};

{$R *.RES}

begin
  frmSplash := TfrmSplash.Create ( Application );
  try
    frmSplash.Show;
    frmSplash.Refresh;
    Application.Initialize;
    Application.Title := 'Icon Editor';
    frmSplash.Update;
    Application.CreateForm ( TMainForm, MainForm );
    Application.CreateForm ( TfrmSelectionProperties, frmSelectionProperties );
    Application.CreateForm ( TfrmImport, frmImport );
    Application.CreateForm ( TfrmAbout, frmAbout );
  finally
    frmSplash.Release;
  end;
  Application.Run;
end.

