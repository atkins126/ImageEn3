unit uraw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfRAW = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ImageWidth: TEdit;
    Label2: TLabel;
    ImageHeight: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    HeaderSize: TEdit;
    Label4: TLabel;
    GroupBox6: TGroupBox;
    Label5: TLabel;
    RowAlign: TEdit;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    PixelFormat: TRadioGroup;
    ColorOrder: TRadioGroup;
    ColorPlanes: TRadioGroup;
    DataFormat: TRadioGroup;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRAW: TfRAW;

implementation

{$R *.DFM}



end.
