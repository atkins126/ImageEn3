unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, imageenio;

type
  TMainForm = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenFile1: TMenuItem;
    OpenRAW1: TMenuItem;
    N1: TMenuItem;
    SaveFile1: TMenuItem;
    SaveRAW1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    ConvertPixelFormat1: TMenuItem;
    procedure OpenFile1Click(Sender: TObject);
    procedure SaveFile1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure OpenRAW1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveRAW1Click(Sender: TObject);
    procedure ConvertPixelFormat1Click(Sender: TObject);
  private
    { Private declarations }
    function SetRAWParameters(IsReading:boolean):boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses uraw, hyieutils, uconvert;

{$R *.DFM}

const
  // warning! If you change PixelFormat combobox colors order you must change this.
  ItemIndex2PixelFormat:array [0..7] of TIEPixelFormat = (ie1g,ie8g,ie16g,ie32f,ie8p,ie24RGB,ieCMYK,ie48RGB);
  PixelFormat2ItemIndex:array [ie1g..ie48RGB] of integer = (0,4,1,2,5,3,6,7);


// this is important!
procedure TMainForm.FormCreate(Sender: TObject);
begin
  // we cannot use Windows Bitmaps!
  ImageEnView1.LegacyBitmap:=False;
  // do not convert pixels formats to 1 bit or 24 bit!
  ImageEnView1.IO.NativePixelFormat:=True;
end;

// Open File
procedure TMainForm.OpenFile1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    LoadFromFileAuto( ExecuteOpenDialog('','',true,0,'') );
end;

// Save File
procedure TMainForm.SaveFile1Click(Sender: TObject);
begin
  with ImageEnView1.IO do
    SaveToFile( ExecuteSaveDialog('','',true,0,'') );
end;

// Exit
procedure TMainForm.Exit1Click(Sender: TObject);
begin
  Close;
end;

function TMainForm.SetRAWParameters(IsReading:boolean):boolean;
var
  PixelFormat:TIEPixelFormat;
  ImageWidth,ImageHeight:integer;
begin

  fRAW.PixelFormat.Enabled:=IsReading;
  fRAW.ImageWidth.Enabled :=IsReading;
  fRAW.ImageHeight.Enabled:=IsReading;
  if not IsReading then
  begin
    // when writing PixelFormat,Width and Height are not settable, because they must comes from current bitmap
    fRAW.PixelFormat.ItemIndex := PixelFormat2ItemIndex[ ImageEnView1.IEBitmap.PixelFormat ];
    fRAW.ImageWidth.Text := IntToStr( ImageEnView1.IEBitmap.Width );
    fRAW.ImageHeight.Text := IntToStr( ImageEnView1.IEBitmap.Height );
  end;

  result:=fRAW.ShowModal = mrOK;
  
  if result then
  begin

    if IsReading then
    begin
      // when reading user can choise PixelFormat, Width and Height
      PixelFormat:=ItemIndex2PixelFormat[ fRAW.PixelFormat.ItemIndex ];
      ImageWidth := StrToIntDef( fRAW.ImageWidth.Text,0 );
      ImageHeight:= StrToIntDef( fRAW.ImageHeight.Text,0 );
      ImageEnView1.IEBitmap.Allocate( ImageWidth, ImageHeight, PixelFormat );
    end;

    ImageEnView1.IO.Params.BMPRAW_HeaderSize := StrToIntDef( fRAW.HeaderSize.Text, 0);

    case fRAW.ColorOrder.ItemIndex of
      0: ImageEnView1.IO.Params.BMPRAW_ChannelOrder := coRGB;
      1: ImageEnView1.IO.Params.BMPRAW_ChannelOrder := coBGR;
    end;

    case fRAW.ColorPlanes.ItemIndex of
      0: ImageEnView1.IO.Params.BMPRAW_Planes := plInterleaved;
      1: ImageEnView1.IO.Params.BMPRAW_Planes := plPlanar;
    end;

    case fRAW.DataFormat.ItemIndex of
      0: ImageEnView1.IO.Params.BMPRAW_DataFormat := dfBinary;
      1: ImageEnView1.IO.Params.BMPRAW_DataFormat := dfTextDecimal;
      2: ImageEnView1.IO.Params.BMPRAW_DataFormat := dfTextHex;
    end;

    ImageEnView1.IO.Params.BMPRAW_RowAlign := StrToIntDef( fRAW.RowAlign.Text, 0);

  end;
end;

// Open RAW
procedure TMainForm.OpenRAW1Click(Sender: TObject);
begin
  if SetRAWParameters(true) then
    with ImageEnView1.IO do
      LoadFromFileBMPRAW( ExecuteOpenDialog('','',true,2,'') );
end;

// Save RAW
procedure TMainForm.SaveRAW1Click(Sender: TObject);
begin
  if SetRAWParameters(false) then
    with ImageEnView1.IO do
      SaveToFileBMPRAW( ExecuteSaveDialog('','',true,19,'Real RAW|*.raw') );
end;

// Convert Pixel Format
procedure TMainForm.ConvertPixelFormat1Click(Sender: TObject);
begin
  fConvert.SourcePixelFormat.ItemIndex := PixelFormat2ItemIndex[ ImageEnView1.IEBitmap.PixelFormat ];
  fConvert.DestPixelFormat.ItemIndex := fConvert.SourcePixelFormat.ItemIndex;
  if fConvert.ShowModal = mrOK then
  begin
    ImageEnView1.IEBitmap.PixelFormat := ItemIndex2PixelFormat[ fConvert.DestPixelFormat.ItemIndex ];
    ImageEnView1.Update;
  end;
end;

end.
