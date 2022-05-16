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
File version 1027
*)

unit imageenio;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

{$R-}
{$Q-}

{$I ie.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ieview,
  ImageEnProc, ExtCtrls, hyiedefs, hyieutils, Dialogs,
{$IFDEF IEINCLUDETWAIN}
  ietwain,
{$ENDIF}
{$IFDEF IEINCLUDEWIA}
  iewia,
{$ENDIF}
{$IFDEF IEINCLUDEDIRECTSHOW}
  ieds,
{$ENDIF}
{$ifdef FPC}
  lmetafile,
{$endif}
  printers;

const
  IEMAXICOIMAGES = 16;

  // Jpeg markers
  JPEG_APP0 = $E0;
  JPEG_APP1 = $E1;
  JPEG_APP2 = $E2;
  JPEG_APP3 = $E3;
  JPEG_APP4 = $E4;
  JPEG_APP5 = $E5;
  JPEG_APP6 = $E6;
  JPEG_APP7 = $E7;
  JPEG_APP8 = $E8;
  JPEG_APP9 = $E9;
  JPEG_APP10 = $EA;
  JPEG_APP11 = $EB;
  JPEG_APP12 = $EC;
  JPEG_APP13 = $ED;
  JPEG_APP14 = $EE;
  JPEG_APP15 = $EF;
  JPEG_COM = $FE;

  // Standard TWain sizes
  IETW_NONE = 0;
  IETW_A4LETTER = 1;
  IETW_B5LETTER = 2;
  IETW_USLETTER = 3;
  IETW_USLEGAL = 4;
  IETW_A5 = 5;
  IETW_B4 = 6;
  IETW_B6 = 7;
  IETW_USLEDGER = 9;
  IETW_USEXECUTIVE = 10;
  IETW_A3 = 11;
  IETW_B3 = 12;
  IETW_A6 = 13;
  IETW_C4 = 14;
  IETW_C5 = 15;
  IETW_C6 = 16;
  IETW_4A0 = 17;
  IETW_2A0 = 18;
  IETW_A0 = 19;
  IETW_A1 = 20;
  IETW_A2 = 21;
  IETW_A4 = IETW_A4LETTER;
  IETW_A7 = 22;
  IETW_A8 = 23;
  IETW_A9 = 24;
  IETW_A10 = 25;
  IETW_ISOB0 = 26;
  IETW_ISOB1 = 27;
  IETW_ISOB2 = 28;
  IETW_ISOB3 = IETW_B3;
  IETW_ISOB4 = IETW_B4;
  IETW_ISOB5 = 29;
  IETW_ISOB6 = IETW_B6;
  IETW_ISOB7 = 30;
  IETW_ISOB8 = 31;
  IETW_ISOB9 = 32;
  IETW_ISOB10 = 33;
  IETW_JISB0 = 34;
  IETW_JISB1 = 35;
  IETW_JISB2 = 36;
  IETW_JISB3 = 37;
  IETW_JISB4 = 38;
  IETW_JISB5 = IETW_B5LETTER;
  IETW_JISB6 = 39;
  IETW_JISB7 = 40;
  IETW_JISB8 = 41;
  IETW_JISB9 = 42;
  IETW_JISB10 = 43;
  IETW_C0 = 44;
  IETW_C1 = 45;
  IETW_C2 = 46;
  IETW_C3 = 47;
  IETW_C7 = 48;
  IETW_C8 = 49;
  IETW_C9 = 50;
  IETW_C10 = 51;
  IETW_USSTATEMENT = 52;
  IETW_BUSINESSCARD = 53;

type

{!!
<FS>TIETextFormat

<FM>Declaration<FC>
TIETextFormat = (ietfPascal, ietfHEX, ietfBase64, ietfASCIIArt);

<FM>Description<FN>

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>ietfPascal<FN></C> <C>
In this case the format is like:<FC>
  const
    'FileName_Extension_Size' = nnnn;
    'FileName_Extension' : array [0..'FileName_Extension_Size'-1] of byte = ( $xx,$xx );<FN>
This is useful when you want embed the image inside a .pas file. You can load back the image writing:<FC>
  ImageEnView1.IO.LoadFromBuffer(FileName_Extension, FileName_Extension_Size, fileformat );<FN>
</C> </R>
<R> <C><FC>ietfHEX<FN></C> <C>
Saves the image as a sequence of hex values. Example:<FC>
   0xaa,0xbb,etc...<FN>
</C> </R>
<R> <C><FC>ietfBase64<FN></C> <C>
Saves the image encoded with base 64 (the base of Mime64). Example:<FC>
  /9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAYEBQYF....<FN>
</C> </R>
<R> <C><FC>ietfASCIIArt<FN></C> <C>
Saves the image as an ascii art. We suggest to subsample the image before save as ascii art. <FC>ImageFormat<FN> field of <A TImageEnIO.SaveToText> must be <FC>ioUnknown<FN>.</C> </R>
</TABLE>

!!}
TIETextFormat = (ietfPascal, ietfHEX, ietfBase64, ietfASCIIArt);


{!!
<FS>TIEAcquireApi

<FM>Declaration<FC>
TIEAcquireApi = (ieaTWain, ieaWIA);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ieaTWain</C> <C>Acquire from Twain device</C> </R>
<R> <C>ieaWIA</C> <C>Acquire from WIA (scanners or camera)</C> </R>
</TABLE>
!!}
  TIEAcquireApi = (ieaTWain, ieaWIA);

{!!
<FS>TIEAcquireBitmapEvent

<FM>Declaration<FC>
TIEAcquireBitmapEvent = procedure(Sender: TObject; ABitmap: <A TIEBitmap>; var Handled: boolean) of object;

<FM>Description<FN>
<FC>ABitmap<FN> is a TIEBitmap object that contains the acquired image.
Setting Handled to True (default is False) causes ImageEn to ignore this image (does not insert it in the <A TImageEnMView> control, if present).
!!}
  TIEAcquireBitmapEvent = procedure(Sender: TObject; ABitmap: TIEBitmap; var Handled: boolean) of object;

{!!
<FS>TIEAfterAcquireBitmapEvent

<FM>Declaration<FC>
TIEAfterAcquireBitmapEvent = procedure(Sender:TObject; index:integer) of object;

<FM>Description<FN>
Event fired just after an image is acquired and added to the image list.
<FC>index<FN> specifies the index of the added image.
!!}
  TIEAfterAcquireBitmapEvent = procedure(Sender:TObject; index:integer) of object;


{!!
<FS>TIEJpegTransform

<FM>Declaration<FC>
TIEJpegTransform = (jtNone, jtCut, jtHorizFlip, jtVertFlip, jtTranspose, jtTransverse, jtRotate90, jtRotate180, jtRotate270);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>jtNone</C> <C>no transformation</C> </R>
<R> <C>jtCut</C> <C>cuts out part of the image</C> </R>
<R> <C>jtHorizFlip</C> <C>Mirrors image horizontally (left-right).</C> </R>
<R> <C>jtVertFlip</C> <C>Mirrors image vertically (top-bottom).</C> </R>
<R> <C>jtTranspose</C> <C>Transposes image (across UL-to-LR axis).</C> </R>
<R> <C>jtTransverse</C> <C>Transverse transpose (across UR-to-LL axis).</C> </R>
<R> <C>jtRotate90</C> <C>Rotates image 90 degrees clockwise.</C> </R>
<R> <C>jtRotate180</C> <C>Rotates image 180 degrees.</C> </R>
<R> <C>jtRotate270</C> <C>Rotates image 270 degrees clockwise (or 90 ccw).</C> </R>
</TABLE>
!!}
  TIEJpegTransform = (jtNone, jtCut, jtHorizFlip, jtVertFlip, jtTranspose, jtTransverse, jtRotate90, jtRotate180, jtRotate270);

{!!
<FS>TIEJpegCopyMarkers

<FM>Declaration<FC>
TIEJpegCopyMarkers = (jcCopyNone, jcCopyComments, jcCopyAll);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>jcCopyNone</C> <C>Copy no extra markers from source file. This setting suppresses all comments and other excess baggage present in the source file.</C> </R>
<R> <C>jcCopyComments</C> <C>Copy only comment markers. This setting copies comments from the source file, but discards any other inessential data.</C> </R>
<R> <C>jcCopyAll</C> <C>Copy all extra markers. This setting preserves miscellaneous markers found in the source file, such as JFIF thumbnails and Photoshop settings. In some files these extra markers can be sizable.</C> </R>
</TABLE>
!!}
  TIEJpegCopyMarkers = (jcCopyNone, jcCopyComments, jcCopyAll);

  // Header used to save a jpeg inside a Stream
  TStreamJpegHeader = record
    ID: array[0..4] of AnsiChar; // ="JFIF\0"
    dim: integer; // length of jpeg box
  end;

  // Header used to save a PCX inside a Stream
  PCXSHead = record
    ID: array[0..4] of AnsiChar; // 'PCX2\0'
    dim: integer;
  end;

  // Header used to save a TIFF inside a Stream
  TIFFSHead = record
    ID: array[0..4] of AnsiChar; // 'TIFF\0'
    dim: integer;
  end;

{!!
<FS>TPreviewParams

<FM>Declaration<FC>
type TPreviewParams = set of (ppALL, ppAUTO, ppJPEG, ppTIFF, ppGIF, ppBMP, ppPCX, ppPNG, ppTGA, ppJ2000);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ppALL</C> <C>shows all pages.</C> </R>
<R> <C>ppAUTO</C> <C>shows the page specified in Params.FileType property.</C> </R>
<R> <C>ppJPEG</C> <C>shows JPEG parameters.</C> </R>
<R> <C>ppTIFF</C> <C>shows TIFF paramaters.</C> </R>
<R> <C>ppGIF</C> <C>shows GIF, non-animated paramters.</C> </R>
<R> <C>ppBMP</C> <C>shows BMP parameters.</C> </R>
<R> <C>ppPCX</C> <C>shows PCX parameters.</C> </R>
<R> <C>ppPNG</C> <C>shows PNG parameters.</C> </R>
<R> <C>ppTGA</C> <C>shows TGA parameters.</C> </R>
<R> <C>ppJ2000</C> <C>shows JPEG2000 parameters.</C> </R>
</TABLE>
!!}
  TPreviewParams = set of (
    ppALL,
    ppAUTO,
    ppJPEG,
    ppTIFF,
    ppGIF,
    ppBMP,
    ppPCX,
    ppPNG,
    ppTGA
{$IFDEF IEINCLUDEJPEG2000}
    , ppJ2000
{$ENDIF}
    );

  TGIFLZWCompFunc = procedure(Stream: TStream; Height, Width: integer; Interlaced: boolean; FData: PAnsiChar; BitsPerPixel: integer);

  TGIFLZWDecompFunc = procedure(Stream: TStream; Height, Width: integer; Interlaced: boolean; FData: PAnsiChar);

  TTIFFLZWDecompFunc = function(CompBuf: pbyte; LineSize: integer; var Id: pointer; FillOrder:integer): pbyte;

  TTIFFLZWCompFunc = procedure(indata: pbyte; inputlen: integer; outstream: TStream; var id: pointer);

  // previews properties

{!!
<FS>TIOPreviewsParamsItems

<FM>Declaration<FC>
TIOPreviewsParamsItems = (ioppDefaultLockPreview, ioppApplyButton);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ioppDefaultLockPreview</C> <C>the "Lock preview" button will be down</C> </R>
<R> <C>ioppApplyButton</C> <C>the "Apply" button is shown</C> </R>
</TABLE>
!!}
  TIOPreviewsParamsItems = (ioppDefaultLockPreview, ioppApplyButton);

{!!
<FS>TIOPreviewsParams

<FM>Declaration<FC>
TIOPreviewsParams = set of <A TIOPreviewsParamsItems>;
!!}
  TIOPreviewsParams = set of TIOPreviewsParamsItems;

  // printing properties

{!!
<FS>TIEVerticalPos

<FM>Declaration<FC>
TIEVerticalPos = (ievpTOP, ievpCENTER, ievpBOTTOM);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ievpTOP</C> <C>the image is top aligned</C> </R>
<R> <C>ievpCENTER</C> <C>the image is center aligned</C> </R>
<R> <C>ievpBOTTOM</C> <C>the image is bottom aligned</C> </R>
</TABLE>
!!}
  TIEVerticalPos = (ievpTOP, ievpCENTER, ievpBOTTOM);

{!!
<FS>TIEHorizontalPos

<FM>Declaration<FC>
TIEHorizontalPos = (iehpLEFT, iehpCENTER, iehpRIGHT);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>iehpLEFT</C> <C>the image is left aligned</C> </R>
<R> <C>iehpCENTER</C> <C>the image is center aligned</C> </R>
<R> <C>iehpRIGHT</C> <C>the image is right aligned</C> </R>
</TABLE>
!!}
  TIEHorizontalPos = (iehpLEFT, iehpCENTER, iehpRIGHT);

{!!
<FS>TIESize

<FM>Declaration<FC>
TIESize = (iesNORMAL, iesFITTOPAGE, iesFITTOPAGESTRETCH, iesSPECIFIEDSIZE);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>iesNORMAL</C> <C>the size is determined by original image DPI (used for real size copy)</C> </R>
<R> <C>iesFITTOPAGE</C> <C>stretch the image to fit the page respecting the proportions</C> </R>
<R> <C>iesFITTOPAGESTRETCH</C> <C>stretch the image to fit the page</C> </R>
<R> <C>iesSPECIFIEDSIZE</C> <C>specify absolute sizes with the SpecWidth and SpecHeight parameters</C> </R>
</TABLE>
!!}
  TIESize = (iesNORMAL, iesFITTOPAGE, iesFITTOPAGESTRETCH, iesSPECIFIEDSIZE);



{!!
<FS>TIECreateAVIFileResult

<FM>Declaration<FC>
TIECreateAVIFileResult = (ieaviOK, ieaviNOCOMPRESSOR, ieaviMEMORY, ieaviUNSUPPORTED);


<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ieaviOK</C> <C>No error.</C> </R>
<R> <C>ieaviNOCOMPRESSOR</C> <C>A suitable compressor cannot be found.</C> </R>
<R> <C>ieaviMEMORY</C> <C>There is not enough memory to complete the operation.</C> </R>
<R> <C>ieaviUNSUPPORTED</C> <C>Compression is not supported for this type of data.</C> </R>
</TABLE>
!!}
TIECreateAVIFileResult = (ieaviOK, ieaviNOCOMPRESSOR, ieaviMEMORY, ieaviUNSUPPORTED);


{!!
<FS>TIOPSCompression

<FM>Declaration<FC>
TIOPSCompression = (ioPS_RLE, ioPS_G4FAX, ioPS_G3FAX2D, ioPS_JPEG);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ioPS_RLE</C> <C>run length compression</C> </R>
<R> <C>ioPS_G4FAX</C> <C>G4Fax (only black/white images)</C> </R>
<R> <C>ioPS_G3FAX2D</C> <C>G3Fax (only black/white images)</C> </R>
<R> <C>ioPS_JPEG</C> <C>DCT-jpeg (only color images)</C> </R>
</TABLE>
!!}
  TIOPSCompression = (
    ioPS_RLE,
    ioPS_G4FAX,
    ioPS_G3FAX2D,
    ioPS_JPEG
    );

{!!
<FS>TIOPDFCompression

<FM>Declaration<FC>
  TIOPDFCompression = (
    ioPDF_UNCOMPRESSED,
    ioPDF_RLE,
    ioPDF_G4FAX,
    ioPDF_G3FAX2D,
    ioPDF_JPEG,
    ioPDF_LZW
    );

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ioPDF_UNCOMPRESSED</C> <C>no compression</C> </R>
<R> <C>ioPDF_RLE</C> <C>run length compression</C> </R>
<R> <C>ioPDF_G4FAX</C> <C>G4Fax (only black/white images)</C> </R>
<R> <C>ioPDF_G3FAX2D</C> <C>G3Fax (only black/white images)</C> </R>
<R> <C>ioPDF_JPEG</C> <C>DCT-jpeg (only color images)</C> </R>
<R> <C>ioPDF_LZW</C> <C>LZW compression (for color and black/white images)</C> </R>
</TABLE>
!!}
  TIOPDFCompression = (
    ioPDF_UNCOMPRESSED,
    ioPDF_RLE,
    ioPDF_G4FAX,
    ioPDF_G3FAX2D,
    ioPDF_JPEG,
    ioPDF_LZW
    );

{!!
<FS>TIOTIFFCompression

<FM>Declaration<FC>
type TIOTIFFCompression = (ioTIFF_UNCOMPRESSED, ioTIFF_CCITT1D, ioTIFF_G3FAX1D, ioTIFF_G3FAX2D, ioTIFF_G4FAX, ioTIFF_LZW, ioTIFF_OLDJPEG, ioTIFF_JPEG, ioTIFF_PACKBITS, ioTIFF_ZIP, ioTIFF_DEFLATE, ioTIFF_UNKNOWN);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ioTIFF_UNCOMPRESSED</C> <C>Uncompressed TIFF. Supports all pixel formats and alpha channel.</C> </R>
<R> <C>ioTIFF_CCITT1D</C> <C>Bilevel Huffman compression. Only black/white images, no alpha channel.</C> </R>
<R> <C>ioTIFF_G3FAX1D</C> <C>Bilevel Group 3 CCITT compression, monodimensional. Only black/white images, no alpha channel.</C> </R>
<R> <C>ioTIFF_G3FAX2D</C> <C>Bilevel Group 3 CCITT compression, bidimensional. Only black/white images, no alpha channel.</C> </R>
<R> <C>ioTIFF_G4FAX</C> <C>Bilevel Group 4 CCITT compression, bidimensional. Only black/white images, no alpha channel.</C> </R>
<R> <C>IoTIFF_LZW</C> <C>LZW compression. Supports alpha channel.</C> </R>
<R> <C>ioTIFF_OLDJPEG</C> <C>Ver.6.0 jpeg compression (unsupported). Only true color images, no alpha channel.</C> </R>
<R> <C>ioTIFF_JPEG</C> <C>Jpeg compression. Only true color images, no alpha channel.</C> </R>
<R> <C>ioTIFF_PACKBITS</C> <C>RLE compression. Supports alpha channel.</C> </R>
<R> <C>ioTIFF_ZIP</C> <C>ZIP compression (non TIFF standard). No alpha channel.</C> </R>
<R> <C>ioTIFF_DEFLATE</C> <C>Adobe ZIP compression (non TIFF standard). No alpha channel.</C> </R>
<R> <C>ioTIFF_UNKNOWN</C> <C>Unknown compression</C> </R>
</TABLE>

For black/white compressions (ioTIFF_CCITT1D, ioTIFF_G3FAX1D, ioTIFF_G3FAX2D and ioTIFF_G4FAX) make sure that <A TIOParamsVals.BitsPerSample>=1 and <A TIOParamsVals.SamplesPerPixel>=1. Example:<FC>
ImageEnView1.IO.Params.TIFF_Compression := ioTIFF_G4FAX;
ImageEnView1.IO.Params.BitsPerSample := 1;
ImageEnView1.IO.Params.SamplesPerPixel := 1;
ImageEnView1.IO.SaveToFile('output.tif');<FN>

!!}
  TIOTIFFCompression = (
    ioTIFF_UNCOMPRESSED,
    ioTIFF_CCITT1D,
    ioTIFF_G3FAX1D,
    ioTIFF_G3FAX2D,
    ioTIFF_G4FAX,
    ioTIFF_LZW,
    ioTIFF_OLDJPEG,
    ioTIFF_JPEG,
    ioTIFF_PACKBITS,
    ioTIFF_ZIP,
    ioTIFF_DEFLATE,
    ioTIFF_UNKNOWN);
{!!
<FS>TIOTIFFPhotometInterpret

<FM>Declaration<FC>
type TIOTIFFPhotometInterpret = (ioTIFF_WHITEISZERO, ioTIFF_BLACKISZERO, ioTIFF_RGB, ioTIFF_RGBPALETTE, ioTIFF_TRANSPMASK, ioTIFF_CMYK, ioTIFF_YCBCR, ioTIFF_CIELAB);

!!}
  TIOTIFFPhotometInterpret = (
    ioTIFF_WHITEISZERO,
    ioTIFF_BLACKISZERO,
    ioTIFF_RGB,
    ioTIFF_RGBPALETTE,
    ioTIFF_TRANSPMASK,
    ioTIFF_CMYK,
    ioTIFF_YCBCR,
    ioTIFF_CIELAB);

{!!
<FS>TIOJPEGColorspace

<FM>Declaration<FC>
type TIOJPEGColorspace=(ioJPEG_RGB, ioJPEG_GRAYLEV, ioJPEG_YCbCr, ioJPEG_CMYK, ioJPEG_YCbCrK);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ioJPEG_RGB</C> <C>separate RGB channels.</C> </R>
<R> <C>ioJPEG_GRAYLEV</C> <C>unique intensity channel (gray levels).</C> </R>
<R> <C>ioJPEG_YCbCr</C> <C>three channels (CCIR Recommendation 601-1)</C> </R>
<R> <C>ioJPEG_CMYK</C> <C>four channels (Cyan Magenta Yellow Black) - linear conversion</C> </R>
<R> <C>ioJPEG_YCbCrK</C> <C>four channels (YCbCr and Black)</C> </R>
</TABLE>
!!}
  TIOJPEGColorspace = (
    ioJPEG_RGB,
    ioJPEG_GRAYLEV,
    ioJPEG_YCbCr,
    ioJPEG_CMYK,
    ioJPEG_YCbCrK);

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TIOJ2000ColorSpace

<FM>Declaration<FC>
  TIOJ2000ColorSpace = (
    ioJ2000_GRAYLEV,
    ioJ2000_RGB,
    ioJ2000_YCbCr);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H>
<R> <C>ioJ2000_GRAYLEV</C> <C>Gray scale image</C> </R>
<R> <C>ioJ2000_RGB</C> <C>RGB image</C> </R>
<R> <C>ioJ2000_YcbCr</C> <C>YcbCr image (currently supported only for loading)</C> </R>
</TABLE>
!!}
  TIOJ2000ColorSpace = (
    ioJ2000_GRAYLEV,
    ioJ2000_RGB,
    ioJ2000_YCbCr);

{!!
<FS>TIOJ2000ScalableBy

<FM>Declaration<FC>
  TIOJ2000ScalableBy = (
    ioJ2000_Rate,
    ioJ2000_Resolution);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H>
<R> <C>ioJ2000_Rate</C> <C>layer-resolution-component-position (LRCP) progressive (i.e., rate scalable)</C> </R>
<R> <C>ioJ2000_Resolution</C> <C>resolution-layer-component-position (RLCP) progressive (i.e., resolution scalable)</C> </R>
</TABLE>
!!}
  TIOJ2000ScalableBy = (
    ioJ2000_Rate,
    ioJ2000_Resolution);

{$ENDIF}

{!!
<FS>TIOJPEGDctMethod

<FM>Declaration<FC>
type TIOJPEGDctMethod = (ioJPEG_ISLOW, ioJPEG_IFAST, ioJPEG_FLOAT);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H>
<R> <C>ioJPEG_ISLOW</C> <C>slow but accurate integer algorithm (default).</C> </R>
<R> <C>ioJPEG_IFAST</C> <C>faster, less accurate integer method.</C> </R>
<R> <C>ioJPEG_FLOAT</C> <C>floating-point method (machine dependent).</C> </R>
</TABLE>
!!}
  TIOJPEGDctMethod = (
    ioJPEG_ISLOW,
    ioJPEG_IFAST,
    ioJPEG_FLOAT);

{!!
<FS>TIOJPEGCromaSubsampling

<FM>Declaration<FC>
type TIOJPEGCromaSubsampling = (ioJPEG_MEDIUM, ioJPEG_HIGH, ioJPEG_NONE);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H>
<R> <C>ioJPEG_MEDIUM</C> <C>4:2:2 croma subsampling. Medium quality.</C> </R>
<R> <C>ioJPEG_HIGH</C> <C>4:1:1 croma subsampling. Default quality for jpegs. Lowest quality.</C> </R>
<R> <C>ioJPEG_NONE</C> <C>4:4:4 croma subsampling. Highest quality.</C> </R>
</TABLE>
!!}
  TIOJPEGCromaSubsampling = (
      ioJPEG_MEDIUM,
      ioJPEG_HIGH,
      ioJPEG_NONE);

{!!
<FS>TIOJPEGScale

<FM>Declaration<FC>
  TIOJPEGScale = (
    ioJPEG_AUTOCALC,
    ioJPEG_FULLSIZE,
    ioJPEG_HALF,
    ioJPEG_QUARTER,
    ioJPEG_EIGHTH);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ioJPEG_AUTOCALC</C> <C>self calculates JPEGScale to match <A TIOParamsVals.Width> and <A TIOParamsVals.Height> properties;</C> </R>
<R> <C>ioJPEG_FULLSIZE</C> <C>full size image (default). Slow loading.</C> </R>
<R> <C>ioJPEG_HALF</C> <C>1/2 of the full size;</C> </R>
<R> <C>ioJPEG_QUARTER</C> <C>1/4 of the full size;</C> </R>
<R> <C>ioJPEG_EIGHTH</C> <C>1/8 of the full size. Very fast loading.</C> </R>
</TABLE>
!!}
  TIOJPEGScale = (
    ioJPEG_AUTOCALC,
    ioJPEG_FULLSIZE,
    ioJPEG_HALF,
    ioJPEG_QUARTER,
    ioJPEG_EIGHTH);

{!!
<FS>TIOBMPVersion

<FM>Declaration<FC>
type TIOBMPVersion = (ioBMP_BM, ioBMP_BM3, ioBMP_BMOS2V1, ioBMP_BMOS2V2);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ioBMP_BM</C> <C>old Windows bitmap.</C> </R>
<R> <C>ioBMP_BM3</C> <C>Windows 3.x or newer bitmap.</C> </R>
<R> <C>ioBMP_BMOS2V1</C> <C>IBM OS/2 version 1.x bitmap.</C> </R>
<R> <C>ioBMP_BMOS2V2</C> <C>IBM OS/2 version 2.x bitmap.</C> </R>
</TABLE>
!!}
  TIOBMPVersion = (
    ioBMP_BM,
    ioBMP_BM3,
    ioBMP_BMOS2V1,
    ioBMP_BMOS2V2);

{!!
<FS>TIOBMPCompression

<FM>Declaration<FC>
type TIOBMPCompression = (ioBMP_UNCOMPRESSED, ioBMP_RLE);

<FM>Description<FN>
Use ioBMP_UNCOMPRESSED to save uncompressed bitmap.
Use ioBMP_RLE to save compressed bitmap (which would can be bigger of uncompressed...).
!!}
  TIOBMPCompression = (
    ioBMP_UNCOMPRESSED,
    ioBMP_RLE);

{!!
<FS>TIOPCXCompression

<FM>Declaration<FC>
type TIOPCXCompression = (ioPCX_UNCOMPRESSED, ioPCX_RLE);

<FM>Description<FN>
ioPCX_UNCOMPRESSED is uncompressed PCX (incompatible with most PCX readers).
ioPCX_RLE is compressed PCX (standard PCX).
!!}
  TIOPCXCompression = (
    ioPCX_UNCOMPRESSED,
    ioPCX_RLE);

{!!
<FS>TIOPNGFilter

<FM>Declaration<FC>
}
  TIOPNGFilter = (
    ioPNG_FILTER_NONE,
    ioPNG_FILTER_SUB,
    ioPNG_FILTER_PAETH);
{!!}

{!!
<FS>TIEGIFAction

<FM>Declaration<FC>
}
  TIEGIFAction = (
    ioGIF_None,
    ioGIF_DontRemove,
    ioGIF_DrawBackground,
    ioGIF_RestorePrev);
{!!}


{!!
<FS>TIOFileType

<FM>Declaration<FC>
TIOFileType = integer;

<FM>Description<FN>
Specifies a file format supported by ImageEn (for read-write, read-only or write-only).

<TABLE>
<R> <H>Constant</H> <H>Description</H> </R>
<R> <C>ioUnknown</C> <C>Unknown file format</C> </R>
<R> <C>ioTIFF</C> <C>TIFF Bitmap</C> </R>
<R> <C>ioGIF</C> <C>GIF</C> </R>
<R> <C>ioJPEG</C> <C>Jpeg bitmap</C> </R>
<R> <C>ioPCX</C> <C>PaintBrush PCX</C> </R>
<R> <C>ioBMP</C> <C>Windows Bitmap</C> </R>
<R> <C>ioICO</C> <C>Windows Icon</C> </R>
<R> <C>ioCUR</C> <C>Windows Cursor</C> </R>
<R> <C>ioPNG</C> <C>Portable Network Graphics</C> </R>
<R> <C>ioWMF</C> <C>Windows Metafile</C> </R>
<R> <C>ioEMF</C> <C>Enhanced Windows Metafile</C> </R>
<R> <C>ioTGA</C> <C>Targa Bitmap</C> </R>
<R> <C>ioPXM</C> <C>Portable Pixmap, GreyMap, BitMap</C> </R>
<R> <C>ioJP2</C> <C>Jpeg2000</C> </R>
<R> <C>ioJ2K</C> <C>Jpeg2000</C> </R>
<R> <C>ioAVI</C> <C>AVI video</C> </R>
<R> <C>ioWBMP</C> <C>Wireless bitmap</C> </R>
<R> <C>ioPS</C> <C>Postscript</C> </R>
<R> <C>ioPDF</C> <C>Adobe PDF</C> </R>
<R> <C>ioDCX</C> <C>Multipage PCX</C> </R>
<R> <C>ioRAW</C> <C>Digital Camera RAW</C> </R>
<R> <C>ioBMPRAW</C> <C>Bitmap RAW</C> </R>
<R> <C>ioWMV</C> <C>Windows Media</C> </R>
<R> <C>ioMPEG</C> <C>Video MPEG</C> </R>
<R> <C>ioPSD</C> <C>Adobe Photoshop PSD</C> </R>
<R> <C>ioIEV</C> <C>Vectorial objects (<A TImageEnVect.SaveToFileIEV>)</C> </R>
<R> <C>ioLYR</C> <C>Layers (<A TImageEnView.LayersSaveToFile>)</C> </R>
<R> <C>ioALL</C> <C>Combined layers and vectorial objects (<A TImageEnVect.SaveToFileAll>)</C> </R>
<R> <C>ioDICOM</C> <C>DICOM medical imaging</C> </R>
<R> <C>ioHDP</C> <C>Microsoft HD Photo. Requires Windows XP (SP2) with .Net 3.0, Windows Vista</C> </R>
<R> <C>ioDLLPLUGINS + offset</C> <C>External plugins (ie dcraw)</C> </R>
<R> <C>ioUSER + offset</C> <C>User registered file formats</C> </R>
</TABLE>
!!}
  TIOFileType = integer;

const
  // types for TIOFileType
  ioUnknown = 0;
  ioTIFF = 1;
  ioGIF = 2;
  ioJPEG = 3;
  ioPCX = 4;
  ioBMP = 5;
  ioICO = 6;
  ioCUR = 7;
  ioPNG = 8;
  ioWMF = 9;
  ioEMF = 10;
  ioTGA = 11;
  ioPXM = 12;
  ioJP2 = 13;
  ioJ2K = 14;
  ioAVI = 15;
  ioWBMP = 16;
  ioPS = 17;
  ioPDF = 18;
  ioDCX = 19;
  ioRAW = 20;
  ioBMPRAW = 21;
  ioWMV = 22;
  ioMPEG = 23;
  ioPSD = 24;
  ioIEV = 25;
  ioLYR = 26;
  ioALL = 27;
  ioDICOM = 28;
  ioHDP = 29;
  ioRAS = 30; // sun RAS (supported by ievision)
  ioDLLPLUGINS = 4096;
  ioUSER = 10000;

type

{!!
<FS>TIOICOSizes

<FM>Declaration<FC>
}
  TIOICOSizes = array[0..IEMAXICOIMAGES - 1] of TSize;
{!!}

{!!
<FS>TIOICOBitCount

<FM>Declaration<FC>
}
  TIOICOBitCount = array[0..IEMAXICOIMAGES - 1] of integer;
{!!}


{!!
<FS>TIOBMPRAWChannelOrder

<FM>Declaration<FC>
}
  TIOBMPRAWChannelOrder=(coRGB, coBGR);
{!!}

{!!
<FS>TIOBMPRAWDataFormat

<FM>Declaration<FC>
TIOBMPRAWDataFormat = (dfBinary, dfTextDecimal, dfTextHex);

<FM>Description<FN>
<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>dfBinary<FN></C> <C>Binary raw data.</C> </R>
<R> <C><FC>dfTextDecimal<FN></C> <C>Ascii text as decimal values.</C> </R>
<R> <C><FC>dfTextHex<FN></C> <C>Ascii text as hexadecimal values.</C> </R>
</TABLE>
!!}
TIOBMPRAWDataFormat = (dfBinary, dfTextDecimal, dfTextHex);

{!!
<FS>TIOBMPRAWPlanes

<FM>Declaration<FC>
TIOBMPRAWPlanes=(plInterleaved, plPlanar);

<FM>Description<FN>
In plInterleaved channels are B,G,R,B,G,R... otherwise they are BBB.., GGG.., RRR...
!!}
  TIOBMPRAWPlanes=(plInterleaved, plPlanar);

{!!
<FS>TIOByteOrder

<FM>Declaration<FC>
}
  TIOByteOrder = (ioBigEndian, ioLittleEndian); // ioBigEndian=Motorola, ioLittleEndian=Intel
{!!}


const
  IEEXIFUSERCOMMENTCODE_UNICODE:AnsiString   = #$55#$4E#$49#$43#$4F#$44#$45#$00;
  IEEXIFUSERCOMMENTCODE_ASCII:AnsiString     = #$41#$53#$43#$49#$49#$00#$00#$00;
  IEEXIFUSERCOMMENTCODE_JIS:AnsiString       = #$4A#$49#$53#$00#$00#$00#$00#$00;
  IEEXIFUSERCOMMENTCODE_UNDEFINED:AnsiString = #$00#$00#$00#$00#$00#$00#$00#$00;

type

  TImageEnIO = class;

{!!
<FS>TIOParamsVals

<FM>Description<FN>
TIOParamsVals object contains all parameters for all image file formats handled by ImageEn, such as compression type, text comments, bit per sample, samples per pixel, etc.
You can set one or more of these parameters before saving or get them after loading with the exception of "export only" file formats like PDF, PS, etc which can be only saved: so you cannot load parameters from them.

<FM>See also<FN>

<A TImageEnIO.Params>
<A TImageEnDBView.IOParams>

<FM>Methods and Properties<FN>

  <FI>Properties storage handling<FN>

  <A TIOParamsVals.Assign>
  <A TIOParamsVals.Create>
  <A TIOParamsVals.LoadFromFile>
  <A TIOParamsVals.LoadFromStream>
  <A TIOParamsVals.ResetEXIF>
  <A TIOParamsVals.ResetInfo>
  <A TIOParamsVals.SaveToFile>
  <A TIOParamsVals.SaveToStream>
  <A TIOParamsVals.SetDefaultParams>
  <A TIOParamsVals.UpdateEXIFThumbnail>

  <FI>Commons<FN>

  <A TIOParamsVals.BitsPerSample>
  <A TIOParamsVals.ColorMapCount>
  <A TIOParamsVals.ColorMap>
  <A TIOParamsVals.DefaultICCProfile>
  <A TIOParamsVals.Dpi>
  <A TIOParamsVals.DpiX>
  <A TIOParamsVals.DpiY>
  <A TIOParamsVals.EnableAdjustOrientation>
  <A TIOParamsVals.FileName>
  <A TIOParamsVals.FileTypeStr>
  <A TIOParamsVals.FileType>
  <A TIOParamsVals.GetThumbnail>
  <A TIOParamsVals.Height>
  <A TIOParamsVals.ImageCount>
  <A TIOParamsVals.ImageIndex>
  <A TIOParamsVals.ImagingAnnot>
  <A TIOParamsVals.InputICCProfile>
  <A TIOParamsVals.IsResource>
  <A TIOParamsVals.OutputICCProfile>
  <A TIOParamsVals.OriginalHeight>
  <A TIOParamsVals.OriginalWidth>
  <A TIOParamsVals.SamplesPerPixel>
  <A TIOParamsVals.Width>

  <FI>BMP<FN>

  <A TIOParamsVals.BMP_Compression>
  <A TIOParamsVals.BMP_HandleTransparency>
  <A TIOParamsVals.BMP_Version>

  <FI>GIF<FN>

  <A TIOParamsVals.GIF_Action>
  <A TIOParamsVals.GIF_Background>
  <A TIOParamsVals.GIF_Comments>
  <A TIOParamsVals.GIF_DelayTime>
  <A TIOParamsVals.GIF_FlagTranspColor>
  <A TIOParamsVals.GIF_ImageCount>
  <A TIOParamsVals.GIF_ImageIndex>
  <A TIOParamsVals.GIF_Interlaced>
  <A TIOParamsVals.GIF_Ratio>
  <A TIOParamsVals.GIF_TranspColor>
  <A TIOParamsVals.GIF_Version>
  <A TIOParamsVals.GIF_WinHeight>
  <A TIOParamsVals.GIF_WinWidth>
  <A TIOParamsVals.GIF_XPos>
  <A TIOParamsVals.GIF_YPos>

  <FI>JPEG<FN>

  <A TIOParamsVals.JPEG_ColorSpace>
  <A TIOParamsVals.JPEG_DCTMethod>
  <A TIOParamsVals.JPEG_CromaSubsampling>
  <A TIOParamsVals.JPEG_EnableAdjustOrientation>
  <A TIOParamsVals.JPEG_GetExifThumbnail>
  <A TIOParamsVals.JPEG_MarkerList>
  <A TIOParamsVals.JPEG_OptimalHuffman>
  <A TIOParamsVals.JPEG_OriginalWidth>
  <A TIOParamsVals.JPEG_OriginalHeight>
  <A TIOParamsVals.JPEG_Progressive>
  <A TIOParamsVals.JPEG_Quality>
  <A TIOParamsVals.JPEG_Scale_Used>
  <A TIOParamsVals.JPEG_Scale>
  <A TIOParamsVals.JPEG_Smooth>
  <A TIOParamsVals.JPEG_WarningCode>
  <A TIOParamsVals.JPEG_WarningTot>

  <FI>JPEG 2000<FN>

  <A TIOParamsVals.J2000_ColorSpace>
  <A TIOParamsVals.J2000_Rate>
  <A TIOParamsVals.J2000_ScalableBy>

  <FI>PCX<FN>

  <A TIOParamsVals.PCX_Compression>
  <A TIOParamsVals.PCX_Version>

  <FI>Adobe PSD<FN>

  <A TIOParamsVals.PSD_LoadLayers>
  <A TIOParamsVals.PSD_ReplaceLayers>
  <A TIOParamsVals.PSD_HasPremultipliedAlpha>

  <FI>HDP<FN>

  <A TIOParamsVals.HDP_ImageQuality>
  <A TIOParamsVals.HDP_Lossless>

  <FI>TIFF<FN>

  <A TIOParamsVals.TIFF_ByteOrder>
  <A TIOParamsVals.TIFF_Compression>
  <A TIOParamsVals.TIFF_DocumentName>
  <A TIOParamsVals.TIFF_EnableAdjustOrientation>
  <A TIOParamsVals.TIFF_GetTile>
  <A TIOParamsVals.TIFF_FillOrder>
  <A TIOParamsVals.TIFF_ImageCount>
  <A TIOParamsVals.TIFF_ImageDescription>
  <A TIOParamsVals.TIFF_ImageIndex>
  <A TIOParamsVals.TIFF_JPEGColorSpace>
  <A TIOParamsVals.TIFF_JPEGQuality>
  <A TIOParamsVals.TIFF_Orientation>
  <A TIOParamsVals.TIFF_PageCount>
  <A TIOParamsVals.TIFF_PageName>
  <A TIOParamsVals.TIFF_PageNumber>
  <A TIOParamsVals.TIFF_PhotometInterpret>
  <A TIOParamsVals.TIFF_PlanarConf>
  <A TIOParamsVals.TIFF_SubIndex>
  <A TIOParamsVals.TIFF_XPos>
  <A TIOParamsVals.TIFF_YPos>
  <A TIOParamsVals.TIFF_ZIPCompression>

  <FI>CUR<FN>

  <A TIOParamsVals.CUR_Background>
  <A TIOParamsVals.CUR_ImageIndex>
  <A TIOParamsVals.CUR_XHotSpot>
  <A TIOParamsVals.CUR_YHotSpot>

  <FI>DCX<FN>

  <A TIOParamsVals.DCX_ImageIndex>

  <FI>ICO<FN>

  <A TIOParamsVals.ICO_Background>
  <A TIOParamsVals.ICO_BitCount>
  <A TIOParamsVals.ICO_ImageIndex>
  <A TIOParamsVals.ICO_Sizes>

  <FI>PNG<FN>

  <A TIOParamsVals.PNG_Background>
  <A TIOParamsVals.PNG_Compression>
  <A TIOParamsVals.PNG_Filter>
  <A TIOParamsVals.PNG_Interlaced>
  <A TIOParamsVals.PNG_TextKeys>
  <A TIOParamsVals.PNG_TextValues>

  <FI>TGA<FN>

  <A TIOParamsVals.TGA_AspectRatio>
  <A TIOParamsVals.TGA_Author>
  <A TIOParamsVals.TGA_Background>
  <A TIOParamsVals.TGA_Compressed>
  <A TIOParamsVals.TGA_Date>
  <A TIOParamsVals.TGA_Descriptor>
  <A TIOParamsVals.TGA_Gamma>
  <A TIOParamsVals.TGA_GrayLevel>
  <A TIOParamsVals.TGA_ImageName>
  <A TIOParamsVals.TGA_XPos>
  <A TIOParamsVals.TGA_YPos>

  <FI>PXM<FN>

  <A TIOParamsVals.PXM_Comments>

  <FI>AVI<FN>

  <A TIOParamsVals.AVI_FrameCount>
  <A TIOParamsVals.AVI_FrameDelayTime>

  <FI>IPTC<FN>

  <A TIOParamsVals.IPTC_Info>

  <FI>EXIF tags<FN>

  <A TIOParamsVals.EXIF_ApertureValue>
  <A TIOParamsVals.EXIF_Artist>
  <A TIOParamsVals.EXIF_Bitmap>
  <A TIOParamsVals.EXIF_BrightnessValue>
  <A TIOParamsVals.EXIF_ColorSpace>
  <A TIOParamsVals.EXIF_CompressedBitsPerPixel>
  <A TIOParamsVals.EXIF_Contrast>
  <A TIOParamsVals.EXIF_Copyright>
  <A TIOParamsVals.EXIF_DateTimeDigitized>
  <A TIOParamsVals.EXIF_DateTimeOriginal>
  <A TIOParamsVals.EXIF_DateTime>
  <A TIOParamsVals.EXIF_DigitalZoomRatio>
  <A TIOParamsVals.EXIF_ExifImageHeight>
  <A TIOParamsVals.EXIF_ExifImageWidth>
  <A TIOParamsVals.EXIF_ExifVersion>
  <A TIOParamsVals.EXIF_ExposureBiasValue>
  <A TIOParamsVals.EXIF_ExposureIndex>
  <A TIOParamsVals.EXIF_ExposureMode>
  <A TIOParamsVals.EXIF_ExposureProgram>
  <A TIOParamsVals.EXIF_ExposureTime>
  <A TIOParamsVals.EXIF_FileSource>
  <A TIOParamsVals.EXIF_FlashPixVersion>
  <A TIOParamsVals.EXIF_Flash>
  <A TIOParamsVals.EXIF_FNumber>
  <A TIOParamsVals.EXIF_FocalLength>
  <A TIOParamsVals.EXIF_FocalLengthIn35mmFilm>
  <A TIOParamsVals.EXIF_FocalPlaneResolutionUnit>
  <A TIOParamsVals.EXIF_FocalPlaneXResolution>
  <A TIOParamsVals.EXIF_FocalPlaneYResolution>
  <A TIOParamsVals.EXIF_GainControl>
  <A TIOParamsVals.EXIF_HasEXIFData>
  <A TIOParamsVals.EXIF_ImageDescription>
  <A TIOParamsVals.EXIF_ImageUniqueID>
  <A TIOParamsVals.EXIF_ISOSpeedRatings>
  <A TIOParamsVals.EXIF_LightSource>
  <A TIOParamsVals.EXIF_Make>
  <A TIOParamsVals.EXIF_MakerNote>
  <A TIOParamsVals.EXIF_MaxApertureValue>
  <A TIOParamsVals.EXIF_MeteringMode>
  <A TIOParamsVals.EXIF_Model>
  <A TIOParamsVals.EXIF_Orientation>
  <A TIOParamsVals.EXIF_PrimaryChromaticities>
  <A TIOParamsVals.EXIF_ReferenceBlackWhite>
  <A TIOParamsVals.EXIF_RelatedSoundFile>
  <A TIOParamsVals.EXIF_ResolutionUnit>
  <A TIOParamsVals.EXIF_Saturation>
  <A TIOParamsVals.EXIF_SceneCaptureType>
  <A TIOParamsVals.EXIF_SceneType>
  <A TIOParamsVals.EXIF_SensingMethod>
  <A TIOParamsVals.EXIF_Sharpness>
  <A TIOParamsVals.EXIF_ShutterSpeedValue>
  <A TIOParamsVals.EXIF_Software>
  <A TIOParamsVals.EXIF_SubjectDistanceRange>
  <A TIOParamsVals.EXIF_SubjectDistance>
  <A TIOParamsVals.EXIF_SubsecTimeDigitized>
  <A TIOParamsVals.EXIF_SubsecTimeOriginal>
  <A TIOParamsVals.EXIF_SubsecTime>
  <A TIOParamsVals.EXIF_UserCommentCode>
  <A TIOParamsVals.EXIF_UserComment>
  <A TIOParamsVals.EXIF_WhiteBalance>
  <A TIOParamsVals.EXIF_WhitePoint>
  <A TIOParamsVals.EXIF_XResolution>
  <A TIOParamsVals.EXIF_YCbCrCoefficients>
  <A TIOParamsVals.EXIF_YCbCrPositioning>
  <A TIOParamsVals.EXIF_YResolution>

  <FI>EXIF Windows XP tags<FN>

  <A TIOParamsVals.EXIF_XPAuthor>
  <A TIOParamsVals.EXIF_XPComment>
  <A TIOParamsVals.EXIF_XPKeywords>
  <A TIOParamsVals.EXIF_XPRating>
  <A TIOParamsVals.EXIF_XPSubject>
  <A TIOParamsVals.EXIF_XPTitle>

  <FI>EXIF GPS tags<FN>

  <A TIOParamsVals.EXIF_GPSVersionID>
  <A TIOParamsVals.EXIF_GPSLatitudeRef>
  <A TIOParamsVals.EXIF_GPSLatitudeDegrees>
  <A TIOParamsVals.EXIF_GPSLatitudeMinutes>
  <A TIOParamsVals.EXIF_GPSLatitudeSeconds>
  <A TIOParamsVals.EXIF_GPSLongitudeRef>
  <A TIOParamsVals.EXIF_GPSLongitudeDegrees>
  <A TIOParamsVals.EXIF_GPSLongitudeMinutes>
  <A TIOParamsVals.EXIF_GPSLongitudeSeconds>
  <A TIOParamsVals.EXIF_GPSAltitudeRef>
  <A TIOParamsVals.EXIF_GPSAltitude>
  <A TIOParamsVals.EXIF_GPSTimeStampHour>
  <A TIOParamsVals.EXIF_GPSTimeStampMinute>
  <A TIOParamsVals.EXIF_GPSTimeStampSecond>
  <A TIOParamsVals.EXIF_GPSSatellites>
  <A TIOParamsVals.EXIF_GPSStatus>
  <A TIOParamsVals.EXIF_GPSMeasureMode>
  <A TIOParamsVals.EXIF_GPSDOP>
  <A TIOParamsVals.EXIF_GPSSpeedRef>
  <A TIOParamsVals.EXIF_GPSSpeed>
  <A TIOParamsVals.EXIF_GPSTrackRef>
  <A TIOParamsVals.EXIF_GPSTrack>
  <A TIOParamsVals.EXIF_GPSImgDirectionRef>
  <A TIOParamsVals.EXIF_GPSImgDirection>
  <A TIOParamsVals.EXIF_GPSMapDatum>
  <A TIOParamsVals.EXIF_GPSDestLatitudeRef>
  <A TIOParamsVals.EXIF_GPSDestLatitudeDegrees>
  <A TIOParamsVals.EXIF_GPSDestLatitudeMinutes>
  <A TIOParamsVals.EXIF_GPSDestLatitudeSeconds>
  <A TIOParamsVals.EXIF_GPSDestLongitudeRef>
  <A TIOParamsVals.EXIF_GPSDestLongitudeDegrees>
  <A TIOParamsVals.EXIF_GPSDestLongitudeMinutes>
  <A TIOParamsVals.EXIF_GPSDestLongitudeSeconds>
  <A TIOParamsVals.EXIF_GPSDestBearingRef>
  <A TIOParamsVals.EXIF_GPSDestBearing>
  <A TIOParamsVals.EXIF_GPSDestDistanceRef>
  <A TIOParamsVals.EXIF_GPSDestDistance>
  <A TIOParamsVals.EXIF_GPSDateStamp>

  <FI>PostScript<FN>

  <A TIOParamsVals.PS_Compression>
  <A TIOParamsVals.PS_PaperHeight>
  <A TIOParamsVals.PS_PaperWidth>
  <A TIOParamsVals.PS_Title>

  <FI>Adobe PDF<FN>

  <A TIOParamsVals.PDF_Author>
  <A TIOParamsVals.PDF_Compression>
  <A TIOParamsVals.PDF_Creator>
  <A TIOParamsVals.PDF_Keywords>
  <A TIOParamsVals.PDF_PaperHeight>
  <A TIOParamsVals.PDF_PaperWidth>
  <A TIOParamsVals.PDF_Producer>
  <A TIOParamsVals.PDF_Subject>
  <A TIOParamsVals.PDF_Title>

  <FI>RAW (Camera)<FN>

  <A TIOParamsVals.RAW_AutoAdjustColors>
  <A TIOParamsVals.RAW_BlueScale>
  <A TIOParamsVals.RAW_Bright>
  <A TIOParamsVals.RAW_Camera>
  <A TIOParamsVals.RAW_ExtraParams>
  <A TIOParamsVals.RAW_FourColorRGB>
  <A TIOParamsVals.RAW_Gamma>
  <A TIOParamsVals.RAW_GetExifThumbnail>
  <A TIOParamsVals.RAW_HalfSize>
  <A TIOParamsVals.RAW_QuickInterpolate>
  <A TIOParamsVals.RAW_RedScale>
  <A TIOParamsVals.RAW_UseAutoWB>
  <A TIOParamsVals.RAW_UseCameraWB>

  <FI>MediaFile (AVI, MPEG, WMV..)<FN>

  <A TIOParamsVals.MEDIAFILE_FrameCount>
  <A TIOParamsVals.MEDIAFILE_FrameDelayTime>

  <FI>RealRAW (not camera RAW)<FN>

  <A TIOParamsVals.BMPRAW_DataFormat>
  <A TIOParamsVals.BMPRAW_ChannelOrder>
  <A TIOParamsVals.BMPRAW_HeaderSize>
  <A TIOParamsVals.BMPRAW_Planes>
  <A TIOParamsVals.BMPRAW_RowAlign>

  <FI>Adobe XMP info<FN>

  <A TIOParamsVals.XMP_Info>
!!}
  TIOParamsVals = class
  private
    fImageEnIO: TImageEnIO;
    fBitsPerSample: integer;
    fFileName: WideString;
    fSamplesPerPixel: integer;
    fWidth: integer;
    fHeight: integer;
    fDpiX: integer;
    fDpiY: integer;
    fFileType: TIOFileType;
    fImageIndex:integer;
    fImageCount:integer;
    fGetThumbnail:boolean;
    fIsResource:boolean;
    fEnableAdjustOrientation:boolean;
    fOriginalWidth: integer;
    fOriginalHeight: integer;
    fTIFF_Compression: TIOTIFFCompression;
    fTIFF_ImageIndex: integer;
    fTIFF_SubIndex:integer; // SubIFD index (-1 read root)
    fTIFF_PhotometInterpret: TIOTIFFPhotometInterpret;
    fTIFF_PlanarConf: integer;
    fTIFF_XPos: integer;
    fTIFF_YPos: integer;
    fTIFF_GetTile: integer; // -1, load all tiles
    fTIFF_DocumentName: AnsiString;
    fTIFF_ImageDescription: AnsiString;
    fTIFF_PageName: AnsiString;
    fTIFF_PageNumber: integer;
    fTIFF_PageCount: integer;
    fTIFF_Orientation: integer;
    fTIFF_LZWDecompFunc: TTIFFLZWDecompFunc;
    fTIFF_LZWCompFunc: TTIFFLZWCompFunc;
    fTIFF_EnableAdjustOrientation: boolean;
    fTIFF_JPEGQuality: integer;
    fTIFF_JPEGColorSpace: TIOJPEGColorSpace;
    fTIFF_ZIPCompression: integer;  // 0=fast 1=normal (default) 2=max
    fTIFF_ImageCount: integer;
    fTIFF_FillOrder:integer;
    fTIFF_ByteOrder:TIOByteOrder;
    fDCX_ImageIndex:integer;
    fGIF_Version: AnsiString;
    fGIF_ImageIndex: integer;
    fGIF_XPos: integer;
    fGIF_YPos: integer;
    fGIF_DelayTime: integer;
    fGIF_FlagTranspColor: boolean;
    fGIF_TranspColor: TRGB;
    fGIF_Interlaced: boolean;
    fGIF_WinWidth: integer;
    fGIF_WinHeight: integer;
    fGIF_Background: TRGB;
    fGIF_Ratio: integer;
    fGIF_Comments: TStringList;
    fGIF_Action: TIEGIFAction;
    fGIF_LZWDecompFunc: TGIFLZWDecompFunc;
    fGIF_LZWCompFunc: TGIFLZWCompFunc;
    fGIF_ImageCount: integer;
    fJPEG_ColorSpace: TIOJPEGColorSpace;
    fJPEG_Quality: integer;
    fJPEG_DCTMethod: TIOJPEGDCTMethod;
    fJPEG_CromaSubsampling: TIOJPEGCromaSubsampling;
    fJPEG_OptimalHuffman: boolean;
    fJPEG_Smooth: integer;
    fJPEG_Progressive: boolean;
    fJPEG_Scale: TIOJPEGScale;
    fJPEG_MarkerList: TIEMarkerList;
    fJPEG_Scale_Used: integer;
    fJPEG_WarningTot: integer;
    fJPEG_WarningCode: integer;
    fJPEG_EnableAdjustOrientation:boolean;
    fJPEG_GetExifThumbnail:boolean;
{$IFDEF IEINCLUDEJPEG2000}
    fJ2000_ColorSpace: TIOJ2000ColorSpace;
    fJ2000_Rate: double;
    fJ2000_ScalableBy: TIOJ2000ScalableBy;
{$ENDIF}
    fPCX_Version: integer;
    fPCX_Compression: TIOPCXCompression;
    fBMP_Version: TIOBMPVersion;
    fBMP_Compression: TIOBMPCompression;
    fBMP_HandleTransparency:boolean;
    fICO_ImageIndex: integer;
    fICO_Background: TRGB;
    fCUR_ImageIndex: integer;
    fCUR_XHotSpot: integer;
    fCUR_YHotSpot: integer;
    fCUR_Background: TRGB;
    fPNG_Interlaced: boolean;
    fPNG_Background: TRGB;
    fPNG_Filter: TIOPNGFilter;
    fPNG_Compression: integer;
    fPNG_TextKeys:TStringList;
    fPNG_TextValues:TStringList;
{$ifdef IEINCLUDEDICOM}
    fDICOM_Tags:TIEDICOMTags;
{$endif}
    fTGA_XPos: integer;
    fTGA_YPos: integer;
    fTGA_Compressed: boolean;
    fTGA_Descriptor: AnsiString;
    fTGA_Author: AnsiString;
    fTGA_Date: TDateTime;
    fTGA_ImageName: AnsiString;
    fTGA_Background: TRGB;
    fTGA_AspectRatio: double;
    fTGA_Gamma: double;
    fTGA_GrayLevel: boolean;
    fIPTC_Info: TIEIPTCInfoList;
    {$ifdef IEINCLUDEIMAGINGANNOT}
    fImagingAnnot: TIEImagingAnnot;
    {$endif}
    fPXM_Comments: TStringList;
    fEXIF_Tags: TList;  // a list of received tags (codes) and a list of tags to write. ONLY FOR NUMERIC TAGS (excluded GPS and non subifd tags).
    fEXIF_HasEXIFData: boolean;
    fEXIF_Orientation: integer;
    fEXIF_Bitmap: TIEBitmap;
    fEXIF_ImageDescription: AnsiString;
    fEXIF_Make: AnsiString;
    fEXIF_Model: AnsiString;
    fEXIF_XResolution: double;
    fEXIF_YResolution: double;
    fEXIF_ResolutionUnit: integer;
    fEXIF_Software: AnsiString;
    fEXIF_Artist:AnsiString;
    fEXIF_DateTime: AnsiString;
    fEXIF_WhitePoint: array[0..1] of double;
    fEXIF_PrimaryChromaticities: array[0..5] of double;
    fEXIF_YCbCrCoefficients: array[0..2] of double;
    fEXIF_YCbCrPositioning: integer;
    fEXIF_ReferenceBlackWhite: array[0..5] of double;
    fEXIF_Copyright: AnsiString;
    fEXIF_ExposureTime: double;
    fEXIF_FNumber: double;
    fEXIF_ExposureProgram: integer;
    fEXIF_ISOSpeedRatings: array[0..1] of integer;
    fEXIF_ExifVersion: AnsiString;
    fEXIF_DateTimeOriginal: AnsiString;
    fEXIF_DateTimeDigitized: AnsiString;
    fEXIF_CompressedBitsPerPixel: double;
    fEXIF_ShutterSpeedValue: double;
    fEXIF_ApertureValue: double;
    fEXIF_BrightnessValue: double;
    fEXIF_ExposureBiasValue: double;
    fEXIF_MaxApertureValue: double;
    fEXIF_SubjectDistance: double;
    fEXIF_MeteringMode: integer;
    fEXIF_LightSource: integer;
    fEXIF_Flash: integer;
    fEXIF_FocalLength: double;
    fEXIF_SubsecTime: AnsiString;
    fEXIF_SubsecTimeOriginal: AnsiString;
    fEXIF_SubsecTimeDigitized: AnsiString;
    fEXIF_FlashPixVersion: AnsiString;
    fEXIF_ColorSpace: integer;
    fEXIF_ExifImageWidth: integer;
    fEXIF_ExifImageHeight: integer;
    fEXIF_RelatedSoundFile: AnsiString;
    fEXIF_FocalPlaneXResolution: double;
    fEXIF_FocalPlaneYResolution: double;
    fEXIF_FocalPlaneResolutionUnit: integer;
    fEXIF_ExposureIndex: double;
    fEXIF_SensingMethod: integer;
    fEXIF_FileSource: integer;
    fEXIF_SceneType: integer;
    fEXIF_UserComment: WideString;
    fEXIF_UserCommentCode: AnsiString;
    fEXIF_MakerNote:TIETagsHandler;
    fEXIF_XPRating:integer;
    fEXIF_XPTitle:WideString;
    fEXIF_XPComment:WideString;
    fEXIF_XPAuthor:WideString;
    fEXIF_XPKeywords:WideString;
    fEXIF_XPSubject:WideString;
    fEXIF_ExposureMode:integer;
    fEXIF_WhiteBalance:integer;
    fEXIF_DigitalZoomRatio:double;
    fEXIF_FocalLengthIn35mmFilm:integer;
    fEXIF_SceneCaptureType:integer;
    fEXIF_GainControl:integer;
    fEXIF_Contrast:integer;
    fEXIF_Saturation:integer;
    fEXIF_Sharpness:integer;
    fEXIF_SubjectDistanceRange:integer;
    fEXIF_ImageUniqueID:AnsiString;
    fEXIF_GPSVersionID:AnsiString;
    fEXIF_GPSLatitudeRef:AnsiString;
    fEXIF_GPSLatitudeDegrees:double;
    fEXIF_GPSLatitudeMinutes:double;
    fEXIF_GPSLatitudeSeconds:double;
    fEXIF_GPSLongitudeRef:AnsiString;
    fEXIF_GPSLongitudeDegrees:double;
    fEXIF_GPSLongitudeMinutes:double;
    fEXIF_GPSLongitudeSeconds:double;
    fEXIF_GPSAltitudeRef:AnsiString;
    fEXIF_GPSAltitude:double;
    fEXIF_GPSTimeStampHour:double;
    fEXIF_GPSTimeStampMinute:double;
    fEXIF_GPSTimeStampSecond:double;
    fEXIF_GPSSatellites:AnsiString;
    fEXIF_GPSStatus:AnsiString;
    fEXIF_GPSMeasureMode:AnsiString;
    fEXIF_GPSDOP:double;
    fEXIF_GPSSpeedRef:AnsiString;
    fEXIF_GPSSpeed:double;
    fEXIF_GPSTrackRef:AnsiString;
    fEXIF_GPSTrack:double;
    fEXIF_GPSImgDirectionRef:AnsiString;
    fEXIF_GPSImgDirection:double;
    fEXIF_GPSMapDatum:AnsiString;
    fEXIF_GPSDestLatitudeRef:AnsiString;
    fEXIF_GPSDestLatitudeDegrees:double;
    fEXIF_GPSDestLatitudeMinutes:double;
    fEXIF_GPSDestLatitudeSeconds:double;
    fEXIF_GPSDestLongitudeRef:AnsiString;
    fEXIF_GPSDestLongitudeDegrees:double;
    fEXIF_GPSDestLongitudeMinutes:double;
    fEXIF_GPSDestLongitudeSeconds:double;
    fEXIF_GPSDestBearingRef:AnsiString;
    fEXIF_GPSDestBearing:double;
    fEXIF_GPSDestDistanceRef:AnsiString;
    fEXIF_GPSDestDistance:double;
    fEXIF_GPSDateStamp:AnsiString;
    fAVI_FrameCount: integer;
    fAVI_FrameDelayTime: integer;
    {$ifdef IEINCLUDEDIRECTSHOW}
    fMEDIAFILE_FrameCount: integer;
    fMEDIAFILE_FrameDelayTime: integer;
    {$endif}
    fPS_PaperWidth: integer;
    fPS_PaperHeight: integer;
    fPS_Compression: TIOPSCompression;
    fPS_Title: AnsiString;
    fPDF_PaperWidth: integer; // in Adobe PDF points (1 point=1/72 of inch).
    fPDF_PaperHeight: integer; // in Adobe PDF points (1 point=1/72 of inch).
    fPDF_Compression: TIOPDFCompression;
    fPDF_Title: AnsiString;
    fPDF_Author: AnsiString;
    fPDF_Subject: AnsiString;
    fPDF_Keywords: AnsiString;
    fPDF_Creator: AnsiString;
    fPDF_Producer: AnsiString;
    {$ifdef IEINCLUDERAWFORMATS}
    fRAW_HalfSize:boolean;
    fRAW_Gamma:double;
    fRAW_Bright:double;
    fRAW_RedScale:double;
    fRAW_BlueScale:double;
    fRAW_QuickInterpolate:boolean;
    fRAW_UseAutoWB:boolean;
    fRAW_UseCameraWB:boolean;
    fRAW_FourColorRGB:boolean;
    fRAW_Camera:AnsiString;
    fRAW_GetExifThumbnail:boolean;
    fRAW_AutoAdjustColors:boolean;
    fRAW_ExtraParams:AnsiString;
    {$endif}
    fBMPRAW_ChannelOrder:TIOBMPRAWChannelOrder;
    fBMPRAW_Planes:TIOBMPRAWPlanes;
    fBMPRAW_RowAlign:integer;
    fBMPRAW_HeaderSize:integer;
    fBMPRAW_DataFormat:TIOBMPRAWDataFormat;
    fPSD_LoadLayers:boolean;
    fPSD_ReplaceLayers:boolean;
    fPSD_HasPremultipliedAlpha:boolean;
    fHDP_ImageQuality:double;
    fHDP_Lossless:boolean;
    fXMP_Info:AnsiString;
    function GetFileTypeStr: string;
    procedure SetEXIF_WhitePoint(index: integer; v: double);
    function GetEXIF_WhitePoint(index: integer): double;
    procedure SetEXIF_PrimaryChromaticities(index: integer; v: double);
    function GetEXIF_PrimaryChromaticities(index: integer): double;
    procedure SetEXIF_YCbCrCoefficients(index: integer; v: double);
    function GetEXIF_YCbCrCoefficients(index: integer): double;
    procedure SetEXIF_ReferenceBlackWhite(index: integer; v: double);
    function GetEXIF_ReferenceBlackWhite(index: integer): double;
    procedure SetEXIF_ISOSpeedRatings(index: integer; v: integer);
    function GetEXIF_ISOSpeedRatings(index: integer): integer;
    procedure SetDpi(Value: integer);
    procedure SetTIFF_Orientation(Value: integer);
    procedure SetEXIF_Orientation(Value: integer);
    procedure SetEXIF_XResolution(Value: double);
    procedure SetEXIF_YResolution(Value: double);
    function GetInputICC:TIEICC;
    function GetOutputICC:TIEICC;
    function GetDefaultICC:TIEICC;
    {$ifdef IEINCLUDEIMAGINGANNOT}
    function GetImagingAnnot:TIEImagingAnnot;
    {$endif}
    procedure SetImageIndex(value:integer);
    procedure SetImageCount(value:integer);
    procedure SetGetThumbnail(value:boolean);
    procedure SetIsResource(value:boolean);
    procedure SetJPEG_GetExifThumbnail(value:boolean);
    {$ifdef IEINCLUDERAWFORMATS}
    procedure SetRAW_GetExifThumbnail(value:boolean);
    {$endif}
    procedure SetEnableAdjustOrientation(value:boolean);
    procedure EXIFTagsAdd(tag:integer);
    procedure EXIFTagsDel(tag:integer);
    procedure SetEXIF_ExposureTime(value:double);
    procedure SetEXIF_FNumber(value:double);
    procedure SetEXIF_ExposureProgram(value:integer);
    procedure SetEXIF_CompressedBitsPerPixel(value:double);
    procedure SetEXIF_ShutterSpeedValue(value:double);
    procedure SetEXIF_ApertureValue(value:double);
    procedure SetEXIF_BrightnessValue(value:double);
    procedure SetEXIF_ExposureBiasValue(value:double);
    procedure SetEXIF_MaxApertureValue(value:double);
    procedure SetEXIF_SubjectDistance(value:double);
    procedure SetEXIF_MeteringMode(value:integer);
    procedure SetEXIF_LightSource(value:integer);
    procedure SetEXIF_Flash(value:integer);
    procedure SetEXIF_FocalLength(value:double);
    procedure SetEXIF_ColorSpace(value:integer);
    procedure SetEXIF_ExifImageWidth(value:integer);
    procedure SetEXIF_ExifImageHeight(value:integer);
    procedure SetEXIF_FocalPlaneXResolution(value:double);
    procedure SetEXIF_FocalPlaneYResolution(value:double);
    procedure SetEXIF_FocalPlaneResolutionUnit(value:integer);
    procedure SetEXIF_ExposureIndex(value:double);
    procedure SetEXIF_SensingMethod(value:integer);
    procedure SetEXIF_FileSource(value:integer);
    procedure SetEXIF_SceneType(value:integer);
    procedure SetDpiX(Value:integer);
    procedure SetDpiY(Value:integer);
  public
    //
    IsNativePixelFormat: boolean;
    // Read-Only fields
    fColorMap: PRGBROW;
    fColorMapCount: integer;
    // ICO (they are not properties)

{!!
<FS>TIOParamsVals.ICO_Sizes

<FM>Declaration<FC>
ICO_Sizes:<A TIOICOSizes>;

<FM>Description<FN>
ICO_Sizes is an array of TSize structures. It contains the input/output sizes of the images contained in an ICO file.
The last size must contain size 0.

<FM>Example<FC>
// save the current image in 'output.ico', It will contain three images with 64x64 32bit (24bit +alphachannel), 32x32 256 colors and 32x32 16 colors
// 64x64 x32bit
ImageEnView.IO.Params.ICO.BitCount[0]:=32;
ImageEnView.IO.Params.ICO.Sizes[0].cx:=64;
ImageEnView.IO.Params.ICO.Sizes[0].cy:=64;
// 32x32 x8bit
ImageEnView.IO.Params.ICO.BitCount[1]:=8;
ImageEnView.IO.Params.ICO.Sizes[1].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[1].cy:=32;
// 32x32 x4bit
ImageEnView.IO.Params.ICO.BitCount[2]:=4;
ImageEnView.IO.Params.ICO.Sizes[2].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[2].cy:=32;
// I don't want other images
ImageEnView.IO.Params.ICO.BitCount[3]:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cx:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cy:=0;
// save
ImageEnView.IO.SaveToFile('output.ico');
!!}
    ICO_Sizes: TIOICOSizes;

{!!
<FS>TIOParamsVals.ICO_BitCount

<FM>Declaration<FC>
ICO_BitCount:<A TIOICOBitCount>;

<FM>Description<FN>
ICO_BitCount is an array of integers. It contains the input/output bitcount of the images contained in an ICO file.
The last bitcount must contain 0.

<FM>Example<FC>
// save the current image in 'output.ico', It will contain three images with 64x64 32bit (24bit +alphachannel), 32x32 256 colors and 32x32 16 colors
// 64x64 x32bit
ImageEnView.IO.Params.ICO.BitCount[0]:=32;
ImageEnView.IO.Params.ICO.Sizes[0].cx:=64;
ImageEnView.IO.Params.ICO.Sizes[0].cy:=64;
// 32x32 x8bit
ImageEnView.IO.Params.ICO.BitCount[1]:=8;
ImageEnView.IO.Params.ICO.Sizes[1].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[1].cy:=32;
// 32x32 x4bit
ImageEnView.IO.Params.ICO.BitCount[2]:=4;
ImageEnView.IO.Params.ICO.Sizes[2].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[2].cy:=32;
// I don't want other images
ImageEnView.IO.Params.ICO.BitCount[3]:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cx:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cy:=0;
// save
ImageEnView.IO.SaveToFile('output.ico');
!!}
    ICO_BitCount: TIOICOBitCount;

    //
    fInputICC: TIEICC;
    fOutputICC: TIEICC;
    fDefaultICC: TIEICC;

    // GENERIC


{!!
<FS>TIOParamsVals.FileName

<FM>Declaration<FC>
property FileName: WideString;

<FM>Description<FN>
Filename of the last loaded or saved image.

Read-only
!!}
    property FileName: WideString read fFileName write fFileName;

    property FileTypeStr: string read GetFileTypeStr;

{!!
<FS>TIOParamsVals.FileType

<FM>Declaration<FC>
property FileType:<A TIOFileType>;

<FM>Description<FN>
FileType is the last loaded/saved file type. For example, after a call to LoadFromFileGIF, this property will have the ioGIF value.

<FM>Example<FC>

if OpenImageEnDialog1.Execute then begin
  ImageEnView1.IO.LoadFromFile(OpenImageEnDialog1.FileName);
  case ImageEnView1.IO.Params.FileType of
    ioTIFF: ShowMessage('You have loaded a TIFF file');
    ioGIF: ShowMessage('You have loaded a GIF file');
......
  end;
end;
!!}
    property FileType: TIOFileType read fFileType write fFileType;

{!!
<FS>TIOParamsVals.BitsPerSample

<FM>Declaration<FC>
property BitsPerSample: integer;

<FM>Description<FN>
Depth, in bits, for each sample.
Allowed values:

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>1<FN></C> <C>1 bit black & white</C> </R>
<R> <C><FC>2..7<FN></C> <C>color mapped bitmap (from 4 to 128 colors)</C> </R>
<R> <C><FC>8<FN></C> <C>color mapped (256 colors), 8 bit gray scale, 24 bit RGB, 48 bit CMYK, 24 bit CIELab</C> </R>
<R> <C><FC>16<FN></C> <C>16 bit gray scale or 48 bit RGB</C> </R>
<R> <C><FC>32<FN></C> <C>32 bit floating point</C> </R>
</TABLE>

See also <A TIOParamsVals.SamplesPerPixel>.

<FM>Example<FC>

// saves 256 colormapped bitmap
ImageEnView1.IO.Params.BitsPerSample:=8;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
ImageEnView1.IO.Params.SaveToFile('alfa.bmp');
!!}
    property BitsPerSample: integer read fBitsPerSample write fBitsPerSample;

{!!
<FS>TIOParamsVals.SamplesPerPixel

<FM>Declaration<FC>
property SamplesPerPixel: integer;

<FM>Description<FN>
Samples (channels) for each pixel.
Allowed values:

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>1<FN></C> <C>Single channel, colormapped or gray scale image</C> </R>
<R> <C><FC>3<FN></C> <C>Three channels, RGB or CIELab</C> </R>
<R> <C><FC>4<FN></C> <C>Four channels, CMYK or BGRA</C> </R>
</TABLE>

See also <A TIOParamsVals.BitsPerSample>.

<FM>Example<FC>

// saves 256 colormapped bitmap
ImageEnView1.IO.Params.BitsPerSample:=8;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
ImageEnView1.IO.Params.SaveToFile('alfa.bmp');
!!}
    property SamplesPerPixel: integer read fSamplesPerPixel write fSamplesPerPixel;

{!!
<FS>TIOParamsVals.Width

<FM>Declaration<FC>
property Width: integer;

<FM>Description<FN>
Width of the image in pixels.
!!}
    property Width: integer read fWidth write fWidth;

{!!
<FS>TIOParamsVals.Height

<FM>Declaration<FC>
property Height: integer;

<FM>Description<FN>
Image height in pixels.
!!}
    property Height: integer read fHeight write fHeight;

    property DpiX: integer read fDpiX write SetDpiX;
    property DpiY: integer read fDpiY write SetDpiY;

{!!
<FS>TIOParamsVals.Dpi

<FM>Declaration<FC>
property Dpi:integer;

<FM>Description<FN>
Dpi specifies the resolution (dots per inch) of the acquired image. If horizontal and vertical resolutions aren't equal, Dpi is the horizontal resolution (the same as DpiX).

<FM>See also<FN>
<A TIOParamsVals.DpiX>
<A TIOParamsVals.DpiY>
!!}
    property Dpi: integer read fDpiX write SetDpi;

{!!
<FS>TIOParamsVals.ColorMap

<FM>Declaration<FC>
property ColorMap: <A PRGBROW>;

<FM>Description<FN>
ColorMap gets the colormap of the last loaded image.

Read-only

<FM>Example<FC>

// shows the palette of the file "myfile.gif"
var
  fPalDial:TImageEnPaletteDialog;
begin
  ImageEnView1.IO.LoadFromFile('myfile.gif');
  fPalDial:=TImageEnPaletteDialog.Create(self);
  fPalDial.SetPalette(ImageEnView1.IO.Params.ColorMap^,ImageEnView1.IO.Params.ColorMapCount);
  fPalDial.Execute;
  fPalDial.free;
end;
!!}
    property ColorMap: PRGBROW read fColorMap;

{!!
<FS>TIOParamsVals.ColorMapCount

<FM>Declaration<FC>
property ColorMapCount: integer;

<FM>Description<FN>
ColorMapCount is the number of entries in the ColorMap array.

Read-only
!!}
    property ColorMapCount: integer read fColorMapcount;

{!!
<FS>TIOParamsVals.ImageIndex

<FM>Declaration<FC>
property ImageIndex:integer;

<FM>Description<FN>
ImageIndex specifies the index of next page to load. You have to specify this property just before methods like LoadFromFile.
This property is valid for all file formats (TIFF, GIF, DCX, etc..) and sets also other properties like TIFF_ImageIndex, GIF_ImageIndex, etc..

<FM>Example<FC>

ImageEnView1.IO.Params.ImageIndex:=1;	// need second page
ImageEnView1.IO.LoadFromFile('input.tif');
!!}
    property ImageIndex:integer read fImageIndex write SetImageIndex;

{!!
<FS>TIOParamsVals.ImageCount

<FM>Declaration<FC>
property ImageCount:integer

<FM>Description<FN>
ImageCount returns the number of page/images/frames founds inside the last loaded file. This property is valid for all file formats.

<FM>Example<FC>

ImageEnView1.IO.LoadFromFile('input.tif');
Pages:=ImageEnView1.IO.Params.ImageCount;
!!}
    property ImageCount:integer read fImageCount write SetImageCount;

{!!
<FS>TIOParamsVals.GetThumbnail

<FM>Declaration<FC>
property GetThumbnail:boolean;

<FM>Description<FN>
You have to set this property just before load an image which could contain a thumbnail (like EXIF thumbnail).
If you set True the thumbnail will be loaded. If no thumbnail is present the full image will be loaded.

<FM>Example<FC>

ImageEnView1.IO.Params.GetThumbnail:=true;
ImageEnView1.IO.LoadFromFile('input.jpg');
!!}
    property GetThumbnail:boolean read fGetThumbnail write SetGetThumbnail;


{!!
<FS>TIOParamsVals.IsResource

<FM>Declaration<FC>
property IsResource:boolean;

<FM>Description<FN>
Some formats (BMP, ICO, CUR), if stored as resources (in EXE, DLL, etc...), do not contain some headers. If you set IsResource=true, these headers are not expected allowing to load correctly the image.

Look at inputoutput/resourceLoader example.

<FM>Example<FC>

// loads resource 143, in "Bitmap"s, from "explorer.exe" (should be a little Windows logo)
var
  re:TIEResourceExtractor;
  buffer:pointer;
  bufferLen:integer;
begin
  re := TIEResourceExtractor.Create('explorer.exe');
  try
    buffer := re.GetBuffer('Bitmap', 'INTRESOURCE:143', bufferLen);
    ImageEnView1.IO.Params.IsResource := true;
    ImageEnView1.IO.LoadFromBuffer(buffer, bufferLen, ioBMP);
  finally
    re.Free;
  end;
end;

!!}
    property IsResource:boolean read fIsResource write SetIsResource;


{!!
<FS>TIOParamsVals.EnableAdjustOrientation

<FM>Declaration<FC>
property EnableAdjustOrientation:boolean;

<FM>Description<FN>
If you set this property to True before load a file which contains EXIF information, the image will be automatically orientated.
This property also sets <A TIOParamsVals.JPEG_EnableAdjustOrientation> and <A TIOParamsVals.TIFF_EnableAdjustOrientation>.

<FM>Example<FC>

ImageEnView1.IO.Params.EnableAdjustOrientation:=true;
ImageEnView1.IO.LoadFromFile('input.jpg');
!!}
    property EnableAdjustOrientation:boolean read fEnableAdjustOrientation write SetEnableAdjustOrientation;

    // ICC
    property InputICCProfile: TIEICC read GetInputICC;
    property OutputICCProfile: TIEICC read GetOutputICC;
    property DefaultICCProfile: TIEICC read GetDefaultICC;
    // IPTC

{!!
<FS>TIOParamsVals.IPTC_Info

<FM>Declaration<FC>
property IPTC_Info: <A TIEIPTCInfoList>;

<FM>Description<FN>
IPTC_Info contains a list of IPTC information contained in a file.
IPTC records can contains text, objects and images. Applications can read/write information from IPTC_Info using string objects or a memory buffer.

Each IPTC_Info item has a record number and a dataset number.  These values specify the type of data contained in the item, according to IPTC - NAA Information Interchange Model Version 4 (look at www.iptc.org).
ImageEn can read/write IPTC textual information of PhotoShop (File info menu).
For JPEG files ImageEn read/write IPTC fields from APP13 marker.
Click <L IPTC items compatible with Adobe PhotoShop>here</L> for a list of IPTC Photoshop items.

<A TIEIPTCInfoList> is the object that contains the list of IPTC information.

<FM>Examples<FC>

// read the image description (writed by PhotoShop) (caption:var, idx:integer)
ImageEnView1.IO.LoadFromFile('image.jpg');
Idx:=ImageEnView1.IO.Params.IPTC_Info.IndexOf(2,120);
Caption:=ImageEnView1.IO.Params.IPTC_Info.StringItem[idx];

// write the image description
ImageEnView1.IO.Params.IPTC_Info.StringItem[idx]:= 'This is the new caption';
ImageEnView1.IO.SaveToFile('image.jpg');
!!}
    property IPTC_Info: TIEIPTCInfoList read fIPTC_Info;

    // Imaging annotations
    {$ifdef IEINCLUDEIMAGINGANNOT}
    property ImagingAnnot: TIEImagingAnnot read GetImagingAnnot;
    {$endif}

    // TIFF

{!!
<FS>TIOParamsVals.TIFF_Compression

<FM>Declaration<FC>
property TIFF_Compression: <A TIOTIFFCompression>;

<FM>Description<FN>
Specifies the compression type for TIFF image format.

!!}
    property TIFF_Compression: TIOTIFFCompression read fTIFF_Compression write fTIFF_Compression;

{!!
<FS>TIOParamsVals.TIFF_ImageIndex

<FM>Declaration<FC>
property TIFF_ImageIndex: integer;

<FM>Description<FN>
TIFF_ImageIndex is the index (from 0) of the image.

!!}
    property TIFF_ImageIndex: integer read fTIFF_ImageIndex write SetImageIndex;

{!!
<FS>TIOParamsVals.TIFF_SubIndex

<FM>Declaration<FC>
property TIFF_SubIndex:integer;

<FM>Description<FN>
A TIFF can contains several pages. You can load image or paramters from a page using TIFF_ImageIndex (or just ImageIndex). Each page can contain sub images, like a tree, so you can load a specific sub page using TIFF_SubIndex.
This is useful for example to load an embedded Jpeg from a DNG (camera raw format), that is located at first page and second sub index.

<FM>Example<FC>

// loads the embeded jpeg from a DNG
ImageEnView1.IO.Params.TIFF_ImageIndex:=0;
ImageEnView1.IO.Params.TIFF_SubIndex:=1;
ImageEnView1.IO.LoadFromFileTIFF('DCSXXX.DNG');
!!}
    property TIFF_SubIndex:integer read fTIFF_SubIndex write fTIFF_SubIndex;

{!!
<FS>TIOParamsVals.TIFF_ImageCount

<FM>Declaration<FC>
property TIFF_ImageCount:integer;

<FM>Description<FN>
TIFF_ImageCount specifies the image count of the last TIFF loaded.

Read-only

<FM>Example<FC>

// this return the frame count of 'pages.tiff' without load the TIFF
ImageEnView1.IO.ParamsFromFile('pages.tiff');
ImageCount:=ImageEnView1.IO.Params.TIFF_ImageCount;
!!}
    property TIFF_ImageCount: integer read fTIFF_ImageCount write SetImageCount;

{!!
<FS>TIOParamsVals.TIFF_PhotometInterpret

<FM>Declaration<FC>
property TIFF_PhotometInterpret: <A TIOTIFFPhotometInterpret>;

<FM>Description<FN>
Photometric interpretation.

!!}
    property TIFF_PhotometInterpret: TIOTIFFPhotometInterpret read fTIFF_PhotometInterpret write fTIFF_PhotometInterpret;

{!!
<FS>TIOParamsVals.TIFF_PlanarConf

<FM>Declaration<FC>
property TIFF_PlanarConf: integer;

<FM>Description<FN>
Planar configuration.

!!}
    property TIFF_PlanarConf: integer read fTIFF_PlanarConf write fTIFF_PlanarConf;

{!!
<FS>TIOParamsVals.TIFF_XPos

<FM>Declaration<FC>
property TIFF_XPos: integer;

<FM>Description<FN>
X top-left position of the original scanned image.

!!}
    property TIFF_XPos: integer read fTIFF_XPos write fTIFF_XPos;

{!!
<FS>TIOParamsVals.TIFF_GetTile

<FM>Declaration<FC>
property TIFF_GetTile: integer;

<FM>Description<FN>
Specified the tile number to load when loading a tiled TIFF file.
-1 (default) means "load all tiles".
!!}
    property TIFF_GetTile: integer read fTIFF_GetTile write fTIFF_GetTile;

{!!
<FS>TIOParamsVals.TIFF_YPos

<FM>Declaration<FC>
property TIFF_YPos: integer;

<FM>Description<FN>
Y top-left position of the original scanned image.

!!}
    property TIFF_YPos: integer read fTIFF_YPos write fTIFF_YPos;

{!!
<FS>TIOParamsVals.TIFF_DocumentName

<FM>Declaration<FC>
property TIFF_DocumentName: AnsiString;

<FM>Description<FN>
Specifies the document name field of a TIFF image format.

<FM>Example<FC>

ImageEnView1.IO.Params.TIFF_DocumentName:='Sanremo';
ImageEnView1.IO.Params.TIFF_ImageDescription:='The city of the flowers';
ImageEnView1.IO.SaveToFile('Italy.tif');
!!}
    property TIFF_DocumentName: AnsiString read fTIFF_DocumentName write fTIFF_DocumentName;

{!!
<FS>TIOParamsVals.TIFF_ImageDescription

<FM>Declaration<FC>
property TIFF_ImageDescription: AnsiString;

<FM>Description<FN>
Specifiy the image description field of a TIFF image format.

<FM>Example<FC>

ImageEnView1.IO.Params.TIFF_DocumentName:='Sanremo';
ImageEnView1.IO.Params.TIFF_ImageDescription:='The city of the flowers';
ImageEnView1.IO.SaveToFile('Italy.tif');
!!}
    property TIFF_ImageDescription: AnsiString read fTIFF_ImageDescription write fTIFF_ImageDescription;

{!!
<FS>TIOParamsVals.TIFF_PageName

<FM>Declaration<FC>
property TIFF_PageName: AnsiString;

<FM>Description<FN>
Page name field in a TIFF image format.

!!}
    property TIFF_PageName: AnsiString read fTIFF_PageName write fTIFF_PageName;

{!!
<FS>TIOParamsVals.TIFF_PageNumber

<FM>Declaration<FC>
property TIFF_PageNumber: integer;

<FM>Description<FN>
Page number.

!!}
    property TIFF_PageNumber: integer read fTIFF_PageNumber write fTIFF_PageNumber;

{!!
<FS>TIOParamsVals.TIFF_PageCount

<FM>Declaration<FC>
property TIFF_PageCount: integer;

<FM>Description<FN>
Number of pages in a TIFF file.

!!}
    property TIFF_PageCount: integer read fTIFF_PageCount write fTIFF_PageCount;

{!!
<FS>TIOParamsVals.TIFF_Orientation

<FM>Declaration<FC>
property TIFF_Orientation:integer;

<FM>Description<FN>
The TIFF_Orientation is the orientation of the original image. ImageEn adjusts automatically the image if <A TIOParamsVals.TIFF_EnableAdjustOrientation> is True.

Allowed values:
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>1</C> <C>The 0th row represents the visual top of the image, and the 0th column represents the visual left-hand side.</C> </R>
<R> <C>2</C> <C>The 0th row represents the visual top of the image, and the 0th column represents the visual right-hand side.</C> </R>
<R> <C>3</C> <C>The 0th row represents the visual bottom of the image, and the 0th column represents the visual right-hand side.</C> </R>
<R> <C>4</C> <C>The 0th row represents the visual bottom of the image, and the 0th column represents the visual left-hand side.</C> </R>
<R> <C>5</C> <C>The 0th row represents the visual left-hand side of the image, and the 0th column represents the visual top.</C> </R>
<R> <C>6</C> <C>The 0th row represents the visual right-hand side of the image, and the 0th column represents the visual top.</C> </R>
<R> <C>7</C> <C>The 0th row represents the visual right-hand side of the image, and the 0th column represents the visual bottom.</C> </R>
<R> <C>8</C> <C>The 0th row represents the visual left-hand side of the image, and the 0th column represents the visual bottom.</C> </R>
</TABLE>

Support for orientations other than 1 is not a baseline TIFF requirement.

Read-only
!!}
    property TIFF_Orientation: integer read fTIFF_Orientation write SetTIFF_Orientation;

{!!
<FS>TIOParamsVals.TIFF_EnableAdjustOrientation

<FM>Declaration<FC>
property TIFF_EnableAdjustOrientation:boolean;

<FM>Description<FN>
When TIFF_EnableAdjustOrientation is True, ImageEn rotates loaded images as specified in the TIFF file. (default value is False).
!!}
    property TIFF_EnableAdjustOrientation: boolean read fTIFF_EnableAdjustOrientation write fTIFF_EnableAdjustOrientation;

    property TIFF_LZWDecompFunc: TTIFFLZWDecompFunc read fTIFF_LZWDecompFunc write fTIFF_LZWDecompFunc;

    property TIFF_LZWCompFunc: TTIFFLZWCompFunc read fTIFF_LZWCompFunc write fTIFF_LZWCompFunc;

{!!
<FS>TIOParamsVals.TIFF_JPEGQuality

<FM>Declaration<FC>
property TIFF_JPEGQuality:integer;

<FM>Description<FN>
TIFF_JPEGQuality is a quality factor, from 1 to 100 for TIFF compressed as JPEG.
High values produce better image quality but require more disk space.
!!}
    property TIFF_JPEGQuality: integer read fTIFF_JPEGQuality write fTIFF_JPEGQuality;

{!!
<FS>TIOParamsVals.TIFF_JPEGColorSpace

<FM>Declaration<FC>
property TIFF_JPEGColorSpace:<A TIOJPEGColorSpace>;

<FM>Description<FN>
Specifies the desired color space for the Jpeg included in a TIFF file.

<FM>Example<FC>
ImageEnView.IO.Params.TIFF_JPEGColorSpace:=ioJPEG_RGB;
ImageEnView.IO.Params.TIFF_Compression:=ioTIFF_JPEG;
ImageEnView.IO.SaveToFile('output.tif');
!!}
    property TIFF_JPEGColorSpace: TIOJPEGColorSpace read fTIFF_JPEGColorSpace write fTIFF_JPEGColorSpace;

{!!
<FS>TIOParamsVals.TIFF_FillOrder

<FM>Declaration<FC>
property TIFF_FillOrder: integer;

<FM>Description<FN>
TIFF_FillOrder specifies the logical order of bits within a byte.
1 = pixels are arranged within a byte such that pixels with lower column values are stored in the higher-order bits of the byte.
2 = pixels are arranged within a byte such that pixels with lower column values are stored in the lower-order bits of the byte.
!!}
    property TIFF_FillOrder: integer read fTIFF_FillOrder write fTIFF_FillOrder;

{!!
<FS>TIOParamsVals.TIFF_ZIPCompression

<FM>Declaration<FC>
property TIFF_ZIPCompression:integer;

<FM>Description<FN>
Specifies the compression level to be used when compression is ioTIFF_ZIP.
0 = fastest
1 = normal (default)
2 = max
!!}
    property TIFF_ZIPCompression:integer read fTIFF_ZIPCompression write fTIFF_ZIPCompression;

{!!
<FS>TIOParamsVals.TIFF_ByteOrder

<FM>Declaration<FC>
property TIFF_ByteOrder:<A TIOByteOrder>;

<FM>Description<FN>
Specifies the byte order of the last loaded image.
This property is readonly, because ImageEn uses always ioLittleEndian when saves TIFF.

ioBigEndian byte order is used by Motorola and PowerPC (non Intel Macintosh), while ioLittleEndian is used by Intel processors.

This function is useful, for example, in <A InsertTIFFImageFile> and <A InsertTIFFImageStream> because this function just merges the two tiff images, without decoding them. If the images have different byte order the resulting TIFF is un-readable.
!!}
    property TIFF_ByteOrder:TIOByteOrder read fTIFF_ByteOrder write fTIFF_ByteOrder;

    // GIF

{!!
<FS>TIOParamsVals.GIF_Version

<FM>Declaration<FC>
property GIF_Version: AnsiString;

<FM>Description<FN>
GIF_Version can be 'GIF89a' or 'GIF87a'.

!!}
    property GIF_Version: AnsiString read fGIF_Version write fGIF_Version;

{!!
<FS>TIOParamsVals.GIF_ImageIndex

<FM>Declaration<FC>
property GIF_ImageIndex: integer;

<FM>Description<FN>
The index (from 0) of the image.

!!}
    property GIF_ImageIndex: integer read fGIF_ImageIndex write SetImageIndex;

{!!
<FS>TIOParamsVals.GIF_ImageCount

<FM>Declaration<FC>
property GIF_ImageCount:integer;

<FM>Description<FN>
GIF_ImageCount specifies the image count of the last GIF loaded.

Read-only

<FM>Example<FC>

// this returns the frame count of 'animated.gif' without load the GIF
ImageEnView1.IO.ParamsFromFile('animated.gif');
ImageCount:=ImageEnView1.IO.Params.GIF_ImageCount;
!!}
    property GIF_ImageCount: integer read fGIF_ImageCount write SetImageCount;

{!!
<FS>TIOParamsVals.GIF_XPos

<FM>Declaration<FC>
property GIF_XPos: integer;

<FM>Description<FN>
GIF_XPos is the top-left X coordinate where the frame will be shown.

!!}
    property GIF_XPos: integer read fGIF_XPos write fGIF_XPos;

{!!
<FS>TIOParamsVals.GIF_YPos

<FM>Declaration<FC>
property GIF_YPos: integer;

<FM>Description<FN>
GIF_YPos is the top-left Y coordinate where the frame will be shown.

!!}
    property GIF_YPos: integer read fGIF_YPos write fGIF_YPos;

{!!
<FS>TIOParamsVals.GIF_DelayTime

<FM>Declaration<FC>
property GIF_DelayTime: integer;

<FM>Description<FN>
GIF_DelayTime is the time (in 1/100 s) the frame remains shown.

!!}
    property GIF_DelayTime: integer read fGIF_DelayTime write fGIF_DelayTime;

{!!
<FS>TIOParamsVals.GIF_FlagTranspColor

<FM>Declaration<FC>
property GIF_FlagTranspColor: boolean;

<FM>Description<FN>
If True, the GIF_TranspColor color is valid (the image has a transparency color).
Note: when the image contains an alpha channel (transparency channel) this property is handled automatically.

<FM>Example<FC>

ImageEnView1.IO.Params.GIF_FlagTranspColor:=True;
ImageEnView1.IO.Params.GIF_TranspColor:=CreateRGB(0,0,0);  // black is the transparent color
!!}
    property GIF_FlagTranspColor: boolean read fGIF_FlagTranspColor write fGIF_FlagTranspColor;

{!!
<FS>TIOParamsVals.GIF_TranspColor

<FM>Declaration<FC>
property GIF_TranspColor: <A TRGB>;

<FM>Description<FN>
GIF_TranspColor is the transparency color (If <A TIOParamsVals.GIF_FlagTranspColor> is True).

This color should exist in the image.

!!}
    property GIF_TranspColor: TRGB read fGIF_TranspColor write fGIF_TranspColor;

{!!
<FS>TIOParamsVals.GIF_Interlaced

<FM>Declaration<FC>
property GIF_Interlaced: boolean;

<FM>Description<FN>
If True, the image is interlaced.

!!}
    property GIF_Interlaced: boolean read fGIF_Interlaced write fGIF_Interlaced;

{!!
<FS>TIOParamsVals.GIF_WinWidth

<FM>Declaration<FC>
property GIF_WinWidth: integer;

<FM>Description<FN>
GIF_WinWidth is the width of the window where GIF is shown.

!!}
    property GIF_WinWidth: integer read fGIF_WinWidth write fGIF_WinWidth;

{!!
<FS>TIOParamsVals.GIF_WinHeight

<FM>Declaration<FC>
property GIF_WinHeight: integer;

<FM>Description<FN>
GIF_WinHeight is the height of the window where GIF is shown.

!!}
    property GIF_WinHeight: integer read fGIF_WinHeight write fGIF_WinHeight;

{!!
<FS>TIOParamsVals.GIF_Background

<FM>Declaration<FC>
property GIF_Background: <A TRGB>;

<FM>Description<FN>
GIF_Background is the background color of the GIF.

This color should exist in the image.

!!}
    property GIF_Background: TRGB read fGIF_Background write fGIF_Background;

{!!
<FS>TIOParamsVals.GIF_Ratio

<FM>Declaration<FC>
property GIF_Ratio: integer;

<FM>Description<FN>
Aspect ratio. Width/Height = (Ratio+15)/64

!!}
    property GIF_Ratio: integer read fGIF_Ratio write fGIF_Ratio;

{!!
<FS>TIOParamsVals.GIF_Comments

<FM>Declaration<FC>
property GIF_Comments:TStringList;

<FM>Description<FN>
GIF_Comments contains the text comments contained in a GIF file.

<FM>Example<FC>

ImageEnIO.Params.Gif_Comments.Clear;
ImageEnIO.Params.GIF_Comments.Add('Hello world!');
ImageEnIO.SaveToFie('output.gif');
!!}
    property GIF_Comments: TStringList read fGIF_Comments;

{!!
<FS>TIOParamsVals.GIF_Action

<FM>Declaration<FC>
property GIF_Action:<A TIEGIFAction>;

<FM>Description<FN>
GIF_Action specifies how to display the frames.
!!}
    property GIF_Action: TIEGIFAction read fGIF_Action write fGIF_Action;

    property GIF_LZWDecompFunc: TGIFLZWDecompFunc read fGIF_LZWDecompFunc write fGIF_LZWDecompFunc;
    property GIF_LZWCompFunc: TGIFLZWCompFunc read fGIF_LZWCompFunc write fGIF_LZWCompFunc;

    // DCX

{!!
<FS>TIOParamsVals.DCX_ImageIndex

<FM>Declaration<FC>
property DCX_ImageIndex:integer;

<FM>Description<FN>
Specifies the image index (0=first page) to load for a DCX file.

<FM>Example<FC>

// I want the second page of 'input.dcx'
ImageEnView1.IO.Params.DCX_ImageIndex := 1;
ImageEnView1.IO.LoadFromFile('input.dcx');
!!}
    property DCX_ImageIndex:integer read fDCX_ImageIndex write SetImageIndex;

    // JPEG

{!!
<FS>TIOParamsVals.JPEG_ColorSpace

<FM>Declaration<FC>
property JPEG_ColorSpace: <A TIOJPEGColorSpace>;

<FM>Description<FN>
Specifies the saved/loaded color space. Default is ioJPEG_YCbCr.
!!}
    property JPEG_ColorSpace: TIOJPEGColorSpace read fJPEG_ColorSpace write fJPEG_ColorSpace;

{!!
<FS>TIOParamsVals.JPEG_Quality

<FM>Declaration<FC>
property JPEG_Quality: integer;

<FM>Description<FN>
Quality factor, from 1 to 100.
High values produce better image quality but require more disk space.

It is possible to estimate the original jpeg compression using <A IECalcJpegStreamQuality> or <A IECalcJpegFileQuality> function.
!!}
    property JPEG_Quality: integer read fJPEG_Quality write fJPEG_Quality;

{!!
<FS>TIOParamsVals.JPEG_DCTMethod

<FM>Declaration<FC>
property JPEG_DCTMethod: <A TIOJPEGDCTMethod>;

<FM>Description<FN>
Specifies the DCT method.

!!}
    property JPEG_DCTMethod: TIOJPEGDCTMethod read fJPEG_DCTMethod write fJPEG_DCTMethod;

{!!
<FS>TIOParamsVals.JPEG_CromaSubsampling

<FM>Declaration<FC>
property JPEG_CromaSubsampling: <A TIOJPEGCromaSubsampling>;

<FM>Description<FN>
Specifies the croma subsampling, influencing the jpeg output quality.
This property is valid only when <A TIOParamsVals.JPEG_ColorSpace>=ioJPEG_YCbCr.
!!}
    property JPEG_CromaSubsampling: TIOJPEGCromaSubsampling read fJPEG_CromaSubsampling write fJPEG_CromaSubsampling;

{!!
<FS>TIOParamsVals.JPEG_OptimalHuffman

<FM>Declaration<FC>
property JPEG_OptimalHuffman: boolean;

<FM>Description<FN>
If True, specifies the Jpeg compressor to use an optimal Huffman table (more compression).  If False, a standard table is used.

!!}
    property JPEG_OptimalHuffman: boolean read fJPEG_OptimalHuffman write fJPEG_OptimalHuffman;

{!!
<FS>TIOParamsVals.JPEG_Smooth

<FM>Declaration<FC>
property JPEG_Smooth: integer;

<FM>Description<FN>
Smoothing factor (0 is none, 100 is max). If JPEG_Smooth is not zero, the jpeg compressor smooth the image before compress it. This improves compression.

!!}
    property JPEG_Smooth: integer read fJPEG_Smooth write fJPEG_Smooth;

{!!
<FS>TIOParamsVals.JPEG_Progressive

<FM>Declaration<FC>
property JPEG_Progressive: boolean;

<FM>Description<FN>
Specifies if this is a progressive jpeg.

!!}
    property JPEG_Progressive: boolean read fJPEG_Progressive write fJPEG_Progressive;

{!!
<FS>TIOParamsVals.JPEG_Scale

<FM>Declaration<FC>
property JPEG_Scale:<A TIOJPEGScale>;

<FM>Description<FN>
JPEG_Scale defines the size of a loaded JPEG image. This property affects the speed of load.

<FM>Example<FC>

// This is the fastest way to load a thumbnailed jpeg of about 100x100 pixels
ImageEnView1.IO.Params.Width:=100;
ImageEnView1.IO.Params.Height:=100;
ImageEnView1.IO.Params.JPEG_Scale:=ioJPEG_AUTOCALC;
ImageEnView1.IO.LoadFromFile('my.jpg');
!!}
    property JPEG_Scale: TIOJPEGScale read fJPEG_Scale write fJPEG_Scale;

{!!
<FS>TIOParamsVals.JPEG_MarkerList

<FM>Declaration<FC>
property JPEG_MarkerList: <A TIEMarkerList>;

<FM>Description<FN>
JPEG_MarkerList contains a list of markers contained in a JPEG file. JPEG markers can contain text, objects and images.  Applications can read/write raw markers from JPEG_MarkerList using stream or memory buffer.
JPEG_MarkerList contains markers from APP0 to APP15 and COM.

<FM>Examples<FC>

// read the JPEG_COM marker  (idx is integer, Comment is string)
ImageEnView1.IO.LoadFromFile('image.jpg');
Idx:=ImageEnView1.IO.Params.JPEG_MarkerList.IndexOf(JPEG_COM);
Comment:=ImageEnView1.IO.Params.JPEG_MarkerList.MarkerData[idx];

// now writes the JPEG_COM marker
Comment:='This is the new comment';
ImageEnView1.IO.Params.JPEG_MarkerList.SetMarker(idx,JPEG_COM,PAnsiChar(Comment),length(Comment));
ImageEnView1.IO.SaveToFile('image.jpg');
!!}
    property JPEG_MarkerList: TIEMarkerList read fJPEG_MarkerList;

{!!
<FS>TIOParamsVals.JPEG_Scale_Used

<FM>Declaration<FC>
property JPEG_Scale_Used:integer;

<FM>Description<FN>
JPEG_Scale_Used contains the denominator of the scale used to load last Jpeg image. It is used only when <A TIOParamsVals.JPEG_Scale> is <FC>ioJPEG_AUTOCALC<FN>.

<FM>Example<FC>

ImageEnView1.IO.Params.Width:=100;
ImageEnView1.IO.Params.Height:=100;
ImageEnView1.IO.Params.JPEG_Scale:=ioJPEG_AUTOCALC;
ImageEnView1.IO.LoadFromFile('my.jpg');
Case ImageEnView1.IO.Params.JPEG_Scale_Used of
	2: ShowMessage('Half');
	4: ShowMessage('Quarter');
	8: ShowMessage('HEIGHTH');
end;
!!}
    property JPEG_Scale_Used: integer read fJPEG_Scale_Used write fJPEG_Scale_Used;

{!!
<FS>TIOParamsVals.JPEG_WarningTot

<FM>Declaration<FC>
property JPEG_WarningTot:integer;

<FM>Description<FN>
JPEG_WarningTot is the count of all warnings encountered during loading a Jpeg.
We suggest use of the <A TImageEnIO.Aborting> property to see if the image is corrupted.
!!}
    property JPEG_WarningTot: integer read fJPEG_WarningTot write fJPEG_WarningTot;

{!!
<FS>TIOParamsVals.JPEG_WarningCode

<FM>Declaration<FC>
property JPEG_WarningCode:integer;

<FM>Description<FN>
JPEG_WarningCode is the last warning code encountered during loading a Jpeg.

0 : ARITH_NOTIMPL 'There are legal restrictions on arithmetic coding'
1 : BAD_ALIGN_TYPE 'ALIGN_TYPE is wrong'
2 : BAD_ALLOC_CHUNK "MAX_ALLOC_CHUNK is wrong"
3 : BAD_BUFFER_MODE "Bogus buffer control mode"
4 : BAD_COMPONENT_ID "Invalid component ID in SOS"
5 : BAD_DCT_COEF "DCT coefficient out of range"
6 : BAD_DCTSIZE "IDCT output block size not supported"
7 : BAD_HUFF_TABLE "Bogus Huffman table definition"
8 : BAD_IN_COLORSPACE "Bogus input colorspace"
9 : BAD_J_COLORSPACE "Bogus JPEG colorspace"
10 : BAD_LENGTH "Bogus marker length"
11 : BAD_LIB_VERSION 'Wrong JPEG library version'
12 : BAD_MCU_SIZE "Sampling factors too large for interleaved scan"
13 : BAD_POOL_ID "Invalid memory pool code"
14 : BAD_PRECISION "Unsupported JPEG data precision"
15 : BAD_PROGRESSION "Invalid progressive parameters"
16 : BAD_PROG_SCRIPT "Invalid progressive parameters"
17 : BAD_SAMPLING "Bogus sampling factors"
18 : BAD_SCAN_SCRIPT "Invalid scan script"
19 : BAD_STATE "Improper call to JPEG library"
20 : BAD_STRUCT_SIZE "JPEG parameter struct mismatch "
21 : BAD_VIRTUAL_ACCESS "Bogus virtual array access"
22 : BUFFER_SIZE "Buffer passed to JPEG library is too small"
23 : CANT_SUSPEND "Suspension not allowed here"
24 : CCIR601_NOTIMPL "CCIR601 sampling not implemented yet"
25 : COMPONENT_COUNT "Too many color components "
26 : CONVERSION_NOTIMPL "Unsupported color conversion request"
27 : DAC_INDEX "Bogus DAC "
28 : DAC_VALUE "Bogus DAC "
29 : DHT_INDEX "Bogus DHT "
30 : DQT_INDEX "Bogus DQT "
31 : EMPTY_IMAGE "Empty JPEG image (DNL not supported)"
32 : EMS_READ "Read from EMS failed"
33 : EMS_WRITE "Write to EMS failed"
34 : EOI_EXPECTED "Didn't expect more than one scan"
35 : FILE_READ "Input file read error"
36 : FILE_WRITE "Output file write error --- out of disk space?"
37 : FRACT_SAMPLE_NOTIMPL "Fractional sampling not implemented yet"
38 : HUFF_CLEN_OVERFLOW "Huffman code size table overflow"
39 : HUFF_MISSING_CODE "Missing Huffman code table entry"
40 : IMAGE_TOO_BIG "Image too big'
41 : INPUT_EMPTY "Empty input file"
42 : INPUT_EOF "Premature end of input file"
43 : MISMATCHED_QUANT_TABLE "Cannot transcode due to multiple use of quantization table"
44 : MISSING_DATA "Scan script does not transmit all data"
45 : MODE_CHANGE "Invalid color quantization mode change"
46 : NOTIMPL "Not implemented yet"
47 : NOT_COMPILED "Requested feature was omitted at compile time"
48 : NO_BACKING_STORE "Backing store not supported"
49 : NO_HUFF_TABLE "Huffman table was not defined"
50 : NO_IMAGE "JPEG datastream contains no image"
51 : NO_QUANT_TABLE "Quantization table was not defined"
52 : NO_SOI "Not a Jpeg file"
53 : OUT_OF_MEMORY "Insufficient memory"
54 : QUANT_COMPONENTS "Cannot quantize"
55 : QUANT_FEW_COLORS "Cannot quantize"
56 : QUANT_MANY_COLORS "Cannot quantize"
57 : SOF_DUPLICATE "Invalid Jpeg file structure: two SOF markers"
58 : SOF_NO_SOS "Invalid Jpeg file structure: missing SOS marker"
59 : SOF_UNSUPPORTED "Unsupported JPEG process"
60 : SOI_DUPLICATE "Invalid Jpeg file structure: two SOI markers"
61 : SOS_NO_SOF "Invalid Jpeg file structure: SOS before SOF"
62 : TFILE_CREATE "Failed to create temporary file"
63 : TFILE_READ "Read failed on temporary file"
64 : TFILE_SEEK "Seek failed on temporary file"
65 : TFILE_WRITE "Write failed on temporary file --- out of disk space?"
66 : TOO_LITTLE_DATA "Application transferred too few scanlines"
67 : UNKNOWN_MARKER "Unsupported marker"
68 : VIRTUAL_BUG "Virtual array controller messed up"
69 : WIDTH_OVERFLOW "Image too wide for this implementation"
70 : XMS_READ "Read from XMS failed"
71 : XMS_WRITE "Write to XMS failed"
72 : COPYRIGHT
73 : VERSION
74 : 16BIT_TABLES "Caution: quantization tables are too coarse for baseline JPEG"
75 : ADOBE "Adobe APP14 marker"
76 : APP0 "Unknown APP0 marker"
77 : APP14 "Unknown APP14 marker"
78 : DAC "Define Arithmetic Table"
79 : DHT "Define Huffman Table"
80 : DQT "Define Quantization Table"
81 : DRI "Define Restart Interval"
82 : EMS_CLOSE "Freed EMS handle
83 : EMS_OPEN "Obtained EMS handle"
84 : EOI "End Of Image"
85 : HUFFBITS
86 : JFIF "JFIF APP0 marker "
87 : JFIF_BADTHUMBNAILSIZE "Warning: thumbnail image size does not match data length"
88 : JFIF_EXTENSION "JFIF extension marker"
89 : JFIF_THUMBNAIL
90 : MISC_MARKER "Miscellaneous marker"
91 : PARMLESS_MARKER "Unexpected marker"
92 : QUANTVALS
93 : QUANT_3_NCOLORS
94 : QUANT_NCOLORS
95 : QUANT_SELECTED
96 : RECOVERY_ACTION
97 : RST
98 : SMOOTH_NOTIMPL "Smoothing not supported with nonstandard sampling ratios"
99 : SOF
100 : SOF_COMPONENT
101 : SOI "Start of Image"
102 : SOS "Start Of Scan"
103 : SOS_COMPONENT
104 : SOS_PARAMS
105 : TFILE_CLOSE "Closed temporary file"
106 : TFILE_OPEN "Opened temporary file"
107 : THUMB_JPEG "JFIF extension marker "
108 : THUMB_PALETTE "JFIF extension marker "
109 : THUMB_RGB "JFIF extension marker "
110 : UNKNOWN_IDS "Unrecognized component IDs, assuming YCbCr"
111 : XMS_CLOSE "Freed XMS handle"
112 : XMS_OPEN "Obtained XMS handle"
113 : ADOBE_XFORM "Unknown Adobe color transform code"
114 : BOGUS_PROGRESSION "Inconsistent progression sequence "
115 : EXTRANEOUS_DATA "Corrupt JPEG data: extraneous bytes before marker"
116 : HIT_MARKER "Corrupt JPEG data: premature end of data segment"
117 : HUFF_BAD_CODE "Corrupt JPEG data: bad Huffman code"
118 : JFIF_MAJOR "Warning: unknown JFIF revision number"
119 : JPEG_EOF "Premature end of Jpeg file"
120 : MUST_RESYNC "Corrupt JPEG data "
121 : NOT_SEQUENTIAL "Invalid SOS parameters for sequential JPEG"
122 : TOO_MUCH_DATA "Application transferred too many scanlines"
!!}
    property JPEG_WarningCode: integer read fJPEG_WarningCode write fJPEG_WarningCode;

{!!
<FS>TIOParamsVals.JPEG_OriginalWidth

<FM>Declaration<FC>
property JPEG_OriginalWidth:integer;

<FM>Description<FN>
JPEG_OriginalWidth specifies the original width when the jpeg image is scaled (using JPEG_Scale).
Contains the same value of <A TIOParamsVals.OriginalWidth>.
See also <A TIOParamsVals.JPEG_OriginalHeight>.
!!}
    property JPEG_OriginalWidth: integer read fOriginalWidth write fOriginalWidth;

{!!
<FS>TIOParamsVals.JPEG_OriginalHeight

<FM>Declaration<FC>
property JPEG_OriginalHeight:integer;

<FM>Description<FN>
JPEG_OriginalHeight specifies the original height when the Jpeg image is scaled (using JPEG_Scale).
Contains the same value of <A TIOParamsVals.OriginalHeight>.
See also <A TIOParamsVals.JPEG_OriginalWidth>
!!}
    property JPEG_OriginalHeight: integer read fOriginalHeight write fOriginalHeight;

{!!
<FS>TIOParamsVals.OriginalWidth

<FM>Declaration<FC>
property OriginalWidth:integer;

<FM>Description<FN>
OriginalWidth specifies the original width when an image is scaled during loading.
See also <A TIOParamsVals.OriginalHeight>.
!!}
    property OriginalWidth: integer read fOriginalWidth write fOriginalWidth;

{!!
<FS>TIOParamsVals.OriginalHeight

<FM>Declaration<FC>
property OriginalHeight:integer;

<FM>Description<FN>
OriginalHeight specifies the original height when an image is scaled during loading.
See also <A TIOParamsVals.OriginalWidth>.
!!}
    property OriginalHeight: integer read fOriginalHeight write fOriginalHeight;

{!!
<FS>TIOParamsVals.JPEG_EnableAdjustOrientation

<FM>Declaration<FC>
property JPEG_EnableAdjustOrientation: boolean;

<FM>Description<FN>
If you set this property to True before load a Jpeg which contains EXIF information, the image will be automatically rotated.

<FM>Example<FC>

ImageEnView1.IO.Params.JPEG_EnableAdjustOrientation:=True;
ImageEnView1.IO.LoadFromFile('input.jpg');
!!}
    property JPEG_EnableAdjustOrientation: boolean read fJPEG_EnableAdjustOrientation write fJPEG_EnableAdjustOrientation;

{!!
<FS>TIOParamsVals.JPEG_GetExifThumbnail

<FM>Declaration<FC>
property JPEG_GetExifThumbnail:boolean;

<FM>Description<FN>
Setting this property to True means that you want a thumbnail instead of the full image.
This works only if a thumbnail is present in EXIF fields.

<FM>Example<FC>

// I wants only the thumbnail
ImageEnView1.IO.Params.JPEG_GetExifThumbnail:=True;
ImageEnView1.IO.LoadFromFile('input.jpg');
!!}
    property JPEG_GetExifThumbnail:boolean read fJPEG_GetExifThumbnail write SetJPEG_GetExifThumbnail;

    // JPEG2000
{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TIOParamsVals.J2000_ColorSpace

<FM>Declaration<FC>
property J2000_ColorSpace:<A TIOJ2000ColorSpace>;

<FM>Description<FN>
J2000_ColorSpace specifies the saved/loaded color space.

!!}
    property J2000_ColorSpace: TIOJ2000ColorSpace read fJ2000_ColorSpace write fJ2000_ColorSpace;

{!!
<FS>TIOParamsVals.J2000_Rate

<FM>Declaration<FC>
property J2000_Rate:double;

<FM>Description<FN>
J2000_Rate specifies the compression rate to apply. Allowed values from 0 to 1, where 1 is no compression (lossless mode).

<FM>Example<FC>

// saves lossless
ImageEnIO.Params.J2000_Rate:=1;
ImageEnIO.SaveToFile('output.jp2');

// saves with loss compression
ImageEnView1.IO.Params.J2000_Rate:=0.015
ImageEnView1.IO.SaveToFile('output.jp2');
!!}
    property J2000_Rate: double read fJ2000_Rate write fJ2000_Rate;

{!!
<FS>TIOParamsVals.J2000_ScalableBy

<FM>Declaration<FC>
property J2000_ScalableBy:<A TIOJ2000ScalableBy>;

<FM>Description<FN>
J2000_ScalableBy specifies the progression order.
!!}
    property J2000_ScalableBy: TIOJ2000ScalableBy read fJ2000_ScalableBy write fJ2000_ScalableBy;

{$ENDIF}

    // PCX

{!!
<FS>TIOParamsVals.PCX_Version

<FM>Declaration<FC>
property PCX_Version: integer;

<FM>Description<FN>
PCX_Version (5 is the default).
!!}
    property PCX_Version: integer read fPCX_Version write fPCX_Version;

{!!
<FS>TIOParamsVals.PCX_Compression

<FM>Declaration<FC>
property PCX_Compression: <A TIOPCXCompression>;

<FM>Description<FN>
PCX_Compression is the compression type for PCX image format.
!!}
    property PCX_Compression: TIOPCXCompression read fPCX_Compression write fPCX_Compression;

    // BMP

{!!
<FS>TIOParamsVals.BMP_Version

<FM>Declaration<FC>
property BMP_Version: <A TIOBMPVersion>;

<FM>Description<FN>
BMP_Version specifies the version of the BMP file.

<FM>Example<FC>

// saves a Windows 3.x bitmap
ImageEnView1.IO.Params.BMP_Version:=ioBMP_BM3;
ImageEnView1.IO.SaveToFile('alfa.bmp');
!!}
    property BMP_Version: TIOBMPVersion read fBMP_Version write fBMP_Version;

{!!
<FS>TIOParamsVals.BMP_Compression

<FM>Declaration<FC>
property BMP_Compression: <A TIOBMPCompression>;

<FM>Description<FN>
BMP_Compression specifies the compression method.

Only 16 or 256 color bitmap can be saved with RLE compression.

<FM>Example<FC>

// saves compressed bitmap
ImageEnView1.IO.Params.BMP_Compression:=ioBMP_RLE;
ImageEnView1.IO.SaveToFile('alfa.bmp');
!!}
    property BMP_Compression: TIOBMPCompression read fBMP_Compression write fBMP_Compression;

{!!
<FS>TIOParamsVals.BMP_HandleTransparency

<FM>Declaration<FC>
property BMP_HandleTransparency: Boolean;

<FM>Description<FN>
BMP file can have 32 bits per pixel. This property controls how interpret the extra byte in the 32 bit word.
When BMP_HandleTransparency is true the extra byte is interpreted as alpha channel, otherwise it is just discarded (ignored).
This means that when a 32-bit bitmap is displayed in ImageEn, the transparent color is not used and the image is displayed without transparency if the BMP_HandleTransparency property is False.
If the BMP_HandleTransparency property is true then the image is displayed with transparency.

<FM>Example<FC>
//BMP_HandleTransparency = true then display with transparency
ImageENVect1.IO.Params.BMP_HandleTransparency := BMP_HandleTransparency1.Checked;
ImageENVect1.IO.LoadFromFile( FilePath );
!!}
    property BMP_HandleTransparency: boolean read fBMP_HandleTransparency write fBMP_HandleTransparency;

    // ICO

{!!
<FS>TIOParamsVals.ICO_ImageIndex

<FM>Declaration<FC>
property ICO_ImageIndex:integer;

<FM>Description<FN>
The ICO_ImageIndex is the index (from 0) of the image. An ICO file can contain multiple images inside.

<FM>Example<FC>

// Load the second image inside 'alfa.ico'
ImageEnView1.IO.Params.ICO_ImageIndex:=1;
ImageEnView1.IO.LoadFromFile('alfa.ico');
!!}
    property ICO_ImageIndex: integer read fICO_ImageIndex write SetImageIndex;

{!!
<FS>TIOParamsVals.ICO_Background

<FM>Declaration<FC>
property ICO_background:<A TRGB>;

<FM>Description<FN>
ICO_background is the background color where to merge loaded image.
Applications should set this property before loading images.
ICO_Background is used only when you load icon files.
This is needed to set a specific color as transparent (the image background) for viewing.
When you save an image as an icon, only the image alpha channel is used.
If you want to make a color transparent you should use <A TImageEnProc.SetTransparentColors> before saving the file.

<FM>Reading example<FC>
ImageEnView1.IO.Params.ICO_Background:=CreateRGB(255,255,255);
ImageEnView1.IO.LoadFromFileICO('myicon.ico');

<FM>Writing example<FC>
ImageEnView1.Proc.SetTransparentColors( transparent_color, transparent_color, 0 );
ImageEnView1.IO.SaveToFileICO('myicon.ico');

!!}
    property ICO_Background: TRGB read fICO_Background write fICO_Background;

    // CUR

{!!
<FS>TIOParamsVals.CUR_ImageIndex

<FM>Declaration<FC>
property CUR_ImageIndex:integer;

<FM>Description<FN>
The CUR_ImageIndex is the index (from 0) of the image.
A CUR file can contain multiple images inside.

<FM>Example<FC>

// Load the second cursor inside 'alfa.cur'
ImageEnView1.IO.Params.CUR_ImageIndex:=1;
ImageEnView1.IO.LoadFromFile('alfa.cur');
!!}
    property CUR_ImageIndex: integer read fCUR_ImageIndex write SetImageIndex;

{!!
<FS>TIOParamsVals.CUR_XHotSpot

<FM>Declaration<FC>
property CUR_XHotSpot:integer;

<FM>Description<FN>
CUR_XHotSpot is the horizontal position of hot spot point.
See also <A TIOParamsVals.CUR_YHotSpot>.
!!}
    property CUR_XHotSpot: integer read fCUR_XHotSpot write fCUR_XHotSpot;

{!!
<FS>TIOParamsVals.CUR_YHotSpot

<FM>Declaration<FC>
property CUR_YHotSpot:integer;

<FM>Description<FN>
CUR_YHotSpot is the vertical position of hot spot point.
See also <A TIOParamsVals.CUR_XHotSpot>.
!!}
    property CUR_YHotSpot: integer read fCUR_YHotSpot write fCUR_YHotSpot;

{!!
<FS>TIOParamsVals.CUR_Background

<FM>Declaration<FC>
property CUR_Background:<A TRGB>;

<FM>Description<FN>
CUR_Background is the background color where to merge loaded image. Applications should set this property before loading images.

<FM>Example<FC>
ImageEnView1.IO.Params.CUR_Background:=CreateRGB(255,255,255);
ImageEnView1.IO.LoadFromFileCUR('myicon.cur');
!!}
    property CUR_Background: TRGB read fCUR_Background write fCUR_Background;

{$ifdef IEINCLUDEDICOM}

    // DICOM

{!!
<FS>TIOParamsVals.DICOM_Tags

<FM>Declaration<FC>
property DICOM_Tags:<A TIEDICOMTags>;

<FM>Description<FN>
This object contains the list of DICOM tags.
Please look at inputoutput\DICOM example for more details.
For a list of DICOM tags look at DICOM documentation.

<FM>Example<FC>
ImageType := ImageEnView1.IO.Params.DICOM_Tags.GetTagString( tags.IndexOf($0008,$0008) );
PatientName := ImageEnView1.IO.Params.DICOM_Tags.GetTagString( tags.IndexOf($0010,$0010) );
!!}
    property DICOM_Tags:TIEDICOMTags read fDICOM_Tags;
{$endif}

    // PNG

{!!
<FS>TIOParamsVals.PNG_Interlaced

<FM>Declaration<FC>
property PNG_Interlaced:boolean;

<FM>Description<FN>
The image is interlaced if PNG_Interlaced is True.
!!}
    property PNG_Interlaced: boolean read fPNG_Interlaced write fPNG_Interlaced;

{!!
<FS>TIOParamsVals.PNG_Background

<FM>Declaration<FC>
property PNG_Background:<A TRGB>;

<FM>Description<FN>
Specifies the background color of the image.
!!}
    property PNG_Background: TRGB read fPNG_Background write fPNG_Background;

{!!
<FS>TIOParamsVals.PNG_Filter

<FM>Declaration<FC>
property PNG_Filter:<A TIOPNGFilter>;

<FM>Description<FN>
Set the PNG_Filter filter to apply. This can have a significant impact on the size and encoding speed and a somewhat lesser impact on the decoding speed of an image.

<FM>Example<FC>

// Set best compression
ImageEnView1.IO.Params.PNG_Filter:=ioPNG_FILTER_PAETH;
ImageEnView1.IO.Params.PNG_Compression:=9;
// Save PNG
ImageEnView1.IO.SaveToFilePNG('max.png');
!!}
    property PNG_Filter: TIOPNGFilter read fPNG_Filter write fPNG_Filter;

{!!
<FS>TIOParamsVals.PNG_Compression

<FM>Declaration<FC>
property PNG_Compression:integer;

<FM>Description<FN>
PNG_Compression changes how much time PNG-compressor spends on trying to compress the image data.
This property accepts values from 0 (no compression) to 9 (best compression).

<FM>Example<FC>

// Set best compression
ImageEnView1.IO.Params.PNG_Filter:=ioPNG_FILTER_PAETH;
ImageEnView1.IO.Params.PNG_Compression:=9;
// Save PNG
ImageEnView1.IO.SaveToFilePNG('max.png');
!!}
    property PNG_Compression: integer read fPNG_Compression write fPNG_Compression;

{!!
<FS>TIOParamsVals.PNG_TextKeys

<FM>Declaration<FC>
property PNG_TextKeys:TStringList;

<FM>Description<FN>
Contains a list of keys associated to a list of values (<A TIOParamsVals.PNG_TextValues> property).
PNG_TextKeys and <A TIOParamsVals.PNG_TextValues> must contain the same number of values.
Only uncompressed text is supported.

<FM>Example<FC>

// add author and other text info in a PNG file
ImageEnView1.IO.Params.PNG_TextKeys.Add('Author');
ImageEnView1.IO.Params.PNG_TextValues.Add('HiComponents');
ImageEnView1.IO.Params.PNG_TextKeys.Add('Subject');
ImageEnView1.IO.Params.PNG_TextValues.Add('Colosseo');
ImageEnView1.IO.SaveToFile('output.png');

// read all text info from a PNG
for i:=0 to ImageEnView1.IO.Params.PNG_TextKeys.Count-1 do
begin
  key := ImageEnView1.IO.Params.PNG_TextKeys[i];
  value := ImageEnView1.IO.Params.PNG_TextValues[I];
end;
!!}
    property PNG_TextKeys:TStringList read fPNG_TextKeys;

{!!
<FS>TIOParamsVals.PNG_TextValues

<FM>Declaration<FC>
property PNG_TextValues:TStringList;

<FM>Description<FN>
Contains a list of values associated to a list of keys (PNG_TextKeys property).
<A TIOParamsVals.PNG_TextKeys> and PNG_TextValues must contain the same number of values.
Only uncompressed text is supported.

<FM>Example<FC>
<L TIOParamsVals.PNG_TextKeys>Look here</L>
!!}
    property PNG_TextValues:TStringList read fPNG_TextValues;

    //// PSD ////

{!!
<FS>TIOParamsVals.PSD_LoadLayers

<FM>Declaration<FC>
property PSD_LoadLayers:Boolean;

<FM>Description<FN>
If True discards the merged image and load only separated layers. If False (default) loads only the merged image.

<FM>Example<FC>
// loads a multilayer PSD and allow user to move and resize layers
ImageEnView1.IO.Params.PSD_LoadLayers:=true;
ImageEnView1.IO.LoadFromFile('input.psd');
ImageEnView1.MouseInteract:=[ miMoveLayers, miResizeLayers];
!!}
    property PSD_LoadLayers:boolean read fPSD_LoadLayers write fPSD_LoadLayers;

{!!
<FS>TIOParamsVals.PSD_ReplaceLayers

<FM>Declaration<FC>
property PSD_ReplaceLayers:boolean;

<FM>Description<FN>
If <FC>true<FN> current layers are replaced by the content of PSD file, otherwise the PSD file content is append to existing layers.
!!}
    property PSD_ReplaceLayers:boolean read fPSD_ReplaceLayers write fPSD_ReplaceLayers;

{!!
<FS>TIOParamsVals.PSD_HasPremultipliedAlpha

<FM>Declaration<FC>
property PSD_HasPremultipliedAlpha:boolean;

<FM>Description<FN>
If <FC>true<FN> alpha channel is premultiplied.
Read-only.
!!}
    property PSD_HasPremultipliedAlpha:boolean read fPSD_HasPremultipliedAlpha;


    //// HDP ////

{!!
<FS>TIOParamsVals.HDP_ImageQuality

<FM>Declaration<FC>
property HDP_ImageQuality:double;

<FM>Description<FN>
0.0 specifies the lowest possible fidelity rendition and 1.0 specifies the highest fidelity, which for
Microsoft HD Photo results in mathematically lossless compression.
The default value is 0.9.
!!}
    property HDP_ImageQuality:double read fHDP_ImageQuality write fHDP_ImageQuality;

{!!
<FS>TIOParamsVals.HDP_Lossless

<FM>Declaration<FC>
property HDP_Lossless:boolean;

<FM>Description<FN>
Setting this parameter to <FC>true<FN> enables mathematically lossless compression mode and overrides the <A TIOParamsVals.HDP_ImageQuality> parameter setting.
The default value is <FC>false<FN>.
!!}
    property HDP_Lossless:boolean read fHDP_Lossless write fHDP_Lossless;


    //// TGA ////

{!!
<FS>TIOParamsVals.TGA_XPos

<FM>Declaration<FC>
property TGA_XPos:integer;

<FM>Description<FN>
TGA_XPos is the top-left X coordinate where the image will be shown (not used by ImageEn).

!!}
    property TGA_XPos: integer read fTGA_XPos write fTGA_XPos;

{!!
<FS>TIOParamsVals.TGA_YPos

<FM>Declaration<FC>
property TGA_YPos:integer;

<FM>Description<FN>
TGA_YPos is the top-left Y coordinate where the image will be shown (not used by ImageEn).

!!}
    property TGA_YPos: integer read fTGA_YPos write fTGA_YPos;

{!!
<FS>TIOParamsVals.TGA_Compressed

<FM>Declaration<FC>
property TGA_Compressed:boolean;

<FM>Description<FN>
Set the TGA_Compressed property to True to compress a TGA image (RLE compression).

!!}
    property TGA_Compressed: boolean read fTGA_Compressed write fTGA_Compressed;

{!!
<FS>TIOParamsVals.TGA_Descriptor

<FM>Declaration<FC>
property TGA_Descriptor:AnsiString;

<FM>Description<FN>
The TGA_Descriptor contains the descriptor of the TGA file.
!!}
    property TGA_Descriptor: AnsiString read fTGA_Descriptor write fTGA_Descriptor;

{!!
<FS>TIOParamsVals.TGA_Author

<FM>Declaration<FC>
property TGA_Author:AnsiString;

<FM>Description<FN>
TGA_Author contains the author name of the TGA file.
!!}
    property TGA_Author: AnsiString read fTGA_Author write fTGA_Author;

{!!
<FS>TIOParamsVals.TGA_Date

<FM>Declaration<FC>
property TGA_Date:TDateTime;

<FM>Description<FN>
TGA_Date contains the date/time creation of the TGA file.
!!}
    property TGA_Date: TDateTime read fTGA_Date write fTGA_Date;

{!!
<FS>TIOParamsVals.TGA_ImageName

<FM>Declaration<FC>
property TGA_ImageName:AnsiString;

<FM>Description<FN>
TGA_ImageName contains the image name of the TGA file.
!!}
    property TGA_ImageName: AnsiString read fTGA_ImageName write fTGA_ImageName;

{!!
<FS>TIOParamsVals.TGA_Background

<FM>Declaration<FC>
property TGA_Background:<A TRGB>;

<FM>Description<FN>
TGA_Background contains the image background (or transparency) color.
!!}
    property TGA_Background: TRGB read fTGA_Background write fTGA_Background;

{!!
<FS>TIOParamsVals.TGA_AspectRatio

<FM>Declaration<FC>
property TGA_AspectRatio:double;

<FM>Description<FN>
TGA_AspectRatio contains the pixel aspect ratio (pixel width/height) of the TGA image.
!!}
    property TGA_AspectRatio: double read fTGA_AspectRatio write fTGA_AspectRatio;

{!!
<FS>TIOParamsVals.TGA_Gamma

<FM>Declaration<FC>
property TGA_Gamma:double;

<FM>Description<FN>
TGA_Gamma contains the gamma value of the TGA image.
!!}
    property TGA_Gamma: double read fTGA_Gamma write fTGA_Gamma;

{!!
<FS>TIOParamsVals.TGA_GrayLevel

<FM>Declaration<FC>
property TGA_GrayLevel:boolean;

<FM>Description<FN>
If TGA_GrayLevel is True, the image will be saved as gray levels.
!!}
    property TGA_GrayLevel: boolean read fTGA_GrayLevel write fTGA_GrayLevel;

    // AVI

{!!
<FS>TIOParamsVals.AVI_FrameCount

<FM>Declaration<FC>
property AVI_FrameCount:integer;

<FM>Description<FN>
AVI_FrameCount specifies how many frames are contained in the last loaded AVI file.
!!}
    property AVI_FrameCount: integer read fAVI_FrameCount write fAVI_FrameCount;

{!!
<FS>TIOParamsVals.AVI_FrameDelayTime

<FM>Declaration<FC>
property AVI_FrameDelayTime:integer;

<FM>Description<FN>
AVI_FrameDelayTime is the time in milliseconds the image will be shown on playing.
!!}
    property AVI_FrameDelayTime: integer read fAVI_FrameDelayTime write fAVI_FrameDelayTime;

    // MEDIAFILE
    {$ifdef IEINCLUDEDIRECTSHOW}

{!!
<FS>TIOParamsVals.MEDIAFILE_FrameCount

<FM>Declaration<FC>
property MEDIAFILE_FrameCount: integer;

<FM>Description<FN>
Specifies the number of frames of last loaded media file (using <A TImageEnIO.OpenMediaFile>).
!!}
    property MEDIAFILE_FrameCount: integer read fMEDIAFILE_FrameCount write fMEDIAFILE_FrameCount;

{!!
<FS>TIOParamsVals.MEDIAFILE_FrameDelayTime

<FM>Declaration<FC>
property MEDIAFILE_FrameDelayTime: integer;

<FM>Description<FN>
MEDIAFILE_FrameDelayTime is the time in milliseconds the image will be shown on playing.
!!}
    property MEDIAFILE_FrameDelayTime: integer read fMEDIAFILE_FrameDelayTime write fMEDIAFILE_FrameDelayTime;

    {$endif}
    // PXM

{!!
<FS>TIOParamsVals.PXM_Comments

<FM>Declaration<FC>
property PXM_Comments:TStringList;

<FM>Description<FN>
PXM_Comments contains a list of the comments found inside (or to write into) PPM, PBM or PGM files.
!!}
    property PXM_Comments: TStringList read fPXM_Comments;

    // PostScript (PS)

{!!
<FS>TIOParamsVals.PS_PaperWidth

<FM>Declaration<FC>
property PS_PaperWidth:integer

<FM>Description<FN>
PS_PaperWidth specifies the paper width in PostScript points (1 point=1/72 of inch).
Default values are width=595 and height=842 (A4 format).
Common values are:

<TABLE>
<R> <H>Paper Size</H> <H>PS_PaperWidth</H> <H>PS_PaperHeight</H> </R>
<R> <C>A0</C> <C>2380</C> <C>3368</C> </R>
<R> <C>A1</C> <C>1684</C> <C>2380</C> </R>
<R> <C>A2</C> <C>1190</C> <C>1684</C> </R>
<R> <C>A3</C> <C>842</C> <C>1190</C> </R>
<R> <C>A4</C> <C>595</C> <C>842</C> </R>
<R> <C>A5</C> <C>421</C> <C>595</C> </R>
<R> <C>A6</C> <C>297</C> <C>421</C> </R>
<R> <C>B5</C> <C>501</C> <C>709</C> </R>
<R> <C>letter (8.5"x11")</C> <C>612</C> <C>792</C> </R>
<R> <C>Legal (8.5"x14")</C> <C>612</C> <C>1008</C> </R>
<R> <C>ledger (17"x11")</C> <C>1224</C> <C>792</C> </R>
<R> <C>11"x17"</C> <C>792</C> <C>1224</C> </R>
</TABLE>

<FM>Example<FC>
// save using letter paper size
ImageEnView1.IO.Params.PS_PaperWidth:=612;
ImageEnView1.IO.Params.PS_PaperHeight:=792;
ImageEnView1.IO.SaveToFile('output.ps');
!!}
    property PS_PaperWidth: integer read fPS_PaperWidth write fPS_PaperWidth;

{!!
<FS>TIOParamsVals.PS_PaperHeight

<FM>Declaration<FC>
property PS_PaperHeight:integer

<FM>Description<FN>
PS_PaperHeight specifies the paper height in PostScript points (1 point=1/72 of inch).
Default values are width=595 and height=842 (A4 format).
Common values are:

<TABLE>
<R> <H>Paper Size</H> <H>PS_PaperWidth</H> <H>PS_PaperHeight</H> </R>
<R> <C>A0</C> <C>2380</C> <C>3368</C> </R>
<R> <C>A1</C> <C>1684</C> <C>2380</C> </R>
<R> <C>A2</C> <C>1190</C> <C>1684</C> </R>
<R> <C>A3</C> <C>842</C> <C>1190</C> </R>
<R> <C>A4</C> <C>595</C> <C>842</C> </R>
<R> <C>A5</C> <C>421</C> <C>595</C> </R>
<R> <C>A6</C> <C>297</C> <C>421</C> </R>
<R> <C>B5</C> <C>501</C> <C>709</C> </R>
<R> <C>letter (8.5"x11")</C> <C>612</C> <C>792</C> </R>
<R> <C>Legal (8.5"x14")</C> <C>612</C> <C>1008</C> </R>
<R> <C>ledger (17"x11")</C> <C>1224</C> <C>792</C> </R>
<R> <C>11"x17"</C> <C>792</C> <C>1224</C> </R>
</TABLE>

<FM>Example<FC>
// save using letter paper size
ImageEnView1.IO.Params.PS_PaperWidth:=612;
ImageEnView1.IO.Params.PS_PaperHeight:=792;
ImageEnView1.IO.SaveToFile('output.ps');
!!}
    property PS_PaperHeight: integer read fPS_paperHeight write fPS_PaperHeight;

{!!
<FS>TIOParamsVals.PS_Compression

<FM>Declaration<FC>
property PS_Compression:<A TIOPSCompression>;

<FM>Description<FN>
PS_Compression specifies the compression filter for a PostScript file.

<FM>Example<FC>
ImageEnView1.IO.LoadFromFile('input.tif');
ImageEnView1.IO.Params.PS_Compression:=ioPS_G4FAX;
ImageEnView1.IO.SaveToFile('output.ps');
!!}
    property PS_Compression: TIOPSCompression read fPS_Compression write fPS_Compression;

{!!
<FS>TIOParamsVals.PS_Title

<FM>Declaration<FC>
property PS_Title:AnsiString;

<FM>Description<FN>
PS_Title specifies the title of the PostScript file.
!!}
    property PS_Title: AnsiString read fPS_Title write fPS_Title;

    // PDF

{!!
<FS>TIOParamsVals.PDF_PaperWidth

<FM>Declaration<FC>
property PDF_PaperWidth:integer

<FM>Description<FN>
PDF_PaperWidth specifies the paper width in Adobe PDF points (1 point=1/72 of inch).
Default values are width=595 and height=842 (A4 format).
Common values are:

<TABLE>
<R> <H>Paper Size</H> <H>PDF_PaperWidth</H> <H>PDF_PaperHeight</H> </R>
<R> <C>A0</C> <C>2380</C> <C>3368</C> </R>
<R> <C>A1</C> <C>1684</C> <C>2380</C> </R>
<R> <C>A2</C> <C>1190</C> <C>1684</C> </R>
<R> <C>A3</C> <C>842</C> <C>1190</C> </R>
<R> <C>A4</C> <C>595</C> <C>842</C> </R>
<R> <C>A5</C> <C>421</C> <C>595</C> </R>
<R> <C>A6</C> <C>297</C> <C>421</C> </R>
<R> <C>B5</C> <C>501</C> <C>709</C> </R>
<R> <C>letter (8.5"x11")</C> <C>612</C> <C>792</C> </R>
<R> <C>Legal (8.5"x14")</C> <C>612</C> <C>1008</C> </R>
<R> <C>ledger (17"x11")</C> <C>1224</C> <C>792</C> </R>
<R> <C>11"x17"</C> <C>792</C> <C>1224</C> </R>
</TABLE>

<FM>Example<FC>
// save using letter paper size
ImageEnView1.IO.Params.PDF_PaperWidth:=612;
ImageEnView1.IO.Params.PDF_PaperHeight:=792;
ImageEnView1.IO.SaveToFile('output.pdf');
!!}
    property PDF_PaperWidth: integer read fPDF_PaperWidth write fPDF_PaperWidth;

{!!
<FS>TIOParamsVals.PDF_PaperHeight

<FM>Declaration<FC>
property PDF_PaperHeight:integer

<FM>Description<FN>
PDF_PaperHeight specifies the paper height in Adobe PDF points (1 point=1/72 of inch).
Default values are width=595 and height=842 (A4 format).
Common values are:

<TABLE>
<R> <H>Paper Size</H> <H>PDF_PaperWidth</H> <H>PDF_PaperHeight</H> </R>
<R> <C>A0</C> <C>2380</C> <C>3368</C> </R>
<R> <C>A1</C> <C>1684</C> <C>2380</C> </R>
<R> <C>A2</C> <C>1190</C> <C>1684</C> </R>
<R> <C>A3</C> <C>842</C> <C>1190</C> </R>
<R> <C>A4</C> <C>595</C> <C>842</C> </R>
<R> <C>A5</C> <C>421</C> <C>595</C> </R>
<R> <C>A6</C> <C>297</C> <C>421</C> </R>
<R> <C>B5</C> <C>501</C> <C>709</C> </R>
<R> <C>letter (8.5"x11")</C> <C>612</C> <C>792</C> </R>
<R> <C>Legal (8.5"x14")</C> <C>612</C> <C>1008</C> </R>
<R> <C>ledger (17"x11")</C> <C>1224</C> <C>792</C> </R>
<R> <C>11"x17"</C> <C>792</C> <C>1224</C> </R>
</TABLE>

<FM>Example<FC>
// save using letter paper size
ImageEnView1.IO.Params.PDF_PaperWidth:=612;
ImageEnView1.IO.Params.PDF_PaperHeight:=792;
ImageEnView1.IO.SaveToFile('output.pdf');
!!}
    property PDF_PaperHeight: integer read fPDF_paperHeight write fPDF_PaperHeight;

{!!
<FS>TIOParamsVals.PDF_Compression

<FM>Declaration<FC>
property PDF_Compression:<A TIOPDFCompression>;

<FM>Description<FN>
PDF_Compression specifies the compression filter for an Adobe PDF file.

<FM>Example<FC>
ImageEnView1.IO.LoadFromFile('input.tif');
ImageEnView1.IO.Params.PDF_Compression:=ioPDF_G4FAX;
ImageEnView1.IO.SaveToFile('output.pdf');
!!}
    property PDF_Compression: TIOPDFCompression read fPDF_Compression write fPDF_Compression;

{!!
<FS>TIOParamsVals.PDF_Title

<FM>Declaration<FC>
property PDF_Title:AnsiString;

<FM>Description<FN>
Specifies the PDF document's title.
!!}
    property PDF_Title: AnsiString read fPDF_Title write fPDF_Title;

{!!
<FS>TIOParamsVals.PDF_Author

<FM>Declaration<FC>
property PDF_Author:AnsiString;

<FM>Description<FN>
Specifies the name of the person who created the document.
!!}
    property PDF_Author: AnsiString read fPDF_Author write fPDF_Author;

{!!
<FS>TIOParamsVals.PDF_Subject

<FM>Declaration<FC>
property PDF_Subject:AnsiString;

<FM>Description<FN>
Specifies the subject of the document.
!!}
    property PDF_Subject: AnsiString read fPDF_Subject write fPDF_Subject;

{!!
<FS>TIOParamsVals.PDF_Keywords

<FM>Declaration<FC>
property PDF_Keywords:AnsiString;

<FM>Description<FN>
Specifies the keywords associated with the document.
!!}
    property PDF_Keywords: AnsiString read fPDF_Keywords write fPDF_Keywords;

{!!
<FS>TIOParamsVals.PDF_Creator

<FM>Declaration<FC>
property PDF_Creator:AnsiString;

<FM>Description<FN>
Specifies the name of the application that created the original document.
!!}
    property PDF_Creator: AnsiString read fPDF_Creator write fPDF_Creator;

{!!
<FS>TIOParamsVals.PDF_Producer

<FM>Declaration<FC>
property PDF_Producer:AnsiString;

<FM>Description<FN>
Specifies the name of the application that converted the image to PDF.
!!}
    property PDF_Producer: AnsiString read fPDF_Producer write fPDF_Producer;

    //// EXIF ////

    property EXIF_Tags:TList read fEXIF_Tags;

{!!
<FS>TIOParamsVals.EXIF_HasEXIFData

<FM>Declaration<FC>
property EXIF_HasEXIFData:boolean;

<FM>Description<FN>
If EXIF_HasEXIFData is True, the loaded image contains EXIF information tags.
If you want to maintain the original EXIF info, set EXIF_HasEXIFData to False, before saving.

Important Note: If an image is assigned from an <A TImageEnView> to another, the EXIF tags is NOT automatically assigned.
To maintain EXIF data in the second <A TImageEnView> or <A TImageEnVect>, you must also assign the EXIF Data:  This applies to all ImageEn 'Display' components including TImageEnView and TImageEnVect.

Here is typical situations:
1) You want to maintain EXIF untouched:
  nothing to do...
2) you want change some EXIF fields, for example:
  Params.EXIF_Software:='ImageEn';
  Params.EXIF_HasEXIFData:=true;
3) you wnat remove all EXIFs:
  Params.ResetInfo;

<FM>Example<FC>

// In this example, a form named DlgEXIF has a TImageEnView (ImageEnView1) and another form has a TImageEnView (ImageEnView).  Both the image and its EXIF data are passed from one to another via assign.

// Assign the image to DlgEXIF
DlgEXIF.ImageEnView1.Assign ( ImageEnView );
// Assign EXIF data to DlgEXIF.ImageEnView1
DlgEXIF.ImageEnView1.IO.Params.Assign ( ImageEnView.IO.Params );
!!}
    property EXIF_HasEXIFData: boolean read fEXIF_HasEXIFData write fEXIF_HasEXIFData;


{!!
<FS>TIOParamsVals.EXIF_Bitmap

<FM>Declaration<FC>
property EXIF_Bitmap:<A TIEBitmap>;

<FM>Description<FN>
Contains thumbnails - not all formats are supported. EXIF_Bitmap is supported only on reading.
!!}
    property EXIF_Bitmap: TIEBitmap read fEXIF_Bitmap write fEXIF_Bitmap;

{!!
<FS>TIOParamsVals.EXIF_ImageDescription

<FM>Declaration<FC>
property EXIF_ImageDescription:AnsiString;

<FM>Description<FN>
Describes the image.
!!}
    property EXIF_ImageDescription: AnsiString read fEXIF_ImageDescription write fEXIF_ImageDescription;

{!!
<FS>TIOParamsVals.EXIF_Make

<FM>Declaration<FC>
property EXIF_Make:AnsiString;

<FM>Description<FN>
The manufacturer of the recording equipment. This is the manufacturer of the DSC, scanner, video digitizer or other
equipment that generated the image.
!!}
    property EXIF_Make: AnsiString read fEXIF_Make write fEXIF_Make;

{!!
<FS>TIOParamsVals.EXIF_Model

<FM>Declaration<FC>
property EXIF_Model:AnsiString;

<FM>Description<FN>
Shows model number of digicam
!!}
    property EXIF_Model: AnsiString read fEXIF_Model write fEXIF_Model;

{!!
<FS>TIOParamsVals.EXIF_Orientation

<FM>Declaration<FC>
property EXIF_Orientation:integer;

<FM>Description<FN>
The orientation of the camera relative to the scene, when the image was captured

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>1<FN></C> <C>top left side</C> </R>
<R> <C><FC>2<FN></C> <C>top right side</C> </R>
<R> <C><FC>3<FN></C> <C>bottom right side</C> </R>
<R> <C><FC>4<FN></C> <C>bottom left side</C> </R>
<R> <C><FC>5<FN></C> <C>left side top</C> </R>
<R> <C><FC>6<FN></C> <C>right side top</C> </R>
<R> <C><FC>7<FN></C> <C>right side bottom</C> </R>
<R> <C><FC>8<FN></C> <C>left side bottom</C> </R>
</TABLE>
!!}
    property EXIF_Orientation: integer read fEXIF_Orientation write SetEXIF_Orientation;

{!!
<FS>TIOParamsVals.EXIF_XResolution

<FM>Declaration<FC>
property EXIF_XResolution:double;

<FM>Description<FN>
Resolution of image. Default value is 1/72 inch (one 'point'), but it has no meaning because personal computers typicaly don't use this value to display/print.
!!}
    property EXIF_XResolution: double read fEXIF_XResolution write SetEXIF_XResolution;

{!!
<FS>TIOParamsVals.EXIF_YResolution

<FM>Declaration<FC>
property EXIF_YResolution:double;

<FM>Description<FN>
Resolution of image. Default value is 1/72 inch (one 'point'), but it has no meaning because personal computers typicaly don't use this value to display/print.
!!}
    property EXIF_YResolution: double read fEXIF_YResolution write SetEXIF_YResolution;

{!!
<FS>TIOParamsVals.EXIF_ResolutionUnit

<FM>Declaration<FC>
property EXIF_ResolutionUnit:integer;

<FM>Description<FN>
Unit of XResolution/YResolution.
        1 means no unit
        2 means inch
        3 means centimeter
         Default value is 2 (inch)
!!}
    property EXIF_ResolutionUnit: integer read fEXIF_ResolutionUnit write fEXIF_ResolutionUnit;

{!!
<FS>TIOParamsVals.EXIF_Software

<FM>Declaration<FC>
property EXIF_Software:AnsiString;

<FM>Description<FN>
Shows firmware(internal software of digicam) version number
!!}
    property EXIF_Software: AnsiString read fEXIF_Software write fEXIF_Software;

{!!
<FS>TIOParamsVals.EXIF_Artist

<FM>Declaration<FC>
property EXIF_Artist:AnsiString;

<FM>Description<FN>
Specifies the EXIF artist.
!!}
    property EXIF_Artist:AnsiString read fEXIF_Artist write fEXIF_Artist;

{!!
<FS>TIOParamsVals.EXIF_DateTime

<FM>Declaration<FC>
property EXIF_DateTime:AnsiString;

<FM>Description<FN>
Date/Time of image was last modified. Data format is "YYYY:MM:DD HH:MM:SS"+0x00, total 20 bytes. If clock has not set or digicam doesn't have clock, the field may be filled with spaces. Usually it has the same value of DateTimeOriginal.
!!}
    property EXIF_DateTime: AnsiString read fEXIF_DateTime write fEXIF_DateTime;

{!!
<FS>TIOParamsVals.EXIF_WhitePoint

<FM>Declaration<FC>
property EXIF_WhitePoint[index:integer]:double;

<FM>Description<FN>
Defines chromaticity of white points of the image. If the image uses CIE Standard Illumination D65 (known as international standard of 'daylight'), the values are '3127/10000, 3290/10000'.
<FC>index<FN> is in the range 0..1.
"-1" for both values means "unspecified".
!!}
    property EXIF_WhitePoint[index: integer]: double read GetEXIF_WhitePoint write SetEXIF_WhitePoint;

{!!
<FS>TIOParamsVals.EXIF_PrimaryChromaticities

<FM>Declaration<FC>
property EXIF_PrimaryChromaticities[index:integer]:double;

<FM>Description<FN>
Defines chromaticity of the primaries of the image. If the image uses CCIR Recommendation 709 primaries, the values are '640/1000,330/1000,300/1000,600/1000,150/1000,0/1000'.
<FC>index<FN> is in the range 0..5.
"-1" for all values means "unspecified".
!!}
    property EXIF_PrimaryChromaticities[index: integer]: double read GetEXIF_PrimaryChromaticities write SetEXIF_PrimaryChromaticities;

{!!
<FS>TIOParamsVals.EXIF_YCbCrCoefficients

<FM>Declaration<FC>
property EXIF_YCbCrCoefficients[index:integer]:double;

<FM>Description<FN>
When the image format is YCbCr, this value shows a constant to translate it to RGB format. Usually values are '0.299/0.587/0.114'.
<FC>index<FN> is in the range 0..2.
"-1" for all values means "unspecified".
!!}
    property EXIF_YCbCrCoefficients[index: integer]: double read GetEXIF_YCbCrCoefficients write SetEXIF_YCbCrCoefficients;

{!!
<FS>TIOParamsVals.EXIF_YCbCrPositioning

<FM>Declaration<FC>
property EXIF_YCbCrPositioning:integer;

<FM>Description<FN>
When image format is YCbCr and uses 'Subsampling' (cropping of chroma data, all digicams do that), defines the chroma sample point of subsampling pixel array.
        0 means "unspecified"
        1 means the center of pixel array.
        2 means the datum point.
!!}
    property EXIF_YCbCrPositioning: integer read fEXIF_YCbCrPositioning write fEXIF_YCbCrPositioning;

{!!
<FS>TIOParamsVals.EXIF_ReferenceBlackWhite

<FM>Declaration<FC>
property EXIF_ReferenceBlackWhite[index:integer]:double;

<FM>Description<FN>
Shows reference value of black point/white point. In case of YCbCr format, first 2 show black/white of Y, next 2 are Cb, last 2 are Cr. In case of RGB format, first 2 show black/white of R, next 2 are G, last 2 are B.
"-1" for all values means "unspecified".
<FC>index<FN> is in the range 0..5.
!!}
    property EXIF_ReferenceBlackWhite[index: integer]: double read GetEXIF_ReferenceBlackWhite write SetEXIF_ReferenceBlackWhite;

{!!
<FS>TIOParamsVals.EXIF_Copyright

<FM>Declaration<FC>
property EXIF_Copyright:AnsiString;

<FM>Description<FN>
Shows copyright information.
!!}
    property EXIF_Copyright: AnsiString read fEXIF_Copyright write fEXIF_Copyright;

{!!
<FS>TIOParamsVals.EXIF_ExposureTime

<FM>Declaration<FC>
property EXIF_ExposureTime:double;

<FM>Description<FN>
Exposure time (reciprocal of shutter speed). Unit is second.
!!}
    property EXIF_ExposureTime: double read fEXIF_ExposureTime write SetEXIF_ExposureTime;

{!!
<FS>TIOParamsVals.EXIF_FNumber

<FM>Declaration<FC>
property EXIF_FNumber:double;

<FM>Description<FN>
The actual F-number (F-stop) of lens when the image was taken.
!!}
    property EXIF_FNumber: double read fEXIF_FNumber write SetEXIF_FNumber;

{!!
<FS>TIOParamsVals.EXIF_ExposureProgram

<FM>Declaration<FC>
property EXIF_ExposureProgram:integer;

<FM>Description<FN>
Exposure program that the camera used when image was taken.
        1 means manual control
        2 program normal
        3 aperture priority
        4 shutter priority
        5 program creative (slow program)
        6 program action (high-speed program)
        7 portrait mode
        8 landscape mode.
!!}
    property EXIF_ExposureProgram: integer read fEXIF_ExposureProgram write SetEXIF_ExposureProgram;

{!!
<FS>TIOParamsVals.EXIF_ISOSpeedRatings

<FM>Declaration<FC>
property EXIF_ISOSpeedRatings[index:integer]:integer;

<FM>Description<FN>
CCD sensitivity equivalent to Ag-Hr film speedrate.
<FC>index<FN> is in the range 0..1.

"0" for all values means "unspecified".
!!}
    property EXIF_ISOSpeedRatings[index: integer]: integer read GetEXIF_ISOSpeedRatings write SetEXIF_ISOSpeedRatings;

{!!
<FS>TIOParamsVals.EXIF_ExifVersion

<FM>Declaration<FC>
property EXIF_ExifVersion:AnsiString;

<FM>Description<FN>
Exif version number. Stored as 4 bytes of ASCII characters. If the picture is based on Exif V2.1, value is "0210". Since the type is 'undefined', there is no NULL (0x00) for termination.
!!}
    property EXIF_ExifVersion: AnsiString read fEXIF_ExifVersion write fEXIF_ExifVersion;

{!!
<FS>TIOParamsVals.EXIF_DateTimeOriginal

<FM>Declaration<FC>
property EXIF_DateTimeOriginal:AnsiString;

<FM>Description<FN>
Date/Time that the original image was taken. This value should not be modified by user program. Data format is "YYYY:MM:DD HH:MM:SS"+0x00, total 20bytes. If clock has not set or digicam doesn't have clock, the field may be filled with spaces. In the Exif standard, this tag is optional, but it is mandatory for DCF.
!!}
    property EXIF_DateTimeOriginal: AnsiString read fEXIF_DateTimeOriginal write fEXIF_DateTimeOriginal;

{!!
<FS>TIOParamsVals.EXIF_DateTimeDigitized

<FM>Declaration<FC>
property EXIF_DateTimeDigitized:AnsiString;

<FM>Description<FN>
Date/Time of image digitized. Usually, it contains the same value of DateTimeOriginal (0x9003). Data format is "YYYY:MM:DD HH:MM:SS"+0x00, total 20 bytes. If clock has not set or digicam doesn't have clock, the field may be filled with spaces. In the Exif standard, this tag is optional, but it is mandatory for DCF.
!!}
    property EXIF_DateTimeDigitized: AnsiString read fEXIF_DateTimeDigitized write fEXIF_DateTimeDigitized;

{!!
<FS>TIOParamsVals.EXIF_CompressedBitsPerPixel

<FM>Declaration<FC>
property EXIF_CompressedBitsPerPixel:double;

<FM>Description<FN>
The average compression ratio of JPEG (rough estimate)
!!}
    property EXIF_CompressedBitsPerPixel: double read fEXIF_CompressedBitsPerPixel write SetEXIF_CompressedBitsPerPixel;

{!!
<FS>TIOParamsVals.EXIF_ShutterSpeedValue

<FM>Declaration<FC>
property EXIF_ShutterSpeedValue:double;

<FM>Description<FN>
Shutter speed by APEX value.
To convert this value to ordinary 'Shutter Speed'; calculate this value's power of 2, then reciprocal.
For example, if the ShutterSpeedValue is '4', shutter speed is 1/(24)=1/16 second.
!!}
    property EXIF_ShutterSpeedValue: double read fEXIF_ShutterSpeedValue write SetEXIF_ShutterSpeedValue;

{!!
<FS>TIOParamsVals.EXIF_ApertureValue

<FM>Declaration<FC>
property EXIF_ApertureValue:double;

<FM>Description<FN>
The actual aperture value of the lens when the image was taken.
Unit is APEX.
To convert this value to ordinary F-number (F-stop), calculate this value's power of root 2 (=1.4142).
For example, if the ApertureValue is '5', F-number is 1.41425 = F5.6.
!!}
    property EXIF_ApertureValue: double read fEXIF_ApertureValue write SetEXIF_ApertureValue;

{!!
<FS>TIOParamsVals.EXIF_BrightnessValue

<FM>Declaration<FC>
property EXIF_BrightnessValue:double;

<FM>Description<FN>
Brightness of taken subject, unit is APEX. To calculate Exposure (Ev) from BrigtnessValue (Bv), you must add SensitivityValue(Sv).
         Ev=Bv+Sv   Sv=log2(ISOSpeedRating/3.125)
         ISO100:Sv=5, ISO200:Sv=6, ISO400:Sv=7, ISO125:Sv=5.32.
!!}
    property EXIF_BrightnessValue: double read fEXIF_BrightnessValue write SetEXIF_BrightnessValue;

{!!
<FS>TIOParamsVals.EXIF_ExposureBiasValue

<FM>Declaration<FC>
property EXIF_ExposureBiasValue:double;

<FM>Description<FN>
Exposure bias (compensation) value of taking picture. Unit is APEX (EV).
!!}
    property EXIF_ExposureBiasValue: double read fEXIF_ExposureBiasValue write SetEXIF_ExposureBiasValue;

{!!
<FS>TIOParamsVals.EXIF_MaxApertureValue

<FM>Declaration<FC>
property EXIF_MaxApertureValue:double;

<FM>Description<FN>
Maximum aperture value of the lens. Convert to F-number by calculating power of root 2 (same process as ApertureValue).
!!}
    property EXIF_MaxApertureValue: double read fEXIF_MaxApertureValue write SetEXIF_MaxApertureValue;

{!!
<FS>TIOParamsVals.EXIF_SubjectDistance

<FM>Declaration<FC>
property EXIF_SubjectDistance:double;

<FM>Description<FN>
Distance to focus point, unit is meters.
!!}
    property EXIF_SubjectDistance: double read fEXIF_SubjectDistance write SetEXIF_SubjectDistance;

{!!
<FS>TIOParamsVals.EXIF_MeteringMode

<FM>Declaration<FC>
property EXIF_MeteringMode:integer;

<FM>Description<FN>
Exposure metering method:
        0 means unknown
        1 average
        2 center weighted average
        3 spot
        4 multi-spot
        5 multi-segment
        6 partial
        255 other
!!}
    property EXIF_MeteringMode: integer read fEXIF_MeteringMode write SetEXIF_MeteringMode;

{!!
<FS>TIOParamsVals.EXIF_LightSource

<FM>Declaration<FC>
property EXIF_LightSource:integer;

<FM>Description<FN>
Light source, actually this means white balance setting:
        0 means unknown
        1 daylight
        2 fluorescent
        3 tungsten
        10 flash
        17 standard light A
        18 standard light B
        19 standard light C
        20 D55
        21 D65
        22 D75
        255 other
!!}
    property EXIF_LightSource: integer read fEXIF_LightSource write SetEXIF_LightSource;

{!!
<FS>TIOParamsVals.EXIF_Flash

<FM>Declaration<FC>
property EXIF_Flash:integer;

<FM>Description<FN>
        0 means flash did not fire
        1 flash fired
        5 flash fired but strobe return light not detected
        7 flash fired and strobe return light detected
!!}
    property EXIF_Flash: integer read fEXIF_Flash write SetEXIF_Flash;

{!!
<FS>TIOParamsVals.EXIF_FocalLength

<FM>Declaration<FC>
property EXIF_FocalLength:double;

<FM>Description<FN>
Focal length of lens used to take image. Unit is millimeters.
!!}
    property EXIF_FocalLength: double read fEXIF_FocalLength write SetEXIF_FocalLength;

{!!
<FS>TIOParamsVals.EXIF_SubsecTime

<FM>Declaration<FC>
property EXIF_SubsecTime:AnsiString;

<FM>Description<FN>
Some of digicam can take 2~30 pictures per second, but DateTime/DateTimeOriginal/DateTimeDigitized tag can't record the sub-second time. SubsecTime tag is used to record it.
For example, DateTimeOriginal = "1996:09:01 09:15:30", SubSecTimeOriginal = "130", Combined original time is "1996:09:01 09:15:30.130"
!!}
    property EXIF_SubsecTime: AnsiString read fEXIF_SubsecTime write fEXIF_SubsecTime;

{!!
<FS>TIOParamsVals.EXIF_SubsecTimeOriginal

<FM>Declaration<FC>
property EXIF_SubsecTimeOriginal:AnsiString;

<FM>Description<FN>
Some of digicam can take 2~30 pictures per second, but DateTime/DateTimeOriginal/DateTimeDigitized tag can't record the sub-second time. SubsecTime tag is used to record it.
For example, DateTimeOriginal = "1996:09:01 09:15:30", SubSecTimeOriginal = "130", Combined original time is "1996:09:01 09:15:30.130"
!!}
    property EXIF_SubsecTimeOriginal: AnsiString read fEXIF_SubsecTimeOriginal write fEXIF_SubsecTimeOriginal;

{!!
<FS>TIOParamsVals.EXIF_SubsecTimeDigitized

<FM>Declaration<FC>
property EXIF_SubsecTimeDigitized:AnsiString;

<FM>Description<FN>
Some of digicam can take 2~30 pictures per second, but DateTime/DateTimeOriginal/DateTimeDigitized tag can't record the sub-second time. SubsecTime tag is used to record it.
For example, DateTimeOriginal = "1996:09:01 09:15:30", SubSecTimeOriginal = "130", Combined original time is "1996:09:01 09:15:30.130"
!!}
    property EXIF_SubsecTimeDigitized: AnsiString read fEXIF_SubsecTimeDigitized write fEXIF_SubsecTimeDigitized;

{!!
<FS>TIOParamsVals.EXIF_FlashPixVersion

<FM>Declaration<FC>
property EXIF_FlashPixVersion:AnsiString;

<FM>Description<FN>
Stores FlashPix version. If the image data is based on FlashPix format Ver.1.0, value is "0100".
!!}
    property EXIF_FlashPixVersion: AnsiString read fEXIF_FlashPixVersion write fEXIF_FlashPixVersion;

{!!
<FS>TIOParamsVals.EXIF_ColorSpace

<FM>Declaration<FC>
property EXIF_ColorSpace:integer;

<FM>Description<FN>
Defines Color Space. DCF image must use sRGB color space so value is always '1'. If the picture uses the other color space, value is '65535':Uncalibrated.
!!}
    property EXIF_ColorSpace: integer read fEXIF_ColorSpace write SetEXIF_ColorSpace;

{!!
<FS>TIOParamsVals.EXIF_ExifImageWidth

<FM>Declaration<FC>
property EXIF_ExifImageWidth:integer;

<FM>Description<FN>
Size of main image.
!!}
    property EXIF_ExifImageWidth: integer read fEXIF_ExifImageWidth write SetEXIF_ExifImageWidth;

{!!
<FS>TIOParamsVals.EXIF_ExifImageHeight

<FM>Declaration<FC>
property EXIF_ExifImageHeight:integer;

<FM>Description<FN>
Size of main image.
!!}
    property EXIF_ExifImageHeight: integer read fEXIF_ExifImageHeight write SetEXIF_ExifImageHeight;

{!!
<FS>TIOParamsVals.EXIF_RelatedSoundFile

<FM>Declaration<FC>
property EXIF_RelatedSoundFile:AnsiString;

<FM>Description<FN>
If this digicam can record audio data with image, shows name of audio data.
!!}
    property EXIF_RelatedSoundFile: AnsiString read fEXIF_RelatedSoundFile write fEXIF_RelatedSoundFile;

{!!
<FS>TIOParamsVals.EXIF_FocalPlaneXResolution

<FM>Declaration<FC>
property EXIF_FocalPlaneXResolution:double;

<FM>Description<FN>
Pixel density at CCD's position. If you have MegaPixel digicam and take a picture by lower resolution (e.g.VGA mode), this value is re-sampled by picture resolution. In such case, FocalPlaneResolution is not same as CCD's actual resolution.
!!}
    property EXIF_FocalPlaneXResolution: double read fEXIF_FocalPlaneXResolution write SetEXIF_FocalPlaneXResolution;

{!!
<FS>TIOParamsVals.EXIF_FocalPlaneYResolution

<FM>Declaration<FC>
property EXIF_FocalPlaneYResolution:double;

<FM>Description<FN>
Pixel density at CCD's position. If you have MegaPixel digicam and take a picture by lower resolution (e.g.VGA mode), this value is re-sampled by picture resolution. In such case, FocalPlaneResolution is not same as CCD's actual resolution.
!!}
    property EXIF_FocalPlaneYResolution: double read fEXIF_FocalPlaneYResolution write SetEXIF_FocalPlaneYResolution;

{!!
<FS>TIOParamsVals.EXIF_FocalPlaneResolutionUnit

<FM>Declaration<FC>
property EXIF_FocalPlaneResolutionUnit:integer;

<FM>Description<FN>
Unit of FocalPlaneXResoluton/FocalPlaneYResolution:
        1 means no-unit
        2 inch
        3 centimeter
Note: Some of Fujifilm's digicams (e.g. FX2700, FX2900, Finepix 4700Z/40i, etc.) use value '3' so it must be 'centimeter', but it seems that they use a '8.3mm?' (1/3in.?) to their ResolutionUnit. Fuji's BUG? Finepix4900Z has been changed to use value '2' but it doesn't match to actual value either.
!!}
    property EXIF_FocalPlaneResolutionUnit: integer read fEXIF_FocalPlaneResolutionUnit write SetEXIF_FocalPlaneResolutionUnit;

{!!
<FS>TIOParamsVals.EXIF_ExposureIndex

<FM>Declaration<FC>
property EXIF_ExposureIndex:double;

<FM>Description<FN>
Same as <A TIOParamsVals.EXIF_ISOSpeedRatings> (0x8827) but data type is unsigned rational.
Only Kodak's digicam uses this tag instead of <A TIOParamsVals.EXIF_ISOSpeedRatings>.
!!}
    property EXIF_ExposureIndex: double read fEXIF_ExposureIndex write SetEXIF_ExposureIndex;

{!!
<FS>TIOParamsVals.EXIF_SensingMethod

<FM>Declaration<FC>
property EXIF_SensingMethod:integer;

<FM>Description<FN>
Shows type of image sensor unit. '2' means 1 chip color area sensor.  Most all digicams use this type.
!!}
    property EXIF_SensingMethod: integer read fEXIF_SensingMethod write SetEXIF_SensingMethod;

{!!
<FS>TIOParamsVals.EXIF_FileSource

<FM>Declaration<FC>
property EXIF_FileSource:integer;

<FM>Description<FN>
Indicates the image source. Value '0x03' means the image source is a digital still camera.
!!}
    property EXIF_FileSource: integer read fEXIF_FileSource write SetEXIF_FileSource;

{!!
<FS>TIOParamsVals.EXIF_SceneType

<FM>Declaration<FC>
property EXIF_SceneType:integer;

<FM>Description<FN>
Indicates the type of scene. Value of '0x01' means that the image was directly photographed.
!!}
    property EXIF_SceneType: integer read fEXIF_SceneType write SetEXIF_SceneType;

{!!
<FS>TIOParamsVals.EXIF_UserComment

<FM>Declaration<FC>
property EXIF_UserComment:WideString

<FM>Description<FN>
EXIF_UserComment is a tag to write keywords or comments on the image besides those in <A TIOParamsVals.EXIF_ImageDescription>, and without the character code limitations of the EXIF_ImageDescription tag.
The character code is specified by the <A TIOParamsVals.EXIF_UserCommentCode> property.
!!}
    property EXIF_UserComment: WideString read fEXIF_UserComment write fEXIF_UserComment;

{!!
<FS>TIOParamsVals.EXIF_UserCommentCode

<FM>Declaration<FC>
property EXIF_UserCommentCode:AnsiString;

<FM>Description<FN>
Specifies the character code (8 bytes) for the <A TIOParamsVals.EXIF_UserComment> property. Allowed values:
<IMG help_images\1.bmp>
!!}
    property EXIF_UserCommentCode: AnsiString read fEXIF_UserCommentCode write fEXIF_UserCommentCode;

{!!
<FS>TIOParamsVals.EXIF_MakerNote

<FM>Declaration<FC>
property EXIF_MakerNote:<A TIETagsHandler>;

<FM>Description<FN>

EXIF_MakerNote contains maker specific information. Unfortunately there is a standard for this tag, then we a general handler which read the IFD (when present) of the maker note.
We suggest to look at inputoutput/EXIF demo for more details.

<FM>Example<FC>
// returns the ISO from a Canon camera
case ImageEnView1.IO.Params.EXIF_MakerNote.GetIntegerIndexed(1, 16) of
  15: ShowMessage('Auto');
  16: ShowMessage ('50');
  17: ShowMessage ('100');
  18: ShowMessage ('200');
  19: ShowMessage ('400');
end;

<FM>Demo<FN>
inputouput/EXIF
!!}
    property EXIF_MakerNote:TIETagsHandler read fEXIF_MakerNote;

{!!
<FS>TIOParamsVals.EXIF_XPTitle

<FM>Declaration<FC>
property EXIF_XPTitle:WideString;

<FM>Description<FN>
Specifies Windows XP image title. This is shown in properties of jpeg/tiff file under Windows XP.
!!}
    property EXIF_XPTitle:WideString read fEXIF_XPTitle write fEXIF_XPTitle;

{!!
<FS>TIOParamsVals.EXIF_XPRating

<FM>Declaration<FC>
property EXIF_XPRating:integer;

<FM>Description<FN>
Specifies Windows XP image rating. This is shown in properties of jpeg/tiff file under Windows XP.
Allowed values from 0 up to 5.
-1 means not available.
!!}
    property EXIF_XPRating:integer read fEXIF_XPRating write fEXIF_XPRating;

{!!
<FS>TIOParamsVals.EXIF_XPComment

<FM>Declaration<FC>
property EXIF_XPComment:WideString;

<FM>Description<FN>
Specifies Windows XP image comment. This is shown in properties of jpeg/tiff file under Windows XP.
!!}
    property EXIF_XPComment:WideString read fEXIF_XPComment write fEXIF_XPComment;

{!!
<FS>TIOParamsVals.EXIF_XPAuthor

<FM>Declaration<FC>
property EXIF_XPAuthor:WideString;

<FM>Description<FN>
Specifies Windows XP image author. This is shown in properties of jpeg/tiff file under Windows XP.
!!}
    property EXIF_XPAuthor:WideString read fEXIF_XPAuthor write fEXIF_XPAuthor;

{!!
<FS>TIOParamsVals.EXIF_XPKeywords

<FM>Declaration<FC>
property EXIF_XPKeywords:WideString;

<FM>Description<FN>
Specifies Windows XP image keywords. This is shown in properties of jpeg/tiff file under Windows XP.
!!}
    property EXIF_XPKeywords:WideString read fEXIF_XPKeywords write fEXIF_XPKeywords;

{!!
<FS>TIOParamsVals.EXIF_XPSubject

<FM>Declaration<FC>
property EXIF_XPSubject:WideString;

<FM>Description<FN>
Specifies Windows XP image subject. This is shown in properties of jpeg/tiff file under Windows XP.
!!}
    property EXIF_XPSubject:WideString read fEXIF_XPSubject write fEXIF_XPSubject;

{!!
<FS>TIOParamsVals.EXIF_ExposureMode

<FM>Declaration<FC>
property EXIF_ExposureMode:integer;

<FM>Description<FN>
This tag indicates the exposure mode set when the image was shot. In auto-bracketing mode, the camera shoots a series of frames of the same scene at different exposure settings.
0 = Auto exposure
1 = Manual exposure
2 = Auto bracket
!!}
    property EXIF_ExposureMode:integer read fEXIF_ExposureMode write fEXIF_ExposureMode;

{!!
<FS>TIOParamsVals.EXIF_WhiteBalance

<FM>Declaration<FC>
property EXIF_WhiteBalance:integer;

<FM>Description<FN>
This tag indicates the white balance mode set when the image was shot.
0 = Auto white balance
1 = Manual white balance
!!}
    property EXIF_WhiteBalance:integer read fEXIF_WhiteBalance write fEXIF_WhiteBalance;

{!!
<FS>TIOParamsVals.EXIF_DigitalZoomRatio

<FM>Declaration<FC>
property EXIF_DigitalZoomRatio:double;

<FM>Description<FN>
This tag indicates the digital zoom ratio when the image was shot. If the numerator of the recorded value is 0, this indicates that digital zoom was not used.
!!}
    property EXIF_DigitalZoomRatio:double read fEXIF_DigitalZoomRatio write fEXIF_DigitalZoomRatio;

{!!
<FS>TIOParamsVals.EXIF_FocalLengthIn35mmFilm

<FM>Declaration<FC>
property EXIF_FocalLengthIn35mmFilm:integer;

<FM>Description<FN>
This tag indicates the equivalent focal length assuming a 35mm film camera, in mm. A value of 0 means the focal length is unknown. Note that this tag differs from the FocalLength tag.
!!}
    property EXIF_FocalLengthIn35mmFilm:integer read fEXIF_FocalLengthIn35mmFilm write fEXIF_FocalLengthIn35mmFilm;

{!!
<FS>TIOParamsVals.EXIF_SceneCaptureType

<FM>Declaration<FC>
property EXIF_SceneCaptureType:integer;

<FM>Description<FN>
This tag indicates the type of scene that was shot. It can also be used to record the mode in which the image was shot. Note that this differs from the scene type (SceneType) tag.
0 = Standard
1 = Landscape
2 = Portrait
3 = Night scene
!!}
    property EXIF_SceneCaptureType:integer read fEXIF_SceneCaptureType write fEXIF_SceneCaptureType;

{!!
<FS>TIOParamsVals.EXIF_GainControl

<FM>Declaration<FC>
property EXIF_GainControl:integer;

<FM>Description<FN>
This tag indicates the degree of overall image gain adjustment.
0 = None
1 = Low gain up
2 = High gain up
3 = Low gain down
4 = High gain down
!!}
    property EXIF_GainControl:integer read fEXIF_GainControl write fEXIF_GainControl;

{!!
<FS>TIOParamsVals.EXIF_Contrast

<FM>Declaration<FC>
property EXIF_Contrast:integer;

<FM>Description<FN>
This tag indicates the direction of contrast processing applied by the camera when the image was shot.
0 = Normal
1 = Soft
2 = Hard
!!}
    property EXIF_Contrast:integer read fEXIF_Contrast write fEXIF_Contrast;

{!!
<FS>TIOParamsVals.EXIF_Saturation

<FM>Declaration<FC>
property EXIF_Saturation:integer;

<FM>Description<FN>
This tag indicates the direction of saturation processing applied by the camera when the image was shot.
0 = Normal
1 = Low saturation
2 = High saturation
!!}
    property EXIF_Saturation:integer read fEXIF_Saturation write fEXIF_Saturation;

{!!
<FS>TIOParamsVals.EXIF_Sharpness

<FM>Declaration<FC>
property EXIF_Sharpness:integer;

<FM>Description<FN>
This tag indicates the direction of sharpness processing applied by the camera when the image was shot.
0 = Normal
1 = Soft
2 = Hard
!!}
    property EXIF_Sharpness:integer read fEXIF_Sharpness write fEXIF_Sharpness;

{!!
<FS>TIOParamsVals.EXIF_SubjectDistanceRange

<FM>Declaration<FC>
property EXIF_SubjectDistanceRange:integer;

<FM>Description<FN>
This tag indicates the distance to the subject.
0 = unknown
1 = Macro
2 = Close view
3 = Distant view
!!}
    property EXIF_SubjectDistanceRange:integer read fEXIF_SubjectDistanceRange write fEXIF_SubjectDistanceRange;

{!!
<FS>TIOParamsVals.EXIF_ImageUniqueID

<FM>Declaration<FC>
property EXIF_ImageUniqueID:AnsiString;

<FM>Description<FN>
This tag indicates an identifier assigned uniquely to each image. It is recorded as an ASCII string equivalent to hexadecimal notation and 128-bit fixed length.
!!}
    property EXIF_ImageUniqueID:AnsiString read fEXIF_ImageUniqueID write fEXIF_ImageUniqueID;

{!!
<FS>TIOParamsVals.EXIF_GPSVersionID

<FM>Declaration<FC>
property EXIF_GPSVersionID:AnsiString;

<FM>Description<FN>
Indicates the version of GPSInfoIFD.
!!}
    property EXIF_GPSVersionID:AnsiString read fEXIF_GPSVersionID write fEXIF_GPSVersionID;

{!!
<FS>TIOParamsVals.EXIF_GPSLatitudeRef

<FM>Declaration<FC>
property EXIF_GPSLatitudeRef:AnsiString;

<FM>Description<FN>
Indicates whether the latitude is north or south latitude. The ASCII value 'N' indicates north latitude, and 'S' is south latitude.
!!}
    property EXIF_GPSLatitudeRef:AnsiString read fEXIF_GPSLatitudeRef write fEXIF_GPSLatitudeRef;

{!!
<FS>TIOParamsVals.EXIF_GPSLatitudeDegrees

<FM>Declaration<FC>
property EXIF_GPSLatitudeDegrees:double;

<FM>Description<FN>
Indicates the latitude degrees.
!!}
    property EXIF_GPSLatitudeDegrees:double read fEXIF_GPSLatitudeDegrees write fEXIF_GPSLatitudeDegrees;

{!!
<FS>TIOParamsVals.EXIF_GPSLatitudeMinutes

<FM>Declaration<FC>
property EXIF_GPSLatitudeMinutes:double;

<FM>Description<FN>
Indicates the latitude minutes.
!!}
    property EXIF_GPSLatitudeMinutes:double read fEXIF_GPSLatitudeMinutes write fEXIF_GPSLatitudeMinutes;

{!!
<FS>TIOParamsVals.EXIF_GPSLatitudeSeconds

<FM>Declaration<FC>
property EXIF_GPSLatitudeSeconds:double;

<FM>Description<FN>
Indicates the latitude seconds.
!!}
    property EXIF_GPSLatitudeSeconds:double read fEXIF_GPSLatitudeSeconds write fEXIF_GPSLatitudeSeconds;

{!!
<FS>TIOParamsVals.EXIF_GPSLongitudeRef

<FM>Declaration<FC>
property EXIF_GPSLongitudeRef:AnsiString;

<FM>Description<FN>
Indicates whether the longitude is east or west longitude. ASCII 'E' indicates east longitude, and 'W' is west longitude.
!!}
    property EXIF_GPSLongitudeRef:AnsiString read fEXIF_GPSLongitudeRef write fEXIF_GPSLongitudeRef;

{!!
<FS>TIOParamsVals.EXIF_GPSLongitudeDegrees

<FM>Declaration<FC>
property EXIF_GPSLongitudeDegrees:double;

<FM>Description<FN>
Indicates the longitude degrees.
!!}
    property EXIF_GPSLongitudeDegrees:double read fEXIF_GPSLongitudeDegrees write fEXIF_GPSLongitudeDegrees;

{!!
<FS>TIOParamsVals.EXIF_GPSLongitudeMinutes

<FM>Declaration<FC>
property EXIF_GPSLongitudeMinutes:double;

<FM>Description<FN>
Indicates the longitude minutes.
!!}
    property EXIF_GPSLongitudeMinutes:double read fEXIF_GPSLongitudeMinutes write fEXIF_GPSLongitudeMinutes;

{!!
<FS>TIOParamsVals.EXIF_GPSLongitudeSeconds

<FM>Declaration<FC>
property EXIF_GPSLongitudeSeconds:double;

<FM>Description<FN>
Indicates the longitude seconds.
!!}
    property EXIF_GPSLongitudeSeconds:double read fEXIF_GPSLongitudeSeconds write fEXIF_GPSLongitudeSeconds;

{!!
<FS>TIOParamsVals.EXIF_GPSAltitudeRef

<FM>Declaration<FC>
property EXIF_GPSAltitudeRef:AnsiString;

<FM>Description<FN>
Indicates the altitude used as the reference altitude. If the reference is sea level and the altitude is above sea level, '0' is given.
If the altitude is below sea level, a value of '1' is given and the altitude is indicated as an absolute value in the <A TIOParamsVals.EXIF_GPSAltitude> tag.
The reference unit is meters.
!!}
    property EXIF_GPSAltitudeRef:AnsiString read fEXIF_GPSAltitudeRef write fEXIF_GPSAltitudeRef;

{!!
<FS>TIOParamsVals.EXIF_GPSAltitude

<FM>Declaration<FC>
property EXIF_GPSAltitude:double;

<FM>Description<FN>
Indicates the altitude based on the reference in GPSAltitudeRef. The reference unit is meters.
!!}
    property EXIF_GPSAltitude:double read fEXIF_GPSAltitude write fEXIF_GPSAltitude;

{!!
<FS>TIOParamsVals.EXIF_GPSTimeStampHour

<FM>Declaration<FC>
property EXIF_GPSTimeStampHour:double;

<FM>Description<FN>
Indicates the time as UTC (Coordinated Universal Time).
!!}
    property EXIF_GPSTimeStampHour:double read fEXIF_GPSTimeStampHour write fEXIF_GPSTimeStampHour;

{!!
<FS>TIOParamsVals.EXIF_GPSTimeStampMinute

<FM>Declaration<FC>
property EXIF_GPSTimeStampMinute:double;

<FM>Description<FN>
Indicates the time as UTC (Coordinated Universal Time).
!!}
    property EXIF_GPSTimeStampMinute:double read fEXIF_GPSTimeStampMinute write fEXIF_GPSTimeStampMinute;

{!!
<FS>TIOParamsVals.EXIF_GPSTimeStampSecond

<FM>Declaration<FC>
property EXIF_GPSTimeStampSecond:double;

<FM>Description<FN>
Indicates the time as UTC (Coordinated Universal Time).
!!}
    property EXIF_GPSTimeStampSecond:double read fEXIF_GPSTimeStampSecond write fEXIF_GPSTimeStampSecond;

{!!
<FS>TIOParamsVals.EXIF_GPSSatellites

<FM>Declaration<FC>
property EXIF_GPSSatellites:AnsiString

<FM>Description<FN>
Indicates the GPS satellites used for measurements. This tag can be used to describe the number of satellites, their ID number, angle of elevation, azimuth, SNR and other information in ASCII notation. The format is not specified.
!!}
    property EXIF_GPSSatellites:AnsiString read fEXIF_GPSSatellites write fEXIF_GPSSatellites;

{!!
<FS>TIOParamsVals.EXIF_GPSStatus

<FM>Declaration<FC>
property EXIF_GPSStatus:AnsiString;

<FM>Description<FN>
Indicates the status of the GPS receiver when the image is recorded. 'A' means measurement is in progress, and 'V' means the measurement is Interoperability.
!!}
    property EXIF_GPSStatus:AnsiString read fEXIF_GPSStatus write fEXIF_GPSStatus;

{!!
<FS>TIOParamsVals.EXIF_GPSMeasureMode

<FM>Declaration<FC>
property EXIF_GPSMeasureMode:AnsiString;

<FM>Description<FN>
Indicates the GPS measurement mode. '2' means two-dimensional measurement and '3' means three-dimensional measurement is in progress.
!!}
    property EXIF_GPSMeasureMode:AnsiString read fEXIF_GPSMeasureMode write fEXIF_GPSMeasureMode;

{!!
<FS>TIOParamsVals.EXIF_GPSDOP

<FM>Declaration<FC>
property EXIF_GPSDOP:double;

<FM>Description<FN>
Indicates the GPS DOP (data degree of precision). An HDOP value is written during two-dimensional measurement, and PDOP during three-dimensional measurement.
!!}
    property EXIF_GPSDOP:double read fEXIF_GPSDOP write fEXIF_GPSDOP;

{!!
<FS>TIOParamsVals.EXIF_GPSSpeedRef

<FM>Declaration<FC>
property EXIF_GPSSpeedRef:AnsiString;

<FM>Description<FN>
Indicates the unit used to express the GPS receiver speed of movement. 'K' 'M' and 'N' represents kilometers per hour, miles per hour, and knots.
!!}
    property EXIF_GPSSpeedRef:AnsiString read fEXIF_GPSSpeedRef write fEXIF_GPSSpeedRef;

{!!
<FS>TIOParamsVals.EXIF_GPSSpeed

<FM>Declaration<FC>
property EXIF_GPSSpeed:double;

<FM>Description<FN>
Indicates the speed of GPS receiver movement.
!!}
    property EXIF_GPSSpeed:double read fEXIF_GPSSpeed write fEXIF_GPSSpeed;

{!!
<FS>TIOParamsVals.EXIF_GPSTrackRef

<FM>Declaration<FC>
property EXIF_GPSTrackRef:AnsiString;

<FM>Description<FN>
Indicates the reference for giving the direction of GPS receiver movement. 'T' denotes true direction and 'M' is magnetic direction.
!!}
    property EXIF_GPSTrackRef:AnsiString read fEXIF_GPSTrackRef write fEXIF_GPSTrackRef;

{!!
<FS>TIOParamsVals.EXIF_GPSTrack

<FM>Declaration<FC>
property EXIF_GPSTrack:double;

<FM>Description<FN>
Indicates the direction of GPS receiver movement. The range of values is from 0.00 to 359.99.
!!}
    property EXIF_GPSTrack:double read fEXIF_GPSTrack write fEXIF_GPSTrack;

{!!
<FS>TIOParamsVals.EXIF_GPSImgDirectionRef

<FM>Declaration<FC>
property EXIF_GPSImgDirectionRef:AnsiString;

<FM>Description<FN>
Indicates the reference for giving the direction of the image when it is captured. 'T' denotes true direction and 'M' is magnetic direction.
!!}
    property EXIF_GPSImgDirectionRef:AnsiString read fEXIF_GPSImgDirectionRef write fEXIF_GPSImgDirectionRef;

{!!
<FS>TIOParamsVals.EXIF_GPSImgDirection

<FM>Declaration<FC>
property EXIF_GPSImgDirection:double;

<FM>Description<FN>
Indicates the direction of the image when it was captured. The range of values is from 0.00 to 359.99.
!!}
    property EXIF_GPSImgDirection:double read fEXIF_GPSImgDirection write fEXIF_GPSImgDirection;

{!!
<FS>TIOParamsVals.EXIF_GPSMapDatum

<FM>Declaration<FC>
property EXIF_GPSMapDatum:AnsiString;

<FM>Description<FN>
Indicates the geodetic survey data used by the GPS receiver. If the survey data is restricted to Japan, the value of this tag is 'TOKYO' or 'WGS-84'.
!!}
    property EXIF_GPSMapDatum:AnsiString read fEXIF_GPSMapDatum write fEXIF_GPSMapDatum;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLatitudeRef

<FM>Declaration<FC>
property EXIF_GPSDestLatitudeRef:AnsiString;

<FM>Description<FN>
Indicates whether the latitude of the destination point is north or south latitude. The ASCII value 'N' indicates north latitude, and 'S' is south latitude.
!!}
    property EXIF_GPSDestLatitudeRef:AnsiString read fEXIF_GPSDestLatitudeRef write fEXIF_GPSDestLatitudeRef;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLatitudeDegrees

<FM>Declaration<FC>
property EXIF_GPSDestLatitudeDegrees:double;

<FM>Description<FN>
Indicates the latitude degrees of the destination point.
!!}
    property EXIF_GPSDestLatitudeDegrees:double read fEXIF_GPSDestLatitudeDegrees write fEXIF_GPSDestLatitudeDegrees;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLatitudeMinutes

<FM>Declaration<FC>
property EXIF_GPSDestLatitudeMinutes:double;

<FM>Description<FN>
Indicates the latitude minutes of the destination point.
!!}
    property EXIF_GPSDestLatitudeMinutes:double read fEXIF_GPSDestLatitudeMinutes write fEXIF_GPSDestLatitudeMinutes;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLatitudeSeconds

<FM>Declaration<FC>
property EXIF_GPSDestLatitudeSeconds:double;

<FM>Description<FN>
Indicates the latitude seconds of the destination point.
!!}
    property EXIF_GPSDestLatitudeSeconds:double read fEXIF_GPSDestLatitudeSeconds write fEXIF_GPSDestLatitudeSeconds;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLongitudeRef

<FM>Declaration<FC>
property EXIF_GPSDestLongitudeRef:AnsiString;

<FM>Description<FN>
Indicates whether the longitude of the destination point is east or west longitude. ASCII 'E' indicates east longitude, and 'W' is west longitude.
!!}
    property EXIF_GPSDestLongitudeRef:AnsiString read fEXIF_GPSDestLongitudeRef write fEXIF_GPSDestLatitudeRef;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLongitudeDegrees

<FM>Declaration<FC>
property EXIF_GPSDestLongitudeDegrees:double;

<FM>Description<FN>
Indicates the longitude degrees of the destination point.
!!}
    property EXIF_GPSDestLongitudeDegrees:double read fEXIF_GPSDestLongitudeDegrees write fEXIF_GPSDestLongitudeDegrees;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLongitudeMinutes

<FM>Declaration<FC>
property EXIF_GPSDestLongitudeMinutes:double;

<FM>Description<FN>
Indicates the longitude minutes of the destination point.
!!}
    property EXIF_GPSDestLongitudeMinutes:double read fEXIF_GPSDestLongitudeMinutes write fEXIF_GPSDestLongitudeMinutes;

{!!
<FS>TIOParamsVals.EXIF_GPSDestLongitudeSeconds

<FM>Declaration<FC>
property EXIF_GPSDestLongitudeSeconds:double;

<FM>Description<FN>
Indicates the longitude seconds of the destination point.
!!}
    property EXIF_GPSDestLongitudeSeconds:double read fEXIF_GPSDestLongitudeSeconds write fEXIF_GPSDestLongitudeSeconds;

{!!
<FS>TIOParamsVals.EXIF_GPSDestBearingRef

<FM>Declaration<FC>
property EXIF_GPSDestBearingRef:AnsiString;

<FM>Description<FN>
Indicates the reference used for giving the bearing to the destination point. 'T' denotes true direction and 'M' is magnetic direction.
!!}
    property EXIF_GPSDestBearingRef:AnsiString read fEXIF_GPSDestBearingRef write fEXIF_GPSDestBearingRef;

{!!
<FS>TIOParamsVals.EXIF_GPSDestBearing

<FM>Declaration<FC>
property EXIF_GPSDestBearing:double;

<FM>Description<FN>
Indicates the bearing to the destination point. The range of values is from 0.00 to 359.99.
!!}
    property EXIF_GPSDestBearing:double read fEXIF_GPSDestBearing write fEXIF_GPSDestBearing;

{!!
<FS>TIOParamsVals.EXIF_GPSDestDistanceRef

<FM>Declaration<FC>
property EXIF_GPSDestDistanceRef:AnsiString;

<FM>Description<FN>
Indicates the unit used to express the distance to the destination point. 'K', 'M' and 'N' represent kilometers, miles and knots.
!!}
    property EXIF_GPSDestDistanceRef:AnsiString read fEXIF_GPSDestDistanceRef write fEXIF_GPSDestDistanceRef;

{!!
<FS>TIOParamsVals.EXIF_GPSDestDistance

<FM>Declaration<FC>
property EXIF_GPSDestDistance:double;

<FM>Description<FN>
Distance to destination.
!!}
    property EXIF_GPSDestDistance:double read fEXIF_GPSDestDistance write fEXIF_GPSDestDistance;

{!!
<FS>TIOParamsVals.EXIF_GPSDateStamp

<FM>Declaration<FC>
property EXIF_GPSDateStamp:AnsiString;

<FM>Description<FN>
GPS date.
!!}
    property EXIF_GPSDateStamp:AnsiString read fEXIF_GPSDateStamp write fEXIF_GPSDateStamp;

    //// XMP ////

{!!
<FS>TIOParamsVals.XMP_Info

<FM>Declaration<FC>
property XMP_Info:AnsiString;

<FM>Description<FN>
Returns Adobe XMP info loaded from Jpeg, TIFF and PSD file formats. Adobe XMP is a XML coded string according to Adobe XMP specification updated to January 2004. ImageEn doesn't parse the XMP-XML string, so to read single tags you have to write code to parse the XML string.

XMP_Info is also saved back to Jpeg, TIFF and PSD file formats.
!!}
    property XMP_Info:AnsiString read fXMP_Info write fXMP_Info;

    // RAW Cameras
    {$ifdef IEINCLUDERAWFORMATS}

{!!
<FS>TIOParamsVals.RAW_HalfSize

<FM>Declaration<FC>
property RAW_HalfSize:boolean;

<FM>Description<FN>

If true specifies that we want load the RAW in half size. You can set this property to speed-up loading.
The default is False.

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_HalfSize:=True;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_HalfSize:boolean read fRAW_HalfSize write fRAW_HalfSize;

{!!
<FS>TIOParamsVals.RAW_Gamma

<FM>Declaration<FC>
property RAW_Gamma:double;

<FM>Description<FN>

This property specifies the gamma used when loading the RAW.
Default 0.6.

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_Gamma:=1;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_Gamma:double read fRAW_Gamma write fRAW_Gamma;

{!!
<FS>TIOParamsVals.RAW_Bright

<FM>Declaration<FC>
property RAW_Bright:double

<FM>Description<FN>

This property specifies the brightness value used when loading the RAW.
Default 1.0.

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_Bright:=1.5;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_Bright:double read fRAW_Bright write fRAW_Bright;

{!!
<FS>TIOParamsVals.RAW_RedScale

<FM>Declaration<FC>
property RAW_RedScale:double

<FM>Description<FN>

This property specifies the red multiplier used when loading the RAW.
Default 1.0 (daylight).

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_RedScale:=0.8;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_RedScale:double read fRAW_RedScale write fRAW_RedScale;

{!!
<FS>TIOParamsVals.RAW_BlueScale

<FM>Declaration<FC>
property RAW_BlueScale:double

<FM>Description<FN>

This property specifies the blue multiplier used when loading the RAW.
Default 1.0 (daylight).

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_BlueScale:=0.8;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_BlueScale:double read fRAW_BlueScale write fRAW_BlueScale;

{!!
<FS>TIOParamsVals.RAW_QuickInterpolate

<FM>Declaration<FC>
property RAW_QuickInterpolate:boolean;

<FM>Description<FN>

If True uses quick, low-quality color interpolation. Default True.

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_QuickInterpolate:=false;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_QuickInterpolate:boolean read fRAW_QuickInterpolate write fRAW_QuickInterpolate;

{!!
<FS>TIOParamsVals.RAW_UseAutoWB

<FM>Declaration<FC>
property RAW_UseAutoWB:boolean;

<FM>Description<FN>

If True uses automatic white balance. Default False.

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_UseAutoWB:=true;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_UseAutoWB:boolean read fRAW_UseAutoWB write fRAW_UseAutoWB;

{!!
<FS>TIOParamsVals.RAW_ExtraParams

<FM>Declaration<FC>
property RAW_ExtraParams:AnsiString;

<FM>Description<FN>

Specifies extra parameters for external raw plugins (dcraw).

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_ExtraParams:='-H 0 -j';
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_ExtraParams:AnsiString read fRAW_ExtraParams write fRAW_ExtraParams;

{!!
<FS>TIOParamsVals.RAW_UseCameraWB

<FM>Declaration<FC>
property RAW_UseCameraWB:boolean

<FM>Description<FN>

If True uses camera white balance, if possible. Default False.

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_UseCameraWB:=true;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_UseCameraWB:boolean read fRAW_UseCameraWB write fRAW_UseCameraWB;

{!!
<FS>TIOParamsVals.RAW_FourColorRGB

<FM>Declaration<FC>
property RAW_FourColorRGB:boolean

<FM>Description<FN>

If True interpolates RGBG as four colors. Default False.

<FM>Example<FC>

ImageEnView1.IO.Params.RAW_FourColorRGB:=true;
ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
!!}
    property RAW_FourColorRGB:boolean read fRAW_FourColorRGB write fRAW_FourColorRGB;

{!!
<FS>TIOParamsVals.RAW_Camera

<FM>Declaration<FC>
property RAW_Camera:AnsiString;

<FM>Description<FN>

Returns the camera descriptor.

<FM>Example<FC>

ImageEnView1.IO.LoadFromFile('CRW_0001.CRW');
Cameraname := ImageEnView1.IO.Params.RAW_Camera;
!!}
    property RAW_Camera:AnsiString read fRAW_Camera write fRAW_Camera;

{!!
<FS>TIOParamsVals.RAW_GetExifThumbnail

<FM>Declaration<FC>
property RAW_GetExifThumbnail:boolean;

<FM>Description<FN>
Setting this property to True means that you want a thumbnail instead of the full image. This works only if a thumbnail is present in EXIF fields.

<FM>Example<FC>

// I wants only the thumbnail
ImageEnView1.IO.Params.RAW_GetExifThumbnail:=True;
ImageEnView1.IO.LoadFromFile('input.crw');
!!}
    property RAW_GetExifThumbnail:boolean read fRAW_GetExifThumbnail write SetRAW_GetExifThumbnail;

{!!
<FS>TIOParamsVals.RAW_AutoAdjustColors

<FM>Declaration<FC>
property RAW_AutoAdjustColors:boolean;

<FM>Description<FN>
If True ImageEn applies an algorithm to adjust image colors.
This works only when the RAW file contains an EXIF thumbnails with correct colors, because ImageEn gets right colors from the thumbnail.

<FM>Example<FC>

ImageEnView.IO.Params.RAW_AutoAdjustColors:=True;
ImageEnView.IO.LoadFromFile('input.crw');

!!}
    property RAW_AutoAdjustColors:boolean read fRAW_AutoAdjustColors write fRAW_AutoAdjustColors;

    {$endif}

    // Real RAWs

{!!
<FS>TIOParamsVals.BMPRAW_ChannelOrder

<FM>Declaration<FC>
property BMPRAW_ChannelOrder:<A TIOBMPRAWChannelOrder>;

<FM>Description<FN>
Specifies the channels order for a RAW file. It can be coRGB or coBGR and it is valid only for color images.

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Examples<FC>

// load a RAW image, RGB, interleaved, 8 bit aligned, 1024x768
ImageEnView1.LegacyBitmap:=false;
ImageEnView1.IEBitmap.Allocate(1024,768,ie24RGB);
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plInterleaved;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.Params.BMPRAW_HeaderSize:=0;
ImageEnView1.IO.LoadFromFileBMPRAW('input.dat');

// load a RAW image, CMYK, interleaved, 8 bit aligned, 1024x768
ImageEnView1.LegacyBitmap:=false;
ImageEnView1.IEBitmap.Allocate(1024,768,ieCMYK);
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plInterleaved;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.Params.BMPRAW_HeaderSize:=0;
ImageEnView1.IO.LoadFromFileBMPRAW('input.dat');

// saves current image as RAW image
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plPlanar;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.SaveToFileBMPRAW('output.dat');
!!}
    property BMPRAW_ChannelOrder:TIOBMPRAWChannelOrder read fBMPRAW_ChannelOrder write fBMPRAW_ChannelOrder;

{!!
<FS>TIOParamsVals.BMPRAW_Planes

<FM>Declaration<FC>
property BMPRAW_Planes:<A TIOBMPRAWPlanes>;

<FM>Description<FN>
Specifies how channels are disposed.

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Example<FC>
<L TIOParamsVals.BMPRAW_ChannelOrder>Look here</L>
!!}
    property BMPRAW_Planes:TIOBMPRAWPlanes read fBMPRAW_Planes write fBMPRAW_Planes;

{!!
<FS>TIOParamsVals.BMPRAW_RowAlign

<FM>Declaration<FC>
property BMPRAW_RowAlign:integer;

<FM>Description<FN>
Specifies the row align in bits.

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Example<FC>
<L TIOParamsVals.BMPRAW_ChannelOrder>Look here</L>
!!}
    property BMPRAW_RowAlign:integer read fBMPRAW_RowAlign write fBMPRAW_RowAlign;

{!!
<FS>TIOParamsVals.BMPRAW_HeaderSize

<FM>Declaration<FC>
property BMPRAW_HeaderSize:integer;

<FM>Description<FN>
Specifies the header size in bytes. The header will be bypassed.

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Example<FC>
<L TIOParamsVals.BMPRAW_ChannelOrder>Look here</L>
!!}
    property BMPRAW_HeaderSize:integer read fBMPRAW_HeaderSize write fBMPRAW_HeaderSize;

{!!
<FS>TIOParamsVals.BMPRAW_DataFormat

<FM>Declaration<FC>
property BMPRAW_DataFormat:<A TIOBMPRAWDataFormat>;

<FM>Description<FN>
Specifies the next input/output data format.
ASCII text values must be separated by one o more non-alpha characters (#13, #10, #32...).

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Examples<FC>

// load a RAW image, 16 bit gray scale, ascii-text
ImageEnView1.LegacyBitmap := false;
ImageEnView1.IEBitmap.Allocate(1024, 768, ie16g);
ImageEnView1.IO.Params.BMPRAW_RowAlign := 8;
ImageEnView1.IO.Params.BMPRAW_HeaderSize := 0;
ImageEnView1.IO.Params.BMPRAW_DataFormat := dfTextDecimal;
ImageEnView1.IO.LoadFromFileBMPRAW('input.dat');
!!}
    property BMPRAW_DataFormat:TIOBMPRAWDataFormat read fBMPRAW_DataFormat write fBMPRAW_DataFormat;


    /////
    constructor Create(IEIO: TImageEnIO);
    destructor Destroy; override;
    procedure SetDefaultParams;
    procedure Assign(Source: TIOParamsVals);
    procedure AssignCompressionInfo(Source: TIOParamsVals);
    procedure SaveToFile(const FileName: WideString);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromFile(const FileName: WideString);
    procedure LoadFromStream(Stream: TStream);
    property ImageEnIO: TImageEnIO read fImageEnIO;
    procedure ResetInfo;
    procedure ResetEXIF;
    function GetProperty(const Prop: WideString): WideString;
    procedure SetProperty(Prop, Value: WideString);
    procedure UpdateEXIFThumbnail;
    procedure FreeColorMap;
  end;





{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TIEDRect

<FM>Declaration<FC>
}
  TIEDRect = record
    Left: double;
    Top: double;
    Right: double;
    Bottom: double;
  end;
{!!}


{!!
<FS>TIETWFilter

<FM>Declaration<FC>
TIETWFilter = (ietwUndefined, ietwRed, ietwGreen, ietwBlue, ietwNone, ietwWhite, ietwCyan, ietwMagenta, ietwYellow, ietwBlack);

<FM>Note<FN>
ietwUndefined unset this property, while ietwNone set "none" value.
!!}
  //
  TIETWFilter = (ietwUndefined, ietwRed, ietwGreen, ietwBlue, ietwNone, ietwWhite, ietwCyan, ietwMagenta, ietwYellow, ietwBlack);

  // capabilities of the TWain source
  TIETWSourceCaps = record
    fXResolution: TIEDoubleList;    // X Resolution
    fYResolution: TIEDoubleList;    // Y Resolution
    fXScaling: TIEDoubleList;       // X Scaling
    fYScaling: TIEDoubleList;       // Y Scaling
    fPixelType: TIEIntegerList;     // Pixel type [ 0 : Black & white (1 bit)
                                    //              1 : Gray scale (8 bit)
                                    //              2 : full RGB (24 bit or 48 bit)
                                    //              3 : palette (ImageEn can't support this)
                                    //              4 : CMY (ImageEn can't support this)
                                    //              5 : CMYK (ImageEn can't support this)
                                    //              6 : YUV (ImageEn can't support this)
                                    //              7 : YUVK (ImageEn can't support this)
                                    //              8 : CIEXYZ (ImageEn can't support this) ]
    fBitDepth: TIEIntegerList;      // Bit Depth [ 1...]
    fGamma: double;                 // Gamma
    fPhysicalHeight: double;        // Physical Height
    fPhysicalWidth: double;         // Physical Width
    fFeederEnabled: boolean;        // FeederEnabled
    fOrientation: TIEIntegerList;   // Orientation
    fIndicators: boolean;           // Progress Indicators
    fAcquireFrame: TIEDRect;        // image layout (this isn't a capability...)
    fBufferedTransfer: boolean;     // image transfer method (default is buffered(true))
    fUseMemoryHandle:boolean;       // use Memory Handle instead of memory pointer to transfer images
    fFileTransfer: boolean;         // image transfer by File (if true overlap fBufferedTransfer), default false
    fDuplexEnabled: boolean;        // Duplex
    fAcquireFrameEnabled: boolean;  // make active fAcquireFrame
    fFeederLoaded: boolean;         // Feeder loaded
    fDuplexSupported: boolean;      // Duplex supported
    fPaperDetectable: boolean;      // Paper detectable
    fContrast: TIEDoubleList;       // Contrast
    fBrightness: TIEDoubleList;     // Brightness
    fThreshold: TIEDoubleList;      // Threshold
    fRotation: TIEDoubleList;       // Rotation
    fUndefinedImageSize: boolean;   // undefined image size
    fStandardSize: TIEIntegerList;  // SupportedSizes
    fAutoFeed: boolean;             // enable/disable Autofeed
    fAutoDeskew:boolean;            // enable/disable ICAP_AUTOMATICDESKEW
    fAutoBorderDetection:boolean;   // enable/disable ICAP_AUTOMATICBORDERDETECTION
    fAutoBright:boolean;            // enable/disable ICAP_AUTOBRIGHT
    fAutoRotate:boolean;            // enable/disable ICAP_AUTOMATICROTATE
    fAutoDiscardBlankPages:integer; // enable/disable/set ICAP_AUTODISCARDBLANKPAGES
    fFilter:TIETWFilter;            // set filter
    fHighlight:double;              // ICAP_HIGHLIGHT (-1 = default)
    fShadow:double;                 // ICAP_SHADOW (-1 = default)
  end;

  // structure for parameters passed to imscan function
  TIETWainShared = record
    hDSMLib: THANDLE;
    DSM_Entry: TDSMEntryProc;
    hproxy: HWND;
  end;
  PIETWainShared = ^TIETWainShared;

{!!
<FS>TIETWainParams

<FM>Description<FN>
The TIETWainParams object contains many properties and methods to control TWain scanners without using the default dialog.

<FM>Methods and Properties<FN>

  <FM>TWain communication handling<FN>

  <A TIETWainParams.Assign>
  <A TIETWainParams.Create>
  <A TIETWainParams.FreeResources>
  <A TIETWainParams.GetDefaultSource>
  <A TIETWainParams.GetFromScanner>
  <A TIETWainParams.SelectSourceByName>
  <A TIETWainParams.SetDefaultParams>
  <A TIETWainParams.Update>

  <FM>TWain properties<FN>

  <A TIETWainParams.AcquireFrameBottom>
  <A TIETWainParams.AcquireFrameEnabled>
  <A TIETWainParams.AcquireFrameLeft>
  <A TIETWainParams.AcquireFrameRight>
  <A TIETWainParams.AcquireFrameTop>
  <A TIETWainParams.AppManufacturer>
  <A TIETWainParams.AppProductFamily>
  <A TIETWainParams.AppProductName>
  <A TIETWainParams.AppVersionInfo>
  <A TIETWainParams.AutoBorderDetection>
  <A TIETWainParams.AutoBright>
  <A TIETWainParams.AutoDeskew>
  <A TIETWainParams.AutoDiscardBlankPages>
  <A TIETWainParams.AutoFeed>
  <A TIETWainParams.AutoRotate>
  <A TIETWainParams.BitDepth>
  <A TIETWainParams.Brightness>
  <A TIETWainParams.BufferedTransfer>
  <A TIETWainParams.CapabilitiesValid>
  <A TIETWainParams.CompatibilityMode>
  <A TIETWainParams.Contrast>
  <A TIETWainParams.Country>
  <A TIETWainParams.DuplexEnabled>
  <A TIETWainParams.DuplexSupported>
  <A TIETWainParams.FeederEnabled>
  <A TIETWainParams.FeederLoaded>
  <A TIETWainParams.FileTransfer>
  <A TIETWainParams.Filter>
  <A TIETWainParams.Gamma>
  <A TIETWainParams.Highlight>
  <A TIETWainParams.Language>
  <A TIETWainParams.LastErrorStr>
  <A TIETWainParams.LastError>
  <A TIETWainParams.LogFile>
  <A TIETWainParams.Orientation>
  <A TIETWainParams.PaperDetectable>
  <A TIETWainParams.PhysicalHeight>
  <A TIETWainParams.PhysicalWidth>
  <A TIETWainParams.PixelType>
  <A TIETWainParams.ProgressIndicators>
  <A TIETWainParams.Rotation>
  <A TIETWainParams.SelectedSource>
  <A TIETWainParams.Shadow>
  <A TIETWainParams.ShowSettingsOnly>
  <A TIETWainParams.SourceCount>
  <A TIETWainParams.SourceName>
  <A TIETWainParams.StandardSize>
  <A TIETWainParams.Threshold>
  <A TIETWainParams.UndefinedImageSize>
  <A TIETWainParams.UseMemoryHandle>
  <A TIETWainParams.VisibleDialog>
  <A TIETWainParams.XResolution>
  <A TIETWainParams.XScaling>
  <A TIETWainParams.YResolution>
  <A TIETWainParams.YScaling>
!!}
  TIETWainParams = class
  private
    fOwner: TComponent;
    fVisibleDialog: boolean;
    fShowSettingsOnly: boolean;     // only settings will be visible (use MSG_ENABLEDSUIONLY instead of MSG_ENABLEDS)
    fSourceListData: TList;
    fSelectedSource: integer;       // index of fSourceListData
    fSourceListDataValid: boolean;  // false to get capabilities
    fCapabilitiesValid: boolean;    // false to get capabilities
    fCapabilities: TIETWSourceCaps; // filled by imscan
    fAppVersionInfo: AnsiString;
    fAppManufacturer: AnsiString;
    fAppProductFamily: AnsiString;
    fAppProductName: AnsiString;
    fCompatibilityMode: boolean;
    fLanguage:word;
    fCountry:word;
    fSourceSettings:TMemoryStream;
    procedure FillSourceListData;
    procedure FillCapabilities;
    function GetSourceName(idx: integer): AnsiString;
    function GetSourceCount: integer;
    function GetXResolution: TIEDoubleList;
    function GetYResolution: TIEDoubleList;
    function GetXScaling: TIEDoubleList;
    function GetYScaling: TIEDoubleList;
    function GetContrast: TIEDoubleList;
    function GetBrightness: TIEDoubleList;
    function GetThreshold: TIEDoubleList;
    function GetRotation: TIEDoubleList;
    function GetPixelType: TIEIntegerList;
    function GetBitDepth:TIEIntegerList;
    function GetGamma: double;
    function GetPhysicalHeight: double;
    function GetPhysicalWidth: double;
    function GetFeederEnabled: boolean;
    function GetAutoFeed: boolean;
    function GetAutoDeskew: boolean;
    function GetAutoBorderDetection: boolean;
    function GetAutoBright: boolean;
    function GetAutoRotate: boolean;
    function GetAutoDiscardBlankPages: integer;
    function GetFilter:TIETWFilter;
    function GetHighlight:double;
    function GetShadow:double;
    function GetUndefinedImageSize: boolean;
    function GetOrientation: TIEIntegerList;
    function GetStandardSize: TIEIntegerList;
    procedure SetSelectedSource(v: integer);
    function GetIndicators: boolean;
    procedure SetFeederEnabled(v: boolean);
    procedure SetAutoFeed(v: boolean);
    procedure SetAutoDeskew(v: boolean);
    procedure SetAutoBorderDetection(v: boolean);
    procedure SetAutoBright(v: boolean);
    procedure SetAutoRotate(v: boolean);
    procedure SetAutoDiscardBlankPages(v: integer);
    procedure SetFilter(v:TIETWFilter);
    procedure SetHighlight(v:double);
    procedure SetShadow(v:double);
    procedure SetUndefinedImageSize(v: boolean);
    procedure SetIndicators(v: boolean);
    function GetAcquireFrame(idx: integer): double;
    procedure SetAcquireFrame(idx: integer; v: double);
    function GetBufferedTransfer: boolean;
    procedure SetBufferedTransfer(v: boolean);
    function GetUseMemoryHandle:boolean;
    procedure SetUseMemoryHandle(v:boolean);
    function GetFileTransfer: boolean;
    procedure SetFileTransfer(v: boolean);
    procedure SetAppVersionInfo(v: AnsiString);
    procedure SetAppManufacturer(v: AnsiString);
    procedure SetAppProductFamily(v: AnsiString);
    procedure SetAppProductName(v: AnsiString);
    procedure SetDuplexEnabled(v: boolean);
    function GetDuplexEnabled: boolean;
    procedure SetAcquireFrameEnabled(v: boolean);
    function GetAcquireFrameEnabled: boolean;
    function GetFeederLoaded: boolean;
    function GetDuplexSupported: boolean;
    function GetPaperDetectable: boolean;
    procedure SetLogFile(v: string);
    function GetLogFile: string;
  public
    // reserved
    TWainShared: TIETWainShared;
    // General properties

{!!
<FS>TIETWainParams.LastError

<FM>Declaration<FC>
LastError:integer;

<FM>Description<FN>
LastError returns the last error which occurred on scanning.

Allowed values (defined in ietwain unit) are:

  TWCC_SUCCESS           =  0; // It worked!
  TWCC_BUMMER            =  1; // Failure due to unknown causes
  TWCC_LOWMEMORY         =  2; // Not enough memory to perform operation
  TWCC_NODS              =  3; // No Data Source
  TWCC_MAXCONNECTIONS    =  4; // DS is connected to max possible applications
  TWCC_OPERATIONERROR    =  5; // DS or DSM reported error, application shouldn't
  TWCC_BADCAP            =  6; // Unknown capability
  TWCC_BADPROTOCOL       =  9; // Unrecognized MSG DG DAT combination
  TWCC_BADVALUE          =  10; // Data parameter out of range
  TWCC_SEQERROR          =  11; // DG DAT MSG out of expected sequence
  TWCC_BADDEST           =  12; // Unknown destination Application/Source in DSM_Entry
  TWCC_CAPUNSUPPORTED    =  13; // Capability not supported by source
  TWCC_CAPBADOPERATION   =  14; // Operation not supported by capability
  TWCC_CAPSEQERROR       =  15; // Capability has dependancy on other capability
  TWCC_DENIED            =  16; // File System operation is denied (file is protected)
  TWCC_FILEEXISTS        =  17; // Operation failed because file already exists.
  TWCC_FILENOTFOUND      =  18; // File not found
  TWCC_NOTEMPTY          =  19; // Operation failed because directory is not empty
  TWCC_PAPERJAM          =  20; // The feeder is jammed
  TWCC_PAPERDOUBLEFEED   =  21; // The feeder detected multiple pages
  TWCC_FILEWRITEERROR    =  22; // Error writing the file (meant for things like disk full conditions)
  TWCC_CHECKDEVICEONLINE =  23; // The device went offline prior to or during this operation
!!}
    LastError: integer;

{!!
<FS>TIETWainParams.LastErrorStr

<FM>Declaration<FC>
LastErrorStr:AnsiString;

<FM>Description<FN>
LastErrorStr returns the last error which occurred on scanning as a string (see also LastError).
!!}
    LastErrorStr: AnsiString;

{!!
<FS>TIETWainParams.VisibleDialog

<FM>Declaration<FC>
property VisibleDialog: boolean;

<FM>Description<FN>
If VisibleDialog is True (default), the scanner user interface is enabled when Acquire method is called.

<FM>Example<FC>

ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;
!!}
    property VisibleDialog: boolean read fVisibleDialog write fVisibleDialog;

{!!
<FS>TIETWainParams.ShowSettingsOnly

<FM>Declaration<FC>
property ShowSettingsOnly: boolean;

<FM>Description<FN>
If ShowSettingsOnly is True the scanner driver will show settings dialog, without acquire the image.
You could use <A TIETWainParams.SourceSettings> to read scanner settings.

<FM>Demo<FN>
capture\twain store

<FM>Example<FC>

// first session: show scanner dialog only to set scanner settings
ImageEnView1.IO.TWainParams.ShowSettingsOnly := true;
ImageEnView1.IO.Acquire;
ImageEnView1.IO.TWainParams.SourceSettings.SaveToFile('mysettings.dat');

// another session: use saved settings
ImageEnView1.IO.TWainParams.ShowSettingsOnly := false;
ImageEnView1.IO.TWainParams.VisibleDialog := false;
ImageEnView1.IO.TWainParams.SourceSettings.LoadFromFile('mysettings.dat');
ImageEnView1.IO.Acquire;
!!}
    property ShowSettingsOnly: boolean read fShowSettingsOnly write fShowSettingsOnly;

{!!
<FS>TIETWainParams.SourceSettings

<FM>Declaration<FC>
property SourceSettings:TMemoryStream;

<FM>Description<FN>
SourceSettings contains custom TWain source settings.
This memory stream is filled when <A TIETWainParams.ShowSettingsOnly> is true and you call <A TImageEnIO.Acquire>.
You can also load it from file to provide already saved settings.

<FM>Demo<FN>
capture\twain store

<FM>Example<FC>

// first session: show scanner dialog only to set scanner settings
ImageEnView1.IO.TWainParams.ShowSettingsOnly := true;
ImageEnView1.IO.Acquire;
ImageEnView1.IO.TWainParams.SourceSettings.SaveToFile('mysettings.dat');

// another session: use saved settings
ImageEnView1.IO.TWainParams.ShowSettingsOnly := false;
ImageEnView1.IO.TWainParams.VisibleDialog := false;
ImageEnView1.IO.TWainParams.SourceSettings.LoadFromFile('mysettings.dat');
ImageEnView1.IO.Acquire;
!!}
    property SourceSettings:TMemoryStream read fSourceSettings;

    property SourceName[idx: integer]: AnsiString read GetSourceName;
    property SourceCount: integer read GetSourceCount;
    property SelectedSource: integer read fSelectedSource write SetSelectedSource;
    property LogFile: string read GetLogFile write SetLogFile;

{!!
<FS>TIETWainParams.CompatibilityMode

<FM>Declaration<FC>
property CompatibilityMode:boolean;

<FM>Description<FN>
CompatibilityMode disables capability setting and reading (some scanner may crash when you set/get capabilities).
Set this property to true only if you have problems with a specific scanner.
!!}
    property CompatibilityMode: boolean read fCompatibilityMode write fCompatibilityMode;

{!!
<FS>TIETWainParams.CapabilitiesValid

<FM>Declaration<FC>
property CapabilitiesValid:boolean;

<FM>Description<FN>
If true all properties are updated from scanner, otherwise not and you should call <A TIETWainParams.GetFromScanner> to update them.
!!}
    property CapabilitiesValid:boolean read fCapabilitiesValid;

{!!
<FS>TIETWainParams.Language

<FM>Declaration<FC>
property Language:word;

<FM>Description<FN>
Specifies the primary language for the scanner dialogs. Default is TWLG_USERLOCALE.
Look also <A TWain language constants>.
Versions before 3.0.3 have TWLG_USA for default.
!!}
    property Language:word read fLanguage write fLanguage;

{!!
<FS>TIETWainParams.Country

<FM>Declaration<FC>
property Country:word;

<FM>Description<FN>
Specifies the primary country where your application is intended to be distributed. Default is TWLG_USA.
Look also <A TWain country constants>.
!!}
    property Country:word read fCountry write fCountry;

    // Capabilities
    property XResolution: TIEDoubleList read GetXResolution;
    property YResolution: TIEDoubleList read GetYResolution;
    property XScaling: TIEDoubleList read GetXScaling;
    property YScaling: TIEDoubleList read GetYScaling;
    property PixelType: TIEIntegerList read GetPixelType;
    property BitDepth:TIEIntegerList read GetBitDepth;
    property Gamma: double read GetGamma; // readonly
    property PhysicalHeight: double read GetPhysicalHeight; // readonly
    property PhysicalWidth: double read GetPhysicalWidth; // readonly
    property FeederEnabled: boolean read GetFeederEnabled write SetFeederEnabled;
    property AutoFeed: boolean read GetAutoFeed write SetAutoFeed;
    property AutoDeskew: boolean read GetAutoDeskew write SetAutoDeskew;
    property AutoBorderDetection: boolean read GetAutoBorderDetection write SetAutoBorderDetection;
    property AutoBright: boolean read GetAutoBright write SetAutoBright;
    property AutoRotate: boolean read GetAutoRotate write SetAutoRotate;
    property AutoDiscardBlankPages: integer read GetAutoDiscardBlankPages write SetAutoDiscardBlankPages;
    property Filter: TIETWFilter read GetFilter write SetFilter;
    property Highlight: double read GetHighlight write SetHighlight;
    property Shadow: double read GetShadow write SetShadow;
    property FeederLoaded: boolean read GetFeederLoaded;
    property PaperDetectable: boolean read GetPaperDetectable;
    property Orientation: TIEIntegerList read GetOrientation;
    property ProgressIndicators: boolean read GetIndicators write SetIndicators;
    property AcquireFrameLeft: double index 0 read GetAcquireFrame write SetAcquireFrame;
    property AcquireFrameTop: double index 1 read GetAcquireFrame write SetAcquireFrame;
    property AcquireFrameRight: double index 2 read GetAcquireFrame write SetAcquireFrame;
    property AcquireFrameBottom: double index 3 read GetAcquireFrame write SetAcquireFrame;
    property BufferedTransfer: boolean read GetBufferedTransfer write SetBufferedTransfer;
    property UseMemoryHandle: boolean read GetUseMemoryHandle write SetUseMemoryHandle;
    property FileTransfer: boolean read GetFileTransfer write SetFileTransfer;
    property DuplexEnabled: boolean read GetDuplexEnabled write SetDuplexEnabled;
    property DuplexSupported: boolean read GetDuplexSupported;
    property AcquireFrameEnabled: boolean read GetAcquireFrameEnabled write SetAcquireFrameEnabled;
    property Contrast: TIEDoubleList read GetContrast;
    property Brightness: TIEDoubleList read GetBrightness;
    property Threshold: TIEDoubleList read GetThreshold;
    property Rotation: TIEDoubleList read GetRotation;
    property UndefinedImageSize: boolean read GetUndefinedImageSize write SetUndefinedImageSize;
    property StandardSize: TIEIntegerList read GetStandardSize;
    // Application identification
    property AppVersionInfo: AnsiString read fAppVersionInfo write SetAppVersionInfo;
    property AppManufacturer: AnsiString read fAppManufacturer write SetAppManufacturer;
    property AppProductFamily: AnsiString read fAppProductFamily write SetAppProductFamily;
    property AppProductName: AnsiString read fAppProductName write SetAppProductName;
    //
    constructor Create(Owner: TComponent);
    destructor Destroy; override;
    procedure SetDefaultParams;
    procedure Assign(Source: TIETWainParams);
    function SelectSourceByName(const sn: AnsiString): boolean;
    function GetDefaultSource: integer;
    procedure Update;
    procedure FreeResources;
    function GetFromScanner: boolean;
  end;
{$ENDIF}

{$IFDEF IEINCLUDESANE}

  TIESANEColorMode = (ieGray, ieColor);

  TIESANEParams = class
  private
    fOwner: TComponent;
    fSaneDevices: PPSANE_Device;
    fSaneOptionDescriptors: PSANE_Option_Descriptor;
    fSelectedSource: integer; // index of the selected device
    // options
    fBitDepth: integer;
    fColorMode: TIESANEColorMode;
    fXResolution, fYResolution: integer;
    //
    procedure FillSourceListData;
    function GetSourceName(idx: integer): AnsiString;
    function GetSourceFullName(idx: integer): AnsiString;
    function GetSourceCount: integer;
    procedure SetSelectedSource(v: integer);
    procedure SetResolution(Value: integer);
  public
    // General properties
    property SourceName[idx: integer]: AnsiString read GetSourceName;
    property SourceFullName[idx: integer]: AnsiString read GetSourceFullName;
    property SourceCount: integer read GetSourceCount;
    property SelectedSource: integer read fSelectedSource write SetSelectedSource;
    // Options
    property BitDepth: integer read fBitDepth write fBitDepth;
    property ColorMode: TIESANEColorMode read fColorMode write fColorMode;
    property XResolution: integer read fXResolution write fXResolution;
    property YResolution: integer read fYResolution write fYResolution;
    property Resolution: integer read fXResolution write SetResolution; // both X and Y resolutions
    //
    constructor Create(Owner: TComponent);
    destructor Destroy; override;
    procedure SetDefaultParams;
    procedure Assign(Source: TIESANEParams);
    function SelectSourceByName(const sn: AnsiString): boolean;
    procedure GetFromScanner;
  end;

{$ENDIF}

  // occurs after preview
{!!
<FS>TIEIOPreviewEvent

<FM>Declaration<FC>
}
  TIEIOPreviewEvent = procedure(Sender: TObject; PreviewForm: TForm) of object;
{!!}

{!!
<FS>TIEDoPreviewsEvent

<FM>Declaration<FC>
}
  TIEDoPreviewsEvent = procedure(Sender: TObject; var Handled: boolean) of object;
{!!}

{!!
<FS>TIECSSource

<FM>Declaration<FC>
TIECSSource = (iecsScreen, iecsForegroundWindow, iecsForegroundWindowClient);

<FM>Description<FN>
iecsScreen : capture current desktop
iecsForegroundWindow : capture foreground window
iecsForegroundWindowClient : capture foreground window client area
!!}
  TIECSSource = (iecsScreen, iecsForegroundWindow, iecsForegroundWindowClient);

{!!
<FS>TIEDialogType

<FM>Declaration<FC>
TIEDialogType = (iedtDialog, iedtMaxi);

<FM>Description<FN>
iedtDialog : show a dialog window.
iedtMaxi : show a maximized window.
!!}
  TIEDialogType = (iedtDialog, iedtMaxi);

{!!
<FS>TIEDialogsMeasureUnit

<FM>Declaration<FC>
TIEDialogsMeasureUnit = (ieduInches, ieduCm, ieduSelectableDefInches, ieduSelectableDefCm);

<FM>Description<FN>
<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C>ieduInches</C> <C>use inches (default)</C> </R>
<R> <C>ieduCm</C> <C>use centimeters (Cm)</C> </R>
<R> <C>ieduSelectableDefInches</C> <C>use inches but allows the user to change it</C> </R>
<R> <C>ieduSelectableDefCm</C> <C>use centimeters but allows the user to change it</C> </R>
</TABLE>
!!}
  TIEDialogsMeasureUnit = (ieduInches, ieduCm, ieduSelectableDefInches, ieduSelectableDefCm);

  // C++Builder doesn't work if we import IEVFW in interface uses
  TAviStreamInfoA_Ex = record
    fccType: DWORD;
    fccHandler: DWORD;
    dwFlags: DWORD; // Contains AVITF_* flags
    dwCaps: DWORD;
    wPriority: WORD;
    wLanguage: WORD;
    dwScale: DWORD;
    dwRate: DWORD; // dwRate / dwScale == samples/second
    dwStart: DWORD;
    dwLength: DWORD; // In units above...
    dwInitialFrames: DWORD;
    dwSuggestedBufferSize: DWORD;
    dwQuality: DWORD;
    dwSampleSize: DWORD;
    rcFrame: TRECT;
    dwEditCount: DWORD;
    dwFormatChangeCount: DWORD;
    szName: array[0..63] of AnsiChar;
  end;

  TAviStreamInfoW_Ex = record
    fccType: DWORD;
    fccHandler: DWORD;
    dwFlags: DWORD; // Contains AVITF_* flags
    dwCaps: DWORD;
    wPriority: WORD;
    wLanguage: WORD;
    dwScale: DWORD;
    dwRate: DWORD;    // dwRate / dwScale == samples/second
    dwStart: DWORD;
    dwLength: DWORD;  // In units above...
    dwInitialFrames: DWORD;
    dwSuggestedBufferSize: DWORD;
    dwQuality: DWORD;
    dwSampleSize: DWORD;
    rcFrame: TRECT;
    dwEditCount: DWORD;
    dwFormatChangeCount: DWORD;
    szName: array[0..63] of WideChar;
  end;

  TAviStreamInfo_Ex = {$IFDEF UNICODE}TAviStreamInfoW_Ex{$ELSE}TAviStreamInfoA_Ex{$ENDIF};
  PMethod = ^TMethod;

  TIEIOMethodTypes = (ieLoadSaveFile, ieLoadSaveStream, ieLoadSaveFileRetInt, ieRetBool, ieLoadSaveStreamRetInt,
                      ieLoadSaveFileFormat, ieLoadSaveStreamFormat, ieCaptureFromScreen, ieLoadSaveIndex,
                      ieImportMetaFile, ieLoadFromURL, ieAcquire);
  TIEIOMethodType_LoadSaveFile = procedure(const FileName: WideString) of object;
  TIEIOMethodType_LoadSaveStream = procedure(Stream: TStream) of object;
  TIEIOMethodType_LoadSaveFileRetInt = function(const FileName: WideString): integer of object;
  TIEIOMethodType_RetBool = function: boolean of object;
  TIEIOMethodType_LoadSaveStreamRetInt = function(Stream: TStream): integer of object;
  TIEIOMethodType_LoadSaveFileFormat = procedure(const FileName: WideString; FileFormat: TIOFileType) of object;
  TIEIOMethodType_LoadSaveStreamFormat = procedure(Stream: TStream; FileFormat: TIOFileType) of object;
  TIEIOMethodType_CaptureFromScreen = procedure(Source: TIECSSource; MouseCursor: TCursor) of object;
  TIEIOMethodType_LoadSaveIndex = procedure(Index: integer) of object;
  TIEIOMethodType_ImportMetaFile = procedure(const FileName: WideString; Width, Height: integer; WithAlpha: boolean) of object;
  TIEIOMethodType_LoadFromURL = procedure(const URL:WideString) of object;
  TIEIOMethodType_Acquire = function(api: TIEAcquireAPI): boolean of object;

  TIEIOThread = class(TThread)
  private
    fThreadList: TList;
    fMethodType: TIEIOMethodTypes;
    fMethod_LoadSaveFile: TIEIOMethodType_LoadSaveFile;
    fMethod_LoadSaveStream: TIEIOMethodType_LoadSaveStream;
    fMethod_LoadSaveFileRetInt: TIEIOMethodType_LoadSaveFileRetInt;
    fMethod_RetBool: TIEIOMethodType_RetBool;
    fMethod_LoadSaveStreamRetInt: TIEIOMethodType_LoadSaveStreamRetInt;
    fMethod_LoadSaveFileFormat: TIEIOMethodType_LoadSaveFileFormat;
    fMethod_LoadSaveStreamFormat: TIEIOMethodType_LoadSaveStreamFormat;
    fMethod_CaptureFromScreen: TIEIOMethodType_CaptureFromScreen;
    fMethod_LoadSaveIndex: TIEIOMethodType_LoadSaveIndex;
    fMethod_ImportMetaFile: TIEIOMethodType_ImportMetaFile;
    fMethod_LoadFromURL: TIEIOMethodType_LoadFromURL;
    fMethod_Acquire: TIEIOMethodType_Acquire;
    p_nf: WideString;
    p_stream: TStream;
    p_fileformat: TIOFileType;
    p_source: TIECSSource;
    p_index: integer;
    p_width, p_height: integer;
    p_withalpha: boolean;
    p_mouseCursor: TCursor;
    p_URL: WideString;
    p_api: TIEAcquireAPI;
    fThreadID: dword;
    fOwner: TImageEnIO;

    procedure Init;
  public
    procedure Execute; override;
    constructor CreateLoadSaveFile(owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveFile; const in_nf: WideString);
    constructor CreateLoadSaveStream(owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveStream; in_Stream: TStream);
    constructor CreateLoadSaveFileRetInt(owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveFileRetInt; const in_nf: WideString);
    constructor CreateRetBool(owner: TImageEnIO; InMethod: TIEIOMethodType_RetBool);
    constructor CreateLoadSaveStreamRetInt(owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveStreamRetInt; in_Stream: TStream);
    constructor CreateLoadSaveFileFormat(owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveFileFormat; const in_nf: WideString; in_fileformat: TIOFileType);
    constructor CreateLoadSaveStreamFormat(owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveStreamFormat; in_Stream: TStream; in_fileformat: TIOFileType);
    constructor CreateCaptureFromScreen(owner: TImageEnIO; InMethod: TIEIOMethodType_CaptureFromScreen; in_source: TIECSSource; in_mouseCursor: TCursor);
    constructor CreateLoadSaveIndex(owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveIndex; in_index: integer);
    constructor CreateImportMetaFile(owner: TImageEnIO; InMethod: TIEIOMethodType_ImportMetaFile; const in_nf: WideString; in_width, in_height: integer; in_withalpha: boolean);
    constructor CreateAcquire(owner: TImageEnIO; InMethod: TIEIOMethodType_Acquire; in_api: TIEAcquireAPI);
    // dummy is necessary to C++Builder in order to compile
    constructor CreateLoadFromURL(owner:TImageEnIO; InMethod:TIEIOMethodType_LoadFromURL; const in_URL:WideString; dummy:double);
    property ThreadID: dword read fThreadID;
  end;

{!!
<FS>TIOPrintPreviewPosition

<FM>Declaration<FC>
}
  TIOPrintPreviewPosition=(ppTopLeft, ppTop, ppTopRight, ppLeft, ppCenter, ppRight, ppBottomLeft, ppBottom, ppBottomRight);
{!!}

{!!
<FS>TIOPrintPreviewSize

<FM>Declaration<FC>
}
  TIOPrintPreviewSize=(psNormal, psFitToPage, psStretchToPage, psSpecifiedSize);
{!!}

  {$IFDEF IEINCLUDEPRINTDIALOGS}
  
{!!
<FS>TIOPrintPreviewParams

<FM>Description<FN>
This class allows you to set/get parameters of print preview dialog.

<FM>Methods and Properties<FN>

  <FI>Storage handling<FN>

  <A TIOPrintPreviewParams.GetProperty>
  <A TIOPrintPreviewParams.LoadFromFile>
  <A TIOPrintPreviewParams.LoadFromStream>
  <A TIOPrintPreviewParams.SaveToFile>
  <A TIOPrintPreviewParams.SaveToStream>
  <A TIOPrintPreviewParams.SetProperty>

  <FI>Settings<FN>

  <A TIOPrintPreviewParams.Gamma>
  <A TIOPrintPreviewParams.Height>
  <A TIOPrintPreviewParams.MarginBottom>
  <A TIOPrintPreviewParams.MarginLeft>
  <A TIOPrintPreviewParams.MarginRight>
  <A TIOPrintPreviewParams.MarginTop>
  <A TIOPrintPreviewParams.Position>
  <A TIOPrintPreviewParams.Size>
  <A TIOPrintPreviewParams.Width>

!!}
  TIOPrintPreviewParams = class
    private
      fMarginTop:double;
      fMarginLeft:double;
      fMarginRight:double;
      fMarginBottom:double;
      fPosition:TIOPrintPreviewPosition;
      fSize:TIOPrintPreviewSize;
      fWidth:double;    // <=0: autocalculated
      fHeight:double;   // <=0: autocalculated
      fGamma:double;
    public
      constructor Create;

{!!
<FS>TIOPrintPreviewParams.MarginTop

<FM>Declaration<FC>
property MarginTop:double;

<FM>Description<FN>
Top margin.
!!}
      property MarginTop:double read fMarginTop write fMarginTop;

{!!
<FS>TIOPrintPreviewParams.MarginLeft

<FM>Declaration<FC>
property MarginLeft:double;

<FM>Description<FN>
Left margin.
!!}
      property MarginLeft:double read fMarginLeft write fMarginLeft;

{!!
<FS>TIOPrintPreviewParams.MarginRight

<FM>Declaration<FC>
property MarginRight:double;

<FM>Description<FN>
Right margin.
!!}
      property MarginRight:double read fMarginRight write fMarginRight;

{!!
<FS>TIOPrintPreviewParams.MarginBottom

<FM>Declaration<FC>
property MarginBottom:double;

<FM>Description<FN>
Bottom margin.
!!}
      property MarginBottom:double read fMarginBottom write fMarginBottom;

{!!
<FS>TIOPrintPreviewParams.Position

<FM>Declaration<FC>
property Position:<A TIOPrintPreviewPosition>;

<FM>Description<FN>
Image position (alignment).
!!}
      property Position:TIOPrintPreviewPosition read fPosition write fPosition;

{!!
<FS>TIOPrintPreviewParams.Size

<FM>Declaration<FC>
property Size:<A TIOPrintPreviewSize>;

<FM>Description<FN>
Image size.
!!}
      property Size:TIOPrintPreviewSize read fSize write fSize;

{!!
<FS>TIOPrintPreviewParams.Width

<FM>Declaration<FC>
property Width:double;

<FM>Description<FN>
Image width when <A TIOPrintPreviewParams.Size>=psSpecifiedSize.
!!}
      property Width:double read fWidth write fWidth;

{!!
<FS>TIOPrintPreviewParams.Height

<FM>Declaration<FC>
property Height:double;

<FM>Description<FN>
Image height when <A TIOPrintPreviewParams.Size>=psSpecifiedSize.
!!}
      property Height:double read fHeight write fHeight;

{!!
<FS>TIOPrintPreviewParams.Gamma

<FM>Declaration<FC>
property Gamma:double;

<FM>Description<FN>
Gamma value.
!!}
      property Gamma:double read fGamma write fGamma;

      procedure SaveToFile(const FileName:WideString);
      procedure LoadFromFile(const FileName:WideString);
      procedure SaveToStream(Stream:TStream);
      procedure LoadFromStream(Stream:TStream);
      procedure SetProperty(Prop,Value:WideString);
      function GetProperty(const Prop:WideString):WideString;
  end;
  {$ENDIF}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// TImageEnIO

{!!
<FS>TImageEnIO<FN>

<FM>Description<FN>
TImageEnIO handles input/output operations.
TImageEnIO must be attached to a <A TImageEnView> (or inherited objects), <A TIEBitmap>, TImage and TBitmap objects.

Anyway <A TImageEnView> already encapsulates TImageEnIO and <A TImageEnProc>, so you don't actually need to put a TImageEnIO on the form.

It also maintains specific file format parameters (<A TImageEnIO.Params>) and uses them when loading or saving to file/stream.

Note: Users often attach a TImageEnIO component to a <A TImageEnMView> component. This is not correct. The <A TImageEnMIO> component must be attached only to a <A TImageEnMView> component.

<FI>Finally, please don't call any TImageEnIO method before it is actually attached to an image container (<A TImageEnView>, <A TIEBitmap>, etc).<FN>



<FM>Methods and Properties<FN>

  <FI>Connected component<FN>

  <A TImageEnIO.AttachedBitmap>
  <A TImageEnIO.AttachedIEBitmap>
  <A TImageEnIO.AttachedImageEn>
  <A TImageEnIO.AttachedTImage>

  <FI>Generic Input/Output<FN>

  <A TImageEnIO.Aborting>
  <A TImageEnIO.AssignParams>
  <A TImageEnIO.AutoAdjustDPI>
  <A TImageEnIO.Background>
  <A TImageEnIO.Bitmap>
  <A TImageEnIO.CaptureFromScreen>
  <A TImageEnIO.ChangeBackground>
  <A TImageEnIO.Create>
  <A TImageEnIO.CreateFromBitmap>
  <A TImageEnIO.DefaultDitherMethod>
  <A TImageEnIO.FilteredAdjustDPI>
  <A TImageEnIO.IEBitmap>
  <A TImageEnIO.LoadFromBuffer>
  <A TImageEnIO.LoadFromFileAuto>
  <A TImageEnIO.LoadFromFileFormat>
  <A TImageEnIO.LoadFromFile>
  <A TImageEnIO.LoadFromResource>
  <A TImageEnIO.LoadFromStreamFormat>
  <A TImageEnIO.LoadFromStream>
  <A TImageEnIO.LoadFromURL>
  <A TImageEnIO.NativePixelFormat>
  <A TImageEnIO.Params>
  <A TImageEnIO.ParamsFromBuffer>
  <A TImageEnIO.ParamsFromFileFormat>
  <A TImageEnIO.ParamsFromFile>
  <A TImageEnIO.ParamsFromStreamFormat>
  <A TImageEnIO.ParamsFromStream>
  <A TImageEnIO.ProxyAddress>
  <A TImageEnIO.ProxyPassword>
  <A TImageEnIO.ProxyUser>
  <A TImageEnIO.SaveToFile>
  <A TImageEnIO.SaveToStream>
  <A TImageEnIO.SaveToText>
  <A TImageEnIO.StreamHeaders>
  <A TImageEnIO.Update>

  <FI>TWain/WIA<FN>

  <A TImageEnIO.AcquireClose>
  <A TImageEnIO.AcquireOpen>
  <A TImageEnIO.Acquire>
  <A TImageEnIO.SelectAcquireSource>
  <A TImageEnIO.TWainParams>
  <A TImageEnIO.WIAParams>

  <FI>Aynchronous input/output<FN>

  <A TImageEnIO.AsyncMode>
  <A TImageEnIO.AsyncRunning>
  <A TImageEnIO.ThreadsCount>
  <A TImageEnIO.WaitThreads>

  <FI>DirectShow capture<FN>

  <A TImageEnIO.DShowParams>

  <FI>Dialogs<FN>

  <A TImageEnIO.DialogsMeasureUnit>
  <A TImageEnIO.DoPreviews>
  <A TImageEnIO.ExecuteOpenDialog>
  <A TImageEnIO.ExecuteSaveDialog>
  <A TImageEnIO.MsgLanguage>
  <A TImageEnIO.PreviewFont>
  <A TImageEnIO.PreviewsParams>
  <A TImageEnIO.SimplifiedParamsDialogs>

  <FI>Printing<FN>

  <A TImageEnIO.DoPrintPreviewDialog>
  <A TImageEnIO.PreviewPrintImage>
  <A TImageEnIO.PrintImagePos>
  <A TImageEnIO.PrintImage>
  <A TImageEnIO.PrintingFilterOnSubsampling>
  <A TImageEnIO.PrintPreviewParams>

  <FI>JPEG<FN>

  <A TImageEnIO.InjectJpegEXIFStream>
  <A TImageEnIO.InjectJpegEXIF>
  <A TImageEnIO.InjectJpegIPTCStream>
  <A TImageEnIO.InjectJpegIPTC>
  <A TImageEnIO.LoadFromFileJpeg>
  <A TImageEnIO.LoadFromStreamJpeg>
  <A TImageEnIO.SaveToFileJpeg>
  <A TImageEnIO.SaveToStreamJpeg>

  <FI>JPEG 2000<FN>

  <A TImageEnIO.LoadFromFileJ2K>
  <A TImageEnIO.LoadFromFileJP2>
  <A TImageEnIO.LoadFromStreamJ2K>
  <A TImageEnIO.LoadFromStreamJP2>
  <A TImageEnIO.SaveToFileJ2K>
  <A TImageEnIO.SaveToFileJP2>
  <A TImageEnIO.SaveToStreamJ2K>
  <A TImageEnIO.SaveToStreamJP2>

  <FI>GIF<FN>

  <A TImageEnIO.InsertToFileGIF>
  <A TImageEnIO.LoadFromFileGIF>
  <A TImageEnIO.LoadFromStreamGIF>
  <A TImageEnIO.SaveToFileGIF>
  <A TImageEnIO.SaveToStreamGIF>
  <A TImageEnIO.ReplaceFileGIF>

  <FI>Adobe PSD<FN>

  <A TImageEnIO.LoadFromFilePSD>
  <A TImageEnIO.LoadFromStreamPSD>
  <A TImageEnIO.SaveToFilePSD>
  <A TImageEnIO.SaveToStreamPSD>

  <FI>HDP - Microsoft HD Photo<FN>

  <A TImageEnIO.LoadFromFileHDP>
  <A TImageEnIO.LoadFromStreamHDP>
  <A TImageEnIO.SaveToFileHDP>
  <A TImageEnIO.SaveToStreamHDP>

  <FI>TIFF<FN>

  <A TImageEnIO.InjectTIFFEXIF>
  <A TImageEnIO.InsertToFileTIFF>
  <A TImageEnIO.InsertToStreamTIFF>
  <A TImageEnIO.LoadFromFileTIFF>
  <A TImageEnIO.LoadFromStreamTIFF>
  <A TImageEnIO.ReplaceFileTIFF>
  <A TImageEnIO.ReplaceStreamTIFF>
  <A TImageEnIO.SaveToFileTIFF>
  <A TImageEnIO.SaveToStreamTIFF>

  <FI>BMP<FN>

  <A TImageEnIO.LoadFromFileBMP>
  <A TImageEnIO.LoadFromStreamBMP>
  <A TImageEnIO.SaveToFileBMP>
  <A TImageEnIO.SaveToStreamBMP>

  <FI>PNG<FN>

  <A TImageEnIO.LoadFromFilePNG>
  <A TImageEnIO.LoadFromStreamPNG>
  <A TImageEnIO.SaveToFilePNG>
  <A TImageEnIO.SaveToStreamPNG>

  <FI>DCX<FN>

  <A TImageEnIO.LoadFromFileDCX>
  <A TImageEnIO.LoadFromStreamDCX>
  <A TImageEnIO.SaveToStreamDCX>
  <A TImageEnIO.SaveToFileDCX>
  <A TImageEnIO.InsertToFileDCX>

  <FI>CUR<FN>

  <A TImageEnIO.LoadFromFileCUR>
  <A TImageEnIO.LoadFromStreamCUR>

  <FI>ICO<FN>

  <A TImageEnIO.LoadFromFileICO>
  <A TImageEnIO.LoadFromStreamICO>
  <A TImageEnIO.SaveToFileICO>
  <A TImageEnIO.SaveToStreamICO>

  <FI>PCX<FN>

  <A TImageEnIO.LoadFromFilePCX>
  <A TImageEnIO.LoadFromStreamPCX>
  <A TImageEnIO.SaveToFilePCX>
  <A TImageEnIO.SaveToStreamPCX>

  <FI>WMF, EMF<FN>

  <A TImageEnIO.ImportMetafile>
  <A TImageEnIO.MergeMetaFile>

  <FI>TGA<FN>

  <A TImageEnIO.LoadFromFileTGA>
  <A TImageEnIO.LoadFromStreamTGA>
  <A TImageEnIO.SaveToFileTGA>
  <A TImageEnIO.SaveToStreamTGA>

  <FI>PXM (PPM, PBM,PGM)<FN>

  <A TImageEnIO.LoadFromFilePXM>
  <A TImageEnIO.LoadFromStreamPXM>
  <A TImageEnIO.SaveToFilePXM>
  <A TImageEnIO.SaveToStreamPXM>

  <FI>AVI<FN>

  <A TImageEnIO.CloseAVIFile>
  <A TImageEnIO.CreateAVIFile>
  <A TImageEnIO.IsOpenAVI>
  <A TImageEnIO.LoadFromAVI>
  <A TImageEnIO.OpenAVIFile>
  <A TImageEnIO.SaveToAVI>

  <FI>WBMP<FN>

  <A TImageEnIO.LoadFromFileWBMP>
  <A TImageEnIO.LoadFromStreamWBMP>
  <A TImageEnIO.SaveToFileWBMP>
  <A TImageEnIO.SaveToStreamWBMP>

  <FI>PostScript (PS)<FN>

  <A TImageEnIO.ClosePSFile>
  <A TImageEnIO.CreatePSFile>
  <A TImageEnIO.SaveToFilePS>
  <A TImageEnIO.SaveToPS>
  <A TImageEnIO.SaveToStreamPS>

  <FI>Adobe PDF<FN>

  <A TImageEnIO.ClosePDFFile>
  <A TImageEnIO.CreatePDFFile>
  <A TImageEnIO.SaveToFilePDF>
  <A TImageEnIO.SaveToPDF>
  <A TImageEnIO.SaveToStreamPDF>

  <FI>RAW Camera<FN>

  <A TImageEnIO.LoadFromFileRAW>
  <A TImageEnIO.LoadFromStreamRAW>
  <A TImageEnIO.LoadJpegFromFileCRW>

  <FI>MediaFiles (AVI, MPEG, WMV..)<FN>

  <A TImageEnIO.CloseMediaFile>
  <A TImageEnIO.IsOpenMediaFile>
  <A TImageEnIO.LoadFromMediaFile>
  <A TImageEnIO.OpenMediaFile>

  <FI>Real RAW (not Camera RAW)<FN>

  <A TImageEnIO.LoadFromFileBMPRAW>
  <A TImageEnIO.LoadFromStreamBMPRAW>
  <A TImageEnIO.SaveToFileBMPRAW>
  <A TImageEnIO.SaveToStreamBMPRAW>

  <FI>DICOM medical imaging<FN>

  <A TImageEnIO.LoadFromFileDICOM>
  <A TImageEnIO.LoadFromStreamDICOM>

  <FM>Events<FN>

  <A TImageEnIO.OnAcquireBitmap>
  <A TImageEnIO.OnDoPreviews>
  <A TImageEnIO.OnFinishWork>
  <A TImageEnIO.OnIOPreview>
  <A TImageEnIO.OnProgress>
!!}
  TImageEnIO = class(TComponent)

  private

    fBitmap: TBitmap; // refers to the bitmap (if fImageEnView is valid then it is FImageEnView.bitmap)
    fIEBitmap: TIEBitmap; // encapsulates fBitmap if SetBitmap, SetAttachedBitmap, SetAttachedImageEn, SetTImage are called
    fIEBitmapCreated: boolean; // true is fIEBitmap is created by TImageEnIO
    fImageEnView: TIEView; // refers to TIEView (fbitmap=fimageenview.bitmap)
    fImageEnViewBitmapChangeHandle:pointer; // bitmap change handle (nil=none)
    fTImage: TImage; // refers to TImage
    fBackground: TColor; // valid only if fImageEnview=nil
    fMsgLanguage: TMsgLanguage;
    fPreviewsParams: TIOPreviewsParams;
    fSimplifiedParamsDialogs: boolean;
    fOnDoPreviews: TIEDoPreviewsEvent;
    fChangeBackground: boolean; // if true change the Background property using the loaded image background
{$IFDEF IEINCLUDETWAIN}
    fTwainParams: TIETWainParams;
{$ENDIF}
    (*$ifdef IEINCLUDESANE*)
    fSANEParams: TIESANEParams;
    (*$endif*)
    fStreamHeaders: boolean; // enable/disable load/save stream headers
    fPreviewFont: TFont;
    fOnIOPreview: TIEIOPreviewEvent;
    fDialogsMeasureUnit: TIEDialogsMeasureUnit;
    fAutoAdjustDPI: boolean;
    fFilteredAdjustDPI: boolean;
    fAVI_avf: pointer; // PAVIFILE
    fAVI_avs: pointer; // PAVISTREAM
    fAVI_avs1: pointer; // PAVISTREAM
    fAVI_gf: pointer; // PGETFRAME
    fAVI_psi: TAviStreamInfoW_Ex;
    fAVI_popts: pointer; // PAVICOMPRESSOPTIONS
    fAVI_idx: integer;
    {$ifdef IEINCLUDEDIRECTSHOW}
    fOpenMediaFile:TIEDirectShow; // open media file
    fOpenMediaFileRate:double;
    fOpenMediaFileMul:integer;
    {$endif}
    fPS_handle: pointer;
    fPS_stream: TIEWideFileStream;
    fPDF_handle: pointer;
    fPDF_stream: TIEWideFileStream;
    fAsyncThreads: TList; // Count>0 is one o more threads are running
    fAsyncThreadsFinishEvent:THandle;
    fAsyncThreadsCS: TRTLCriticalSection; // protect fAsyncThreads access
    fAsyncMode: boolean; // true if we need async mode
    fPrintingFilterOnSubsampling: TResampleFilter;
    // TWain modeless
    fgrec: pointer;
    // WIA
{$IFDEF IEINCLUDEWIA}
    fWIA: TIEWia;
{$ENDIF}
    // DirectShow
{$IFDEF IEINCLUDEDIRECTSHOW}
    fDShow: TIEDirectShow;
{$ENDIF}
    // proxy settings
    fProxyAddress, fProxyUser, fProxyPassword: WideString;
    //
    fDefaultDitherMethod: TIEDitherMethod;
    fResetPrinter: boolean;
    {$IFDEF IEINCLUDEPRINTDIALOGS}
    fPrintPreviewParams:TIOPrintPreviewParams;
    {$ENDIF}
    //
    function IsInsideAsyncThreads: boolean;
    procedure SetAttachedBitmap(atBitmap: TBitmap);
    procedure SetAttachedImageEn(atImageEn: TIEView);
    function GetReBackground: TColor;
    procedure SetReBackground(v: TColor);
    procedure SetPreviewFont(f: TFont);
    procedure SetTImage(v: TImage);
    procedure SetIOPreviewParams(v: TIOPreviewsParams);
    function GetIOPreviewParams: TIOPreviewsParams;
    procedure AdjustDPI;
    function GetAsyncRunning: integer;
    function GetThreadsCount: integer;
    procedure SetDefaultDitherMethod(Value: TIEDitherMethod);
{$IFDEF IEINCLUDEWIA}
    function WiaOnProgress(Percentage: integer): boolean;
{$ENDIF}
    procedure SetPrintLogFile(v:String);
    function GetPrintLogFile:String;
    procedure UpdateAPP138BimResolution;
    procedure ParamsFromMetaFile(stream:TStream);

  protected

{$IFNDEF IEDEBUG}
    fParams: TIOParamsVals;
{$ENDIF}
    fAborting: boolean;
    fOnIntProgress: TIEProgressEvent; // internal progress event, always assigned to DoIntProgress
    fOnProgress: TIEProgressEvent;
    fOnFinishWork: TNotifyEvent;
    fOnAcquireBitmap: TIEAcquireBitmapEvent;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OnBitmapChange(Sender: TObject; destroying: boolean);
    procedure PrintImageEx(PrtCanvas: TCanvas; dpix, dpiy: integer; pagewidth, pageheight: double; MarginLeft, MarginTop, MarginRight, MarginBottom: double; VerticalPos: TIEVerticalPos; HorizontalPos: TIEHorizontalPos; Size: TIESize; SpecWidth, SpecHeight: double; GammaCorrection: double);
    procedure PrintImagePosEx(PrtCanvas: TCanvas; dpix, dpiy: integer; x, y: double; Width, Height: double; GammaCorrection: double);
{$IFDEF IEINCLUDEJPEG2000}
    procedure LoadFromStreamJ2000(Stream: TStream);
    procedure SaveToStreamJ2000(Stream: TStream; format: integer);
{$ENDIF} // IEINCLUDEJPEG2000
    procedure SetBitmap(bmp: TBitmap);
    procedure SetIEBitmap(bmp: TIEBitmap);
    procedure SetAttachedIEBitmap(bmp: TIEBitmap);
    procedure TWMultiCallBack(Bitmap: TIEBitmap; var IOParams: TObject); virtual;
    procedure TWCloseCallBack; virtual;
    procedure DoAcquireBitmap(ABitmap: TIEBitmap; var Handled: boolean); dynamic;
    procedure DoFinishWork; virtual;
    function GetBitmap: TBitmap; virtual;
    function MakeConsistentBitmap(allowedFormats: TIEPixelFormatSet): boolean;
{$IFDEF IEINCLUDEWIA}
    function GetWIAParams: TIEWia; virtual;
{$ENDIF}
{$IFDEF IEINCLUDEDIRECTSHOW}
    function GetDShowParams: TIEDirectShow; virtual;
{$ENDIF}
    function SyncLoadFromStreamGIF(Stream: TStream): integer;
    procedure SyncLoadFromStreamPCX(Stream: TStream; streamhead: boolean);
    procedure SyncLoadFromStreamDCX(Stream: TStream);
    function SyncLoadFromStreamTIFF(Stream: TStream; streamhead: boolean): integer;
    procedure SyncLoadFromStreamBMP(Stream: TStream);
    procedure SyncSaveToStreamPS(Stream: TStream);
    {$ifdef IEINCLUDEPDFWRITING}
    procedure SyncSaveToStreamPDF(Stream: TStream);
    {$endif}
    procedure SyncSaveToStreamBMP(Stream: TStream);
    procedure SyncSaveToStreamDCX(Stream: TStream);
    {$ifdef IEINCLUDEPSD}
    procedure SyncLoadFromStreamPSD(Stream: TStream);
    {$endif}
    procedure SyncLoadFromStreamCUR(Stream:TStream);
    procedure SyncLoadFromStreamICO(Stream:TStream);
    {$ifdef IEINCLUDEWIC}
    procedure SyncLoadFromStreamHDP(Stream: TStream);
    {$endif}
    {$ifdef IEINCLUDERAWFORMATS}
    procedure SyncLoadFromStreamRAW(Stream: TStream);
    {$endif}
    procedure SyncLoadFromStreamBMPRAW(Stream:TStream);
    procedure SyncSaveToStreamBMPRAW(Stream: TStream);
    procedure CheckDPI;
    procedure SetNativePixelFormat(value:boolean);
    function GetNativePixelFormat:boolean;
    procedure DoIntProgress(Sender: TObject; per: integer); virtual;
    {$ifdef IEINCLUDEPSD}
    procedure SyncSaveToStreamPSD(Stream: TStream);
    {$endif}
    {$ifdef IEINCLUDEWIC}
    procedure SyncSaveToStreamHDP(Stream: TStream);
    {$endif}
    procedure LoadViewerFile(const fileName:WideString; ft:TIOFileType);
    procedure LoadViewerStream(Stream:TStream; ft:TIOFileType);
    procedure SetViewerDPI(dpix, dpiy:integer); virtual;

  public

{$IFDEF IEDEBUG}
    fParams: TIOParamsVals;
{$ENDIF}
    constructor Create(Owner: TComponent); override;
    constructor CreateFromBitmap(Bitmap:TIEBitmap); overload;
    constructor CreateFromBitmap(Bitmap:TBitmap); overload;
    destructor Destroy; override;
    property AttachedBitmap: TBitmap read fBitmap write SetAttachedBitmap;
    property AttachedIEBitmap: TIEBitmap read fIEBitmap write SetAttachedIEBitmap;
    procedure Update;
    procedure SyncGetHandle;

{!!
<FS>TImageEnIO.ChangeBackground

<FM>Declaration<FC>
property ChangeBackground:boolean;

<FM>Description<FN>
Set ChangeBackground to True to change the <A TImageEnView> control background color to the image background color (the default is False). Not all file formats contains background color information.
!!}
    property ChangeBackground: boolean read fChangeBackground write fChangeBackground;

    property ThreadsCount: integer read GetThreadsCount;
    property DefaultDitherMethod: TIEDitherMethod read fDefaultDitherMethod write SetDefaultDitherMethod;
{$IFDEF IEINCLUDEDIALOGIO}
    function DoPreviews(pp: TPreviewParams = [ppAll]): boolean; virtual;
{$ENDIF} // IEINCLUDEDIALOGIO
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property IEBitmap: TIEBitmap read fIEBitmap write SetIEBitmap;

{!!
<FS>TImageEnIO.Params

<FM>Declaration<FC>
property Params: <A TIOParamsVals>;

<FM>Description<FN>
This property contains a TIOParamsVals object. This property contains some parameters (as bits per sample, type of compression, etc) of each image file format. The parameters are updated when you load files or streams.
Also you can modify these parameters before saving to files or streams.

Read-only

<FM>Example<FC>

// Sets colormapped 256 colors
ImageEnView1.IO.Params.BitsPerSample:=8;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
// Sets OS2.x compressed BMP
ImageEnView1.IO.Params.BMP_Version:=ioBMP_BMOS2V2;
ImageEnView1.IO.Params.BMP_Compression:=ioBMP_RLE;
// Saves
ImageEnView1.IO.SaveToFile('lady.bmp');
!!}
    property Params: TIOParamsVals read fParams;

    procedure AssignParams(Source: TObject);
    procedure RecreatedTImageEnViewHandle;

    {$ifdef IEINCLUDERESOURCEEXTRACTOR}
    procedure LoadFromResource(const ModulePath:WideString; const ResourceType:string; const ResourceName:string; Format:TIOFileType);
    {$endif}

    // JPEG
    procedure SaveToFileJpeg(const FileName: WideString);
    procedure LoadFromFileJpeg(const FileName: WideString);
    procedure SaveToStreamJpeg(Stream: TStream);
    procedure LoadFromStreamJpeg(Stream: TStream);
    function InjectJpegIPTC(const FileName: WideString): boolean;
    function InjectJpegIPTCStream(InputStream, OutputStream: TStream): boolean;
    function InjectJpegEXIF(const FileName: WideString): boolean;
    function InjectJpegEXIFStream(InputStream, OutputStream: TStream): boolean;
    // DCX
    procedure LoadFromFileDCX(const FileName: WideString);
    procedure LoadFromStreamDCX(Stream: TStream);
    procedure SaveToStreamDCX(Stream: TStream);
    procedure SaveToFileDCX(const FileName: WideString);
    procedure InsertToFileDCX(const FileName: WideString);
    // JPEG2000
{$IFDEF IEINCLUDEJPEG2000}
    procedure LoadFromFileJP2(const FileName: WideString);
    procedure LoadFromFileJ2K(const FileName: WideString);
    procedure LoadFromStreamJP2(Stream: TStream);
    procedure LoadFromStreamJ2K(Stream: TStream);
    procedure SaveToStreamJP2(Stream: TStream);
    procedure SaveToStreamJ2K(stream: TStream);
    procedure SaveToFileJP2(const FileName: WideString);
    procedure SaveToFileJ2K(const FileName: WideString);
{$ENDIF} // IEINCLUDEJPEG2000
    // GIF
    function LoadFromFileGIF(const FileName: WideString): integer;
    procedure SaveToFileGIF(const FileName: WideString);
    function InsertToFileGIF(const FileName: WideString): integer;
    function LoadFromStreamGIF(Stream: TStream): integer;
    procedure SaveToStreamGIF(Stream: TStream);
    function ReplaceFileGIF(const FileName: WideString): integer;
    // PCX
    procedure SaveToStreamPCX(Stream: TStream);
    procedure LoadFromStreamPCX(Stream: TStream);
    procedure SaveToFilePCX(const FileName: WideString);
    procedure LoadFromFilePCX(const FileName: WideString);
    // TIFF
    function LoadFromStreamTIFF(Stream: TStream): integer;
    procedure SaveToStreamTIFF(Stream: TStream);
    function LoadFromFileTIFF(const FileName: WideString): integer;
    procedure SaveToFileTIFF(const FileName: WideString);
    function InsertToFileTIFF(const FileName: WideString): integer;
    function InsertToStreamTIFF(Stream: TStream): integer;
    function ReplaceFileTIFF(const FileName: WideString): integer;
    function ReplaceStreamTIFF(Stream: TStream): integer;
    {$ifdef IEINCLUDETIFFHANDLER}
    function InjectTIFFEXIF(const FileName: WideString; pageIndex:integer = 0): boolean; overload;
    function InjectTIFFEXIF(const InputFileName, OutputFileName: WideString; pageIndex:integer = 0): boolean; overload;
    function InjectTIFFEXIF(InputStream, OutputStream:TStream; pageIndex:integer = 0): boolean; overload;
    {$endif}
    // BMP
    procedure SaveToStreamBMP(Stream: TStream);
    procedure LoadFromStreamBMP(Stream: TStream);
    procedure SaveToFileBMP(const FileName: WideString);
    procedure LoadFromFileBMP(const FileName:WideString);
    // ICO
    procedure LoadFromFileICO(const FileName: WideString);
    procedure LoadFromStreamICO(Stream:TStream);
    procedure SaveToStreamICO(Stream: TStream);
    procedure SaveToFileICO(const FileName: WideString);
    // CUR
    procedure LoadFromFileCUR(const FileName: WideString);
    procedure LoadFromStreamCUR(Stream:TStream);
    // PNG
{$IFDEF IEINCLUDEPNG}
    procedure LoadFromFilePNG(const FileName: WideString);
    procedure LoadFromStreamPNG(Stream: TStream);
    procedure SaveToFilePNG(const FileName: WideString);
    procedure SaveToStreamPNG(Stream: TStream);
{$ENDIF}
{$ifdef IEINCLUDEDICOM}
    // DICOM
    procedure LoadFromFileDICOM(const FileName: WideString);
    procedure LoadFromStreamDICOM(Stream:TStream);
{$endif}
    // TGA
    procedure LoadFromFileTGA(const FileName: WideString);
    procedure LoadFromStreamTGA(Stream: TStream);
    procedure SaveToFileTGA(const FileName: WideString);
    procedure SaveToStreamTGA(Stream: TStream);
    // METAFILE (WMF,EMF)
    procedure ImportMetafile(const FileName:WideString; Width:integer=-1; Height:integer=-1; WithAlpha: boolean=true); overload;
    procedure ImportMetafile(Stream:TStream; Width:integer=-1; Height:integer=-1; WithAlpha: boolean=true); overload;
    procedure ImportMetaFile(meta:TMetaFile; Width:integer=-1; Height:integer=-1; WithAlpha: boolean=true); overload;
    procedure MergeMetafile(const FileName:WideString; x, y:integer; Width:integer=-1; Height:integer=-1);
    // PXM, PBM, PGM, PPM
    procedure LoadFromFilePXM(const FileName: WideString);
    procedure LoadFromStreamPXM(Stream: TStream);
    procedure SaveToFilePXM(const FileName: WideString);
    procedure SaveToStreamPXM(Stream: TStream);
    // AVI
    function OpenAVIFile(const FileName: WideString): integer;
    procedure CloseAVIFile;
    procedure LoadFromAVI(FrameIndex: integer);
    function CreateAVIFile(const FileName: WideString; rate:integer=15; const codec:AnsiString='DIB '):TIECreateAVIFileResult;
    procedure SaveToAVI;
    function IsOpenAVI:boolean;
    // Media File
    {$ifdef IEINCLUDEDIRECTSHOW}
    function OpenMediaFile(const FileName: WideString):integer;
    procedure CloseMediaFile;
    procedure LoadFromMediaFile(FrameIndex:integer);
    function IsOpenMediaFile:boolean;
    {$endif}
    // WBMP
    procedure LoadFromFileWBMP(const FileName: WideString);
    procedure LoadFromStreamWBMP(Stream: TStream);
    procedure SaveToFileWBMP(const FileName: WideString);
    procedure SaveToStreamWBMP(Stream: TStream);
    // PostScript (PS)
    procedure CreatePSFile(const FileName: WideString);
    procedure SaveToPS;
    procedure ClosePSFile;
    procedure SaveToStreamPS(Stream: TStream);
    procedure SaveToFilePS(const FileName: WideString);
    // PDF
    {$ifdef IEINCLUDEPDFWRITING}
    procedure CreatePDFFile(const FileName: WideString);
    procedure SaveToPDF;
    procedure ClosePDFFile;
    procedure SaveToStreamPDF(Stream: TStream);
    procedure SaveToFilePDF(const FileName: WideString);
    {$endif}
    // RAW
    {$ifdef IEINCLUDERAWFORMATS}
    procedure LoadFromStreamRAW(Stream: TStream);
    procedure LoadFromFileRAW(const FileName: WideString);
    procedure LoadJpegFromFileCRW(const FileName: WideString);
    {$endif}
    // Real RAW
    procedure LoadFromStreamBMPRAW(Stream: TStream);
    procedure LoadFromFileBMPRAW(const FileName: WideString);
    procedure SaveToStreamBMPRAW(Stream: TStream);
    procedure SaveToFileBMPRAW(const FileName: WideString);
    // PSD
    {$ifdef IEINCLUDEPSD}
    procedure LoadFromStreamPSD(Stream:TStream);
    procedure LoadFromFilePSD(const FileName: WideString);
    procedure SaveToStreamPSD(Stream: TStream);
    procedure SaveToFilePSD(const FileName: WideString);
    {$endif}
    // HDP
    {$ifdef IEINCLUDEWIC}
    procedure LoadFromStreamHDP(Stream:TStream);
    procedure LoadFromFileHDP(const FileName: WideString);
    procedure SaveToStreamHDP(Stream: TStream);
    procedure SaveToFileHDP(const FileName: WideString);
    {$endif}
    // GENERAL
    procedure LoadFromFile(const FileName: WideString); dynamic;
    procedure LoadFromFileAuto(const FileName: WideString); dynamic;
    procedure SaveToFile(const FileName: WideString); dynamic;
    procedure SaveToText(const FileName:WideString; ImageFormat:TIOFileType=-1; TextFormat:TIETextFormat=ietfASCIIArt); dynamic;
    procedure LoadFromFileFormat(const FileName: WideString; FileFormat: TIOFileType); dynamic;
    procedure LoadFromBuffer(Buffer:pointer; BufferSize:integer; Format:TIOFileType = ioUnknown); dynamic;
    procedure ParamsFromBuffer(Buffer:pointer; BufferSize:integer; Format:TIOFileType = ioUnknown); dynamic;

{!!
<FS>TImageEnIO.Aborting

<FM>Declaration<FC>
property Aborting:boolean;

<FM>Description<FN>
Applications can abort save/load processing by assigning True to the Aborting property.

If the value is set to True during loading, the image will be truncated. If it is set to True during saving, the file will be closed and truncated (will be unreadable).
You can also read the <FC>Aborting<FN> property to know when aborting is in progress.

<FM>Example<FC>

// Begin to load image
procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnView1.IO.LoadFromFile('xyx.bmp');
end;

// Progress of load
procedure TForm1.ImageEnIO1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position:=per;
  Application.ProcessMessages;	 // <- important!
end;

// STOP! button
procedure TForm1.Button1Click(Sender: TObject);
begin
  ImageEnView1.IO.Aborting:=True;
end;
!!}
    property Aborting: boolean read fAborting write fAborting;

    procedure ParamsFromFile(const FileName: WideString); dynamic;
    procedure ParamsFromFileFormat(const FileName: WideString; format: TIOFileType); dynamic;
    procedure ParamsFromStream(Stream: TStream); dynamic;
    procedure ParamsFromStreamFormat(Stream: TStream; format: TIOFileType); dynamic;
    procedure LoadFromStream(Stream: TStream); dynamic;
    procedure LoadFromStreamFormat(Stream: TStream; FileFormat: TIOFileType); dynamic;
    procedure SaveToStream(Stream: TStream; FileType: TIOFileType); dynamic;
{$IFDEF IEINCLUDEOPENSAVEDIALOGS}
    function ExecuteOpenDialog(const InitialDir:WideString = ''; const InitialFileName:WideString = '';AlwaysAnimate:boolean = True; FilterIndex:integer = 1; const ExtendedFilters:WideString = ''; const Title:WideString=''; const Filter:WideString=''): WideString;
    function ExecuteSaveDialog(const InitialDir:WideString = ''; const InitialFileName:WideString = '';AlwaysAnimate:boolean = False; FilterIndex:integer = 0; const ExtendedFilters:WideString = ''; const Title:WideString=''; const Filter:WideString=''): WideString;
{$ENDIF} // IEINCLUDEOPENSAVEDIALOGS
    procedure CaptureFromScreen(Source: TIECSSource = iecsScreen; MouseCursor: TCursor = -1);
    procedure LoadFromURL(const URL:WideString);
    // TWAIN SCANNERS
{$IFDEF IEINCLUDETWAIN}
    function Acquire(api: TIEAcquireApi = ieaTWain): boolean;
    function SelectAcquireSource(api: TIEAcquireApi = ieaTWain): boolean;
    function AcquireOpen: boolean;
    procedure AcquireClose;
{$ENDIF} // IEINCLUDETWAIN
{$IFDEF IEINCLUDESANE}
    function Acquire: boolean;
{$ENDIF} // IEINCLUDESANE
    // ASYNC WORKS
    property AsyncRunning: integer read GetAsyncRunning;

{!!
<FS>TImageEnIO.AsyncMode

<FM>Declaration<FC>
property AsyncMode:boolean;

<FM>Description<FN>
Set AsyncMode to True to enable asynchronous input/output operations.
When asynchronous mode is enabled, each input/output method creates a new thread that executes the task then the called method returns without waiting for the end of the task.
Applicable only when TImageEnIO is attached to a <A TIEBitmap> object.

<FM>Example<FC>

// multithread saving
Var
  Bmp:TIEBitmap;
  Io:TImageEnIO;
Begin
  Bmp:=TIEBitmap.Create;
  Io:=TImageEnIO.CreateFromBitmap(bmp);

  Io.LoadFromFile('input.bmp');
  Io.AsyncMode:=True;	// this makes a thread foreach input/output task
  Io.SaveToFile('i1.jpg');	// thread-1
  Io.SaveToFile('i2.jpg');	// thread-2
  Io.SaveToFile('i3.jpg');	// thread-3

  Io.Free;	// free method waits for all tasks end!
  Bmp.Free;
End;
!!}
    property AsyncMode: boolean read fAsyncMode write fAsyncMode;

    procedure WaitThreads(Aborts:boolean = false);
    procedure SuspendThreads; {$ifdef IEHASTTHREADSTART} deprecated; {$endif}
    procedure ResumeThreads;  {$ifdef IEHASTTHREADSTART} deprecated; {$endif}

    // TWAIN/WIA and SANE scanners
{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnIO.TWainParams

<FM>Declaration<FC>
property TWainParams:<A TIETWainParams>;

<FM>Description<FN>
Use the TWainParams property to control scanner acquisition. You can enable/disable standard user interface, set pixeltype (Grayscale, RGB...), DPI, or select the acquire scanner without user interaction.

Look at <FC>TIETWainParams<FN> object for more details.

<FM>Example<FC>

// Acquires a black/white (1bit) image
ImageEnView1.IO.TWainParams.PixelType.CurrentValue:=0;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;
!!}
    property TWainParams: TIETWainParams read fTWainParams;

{$ENDIF}
{$IFDEF IEINCLUDESANE}
    property SANEParams: TIESANEParams read fSANEParams;
{$ENDIF}
{$IFDEF IEINCLUDEWIA}
    property WIAParams: TIEWia read GetWIAParams;
{$ENDIF}
    // Video capture
{$IFDEF IEINCLUDEDIRECTSHOW}
    property DShowParams: TIEDirectShow read GetDShowParams;
{$ENDIF}
    // PRINTING
    procedure PrintImagePos(PrtCanvas: TCanvas; x, y: double; Width, Height: double; GammaCorrection: double = 1);
    procedure PrintImage(PrtCanvas: TCanvas = nil; MarginLeft: double = 1; MarginTop: double = 1; MarginRight: double = 1; MarginBottom: double = 1; VerticalPos: TIEVerticalPos = ievpCENTER; HorizontalPos: TIEHorizontalPos = iehpCENTER; Size: TIESize = iesFITTOPAGE; SpecWidth: double = 0; SpecHeight: double = 0; GammaCorrection: double = 1);
    procedure PreviewPrintImage(DestBitmap: TBitmap; MaxBitmapWidth: integer; MaxBitmapHeight: integer; PrinterObj: TPrinter = nil; MarginLeft: double = 1; MarginTop: double = 1; MarginRight: double = 1; MarginBottom: double = 1; VerticalPos: TIEVerticalPos = ievpCENTER; HorizontalPos: TIEHorizontalPos = iehpCENTER; Size: TIESize = iesFITTOPAGE; SpecWidth: double = 0; SpecHeight: double = 0; GammaCorrection: double = 1);
{$IFDEF IEINCLUDEPRINTDIALOGS}
    function DoPrintPreviewDialog(DialogType: TIEDialogType = iedtDialog; const TaskName: WideString = ''; PrintAnnotations:boolean=false; const Caption:WideString=''): boolean;

{!!
<FS>TImageEnIO.PrintPreviewParams

<FM>Declaration<FC>
property PrintPreviewParams:<A TIOPrintPreviewParams>;

<FM>Description<FN>
This property allows you to set/get parameters of print preview dialog.

All measure units are specified by <A TImageEnIO.DialogsMeasureUnit> property.
!!}
    property PrintPreviewParams:TIOPrintPreviewParams read fPrintPreviewParams;

{$ENDIF}

{!!
<FS>TImageEnIO.PrintingFilterOnSubsampling

<FM>Declaration<FC>
property PrintingFilterOnSubsampling: <A TResampleFilter>;

<FM>Description<FN>
Specifies a filter when the image needs to be printed and it must be resampled.
Filtering enhances the image quality but slows processing.
!!}
    property PrintingFilterOnSubsampling: TResampleFilter read fPrintingFilterOnSubsampling write fPrintingFilterOnSubsampling;

    // proxy settings (used by LoadFromURL and LoadFromFile with http:// prefix

{!!
<FS>TImageEnIO.ProxyAddress

<FM>Declaration<FC>
property ProxyAddress:WideString;

<FM>Description<FN>
ProxyAddress specifies the proxy address and port when using <A TImageEnIO.LoadFromURL> method. The syntax is: 'domain:port'.

<FM>Example<FC>
ImageEnIO.ProxyAddress:='10.2.7.2:8080';
ImageEnIO.LoadFromURL('http://www.hicomponents.com/image.jpg');
!!}
    property ProxyAddress: WideString read fProxyAddress write fProxyAddress;

{!!
<FS>TImageEnIO.ProxyUser

<FM>Declaration<FC>
property ProxyUser:WideString;

<FM>Description<FN>
ProxyUser specifies the proxy userid when using <A TImageEnIO.LoadFromURL> method.

<FM>Example<FC>
ImageEnIO.ProxyAddress:='10.2.7.2:8080';
ImageEnIO.ProxyUser:='testuser';
ImageEnIO.ProxyPassword:='testpassword';
ImageEnIO.LoadFromURL('http://www.hicomponents.com/image.jpg');
!!}
    property ProxyUser: WideString read fProxyUser write fProxyUser;

{!!
<FS>TImageEnIO.ProxyPassword

<FM>Declaration<FC>
property ProxyPassword:WideString;

<FM>Description<FN>
ProxyPassword specifies the proxy password when using <A TImageEnIO.LoadFromURL> method.

<FM>Example<FC>
ImageEnIO.ProxyAddress:='10.2.7.2:8080';
ImageEnIO.ProxyUser:='testuser';
ImageEnIO.ProxyPassword:='testpassword';
ImageEnIO.LoadFromURL('http://www.hicomponents.com/image.jpg');
!!}
    property ProxyPassword: WideString read fProxyPassword write fProxyPassword;

    //
    property ResetPrinter: boolean read fResetPrinter write fResetPrinter;
    property PrintLogFile: String read GetPrintLogFile write SetPrintLogFile;
  published
    property AttachedImageEn: TIEView read fImageEnView write SetAttachedImageEn;
    property Background: TColor read GetReBackground write SetReBackground default clBlack;

{!!
<FS>TImageEnIO.OnProgress

<FM>Declaration<FC>
property OnProgress: <A TIEProgressEvent>;

<FM>Description<FN>
OnProgress event is called on input/output operations.
!!}
    property OnProgress: TIEProgressEvent read fOnProgress write fOnProgress;

{!!
<FS>TImageEnIO.MsgLanguage

<FM>Declaration<FC>
property MsgLanguage: <A TMsgLanguage>;

<FM>Description<FN>
This property sets the language for Input/output previews (<A TImageEnIO.DoPreviews>) and print dialogs (<A TImageEnIO.DoPrintPreviewDialog>).

<FM>Example<FC>

ImageEnView1.IO.MsgLanguage:=msEnglish;  // This is the default
!!}
    property MsgLanguage: TMsgLanguage read fMsgLanguage write fMsgLanguage default msSystem;

    property PreviewsParams: TIOPreviewsParams read GetIOPreviewParams write SetIOPreviewParams default [];

{!!
<FS>TImageEnIO.StreamHeaders

<FM>Declaration<FC>
property StreamHeaders: boolean;

<FM>Description<FN>
If True, each SaveToStreamXXX method adds an additional special header as needed for multi-image streams.
When a special header is added, the images saved with SaveToStreamXXX aren't compatible with LoadFromFileXXXX methods.

<FM>Example<FC>

// Saves ImageEnView1 and ImageEnView2 images in file images.dat
// images.dat isn't loadable with LoadFromFileXXX methods
var
  fs:TFileStream;
Begin
  fs:=TFileStream.Create('bmpimages.dat',fmCreate);
  ImageEnView1.IO.StreamHeaders:=True;
  ImageEnView1.IO.SaveToStreamJPEG(fs);
  ImageEnView2.IO.StreamHeaders:=True;
  ImageEnView2.IO.SaveToStreamJPEG(fs);
  fs.free;
End;

// Saves a single image in image.jpg
// image.jpg is loadable with LoadFromFileXXX methods
var
  fs.TFileStream;
Begin
  fs:=TFileStream.Create('image.jpg');
  ImageEnView1.IO.StreamHeaders:=False;
  ImageEnView1.IO.SaveToFileJPEG(fs);
End;
!!}
    property StreamHeaders: boolean read fStreamHeaders write fStreamHeaders default false;

    property PreviewFont: TFont read fPreviewFont write SetPreviewFont;
    property AttachedTImage: TImage read fTImage write SetTImage;

{!!
<FS>TImageEnIO.OnIOPreview

<FM>Declaration<FC>
property OnIOPreview:<A TIEIOPreviewEvent>;

<FM>Description<FN>
The OnIOPreview event is called before the preview form is displayed (running <A TImageEnIO.DoPreviews> method).

<FM>Example<FC>

procedure TForm1.ImageEnIO1IOPreview(Sender: TObject; PreviewForm:TForm);
begin
  with (PreviewForm as TfIOPreviews) do begin
    ProgressBar1.Visible:=False;
  end;
end;
!!}
    property OnIOPreview: TIEIOPreviewEvent read fOnIOPreview write fOnIOPreview;

{!!
<FS>TImageEnIO.DialogsMeasureUnit

<FM>Declaration<FC>
property DialogsMeasureUnit:<A TIEDialogsMeasureUnit>

<FM>Description<FN>
The DialogsMeasureUnit property specifies the measurement unit used in the print preview dialog (see <A TImageEnIO.DoPrintPreviewDialog>).

<FM>Example<FC>

ImageEnView1.IO.DialogsMeasureUnit:=ieduCm;
ImageEnView1.IO.DoPrintPreviewDialog(iedtDialog);
!!}
    property DialogsMeasureUnit: TIEDialogsMeasureUnit read fDialogsMeasureUnit write fDialogsMeasureUnit default ieduInches;

{!!
<FS>TImageEnIO.AutoAdjustDPI

<FM>Declaration<FC>
property AutoAdjustDPI:boolean;

<FM>Description<FN>
When AutoAdjustDPI is True and last loaded/scanned image has horizontal DPI not equal to vertical DPI, ImageEn resizes the image making DPIX=DPIY.

The default is False.
!!}
    property AutoAdjustDPI: boolean read fAutoAdjustDPI write fAutoAdjustDPI default False;

{!!
<FS>TImageEnIO.FilteredAdjustDPI

<FM>Declaration<FC>
property FilteredAdjustDPI:boolean;

<FM>Description<FN>
This property is valid when AutoAdjustDPI is True. If set to True, ImageEn applies a resampling filter to the image to ehnance quality.
It can slow down the loading process.
!!}
    property FilteredAdjustDPI: boolean read fFilteredAdjustDPI write fFilteredAdjustDPI default false;

{!!
<FS>TImageEnIO.OnFinishWork

TImageEnMView component

<FM>Declaration<FC>
property OnFinishWork:TNotifyEvent;

<FM>Description<FN>
OnFinishWork occurs when an input/output task ends. It is useful for resetting progress bars, or to know when a thread ends in a asynchronous mode.
!!}
    property OnFinishWork: TNotifyEvent read fOnFinishWork write fOnFinishWork;

{!!
<FS>TImageEnIO.OnAcquireBitmap

<FM>Declaration<FC>
property OnAcquireBitmap:<A TIEAcquireBitmapEvent>;

<FM>Description<FN>
This event occurs whenever a new bitmap is acquired from multipage TWain acquisition.
!!}
    property OnAcquireBitmap: TIEAcquireBitmapEvent read fOnAcquireBitmap write fOnAcquireBitmap;

{!!
<FS>TImageEnIO.SimplifiedParamsDialogs

<FM>Declaration<FC>
property SimplifiedParamsDialogs:boolean;

<FM>Description<FN>
If the SimplifiedParamsDialogs property is True (the default), the 'Advanced' button of open/save dialogs will show a simplified set of parameters.
Warning: the default is True, to allow old style "advanced" dialogs set it to False.

<FM>Example<FN>
This shows the 'Advanced' dialog for TIFF, using SimplifiedParamsDialogs=True:
<IMG help_images\68.bmp>

This show the 'Advanced' dialog for TIFF, using SimplifiedParamsDialogs=False:
<IMG help_images\69.bmp>
!!}
    property SimplifiedParamsDialogs: boolean read fSimplifiedParamsDialogs write fSimplifiedParamsDialogs default true;

{!!
<FS>TImageEnIO.OnDoPreviews

<FM>Declaration<FC>
property OnDoPreviews:<A TIEDoPreviewsEvent>;

<FM>Description<FN>
OnDoPreviews occurs just before the default dialog box (Advanced button in save dialog) shows.
You can disable the dialog box by just setting Handled to true.
!!}
    property OnDoPreviews: TIEDoPreviewsEvent read fOnDoPreviews write fOnDoPreviews;

    property NativePixelFormat: boolean read GetNativePixelFormat write SetNativePixelFormat default false;
  end;

// TImageEnIO
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////


procedure IEInitialize_imageenio;
procedure IEFinalize_imageenio;


function IsKnownFormat(const FileName: WideString): boolean;
function FindFileFormat(const FileName: WideString; VerifyExtension: boolean = false): TIOFileType;
function FindStreamFormat(Stream: TStream): TIOFileType;
function DeleteGIFIm(const FileName: WideString; idx: integer): integer;
procedure DeleteDCXIm(const FileName: WideString; idx: integer);
function DeleteTIFFIm(const FileName: WideString; idx: integer): integer;
function DeleteTIFFImGroup(const FileName: WideString; Indexes: array of integer): integer;
function EnumGIFIm(const FileName: WideString): integer;
function EnumTIFFIm(const FileName: WideString): integer;
function EnumTIFFStream(Stream: TStream): integer;
function EnumICOIm(const FileName: WideString): integer;
function EnumDCXIm(const FileName: WideString): integer;
function CheckAniGIF(const FileName: WideString): boolean;
procedure IEWriteICOImages(const fileName: WideString; images: array of TObject);
function JpegLosslessTransform(const SourceFile, DestFile: WideString; Transform: TIEJpegTransform; GrayScale: boolean; CopyMarkers: TIEJpegCopyMarkers; CutRect: TRect; UpdateEXIF:boolean=false): boolean; overload;
function JpegLosslessTransform(const SourceFile, DestFile: WideString; Transform: TIEJpegTransform): boolean; overload;
function JpegLosslessTransform2(const FileName: WideString; Transform: TIEJpegTransform; GrayScale: boolean; CopyMarkers: TIEJpegCopyMarkers; CutRect: TRect; UpdateEXIF:boolean=false): boolean;
function JpegLosslessTransformStream(SourceStream, DestStream: TStream; Transform: TIEJpegTransform; GrayScale: boolean; CopyMarkers: TIEJpegCopyMarkers; CutRect: TRect; UpdateEXIF:boolean=false): boolean;
procedure ExtractTIFFImageStream(SourceStream, OutStream: TStream; idx: integer);
procedure ExtractTIFFImageFile(const SourceFileName, OutFileName: WideString; idx: integer);
procedure InsertTIFFImageStream(SourceStream, InsertingStream, OutStream: TStream; idx: integer);
procedure InsertTIFFImageFile(const SourceFileName, InsertingFileName, OutFileName: WideString; idx: integer);
function IEAdjustDPI(bmp: TIEBitmap; Params: TIOParamsVals; FilteredAdjustDPI: boolean): TIEBitmap;
function IEGetFileFramesCount(const FileName:WideString):integer;
function IEFindNumberWithKnownFormat( const Directory: WideString ): integer;
function IEAVISelectCodec:AnsiString;

function IEAVIGetCodecs:TStringList;
function IEAVIGetCodecsDescription:TStringList;

procedure IEPrintLogWrite(const ss: String);

function IEGetFromURL(const URL:WideString; OutStream:TStream; const ProxyAddress:WideString; const ProxyUser:WideString; const ProxyPassword:WideString; OnProgress: TIEProgressEvent; Sender: TObject; Aborting:pboolean; var FileExt:string):boolean;



type

{!!
<FS>TIEReadImageStream

<FM>Declaration<FC>
TIEReadImageStream = procedure(Stream: TStream; Bitmap: <A TIEBitmap>; var IOParams: <A TIOParamsVals>; var Progress: <A TProgressRec>; Preview: boolean);
!!}
TIEReadImageStream = procedure(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec; Preview: boolean);


{!!
<FS>TIEWriteImageStream

<FM>Declaration<FC>
TIEWriteImageStream = procedure(Stream: TStream; Bitmap: <A TIEBitmap>; var IOParams: <A TIOParamsVals>; var Progress: <A TProgressRec>);
!!}
TIEWriteImageStream = procedure(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec);

{!!
<FS>TIETryImageStream

<FM>Declaration<FC>
TIETryImageStream = function(Stream: TStream; TryingFormat:<A TIOFileType>): boolean;
!!}
TIETryImageStream = function(Stream: TStream; TryingFormat:TIOFileType): boolean;


{!!
<FS>TIEFileFormatInfo

<FM>Declarations<FC>
TIEFileFormatInfo=class
    FileType:<A TIOFileType>;
    FullName: string;               // ie'JPEG Bitmap'
    Extensions: string;             // extensions without '.' ex 'jpg' (ex 'jpg;jpeg;jpe')
    InternalFormat:boolean;
    DialogPage: <A TPreviewParams>;
    ReadFunction: <A TIEReadImageStream>;   // Read image function
    WriteFunction: <A TIEWriteImageStream>; // Write image function
    TryFunction: <A TIETryImageStream>;     // Detect image function
end;
!!}
  TIEFileFormatInfo = class
    FileType: TIOFileType;
    FullName: string;       // ex 'JPEG Bitmap'
    Extensions: string;     // extensions without '.' ex 'jpg' (ex 'jpg;jpeg;jpe')
    InternalFormat:boolean;
    DialogPage: TPreviewParams;
    ReadFunction: TIEReadImageStream;
    WriteFunction: TIEWriteImageStream;
    TryFunction: TIETryImageStream;
  end;


// custom file formats registration functions
function IEFileFormatGetInfo(FileType: TIOFileType): TIEFileFormatInfo;
function IEFileFormatGetInfo2(Extension: string): TIEFileFormatInfo;
function IEFileFormatGetExt(FileType: TIOFileType; idx: integer): string;
function IEFileFormatGetExtCount(FileType: TIOFileType): integer;
procedure IEFileFormatAdd(FileFormatInfo: TIEFileFormatInfo);
procedure IEFileFormatRemove(FileType: TIOFileType);

function IEExtToFileFormat(ex:string): TIOFileType;

function IEIsInternalFormat(ex:string):boolean;

// external dll plugins
function IEAddExtIOPlugin(const FileName:string):integer;
function IEIsExtIOPluginLoaded(const FileName:string):boolean;

// others
procedure IEUpdateGIFStatus;

function IECalcJpegFileQuality(const FileName: WideString): integer;

function IECalcJpegStreamQuality(Stream: TStream): integer;
procedure IEOptimizeGIF(const InputFile,OutputFile:WideString);

type

{!!
<FS>TIEColorSpace

<FM>Declaration<FC>
}
  TIEColorSpace = (iecmsRGB, iecmsBGR, iecmsCMYK, iecmsCMYK6, iecmsCIELab, iecmsGray8, iecmsRGB48, iecmsRGB48_SE, iecmsYCBCR);
{!!}

{!!
<FS>TIEConvertColorFunction

<FM>Declaration<FC>
TIEConvertColorFunction = procedure(InputScanline: pointer; InputColorSpace: <A TIEColorSpace>; OutputScanline: pointer; OutputColorSpace: <A TIEColorSpace>; ImageWidth: integer; IOParams:<A TIOParamsVals>);

<FM>Description<FN>
Specifies the function used to convert from a color space to another.
!!}
  TIEConvertColorFunction = procedure(InputScanline: pointer; InputColorSpace: TIEColorSpace; OutputScanline: pointer; OutputColorSpace: TIEColorSpace; ImageWidth: integer; IOParams:TIOParamsVals);

var

  DefGIF_LZWDECOMPFUNC: TGIFLZWDecompFunc;
  DefGIF_LZWCOMPFUNC: TGIFLZWCompFunc;
  DefTIFF_LZWDECOMPFUNC: TTIFFLZWDecompFunc;
  DefTIFF_LZWCOMPFUNC: TTIFFLZWCompFunc;

  iegFileFormats: TList;


{!!
<FS>iegUseCMYKProfile

<FM>Declaration<FC>
iegUseCMYKProfile:boolean;

<FM>Description<FN>
When true ImageEn uses an internal ICC profile to convert from CMYK to RGB and viceversa.
!!}
  iegUseCMYKProfile:boolean;

{!!
<FS>iegUseDefaultFileExists

<FM>Declaration<FC>
iegUseDefaultFileExists:boolean;

<FM>Description<FN>
When true (default is false since version 3.0.3) ImageEn uses FileExists function. Otherwise uses an different way which doesn't need "listing" Windows rights.
!!}
  iegUseDefaultFileExists:boolean;

{!!
<FS>iegMaxImageEMFSize

<FM>Declaration<FC>
iegMaxImageEMFSize:integer;

<FM>Description<FN>
Specifies the maximum width or height of imported EMF/WMF image.

<FM>Example<FC>
// we want maximum 1024x??? imported image
iegMaxImageEMFSize:=1024;
ImageEnView1.IO.LoadFromFile('input.wmf');
!!}
  iegMaxImageEMFSize:integer;

{!!
<FS>DefTEMPPATH

<FM>Declaration<FC>
DefTEMPPATH: string;

<FM>Description<FN>
The DefTEMPPATH global variable specifies the directory where ImageEn stores temporary files.
The default value (empty string) is equal to default system temporary directory.

Applications should set DefTEMPPATH inside 'initialization' block, before that the ImageEn components are created.
For <A TImageEnMView> component, you can change DefTEMPPATH at any time, just call after the <A TImageEnMView.Clear> method.

<FM>Example<FC>

Initialization
  DefTEMPPATH:='g:\temp';

  ...or...

// this set ImageEnMView1 to disk G and ImageEnMView2 to disk H:
DefTEMPPATH:='g:\';
ImageEnMView1.Clear;
DefTEMPPATH:='h:\';
ImageEnMView2.Clear;
!!}
  DefTEMPPATH: string;

{$IFDEF IEINCLUDETWAIN}
  iegTWainLogName: string;
  iegTWainLogFile: textfile;
{$ENDIF}

{!!
<FS>IEConvertColorFunction

<FM>Declaration<FC>
IEConvertColorFunction: <A TIEConvertColorFunction>;

<FM>Description<FN>
Specifies the function used to convert from a color space to another.
!!}
  IEConvertColorFunction: TIEConvertColorFunction;

{!!
<FS>iegEnableCMS

<FM>Declaration<FC>
iegEnableCMS: boolean;

<FM>Description<FN>
Enables a Color Management System. Default CMS is provided by Windows.
Default values is <FC>false<FN>: this means that no color profile is applied.
Look at <A The Color Management System>.
!!}
  iegEnableCMS: boolean;

{!!
<FS>iegColorReductionAlgorithm

<FM>Declaration<FC>
iegColorReductionAlgorithm:integer;

<FM>Description<FN>
Specifies the algorithm used when converting from true color (24 bit) to color mapped images.
Color reduction algorithm are used, for example, when you save to a GIF.
-1 = automatically select (default)
0 = Kohonen algorithm (look also <A iegColorReductionQuality>)
1 = Median cut
!!}
  iegColorReductionAlgorithm:integer;

{!!
<FS>iegColorReductionQuality

<FM>Declaration<FC>
iegColorReductionQuality:integer;

<FM>Description<FN>
When <A iegColorReductionAlgorithm> is 0, this field specifies the quality. 0=minimum quality, 100=maximum quality.
-1 means "automatically calcualted" (default)
!!}
  iegColorReductionQuality:integer;

{!!
<FS>iegObjectsTIFFTag

<FM>Declaration<FC>
iegObjectsTIFFTag:integer;

<FM>Description<FN>
Specifies the TIFF tag used to read/write embedded vectorial objects. The default value is 40101.
!!}
  iegObjectsTIFFTag:integer;


  iegPrintLogFileName: String;
  iegPrintLogFile: textfile;


{!!
<FS>iegUseRelativeStreams

<FM>Declaration<FC>
iegUseRelativeStreams:boolean;

<FM>Description<FN>
For default ImageEn uses absolute streams. This means that the image must be contained from position zero of the stream.
Setting iegUseRelativeStreams=true, you can put the image in any offset of the stream.
Default is False.
!!}
  iegUseRelativeStreams:boolean;

function IECMYK2RGB(cmyk: TCMYK): TRGB;
function IERGB2CMYK(const rgb: TRGB): TCMYK;
procedure IEDefaultConvertColorFunction(InputScanline: pointer; InputColorSpace: TIEColorSpace; OutputScanline: pointer; OutputColorSpace: TIEColorSpace; ImageWidth: integer; IOParams: TIOParamsVals);

implementation

uses giffilter, PCXFilter, imscan, tiffilt, jpegfilt, BMPFilt, IOPreviews,
  pngfilt, pngfiltw, neurquant, ietgafil, IEMIO, IEMView, IEOpenSaveDlg, ieprnform1, ieprnform2, IEVfw, iej2000, iepsd, iewic, giflzw, tiflzw, ielcms,
  ieraw, imageenview, ievect, iedicom, iezlib;

{$R-}



{!!
<FS>TImageEnIO.Create

<FM>Declaration<FC>
constructor Create(Owner: TComponent);

<FM>Description<FN>
Creates a new instance. You can set Owner=nil to create a component without owner.
!!}
constructor TImageEnIO.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  fIEBitmap := TIEBitmap.Create;
  fIEBitmapCreated := true; // we create fIEBitmap
  InitializeCriticalSection(fAsyncThreadsCS);
  fImageEnViewBitmapChangeHandle := nil;
  fOnIOPreview := nil;
  fStreamHeaders := false;
  fParams := TIOParamsVals.Create(self);
{$IFDEF IEINCLUDETWAIN}
  fTWainParams := TIETWainParams.Create(Self);
{$ENDIF}
  (*$ifdef IEINCLUDESANE*)
  fSANEParams := TIESANEParams.Create(Self);
  (*$endif*)
  fBitmap := nil;
  fImageEnView := nil;
  fTImage := nil;
  fBackground := clBlack;
  fOnIntProgress := DoIntProgress;
  fOnProgress:=nil;
  fOnFinishWork := nil;
  fPreviewsParams := [];
  fPreviewFont := TFont.Create;
  fMsgLanguage := msSystem;
  fAborting := false;
  fDialogsMeasureUnit := ieduInches;
  fAutoAdjustDPI := False;
  fFilteredAdjustDPI := false;
  fAVI_avf := nil;
  fAVI_avs := nil;
  fAVI_avs1 := nil;
  fAVI_gf := nil;
  {$ifdef IEINCLUDEDIRECTSHOW}
  fOpenMediaFile:=nil;
  {$endif}
  fAsyncThreads := TList.Create;
  fAsyncThreadsFinishEvent := Windows.CreateEvent(nil, false, false, nil);
  fAsyncMode := false;
  fPrintingFilterOnSubsampling := rfFastLinear;
  fgrec := nil;
  fOnAcquireBitmap := nil;
  SimplifiedParamsDialogs := true;
  fOnDoPreviews := nil;
  fChangeBackground := false;
  ProxyAddress := '';
  ProxyUser := '';
  ProxyPassword := '';
  fDefaultDitherMethod := ieThreshold;
  fResetPrinter := true;
  fPS_handle := nil;
  fPS_stream := nil;
  fPDF_handle := nil;
  fPDF_stream := nil;
{$IFDEF IEINCLUDEWIA}
  fWIA := nil;
{$ENDIF}
{$IFDEF IEINCLUDEDIRECTSHOW}
  fDShow := nil;
{$ENDIF}
  {$IFDEF IEINCLUDEPRINTDIALOGS}
  fPrintPreviewParams:=TIOPrintPreviewParams.Create;
  {$ENDIF}
end;

{!!
<FS>TImageEnIO.CreateFromBitmap

<FM>Declaration<FC>
constructor CreateFromBitmap(Bitmap:TIEBitmap);
constructor CreateFromBitmap(Bitmap:TBitmap);

<FM>Description<FN>
Creates a new instance assigning property <A TImageEnIO.AttachedIEBitmap> or <A TImageEnIO.AttachedBitmap>.

<FM>Example<FC>
with TImageEnIO.CreateFromBitmap(myBitmap) do
begin
  LoadFromFile('input.jpg');
  Free;
end;
!!}
constructor TImageEnIO.CreateFromBitmap(Bitmap:TIEBitmap);
begin
  Create(nil);
  AttachedIEBitmap := Bitmap;
end;

constructor TImageEnIO.CreateFromBitmap(Bitmap:TBitmap);
begin
  Create(nil);
  AttachedBitmap := Bitmap;
end;

procedure TImageEnIO.SetNativePixelFormat(value:boolean);
begin
  if assigned(fParams) then
    fParams.IsNativePixelFormat:=value;
end;

{!!
<FS>TImageEnIO.NativePixelFormat

<FM>Declaration<FC>
property NativePixelFormat:boolean;

<FM>Description<FN>
By setting this property to True, you disable the conversion of paletted images, gray scale and all other formats to 24 bit or 1 bit.
By default, ImageEn converts all paletted, gray scale images and other formats to 24 bit (true color). Only black/white images are stored in the original format with 1 bit per pixel.
<A TImageEnView.LegacyBitmap> must be False.

Note that setting <FC>NativePixelFormat=True<FN>, you will not be able to execute some image processing operations.

For example, if you have a 16 bit gray scale TIFF and you want to work with 16 bit gray scale pixels, you have to write this before load the image:<FC>
ImageEnView1.LegacyBitmap:=False;	// do not use Tbitmap
ImageEnView1.IO.NativePixelFormat:=true; // leave original pixel format

<FN>Now you can read pixels using:<FC>
word = ImageEnView1.IEBitmap. Pixels_ie16g[x,y];
!!}
function TImageEnIO.GetNativePixelFormat:boolean;
begin
  if assigned(fParams) then
    result:=fParams.IsNativePixelFormat
  else
    result:=false;
end;

{!!
<FS>TImageEnIO.WaitThreads

<FM>Declaration<FC>
procedure WaitThreads(Aborts:boolean = false);

<FM>Description<FN>
WaitThreads waits until all threads complete. If <FC>Aborts<FN> is True, all threads will abort.

<FM>Example<FC>
ImageEnIO.LoadFromFile('input.jpg');
ImageEnIO.AsyncMode:=True;  // enables multithreading
ImageEnIO.SaveToFile('output1.jpg');  // save in thread 1
ImageEnIO.SaveToFile('output2.jpg');  // save in thread 2
ImageEnIO.WaitThreads(false);  // wait until all save threads terminate
!!}
procedure TImageEnIO.WaitThreads(Aborts:boolean);
var
  i:integer;
begin
  repeat
    EnterCriticalSection(fAsyncThreadsCS);
    if Aborts then
      fAborting := true;
    i := fAsyncThreads.Count;
    LeaveCriticalSection(fAsyncThreadsCS);
    if i = 0 then
      break;
    Windows.WaitForSingleObject(fAsyncThreadsFinishEvent, INFINITE);
  until false;
end;

procedure TImageEnIO.SuspendThreads; {$ifdef IEHASTTHREADSTART} deprecated; {$endif}
var
  i: integer;
begin
  EnterCriticalSection(fAsyncThreadsCS);
  try
    for i:=0 to fAsyncThreads.Count-1 do
    begin
      TThread(fAsyncThreads[i]).Suspend;
      while not TThread(fAsyncThreads[i]).Suspended do
        sleep(0); // give up the remainder of my current time slice
    end;
  finally
    LeaveCriticalSection(fAsyncThreadsCS);
  end;
end;

procedure TImageEnIO.ResumeThreads; {$ifdef IEHASTTHREADSTART} deprecated; {$endif}
var
  i: integer;
begin
  EnterCriticalSection(fAsyncThreadsCS);
  try
    for i:=0 to fAsyncThreads.Count-1 do
      if TThread(fAsyncThreads[i]).Suspended then
        TThread(fAsyncThreads[i]).Resume;
  finally
    LeaveCriticalSection(fAsyncThreadsCS);
  end;
end;

destructor TImageEnIO.Destroy;
begin
  // wait threads
  WaitThreads(false);
  FreeAndNil(fAsyncThreads);
  Windows.CloseHandle(fAsyncThreadsFinishEvent);
  //
  {$ifdef IEINCLUDEDIRECTSHOW}
  CloseMediaFile;
  {$endif}
  CloseAVIFile; // works only if AVI is not closed
  ClosePSFile;
  {$ifdef IEINCLUDEPDFWRITING}
  ClosePDFFile;
  {$endif}
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle);
  FreeAndNil(fParams);
{$IFDEF IEINCLUDETWAIN}
  FreeAndNil(fTWainParams);
{$ENDIF}
  {$ifdef IEINCLUDESANE}
  FreeAndNil(fSANEParams);
  {$endif}
  {$IFDEF IEINCLUDEPRINTDIALOGS}
  FreeAndNil(fPrintPreviewParams);
  {$ENDIF}
  FreeAndNil(fPreviewFont);
  if fIEBitmapCreated then
    FreeAndNil(fIEBitmap);
{$IFDEF IEINCLUDEWIA}
  if assigned(fWia) then
    FreeAndNil(fWia);
{$ENDIF}
{$IFDEF IEINCLUDEDIRECTSHOW}
  if assigned(fDShow) then
    FreeAndNil(fDShow);
{$ENDIF}

  DeleteCriticalSection(fAsyncThreadsCS);

  inherited;
end;

procedure TImageEnIO.RecreatedTImageEnViewHandle;
begin
  {$ifdef IEINCLUDEDIRECTSHOW}
  if assigned(fImageEnView) and assigned(fDShow) and (fDShow.NotifyWindow<>fImageEnView.Handle) then
    fDShow.SetNotifyWindow(fImageEnView.Handle, IEM_NEWFRAME, IEM_EVENT);
  {$endif}
end;


procedure TImageEnIO.SyncGetHandle;
begin
  if Assigned(fImageEnView) then
    fImageEnView.Handle;
end;


{!!
<FS>TImageEnIO.Update

<FM>Declaration<FC>
procedure Update;

<FM>Description<FN>
If TImageEnIO is attached to <A TImageEnView> (or inherited) object, Update calls relative Update method.
If TImageEnIO is attached to TBitmap object, Update sets Modified property to True.
!!}
procedure TImageEnIO.Update;
begin

  // remove alpha if attached to fBitmap
  if assigned(fBitmap) then
    fIEBitmap.RemoveAlphaChannel;

  if assigned(fImageEnView) then
  begin
    with fImageEnView do
    begin
      if IsInsideAsyncThreads then
      begin
        if Parent<>nil then
        begin
          {$ifdef IEHASTTHREADSTATICSYNCHRONIZE}
          if not HandleAllocated then // 3.0.2, to avoid deadlocks
            TThread.Synchronize(nil, SyncGetHandle); // 3.0.1, 15/7/2008 - 13:55
          {$endif}
          PostMessage(handle, IEM_UPDATE, 0, 0);
        end;
      end
      else
        Update;
      ImageChange;
    end;
  end
  else
  if assigned(fBitmap) then
    fBitmap.modified := true;

end;


// Get actual background color
function TImageEnIO.GetReBackground: TColor;
begin
  if assigned(fImageEnView) then
    result := fImageEnView.background
  else
    result := fBackground;
end;


{!!
<FS>TImageEnIO.Background

<FM>Declaration<FC>
property Background: TColor;

<FM>Description<FN>
This property sets the background color.
The background color is the color shown in unoccupied area when the current image is less of control size.

When TImageEnIO is attached to <A TImageEnView> the TImageEnIO.Background is equal to <A TImageEnView.Background>.
!!}
procedure TImageEnIO.SetReBackground(v: TColor);
begin
  if assigned(fImageEnView) then
  begin
{$IFDEF IEINCLUDEMULTIVIEW}
    if not (fImageEnView is TImageEnMView) then
{$ENDIF}
      if fChangeBackground then
        fImageEnView.background := v;
  end
  else
    fBackground := v;
end;

function TImageEnIO.IsInsideAsyncThreads: boolean;
var
  i: integer;
  ch: THandle;
begin
  result := false;
  ch := GetCurrentThreadId;
  try
    EnterCriticalSection(fAsyncThreadsCS);
    for i := 0 to fAsyncThreads.Count - 1 do
      if TIEIOThread(fAsyncThreads.Items[i]).ThreadId = ch then
      begin
        result := true;
        exit;
      end;
  finally
    LeaveCriticalSection(fAsyncThreadsCS);
  end;
end;

function TImageEnIO.MakeConsistentBitmap(allowedFormats: TIEPixelFormatSet): boolean;
begin
  result := false;
  if not assigned(fIEBitmap) then
    exit;
  if assigned(fBitmap) then
    fIEBitmap.EncapsulateTBitmap(fBitmap, false); // synchronize fBitmap with fIEBitmap
  if (not (allowedFormats = [])) and (not (fIEBitmap.PixelFormat in allowedFormats)) then
    exit;
  result := true;
end;

{!!
<FS>TImageEnIO.SaveToFileGif

<FM>Declaration<FC>
procedure SaveToFileGif(const FileName: WideString);

<FM>Description<FN>
SaveToFileGif saves the image in a GIF file (89a). The GIF will have a single image and it won't be marked as animated.

FileName is the file name with extension.


<FM>Example<FC>

// Saves an interlaced, 64 colour Gif.
ImageEnView1.IO.Params.GIF_Interlaced:=true;
ImageEnView1.IO.Params.BitsPerSample:=6;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
ImageEnView1.IO.SaveToFileGif('image.gif');
!!}
procedure TImageEnIO.SaveToFileGIF(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileGIF, FileName);
    exit;
  end;
  try
    fAborting := true;
    fs:=nil;
    try
      fs := TIEWideFileStream.Create(FileName, fmCreate);
      fAborting := false;
      Progress.Aborting := @fAborting;
      if not MakeConsistentBitmap([]) then
        exit;
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      WriteGIFStream(fs, fiebitmap, fParams, Progress);
      fParams.FileName:=FileName;
      fParams.FileType:=ioGIF;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.InsertToFileGif

<FM>Declaration<FC>
function InsertToFileGif(const FileName: WideString): integer;

<FM>Description<FN>
This function inserts a frame in a GIF file and makes it animated. The file must exist.

FileName is the file name with extension.

Returns the number of images inside the specified file.


<FM>Example<FC>

// Creates an animated gif with images contained in ImageEn1 and ImageEn2 components:
ImageEnView1.IO.SaveToFileGif('anim.gif');
ImageEnView2.IO.Params.GIF_ImageIndex:=1;
ImageEnView2.IO.InsertToFileGif('anim.gif');

!!}
function TImageEnIO.InsertToFileGIF(const FileName: WideString): integer;
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFileRetInt(self, InsertToFileGIF, FileName);
    result := -1;
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    result := 0;
    if not MakeConsistentBitmap([]) then
      exit;
    if fParams.GIF_WinWidth < (fiebitmap.width + fParams.GIF_XPos) then
      fParams.GIF_WinWidth := fiebitmap.width + fParams.GIF_XPos;
    if fParams.GIF_WinHeight < (fiebitmap.height + fParams.GIF_ypos) then
      fParams.GIF_WinHeight := fiebitmap.height + fParams.GIF_ypos;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    result := _InsertGIFIm(FileName, fIEBitmap, fParams, Progress);
    if not fAborting then
      _GIFMakeAnimate(string(FileName), 0, fParams.GIF_WinWidth, fParams.GIF_WinHeight); // makes it animated
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.InsertToFileTIFF

<FM>Declaration<FC>
function InsertToFileTIFF(const FileName: WideString): integer;

<FM>Description<FN>
Insert a frame in a TIFF file at position specified by <TIOParamsVals.ImageIndex>. The file must exist.

FileName is the file name with extension.
Returns the number of images inside the file.


<FM>Example<FC>

// Creates a multi-image TIFF
ImageEnView1.IO.SaveToFile('multi.tif');  // create with a single image
ImageEnView2.IO.Params.ImageIndex:=1;  // prepare to insert as second image
ImageEnView2.IO.InsertToFileTIFF('multi.tif');
!!}
function TImageEnIO.InsertToFileTIFF(const FileName: WideString): integer;
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFileRetInt(self, InsertToFileTIFF, FileName);
    result := -1;
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    result := 0;
    if not MakeConsistentBitmap([]) then
      exit;
    fs := nil;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fs := TIEWideFileStream.Create(FileName, fmOpenReadWrite);
      fAborting := false;
      result := TIFFWriteStream(fs, true, fIEBitmap, fParams, Progress);
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.InsertToStreamTIFF

<FM>Declaration<FC>
function InsertToStreamTIFF(Stream: TStream): integer;

<FM>Description<FN>
Insert a frame in a TIFF stream at position specified by <TIOParamsVals.ImageIndex>.. The stream position must be at the beginning.

Returns the number of images inside the file.

<FM>Example<FC>

ImageEnView1.IO.Params.ImageIndex:=1;  // prepare to insert as second image
ImageEnView1.IO.InsertToStreamTIFF(outstream);

!!}
function TImageEnIO.InsertToStreamTIFF(Stream: TStream): integer;
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStreamRetInt(self, InsertToStreamTIFF, Stream);
    result := -1;
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    result := 0;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fAborting := false;
    Stream.Position:=0;
    result := TIFFWriteStream(Stream, true, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;


// replace based on TIFF_ImageIndex

{!!
<FS>TImageEnIO.ReplaceFileTIFF

<FM>Declaration<FC>
function ReplaceFileTIFF(const FileName: WideString):integer;

<FM>Description<FN>
This function saves current image replacing to the specified multi-page TIFF file, replacing only the image at index specified with <A TImageEnIO.Params>.<A TIOParamsVals.TIFF_ImageIndex>.

<FM>Example<FC>
// We have a multipage tiff, named 'multipage.tif'.
// We want to change only the second page (index 1), making it negative.
ImageEnView1.IO.Params.TIFF_ImageIndex:=1;  // select page
ImageEnView1.IO.LoadFromFile('multipage.tif');
ImageEnView1.Proc.Negative;
ImageEnView1.IO.ReplaceFileTIFF('multipage.tif');

!!}
function TImageEnIO.ReplaceFileTIFF(const FileName: WideString): integer;
begin
  DeleteTIFFIm(FileName, fParams.TIFF_ImageIndex);
  result := InsertToFileTIFF(FileName);
end;

// replace based on GIF_ImageIndex

{!!
<FS>TImageEnIO.ReplaceFileGIF

<FM>Declaration<FC>
function ReplaceFileGIF(const FileName: WideString):integer;

<FM>Description<FN>
This function saves the current image in the specified multi-page GIF file, replacing only the image at the index specified with <A TImageEnIO.Params>.<A TIOParamsVals.GIF_ImageIndex>.

<FM>Example<FC>
// We have a multipage GIF, named 'multipage.gif'. 
// We want to change only the second page (index 1), making it negative.
ImageEnView1.IO.Params.GIF_ImageIndex:=1;  // select page
ImageEnView1.IO.LoadFromFile('multipage.gif');
ImageEnView1.Proc.Negative;
ImageEnView1.IO.ReplaceFileTIFF('multipage.gif');

!!}
function TImageEnIO.ReplaceFileGIF(const FileName: WideString): integer;
begin
  DeleteGIFIm(FileName, fParams.GIF_ImageIndex);
  result := InsertToFileGIF(FileName);
end;

{!!
<FS>DeleteGIFIm

<FM>Declaration<FC>
function DeleteGIFIm(const FileName: WideString; idx:integer):integer;

<FM>Description<FN>
Remove the idx (0 is first image) image from FileName file.

Returns the remaining number of frames that FileName file contains.
If the FileName doesn't exists or doesn't contains images return 0.
!!}
// Remove the image idx from the specified GIF
// returns the remaining images count
function DeleteGIFIm(const FileName: WideString; idx: integer): integer;
begin
  result := _DeleteGIFIm(FileName, idx, true);
end;

{!!
<FS>DeleteTIFFIm

<FM>Declaration<FC>
function DeleteTIFFIm(const FileName: WideString; idx:integer):integer;

<FM>Description<FN>
Remove the idx (0 is first image) image from FileName file.

Returns the remaining number of frames that FileName file contains.
If the FileName doesn't exists or doesn't contains images return 0.

!!}
// removes the image idx from the specified tiff
// returns the remained images
function DeleteTIFFIm(const FileName: WideString; idx: integer): integer;
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenReadWrite);
  try
    result := _DeleteTIFFImStream(fs, idx);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>DeleteDCXIm

<FM>Declaration<FC>
procedure DeleteDCXIm(const FileName: WideString; idx: integer);

<FM>Description<FN>
Remove the idx (0 is first image) image from FileName file.

If the FileName doesn't exists or doesn't contains images return 0.

<FM>See also<FN>

<A Helper functions>

!!}
procedure DeleteDCXIm(const FileName: WideString; idx: integer);
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenReadWrite);
  try
    IEDCXDeleteStream(fs,idx);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>DeleteTIFFImGroup

<FM>Declaration<FC>
function DeleteTIFFImGroup(const FileName: WideString; Indexes:array of integer):integer;

<FM>Description<FN>
DeleteTIFFImGroup removes the specified group of pages from the FileName file.
DeleteTIFFImGroup returns the remaining number of frames that FileName file contains.

Indexes is an array of page indexes to remove.
If the FileName doesn't exists or doesn't contains images return 0.

!!}
function DeleteTIFFImGroup(const FileName: WideString; Indexes: array of integer): integer;
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenReadWrite);
  try
    result := _DeleteTIFFImStreamGroup(fs, @Indexes, high(Indexes) + 1);
  finally
    FreeAndNil(fs);
  end;
end;

// Enumerates images in the specified GIF

{!!
<FS>EnumGIFIm

<FM>Declaration<FC>
function EnumGIFIm(const FileName: WideString):integer;

<FM>Description<FN>
Returns the number of frames (images) that FileName file contains.

A GIF could contain more images also if it is not marked as animated.
If the FileName doesn't exist or doesn't contain images, it returns a value of  0.

!!}
function EnumGIFIm(const FileName: WideString): integer;
begin
  try
    result := _DeleteGIFIm(FileName, -1, false);
  except
    result := 0;
  end;
end;

{!!
<FS>EnumTIFFIm

<FM>Declaration<FC>
function EnumTIFFIm(const FileName: WideString):integer;

<FM>Description<FN>
Returns the number of frames (images) that FileName file contains.

If the FileName doesn't exist or doesn't contain images, it returns a value of 0.

!!}
// Enumerates images in the specified TIFF
function EnumTIFFIm(const FileName: WideString): integer;
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := _EnumTIFFImStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>EnumDCXIm

<FM>Declaration<FC>
function EnumDCXIm(const FileName: WideString):integer;

<FM>Description<FN>
Returns the number of frames (images) that FileName file contains.

If the FileName doesn't exist or doesn't contain images, it returns a value of 0.

See also

<A Helper functions>

!!}
function EnumDCXIm(const FileName: WideString): integer;
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := IEDCXCountStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>EnumTIFFStream

<FM>Declaration<FC>
function EnumTIFFStream(Stream:TStream):integer;

<FM>Description<FN>
EnumTIFFStream returns the number of frames (images) that the TIFF Stream contains.
!!}
function EnumTIFFStream(Stream: TStream): integer;
begin
  result := _EnumTIFFImStream(Stream);
end;

{!!
<FS>EnumICOIm

<FM>Declaration<FC>
function EnumICOIm(const FileName: WideString):integer;

<FM>Description<FN>
EnumICOIm  returns the number of images inside an ICO file.
!!}
function EnumICOIm(const FileName: WideString): integer;
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := _EnumICOImStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>CheckAniGIF

<FM>Declaration<FC>
function CheckAniGIF(const FileName: WideString):boolean;

<FM>Description<FN>
Returns True if the GIF image FileName has the animated flag set ("NETSCAPE2.0" string).

If the file doesn't exist or if the image hasn't set the flag, it returns False.
!!}
// Returns True is the specified GIF is animated
function CheckAniGIF(const FileName: WideString): boolean;
begin
  try
    result := _CheckGIFAnimate(string(FileName));
  except
    result := false;
  end;
end;

{!!
<FS>TImageEnIO.SaveToFile

<FM>Declaration<FC>
procedure SaveToFile(const FileName: WideString);

<FM>Description<FN>
SaveToFile saves the current image to Jpeg, Jpeg2000, PNG, TIFF, BMP, WBMP, PS, PDF, PCX, DCX, TGA, PXM, ICO, HDP, GIF and all other supported formats.

SaveToFile detects file format from the extension of the specified file.
<FC>FileName<FN> is the file name with extension.


<FM>Example<FC>

ImageEnView1.IO.SaveToFile('rome.jpg');
ImageEnView1.IO.SaveToFile('florence.tif');
ImageEnView1.IO.SaveToFile('venice.gif');

// Saves a 16 color bitmap
ImageEnView1.IO.Params.BitsPerSample:=4;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
ImageEnView1.IO.SaveToFile('Italy.bmp');
!!}
procedure TImageEnIO.SaveToFile(const FileName: WideString);
var
  ex: string;
  fpi: TIEFileFormatInfo;
  fs: TIEWideFileStream;
  Progress: TProgressRec;
begin
  ex := string(IEExtractFileExtW(FileName));
  if FileName = '' then
    exit;
  if (ex = '.jpg') or (ex = '.jpeg') or (ex = '.jpe') or (ex='.jif') then
    SaveToFileJpeg(FileName)
{$IFDEF IEINCLUDEJPEG2000}
  else if (ex = '.jp2') then
    SaveToFileJP2(FileName)
  else if (ex = '.j2k') or (ex = '.jpc') or (ex = '.j2c') then
    SaveToFileJ2K(FileName)
{$ENDIF}
  else if ex = '.pcx' then
    SaveToFilePCX(FileName)
  else if ex = '.dcx' then
    SaveToFileDCX(FileName)
  else if ex = '.gif' then
    SaveToFileGIF(FileName)
  else if (ex = '.tif') or (ex = '.tiff') or (ex = '.fax') or (ex = '.g3f') or (ex = '.g3n') then
    SaveToFileTIFF(FileName)
{$IFDEF IEINCLUDEPNG}
  else if (ex = '.png') then
    SaveToFilePNG(FileName)
{$ENDIF}
  else if (ex = '.bmp') or (ex = '.dib') or (ex = '.rle') then
    SaveToFileBMP(FileName)
  else if (ex = '.tga') or (ex = '.targa') or (ex = '.vda') or (ex = '.icb') or (ex = '.vst') or (ex = '.win') then
    SaveToFileTGA(FileName)
  else if (ex = '.pxm') or (ex = '.pbm') or (ex = '.pgm') or (ex = '.ppm') then
    SaveToFilePXM(FileName)
  else if (ex = '.ico') then
    SaveToFileICO(FileName)
  else if (ex = '.wbmp') then
    SaveToFileWBMP(FileName)
  else if (ex = '.ps') or (ex = '.eps') then
    SaveToFilePS(FileName)
  {$ifdef IEINCLUDEPDFWRITING}
  else if (ex = '.pdf') then
    SaveToFilePDF(FileName)
  {$endif}
  {$ifdef IEINCLUDEPSD}
  else if (ex = '.psd') then
    SaveToFilePSD(FileName)
  {$endif}
  {$ifdef IEINCLUDEWIC}
  else if (ex = '.hdp') or (ex = '.wdp') then
    SaveToFileHDP(FileName)
  {$endif}
  else
  begin
    // try registered file formats
    fpi := IEFileFormatGetInfo2(ex);
    if assigned(fpi) and assigned(fpi.WriteFunction) then
      with fpi do
      begin
        if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
        begin
          TIEIOThread.CreateLoadSaveFile(self, SaveToFile, FileName);
          exit;
        end;
        try
          fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
          Progress.Aborting := @fAborting;
          if not MakeConsistentBitmap([]) then
            exit;
          if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
            fIEBitmap.PixelFormat := ie24RGB;
          fs := TIEWideFileStream.Create(FileName, fmCreate);
          fAborting := false;
          Progress.fOnProgress := fOnIntProgress;
          Progress.Sender := Self;
          fParams.fFileName := FileName;
          fParams.fFileType := FileType;
          try
            WriteFunction(fs, fIEBitmap, fParams, Progress);
          finally
            FreeAndNil(fs);
          end;
          fParams.FileName:=FileName;
          fParams.FileType:=fpi.FileType;
        finally
          DoFinishWork;
        end;
      end
    else
      fAborting := True;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamGif

<FM>Declaration<FC>
procedure SaveToStreamGif(Stream: TStream);

<FM>Description<FN>
SaveToStreamGif saves current image as GIF in the Stream.

If <A TImageEnIO.StreamHeaders> property is True, it adds an additional special header as needed for multi-image streams.

<FM>Example<FC>

// Saves ImageEnView1 and ImageEnView2 in file images.dat
// images.dat isn't loadable with LoadFromFileXXX methods
var
  fs:TFileStream;
Begin
  fs:=TFileStream.Create('bmpimages.dat',fmCreate);
  ImageEnView1.IO.StreamHeaders:=True;
  ImageEnView1.IO.SaveToStreamGIF(fs);
  ImageEnView2.IO.StreamHeaders:=True;
  ImageEnView2.IO.SaveToStreamGIF(fs);
  fs.free;
End;

// Saves a single image in image.gif
// image.gif is loadable with LoadFromFileXXX methods
var
  fs.TFileStream;
Begin
  fs:=TFileStream.Create('image.gif');
  ImageEnView1.IO.StreamHeaders:=False;
  ImageEnView1.IO.SaveToFileGIF(fs);
End;

!!}
procedure TImageEnIO.SaveToStreamGIF(Stream: TStream);
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamGIF, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    WriteGIFStream(Stream, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;

{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnIO.Acquire

<FM>Declaration<FC>
function Acquire(api:<A TIEAcquireApi>): boolean;

<FM>Description<FN>
The Acquire method performs image acquisition from Twain or WIA compatible scanners. Returns True if the acquisition has succeeded, False otherwise.
It is suggested to call <A TIOParamsVals.SetDefaultParams> before call Acquire to reset parameters if you have already loaded an image from file.

<FM>Example<FC>

ImageEnView1.IO.SelectAcquireSource; // select scanner source
ImageEnView1.IO.Acquire;  // scan image
ImageEnView1.IO.SaveToFile('newimage.jpg'); // save scanned image
!!}
function TImageEnIO.Acquire(api: TIEAcquireApi): boolean;
var
  Progress: TProgressRec;
begin
  // calling Acquire after AcquireOpen!!!!
  if assigned(fgrec) then
  begin
    result := true; // there is already a scanner dialog open
    exit;
  end;
  //
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateAcquire(self, Acquire, api);
    result := true;
    exit;
  end;
  try
    fAborting := false;
    result := false;
    Progress.Aborting := @fAborting;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    if not MakeConsistentBitmap([]) then
      exit;
    case api of
      ieaTWain:
        begin
          fTWainParams.LastError := 0;
          fTWainParams.LastErrorStr := '';
          if IETW_Acquire(fIEBitmap, false, nil, fTWainParams, fParams, Progress, @fTWainParams.TWainShared, IEFindHandle(self), NativePixelFormat) then
          begin
            result := true;
            if fAutoAdjustDPI then
              AdjustDPI;
            if assigned(fImageEnView) then
            begin
              fImageEnView.dpix := fParams.DpiX;
              fImageEnView.dpiy := fParams.DpiY;
            end;
          end;
          SetFocus(IEFindHandle(self));
        end;
      ieaWIA:
        begin
{$IFDEF iEINCLUDEWIA}
          WIAParams.ProcessingBitmap := fIEBitmap;
          result:=WIAParams.Transfer(nil, false);
{$ENDIF}
        end;
    end;
    Update;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnIO.SelectAcquireSource

<FM>Declaration<FC>
function SelectAcquireSource(api:<A TIEAcquireApi>):boolean;

<FM>Description<FN>
SelectAcquireSource shows a dialog where the user can select a Twain or WIA device.

Returns False if user press "Cancel" button.

<FM>Example<FC>

if ImageEn1.IO.SelectAcquireSource then
  ImageEn1.IO.Acquire;
!!}
function TImageEnIO.SelectAcquireSource(api: TIEAcquireApi): boolean;
var
  sn: AnsiString;
begin
  result := false;
  case api of
    ieaTWain:
      begin
        result := IETW_SelectImageSource(sn, @fTWainParams.TWainShared, IEFindHandle(self));
        fTWainParams.SelectSourceByName(sn);
      end;
    ieaWIA:
      begin
{$IFDEF IEINCLUDEWIA}
        result := WIAParams.ConnectToUsingDialog;
{$ENDIF}
      end;
  end;
end;
{$ENDIF}

function TImageEnIO.SyncLoadFromStreamGIF(Stream: TStream): integer;
var
  p1:int64;
  bmp, merged: TIEBitmap;
  numi, reqidx: integer;
  Progress, Progress2: TProgressRec;
  im: integer;
  tempAlphaChannel: TIEMask;
  dummy1: ppointerarray;
  dummy2, dummy3: pinteger;
  act: TIEGIFAction;
  backx, backy, backw, backh: integer;
  dx, dy: integer;
  OriginalPixelFormat:TIEPixelFormat;
begin
  result := 0;
  try
    fAborting := False;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;

    p1 := Stream.Position;
    im := 0;
    merged := TIEBitmap.Create;
    merged.Location := ieMemory;
    act := ioGIF_None;
    backw := 0;
    backh := 0;
    backx := 0;
    backy := 0;
    reqidx := fParams.GIF_ImageIndex;

    if reqidx>0 then
    begin
      Progress2.fOnProgress := nil;
      Progress2.Sender := nil;
      Progress2.Aborting := @fAborting;
    end
    else
      Progress2:=Progress;

    repeat
      bmp := TIEBitmap.Create;
      Stream.position := p1;
      fParams.GIF_ImageIndex := im;
      tempAlphaChannel := nil;
      ReadGIFStream(Stream, bmp, numi, fParams, Progress2, False, tempAlphaChannel, false);
      OriginalPixelFormat:=bmp.PixelFormat;
      CheckDPI;
      dx := imax(fParams.GIF_WinWidth, bmp.Width);
      dy := imax(fParams.GIF_WinHeight, bmp.Height);
      if assigned(tempAlphaChannel) then
      begin
        bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
        FreeAndNil(tempAlphaChannel);
      end;
      if numi > 1 then
      begin
        if act = ioGIF_DrawBackground then
        begin
          merged.FillRect(backx, backy, backx + backw - 1, backy + backh - 1, TRGB2TColor(fParams.GIF_Background));
          merged.AlphaChannel.FillRect(backx, backy, backx + backw - 1, backy + backh - 1, 0);
        end;
        if (merged.Width = 0) then
        begin
          merged.Allocate(dx, dy, ie24RGB);
          merged.Fill(TRGB2TColor(fParams.GIF_Background));
          merged.AlphaChannel.Fill(0);
        end;
        if merged.PixelFormat<>ie24RGB then
          merged.PixelFormat:=ie24RGB;
        if (dx > merged.Width) or (dy > merged.Height) then
          merged.Resize(dx, dy, TRGB2TColor(fparams.GIF_Background), 255, iehLeft, ievTop);
        dummy1 := nil;
        dummy2 := nil;
        dummy3 := nil;

        bmp.RenderToTIEBitmap(merged, dummy1, dummy2, dummy3, nil, fParams.GIF_XPos, fParams.GIF_YPos, bmp.Width, bmp.Height, 0, 0, bmp.Width, bmp.Height, true, false, 255, rfNone, true, ielNormal);

        bmp.MergeAlphaRectTo(merged, 0,0, fParams.GIF_XPos, fParams.GIF_YPos, bmp.Width,bmp.Height);
        merged.AlphaChannel.Full:=False;

        backw := bmp.Width;
        backh := bmp.Height;
        backx := fParams.GIF_XPos;
        backy := fParams.GIF_YPos;
        FreeAndNil(bmp);
        bmp := merged;
        act := fParams.GIF_Action; // act refers to the action of next image
        fParams.GIF_Action:=ioGIF_DrawBackground;
        fParams.GIF_XPos:=0;
        fParams.GIF_YPos:=0;
      end;
      //
      if fAborting then
      begin
        if bmp<>merged then
          FreeAndNil(bmp);
        break;
      end;
      if numi > 0 then
      begin
        Progress.per1 := 100 / numi;
        fIEBitmap.Assign(bmp);
        fIEBitmap.PixelFormat:=originalPixelFormat;
      end;
      if bmp <> merged then
        FreeAndNil(bmp)
      else
        bmp:=nil;
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * im));
      if fAborting then
        break;
      inc(im);
    until (im >= numi) or (im - 1 = reqidx);
    FreeAndNil(merged);
    fParams.GIF_ImageIndex := reqidx;
    result := numi;

    if fAutoAdjustDPI then
      AdjustDPI;
    if fParams.GIF_FlagTranspColor then
      BackGround := TRGB2TCOLOR(fParams.GIF_TranspColor)
    else
      BackGround := TRGB2TCOLOR(fParams.GIF_Background);

    fParams.FileType := ioGIF;
    fParams.fFileName := '';
    Update;
  finally
    DoFinishWork;
  end;
end;



{!!
<FS>TImageEnIO.LoadFromFileGIF

<FM>Declaration<FC>
function LoadFromFileGIF(const FileName: WideString): integer;

<FM>Description<FN>
LoadFromFileGIF loads an image from a GIF file (87a, 89a and animated GIF).

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.

Returns number of images contained in GIF file (number of frames if this is an animated GIFf).


<FM>Example<FC>

// Loads the third frame of an animated gif
ImageEnView1.IO.Params.GIF_ImageIndex:=2;
ImageEnView1.IO.LoadFromFileGIF('anim.gif');
!!}
// return remaining images
function TImageEnIO.LoadFromFileGIF(const FileName: WideString): integer;
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFileRetInt(self, LoadFromFileGIF, FileName);
    result := -1;
    exit;
  end;
  fs := TIEWideFileStream.create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := SyncLoadFromStreamGIF(fs);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;



{!!
<FS>TImageEnIO.LoadFromStreamGIF

<FM>Declaration<FC>
function LoadFromStreamGIF(Stream: TStream): integer;

<FM>Description<FN>
LoadFromStreamGIF loads an image from a stream.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
Returns number of images contained in the stream (number of frames if this is an animated stream).
If <A TImageEnIO.StreamHeaders> property is True, the stream must have a special header (saved using <A TImageEnIO.SaveToStreamGIF>).


<FM>Example<FC>

// loads a GIF file with LoadfFromStreamGIF
var fs:TFileStream;
Begin
  fs:=TFileStream.Create('myfile.gif',fmOpenRead);
  ImageEnView1.IO.LoadFromStreamGIF(fs);
  fs.free;
End;
!!}
// returns remaining images
function TImageEnIO.LoadFromStreamGIF(Stream: TStream): integer;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStreamRetInt(self, LoadFromStreamGIF, Stream);
    result := -1;
    exit;
  end;
  result := SyncLoadFromStreamGIF(Stream);
end;

{!!
<FS>TImageEnIO.LoadFromFileDCX

<FM>Declaration<FC>
procedure LoadFromFileDCX(const FileName: WideString);

<FM>Description<FN>
Loads a DCX file. FileName is the file name.
You can set the page to load using <A TImageEnIO.Params>.<A TIOParamsVals.DCX_ImageIndex> property.

<FM>Example<FC>

// I want the second page of 'input.dat' (which is a DCX file)
ImageEnView1.IO.Params.DCX_ImageIndex := 1;
ImageEnView1.IO.LoadFromFileDCX('input.dat');

!!}
procedure TImageEnIO.LoadFromFileDCX(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileDCX, FileName);
    exit;
  end;
  fs := TIEWideFileStream.create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamDCX(fs);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamDCX

<FM>Declaration<FC>
procedure LoadFromStreamDCX(Stream: TStream);

<FM>Description<FN>
Loads a DCX file from specified Stream.
You can set the page to load using <A TImageEnIO.Params>.<A TIOParamsVals.DCX_ImageIndex> property.

!!}
procedure TImageEnIO.LoadFromStreamDCX(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamDCX, Stream);
    exit;
  end;
  SyncLoadFromStreamDCX(Stream);
end;


procedure TImageEnIO.SyncLoadFromStreamDCX(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    IEDCXReadStream(Stream, fIEBitmap, fParams, Progress, false);
    CheckDPI;
    if fAutoAdjustDPI then
      AdjustDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioDCX;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    Update;
  finally
    DoFinishWork;
  end;
end;


procedure TImageEnIO.SyncLoadFromStreamPCX(Stream: TStream; streamhead: boolean);
var
  SHead: PCXSHead;
  lp1: int64;
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    lp1 := 0;
    if streamhead then
    begin
      // load header
      lp1 := Stream.position;
      Stream.Read(SHead, sizeof(PCXSHead));
      if IECopy(SHead.id, 1, 3) <> 'PCX' then
      begin
        fAborting := true;
        exit;
      end;
      if SHead.id <> 'PCX2' then
      begin
        Stream.position := lp1 + 4;
        SHead.dim := Stream.size;
      end;
    end
    else
      SHead.dim := Stream.size;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    ReadPcxStream(Stream, fIEBitmap, fParams, SHead.dim, Progress, false);
    CheckDPI;
    if fAutoAdjustDPI then
      AdjustDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioPCX;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    Update;
    if streamhead and (SHead.id = 'PCX2') then
      Stream.Position := lp1 + sizeof(SHead) + SHead.dim; // posiziona alla fine del blocco PCX
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamPCX

<FM>Declaration<FC>
procedure LoadFromStreamPCX(Stream: TStream);

<FM>Description<FN>
LoadFromStreamPCX loads the image from a PCX stream.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
If <A TImageEnIO.StreamHeaders> property is True, the stream must have a special header (saved using <A TImageEnIO.SaveToStreamPCX>).


<FM>Example<FC>

// loads a PCX file with LoadfFromStreamPCX
var fs:TFileStream;
Begin
  fs:=TFileStream.Create('myfile.pcx',fmOpenRead);
  ImageEnView1.IO.LoadFromStreamPCX(fs);
  fs.free;
End;

!!}
procedure TImageEnIO.LoadFromStreamPCX(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamPCX, Stream);
    exit;
  end;
  SyncLoadFromStreamPCX(Stream, fStreamHeaders);
end;

{!!
<FS>TImageEnIO.LoadFromFilePCX

<FM>Declaration<FC>
procedure LoadFromFilePCX(const FileName: WideString);

<FM>Description<FN>
LoadFromFilePCX loads the image from a PCX file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.


<FM>Example<FC>

ImageEnView1.IO.LoadFromFilePCX('alfa.pcx');

!!}
procedure TImageEnIO.LoadFromFilePCX(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFilePCX, FileName);
    exit;
  end;
  fs := TIEWideFileStream.create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamPCX(fs, false);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;

function TImageEnIO.SyncLoadFromStreamTIFF(Stream: TStream; streamhead: boolean): integer;
var
  SHead: TIFFSHead;
  Progress: TProgressRec;
  p0: int64;
  tmpAlphaChannel: TIEMask;
  BufStream:TIEBufferedReadStream;
begin
  BufStream:=TIEBufferedReadStream.Create(Stream,8192,iegUseRelativeStreams);
  fAborting := false;
  Progress.Aborting := @fAborting;
  try
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    p0 := 0;
    if streamhead then
    begin
      BufStream.read(SHead, sizeof(SHead));
      p0 := BufStream.Position;
      if SHead.id <> 'TIFF' then
      begin
        fAborting := true;
        result := 0;
        exit;
      end;
    end;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    tmpAlphaChannel := nil;
    TIFFReadStream(fIEBitmap, BufStream, result, fParams, Progress, false, tmpAlphaChannel, not streamhead, false, false);
    CheckDPI;
    if assigned(tmpAlphaChannel) then
    begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
    end;
    if fAutoAdjustDPI then
      AdjustDPI;
    if streamhead then
      BufStream.Position := p0 + SHead.dim;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    fParams.fFileName := '';
    fParams.fFileType := ioTIFF;
    Update;
  finally
    BufStream.Free;
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamTIFF

<FM>Declaration<FC>
function LoadFromStreamTIFF(Stream: TStream): integer;

<FM>Description<FN>
LoadFromStreamTIFF loads the image from a TIFF stream (rev. 6.0, Packbits, LZW, CCITT G.3 and G.4).

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
Returns number of images contained in the stream.
If <A TImageEnIO.StreamHeaders> property is True, the stream must have a special header (saved using <A TImageEnIO.SaveToStreamTIFF>).


<FM>Example<FC>

// loads a TIFF file with LoadfFromStreamTIFF
var fs:TFileStream;
Begin
  fs:=TFileStream.Create('myfile.tif',fmOpenRead);
  ImageEnView1.IO.LoadFromStreamTIFF(fs);
  fs.free;
End;

!!}
function TImageEnIO.LoadFromStreamTIFF(Stream: TStream): integer;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStreamRetInt(self, LoadFromStreamTIFF, Stream);
    result := -1;
    exit;
  end;
  result := SyncLoadFromStreamTIFF(Stream, fStreamHeaders);
end;

// returns remaining images

{!!
<FS>TImageEnIO.LoadFromFileTIFF

<FM>Declaration<FC>
function LoadFromFileTIFF(const FileName: WideString): integer;

<FM>Description<FN>
LoadFromFileTIFF loads an image from a TIFF file (rev. 6.0, Packbits, LZW, CCITT G.3 and G.4).

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.

Returns number of images contained in TIFF file.


<FM>Example<FC>

// loads the second image in the myimage.tif file
ImageEnView1.IO.Params.TIFF_ImageIndex:=1;
ImageEnView1.IO.LoadFromFileTIFF('myimage.tif');

!!}
function TImageEnIO.LoadFromFileTIFF(const FileName: WideString): integer;
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFileRetInt(self, LoadFromFileTIFF, FileName);
    result := -1;
    exit;
  end;
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := SyncLoadFromStreamTIFF(fs, false);
  finally
    FreeAndNil(fs);
  end;
  fParams.fFileName := FileName;
end;

{!!
<FS>TImageEnIO.LoadFromFileAuto

<FM>Declaration<FC>
procedure LoadFromFileAuto(const FileName: WideString); dynamic;

<FM>Description<FN>
LoadFromFileAuto loads an image from file. To detect file format it doesn't look at the file extension, but at the file content.
This method can load LYR (<A TImageEnView> layers), IEV (<A TImageEnVect> objects) and LYR+IEV formats when <A TImageEnIO.AttachedImageEn> is TImageEnView or TImageEnVect.

<FM>Example<FC>

ImageEnView1.IO.LoadFromFileAuto('input.dat');

ImageEnView1.IO.LoadFromFileAuto('input.tif'); // a tiff or a RAW?

!!}
procedure TImageEnIO.LoadFromFileAuto(const FileName: WideString);
var
  ff:TIOFileType;
begin
  ff := FindFileFormat(FileName, false);
  if ff=ioUnknown then
    LoadFromFile(FileName)
  else
    LoadFromFileFormat(FileName,ff);
end;

procedure TImageEnIO.LoadViewerFile(const fileName:WideString; ft:TIOFileType);
var
  r:TRect;
  tempIE:TImageEnVect;
begin
  case ft of
    ioIEV:
      begin
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
          with (fImageEnView as TImageEnVect) do
          begin
            LoadFromFileIEV(fileName);
            r:=ObjectsExtents;
            Proc.ImageResize(r.Right,r.Bottom);
            Proc.Fill(CreateRGB(255,255,255));
            AlphaChannel.Fill(0);
          end
        else
        begin
          // TImageEnView not associated, renderize image
          tempIE:=TImageEnVect.Create(nil);
          try
          tempIE.LegacyBitmap:=false;
          tempIE.LoadFromFileIEV(fileName);
          r:=tempIE.ObjectsExtents;
          tempIE.Proc.ImageResize(r.Right,r.Bottom);
          tempIE.Proc.Fill(CreateRGB(255,255,255));
          tempIE.CopyObjectsToBack();
          IEBitmap.Assign( tempIE.IEBitmap );
          finally
            tempIE.Free;
            DoFinishWork;
          end;
        end;
      end;
    ioLYR:
      begin
        if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
          (fImageEnView as TImageEnView).LayersLoadFromFile(fileName)
        else
        begin
          // TImageEnView not associated, renderize image
          tempIE:=TImageEnVect.Create(nil);
          try
          tempIE.LegacyBitmap:=false;
          tempIE.LayersLoadFromFile(fileName);
          tempIE.LayersMergeAll;
          IEBitmap.Assign( tempIE.IEBitmap );
          finally
            tempIE.Free;
            DoFinishWork;
          end;
        end;
      end;
    ioALL:
      begin
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
          (fImageEnView as TImageEnVect).LoadFromFileALL(string(fileName))
        else
        begin
          // TImageEnView not associated, renderize image
          tempIE:=TImageEnVect.Create(nil);
          try
          tempIE.LegacyBitmap:=false;
          tempIE.LoadFromFileALL(string(fileName));
          tempIE.LayersMergeAll;
          tempIE.CopyObjectsToBack();
          IEBitmap.Assign( tempIE.IEBitmap );
          finally
            tempIE.Free;
            DoFinishWork;
          end;
        end;
      end;
  end;
  Params.fFileType:=ft;
end;

procedure TImageEnIO.LoadViewerStream(Stream:TStream; ft:TIOFileType);
begin
  case ft of
    ioIEV:
      begin
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
          (fImageEnView as TImageEnVect).LoadFromStreamIEV(Stream);
      end;
    ioLYR:
      begin
        if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
          (fImageEnView as TImageEnView).LayersLoadFromStream(Stream);
      end;
    ioALL:
      begin
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
          (fImageEnView as TImageEnVect).LoadFromStreamALL(Stream);
      end;
  end;
  Params.fFileType:=ft;
end;


{!!
<FS>TImageEnIO.LoadFromFile

<FM>Declaration<FC>
procedure LoadFromFile(const FileName: WideString);

<FM>Description<FN>
LoadFromFile loads an image from the specified file. It recognizes the image format from the filename extension.
The source can be also an URL, if it has the form 'http://'.
This method can load LYR (<A TImageEnView> layers), IEV (<A TImageEnVect> objects) and LYR+IEV formats when <A TImageEnIO.AttachedImageEn> is TImageEnView or TImageEnVect.

LoadFromFile detects file format from the extension of the specified file.
If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be True.
<FC>FileName<FN> is the file name with extension.


<FM>Example<FC>

// loads the second image in the document.tif
ImageEnView1.IO.Params.TIFF_ImageIndex:=1;
ImageEnView1.IO.LoadFromFile('document.tif');

!!}
procedure TImageEnIO.LoadFromFile(const FileName: WideString);
var
  ex: string;
  fpi: TIEFileFormatInfo;
  fs: TIEWideFileStream;
  Progress: TProgressRec;
begin
  if not assigned(fIEBitmap) then
    exit;

  if FileName = '' then
  begin
    fAborting := True;
    DoFinishWork;
    exit;
  end;

  if IEGetURLTypeW(FileName)<>ieurlUNKNOWN then
  begin
    LoadFromURL(FileName);
    exit;
  end;

  ex := string(IEExtractFileExtW(FileName));

  if (ex = '.avi') then
  begin
    OpenAVIFile(FileName);
    if fAborting then
      exit;
    LoadFromAVI(fParams.fImageIndex);
    CloseAVIFile;
    Params.fFileName := FileName;
    Params.fFileType := ioAVI;
    exit;
  end;

  fpi := IEFileFormatGetInfo2(ex);
  if fpi=nil then
  begin
    fAborting := True;
    DoFinishWork;
    exit; // extension not recognized
  end;

  if fpi.InternalFormat then
    case fpi.FileType of
      ioJPEG: begin LoadFromFileJpeg(FileName); exit; end;
      {$IFDEF IEINCLUDEJPEG2000}
      ioJP2: begin LoadFromFileJP2(FileName); exit; end;
      ioJ2K: begin LoadFromFileJ2K(FileName); exit; end;
      {$ENDIF}
      {$IFDEF IEINCLUDEPNG}
      ioPNG: begin LoadFromFilePNG(FileName); exit; end;
      {$ENDIF}
      {$ifdef IEINCLUDEDICOM}
      ioDICOM: begin LoadFromFileDICOM(FileName); exit; end;
      {$endif}
      ioTIFF: begin LoadFromFileTIFF(FileName); exit; end;
      ioPCX: begin LoadFromFilePCX(FileName); exit; end;
      ioDCX: begin LoadFromFileDCX(FileName); exit; end;
      ioGIF: begin LoadFromFileGIF(FileName); exit; end;
      ioWMF,ioEMF: begin ImportMetaFile(FileName, -1, -1, true); exit; end;
      ioBMP: begin LoadFromFileBMP(FileName); exit; end;
      ioCUR: begin LoadFromFileCUR(FileName); exit; end;
      ioICO: begin LoadFromFileICO(FileName); exit; end;
      ioTGA: begin LoadFromFileTGA(FileName); exit; end;
      ioPXM: begin LoadFromFilePXM(FileName); exit; end;
      ioWBMP: begin LoadFromFileWBMP(FileName); exit; end;
      {$ifdef IEINCLUDERAWFORMATS}
      ioRAW: begin LoadFromFileRAW(FileName); exit; end;
      {$endif}
      {$ifdef IEINCLUDEPSD}
      ioPSD: begin LoadFromFilePSD(FileName); exit; end;
      {$endif}
      {$ifdef IEINCLUDEWIC}
      ioHDP: begin LoadFromFileHDP(FileName); exit; end;
      {$endif}
      ioIEV, ioLYR, ioALL: begin LoadViewerFile(FileName,fpi.FileType); exit; end;
    end;

  // try external formats
  Params.fFileName := '';
  Params.fFileType := ioUnknown;
  fParams.ResetInfo;
  if assigned(fpi.ReadFunction) then
    with fpi do
    begin
      // file format supported
      if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
      begin
        TIEIOThread.CreateLoadSaveFile(self, LoadFromFile, FileName);
        exit;
      end;
      fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
      Progress.Aborting := @fAborting;
      if not MakeConsistentBitmap([]) then
        exit;
      fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
      fAborting := false;
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fParams.fFileName := FileName;
      fParams.fFileType := FileType;
      try
        ReadFunction(fs, fIEBitmap, fParams, Progress, False);
      except
        fAborting := True;
      end;
      if not fAborting then
      begin
        if fAutoAdjustDPI then
          AdjustDPI;
        SetViewerDPI(fParams.DpiX, fParams.DpiY);
      end;
      update;
      FreeAndNil(fs);
      DoFinishWork;
      exit;
    end;

  // fail
  fAborting := True;
  DoFinishWork;
end;

{!!
<FS>TImageEnIO.LoadFromFileFormat

<FM>Declaration<FC>
procedure LoadFromFileFormat(const FileName: WideString; FileFormat:<A TIOFileType>);

<FM>Description<FN>
LoadFromFileFormat loads an image from file. LoadFromFileFormat detects the file format from FileFormat parameter.
This method can load LYR (<A TImageEnView> layers), IEV (<A TImageEnVect> objects) and LYR+IEV formats when <A TImageEnIO.AttachedImageEn> is TImageEnView or TImageEnVect.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name.

<FM>Example<FC>

// load ximage.dat as a Jpeg file
ImageEnView1.IO.LoadFromFileFormat('ximage.dat',ioJPEG)

// load layers and vectorial objects
ImageEnVect1.IO.LoadFromFileFormat('file.all',ioALL);

!!}
procedure TImageEnIO.LoadFromFileFormat(const FileName: WideString; FileFormat: TIOFileType);
var
  fpi: TIEFileFormatInfo;
  fs: TIEWideFileStream;
  Progress: TProgressRec;
begin

  fpi := IEFileFormatGetInfo(FileFormat);
  if fpi=nil then
    exit;

  if fpi.InternalFormat then
    case FileFormat of
      ioTIFF: LoadFromFileTIFF(FileName);
      ioGIF: LoadFromFileGIF(FileName);
      ioJPEG: LoadFromFileJpeg(FileName);
      ioPCX: LoadFromFilePCX(FileName);
      ioDCX: LoadFromFileDCX(FileName);
      ioBMP: LoadFromFileBMP(FileName);
      ioICO: LoadFromFileICO(FileName);
      ioCUR: LoadFromFileCUR(FileName);
  {$IFDEF IEINCLUDEPNG}
      ioPNG: LoadFromFilePNG(FileName);
  {$ENDIF}
  {$ifdef IEINCLUDEDICOM}
      ioDICOM: LoadFromFileDICOM(FileName);
  {$endif}
      ioWMF,ioEMF: ImportMetaFile(FileName, -1, -1, true);
      ioTGA: LoadFromFileTGA(FileName);
      ioPXM: LoadFromFilePXM(FileName);
      ioWBMP: LoadFromFIleWBMP(FileName);
  {$IFDEF IEINCLUDEJPEG2000}
      ioJP2: LoadFromFileJP2(FileName);
      ioJ2K: LoadFromFileJ2K(FileName);
  {$ENDIF}
  {$ifdef IEINCLUDERAWFORMATS}
      ioRAW: LoadFromFileRAW(FileName);
  {$endif}
      ioBMPRAW: LoadFromFileBMPRAW(FileName);
      {$ifdef IEINCLUDEPSD}
      ioPSD: LoadFromFilePSD(FileName);
      {$endif}
      {$ifdef IEINCLUDEWIC}
      ioHDP: LoadFromFileHDP(FileName);
      {$endif}
      ioIEV, ioLYR, ioALL: begin LoadViewerFile(FileName,FileFormat); exit; end;
      else
        LoadFromFile(FileName);
    end

  else
    begin
      fParams.ResetInfo;
      Params.fFileName := '';
      Params.fFileType := ioUnknown;
      // try registered file formats
      if assigned(fpi.ReadFunction) then
        with fpi do
        begin
          // file format supported
          if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
          begin
            TIEIOThread.CreateLoadSaveFileFormat(self, LoadFromFileFormat, FileName, FileFormat);
            exit;
          end;
          try
            fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
            Progress.Aborting := @fAborting;
            if not MakeConsistentBitmap([]) then
              exit;
            fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
            fAborting := false;
            try
              Progress.fOnProgress := fOnIntProgress;
              Progress.Sender := Self;
              fParams.fFileName := FileName;
              fParams.fFileType := FileType;
              ReadFunction(fs, fIEBitmap, fParams, Progress, False);
              if fAutoAdjustDPI then
                AdjustDPI;
              SetViewerDPI(fParams.DpiX, fParams.DpiY);
              update;
            finally
              FreeAndNil(fs);
            end;
          finally
            DoFinishWork;
          end;
        end
      else
      begin
        fAborting := True;
        DoFinishWork;
      end;
    end;
end;

procedure TImageEnIO.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = fImageEnView) and (Operation = opRemove) then
  begin
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle);
    fImageEnView := nil;
  end;
  if (AComponent = fTImage) and (Operation = opRemove) then
    fTImage := nil;
end;

procedure TImageEnIO.UpdateAPP138BimResolution;
type
  TPSDResolutionInfo=packed record
    hRes:longint;       // fixed point number: pixels per inch
    hResUnit:word;      // 1=pixels per inch, 2=pixels per centimeter
    WidthUnit:word;     // 1=in, 2=cm, 3=pt, 4=picas, 5=columns
    vRes:longint;       // fixed point number: pixels per inch
    vResUnit:word;      // 1=pixels per inch, 2=pixels per centimeter
    HeightUnit:word;    // 1=in, 2=cm, 3=pt, 4=picas, 5=columns
  end;
  PPSDResolutionInfo=^TPSDResolutionInfo;
var
  idx:integer;
  data:PAnsiChar;
  len:integer;
  p:integer;
  q:integer;
  ri:PPSDResolutionInfo;
begin
  idx:=fParams.JPEG_MarkerList.IndexOf( JPEG_APP13 );
  if idx>-1 then
  begin
    data:=fParams.JPEG_MarkerList.MarkerData[idx];
    len:=fParams.JPEG_MarkerList.MarkerLength[idx];
    for p:=0 to len-1 do
    begin
      if CompareMem(@data[p],PAnsiChar('8BIM'#3#237),6) then // 0x03 0xED (resolution identifier)
      begin
        inc(data,p+6);
        q:=IESwapWord(pword(data)^);  // name length
        inc(data,2);
        inc(data,q);
        q:=IESwapDWord(pdword(data)^);  // structure length
        inc(data,4);
        if q>=sizeof(TPSDResolutionInfo) then
        begin
          ri:=PPSDResolutionInfo(data);
          ri^.hRes:=IESwapDWord(fParams.DpiX*65536);
          ri^.vRes:=IESwapDWord(fParams.DpiY*65536);
          ri^.hResUnit:=IESwapWord(1);    // 1=pixels per inch
          ri^.vResUnit:=IESwapWord(1);    // 1=pixels per inch
          ri^.WidthUnit:=IESwapWord(1);   // 1=in
          ri^.HeightUnit:=IESwapWord(1);  // 1=in
        end;
          break;
      end;
    end;
  end;
end;

{!!
<FS>TImageEnIO.SaveToFileJpeg

<FM>Declaration<FC>
procedure SaveToFileJpeg(const FileName: WideString);

<FM>Description<FN>
SaveToFileJpeg saves the current image to a file in JPEG format.

FileName is the file name, with extension.


<FM>Example<FC>

// Saves a gray levels, progressive jpeg image with quality 30
ImageEnView1.IO.Params.JPEG_ColorSpace:=ioJPEG_GRAYLEV;
ImageEnView1.IO.Params.JPEG_Quality:=30;
ImageEnView1.IO.Params.JPEG_Progressive:=True;
ImageEnView1.IO.SaveToFileJpeg('image.jpg');

!!}
procedure TImageEnIO.SaveToFileJpeg(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
  buf: pointer;
  lbuf, mi, i: integer;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileJpeg, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;

    // update APP13 - 8BIM dpi info (Photoshop) resolution. This is overwritten if IPTC is written.
    UpdateAPP138BimResolution;

    // update APP13 marker with IPTC_Info
    if (fParams.IPTC_Info.UserChanged) or ( (fParams.IPTC_Info.Count>0) and (fParams.JPEG_MarkerList.Count=0) ) then
    begin
      fParams.IPTC_Info.SaveToStandardBuffer(buf, lbuf, true);
      mi := fParams.JPEG_MarkerList.IndexOf(JPEG_APP13);
      if buf <> nil then
      begin
        // replace or add IPTC marker
        if mi >= 0 then
          fParams.JPEG_MarkerList.SetMarker(mi, JPEG_APP13, buf, lbuf)
        else
          fParams.JPEG_MarkerList.AddMarker(JPEG_APP13, buf, lbuf);
        freemem(buf);
      end
      else if mi >= 0 then
        // remove IPTC marker
        fParams.JPEG_MarkerList.DeleteMarker(mi);
    end;

    // Exif info
    if fParams.EXIF_HasExifData then
    begin
      // save in temporary buffer
      SaveEXIFToStandardBuffer(fParams, buf, lbuf, true);
      // remove previous EXIF data
      with fParams.JPEG_MarkerList do
        for i:=0 to Count-1 do
          if (MarkerType[i]=JPEG_APP1) and CheckEXIFFromStandardBuffer(MarkerData[i], MarkerLength[i]) then
          begin
            DeleteMarker(i);
            break;
          end;
      // save in APP1
      fParams.JPEG_MarkerList.AddMarker(JPEG_APP1,buf,lbuf);
      freemem(buf);
    end;

    // XMP (3.0.4)
    // remove previous XMP data
    with fParams.JPEG_MarkerList do
      for i:=0 to Count-1 do
        if (MarkerType[i]=JPEG_APP1) and (IEFindXMPFromJpegTag(MarkerData[i], MarkerLength[i])<>nil) then
        begin
          DeleteMarker(i);
          break;
        end;
    if fParams.XMP_Info<>'' then
    begin
      // save in temporary buffer
      IESaveXMPToJpegTag(fParams,buf,lbuf);
      // save in APP1
      fParams.JPEG_MarkerList.AddMarker(JPEG_APP1,buf,lbuf);
      freemem(buf);
    end;

    try
      WriteJpegStream(fs, fIEBitmap, fParams, Progress);
      fParams.FileName:=FileName;
      fParams.FileType:=ioJPEG;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromFileJpeg

<FM>Declaration<FC>
procedure LoadFromFileJpeg(const FileName: WideString);

<FM>Description<FN>
LoadFromFileJpeg loads the image from a JPEG file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.


<FM>Example<FC>

ImageEnView1.IO.LoadFromFileJpeg('alfa.jpg');

!!}
procedure TImageEnIO.LoadFromFileJpeg(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
  XStream:TIEBufferedReadStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileJpeg, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    XStream:=TIEBufferedReadStream.Create(fs,8192);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fIEBitmap.RemoveAlphaChannel;
      ReadJPegStream(XStream, nil, fIEBitmap, fParams, Progress, False, false, true, false, true,true,-1,fParams.IsNativePixelFormat);
      CheckDPI;
      if fAutoAdjustDPI then
        AdjustDPI;
      fParams.fFileName := FileName;
      fParams.fFileType := ioJPEG;
      SetViewerDPI(fParams.DpiX, fParams.DpiY);
      Update;
    finally
      FreeAndNil(XStream);
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream:TStream; FileType:<A TIOFileType>);

<FM>Description<FN>
SaveToStream saves the image to a stream by calling FileType to specify the file format.

If <A TImageEnIO.StreamHeaders> property is True adds an additional special header, needed for multi-image streams.

!!}
procedure TImageEnIO.SaveToStream(Stream: TStream; FileType: TIOFileType);
var
  fpi: TIEFileFormatInfo;
  Progress: TProgressRec;
begin
  case FileType of
    ioTIFF: SaveToStreamTIFF(Stream);
    ioGIF: SaveToStreamGIF(Stream);
    ioJPEG: SaveToStreamJPEG(Stream);
{$IFDEF IEINCLUDEJPEG2000}
    ioJP2: SaveToStreamJP2(Stream);
    ioJ2K: SaveToStreamJ2K(Stream);
{$ENDIF}
    ioPCX: SaveToStreamPCX(Stream);
    ioDCX: SaveToStreamDCX(Stream);
    ioBMP: SaveToStreamBMP(Stream);
{$IFDEF IEINCLUDEPNG}
    ioPNG: SaveToStreamPNG(Stream);
{$ENDIF}
    ioTGA: SaveToStreamTGA(Stream);
    ioPXM: SaveToStreamPXM(Stream);
    ioICO: SaveToStreamICO(Stream);
    ioWBMP: SaveToStreamWBMP(Stream);
    ioPS: SaveToStreamPS(Stream);
    {$ifdef IEINCLUDEPDFWRITING}
    ioPDF: SaveToStreamPDF(Stream);
    {$endif}
    {$ifdef IEINCLUDEPSD}
    ioPSD: SaveToStreamPSD(Stream);
    {$endif}
    {$ifdef IEINCLUDEWIC}
    ioHDP: SaveToStreamHDP(Stream);
    {$endif}
  else
    begin
      if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
      begin
        TIEIOThread.CreateLoadSaveStreamFormat(self, SaveToStream, Stream, FileType);
        exit;
      end;
      fpi := IEFileFormatGetInfo(FileType);
      if assigned(fpi) and assigned(fpi.WriteFunction) then
        with fpi do
        begin
          try
            fAborting := false;
            Progress.Aborting := @fAborting;
            if not MakeConsistentBitmap([]) then
              exit;
            if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
              fIEBitmap.PixelFormat := ie24RGB;
            Progress.fOnProgress := fOnIntProgress;
            Progress.Sender := Self;
            fParams.fFileType := FileType;
            WriteFunction(Stream, fIEBitmap, fParams, Progress);
          finally
            DoFinishWork;
          end;
        end
      else
        fAborting := True;
    end;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromBuffer

<FM>Declaration<FC>
procedure LoadFromBuffer(Buffer:pointer; BufferSize:integer; Format:<A TIOFileType> = ioUnknown);

<FM>Description<FN>
Loads an image from the specified buffer.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Buffer<FN></C> <C>The buffer pointer</C> </R>
<R> <C><FC>BufferSize<FN></C> <C>The buffer length in bytes.</C> </R>
<R> <C><FC>Format<FN></C> <C>Specifies the expected file format. If Format is ioUnknown, then try to find the format automatically</C> </R>
</TABLE>

See also: <A TImageEnIO.ParamsFromBuffer>

<FM>Example<FC>

ImageEnView1.IO.LoadFromBuffer(mybuffer, mybufferlength, ioJPEG);
!!}
procedure TImageEnIO.LoadFromBuffer(Buffer:pointer; BufferSize:integer; Format:TIOFileType);
var
  stream:TIEMemStream;
begin
  if (Buffer=nil) or (BufferSize=0) then
  begin
    fAborting := true;
    exit;
  end;

  stream := TIEMemStream.Create(Buffer, BufferSize);
  try
    if Format = ioUnknown then
      LoadFromStream(stream)
    else
      LoadFromStreamFormat(stream, Format);
  finally
    FreeAndNil(stream);
  end;

end;


{!!
<FS>TImageEnIO.ParamsFromBuffer

<FM>Declaration<FC>
procedure ParamsFromBuffer(Buffer:pointer; BufferSize:integer; Format:<A TIOFileType> = ioUnknown);

<FM>Description<FN>
Loads an image parameters (but not the actual image) from the specified buffer.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Buffer<FN></C> <C>The buffer pointer</C> </R>
<R> <C><FC>BufferSize<FN></C> <C>The buffer length in bytes.</C> </R>
<R> <C><FC>Format<FN></C> <C>Specifies the expected file format. If Format is ioUnknown, then try to find the format automatically</C> </R>
</TABLE>

See also: <A TImageEnIO.LoadFromBuffer>

<FM>Example<FC>

ImageEnView1.IO.ParamsFromBuffer(mybuffer, mybufferlength, ioJPEG);
!!}
procedure TImageEnIO.ParamsFromBuffer(Buffer:pointer; BufferSize:integer; Format:TIOFileType);
var
  stream:TIEMemStream;
begin
  if (Buffer=nil) or (BufferSize=0) then
  begin
    fAborting := true;
    exit;
  end;

  stream := TIEMemStream.Create(Buffer, BufferSize);
  try
    if Format = ioUnknown then
      ParamsFromStream(stream)
    else
      ParamsFromStreamFormat(stream, Format);
  finally
    FreeAndNil(stream);
  end;

end;


(*
ietfPascal:
  const
    'FileName_Extension_Size' = nnnn;
    'FileName_Extension' : array [0..'FileName_Extension_Size'-1] of byte = ( $xx,$xx );
ietfHEX
  0xaa,0xbb,etc
ietfBase64
  /9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAYEBQYF....
*)

{!!
<FS>TImageEnIO.SaveToText

<FM>Declaration<FC>
procedure SaveToText(const FileName:WideString; ImageFormat: <A TIOFileType>; TextFormat:<A TIETextFormat>);

<FM>Description<FN>
Saves current image in the specified text format.

Parameters:

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>FileName<FN></C> <C>Output file name.</C> </R>
<R> <C><FC>ImageFormat<FN></C> <C>Wanted file format.</C> </R>
<R> <C><FC>TextFormat<FN></C> <C>Output text format. See allowed values in <A TIETextFormat>.</C> </R>
</TABLE>


<FM>Example<FC>
ImageEnView1.IO.LoadFromFile('input.jpg');
ImageEnView1.Proc.Resample(128,-1);
ImageEnView1.Io.SaveToText('output.txt', ioUnknown, ietfASCIIArt);
!!}
procedure TImageEnIO.SaveToText(const FileName:WideString; ImageFormat:TIOFileType; TextFormat:TIETextFormat);
const
  GR:array [0..8] of AnsiChar = 'W@#*+:., ';
var
  fw:TextFile;
  ss,s1:AnsiString;
  i,j,v:integer;
  blen:integer;
  ms:TMemoryStream;
  b:byte;
  px:PRGB;

  procedure PrepareStream;
  begin
    ss:=AnsiString(FileName);
    i:=IEPos('.',ss);
    if i>0 then
      ss[i]:='_';
    s1:=ss+'_Size';

    ms:=TMemoryStream.Create;
    SaveToStream(ms,ImageFormat);
    ms.Position:=0;
    blen:=ms.Size;
  end;

begin
  assignfile(fw,FileName);
  rewrite(fw);

  case TextFormat of

    ietfPascal:
      begin
        PrepareStream;
        WriteLn(fw, 'const' );
        WriteLn(fw, '  '+s1+' = '+IEIntToStr(blen)+';');
        WriteLn(fw, '  '+ss+' : array [0..'+s1+'-1] of byte = (' );
        ss:='';
        for i:=0 to blen-2 do
        begin
          ms.Read(b,1);
          ss:=ss+'$'+IEIntToHex(b,2)+',';
          if length(ss)>70 then
          begin
            WriteLn(fw, '    '+ss);
            ss:='';
          end;
        end;
        ms.Read(b,1);
        WriteLn(fw, '    '+ss+'$'+IEIntToHex(b,2)+');');
        FreeAndNil(ms);
      end;

    ietfHEX:
      begin
        PrepareStream;
        WriteLn(fw, '\\ Size='+IEIntToStr(blen) );
        ss:='';
        for i:=0 to blen-2 do
        begin
          ms.Read(b,1);
          ss:=ss+'0x'+IEIntToHex(b,2)+',';
          if length(ss)>70 then
          begin
            WriteLn(fw, ss);
            ss:='';
          end;
        end;
        ms.Read(b,1);
        WriteLn(fw, ss+'0x'+IEIntToHex(b,2));
        FreeAndNil(ms);
      end;

    ietfBase64:
      begin
        PrepareStream;
        IEencode64(ms,fw,76);
        FreeAndNil(ms);
      end;

    ietfASCIIArt:
      begin
        if not MakeConsistentBitmap([ie24RGB]) then
          exit;
        for i:=0 to fIEBitmap.Height-1 do
        begin
          ss:='';
          px:=fIEBitmap.Scanline[i];
          for j:=0 to fIEBitmap.Width-1 do
          begin
            with px^ do
              v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            v:=trunc((v/255)*9);
            ss:=ss+GR[v];
            inc(px);
          end;
          WriteLn(fw,ss);
        end;
      end;

  end;

  closefile(fw);
  fParams.FileName:=FileName;
end;

{!!
<FS>TImageEnIO.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream: TStream);

<FM>Description<FN>
LoadFromStream loads the image from a stream by calling <A FindStreamFormat> to select file format.
This method can load LYR (<A TImageEnView> layers), IEV (<A TImageEnVect> objects) and LYR+IEV formats when <A TImageEnIO.AttachedImageEn> is TImageEnView or TImageEnVect.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property is True.
If the <A TImageEnIO.StreamHeaders> property is True, the stream must have a special header (saved with <A TImageEnIO.SaveToStream>).

!!}
procedure TImageEnIO.LoadFromStream(Stream: TStream);
var
  sf: TIOFileType;
  lp: int64;
  fpi: TIEFileFormatInfo;
  Progress: TProgressRec;
begin
  lp := Stream.Position;
  sf := FindStreamFormat(Stream);
  fpi := IEFileFormatGetInfo(sf);

  if fpi=nil then
    exit;

  Stream.Position := lp;

  if fpi.InternalFormat then
    case sf of
      ioTIFF: LoadFromStreamTIFF(Stream);
      ioGIF: LoadFromStreamGIF(Stream);
      ioJPEG: LoadFromStreamJPEG(Stream);
      ioPCX: LoadFromStreamPCX(Stream);
      ioDCX: LoadFromStreamDCX(Stream);
      ioBMP: LoadFromStreamBMP(Stream);
      ioICO: LoadFromStreamICO(Stream);
      ioCUR: LoadFromStreamCUR(Stream);
      {$IFDEF IEINCLUDEPNG}
      ioPNG: LoadFromStreamPNG(Stream);
      {$ENDIF}
      {$ifdef IEINCLUDEDICOM}
      ioDICOM: LoadFromStreamDICOM(Stream);
      {$endif}
      ioTGA: LoadFromStreamTGA(Stream);
      ioPXM: LoadFromStreamPXM(Stream);
      {$IFDEF IEINCLUDEJPEG2000}
      ioJP2: LoadFromStreamJP2(Stream);
      ioJ2K: LoadFromStreamJ2K(Stream);
      {$ENDIF}
      {$ifdef IEINCLUDERAWFORMATS}
      ioRAW: LoadFromStreamRAW(Stream);
      {$endif}
      {$ifdef IEINCLUDEPSD}
      ioPSD: LoadFromStreamPSD(Stream);
      {$endif}
      {$ifdef IEINCLUDEWIC}
      ioHDP: LoadFromStreamHDP(Stream);
      {$endif}
      ioIEV, ioLYR, ioALL: begin LoadViewerStream(Stream,sf); exit; end;
      ioWMF, ioEMF: ImportMetafile(Stream);
    end
  else
    begin
      // unknown or user registered file formats
      if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
      begin
        TIEIOThread.CreateLoadSaveStream(self, LoadFromStream, Stream);
        exit;
      end;
      fParams.ResetInfo;
      Params.fFileName := '';
      Params.fFileType := ioUnknown;
      if assigned(fpi) and assigned(fpi.ReadFunction) then
        with fpi do
        begin
          // file format supported
          try
            fAborting := false;
            Progress.Aborting := @fAborting;
            if not MakeConsistentBitmap([]) then
              exit;
            Progress.fOnProgress := fOnIntProgress;
            Progress.Sender := Self;
            fParams.fFileType := FileType;
            ReadFunction(Stream, fIEBitmap, fParams, Progress, False);
            if fAutoAdjustDPI then
              AdjustDPI;
            SetViewerDPI(fParams.DpiX, fParams.DpiY);
            update;
          finally
            DoFinishWork;
          end;
        end
      else
      begin
        fAborting := True;
        DoFinishWork;
      end;
    end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamFormat

<FM>Declaration<FC>
procedure LoadFromStreamFormat(Stream:TStream; FileFormat:<A TIOFileType>);

<FM>Description<FN>
LoadFromStreamFormat loads an image from stream. LoadFromStreamFormat detects file format from FileFormat parameter.
This method can also load LYR (<A TImageEnView> layers), IEV (<A TImageEnVect> objects) and LYR+IEV formats when <A TImageEnIO.AttachedImageEn> is TImageEnView or TImageEnVect.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.

If <FC>FileFormat<FN> is <FC>ioUnknown<FN>, then <A TImageEnIO.LoadFromStream> is called (autodetection of the file format).

<FM>Example<FC>

// load a jpeg from the stream stm
ImageEnView1.IO.LoadFromStreamFormat(stm, ioJPEG)

!!}
procedure TImageEnIO.LoadFromStreamFormat(Stream: TStream; FileFormat: TIOFileType);
var
  fpi: TIEFileFormatInfo;
  Progress: TProgressRec;
begin
  if FileFormat=ioUnknown then
  begin
    LoadFromStream(Stream);
    exit;
  end;

  fpi := IEFileFormatGetInfo(FileFormat);
  if fpi=nil then
    exit;

  if fpi.InternalFormat then
    case FileFormat of
      ioTIFF: LoadFromStreamTIFF(Stream);
      ioGIF: LoadFromStreamGIF(Stream);
      ioJPEG: LoadFromStreamJPEG(Stream);
      ioPCX: LoadFromStreamPCX(Stream);
      ioDCX: LoadFromStreamDCX(Stream);
      ioBMP: LoadFromStreamBMP(Stream);
      ioICO: LoadFromStreamICO(Stream);
      ioCUR: LoadFromStreamCUR(Stream);
      {$IFDEF IEINCLUDEPNG}
      ioPNG: LoadFromStreamPNG(Stream);
      {$ENDIF}
      {$ifdef IEINCLUDEDICOM}
      ioDICOM: LoadFromStreamDICOM(Stream);
      {$endif}
      ioTGA: LoadFromStreamTGA(Stream);
      ioPXM: LoadFromStreamPXM(Stream);
      ioWBMP: LoadFromStreamWBMP(Stream);
      {$IFDEF IEINCLUDEJPEG2000}
      ioJP2: LoadFromStreamJP2(Stream);
      ioJ2K: LoadFromStreamJ2K(Stream);
      {$ENDIF}
      {$ifdef IEINCLUDERAWFORMATS}
      ioRAW: LoadFromStreamRAW(Stream);
      {$endif}
      ioBMPRAW: LoadFromStreamBMPRAW(Stream);
      {$ifdef IEINCLUDEPSD}
      ioPSD: LoadFromStreamPSD(Stream);
      {$endif}
      {$ifdef IEINCLUDEWIC}
      ioHDP: LoadFromStreamHDP(Stream);
      {$endif}
      ioIEV, ioLYR, ioALL: begin LoadViewerStream(Stream,FileFormat); exit; end;
    end
  else
    begin
      // unknown or user registered file formats
      if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
      begin
        TIEIOThread.CreateLoadSaveStreamFormat(self, LoadFromStreamFormat, Stream, FileFormat);
        exit;
      end;
      fParams.ResetInfo;
      Params.fFileName := '';
      Params.fFileType := ioUnknown;
      if assigned(fpi) and assigned(fpi.ReadFunction) then
        with fpi do
        begin
          // file format supported
          try
            fAborting := false;
            Progress.Aborting := @fAborting;
            if not MakeConsistentBitmap([]) then
              exit;
            Progress.fOnProgress := fOnIntProgress;
            Progress.Sender := Self;
            fParams.fFileType := FileType;
            ReadFunction(Stream, fIEBitmap, fParams, Progress, False);
            if fAutoAdjustDPI then
              AdjustDPI;
            SetViewerDPI(fParams.DpiX, fParams.DpiY);
            update;
          finally
            DoFinishWork;
          end;
        end
      else
      begin
        fAborting := True;
        DoFinishWork;
      end;
    end;
end;

{!!
<FS>TImageEnIO.SaveToFilePCX

<FM>Declaration<FC>
procedure SaveToFilePCX(const FileName: WideString);

<FM>Description<FN>
SaveToFilePCX saves the current image in PCX format to a file.
FileName is the file name, with extension.


<FM>Example<FC>

// Saves a 256 color PCX
ImageEnView1.IO.Params.BitsPerSample:=8;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
ImageEnView1.IO.SaveToFilePCX('image.pcx');

!!}
procedure TImageEnIO.SaveToFilePCX(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFilePCX, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      WritePcxStream(fs, fIEBitmap, fParams, Progress);
      fParams.FileName:=FileName;
      fParams.FileType:=ioPCX;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromFileTGA

<FM>Declaration<FC>
procedure LoadFromFileTGA(const FileName: WideString);

<FM>Description<FN>
LoadFromFileTGA loads an image from a TGA file.
If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be True.

FileName is the file name with extension.
!!}
procedure TImageEnIO.LoadFromFileTGA(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
  tmpAlphaChannel: TIEMask;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileTGA, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fIEBitmap.RemoveAlphaChannel;
      tmpAlphaChannel := nil;
      ReadTGAStream(fs, fIEBitmap, fParams, Progress, false, tmpAlphaChannel, false);
      CheckDPI;
      if assigned(tmpAlphaChannel) then
      begin
        fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
        FreeAndNil(tmpAlphaChannel);
      end;
      if fAutoAdjustDPI then
        AdjustDPI;
      fParams.fFileName := FileName;
      fParams.fFileType := ioTGA;
      SetViewerDPI(fParams.DpiX, fParams.DpiY);
      update;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamTGA

<FM>Declaration<FC>
procedure LoadFromStreamTGA(Stream:TStream);

<FM>Description<FN>
LoadFromStreamTGA loads an image from a TGA stream.
If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be True.

Stream is the image stream.
!!}
procedure TImageEnIO.LoadFromStreamTGA(Stream: TStream);
var
  Progress: TProgressRec;
  tmpAlphaChannel: TIEMask;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamTGA, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    tmpAlphaChannel := nil;
    ReadTGAStream(Stream, fIEBitmap, fParams, Progress, false, tmpAlphaChannel, false);
    CheckDPI;
    if assigned(tmpAlphaChannel) then
    begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
    end;
    if fAutoAdjustDPI then
      AdjustDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioTGA;
    update;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SavetoFileTGA

<FM>Declaration<FC>
procedure SaveToFileTGA(const FileName: WideString);

<FM>Description<FN>
SaveToFileTGA saves the current image in TGA format to a file.

<FC>FileName<FN> is the file name, with extension.
!!}
procedure TImageEnIO.SaveToFileTGA(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
  iemask: TIEMask;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileTGA, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      if fIEBitmap.HasAlphaChannel then
      begin
        iemask := TIEMask.Create;
        fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
        WriteTGAStream(fs, fIEBitmap, fParams, Progress, iemask);
        FreeAndNil(iemask);
      end
      else
        WriteTGAStream(fs, fIEBitmap, fParams, Progress, nil);
      fParams.FileName:=FileName;
      fParams.FileType:=ioTGA;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamTGA

<FM>Declaration<FC>
procedure SaveToStreamTGA(Stream:TStream);

<FM>Description<FN>
SaveToStreamTGA saves the current image in TGA format to stream.

Stream is the image stream.
!!}
procedure TImageEnIO.SaveToStreamTGA(Stream: TStream);
var
  Progress: TProgressRec;
  iemask: TIEMask;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamTGA, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    if fIEBitmap.HasAlphaChannel then
    begin
      iemask := TIEMask.Create;
      fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
      WriteTGAStream(Stream, fIEBitmap, fParams, Progress, iemask);
      FreeAndNil(iemask);
    end
    else
      WriteTGAStream(Stream, fIEBitmap, fParams, Progress, nil);
  finally
    DoFinishWork;
  end;
end;

procedure TImageEnIO.SyncSaveToStreamBMP(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    BMPWriteStream(Stream, fIEBitmap, fParams, Progress, fParams.BMP_HandleTransparency);
  finally
    DoFinishWork;
  end;
end;

procedure TImageEnIO.SyncSaveToStreamDCX(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    IEDCXInsertStream(Stream,fIEBitmap,fParams,Progress);
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamDCX

<FM>Declaration<FC>
procedure SaveToStreamDCX(Stream: TStream);

<FM>Description<FN>
Saves current image in DCX format to the specified stream.

!!}
procedure TImageEnIO.SaveToStreamDCX(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamDCX, Stream);
    exit;
  end;
  Stream.Size:=0; // this avoid that this function inserts
  SyncSaveToStreamDCX(Stream);
end;

{!!
<FS>TImageEnIO.SaveToFileDCX

<FM>Declaration<FC>
procedure SaveToFileDCX(const FileName: WideString);

<FM>Description<FN>
Saves current image in DCX format to the specified file.

!!}
procedure TImageEnIO.SaveToFileDCX(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileDCX, FileName);
    exit;
  end;
  fs := nil;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    SyncSaveToStreamDCX(fs);
    fParams.FileName:=FileName;
    fParams.FileType:=ioDCX;
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnIO.InsertToFileDCX

<FM>Declaration<FC>
procedure InsertToFileDCX(const FileName: WideString);

<FM>Description<FN>
Inserts current image in DCX format to the specified file, to the position specified by Params.DCX_ImageIndex.

<FM>Example<FC>

ImageEnView1.IO.Params.DCX_ImageIndex := 1;
ImageEnView1.IO.InsertToFileDCX('multipage.dcx');

!!}
procedure TImageEnIO.InsertToFileDCX(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, InsertToFileDCX, FileName);
    exit;
  end;
  fs := nil;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmOpenReadWrite);
    SyncSaveToStreamDCX(fs);
  finally
    FreeAndNil(fs);
  end;
end;


{!!
<FS>TImageEnIO.SaveToStreamBMP

<FM>Declaration<FC>
procedure SaveToStreamBMP(Stream: TStream);

<FM>Description<FN>
<FC>SaveToStreamBMP<FN> saves current image as BMP in the Stream.

If <A TImageEnIO.StreamHeaders> property is True, it adds an additional special header as needed for multi-image streams.


<FM>Example<FC>

// Saves ImageEnView1 and ImageEnView2 images in file images.dat
// images.dat isn't loadable with LoadFromFileXXX methods
var
  fs:TFileStream;
Begin
  fs:=TFileStream.Create('bmpimages.dat',fmCreate);
  ImageEnView1.IO.StreamHeaders:=True;
  ImageEnView1.IO.SaveToStreamBMP(fs);
  ImageEnView2.IO.StreamHeaders:=True;
  ImageEnView2.IO.SaveToStreamBMP(fs);
  fs.free;
End;

// Saves a single image in image.bmp
// image.bmp is loadable with LoadFromFileXXX methods
var
  fs.TFileStream;
Begin
  fs:=TFileStream.Create('image.bmp');
  ImageEnView1.IO.StreamHeaders:=False;
  ImageEnView1.IO.SaveToFileBMP(fs);
End;

!!}
procedure TImageEnIO.SaveToStreamBMP(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamBMP, Stream);
    exit;
  end;
  SyncSaveToStreamBMP(Stream);
end;

{!!
<FS>TImageEnIO.SaveToFileBMP

<FM>Declaration<FC>
procedure SaveToFileBMP(const FileName: WideString);

<FM>Description<FN>
SaveToFileBMP saves the current image in BMP format to a file.

<FC>FileName<FN> is the file name with extension.


<FM>Example<FC>

// Saves a 256 color compressed bitmap bitmap
ImageEnView1.IO.Params.BitsPerSample:=8;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
ImageEnView1.IO.Params.BMP_Compression:=ioBMP_RLE;
ImageEnView1.IO.SaveToFile('Italy.bmp');

!!}
procedure TImageEnIO.SaveToFileBMP(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileBMP, FileName);
    exit;
  end;
  fs := nil;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    SyncSaveToStreamBMP(fs);
    fParams.FileName:=FileName;
    fParams.FileType:=ioBMP;
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnIO.SaveToFileTIFF

<FM>Declaration<FC>
procedure SaveToFileTIFF(const FileName: WideString);

<FM>Description<FN>
SaveToFileTIFF saves the current image in TIFF format to a file.

<FC>FileName<FN> is the file name, with extension.


<FM>Example<FC>

ImageEnView1.IO.Params.DocumentName:='My document';
ImageEnView1.IO.SaveToFileTIFF('image.tiff');

!!}
procedure TImageEnIO.SaveToFileTIFF(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileTIFF, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      TIFFWriteStream(fs, false, fIEBitmap, fParams, Progress);
      fParams.FileName:=FileName;
      fParams.FileType:=ioTIFF;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamTIFF

<FM>Declaration<FC>
procedure SaveToStreamTIFF(Stream: TStream);

<FM>Description<FN>
SaveToStreamTIFF saves the current image with PCX format to the specified Stream.
If <A TImageEnIO.StreamHeaders> property is True, it adds an additional special header as needed for multi-image streams.


<FM>Example<FC>

// Saves ImageEnView1 and ImageEnView2 attached images in file images.dat
// images.dat isn't loadable with LoadFromFileXXX methods
var
  fs:TFileStream;
Begin
  fs:=TFileStream.Create('bmpimages.dat',fmCreate);
  ImageEnView1.IO.StreamHeaders:=True;
  ImageEnView1.IO.SaveToStreamTIFF(fs);
  ImageEnView2.IO.StreamHeaders:=True;
  ImageEnView2.IO.SaveToStreamTIFF(fs);
  fs.free;
End;

// Saves a single image in image.tif
// image.tif is loadable with LoadFromFileXXX methods
var
  fs.TFileStream;
Begin
  fs:=TFileStream.Create('image.tif');
  ImageEnView1.IO.StreamHeaders:=False;
  ImageEnView1.IO.SaveToFileTIFF(fs);
End;

!!}
procedure TImageEnIO.SaveToStreamTIFF(Stream: TStream);
var
  SHead: TIFFSHead;
  lp1, lp2: int64;
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamTIFF, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    lp1 := 0;
    if fStreamHeaders then
    begin
      lp1 := Stream.position;
      Stream.write(SHead, sizeof(SHead)); // create space for TIFF stream header
    end;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    TIFFWriteStream(Stream, false, fIEBitmap, fParams, Progress);
    if fStreamHeaders then
    begin
      // salve HEADER-TIFF-STREAM
      lp2 := Stream.position;
      Stream.position := lp1;
      SHead.id := 'TIFF';
      SHead.dim := lp2 - lp1 - sizeof(SHead);
      Stream.Write(SHead, sizeof(SHead));
      Stream.position := lp2;
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamPCX

<FM>Declaration<FC>
procedure SaveToStreamPCX(Stream: TStream);

<FM>Description<FN>
SaveToStreamPCX saves the current image as PCX in the Stream.
If <A TImageEnIO.StreamHeaders> property is True, it adds an additional special header as needed for multi-image streams.

<FM>Example<FC>

// Saves ImageEnView1 and ImageEnView2 attached images in file images.dat
// images.dat isn't loadable with LoadFromFileXXX methods
var
  fs:TFileStream;
Begin
  fs:=TFileStream.Create('bmpimages.dat',fmCreate);
  ImageEnView1.IO.StreamHeaders:=True;
  ImageEnView1.IO.SaveToStreamPCX(fs);
  ImageEnView2.IO.StreamHeaders:=True;
  ImageEnView2.IO.SaveToStreamPCX(fs);
  fs.free;
End;

// Saves a single image in image.pcx
// image.pcx is loadable with LoadFromFileXXX methods
var
  fs:TFileStream;
Begin
  fs:=TFileStream.Create('image.pcx');
  ImageEnView1.IO.StreamHeaders:=False;
  ImageEnView1.IO.SaveToFilePCX(fs);
End;

!!}
procedure TImageEnIO.SaveToStreamPCX(Stream: TStream);
var
  SHead: PCXSHead;
  lp1, lp2: int64;
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamPCX, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    lp1 := 0;
    if fStreamHeaders then
    begin
      lp1 := Stream.position;
      Stream.write(SHead, sizeof(SHead)); // lascia spazio per header PCX stream
    end;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    WritePcxStream(Stream, fIEBitmap, fParams, Progress);
    if fStreamHeaders and not fAborting then
    begin
      // salva HEADER-PCX-STREAM
      lp2 := Stream.position;
      Stream.position := lp1;
      SHead.id := 'PCX2'; // PCX2 è PCX con dimensione
      SHead.dim := lp2 - lp1 - sizeof(SHead);
      Stream.Write(SHead, sizeof(SHead));
      Stream.position := lp2;
    end;
  finally
    DoFinishWork;
  end;
end;

// do parameters previews
// return True if user press OK
{$IFDEF IEINCLUDEDIALOGIO}

{!!
<FS>TImageEnIO.DoPreviews

<FM>Declaration<FC>
function DoPreviews(pp: <A TPreviewParams>): boolean;

<FM>Description<FN>
This function executes the Previews dialog. This dialog gets/sets the parameters of image file formats.

<FC>pp<FN> is the set of the image formats parameters to show in the dialog.


<FM>Example<FC>

ImageEnView1.IO.LoadFromFile('myimage.gif');  // loads a GIF image
ImageEnView1.IO.DoPreviews([ppGIF]); // sets GIF parameters (background, transparency...)
ImageEnView1.IO.SaveToFile('newimae.gif'); // saves some image with new parameters
!!}
function TImageEnIO.DoPreviews(pp: TPreviewParams): boolean;
var
  fIOPreviews: TfIOPreviews;
  Handled: boolean;
begin
  Handled := false;
  if assigned(fOnDoPreviews) then
    fOnDoPreviews(self, Handled);
  if not Handled then
  begin
    result := false;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;

    fIOPreviews := TfIOPreviews.Create(self);

    fIOPreviews.DefaultLockPreview := ioppDefaultLockPreview in PreviewsParams;
    fIOPreviews.Button4.Visible := ioppApplyButton in PreviewsParams;
    fIOPreviews.fParams := fParams;
    fIOPreviews.fSimplified := fSimplifiedParamsDialogs;
    if fSimplifiedParamsDialogs then
    begin
      fIOPreviews.PageControl1.Height := trunc(122 / 96 * Screen.PixelsPerInch);
      fIOPreviews.Height := trunc(360 / 96 * Screen.PixelsPerInch);
    end;
    fIOPreviews.fDefaultDitherMethod := fDefaultDitherMethod;

    fIOPreviews.SetLanguage(fMsgLanguage);
    fIOPreviews.Font.assign(fPreviewFont);

    fIOPreviews.ImageEn1.SetExternalBitmap( fIEBitmap );

    fIOPreviews.ImageEn1.Update;
    fIOPreviews.ImageEn2.Blank;

    if fIOPreviews.SetPreviewParams(pp) then
    begin
      if assigned(fOnIOPreview) then
        fOnIOPreview(self, fIOPreviews);
      result := fIOPreviews.ShowModal = mrOk;
    end;

    fIOPreviews.ImageEn1.SetExternalBitmap( nil );

    fIOPreviews.Release;

    Update;
  end
  else
    result := true; // handled
end;
{$ENDIF}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TIOParamsVals.Create

<FM>Declaration<FC>
constructor Create(IEIO: <A TImageEnIO>);

<FM>Description<FN>
A TIOParamsVals is automatically created from TImageEnIO component.
!!}
constructor TIOParamsVals.Create(IEIO: TImageEnIO);
begin
  inherited Create;
  fImageEnIO := IEIO;
  fColorMap := nil;
  fEXIF_Bitmap := nil;
  fJPEG_MarkerList := TIEMarkerList.Create;
  fIPTC_Info := TIEIPTCInfoList.Create;
  fPXM_Comments := TStringList.Create;
  fGIF_Comments := TStringList.Create;
  fPNG_TextKeys := TStringList.Create;
  fPNG_TextValues := TStringList.Create;
  {$ifdef IEINCLUDEDICOM}
  fDICOM_Tags := TIEDICOMTags.Create;
  {$endif}
  {$ifdef IEINCLUDEIMAGINGANNOT}
  fImagingAnnot := nil;
  {$endif}
  fInputICC := nil;
  fOutputICC := nil;
  fDefaultICC := nil;
  fEXIF_MakerNote := TIETagsHandler.Create;
  fEXIF_Tags := TList.Create;
  SetDefaultParams;
end;

destructor TIOParamsVals.Destroy;
begin
  FreeAndNil(fEXIF_Tags);
  FreeAndNil(fEXIF_MakerNote);
  if assigned(fEXIF_Bitmap) then
    FreeAndNil(fEXIF_Bitmap);
  if ColorMap <> nil then
    freemem(ColorMap);
  FreeAndNil(fJPEG_MarkerList);
  FreeAndNil(fIPTC_Info);
  {$ifdef IEINCLUDEIMAGINGANNOT}
  if assigned(fImagingAnnot) then
    FreeAndNil(fImagingAnnot);
  {$endif}
  FreeAndNil(fPXM_Comments);
  FreeAndNil(fGIF_Comments);
  FreeAndNil(fPNG_TextKeys);
  FreeAndNil(fPNG_TextValues);
  {$ifdef IEINCLUDEDICOM}
  FreeAndNil(fDICOM_Tags);
  {$endif}
  if assigned(fInputICC) then
    FreeAndNil(fInputICC);
  if assigned(fOutputICC) then
    FreeAndNil(fOutputICC);
  if assigned(fDefaultICC) then
    FreeAndNil(fDefaultICC);
  inherited;
end;

procedure TIOParamsVals.FreeColorMap;
begin
  if fColorMap <> nil then
    freemem(fColorMap);
  fColorMap := nil;
  fColorMapCount := 0;
end;

{!!
<FS>TIOParamsVals.ResetEXIF

<FM>Declaration<FC>
procedure ResetEXIF;

<FM>Description<FN>
This method resets all EXIF fields. This is useful to remove EXIF info from your files.
However if you want remove all metadata information from the jpegs we suggest to call ResetInfo instead of ResetEXIF.
!!}
procedure TIOParamsVals.ResetEXIF;
var
  q: integer;
begin
  fEXIF_Tags.Clear;
  fEXIF_HasEXIFData := false;
  if assigned(fEXIF_Bitmap) then
    FreeAndNil(fEXIF_Bitmap);
  fEXIF_Bitmap := nil;
  fEXIF_ImageDescription := '';
  fEXIF_Make := '';
  fEXIF_Model := '';
  fEXIF_Orientation := 0;
  fEXIF_XResolution := 0;
  fEXIF_YResolution := 0;
  fEXIF_ResolutionUnit := 0;
  fEXIF_Software := '';
  fEXIF_Artist := '';
  fEXIF_DateTime := '';
  fEXIF_WhitePoint[0] := -1;
  fEXIF_WhitePoint[1] := -1;
  for q := 0 to 5 do
    fEXIF_PrimaryChromaticities[q] := -1;
  for q := 0 to 2 do
    fEXIF_YCbCrCoefficients[q] := -1;
  fEXIF_YCbCrPositioning := -1;
  for q := 0 to 5 do
    fEXIF_ReferenceBlackWhite[q] := -1;
  fEXIF_Copyright := '';
  fEXIF_ExposureTime := -1;
  fEXIF_FNumber := -1;
  fEXIF_ExposureProgram := -1;
  fEXIF_ISOSpeedRatings[0] := 0;
  fEXIF_ISOSpeedRatings[1] := 0;
  fEXIF_ExifVersion := '';
  fEXIF_DateTimeOriginal := '';
  fEXIF_DateTimeDigitized := '';
  fEXIF_CompressedBitsPerPixel := 0;
  fEXIF_ShutterSpeedValue := -1;
  fEXIF_ApertureValue := -1;
  fEXIF_BrightnessValue := -1000;
  fEXIF_ExposureBiasValue := -1000;
  fEXIF_MaxApertureValue := -1000;
  fEXIF_SubjectDistance := -1;
  fEXIF_MeteringMode := -1;
  fEXIF_LightSource := -1;
  fEXIF_Flash := -1;
  fEXIF_FocalLength := -1;
  fEXIF_SubsecTime := '';
  fEXIF_SubsecTimeOriginal := '';
  fEXIF_SubsecTimeDigitized := '';
  fEXIF_FlashPixVersion := '';
  fEXIF_ColorSpace := -1;
  fEXIF_ExifImageWidth := 0;
  fEXIF_ExifImageHeight := 0;
  fEXIF_RelatedSoundFile := '';
  fEXIF_FocalPlaneXResolution := -1;
  fEXIF_FocalPlaneYResolution := -1;
  fEXIF_FocalPlaneResolutionUnit := -1;
  fEXIF_ExposureIndex := -1;
  fEXIF_SensingMethod := -1;
  fEXIF_FileSource := -1;
  fEXIF_SceneType := -1;
  fEXIF_UserComment := '';
  fEXIF_UserCommentCode := '';
  fEXIF_MakerNote.Clear;
  fEXIF_XPRating:=-1;
  fEXIF_XPTitle:='';
  fEXIF_XPComment:='';
  fEXIF_XPAuthor:='';
  fEXIF_XPKeywords:='';
  fEXIF_XPSubject:='';
  fEXIF_ExposureMode:=-1;
  fEXIF_WhiteBalance:=-1;
  fEXIF_DigitalZoomRatio:=-1;
  fEXIF_FocalLengthIn35mmFilm:=-1;
  fEXIF_SceneCaptureType:=-1;
  fEXIF_GainControl:=-1;
  fEXIF_Contrast:=-1;
  fEXIF_Saturation:=-1;
  fEXIF_Sharpness:=-1;
  fEXIF_SubjectDistanceRange:=-1;
  fEXIF_ImageUniqueID:='';
  fEXIF_GPSVersionID:='';  // ''=indicates that there aren't GPS info to write
  fEXIF_GPSLatitudeRef:='';
  fEXIF_GPSLatitudeDegrees:=0;
  fEXIF_GPSLatitudeMinutes:=0;
  fEXIF_GPSLatitudeSeconds:=0;
  fEXIF_GPSLongitudeRef:='';
  fEXIF_GPSLongitudeDegrees:=0;
  fEXIF_GPSLongitudeMinutes:=0;
  fEXIF_GPSLongitudeSeconds:=0;
  fEXIF_GPSAltitudeRef:='';
  fEXIF_GPSAltitude:=0;
  fEXIF_GPSTimeStampHour:=0;
  fEXIF_GPSTimeStampMinute:=0;
  fEXIF_GPSTimeStampSecond:=0;
  fEXIF_GPSSatellites:='';
  fEXIF_GPSStatus:='';
  fEXIF_GPSMeasureMode:='';
  fEXIF_GPSDOP:=0;
  fEXIF_GPSSpeedRef:='';
  fEXIF_GPSSpeed:=0;
  fEXIF_GPSTrackRef:='';
  fEXIF_GPSTrack:=0;
  fEXIF_GPSImgDirectionRef:='';
  fEXIF_GPSImgDirection:=0;
  fEXIF_GPSMapDatum:='';
  fEXIF_GPSDestLatitudeRef:='';
  fEXIF_GPSDestLatitudeDegrees:=0;
  fEXIF_GPSDestLatitudeMinutes:=0;
  fEXIF_GPSDestLatitudeSeconds:=0;
  fEXIF_GPSDestLongitudeRef:='';
  fEXIF_GPSDestLongitudeDegrees:=0;
  fEXIF_GPSDestLongitudeMinutes:=0;
  fEXIF_GPSDestLongitudeSeconds:=0;
  fEXIF_GPSDestBearingRef:='';
  fEXIF_GPSDestBearing:=0;
  fEXIF_GPSDestDistanceRef:='';
  fEXIF_GPSDestDistance:=0;
  fEXIF_GPSDateStamp:='';
  // removes Jpeg EXIF tag
  with JPEG_MarkerList do
    for q:=0 to Count-1 do
      if (MarkerType[q]=JPEG_APP1) and CheckEXIFFromStandardBuffer(MarkerData[q], MarkerLength[q]) then
      begin
        DeleteMarker(q);
        break;
      end;
end;



{!!
<FS>TIOParamsVals.ResetInfo

<FM>Declaration<FC>
procedure ResetInfo;

<FM>Description<FN>
This method resets IPTC information, imaging annotations, jpeg markers, EXIF, GIF comments, PNG comments, TIFF textual tags, TGA comments, PXM comments and any other loaded textual information.
It also removes the input ICC profile.

<FM>Example<FC>

ImageEnView1.IO.Params.ResetInfo;
!!}
// reset only info tags (EXIF, IPTC, JPEG_Tags, XMP and comments)
procedure TIOParamsVals.ResetInfo;
begin
  IPTC_Info.Clear;
  {$ifdef IEINCLUDEIMAGINGANNOT}
  if assigned(fImagingAnnot) then
    FreeAndNil(fImagingAnnot);
  {$endif}
  JPEG_MarkerList.Clear;
  ResetEXIF;
  GIF_Comments.Clear;
  {$ifdef IEINCLUDEDICOM}
  DICOM_Tags.Clear;
  {$endif}
  PNG_TextKeys.Clear;
  PNG_TextValues.Clear;
  TIFF_DocumentName := '';
  TIFF_ImageDescription := '';
  TIFF_PageName := '';
  TGA_Descriptor := '';
  TGA_Author := '';
  TGA_ImageName := '';
  PXM_Comments.Clear;
  XMP_Info := '';
  if assigned(fInputICC) then
    FreeAndNil(fInputICC);
  // do not reset output or Default ICC profile
end;

{!!
<FS>TIOParamsVals.SetDefaultParams

<FM>Declaration<FC>
procedure SetDefaultParams;

<FM>Description<FN>
Sets default parameters (startup parameters).
!!}
procedure TIOParamsVals.SetDefaultParams;
begin
  FreeColorMap; // no colormap
  fFileName := '';
  fFileType := ioUnknown;
  BitsPerSample := 8; // 8 BITS x SAMPLE
  SamplesPerPixel := 3; // 3 SAMPLES x PIXEL (RGB)
  IsNativePixelFOrmat := false;
  if assigned(fImageEnIO) then
  begin
    if assigned(fImageEnIO.Bitmap) then
    begin
      fWidth := fImageEnIO.Bitmap.Width;
      fHeight := fImageEnIO.Bitmap.Height;
    end;
    SetDPIX(gDefaultDPIX);
    SetDPIY(gDefaultDPIY);
  end;
  fImageIndex := 0;
  fImageCount := 0;
  fGetThumbnail := false;
  fIsResource := false;
  fEnableAdjustOrientation:=false;
  // GIF
  GIF_Version := 'GIF89a';
  GIF_ImageIndex := 0;
  GIF_XPos := 0;
  GIF_YPos := 0;
  GIF_DelayTime := 0;
  GIF_FlagTranspColor := false;
  GIF_TranspColor := CreateRGB(0, 0, 0);
  GIF_Interlaced := false;
  GIF_WinWidth := 0;
  GIF_WinHeight := 0;
  GIF_Background := CreateRGB(0, 0, 0);
  GIF_Ratio := 0;
  GIF_LZWDecompFunc := DefGIF_LZWDecompFunc;
  GIF_LZWCompFunc := DefGIF_LZWCompFunc;
  fGIF_ImageCount := 0;
  GIF_Comments.Clear;
  GIF_Action := ioGIF_DrawBackground;
  // DCX
  DCX_ImageIndex := 0;
  // TIFF
  TIFF_Compression := ioTIFF_UNCOMPRESSED;
  TIFF_PhotometInterpret := ioTIFF_RGB;
  TIFF_PlanarConf := 1;
  TIFF_ImageIndex := 0;
  TIFF_SubIndex:=-1;
  TIFF_XPos := 0;
  TIFF_YPos := 0;
  TIFF_GetTile := -1;
  TIFF_DocumentName := '';
  TIFF_ImageDescription := '';
  TIFF_PageName := '';
  TIFF_PageNumber := -1;
  TIFF_PageCount := -1;
  TIFF_Orientation := 1;
  TIFF_LZWDecompFunc := DefTIFF_LZWDecompFunc;
  TIFF_LZWCompFunc := DefTIFF_LZWCompFunc;
  fTIFF_ImageCount := 0;
  fTIFF_EnableAdjustOrientation := false;
  fTIFF_JPEGQuality := 80;
  fTIFF_JPEGColorSpace := ioJPEG_YCBCR;
  fTIFF_FillOrder := 1;
  fTIFF_ZIPCompression := 1;  // normal (default)
  fTIFF_ByteOrder := ioLittleEndian; // Intel
  // JPEG
  JPEG_ColorSpace := ioJPEG_YCbCr;
  JPEG_Quality := 80;
  JPEG_DCTMethod := ioJPEG_ISLOW; // 3.0.1
  JPEG_CromaSubsampling := ioJPEG_HIGH;
  JPEG_OptimalHuffman := false;
  JPEG_Smooth := 0;
  JPEG_Progressive := false;
  JPEG_Scale := ioJPEG_FULLSIZE;
  JPEG_MarkerList.clear;
  JPEG_Scale_Used := 1;
  OriginalWidth := 0;
  OriginalHeight := 0;
  JPEG_EnableAdjustOrientation:=false;
  JPEG_GetExifThumbnail:=false;
  // JPEG2000
{$IFDEF IEINCLUDEJPEG2000}
  fJ2000_ColorSpace := ioJ2000_RGB;
  fJ2000_Rate := 1;
  fJ2000_ScalableBy := ioJ2000_Rate;
{$ENDIF}
  // BMP
  BMP_Compression := ioBMP_UNCOMPRESSED;
  BMP_Version := ioBMP_BM3;
  BMP_HandleTransparency := false;
  // PCX
  PCX_Version := 5;
  PCX_Compression := ioPCX_RLE;
  // ICO
  ICO_ImageIndex := 0;
  ICO_Background := CreateRGB(255, 255, 255);
  FillChar(ICO_Sizes[0], sizeof(TIOICOSizes), 0);
  ICO_Sizes[0].cx := 64;
  ICO_Sizes[0].cy := 64;
  FillChar(ICO_BitCount[0], sizeof(TIOICOBitCount), 0);
  ICO_BitCount[0] := 8;
  // CUR
  CUR_ImageIndex := 0;
  CUR_XHotSpot := 0;
  CUR_XHotSpot := 0;
  CUR_Background := CreateRGB(255, 255, 255);
  // PNG
  PNG_Interlaced := false;
  PNG_Background := CreateRGB(0, 0, 0);
  PNG_Filter := ioPNG_FILTER_NONE;
  PNG_Compression := 5;
  PNG_TextKeys.Clear;
  PNG_TextValues.Clear;
  // DICOM
  {$ifdef IEINCLUDEDICOM}
  DICOM_Tags.Clear;
  {$endif}
  // PSD
  PSD_LoadLayers:=false;
  PSD_ReplaceLayers:=true;
  fPSD_HasPremultipliedAlpha:=false;
  // HDP
  fHDP_ImageQuality := 0.9;
  fHDP_Lossless := false;
  // TGA
  TGA_XPos := 0;
  TGA_YPos := 0;
  TGA_Compressed := true;
  TGA_Descriptor := '';
  TGA_Author := '';
  TGA_Date := date;
  TGA_ImageName := '';
  TGA_Background := CreateRGB(0, 0, 0);
  TGA_AspectRatio := 1;
  TGA_Gamma := 2.2;
  TGA_GrayLevel := false;
  // AVI
  AVI_FrameCount := 0;
  AVI_FrameDelayTime := 0;
  // IPTC
  IPTC_Info.Clear;
  // PXM
  PXM_Comments.Clear;
  // EXIF
  ResetEXIF;
  // PS
  PS_PaperWidth := 595;
  PS_PaperHeight := 842;
  PS_Compression := ioPS_G4FAX;
  PS_Title := 'No Title';
  // PDF
  PDF_PaperWidth := 595;
  PDF_PaperHeight := 842;
  PDF_Compression := ioPDF_G4FAX;
  PDF_Title := '';
  PDF_Author := '';
  PDF_Subject := '';
  PDF_Keywords := '';
  PDF_Creator := '';
  PDF_Producer := '';

  {$ifdef IEINCLUDEIMAGINGANNOT}
  // Imaging Annotations
  if assigned(fImagingAnnot) then
    FreeAndNil(fImagingAnnot);
  {$endif}

  // ICC
  if assigned(fInputICC) then
    FreeAndNil(fInputICC);
  if assigned(fOutputICC) then
    FreeAndNil(fOutputICC);
  if assigned(fDefaultICC) then
    FreeAndNil(fDefaultICC);
  // RAW
  {$ifdef IEINCLUDERAWFORMATS}
  fRAW_HalfSize:=false;
  fRAW_Gamma:=0.6;
  fRAW_Bright:=1.0;
  fRAW_RedScale:=1.0;
  fRAW_BlueScale:=1.0;
  fRAW_QuickInterpolate:=true;
  fRAW_UseAutoWB:=false;
  fRAW_UseCameraWB:=false;
  fRAW_FourColorRGB:=false;
  fRAW_Camera:='';
  fRAW_GetExifThumbnail:=false;
  fRAW_AutoAdjustColors:=false;
  fRAW_ExtraParams:='';
  {$endif}
  // real RAW
  fBMPRAW_ChannelOrder:=coRGB;
  fBMPRAW_Planes:=plInterleaved;
  fBMPRAW_RowAlign:=8;
  fBMPRAW_HeaderSize:=0;
  fBMPRAW_DataFormat:=dfBinary;
  // XMP
  fXMP_Info:='';
end;


{!!
<FS>TIOParamsVals.Assign

<FM>Declaration<FC>
procedure Assign(Source: <A TIOParamsVals>);

<FM>Description<FN>
Copies all image format parameters from Source.

<FM>Example<FC>

ImageEnView1.IO.Params.Assign( ImageEnView2.IO.Params );
!!}
procedure TIOParamsVals.Assign(Source: TIOParamsVals);
var
  q: integer;
begin
  fFileName := Source.FileName;
  fFileType := Source.FileType;
  BitsPerSample := Source.BitsPerSample;
  SamplesPerPixel := Source.SamplesPerPixel;
  fWidth := Source.Width;
  fHeight := Source.Height;
  DpiX := Source.DpiX;
  DpiY := Source.DpiY;
  fColorMapCount := Source.ColorMapCount;
  IsNativePixelFormat := Source.IsNativePixelFormat;  // 3.0.3
  FreeColorMap;
  if Source.ColorMap <> nil then
  begin
    getmem(fColorMap, ColorMapCount * sizeof(TRGB));
    copymemory(ColorMap, Source.ColorMap, ColorMapCount * sizeof(TRGB));
  end;
  fImageIndex := Source.fImageIndex;
  fImageCount := Source.fImageCount;
  fGetThumbnail := Source.fGetThumbnail;
  fIsResource := Source.fIsResource;
  fEnableAdjustOrientation:=Source.fEnableAdjustOrientation;
  OriginalWidth := Source.OriginalWidth;
  OriginalHeight := Source.OriginalHeight;
  // TIFF
  TIFF_Compression := Source.TIFF_Compression;
  TIFF_ImageIndex := Source.TIFF_ImageIndex;
  TIFF_SubIndex := Source.TIFF_SubIndex;
  TIFF_PhotometInterpret := Source.TIFF_PhotometInterpret;
  TIFF_PlanarConf := Source.TIFF_PlanarConf;
  TIFF_XPos := Source.TIFF_XPos;
  TIFF_YPos := Source.TIFF_YPos;
  TIFF_GetTile := Source.TIFF_GetTile;
  TIFF_DocumentName := Source.TIFF_DocumentName;
  TIFF_ImageDescription := Source.TIFF_ImageDescription;
  TIFF_PageName := Source.TIFF_PageName;
  TIFF_PageNumber := Source.TIFF_PageNumber;
  TIFF_PageCount := Source.TIFF_PageCount;
  TIFF_Orientation := Source.TIFF_Orientation;
  TIFF_LZWDecompFunc := Source.TIFF_LZWDecompFunc;
  TIFF_LZWCompFunc := Source.TIFF_LZWCompFunc;
  fTIFF_ImageCount := Source.TIFF_ImageCount;
  fTIFF_EnableAdjustOrientation := Source.TIFF_EnableAdjustOrientation;
  fTIFF_JPEGQuality := Source.fTIFF_JPEGQuality;
  fTIFF_JPEGColorSpace := Source.fTIFF_JPEGColorSpace;
  fTIFF_FillOrder := Source.fTIFF_FillOrder;
  fTIFF_ZIPCompression := Source.fTIFF_ZIPCompression;
  fTIFF_ByteOrder := Source.fTIFF_ByteOrder;
  // GIF
  GIF_Version := Source.GIF_Version;
  GIF_ImageIndex := Source.GIF_ImageIndex;
  GIF_XPos := Source.GIF_XPos;
  GIF_YPos := Source.GIF_YPos;
  GIF_DelayTime := Source.GIF_DelayTime;
  GIF_FlagTranspColor := Source.GIF_FlagTranspColor;
  GIF_TranspColor := Source.GIF_TranspColor;
  GIF_Interlaced := Source.GIF_Interlaced;
  GIF_WinWidth := Source.GIF_WinWidth;
  GIF_WinHeight := Source.GIF_WinHeight;
  GIF_Background := Source.GIF_background;
  GIF_Ratio := Source.GIF_Ratio;
  GIF_LZWDecompFunc := Source.GIF_LZWDecompFunc;
  GIF_LZWCompFunc := Source.GIF_LZWCompFunc;
  fGIF_ImageCount := Source.GIF_ImageCount;
  GIF_Comments.Assign(Source.GIF_Comments);
  GIF_Action := Source.GIF_Action;
  // DCX
  DCX_ImageIndex:=Source.DCX_ImageIndex;
  // JPEG
  JPEG_ColorSpace := Source.JPEG_ColorSpace;
  JPEG_Quality := Source.JPEG_Quality;
  JPEG_DCTMethod := Source.JPEG_DCTMethod;
  JPEG_CromaSubsampling := Source.JPEG_CromaSubsampling;
  JPEG_OptimalHuffman := Source.JPEG_OptimalHuffman;
  JPEG_Smooth := Source.JPEG_Smooth;
  JPEG_Progressive := Source.JPEG_Progressive;
  JPEG_Scale := Source.JPEG_Scale;
  JPEG_MarkerList.Assign(Source.JPEG_MarkerList);
  JPEG_Scale_Used := Source.JPEG_Scale_Used;
  JPEG_EnableAdjustOrientation:=Source.JPEG_EnableAdjustOrientation;
  JPEG_GetExifThumbnail:=Source.JPEG_GetExifThumbnail;
  // JPEG2000
{$IFDEF IEINCLUDEJPEG2000}
  fJ2000_ColorSpace := Source.J2000_ColorSpace;
  fJ2000_Rate := Source.J2000_Rate;
  fJ2000_ScalableBy := Source.J2000_ScalableBy;
{$ENDIF}
  // PCX
  PCX_Version := Source.PCX_Version;
  PCX_Compression := Source.PCX_Compression;
  // BMP
  BMP_Version := Source.BMP_Version;
  BMP_Compression := Source.BMP_Compression;
  BMP_HandleTransparency := Source.BMP_HandleTransparency;
  // ICO
  ICO_ImageIndex := Source.ICO_ImageIndex;
  ICO_Background := Source.ICO_Background;
  move(Source.ICO_Sizes[0], ICO_Sizes[0], sizeof(TIOICOSizes));
  move(Source.ICO_BitCount[0], ICO_BitCount[0], sizeof(TIOICOBitCount));
  // CUR
  CUR_ImageIndex := Source.CUR_ImageIndex;
  CUR_XHotSpot := Source.CUR_XHotSpot;
  CUR_YHotSpot := Source.CUR_YHotSpot;
  CUR_Background := Source.CUR_background;
  // PNG
  PNG_Interlaced := Source.PNG_Interlaced;
  PNG_Background := Source.PNG_Background;
  PNG_Filter := Source.PNG_Filter;
  PNG_Compression := Source.PNG_Compression;
  PNG_TextKeys.Assign( Source.PNG_TextKeys );
  PNG_TextValues.Assign( Source.PNG_TextValues );
  // DICOM
  {$ifdef IEINCLUDEDICOM}
  DICOM_Tags.Assign( Source.DICOM_Tags );
  {$endif}
  // PSD
  PSD_LoadLayers := Source.PSD_LoadLayers;
  PSD_ReplaceLayers := Source.PSD_ReplaceLayers;
  fPSD_HasPremultipliedAlpha := Source.PSD_HasPremultipliedAlpha;
  // HDP
  fHDP_ImageQuality := Source.fHDP_ImageQuality;
  fHDP_Lossless := Source.fHDP_Lossless;
  // TGA
  TGA_XPos := Source.TGA_XPos;
  TGA_YPos := Source.TGA_YPos;
  TGA_Compressed := Source.TGA_Compressed;
  TGA_Descriptor := Source.TGA_Descriptor;
  TGA_Author := Source.TGA_Author;
  TGA_Date := Source.TGA_Date;
  TGA_ImageName := Source.TGA_ImageName;
  TGA_Background := Source.TGA_Background;
  TGA_AspectRatio := Source.TGA_AspectRatio;
  TGA_Gamma := Source.TGA_Gamma;
  TGA_GrayLevel := Source.TGA_GrayLevel;
  // AVI
  AVI_FrameCount := Source.AVI_FrameCount;
  AVI_FrameDelayTime := Source.AVI_FrameDelayTime;
  // IPTC
  IPTC_Info.Assign(Source.IPTC_Info);

  {$ifdef IEINCLUDEIMAGINGANNOT}
  // Imaging annotations
  if assigned(Source.fImagingAnnot) then
    ImagingAnnot.Assign(Source.ImagingAnnot)
  else if assigned(fImagingAnnot) then
    FreeAndNil(fImagingAnnot);
  {$endif}

  // ICC
  if assigned(Source.fInputICC) then
    InputICCProfile.Assign(Source.InputICCProfile)
  else if assigned(fInputICC) then
    FreeAndNil(fInputICC);
  if assigned(Source.fOutputICC) then
    OutputICCProfile.Assign(Source.OutputICCProfile)
  else if assigned(fOutputICC) then
    FreeAndNil(fOutputICC);
  if assigned(Source.fDefaultICC) then
    DefaultICCProfile.Assign(Source.DefaultICCProfile)
  else if assigned(fDefaultICC) then
    FreeAndNil(fDefaultICC);
  // PXM
  PXM_Comments.Assign(Source.PXM_Comments);
  // EXIF
  IECopyTList(Source.fEXIF_Tags, fEXIF_Tags);
  fEXIF_HasEXIFData := Source.fEXIF_HasEXIFData;
  if assigned(Source.fEXIF_Bitmap) then
  begin
    if not assigned(fEXIF_Bitmap) then
      fEXIF_Bitmap := TIEBitmap.Create;
    fEXIF_Bitmap.Assign(Source.fEXIF_Bitmap);
  end;
  fEXIF_ImageDescription := Source.fEXIF_ImageDescription;
  fEXIF_Make := Source.fEXIF_Make;
  fEXIF_Model := Source.fEXIF_Model;
  fEXIF_XResolution := Source.fEXIF_XResolution;
  fEXIF_YResolution := Source.fEXIF_YResolution;
  fEXIF_ResolutionUnit := Source.fEXIF_ResolutionUnit;
  fEXIF_Software := Source.fEXIF_Software;
  fEXIF_Artist := Source.fEXIF_Artist;
  fEXIF_DateTime := Source.fEXIF_DateTime;
  fEXIF_WhitePoint := Source.fEXIF_WhitePoint;
  for q := 0 to 5 do
    fEXIF_PrimaryChromaticities[q] := Source.fEXIF_PrimaryChromaticities[q];
  for q := 0 to 2 do
    fEXIF_YCbCrCoefficients[q] := Source.fEXIF_YCbCrCoefficients[q];
  fEXIF_YCbCrPositioning := Source.fEXIF_YCbCrPositioning;
  for q := 0 to 5 do
    fEXIF_ReferenceBlackWhite[q] := Source.fEXIF_ReferenceBlackWhite[q];
  fEXIF_Copyright := Source.fEXIF_Copyright;
  fEXIF_ExposureTime := Source.fEXIF_ExposureTime;
  fEXIF_FNumber := Source.fEXIF_FNumber;
  fEXIF_ExposureProgram := Source.fEXIF_ExposureProgram;
  fEXIF_ISOSpeedRatings[0] := Source.EXIF_ISOSpeedRatings[0];
  fEXIF_ISOSpeedRatings[1] := Source.EXIF_ISOSpeedRatings[1];
  fEXIF_ExifVersion := Source.EXIF_ExifVersion;
  fEXIF_DateTimeOriginal := Source.EXIF_DateTimeOriginal;
  fEXIF_DateTimeDigitized := Source.EXIF_DateTimeDigitized;
  fEXIF_CompressedBitsPerPixel := Source.EXIF_CompressedBitsPerPixel;
  fEXIF_ShutterSpeedValue := Source.EXIF_ShutterSpeedValue;
  fEXIF_ApertureValue := Source.EXIF_ApertureValue;
  fEXIF_BrightnessValue := Source.EXIF_BrightnessValue;
  fEXIF_ExposureBiasValue := Source.EXIF_ExposureBiasValue;
  fEXIF_MaxApertureValue := Source.EXIF_MaxApertureValue;
  fEXIF_SubjectDistance := Source.EXIF_SubjectDistance;
  fEXIF_MeteringMode := Source.EXIF_MeteringMode;
  fEXIF_LightSource := Source.EXIF_LightSource;
  fEXIF_Flash := Source.EXIF_Flash;
  fEXIF_FocalLength := Source.EXIF_FocalLength;
  fEXIF_SubsecTime := Source.EXIF_SubsecTime;
  fEXIF_SubsecTimeOriginal := Source.EXIF_SubsecTimeOriginal;
  fEXIF_SubsecTimeDigitized := Source.EXIF_SubsecTimeDigitized;
  fEXIF_FlashPixVersion := Source.EXIF_FlashPixVersion;
  fEXIF_ColorSpace := Source.EXIF_ColorSpace;
  fEXIF_ExifImageWidth := Source.EXIF_ExifImageWidth;
  fEXIF_ExifImageHeight := Source.EXIF_ExifImageHeight;
  fEXIF_RelatedSoundFile := Source.EXIF_RelatedSoundFile;
  fEXIF_FocalPlaneXResolution := Source.EXIF_FocalPlaneXResolution;
  fEXIF_FocalPlaneYResolution := Source.EXIF_FocalPlaneYResolution;
  fEXIF_FocalPlaneResolutionUnit := Source.EXIF_FocalPlaneResolutionUnit;
  fEXIF_ExposureIndex := Source.EXIF_ExposureIndex;
  fEXIF_SensingMethod := Source.EXIF_SensingMethod;
  fEXIF_FileSource := Source.EXIF_FileSource;
  fEXIF_SceneType := Source.EXIF_SceneType;
  fEXIF_UserComment := Source.EXIF_UserComment;
  fEXIF_UserCommentCode := Source.EXIF_UserCommentCode;
  fEXIF_MakerNote.Assign(source.EXIF_MakerNote);
  fEXIF_XPRating:=Source.EXIF_XPRating;
  fEXIF_XPTitle:=Source.EXIF_XPTitle;
  fEXIF_XPComment:=Source.EXIF_XPComment;
  fEXIF_XPAuthor:=Source.EXIF_XPAuthor;
  fEXIF_XPKeywords:=Source.EXIF_XPKeywords;
  fEXIF_XPSubject:=Source.EXIF_XPSubject;
  fEXIF_ExposureMode:=Source.fEXIF_ExposureMode;
  fEXIF_WhiteBalance:=Source.fEXIF_WhiteBalance;
  fEXIF_DigitalZoomRatio:=Source.fEXIF_DigitalZoomRatio;
  fEXIF_FocalLengthIn35mmFilm:=Source.fEXIF_FocalLengthIn35mmFilm;
  fEXIF_SceneCaptureType:=Source.fEXIF_SceneCaptureType;
  fEXIF_GainControl:=Source.fEXIF_GainControl;
  fEXIF_Contrast:=Source.fEXIF_Contrast;
  fEXIF_Saturation:=Source.fEXIF_Saturation;
  fEXIF_Sharpness:=Source.fEXIF_Sharpness;
  fEXIF_SubjectDistanceRange:=Source.fEXIF_SubjectDistanceRange;
  fEXIF_ImageUniqueID:=Source.fEXIF_ImageUniqueID;
  fEXIF_GPSVersionID:=Source.fEXIF_GPSVersionID;
  fEXIF_GPSLatitudeRef:=Source.fEXIF_GPSLatitudeRef;
  fEXIF_GPSLatitudeDegrees:=Source.fEXIF_GPSLatitudeDegrees;
  fEXIF_GPSLatitudeMinutes:=Source.fEXIF_GPSLatitudeMinutes;
  fEXIF_GPSLatitudeSeconds:=Source.fEXIF_GPSLatitudeSeconds;
  fEXIF_GPSLongitudeRef:=Source.fEXIF_GPSLongitudeRef;
  fEXIF_GPSLongitudeDegrees:=Source.fEXIF_GPSLongitudeDegrees;
  fEXIF_GPSLongitudeMinutes:=Source.fEXIF_GPSLongitudeMinutes;
  fEXIF_GPSLongitudeSeconds:=Source.fEXIF_GPSLongitudeSeconds;
  fEXIF_GPSAltitudeRef:=Source.fEXIF_GPSAltitudeRef;
  fEXIF_GPSAltitude:=Source.fEXIF_GPSAltitude;
  fEXIF_GPSTimeStampHour:=Source.fEXIF_GPSTimeStampHour;
  fEXIF_GPSTimeStampMinute:=Source.fEXIF_GPSTimeStampMinute;
  fEXIF_GPSTimeStampSecond:=Source.fEXIF_GPSTimeStampSecond;
  fEXIF_GPSSatellites:=Source.fEXIF_GPSSatellites;
  fEXIF_GPSStatus:=Source.fEXIF_GPSStatus;
  fEXIF_GPSMeasureMode:=Source.fEXIF_GPSMeasureMode;
  fEXIF_GPSDOP:=Source.fEXIF_GPSDOP;
  fEXIF_GPSSpeedRef:=Source.fEXIF_GPSSpeedRef;
  fEXIF_GPSSpeed:=Source.fEXIF_GPSSpeed;
  fEXIF_GPSTrackRef:=Source.fEXIF_GPSTrackRef;
  fEXIF_GPSTrack:=Source.fEXIF_GPSTrack;
  fEXIF_GPSImgDirectionRef:=Source.fEXIF_GPSImgDirectionRef;
  fEXIF_GPSImgDirection:=Source.fEXIF_GPSImgDirection;
  fEXIF_GPSMapDatum:=Source.fEXIF_GPSMapDatum;
  fEXIF_GPSDestLatitudeRef:=Source.fEXIF_GPSDestLatitudeRef;
  fEXIF_GPSDestLatitudeDegrees:=Source.fEXIF_GPSDestLatitudeDegrees;
  fEXIF_GPSDestLatitudeMinutes:=Source.fEXIF_GPSDestLatitudeMinutes;
  fEXIF_GPSDestLatitudeSeconds:=Source.fEXIF_GPSDestLatitudeSeconds;
  fEXIF_GPSDestLongitudeRef:=Source.fEXIF_GPSDestLongitudeRef;
  fEXIF_GPSDestLongitudeDegrees:=Source.fEXIF_GPSDestLongitudeDegrees;
  fEXIF_GPSDestLongitudeMinutes:=Source.fEXIF_GPSDestLongitudeMinutes;
  fEXIF_GPSDestLongitudeSeconds:=Source.fEXIF_GPSDestLongitudeSeconds;
  fEXIF_GPSDestBearingRef:=Source.fEXIF_GPSDestBearingRef;
  fEXIF_GPSDestBearing:=Source.fEXIF_GPSDestBearing;
  fEXIF_GPSDestDistanceRef:=Source.fEXIF_GPSDestDistanceRef;
  fEXIF_GPSDestDistance:=Source.fEXIF_GPSDestDistance;
  fEXIF_GPSDateStamp:=Source.fEXIF_GPSDateStamp;
  // PS
  fPS_PaperWidth := Source.fPS_PaperWidth;
  fPS_PaperHeight := Source.fPS_PaperHeight;
  fPS_Compression := Source.fPS_Compression;
  fPS_Title := Source.fPS_Title;
  // PDF
  fPDF_PaperWidth := Source.fPDF_PaperWidth;
  fPDF_PaperHeight := Source.fPDF_PaperHeight;
  fPDF_Compression := Source.fPDF_Compression;
  fPDF_Title := Source.fPDF_Title;
  fPDF_Author := Source.fPDF_Author;
  fPDF_Subject := Source.fPDF_Subject;
  fPDF_Keywords := Source.fPDF_Keywords;
  fPDF_Creator := Source.fPDF_Creator;
  fPDF_Producer := Source.fPDF_Producer;
  // RAW
  {$ifdef IEINCLUDERAWFORMATS}
  fRAW_HalfSize:=Source.fRAW_HalfSize;
  fRAW_Gamma:=Source.fRAW_Gamma;
  fRAW_Bright:=Source.fRAW_Bright;
  fRAW_RedScale:=Source.fRAW_RedScale;
  fRAW_BlueScale:=Source.fRAW_BlueScale;
  fRAW_QuickInterpolate:=Source.fRAW_QuickInterpolate;
  fRAW_UseAutoWB:=Source.fRAW_UseAutoWB;
  fRAW_UseCameraWB:=Source.fRAW_UseCameraWB;
  fRAW_FourColorRGB:=Source.fRAW_FourColorRGB;
  fRAW_Camera:=Source.fRAW_Camera;
  fRAW_GetExifThumbnail:=Source.fRAW_GetExifThumbnail;
  fRAW_AutoAdjustColors:=Source.fRAW_AutoAdjustColors;
  fRAW_ExtraParams:=Source.fRAW_ExtraParams;
  {$endif}
  // Real RAW
  fBMPRAW_ChannelOrder:=Source.fBMPRAW_ChannelOrder;
  fBMPRAW_Planes:=Source.fBMPRAW_Planes;
  fBMPRAW_RowAlign:=Source.fBMPRAW_RowAlign;
  fBMPRAW_HeaderSize:=Source.fBMPRAW_HeaderSize;
  fBMPRAW_DataFormat:=Source.fBMPRAW_DataFormat;
  // XMP
  fXMP_Info:=Source.fXMP_Info;
end;

// assign compression parameters

procedure TIOParamsVals.AssignCompressionInfo(Source: TIOParamsVals);
begin
  BitsPerSample := Source.BitsPerSample;
  SamplesPerPixel := Source.SamplesPerPixel;
  // TIFF
  TIFF_Compression := Source.TIFF_Compression;
  TIFF_PhotometInterpret := Source.TIFF_PhotometInterpret;
  TIFF_PlanarConf := Source.TIFF_PlanarConf;
  TIFF_Orientation := Source.TIFF_Orientation;
  TIFF_LZWDecompFunc := Source.TIFF_LZWDecompFunc;
  TIFF_LZWCompFunc := Source.TIFF_LZWCompFunc;
  fTIFF_EnableAdjustOrientation := Source.TIFF_EnableAdjustOrientation;
  fTIFF_JPEGQuality := Source.fTIFF_JPEGQuality;
  fTIFF_JPEGColorSpace := Source.fTIFF_JPEGColorSpace;
  fTIFF_FillOrder := Source.fTIFF_FillOrder;
  fTIFF_ZIPCompression := Source.fTIFF_ZIPCompression;
  // GIF
  GIF_Interlaced := Source.GIF_Interlaced;
  GIF_LZWDecompFunc := Source.GIF_LZWDecompFunc;
  GIF_LZWCompFunc := Source.GIF_LZWCompFunc;
  // JPEG
  JPEG_ColorSpace := Source.JPEG_ColorSpace;
  JPEG_Quality := Source.JPEG_Quality;
  JPEG_DCTMethod := Source.JPEG_DCTMethod;
  JPEG_CromaSubsampling := Source.JPEG_CromaSubsampling;
  JPEG_OptimalHuffman := Source.JPEG_OptimalHuffman;
  JPEG_Smooth := Source.JPEG_Smooth;
  JPEG_Progressive := Source.JPEG_Progressive;
  // JPEG2000
{$IFDEF IEINCLUDEJPEG2000}
  fJ2000_ColorSpace := Source.J2000_ColorSpace;
  fJ2000_Rate := Source.J2000_Rate;
  fJ2000_ScalableBy := Source.J2000_ScalableBy;
{$ENDIF}
  // PCX
  PCX_Version := Source.PCX_Version;
  PCX_Compression := Source.PCX_Compression;
  // BMP
  BMP_Version := Source.BMP_Version;
  BMP_Compression := Source.BMP_Compression;
  BMP_HandleTransparency := Source.BMP_HandleTransparency;
  // ICO
  // CUR
  // PNG
  PNG_Interlaced := Source.PNG_Interlaced;
  PNG_Filter := Source.PNG_Filter;
  PNG_Compression := Source.PNG_Compression;
  // TGA
  TGA_Compressed := Source.TGA_Compressed;
  TGA_GrayLevel := Source.TGA_GrayLevel;
  // AVI
  // IPTC
  // PXM
  // EXIF
  // PS
  PS_Compression := Source.PS_Compression;
  // PDF
  PDF_Compression := Source.PDF_Compression;
end;

procedure TIOParamsVals.SetEXIF_ISOSpeedRatings(index: integer; v: integer);
begin
  fEXIF_ISOSpeedRatings[index] := v;
end;

function TIOParamsVals.GetEXIF_ISOSpeedRatings(index: integer): integer;
begin
  result := fEXIF_ISOSpeedRatings[index];
end;

procedure TIOParamsVals.SetEXIF_ReferenceBlackWhite(index: integer; v: double);
begin
  fEXIF_ReferenceBlackWhite[index] := v;
end;

function TIOParamsVals.GetEXIF_ReferenceBlackWhite(index: integer): double;
begin
  result := fEXIF_ReferenceBlackWhite[index];
end;

procedure TIOParamsVals.SetEXIF_WhitePoint(index: integer; v: double);
begin
  fEXIF_WhitePoint[index] := v;
end;

function TIOParamsVals.GetEXIF_WhitePoint(index: integer): double;
begin
  result := fEXIF_WhitePoint[index];
end;

procedure TIOParamsVals.SetEXIF_PrimaryChromaticities(index: integer; v: double);
begin
  fEXIF_PrimaryChromaticities[index] := v;
end;

function TIOParamsVals.GetEXIF_PrimaryChromaticities(index: integer): double;
begin
  result := fEXIF_PrimaryChromaticities[index];
end;

procedure TIOParamsVals.SetEXIF_YCbCrCoefficients(index: integer; v: double);
begin
  fEXIF_YCbCrCoefficients[index] := v;
end;

function TIOParamsVals.GetEXIF_YCbCrCoefficients(index: integer): double;
begin
  result := fEXIF_YCbCrCoefficients[index];
end;

{!!
<FS>TIOParamsVals.SaveToFile

<FM>Declaration<FC>
procedure SaveToFile(const FileName:WideString);

<FM>Description<FN>
SaveToFile saves the file format parameters.

<FM>Example<FC>

// Saves default parameters
ImageEnView1.IO.Params.TIFF_Compression:=ioTIFF_LZW;
ImageEnView1.IO.Params.SaveToFile('default');

....

// Load default parameters
ImageEnView1.IO.Params.LoadFromFile('default');
!!}
procedure TIOParamsVals.SaveToFile(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  fs := nil;
  try
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    SaveToStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TIOParamsVals.LoadFromFile

<FM>Declaration<FC>
procedure LoadFromFile(const FileName:WideString);

<FM>Description<FN>
Loads the file formats parameters.

<FM>Example<FC>

// Saves default parameters
ImageEnView1.IO.Params.TIFF_Compression:=ioTIFF_LZW;
ImageEnView1.IO.Params.SaveToFile('default');

....

// Load default parameters
ImageEnView1.IO.Params.LoadFromFile('default');
!!}
procedure TIOParamsVals.LoadFromFile(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  fs := nil;
  try
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    LoadFromStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

procedure TIOParamsVals.SetDpi(Value: integer);
begin
  DpiX := Value;
  DpiY := Value;
end;

{!!
<FS>TIOParamsVals.DpiX

<FM>Declaration<FC>
property DpiX: integer;

<FM>Description<FN>
Specifies the DpiX (horizontal dots per inch) of the image.

<FM>See also<FN>
<A TIOParamsVals.Dpi>
<A TIOParamsVals.DpiY>
!!}
procedure TIOParamsVals.SetDpiX(Value: integer);
begin
  fDpiX := Value;
  fEXIF_XResolution := Value;
  if assigned(fImageEnIO) and assigned(fImageEnIO.fImageEnView) and (fImageEnIO.fImageEnView is TImageEnView) then
  begin
    (fImageEnIO.fImageEnView as TImageEnView).LockUpdate;
    fImageEnIO.fImageEnView.DpiX := Value;
    (fImageEnIO.fImageEnView as TImageEnView).UnLockUpdateEx;
  end;
end;

{!!
<FS>TIOParamsVals.DpiY

<FM>Declaration<FC>
property DpiY: integer;

<FM>Description<FN>
Specifies the DpiY (vertical dots per inch) of the image.

<FM>See also<FN>
<A TIOParamsVals.Dpi>
<A TIOParamsVals.DpiX>
!!}
procedure TIOParamsVals.SetDpiY(Value: integer);
begin
  fDpiY := Value;
  fEXIF_YResolution := Value;
  if assigned(fImageEnIO) and assigned(fImageEnIO.fImageEnView) and (fImageEnIO.fImageEnView is TImageEnView) then
  begin
    (fImageEnIO.fImageEnView as TImageEnView).LockUpdate;
    fImageEnIO.fImageEnView.DpiY := Value;
    (fImageEnIO.fImageEnView as TImageEnView).UnLockUpdateEx;
  end;
end;

procedure TIOParamsVals.SetImageIndex(value:integer);
begin
  fImageIndex:=value;
  fTIFF_ImageIndex:=value;
  fDCX_ImageIndex:=value;
  fGIF_ImageIndex:=value;
  fICO_ImageIndex:=value;
  fCUR_ImageIndex:=value;
end;

procedure TIOParamsVals.SetEnableAdjustOrientation(value:boolean);
begin
  fEnableAdjustOrientation:=value;
  fTIFF_EnableAdjustOrientation:=value;
  fJPEG_EnableAdjustOrientation:=value;
end;

procedure TIOParamsVals.SetImageCount(value:integer);
begin
  fImageCount:=value;
  fTIFF_ImageCount:=value;
  fAVI_FrameCount:=value;
  fGIF_ImageCount:=value;
  {$IFDEF IEINCLUDEDIRECTSHOW}
  fMEDIAFILE_FrameCount:=value;
  {$ENDIF}
end;

procedure TIOParamsVals.SetGetThumbnail(value:boolean);
begin
  fGetThumbnail:=value;
  fJPEG_GetExifThumbnail:=value;
  {$ifdef IEINCLUDERAWFORMATS}
  fRAW_GetExifThumbnail:=value;
  {$endif}
end;

procedure TIOParamsVals.SetIsResource(value:boolean);
begin
  fIsResource := value;
end;

procedure TIOParamsVals.SetJPEG_GetExifThumbnail(value:boolean);
begin
  fGetThumbnail:=value;
  fJPEG_GetExifThumbnail:=value;
end;

{$ifdef IEINCLUDERAWFORMATS}
procedure TIOParamsVals.SetRAW_GetExifThumbnail(value:boolean);
begin
  fRAW_GetExifThumbnail:=value;
end;
{$endif}

procedure TIOParamsVals.SetTIFF_Orientation(Value: integer);
begin
  fTIFF_Orientation := Value;
  fEXIF_Orientation := Value;
end;

procedure TIOParamsVals.SetEXIF_Orientation(Value: integer);
begin
  fEXIF_Orientation := Value;
  fTIFF_Orientation := Value;
end;

procedure TIOParamsVals.SetEXIF_XResolution(Value: double);
begin
  SetDpiX(trunc(Value));
  fEXIF_XResolution := Value;  // because SetDpiX assign truncated value
end;

procedure TIOParamsVals.SetEXIF_YResolution(Value: double);
begin
  SetDpiY(trunc(Value));
  fEXIF_YResolution:=Value;  // because SetDpiX assign truncated value
end;

{!!
<FS>TIOParamsVals.InputICCProfile

<FM>Declaration<FC>
property InputICCProfile: <A TIEICC>;

<FM>Description<FN>
InputICCProfile contains the ICC profile associated with the loaded image.
If <A iegEnableCMS> is True and ImageEn has a CMS, the <A TIOParamsVals.InputICCProfile> and <A TIOParamsVals.OutputICCProfile> are applied when you load the image.
!!}
function TIOParamsVals.GetInputICC:TIEICC;
begin
  if not assigned(fInputICC) then
    fInputICC:=TIEICC.Create;
  result:=fInputICC;
end;

{!!
<FS>TIOParamsVals.DefaultICCProfile

<FM>Declaration<FC>
property DefaultICCProfile: <A TIEICC>;

<FM>Description<FN>
DefaultICCProfile contains a default ICC profile associated with the loaded image.
A default ICC profile is used only when the loaded image has not a own ICC profile.

<FM>Example<FC>

ImageEnView1.IO.Params.DefaultICCProfile.LoadFromFile('c:\Windows\System32\spool\drivers\color\AdobeRGB1998.icc');
ImageEnView1.IO.LoadFromFile('input.tif');
!!}
function TIOParamsVals.GetDefaultICC:TIEICC;
begin
  if not assigned(fDefaultICC) then
    fDefaultICC:=TIEICC.Create;
  result:=fDefaultICC;
end;

{!!
<FS>TIOParamsVals.OutputICCProfile

<FM>Declaration<FC>
property OutputICCProfile: <A TIEICC>;

<FM>Description<FN>
OutputICCProfile contains the ICC profile associated with the current display system. The default profile is sRGB..
If <A iegEnableCMS> is True and ImageEn has a CMS, the <A TIOParamsVals.InputICCProfile> and <A TIOParamsVals.OutputICCProfile> are applied when you load the image.
!!}
function TIOParamsVals.GetOutputICC:TIEICC;
begin
  if not assigned(fOutputICC) then
  begin
    fOutputICC:=TIEICC.Create;
    fOutputICC.Assign_sRGBProfile;
  end;
  result:=fOutputICC;
end;

{!!
<FS>TIOParamsVals.ImagingAnnot

<FM>Declaration<FC>
property ImagingAnnot:<A TIEImagingAnnot>;

<FM>Description<FN>
ImagingAnnot contains the (Wang) imaging annotations loaded (or to save) from a TIFF.
Using <A TIEImagingAnnot> object you can create new objects, copy to a <A TImageEnVect> (as vectorial objects), copy from a <A TImageEnVect> (from vectorial objects) or just draw on the bitmap.

<FM>Example<FC>
// load an image and all annotations from input.tif . This allow to modify the annotations:
ImageEnVect1.IO.LoadFromFile('input.tif');
ImageEnVect1.IO.Params.ImagingAnnot.CopyToTImageEnVect( ImageEnVect1 );

// load an image and all annotations from input.tif, but just draw on the image (for display):
ImageEnVect1.IO.LoadFromFile('input.tif');
ImageEnVect1.IO.Params.ImagingAnnot.DrawToBitmap( ImageEnVect1.IEBitmap, true );
ImageEnVect1.Update;
!!}
{$ifdef IEINCLUDEIMAGINGANNOT}
function TIOParamsVals.GetImagingAnnot:TIEImagingAnnot;
begin
  if not assigned(fImagingAnnot) then
  begin
    fImagingAnnot:=TIEImagingAnnot.Create;
    fImagingAnnot.Parent:=self;
  end;
  result:=fImagingAnnot;
end;
{$endif}

{!!
<FS>TIOParamsVals.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream:TStream);

<FM>Description<FN>
Saves the file format parameters.
!!}
// the first integer is the version
procedure TIOParamsVals.SaveToStream(Stream: TStream);
var
  ver:integer;
  //i:integer;
  i32:integer;
  ms:TMemoryStream;
  ab:boolean;
  pr:TProgressRec;
begin
  ver := 44;
  Stream.Write(ver, sizeof(integer));

  // EXIF (embedded in a TIFF). Must be the first loading so next tags can be set correctly
  ms := TMemoryStream.Create;
  try
    ab := false;
    pr.fOnProgress := nil;
    pr.Sender := nil;
    pr.Aborting := @ab;
    TIFFWriteStream(ms, false, nil, self, pr);
    i32 := ms.Size;
    Stream.Write(i32, sizeof(integer));
    IECopyFrom(Stream, ms, 0);
  finally
    ms.Free;
  end;

  // Generics
  SaveStringToStream(Stream, AnsiString(fFileName));
  Stream.Write(fFileType, sizeof(TIOFileType));
  Stream.Write(fBitsPerSample, sizeof(integer));
  Stream.Write(fSamplesPerPixel, sizeof(integer));
  Stream.Write(fWidth, sizeof(integer));
  Stream.Write(fHeight, sizeof(integer));
  Stream.Write(fDpiX, sizeof(integer));
  Stream.Write(fDpiY, sizeof(integer));
  Stream.Write(fColorMapCount, sizeof(integer));
  if fColorMapCount > 0 then
    Stream.Write(fColorMap^, fColorMapCount * sizeof(TRGB));
  Stream.Write(fImageIndex, sizeof(integer));
  Stream.Write(fImageCount, sizeof(integer));
  Stream.Write(fGetThumbnail, sizeof(boolean));
  Stream.Write(fEnableAdjustOrientation, sizeof(boolean));
  Stream.Write(fIsResource, sizeof(boolean));

  // TIFF
  Stream.Write(fTIFF_Compression, sizeof(TIOTIFFCompression));
  Stream.Write(fTIFF_ImageIndex, sizeof(integer));
  Stream.Write(fTIFF_PhotometInterpret, sizeof(TIOTIFFPhotometInterpret));
  Stream.Write(fTIFF_PlanarConf, sizeof(integer));
  Stream.Write(fTIFF_XPos, sizeof(integer));
  Stream.Write(fTIFF_YPos, sizeof(integer));
  SaveStringToStream(Stream, fTIFF_DocumentName);
  SaveStringToStream(Stream, fTIFF_ImageDescription);
  SaveStringToStream(Stream, fTIFF_PageName);
  Stream.Write(fTIFF_PageNumber, sizeof(integer));
  Stream.Write(fTIFF_PageCount, sizeof(integer));
  Stream.Write(fTIFF_ImageCount, sizeof(integer));
  Stream.Write(fTIFF_Orientation, sizeof(integer));
  Stream.Write(fTIFF_JPEGQuality, sizeof(integer));
  Stream.Write(fTIFF_JPEGColorSpace, sizeof(TIOJPEGColorSpace));
  Stream.Write(fTIFF_FillOrder, sizeof(integer));
  Stream.Write(fTIFF_ZIPCompression, sizeof(integer));
  Stream.Write(fTIFF_SubIndex, sizeof(integer));
  Stream.Write(fTIFF_ByteOrder, sizeof(TIOByteOrder));
  Stream.Write(fTIFF_GetTile, sizeof(integer));

  // GIF
  SaveStringToStream(Stream, fGIF_Version);
  Stream.Write(fGIF_ImageIndex, sizeof(integer));
  Stream.Write(fGIF_XPos, sizeof(integer));
  Stream.Write(fGIF_YPos, sizeof(integer));
  Stream.Write(fGIF_DelayTime, sizeof(integer));
  Stream.Write(fGIF_FlagTranspColor, sizeof(boolean));
  Stream.Write(fGIF_TranspColor, sizeof(TRGB));
  Stream.Write(fGIF_Interlaced, sizeof(boolean));
  Stream.Write(fGIF_WinWidth, sizeof(integer));
  Stream.Write(fGIF_WinHeight, sizeof(integer));
  Stream.Write(fGIF_Background, sizeof(TRGB));
  Stream.Write(fGIF_Ratio, sizeof(integer));
  Stream.Write(fGIF_ImageCount, sizeof(integer));
  SaveStringListToStream(Stream, fGIF_Comments);
  Stream.Write(fGIF_Action, sizeof(TIEGIFAction));

  // JPEG
  Stream.Write(fJPEG_ColorSpace, sizeof(TIOJPEGColorSpace));
  Stream.Write(fJPEG_Quality, sizeof(integer));
  Stream.Write(fJPEG_DCTMethod, sizeof(TIOJPEGDCTMethod));
  Stream.Write(fJPEG_OptimalHuffman, sizeof(boolean));
  Stream.Write(fJPEG_Smooth, sizeof(integer));
  Stream.Write(fJPEG_Progressive, sizeof(boolean));
  Stream.Write(fJPEG_Scale, sizeof(TIOJPEGScale));
  fJPEG_MarkerList.SaveToStream(Stream);
  Stream.Write(fOriginalWidth, sizeof(integer));    // since 3.0.2 common to all formats (file position invaried due file compatibility)
  Stream.Write(fOriginalHeight, sizeof(integer));   // since 3.0.2 common to all formats (file position invaried due file compatibility)
  Stream.Write(fJPEG_EnableAdjustOrientation, sizeof(boolean));
  Stream.Write(fJPEG_GetExifThumbnail,sizeof(boolean));
  Stream.Write(fJPEG_CromaSubsampling, sizeof(TIOJPEGCromaSubsampling));

  // JPEG2000
{$IFDEF IEINCLUDEJPEG2000}
  Stream.Write(fJ2000_ColorSpace, sizeof(TIOJ2000ColorSpace));
  Stream.Write(fJ2000_Rate, sizeof(double));
  Stream.Write(fJ2000_ScalableBy, sizeof(TIOJ2000ScalableBy));
{$ENDIF}

  // PCX
  Stream.Write(fPCX_Version, sizeof(integer));
  Stream.Write(fPCX_Compression, sizeof(TIOPCXCompression));

  // BMP
  Stream.Write(fBMP_Version, sizeof(TIOBMPVersion));
  Stream.Write(fBMP_Compression, sizeof(TIOBMPCompression));
  Stream.Write(fBMP_HandleTransparency, sizeof(boolean));

  // ICO
  Stream.Write(fICO_ImageIndex, sizeof(integer));
  Stream.Write(fICO_Background, sizeof(TRGB));
  Stream.Write(ICO_Sizes[0], sizeof(TIOICOSizes));
  Stream.Write(ICO_BitCount[0], sizeof(TIOICOBitCount));

  // CUR
  Stream.Write(fCUR_ImageIndex, sizeof(integer));
  Stream.Write(fCUR_XHotSpot, sizeof(integer));
  Stream.Write(fCUR_YHotSpot, sizeof(integer));
  Stream.Write(fCUR_Background, sizeof(TRGB));

  // PNG
  Stream.Write(fPNG_Interlaced, sizeof(boolean));
  Stream.Write(fPNG_Background, sizeof(TRGB));
  Stream.Write(fPNG_Filter, sizeof(TIOPNGFilter));
  Stream.Write(fPNG_Compression, sizeof(integer));
  SaveStringListToStream(Stream,fPNG_TextKeys);
  SaveStringListToStream(Stream,fPNG_TextValues);

  // DICOM
  {$ifdef IEINCLUDEDICOM}
  DICOM_Tags.SaveToStream(Stream);
  {$endif}

  // PSD
  Stream.Write(fPSD_LoadLayers,sizeof(boolean));
  Stream.Write(fPSD_ReplaceLayers,sizeof(boolean));
  Stream.Write(fPSD_HasPremultipliedAlpha,sizeof(boolean));

  // HDP
  Stream.Write(fHDP_ImageQuality, sizeof(double));
  Stream.Write(fHDP_Lossless, sizeof(boolean));

  // TGA
  Stream.Write(fTGA_XPos, sizeof(integer));
  Stream.Write(fTGA_YPos, sizeof(integer));
  Stream.Write(fTGA_Compressed, sizeof(boolean));
  SaveStringToStream(Stream, fTGA_Descriptor);
  SaveStringToStream(Stream, fTGA_Author);
  Stream.Write(fTGA_Date, sizeof(TDateTime));
  SaveStringToStream(Stream, fTGA_ImageName);
  Stream.Write(fTGA_Background, sizeof(TRGB));
  Stream.Write(fTGA_AspectRatio, sizeof(double));
  Stream.Write(fTGA_Gamma, sizeof(double));
  Stream.Write(fTGA_GrayLevel, sizeof(boolean));

  // IPTC
  fIPTC_Info.SaveToStream(Stream);

  // PXM
  SaveStringListToStream(Stream, fPXM_Comments);

  // AVI
  Stream.Write(fAVI_FrameCount, sizeof(integer));
  Stream.Write(fAVI_FrameDelayTIme, sizeof(integer));

  // PS
  Stream.Write(fPS_PaperWidth, sizeof(integer));
  Stream.Write(fPS_PaperHeight, sizeof(integer));
  Stream.Write(fPS_Compression, sizeof(TIOPSCompression));
  SaveStringToStream(Stream, fPS_Title);

  // PDF
  Stream.Write(fPDF_PaperWidth, sizeof(integer));
  Stream.Write(fPDF_PaperHeight, sizeof(integer));
  Stream.Write(fPDF_Compression, sizeof(TIOPDFCompression));
  SaveStringToStream(Stream, fPDF_Title);
  SaveStringToStream(Stream, fPDF_Author);
  SaveStringToStream(Stream, fPDF_Subject);
  SaveStringToStream(Stream, fPDF_Keywords);
  SaveStringToStream(Stream, fPDF_Creator);
  SaveStringToStream(Stream, fPDF_Producer);

  // DCX
  Stream.Write(fDCX_ImageIndex, sizeof(integer));

  {$ifdef IEINCLUDEIMAGINGANNOT}
  // imaging annotations
  ImagingAnnot.SaveToStream(Stream);
  {$endif}

  // ICC
  InputICCProfile.SaveToStream(Stream,false);
  OutputICCProfile.SaveToStream(Stream,false);
  DefaultICCProfile.SaveToStream(Stream,false);

  // RAW
  {$ifdef IEINCLUDERAWFORMATS}
  Stream.Write(fRAW_HalfSize,sizeof(boolean));
  Stream.Write(fRAW_Gamma,sizeof(double));
  Stream.Write(fRAW_Bright,sizeof(double));
  Stream.Write(fRAW_RedScale,sizeof(double));
  Stream.Write(fRAW_BlueScale,sizeof(double));
  Stream.Write(fRAW_QuickInterpolate,sizeof(boolean));
  Stream.Write(fRAW_UseAutoWB,sizeof(boolean));
  Stream.Write(fRAW_UseCameraWB,sizeof(boolean));
  Stream.Write(fRAW_FourColorRGB,sizeof(boolean));
  SaveStringToStream(Stream, fRAW_Camera);
  Stream.Write(fRAW_GetExifThumbnail,sizeof(boolean));
  Stream.Write(fRAW_AutoAdjustColors,sizeof(boolean));
  SaveStringToStream(Stream, fRAW_ExtraParams);
  {$endif}
  {$ifdef IEINCLUDEDIRECTSHOW}
  Stream.Write(fMEDIAFILE_FrameCount,sizeof(integer));
  Stream.Write(fMEDIAFILE_FrameDelayTime,sizeof(integer));
  {$endif}

  // real RAW
  Stream.Write(fBMPRAW_ChannelOrder,sizeof(TIOBMPRAWChannelOrder));
  Stream.Write(fBMPRAW_Planes,sizeof(TIOBMPRAWPlanes));
  Stream.Write(fBMPRAW_RowAlign,sizeof(integer));
  Stream.Write(fBMPRAW_HeaderSize,sizeof(integer));
  Stream.Write(fBMPRAW_DataFormat,sizeof(TIOBMPRAWDataFormat));

  // EXIF
  (*
  i32 := fEXIF_Tags.Count;
  Stream.Write(i32, sizeof(i32));
  for i:=0 to fEXIF_Tags.Count-1 do
  begin
    i32 := integer(fEXIF_Tags[i]);
    Stream.Write(i32, sizeof(i32));
  end;
  Stream.Write(fEXIF_HasEXIFData, sizeof(boolean));
  Stream.Write(fEXIF_Orientation, sizeof(integer));
  Stream.Write(fEXIF_Bitmap: TIEBitmap;
    fEXIF_ImageDescription: AnsiString;
    fEXIF_Make: AnsiString;
    fEXIF_Model: AnsiString;
    fEXIF_XResolution: double;
    fEXIF_YResolution: double;
    fEXIF_ResolutionUnit: integer;
    fEXIF_Software: AnsiString;
    fEXIF_Artist:AnsiString;
    fEXIF_DateTime: AnsiString;
    fEXIF_WhitePoint: array[0..1] of double;
    fEXIF_PrimaryChromaticities: array[0..5] of double;
    fEXIF_YCbCrCoefficients: array[0..2] of double;
    fEXIF_YCbCrPositioning: integer;
    fEXIF_ReferenceBlackWhite: array[0..5] of double;
    fEXIF_Copyright: AnsiString;
    fEXIF_ExposureTime: double;
    fEXIF_FNumber: double;
    fEXIF_ExposureProgram: integer;
    fEXIF_ISOSpeedRatings: array[0..1] of integer;
    fEXIF_ExifVersion: AnsiString;
    fEXIF_DateTimeOriginal: AnsiString;
    fEXIF_DateTimeDigitized: AnsiString;
    fEXIF_CompressedBitsPerPixel: double;
    fEXIF_ShutterSpeedValue: double;
    fEXIF_ApertureValue: double;
    fEXIF_BrightnessValue: double;
    fEXIF_ExposureBiasValue: double;
    fEXIF_MaxApertureValue: double;
    fEXIF_SubjectDistance: double;
    fEXIF_MeteringMode: integer;
    fEXIF_LightSource: integer;
    fEXIF_Flash: integer;
    fEXIF_FocalLength: double;
    fEXIF_SubsecTime: AnsiString;
    fEXIF_SubsecTimeOriginal: AnsiString;
    fEXIF_SubsecTimeDigitized: AnsiString;
    fEXIF_FlashPixVersion: AnsiString;
    fEXIF_ColorSpace: integer;
    fEXIF_ExifImageWidth: integer;
    fEXIF_ExifImageHeight: integer;
    fEXIF_RelatedSoundFile: AnsiString;
    fEXIF_FocalPlaneXResolution: double;
    fEXIF_FocalPlaneYResolution: double;
    fEXIF_FocalPlaneResolutionUnit: integer;
    fEXIF_ExposureIndex: double;
    fEXIF_SensingMethod: integer;
    fEXIF_FileSource: integer;
    fEXIF_SceneType: integer;
    fEXIF_UserComment: WideString;
    fEXIF_UserCommentCode: AnsiString;
    fEXIF_MakerNote:TIETagsHandler;
    fEXIF_XPRating:integer;
    fEXIF_XPTitle:WideString;
    fEXIF_XPComment:WideString;
    fEXIF_XPAuthor:WideString;
    fEXIF_XPKeywords:WideString;
    fEXIF_XPSubject:WideString;
    fEXIF_ExposureMode:integer;
    fEXIF_WhiteBalance:integer;
    fEXIF_DigitalZoomRatio:double;
    fEXIF_FocalLengthIn35mmFilm:integer;
    fEXIF_SceneCaptureType:integer;
    fEXIF_GainControl:integer;
    fEXIF_Contrast:integer;
    fEXIF_Saturation:integer;
    fEXIF_Sharpness:integer;
    fEXIF_SubjectDistanceRange:integer;
    fEXIF_ImageUniqueID:AnsiString;
    fEXIF_GPSVersionID:AnsiString;
    fEXIF_GPSLatitudeRef:AnsiString;
    fEXIF_GPSLatitudeDegrees:double;
    fEXIF_GPSLatitudeMinutes:double;
    fEXIF_GPSLatitudeSeconds:double;
    fEXIF_GPSLongitudeRef:AnsiString;
    fEXIF_GPSLongitudeDegrees:double;
    fEXIF_GPSLongitudeMinutes:double;
    fEXIF_GPSLongitudeSeconds:double;
    fEXIF_GPSAltitudeRef:AnsiString;
    fEXIF_GPSAltitude:double;
    fEXIF_GPSTimeStampHour:double;
    fEXIF_GPSTimeStampMinute:double;
    fEXIF_GPSTimeStampSecond:double;
    fEXIF_GPSSatellites:AnsiString;
    fEXIF_GPSStatus:AnsiString;
    fEXIF_GPSMeasureMode:AnsiString;
    fEXIF_GPSDOP:double;
    fEXIF_GPSSpeedRef:AnsiString;
    fEXIF_GPSSpeed:double;
    fEXIF_GPSTrackRef:AnsiString;
    fEXIF_GPSTrack:double;
    fEXIF_GPSImgDirectionRef:AnsiString;
    fEXIF_GPSImgDirection:double;
    fEXIF_GPSMapDatum:AnsiString;
    fEXIF_GPSDestLatitudeRef:AnsiString;
    fEXIF_GPSDestLatitudeDegrees:double;
    fEXIF_GPSDestLatitudeMinutes:double;
    fEXIF_GPSDestLatitudeSeconds:double;
    fEXIF_GPSDestLongitudeRef:AnsiString;
    fEXIF_GPSDestLongitudeDegrees:double;
    fEXIF_GPSDestLongitudeMinutes:double;
    fEXIF_GPSDestLongitudeSeconds:double;
    fEXIF_GPSDestBearingRef:AnsiString;
    fEXIF_GPSDestBearing:double;
    fEXIF_GPSDestDistanceRef:AnsiString;
    fEXIF_GPSDestDistance:double;
    fEXIF_GPSDateStamp:AnsiString;
  *)

end;

{!!
<FS>TIOParamsVals.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream:TStream);

<FM>Description<FN>
Loads the file formats parameters.
!!}
// read params stream
procedure TIOParamsVals.LoadFromStream(Stream: TStream);
var
  ver, i32:integer;
  b:byte;
  idummy:integer;
  ss:AnsiString;
  ms:TMemoryStream;
  ab:boolean;
  pr:TProgressRec;
  alpha:TIEMask;
begin
  Stream.Read(ver, sizeof(integer));

  if ver>=43 then
  begin
    alpha := nil;
    ms := TMemoryStream.Create;
    try
      Stream.Read(i32, sizeof(integer));
      if i32 > 0 then
        ms.CopyFrom(Stream, i32);
      ms.Position := 0;
      ab := false;
      pr.fOnProgress := nil;
      pr.Sender := nil;
      pr.Aborting := @ab;
      alpha := TIEMask.Create;
      TIFFReadStream(nil, ms, i32, self, pr, true, alpha, false, true, false);
    finally
      alpha.Free;
      ms.Free;
    end;
  end;

  // generics
  LoadStringFromStream(Stream, ss);
  fFileName:=WideString(ss);
  if ver < 2 then
  begin
    // in versions 0 and 1, TIOFileType was a byte
    Stream.Read(b, 1);
    fFileType := TIOFileType(b);
  end
  else
    Stream.Read(fFileType, sizeof(TIOFileType));
  Stream.Read(fBitsPerSample, sizeof(integer));
  Stream.Read(fSamplesPerPixel, sizeof(integer));
  Stream.Read(fWidth, sizeof(integer));
  Stream.Read(fHeight, sizeof(integer));
  Stream.Read(fDpiX, sizeof(integer));
  Stream.Read(fDpiY, sizeof(integer));
  FreeColorMap;
  Stream.Read(fColorMapCount, sizeof(integer));
  if fColorMapCount > 0 then
  begin
    getmem(fColorMap, fColorMapCount * sizeof(TRGB));
    Stream.Read(fColorMap^, fColorMapCount * sizeof(TRGB));
  end;
  if ver >= 25 then
  begin
    Stream.Read(fImageIndex, sizeof(integer));
    Stream.Read(fImageCount, sizeof(integer));
    Stream.Read(fGetThumbnail, sizeof(boolean));
  end;
  if ver >= 38 then
    Stream.Read(fEnableAdjustOrientation, sizeof(boolean));

  if ver >= 44 then
    Stream.Read(fIsResource, sizeof(boolean));

  // TIFF
  Stream.Read(fTIFF_Compression, sizeof(TIOTIFFCompression));
  Stream.Read(fTIFF_ImageIndex, sizeof(integer));
  Stream.Read(fTIFF_PhotometInterpret, sizeof(TIOTIFFPhotometInterpret));
  Stream.Read(fTIFF_PlanarConf, sizeof(integer));
  Stream.Read(fTIFF_XPos, sizeof(integer));
  Stream.Read(fTIFF_YPos, sizeof(integer));
  LoadStringFromStream(Stream, fTIFF_DocumentName);
  LoadStringFromStream(Stream, fTIFF_ImageDescription);
  LoadStringFromStream(Stream, fTIFF_PageName);
  Stream.Read(fTIFF_PageNumber, sizeof(integer));
  Stream.Read(fTIFF_PageCount, sizeof(integer));
  if ver >= 4 then
  begin
    Stream.Read(fTIFF_ImageCount, sizeof(integer));
    if ver >= 6 then
      Stream.Read(fTIFF_Orientation, sizeof(integer));
  end;
  if ver >= 10 then
    Stream.Read(fTIFF_JPEGQuality, sizeof(integer));
  if ver >= 16 then
    Stream.Read(fTIFF_JPEGColorSpace, sizeof(TIOJPegColorSpace));
  if ver >= 26 then
    Stream.Read(fTIFF_FillOrder, sizeof(integer));
  if ver >= 30 then
    Stream.Read(fTIFF_ZIPCompression, sizeof(integer));
  if ver >= 31 then
    Stream.Read(fTIFF_SubIndex, sizeof(integer));
  if ver >= 32 then
    Stream.Read(fTIFF_ByteOrder, sizeof(TIOByteOrder));
  if ver >= 40 then
    Stream.Read(fTIFF_GetTile, sizeof(integer));

  // GIF
  LoadStringFromStream(Stream, fGIF_Version);
  Stream.Read(fGIF_ImageIndex, sizeof(integer));
  Stream.Read(fGIF_XPos, sizeof(integer));
  Stream.Read(fGIF_YPos, sizeof(integer));
  Stream.Read(fGIF_DelayTime, sizeof(integer));
  Stream.Read(fGIF_FlagTranspColor, sizeof(boolean));
  Stream.Read(fGIF_TranspColor, sizeof(TRGB));
  Stream.Read(fGIF_Interlaced, sizeof(boolean));
  Stream.Read(fGIF_WinWidth, sizeof(integer));
  Stream.Read(fGIF_WinHeight, sizeof(integer));
  Stream.Read(fGIF_Background, sizeof(TRGB));
  Stream.Read(fGIF_Ratio, sizeof(integer));
  if ver >= 4 then
    Stream.Read(fGIF_ImageCount, sizeof(integer));
  if ver >= 9 then
    LoadStringListFromStream(Stream, fGIF_Comments);
  if ver >= 12 then
    Stream.Read(fGIF_Action, sizeof(TIEGIFAction));

  // JPEG
  Stream.Read(fJPEG_ColorSpace, sizeof(TIOJPEGColorSpace));
  Stream.Read(fJPEG_Quality, sizeof(integer));
  Stream.Read(fJPEG_DCTMethod, sizeof(TIOJPEGDCTMethod));
  Stream.Read(fJPEG_OptimalHuffman, sizeof(boolean));
  Stream.Read(fJPEG_Smooth, sizeof(integer));
  Stream.Read(fJPEG_Progressive, sizeof(boolean));
  if ver >= 1 then
    Stream.Read(fJPEG_Scale, sizeof(TIOJPEGScale));
  if ver >= 4 then
    fJPEG_MarkerList.LoadFromStream(Stream);
  if ver >= 7 then
  begin
    Stream.Read(fOriginalWidth, sizeof(integer));   // 3.0.2: common to all file formats
    Stream.Read(fOriginalHeight, sizeof(integer));  // 3.0.2: common to all file formats
  end;
  if ver >= 20 then
  begin
    Stream.Read(fJPEG_EnableAdjustOrientation, sizeof(boolean));
    Stream.Read(fJPEG_GetExifThumbnail,sizeof(boolean));
  end;
  if ver >= 39 then
    Stream.Read(fJPEG_CromaSubsampling, sizeof(TIOJPEGCromaSubsampling));

  // JPEG2000
{$IFDEF IEINCLUDEJPEG2000}
  if ver >= 8 then
  begin
    Stream.Read(fJ2000_ColorSpace, sizeof(TIOJ2000ColorSpace));
    Stream.Read(fJ2000_Rate, sizeof(double));
    Stream.Read(fJ2000_ScalableBy, sizeof(TIOJ2000ScalableBy));
  end;
{$ENDIF}

  // PCX
  Stream.Read(fPCX_Version, sizeof(integer));
  Stream.Read(fPCX_Compression, sizeof(TIOPCXCompression));

  // BMP
  Stream.Read(fBMP_Version, sizeof(TIOBMPVersion));
  Stream.Read(fBMP_Compression, sizeof(TIOBMPCompression));
  if ver>=28 then
    Stream.Read(fBMP_HandleTransparency, sizeof(boolean));

  // ICO
  if ver = 0 then
  begin
    Stream.Read(idummy, sizeof(integer));
    Stream.Read(idummy, sizeof(integer));
    fICO_ImageIndex := 0;
  end
  else
  begin
    Stream.Read(fICO_ImageIndex, sizeof(integer));
    if ver >= 3 then
      Stream.Read(fICO_Background, sizeof(TRGB));
    if ver >= 11 then
    begin
      Stream.Read(ICO_Sizes[0], sizeof(TIOICOSizes));
      Stream.Read(ICO_BitCount[0], sizeof(TIOICOBitCount));
    end;
  end;

  // CUR
  if ver = 0 then
  begin
    Stream.Read(idummy, sizeof(integer));
    Stream.Read(idummy, sizeof(integer));
    fCUR_ImageIndex := 0;
    fCUR_XHotSpot := 0;
    fCUR_YHotSpot := 0;
  end
  else
  begin
    Stream.Read(fCUR_ImageIndex, sizeof(integer));
    Stream.Read(fCUR_XHotSpot, sizeof(integer));
    Stream.Read(fCUR_YHotSpot, sizeof(integer));
    if ver >= 3 then
      Stream.Read(fCUR_Background, sizeof(TRGB));
  end;

  // PNG
  Stream.Read(fPNG_Interlaced, sizeof(boolean));
  Stream.Read(fPNG_Background, sizeof(TRGB));
  Stream.Read(fPNG_Filter, sizeof(TIOPNGFilter));
  Stream.Read(fPNG_Compression, sizeof(integer));
  if ver >= 23 then
  begin
    LoadStringListFromStream(Stream,fPNG_TextKeys);
    LoadStringListFromStream(Stream,fPNG_TextValues);
  end;

  // DICOM
  {$ifdef IEINCLUDEDICOM}
  if ver >= 37 then
    DICOM_Tags.LoadFromStream(Stream);
  {$endif}

  // PSD
  if ver >=27 then
  begin
    Stream.Read(fPSD_LoadLayers,sizeof(boolean));
    if ver>=34 then
      Stream.Read(fPSD_ReplaceLayers,sizeof(boolean));
    if ver>=36 then
      Stream.Read(fPSD_HasPremultipliedAlpha,sizeof(boolean));
  end;

  // HDP
  if ver >=41 then
  begin
    Stream.Read(fHDP_ImageQuality, sizeof(double));
    Stream.Read(fHDP_Lossless, sizeof(boolean));
  end;

  // TGA
  if ver >= 3 then
  begin
    Stream.Read(fTGA_XPos, sizeof(integer));
    Stream.Read(fTGA_YPos, sizeof(integer));
    Stream.Read(fTGA_Compressed, sizeof(boolean));
    LoadStringFromStream(Stream, fTGA_Descriptor);
    LoadStringFromStream(Stream, fTGA_Author);
    Stream.Read(fTGA_Date, sizeof(TDateTime));
    LoadStringFromStream(Stream, fTGA_ImageName);
    Stream.Read(fTGA_Background, sizeof(TRGB));
    Stream.Read(fTGA_AspectRatio, sizeof(double));
    Stream.Read(fTGA_Gamma, sizeof(double));
    Stream.Read(fTGA_GrayLevel, sizeof(boolean));
  end;

  // IPTC
  if ver >= 4 then
    fIPTC_Info.LoadFromStream(Stream);

  // PXM
  if ver >= 5 then
    LoadStringListFromStream(Stream, fPXM_Comments);

  // AVI
  if ver >= 6 then
  begin
    Stream.Read(fAVI_FrameCount, sizeof(integer));
    Stream.Read(fAVI_FrameDelayTime, sizeof(integer));
  end;

  // PS
  if ver >= 14 then
  begin
    Stream.Read(fPS_PaperWidth, sizeof(integer));
    Stream.Read(fPS_PaperHeight, sizeof(integer));
    Stream.Read(fPS_Compression, sizeof(TIOPSCompression));
    LoadStringFromStream(Stream, fPS_Title);
  end;

  // PDF
  if ver >= 14 then
  begin
    Stream.Read(fPDF_PaperWidth, sizeof(integer));
    Stream.Read(fPDF_PaperHeight, sizeof(integer));
    Stream.Read(fPDF_Compression, sizeof(TIOPDFCompression));
    if ver >= 15 then
    begin
      LoadStringFromStream(Stream, fPDF_Title);
      LoadStringFromStream(Stream, fPDF_Author);
      LoadStringFromStream(Stream, fPDF_Subject);
      LoadStringFromStream(Stream, fPDF_Keywords);
      LoadStringFromStream(Stream, fPDF_Creator);
      LoadStringFromStream(Stream, fPDF_Producer);
    end;
  end;

  // DCX
  if ver>=18 then
    Stream.Read(fDCX_ImageIndex, sizeof(integer));

  {$ifdef IEINCLUDEIMAGINGANNOT}
  // Imagning annotations
  if ver >= 13 then
    ImagingAnnot.LoadFromStream(Stream);
  {$endif}

  // ICC
  if ver >=17 then
  begin
    InputICCProfile.LoadFromStream(Stream,false);
    OutputICCProfile.LoadFromStream(Stream,false);
    if ver >=33 then
      DefaultICCProfile.LoadFromStream(Stream,false);
  end;

  // RAW
  if ver>=18 then
  begin
    {$ifdef IEINCLUDERAWFORMATS}
    Stream.Read(fRAW_HalfSize,sizeof(boolean));
    Stream.Read(fRAW_Gamma,sizeof(double));
    Stream.Read(fRAW_Bright,sizeof(double));
    Stream.Read(fRAW_RedScale,sizeof(double));
    Stream.Read(fRAW_BlueScale,sizeof(double));
    Stream.Read(fRAW_QuickInterpolate,sizeof(boolean));
    Stream.Read(fRAW_UseAutoWB,sizeof(boolean));
    Stream.Read(fRAW_UseCameraWB,sizeof(boolean));
    Stream.Read(fRAW_FourColorRGB,sizeof(boolean));
    LoadStringFromStream(Stream, fRAW_Camera);
    Stream.Read(fRAW_GetExifThumbnail,sizeof(boolean));
    if ver>=22 then
      Stream.Read(fRAW_AutoAdjustColors,sizeof(boolean));
    if ver>=35 then
      LoadStringFromStream(Stream, fRAW_ExtraParams);
    {$endif}
  end;

  // Media File
  {$ifdef IEINCLUDEDIRECTSHOW}
  if ver>=21 then
  begin
    Stream.Read(fMEDIAFILE_FrameCount,sizeof(integer));
    Stream.Read(fMEDIAFILE_FrameDelayTime,sizeof(integer));
  end;
  {$endif}

  // Real RAW
  if ver>=23 then
  begin
    Stream.Read(fBMPRAW_ChannelOrder,sizeof(TIOBMPRAWChannelOrder));
    Stream.Read(fBMPRAW_Planes,sizeof(TIOBMPRAWPlanes));
    Stream.Read(fBMPRAW_RowAlign,sizeof(integer));
    Stream.Read(fBMPRAW_HeaderSize,sizeof(integer));
    if ver>=42 then
      Stream.Read(fBMPRAW_DataFormat,sizeof(TIOBMPRAWDataFormat));
  end;

end;



{!!
<FS>TIOParamsVals.FileTypeStr

<FM>Declaration<FC>
property FileTypeStr:string;

<FM>Description<FN>
FileTypeStr returns a textual description of the file type contained in the FileType property and other file format specific properties.
For example, if <A TIOParamsVals.FileType> is ioTIFF and <A TIOParamsVals.TIFF_Compression> is ioTIFF_G4FAX, FileTypeStr returns the string: 'TIFF Bitmap (TIF)  Group 4 Fax'.

Read only

<FM>Example<FC>

if OpenImageEnDialog1.Execute then
begin
  ImageEnView1.IO.LoadFromFile(OpenImageEnDialog1.FileName);
  ShowMessage( ImageEnView1.IO.Params.FileTypeStr );
end;
!!}
// returns the type of last loaded file
function TIOParamsVals.GetFileTypeStr: string;
var
  fi: TIEFileFormatInfo;
begin
  // main
  fi := IEFileFormatGetInfo(fFileType);
  if assigned(fi) then
    with fi do
      result := FullName + ' (' + UpperCase(IEFileFormatGetExt(fFileType, 0)) + ')'
  else
    result := '';
  // sub formats
  case fFileType of
    ioTIFF:
      case TIFF_Compression of
        ioTIFF_UNCOMPRESSED:  result := result + ' Uncompressed';
        ioTIFF_CCITT1D:       result := result + ' Huffman';
        ioTIFF_G3FAX1D:       result := result + ' Group 3 Fax';
        ioTIFF_G3FAX2D:       result := result + ' Group 3 Fax 2D';
        ioTIFF_G4FAX:         result := result + ' Group 4 Fax';
        ioTIFF_LZW:           result := result + ' LZW';
        ioTIFF_OLDJPEG:       result := result + ' Jpeg v.5';
        ioTIFF_JPEG:          result := result + ' Jpeg';
        ioTIFF_PACKBITS:      result := result + ' PackBits RLE';
        ioTIFF_ZIP:           result := result + ' ZIP';
        ioTIFF_DEFLATE:       result:=result+' Deflate';
      end;
    ioJPEG:
      case JPEG_ColorSpace of
        ioJPEG_GRAYLEV: result := result + ' Gray level';
        ioJPEG_YCbCr:   result := result + ' YCbCr';
        ioJPEG_CMYK:    result := result + ' CMYK';
        ioJPEG_YCbCrK:  result := result + ' YCbCrK';
      end;
{$IFDEF IEINCLUDEJPEG2000}
    ioJP2,
      ioJ2k:
      case fJ2000_ColorSpace of
        ioJ2000_GRAYLEV:  result := result + ' Gray level';
        ioJ2000_RGB:      result := result + ' RGB';
        ioJ2000_YCbCr:    result := result + ' YCbCr';
      end;
{$ENDIF}
    ioPCX:
      if PCX_Compression = ioPCX_UNCOMPRESSED then
        result := result + ' Uncompressed';
    ioBMP:
      case BMP_Version of
        ioBMP_BM:       result := result + ' ver.1';
        ioBMP_BM3:      result := result + ' ver.3';
        ioBMP_BMOS2V1:  result := result + ' OS/2 v.1';
        ioBMP_BMOS2V2:  result := result + ' OS/2 v.2';
      end;
    ioGIF:
      if GIF_Interlaced then
        result := result + ' Interlaced';
{$IFDEF IEINCLUDEPNG}
    ioPNG:
      if PNG_Interlaced then
        result := result + ' Interlaced';
{$ENDIF}
    ioTGA:
      if TGA_Compressed then
        result := result + ' Compressed'
      else
        result := result + ' Uncompressed';
{$ifdef IEINCLUDERAWFORMATS}
    ioRAW:
      result:=result+' ('+string(RAW_Camera)+')';
{$endif}
  end;

end;

function TIOParamsVals.GetProperty(const Prop: WideString): WideString;
var
	ss:WideString;
  q:integer;
begin
	ss:=UpperCase(IERemoveCtrlCharsW(Prop));
	if ss='FILENAME' then
    result:=FileName
	else if ss='FILETYPESTR' then
   	result:=WideString(FileTypeStr)
	else if ss='FILETYPE' then
   	result:=IntToStr(FileType)
	else if ss='BITSPERSAMPLE' then
   	result:=IntToStr(BitsPerSample)
	else if ss='SAMPLESPERPIXEL' then
   	result:=IntToStr(SamplesPerPixel)
	else if ss='WIDTH' then
   	result:=IntToStr(Width)
	else if ss='HEIGHT' then
   	result:=IntToStr(Height)
	else if ss='DPIX' then
   	result:=IntToStr(DpiX)
	else if ss='DPIY' then
    result:=IntToStr(DpiY)
  else if Copy(ss,1,12)='COLORMAPITEM' then
  begin
		q:=StrToIntDef(Copy(ss,13,length(ss)),0);
    result:=IERGB2StrW(ColorMap^[q]);
  end
  else if ss='COLORMAPCOUNT' then
   	result:=IntToStr(ColorMapCount)
  else if ss='ISNATIVEPIXELFORMAT' then
    result:=IEBool2StrW(IsNativePixelFormat)
  else if ss='ENABLEADJUSTORIENTATION' then
    result:=IEBool2StrW(EnableAdjustOrientation)

  else if ss='ABORTING' then
    result := IEBool2StrW(fImageEnIO.Aborting)

	else if ss='TIFF_COMPRESSION' then
    result:=IntToStr(integer(TIFF_Compression))
  else if ss='TIFF_IMAGEINDEX' then
   	result:=IntToStr(TIFF_ImageIndex)
  else if ss='TIFF_SUBINDEX' then
    result:=IntToStr(TIFF_SubIndex)
  else if ss='TIFF_IMAGECOUNT' then
   	result:=IntToStr(TIFF_ImageCount)
  else if ss='TIFF_JPEGQUALITY' then
   	result:=IntToStr(TIFF_JpegQuality)
  else if ss='TIFF_ZIPCOMPRESSION' then
    result:=IntToStr(TIFF_ZIPCompression)
	else if ss='TIFF_PHOTOMETINTEPRET' then
    result:=IntToStr(integer(TIFF_PhotometInterpret))
	else if ss='TIFF_PLANARCONF' then
   	result:=IntToStr(TIFF_PlanarConf)
	else if ss='TIFF_XPOS' then
   	result:=IntToStr(TIFF_XPos)
	else if ss='TIFF_YPOS' then
   	result:=IntToStr(TIFF_YPos)
  else if ss='TIFF_GETTILE' then
    result:=IntToStr(TIFF_GetTile)
	else if ss='TIFF_DOCUMENTNAME' then
   	result:=WideString(TIFF_DocumentName)
  else if ss='TIFF_IMAGEDESCRIPTION' then
   	result:=WideString(TIFF_ImageDescription)
  else if ss='TIFF_PAGENAME' then
   	result:=WideString(TIFF_PageName)
  else if ss='TIFF_PAGENUMBER' then
   	result:=IntToStr(TIFF_PageNumber)
  else if ss='TIFF_PAGECOUNT' then
   	result:=IntToStr(TIFF_PageCount)
	else if ss='TIFF_JPEGCOLORSPACE' then
    result:=IntToStr(integer(TIFF_JPEGColorSpace))
  else if ss='TIFF_FILLORDER' then
    result:=IntToStr(TIFF_FillOrder)
  else if ss='TIFF_ORIENTATION' then
    result:=IntToStr(TIFF_Orientation)
  else if ss='TIFF_ENABLEADJUSTORIENTATION' then
    result:=IEBool2StrW(TIFF_EnableAdjustOrientation)
  else if ss='TIFF_BYTEORDER' then
    result:=IntToStr(integer(TIFF_ByteOrder))

  else if ss='DCX_IMAGEINDEX' then
   	result:=IntToStr(DCX_ImageIndex)

  else if ss='AVI_FRAMECOUNT' then
    result:=IntToStr(AVI_FrameCount)
  else if ss='AVI_FRAMEDELAYTIME' then
    result:=IntToStr(AVI_FrameDelayTime)

  else if ss='GIF_VERSION' then
   	result:=WideString(GIF_Version)
  else if ss='GIF_IMAGEINDEX' then
   	result:=IntToStr(GIF_ImageIndex)
  else if ss='GIF_IMAGECOUNT' then
   	result:=IntToStr(GIF_ImageCount)
  else if ss='GIF_XPOS' then
   	result:=IntToStr(GIF_XPos)
  else if ss='GIF_YPOS' then
   	result:=IntToStr(GIF_YPos)
  else if ss='GIF_DELAYTIME' then
    result:=IntToStr(GIF_DelayTime)
  else if ss='GIF_TRANSPARENT' then
   	result:=IEBool2StrW(GIF_FlagTranspColor)
  else if ss='GIF_TRANSPCOLOR' then
   	result:=IERGB2StrW(GIF_TranspColor)
  else if ss='GIF_INTERLACED' then
   	result:=IEBool2StrW(GIF_Interlaced)
  else if ss='GIF_WINWIDTH' then
		result:=IntToStr(GIF_WinWidth)
  else if ss='GIF_WINHEIGHT' then
		result:=IntToStr(GIF_WinHeight)
  else if ss='GIF_BACKGROUND' then
   	result:=IERGB2StrW(GIF_Background)
  else if ss='GIF_RATIO' then
		result:=IntToStr(GIF_Ratio)

	else if ss='JPEG_COLORSPACE' then
    result:=IntToStr(integer(JPEG_ColorSpace))
  else if ss='JPEG_QUALITY' then
		result:=IntToStr(JPEG_Quality)
	else if ss='JPEG_DCTMETHOD' then
    result:=IntToStr(integer(JPEG_DCTMethod))
  else if ss='JPEG_OPTIMALHUFFMAN' then
   	result:=IEBool2StrW(JPEG_OptimalHuffman)
  else if ss='JPEG_SMOOTH' then
		result:=IntToStr(JPEG_Smooth)
  else if ss='JPEG_PROGRESSIVE' then
   	result:=IEBool2StrW(JPEG_Progressive)
  else if ss='JPEG_SCALE_USED' then
    result:=IntToStr(JPEG_Scale_Used)
	else if ss='JPEG_SCALE' then
    result:=IntToStr(integer(JPEG_Scale))
  else if ss='JPEG_ENABLEADJUSTORIENTATION' then
    result:=IEBool2StrW(JPEG_EnableAdjustOrientation)
  else if ss='JPEG_GETEXIFTHUMBNAIL' then
    result:=IEBool2StrW(JPEG_GetExifThumbnail)
  else if ss='JPEG_WARNINGTOT' then
    result:=IntToStr(JPEG_WarningTot)
  else if ss='JPEG_WARNINGCODE' then
    result:=IntToStr(JPEG_WarningCode)
  else if ss='JPEG_ORIGINALWIDTH' then
    result:=IntToStr(OriginalWidth)
  else if ss='JPEG_ORIGINALHEIGHT' then
    result:=IntToStr(OriginalHeight)
  else if ss='ORIGINALWIDTH' then
    result:=IntToStr(OriginalWidth)
  else if ss='ORIGINALHEIGHT' then
    result:=IntToStr(OriginalHeight)
  else if ss='JPEG_CROMASUBSAMPLING' then
    result:=IntToStr(integer(JPEG_CromaSubsampling))

  else if ss='PCX_VERSION' then
		result:=IntToStr(PCX_Version)
	else if ss='PCX_COMPRESSION' then
    result:=IntToStr(integer(PCX_Compression))

	else if ss='BMP_VERSION' then
    result:=IntToStr(integer(BMP_Version))
	else if ss='BMP_COMPRESSION' then
    result:=IntToStr(integer(BMP_Compression))
  else if ss='BMP_HANDLETRANSPARENCY' then
    result:=IEBool2StrW(BMP_HandleTransparency)

  else if ss='BMPRAW_CHANNELORDER' then
    result:=IntToStr(integer(BMPRAW_ChannelOrder))
  else if ss='BMPRAW_PLANES' then
    result:=IntToStr(integer(BMPRAW_Planes))
  else if ss='BMPRAW_ROWALIGN' then
    result:=IntToStr(BMPRAW_RowAlign)
  else if ss='BMPRAW_HEADERSIZE' then
    result:=IntToStr(BMPRAW_HeaderSize)
  else if ss='BMPRAW_DATAFORMAT' then
    result:=IntToStr(integer(BMPRAW_DataFormat))

  else if ss='ICO_IMAGEINDEX' then
		result:=IntToStr(ICO_ImageIndex)
  else if ss='ICO_BACKGROUND' then
   	result:=IERGB2StrW(ICO_Background)

  else if ss='CUR_IMAGEINDEX' then
		result:=IntToStr(CUR_ImageIndex)
  else if ss='CUR_XHOTSPOT' then
		result:=IntToStr(CUR_XHotSpot)
  else if ss='CUR_YHOTSPOT' then
		result:=IntToStr(CUR_YHotSpot)
  else if ss='CUR_BACKGROUND' then
   	result:=IERGB2StrW(CUR_Background)

	else if ss='PNG_INTERLACED' then
   	result:=IEBool2StrW(PNG_Interlaced)
  else if ss='PNG_BACKGROUND' then
   	result:=IERGB2StrW(PNG_Background)
	else if ss='PNG_FILTER' then
    result:=IntToStr(integer(PNG_Filter))
  else if ss='PNG_COMPRESSION' then
		result:=IntToStr(PNG_Compression)

  else if ss='PSD_LOADLAYERS' then
    result:=IEBool2StrW(PSD_LoadLayers)
  else if ss='PSD_REPLACELAYERS' then
    result:=IEBool2StrW(PSD_ReplaceLayers)
  else if ss='PSD_HASPREMULTIPLIEDALPHA' then
    result:=IEBool2StrW(PSD_HasPremultipliedAlpha)

  else if ss='HDP_IMAGEQUALITY' then
    result:=IEFloatToStrW(HDP_ImageQuality)
  else if ss='HDP_LOSSLESS' then
    result:=IEBool2StrW(HDP_Lossless)

  else if ss='TGA_XPOS' then
		result:=IntToStr(TGA_XPos)
  else if ss='TGA_YPOS' then
		result:=IntToStr(TGA_YPos)
	else if ss='TGA_COMPRESSED' then
   	result:=IEBool2StrW(TGA_Compressed)
  else if ss='TGA_DESCRIPTOR' then
   	result:=WideString(TGA_Descriptor)
  else if ss='TGA_AUTHOR' then
   	result:=WideString(TGA_Author)
  else if ss='TGA_DATE' then
   	result:=datetostr(TGA_Date)
  else if ss='TGA_IMAGENAME' then
   	result:=WideString(TGA_ImageName)
  else if ss='TGA_BACKGROUND' then
   	result:=IERGB2StrW(TGA_Background)
  else if ss='TGA_ASPECTRATIO' then
   	result:=IEFloatToStrW(TGA_AspectRatio)
  else if ss='TGA_GAMMA' then
   	result:=IEFloatToStrW(TGA_Gamma)
	else if ss='TGA_GRAYLEVEL' then
   	result:=IEBool2StrW(TGA_GrayLevel)

  {$ifdef IEINCLUDEJPEG2000}
  else if ss='J2000_COLORSPACE' then
    result:=IntToStr(integer(J2000_ColorSpace))
  else if ss='J2000_RATE' then
   	result:=IEFloatToStrW(J2000_Rate)
  else if ss='J2000_SCALABLEBY' then
   	result:=IntToStr(integer(J2000_ScalableBy))
  {$endif}

  else if ss='PS_PAPERWIDTH' then
   	result:=IntToStr(PS_PaperWidth)
  else if ss='PS_PAPERHEIGHT' then
   	result:=IntToStr(PS_PaperHeight)
  else if ss='PS_COMPRESSION' then
   	result:=IntToStr(integer(PS_Compression))
  else if ss='PS_TITLE' then
   	result:=WideString(PS_Title)
  else if ss='PDF_PAPERWIDTH' then
   	result:=IntToStr(PDF_PaperWidth)
  else if ss='PDF_PAPERHEIGHT' then
   	result:=IntToStr(PDF_PaperHeight)
  else if ss='PDF_COMPRESSION' then
   	result:=IntToStr(integer(PDF_Compression))
  else if ss='PDF_TITLE' then
   	result:=WideString(PDF_Title)
  else if ss='PDF_AUTHOR' then
   	result:=WideString(PDF_Author)
  else if ss='PDF_SUBJECT' then
   	result:=WideString(PDF_Subject)
  else if ss='PDF_KEYWORDS' then
   	result:=WideString(PDF_Keywords)
  else if ss='PDF_CREATOR' then
   	result:=WideString(PDF_Creator)
  else if ss='PDF_PRODUCER' then
   	result:=WideString(PDF_Producer)

  else if ss='EXIF_HASEXIF' then
   	result:=IEBool2StrW(EXIF_HasEXIFData)
  else if ss='EXIF_IMAGEDESCRIPTION' then
   	result:=WideString(EXIF_ImageDescription)
  else if ss='EXIF_MAKE' then
   	result:=WideString(EXIF_Make)
  else if ss='EXIF_MODEL' then
   	result:=WideString(EXIF_Model)
  else if ss='EXIF_ORIENTATION' then
   	result:=IntToStr(EXIF_Orientation)
  else if ss='EXIF_XRESOLUTION' then
   	result:=IEFloatToStrW(EXIF_XResolution)
  else if ss='EXIF_YRESOLUTION' then
   	result:=IEFloatToStrW(EXIF_YResolution)
  else if ss='EXIF_RESOLUTIONUNIT' then
   	result:=IntToStr(EXIF_ResolutionUnit)
  else if ss='EXIF_SOFTWARE' then
   	result:=WideString(EXIF_Software)
  else if ss='EXIF_DATETIME' then
   	result:=WideString(EXIF_Datetime)
  else if ss='EXIF_COPYRIGHT' then
   	result:=WideString(EXIF_Copyright)
  else if ss='EXIF_EXPOSURETIME' then
   	result:=IEFloatToStrW(EXIF_ExposureTime)
  else if ss='EXIF_FNUMBER' then
   	result:=IEFloatToStrW(EXIF_FNumber)
  else if ss='EXIF_EXPOSUREPROGRAM' then
   	result:=IntToStr(EXIF_ExposureProgram)
  else if ss='EXIF_EXIFVERSION' then
   	result:=WideString(EXIF_EXIFVersion)
  else if ss='EXIF_DATETIMEORIGINAL' then
   	result:=WideString(EXIF_DateTimeOriginal)
  else if ss='EXIF_DATETIMEDIGITIZED' then
   	result:=WideString(EXIF_DateTimeDigitized)
  else if ss='EXIF_COMPRESSEDBITSPERPIXEL' then
   	result:=IEFloatToStrW(EXIF_CompressedBitsPerPixel)
  else if ss='EXIF_SHUTTERSPEEDVALUE' then
   	result:=IEFloatToStrW(EXIF_ShutterSpeedValue)
  else if ss='EXIF_APERTUREVALUE' then
   	result:=IEFloatToStrW(EXIF_ApertureValue)
  else if ss='EXIF_BRIGHTNESSVALUE' then
   	result:=IEFloatToStrW(EXIF_BrightNessValue)
  else if ss='EXIF_EXPOSUREBIASVALUE' then
   	result:=IEFloatToStrW(EXIF_ExposureBiasValue)
  else if ss='EXIF_MAXAPERTUREVALUE' then
   	result:=IEFloatToStrW(EXIF_MaxApertureValue)
  else if ss='EXIF_SUBJECTDISTANCE' then
   	result:=IEFloatToStrW(EXIF_SubjectDistance)
  else if ss='EXIF_METERINGMODE' then
   	result:=IntToStr(EXIF_MeteringMode)
  else if ss='EXIF_LIGHTSOURCE' then
   	result:=IntToStr(EXIF_LightSource)
  else if ss='EXIF_FLASH' then
   	result:=IntToStr(EXIF_Flash)
  else if ss='EXIF_FOCALLENGTH' then
   	result:=IEFloatToStrW(EXIF_FocalLength)
  else if ss='EXIF_SUBSECTIME' then
   	result:=WideString(EXIF_SubsecTime)
  else if ss='EXIF_SUBSECTIMEORIGINAL' then
   	result:=WideString(EXIF_SubsecTimeOriginal)
  else if ss='EXIF_SUBSECTIMEDIGITIZED' then
   	result:=WideString(EXIF_SubsecTimeDigitized)
  else if ss='EXIF_FLASHPIXVERSION' then
   	result:=WideString(EXIF_FlashPixVersion)
  else if ss='EXIF_COLORSPACE' then
   	result:=IntToStr(EXIF_ColorSpace)
  else if ss='EXIF_EXIFIMAGEWIDTH' then
   	result:=IntToStr(EXIF_EXIFImageWidth)
  else if ss='EXIF_EXIFIMAGEHEIGHT' then
   	result:=IntToStr(EXIF_EXIFImageHeight)
  else if ss='EXIF_RELATEDSOUNDFILE' then
   	result:=WideString(EXIF_RelatedSoundFile)
  else if ss='EXIF_FOCALPLANEXRESOLUTION' then
   	result:=IEFloatToStrW(EXIF_FocalPlaneXResolution)
  else if ss='EXIF_FOCALPLANEYRESOLUTION' then
   	result:=IEFloatToStrW(EXIF_FocalPlaneYResolution)
  else if ss='EXIF_FOCALPLANERESOLUTIONUNIT' then
   	result:=IntToStr(EXIF_FocalPlaneResolutionUnit)
  else if ss='EXIF_EXPOSUREINDEX' then
   	result:=IEFloatToStrW(EXIF_ExposureIndex)
  else if ss='EXIF_SENSINGMETHOD' then
   	result:=IntToStr(EXIF_SensingMethod)
  else if ss='EXIF_FILESOURCE' then
   	result:=IntToStr(EXIF_FileSource)
  else if ss='EXIF_SCENETYPE' then
   	result:=IntToStr(EXIF_SceneType)
  else if ss='EXIF_USERCOMMENT' then
   	result:=EXIF_UserComment
  else if ss='EXIF_USERCOMMENTCODE' then
   	result:=WideString(EXIF_UserCommentCode)
  else if ss='EXIF_EXPOSUREMODE' then
    result:=IntToStr(fEXIF_ExposureMode)
  else if ss='EXIF_WHITEBALANCE' then
    result:=IntToStr(fEXIF_WhiteBalance)
  else if ss='EXIF_DIGITALZOOMRATIO' then
    result:=IEFloatToStrW(fEXIF_DigitalZoomRatio)
  else if ss='EXIF_FOCALLENGTHIN35MMFILM' then
    result:=IntToStr(fEXIF_FocalLengthIn35mmFilm)
  else if ss='EXIF_SCENECAPTURETYPE' then
    result:=IntToStr(fEXIF_SceneCaptureType)
  else if ss='EXIF_GAINCONTROL' then
    result:=IntToStr(fEXIF_GainControl)
  else if ss='EXIF_CONTRAST' then
    result:=IntToStr(fEXIF_Contrast)
  else if ss='EXIF_SATURATION' then
    result:=IntToStr(fEXIF_Saturation)
  else if ss='EXIF_SHARPNESS' then
    result:=IntToStr(fEXIF_Sharpness)
  else if ss='EXIF_SUBJECTDISTANCERANGE' then
    result:=IntToStr(fEXIF_SubjectDistanceRange)
  else if ss='EXIF_IMAGEUNIQUEID' then
    result:=WideString(fEXIF_ImageUniqueID)
  else if ss='EXIF_ARTIST' then
    result:=WideString(fEXIF_Artist)
  else if ss='EXIF_ISOSPEEDRATINGS0' then
    result:=IntToStr(EXIF_ISOSpeedRatings[0])
  else if ss='EXIF_ISOSPEEDRATINGS1' then
    result:=IntToStr(EXIF_ISOSpeedRatings[1])
  else if ss='EXIF_XPRATING' then
    result:=IntToStr(fEXIF_XPRating)
  else if ss='EXIF_XPTITLE' then
    result:=fEXIF_XPTitle
  else if ss='EXIF_XPCOMMENT' then
    result:=fEXIF_XPComment
  else if ss='EXIF_XPAUTHOR' then
    result:=fEXIF_XPAuthor
  else if ss='EXIF_XPKEYWORDS' then
    result:=fEXIF_XPKeywords
  else if ss='EXIF_XPSUBJECT' then
    result:=fEXIF_XPSubject
  else if ss='EXIF_WHITEPOINT0' then
    result:=IEFloatToStrW(fEXIF_WhitePoint[0])
  else if ss='EXIF_WHITEPOINT1' then
    result:=IEFloatToStrW(fEXIF_WhitePoint[1])
  else if ss='EXIF_YCBCRCOEFFICIENTS0' then
    result:=IEFloatToStrW(fEXIF_YCbCrCoefficients[0])
  else if ss='EXIF_YCBCRCOEFFICIENTS1' then
    result:=IEFloatToStrW(fEXIF_YCbCrCoefficients[1])
  else if ss='EXIF_YCBCRCOEFFICIENTS2' then
    result:=IEFloatToStrW(fEXIF_YCbCrCoefficients[2])
  else if ss='EXIF_YCBCRPOSITIONING' then
    result:=IntToStr(EXIF_YCbCrPositioning)
  else if ss='EXIF_GPSVERSIONID' then
    result:=WideString(fEXIF_GPSVersionID)
  else if ss='EXIF_GPSLATITUDEREF' then
    result:=WideString(fEXIF_GPSLatitudeRef)
  else if ss='EXIF_GPSLATITUDEDEGREES' then
    result:=IEFloatToStrW(fEXIF_GPSLatitudeDegrees)
  else if ss='EXIF_GPSLATITUDEMINUTES' then
    result:=IEFloatToStrW(fEXIF_GPSLatitudeMinutes)
  else if ss='EXIF_GPSLATITUDESECONDS' then
    result:=IEFloatToStrW(fEXIF_GPSLatitudeSeconds)
  else if ss='EXIF_GPSLONGITUDEREF' then
    result:=WideString(fEXIF_GPSLONGITUDEREF)
  else if ss='EXIF_GPSLONGITUDEDEGREES' then
    result:=IEFloatToStrW(fEXIF_GPSLongitudeDegrees)
  else if ss='EXIF_GPSLONGITUDEMINUTES' then
    result:=IEFloatToStrW(fEXIF_GPSLongitudeMinutes)
  else if ss='EXIF_GPSLONGITUDESECONDS' then
    result:=IEFloatToStrW(fEXIF_GPSLongitudeSeconds)
  else if ss='EXIF_GPSALTITUDEREF' then
    result:=WideString(fEXIF_GPSAltitudeRef)
  else if ss='EXIF_GPSALTITUDE' then
    result:=IEFloatToStrW(fEXIF_GPSAltitude)
  else if ss='EXIF_GPSTIMESTAMPHOUR' then
    result:=IEFloatToStrW(fEXIF_GPSTimeStampHour)
  else if ss='EXIF_GPSTIMESTAMPMINUTE' then
    result:=IEFloatToStrW(fEXIF_GPSTimeStampMinute)
  else if ss='EXIF_GPSTIMESTAMPSECOND' then
    result:=IEFloatToStrW(fEXIF_GPSTimeStampSecond)
  else if ss='EXIF_GPSSATELLITES' then
    result:=WideString(fEXIF_GPSSatellites)
  else if ss='EXIF_GPSSTATUS' then
    result:=WideString(fEXIF_GPSStatus)
  else if ss='EXIF_GPSMEASUREMODE' then
    result:=WideString(fEXIF_GPSMeasureMode)
  else if ss='EXIF_GPSDOP' then
    result:=IEFloatToStrW(fEXIF_GPSDOP)
  else if ss='EXIF_GPSSPEEDREF' then
    result:=WideString(fEXIF_GPSSpeedRef)
  else if ss='EXIF_GPSSPEED' then
    result:=IEFloatToStrW(fEXIF_GPSSpeed)
  else if ss='EXIF_GPSTRACKREF' then
    result:=WideString(fEXIF_GPSTrackRef)
  else if ss='EXIF_GPSTRACK' then
    result:=IEFloatToStrW(fEXIF_GPSTrack)
  else if ss='EXIF_GPSIMGDIRECTIONREF' then
    result:=WideString(fEXIF_GPSImgDirectionRef)
  else if ss='EXIF_GPSIMGDIRECTION' then
    result:=IEFloatToStrW(fEXIF_GPSImgDirection)
  else if ss='EXIF_GPSMAPDATUM' then
    result:=WideString(fEXIF_GPSMapDatum)
  else if ss='EXIF_GPSDESTLATITUDEREF' then
    result:=WideString(fEXIF_GPSDestLatitudeRef)
  else if ss='EXIF_GPSDESTLATITUDEDEGREES' then
    result:=IEFloatToStrW(fEXIF_GPSDestLatitudeDegrees)
  else if ss='EXIF_GPSDESTLATITUDEMINUTES' then
    result:=IEFloatToStrW(fEXIF_GPSDestLatitudeMinutes)
  else if ss='EXIF_GPSDESTLATITUDESECONDS' then
    result:=IEFloatToStrW(fEXIF_GPSDestLatitudeSeconds)
  else if ss='EXIF_GPSDESTLONGITUDEREF' then
    result:=WideString(fEXIF_GPSDestLongitudeRef)
  else if ss='EXIF_GPSDESTLONGITUDEDEGREES' then
    result:=IEFloatToStrW(fEXIF_GPSDestLongitudeDegrees)
  else if ss='EXIF_GPSDESTLONGITUDEMINUTES' then
    result:=IEFloatToStrW(fEXIF_GPSDestLongitudeMinutes)
  else if ss='EXIF_GPSDESTLONGITUDESECONDS' then
    result:=IEFloatToStrW(fEXIF_GPSDestLongitudeSeconds)
  else if ss='EXIF_GPSDESTBEARINGREF' then
    result:=WideString(fEXIF_GPSDestBearingRef)
  else if ss='EXIF_GPSDESTBEARING' then
    result:=IEFloatToStrW(fEXIF_GPSDestBearing)
  else if ss='EXIF_GPSDESTDISTANCEREF' then
    result:=WideString(fEXIF_GPSDestDistanceRef)
  else if ss='EXIF_GPSDESTDISTANCE' then
    result:=IEFloatToStrW(fEXIF_GPSDestDistance)
  else if ss='EXIF_GPSDATESTAMP' then
    result:=WideString(fEXIF_GPSDateStamp)

  {$ifdef IEINCLUDERAWFORMATS}
  else if ss='RAW_HALFSIZE' then
    result:=IEBool2StrW(RAW_HalfSize)
  else if ss='RAW_GAMMA' then
    result:=IEFloatToStrW(RAW_Gamma)
  else if ss='RAW_BRIGHT' then
    result:=IEFloatToStrW(RAW_Bright)
  else if ss='RAW_REDSCALE' then
    result:=IEFloatToStrW(RAW_RedScale)
  else if ss='RAW_BLUESCALE' then
    result:=IEFloatToStrW(RAW_BlueScale)
  else if ss='RAW_QUICKINTERPOLATE' then
    result:=IEBool2StrW(RAW_QuickInterpolate)
  else if ss='RAW_USEAUTOWB' then
    result:=IEBool2StrW(RAW_UseAutoWB)
  else if ss='RAW_USECAMERAWB' then
    result:=IEBool2StrW(RAW_UseCameraWB)
  else if ss='RAW_FOURCOLORRGB' then
    result:=IEBool2StrW(RAW_FourColorRGB)
  else if ss='RAW_CAMERA' then
    result:=WideString(RAW_Camera)
  else if ss='RAW_GETEXIFTHUMBNAIL' then
    result:=IEBool2StrW(RAW_GetExifThumbnail)
  else if ss='RAW_AUTOADJUSTCOLORS' then
    result:=IEBool2StrW(RAW_AutoAdjustColors)
  else if ss='RAW_EXTRAPARAMS' then
    result:=WideString(RAW_ExtraParams)
  {$endif}

  {$IFDEF IEINCLUDEDIRECTSHOW}
  else if ss='MEDIAFILE_FRAMECOUNT' then
    result:=IntToStr(MEDIAFILE_FrameCount)
  else if ss='MEDIAFILE_FRAMEDELAYTIME' then
    result:=IntToStr(MEDIAFILE_FrameDelayTime)
  {$ENDIF}

  else if ss='IMAGEINDEX' then
    result:=IntToStr(ImageIndex)
  else if ss='IMAGECOUNT' then
    result:=IntToStr(ImageCount)
  else if ss='GETTHUMBNAIL' then
    result:=IEBool2StrW(GetThumbnail)
  else if ss='ISRESOURCE' then
    result:=IEBool2StrW(IsResource)

  else if ss='XMP_INFO' then
    result:=WideString(XMP_Info)

  else
   	result:='INVALID PROPERTY';
end;

procedure TIOParamsVals.SetProperty(Prop, Value: WideString);
var
  ss:WideString;
  q:integer;
begin
	ss:=UpperCase(IERemoveCtrlCharsW(Prop));
  Value:=IERemoveCtrlCharsW(Value);
	if ss='BITSPERSAMPLE' then
    BitsPerSample:=StrToIntDef(Value,8)
	else if ss='SAMPLESPERPIXEL' then
   	SamplesPerPixel:=StrToIntDef(Value,8)
	else if ss='WIDTH' then
   	Width:=StrToIntDef(Value,1)
	else if ss='HEIGHT' then
   	Height:=StrToIntDef(Value,1)
	else if ss='DPIX' then
   	DpiX:=StrToIntDef(Value,1)
	else if ss='DPIY' then
   	DpiY:=StrToIntDef(Value,1)
  else if Copy(ss,1,12)='COLORMAPITEM' then begin
		q:=StrToIntDef(Copy(ss,13,length(ss)),0);
		ColorMap^[q]:=IEStr2RGBW(Value);
  end
  //else if ss='COLORMAPCOUNT' then
   	// readonly
  else if ss='ISNATIVEPIXELFORMAT' then
    IsNativePixelFormat:=IEStr2BoolW(value)
  else if ss='ENABLEADJUSTORIENTATION' then
    EnableAdjustOrientation:=IEStr2BoolW(value)

  else if ss='ABORTING' then
    fImageEnIO.Aborting := IEStr2BoolW(value)

	else if ss='TIFF_COMPRESSION' then
    TIFF_Compression:=TIOTIFFCompression(StrToIntDef(Value,0))
  else if ss='TIFF_IMAGEINDEX' then
   	TIFF_ImageIndex:=StrToIntDef(value,0)
  else if ss='TIFF_SUBINDEX' then
    TIFF_SubIndex:=StrToIntDef(value,0)
  //else if ss='TIFF_IMAGECOUNT' then
   	// readonly
	else if ss='TIFF_PHOTOMETINTEPRET' then
    TIFF_PhotometInterpret:=TIOTIFFPhotometInterpret(StrToIntDef(value,0))
	else if ss='TIFF_PLANARCONF' then
   	TIFF_PlanarConf:=StrToIntDef(value,0)
	else if ss='TIFF_XPOS' then
   	TIFF_XPos:=StrToIntDef(value,0)
	else if ss='TIFF_YPOS' then
   	TIFF_YPos:=StrToIntDef(value,0)
  else if ss='TIFF_GETTILE' then
    TIFF_GetTile:=StrToIntDef(value,-1)
	else if ss='TIFF_JPEGQUALITY' then
   	TIFF_JPEGQuality:=StrToIntDef(value,0)
  else if ss='TIFF_ZIPCOMPRESSION' then
    TIFF_ZIPCompression:=StrToIntDef(value,0)
	else if ss='TIFF_DOCUMENTNAME' then
   	TIFF_DocumentName:=AnsiString(value)
  else if ss='TIFF_IMAGEDESCRIPTION' then
   	TIFF_ImageDescription:=AnsiString(value)
  else if ss='TIFF_PAGENAME' then
   	TIFF_PageName:=AnsiString(value)
  else if ss='TIFF_PAGENUMBER' then
   	TIFF_PageNumber:=StrToIntDef(value,0)
  else if ss='TIFF_PAGECOUNT' then
   	TIFF_PageCount:=StrToIntDef(value,0)
	else if ss='TIFF_JPEGCOLORSPACE' then
    TIFF_JPEGColorSpace:=TIOJPEGColorSpace(StrToIntDef(value,0))
  else if ss='TIFF_FILLORDER' then
    TIFF_FillOrder:=StrToIntDef(value,1)
  else if ss='TIFF_ORIENTATION' then
    TIFF_Orientation:=StrToIntDef(value,1)
  else if ss='TIFF_ENABLEADJUSTORIENTATION' then
    TIFF_EnableAdjustOrientation:=IEStr2BoolW(value)
  else if ss='TIFF_BYTEORDER' then
    TIFF_ByteOrder:=TIOByteOrder(StrToIntDef(value,1))

  else if ss='DCX_IMAGEINDEX' then
   	DCX_ImageIndex:=StrToIntDef(value,0)

  else if ss='AVI_FRAMECOUNT' then
    AVI_FrameCount:=StrToIntDef(value,0)
  else if ss='AVI_FRAMEDELAYTIME' then
    AVI_FrameDelayTime:=StrToIntDef(value,0)

  else if ss='GIF_VERSION' then
   	GIF_Version:=AnsiString(value)
  else if ss='GIF_IMAGEINDEX' then
   	GIF_ImageIndex:=StrToIntDef(value,0)
  //else if ss='GIF_IMAGECOUNT' then
   	// read-only
  else if ss='GIF_XPOS' then
   	GIF_XPos:=StrToIntDef(value,0)
  else if ss='GIF_YPOS' then
   	GIF_YPos:=StrToIntDef(value,0)
  else if ss='GIF_DELAYTIME' then
     	GIF_DelayTime:=StrToIntDef(value,0)
	else if ss='GIF_TRANSPARENT' then
      GIF_FlagTranspColor:=IEStr2BoolW(value)
  else if ss='GIF_TRANSPCOLOR' then
	   GIF_TranspColor:=IEStr2RGBW(value)
  else if ss='GIF_INTERLACED' then
    GIF_Interlaced:=IEStr2BoolW(value)
  else if ss='GIF_WINWIDTH' then
		GIF_WinWidth:=StrToIntDef(value,0)
  else if ss='GIF_WINHEIGHT' then
		GIF_WinHeight:=StrToIntDef(value,0)
  else if ss='GIF_BACKGROUND' then
   	GIF_Background:=IEStr2RGBW(value)
  else if ss='GIF_RATIO' then
		GIF_Ratio:=StrToIntDef(value,0)

	else if ss='JPEG_COLORSPACE' then
    JPEG_ColorSpace:=TIOJPEGColorSpace(StrToIntDef(value,0))
  else if ss='JPEG_QUALITY' then
		JPEG_Quality:=StrToIntDef(value,0)
	else if ss='JPEG_DCTMETHOD' then
    JPEG_DCTMethod:=TIOJPEGDCTMethod(StrToIntDef(value,0))
  else if ss='JPEG_OPTIMALHUFFMAN' then
    JPEG_OptimalHuffman:=IEStr2BoolW(value)
  else if ss='JPEG_SMOOTH' then
		JPEG_Smooth:=StrToIntDef(value,0)
  else if ss='JPEG_PROGRESSIVE' then
    JPEG_Progressive:=IEStr2BoolW(value)
  else if ss='JPEG_SCALE_USED' then
    JPEG_Scale_Used:=StrToIntDef(value,0)
	else if ss='JPEG_SCALE' then
    JPEG_Scale:=TIOJPEGScale(StrToIntDef(value,0))
  else if ss='JPEG_ENABLEADJUSTORIENTATION' then
    JPEG_EnableAdjustOrientation:=IEStr2BoolW(value)
  else if ss='JPEG_GETEXIFTHUMBNAIL' then
    JPEG_GetExifThumbnail:=IEStr2BoolW(value)
  else if ss='JPEG_WARNINGTOT' then
    JPEG_WarningTot:=StrToIntDef(value,0)
  else if ss='JPEG_WARNINGCODE' then
    JPEG_WarningCode:=StrToIntDef(value,0)
  else if ss='JPEG_ORIGINALWIDTH' then
    OriginalWidth:=StrToIntDef(value,0)
  else if ss='JPEG_ORIGINALHEIGHT' then
    OriginalHeight:=StrToIntDef(value,0)
  else if ss='ORIGINALWIDTH' then
    OriginalWidth:=StrToIntDef(value,0)
  else if ss='ORIGINALHEIGHT' then
    OriginalHeight:=StrToIntDef(value,0)
  else if ss='JPEG_CROMASUBSAMPLING' then
    JPEG_CromaSubsampling:=TIOJPEGCROMASUBSAMPLING(StrToIntDef(value,1))

  else if ss='PCX_VERSION' then
		PCX_Version:=StrToIntDef(value,0)
	else if ss='PCX_COMPRESSION' then
    PCX_Compression:=TIOPCXCompression(StrToIntDef(value,0))

	else if ss='BMP_VERSION' then
    BMP_Version:=TIOBMPVersion(StrToIntDef(value,0))
	else if ss='BMP_COMPRESSION' then
    BMP_Compression:=TIOBMPCompression(StrToIntDef(value,0))
  else if ss='BMP_HANDLETRANSPARENCY' then
    BMP_HandleTransparency:=IEStr2BoolW(value)

  else if ss='BMPRAW_CHANNELORDER' then
    BMPRAW_ChannelOrder:=TIOBMPRAWChannelOrder(StrToIntDef(value,0))
  else if ss='BMPRAW_PLANES' then
    BMPRAW_Planes:=TIOBMPRAWPlanes(StrToIntDef(value,0))
  else if ss='BMPRAW_ROWALIGN' then
    BMPRAW_RowAlign:=StrToIntDef(value,8)
  else if ss='BMPRAW_HEADERSIZE' then
    BMPRAW_HeaderSize:=StrToIntDef(value,0)
  else if ss='BMPRAW_DATAFORMAT' then
    BMPRAW_DataFormat:=TIOBMPRAWDataFormat(StrToIntDef(value,0))

  else if ss='ICO_IMAGEINDEX' then
		ICO_ImageIndex:=StrToIntDef(value,0)
  else if ss='ICO_BACKGROUND' then
   	ICO_Background:=IEStr2RGBW(value)

  else if ss='CUR_IMAGEINDEX' then
		CUR_ImageIndex:=StrToIntDef(value,0)
  else if ss='CUR_XHOTSPOT' then
		CUR_XHotSpot:=StrToIntDef(value,0)
  else if ss='CUR_YHOTSPOT' then
		CUR_YHotSpot:=StrToIntDef(value,0)
  else if ss='CUR_BACKGROUND' then
   	CUR_Background:=IEStr2RGBW(value)

	else if ss='PNG_INTERLACED' then
    PNG_Interlaced:=IEStr2BoolW(value)
  else if ss='PNG_BACKGROUND' then
   	PNG_Background:=IEStr2RGBW(value)
	else if ss='PNG_FILTER' then
    PNG_Filter:=TIOPNGFilter(StrToIntDef(value,0))
  else if ss='PNG_COMPRESSION' then
		PNG_Compression:=StrToIntDef(value,1)

  else if ss='PSD_LOADLAYERS' then
    PSD_LoadLayers:=IEStr2BoolW(value)
  else if ss='PSD_REPLACELAYERS' then
    PSD_ReplaceLayers:=IEStr2BoolW(value)
  //else if ss='PSD_HASPREMULTIPLIEDALPHA' then
    // readonly, PSD_HasPremultipliedAlpha:=IEStr2BoolW(value)

  else if ss='HDP_IMAGEQUALITY' then
    HDP_ImageQuality:=IEStrToFloatDefW(value, 0.9)
  else if ss='HDP_LOSSLESS' then
    HDP_Lossless:=IEStr2BoolW(value)

  else if ss='TGA_XPOS' then
		TGA_XPos:=StrToIntDef(value,0)
  else if ss='TGA_YPOS' then
		TGA_YPos:=StrToIntDef(value,0)
	else if ss='TGA_COMPRESSED' then
    TGA_Compressed:=IEStr2BoolW(value)
  else if ss='TGA_DESCRIPTOR' then
   	TGA_Descriptor:=AnsiString(value)
  else if ss='TGA_AUTHOR' then
   	TGA_Author:=AnsiString(value)
  else if ss='TGA_DATE' then begin
   	try
   	TGA_Date:=strtodate(value)
    except
    end;
  end else if ss='TGA_IMAGENAME' then
   	TGA_ImageName:=AnsiString(value)
  else if ss='TGA_BACKGROUND' then
   	TGA_Background:=IEStr2RGBW(value)
  else if ss='TGA_ASPECTRATIO' then begin
   	try
   	TGA_AspectRatio:=IEStrToFloatDefW(value,0)
    except
    end;
  end else if ss='TGA_GAMMA' then begin
   	try
   	TGA_Gamma:=IEStrToFloatDefW(value,0)
    except
    end;
	end else if ss='TGA_GRAYLEVEL' then
    TGA_GrayLevel:=IEStr2BoolW(value)

    {$ifdef IEINCLUDEJPEG2000}
  else if ss='J2000_COLORSPACE' then
   	J2000_ColorSpace:=TIOJ2000ColorSpace(StrToIntDef(value,0))
  else if ss='J2000_RATE' then begin
   	try
   	J2000_Rate:=IEStrToFloatDefW(value,0)
    except
    end;
  end else if ss='J2000_SCALABLEBY' then
   	J2000_ScalableBy:=TIOJ2000ScalableBy(StrToIntDef(value,0))
    {$endif}

  else if ss='PS_PAPERWIDTH' then
   	PS_PaperWidth:=StrToIntDef(value,595)
  else if ss='PS_PAPERHEIGHT' then
   	PS_PaperHeight:=StrToIntDef(value,842)
  else if ss='PS_COMPRESSION' then
   	PS_Compression:=TIOPSCompression(StrToIntDef(value,0))
  else if ss='PS_TITLE' then
   	PS_Title:=AnsiString(value)
  else if ss='PDF_PAPERWIDTH' then
   	PDF_PaperWidth:=StrToIntDef(value,595)
  else if ss='PDF_PAPERHEIGHT' then
   	PDF_PaperHeight:=StrToIntDef(value,842)
  else if ss='PDF_COMPRESSION' then
   	PDF_Compression:=TIOPDFCompression(StrToIntDef(value,0))
  else if ss='PDF_TITLE' then
   	PDF_Title:=AnsiString(value)
  else if ss='PDF_AUTHOR' then
   	PDF_Author:=AnsiString(value)
  else if ss='PDF_SUBJECT' then
   	PDF_Subject:=AnsiString(value)
  else if ss='PDF_KEYWORDS' then
   	PDF_Keywords:=AnsiString(value)
  else if ss='PDF_CREATOR' then
   	PDF_Creator:=AnsiString(value)
  else if ss='PDF_PRODUCER' then
   	PDF_Producer:=AnsiString(value)

  else if ss='EXIF_HASEXIF' then
   	EXIF_HasEXIFData:=IEStr2BoolW(value)
  else if ss='EXIF_IMAGEDESCRIPTION' then
   	EXIF_ImageDescription:=AnsiString(value)
  else if ss='EXIF_MAKE' then
   	EXIF_Make:=AnsiString(value)
  else if ss='EXIF_MODEL' then
   	EXIF_Model:=AnsiString(value)
  else if ss='EXIF_ORIENTATION' then
   	EXIF_Orientation:=StrToIntDef(value,0)
  else if ss='EXIF_XRESOLUTION' then
   	try
   	EXIF_XResolution:=IEStrToFloatDefW(value,0);
    except
    end
  else if ss='EXIF_YRESOLUTION' then
   	try
   	EXIF_YResolution:=IEStrToFloatDefW(value,0);
    except
    end
  else if ss='EXIF_RESOLUTIONUNIT' then
   	EXIF_ResolutionUnit:=StrToIntDef(value,0)
  else if ss='EXIF_SOFTWARE' then
   	EXIF_Software:=AnsiString(value)
  else if ss='EXIF_DATETIME' then
   	EXIF_Datetime:=AnsiString(value)
  else if ss='EXIF_COPYRIGHT' then
   	EXIF_Copyright:=AnsiString(value)
  else if ss='EXIF_EXPOSURETIME' then
   	try
   	EXIF_ExposureTime:=IEStrToFloatDefW(value,0)
    except
    end
  else if ss='EXIF_FNUMBER' then
   	try
   	EXIF_FNumber:=IEStrToFloatDefW(value,-1)
    except
    end
  else if ss='EXIF_EXPOSUREPROGRAM' then
   	EXIF_ExposureProgram:=StrToIntDef(value,-1)
  else if ss='EXIF_EXIFVERSION' then
   	EXIF_EXIFVersion:=AnsiString(value)
  else if ss='EXIF_DATETIMEORIGINAL' then
   	EXIF_DateTimeOriginal:=AnsiString(value)
  else if ss='EXIF_DATETIMEDIGITIZED' then
   	EXIF_DateTimeDigitized:=AnsiString(value)
  else if ss='EXIF_COMPRESSEDBITSPERPIXEL' then
   	try
   	EXIF_CompressedBitsPerPixel:=IEStrToFloatDefW(value,0)
    except
    end
  else if ss='EXIF_SHUTTERSPEEDVALUE' then
   	try
   	EXIF_ShutterSpeedValue:=IEStrToFloatDefW(value,-1);
    except
    end
  else if ss='EXIF_APERTUREVALUE' then
   	try
   	EXIF_ApertureValue:=IEStrToFloatDefW(value,-1);
    except
    end
  else if ss='EXIF_BRIGHTNESSVALUE' then
   	try
   	EXIF_BrightNessValue:=IEStrToFloatDefW(value,-1000);
    except
    end
  else if ss='EXIF_EXPOSUREBIASVALUE' then
   	try
   	EXIF_ExposureBiasValue:=IEStrToFloatDefW(value,-1000);
    except
    end
  else if ss='EXIF_MAXAPERTUREVALUE' then
   	try
   	EXIF_MaxApertureValue:=IEStrToFloatDefW(value,-1000);
    except
    end
  else if ss='EXIF_SUBJECTDISTANCE' then
   	try
   	EXIF_SubjectDistance:=IEStrToFloatDefW(value,-1);
    except
    end
  else if ss='EXIF_METERINGMODE' then
   	EXIF_MeteringMode:=StrToIntDef(value,-1)
  else if ss='EXIF_LIGHTSOURCE' then
   	EXIF_LightSource:=StrToIntDef(value,-1)
  else if ss='EXIF_FLASH' then
   	EXIF_Flash:=StrToIntDef(value,-1)
  else if ss='EXIF_FOCALLENGTH' then
   	try
   	EXIF_FocalLength:=IEStrToFloatDefW(value,-1)
    except
    end
  else if ss='EXIF_SUBSECTIME' then
   	EXIF_SubsecTime:=AnsiString(value)
  else if ss='EXIF_SUBSECTIMEORIGINAL' then
   	EXIF_SubsecTimeOriginal:=AnsiString(value)
  else if ss='EXIF_SUBSECTIMEDIGITIZED' then
   	EXIF_SubsecTimeDigitized:=AnsiString(value)
  else if ss='EXIF_FLASHPIXVERSION' then
   	EXIF_FlashPixVersion:=AnsiString(value)
  else if ss='EXIF_COLORSPACE' then
   	EXIF_ColorSpace:=StrToIntDef(value,-1)
  else if ss='EXIF_EXIFIMAGEWIDTH' then
   	EXIF_EXIFImageWidth:=StrToIntDef(value,0)
  else if ss='EXIF_EXIFIMAGEHEIGHT' then
   	EXIF_EXIFImageHeight:=StrToIntDef(value,0)
  else if ss='EXIF_RELATEDSOUNDFILE' then
   	EXIF_RelatedSoundFile:=AnsiString(value)
  else if ss='EXIF_FOCALPLANEXRESOLUTION' then
   	try
   	EXIF_FocalPlaneXResolution:=IEStrToFloatDefW(value,-1)
    except
    end
  else if ss='EXIF_FOCALPLANEYRESOLUTION' then
   	try
   	EXIF_FocalPlaneYResolution:=IEStrToFloatDefW(value,-1)
    except
    end
  else if ss='EXIF_FOCALPLANERESOLUTIONUNIT' then
   	EXIF_FocalPlaneResolutionUnit:=StrToIntDef(value,-1)
  else if ss='EXIF_EXPOSUREINDEX' then
   	try
   	EXIF_ExposureIndex:=IEStrToFloatDefW(value,-1)
    except
    end
  else if ss='EXIF_SENSINGMETHOD' then
   	EXIF_SensingMethod:=StrToIntDef(value,-1)
  else if ss='EXIF_FILESOURCE' then
   	EXIF_FileSource:=StrToIntDef(value,-1)
  else if ss='EXIF_SCENETYPE' then
   	EXIF_SceneType:=StrToIntDef(value,-1)
  else if ss='EXIF_USERCOMMENT' then
   	EXIF_UserComment:=value
  else if ss='EXIF_USERCOMMENTCODE' then
   	EXIF_UserCommentCode:=AnsiString(value)

  else if ss='EXIF_EXPOSUREMODE' then
    fEXIF_ExposureMode:=StrToIntDef(value,-1)
  else if ss='EXIF_WHITEBALANCE' then
    fEXIF_WhiteBalance:=StrToIntDef(value,-1)
  else if ss='EXIF_DIGITALZOOMRATIO' then
    fEXIF_DigitalZoomRatio:=IEStrToFloatDefW(value,-1)
  else if ss='EXIF_FOCALLENGTHIN35MMFILM' then
    fEXIF_FocalLengthIn35mmFilm:=StrToIntDef(value,-1)
  else if ss='EXIF_SCENECAPTURETYPE' then
    fEXIF_SceneCaptureType:=StrToIntDef(value,-1)
  else if ss='EXIF_GAINCONTROL' then
    fEXIF_GainControl:=StrToIntDef(value,-1)
  else if ss='EXIF_CONTRAST' then
    fEXIF_Contrast:=StrToIntDef(value,-1)
  else if ss='EXIF_SATURATION' then
    fEXIF_Saturation:=StrToIntDef(value,-1)
  else if ss='EXIF_SHARPNESS' then
    fEXIF_Sharpness:=StrToIntDef(value,-1)
  else if ss='EXIF_SUBJECTDISTANCERANGE' then
    fEXIF_SubjectDistanceRange:=StrToIntDef(value,-1)
  else if ss='EXIF_IMAGEUNIQUEID' then
    fEXIF_ImageUniqueID:=AnsiString(value)

  else if ss='EXIF_GPSVERSIONID' then
    fEXIF_GPSVersionID:=AnsiString(value)
  else if ss='EXIF_GPSLATITUDEREF' then
    fEXIF_GPSLatitudeRef:=AnsiString(value)
  else if ss='EXIF_GPSLATITUDEDEGREES' then
    fEXIF_GPSLatitudeDegrees:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSLATITUDEMINUTES' then
    fEXIF_GPSLatitudeMinutes:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSLATITUDESECONDS' then
    fEXIF_GPSLatitudeSeconds:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSLONGITUDEREF' then
    fEXIF_GPSLONGITUDEREF:=AnsiString(value)
  else if ss='EXIF_GPSLONGITUDEDEGREES' then
    fEXIF_GPSLongitudeDegrees:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSLONGITUDEMINUTES' then
    fEXIF_GPSLongitudeMinutes:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSLONGITUDESECONDS' then
    fEXIF_GPSLongitudeSeconds:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSALTITUDEREF' then
    fEXIF_GPSAltitudeRef:=AnsiString(value)
  else if ss='EXIF_GPSALTITUDE' then
    fEXIF_GPSAltitude:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSTIMESTAMPHOUR' then
    fEXIF_GPSTimeStampHour:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSTIMESTAMPMINUTE' then
    fEXIF_GPSTimeStampMinute:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSTIMESTAMPSECOND' then
    fEXIF_GPSTimeStampSecond:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSSATELLITES' then
    fEXIF_GPSSatellites:=AnsiString(value)
  else if ss='EXIF_GPSSTATUS' then
    fEXIF_GPSStatus:=AnsiString(value)
  else if ss='EXIF_GPSMEASUREMODE' then
    fEXIF_GPSMeasureMode:=AnsiString(value)
  else if ss='EXIF_GPSDOP' then
    fEXIF_GPSDOP:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSSPEEDREF' then
    fEXIF_GPSSpeedRef:=AnsiString(value)
  else if ss='EXIF_GPSSPEED' then
    fEXIF_GPSSpeed:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSTRACKREF' then
    fEXIF_GPSTrackRef:=AnsiString(value)
  else if ss='EXIF_GPSTRACK' then
    fEXIF_GPSTrack:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSIMGDIRECTIONREF' then
    fEXIF_GPSImgDirectionRef:=AnsiString(value)
  else if ss='EXIF_GPSIMGDIRECTION' then
    fEXIF_GPSImgDirection:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSMAPDATUM' then
    fEXIF_GPSMapDatum:=AnsiString(value)
  else if ss='EXIF_GPSDESTLATITUDEREF' then
    fEXIF_GPSDestLatitudeRef:=AnsiString(value)
  else if ss='EXIF_GPSDESTLATITUDEDEGREES' then
    fEXIF_GPSDestLatitudeDegrees:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDESTLATITUDEMINUTES' then
    fEXIF_GPSDestLatitudeMinutes:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDESTLATITUDESECONDS' then
    fEXIF_GPSDestLatitudeSeconds:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDESTLONGITUDEREF' then
    fEXIF_GPSDestLongitudeRef:=AnsiString(value)
  else if ss='EXIF_GPSDESTLONGITUDEDEGREES' then
    fEXIF_GPSDestLongitudeDegrees:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDESTLONGITUDEMINUTES' then
    fEXIF_GPSDestLongitudeMinutes:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDESTLONGITUDESECONDS' then
    fEXIF_GPSDestLongitudeSeconds:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDESTBEARINGREF' then
    fEXIF_GPSDestBearingRef:=AnsiString(value)
  else if ss='EXIF_GPSDESTBEARING' then
    fEXIF_GPSDestBearing:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDESTDISTANCEREF' then
    fEXIF_GPSDestDistanceRef:=AnsiString(value)
  else if ss='EXIF_GPSDESTDISTANCE' then
    fEXIF_GPSDestDistance:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_GPSDATESTAMP' then
    fEXIF_GPSDateStamp:=AnsiString(value)
  else if ss='EXIF_ISOSPEEDRATINGS0' then
    fEXIF_ISOSpeedRatings[0]:=StrToIntDef(value,0)
  else if ss='EXIF_ISOSPEEDRATINGS1' then
    fEXIF_ISOSpeedRatings[1]:=StrToIntDef(value,0)
  else if ss='EXIF_ARTIST' then
    fEXIF_Artist:=AnsiString(value)
  else if ss='EXIF_XPRATING' then
    fEXIF_XPRating:=StrToIntDef(value,-1)
  else if ss='EXIF_XPTITLE' then
    fEXIF_XPTitle:=value
  else if ss='EXIF_XPCOMMENT' then
    fEXIF_XPComment:=value
  else if ss='EXIF_XPAUTHOR' then
    fEXIF_XPAuthor:=value
  else if ss='EXIF_XPKEYWORDS' then
    fEXIF_XPKeywords:=value
  else if ss='EXIF_XPSUBJECT' then
    fEXIF_XPSubject:=value
  else if ss='EXIF_WHITEPOINT0' then
    fEXIF_WhitePoint[0]:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_WHITEPOINT1' then
    fEXIF_WhitePoint[1]:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_YCBCRCOEFFICIENTS0' then
    fEXIF_YCbCrCoefficients[0]:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_YCBCRCOEFFICIENTS1' then
    fEXIF_YCbCrCoefficients[1]:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_YCBCRCOEFFICIENTS2' then
    fEXIF_YCbCrCoefficients[2]:=IEStrToFloatDefW(value,0)
  else if ss='EXIF_YCBCRPOSITIONING' then
    EXIF_YCbCrPositioning:=StrToIntDef(value,0)


   {$ifdef IEINCLUDERAWFORMATS}
  else if ss='RAW_HALFSIZE' then
    RAW_HalfSize:=IEStr2BoolW(value)
  else if ss='RAW_GAMMA' then
    RAW_Gamma:=IEStrToFloatDefW(value,0)
  else if ss='RAW_BRIGHT' then
    RAW_Bright:=IEStrToFloatDefW(value,0)
  else if ss='RAW_REDSCALE' then
    RAW_RedScale:=IEStrToFloatDefW(value,0)
  else if ss='RAW_BLUESCALE' then
    RAW_BlueScale:=IEStrToFloatDefW(value,0)
  else if ss='RAW_QUICKINTERPOLATE' then
    RAW_QuickInterpolate:=IEStr2BoolW(value)
  else if ss='RAW_USEAUTOWB' then
    RAW_UseAutoWB:=IEStr2BoolW(value)
  else if ss='RAW_USECAMERAWB' then
    RAW_UseCameraWB:=IEStr2BoolW(value)
  else if ss='RAW_FOURCOLORRGB' then
    RAW_FourColorRGB:=IEStr2BoolW(value)
  else if ss='RAW_CAMERA' then
    RAW_Camera:=AnsiString(value)
  else if ss='RAW_GETEXIFTHUMBNAIL' then
    RAW_GetExifThumbnail:=IEStr2BoolW(value)
  else if ss='RAW_AUTOADJUSTCOLORS' then
    RAW_AutoAdjustColors:=IEStr2BoolW(value)
  else if ss='RAW_EXTRAPARAMS' then
    RAW_ExtraParams:=AnsiString(value)
   {$endif}

  {$IFDEF IEINCLUDEDIRECTSHOW}
  else if ss='MEDIAFILE_FRAMECOUNT' then
    MEDIAFILE_FrameCount:=StrToIntDef(value,0)
  else if ss='MEDIAFILE_FRAMEDELAYTIME' then
    MEDIAFILE_FrameDelayTime:=StrToIntDef(value,0)
  {$ENDIF}

  else if ss='IMAGEINDEX' then
    ImageIndex:=StrToIntDef(value,0)
  else if ss='IMAGECOUNT' then
    ImageCount:=StrToIntDef(value,0)
  else if ss='GETTHUMBNAIL' then
    GetThumbnail:=IEStr2BoolW(value)
  else if ss='ISRESOURCE' then
    IsResource:=IEStr2BoolW(value)

  else if ss='XMP_INFO' then
    XMP_Info:=AnsiString(value);

end;

{!!
<FS>TIOParamsVals.UpdateEXIFThumbnail

<FM>Declaration<FC>
procedure UpdateEXIFThumbnail;

<FM>Description<FN>
Updates EXIF_Bitmap property with the content of current image.
You should call this method just before save a jpeg to make thumbnail consistent with saved image.

<FM>Example<FC>

ImageEnView1.IO.LoadFromFile('input.jpg');
ImageEnView1.Proc.Negative;
ImageEnView1.IO.Params.UpdateEXIFThumbnail;
ImageEnView1.IO.SaveToFile('output.jpg');
!!}
procedure TIOParamsVals.UpdateEXIFThumbnail;
var
  proc:TImageEnProc;
begin
  if fEXIF_Bitmap=nil then
    fEXIF_Bitmap := TIEBitmap.Create;
  proc := TImageEnProc.CreateFromBitmap(fImageEnIO.IEBitmap);
  proc.AutoUndo := false;
  try
    proc.ResampleTo(fEXIF_Bitmap, 160, -1, rfTriangle);
  finally
    proc.free;
  end;
end;

procedure TIOParamsVals.EXIFTagsAdd(tag:integer);
begin
  if fEXIF_Tags.IndexOf(pointer(tag))<0 then
    fEXIF_Tags.Add(pointer(tag));
end;

procedure TIOParamsVals.EXIFTagsDel(tag:integer);
var
  p:integer;
begin
  p := fEXIF_Tags.IndexOf(pointer(tag));
  if p>-1 then
    fEXIF_Tags.Delete(p);
end;

procedure TIOParamsVals.SetEXIF_ExposureTime(value:double);
begin
  fEXIF_ExposureTime := value;
  if value<>-1 then
    EXIFTagsAdd($829A)
  else
    EXIFTagsDel($829A);
end;

procedure TIOParamsVals.SetEXIF_FNumber(value:double);
begin
  fEXIF_FNumber := value;
  if value<>-1 then
    EXIFTagsAdd($829D)
  else
    EXIFTagsDel($829D);
end;

procedure TIOParamsVals.SetEXIF_ExposureProgram(value:integer);
begin
  fEXIF_ExposureProgram := value;
  if value<>-1 then
    EXIFTagsAdd($8822)
  else
    EXIFTagsDel($8822);
end;

procedure TIOParamsVals.SetEXIF_CompressedBitsPerPixel(value:double);
begin
  fEXIF_CompressedBitsPerPixel := value;
  if value<>0 then
    EXIFTagsAdd($9102)
  else
    EXIFTagsDel($9102);
end;

procedure TIOParamsVals.SetEXIF_ShutterSpeedValue(value:double);
begin
  fEXIF_ShutterSpeedValue := value;
  if value<>-1 then
    EXIFTagsAdd($9201)
  else
    EXIFTagsDel($9201);
end;

procedure TIOParamsVals.SetEXIF_ApertureValue(value:double);
begin
  fEXIF_ApertureValue := value;
  if value<>-1 then
    EXIFTagsAdd($9202)
  else
    EXIFTagsDel($9202);
end;

procedure TIOParamsVals.SetEXIF_BrightnessValue(value:double);
begin
  fEXIF_BrightnessValue := value;
  if value<>-1000 then
    EXIFTagsAdd($9203)
  else
    EXIFTagsDel($9203);
end;

procedure TIOParamsVals.SetEXIF_ExposureBiasValue(value:double);
begin
  fEXIF_ExposureBiasValue := value;
  if value<>-1000 then
    EXIFTagsAdd($9204)
  else
    EXIFTagsDel($9204);
end;

procedure TIOParamsVals.SetEXIF_MaxApertureValue(value:double);
begin
  fEXIF_MaxApertureValue := value;
  if value<>-1000 then
    EXIFTagsAdd($9205)
  else
    EXIFTagsDel($9205);
end;

procedure TIOParamsVals.SetEXIF_SubjectDistance(value:double);
begin
  fEXIF_SubjectDistance := value;
  if value<>-1 then
    EXIFTagsAdd($9206)
  else
    EXIFTagsDel($9206);
end;

procedure TIOParamsVals.SetEXIF_MeteringMode(value:integer);
begin
  fEXIF_MeteringMode := value;
  if value<>-1 then
    EXIFTagsAdd($9207)
  else
    EXIFTagsDel($9207);
end;

procedure TIOParamsVals.SetEXIF_LightSource(value:integer);
begin
  fEXIF_LightSource := value;
  if value<>-1 then
    EXIFTagsAdd($9208)
  else
    EXIFTagsDel($9208);
end;

procedure TIOParamsVals.SetEXIF_Flash(value:integer);
begin
  fEXIF_Flash := value;
  if value<>-1 then
    EXIFTagsAdd($9209)
  else
    EXIFTagsDel($9209);
end;

procedure TIOParamsVals.SetEXIF_FocalLength(value:double);
begin
  fEXIF_FocalLength := value;
  if value<>-1 then
    EXIFTagsAdd($920A)
  else
    EXIFTagsDel($920A);
end;

procedure TIOParamsVals.SetEXIF_ColorSpace(value:integer);
begin
  fEXIF_ColorSpace := value;
  if value<>-1 then
    EXIFTagsAdd($A001)
  else
    EXIFTagsDel($A001);
end;

procedure TIOParamsVals.SetEXIF_ExifImageWidth(value:integer);
begin
  fEXIF_ExifImageWidth := value;
  if value<>0 then
    EXIFTagsAdd($A002)
  else
    EXIFTagsDel($A002);
end;

procedure TIOParamsVals.SetEXIF_ExifImageHeight(value:integer);
begin
  fEXIF_ExifImageHeight := value;
  if value<>0 then
    EXIFTagsAdd($A003)
  else
    EXIFTagsDel($A003);
end;

procedure TIOParamsVals.SetEXIF_FocalPlaneXResolution(value:double);
begin
  fEXIF_FocalPlaneXResolution := value;
  if value<>-1 then
    EXIFTagsAdd($A20E)
  else
    EXIFTagsDel($A20E);
end;

procedure TIOParamsVals.SetEXIF_FocalPlaneYResolution(value:double);
begin
  fEXIF_FocalPlaneYResolution := value;
  if value<>-1 then
    EXIFTagsAdd($A20F)
  else
    EXIFTagsDel($A20F);
end;

procedure TIOParamsVals.SetEXIF_FocalPlaneResolutionUnit(value:integer);
begin
  fEXIF_FocalPlaneResolutionUnit := value;
  if value<>-1 then
    EXIFTagsAdd($A210)
  else
    EXIFTagsDel($A210);
end;

procedure TIOParamsVals.SetEXIF_ExposureIndex(value:double);
begin
  fEXIF_ExposureIndex := value;
  if value<>-1 then
    EXIFTagsAdd($A215)
  else
    EXIFTagsDel($A215);
end;

procedure TIOParamsVals.SetEXIF_SensingMethod(value:integer);
begin
  fEXIF_SensingMethod := value;
  if value<>-1 then
    EXIFTagsAdd($A217)
  else
    EXIFTagsDel($A217);
end;

procedure TIOParamsVals.SetEXIF_FileSource(value:integer);
begin
  fEXIF_FileSource := value;
  if value<>-1 then
    EXIFTagsAdd($A300)
  else
    EXIFTagsDel($A300);
end;

procedure TIOParamsVals.SetEXIF_SceneType(value:integer);
begin
  fEXIF_SceneType := value;
  if value<>-1 then
    EXIFTagsAdd($A301)
  else
    EXIFTagsDel($A301);
end;


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////



{!!
<FS>TImageEnIO.LoadFromStreamJpeg

<FM>Declaration<FC>
procedure LoadFromStreamJpeg(Stream: TStream);

<FM>Description<FN>
LoadFromStreamJpeg loads the image from a JPEG stream.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
If <A TImageEnIO.StreamHeaders> property is True, the stream must have a special header (saved with <A TImageEnIO.SaveToStreamJPEG>).


<FM>Example<FC>

// loads a JPEG file with LoadfFromStreamJPEG
var fs:TFileStream;
Begin
  fs:=TFileStream.Create('myfile.jpg',fmOpenRead);
  ImageEnView1.IO.LoadFromStreamJPG(fs);
  fs.free;
End;
!!}
// at the beginning could be a TStreamJpegHeader structure
procedure TImageEnIO.LoadFromStreamJpeg(Stream: TStream);
var
  sh: TStreamJpegHeader;
  lp: int64;
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamJpeg, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    lp := Stream.Position;
    Stream.Read(sh, sizeof(sh)); // carica header TStreamJpegHeader
    if sh.ID <> 'JFIF' then
      // non ha lo stream header, torna all'inizio
      Stream.Position := lp;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    ReadJpegStream(Stream, nil, fIEBitmap, fParams, Progress, False, false, true, false, true,true,-1,fParams.IsNativePixelFormat);
    CheckDPI;
    if sh.ID = 'JFIF' then
      Stream.Position := lp + sizeof(sh) + sh.dim;
    if fAutoAdjustDPI then
      AdjustDPI;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    fParams.fFileName := '';
    fParams.fFileType := ioJPEG;
    Update;
  finally
    DoFinishWork;
  end;
end;


{!!
<FS>TImageEnIO.SaveToStreamJpeg

<FM>Declaration<FC>
procedure SaveToStreamJpeg(Stream: TStream);

<FM>Description<FN>
SaveToStreamJpeg saves the current image as JPEG in the Stream.

If <A TImageEnIO.StreamHeaders> property is True, it adds an additional special header as needed for multi-image streams.


<FM>Example<FC>

// Saves ImageEnView1 and ImageEnView2 attached images in file images.dat
// images.dat isn't loadable with LoadFromFileXXX methods
var
  fs:TFileStream;
Begin
  fs:=TFileStream.Create('bmpimages.dat',fmCreate);
  ImageEnView1.IO.StreamHeaders:=True;
  ImageEnView1.IO.SaveToStreamJPEG(fs);
  ImageEnView2.IO.StreamHeaders:=True;
  ImageEnView2.IO.SaveToStreamJPEG(fs);
  fs.free;
End;

// Saves a single image in image.jpg
// image.jpg is loadable with LoadFromFileXXX methods
var
  fs.TFileStream;
Begin
  fs:=TFileStream.Create('image.jpg');
  ImageEnView1.IO.StreamHeaders:=False;
  ImageEnView1.IO.SaveToFileJPEG(fs);
End;

!!}
procedure TImageEnIO.SaveToStreamJpeg(Stream: TStream);
var
  sh: TStreamJpegHeader;
  lp, lp2: int64;
  Progress: TProgressRec;
  buf: pointer;
  lbuf, mi, i: integer;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamJpeg, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    lp := 0;
    if fStreamHeaders then
    begin
      lp := Stream.position; // save initial position
      Stream.write(sh, sizeof(sh)); // leaves spaces for the header
    end;

    // update APP13 - 8BIM dpi info (Photoshop) resolution. This is overwritten if IPTC is written.
    UpdateAPP138BimResolution;

    // update APP13 marker with IPTC_Info
    if (fParams.IPTC_Info.UserChanged) or ( (fParams.IPTC_Info.Count>0) and (fParams.JPEG_MarkerList.Count=0) ) then
    begin
      fParams.IPTC_Info.SaveToStandardBuffer(buf, lbuf, true);
      mi := fParams.JPEG_MarkerList.IndexOf(JPEG_APP13);
      if buf <> nil then
      begin
        // replace or add IPTC marker
        if mi >= 0 then
          fParams.JPEG_MarkerList.SetMarker(mi, JPEG_APP13, buf, lbuf)
        else
          fParams.JPEG_MarkerList.AddMarker(JPEG_APP13, buf, lbuf);
        freemem(buf);
      end
      else if mi >= 0 then
        // remove IPTC marker
        fParams.JPEG_MarkerList.DeleteMarker(mi);
    end;

    // Exif info
    if fParams.EXIF_HasExifData then
    begin
      // save in temporary buffer
      SaveEXIFToStandardBuffer(fParams, buf, lbuf, true);
      // remove previous EXIF data
      with fParams.JPEG_MarkerList do
        for i:=0 to Count-1 do
          if (MarkerType[i]=JPEG_APP1) and CheckEXIFFromStandardBuffer(MarkerData[i], MarkerLength[i]) then
          begin
            DeleteMarker(i);
            break;
          end;
      // save in APP1
      fParams.JPEG_MarkerList.AddMarker(JPEG_APP1,buf,lbuf);
      freemem(buf);
    end;

    // XMP
    // remove previous XMP data
    with fParams.JPEG_MarkerList do
      for i:=0 to Count-1 do
        if (MarkerType[i]=JPEG_APP1) and (IEFindXMPFromJpegTag(MarkerData[i], MarkerLength[i])<>nil) then
        begin
          DeleteMarker(i);
          break;
        end;
    if fParams.XMP_Info<>'' then
    begin
      // save in temporary buffer
      IESaveXMPToJpegTag(fParams,buf,lbuf);
      // save in APP1
      fParams.JPEG_MarkerList.AddMarker(JPEG_APP1,buf,lbuf);
      freemem(buf);
    end;

    // save jpeg
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    WriteJpegStream(Stream, fIEBitmap, fParams, Progress);
    if fStreamHeaders then
    begin
      lp2 := Stream.position; // saves final position
      Stream.position := lp; // return to initial position
      sh.ID := 'JFIF';
      sh.dim := lp2 - lp - sizeof(sh);
      Stream.Write(sh, sizeof(sh)); // Saves header TStreamJpegHeader
      Stream.position := lp2; // return to final position
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.PreviewFont

<FM>Declaration<FC>
property PreviewFont: TFont;

<FM>Description<FN>
The PreviewFont property contains the font used in the <A TImageEnIO.DoPreviews> dialog.
Make sure the size of the font match label's length.

<FM>Example<FC>

ImageEnView1.IO.PreviewFont.Name:='MS Times New Roman';
ImageEnView1.IO.DoPreviews([ppAll]);
!!}
procedure TImageEnIO.SetPreviewFont(f: TFont);
begin
  fPreviewFont.assign(f);
end;

procedure TImageEnIO.SyncLoadFromStreamBMP(Stream:TStream);
var
  Progress: TProgressRec;
  tmpAlphaChannel: TIEMask;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    tmpAlphaChannel := nil;
    BMPReadStream(Stream, fIEBitmap, 0, fParams, Progress, false, false,tmpAlphaChannel,not fParams.BMP_HandleTransparency);
    CheckDPI;
    if assigned(tmpAlphaChannel) then
    begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
      FreeAndNil(tmpAlphaChannel);
    end;
    if fAutoAdjustDPI then
      AdjustDPI;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    fParams.fFileName := '';
    fParams.fFileType := ioBMP;
    update;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamBMP

<FM>Declaration<FC>
procedure LoadFromStreamBMP(Stream:TStream);

<FM>Description<FN>
LoadFromStreamBMP loads the image from a BMP stream.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
If <A TImageEnIO.StreamHeaders> property is True, the stream must have a special header (saved with <A TImageEnIO.SaveToStreamBMP>).



<FM>Example<FC>

// loads a BMP file with LoadfFromStreamBMP
var fs:TFileStream;
Begin
  fs:=TFileStream.Create('myfile.bmp',fmOpenRead);
  ImageEnView1.IO.LoadFromStreamBMP(fs);
  fs.free;
End;

!!}
procedure TImageEnIO.LoadFromStreamBMP(Stream:TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamBMP, Stream);
    exit;
  end;
  SyncLoadFromStreamBMP(Stream);
end;



{!!
<FS>TImageEnIO.LoadFromFileBMP

<FM>Declaration<FC>
procedure LoadFromFileBMP(const FileName:WideString);

<FM>Description<FN>
LoadFromFileBMP loads an image from a BMP file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.


<FM>Example<FC>

ImageEnView1.IO.LoadFromFileBMP('myimage.bmp');

!!}
procedure TImageEnIO.LoadFromFileBMP(const FileName:WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileBMP, FileName);
    exit;
  end;
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamBMP(fs);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;




{!!
<FS>TImageEnIO.AssignParams

<FM>Declaration<FC>
procedure AssignParams(Source: TObject);

<FM>Description<FN>
Assigns file format parameters from another TImageEnIO component or <A TIOParamsVals> object.
!!}
// Copy only Params
procedure TImageEnIO.AssignParams(Source: TObject);
begin
  if Source is TImageEnIO then
    fParams.assign((Source as TImageEnIO).Params)
  else if Source is TIOParamsVals then
    fParams.assign(Source as TIOParamsVals);
end;

{!!
<FS>IsKnownFormat

<FM>Declaration<FC>
function IsKnownFormat(const FileName:WideString):boolean;

<FM>Description<FN>
Returns <FC>true<FN> if the specified filename is a known file format.

<FM>Example<FC>
If IsKnownFormat('test.fax') then
  ShowMessage('ok, I can load it');
!!}
function IsKnownFormat(const FileName: WideString): boolean;
var
  fpi: TIEFileFormatInfo;
begin
  fpi := IEFileFormatGetInfo2(string(IEExtractFileExtW(FileName)));
  result := assigned(fpi) and (@fpi.ReadFunction <> nil);
end;

{!!
<FS>FindFileFormat

<FM>Declaration<FC>
function FindFileFormat(const FileName: WideString; VerifyExtension:boolean):<A TIOFileType>;

<FM>Description<FN>
Returns file format of the specified file. FindFileFormat reads the file and try to recognize file format from file header.

If <FC>VerifyExtension<FN> is False, the <FC>FindFileFormat<FN> function doesn't examine the file extension.

<FC>FineFileFormat<FN> uses <A FindStreamFormat> to detect image format from file header.

<FM>Example<FC>

var
  ss:TIOFileType;
begin
  ss:=FindFileFormat('myfile.dat',false);
  if ss=ioGIF then
    ImageEnView1.IO.LoadFromFileGIF('myfile.dat')
  else if ss=ioJPEG then
    ImageEnView1.IO.LoadFromFileJpeg('myfile.dat');
end;
!!}
// recognize JPG, GIF, PCX, DCX, BMP, TIF, PNG, ICO, CUR, TGA, PXM, JP2, JPC, J2C, J2K, RAW, PSD, HDP
// supports registered file formats
function FindFileFormat(const FileName: WideString; VerifyExtension: boolean): TIOFileType;
var
  fs: TIEWideFileStream;
  fpi: TIEFileFormatInfo;
begin
  result := ioUnknown;
  if (FileName='') or not IEFileExistsW(FileName) then
    exit;
  // verify stream
  try
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      result := FindStreamFormat(fs);
    finally
      FreeAndNil(fs);
    end;
  except
  end;

  fpi := IEFileFormatGetInfo2(string(IEExtractFileExtW(FileName)));

  // raw formats cannot be confused with TIFF, then we have to look the extension
  if (fpi<>nil) and (fpi.FileType=ioRAW) and (result=ioTIFF) then
    result:=ioRAW;

  if (fpi<>nil) and not fpi.InternalFormat then
    result:=fpi.FileType
  else if VerifyExtension and (result <> ioUnknown) then
  begin
    // verify extension
    if assigned(fpi) then
    begin
      if (result <> ioICO) and (result <> ioCUR) then
      begin
        if result <> fpi.FileType then
          result := ioUnknown;
      end
      else
        result := fpi.FileType;
    end
    else
      result := ioUnknown;
  end;
end;

function AVITryStream(Stream: TStream): boolean;
var
  l: int64;
  s1, s2: array[0..3] of AnsiChar;
begin
  l := Stream.Position;
  Stream.Read(s1[0], 4);
  Stream.Seek(4, soCurrent);
  Stream.Read(s2[0], 4);
  result := (s1 = 'RIFF') and (s2 = 'AVI ');
  Stream.Position := l;
end;

{!!
<FS>FindStreamFormat

<FM>Declaration<FC>
function FindStreamFormat(Stream:TStream):<A TIOFileType>;

<FM>Description<FN>
Returns the format of the specified file.
FindStreamFormat reads the stream and tries to recognize the file's format from the file's header.
This function can recognize one of following file formats:

<TABLE>
<R> <H>Return value</H> <H>File format</H> </R>
<R> <C>ioGIF</C> <C>GIF</C> </R>
<R> <C>ioBMP</C> <C>BMP</C> </R>
<R> <C>ioPCX</C> <C>PCX</C> </R>
<R> <C>ioTIFF</C> <C>TIFF</C> </R>
<R> <C>ioPNG</C> <C>PNG</C> </R>
<R> <C>ioDICOM</C> <C>DICOM</C> </R>
<R> <C>ioICO</C> <C>ICO</C> </R>
<R> <C>ioCUR</C> <C>CUR</C> </R>
<R> <C>ioTGA</C> <C>TGA</C> </R>
<R> <C>ioPXM</C> <C>PXM</C> </R>
<R> <C>ioJPEG</C> <C>JPEG</C> </R>
<R> <C>ioJP2, ioJ2K</C> <C>JPEG2000</C> </R>
<R> <C>ioAVI</C> <C>AVI</C> </R>
<R> <C>ioDCX</C> <C>DCX</C> </R>
<R> <C>ioWMF</C> <C>WMF</C> </R>
<R> <C>ioEMF</C> <C>EMF</C> </R>
<R> <C>ioPSD</C> <C>PSD</C> </R>
<R> <C>ioIEV</C> <C>IEV (ImageEn vectorial objects)</C> </R>
<R> <C>ioLYR</C> <C>LYR (ImageEn layers)</C> </R>
<R> <C>ioALL</C> <C>ALL (ImageEn vectorial objects and layers)</C> </R>
<R> <C>ioRAW</C> <C>RAW (when dcraw plugin is not installed)</C> </R>
<R> <C>ioHDP</C> <C>Microsoft HD Photo</C> </R>
<R> <C>ioDLLPLUGINS + offset</C> <C>External plugins (ie dcraw)</C> </R>
<R> <C>ioUSER + offset</C> <C>User registered file formats</C> </R>
</TABLE>

!!}
function FindStreamFormat(Stream: TStream): TIOFileType;
var
  Size: integer;
  HeaderJpegStream: TStreamJpegHeader;
  HeaderGIF: TGIFHeader;
  HeaderPcx: PCXSHead;
  HeaderPcx2: TPcxHeader;
  HeaderBmp: TBITMAPFILEHEADER;
  HeaderTIFF: TIFFSHead;
  id: array[0..3] of AnsiChar;
  lp: int64;
  q: integer;
begin
  result := ioUnknown;
  try
    lp := Stream.Position;
    Size := Stream.Size;

    try

      // try jpeg (with extra header)
      if Size > sizeof(TStreamJpegHeader) then
      begin
        Stream.Read(HeaderJpegStream, sizeof(HeaderJpegStream));
        Stream.Position := lp;
        if HeaderJpegStream.ID = 'JFIF' then
        begin
          result := ioJPEG;
          exit;
        end;
      end;

      // try GIF (no extra header)
      if Size > sizeof(TGIFHeader) then
      begin
        Stream.Read(HeaderGIF, sizeof(HeaderGIF));
        Stream.Position := lp;
        if (headergif.id[0] = 'G') and (headergif.id[1] = 'I') and (headergif.id[2] = 'F') then
        begin
          result := ioGIF;
          exit;
        end;
      end;

      // try PCX (with extra header - ver.2)
      if Size > sizeof(PCXSHead) then
      begin
        Stream.Read(HeaderPCX, sizeof(HeaderPCX));
        Stream.Position := lp;
        if HeaderPCX.id = 'PCX2' then
        begin
          result := ioPCX;
          exit;
        end;
      end;

      // try PCX (with extra header - ver.1)
      if Size > 4 then
      begin
        Stream.Read(id, 4);
        Stream.Position := lp;
        if id = 'PCX' then
        begin
          result := ioPCX;
          exit;
        end;
      end;

      // try BMP (no extra header)
      if Size > sizeof(HeaderBmp) then
      begin
        Stream.Read(HeaderBmp, sizeof(HeaderBmp));
        Stream.Position := lp;
        if HeaderBmp.bfType = 19778 then
        begin
          result := ioBMP;
          exit;
        end;
      end;

      // try PCX (no extra header)
      if Size > sizeof(TPcxHeader) then
      begin
        Stream.Read(HeaderPcx2, sizeof(HeaderPcx2));
        Stream.Position := lp;
        if (HeaderPcx2.Manufacturer = $0A) and (HeaderPcx2.Version <= 5) then
        begin
          result := ioPCX;
          exit;
        end;
      end;

      // try TIFF (with extra header)
      if Size > sizeof(TIFFSHead) then
      begin
        Stream.Read(HeaderTIFF, sizeof(HeaderTIFF));
        Stream.Position := lp;
        if HeaderTIFF.ID = 'TIFF' then
        begin
          result := ioTIFF;
          exit;
        end;
      end;

      {$ifdef IEINCLUDEWIC}
      // try HDP (Microsoft PhotoHD)
      if IsHDPStream(Stream) then
      begin
        result := ioHDP;
        exit;
      end;
      {$endif}

      // try TIFF (no extra header)
      if IsTIFFStream(Stream) and not IsDNGStream(Stream) then
      begin
        result := ioTIFF;
        exit;
      end;

      // try PNG
  {$IFDEF IEINCLUDEPNG}
      if Size > 8 then
      begin
        if IsPNGStream(Stream) then
        begin
          result := ioPNG;
          exit;
        end;
      end;
  {$ENDIF}

      // try DICOM
  {$ifdef IEINCLUDEDICOM}
      if IEDICOMTryStream(Stream) then
      begin
        result := ioDICOM;
        exit;
      end;
  {$endif}

      // try ICO
      if IcoTryStream(Stream) then
      begin
        result := ioICO;
        exit;
      end;

      // try CUR
      if CurTryStream(Stream) then
      begin
        result := ioCUR;
        exit;
      end;

      // try TGA
      if TryTGA(Stream) then
      begin
        result := ioTGA;
        exit;
      end;

      // try PXM
      if tryPXM(Stream) then
      begin
        result := ioPXM;
        exit;
      end;

  {$IFDEF IEINCLUDEJPEG2000}
      // try jp2
      if J2KTryStreamJP2(Stream) then
      begin
        result := ioJP2;
        exit;
      end;
      // try j2k, jpc, j2c
      if J2KTryStreamJ2K(Stream) then
      begin
        result := ioJ2K;
        exit;
      end;
  {$ENDIF}

      // try AVI
      if AVITryStream(Stream) then
      begin
        result := ioAVI;
        exit;
      end;

      // try DCX
      if IEDCXTryStream(Stream) then
      begin
        result := ioDCX;
        exit;
      end;

      // try WMF
      if IEWMFTryStream(Stream) then
      begin
        result:=ioWMF;
        exit;
      end;

      // try EMF
      if IEEMFTryStream(Stream) then
      begin
        result:=ioEMF;
        exit;
      end;

      {$ifdef IEINCLUDEPSD}

      // try PSD
      if IETryPSD(Stream) then
      begin
        result:=ioPSD;
        exit;
      end;

      {$endif}

      // try IEV
      if IETryIEV(Stream) then
      begin
        result:=ioIEV;
        exit;
      end;

      // try LYR
      if IETryLYR(Stream) then
      begin
        result:=ioLYR;
        exit;
      end;

      // try ALL (LYR+IEV)
      if IETryALL(Stream) then
      begin
        result:=ioALL;
        exit;
      end;

      // try jpeg (without extra header)
      if JpegTryStream(Stream, true) >= 0 then
      begin
        result := ioJPEG;
        exit;
      end;

      // try user registered file formats
      for q := 0 to iegFileFormats.Count - 1 do
        with TIEFileFormatInfo(iegFileFormats[q]) do
          if assigned(TryFunction) then
          begin
            Stream.Position := lp;
            if TryFunction(Stream,FileType) then
            begin
              result := FileType;
              break;
            end;
          end;
      Stream.Position := lp;
      if result <> ioUnknown then
        exit;

      // try RAW
      {$ifdef IEINCLUDERAWFORMATS}
      if IERAWTryStream(Stream) then
      begin
        result := ioRAW;
        exit;
      end;
      {$endif}

    finally
      Stream.Position := lp;
    end;

  except
  end;
end;

// reset fBitmap (called from RegisterBitmapChangeEvent)
procedure TImageEnIO.OnBitmapChange(Sender: TObject; destroying: boolean);
begin
  if destroying then
  begin
    fImageEnView := nil;
  end
  else if assigned(fImageEnView) then
  begin
    if assigned(fIEBitmap) then
    begin
      fIEBitmap := fImageEnView.IEBitmap;
      fBitmap := nil; // both fBitmap and fIEBitmap aren't allowed if not encapsulated
    end
    else if assigned(fBitmap) then
    begin
      fBitmap := fImageEnView.Bitmap;
      if fIEBitmapCreated then
        fIEBitmap.EncapsulateTBitmap(fBitmap, true)
    end;

    fParams.DpiX:=fImageEnView.DpiX;
    fParams.DpiY:=fImageEnView.DpiY;
  end;
end;

{$IFDEF IEINCLUDEPNG}

{!!
<FS>TImageEnIO.LoadFromFilePNG

<FM>Declaration<FC>
procedure LoadFromFilePNG(const FileName: WideString);

<FM>Description<FN>
LoadFromFilePNG loads an image from a PNG file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be True.
FileName is the file name with extension.

!!}
procedure TImageEnIO.LoadFromFilePNG(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFilePNG, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fParams.PNG_Background := tcolor2trgb(Background);
      fIEBitmap.RemoveAlphaChannel;
      ReadPNGStream(fs, fIEBitmap, fParams, Progress, false);
      CheckDPI;
      if fAutoAdjustDPI then
        AdjustDPI;
      fParams.fFileName := FileName;
      fParams.fFileType := ioPNG;
      SetViewerDPI(fParams.DpiX, fParams.DpiY);
      BackGround := TRGB2TCOLOR(fParams.PNG_Background);
      update;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEPNG}

{!!
<FS>TImageEnIO.LoadFromStreamPNG

<FM>Declaration<FC>
procedure LoadFromStreamPNG(Stream: TStream);

<FM>Description<FN>
LoadFromStreamPNG loads the image from a PNG stream.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property is True.

!!}
procedure TImageEnIO.LoadFromStreamPNG(Stream: TStream);
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamPNG, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    ReadPNGStream(Stream, fIEBitmap, fParams, Progress, false);
    CheckDPI;
    if fAutoAdjustDPI then
      AdjustDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioPNG;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    BackGround := TRGB2TCOLOR(fParams.PNG_Background);
    update;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEPNG}

{!!
<FS>TImageEnIO.SaveToFilePNG

<FM>Declaration<FC>
procedure SaveToFilePNG(const FileName: WideString);

<FM>Description<FN>
SaveToFilePNG saves the current image to a file in PNG format.

FileName is the file name, with extension.


<FM>Example<FC>

// Set best compression
ImageEnView1.IO.Params.PNG_Filter:=ioPNG_FILTER_PAETH;
ImageEnView1.IO.Params.PNG_Compression:=9;
// Save PNG
ImageEnView1.IO.SaveToFilePNG('max.png');

!!}
procedure TImageEnIO.SaveToFilePNG(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
  iemask: TIEMask;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFilePNG, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    try
      if fIEBitmap.HasAlphaChannel then
      begin
        iemask := TIEMask.Create;
        fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
        WritePNGStream(fs, fIEBitmap, fParams, Progress, iemask);
        FreeAndNil(iemask);
      end
      else
        WritePNGStream(fs, fIEBitmap, fParams, Progress, nil);
      fParams.FileName:=FileName;
      fParams.FileType:=ioPNG;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEPNG}

{!!
<FS>TImageEnIO.SaveToStreamPNG

<FM>Declaration<FC>
procedure SaveToStreamPNG(Stream: TStream);

<FM>Description<FN>
SaveToStreamPNG  saves the current image as PNG in the Stream.


<FM>Example<FC>

// Set best compression
ImageEnView1.IO.Params.PNG_Filter:=ioPNG_FILTER_PAETH;
ImageEnView1.IO.Params.PNG_Compression:=9;
// Save PNG
ImageEnView1.IO.SaveToStreamPNG(Stream);

!!}
procedure TImageEnIO.SaveToStreamPNG(Stream: TStream);
var
  Progress: TProgressRec;
  iemask: TIEMask;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamPNG, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    if fIEBitmap.HasAlphaChannel then
    begin
      iemask := TIEMask.Create;
      fIEBitmap.AlphaChannel.CopyToTIEMask(iemask);
      WritePNGStream(Stream, fIEBitmap, fParams, Progress, iemask);
      FreeAndNil(iemask);
    end
    else
      WritePNGStream(Stream, fIEBitmap, fParams, Progress, nil);
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$ifdef IEINCLUDEDICOM}

{!!
<FS>TImageEnIO.LoadFromFileDICOM

<FM>Declaration<FC>
procedure LoadFromFileDICOM(const FileName: WideString);

<FM>Description<FN>
Loads a DICOM image.
This method is necessary when the DICOM file hasn't extension and hasn't a valid DICOM header, but you are sure that is a DICOM file.
DICOM parameters are stored in <A TIOParamsVals.DICOM_Tags>.

<FM>Example<FC>

ImageEnView1.IO.LoadFromFileDICOM('heart');
!!}
procedure TImageEnIO.LoadFromFileDICOM(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileDICOM, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fIEBitmap.RemoveAlphaChannel;
      IEDICOMRead(fs, fParams, fIEBitmap, Progress, false);
      fParams.fFileName := FileName;
      fParams.fFileType := ioDICOM;
      Update;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;


{!!
<FS>TImageEnIO.LoadFromStreamDICOM

<FM>Declaration<FC>
procedure LoadFromStreamDICOM(Stream: TStream);

<FM>Description<FN>
Loads a DICOM image from stream.
DICOM parameters are stored in <A TIOParamsVals.DICOM_Tags>.
!!}
procedure TImageEnIO.LoadFromStreamDICOM(Stream: TStream);
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamDICOM, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    IEDICOMRead(Stream, fParams, fIEBitmap, Progress, false);
    fParams.fFileName := '';
    fParams.fFileType := ioDICOM;
    Update;
  finally
    DoFinishWork;
  end;
end;
{$endif}

{!!
<FS>TImageEnIO.PreviewsParams

<FM>Declaration<FC>
property PreviewsParams:<A TIOPreviewsParams>;

<FM>Description<FN>
This property specifies the features that the input/output preview dialog will have.

<FM>Example<FC>

ImageEnView1.IO.PreviewsParams:=[ioppDefaultLockPreview];
ImageEnView1.IO.DoPreviews([ppTIFF]);
!!}
procedure TImageEnIO.SetIOPreviewParams(v: TIOPreviewsParams);
begin
  fPreviewsParams := v;
end;

function TImageEnIO.GetIOPreviewParams: TIOPreviewsParams;
begin
  result := fPreviewsParams;
end;

{!!
<FS>TImageEnIO.LoadFromFileICO

<FM>Declaration<FC>
procedure LoadFromFileICO(const FileName: WideString);

<FM>Description<FN>
LoadFromFileICO loads an image from an ICO file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be True.
FileName is the file name with extension.


<FM>Example<FC>

ImageEnView1.IO.LoadFromFileICO('gates.ico');

!!}
procedure TImageEnIO.LoadFromFileICO(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileICO, FileName);
    exit;
  end;
  fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamICO(fs);
  finally
    FreeAndNil(fs);
  end;
  fParams.fFileName := FileName;
end;


procedure TImageEnIO.SyncLoadFromStreamICO(Stream:TStream);
var
  Progress: TProgressRec;
  tmpAlphaChannel: TIEMask;
begin
  tmpAlphaChannel := nil;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    ICOReadStream(Stream, fIEBitmap, fParams, false, Progress, tmpAlphaChannel, false);
    CheckDPI;
    if assigned(tmpAlphaChannel) then
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
    if fAutoAdjustDPI then
      AdjustDPI;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    fParams.fFileName := '';
    fParams.fFileType := ioICO;
    Update;
  finally
    tmpAlphaChannel.Free;
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamICO

<FM>Declaration<FC>
procedure LoadFromStreamICO(Stream:TStream);


<FM>Description<FN>
LoadFromStreamICO loads an ICO image from a stream.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.

!!}
procedure TImageEnIO.LoadFromStreamICO(Stream:TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamICO, Stream);
    exit;
  end;
  SyncLoadFromStreamICO(Stream);
end;



procedure TImageEnIO.SyncLoadFromStreamCUR(Stream:TStream);
var
  Progress: TProgressRec;
  tmpAlphaChannel: TIEMask;
begin
  tmpAlphaChannel := nil;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    CURReadStream(Stream, fIEBitmap, fParams, false, Progress, tmpAlphaChannel, false);
    CheckDPI;
    if assigned(tmpAlphaChannel) then
      fIEBitmap.AlphaChannel.CopyFromTIEMask(tmpAlphaChannel);
    if fAutoAdjustDPI then
      AdjustDPI;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    fParams.fFileName := '';
    fParams.fFileType := ioCUR;
    Update;
  finally
    tmpAlphaChannel.Free;
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamCUR

<FM>Declaration<FC>
procedure LoadFromStreamCUR(Stream:TStream);

<FM>Description<FN>
LoadFromStreamCUR loads a CUR image from a stream.

If the stream does not represent a valid image format, the <A TImageEnIO.Aborting> property is True.

!!}
procedure TImageEnIO.LoadFromStreamCUR(Stream:TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamCUR, Stream);
    exit;
  end;
  SyncLoadFromStreamCUR(Stream);
end;



{!!
<FS>TImageEnIO.LoadFromFileCUR

<FM>Declaration<FC>
procedure LoadFromFileCUR(const FileName: WideString);

<FM>Description<FN>
LoadFromFileCUR loads an image from a CUR file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.


<FM>Example<FC>

ImageEnView1.IO.LoadFromFileCUR('gates.cur');

!!}
procedure TImageEnIO.LoadFromFileCUR(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileCUR, FileName);
    exit;
  end;
  fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamCUR(fs);
  finally
    FreeAndNil(fs);
  end;
  fParams.fFileName := FileName;
end;

{!!
<FS>TImageEnIO.ImportMetafile

<FM>Declaration<FC>
procedure ImportMetafile(const FileName: WideString; Width, Height:integer; WithAlpha:boolean);
procedure ImportMetafile(Stream:TStream; Width:integer=-1; Height:integer=-1; WithAlpha: boolean=true);
procedure ImportMetaFile(meta:TMetaFile; Width, Height:integer; WithAlpha:boolean);

<FM>Description<FN>
ImportMetafile imports a WMF or EMF vectorial image.

Width and Height are required image sizes (the rectangle where the vectorial image will be painted).
To maintain the image aspect ratio set only one size, assigning -1 to the other (ex. ImportMetafile('axi.emf',-1,500) ).

If WithAlpha is true then ImportMetaFile creates an alpha channel, making visible only the metafile content.

If the file does not represent a valid image format, ImportMetafile raises an EInvalidGraphic exception.

Important: ImportMetafile converts vectorial image to raster image, so we have to limit the rasterized image sizes.
The maximum allowed size is stored in the public field named <A iegMaxImageEMFSize>.

<FM>Example<FC>

// import vectorial image 'alfa.wmf', resizing to 500xHHH (HHH is autocalculated)
ImageEnView1.IO.ImportMetafile('alfa.wmf',500,-1, true);
!!}
// If Width or Height is -1 then it is auto-calculated maintain aspect ratio
// Import... because this is a vectorial image
// SHOULD NOT BE IN THREADS BECAUSE USE TCANVAS AND TMETAFILE!!
procedure TImageEnIO.ImportMetaFile(meta:TMetaFile; Width, Height:integer; WithAlpha:boolean);
var
  dib: TIEDibBitmap;
  dibcanvas: TCanvas;
  x, y: integer;
  px: pbyte;
  p_rgb: PRGB;
begin
  fAborting := false;
  if (meta.width = 0) or (meta.height = 0) then
  begin
    fAborting := true;
    exit;
  end;
  if (Width = 0) or (Height = 0) then
    exit;
  if not MakeConsistentBitmap([]) then
    exit;
  fParams.ResetInfo;

  if (Width > 0) or (Height > 0) then   // 3.0.4
  begin
    if (Width > 0) and (Height > 0) then  // 3.0.4
    begin
      meta.Width := Width;
      meta.Height := Height;
    end
    else
    begin
      if Width < 0 then
      begin
        meta.Width := (meta.Width * Height) div meta.Height;
        meta.Height := Height;
      end
      else if Height < 0 then
      begin
        meta.Height := (meta.Height * Width) div meta.Width;
        meta.Width := Width;
      end;
    end;
  end;
  if (meta.width > iegMaxImageEMFSize) or (meta.height > iegMaxImageEMFSize) then
  begin
    if meta.Height > meta.Width then
    begin
      meta.Width := (meta.Width * iegMaxImageEMFSize) div meta.Height;
      meta.Height := iegMaxImageEMFSize;
    end
    else
    begin
      meta.Height := (meta.Height * iegMaxImageEMFSize) div meta.Width;
      meta.Width := iegMaxImageEMFSize;
    end;
  end;

  dib := TIEDibBitmap.Create;
  dibcanvas := TCanvas.Create;
  dib.AllocateBits(meta.Width, meta.Height, 24);
  dibcanvas.Handle := dib.HDC;
  fParams.fFileName := '';
  if meta.Enhanced then
    fParams.fFileType := ioEMF
  else
    fParams.fFileType := ioWMF;
  fParams.BitsPerSample := 8;
  fParams.SamplesPerPixel := 3;
  fParams.fWidth := dib.Width;
  fParams.fHeight := dib.Height;
  fParams.fOriginalWidth := dib.Width;
  fParams.fOriginalHeight := dib.Height;
  fParams.DpiX := gDefaultDPIX;
  fParams.DpiY := gDefaultDPIY;
  fParams.FreeColorMap;
  SetViewerDPI(fParams.DpiX, fParams.DpiY);
  dibCanvas.Brush.Color := GetReBackground;
  dibcanvas.Brush.Style := bsSolid;
  dibCanvas.fillrect(rect(0, 0, dib.width, dib.height));
  dibCanvas.Draw(0, 0, meta);
  fIEBitmap.CopyFromTDibBitmap(dib);
  FreeAndNil(dibcanvas);
  FreeAndNil(dib);
  // alpha channel
  fIEBitmap.RemoveAlphaChannel;
  if WithAlpha then
  begin
    dib := TIEDibBitmap.Create;
    dibcanvas := TCanvas.Create;
    dib.AllocateBits(meta.Width, meta.Height, 24);
    dibcanvas.Handle := dib.HDC;
    dibCanvas.Brush.Color := $00010203; // transparent color (we hope it isn't in the image)
    dibcanvas.Brush.Style := bsSolid;
    dibCanvas.FillRect(rect(0, 0, dib.width, dib.height));
    dibcanvas.Draw(0, 0, meta);
    for y := 0 to fIEBitmap.AlphaChannel.Height - 1 do
    begin
      px := fIEBitmap.AlphaChannel.Scanline[y];
      p_rgb := dib.Scanline[y];
      for x := 0 to fIEBitmap.AlphaChannel.Width - 1 do
      begin
        with p_rgb^ do
          if (b = $01) and (g = $02) and (r = $03) then
            px^ := 0
          else
            px^ := 255;
        inc(p_rgb);
        inc(px);
      end;
    end;
    fIEBitmap.AlphaChannel.SyncFull;
    FreeAndNil(dibcanvas);
    FreeAndNil(dib);
  end;
  Update;
end;

procedure TImageEnIO.ParamsFromMetaFile(stream:TStream);
var
  meta:TMetaFile;
begin
  meta := TMetaFile.Create;
  meta.LoadFromStream(stream);
  try
    fParams.fFileName := '';
    if meta.Enhanced then
      fParams.fFileType := ioEMF
    else
      fParams.fFileType := ioWMF;
    fParams.BitsPerSample := 8;
    fParams.SamplesPerPixel := 3;
    fParams.fWidth := meta.Width;
    fParams.fHeight := meta.Height;
    fParams.fOriginalWidth := meta.Width;
    fParams.fOriginalHeight := meta.Height;
    fParams.DpiX := gDefaultDPIX;
    fParams.DpiY := gDefaultDPIY;
    fParams.FreeColorMap;
  finally
    meta.Free;
  end;
end;

procedure TImageEnIO.ImportMetafile(const FileName: WideString; Width, Height: integer; WithAlpha: boolean);
var
  meta: TMetafile;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateImportMetaFile(self, ImportMetaFile, FileName, Width, Height, WithAlpha);
    exit;
  end;
  try
    meta := TMetaFile.Create;
    try
      meta.LoadFromFile(FileName);
      ImportMetaFile(meta,Width,Height,WithAlpha);
      fParams.fFileName := FileName;
    finally
      FreeAndNil(meta);
    end;
  finally
    DoFinishWork;
  end;
end;

procedure TImageEnIO.ImportMetafile(Stream:TStream; Width:integer=-1; Height:integer=-1; WithAlpha: boolean=true);
var
  meta: TMetafile;
begin
  try
    meta := TMetaFile.Create;
    try
      meta.LoadFromStream(Stream);
      ImportMetaFile(meta, Width, Height, WithAlpha);
      fParams.fFileName := '';
    finally
      FreeAndNil(meta);
    end;
  finally
    DoFinishWork;
  end;
end;


{!!
<FS>TImageEnIO.ParamsFromFileFormat

<FM>Declaration<FC>
procedure ParamsFromFileFormat(const FileName: WideString; format:<A TIOFileType>);

<FM>Description<FN>
The ParamsFromFileFormat method fills Params when reading an image from Stream, but don't load the image into the component.

For ParamsFromFileFormat, FileName is the file name with full path.
format is the file format you know the stream or file contains (you cannot specify ioUnknown).

<FN>Examples<FC>

ImageEnView1.IO.ParamsFromFileFormat('alfa.jpg',ioJPEG);

ImageEnView1.IO.ParamsFromFileFormat('alfa.dat',ioJPEG);
!!}
procedure TImageEnIO.ParamsFromFileFormat(const FileName: WideString; format: TIOFileType);
var
  idummy: integer;
  fpi: TIEFileFormatInfo;
  fs: TIEWideFileStream;
  nullpr: TProgressRec;
  tempAlphaChannel: TIEMask;
  BufStream:TIEBufferedReadStream;
begin
  fs := nil;
  BufStream := nil;
  try
    fParams.fFileType := format;
    fParams.ResetInfo;
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    with nullpr do
    begin
      Aborting := @fAborting;
      fOnProgress := nil;
      Sender := nil;
    end;
    tempAlphaChannel := nil;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    BufStream := TIEBufferedReadStream.Create(fs, 8192, iegUseRelativeStreams);
    fAborting := false;
    case fParams.fFileType of
      ioTIFF: TIFFReadStream(fIEBitmap, BufStream, idummy, fParams, nullpr, True, tempAlphaChannel, true, true, false);
      ioGIF: ReadGIFStream(BufStream, fIEBitmap, idummy, fParams, nullpr, True, tempAlphaChannel, true);
      ioJPEG: ReadJpegStream(BufStream, nil, fIEBitmap, fParams, nullpr, True, false, true, false, true,true,-1,fParams.IsNativePixelFormat);
      ioICO: ICOReadStream(BufStream, fIEBitmap, fParams, True, nullpr, tempAlphaChannel, true);
      ioCUR: CURReadStream(BufStream, fIEBitmap, fParams, True, nullpr, tempAlphaChannel, true);
      ioPCX: ReadPcxStream(BufStream, fIEBitmap, fParams, BufStream.size, nullpr, True);
      ioDCX: IEDCXReadStream(BufStream, fIEBitmap, fParams, nullpr, True);
      ioBMP: BMPReadStream(BufStream, fIEBitmap, BufStream.size, fParams, nullpr, True, false,tempAlphaChannel,true);
      {$IFDEF IEINCLUDEPNG}
      ioPNG: ReadPNGStream(BufStream, fIEBitmap, fParams, nullpr, true);
      {$ENDIF}
      {$ifdef IEINCLUDEDICOM}
      ioDICOM: IEDICOMRead(BufStream, fParams, fIEBitmap, nullpr, true);
      {$endif}
      ioTGA: ReadTGAStream(BufStream, fIEBitmap, fParams, nullpr, true, tempAlphaChannel, true);
      ioPXM: PXMReadStream(BufStream, fIEBitmap, fParams, nullpr, true);
      ioWBMP: WBMPReadStream(BufStream, fIEBitmap, fParams, nullpr, true);
      {$IFDEF IEINCLUDEJPEG2000}
      ioJP2: J2KReadStream(BufStream, fIEBitmap, fParams, nullpr, true);
      ioJ2K: J2KReadStream(BufStream, fIEBitmap, fParams, nullpr, true);
      {$ENDIF}
      {$ifdef IEINCLUDERAWFORMATS}
      ioRAW: IEReadCameraRAWStream(BufStream, fIEBitmap, fParams, nullpr, true);
      {$endif}
      {$ifdef IEINCLUDEPSD}
      ioPSD: IEReadPSD(BufStream, nil, fParams, nullpr, false, nil);
      {$endif}
      {$ifdef IEINCLUDEWIC}
      ioHDP: IEHDPRead(BufStream, fIEBitmap, fParams, nullpr, true);
      {$endif}
      ioWMF, ioEMF: ParamsFromMetaFile(BufStream);
    else
      begin
        fpi := IEFileFormatGetInfo(fParams.fFileType);
        if assigned(fpi) then
          with fpi do
            if assigned(ReadFunction) then
            begin
              ReadFunction(BufStream, fIEBitmap, fParams, nullpr, true);
            end;
      end;
    end;
  except
    fParams.fFileType := ioUnknown;
  end;
  if fAborting then
    fParams.fFileType := ioUnknown;
  fParams.fFileName := FileName;
  BufStream.Free;
  fs.Free;
  DoFinishWork;
end;


{!!
<FS>TImageEnIO.ParamsFromFile

<FM>Declaration<FC>
procedure ParamsFromFile(const FileName: WideString);

<FM>Description<FN>
ParamsFromFile reads the image properties (<A TImageEnIO.Params>) without loading the image (and without changing the current image).

ParamsFromFile (and <A TImageEnIO.ParamsFromStream>) auto recognize image type from file header and file name extension.
If image is unknown the <A TImageEnIO.Params>.<A TIOParamsVals.FileType> has ioUnknown value.

See also <A TImageEnIO.ParamsFromStreamFormat> and <A TImageEnIO.ParamsFromFileFormat>.

<FM>Example<FC>

// shows bits per sample without load the image
ImageEnView1.IO.ParamsFromFile('alfa.bmp');
Label1.Caption:='alfa.bmp has'+inttostr(ImageEnView1.IO.Params.BitsPerSample)+' bits per sample';
!!}
// Fills Params reading the specified file, but the contained image
procedure TImageEnIO.ParamsFromFile(const FileName: WideString);
begin
  try
    ParamsFromFileFormat(FileName, FindFileFormat(FileName, true));
  except
    fParams.fFileType := ioUnknown;
  end;
end;

{!!
<FS>TImageEnIO.ParamsFromStreamFormat

<FM>Declaration<FC>
procedure ParamsFromStreamFormat(Stream:TStream; format:<A TIOFileType>);

<FM>Description<FN>
The ParamsFromStreamFormat method fills Params when reading an image from Stream, but don't load the image into the component.

<FC>Stream<FN> is a TStream that contains the image.
<FC>format<FN> is the file format you know the stream or file contains (you cannot specify ioUnknown).
!!}
// Fills Params reading Stream, but doesn't load the image
// format specifies the file format
// The Stream position changes
procedure TImageEnIO.ParamsFromStreamFormat(Stream: TStream; format: TIOFileType);
var
  idummy: integer;
  fpi: TIEFileFormatInfo;
  nullpr: TProgressRec;
  tempAlphaChannel: TIEMask;
  BufStream:TIEBufferedReadStream;
begin
  BufStream := TIEBufferedReadStream.Create(Stream, 8192, iegUseRelativeStreams);
  try
    fParams.fFileType := format;
    fParams.ResetInfo;
    fAborting := false;
    with nullpr do
    begin
      Aborting := @fAborting;
      fOnProgress := nil;
      Sender := nil;
    end;
    tempAlphaChannel := nil;
    case fParams.fFileType of
      ioTIFF: TIFFReadStream(fIEBitmap, BufStream, idummy, fParams, nullpr, True, tempAlphaChannel, true, true, false);
      ioGIF: ReadGIFStream(BufStream, fIEBitmap, idummy, fParams, nullpr, True, tempAlphaChannel, true);
      ioJPEG: ReadJpegStream(BufStream, nil, fIEBitmap, fParams, nullpr, True, false, true, false, true,true,-1,fParams.IsNativePixelFormat);
      ioICO: ICOReadStream(BufStream, fIEBitmap, fParams, True, nullpr, tempAlphaChannel, true);
      ioCUR: CURReadStream(BufStream, fIEBitmap, fParams, True, nullpr, tempAlphaChannel, true);
      ioPCX: ReadPcxStream(BufStream, fIEBitmap, fParams, BufStream.size, nullpr, True);
      ioDCX: IEDCXReadStream(BufStream, fIEBitmap, fParams, nullpr, True);
      ioBMP: BMPReadStream(BufStream, fIEBitmap, BufStream.size, fParams, nullpr, True, false,tempAlphaChannel,true);
      {$IFDEF IEINCLUDEPNG}
      ioPNG: ReadPNGStream(BufStream, fIEBitmap, fParams, nullpr, true);
      {$ENDIF}
      {$ifdef IEINCLUDEDICOM}
      ioDICOM: IEDICOMRead(BufStream, fParams, fIEBitmap, nullpr, true);
      {$endif}
      ioTGA: ReadTGAStream(BufStream, fIEBitmap, fParams, nullpr, True, tempAlphaChannel, true);
      ioPXM: PXMReadStream(BufStream, fIEBitmap, fParams, nullpr, True);
      ioWBMP: WBMPReadStream(BufStream, fIEBitmap, fParams, nullpr, True);
      {$IFDEF IEINCLUDEJPEG2000}
      ioJP2: J2KReadStream(BufStream, fIEBitmap, fParams, nullpr, True);
      ioJ2K: J2KReadStream(BufStream, fIEBitmap, fParams, nullpr, True);
      {$ENDIF}
      {$ifdef IEINCLUDERAWFORMATS}
      ioRAW: IEReadCameraRAWStream(BufStream, fIEBitmap, fParams, nullpr, true);
      {$endif}
      {$ifdef IEINCLUDEPSD}
      ioPSD: IEReadPSD(BufStream, nil, fParams, nullpr, false, nil);
      {$endif}
      {$ifdef IEINCLUDEWIC}
      ioHDP: IEHDPRead(BufStream, nil, fParams, nullpr, false);
      {$endif}
      ioWMF, ioEMF: ParamsFromMetaFile(BufStream);
    else
      begin
        fpi := IEFileFormatGetInfo(fParams.fFileType);
        if assigned(fpi) then
          with fpi do
            if assigned(ReadFunction) then
              ReadFunction(BufStream, fIEBitmap, fParams, nullpr, true);
      end;
    end;
  except
    fParams.fFileType := ioUnknown;
  end;
  BufStream.Free;
  if fAborting then
    fParams.fFileType := ioUnknown;
  DoFinishWork;
end;

{!!
<FS>TImageEnIO.ParamsFromStream

<FM>Declaration<FC>
procedure ParamsFromStream(Stream:TStream);

<FM>Description<FN>
Reads the image properties (<A TImageEnIO.Params>) without loading the image (and without changing the current image).

Autorecognizes image type from file header and file name extension.
If image is unknown the <A TImageEnIO.Params>.<A TIOParamsVals.FileType> has ioUnknown value.
!!}
procedure TImageEnIO.ParamsFromStream(Stream: TStream);
begin
  try
    ParamsFromStreamFormat(Stream, FindStreamFormat(Stream));
  except
    fParams.fFileType := ioUnknown;
  end;
end;

{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TIETWainParams.Create

<FM>Declaration<FC>
constructor Create(Owner: TComponent);
!!}
constructor TIETWainParams.Create(Owner: TComponent);
begin
  inherited Create;
  fOwner := Owner;
  fSourceListDataValid := false;
  fSourceListData := TList.Create;
  fCapabilitiesValid := false;
  TWainShared.hDSMLib := 0;
  TWainShared.DSM_Entry := nil;
  TWainShared.hproxy := 0;
  fSourceSettings := TMemoryStream.Create;
  //
  with fCapabilities do
  begin
    fXResolution := TIEDoubleList.Create;
    fYResolution := TIEDoubleList.Create;
    fXScaling := TIEDoubleList.Create;
    fYScaling := TIEDoubleList.Create;
    fPixelType := TIEIntegerList.Create;
    fBitDepth := TIEIntegerList.Create;
    fOrientation := TIEIntegerList.Create;
    fContrast := TIEDoubleList.Create;
    fBrightness := TIEDoubleList.Create;
    fStandardSize := TIEIntegerList.Create;
    fThreshold := TIEDoubleList.Create;
    fRotation := TIEDoubleList.Create;
  end;
  //
  SetDefaultParams;
end;

destructor TIETWainParams.Destroy;
begin
  IETW_FreeResources(@TWainShared, IEFindHandle(fOwner));
  SetDefaultParams;
  FreeAndNil(fSourceListData);
  FreeAndNil(fSourceSettings);

  with fCapabilities do
  begin
    FreeAndNil(fXResolution);
    FreeAndNil(fYResolution);
    FreeAndNil(fXScaling);
    FreeAndNil(fYScaling);
    FreeAndNil(fPixelType);
    FreeAndNil(fBitDepth);
    FreeAndNil(fOrientation);
    FreeAndNil(fContrast);
    FreeAndNil(fBrightness);
    FreeAndNil(fStandardSize);
    FreeAndNil(fThreshold);
    FreeAndNil(fRotation);
  end;
  //
  inherited;
end;

{!!
<FS>TIETWainParams.FreeResources

<FM>Declaration<FC>
procedure FreeResources;

<FM>Description<FN>
ImageEn keeps the scanner driver open to improve scanning performance. 

Call FreeResources to close and free the scanner driver after a call to <A TImageEnIO.Acquire> method: this degrades performance but can improve stability.
Applications should not call FreeResources because it is executed when the application exits.

!!}
procedure TIETWainParams.FreeResources;
begin
  IETW_FreeResources(@TWainShared, IEFindHandle(fOwner));
  TWainShared.hDSMLib := 0;
  TWainShared.DSM_Entry := nil;
  TWainShared.hproxy := 0;
end;

{!!
<FS>TIETWainParams.GetDefaultSource

<FM>Declaration<FC>
function GetDefaultSource:integer;

<FM>Description<FN>
GetDefaultSource returns the system's default TWain source.
The default ImageEn source has the index 0, but this should be different from the system's default source.

<FM>Example<FC>

// set system default source as current ImageEn Twain source
ImageEnView1.IO.TWainParams.SelectedSource:=ImageEnIO.TWainParams.GetDefaultSource;

!!}
function TIETWainParams.GetDefaultSource: integer;
var
  q, ll: integer;
  sn: AnsiString;
begin
  result := 0;
  sn := IETW_GetDefaultSource(@TWainShared, IEFindHandle(fOwner));
  FillSourceListData;
  ll := length(sn);
  for q := 0 to fSourceListData.Count - 1 do
    if IEUpperCase(IECopy(pTW_IDENTITY(fSourceListData[q])^.ProductName, 1, ll)) = IEUpperCase(sn) then
    begin
      result := q;
      break;
    end;
end;



{!!
<FS>TIETWainParams.SetDefaultParams

<FM>Declaration<FC>
procedure SetDefaultParams;

<FM>Description<FN>
SetDefaultParams restores default parameters.
!!}
// set defaults. Also free fSourceListData items and fCapabilities allocated data
procedure TIETWainParams.SetDefaultParams;
var
  q: integer;
begin
  for q := 0 to fSourceListData.Count - 1 do
    Freemem(fSourceListData[q]);
  fSourceListData.Clear;
  fVisibleDialog := true;
  fShowSettingsOnly := false;
  fCompatibilityMode := false;
  fLanguage := TWLG_USERLOCALE;
  fCountry := TWCY_USA;
  fSelectedSource := 0;
  fSourceListDataValid := false;
  fCapabilitiesValid := false;
  fSourceSettings.Clear;
  // set fCapabilities items
  with fCapabilities do
  begin
    fXResolution.Clear;
    fYResolution.Clear;
    fXScaling.Clear;
    fYScaling.Clear;
    fPixelType.Clear;
    fBitDepth.Clear;
    fContrast.Clear;
    fBrightness.Clear;
    fGamma := 2.2;
    fPhysicalHeight := 0;
    fPhysicalWidth := 0;
    fThreshold.Clear;
    fRotation.Clear;
{$IFDEF IEINCLUDEMULTIVIEW}
    if fOwner is TImageEnMIO then
    begin
      fFeederEnabled := true;
      fDuplexEnabled := true;
      fAutoFeed := true;
    end
    else
    begin
{$ENDIF}
      fFeederEnabled := false;
      fDuplexEnabled := false;
      fAutoFeed := false;
{$IFDEF IEINCLUDEMULTIVIEW}
    end;
{$ENDIF}
    fAutoDeskew:=false;
    fAutoBorderDetection:=false;
    fAutoBright:=false;
    fAutoRotate:=false;
    fAutoDiscardBlankPages:=-2; // -2 = disable
    fFilter:=ietwUndefined;
    fHighlight:=-1;
    fShadow:=-1;
    fAcquireFrameEnabled := false;
    fOrientation.clear;
    fIndicators := true;
    fillchar(fAcquireFrame, sizeof(TRect), 0);
    fBufferedTransfer := True;
    fUseMemoryHandle := True;
    fFileTransfer := false;
    fUndefinedImageSize := false;
    fStandardSize.clear;
  end;
  // app identification
  fAppVersionInfo := '';
  fAppManufacturer := '';
  fAppProductFamily := '';
  fAppProductName := '';
  //
  LastError := 0;
  LastErrorStr := '';
end;

{!!
<FS>TIETWainParams.Assign

<FM>Declaration<FC>
procedure Assign(Source: <A TIETWainParams>);

<FM>Description<FN>
Applications can Assign TWain parameters between <A TImageEnIO> and <A TImageEnMIO> components.

<FM>Example<FC>

ImageEnView1.IO.TWainParams.Assign( ImageEnView2.IO.TWainParams );

TImageEnMView1.MIO.TWainParams.Assign( ImageEnMView2.MIO.TWainParams );
!!}
procedure TIETWainParams.Assign(Source: TIETWainParams);
var
  q: integer;
  pt: pTW_IDENTITY;
begin
  fVisibleDialog := Source.fVisibleDialog;
  fShowSettingsOnly := Source.fShowSettingsOnly;
  fCompatibilityMode := Source.fCompatibilityMode;
  fLanguage := Source.fLanguage;
  fCountry := Source.fCountry;
  fSelectedSource := Source.fSelectedSource;
  fSourceListDataValid := Source.fSourceListDataValid;
  fSourceSettings.LoadFromStream(Source.fSourceSettings);
  // free fSourceListData items
  for q := 0 to fSourceListData.Count - 1 do
    Freemem(fSourceListData[q]);
  fSourceListData.Clear;
  // copy fSourceListData items
  for q := 0 to Source.fSourceListData.Count - 1 do
  begin
    getmem(pt, sizeof(TW_IDENTITY));
    move(Source.fSourceListData[q]^, pt^, sizeof(TW_IDENTITY));
    fSourceListData.Add(pt);
  end;
  // copy fCapabilities (item by item)
  with fCapabilities do
  begin
    fXResolution.assign(Source.fCapabilities.fXResolution);
    fYResolution.assign(Source.fCapabilities.fYResolution);
    fXScaling.assign(Source.fCapabilities.fXScaling);
    fYScaling.assign(Source.fCapabilities.fYScaling);
    fPixelType.assign(Source.fCapabilities.fPixelType);
    fBitDepth.assign(Source.fCapabilities.fBitDepth);
    fGamma := Source.fCapabilities.fGamma;
    fPhysicalHeight := Source.fCapabilities.fPhysicalHeight;
    fPhysicalWidth := Source.fCapabilities.fPhysicalWidth;
    fFeederEnabled := Source.fCapabilities.fFeederEnabled;
    fAutoFeed := Source.fCapabilities.fAutoFeed;
    fAutoDeskew := Source.fCapabilities.fAutoDeskew;
    fAutoBorderDetection := Source.fCapabilities.fAutoBorderDetection;
    fAutoBright := Source.fCapabilities.fAutoBright;
    fAutoRotate := Source.fCapabilities.fAutoRotate;
    fAutoDiscardBlankPages := Source.fCapabilities.fAutoDiscardBlankPages;
    fFilter := Source.fCapabilities.fFilter;
    fHighlight := Source.fCapabilities.fHighlight;
    fShadow := Source.fCapabilities.fShadow;
    fDuplexEnabled := Source.fCapabilities.fDuplexEnabled;
    fAcquireFrameEnabled := Source.fCapabilities.fAcquireFrameEnabled;
    fOrientation.assign(Source.fCapabilities.fOrientation);
    fIndicators := Source.fCapabilities.fIndicators;
    fAcquireFrame := Source.fCapabilities.fAcquireFrame;
    fBufferedTransfer := Source.fCapabilities.fBufferedTransfer;
    fUseMemoryHandle := Source.fCapabilities.fUseMemoryHandle;
    fFileTransfer := Source.fCapabilities.fFileTransfer;
    fContrast.assign(Source.fCapabilities.fContrast);
    fBrightness.assign(Source.fCapabilities.fBrightness);
    fThreshold.assign(Source.fCapabilities.fThreshold);
    fRotation.Assign(Source.fCapabilities.fRotation);
    fUndefinedImageSize := Source.fCapabilities.fUndefinedImageSize;
    fStandardSize := Source.fCapabilities.fStandardSize;
  end;
  // copy app id
  fAppVersionInfo := Source.fAppVersionInfo;
  fAppManufacturer := Source.fAppManufacturer;
  fAppProductFamily := Source.fAppProductFamily;
  fAppProductName := Source.fAppProductName;
end;

procedure TIETWainParams.FillSourceListData;
var
  q: integer;
begin
  if not fSourceListDataValid then
  begin
    // free fSourceListData items
    for q := 0 to fSourceListData.Count - 1 do
      Freemem(fSourceListData[q]);
    fSourceListData.Clear;
    // get fSourceListData
    IETW_GetSourceList(fSourceListData, @TWainShared, IEFindHandle(fOwner));
    fSourceListDataValid := True;
    // get source capabilities
    //FillCapabilities;	// removed in 1.8 version (works well?)
  end;
end;

{!!
<FS>TIETWainParams.GetFromScanner

<FM>Declaration<FC>
function GetFromScanner:boolean;

<FM>Description<FN>
GetFromScanner fills all properties with scanner parameters. Use this method to update ImageEn parameters with scanner values.

Returns False if cannot connect to the scanner.

<FM>Example<FC>
ImageEnView1.IO.GetFromScanner;
ScannerPixelType := ImageEnView1.IO.TWainParams.PixelType.CurrentValue;

!!}
function TIETWainParams.GetFromScanner: boolean;
begin
  result := IETW_GetCapabilities(self, fCapabilities, false, @TWainShared, IEFindHandle(fOwner));
  fCapabilitiesValid := True;
end;

procedure TIETWainParams.FillCapabilities;
begin
  if not fCapabilitiesValid then
  begin
    IETW_GetCapabilities(self, fCapabilities, false, @TWainShared, IEFindHandle(fOwner));
    fCapabilitiesValid := True;
  end;
end;

{!!
<FS>TIETWainParams.SourceName

<FM>Declaration<FC>
property SourceName[index]: AnsiString;

<FM>Description<FN>
SourceName is the name of the index scanner. This list has <A TIETWainParams.SourceCount> values.

Read-only

<FM>Example<FC>

// Fills the ListBox1 with all scanner names installed on the system
for q:=0 to ImageEnView1.IO.TWainParams.SourceCount-1 do
  ListBox1.Items.Add( ImageEnView1.IO.TWainParams.SourceName[q] );

!!}
function TIETWainParams.GetSourceName(idx: integer): AnsiString;
begin
  FillSourceListData;
  if idx < fSourceListData.Count then
    result := pTW_IDENTITY(fSourceListData[idx])^.ProductName
  else
    result := '';
end;

{!!
<FS>TIETWainParams.SourceCount

<FM>Declaration<FC>
property SourceCount: integer;

<FM>Description<FN>
SourceCount is the count of the installed scanners. It also defines the length of the <A TIETWainParams.SourceName>[] list.

Read-only

<FM>Example<FC>

// Fills the ListBox1 with all scanner names installed on the system
for q:=0 to ImageEnView1.IO.TWainParams.SourceCount-1 do
  ListBox1.Items.Add( ImageEnView1.IO.TWainParams.SourceName[q] );
!!}
function TIETWainParams.GetSourceCount: integer;
begin
  FillSourceListData;
  result := fSourceListData.Count;
end;

{!!
<FS>TIETWainParams.SelectSourceByName

<FM>Declaration<FC>
function SelectSourceByName(const sn: AnsiString): boolean;

<FM>Description<FN>
SelectSourceByName selects the first device that matches left name string with <FC>sn<FN>.
Returns true if device is found.
The list of names is contained in <A TIETWainParams.SourceName>[] list.

<FM>Example<FC>

// Select the second scanner
ImageEnView1.IO.TWainParams.SelectedSource:=1;

// Select scanner by name
ImageEnView1.IO.TWainParams.SelectSourceByName('CanoScan FB620');

// Select scanner with standard dialog
ImageEnView1.IO.SelectAcquireSource;

!!}
function TIETWainParams.SelectSourceByName(const sn: AnsiString): boolean;
var
  q, ll: integer;
begin
  result := false;
  FillSourceListData;
  ll := length(sn);
  for q := 0 to fSourceListData.Count - 1 do
    if IEUpperCase(IECopy(pTW_IDENTITY(fSourceListData[q])^.ProductName, 1, ll)) = IEUpperCase(sn) then
    begin
      if fSelectedSource <> q then
        SetSelectedSource(q);
      result := true;
      break;
    end;
end;

{!!
<FS>TIETWainParams.XResolution

<FM>Declaration<FC>
property XResolution: <A TIEDoubleList>;

<FM>Description<FN>
XResolution is the DPI (Dots per Inch) in the X-axis.

Allowed values can be assigned to XResolution.CurrentValue property. To see which values your scanner supports, look at the XResolution.Items[] array, or XResolution.RangeMin, XResolution.RangeMax and XResolution.RangeStep.

You can also limit scanner user interface allowed values by removing some XResolution.Items[] items or changing XResolution.RangeMin, XResolution.RangeMax and XResolution.RangeStep.

<FM>Example<FC>

// Acquire with 100 DPI (if supported by scanner)
ImageEnView1.IO.YResolution.CurrentValue:=100;
ImageEnView1.IO.XResolution.CurrentValue:=100;
ImageEnView1.IO.VisibleDialog:=False;
ImageEnView1.IO.Acquire;

!!}
function TIETWainParams.GetXResolution: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fXResolution;
end;

{!!
<FS>TIETWainParams.YResolution

<FM>Declaration<FC>
property YResolution: <A TIEDoubleList>;

<FM>Description<FN>
YResolution is the DPI (Dots per Inch) in the Y-axis.

Allowed values can be assigned to YResolution.CurrentValue property. To see which values your scanner supports, look at YResolution.Items[] array, or YResolution.RangeMin, YResolution.RangeMax and YResolution.RangeStep.

You can also limit scanner user interface allowed values by removing some YResolution.Items[] items or by changing YResolution.RangeMin, YResolution.RangeMax or YResolution.RangeStep.

<FM>Example<FC>

// Acquire with 100 DPI (if supported by scanner)
ImageEnView1.IO.YResolution.CurrentValue:=100;
ImageEnView1.IO.XResolution.CurrentValue:=100;
ImageEnView1.IO.VisibleDialog:=False;
ImageEnView1.IO.Acquire;

!!}
function TIETWainParams.GetYResolution: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fYResolution;
end;

{!!
<FS>TIETWainParams.XScaling


<FM>Declaration<FC>
property XScaling: <A TIEDoubleList>;

<FM>Description<FN>
XScaling  is the X-axis scaling value. A value of 1.0 is equivalent to 100% scaling.

Allowed values can be assigned to XScaling.CurrentValue property. To see which values your scanner supports, look at XScaling.Items[] array, or XScaling.RangeMin, XScaling.RangeMax and XScaling.RangeStep.

You can also limit scanner user interface allowed values by removing some XResolution.Items[] items or by changing XResolution.RangeMin, XResolution.RangeMax and XResolution.RangeStep.

!!}
function TIETWainParams.GetXScaling: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fXScaling;
end;

{!!
<FS>TIETWainParams.YScaling

<FM>Declaration<FC>
property YScaling: <A TIEDoubleList>;

<FM>Description<FN>
YScaling is the Y-axis scaling value. A value of 1.0 is equivalent to 100% scaling.

Allowed values can be assigned to the YScaling.CurrentValue property. To see which values your scanner supports, look at  the YScaling.Items[] array, or YScaling.RangeMin, YScaling.RangeMax and YScaling.RangeStep.

You can also limit scanner user interface allowed values by removing some YScaling.Items[] items or by changing YResolution.RangeMin, YResolution.RangeMax and YResolution.RangeStep.
!!}
function TIETWainParams.GetYScaling: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fYScaling;
end;

{!!
<FS>TIETWainParams.Contrast

<FM>Declaration<FC>
property Contrast: <A TIEDoubleList>;

<FM>Description<FN>
Contrast value. Allowed range is -1000 to +1000.

Allowed values can be assigned to Contrast.CurrentValue property. To see which values your scanner supports look at the Contrast.Items[] array, or Contrast.RangeMin, Contrast.RangeMax and Contrast.RangeStep.
You can also limit scanner user interface allowed values by removing some Contrast.Items[] items or changing Contrast.RangeMin, Contrast.RangeMax or Contrast.RangeStep.

!!}
function TIETWainParams.GetContrast: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fContrast;
end;

{!!
<FS>TIETWainParams.Threshold

<FM>Declaration<FC>
property Threshold: <A TIEDoubleList>;

<FM>Description<FN>
Threshold specifies the dividing line between black and white. Allowed values: 0..255.

!!}
function TIETWainParams.GetThreshold: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fThreshold;
end;

{!!
<FS>TIETWainParams.Rotation

<FM>Declaration<FC>
property Rotation:<A TIEDoubleList>;

<FM>Description<FN>
Specifies how much the Source can/should rotate the scanned image data prior to transfer. Allowed values are in the range: -360..+360 degrees.

!!}
function TIETWainParams.GetRotation: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fRotation;
end;

{!!
<FS>TIETWainParams.Brightness

<FM>Declaration<FC>
property Brightness: <A TIEDoubleList>;

<FM>Description<FN>
Brightness value. Allowed range is -1000 to +1000.

Allowed values can be assigned to Brightness.CurrentValue property. To see which values your scanner supports look at Brightness.Items[] array, or Brightness.RangeMin, Brightness.RangeMax and Brightness.RangeStep.
You can also limit scanner user interface allowed values removing some Brightness.Items[] items or changing Brightness.RangeMin, Brightness.RangeMax and Brightness.RangeStep.
!!}
function TIETWainParams.GetBrightness: TIEDoubleList;
begin
  FillCapabilities;
  result := fCapabilities.fBrightness;
end;

{!!
<FS>TIETWainParams.PixelType

<FM>Declaration<FC>
property PixelType: <A TIEIntegerList>;

<FM>Description<FN>
PixelType is the type of pixel data that a scanner is capable of acquiring.
Valid values are:

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>0<FN></C> <C>Black & white (1 bit)</C> </R>
<R> <C><FC>1<FN></C> <C>Gray scale (8 bit)</C> </R>
<R> <C><FC>2<FN></C> <C>Full RGB (24 bit)</C> </R>
<R> <C><FC>3<FN></C> <C>Palette (ImageEn can't support this)</C> </R>
<R> <C><FC>4<FN></C> <C>CMY (ImageEn can't support this)</C> </R>
<R> <C><FC>5<FN></C> <C>CMYK (ImageEn can't support this)</C> </R>
<R> <C><FC>6<FN></C> <C>YUV (ImageEn can't support this)</C> </R>
<R> <C><FC>7<FN></C> <C>YUVK (ImageEn can't support this)</C> </R>
<R> <C><FC>8<FN></C> <C>CIEXYZ (ImageEn can't support this)</C> </R>
</TABLE>

Above values can be assigned to PixelType.<A TIEIntegerList.CurrentValue> property. To see which values your scanner supports, look at PixelType.<A TIEIntegerList.Items>[] array.
You can also limit scanner user interface allowed values by removing some PixelTtype.Items[] items.

<FM>Example<FC>

// Acquires a black/white (1bit) image
ImageEnView1.IO.TWainParams.PixelType.CurrentValue:=0;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;

// Acquires a gray scale (8bit) image
ImageEnView1.IO.TWainParams.PixelType.CurrentValue:=1;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;

// Acquires a full RGB (24bit) image
ImageEnView1.IO.TWainParams.PixelType.CurrentValue:=2;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;

// Show standard scanner user interface, but allow only black/white image acquisition
ImageEnView1.IO.TWainParams.PixelType.Clear;
ImageEnView1.IO.TWainParams.PixelType.Add(0);
ImageEnView1.IO.Acquire;
!!}
function TIETWainParams.GetPixelType: TIEIntegerList;
begin
  FillCapabilities;
  result := fCapabilities.fPixelType;
end;

{!!
<FS>TIETWainParams.BitDepth

<FM>Declaration<FC>
property BitDepth:<A TIEIntegerList>;

<FM>Description<FN>
Specifies the bit depth (bits per channel) of the image to scan.

<FM>Example<FC>

// acquire 48 bit (RGB, 16 bit per pixel) native pixels
ImageEnView1.LegacyBitmap:=false;
ImageEnView1.IO.NativePixelFormat:=true;
ImageEnView1.IO.TwainParams.BitDepth.CurrentValue:=16;
ImageEnView1.IO.Acquire;

!!}
function TIETWainParams.GetBitDepth: TIEIntegerList;
begin
  FillCapabilities;
  result := fCapabilities.fBitDepth;
end;

{!!
<FS>TIETWainParams.Gamma

<FM>Declaration<FC>
property Gamma: double;

<FM>Description<FN>
Gamma is the gamma value of your scanner.

Read-only
!!}
function TIETWainParams.GetGamma: double;
begin
  FillCapabilities;
  result := fCapabilities.fGamma;
end;

{!!
<FS>TIETWainParams.FeederLoaded

<FM>Declaration<FC>
property FeederLoaded: boolean;

<FM>Description<FN>
Use the FeederLoaded property to reflect whether or not there are documents loaded in the Source's feeder.

<FM>Example<FC>

// use of TImageEnIO (instead of TImageEnMIO) to acquire and save multi pages
while ImageEnView1.IO.TWainParams.FeederLoaded do
begin
  ImageEnView1.IO.Acquire;
  ImageEnView1.IO.SaveToFile('page'+inttostr(count)+'.jpg');
  Inc( count );
end;

!!}
function TIETWainParams.GetFeederLoaded: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fFeederLoaded;
end;

{!!
<FS>TIETWainParams.PaperDetectable

<FM>Declaration<FC>
property PaperDetectable: boolean;

<FM>Description<FN>
If PaperDetectable is True, the scanner is able to detect paper.
!!}
function TIETWainParams.GetPaperDetectable: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fPaperDetectable;
end;

{!!
<FS>TIETWainParams.DuplexSupported

<FM>Declaration<FC>
property DuplexSupported: boolean;

<FM>Description<FN>
If DuplexSupported is True, the scanner can scans both sides of a paper; otherwise the scanner will scan only one side.

<FM>Example<FC>

// enables duplex if supported
If ImageEnMView1.MIO.TwainParams.DuplexSupported then
  ImageEnView1.IO.TwainParams.DuplexEnabled:=True;

!!}
function TIETWainParams.GetDuplexSupported: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fDuplexSupported;
end;

{!!
<FS>TIETWainParams.PhysicalHeight

<FM>Declaration<FC>
property PhysicalHeight: double;

<FM>Description<FN>
PhysicalHeight is the maximum physical height (Y-axis) the scanner can acquire (measured in inches).

Read-only
!!}
function TIETWainParams.GetPhysicalHeight: double;
begin
  FillCapabilities;
  result := fCapabilities.fPhysicalHeight;
end;

{!!
<FS>TIETWainParams.PhysicalWidth

<FM>Declaration<FC>
property PhysicalWidth: double;

<FM>Description<FN>
PhysicalWidth is the maximum physical width (X-axis) the scanner can acquire (measured in inches).

Read-only

!!}
function TIETWainParams.GetPhysicalWidth: double;
begin
  FillCapabilities;
  result := fCapabilities.fPhysicalWidth;
end;

{!!
<FS>TIETWainParams.FeederEnabled

<FM>Declaration<FC>
property FeederEnabled: boolean;

<FM>Description<FN>
FeederEnabled enables the feed loader mechanism when present.
Use this property only within <A TImageEnMIO> component to disable the feed loader.

<FM>Example<FC>

// Acquires only one feed
ImageEnMView1.MIO.TWainParams.FeederEnabled:=False;
ImageEnMView1.MIO.Acquire;
!!}
function TIETWainParams.GetFeederEnabled: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fFeederEnabled;
end;

{!!
<FS>TIETWainParams.AutoFeed

<FM>Declaration<FC>
property AutoFeed:boolean;

<FM>Description<FN>
If AutoFeed is true, the scanner will automatically feed the next page from the document feeder.
!!}
function TIETWainParams.GetAutoFeed: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fAutoFeed;
end;

{!!
<FS>TIETWainParams.AutoDeskew

<FM>Declaration<FC>
property AutoDeskew: boolean;

<FM>Description<FN>
Turns automatic deskew correction on and off.

!!}
function TIETWainParams.GetAutoDeskew: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fAutoDeskew;
end;

{!!
<FS>TIETWainParams.AutoBorderDetection

<FM>Declaration<FC>
property AutoBorderDetection: boolean;

<FM>Description<FN>
Turns automatic border detection on and off.
!!}
function TIETWainParams.GetAutoBorderDetection: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fAutoBorderDetection;
end;

{!!
<FS>TIETWainParams.AutoBright

<FM>Declaration<FC>
property AutoBright: boolean;

<FM>Description<FN>
TRUE enables and FALSE disables the Source's Auto-brightness function (if any).

!!}
function TIETWainParams.GetAutoBright: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fAutoBright;
end;

{!!
<FS>TIETWainParams.AutoRotate

<FM>Declaration<FC>
property AutoRotate: boolean;

<FM>Description<FN>
When <FC>true<FN> this capability depends on intelligent features within the Source to automatically rotate the image to the correct position.
!!}
function TIETWainParams.GetAutoRotate: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fAutoRotate;
end;

{!!
<FS>TIETWainParams.AutoDiscardBlankPages

<FM>Declaration<FC>
property AutoDiscardBlankPages: integer;

<FM>Description<FN>
Use this capability to have the scanner discard blank images.
Applications never see these images during the scanning session.
Allowed values:

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>-2<FN></C> <C>Indicates that all images will be delivered to the application, none of them will be discarded</C> </R>
<R> <C><FC>-1<FN></C> <C>Scanner source will decide if an image is blank or not and discard as appropriate</C> </R>
<R> <C><FC>>=0<FN></C>
<C>Scanner will use it as the byte size cutoff point to identify which images are to be discarded.
If the size of the image is less than or equal to this value, then it will be discarded.
If the size of the image is greater than this value, then it will be kept so that it can be transferred to the Application.</C></R>
</TABLE>
!!}
function TIETWainParams.GetAutoDiscardBlankPages: integer;
begin
  FillCapabilities;
  result := fCapabilities.fAutoDiscardBlankPages;
end;


{!!
<FS>TIETWainParams.Filter

<FM>Declaration<FC>
property Filter: <A TIETWFilter>;

<FM>Description<FN>
Describes the color characteristic of the subtractive filter applied to the image data.
ietwUndefined (default) unsets this property, while ietwNone set "none" value.
!!}
function TIETWainParams.GetFilter: TIETWFilter;
begin
  FillCapabilities;
  result := fCapabilities.fFilter;
end;

{!!
<FS>TIETWainParams.Highlight

<FM>Declaration<FC>
property Highlight: double;

<FM>Description<FN>
Specifies which value in an image should be interpreted as the lightest "highlight". All values "lighter" than this value will be clipped to this value.
-1 is the default scanner value (it means "do not change current value").
Allowed values from 0 to 255.
!!}
function TIETWainParams.GetHighlight: double;
begin
  FillCapabilities;
  result := fCapabilities.fHighlight;
end;

{!!
<FS>TIETWainParams.Shadow

<FM>Declaration<FC>
property Shadow: double;

<FM>Description<FN>
Specifies which value in an image should be interpreted as the darkest "shadow". All values "darker" than this value will be clipped to this value.
-1 is the default scanner value (it means "do not change current value").
Allowed values from 0 to 255.
!!}
function TIETWainParams.GetShadow: double;
begin
  FillCapabilities;
  result := fCapabilities.fShadow;
end;

{!!
<FS>TIETWainParams.UndefinedImageSize

<FM>Declaration<FC>
property UndefinedImageSize: boolean;

<FM>Description<FN>
UndefinedImageSize enables support for an undefined image size scanner. Default is False.
!!}
function TIETWainParams.GetUndefinedImageSize: boolean;
begin
  // no need FillCapabilities
  result := fCapabilities.fUndefinedImageSize;
end;

{!!
<FS>TIETWainParams.DuplexEnabled

<FM>Declaration<FC>
property DuplexEnabled: boolean;

<FM>Description<FN>
If DuplexEnabled is True, the scanner scans both sides of a paper; otherwise (default), the scanner will scan only one side.
Use this property only within <A TImageEnMIO> component to enable/disable duplex mode.
!!}
function TIETWainParams.GetDuplexEnabled: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fDuplexEnabled;
end;

{!!
<FS>TIETWainParams.AcquireFrameEnabled

<FM>Declaration<FC>
property AcquireFrameEnabled: boolean;

<FM>Description<FN>
If AcquireFrameEnabled is True, it enables the properties <A TIETWainParams.AcquireFrameLeft>, <A TIETWainParams.AcquireFrameRight>, <A TIETWainParams.AcquireFrameTop> and <A TIETWainParams.AcquireFrameBottom>.

When True, some scanners don't allow the user to change the acquisition frame.
Default is False.

!!}
function TIETWainParams.GetAcquireFrameEnabled: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fAcquireFrameEnabled;
end;

{!!
<FS>TIETWainParams.Orientation

<FM>Declaration<FC>
property Orientation: <A TIEIntegerList>;

<FM>Description<FN>
Orientation defines the orientation of the output image. Not all scanners support this capability.
Vaid values are:

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>0<FN></C> <C>No rotation (Portrait)</C> </R>
<R> <C><FC>1<FN></C> <C>Rotate 90°</C> </R>
<R> <C><FC>2<FN></C> <C>Rotate 180°</C> </R>
<R> <C><FC>3<FN></C> <C>Rotate 270° (Landscape)</C> </R>
</TABLE>

The above values can be assigned to the Orientation.<A TIEIntegerList.CurrentValue> property.
To know which values your scanner supports, look at Orientation.<A TIEIntegerList.Items>[] array.

<FM>Example<FC>

// Acquire image in landscape orientation (if supported)
ImageEnView1.IO.TWainParams.Orientation.CurrentValue:=3;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;

// As above, but control if landscape is supported
if ImageEnView1.IO.TWainParams.Orientation.IndexOf(3)=3 then
begin
  ImageEnView1.IO.TWainParams.Orientation.CurrentValue:=3;
  ImageEnView1.IO.TWainParams.VisibleDialog:=False;
  ImageEnView1.IO.Acquire;
end
else
  ShowMessage('landscape isn't supported');

!!}
function TIETWainParams.GetOrientation: TIEIntegerList;
begin
  FillCapabilities;
  result := fCapabilities.fOrientation;
end;

{!!
<FS>TIETWainParams.StandardSize

<FM>Declaration<FC>
property StandardSize: <A TIEIntegerList>;

<FM>Description<FN>
StandardSize page size for devices that support fixed frame sizes.
Defined sizes match typical page sizes. This specifies the size(s) the Source can/should use to acquire image data.
Allowed values:

   IETW_NONE
   IETW_A4LETTER
   IETW_B5LETTER
   IETW_USLETTER
   IETW_USLEGAL
   IETW_A5
   IETW_B4
   IETW_B6
   IETW_USLEDGER
   IETW_USEXECUTIVE
   IETW_A3
   IETW_B3
   IETW_A6
   IETW_C4
   IETW_C5
   IETW_C6
   IETW_4A0
   IETW_2A0
   IETW_A0
   IETW_A1
   IETW_A2
   IETW_A4
   IETW_A7
   IETW_A8
   IETW_A9
   IETW_A10
   IETW_ISOB0
   IETW_ISOB1
   IETW_ISOB2
   IETW_ISOB3
   IETW_ISOB4
   IETW_ISOB5
   IETW_ISOB6
   IETW_ISOB7
   IETW_ISOB8
   IETW_ISOB9
   IETW_ISOB10
   IETW_JISB0
   IETW_JISB1
   IETW_JISB2
   IETW_JISB3
   IETW_JISB4
   IETW_JISB5
   IETW_JISB6
   IETW_JISB7
   IETW_JISB8
   IETW_JISB9
   IETW_JISB10
   IETW_C0
   IETW_C1
   IETW_C2
   IETW_C3
   IETW_C7
   IETW_C8
   IETW_C9
   IETW_C10
   IETW_USSTATEMENT
   IETW_BUSINESSCARD

<FM>Example<FC>
ImageEnView1.IO.TwainParams.StandardSize.CurrentValue:= IETW_A4LETTER

!!}
function TIETWainParams.GetStandardSize: TIEIntegerList;
begin
  FillCapabilities;
  result := fCapabilities.fStandardSize;
end;

function TIETWainParams.GetIndicators: boolean;
begin
  FillCapabilities;
  result := fCapabilities.fIndicators;
end;

procedure TIETWainParams.SetFeederEnabled(v: boolean);
begin
  fCapabilities.fFeederEnabled := v;
end;

procedure TIETWainParams.SetAutoFeed(v: boolean);
begin
  fCapabilities.fAutoFeed := v;
end;

procedure TIETWainParams.SetAutoDeskew(v: boolean);
begin
  fCapabilities.fAutoDeskew := v;
end;

procedure TIETWainParams.SetAutoBorderDetection(v: boolean);
begin
  fCapabilities.fAutoBorderDetection := v;
end;

procedure TIETWainParams.SetAutoBright(v: boolean);
begin
  fCapabilities.fAutoBright := v;
end;

procedure TIETWainParams.SetAutoRotate(v: boolean);
begin
  fCapabilities.fAutoRotate := v;
end;

procedure TIETWainParams.SetAutoDiscardBlankPages(v: integer);
begin
  fCapabilities.fAutoDiscardBlankPages := v;
end;

procedure TIETWainParams.SetFilter(v: TIETWFilter);
begin
  fCapabilities.fFilter := v;
end;

procedure TIETWainParams.SetHighlight(v: double);
begin
  fCapabilities.fHighlight := v;
end;

procedure TIETWainParams.SetShadow(v: double);
begin
  fCapabilities.fShadow := v;
end;

procedure TIETWainParams.SetUndefinedImageSize(v: boolean);
begin
  fCapabilities.fUndefinedImageSize := v;
end;

procedure TIETWainParams.SetDuplexEnabled(v: boolean);
begin
  fCapabilities.fDuplexEnabled := v;
end;

procedure TIETWainParams.SetAcquireFrameEnabled(v: boolean);
begin
  fCapabilities.fAcquireFrameEnabled := v;
end;

{!!
<FS>TIETWainParams.ProgressIndicators

<FM>Declaration<FC>
property ProgressIndicators: boolean;

<FM>Description<FN>
If ProgressIndicators is True (default), the scanner will display a progress indicator during acquisition and transfer, regardless of whether the scanner user interface is active.
You can use <A TImageEnIO.OnProgress> event to display your custom progress indicator.
!!}
procedure TIETWainParams.SetIndicators(v: boolean);
begin
  fCapabilities.fIndicators := v;
end;

function TIETWainParams.GetAcquireFrame(idx: integer): double;
begin
  FillCapabilities;
  case idx of
    0: result := fCapabilities.fAcquireFrame.Left;
    1: result := fCapabilities.fAcquireFrame.Top;
    2: result := fCapabilities.fAcquireFrame.Right;
    3: result := fCapabilities.fAcquireFrame.Bottom;
  else
    result := 0;
  end;
end;

{!!
<FS>TIETWainParams.AcquireFrameLeft

<FM>Declaration<FC>
property AcquireFrameLeft: double;

<FM>Description<FN>
AcquireFrameLeft is the left of the rectangle to acquire measured in inches.

<FM>See also<FN>
<A TIETWainParams.AcquireFrameTop>
<A TIETWainParams.AcquireFrameRight>
<A TIETWainParams.AcquireFrameBottom>

<FM>Example<FC>

// Acquires the 2,2,7,7 rectangle without display scanner dialog
ImageEnView1.IO.TWainParams.AcquireFrameTop:=2;
ImageEnView1.IO.TWainParams.AcquireFrameLeft:=2;
ImageEnView1.IO.TWainParams.AcquireFrameRight:=7;
ImageEnView1.IO.TWainParams.AcquireFrameBottom:=7;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;
!!}
{!!
<FS>TIETWainParams.AcquireFrameBottom

<FM>Declaration<FC>
property AcquireFrameBottom: double;

<FM>Description<FN>
AcquireFrameBottom is the bottom of the rectangle to acquire measured in inches.

<FM>See also<FN>
<A TIETWainParams.AcquireFrameLeft>
<A TIETWainParams.AcquireFrameTop>
<A TIETWainParams.AcquireFrameRight>

<FM>Example<FC>

// Acquires the 2,2,7,7 rectangle without display scanner dialog
ImageEnView1.IO.TWainParams.AcquireFrameTop:=2;
ImageEnView1.IO.TWainParams.AcquireFrameLeft:=2;
ImageEnView1.IO.TWainParams.AcquireFrameRight:=7;
ImageEnView1.IO.TWainParams.AcquireFrameBottom:=7;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire
!!}
{!!
<FS>TIETWainParams.AcquireFrameRight

<FM>Declaration<FC>
property AcquireFrameRight: double;

<FM>Description<FN>
AcquireFrameRight is the right side of the rectangle to acquire measured in inches.

<FM>See also<FN>
<A TIETWainParams.AcquireFrameLeft>
<A TIETWainParams.AcquireFrameTop>
<A TIETWainParams.AcquireFrameBottom>

<FM>Example<FC>

// Acquires the 2,2,7,7 rectangle without display scanner dialog
ImageEnView1.IO.TWainParams.AcquireFrameTop:=2;
ImageEnView1.IO.TWainParams.AcquireFrameLeft:=2;
ImageEnView1.IO.TWainParams.AcquireFrameRight:=7;
ImageEnView1.IO.TWainParams.AcquireFrameBottom:=7;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;
!!}
{!!
<FS>TIETWainParams.AcquireFrameTop

<FM>Declaration<FC>
property AcquireFrameTop: double;

<FM>Description<FN>
AcquireFrameTop is the top of the rectangle to acquire measured in inches.

<FM>See also<FN>
<A TIETWainParams.AcquireFrameLeft>
<A TIETWainParams.AcquireFrameRight>
<A TIETWainParams.AcquireFrameBottom>

<FM>Example<FC>

// Acquires the 2,2,7,7 rectangle without display scanner dialog
ImageEnView1.IO.TWainParams.AcquireFrameTop:=2;
ImageEnView1.IO.TWainParams.AcquireFrameLeft:=2;
ImageEnView1.IO.TWainParams.AcquireFrameRight:=7;
ImageEnView1.IO.TWainParams.AcquireFrameBottom:=7;
ImageEnView1.IO.TWainParams.VisibleDialog:=False;
ImageEnView1.IO.Acquire;
!!}
procedure TIETWainParams.SetAcquireFrame(idx: integer; v: double);
begin
  case idx of
    0: fCapabilities.fAcquireFrame.Left := v;
    1: fCapabilities.fAcquireFrame.Top := v;
    2: fCapabilities.fAcquireFrame.Right := v;
    3: fCapabilities.fAcquireFrame.Bottom := v;
  end;
end;

{!!
<FS>TIETWainParams.BufferedTransfer

<FM>Declaration<FC>
property BufferedTransfer: boolean;

<FM>Description<FN>
Set the BufferedTransfer property to False if you have problems acquiring an image.
You never use this property under normal circumstances.
!!}
function TIETWainParams.GetBufferedTransfer: boolean;
begin
  result := fCapabilities.fBufferedTransfer;
end;

procedure TIETWainParams.SetBufferedTransfer(v: boolean);
begin
  fCapabilities.fBufferedTransfer := v;
end;

{!!
<FS>TIETWainParams.UseMemoryHandle

<FM>Declaration<FC>
property UseMemoryHandle: boolean;

<FM>Description<FN>
Some scanner's drivers do not support memory handles, so we have to pass memory pointers in order to transfer images.
You should try to set this property to False if you have problems scanning documents or images.
!!}
function TIETWainParams.GetUseMemoryHandle: boolean;
begin
  result := fCapabilities.fUseMemoryHandle;
end;

procedure TIETWainParams.SetUseMemoryHandle(v: boolean);
begin
  fCapabilities.fUseMemoryHandle := v;
end;

{!!
<FS>TIETWainParams.FileTransfer

<FM>Declaration<FC>
property FileTransfer: boolean;

<FM>Description<FN>
If FileTransfer true, uses a file transfer to get images from the scanner (regardness of <A TIETWainParams.BufferedTransfer> setting).
There are three ways to get an image from scanner:
1 - native transfer ( set FileTransfer=False and BufferedTransfer=False )
2 - buffered transfer ( set FileTransfer=False and BufferedTransfer=True )
3 - file transfer ( set FileTransfer=True )

FileTransfer is slow but more compatible.

!!}
function TIETWainParams.GetFileTransfer: boolean;
begin
  result := fCapabilities.fFileTransfer;
end;

procedure TIETWainParams.SetFileTransfer(v: boolean);
begin
  fCapabilities.fFileTransfer := v;
end;

{!!
<FS>TIETWainParams.SelectedSource

<FM>Declaration<FC>
property SelectedSource: integer;

<FM>Description<FN>
SelectedSource is an index of SourceName[] list, and defines the currently selected scanner (source).

The default is 0 (first scanner).
This is an alternative method to select a scanner without calling the <A TImageEnIO.SelectAcquireSource> method.

<FM>Example<FC>

// Select the second scanner
ImageEnView1.IO.TWainParams.SelectedSource:=1;

// Select scanner by name
ImageEnView1.IO.TWainParams.SelectSourceByName('CanoScan FB620');

// Select scanner with standard dialog
ImageEnView1.IO.SelectAcquireSource;
!!}
procedure TIETWainParams.SetSelectedSource(v: integer);
begin
  if v <> fSelectedSource then
  begin
    fSelectedSource := v;
    fCapabilitiesValid := false;
    FillCapabilities;
  end;
end;

{!!
<FS>TIETWainParams.Update

<FM>Declaration<FC>
procedure Update;

<FM>Description<FN>
The Update method determines if current parameters are valid.

For example, if the application assigns a combination of <A TIETWainParams.PixelType> and <A TIETWainParams.YResolution> unsupported by scanner, the Update method restores the PixelType and YResolution value to a value supported by the scanner.

<FM>Example<FC>

// Try if RGB and YResolution combination is supported
ImageEnView1.IO.TWainParams.PixelType.CurrentValue:=2;
ImageEnView1.IO.TWainParams.YResolution.CurrentValue:=300;
ImageEnView1.IO.TWainParams.Update;
if (ImageEnView1.IO.TWainParams.PixelType.CurrentValue<>2) or (ImageEnView1.IO.TWainParams.YResolution.CurrentValue<>300) then
  ShowMessage('error!');
!!}
procedure TIETWainParams.Update;
begin
  IETW_GetCapabilities(self, fCapabilities, true, @TWainShared, IEFindHandle(fOwner));
  fCapabilitiesValid := True;
end;

{!!
<FS>TIETWainParams.AppVersionInfo

<FM>Declaration<FC>
property AppVersionInfo:AnsiString;

<FM>Description<FN>
These properties specify the application information communicated to the Twain scanner interface.

!!}
procedure TIETWainParams.SetAppVersionInfo(v: AnsiString);
begin
  fAppVersionInfo := IECopy(v, 1, 32);
end;

{!!
<FS>TIETWainParams.AppManufacturer

<FM>Declaration<FC>
property AppManufacturer:AnsiString;

<FM>Description<FN>
These properties specify the application information communicated to the Twain scanner interface.
!!}
procedure TIETWainParams.SetAppManufacturer(v: AnsiString);
begin
  fAppManufacturer := IECopy(v, 1, 32);
end;

{!!
<FS>TIETWainParams.AppProductfamily

<FM>Declaration<FC>
property AppProductfamily:AnsiString;

<FM>Description<FN>
These properties specify the application information communicated to the Twain scanner interface.
!!}
procedure TIETWainParams.SetAppProductFamily(v: AnsiString);
begin
  fAppProductFamily := IECopy(v, 1, 32);
end;

{!!
<FS>TIETWainParams.AppProductName

<FM>Declaration<FC>
property AppProductName:AnsiString;

<FM>Description<FN>
These properties specify the application information communicated to the Twain scanner interface.
!!}
procedure TIETWainParams.SetAppProductName(v: AnsiString);
begin
  fAppProductName := IECopy(v, 1, 32);
end;

procedure TIETWainParams.SetLogFile(v: string);
begin
  if iegTWainLogName <> '' then
    CloseFile(iegTWainLogFile);
  iegTWainLogName := v;
  if v <> '' then
  begin
    AssignFile(iegTWainLogFile, iegTWainLogName);
    Rewrite(iegTwainLogFile);
    WriteLn(iegTwainLogFile, 'TWain log. Core version '+IEMAINVERSION+' '+IntToStr(IEMAINDATEDD)+' '+IntToStr(IEMAINDATEMM)+' '+IntToStr(IEMAINDATEYY));
  end;
end;

{!!
<FS>TIETWainParams.LogFile

<FM>Declaration<FC>
property LogFile:string;

<FM>Description<FN>
LogFile specifies the file name that will contain the log of the communication between ImageEn and the scanner driver.
Set this property before use scanner related methods or properties.

<FM>Example<FC>
ImageEnView.IO.TwainParams.LogFile:='c:\twainlog.txt';

!!}
function TIETWainParams.GetLogFile: string;
begin
  result := iegTWainLogName;
end;

{$ENDIF} // {$ifdef IEINCLUDETWAIN}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Registered File formats support
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>IEFileFormatGetInfo

<FM>Declaration<FC>
function IEFileFormatGetInfo(FileType: <A TIOFileType>): <A TIEFileFormatInfo>;

<FM>Description<FN>
Returns a TIEFileFormatInfo object which contains info about the specified file format.
!!}
// ret nil if FileType doesn't exists
function IEFileFormatGetInfo(FileType: TIOFileType): TIEFileFormatInfo;
var
  q: integer;
begin
  for q := 0 to iegFileFormats.Count - 1 do
  begin
    result := TIEFileFormatInfo(iegFileFormats[q]);
    if result.FileType = FileType then
      exit;
  end;
  result := nil;
end;

// ret extension count
function IEFileFormatGetExtCount(FileType: TIOFileType): integer;
begin
  result := 0;
  while IEFileFormatGetExt(FileType, result) <> '' do
    inc(result);
end;

// ret extension
// example: for Extensions='jpg;jpeg' idx=1 is 'jpeg'
function IEFileFormatGetExt(FileType: TIOFileType; idx: integer): string;
var
  fi: TIEFileFormatInfo;
  ss: string;
  //
  function ExtractNext: string;
  var
    q: integer;
  begin
    q := Pos(';', ss);
    if q = 0 then
    begin
      result := ss;
      ss := '';
    end
    else
    begin
      result := Copy(ss, 1, q - 1);
      ss := Copy(ss, q + 1, length(ss) - q);
    end;
  end;
  //
var
  i: integer;
begin
  fi := IEFileFormatGetInfo(FileType);
  if assigned(fi) then
  begin
    ss := fi.Extensions;
    i := 0;
    while length(ss) > 0 do
    begin
      result := ExtractNext;
      if i = idx then
        exit;
      inc(i);
    end;
  end;
  result := '';
end;

{!!
<FS>IEFileFormatGetInfo2

<FM>Declaration<FC>
function IEFileFormatGetInfo2(Extension: string): <A TIEFileFormatInfo>;

<FM>Description<FN>
Returns a TIEFileFormatInfo object which contains info about the specified file format.
The format is specified on its extension (example '.gif' or 'gif').
!!}
// ret nil if Extension doesn't exists (accept '.xxx' or 'xxx')
function IEFileFormatGetInfo2(Extension: string): TIEFileFormatInfo;
var
  q, i, c: integer;
begin
  Extension := LowerCase(Extension);
  if (Length(Extension) > 0) and (Extension[1] = '.') then
    Delete(Extension, 1, 1);

  for q := 0 to iegFileFormats.Count - 1 do
  begin
    result := TIEFileFormatInfo(iegFileFormats[q]);
    c := IEFileFormatGetExtCount(result.FileType);
    for i := 0 to c - 1 do
      if LowerCase(IEFileFormatGetExt(result.FileType, i)) = Extension then
        exit;
  end;
  result := nil;
end;


{!!
<FS>IEFileFormatAdd

<FM>Declaration<FC>
procedure IEFileFormatAdd(FileFormatInfo: <A TIEFileFormatInfo>);

<FM>Description<FN>
Adds a new file format. The object <FC>FileFormatInfo<FN> specifies file format info and read/write functions.
You haven't to free <FC>FileFormatInfo<FN> object.

<FM>Example<FC>
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
!!}
procedure IEFileFormatAdd(FileFormatInfo: TIEFileFormatInfo);
begin
  iegFileFormats.Add(FileFormatInfo);
end;

{!!
<FS>IEFileFormatRemove

<FM>Declaration<FC>
procedure IEFileFormatRemove(FileType: <A TIOFileType>);

<FM>Description<FN>
Removes a file format added using <A IEFileFormatAdd>.
!!}
procedure IEFileFormatRemove(FileType: TIOFileType);
var
  r: TIEFileFormatInfo;
begin
  r := IEFileFormatGetInfo(FileType);
  if assigned(r) then
  begin
    iegFileFormats.Remove(r);
    r.Free;
  end;
end;

procedure DumpReadImageStream(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec; Preview: boolean);
begin
end;

procedure DumpWriteImageStream(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec);
begin
end;

function DumpTryImageStream(Stream: TStream; TryingFormat:TIOFileType): boolean;
begin
  result := false;
end;

// Alloc iegFileFormats global variable and embedded file formats
procedure IEInitFileFormats;
var
  fi: TIEFileFormatInfo;
  L3118: TImageEnIO;
begin
  // this allows the linker to include all obj files avoiding Delphi "Internal Error L3118"
  L3118 := TImageEnIO.Create(nil);
  FreeAndNil(L3118);

  iegFileFormats := TList.Create;

  // TIFF
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioTIFF;
    FullName := 'TIFF Bitmap';
    Extensions := 'TIF;TIFF;FAX;G3N;G3F;XIF';
    DialogPage := [ppTIFF];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // GIF
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioGIF;
    FullName := 'CompuServe Bitmap';
    Extensions := 'GIF';
    DialogPage := [ppGIF];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // JPEG
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioJPEG;
    FullName := 'JPEG Bitmap';
    Extensions := 'JPG;JPEG;JPE;JIF';
    DialogPage := [ppJPEG];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // PCX
  with fi do
  begin
    fi := TIEFileFormatInfo.Create;
    FileType := ioPCX;
    FullName := 'PaintBrush';
    Extensions := 'PCX';
    DialogPage := [ppPCX];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // BMP
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioBMP;
    FullName := 'Windows Bitmap';
    Extensions := 'BMP;DIB;RLE';
    DialogPage := [ppBMP];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // BMPRAW
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioBMPRAW;
    FullName := 'Raw Bitmap';
    Extensions := ''; // in this way this format will not be included in open/save dialog
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // ICO
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioICO;
    FullName := 'Windows Icon';
    Extensions := 'ICO';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // CUR
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioCUR;
    FullName := 'Windows Cursor';
    Extensions := 'CUR';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := nil; // cannot write
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;


  {$IFDEF IEINCLUDEPNG}
  // PNG
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioPNG;
    FullName := 'Portable Network Graphics';
    Extensions := 'PNG';
    DialogPage := [ppPNG];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;
  {$ENDIF}

  {$ifdef IEINCLUDEDICOM}
  // DICOM
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioDICOM;
    FullName := 'DICOM Bitmap';
    Extensions := 'DCM;DIC;DICOM;V2';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := nil;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;
  {$endif}

  // WMF
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioWMF;
    FullName := 'Windows Metafile';
    Extensions := 'WMF';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := nil; // cannot write
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // EMF
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioEMF;
    FullName := 'Enhanced Windows Metafile';
    Extensions := 'EMF';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := nil; // cannot write
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // TGA
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioTGA;
    FullName := 'Targa Bitmap';
    Extensions := 'TGA;TARGA;VDA;ICB;VST;PIX';
    DialogPage := [ppTGA];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // PXM
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioPXM;
    FullName := 'Portable Pixmap, GrayMap, BitMap';
    Extensions := 'PXM;PPM;PGM;PBM';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // WBMP
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioWBMP;
    FullName := 'Wireless Bitmap';
    Extensions := 'WBMP';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  {$IFDEF IEINCLUDEJPEG2000}
  // JP2
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioJP2;
    FullName := 'JPEG2000';
    Extensions := 'JP2';
    DialogPage := [ppJ2000];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;
  // J2K
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioJ2K;
    FullName := 'JPEG2000 Code Stream';
    Extensions := 'J2K;JPC;J2C';
    DialogPage := [ppJ2000];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;
  {$ENDIF}

  // PostScript (PS)
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioPS;
    FullName := 'PostScript Level 2';
    Extensions := 'PS;EPS';
    DialogPage := [];
    ReadFunction := nil;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // Adobe PDF
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioPDF;
    FullName := 'Adobe PDF';
    Extensions := 'PDF';
    DialogPage := [];
    ReadFunction := nil;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // DCX
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioDCX;
    FullName := 'Multipage PCX';
    Extensions := 'DCX';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // RAW
  {$ifdef IEINCLUDERAWFORMATS}
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioRAW;
    FullName := 'Camera RAW';
    Extensions := 'CRW;CR2;NEF;RAW;PEF;RAF;X3F;BAY;ORF;SRF;MRW;DCR;SR2';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := nil;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;
  {$endif}

  // PSD
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioPSD;
    FullName := 'Photoshop PSD';
    Extensions := 'PSD';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // IEV
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioIEV;
    FullName := 'Vectorial objects';
    Extensions := 'IEV';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // LYR
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioLYR;
    FullName := 'Layers';
    Extensions := 'LYR';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // ALL
  fi := TIEFileFormatInfo.Create;
  with fi do
  begin
    FileType := ioALL;
    FullName := 'Layers and objects';
    Extensions := 'ALL';
    DialogPage := [];
    ReadFunction := DumpReadImageStream;
    WriteFunction := DumpWriteImageStream;
    TryFunction := DumpTryimageStream;
    InternalFormat:=true;
    IEFileFormatAdd(fi);
  end;

  // HDP
  {$ifdef IEINCLUDEWIC}
  if IEWICAvailable() then
  begin
    fi := TIEFileFormatInfo.Create;
    with fi do
    begin
      FileType := ioHDP;
      FullName := 'Microsoft HD Photo';
      Extensions := 'WDP;HDP';
      DialogPage := [];
      ReadFunction := DumpReadImageStream;
      WriteFunction := DumpWriteImageStream;
      TryFunction := DumpTryimageStream;
      InternalFormat := true;
      IEFileFormatAdd(fi);
    end;
  end;
  {$endif}

end;

// update GIF WriteFunction and ReadFunction regarding to DefGIF_LZWCOMPFUNC and DefGIF_LZWDECOMPFUNC
procedure IEUpdateGIFStatus;
var
  fi: TIEFileFormatInfo;
begin
  fi := IEFileFormatGetInfo(ioGIF);
  if assigned(fi) then
  begin
    if @DefGIF_LZWDECOMPFUNC <> nil then
      fi.ReadFunction := DumpReadImageStream
    else
      fi.ReadFunction := nil;
    if @DefGIF_LZWCOMPFUNC <> nil then
      fi.WriteFunction := DumpWriteImageStream
    else
      fi.WriteFunction := nil;
  end;
end;

// Free iegFileFormats global variable
procedure IEFreeFileFormats;
var
  q: integer;
begin
  for q := 0 to iegFileFormats.Count - 1 do
    TIEFileFormatInfo(iegFileFormats[q]).Free;
  FreeAndNil(iegFileFormats);
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnIO.LoadFromFilePXM

<FM>Declaration<FC>
procedure LoadFromFilePXM(const FileName: WideString);

<FM>Description<FN>
<A TImageEnIO.LoadFromFilePXM> and <A TImageEnIO.LoadFromStreamPXM> methods load an image from a PBM, PGM, PPM file or stream.

If the file/stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
<FC>FileName<FN> is the file name with extension.
!!}
procedure TImageEnIO.LoadFromFilePXM(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFilePXM, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fIEBitmap.RemoveAlphaChannel;
      PXMReadStream(fs, fIEBitmap, fParams, Progress, false);
      CheckDPI;
      if fAutoAdjustDPI then
        AdjustDPI;
      fParams.fFileName := FileName;
      fParams.fFileType := ioPXM;
      update;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamPXM

<FM>Declaration<FC>
procedure LoadFromStreamPXM(Stream:TStream);

<FM>Description<FN>
<A TImageEnIO.LoadFromFilePXM> and <A TImageEnIO.LoadFromStreamPXM> methods load an image from a PBM, PGM, PPM file or stream.

If the file/stream does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
<FC>Stream<FN> is the source stream.
!!}
procedure TImageEnIO.LoadFromStreamPXM(Stream: TStream);
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamPXM, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    PXMReadStream(Stream, fIEBitmap, fParams, Progress, false);
    CheckDPI;
    if fAutoAdjustDPI then
      AdjustDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioPXM;
    update;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToFilePXM

<FM>Declaration<FC>
procedure SaveToFilePXM(const FileName: WideString);

<FM>Description<FN>
<A TImageEnIO.SaveToFilePXM> or <A TImageEnIO.SaveToStreamPXM> saves the current image in PBM, PGM or PPM format to file or stream.

<FC>FileName<FN> is the file name, with extension.

If the PBM (Portable Bitmap) contains only 1 bpp images (black/white), then the values must be Params.BitsPerPixel=1 and Params.SamplesPerPixel=1.
If the PGM (Portable Graymap) contains only 8 bpp images (gray scale), then the values must be Params.BitsPerPixel=8 and Params.SamplesPerPixel=1.
If the PPM (Portable Pixmap) contains only 24 bpp images (true color), then the values must be Params.BitsPerPixel=8 and Params.SamplesPerPixel=3.

!!}
procedure TImageEnIO.SaveToFilePXM(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFilePXM, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) and (fIEBitmap.PixelFormat<>ie48RGB) then
      fIEBitmap.PixelFormat := ie24RGB;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      PXMWriteStream(fs, fIEBitmap, fParams, Progress);
      fParams.FileName:=FileName;
      fParams.FileType:=ioPXM;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamPXM

<FM>Declaration<FC>
procedure SaveToStreamPXM(Stream:TStream);

<FM>Description<FN>
<A TImageEnIO.SaveToFilePXM> or <A TImageEnIO.SaveToStreamPXM> saves the current image in PBM, PGM or PPM format to file or stream.

<FC>Stream<FN> is the source stream.

If the PBM (Portable Bitmap) contains only 1 bpp images (black/white), then the values must be Params.BitsPerPixel=1 and Params.SamplesPerPixel=1.
If the PGM (Portable Graymap) contains only 8 bpp images (gray scale), then the values must be Params.BitsPerPixel=8 and Params.SamplesPerPixel=1.
If the PPM (Portable Pixmap) contains only 24 bpp images (true color), then the values must be Params.BitsPerPixel=8 and Params.SamplesPerPixel=3.

!!}
procedure TImageEnIO.SaveToStreamPXM(Stream: TStream);
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamPXM, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    PXMWriteStream(Stream, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;

procedure PrintImagePos_func1(x, y: dword; pixel: pointer; UserData: pointer);
begin
  with PRGB(pixel)^ do
  begin
    r := pbytearray(UserData)^[r];
    g := pbytearray(UserData)^[g];
    b := pbytearray(UserData)^[b];
  end;
end;

// dpix,dpiy cannot be 0
procedure TImageEnIO.PrintImagePosEx(PrtCanvas: TCanvas; dpix, dpiy: integer; x, y: double; Width, Height: double; GammaCorrection: double);
var
  px, py, pWidth, pHeight: integer;
  zz: double;
begin
  IEPrintLogWrite('TImageEnIO.PrintImagePosEx: begin');
  if not MakeConsistentBitmap([]) then
    exit;
  //
  px := trunc(x * dpix);
  py := trunc(y * dpiy);
  pWidth := trunc(Width * dpix);
  pHeight := trunc(Height * dpiy);
  zz := pWidth / fIEBitmap.Width;
  //
  if (fPrintingFilterOnSubsampling<>rfNone) and (zz < 1) then
  begin
    IEPrintLogWrite('TImageEnIO.PrintImagePosEx: calling RenderToCanvas with subsampling filter');
    fIEBitmap.RenderToCanvas(PrtCanvas, px, py, pWidth, pHeight, fPrintingFilterOnSubsampling, GammaCorrection);
  end
  else
  begin
    IEPrintLogWrite('TImageEnIO.PrintImagePosEx: calling RenderToCanvas without subsampling filter');
    fIEBitmap.RenderToCanvas(PrtCanvas, px, py, pWidth, pHeight, rfNone, GammaCorrection);
  end;
  IEPrintLogWrite('TImageEnIO.PrintImagePosEx: end');
end;



{!!
<FS>TImageEnIO.PrintImagePos

<FM>Declaration<FC>
procedure PrintImagePos(PrtCanvas:TCanvas; x, y:double; Width, Height:double; GammaCorrection:double);

<FM>Description<FN>
PrintImagePos prints the current image, specifing absolute position and size.

PrtCanvas is the printing canvas. The application can set this parameter from Printer.Canvas.

<FC>x, y<FN> is the top-left starting point, in inches.
<FC>Width, Height<FN> is the image size, in inches.
<FC>GammaCorrection<FN> is the gamma correction value. Use a value of 1.0 to disable gamma correction.

<FM>Example<FC>

// print the image at the position 2, 2 and height 10 and width 10 (stretch the image)
Printer.BeginDoc;
ImageEnView1.IO.PrintImagePos(Printer.Canvas,2,2,10,10,1);
Printer.EndDoc;
!!}
// if width=0 and/or height=0, PrintImagePos autocalculates for normal size
procedure TImageEnIO.PrintImagePos(PrtCanvas: TCanvas; x, y: double; Width, Height: double; GammaCorrection: double);
var
  dpix, dpiy: integer;
begin
  dpix := GetDeviceCaps(PrtCanvas.Handle, LOGPIXELSX);
  dpiy := GetDeviceCaps(PrtCanvas.Handle, LOGPIXELSY);
  PrintImagePosEx(PrtCanvas, dpix, dpiy, x, y, Width, Height, GammaCorrection);
end;

// dpix, dpiy are dpi of destination device, cannot be 0
procedure TImageEnIO.PrintImageEx(PrtCanvas: TCanvas; dpix, dpiy: integer; pagewidth, pageheight: double; MarginLeft, MarginTop, MarginRight, MarginBottom: double; VerticalPos: TIEVerticalPos; HorizontalPos: TIEHorizontalPos; Size: TIESize; SpecWidth, SpecHeight: double; GammaCorrection: double);
var
  x, y, width, height: double;
  z: double;
  bitmapwidth, bitmapheight: double; // in inches
  imgdpix, imgdpiy: integer;
begin
  IEPrintLogWrite('TImageEnIO.PrintImageEx: begin');
  if not MakeConsistentBitmap([]) then
    exit;
  if assigned(fImageEnView) then
  begin
    imgdpix := fImageEnView.DpiX;
    imgdpiy := fImageEnView.DpiY;
  end
  else
  begin
    imgdpix := Params.DpiX;
    imgdpiy := Params.DpiY;
  end;
  if assigned(fTImage) then
  begin
    if (fTImage.Picture.Bitmap.PixelFormat <> pf1bit) and (fTImage.Picture.Bitmap.PixelFormat <> pf24bit) then
      fTImage.Picture.Bitmap.PixelFormat := pf24bit;
  end;
  (*
  if imgdpix<=1 then imgdpix:=gDefaultDpix;
  if imgdpiy<=1 then imgdpiy:=gDefaultDpiy;
  *)
  if imgdpix <= 1 then
    imgdpix := dpix;
  if imgdpiy <= 1 then
    imgdpiy := dpiy;
  (*
  if (dpix=0) or (dpiy=0) then begin
   dpix:=imgdpix;
     dpiy:=imgdpiy;
     pagewidth:=pagewidth/dpix;
     pageheight:=pageheight/dpiy;
  end;*)
  IEPrintLogWrite('TImageEnIO.PrintImageEx: setting page sizes');
  pagewidth := pagewidth - (MarginLeft + MarginRight);
  pageheight := pageheight - (MarginTop + MarginBottom);
  width := 0;
  height := 0;
  x := 0;
  y := 0;
  case Size of
    iesNORMAL:
      begin
        width := fIEBitmap.Width / imgdpix;
        height := fIEBitmap.Height / imgdpiy;
      end;
    iesFITTOPAGE:
      begin
        bitmapwidth := fIEBitmap.Width / dpix;
        bitmapheight := fIEBitmap.Height / dpiy;
        z := dmin(pagewidth / bitmapwidth, pageheight / bitmapheight);
        width := bitmapwidth * z;
        height := bitmapheight * z;
      end;
    iesFITTOPAGESTRETCH:
      begin
        width := pagewidth;
        height := pageheight;
      end;
    iesSPECIFIEDSIZE:
      begin
        width := SpecWidth;
        height := SpecHeight;
      end;
  end;
  case HorizontalPos of
    iehpLEFT:
      x := MarginLeft;
    iehpCENTER:
      x := MarginLeft + (pagewidth - width) / 2;
    iehpRIGHT:
      x := MarginLeft + pagewidth - width;
  end;
  case VerticalPos of
    ievpTOP:
      y := MarginTop;
    ievpCENTER:
      y := MarginTop + (pageheight - height) / 2;
    ievpBOTTOM:
      y := MarginTop + pageheight - height;
  end;
  PrintImagePosEx(PrtCanvas, dpix, dpiy, x, y, width, height, GammaCorrection);
  IEPrintLogWrite('TImageEnIO.PrintImageEx: end');
end;

{!!
<FS>TImageEnIO.PrintImage

<FM>Declaration<FC>
procedure PrintImage(PrtCanvas:TCanvas; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:<A TIEVerticalPos>; HorizontalPos:<A TIEHorizontalPos>; Size: <A TIESize>; SpecWidth,SpecHeight:double; GammaCorrection:double);

<FM>Description<FN>
PrintImage prints the current image by specifying margins, vertical position, horizonal position and size.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>PrtCanvas<FN></C> <C>This is the printing canvas. The application can set this parameter from Printer.Canvas.</C> </R>
<R> <C><FC>MarginLeft<FN></C> <C>Left page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>MarginTop<FN></C> <C>Top page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>MarginRight<FN></C> <C>Right page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>MarginBottom<FN></C> <C>Bottom page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>VerticalPos<FN></C> <C>Determines how the image vertically aligns within the page.</C> </R>
<R> <C><FC>HorizontalPos<FN></C> <C>Determines how the image horizontally aligns within the page.</C> </R>
<R> <C><FC>Size<FN></C> <C>Determines the size of the image.</C> </R>
<R> <C><FC>SpecWidth<FN></C> <C>Specifies the absolute width of the image in inches. Valid only when Size=iesSPECIFIEDSIZE.</C> </R>
<R> <C><FC>SpecHeight<FN></C> <C>Specifies the absolute height of the image in inches. Valid only when Size=iesSPECIFIEDSIZE.</C> </R>
<R> <C><FC>GammaCorrection<FN></C> <C>The gamma correction value, use 1.0 to disable gamma correction.</C> </R>
</TABLE>


<FM>Example<FC>

// print the image in center of the page with original sizes
Printer.BeginDoc;
ImageEnView1.IO.PrintImage(Printer.Canvas,0,0,0,0,ievpCENTER,iehpCENTER,iesNORMAL,0,0,1);
Printer.EndDoc;

// print the image in center of the page stretch to the page (respecting the proportions)
Printer.BeginDoc;
ImageEnView1.IO.PrintImage(Printer.Canvas,0,0,0,0,ievpCENTER,iehpCENTER,iesFITTOPAGE,0,0,1);
Printer.EndDoc;

!!}
procedure TImageEnIO.PrintImage(PrtCanvas: TCanvas; MarginLeft, MarginTop, MarginRight, MarginBottom: double; VerticalPos: TIEVerticalPos; HorizontalPos: TIEHorizontalPos; Size: TIESize; SpecWidth, SpecHeight: double; GammaCorrection: double);
var
  dpix, dpiy: integer;
  pagewidth, pageheight: double;
begin
  IEPrintLogWrite('TImageEnIO.PrintImage: begin');
  if PrtCanvas = nil then
    PrtCanvas := Printer.Canvas;
  dpix := GetDeviceCaps(PrtCanvas.Handle, LOGPIXELSX);
  dpiy := GetDeviceCaps(PrtCanvas.Handle, LOGPIXELSY);
  pagewidth := GetDeviceCaps(PrtCanvas.Handle, 8) / dpix; // HORZRES
  pageheight := GetDeviceCaps(PrtCanvas.Handle, 10) / dpiy; // VERTRES
  PrintImageEx(PrtCanvas, dpix, dpiy, pagewidth, pageheight, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos, Size, SpecWidth, SpecHeight, GammaCorrection);
  IEPrintLogWrite('TImageEnIO.PrintImage: end');
end;



{!!
<FS>TImageEnIO.PreviewPrintImage

<FM>Declaration<FC>
procedure PreviewPrintImage(DestBitmap:TBitmap; MaxBitmapWidth, MaxBitmapHeight:integer; Printer:TPrinter; MarginLeft, MarginTop, MarginRight, MarginBottom:double; VerticalPos:<A TIEVerticalPos>; HorizontalPos:<A TIEHorizontalPos>; Size:<A TIESize>; SpecWidth, SpecHeight:double; GammaCorrection:double);

<FM>Description<FN>
PreviewPrintImage draws the current image print preview, specifying margins, vertical position, horizontal position and size.
It also paints a rectangle over the image that specifies the margin limits.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>DestBitmap<FN></C> <C>Destination bitmap where to paint the preview. Resizes DestBitmap as needed.</C> </R>
<R> <C><FC>MaxBitmapWidth<FN></C> <C>Maximum destination bitmap width. Preview will be stretched to match this size.</C> </R>
<R> <C><FC>MaxBitmapHeight<FN></C> <C>Maximum destination bitmap height. Preview will be stretched to match this size.</C> </R>
<R> <C><FC>Printer<FN></C> <C>This is the Printer object. PreviewPrintImage need it to know printer settings as orientation or page sizes.</C> </R>
<R> <C><FC>MarginLeft<FN></C> <C>Left page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>MarginTop<FN></C> <C>Top page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>MarginRight<FN></C> <C>Right page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>MarginBottom<FN></C> <C>Bottom page margin in inches. Specying zero causes no margin to be used.</C> </R>
<R> <C><FC>VerticalPos<FN></C> <C>Determines how the image vertically aligns within the page.</C> </R>
<R> <C><FC>HorizontalPos<FN></C> <C>Determines how the image horizontally aligns within the page.</C> </R>
<R> <C><FC>Size<FN></C> <C>Determines the size of the image.</C> </R>
<R> <C><FC>SpecWidth<FN></C> <C>Specifies the absolute width of the image in inches. Valid only when Size=iesSPECIFIEDSIZE.</C> </R>
<R> <C><FC>SpecHeight<FN></C> <C>Specifies the absolute height of the image in inches. Valid only when Size=iesSPECIFIEDSIZE.</C> </R>
<R> <C><FC>GammaCorrection<FN></C> <C>The gamma correction value, use 1.0 to disable gamma correction.</C> </R>
</TABLE>


<FM>Example<FC>

// Assuming that ImageEnView1 contains the image and ImageEnIO1 is attached to ImageEnView1.
// Paint and display the preview in ImageEnView2 component.
ImageEnView1.IO.PreviewPrintImage(ImageEnView2.Bitmap, ImageEnView2.Width, ImageEnView2.Height, Printer, 0, 0, 0, 0, ievpCENTER, iehpCENTER, iesFITTOPAGE ,0 ,0 , 1);
ImageEnView2.Update;

!!}
procedure TImageEnIO.PreviewPrintImage(DestBitmap: TBitmap; MaxBitmapWidth, MaxBitmapHeight: integer; PrinterObj: TPrinter; MarginLeft, MarginTop, MarginRight, MarginBottom: double; VerticalPos: TIEVerticalPos; HorizontalPos: TIEHorizontalPos; Size: TIESize; SpecWidth, SpecHeight: double; GammaCorrection: double);
var
  Zoom, z1, z: double;
  x1, y1, x2, y2: integer;
  dpix, dpiy: integer;
  PageWidth, PageHeight: integer;
begin
  if PrinterObj = nil then
    PrinterObj := Printer;
  Zoom := (MaxBitmapWidth - 5) / (PrinterObj.PageWidth / 100);
  z1 := (MaxBitmapHeight - 5) / (PrinterObj.PageHeight / 100);
  if z1 < Zoom then
    Zoom := z1;
  z := Zoom / 100;
  PageWidth := trunc(PrinterObj.PageWidth * z);
  PageHeight := trunc(PrinterObj.PageHeight * z);
  dpix := trunc(GetDeviceCaps(PrinterObj.Handle, LOGPIXELSX) * z);
  dpiy := trunc(GetDeviceCaps(PrinterObj.Handle, LOGPIXELSY) * z);
  DestBitmap.Width := 1;
  DestBitmap.Height := 1;
  DestBitmap.PixelFormat := pf24bit;
  DestBitmap.Width := PageWidth;
  DestBitmap.Height := PageHeight;
  with DestBitmap.Canvas do
  begin
    Brush.Color := clWhite;
    Brush.Style := bsSolid;
    fillrect(rect(0, 0, destbitmap.width, destbitmap.height));
  end;
  PrintImageEx(DestBitmap.Canvas, dpix, dpiy, PageWidth / dpix, PageHeight / dpiy, MarginLeft, MarginTop, MarginRight, MarginBottom, VerticalPos, HorizontalPos, Size, SpecWidth, SpecHeight, GammaCorrection);
  with DestBitmap.Canvas do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBlack;
    Pen.Mode := pmNot;
    Pen.Style := psDash;
    Pen.Width := 1;
    x1 := trunc(MarginLeft * dpix);
    y1 := trunc(MarginTop * dpiy);
    x2 := trunc(PageWidth - MarginRight * dpix);
    y2 := trunc(PageHeight - MarginBOttom * dpiy);
    Rectangle(x1, y1, x2, y2);
  end;
end;

{!!
<FS>TImageEnIO.InjectJpegIPTC

<FM>Declaration<FC>
function InjectJpegIPTC(const FileName: WideString):boolean;

<FM>Description<FN>
InjectJpegIPTC replaces IPTC information of the FileName jpeg file with IPTC current in memory without loading or modifying the original image.

The method returns False on fail.

<FM>Example<FC>

// copy the IPTC info (not the image) from file one.jpg to the inside of file two.jpg, without loading any images
ImageEnView1.IO.ParamsFromFile('one.jpg');
ImageEnView1.IO.InjectJpegIPTC('two.jpg');

// removes IPTC info from image.jpg
ImageEnView1.IO.Params.IPTC_Info.Clear;
ImageEnView1.IO.InjectJpegIPTC('image.jpg');

!!}
function TImageEnIO.InjectJpegIPTC(const FileName: WideString): boolean;
var
  fr: TMemoryStream;
  fm: TMemoryStream;
  Progress: TProgressRec;
begin
  fAborting := false;
  Progress.Aborting := @fAborting;
  Progress.fOnProgress := fOnIntProgress;
  Progress.Sender := Self;
  fr := TMemorystream.Create;
  fm := TMemoryStream.Create;
  try
    fr.LoadFromFile(FileName);
    fr.Position := 0;
    fm.Size := fr.Size;
    result := IEJpegInjectIPTC(fr, fm, fParams.IPTC_Info, Progress);
    fm.Size := fm.Position;
    if result then
      fm.SaveToFile(FileName);
  finally
    FreeAndNil(fr);
    FreeAndNil(fm);
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.InjectJpegIPTCStream

<FM>Declaration<FC>
function InjectJpegIPTCStream(InputStream, OutputStream:TStream):boolean;

<FM>Description<FN>
InjectJpegIPTCStream replaces IPTC information of the InputStream stream (Jpeg) with IPTC currently in memory without loading or modifying the original image.
<FC>OutputStream<FN> contains the modified stream.

The method returns False if it fails.
!!}
function TImageEnIO.InjectJpegIPTCStream(InputStream, OutputStream: TStream): boolean;
var
  Progress: TProgressRec;
begin
  Progress.fOnProgress := nil;
  result := IEJpegInjectIPTC(InputStream, OutputStream, fParams.IPTC_Info, Progress);
end;

{!!
<FS>TImageEnIO.InjectJpegEXIF

<FM>Declaration<FC>
function InjectJpegEXIF(const FileName: WideString):boolean;

<FM>Description<FN>
InjectJpegEXIF replaces EXIF information of the FileName Jpeg file with EXIF current in memory without loading or modifying the original image.
The method returns False if it fails.

<FM>Example<FC>
// copy the EXIF info (not the image) from file one.jpg inside two.jpg, without loading any image
ImageEnView1.IO.ParamsFromFile('one.jpg');
ImageEnView1.IO.InjectJpegEXIF('two.jpg');

// removes EXIF info from image.jpg
ImageEnView1.IO.Params.EXIF_HasExifData := false;
ImageEnView1.IO.InjectJpegEXIF('image.jpg');

!!}
function TImageEnIO.InjectJpegEXIF(const FileName: WideString): boolean;
var
  fr: TMemoryStream;
  fm: TMemoryStream;
  Progress: TProgressRec;
begin
  fAborting := false;
  Progress.Aborting := @fAborting;
  Progress.fOnProgress := fOnIntProgress;
  Progress.Sender := Self;
  fr := TMemoryStream.Create;
  fm := TMemoryStream.Create;
  try
    fr.LoadFromFile(FileName);
    fr.Position := 0;
    fm.Size := fr.Size;
    result := IEJpegInjectEXIF(fr, fm, fParams, Progress);
    fm.Size := fm.Position;
    if result then
      fm.SaveToFile(FileName);
  finally
    FreeAndNil(fr);
    FreeAndNil(fm);
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.InjectJpegEXIFStream

<FM>Declaration<FC>
function InjectJpegEXIFStream(InputStream, OutputStream:TStream):boolean;

<FM>Description<FN>
InjectJpegEXIFStream replaces EXIF information of the InputStream stream (jpeg) with EXIF current in memory without loading or modifying the original image.
<FC>OutputStream<FN> contains the modified stream.
The method returns <FC>false<FN> if it fails.
!!}
function TImageEnIO.InjectJpegEXIFStream(InputStream, OutputStream: TStream): boolean;
var
  Progress: TProgressRec;
begin
  Progress.fOnProgress := nil;
  result := IEJpegInjectEXIF(InputStream, OutputStream, fParams, Progress);
end;




{!!
<FS>TImageEnIO.InjectTIFFEXIF

<FM>Declaration<FC>
function InjectTIFFEXIF(const FileName: WideString; pageIndex:integer): boolean;
function InjectTIFFEXIF(const InputFileName, OutputFileName: WideString; pageIndex:integer): boolean;
function InjectTIFFEXIF(InputStream, OutputStream:TStream; pageIndex:integer): boolean;

<FM>Description<FN>
InjectTIFFEXIF replaces EXIF meta-tags of InputStream or FileName with EXIF currently in memory without loading or modifying the original image.
InjectTIFFEXIF works only with TIFF and Microsoft HDPhoto file formats.
The method returns <FC>false<FN> if it fails.
!!}
{$ifdef IEINCLUDETIFFHANDLER}
function TImageEnIO.InjectTIFFEXIF(const FileName: WideString; pageIndex:integer): boolean;
begin
  result := IEInjectTIFFEXIF(nil, nil, FileName, FileName, pageIndex, fParams);
end;

function TImageEnIO.InjectTIFFEXIF(const InputFileName, OutputFileName: WideString; pageIndex:integer = 0): boolean;
begin
  result := IEInjectTIFFEXIF(nil, nil, InputFileName, OutputFileName, pageIndex, fParams);
end;

function TImageEnIO.InjectTIFFEXIF(InputStream, OutputStream:TStream; pageIndex:integer): boolean;
begin
  result := IEInjectTIFFEXIF(InputStream, OutputStream, '', '', pageIndex, fParams);
end;
{$endif}



{$IFDEF IEINCLUDEOPENSAVEDIALOGS}

{!!
<FS>TImageEnIO.ExecuteOpenDialog

<FM>Declaration<FC>
function ExecuteOpenDialog(const InitialDir:WideString; const InitialFileName:WideString; AlwaysAnimate:boolean; FilterIndex:integer; const ExtendedFilters:WideString; const Title:WideString=''; const Filter:WideString=''):WideString;

<FM>Description<FN>
The ExecuteOpenDialog shows and executes the open dialog. It encapsulates the <A TOpenImageEnDialog> component.
<FC>InitialDir<FN> is the starting directory.
<FC>InitialFileName<FN> is the default file name with extension.
<FC>AlwaysAnimate<FN> if true auto-animate GIF and AVI
<FC>FilterIndex<FN> specifies what file format to select for default. Allowed values:
1 : Common graphics formats
2 : All Graphics formats
3 : TIFF Bitmap (TIF;TIFF;FAX)
4 : GIF (GIF)
5 : JPEG Bitmap (JPG;JPEG;JPE)
6 : PaintBrush (PCX)
7 : Windows Bitmap (BMP;DIB;RLE)
8 : Windows Icon (ICO)
9 : Windows Cursor (CUR)
10 : Portable Network Graphics (PNG)
11 : DICOM medical imaging (DCM)
12 : Windows Metafile (WMF)
13 : Enhanced Windows Metafile (EMF)
14 : Targa Bitmap (TGA;TARGA;VDA;ICB;VST;PIX)
15 : Portable Pixmap, GreyMap, BitMap (PXM;PPM;PGM;PBM)
16 : Wireless Bitmap (WBMP)
17 : Jpeg2000 (JP2)
18 : Jpeg2000 Code Stream (J2K;JPC;J2C)
19 : Multipage PCX (DCX)
20 : Camera RAW (RAW;NEF....)
21 : Photoshop PSD (PSD)
22 : Vectorial objects (IEV)
23 : Layers (LYR)
24 : Layers and vectorial objects (ALL)
25 : Microsoft HD Photo (HDP;WDP)
26 : Video for Windows (AVI)
27 : Mpeg (MPG;MPEG)
28 : Windows Media Video (WMV)

<FC>ExtendedFilters<FN> specifies additional file formats (example: 'Fun Bitmap|*.fun;*.fan' ).
<FC>Title<FN> specifies the dialog title. Empty string means operating system default value.
<FC>Filter<FN> specifies file extensions to enable (i.e. 'JPEG Bitmap (JPG)|*.jpg|CompuServe Bitmap (GIF)|*.gif').

Returns null string ('') if the user clicks on Cancel.

<FM>Example<FC>

filename := ImageEnView1.IO.ExecuteOpenDialog('', '', false);
if filename <> '' then
  ImageEnView1.IO.LoadFromFile(filename);
!!}
function TImageEnIO.ExecuteOpenDialog(const InitialDir:WideString; const InitialFileName:WideString; AlwaysAnimate:boolean;
                                      FilterIndex: integer; const ExtendedFilters:WideString; const Title:WideString; const Filter:WideString):WideString;
var
  fOpenImageEnDialog: TOpenImageEnDialog;
begin
  fOpenImageEnDialog := TOpenImageEnDialog.create(self);
  fOpenImageEnDialog.InitialDir := string(InitialDir);
  fOpenImageEnDialog.FileName := InitialFileName;
{$IFDEF IEINCLUDEMULTIVIEW}
  fOpenImageEnDialog.AlwaysAnimate := AlwaysAnimate;
{$ENDIF}

{$IFNDEF IEDELPHI3}
{$IFNDEF IECPPBUILDER3}
  fOpenImageEnDialog.Options := fOpenImageEnDialog.Options + [OFENABLESIZING];
{$ENDIF}
{$ENDIF}

  if Filter<>'' then
  begin
    fOpenImageEnDialog.AutoSetFilter := false;
    fOpenImageEnDialog.Filter := Filter;
  end;

  fOpenImageEnDialog.PreviewBorderStyle := IepsSoftShadow;
  fOpenImageEnDialog.FilterIndex := FilterIndex;
  fOpenImageEnDialog.AutoAdjustDPI := AutoAdjustDPI;
  fOpenImageEnDialog.FilteredAdjustDPI := FilteredAdjustDPI;
  fOpenImageEnDialog.ExtendedFilters := string(ExtendedFilters);
  fOpenImageEnDialog.MsgLanguage := fMsgLanguage;
  if Title<>'' then
    fOpenImageEnDialog.Title := string(Title);
  if fOpenImageEnDialog.Execute then
  begin
    Params.TIFF_ImageIndex:=fOpenImageEnDialog.SelectedFrame;
    Params.GIF_ImageIndex:=fOpenImageEnDialog.SelectedFrame;
    Params.DCX_ImageIndex:=fOpenImageEnDialog.SelectedFrame;
    Params.ICO_ImageIndex:=fOpenImageEnDialog.SelectedFrame;
    result := fOpenImageEnDialog.FileNameW;
  end
  else
    result := '';
  FreeAndNil(fOpenImageEnDialog);
end;
{$ENDIF} // IEINCLUDEOPENSAVEDIALOGS

{$IFDEF IEINCLUDEOPENSAVEDIALOGS}

{!!
<FS>TImageEnIO.ExecuteSaveDialog

<FM>Declaration<FC>
function ExecuteSaveDialog(const InitialDir:WideString; const InitialFileName:WideString; AlwaysAnimate:boolean; FilterIndex:integer; const ExtendedFilters:WideString; const Title:WideString; const Filter:WideString=''):WideString;

<FM>Description<FN>
The ExecuteSaveDialog shows and executes the save dialog. It encapsulates the <A TSaveImageEnDialog> component.
<FC>InitialDir<FN> is the starting directory.
<FC>InitialFileName<FN> is the default file name with extension.
<FC>AlwaysAnimate<FN> if true auto-animate GIF and AVI
<FC>FilterIndex<FN> specifies what file format to select by default. The InitialFileName extension, if specified, in the second parameter, will over-ride the specified index. Valid values are:
1 : TIFF Bitmap (TIF;TIFF;FAX)
2 : GIF (GIF) - if enabled
3 : JPEG Bitmap (JPG;JPEG;JPE)
4 : PaintBrush (PCX)
5 : Windows Bitmap (BMP;DIB;RLE)
6 : Windows Icon (ICO)
7 : Portable Network Graphics (PNG)
8 : Targa Bitmap (TGA;TARGA;VDA;ICB;VST;PIX)
9 : Portable Pixmap, GreyMap, BitMap (PXM;PPM;PGM;PBM)
10 : Wireless Bitmap (WBMP)
11 : Jpeg2000 (JP2)
12 : Jpeg2000 Code Stream (J2K;JPC;J2C)
13 : PostScript Level 2 (PS;EPS)
14 : Adobe PDF (PDF)
15 : Multipage PCX (DCX)
16 : Photoshop PSD (PSD)
17 : Vectorial objects (IEV)
18 : Layers (LYR)
19 : Layers and objects (ALL)
20 : Microsoft HD Photo
21 : Video for Windows (AVI)

<FC>ExtendedFilters<FN> specifies additional file formats (example: 'Fun Bitmap|*.fun;*.fan' )
<FC>Title<FN> specifies the dialog title. Empty string means operating system default value.
<FC>Filter<FN> specifies file extensions to enable (i.e. 'JPEG Bitmap (JPG)|*.jpg|CompuServe Bitmap (GIF)|*.gif').

Returns a null string ('') if the user clicks on Cancel.

<FM>Example<FC>

filename := ImageEnView1.IO.ExecuteOpenDialog('', '', false);
if filename<>'' then
  ImageEnView1.IO.SaveToFile(fileName)
!!}
function TImageEnIO.ExecuteSaveDialog(const InitialDir:WideString; const InitialFileName:WideString; AlwaysAnimate: boolean; FilterIndex: integer; const ExtendedFilters:WideString; const Title:WideString; const Filter:WideString):WideString;
var
  fSaveImageEnDialog: TSaveImageEnDialog;
begin
  fSaveImageEnDialog := TSaveImageEnDialog.create(self);
  fSaveImageEnDialog.InitialDir := string(InitialDir);
  fSaveImageEnDialog.FileName := InitialFileName;
{$IFDEF IEINCLUDEMULTIVIEW}
  fSaveImageEnDialog.AlwaysAnimate := AlwaysAnimate;
{$ENDIF}
{$IFNDEF IEDELPHI3}
{$IFNDEF IECPPBUILDER3}
  fSaveImageEnDialog.Options := fSaveImageEnDialog.Options + [OFENABLESIZING];
{$ENDIF}
{$ENDIF}
  if Filter<>'' then
  begin
    fSaveImageEnDialog.AutoSetFilter := false;
    fSaveImageEnDialog.Filter := Filter;
  end;
  fSaveImageEnDialog.AttachedImageEnIO := self;
  fSaveImageEnDialog.PreviewBorderStyle := IepsSoftShadow;
  fSaveImageEnDialog.FilterIndex := FilterIndex;
  fSaveImageEnDialog.AutoAdjustDPI := AutoAdjustDPI;
  fSaveImageEnDialog.FilteredAdjustDPI := FilteredAdjustDPI;
  fSaveImageEnDialog.ExtendedFilters := string(ExtendedFilters);
  fSaveImageEnDialog.MsgLanguage := fMsgLanguage;
  fSaveImageEnDialog.ShowAVI:=false;
  if Title<>'' then
    fSaveImageEnDialog.Title:=string(Title);
  if fSaveImageEnDialog.Execute then
    result := fSaveImageEnDialog.FileNameW
  else
    result := '';
  FreeAndNil(fSaveImageEnDialog);
end;
{$ENDIF} // IEINCLUDEOPENSAVEDIALOGS

{!!
<FS>TImageEnIO.CaptureFromScreen

<FM>Declaration<FC>
procedure CaptureFromScreen(Source:<A TIECSSource>; MouseCursor:TCursor);

<FM>Description<FN>
CaptureFromScreen captures current desktop or active window.

MouseCursor defines the cursor to draw because ImageEn cannot get it from Windows. Use -1 for none.

<FM>Example<FC>

// saves current desktop in 'screen.png'
ImageEnView1.io.CaptureFromScreen(iecsScreen,-1);
ImageEnView1.io.SaveToFile('screen.png');

!!}
procedure TImageEnIO.CaptureFromScreen(Source: TIECSSource; MouseCursor: TCursor);
var
  hwin, hdc: THandle;
  x, y, w, h: integer;
  rc: trect;
  vdsk: boolean;
  pt: TPoint;
  xbmp: TIEDibBitmap;
  plc: TWINDOWPLACEMENT;
  hCursor: THandle;
  MousePt: TPoint;
  ClientLeftTop: TPoint;
  IconInfo: TIconInfo;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateCaptureFromScreen(self, CaptureFromScreen, Source, MouseCursor);
    exit;
  end;
  if not MakeConsistentBitmap([]) then
    exit;
  getcursorpos(MousePt);
  hCursor := Screen.Cursors[-2];
  GetIconInfo(hCursor, IconInfo);
  ClientLeftTop := Point(0, 0);
  vdsk := (iegOpSys<>ieosWin95) and (iegOpSys<>ieosWinNT4); // 2.3.1
  hwin := 0;
  w := 0;
  h := 0;
  x := 0;
  y := 0;
  case Source of
    iecsScreen:
      begin
        hwin := GetDesktopWindow;
        if vdsk then
        begin
          // available only on win98, me, 2000, Xp
          x := GetSystemMetrics(76); // SM_XVIRTUALSCREEN
          y := GetSystemMetrics(77); // SM_YVIRTUALSCREEN
          w := GetSystemMetrics(78); // SM_CXVIRTUALSCREEN
          h := GetSystemMetrics(79); // SM_CYVIRTUALSCREEN
        end
        else
        begin
          w := Screen.Width;
          h := Screen.Height;
        end;
        dec(MousePt.x, integer(IconInfo.xHotspot));
        dec(MousePt.y, integer(IconInfo.yHotspot));
        Windows.ScreenToClient(hwin, MousePt);
      end;
    iecsForegroundWindow:
      begin
        hwin := GetForegroundWindow;
        if hwin <> 0 then
        begin
          plc.length := sizeof(TWINDOWPLACEMENT);
          GetWindowPlacement(hwin, @plc);
          if GetWindowRect(hwin, rc) then
          begin
            if plc.showCmd = SW_SHOWMAXIMIZED then
            begin
              if rc.left < 0 then
                x := -rc.left;
              if rc.top < 0 then
                y := -rc.top;
              w := rc.Right - x;
              h := rc.Bottom - y;
              if rc.left < 0 then
                rc.left := 0;
              if rc.top < 0 then
                rc.top := 0;
            end
            else
            begin
              w := rc.Right - rc.Left;
              h := rc.Bottom - rc.Top;
            end;
            Windows.ClientToScreen(hwin, ClientLeftTop);
            dec(MousePt.x, -(ClientLeftTop.x - rc.left) + integer(IconInfo.xHotspot));
            dec(MousePt.y, -(ClientLeftTop.y - rc.top) + integer(IconInfo.yHotspot));
            Windows.ScreenToClient(hwin, MousePt);
          end
          else
            hwin := 0;
        end;
      end;
    iecsForegroundWindowClient:
      begin
        hwin := GetForegroundWindow;
        if hwin <> 0 then
        begin
          if GetClientRect(hwin, rc) then
          begin
            pt.x := rc.Left;
            pt.y := rc.Top;
            Windows.ClientToScreen(hwin, pt);
            x := pt.x;
            y := pt.y;
            pt.x := rc.Right;
            pt.y := rc.Bottom;
            Windows.ClientToScreen(hwin, pt);
            w := pt.x - x;
            h := pt.y - y;
            hwin := GetDesktopWindow;
            dec(MousePt.x, integer(IconInfo.xHotspot) + x);
            dec(MousePt.y, integer(IconInfo.yHotspot) + y);
          end
          else
            hwin := 0;
        end;
      end;
  end;
  if hwin <> 0 then
  begin
    xbmp := TIEDibBitmap.Create;
    xbmp.AllocateBits(w, h, 24);
    hdc := GetWindowDC(hwin);
    if hdc <> 0 then
    begin
      BitBlt(xbmp.HDC, 0, 0, w, h, hdc, x, y, SRCCOPY);
      if MouseCursor <> -1 then
        DrawIconEx(xbmp.HDC, MousePt.x, MousePt.y, hCursor, 0, 0, 0, 0, DI_DEFAULTSIZE or DI_NORMAL);
      fIEBitmap.Allocate(w, h, ie24RGB);
      for y := 0 to h - 1 do
        CopyMemory(fIEBitmap.Scanline[y], xbmp.Scanline[y], fIEBitmap.RowLen);
      FreeAndNil(xbmp);
      ReleaseDC(hwin, hdc);
      fParams.DpiX:=gSystemDPIX;
      fParams.DpiY:=gSystemDPIY;
      Update;
    end;
  end;
  DoFinishWork;
end;

{$IFDEF IEINCLUDEPRINTDIALOGS}

constructor TIOPrintPreviewParams.Create;
begin
  inherited Create;
  fMarginTop:=1;
  fMarginLeft:=1;
  fMarginRight:=1;
  fMarginBottom:=1;
  fPosition:=ppCenter;
  fSize:=psFitToPage;
  fWidth :=-1;  // default autocalculated
  fHeight:=-1;  // default autocalculated
  fGamma:=1;
end;

{!!
<FS>TIOPrintPreviewParams.SaveToFile

<FM>Declaration<FC>
procedure SaveToFile(const FileName:WideString);

<FM>Description<FN>
Save all properties to file.
!!}
procedure TIOPrintPreviewParams.SaveToFile(const FileName:WideString);
var
  fs: TIEWideFileStream;
begin
  fs:=TIEWideFileStream.Create(FileName, fmCreate);
  SaveToStream(fs);
  FreeAndNil(fs);
end;

{!!
<FS>TIOPrintPreviewParams.LoadFromFile

<FM>Declaration<FC>
procedure LoadFromFile(const FileName:WideString);

<FM>Description<FN>
Load all properties from file.
!!}
procedure TIOPrintPreviewParams.LoadFromFile(const FileName:WideString);
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TIOPrintPreviewParams.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream:TStream);

<FM>Description<FN>
Save all properties to stream.
!!}
procedure TIOPrintPreviewParams.SaveToStream(Stream:TStream);
begin
  Stream.Write(fMarginTop,sizeof(double));
  Stream.Write(fMarginLeft,sizeof(double));
  Stream.Write(fMarginRight,sizeof(double));
  Stream.Write(fMarginBottom,sizeof(double));
  Stream.Write(fPosition,sizeof(TIOPrintPreviewPosition));
  Stream.Write(fSize,sizeof(TIOPrintPreviewSize));
  Stream.Write(fWidth,sizeof(double));
  Stream.Write(fHeight,sizeof(double));
  Stream.Write(fGamma,sizeof(double));
end;

{!!
<FS>TIOPrintPreviewParams.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream:TStream);

<FM>Description<FN>
Loads all properties from stream.
!!}
procedure TIOPrintPreviewParams.LoadFromStream(Stream:TStream);
begin
  Stream.Read(fMarginTop,sizeof(double));
  Stream.Read(fMarginLeft,sizeof(double));
  Stream.Read(fMarginRight,sizeof(double));
  Stream.Read(fMarginBottom,sizeof(double));
  Stream.Read(fPosition,sizeof(TIOPrintPreviewPosition));
  Stream.Read(fSize,sizeof(TIOPrintPreviewSize));
  Stream.Read(fWidth,sizeof(double));
  Stream.Read(fHeight,sizeof(double));
  Stream.Read(fGamma,sizeof(double));
end;

{!!
<FS>TIOPrintPreviewParams.GetProperty

<FM>Declaration<FC>
function GetProperty(const Prop:WideString):WideString;

<FM>Description<FN>
Allows to read a property using its string representation.
!!}
function TIOPrintPreviewParams.GetProperty(const Prop:WideString):WideString;
var
	ss:WideString;
begin
	ss:=UpperCase(IERemoveCtrlCharsW(Prop));
  if ss='MARGINTOP' then
    result:=IEFloatToStrW(fMarginTop)
  else if ss='MARGINLEFT' then
    result:=IEFloatToStrW(fMarginLeft)
  else if ss='MARGINRIGHT' then
    result:=IEFloatToStrW(fMarginRight)
  else if ss='MARGINBOTTOM' then
    result:=IEFloatToStrW(fMarginBottom)
  else if ss='POSITION' then
    result:=IntToStr(integer(fPosition))
  else if ss='SIZE' then
    result:=IntToStr(integer(fSize))
  else if ss='WIDTH' then
    result:=IEFloatToStrW(fWidth)
  else if ss='HEIGHT' then
    result:=IEFloatToStrW(fHeight)
  else if ss='GAMMA' then
    result:=IEFloatToStrW(fGamma);
end;

{!!
<FS>TIOPrintPreviewParams.SetProperty

<FM>Declaration<FC>
procedure SetProperty(Prop,Value:WideString);

<FM>Description<FN>
Allows to write a property using its string representation.
!!}
procedure TIOPrintPreviewParams.SetProperty(Prop,Value:WideString);
var
	ss:WideString;
begin
	ss:=UpperCase(IERemoveCtrlCharsW(Prop));
  Value:=IERemoveCtrlCharsW(Value);
  if ss='MARGINLEFT' then
    fMarginLeft:=iestrtofloatdefW(value,0)
  else if ss='MARGINRIGHT' then
    fMarginRight:=iestrtofloatdefW(value,0)
  else if ss='MARGINTOP' then
    fMarginTop:=iestrtofloatdefW(value,0)
  else if ss='MARGINBOTTOM' then
    fMarginBottom:=iestrtofloatdefW(value,0)
  else if ss='POSITION' then
    fPosition:=TIOPrintPreviewPosition(StrToIntDef(value,0))
  else if ss='SIZE' then
    fSize:=TIOPrintPreviewSize(StrToIntDef(value,0))
  else if ss='WIDTH' then
    fWidth:=iestrtofloatdefW(value,0)
  else if ss='HEIGHT' then
    fHeight:=iestrtofloatdefW(value,0)
  else if ss='GAMMA' then
    fGamma:=iestrtofloatdefW(value,0);
end;


{!!
<FS>TImageEnIO.DoPrintPreviewDialog

<FM>Declaration<FC>
function DoPrintPreviewDialog(DialogType:<A TIEDialogType>; const TaskName:WideString ; PrintAnnotations:boolean; const Caption:WideString):boolean;

<FM>Description<FN>
DoPrintPreviewDialog shows the print preview dialog of type DialogType.

<FC>TaskName<FN> determines the text that appears listed in the Print Manager and on network header pages.
If <FC>PrintAnnotation<FN> is true and the image contains Imaging Annotations they will be printed out.
<FC>Caption<FN> specifies the caption of preview dialog.

<FM>Example<FC>

ImageEnView1.IO.DoPrintPreviewDialog(iedtDialog);
<IMG help_images\56.bmp>

ImageEnView1.IO.DoPrintPreviewDialog(iedtMaxi);
<IMG help_images\57.bmp>
!!}
function TImageEnIO.DoPrintPreviewDialog(DialogType: TIEDialogType; const TaskName: WideString; PrintAnnotations:boolean; const Caption:WideString): boolean;
var
  fieprnform1: tfieprnform1;
  fieprnform2: tfieprnform2;
begin
  if fResetPrinter then
    IEResetPrinter;
  result := false;
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.Width<=1) and (fIEBitmap.Height<=1) then
    exit;
  case DialogType of
    iedtDialog:
      begin
        fieprnform2 := tfieprnform2.Create(self);
        fieprnform2.io := self;
        fieprnform2.fDialogsMeasureUnit := fDialogsMeasureUnit;
        fieprnform2.SetLanguage(fMsgLanguage);
        fieprnform2.Font.assign(fPreviewFont);
        fieprnform2.fTaskName := TaskName;
        fieprnform2.fPrintPreviewParams:=fPrintPreviewParams;
        fieprnform2.PrintAnnotations:=PrintAnnotations;
        fieprnform2.Caption:=Caption;
        if assigned(fOnIOPreview) then
          fOnIOPreview(self, fieprnform2);
        result := fieprnform2.ShowModal = mrOk;
        fieprnform2.Release;
      end;
    iedtMaxi:
      begin
        fieprnform1 := tfieprnform1.Create(self);
        fieprnform1.io := self;
        fieprnform1.fDialogsMeasureUnit := fDialogsMeasureUnit;
        fieprnform1.SetLanguage(fMsgLanguage);
        fieprnform1.Font.assign(fPreviewFont);
        fieprnform1.fTaskName := TaskName;
        fieprnform1.Left := 0;
        fieprnform1.Top := 0;
        fieprnform1.fPrintPreviewParams:=fPrintPreviewParams;
        fieprnform1.PrintAnnotations:=PrintAnnotations;
        fieprnform1.Caption:=Caption;
        if assigned(fOnIOPreview) then
          fOnIOPreview(self, fieprnform1);
        result := fieprnform1.ShowModal = mrOk;
        fieprnform1.Release;
      end;
  end;
end;

{$ENDIF}

function IEAdjustDPI(bmp: TIEBitmap; Params: TIOParamsVals; FilteredAdjustDPI: boolean): TIEBitmap;
var
  new_w, new_h: integer;
begin
  result := bmp;
  with Params do
    if (DpiX <> DpiY) and (DpiX > 0) and (DpiY > 0) and (bmp.Width>0) and (bmp.Height>0) then
    begin
      result := TIEBitmap.Create;
      if Width > Height then
      begin
        new_h := trunc((Height / DpiY) * DpiX);
        new_w := Width;
        DpiY := DpiX;
        Height := new_h;
      end
      else
      begin
        new_w := trunc((Width / DpiX) * DpiY);
        new_h := Height;
        DpiX := DpiY;
        Width := new_w;
      end;
      if FilteredAdjustDPI then
      begin
        result.Allocate(new_w, new_h, ie24RGB);
        if bmp.PixelFormat <> ie24RGB then
          bmp.PixelFormat := ie24RGB;
        _ResampleEx(bmp, result, rfFastLinear, nil, nil);
      end
      else
      begin
        result.Allocate(new_w, new_h, bmp.PixelFormat);
        _IEBmpStretchEx(bmp, result, nil, nil);
      end;
    end;
end;

procedure TImageEnIO.AdjustDPI;
var
  new_w, new_h: integer;
  newbmp, oldalpha: TIEBitmap;
begin
  with fParams do
  begin
    if not MakeConsistentBitmap([]) then
      exit;
    if (DpiX <> DpiY) and (DpiX > 0) and (DpiY > 0) and (fIEBitmap.Width>0) and (fIEBitmap.Height>0) and (fHeight>0) and (fWidth>0) then
    begin
      newbmp := TIEBitmap.Create;
      if fWidth > fHeight then
      begin
        new_h := trunc((fHeight / fDpiY) * fDpiX);
        new_w := fWidth;
        fDpiY := fDpiX;
        fHeight := new_h;
      end
      else
      begin
        new_w := trunc((fWidth / fDpiX) * fDpiY);
        new_h := fHeight;
        fDpiX := fDpiY;
        fWidth := new_w;
      end;
      if fIEBitmap.HasAlphaChannel then
      begin
        oldalpha := TIEBitmap.Create;
        oldalpha.assign(fIEBitmap.AlphaChannel);
      end
      else
        oldalpha := nil;
      if fFilteredAdjustDPI then
      begin
        newbmp.Allocate(new_w, new_h, ie24RGB);
        if fIEBitmap.PixelFormat <> ie24RGB then
          fIEBitmap.PixelFormat := ie24RGB;
        _ResampleEx(fIEBitmap, newbmp, rfFastLinear, nil, nil);
      end
      else
      begin
        newbmp.Allocate(new_w, new_h, fIEBitmap.PixelFormat);
        _IEBmpStretchEx(fIEBitmap, newbmp, nil, nil);
      end;
      fIEBitmap.Assign(newbmp);
      FreeAndNil(newbmp);
      // stretch alpha
      if assigned(oldalpha) then
      begin
        _IEBmpStretchEx(oldalpha, fIEBitmap.AlphaChannel, nil, nil);
        FreeAndNil(oldalpha);
      end;
    end;
  end;
end;

{!!
<FS>JpegLosslessTransformStream

<FM>Declaration<FC>
function JpegLosslessTransformStream(SourceStream, DestStream:TStream; Transform:<A TIEJpegTransform>; GrayScale:boolean; CopyMarkers:<A TIEJpegCopyMarkers>; CutRect:Trect; UpdateEXIF:Boolean=false):boolean;

<FM>Description<FN>
JpegLosslessTransformStream performs various useful transformations of Jpeg files. JpegLosslessTransform works by rearranging the compressed data, without ever fully decoding the image. Therefore, its transformations are lossless: there is no image degradation at all.

The resulting image will contain at least the CutRect region (constrained to the image size), and may be larger to round up to the nearest DCT block boundary (or multiple thereof, depending on the sampling factors). If the image ends in a partial DCT block that part of the image will be lost, even though it would be possible to include it.

SourceStream and DestStream are source and destination TSream objects that contains jpeg stream.
Transform specifies the required transformation.

GrayScale = True force grayscale output.

CopyMarkes specifies how to copy comments and markers (as IPTC info).

CutRect specifies the rectangle to save when jtCut is specified.

UpdateEXIF: when true ImageEn updates orientation and thumbnail of EXIF tags.

JpegLosslessTransform returns False if it fails.

!!}
function JpegLosslessTransformStream(SourceStream, DestStream: TStream; Transform: TIEJpegTransform; GrayScale: boolean; CopyMarkers: TIEJpegCopyMarkers; CutRect: TRect; UpdateEXIF:boolean): boolean;
var
  xp: TProgressRec;
  ab: boolean;
begin
  ab := false;
  xp.Aborting := @ab;
  IEJpegLosslessTransform(SourceStream, DestStream, xp, integer(Transform), GrayScale, integer(CopyMarkers), CutRect, UpdateEXIF);
  result := not ab;
end;

{!!
<FS>JpegLosslessTransform

<FM>Declaration<FC>
function JpegLosslessTransform(const SourceFile, DestFile: WideString; Transform: <A TIEJpegTransform>; GrayScale:boolean; CopyMarkers:<A TIEJpegCopyMarkers>; CutRect:Trect, UpdateEXIF:boolean=false):boolean;
function JpegLosslessTransform(const SourceFile, DestFile: WideString; Transform: <A TIEJpegTransform>): boolean; overload;

<FM>Description<FN>
JpegLosslessTransform performs various useful transformations of Jpeg files. JpegLosslessTransform works by rearranging the compressed data, without ever fully decoding the image. Therefore, its transformations are lossless: there is no image degradation at all.

The resulting image will contain at least the CutRect region (constrained to the image size), and may be larger to round up to the nearest DCT block boundary (or multiple thereof, depending on the sampling factors). If the image ends in a partial DCT block that part of the image will be lost, even though it would be possible to include it.

SourceFile and DestFile are file path of source and destination Jpeg files.
Transform specifies the required transformation.

GrayScale = True force grayscale output.

CopyMarkes specifies how to copy comments and markers (as IPTC info).

CutRect specifies the rectangle to save when jtCut is specified.

UpdateEXIF: when true ImageEn updates orientation and thumbnail of EXIF tags.

JpegLosslessTransform returns False if it fails.

<FM>Example<FC>
uses ImageEnIO;
..
JpegLosslessTransform('input.jpg','output.jpg',jtRotate90,false,jcCopyAll,Rect(0,0,0,0));
!!}
function JpegLosslessTransform(const SourceFile, DestFile: WideString; Transform: TIEJpegTransform; GrayScale: boolean; CopyMarkers: TIEJpegCopyMarkers; CutRect: TRect; UpdateEXIF:boolean): boolean;
var
  fr, fw: TIEWideFileStream;
begin
  try
    fr := TIEWideFileStream.Create(SourceFile, fmOpenRead or fmShareDenyWrite);
  except
    result := false;
    exit;
  end;
  try
    fw := TIEWideFileStream.Create(DestFile, fmCreate);
  except
    FreeAndNil(fr);
    result := false;
    exit;
  end;
  result := JpegLosslessTransformStream(fr, fw, Transform, GrayScale, CopyMarkers, CutRect, UpdateEXIF);
  FreeAndNil(fw);
  FreeAndNil(fr);
end;

function JpegLosslessTransform(const SourceFile, DestFile: WideString; Transform: TIEJpegTransform): boolean; overload;
begin
  result:=JpegLosslessTransform(SourceFile,DestFile,Transform,false,jcCopyAll,Rect(0,0,0,0),true);
end;

{!!
<FS>JpegLosslessTransform2

<FM>Declaration<FC>
function JpegLosslessTransform2(const FileName: WideString; Transform: <A TIEJpegTransform>; GrayScale: boolean; CopyMarkers: <A TIEJpegCopyMarkers>; CutRect: TRect; UpdateEXIF:boolean): boolean;

<FM>Description<FN>
This functions is like <A JpegLosslessTransform>, but get only one FileName which is both input and output.
!!}
function JpegLosslessTransform2(const FileName: WideString; Transform: TIEJpegTransform; GrayScale: boolean; CopyMarkers: TIEJpegCopyMarkers; CutRect: TRect; UpdateEXIF:boolean): boolean;
var
  i:integer;
  SrcFileName:WideString;
begin
  i:=0;
  repeat
    SrcFileName:=FileName+IntToStr(i);
    inc(i);
  until not IEFileExistsW(SrcFileName);
  MoveFileW(PWideChar(FileName), PWideChar(SrcFileName));
  result := JpegLosslessTransform(SrcFileName, FileName, Transform, GrayScale, CopyMarkers, CutRect, UpdateEXIF);
  if not result then
  begin
    if IEFileExistsW(FileName) then
      DeleteFileW(PWideChar(FileName));
    MoveFileW(PWideChar(SrcFileName), PWideChar(FileName));
  end
  else
  DeleteFileW(PWideChar(SrcFileName));
end;


// return frame count
{!!
<FS>TImageEnIO.OpenAVIFile

<FM>Declaration<FC>
function OpenAVIFile(const FileName: WideString):integer;

<FM>Description<FN>
OpenAVIFile opens an AVI file, without reading frames. OpenAVIFile returns the frame count contained in the AVI.
See also <A TImageEnIO.CloseAVIFile>.

<FM>Example<FC>

// saves first AVI frame to 'frame1.jpg', second frame to 'frame2.jpg'

ImageEnView1.IO.OpenAVIFile( 'film.avi' );

ImageEnView1.IO.LoadFromAVI( 0 );
ImageEnView1.IO.SaveToFile('frame1.jpg');

ImageEnView1.IO.LoadFromAVI( 1 );
ImageEnView1.IO.SaveToFile('frame2.jpg');
..
ImageEnView1.IO.CloseAVIFile;
!!}
function TImageEnIO.OpenAVIFile(const FileName: WideString): integer;
var
  psi: TAviStreamInfoW;
begin
  fAborting:=false;
  if fAVI_avf <> nil then
    CloseAVIFile;
  result := 0;
  fParams.fAVI_FrameCount := 0;
  try
    fParams.fFileName := FileName;
    fParams.FileType := ioUnknown;
    if not gAVIFILEinit then
    begin
      AVIFileInit;
      gAVIFILEinit := true;
    end;
    if AVIFileOpenW(PAVIFILE(fAVI_avf), PWideChar(FileName), OF_READ, nil) <> 0 then
    begin
      fAborting := True;
      exit;
    end;
    if AVIFileGetStream(PAVIFILE(fAVI_avf), PAVISTREAM(fAVI_avs), streamtypeVIDEO, 0) <> 0 then
    begin
      AVIFileRelease(fAVI_avf);
      fAborting := True;
      exit;
    end;
    if AVIStreamInfoW(PAVISTREAM(fAVI_avs), psi, sizeof(TAVISTREAMINFOW)) <> 0 then
    begin
      AVIFileRelease(fAVI_avf);
      AVIStreamRelease(fAVI_avs);
      fAborting := True;
      exit;
    end;
    move(psi, fAVI_psi, sizeof(TAviStreamInfoW_Ex));
    fAVI_gf := AVIStreamGetFrameOpen(fAVI_avs, nil);
    if fAVI_gf = nil then
    begin
      AVIFileRelease(fAVI_avf);
      AVIStreamRelease(fAVI_avs);
      fAborting := True;
      exit;
    end;
    result := fAVI_psi.dwLength;
    fParams.fAVI_FrameCount := fAVI_psi.dwLength;
    fParams.fAVI_FrameDelayTime := trunc(1000 / (fAVI_psi.dwRate/fAVI_psi.dwScale));
  finally
    if fAborting then
    begin
      fAVI_avf := nil;
      fAVI_avs := nil;
      fAVI_gf := nil;
    end;
  end;
end;

{!!
<FS>TImageEnIO.CloseAVIFile

<FM>Declaration<FC>
procedure CloseAVIFile;

<FM>Description<FN>
CloseAVIFile closes the AVI file opened with <A TImageEnIO.OpenAVIFile> or <A TImageEnIO.CreateAVIFile>.

<FM>Example<FC>

// saves first AVI frame to 'frame1.jpg', second frame to 'frame2.jpg'

ImageEnView1.IO.OpenAVIFile( 'film.avi' );

ImageEnView1.IO.LoadFromAVI( 0 );
ImageEnView1.IO.SaveToFile('frame1.jpg');

ImageEnView1.IO.LoadFromAVI( 1 );
ImageEnView1.IO.SaveToFile('frame2.jpg');
..
ImageEnView1.IO.CloseAVIFile;
!!}
procedure TImageEnIO.CloseAVIFile;
begin
  if fAVI_avs1 <> nil then
  begin
    // save
    AVISaveOptionsFree(1, PAVICOMPRESSOPTIONS(fAVI_popts));
    freemem(fAVI_popts);
    if fAVI_avs<>nil then
      AVIStreamRelease(fAVI_avs);
    AVIStreamRelease(fAVI_avs1);
    AVIFileRelease(fAVI_avf);
    fAVI_popts := nil;
    fAVI_avs := nil;
    fAVI_avs1 := nil;
    fAVI_avf := nil;
  end
  else
  begin
    // load
    if fAVI_avf = nil then
      exit;
    AVIStreamGetFrameClose(fAVI_gf);
    AVIStreamRelease(fAVI_avs);
    AVIFileRelease(fAVI_avf);
    fAVI_avf := nil;
    fAVI_avs := nil;
    fAVI_gf := nil;
  end;
end;

{!!
<FS>TImageEnIO.IsOpenAVI

<FM>Declaration<FC>
function IsOpenAVI:boolean;

<FM>Description<FN>
Returns True when <A TImageEnIO.OpenAVIFile> has currently open a file.

!!}
function TImageEnIO.IsOpenAVI:boolean;
begin
  result:= (fAVI_avf<>nil) and (fAVI_avs<>nil) and (fAVI_gf<>nil);
end;


{!!
<FS>TImageEnIO.LoadFromAVI

<FM>Declaration<FC>
procedure LoadFromAVI(FrameIndex:integer);

<FM>Description<FN>
LoadFromAVI read the FrameIndex frame opened with the <A TImageEnIO.OpenAVIFile> method.

<FM>Example<FC>

// saves first AVI frame to 'frame1.jpg', second frame to 'frame2.jpg'

ImageEnView1.IO.OpenAVIFile( 'film.avi' );

ImageEnView1.IO.LoadFromAVI( 0 );
ImageEnView1.IO.SaveToFile('frame1.jpg');

ImageEnView1.IO.LoadFromAVI( 1 );
ImageEnView1.IO.SaveToFile('frame2.jpg');
..
ImageEnView1.IO.CloseAVIFile;
!!}
procedure TImageEnIO.LoadFromAVI(FrameIndex: integer);
var
  pt: pointer;
  bitcount: integer;
  dib: TIEDibBitmap;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveIndex(self, LoadFromAVI, FrameIndex);
    exit;
  end;
  try
    fAborting := false;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fAVI_avf = nil) or (fAVI_avs = nil) or (fAVI_gf = nil) then
      exit;
    if dword(FrameIndex) >= fAVI_psi.dwLength then
      exit;
    pt := AVIStreamGetFrame(fAVI_gf, FrameIndex);
    fParams.fAVI_FrameCount := fAVI_psi.dwLength;
    fParams.fAVI_FrameDelayTime := trunc(1000 / (fAVI_psi.dwRate/fAVI_psi.dwScale));
    dib := TIEDibBitmap.create;
    if pt <> nil then
    begin
      bitcount := _IECopyDIB2Bitmap2Ex(int64(DWORD(pt)), dib, nil, true); // uses drawdibdraw
      fIEBitmap.CopyFromTDibBitmap(dib);
      case BitCount of
        1:
          begin
            fParams.BitsPerSample := 1;
            fParams.SamplesPerPixel := 1;
          end;
        4:
          begin
            fParams.BitsPerSample := 4;
            fParams.SamplesPerPixel := 1;
          end;
        8:
          begin
            fParams.BitsPerSample := 8;
            fParams.SamplesPerPixel := 1;
          end;
        15:
          begin
            fParams.BitsPerSample := 5;
            fParams.SamplesPerPixel := 3;
          end;
        16, 24, 32:
          begin
            fParams.BitsPerSample := 8;
            fParams.SamplesPerPixel := 3;
          end;
      end;
      fParams.DpiX := gDefaultDPIX;
      fParams.DpiY := gDefaultDPIY;
      fParams.Width := dib.Width;
      fParams.Height := dib.Height;
      fParams.OriginalWidth := dib.Width;
      fParams.OriginalHeight := dib.Height;
      fParams.FreeColorMap;
      Update;
    end;
    FreeAndNil(dib);
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.CreateAVIFile

<FM>Declaration<FC>
function CreateAVIFile(const FileName: WideString; rate:integer; const codec:AnsiString):TIECreateAVIFileResult;

<FM>Description<FN>
CreateAVIFile creates a new AVI file using FileName file name.

The rate parameter specifies the number of frames per second.
codec specifies the compression codec to use (must be installed on system) as four characters length string.
For example:
'cvid' : cinepak by Radius
'msvc' : Microsoft Video 1
'mp42' : Microsoft MPEG4 V2
more codecs at http://www.fourcc.org or http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnwmt/html/registeredfourcccodesandwaveformats.asp (or at msdn.microsoft.com searching for registered fourcc codes and wave formats).

You can save each frame to the created AVI file using the <A TImageEnIO.SaveToAVI> method.
Finally, call <A TImageEnIO.CloseAVIFile> to close the file.

<FM>Example<FC>
ImageEnView.IO.CreateAVIFile('output.avi', 20, 'DIB ');
// save frame 0
ImageEnView.IO.LoadFromFile('frame0.jpg');
ImageEnView.IO.Params.BitsPerSample:=8;
ImageEnView.IO.Params.SamplesPerPixel:=1;
ImageEnView.IO.SaveToAVI;
// save frame 1
ImageEnView.IO.LoadFromFile('frame1.jpg');
ImageEnView.IO.Params.BitsPerSample:=8;
ImageEnView.IO.Params.SamplesPerPixel:=1;
ImageEnView.IO.SaveToAVI;
// close the file
ImageEnView.IO.CloseAVIFile;
!!}
function TImageEnIO.CreateAVIFile(const FileName:WideString; rate:integer; const codec:AnsiString):TIECreateAVIFileResult;
var
  psi: TAviStreamInfoW;
  hr:HResult;
begin
  fAborting := False;
  if not gAVIFILEinit then
  begin
    AVIFileInit;
    gAVIFILEinit := true;
  end;
  if IEFileExistsW(FileName) then
    DeleteFileW(PWideChar(FileName));
  if AVIFileOpenW(PAVIFILE(fAVI_avf), PWideChar(FileName), OF_WRITE or OF_CREATE, nil) <> 0 then
    raise EInvalidGraphic.Create('unable to create AVI file');
  zeromemory(@psi, sizeof(psi));
  psi.fccType := streamtypeVIDEO;
  psi.dwScale := 1;
  psi.dwRate := rate;
  psi.dwQuality := $FFFFFFFF;
  fAVI_popts := allocmem(sizeof(TAVICOMPRESSOPTIONS));
  if (fParams.BitsPerSample = 8) and (fParams.SamplesPerPixel = 1) then
    psi.dwSuggestedBufferSize := IEBitmapRowLen(fParams.Width, 8, 32) * fParams.Height
  else
    psi.dwSuggestedBufferSize := IEBitmapRowLen(fParams.Width, 24, 32) * fParams.Height;
  psi.rcFrame := rect(0, 0, fParams.Width, fParams.Height);
  AVIFileCreateStreamW(PAVIFILE(fAVI_avf), PAVISTREAM(fAVI_avs1), psi);

  if codec = '' then
  begin
    if not AVISaveOptions(0, 0, 1, @fAVI_avs1, @fAVI_popts) then
    begin
      AVIStreamRelease(fAVI_avs1);
      fAVI_avs1 := nil;
      AVIFileRelease(fAVI_avf);
      fAVI_avf := nil;
      freemem(fAVI_popts);
      fAborting := True;
      result := ieaviNOCOMPRESSOR;
      exit; // EXIT POINT
    end;
  end
  else
  begin
    PAVICOMPRESSOPTIONS(fAVI_popts)^.fccType := streamtypeVIDEO;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.fccHandler := pinteger(PAnsiChar(codec))^;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.dwKeyFrameEvery := 0;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.dwQuality := $FFFFFFFF;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.dwBytesPerSecond := 0;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.dwFlags := 0;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.lpFormat := nil;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.cbFormat := 0;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.lpParms := nil;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.cbParms := 0;
    PAVICOMPRESSOPTIONS(fAVI_popts)^.dwInterleaveEvery := 0;
  end;
  hr := AVIMakeCompressedStream(PAVISTREAM(fAVI_avs), PAVISTREAM(fAVI_avs1), fAVI_popts, nil);

  if hr = AVIERR_NOCOMPRESSOR then
    result := ieaviNOCOMPRESSOR
  else if hr = AVIERR_MEMORY then
    result := ieaviMEMORY
  else if hr = AVIERR_UNSUPPORTED then
    result := ieaviUNSUPPORTED
  else
    result := ieaviOK;

  fAborting := result <> ieaviOK;

  fAVI_idx := 0;
end;

{!!
<FS>TImageEnIO.SaveToAVI

<FM>Declaration<FC>
procedure SaveToAVI;

<FM>Description<FN>
SaveToAVI saves the image to the current open AVI file (open using <A TImageEnIO.CreateAVIFile>).
We suggest setting <A TImageEnIO.Params>.<A TIOParamsVals.BitsPerSample> and Params.<A TIOParamsVals.SamplesPerPixel> before calling <A TImageEnIO.SaveToAVI>, because AVI requires all images have same color depth.

<FM>Example<FC>
ImageEnView.IO.CreateAVIFile('output.avi', 20, 'DIB ');
// save frame 0
ImageEnView.IO.LoadFromFile('frame0.jpg');
ImageEnView.IO.Params.BitsPerSample:=8;
ImageEnView.IO.Params.SamplesPerPixel:=1;
ImageEnView.IO.SaveToAVI;
// save frame 1
ImageEnView.IO.LoadFromFile('frame1.jpg');
ImageEnView.IO.Params.BitsPerSample:=8;
ImageEnView.IO.Params.SamplesPerPixel:=1;
ImageEnView.IO.SaveToAVI;
// close the file
ImageEnView.IO.CloseAVIFile;

!!}
procedure TImageEnIO.SaveToAVI;
type
  TBitmapInfoHeader256Ex = packed record
    biSize: DWORD;
    biWidth: Longint;
    biHeight: Longint;
    biPlanes: Word;
    biBitCount: Word;
    biCompression: DWORD;
    biSizeImage: DWORD;
    biXPelsPerMeter: Longint;
    biYPelsPerMeter: Longint;
    biClrUsed: DWORD;
    biClrImportant: DWORD;
    Palette: array[0..255] of TRGBQUAD;
  end;
  PBitmapInfoHeader256Ex = ^TBitmapInfoHeader256Ex;
var
  he: TBitmapInfoHeader256Ex;
  i: integer;
  sw, sx: integer;
  bmp: TIEBitmap;
begin

  if (fAVI_avs=nil) or (not MakeConsistentBitmap([])) then
    exit;
  if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
    fIEBitmap.PixelFormat := ie24RGB;

  bmp := TIEBitmap.Create;
  bmp.Location := ieMemory;
  bmp.Assign(fIEBitmap);

  // set video format
  he.biSize := sizeof(TBitmapInfoHeader);
  he.biWidth := bmp.Width;
  he.biHeight := bmp.Height;
  he.biPlanes := 1;
  he.biCompression := BI_RGB;
  he.biXPelsPerMeter := 0;
  he.biYPelsPerMeter := 0;
  he.biClrImportant := 0;
  if (fParams.fSamplesPerPixel = 1) and (fParams.fBitsPerSample = 8) then
  begin
    // 256 colors
    he.biClrUsed := 256;
    bmp.PixelFormat := ie8p;
    he.biSizeImage := bmp.RowLen * bmp.Height;
    he.biBitCount := 8;
    for i := 0 to 255 do
    begin
      he.Palette[i].rgbRed := bmp.Palette[i].r;
      he.Palette[i].rgbGreen := bmp.Palette[i].g;
      he.Palette[i].rgbBlue := bmp.Palette[i].b;
      he.Palette[i].rgbReserved := 0;
    end;
    AVIStreamSetFormat(fAVI_avs, fAVI_idx, @he, sizeof(TBITMAPINFOHEADER) + 256 * sizeof(TRGBQUAD));
  end
  else
  if bmp.HasAlphaChannel then // 2.3.1
  begin
    // 32bit RGBA
    bmp.PixelFormat:=ie32RGB;
    bmp.SynchronizeRGBA(false); // alpha to RGBA
    he.biClrUsed := 0;
    he.biBitCount := 32;
    //he.biCompression := IEBI_RGBA;  // <- don't work with it!
    he.biSizeImage := bmp.RowLen * bmp.Height;
    if fAVI_idx = 0 then
      AVIStreamSetFormat(fAVI_avs, 0, @he, sizeof(TBITMAPINFOHEADER));
  end
  else
  begin
    // 24 bit
    he.biClrUsed := 0;
    he.biBitCount := 24;
    he.biSizeImage := bmp.RowLen * bmp.Height;
    if fAVI_idx = 0 then
      AVIStreamSetFormat(fAVI_avs, 0, @he, sizeof(TBITMAPINFOHEADER));
  end;
  sw := 0;
  sx := 0;
  AVIStreamWrite(fAVI_avs, fAVI_idx, 1, bmp.Scanline[bmp.Height - 1], he.biSizeImage, AVIIF_KEYFRAME, @sx, @sw);
  FreeAndNil(bmp);
  inc(fAVI_idx);
end;

{!!
<FS>TImageEnIO.MergeMetaFile

<FM>Declaration<FC>
procedure MergeMetafile(const FileName:WideString; x, y, Width, Height:integer);

<FM>Description<FN>
MergeMetafile loads a metafile and draws it at the x, y position using Width and Height sizes.
If Width or Height is -1 this one is autocalculated.

<FM>Example<FC>

ImageEnView1.io.LoadFromFile('backgroundimage.jpg');
ImageEnView1.io.MergeMetaFile('overimage.wmf',100,100,120,-1);

!!}
// If Width or Height is -1 then it is auto-calculated maintain aspect ratio
// Import... because this is a vectorial image
// Doesn't set IO params
// DON't USE INSIDE A THREAD
procedure TImageEnIO.MergeMetafile(const FileName: WideString; x, y, Width, Height: integer);
const
  MAXDIMS = 16000;
var
  meta: TMetafile;
  dib: TIEDibBitmap;
  dibcanvas: TCanvas;
begin
  try
    fAborting := false;
    if (Width = 0) or (Height = 0) then
      exit;
    if not MakeConsistentBitmap([]) then
      exit;
    meta := tmetafile.create;
    try
      meta.LoadFromFile(FileName);
      if (Width >= 0) or (Height >= 0) then
      begin
        if (Width >= 0) and (Height >= 0) then
        begin
          meta.Width := Width;
          meta.Height := Height;
        end
        else
        begin
          if Width < 0 then
          begin
            meta.Width := (meta.Width * Height) div meta.Height;
            meta.Height := Height;
          end
          else if Height < 0 then
          begin
            meta.Height := (meta.Height * Width) div meta.Width;
            meta.Width := Width;
          end;
        end;
      end;
      if (meta.width = 0) or (meta.height = 0) then
      begin
        fAborting := true;
        exit; // finally will be executed (meta.free)
      end;
      if (meta.width > MAXDIMS) or (meta.height > MAXDIMS) then
      begin
        if meta.Height > meta.Width then
        begin
          meta.Width := (meta.Width * MAXDIMS) div meta.Height;
          meta.Height := MAXDIMS;
        end
        else
        begin
          meta.Height := (meta.Height * MAXDIMS) div meta.Width;
          meta.Width := MAXDIMS;
        end;
      end;
      meta.transparent := true;
      dib := TIEDibBitmap.Create;
      dibcanvas := TCanvas.Create;
      dib.AllocateBits(meta.Width - 1, meta.Height - 1, 24);
      fIEBitmap.CopyToTDibBitmap(dib, x, y, dib.Width, dib.Height);
      dibcanvas.Handle := dib.HDC;
      dibCanvas.Draw(0, 0, meta);
      fIEBitmap.MergeFromTDibBitmap(dib, x, y);
      FreeAndNil(dibcanvas);
      FreeAndNil(dib);
    finally
      FreeAndNil(meta);
    end;
    update;
  finally
    DoFinishWork;
  end;
end;

// doesn't set fParams.fFileType
{$IFDEF IEINCLUDEJPEG2000}

procedure TImageEnIO.LoadFromStreamJ2000(Stream: TStream);
var
  Progress: TProgressRec;
begin
  fAborting := false;
  Progress.Aborting := @fAborting;
  if not MakeConsistentBitmap([]) then
    exit;
  fParams.ResetInfo;
  Progress.fOnProgress := fOnIntProgress;
  Progress.Sender := Self;
  fIEBitmap.RemoveAlphaChannel;
  J2KReadStream(Stream, fIEBitmap, fParams, Progress, False);
  CheckDPI;
  if fAutoAdjustDPI then
    AdjustDPI;
  fParams.fFileName := '';
  SetViewerDPI(fParams.DpiX, fParams.DpiY);
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.LoadFromStreamJP2

<FM>Declaration<FC>
procedure LoadFromStreamJP2(Stream: TStream);

<FM>Description<FN>
LoadFromStreamJP2loads an image from a Jpeg2000 (JP2) stream.
If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.

!!}
procedure TImageEnIO.LoadFromStreamJP2(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamJP2, Stream);
    exit;
  end;
  try
    LoadFromStreamJ2000(Stream);
    fParams.fFileType := ioJP2;
    update;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.LoadFromStreamJ2K

<FM>Declaration<FC>
procedure LoadFromStreamJ2K(Stream: TStream);

<FM>Description<FN>
LoadFromStreamJ2K loads an image from a Jpeg2000 (J2K code stream) stream.
If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.

!!}
procedure TImageEnIO.LoadFromStreamJ2K(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamJ2K, Stream);
    exit;
  end;
  try
    LoadFromStreamJ2000(Stream);
    fParams.fFileType := ioJ2K;
    update;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.LoadFromFileJ2K

<FM>Declaration<FC>
procedure LoadFromFileJ2K(const FileName: WideString);

<FM>Description<FN>
LoadFromFileJ2K loads an image from a Jpeg2000 (J2K code stream) file.
If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.

!!}
procedure TImageEnIO.LoadFromFileJ2K(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileJ2K, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    fAborting := false;
    try
      LoadFromStreamJ2000(fs);
      fParams.fFileName := FileName;
      fParams.fFileType := ioJ2K;
    finally
      FreeAndNil(fs);
    end;
    update;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.LoadFromFileJP2

<FM>Declaration<FC>
procedure LoadFromFileJP2(const FileName: WideString);

<FM>Description<FN>
LoadFromFileJP2 loads an image from a Jpeg2000 (JP2) file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.

!!}
procedure TImageEnIO.LoadFromFileJP2(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileJP2, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    fAborting := false;
    try
      LoadFromStreamJ2000(fs);
      fParams.fFileName := FileName;
      fParams.fFileType := ioJP2;
    finally
      FreeAndNil(fs);
    end;
    update;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

procedure TImageEnIO.SaveToStreamJ2000(Stream: TStream; format: integer);
var
  Progress: TProgressRec;
begin
  fAborting := false;
  Progress.Aborting := @fAborting;
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
    fIEBitmap.PixelFormat := ie24RGB;
  Progress.fOnProgress := fOnIntProgress;
  Progress.Sender := Self;
  J2KWriteStream(Stream, fIEBitmap, fParams, Progress, format);
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.SaveToStreamJP2

<FM>Declaration<FC>
procedure SaveToStreamJP2(Stream: TStream);

<FM>Description<FN>
SaveToStreamJP2 saves the current image as Jpeg2000 (JP2) in the Stream.
!!}
procedure TImageEnIO.SaveToStreamJP2(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamJP2, Stream);
    exit;
  end;
  try
    SaveToStreamJ2000(Stream, 0);
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.SaveToStreamJ2K

<FM>Declaration<FC>
procedure SaveToStreamJ2K(Stream: TStream);

<FM>Description<FN>
SaveToStreamJ2K saves the current image as Jpeg2000 (J2K code stream) in the Stream.
!!}
procedure TImageEnIO.SaveToStreamJ2K(stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamJ2K, Stream);
    exit;
  end;
  try
    SaveToStreamJ2000(Stream, 1);
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.SaveToFileJP2

<FM>Declaration<FC>
procedure SaveToFileJP2(const FileName: WideString);

<FM>Description<FN>
SaveToFileJP2 saves the current image in Jpeg2000 (JP2) format to the FileName file.
FileName is the file name, with extension.
!!}
procedure TImageEnIO.SaveToFileJP2(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileJP2, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      SaveToStreamJ2000(fs, 0);
      fParams.FileName:=FileName;
      fParams.FileType:=ioJP2;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{$IFDEF IEINCLUDEJPEG2000}

{!!
<FS>TImageEnIO.SaveToFileJ2K

<FM>Declaration<FC>
procedure SaveToFileJ2K(const FileName: WideString);

<FM>Description<FN>
SaveToFileJ2K  saves the current image in Jpeg2000 (J2K code stream) format to the FileName file.
FileName is the file name, with extension.
!!}
procedure TImageEnIO.SaveToFileJ2K(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileJ2K, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      SaveToStreamJ2000(fs, 1);
      fParams.FileName:=FileName;
      fParams.FileType:=ioJ2K;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;
{$ENDIF}

{!!
<FS>TImageEnIO.IEBitmap

<FM>Declaration<FC>
property IEBitmap: <A TIEBitmap>

<FM>Description<FN>
IEBitmap contains the attached <A TIEBitmap> object (some value of <A TImageEnIO.AttachedIEBitmap> property).
!!}
procedure TImageEnIO.SetIEBitmap(bmp: TIEBitmap);
begin
  fBitmap := nil;
  if fIEBitmapCreated then
    FreeAndNil(fIEBitmap);
  fIEBitmapCreated := false;
  fIEBitmap := bmp;
end;

{!!
<FS>TImageEnIO.AttachedIEBitmap

<FM>Declaration<FC>
property AttachedIEBitmap: <A TIEBitmap>

<FM>Description<FN>
AttachedIEBitmap contains the attached <A TIEBitmap> object (some value of <A TImageEnIO.IEBitmap> property).

<FM>Example<FC>

// multithread saving
Var
  Bmp:TIEBitmap;
  Io:TImageEnIO;
Begin
  Bmp:=TIEBitmap.Create;
  Io:=TImageEnIO.CreateFromBitmap(bmp);

  Io.LoadFromFile('input.bmp');
  Io.AsyncMode:=True;	// this makes a thread foreach input/output task
  Io.SaveToFile('i1.jpg');	// thread-1
  Io.SaveToFile('i2.jpg');	// thread-2
  Io.SaveToFile('i3.jpg');	// thread-3

  Io.Free;	// free method waits for all tasks end!
  Bmp.Free;
End;
!!}
procedure TImageEnIO.SetAttachedIEBitmap(bmp: TIEBitmap);
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle); // remove previous if exists
  if (not assigned(bmp)) and (assigned(fImageEnView) or assigned(fTImage)) then
    exit; // error
  SetIEBitmap(bmp);
  if assigned(bmp) then
  begin
    fImageEnView := nil;
    fTImage := nil;
  end;
end;

procedure TImageEnIO.SetBitmap(bmp: TBitmap);
begin
  fBitmap := bmp;
  fIEBitmap.EncapsulateTBitmap(fBitmap, true);
end;

{!!
<FS>TImageEnIO.AttachedBitmap

<FM>Declaration<FC>
property AttachedBitmap: TBitmap;

<FM>Description<FN>
Use this property if you want to attach TImageEnIO to a normal TBitmap object.
This property is mutually exclusive with <A TImageEnIO.AttachedTImage> and <A TImageEnIO.AttachedImageEn>.

<FM>Example<FC>

var
  bmp:TBitmap;
Begin
  bmp:=TBitmap.Create;
  ImageEnIO1.AttachedBitmap:= bmp;
  ImageEnIO1.LoadFromFile('alfa.tif');
  ...
End;
!!}
procedure TImageEnIO.SetAttachedBitmap(atBitmap: TBitmap);
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle); // remove previous if exists
  if (not assigned(atBitmap)) and (assigned(fImageEnView) or assigned(fTImage)) then
    exit; // error
  fBitmap := atBitmap;
  if assigned(fBitmap) then
    fIEBitmap.EncapsulateTBitmap(fBitmap, true);
  if assigned(fBitmap) then
  begin
    fImageEnView := nil;
    fTImage := nil;
  end;
end;

{!!
<FS>TImageEnIO.AttachedImageEn

<FM>Declaration<FC>
property AttachedImageEn:<A TIEView>;

<FM>Description<FN>
Use this property if you want to attach a TImageEnIO to a TImageEn, <A TImageEnView> or <A TImageEnDBView> (or any other inherited object) components.
This property is mutually exclusive with <A TImageEnIO.AttachedTImage> and <A TImageEnIO.AttachedBitmap>.
TIEView is the base class of TImageEnView and <A TImageEnMView>.

<FM>Example<FC>

ImageEnIO1.AttachedImageEn := ImageEnView1;
!!}
procedure TImageEnIO.SetAttachedImageEn(atImageEn: TIEView);
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle); // remove previous if exists
  fImageEnView := atImageEn;
  if assigned(fImageEnView) then
  begin // fImageEnView now could be nil
    if fIEBitmapCreated then
    begin
      fIEBitmapCreated := false;
      FreeAndNil(fIEBitmap);
    end;
    fBitmap := fImageEnView.Bitmap;
    fIEBitmap := fImageEnView.IEBitmap;
    if assigned(fIEBitmap) then
      // use TIEBitmap
      fBitmap := nil // both fBitmap and fIEBitmap not allowed
    else
    begin
      // use TBitmap
      fIEBitmapCreated := true;
      fIEBitmap := TIEBitmap.Create;
      fIEBitmap.EncapsulateTBitmap(fBitmap, true);
    end;
    fImageEnView.FreeNotification(self);
    fTImage := nil;
    fImageEnViewBitmapChangeHandle := fImageEnView.RegisterBitmapChangeEvent(OnBitmapChange);
  end
  else
  begin
    fIEBitmap := TIEBitmap.Create;
    fIEBitmapCreated := true; // we create fIEBitmap
  end;
end;

{!!
<FS>TImageEnIO.AttachedTImage

<FM>Declaration<FC>
property AttachedTImage: TImage;

<FM>Description<FN>
Use this property if you want to attach TImageEnIO to a TImage (any other inherited object) component.
This property is mutually exclusive with <A TImageEnIO.AttachedImageEn> and <A TImageEnIO.AttachedBitmap>.

<FM>Example<FC>

ImageEnIO1.AttachedTImage:=Image1;
!!}
procedure TImageEnIO.SetTImage(v: TImage);
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle); // remove previous if exists
  fTImage := v;
  if assigned(fTImage) then
  begin
    fBitmap := fTImage.Picture.Bitmap;
    fIEBitmap.EncapsulateTBitmap(fBitmap, true);
    fTImage.FreeNotification(self);
    fImageEnView := nil;
  end
  else
    fIEBitmap.FreeImage(true);
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEIOThread

{!!
<FS>TImageEnIO.AsyncRunning

<FM>Declaration<FC>
property AsyncRunning:integer;

<FM>Description<FN>
AsyncRunning returns how many threads are running.
See also <A TImageEnIO.AsyncMode>.

<FM>Example<FC>

// multithread saving
Var
  Bmp:TIEBitmap;
  Io:TImageEnIO;
Begin
  Bmp:=TIEBitmap.Create;
  Io:=TImageEnIO.CreateFromBitmap(bmp);

  Io.LoadFromFile('input.bmp');
  Io.AsyncMode:=True;	// this makes a thread foreach input/output task
  Io.SaveToFile('i1.jpg');	// thread-1
  Io.SaveToFile('i2.jpg');	// thread-2
  Io.SaveToFile('i3.jpg');	// thread-3

  // waits all threads finish
  Io.WaitThreads();
..
End;
!!}
function TImageEnIO.GetAsyncRunning: integer;
begin
  EnterCriticalSection(fAsyncThreadsCS);
  result := fAsyncThreads.Count;
  LeaveCriticalSection(fAsyncThreadsCS);
end;

procedure TIEIOThread.Init;
begin
  fThreadList := fOwner.fAsyncThreads;
  EnterCriticalSection(fOwner.fAsyncThreadsCS);
  fThreadList.Add(self);
  Windows.ResetEvent(fOwner.fAsyncThreadsFinishEvent);
  LeaveCriticalSection(fOwner.fAsyncThreadsCS);
  {$ifndef IEHASAFTERCONSTRUCTION}
  // this Delphi version hasn't AfterConstruction. We create threads in suspended mode, then resume
  Resume;
  {$endif}
end;

{$ifdef IEHASAFTERCONSTRUCTION}
const TIEIOTHREAD_STARTMODE = false;  // start in AfterConstruction (don't need Resume)
{$else}
const TIEIOTHREAD_STARTMODE = true;   // start suspended (need Resume)
{$endif}

constructor TIEIOThread.CreateLoadSaveFile(Owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveFile; const in_nf: WideString);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadSaveFile;
  fMethod_LoadSaveFile := InMethod;
  p_nf := in_nf;
  Init;
end;

constructor TIEIOThread.CreateLoadSaveStream(Owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveStream; in_Stream: TStream);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadSaveStream;
  fMethod_LoadSaveStream := InMethod;
  p_stream := in_Stream;
  Init;
end;

constructor TIEIOThread.CreateLoadSaveStreamRetInt(Owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveStreamRetInt; in_Stream: TStream);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadSaveStreamRetInt;
  fMethod_LoadSaveStreamRetInt := InMethod;
  p_stream := in_Stream;
  Init;
end;

constructor TIEIOThread.CreateLoadSaveFileRetInt(Owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveFileRetInt; const in_nf: WideString);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadSaveFileRetInt;
  fMethod_LoadSaveFileRetInt := InMethod;
  p_nf := in_nf;
  Init;
end;

constructor TIEIOThread.CreateRetBool(Owner: TImageEnIO; InMethod: TIEIOMethodType_RetBool);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieRetBool;
  fMethod_RetBool := InMethod;
  Init;
end;

constructor TIEIOThread.CreateLoadSaveFileFormat(Owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveFileFormat; const in_nf: WideString; in_fileformat: TIOFileType);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadSaveFileFormat;
  fMethod_LoadSaveFileFormat := InMethod;
  p_nf := in_nf;
  p_fileformat := in_fileformat;
  Init;
end;

constructor TIEIOThread.CreateLoadSaveStreamFormat(Owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveStreamFormat; in_Stream: TStream; in_fileformat: TIOFileType);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadSaveStreamFormat;
  fMethod_LoadSaveStreamFormat := InMethod;
  p_stream := in_stream;
  p_fileformat := in_fileformat;
  Init;
end;

constructor TIEIOThread.CreateCaptureFromScreen(Owner: TImageEnIO; InMethod: TIEIOMethodType_CaptureFromScreen; in_source: TIECSSource; in_mouseCursor: TCursor);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieCaptureFromScreen;
  fMethod_CaptureFromScreen := InMethod;
  p_source := in_source;
  p_mouseCursor := in_mouseCursor;
  Init;
end;

constructor TIEIOThread.CreateLoadSaveIndex(Owner: TImageEnIO; InMethod: TIEIOMethodType_LoadSaveIndex; in_index: integer);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadSaveIndex;
  fMethod_LoadSaveIndex := InMethod;
  p_index := in_index;
  Init;
end;

constructor TIEIOThread.CreateImportMetaFile(owner: TImageEnIO; InMethod: TIEIOMethodType_ImportMetaFile; const in_nf: WideString; in_width, in_height: integer; in_withalpha: boolean);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieImportMetaFile;
  fMethod_ImportMetaFile := InMethod;
  p_nf := in_nf;
  p_width := in_width;
  p_height := in_height;
  p_withalpha := in_withalpha;
  Init;
end;

constructor TIEIOThread.CreateLoadFromURL(owner:TImageEnIO; InMethod:TIEIOMethodType_LoadFromURL; const in_URL:WideString; dummy:double);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieLoadFromURL;
  fMethod_LoadFromURL := InMethod;
  p_URL := in_URL;
  Init;
end;

constructor TIEIOThread.CreateAcquire(owner: TImageEnIO; InMethod: TIEIOMethodType_Acquire; in_api: TIEAcquireAPI);
begin
  inherited Create(TIEIOTHREAD_STARTMODE);
  fOwner := Owner;
  fMethodType := ieAcquire;
  fMethod_Acquire := InMethod;
  p_api := in_api;
  Init;
end;

procedure TIEIOThread.Execute;
begin
  fThreadID := GetCurrentThreadID;
  try
    case fMethodType of
      ieLoadSaveFile:         fMethod_LoadSaveFile(p_nf);
      ieLoadSaveStream:       fMethod_LoadSaveStream(p_stream);
      ieLoadSaveFileRetInt:   fMethod_LoadSaveFileRetInt(p_nf);
      ieRetBool:              fMethod_RetBool;
      ieLoadSaveStreamRetInt: fMethod_LoadSaveStreamRetInt(p_stream);
      ieLoadSaveFileFormat:   fMethod_LoadSaveFileFormat(p_nf, p_fileformat);
      ieLoadSaveStreamFormat: fMethod_LoadSaveStreamFormat(p_stream, p_FileFormat);
      ieCaptureFromScreen:    fMethod_CaptureFromScreen(p_Source, p_mouseCursor);
      ieLoadSaveIndex:        fMethod_LoadSaveIndex(p_index);
      ieImportMetaFile:       fMethod_ImportMetaFile(p_nf, p_width, p_height, p_withalpha);
      ieLoadFromURL:          fMethod_LoadFromURL(p_URL);
    end;
  except
    fOwner.Aborting := true;
  end;
  FreeOnTerminate := true;
  EnterCriticalSection(fOwner.fAsyncThreadsCS);
  fThreadList.Remove(self);
  if fThreadList.Count = 0 then
    Windows.SetEvent(fOwner.fAsyncThreadsFinishEvent);
  LeaveCriticalSection(fOwner.fAsyncThreadsCS);
end;

// end of TIEIOThread
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>ExtractTIFFImageStream

<FM>Declaration<FC>
procedure ExtractTIFFImageStream(SourceStream, OutStream:TStream; idx:integer);

<FM>Description<FN>

ExtractTIFFImageStream extracts the page idx (starting at 0) from SourceStream and saves it to OutStream.
It doesn't remove the page from source file; also it doesn't decompress the image resulting in a very quick process.

<FM>Example<FC>

// extract first page
fr:=TFileStream.Create('input_multipage.tif',fmOpenRead);
fw:=TFileStream.Create('page0.tif',fmCreate);
ExtractTIFFImageFile( fr , fw, 0 );
fw.free;
fr.free;
!!}
procedure ExtractTIFFImageStream(SourceStream, OutStream: TStream; idx: integer);
begin
  _ExtractTIFFImStream(SourceStream, idx, OutStream);
end;

{!!
<FS>ExtractTIFFImageFile

<FM>Declaration<FC>
procedure ExtractTIFFImageFile(const SourceFileName, OutFileName:WideString; idx:integer);

<FM>Description<FN>
ExtractTIFFImageFile extracts the page idx (starting at 0) from SourceFileName and saves it to OutFileName.
It doesn't remove the page from source file; also it doesn't decompress the image resulting in a very quick process.

<FM>Example<FC>

ExtractTIFFImageFile( 'input_multipage.tif' , 'page0.tif', 0 );	//  extract first page

!!}
procedure ExtractTIFFImageFile(const SourceFileName, OutFileName: WideString; idx: integer);
var
  SourceStream, OutStream: TIEWideFileStream;
begin
  SourceStream := TIEWideFileStream.Create(SourceFileName, fmOpenRead or fmShareDenyWrite);
  OutStream := nil;
  try
    OutStream := TIEWideFileStream.Create(OutFileName, fmCreate);
    _ExtractTIFFImStream(SourceStream, idx, OutStream);
  finally
    FreeAndNil(OutStream);
  end;
  FreeAndNil(SourceStream);
end;

{!!
<FS>InsertTIFFImageStream

<FM>Declaration<FC>
procedure InsertTIFFImageStream(SourceStream,InsertingStream,OutStream:TStream; idx:integer);

<FM>Description<FN>
InsertTIFFImageStream inserts the TIFF stream <FC>InsertingStream<FN> in <FC>SourceStream<FN> saving result in OutStream.
<FC>Idx<FN> is the page where to insert the file.

The two TIFFs must have the same byte order. You can check it reading image parameters and checking <A TIOParamsVals.TIFF_ByteOrder> property.

It is a fast operation because both sources and destination images are uncompressed.
!!}
procedure InsertTIFFImageStream(SourceStream, InsertingStream, OutStream: TStream; idx: integer);
begin
  _InsertTIFFImStream(SourceStream, InsertingStream, idx, OutStream);
end;

{!!
<FS>InsertTIFFImageFile

<FM>Declaration<FC>
procedure InsertTIFFImageFile(const SourceFileName, InsertingFileName, OutFileName:WideString; idx:integer);

<FM>Description<FN>
InsertTIFFImageFile inserts the file <FC>InsertingFileName<FN> in <FC>SourceFileName<FN> saving result in <FC>OutFileName<FN>.

<FC>Idx<FN> is the page where to insert the file.
It is a fast operation because both sources and destination images are uncompressed.

The two TIFFs must have the same byte order. You can check it reading image parameters and checking <A TIOParamsVals.TIFF_ByteOrder> property.

<FM>Example<FC>

// this inserts pagetoinsert.tif in old.tif as first page and save all to new.tif
InsertingTIFFImageFile( 'old.tif' , 'pagetoinsert.tif', 'new.tif', 0 );
!!}
// InsertingFileName is the page to insert
procedure InsertTIFFImageFile(const SourceFileName, InsertingFileName, OutFileName: WideString; idx: integer);
var
  SourceStream, InsertingStream, OutStream: TIEWideFileStream;
begin
  SourceStream := TIEWideFileStream.Create(SourceFileName, fmOpenRead or fmShareDenyWrite);
  InsertingStream := nil;
  OutStream := nil;
  try
    InsertingStream := TIEWideFileStream.Create(InsertingFileName, fmOpenRead or fmShareDenyWrite);
    try
      OutStream := TIEWideFileStream.Create(OutFileName, fmCreate);
      _InsertTIFFImStream(SourceStream, InsertingStream, idx, OutStream);
    finally
      FreeAndNil(OutStream);
    end;
  finally
    FreeAndNil(InsertingStream);
  end;
  FreeAndNil(SourceStream);
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// load from url

type
  HINTERNET = Pointer;
  INTERNET_PORT = Word;
  LPINTERNET_BUFFERS=^INTERNET_BUFFERS;
  INTERNET_BUFFERS = packed record
    dwStructSize:DWORD;
    Next:LPINTERNET_BUFFERS;
    lpcszHeader:PAnsiChar;
    dwHeadersLength:DWORD;
    dwHeadersTotal:DWORD;
    lpvBuffer:pointer;
    dwBufferLength:DWORD;
    dwBufferTotal:DWORD;
    dwOffsetLow:DWORD;
    dwOffsetHigh:DWORD;
  end;


  TInternetCloseHandle = function(hInet: HINTERNET): BOOL; stdcall;
  TInternetOpen = function(lpszAgent: PAnsiChar; dwAccessType: DWORD; lpszProxy, lpszProxyBypass: PAnsiChar; dwFlags: DWORD): HINTERNET; stdcall;
  TInternetConnect = function(hInet: HINTERNET; lpszServerName: PAnsiChar; nServerPort: INTERNET_PORT; lpszUsername: PAnsiChar; lpszPassword: PAnsiChar; dwService: DWORD; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall;
  THttpOpenRequest = function(hConnect: HINTERNET; lpszVerb: PAnsiChar; lpszObjectName: PAnsiChar; lpszVersion: PAnsiChar; lpszReferrer: PAnsiChar; lplpszAcceptTypes: PAnsiChar; dwFlags: DWORD; dwContext: DWORD): HINTERNET; stdcall;
  THttpSendRequest = function(hRequest: HINTERNET; lpszHeaders: PAnsiChar; dwHeadersLength: DWORD; lpOptional: Pointer; dwOptionalLength: DWORD): BOOL; stdcall;
  TInternetReadFile = function(hFile: HINTERNET; lpBuffer: Pointer; dwNumberOfBytesToRead: DWORD; var lpdwNumberOfBytesRead: DWORD): BOOL; stdcall;
  TInternetReadFileEx = function(hFile: HINTERNET; lpBuffersOut:LPINTERNET_BUFFERS; dwFlags:DWORD; dwContext:DWORD): BOOL; stdcall;
  THttpQueryInfo = function(hRequest:HINTERNET; dwInfoLevel:DWORD; lpvBuffer:pointer; lpdwBufferLength:PDWORD; lpdwIndex:PDWORD):BOOL; stdcall;
  TInternetQueryOption = function(hInternet:HINTERNET; dwOption:DWORD; lpBuffer:pointer; var lpdwBufferLength:DWORD):BOOL; stdcall;
  TInternetSetOption = function(hInternet:HINTERNET; dwOption:DWORD; lpBuffer:pointer; dwBufferLength:DWORD):BOOL; stdcall;
  TInternetGetLastResponseInfo = function(lpdwError:PDWORD; lpszBuffer:PAnsiChar; lpdwBufferLength:PDWORD):BOOL; stdcall;
  TFtpOpenFile = function(hConnect:HINTERNET; lpszFileName:PAnsiChar; dwAccess:DWORD; dwFlags:DWORD; dwContext:PDWORD):HINTERNET; stdcall;



const
  INTERNET_OPEN_TYPE_DIRECT = 1;
  INTERNET_SERVICE_FTP  = 1;
  INTERNET_SERVICE_HTTP = 3;
  INTERNET_OPEN_TYPE_PROXY = 3;
  INTERNET_FLAG_NO_CACHE_WRITE = $04000000;
  INTERNET_FLAG_DONT_CACHE = INTERNET_FLAG_NO_CACHE_WRITE;
  INTERNET_FLAG_KEEP_CONNECTION = $00400000;
  INTERNET_FLAG_RELOAD = $80000000;
  HTTP_QUERY_CONTENT_LENGTH = 5;
  IRF_NO_WAIT = 8;
  INTERNET_FLAG_ASYNC=$10000000;
  INTERNET_FLAG_SECURE=$00800000;
  INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP   =$00008000; // ex: https:// to http://
  INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS  =$00004000; // ex: http:// to https://
  INTERNET_FLAG_IGNORE_CERT_DATE_INVALID  =$00002000; // expired X509 Cert.
  INTERNET_FLAG_IGNORE_CERT_CN_INVALID    =$00001000; // bad common name in X509 Cert.
  INTERNET_OPEN_TYPE_PRECONFIG = 0;
  INTERNET_FLAG_NO_AUTH           =$00040000;
  INTERNET_OPTION_SECURITY_FLAGS          =31;
  SECURITY_FLAG_IGNORE_REVOCATION         =$00000080;
  SECURITY_FLAG_IGNORE_UNKNOWN_CA         =$00000100;
  SECURITY_FLAG_IGNORE_WRONG_USAGE        =$00000200;
  HTTP_QUERY_CONTENT_TYPE = 1;
  FTP_TRANSFER_TYPE_BINARY    = $00000002;


var
  wininet: THandle;
  InternetOpen: TInternetOpen;
  InternetCloseHandle: TInternetCloseHandle;
  InternetConnect: TInternetConnect;
  HttpOpenRequest: THttpOpenRequest;
  HttpSendRequest: THttpSendRequest;
  HttpQueryInfo: THttpQueryInfo;
  InternetReadFile: TInternetReadFile;
  InternetReadFileEx: TInternetReadFileEx;
  InternetQueryOption: TInternetQueryOption;
  InternetSetOption: TInternetSetOption;
  InternetGetLastResponseInfo: TInternetGetLastResponseInfo;
  FtpOpenFile : TFtpOpenFile;

procedure IEInitWinINet;
begin
  if wininet = 0 then
  begin
    // try to load the wininet.dll dynamic library
    wininet := LoadLibrary('wininet.dll');
    if wininet <> 0 then
    begin
      InternetOpen := GetProcAddress(wininet, 'InternetOpenA');
      InternetCloseHandle := GetProcAddress(wininet, 'InternetCloseHandle');
      InternetConnect := GetProcAddress(wininet, 'InternetConnectA');
      HttpOpenRequest := GetProcAddress(wininet, 'HttpOpenRequestA');
      HttpSendRequest := GetProcAddress(wininet, 'HttpSendRequestA');
      HttpQueryInfo := GetProcAddress(wininet, 'HttpQueryInfoA');
      InternetReadFile := GetProcAddress(wininet, 'InternetReadFile');
      InternetReadFileEx := GetProcAddress(wininet, 'InternetReadFileExA');
      InternetQueryOption := GetProcAddress(wininet, 'InternetQueryOptionA');
      InternetSetOption := GetProcAddress(wininet, 'InternetSetOptionA');
      InternetGetLastResponseInfo := GetProcAddress(wininet, 'InternetGetLastResponseInfoA');
      FtpOpenFile :=GetProcAddress(wininet, 'FtpOpenFileA');
     end;
  end;
end;

procedure IEFreeWinINet;
begin
  if wininet <> 0 then
  begin
    FreeLibrary(wininet);
    wininet:=0;
  end;
end;


// URL: 'http://domain[:port]/resource'  (example 'http://www.hicomponents.com/test.jpg' )
// URL: 'https://domain[:port]/resource'
// URL: 'ftp://user:password@domain[:port]/resource' (example 'ftp://user:password@ftp.hicomponents.com/Pictures/test.jpg')
// ProxyAddress: 'domain:port' (example '10.2.7.2:8080' )
function IEGetFromURL(const URL:WideString; OutStream:TStream; const ProxyAddress:WideString; const ProxyUser:WideString; const ProxyPassword:WideString; OnProgress: TIEProgressEvent; Sender: TObject; Aborting:pboolean; var FileExt:string):boolean;
var
  hint: HINTERNET;
  hcon: HINTERNET;
  hreq: HINTERNET;
  buf: PAnsiChar;
  Host, Page: AnsiString;
  Port, i, j: integer;
  ib: INTERNET_BUFFERS;
  t1: dword;
  ConnType:TIEURLType;
  Service:dword;
  flags:cardinal;
  OptionsBuffer,OptionsBufferLen:DWORD;
  bx: cardinal;
  filetype:AnsiString;
  userid,password:AnsiString;
  AURL:AnsiString;

  //
  procedure FreeHandles;
  begin
    if hreq <> nil then
      InternetCloseHandle(hreq);
    if hcon <> nil then
      InternetCloseHandle(hcon);
    if hint <> nil then
      internetCloseHandle(hint);
  end;
begin

  result := false;

  ConnType := IEGetURLTypeW(URL);
  AURL := AnsiString(URL);

  // remove protocol part and set service type
  case ConnType of
    ieurlHTTP:
      begin
        delete(AURL, 1, 7);
        Service:=INTERNET_SERVICE_HTTP;
      end;
    ieurlHTTPS:
      begin
        delete(AURL, 1, 8);
        Service:=INTERNET_SERVICE_HTTP;
      end;
    ieurlFTP:
      begin
        delete(AURL, 1, 6);
        Service:=INTERNET_SERVICE_FTP;
      end;
    else
      exit;
  end;

  userid:='';
  password:='';

  // extract userid/password, Host, Port and Resource (Page)
  i := IEPos('/', AURL);
  if i < 1 then
    exit;
  Host := IECopy(AURL, 1, i - 1);
  Page := IECopy(AURL, i, length(AURL));
  Port := 0;
  i := IEPos('@', Host);
  if i > 0 then
  begin
    // userid/password
    j:=IEPos(':',Host);
    if j=0 then
      exit;
    userid:=IECopy(Host,1,j-1);
    password:=IECopy(Host,j+1,i-j-1);
    Host:=IECopy(Host,i+1,length(Host));
  end;
  i := IEPos(':', Host);
  if i > 0 then
  begin
    Port := IEStrToIntDef(IECopy(Host, i + 1, length(Host)), 80);
    Host := IECopy(Host, 1, i - 1);
  end
  else
  begin
    // default port
    case ConnType of
      ieurlHTTP: Port:=80;
      ieurlHTTPS: Port:=443;
      ieurlFTP: Port:=21;
    end;
  end;

  hreq := nil;
  hcon := nil;
  hint := nil;
  buf:=nil;

  try

    if ProxyAddress = '' then
    begin
      hint := InternetOpen('Mozilla/4.*', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
      hcon := InternetConnect(hint, PAnsiChar(AnsiString(Host)), Port, PAnsiChar(AnsiString(userid)), PAnsiChar(AnsiString(password)), Service, 0, 0);
    end
    else
    begin
      hint := InternetOpen('Mozilla/4.*', INTERNET_OPEN_TYPE_PROXY, PAnsiChar(AnsiString(ProxyAddress)), nil, 0);
      hcon := InternetConnect(hint, PAnsiChar(AnsiString(Host)), Port, PAnsiChar(AnsiString(ProxyUser)), PAnsiChar(AnsiString(ProxyPassword)), Service, 0, 0);
    end;

    if hcon = nil then
      exit;

    if (ConnType=ieurlHTTP) or (ConnType=ieurlHTTPS) then
    begin

      flags:=INTERNET_FLAG_DONT_CACHE or INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_RELOAD;
      if ConnType=ieurlHTTPS then
        flags:=flags or INTERNET_FLAG_SECURE or INTERNET_FLAG_IGNORE_CERT_CN_INVALID or INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP or
                        INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID;
      hreq := HttpOpenRequest(hcon, 'GET', PAnsiChar(AnsiString(Page)), 'HTTP/1.1', nil, nil, flags, 0);
      if hreq = nil then
        exit;

      OptionsBufferLen:=sizeof(OptionsBuffer);
      InternetQueryOption(hreq,INTERNET_OPTION_SECURITY_FLAGS,@OptionsBuffer,OptionsBufferLen);
      OptionsBuffer:=OptionsBuffer or SECURITY_FLAG_IGNORE_UNKNOWN_CA or SECURITY_FLAG_IGNORE_REVOCATION or SECURITY_FLAG_IGNORE_WRONG_USAGE;
      InternetSetOption(hreq,INTERNET_OPTION_SECURITY_FLAGS,@OptionsBuffer,sizeof(OptionsBuffer));

      getmem(buf, 65536);

      HttpSendRequest(hreq, nil, 0, nil, 0);

      // get file type
      fileExt:='';
      t1:=65536;
      if HttpQueryInfo(hreq,HTTP_QUERY_CONTENT_TYPE,buf,@t1,nil) then
      begin
        PAnsiChar(buf)[t1]:=#0;
        fileType:=StrPas(PAnsiChar(buf));
        t1:=IEPos('/',fileType);
        if t1>0 then
          fileExt:=string(IECopy(fileType,t1+1,length(fileType)));
      end;

      // get file length
      t1:=65536;
      if HttpQueryInfo(hreq,HTTP_QUERY_CONTENT_LENGTH,buf,@t1,nil) then
      begin
        PAnsiChar(buf)[t1]:=#0;
        t1:=IEStrToIntDef(PAnsiChar(buf),0); // 2.3.2
      end
      else
        t1:=0;

    end
    else if (ConnType=ieurlFTP) then
    begin

      Page:=IECopy(Page,2,length(Page));

      hreq:=FtpOpenFile(hcon,PAnsiChar(Page),GENERIC_READ,FTP_TRANSFER_TYPE_BINARY,nil);
      if hreq = nil then
        exit;

      fileExt:=string(IECopy(IEExtractFileExtA(Page),2,10));
      t1:=0;
      getmem(buf, 65536);

    end;

    if t1<>0 then
    begin
      // we know the size, can load in async mode
      fillchar(ib,sizeof(ib),0);
      ib.dwStructSize:=sizeof(ib);
      repeat
        ib.lpvBuffer:=buf;
        ib.dwBufferLength:=65536;
        if not InternetReadFileEx(hreq,@ib,IRF_NO_WAIT,0) then
          break;
        if ib.dwBufferLength=0 then
          break
        else
        begin
          OutStream.Write(pbyte(ib.lpvBuffer)^,ib.dwBufferLength);
          if assigned(OnProgress) then
            OnProgress(Sender, trunc(100 / t1 * OutStream.Size));
        end;
      until (dword(OutStream.Size)>=t1) or (assigned(Aborting) and Aborting^);
    end
    else
    begin
      // sync mode
      repeat
        InternetReadFile(hreq, buf, 1024, bx);
        OutStream.Write(buf^, bx);
      until (bx = 0) or (assigned(Aborting) and Aborting^);
    end;

  finally
    if buf<>nil then
      freemem(buf);
    FreeHandles;
  end;

  result:=true;
end;


{!!
<FS>TImageEnIO.LoadFromURL

<FM>Declaration<FC>
procedure LoadFromURL(const URL:WideString);

<FM>Description<FN>
LoadFromURL loads the image from the network using the HTTP or FTP protocol, specifing the URL.
This function doesn't support password authentication for HTTP, while it is necessary for FTP (also conntecting to anonymous server).

URL must have the syntax:
'http://domain[:port]/resource'
'https://domain[:port]/resource'
'ftp://user:password@domain[:port]/resource'

It is possible to set proxy parameters using <A TImageEnIO.ProxyAddress>, <A TImageEnIO.ProxyUser> and <A TImageEnIO.ProxyPassword> properties.

<FM>Example<FC>
// load from standard port 80
ImageEnView.IO.LoadFromURL('http://www.hicomponents.com/image.jpg');

// load from port 8080
ImageEnView.IO.LoadFromURL('http://www.hicomponents.com:8080/image.jpg');

// load from FTP
ImageEnView.IO.LoadFromURL('ftp://space:shuttle@ftp.hicomponents.com/Pictures/test.jpg')

!!}
procedure TImageEnIO.LoadFromURL(const URL:WideString);
var
  ms:TMemoryStream;
  FileExt:string;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadFromURL(self, LoadFromURL, URL, 0);
    exit;
  end;

  ms:=TMemoryStream.Create;

  try

  if not IEGetFromURL(URL,ms,fProxyAddress,fProxyUser,fProxyPassword,fOnIntProgress,self,@fAborting,FileExt) then
  begin
    fAborting:=true;
    DoFinishWork;
  end
  else
  begin
    ms.Position := 0;
    LoadFromStream(ms); // this do other works, as IEBitmap sync, OnFinishWork, Update
  end;

  finally
    FreeAndNil(ms);
  end;
end;

// load from url
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnIO.DoAcquireBitmap(ABitmap: TIEBitmap; var Handled: boolean);
begin
  if assigned(fOnAcquireBitmap) then
    fOnAcquireBitmap(self, ABitmap, Handled);
end;

procedure TImageEnIO.TWMultiCallBack(Bitmap: TIEBitmap; var IOParams: TObject);
var
  bHandled: boolean; // Flag indicating whether the user has handled the acquired bitmap themselves
begin
  if not MakeConsistentBitmap([]) then
    exit;
  bHandled := false;
  DoAcquireBitmap(Bitmap, bHandled);
  if not bHandled then
  begin
    IOParams := fParams;
    fIEBitmap.Assign(Bitmap);
    if fAutoAdjustDPI then
      AdjustDPI;
    Update;
  end;
end;

procedure TImageEnIO.TWCloseCallBack;
begin
  fgrec := nil;
end;

{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnIO.AcquireOpen

<FM>Declaration<FC>
function AcquireOpen:boolean;

<FM>Description<FN>
AcquireOpen opens a connection to the selected scanner. It is useful to do a modeless acquisition.
AcquireOpen returns False if it fails.
Whenever ImageEn gets an image, the <A TImageEnIO.OnAcquireBitmap> event occurs.

See also <A TImageEnIO.AcquireClose>.

<FM>Example<FC>

ImageEnIO.AcquireOpen;
..
ImageEnIO.AcquireClose;

!!}
function TImageEnIO.AcquireOpen: boolean;
begin
  if (not assigned(fgrec)) and assigned(fImageEnView) then
  begin
    fAborting := false;
    fTWainParams.FreeResources;
    fTWainParams.LastError := 0;
    fTWainParams.LastErrorStr := '';
    fgrec := IETWAINAcquireOpen(TWCloseCallBack, TWMultiCallBack, fTWainParams, @fTWainParams.TWainShared, fParams, fImageEnView, NativePixelFormat);
    result := fgrec <> nil;
  end
  else
    result := false;
end;
{$ENDIF}

{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnIO.AcquireClose

<FM>Declaration<FC>
procedure AcquireClose;

<FM>Description<FN>
AcquireClose closes a connection opened with <A TImageEnIO.AcquireOpen>. It is useful to do a modeless acquisition.
Whenever ImageEn gets an image the <A TImageEnIO.OnAcquireBitmap> event occurs.

<FM>Example<FC>

ImageEnIO.AcquireOpen;
..
ImageEnIO.AcquireClose;

!!}
procedure TImageEnIO.AcquireClose;
begin
  if fgrec <> nil then
  begin
    IETWAINAcquireClose(fgrec);
    fgrec := nil;
  end;
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

(*$ifdef IEINCLUDESANE*)

constructor TIESANEParams.Create(Owner: TComponent);
begin
  inherited Create;
  fOwner := Owner;
  fSaneDevices := nil;
  fSelectedSource := 0;
  fSaneOptionDescriptors := nil;
  SetDefaultParams;
end;

destructor TIESANEParams.Destroy;
begin
  inherited;
end;

procedure TIESANEParams.SetDefaultParams;
begin
  fBitDepth := 8;
  fColorMode := ieColor;
  fXResolution := 150;
  fYResolution := 150;
end;

procedure TIESANEParams.Assign(Source: TIESANEParams);
begin
end;

procedure TIESANEParams.SetResolution(Value: integer);
begin
  fXResolution := Value;
  fYResolution := Value;
end;

function TIESANEParams.SelectSourceByName(const sn: AnsiString): boolean;
var
  sd: PPSANE_Device;
  i: integer;
begin
  result := false;
  FillSourceListData;
  if fSaneDevices <> nil then
  begin
    sd := fSaneDevices;
    i := 0;
    while sd^ <> nil do
    begin
      if IEUpperCase(sd^^.name) = IEUpperCase(sn) then
      begin
        fSelectedSource := i;
        break;
      end;
      inc(sd);
      inc(i);
    end;
  end;
end;

// fill fSaneDevices
procedure TIESANEParams.FillSourceListData;
begin
  if fSaneDevices = nil then
    if sane_get_devices(fSaneDevices, 0) <> SANE_STATUS_GOOD then
      fSaneDevices := nil;
end;

function TIESANEParams.GetSourceName(idx: integer): AnsiString;
var
  sd: PPSANE_Device;
  i: integer;
begin
  result := '';
  FillSourceListData;
  if fSaneDevices <> nil then
  begin
    sd := fSaneDevices;
    i := 0;
    while sd^ <> nil do
    begin
      if i = idx then
      begin
        result := sd^^.name;
        break;
      end;
      inc(sd);
    end;
  end;
end;

function TIESANEParams.GetSourceFullName(idx: integer): AnsiString;
var
  sd: PPSANE_Device;
  i: integer;
begin
  result := '';
  FillSourceListData;
  if fSaneDevices <> nil then
  begin
    sd := fSaneDevices;
    i := 0;
    while sd^ <> nil do
    begin
      if i = idx then
      begin
        with sd^^ do
          result := name + ' (' + vendor + ') ' + model + ' ' + xtype;
        break;
      end;
      inc(sd);
    end;
  end;
end;

function TIESANEParams.GetSourceCount: integer;
var
  sd: PPSANE_Device;
begin
  result := 0;
  FillSourceListData;
  if fSaneDevices <> nil then
  begin
    sd := fSaneDevices;
    while sd^ <> nil do
    begin
      inc(sd);
      inc(result);
    end;
  end;
end;

procedure TIESANEParams.SetSelectedSource(v: integer);
begin
  fSelectedSource := v;
end;

procedure InitSANE;
var
  version_code: SANE_Int;
begin
  sane_init(version_code, nil);
end;

procedure ExitSANE;
begin
  sane_exit;
end;

// fill fSaneOptionDescriptors
procedure TIESANEParams.GetFromScanner;
var
  st: SANE_Status;
  shandle: SANE_Handle;
begin
  st := sane_open(PAnsiChar(SourceName[fSelectedSource]), shandle);
  if st = SANE_STATUS_GOOD then
  begin
    //
    //..here a loop to get all option descriptors...
    //
    sane_close(shandle);
  end;
end;

function TImageEnIO.Acquire: boolean;
var
  Progress: TProgressRec;
  st: SANE_Status;
  devicename: AnsiString;
  shandle: SANE_Handle;
  par: SANE_Parameters;
  buf, xbuf: pbyte;
  buflen, retlen, row, col: integer;
  px: PRGB;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateRetBool(self, fAsyncThreads, Acquire);
    result := true;
    exit;
  end;
  try
    fAborting := false;
    result := false;
    if not assigned(fIEBitmap) then
      exit;
    Progress.Aborting := @fAborting;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    if not MakeConsistentBitmap([]) then
      exit;
    // acquire from SANE
    with fSANEParams do
      devicename := SourceName[SelectedSource];
    st := sane_open(PAnsiChar(devicename), shandle);
    if st = SANE_STATUS_GOOD then
    begin
      // set options
      IESANE_SetIntOption(shandle, 'depth', fSANEParams.BitDepth);
      case fSANEParams.ColorMode of
        ieColor: IESANE_SetStrOption(shandle, 'mode', 'Color');
        ieGray: IESANE_SetStrOption(shandle, 'mode', 'Gray');
      end;
      IESANE_SetIntOption(shandle, 'resolution', fSANEParams.XResolution);
      IESANE_SetIntOption(shandle, 'y-resolution', fSANEParams.YResolution);
      //
      st := sane_start(shandle);
      if st = SANE_STATUS_GOOD then
      begin
        sane_get_parameters(shandle, par);
        if par.lines = -1 then
        begin
          // it doesn't know the image height (hand scanner?)
        end
        else
        begin
          // gets resulting DPI
          IESANE_GetIntOption(shandle, 'resolution', fParams.fDPIX);
          if not IESANE_GetIntOption(shandle, 'y-resolution', fParams.fDPIY) then
            fParams.fDPIY := fParams.fDPIX;
          // it knows the image height
          fParams.fWidth := par.pixels_per_line;
          fParams.fHeight := par.lines;
          if par.format = SANE_FRAME_GRAY then
            fParams.fSamplesPerPixel := 1
          else
            fParams.fSamplesPerPixel := 3;
          fParams.fBitsPerSample := par.depth;
          if (fParams.fBitsPerSample = 1) and (fParams.fSamplesPerPixel = 1) then
            fIEBitmap.Allocate(par.pixels_per_line, par.lines, ie1g)
          else
            fIEBitmap.Allocate(par.pixels_per_line, par.lines, ie24RGB);
          buflen := IEBitmapRowLen(fParams.fWidth, fParams.fSamplesPerPixel * fParams.fBitsPerSample, 32);
          getmem(buf, buflen);
          // acquire
          row := 0;
          while true do
          begin
            st := sane_read(shandle, PSANE_Byte(buf), par.bytes_per_line, retlen);
            if st <> SANE_STATUS_GOOD then
              break;
            case par.format of
              SANE_FRAME_GRAY:
                begin
                  // gray or black/white
                  if par.depth = 8 then
                  begin
                    px := fIEBitmap.Scanline[row];
                    xbuf := buf;
                    for col := 0 to fIEBitmap.Width - 1 do
                    begin
                      with px^ do
                      begin
                        r := xbuf^;
                        g := xbuf^;
                        b := xbuf^;
                        inc(xbuf);
                      end;
                      inc(px);
                    end;
                  end
                  else if par.depth = 1 then
                  begin
                    CopyMemory(fIEBitmap.Scanline[row], buf, par.bytes_per_line);
                    _NegativeBuffer(fIEBitmap.Scanline[row], buflen);
                  end;
                end;
              SANE_FRAME_RGB:
                begin
                  // RGB
                  px := fIEBitmap.Scanline[row];
                  xbuf := buf;
                  for col := 0 to fIEBitmap.Width - 1 do
                  begin
                    with px^ do
                    begin
                      r := xbuf^;
                      inc(xbuf);
                      g := xbuf^;
                      inc(xbuf);
                      b := xbuf^;
                      inc(xbuf);
                    end;
                    inc(px);
                  end;
                end;
            end;
            inc(row);
            with Progress do
              if assigned(fOnProgress) then
                fOnProgress(self, trunc(100 / par.lines * row));
          end;
          freemem(buf);
        end;
        sane_cancel(shandle);
        result := true;
      end;
      sane_close(shandle);
    end;
    //
    if result then
    begin
      if fAutoAdjustDPI then
        AdjustDPI;
      if assigned(fImageEnView) then
      begin
        fImageEnView.dpix := fParams.DpiX;
        fImageEnView.dpiy := fParams.DpiY;
      end;
    end;
    Update;
  finally
    DoFinishWork;
  end;
end;

(*$endif*)// IEINCLUDESANE

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnIO.ThreadsCount

<FM>Declaration<FC>
property ThreadsCount:integer;

<FM>Description<FN>
ThreadsCount returns the count of currently active threads. Valid only if <A TImageEnIO.AsyncMode> is True.

!!}
function TImageEnIO.GetThreadsCount: integer;
begin
  EnterCriticalSection(fAsyncThreadsCS);
  result := fAsyncThreads.Count;
  LeaveCriticalSection(fAsyncThreadsCS);
end;

{!!
<FS>TImageEnIO.DefaultDitherMethod

<FM>Declaration<FC>
property DefaultDitherMethod:<A TIEDitherMethod>;

<FM>Description<FN>
DefaultDitherMethod specifies the default dithering method to apply when a color image needs to be converted to black/white.
<FC>ieThreshold<FN> is the default.
!!}
procedure TImageEnIO.SetDefaultDitherMethod(Value: TIEDitherMethod);
begin
  if assigned(fIEBitmap) then
    fIEBitmap.DefaultDitherMethod := Value;
  fDefaultDitherMethod := Value;
end;

{!!
<FS>TImageEnIO.Bitmap

<FM>Declaration<FC>
property Bitmap: TBitmap;

<FM>Description<FN>
References the bitmap contained in TImageEnIO, <A TImageEnView> or <A TImageEnMView>.

Read-only

<FM>Example<FC>

// This use standard Delphi LoadFromFile
ImageEnView1.IO.Bitmap.LoadFromFile('my.bmp');
ImageEnView1.IO.Bitmap.PixelFormat := pf24bit;
ImageEnView1.Update;
!!}
function TImageEnIO.GetBitmap: TBitmap;
begin
  if assigned(fIEBitmap) and (fIEBitmap.Location = ieTBitmap) then
    result := fIEBitmap.VclBitmap
  else
    result := fBitmap;
end;

{!!
<FS>TImageEnIO.SaveToStreamICO

<FM>Declaration<FC>
procedure SaveToStreamICO(Stream:TStream);

<FM>Description<FN>
SaveToStreamICO saves the image to an ICO stream. ICO format allows storing multiple images with several resolutions and sizes.
ImageEn creates for you the sub-images to save; you have only to set the <A TImageEnIO.Params>.<A TIOParamsVals.ICO_BitCount> and Params.<A TIOParamsVals.ICO_Sizes> arrays.

If you want control each image separately use <A IEWriteICOImages> function.

<FM>Example<FC>
// save the current image in 'output.ico', It will contain three images with 64x64 32bit (24bit +alphachannel), 32x32 256 colors and 32x32 16 colors
// 64x64 x32bit
ImageEnView.IO.Params.ICO.BitCount[0]:=32;
ImageEnView.IO.Params.ICO.Sizes[0].cx:=64;
ImageEnView.IO.Params.ICO.Sizes[0].cy:=64;
// 32x32 x8bit
ImageEnView.IO.Params.ICO.BitCount[1]:=8;
ImageEnView.IO.Params.ICO.Sizes[1].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[1].cy:=32;
// 32x32 x4bit
ImageEnView.IO.Params.ICO.BitCount[2]:=4;
ImageEnView.IO.Params.ICO.Sizes[2].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[2].cy:=32;
// I don't want other images
ImageEnView.IO.Params.ICO.BitCount[3]:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cx:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cy:=0;
// save
ImageEnView.IO.SaveToFile('output.ico');

!!}
procedure TImageEnIO.SaveToStreamICO(Stream: TStream);
var
  Progress: TProgressRec;
  icount: integer;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamICO, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    icount := 0;
    while (icount <= high(Params.ICO_Sizes)) and (Params.ICO_Sizes[icount].cx > 0) do
      inc(icount);
    ICOWriteStream(Stream, fIEBitmap, fParams, Progress, slice(Params.ICO_Sizes, icount), slice(Params.ICO_BitCount, icount));
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToFileICO

<FM>Declaration<FC>
procedure SaveToFileICO(const FileName: WideString);

<FM>Description<FN>
SaveToFileICO  saves the image to a file. ICO format allows storing multiple images with several resolutions and sizes.
ImageEn creates for you the sub-images to save, you have only to set the <A TImageEnIO.Params>.<A TIOParamsVals.ICO_BitCount> and Params.<A TIOParamsVals.ICO_Sizes> arrays.

If you want control each image separately, use <A IEWriteICOImages> function.

<FM>Example<FC>

// save the current image in 'output.ico', It will contain three images with 64x64 32bit (24bit +alphachannel), 32x32 256 colors and 32x32 16 colors
// 64x64 x32bit
ImageEnView.IO.Params.ICO.BitCount[0]:=32;
ImageEnView.IO.Params.ICO.Sizes[0].cx:=64;
ImageEnView.IO.Params.ICO.Sizes[0].cy:=64;
// 32x32 x8bit
ImageEnView.IO.Params.ICO.BitCount[1]:=8;
ImageEnView.IO.Params.ICO.Sizes[1].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[1].cy:=32;
// 32x32 x4bit
ImageEnView.IO.Params.ICO.BitCount[2]:=4;
ImageEnView.IO.Params.ICO.Sizes[2].cx:=32;
ImageEnView.IO.Params.ICO.Sizes[2].cy:=32;
// I don't want other images
ImageEnView.IO.Params.ICO.BitCount[3]:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cx:=0;
ImageEnView.IO.Params.ICO.Sizes[3].cy:=0;
// save
ImageEnView.IO.SaveToFile('output.ico');

!!}
procedure TImageEnIO.SaveToFileICO(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
  icount: integer;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileICO, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      icount := 0;
      while (icount <= high(Params.ICO_Sizes)) and (Params.ICO_Sizes[icount].cx > 0) do
        inc(icount);
      ICOWriteStream(fs, fIEBitmap, fParams, Progress, slice(Params.ICO_Sizes, icount), slice(Params.ICO_BitCount, icount));
      fParams.FileName:=FileName;
      fParams.FileType:=ioICO;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>IEWriteICOImages

<FM>Declaration<FC>
procedure IEWriteICOImages(const fileName:WideString; images:array of TObject);

<FM>Description<FN>
IEWriteICOImages is an alternate mode to save ICO files (instead <A TImageEnIO.SaveToFile> or <A TImageEnIO.SaveToFileICO>). It allows specifying the origin of each frame of ICO to be saved.
IEWriteICOImages doesn't look at <A TIOParamsVals.ICO_Sizes> and <A TIOParamsVals.ICO_BitCount>, but just to <A TImageEnView>.<A TImageEnView.IO>.<A TImageEnIO.Params>.<A TIOParamsVals.BitsPerSample> and TImageEnView.IO.Params.<A TIOParamsVals.SamplesPerPixel>.

<FM>Example<FC>
// we suppose there are three images for each TImageEnView component (ex. ImageEnView1,ImageEnView2,ImageEnView3)
// we want three images inside the ICO file, of 32 bit, 8 bit and 4 bit.

// 32 bit (24 for colors and 8 for alpha channel)
ImageEnView1.IO.Params.BitsPerSample:=4;
ImageEnView1.IO.Params.SamplesPerPixel:=3;
// 8 bit (256 colors)
ImageEnView1.IO.Params.BitsPerSample:=8;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
// 4 bit (16 colors)
ImageEnView1.IO.Params.BitsPerSample:=4;
ImageEnView1.IO.Params.SamplesPerPixel:=1;
// save all inside a single ICO
IEWriteICOImages('output.ico',[ImageEnView1,ImageEnView2,ImageEnView3]);

!!}
procedure IEWriteICOImages(const fileName: WideString; images: array of TObject);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
  fAborting: boolean;
begin
  fAborting := false;
  Progress.Aborting := @fAborting;
  Progress.fOnProgress := nil;
  Progress.Sender := nil;
  fs := TIEWideFileStream.Create(fileName, fmCreate);
  try
    ICOWriteStream2(fs, images, Progress);
  finally
    FreeAndNil(fs);
  end;
end;

{$IFDEF IEINCLUDEWIA}

{!!
<FS>TImageEnIO.WIAParams

<FM>Declaration<FC>
property WIAParams: <A TIEWia>;

<FM>Description<FN>

WIAParams allows you to set/get parameters, show dialogs and control WIA devices.
Look at <A TIEWia> for more info.

<FM>Examples<FC>

// capture from WIA
ImageEnView.IO.Acquire( ieaWIA );

// select device and capture from WIA
ImageEnView.IO.SelectAcquireSource( ieaWIA );
ImageEnView.IO.Acquire( ieaWIA );

// show preview dialog and capture
if ImageEnView.IO.WIAParams.ShowAcquireDialog then
  ImageEnView.IO.Acquire( ieaWIA );

// select first device then capture
ImageEnView.IO.WIAParams.ConnectTo( 0 );
ImageEnView.IO.Acquire( ieaWIA );

// select first device, set black/white (with threshold) and capture
ImageEnView.IO.WIAParams.ConnectTo( 0 );
ImageEnView.IO.WIAParams.SetItemProperty(WIA_IPA_DATATYPE, WIA_DATA_THRESHOLD, nil);
ImageEnView.IO.Acquire( ieaWIA );

// set dpi=150 then capture
ImageEnView.IO.WIAParams.SetItemProperty(WIA_IPS_XRES, 150, nil);
ImageEnView.IO.WIAParams.SetItemProperty(WIA_IPS_YRES, 150, nil);
ImageEnView.IO.Acquire( ieaWIA );

!!}
function TImageEnIO.GetWIAParams: TIEWia;
begin
  if not assigned(fWIA) then
  begin
    fWIA := TIEWia.Create(self);
    fWIA.OnProgress := WiaOnProgress;
  end;
  result := fWIA;
end;

function TImageEnIO.WiaOnProgress(Percentage: integer): boolean;
begin
  fOnIntProgress(self, Percentage); // fOnIntProgress is always assigned
  result := not fAborting;
end;
{$ENDIF}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnIO.LoadFromFileWBMP

<FM>Declaration<FC>
procedure LoadFromFileWBMP(const FileName: WideString);

<FM>Description<FN>
LoadFromFileWBMP loads an image from a WBMP (Wireless bitmap) file.
If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.

FileName is the file name with extension.
!!}
procedure TImageEnIO.LoadFromFileWBMP(const FileName: WideString);
var
  fs: TIEWideFileStream;
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileWBMP, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fIEBitmap.RemoveAlphaChannel;
      WBMPReadStream(fs, fIEBitmap, fParams, Progress, false);
      CheckDPI;
      fParams.fFileName := FileName;
      fParams.fFileType := ioWBMP;
      update;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamWBMP

<FM>Declaration<FC>
procedure LoadFromStreamWBMP(Stream: TStream);

<FM>Description<FN>
LoadFromStreamWBMP loads an image from a WBMP (Wireless bitmap) stream.
If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
!!}
procedure TImageEnIO.LoadFromStreamWBMP(Stream: TStream);
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamWBMP, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    WBMPReadStream(Stream, fIEBitmap, fParams, Progress, false);
    CheckDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioWBMP;
    update;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToFileWBMP

<FM>Declaration<FC>
procedure SaveToFileWBMP(const FileName: WideString);

<FM>Description<FN>
SaveToFileWBMP saves the current image in WBMP (Wireless bitmap) format to file.
FileName is the file name, with extension.

!!}
procedure TImageEnIO.SaveToFileWBMP(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileWBMP, FileName);
    exit;
  end;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    fAborting := false;
    try
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      WBMPWriteStream(fs, fIEBitmap, fParams, Progress);
      fParams.FileName:=FileName;
      fParams.FileType:=ioWBMP;
    finally
      FreeAndNil(fs);
    end;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamWBMP

<FM>Declaration<FC>
procedure SaveToStreamWBMP(Stream: TStream);

<FM>Description<FN>
SaveToStreamWBMP saves the current image as WBMP (Wireless bitmap) in the Stream.

!!}
procedure TImageEnIO.SaveToStreamWBMP(Stream: TStream);
var
  Progress: TProgressRec;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamWBMP, Stream);
    exit;
  end;
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    WBMPWriteStream(Stream, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// CMYK/RGB conversions


var
  CMYKProfile:TIEICC;
  SRGBProfile:TIEICC;

function InitCMYKConversion:boolean;
{$IFDEF IEINCLUDEZLIB}
var
  buf:pointer;
  buflen:integer;
  cmyk:TCMYK;
  rgb:TRGB;
begin
  result:=true;
  if CMYKProfile=nil then
  begin
    ZDecompress(@IECMYKPROFILE[0],length(IECMYKPROFILE)*8,buf,buflen,118188);
    CMYKProfile:=TIEICC.Create(false);
    CMYKProfile.LoadFromBuffer(buf,buflen);
    freemem(buf);
    if CMYKProfile.IsValid then
    begin
      SRGBProfile:=TIEICC.Create(false);
      SRGBProfile.Assign_sRGBProfile;
      cmyk:=CreateCMYK(0,0,0,0);
      rgb:=CreateRGB(0,0,0);
      CMYKProfile.Transform(SRGBProfile,integer(iecmsCMYK),integer(iecmsBGR),0, 0 ,@cmyk,@rgb,1); // fake CMYK->RGB transform, just to initialize
      SRGBProfile.Transform(CMYKProfile,integer(iecmsBGR),integer(iecmsCMYK),0, 0 ,@rgb,@cmyk,1); // fake RGB->CMYK transform, just to initialize
    end
    else
      result:=false;
  end;
end;
{$ELSE}
begin
  result:=false;
end;
{$ENDIF}

// CMYK to RGB
function IECMYK2RGB(cmyk: TCMYK): TRGB;
var
  cmyk16:TCMYK16;
  rgb48:TRGB48;
begin
  if iegUseCMYKProfile and InitCMYKConversion then
  begin
    cmyk16.c:=(255-cmyk.c)*257;
    cmyk16.m:=(255-cmyk.m)*257;
    cmyk16.y:=(255-cmyk.y)*257;
    cmyk16.k:=(255-cmyk.k)*257;
    IE_TranslateColors(CMYKProfile.MSTransform, @cmyk16, 1, IE_CS2IF[integer(iecmsCMYK)], @rgb48, IE_CS2IF[integer(iecmsBGR)]);
    result.r:=rgb48.r shr 8;
    result.g:=rgb48.g shr 8;
    result.b:=rgb48.b shr 8;
  end
  else
  begin
    with cmyk, result do
    begin
      r := k * c div 255;
      g := k * m div 255;
      b := k * y div 255;
    end;
  end;
end;

// RGB to CMYK
function IERGB2CMYK(const rgb: TRGB): TCMYK;
var
  cmyk16:TCMYK16;
  rgb48:TRGB48;
begin
  if iegUseCMYKProfile and InitCMYKConversion then
  begin
    rgb48.r:=rgb.r * 257;
    rgb48.g:=rgb.g * 257;
    rgb48.b:=rgb.b * 257;
    IE_TranslateColors(SRGBProfile.MSTransform, @rgb48, 1, IE_CS2IF[integer(iecmsBGR)], @cmyk16, IE_CS2IF[integer(iecmsCMYK)]);
    result.c:=255- cmyk16.c shr 8;
    result.m:=255- cmyk16.m shr 8;
    result.y:=255- cmyk16.y shr 8;
    result.k:=255- cmyk16.k shr 8;
  end
  else
    with rgb, result do
    begin
      k := imax(r, imax(g, b));
      if k = 0 then
        k := 1;
      C := r * 255 div k;
      M := g * 255 div k;
      Y := b * 255 div k;
    end;
end;

// end of CMYK/RGB conversions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


procedure IEDefaultConvertColorFunction(InputScanline: pointer; InputColorSpace: TIEColorSpace; OutputScanline: pointer; OutputColorSpace: TIEColorSpace; ImageWidth: integer; IOParams: TIOParamsVals);
{$ifdef IEINCLUDECMS}
const
  CCTOCMS:array [iecmsRGB..iecmsYCBCR] of integer = (TYPE_RGB_8, TYPE_BGR_8, TYPE_CMYK_8_REV, TYPE_CMYKcm_8, TYPE_Lab_8, TYPE_GRAY_8, TYPE_RGB_16, TYPE_RGB_16_SE, TYPE_YCbCr_8);
{$endif}
var
  xlab: PCIELAB;
  xcmyk: PCMYK;
  xbgr: PRGB;
  xgray8: pbyte;
  xrgb48: PRGB48;
  xycbcr: PYCBCR;
  i: integer;
  InputProfile:TIEICC;
begin
  InputProfile:=nil;
  if assigned(IOParams) then
  begin
    if assigned(IOParams.fDefaultICC) and ((IOParams.fInputICC=nil) or (not IOParams.fInputICC.IsValid))  then
      InputProfile:=IOParams.fDefaultICC
    else
      InputProfile:=IOParams.fInputICC;
  end;
  {$ifdef IEINCLUDECMS}
  if iegEnableCMS and (IOParams<>nil) and assigned(InputProfile) and InputProfile.IsValid and not InputProfile.IsApplied and IOParams.OutputICCProfile.IsValid then
  begin
    // use CMS
    if InputProfile.Transform(IOParams.OutputICCProfile,CCTOCMS[InputColorSpace],CCTOCMS[OutputColorSpace],INTENT_PERCEPTUAL, 0 ,InputScanline,OutputScanline,ImageWidth) then
      exit; // sucessful
  end;
  {$else}
  // use mscms
  if iegEnableCMS and (IOParams<>nil) and assigned(InputProfile) and InputProfile.IsValid and not InputProfile.IsApplied and IOParams.OutputICCProfile.IsValid then
    if InputProfile.Transform(IOParams.OutputICCProfile,integer(InputColorSpace),integer(OutputColorSpace),0, 0 ,InputScanline,OutputScanline,ImageWidth) then
      exit; // sucessful
  {$endif}

  case InputColorSpace of

    iecmsRGB:
      case OutputColorSpace of
        iecmsBGR:
          begin
            // RGB->BGR
            _CopyBGR_RGB(OutputScanline,InputScanline,ImageWidth);
          end;
      end;

    iecmsRGB48:
      case OutputColorSpace of
        iecmsBGR:
          begin
            // RGB48->BGR
            xrgb48 := PRGB48(InputScanline);
            xbgr := PRGB(OutputScanline);
            for i := 0 to ImageWidth - 1 do
            begin
              xbgr^.r := xrgb48^.r shr 8;
              xbgr^.g := xrgb48^.g shr 8;
              xbgr^.b := xrgb48^.b shr 8;
              inc(xbgr);
              inc(xrgb48);
            end;
          end;
      end;

    iecmsRGB48_SE:
      case OutputColorSpace of
        iecmsBGR:
          begin
            // RGB48->BGR
            xrgb48 := PRGB48(InputScanline);
            xbgr := PRGB(OutputScanline);
            for i := 0 to ImageWidth - 1 do
            begin
              xbgr^.r := xrgb48^.r and $FF;
              xbgr^.g := xrgb48^.g and $FF;
              xbgr^.b := xrgb48^.b and $FF;
              inc(xbgr);
              inc(xrgb48);
            end;
          end;
      end;

    iecmsBGR:
      case OutputColorSpace of
        iecmsCMYK:
          begin
            // BGR->CMYK
            xbgr := PRGB(InputScanline);
            xcmyk := PCMYK(OutputScanline);
            for i := 0 to ImageWidth - 1 do
            begin
              xcmyk^ := IERGB2CMYK(xbgr^);
              inc(xbgr);
              inc(xcmyk);
            end;
          end;
        iecmsCIELab:
          begin
            // BGR->CIELab
            xbgr := PRGB(InputScanline);
            xlab := PCIELAB(OutputScanline);
            for i := 0 to ImageWidth - 1 do
            begin
              xlab^ := IERGB2CIELAB(xbgr^);
              inc(xbgr);
              inc(xlab);
            end;
          end;
        iecmsGray8:
          begin
            // BGR->Gray8
            xbgr := PRGB(InputScanline);
            xgray8 := pbyte(OutputScanline);
            for i := 0 to ImageWidth -1 do
            begin
              with xbgr^ do
                xgray8^ := (r*gRedToGrayCoef + g*gGreenToGrayCoef + b*gBlueToGrayCoef) div 100;
              inc(xbgr);
              inc(xgray8);
            end;
          end;
        iecmsBGR:
          begin
            // BGR->BGR
            copymemory(OutputScanline,InputScanline,ImageWidth*3);
          end;
      end;

    iecmsCMYK:
      case OutputColorSpace of
        iecmsBGR:
          begin
            // CMYK->BGR
            xcmyk := PCMYK(InputScanline);
            xbgr := OutputScanline;
            for i := 0 to ImageWidth - 1 do
            begin
              xbgr^ := IECMYK2RGB(xcmyk^);
              inc(xbgr);
              inc(xcmyk);
            end;
          end;
      end;

    iecmsCMYK6:
      case OutputColorSpace of
        iecmsBGR:
          begin
            // CMYK->BGR
            xcmyk := PCMYK(InputScanline);
            xbgr := OutputScanline;
            for i := 0 to ImageWidth - 1 do
            begin
              with xcmyk^ do
              begin
                c:=255-c;
                m:=255-m;
                y:=255-y;
                k:=255-k;
              end;
              xbgr^ := IECMYK2RGB(xcmyk^);
              inc(xbgr);
              inc(xcmyk);
              inc(pbyte(xcmyk),2);
            end;
          end;
      end;

    iecmsCIELab:
      case OutputColorSpace of
        iecmsBGR:
          begin
            // ieCIELab->BGR
            xlab := PCIELAB(InputScanline);
            xbgr := OutputScanline;
            for i := 0 to ImageWidth - 1 do
            begin
              xbgr^ := IECIELAB2RGB(xlab^);
              inc(xlab);
              inc(xbgr);
            end;
          end;
      end;

    iecmsYCbCr:
      case OutputColorSpace of
        iecmsBGR:
          begin
            // ieYCbCr->BGR
            xycbcr := PYCBCR(InputScanline);
            xbgr := OutputScanline;
            for i := 0 to ImageWidth - 1 do
            begin
              IEYCbCr2RGB(xbgr^, xycbcr^.y,xycbcr^.Cb,xycbcr^.Cr);
              inc(xycbcr);
              inc(xbgr);
            end;
          end;
      end;

  end;
end;

{!!
<FS>TImageEnIO.CreatePSFile

<FM>Declaration<FC>
procedure CreatePSFile(const FileName: WideString);

<FM>Description<FN>
CreatePSFile creates a new PostScript file using FileName path and file name. You can add pages using SaveToPS and finally close the file using ClosePSFile.
The PS file will contain only images, aligned to the upper-left side of the paper.

<FM>Example<FC>
ImageEnView1.IO.CreatePSFile( 'output.ps' );

// load and save page 1
ImageEnView1.IO.LoadFromFile('page1.tiff');
ImageEnView1.IO.Params.PS_Compression:= ioPS_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPS;

// load and save page 2
ImageEnView1.IO.LoadFromFile('page2.tiff');
ImageEnView1.IO.Params.PS_Compression:= ioPS_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPS;

..other pages..

// close PS file
ImageEnView1.IO.ClosePSFile;

!!}
procedure TImageEnIO.CreatePSFile(const FileName: WideString);
begin
  fAborting := False;
  fPS_stream := TIEWideFileStream.Create(FileName, fmCreate);
  fPS_handle := IEPostScriptCreate(fPS_stream, fParams);
end;

{!!
<FS>TImageEnIO.SaveToPS

<FM>Declaration<FC>
procedure SaveToPS;

<FM>Description<FN>
SaveToPS saves the current image to an open PostScript file. You can create a PostScript file using CreatePSFile then add pages using SaveToPS and finally close the file using ClosePSFile.
The resulting PS file will contain only images, aligned to the upper-left side of the paper.

<FM>Example<FC>
ImageEnView1.IO.CreatePSFile( 'output.ps' );

// load and save page 1
ImageEnView1.IO.LoadFromFile('page1.tiff');
ImageEnView1.IO.Params.PS_Compression:= ioPS_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPS;

// load and save page 2
ImageEnView1.IO.LoadFromFile('page2.tiff');
ImageEnView1.IO.Params.PS_Compression:= ioPS_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPS;

..other pages..

// close PS file
ImageEnView1.IO.ClosePSFile;

!!}
procedure TImageEnIO.SaveToPS;
var
  Progress: TProgressRec;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
    fIEBitmap.PixelFormat := ie24RGB;
  fAborting := false;
  Progress.Aborting := @fAborting;
  Progress.fOnProgress := fOnIntProgress;
  Progress.Sender := Self;
  IEPostScriptSave(fPS_handle, fPS_stream, fIEBitmap, fParams, Progress);
end;

{!!
<FS>TImageEnIO.ClosePSFile

<FM>Declaration<FC>
procedure ClosePSFile;

<FM>Description<FN>
ClosePSFile closes the currently open PostScript file. You can create a PostScript file using <A TImageEnIO.CreatePSFile> then add pages using SaveToPS and finally close the file using <A TImageEnIO.ClosePSFile>.
The resulting PS file will contain only images, aligned to the upper-left side of the paper.

<FM>Example<FC>
ImageEnView1.IO.CreatePSFile( 'output.ps' );

// load and save page 1
ImageEnView1.IO.LoadFromFile('page1.tiff');
ImageEnView1.IO.Params.PS_Compression:= ioPS_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPS;

// load and save page 2
ImageEnView1.IO.LoadFromFile('page2.tiff');
ImageEnView1.IO.Params.PS_Compression:= ioPS_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPS;

..other pages..

// close PS file
ImageEnView1.IO.ClosePSFile;
!!}
procedure TImageEnIO.ClosePSFile;
begin
  if fPS_handle <> nil then
    IEPostScriptClose(fPS_handle, fPS_stream);
  if assigned(fPS_stream) then
    FreeAndNil(fPS_stream);
  fPS_stream := nil;
  fPS_handle := nil;
end;

procedure TImageEnIO.SyncSaveToStreamPS(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    IEPostScriptSaveOneStep(Stream, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamPS

<FM>Declaration<FC>
procedure SaveToStreamPS(Stream:TStream);

<FM>Description<FN>
SaveToStreamPS saves the current image to Stream. The resulting PostScript file will have only one page.
!!}
procedure TImageEnIO.SaveToStreamPS(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamPS, Stream);
    exit;
  end;
  SyncSaveToStreamPS(Stream);
end;

{!!
<FS>TImageEnIO.SaveToFilePS

<FM>Declaration<FC>
procedure SaveToFilePS(const FileName: WideString);

<FM>Description<FN>
SaveToFilePS saves the current image to FileName (filename). The resulting PostScript file will have only one page.

<FM>Example<FC>
ImageEnView1.IO.LoadFromFile('input.bmp');
ImageEnView1.IO.SaveToFilePS('output.ps');
!!}
procedure TImageEnIO.SaveToFilePS(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFilePXM, FileName);
    exit;
  end;
  fs := TIEWideFileStream.Create(FileName, fmCreate);
  try
    SyncSaveToStreamPS(fs);
    fParams.FileName:=FileName;
    fParams.FileType:=ioPS;
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnIO.CreatePDFFile

<FM>Declaration<FC>
procedure CreatePDFFile(const FileName: WideString);

<FM>Description<FN>
CreatePDFFile creates a new Adobe PDF file using FileName path and file name. You can add pages using <A TImageEnIO.SaveToPDF> and finally close the file using <A TImageEnIO.ClosePDFFile>.
The resulting PDF file will contain only images, aligned to the upper-left side of the paper.

<FM>Example<FC>
ImageEnView1.IO.CreatePDFFile( 'output.pdf' );

// load and save page 1
ImageEnView1.IO.LoadFromFile('page1.tiff');
ImageEnView1.IO.Params.PDF_Compression:= ioPDF_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPDF;

// load and save page 2
ImageEnView1.IO.LoadFromFile('page2.tiff');
ImageEnView1.IO.Params.PDF_Compression:= ioPDF_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPDF;

..other pages..

// close PDF file
ImageEnView1.IO.ClosePDFFile;
!!}
{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnIO.CreatePDFFile(const FileName: WideString);
begin
  fAborting := False;
  fPDF_stream := TIEWideFileStream.Create(FileName, fmCreate);
  fPDF_handle := IEPDFCreate(fParams);
end;
{$endif}

{!!
<FS>TImageEnIO.SaveToPDF

<FM>Declaration<FC>
procedure SaveToPDF;

<FM>Description<FN>
SaveToPDF saves the current image to an open Adobe PDF file. You can create a PDF file using <A TImageEnIO.CreatePDFFile> then add pages using <A TImageEnIO.SaveToPDF> and finally close the file using <A TImageEnIO.ClosePDFFile>.
The resulting PDF file will contain only images, aligned to the upper-left side of the paper.

<FM>Example<FC>
ImageEnView1.IO.CreatePDFFile( 'output.pdf' );

// load and save page 1
ImageEnView1.IO.LoadFromFile('page1.tiff');
ImageEnView1.IO.Params.PDF_Compression:= ioPDF_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPDF;

// load and save page 2
ImageEnView1.IO.LoadFromFile('page2.tiff');
ImageEnView1.IO.Params.PDF_Compression:= ioPDF_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPDF;

..other pages..

// close PDF file
ImageEnView1.IO.ClosePDFFile;
!!}
{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnIO.SaveToPDF;
var
  Progress: TProgressRec;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
    fIEBitmap.PixelFormat := ie24RGB;
  fAborting := false;
  Progress.Aborting := @fAborting;
  Progress.fOnProgress := fOnIntProgress;
  Progress.Sender := Self;
  IEPDFSave(fPDF_handle, fIEBitmap, fParams, Progress);
end;
{$endif}

{!!
<FS>TImageEnIO.ClosePDFFile

<FM>Declaration<FC>
procedure ClosePDFFile;

<FM>Description<FN>
ClosePDFFile closes the current open Adobe PDF file. You can create a PDF file using <A TImageEnIO.CreatePDFFile> then add pages using <A TImageEnIO.SaveToPDF> and finally close the file using <A TImageEnIO.ClosePDFFile>.
The resulting PDF file will contain only images, aligned to the upper-left side of the paper.

<FM>Example<FC>
ImageEnView1.IO.CreatePDFFile( 'output.pdf' );

// load and save page 1
ImageEnView1.IO.LoadFromFile('page1.tiff');
ImageEnView1.IO.Params.PDF_Compression:= ioPDF_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPDF;

// load and save page 2
ImageEnView1.IO.LoadFromFile('page2.tiff');
ImageEnView1.IO.Params.PDF_Compression:= ioPDF_G4FAX;	// G4Fax compression
ImageEnView1.IO.SaveToPDF;

..other pages..

// close PDF file
ImageEnView1.IO.ClosePDFFile;
!!}
{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnIO.ClosePDFFile;
begin
  if fPDF_handle <> nil then
    IEPDFClose(fPDF_handle, fPDF_stream, fParams);
  if assigned(fPDF_stream) then
    FreeAndNil(fPDF_stream);
  fPDF_stream := nil;
  fPDF_handle := nil;
end;
{$endif}

{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnIO.SyncSaveToStreamPDF(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.pixelformat <> ie24RGB) and (fIEBitmap.PixelFormat <> ie1g) then
      fIEBitmap.PixelFormat := ie24RGB;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    IEPDFSaveOneStep(Stream, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;
{$endif}

{!!
<FS>TImageEnIO.SaveToStreamPDF

<FM>Declaration<FC>
procedure SaveToStreamPDF(Stream:TStream);

<FM>Description<FN>
SaveToStreamPDF saves the current image to Stream. The resulting Adobe PDF file will have only one page.
!!}
{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnIO.SaveToStreamPDF(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamPDF, Stream);
    exit;
  end;
  SyncSaveToStreamPDF(Stream);
end;
{$endif}

{!!
<FS>TImageEnIO.SaveToFilePDF

<FM>Declaration<FC>
procedure SaveToFilePDF(const FileName: WideString);

<FM>Description<FN>
SaveToFilePDF saves current image to FileName (filename). The resulting Adobe PDF file will have only one page.

<FM>Example<FC>
ImageEnView1.IO.LoadFromFile('input.bmp');
ImageEnView1.IO.SaveToFilePDF('output.pdf');
!!}
{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnIO.SaveToFilePDF(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFilePXM, FileName);
    exit;
  end;
  fs := TIEWideFileStream.Create(FileName, fmCreate);
  try
    SyncSaveToStreamPDF(fs);
    fParams.FileName:=FileName;
    fParams.FileType:=ioPDF;
  finally
    FreeAndNil(fs);
  end;
end;
{$endif}

{$IFDEF IEINCLUDEDIRECTSHOW}

{!!
<FS>TImageEnIO.DShowParams

<FM>Declaration<FC>
property DShowParams:<A TIEDirectShow>;

<FM>Description<FN>
DShowParams is a TIEDirectShow instance which allows control of some Direct Show features, such as video capture, audio capture, multimedia files capture as well video rendering, and multimedia file writing.

<FM>Demos<FN>
capture\directshow1
capture\directshow2
capture\motiondetectior
capture\videoeffects
capture\videoplayer

<FM>Examples<FC>

Capture Skeleton

// this fills ComboBox1 with names of all video capture inputs
ComboBox1.Items.Assign( ImageEnView1.IO.DShowParams.VideoInputs );

// this select the first video input available
ImageEnView1.IO.DShowParams.SetVideoInput( 0 );

// this enables frame grabbing
// ImageEnView1.OnDShowNewFrame event occurs for each frame acquired
ImageEnView1.IO.DShowParams.EnableSampleGrabber:=true;

// connect to the video input: this begins video capture
ImageEnView1.IO.DShowParams.Connect;

..

// disconnect the video input
ImageEnView1.IO.DShowParams.Disconnect;

Capture a frame

// we are inside the OnDShowNewFrame event:
procedure Tfmain.ImageEnView1DShowNewFrame(Sender: TObject);
begin
   // copy current sample to ImageEnView bitmap
   ImageEnView1.IO.DShowParams.GetSample(ImageEnView1.IEBitmap);
   // refresh ImageEnView1
   ImageEnView1.Update;
end;

Setting video capture size

// we'd like to acquire 640x480 frames
ImageEnView1.IO.DShowParams.SetCurrentVideoFormat( 640, 480,'' );

Select a TV Tuner channel

// we want channel 15
ImageEnView1.IO.DShowParams.TunerChannel:=15;

Showing capture card dialogs

// show video dialog
ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInput,ietFilter);

// show video source dialog
ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInputSource,ietFilter);

// show tuner dialog
ImageEnView1.IO.DShowParams.ShowPropertyPages(iepTuner,ietFilter);

// show format dialog
ImageEnView1.IO.DShowParams.ShowPropertyPages(iepVideoInput,ietOutput);

Read from a multimedia file, and save with another compression

ImageEnView1.IO.DShowParams.FileInput:='input.avi';
ImageEnView1.IO.DShowParams.FileOutput:='output.avi';
ImageEnView1.IO.DShowParams.SetVideoCodec( .. );
ImageEnView1.IO.DShowParams.SetAudioCodec( .. );

ImageEnView1.IO.DShowParams.EnableSampleGrabber:=true;
ImageEnView1.IO.DShowParams.Connect;

See also 'directshow1' and 'directshow2' example for more info.
!!}
function TImageEnIO.GetDShowParams: TIEDirectShow;
begin
  if not assigned(fDShow) then
  begin
    fDShow := TIEDirectShow.Create;
    if assigned(fImageEnView) then
    begin
      fDShow.SetNotifyWindow(fImageEnView.Handle, IEM_NEWFRAME, IEM_EVENT)
    end;
  end;
  result := fDShow;
end;
{$ENDIF}

procedure TImageEnIO.CheckDPI;
begin
  if fParams.DpiX < 2 then
    fParams.DpiX := gDefaultDPIX;
  if fParams.DpiY < 2 then
    fParams.DpiY := gDefaultDPIY;
end;

{!!
<FS>IECalcJpegFileQuality

<FM>Declaration<FC>
function IECalcJpegFileQuality(const FileName:WideString):integer;

<FM>Description<FN>
This function estimates the quality of a Jpeg file.
Returned value can be used with the <A TIOParamsVals.JPEG_Quality> property.

<FM>Example<FC>
ImageEnView1.LoadFromFile('input.jpg');
// do image processing here..
ImageEnView1.IO.Params.JPEG_Quality:=IECalcJpegFileQuality('input.jpg');
ImageEnView1.IO.SaveToFile('output.jpg');

!!}
function IECalcJpegFileQuality(const FileName: WideString): integer;
var
  fs: TIEWideFileStream;
begin
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := IECalcJpegStreamQuality(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>IECalcJpegStreamQuality

<FM>Declaration<FC>
function IECalcJpegStreamQuality(Stream:TStream):integer;

<FM>Description<FN>
This function estimates the quality of a Jpeg file.
Returned value can be used with the <A TIOParamsVals.JPEG_Quality> property.

<FM>Example<FC>
ImageEnView1.LoadFromFile('input.jpg');
// do image processing here..
ImageEnView1.IO.Params.JPEG_Quality:=IECalcJpegFileQuality('input.jpg');
ImageEnView1.IO.SaveToFile('output.jpg');

!!}
function IECalcJpegStreamQuality(Stream: TStream): integer;
var
  qt:pointer;
  QTables: pintegerarray;
  QTablesCount: integer;
  i: integer;
begin
  QTablesCount := IEGetJpegQuality(Stream, qt);
  QTables:=qt;
  // returns the average of all qtables
  result := 0;
  for i := 0 to QTablesCount - 1 do
    result := result + QTables[i];
  result := result div QTablesCount;
  //
  freemem(qt);
end;

{$ifdef IEINCLUDERAWFORMATS}
procedure TImageEnIO.SyncLoadFromStreamRAW(Stream: TStream);
var
  Progress: TProgressRec;
  ff:TIOFileType;
begin
  ff:=IEExtToFileFormat('RAW');
  if ff=ioRAW then
  begin
    // use internal implementation
    try
      fAborting := false;
      Progress.Aborting := @fAborting;
      if not MakeConsistentBitmap([]) then
        exit;
      fParams.ResetInfo;
      Progress.fOnProgress := fOnIntProgress;
      Progress.Sender := Self;
      fIEBitmap.RemoveAlphaChannel;
      IEReadCameraRAWStream(Stream, fIEBitmap, fParams, Progress, false);
      CheckDPI;
      if fAutoAdjustDPI then
        AdjustDPI;
      fParams.fFileName := '';
      fParams.fFileType := ioRAW;
      SetViewerDPI(fParams.DpiX, fParams.DpiY);
      Update;
    finally
      DoFinishWork;
    end;
  end
  else
    // use external plugin if available
    LoadFromStreamFormat(Stream,ff);
end;
{$endif}

{$ifdef IEINCLUDERAWFORMATS}
{!!
<FS>TImageEnIO.LoadFromStreamRAW

<FM>Declaration<FC>
procedure LoadFromStreamRAW(Stream: TStream);

<FM>Description<FN>
Loads an image from a stream as Camera RAW. 

See also <A List of supported Camera RAW formats>
!!}
procedure TImageEnIO.LoadFromStreamRAW(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamRAW, Stream);
    exit;
  end;
  SyncLoadFromStreamRAW(Stream);
end;
{$endif}

{$ifdef IEINCLUDERAWFORMATS}
{!!
<FS>TImageEnIO.LoadFromFileRAW

<FM>Declaration<FC>
procedure LoadFromFileRAW(const FileName: WideString);

<FM>Description<FN>
Loads an image from a file as Camera RAW.

See also <A List of supported Camera RAW formats>
!!}
procedure TImageEnIO.LoadFromFileRAW(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileRAW, FileName);
    exit;
  end;
  fs := TIEWideFileStream.create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamRAW(fs);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;
{$endif}

{$ifdef IEINCLUDEDIRECTSHOW}
{!!
<FS>TImageEnIO.OpenMediaFile

<FM>Declaration<FC>
function OpenMediaFile(const FileName: WideString):integer;

<FM>Description<FN>
OpenMediaFile opens a video file using DirectShow which allows you to load AVI, Mpeg, WMV and other DirectX supported formats.
It opens the file, but doesn't actually get the image. To get a frame use <A TImageEnIO.LoadFromMediaFile> method.
To close the media file use <A TImageEnIO.CloseMediaFile>.

<FM>Example<FC>

// saves the frame 10 as 'frame10.jpg'
ImageEnView1.IO.OpenMediaFile('film.mpeg');
ImageEnView1.IO.LoadFromMediaFile(10);
ImageEnView1.IO.SaveToFile('frame10.jpg');
ImageEnView1.IO.CloseMediaFile;
!!}
function TImageEnIO.OpenMediaFile(const FileName: WideString):integer;
var
  l:int64;
  ww,hh:integer;
  fmt:AnsiString;
  avgtime,ltime:int64;
begin
  result:=0;
  if assigned(fOpenMediaFile) then
    CloseMediaFile;
  fAborting := True;
  fOpenMediaFile:=TIEDirectShow.Create;

  fOpenMediaFile.FileInput:=AnsiString(FileName);
  fOpenMediaFile.EnableSampleGrabber:=true;
  fOpenMediaFile.Connect;

  fOpenMediaFile.Pause;

  fOpenMediaFile.TimeFormat:=tfTime;
  ltime:=fOpenMediaFile.Duration;
  if (ltime=0) then
    exit;
  fOpenMediaFile.TimeFormat:=tfFrame;
  l:=fOpenMediaFile.Duration;
  avgtime:=fOpenMediaFile.GetAverageTimePerFrame;

  if (l=ltime) and (avgtime<>0) then
  begin
    l:=l div avgtime;
    fOpenMediaFileMul:=avgtime;
  end
  else
    fOpenMediaFileMul:=1;
  fOpenMediaFileRate:=(ltime/10000000)/l*1000;  // 2.2.4(rc2)

  fAborting:=False;

  fParams.fMEDIAFILE_FrameCount:=l;
  fParams.FileType := ioUnknown;
  fParams.FileName := FileName; // this is important for TImageEnMView

  fOpenMediaFile.GetCurrentVideoFormat(ww,hh,fmt);
  fParams.Width:=ww;
  fParams.Height:=hh;
  fParams.OriginalWidth:=ww;
  fParams.OriginalHeight:=hh;

  result:=l;
end;

{!!
<FS>TImageEnIO.CloseMediaFile

<FM>Declaration<FC>
procedure CloseMediaFile;

<FM>Description<FN>
CloseMediaFile closes a video file open with <A TImageEnIO.OpenMediaFile>.

<FM>Example<FC>

// saves the frame 10 as 'frame10.jpg'
ImageEnView1.IO.OpenMediaFile('film.mpeg');
ImageEnView1.IO.LoadFromMediaFile(10);
ImageEnView1.IO.SaveToFile('frame10.jpg');
ImageEnView1.IO.CloseMediaFile;

!!}
procedure TImageEnIO.CloseMediaFile;
begin
  if assigned(fOpenMediaFile) then
  begin
    fOpenMediaFile.Disconnect;
    FreeAndNil(fOpenMediaFile);
  end;
end;

{!!
<FS>TImageEnIO.LoadFromMediaFile

<FM>Declaration<FC>
procedure LoadFromMediaFile(FrameIndex:integer);

<FM>Description<FN>
LoadFromMediaFile loads the specified frame from a media file open using <A TImageEnIO.OpenMediaFile>.
The first frame has index 0.

<FM>Example<FC>

// saves the frame 10 as 'frame10.jpg'
ImageEnView1.IO.OpenMediaFile('film.mpeg');
ImageEnView1.IO.LoadFromMediaFile(10);
ImageEnView1.IO.SaveToFile('frame10.jpg');
ImageEnView1.IO.CloseMediaFile;

!!}
procedure TImageEnIO.LoadFromMediaFile(FrameIndex:integer);
begin
  if assigned(fOpenMediaFile) then
  begin
    fParams.TIFF_ImageIndex := FrameIndex;
    fParams.GIF_ImageIndex := FrameIndex;
    fParams.DCX_ImageIndex := FrameIndex;

    fOpenMediaFile.position:= int64(FrameIndex) * int64(fOpenMediaFileMul);

    fOpenMediaFile.GetSample( fIEBitmap );
    fParams.fMEDIAFILE_FrameDelayTime:=round(fOpenMediaFileRate);
    Update;
  end;
end;

{!!
<FS>TImageEnIO.IsOpenMediaFile

<FM>Declaration<FC>
function IsOpenMediaFile:boolean;

<FM>Description<FN>
Returns True when OpenMediaFile has currently open a file.
!!}
function TImageEnIO.IsOpenMediaFile:boolean;
begin
  result:=assigned(fOpenMediaFile);
end;

{$endif}

{!!
<FS>IEGetFileFramesCount

<FM>Declaration<FC>
function IEGetFileFramesCount(const FileName:WideString):integer;

<FM>Description<FN>
This is a generic way to get number of frames in a multipage file (GIF, TIFF, AVI, MPEG...) or a single page (JPEG...).

<FM>See also<FN>
<A Helper functions>
!!}
function IEGetFileFramesCount(const FileName:WideString):integer;
var
  fi:TIEFileFormatInfo;
  ie:TImageEnView;
begin
  fi:=IEFileFormatGetInfo2(string(IEExtractFileExtW(FileName)));
  if assigned(fi) and (fi.FileType<>ioUnknown) and (fi.FileType<>ioAVI) then
  begin
    case fi.FileType of
      ioGIF:   result:=EnumGifIm(FileName);
      ioTIFF:  result:=EnumTIFFIm(FileName);
      ioICO:   result:=EnumICOIm(FileName);
      ioDCX:   result:=EnumDCXIm(FileName);
      {$ifdef IEINCLUDEDICOM}
      ioDICOM: result:=IEDICOMImageCount(string(FileName));
      {$endif}
      {$ifdef IEINCLUDEWIC}
      ioHDP:   result:=IEHDPFrameCount(FileName);
      {$endif}
      else
        result:=1;  // a single page file (jpeg, bmp...)
    end;
  end
  else
  begin
    // AVI or multimedia files (Mpeg,...)
    ie:=TImageEnView.Create(nil);
    {$ifdef IEINCLUDEDIRECTSHOW}
    result:=ie.IO.OpenMediaFile(FileName);
    ie.IO.CloseMediaFile;
    {$else}
    // only AVI supported
    result:=ie.IO.OpenAVIFile(FileName);
    ie.IO.CloseAVIFile;
    {$endif}
    FreeAndNil(ie);
  end;
end;

{!!
<FS>IEExtToFileFormat

<FM>Declaration<FC>
function IEExtToFileFormat(ex:string): <A TIOFileType>;

<FM>Description<FN>
Converts file extension to TIOFileType type.

<FM>See also<FN>
<A Helper functions>
!!}
function IEExtToFileFormat(ex:string): TIOFileType;
var
  fpi: TIEFileFormatInfo;
begin
  fpi := IEFileFormatGetInfo2( LowerCase(ex) );
  if assigned(fpi) then
    result := fpi.FileType
  else
    result := ioUnknown;
end;

{!!
<FS>IEIsInternalFormat

<FM>Declaration<FC>
function IEIsInternalFormat(ex:string):boolean;

<FM>Description<FN>
Returns true if the specified extension is recognized as internal file format.

<FM>See also<FN>
<A Helper functions>
!!}
function IEIsInternalFormat(ex:string):boolean;
var
  fpi: TIEFileFormatInfo;
begin
  fpi := IEFileFormatGetInfo2( LowerCase(ex) );
  result:=assigned(fpi) and fpi.InternalFormat;
end;

procedure TImageEnIO.SyncLoadFromStreamBMPRAW(Stream:TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    IERealRAWReadStream(Stream, fIEBitmap, fParams, Progress);
    fParams.fFileName := '';
    fParams.fFileType := ioBMPRAW;
    Update;
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamBMPRAW

<FM>Declaration<FC>
procedure LoadFromStreamBMPRAW(Stream: TStream);

<FM>Description<FN>
Loads an image from stream as RAW.
This is not camera RAW, but real RAW (named in ImageEn as BMPRAW) where you can specify the channels order, placement, alignment, size, etc..

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Examples<FC>

// load a RAW image, RGB, interleaved, 8 bit aligned, 1024x768
ImageEnView1.LegacyBitmap:=false;
ImageEnView1.IEBitmap.Allocate(1024,768,ie24RGB);
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plInterleaved;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.Params.BMPRAW_HeaderSize:=0;
ImageEnView1.IO.LoadFromStreamBMPRAW( stream );

// load a RAW image, CMYK, interleaved, 8 bit aligned, 1024x768
ImageEnView1.LegacyBitmap:=false;
ImageEnView1.IEBitmap.Allocate(1024,768,ieCMYK);
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plInterleaved;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.Params.BMPRAW_HeaderSize:=0;
ImageEnView1.IO.LoadFromStreamBMPRAW( stream );

!!}
procedure TImageEnIO.LoadFromStreamBMPRAW(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamBMPRAW, Stream);
    exit;
  end;
  SyncLoadFromStreamBMPRAW(Stream);
end;

{!!
<FS>TImageEnIO.LoadFromFileBMPRAW

<FM>Declaration<FC>
procedure LoadFromFileBMPRAW(const FileName: WideString);

<FM>Description<FN>
Loads a file as RAW. This is not camera RAW, but real RAW (named in ImageEn as BMPRAW) where you can specify the channels order, placement, alignment, size, etc..

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Examples<FC>

// load a RAW image, RGB, interleaved, 8 bit aligned, 1024x768
ImageEnView1.LegacyBitmap:=false;
ImageEnView1.IEBitmap.Allocate(1024,768,ie24RGB);
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plInterleaved;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.Params.BMPRAW_HeaderSize:=0;
ImageEnView1.IO.LoadFromFileBMPRAW('input.dat');

// load a RAW image, CMYK, interleaved, 8 bit aligned, 1024x768
ImageEnView1.LegacyBitmap:=false;
ImageEnView1.IEBitmap.Allocate(1024,768,ieCMYK);
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plInterleaved;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.Params.BMPRAW_HeaderSize:=0;
ImageEnView1.IO.LoadFromFileBMPRAW('input.dat');

!!}
procedure TImageEnIO.LoadFromFileBMPRAW(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if FileName='' then
    exit;
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileBMPRAW, FileName);
    exit;
  end;
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamBMPRAW(fs);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;

procedure TImageEnIO.SyncSaveToStreamBMPRAW(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    IERealRAWWriteStream(Stream, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamBMPRAW

<FM>Declaration<FC>
procedure SaveToStreamBMPRAW(Stream: TStream);

<FM>Description<FN>
Saves current image as RAW to stream. This is not camera RAW, but real RAW (named in ImageEn as BMPRAW) where you can specify the channels order, placement, alignment, size, etc..

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Example<FC>

// saves current image as RAW image
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plPlanar;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.SaveToStreamBMPRAW(stream);
!!}
procedure TImageEnIO.SaveToStreamBMPRAW(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamBMPRAW, Stream);
    exit;
  end;
  SyncSaveToStreamBMPRAW(Stream);
end;

{!!
<FS>TImageEnIO.SaveToFileBMPRAW

<FM>Declaration<FC>
procedure SaveToFileBMPRAW(const FileName: WideString);

<FM>Description<FN>
Saves current image as RAW to file. This is not camera RAW, but real RAW (named in ImageEn as BMPRAW) where you can specify the channels order, placement, alignment, size, etc..

<FM>Demo<FN>
Inputoutput/RealRAW

<FM>Example<FC>

// saves current image as RAW image
ImageEnView1.IO.Params.BMPRAW_ChannelOrder:=coRGB;
ImageEnView1.IO.Params.BMPRAW_Planes:= plPlanar;
ImageEnView1.IO.Params.BMPRAW_RowAlign:=8;
ImageEnView1.IO.SaveToFileBMPRAW('output.dat');
!!}
procedure TImageEnIO.SaveToFileBMPRAW(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if FileName='' then
    exit;
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileBMPRAW, FileName);
    exit;
  end;
  fs := nil;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    SyncSaveToStreamBMPRAW(fs);
    fParams.FileName:=FileName;
    fParams.FileType:=ioBMPRAW;
  finally
    FreeAndNil(fs);
  end;
end;

{$ifdef IEINCLUDERAWFORMATS}
{!!
<FS>TImageEnIO.LoadJpegFromFileCRW

<FM>Declaration<FC>
procedure LoadJpegFromFileCRW(const FileName: WideString);

<FM>Description<FN>
Extract and load the large Jpeg encapsulated inside a CRW (canon RAW) file.

<FM>Example<FC>
ImageEnView1.IO.LoadJpegFromFileCRW('input.crw');

!!}
procedure TImageEnIO.LoadJpegFromFileCRW(const FileName: WideString);
var
  Progress: TProgressRec;
  fs: TIEWideFileStream;
begin
  if FileName='' then
    exit;
  fs := TIEWideFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    IECRWGetJpeg(fIEBitmap,fs);
    fParams.fFileName := FileName;
    fParams.fFileType := ioRAW;
    Update;
  finally
    FreeAndNil(fs);
    DoFinishWork;
  end;
end;
{$endif}

{!!
<FS>IEAVISelectCodec

<FM>Declaration<FC>
function IEAVISelectCodec:AnsiString;

<FM>Description<FN>
This function shows Windows codec selection dialog and return the (fourcc) codec string, that you can pass for example to <A TImageEnIO.CreateAVIFile>.
!!}
function IEAVISelectCodec:AnsiString;
var
  AVI_avf: pointer;
  AVI_avs1: pointer;
  AVI_popts: pointer;
  psi: TAviStreamInfo;
  tempfilename:string;
begin
  if not gAVIFILEinit then
  begin
    AVIFileInit;
    gAVIFILEinit := true;
  end;
  AVI_avs1 := nil;
  AVI_avf := nil;
  AVI_popts := nil;
  tempfilename:=IEGetTempFileName('avitemp',DefTEMPPATH)+'.avi';
  if IEFileExists(tempfilename) then
    DeleteFile(tempfilename);
  if AVIFileOpen(PAVIFILE(AVI_avf), PChar(tempfilename), OF_WRITE or OF_CREATE, nil) <> 0 then
    raise EInvalidGraphic.Create('unable to create AVI file');
  try
    ZeroMemory(@psi, sizeof(psi));
    psi.fccType := streamtypeVIDEO;
    psi.dwScale := 1;
    psi.dwRate := 15;
    psi.dwQuality := $FFFFFFFF;
    AVI_popts := AllocMem(sizeof(TAVICOMPRESSOPTIONS));
    psi.dwSuggestedBufferSize := 0;
    psi.rcFrame := rect(0, 0, 640,480);
    AVIFileCreateStream(PAVIFILE(AVI_avf), PAVISTREAM(AVI_avs1), psi);
    if AVISaveOptions(0, 0, 1, @AVI_avs1, @AVI_popts) then
      result:=PAnsiChar(@PAVICOMPRESSOPTIONS(AVI_popts)^.fccHandler)
    else
      result:='';
  finally
    if AVI_popts<>nil then
    begin
      AVISaveOptionsFree(1, PAVICOMPRESSOPTIONS(AVI_popts));
      freemem(AVI_popts);
    end;
    if AVI_avs1<>nil then
      AVIStreamRelease(AVI_avs1);
    if AVI_avf<>nil then
      AVIFileRelease(AVI_avf);
    if IEFileExists(tempfilename) then
      DeleteFile(tempfilename);
  end;
end;

type
TICINFO = packed record
  dwSize: DWORD;
  fccType:DWORD;
  fccHandler:DWORD;
  dwFlags:DWORD;
  dwVersion:DWORD;
  dwVersionICM:DWORD;
  szName:array [0..16-1] of WCHAR;
  szDescription:array [0..128-1] of WCHAR;
  szDriver:array [0..128-1] of WCHAR;
end;
PICINFO = ^TICINFO;

function ICInfo(fccType:DWORD; fccHandler:DWORD; lpicinfo:PICINFO): Boolean; stdcall; external 'MsVfW32.dll' name 'ICInfo';
function ICGetInfo(hic:THandle; lpicinfo:PICINFO; cb:DWORD):LRESULT; stdcall; external 'MsVfW32.dll' name 'ICGetInfo';
function ICOpen(fccType:DWORD; fccHandler:DWORD; wMode:UINT):THandle; stdcall; external 'MsVfW32.dll' name 'ICOpen';
function ICClose(hic:THandle):LRESULT; stdcall; external 'MsVfW32.dll' name 'ICClose';

{!!
<FS>IEAVIGetCodecs

<FM>Declaration<FC>
function IEAVIGetCodecs:TStringList;

<FM>Description<FN>
This function returns a list of Windows codec as (fourcc) codec strings, that you can pass for example to <A TImageEnIO.CreateAVIFile>.
To obtain codecs description use <A IEAVIGetCodecsDescription>.
!!}
function IEAVIGetCodecs:TStringList;
var
  i:integer;
  ic:TICINFO;
  fourcc:AnsiString;
begin
  result:=TStringList.Create;
  FillChar(ic,sizeof(ic),0);
  SetLength(fourcc,4);
  i:=0;
  while true do
  begin
    if not ICInfo(0,i,@ic) then
      break;
    Move(ic.fccHandler,fourcc[1],4);
    result.Add( string(fourcc) );
    inc(i);
  end;
end;

{!!
<FS>IEAVIGetCodecsDescription

<FM>Declaration<FC>
function IEAVIGetCodecsDescription:TStringList;

<FM>Description<FN>
This function returns a list of Windows codec descriptions.
To obtain actual codecs use <A IEAVIGetCodecs>.
!!}
function IEAVIGetCodecsDescription:TStringList;
var
  i:integer;
  ic:TICINFO;
  hic:THandle;
begin
  result:=TStringList.Create;
  FillChar(ic,sizeof(ic),0);
  i:=0;
  while true do
  begin
    if not ICInfo(0,i,@ic) then
      break;
    hic:=ICOpen(ic.fccType,ic.fccHandler,4);
    ICGetInfo(hic,@ic,sizeof(TICINFO));
    result.Add( ic.szDescription );
    ICClose(hic);
    inc(i);
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// input/output plugins

const

// IEX_GetInfo/IEX_SetInfo: available after IEX_ExecuteRead
IEX_IMAGEWIDTH           =$00;
IEX_IMAGEHEIGHT          =$01;
IEX_PIXELFORMAT          =$02;     // IEX_1G, IEX_8G etc
IEX_FORMATDESCRIPTOR     =$03;     // could be the same of IEX_PLUGINDESCRIPTOR plus specific file format info
IEX_IMAGEDATA            =$04;     // RGB data. R,G,B are interlaced and the alignment is 8 bit. First channel is Red.
IEX_IMAGEPALETTE         =$05;     // an array of 256x8 bit RGB triplets, only when format is IEX_8P
IEX_IMAGEDATELENGTH      =$06;     // length of IEX_IMAGEDATA buffer
IEX_ORIGINALIMAGEWIDTH   =$07;
IEX_ORIGINALIMAGEHEIGHT  =$08;

// IEX_GetInfo/IEX_SetInfo: always available after IEX_Initialize
IEX_PLUGINCAPABILITY     =$0101;     // IEX_FILEREADER and/or IEX_FILEWRITER and/or IEX_MULTITHREAD
IEX_PLUGINDESCRIPTOR     =$0102;     // ex. "Camera RAW"
IEX_FILEEXTENSIONS       =$0103;     // ex. "CRW;CR2;NEF;RAW;PEF;RAF;X3F;BAY;ORF;SRF;MRW;DCR"
IEX_AUTOSEARCHEXIF       =$0104;     // plugin provides this value. You should use only with IEX_GetInfo. If true ImageEn will search automatically for EXIF in file
IEX_FORMATSCOUNT         =$0105;     // >1 if the plugin supports multiple formats

// IEX_GetInfo/IEX_SetInfo: values for IEX_CAPABILITY
IEX_FILEREADER           =$0001;
IEX_FILEWRITER           =$0010;
IEX_MULTITHREAD          =$0100;

// IEX_GetInfo/IEX_SetInfo: values for IEX_PIXELFORMAT
IEX_INVALID  =0;
IEX_1G       =1;
IEX_8P       =2;
IEX_8G       =3;
IEX_16G      =4;
IEX_24RGB    =5;
IEX_32F      =6;
IEX_CMYK     =7;
IEX_48RGB    =8;

type

// callbacks (stdcall)
TIEX_Progress = procedure(percentage:integer; UserData:pointer); stdcall;
TIEX_Read = function(buffer:pointer; bufferLength:integer; UserData:pointer):integer; stdcall;
TIEX_Write = function(buffer:pointer; bufferLength:integer; UserData:pointer):integer; stdcall;
TIEX_PositionSet = procedure(position:integer; UserData:pointer); stdcall;
TIEX_PositionGet = function(UserData:pointer):integer; stdcall;
TIEX_Length = function(UserData:pointer):integer; stdcall;
TIEX_GetParameter = procedure(Param:PAnsiChar; value:PAnsiChar; UserData:pointer); stdcall;
TIEX_SetParameter = procedure(Param:PAnsiChar; value:PAnsiChar; UserData:pointer); stdcall;

// callbacks (cdecl)
TIEX_Progress_cdecl = procedure(percentage:integer; UserData:pointer); cdecl;
TIEX_Read_cdecl = function(buffer:pointer; bufferLength:integer; UserData:pointer):integer; cdecl;
TIEX_Write_cdecl = function(buffer:pointer; bufferLength:integer; UserData:pointer):integer; cdecl;
TIEX_PositionSet_cdecl = procedure(position:integer; UserData:pointer); cdecl;
TIEX_PositionGet_cdecl = function(UserData:pointer):integer; cdecl;
TIEX_Length_cdecl = function(UserData:pointer):integer; cdecl;
TIEX_GetParameter_cdecl = procedure(Param:PAnsiChar; value:PAnsiChar; UserData:pointer); cdecl;
TIEX_SetParameter_cdecl = procedure(Param:PAnsiChar; value:PAnsiChar; UserData:pointer); cdecl;


// dll exported (stdcall)
TIEX_GetInfo = function(handle:pointer; info:integer):pointer; stdcall;
TIEX_SetInfo = procedure(handle:pointer; info:integer; value:pointer); stdcall;
TIEX_ExecuteRead = procedure(handle:pointer; parametersOnly:longbool); stdcall;
TIEX_ExecuteWrite = procedure(handle:pointer); stdcall;
TIEX_ExecuteTry = function(handle:pointer):longbool; stdcall;
TIEX_AddParameter = procedure(handle:pointer; param:PAnsiChar); stdcall;
TIEX_SetCallBacks = procedure(handle:pointer; progressfun:TIEX_Progress; readfun:TIEX_Read; writefun:TIEX_Write; posset:TIEX_PositionSet; posget:TIEX_PositionGet; lenfun:TIEX_Length; getparam:TIEX_GetParameter; setparam:TIEX_SetParameter; userData:pointer ); stdcall;
TIEX_Initialize = function(format:integer):pointer; stdcall;
TIEX_Finalize = procedure(handle:pointer); stdcall;

// dll exported (cdecl)
TIEX_GetInfo_cdecl = function(handle:pointer; info:integer):pointer; cdecl;
TIEX_SetInfo_cdecl = procedure(handle:pointer; info:integer; value:pointer); cdecl;
TIEX_ExecuteRead_cdecl = procedure(handle:pointer; parametersOnly:longbool); cdecl;
TIEX_ExecuteWrite_cdecl = procedure(handle:pointer); cdecl;
TIEX_ExecuteTry_cdecl = function(handle:pointer):longbool; cdecl;
TIEX_AddParameter_cdecl = procedure(handle:pointer; param:PAnsiChar); cdecl;
TIEX_SetCallBacks_cdecl = procedure(handle:pointer; progressfun:TIEX_Progress_cdecl; readfun:TIEX_Read_cdecl; writefun:TIEX_Write_cdecl; posset:TIEX_PositionSet_cdecl; posget:TIEX_PositionGet_cdecl; lenfun:TIEX_Length_cdecl; getparam:TIEX_GetParameter_cdecl; setparam:TIEX_SetParameter_cdecl; userData:pointer ); cdecl;
TIEX_Initialize_cdecl = function(format:integer):pointer; cdecl;
TIEX_Finalize_cdecl = procedure(handle:pointer); cdecl;


TIEIOPlugin=record
  libhandle:THandle;
  // stdcall
  IEX_ExecuteRead_std:TIEX_ExecuteRead;
  IEX_ExecuteWrite_std:TIEX_ExecuteWrite;
  IEX_ExecuteTry_std:TIEX_ExecuteTry;
  IEX_AddParameter_std:TIEX_AddParameter;
  IEX_SetCallBacks_std:TIEX_SetCallBacks;
  IEX_Initialize_std:TIEX_Initialize;
  IEX_Finalize_std:TIEX_Finalize;
  IEX_GetInfo_std:TIEX_GetInfo;
  IEX_SetInfo_std:TIEX_SetInfo;
  // cdecl
  IEX_ExecuteRead_cdecl:TIEX_ExecuteRead_cdecl;
  IEX_ExecuteWrite_cdecl:TIEX_ExecuteWrite_cdecl;
  IEX_ExecuteTry_cdecl:TIEX_ExecuteTry_cdecl;
  IEX_AddParameter_cdecl:TIEX_AddParameter_cdecl;
  IEX_SetCallBacks_cdecl:TIEX_SetCallBacks_cdecl;
  IEX_Initialize_cdecl:TIEX_Initialize_cdecl;
  IEX_Finalize_cdecl:TIEX_Finalize_cdecl;
  IEX_GetInfo_cdecl:TIEX_GetInfo_cdecl;
  IEX_SetInfo_cdecl:TIEX_SetInfo_cdecl;

  FileType:TIOFileType;
  PluginsCS:TRTLCriticalSection; // protect non multithreaded plugin
  Capability:integer;
  pluginFormat:integer; // the index of format inside the plugin
  DLLFileName:string;
  use_cdecl:boolean;
end;
PIEIOPlugin=^TIEIOPlugin;

var
  ioplugins:TList;


function IEGetIOPlugin(fileType:TIOFileType):PIEIOPlugin;
var
  i:integer;
begin
  for i:=0 to ioplugins.Count-1 do
  begin
    result:=PIEIOPlugin( ioplugins[i] );
    if result^.FileType=fileType then
      exit;
  end;
  result:=nil;
end;

type
  TIECallbackRecord=record
    OnProgress:TIEProgressEvent;
    OnProgressSender:TObject;
    Stream:TStream;
    params:TIOParamsVals;
  end;
  PIECallBackRecord=^TIECallBackRecord;


procedure CallBack_Progress_std(percentage:integer; userdata:pointer); stdcall;
begin
  with PIECallBackRecord(userdata)^ do
    if assigned(OnProgress) then
      OnProgress( OnProgressSender, percentage );
end;

procedure CallBack_Progress_cdecl(percentage:integer; userdata:pointer); cdecl;
begin
  CallBack_Progress_std(percentage,userdata);
end;

function CallBack_Read_std(buffer:pointer; bufferLength:integer; userdata:pointer):integer; stdcall;
begin
  result:= PIECallBackRecord(userdata)^.Stream.Read(pbyte(buffer)^,bufferLength);
end;

function CallBack_Read_cdecl(buffer:pointer; bufferLength:integer; userdata:pointer):integer; cdecl;
begin
  result:=CallBack_Read_std(buffer,bufferLength,userdata);
end;

function CallBack_Write_std(buffer:pointer; bufferLength:integer; userdata:pointer):integer; stdcall;
begin
  result:=PIECallBackRecord(userdata)^.Stream.Write(pbyte(buffer)^,bufferLength);
end;

function CallBack_Write_cdecl(buffer:pointer; bufferLength:integer; userdata:pointer):integer; cdecl;
begin
  result:=CallBack_Write_std(buffer,bufferLength,userdata);
end;

procedure CallBack_PositionSet_std(position:integer; UserData:pointer); stdcall;
begin
  PIECallBackRecord(userdata)^.Stream.Position:=position;
end;

procedure CallBack_PositionSet_cdecl(position:integer; UserData:pointer); cdecl;
begin
  CallBack_PositionSet_std(position,UserData);
end;

function CallBack_PositionGet_std(UserData:pointer):integer; stdcall;
begin
  result:=PIECallBackRecord(userdata)^.Stream.Position;
end;

function CallBack_PositionGet_cdecl(UserData:pointer):integer; cdecl;
begin
  result:=CallBack_PositionGet_std(UserData);
end;

function CallBack_Length_std(UserData:pointer):integer; stdcall;
begin
  result:=PIECallBackRecord(userdata)^.Stream.Size;
end;

function CallBack_Length_cdecl(UserData:pointer):integer; cdecl;
begin
  result:=CallBack_Length_std(UserData);
end;

procedure CallBack_GetParameter_std(Param:PAnsiChar; Value:PAnsiChar; UserData:pointer); stdcall;
begin
  if assigned( PIECallBackRecord(userdata)^.Params ) then
    StrCopy( Value, PAnsiChar(AnsiString(PIECallBackRecord(userdata)^.Params.GetProperty(WideString(Param)))) );
end;

procedure CallBack_GetParameter_cdecl(Param:PAnsiChar; Value:PAnsiChar; UserData:pointer); cdecl;
begin
  CallBack_GetParameter_std(Param,Value,UserData);
end;

procedure CallBack_SetParameter_std(Param:PAnsiChar; Value:PAnsiChar; UserData:pointer); stdcall;
begin
  if assigned( PIECallBackRecord(userdata)^.Params ) then
    PIECallBackRecord(userdata)^.Params.SetProperty(WideString(Param),WideString(Value));
end;

procedure CallBack_SetParameter_cdecl(Param:PAnsiChar; Value:PAnsiChar; UserData:pointer); cdecl;
begin
  CallBack_SetParameter_std(Param,Value,UserData);
end;




function IEX_GetInfo(p:PIEIOPlugin; handle:pointer; info:integer):pointer;
begin
  if p^.use_cdecl then
    result:=p^.IEX_GetInfo_cdecl(handle,info)
  else
    result:=p^.IEX_GetInfo_std(handle,info);
end;

procedure IEX_SetInfo(p:PIEIOPlugin; handle:pointer; info:integer; value:pointer);
begin
  if p^.use_cdecl then
    p^.IEX_SetInfo_cdecl(handle,info,value)
  else
    p^.IEX_SetInfo_std(handle,info,value);
end;

procedure IEX_ExecuteRead(p:PIEIOPlugin; handle:pointer; parametersOnly:longbool);
begin
  if p^.use_cdecl then
    p^.IEX_ExecuteRead_cdecl(handle,parametersOnly)
  else
    p^.IEX_ExecuteRead_std(handle,parametersOnly);
end;

procedure IEX_ExecuteWrite(p:PIEIOPlugin; handle:pointer);
begin
  if p^.use_cdecl then
    p^.IEX_ExecuteWrite_cdecl(handle)
  else
    p^.IEX_ExecuteWrite_std(handle);
end;

function IEX_ExecuteTry(p:PIEIOPlugin; handle:pointer):longbool;
begin
  if p^.use_cdecl then
    result:=p^.IEX_ExecuteTry_cdecl(handle)
  else
    result:=p^.IEX_ExecuteTry_std(handle);
end;

procedure IEX_AddParameter(p:PIEIOPlugin; handle:pointer; param:PAnsiChar);
begin
  if p^.use_cdecl then
    p^.IEX_AddParameter_cdecl(handle,param)
  else
    p^.IEX_AddParameter_std(handle,param);
end;

procedure IEX_SetCallBacks(p:PIEIOPlugin; handle:pointer; userData:pointer);
begin
  if p^.use_cdecl then
    p^.IEX_SetCallBacks_cdecl(handle, CallBack_Progress_cdecl, CallBack_Read_cdecl, CallBack_Write_cdecl, CallBack_PositionSet_cdecl, CallBack_PositionGet_cdecl, CallBack_Length_cdecl, CallBack_GetParameter_cdecl, CallBack_SetParameter_cdecl, userData)
  else
    p^.IEX_SetCallBacks_std(handle, CallBack_Progress_std, CallBack_Read_std, CallBack_Write_std, CallBack_PositionSet_std, CallBack_PositionGet_std, CallBack_Length_std, CallBack_GetParameter_std, CallBack_SetParameter_std, userData)
end;

function IEX_Initialize(p:PIEIOPlugin; format:integer):pointer;
begin
  if p^.use_cdecl then
    result:=p^.IEX_Initialize_cdecl(format)
  else
    result:=p^.IEX_Initialize_std(format);
end;

procedure IEX_Finalize(p:PIEIOPlugin; handle:pointer);
begin
  if p^.use_cdecl then
    p^.IEX_Finalize_cdecl(handle)
  else
    p^.IEX_Finalize_std(handle);
end;





// invert swap low-high bytes (only for 48bit RGB images)
procedure BGRHL(row:PRGB48; width:integer);
var
  i:integer;
begin
  for i:=0 to width-1 do
  begin
    with row^ do
    begin
      r:=IESwapWord(r);
      g:=IESwapWord(g);
      b:=IESwapWord(b);
    end;
    inc(row);
  end;
end;

procedure IEPlgInREAD(InputStream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec; Preview: boolean);
type
  plongbool=^longbool;
var
  p:PIEIOPlugin;
  rec:TIECallbackRecord;
  handle:pointer;
  srcformat:integer;
  width,height,row:integer;
  image:pbyte;
  imagelen:integer;
  rl:integer;
  tempBitmap:TIEBitmap;
  q:integer;
  Stream:TIEBufferedReadStream;
  dd:double;
  tempio:TImageEnIO;
  memstream:TIEMemStream;
  {$ifdef IEINCLUDERAWFORMATS}
  lextra:AnsiString;
  {$endif}
begin
  p:=IEGetIOPlugin( IOParams.FileType );
  if p=nil then
    exit;

  if IOParams.GetThumbnail then
  begin
    // try to load the (EXIF?) thumbnail
    if IOParams.EXIF_Bitmap<>nil then
      IOParams.EXIF_Bitmap.FreeImage(true);
    IOParams.GetThumbnail:=false;
    IEPlgInREAD(InputStream,Bitmap,IOParams,Progress,true);
    IOParams.GetThumbnail:=true;
    if assigned(IOParams.EXIF_Bitmap) and not IOParams.EXIF_Bitmap.IsEmpty then
    begin
      // success, exit
      Bitmap.Assign( IOParams.EXIF_Bitmap );
      exit;
    end;
    {$ifdef IEINCLUDERAWFORMATS}
    if p^.DLLFileName = 'dcrawlib.dll' then // 3.0.1
    begin
      // try to load with "-e" option, if raw
      lextra:=IOParams.RAW_ExtraParams;
      IOParams.RAW_ExtraParams:='-e';
      IOParams.GetThumbnail:=false;
      IEPlgInREAD(InputStream,Bitmap,IOParams,Progress,false);
      IOParams.GetThumbnail:=true;
      IOParams.RAW_ExtraParams:=lextra;
      if not Progress.Aborting^ then
        exit;
    end;
    {$endif}
    // continue loading the full image
    InputStream.Position:=0;
  end;

  if (p^.Capability and IEX_MULTITHREAD)=0 then
    EnterCriticalSection(p^.PluginsCS);

  Stream := TIEBufferedReadStream.Create(InputStream,1024*1024,iegUseRelativeStreams);

  rec.OnProgress:=Progress.fOnProgress;
  rec.OnProgressSender:=Progress.Sender;
  rec.Stream:=Stream;
  rec.params:=IOParams;
  Progress.Aborting^:=false;

  handle:=IEX_Initialize(p,p^.pluginFormat);
  IEX_SetCallBacks(p,handle,@rec);

  try

    if plongbool(IEX_GetInfo(p,handle,IEX_AUTOSEARCHEXIF))^ then
    begin
      // ImageEn will search EXIF info inside the file
      Stream.Position:=0;
      q:=IESearchEXIFInfo(Stream);
      if q>=0 then
      begin
        Stream.Position:=q;
        if IELoadEXIFFromTIFF(Stream,IOParams) then
        begin
          // use dpi of the Exif
          if IOParams.EXIF_ResolutionUnit = 3 then
            dd := 2.54
          else
            dd := 1;
          IOParams.DpiX := trunc(IOParams.EXIF_XResolution * dd);
          IOParams.DpiY := trunc(IOParams.EXIF_YResolution * dd);
        end;
      end else
      begin
        // is this a CRW? (with CIFF instead of EXIF?)
        Stream.Position:=0;
        {$ifdef IEINCLUDERAWFORMATS}
        IECRWGetCIFFAsExif(Stream,IOParams);
        {$endif}
      end;

      // look for IPTC
      Stream.Position:=0;
      tempio:=TImageEnIO.Create(nil);
      try
        tempio.ParamsFromStreamFormat(Stream,ioTIFF);
        IOParams.IPTC_Info.Assign( tempio.Params.IPTC_Info );
      finally
        tempio.free;
      end;

      // reset position
      Stream.Position:=0;
    end;

    IEX_ExecuteRead(p,handle,Preview);

    width:=pinteger(IEX_GetInfo(p,handle,IEX_IMAGEWIDTH))^;
    height:=pinteger(IEX_GetInfo(p,handle,IEX_IMAGEHEIGHT))^;
    srcformat:=pinteger(IEX_GetInfo(p,handle,IEX_PIXELFORMAT))^;
    image:=IEX_GetInfo(p,handle,IEX_IMAGEDATA);

    // set ioparams
    IOParams.Width:=width;
    IOParams.Height:=height;
    if assigned(IEX_GetInfo(p,handle,IEX_ORIGINALIMAGEWIDTH)) then
    begin
      IOParams.OriginalWidth:=pinteger(IEX_GetInfo(p,handle,IEX_ORIGINALIMAGEWIDTH))^;
      IOParams.OriginalHeight:=pinteger(IEX_GetInfo(p,handle,IEX_ORIGINALIMAGEHEIGHT))^;
    end
    else
    begin
      IOParams.OriginalWidth  := width;
      IOParams.OriginalHeight := height;
    end;
    case srcformat of
      IEX_1G     : begin IOParams.BitsPerSample:=1; IOParams.SamplesPerPixel:=1; end;
      IEX_8G     : begin IOParams.BitsPerSample:=8; IOParams.SamplesPerPixel:=1; end;
      IEX_8P     : begin IOParams.BitsPerSample:=8; IOParams.SamplesPerPixel:=1; end;
      IEX_16G    : begin IOParams.BitsPerSample:=16; IOParams.SamplesPerPixel:=1; end;
      IEX_24RGB  : begin IOParams.BitsPerSample:=8; IOParams.SamplesPerPixel:=3; end;
      IEX_48RGB  : begin IOParams.BitsPerSample:=16; IOParams.SamplesPerPixel:=3; end;
      IEX_32F    : begin IOParams.BitsPerSample:=32; IOParams.SamplesPerPixel:=1; end;
      IEX_CMYK   : begin IOParams.BitsPerSample:=8; IOParams.SamplesPerPixel:=4; end;
    end;
    IOParams.FreeColorMap;

    if (image<>nil) and (width<>0) and (height<>0) and not Preview then
    begin

      tempBitmap:=nil;

      if IOParams.IsNativePixelFormat then
      begin
        // native pixel format
        Bitmap.Allocate(width,height,TIEPixelFormat(srcformat));
      end
      else
      begin
        // convert to ie1g or ie24RGB
        if (srcformat=IEX_1G) then
          Bitmap.Allocate(width,height,ie1g)
        else if srcFormat=IEX_24RGB then
          Bitmap.Allocate(width,height,ie24RGB)
        else
        begin
          Bitmap.Allocate(width,height,ie24RGB);
          tempBitmap:=TIEBitmap.Create;
          tempBitmap.Allocate(width,height,TIEPixelFormat(srcformat));
        end;
      end;

      for row:=0 to height-1 do
      begin

        if tempBitmap=nil then
        begin
          // native pixel format of ie1g or ie24RGB
          rl:=IEBitmapRowLen(width, Bitmap.BitCount, 8);
          CopyMemory( Bitmap.Scanline[row], image, rl );
          if Bitmap.PixelFormat=ie24RGB then
            _BGR2RGB( Bitmap.Scanline[row], width );
          if Bitmap.PixelFOrmat=ie48RGB then
            BGRHL( Bitmap.Scanline[row], width );
          inc(image,rl);
        end
        else
        begin
          // non-nativepixelformat or other pixel formats to convert to ie1g or ie24RGB
          rl:=IEBitmapRowLen(width, tempBitmap.BitCount, 8);
          CopyMemory( tempBitmap.Scanline[row], image, rl );
          inc(image,rl);
        end;

      end;

      if tempBitmap<>nil then
      begin
        Bitmap.CopyAndConvertFormat(tempBitmap);
        FreeAndNil(tempBitmap);
      end;

      if IOParams.EXIF_HasEXIFData and IOParams.EnableAdjustOrientation then
      begin
        IEAdjustEXIFOrientation(Bitmap,IOParams.EXIF_Orientation);
        IOParams.EXIF_Orientation:=1; // 3.0.3
      end;

    end;

    if (image<>nil) and not Preview and (srcFormat=IEX_INVALID) then
    begin
      // try to load using known format (in case it is jpeg thumbnail)
      memstream := nil;
      tempio := TImageEnIO.CreateFromBitmap(Bitmap);
      try
        imagelen:=pinteger(IEX_GetInfo(p,handle,IEX_IMAGEDATELENGTH))^;
        memstream:=TIEMemStream.Create(image,imagelen);
        tempio.LoadFromStream(memstream);
        IOParams.Assign(tempio.Params);
      finally
        memstream.free;
        tempio.free;
      end;
    end;

    if (image=nil) and not Preview then
      Progress.Aborting^:=true;

  finally
    IEX_Finalize(p, handle);

    if Stream<>nil then
      FreeAndNil(Stream);
    if (p^.Capability and IEX_MULTITHREAD)=0 then
      LeaveCriticalSection(p^.PluginsCS);
  end;

end;

function IEPlgInTRY(Stream: TStream; TryingFormat:TIOFileType): boolean;
var
  p:PIEIOPlugin;
  rec:TIECallbackRecord;
  handle:pointer;
begin
  p:=IEGetIOPlugin( TryingFormat );
  if p=nil then
  begin
    result:=false;
    exit;
  end;

  rec.OnProgress:=nil;
  rec.OnProgressSender:=nil;
  rec.Stream:=Stream;
  rec.params:=nil;

  if (p^.Capability and IEX_MULTITHREAD)=0 then
    EnterCriticalSection(p^.PluginsCS);

  handle:=IEX_Initialize(p,p^.pluginFormat);

  IEX_SetCallBacks(p,handle, @rec);

  try

    result:=IEX_ExecuteTry(p,handle);

  finally
    IEX_Finalize(p,handle);

    if (p^.Capability and IEX_MULTITHREAD)=0 then
      LeaveCriticalSection(p^.PluginsCS);
  end;

end;

procedure IEPlgInWRITE(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var Progress: TProgressRec);
var
  p:PIEIOPlugin;
  rec:TIECallbackRecord;
  handle:pointer;
  i,rl,row:integer;
  mem:pointer;
  pd:pbyte;
begin
  p:=IEGetIOPlugin( IOParams.FileType );
  if p=nil then
    exit;

  mem := nil;

  rec.OnProgress:=Progress.fOnProgress;
  rec.OnProgressSender:=Progress.Sender;
  rec.Stream:=Stream;
  rec.params:=IOParams;
  Progress.Aborting^:=false;

  if (p^.Capability and IEX_MULTITHREAD)=0 then
    EnterCriticalSection(p^.PluginsCS);

  handle:=IEX_Initialize(p,p^.pluginFormat);

  IEX_SetCallBacks(p,handle, @rec);

  i:=Bitmap.Width;
  IEX_SetInfo(p,handle,IEX_IMAGEWIDTH, @i);
  i:=Bitmap.Height;
  IEX_SetInfo(p,handle,IEX_IMAGEHEIGHT,@i);

  i:=integer(Bitmap.PixelFormat);
  IEX_SetInfo(p,handle,IEX_PIXELFORMAT,@i);
  rl:=IEBitmapRowLen(Bitmap.Width,Bitmap.BitCount,8); // 8 bit aligned

  try

    getmem(mem, rl*Bitmap.Height);

    pd:=mem;
    for row:=0 to Bitmap.Height-1 do
    begin
      CopyMemory(pd,Bitmap.Scanline[row],rl);
      if Bitmap.PixelFormat=ie24RGB then
        _BGR2RGB( PRGB(pd), Bitmap.Width );
      inc(pd,rl);
    end;

    IEX_SetInfo(p,handle,IEX_IMAGEDATA, mem);
    IEX_ExecuteWrite(p,handle);

  finally
    freemem(mem);
    IEX_Finalize(p,handle);
  if (p^.Capability and IEX_MULTITHREAD)=0 then
    LeaveCriticalSection(p^.PluginsCS);
  end;

end;

// return true is the specified plugins is already loaded
// does not compare file path
function IEIsExtIOPluginLoaded(const FileName:string):boolean;
var
  p:PIEIOPlugin;
  i:integer;
begin
  result:=false;
  for i:=0 to ioplugins.Count-1 do
  begin
    p:=ioplugins[i];
    if ExtractFileName(p^.DLLFileName)=ExtractFileName(string(FileName)) then
    begin
      result:=true;
      break;
    end;
  end;
end;

{!!
<FS>IEAddExtIOPlugin

<FM>Declaration<FC>
function IEAddExtIOPlugin(const FileName:string):integer;

<FM>Description<FN>
This function add new file formats using an external dynamic library (dll), named input/output plugin. We suggest to download examples at
http://www.hi-components.com/ndownloads_plgins.asp
here you can find plugins to load and save JBIG, the last release of DCRAW (to load camera RAW) and other useful plugins.
All of them are inclusive of source code, so you can know how write new ones.

Returns the file type that you can use, for example, in <A TImageEnIO.LoadFromStreamFormat>.

<FM>Example<FC>
IEFileFormatRemove(ioRAW);
IEAddExtIOPlugIn('dcrawlib.dll');
IEAddExtIOPlugIn('jbiglib.dll');
IEAddExtIOPlugIn('imagemagick.dll');

<FN>The first instruction is needed only when you add dcrawlib.dll , because ImageEn already has an internal implementation of RAW format. In this way you disable the internal implementation.
A plugin can include more than one file format. For example imagemagick.dll add PCD, DICOM, FITS and many others.
Please read license terms for each plugin downloaded from hicomponents.com web site.

<FM>See also<FN>

<A Helper functions>

!!}
function IEAddExtIOPlugin(const FileName:string):integer;
var
  h:THandle;
  p:PIEIOPlugin;
  FileFormatInfo:TIEFileFormatInfo;
  formatsCount:integer;
  formatIndex:integer;
  done:boolean;
  ph:pointer;
begin
  result:=0;

  if IEIsExtIOPluginLoaded(FileName) then
    exit; // already loaded

  formatIndex:=0;
  repeat

    done:=true;
    h:=LoadLibrary(PChar(FileName));
    if h<>0 then
    begin

      new( p );

      p^.use_cdecl := GetProcAddress(h,'IEX_UseCDECL')<>nil;  // this is a flag not a function!

      if p^.use_cdecl then
      begin
        p^.IEX_ExecuteRead_cdecl := GetProcAddress(h, 'IEX_ExecuteRead');
        p^.IEX_ExecuteWrite_cdecl := GetProcAddress(h, 'IEX_ExecuteWrite');
        p^.IEX_ExecuteTry_cdecl := GetProcAddress(h, 'IEX_ExecuteTry');
        p^.IEX_AddParameter_cdecl := GetProcAddress(h, 'IEX_AddParameter');
        p^.IEX_SetCallBacks_cdecl := GetProcAddress(h, 'IEX_SetCallBacks');
        p^.IEX_Initialize_cdecl := GetProcAddress(h, 'IEX_Initialize');
        p^.IEX_Finalize_cdecl := GetProcAddress(h, 'IEX_Finalize');
        p^.IEX_GetInfo_cdecl := GetProcAddress(h, 'IEX_GetInfo');
        p^.IEX_SetInfo_cdecl := GetProcAddress(h, 'IEX_SetInfo');
      end
      else
      begin
        // stdcall
        p^.IEX_ExecuteRead_std := GetProcAddress(h, 'IEX_ExecuteRead');
        p^.IEX_ExecuteWrite_std := GetProcAddress(h, 'IEX_ExecuteWrite');
        p^.IEX_ExecuteTry_std := GetProcAddress(h, 'IEX_ExecuteTry');
        p^.IEX_AddParameter_std := GetProcAddress(h, 'IEX_AddParameter');
        p^.IEX_SetCallBacks_std := GetProcAddress(h, 'IEX_SetCallBacks');
        p^.IEX_Initialize_std := GetProcAddress(h, 'IEX_Initialize');
        p^.IEX_Finalize_std := GetProcAddress(h, 'IEX_Finalize');
        p^.IEX_GetInfo_std := GetProcAddress(h, 'IEX_GetInfo');
        p^.IEX_SetInfo_std := GetProcAddress(h, 'IEX_SetInfo');
      end;

      if ((@p^.IEX_ExecuteRead_std=nil) or (@p^.IEX_ExecuteWrite_std=nil) or (@p^.IEX_AddParameter_std=nil) or (@p^.IEX_SetCallBacks_std=nil) or
          (@p^.IEX_Initialize_std=nil) or (@p^.IEX_Finalize_std=nil) or (@p^.IEX_GetInfo_std=nil) or (@p^.IEX_SetInfo_std=nil) or (@p^.IEX_ExecuteTry_std=nil)) and
         ((@p^.IEX_ExecuteRead_cdecl=nil) or (@p^.IEX_ExecuteWrite_cdecl=nil) or (@p^.IEX_AddParameter_cdecl=nil) or (@p^.IEX_SetCallBacks_cdecl=nil) or
          (@p^.IEX_Initialize_cdecl=nil) or (@p^.IEX_Finalize_cdecl=nil) or (@p^.IEX_GetInfo_cdecl=nil) or (@p^.IEX_SetInfo_cdecl=nil) or (@p^.IEX_ExecuteTry_cdecl=nil)) then
      begin
        // this is not a plugin dll
        FreeLibrary(h);
        dispose( p );
      end
      else
      begin
        // this is OK
        ph:=IEX_Initialize(p,formatIndex);
        formatsCount:=pinteger(IEX_GetInfo(p,ph,IEX_FORMATSCOUNT))^;
        p^.libhandle:=h;
        p^.DLLFileName:=FileName;
        p^.FileType:=ioDLLPLUGINS + ioplugins.Count;
        p^.pluginFormat:=formatIndex;
        FileFormatInfo:=TIEFileFormatInfo.Create;
        FileFormatInfo.FileType:=p^.FileType;
        FileFormatInfo.FullName:=string(PAnsiChar(IEX_GetInfo(p,ph,IEX_PLUGINDESCRIPTOR))); // plugins can send only ansichars
        FileFormatInfo.Extensions:=string(PAnsiChar(IEX_GetInfo(p,ph,IEX_FILEEXTENSIONS))); // plugins can send only ansichars
        FileFormatInfo.DialogPage:=[];
        FileFormatInfo.InternalFormat:=false;
        p^.Capability:=pinteger( IEX_GetInfo(p,ph,IEX_PLUGINCAPABILITY) )^;
        if (p^.Capability and IEX_FILEREADER)<>0 then
          FileFormatInfo.ReadFunction:=IEPlgInREAD;
        if (p^.Capability and IEX_FILEREADER)<>0 then
          FileFormatInfo.TryFunction:=IEPlgInTRY;
        if (p^.Capability and IEX_FILEWRITER)<>0 then
          FileFormatInfo.WriteFunction:=IEPlgInWRITE;
        if (p^.Capability and IEX_MULTITHREAD)=0 then
          InitializeCriticalSection(p^.PluginsCS);
        ioplugins.Add( p );
        IEFileFormatAdd( FileFormatInfo );
        result:=p^.FileType;
        inc(formatIndex);
        done:= formatIndex=formatsCount;
        IEX_Finalize(p,ph);
      end;

    end;

  until done;
end;

procedure IEUnLoadIOPlugins;
var
  i:integer;
  p:PIEIOPlugin;
begin
  for i:=0 to ioplugins.Count-1 do
  begin
    p:=ioplugins[i];
    IEFileFormatRemove( p^.FileType );
    if (p^.Capability and IEX_MULTITHREAD)=0 then
      DeleteCriticalSection(p^.PluginsCS);
    FreeLibrary( p^.libhandle );
    dispose( p );
  end;
  ioplugins.Clear;
end;

// input/output plugins
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>IEOptimizeGIF

<FM>Declaration<FC>
procedure IEOptimizeGIF(const InputFile,OutputFile:WideString);

<FM>Description<FN>
This procedure optimizes a GIF animations (or multipage) discovering differences among frames and saving in the new GIF only the differences.

<FM>Example<FC>

ImageEnMView1.MIO.SaveToFile('temp.gif');
IEOptimizeGIF('temp.gif','output.gif');

!!}
procedure IEOptimizeGIF(const InputFile,OutputFile:WideString);
var
  i:integer;
  ie:TImageEnView;
  prev:TIEBitmap;
  x,y,w,h:integer;
  p1,p2:PRGB;
  x1,y1,x2,y2:integer;
  a1,a2:pbyte;
  ielist:TList;
begin
  ielist:=TList.Create;
  prev:=TIEBitmap.Create;
  i:=0;
  repeat
    ie:=TImageEnView.Create(nil);
    ielist.Add(ie);
    ie.IO.Params.GIF_ImageIndex:=i;
    ie.IO.LoadFromFileGIF(InputFile);

    if i=0 then
    begin
      // this is the first frame, save as is
      ie.IO.Params.GIF_Action:=ioGIF_DontRemove;
      prev.Assign( ie.IEBitmap );
    end
    else
    begin
      // this is not first frame, check differences with "prev" bitmap
      x1:=1000000;
      y1:=1000000;
      x2:=0;
      y2:=0;
      w:=imin(prev.Width,ie.IEBitmap.Width);
      h:=imin(prev.Height,ie.IEBitmap.Height);
      y:=0;
      while y<h do
      begin
        p1:=prev.Scanline[y];
        a1:=prev.AlphaChannel.Scanline[y];
        p2:=ie.IEBitmap.Scanline[y];
        a2:=ie.IEBitmap.AlphaChannel.Scanline[y];
        for x:=0 to w-1 do
        begin
          if (p1^.r<>p2^.r) or (p1^.g<>p2^.g) or (p1^.b<>p2^.b) then
          begin
            if x < x1 then
              x1 := x;
            if x > x2 then
              x2 := x;
            if y < y1 then
              y1 := y;
            if y > y2 then
              y2 := y;
          end;
          if (a2^=0) and (a1^=255) then
          begin
            x1:=1000000;
            y1:=1000000;
            x2:=0;
            y2:=0;
            y:=h;
            break;
          end;
          inc(p1);
          inc(p2);
          inc(a1);
          inc(a2);
        end;
        inc(y);
      end;
      prev.Assign( ie.IEBitmap );
      if (x1<>1000000) and (y1<>1000000) and (x2<>0) and (y2<>0) then
      begin
        ie.Proc.Crop(x1,y1,x2,y2);
        ie.IO.Params.GIF_XPos:=x1;
        ie.IO.Params.GIF_YPos:=y1;
        ie.IO.Params.GIF_WinWidth:=prev.Width;
        ie.IO.Params.GIF_WinHeight:=prev.Height;
        ie.IO.Params.GIF_Action:=ioGIF_DontRemove;
      end
      else
        ie.IO.Params.GIF_Action:=ioGIF_DrawBackground;
    end;

    inc(i);
  until i=ie.IO.Params.GIF_ImageCount;

  for i:=0 to ielist.Count-1 do
  begin
    ie:=ielist[i];
    if i<ielist.Count-1 then
      ie.IO.Params.GIF_Action:=TImageEnView(ielist[i+1]).IO.Params.GIF_Action;
    if i=0 then
      ie.IO.SaveToFileGIF(OutputFile)
    else
      ie.IO.InsertToFileGIF(OutputFile);
    FreeAndNil(ie);
  end;

  FreeAndNil(prev);
  FreeAndNil(ielist);
end;

procedure TImageEnIO.DoIntProgress(Sender: TObject; per: integer);
begin
  if assigned(fOnProgress) then
  begin
    if assigned(fImageEnView) and (fImageEnView.Parent<>nil) and IsInsideAsyncThreads then
    begin
      // we are inside a thread, so send a message to the parent TImageEnView component, if exists
      {$ifdef IEHASTTHREADSTATICSYNCHRONIZE}
      if not fImageEnView.HandleAllocated then // 3.0.2, to avoid deadlocks
        TThread.Synchronize(nil, SyncGetHandle); // 3.0.1, 15/7/2008 - 13:55
      {$endif}
      PostMessage( fImageEnView.Handle, IEM_PROGRESS, per, 0);
    end
    else
      fOnProgress(Sender,per);
  end;
end;

procedure TImageEnIO.DoFinishWork;
begin
  fOnIntProgress(self, 100);  // fOnIntProgress is always assigned
  if assigned(fOnFinishWork) then
  begin
    if assigned(fImageEnView) and (fImageEnView.Parent<>nil) and IsInsideAsyncThreads then
    begin
      // we are inside a thread, so send a message to the parent TImageEnView component, if exists
      {$ifdef IEHASTTHREADSTATICSYNCHRONIZE}
      if not fImageEnView.HandleAllocated then // 3.0.2, to avoid deadlocks
        TThread.Synchronize(nil, SyncGetHandle); // 3.0.1, 15/7/2008 - 13:55
      {$endif}
      PostMessage( fImageEnView.Handle, IEM_FINISHWORK, 0, 0);
    end
    else
      fOnFinishWork(self);
  end;
end;

{!!
<FS>TImageEnIO.LoadFromStreamPSD

<FM>Declaration<FC>
procedure LoadFromStreamPSD(Stream:TStream);

<FM>Description<FN>
LoadFromStreamPSD loads an image from a Adobe PSD stream.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.

PSD can contain multiple layers. If you want load separated layers write:<FC>
ImageEnView1.IO.Params.PSD_LoadLayers:=true;
ImageEnView1.IO.LoadFromStreamPSD(stream);<FN>

If you want load only the merged image (default) write:<FC>
ImageEnView1.IO.Params.PSD_LoadLayers:=false;
ImageEnView1.IO.LoadFromStreamPSD(stream);<FN>
!!}
{$ifdef IEINCLUDEPSD}
procedure TImageEnIO.LoadFromStreamPSD(Stream:TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamPSD, Stream);
    exit;
  end;
  SyncLoadFromStreamPSD(Stream);
end;
{$endif}

{!!
<FS>TImageEnIO.LoadFromFilePSD

<FM>Declaration<FC>
procedure LoadFromFilePSD(const FileName: WideString);

<FM>Description<FN>
LoadFromFilePSD loads an image from a Adobe PSD file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
FileName is the file name with extension.

PSD can contain multiple layers. If you want load separated layers write:<FC>
ImageEnView1.IO.Params.PSD_LoadLayers:=true;
ImageEnView1.IO.LoadFromFilePSD(filename);<FN>

If you want load only the merged image (default) write:<FC>
ImageEnView1.IO.Params.PSD_LoadLayers:=false;
ImageEnView1.IO.LoadFromFilePSD(filename);<FN>

<FM>Example<FC>

ImageEnView1.IO.Params.PSD_LoadLayers:=true;
ImageEnView1.IO.LoadFromFilePSD('input.psd');

!!}
{$ifdef IEINCLUDEPSD}
procedure TImageEnIO.LoadFromFilePSD(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFilePSD, FileName);
    exit;
  end;
  fs := TIEWideFileStream.create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamPSD(fs);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;
{$endif}

{$ifdef IEINCLUDEPSD}
procedure TImageEnIO.SyncLoadFromStreamPSD(Stream: TStream);
var
  Progress: TProgressRec;
  layers:TList;
  i,l:integer;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;

    if Params.PSD_LoadLayers and Params.PSD_ReplaceLayers and assigned(fImageEnView) and (fImageEnView is TImageEnView) then
      // working with TImageEnView, remove all layers
      (fImageEnView as TImageEnView).LayersClear;

    fIEBitmap.RemoveAlphaChannel;
    layers:=TList.Create;
    IEReadPSD(Stream, fIEBitmap, fParams, Progress, fParams.PSD_LoadLayers, layers);

    if Params.PSD_LoadLayers and assigned(fImageEnView) and (fImageEnView is TImageEnView) then
    begin
      // working with TImageEnView
      if layers.Count>0 then
      begin
        if Params.PSD_ReplaceLayers then
          l:=0
        else
          l:=(fImageEnView as TImageEnView).LayersAdd;

        // create a transparent layer 0 when the first layer is moved
        with TIELayer(layers[0]) do
          if (PosX<>0) or (PosY<>0) then
          begin
            (fImageEnView as TImageEnView).Layers[l].SetDefaults;
            (fImageEnView as TImageEnView).Layers[l].Locked:=true;
            (fImageEnView as TImageEnView).Layers[l].Bitmap.Allocate(fParams.Width,fParams.Height);
            (fImageEnView as TImageEnView).Layers[l].Bitmap.AlphaChannel.Fill(0);
            (fImageEnView as TImageEnView).LayersAdd;
            inc(l);
          end;

        (fImageEnView as TImageEnView).Layers[l].Assign( TIELayer(layers[0]) );
        for i:=1 to layers.count-1 do
        begin
          l:=(fImageEnView as TImageEnView).LayersAdd;
          (fImageEnView as TImageEnView).Layers[l].Assign( TIELayer(layers[i]) );
        end;
      end;
    end
    else if (layers.Count=1) and not fParams.GetThumbnail then
    begin
      // One layer or TImageEnIO
      fIEBitmap.AlphaChannel.Assign( TIELayer(layers[0]).Bitmap.AlphaChannel );
      if (fIEBitmap.Width<>fIEBitmap.AlphaChannel.Width) or (fIEBitmap.Height<>fIEBitmap.AlphaChannel.Height) then
      begin
        // an alpha channel can be moved and of different size
        fIEBitmap.AlphaChannel.Resize(fIEBitmap.AlphaChannel.Width+TIELayer(layers[0]).PosX,
                                      fIEBitmap.AlphaChannel.Height+TIELayer(layers[0]).PosY,0,0,iehRight,ievBottom);
        fIEBitmap.AlphaChannel.Resize(fIEBitmap.Width,fIEBitmap.Height,0,0,iehLeft,ievTop);
      end;
    end;

    for i:=0 to layers.count-1 do
      TIELayer(layers[i]).free;
    layers.free;

    CheckDPI;
    if fAutoAdjustDPI then
      AdjustDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioPSD;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    Update;
  finally
    DoFinishWork;
  end;
end;
{$endif}

{$ifdef IEINCLUDEPSD}
procedure TImageEnIO.SyncSaveToStreamPSD(Stream: TStream);
var
  Progress: TProgressRec;
  merged,view:TImageEnView;
  layers:TList;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
      view:=(fImageEnView as TImageEnView)
    else
      view:=nil;
    if (view<>nil) then
    begin
      merged:=TImageEnView.Create(nil);
      merged.LegacyBitmap:=False;
      view.LayersDrawTo(merged.IEBitmap);
      merged.IEBitmap.Location:=ieMemory;
      merged.IEBitmap.PixelFormat:=view.Layers[0].Bitmap.PixelFormat;
      layers:= view.LayersList;
      IEWritePSD(Stream, fParams, Progress, merged.IEBitmap, layers);
      merged.free;
    end
    else
    begin
      layers:=TList.Create;
      IEWritePSD(Stream, fParams, Progress, fIEBitmap, layers);
      layers.free;
    end;
  finally
    DoFinishWork;
  end;
end;
{$endif}

{!!
<FS>TImageEnIO.SaveToStreamPSD

<FM>Declaration<FC>
procedure SaveToStreamPSD(Stream: TStream);

<FM>Description<FN>
Saves current image or all layers as PSD file format. PSD supports multiple layers, so it can store position and other useful info (like layer name). PSD also have a merged representation of the image to fast preview the merged result.
!!}
{$ifdef IEINCLUDEPSD}
procedure TImageEnIO.SaveToStreamPSD(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamPSD, Stream);
    exit;
  end;
  SyncSaveToStreamPSD(Stream);
end;
{$endif}

{!!
<FS>TImageEnIO.SaveToFilePSD

<FM>Declaration<FC>
procedure SaveToFilePSD(const FileName: WideString);

<FM>Description<FN>
Saves current image or all layers as PSD file format. PSD supports multiple layers, so it can store position and other useful info (like layer name).
PSD also have a merged representation of the image to fast preview the merged result.
!!}
{$ifdef IEINCLUDEPSD}
procedure TImageEnIO.SaveToFilePSD(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFilePSD, FileName);
    exit;
  end;
  fs := nil;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    SyncSaveToStreamPSD(fs);
    fParams.FileName:=FileName;
    fParams.FileType:=ioPSD;
  finally
    FreeAndNil(fs);
  end;
end;
{$endif}

{!!
<FS>IEFindNumberWithKnownFormat

<FM>Declaration<FC>
function IEFindNumberWithKnownFormat( const Directory: WideString ): integer;

<FM>Description<FN>
This function returns the number of images recognized by ImageEn in specified directory.
!!}
// Returns the number of Images with KnownFormat in a Folder
function IEFindNumberWithKnownFormat( const Directory: WideString ): integer;
var
 Found: integer;
 SR: TSearchRec;
 FPath: TFileName;
begin
  Result := 0;
  Found := FindFirst ( Directory + '\*.*', $00000020, SR ); // $00000020=faArchive
  if Found = 0 then
  begin
    while Found = 0 do
    begin
      FPath := Directory + '\' + SR.Name;
      if IsKnownFormat ( FPath ) and ( SR.Attr and $10 = 0 ) then
        inc ( Result );
      Found := FindNext ( SR );
    end;
    FindClose ( SR );
  end;
end;

procedure TImageEnIO.SetPrintLogFile(v: String);
begin
  if iegPrintLogFileName <> '' then
    CloseFile(iegPrintLogFile);
  iegPrintLogFileName := v;
  if v <> '' then
  begin
    AssignFile(iegPrintLogFile, iegPrintLogFileName);
    Rewrite(iegPrintLogFile);
  end;
end;

function TImageEnIO.GetPrintLogFile: String;
begin
  result := iegPrintLogFileName;
end;


procedure IEPrintLogWrite(const ss: String);
begin
  if iegPrintLogFileName <> '' then
  begin
    closefile(iegPrintLogFile);
    assignfile(iegPrintLogFile, string(iegPrintLogFileName));
    append(iegPrintLogFile);
    WriteLn(iegPrintLogFile, datetostr(date) + ' ' + timetostr(time) + ' : ' + ss);
    Flush(iegPrintLogFile);
  end;
end;

{!!
<FS>TImageEnIO.ReplaceStreamTIFF

<FM>Declaration<FC>
function ReplaceStreamTIFF(Stream: TStream): integer;

<FM>Description<FN>
This function saves current image replacing to the specified multi-page TIFF stream, replacing only the image at index specified with <A TImageEnIO.Params>.<A TIOParamsVals.TIFF_ImageIndex>.
Stream position must be at the begin of the TIFF content.
!!}
function TImageEnIO.ReplaceStreamTIFF(Stream: TStream): integer;
var
  lpos:int64;
begin
  lpos:=Stream.Position;
  _DeleteTIFFImStream(Stream, fParams.TIFF_ImageIndex);
  Stream.Position:=lpos;
  result:=InsertToStreamTIFF(Stream);
end;

// 3.0.2
procedure TImageEnIO.SetViewerDPI(dpix, dpiy:integer);
begin
  if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
    with fImageEnView as TImageEnView do
    begin
      LockUpdate;
      SetDpi(fParams.dpix, fParams.dpiy);
      UnlockUpdateEx; // do not call Update
    end;
end;

{$ifdef IEINCLUDEWIC}
{!!
<FS>TImageEnIO.LoadFromStreamHDP

<FM>Declaration<FC>
procedure LoadFromStreamHDP(Stream:TStream);

<FM>Description<FN>
LoadFromStreamPSD loads an image from a Microsoft HD Photo stream.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.

Requires: Windows XP (SP2) with .Net 3.0, Windows Vista.
!!}
procedure TImageEnIO.LoadFromStreamHDP(Stream:TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, LoadFromStreamHDP, Stream);
    exit;
  end;
  SyncLoadFromStreamHDP(Stream);
end;

{!!
<FS>TImageEnIO.LoadFromFileHDP

<FM>Declaration<FC>
procedure LoadFromFileHDP(const FileName: WideString);

<FM>Description<FN>
LoadFromFileHDP loads an image from Microsoft HD Photo file.

If the file does not represent a valid image format, the <A TImageEnIO.Aborting> property will be true.
<FC>FileName<FN> is the file name with extension.

Requires: Windows XP (SP2) with .Net 3.0, Windows Vista.
!!}
procedure TImageEnIO.LoadFromFileHDP(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, LoadFromFileHDP, FileName);
    exit;
  end;
  fs := TIEWideFileStream.create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    SyncLoadFromStreamHDP(fs);
    fParams.fFileName := FileName;
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnIO.SaveToStreamHDP

<FM>Declaration<FC>
procedure SaveToStreamHDP(Stream: TStream);

<FM>Description<FN>
Saves current image or all layers as Microsoft HD Photo file format.

Requires: Windows XP (SP2) with .Net 3.0, Windows Vista.
!!}
procedure TImageEnIO.SaveToStreamHDP(Stream: TStream);
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveStream(self, SaveToStreamHDP, Stream);
    exit;
  end;
  SyncSaveToStreamHDP(Stream);
end;

{!!
<FS>TImageEnIO.SaveToFileHDP

<FM>Declaration<FC>
procedure SaveToFileHDP(const FileName: WideString);

<FM>Description<FN>
Saves current image or all layers as Microsoft HD Photo file format.

Requires: Windows XP (SP2) with .Net 3.0, Windows Vista.
!!}
procedure TImageEnIO.SaveToFileHDP(const FileName: WideString);
var
  fs: TIEWideFileStream;
begin
  if (not fIEBitmapCreated) and fAsyncMode and (not IsInsideAsyncThreads) then
  begin
    TIEIOThread.CreateLoadSaveFile(self, SaveToFileHDP, FileName);
    exit;
  end;
  fs := nil;
  try
    fAborting := true; // this allow fAborting=true when the file is not found (or not accessible)
    fs := TIEWideFileStream.Create(FileName, fmCreate);
    SyncSaveToStreamHDP(fs);
    fParams.FileName:=FileName;
    fParams.FileType:=ioHDP;
  finally
    FreeAndNil(fs);
  end;
end;

procedure TImageEnIO.SyncLoadFromStreamHDP(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    fParams.ResetInfo;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    fIEBitmap.RemoveAlphaChannel;
    IEHDPRead(Stream, fIEBitmap, fParams, Progress, false);
    CheckDPI;
    if fAutoAdjustDPI then
      AdjustDPI;
    fParams.fFileName := '';
    fParams.fFileType := ioHDP;
    SetViewerDPI(fParams.DpiX, fParams.DpiY);
    Update;
  finally
    DoFinishWork;
  end;
end;

procedure TImageEnIO.SyncSaveToStreamHDP(Stream: TStream);
var
  Progress: TProgressRec;
begin
  try
    fAborting := false;
    Progress.Aborting := @fAborting;
    if not MakeConsistentBitmap([]) then
      exit;
    Progress.fOnProgress := fOnIntProgress;
    Progress.Sender := Self;
    IEHDPWrite(Stream, fIEBitmap, fParams, Progress);
  finally
    DoFinishWork;
  end;
end;

{$endif}  // HDP






{$ifdef IEINCLUDERESOURCEEXTRACTOR}


{!!
<FS>TImageEnIO.LoadFromResource

<FM>Declaration<FC>
procedure LoadFromResource(const ModulePath:WideString; const ResourceType:string; const ResourceName:string; Format:TIOFileType);

<FM>Description<FN>
Loads the specified image resource from PE files like EXE, DLL, OCX, ICL, BPL, etc..

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>ModulePath<FN></C> <C>Specifies the path and filename of PE module.</C> </R>
<R> <C><FC>ResourceType<FN></C> <C>Resource type as string (ie 'Bitmap', 'Cursor').</C> </R>
<R> <C><FC>ResourceName<FN></C> <C>Resource name as string (ie 'INTRESOURCE:100', 'Hand').</C> </R>
<R> <C><FC>Format<FN></C> <C>Specifies the expected file format. If Format is ioUnknown, then try to find the format automatically. ioUnknown should fail for BMP, ICO and CUR resources.</C> </R>
</TABLE>

See also <A TIEResourceExtractor>.

<FM>Example<FC>

// loads resource 143, in "Bitmap"s, from "explorer.exe" (should be a little Windows logo)
ImageEnView1.IO.LoadFromResource('explorer.exe', 'Bitmap', 'INTRESOURCE:143', ioBMP);

!!}
procedure TImageEnIO.LoadFromResource(const ModulePath:WideString; const ResourceType:string; const ResourceName:string; Format:TIOFileType);
var
  re:TIEResourceExtractor;
  buffer:pointer;
  bufferLen:integer;
begin
  re := TIEResourceExtractor.Create(ModulePath);
  try
    buffer := re.GetBuffer(AnsiString(ResourceType), AnsiString(ResourceName), bufferLen);
    fParams.IsResource := true;
    LoadFromBuffer(buffer, bufferLen, format);
  finally
    fParams.IsResource := false;
    re.Free;
  end;
end;

{$endif}  // IEINCLUDERESOURCEEXTRACTOR



procedure IEInitialize_imageenio;
begin
  iegUseDefaultFileExists := false;
  DefGIF_LZWDECOMPFUNC := GIFLZWDecompress;
  DefGIF_LZWCOMPFUNC := GIFLZWCompress;
  DefTIFF_LZWDECOMPFUNC := TIFFLZWDecompress;
  DefTIFF_LZWCOMPFUNC := TIFFLZWCompress;
  DefTEMPPATH := '';
  IEInitFileFormats;
  gAVIFILEinit := false;
  (*$ifdef IEINCLUDESANE*)
  InitSANE;
  (*$endif*)
  {$IFDEF IEINCLUDETWAIN}
  iegTWainLogName := '';
  {$ENDIF}
  wininet := 0;
  IEInitWinINet;
  {$IFDEF IEREGISTERTPICTUREFORMATS}
  IERegisterFormats;
  {$ENDIF}
  IEConvertColorFunction := IEDefaultConvertColorFunction;
  iegEnableCMS:=false;
  iegObjectsTIFFTag:=40101;
  ioplugins:=TList.Create;
  iegColorReductionAlgorithm:=-1;
  iegColorReductionQuality:=-1;
  iegUseRelativeStreams:=false;
  iegUseCMYKProfile:=true;
  CMYKProfile:=nil;
  iegMaxImageEMFSize:=8000;
end;

procedure IEFinalize_imageenio;
begin
  FreeAndNil(CMYKProfile);
  FreeAndNil(SRGBProfile);
  {$IFDEF IEREGISTERTPICTUREFORMATS}
  IEUnregisterFormats;
  {$ENDIF}
  IEUnLoadIOPlugins;
  IEFreeFileFormats;
  if gAVIFILEinit then
    AviFileExit;
  IEFreeWinINet;
  (*$ifdef IEINCLUDESANE*)
  ExitSANE;
  (*$endif*)
  {$IFDEF IEINCLUDETWAIN}
  if iegTWainLogName <> '' then
    closefile(iegTWainLogFile);
  {$ENDIF}
  FreeAndNil(ioplugins);
end;



end.



