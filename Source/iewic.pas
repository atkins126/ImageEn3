(*
Copyright (c) 1998-2010 by HiComponents. All rights reserved.

This software comes without express or implied warranty.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE.

ImageEn, IEvolution and ImageEn ActiveX may not be included in any
commercial, shareware or freeware libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com
*)

(*
File version 1004
*)

unit iewic;

{$R-}
{$Q-}

{$I ie.inc}

{$IFDEF IEINCLUDEWIC}

interface

uses Windows, Messages, SysUtils, Classes, ActiveX, Graphics, Controls, imageenio, hyiedefs, hyieutils, ieds, iewia, dialogs;


procedure IEHDPRead(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean);
procedure IEHDPWrite(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec);
function IEHDPFrameCount(const FileName:WideString):integer;
function IEWICAvailable:boolean;

type


IE_ProgressNotificationCallback=function(pvData:pointer; uFrameNum:dword; operation:dword; dblProgress:double):HResult; stdcall;


IE_IWICBitmapCodecProgressNotification = interface(IUnknown)
  ['{64C1024E-C3CF-4462-8078-88C2B11C46D9}']
  function RegisterProgressNotification(pfnProgressNotification:IE_ProgressNotificationCallback; pvData:pointer; dwProgressFlags:dword):HResult; stdcall;
end;


IE_IWICStream = interface(IStream)
  ['{135FF860-22B7-4ddf-B0F6-218F4F299A43}']
  function InitializeFromIStream(pIStream:IIEStream):HResult; stdcall;
  function InitializeFromFilename(wzFileName:pwchar; dwDesiredAccess:dword):HResult; stdcall;
  function InitializeFromMemory(pbBuffer:pbyte; cbBufferSize:dword):HResult; stdcall;
  function InitializeFromIStreamRegion:HResult; stdcall;
end;


IE_WICRect = record
  X:longint;
  Y:longint;
  Width:longint;
  Height:longint;
end;


IE_IWICBitmapSource = interface(IUnknown)
  ['{00000120-a8f2-4877-ba0a-fd2b6645fb94}']
  function GetSize(var puiWidth:longint; var puiHeight:longint):HResult; stdcall;
  function GetPixelFormat(var pPixelFormat:TGUID):HResult; stdcall;
  function GetResolution(var pDpiX:double; var pDpiY:double):HResult; stdcall;
  function CopyPalette:HResult; stdcall;
  function CopyPixels(const prc:IE_WICRect; cbStride:dword; cbBufferSize:dword; pbBuffer:pbyte):HResult; stdcall;
end;


IE_IWICPalette = interface(IUnknown)
  ['{00000040-a8f2-4877-ba0a-fd2b6645fb94}']
  function InitializePredefined:HResult; stdcall;
  function InitializeCustom:HResult; stdcall;
  function InitializeFromBitmap:HResult; stdcall;
  function InitializeFromPalette:HResult; stdcall;
  function GetType:HResult; stdcall;
  function GetColorCount:HResult; stdcall;
  function GetColors:HResult; stdcall;
  function IsBlackWhite:HResult; stdcall;
  function IsGrayscale:HResult; stdcall;
  function HasAlpha:HResult; stdcall;
end;


IE_IWICFormatConverter = interface(IE_IWICBitmapSource)
  ['{00000301-a8f2-4877-ba0a-fd2b6645fb94}']
  function Initialize(pISource:IE_IWICBitmapSource; var dstFormat:TGUID; dither:dword; pIPalette:IE_IWICPalette; alphaThresholdPercent:double; paletteTranslate:dword):HResult; stdcall;
  function CanConvert:HResult; stdcall;
end;


IE_IWICMetadataQueryReader = interface(IUnknown)
  ['{30989668-E1C9-4597-B395-458EEDB808DF}']
  function GetContainerFormat:HResult; stdcall;
  function GetLocation:HResult; stdcall;
  function GetMetadataByName(wzName:pwchar; var pvarValue:PROPVARIANT):HResult; stdcall;
  function GetEnumerator:HResult; stdcall;
end;


IE_IWICMetadataQueryWriter = interface(IE_IWICMetadataQueryReader)
  ['{A721791A-0DEF-4d06-BD91-2118BF1DB10B}']
  function SetMetadataByName(wzName:pwchar; const pvarValue:PROPVARIANT):HResult; stdcall;
  function RemoveMetadataByName(wzName:pwchar):HResult; stdcall;
end;


IE_IWICBitmapFrameDecode = interface(IE_IWICBitmapSource)
  ['{3B16811B-6A43-4ec9-A813-3D930C13B940}']
  function GetMetadataQueryReader(var ppIMetadataQueryReader:IE_IWICMetadataQueryReader):HResult; stdcall;
  function GetColorContexts:HResult; stdcall;
  function GetThumbnail(var ppIThumbnail:IE_IWICBitmapSource):HResult; stdcall;
end;


IE_IWICBitmapDecoder = interface(IUnknown)
  ['{9EDDE9E7-8DEE-47ea-99DF-E6FAF2ED44BF}']
  function QueryCapability:HResult; stdcall;
  function Initialize:HResult; stdcall;
  function GetContainerFormat:HResult; stdcall;
  function GetDecoderInfo:HResult; stdcall;
  function CopyPalette:HResult; stdcall;
  function GetMetadataQueryReader:HResult; stdcall;
  function GetPreview:HResult; stdcall;
  function GetColorContexts:HResult; stdcall;
  function GetThumbnail:HResult; stdcall;
  function GetFrameCount(var pCount:longint):HResult; stdcall;
  function GetFrame(index:dword; var ppIBitmapFrame:IE_IWICBitmapFrameDecode):HResult; stdcall;
end;


IE_PROPBAG2 = record
  dwType:dword;
  vt:word;
  cfType:word;
  dwHint:dword;
  pstrName:pwchar;
  clsid:TGUID;
end;

IE_PPROPBAG2 = ^IE_PROPBAG2;

IE_PPROPVARIANT = ^PROPVARIANT;

IE_IPropertyBag2 = interface(IUnknown)
  ['{22F55882-280B-11d0-A8A9-00A0C90C2004}']
  function Read:HResult; stdcall;
  function Write(cProperties:dword; pPropBag:IE_PPROPBAG2; pvarValue:IE_PPROPVARIANT):HResult; stdcall;
  function CountProperties:HResult; stdcall;
  function GetPropertyInfo:HResult; stdcall;
  function LoadObject:HResult; stdcall;
end;


IE_IWICBitmapFrameEncode = interface(IUnknown)
  ['{00000105-a8f2-4877-ba0a-fd2b6645fb94}']
  function Initialize(pIEncoderOptions:IE_IPropertyBag2):HResult; stdcall;
  function SetSize(uiWidth:dword; uiHeight:dword):HResult; stdcall;
  function SetResolution(dpiX:double; dpiY:double):HResult; stdcall;
  function SetPixelFormat(const pPixelFormat:TGUID):HResult; stdcall;
  function SetColorContexts:HResult; stdcall;
  function SetPalette:HResult; stdcall;
  function SetThumbnail:HResult; stdcall;
  function WritePixels(lineCount:dword; cbStride:dword; cbBufferSize:dword; pbPixels:pbyte):HResult; stdcall;
  function WriteSource:HResult; stdcall;
  function Commit:HResult; stdcall;
  function GetMetadataQueryWriter(var ppIMetadataQueryWriter:IE_IWICMetadataQueryWriter):HResult; stdcall;
end;


