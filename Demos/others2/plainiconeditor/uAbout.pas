unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmAbout = class ( TForm )
    pnlClient: TPanel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Button1: TButton;
    Label1: TLabel;
    Label5: TLabel;
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
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

uses ShellAPI;

{$R *.dfm}

procedure TfrmAbout.Label5MouseEnter ( Sender: TObject );
begin
  Label5.Font.Color := clRed;
  Label5.Font.Style := [ fsUnderline ];
end;

procedure TfrmAbout.Label5MouseLeave ( Sender: TObject );
begin
  Label5.Font.Color := clBlack;
  Label5.Font.Style := [ ];
end;

procedure TfrmAbout.Label5Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( 0, nil, PChar ( 'mailto:' + Label5.Caption ), nil, nil, SW_NORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmAbout.Label1Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'http://www.hicomponents.com/Apprehend' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmAbout.Label1MouseEnter ( Sender: TObject );
begin
  Label1.Font.Color := clRed;
  Label1.Font.Style := [ fsUnderline ];
end;

procedure TfrmAbout.Label1MouseLeave ( Sender: TObject );
begin
  Label1.Font.Color := clBlack;
  Label1.Font.Style := [ ];
end;

procedure TfrmAbout.Label4Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'http://www.hicomponents.com' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmAbout.Label4MouseEnter ( Sender: TObject );
begin
  Label4.Font.Color := clRed;
  Label4.Font.Style := [ fsUnderline ];
end;

procedure TfrmAbout.Label4MouseLeave ( Sender: TObject );
begin
  Label4.Font.Color := clBlack;
  Label4.Font.Style := [ ];
end;

end.

