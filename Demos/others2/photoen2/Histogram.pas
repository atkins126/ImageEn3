unit Histogram;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  HistogramBox, ExtCtrls, ImageEnProc, StdCtrls;

type
  TfHistogram = class(TForm)
    Panel1: TPanel;
    ImageEnProc1: TImageEnProc;
    HistogramBox1: THistogramBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Button1: TButton;
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fHistogram: TfHistogram;

implementation

{$R *.DFM}

// Channel

procedure TfHistogram.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: HistogramBox1.HistogramKind := [hkGray];
    1: HistogramBox1.HistogramKind := [hkRed];
    2: HistogramBox1.HistogramKind := [hkGreen];
    3: HistogramBox1.HistogramKind := [hkBlue];
  end;
end;

// Style

procedure TfHistogram.ComboBox2Change(Sender: TObject);
begin
  if ComboBox2.ItemIndex = 0 then
    HistogramBox1.HistogramStyle := hsBars
  else
    HistogramBox1.HistogramStyle := hsLines;
end;

procedure TfHistogram.FormCreate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 0;
  ComboBox2.ItemIndex := 0;
end;

end.
