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
File version 1009
*)


unit hyiedefs;

{$R-}
{$Q-}

{$I ie.inc}

interface

uses Windows, Messages, Classes, SysUtils, Graphics;



const
  // version details
  IEMAINVERSION:string = '3.1.2';
  IEMAINDATEDD = 5;
  IEMAINDATEMM = 9;
  IEMAINDATEYY = 2010;

  IEM_UPDATE = WM_USER + 7000; // message to TImageEnView for Update
  // messages from TImageEnIO.DShowParams
  IEM_NEWFRAME = WM_USER + 7001;
  IEM_EVENT = WM_USER + 7002;
  // async OnProgress/OnFinishWork messages
  IEM_PROGRESS = WM_USER + 7003;
  IEM_FINISHWORK=WM_USER + 7004;

  IEWM_MOUSEHWHEEL = $020E;


// defines IECMYKPROFILE const
{$WARNINGS OFF}
{$I table1.inc}
{$WARNINGS ON}

{$IFDEF UNICODE}
 IEDLLWNameExt = 'W';
{$ELSE}
 IEDLLWNameExt = 'A';
{$ENDIF}

{$ifdef IEOLDSEEKDEF}
 soCurrent = soFromCurrent;
 soBeginning = soFromBeginning;
 soEnd = soFromEnd;
{$endif}

type

{$ifdef FPC}
  TCMWantSpecialKey = TWMKey;
{$endif}


PBitmapInfoHeader256 = ^TBitmapInfoHeader256;

{!!
<FS>PPointArray

<FM>Declaration<FC>
PPointArray = ^<A TPointArray>;
!!}
  PPointArray = ^TPointArray;

{!!
<FS>PIEPointArray

<FM>Declaration<FC>
PIEPointArray = ^<A TIEPointArray>;
!!}
  PIEPointArray = ^TIEPointArray;

{!!
<FS>PPointerArray

<FM>Declaration<FC>
PPointerArray = ^<A TPointerArray>;
!!}
  PPointerArray = ^TPointerArray;


{!!
<FS>PDoubleArray

<FM>Declaration<FC>
PDoubleArray = ^<A TDoubleArray>;
!!}
  PDoubleArray = ^TDoubleArray;

{!!
<FS>PDWordArray

<FM>Declaration<FC>
PDWordArray = ^<A TDWordArray>;
!!}
  PDWordArray = ^TDWordArray;


{!!
<FS>PSingleArray

<FM>Declaration<FC>
PSingleArray = ^<A TSingleArray>;
!!}
  PSingleArray = ^TSingleArray;


{!!
<FS>PRGBA

<FM>Declaration<FC>
PRGBA = ^<A TRGBA>;
!!}
  PRGBA = ^TRGBA;


{!!
<FS>PIERGBAPalette

<FM>Declaration<FC>
PIERGBAPalette = ^<A TIERGBAPalette>;
!!}
  PIERGBAPalette = ^TIERGBAPalette;


{!!
<FS>PRGB

<FM>Declaration<FC>
type PRGB = ^<A TRGB>;
!!}
  PRGB = ^TRGB;


{!!
<FS>PIERGBPalette

<FM>Declaration<FC>
PIERGBPalette = ^<A TIERGBPalette>;
!!}
  PIERGBPalette = ^TIERGBPalette;


{!!
<FS>PCMYK

<FM>Declaration<FC>
PCMYK = ^<A TCMYK>;
!!}
  PCMYK = ^TCMYK;


{!!
<FS>PCIELAB

<FM>Declaration<FC>
PCIELAB = ^<A TCIELAB>;
!!}
  PCIELAB = ^TCIELAB;


{!!
<FS>PCIELABROW

<FM>Declaration<FC>
PCIELABROW = ^<A TCIELABROW>;
!!}
  PCIELABROW = ^TCIELABROW;


{!!
<FS>PYCBCR

<FM>Declaration<FC>
PYCBCR = ^<A TYCBCR>;
!!}
  PYCBCR = ^TYCBCR;


{!!
<FS>PCMYKROW

<FM>Declaration<FC>
PCMYKROW = ^<A TCMYKROW>;
!!}
  PCMYKROW = ^TCMYKROW;


{!!
<FS>PRGBROW

<FM>Declaration<FC>
type PRGBROW = ^<A RGBROW>;
!!}
  PRGBROW = ^RGBROW;

