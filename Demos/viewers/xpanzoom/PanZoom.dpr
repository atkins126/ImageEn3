program PanZoom;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  uGetSelection in 'uGetSelection.pas' {dlgGetSelection};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'XPanZoom';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdlgGetSelection, dlgGetSelection);
  Application.Run;
end.
