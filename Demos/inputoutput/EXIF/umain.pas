unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ieview, ImageEnView, FileCtrl, StdCtrls, ImageEnIO, ComCtrls,
  ExtCtrls, hyieutils, hyiedefs;

type
  TMainForm = class(TForm)
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    ImageEnView1: TImageEnView;
    ProgressBar1: TProgressBar;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadParameters;
    procedure WriteParameters;
  end;

var
  MainForm: TMainForm;

implementation

uses umakernote;

{$R *.DFM}

// initialize properties grid

procedure TMainForm.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0, 0] := 'Property name';
  StringGrid1.Cells[1, 0] := 'Value';
end;

procedure DecimalToFract(value: double; AllowedDecimals: integer; var num, den: integer);
var
  d, i: integer;
  ex: boolean;
begin
  d := trunc(iepower(10, AllowedDecimals));
  num := trunc(value * d);
  den := d;
  repeat
    ex := true;
    for i := 10 downto 2 do
      if ((num mod i) = 0) and ((den mod i) = 0) then
      begin
        num := num div i;
        den := den div i;
        ex := false;
      end;
  until ex;
end;

function DecimalToFractStr(value: double): string;
var
  num, den: integer;
begin
  DecimalToFract(value, 6, num, den);
  result := inttostr(num) + '/' + inttostr(den);
end;

// load a file

procedure TMainForm.FileListBox1Change(Sender: TObject);
begin
  if IsKnownFormat(FileListBox1.FileName) then
  begin
    // load only parameters
    ImageEnView1.IO.ParamsFromFile(FileListBox1.FileName);
    if assigned(ImageEnView1.IO.Params.EXIF_Bitmap) and not ImageEnView1.IO.Params.EXIF_Bitmap.IsEmpty then
    begin
      // there is a thumbnail, display it
      ImageEnView1.IEBitmap.Assign( ImageEnView1.IO.Params.EXIF_Bitmap );
      ImageEnView1.Update;
    end
    else
    begin
      // we need only a thumbnail (fast load)
      ImageEnView1.IO.Params.GetThumbnail:=true;
      ImageEnView1.io.LoadFromFile(FileListBox1.FileName);
    end;
    ProgressBar1.Position := 0;
    ReadParameters;
  end;
end;

// load progress

procedure TMainForm.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

// save changes

procedure TMainForm.Button1Click(Sender: TObject);
begin
  WriteParameters;
  // inject EXIF in jpeg
  ImageEnView1.io.InjectJpegEXIF(FileListBox1.FileName);
  ProgressBar1.Position := 0;
end;

