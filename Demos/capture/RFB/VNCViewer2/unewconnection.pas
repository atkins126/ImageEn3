unit unewconnection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TNewConnectionForm = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    AddressEdit: TEdit;
    Port: TLabel;
    PortEdit: TEdit;
    Label2: TLabel;
    PasswordEdit: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NewConnectionForm: TNewConnectionForm;

implementation

{$R *.dfm}

procedure TNewConnectionForm.FormActivate(Sender: TObject);
begin
  AddressEdit.Text := '';
  PortEdit.Text := '5900';
  PassWordEdit.Text := '';

  AddressEdit.SetFocus;
end;

end.
