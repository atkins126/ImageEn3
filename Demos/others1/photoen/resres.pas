unit resres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TfResize = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    ComboBox1: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private declarations }
    DontChange: boolean;
  public
    { Public declarations }
    OrgWidth, OrgHeight: integer;
  end;

var
  fResize: TfResize;

implementation

{$R *.DFM}

procedure TfResize.FormActivate(Sender: TObject);
begin
  DontChange := true;
  edit1.text := inttostr(OrgWidth);
  edit2.text := inttostr(OrgHeight);
  DontChange := false;
  ComboBox1.ItemIndex := 0;
  edit1.setfocus;
end;

procedure TfResize.Edit1Change(Sender: TObject);
begin
  if CheckBox1.checked and not DontChange then
  begin
    DontChange := true;
    edit2.text := inttostr(round(OrgHeight * strtointdef(edit1.text, 0) / OrgWidth));
    DontChange := false;
  end;
end;

procedure TfResize.Edit2Change(Sender: TObject);
begin
  if CheckBox1.checked and not DontChange then
  begin
    DontChange := true;
    edit1.text := inttostr(round(OrgWidth * strtointdef(edit2.text, 0) / OrgHeight));
    DontChange := false;
  end;
end;

end.
