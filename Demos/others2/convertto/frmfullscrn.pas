//------------------------------------------------------------------------------
//  ImageEN Convert To  & Lossless Transform Demo: 1.0
//------------------------------------------------------------------------------

unit frmfullscrn;

interface

uses SysUtils, Windows, Messages, Classes, Graphics, Controls, Comctrls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ImageEnView, ImageEn,
  IEView;

type
  TFullScreen = class ( TForm )
    ImageEnView1: TImageEnView;
    procedure ImageClick ( Sender: TObject );
    procedure Image1KeyDown ( Sender: TObject;var Key: Word;Shift: TShiftState );
    procedure FormKeyPress ( Sender: TObject;var Key: Char );
    procedure FormCreate ( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FullScreen: TFullScreen;

implementation

{$R *.DFM}

procedure TFullScreen.ImageClick ( Sender: TObject );
begin
  FullScreen.Close;
end;

procedure TFullScreen.Image1KeyDown ( Sender: TObject;var Key: Word;Shift: TShiftState );
begin
  FullScreen.Close;
end;

procedure TFullScreen.FormKeyPress ( Sender: TObject;var Key: Char );
begin
  FullScreen.Close;
end;

procedure TFullScreen.FormCreate ( Sender: TObject );
begin
  ImageEnView1.SetChessboardStyle ( 6, bsSolid );
end;

end.