{!!
<FS>PRGB32ROW

<FM>Declaration<FC>
type PRGB32ROW = ^<A RGB32ROW>;
!!}
  PRGB32ROW = ^RGB32ROW;

{!!
<FS>PRGB48ROW

<FM>Declaration<FC>
PRGB48ROW = ^<A TRGB48ROW>;
!!}
  PRGB48ROW = ^TRGB48ROW;

{!!
<FS>PBYTEROW

<FM>Declaration<FC>
PBYTEROW = ^<A TBYTEROW>;
!!}
  PBYTEROW = ^TBYTEROW;

{!!
<FS>PBYTEROWS

<FM>Declaration<FC>
PBYTEROWS = ^<A TBYTEROWS>;
!!}
  PBYTEROWS = ^TBYTEROWS;

{!!
<FS>pIntegerArray

<FM>Declaration<FC>
pIntegerArray = ^<A IntegerArray>;
!!}
  pIntegerArray = ^IntegerArray;

{!!
<FS>PPRGBArray

<FM>Declaration<FC>
type PPRGBArray = ^<A PRGBArray>;
!!}
  PPRGBArray = ^PRGBArray;

{!!
<FS>pboolean

<FM>Declaration<FC>
}
  pboolean = ^boolean;
{!!}


{!!
<FS>PProgressRec

<FM>Declaration<FC>
PProgressRec = ^<A TProgressRec>;
!!}
  PProgressRec = ^TProgressRec;


  // DRAWDIB TYPES
  hDrawDib = THandle;
  TDrawDibTime = record
    timeCount: LongInt;       // see below
    timeDraw: LongInt;        // time to draw bitmaps
    timeDecompress: LongInt;  // time to decompress bitmaps
    timeDither: LongInt;      // time to dither bitmaps
    timeStretch: LongInt;     // time to stretch bitmaps
    timeBlt: LongInt;         // time to transfer bitmaps (BitBlt)
    timeSetDIBits: LongInt;   // time to transfer bitmaps (SetDIBits)
  end;

  // TBitmapInfoHeader + palette 256 colors
  TBitmapInfoHeader256 = packed record
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
    Palette: array[0..1] of TRGBQUAD;
  end;

{!!
<FS>TPointArray

<FM>Declaration<FC>
}
  TPointArray = array[0..Maxint div 16] of Windows.TPoint;
{!!}


  // Why this? Because C++Builder doesn't want TPointArray or PPointArray for variable declarations (not function members)
{!!
<FS>TIEPoint

<FM>Declaration<FC>
}
  TIEPoint = record
    X: Longint;
    Y: Longint;
  end;
{!!}


{!!
<FS>TIEPointArray

<FM>Declaration<FC>
TIEPointArray = array[0..Maxint div 16] of <A TIEPoint>;
!!}
  TIEPointArray = array[0..Maxint div 16] of TIEPoint;


{!!
<FS>TIEQuadCoords

<FM>Declaration<FC>
}
TIEQuadCoords = record
  x0, y0:integer;
  x1, y1:integer;
  x2, y2:integer;
  x3, y3:integer;
end;
{!!}

{!!
<FS>TPointerArray

<FM>Declaration<FC>
}
  TPointerArray = array[0..maxint div 16] of pointer;
{!!}


{!!
<FS>TDoubleArray

<FM>Declaration<FC>
TDoubleArray = array[0..maxint div 16] of double;
!!}
  TDoubleArray = array[0..maxint div 16] of double;


{!!
<FS>TDWordArray

<FM>Declaration<FC>
TDWordArray = array[0..maxint div 16] of dword;
!!}
  TDWordArray = array[0..maxint div 16] of dword;


{!!
<FS>TSingleArray

<FM>Declaration<FC>
TSingleArray = array[0..maxint div 16] of single;
!!}
  TSingleArray = array[0..maxint div 16] of single;


{!!
<FS>TIESmallIntArray

<FM>Declaration<FC>
TIESmallIntArray = array[0..maxint div 16] of SmallInt;
!!}
  TIESmallIntArray = array[0..maxint div 16] of SmallInt;

{!!
<FS>PIESmallIntArray

<FM>Declaration<FC>
PIESmallIntArray = ^TIESmallIntArray;
!!}
  PIESmallIntArray = ^TIESmallIntArray;


