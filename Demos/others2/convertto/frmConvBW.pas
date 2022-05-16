//------------------------------------------------------------------------------
//  ImageEN Convert To  & Lossless Transform Demo: 1.0
//------------------------------------------------------------------------------

unit frmConvBW;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls;

type
  TfConvBW = class ( TForm )
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    procedure RadioGroup1Click ( Sender: TObject );
    procedure SpeedButton1Click ( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConvBW: TfConvBW;

implementation

{$R *.DFM}

procedure TfConvBW.RadioGroup1Click ( Sender: TObject );
begin
  GroupBox1.Enabled := RadioGroup1.ItemIndex = 0;
end;

procedure TfConvBW.SpeedButton1Click ( Sender: TObject );
begin
  edit1.enabled := not SpeedButton1.Down;
  label1.enabled := not SpeedButton1.Down;
end;

end.

