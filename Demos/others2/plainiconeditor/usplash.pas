unit usplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmSplash = class ( TForm )
    pnlClient: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ProgressBar: TProgressBar;
    procedure Label5MouseEnter ( Sender: TObject );
    procedure Label5MouseLeave ( Sender: TObject );
    procedure Label5Click ( Sender: TObject );
    procedure Label1Click ( Sender: TObject );
    procedure Label1MouseEnter ( Sender: TObject );
    procedure Label1MouseLeave ( Sender: TObject );
    procedure Label4Click ( Sender: TObject );
    procedure Label4MouseEnter ( Sender: TObject );
    procedure Label4MouseLeave ( Sender: TObject );
  private
    { Private declarations }
    function GetProgress: Integer;
    procedure SetProgress ( AValue: Integer );
  public
    { Public declarations }
    constructor Create ( AOwner: TComponent ); override;
    property Progress: Integer read GetProgress write SetProgress;
  end;

var
  frmSplash: TfrmSplash;

  const
  VERSION = '1.0';

implementation

uses ShellAPI;

{$R *.dfm}

function TfrmSplash.GetProgress: Integer;
begin
  Result := ProgressBar.Position;
end;

procedure TfrmSplash.SetProgress ( AValue: Integer );
begin
  ProgressBar.Position := AValue;
  Update;
end;

constructor TfrmSplash.Create ( AOwner: TComponent );
begin
  inherited;
  ProgressBar.Position := 0;
  Label3.Caption := 'Version ' + VERSION;
  Label3.Invalidate;
end;

procedure TfrmSplash.Label5MouseEnter ( Sender: TObject );
begin
  Label5.Font.Color := clRed;
  Label5.Font.Style := [ fsUnderline ];
end;

procedure TfrmSplash.Label5MouseLeave ( Sender: TObject );
begin
  Label5.Font.Color := clBlack;
  Label5.Font.Style := [ ];
end;

procedure TfrmSplash.Label5Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( 0, nil, PChar ( 'mailto:' + Label5.Caption ), nil, nil, SW_NORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmSplash.Label1Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'http://www.hicomponents.com/Apprehend' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmSplash.Label1MouseEnter ( Sender: TObject );
begin
  Label1.Font.Color := clRed;
  Label1.Font.Style := [ fsUnderline ];
end;

procedure TfrmSplash.Label1MouseLeave ( Sender: TObject );
begin
  Label1.Font.Color := clBlack;
  Label1.Font.Style := [ ];
end;

procedure TfrmSplash.Label4Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'http://www.hicomponents.com' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmSplash.Label4MouseEnter ( Sender: TObject );
begin
  Label4.Font.Color := clRed;
  Label4.Font.Style := [ fsUnderline ];
end;

procedure TfrmSplash.Label4MouseLeave ( Sender: TObject );
begin
  Label4.Font.Color := clBlack;
  Label4.Font.Style := [ ];
end;

end.

