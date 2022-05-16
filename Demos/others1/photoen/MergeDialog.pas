unit MergeDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfMergeDialog = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    TrackBar1: TTrackBar;
    Button1: TButton;
    Button2: TButton;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMergeDialog: TfMergeDialog;

implementation

uses Main;

{$R *.DFM}

procedure TfMergeDialog.TrackBar1Change(Sender: TObject);
begin
  groupbox2.caption := ' Merge ' + inttostr(100 - trackbar1.position) + '%';
end;

procedure TfMergeDialog.FormActivate(Sender: TObject);
var
  q: integer;
begin
  ListBox1.Clear;
  for q := 0 to MainForm.MDIChildCount - 1 do
    ListBox1.Items.Add(extractfilename(MainForm.MDIChildren[q].Caption));
end;

end.
