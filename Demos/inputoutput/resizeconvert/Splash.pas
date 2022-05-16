{----------------------------------------------------------------------------
| TImageENView Image Batch Conversion Demo
| Description: Demonstrate TImageEnView
| Known Problems: None
|---------------------------------------------------------------------------}

unit Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmSplash = class(TForm)
    pnlClient: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ProgressBar: TProgressBar;
    Label5: TLabel;
  private
    { Private declarations }
    function GetProgress: Integer;
    procedure SetProgress(AValue: Integer);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property Progress: Integer read GetProgress write SetProgress;
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

function TfrmSplash.GetProgress: Integer;
begin
  Result := ProgressBar.Position;
end;

procedure TfrmSplash.SetProgress(AValue: Integer);
begin
  ProgressBar.Position := AValue;
  Update;
end;

constructor TfrmSplash.Create(AOwner: TComponent);
begin
  inherited;
  ProgressBar.Position := 0;
end;

end.
