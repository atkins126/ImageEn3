{----------------------------------------------------------------------------
| TImageENView Image Batch Conversion Demo
| Description: Demonstrate TImageEnView
| Known Problems: None
|---------------------------------------------------------------------------}

unit ConvertForm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls;

type
  TfrmStatus = class(TForm)
    OKBtn: TButton;
    ProgressBar1: TProgressBar;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStatus: TfrmStatus;

implementation

{$R *.dfm}

procedure TfrmStatus.OKBtnClick(Sender: TObject);
begin
Close;
end;

end.