IE_IWICBitmapEncoder = interface(IUnknown)
  ['{00000103-a8f2-4877-ba0a-fd2b6645fb94}']
  function Initialize(pIStream:IStream; cacheOption:dword):HResult; stdcall;
  function GetContainerFormat:HResult; stdcall;
  function GetEncoderInfo:HResult; stdcall;
  function SetColorContexts:HResult; stdcall;
  function SetPalette:HResult; stdcall;
  function SetThumbnail:HResult; stdcall;
  function SetPreview:HResult; stdcall;
  function CreateNewFrame(var ppIFrameEncode:IE_IWICBitmapFrameEncode; var ppIEncoderOptions:IE_IPropertyBag2):HResult; stdcall;
  function Commit:HResult; stdcall;
  function GetMetadataQueryWriter:HResult; stdcall;
end;


IE_IWICImagingFactory = interface(IUnknown)
  ['{ec5ec8a9-c395-4314-9c77-54d7a935ff70}']
  function CreateDecoderFromFilename:HResult; stdcall;
  function CreateDecoderFromStream(pIStream:IStream; const pguidVendor:TGUID; metadataOptions:dword; var ppIDecoder:IE_IWICBitmapDecoder):HResult; stdcall;
  function CreateDecoderFromFileHandle:HResult; stdcall;
  function CreateComponentInfo:HResult; stdcall;
  function CreateDecoder(const guidContainerFormat:TGuid; const pguidVendor:TGuid; var ppIDecoder:IE_IWICBitmapDecoder):HResult; stdcall;
  function CreateEncoder(const guidContainerFormat:TGUID; const pguidVendor:TGUID; var ppIEncoder:IE_IWICBitmapEncoder):HResult; stdcall;
  function CreatePalette:HResult; stdcall;
  function CreateFormatConverter(var ppIFormatConverter:IE_IWICFormatConverter):HResult; stdcall;
  function CreateBitmapScaler:HResult; stdcall;
  function CreateBitmapClipper:HResult; stdcall;
  function CreateBitmapFlipRotator:HResult; stdcall;
  function CreateStream(var ppIWICStream:IE_IWICStream):HResult; stdcall;
  function CreateColorContext:HResult; stdcall;
  function CreateColorTransformer:HResult; stdcall;
  function CreateBitmap:HResult; stdcall;
  function CreateBitmapFromSource:HResult; stdcall;
  function CreateBitmapFromSourceRect:HResult; stdcall;
  function CreateBitmapFromMemory:HResult; stdcall;
  function CreateBitmapFromHBITMAP:HResult; stdcall;
  function CreateBitmapFromHICON:HResult; stdcall;
  function CreateComponentEnumerator:HResult; stdcall;
  function CreateFastMetadataEncoderFromDecoder:HResult; stdcall;
  function CreateFastMetadataEncoderFromFrameDecode:HResult; stdcall;
  function CreateQueryWriter:HResult; stdcall;
  function CreateQueryWriterFromReader:HResult; stdcall;
end;


{!!
<FS>TIEWICTIFFCompressionMethod

<FM>Declaration<FC>
TIEWICTIFFCompressionMethod = (ieWICTiffCompressionNone, ieWICTiffCompressionCCITT3, ieWICTiffCompressionCCITT4, ieWICTiffCompressionLZW, ieWICTiffCompressionRLE, ieWICTiffCompressionZIP);

<FM>Description<FN>
Specifies the Tagged Image File Format (TIFF) compression options.

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>ieWICTiffCompressionNone<FN></C> <C>No compression.</C> </R>
<R> <C><FC>ieWICTiffCompressionCCITT3<FN></C> <C>A CCITT3 compression algorithm. This algorithm is only valid for 1bpp pixel formats.</C> </R>
<R> <C><FC>ieWICTiffCompressionCCITT4<FN></C> <C>A CCITT4 compression algorithm. This algorithm is only valid for 1bpp pixel formats.</C> </R>
<R> <C><FC>ieWICTiffCompressionLZW<FN></C> <C>A LZW compression algorithm.</C> </R>
<R> <C><FC>ieWICTiffCompressionRLE<FN></C> <C>A RLE compression algorithm. This algorithm is only valid for 1bpp pixel formats.</C> </R>
<R> <C><FC>ieWICTiffCompressionZIP<FN></C> <C>A ZIP compression algorithm.</C> </R>
</TABLE>
!!}
TIEWICTIFFCompressionMethod = (
  ieWICTiffCompressionDontCare , // don't use
	ieWICTiffCompressionNone,
	ieWICTiffCompressionCCITT3,
	ieWICTiffCompressionCCITT4,
	ieWICTiffCompressionLZW,
	ieWICTiffCompressionRLE,
	ieWICTiffCompressionZIP);