{!!
<FS>TRGBA

<FM>Declaration<FC>
}
  TRGBA = packed record
    b: byte;
    g: byte;
    r: byte;
    a: byte;
  end;
{!!}

{!!
<FS>TRGB48

<FM>Declaration<FC>
}
  TRGB48 = packed record
    r: word;
    g: word;
    b: word;
  end;
{!!}

{!!
<FS>PRGB48

<FM>Declaration<FC>
PRGB48 = ^<A TRGB48>;
!!}
  PRGB48 = ^TRGB48;

  TIELine = record
    P, Q: TPoint;
  end;
  TIELineArray = array[0..8192] of TIELine;
  PIELineArray = ^TIELineArray;

{!!
<FS>TIERGBAPalette

<FM>Declaration<FC>
TIERGBAPalette = array[0..maxint div 16] of <A TRGBA>;
!!}
  TIERGBAPalette = array[0..maxint div 16] of TRGBA;

{!!
<FS>TRGB

<FM>Declaration<FC>
}
  TRGB = packed record
    b: byte;
    g: byte;
    r: byte;
  end;
{!!}


{!!
<FS>TIERGBPalette

<FM>Declaration<FC>
TIERGBPalette = array[0..maxint div 16] of <A TRGB>;
!!}
  TIERGBPalette = array[0..maxint div 16] of TRGB;


{!!
<FS>TCMYK

<FM>Declaration<FC>
}
  TCMYK = packed record
    c: byte;
    m: byte;
    y: byte;
    k: byte;
  end;
{!!}

{!!
<FS>TCMYK16

<FM>Declaration<FC>
}
  TCMYK16 = packed record
    c: word;
    m: word;
    y: word;
    k: word;
  end;
{!!}


{!!
<FS>TCIELab

<FM>Declaration<FC>
!!}
  TCIELab = packed record
    l: byte;
    a: shortint;
    b: shortint;
  end;
{!!}

{!!
<FS>TYCbCr

<FM>Declaration<FC>
}
  TYCbCr = packed record
    y: byte;
    Cb: byte;
    Cr: byte;
  end;
{!!}


{!!
<FS>TCMYKROW

<FM>Declaration<FC>
TCMYKROW   = array[0..Maxint div 16] of <A TCMYK>;
!!}
  TCMYKROW   = array[0..Maxint div 16] of TCMYK;


{!!
<FS>TRGB48ROW

<FM>Declaration<FC>
TRGB48ROW  = array[0..Maxint div 16] of <A TRGB48>;
!!}
  TRGB48ROW  = array[0..Maxint div 16] of TRGB48;


{!!
<FS>TCIELABROW

<FM>Declaration<FC>
TCIELABROW = array[0..Maxint div 16] of <A TCIELAB>;
!!}
  TCIELABROW = array[0..Maxint div 16] of TCIELAB;


{!!
<FS>TCIELABROW

<FM>Declaration<FC>
}
  T3dPoint = record
    x, y, z: double;
  end;
{!!}

{!!
<FS>RGBROW

<FM>Declaration<FC>
type RGBROW = array[0 . . Maxint div 16] of <A TRGB>;
!!}
  RGBROW = array[0..Maxint div 16] of TRGB;

{!!
<FS>RGB32ROW

<FM>Declaration<FC>
type RGB32ROW = array[0 . . Maxint div 16] of <A TRGBA>;
!!}
  RGB32ROW = array[0..Maxint div 16] of TRGBA;


  // row of bytes
{!!
<FS>TBYTEROW

<FM>Declaration<FC>
}
  TBYTEROW = array[0..Maxint div 16] of byte;
{!!}


  // array of byte rows
{!!
<FS>TBYTEROWS

<FM>Declaration<FC>
}
  TBYTEROWS = array[0..Maxint div 16] of PBYTEROW;
{!!}


{!!
<FS>IntegerArray

<FM>Declaration<FC>
}
  IntegerArray = array[0..MaxInt div 16] of integer;
{!!}


  // pointer tp array of pointers to TRGB (scanline rows)
{!!
<FS>PRGBArray

<FM>Declaration<FC>
type PRGBArray = array[0 . . Maxint div 16] of pRGB;
!!}
  PRGBArray = array[0..Maxint div 16] of pRGB;

