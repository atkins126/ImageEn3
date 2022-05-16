{----------------------------------------------------------------------------
| TImageENView Image Batch Conversion Demo
| Description: Demonstrate TImageEnView
| Known Problems: None
|---------------------------------------------------------------------------}

unit View;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ieview, imageenview, ieopensavedlg, HYIEDefs, HYieutils;

type
  TfrmView = class ( TForm )
    ImageEnView: TImageEnView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmView: TfrmView;

implementation

uses Main;

{$R *.dfm}

procedure TfrmView.FormCreate(Sender: TObject);
begin
  ImageEnView.SetChessboardStyle ( 6, bsSolid );
  // mouse wheel will scroll image of 15 % of component height
  ImageEnView.MouseWheelParams.Action := iemwVScroll;
  ImageEnView.MouseWheelParams.Variation := iemwPercentage;
  ImageEnView.MouseWheelParams.Value := 15;
  // set scrollbar params to match wheel
  ImageEnView.HScrollBarParams.LineStep := 15;
  ImageEnView.VScrollBarParams.LineStep := 15;
end;

end.

