unit uImport;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Spin, ImageENIO;

type
  TfrmImport = class ( TForm )
    RadioGroup1: TRadioGroup;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    RzLabel1: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    ComboBox1: TComboBox;
    procedure RadioButton7Click ( Sender: TObject );
    procedure Button1Click(Sender: TObject);
    procedure RzSpinEdit1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure RzRadioButton7Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fIconWidth: integer;
    fIconHeight: integer;
    fBitsPerSample: integer;
    fSamplesPerPixel: integer;
    fBitCount: integer;
    fICO_BitCount: TIOICOBitCount;
  end;

var
  frmImport: TfrmImport;

implementation

uses umain;

{$R *.dfm}

procedure TfrmImport.RadioButton7Click ( Sender: TObject );
begin
  SpinEdit1.Enabled := true;
  SpinEdit2.Enabled := true;
end;

procedure TfrmImport.Button1Click(Sender: TObject);
begin
  if RadioButton1.Checked then
  begin
    fIconWidth := 16;
    fIconHeight := 16;
  end
  else
    if RadioButton2.Checked then
    begin
      fIconWidth := 32;
      fIconHeight := 32;
    end
    else
      if RadioButton3.Checked then
      begin
        fIconWidth := 48;
        fIconHeight := 48;
      end
      else
        if RadioButton4.Checked then
        begin
          fIconWidth := 64;
          fIconHeight := 64;
        end
        else
          if RadioButton5.Checked then
          begin
            fIconWidth := 72;
            fIconHeight := 72;
          end
          else
            if RadioButton6.Checked then
            begin
              fIconWidth := 128;
              fIconHeight := 128;
            end
            else
              if RadioButton7.Checked then
              begin
                fIconWidth := SpinEdit1.Value;
                fIconHeight := SpinEdit2.Value;
              end;

  case RadioGroup1.ItemIndex of
    0:
      begin // 32 bit
        fBitCount := 32;
        fBitsPerSample := 8;
        fSamplesPerPixel := 4;
        fICO_BitCount[0] := 32;
      end;
    1:
      begin // 24 bit True
        fBitCount := 24;
        fBitsPerSample := 8;
        fSamplesPerPixel := 3;
        fICO_BitCount[0] := 24;
      end;
    2:
      begin // 256 color
        fBitCount := 8;
        fBitsPerSample := 8;
        fSamplesPerPixel := 1;
        fICO_BitCount[0] := 8;
      end;
    3:
      begin // 16 color
        fBitCount := 4;
        fBitsPerSample := 4;
        fSamplesPerPixel := 1;
        fICO_BitCount[0] := 4;
      end;
    4:
      begin // Monochrome
        fBitCount := 2;
        fBitsPerSample := 1;
        fSamplesPerPixel := 1;
        fICO_BitCount[0] := 2
      end;
  end; // case
end;

procedure TfrmImport.RzSpinEdit1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  SpinEdit2.Value := SpinEdit1.Value;
end;

procedure TfrmImport.RzRadioButton7Click(Sender: TObject);
begin
  SpinEdit1.Enabled := true;
  SpinEdit2.Enabled := true;
end;

procedure TfrmImport.RadioButton6Click(Sender: TObject);
begin
  SpinEdit1.Enabled := false;
  SpinEdit2.Enabled := false;
end;

procedure TfrmImport.RadioButton5Click(Sender: TObject);
begin
  SpinEdit1.Enabled := false;
  SpinEdit2.Enabled := false;
end;

procedure TfrmImport.RadioButton4Click(Sender: TObject);
begin
  SpinEdit1.Enabled := true;
  SpinEdit2.Enabled := true;
end;

procedure TfrmImport.RadioButton3Click(Sender: TObject);
begin
  SpinEdit1.Enabled := false;
  SpinEdit2.Enabled := false;
end;

procedure TfrmImport.RadioButton2Click(Sender: TObject);
begin
  SpinEdit1.Enabled := false;
  SpinEdit2.Enabled := false;
end;

procedure TfrmImport.RadioButton1Click(Sender: TObject);
begin
  SpinEdit1.Enabled := false;
  SpinEdit2.Enabled := false;
end;

end.

