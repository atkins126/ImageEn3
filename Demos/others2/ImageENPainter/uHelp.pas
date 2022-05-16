unit uHelp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFrmHelp = class(TForm)
    RichEdit1: TRichEdit;
    Panel1: TPanel;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHelp: TFrmHelp;

implementation

{$R *.dfm}

procedure TFrmHelp.FormActivate(Sender: TObject);
begin
  RichEdit1.Lines.LoadFromFile('ImageEN Painter Help.rtf');
end;

end.
