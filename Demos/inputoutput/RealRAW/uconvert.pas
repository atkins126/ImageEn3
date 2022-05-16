unit uconvert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfConvert = class(TForm)
    Button1: TButton;
    Button2: TButton;
    SourcePixelFormat: TRadioGroup;
    DestPixelFormat: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConvert: TfConvert;

implementation

{$R *.DFM}






end.
