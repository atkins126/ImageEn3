program ImageEx;

uses
  Forms,
  Main in 'MAIN.PAS' {MainForm},
  Childwin in 'CHILDWIN.PAS' {MDIChild},
  About in 'about.pas' {AboutBox},
  ColorSel in 'ColorSel.pas' {fColorSel},
  Rotate in 'Rotate.pas' {fRotate},
  MergeDialog in 'MergeDialog.pas' {fMergeDialog},
  Histogram in 'Histogram.pas' {fHistogram},
  ConvBW in 'ConvBW.pas' {fConvBW},
  resres in 'resres.pas' {fResize},
  zprop in 'zprop.pas' {fZProp},
  Unit1 in 'Unit1.pas' {Form1};

{$R *.RES}

begin
   Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfColorSel, fColorSel);
  Application.CreateForm(TfRotate, fRotate);
  Application.CreateForm(TfMergeDialog, fMergeDialog);
  Application.CreateForm(TfHistogram, fHistogram);
  Application.CreateForm(TfConvBW, fConvBW);
  Application.CreateForm(TfResize, fResize);
  Application.CreateForm(TfZProp, fZProp);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

