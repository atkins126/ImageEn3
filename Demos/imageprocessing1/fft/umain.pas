unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, iefft, ComCtrls, imageenproc;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    ImageEnView1: TImageEnView;
    Button1: TButton;
    Button2: TButton;
    ImageEnView2: TImageEnView;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Button3: TButton;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edit1: TEdit;
    Button4: TButton;
    Label4: TLabel;
    Edit2: TEdit;
    Button5: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ImageEnView2SelectionChanging(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FTImage:TIEFtImage;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FTImage:=nil;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if assigned(FTImage) then
    FTImage.Free;
end;

// Open Original Image
procedure TForm1.Button1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile( ExecuteOpenDialog('','',false,1,'') );
end;

procedure TForm1.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position:=per;
end;

// Create FFT
procedure TForm1.Button2Click(Sender: TObject);
begin
  if assigned(FTImage) then
    FTImage.Free;
  FTImage:=ImageEnView1.Proc.FTCreateImage( ieitRGB ,-1,-1 );
  ImageEnView2.Proc.FTDisplayFrom( FTImage );
end;

// ReCreate image
procedure TForm1.Button3Click(Sender: TObject);
begin
  if assigned(FTImage) then
    ImageEnView1.Proc.FTConvertFrom( FTImage );
end;

// Do "HI Pass"
procedure TForm1.Button4Click(Sender: TObject);
begin
  if assigned(FTImage) then
  begin
    FTImage.HiPass( StrToIntDef(edit1.text,1) );
    ImageEnView2.Proc.FTDisplayFrom( FTImage );
  end;
end;

// Do "Lo Pass"
procedure TForm1.Button5Click(Sender: TObject);
begin
  if assigned(FTImage) then
  begin
    FTImage.LoPass( StrToIntDef(edit2.text,1) );
    ImageEnView2.Proc.FTDisplayFrom( FTImage );
  end;
end;

procedure TForm1.ImageEnView2SelectionChanging(Sender: TObject);
begin
  with ImageEnView2 do
    label6.caption := IntToStr(SelX1)+','+IntToStr(SelY1)+','+IntToStr(SelX2)+','+IntToStr(SelY2);
end;

// Do Clear Area
procedure TForm1.Button6Click(Sender: TObject);
begin
  if assigned(FTImage) then
  begin
    with ImageEnView2 do
      FTImage.ClearZone( SelX1,SelY1,SelX2,SelY2 );
    ImageEnView2.Proc.FTDisplayFrom( FTImage );
  end;
end;

end.
