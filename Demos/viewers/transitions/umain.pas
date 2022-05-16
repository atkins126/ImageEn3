unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ImageEnView, ieview, ieXtraTransitions, iemview, hyieutils,
  ComCtrls;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    lblTransName: TLabel;
    spnTrans: TUpDown;
    Button3: TButton;
    spnDuration: TUpDown;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImageEnView1Click(Sender: TObject);
    procedure ImageEnView1KeyPress(Sender: TObject; var Key: Char);
    procedure spnTransClick(Sender: TObject; Button: TUDBtnType);
  private
    { Private declarations }
  public
    { Public declarations }
    curimage: integer;
    lleft, ltop, lwidth, lheight: integer;
    procedure ShowImage(bNext: boolean);
  end;

var
  Form1: TForm1;

implementation

uses ImageEnProc;

{$R *.DFM}

procedure TForm1.ShowImage(bNext: boolean);
begin
  if bNext then
  begin
    if spnTrans.Position = MAX_TRANSITIONS then
      spnTrans.Position := 1
    else
      spnTrans.Position := spnTrans.Position + 1;
  end;

  lblTransName.caption := IETransitionList[spnTrans.Position].name;
  caption := 'Transition: ' + IETransitionList[spnTrans.Position].name;

  inc(curimage);
  if curimage > 3 then
    curimage := 0;

  ImageEnView1.PrepareTransition;

  ImageEnView1.io.LoadFromFile(extractfilepath(ParamStr(0)) + inttostr(curimage) + '.jpg');

  ImageEnView1.RunTransition( TIETransitionType(spnTrans.Position) , spnDuration.Position);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  spnTrans.max := MAX_TRANSITIONS;
  curimage := -1;
  ShowImage(False);
end;

// next image button

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowImage(True);
end;

// full screen

procedure TForm1.Button2Click(Sender: TObject);
begin
  lleft := Left;
  ltop := Top;
  lwidth := Width;
  lheight := Height;
  Panel1.Hide;
  ImageEnView1.BorderStyle := bsNone;
  WindowState := wsMaximized;
  BorderStyle := bsNone;
  ImageEnView1.SetFocus;
end;

// click on the slide

procedure TForm1.ImageEnView1Click(Sender: TObject);
begin
  ShowImage(True);
end;

// key press

procedure TForm1.ImageEnView1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    BorderStyle := bsSizeable;
    WindowState := wsNormal;
    ImageEnView1.BorderStyle := bsSingle;
    Panel1.Show;
    SetBounds(lleft, ltop, lwidth, lheight);
  end;
end;

procedure TForm1.spnTransClick(Sender: TObject; Button: TUDBtnType);
begin
  ShowImage(false);
end;

end.
