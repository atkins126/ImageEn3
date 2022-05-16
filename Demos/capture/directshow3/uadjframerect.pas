unit uadjframerect;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview, StdCtrls;

type
  TfAdjustFrameRect = class(TForm)
    ImageEnView1: TImageEnView;
    Label1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAdjustFrameRect: TfAdjustFrameRect;

implementation

{$R *.DFM}

end.
