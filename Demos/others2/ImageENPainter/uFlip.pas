//------------------------------------------------------------------------------
  //  ImageEN Painter    : Version 1.0
  //  Copyright (c) 2007 : Adirondack Software & Graphics
  //  Created            : 05-25-2007
  //  Last Modification  : 05-25-2007
  //  Description        : Flip Unit
//------------------------------------------------------------------------------

unit uFlip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ieview, imageenview, imageenproc, StdCtrls, ExtCtrls;

type
  TFrmFlip = class( TForm )
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    ImageEnView1: TImageEnView;
    MergeAlpha1: TCheckBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure RadioGroup1Click( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFlip: TFrmFlip;

implementation

{$R *.dfm}

uses uMain;

procedure TFrmFlip.RadioGroup1Click( Sender: TObject );
begin
  case RadioGroup1.ItemIndex of
    0: ImageEnView1.Proc.Flip( fdHorizontal );
    1: ImageEnView1.Proc.Flip( fdVertical );
  end;
end;

end.

