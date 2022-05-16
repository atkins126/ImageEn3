unit ColorSel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, HSVBox, ExtCtrls;

type
  TfColorSel = class(TForm)
    Panel1: TPanel;
    HSVBox1: THSVBox;
    Label1: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label3: TLabel;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Label4: TLabel;
    UpDown3: TUpDown;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Edit4: TEdit;
    UpDown4: TUpDown;
    Label6: TLabel;
    Edit5: TEdit;
    UpDown5: TUpDown;
    Label7: TLabel;
    Edit6: TEdit;
    UpDown6: TUpDown;
    Edit3: TEdit;
    procedure Edit1Change(Sender: TObject);
    procedure HSVBox1Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
  private
    { Private declarations }
    changing: boolean;
  public
    { Public declarations }
  end;

var
  fColorSel: TfColorSel;

implementation

{$R *.DFM}

// RGB Change

procedure TfColorSel.Edit1Change(Sender: TObject);
begin
  if not changing then
  begin
    HSVBox1.SetRGB(strtointdef(edit1.text, 0), strtointdef(edit2.text, 0), strtointdef(edit3.text, 0));
    HSVBox1Change(self);
  end;
end;

// HSV Change

procedure TfColorSel.HSVBox1Change(Sender: TObject);
begin
  changing := true;
  updown1.position := HSVBox1.Red;
  edit1.text := inttostr(HSVBox1.Red);
  updown2.position := HSVBox1.Green;
  edit2.text := inttostr(HSVBox1.Green);
  updown3.position := HSVBox1.Blue;
  edit3.text := inttostr(HSVBox1.Blue);
  updown4.position := HSVBox1.Hue;
  edit4.text := inttostr(HSVBox1.Hue);
  updown5.position := HSVBox1.Sat;
  edit5.text := inttostr(HSVBox1.Sat);
  updown6.position := HSVBox1.Val;
  edit6.text := inttostr(HSVBox1.Val);
  changing := false;
  panel2.color := HSVBox1.color;
end;

procedure TfColorSel.FormActivate(Sender: TObject);
begin
  HSVBox1Change(self);
end;

// Hue Change

procedure TfColorSel.Edit4Change(Sender: TObject);
begin
  if not changing then
  begin
    HSVBox1.Hue := strtointdef(edit4.text, 0);
    HSVBox1Change(self);
  end;
end;

// Sat/Val Change

procedure TfColorSel.Edit5Change(Sender: TObject);
begin
  if not changing then
  begin
    HSVBox1.Sat := strtointdef(edit5.text, 0);
    HSVBox1.Val := strtointdef(edit6.text, 0);
    HSVBox1Change(self);
  end;
end;

end.
