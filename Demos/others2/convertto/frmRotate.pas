//------------------------------------------------------------------------------
//  ImageEN Convert To  & Lossless Transform Demo: 1.0
//------------------------------------------------------------------------------

unit frmRotate;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   StdCtrls, ComCtrls, ImageEn, ExtCtrls, ImageEnView, ImageEnProc, IEView;

type
   TfRotate = class( TForm )
      GroupBox1: TGroupBox;
      Button1: TButton;
      Button2: TButton;
      Label1: TLabel;
      Edit1: TEdit;
      UpDown1: TUpDown;
      CheckBox1: TCheckBox;
      ImageEnView1: TImageEnView;
      ImageEnProc1: TImageEnProc;
      procedure FormActivate( Sender: TObject );
      procedure Edit1Change( Sender: TObject );
   private
    { Private declarations }
   public
    { Public declarations }
   end;

var
   fRotate: TfRotate;

implementation

{$R *.DFM}

procedure TfRotate.FormActivate( Sender: TObject );
begin
   Updown1.Position := 0;
   Checkbox1.Checked := false;
   ImageEnProc1.SaveUndo;
end;

// edit-change
procedure TfRotate.Edit1Change( Sender: TObject );
begin
   ImageEnProc1.Undo;
   ImageEnProc1.rotate( strtointdef( edit1.text, 0 ), checkbox1.checked );
   ImageEnView1.Fit;
end;

end.

