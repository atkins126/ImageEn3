program ResizeConvert;

uses
  Forms,
  Windows,
  main in 'main.pas' {Form1},
  ConvertForm in 'ConvertForm.pas' {frmStatus},
  Splash in 'Splash.pas' {frmSplash},
  View in 'View.pas' {frmView},
  ViewLog in 'ViewLog.pas' {ViewLogFile};

{$R *.res}

begin
  frmSplash := TfrmSplash.Create ( Application );
  try
    frmSplash.Show;
    frmSplash.Refresh;
    Application.Initialize;
    Application.Title := 'Image Batch Converter';
    frmSplash.Progress := 25;
    Sleep ( 200 );
    Application.CreateForm ( TForm1, Form1 );
    Application.CreateForm ( TfrmView, frmView );
    Application.CreateForm ( TViewLogFile, ViewLogFile );
    frmSplash.Progress := 66;
    Sleep ( 200 );
    Application.CreateForm ( TfrmStatus, frmStatus );
    frmSplash.Progress := 100;
    Sleep ( 400 );
    frmSplash.Update;
  finally
    frmSplash.Release;
  end;
  Application.Run;
end.

