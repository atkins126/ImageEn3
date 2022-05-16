unit uselectinput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tfselectinput = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fselectinput: Tfselectinput;

implementation

uses umain;

{$R *.dfm}

// select source file

procedure Tfselectinput.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit1.Text := OpenDialog1.FileName;
end;

procedure Tfselectinput.FormActivate(Sender: TObject);
begin
  ListBox1.Items.Assign(fmain.ImageEnView1.IO.DShowParams.VideoInputs);
  ListBox2.Items.Assign(fmain.ImageEnView1.IO.DShowParams.AudioInputs);
end;

procedure Tfselectinput.ListBox1Click(Sender: TObject);
begin
  edit1.Text:='';
end;

procedure Tfselectinput.ListBox2Click(Sender: TObject);
begin
  Edit1.Text:='';
end;

procedure Tfselectinput.Edit1Change(Sender: TObject);
begin
  ListBox1.ItemIndex:=-1;
  ListBox2.ItemIndex:=-1;
end;

end.
