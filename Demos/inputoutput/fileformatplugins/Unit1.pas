unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, IEOpenSaveDlg, ImageEnIO, ImageEnView, StdCtrls, ieview;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    ImageEnIO1: TImageEnIO;
    OpenImageEnDialog1: TOpenImageEnDialog;
    SaveImageEnDialog1: TSaveImageEnDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Load1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Load1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses unc;

{$R *.DFM}

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Load1Click(Sender: TObject);
begin
  if OpenImageEnDialog1.Execute then
    ImageEnIO1.LoadFromFile(OpenImageEnDialog1.FileName);
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  if SaveImageEnDialog1.Execute then
    ImageEnIO1.SaveToFile(SaveImageEnDialog1.FileName);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  // register UNC (uncompressed) file format
  RegisterUNC;
end;

end.
