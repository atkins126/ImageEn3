//------------------------------------------------------------------------------
  //  ImageEN Painter    : Version 1.0
  //  Copyright (c) 2007 : Adirondack Software & Graphics
  //  Created            : 05-25-2007
  //  Last Modification  : 05-25-2007
  //  Description        : Rotate Unit
//------------------------------------------------------------------------------

unit uRotate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, ImageEn, ImageEnView, ImageEnProc, ieview;

type
  TfrmRotate = class ( TForm )
    ImageEnProc1: TImageEnProc;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    CheckBox1: TCheckBox;
    ImageEnView1: TImageEnView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow ( Sender: TObject );
    procedure UpDown1Click ( Sender: TObject; Button: TUDBtnType );
    procedure Edit1KeyUp ( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRotate: TfrmRotate;

implementation

{$R *.DFM}

procedure TfrmRotate.FormActivate(Sender: TObject);
begin
  ImageEnView1.Proc.Rotate ( StrToIntDef ( Edit1.Text, 90 ) );
end;

procedure TfrmRotate.FormShow ( Sender: TObject );
begin
  ImageEnView1.SetChessboardStyle ( 6, bsSolid );
  ImageEnProc1.SaveUndo;
  ImageEnProc1.Rotate ( UpDown1.Position, Checkbox1.Checked );
end;

procedure TfrmRotate.UpDown1Click ( Sender: TObject; Button: TUDBtnType );
var
  RotationValue: integer;
begin
  RotationValue := UpDown1.Position;
  ImageEnProc1.Undo;
  ImageEnProc1.Rotate ( RotationValue, Checkbox1.Checked );
  ImageEnView1.Fit;
end;

procedure TfrmRotate.Edit1KeyUp ( Sender: TObject; var Key: Word;
  Shift: TShiftState );
const
  LF = #10;
var
  RotationValue: integer;
begin
  RotationValue := 90;
  try
    RotationValue := StrToInt ( Edit1.Text );
  except
    on E: EConvertError do
    begin
      if ( Edit1.Text <> '-' ) and ( Edit1.Text <> '' ) then
        MessageDlg ( E.Message + LF + 'Please enter a valid value', mtError, [ mbOK ], 0 );
    end;
  end;
  if ( RotationValue > -359 ) and ( RotationValue < 359 ) then
    if RotationValue <> 0 then
    begin
      ImageEnProc1.Undo;
      ImageEnProc1.Rotate ( RotationValue, Checkbox1.Checked );
      ImageEnView1.Fit;
    end;
end;

end.