{!!
<FS>TIEProgressEvent

<FM>Declaration<FC>
type TIEProgressEvent = procedure(Sender: TObject; per: integer) of object;

<FM>Description<FN>
<FC>per<FN> is a value from 0 to 100 that indicates the percentage progress made.
!!}
  // Notify progress (per=percentage)
  TIEProgressEvent = procedure(Sender: TObject; per: integer) of object;


{!!
<FS>TIEJob

<FM>Declaration<FC>
}
  TIEJob = (iejNOTHING, // no job / end of work
    iejGENERALPROCESSING, // generic processing
    iejVIDEOCAP_CONNECTING // Video capture - connecting...
    );
{!!}

{!!
<FS>TIEJobEvent

<FM>Declaration<FC>
type TIEJobEvent = procedure(Sender: TObject; job:<A TIEJob>; per:integer) of object;

<FM>Description<FN>
A TIEJobEvent is called during ImageEn processing.

<FC>job<FN> is the job type in progress.
<FC>per<FN> is percentage of performed work related to job.

The <FC>job<FN> parameter can be one of these values:

iejNOTHING : No job / end of work
iejGENERALPROCESSING : generic job
iejVIDEOCAP_CONNECTING : video capture - connecting to video capture card
!!}
  TIEJobEvent = procedure(Sender: TObject; job: TIEJob; per: integer) of object;

{!!
<FS>TProgressRec

<FM>Declaration<FC>
}
  // helper structure for OnProgress
  TProgressRec = record
    fOnProgress: TIEProgressEvent;
    Sender: TObject;
    val: integer; // counter (per=trunc(per1*val))
    tot: integer;
    per1: double; // (100/maxval)
    per2: double;
    Aborting: pboolean;
  end;
{!!}

  // resample filters
{!!
<FS>TResampleFilter

<FM>Declaration<FC>
TResampleFilter = (rfNone, rfTriangle, rfHermite, rfBell, rfBSpline, rfLanczos3, rfMitchell, rfNearest, rfLinear, rfFastLinear, rfBilinear, rfBicubic, rfProjectBW, rfProjectWB);

<FM>Description<FN>
If you need the best quality we suggest: rfHermite, rfBell, rfBSpline, rfLanczos3, rfMitchell, rfNearest, rfBilinear, rfBicubic

If you need speed we suggest: rfTriangle, rfLinear, rfFastLinear

For projects (white on black or black on white) we suggest: rfProjectBW and rfProjectWB
!!}
  TResampleFilter = (rfNone, rfTriangle, rfHermite, rfBell, rfBSpline, rfLanczos3, rfMitchell, rfNearest, rfLinear, rfFastLinear, rfBilinear, rfBicubic, rfProjectBW, rfProjectWB);

  THYIEGraphicHeader = record
    Count: Word; { Fixed at 1 }
    HType: Word; { Fixed at $0100 }
    Size: Longint; { Size not including header }
  end;

{!!
<FS>TMsgLanguage

<FM>Declaration<FC>
Type TMsgLanguage=(msSystem, msEnglish, msItalian, msGerman, msSpanish, msFrench, msPortuguese, msGreek, msRussian, msDutch, msSwedish, msPolish, msJapanese, msCzech, msFinnish, msFarsi, msChinese, msChineseTraditional, msDanish, msTurkish, msKorean, msHungarian, msUser);
!!}
  TMsgLanguage = (
    msSystem
{$IFDEF IESUPPORTENGLISH}
    , msEnglish
{$ENDIF}
{$IFDEF IESUPPORTITALIAN}
    , msItalian
{$ENDIF}
{$IFDEF IESUPPORTGERMAN}
    , msGerman
{$ENDIF}
{$IFDEF IESUPPORTSPANISH}
    , msSpanish
{$ENDIF}
{$IFDEF IESUPPORTFRENCH}
    , msFrench
{$ENDIF}
{$IFDEF IESUPPORTPORTUGUESE}
    , msPortuguese
{$ENDIF}
{$IFDEF IESUPPORTGREEK}
    , msGreek
{$ENDIF}
{$IFDEF IESUPPORTRUSSIAN}
    , msRussian
{$ENDIF}
{$IFDEF IESUPPORTDUTCH}
    , msDutch
{$ENDIF}
{$IFDEF IESUPPORTSWEDISH}
    , msSwedish
{$ENDIF}
{$IFDEF IESUPPORTPOLISH}
    , msPolish
{$ENDIF}
{$IFDEF IESUPPORTJAPANESE}
    , msJapanese
{$ENDIF}
{$IFDEF IESUPPORTCZECH}
    , msCzech
{$ENDIF}
{$IFDEF IESUPPORTFINNISH}
    , msFinnish
{$ENDIF}
{$IFDEF IESUPPORTFARSI}
    , msFarsi
{$ENDIF}
{$IFDEF IESUPPORTCHINESE}
    , msChinese
    , msChineseTraditional
{$ENDIF}
{$IFDEF IESUPPORTDANISH}
    , msDanish
{$ENDIF}
{$IFDEF IESUPPORTTURKISH}
    , msTurkish
{$ENDIF}
{$IFDEF IESUPPORTKOREAN}
    , msKorean
{$ENDIF}
{$IFDEF IESUPPORTHUNGARIAN}
    , msHungarian
{$ENDIF}
{$IFDEF IESUPPORTUSER}
    , msUser
{$ENDIF}
    );

