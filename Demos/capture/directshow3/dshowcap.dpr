program dshowcap;

uses
  Forms,
  umain in 'umain.pas' {fmain},
  uadjframerect in 'uadjframerect.pas' {fAdjustFrameRect};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfmain, fmain);
  Application.CreateForm(TfAdjustFrameRect, fAdjustFrameRect);
  Application.Run;
end.
