program ConvertToDemo;

uses
  Forms,
  FrmMain in 'FrmMain.pas' {FormMain},
  frmConvBW in 'frmConvBW.pas' {fConvBW},
  frmresres in 'frmresres.pas' {fResize},
  frmPropDlg in 'frmPropDlg.pas' {PropertiesDlg},
  frmSelection in 'frmSelection.pas' {SelectionDialog},
  frmfullscrn in 'frmfullscrn.pas' {FullScreen},
  frmRotate in 'frmRotate.pas' {fRotate},
  frmLosslessTransform in 'frmLosslessTransform.pas' {LosslessTransform};

{$R *.RES}

begin
    Application.Initialize;
    Application.Title := 'Apprehend Demo';
    Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TPropertiesDlg, PropertiesDlg);
  Application.CreateForm(TSelectionDialog, SelectionDialog);
  Application.CreateForm(TFullScreen, FullScreen);
  Application.CreateForm(TfRotate, fRotate);
  Application.CreateForm(TfResize, fResize);
  Application.CreateForm(TfConvBW, fConvBW);
  Application.CreateForm(TLosslessTransform, LosslessTransform);
  Application.Run;
end.