{!!
<FS>TMsgLanguageWords

<FM>Declaration<FC>
}
  TMsgLanguageWords = (IEMSG_PREVIEW, IEMSG_SOURCE, IEMSG_RESULT, IEMSG_OK, IEMSG_CANCEL,
    IEMSG_LOCKPREVIEW, IEMSG_COPYRESULTTOSOURCE, IEMSG_CONTRAST, IEMSG_BRIGHTNESS,
    IEMSG_HUE, IEMSG_SATURATION, IEMSG_VALUE, IEMSG_BASECOLOR, IEMSG_NEWCOLOR,
    IEMSG_LUMINOSITY, IEMSG_RED, IEMSG_GREEN, IEMSG_BLUE, IEMSG_FILTERVALUES, IEMSG_PRESETS,
    IEMSG_DIVISOR, IEMSG_LOAD, IEMSG_SAVE, IEMSG_EQUALIZATION, IEMSG_THRESHOLD, IEMSG_EQUALIZE,
    IEMSG_HISTOGRAM, IEMSG_GRAY, IEMSG_LIGHT, IEMSG_LEFT, IEMSG_TOP, IEMSG_WIDTH, IEMSG_HEIGHT,
    IEMSG_COLOR, IEMSG_SOURCEIMAGEQUANTITY, IEMSG_LENS, IEMSG_REFRACTION, IEMSG_PARAMETERSPREVIEW,
    IEMSG_QUALITY, IEMSG_DCTMETHOD, IEMSG_SMOOTHINGFACTOR, IEMSG_GRAYSCALE, IEMSG_OPTIMALHUFFMAN,
    IEMSG_ORIGINALSIZE, IEMSG_COMPRESSEDSIZE, IEMSG_ADVANCED, IEMSG_PROGRESSIVE, IEMSG_COMPRESSION,
    IEMSG_IMAGEINDEX, IEMSG_PHOTOMETRIC, IEMSG_SCANNDEDDOCUMENTINFO, IEMSG_NAME, IEMSG_DESCRIPTION,
    IEMSG_PAGENAME, IEMSG_PAGENUMBER, IEMSG_OF, IEMSG_HORIZPOSITIONINCH, IEMSG_VERTPOSITIONINCH,
    IEMSG_COLORS, IEMSG_TRANSPARENT, IEMSG_TRANSPARENTCOLOR, IEMSG_INTERLACED, IEMSG_BACKGROUND,
    IEMSG_HORIZPOSITION, IEMSG_VERTPOSITION, IEMSG_DELAYTIME, IEMSG_FILTER, IEMSG_WAVE,
    IEMSG_AMPLITUDE, IEMSG_WAVELENGTH, IEMSG_PHASE, IEMSG_REFLECTIVE, IEMSG_USERFILTER,
    IEMSG_MORPHFILTER, IEMSG_WINDOWSIZE, IEMSG_MAXIMUM, IEMSG_MINIMUM, IEMSG_OPEN,
    IEMSG_CLOSE, IEMSG_ROTATE, IEMSG_FLIP, IEMSG_FLIPHOR, IEMSG_FLIPVER,
    IEMSG_FREQUENCYDOMAINIMAGE, IEMSG_SELECTTHEREGIONTOCLEAR, IEMSG_CLEAR, IEMSG_RESET,
    IEMSG_ANIMATE, IEMSG_LOADFILTER, IEMSG_SAVEFILTER, IEMSG_BUMPMAP, IEMSG_PRINT, IEMSG_MARGINS, IEMSG_INCHES,
    IEMSG_RIGHT, IEMSG_BOTTOM, IEMSG_POSITION, IEMSG_SIZE, IEMSG_NORMAL, IEMSG_FITTOPAGE, IEMSG_STRETCHTOPAGE,
    IEMSG_SPECIFIEDSIZE, IEMSG_GAMMACORRECTION, IEMSG_VALUE2, IEMSG_PRINTSETUP, IEMSG_LEFTMARGIN, IEMSG_TOPMARGIN,
    IEMSG_RIGHTMARGIN, IEMSG_BOTTOMMARGIN, IEMSG_LOCATIONSIZE, IEMSG_TOPLEFT, IEMSG_TOPCENTER, IEMSG_TOPRIGHT,
    IEMSG_CENTERLEFT, IEMSG_CENTER, IEMSG_CENTERRIGHT, IEMSG_BOTTOMLEFT, IEMSG_BOTTOMCENTER, IEMSG_BOTTOMRIGHT,
    IEMSG_CLOSE2, IEMSG_APPLY, IEMSG_MEASUREUNITS, IEMSG_UNITS, IEMSG_RATE,
    IEMSG_ALLGRAPHICS, IEMSG_VIDEOFORWINDOWS, IEMSG_FILE, IEMSG_MEM, IEMSG_LOCKPREVIEWHINT,
    IEMSG_PRINTALL, IEMSG_PRINTSELECTED, IEMSG_COMMONGRAPHICFILES, IEMSG_ALLFILES,
    IEMSG_HSV, IEMSG_HSL, IEMSG_RGB, IEMSG_FFT, IEMSG_SHARPEN, IEMSG_CHANNELS,
    IEMSG_PIXEL, IEMSG_FRAMES, IEMSG_BIT, IEMSG_BYTE, IEMSG_DPI, IEMSG_KB, IEMSG_FIT
    );
{!!}

