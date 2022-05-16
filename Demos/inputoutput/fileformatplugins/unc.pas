unit unc;

////////////////////////////////////////////////////////////////////////////////
// UNC file format functions
// features:
//   - can save only pf24bit images (true color)
//   - uncompressed
// note: UNC doesn't really a standard file format

interface

// note: ImageEnIO and hyiedefs required for TIOParamsVals and TProgressRec types
uses Classes, Graphics, ImageEnIO, hyiedefs, hyieutils;

const
  ioUNC = ioUSER + 1; // to get a unique FileType number contact support@hicomponents.com

procedure RegisterUNC;

procedure ReadUNC(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec; Preview: boolean);
procedure WriteUNC(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec);
function TryUNC(Stream: TStream; TryingFormat:TIOFileType): boolean;

implementation

const
  UNCMagic = 'UNCFILEFORMAT';

type
  TUNCHeader = record
    Magic: string[13]; // string 'UNCFILEFORMAT'
    Width: integer;
    Height: integer;
  end;

  pbyte = ^byte;

procedure RegisterUNC;
var
  FileFormatInfo: TIEFileFormatInfo;
begin
  FileFormatInfo := TIEFileFormatInfo.Create;
  with FileFormatInfo do
  begin
    FileType := ioUNC;
    FullName := 'Uncompressed Bitmap';
    Extensions := 'unc;ucp';
    InternalFormat := False;
    DialogPage := [];
    ReadFunction := ReadUNC;
    WriteFunction := WriteUNC;
    TryFunction := TryUNC;
  end;
  IEFileFormatADD(FileFormatInfo);
end;

// Read UNC stream

procedure ReadUNC(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec; Preview: boolean);
var
  UNCHeader: TUNCHeader;
  rl, y: integer;
begin
  // read and verify header
  Stream.Read(UNCHeader, sizeof(TUNCHeader));
  if UNCHeader.Magic <> UNCMagic then
  begin
    Progress.Aborting^ := true;
    exit;
  end;
  // set bitmap type and size
  Bitmap.Allocate(UNCHeader.Width, UNCHeader.Height, ie24RGB);
  // set IOparams
  IOParams.BitsPerSample := 8;
  IOParams.SamplesPerPixel := 3;
  IOParams.Width := UNCHeader.Width;
  IOParams.Height := UNCHeader.Height;
  // load images if needed
  if not Preview then
  begin
    // reset progress status
    Progress.per1 := 100 / Bitmap.Height;
    Progress.val := 0;
    // calc row length
    rl := abs(integer(Bitmap.Scanline[0]) - integer(Bitmap.Scanline[1]));
    // read rows
    for y := 0 to Bitmap.Height - 1 do
    begin
      Stream.Read(pbyte(Bitmap.Scanline[y])^, rl);
      // OnProgress
      with Progress do
      begin
        inc(val);
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * val));
      end;
    end;
  end;
end;

// Write UNC stream

procedure WriteUNC(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec);
var
  UNCHeader: TUNCHeader;
  rl, y: integer;
begin
  if Bitmap.PixelFormat <> ie24RGB then
  begin
    // really you should consider IOParams to know how the user want to save
      // the image (read SamplesPerPixel and BitsPerSample)
    Progress.Aborting^ := True;
    exit;
  end;
  // write header
  with UNCHeader do
  begin
    Magic := 'UNCFILEFORMAT';
    Width := Bitmap.Width;
    Height := Bitmap.Height;
  end;
  Stream.Write(UNCHeader, sizeof(TUNCHeader));
  // reset progress status
  Progress.per1 := 100 / Bitmap.Height;
  Progress.val := 0;
  // calc row length
  rl := abs(integer(Bitmap.Scanline[0]) - integer(Bitmap.Scanline[1]));
  // write rows
  for y := 0 to Bitmap.Height - 1 do
  begin
    Stream.Write(pbyte(Bitmap.Scanline[y])^, rl);
    // OnProgress
    with Progress do
    begin
      inc(val);
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * val));
    end;
  end;
end;

// Verifies if stream contains an UNC file format

function TryUNC(Stream: TStream; TryingFormat:TIOFileType): boolean;
var
  UNCHeader: TUNCHeader;
begin
  // read and verify header
  Stream.Read(UNCHeader, sizeof(TUNCHeader));
  result := UNCHeader.Magic = UNCMagic;
end;

end.
