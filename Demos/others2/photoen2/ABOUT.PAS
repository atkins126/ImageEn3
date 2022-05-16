unit About;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ImageEnProc, ImageEnIO, ImageEnView, ieview;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    Label1: TLabel;
    OKButton: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

uses SysUtils;

{$R *.DFM}

end.