type
  TIELANGUAGECHARINFO = record
    CharSet:TFontCharset;
    FontName:string;  // empty string means predefined
    CodePage:word;
  end;

const

  IELANGUAGECHARINFO:array [TMsgLanguage] of TIELANGUAGECHARINFO = (
      (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:0)
{$IFDEF IESUPPORTENGLISH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTITALIAN}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTGERMAN}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTSPANISH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTFRENCH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTPORTUGUESE}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTGREEK}
    , (CharSet:GREEK_CHARSET; FontName:''; CodePage:1253)
{$ENDIF}
{$IFDEF IESUPPORTRUSSIAN}
    , (CharSet:RUSSIAN_CHARSET; FontName:''; CodePage:1251)
{$ENDIF}
{$IFDEF IESUPPORTDUTCH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTSWEDISH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTPOLISH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1250)
{$ENDIF}
{$IFDEF IESUPPORTJAPANESE}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:932)
{$ENDIF}
{$IFDEF IESUPPORTCZECH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1250)
{$ENDIF}
{$IFDEF IESUPPORTFINNISH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTFARSI}
    , (CharSet:ARABIC_CHARSET; FontName:'Tahoma'; CodePage:1256)
{$ENDIF}
{$IFDEF IESUPPORTCHINESE}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:936) // chinese
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:950) // chinese trad.
{$ENDIF}
{$IFDEF IESUPPORTDANISH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
{$IFDEF IESUPPORTTURKISH}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1254)
{$ENDIF}
{$IFDEF IESUPPORTKOREAN}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:949)
{$ENDIF}
{$IFDEF IESUPPORTHUNGARIAN}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1250)
{$ENDIF}
{$IFDEF IESUPPORTUSER}
    , (CharSet:DEFAULT_CHARSET; FontName:''; CodePage:1252)
{$ENDIF}
    );


  IESELBREAK = $FFFFF; // selection break code

  IETAGSIZE: array [1..12] of word = (1, 1, 2, 4, 8, 1, 1, 2, 4, 8, 4, 8); // size of tags

  // YUV formats
  IEBI_IYU1 = $31555949;
  IEBI_IYU2 = $32555949;
  IEBI_UYVY = $59565955;
  IEBI_UYNV = $564E5955;
  IEBI_cyuv = $76757963;
  IEBI_YUY2 = $32595559;
  IEBI_YUNV = $564E5559;
  IEBI_YVYU = $55595659;
  IEBI_Y41P = $50313459;
  IEBI_Y211 = $31313259;
  IEBI_Y41T = $54313459;
  IEBI_Y42T = $54323459;
  IEBI_CLJR = $524A4C43;
  IEBI_YVU9 = $39555659;
  IEBI_IF09 = $39304649;
  IEBI_YV12 = $32315659;
  IEBI_I420 = $30323449;
  IEBI_IYUV = $56555949;
  IEBI_CLPL = $4C504C43;

