unit uSelectionProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TfrmSelectionProperties = class ( TForm )
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    UpDownSelectionTolerance: TUpDown;
    SelectionIntensityEdit: TEdit;
    MagicWandToleranceUpDown: TUpDown;
    MagicWandToleranceEdit: TEdit;
    cbMagicWandMode: TComboBox;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute: Boolean;
  end;

var
  frmSelectionProperties: TfrmSelectionProperties;

implementation

uses UMain, IEView, ImageENView;

{$R *.dfm}

function TfrmSelectionProperties.Execute: Boolean;
begin
  Result := (ShowModal = mrOK);
end;

end.

