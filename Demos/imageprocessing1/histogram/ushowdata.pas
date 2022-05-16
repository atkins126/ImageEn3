unit ushowdata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFShowValues = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    ListBox2: TListBox;
    Label3: TLabel;
    ListBox3: TListBox;
    Label4: TLabel;
    ListBox4: TListBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FShowValues: TFShowValues;

implementation

uses umain,imageenproc;

{$R *.DFM}

procedure TFShowValues.FormActivate(Sender: TObject);
var
  hist:THistogram;
  i:integer;
begin
  MainForm.ImageEnView1.Proc.GetHistogram( @hist );
  listbox1.Clear;
  for i:=0 to 255 do
  begin
    listbox1.Items.Add( inttostr(i)+' -> '+inttostr(hist[i].Gray) );
    listbox2.Items.Add( inttostr(i)+' -> '+inttostr(hist[i].R) );
    listbox3.Items.Add( inttostr(i)+' -> '+inttostr(hist[i].G) );
    listbox4.Items.Add( inttostr(i)+' -> '+inttostr(hist[i].B) );
  end;
end;




end.