procedure TMainForm.ReadParameters;
begin
  with StringGrid1, ImageEnView1.IO.Params do
  begin
    Cells[0, 1] := 'ImageDescription';
    Cells[1, 1] := EXIF_ImageDescription;
    Cells[0, 2] := 'Make';
    Cells[1, 2] := EXIF_Make;
    Cells[0, 3] := 'Model';
    Cells[1, 3] := EXIF_Model;
    Cells[0, 4] := 'Orientation';
    Cells[1, 4] := inttostr(EXIF_Orientation);
    Cells[0, 5] := 'XResolution';
    Cells[1, 5] := floattostr(EXIF_XResolution);
    Cells[0, 6] := 'YResolution';
    Cells[1, 6] := floattostr(EXIF_YResolution);
    Cells[0, 7] := 'Software';
    Cells[1, 7] := EXIF_Software;
    Cells[0, 8] := 'DateTime';
    Cells[1, 8] := EXIF_DateTime;
    Cells[0, 9] := 'Copyright';
    Cells[1, 9] := EXIF_Copyright;
    Cells[0, 10] := 'ExposureTime';
    Cells[1, 10] := DecimalToFractStr(EXIF_ExposureTime) + ' sec';
    Cells[0, 11] := 'FNumber';
    Cells[1, 11] := floattostr(EXIF_FNumber);
    Cells[0, 12] := 'ExposureProgram';
    Cells[1, 12] := inttostr(EXIF_ExposureProgram);
    Cells[0, 13] := 'ExifVersion';
    Cells[1, 13] := EXIF_ExifVersion;
    Cells[0, 14] := 'DateTimeOriginal';
    Cells[1, 14] := EXIF_DateTimeOriginal;
    Cells[0, 15] := 'DateTimeDigitized';
    Cells[1, 15] := EXIF_DateTimeDigitized;
    Cells[0, 16] := 'CompressedBitsPerPixel';
    Cells[1, 16] := floattostr(EXIF_CompressedBitsPerPixel);
    Cells[0, 17] := 'ShutterSpeedValue';
    Cells[1, 17] := floattostr(EXIF_ShutterSpeedValue);
    Cells[0, 18] := 'ApertureValue';
    Cells[1, 18] := floattostr(EXIF_ApertureValue);
    Cells[0, 19] := 'BrightnessValue';
    Cells[1, 19] := floattostr(EXIF_BrightnessValue);
    Cells[0, 20] := 'ExposureBiasValue';
    Cells[1, 20] := floattostr(EXIF_ExposureBiasValue);
    Cells[0, 21] := 'MaxApertureValue';
    Cells[1, 21] := floattostr(EXIF_MaxApertureValue);
    Cells[0, 22] := 'SubjectDistance';
    Cells[1, 22] := floattostr(EXIF_SubjectDistance);
    Cells[0, 23] := 'MeteringMode';
    Cells[1, 23] := inttostr(EXIF_MeteringMode);
    Cells[0, 24] := 'LightSource';
    Cells[1, 24] := inttostr(EXIF_LightSource);
    Cells[0, 25] := 'Flash';
    Cells[1, 25] := inttostr(EXIF_Flash);
    Cells[0, 26] := 'FocalLength';
    Cells[1, 26] := floattostr(EXIF_FocalLength);
    Cells[0, 27] := 'SubsecTime';
    Cells[1, 27] := EXIF_SubsecTime;
    Cells[0, 28] := 'SubsecTimeOriginal';
    Cells[1, 28] := EXIF_SubsecTimeOriginal;
    Cells[0, 29] := 'SubsecTimeDigitized';
    Cells[1, 29] := EXIF_SubsecTimeDigitized;
    Cells[0, 30] := 'FlashPixVersion';
    Cells[1, 30] := EXIF_FlashPixVersion;
    Cells[0, 31] := 'ColorSpace';
    Cells[1, 31] := inttostr(EXIF_ColorSpace);
    Cells[0, 32] := 'ExifImageWidth';
    Cells[1, 32] := inttostr(EXIF_ExifImageWidth);
    Cells[0, 33] := 'ExifImageHeight';
    Cells[1, 33] := inttostr(EXIF_ExifImageHeight);
    Cells[0, 34] := 'RelatedSoundFile';
    Cells[1, 34] := EXIF_RelatedSoundFile;
    Cells[0, 35] := 'FocalPlaneXResolution';
    Cells[1, 35] := floattostr(EXIF_FocalPlaneXResolution);
    Cells[0, 36] := 'FocalPlaneYResolution';
    Cells[1, 36] := floattostr(EXIF_FocalPlaneYResolution);
    Cells[0, 37] := 'FocalPlaneResolutionUnit';
    Cells[1, 37] := inttostr(EXIF_FocalPlaneResolutionUnit);
    Cells[0, 38] := 'ExposureIndex';
    Cells[1, 38] := floattostr(EXIF_ExposureIndex);
    Cells[0, 39] := 'SensingMethod';
    Cells[1, 39] := inttostr(EXIF_SensingMethod);
    Cells[0, 40] := 'FileSource';
    Cells[1, 40] := inttostr(EXIF_FileSource);
    Cells[0, 41] := 'SceneType';
    Cells[1, 41] := inttostr(EXIF_SceneType);
    Cells[0, 42] := 'UserComment';
    Cells[1, 42] := EXIF_UserComment;

    Cells[0, 43] := 'XP Title';
    Cells[1, 43] := WideCharToString(PWideChar(EXIF_XPTitle));
    Cells[0, 44] := 'XP Comment';
    Cells[1, 44] := WideCharToString(PWideChar(EXIF_XPComment));
    Cells[0, 45] := 'XP Author';
    Cells[1, 45] := WideCharToString(PWideChar(EXIF_XPAuthor));
    Cells[0, 46] := 'XP Keywords';
    Cells[1, 46] := WideCharToString(PWideChar(EXIF_XPKeywords));
    Cells[0, 47] := 'XP Subject';
    Cells[1, 47] := WideCharToString(PWideChar(EXIF_XPSubject));
  end;
