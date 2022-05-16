unit uchild;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ieview, imageenview;

type
  Tfchild = class(TForm)
    ImageEnView1: TImageEnView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  image1,image2,diffs:Tfchild;

implementation

{$R *.DFM}

end.