{!!
<FS>TIEWICReader

<FM>Description<FN>
TIEWICReader class encapsulates some Microsoft Windows Imaging Component (WIC) interfaces and allows to load Microsoft HD Photo and other WIC installed file formats.
WIC preinstalled decoders are TIFF, PNG, GIF, ICO, BMP, JPEG, HDP.
Requires: Windows XP (SP2) with .Net 3.0, Windows Vista.

<FM>Examples<FC>
// loads input.hdp in ImageEnView1, the same of ImageEnView1.IO.LoadFromFile('input.hdp')
with TIEWICReader.Create do
begin
  Open('input.hdp', ioHDP);
  GetFrame(0, ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free;
end;
ImageEnView1.Update;

// loads input.jpg in ImageEnView1
with TIEWICReader.Create do
begin
  Open('input.jpg', ioJPEG);
  GetFrame(0, ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free;
end;
ImageEnView1.Update;


// loads page 2 from input.tif to ImageEnView1
with TIEWICReader.Create do
begin
  Open('input.tif', ioTIFF);
  GetFrame(2, ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free;
end;
ImageEnView1.Update;



<FM>Methods and Properties<FN>

  <A TIEWICReader.Close>
  <A TIEWICReader.DPIX>
  <A TIEWICReader.DPIY>
  <A TIEWICReader.FrameCount>
  <A TIEWICReader.FrameHeight>
  <A TIEWICReader.FrameWidth>
  <A TIEWICReader.GetFrame>
  <A TIEWICReader.IsAvailable>
  <A TIEWICReader.Open>
!!}
TIEWICReader = class
private
  fOLEInitialized:boolean;
  fWICImagingFactory:IE_IWICImagingFactory;
  fDecoder:IE_IWICBitmapDecoder;
  fFrame:IE_IWICBitmapFrameDecode;
  fQueryReader:IE_IWICMetadataQueryReader;
  fDPIX:double;
  fDPIY:double;
  fStream:TStream;
  fStreamBase:int64;
  fFileStream:TIEWideFileStream;
  function GetFrameCount:integer;

protected
  procedure CopyWICBitmapToIEBitmap(source:IE_IWICBitmapSource; dest:TIEBitmap; nativePixelFormat:boolean);

public

  constructor Create;
  destructor Destroy; override;

  function IsAvailable:boolean;

  function Open(Stream:TStream; fileType:TIOFileType):boolean; overload;
  function Open(const FileName:WideString; fileType:TIOFileType):boolean; overload;
  procedure Close;

  procedure GetFrame(frameIndex:integer; destBitmap:TIEBitmap; IOParams:TIOParamsVals=nil; Aborting:pboolean=nil);
  property FrameCount:integer read GetFrameCount;
  function FrameWidth:integer;  // call after GetFrame
  function FrameHeight:integer; // call after GetFrame

{!!
<FS>TIEWICReader.DPIX

<FM>Declaration<FC>
property DPIX:double;

<FM>Description<FN>
X-axis dots per inch (dpi) resolution. This property is filled by <A TIEWICReader.GetFrame> method.

See also <A TIEWICReader.DPIY>
!!}
  property DPIX:double read fDPIX write fDPIX;

{!!
<FS>TIEWICReader.DPIY

<FM>Declaration<FC>
property DPIY:double;

<FM>Description<FN>
Y-axis dots per inch (dpi) resolution. This property is filled by <A TIEWICReader.GetFrame> method.

See also <A TIEWICReader.DPIX>
!!}
  property DPIY:double read fDPIY write fDPIY;

  function QueryMetadata(const query:string):PROPVARIANT;

end;




{!!
<FS>TIEWICWriter

<FM>Description<FN>
TIEWICWriter class encapsulates some Microsoft Windows Imaging Component (WIC) interfaces and allows to write Microsoft HD Photo and other WIC installed file formats.
WIC preinstalled encoders are TIFF, PNG, GIF, BMP, JPEG, HDP.
Requires: Windows XP (SP2) with .Net 3.0, Windows Vista.

<FM>Examples<FC>
// saves ImageEnView1 to output.hdp, the same of ImageEnView1.IO.SaveToFile('output.hdp')
with TIEWICWriter.Create do
begin
  Open('output.hdp', ioHDP);
  PutFrame(ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free;
end;

// saves ImageEnView1 to output.jpg
with TIEWICWriter.Create do
begin
  Open('output.jpg', ioJPEG);
  PutFrame(ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free;
end;

// saves ImageEnView1 and ImageEnView2 as two pages in output.tif
with TIEWICWriter.Create do
begin
  Open('output.tif', ioTIFF);
  PutFrame(ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  PutFrame(ImageEnView2.IEBitmap, ImageEnView2.IO.Params);
  Free;
end;



<FM>Methods and Properties<FN>

  <A TIEWICWriter.Close>
  <A TIEWICWriter.DPIX>
  <A TIEWICWriter.DPIY>
  <A TIEWICWriter.IsAvailable>
  <A TIEWICWriter.Open>
  <A TIEWICWriter.PutFrame>

  <FI>Canonical Encoder Parameter Properties<FN>
  <A TIEWICWriter.CompressionQuality>
  <A TIEWICWriter.ImageQuality>
  <A TIEWICWriter.Lossless>

  <FI>Specific HD Photo encoder parameter properties<FN>
  <A TIEWICWriter.FrequencyOrder>
  <A TIEWICWriter.HorizontalTileSlices>
  <A TIEWICWriter.Overlap>
  <A TIEWICWriter.Quality>
  <A TIEWICWriter.Subsampling>
  <A TIEWICWriter.UseCodecOptions>
  <A TIEWICWriter.VerticalTileSlices>
!!}
TIEWICWriter = class
private
  fOLEInitialized:boolean;
  fWICImagingFactory: IE_IWICImagingFactory;
  fEncoder:IE_IWICBitmapEncoder;
  fDPIX:double;
  fDPIY:double;
  fImageQuality:double;       // -1 = encoder default
  fCompressionQuality:double; // -1 = encoder default
  fLossless:boolean;
  fUseCodecOptions:boolean;
  fQuality:integer;           // enabled if fUseCodecOptions=true
  fOverlap:integer;           // enabled if fUseCodecOptions=true
  fSubsampling:integer;       // enabled if fUseCodecOptions=true
  fHorizontalTileSlices:integer;
  fVerticalTileSlices:integer;
  fFrequencyOrder:boolean;
  fTIFFCompressionMethod:TIEWICTIFFCompressionMethod;
  fStream:TStream;
  fStreamBase:int64;
  fFileStream:TIEWideFileStream;

protected

public
  constructor Create;
  destructor Destroy; override;

  function IsAvailable:boolean;

  function Open(const FileName:WideString; fileType:TIOFileType):boolean; overload;
  function Open(Stream:TStream; fileType:TIOFileType):boolean; overload;
  procedure Close;

  procedure PutFrame(srcBitmap:TIEBitmap; IOParams:TIOParamsVals = nil);

{!!
<FS>TIEWICWriter.DPIX

<FM>Declaration<FC>
property DPIX:double;

<FM>Description<FN>
X-axis dots per inch (dpi) resolution. You have to set this property before each <A TIEWICWriter.PutFrame> call.

See also <A TIEWICWriter.DPIY>
!!}
  property DPIX:double read fDPIX write fDPIX;

{!!
<FS>TIEWICWriter.DPIY

<FM>Declaration<FC>
property DPIY:double;

<FM>Description<FN>
Y-axis dots per inch (dpi) resolution. You have to set this property before each <A TIEWICWriter.PutFrame> call.

See also <A TIEWICWriter.DPIX>
!!}
  property DPIY:double read fDPIY write fDPIY;

  //// Canonical Encoder Parameter Properties ////

{!!
<FS>TIEWICWriter.ImageQuality

<FM>Declaration<FC>
property ImageQuality:double;

<FM>Description<FN>
0.0 specifies the lowest possible fidelity rendition and 1.0 specifies the highest fidelity, which for HD Photo results in mathematically lossless compression.
You have to set this property before each <A TIEWICWriter.PutFrame> call.

<FM>Example<FC>
with TIEWICWriter.Create do
begin
  Open('output.hdp', ioHDP);
  ImageQuality := 0.7;
  PutFrame(ImageEnView1.IEBitmap);
  Free;
end;
!!}
  property ImageQuality:double read fImageQuality write fImageQuality;

{!!
<FS>TIEWICWriter.CompressionQuality

<FM>Declaration<FC>
property CompressionQuality:double;

<FM>Description<FN>
0.0 specifies the least efficient compression scheme available, typically resulting in a fast encode but larger output.
A value of 1.0 specifies the most efficient scheme available, typically taking more time to encode but producing smaller output.
HD Photo does not support this encoder option.
You have to set this property before each <A TIEWICWriter.PutFrame> call.
!!}
  property CompressionQuality:double read fCompressionQuality write fCompressionQuality;

{!!
<FS>TIEWICWriter.Lossless

<FM>Declaration<FC>
property Lossless:boolean;

<FM>Description<FN>
Setting this parameter to <FC>true<FN> enables mathematically lossless compression mode and overrides the <A TIEWICWriter.ImageQuality> parameter setting.
The default value is <FC>false<FN>.
You have to set this property before each <A TIEWICWriter.PutFrame> call.

<FM>Example<FC>
with TIEWICWriter.Create do
begin
  Open('output.hdp', ioHDP);
  Lossless := true;
  PutFrame(ImageEnView1.IEBitmap);
  Free;
end;
!!}
  property Lossless:boolean read fLossless write fLossless;

  //// Specific HD Photo encoder parameter properties ////


{!!
<FS>TIEWICWriter.UseCodecOptions

<FM>Declaration<FC>
property UseCodecOptions:boolean;

<FM>Description<FN>
If this parameter is <FC>true<FN>, the <A TIEWICWriter.Quality>, <A TIEWICWriter.Overlap> and <A TIEWICWriter.Subsampling> parameters are used in place of the <A TIEWICWriter.ImageQuality> encoder canonical parameter.
When <FC>false<FN>, the <A TIEWICWriter.Quality>, <A TIEWICWriter.Overlap> and <A TIEWICWriter.Subsampling> parameters are set based on a table lookup determined by the <A TIEWICWriter.ImageQuality> parameter.
The default value is <FC>false<FN>.
You have to set this property before each <A TIEWICWriter.PutFrame> call.

<FM>Example<FC>
with TIEWICWriter.Create do
begin
  Open('output.hdp', ioHDP);
  UseCodecOptions := true;
  Quality := 10;
  PutFrame(ImageEnView1.IEBitmap);
  Free;
end;
!!}
  property UseCodecOptions:boolean read fUseCodecOptions write fUseCodecOptions;

{!!
<FS>TIEWICWriter.Quality

<FM>Declaration<FC>
property Quality:integer;

<FM>Description<FN>
This parameter controls the compression quality for the main image. A value of 1 sets lossless mode.
Increasing values result in higher compression ratios and lower image quality.
The default value is 1.

<A TIEWICWriter.UseCodecOptions> must be <FC>true<FN>.
You have to set this property before each <A TIEWICWriter.PutFrame> call.

<FM>Example<FC>
with TIEWICWriter.Create do
begin
  Open('output.hdp', ioHDP);
  UseCodecOptions := true;
  Quality := 10;
  PutFrame(ImageEnView1.IEBitmap);
  Free;
end;
!!}
  property Quality:integer read fQuality write fQuality;

{!!
<FS>TIEWICWriter.Overlap

<FM>Declaration<FC>
property Overlap:integer;

<FM>Description<FN>
This parameter selects the optional overlap processing level:
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>0</C> <C>No overlap processing is enabled.</C> </R>
<R> <C>1</C> <C>One level of overlap processing is enabled, modifying 4x4 block encoded values based on values of neighboring blocks.</C> </R>
<R> <C>2</C> <C>Two levels of overlap processing are enabled; in addition to the first level processing, encoded values of 16x16 macro blocks are modified based on the values of neighboring macro blocks.</C> </R>
</TABLE>

The default value is 1.

<A TIEWICWriter.UseCodecOptions> must be <FC>true<FN>.
You have to set this property before each <A TIEWICWriter.PutFrame> call.
!!}
  property Overlap:integer read fOverlap write fOverlap;

{!!
<FS>TIEWICWriter.Subsampling

<FM>Declaration<FC>
property Subsampling:integer;

<FM>Description<FN>
This parameter only applies to RGB images. It enables additional compression in the chroma space, preserving luminance detail at the expense of color detail:

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>3</C> <C>4:4:4 encoding preserves full chroma resolution.</C> </R>
<R> <C>2</C> <C>4:2:2 encoding reduces chroma resolution to ½ of luminance resolution.</C> </R>
<R> <C>1</C> <C>4:2:0 encoding reduces chroma resolution to ¼ of luminance resolution.</C> </R>
<R> <C>0</C> <C>4:0:0 encoding discards all chroma content, preserving luminance only. Because the codec uses a slightly modified definition of luminance to improve performance, it is preferred to convert an RGB image to monochrome before encoding rather than use this chroma subsampling mode.</C> </R>
</TABLE>

Any value greater than 3 returns an error.  The default value is 3.

<A TIEWICWriter.UseCodecOptions> must be <FC>true<FN>.
You have to set this property before each <A TIEWICWriter.PutFrame> call.
!!}
  property Subsampling:integer read fSubsampling write fSubsampling;

{!!
<FS>TIEWICWriter.HorizontalTileSlices

<FM>Declaration<FC>
property HorizontalTileSlices:integer;

<FM>Description<FN>
HorizontalTileSlices and <A TIEWICWriter.VerticalTileSlices> specify the horizontal and vertical tiling of the image prior to compression encoding for the most optimal region decode performance.
Dividing the image into rectangular tiles during encoding makes it possible to decode regions of the image without the need to process the entire compressed data stream.
The default value of 0 specifies no subdivision, so the entire image is treated as a single tile.
A value of 1 for each parameter will create a single horizontal and a single vertical division, effectively dividing the image into four equally sized tiles.
The maximum value of 4095 for each parameter divides the image into 4096 tile rows with 4096 tiles per row.
In other words, the parameter values equal the number of horizontal and vertical tiles (respectively) minus 1.
A tile can never be smaller than 16 pixels in width or height, so the HD Photo encoder may adjust this parameter to maintain the required minimum tile size.
Because there is storage and processing overhead associated with each tile, these values should be chosen carefully to meet the specific scenario and unless there is a very specific reason, large numbers of small tiles should be avoided.

The default value for both parameters is 0.

You have to set this property before each <A TIEWICWriter.PutFrame> call.
!!}
  property HorizontalTileSlices:integer read fHorizontalTileSlices write fHorizontalTileSlices;

{!!
<FS>TIEWICWriter.VerticalTileSlices

<FM>Declaration<FC>
property VerticalTileSlices:integer;

<FM>Description<FN>
<A TIEWICWriter.HorizontalTileSlices> and VerticalTileSlices specify the horizontal and vertical tiling of the image prior to compression encoding for the most optimal region decode performance.
Dividing the image into rectangular tiles during encoding makes it possible to decode regions of the image without the need to process the entire compressed data stream.
The default value of 0 specifies no subdivision, so the entire image is treated as a single tile.
A value of 1 for each parameter will create a single horizontal and a single vertical division, effectively dividing the image into four equally sized tiles.
The maximum value of 4095 for each parameter divides the image into 4096 tile rows with 4096 tiles per row.
In other words, the parameter values equal the number of horizontal and vertical tiles (respectively) minus 1.
A tile can never be smaller than 16 pixels in width or height, so the HD Photo encoder may adjust this parameter to maintain the required minimum tile size.
Because there is storage and processing overhead associated with each tile, these values should be chosen carefully to meet the specific scenario and unless there is a very specific reason, large numbers of small tiles should be avoided.

The default value for both parameters is 0.

You have to set this property before each <A TIEWICWriter.PutFrame> call.
!!}
  property VerticalTileSlices:integer read fVerticalTileSlices write fVerticalTileSlices;

{!!
<FS>TIEWICWriter.FrequencyOrder

<FM>Declaration<FC>
property FrequencyOrder:boolean;

<FM>Description<FN>
This parameter specifies that the image must be encoded in frequency order, with the lowest frequency data appearing first in the file, and image content grouped by its frequency rather than its spatial orientation.
Organizing a file by frequency order provides the highest performance results for any frequency-based decoding, and is the preferred option.
Device implementations of HD Photo encoders may choose to organize a file in spatial order to reduce the memory footprint required during encoding.
The default value is <FC>true<FN> and it is recommended that applications and devices always use frequency order unless there are performance or application-specific reasons to use spatial order.

You have to set this property before each <A TIEWICWriter.PutFrame> call.
!!}
  property FrequencyOrder:boolean read fFrequencyOrder write fFrequencyOrder;

  ///// TIFF specific compression parameters /////

{!!
<FS>TIEWICWriter.TIFFCompressionMethod

<FM>Declaration<FC>
property TIFFCompressionMethod:<A TIEWICTIFFCompressionMethod>;

<FM>Description<FN>
Specifies the Tagged Image File Format (TIFF) compression options.

You have to set this property before each <A TIEWICWriter.PutFrame> call.

<FM>Example<FC>
// writes a TIFF using CCITT4 compression (make sure ImageEnView1.IEBitmap.PixelFormat=ie1g)
with TIEWICWriter.Create do
begin
  Open('output.tif', ioTIFF);
  TIFFCompressionMethod := ieWICTiffCompressionCCITT4;
  PutFrame(ImageEnView1.IEBitmap);
  Free;
end;
!!}
  property TIFFCompressionMethod:TIEWICTIFFCompressionMethod read fTIFFCompressionMethod write fTIFFCompressionMethod;

end;




implementation

uses ieview, tiffilt;

const
  ole32 = 'ole32.dll';

function CoCreateInstance(const clsid: TGUID; unkOuter: IUnknown; dwClsContext: Longint; const iid: TGUID; out pv): HResult; stdcall; external ole32 name 'CoCreateInstance';
function OleInitialize(pwReserved: Pointer): HResult; stdcall; external ole32 name 'OleInitialize';
procedure OleUninitialize; stdcall; external ole32 name 'OleUninitialize';


const

CLSCTX_INPROC_SERVER = 1;

CLSID_WICImagingFactory: TGUID = (D1:$cacaf262; D2:$9370; D3:$4615; D4:($a1, $3b, $9f, $55, $39, $da, $4c, $a));

CLSID_WICBmpDecoder: TGUID  = (D1:$6b462062; D2:$7cbf; D3:$400d; D4:($9f, $db, $81, $3d, $d1, $f, $27, $78));
CLSID_WICPngDecoder: TGUID  = (D1:$389ea17b; D2:$5078; D3:$4cde; D4:($b6, $ef, $25, $c1, $51, $75, $c7, $51));
CLSID_WICIcoDecoder: TGUID  = (D1:$c61bfcdf; D2:$2e0f; D3:$4aad; D4:($a8, $d7, $e0, $6b, $af, $eb, $cd, $fe));
CLSID_WICJpegDecoder: TGUID = (D1:$9456a480; D2:$e88b; D3:$43ea; D4:($9e, $73, $b, $2d, $9b, $71, $b1, $ca));
CLSID_WICGifDecoder: TGUID  = (D1:$381dda3c; D2:$9ce9; D3:$4834; D4:($a2, $3e, $1f, $98, $f8, $fc, $52, $be));
CLSID_WICTiffDecoder: TGUID = (D1:$b54e85d9; D2:$fe23; D3:$499f; D4:($8b, $88, $6a, $ce, $a7, $13, $75, $2b));
CLSID_WICWmpDecoder: TGUID  = (D1:$a26cec36; D2:$234c; D3:$4950; D4:($ae, $16, $e3, $4a, $ac, $e7, $1d, $0d));

CLSID_WICBmpEncoder: TGUID  = (D1:$69be8bb4; D2:$d66d; D3:$47c8; D4:($86, $5a, $ed, $15, $89, $43, $37, $82));
CLSID_WICPngEncoder: TGUID  = (D1:$27949969; D2:$876a; D3:$41d7; D4:($94, $47, $56, $8f, $6a, $35, $a4, $dc));
CLSID_WICJpegEncoder: TGUID = (D1:$1a34f5c1; D2:$4a5a; D3:$46dc; D4:($b6, $44, $1f, $45, $67, $e7, $a6, $76));
CLSID_WICGifEncoder: TGUID  = (D1:$114f5598; D2:$0b22; D3:$40a0; D4:($86, $a1, $c8, $3e, $a4, $95, $ad, $bd));
CLSID_WICTiffEncoder: TGUID = (D1:$0131be10; D2:$2001; D3:$4c5f; D4:($a9, $b0, $cc, $88, $fa, $b6, $4c, $e8));
CLSID_WICWmpEncoder: TGUID  = (D1:$ac4ce3cb; D2:$e1c1; D3:$44cd; D4:($82, $15, $5a, $16, $65, $50, $9e, $c2));


GUID_WICPixelFormatDontCare: TGUID    = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $00));
GUID_WICPixelFormat1bppIndexed: TGUID = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $01));
GUID_WICPixelFormat8bppIndexed: TGUID = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $04));
GUID_WICPixelFormatBlackWhite: TGUID  = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $05));
GUID_WICPixelFormat8bppGray: TGUID    = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $08));
GUID_WICPixelFormat16bppGray: TGUID   = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $0b));
GUID_WICPixelFormat24bppBGR: TGUID    = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $0c));
GUID_WICPixelFormat24bppRGB: TGUID    = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $0d));
GUID_WICPixelFormat48bppRGB: TGUID    = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $15));
GUID_WICPixelFormat32bppCMYK: TGUID   = (D1:$6fddc324; D2:$4e03; D3:$4bfe; D4:($b1, $85, $3d, $77, $76, $8d, $c9, $1c));

