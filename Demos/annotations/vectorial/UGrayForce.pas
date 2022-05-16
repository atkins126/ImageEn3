unit UGrayForce;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IEGradientBar, HSVBox;

type
  TGrayForce = class(TForm)
    GroupBox1: TGroupBox;
    IEGradientBar1: TIEGradientBar;
    IEGradientBar2: TIEGradientBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    HSVBox1: THSVBox;
    Label6: TLabel;
    procedure IEGradientBar1Change(Sender: TObject);
    procedure IEGradientBar2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HSVBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GrayForce: TGrayForce;

implementation

uses Main;

{$R *.DFM}

procedure TGrayForce.IEGradientBar1Change(Sender: TObject);
begin
  Label3.Caption := IntToStr(IEGradientBar1.ColorIndex);
end;

procedure TGrayForce.IEGradientBar2Change(Sender: TObject);
begin
  Label4.Caption := IntToStr(IEGradientBar2.ColorIndex);
end;

procedure TGrayForce.FormCreate(Sender: TObject);
begin
  IEGradientBar1.ColorIndex := 0;
  IEGradientBar2.ColorIndex := 255;
end;

procedure TGrayForce.HSVBox1Change(Sender: TObject);
begin
  Label6.Caption := 'R:' + IntToStr(HSVBox1.Red) + ', G:' + IntToStr(HSVBox1.Green) + ', B:' + IntToStr(HSVBox1.Blue);
end;

end.
