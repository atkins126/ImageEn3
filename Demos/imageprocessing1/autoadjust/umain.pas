unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, ExtCtrls, ComCtrls, hyieutils, imageenproc;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    ImageEnView1: TImageEnView;
    Panel2: TPanel;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Panel3: TPanel;
    Button9: TButton;
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    TabSheet2: TTabSheet;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button8: TButton;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    CheckBox1: TCheckBox;
    TabSheet3: TTabSheet;
    GroupBox3: TGroupBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    TabSheet4: TTabSheet;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Button7: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    ProgressBar1: TProgressBar;
    TabSheet5: TTabSheet;
    Label12: TLabel;
    Edit11: TEdit;
    Button11: TButton;
    TabSheet6: TTabSheet;
    Button10: TButton;
    Label13: TLabel;
    Edit12: TEdit;
    Label14: TLabel;
    Edit13: TEdit;
    TabSheet7: TTabSheet;
    GroupBox1: TGroupBox;
    Label15: TLabel;
    Edit14: TEdit;
    Button12: TButton;
    Label16: TLabel;
    Edit15: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure Button3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
    Filename: string;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormShow(Sender: TObject);
begin
  WindowState := wsMaximized;
  Align := alClient;
  ProgressBar1.Position := 0;
  ImageEnView1.Proc.UndoLimit:=10;
end;

// Undo
procedure TMainForm.Button9Click(Sender: TObject);
begin
  ImageEnView1.Proc.Undo;
  ImageEnView1.Proc.ClearUndo;
end;

// Open...
procedure TMainForm.Button1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
  begin
    FileName:=ExecuteOpenDialog('', '', false, 0, '');
    LoadFromFileAuto(FileName);
  end;
  //ImageEnView1.Fit;
  ProgressBar1.Position := 0;
end;

// Reload
procedure TMainForm.Button2Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFileAuto( FileName );
  ImageEnView1.Fit;
  ProgressBar1.Position := 0;
end;

// Zoom
procedure TMainForm.TrackBar1Change(Sender: TObject);
begin
  ImageEnView1.Zoom:=TrackBar1.Position;
  Label1.Caption:='Zoom ('+inttostr(TrackBar1.Position)+'%)';
end;

// Progress
procedure TMainForm.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position:=per;
end;

// Automatic Image Enhancement-1
procedure TMainForm.Button3Click(Sender: TObject);
begin
  ImageEnView1.Proc.AutoImageEnhance1( strtointdef(Edit1.Text,0),
                                      strtointdef(Edit2.Text,0),
                                      strtointdef(Edit3.Text,0),
                                      strtointdef(Edit4.Text,0)
                                      );
  ProgressBar1.Position := 0;
end;

// Gray World
procedure TMainForm.Button4Click(Sender: TObject);
begin
  ImageEnView1.Proc.WhiteBalance_GrayWorld;
  ProgressBar1.Position := 0;
end;

// Auto White
procedure TMainForm.Button5Click(Sender: TObject);
begin
  ImageEnView1.Proc.WhiteBalance_AutoWhite;
  ProgressBar1.Position := 0;
end;

// Gain Offset
procedure TMainForm.Button6Click(Sender: TObject);
begin
  ImageEnView1.Proc.AdjustGainOffset;
  ProgressBar1.Position := 0;
end;

// Auto sharpen
procedure TMainForm.Button7Click(Sender: TObject);
begin
  ImageEnView1.Proc.AutoSharp( strtointdef(Edit5.Text,0),
                               strtointdef(Edit6.Text,0)/1000
                             );
  ProgressBar1.Position := 0;
end;

// Automatic Image Enhancement-1
procedure TMainForm.Button8Click(Sender: TObject);
begin
  ImageEnView1.Proc.AutoImageEnhance2( strtointdef(edit7.Text,0),
                                       strtointdef(edit8.Text,0),
                                       iestrtofloatdef(edit9.Text,0),
                                       strtointdef(edit10.Text,0),
                                       checkbox1.Checked);
  ProgressBar1.Position := 0;
end;


// Contrast
procedure TMainForm.Button11Click(Sender: TObject);
begin
  ImageEnView1.Proc.Contrast2( strtointdef(edit11.Text,0)/100 );
  ProgressBar1.Position := 0;
end;

// adjust histogram of Luma and saturation
procedure TMainForm.Button10Click(Sender: TObject);
begin
  ImageEnView1.Proc.AdjustLumSatHistogram( strtointdef(edit12.Text,0)/100,
                                           strtointdef(edit13.Text,0)/100 );
  ProgressBar1.Position := 0;
end;

procedure TMainForm.Button12Click(Sender: TObject);
begin
  ImageEnView1.Proc.AutoImageEnhance3( iestrtofloatdef(edit14.Text,0.35),
                                       strtointdef(edit15.Text, 80) );
  ProgressBar1.Position := 0;                                       
end;

end.