GUID_ContainerFormatBmp: TGUID  = (D1:$0af1d87e; D2:$fcfe; D3:$4188; D4:($bd, $eb, $a7, $90, $64, $71, $cb, $e3));
GUID_ContainerFormatPng: TGUID  = (D1:$1b7cfaf4; D2:$713f; D3:$473c; D4:($bb, $cd, $61, $37, $42, $5f, $ae, $af));
GUID_ContainerFormatIco: TGUID  = (D1:$a3a860c4; D2:$338f; D3:$4c17; D4:($91, $9a, $fb, $a4, $b5, $62, $8f, $21));
GUID_ContainerFormatJpeg: TGUID = (D1:$19e4a5aa; D2:$5662; D3:$4fc5; D4:($a0, $c0, $17, $58, $02, $8e, $10, $57));
GUID_ContainerFormatTiff: TGUID = (D1:$163bcc30; D2:$e2e9; D3:$4f0b; D4:($96, $1d, $a3, $e9, $fd, $b7, $88, $a3));
GUID_ContainerFormatGif: TGUID  = (D1:$1f8a5601; D2:$7d4d; D3:$4cbd; D4:($9c, $82, $1b, $c8, $d4, $ee, $b9, $a5));
GUID_ContainerFormatWmp: TGUID  = (D1:$57a37caa; D2:$367a; D3:$4540; D4:($91, $6b, $f1, $83, $c5, $09, $3a, $4b));

