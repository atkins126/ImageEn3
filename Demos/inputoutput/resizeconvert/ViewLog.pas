{----------------------------------------------------------------------------
| TImageENView Image Batch Conversion Demo
| Description: Demonstrate TImageEnView
| Known Problems: None
|---------------------------------------------------------------------------}

unit ViewLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TViewLogFile = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewLogFile: TViewLogFile;

implementation

{$R *.dfm}

procedure TViewLogFile.FormShow(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(ChangeFileExt(Application.ExeName, '.log'));
end;

end.
