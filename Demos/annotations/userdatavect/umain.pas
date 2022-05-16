unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, ievect, ExtCtrls, imageenio, Buttons;

type
  TMyData=record
    text1:string[255];
    text2:string[255];
  end;
  PMyData=^TMyData;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    ImageEnVect1: TImageEnVect;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ComboBox1: TComboBox;
    SpeedButton1: TSpeedButton;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
    procedure ImageEnVect1ObjectOver(Sender: TObject; hobj: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ComboBox1.ItemIndex:=0;
  ImageEnVect1.MouseInteractVt:=[miObjectSelect];
  ImageEnVect1.MaxSelectionDistance:=10;
end;

// Open
procedure TMainForm.Button1Click(Sender: TObject);
var
  filename:string;
begin
  if OpenDialog1.Execute then
  begin
    filename:=OpenDialog1.FileName;
    if IsKnownFormat(filename) then
      ImageEnVect1.IO.LoadFromFile(filename)
    else
      ImageEnVect1.LoadFromFileAll(filename);
  end;
end;

// Save
procedure TMainForm.Button2Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    ImageEnVect1.SaveToFileAll(SaveDialog1.FileName,-1);
end;

// Add new object
procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
  begin
    case ComboBox1.ItemIndex of
      0: ImageEnVect1.MouseInteractVt:=[miPutLine];
      1: ImageEnVect1.MouseInteractVt:=[miPutBox];
      2: ImageEnVect1.MouseInteractVt:=[miPutEllipse];
      3: ImageEnVect1.MouseInteractVt:=[miPutBitmap];
      4: ImageEnVect1.MouseInteractVt:=[miPutText];
      5: ImageEnVect1.MouseInteractVt:=[miPutRuler];
      6: ImageEnVect1.MouseInteractVt:=[miPutPolyline];
      7: ImageEnVect1.MouseInteractVt:=[miPutAngle];
      8: ImageEnVect1.MouseInteractVt:=[miPutMemo];
    end;
  end
  else
    ImageEnVect1.MouseInteractVt:=[miObjectSelect];

  ImageEnVect1.PolylineEndingMode:=ieemMouseUp;
end;

// New object created. Create new info
procedure TMainForm.ImageEnVect1NewObject(Sender: TObject; hobj: Integer);
var
  mydata:PMyData;
begin
  getmem(mydata, sizeof(TMyData));

  mydata^.text1:=Edit1.Text;
  mydata^.text2:=Edit2.Text;

  ImageEnVect1.ObjUserData[hobj]:=mydata;
  ImageEnVect1.ObjUserDataLength[hobj]:=sizeof(TMyData);
end;

procedure TMainForm.ImageEnVect1ObjectOver(Sender: TObject; hobj: Integer);
var
  mydata:PMyData;
begin
  mydata:=ImageEnVect1.ObjUserData[ hobj ];
  if mydata<>nil then
  begin
    Edit1.Text:=mydata.text1;
    Edit2.Text:=mydata.text2;
  end;
end;

end.