GUID_VendorMicrosoft: TGUID = (D1:$f0e749ca; D2:$edef; D3:$4589; D4:($a7, $3a, $ee, $e, $62, $6a, $2a, $2b));



// WICDecodeOptions
WICDecodeMetadataCacheOnDemand  = $00000000;
WICDecodeMetadataCacheOnLoad    = $00000001;


// WICBitmapEncoderCacheOption
WICBitmapEncoderCacheInMemory = $00000000;
WICBitmapEncoderCacheTempFile = $00000001;
WICBitmapEncoderNoCache       = $00000002;


// WICBitmapDitherType
WICBitmapDitherTypeNone           = $00000000;
WICBitmapDitherTypeSolid          = $00000000;
WICBitmapDitherTypeOrdered4x4     = $00000001;
WICBitmapDitherTypeOrdered8x8     = $00000002;
WICBitmapDitherTypeOrdered16x16   = $00000003;
WICBitmapDitherTypeSpiral4x4      = $00000004;
WICBitmapDitherTypeSpiral8x8      = $00000005;
WICBitmapDitherTypeDualSpiral4x4  = $00000006;
WICBitmapDitherTypeDualSpiral8x8  = $00000007;
WICBitmapDitherTypeErrorDiffusion = $00000008;

// STREAM_SEEK
STREAM_SEEK_SET = 0;
STREAM_SEEK_CUR = 1;
STREAM_SEEK_END = 2;

PROPBAG2_TYPE_UNDEFINED	= 0;
PROPBAG2_TYPE_DATA	    = 1;
PROPBAG2_TYPE_URL	      = 2;
PROPBAG2_TYPE_OBJECT	  = 3;
PROPBAG2_TYPE_STREAM	  = 4;
PROPBAG2_TYPE_STORAGE	  = 5;
PROPBAG2_TYPE_MONIKER	  = 6;



//////////////////////////////////////////////////////////////////
// TIEWICReader

constructor TIEWICReader.Create;
begin
  inherited Create;

  fOLEInitialized := Succeeded(OleInitialize(nil));

  fWICImagingFactory := nil;
  fDecoder := nil;
  fFrame := nil;
  fQueryReader := nil;
  fStream := nil;
  fStreamBase := 0;
  fFileStream := nil;

  fDPIX := gDefaultDPIX;
  fDPIY := gDefaultDPIY;

  CoCreateInstance(CLSID_WICImagingFactory, nil, CLSCTX_INPROC_SERVER, IE_IWICImagingFactory, fWICImagingFactory);
end;


destructor TIEWICReader.Destroy;
begin
  Close();
  fWICImagingFactory := nil;

  if fOLEInitialized then
    OleUninitialize;

  inherited;
end;


