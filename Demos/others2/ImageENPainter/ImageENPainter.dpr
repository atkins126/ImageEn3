program ImageENPainter;

uses
  Forms,
  umain in 'umain.pas' {FrmMain},
  uAbout in 'uAbout.pas' {frmAbout},
  upick in 'upick.pas' {PickDialog},
  uFlip in 'uFlip.pas' {FrmFlip},
  uRotate in 'uRotate.pas' {frmRotate},
  uMsg in 'uMsg.pas' {FrmMsg},
  uPaste in 'uPaste.pas' {frmPaste},
  uResize in 'uResize.pas' {frmResize},
  uHelp in 'uHelp.pas' {FrmHelp};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'DelphiPainter';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
