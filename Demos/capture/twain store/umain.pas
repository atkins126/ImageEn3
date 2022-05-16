unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ieview, imageenview, ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    Button1: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

// Set TWain settings
procedure TMainForm.Button1Click(Sender: TObject);
begin
  // Ask user to select a TWain device
  ImageEnView1.IO.SelectAcquireSource();

  // Next call to "Acquire" will only show scanner user interface
  ImageEnView1.IO.TWainParams.ShowSettingsOnly := true;

  // Show scanner user interface, so user can set settings
  ImageEnView1.IO.Acquire();

  // Save settings to file
  // Here we use scanner name. Anyway you could have different settings like "Gray scale", "Color", "ADF"...
  with ImageEnView1.IO.TWainParams do
    SourceSettings.SaveToFile(SourceName[SelectedSource]+'.settings');
end;

// Acquire
procedure TMainForm.Button4Click(Sender: TObject);
var
  FileName:string;
begin
  // Ask user to select a TWain device
  ImageEnView1.IO.SelectAcquireSource();

  with ImageEnView1.IO.TWainParams do
  begin
    // Does this settings exists?
    FileName := SourceName[SelectedSource]+'.settings';
    if not FileExists(FileName) then
    begin
      ShowMessage('Settings not saved for this device. Please click "Set TWain Settings".');
      exit;
    end;

    // We don't need device dialog (optional)
    VisibleDialog := false;

    // Disable ShowSettingsOnly (this is the default, but could be true from previous session)
    ShowSettingsOnly := false;

    // Load device settings
    SourceSettings.LoadFromFile(FileName);
  end;

  // Capture image using loaded device settings
  ImageEnView1.IO.Acquire();
end;

end.