var

  ieMessages: array[TMsgLanguage] of array[TMsgLanguageWords] of string;

  gAVIFILEinit: boolean; // true if AVIFILE library has been initialized

{!!
<FS>gRedToGrayCoef

<FM>Declaration<FC>
gRedToGrayCoef:integer;

<FM>Description<FN>
Specify the red coefficient used to convert from color to gray scale. Default values are 21, 71 and 8. The conversion formula is:
<FC>gray := (Red * <A gRedToGrayCoef> + Green * <A gGreenToGrayCoef> + Blue * <A gBlueToGrayCoef>) div 100;
!!}
  gRedToGrayCoef:integer;

{!!
<FS>gGreenToGrayCoef

<FM>Declaration<FC>
gGreenToGrayCoef:integer;

<FM>Description<FN>
Specify the green coefficient used to convert from color to gray scale. Default values are 21, 71 and 8. The conversion formula is:
<FC>gray := (Red * <A gRedToGrayCoef> + Green * <A gGreenToGrayCoef> + Blue * <A gBlueToGrayCoef>) div 100;
!!}
  gGreenToGrayCoef:integer;

{!!
<FS>gBlueToGrayCoef

<FM>Declaration<FC>
gBlueToGrayCoef:integer;

<FM>Description<FN>
Specify the blue coefficient used to convert from color to gray scale. Default values are 21, 71 and 8. The conversion formula is:
<FC>gray := (Red * <A gRedToGrayCoef> + Green * <A gGreenToGrayCoef> + Blue * <A gBlueToGrayCoef>) div 100;
!!}
  gBlueToGrayCoef:integer;

{!!
<FS>iegDialogsBackground

<FM>Declaration<FC>
iegDialogsBackground:(iedbDefault, iedbPaper, iedbMetal);

<FM>Description<FN>
Specify the default dialogs (image processing, printing, ..) background style. This is not the image background, but actually the dialog background.
!!}
  iegDialogsBackground:(iedbDefault, iedbPaper, iedbMetal);


type

  IIESequentialStream = interface(IUnknown)
    ['{0c733a30-2a1c-11ce-ade5-00aa0044773d}']
    function Read(pv:pointer; cb:dword; pcbRead:PDWORD): HResult; stdcall;
    function Write(pv:pointer; cb:dword; pcbWritten:PDWORD): HResult; stdcall;
  end;

  IE_STATSTG = record
  end;

  IIEStream = interface(IIESequentialStream)
    ['{0000000C-0000-0000-C000-000000000046}']
    function Seek(dlibMove:int64; dwOrigin:dword; var plibNewPosition:int64): HResult; stdcall;
    function SetSize(libNewSize:int64): HResult; stdcall;
    function CopyTo(pstm:IIEStream; cb:int64; var pcbRead:int64; var pcbWritten:int64): HResult; stdcall;
    function Commit(grfCommitFlags:dword): HResult; stdcall;
    function Revert(): HResult; stdcall;
    function LockRegion(libOffset:int64; cb:int64; dwLockType:dword): HResult; stdcall;
    function UnlockRegion(libOffset:int64; cb:int64; dwLockType:dword): HResult; stdcall;
    function Stat(var pstatstg:IE_STATSTG; grfStatFlag:dword): HResult; stdcall;
    function Clone(var ppstm:IIEStream): HResult; stdcall;
  end;


procedure IEInitialize_hyiedefs;
procedure IEFinalize_hyiedefs;





implementation

uses hyieutils, imageenio,imageenview,imageenproc;


procedure IEInitialize_hyiedefs;
begin
  gRedToGrayCoef:=21;
  gGreenToGrayCoef:=71;
  gBlueToGrayCoef:=8;
  iegDialogsBackground:=iedbDefault;
end;

procedure IEFinalize_hyiedefs;
begin
end;



end.
