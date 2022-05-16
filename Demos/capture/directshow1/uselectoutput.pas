unit uselectoutput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  Tfselectoutput = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    ListBox2: TListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fselectoutput: Tfselectoutput;

implementation

uses umain;

{$R *.dfm}

procedure Tfselectoutput.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Edit1.text := SaveDialog1.FileName;
end;

procedure Tfselectoutput.FormActivate(Sender: TObject);
begin
  ListBox1.Items.Assign(fmain.ImageEnView1.IO.DShowParams.VideoCodecs);
  ListBox2.Items.Assign(fmain.ImageEnView1.IO.DShowParams.AudioCodecs);
end;

end.
