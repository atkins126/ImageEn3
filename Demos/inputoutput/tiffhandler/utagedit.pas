unit utagedit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  Tftagedit = class(TForm)
    Label1: TLabel;
    TagCode: TEdit;
    Label2: TLabel;
    TagType: TComboBox;
    Label3: TLabel;
    TagValue: TEdit;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftagedit: Tftagedit;

implementation

{$R *.DFM}

end.
