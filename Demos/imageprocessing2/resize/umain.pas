unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, ExtCtrls, hyieutils;

type
  TForm1 = class(TForm)
    ieSource: TImageEnView;
    Label1: TLabel;
    Label2: TLabel;
    ieDest: TImageEnView;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
begin
  ieSource.IO.LoadFromFile('heli.jpg');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // avid flickering
  ieDest.LockUpdate;

  // get/restore source image
  ieDest.Assign(ieSource);

  // resize
  ieDest.Proc.ImageResize(StrToInt(Edit1.Text), StrToInt(Edit2.Text),
    TIEHAlign(RadioGroup1.ItemIndex), TIEVAlign(RadioGroup2.ItemIndex));
  //
  ieDest.UnLockUpdate;
end;

end.