end;

// not still well implemented...

procedure TMainForm.WriteParameters;
begin
  with StringGrid1, ImageEnView1.IO.Params do
  begin
    EXIF_ImageDescription := Cells[1, 1];
    EXIF_Make := Cells[1, 2];
    EXIF_Model := Cells[1, 3];
    EXIF_Orientation := strtointdef(Cells[1, 4], 0);
    EXIF_XResolution := strtointdef(Cells[1, 5], 0);
    EXIF_YResolution := strtointdef(Cells[1, 6], 0);
    EXIF_Software := Cells[1, 7];
    EXIF_DateTime := Cells[1, 8];
    EXIF_Copyright := Cells[1, 9];
    //Cells[1,10]:=DecimalToFractStr(EXIF_ExposureTime)+' sec';
    EXIF_FNumber := strtofloat(Cells[1, 11]);
    EXIF_ExposureProgram := strtointdef(Cells[1, 12], 0);
    EXIF_ExifVersion := Cells[1, 13];
    EXIF_DateTimeOriginal := Cells[1, 14];
    EXIF_DateTimeDigitized := Cells[1, 15];
    //Cells[1,16]:=floattostr(EXIF_CompressedBitsPerPixel);
    //Cells[1,17]:=floattostr(EXIF_ShutterSpeedValue);
    //Cells[1,18]:=floattostr(EXIF_ApertureValue);
    //Cells[1,19]:=floattostr(EXIF_BrightnessValue);
    //Cells[1,20]:=floattostr(EXIF_ExposureBiasValue);
    //Cells[1,21]:=floattostr(EXIF_MaxApertureValue);
    //Cells[1,22]:=floattostr(EXIF_SubjectDistance);
    //Cells[1,23]:=inttostr(EXIF_MeteringMode);
    //Cells[1,24]:=inttostr(EXIF_LightSource);
    //Cells[1,25]:=inttostr(EXIF_Flash);
    //Cells[1,26]:=floattostr(EXIF_FocalLength);
    //Cells[1,27]:=EXIF_SubsecTime;
    //Cells[1,28]:=EXIF_SubsecTimeOriginal;
    //Cells[1,29]:=EXIF_SubsecTimeDigitized;
    //Cells[1,30]:=EXIF_FlashPixVersion;
    //Cells[1,31]:=inttostr(EXIF_ColorSpace);
    EXIF_ExifImageWidth := strtointdef(Cells[1, 32], 0);
    EXIF_ExifImageHeight := strtointdef(Cells[1, 33], 0);
    EXIF_RelatedSoundFile := Cells[1, 34];
    //Cells[1,35]:=floattostr(EXIF_FocalPlaneXResolution);
    //Cells[1,36]:=floattostr(EXIF_FocalPlaneYResolution);
    //Cells[1,37]:=inttostr(EXIF_FocalPlaneResolutionUnit);
    //Cells[1,38]:=floattostr(EXIF_ExposureIndex);
    //Cells[1,39]:=inttostr(EXIF_SensingMethod);
    //Cells[1,40]:=inttostr(EXIF_FileSource);
    //Cells[1,41]:=inttostr(EXIF_SceneType);
    EXIF_XPTitle := Cells[1, 42];
    EXIF_XPComment := Cells[1, 43];
    EXIF_XPAuthor := Cells[1, 44];
    EXIF_XPKeywords := Cells[1, 45];
    EXIF_XPSubject := Cells[1, 46];
  end;
end;

// look maker note
procedure TMainForm.Button2Click(Sender: TObject);
begin
  fMakerNote.ShowModal;
end;

end.
