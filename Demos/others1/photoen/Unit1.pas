unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Main, Childwin;

{$R *.DFM}

// read

procedure TForm1.Button1Click(Sender: TObject);
var
  ss: TMemoryStream;
begin
  Memo1.Clear;
  ss := TMemoryStream.Create;
  with MainForm.ActiveMDIChild as TMDIChild do
  begin
    ss.Size := ImageEnView1.Proc.ReadHiddenData(nil, 0);
    ImageEnView1.Proc.ReadHiddenData(ss.memory, ss.Size);
  end;
  Memo1.Lines.LoadFromStream(ss);
  ss.free;
end;

// write

procedure TForm1.Button2Click(Sender: TObject);
var
  ss: TMemoryStream;
begin
  ss := TMemoryStream.Create;
  Memo1.Lines.SaveToStream(ss);
  with MainForm.ActiveMDIChild as TMDIChild do
    ImageEnView1.Proc.WriteHiddenData(ss.memory, ss.size);
  ss.free;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  Memo1.Clear;
  with MainForm.ActiveMDIChild as TMDIChild do
    label3.Caption := IntToStr(ImageEnView1.Proc.GetHiddenDataSpace);
end;

end.
