unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, ExtCtrls, hyiedefs, hyieutils, StdCtrls, imageenproc,
  ComCtrls;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Button1: TButton;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    Label8: TLabel;
    Edit8: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Edit10: TEdit;
    Label11: TLabel;
    Edit11: TEdit;
    Label12: TLabel;
    Edit12: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Button2: TButton;
    Save1: TMenuItem;
    GroupBox1: TGroupBox;
    TrackBar1: TTrackBar;
    Label16: TLabel;
    TrackBar2: TTrackBar;
    Label17: TLabel;
    TrackBar3: TTrackBar;
    Label18: TLabel;
    TrackBar4: TTrackBar;
    Label19: TLabel;
    GroupBox2: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    TrackBar5: TTrackBar;
    TrackBar6: TTrackBar;
    TrackBar7: TTrackBar;
    TrackBar8: TTrackBar;
    GroupBox3: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    TrackBar9: TTrackBar;
    TrackBar10: TTrackBar;
    TrackBar11: TTrackBar;
    TrackBar12: TTrackBar;
    GroupBox4: TGroupBox;
    ImageEnView2: TImageEnView;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

// File | Exit

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

// File | Open

procedure TForm1.Open1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 0, ''));
  // assign preview window
  ImageEnView1.Proc.ResampleTo(ImageEnView2.IEBitmap, 150, -1, rfFastLinear);
  ImageEnView2.Update;
  ImageEnView2.Proc.SaveUndo(ieuImage);
end;

// apply to RGB

procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnView1.Proc.RadialStretch(IEStrToFloatDefS(edit1.text, 0), IEStrToFloatDefS(edit2.text, 0), IEStrToFloatDefS(edit3.text, 0), IEStrToFloatDefS(edit4.text, 0),
    IEStrToFloatDefS(edit5.text, 0), IEStrToFloatDefS(edit6.text, 0), IEStrToFloatDefS(edit7.text, 0), IEStrToFloatDefS(edit8.text, 0),
    IEStrToFloatDefS(edit9.text, 0), IEStrToFloatDefS(edit10.text, 0), IEStrToFloatDefS(edit11.text, 0), IEStrToFloatDefS(edit12.text, 0));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  imageenview1.proc.undo;
end;

// save as

procedure TForm1.Save1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    SaveToFile(ExecuteSaveDialog('', '', false, 0, ''));
end;

// changes a trackbar for preview

procedure TForm1.TrackBar1Change(Sender: TObject);
begin

  if checkbox2.Checked then
  begin
    trackbar5.position := trackbar1.position;
    trackbar9.position := trackbar1.position;

    trackbar6.position := trackbar2.position;
    trackbar10.position := trackbar2.position;

    trackbar7.position := trackbar3.position;
    trackbar11.position := trackbar3.position;

    if not checkbox1.checked then
    begin
      trackbar8.position := trackbar4.position;
      trackbar12.position := trackbar4.position;
    end;
  end;

  if checkbox1.checked then
  begin
    // "d" is automatic
    trackbar4.position := 1000 - (trackbar1.position + trackbar2.position + trackbar3.position);
    trackbar8.position := 1000 - (trackbar5.position + trackbar6.position + trackbar7.position);
    trackbar12.position := 1000 - (trackbar9.position + trackbar10.position + trackbar11.position);
  end;

  edit1.text := floattostr(trackbar1.position / 1000);
  edit2.text := floattostr(trackbar2.position / 1000);
  edit3.text := floattostr(trackbar3.position / 1000);
  edit4.text := floattostr(trackbar4.position / 1000);
  edit5.text := floattostr(trackbar5.position / 1000);
  edit6.text := floattostr(trackbar6.position / 1000);
  edit7.text := floattostr(trackbar7.position / 1000);
  edit8.text := floattostr(trackbar8.position / 1000);
  edit9.text := floattostr(trackbar9.position / 1000);
  edit10.text := floattostr(trackbar10.position / 1000);
  edit11.text := floattostr(trackbar11.position / 1000);
  edit12.text := floattostr(trackbar12.position / 1000);

  ImageEnView2.Proc.Undo;
  ImageEnView2.Proc.RadialStretch(IEStrToFloatDefS(edit1.text, 0), IEStrToFloatDefS(edit2.text, 0), IEStrToFloatDefS(edit3.text, 0), IEStrToFloatDefS(edit4.text, 0),
    IEStrToFloatDefS(edit5.text, 0), IEStrToFloatDefS(edit6.text, 0), IEStrToFloatDefS(edit7.text, 0), IEStrToFloatDefS(edit8.text, 0),
    IEStrToFloatDefS(edit9.text, 0), IEStrToFloatDefS(edit10.text, 0), IEStrToFloatDefS(edit11.text, 0), IEStrToFloatDefS(edit12.text, 0));

end;

// R=G=B
procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  GroupBox2.Enabled:=not CheckBox2.Checked;
  GroupBox3.Enabled:=not CheckBox2.Checked;
end;

end.
