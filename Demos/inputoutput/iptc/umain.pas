unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ieview, ImageEnView, FileCtrl, StdCtrls, ImageEnIO, ComCtrls,
  ExtCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Panel2: TPanel;
    ImageEnView1: TImageEnView;
    ProgressBar1: TProgressBar;
    DriveComboBox1: TDriveComboBox;
    DirectoryListBox1: TDirectoryListBox;
    FileListBox1: TFileListBox;
    Button1: TButton;
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
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

type
  iptc_item = record
    r: integer;
    d: integer;
    s: string;
  end;

const
  iptc: array[0..30] of iptc_item = (
    (r: 2; d: 5; s: 'Object name'),
    (r: 2; d: 120; s: 'Caption/Abstract'),
    (r: 2; d: 25; s: 'Keywords'),
    (r: 2; d: 40; s: 'Special Instructions'),
    (r: 2; d: 55; s: 'Date Created (CCYYMMDD)'),
    (r: 2; d: 60; s: 'Time Created (HHMMSS±HHMM)'),
    (r: 2; d: 80; s: 'By-line'),
    (r: 2; d: 85; s: 'By-line'),
    (r: 2; d: 90; s: 'City'),
    (r: 2; d: 95; s: 'Province/State'),
    (r: 2; d: 100; s: 'Country/Primary Location Code'),
    (r: 2; d: 101; s: 'Country/Primary Location Name'),
    (r: 2; d: 103; s: 'Original Transmission Reference'),
    (r: 2; d: 110; s: 'Credit'),
    (r: 2; d: 115; s: 'Source'),
    (r: 2; d: 122; s: 'Writer/Editor'),
    (r: 2; d: 7; s: 'Edit status'),
    (r: 2; d: 10; s: 'Urgency'),
    (r: 2; d: 15; s: 'Category'),
    (r: 2; d: 20; s: 'Supplemental Category'),
    (r: 2; d: 22; s: 'Fixture Identifier'),
    (r: 2; d: 30; s: 'Release Date (CCYYMMDD)'),
    (r: 2; d: 35; s: 'Release Time (HHMMSS±HHMM)'),
    (r: 2; d: 45; s: 'Reference Service'),
    (r: 2; d: 47; s: 'Reference Date (CCYYMMDD)'),
    (r: 2; d: 50; s: 'Reference Number'),
    (r: 2; d: 65; s: 'Originating Program'),
    (r: 2; d: 70; s: 'Program Version'),
    (r: 2; d: 75; s: 'Object Cycle (a=morning, b=evening, c=both)'),
    (r: 2; d: 116; s: 'Copyright Notice'),
    (r: 2; d: 130; s: 'Image Type'));

  // initialize properties grid

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  StringGrid1.Cells[0, 0] := 'Property name';
  StringGrid1.Cells[1, 0] := 'Value';
  for i := 0 to high(iptc) do
    StringGrid1.Cells[0, i + 1] := iptc[i].s;
end;

// load a file

procedure TForm1.FileListBox1Change(Sender: TObject);
var
  i,j,k: integer;
begin
  if IsKnownFormat(FileListBox1.FileName) then
  begin
    // we need only a thumbnail (fast load)
    ImageEnView1.io.Params.Width := ImageEnView1.Width;
    ImageEnView1.io.Params.Height := ImageEnView1.Height;
    ImageEnView1.io.Params.JPEG_Scale := ioJPEG_AUTOCALC;
    ImageEnView1.io.LoadFromFile(FileListBox1.FileName);
    ProgressBar1.Position := 0;
    // read IPTC
    for i := 0 to high(iptc) do
      with ImageEnView1.io.Params.IPTC_Info do
      begin
        k:=IndexOf(iptc[i].r, iptc[i].d);
        if k>=0 then
        begin
          // tag found
          StringGrid1.Cells[1, i + 1] := StringItem[k];
          // look for other fields with the same recordnumber and dataset
          for j:=k+1 to Count-1 do
            if (RecordNumber[j]=iptc[i].r) and (DataSet[j]=iptc[i].d) then
              StringGrid1.Cells[1, i + 1] := StringGrid1.Cells[1, i + 1] + '; '+StringItem[j];
        end
        else
          StringGrid1.Cells[1,i+1]:='';
      end;

  end;
end;

// load progress

procedure TForm1.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

function CreateList(const ss:string):TStringList;
var
  i:integer;
  si:string;
begin
  si:='';
  result:=TStringList.Create;
  for i:=1 to length(ss) do
    if ss[i]=';' then
    begin
      result.Add(trim(si));
      si:='';
    end
    else
      si:=si+ss[i];
  if si<>'' then
    result.Add(trim(si));
end;

// save changes

procedure TForm1.Button1Click(Sender: TObject);
var
  i, j: integer;
  sl:TStringList;
begin
  // clear old IPTC values
  ImageEnView1.IO.Params.IPTC_Info.Clear;
  // load values from the properties grid
  for i := 0 to high(iptc) do
    with ImageEnView1.io.Params.IPTC_Info do
    begin
      sl:=CreateList( StringGrid1.Cells[1, i + 1] );
      for j:=0 to sl.Count-1 do
        if sl[j]<>'' then
          AddStringItem(iptc[i].r, iptc[i].d, sl[j]);
      sl.free;
    end;
  case ImageEnView1.io.Params.FileType of
    ioJPEG:
      // inject iptc in jpeg
      ImageEnView1.io.InjectJpegIPTC(FileListBox1.FileName);
    ioTIFF:
      // save iptc in TIFF
      ImageEnView1.io.SaveToFile(FileListBox1.FileName);
  end;
  ProgressBar1.Position := 0;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
begin
  ImageEnView1.io.Params.IPTC_Info.Clear;
  for i := 0 to high(iptc) do
    StringGrid1.Cells[1, i + 1] := '';
end;

end.