{!!
<FS>TIEWICReader.Close

<FM>Declaration<FC>
procedure Close;

<FM>Description<FN>
Closes currently open stream or file freeing allocated resources.
This method is implicitly called by <FC>Free<FN> method.

<FM>Example<FC>
with TIEWICReader.Create do
begin
  Open('input.hdp', ioHDP);
  GetFrame(0, ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free; // Calls Close() implicitly
end;
ImageEnView1.Update;
!!}
procedure TIEWICReader.Close;
begin
  if assigned(fFileStream) then
    FreeAndNil(fFileStream);
  fQueryReader := nil;
  fFrame := nil;
  fDecoder := nil;
end;


{!!
<FS>TIEWICReader.IsAvailable

<FM>Declaration<FC>
function IsAvailable:boolean;

<FM>Description<FN>
Returns true if WIC is available. This should happen on Windows XP (SP2) with .Net 3.0, Windows Vista.

Look also <A IEWICAvailable> function.

<FM>Example<FC>
with TIEWICReader.Create do
  if IsAvailable then
  begin
    Open('input.hdp', ioHDP);
    GetFrame(0, ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
    Free;
  end;
ImageEnView1.Update;
!!}
function TIEWICReader.IsAvailable:boolean;
begin
  result := (fWICImagingFactory<>nil) and IEWICAvailable();
end;


{!!
<FS>TIEWICReader.Open

<FM>Declaration<FC>
function Open(Stream:TStream; fileType:<A TIOFileType>):boolean;
function Open(const FileName:WideString; fileType:<A TIOFileType>):boolean;

<FM>Description<FN>
Opens a stream or file, enabling subsequent calls to <A TIEWICReader.GetFrame>.
You should call <FC>Free<FN> or <A TIEWICReader.Close> in order to terminate reading.

<FM>Example<FC>
with TIEWICReader.Create do
begin
  Open('input.hdp', ioHDP);
  GetFrame(0, ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free; // Calls Close() implicitly
end;
ImageEnView1.Update;
!!}
function TIEWICReader.Open(Stream:TStream; fileType:TIOFileType):boolean;
var
  DecoderGuid:TGUID;
begin
  result := false;
  if not IsAvailable() then
    exit;

  fStream := Stream;
  fStreamBase := Stream.Position;

  case fileType of
    ioBMP:  DecoderGuid := CLSID_WICBmpDecoder;
    ioPNG:  DecoderGuid := CLSID_WICPngDecoder;
    ioICO:  DecoderGuid := CLSID_WICIcoDecoder;
    ioJPEG: DecoderGuid := CLSID_WICJpegDecoder;
    ioGIF:  DecoderGuid := CLSID_WICGifDecoder;
    ioTIFF: DecoderGuid := CLSID_WICTiffDecoder;
    ioHDP:  DecoderGuid := CLSID_WICWmpDecoder;
    else
      exit;
  end;
  fDecoder := nil;
  fWICImagingFactory.CreateDecoderFromStream(TStreamAdapter.Create(Stream), DecoderGuid, WICDecodeMetadataCacheOnLoad, fDecoder);

  if fDecoder = nil then
    exit;

  result := true;
end;


function TIEWICReader.Open(const FileName:WideString; fileType:TIOFileType):boolean;
begin
  fFileStream := TIEWideFileStream.create(FileName, fmOpenRead or fmShareDenyWrite);
  result := Open(fFileStream, fileType);
end;


{!!
<FS>TIEWICReader.FrameCount

<FM>Declaration<FC>
property FrameCount:integer;

<FM>Description<FN>
Returns the total number of frames in the image.

<FM>Example<FC>
with TIEWICReader.Create do
begin
  Open('input.tif', ioHDP);
  fCount := FrameCount;
  for i:=0 to fCount-1 do
    GetFrame(i, bitmap[i]);
  Free;
end;
!!}
function TIEWICReader.GetFrameCount:integer;
begin
  result := 0;
  if not IsAvailable() or not assigned(fDecoder) then
    exit;
  fDecoder.GetFrameCount(result);
end;


procedure TIEWICReader.CopyWICBitmapToIEBitmap(source:IE_IWICBitmapSource; dest:TIEBitmap; nativePixelFormat:boolean);
var
  converter:IE_IWICFormatConverter;
  pixelFormatGUID:TGUID;
  pixelFormat:TIEPixelFormat;
  w, h, i, j:longint;
  rc: IE_WICRect;
  pb:pbyte;
begin
  source.GetPixelFormat(pixelFormatGUID);
  if nativePixelFormat then
  begin
    if CompareGUID(pixelFormatGUID, GUID_WICPixelFormat1bppIndexed) then
    begin
      pixelFormatGUID := GUID_WICPixelFormat8bppIndexed;
      pixelFormat := ie8p;
    end
    else if CompareGUID(pixelFormatGUID, GUID_WICPixelFormat8bppIndexed) then
    begin
      // palette not supported at the moment
      pixelFormatGUID := GUID_WICPixelFormat24bppBGR;
      pixelFormat := ie24RGB;
    end
    else if CompareGUID(pixelFormatGUID, GUID_WICPixelFormatBlackWhite) then
      pixelFormat := ie1g
    else if CompareGUID(pixelFormatGUID, GUID_WICPixelFormat8bppGray) then
      pixelFormat := ie8g
    else if CompareGUID(pixelFormatGUID, GUID_WICPixelFormat16bppGray) then
      pixelFormat := ie16g
    else if CompareGUID(pixelFormatGUID, GUID_WICPixelFormat24bppBGR) then
      pixelFormat := ie24RGB
    else if CompareGUID(pixelFormatGUID, GUID_WICPixelFormat48bppRGB) then
      pixelFormat := ie48RGB
    else if CompareGUID(pixelFormatGUID, GUID_WICPixelFormat32bppCMYK) then
      pixelFormat := ieCMYK
    else
    begin
      pixelFormatGUID := GUID_WICPixelFormat24bppBGR;
      pixelFormat := ie24RGB;
    end;
  end
  else
  begin
    // only 1bit and 24bitRGB are supported
    if CompareGUID(pixelFormatGUID, GUID_WICPixelFormatBlackWhite) then
      pixelFormat := ie1g
    else
    begin
      pixelFormatGUID := GUID_WICPixelFormat24bppBGR;
      pixelFormat := ie24RGB;
    end;
  end;

  converter := nil;
  fWICImagingFactory.CreateFormatConverter(converter);
  converter.Initialize(source, pixelFormatGUID, WICBitmapDitherTypeNone, nil, 0.0, 0);

  converter.GetSize(w, h);
  dest.Allocate(w, h, pixelFormat);
  rc.X := 0;
  rc.Width := w;
  rc.Height := 1;
  for i:=0 to h-1 do
  begin
    rc.Y := i;
    converter.CopyPixels(rc, dest.Rowlen, dest.Rowlen, dest.ScanLine[i]);
  end;

  if dest.PixelFormat=ieCMYK then
  begin
    // CMYK channels need to be inverted
    for i:=0 to h-1 do
    begin
      pb := dest.ScanLine[i];
      for j:=w*4-1 downto 0 do
      begin
        pb^ := 255-pb^;
        inc(pb);
      end;
    end;
  end;

  converter := nil;
end;


{!!
<FS>TIEWICReader.GetFrame

<FM>Declaration<FC>
procedure GetFrame(frameIndex:integer; destBitmap:<A TIEBitmap>; IOParams:<A TIOParamsVals> = nil; Aborting:pboolean = nil);

<FM>Description<FN>
Retrieves the specified frame of the image.
If <FC>IOParams<FN> is specified then it is filled also with EXIF metatags.

Look also <A TIEWICReader.Open>.

<FM>Example<FC>
with TIEWICReader.Create do
begin
  Open('input.tif', ioHDP);
  fCount := FrameCount;
  for i:=0 to fCount-1 do
    GetFrame(i, bitmap[i]);
  Free;
end;
!!}
// IOParams can be nil
// Aborting can be nil
procedure TIEWICReader.GetFrame(frameIndex:integer; destBitmap:TIEBitmap; IOParams:TIOParamsVals; Aborting:pboolean);
var
  thumb:IE_IWICBitmapSource;
  lp:int64;
  nativePixelFormat:boolean;
begin
  if not IsAvailable() or not assigned(fDecoder) then
  begin
    if assigned(Aborting) then
      Aborting^ := true;
    exit;
  end;

  // load frame "frameIndex"
  fFrame := nil;
  fDecoder.GetFrame(frameIndex, fFrame);

  // get info
  fFrame.GetResolution(fDPIX, fDPIY);

  // get metadata
  fQueryReader := nil;
  fFrame.GetMetadataQueryReader(fQueryReader);

  if assigned(IOParams) and not IOParams.IsNativePixelFormat then
    nativePixelFormat := false
  else
    nativePixelFormat := true;

  if assigned(IOParams) and IOParams.GetThumbnail then
  begin
    // get thumbnail of this frame
    thumb := nil;
    fFrame.GetThumbnail(thumb);
    if assigned(thumb) then
      // thumb available, get it
      CopyWICBitmapToIEBitmap(thumb, destBitmap, nativePixelFormat)
    else
      // thumb not available, get full frame
      CopyWICBitmapToIEBitmap(fFrame, destBitmap, nativePixelFormat);
  end
  else
    // get full image
    CopyWICBitmapToIEBitmap(fFrame, destBitmap, nativePixelFormat);

  // 3.0.4
  if assigned(IOParams) then
  begin
    lp := fStream.Position;
    fStream.Position := fStreamBase;
    IELoadEXIFFromTIFF(fStream, IOParams, IOParams.ImageIndex); // load EXIF and other TIFF compatible tags
    fStream.Position := lp; // restores as WIC expects
    // assign non exif tags
    IOParams.BitsPerSample := destBitmap.BitCount div destBitmap.ChannelCount;
    IOParams.SamplesPerPixel := destBitmap.ChannelCount;
    IOParams.OriginalWidth := FrameWidth;
    IOParams.OriginalHeight := FrameHeight;
    IOParams.Width := destBitmap.Width;
    IOParams.Height := destBitmap.Height;
    IOParams.DpiX := trunc(DPIX);
    IOParams.DpiY := trunc(DPIY);
  end;

end;


{!!
<FS>TIEWICReader.FrameWidth

<FM>Declaration<FC>
function FrameWidth:integer;

<FM>Description<FN>
Retrieves the width of the frame.
!!}
function TIEWICReader.FrameWidth:integer;
var
  h:integer;
begin
  result := 0;
  if assigned(fFrame) then
    fFrame.GetSize(result, h);
end;


{!!
<FS>TIEWICReader.FrameHeight

<FM>Declaration<FC>
function FrameHeight:integer;

<FM>Description<FN>
Retrieves the height of the frame.
!!}
function TIEWICReader.FrameHeight:integer;
var
  w:integer;
begin
  result := 0;
  if assigned(fFrame) then
    fFrame.GetSize(w, result);
end;


function TIEWICReader.QueryMetadata(const query:string):PROPVARIANT;
begin
  if not IsAvailable() or not assigned(fDecoder) then
    exit;

  if assigned(fQueryReader) then
  begin
    FillChar(result, sizeof(PROPVARIANT), 0);
    fQueryReader.GetMetadataByName(pwchar(WideString(query)),result);
  end;
end;




//////////////////////////////////////////////////////////////////
// TIEWICWriter

constructor TIEWICWriter.Create;
begin
  inherited Create;

  fOLEInitialized := Succeeded(OleInitialize(nil));

  fWICImagingFactory := nil;
  fDPIX := gDefaultDPIX;
  fDPIY := gDefaultDPIY;
  fImageQuality := -1;
  fCompressionQuality := -1;
  fLossless := false;
  UseCodecOptions := false;
  fQuality := 1;
  fOverlap := 1;
  fSubsampling := 3;
  fHorizontalTileSlices := 0;
  fVerticalTileSlices := 0;
  fFrequencyOrder := true;
  fTIFFCompressionMethod := ieWICTiffCompressionNone;
  fEncoder := nil;
  fStream := nil;
  fStreamBase := 0;
  fFileStream := nil;

  CoCreateInstance(CLSID_WICImagingFactory, nil, CLSCTX_INPROC_SERVER, IE_IWICImagingFactory, fWICImagingFactory);
end;


destructor TIEWICWriter.Destroy;
begin
  Close();
  fWICImagingFactory := nil;

  if fOLEInitialized then
    OleUninitialize;

  inherited;
end;


{!!
<FS>TIEWICWriter.IsAvailable

<FM>Declaration<FC>
function IsAvailable:boolean;

<FM>Description<FN>
Returns true if WIC is available. This should happen on Windows XP (SP2) with .Net 3.0, Windows Vista.

Look also <A IEWICAvailable> function.

<FM>Example<FC>
with TIEWICWriter.Create do
  if IsAvailable then
  begin
    Open('output.hdp', ioHDP);
    PutFrame(ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
    Free;
  end;
!!}
function TIEWICWriter.IsAvailable:boolean;
begin
  result := fWICImagingFactory <> nil;
end;


{!!
<FS>TIEWICWriter.Open

<FM>Declaration<FC>
function Open(Stream:TStream; fileType:<A TIOFileType>):boolean;
function Open(const FileName:WideString; fileType:<A TIOFileType>):boolean;

<FM>Description<FN>
Creates specified image format in stream or file, enabling subsequent calls to <A TIEWICWriter.PutFrame> calls.
You should call <FC>Free<FN> or <A TIEWICWriter.Close> in order to commit changes.

<FM>Example<FC>
// saves ImageEnView1 to output.hdp, the same of ImageEnView1.IO.SaveToFile('output.hdp')
with TIEWICWriter.Create do
begin
  Open('output.hdp', ioHDP);
  PutFrame(ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free;
end;
!!}
function TIEWICWriter.Open(Stream:TStream; fileType:TIOFileType):boolean;
var
  ContainerGuid:TGUID;
begin
  result := false;
  if not IsAvailable() then
    exit;

  fStream := Stream;
  fStreamBase := Stream.Position;

  case fileType of
    ioBMP:  ContainerGuid := GUID_ContainerFormatBmp;
    ioPNG:  ContainerGuid := GUID_ContainerFormatPng;
    ioJPEG: ContainerGuid := GUID_ContainerFormatJpeg;
    ioGIF:  ContainerGuid := GUID_ContainerFormatGif;
    ioTIFF: ContainerGuid := GUID_ContainerFormatTiff;
    ioHDP:  ContainerGuid := GUID_ContainerFormatWmp;
    else
      exit;
  end;
  fEncoder := nil;
  fWICImagingFactory.CreateEncoder(ContainerGuid, GUID_VendorMicrosoft, fEncoder);

  if fEncoder = nil then
    exit;

  fEncoder.Initialize(TStreamAdapter.Create(Stream), WICBitmapEncoderNoCache);

  result := true;
end;


function TIEWICWriter.Open(const FileName:WideString; fileType:TIOFileType):boolean;
begin
  fFileStream := TIEWideFileStream.Create(FileName, fmCreate);
  result := Open(fFileStream, fileType);
end;


{!!
<FS>TIEWICWriter.Close

<FM>Declaration<FC>
procedure Close;

<FM>Description<FN>
Commit changes to output stream or file.
This method is implicitly called by <FC>Free<FN> method.
!!}
procedure TIEWICWriter.Close;
begin
  if assigned(fEncoder) then
  begin
    fEncoder.Commit;
    fEncoder := nil;
  end;
  if assigned(fFileStream) then
    FreeAndNil(fFileStream);
end;


procedure SetPropertyBag(prop:IE_IPropertyBag2; const name:string; value:variant; propType:TVarType);
var
  propName:IE_PROPBAG2;
  propValue:PROPVARIANT;
begin
  FillChar(propName, sizeof(IE_PROPBAG2), 0);
  propName.dwType := PROPBAG2_TYPE_DATA;
  propName.vt := propType;
  propName.pstrName := pwchar(WideString(name));
  propValue.vt := propType;
  case propType of
    VT_R4: propValue.fltVal := value;
    VT_BOOL: propValue.boolVal := value;
    VT_UI1: propValue.bVal := value;
    VT_UI2: propValue.uiVal := value;
    else
      assert(false);  // unsupported property type
  end;
  prop.Write(1, @propName, @propValue);
end;


{!!
<FS>TIEWICWriter.PutFrame

<FM>Declaration<FC>
procedure PutFrame(srcBitmap:<A TIEBitmap>; IOParams:<A TIOParamsVals> = nil);

<FM>Description<FN>
Adds a new frame to current open stream or file.
You can call multiple <FC>PutFrame<FN> only if the writing file format accepts more than one frame.
If <FC>IOParams<FN> is specified parameters (DPI, compression) are read from it.
<FC>PutFrame<FN> doesn't write EXIF metatags: you have to use <A TImageEnIO.InjectTIFFEXIF> to inject EXIF in HDPhoto or TIFF files.
It is important that you close the stream/file before inject EXIF metatags.

<FM>Example<FC>
// saves ImageEnView1 to output.hdp, the same of ImageEnView1.IO.SaveToFile('output.hdp')
with TIEWICWriter.Create do
begin
  Open('output.hdp', ioHDP);
  PutFrame(ImageEnView1.IEBitmap, ImageEnView1.IO.Params);
  Free;
end;
ImageEnView1.IO.InjectTIFFEXIF('output.hdp');
!!}
// IOParams can be nil
// doesn't save/inject exif info
// Note: for some unknown reason it is not possible to include multiple frames in HDP files
procedure TIEWICWriter.PutFrame(srcBitmap:TIEBitmap; IOParams:TIOParamsVals);
const
  TIFFCOMPRESSIONMETHODTOINT:array [TIEWICTIFFCompressionMethod] of integer = (0, 1, 2, 3, 4, 5, 6);
var
  frame:IE_IWICBitmapFrameEncode;
  prop:IE_IPropertyBag2;
  w, h, i:integer;
  pixelFormatGUID:TGUID;
begin
  frame := nil;
  prop := nil;
  fEncoder.CreateNewFrame(frame, prop);

  if assigned(frame) and assigned(prop) then
  begin

    if assigned(IOParams) then
    begin
      DPIX := IOParams.DpiX;
      DPIY := IOParams.DpiY;
      ImageQuality := IOParams.HDP_ImageQuality;
      Lossless := IOParams.HDP_Lossless;
    end;

    // Canonical codec properties
    if fImageQuality>=0.0 then
      SetPropertyBag(prop, 'ImageQuality', fImageQuality, VT_R4);
    if fCompressionQuality>=0.0 then
      SetPropertyBag(prop, 'CompressionQuality', fCompressionQuality, VT_R4);
    SetPropertyBag(prop, 'Lossless', fLossless, VT_BOOL);

    // HDP codec properties
    if fUseCodecOptions then
    begin
      SetPropertyBag(prop, 'UseCodecOptions', fUseCodecOptions, VT_BOOL);
      SetPropertyBag(prop, 'Quality', fQuality, VT_UI1);
      SetPropertyBag(prop, 'Overlap', fOverlap, VT_UI1);
      SetPropertyBag(prop, 'Subsampling', fSubsampling, VT_UI1);
    end;
    SetPropertyBag(prop, 'HorizontalTileSlices', fHorizontalTileSlices, VT_UI2);
    SetPropertyBag(prop, 'VerticalTileSlices', fVerticalTileSlices, VT_UI2);
    SetPropertyBag(prop, 'FrequencyOrder', fFrequencyOrder, VT_BOOL);

    // TIFF codec properties
    SetPropertyBag(prop, 'TiffCompressionMethod', TIFFCOMPRESSIONMETHODTOINT[fTIFFCompressionMethod], VT_UI1);

    frame.Initialize(prop);

    w := srcBitmap.Width;
    h := srcBitmap.Height;
    frame.SetSize(w, h);

    frame.SetResolution(fDPIX, fDPIY);

    case srcBitmap.PixelFormat of
      ie1g:     pixelFormatGUID := GUID_WICPixelFormatBlackWhite;
      ie8p:     assert(false);  // unsupported
      ie8g:     pixelFormatGUID := GUID_WICPixelFormat8bppGray;
      ie16g:    pixelFormatGUID := GUID_WICPixelFormat16bppGray;
      ie24RGB:  pixelFormatGUID := GUID_WICPixelFormat24bppBGR;
      ie32f:    assert(false);  // unsupported
      ieCMYK:   pixelFormatGUID := GUID_WICPixelFormat32bppCMYK;
      ie48RGB:  pixelFormatGUID := GUID_WICPixelFormat48bppRGB;
      ieCIELab: assert(false);  // unsupported
      ie32RGB:  assert(false);  // unsupported
    end;
    frame.SetPixelFormat(pixelFormatGUID);

    for i:=0 to h-1 do
      frame.WritePixels(1, srcBitmap.Rowlen, srcBitmap.Rowlen, srcBitmap.ScanLine[i]);

    frame.Commit;

  end;

  frame := nil;
  prop := nil;

end;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////


procedure IEHDPRead(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean);

  procedure DoProgress(val:integer);
  begin
    with xProgress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, 0);
  end;

var
  wic:TIEWICReader;
begin
  DoProgress(0);
  wic := TIEWICReader.Create;
  try
    wic.Open(Stream, ioHDP);
    wic.GetFrame(IOParams.ImageIndex, Bitmap, IOParams, xProgress.Aborting);  // exif loaded in GetFrame
  finally
    wic.Free; // wic.Close called in Free
    DoProgress(100);
  end;
end;


// support writing of a single page
procedure IEHDPWrite(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec);

  procedure DoProgress(val:integer);
  begin
    with xProgress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, 0);
  end;

var
  wic:TIEWICWriter;
  lp:int64;
begin
  if not IEWICAvailable() then
  begin
    xProgress.Aborting^ := true;
    exit;
  end;

  DoProgress(0);
  lp := Stream.Position;
  wic := TIEWICWriter.Create;
  try
    wic.Open(Stream, ioHDP);
    wic.PutFrame(Bitmap, IOParams); // exif not written in PutFrame
  finally
    wic.Free;
    Stream.Position := lp;
    IEInjectTIFFEXIF(Stream, Stream, '', '', 0, IOParams);
    DoProgress(100);
  end;
end;



function IEHDPFrameCount(const FileName:WideString):integer;
var
  wic:TIEWICReader;
  fs:TIEWideFileStream;
begin
  if IEWICAvailable() then
  begin
    wic := TIEWICReader.Create;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      wic.Open(fs, ioHDP);
      result := wic.FrameCount;
    finally
      wic.Free;
      fs.Free;
    end;
  end
  else
    result := 0;
end;

var iegWICAvailable:boolean = false;
    iegWICTested:boolean = false;


{!!
<FS>IEWICAvailable

<FM>Declaration<FC>
function IEWICAvailable:boolean;

<FM>Description<FN>
Returns True if WIC interfaces are available. This means that Microsoft HD Photo is also available.
!!}
{$ifdef IEDOTNETVERSION}
  function IEWICAvailable:boolean;
  begin
    iegWICTested := true;
    iegWICAvailable := true;
    result := true;
  end;
{$else}
  function IEWICAvailable:boolean;
  var
    factory:IE_IWICImagingFactory;
    oleInit:boolean;
  begin
    if not iegWICTested then
    begin
      oleInit := Succeeded(OleInitialize(nil));

      try
        factory := nil;
        CoCreateInstance(CLSID_WICImagingFactory, nil, CLSCTX_INPROC_SERVER, IE_IWICImagingFactory, factory);
        iegWICAvailable := assigned(factory);
        factory := nil;

      finally
        if oleInit then
          OleUninitialize;
      end;

      iegWICTested := true;
    end;
    result := iegWICAvailable;
  end;
{$endif}



{$ELSE} // {$ifdef IEINCLUDEWIC}

interface

function IEWICAvailable:boolean;


implementation


function IEWICAvailable:boolean;
begin
  result := false;
end;

{$ENDIF}


end.
