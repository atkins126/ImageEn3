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
File version 1055
*)


unit hyieutils;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}


{$R-}
{$Q-}

{$I ie.inc}

interface

uses Windows, Messages, Forms, Classes, StdCtrls, Graphics, Controls, SysUtils, hyiedefs, iewords;


type

{!!
<FS>TIECompareFunction

<FM>Declaration<FC>
}
  TIECompareFunction=function(Index1, Index2:integer):integer of object;
{!!}

{!!
<FS>TIESwapFunction

<FM>Declaration<FC>
}
  TIESwapFunction=procedure(Index1,Index2:integer) of object;
{!!}

{!!
<FS>TIEDialogCenter

<FM>Declaration<FC>
}
  TIEDialogCenter = procedure(Wnd: HWnd);
{!!}

  TTIFFHeader = packed record
    Id: word;
    Ver: word;
    PosIFD: dword;  // 3.0.4
  end;

  TTIFFTAG = packed record
    IdTag: word;      // tag identified
    DataType: word;   // data type
    DataNum: integer; // data count
    DataPos: dword; // data position  // 3.0.4
  end;
  PTIFFTAG = ^TTIFFTAG;

  TIFD = array[0..MaxInt div 16] of TTIFFTag;
  PIFD = ^TIFD;

  TTIFFEnv = record
    Intel: boolean; // true:Intel - false:Motorola
    Stream: TStream;
    IFD: PIFD;
    NumTags: word;
    StreamBase: int64;
  end;

  // handles hash code for numeric values
  THash1Item = class
    key: integer;
    nextitem: THash1Item; // nil=end of list
    value: integer;
  end;

  THash1 = class
  private
    fMainKeys: TList; // main key array
    fMainKeysUse: TList; // main key array - state [0=free; 1=busy; 2=more keys]
    fMainKeysValue: TList; // array of values
    fHbits: integer; // has table size in bits
    fHdim: integer; // items count of fMainKeys and fMainKeyUse
    fIteratePtr1: integer;
    fIteratePtr2: THash1Item;
    function HashFunc(kk: integer): integer;
  public
    nkeys: integer; // inserted key count
    constructor Create(Hbits: integer);
    destructor Destroy; override;
    function Insert(kk: integer): boolean;
    function KeyPresent(kk: integer): boolean;
    function Insert2(kk: integer; var ptr1: integer; var ptr2: Thash1Item): boolean;
    procedure SetValue(ptr1: integer; ptr2: Thash1Item; Value: integer);
    function GetValue(ptr1: integer; ptr2: Thash1Item): integer;
    function IterateBegin: boolean;
    function IterateNext: boolean;
    function IterateGetValue: integer;
  end;

{!!
<FS>TIEOpSys

<FM>Declaration<FC>
}
  TIEOpSys = (ieosWin95, ieosWin98, ieosWinME, ieosWinNT4, ieosWin2000, ieosWinXP, ieosWin2003, ieosWinVista, ieosWin7, ieosUnknown);
{!!}

{!!
<FS>TImageEnPaletteDialog

<FM>Description<FN>
TImageEnPaletteDialog is a dialog useful to show a palette and select a color from it.

See also <A TImageEnProc.CalcImagePalette>

<FM>Methods<FN>

  <A TImageEnPaletteDialog.Execute>
  <A TImageEnPaletteDialog.SetPalette>
!!}
  TImageEnPaletteDialog = class(TForm)
  private
    MouseCol: integer;
    fPalette: PRGBROW;
    fNumCol: integer;
    procedure FormPaint(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; x, y: integer);
    procedure FormClick(Sender: TObject);
  public
    ButtonCancel: TButton;
    SelCol: TColor;
    property NumCol: integer read MouseCol;
    constructor Create(AOwner: TComponent); override;
    procedure SetPalette(var Palette: array of TRGB; NumCol: integer);
    function Execute: boolean;
  end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEScrollBarParams

{!!
<FS>TIEScrollBarParams

<FM>Description<FN>
Allows an application to customize the scroll bars behavior like tracking (display refresh on mouse dragging), up/down buttons pixel scroll, pagedown/up pixel scroll.

<FM>Properties<FN>

  <A TIEScrollBarParams.LineStep>
  <A TIEScrollBarParams.PageStep>
  <A TIEScrollBarParams.Tracking>
!!}
  TIEScrollBarParams = class
  private
    fLineStep: integer; // click on up/down/left/right (-1=default size)
    fPageStep: integer; // page step (-1=default size)
    fTracking: boolean; // scroll-bar updates display in real-time (true=default)
  public
    constructor Create;
    destructor Destroy; override;

{!!
<FS>TIEScrollBarParams.LineStep

<FM>Declaration<FC>
property LineStep: integer;

<FM>Description<FN>
LineStep is the number of pixels to scroll when the user clicks on UP or DOWN arrows.
Setting this property to -1, the component scrolls by one thumbnail at a time. Default value is -1.
!!}
    property LineStep: integer read fLineStep write fLineStep;

{!!
<FS>TIEScrollBarParams.PageStep

<FM>Declaration<FC>
property PageStep: integer;

<FM>Description<FN>
PageStep is the number of pixels to scroll when the user clicks near the cursor (PAGEUP or PAGEDOWN).
Setting this property to -1, the component scrolls by one page (client height). Default value is -1.
!!}
    property PageStep: integer read fPageStep write fPageStep;

{!!
<FS>TIEScrollBarParams.Tracking

<FM>Declaration<FC>
property Tracking: boolean

<FM>Description<FN>
Set Tracking to False to disable display refreshing during mouse dragging. Default value is True.
!!}
    property Tracking: boolean read fTracking write fTracking;

  end;

// TIEScrollBarParams
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEMouseWheelParams

{!!
<FS>TIEMouseWheelParamsAction

<FM>Declaration<FC>
}
  TIEMouseWheelParamsAction = (iemwNone, iemwVScroll, iemwZoom);
{!!}

{!!
<FS>TIEMouseWheelParamsVariation

<FM>Declaration<FC>
}
  TIEMouseWheelParamsVariation = (iemwAbsolute, iemwPercentage);
{!!}

{!!
<FS>TIEMouseWheelParamsZoomPosition

<FM>Declaration<FC>
}
  TIEMouseWheelParamsZoomPosition = (iemwCenter, iemwMouse);
{!!}

{!!
<FS>TIEMouseWheelParams

<FM>Description<FN>
The TIEMouseWheelParams allows applications to customize the mouse wheel’s behavior.

<FM>Properties<FN>

  <A TIEMouseWheelParams.InvertDirection>
  <A TIEMouseWheelParams.Action>
  <A TIEMouseWheelParams.Variation>
  <A TIEMouseWheelParams.Value>
  <A TIEMouseWheelParams.ZoomPosition>
!!}
  TIEMouseWheelParams = class
  public

{!!
<FS>TIEMouseWheelParams.InvertDirection

<FM>Declaration<FC>
InvertDirection: boolean;

<FM>Description<FN>
If True inverts wheel direction (default False).
!!}
    InvertDirection: boolean; // invert wheel direction

{!!
<FS>TIEMouseWheelParams.Action

<FM>Declaration<FC>
Action: <A TIEMouseWheelParamsAction>;

<FM>Description<FN>
Action specifies the task to perform on mouse wheel events.
Specify iemwNone for no operation, iemwVScroll for vertical image scroll or iemwZoom for zoom-in/out (default iemwZoom).
!!}
    Action: TIEMouseWheelParamsAction; // action

{!!
<FS>TIEMouseWheelParams.Variation

<FM>Declaration<FC>
Variation: <A TIEMouseWheelParamsVariation>;

<FM>Description<FN>
Variation specifies how much scrolling or zooming occurs in response to mouse wheel rotation.
If Variation is iemwAbsolute, Value contains the absolute value to add or subtract from the current value.
If Variation is iemwPercentage, Value contains the percentage of variation from the current value (default  is iemwPercentage).
!!}
    Variation: TIEMouseWheelParamsVariation; // variation mode

{!!
<FS>TIEMouseWheelParams.Value

<FM>Declaration<FC>
Value: integer;

<FM>Description<FN>
Value or percentage of variation (default 8).
!!}
    Value: integer; // value o percentage of variation

{!!
<FS>TIEMouseWheelParams.ZoomPosition

<FM>Declaration<FC>
ZoomPosition: <A TIEMouseWheelParamsZoomPosition>;

<FM>Description<FN>
If Action is iemwZoom, ZoomPosition specifies where the zoom acts. The default is the center of the control, otherwise (iemwMouse) zooms from the mouse’s position.
!!}
    ZoomPosition: TIEMouseWheelParamsZoomPosition;

    constructor Create;
    destructor Destroy; override;
  end;

// TIEMouseWheelParams
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////



  TIEByteArray = class
  private
    fSize: integer;       // size of datas
    fRSize: integer;      // size of allocated buffer
    fBlockSize: integer;  // allocation block size
    procedure SetSize(v: integer);
  public
    Data: pbytearray;
    constructor Create(InitBlockSize:integer=8192);
    destructor Destroy; override;
    procedure AddByte(v: byte);
    property Size: integer read fSize write SetSize;
    property BlockSize: integer read fBlockSize write fBlockSize;
    procedure Clear;
    function AppendFromStream(Stream: TStream; Count: integer): integer;
  end;

  TNulStream = class(TStream)
  private
    fposition: integer;
    fsize: integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
  end;

  TIEListChanges = set of (ielItems, ielRange, ielCurrentValue);

{!!
<FS>TIEList

<FM>Description<FN>
This is the abstract class for <A TIEDoubleList> and <A TIEIntegerList>.

<FM>Implemented Methods<FN>

  <A TIEList.Clear>
  <A TIEList.Delete>

<FM>Implemented Properties<FN>

  <A TIEList.Changed>
  <A TIEList.Count>
!!}
  // abstract class for IE lists
  TIEList = class
  private
    fCapacity: integer;
    fCount: integer;
  protected
    fItemSize: integer; // sizeof(...)
    fData: pointer;
    fChanged: TIEListChanges;
    procedure SetCount(v: integer); virtual;
    function AddItem(v: pointer): integer;
    procedure InsertItem(idx: integer; v: pointer);
    function IndexOfItem(v: pointer): integer;
    function BaseGetItem(idx: integer): pointer;
    procedure BaseSetItem(idx: integer; v: pointer);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Delete(idx: integer); virtual;
    property Count: integer read fCount write SetCount;
    procedure Clear; virtual;
    procedure Assign(Source: TIEList); virtual;

{!!
<FS>TIEList.Changed

<FM>Declaration<FC>
property Changed:TIEListChanges;

<FM>Description<FN>
Changed is True whenever the items array, Range or CurrentValue changes.
!!}
    property Changed: TIEListChanges read fChanged write fChanged;

  end;

{!!
<FS>TIEDoubleList

<FM>Description<FN>
TIEDoubleList is a list of double values. You can handle this object as a standard TList object.
An ImageEn list contains an array of values, a current value (not an index of the array), and an allowed range of values.

<FM>Methods and Properties<FN>

  <A TIEDoubleList.Add>
  <A TIEDoubleList.Clear>
  <A TIEDoubleList.CurrentValue>
  <A TIEDoubleList.IndexOf>
  <A TIEDoubleList.Insert>
  <A TIEDoubleList.Items>
  <A TIEDoubleList.RangeMax>
  <A TIEDoubleList.RangeMin>
  <A TIEDoubleList.RangeStep>
  <A TIEList.Changed> (inherited from TIEList)

!!}
  TIEDoubleList = class(TIEList)
  private
    fRangeMin: double;
    fRangeMax: double;
    fRangeStep: double;
    fCurrentValue: double;
    function GetItem(idx: integer): double;
    procedure SetItem(idx: integer; v: double);
    procedure SetRangeMax(v: double);
    procedure SetRangeMin(v: double);
    procedure SetRangeStep(v: double);
    procedure SetCurrentValue(v: double);
  public
    function Add(v: double): integer;
    procedure Insert(idx: integer; v: double);
    procedure Clear; override;
    function IndexOf(v: double): integer;
    property RangeMin: double read fRangeMin write SetRangeMin;
    property RangeMax: double read fRangeMax write SetRangeMax;
    property RangeStep: double read fRangeStep write SetRangeStep;
    property Items[idx: integer]: double read GetItem write SetItem; default;
    procedure Assign(Source: TIEList); override;
    property CurrentValue: double read fCurrentValue write SetCurrentValue;
  end;

{!!
<FS>TIEIntegerList

<FM>Description<FN>
TIEIntegerList is a list of integer values. You can handle this object as a standard TList object.
An ImageEn list contains an array of values, a current value (not an index of the array), and an allowed range of values.


<FM>Methods and Properties<FN>

  <A TIEIntegerList.Add>
  <A TIEIntegerList.Clear>
  <A TIEIntegerList.CurrentValue>
  <A TIEIntegerList.IndexOf>
  <A TIEIntegerList.Insert>
  <A TIEIntegerList.Items>
  <A TIEIntegerList.RangeMax>
  <A TIEIntegerList.RangeMin>
  <A TIEIntegerList.RangeStep>
  <A TIEList.Changed> (inherited from TIEList)

!!}
  TIEIntegerList = class(TIEList)
  private
    fRangeMin: integer;
    fRangeMax: integer;
    fRangeStep: integer;
    fCurrentValue: integer;
    function GetItem(idx: integer): integer;
    procedure SetItem(idx: integer; v: integer);
    procedure SetRangeMax(v: integer);
    procedure SetRangeMin(v: integer);
    procedure SetRangeStep(v: integer);
    procedure SetCurrentValue(v: integer);
  public
    function Add(v: integer): integer;
    procedure Insert(idx: integer; v: integer);
    procedure Clear; override;
    function IndexOf(v: integer): integer;
    property RangeMin: integer read fRangeMin write SetRangeMin;
    property RangeMax: integer read fRangeMax write SetRangeMax;
    property RangeStep: integer read fRangeStep write SetRangeStep;
    property Items[idx: integer]: integer read GetItem write SetItem; default;
    procedure Assign(Source: TIEList); override;
    property CurrentValue: integer read fCurrentValue write SetCurrentValue;
  end;

  TIERecordList = class(TIEList)
  private
    function GetItem(idx: integer): pointer;
    procedure SetItem(idx: integer; v: pointer);
  public
    function Add(v: pointer): integer;
    procedure Insert(idx: integer; v: pointer);
    function IndexOf(v: pointer): integer;
    property Items[idx: integer]: pointer read GetItem write SetItem; default;
    constructor CreateList(RecordSize: integer);
  end;

{!!
<FS>TIEMarkerList

<FM>Description<FN>
TIEMarkerList is the object that contains the list of markers loaded from a jpeg.


<FM>Methods and properties<FN>

  <A TIEMarkerList.AddMarker>
  <A TIEMarkerList.Assign>
  <A TIEMarkerList.Clear>
  <A TIEMarkerList.Count>
  <A TIEMarkerList.DeleteMarker>
  <A TIEMarkerList.IndexOf>
  <A TIEMarkerList.InsertMarker>
  <A TIEMarkerList.LoadFromStream>
  <A TIEMarkerList.MarkerData>
  <A TIEMarkerList.MarkerLength>
  <A TIEMarkerList.MarkerStream>
  <A TIEMarkerList.MarkerType>
  <A TIEMarkerList.SaveToStream>
  <A TIEMarkerList.SetMarker>
!!}
  TIEMarkerList = class
  private
    fData: TList; // list of TMemoryStream
    fType: TList; // list of byte
    function GetCount: integer;
    function GetMarkerData(idx: integer): PAnsiChar;
    function GetMarkerStream(idx: integer): TStream;
    function GetMarkerType(idx: integer): byte;
    function GetMarkerLength(idx: integer): word;
    function SortCompare(Index1,Index2:integer):integer;
    procedure SortSwap(Index1,Index2:integer);
  public
    constructor Create;
    destructor Destroy; override;
    function AddMarker(marker: byte; data: PAnsiChar; datalen: word): integer;
    procedure SetMarker(idx: integer; marker: byte; data: PAnsiChar; datalen: word);
    procedure InsertMarker(idx: integer; data: PAnsiChar; marker: byte; datalen: word);
    procedure Clear;
    property MarkerData[idx: integer]: PAnsiChar read GetMarkerData;
    property MarkerStream[idx: integer]: TStream read GetMarkerStream;
    property MarkerLength[idx: integer]: word read GetMarkerLength;
    property MarkerType[idx: integer]: byte read GetMarkerType;
    function IndexOf(marker: byte): integer;
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    procedure DeleteMarker(idx: integer);
    property Count: integer read GetCount;
    procedure Assign(Source: TIEMarkerList);
    procedure Sort;
  end;

  TIPTCInfo = packed record
    fRecord: integer;
    fDataSet: integer;
    fLength: integer;
  end;
  PIPTCInfo = ^TIPTCInfo;

{!!
<FS>TIEIPTCInfoList

<FM>Description<FN>
TIEIPTCInfoList contains a list of IPTC information contained in a file.
IPTC records can contains text, objects and images. Applications can read/write information from TIEIPTCInfoList using string objects or a memory buffer.
Each IPTC_Info item has a record number and a dataset number.  These values specify the type of data contained in the item, according to IPTC - NAA Information Interchange Model Version 4 (look at <L http://www.iptc.org>www.iptc.org</L>).
ImageEn can read/write IPTC textual information of PhotoShop (File info menu).
For JPEG files ImageEn read/write IPTC fields from APP13 marker.
Click <L IPTC items compatible with Adobe PhotoShop>here</L> for a list of IPTC Photoshop items.

An instance of TIEIPTCInfoList is <A TIOParamsVals.IPTC_Info>

<FM>Methods and Properties<FN>

  <A TIEIPTCInfoList.AddBufferItem>
  <A TIEIPTCInfoList.AddStringItem>
  <A TIEIPTCInfoList.Assign>
  <A TIEIPTCInfoList.Clear>
  <A TIEIPTCInfoList.Count>
  <A TIEIPTCInfoList.DataSet>
  <A TIEIPTCInfoList.DeleteItem>
  <A TIEIPTCInfoList.GetItemData>
  <A TIEIPTCInfoList.GetItemLength>
  <A TIEIPTCInfoList.IndexOf>
  <A TIEIPTCInfoList.InsertStringItem>
  <A TIEIPTCInfoList.LoadFromStandardBuffer>
  <A TIEIPTCInfoList.LoadFromStream>
  <A TIEIPTCInfoList.RecordNumber>
  <A TIEIPTCInfoList.SaveToStandardBuffer>
  <A TIEIPTCInfoList.SaveToStream>
  <A TIEIPTCInfoList.StringItem>
!!}
  TIEIPTCInfoList = class
  private
    fBuffer: TList;
    fInfo: TList;
    fUserChanged: boolean;
    function GetStrings(idx: integer): string;
    procedure SetStrings(idx: integer; Value: string);
    function GetRecordNumber(idx: integer): integer;
    procedure SetRecordNumber(idx: integer; Value: integer);
    function GetDataSet(idx: integer): integer;
    procedure SetDataSet(idx: integer; Value: integer);
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    property StringItem[idx: integer]: string read GetStrings write SetStrings;
    property RecordNumber[idx: integer]: integer read GetRecordNumber write SetRecordNumber;
    property DataSet[idx: integer]: integer read GetDataSet write SetDataSet;
    function AddStringItem(ARecordNumber: integer; ADataSet: integer; Value: AnsiString): integer;
    function AddBufferItem(ARecordNumber: integer; ADataSet: integer; Buffer: pointer; BufferLength: integer): integer;
    procedure InsertStringItem(idx: integer; ARecordNumber: integer; ADataSet: integer; Value: AnsiString);
    procedure Clear;
    function IndexOf(ARecordNumber: integer; ADataSet: integer): integer;
    procedure DeleteItem(idx: integer);
    property Count: integer read GetCount;
    procedure Assign(Source: TIEIPTCInfoList);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    function LoadFromStandardBuffer(Buffer: pointer; BufferLength: integer):boolean;
    procedure SaveToStandardBuffer(var Buffer: pointer; var BufferLength: integer; WriteHeader: boolean);
    property UserChanged: boolean read fUserChanged write fUserChanged;
    function GetItemData(idx:integer):pointer;
    function GetItemLength(idx:integer):integer;
  end;

  // annotation types
const
  IEAnnotImageEmbedded = 1;
  IEAnnotImageReference = 2;
  IEAnnotStraightLine = 3;
  IEAnnotFreehandLine = 4;
  IEAnnotHollowRectangle = 5;
  IEAnnotFilledRectangle = 6;
  IEAnnotTypedText = 7;
  IEAnnotTextFromFile = 8;
  IEAnnotTextStamp = 9;
  IEAnnotAttachANote = 10;
  IEAnnotForm = 12;
  IEAnnotOCRRegion = 13;

  // TIEBitmap maximum channels
const
  IEMAXCHANNELS = 4;

type





{!!
<FS>TIEPixelFormat

<FM>Declaration<FC>
}
  TIEPixelFormat = (ienull,
                    ie1g,     // gray scale (black/white)
                    ie8p,     // color (palette)
                    ie8g,     // gray scale (256 levels)
                    ie16g,    // gray scale (65536 levels)
                    ie24RGB,  // RGB 24 bit (8 bit per channel)
                    ie32f,    // float point values, 32 bit - Single in Pascal - gray scale
                    ieCMYK,   // CMYK (reversed 8 bit values)
                    ie48RGB,  // RGB 48 bit (16 bit per channel)
                    ieCIELab, // CIELab (8 bit per channel)
                    ie32RGB   // RGB 32 bit (8 bit per channel), last 8 bit are unused with some exceptions
  );
{!!}

{!!
<FS>TIEPixelFormatSet

<FM>Declaration<FC>
}
  TIEPixelFormatSet = set of TIEPixelFormat;
{!!}

{!!
<FS>TIEDataAccess

<FM>Declaration<FC>
}
  TIEDataAccess = set of (iedRead, iedWrite);
{!!}

{!!
<FS>TIEBaseBitmap

<FM>Description<FN>
This is the base abstract class for <A TIEBitmap> object. Applications cannot create TIEBaseBitmap objects, instead use TIEBitmap.

<FM>Implemented Properties<FN>

  <A TIEBaseBitmap.Access>
  <A TIEBaseBitmap.Palette>
  <A TIEBaseBitmap.PaletteLength>

!!}
  TIEBaseBitmap = class
  protected
    fAccess: TIEDataAccess;
    function GetScanLine(Row: integer): pointer; virtual; abstract;
    function GetBitCount: integer; virtual; abstract;
    function GetHeight: integer; virtual; abstract;
    function GetWidth: integer; virtual; abstract;
    function GetPixelFormat: TIEPixelFormat; virtual; abstract;
    function GetRowLen: integer; virtual; abstract;
    function GetPaletteBuffer:pointer; virtual; abstract;
    function GetPalette(index: integer): TRGB; virtual; abstract;
    procedure SetPalette(index: integer; Value: TRGB); virtual; abstract;
    function GetPaletteLen:integer; virtual; abstract;
  public
    property Scanline[row: integer]: pointer read GetScanline;
    property BitCount: integer read GetBitCount;
    property Width: integer read GetWidth;
    property Height: integer read GetHeight;
    property PixelFormat: TIEPixelFormat read GetPixelFormat;
    function Allocate(ImageWidth, ImageHeight: integer; ImagePixelFormat: TIEPixelFormat):boolean; virtual; abstract;
    procedure Assign(Source: TObject); virtual; abstract;
    property RowLen: integer read GetRowLen;

{!!
<FS>TIEBaseBitmap.Access

<FM>Declaration<FC>
property Access:<A TIEDataAccess>;

<FM>Description<FN>
Access specifies if the bitmap is readable or/and writable. This works only when Location is ieFile to speed up reading and writing operations.

The default value is [iedRead,iedWrite] that means read and write.

<FM>Examples<FC>

// set writeonly when load input.tif (in reality this is automatic!)
ImageEnView.IEBitmap.Access:=[iedWrite];
ImageEnView.IO.LoadFromFile('input.tif’);
ImageEnView.IEBitmap.Access:=[iedWrite,iedRead];	// restore

// set readonly when save output.tif (in reality this is automatic!)
ImageEnView.IEBitmap.Access:=[iedRead];
ImageEnView.IO.SaveToFile('output.tif’);
ImageEnView.IEBitmap.Access:=[iedWrite,iedRead];	// restore
!!}
    property Access: TIEDataAccess read fAccess write fAccess;

{!!
<FS>TIEBaseBitmap.Palette

<FM>Declaration<FC>
property Palette[index:integer]:<A TRGB>;

<FM>Description<FN>
Palette returns the color of palette entry index.
!!}
    property Palette[index: integer]: TRGB read GetPalette write SetPalette;

    property PaletteBuffer:pointer read GetPaletteBuffer;

{!!
<FS>TIEBaseBitmap.PaletteLength

<FM>Declaration<FC>
property PaletteLength:integer;

<FM>Description<FN>
PaletteLength returns the palette entries count.
!!}
    property PaletteLength: integer read GetPaletteLen;

    procedure CopyPaletteTo(Dest:TIEBaseBitmap); virtual; abstract;

  end;

  (*
  // the memory mapped object
  TIEFileBuffer=class
     private
        fHTempFile:THandle;
        fHFileMap:THandle;
        fFileName:AnsiString;
        fMapped:TList;
     public
        constructor Create;
        destructor Destroy; override;
        function AllocateFile(FileName:AnsiString; SizeLo,SizeHi:dword):boolean;
        procedure ReAllocateFile(NewSizeLo,NewSizeHi:dword);
        function Map(OffsetHi, OffsetLo, Size:integer):pointer;
        procedure UnMap(ptr:pointer);
        procedure UnMapAll;
        function IsAllocated:boolean;
        procedure DeAllocate;
        procedure CopyTo(Dest:TIEFileBuffer; Offsethi,OffSetLo,Size:integer);
  end;
  //*)

  //(*

  TIETemporaryFileStream = class(THandleStream)
  private
    FHandle:THandle;
  public
    constructor Create(const FileName: string);
    destructor Destroy; override;
  end;

  TIEWideFileStream = class(THandleStream)
  public
    constructor Create(const FileName: WideString; Mode: Word);
    destructor Destroy; override;
  end;

  TIEFileBufferItem = record
    Pos: int64; // buffer position inside the file
    Size: int64; // buffer size
    ptr: pointer; // allocated buffer
    access: TIEDataAccess;
  end;
  PIEFileBufferItem = ^TIEFileBufferItem;

  // emulates a memory mapped file
  TIEFileBuffer = class
  private
    fSimFile:TStream; // 3.0.3, can be TIETemporaryFileStream or TMemoryStream
    fFileName: string;
    fMapped: TList; // list of TIEFileBufferItem structures
    function IndexOf(ptr: pointer): integer;
  public
    constructor Create;
    destructor Destroy; override;
    function AllocateFile(InSize: int64; const Descriptor:string; UseDisk:boolean): boolean;
    procedure ReAllocateFile(NewSize: int64);
    function Map(InPos, InSize: int64; DataAccess: TIEDataAccess): pointer;
    procedure UnMap(ptr: pointer);
    procedure UnMapAll;
    function IsAllocated: boolean;
    procedure DeAllocate;
    procedure CopyTo(Dest: TIEFileBuffer; InPos, InSize: int64); overload;
    procedure CopyTo(Dest: TStream; InPos, InSize: int64); overload;
  end;
  //*)



/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEHashStream

{$ifdef IEINCLUDEHASHSTREAM}

{!!
<FS>TIEHashAlgorithm

<FM>Declaration<FC>
TIEHashAlgorithm = (
  iehaMD2, // MD2 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  iehaMD4, // MD4 hashing algorithm.
  iehaMD5, // MD5 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  iehaSHA  // SHA hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
);
!!}
{$ifdef IEHASCONSTENUM}
TIEHashAlgorithm = (
  iehaMD2 = $00008001, // MD2 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  iehaMD4 = $00008002, // MD4 hashing algorithm.
  iehaMD5 = $00008003, // MD5 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  iehaSHA = $00008004  // SHA hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
);
{$else}
type TIEHashAlgorithm = integer;
const iehaMD2 = $00008001; // MD2 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
const iehaMD4 = $00008002; // MD4 hashing algorithm.
const iehaMD5 = $00008003; // MD5 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
const iehaSHA = $00008004; // SHA hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
{$endif}

type

{!!
<FS>TIEHashStream

<FM>Description<FN>

Builds an hash string from stream.
Hash algorithm can be MD2, MD4, MD5 and SHA.

<FM>Examples<FC>

// saves the file with an unique name (create hash from the jpeg content and use it as file name)
var
  hashStream:TIEHashStream;
begin
  hashStream := TIEHashStream.Create(iehaMD5);
  try
    ImageEnView1.IO.SaveToStreamJpeg(hashStream);
    hashStream.SaveToFile(hashStream.GetHash()+'.jpg');
  finally
    hashStream.Free;
  end;
end;



<FM>Methods and properties<FN>

  <A TIEHashStream.Create>
  <A TIEHashStream.GetHash>
  <A TIEHashStream.LoadFromFile>
  <A TIEHashStream.LoadFromStream>
  <A TIEHashStream.Write>
  <A TIEHashStream.Read>
  <A TIEHashStream.Seek>
  <A TIEHashStream.SaveToFile>
  <A TIEHashStream.SaveToStream>
!!}
  TIEHashStream = class(TStream)
    private
      m_MemStream: TMemoryStream;
      m_CryptProvider: pointer;
      m_CryptHash: pointer;
    public
      constructor Create(Algorithm:TIEHashAlgorithm=iehaMD5; Buffered:boolean=true);
      destructor Destroy; override;
      function GetHash:AnsiString;
      function Write(const Buffer; Count:longint):longint; override;
      function Read(var Buffer; Count:longint):longint; override;
      {$ifdef IEOLDSEEKDEF}
      function Seek(Offset:longint; Origin:word):longint; override;
      {$else}
      function Seek(const Offset:int64; Origin:TSeekOrigin):int64; override;
      {$endif}
      procedure SaveToFile(const filename:AnsiString);
      procedure SaveToStream(Stream:TStream);
      procedure LoadFromFile(const filename:AnsiString);
      procedure LoadFromStream(Stream:TStream);
  end;


{$endif}  // IEINCLUDEHASHSTREAM

// TIEHashStream
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
<FS>TIELocation

<FM>Declaration<FC>
TIELocation = (ieMemory, ieFile, ieTBitmap);

<FM>Description<FN>

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>ieMemory<FN></C> <C>Uses standard memory. Canvas not available. Used for fast and little images.</C> </R>
<R> <C><FC>ieFile<FN></C> <C>Uses memory mapped files. Canvas not available. Used for big images.</C> </R>
<R> <C><FC>ieTBitmap<FN></C> <C>Uses TBitmap VCL object. Canvas available. Used for drawing and compatibility. Location can be assigned before or after Allocate. Assigning Location on a existing image it converts the image to new location.</C> </R>
</TABLE>

!!}
  TIELocation = (
    ieMemory, // use GetMem, no Canvas available (FOR FAST AND LITTLE IMAGES)
    ieFile,   // use Memory mapped file, no Canvas available (FOR BIG IMAGES)
    ieTBitmap // use TBitmap VCL object, Canvas available (FOR DRAWING)
    );

{!!
<FS>TIERenderOperation

<FM>Declaration<FC>
}
  TIERenderOperation = (
    ielNormal,
    ielAdd, // Additive
    ielSub, // Difference
    ielDiv,
    ielMul,
    ielOR,
    ielAND,
    ielXOR,
    ielMAX, // Lighten
    ielMIN, // Darken
    ielAverage,
    ielScreen,
    ielNegation,
    ielExclusion,
    ielOverlay,
    ielHardLight,
    ielSoftLight,
    ielXFader,
    ielColorEdge,
    ielColorBurn,
    ielInverseColorDodge,
    ielInverseColorBurn,
    ielSoftDodge,
    ielSoftBurn,
    ielReflect,
    ielGlow,
    ielFreeze,
    ielEat,
    ielSubtractive,
    ielInterpolation,
    ielStamp,
    ielRed,
    ielGreen,
    ielBlue,
    ielHue,
    ielSaturation,
    ielColor,
    ielLuminosity,
    ielStereoBW,
    ielStereoColor,
    ielStereoColorDubois,
    ielStereoEven,
    ielStereoOdd
    );
{!!}

{!!
<FS>TIEDitherMethod

<FM>Declaration<FC>
}
  TIEDitherMethod = (ieOrdered, ieThreshold);
{!!}

{!!
<FS>TIEHAlign

<FM>Declaration<FC>
}
  TIEHAlign = (iehLeft, iehCenter, iehRight);
{!!}

{!!
<FS>TIEVAlign

<FM>Declaration<FC>
}
  TIEVAlign = (ievTop, ievCenter, ievBottom);
{!!}

{!!
<FS>TIEMemoryAllocator

<FM>Declaration<FC>
}
  TIEMemoryAllocator = (iemaVCL, iemaSystem, iemaAuto);
{!!}

{!!
<FS>TIEBitmapOrigin

<FM>Declaration<FC>
}
  TIEBitmapOrigin = (ieboBOTTOMLEFT, ieboTOPLEFT);
{!!}

type TIEMask = class;
     TIEDibbitmap = class;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEBitmap

{!!
<FS>TIEBitmap

<FM>Description<FN>
TIEBitmap is a replacement of VCL TBitmap class. It has many methods and properties compatible with TBitmap and enhances it supporting multi-threading and large images.
TIEBitmap can store images in memory mapped files (for big images), in memory (fast access) or can encapsulate TBitmap objects (for canvas drawing and compatibility).

<FM>Methods and Properties<FN>

  <A TIEBaseBitmap.Access> (inherited from <A TIEBaseBitmap>)
  <A TIEBaseBitmap.Palette> (inherited from <A TIEBaseBitmap>)
  <A TIEBaseBitmap.PaletteLength> (inherited from <A TIEBaseBitmap>)

  <A TIEBitmap.Allocate>
  <A TIEBitmap.Alpha>
  <A TIEBitmap.AlphaChannel>
  <A TIEBitmap.Assign>
  <A TIEBitmap.AssignImage>
  <A TIEBitmap.AutoCalcBWValues>
  <A TIEBitmap.BitAlignment>
  <A TIEBitmap.BitCount>
  <A TIEBitmap.BlackValue>
  <A TIEBitmap.CalcRAWSize>
  <A TIEBitmap.Canvas>
  <A TIEBitmap.CanvasCurrentAlpha>
  <A TIEBitmap.ChannelCount>
  <A TIEBitmap.ChannelOffset>
  <A TIEBitmap.Contrast>
  <A TIEBitmap.CopyAndConvertFormat>
  <A TIEBitmap.CopyFromMemory>
  <A TIEBitmap.CopyFromDIB>
  <A TIEBitmap.CopyFromTBitmap>
  <A TIEBitmap.CopyFromTDibBitmap>
  <A TIEBitmap.CopyFromTIEMask>
  <A TIEBitmap.CopyPaletteTo>
  <A TIEBitmap.CopyRectTo>
  <A TIEBitmap.CopyToTBitmap>
  <A TIEBitmap.CopyToTDibBitmap>
  <A TIEBitmap.CopyToTIEMask>
  <A TIEBitmap.CopyWithMask1>
  <A TIEBitmap.CopyWithMask2>
  <A TIEBitmap.Create>
  <A TIEBitmap.CreateDIB>
  <A TIEBitmap.DefaultDitherMethod>
  <A TIEBitmap.Destroy>
  <A TIEBitmap.DrawToCanvas>
  <A TIEBitmap.EncapsulatedFromMemory>
  <A TIEBitmap.EncapsulatedFromTBitmap>
  <A TIEBitmap.EncapsulateMemory>
  <A TIEBitmap.EncapsulateTBitmap>
  <A TIEBitmap.Fill>
  <A TIEBitmap.FillRect>
  <A TIEBitmap.FreeImage>
  <A TIEBitmap.FreeRow>
  <A TIEBitmap.Full>
  <A TIEBitmap.GetHash>
  <A TIEBitmap.GetRow>
  <A TIEBitmap.HasAlphaChannel>
  <A TIEBitmap.Height>
  <A TIEBitmap.IsAllBlack>
  <A TIEBitmap.IsEmpty>
  <A TIEBitmap.IsGrayScale>
  <A TIEBitmap.LoadRAWFromBufferOrStream>
  <A TIEBitmap.Location>
  <A TIEBitmap.MemoryAllocator>
  <A TIEBitmap.MergeAlphaRectTo>
  <A TIEBitmap.MergeFromTDibBitmap>
  <A TIEBitmap.MergeWithAlpha>
  <A TIEBitmap.MinFileSize>
  <A TIEBitmap.MoveRegion>
  <A TIEBitmap.Origin>
  <A TIEBitmap.PaletteUsed>
  <A TIEBitmap.PixelFormat>
  <A TIEBitmap.Pixels_ie16g>
  <A TIEBitmap.Pixels_ie1g>
  <A TIEBitmap.Pixels_ie24RGB>
  <A TIEBitmap.Pixels_ie32f>
  <A TIEBitmap.Pixels_ie32RGB>
  <A TIEBitmap.Pixels_ie48RGB>
  <A TIEBitmap.Pixels_ie8>
  <A TIEBitmap.Pixels_ieCIELab>
  <A TIEBitmap.Pixels_ieCMYK>
  <A TIEBitmap.Pixels>
  <A TIEBitmap.PPixels_ie24RGB>
  <A TIEBitmap.PPixels_ie32RGB>
  <A TIEBitmap.PPixels_ie48RGB>
  <A TIEBitmap.Read>
  <A TIEBitmap.RemoveAlphaChannel>
  <A TIEBitmap.RenderToCanvas>
  <A TIEBitmap.RenderToCanvasWithAlpha>
  <A TIEBitmap.RenderToTBitmap>
  <A TIEBitmap.RenderToTBitmapEx>
  <A TIEBitmap.RenderToTIEBitmap>
  <A TIEBitmap.RenderToTIEBitmapEx>
  <A TIEBitmap.Resize>
  <A TIEBitmap.Rowlen>
  <A TIEBitmap.SaveRAWToBufferOrStream>
  <A TIEBitmap.ScanLine>
  <A TIEBitmap.StretchRectTo>
  <A TIEBitmap.SwitchTo>
  <A TIEBitmap.SyncFull>
  <A TIEBitmap.SynchronizeRGBA>
  <A TIEBitmap.TBitmapScanlines>
  <A TIEBitmap.UndoInfo>
  <A TIEBitmap.UpdateFromTBitmap>
  <A TIEBitmap.VclBitmap>
  <A TIEBitmap.WhiteValue>
  <A TIEBitmap.Width>
  <A TIEBitmap.Write>
!!}
  TIEBitmap = class(TIEBaseBitmap)
  private
    // image data
    fmemmap: TIEFileBuffer;
    fWorkingMap: pointer;               // last mapped memory buffer
    fRGBPalette: PIERGBPalette;
    fRGBPaletteLen: integer;
    fAlphaChannel: TIEBitmap;
    fMemory: pointer;                   // used only when fLocation=ieMemory
    fRealMemory: pointer;               // non aligned fMemory pointer
    fBitmap: TBitmap;                   // used only when fLocation=ieTBitmap
    fBitmapScanlines: ppointerarray;    // used by scanline[] for TBitmap object
    fScanlinesToUnMapPtr: TList;        // list of scanlines to unmap, valid only for ieFile and using GetRow (and FreeRow)
    fScanlinesToUnMapRow: TList;        // list of scanlines to unmap, like fScanlinesToUnMapPtr but contains the row index to unmap
    fOrigin:TIEBitmapOrigin;            // bitmap origin (topleft or bottomleft)
    // image properties
    fWidth, fHeight: integer;
    fBitCount: integer;
    fChannelCount: integer;
    fRowLen: integer;
    fPixelFormat: TIEPixelFormat;
    fIsAlpha: boolean;                  // if true this object is the alpha channel of another TIEBitmap object
    fLocation: TIELocation;
    fFull: boolean;                     // True if all bits are 1, Modified by SetPixels__, SetAlpha, Fill
    fEncapsulatedFromTBitmap: boolean;  // True if fBitmap comes from an original TBitmap. Do not free it.
    fEncapsulatedFromMemory: boolean;   // True if fMemory comes from an original memory. Do not free it.
    fMinFileSize: int64;                // if fRowLen*height < fMinFileSize Location will be ieMemory otherwise will be ieFile
    fDefaultDitherMethod: TIEDitherMethod; // default method used to convert color image to black/white
    fPaletteUsed: integer;              // number of colors used of the palette
    // rendering options
    fBlackValue: double;                // pixels with value <= fBlackValue will be black (appliable only to ie8g,ie16g,ie24RGB) - boths fBlackValue and fWhiteValue to zero disables them
    fWhiteValue: double;                // pixels with value >= fWhiteValue will be white (appliable only to ie8g,ie16g,ie24RGB)
    fChannelOffset: array[0..IEMAXCHANNELS - 1] of integer;
    fEnableChannelOffset: boolean;      // automatically set to true when one of fChannelOffset values is <>0
    fContrast: integer;
    fBitAlignment: integer;             // number of bits of alignment (32 bit is the default) - works only for ieMemory images
    fMemoryAllocator:TIEMemoryAllocator;
    // others
    fFullReallocate:boolean;            // next AllocateImage will be forced to reallocate image (even size and pixelformat doesn't change)
    fUndoInfo:pointer;                  // save undo info. Used when this bitmap is saved in Undo/Redo lists
    fCanvasCurrentAlpha:integer;        // when -1 then pf8bit and graypal are not set for this TBitmap
    // fragmented memory allocation
    fFragmentsCount:integer;            // number of fragments
    fRowsPerFragment:integer;           // image rows per fragment
    fFragments:ppointerarray;           // array of pointers to fragments
    //
    procedure SetWidth(Value: integer);
    procedure SetHeight(Value: integer);
    function AllocateImage:boolean;
    procedure SetPixelFormat(Value: TIEPixelFormat);
    procedure ConvertToPixelFormat(DestPixelFormat: TIEPixelFormat);
    function GetPixels_ie1g(x, y: integer): boolean;
    function GetPixels_ie8(x, y: integer): byte;
    function GetPixels_ie16g(x, y: integer): word;
    function GetPixels_ie24RGB(x, y: integer): TRGB;
    function GetPixels_ie32RGB(x, y: integer): TRGBA;
    function GetPixels_ie32f(x, y: integer): single;
    function GetPixels_ieCMYK(x, y:integer):TCMYK;
    function GetPixels_ieCIELab(x,y:integer):TCIELab;
    function GetPixels_ie48RGB(x,y:integer):TRGB48;
    function GetPPixels_ie24RGB(x, y: integer): PRGB;
    function GetPPixels_ie32RGB(x, y: integer): PRGBA;
    function GetPPixels_ie48RGB(x, y: integer): PRGB48;
    function GetPixels(x, y: integer): TRGB;
    procedure SetPixels(x, y:integer; value:TRGB);
    procedure SetPixels_ie1g(x, y: integer; Value: boolean);
    procedure SetPixels_ie8(x, y: integer; Value: byte);
    procedure SetPixels_ie16g(x, y: integer; Value: word);
    procedure SetPixels_ie24RGB(x, y: integer; Value: TRGB);
    procedure SetPixels_ie32RGB(x, y: integer; Value: TRGBA);
    procedure SetPixels_ie32f(x, y: integer; Value: single);
    procedure SetPixels_ieCMYK(x,y:integer; Value:TCMYK);
    procedure SetPixels_ieCIELab(x,y:integer; Value:TCIELab);
    procedure SetPixels_ie48RGB(x,y:integer; Value:TRGB48);
    function GetAlpha(x, y: integer): byte;
    procedure SetAlpha(x, y: integer; Value: byte);
    procedure SetLocation(Value: TIELocation);
    procedure UpdateTBitmapPalette;
    function GetHasAlphaChannel: boolean;
    procedure FreeBitmapScanlines;
    procedure BuildBitmapScanlines;
    function GetVclBitmap: TBitmap;
    procedure SetChannelOffset(idx: integer; value: integer);
    function GetChannelOffset(idx: integer): integer;
    procedure SetBitAlignment(value: integer);
    function GetChannelCount:integer;
    procedure SetCanvasCurrentAlpha(v:integer);
    procedure SetAlphaChannel(value:TIEBitmap);
    procedure FragmentedAlloc;
    procedure FreeFragments;
    procedure AllocateMemory(size:integer; var StartBuffer:pointer; var AlignedBuffer:pointer);
    procedure SetOrigin(value:TIEBitmapOrigin);
  protected
    function GetCanvas: TCanvas;
    function GetAlphaChannel: TIEBitmap;
    function GetBitCount: integer; override;
    function GetWidth: integer; override;
    function GetHeight: integer; override;
    function GetRowLen: integer; override;
    function GetScanLine(Row: integer): pointer; override;
    function GetPixelFormat: TIEPixelFormat; override;
    function GetPalette(index: integer): TRGB; override;
    function GetPaletteBuffer:pointer; override;
    procedure SetPalette(index: integer; Value: TRGB); override;
    function GetPaletteLen:integer; override;
    procedure FreeAllMaps;
    procedure Render_ie24RGB(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation); virtual;
    procedure Render_ie24RGB_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation); virtual;
    procedure Render_ie32RGB(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation); virtual;
    procedure Render_ie32RGB_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation); virtual;
    procedure Render_ie1g(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie1g_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie8g(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie8g_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie8p(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie8p_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie16g(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie16g_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie32f(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie32f_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ieCMYK(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ieCMYK_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ieCIELab(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ieCIELab_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean); virtual;
    procedure Render_ie48RGB(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation); virtual;
    procedure Render_ie48RGB_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation); virtual;
  public
    constructor Create; overload;
    constructor Create(ImageWidth, ImageHeight:integer; ImagePixelFormat:TIEPixelFormat=ie24RGB); overload;
    constructor Create(const FileName:string; IOParams:TObject = nil); overload;
    constructor Create(image:TIEBitmap); overload;
    constructor CreateAsAlphaChannel(ImageWidth, ImageHeight: integer; ImageLocation: TIELocation);
    destructor Destroy; override;
    property Width: integer read GetWidth write SetWidth;
    property Height: integer read GetHeight write SetHeight;
    property PixelFormat: TIEPixelFormat read GetPixelFormat write SetPixelFormat;
    procedure Assign(Source: TObject); override;  // for TIEBitmap and TBitmap
    procedure AssignImage(Source: TIEBitmap);     // assign without alpha channel
    property ScanLine[Row: integer]: pointer read GetScanLine;
    procedure UpdateFromTBitmap;
    procedure AdjustCanvasOrientation;

    function Read(const FileName:string; IOParams:TObject = nil):boolean; overload;
    function Read(Stream:TStream; IOParams:TObject = nil):boolean; overload;
    procedure Write(const FileName:string; IOParams:TObject = nil); overload;
    procedure Write(Stream:TStream; FileType:integer; IOParams:TObject = nil); overload;  // FileType is TIOFileType

    {$ifdef IEINCLUDEHASHSTREAM}
    function GetHash(Algorithm:TIEHashAlgorithm=iehaMD5):AnsiString;
    {$endif}

{!!
<FS>TIEBitmap.TBitmapScanlines

<FM>Declaration<FC>
property TBitmapScanlines:<A ppointerarray>;

<FM>Description<FN>
Returns an array of pointers for each scanline of the bitmap.
!!}
    property TBitmapScanlines:ppointerarray read fBitmapScanlines;
                             
    property Canvas: TCanvas read GetCanvas;

{!!
<FS>TIEBitmap.EncapsulatedFromTBitmap

<FM>Declaration<FC>
property EncapsulatedFromTBitmap:boolean;

<FM>Description<FN>
It is True if the image is encapsulated from a TBitmap object (using <A TIEBitmap.EncapsulateTBitmap>).
!!}
    property EncapsulatedFromTBitmap: boolean read fEncapsulatedFromTBitmap write fEncapsulatedFromTBitmap;

{!!
<FS>TIEBitmap.EncapsulatedFromMemory

<FM>Declaration<FC>
property EncapsulatedFromMemory:boolean;

<FM>Description<FN>
It is True if the image is encapsulated from a memory buffer (using <A TIEBitmap.EncapsulateMemory>).
!!}
    property EncapsulatedFromMemory: boolean read fEncapsulatedFromMemory write fEncapsulatedFromMemory;

    property Rowlen: integer read GetRowlen;
    function Allocate(ImageWidth, ImageHeight: integer; ImagePixelFormat: TIEPixelFormat=ie24RGB):boolean; override;
    procedure EncapsulateTBitmap(obj: TBitmap; DoFreeImage: boolean=false);
    procedure EncapsulateMemory(mem:pointer; bmpWidth, bmpHeight:integer; bmpPixelFormat:TIEPixelFormat; DoFreeImage:boolean; Origin:TIEBitmapOrigin = ieboBOTTOMLEFT);
    procedure FreeImage(freeAlpha:boolean = true);
    procedure SwitchTo(Target: TIEBitmap);
    property AlphaChannel: TIEBitmap read GetAlphaChannel write SetAlphaChannel;  // do not set AlphaChannel unless you free or save the object manually!!
    property Location: TIELocation read fLocation write SetLocation; // default ieFile
    procedure CopyToTBitmap(Dest: TBitmap);
    procedure CopyWithMask1(Dest: TIEBitmap; SourceMask:TIEMask; Background:TColor); overload;
    procedure CopyWithMask1(Dest: TIEBitmap; SourceMask:TIEMask); overload;
    procedure CopyWithMask2(Dest: TIEBitmap; DestMask:TIEMask);
    procedure CopyFromMemory(SrcBuffer:pointer; SrcWidth:integer; SrcHeight:integer; SrcPixelFormat:TIEPixelFormat; SrcOrigin:TIEBitmapOrigin; SrcRowLen:integer);
    procedure CopyFromTBitmap(Source: TBitmap);
    procedure CopyFromTIEMask(Source: TIEMask);
    procedure CopyToTIEMask(Dest: TIEMask);
    procedure CopyRectTo(Dest: TIEBitmap; SrcX, SrcY, DstX, DstY: integer; RectWidth, RectHeight: integer);
    procedure MergeAlphaRectTo(Dest: TIEBitmap; SrcX, SrcY, DstX, DstY: integer; RectWidth, RectHeight: integer);
    function GetRow(Row: integer): pointer;
    procedure FreeRow(Row: integer);
    procedure Resize(NewWidth, NewHeight: integer; BackgroundValue: double = 0; AlphaValue: integer = 255; HorizAlign: TIEHAlign = iehLeft; VertAlign: TIEVAlign = ievTop);
    property VclBitmap: TBitmap read GetVclBitmap write fBitmap;
    procedure MoveRegion(x1, y1, x2, y2, DstX, DstY:integer; BackgroundValue:double; FillSource:boolean = true);
    procedure CopyFromTDibBitmap(Source: TIEDibBitmap);
    procedure MergeFromTDibBitmap(Source: TIEDibBitmap; x, y: integer);
    procedure CopyToTDibBitmap(Dest: TIEDibBitmap; source_x, source_y, sourceWidth, sourceHeight: integer);
    procedure CopyFromDIB(Source:THandle); overload;
    procedure CopyFromDIB(BitmapInfo:pointer; Pixels:pointer=nil); overload;
    function CreateDIB:THandle; overload;
    function CreateDIB(x1,y1,x2,y2:integer):THandle; overload;
    property Pixels_ie1g[x, y: integer]: boolean read GetPixels_ie1g write SetPixels_ie1g;
    property Pixels_ie8[x, y: integer]: byte read GetPixels_ie8 write SetPixels_ie8;
    property Pixels_ie16g[x, y: integer]: word read GetPixels_ie16g write SetPixels_ie16g;
    property Pixels_ie24RGB[x, y: integer]: TRGB read GetPixels_ie24RGB write SetPixels_ie24RGB;
    property Pixels_ie32RGB[x, y: integer]: TRGBA read GetPixels_ie32RGB write SetPixels_ie32RGB;
    property Pixels_ie32f[x, y: integer]: single read GetPixels_ie32f write SetPixels_ie32f;
    property Pixels_ieCMYK[x,y:integer]:TCMYK read GetPixels_ieCMYK write Setpixels_ieCMYK;
    property Pixels_ieCIELab[x,y:integer]:TCIELab read GetPixels_ieCIELab write Setpixels_ieCIELab;
    property Pixels_ie48RGB[x,y:integer]:TRGB48 read GetPixels_ie48RGB write SetPixels_ie48RGB;
    property PPixels_ie24RGB[x, y: integer]: PRGB read GetPPixels_ie24RGB;
    property PPixels_ie32RGB[x, y: integer]: PRGBA read GetPPixels_ie32RGB;
    property PPixels_ie48RGB[x, y: integer]: PRGB48 read GetPPixels_ie48RGB;
    property Pixels[x, y: integer]: TRGB read GetPixels write SetPixels; // return always RGB (also with ie1g,ie8...)
    property Alpha[x, y: integer]: byte read GetAlpha write SetAlpha;
    procedure RenderToTIEBitmap(ABitmap: TIEBitmap; var ABitmapScanline: ppointerarray; var XLUT, YLUT: pinteger; UpdRect: PRect; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; EnableAlpha: boolean; SolidBackground: boolean; Transparency: integer; Filter: TResampleFilter; FreeTables: boolean; RenderOperation: TIERenderOperation = ielNormal);
    procedure RenderToTBitmap(ABitmap: TBitmap; var ABitmapScanline: ppointerarray; var XLUT, YLUT: pinteger; UpdRect: PRect; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; EnableAlpha: boolean; SolidBackground: boolean; Transparency: integer; Filter: TResampleFilter; FreeTables: boolean; RenderOperation: TIERenderOperation = ielNormal);
    procedure RenderToTBitmapEx(Dest:TBitmap; xDst, yDst, dxDst, dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: TResampleFilter; RenderOperation: TIERenderOperation = ielNormal);
    procedure RenderToTIEBitmapEx(Dest:TIEBitmap; xDst, yDst, dxDst, dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: TResampleFilter; RenderOperation: TIERenderOperation = ielNormal);
    procedure RenderToCanvasWithAlpha(Dest:TCanvas; xDst, yDst, dxDst, dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer = 255; Filter: TResampleFilter = rfNone; RenderOperation: TIERenderOperation = ielNormal);
    procedure StretchRectTo(Dest: TIEBitmap; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; Filter: TResampleFilter; Transparency: integer);
    procedure RenderToCanvas(DestCanvas: TCanvas; xDst, yDst, dxDst, dyDst: integer; Filter: TResampleFilter; Gamma: double);
    procedure DrawToCanvas(DestCanvas:TCanvas; xDst, yDst:integer);
    procedure SynchronizeRGBA(RGBAtoAlpha:boolean);
    procedure MergeWithAlpha(Bitmap:TIEBitmap; DstX:integer=0; DstY:integer=0; DstWidth:integer=-1; DstHeight:integer=-1; Transparency:integer=255; ResampleFilter:TResampleFilter = rfNone; Operation:TIERenderOperation=ielNormal);

{!!
<FS>TIEBitmap.Full

<FM>Declaration<FC>
property Full:boolean;

<FM>Description<FN>
Full is true all pixels are 1 (or white).
See also <A TIEBitmap.SyncFull>.
!!}
    property Full: boolean read fFull write fFull;

{!!
<FS>TIEBitmap.Origin

<FM>Declaration<FC>
property Origin:<A TIEBitmapOrigin>;

<FM>Description<FN>
Specifies bitmap origin. Default is bottomleft, that is Windows compatible.
Other libraries could require topleft (like OpenCV).
!!}
    property Origin:TIEBitmapOrigin read fOrigin write SetOrigin;

    procedure SyncFull; // set Full to True if all values are 255
    procedure Fill(Value: double); overload;
    procedure FillRect(x1, y1, x2, y2: integer; Value: double);
    property HasAlphaChannel: boolean read GetHasAlphaChannel;

{!!
<FS>TIEBitmap.MinFileSize

<FM>Declaration<FC>
property MinFileSize:int64;

<FM>Description<FN>
Specifies the minimum memory needed by the image to allow use of memory mapped file.
If the memory needed by the image is less than MinFileSize, the image will be stored in memory (also if the Location is ieFile).
If the global variable <A IEDefMinFileSize> is not -1, it overlaps the property MinFileSize value.
!!}
    property MinFileSize: int64 read fMinFileSize write fMinFileSize;

    procedure RemoveAlphaChannel(Merge:boolean=false; BackgroundColor:TColor=clWhite);

{!!
<FS>TIEBitmap.DefaultDitherMethod

<FM>Declaration<FC>
property DefaultDitherMethod:<A TIEDitherMethod>;

<FM>Description<FN>
Specifies the default dithering method to apply when a color image needs to be converted to black/white.
The default is ieThreshold.
!!}
    property DefaultDitherMethod: TIEDitherMethod read fDefaultDitherMethod write fDefaultDitherMethod;

{!!
<FS>TIEBitmap.BlackValue

<FM>Declaration<FC>
property BlackValue:double;

<FM>Description<FN>
Specifies (with <A TIEBitmap.WhiteValue>) the values range starting from black to white.

For example, if your image is a gray scale (256 levels) where only values from 100 to 200 are used (100 is black and 200 is white), to display the image you have to write:
<FC>
ImageEnView.IEBitmap.BlackValue:=100;
ImageEnView.IEBitmap.WhiteValue:=200;
ImageEnView.Update;
<FN>
!!}
    property BlackValue: double read fBlackValue write fBlackValue;

{!!
<FS>TIEBitmap.WhiteValue

<FM>Declaration<FC>
property BlackValue:double;

<FM>Description<FN>
Specifies (with <A TIEBitmap.BlackValue>) the values range starting from black to white.

For example, if your image is a gray scale (256 levels) where only values from 100 to 200 are used (100 is black and 200 is white), to display the image you have to write:
<FC>
ImageEnView.IEBitmap.BlackValue:=100;
ImageEnView.IEBitmap.WhiteValue:=200;
ImageEnView.Update;
<FN>
!!}
    property WhiteValue: double read fWhiteValue write fWhiteValue;

    procedure AutoCalcBWValues;
    property ChannelOffset[idx: integer]: integer read GetChannelOffset write SetChannelOffset;

{!!
<FS>TIEBitmap.Contrast

<FM>Declaration<FC>
property Contrast:integer;

<FM>Description<FN>
Contrast specifies a dynamic contrast to apply. It doesn't change the image but only how it is displayed.

Allowed values are 0 to 100.

<FM>Example<FC>

ImageEnView.IEBitmap.Contrast := 20;
ImageEnView.Update;
!!}
    property Contrast: integer read fContrast write fContrast;

    function IsGrayScale:boolean;
    function IsAllBlack:boolean;

{!!
<FS>TIEBitmap.PaletteUsed

<FM>Declaration<FC>
property PaletteUsed:integer;

<FM>Description<FN>
Specifies number of colors used by the palette.
!!}
    property PaletteUsed: integer read fPaletteUsed write fPaletteUsed;

    property BitAlignment: integer read fBitAlignment write SetBitAlignment;
    function IsEmpty:boolean;
    procedure CopyAndConvertFormat(Source:TIEBitmap);
    property ChannelCount:integer read GetChannelCount; // informative only field
    property BitCount: integer read GetBitCount;  // informative only field

{!!
<FS>TIEBitmap.MemoryAllocator

<FM>Declaration<FC>
property MemoryAllocator:<A TIEMemoryAllocator>;

<FM>Description<FN>
Specifies which functions use to allocate bitmap memory.
!!}
    property MemoryAllocator:TIEMemoryAllocator read fMemoryAllocator write fMemoryAllocator;

    //
    function CalcRAWSize:integer;
    procedure SaveRAWToBufferOrStream(Buffer:pointer; Stream:TStream);
    function LoadRAWFromBufferOrStream(Buffer:pointer; Stream:TStream):boolean;
    //

{!!
<FS>TIEBitmap.UndoInfo

<FM>Declaration<FC>
property UndoInfo:pointer;

<FM>Description<FN>
Used internally to store undo information.
!!}
    property UndoInfo:pointer read fUndoInfo write fUndoInfo;

    property CanvasCurrentAlpha:integer read fCanvasCurrentAlpha write SetCanvasCurrentAlpha;

    procedure CopyPaletteTo(Dest:TIEBaseBitmap); override;

    property FragmentsCount:integer read fFragmentsCount;

  end;

// TIEBitmap
///////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////







//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
// TIEMask


{!!
<FS>TIEMask

<FM>Description<FN>
TIEMask contains a selection, which is a map of selected and unselected pixels.
A selection map can have a depth of 1 bit or 8 bit.
For a map of 1 bit, 0 is a non selected pixel, while 1 is selected.
For a map of 8 bit, 0 is non selected pixel, >0 is "semi" selected pixel up to 255 that means fully selected pixel.

<A TImageEnView> component uses this class to store current selection in <A TImageEnView.SelectionMask> property.

<FM>Methods and Properties<FN>

  <A TIEMask.AllocateBits>
  <A TIEMask.Assign>
  <A TIEMask.Bits>
  <A TIEMask.BitsPerPixel>
  <A TIEMask.CombineWithAlpha>
  <A TIEMask.CopyBitmap>
  <A TIEMask.CopyIEBitmap>
  <A TIEMask.CopyIEBitmapAlpha>
  <A TIEMask.DrawOuter>
  <A TIEMask.DrawOutline>
  <A TIEMask.DrawPolygon>
  <A TIEMask.Empty>
  <A TIEMask.Fill>
  <A TIEMask.FreeBits>
  <A TIEMask.Full>
  <A TIEMask.GetPixel>
  <A TIEMask.Height>
  <A TIEMask.Intersect>
  <A TIEMask.InvertCanvas>
  <A TIEMask.IsEmpty>
  <A TIEMask.IsPointInside>
  <A TIEMask.Negative>
  <A TIEMask.Resize>
  <A TIEMask.Rowlen>
  <A TIEMask.ScanLine>
  <A TIEMask.SetPixel>
  <A TIEMask.SyncFull>
  <A TIEMask.SyncRect>
  <A TIEMask.TranslateBitmap>
  <A TIEMask.Width>
  <A TIEMask.X1>
  <A TIEMask.X2>
  <A TIEMask.Y1>
  <A TIEMask.Y2>
!!}
  TIEMask = class
  private
    fWidth: integer; // width of bit mask
    fHeight: integer; // height of bit mask
    fBitsperpixel: integer; // max 8 bits per pixel
    fRowlen: integer; // len in bytes of a row
    fBits: pbyte; // bit mask (0=not selected,  1=selected)
    fX1, fY1, fX2, fY2: integer; // bounding rect
    fBitmapInfoHeader1: TBitmapInfoHeader256;
    fTmpBmp: pbyte; // used by DrawOutline
    fTmpBmpWidth, fTmpBmpHeight: integer; // used by DrawOutline
    fTmpBmpScanline: ppointerarray; // used by DrawOutline
    fFull: boolean; // true if all pixels are 1 or 255
    fDrawPixelBitmap:TBitmap;
    fDrawPixelPtr:PRGB;
    function DrawHorizontalLine(Alpha: integer; xleft, xright, y: integer): integer;
    procedure DrawSinglePolygon(Alpha: integer; SelPoly: PPointArray; SelPolyCount: integer);
    function GetScanLine(Row: integer): pointer;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetPixel(x, y: integer; Alpha: integer);
    function GetPixel(x, y: integer): integer;
    procedure AllocateBits(width, height: integer; bitsperpixel: integer);
    procedure Resize(NewWidth, NewHeight: integer);
    procedure FreeBits;
    procedure CopyBitmap(Dest, Source: TBitmap; dstonlymask, srconlymask: boolean);
    procedure CopyIEBitmap(Dest, Source: TIEBitmap; dstonlymask, srconlymask: boolean; UseAlphaChannel: boolean);
    procedure CopyIEBitmapAlpha(Dest, Source: TIEBitmap; dstonlymask, srconlymask: boolean);
    procedure DrawPolygon(Alpha: integer; SelPoly: PPointArray; SelPolyCount: integer);
    procedure CombineWithAlpha(SourceAlpha:TIEBitmap; ox,oy:integer; SynchronizeBoundingRect:boolean);
    procedure Fill(Alpha: integer);
    procedure Empty;
    function IsPointInside(x, y: integer): boolean;
    procedure TranslateBitmap(var ox, oy: integer; CutSel: boolean);
    procedure InvertCanvas(Dest: TCanvas; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer);
    procedure DrawOuter(Dest: TBitmap; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer; AlphaBlend:integer=-1; Color:TColor=clBlack);
    procedure DrawOutline(Dest: TCanvas; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer; AniCounter: integer; Color1, Color2: TColor; actualRect:PRect = nil);
    procedure Negative(MaxVal: integer);
    procedure SyncFull; // set Full to True if all values are 255
    procedure SyncRect; // set X1,Y1,X2,Y2
    procedure Intersect(x1,y1,x2,y2:integer);
    function CreateResampledMask(NewWidth,NewHeight:integer):TIEMask;

{!!
<FS>TIEMask.Width

<FM>Declaration<FC>
property Width:integer;

<FM>Description<FN>
Width of the selection mask. It must be equal to the image width. (readonly)
!!}
    property Width: integer read fWidth;

{!!
<FS>TIEMask.Height

<FM>Declaration<FC>
property Height:integer;

<FM>Description<FN>
Height of the selection mask. It must be equal to the image height. (readonly)
!!}
    property Height: integer read fHeight;

{!!
<FS>TIEMask.BitsPerPixel

<FM>Declaration<FC>
property BitsPerPixel:integer;

<FM>Description<FN>
Bits per pixels of the mask. ImageEn supports only 1 bit selection masks (1 selected, 0 not selected). (readonly)
!!}
    property BitsPerPixel: integer read fBitsPerPixel;

{!!
<FS>TIEMask.X1

<FM>Declaration<FC>
property X1:integer;

<FM>Description<FN>
Left-up side of the non-empty selection (an empty mask has 1).
!!}
    property X1: integer read fX1 write fX1;

{!!
<FS>TIEMask.Y1

<FM>Declaration<FC>
property Y1:integer;

<FM>Description<FN>
Left-up side of the non-empty selection (an empty mask has 1).
!!}
    property Y1: integer read fY1 write fY1;

{!!
<FS>TIEMask.X2

<FM>Declaration<FC>
property X2:integer;

<FM>Description<FN>
Right-bottom side of the non-empty selection.
!!}
    property X2: integer read fX2 write fX2;

{!!
<FS>TIEMask.Y2

<FM>Declaration<FC>
property Y2:integer;

<FM>Description<FN>
Right-bottom side of the non-empty selection.
!!}
    property Y2: integer read fY2 write fY2;

    function IsEmpty: boolean;
    property ScanLine[row: integer]: pointer read GetScanLine;
    procedure Assign(Source: TIEMask);

{!!
<FS>TIEMask.Rowlen

<FM>Declaration<FC>
property Rowlen:integer;

<FM>Description<FN>
The length of a row in bytes. (readonly)
!!}
    property Rowlen: integer read fRowlen;

{!!
<FS>TIEMask.Bits

<FM>Declaration<FC>
property Bits:pbyte;

<FM>Description<FN>
Contains the raw buffer of the selection mask.
!!}
    property Bits: pbyte read fBits;

{!!
<FS>TIEMask.Full

<FM>Declaration<FC>
property Full:boolean;

<FM>Description<FN>
True when the mask contains all 1 values (that is the image has all pixels selected).
!!}
    property Full: boolean read fFull write fFull;

  end;

// TIEMask
//////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////







  TIEVirtualImageInfo = record
    pos: int64;
    vsize: int64;
    ptr: pointer;         // pointer to a memory buffer. it is <>nil if view mapped
    bitmapped: boolean;   // true if this image is in the fBmpToRelease list
    orig_width: integer;  // assigned by class user (info for original image when here is stored a thumbnail)
    orig_height: integer; // assigned by class user (info for original image when here is stored a thumbnail)
    HasAlphaChannel: boolean;
    currentaccess: TIEDataAccess;
    ImWidth:integer;
    ImHeight:integer;
    ImBitCount:integer;
    ImPixelFormat:TIEPixelFormat; // specifies how ImBitCount is organized (not actually used by TIEVirtualImageList)
  end;
  PIEVirtualImageInfo = ^TIEVirtualImageInfo;

  TIEVirtualToReleaseBmp = record
    info: PIEVirtualImageInfo;
    bmp: TIEBitmap;
    refcount: integer;
  end;
  PIEVirtualToReleaseBmp = ^TIEVirtualToReleaseBmp;

  TIEVirtualFreeBlock = record
    pos: int64;
    vsize: dword; // size of the free block
  end;
  PIEVirtualFreeBlock = ^TIEVirtualFreeBlock;

  TIEVirtualImageList = class
  private
    fmemmap: TIEFileBuffer;
    fUseDisk: boolean;
    fSize: int64;             // allocated size
    fImageInfo: TList;
    fToDiscardList: TList;    // list of the image to unmap (the first is the next to discard)
    fFreeBlocks: TList;       // list of free blocks in the file
    fInsPos: int64;           // next free space
    fAllocationBlock: dword;
    fMaxImagesInMemory: integer;
    fImagesInMemory: integer;
    fBmpToRelease: TList;     // list of to-release bitmaps (TBitmap) objects, list of TIEVirtualToReleaseBmp
    fLastVImageSize: dword;
    fDescriptor:string;       // a descriptor which identifies the file inside the temp directory
    function GetImageCount: integer;
    function BmpToReleaseIndexOf(image: pointer): integer;
    procedure MergeConsecutiveBlocks();
  protected
    procedure ReAllocateBits;
    procedure FreeBits;
    procedure RemoveImageInfo(idx: integer; deleteItem:boolean);
    procedure DiscardImage(info: PIEVirtualImageInfo);
    procedure DiscardOne;
    procedure DiscardAll;
    procedure MapImage(image: pointer; access: TIEDataAccess);
    function AllocImage(image: pointer; Width, Height, Bitcount: integer; PixelFormat:TIEPixelFormat; HasAlpha: boolean): boolean;
    procedure DirectCopyToBitmap(image: pointer; bitmap: TIEBitmap);
    procedure CreateEx;
    procedure DestroyEx;
  public
    constructor Create(const Descriptor:string; UseDisk:boolean);
    destructor Destroy; override;
    procedure PrepareSpaceFor(Width, Height: integer; Bitcount: integer; ImageCount: integer);
    function AddBlankImage(Width, Height, Bitcount: integer; PixelFormat:TIEPixelFormat; HasAlpha: boolean): pointer;
    // bitmaps import/export
    function AddBitmap(bitmap: TBitmap): pointer;
    function AddIEBitmap(bitmap: TIEBaseBitmap): pointer;
    function AddBitmapRect(bitmap: TBitmap; xsrc, ysrc, dxsrc, dysrc: integer): pointer;
    procedure CopyToIEBitmap(image: pointer; bitmap: TIEBitmap);
    procedure CopyFromIEBitmap(image: pointer; bitmap: TIEBitmap);
    function GetBitmap(image: pointer): TIEBitmap;
    procedure ReleaseBitmap(bitmap: TIEBitmap; changed: boolean);
    procedure ReleaseBitmapByImage(image: pointer; changed: boolean);
    //
    property MaxImagesInMemory: integer read fMaxImagesInMemory write fMaxImagesInMemory;
    property ImageCount: integer read GetImageCount;
    procedure Delete(image: pointer);
    // image info
    function GetImageWidth(image: pointer): integer;
    function GetImageHeight(image: pointer): integer;
    function GetImageOriginalWidth(image: pointer): integer;
    function GetImageOriginalHeight(image: pointer): integer;
    procedure SetImageOriginalWidth(image: pointer; Value: integer);
    procedure SetImageOriginalHeight(image: pointer; Value: integer);
    function GetImageBitCount(image: pointer): integer;
    function GetImageBits(image: pointer): pointer;
    function GetImagePixelFormat(image: pointer):TIEPixelFormat;
    function GetImagePalette(image:pointer):pointer;
    function GetAlphaBits(image: pointer): pointer;
    function GetImageFilePos(image:pointer):int64;
    function FindImageIndex(image:pointer):integer;
    function GetImageFromIndex(index:integer):pointer;
    // input/output
    procedure SaveToStream(Stream:TStream);
    function LoadFromStream(Stream:TStream):boolean;
  end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEDibBitmap

{!!
<FS>TIEDibBitmap

<FM>Description<FN>
TIEDibBitmap encapsulates a Windows DIB section.
It inherits from <A TIEBaseBitmap>.

<FM>Methods and Properties<FN>

  <A TIEDibBitmap.Allocate>
  <A TIEDibBitmap.AllocateBits>
  <A TIEDibBitmap.Assign>
  <A TIEDibBitmap.BitCount>
  <A TIEDibBitmap.Bits>
  <A TIEDibBitmap.CopyToTBitmap>
  <A TIEDibBitmap.DIB>
  <A TIEDibBitmap.FreeBits>
  <A TIEDibBitmap.HDC>
  <A TIEDibBitmap.Height>
  <A TIEDibBitmap.Rowlen>
  <A TIEDibBitmap.Scanline>
  <A TIEDibBitmap.Width>
!!}
  // a DIB section (used for little image processing and transfers tasks)
  // BitCount supportted:
  //		1 : black/white images
  //    24: true color images
  TIEDibBitmap = class(TIEBaseBitmap)
  private
    fWidth, fHeight: dword;
    fBitCount: dword;
    fRowLen: dword;
    fHDC: THandle;
    fDIB: THandle;
    fBitmapInfoHeader1: TBitmapInfoHeader256;
    fBits: pointer;
  protected
    function GetBitCount: integer; override;
    function GetWidth: integer; override;
    function GetHeight: integer; override;
    function GetPixelFormat: TIEPixelFormat; override;
    function GetRowLen: integer; override;
    function GetScanLine(row: integer): pointer; override;
    function GetPalette(index: integer): TRGB; override;
    function GetPaletteBuffer:pointer; override;
    procedure SetPalette(index: integer; Value: TRGB); override;
    function GetPaletteLen:integer; override;
  public
    constructor Create;
    destructor Destroy; override;
    function AllocateBits(BmpWidth, BmpHeight, BmpBitCount: dword):boolean;
    function Allocate(ImageWidth, ImageHeight: integer; ImagePixelFormat: TIEPixelFormat):boolean; override;
    procedure FreeBits;

{!!
<FS>TIEDibBitmap.HDC

<FM>Declaration<FC>
property HDC: THandle;

<FM>Description<FN>
Returns the device context (HDC) handle of this DIB section.
!!}
    property HDC: THandle read fHDC;

{!!
<FS>TIEDibBitmap.DIB

<FM>Declaration<FC>
property DIB: Thandle;

<FM>Description<FN>
Returns the DIB handle.
!!}
    property DIB: Thandle read fDIB;

{!!
<FS>TIEDibBitmap.Width

<FM>Declaration<FC>
property Width: dword

<FM>Description<FN>
Returns the DIB width.
!!}
    property Width: dword read fWidth;

{!!
<FS>TIEDibBitmap.Height

<FM>Declaration<FC>
property Height: dword;

<FM>Description<FN>
Returns the DIB height.
!!}
    property Height: dword read fHeight;

{!!
<FS>TIEDibBitmap.BitCount

<FM>Declaration<FC>
property BitCount: dword;

<FM>Description<FN>
Returns the DIB bit count (1 or 24).
!!}
    property BitCount: dword read fBitCount;

{!!
<FS>TIEDibBitmap.Scanline

<FM>Declaration<FC>
property Scanline[row: integer]: pointer;

<FM>Description<FN>
Returns a pointer to the specified row.
!!}
    property Scanline[row: integer]: pointer read GetScanline;

{!!
<FS>TIEDibBitmap.Bits

<FM>Declaration<FC>
property Bits: pointer;

<FM>Description<FN>
Returns a pointer to bitmap bits.
!!}
    property Bits: pointer read fBits;

{!!
<FS>TIEDibBitmap.Rowlen

<FM>Declaration<FC>
property Rowlen: integer;

<FM>Description<FN>
Returns the row length in bytes.
!!}
    property Rowlen: integer read GetRowlen;

    procedure CopyToTBitmap(Dest: TBitmap);
    procedure Assign(Source: TObject); override;

    procedure CopyPaletteTo(Dest:TIEBaseBitmap); override;

  end;

// TIEDibBitmap
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////







{$ifdef IEINCLUDEIMAGINGANNOT}

  OIAN_MARK_ATTRIBUTES = record
    uType: integer;
    lrBounds: TRect;
    rgbColor1: TRGBQUAD;
    rgbColor2: TRGBQUAD;
    bHighlighting: longbool;
    bTransparent: longbool;
    uLineSize: dword;
    uReserved1: dword;
    uReserved2: dword;
    lfFont: TLOGFONTA;
    bReserved3: dword;
    Time: integer;
    bVisible: longbool;
    dwReserved4: dword;
    lReserved: array[0..9] of integer;
  end;

{!!
<FS>TIEImagingObject

<FM>Declaration<FC>
TIEImagingObject = class;

<FM>Description<FN>
Internal representation of an imaging object.
!!}
  TIEImagingObject = class
  private
    attrib: OIAN_MARK_ATTRIBUTES;
    points: PIEPointArray;
    pointsLen: integer;
    text: PAnsiChar;
    image: TIEBitmap;
  public
    constructor Create;
    destructor Destroy; override;
  end;

{!!
<FS>TIEImagingAnnot

<FM>Description<FN>
ImagingAnnot contains the (Wang) imaging annotations loaded (or to save) from a TIFF.
Using <A TIEImagingAnnot> object you can create new objects, copy to a <A TImageEnVect> (as vectorial objects), copy from a <A TImageEnVect> (from vectorial objects) or just draw on the bitmap.

<FM>Methods and Properties<FN>

  <A TIEImagingAnnot.Assign>
  <A TIEImagingAnnot.Clear>
  <A TIEImagingAnnot.CopyFromTImageEnVect>
  <A TIEImagingAnnot.CopyToTImageEnVect>
  <A TIEImagingAnnot.DrawToBitmap>
  <A TIEImagingAnnot.LoadFromStandardBuffer>
  <A TIEImagingAnnot.LoadFromStream>
  <A TIEImagingAnnot.Objects>
  <A TIEImagingAnnot.ObjectsCount>
  <A TIEImagingAnnot.SaveToStandardBuffer>
  <A TIEImagingAnnot.SaveToStream>
!!}
  TIEImagingAnnot = class
  private
    fParent:TObject; // optional parent object
    fUserChanged: boolean;
    fObjects: TList;
    function GetObject(idx: integer): TIEImagingObject;
    function GetObjectsCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromStandardBuffer(buffer: pointer; buflen: integer);
    procedure SaveToStandardBuffer(var Buffer: pointer; var BufferLength: integer);
    property UserChanged: boolean read fUserChanged write fUserChanged;
    procedure Clear;
    procedure Assign(Source: TIEImagingAnnot);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    procedure CopyToTImageEnVect(Target: TObject=nil);
    procedure CopyFromTImageEnVect(Target: TObject=nil);
    procedure DrawToBitmap(target: TIEBitmap; Antialias: boolean);
    property Objects[idx: integer]: TIEImagingObject read GetObject;
    property ObjectsCount: integer read GetObjectsCount;
    property Parent:TObject read fParent write fParent;
  end;

{$endif}  // IEINCLUDEIMAGINGANNOT










  // a bitmap in memory that doesn't use system handles
  // BitCount supported:
  //		1	: black/white
  //		8  : gray (no palette)
  //   24  : true color
  //   32  : true color + alpha (or 32 bit float point)
  //   64  : double (64 bit float point)
  TIEWorkBitmap = class
  private
    fWidth, fHeight: integer;
    fBitCount: integer;
    fRowLen: integer;
    fBits: pointer;
    function GetScanline(row: integer): pointer;
  public
    constructor Create(BmpWidth, BmpHeight, BmpBitCount: integer);
    destructor Destroy; override;
    procedure AllocateBits(BmpWidth, BmpHeight, BmpBitCount: integer);
    procedure FreeBits;
    property Width: integer read fWidth;
    property Height: integer read fHeight;
    property BitCount: integer read fBitCount;
    property Scanline[row: integer]: pointer read GetScanline;
    property Bits: pointer read fBits;
    property Rowlen: integer read fRowlen;
    function GetPByte(row, col: integer): pbyte;
    function GetPRGB(row, col: integer): PRGB;
    function GetPDouble(row, col: integer): PDouble;
    function GetPSingle(row, col: integer): PSingle;
    function GetPInteger(row, col: integer): pinteger;
    procedure SetBit(row, col: integer; value: integer);
  end;




{!!
<FS>TIETIFTagsReader

<FM>Description<FN>
TIETIFTagsReader allows reading of single tags from a TIFF file or stream.

Look also <A TIETIFFHandler> for a more powerful TIFF handling class.

<FM>Methods and Properties<FN>

  <A TIETIFTagsReader.CreateFromFile>
  <A TIETIFTagsReader.CreateFromIFD>
  <A TIETIFTagsReader.CreateFromStream>
  <A TIETIFTagsReader.GetInteger>
  <A TIETIFTagsReader.GetIntegerArray>
  <A TIETIFTagsReader.GetIntegerIndexed>
  <A TIETIFTagsReader.GetMiniString>
  <A TIETIFTagsReader.GetRational>
  <A TIETIFTagsReader.GetRationalIndexed>
  <A TIETIFTagsReader.GetRawData>
  <A TIETIFTagsReader.GetString>
  <A TIETIFTagsReader.ImageCount>
  <A TIETIFTagsReader.TagExists>
  <A TIETIFTagsReader.TagLength>



<FM>Example<FC>
Var
  Tags:TIETIFTagsReader;
...
Tags:=TIETIFTagsReader.CreateFromFile('input.tif',0);  // read tags of the first image (page)
If Tags.TagExists(269) then
  DocumentName := Tags.GetString(269);  // 269 is the document name
If Tags.TagExists(285) then
  Pagename := Tags.GetString(285);  // 285 is the page name
Tags.free;

!!}
  TIETIFTagsReader = class
  private
    fFileStream: TStream;
    fStream: TStream;
    fTIFFEnv: TTIFFEnv;
    fNumi: integer;
  public
    constructor CreateFromFile(const FileName: string; ImageIndex: integer);
    constructor CreateFromStream(Stream: TStream; ImageIndex: integer);
    constructor CreateFromIFD(tagReader: TIETIFTagsReader; IFDTag: integer);
    destructor Destroy; override;

{!!
<FS>TIETIFTagsReader.ImageCount

<FM>Declaration<FC>
property ImageCount:integer;

<FM>Description<FN>
ImageCount returns the pages existing in the TIFF.
!!}
    property ImageCount: integer read fNumi;

    function TagExists(Tag: integer): boolean;
    function TagLength(Tag: integer): integer;
    function GetInteger(Tag: integer): integer;
    function GetIntegerIndexed(Tag: integer; index: integer): integer;
    function GetRational(Tag:integer; defaultValue:double = 0): double;
    function GetRationalIndexed(Tag:integer; index:integer; defVal:double=0.0):double;
    function GetIntegerArray(Tag: integer; var ar: PDWordArray): integer;
    function GetRawData(Tag: integer): pointer;
    function GetString(Tag: integer): AnsiString;
    function GetMiniString(Tag: integer): AnsiString;
  end;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIETagsHandler

TIEEXIFMakerNoteDeviceInfo = record
  signature:AnsiString;
  base:(iemnAbsolute, iemnTIFFHeader);
  headerType:(iemnNONE, iemnTIFF, iemnIFDOFFSET);
  TIFFHeader:TTIFFHeader; // in case of iemnTIFF
  byteOrder:(ieboFromEXIF, ieboFromTIFFHeader, ieboLittleEndian, ieboBigEndian);
end;


{!!
<FS>TIETagsHandler

<FM>Description<FN>
This class allows to read EXIF maker note tags, when it is in form of IFD (like Canon).

<FM>Methods and Properties<FN>

  <A TIETagsHandler.GetInteger>
  <A TIETagsHandler.GetIntegerArray>
  <A TIETagsHandler.GetIntegerIndexed>
  <A TIETagsHandler.GetMiniString>
  <A TIETagsHandler.GetRational>
  <A TIETagsHandler.GetRationalIndexed>
  <A TIETagsHandler.GetRawData>
  <A TIETagsHandler.GetString>
  <A TIETagsHandler.TagExists>
  <A TIETagsHandler.TagLength>
!!}
  TIETagsHandler=class
  private
    fUnparsedData:pointer;
    fUnparsedDataLength:integer;
    fEXIFMakerInfo:TIEEXIFMakerNoteDeviceInfo;
    fData:TMemoryStream;
    fTIFFEnv:TTIFFEnv;

    procedure SetUnparsedData(value:pointer);
    procedure CheckHeader;
  public
    constructor Create;
    destructor Destroy; override;
    property Data:TMemoryStream read fData;
    procedure Update; // synch fTIFFEnv with fData content
    procedure Assign(source:TIETagsHandler);
    procedure Clear;

    function TagExists(Tag: integer): boolean;
    function TagLength(Tag: integer): integer;
    function GetInteger(Tag: integer): integer;
    function GetIntegerIndexed(Tag: integer; index: integer): integer;
    function GetRational(Tag:integer; defaultValue:double = 0): double;
    function GetRationalIndexed(Tag:integer; index:integer; defVal:double=0.0):double;
    function GetIntegerArray(Tag: integer; var ar: PDWordArray): integer;
    function GetRawData(Tag: integer): pointer;
    function GetString(Tag: integer): AnsiString;
    function GetMiniString(Tag: integer): AnsiString;

    property UnparsedData:pointer read fUnparsedData write SetUnparsedData;
    property UnparsedDataLength:integer read fUnparsedDataLength write fUnparsedDataLength;

    procedure ReadFromStream(stream:TStream; size:integer; littleEndian:boolean);
    function WriteToStream(stream:TStream):integer;
  end;

// TIETagsHandler
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
<FS>TIETagType

<FM>Declaration<FC>
}
  TIETagType=(ttUnknown, ttByte, ttAscii, ttShort, ttLong, ttRational, ttSByte, ttUndefined, ttSShort, ttSLong, ttSRational, ttFloat, ttDouble);
{!!}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIETIFFHandler

{$ifdef IEINCLUDETIFFHANDLER}

{!!
<FS>TIETIFFHandler

<FM>Description<FN>
TIETIFFHandler class allows you to read all TIFF tags, edit/add tags and pages, delete pages, and finally save back the modified TIFF.
This class is unable to work with some OLD-JPEG tiff files. OLD-JPEG compression is no more in TIFF standard.

<FM>Examples<FN>
<A TIETIFFHandler examples>

<FM>Demo<FN>
inputoutput/tiffhandler

<FM>Methods and Properties<FN>

  <A TIETIFFHandler.Create>

  <FI>Input/output<FN>

  <A TIETIFFHandler.ReadFile>
  <A TIETIFFHandler.ReadStream>
  <A TIETIFFHandler.InsertTIFFStream>
  <A TIETIFFHandler.InsertTIFFFile>
  <A TIETIFFHandler.InsertPageAsFile>
  <A TIETIFFHandler.InsertPageAsStream>
  <A TIETIFFHandler.InsertPageAsImage>
  <A TIETIFFHandler.WriteFile>
  <A TIETIFFHandler.WriteStream>
  <A TIETIFFHandler.FreeData>

  <FI>Informational<FN>

  <A TIETIFFHandler.LittleEndian>
  <A TIETIFFHandler.Version>

  <FI>Tag info/handling<FN>

  <A TIETIFFHandler.GetTagsCount>
  <A TIETIFFHandler.GetPagesCount>
  <A TIETIFFHandler.GetTagCode>
  <A TIETIFFHandler.GetTagType>
  <A TIETIFFHandler.GetTagLength>
  <A TIETIFFHandler.GetTagLengthInBytes>
  <A TIETIFFHandler.FindTag>
  <A TIETIFFHandler.DeleteTag>
  <A TIETIFFHandler.GetTagDescription>
  <A TIETIFFHandler.ChangeTagCode>

  <FI>Tag read<FN>

  <A TIETIFFHandler.GetInteger>
  <A TIETIFFHandler.GetString>
  <A TIETIFFHandler.GetFloat>
  <A TIETIFFHandler.GetValue>
  <A TIETIFFHandler.SaveTagToFile>
  <A TIETIFFHandler.GetValueRAW>

  <FI>Tag write<FN>

  <A TIETIFFHandler.SetValue>
  <A TIETIFFHandler.SetValueRAW>

  <FI>Tag copy<FN>

  <A TIETIFFHandler.CopyTag>

  <FI>Pages handling<FN>

  <A TIETIFFHandler.DeletePage>
  <A TIETIFFHandler.InsertPage>
  <A TIETIFFHandler.MovePage>
  <A TIETIFFHandler.ExchangePage>

!!}


{!!
<FS>TIETIFFHandler examples

<FC>
// add a custom tag (65000 with 'Hello World') at page 0
mytif := TIETIFFHandler.Create('input.tif');
mytif.SetValue(0, 65000, ttAscii, 'Hello World!');
mytif.WriteFile('output.tif');
mytif.free;

// delete second page (indexed 1) of a multipage tiff
mytif := TIETIFFHandler.Create('input.tif');
mytif.DeletePage(1);
mytif.WriteFile('output.tif');
mytif.free;

// insert a new page from an external file
mytif := TIETIFFHandler.Create('input.tif');
mytif.InsertPageAsFile('external.jpg',0);
mytif.WriteFile('output.tif');
mytif.free;

// merge two tiff (even they are multipage files..)
mytif := TIETIFFHandler.Create('input-1.tif');
mytif.InsertTIFFFile('input-2.tif',mytif.PagesCount-1);
mytif.WriteFile('output.tif');
mytif.free;

// read tag 305 ('software')
mytif := TIETIFFHandler.Create('input-1.tif');
software:=mytif.GetString(0, mytif.FindTag(0,305));
mytif.free;
!!}

  TIETIFFHandler=class
  private
    fIsMotorola:boolean;
    fVersion:word;
    fPages:TList; // each item contain another TList which contains pointers to TTIFFTAG
    function ReadHeader(Stream:TStream):boolean;
    function xword(value:word):word;
    function xdword(value:dword):dword;
    function GetIntegerByCode(page:integer; tagcode:integer; idx:integer):integer; overload;
    function GetIntegerByCode(ifd:TList; tagcode:integer; idx:integer):integer; overload;
    procedure SortTags(pageIndex:integer); overload;
    procedure SortTags(ifd:TList); overload;
    function GetValueRAWEx(pageIndex:integer; tagIndex: integer; arrayIndex: integer; var tagType:integer): pointer; overload;
    function GetValueRAWEx(tag:PTIFFTAG; arrayIndex: integer): pointer; overload;
    function GetLittleEndian:boolean;
    procedure CheckPairTag(tagCode:integer; var tgpos:integer; var tglen:integer); overload;
    function CheckPairTag(tagCode:integer):boolean; overload;
    function CheckIFD(tagCode:integer):boolean;
    function ReadIFD(Stream:TStream; Pages:TList; ifd:TList; insertPos:integer):boolean;
    function FindTag(ifd:TList; tagCode:integer):integer; overload;
    procedure DeleteTag(pageIndex:integer; tagIndex:integer; checkOffsetTags:boolean); overload;
    procedure DeleteTag(ifd:TList; tagIndex:integer; checkOffsetTags:boolean); overload;
    procedure WriteIFD(Stream:TStream; ifd:TList; var dataPos:int64);
    function GetInteger(ifd:TList; tagIndex:integer; arrayIndex:integer):integer; overload;
    procedure SetValue(ifd:TList; tagCode:integer; tagType:TIETagType; value:variant); overload;
    procedure CopyTag(src_ifd:TList; srcTagIndex:integer; source:TIETIFFHandler; dst_ifd:TList); overload;
    procedure init;
  public
    constructor Create; overload;
    constructor Create(const FileName:string); overload;
    constructor Create(Stream:TStream); overload;
    destructor Destroy; override;

    // input/output

    function ReadFile(const FileName:string):boolean;
    function ReadStream(Stream:TStream):boolean;
    function InsertTIFFStream(Stream:TStream; pageIndex:integer):boolean;
    function InsertTIFFFile(const FileName:string; pageIndex:integer):boolean;
    function InsertPageAsFile(const FileName:string; pageIndex:integer):boolean;
    function InsertPageAsStream(Stream:TStream; pageIndex:integer):boolean;
    function InsertPageAsImage(viewer:TObject; pageIndex:integer):boolean;
    procedure WriteFile(const FileName:string; page:integer = -1);
    procedure WriteStream(Stream:TStream; page:integer = -1);
    procedure FreeData;

    // tag info/handling

    function GetTagsCount(pageIndex:integer):integer;
    function GetPagesCount:integer;
    function GetTagCode(pageIndex:integer; tagIndex:integer):integer;
    function GetTagType(pageIndex:integer; tagIndex:integer):TIETagType;
    function GetTagLength(pageIndex:integer; tagIndex:integer):integer;
    function GetTagLengthInBytes(pageIndex:integer; tagIndex:integer):integer;
    function FindTag(pageIndex:integer; tagCode:integer):integer; overload;
    procedure DeleteTag(pageIndex:integer; tagIndex:integer); overload;
    function GetTagDescription(pageIndex:integer; tagIndex:integer):AnsiString;
    procedure ChangeTagCode(pageIndex:integer; tagIndex:integer; newCode:integer);

    // tag read

    function GetInteger(pageIndex:integer; tagIndex:integer; arrayIndex:integer):integer; overload;
    function GetString(pageIndex:integer; tagIndex:integer):AnsiString;
    function GetFloat(pageIndex:integer; tagIndex:integer; arrayIndex:integer):double;
    function GetValue(pageIndex:integer; tagIndex:integer; arrayIndex:integer):variant;
    procedure SaveTagToFile(pageIndex:integer; tagIndex:integer; const fileName:string);
    function GetValueRAW(pageIndex:integer; tagIndex: integer; arrayIndex: integer): pointer;

    // tag write

    procedure SetValue(pageIndex:integer; tagCode:integer; tagType:TIETagType; value:variant); overload;
    procedure SetValueRAW(pageIndex:integer; tagCode:integer; tagType:TIETagType; dataNum:integer; buffer:pointer);

    // tag copy

    procedure CopyTag(srcPageIndex:integer; srcTagIndex:integer; source:TIETIFFHandler; dstPageIndex:integer); overload;

    // pages handling

    procedure DeletePage(pageIndex:integer);
    procedure ExchangePage(Index1, Index2:integer);
    procedure MovePage(CurIndex, NewIndex:integer);
    function InsertPage(pageIndex:integer = -1):integer; overload;
    function InsertPage(pageIndex:integer; sourceHandler:TIETIFFHandler; sourcePage:integer):integer; overload;

    // informational

    property LittleEndian:boolean read GetLittleEndian;

{!!
<FS>TIETIFFHandler.Version

<FM>Declaration<FC>
property Version:word;

<FM>Description<FN>
Returns file version. TIFF ver.6 will have $2A, while Microsoft HD Photo will have $1BC.
!!}
    property Version:word read fVersion write fVersion;

  end;

{$endif}

// TIETIFFHandler
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////


  TIEGraphicBase = class(TGraphic)
  private
    fio: TObject; // TImageEnIO
    bmp: TIEBitmap;
    fFiletype: integer;
    fResampleFilter:TResampleFilter;
  protected
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    procedure SetHeight(Value: Integer); override;
    procedure SetWidth(Value: Integer); override;
    procedure WriteData(Stream: TStream); override;
    procedure ReadData(Stream: TStream); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE); {$ifndef FPC} override; {$endif}
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);  {$ifndef FPC} override; {$endif}
    procedure Assign(Source: TPersistent); override;
    property IO: TObject read fio;
    property ResampleFilter:TResampleFilter read fResampleFilter write fResampleFilter;
    property IEBitmap:TIEBitmap read bmp;
    procedure AssignTo(Dest: TPersistent); override;
  end;

  // a memorystream that doesn't create the memory space (and doesn't free it)
  TIEMemStream = class(TCustomMemoryStream)
  public
    constructor Create(Ptr: pointer; Size: integer);
    procedure SetSize(NewSize: Longint); override;
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

type

  IE_PROFILE=packed record
    dwType:DWORD;
    pProfileData:pointer;
    cbDataSize:DWORD;
  end;
  IE_PPROFILE=^IE_PROFILE;
  IE_HPROFILE=THANDLE;
  IE_PHPROFILE=^IE_HPROFILE;
  IE_HTRANSFORM=THandle;


  TIE_ICMProgressProcCallback=function(ulMax:dword; ulCurrent:dword ; ulCallbackData:LPARAM):longbool; stdcall;
  TIE_OpenColorProfile=function ( pProfile: IE_PPROFILE; dwDesiredAccess:DWORD ; dwShareMode:DWORD ; dwCreationMode:DWORD):IE_HPROFILE; stdcall;
  TIE_CloseColorProfile=function ( hProfile:IE_HPROFILE ):longbool; stdcall;
  TIE_CreateMultiProfileTransform=function ( pahProfiles:IE_PHPROFILE; nProfiles:DWORD; padwIntent:PDWORD; nIntents:DWORD; dwFlags:DWORD; indexPreferredCMM:DWORD ):IE_HTRANSFORM; stdcall;
  TIE_DeleteColorTransform=function ( hColorTransform:IE_HTRANSFORM ):longbool; stdcall;
  TIE_TranslateColors=function ( hColorTransform:IE_HTRANSFORM; paInputColors:pointer ; nColors:DWORD ; ctInput:dword ; paOutputColors:pointer ; ctOutput:dword ):longbool; stdcall;


var
  IE_OpenColorProfile:TIE_OpenColorProfile;
  IE_CloseColorProfile:TIE_CloseColorProfile;
  IE_CreateMultiProfileTransform:TIE_CreateMultiProfileTransform;
  IE_DeleteColorTransform:TIE_DeleteColorTransform;
  IE_TranslateColors:TIE_TranslateColors;

const
  IE_COLOR_GRAY=1;
  IE_COLOR_RGB=2;
  IE_COLOR_XYZ=3;
  IE_COLOR_Yxy=4;
  IE_COLOR_Lab=5;
  IE_COLOR_3_CHANNEL=6;
  IE_COLOR_CMYK=7;
  IE_COLOR_5_CHANNEL=8;
  IE_COLOR_6_CHANNEL=9;
  IE_COLOR_7_CHANNEL=10;
  IE_COLOR_8_CHANNEL=11;
  IE_COLOR_NAMED=12;


const
  IE_PROFILE_READ        =1;
  IE_PROFILE_READWRITE   =2;
  IE_PROFILE_FILENAME    =1;
  IE_PROFILE_MEMBUFFER   =2;
  IE_LCS_SIGNATURE:AnsiString       ='PSOC';
  IE_LCS_CALIBRATED_RGB   =$00000000;
  IE_LCS_sRGB:AnsiString             ='sRGB';
  IE_LCS_WINDOWS_COLOR_SPACE:AnsiString ='Win ';
  IE_LCS_GM_BUSINESS                 =$00000001;
  IE_LCS_GM_GRAPHICS                 =$00000002;
  IE_LCS_GM_IMAGES                   =$00000004;
  IE_LCS_GM_ABS_COLORIMETRIC         =$00000008;
  IE_PROOF_MODE                  =$00000001;
  IE_NORMAL_MODE                 =$00000002;
  IE_BEST_MODE                   =$00000003;
  IE_ENABLE_GAMUT_CHECKING       =$00010000;
  IE_USE_RELATIVE_COLORIMETRIC   =$00020000;
  IE_FAST_TRANSLATE              =$00040000;
  IE_INDEX_DONT_CARE     =0;
  IE_INTENT_PERCEPTUAL               =0;
  IE_INTENT_RELATIVE_COLORIMETRIC    =1;
  IE_INTENT_SATURATION               =2;
  IE_INTENT_ABSOLUTE_COLORIMETRIC    =3;

const
  IE_CS2IF:array [0..8] of dword=(IE_COLOR_RGB,IE_COLOR_RGB,IE_COLOR_CMYK,IE_COLOR_CMYK,IE_COLOR_Lab,IE_COLOR_GRAY,IE_COLOR_RGB,IE_COLOR_RGB,IE_COLOR_3_CHANNEL);

type

{!!
<FS>TIEICC

<FM>Description<FN>
TIEICC class contains a color profile. It is used for the loaded image ICC profile and for the display ICC profile (which default is sRGB).

Note: several constants are defined in ielcms unit.

<FM>Methods and Properties<FN>

  <A TIEICC.Apply>
  <A TIEICC.Apply2>
  <A TIEICC.Assign_LabProfile>
  <A TIEICC.Assign_LabProfileD50>
  <A TIEICC.Assign_LabProfileFromTemp>
  <A TIEICC.Assign_sRGBProfile>
  <A TIEICC.Assign_XYZProfile>
  <A TIEICC.Assign>
  <A TIEICC.Clear>
  <A TIEICC.ConvertBitmap>
  <A TIEICC.Copyright>
  <A TIEICC.Description>
  <A TIEICC.FreeTransform>
  <A TIEICC.IsApplied>
  <A TIEICC.IsValid>
  <A TIEICC.LoadFromBuffer>
  <A TIEICC.LoadFromFile>
  <A TIEICC.LoadFromStream>
  <A TIEICC.SaveToStream>
  <A TIEICC.Transform>
!!}
  TIEICC = class
  private
    fUseLCMS:boolean;
    fRaw:pbyte;
    fRawLen:integer;
    fProfile:pointer;
    fProfileStream:TIEMemStream;
    fMSProfile:THandle; // MSCMS profile handle
    fApplied:boolean;
    // current transform data
    fTransform:pointer;
    fInputFormat:integer;
    fOutputFormat:integer;
    fDestination:TIEICC;
    fIntent:integer;
    fFlags:integer;
    fMSTransform:THandle;
    // informative data
    fCopyright:AnsiString;
    fDescription:AnsiString;
    //
    procedure OpenProfileFromRaw;
    procedure CloseProfileFromRaw;
    procedure ExtractInfo;
  public
    property MSTransform:THandle read fMSTransform;
    constructor Create(UseLCMS:boolean=true); // UseLCMS=true works only when IEINCLUDECMS is defined, otherwise it is always False
    destructor Destroy; override;
    procedure LoadFromBuffer(buffer:pointer; bufferlen:integer);
    procedure Clear;
    procedure SaveToStream(Stream:TStream; StandardICC:boolean);
    procedure LoadFromStream(Stream:TStream; StandardICC:boolean);
    procedure LoadFromFile(const FileName:string);
    procedure Assign(source:TIEICC);
    function IsValid:boolean;

{!!
<FS>TIEICC.IsApplied

<FM>Declaration<FC>
property IsApplied:boolean;

<FM>Description<FN>
Returns True if <A TIEICC.Transform>, <A TIEICC.Apply> or <A TIEICC.Apply2> runned since the profile has been loaded.
!!}
    property IsApplied:boolean read fApplied; // true after FreeTransform

    property Raw:pbyte read fRaw;
    property RawLength:integer read fRawLen;
    // preset profiles
    procedure Assign_sRGBProfile;
    procedure Assign_LabProfile(WhitePoint_x, WhitePoint_y, WhitePoint_Y_:double);
    procedure Assign_LabProfileFromTemp(TempK:integer);
    procedure Assign_LabProfileD50;
    procedure Assign_XYZProfile;
    // transform
    procedure FreeTransform;
    function Transform(Destination:TIEICC; InputFormat:integer; OutputFormat:integer; Intent:integer; Flags:integer; InputBuffer:pointer; OutputBuffer:pointer; ImageWidth:integer):boolean;
    function Apply(SourceBitmap:TIEBitmap; SourceFormat:integer; DestinationBitmap:TIEBitmap; DestinationFormat:integer; DestinationProfile:TIEICC; Intent:integer; Flags:integer):boolean;
    function Apply2(Bitmap:TIEBitmap; SourceFormat:integer; DestinationFormat:integer; DestinationProfile:TIEICC; Intent:integer; Flags:integer):boolean;
    function ConvertBitmap(Bitmap:TIEBitmap; DestPixelFormat:TIEPixelFormat; DestProfile:TIEICC):boolean;
    function IsTransforming:boolean;
    // informative

{!!
<FS>TIEICC.Copyright

<FM>Declaration<FC>
property Copyright:AnsiString;

<FM>Description<FN>
Returns Copyright string found inside the ICC profile.
!!}
    property Copyright:AnsiString read fCopyright;

{!!
<FS>TIEICC.Description

<FM>Declaration<FC>
property Description:AnsiString;

<FM>Description<FN>
Returns ICC profile description found inside the ICC profile.
!!}
    property Description:AnsiString read fDescription;

  end;

  {$ifdef IEINCLUDENEURALNET}

  tdoublepdoublearray = array [0..maxint div 8] of pdoublearray;
  pdoublepdoublearray = ^tdoublepdoublearray;

  TLAYER = record
    Units:integer;         // - number of units in this layer
    Output:pdoublearray;        // - output of ith unit
    Error:pdoublearray;         // - error term of ith unit
    Weight:pdoublepdoublearray;        // - connection weights to ith unit
    WeightSave:pdoublepdoublearray;    // - saved weights for stopped training
    dWeight:pdoublepdoublearray;       // - last weight deltas for momentum
  end;
  PTLAYER = ^TLAYER;
  TLAYERARRAY = array [0..maxint div 32] of TLAYER;
  PTLAYERARRAY = ^TLAYERARRAY;

  // multilayer backpropagation neural network
  TIENeurNet = class
    private
      LayersDef:pintegerarray;  // number of units for each layer
      LayersDefCount:integer; // layers count

      Layer:PTLAYERARRAY;         // - layers of this net
      InputLayer:PTLAYER;    // - input layer
      OutputLayer:PTLAYER;   // - output layer
      Alpha:double;         // - momentum factor
      Eta:double;           // - learning rate
      Gain:double;          // - gain of sigmoid function
      Error:double;         // - total net error

      procedure GenerateNetwork;
      procedure RandomWeights;
      procedure PropagateLayer(Lower,Upper:PTLAYER);
      procedure BackpropagateLayer(Upper,Lower:PTLAYER);
      procedure BackpropagateNet;
      procedure AdjustWeights;
    public
      constructor Create(layerUnits:array of integer);
      destructor Destroy; override;
      property Momentum:double read Alpha write Alpha;
      property LearnRate:double read Eta write Eta;
      property SigmoidGain:double read Gain write Gain;
      property NetError:double read Error write Error;

      procedure SetInput(idx:integer; value:double); overload;
      procedure SetInput(fromIdx:integer; Input:pdoublearray); overload;
      procedure SetInput(fromIdx:integer; bitmap:TIEBitmap; colorSpace:integer; srcX,srcY,srcWidth,srcHeight:integer; dstWidth,dstHeight:integer); overload;
      procedure SetInputAsHist(fromIdx:integer; bitmap:TIEBitmap); overload;

      function GetOutput(idx:integer):double; overload;
      procedure GetOutput(Output:pdoublearray); overload;
      procedure GetOutput(Bitmap:TIEBitmap; w,h:integer); overload;

      procedure Run;
      procedure Train(bitmap:TIEBitmap; srcX,srcY,srcWidth,srcHeight:integer; dstWidth,dstHeight:integer; DoTrain:boolean); overload;
      procedure Train(Target:array of double; DoTrain:boolean); overload;

      procedure SaveWeights;
      procedure RestoreWeights;

      procedure SaveToStream(Stream:TStream);
      procedure SaveToFile(const FileName:string);
      procedure LoadFromStream(Stream:TStream);
      procedure LoadFromFile(const FileName:string);

  end;
  {$endif}


  {$ifdef IEUSEBUFFEREDSTREAM}
  TIEBufferedReadStream = class(TStream)
  private
    fStream:TStream;
    fBufferSize:integer;
    fMemory:pbytearray;
    fPosition:int64;
    fPositionBuf:integer;
    fSize:int64;
    fRelativePosition:int64;
    fOverPosition:boolean;
    procedure AllocBufferSize(BufferSize:integer);
    procedure LoadData;
  public
    constructor Create(InputStream:TStream; BufferSize:integer; UseRelativePosition:boolean=true);
    destructor Destroy; override;
    function Read(var Buffer; Count: longint): Longint; override;
    function Write(const Buffer; Count: longint): Longint; override;
    {$ifdef IEOLDSEEKDEF}
    function Seek(Offset: longint; Origin: word): longint; override;
    {$else}
    function Seek(const Offset: int64; Origin: TSeekOrigin): int64; override;
    {$endif}
    property OverPosition:boolean read fOverPosition;
  end;

  TIEBufferedWriteStream = class(TStream)
  private
    fStream:TStream;
    fMemory:pbytearray;
    fBufferSize:integer;
    fBufferPos:integer;
    procedure FlushData;
  public
    constructor Create(InputStream:TStream; BufferSize:integer);
    destructor Destroy; override;
    function Read(var Buffer; Count: longint): Longint; override;
    function Write(const Buffer; Count: longint): Longint; override;
    {$ifdef IEOLDSEEKDEF}
    function Seek(Offset: longint; Origin: word): longint; override;
    {$else}
    function Seek(const Offset: int64; Origin: TSeekOrigin): int64; override;
    {$endif}
  end;

  {$else}

  TIEBufferedReadStream = class(TStream)
  private
    fStream:TStream;
  public
    constructor Create(InputStream:TStream; BufferSize:integer; UseRelativePosition:boolean=true);
    destructor Destroy; override;
    function Read(var Buffer; Count: longint): Longint; override;
    function Write(const Buffer; Count: longint): Longint; override;
    {$ifdef IEOLDSEEKDEF}
    function Seek(Offset: longint; Origin: word): longint; override;
    {$else}
    function Seek(const Offset: int64; Origin: TSeekOrigin): int64; override;
    {$endif}
  end;

  TIEBufferedWriteStream = class(TStream)
  private
    fStream:TStream;
  public
    constructor Create(InputStream:TStream; BufferSize:integer);
    destructor Destroy; override;
    function Read(var Buffer; Count: longint): Longint; override;
    function Write(const Buffer; Count: longint): Longint; override;
    {$ifdef IEOLDSEEKDEF}
    function Seek(Offset: longint; Origin: word): longint; override;
    {$else}
    function Seek(const Offset: int64; Origin: TSeekOrigin): int64; override;
    {$endif}
  end;


  {$endif}



  TIETIFFImage = class(TIEGraphicBase)
  end;
  TIEGIFImage = class(TIEGraphicBase)
  end;
  TIEJpegImage = class(TIEGraphicBase)
  end;
  TIEPCXImage = class(TIEGraphicBase)
  end;
  TIEBMPImage = class(TIEGraphicBase)
  end;
  TIEICOImage = class(TIEGraphicBase)
  end;
{$IFDEF IEINCLUDEPNG}
  TIEPNGImage = class(TIEGraphicBase)
  end;
{$ENDIF}
  TIETGAImage = class(TIEGraphicBase)
  end;
  TIEPXMImage = class(TIEGraphicBase)
  end;
{$IFDEF IEINCLUDEJPEG2000}
  TIEJP2Image = class(TIEGraphicBase)
  end;
  TIEJ2KImage = class(TIEGraphicBase)
  end;
{$ENDIF}
  TIEPSDImage = class(TIEGraphicBase)
  end;

  TIEShadowType = (iestNone, iestSolid, iestSmooth1, iestSmooth2);

  TIEMultiCallBack = procedure(Bitmap: TIEBitmap; var IOParams: TObject) of object;


{$ifdef IEINCLUDEPDFWRITING}

  //////////////////////////////////////////////////////////////////////////////
  // PDF support
  // base class for all objects( direct and indirect )

  // for indirect object:
  // 	ObjectNumber is not included because it always starts at 1
  // 	GenerationNumber is not included because it is always 0
  TIEPDFObject = class
    Index: integer;
    Position: integer; // position inside the start of stream (wrote when we save the objects to the stream)
    DontFree: boolean; // if True the parent doesn't free this object
    constructor Create;
    destructor Destroy; override;
    procedure Write(Stream: TStream); virtual; abstract;
  end;

  // object reference
  TIEPDFRefObject = class(TIEPDFObject)
    ObjectNumber: integer;
    GenerationNumber: integer;
    constructor Create(ObjNumber: integer; GenNumber: integer);
    procedure Write(Stream: TStream); override;
  end;

  // boolean object
  TIEPDFBooleanObject = class(TIEPDFObject)
    Value: boolean;
    constructor Create(vv: boolean);
    procedure Write(Stream: TStream); override;
  end;

  // numeric object
  TIEPDFNumericObject = class(TIEPDFObject)
    Value: double;
    constructor Create(vv: double);
    procedure Write(Stream: TStream); override;
  end;

  // string object
  TIEPDFStringObject = class(TIEPDFObject)
    Value: AnsiString;
    constructor Create(vv: AnsiString);
    procedure Write(Stream: TStream); override;
  end;

  // name object
  TIEPDFNameObject = class(TIEPDFObject)
    Value: AnsiString;
    constructor Create(vv: AnsiString); // do not specify '\'
    procedure Write(Stream: TStream); override;
  end;

  // array object
  TIEPDFArrayObject = class(TIEPDFObject)
    Items: TList;
    constructor Create;
    destructor Destroy; override;
    procedure Write(Stream: TStream); override;
  end;

  // dictionary object
  TIEPDFDictionaryObject = class(TIEPDFObject)
    items: TStringList; // Items[] for key (without '/') and Objects[] for values
    constructor Create;
    destructor Destroy; override;
    procedure Write(Stream: TStream); override;
  end;

  // stream object
  TIEPDFStreamObject = class(TIEPDFObject)
    data: pointer;
    length: integer;
    dict: TIEPDFDictionaryObject;
    constructor Create;
    constructor CreateCopy(copydata: pointer; copylength: integer);
    destructor Destroy; override;
    procedure Write(Stream: TStream); override;
  end;

procedure iepdf_WriteHeader(Stream: TStream);
procedure iepdf_WriteFooter(Stream: TStream; IndirectObjects: TList; info: TIEPDFObject);
procedure iepdf_WriteIndirectObjects(Stream: TStream; IndirectObjects: TList);
function iepdf_AddCatalog(IndirectObjects: TList):TIEPDFDictionaryObject;
function iepdf_AddPageTree(IndirectObjects: TList; pages: TList):TIEPDFDictionaryObject;
procedure iepdf_AddPage(IndirectObjects: TList; pages: TList; Resources: TIEPDFDictionaryObject; MediaBox: TIEPDFArrayObject; Content: integer);
procedure iepdf_AddIndirectObject(IndirectObjects: TList; obj: TIEPDFObject);
procedure iepdf_WriteLn(Stream: TStream; line: AnsiString);
procedure iepdf_Write(Stream: TStream; line: AnsiString);

{$endif}  // IEINCLUDEPDFWRITING

// End of PDF support
//////////////////////////////////////////////////////////////////////////////

{$ifdef IEINCLUDEDICOM}

{!!
<FS>TIEDICOMTag

<FM>Declaration<FC>
}
type TIEDICOMTag = record
  Group:word;
  Element:word;
  DataType:array [0..1] of AnsiChar;
  Data:pointer;
  DataLen:integer;
end;
{!!}

{!!
<FS>PIEDICOMTag

<FM>Declaration<FC>
PIEDICOMTag=^<A TIEDICOMTag>;
!!}
PIEDICOMTag=^TIEDICOMTag;


{!!
<FS>TIEDICOMTags

<FM>Description<FN>

<FM>Methods and Properties<FN>

  <A TIEDICOMTags.AddTag>
  <A TIEDICOMTags.Clear>
  <A TIEDICOMTags.Count>
  <A TIEDICOMTags.DeleteTag>
  <A TIEDICOMTags.GetTag>
  <A TIEDICOMTags.GetTagString>
  <A TIEDICOMTags.IndexOf>

!!}
TIEDICOMTags = class
  private
    fTags:TList;
    function GetCount:integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure SaveToStream(Stream:TStream);
    procedure LoadFromStream(Stream:TStream);
    procedure Assign(Source:TIEDICOMTags);

    function AddTag(Group:word; Element:word; DataType:AnsiString; Data:pointer; DataLen:integer):integer;
    function IndexOf(Group:word; Element:word):integer;
    function GetTag(index:integer):PIEDICOMTag;
    function GetTagString(index:integer):AnsiString;
    procedure DeleteTag(index:integer);
    property Count:integer read GetCount;
end;

{$endif}

type

TIEWideStrings = class
  private
    fStrings:TList;
    function CreateCopyBuffer(const S:WideString):PWideChar;
    function GetCount:integer;
    function GetString(idx:integer):WideString;
    procedure SetString(idx:integer; const S:WideString);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Count:integer read GetCount;
    function Add(const S:WideString):integer;
    property Strings[idx:integer]:WideString read GetString write SetString; default;
end;



TIEDirContent = class
  private
    fFirstGot:boolean;
    fHandle:THandle;
    fFindData:WIN32_FIND_DATAW;
  public
    constructor Create(const dir:WideString);
    destructor Destroy; override;
    function getItem(var filename:WideString; getFiles:boolean = true; getDirs:boolean = false):boolean;
end;



TIEThreadPool = class
  private
    fThreads:TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(Thread:TThread);
    procedure Join;
end;


{$ifdef IEINCLUDERESOURCEEXTRACTOR}

{!!
<FS>TIEResourceBookmark

<FM>Description<FN>


Look at inputoutput/resourceLoader example.



<FM>Methods and properties<FN>

  <A TIEResourceBookmark.TypeIndex>
  <A TIEResourceBookmark.NameIndex>
  <A TIEResourceBookmark.FrameIndex>
!!}
TIEResourceBookmark = class
  private
    m_TypeIndex:integer;
    m_NameIndex:integer;
    m_FrameIndex:integer;

  public


{!!
<FS>TIEResourceBookmark.TypeIndex

<FM>Declaration<FC>
property TypeIndex:integer;

<FM>Description<FN>
Resource type index of this bookmark.
!!}
    property TypeIndex:integer read m_TypeIndex;

{!!
<FS>TIEResourceBookmark.NameIndex

<FM>Declaration<FC>
property NameIndex:integer;

<FM>Description<FN>
Resource name index of this bookmark.
!!}
    property NameIndex:integer read m_NameIndex;

{!!
<FS>TIEResourceBookmark.FrameIndex

<FM>Declaration<FC>
property FrameIndex:integer;

<FM>Description<FN>
Frame index of a grouped resource of this bookmark.
!!}
    property FrameIndex:integer read m_FrameIndex;

    constructor Create(TypeIndex_, NameIndex_, FrameIndex_:integer);
end;


{!!
<FS>TIEResourceExtractor

<FM>Description<FN>

TIEResourceExtractor class helps to extract resources from a PE files like EXE, DLL, OCX, ICL, BPL, etc..
In details, it is intended to extract Icons, Bitmaps, Cursors and other image resources.

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


<FM>Methods and properties<FN>

  <A TIEResourceExtractor.Create>
  <A TIEResourceExtractor.FriendlyTypes>
  <A TIEResourceExtractor.GetBuffer>
  <A TIEResourceExtractor.GetFrameBuffer>
  <A TIEResourceExtractor.GetGroupAndFrame>
  <A TIEResourceExtractor.GetResourceBookmark>
  <A TIEResourceExtractor.GroupCountFrames>
  <A TIEResourceExtractor.GroupFrameDepth>
  <A TIEResourceExtractor.GroupFrameHeight>
  <A TIEResourceExtractor.GroupFrameName>
  <A TIEResourceExtractor.GroupFrameWidth>
  <A TIEResourceExtractor.IndexOfType>
  <A TIEResourceExtractor.IsGroup>
  <A TIEResourceExtractor.IsGrouped>
  <A TIEResourceExtractor.IsValid>
  <A TIEResourceExtractor.Names>
  <A TIEResourceExtractor.NamesCount>
  <A TIEResourceExtractor.TypesCount>
  <A TIEResourceExtractor.Types>

!!}
TIEResourceExtractor = class
  private
    m_hlib:THandle;
    m_typesList:TStringList;
    m_resourceBookmarks:TList;
    function GetTypesCount:integer;
    function GetNamesCount(TypeIndex:integer):integer;
    function GetTypes(TypeIndex:integer):AnsiString;
    function GetNames(TypeIndex:integer; NameIndex:integer):AnsiString;
    function GetFriendlyTypes(TypeIndex:integer):AnsiString;
    function GetIsValid:boolean;
    function GetGroupCountFrames(TypeIndex:integer; NameIndex:integer):integer;
    function GetGroupFrameWidth(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):integer;
    function GetGroupFrameHeight(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):integer;
    function GetGroupFrameDepth(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):integer;
    function GetGroupFrameName(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):AnsiString;
    function GetIsGroup(TypeIndex:integer):boolean;
    function GetIsGrouped(TypeIndex:integer):boolean;
  public
    constructor Create(const Filename:WideString);
    destructor Destroy; override;
    property TypesCount:integer read GetTypesCount;
    property Types[TypeIndex:integer]:AnsiString read GetTypes;
    property FriendlyTypes[TypeIndex:integer]:AnsiString read GetFriendlyTypes;
    property NamesCount[TypeIndex:integer]:integer read GetNamesCount;
    property Names[TypeIndex:integer; NameIndex:integer]:AnsiString read GetNames;
    function GetBuffer(TypeIndex:integer; NameIndex:integer; var BufferLength:integer):pointer; overload;
    function GetBuffer(const TypeStr:AnsiString; const NameStr:AnsiString; var BufferLength:integer):pointer; overload;
    function GetBuffer(ResourceBookmark:TIEResourceBookmark; var BufferLength:integer):pointer; overload;
    property IsValid:boolean read GetIsValid;
    property IsGroup[TypeIndex:integer]:boolean read GetIsGroup;
    property IsGrouped[TypeIndex:integer]:boolean read GetIsGrouped;
    property GroupCountFrames[TypeIndex:integer; NameIndex:integer]:integer read GetGroupCountFrames;  // number of frames for specified icon/cursor
    property GroupFrameWidth[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:integer read GetGroupFrameWidth;
    property GroupFrameHeight[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:integer read GetGroupFrameHeight;
    property GroupFrameDepth[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:integer read GetGroupFrameDepth;
    property GroupFrameName[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:AnsiString read GetGroupFrameName;
    procedure GetGroupAndFrame(TypeIndex:integer; NameIndex:integer; var GroupTypeIndex:integer; var GroupIndex:integer; var GroupFrameIndex:integer);
    function IndexOfType(TypeName:AnsiString):integer;
    function GetFrameBuffer(TypeIndex:integer; NameIndex:integer; FrameIndex:integer; var BufferLength:integer):pointer;
    function GetResourceBookmark(TypeIndex:integer; NameIndex:integer; FrameIndex:integer = -1):TIEResourceBookmark;
end;

{$endif}  // IEINCLUDERESOURCEEXTRACTOR



{$ifdef IERFBPROTOCOL}

{!!
<FS>TIERFBClipboardTextEvent

<FM>Declaration<FC>
TIERFBClipboardTextEvent = procedure(Sender:TObject; Text:AnsiString) of object;

<FM>Description<FN>
Declaration for clipboard messages from RFB server.
!!}
TIERFBClipboardTextEvent = procedure(Sender:TObject; Text:AnsiString) of object;


{!!
<FS>TIERFBUpdateRectEvent

<FM>Declaration<FC>
TIERFBUpdateRectEvent = procedure(Sender:TObject; Rect:TRect) of object;

<FM>Description<FN>
Declaration for update rectangle messages from RFB server.
!!}
TIERFBUpdateRectEvent = procedure(Sender:TObject; Rect:TRect) of object;


{!!
<FS>EIERFBError

<FM>Declaration<FC>
EIERFBError = class(Exception);

<FM>Description<FN>
Generic RFB exception.
!!}
EIERFBError = class(Exception);

TIERFBClient = class;

TIERFBMessageThread = class(TThread)
  private
    m_client:TIERFBClient;
    m_clipboardText:AnsiString;
    m_updatedRect:TRect;
    procedure CopyRawRow(var src:pbyte; dst:pbyte; columns:integer);
    procedure msg_FrameBufferUpdate;
    procedure msg_SetColourMapEntries;
    procedure msg_Bell;
    procedure msg_ServerCutText;
    procedure DoOnUpdate;
    procedure DoOnUpdateNonSync;
    procedure DoOnUpdateRect;
    procedure DoOnBell;
    procedure DoOnClipboardText;
    procedure DoOnUpdateScreenSize;
    procedure UpdateCursorShape;
  public
    constructor Create(Client:TIERFBClient);
    destructor Destroy(); override;
    procedure Execute; override;
end;


{!!
<FS>TIERFBPixelFormat

<FM>Declaration<FC>
TIERFBPixelFormat = (ierfbPalette256, ierfbRGB16, ierfbRGB32);

<FM>Description<FN>
Specifies connection pixel format (this is not the framebuffer pixelformat, which is always 24 bit RGB).

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>ierfbPalette256<FN></C> <C>256 colors palette.</C> </R>
<R> <C><FC>ierfbRGB16<FN></C> <C>RGB packed inside words of 16 bits.</C> </R>
<R> <C><FC>ierfbRGB32<FN></C> <C>RGB, 8 bit per channel. Last byte discarded.</C> </R>
</TABLE>
!!}
TIERFBPixelFormat = (ierfbPalette256, ierfbRGB16, ierfbRGB32);

TIEClientSocket = class
  private
    m_socket:pointer;
    m_littleEndian:boolean;
    function GetConnected:boolean;
  public
    constructor Create;
    destructor Destroy; override;
    // options
    property LittleEndian:boolean read m_littleEndian write m_littleEndian;
    // receive
    procedure ReceiveBuffer(buf:pointer; len:integer);
    procedure ReceivePad(len:integer);
    function ReceiveByte():byte;
    function ReceiveWord():word;
    function ReceiveDWord():dword;
    // send
    procedure SendBuffer(buf:pointer; len:integer);
    procedure SendPad(len:integer);
    procedure SendByte(value:byte);
    procedure SendWord(value:word);
    procedure SendDWord(value:dword);
    // connect/disconnect
    procedure Connect(const Address:string; Port:word);
    procedure Disconnect();
    property Connected:boolean read GetConnected;
end;



{!!
<FS>TIERFBClient

<FM>Description<FN>

TIERFBClient implements a RFB (Remote Frame Buffer) client.
It can connect to any RFB compatible server like RealVNC, TightVNC, VMWare virtual machines or Macintosh remote desktop.

Currently implemented features:
<TABLE>
<R> <H></H> <H></H> </R>
<R> <C><FC>Protocol<FN></C> <C>3.3, 3.7 and 3.8</C> </R>
<R> <C><FC>Authentication<FN></C> <C>No authentication or VNC (DES) authentication</C> </R>
<R> <C><FC>Pixel format<FN></C> <C>8 bit with RGB palette, 16 bit RGB, 32 bit RGB</C> </R>
<R> <C><FC>Client messages<FN></C> <C>SetPixelFormat, SetEncodings, FrameBufferUpdateRequest, KeyEvent, PointerEvent, ClientCutText</C> </R>
<R> <C><FC>Server messages<FN></C> <C>FrameBufferUpdate, SetColorMapEntries, Bell, ServerCutText</C> </R>
<R> <C><FC>Keyboard<FN></C> <C>Limited support (CTRL-?, ALT-? could require more code by application)</C> </R>
<R> <C><FC>Encodings<FN></C> <C>Raw, CopyRect, RRE, Cursor, DesktopSize</C> </R>
<R> <C><FC>Cursor<FN></C> <C>Cursor shape and drawing local handled</C> </R>
</TABLE>

Requires at least Windows 2000.

Keysending doesn't support all key combinations (like CTRL-?, ALT-?, etc...), so applications should handle these combination manually.

See capture\RFB\VNCViewer1 and capture\RFB\VNCViewer2 examples.


<FM>Methods and properties<FN>

  <A TIERFBClient.Create>

  <FI>Connect/disconnect<FN>

  <A TIERFBClient.Connect>
  <A TIERFBClient.Connected>
  <A TIERFBClient.Disconnect>
  <A TIERFBClient.Suspended>

  <FI>Server properties<FN>

  <A TIERFBClient.ScreenName>
  <A TIERFBClient.ScreenPixelFormat>
  <A TIERFBClient.ScreenSize>

  <FI>Commands<FN>

  <A TIERFBClient.SendClipboard>
  <A TIERFBClient.SendKeyEvent>
  <A TIERFBClient.SendPointerEvent>
  <A TIERFBClient.SendRequestUpdate>

  <FI>Framebuffer access (to access frame buffer or cursor)<FN>

  <A TIERFBClient.LockFrameBuffer>
  <A TIERFBClient.UnlockFrameBuffer>

  <FI>Frame buffer and cursor bitmaps<FN>

  <A TIERFBClient.Cursor>
  <A TIERFBClient.FrameBuffer>

  <FI>Events<FN>

  <A TIERFBClient.OnBell>
  <A TIERFBClient.OnClipboardText>
  <A TIERFBClient.OnCursorShapeUpdated>
  <A TIERFBClient.OnUpdate>
  <A TIERFBClient.OnUpdateRect>
  <A TIERFBClient.OnUpdateScreenSize>
!!}
TIERFBClient = class
  private
    m_socket:TIEClientSocket;
    m_frameBufferSize:TSize;
    m_bitsPerPixel:byte;
    m_depth:byte;
    m_bigEndianFlag:byte;
    m_trueColorFlag:byte;
    m_redMax:word;
    m_greenMax:word;
    m_blueMax:word;
    m_redShift:byte;
    m_greenShift:byte;
    m_blueShift:byte;
    m_name:AnsiString;
    m_frameBuffer:TIEBitmap;
    m_freeFrameBuffer:boolean;
    m_OnUpdateRect:TIERFBUpdateRectEvent;
    m_OnUpdate:TNotifyEvent;
    m_OnUpdateNonSync:TNotifyEvent;
    m_OnBell:TNotifyEvent;
    m_OnClipboardText:TIERFBClipboardTextEvent;
    m_OnCursorShapeUpdated:TNotifyEvent;
    m_OnUpdateScreenSize:TNotifyEvent;
    m_msgThread:TIERFBMessageThread;
    m_colorMap:array of TRGB48;
    m_pixelFormat:TIERFBPixelFormat;
    m_cursor:TIEBitmap;
    m_cursorPos:TPoint;
    m_cursorHotSpot:TPoint;
    m_savedCursorArea:TIEBitmap;
    m_savedCursorPos:TPoint;
    m_frameBufferLock:TRTLCriticalSection;
    m_socketSendLock:TRTLCriticalSection;
    m_suspended:boolean;  // bypass framebuffer updates
    procedure SendSetPixelFormat(pixelFormat:TIERFBPixelFormat);  // call it only inside "Connect", otherwise we con't know if a msg_FrameBufferUpdate message has the new pixel format
    function GetConnected:boolean;
    procedure PaintCursor;
    procedure RemoveCursor;
    procedure SetSuspended(value:boolean);

  public
    constructor Create(FrameBuffer:TIEBitmap = nil);
    destructor Destroy; override;

    // connect/disconnect
    procedure Connect(const Address:string; Port:word = 5900; const Password:AnsiString = '');
    procedure Disconnect();

{!!
<FS>TIERFBClient.Connected

<FM>Declaration<FC>
property Connected:boolean;

<FM>Description<FN>
Returns <FC>true<FN> when connection is active.

See also:
<A TIERFBClient.Connect>
<A TIERFBClient.Disconnect>
!!}
    property Connected:boolean read GetConnected;

{!!
<FS>TIERFBClient.Suspended

<FM>Declaration<FC>
property Suspended:boolean;

<FM>Description<FN>
Setting this property you can suspend frame buffer updates.
This is useful when applications need to do some processing on the framebuffer (like save it).
When suspended TIERFBClient continues to receive messages and updates from the server, but they do not update the frame buffer.
Events like <A TIERFBClient.OnUpdate> and <A TIERFBClient.OnUpdateRect> are disabled when connection is in suspended state.

<FM>Example<FC>
rfb.Suspended := true;
try
  ImageEnView.IO.SaveToFile('curentframe.jpg');
finally
  rfb.Suspended := false;
end;
!!}
    property Suspended:boolean read m_suspended write SetSuspended;

    // server properties

{!!
<FS>TIERFBClient.ScreenSize

<FM>Declaration<FC>
property ScreenSize:TSize;

<FM>Description<FN>
Returns the server screen size (width and height in pixels). This may change after <A TIERFBClient.OnUpdateScreenSize> event.
!!}
    property ScreenSize:TSize read m_frameBufferSize;

{!!
<FS>TIERFBClient.ScreenName

<FM>Declaration<FC>
property ScreenName:AnsiString;

<FM>Description<FN>
Returns the server screen name.
!!}
    property ScreenName:AnsiString read m_name;

{!!
<FS>TIERFBClient.ScreenPixelFormat

<FM>Declaration<FC>
property ScreenPixelFormat:<A TIERFBPixelFormat>;

<FM>Description<FN>
Specifies connection pixel format (this is not the framebuffer pixelformat, which is always 24 bit RGB).
Applications must set this property before start the connection.
Default is ierfbRGB32.

<FM>Example<FC>
with TIERFBClient.Create do
begin
  rfb.ScreenPixelFormat := ierfbPalette256;
  rfb.Connect('A_VNC_Server');
  ...
end;
!!}
    property ScreenPixelFormat:TIERFBPixelFormat read m_pixelFormat write m_pixelFormat default ierfbRGB32;

    // commands
    procedure SendRequestUpdate(x, y, width, height:word; incremental:boolean); overload;
    procedure SendRequestUpdate(incremental:boolean = true); overload;
    procedure SendPointerEvent(x, y:integer; LeftButton:boolean; MiddleButton:boolean; RightButton:boolean);
    procedure SendKeyEvent(xkey:dword; down:boolean); overload;
    procedure SendKeyEvent(VirtualKey:dword; KeyData:dword; down:boolean); overload;
    procedure SendClipboard(const Text:AnsiString);

    // framebuffer access (to access frame buffer or cursor)
    procedure LockFrameBuffer;
    procedure UnlockFrameBuffer;

    // frame buffer and cursor bitmaps

{!!
<FS>TIERFBClient.FrameBuffer

<FM>Declaration<FC>
property FrameBuffer:<A TIEBitmap>;

<FM>Description<FN>
Contains the bitmap where TIERFBClient will paint server screen.
This bitmap could be external (for instance a TImageEnView.IEBitmap) or internal (created and owned by TIERFBClient object).

See also:
<A TIERFBClient.Connect>
<A TIERFBClient.LockFrameBuffer>
<A TIERFBClient.UnlockFrameBuffer>
<A TIERFBClient.Suspended>
!!}
    property FrameBuffer:TIEBitmap read m_frameBuffer;

{!!
<FS>TIERFBClient.Cursor

<FM>Declaration<FC>
property Cursor:<A TIEBitmap>;

<FM>Description<FN>
Contains last cursor shape sent by the server.

See also:
<A TIERFBClient.LockFrameBuffer>
<A TIERFBClient.UnlockFrameBuffer>
!!}
    property Cursor:TIEBitmap read m_cursor;

    // events

{!!
<FS>TIERFBClient.OnUpdateRect

<FM>Declaration<FC>
property OnUpdateRect:<A TIERFBUpdateRectEvent>;

<FM>Description<FN>
OnUpdateRect occurs whenever server updates a single frame buffer rectangle.
Because multiple rectangle updates can be sent in a single message so <A TIERFBClient.OnUpdate> is also sent after a sequence of OnUpdateRect messages.
!!}
    property OnUpdateRect:TIERFBUpdateRectEvent read m_OnUpdateRect write m_OnUpdateRect;

{!!
<FS>TIERFBClient.OnUpdate

<FM>Declaration<FC>
property OnUpdate:TNotifyEvent;

<FM>Description<FN>
OnUpdate occurs after a sequence of rectangles has been updated (see <A TIERFBClient.OnUpdateRect>.

<FM>Example<FC>

// this is the common way to handle OnUpdate events using ImageEnView1.IEBitmap has framebuffer
procedure TForm.OnRFBUpdate(Sender:TObject);
begin
  ImageEnView1.Update;
end;

// this is the common way to handle OnUpdate events using TIERFBClient owned frame buffer
procedure TForm.OnRFBUpdate(Sender:TObject);
begin
  rfb.LockFrameBuffer;
  ImageEnView1.IEBitmap.Assign( rfb.FrameBuffer );
  rfb.UnlockFrameBuffer;
  ImageEnView1.Update;
end;
!!}
    property OnUpdate:TNotifyEvent read m_OnUpdate write m_OnUpdate;

    property OnUpdateNonSync:TNotifyEvent read m_OnUpdateNonSync write m_OnUpdateNonSync;

{!!
<FS>TIERFBClient.OnBell

<FM>Declaration<FC>
property OnBell:TNotifyEvent;

<FM>Description<FN>
This event occurs whenever server sends "bell" message.
!!}
    property OnBell:TNotifyEvent read m_OnBell write m_OnBell;

{!!
<FS>TIERFBClient.OnClipboardText

<FM>Declaration<FC>
property OnClipboardText:<A TIERFBClipboardTextEvent>;

<FM>Description<FN>
This event occurs whenever server sends clipboard text (user on the server Copies or Cuts some text).
!!}
    property OnClipboardText:TIERFBClipboardTextEvent read m_OnClipboardText write m_OnClipboardText;

{!!
<FS>TIERFBClient.OnCursorShapeUpdated

<FM>Declaration<FC>
property OnCursorShapeUpdated:TNotifyEvent;

<FM>Description<FN>
OnCursorShapeUpdates occurs whenever the cursor shape (<A TIERFBClient.Cursor>) is updated.
Cursor is painted automatically, so you don't need to handle this event or to read Cursor bitmap.
!!}
    property OnCursorShapeUpdated:TNotifyEvent read m_OnCursorShapeUpdated write m_OnCursorShapeUpdated;

{!!
<FS>TIERFBClient.OnUpdateScreenSize

<FM>Declaration<FC>
property OnUpdateScreenSize:TNotifyEvent;

<FM>Description<FN>
OnUpdateScreenSize occurs whenever server changes desktop size. The framebuffer will be automatically resized.
!!}
    property OnUpdateScreenSize:TNotifyEvent read m_OnUpdateScreenSize write m_OnUpdateScreenSize;

end;


TIE3DESMode = (ie3desENCRYPT, ie3desDECRYPT);

TIE3DES = class
  private
    KnL:array [0..31] of dword;
    KnR:array [0..31] of dword;
    Kn3:array [0..31] of dword;
    procedure scrunch(outof:pbyte; into:pdword);
    procedure unscrun(outof:pdword; into:pbyte);
    procedure desfunc(block:pdwordarray; keys:pdword);
    procedure cookey(raw1:pdword);
    procedure usekey(from:pdword);
    procedure deskey(key:pbytearray; edf:TIE3DESMode);
    procedure des(inblock:pbyte; outblock:pbyte);

  public
    constructor Create(const Password:AnsiString; Mode:TIE3DESMode);
    destructor Destroy; override;

    procedure transform(InBlock:pbyte; OutBlock:pbyte; Length:integer);
end;

{$endif}


//////////////////////////////////////////////////////////////////////////////
// functions
procedure IEInitializeImageEn;
procedure IEFinalizeImageEn;
procedure IEInitialize_hyieutils;
procedure IEFinalize_hyieutils;
function _GetBitCount(b: Integer): Integer;
function _NColToBitsPixel(NCol: integer): integer;
function IEBitmapRowLen(Width: integer; BitCount: integer; align: integer): integer;
function _PixelFormat2RowLen(Width: integer; PixelFormat: TPixelFormat): integer;
function _Pixelformat2BitCount(PixelFormat: TPixelFormat): integer;
function _Bitcount2Pixelformat(Bitcount: integer): TPixelFormat;
function IEVCLPixelFormat2ImageEnPixelFormat(PixelFormat:TPixelFormat):TIEPixelFormat;
procedure ReverseBits(var inp: dword); assembler;
procedure ReverseBitsB(var inp: byte);
procedure _CastPolySelCC(const x1, y1: integer; var x2, y2: integer);
function _RectXRect(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2: integer): boolean;
function _RectPRect(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2: integer): integer;
function _InRect(xx, yy, x1, y1, x2, y2: integer): boolean;
function _InRectO(xx, yy, x1, y1, x2, y2: integer): boolean;
function IEGetFileSize(const FileName: string): integer;
procedure SaveStringToStream(Stream: TStream; const ss: AnsiString);
procedure LoadStringFromStream(Stream: TStream; var ss: AnsiString);
procedure SaveStringToStreamW(Stream: TStream; const ss: widestring);
procedure LoadStringFromStreamW(Stream: TStream; var ss: widestring);
procedure SaveStringListToStream(Stream: TStream; sl: TStringList);
procedure LoadStringListFromStream(Stream: TStream; sl: TStringList);
function _GetNumCol(BitsPerSample: integer; SamplesPerPixel: integer): integer;
function iemsg(const msg: TMsgLanguageWords; const lang: TMsgLanguage): WideString;

procedure IESetTranslationWord(const lang: TMsgLanguage; const msg: TMsgLanguageWords; const trans: AnsiString);
{$ifdef UNICODE}
procedure IESetTranslationWordU(const lang: TMsgLanguage; const msg: TMsgLanguageWords; const trans: string);
{$endif}

function IEFloor(X: Extended): Integer;
function _DistPoint2Line(xp, yp, x1, y1, x2, y2: integer): double;
function _DistPoint2Seg(xp, yp, x1, y1, x2, y2: integer): double;
function _DistPoint2Point(x1, y1, x2, y2: integer): double;
function _DistPoint2Polyline(x, y: integer; PolyPoints: PPointArray; PolyPointsCount: integer; ToSubX, ToSubY, ToAddX, ToAddY: integer; ToMulX, ToMulY: double; penWidth:integer; closed:boolean): double;
function IEDistPoint2Ellipse(x, y, x1, y1, x2, y2: integer; filled:boolean; penWidth:integer): double;
function IEDist2Box(x,y, x1,y1,x2,y2:integer; filled:boolean; penWidth:integer):double;
function IEMMXSupported: bytebool;
//procedure IEMul64(op1, op2: dword; resultlo: pdword; resulthi: pdword);
//function IEAdd64(op1_lo, op1_hi, op2_lo, op2_hi: dword; result_lo, result_hi: pdword): integer;
//function IEGreater64(op1_lo, op1_hi, op2_lo, op2_hi: dword): boolean;
procedure SafeStreamWrite(Stream: TStream; var Aborting: boolean; const Buffer; Count: Longint);
procedure IEBitmapMapXCopy(map: pbyte; maprowlen: dword; mapbitcount: dword; bitmap: TBitmap; mapx, mapy, bitmapx, bitmapy, dx, dy: dword; dir: integer);
function IEPower(Base, Exponent: Extended): Extended;
function IEPower2(const Base, Exponent: Double): Double;
function IESwapWord(i: word): word;
procedure IESwapWordRow(wordBuffer:pword; count:integer);
function IESwapDWord(i: integer): integer;
procedure IERightShadow(Canvas: TCanvas; DestBitmap:TBitmap; x1, y1, x2, y2: integer; st: TIEShadowType; dstColor:TColor);
procedure IEBottomShadow(Canvas: TCanvas; DestBitmap:TBitmap; x1, y1, x2, y2: integer; st: TIEShadowType; dstColor:TColor);
procedure IERectShadow(Bitmap:TBitmap; x1,y1,x2,y2:integer; dstColor:TColor);
function IEFloatToStrA(Value:Extended):AnsiString;
function IEFloatToStrW(Value:Extended):WideString;
function IEFloatToStrS(Value:Extended):string;
function IEFindHandle(cmp: TComponent): integer;
procedure DrawDibDrawEmu(hdd: THandle; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt);
procedure DrawDib(hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer);
function IEDrawDibClose(hdd: hDrawDib): Boolean;
function IEDrawDibDraw(hdd: hDrawDib; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt): Boolean;
function IEDrawDibOpen: hDrawDib;
function IEDrawDibRealize(hdd: hDrawDib; hDC: THandle; fBackground: Bool): UInt;
procedure IECenterWindow(Wnd: HWnd);
procedure IEResetPrinter;
function IEStrToFloatDefA(s: AnsiString; Def: extended): extended;
function IEStrToFloatDefW(s: WideString; Def: extended): extended;
function IEStrToFloatDefS(s: String; Def: extended): extended;
function IEStrToFloatDef(s: String; Def: extended): extended;
function IERGB2CIELAB(rgb: TRGB): TCIELAB;
function IECIELAB2RGB(const lab: TCIELAB): TRGB;
procedure IEDraw3DRect(Canvas: TCanvas; x1, y1, x2, y2: integer; cl1, cl2: TColor);
procedure IEDraw3DRect2(Canvas: TObject; x1, y1, x2, y2: integer; cl1, cl2: TColor);
procedure IEDrawHint(Canvas: TCanvas; var x, y: integer; const ss: string; Font: TFont; Brush: TBrush; var SaveBitmap: TBitmap; MaxWidth, MaxHeight: integer; Border1, Border2: TColor);
procedure IEDrawHint2(Canvas: TCanvas; var x, y: integer; const ss: string; const minText:string);
function IEDirectoryExists(const Name: string): Boolean;
procedure IEForceDirectories(Dir: string);
function IEGetMemory(freememory:boolean): int64;
procedure IESetplim(var plim: trect; x, y: integer);
function IEAngle(x1, y1, x2, y2, x3, y3: integer): double;
function IEAngle2(x1, y1, x2, y2: integer): double;
function IEAngle3(x1, y1, xc, yc, x2, y2: integer): double;
function IEArcCos(X: Extended): Extended;
function IEExtractStylesFromLogFont(logfont: PLogFontA): TFontStyles;
procedure IESetGrayPalette(Bitmap:TBitmap);
function IEIsGrayPalette(Bitmap:TBitmap):boolean;
procedure IECopyTBitmapPaletteToTIEBitmap(source:TBitmap; dest:TIEBitmap);
function IEConvertGUIDToString(g: PGUID): AnsiString;
function CompareGUID(const g1,g2:TGuid):boolean;
procedure IEConvertAStringToGUID(invar: AnsiString; gg: PGUID);
procedure IEConvertWStringToGUID(invar: WideString; gg: PGUID);
procedure IEFitResample(owidth, oheight, fwidth, fheight: integer; var rwidth, rheight: integer);
function IEIsRemoteSession : boolean;
procedure IEBezier2D4Controls(p0:TPoint; c0:TPoint; c1:TPoint; p1:TPoint; pResultArray:PPointArray; nSteps:integer);

procedure IERotatePoints(var rpt:array of TPoint; angle:double; CenterX,CenterY:integer);
procedure IERotatePoint(var px,py:integer; angle:double; CenterX,CenterY:integer);

function IEISPointInPoly(x,y:integer; poly:array of TPoint):boolean;
function IEISPointInPoly2(x, y: integer; PolyPoints: PPointArray; PolyPointsCount: integer; ToSubX, ToSubY, ToAddX, ToAddY: integer; ToMulX, ToMulY:double):boolean;

function IEASCII85EncodeBlock(var inbytes: pbyte; buflen: integer; var outstr: PAnsiChar; var asciilen: integer): integer;
function IEASCII85DecodeBlock(var instr: PAnsiChar; buflen: integer; var outbytes: pbyte): integer;
function IEPSRunLengthEncode(inbytes: pbytearray; inlen: integer; outbytes: pbytearray): integer;
procedure IEWriteStrLn(s: TStream; ss: AnsiString);
function IECopyFrom(Dest:TStream; Source:TStream; Count:int64):int64;

function IEWStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;

function IEGetDecimalSeparator:Char;
procedure IESetDecimalSeparator(c:Char);

procedure IEBlend(var src:TRGB; var dst:TRGB; RenderOperation:TIERenderOperation; row:integer);
procedure IEBlendRGBA(var src:TRGBA; var dst:TRGBA; RenderOperation:TIERenderOperation; row:integer);

// EXIF SUPPORT FUNCTIONS
function LoadEXIFFromStandardBuffer(Buffer: pointer; BufferLength: integer; params: TObject): boolean;
procedure SaveEXIFToStandardBuffer(params: TObject; var Buffer: pointer; var BufferLength: integer; savePreamble:boolean);
function IESearchEXIFInfo(Stream:TStream):int64;
function IELoadEXIFFromTIFF(Stream:TStream; params: TObject): boolean; overload;
function IELoadEXIFFromTIFF(Stream:TStream; params: TObject; page:integer): boolean; overload;
procedure IEAdjustEXIFOrientation(Bitmap:TIEBitmap; Orientation:integer);
function CheckEXIFFromStandardBuffer(Buffer:pointer; BufferLength:integer):boolean;

// XMP support functions
function IELoadXMPFromJpegTag(Buffer:pointer; BufferLength:integer; params:TObject):boolean;
procedure IESaveXMPToJpegTag(params:TObject; var Buffer:pointer; var BufferLength:integer);
function IEFindXMPFromJpegTag(Buffer:pointer; BufferLength:integer):pbyte;

function IEOpenClipboard:boolean;

procedure IEDrawGrayedOut(Canvas:TCanvas; XDst, YDst, WidthDst, HeightDst:integer; SX1, SY1, SX2, SY2:integer);

{!!
<FS>IEGetCoresCount

<FM>Declaration<FC>
function IEGetCoresCount():integer;

<FM>Description<FN>
Returns the total amount of processor's cores present on the system.

Some Windows operating system versions cannot communicate this information, so it is defaulted to <A iegDefaultCoresCount> public field.
!!}
function IEGetCoresCount():integer;


{!!
<FS>IERegisterFormats

<FM>Declaration<FC>
procedure IERegisterFormats;

<FM>Description<FN>
Register/unregister following classes inside the VCL class framework. This allows use of standard VCL open/save dialogs and TPicture objects with ImageEn file formats.

TIETiffImage, TIEGifImage, TIEJpegImage, TIEPCXImage, TIEBMPImage, TIEICOImage, TIEPNGImage, TIETGAImage, TIEPXMImage, TIEJP2Image, TIEJ2Kimage

Each of above classes inherits from TIEGraphicBase. To get input/ouput parameters use “IO” property: it is the same of ImageEnIO.Params property.
!!}
procedure IERegisterFormats;

{!!
<FS>IEUnregisterFormats

<FM>Declaration<FC>
procedure IEUnregisterFormats;

<FM>Description<FN>
Unregisters ImageEn file formats from VCL.
!!}
procedure IEUnregisterFormats;

procedure IEencode64( infile:TStream; var outfile:textfile; linesize:integer );

function IESetScrollRange(hWnd: HWND; nBar, nMinPos, nMaxPos: Integer; bRedraw: BOOL; flat:boolean): BOOL;
procedure IESetSBPageSize(HScrollBar: THandle; fnBar: integer; PageSize: Integer; Redraw: boolean; flat:boolean);
function IESetScrollPos(hWnd: HWND; nBar, nPos: Integer; bRedraw: BOOL; flat:boolean): Integer;
function IEEnableScrollBar(hWnd: HWND; wSBflags, wArrows: UINT; flat:boolean): BOOL;
function IEShowScrollBar(hWnd: HWND; wBar: Integer; bShow: BOOL; flat:boolean): BOOL;
function IESetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL; flat:boolean): Integer;
procedure IESetScrollBar(hWnd:HWND; nBar:integer; nMinPos:integer; nMaxPos:integer; PageSize:integer; nPos:integer; bRedraw:boolean; flat:boolean);

// IIF functions
function IEIFI(cond:boolean; val1,val2:integer):integer;
function IEIFD(cond:boolean; val1,val2:double):double;

function IECSwapWord(i: word; sc: boolean): word;
function IECSwapDWord(i: integer; sc: boolean): integer;

function IERemoveCtrlCharsA(const text:AnsiString):AnsiString;
function IERemoveCtrlCharsW(const text:WideString):WideString;
function IERemoveCtrlCharsS(const text:String):String;
function IERGB2StrS(c:TRGB):string;
function IERGB2StrW(c:TRGB):WideString;
function IEBool2StrS(v:boolean):string;
function IEBool2StrW(v:boolean):WideString;
function IEStr2RGBS(const rgbstr:string):TRGB;
function IEStr2RGBW(const rgbstr:WideString):TRGB;
function IEStr2BoolS(const v:string):boolean;
function IEStr2BoolW(const v:WideString):boolean;

procedure IEQuickSort(ItemsCount:integer; CompareFunction:TIECompareFunction; SwapFunction:TIESwapFunction);

function IEGetTempFileName(const Descriptor:string; const Directory:string):string;
function IEGetTempFileName2:string;

procedure IERGB2YCbCr(rgb:TRGB; var Y,Cb,Cr:integer);
procedure IEYCbCr2RGB(var rgb:TRGB; Y,Cb,Cr:integer);

{$ifndef IEHASFREEANDNIL}
procedure FreeAndNil(var Obj);
{$endif}

function IESystemAlloc(ASize: dword): pointer;
procedure IESystemFree(var P);
function IEAutoAlloc(ASize:dword):pointer;
procedure IEAutoFree(var P);

procedure IESilentGetMem(var P; Size: Integer);

procedure IECreateOSXBackgroundPaper(bmp:TBitmap; width,height:integer);
procedure IECreateOSXBackgroundMetal(bmp:TBitmap; width,height:integer);

// clipboard helpers
function IEEnumClipboardNames:TStringList;
function IEGetClipboardDataByName(const name:string):THandle;

// alpha/opacity
function IEAlphaToOpacity(Alpha:integer ):integer;
function IEOpacityToAlpha(Opacity:integer):integer;

function IEIsLeftMouseButtonPressed:boolean;

function IERGBToStr(rgb:TRGB):AnsiString;

function IEExtractFileExtS(const FileName:String; includeDot:boolean=true):String;
function IEExtractFileExtW(const FileName:WideString; includeDot:boolean=true):WideString;
function IEExtractFileExtA(const FileName:AnsiString; includeDot:boolean=true):AnsiString;
function IETrim(const v:AnsiString):AnsiString;
function IEUpperCase(const v:AnsiString):AnsiString;
function IELowerCase(const v:AnsiString):AnsiString;
function IEIntToStr(v:integer):AnsiString;
function IEStrToIntDef(const s:AnsiString; def:integer):integer;
function IECopy(S:AnsiString; Index, Count: Integer): AnsiString;
function IEFloatToStrFA(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): AnsiString;
function IEFloatToStrFS(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): string;
function IEIntToHex(Value: Integer; Digits: Integer): AnsiString;
function IEPos(Substr: AnsiString; S: AnsiString): Integer;
function IEStrDup(s: PAnsiChar): PAnsiChar;
function IEExtractFilePathA(const FileName: AnsiString): AnsiString;
function IEExtractFilePathW(const FileName: WideString): WideString;
function IEExtractFileNameW(const FileName: WideString): WideString;

function IEFileExists(const FileName: string): Boolean;
function IEFileExistsW(const FileName: WideString): Boolean;
procedure IEDecimalToFraction(value:double; var numerator:integer; var denominator:integer; accuracy:double = 0.000000005);

procedure IECopyTList(source:TList; dest:TList);

function IETextWidthW(Canvas:TCanvas; const Text:WideString):integer;
function IETextHeightW(Canvas:TCanvas; const Text:WideString):integer;

type
TIEURLType = (ieurlUNKNOWN, ieurlHTTP, ieurlHTTPS, ieurlFTP);

function IEGetURLTypeA(const URL:AnsiString):TIEURLType;
function IEGetURLTypeW(const URL:WideString):TIEURLType;

const
  iebitmask1: array[0..7] of byte = ($80, $40, $20, $10, $08, $04, $02, $01); // $80 shr index

var

{!!
<FS>IEDefDialogCenter

<FM>Declaration<FC>
IEDefDialogCenter: <A TIEDialogCenter>;

<FM>Description<FN>
Specify a function called when open/save dialogs needs to be centered.
!!}
  IEDefDialogCenter: TIEDialogCenter;

{!!
<FS>IEDefMinFileSize

<FM>Declaration<FC>
IEDefMinFileSize: int64;

<FM>Description<FN>
Specifies the default value for <A TIEBitmap.MinFileSize> property.
<A TIEBitmap.MinFileSize> specifies the minimum memory needed by the image to allow use of memory mapped file.
If the memory needed by the image is less than MinFileSize, the image will be stored in memory (also if the Location is ieFile). If the global variable IEDefMinFileSize is not -1, it overlaps the property MinFileSize value.
!!}
  IEDefMinFileSize: int64;

{!!
<FS>iegAutoLocateOnDisk

<FM>Declaration<FC>
iegAutoLocateOnDisk:boolean;

<FM>Description<FN>
If true (default) TIEBitmap will allocate the image on disk if it fails to allocate on memory.
!!}
  iegAutoLocateOnDisk:boolean;

{!!
<FS>iegAutoFragmentBitmap

<FM>Declaration<FC>
iegAutoFragmentBitmap:boolean;

<FM>Description<FN>
If true (default) TIEBitmap will try to allocate chunks of memory instead of a single buffer to contain the image.
This is useful when memory is fragmented.
!!}
  iegAutoFragmentBitmap:boolean;

{!!
<FS>iegDefaultCoresCount

<FM>Declaration<FC>
iegDefaultCoresCount:integer;

<FM>Description<FN>
Specifies the totale amount of processor's cores to use.
-1 (default) means to get this value from operating system.

See also <A IEGetCoresCount>.
!!}
  iegDefaultCoresCount:integer;


{!!
<FS>iegOpSys

<FM>Declaration<FC>
iegOpSys:<A TIEOpSys>;

<FM>Description<FN>
Contains the detected operating system.
!!}
  iegOpSys:TIEOpSys;

  iegUnicodeOS:boolean; // true = Unicode operating system, false = non unicode (ie Win98/WinME)


implementation

uses ImageEnView, ImageEnProc, ImageEnIO, ieview, neurquant, tiffilt, ievect, printers, ielcms, iegdiplus
     ,iej2000, tifccitt, ietextc, iewia, iewic, iepresetim, iezlib
  {$ifdef IEINCLUDEFLATSB}
  ,flatsb
  {$endif}
;

{$R-}

// DRAWDIB LIBRARY
const
  DLL = 'MsVfW32.dll';

function DrawDibClose(hdd: hDrawDib): Boolean; stdcall; external DLL name 'DrawDibClose';

function DrawDibDraw(hdd: hDrawDib; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt): Boolean; stdcall; external DLL name 'DrawDibDraw';

function DrawDibOpen: hDrawDib; stdcall; external DLL name 'DrawDibOpen';

function DrawDibRealize(hdd: hDrawDib; hDC: THandle; fBackground: Bool): UInt; stdcall; external DLL name 'DrawDibRealize';



const
  A90 = PI / 2;


var
  IECosineTab: array[0..255] of integer;

  iegAnnotCreationScale:integer = 7500;


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// generic inline functions. Must be not moved out of this unit

function GetPixelbw_inline(row: pbyte; pix: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
begin
  result := pbytearray(row)^[pix shr 3] and iebitmask1[pix and $7];
end;

procedure SetPixelbw_inline(row: pbyte; pix: integer; vv: integer); {$ifdef IESUPPORTINLINE} inline; {$endif}
var
  bp: pbyte;
begin
  bp := pbyte(int64(DWORD(row)) + (int64(pix) shr 3));
  if vv <> 0 then
    bp^ := bp^ or iebitmask1[pix and 7]
  else
    bp^ := bp^ and not iebitmask1[pix and 7];
end;



/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// THash1
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

// sbits: hash table size in bit.
constructor THash1.Create(Hbits: integer);
begin
  inherited Create;
  fHbits := Hbits;
  fHdim := 1 shl fHbits;
  fMainKeys := TList.Create;
  fMainKeys.Count := fHdim;
  fMainKeysUse := TList.Create;
  fMainKeysUse.Count := fHdim;
  fMainKeysValue := TList.Create;
  fMainKeysValue.Count := fHdim;
  nkeys := 0;
end;

destructor THash1.Destroy;
var
  q: integer;
  p1, p2: THash1Item;
begin
  for q := 0 to fHdim - 1 do
    case integer(fMainKeysUse[q]) of
      2: // free concurrences
        begin
          p1 := Thash1Item(fMainKeys[q]);
          repeat
            p2 := p1.nextitem;
            FreeAndNil(p1);
            p1 := p2; // free next item
          until p1 = nil;
        end;
    end;
  FreeAndNil(fMainKeys);
  FreeAndNil(fMainKeysUse);
  FreeAndNil(fMainKeysValue);
  inherited;
end;

// hash function
// uses first fHbits-1 as direct index
function THash1.HashFunc(kk: integer): integer;
begin
  result := kk and (fHdim - 1);
end;

// insert a new key (kk) only if it already present
// ret TRUE if key inserted
function THash1.Insert2(kk: integer; var ptr1: integer; var ptr2: Thash1Item): boolean;
var
  ix: integer;
  p1, p2: THash1Item;
begin
  ptr2 := nil;
  result := false;
  ix := HashFunc(kk);
  ptr1 := ix;
  case integer(fMainKeysUse[ix]) of
    0: // free position
      begin
        fMainKeysUse[ix] := TObject(1);
        fMainKeys[ix] := TObject(kk);
      end;
    1: // position busy, verify if this already exists
      begin
        if integer(fMainKeys[ix]) = kk then
          exit; // key already inserted
        // create a list of keys
        p1 := THash1Item.Create;
        p1.key := kk;
        p1.nextitem := nil;
        ptr2 := p1;
        //
        p2 := THash1Item.Create;
        p2.key := integer(fMainKeys[ix]);
        p2.nextitem := p1;
        p2.value := integer(fMainKeysValue[ix]);
        //
        fMainKeys[ix] := p2;
        fMainKeysUse[ix] := TObject(2);
        // from here fMainKeyValue[ix] is no longer valid
      end;
    2: // position busy, with more one key, verify also if already present
      begin
        // search for last key or if already present
        p1 := Thash1Item(fMainKeys[ix]);
        while true do
        begin
          if p1.key = kk then
            exit; // key already inserted
          if p1.nextitem = nil then
            break; // found last item
          p1 := p1.nextitem;
        end;
        // now p1 point to the last item, create a new one
        p2 := THash1Item.Create;
        p2.key := kk;
        p2.nextitem := nil;
        ptr2 := p2;
        p1.nextitem := p2; // append item just created
      end;
  end;
  inc(nkeys);
  result := true;
end;

// insert a new key (kk) only if it already present
// ret TRUE if key inserted
function THash1.Insert(kk: integer): boolean;
var
  ptr1: integer;
  ptr2: Thash1Item;
begin
  result := Insert2(kk, ptr1, ptr2);
end;

// verify if key kk exists
function THash1.KeyPresent(kk: integer): boolean;
var
  ix: integer;
  p1: THash1Item;
begin
  result := false;
  ix := HashFunc(kk);
  case integer(fMainKeysUse[ix]) of
    1: // position busy, check if it exists
      begin
        if integer(fMainKeys[ix]) = kk then
          result := true;
      end;
    2: // position busy, with more than one ket, check if it exists
      begin
        // find last key or if it already exists
        p1 := Thash1Item(fMainKeys[ix]);
        while true do
        begin
          if p1.key = kk then
          begin
            result := true; // actual key
            break;
          end;
          if p1.nextitem = nil then
            break; // find last item
          p1 := p1.nextitem;
        end;
      end;
  end;
end;

procedure THash1.SetValue(ptr1: integer; ptr2: Thash1Item; Value: integer);
begin
  if ptr2 <> nil then
    ptr2.value := Value
  else
    fMainKeysValue[ptr1] := TObject(Value);
end;

function THash1.GetValue(ptr1: integer; ptr2: Thash1Item): integer;
begin
  if ptr2 <> nil then
    result := ptr2.Value
  else
    result := integer(fMainKeysValue[ptr1]);
end;

function THash1.IterateBegin: boolean;
begin
  fIterateptr1 := -1;
  fIterateptr2 := nil;
  result := IterateNext;
end;

function THash1.IterateNext: boolean;
begin
  result := false;
  if fIterateptr2 = nil then
  begin
    inc(fIterateptr1);
    while fIterateptr1 < fHdim do
    begin
      case integer(fMainKeysUse[fIterateptr1]) of
        1:
          begin
            result := true;
            exit;
          end;
        2:
          begin
            fIterateptr2 := THash1Item(fMainKeys[fIterateptr1]);
            result := true;
            exit;
          end;
      end;
      inc(fIterateptr1);
    end;
  end
  else
  begin
    fIterateptr2 := fIterateptr2.nextitem;
    if fIterateptr2 = nil then
      result := IterateNext
    else
      result := true;
  end;
end;

function THash1.IterateGetValue: integer;
begin
  if fIterateptr2 <> nil then
    result := fIterateptr2.Value
  else
    result := integer(fMainKeysValue[fIterateptr1]);
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

function IEDirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

procedure IEForceDirectories(Dir: string);
begin
  if Length(Dir) = 0 then
    raise Exception.Create('Cannot Create Directory');
  if (AnsiLastChar(Dir) <> nil) and (AnsiLastChar(Dir)^ = '\') then
    Delete(Dir, Length(Dir), 1);
  if (Length(Dir) < 3) or IEDirectoryExists(Dir) or (ExtractFilePath(Dir) = Dir) then
    exit;
  IEForceDirectories(ExtractFilePath(Dir));
  CreateDir(Dir);
end;

// count consecutive bits
// ex  000111110000  return 5

function _GetBitCount(b: Integer): Integer;
var
  i: Integer;
begin
  i := 0;
  while (i < 31) and (((1 shl i) and b) = 0) do
    Inc(i);
  Result := 0;
  while ((1 shl i) and b) <> 0 do
  begin
    Inc(i);
    Inc(Result);
  end;
end;

// Converts colors count to needed bits per pixels (rounded)
function _NColToBitsPixel(NCol: integer): integer;
var
  q: integer;
begin
  result := -1;
  for q := 0 to 31 do
    if (NCol and (1 shl q)) <> 0 then
    begin
      if result <> -1 then
        result := q + 1
      else
        result := q;
    end;
end;

// return line length in bytes
// align is the number of bits of alignment. Allowed multiple of 8 bits (8,16,24,32,48...)
function IEBitmapRowLen(Width: integer; BitCount: integer; align: integer): integer;
begin
  case align of
    32:
      // formula optimized for 32
      result := (((Width * BitCount) + 31) shr 5) shl 2; // (((Width*BitCount)+31) div 32) * 4
  else
    // generic formula
    result := (((Width * BitCount) + (align - 1)) div align) * (align div 8);
  end;
end;

// Converts Pixelformat of TBitmap to BitCount
function _Pixelformat2BitCount(PixelFormat: TPixelFormat): integer;
const
  conv: array[pfDevice..pfCustom] of integer = (0, 1, 4, 8, 15, 16, 24, 32, 0);
begin
  case PixelFormat of
    pf1bit: result := 1;
    pf4bit: result := 4;
    pf8bit: result := 8;
    pf15bit: result := 15;
    pf16bit: result := 16;
    pf24bit: result := 24;
    pf32bit: result := 32;
  else
    result := 0;
  end;
end;

function IEVCLPixelFormat2ImageEnPixelFormat(PixelFormat:TPixelFormat):TIEPixelFormat;
begin
  case PixelFormat of
    pf1bit: result := ie1g;
    pf4bit: result := ie8p;
    pf8bit: result := ie8p;
    pf15bit: result := ie24RGB;
    pf16bit: result := ie24RGB;
    pf24bit: result := ie24RGB;
    pf32bit: result := ie24RGB;
  else
    result := ie24RGB;
  end;
end;

// Get rowlen from PixelFormat
function _PixelFormat2RowLen(Width: integer; PixelFormat: TPixelFormat): integer;
begin
  result := IEBitmapRowLen(Width, _Pixelformat2BitCount(PixelFormat), 32);
end;

// converts BitCount to PixelFormat (of TBitmap)
function _Bitcount2Pixelformat(Bitcount: integer): TPixelFormat;
begin
  case BitCount of
    1: result := pf1bit;
    4: result := pf4bit;
    8: result := pf8bit;
    15: result := pf15bit;
    16: result := pf16bit;
    24: result := pf24bit;
    32: result := pf32bit;
  else
    result := pfCustom;
  end;
end;

// reverse byte bits
procedure ReverseBitsB(var inp: byte);
const
  invtab: array[0..255] of byte = ($00, $80, $40, $C0, $20, $A0, $60, $E0, $10, $90, $50, $D0, $30, $B0,
    $70, $F0, $08, $88, $48, $C8, $28, $A8, $68, $E8, $18, $98, $58, $D8, $38, $B8, $78, $F8, $04, $84,
    $44, $C4, $24, $A4, $64, $E4, $14, $94, $54, $D4, $34, $B4, $74, $F4, $0C, $8C, $4C, $CC, $2C, $AC,
    $6C, $EC, $1C, $9C, $5C, $DC, $3C, $BC, $7C, $FC, $02, $82, $42, $C2, $22, $A2, $62, $E2, $12, $92,
    $52, $D2, $32, $B2, $72, $F2, $0A, $8A, $4A, $CA, $2A, $AA, $6A, $EA, $1A, $9A, $5A, $DA, $3A, $BA,
    $7A, $FA, $06, $86, $46, $C6, $26, $A6, $66, $E6, $16, $96, $56, $D6, $36, $B6, $76, $F6, $0E, $8E,
    $4E, $CE, $2E, $AE, $6E, $EE, $1E, $9E, $5E, $DE, $3E, $BE, $7E, $FE, $01, $81, $41, $C1, $21, $A1,
    $61, $E1, $11, $91, $51, $D1, $31, $B1, $71, $F1, $09, $89, $49, $C9, $29, $A9, $69, $E9, $19, $99,
    $59, $D9, $39, $B9, $79, $F9, $05, $85, $45, $C5, $25, $A5, $65, $E5, $15, $95, $55, $D5, $35, $B5,
    $75, $F5, $0D, $8D, $4D, $CD, $2D, $AD, $6D, $ED, $1D, $9D, $5D, $DD, $3D, $BD, $7D, $FD, $03, $83,
    $43, $C3, $23, $A3, $63, $E3, $13, $93, $53, $D3, $33, $B3, $73, $F3, $0B, $8B, $4B, $CB, $2B, $AB,
    $6B, $EB, $1B, $9B, $5B, $DB, $3B, $BB, $7B, $FB, $07, $87, $47, $C7, $27, $A7, $67, $E7, $17, $97,
    $57, $D7, $37, $B7, $77, $F7, $0F, $8F, $4F, $CF, $2F, $AF, $6F, $EF, $1F, $9F, $5F, $DF, $3F, $BF,
    $7F, $FF);
begin
  inp := invtab[inp];
end;

procedure ReverseBits(var inp: dword); assembler;
asm
      push esi
      push ebx
      mov  esi, eax
      mov  eax, DWord Ptr [esi]
      BSWAP   EAX
      MOV     EDX, EAX
      AND     EAX, 0AAAAAAAAh
      SHR     EAX, 1
      AND     EDX, 055555555h
      SHL     EDX, 1
      OR      EAX, EDX
      MOV     EDX, EAX
      AND     EAX, 0CCCCCCCCh
      SHR     EAX, 2
      AND     EDX, 033333333h
      SHL     EDX, 2
      OR      EAX, EDX
      MOV     EDX, EAX
      AND     EAX, 0F0F0F0F0h
      SHR     EAX, 4
      AND     EDX, 00F0F0F0Fh
      SHL     EDX, 4
      OR      EAX, EDX
      mov DWord Ptr [esi], eax
      pop    ebx
      pop    esi
end;


function IntPower(Base: Extended; Exponent: Integer): Extended;
asm
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;

function IEPower(Base, Exponent: Extended): Extended;
begin
  if Exponent = 0.0 then
    Result := 1.0 { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0 { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Trunc(Exponent))
  else
    Result := Exp(Exponent * Ln(Base))
end;

function IEPower2(const Base, Exponent: Double): Double;
const
 MAXINTFP : Extended = $7fffffff;
asm
   sub    esp,$14
   //if (Abs(Exponent) <= MaxInt) then
   fld    MAXINTFP
   fld    Exponent
   fld    st(0)
   fabs
   fcomp  st(2)
   fstsw  ax
   sahf
   ffree  st(1)
   jae    @IfEnd1
   //Y := Round(Exponent);
   fld    st(0)
   frndint
   fist   dword ptr [esp]
   fcomp  st(1)
   fstsw  ax
   sahf
   ffree  st(0)
   jnz    @IfEnd2
   //Result := IntPowerDKCIA32_4e(Base, Y)
   //if Base = 0 then
   fldz
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jnz    @IntPowIfEnd2
   //if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElse2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse2 :
   //ResultX := 0;
   fxch   st(1)
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowIfEnd2 :
   //else if Exponent = 0 then
   mov    ecx,[esp]
   test   ecx,ecx
   jnz    @IntPowElseIf2
   //ResultX := 1
   ffree  st(1)
   ffree  st(0)
   fld1
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf2 :
   //else if Exponent = 1 then
   cmp    ecx,1
   jnz    @IntPowElseIf3
   //ResultX := Base
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf3 :
   //else if Exponent = 2 then
   cmp    ecx,2
   jnz    @IntPowElseIf4
   //ResultX := Base * Base
   ffree  st(1)
   fmul   st(0),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf4 :
   //else if Exponent > 2 then
   cmp    ecx,2
   jle    @IntPowElseIf5
   ffree  st(1)
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
   mov    eax,ecx
   //I := 2;
   mov    edx,2
   //I2 := Exponent;
 @IntPowRepeat1Start :
   //I2 := I2 shr 1;
   shr    ecx,1
   jnc    @IntPowIfEnd8
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd8 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    edx,edx
   //until(I > Exponent);
   cmp    eax,edx
   jnl    @IntPowRepeat1Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf5 :
   //else if Exponent = -1 then
   cmp    ecx,-1
   jnz    @IntPowElseIf6
   ffree  st(1)
   //ResultX := 1/Base
   fld1
   fdivrp st(1),st(0)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElseIf6 :
   //else if Exponent = -2 then
   cmp    ecx,-2
   jnz    @IntPowElse7
   //ResultX := 1/(Base*Base)
   ffree  st(1)
   fmul   st(0),st(0)
   fld1
   fdivrp
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IntPowElse7 :
   ffree  st(1)
   //else //if Exponent < -2 then
   //I2 := -Exponent;
   mov    eax,ecx
   neg    eax
   mov    edx,eax
   //I := 2;
   mov    ecx,2
   //ResultX2 := 1;
   fld1
   //ResultX := Base;
   fxch   st(1)
 @IntPowRepeat2Start :
   //I2 := I2 shr 1;
   shr    eax,1
   jnc    @IntPowIfEnd7
   //ResultX2 := ResultX2 * ResultX;
   fmul   st(1),st(0)
 @IntPowIfEnd7 :
   //ResultX := ResultX * ResultX;
   fmul   st(0),st(0)
   //I := I * 2;
   add    ecx,ecx
   //until(I > -Exponent);
   cmp    ecx,edx
   jle    @IntPowRepeat2Start
   //ResultX := ResultX * ResultX2;
   fmulp  st(1),st(0)
   //ResultX := 1 / ResultX;
   fld1
   fdivr
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd2 :
   //Result := Exp(Exponent * Ln(Base))
   fld    Base
   fldln2
   fxch   st(1)
   fyl2x
   fld    Exponent
   fmulp
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd1 :
   //if (Exponent > 0) and (Base <> 0) then
   fldz
   fcom   st(1)
   fstsw  ax
   sahf
   jbe    @IfEnd3
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   jz     @IfEnd3
   ffree  st(1)
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0), st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @IfEnd3 :
   //else if Base = 0 then
   fld    Base
   fcom   st(1)
   fstsw  ax
   sahf
   ffree  st(1)
   jnz    @ElseIfEnd4
   //Result := 0
   ffree  st(2)
   wait
   mov    esp,ebp
   pop    ebp
   ret    $10
 @ElseIfEnd4 :
   //Result := Exp(Exponent * Ln(Base))
   fldln2
   fxch   st(1)
   fyl2x
   fmul   st(0),st(2)
   ffree  st(2)
   fldl2e
   fmulp
   fld    st(0)
   frndint
   fsub   st(1),st(0)
   fxch   st(1)
   f2xm1
   fld1
   faddp
   fscale
   ffree  st(1)
   wait
   mov    esp,ebp
end;

// if hdd<>0 uses DibDrawDib otherwise StetchDIBits
// USE THIS ONLY ON PRINTING FUNCTION OF TIMAGEENIO
procedure DrawDibDrawEmu(hdd: THandle; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt);
var
  fr: boolean;
begin
  fr := (lpbi.biBitCount = 24) and (hdd = 0);
  if fr then
    hdd := drawdibopen;
  if hdd = 0 then
  begin
    StretchDIBits(hDC, xDst, yDst, dxDst, dyDst, xSrc, ySrc, dxSrc, dySrc, Bits, PBITMAPINFO(@lpbi)^, DIB_RGB_COLORS, SRCCOPY);
  end
  else
    DrawDibDraw(hdd, hDC, xDst, yDst, dxDst, dyDst, lpbi, Bits, xSrc, ySrc, dxSrc, dySrc, wFlags);
  if fr then
    drawdibclose(hdd);
end;

procedure DrawDib(hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer);
begin
  SetStretchBltMode(hDC, HALFTONE);
  StretchDIBits(hDC, xDst, yDst, dxDst, dyDst, xSrc, ySrc, dxSrc, dySrc, Bits, PBITMAPINFO(@lpbi)^, DIB_RGB_COLORS, SRCCOPY);
end;


////////////////////////////////////////////////////////////////////////////////////
// exchanges WORD [ ex result:=hibyte(i) or (lobyte(i) shl 8); ]
function IESwapWord(i: word): word; assembler;
asm
	ror ax,8
end;

procedure IESwapWordRow(wordBuffer:pword; count:integer);
begin
  for count:=count-1 downto 0 do
  begin
    wordBuffer^ := (wordBuffer^ and $FF shl 8) or (wordBuffer^ and $FF00 shr 8);
    inc(wordBuffer);
  end;
end;

////////////////////////////////////////////////////////////////////////////////////
// exchanges DWORD
function IESwapDWord(i: integer): integer;
begin
  asm
   	mov EAX,i
   	bswap EAX
      mov @result,EAX
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// DoPaletteDialog
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnPaletteDialog.SetPalette

<FM>Declaration<FC>
procedure SetPalette(var Palette: array of <A TRGB>; NumCol: integer);

<FM>Description<FN>
Sets palette to show in the dialog.

<FM>Example<FC>

Var
  fPalDial:TImageEnPaletteDialog;
Begin
  fPalDial:=TImageEnPaletteDialog.Create(self);
  fPalDial.SetPalette(ImageEnIO1.Params.ColorMap^,ImageEnIO1.Params.ColorMapCount);
  if fPalDial.Execute then
    Panel1.Color:=fPalDial.SelCol;
  fPalDial.free;
End;
!!}
procedure TImageEnPaletteDialog.SetPalette(var Palette: array of TRGB; NumCol: integer);
begin
  fPalette := PRGBROW(@(Palette[0]));
  fNumCol := NumCol;
end;


constructor TImageEnPaletteDialog.Create(AOwner: TComponent);
begin
  inherited CreateNew(AOwner);
  OnPaint := self.FormPaint;
  OnMouseMove := self.FormMouseMove;
  OnClick := self.FormClick;
  BorderIcons := [biSystemMenu];
  BorderStyle := bsDialog;
  Caption := 'Palette';
  Height := 199;
  Position := poScreenCenter;
  Width := 520;
  ButtonCancel := TButton.Create(self);
  with ButtonCancel do
  begin
    Parent := self;
    ModalResult := mrCancel;
    Caption := '&Cancel';
    Cancel := true;
    Left := 4;
    Top := 136;
  end;
  MouseCol := -1;
end;


procedure TImageEnPaletteDialog.FormPaint(Sender: TObject);
var
  c, x, y: integer;
begin
  for c := 0 to fNumCol - 1 do
  begin
    y := 1 + (c div 32) * 16;
    x := 1 + (c - (c div 32) * 32) * 16;
    Canvas.Brush.Color := TRGB2TColor(fPalette^[c]);
    if MouseCol = c then
      Canvas.Pen.Color := clBlack
    else
      Canvas.Pen.Color := clWhite;
    Canvas.Rectangle(x, y, x + 15, y + 15);
  end;
end;


procedure TImageEnPaletteDialog.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  c: integer;
begin
  c := ((x - 1) div 16) + ((y - 1) div 16) * 32;
  if (c >= 0) and (c < fNumCol) and (c <> MouseCol) then
  begin
    MouseCol := c;
    FormPaint(self);
  end;
end;


procedure TImageEnPaletteDialog.FormClick(Sender: TObject);
begin
  SelCol := TRGB2TCOLOR(fPalette^[MouseCol]);
  modalresult := mrOK;
end;


{!!
<FS>TImageEnPaletteDialog.Execute

<FM>Declaration<FC>
function Execute: boolean;

<FM>Description<FN>
Executes the dialog. Returns True if the user select a color, otherwise False if the user Cancel the dialog.

Use SelCol property to get the color selected as TColor or NumCol to get as integer index.

<FM>Example<FC>

Var
  fPalDial:TImageEnPaletteDialog;
Begin
  fPalDial:=TImageEnPaletteDialog.Create(self);
  fPalDial.SetPalette(ImageEnIO1.Params.ColorMap^,ImageEnIO1.Params.ColorMapCount);
  if fPalDial.Execute then
    Panel1.Color:=fPalDial.SelCol;
  fPalDial.free;
End;

!!}
function TImageEnPaletteDialog.Execute: boolean;
begin
  result := ShowModal = mrOK;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

// changes x2,y2 to make an angle of 45° or 90° with the line to x1,y1
// useful when CTRL is pressed
procedure _CastPolySelCC(const x1, y1: integer; var x2, y2: integer);
var
  dx, dy: integer;
  adx, ady: integer;
begin
  dx := x1 - x2;
  adx := abs(dx);
  dy := y1 - y2;
  ady := abs(dy);
  if adx + 30 < ady then
    x2 := x1
  else if adx - 30 > ady then
    y2 := y1
  else
  begin
    if (dx < 0) and (dy < 0) then
    begin
      if (adx < ady) then
        inc(x2, abs(adx - ady))
      else
        inc(y2, abs(adx - ady));
    end
    else if (dx > 0) and (dy > 0) then
    begin
      if (adx < ady) then
        inc(y2, abs(adx - ady))
      else
        inc(x2, abs(adx - ady));
    end
    else if (dx > 0) then
    begin
      if (adx < ady) then
        dec(x2, abs(adx - ady))
      else
        inc(y2, abs(adx - ady));
    end
    else if (dy > 0) then
    begin
      if (adx < ady) then
        inc(x2, abs(adx - ady))
      else
        dec(y2, abs(adx - ady));
    end;
  end;
end;

// Return true if the two rectangles have a common region
// The rectangles must have ordered coordinates
function _RectXRect(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2: integer): boolean;
begin
  result := not ((IMAX(ax1, ax2) < bx1) or (IMIN(ax1, ax2) > bx2) or
    (IMAX(ay1, ay2) < by1) or (IMIN(ay1, ay2) > by2));
end;

// Return "How much" the rectangle "b" is included in "a"
// 0 = no common region
// 1 = common region (not all)
// 2 = common region
// The rectangles must have ordered coordinates
function _RectPRect(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2: integer): integer;
var
  vx1, vx2: boolean;
  vy1, vy2: boolean;
begin
  vx1 := (bx1 >= ax1) and (bx1 <= ax2);
  vx2 := (bx2 >= ax1) and (bx2 <= ax2);
  vy1 := (by1 >= ay1) and (by1 <= ay2);
  vy2 := (by2 >= ay1) and (by2 <= ay2);
  if (vx1 xor vx2) and (vy1 or vy2) then
    result := 1 // partial x
  else if (vx1 or vx2) and (vy1 xor vy2) then
    result := 1 // partial y
  else if (vx1 xor vx2) and (vy1 xor vy2) then
    result := 1 // partial xy
  else if vx1 and vx2 and vy1 and vy2 then
    result := 2 // full
  else
    result := 0; // null
end;

// return true if the point xx,yy is inside the rectangle x1,y1,x2,y2
// x1,y1,x2,y2 must be ordered
function _InRect(xx, yy, x1, y1, x2, y2: integer): boolean;
begin
  result := (xx >= x1) and (xx <= x2) and (yy >= y1) and (yy <= y2);
end;

// return true if the point xx,yy is inside the rectangle x1,y1,x2,y2
// x1,y1,x2,y2 ordered or not ordered
function _InRectO(xx, yy, x1, y1, x2, y2: integer): boolean;
begin
  OrdCor(x1, y1, x2, y2);
  result := (xx >= x1) and (xx <= x2) and (yy >= y1) and (yy <= y2);
end;

// return file size
function IEGetFileSize(const FileName: string): integer;
var
  hh: THandle;
begin
  hh := CreateFile(PChar(FileName), 0, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  result := GetFileSize(hh, nil);
  CloseHandle(hh);
end;

/////////////////////////////////////////////////////////////////////////////////////
// search for the window handle that contains cmp, going back (start from cmp)
function IEFindHandle(cmp: TComponent): integer;
var
  xowner: TComponent;
begin
  xowner := cmp;
  while assigned(xowner) and not (xowner is TWinControl) do
    xowner := xowner.owner;
  if assigned(xowner) and (xowner as TWinControl).handleallocated then
    result := (xowner as TWinControl).Handle
  else
    result := 0;
end;

/////////////////////////////////////////////////////////////////////////////////////

procedure IERightShadow(Canvas: TCanvas; DestBitmap:TBitmap; x1, y1, x2, y2: integer; st: TIEShadowType; dstColor:TColor);
var
  y, x, ww, hh: integer;
  cl1, cl2, cl: integer;
  o: integer;
  cl_c,radius,Temp:double;
  dstRGB:TRGB;
  cl_r,cl_g,cl_b:integer;
  //bmp:TIEBitmap;
  px:PRGB;
  bmpw,bmph:integer;
begin
  ww := x2 - x1 + 1;
  hh := y2 - y1 + 1;
  case st of
    iestSolid:
      Canvas.FillRect(Rect(x1, y1 + ww, x2, y2 + 1));
    iestSmooth1:
      begin
        // 2.2.5
        bmpw:=0;
        bmph:=0;
        if assigned(DestBitmap) then
        begin
          bmpw:=DestBitmap.Width;
          bmph:=DestBitmap.Height;
        end;
        radius:=ww/3;
        for x := 0 to ww - 1 do
        begin
          Temp := (ww-x) / radius;
          cl_c := Exp(-0.1 - Temp * Temp / 6);
          for y:=y1+ww to y2-ww+x+3 do
          begin
            if assigned(DestBitmap) and (x+x1>=0) and (y>=0) and (x+x1<bmpw) and (y<bmph) then
            begin
              px:=DestBitmap.Scanline[y]; inc(px,x+x1);
              with px^ do
              begin
                r:=trunc(cl_c*r);
                g:=trunc(cl_c*g);
                b:=trunc(cl_c*b);
              end;
            end
            else
            begin
              dstRGB:=TColor2TRGB( Canvas.Pixels[x1+x,y] );
              cl_r:=trunc(cl_c*dstRGB.r);
              cl_g:=trunc(cl_c*dstRGB.g);
              cl_b:=trunc(cl_c*dstRGB.b);
              Canvas.Pixels[x1+x,y]:=TColor((cl_r) + (cl_g shl 8) + (cl_b shl 16));
            end;
          end;
        end;
      end;
    iestSmooth2:
      begin
        o := 0;
        for y := 0 to hh do
        begin
          cl2 := blimit(trunc(exp((hh - y * 3) / hh) / exp(1) * 255));
          if y > hh - ww + 1 then
            inc(o);
          for x := o to ww do
          begin
            cl1 := trunc(exp(x / ww) / exp(1) * 255);
            cl := imax(cl1, cl2);
            Canvas.Pixels[x1 + x, y1 + y] := TColor((cl) + (cl shl 8) + (cl shl 16));
          end;
        end;
      end;
    (*
    iestSmooth3:
      // EXPERIMENTAL!
      begin
        o:=hh+20;
        bmp:=TIEBitmap.Create(o,o,ie8g);
        bmp.Fill(0);
        bmp.FillRect(10,10,o-10,o-10,255);
        _IEGBlurRect8(bmp,0,0,o-1,o-1,4);
        for y:=y1 to y2 do
        begin
          for x:=x1 to x2 do
          begin
            dstRGB:=TColor2TRGB(Canvas.Pixels[x,y]);
            cl_c:=1-bmp.Pixels_ie8[x-x1+o-10,y-y1+10]/255;
            cl_r:=trunc(cl_c*dstRGB.r);
            cl_g:=trunc(cl_c*dstRGB.g);
            cl_b:=trunc(cl_c*dstRGB.b);
            Canvas.pixels[x,y]:=TColor((cl_r) + (cl_g shl 8) + (cl_b shl 16));
          end;
        end;
        bmp.free;
      end;
    *)
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////

procedure IEBottomShadow(Canvas: TCanvas; DestBitmap:TBitmap; x1, y1, x2, y2: integer; st: TIEShadowType; dstColor:TColor);
var
  y, x, ww, hh: integer;
  cl1, cl2, cl: integer;
  o: integer;
  cl_c,radius,Temp:double;
  dstRGB:TRGB;
  cl_r,cl_g,cl_b:integer;
  bmpw,bmph:integer;
  px:PRGB;
begin
  ww := x2 - x1 + 1;
  hh := y2 - y1 + 1;
  case st of
    iestSolid:
      Canvas.FillRect(Rect(x1 + hh, y1, x2 + 1, y2));
    iestSmooth1:
      begin
        // 2.2.5
        bmpw:=0;
        bmph:=0;
        if assigned(DestBitmap) then
        begin
          bmpw:=DestBitmap.Width;
          bmph:=DestBitmap.Height;
        end;
        px:=nil;
        radius:=hh/3;
        for y := 0 to hh - 1 do
        begin
          Temp := (y-hh) / radius;
          cl_c := Exp(-0.1 - Temp * Temp / 6);
          if assigned(DestBitmap) and (y+y1>0) and (y+y1<bmph) then
          begin
            px:=DestBitmap.Scanline[y+y1];
            inc(px,x1+hh);
          end;
          for x:=x1+hh to x2-hh+y+1 do
          begin
            if assigned(DestBitmap) and (x>=0) and (y+y1>=0) and (x<bmpw) and (y+y1<bmph) then
            begin
              with px^ do
              begin
                r:=trunc(cl_c*r);
                g:=trunc(cl_c*g);
                b:=trunc(cl_c*b);
              end;
              inc(px);
            end
            else
            begin
              dstRGB:=TColor2TRGB( Canvas.Pixels[x,y1+y] );
              cl_r:=trunc(cl_c*dstRGB.r);
              cl_g:=trunc(cl_c*dstRGB.g);
              cl_b:=trunc(cl_c*dstRGB.b);
              Canvas.Pixels[x,y1+y]:=TColor((cl_r) + (cl_g shl 8) + (cl_b shl 16));
            end;
          end;
        end;
      end;
    iestSmooth2:
      begin
        o := 0;
        for x := 0 to ww do
        begin
          cl2 := blimit(trunc(exp((ww - x * 3) / ww) / exp(1) * 255));
          if x > ww - hh + 1 then
            inc(o);
          for y := o to hh do
          begin
            cl1 := trunc(exp(y / hh) / exp(1) * 255);
            cl := imax(cl1, cl2);
            Canvas.Pixels[x1 + x, y1 + y] := TColor((cl) + (cl shl 8) + (cl shl 16));
          end;
        end;
      end;
  end;
end;

procedure IERectShadow(Bitmap:TBitmap; x1,y1,x2,y2:integer; dstColor:TColor);
var
  ww,hh:integer;
  bmp:TIEBitmap;
  cl_c:double;
  radius:integer;
  bmpw,bmph:integer;
  pb:pbyte;
  px:PRGB;
  x,y:integer;
  offx,offy:integer;
begin
  radius:=5;
  offx:=2;
  offy:=2;

  bmpw:=Bitmap.Width;
  bmph:=Bitmap.Height;
  ww:=x2-x1+1;
  hh:=y2-y1+1;
  bmp:=TIEBitmap.Create(ww+radius*2,hh+radius*2,ie8g);
  bmp.Fill(0);
  bmp.FillRect(radius,radius,ww+radius-1+offx,hh+radius-1+offy,255);
  _IEGBlurRect8(bmp,0,0,ww+radius*2-1,hh+radius*2-1,radius/2);
  for y:=y1-radius to y2+radius do
  begin
    if (y>=0) and (y<bmph) then
    begin
      px:=Bitmap.Scanline[y]; inc(px,x1-radius);
      pb:=bmp.Scanline[y-y1+radius];
      for x:=x1-radius to x2+radius do
      begin
        if (x>=0) and (x<bmpw) and ((x<x1) or (x>=x2) or (y<y1) or (y>=y2)) then
        begin
          cl_c:=1-pb^/255;
          with px^ do
          begin
            r:=trunc(cl_c*r);
            g:=trunc(cl_c*g);
            b:=trunc(cl_c*b);
          end;
        end;
        inc(px);
        inc(pb);
      end;
    end;
  end;
  bmp.free;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

constructor TIEByteArray.Create(InitBlockSize:integer);
begin
  inherited Create;
  fBlockSize := InitBlockSize;
  fSize := 0;
  fRSize := fBlockSize;
  getmem(Data, fRSize);
end;

destructor TIEByteArray.Destroy;
begin
  freemem(Data);
  inherited;
end;

procedure TIEByteArray.AddByte(v: byte);
begin
  SetSize(fSize + 1);
  Data^[fSize - 1] := v;
end;

procedure TIEByteArray.Clear;
begin
  freemem(Data);
  fSize := 0;
  fRSize := fBlockSize;
  getmem(Data, fRSize);
end;

procedure TIEByteArray.SetSize(v: integer);
var
  tmp: pbytearray;
begin
  if v > fSize then
  begin
    // increase
    if v > fRSize then
    begin
      fRSize := v + fBlockSize;
      getmem(tmp, fRSize);
      CopyMemory(tmp, Data, fSize);
      freemem(Data);
      Data := tmp;
    end;
  end
  else
  begin
    // decrease
    if v < (fRSize - fBlockSize) then
    begin
      fRSize := v + fBlockSize;
      getmem(tmp, fRSize);
      CopyMemory(tmp, Data, fSize);
      freemem(Data);
      Data := tmp;
    end;
  end;
  fSize := v;
end;

// returns writed bytes
function TIEByteArray.AppendFromStream(Stream: TStream; Count: integer): integer;
var
  l: integer;
begin
  l := fSize;
  SetSize(fSize + Count);
  result := Stream.Read(Data^[l], Count);
  if result < Count then
    SetSize(l + result);
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

// Saves the string ss to Stream. Saves the size (integer) then the string.
// Compatible with LoadStringFromStream
procedure SaveStringToStream(Stream: TStream; const ss: AnsiString);
var
  i: integer;
begin
  i := length(ss);
  Stream.Write(i, sizeof(integer));
  Stream.Write(PAnsiChar(ss)^, i);
end;

// Loads a string from Stream. Compatible with SaveStringToStream
procedure LoadStringFromStream(Stream: TStream; var ss: AnsiString);
var
  i: integer;
begin
  Stream.Read(i, sizeof(integer));
  SetLength(ss, i);
  Stream.Read(PAnsiChar(ss)^, i);
end;

// Saves the string ss to Stream. Saves the size (integer) then the string.
// Compatible with LoadStringFromStreamW
procedure SaveStringToStreamW(Stream: TStream; const ss: widestring);
var
  i: integer;
begin
  i := length(ss);
  Stream.Write(i, sizeof(integer));
  Stream.Write(ss[1], i*2);
end;

// Loads a string from Stream. Compatible with SaveStringToStreamW
procedure LoadStringFromStreamW(Stream: TStream; var ss: widestring);
var
  i: integer;
begin
  Stream.Read(i, sizeof(integer));
  SetLength(ss, i);
  Stream.Read(ss[1], i*2);
end;


procedure SaveStringListToStream(Stream: TStream; sl: TStringList);
var
  i: integer;
begin
  i := sl.Count;
  Stream.Write(i, sizeof(integer));
  for i := 0 to sl.Count - 1 do
    SaveStringToStream(Stream, AnsiString(sl[i]));
end;

procedure LoadStringListFromStream(Stream: TStream; sl: TStringList);
var
  i, w: integer;
  ss: AnsiString;
begin
  Stream.Read(w, sizeof(integer));
  sl.Clear;
  for i := 0 to w - 1 do
  begin
    LoadStringFromStream(Stream, ss);
    sl.Add(string(ss));
  end;
end;

// Returns number of colors calculated from BitsPerSample and SamplesperPixel

function _GetNumCol(BitsPerSample: integer; SamplesPerPixel: integer): integer;
begin
  result := 1;
  while SamplesPerPixel > 0 do
  begin
    result := result * (1 shl BitsPerSample);
    dec(SamplesPerPixel);
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

constructor TNulStream.Create;
begin
  inherited;
  fposition := 0;
  fsize := 0;
end;

destructor TNulStream.Destroy;
begin
  inherited Destroy;
end;

function TNulStream.Read(var Buffer; Count: Longint): Longint;
begin
  inc(fposition, Count);
  if fposition >= fsize then
    fsize := fposition;
  result := Count;
end;

function TNulStream.Write(const Buffer; Count: Longint): Longint;
begin
  inc(fposition, Count);
  if fposition >= fsize then
    fsize := fposition;
  result := Count;
end;

function TNulStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  case Origin of
    soFromBeginning:
      begin
        fPosition := offset;
        if fposition >= fsize then
          fsize := fposition;
      end;
    soFromCurrent:
      begin
        inc(fposition, offset);
        if fposition >= fsize then
          fsize := fposition;
      end;
    soFromEnd:
      begin
        fposition := fsize - offset;
      end;
  end;
  result := fPosition;
end;


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>IESetTranslationWord

<FM>Declaration<FC>
procedure IESetTranslationWord(const lang: <A TMsgLanguage>; const msg: <A TMsgLanguageWords>; const trans: AnsiString);
procedure IESetTranslationWordU(const lang: <A TMsgLanguage>; const msg: <A TMsgLanguageWords>; const trans: String);

<FM>Description<FN>
IESetTranslationWord allows applications to set a customized word/sentence translation.
<FC>lang<FN> is the target language.
<FC>msg<FN> is the message to translate.
<FC>trans<FN> is the translated message.

See also iewords.pas file.
!!}
procedure IESetTranslationWord(const lang: TMsgLanguage; const msg: TMsgLanguageWords; const trans: AnsiString);
{$ifdef UNICODE}
var
  rbs:RawByteString;
begin
  rbs := trans;
  SetCodePage(rbs, IELANGUAGECHARINFO[lang].CodePage, false);
  ieMessages[lang][msg] := string(rbs);
end;
{$else}
begin
  ieMessages[lang][msg] := string(trans);
end;
{$endif}

{$ifdef UNICODE}
procedure IESetTranslationWordU(const lang: TMsgLanguage; const msg: TMsgLanguageWords; const trans: string);
begin
  ieMessages[lang][msg] := trans;
end;
{$endif}

// returns the message "msg" in language "lang"
function iemsg(const msg: TMsgLanguageWords; const lang: TMsgLanguage): WideString;
begin
  if lang = msSystem then
  begin
    case syslocale.PriLangID of
{$IFDEF IESUPPORTITALIAN}
      LANG_ITALIAN: result := ieMessages[msItalian][msg];
{$ENDIF}
{$IFDEF IESUPPORTPORTUGUESE}
      LANG_PORTUGUESE: result := ieMessages[msPortuguese][msg];
{$ENDIF}
{$IFDEF IESUPPORTENGLISH}
      LANG_ENGLISH: result := ieMessages[msEnglish][msg];
{$ENDIF}
{$IFDEF IESUPPORTSPANISH}
      LANG_SPANISH: result := ieMessages[msSpanish][msg];
{$ENDIF}
{$IFDEF IESUPPORTFRENCH}
      LANG_FRENCH: result := ieMessages[msFrench][msg];
{$ENDIF}
{$IFDEF IESUPPORTGERMAN}
      LANG_GERMAN: result := ieMessages[msGerman][msg];
{$ENDIF}
{$IFDEF IESUPPORTGREEK}
      LANG_GREEK: result := ieMessages[msGreek][msg];
{$ENDIF}
{$IFDEF IESUPPORTRUSSIAN}
      LANG_RUSSIAN: result := ieMessages[msRussian][msg];
{$ENDIF}
{$IFDEF IESUPPORTDUTCH}
      LANG_DUTCH: result := ieMessages[msDutch][msg];
{$ENDIF}
{$IFDEF IESUPPORTSWEDISH}
      LANG_SWEDISH: result := ieMessages[msSwedish][msg];
{$ENDIF}
{$IFDEF IESUPPORTPOLISH}
      LANG_POLISH: result := ieMessages[msPolish][msg];
{$ENDIF}
{$IFDEF IESUPPORTJAPANESE}
      LANG_JAPANESE: result := ieMessages[msJapanese][msg];
{$ENDIF}
{$IFDEF IESUPPORTCZECH}
      LANG_CZECH: result := ieMessages[msCzech][msg];
{$ENDIF}
{$IFDEF IESUPPORTFINNISH}
      LANG_FINNISH: result := ieMessages[msFinnish][msg];
{$ENDIF}
{$IFDEF IESUPPORTFARSI}
      LANG_FARSI: result := ieMessages[msFarsi][msg];
{$ENDIF}
{$IFDEF IESUPPORTDANISH}
      LANG_DANISH: result := ieMessages[msDanish][msg];
{$ENDIF}
{$IFDEF IESUPPORTTURKISH}
      LANG_TURKISH: result := ieMessages[msTurkish][msg];
{$ENDIF}
{$IFDEF IESUPPORTKOREAN}
      LANG_KOREAN: result := ieMessages[msKorean][msg];
{$ENDIF}
{$IFDEF IESUPPORTHUNGARIAN}
      LANG_HUNGARIAN: result := ieMessages[msHungarian][msg];
{$ENDIF}
{$IFDEF IESUPPORTCHINESE}
      LANG_CHINESE:
        case syslocale.SubLangID of
          SUBLANG_CHINESE_SIMPLIFIED:  result := ieMessages[msChinese][msg];
          SUBLANG_CHINESE_TRADITIONAL: result := ieMessages[msChineseTraditional][msg];
        end;
{$ENDIF}
    else
{$IFDEF IESUPPORTENGLISH}
      result := ieMessages[msEnglish][msg];
{$ELSE}
      result := ieMessages[TMsgLanguage(1)][msg];
{$ENDIF}
    end;
  end
  else
  begin
    result := ieMessages[lang][msg];
    if result = '' then
{$IFDEF IESUPPORTENGLISH}
      result := ieMessages[msEnglish][msg];
{$ELSE}
      result := ieMessages[TMsgLanguage(1)][msg];
{$ENDIF}
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEList

constructor TIEList.Create;
begin
  inherited;
  fData := nil;
  Clear;
end;

destructor TIEList.Destroy;
begin
  freemem(fData);
  inherited Destroy;
end;

{!!
<FS>TIEList.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Clear empties the Items array.
!!}
procedure TIEList.Clear;
begin
  fCapacity := 0;
  fCount := 0;
  if assigned(fData) then
    freemem(fData);
  fData := nil;
  fChanged := [];
end;

{!!
<FS>TIEList.Count

<FM>Declaration<FC>
property Count:integer;

<FM>Description<FN>
Count contains the number of items in the Items array.
!!}
procedure TIEList.SetCount(v: integer);
var
  xData: pointer;
begin
  if fCapacity < v then
  begin
    fCapacity := imax(fCapacity * 2, v);
    getmem(xData, fCapacity * fItemSize);
    if assigned(fData) then
    begin
      move(pbyte(fData)^, pbyte(xData)^, imin(fCount, v) * fItemSize);
      freemem(fData);
    end;
    fData := xData;
  end;
  fCount := v;
  fChanged := fChanged + [ielItems];
end;

{!!
<FS>TIEList.Delete

<FM>Declaration<FC>
procedure Delete(idx:integer);

<FM>Description<FN>
Delete the idx value from the list.
!!}
procedure TIEList.Delete(idx: integer);
var
  xData: pointer;
  q: integer;
  psrc, pdst: pbyte;
begin
  if (idx >= 0) and (idx < fCount) then
  begin
    getmem(xData, (fCount - 1) * fItemSize);
    psrc := fData;
    pdst := xData;
    for q := 0 to fCount - 1 do
    begin
      if q <> idx then
      begin
        // copy
        move(psrc^, pdst^, fItemSize);
        inc(pdst, fItemSize);
      end;
      inc(psrc, fItemSize);
    end;
    freemem(fData);
    fData := xData;
    dec(fCount);
    fCapacity := fCount;
    fChanged := fChanged + [ielItems];
  end;
end;

procedure TIEList.InsertItem(idx: integer; v: pointer);
var
  xData: pointer;
  q: integer;
  psrc, pdst: pbyte;
begin
  if idx < fCount then
  begin
    inc(fCount);
    fCapacity := fCount;
    getmem(xData, fCount * fItemSize);
    psrc := fData;
    pdst := xData;
    for q := 0 to fCount - 1 do
    begin
      if q <> idx then
      begin
        // copy
        move(psrc^, pdst^, fItemSize);
        inc(psrc, fItemSize);
      end
      else
        // insert
        move(pbyte(v)^, pdst^, fItemSize);
      inc(pdst, fItemSize);
    end;
    freemem(fData);
    fData := xData;
    fChanged := fChanged + [ielItems];
  end
  else
    AddItem(v);
end;

function TIEList.IndexOfItem(v: pointer): integer;
var
  pp: pbyte;
begin
  pp := fData;
  for result := 0 to fCount - 1 do
  begin
    if CompareMem(pp, v, fItemSize) then
      exit;
    inc(pp, fItemSize);
  end;
  result := -1;
end;

function TIEList.AddItem(v: pointer): integer;
begin
  result := fCount;
  SetCount(fCount + 1);
  move(pbyte(v)^, pbyte(int64(DWORD(fData)) + result * fItemSize)^, fItemSize);
  fChanged := fChanged + [ielItems];
end;

function TIEList.BaseGetItem(idx: integer): pointer;
begin
  result := pointer(int64(DWORD(fData)) + idx * fItemSize)
end;

procedure TIEList.BaseSetItem(idx: integer; v: pointer);
begin
  if idx < fCount then
  begin
    move(pbyte(v)^, pbyte(int64(DWORD(fData)) + idx * fItemSize)^, fItemSize);
    fChanged := fChanged + [ielItems];
  end;
end;

procedure TIEList.Assign(Source: TIEList);
begin
  if assigned(Source) then
  begin
    fCount := Source.fCount;
    fItemSize := Source.fItemSize;
    fChanged := Source.fChanged;
    if assigned(fData) then
      freemem(fData);
    getmem(fData, fItemSize * fCount);
    move(pbyte(Source.fData)^, pbyte(fData)^, fItemSize * fCount);
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEDoubleList

procedure TIEDoubleList.Assign(Source: TIEList);
begin
  inherited;
  if assigned(Source) then
  begin
    fRangeMin := (Source as TIEDoubleList).fRangeMin;
    fRangeMax := (Source as TIEDoubleList).fRangeMax;
    fRangeStep := (Source as TIEDoubleList).fRangeStep;
    fCurrentValue := (Source as TIEDoubleList).fCurrentValue;
  end;
end;

{!!
<FS>TIEDoubleList.Add

<FM>Declaration<FC>
function Add(v: double): integer;

<FM>Description<FN>
Adds a new value to the list.

!!}
function TIEDoubleList.Add(v: double): integer;
begin
  result := AddItem(@v);
end;

{!!
<FS>TIEDoubleList.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Removes all items.
!!}
procedure TIEDoubleList.Clear;
begin
  inherited;
  fItemSize := sizeof(double);
  fRangeMin := 0;
  fRangeMax := 0;
  fRangeStep := 0;
  fCurrentValue := 0;
end;

{!!
<FS>TIEDoubleList.Items

<FM>Declaration<FC>
property Items[index]: double;

<FM>Description<FN>
Items returns the double value of index element.

!!}
function TIEDoubleList.GetItem(idx: integer): double;
begin
  result := PDouble(BaseGetItem(idx))^;
end;

procedure TIEDoubleList.SetItem(idx: integer; v: double);
begin
  BaseSetItem(idx, @v);
end;

{!!
<FS>TIEDoubleList.Insert

<FM>Declaration<FC>
procedure Insert(idx: integer; v: double);

<FM>Description<FN>
Insert a new value inside idx position.

!!}
procedure TIEDoubleList.Insert(idx: integer; v: double);
begin
  InsertItem(idx, @v);
end;

{!!
<FS>TIEDoubleList.IndexOf

<FM>Declaration<FC>
function IndexOf(v: double): integer;

<FM>Description<FN>
IndexOf returns the index of v value. Returns -1 if not found.

!!}
function TIEDoubleList.IndexOf(v: double): integer;
begin
  result := IndexOfItem(@v);
end;

{!!
<FS>TIEDoubleList.RangeMin

<FM>Declaration<FC>
property RangeMin: double;

<FM>Description<FN>
RangeMin is the minimum value that you can assign to <A TIEDoubleList.CurrentValue>.
!!}
procedure TIEDoubleList.SetRangeMin(v: double);
begin
  fRangeMin := v;
  fChanged := fChanged + [ielRange];
end;

{!!
<FS>TIEDoubleList.RangeMax

<FM>Declaration<FC>
property RangeMax: double;

<FM>Description<FN>
RangeMax is the max value that you can assign to <A TIEDoubleList.CurrentValue>.
!!}
procedure TIEDoubleList.SetRangeMax(v: double);
begin
  fRangeMax := v;
  fChanged := fChanged + [ielRange];
end;

{!!
<FS>TIEDoubleList.RangeStep

<FM>Declaration<FC>
property RangeStep: double;

<FM>Description<FN>
RangeStep defines the step from <A TIEDoubleList.RangeMin> to <A TIEDoubleList.RangeMax>.
!!}
procedure TIEDoubleList.SetRangeStep(v: double);
begin
  fRangeStep := v;
  fChanged := fChanged + [ielRange];
end;

{!!
<FS>TIEDoubleList.CurrentValue

<FM>Declaration<FC>
property CurrentValue: double;

<FM>Description<FN>
CurrentValue returns the current value of the list. It isn't an index of <A TIEDoubleList.Items>, but a "powerup" value.
No control is made to values assigned to CurrentValue, but it should be one of the values in <A TIEDoubleList.Items> or inside of <A TIEDoubleList.RangeMin> and <A TIEDoubleList.RangeMax> (regarding <A TIEDoubleList.RangeStep> also).
!!}
procedure TIEDoubleList.SetCurrentValue(v: double);
begin
  fCurrentValue := v;
  fChanged := fChanged + [ielCurrentValue];
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEIntegerList

procedure TIEIntegerList.Assign(Source: TIEList);
begin
  inherited;
  if assigned(Source) then
  begin
    fRangeMin := (Source as TIEIntegerList).fRangeMin;
    fRangeMax := (Source as TIEIntegerList).fRangeMax;
    fRangeStep := (Source as TIEIntegerList).RangeStep;
    fCurrentValue := (Source as TIEIntegerList).fCurrentValue;
  end;
end;

{!!
<FS>TIEIntegerList.Add

<FM>Declaration<FC>
function Add(v: integer): integer;

<FM>Description<FN>
Adds a new value to the list.
!!}
function TIEIntegerList.Add(v: Integer): integer;
begin
  result := AddItem(@v);
end;

{!!
<FS>TIEIntegerList.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Removes all items.
!!}
procedure TIEIntegerList.Clear;
begin
  inherited;
  fRangeMin := 0;
  fRangeMax := 0;
  fRangeStep := 0;
  fCurrentValue := 0;
  fItemSize := sizeof(Integer);
end;

{!!
<FS>TIEIntegerList.Items

<FM>Declaration<FC>
property Items[index]: integer;

<FM>Description<FN>
<FC>Items<FN> returns the value of <FC>index<FN> element.
!!}
function TIEIntegerList.GetItem(idx: integer): Integer;
begin
  result := PInteger(BaseGetItem(idx))^;
end;

procedure TIEIntegerList.SetItem(idx: integer; v: Integer);
begin
  BaseSetItem(idx, @v);
end;

{!!
<FS>TIEIntegerList.Insert

<FM>Declaration<FC>
procedure Insert(idx: integer; v: integer);

<FM>Description<FN>
Insert a new value inside idx position.
!!}
procedure TIEIntegerList.Insert(idx: integer; v: Integer);
begin
  InsertItem(idx, @v);
end;

{!!
<FS>TIEIntegerList.IndexOf

<FM>Declaration<FC>
function IndexOf(v: integer): integer;

<FM>Description<FN>
IndexOf returns the index of v value. Returns -1 if not found.

!!}
function TIEIntegerList.IndexOf(v: Integer): integer;
begin
  result := IndexOfItem(@v);
end;

{!!
<FS>TIEIntegerList.RangeMin

<FM>Declaration<FC>
property RangeMin: integer;

<FM>Description<FN>
RangeMin is the minimum value that you may assign to <A TIEIntegerList.CurrentValue>.

!!}
procedure TIEIntegerList.SetRangeMin(v: integer);
begin
  fRangeMin := v;
  fChanged := fChanged + [ielRange];
end;

{!!
<FS>TIEIntegerList.RangeMax

<FM>Declaration<FC>
property RangeMax: integer;

<FM>Description<FN>
RangeMax is the maximum value you may assign to <A TIEIntegerList.CurrentValue>.

!!}
procedure TIEIntegerList.SetRangeMax(v: integer);
begin
  fRangeMax := v;
  fChanged := fChanged + [ielRange];
end;

{!!
<FS>TIEIntegerList.RangeStep

<FM>Declaration<FC>
property RangeStep: integer;

<FM>Description<FN>
RangeStep specifies the step from <A TIEIntegerList.RangeMin> to <A TIEIntegerList.RangeMax>.

!!}
procedure TIEIntegerList.SetRangeStep(v: integer);
begin
  fRangeStep := v;
  fChanged := fChanged + [ielRange];
end;

{!!
<FS>TIEIntegerList.CurrentValue

<FM>Declaration<FC>
property CurrentValue: integer;

<FM>Description<FN>
CurrentValue returns the current value of the list. It isn't an index of <A TIEIntegerList.Items>, but a "powerup" value.

No control is made to values assigned to CurrentValue, but it should be one of the values in <A TIEIntegerList.Items> or inside of <A TIEIntegerList.RangeMin> and <A TIEIntegerList.RangeMax> (regarding <A TIEIntegerList.RangeStep> also).

!!}
procedure TIEIntegerList.SetCurrentValue(v: integer);
begin
  fCurrentValue := v;
  fChanged := fChanged + [ielCurrentValue];
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIEMarkerList

constructor TIEMarkerList.Create;
begin
  inherited;
  fData := TList.Create;
  fType := TList.Create;
end;

destructor TIEMarkerList.Destroy;
begin
  Clear;
  FreeAndNil(fData);
  FreeAndNil(fType);
  inherited Destroy;
end;

{!!
<FS>TIEMarkerList.Count

<FM>Declaration<FC>
property Count:integer;

<FM>Description<FN>
Returns the markers count.
!!}
function TIEMarkerList.GetCount: integer;
begin
  result := fData.Count;
end;

{!!
<FS>TIEMarkerList.MarkerStream

<FM>Declaration<FC>
property MarkerStream[idx:integer]:TStream;

<FM>Description<FN>
Get marker data stream of marker idx.
!!}
function TIEMarkerList.GetMarkerStream(idx: integer): TStream;
begin
  result := TStream(fData.Items[idx]);
  result.Position := 0;
end;

{!!
<FS>TIEMarkerList.MarkerData

<FM>Declaration<FC>
property MarkerData[idx:integer]:PAnsiChar;

<FM>Description<FN>
Get marker data buffer pointer of marker idx.
!!}
function TIEMarkerList.GetMarkerData(idx: integer): PAnsiChar;
begin
  result := PAnsiChar(TMemoryStream(fData.Items[idx]).memory);
end;

{!!
<FS>TIEMarkerList.MarkerType

<FM>Declaration<FC>
property MarkerType[idx:integer]:byte;

<FM>Description<FN>
Get marker type (JPEG_APP0 to JPEG_APP15 and JPEG_COM).
!!}
function TIEMarkerList.GetMarkerType(idx: integer): byte;
begin
  result := byte(integer(fType.Items[idx]));
end;

{!!
<FS>TIEMarkerList.MarkerLength

<FM>Declaration<FC>
property MarkerLength[idx:integer]:word;

<FM>Description<FN>
Get marker length (65535 bytes max).
!!}
function TIEMarkerList.GetMarkerLength(idx: integer): word;
begin
  result := TMemoryStream(fData.Items[idx]).size;
end;

{!!
<FS>TIEMarkerList.IndexOf

<FM>Declaration<FC>
function IndexOf(marker:byte):integer;

<FM>Description<FN>
Finds the first marker and return its index. If a marker is not in the list, IndexOf returns -1.
!!}
function TIEMarkerList.IndexOf(marker: byte): integer;
begin
  for result := 0 to fType.Count - 1 do
    if byte(integer(fType.Items[result])) = marker then
      exit;
  result := -1;
end;

{!!
<FS>TIEMarkerList.AddMarker

<FM>Declaration<FC>
function AddMarker(marker:byte; data:PAnsiChar; datalen:word):integer;

<FM>Description<FN>
Adds a new marker to the list. marker can be from JPEG_APP0 to JPEG_APP15 and JPEG_COM.
AddMarker returns the index of the new marker, where the first marker in the list has an index of 0.
A single JPEG file can contains multiple instances of some marker.
!!}
function TIEMarkerList.AddMarker(marker: byte; data: PAnsiChar; datalen: word): integer;
var
  ms: TMemoryStream;
  i: integer;
begin
  ms := TMemoryStream.Create;
  ms.Write(data^, datalen);
  fData.Add(ms);
  i := marker;
  result := fType.Add(pointer(i));
end;

{!!
<FS>TIEMarkerList.InsertMarker

<FM>Declaration<FC>
procedure InsertMarker(idx:integer; data:PAnsiChar; marker:byte; datalen:word);

<FM>Description<FN>
Call InsertMarker to add marker to the middle of the marker array. The <FC>idx<FN> parameter is a zero-based index.
!!}
procedure TIEMarkerList.InsertMarker(idx: integer; data: PAnsiChar; marker: byte; datalen: word);
var
  ms: TMemoryStream;
  i: integer;
begin
  ms := TMemoryStream.Create;
  ms.Write(data^, datalen);
  fData.Insert(idx, ms);
  i := marker;
  fType.Insert(idx, pointer(i));
end;

{!!
<FS>TIEMarkerList.SetMarker

<FM>Declaration<FC>
procedure SetMarker(idx:integer; marker:byte; data:PAnsiChar; datalen:word);

<FM>Description<FN>
Replace the marker <FC>idx<FN>.
!!}
procedure TIEMarkerList.SetMarker(idx: integer; marker: byte; data: PAnsiChar; datalen: word);
var
  ms: TMemoryStream;
  i: integer;
begin
  TMemoryStream(fData.Items[idx]).Free;
  fData.Items[idx]:=nil;
  ms := TMemoryStream.Create;
  ms.Write(data^, datalen);
  fData.Items[idx] := ms;
  i := marker;
  fType.Items[idx] := pointer(i);
end;

{!!
<FS>TIEMarkerList.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Remove all markers.
!!}
procedure TIEMarkerList.Clear;
var
  i:integer;
begin
  for i:=0 to fData.Count-1 do
    TMemoryStream(fData.Items[i]).free;
  fData.Clear;
  fType.Clear;
end;

{!!
<FS>TIEMarkerList.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream: TStream);

<FM>Description<FN>
Saves all markers in the stream. Only <A TIEMarkerList.LoadFromStream> can reload data.
!!}
procedure TIEMarkerList.SaveToStream(Stream: TStream);
var
  bb: byte;
  ii, w: integer;
begin
  bb := 0;
  Stream.Write(bb, 1); // version
  ii := fData.Count;
  Stream.Write(ii, sizeof(integer)); // markers count
  for ii := 0 to fData.Count - 1 do
  begin
    bb := byte(integer(fType.Items[ii]));
    Stream.Write(bb, 1); // marker type
    w := TMemoryStream(fData.Items[ii]).Size;
    Stream.Write(w, sizeof(integer)); // marker length
    TMemoryStream(fData.Items[ii]).Position := 0;
    TMemoryStream(fData.Items[ii]).SaveToStream(Stream); // data
  end;
end;

{!!
<FS>TIEMarkerList.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream: TStream);

<FM>Description<FN>
Loads all markers from stream.
!!}
procedure TIEMarkerList.LoadFromStream(Stream: TStream);
var
  bb: byte;
  ii, q, w, l: integer;
  ms: TMemoryStream;
begin
  Clear;
  Stream.Read(bb, 1);
  Stream.Read(ii, sizeof(integer));
  for q := 0 to ii - 1 do
  begin
    Stream.Read(bb, 1);
    w := bb;
    fType.Add(pointer(w));
    Stream.Read(l, sizeof(integer));
    ms := TMemoryStream.Create;
    ms.SetSize(l);
    Stream.Read(PAnsiChar(ms.memory)^, l);
    fData.Add(ms);
  end;
end;

{!!
<FS>TIEMarkerList.DeleteMarker

<FM>Declaration<FC>
procedure DeleteMarker(idx:integer);

<FM>Description<FN>
Removes marker <FC>idx<FN>.
!!}
procedure TIEMarkerList.DeleteMarker(idx: integer);
begin
  TMemoryStream(fData.Items[idx]).free;
  fData.Delete(idx);
  fType.Delete(idx);
end;

{!!
<FS>TIEMarkerList.Assign

<FM>Declaration<FC>
procedure Assign(Source: <A TIEMarkerList>);

<FM>Description<FN>
Assigns all markers from <FC>Source<FN>.
!!}
procedure TIEMarkerList.Assign(Source: TIEMarkerList);
var
  q: integer;
begin
  if assigned(Source) then
  begin
    Clear;
    for q := 0 to Source.Count - 1 do
      AddMarker(Source.MarkerType[q], Source.MarkerData[q], Source.MarkerLength[q]);
  end;
end;

function TIEMarkerList.SortCompare(Index1,Index2:integer):integer;
var
  p1,p2:PAnsiChar;
begin
  result:=integer(fType[Index1])-integer(fType[Index2]);
  if (integer(fType[Index1])=JPEG_APP2) and (integer(fType[Index2])=JPEG_APP2) and (MarkerLength[Index1]>13) and (MarkerLength[Index2]>13) then
  begin
    // compare ICC tags (2.3.1)
    p1:=MarkerData[Index1];
    p2:=MarkerData[Index2];
    if (p1='ICC_PROFILE') and (p2='ICC_PROFILE') then
    begin
      result:=ord(p1[12])-ord(p2[12]);
    end;
  end;
end;

procedure TIEMarkerList.SortSwap(Index1,Index2:integer);
var
  t:pointer;
begin
  t:=fType[Index1];
  fType[Index1]:=fType[Index2];
  fType[Index2]:=t;
  t:=fData[Index1];
  fData[Index1]:=fData[Index2];
  fData[Index2]:=t;
end;

// 2.2.5
procedure TIEMarkerList.Sort;
var
  i,j:integer;
begin
  IEQuickSort(fType.Count,SortCompare,SortSwap);
  // put APP1 with EXIF before other APP1
  // APP1-EXIF must be the first one, even they are other APP1 tags (i.e. Photoshop adds a custom APP1 tag)
  for i:=0 to fType.Count-1 do
    if integer(fType[i])=JPEG_APP1 then
    begin
      for j:=i+1 to fType.Count-1 do
        if (GetMarkerType(j)=JPEG_APP1) and CheckEXIFFromStandardBuffer(GetMarkerData(j),GetMarkerLength(j)) then
          SortSwap(i,j);
      break;
    end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// PIEIPTCInfoList

{!!
<FS>TIEIPTCInfoList.StringItem

<FM>Declaration<FC>
property StringItem[idx:integer]:string;

<FM>Description<FN>
Returns the string associated to the item <FC>idx<FN>. The item must be of string type.
!!}
function TIEIPTCInfoList.GetStrings(idx: integer): string;
var
  r:AnsiString;
begin
  if (idx >= 0) and (idx < fInfo.Count) then
  begin
    SetLength(r, PIPTCInfo(fInfo[idx])^.fLength);
    move(pbyte(fBuffer[idx])^, r[1], PIPTCInfo(fInfo[idx])^.fLength);
  end
  else
    r := '';
  result := string(r);
end;

procedure TIEIPTCInfoList.SetStrings(idx: integer; Value: string);
var
  v:AnsiString;
begin
  v := AnsiString(Value);
  freemem(fBuffer[idx]);
  fBuffer[idx] := allocmem(length(v));
  CopyMemory(fBuffer[idx], PAnsiChar(v), length(v));
  PIPTCInfo(fInfo[idx])^.fLength := length(v);
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.GetItemData

<FM>Declaration<FC>
function GetItemData(idx:integer):pointer;

<FM>Description<FN>
Returns the raw data associated to the item <FC>idx<FN>.
!!}
function TIEIPTCInfoList.GetItemData(idx:integer):pointer;
begin
  if (idx >= 0) and (idx < fInfo.Count) then
    result := fBuffer[idx]
  else
    result := nil;
end;

{!!
<FS>TIEIPTCInfoList.GetItemLength

<FM>Declaration<FC>
function GetItemLength(idx:integer):integer;

<FM>Description<FN>
Returns the raw data length associated to the item <FC>idx<FN>.
!!}
function TIEIPTCInfoList.GetItemLength(idx:integer):integer;
begin
  if (idx >= 0) and (idx < fInfo.Count) then
    result := PIPTCInfo(fInfo[idx])^.fLength
  else
    result := 0;
end;


{!!
<FS>TIEIPTCInfoList.RecordNumber

<FM>Declaration<FC>
property RecordNumber[idx:integer]:integer;

<FM>Description<FN>
Returns the record number associated to the item <FC>idx<FN>.
!!}
function TIEIPTCInfoList.GetRecordNumber(idx: integer): integer;
begin
  result := PIPTCInfo(fInfo[idx])^.fRecord;
end;

procedure TIEIPTCInfoList.SetRecordNumber(idx: integer; Value: integer);
begin
  PIPTCInfo(fInfo[idx])^.fRecord := Value;
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.DataSet

<FM>Declaration<FC>
property DataSet[idx:integer]:integer;

<FM>Description<FN>
Returns the dataset number associated to the item <FC>idx<FN>.
!!}
function TIEIPTCInfoList.GetDataSet(idx: integer): integer;
begin
  result := PIPTCInfo(fInfo[idx])^.fDataSet;
end;

procedure TIEIPTCInfoList.SetDataSet(idx: integer; Value: integer);
begin
  PIPTCInfo(fInfo[idx])^.fDataSet := Value;
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.Count

<FM>Declaration<FC>
property Count:integer;

<FM>Description<FN>
Returns items count.
!!}
function TIEIPTCInfoList.GetCount: integer;
begin
  result := fInfo.Count;
end;

constructor TIEIPTCInfoList.Create;
begin
  inherited Create;
  fInfo := TList.Create;
  fBuffer := TList.Create;
  fUserChanged := false;
end;

destructor TIEIPTCInfoList.Destroy;
begin
  Clear;
  FreeAndNil(fInfo);
  FreeAndNil(fBuffer);
  inherited Destroy;
end;

{!!
<FS>TIEIPTCInfoList.AddStringItem

<FM>Declaration<FC>
function AddStringItem(RecordNumber:integer; DataSet:integer; Value:AnsiString):integer;

<FM>Description<FN>
Adds a string (textual information) with specified <FC>RecordNumber<FN> and <FC>DataSet<FN>.
AddStringItem returns the index of the new item, where the first item in the list has an index of 0.
!!}
function TIEIPTCInfoList.AddStringItem(ARecordNumber: integer; ADataSet: integer; Value: AnsiString): integer;
var
  pinfo: PIPTCInfo;
  xbuffer: PAnsiChar;
begin
  getmem(xbuffer, length(Value));
  copymemory(xbuffer, PAnsiChar(Value), length(Value));
  result := fBuffer.Add(xbuffer);
  new(pinfo);
  pinfo^.fRecord := ARecordNumber;
  pinfo^.fDataSet := ADataSet;
  pinfo^.fLength := length(Value);
  fInfo.Add(pinfo);
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.AddBufferItem

<FM>Declaration<FC>
function AddBufferItem(RecordNumber:integer; DataSet:integer; Buffer:pointer; BufferLength:integer):integer;

<FM>Description<FN>
Adds a memory buffer (non-textual information) with specified <FC>RecordNumber<FN> and <FC>DataSet<FN>.
AddBufferItem returns the index of the new item, where the first item in the list has an index of 0.
!!}
function TIEIPTCInfoList.AddBufferItem(ARecordNumber: integer; ADataSet: integer; Buffer: pointer; BufferLength: integer): integer;
var
  pinfo: PIPTCInfo;
  xbuffer: pointer;
begin
  getmem(xbuffer, BufferLength);
  copymemory(xbuffer, Buffer, BufferLength);
  result := fBuffer.Add(xbuffer);
  new(pinfo);
  pinfo^.fRecord := ARecordNumber;
  pinfo^.fDataSet := ADataSet;
  pinfo^.fLength := BufferLength;
  fInfo.Add(pinfo);
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.InsertStringItem

<FM>Declaration<FC>
procedure InsertStringItem(idx:integer; RecordNumber:integer; DataSet:integer; Value:AnsiString);

<FM>Description<FN>
Call InsertStringItem to add item to the middle of the item array. The <FC>idx<FN> parameter is a zero-based index.
!!}
procedure TIEIPTCInfoList.InsertStringItem(idx: integer; ARecordNumber: integer; ADataSet: integer; Value: AnsiString);
var
  pinfo: PIPTCInfo;
  xbuffer: pointer;
begin
  getmem(xbuffer, length(Value));
  copymemory(xbuffer, PAnsiChar(Value), length(Value));
  fBuffer.Insert(idx, xbuffer);
  new(pinfo);
  pinfo^.fRecord := ARecordNumber;
  pinfo^.fDataSet := ADataSet;
  pinfo^.fLength := length(Value);
  fInfo.Insert(idx, pinfo);
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Removes all items.
!!}
procedure TIEIPTCInfoList.Clear;
var
  i:integer;
begin
  for i:=0 to fInfo.Count-1 do
  begin
    dispose(PIPTCInfo(fInfo[i]));
    freemem(fBuffer[i]);
  end;
  fInfo.Clear;
  fBuffer.Clear;

  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.IndexOf

<FM>Declaration<FC>
function IndexOf(RecordNumber:integer; DataSet:integer):integer;

<FM>Description<FN>
Finds the first item that matches with <FC>RecordNumber<FN> and <FC>DataSet<FN> parameters and returns its index.
If the item is not in the list, IndexOf returns -1.
!!}
function TIEIPTCInfoList.IndexOf(ARecordNumber: integer; ADataSet: integer): integer;
begin
  for result := 0 to fInfo.Count - 1 do
    with PIPTCInfo(fInfo[result])^ do
      if (fRecord = ARecordNumber) and (fDataSet = ADataSet) then
        exit;
  result := -1;
end;

{!!
<FS>TIEIPTCInfoList.DeleteItem

<FM>Declaration<FC>
procedure DeleteItem(idx:integer);

<FM>Description<FN>
Removes the item <FC>idx<FN>.
!!}
procedure TIEIPTCInfoList.DeleteItem(idx: integer);
begin
  dispose(PIPTCInfo(fInfo[idx]));
  fInfo.Delete(idx);
  freemem(fBuffer[idx]);
  fBuffer.Delete(idx);
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.Assign

<FM>Declaration<FC>
procedure Assign(Source: <A TIEIPTCInfoList>);

<FM>Description<FN>
Copies all items from <FC>Source<FN>.
!!}
procedure TIEIPTCInfoList.Assign(Source: TIEIPTCInfoList);
var
  q: integer;
begin
  if assigned(Source) then
  begin
    Clear;
    for q := 0 to Source.Count - 1 do
      AddBufferItem(Source.RecordNumber[q], Source.DataSet[q], Source.fBuffer[q], PIPTCInfo(Source.fInfo[q])^.fLength);
    fUserChanged := true;
  end;
end;

{!!
<FS>TIEIPTCInfoList.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream: TStream);

<FM>Description<FN>
Saves IPTC info in the <FC>Stream<FN>. Do not use this method to embed IPTC info inside image files.
!!}
procedure TIEIPTCInfoList.SaveToStream(Stream: TStream);
var
  q, v: integer;
begin
  v := 0;
  Stream.Write(v, sizeof(integer)); // version
  v := fInfo.Count;
  Stream.Write(v, sizeof(integer)); // count
  for q := 0 to fInfo.Count - 1 do
  begin
    Stream.Write(PIPTCInfo(fInfo[q])^, sizeof(TIPTCInfo));
    Stream.Write(pbyte(fBuffer[q])^, PIPTCInfo(fInfo[q])^.fLength);
  end;
end;

{!!
<FS>TIEIPTCInfoList.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream: TStream);

<FM>Description<FN>
Loads all IPTC info from stream. This method cannot load IPTC embedded in image formats.
!!}
procedure TIEIPTCInfoList.LoadFromStream(Stream: TStream);
var
  q, v: integer;
  info: TIPTCInfo;
  xbuffer: pbyte;
begin
  Clear;
  Stream.Read(v, sizeof(integer)); // version
  Stream.Read(v, sizeof(integer)); // count
  for q := 0 to v - 1 do
  begin
    Stream.Read(info, sizeof(TIPTCInfo));
    getmem(xbuffer, info.fLength);
    Stream.Read(xbuffer^, info.fLength);
    AddBufferItem(info.fRecord, info.fDataSet, xbuffer, info.fLength);
    freemem(xbuffer);
  end;
  fUserChanged := true;
end;

{!!
<FS>TIEIPTCInfoList.SaveToStandardBuffer

<FM>Declaration<FC>
procedure SaveToStandardBuffer(var Buffer: pointer; var BufferLength: integer; WriteHeader: boolean);

<FM>Description<FN>
Saves IPTC in a buffer. You have to free the buffer.
This method is used to embed IPTC info inside an image file.
!!}
// Buffer is allocated by SaveToStandardBuffer
procedure TIEIPTCInfoList.SaveToStandardBuffer(var Buffer: pointer; var BufferLength: integer; WriteHeader: boolean);
const
  psheader: PAnsiChar = (*0*) 'Photoshop 3.0' + #0 + (*14*) '8BIM' + (*18*) #4#4 + (*20*) #0#0 + (*22*) #0#0#0#0;
  psheader2: PAnsiChar = #28#2#0#0#2#0#2;
var
  q: integer;
  ms: TMemoryStream;
  l, tl: dword;
  b: byte;
begin
  if fInfo.Count = 0 then
  begin
    Buffer := nil;
    BufferLength := 0;
  end
  else
  begin
    ms := TMemoryStream.Create;

    if WriteHeader then
      // good for Jpegs
      ms.Write(psheader^, 26) // PhotoShop 3.0 marker
    else
      // good for TIFF
      ms.Write(psheader2^, 7); // marker for TIFFs

    tl := 0;
    for q := 0 to fInfo.Count - 1 do
    begin
      with PIPTCInfo(fInfo[q])^ do
      begin
        if ((fRecord = 2) and (fDataSet = 0)) or (fLength = 0) then
          continue;
        b := $1C;
        ms.Write(b, 1); // tag marker
        b := fRecord;
        ms.Write(b, 1); // recnum
        b := fDataSet;
        ms.Write(b, 1); // dataset
        l := fLength;
        if l > 32767 then
        begin
          // long
          b := 0;
          ms.Write(b, 1); // length of data field count field (hi)
          b := 4;
          ms.Write(b, 1); // length of data field count field (lo)
          b := (l and $FF000000) shr 24;
          ms.Write(b, 1); // data length
          b := (l and $00FF0000) shr 16;
          ms.Write(b, 1);
          b := (l and $0000FF00) shr 8;
          ms.Write(b, 1);
          b := (l and $000000FF);
          ms.Write(b, 1);
          inc(tl, 3 + 6 + l);
        end
        else
        begin
          // short
          b := (l and $0000FF00) shr 8;
          ms.Write(b, 1); // data length
          b := (l and $000000FF);
          ms.Write(b, 1);
          inc(tl, 3 + 2 + l);
        end;
        ms.Write(pbyte(fBuffer[q])^, l);
      end;
    end;
    BufferLength := ms.Size;
    if (BufferLength and $1) <> 0 then
    begin
      inc(BufferLength);
      b := 0;
      ms.Write(b, 1);
    end;
    getmem(Buffer, BufferLength);
    copymemory(Buffer, ms.Memory, BufferLength);

    if WriteHeader then
    begin
      pbytearray(Buffer)^[22] := (tl and $FF000000) shr 24;
      pbytearray(Buffer)^[23] := (tl and $00FF0000) shr 16;
      pbytearray(Buffer)^[24] := (tl and $0000FF00) shr 8;
      pbytearray(Buffer)^[25] := (tl and $000000FF);
    end;

    FreeAndNil(ms);
  end;
end;

{!!
<FS>TIEIPTCInfoList.LoadFromStandardBuffer

<FM>Declaration<FC>
function LoadFromStandardBuffer(Buffer: pointer; BufferLength: integer):boolean;

<FM>Description<FN>
Loads IPTC from the specified buffer. Used to extract IPTC info from an image file.
!!}
function TIEIPTCInfoList.LoadFromStandardBuffer(Buffer: pointer; BufferLength: integer):boolean;
var
  pc: PAnsiChar;
  ps: integer;
  dataset, recnum: integer;
  len: integer;
begin

  result:=false;

  Clear;
  if BufferLength=0 then
    exit;
  pc := PAnsiChar(Buffer);
  ps := 0;

  // 2.3.0
  if CompareMem(pc,PAnsiChar('Photoshop 3.0'),13) then
    while (ps<BufferLength) do
      if CompareMem(@pc[ps],PAnsiChar('8BIM'#4#4),6) then
      begin
        inc(ps,6);
        break;
      end
      else
        inc(ps);

  while (ps < BufferLength) do
    if (pc[ps] = AnsiChar($1C)) then
      break
    else
      inc(ps);
  // 2.2.4
  while (ps+1 < BufferLength) do
    if (pc[ps+1] <> AnsiChar($1C)) then
      break
    else
      inc(ps);

  repeat
    if pc[ps] <> AnsiChar($1C) then
      break;
    inc(ps);
    if (ps + 4) >= BufferLength then
      break;
    recnum := integer(pc[ps]);
    inc(ps);
    dataset := integer(pc[ps]);
    inc(ps);
    if (byte(pc[ps]) and $80) <> 0 then
    begin
      // long tag
      len := (integer(pc[ps + 2]) shl 24) + (integer(pc[ps + 3]) shl 16) +
        (integer(pc[ps + 4]) shl 8) + (integer(pc[ps + 5]));
      inc(ps, 6);
    end
    else
    begin
      // short tag
      len := (integer(pc[ps]) shl 8) or integer(pc[ps + 1]);
      inc(ps, 2);
    end;
    len := abs(len);
    if (ps + len) > BufferLength then
      break;
    AddBufferItem(recnum, dataset, @(pc[ps]), len);
    inc(ps, len);
    result:=true; // at least one tag loaded
  until ps >= BufferLength;
  fUserChanged := false; // the user should not call LoadFromStandardBuffer, then this is not an user changement
end;

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
// TIERecordList

constructor TIERecordList.CreateList(RecordSize: integer);
begin
  inherited Create;
  fItemSize := RecordSize;
end;

function TIERecordList.GetItem(idx: integer): pointer;
begin
  result := BaseGetItem(idx);
end;

procedure TIERecordList.SetItem(idx: integer; v: pointer);
begin
  BaseSetItem(idx, v);
end;

function TIERecordList.Add(v: pointer): integer;
begin
  result := AddItem(v);
end;

procedure TIERecordList.Insert(idx: integer; v: pointer);
begin
  InsertItem(idx, v);
end;

function TIERecordList.IndexOf(v: pointer): integer;
begin
  result := IndexOfItem(v);
end;

////////////////////////////////////////////////////////////////////////////////////////

function IEFloor(X: extended): Integer;
begin
  Result := Integer(trunc(X));
  if Frac(X) < 0 then
    Dec(Result);
end;

// point to point distance

function _DistPoint2Point(x1, y1, x2, y2: integer): double;
begin
  result := sqrt(sqr(x2 - x1) + sqr(y2 - y1));
end;

// point to line distance
function _DistPoint2Line(xp, yp, x1, y1, x2, y2: integer): double;
var
  a, b, c: double;  // leave a,b,c as double (not integers! otherwise an overflow could occur)
begin
  a := y1 - y2;
  b := x2 - x1;
  c := x1 * y2 - x2 * y1;
  result := abs(a * xp + b * yp + c) / sqrt(a * a + b * b);
end;

// Point<->Segment distance
function _DistPoint2Seg(xp, yp, x1, y1, x2, y2: integer): double;
var
  r: double;
begin
  result := 1000000;
  try
    if (x1 = x2) and (y1 = y2) then
      result := sqrt(sqr(xp - x1) + sqr(yp - y1))
    else
    begin
      r := ((y1 - yp) * (y1 - y2) - (x1 - xp) * (x2 - x1)) / (sqr(x2 - x1) + sqr(y2 - y1)); // 2.2.4rc2
      if r > 1 then
      begin
        // distance from xp,yp to x2,y2
        if abs(xp - x2) > 45000 then
          exit;
        if abs(yp - y2) > 45000 then
          exit;
        result := sqrt(sqr(xp - x2) + sqr(yp - y2));
      end
      else if r < 0 then
      begin
        // distance from xp,yp to x1,y1
        if abs(x1 - xp) > 45000 then
          exit;
        if abs(y1 - yp) > 45000 then
          exit;
        result := sqrt(sqr(x1 - xp) + sqr(y1 - yp))
      end
      else
      begin
        // distance from the line
        result := _DistPoint2Line(xp, yp, x1, y1, x2, y2);
      end;
    end;
  except
  end;
end;

function _DistPoint2Polyline(x, y: integer; PolyPoints: PPointArray; PolyPointsCount: integer; ToSubX, ToSubY, ToAddX, ToAddY: integer; ToMulX, ToMulY: double; penWidth:integer; closed:boolean): double;
var
  i: integer;
  d: double;
  x1, y1, x2, y2: integer;

  procedure comp;
  var
    j,k:integer;
  begin
    d := _DistPoint2Seg(x, y, x1, y1, x2, y2);
    if penWidth > 1 then
      for j:=-penWidth div 2 to penWidth div 2 do
        for k:=2 to penWidth div 2 do
        begin
          d := dmin(d, _DistPoint2Seg(x, y, x1+j, y1+k, x2+j, y2+k));
        end;
    if d < result then
      result := d;
    iswap(x1, x2);
    iswap(y1, y2);
  end;

begin
  result := 1000000;
  if PolyPointsCount > 0 then
  begin
    x1 := round((PolyPoints^[0].x - ToSubX) * ToMulX + ToAddX);
    y1 := round((PolyPoints^[0].y - ToSubY) * ToMulY + ToAddY);
    for i := 1 to PolyPointsCount - 1 do
    begin
      x2 := round((PolyPoints^[i].x - ToSubX) * ToMulX + ToAddX);
      y2 := round((PolyPoints^[i].y - ToSubY) * ToMulY + ToAddY);
      comp;
    end;
    if closed then
    begin
      x2 := round((PolyPoints^[0].x - ToSubX) * ToMulX + ToAddX);
      y2 := round((PolyPoints^[0].y - ToSubY) * ToMulY + ToAddY);
      comp;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEScrollBarParams

constructor TIEScrollBarParams.Create;
begin
  inherited Create;
  fLineStep := -1;
  fPageStep := -1;
  fTracking := true;
end;

destructor TIEScrollBarParams.Destroy;
begin
  inherited;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

constructor TIEMouseWheelParams.Create;
begin
  inherited Create;
  InvertDirection := false;
  Action := iemwZoom;
  Variation := iemwPercentage;
  Value := 8;
  ZoomPosition := iemwCenter;
end;

destructor TIEMouseWheelParams.Destroy;
begin
  inherited;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

// check if mmx available

function IEMMXSupported: bytebool;
begin
  result := false;
  asm
     	push ebx
		// check if the cpuid instruction is available
      pushfd
      pushfd
      pop    eax
      mov    ecx, eax
      xor    eax, 200000h
      push   eax
      popfd
      pushfd
      pop    eax
      popfd
      xor    eax, ecx
      jz @nocpuid
      // cpuid supported, check MMX
      mov eax, 1
      Dw $A20F	// CPUID
      test edx, 800000h
      setnz result
   @nocpuid:
      pop ebx
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEMask class

constructor TIEMask.Create;
begin
  inherited;
  fFull := false;
  fWidth := 0;
  fHeight := 0;
  fBitsperpixel := 0;
  fRowlen := 0;
  fBits := nil;
  fX1 := 2147483647;
  fY1 := 2147483647;
  fX2 := 0;
  fY2 := 0;
  //
  ZeroMemory(@fBitmapInfoHeader1, sizeof(TBitmapInfoHeader256));
  with fBitmapInfoHeader1 do
  begin
    biSize := sizeof(TBitmapInfoHeader);
    biPlanes := 1;
    biBitCount := 1;
    Palette[1].rgbRed := 255;
    Palette[1].rgbGreen := 255;
    Palette[1].rgbBlue := 255;
    biCompression := BI_RGB;
  end;
  fTmpBmp := nil;
  fTmpBmpScanline := nil;
  fTmpBmpWidth := 0;
  fTmpBmpHeight := 0;
  fDrawPixelBitmap:=TBitmap.Create;
  fDrawPixelBitmap.Width:=1;
  fDrawPixelBitmap.Height:=1;
  fDrawPixelBitmap.PixelFormat:=pf24bit;
  fDrawPixelPtr:=PRGB(fDrawPixelBitmap.Scanline[0]);
end;

destructor TIEMask.Destroy;
begin
  fDrawPixelBitmap.Free;
  FreeBits;
  inherited;
end;

function TIEMask.CreateResampledMask(NewWidth,NewHeight:integer):TIEMask;
var
  x, y, sx: integer;
  zx, zy: double;
  sxarr: pintegerarray;
  d_g, s_g, bp: pbyte;
  s_ga: pbytearray;
begin
  result:=TIEMask.Create;
  result.AllocateBits(NewWidth,NewHeight,fBitsperpixel);
  zx := Width / result.Width;
  zy := Height / result.Height;
  getmem(sxarr, sizeof(integer) * result.Width);
  for x := 0 to result.Width - 1 do
    sxarr[x] := trunc(x * zx);
  case fBitsperpixel of
    1:
      for y := 0 to result.Height - 1 do
      begin
        s_g := Scanline[trunc(y * zy)];
        d_g := result.Scanline[y];
        for x := 0 to result.Width - 1 do
        begin
          sx := sxarr[x];
          bp := pbyte(int64(DWORD(d_g)) + (int64(x) shr 3));
          if (pbytearray(s_g)^[sx shr 3] and iebitmask1[sx and $7]) <> 0 then
            bp^ := bp^ or iebitmask1[x and 7]
          else
            bp^ := bp^ and not iebitmask1[x and 7];
        end;
      end;
    8:
      for y := 0 to result.Height - 1 do
      begin
        s_ga := Scanline[trunc(y * zy)];
        d_g := result.Scanline[y];
        for x := 0 to result.Width - 1 do
        begin
          d_g^ := s_ga[sxarr[x]];
          inc(d_g);
        end;
      end;
  end;
  freemem(sxarr);
  if not IsEmpty then
  begin
    result.fX1:=trunc(fX1/zx);
    result.fY1:=trunc(fY1/zy);
    result.fX2:=trunc(fX2/zx);
    result.fY2:=trunc(fY2/zy);
  end;
  result.fFull:=fFull;
end;

{!!
<FS>TIEMask.Assign

<FM>Declaration<FC>
procedure Assign(Source:<A TIEMask>);

<FM>Description<FN>
Assigns Source mask.
!!}
procedure TIEMask.Assign(Source: TIEMask);
begin
  if assigned(Source) then
  begin
    AllocateBits(Source.fWidth, Source.fHeight, Source.fBitsPerPixel);
    copymemory(fBits, Source.fBits, fRowlen * fHeight);
    fX1 := Source.fX1;
    fY1 := Source.fY1;
    fX2 := Source.fX2;
    fY2 := Source.fY2;
    fFull := Source.fFull;
  end;
end;

{!!
<FS>TIEMask.SetPixel

<FM>Declaration<FC>
procedure SetPixel(x,y:integer; Alpha:integer);

<FM>Description<FN>
Set a single pixel selection at x,y coordinates. A pixel with mask 1 or >0 is selected.
!!}
// set mask pixel
// supported bitsperpixel: 1, 8
// Alpha for 1bpp:
//     1 = over image is fully visible (for selections: the region is selected)
//     0 = over image is not visible (for selections: the region is not selected)
// Alpha for 8bpp:
//     255 = over image si fully visible
//     ...
//     0 = over image is not visible
procedure TIEMask.SetPixel(x, y: integer; Alpha: integer);
begin
  if (x >= fWidth) or (y >= fHeight) or (x < 0) or (y < 0) then
    exit;
  if Alpha <> 0 then
  begin
    if x < fX1 then
      fX1 := x;
    if x > fX2 then
      fX2 := x;
    if y < fY1 then
      fY1 := y;
    if y > fY2 then
      fY2 := y;
    if fX1 < 0 then
      fX1 := 0;
    if fX2 >= fWidth then
      fX2 := fWidth - 1;
    if fY1 < 0 then
      fY1 := 0;
    if fY2 >= fHeight then
      fY2 := fHeight - 1;
  end;
  if fFull then
    fFull := not ((fBitsPerPixel = 8) and (Alpha <> 255)) or ((fBitsPerPixel = 1) and (Alpha = 0));
  case fBitsperpixel of
    1:
      begin
        // 1 bit per pixel
        SetPixelbw_inline(pbyte(int64(DWORD(fBits)) + (fHeight - y - 1) * fRowlen), x, Alpha);
      end;
    8:
      begin
        // 8 bits per pixel
        pbyte(int64(DWORD(fBits)) + (fHeight - y - 1) * fRowlen + x)^ := Alpha;
      end;
  end;
end;



{!!
<FS>TIEMask.SyncRect

<FM>Declaration<FC>
procedure SyncRect;

<FM>Description<FN>
Adjusts <A TIEMask.X1>, <A TIEMask.Y1>, <A TIEMask.X2> and <A TIEMask.Y2> to enclose the bounding box of the selected pixels.
!!}
procedure TIEMask.SyncRect;

  procedure SetRect(x, y:integer; var fX1, fY1, fX2, fY2:integer; fWidth, fHeight:integer); {$ifdef IESUPPORTINLINE} inline; {$endif}
  begin
    if x < fX1 then
      fX1 := x;
    if x > fX2 then
      fX2 := x;
    if y < fY1 then
      fY1 := y;
    if y > fY2 then
      fY2 := y;
    if fX1 < 0 then
      fX1 := 0;
    if fX2 >= fWidth then
      fX2 := fWidth - 1;
    if fY1 < 0 then
      fY1 := 0;
    if fY2 >= fHeight then
      fY2 := fHeight - 1;
  end;

var
  y, x: integer;
  px: pbyte;
begin
  fX1 := 2147483647;
  fY1 := 2147483647;
  fX2 := 0;
  fY2 := 0;
  for y := 0 to fHeight - 1 do
  begin
    case fBitsPerPixel of
      1:
        for x := 0 to fWidth - 1 do
          if GetPixelbw_inline(pbyte(int64(DWORD(fBits)) + (fHeight - y - 1) * fRowlen), x) <> 0 then
            SetRect(x, y, fX1, fY1, fX2, fY2, fWidth, fHeight);
      8:
        begin
          px := Scanline[y];
          for x := 0 to fWidth - 1 do
          begin
            if px^ <> 0 then
              SetRect(x, y, fX1, fY1, fX2, fY2, fWidth, fHeight);
            inc(px);
          end;
        end;
    end;
  end;
end;

{!!
<FS>TIEMask.GetPixel

<FM>Declaration<FC>
function GetPixel(x, y:integer):integer;

<FM>Description<FN>
Return the value of the pixel at x,y coordinates.
!!}
// get mask pixel
// supported bitsperpixel: 1, 8
// Value for 1bpp:
//     1 = over image is fully visible (for selections: the region is selected)
//     0 = over image is not visible (for selections: the region is not selected)
// Value for 8bpp:
//     255 = over image si fully visible
//     ...
//     0 = over image is not visible
function TIEMask.GetPixel(x, y: integer): integer;
begin
  if (x >= fWidth) or (y >= fHeight) or (x < 0) or (y < 0) then
    result := 0
  else
    case fBitsperpixel of
      1:
        begin
          // 1 bit per pixel
          result := GetPixelbw_inline(pbyte(int64(DWORD(fBits)) + (fHeight - y - 1) * fRowlen), x);
        end;
      8:
        begin
          // 8 bits per pixel
          result := pbyte(int64(DWORD(fBits)) + (fHeight - y - 1) * fRowlen + x)^;
        end;
    else
      result := 0;
    end;
end;

{!!
<FS>TIEMask.IsPointInside

<FM>Declaration<FC>
function IsPointInside(x,y:integer):boolean;

<FM>Description<FN>
Return true if the x,y pixel is not 0.
!!}
// return true if the x,y point is inside non zero mask
function TIEMask.IsPointInside(x, y: integer): boolean;
begin
  result := GetPixel(x, y) <> 0;
end;

{!!
<FS>TIEMask.AllocateBits

<FM>Declaration<FC>
procedure AllocateBits(width,height:integer; bitsperpixel:integer);

<FM>Description<FN>
Allocates memory for the map.
Memory is zero filled.
<FC>bitsperpixel<FN> can be 1 or 8.
!!}
// allocate Mask (and free previous)
// memory is initialized to zero
procedure TIEMask.AllocateBits(width, height: integer; bitsperpixel: integer);
begin
  FreeBits;
  fWidth := width;
  fHeight := height;
  fBitsperpixel := bitsperpixel;
  fRowlen := IEBitmapRowLen(width, fBitsPerPixel, 32);
  fBits := allocmem(height * fRowlen);
  fX1 := 2147483647;
  fY1 := 2147483647;
  fX2 := 0;
  fY2 := 0;
  fFull := false;
end;

{!!
<FS>TIEMask.Resize

<FM>Declaration<FC>
procedure Resize(NewWidth, NewHeight: integer);

<FM>Description<FN>
Resizes this selection map.
!!}
procedure TIEMask.Resize(NewWidth, NewHeight: integer);
var
  lBits, ps, pd: pbyte;
  lRowLen, y, rl: integer;
  h:integer;
begin
  lBits := fBits;
  lRowLen := fRowLen;
  fRowLen := IEBitmapRowLen(NewWidth, fBitsPerPixel, 32);
  fBits := allocmem(NewHeight * fRowlen);
  rl := imin(lRowLen, fRowLen);
  ps := pbyte(int64(DWORD(lBits)) + (fHeight - 1) * lRowLen);
  pd := pbyte(int64(DWORD(fBits)) + (NewHeight - 1) * fRowLen);
  h:=imin(fHeight,NewHeight);
  for y := 0 to h - 1 do
  begin
    copymemory(pd, ps, rl);
    dec(ps, lRowLen);
    dec(pd, fRowLen);
  end;
  freemem(lBits);
  fWidth := NewWidth;
  fHeight := NewHeight;
  if fX1 < fX2 then
  begin
    fX1 := imin(fX1, fWidth - 1);
    fY1 := imin(fY1, fHeight - 1);
    fX2 := imin(fX2, fWidth - 1);
    fY2 := imin(fY2, fHeight - 1);
  end;
end;

{!!
<FS>TIEMask.FreeBits

<FM>Declaration<FC>
procedure FreeBits;

<FM>Description<FN>
Free the allocated mask.
!!}
procedure TIEMask.FreeBits;
begin
  if fTmpBmp <> nil then
  begin
    freemem(fTmpBmp);
    freemem(fTmpBmpScanline);
  end;
  fTmpBmp := nil;
  fTmpBmpScanline := nil;
  fTmpBmpWidth := 0;
  fTmpBmpHeight := 0;

  if fBits <> nil then
    freemem(fBits);
  fBits := nil;
  fWidth := 0;
  fHeight := 0;
  fBitsperpixel := 0;
  fRowlen := 0;
end;

{!!
<FS>TIEMask.InvertCanvas

<FM>Declaration<FC>
procedure InvertCanvas(Dest: TCanvas; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer);

<FM>Description<FN>
For internal use only.
!!}
// Inverts pixels of Dest rect, stretching mask rect
// Only with fBitsPerPixel=1
procedure TIEMask.InvertCanvas(Dest: TCanvas; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer);
var
  bi: ^TBitmapInfo;
begin
  if (fX1 = 2147483647) or (fY1 = 2147483647) or (fBitsPerPixel <> 1) then
    exit;
  with fBitmapInfoHeader1 do
  begin
    biWidth := fWidth;
    biHeight := fHeight;
  end;
  bi := @fBitmapInfoHeader1;
  StretchDIBits(Dest.Handle, xDst, yDst, dxDst, dyDst, xMask, (fheight - dyMask - yMask), dxMask, dyMask, fBits, bi^, DIB_RGB_COLORS, SRCINVERT);
end;

procedure Stretch(BitsPerPixel: integer; dest: pbyte; dxDst, dyDst, xSrc, ySrc, dxSrc, dySrc: integer; src: pbyte; srcWidth, srcHeight: integer; fx1, fy1, fx2, fy2: integer);
var
  rx, ry, sy: integer;
  y2, x2: integer;
  x, y: integer;
  px1, px2, px3: pbyte;
  destRowlen, srcRowLen, sx: integer;
  ffx1, ffy1, ffx2, ffy2: integer;
  zx, zy: double;
  arx, arxp: pinteger;
begin
  if (dxDst < 1) or (dyDst < 1) then
    exit;
  destRowlen := IEBitmapRowLen(dxDst, BitsPerPixel, 32);
  zeromemory(dest, destRowlen * dyDst);
  srcRowLen := IEBitmapRowLen(srcWidth, BitsPerPixel, 32);
  ry := trunc((dySrc / dyDst) * 16384); // 2^14
  rx := trunc((dxSrc / dxDst) * 16384);
  y2 := dyDst - 1;
  x2 := dxDst - 1;
  zx := dxDst / dxSrc;
  zy := dyDst / dySrc;
  ffy1 := imax(trunc(zy * (fy1 - ySrc)), 0);
  ffx1 := imax(trunc(zx * (fx1 - xSrc)), 0);
  ffy2 := imin(trunc(zy * (fy2 - ySrc + 1)), y2);
  ffx2 := imin(trunc(zx * (fx2 - xSrc + 1)), x2);
  if (ffx2-ffx1+1)<=0 then
    exit;
  zeromemory(dest, IEBitmapRowLen(dxDst, BitsPerPixel, 32) * dyDst);
  getmem(arx, sizeof(integer) * (ffx2 - ffx1 + 1));
  arxp := arx;
  for x := ffx1 to ffx2 do
  begin
    arxp^ := ((rx * x) shr 14) + xSrc;
    inc(arxp);
  end;
  for y := ffy1 to ffy2 do
  begin
    px2 := pbyte(int64(DWORD(dest)) + (dyDst - y - 1) * destRowlen);
    sy := imin( SrcHeight-1, ((ry * y) shr 14) + ySrc );  // 3.0.1
    px1 := pbyte(int64(DWORD(src)) + (srcHeight - sy - 1) * srcRowlen);
    arxp := arx;
    case BitsPerPixel of
      1:
        begin
          for x := ffx1 to ffx2 do
          begin
            if (pbytearray(px1)^[arxp^ shr 3] and iebitmask1[arxp^ and $7]) <> 0 then
            begin
              px3 := @(pbytearray(px2)^[x shr 3]);
              px3^ := px3^ or iebitmask1[x and 7]; // to 1
            end;
            inc(arxp);
          end;
        end;
      8:
        begin
          for x := ffx1 to ffx2 do
          begin
            pbytearray(px2)^[x] := pbytearray(px1)^[arxp^];
            inc(arxp);
          end;
        end;
    end;
  end;
  freemem(arx);
end;

{!!
<FS>TIEMask.DrawOutline

<FM>Declaration<FC>
procedure DrawOutline(Dest: TCanvas; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer; AniCounter: integer; Color1, Color2: TColor; actualRect:PRect = nil);

<FM>Description<FN>
For internal use only.
!!}
procedure TIEMask.DrawOutline(Dest: TCanvas; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer; AniCounter: integer; Color1, Color2: TColor; actualRect:PRect);
var
  row, col, x, y: integer;
  px, px2: pbyte;
  rowlo, rowhi, collo, colhi: integer;
  zx, zy: integer;
  c1, c2: integer;
  crgb: array[false..true] of TRGB;
  rgb: TRGB;
  xx, yy: integer;
  row1, row2: integer;
  //
  procedure DrawPix;
  var
    y: integer;
  begin
    xx := col + xDst;
    rgb := crgb[(((xx + yy + AniCounter) and 7) < 4)];
    if col = 0 then
    begin
      x := ((col * zx) shr 14) + xMask;
      if (x <= fX1) then
      begin
        fDrawPixelPtr^:=rgb;
        Dest.Draw(xx,yy,fDrawPixelBitmap);
      end;
    end
    else if col = colhi then
    begin
      x := ((col * zx) shr 14) + xMask;
      if (x >= fX2) or (dxMask = Width) then
      begin
        fDrawPixelPtr^:=rgb;
        Dest.Draw(xx,yy,fDrawPixelBitmap);
      end;
    end
    else if row = 0 then
    begin
      y := ((row * zy) shr 14) + yMask;
      if (y <= fY1) then
      begin
        fDrawPixelPtr^:=rgb;
        Dest.Draw(xx,yy,fDrawPixelBitmap);
      end;
    end
    else if row = rowhi then
    begin
      y := ((row * zy) shr 14) + yMask;
      if (y >= fY2) or (dyMask = Height) then
      begin
        fDrawPixelPtr^:=rgb;
        Dest.Draw(xx,yy,fDrawPixelBitmap);
      end;
    end
    else
    begin
      case fBitsPerPixel of
        1:
          begin
            c1 := 13 - ((col - 1) and 7);
            c2 := (col - 1) shr 3;
            for y := row1 to row2 do
            begin
              // read 3 pixels at the time
              px2 := pbyte(int64(DWORD(fTmpBmpScanline[y])) + int64(c2));
              if ((IESwapWord(pword(px2)^) shr c1) and 7) < 7 then
              begin
                fDrawPixelPtr^:=rgb;
                Dest.Draw(xx,yy,fDrawPixelBitmap);
                break;
              end;
            end;
          end;
        8:
          for y := row1 to row2 do
          begin
            px2 := pbyte(int64(DWORD(fTmpBmpScanline[y])) + int64(col - 1));
            if px2^ = 0 then
            begin
              fDrawPixelPtr^:=rgb;
              Dest.Draw(xx,yy,fDrawPixelBitmap);
            end;
            inc(px2);
            if px2^ = 0 then
            begin
              fDrawPixelPtr^:=rgb;
              Dest.Draw(xx,yy,fDrawPixelBitmap);
            end;
            inc(px2);
            if px2^ = 0 then
            begin
              fDrawPixelPtr^:=rgb;
              Dest.Draw(xx,yy,fDrawPixelBitmap);
            end;
          end;
      end;
    end;
  end;
  //
begin
  if (dxDst < 1) or (dyDst < 1) or (fX1 = 2147483647) or (fY1 = 2147483647) then
    exit;

  crgb[false] := TColor2TRGB(Color1);
  crgb[true] := TColor2TRGB(Color2);
  if (fTmpBmpWidth <> dxDst) or (fTmpBmpHeight <> dyDst) then
  begin
    fTmpBmpWidth := dxDst;
    fTmpBmpHeight := dyDst;
    row := IEBitmaprowlen(dxDst, fBitsPerPixel, 32);
    if fTmpBmp <> nil then
    begin
      freemem(fTmpBmp);
      freemem(fTmpBmpScanline);
    end;
    getmem(fTmpBmp, row * dyDst);
    getmem(fTmpBmpScanline, sizeof(pointer) * dyDst);
    for y := 0 to dyDst - 1 do
      fTmpBmpScanline[y] := pointer(int64(DWORD(fTmpBmp)) + (dyDst - y - 1) * row);
  end;
  Stretch(fBitsPerPixel, fTmpBmp, dxDst, dyDst, xMask, yMask, dxMask, dyMask, fBits, fWidth, fHeight, fx1, fy1, fx2, fy2);
  zx := trunc((dxMask / dxDst) * 16384);
  zy := trunc((dyMask / dyDst) * 16384);
  rowlo := imax(((fY1 - yMask) * 16384 div zy), 0);
  rowhi := imin(((fY2 - yMask + 1) * 16384 div zy) + 1, (dyDst - 1));
  collo := imax(((fX1 - xMask) * 16384 div zx), 0);
  colhi := imin(((fX2 - xMask + 1) * 16384 div zx) + 1, (dxDst - 1));
  if assigned(actualRect) then
    actualRect^ := Rect(xDst+collo+1, yDst+rowlo+1, xDst+colhi-1, yDst+rowhi-1);
  // draw outline of the mask
  Dest.Pen.Style := psSolid;
  Dest.Pen.Mode := pmCopy;
  for row := rowlo to rowhi do
  begin
    px := fTmpBmpScanline[row];
    yy := row + yDst;
    row1 := imax(row - 1, 0);
    row2 := imin(row + 1, dyDst - 1);
    case fBitsPerPixel of
      1:
        for col := collo to colhi do
        begin
          if (pbytearray(px)^[col shr 3] and iebitmask1[col and $7]) <> 0 then
            DrawPix;
        end;
      8:
        for col := collo to colhi do
        begin
          if pbytearray(px)^[col] <> 0 then
            DrawPix;
        end;
    end;
  end;
end;

{!!
<FS>TIEMask.DrawOuter

<FM>Declaration<FC>
procedure DrawOuter(Dest: TBitmap; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer; AlphaBlend:integer; Color:TColor);

<FM>Description<FN>
For internal use only.
!!}
procedure TIEMask.DrawOuter(Dest: TBitmap; xDst, yDst, dxDst, dyDst: integer; xMask, yMask, dxMask, dyMask: integer; AlphaBlend:integer; Color:TColor);
var
  row, col, y, dw, dh: integer;
  px: pbyte;
  rowlo, rowhi, collo, colhi: integer;
  zx, zy: integer;
  dzx,dzy:double;
  pxd: PRGB;
  clr: TRGB;
  alp: double;
begin
  if (dxDst < 1) or (dyDst < 1) or (fX1 = 2147483647) or (fY1 = 2147483647) then
    exit;

  if yDst<0 then
  begin
    dzy:=dyMask/dyDst;
    dyDst:=dyDst-yDst;
    dyMask:=dyMask-round(yDst*dzy);
    yMask:=yMask-round(yDst*dzy);
    yDst:=0;
  end;
  if xDst<0 then
  begin
    dzx:=dxMask/dxDst;
    dxDst:=dxDst-xDst;
    dxMask:=dxMask-round(xDst*dzx);
    xMask:=xMask-round(xDst*dzx);
    xDst:=0;
  end;

  if (fTmpBmpWidth <> dxDst) or (fTmpBmpHeight <> dyDst) then
  begin
    fTmpBmpWidth := dxDst;
    fTmpBmpHeight := dyDst;
    row := IEBitmaprowlen(dxDst, fBitsPerPixel, 32);
    if fTmpBmp <> nil then
    begin
      freemem(fTmpBmp);
      freemem(fTmpBmpScanline);
    end;
    getmem(fTmpBmp, row * dyDst);
    getmem(fTmpBmpScanline, sizeof(pointer) * dyDst);
    for y := 0 to dyDst - 1 do
      fTmpBmpScanline[y] := pointer(int64(DWORD(fTmpBmp)) + (dyDst - y - 1) * row);
  end;
  Stretch(fBitsPerPixel, fTmpBmp, dxDst, dyDst, xMask, yMask, dxMask, dyMask, fBits, fWidth, fHeight, fx1, fy1, fx2, fy2);
  zx := trunc((dxMask / dxDst) * 16384);
  zy := trunc((dyMask / dyDst) * 16384);
  dw := Dest.Width;
  dh := Dest.Height;
  rowlo := imax(((-yMask) * 16384 div zy), 0);
  rowhi := imin(((Height - yMask) * 16384 div zy) + 1, (dyDst - 1));
  rowhi := imin(rowhi, dh - 1);
  collo := imax(((0 - xMask) * 16384 div zx), 0);
  colhi := imin(((Width - xMask) * 16384 div zx) + 1, (dxDst - 1));
  colhi := imin(colhi, dw - 1);

  clr := TColor2TRGB(Color);
  alp := AlphaBlend / 255;

  for row := rowlo to rowhi do
  begin
    px := fTmpBmpScanline[row];
    pxd := Dest.Scanline[row + yDst];
    inc(pxd, collo + xDst);

    if row+yDst >= Dest.Height then
      break;

    if AlphaBlend=-1 then
    begin
      // just set fixed values
      case fBitsPerPixel of
        1:
          for col := collo to colhi do
          begin
            if collo+xDst+col >= Dest.Width then
              break;
            if (pbytearray(px)^[col shr 3] and iebitmask1[col and $7]) = 0 then
              if (((row and 1) = 0) and ((col and 1) = 0)) or (((row and 1) = 1) and ((col and 1) = 1)) then
                with pxd^ do
                begin
                  r := 97;
                  g := 97;
                  b := 97;
                end;
            inc(pxd);
          end;
        8:
          for col := collo to colhi do
          begin
            if collo+xDst+col >= Dest.Width then
              break;
            if (pbytearray(px)^[col]) = 0 then
              if (((row and 1) = 0) and ((col and 1) = 0)) or (((row and 1) = 1) and ((col and 1) = 1)) then
                with pxd^ do
                begin
                  r := 97;
                  g := 97;
                  b := 97;
                end;
            inc(pxd);
          end;
      end;
    end
    else
    begin
      // use alpha blend
      case fBitsPerPixel of
        1:
          for col := collo to colhi do
          begin
            if collo+xDst+col >= Dest.Width then
              break;
            if (pbytearray(px)^[col shr 3] and iebitmask1[col and $7]) = 0 then
              with pxd^ do
              begin
                r := trunc(clr.r*alp+r*(1-alp));
                g := trunc(clr.g*alp+g*(1-alp));
                b := trunc(clr.b*alp+b*(1-alp));
              end;
            inc(pxd);
          end;
        8:
          for col := collo to colhi do
          begin
            if collo+xDst+col >= Dest.Width then
              break;
            if (pbytearray(px)^[col]) = 0 then
              with pxd^ do
              begin
                r := trunc(clr.r*alp+r*(1-alp));
                g := trunc(clr.g*alp+g*(1-alp));
                b := trunc(clr.b*alp+b*(1-alp));
              end;
            inc(pxd);
          end;
      end;
    end;
  end;
end;

{!!
<FS>TIEMask.CopyBitmap

<FM>Declaration<FC>
procedure CopyBitmap(Dest, Source: TBitmap; dstonlymask, srconlymask: boolean);

<FM>Description<FN>
For internal use only.
!!}
// copy Source in Dest applying mask
// Source and Dest can be pf24bit or pf1bit (must be Source.PixelFormat=Dest.PixelFormat)
// when dstonlymask is false the entire source bitmap is copied to dest
// when dstonlymask is true only the effective mask region is copied to dest
// when srconlymask is false the source has some size of the mask
// when srconlymask is true the source has size of real used mask
procedure TIEMask.CopyBitmap(Dest, Source: TBitmap; dstonlymask, srconlymask: boolean);
var
  row, col: integer;
  px1, px2: PRGB;
  a: integer;
  pb: pbyte;
  ii: int64;
  ox, oy, sx, sy: integer;
begin
  if (fX1 > fX2) and (fY1 > fY2) then
    exit;
  if dstonlymask then
  begin
    ox := fX1;
    oy := fY1;
  end
  else
  begin
    ox := 0;
    oy := 0;
  end;
  if srconlymask then
  begin
    sx := fX1;
    sy := fY1;
  end
  else
  begin
    sx := 0;
    sy := 0;
  end;
  case fBitsperpixel of
    1:
      begin
        // 1 bit per pixel (copy if mask is 1)
        if (Source.PixelFormat = pf24bit) and (Dest.PixelFormat = pf24bit) then
        begin
          // pf24bit
          for row := fY1 to fY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            inc(px1, fX1 - sx);
            px2 := Dest.ScanLine[row - oy];
            inc(px2, fX1 - ox);
            pb := pbyte(int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen);
            for col := fX1 to fX2 do
            begin
              if GetPixelbw_inline(pb, col) <> 0 then
                px2^ := px1^;
              inc(px2);
              inc(px1);
            end;
          end;
        end
        else if (Source.PixelFormat = pf1bit) and (Dest.PixelFormat = pf1bit) then
        begin
          // pf1bit
          for row := fY1 to fY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            px2 := Dest.ScanLine[row - oy];
            pb := pbyte(int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen);
            for col := fX1 to fX2 do
            begin
              if GetPixelbw_inline(pb, col) <> 0 then
                SetPixelbw_inline(pbyte(px2), col - ox, GetPixelbw_inline(pbyte(px1), col - sx));
            end;
          end;
        end;
      end;
    8:
      begin
        // 8 bits per pixel (alpha blend)
        if (Source.PixelFormat = pf24bit) and (Dest.PixelFormat = pf24bit) then
        begin
          // pf24bit
          for row := fY1 to fY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            inc(px1, fX1 - sx);
            px2 := Dest.ScanLine[row - oy];
            inc(px2, fX1 - ox);
            ii := int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen;
            for col := fX1 to fX2 do
            begin
              a := pbyte(ii + col)^ shl 10;
              px2^.r := (a * (px1^.r - px2^.r) shr 18 + px2^.r);
              px2^.g := (a * (px1^.g - px2^.g) shr 18 + px2^.g);
              px2^.b := (a * (px1^.b - px2^.b) shr 18 + px2^.b);
              inc(px2);
              inc(px1);
            end;
          end;
        end
        else if (Source.PixelFormat = pf1bit) and (Dest.PixelFormat = pf1bit) then
        begin
          // pf1bit
          for row := fY1 to fY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            px2 := Dest.ScanLine[row - oy];
            ii := int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen;
            for col := fX1 to fX2 do
            begin
              a := pbyte(ii + col)^;
              if a <> 0 then
                SetPixelbw_inline(pbyte(px2), col - ox, GetPixelbw_inline(pbyte(px1), col - sx));
            end;
          end;
        end;
      end;
  end;
end;

{!!
<FS>TIEMask.CopyIEBitmap

<FM>Declaration<FC>
procedure CopyIEBitmap(Dest, Source: <A TIEBitmap>; dstonlymask, srconlymask: boolean; UseAlphaChannel: boolean);

<FM>Description<FN>
For internal use only.
!!}
// copy Source in Dest applying mask (using TIEBItmap instead of TBitmap)
// Source and Dest can be ie24RGB or ie1g (must be Source.PixelFormat=Dest.PixelFormat)
// when dstonlymask is false the entire source bitmap is copied to dest
// when dstonlymask is true only the actual mask region is copied to dest
// when srconlymask is false the source has same size of the mask
// when srconlymask is true the source has size of actual used mask
// If UseAlphaChannel is true then calls CopyIEBitmapAlpha
procedure TIEMask.CopyIEBitmap(Dest, Source: TIEBitmap; dstonlymask, srconlymask: boolean; UseAlphaChannel: boolean);
var
  row, col: integer;
  px1, px2: PRGB;
  a: integer;
  pb,pb1,pb2: pbyte;
  ii: int64;
  ox, oy, sx, sy: integer;
  nX2,nY2:integer;
begin
  if srconlymask then
  begin
    nX2:=fX1+imin(imin(fX2-fX1,Source.Width-1),Dest.Width-1);   // 2.3.1
    nY2:=fY1+imin(imin(fY2-fY1,Source.Height-1),Dest.height-1); // 2.3.1
  end
  else
  begin
    nX2:=fX2;
    nY2:=fY2;
  end;

  if (fX1 > nX2) and (fY1 > nY2) then
    exit;
  if dstonlymask then
  begin
    ox := fX1;
    oy := fY1;
  end
  else
  begin
    ox := 0;
    oy := 0;
  end;
  if srconlymask then
  begin
    sx := fX1;
    sy := fY1;
  end
  else
  begin
    sx := 0;
    sy := 0;
  end;
  case fBitsperpixel of
    1:
      begin
        // 1 bit per pixel (copy if mask is 1)
        if (Source.PixelFormat = ie24RGB) and (Dest.PixelFormat = ie24RGB) then
        begin
          // ie24RGB
          for row := fY1 to nY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            inc(px1, fX1 - sx);
            px2 := Dest.ScanLine[row - oy];
            inc(px2, fX1 - ox);
            pb := pbyte(int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen);
            for col := fX1 to nX2 do
            begin
              if GetPixelbw_inline(pb, col) <> 0 then
                px2^ := px1^;
              inc(px2);
              inc(px1);
            end;
          end;
        end
        else if ((Source.PixelFormat = ie8g) and (Dest.PixelFormat = ie8g)) or ((Source.PixelFormat = ie8p) and (Dest.PixelFormat = ie8p)) then
        begin
          // ie8g or ie8p
          for row := fY1 to nY2 do
          begin
            pb1 := Source.ScanLine[row - sy];
            inc(pb1, fX1 - sx);
            pb2 := Dest.ScanLine[row - oy];
            inc(pb2, fX1 - ox);
            pb := pbyte(int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen);
            for col := fX1 to nX2 do
            begin
              if GetPixelbw_inline(pb, col) <> 0 then
                pb2^ := pb1^;
              inc(pb2);
              inc(pb1);
            end;
          end;
        end
        else if (Source.PixelFormat = ie1g) and (Dest.PixelFormat = ie1g) then
        begin
          // ie1g
          for row := fY1 to nY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            px2 := Dest.ScanLine[row - oy];
            pb := pbyte(int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen);
            for col := fX1 to nX2 do
            begin
              if GetPixelbw_inline(pb, col) <> 0 then
                SetPixelbw_inline(pbyte(px2), col - ox, GetPixelbw_inline(pbyte(px1), col - sx));
            end;
          end;
        end
        else if (Source.PixelFormat=Dest.PixelFormat) then
        begin
          for row := fY1 to nY2 do
          begin
            pb := pbyte(int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen);
            case Source.PixelFormat of
              ie16g:
                for col := fX1 to nX2 do
                  if GetPixelbw_inline(pb, col) <> 0 then
                    Dest.Pixels_ie16g[col-ox,row-oy]:=Source.Pixels_ie16g[col-sx,row-sy];
              ie32f:
                for col := fX1 to nX2 do
                  if GetPixelbw_inline(pb, col) <> 0 then
                    Dest.Pixels_ie32f[col-ox,row-oy]:=Source.Pixels_ie32f[col-sx,row-sy];
              ieCMYK:
                for col := fX1 to nX2 do
                  if GetPixelbw_inline(pb, col) <> 0 then
                    Dest.Pixels_ieCMYK[col-ox,row-oy]:=Source.Pixels_ieCMYK[col-sx,row-sy];
              ieCIELab:
                for col := fX1 to nX2 do
                  if GetPixelbw_inline(pb, col) <> 0 then
                    Dest.Pixels_ieCIELab[col-ox,row-oy]:=Source.Pixels_ieCIELab[col-sx,row-sy];
              ie48RGB:
                for col := fX1 to nX2 do
                  if GetPixelbw_inline(pb, col) <> 0 then
                    Dest.Pixels_ie48RGB[col-ox,row-oy]:=Source.Pixels_ie48RGB[col-sx,row-sy];
            end;
          end;
        end;
      end;
    8:
      begin
        // 8 bits per pixel (alpha blend)
        if (Source.PixelFormat = ie24RGB) and (Dest.PixelFormat = ie24RGB) then
        begin
          // ie24RGB
          for row := fY1 to nY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            inc(px1, fX1 - sx);
            px2 := Dest.ScanLine[row - oy];
            inc(px2, fX1 - ox);
            ii := int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen;
            for col := fX1 to nX2 do
            begin
              a := pbyte(ii + col)^ shl 10;
              px2^.r := (a * (px1^.r - px2^.r) shr 18 + px2^.r);
              px2^.g := (a * (px1^.g - px2^.g) shr 18 + px2^.g);
              px2^.b := (a * (px1^.b - px2^.b) shr 18 + px2^.b);
              inc(px2);
              inc(px1);
            end;
          end;
        end
        else if ((Source.PixelFormat = ie8g) and (Dest.PixelFormat = ie8g)) or ((Source.PixelFormat = ie8p) and (Dest.PixelFormat = ie8p)) then
        begin
          // ie8g or ie8p
          for row := fY1 to nY2 do
          begin
            pb1 := Source.ScanLine[row - sy];
            inc(pb1, fX1 - sx);
            pb2 := Dest.ScanLine[row - oy];
            inc(pb2, fX1 - ox);
            ii := int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen;
            for col := fX1 to nX2 do
            begin
              a := pbyte(ii + col)^ shl 10;
              pb2^ := (a * (pb1^ - pb2^) shr 18 + pb2^);
              inc(pb2);
              inc(pb1);
            end;
          end;
        end
        else if (Source.PixelFormat = ie1g) and (Dest.PixelFormat = ie1g) then
        begin
          // ie1g
          for row := fY1 to nY2 do
          begin
            px1 := Source.ScanLine[row - sy];
            px2 := Dest.ScanLine[row - oy];
            ii := int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen;
            for col := fX1 to nX2 do
            begin
              a := pbyte(ii + col)^;
              if a <> 0 then
                SetPixelbw_inline(pbyte(px2), col - ox, GetPixelbw_inline(pbyte(px1), col - sx));
            end;
          end;
        end;
      end;
  end;
  if UseAlphaChannel then
    CopyIEBitmapAlpha(Dest, Source, dstonlymask, srconlymask);
end;

{!!
<FS>TIEMask.CopyIEBitmapAlpha

<FM>Declaration<FC>
procedure CopyIEBitmapAlpha(Dest, Source: <A TIEBitmap>; dstonlymask, srconlymask: boolean);

<FM>Description<FN>
For internal use only.
!!}
// Like CopyIEBitmap, but sets the alpha channel in Dest (0=no selection, 255=selection, if Source is 255, otherwise set Source.Alpha)
procedure TIEMask.CopyIEBitmapAlpha(Dest, Source: TIEBitmap; dstonlymask, srconlymask: boolean);
var
  row, col: integer;
  px1, px2: pbyte;
  pb: pbyte;
  ox, oy, sx, sy, ii: integer;
  al255: pbyte;
  nX2,nY2:integer;
begin
  if srconlymask then
  begin
    nX2:=fX1+imin(imin(fX2-fX1,Source.Width-1),Dest.Width-1);   // 2.3.1
    nY2:=fY1+imin(imin(fY2-fY1,Source.Height-1),Dest.height-1); // 2.3.1
  end
  else
  begin
    nX2:=fX2;
    nY2:=fY2;
  enD;
  if (fX1 > nX2) and (fY1 > nY2) then
    exit;
  if dstonlymask then
  begin
    ox := fX1;
    oy := fY1;
  end
  else
  begin
    ox := 0;
    oy := 0;
  end;
  if srconlymask then
  begin
    sx := fX1;
    sy := fY1;
  end
  else
  begin
    sx := 0;
    sy := 0;
  end;
  al255 := nil;
  if not Source.HasAlphaChannel then
  begin
    getmem(al255, Source.Width);
    fillchar(al255^, Source.Width, 255);
  end;
  for row := fY1 to nY2 do
  begin
    if Source.HasAlphaChannel then
      px1 := Source.AlphaChannel.ScanLine[row - sy]
    else
      px1 := al255;
    inc(px1, fX1 - sx);
    px2 := Dest.AlphaChannel.ScanLine[row - oy];
    inc(px2, fX1 - ox);
    pb := pbyte(int64(DWORD(fBits)) + (fHeight - row - 1) * fRowlen);
    case fBitsPerPixel of
      1:
        for col := fX1 to nX2 do
        begin
          if GetPixelbw_inline(pb, col) <> 0 then
            // selected
            px2^ := imin(px1^, 255)
          else
            // not selected
            px2^ := 0;
          inc(px2);
          inc(px1);
        end;
      8:
        for col := fX1 to nX2 do
        begin
          ii := pbytearray(pb)^[col];
          if ii <> 0 then
            // selected
            px2^ := imin(px1^, ii)
          else
            // not selected
            px2^ := 0;
          inc(px2);
          inc(px1);
        end;
    end;
  end;
  if al255 <> nil then
    freemem(al255);
  Dest.AlphaChannel.Full := false;
end;

// draw an horizontal line, associating Alpha value to the setted pixels
// return number of pixel written

function TIEMask.DrawHorizontalLine(Alpha: integer; xleft, xright, y: integer): integer;
var
  x: integer;
  pb: pbyte;
  pp: pbytearray;
begin
  result := 0;
  if xleft < 0 then
    xleft := 0;
  if xright >= fWidth then
    xright := fWidth - 1;
  if y < 0 then
    y := 0;
  if y >= fHeight then
    y := fHeight - 1;
  if fFull then
    fFull := not ((fBitsPerPixel = 8) and (Alpha <> 255)) or ((fBitsPerPixel = 1) and (Alpha = 0));
  case fBitsperpixel of
    1:
      begin
        // 1 bit per pixel, Alpha must be 1
        pp := pbytearray(int64(DWORD(fBits)) + (fHeight - y - 1) * fRowlen);
        if Alpha=1 then
        begin
          for x := xleft to xright do
          begin
            pb := @(pp^[x shr 3]);
            pb^ := pb^ or iebitmask1[x and 7];
            inc(result);
          end;
        end
        else
        begin
          for x := xleft to xright do
          begin
            pb := @(pp^[x shr 3]);
            pb^ := pb^ and not iebitmask1[x and 7];
            inc(result);
          end;
        end;
      end;
    8:
      begin
        // 8 bits per pixel
        fillchar(pbyte(int64(DWORD(fBits)) + (fHeight - y - 1) * fRowlen + xleft)^, xright - xleft + 1, Alpha);
        inc(result, xright - xleft + 1);
      end;
  end;
end;

{!!
<FS>TIEMask.ScanLine

<FM>Declaration<FC>
property ScanLine[row:integer]:pointer;

<FM>Description<FN>
Like TBitmap.Scanline property. It allows to get/set mask by hand.
!!}
function TIEMask.GetScanLine(Row: integer): pointer;
begin
  result := pointer(int64(DWORD(fBits)) + (fHeight - Row - 1) * fRowlen);
end;

{!!
<FS>TIEMask.Fill

<FM>Declaration<FC>
procedure Fill(Alpha:integer);

<FM>Description<FN>
Fills the entire mask using Alpha value.
!!}
procedure TIEMask.Fill(Alpha: integer);
begin
  fillchar(fBits^, fRowLen * fHeight, Alpha);
  fFull := not ((fBitsPerPixel = 8) and (Alpha <> 255)) or ((fBitsPerPixel = 1) and (Alpha = 0));
end;

{!!
<FS>TIEMask.IsEmpty

<FM>Declaration<FC>
function IsEmpty:boolean;

<FM>Description<FN>
Return True is the mask contains all zeros.
!!}
function TIEMask.IsEmpty: boolean;
begin
  result := fX1 = 2147483647;
end;

{!!
<FS>TIEMask.Empty

<FM>Declaration<FC>
procedure Empty;

<FM>Description<FN>
Fills the entire mask with zeros.
!!}
procedure TIEMask.Empty;
begin
  Fill(0);
  fX1 := 2147483647;
  fY1 := 2147483647;
  fX2 := 0;
  fY2 := 0;
end;

{!!
<FS>TIEMask.DrawPolygon

<FM>Declaration<FC>
procedure DrawPolygon(Alpha:integer; SelPoly:<A PPointArray>; SelPolyCount:integer);

<FM>Description<FN>
Draw specified polygon in the mask, using Alpha value for all pixels.
!!}
// draw multi polygons separated by IESELBREAK, using DrawSinglePolygon
procedure TIEMask.DrawPolygon(Alpha: integer; SelPoly: PPointArray; SelPolyCount: integer);
var
  p1, p2, q: integer;
begin
  if SelPolyCount > 0 then
  begin
    p1 := 0;
    for q := 0 to SelPolyCount do
      if (q = SelPolyCount) or (SelPoly^[q].x = IESELBREAK) then
      begin
        p2 := q - p1;
        DrawSinglePolygon(Alpha, PPointArray(@(SelPoly^[p1])), p2);
        p1 := q + 1;
      end;
  end;
  SyncFull;
end;

// draw a filled polygon in the mask, associating Alpha value to the setted pixels
procedure TIEMask.DrawSinglePolygon(Alpha: integer; SelPoly: PPointArray; SelPolyCount: integer);
type
  eltptr = ^element;
  element = record
    xP, yQ, dx, dy, E: integer;
    next: eltptr;
  end;
  telementarray = array[0..32767] of eltptr;
  pelementarray = ^telementarray;
var
  x, y, i, ymin, ymax, j, ny, i1, xP, yP, xQ, yQ, temp, dx, dy, m, dyQ, E, xleft, xright: integer;
  table: pelementarray;
  p, start, _end, p0, q: eltptr;
  pw: integer; // pixel written
begin
  ymin := 2147483647;
  ymax := 0;
  for i := 0 to SelPolyCount - 1 do
  begin
    x := selpoly^[i].x;
    y := selpoly^[i].y;
    if y < ymin then
      ymin := y;
    if y > ymax then
      ymax := y;
    if Alpha <> 0 then
    begin
      if x < fX1 then
        fX1 := x;
      if x > fX2 then
        fX2 := x - 1;
      if y < fY1 then
        fY1 := y;
      if y > fY2 then
        fY2 := y - 1;
    end;
  end;
  if fX1 < 0 then
    fX1 := 0;
  if fX2 >= fWidth then
    fX2 := fWidth - 1;
  if fY1 < 0 then
    fY1 := 0;
  if fY2 >= fHeight then
    fY2 := fHeight - 1;
  ny := ymax - ymin + 1;
  getmem(table, ny * sizeof(eltptr));
  for j := 0 to ny - 1 do
    table[j] := nil;
  for i := 0 to SelPolyCount - 1 do
  begin
    i1 := i + 1;
    if i1 = SelPolyCount then
      i1 := 0;
    xP := selpoly^[i].x;
    yP := selpoly^[i].y;
    xQ := selpoly^[i1].x;
    yQ := selpoly^[i1].y;
    if yP = yQ then
      continue;
    if yQ < yP then
    begin
      temp := xP;
      xP := xQ;
      xQ := temp;
      temp := yP;
      yP := yQ;
      yQ := temp;
    end;
    getmem(p, sizeof(element));
    p^.xP := xP;
    p^.dx := xQ - xP;
    p^.yQ := yQ;
    p^.dy := yQ - yP;
    j := yP - ymin;
    p^.next := table[j];
    table[j] := p;
  end;
  getmem(start, sizeof(element));
  _end := start;
  pw := 0;
  for j := 0 to ny - 1 do
  begin
    y := ymin + j;
    p := start;
    while p <> _end do
    begin
      if p^.yQ = y then
      begin
        q := p^.next;
        if (q = _end) then
          _end := p
        else
          p^ := q^;
        freemem(q);
      end
      else
      begin
        dx := p^.dx;
        if dx <> 0 then
        begin
          x := p^.xP;
          dy := p^.dy;
          E := p^.E;
          m := dx div dy;
          dyQ := 2 * dy;
          inc(x, m);
          inc(E, 2 * dx - m * dyQ);
          if (E > dy) or (E < -dy) then
          begin
            if dx > 0 then
            begin
              inc(x);
              dec(E, dyQ);
            end
            else
            begin
              dec(x);
              inc(E, dyQ);
            end;
          end;
          p^.xP := x;
          p^.E := E;
        end;
        p := p^.next;
      end;
    end;
    p := table[j];
    while p <> nil do
    begin
      _end^.xP := p^.xP;
      x := _end^.xP;
      yQ := p^.yQ;
      dx := p^.dx;
      dy := p^.dy;
      q := start;
      while (q^.xP < x) or (q^.xP = x) and (q <> _end) and (q^.dx * dy < dx * q^.dy) do
        q := q^.next;
      p0 := p;
      p := p^.next;
      if q = _end then
        _end := p0
      else
        p0^ := q^;
      q^.xP := x;
      q^.yQ := yQ;
      q^.dx := dx;
      q^.dy := dy;
      q^.E := 0;
      q^.next := p0;
    end;
    p := start;
    while p <> _end do
    begin
      xleft := p^.xP;
      p := p^.next;
      xright := p^.xP - 1;
      if xleft <= xright then
        inc(pw, DrawHorizontalLine(Alpha, xleft, xright, y));
      p := p^.next;
    end;
  end;
  p := start;
  while p <> _end do
  begin
    p0 := p;
    p := p^.next;
    freemem(p0);
  end;
  freemem(start);
  freemem(table);
  if pw = 0 then
  begin
    // empty selection
    fX1 := 2147483647;
    fY1 := 2147483647;
    fX2 := 0;
    fY2 := 0;
  end;
end;

{!!
<FS>TIEMask.TranslateBitmap

<FM>Declaration<FC>
procedure TranslateBitmap(var ox, oy:integer; CutSel:boolean);

<FM>Description<FN>
Translates the mask of <FC>ox, oy<FN> pixels. <FC>CutSel<FN> is true if the mask can go out of mask margins.
!!}
// adjust ox,oy
procedure TIEMask.TranslateBitmap(var ox, oy: integer; CutSel: boolean);
var
  xbits, ps, pd: pbyte;
  x, y: integer;
  xx, yy: integer;
  p: integer;
  dx, dy, slen: integer;
begin
  if IsEmpty then
    SyncRect;
  if IsEmpty then
    exit;
  if CutSel then
  begin
    if (ox + fX1) < 0 then
      inc(fX1, abs(ox + fX1));
    if (oy + fY1) < 0 then
      inc(fY1, abs(oy + fY1));
    if (ox + fX2) >= fWidth then
      dec(fX2, 1 + abs(fWidth - (ox + fX2)));
    if (oy + fY2) >= fHeight then
      dec(fY2, 1 + abs(fHeight - (oy + fY2)));
  end
  else
  begin
    if (ox + fX1) < 0 then
      dec(ox, (ox + fX1));
    if (ox + fX2) >= fWidth then
      dec(ox, (ox + fX2 - fWidth + 1));
    if (oy + fY1) < 0 then
      dec(oy, (oy + fY1));
    if (oy + fY2) >= fHeight then
      dec(oy, (oy + fY2 - fHeight + 1));
  end;
  if (ox = 0) and (oy = 0) then
    exit;
  case fBitsperpixel of
    1:
      begin
        // 1 bit per pixel
        dx := fX2 - fX1 + 1;
        dy := fY2 - fY1 + 1;
        if (dx<=0) or (dy<=0) then
        begin
          Empty;
          exit;
        end;
        slen := IEBitmapRowLen(dx, fBitsPerPixel, 32);
        xbits := allocmem(slen * dy); // we need zero filled memory
        ps := pbyte(int64(DWORD(fBits)) + (fHeight - fY1 - 1) * fRowlen);
        pd := pbyte(int64(DWORD(xBits)) + (dy - 1) * slen);
        for y := 0 to dy - 1 do
        begin
          IECopyBits_large(pd, ps, 0, fX1, dx, fRowLen);
          //zeromemory(ps, fRowLen);
          dec(ps, fRowlen);
          dec(pd, slen);
        end;
        zeromemory(fbits, frowlen * fheight);
        ps := pbyte(int64(DWORD(xBits)) + (dy - 1) * slen);
        pd := pbyte(int64(DWORD(fBits)) + (fHeight - fY1 - oy - 1) * fRowlen);
        for y := 0 to dy - 1 do
        begin
          IECopyBits_large(pd, ps, fX1 + ox, 0, dx, slen);
          dec(pd, fRowlen);
          dec(ps, slen);
        end;
        freemem(xbits);
      end;
    8:
      begin
        // 8 bits per pixel
        getmem(xbits, frowlen * fheight);
        copymemory(xbits, fbits, frowlen * fheight);
        zeromemory(fbits, frowlen * fheight);
        for y := fY1 to fY2 do
        begin
          yy := y + oy;
          if (yy < fHeight) and (yy >= 0) then
          begin
            for x := fX1 to fX2 do
            begin
              xx := x + ox;
              if (xx < fWidth) and (xx >= 0) then
              begin
                p := pbyte(int64(DWORD(xBits)) + (fHeight - y - 1) * fRowlen + x)^;
                pbyte(int64(DWORD(fBits)) + (fHeight - yy - 1) * fRowlen + xx)^ := p;
              end;
            end;
          end;
        end;
        freemem(xbits);
      end;
  end;
  inc(fX1, ox);
  if fX1 < 0 then
    fX1 := 0;
  if fX1 >= fWidth then
    fX1 := fWidth - 1;
  inc(fY1, oy);
  if fY1 < 0 then
    fY1 := 0;
  if fY1 >= fHeight then
    fY1 := fHeight - 1;
  inc(fX2, ox);
  if fX2 < 0 then
    fX2 := 0;
  if fX2 >= fWidth then
    fX2 := fWidth - 1;
  inc(fY2, oy);
  if fY2 < 0 then
    fY2 := 0;
  if fY2 >= fHeight then
    fY2 := fHeight - 1;
end;

{!!
<FS>TIEMask.Negative

<FM>Declaration<FC>
procedure Negative(MaxVal: integer);

<FM>Description<FN>
For internal use only.
!!}
procedure TIEMask.Negative(MaxVal: integer);
var
  x, y: integer;
begin
  if (fX1 = 2147483647) or (fY1 = 2147483647) then
    exit;
  fFull := false;
  fX1 := 2147483647;
  fY1 := 2147483647;
  fX2 := 0;
  fY2 := 0;
  for y := 0 to fHeight - 1 do
  begin
    for x := 0 to fWidth - 1 do
    begin
      if GetPixel(x, y) = 0 then
      begin
        SetPixel(x, y, MaxVal);
        if x < fX1 then
          fX1 := x;
        if x > fX2 then
          fX2 := x;
        if y < fY1 then
          fY1 := y;
        if y > fY2 then
          fY2 := y;
      end
      else
        SetPixel(x, y, 0);
    end;
  end;
end;

{!!
<FS>TIEMask.SyncFull

<FM>Declaration<FC>
procedure SyncFull;

<FM>Description<FN>
Sets <A TIEMask.Full> to True if all values are 255.
!!}
// set Full to True if all values are 255
// works both 1 and 8 bitsperpixel
procedure TIEMask.SyncFull;
var
  px: pbyte;
  y, x, l: integer;
begin
  case fBitsperpixel of
    1:
      begin

        l:=fWidth div 8;
        for y:=0 to fHeight-1 do
        begin
          px:=Scanline[y];
          for x:=0 to l-1 do
          begin
            if px^<$FF then
            begin
              fFull:=false;
              exit;
            end;
            inc(px);
          end;

          if (fWidth and $7)<>0 then
          begin
            // check last bits
            for x:=l*8 to fWidth-1 do
            begin
              if GetPixel(x,y)=0 then
              begin
                fFull:=false;
                exit;
              end;
            end;
          end;
        end;

      end;
    8:
      begin

        for y := 0 to fHeight - 1 do
        begin
          px := Scanline[y];
          for x := 0 to fWidth - 1 do
          begin
            if px^ < $FF then
            begin
              fFull := False;
              exit;
            end;
            inc(px);
          end;
        end;

      end;
  end;
  fFull := True;
end;

{!!
<FS>TIEMask.CombineWithAlpha

<FM>Declaration<FC>
procedure CombineWithAlpha(SourceAlpha:<A TIEBitmap>; ox,oy:integer; SynchronizeBoundingRect:boolean);

<FM>Description<FN>
Only for internal use.
!!}
procedure TIEMask.CombineWithAlpha(SourceAlpha:TIEBitmap; ox,oy:integer; SynchronizeBoundingRect:boolean);
var
  x,y:integer;
  px,pa:pbyte;
begin
  if (SourceAlpha.PixelFormat<>ie8g) and (SourceAlpha.PixelFormat<>ie8p) then
    exit;
  case fBitsperpixel of
    1:
      begin
        for y:=0 to SourceAlpha.Height-1 do
        begin
          if y+oy>=fHeight then
            break;
          px:=Scanline[y+oy];
          pa:=SourceAlpha.Scanline[y];
          for x:=0 to SourceAlpha.Width-1 do
          begin
            if x+ox>=fWidth then
              break;
            if pa^=0 then
              SetPixelbw_inline(px,x+ox,0);
            inc(pa);
          end;
        end;
      end;
    8:
      begin
        for y:=0 to SourceAlpha.Height-1 do
        begin
          if y+oy>=fHeight then
            break;
          px:=Scanline[y+oy]; inc(px,ox);
          pa:=SourceAlpha.Scanline[y];
          for x:=0 to SourceAlpha.Width-1 do
          begin
            if x+ox>=fWidth then
              break;
            px^:=imin(pa^,px^);
            inc(pa);
            inc(px);
          end;
        end;
      end;
  end;
  if SynchronizeBoundingRect then
    SyncRect;
  SyncFull;
end;

{!!
<FS>TIEMask.Intersect

<FM>Declaration<FC>
procedure Intersect(x1, y1, x2, y2:integer);

<FM>Description<FN>
For internal use only.
!!}
procedure TIEMask.Intersect(x1, y1, x2, y2:integer);
var
  px:pbyte;
  x,y:integer;
begin
  case fBitsPerPixel of
    1:
      for y:=fY1 to fY2 do
      begin
        px:=Scanline[y];
        for x:=fX1 to fX2 do
          if (x<x1) or (x>x2) or (y<y1) or (y>y2) then
            SetPixelbw_inline(px,x,0);
      end;
    8:
      for y:=fY1 to fY2 do
      begin
        px:=Scanline[y];
        for x:=fX1 to fX2 do
        begin
          if (x<x1) or (x>x2) or (y<y1) or (y>y2) then
            px^:=0;
          inc(px);
        end;
      end;
  end;
  SyncRect;
  SyncFull;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEVirtualImageList

// Location:
//   ielTempFile : create in a temp directory a new file
// TempDirectory:
//   if empty uses windows temp directory
//   otherwise must be a full path ending with '\'
constructor TIEVirtualImageList.Create(const Descriptor:string; UseDisk:boolean);
begin
  inherited Create;
  fDescriptor := Descriptor;
  fUseDisk := UseDisk;
  fAllocationBlock := 262144;
  fMaxImagesInMemory := 10;
  CreateEx;
end;

destructor TIEVirtualImageList.Destroy;
begin
  DestroyEx;
  inherited;
end;

procedure TIEVirtualImageList.CreateEx;
begin
  fmemmap := TIEFileBuffer.Create;
  fSize := fAllocationBlock;
  fInsPos := 0;
  fImageInfo := TList.Create;
  fFreeBlocks := TList.Create;
  fToDiscardList := TList.Create;
  fImagesInMemory := 0;
  fBmpToRelease := TList.Create;
  fLastVImageSize := 0;
  ReAllocateBits;
end;

procedure TIEVirtualImageList.DestroyEx;
begin
  FreeBits;
  FreeAndNil(fmemmap);
  FreeAndNil(fImageInfo);
  FreeAndNil(fFreeBlocks);
  FreeAndNil(fToDiscardList);
  FreeAndNil(fBmpToRelease);
end;

procedure TIEVirtualImageList.SaveToStream(Stream:TStream);
var
  i:integer;
  ii:PIEVirtualImageInfo;
  ver:byte;
begin
  DiscardAll; // make file consistent
  // magick
  SaveStringToStream(Stream,'VIRTUALIMAGELIST');
  // version
  ver:=1;
  Stream.Write(ver,1);
  // images count
  i:=fImageInfo.Count; Stream.Write(i,sizeof(integer));
  // images info
  for i:=0 to fImageInfo.Count-1 do
    Stream.Write( PIEVirtualImageInfo(fImageInfo[i])^, sizeof(TIEVirtualImageInfo) );
  // images data
  for i:=0 to fImageInfo.Count-1 do
  begin
    ii:=PIEVirtualImageInfo(fImageInfo[i]);
    fmemmap.CopyTo(Stream, ii^.pos, ii^.vsize); // 3.0.0b3
  end;
end;

function TIEVirtualImageList.LoadFromStream(Stream:TStream):boolean;
var
  i:integer;
  s:AnsiString;
  ii:PIEVirtualImageInfo;
  fs:integer;
  ver:byte;
  icount:integer;
begin
  result := false;
  // magick
  LoadStringFromStream(Stream, s);
  if s<>'VIRTUALIMAGELIST' then
    exit;
  // version
  Stream.Read(ver,1);
  // images count
  Stream.Read(icount,sizeof(integer));

  if icount>0 then
  begin
    DestroyEx;
    CreateEx;
    // images info
    fs := 0;
    for i:=0 to icount-1 do
    begin
      new(ii);
      Stream.Read(ii^,sizeof(TIEVirtualImageInfo));
      ii^.pos := fs;
      fImageInfo.Add(ii);
      inc(fs, ii^.vsize);
    end;
    // images data
    fSize := fs+1;
    ReallocateBits;
    fmemmap.fSimFile.Position := 0;
    if fs>0 then
      IECopyFrom(fmemmap.fSimFile, Stream, fs);
    fInsPos := fs;
  end;
  result := true;
end;

// allocate (or re-allocate) bits without memory loss
procedure TIEVirtualImageList.ReAllocateBits;
var
  i:integer;
begin
  // delete free blocks list
  for i:=0 to fFreeBlocks.Count-1 do
    dispose(fFreeBlocks[i]);
  fFreeBlocks.Clear;

  if not fmemmap.IsAllocated then
  begin
    FreeBits;
    fmemmap.AllocateFile(fSize,fDescriptor,fUseDisk);
  end
  else
  begin
    DiscardAll;
    fmemmap.ReAllocateFile(fSize);
  end;
end;

procedure TIEVirtualImageList.FreeBits;
var
  i:integer;
begin

  for i:=0 to fImageInfo.Count-1 do
    RemoveImageInfo(i, false);
  fImageInfo.Clear;

  fToDiscardList.Clear;

  // delete free blocks list
  for i:=0 to fFreeBlocks.Count-1 do
    dispose(fFreeBlocks[i]);
  fFreeBlocks.Clear;

  // bmp to release list
  for i:=0 to fBmpToRelease.Count-1 do
  begin
    FreeAndNil(PIEVirtualToReleaseBmp(fBmpToRelease[i])^.bmp);
    dispose(fBmpToRelease[i]);
  end;
  fBmpToRelease.Clear;

  fmemmap.DeAllocate;
  fInsPos := 0;
end;

procedure TIEVirtualImageList.RemoveImageInfo(idx: integer; deleteItem:boolean);
var
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  qidx := BmpToReleaseIndexOf(fImageInfo[idx]);
  if qidx > -1 then
  begin
    inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
    FreeAndNil(inf^.bmp);
    dispose(inf);
    fBmpToRelease.Delete(qidx);
  end;
  DiscardImage(fImageInfo[idx]); // discard if needed
  dispose(fImageInfo[idx]);
  if deleteItem then
    fImageInfo.Delete(idx);
end;

procedure TIEVirtualImageList.DiscardImage(info: PIEVirtualImageInfo);
begin
  with info^ do
  begin
    if ptr <> nil then
    begin
      fmemmap.UnMap(ptr);
      fToDiscardList.Remove(info);
      dec(fImagesInMemory);
    end;
    ptr := nil;
  end;
end;

procedure TIEVirtualImageList.DiscardOne;
begin
  if fToDiscardList.Count > 0 then
    DiscardImage(fToDiscardList[0]);
end;

procedure TIEVirtualImageList.DiscardAll;
begin
  while fToDiscardList.Count > 0 do
    DiscardImage(fToDiscardList[0]);
end;

// the opposite of DiscardImage
// if the image is already mapped, MapImage brings it at last position of the discard list
procedure TIEVirtualImageList.MapImage(image: pointer; access: TIEDataAccess);
var
  pinfo: PIEVirtualImageInfo;
begin
  pinfo := image;
  with pinfo^ do
  begin
    if access <> currentaccess then
      DiscardImage(pinfo);
    if ptr = nil then
    begin
      while (fImagesInMemory (*+ 1*)) > fMaxImagesInMemory do // 2.3.1
        DiscardOne;
      ptr := fmemmap.Map(pos, vsize, access);
      if ptr <> nil then
      begin
        inc(fImagesInMemory);
        fToDiscardList.Add(pinfo);
      end;
      currentaccess := access;
    end
    else
    begin
      // move to the end of discard list
      if pinfo^.ptr <> nil then
      begin
        fToDiscardList.Remove(pinfo);
        fToDiscardList.Add(pinfo);
      end;
    end;
  end;
end;

procedure TIEVirtualImageList.PrepareSpaceFor(Width, Height: integer; Bitcount: integer; ImageCount: integer);
var
  rowlen, bmplen, vbmplen: int64;
begin
  rowlen := IEBitmapRowLen(Width, Bitcount, 32);
  bmplen := Height * rowlen;
  vbmplen := bmplen;
  fSize := fSize + vbmplen * ImageCount;
  ReAllocateBits;
end;

// the image remains mapped
function TIEVirtualImageList.AddBlankImage(Width, Height, Bitcount:integer; PixelFormat:TIEPixelFormat; HasAlpha:boolean):pointer;
var
  ii: PIEVirtualImageInfo;
begin
  result := nil;
  new(ii);
  if AllocImage(ii, Width, Height, Bitcount, PixelFormat, HasAlpha) then
  begin
    fImageInfo.Add(ii);
    result := ii;
  end
  else
    dispose(ii);
end;

procedure TIEVirtualImageList.MergeConsecutiveBlocks();
var
  i:integer;
  fb_cur, fb_next:PIEVirtualFreeBlock;
begin
  i := 0;
  while i < fFreeBlocks.Count-1 do  // -1 avoids to check last block
  begin
    fb_cur := PIEVirtualFreeBlock(fFreeBlocks[i]);
    fb_next := PIEVirtualFreeBlock(fFreeBlocks[i+1]);
    if fb_cur^.pos + fb_cur^.vsize = fb_next^.pos then
    begin
      // do merge
      inc(fb_cur^.vsize, fb_next^.vsize);
      fFreeBlocks.Delete(i+1);
      dispose(fb_next);
    end
    else
      inc(i);
  end;
end;

function TIEVirtualImageList.AllocImage(image:pointer; Width, Height, Bitcount:integer; PixelFormat:TIEPixelFormat; HasAlpha:boolean):boolean;
var
  rowlen, vbmplen, alphalen: int64;
  ne: int64;
  ii: PIEVirtualImageInfo;
  fb: PIEVirtualFreeBlock;
  q: integer;
  paletteLen:integer; // palette length in bytes
begin
  rowlen := IEBitmapRowLen(Width, Bitcount, 32);

  alphalen := 0;
  if HasAlpha then
    alphalen := sizeof(boolean) + IEBitmapRowLen(Width, 8, 32) * Height;

  paletteLen := 0;
  if PixelFormat = ie8p then
    paletteLen := 256 * sizeof(TRGB);

  vbmplen := Height * rowlen + alphalen + paletteLen;

  // look for a free block before last image
  MergeConsecutiveBlocks();
  q := 0;
  fb := nil;
  while q < fFreeBlocks.Count do
  begin
    fb := PIEVirtualFreeBlock(fFreeBlocks[q]);
    if vbmplen <= fb^.vsize then
      break
    else
      fb := nil;
    inc(q);
  end;

  if fb <> nil then
  begin
    // found a free block
    ne := fInsPos;
    fInsPos := fb^.pos;
    // split or remove free block
    if fb^.vsize = vbmplen then
    begin
      // remove free block
      dispose(fb);
      fFreeBlocks.Delete(q);
    end
    else
    begin
      // split to a new free block
      inc(fb^.pos, vbmplen);
      dec(fb^.vsize, vbmplen);
    end;
  end
  else
  begin
    // no free blocks found, allocate new
    if fAllocationBlock < vbmplen then
      fAllocationBlock := fLastVImageSize + vbmplen;
    fLastVImageSize := vbmplen;
    ne := fInsPos + vbmplen;
    if ne > fSize then
    begin
      // expand file (of fAllocationBlock bytes)
      fSize := fSize + fAllocationBlock;
      ReAllocateBits;
    end;
  end;

  ii := image;
  with ii^ do
  begin
    pos := fInsPos;
    vsize := vbmplen;
    ptr := nil;
    bitmapped := false;
    orig_width := Width;
    orig_height := Height;
    HasAlphaChannel := HasAlpha;
    currentaccess := [iedWrite];
    ImWidth := Width;
    ImHeight := Height;
    ImBitCount := BitCount;
    ImPixelFormat := PixelFormat;
  end;
  MapImage(ii, ii^.currentaccess);

  if ii^.ptr <> nil then
    fInsPos := ne;

  result := true;

end;

function TIEVirtualImageList.AddBitmap(bitmap: TBitmap): pointer;
var
  tbmp: TIEBitmap;
begin
  tbmp := TIEBitmap.Create;
  try
    tbmp.EncapsulateTBitmap(bitmap, true);
    result := AddIEBitmap(tbmp);
  finally
    FreeAndNil(tbmp);
  end;
end;

// the image stays mapped
function TIEVirtualImageList.AddIEBitmap(bitmap: TIEBaseBitmap): pointer;
var
  row: integer;
  pbmp: pbyte;
  ii: PIEVirtualImageInfo;
  rowlen: integer;
  bitcount: integer;
  iebmp: TIEBitmap;
  HasAlpha: boolean;
begin
  bitcount := bitmap.BitCount;
  HasAlpha := (bitmap is TIEBitmap) and ((bitmap as TIEBitmap).HasAlphaChannel);
  result := AddBlankImage(bitmap.Width, bitmap.Height, bitcount, bitmap.PixelFormat, HasAlpha);
  ii := result;
  if (ii <> nil) and (ii^.ptr <> nil) then
  begin
    pbmp := ii^.ptr;
    rowlen := IEBitmapRowLen(bitmap.Width, bitcount, 32);
    // write bitmap
    for row := 0 to bitmap.height - 1 do
    begin
      CopyMemory(pbmp, bitmap.Scanline[bitmap.height - row - 1], rowlen);
      inc(pbmp, rowlen);
    end;
    // write palette (if present)
    if bitmap.PixelFormat = ie8p then
    begin
      CopyMemory(pbmp, bitmap.PaletteBuffer, 256*sizeof(TRGB));
      inc(pbmp, 256*sizeof(TRGB));
    end;
    // write alpha channel (if present)
    if HasAlpha then
    begin
      // copy alpha channel
      rowlen := IEBitmapRowLen(bitmap.Width, 8, 32);
      iebmp := bitmap as TIEBitmap;
      pboolean(pbmp)^ := iebmp.AlphaChannel.Full;
      inc(pbmp, sizeof(boolean));
      for row := 0 to bitmap.height - 1 do
      begin
        CopyMemory(pbmp, iebmp.AlphaChannel.Scanline[bitmap.height - row - 1], rowlen);
        inc(pbmp, rowlen);
      end;
    end;
  end;
end;

// the image remains mapped
function TIEVirtualImageList.AddBitmapRect(bitmap: TBitmap; xsrc, ysrc, dxsrc, dysrc: integer): pointer;
var
  pbmp: pbyte;
  ii: PIEVirtualImageInfo;
  rowlen: integer;
  bitcount: integer;
begin
  bitcount := _Pixelformat2BitCount(bitmap.PixelFormat);
  result := AddBlankImage(dxsrc, dysrc, bitcount, IEVCLPixelFormat2ImageEnPixelFormat(bitmap.PixelFormat) ,false);
  if result <> nil then
  begin
    ii := result;
    pbmp := ii^.ptr;
    rowlen := IEBitmapRowLen(dxsrc, bitcount, 32);
    IEBitmapMapXCopy(pbmp, rowlen, bitcount, bitmap, 0, 0, xsrc, ysrc, dxsrc, dysrc, 1);
  end;
end;

// get the image from the memory mapped file (NOT FROM BmpToRelease!!)
procedure TIEVirtualImageList.DirectCopyToBitmap(image: pointer; bitmap: TIEBitmap);
var
  pbmp: pbyte;
  rowlen: dword;
  width, height, bitcount: integer;
  row: integer;
  ii: PIEVirtualImageInfo;
begin
  ii := image;
  MapImage(ii, [iedRead]);
  if ii^.ptr <> nil then
  begin
    pbmp := ii^.ptr;
    width := ii^.ImWidth;
    height := ii^.ImHeight;
    bitcount := ii^.ImBitCount;
    rowlen := IEBitmapRowLen(width, bitcount, 32);

    if (bitmap.PixelFormat <> ii^.ImPixelFormat) or (bitmap.width <> width) or (bitmap.height <> height) then
      bitmap.Allocate(width, height, ii^.ImPixelFormat);

    // copy bitmap
    for row := 0 to height - 1 do
    begin
      copymemory(bitmap.ScanLine[height - row - 1], pbmp, rowlen);
      inc(pbmp, rowlen);
    end;
    // copy palette
    if bitmap.PixelFormat = ie8p then
    begin
      CopyMemory(bitmap.PaletteBuffer, pbmp, 256*sizeof(TRGB));
      inc(pbmp, 256*sizeof(TRGB));
    end;
    // copy alpha channel
    if (not ii^.HasAlphaChannel) or pboolean(pbmp)^ then
      bitmap.RemoveAlphaChannel
    else
    begin
      // load alpha
      bitmap.AlphaChannel.Full := pboolean(pbmp)^;
      inc(pbmp, sizeof(boolean));
      rowlen := IEBitmapRowLen(width, 8, 32);
      for row := 0 to height - 1 do
      begin
        copymemory(bitmap.AlphaChannel.Scanline[height - row - 1], pbmp, rowlen);
        inc(pbmp, rowlen);
      end;
    end;
  end;
end;

// can get the image from memory mapped or from BmpToRelease
procedure TIEVirtualImageList.CopyToIEBitmap(image: pointer; bitmap: TIEBitmap);
var
  pbmp: pbyte;
  rowlen: dword;
  width, height, bitcount: integer;
  row: integer;
  ii: PIEVirtualImageInfo;
  qidx: integer;
begin
  ii := image;
  MapImage(ii, [iedRead]);
  if ii^.ptr <> nil then
  begin
    qidx := BmpToReleaseIndexOf(image);
    if qidx < 0 then
    begin
      pbmp := ii^.ptr;
      width := ii^.ImWidth;
      height := ii^.ImHeight;
      bitcount := ii^.ImBitCount;
      rowlen := IEBitmapRowLen(width, bitcount, 32);
      bitmap.Allocate(width, height, ii^.ImPixelFormat);  // 2.2.6
      // copy bitmap
      for row := 0 to height - 1 do
      begin
        copymemory(bitmap.scanline[height - row - 1], pbmp, rowlen);
        inc(pbmp, rowlen);
      end;
      // copy palette
      if bitmap.PixelFormat = ie8p then
      begin
        CopyMemory(bitmap.PaletteBuffer, pbmp, 256*sizeof(TRGB));
        inc(pbmp, 256*sizeof(TRGB));
      end;
      // copy alpha channel
      if (not ii^.HasAlphaChannel) or pboolean(pbmp)^ then
        bitmap.RemoveAlphaChannel
      else
      begin
        // load alpha
        bitmap.AlphaChannel.Full := pboolean(pbmp)^;
        inc(pbmp, sizeof(boolean));
        rowlen := IEBitmapRowLen(width, 8, 32);
        for row := 0 to height - 1 do
        begin
          copymemory(bitmap.AlphaChannel.Scanline[height - row - 1], pbmp, rowlen);
          inc(pbmp, rowlen);
        end;
      end;
    end
    else
    begin
      // stored in TBitmap
      bitmap.Assign(PIEVirtualToReleaseBmp(fBmpToRelease[qidx]).bmp);
    end;
  end;
end;

procedure TIEVirtualImageList.CopyFromIEBitmap(image: pointer; bitmap: TIEBitmap);
var
  pbmp: pbyte;
  rowlen: dword;
  width, height, bitcount: integer;
  row: integer;
  ii: PIEVirtualImageInfo;
  bmpbitcount: integer;
begin

  ii := image;
  MapImage(ii, [iedRead, iedWrite]);
  if ii^.ptr <> nil then
  begin
    width := ii^.ImWidth;
    height := ii^.ImHeight;
    bitcount := ii^.ImBitCount;
    bmpbitcount := bitmap.BitCount;
    if (width <> bitmap.width) or (height <> bitmap.height) or (bmpbitcount <> bitcount) or (bitmap.HasAlphaChannel <> ii^.HasAlphaChannel) then
    begin
      width := bitmap.width;
      height := bitmap.height;
      bitcount := bmpbitcount;
      DiscardImage(ii);
      AllocImage(ii, width, height, bitcount, bitmap.PixelFormat, bitmap.HasAlphaChannel); // changes ii^.ptr
    end;
    pbmp := ii^.ptr;
    rowlen := IEBitmapRowLen(width, bitcount, 32);
    // copy bitmap
    for row := 0 to height - 1 do
    begin
      copymemory(pbmp, bitmap.scanline[height - row - 1], rowlen);
      inc(pbmp, rowlen);
    end;
    // copy palette
    if bitmap.PixelFormat = ie8p then
    begin
      CopyMemory(pbmp, bitmap.PaletteBuffer, 256*sizeof(TRGB));
      inc(pbmp, 256*sizeof(TRGB));
    end;
    // alpha channel
    rowlen := IEBitmapRowLen(bitmap.Width, 8, 32);
    if bitmap.HasAlphaChannel then
    begin
      // copy alpha channel
      pboolean(pbmp)^ := bitmap.AlphaChannel.Full;
      inc(pbmp, sizeof(boolean));
      for row := 0 to bitmap.height - 1 do
      begin
        copymemory(pbmp, bitmap.AlphaChannel.Scanline[bitmap.height - row - 1], rowlen);
        inc(pbmp, rowlen);
      end;
    end;
  end;
end;

function TIEVirtualImageList.BmpToReleaseIndexOf(image: pointer): integer;
var
  q: integer;
begin
  result := -1;
  for q := 0 to fBmpToRelease.Count - 1 do
    if PIEVirtualToReleaseBmp(fBmpToRelease[q])^.info = image then
    begin
      result := q;
      break;
    end;
end;

// create a bitmap (must be released with ReleaseBitmap)
function TIEVirtualImageList.GetBitmap(image: pointer): TIEBitmap;
var
  inf: PIEVirtualToReleaseBmp;
  qidx: integer;
begin
  result := nil;
  MapImage(image, [iedRead]);
  if PIEVirtualImageInfo(image)^.ptr <> nil then
  begin
    qidx := BmpToReleaseIndexOf(image);
    if qidx < 0 then
    begin
      result := TIEBitmap.Create;
      new(inf);
      inf^.info := image;
      inf^.bmp := result;
      inf^.refcount := 1;
      fBmpToRelease.Add(inf);
      DirectCopyToBitmap(image, result);
    end
    else
    begin
      // already got
      inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
      inc(inf^.refcount);
      result := inf^.bmp;
    end;
    PIEVirtualImageInfo(image)^.bitmapped := true;
  end;
end;

// release a bitmap created by GetBitmap
// if changed is true copy the bitmap back to internal image
// warning: changed with refcount>1 should make changes lost
procedure TIEVirtualImageList.ReleaseBitmap(bitmap: TIEBitmap; changed: boolean);
var
  q, idx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  if bitmap <> nil then
  begin
    if (bitmap.Location = ieTBitmap) then
      bitmap.UpdateFromTBitmap;
    //
    idx := -1;
    for q := 0 to fBmpToRelease.Count - 1 do
      if PIEVirtualToReleaseBmp(fBmpToRelease[q])^.bmp = bitmap then
      begin
        idx := q;
        break;
      end;
    if idx < 0 then
      exit;
    inf := PIEVirtualToReleaseBmp(fBmpToRelease[idx]);
    dec(inf^.refcount);
    if changed then
    begin
      // copy back
      CopyFromIEBitmap(inf^.info, bitmap);
    end;
    if inf^.refcount = 0 then
    begin
      // free memory
      PIEVirtualImageInfo(inf^.info)^.bitmapped := false;
      FreeAndNil(bitmap);
      dispose(inf);
      fBmpToRelease.Delete(idx);
    end;
  end;
end;

// release a bitmap created by GetBitmap
// if changed is true copy the bitmap back to internal image
// warning: changed with refcount>1 should make changes lost
procedure TIEVirtualImageList.ReleaseBitmapByImage(image: pointer; changed: boolean);
var
  q, idx: integer;
begin
  idx := -1;
  for q := 0 to fBmpToRelease.Count - 1 do
    if PIEVirtualToReleaseBmp(fBmpToRelease[q])^.info = image then
    begin
      idx := q;
      break;
    end;
  if idx < 0 then
    exit;
  ReleaseBitmap(PIEVirtualToReleaseBmp(fBmpToRelease[idx])^.bmp, changed);
end;

function TIEVirtualImageList.GetImageCount: integer;
begin
  result := fImageInfo.Count;
end;

function TIEVirtualImageList.GetImageWidth(image: pointer): integer;
var
  ii: PIEVirtualImageInfo;
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  ii := image;
  if ii^.bitmapped then
  begin
    qidx := BmpToReleaseIndexOf(image);
    inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
    result := inf^.bmp.Width;
  end
  else
    result:=ii^.ImWidth;
end;

function TIEVirtualImageList.GetImageHeight(image: pointer): integer;
var
  ii: PIEVirtualImageInfo;
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  ii := image;
  if ii^.bitmapped then
  begin
    qidx := BmpToReleaseIndexOf(image);
    inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
    result := inf^.bmp.Height;
  end
  else
    result:=ii^.ImHeight;
end;

function TIEVirtualImageList.GetImageOriginalWidth(image: pointer): integer;
begin
  result := PIEVirtualImageInfo(image)^.orig_width;
end;

function TIEVirtualImageList.GetImageOriginalHeight(image: pointer): integer;
begin
  result := PIEVirtualImageInfo(image)^.orig_height;
end;

procedure TIEVirtualImageList.SetImageOriginalWidth(image: pointer; Value: integer);
begin
  PIEVirtualImageInfo(image)^.orig_width := Value;
end;

procedure TIEVirtualImageList.SetImageOriginalHeight(image: pointer; Value: integer);
begin
  PIEVirtualImageInfo(image)^.orig_height := Value;
end;

function TIEVirtualImageList.GetImageBitCount(image: pointer): integer;
var
  ii: PIEVirtualImageInfo;
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  ii := image;
  if ii^.bitmapped then
  begin
    qidx := BmpToReleaseIndexOf(image);
    inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
    result := inf^.bmp.Bitcount;
  end
  else
    result:=ii^.ImBitCount;
end;

function TIEVirtualImageList.GetImagePixelFormat(image: pointer):TIEPixelFormat;
var
  ii: PIEVirtualImageInfo;
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  ii := image;
  if ii^.bitmapped then
  begin
    qidx := BmpToReleaseIndexOf(image);
    inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
    result := inf^.bmp.PixelFormat;
  end
  else
    result:=ii^.imPixelFormat;
end;

function TIEVirtualImageList.GetImageFilePos(image:pointer):int64;
var
  ii: PIEVirtualImageInfo;
begin
  ii := image;
  result:=ii^.pos;
end;

function TIEVirtualImageList.GetImageFromIndex(index:integer):pointer;
begin
  if index=-1 then
    result:=nil
  else
    result:=PIEVirtualImageInfo(fImageInfo[index]);
end;

function TIEVirtualImageList.FindImageIndex(image:pointer):integer;
begin
  result:=fImageInfo.IndexOf(image);
end;


// returned pointer is valid until next call to TIEVirtualDBList class
function TIEVirtualImageList.GetImageBits(image: pointer): pointer;
var
  ii: PIEVirtualImageInfo;
  pbmp: pbyte;
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  result := nil;
  ii := image;
  if ii^.bitmapped then
  begin
    qidx := BmpToReleaseIndexOf(image);
    if qidx >= 0 then
    begin
      inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
      result := inf^.bmp.scanline[inf^.bmp.height - 1];
    end;
  end
  else
  begin
    MapImage(ii, [iedRead]);
    if ii^.ptr <> nil then
    begin
      pbmp := ii^.ptr;
      result := pbmp;
    end;
  end;
end;

function TIEVirtualImageList.GetImagePalette(image:pointer):pointer;
var
  ii: PIEVirtualImageInfo;
  pbmp: pbyte;
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  result := nil;
  ii := image;
  if ii^.bitmapped then
  begin
    qidx := BmpToReleaseIndexOf(image);
    if qidx >= 0 then
    begin
      inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
      result := inf^.bmp.PaletteBuffer;
    end;
  end
  else
  begin
    MapImage(ii, [iedRead]);
    if ii^.ptr <> nil then
    begin
      pbmp := ii^.ptr;
      inc(pbmp, IEBitmapRowLen(ii^.ImWidth, ii^.ImBitCount, 32) * ii^.ImHeight);
      result := pbmp;
    end;
  end;
end;

// returned pointer is valid until next call to TIEVirtualDBList class
function TIEVirtualImageList.GetAlphaBits(image: pointer): pointer;
var
  ii: PIEVirtualImageInfo;
  pbmp: pbyte;
  qidx: integer;
  inf: PIEVirtualToReleaseBmp;
begin
  result := nil;
  ii := image;
  if ii^.HasAlphaChannel then
  begin
    if ii^.bitmapped then
    begin
      qidx := BmpToReleaseIndexOf(image);
      if qidx >= 0 then
      begin
        inf := PIEVirtualToReleaseBmp(fBmpToRelease[qidx]);
        if inf^.bmp.HasAlphaChannel then
          result := inf^.bmp.AlphaChannel.ScanLine[inf^.bmp.height - 1]
        else
          result := nil;
      end;
    end
    else
    begin
      MapImage(ii, [iedRead]);
      if ii^.ptr <> nil then
      begin
        pbmp := ii^.ptr;
        inc(pbmp, IEBitmapRowLen(ii^.ImWidth, ii^.ImBitCount, 32) * ii^.ImHeight);
        if ii^.ImPixelFormat = ie8p then
          inc(pbmp, 256 * sizeof(TRGB));
        if pboolean(pbmp)^ then
          result := nil
        else
        begin
          inc(pbmp, sizeof(boolean));
          result := pbmp;
        end;
      end;
    end;
  end;
end;

procedure TIEVirtualImageList.Delete(image: pointer);
var
  fb: PIEVirtualFreeBlock;
  ii: PIEVirtualImageInfo;
begin
  // make a new entry in the free blocks list (fFreeBlocks)
  ii := image;
  new(fb);
  fb^.pos := ii^.pos;
  fb^.vsize := ii^.vsize;
  fFreeBlocks.Add(fb);

  RemoveImageInfo(fImageInfo.IndexOf(image), true);
  if fImageInfo.Count = 0 then
  begin
    fSize := fAllocationBlock;
    fInsPos := 0;
    ReAllocateBits;
  end;
end;


// end of TIEVirtualImageList.
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

(*
// Sum two 64 bit values, return one 64 value
// return also the carry
// probably there is a better method...
function IEAdd64(op1_lo, op1_hi, op2_lo, op2_hi: dword; result_lo, result_hi: pdword): integer;
var
  v32: dword;
  c: byte;
  q: integer;
begin
  result_lo^ := 0;
  result_hi^ := 0;
  // low
  c := 0;
  for q := 0 to 3 do
  begin
    v32 := pbytearray(@op1_lo)[q] + pbytearray(@op2_lo)[q] + c;
    pbytearray(result_lo)[q] := v32 and $FF;
    if v32 > 255 then
      c := 1
    else
      c := 0;
  end;
  // hi
  for q := 0 to 3 do
  begin
    v32 := pbytearray(@op1_hi)[q] + pbytearray(@op2_hi)[q] + c;
    pbytearray(result_hi)[q] := v32 and $FF;
    if v32 > 255 then
      c := 1
    else
      c := 0;
  end;
  result := c;
end;

// return true if op1>op2
// probably there is a better method...
function IEGreater64(op1_lo, op1_hi, op2_lo, op2_hi: dword): boolean;
var
  q: integer;
  o1, o2: byte;
begin
  result := false;
  // hi
  for q := 3 downto 0 do
  begin
    o1 := pbytearray(@op1_hi)[q];
    o2 := pbytearray(@op2_hi)[q];
    if o1 > o2 then
    begin
      result := true;
      exit;
    end
    else if o1 < o2 then
      exit;
  end;
  // low
  for q := 3 downto 0 do
  begin
    o1 := pbytearray(@op1_lo)[q];
    o2 := pbytearray(@op2_lo)[q];
    if o1 > o2 then
    begin
      result := true;
      exit;
    end
    else if o1 < o2 then
      exit;
  end;
end;

procedure IEMul64(op1, op2: dword; resultlo: pdword; resulthi: pdword);
var
  lo, hi: dword;
begin
  asm
   	push edx
      push eax
		mov eax,op1
      mul op2
      mov lo,eax
      mov hi,edx
      pop eax
      pop edx
  end;
  resultlo^ := lo;
  resulthi^ := hi;
end;
*)

//

procedure SafeStreamWrite(Stream: TStream; var Aborting: boolean; const Buffer; Count: Longint);
begin
  if Stream.Write(Buffer, Count) < Count then
    Aborting := true;
end;

// copy a bitmap/map to a map/bitmap
// dir:  0=map to bitmap
//       1=bitmap to map
// map and bitmap must have some pixel format: exception for from bitmap (pf1bit) to map (24 bit)
procedure IEBitmapMapXCopy(map: pbyte; maprowlen: dword; mapbitcount: dword; bitmap: TBitmap; mapx, mapy, bitmapx, bitmapy, dx, dy: dword; dir: integer);
var
  s1, d1: pbyte;
  rgb: PRGB;
  yy, xx: integer;
  rl: integer;
begin
  case dir of
    0:
      begin
        // copy from map to bitmap
        s1 := map;
        inc(s1, maprowlen * mapy);
        case bitmap.PixelFormat of
          pf1bit:
            begin
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                IECopyBits_large(bitmap.Scanline[yy], s1, bitmapx, mapx, dx, maprowlen);
                inc(s1, maprowlen);
              end;
            end;
          pf8bit:
            begin
              inc(s1, mapx);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx);
                CopyMemory(d1, s1, dx);
                inc(s1, maprowlen);
              end;
            end;
          pf24bit:
            begin
              inc(s1, mapx * 3);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx * 3);
                CopyMemory(d1, s1, dx * 3);
                inc(s1, maprowlen);
              end;
            end;
        end;
      end;
    1:
      begin
        // copy from bitmap to map
        s1 := map;
        inc(s1, maprowlen * mapy);
        case bitmap.PixelFormat of
          pf1bit:
            begin
              if mapbitcount = 24 then
              begin
                // convert 1bit to 24bit
                inc(s1, mapx * 3);
                for yy := bitmapy + dy - 1 downto bitmapy do
                begin
                  rgb := PRGB(s1);
                  d1 := bitmap.scanline[yy];
                  for xx := bitmapx to bitmapx + dx - 1 do
                  begin
                    with rgb^ do
                      if GetPixelbw_inline(d1, xx) <> 0 then
                      begin
                        r := 255;
                        g := 255;
                        b := 255;
                      end
                      else
                      begin
                        r := 0;
                        g := 0;
                        b := 0;
                      end;
                    inc(rgb);
                  end;
                  inc(s1, maprowlen);
                end;
              end
              else
              begin
                rl := _PixelFormat2RowLen(bitmap.width, bitmap.pixelformat);
                for yy := bitmapy + dy - 1 downto bitmapy do
                begin
                  IECopyBits_large(s1, bitmap.Scanline[yy], mapx, bitmapx, dx, rl);
                  inc(s1, maprowlen);
                end;
              end;
            end;
          pf8bit:
            begin
              inc(s1, mapx);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx);
                CopyMemory(s1, d1, dx);
                inc(s1, maprowlen);
              end;
            end;
          pf24bit:
            begin
              inc(s1, mapx * 3);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx * 3);
                CopyMemory(s1, d1, dx * 3);
                inc(s1, maprowlen);
              end;
            end;
        end;
      end;
  end;
end;

// copy a bitmap/map to a map/bitmap
// dir:  0=map to bitmap
//       1=bitmap to map
// map and bitmap must have some pixel format: exception for from bitmap (ie1g) to map (ie24RGB)
procedure IEBitmapMapXCopyEx(map: pbyte; maprowlen: dword; mapbitcount: dword; bitmap: TIEBitmap; mapx, mapy, bitmapx, bitmapy, dx, dy: dword; dir: integer);
var
  s1, d1: pbyte;
  rgb: PRGB;
  yy, xx: integer;
begin
  case dir of
    0:
      begin
        // copy from map to bitmap
        s1 := map;
        inc(s1, maprowlen * mapy);
        case bitmap.PixelFormat of
          ie1g:
            begin
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                IECopyBits_large(bitmap.Scanline[yy], s1, bitmapx, mapx, dx, maprowlen);
                inc(s1, maprowlen);
              end;
            end;
          ie8g, ie8p:
            begin
              inc(s1, mapx);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx);
                CopyMemory(d1, s1, dx);
                inc(s1, maprowlen);
              end;
            end;
          ie24RGB:
            begin
              inc(s1, mapx * 3);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx * 3);
                CopyMemory(d1, s1, dx * 3);
                inc(s1, maprowlen);
              end;
            end;
        end;
      end;
    1:
      begin
        // copy from bitmap to map
        s1 := map;
        inc(s1, maprowlen * mapy);
        case bitmap.PixelFormat of
          ie1g:
            begin
              if mapbitcount = 24 then
              begin
                // convert 1bit to 24bit
                inc(s1, mapx * 3);
                for yy := bitmapy + dy - 1 downto bitmapy do
                begin
                  rgb := PRGB(s1);
                  d1 := bitmap.scanline[yy];
                  for xx := bitmapx to bitmapx + dx - 1 do
                  begin
                    with rgb^ do
                      if GetPixelbw_inline(d1, xx) <> 0 then
                      begin
                        r := 255;
                        g := 255;
                        b := 255;
                      end
                      else
                      begin
                        r := 0;
                        g := 0;
                        b := 0;
                      end;
                    inc(rgb);
                  end;
                  inc(s1, maprowlen);
                end;
              end
              else
                for yy := bitmapy + dy - 1 downto bitmapy do
                begin
                  IECopyBits_large(s1, bitmap.Scanline[yy], mapx, bitmapx, dx, bitmap.RowLen);
                  inc(s1, maprowlen);
                end;
            end;
          ie8g, ie8p:
            begin
              inc(s1, mapx);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx);
                CopyMemory(s1, d1, dx);
                inc(s1, maprowlen);
              end;
            end;
          ie24RGB:
            begin
              inc(s1, mapx * 3);
              for yy := bitmapy + dy - 1 downto bitmapy do
              begin
                d1 := bitmap.Scanline[yy];
                inc(d1, bitmapx * 3);
                CopyMemory(s1, d1, dx * 3);
                inc(s1, maprowlen);
              end;
            end;
        end;
      end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEDibBitmap

constructor TIEDibBitmap.Create;
begin
  inherited;
  fWidth := 0;
  fHeight := 0;
  fBitCount := 0;
  fHDC := 0;
  fDIB := 0;
  fBits := nil;
  ZeroMemory(@fBitmapInfoHeader1, sizeof(TBitmapInfoHeader256));
  with fBitmapInfoHeader1 do
  begin
    biSize := sizeof(TBitmapInfoHeader);
    biPlanes := 1;
    Palette[1].rgbRed := 255;
    Palette[1].rgbGreen := 255;
    Palette[1].rgbBlue := 255;
    biCompression := BI_RGB;
  end;
end;

destructor TIEDibBitmap.Destroy;
begin
  FreeBits;
  inherited;
end;

function TIEDibBitmap.GetBitCount: integer;
begin
  result := fBitCount;
end;

function TIEDibBitmap.GetWidth: integer;
begin
  result := fWidth;
end;

function TIEDibBitmap.GetHeight: integer;
begin
  result := fHeight;
end;

{!!
<FS>TIEDibBitmap.PixelFormat

<FM>Declaration<FC>
property PixelFormat: <A TIEPixelFormat>

<FM>Description<FN>
Sets/gets the pixel format.
!!}
function TIEDibBitmap.GetPixelFormat: TIEPixelFormat;
begin
  case fBitCount of
    1: result := ie1g;
    24: result := ie24RGB;
  else
    result := ienull;
  end;
end;

function TIEDibBitmap.GetRowLen: integer;
begin
  result := fRowLen;
end;

{!!
<FS>TIEDibBitmap.Allocate

<FM>Declaration<FC>
function Allocate(ImageWidth, ImageHeight: integer; ImagePixelFormat: TIEPixelFormat):boolean;

<FM>Description<FN>
Allocates a new windows DIB section of the specified size and pixel format.
<FC>ImagePixelFormat<FN> can be ie1g or ie24RGB.
Returns True on successfull.
!!}
function TIEDibBitmap.Allocate(ImageWidth, ImageHeight: integer; ImagePixelFormat: TIEPixelFormat):boolean;
begin
  result:=false;
  if ImagePixelFormat = ie1g then
    result:=AllocateBits(ImageWidth, ImageHeight, 1)
  else if ImagePixelFormat = ie24RGB then
    result:=AllocateBits(ImageWidth, ImageHeight, 24);
end;

{!!
<FS>TIEDibBitmap.AllocateBits

<FM>Declaration<FC>
function AllocateBits(BmpWidth, BmpHeight, BmpBitCount: dword):boolean;

<FM>Description<FN>
Allocates a new windows DIB section of the specified size and bitcount.
<FC>BmpBitCount<FN> can be 1 or 24.
Returns True on successful.
!!}
function TIEDibBitmap.AllocateBits(BmpWidth, BmpHeight, BmpBitCount: dword):boolean;
begin
  result:=false;
  if (BmpWidth > 0) and (BmpHeight > 0) (*and ((BmpBitCount=1) or (BmpBitCount=24))*) then
  begin
    FreeBits;
    fBitCount := BmpBitCount;
    fWidth := BmpWidth;
    fHeight := BmpHeight;
    fRowLen := IEBitmapRowLen(fWidth, BmpBitCount, 32);
    fHDC := CreateCompatibleDC(0);
    if fHDC=0 then
      exit;
    with fBitmapInfoHeader1 do
    begin
      biBitCount := BmpBitCount;
      biWidth := BmpWidth;
      biHeight := BmpHeight;
      biSizeImage := fRowLen * fHeight;
    end;
    fDIB := CreateDIBSection(fHDC, PBITMAPINFO(@fBitmapInfoHeader1)^, DIB_RGB_COLORS, fBits, 0, 0);
    if fDIB=0 then
      exit;
    SelectObject(fHDC, fDIB);
    result:=true;
  end;
end;

{!!
<FS>TIEDibBitmap.FreeBits

<FM>Declaration<FC>
procedure FreeBits;

<FM>Description<FN>
Frees the allocated DIB section.
!!}
procedure TIEDibBitmap.FreeBits;
begin
  if fDIB <> 0 then
    DeleteObject(fDIB);
  fDIB := 0;
  if fHDC <> 0 then
    DeleteDC(fHDC);
  fHDC := 0;
  fBits := nil;
  fWidth := 0;
  fHeight := 0;
  fBitCount := 0;
end;

function TIEDibBitmap.GetScanline(row: integer): pointer;
begin
  result := pointer(int64(DWORD(fBits)) + (fHeight - int64(row) - 1) * fRowlen);
end;

{!!
<FS>TIEDibBitmap.CopyToTBitmap

<FM>Declaration<FC>
procedure CopyToTBitmap(Dest: TBitmap);

<FM>Description<FN>
Copies the DIB bitmap to a TBitmap object.
!!}
procedure TIEDibBitmap.CopyToTBitmap(Dest: TBitmap);
var
  row: integer;
begin
  Dest.Width := 1;
  Dest.Height := 1;
  case fBitCount of
    1: Dest.PixelFormat := pf1bit;
    24: Dest.PixelFormat := pf24bit;
  end;
  Dest.Width := fWidth;
  Dest.Height := fHeight;
  for row := 0 to fHeight - 1 do
    CopyMemory(Dest.Scanline[row], Scanline[row], fRowLen);
end;

{!!
<FS>TIEDibBitmap.Assign

<FM>Declaration<FC>
procedure Assign(Source: TObject);

<FM>Description<FN>
Copies the DIB bitmap from another TIEDibBitmap object (<FC>Source<FN>).
!!}
// only for TIEDibBitmap
procedure TIEDibBitmap.Assign(Source: TObject);
var
  src: TIEDibBitmap;
begin
  if Source is TIEDibBitmap then
  begin
    src := Source as TIEDibBitmap;
    AllocateBits(src.Width, src.Height, src.BitCount);
    CopyMemory(fBits, src.fBits, fRowlen * fHeight);
  end;
end;

function TIEDibBitmap.GetPalette(index: integer): TRGB;
begin
  // not supported
  result := CreateRGB(0,0,0);
end;

function TIEDibBitmap.GetPaletteBuffer:pointer;
begin
  // not supported;
  result := nil;
end;

procedure TIEDibBitmap.SetPalette(index: integer; Value: TRGB);
begin
  // not supported
end;

function TIEDibBitmap.GetPaletteLen:integer;
begin
  // not supported
  result:=0;
end;

procedure TIEDibBitmap.CopyPaletteTo(Dest:TIEBaseBitmap);
begin
  // not supported
end;


// end of TIEDibBitmap
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEWorkBitmap

constructor TIEWorkBitmap.Create(BmpWidth, BmpHeight, BmpBitCount: integer);
begin
  inherited Create;
  fWidth := 0;
  fHeight := 0;
  fBitCount := 0;
  fRowLen := 0;
  fBits := nil;
  if (BmpWidth > 0) and (BmpHeight > 0) then
    AllocateBits(BmpWidth, BmpHeight, BmpBitCount);
end;

destructor TIEWorkBitmap.Destroy;
begin
  FreeBits;
  inherited;
end;

function TIEWorkBitmap.GetScanline(row: integer): pointer;
begin
  result := pointer(int64(DWORD(fBits)) + int64((fHeight - row - 1) * fRowlen));
end;

function TIEWorkBitmap.GetPByte(row, col: integer): pbyte;
begin
  result := pbyte(int64(DWORD(fBits)) + int64((fHeight - row - 1) * fRowlen + col));
end;

function TIEWorkBitmap.GetPRGB(row, col: integer): PRGB;
begin
  result := PRGB(int64(DWORD(fBits)) + int64((fHeight - row - 1) * fRowlen + col * 3));
end;

function TIEWorkBitmap.GetPDouble(row, col: integer): PDouble;
begin
  result := PDouble(int64(DWORD(fBits)) + int64((fHeight - row - 1) * fRowlen + col * 8));
end;

function TIEWorkBitmap.GetPSingle(row, col: integer): PSingle;
begin
  result := PSingle(int64(DWORD(fBits)) + int64((fHeight - row - 1) * fRowlen + col * 4));
end;

function TIEWorkBitmap.GetPInteger(row, col: integer): pinteger;
begin
  result := pinteger(int64(DWORD(fBits)) + int64((fHeight - row - 1) * fRowlen + col * 4));
end;

procedure TIEWorkBitmap.SetBit(row, col: integer; value: integer);
var
  bp: pbyte;
begin
  bp := pbyte(int64(DWORD(fBits)) + int64((fHeight - row - 1) * fRowlen + (col shr 3)));
  if value <> 0 then
    bp^ := bp^ or iebitmask1[col and 7]
  else
    bp^ := bp^ and not iebitmask1[col and 7];
end;

procedure TIEWorkBitmap.AllocateBits(BmpWidth, BmpHeight, BmpBitCount: integer);
begin
  if (BmpWidth <> fWidth) or (BmpHeight <> fHeight) or (BmpBitCount <> fBitCount) then
  begin
    FreeBits;
    fBitCount := BmpBitCount;
    fWidth := BmpWidth;
    fHeight := BmpHeight;
    fRowLen := IEBitmapRowLen(fWidth, BmpBitCount, 32);
    //getmem(fBits, fRowLen * fHeight);
    fBits := IEAutoAlloc(fRowLen * fHeight);  // 2.2.4rc2
  end;
end;

procedure TIEWorkBitmap.FreeBits;
begin
  if fBits <> nil then
    //freemem(fBits);
    IEAutoFree(fBits);
  fWidth := 0;
  fHeight := 0;
  fBitCount := 0;
  fRowLen := 0;
  fBits := nil;
end;

// TIEWorkBitmap
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// EXIF SUPPORT FUNCTIONS

procedure CopyEXIF(source, dest: TIOParamsVals);
var
  q: integer;
begin
  IECopyTList(source.EXIF_Tags, dest.EXIF_Tags);
  dest.EXIF_ImageDescription := source.TIFF_ImageDescription;
  dest.EXIF_Make := source.EXIF_Make;
  dest.EXIF_Model := source.EXIF_Model;
  dest.EXIF_Orientation := source.EXIF_Orientation;
  dest.EXIF_XResolution := source.EXIF_XResolution;
  dest.EXIF_YResolution := source.EXIF_YResolution;
  dest.EXIF_ResolutionUnit := source.EXIF_ResolutionUnit;
  dest.EXIF_Software := source.EXIF_Software;
  dest.EXIF_XPRating := source.EXIF_XPRating;
  dest.EXIF_XPTitle := source.EXIF_XPTitle;
  dest.EXIF_XPComment := source.EXIF_XPComment;
  dest.EXIF_XPAuthor := source.EXIF_XPAuthor;
  dest.EXIF_XPKeywords := source.EXIF_XPKeywords;
  dest.EXIF_XPSubject := source.EXIF_XPSubject;
  dest.EXIF_Artist := source.EXIF_Artist;
  dest.EXIF_DateTime := source.EXIF_DateTime;
  dest.EXIF_WhitePoint[0] := source.EXIF_WhitePoint[0];
  dest.EXIF_WhitePoint[1] := source.EXIF_WhitePoint[1];
  for q := 0 to 5 do
    dest.EXIF_PrimaryChromaticities[q] := source.EXIF_PrimaryChromaticities[q];
  for q := 0 to 2 do
    dest.EXIF_YCbCrCoefficients[q] := source.EXIF_YCbCrCoefficients[q];
  dest.EXIF_YCbCrPositioning := source.EXIF_YCbCrPositioning;
  for q := 0 to 5 do
    dest.EXIF_ReferenceBlackWhite[q] := source.EXIF_ReferenceBlackWhite[q];
  dest.EXIF_Copyright := source.EXIF_Copyright;
  dest.EXIF_ExposureTime := source.EXIF_ExposureTime;
  dest.EXIF_FNumber := source.EXIF_FNumber;
  dest.EXIF_ExposureProgram := source.EXIF_ExposureProgram;
  dest.EXIF_ISOSpeedRatings[0] := source.EXIF_ISOSpeedRatings[0];
  dest.EXIF_ISOSpeedRatings[1] := source.EXIF_ISOSpeedRatings[1];
  dest.EXIF_ExifVersion := source.EXIF_ExifVersion;
  dest.EXIF_DateTimeOriginal := source.EXIF_DateTimeOriginal;
  dest.EXIF_DateTimeDigitized := source.EXIF_DateTimeDigitized;
  dest.EXIF_CompressedBitsPerPixel := source.EXIF_CompressedBitsPerPixel;
  dest.EXIF_ShutterSpeedValue := source.EXIF_ShutterSpeedValue;
  dest.EXIF_ApertureValue := source.EXIF_ApertureValue;
  dest.EXIF_BrightnessValue := source.EXIF_BrightnessValue;
  dest.EXIF_ExposureBiasValue := source.EXIF_ExposureBiasValue;
  dest.EXIF_MaxApertureValue := source.EXIF_MaxApertureValue;
  dest.EXIF_SubjectDistance := source.EXIF_SubjectDistance;
  dest.EXIF_MeteringMode := source.EXIF_MeteringMode;
  dest.EXIF_LightSource := source.EXIF_LightSource;
  dest.EXIF_Flash := source.EXIF_Flash;
  dest.EXIF_FocalLength := source.EXIF_FocalLength;
  dest.EXIF_SubsecTime := source.EXIF_SubsecTime;
  dest.EXIF_SubsecTimeOriginal := source.EXIF_SubsecTimeOriginal;
  dest.EXIF_SubsecTimeDigitized := source.EXIF_SubsecTimeDigitized;
  dest.EXIF_FlashPixVersion := source.EXIF_FlashPixVersion;
  dest.EXIF_ColorSpace := source.EXIF_ColorSpace;
  dest.EXIF_ExifImageWidth := source.EXIF_ExifImageWidth;
  dest.EXIF_ExifImageHeight := source.EXIF_ExifImageHeight;
  dest.EXIF_RelatedSoundFile := source.EXIF_RelatedSoundFile;
  dest.EXIF_FocalPlaneXResolution := source.EXIF_FocalPlaneXResolution;
  dest.EXIF_FocalPlaneYResolution := source.EXIF_FocalPlaneYResolution;
  dest.EXIF_FocalPlaneResolutionUnit := source.EXIF_FocalPlaneResolutionUnit;
  dest.EXIF_ExposureIndex := source.EXIF_ExposureIndex;
  dest.EXIF_SensingMethod := source.EXIF_SensingMethod;
  dest.EXIF_FileSource := source.EXIF_FileSource;
  dest.EXIF_SceneType := source.EXIF_SceneType;
  dest.EXIF_UserComment := source.EXIF_UserComment;
  dest.EXIF_UserCommentCode := source.EXIF_UserCommentCode;
  dest.EXIF_MakerNote.Assign(source.EXIF_MakerNote);
  dest.EXIF_ExposureMode:=source.EXIF_ExposureMode;
  dest.EXIF_WhiteBalance:=source.EXIF_WhiteBalance;
  dest.EXIF_DigitalZoomRatio:=source.EXIF_DigitalZoomRatio;
  dest.EXIF_FocalLengthIn35mmFilm:=source.EXIF_FocalLengthIn35mmFilm;
  dest.EXIF_SceneCaptureType:=source.EXIF_SceneCaptureType;
  dest.EXIF_GainControl:=source.EXIF_GainControl;
  dest.EXIF_Contrast:=source.EXIF_Contrast;
  dest.EXIF_Saturation:=source.EXIF_Saturation;
  dest.EXIF_Sharpness:=source.EXIF_Sharpness;
  dest.EXIF_SubjectDistanceRange:=source.EXIF_SubjectDistanceRange;
  dest.EXIF_ImageUniqueID:=source.EXIF_ImageUniqueID;
  dest.EXIF_GPSVersionID:=Source.EXIF_GPSVersionID;
  dest.EXIF_GPSLatitudeRef:=Source.EXIF_GPSLatitudeRef;
  dest.EXIF_GPSLatitudeDegrees:=Source.EXIF_GPSLatitudeDegrees;
  dest.EXIF_GPSLatitudeMinutes:=Source.EXIF_GPSLatitudeMinutes;
  dest.EXIF_GPSLatitudeSeconds:=Source.EXIF_GPSLatitudeSeconds;
  dest.EXIF_GPSLongitudeRef:=Source.EXIF_GPSLongitudeRef;
  dest.EXIF_GPSLongitudeDegrees:=Source.EXIF_GPSLongitudeDegrees;
  dest.EXIF_GPSLongitudeMinutes:=Source.EXIF_GPSLongitudeMinutes;
  dest.EXIF_GPSLongitudeSeconds:=Source.EXIF_GPSLongitudeSeconds;
  dest.EXIF_GPSAltitudeRef:=Source.EXIF_GPSAltitudeRef;
  dest.EXIF_GPSAltitude:=Source.EXIF_GPSAltitude;
  dest.EXIF_GPSTimeStampHour:=Source.EXIF_GPSTimeStampHour;
  dest.EXIF_GPSTimeStampMinute:=Source.EXIF_GPSTimeStampMinute;
  dest.EXIF_GPSTimeStampSecond:=Source.EXIF_GPSTimeStampSecond;
  dest.EXIF_GPSSatellites:=Source.EXIF_GPSSatellites;
  dest.EXIF_GPSStatus:=Source.EXIF_GPSStatus;
  dest.EXIF_GPSMeasureMode:=Source.EXIF_GPSMeasureMode;
  dest.EXIF_GPSDOP:=Source.EXIF_GPSDOP;
  dest.EXIF_GPSSpeedRef:=Source.EXIF_GPSSpeedRef;
  dest.EXIF_GPSSpeed:=Source.EXIF_GPSSpeed;
  dest.EXIF_GPSTrackRef:=Source.EXIF_GPSTrackRef;
  dest.EXIF_GPSTrack:=Source.EXIF_GPSTrack;
  dest.EXIF_GPSImgDirectionRef:=Source.EXIF_GPSImgDirectionRef;
  dest.EXIF_GPSImgDirection:=Source.EXIF_GPSImgDirection;
  dest.EXIF_GPSMapDatum:=Source.EXIF_GPSMapDatum;
  dest.EXIF_GPSDestLatitudeRef:=Source.EXIF_GPSDestLatitudeRef;
  dest.EXIF_GPSDestLatitudeDegrees:=Source.EXIF_GPSDestLatitudeDegrees;
  dest.EXIF_GPSDestLatitudeMinutes:=Source.EXIF_GPSDestLatitudeMinutes;
  dest.EXIF_GPSDestLatitudeSeconds:=Source.EXIF_GPSDestLatitudeSeconds;
  dest.EXIF_GPSDestLongitudeRef:=Source.EXIF_GPSDestLongitudeRef;
  dest.EXIF_GPSDestLongitudeDegrees:=Source.EXIF_GPSDestLongitudeDegrees;
  dest.EXIF_GPSDestLongitudeMinutes:=Source.EXIF_GPSDestLongitudeMinutes;
  dest.EXIF_GPSDestLongitudeSeconds:=Source.EXIF_GPSDestLongitudeSeconds;
  dest.EXIF_GPSDestBearingRef:=Source.EXIF_GPSDestBearingRef;
  dest.EXIF_GPSDestBearing:=Source.EXIF_GPSDestBearing;
  dest.EXIF_GPSDestDistanceRef:=Source.EXIF_GPSDestDistanceRef;
  dest.EXIF_GPSDestDistance:=Source.EXIF_GPSDestDistance;
  dest.EXIF_GPSDateStamp:=Source.EXIF_GPSDateStamp;
end;

// return a pointer (to free!)
// if savePreamble=true, will save 'Exif/0/0' before TIFF data
procedure SaveEXIFToStandardBuffer(params: TObject; var Buffer: pointer; var BufferLength: integer; savePreamble:boolean);
const
  EXF:AnsiString = 'Exif'#0#0;
var
  ioparams, tempParams: TIOParamsVals;
  ms: TMemoryStream;
  nullpr: TProgressRec;
  fAbort: boolean;
begin
  Buffer := nil;
  BufferLength := 0;
  fAbort := false;
  with nullpr do
  begin
    Aborting := @fAbort;
    fOnProgress := nil;
    Sender := nil;
  end;
  ioparams := TIOParamsVals(Params);
  ms := TMemoryStream.Create;

  try
    TIFFWriteStream(ms, false, nil, ioparams, nullpr);
    // EXIF Thumbnail (EXIF_Bitmap)
    if assigned(ioparams.EXIF_Bitmap) and not ioparams.EXIF_Bitmap.IsEmpty then
    begin
      ms.Position:=0;
      tempParams:=TIOParamsVals.Create(nil);
      tempParams.TIFF_ImageIndex:=1;
      tempParams.TIFF_Compression:=ioTIFF_OLDJPEG;
      TIFFWriteStream(ms, true, ioparams.EXIF_Bitmap, tempParams, nullpr);
      tempParams.Free;
    end;

    if savePreamble then
    begin
      BufferLength := ms.Size + 6;
      getmem(Buffer, BufferLength);
      move(EXF[1], pbyte(Buffer)^, 6);
      move(pbyte(ms.Memory)^, PAnsiChar(Buffer)[6], BufferLength - 6);
    end
    else
    begin
      BufferLength := ms.Size;
      getmem(Buffer, BufferLength);
      move(pbyte(ms.Memory)^, pbyte(Buffer)^, BufferLength);
    end;
  finally
    FreeAndNil(ms);
  end;
end;

function CheckEXIFFromStandardBuffer(Buffer:pointer; BufferLength:integer):boolean;
begin
  result := (PAnsiChar(Buffer) = 'Exif');
end;

// usable only when the TIFF contains a single page
function LoadEXIFFromStandardBuffer(Buffer: pointer; BufferLength: integer; params: TObject): boolean;
var
  ioparams: TIOParamsVals;
  tmpio: TIOParamsVals;
  ms: TMemoryStream;
  numi: integer;
  nullpr: TProgressRec;
  fAbort: boolean;
  tempAlphaChannel: TIEMask;
begin
  result := false;
  if PAnsiChar(Buffer) <> 'Exif' then
    exit;
  //
  ioparams := TIOParamsVals(Params);
  tmpio := TIOParamsVals.Create(ioparams.ImageEnIO);
  ms := TMemoryStream.Create;
  ms.Write(pbytearray(Buffer)[6], BufferLength - 6);
  ms.position := 0;
  fAbort := false;
  with nullpr do
  begin
    Aborting := @fAbort;
    fOnProgress := nil;
    Sender := nil;
  end;
  // load data
  if not assigned(ioparams.EXIF_Bitmap) then
    ioparams.EXIF_Bitmap := TIEBitmap.Create;
  ioparams.EXIF_Bitmap.FreeImage(true);
  tempAlphaChannel := nil;
  TIFFReadStream(ioparams.EXIF_Bitmap, ms, numi, tmpio, nullpr, true, tempAlphaChannel, true, true, false);
  CopyEXIF(tmpio, ioparams);
  ioparams.EXIF_HasEXIFData := true;
  // load thumbnail
  tmpio.TIFF_ImageIndex := 1;
  ms.position := 0;
  fAbort := false;
  tempAlphaChannel := nil;
  TIFFReadStream(ioparams.EXIF_Bitmap, ms, numi, tmpio, nullpr, false, tempAlphaChannel, true, true, true);
  if fAbort then
    ioparams.EXIF_Bitmap.FreeImage(true);
  IEAdjustEXIFOrientation(ioparams.EXIF_Bitmap,ioparams.TIFF_Orientation);
  FreeAndNil(ms);
  //
  FreeAndNil(tmpio);
  result := true;
end;

// returns the position of the first EXIF data block
// -1 = not found
// saves stream position
function IESearchEXIFInfo(Stream:TStream):int64;
const
  magic1:PAnsiChar='Exif'#0#0;
  BUFBLOCK=65536*2;
var
  lsave:int64;
  buf:PAnsiChar;
  tiffhe:TTIFFHeader;
  bufpos:integer;
  StreamSize:int64;
begin
  result:=-1;
  lsave:=Stream.Position;

  StreamSize:=Stream.Size;

  getmem(buf,BUFBLOCK);
  Stream.Read(buf^,BUFBLOCK);

  bufpos:=0;
  while bufpos<BUFBLOCK do
  begin
    move(buf[bufpos],tiffhe,sizeof(TTIFFHeader));
    if (tiffhe.Id=$4949) or (tiffhe.Id=$4D4D) then
    begin
      if (tiffhe.Id=$4D4D) then
      begin
        // motorola
        tiffhe.Ver:=IESwapWord(tiffhe.Ver);
        tiffhe.PosIFD:=IESwapDWord(tiffhe.PosIFD);
      end;
      if (tiffhe.PosIFD<StreamSize) then  // 3.0.4
      begin
        if ((tiffhe.Ver=42) or (tiffhe.Ver=20306) or (tiffhe.Ver=21330)) then
        begin
          result:=bufpos;
          break;
        end;
      end;
    end;
    inc(bufpos);
  end;

  freemem(buf);

  Stream.Position:=lsave;
end;

// usable only when the TIFF contains a single page
function IELoadEXIFFromTIFF(Stream:TStream; params: TObject): boolean;
var
  ioparams: TIOParamsVals;
  tmpio: TIOParamsVals;
  numi: integer;
  nullpr: TProgressRec;
  fAbort: boolean;
  tempAlphaChannel: TIEMask;
  lsave:int64;
  bmp1,bmp2:TIEBitmap;
begin
  lsave:=Stream.Position;
  ioparams := TIOParamsVals(Params);
  tmpio := TIOParamsVals.Create(ioparams.ImageEnIO);
  bmp1:=TIEBitmap.Create;
  bmp2:=TIEBitmap.Create;

  try

    fAbort := false;
    with nullpr do
    begin
      Aborting := @fAbort;
      fOnProgress := nil;
      Sender := nil;
    end;
    // load data
    if not assigned(ioparams.EXIF_Bitmap) then
      ioparams.EXIF_Bitmap := TIEBitmap.Create;
    ioparams.EXIF_Bitmap.FreeImage(true);
    tempAlphaChannel := nil;
    TIFFReadStream(ioparams.EXIF_Bitmap, Stream, numi, tmpio, nullpr, true, tempAlphaChannel, true, true, false);
    CopyEXIF(tmpio, ioparams);
    ioparams.EXIF_HasEXIFData := true;

    // load thumbnail, try image 0
    tmpio.TIFF_ImageIndex := 0;
    tempAlphaChannel := nil;
    Stream.Position:=lsave;
    fAbort:=false;
    TIFFReadStream(bmp1, Stream, numi, tmpio, nullpr, false, tempAlphaChannel, true, true, true);
    // try image 1
    tmpio.TIFF_ImageIndex := 1;
    tempAlphaChannel := nil;
    Stream.Position:=lsave;
    fAbort:=false;
    TIFFReadStream(bmp2, Stream, numi, tmpio, nullpr, false, tempAlphaChannel, true, true, true);

    if (bmp1.Width>0) and ((bmp1.Width<bmp2.Width) or (bmp2.Width=0)) and not bmp1.IsAllBlack then
      ioparams.EXIF_Bitmap.Assign( bmp1 )
    else if (bmp2.Width>0) and ((bmp2.Width<bmp1.Width) or (bmp1.Width=0)) and not bmp2.IsAllBlack  then
      ioparams.EXIF_Bitmap.Assign( bmp2 );

  finally
    bmp1.free;
    bmp2.free;
    FreeAndNil(tmpio);
    result := true;
    Stream.Position:=lsave;
  end;
end;

function IELoadEXIFFromTIFF(Stream:TStream; params: TObject; page:integer): boolean;
var
  ioparams: TIOParamsVals;
  numi: integer;
  nullpr: TProgressRec;
  fAbort: boolean;
  tempAlphaChannel: TIEMask;
  lsave:int64;
begin
  lsave:=Stream.Position;
  ioparams := TIOParamsVals(Params);

  try

    fAbort := false;
    with nullpr do
    begin
      Aborting := @fAbort;
      fOnProgress := nil;
      Sender := nil;
    end;
    // load data
    if not assigned(ioparams.EXIF_Bitmap) then
      ioparams.EXIF_Bitmap := TIEBitmap.Create;
    ioparams.EXIF_Bitmap.FreeImage(true);
    tempAlphaChannel := nil;
    TIFFReadStream(ioparams.EXIF_Bitmap, Stream, numi, ioparams, nullpr, true, tempAlphaChannel, true, true, false);

  finally
    result := true;
    Stream.Position:=lsave;
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


function IEGetOpSys: TIEOpSys;
var
  ver: TOSVersionInfo;
begin
  result := ieosUnknown;
  ver.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if not GetVersionEx(ver) then
    Exit;
  case ver.dwPlatformId of
    VER_PLATFORM_WIN32_WINDOWS:
      begin
        if (ver.dwMajorVersion=4) then
        begin
          if (ver.dwMinorVersion=0) then
            result:=ieosWin95
          else if (ver.dwMinorVersion=10) then
            result:=ieosWin98
          else if  (ver.dwMinorVersion=90) then
            result:=ieosWinME;
        end;
      end;
    VER_PLATFORM_WIN32_NT:
      begin
        if (ver.dwMajorVersion=4) and (ver.dwMinorVersion=0) then
          result:=ieosWinNT4
        else if (ver.dwMajorVersion=5) and (ver.dwMinorVersion=0) then
          result:=ieosWin2000
        else if (ver.dwMajorVersion=5) and (ver.dwMinorVersion=1) then
          result:=ieosWinXP
        else if (ver.dwMajorVersion=5) and (ver.dwMinorVersion=2) then
          result:=ieosWin2003
        else if (ver.dwMajorVersion=6) and (ver.dwMinorVersion=0) then
          result:=ieosWinVista
        else if (ver.dwMajorVersion=6) and (ver.dwMinorVersion=1) then
          result:=ieosWin7;
      end;
  end;
end;


function IEStrToFloatDefA(s: AnsiString; Def: extended): extended;
var
  q: integer;
begin
  if not TextToFloat(PAnsiChar(s), result, fvExtended) then
  begin
    q := IEPos(',', s);
    if q > 0 then
      s[q] := '.'
    else
    begin
      q := IEPos('.', s);
      if q > 0 then
        s[q] := ',';
    end;
    if not TextToFloat(PAnsiChar(s), result, fvExtended) then
      result := Def;
  end;
end;

function IEStrToFloatDefW(s: WideString; Def: extended): extended;
begin
  result := IEStrToFloatDefA(AnsiString(s),Def);
end;

function IEStrToFloatDefS(s: String; Def: extended): extended;
begin
  result := IEStrToFloatDefA(AnsiString(s),Def);
end;

function IEStrToFloatDef(s: String; Def: extended): extended;
begin
  result := IEStrToFloatDefA(AnsiString(s),Def);
end;

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


// L: 0..255
// A: -127...127
// B: -127...127
function IERGB2CIELAB(rgb: TRGB): TCIELAB;
var
  X, Y, Z, fX, fY, fZ:double;
  RR, GG, BB:double;
  L:double;
begin
  RR := rgb.r / 255.0;
  GG := rgb.g / 255.0;
  BB := rgb.b / 255.0;

  if (RR > 0.04045) then
    RR := IEPower2(((RR + 0.055) / 1.055), 2.4)
  else
    RR := RR / 12.92;
  if (GG > 0.04045) then
    GG := IEPower2(((GG + 0.055) / 1.055), 2.4)
  else
    GG := GG / 12.92;
  if (BB > 0.04045) then
    BB := IEPower2(((BB + 0.055) / 1.055), 2.4)
  else
    BB := BB / 12.92;

  X := (0.412453*RR + 0.357580*GG + 0.180423*BB) / 0.95047;
  Y := (0.212671*RR + 0.715160*GG + 0.072169*BB);
  Z := (0.019334*RR + 0.119193*GG + 0.950227*BB) / 1.088883;

  if (Y > 0.008856) then
  begin
    fY := IEPower2(Y, 1.0/3.0);
    L := 116.0*fY - 16.0;
  end
  else
  begin
    fY := 7.787*Y + 16.0/116.0;
    L := 903.3*Y;
  end;

  if (X > 0.008856) then
    fX := IEPower2(X, 1.0/3.0)
  else
    fX := 7.787*X + 16.0/116.0;

  if (Z > 0.008856) then
    fZ := IEPower2(Z, 1.0/3.0)
  else
    fZ := 7.787*Z + 16.0/116.0;

  result.L := trunc(L*2.5);
  result.a := trunc(500.0*(fX - fY));
  result.b := trunc(200.0*(fY - fZ));
end;

function IECIELAB2RGB(const lab:TCIELAB):TRGB;
var
  var_R, var_G, var_B:double;
  X, Y, Z:double;
begin
  with lab do
  begin
    Y := ( L*0.39215686275 + 16 ) / 116;
    X := a / 500 + Y;
    Z := Y - b / 200;
  end;

	if ( IEPower2(Y, 3) > 0.008856 ) then
		Y := IEPower2(Y, 3)
	else
		Y := ( Y - 0.13793103448 ) / 7.787;

	if ( IEPower2(X, 3) > 0.008856 ) then
		X := IEPower2(X, 3)
	else
		X := ( X - 0.13793103448 ) / 7.787;

	if ( IEPower2(Z, 3) > 0.008856 ) then
		Z := IEPower2(Z, 3)
	else
		Z := ( Z - 0.13793103448 ) / 7.787;

  X := X * 0.95047;
  Z := Z * 1.08883;

	var_R := X * 3.2406 +    Y * (-1.5372) + Z * (-0.4986);
	var_G := X * (-0.9689) + Y * 1.8758 +    Z * 0.0415;
	var_B := X * 0.0557 +    Y * (-0.2040) + Z * 1.0570;

	if ( var_R > 0.0031308 ) then
		var_R := 1.055 * ( IEPower2(var_R, 0.41666666667) ) - 0.055
	else
		var_R := 12.92 * var_R;

	if ( var_G > 0.0031308 ) then
		var_G := 1.055 * ( IEPower2(var_G, 0.41666666667) ) - 0.055
	else
		var_G := 12.92 * var_G;

	if ( var_B > 0.0031308 ) then
		var_B := 1.055 * ( IEPower2(var_B, 0.41666666667) ) - 0.055
	else
		var_B := 12.92 * var_B;

  with result do
  begin
    r := blimit(round(var_R * 255));
    g := blimit(round(var_G * 255));
    b := blimit(round(var_B * 255));
  end;
end;



// draw a 3d rect
procedure IEDraw3DRect(Canvas: TCanvas; x1, y1, x2, y2: integer; cl1, cl2: TColor);
begin
  with Canvas do
  begin
    Pen.Mode := pmCopy;
    Pen.Style := psSolid;
    Pen.Color := cl1;
    Pen.Width := 1;
    MoveTo(x1, y2);
    LineTo(x1, y1);
    LineTo(x2, y1);
    Pen.Color := cl2;
    MoveTo(x1, y2);
    LineTo(x2, y2);
    LineTo(x2, y1);
  end;
end;

// the same of IEDraw3DRect but using TIECanvas
// Canvas must be TIECanvas
procedure IEDraw3DRect2(Canvas: TObject; x1, y1, x2, y2: integer; cl1, cl2: TColor);
begin
  with Canvas as TIECanvas do
  begin
    Pen.Mode := pmCopy;
    Pen.Style := psSolid;
    Pen.Color := cl1;
    MoveTo(x1, y2);
    LineTo(x1, y1);
    LineTo(x2, y1);
    Pen.Color := cl2;
    MoveTo(x1, y2);
    LineTo(x2, y2);
    LineTo(x2, y1);
  end;
end;


////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
// TIEBitmap

const
  PIXELFORMAT2BITCOUNT:      array [TIEPixelFormat] of integer = (0, 1, 8, 8, 16, 24, 32, 32, 48, 24, 32);
  PIXELFORMAT2CHANNELCOUNT: array [TIEPixelFormat] of integer = (0, 1, 1, 1,  1,  3,  1,  4,  3,  3, 4);

{!!
<FS>TIEBitmap.Create

<FM>Declaration<FC>
constructor Create;
constructor Create(ImageWidth,ImageHeight:integer; ImagePixelFormat:<A TIEPixelFormat> = ie24RGB);
constructor Create(const FileName:string; IOParams:<A TIOParamsVals> = nil);
constructor Create(image:TIEBitmap);

<FM>Description<FN>
Creates a new TIEBitmap object.
The second overload creates the bitmap using specified parameters.
Third overload loads image from specified file. <FC>IOParams<FN> specifies the in/out parameters as <A TIOParamsVals> objects.
Fourth overload creates a clone of source image.


<FM>Examples<FC>

// creates an empty image
bmp1 := TIEBitmap.Create;

// creates 1000x1000, 24 bit RGB image
bmp2 := TIEBitmap.Create(1000, 1000, ie24RGB);

// creates an image from file "input.png"
bmp2 := TIEBitmap.Create("input.png");

// creates a clone of bmp2
bmp3 := TIEBitmap.Create(bmp2);
!!}
constructor TIEBitmap.Create;
var
  fm: int64;
  i:integer;
begin
  inherited;
  fmemmap := TIEFileBuffer.Create;
  fOrigin := ieboBOTTOMLEFT;
  fFragments := nil;
  fFragmentsCount := 0;
  fRowsPerFragment := 0;
  fFullReallocate := true;
  fWidth := 0;
  fHeight := 0;
  fBitCount := 0;
  fMemoryAllocator := iemaAuto; // 2.2.4rc2
  fChannelCount:=0;
  fWorkingMap := nil;
  fPixelFormat := ienull;
  fRGBPalette := nil;
  fIsAlpha := false;
  fAlphaChannel := nil;
  fRGBPaletteLen := 0;
  fLocation := ieFile;
  fMemory := nil;
  fRealMemory := nil;
  fBitmap := nil;
  fBitmapScanlines := nil;
  fFull := false;
  fEncapsulatedFromTBitmap := false;
  fEncapsulatedFromMemory := false;
  fScanlinesToUnMapPtr := TList.Create;
  fScanlinesToUnMapRow := TList.Create;
  fDefaultDitherMethod := ieThreshold;
  fBlackValue := 0;
  fWhiteValue := 0;
  // calculates fMinFileSize
  fm := IEGetMemory(false);  // 2.3.3
  if IEDefMinFileSize = -1 then
  begin
    if fm = 0 then
    begin
      // we cannot know how much memory is free
      fMinFileSize := 32 * 1024 * 1024; // 32 Mbytes
    end
    else
    begin
      fMinFileSize := trunc(fm/1.3);
    end;
  end
  else
    fMinFileSize := IEDefMinFileSize;
  // channels
  for i := 0 to IEMAXCHANNELS - 1 do
    fChannelOffset[i] := 0;
  //
  fContrast := 0;
  fAccess := [iedRead, iedWrite];
  fPaletteUsed := 256;
  fBitAlignment := 32;
  fCanvasCurrentAlpha := -1;
end;

constructor TIEBitmap.Create(ImageWidth, ImageHeight:integer; ImagePixelFormat:TIEPixelFormat=ie24RGB);
begin
  Create;
  Allocate(ImageWidth,ImageHeight,ImagePixelFormat);
end;

constructor TIEBitmap.Create(const FileName:string; IOParams:TObject);
begin
  Create;
  Read(FileName, IOParams);
end;

constructor TIEBitmap.Create(image:TIEBitmap);
begin
  Create;
  Assign(image);
end;


{!!
<FS>TIEBitmap.Read

<FM>Declaration<FC>
function Read(const FileName:string; IOParams:TObject = nil):boolean; overload;
function Read(Stream:TStream; IOParams:TObject = nil):boolean; overload;

<FM>Description<FN>
Loads image from file or stream. This method supports all formats supported by <A TImageEnIO> class.
<FC>IOParams<FN> specifies the in/out parameters as <A TIOParamsVals> objects.
Returns <FC>false<FN> on failure.

<FM>Examples<FC>

var
  bmp:TIEBitmap;
begin
  bmp := TIEBitmap.Create;
  bmp.Read('input.jpg');
  bmp.Write('output.jpg');
  bmp.Free;
end;

...that is the same of...

with TIEBitmap.Create('input.jpg') do
begin
  Write('output.jpg');
  Free;
end;

...that is the same of...

var
  bmp:TIEBitmap;
  io:TImageEnIO;
begin
  bmp := TIEBitmap.Create;
  io := TImageEnIO.CreateFromBitmap(bmp);
  io.LoadFromFile('input.jpg');
  io.SaveToFile('output.jpg');
  io.Free;
  bmp.Free;
end;
!!}
function TIEBitmap.Read(const FileName:string; IOParams:TObject):boolean;
var
  io:TImageEnIO;
  params:TIOParamsVals;
begin
  params := nil;
  if assigned(IOParams) then
    params := (IOParams as TIOParamsVals);
  io := TImageEnIO.CreateFromBitmap(self);
  try
    if assigned(params) then
      io.Params.Assign(params);
    io.LoadFromFile(FileName);
    result := io.Aborting;
    if assigned(params) then
      params.Assign(io.Params);
  finally
    io.Free;
  end;
end;

function TIEBitmap.Read(Stream:TStream; IOParams:TObject):boolean;
var
  io:TImageEnIO;
  params:TIOParamsVals;
begin
  params := nil;
  if assigned(IOParams) then
    params := (IOParams as TIOParamsVals);
  io := TImageEnIO.CreateFromBitmap(self);
  try
    if assigned(params) then
      io.Params.Assign(params);
    io.LoadFromStream(Stream);
    result := io.Aborting;
    if assigned(params) then
      params.Assign(io.Params);
  finally
    io.Free;
  end;
end;


{!!
<FS>TIEBitmap.Write

<FM>Declaration<FC>
procedure Write(const FileName:string; IOParams:TObject = nil); overload;
procedure Write(Stream:TStream; FileType:integer; IOParams:TObject = nil); overload;  // FileType is TIOFileType

<FM>Description<FN>
Writes image to file or stream. This method supports all formats supported by <A TImageEnIO> class.
<FC>IOParams<FN> specifies the in/out parameters as <A TIOParamsVals> objects.

<FM>Examples<FC>

var
  bmp:TIEBitmap;
begin
  bmp := TIEBitmap.Create;
  bmp.Read('input.jpg');
  bmp.Write('output.jpg');
  bmp.Free;
end;

...that is the same of...

with TIEBitmap.Create('input.jpg') do
begin
  Write('output.jpg');
  Free;
end;

...that is the same of...

var
  bmp:TIEBitmap;
  io:TImageEnIO;
begin
  bmp := TIEBitmap.Create;
  io := TImageEnIO.CreateFromBitmap(bmp);
  io.LoadFromFile('input.jpg');
  io.SaveToFile('output.jpg');
  io.Free;
  bmp.Free;
end;
!!}
procedure TIEBitmap.Write(const FileName:string; IOParams:TObject);
var
  io:TImageEnIO;
  params:TIOParamsVals;
begin
  params := nil;
  if assigned(IOParams) then
    params := (IOParams as TIOParamsVals);
  io := TImageEnIO.CreateFromBitmap(self);
  try
    if assigned(params) then
      io.Params.Assign(params);
    io.SaveToFile(FileName);
  finally
    io.Free;
  end;
end;

procedure TIEBitmap.Write(Stream:TStream; FileType:integer; IOParams:TObject);
var
  io:TImageEnIO;
  params:TIOParamsVals;
begin
  params := nil;
  if assigned(IOParams) then
    params := (IOParams as TIOParamsVals);
  io := TImageEnIO.CreateFromBitmap(self);
  try
    if assigned(params) then
      io.Params.Assign(params);
    io.SaveToStream(Stream, FileType);
  finally
    io.Free;
  end;
end;


{!!
<FS>TIEBitmap.CanvasCurrentAlpha

<FM>Declaration<FC>
property CanvasCurrentAlpha:integer

<FM>Description<FN>
Setting this property to a value >=0, make the alpha channel an 8 bit gray scale paintable bitmap.
This means that you can draw on the alpha channel using TCanvas object.
The value (0..255) specifies the transparency, 0=fully transparent, 255=fully opaque.
The default is -1.

<FM>Example<FC>

ImageEnView1.IEBitmap.AlphaChannel.CanvasCurrentAlpha:=128;
with ImageEnView1.IEBitmap.AlphaChannel.Canvas do
begin
  FillRect(0,0,100,100);
  Ellipse(10,10,200,200);
end;
!!}
procedure TIEBitmap.SetCanvasCurrentAlpha(v:integer);
var
  c:TColor;
begin
  if fCanvasCurrentAlpha=-1 then
  begin
    Location := ieTBitmap; // we need a canvas
    PixelFormat := ie8g;
    VclBitmap.PixelFormat := pf8bit;
    IESetGrayPalette(VclBitmap);
  end;
  if v<>-1 then
  begin
    c:=$02000000 or (v) or (v shl 8) or (v shl 16);
    Canvas.Pen.Color:=c;
    Canvas.Brush.Color:=c;
  end;
  fCanvasCurrentAlpha:=v;
end;


{!!
<FS>TIEBitmap.UpdateFromTBitmap

<FM>Declaration<FC>
procedure UpdateFromTBitmap;

<FM>Description<FN>
Updates TIEBitmap fields to the content of embedded TBitmap object (<A TIEBitmap.VclBitmap>).
This is useful if you change VclBitmap and wants to refresh TIEBitmap.

<FM>Example<FC>
ImageEnView1.IEBitmap.VclBitmap.Width := 1000;
ImageEnView1.IEBitmap.UpdateFromTBitmap;
ImageEnView1.Update;

!!}
procedure TIEBitmap.UpdateFromTBitmap;
var
  px: TIEPixelFormat;
begin
  if assigned(fBitmap) then
  begin
    px := ie24RGB;
    case fBitmap.PixelFormat of
      pf1bit:
        px := ie1g;
      pf8bit:
        if fIsAlpha or IEIsGrayPalette(fBitmap) then
          px := ie8g
        else
          px := ie8p;
      pf24bit:
        px := ie24RGB;
      pf32bit:
        px := ie32RGB;  // 2.3.2 (19/11/07 15:40)
    end;
    if (fWidth <> fBitmap.Width) or (fHeight <> fBitmap.Height) or (fPixelFormat <> px) then
    begin
      fWidth := fBitmap.Width;
      fHeight := fBitmap.Height;
      fPixelFormat := px;
      fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
      fChannelCount := PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
      fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
      if HasAlphaChannel and ((fAlphaChannel.Width <> fWidth) or (fAlphaChannel.Height <> fHeight)) then
        fAlphaChannel.Allocate(fWidth, fHeight, ie8g);
      BuildBitmapScanlines;
    end;
    if (fHeight > 0) and assigned(fBitmapScanlines) and (fBitmapScanlines[0] <> fBitmap.Scanline[0]) then
      BuildBitmapScanlines;
    if fPixelFormat=ie8p then
      IECopyTBitmapPaletteToTIEBitmap(fBitmap,self);
  end;
end;

{!!
<FS>TIEBitmap.BitCount

<FM>Declaration<FC>
property BitCount:integer;

<FM>Description<FN>
Gets the bits per pixel. Here is the <A TIEBitmap.PixelFormat> - BitCount comparison:
PixelFormat=ie1g -> BitCount=1
PixelFormat=ie8g -> BitCount=8
PixelFormat=ie8p -> BitCount=8
PixelFormat=ie16g -> BitCount=16
PixelFormat=ie24RGB -> BitCount=24
PixelFormat=ie32f -> BitCount=32
PixelFormat=ieCMYK -> BitCount=32
PixelFormat=ie48RGB -> BitCount=48
PixelFormat=ieCIELab -> BitCount=24
PixelFormat=ie32RGB -> BitCount=32
!!}
function TIEBitmap.GetBitCount: integer;
begin
  if (fLocation = ieTBitmap) then
    UpdateFromTBitmap;
  result := fBitCount;
end;

{!!
<FS>TIEBitmap.ChannelCount

<FM>Declaration<FC>
property ChannelCount:integer;

<FM>Description<FN>
Returns number of channels of current pixel format.
!!}
function TIEBitmap.GetChannelCount: integer;
begin
  if (fLocation = ieTBitmap) then
    UpdateFromTBitmap;
  result := fChannelCount;
end;

{!!
<FS>TIEBitmap.Width

<FM>Declaration<FC>
property Width:integer;

<FM>Description<FN>
Gets/sets the image width.
!!}
function TIEBitmap.GetWidth: integer;
begin
  if (fLocation = ieTBitmap) then
    UpdateFromTBitmap;
  result := fWidth;
end;

{!!
<FS>TIEBitmap.Height

<FM>Declaration<FC>
property Height:integer;

<FM>Description<FN>
Gets/sets the image height.
!!}
function TIEBitmap.GetHeight: integer;
begin
  if (fLocation = ieTBitmap) then
    UpdateFromTBitmap;
  result := fHeight;
end;

{!!
<FS>TIEBitmap.PixelFormat

<FM>Declaration<FC>
property PixelFormat:<A TIEPixelFormat>;

<FM>Description<FN>
Gets/sets the image pixelformat.
PixelFormat can convert image from a format to another.
!!}
function TIEBitmap.GetPixelFormat: TIEPixelFormat;
begin
  if (fLocation = ieTBitmap) then
    UpdateFromTBitmap;
  result := fPixelFormat;
end;

{!!
<FS>TIEBitmap.RowLen

<FM>Declaration<FC>
property RowLen:integer;

<FM>Description<FN>
Gets the count of bytes in a row. For default a row is double word aligned (32bit).
!!}
function TIEBitmap.GetRowLen: integer;
begin
  if (fLocation = ieTBitmap) then
    UpdateFromTBitmap;
  result := fRowLen;
end;

{!!
<FS>TIEBitmap.VclBitmap

<FM>Declaration<FC>
property VclBitmap:TBitmap;

<FM>Description<FN>
Contains the encapsulated TBitmap object.
!!}
function TIEBitmap.GetVclBitmap: TBitmap;
begin
  SetLocation(ieTBitmap);
  AdjustCanvasOrientation;
  result := fBitmap;
end;

// used by Allocate
// set fEncapsulatedFromTBitmap to false
// set fEncapsulatedFromMemory to false
constructor TIEBitmap.CreateAsAlphaChannel(ImageWidth, ImageHeight: integer; ImageLocation: TIELocation);
begin
  Create;
  fEncapsulatedFromTBitmap := false;
  fEncapsulatedFromMemory := false;
  fIsAlpha := true;
  fLocation := ImageLocation;
  if fLocation = ieTBitmap then
    fLocation := ieMemory;
  Allocate(ImageWidth, ImageHeight, ie8g);
  Fill(255); // full opaque
end;

{!!
<FS>TIEBitmap.RemoveAlphaChannel

<FM>Declaration<FC>
procedure RemoveAlphaChannel(Merge:boolean=false; BackgroundColor:TColor=clWhite);

<FM>Description<FN>
RemoveAlphaChannel removes the associated alpha channel.
When Merge is true, the specified <FC>BackgroundColor<FN> is merged with the semitransparent areas of the image (like a shadow).
!!}
procedure TIEBitmap.RemoveAlphaChannel(Merge:boolean; BackgroundColor:TColor);
var
  x, y: integer;
  px: PRGB;
  al: pbyte;
  a: integer;
  br, bg, bb: integer;
begin

  if fIsAlpha or not HasAlphaChannel then
    exit;

  if Merge and (PixelFormat = ie24RGB) and (HasAlphaChannel) then
  begin
    // merges with fBackground color
    with TColor2TRGB(BackgroundColor) do
    begin
      br := r;
      bg := g;
      bb := b;
    end;
    for y := 0 to fHeight - 1 do
    begin
      px := Scanline[y];
      al := AlphaChannel.Scanline[y];
      for x := 0 to fWidth - 1 do
      begin
        a := al^ shl 10;
        with px^ do
        begin
          r := a * (r - br) shr 18 + br;
          g := a * (g - bg) shr 18 + bg;
          b := a * (b - bb) shr 18 + bb;
        end;
        inc(px);
        inc(al);
      end;
    end;
  end;

  FreeAndNil(fAlphaChannel);

end;

{!!
<FS>TIEBitmap.AlphaChannel

<FM>Declaration<FC>
property AlphaChannel:<A TIEBitmap>;

<FM>Description<FN>
TIEBitmap handles the alpha channel as an encapsulated TIEBitmap object with pixelformat of ie8g.
This property returns the associated AlphaChannel.
If an image doesn't have an alpha channel, you can create it just using AlphaChannel property.
To know if an image has an alpha channel, examine the <A TIEBitmap.HasAlphaChannel> property.
!!}
function TIEBitmap.GetAlphaChannel: TIEBitmap;
begin
  if (not fIsAlpha) and (not assigned(fAlphaChannel)) then
    // we need to create alpha channel
    fAlphaChannel := TIEBitmap.CreateAsAlphaChannel(fWidth, fHeight, fLocation);
  result := fAlphaChannel; // it could be nil
end;

procedure TIEBitmap.SetAlphaChannel(value:TIEBitmap);
begin
  fAlphaChannel:=value;
  fAlphaChannel.fIsAlpha:=true;
end;

{!!
<FS>TIEBitmap.HasAlphaChannel

<FM>Declaration<FC>
property HasAlphaChannel:boolean;

<FM>Description<FN>
HasAlphaChannel specifies if the current image has an alpha channel.
!!}
// used by HasAlphaChannel
function TIEBitmap.GetHasAlphaChannel: boolean;
begin
  result := assigned(fAlphaChannel);
end;

{!!
<FS>TIEBitmap.Destroy

<FM>Declaration<FC>
destructor Destroy;

<FM>Description<FN>
Destroys this TIEBitmap object.
!!}
destructor TIEBitmap.Destroy;
begin
  FreeImage(true);
  FreeAndNil(fmemmap);
  FreeAndNil(fScanlinesToUnMapPtr);
  FreeAndNil(fScanlinesToUnMapRow);
  inherited;
end;

{!!
<FS>TIEBitmap.SwitchTo

<FM>Declaration<FC>
procedure SwitchTo(Target:<A TIEBitmap>);

<FM>Description<FN>
Assigns current image to the target object. The source object will be empty.
Executes more quickly than a copy operation because the image is transferred not copied.
In detail it assigns all fields to Target, and set to zero all parameters (do not free the image or allocated memory).
!!}
// set fEncapsulatedFromTBitmap to false
// set fEncapsulatedFromMemory to false
// note: fIsAlpha is not resetted! (otherwise this could be not recognized as AlphaChannel)
procedure TIEBitmap.SwitchTo(Target: TIEBitmap);
begin
  Target.FreeImage(true);
  Target.fWidth := fWidth;
  Target.fHeight := fHeight;
  Target.fBitCount := fBitCount;
  Target.fChannelCount:=fChannelCount;
  Target.fWorkingMap := fWorkingMap;
  Target.fRowLen := fRowLen;
  Target.fPixelFormat := fPixelFormat;
  Target.fRGBPalette := fRGBPalette;
  Target.fRGBPaletteLen := fRGBPaletteLen;
  Target.fAlphaChannel := fAlphaChannel;
  Target.fIsAlpha := fIsAlpha;
  Target.fMemory := fMemory;
  Target.fRealMemory := fRealMemory;
  Target.fBitmap := fBitmap;
  Target.fLocation := fLocation;
  Target.fFull := fFull;
  Target.fEncapsulatedFromTBitmap := fEncapsulatedFromTBitmap;
  Target.fEncapsulatedFromMemory := fEncapsulatedFromMemory;
  Target.fBitmapScanlines := fBitmapScanlines;
  Target.fFragmentsCount := fFragmentsCount;
  Target.fFragments := fFragments;
  Target.fRowsPerFragment := fRowsPerFragment;
  Target.fOrigin := fOrigin;
  FreeAndNil(Target.fmemmap);
  Target.fmemmap := fmemmap;
  FreeAndNil(Target.fScanlinesToUnMapPtr);
  FreeAndNil(Target.fScanlinesToUnMapRow);
  Target.fScanlinesToUnMapPtr := fScanlinesToUnMapPtr;
  Target.fScanlinesToUnMapRow := fScanlinesToUnMapRow;
  Target.fDefaultDitherMethod := fDefaultDitherMethod;
  Target.fBitAlignment := fBitAlignment;
  Target.fMemoryAllocator := fMemoryAllocator;
  // warning! this doesn't reset fIsAlpha!!
  fWidth := 0;
  fHeight := 0;
  fBitCount := 0;
  fChannelCount:=0;
  fWorkingMap := nil;
  fRowLen := 0;
  fPixelFormat := ienull;
  fRGBPalette := nil;
  fRGBPaletteLen := 0;
  fAlphaChannel := nil;
  fMemory := nil;
  fRealMemory := nil;
  fBitmap := nil;
  fBitmapScanlines := nil;
  fScanlinesToUnMapPtr := TList.Create;
  fScanlinesToUnMapRow := TList.Create;
  fFull := false;
  fFullReallocate := true;
  fEncapsulatedFromTBitmap := false;
  fEncapsulatedFromMemory := false;
  fmemmap := TIEFileBuffer.Create;
  fFragmentsCount := 0;
  fFragments := nil;
  fRowsPerFragment := 0;
  fOrigin := ieboBOTTOMLEFT;
end;

// free bitmap scanlines
procedure TIEBitmap.FreeBitmapScanlines;
begin
  if fBitmapScanlines <> nil then
    freemem(fBitmapScanlines);
  fBitmapScanlines := nil;
end;

// free and build bitmap scanlines
procedure TIEBitmap.BuildBitmapScanlines;
var
  i: integer;
begin
  FreeBitmapScanlines;
  if assigned(fBitmap) then
  begin
    getmem(fBitmapScanlines, sizeof(pointer) * fHeight);
    for i := 0 to fHeight - 1 do
      fBitmapScanlines[i] := fBitmap.Scanline[i];
  end;
end;

{!!
<FS>TIEBitmap.BitAlignment

<FM>Declaration<FC>
property BitAlignment:integer;

<FM>Description<FN>
Specifies the number of bits of alignment (32 is the default). This works only when <A TIEBitmap.Location> is ieMemory.
!!}
procedure TIEBitmap.SetBitAlignment(value: integer);
var
  old: TIEBitmap;
  row, mi: integer;
begin
  if value <> fBitAlignment then
  begin
    fFullReallocate := true;
    if (fLocation = ieMemory) then
    begin
      old := TIEBitmap.Create;
      SwitchTo(old);
      fBitAlignment := value;
      Allocate(old.Width, old.fHeight, old.fPixelFormat);
      mi := imin(fRowLen, old.fRowLen);
      for row := 0 to fHeight - 1 do
        CopyMemory(ScanLine[row], old.ScanLine[row], mi);
      // copy alpha (already sized in "resize alpha")
      if old.HasAlphaChannel then
        AlphaChannel.Assign(old.AlphaChannel);
      FreeAndNil(old);
    end;
  end;
end;

// resize also alpha channel
procedure TIEBitmap.SetWidth(Value: integer);
var
  old: TIEBitmap;
  row, mi, mih: integer;
  tmpbmp: TBitmap;
begin
  if Value <> fWidth then
  begin
    // resize alpha
    if HasAlphaChannel then
      AlphaChannel.Width := Value;
    // resize image
    case fLocation of
      ieMemory,
        ieFile:
        begin
          if (fPixelFormat <> ienull) and (fHeight > 0) then
          begin
            old := TIEBitmap.Create;
            SwitchTo(old);
            Allocate(Value, old.fHeight, old.fPixelFormat);
            if old.fPixelFormat <> ienull then
            begin
              mi := imin(fRowLen, old.fRowLen);
              mih := imin(fHeight, old.fHeight);
              for row := 0 to mih - 1 do
                CopyMemory(ScanLine[row], old.ScanLine[row], mi);
            end;
            // copy alpha (already sized in "resize alpha")
            if old.HasAlphaChannel then
              AlphaChannel.Assign(old.AlphaChannel);
            FreeAndNil(old);
            fFull := false;
          end
          else
            fWidth := Value;
        end;
      ieTBitmap:
        begin
          if fBitmap = nil then
            fBitmap := TBitmap.Create;
          if fBitmap.PixelFormat = pf1bit then
          begin
            // we need this because sometime just set fBitmap.Width:=xx doesn't work
            tmpbmp := TBitmap.Create;
            IECopyBitmap(fBitmap, tmpbmp);
            fBitmap.Width := Value;
            fbitmap.HandleType := bmDDB;
            fBitmap.Canvas.Draw(0, 0, tmpbmp);
            fbitmap.HandleType := bmDIB;
            FreeAndNil(tmpbmp);
          end
          else
            fBitmap.Width := Value;
          fWidth := fBitmap.Width;
          fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
          BuildBitmapScanlines;
          // no need to copy alpha
        end;
    end;
  end;
end;

// resize also alpha channel
procedure TIEBitmap.SetHeight(Value: integer);
var
  old: TIEBitmap;
  row, mi, miw: integer;
  tmpbmp: TBitmap;
begin
  if Value <> fHeight then
  begin
    // resize alpha
    if HasAlphaChannel then
      AlphaChannel.Height := Value;
    case fLocation of
      ieMemory,
        ieFile:
        begin
          if (fPixelFormat <> ienull) and (fWidth > 0) then
          begin
            old := TIEBitmap.Create;
            SwitchTo(old);
            Allocate(old.fWidth, Value, old.fPixelFormat);
            if old.fPixelFormat <> ienull then
            begin
              mi := imin(fHeight, old.fHeight);
              miw := imin(fRowLen, old.fRowLen);
              for row := 0 to mi - 1 do
                CopyMemory(ScanLine[row], old.ScanLine[row], miw);
            end;
            // copy alpha (already sized in "resize alpha")
            if old.HasAlphaChannel then
              AlphaChannel.Assign(old.AlphaChannel);
            FreeAndNil(old);
            fFull := false;
          end
          else
            fHeight := Value;
        end;
      ieTBitmap:
        begin
          if fBitmap = nil then
            fBitmap := TBitmap.Create;
          if fBitmap.PixelFormat = pf1bit then
          begin
            // we need this because sometime just set fBitmap.Height:=xx doesn't work
            tmpbmp := TBitmap.Create;
            IECopyBitmap(fBitmap, tmpbmp);
            fBitmap.Height := Value;
            fbitmap.HandleType := bmDDB;
            fBitmap.Canvas.Draw(0, 0, tmpbmp);
            fbitmap.HandleType := bmDIB;
            FreeAndNil(tmpbmp);
          end
          else
            fBitmap.Height := Value;
          fHeight := fBitmap.Height;
          BuildBitmapScanlines;
          // no need to copy alpha
        end;
    end;
  end;
end;

// works only on enlarging bitmap
procedure DoAlignAfter(Bitmap: TIEBitmap; OldWidth, OldHeight:integer; bk: double; HorizAlign: TIEHAlign; VertAlign: TIEVAlign);
begin
  if Bitmap.Width > OldWidth then
  begin
    Bitmap.FillRect(OldWidth, 0, Bitmap.Width - 1, Bitmap.Height - 1, bk);
    case HorizAlign of
      iehLeft: ; // do nothing, already aligned
      iehCenter:
        Bitmap.MoveRegion(0, 0, OldWidth - 1, OldHeight - 1, ((Bitmap.Width - OldWidth) div 2), 0, bk);
      iehRight:
        Bitmap.MoveRegion(0, 0, OldWidth - 1, OldHeight - 1, Bitmap.Width - OldWidth, 0, bk);
    end;
  end;
  if Bitmap.Height > OldHeight then
  begin
    Bitmap.FillRect(0, OldHeight, Bitmap.Width - 1, Bitmap.Height - 1, bk);
    case VertAlign of
      ievTop: ; // do nothing, already aligned
      ievCenter:
        Bitmap.MoveRegion(0, 0, Bitmap.Width - 1, OldHeight - 1, 0, ((Bitmap.Height - OldHeight) div 2), bk);
      ievBottom:
        Bitmap.MoveRegion(0, 0, Bitmap.Width - 1, OldHeight - 1, 0, Bitmap.Height - OldHeight, bk);
    end;
  end;
end;

// works only on reducing bitmap
procedure DoAlignBefore(Bitmap: TIEBitmap; NewWidth, NewHeight: integer; bk:double; HorizAlign: TIEHAlign; VertAlign: TIEVAlign);
var
  cx, cy: integer;
begin
  if Bitmap.Width > NewWidth then
  begin
    cx := (Bitmap.Width - NewWidth) div 2;
    case HorizAlign of
      iehLeft: ; // do nothing, already aligned
      iehCenter:
        Bitmap.MoveRegion(cx, 0, cx + NewWidth - 1, Bitmap.Height - 1, 0, 0, bk);
      iehRight:
        Bitmap.MoveRegion(Bitmap.Width - NewWidth, 0, Bitmap.Width - 1, Bitmap.Height - 1, 0, 0, bk);
    end;
  end;
  if Bitmap.Height > NewHeight then
  begin
    cy := (Bitmap.Height - NewHeight) div 2;
    case VertAlign of
      ievTop: ; // do nothing, already aligned
      ievCenter:
        Bitmap.MoveRegion(0, cy, Bitmap.Width - 1, cy + NewHeight - 1, 0, 0, bk);
      ievBottom:
        Bitmap.MoveRegion(0, Bitmap.Height - NewHeight, Bitmap.Width - 1, Bitmap.height - 1, 0, 0, bk);
    end;
  end;
end;


{!!
<FS>TIEBitmap.Resize

<FM>Declaration<FC>
procedure Resize(NewWidth, NewHeight:integer; BackgroundValue:double; AlphaValue:integer; HorizAlign:<A TIEHAlign>; VertAlign:<A TIEVAlign>);

<FM>Description<FN>
Resizes the image to specified <FC>NewWidth<FN> and <FC>NewHeight<FN> values without resampling the image.
This method resizes also the alpha channel.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>NewWidth<FN></C> <C>New image width.</C> </R>
<R> <C><FC>NewHeight<FN></C> <C>New image height.</C> </R>
<R> <C><FC>BackgroundValue<FN></C> <C>TColor value for ie24RGB images or a gray level for gray scale or black/white images. It is used to fill added regions.</C> </R>
<R> <C><FC>AlphaValue<FN></C> <C>Alpha value used to fill added regions.</C> </R>
<R> <C><FC>HorizAlign<FN></C> <C>Specifies how to horizontally align the old image.</C> </R>
<R> <C><FC>VertAlign<FN></C> <C>Specifies how to vertically align the old image.</C> </R>
</TABLE>

!!}
// HorizAlign acts only when NewWidth>Width
// VertAlign acts only when NewHeight>Height
// AlphaValue is valid only when HasAlphaChannel is true and this is not an alpha channel
procedure TIEBitmap.Resize(NewWidth, NewHeight: integer; BackgroundValue: double; AlphaValue: integer; HorizAlign: TIEHAlign; VertAlign: TIEVAlign);
var
  lw, lh: integer;
begin
  lw := Width;
  lh := Height;
  DoAlignBefore(self, NewWidth, NewHeight, BackgroundValue, HorizAlign, VertAlign);
  if HasAlphaChannel then
    DoAlignBefore(AlphaChannel, NewWidth, NewHeight, AlphaValue, HorizAlign, VertAlign);
  SetWidth(NewWidth);
  SetHeight(NewHeight);
  DoAlignAfter(self, lw, lh, BackgroundValue, HorizAlign, VertAlign);
  if HasAlphaChannel then
    DoAlignAfter(AlphaChannel, lw, lh, AlphaValue, HorizAlign, VertAlign);
end;

{!!
<FS>TIEBitmap.MoveRegion

<FM>Declaration<FC>
procedure MoveRegion(x1, y1, x2, y2, DstX, DstY:integer; BackgroundValue:double; FillSource:boolean = true);

<FM>Description<FN>
MoveRegion moves a rectangle specified in <FC>x1, y1, x2, y2<FN> to <FC>DstX, DstY<FN> position.
The <FC>BackgroundValue<FN> parameter specifies the color that fills the source rectangle.
If <FC>FillSource<FN> is true (default) then the source rectangle is filled with <FC>BackgroundValue<FN>.
MoveRegion doesn't copy the alpha channel.
!!}
procedure TIEBitmap.MoveRegion(x1, y1, x2, y2, DstX, DstY:integer; BackgroundValue:double; FillSource:boolean);
var
  tmp: TIEBitmap;
begin
  tmp := TIEBitmap.Create;
  tmp.Allocate(x2 - x1 + 1, y2 - y1 + 1, PixelFormat);
  CopyRectTo(tmp, x1, y1, 0, 0, tmp.Width, tmp.Height);
  if FillSource then
    FillRect(x1, y1, x2, y2, BackgroundValue);
  tmp.CopyRectTo(self, 0, 0, DstX, DstY, tmp.Width, tmp.Height);
  FreeAndNil(tmp);
end;

procedure TIEBitmap.SetPixelFormat(Value: TIEPixelFormat);
begin
  if Value <> fPixelFormat then
    ConvertToPixelFormat(Value);
end;

procedure TIEBitmap.FreeAllMaps;
begin
  if fWorkingMap <> nil then
    fmemmap.UnMap(fWorkingMap);
  while fScanlinesToUnMapPtr.Count > 0 do
  begin
    fmemmap.UnMap(fScanlinesToUnMapPtr[fScanlinesToUnMapPtr.Count - 1]);
    fScanlinesToUnMapPtr.Delete(fScanlinesToUnMapPtr.Count - 1);
  end;
  fScanlinesToUnMapRow.Clear;
  fWorkingMap := nil;
end;


{!!
<FS>TIEBitmap.FreeImage

<FM>Declaration<FC>
procedure FreeImage(freeAlpha:boolean = true);

<FM>Description<FN>
FreeImage destroys the image and frees memory.
!!}
// set fEncapsulatedFromTBitmap to false
// set fEncapsulatedFromMemory to false
procedure TIEBitmap.FreeImage(freeAlpha:boolean);
begin
  if freeAlpha and assigned(fAlphaChannel) then
    FreeAndNil(fAlphaChannel);
  if fRGBPalette <> nil then
    freemem(fRGBPalette);
  FreeAllMaps;
  fmemmap.DeAllocate;
  if (not fEncapsulatedFromMemory) and (fMemory <> nil) and (fRealMemory<>nil) then
  begin
    case fMemoryAllocator of
      iemaVCL:    freemem(fRealMemory);
      iemaSystem: IESystemFree(fRealMemory);
      iemaAuto:   IEAutoFree(fRealMemory);
    end;
  end;
  if (not fEncapsulatedFromTBitmap) and (fBitmap <> nil) then
    FreeAndNil(fBitmap);
  FreeBitmapScanlines; // this set fBitmapScanlines:=nil
  FreeFragments;
  fMemory := nil;
  fRealMemory := nil;
  fBitmap := nil;
  fRGBPalette := nil;
  fRGBPaletteLen := 0;
  fWidth := 0;
  fHeight := 0;
  fRowlen := 0;
  fBitCount := 0;
  fChannelCount:=0;
  fFull := false;
  fEncapsulatedFromTBitmap := false;
  fEncapsulatedFromMemory := false;
end;

{!!
<FS>TIEBitmap.IsEmpty

<FM>Declaration<FC>
function IsEmpty:boolean;

<FM>Description<FN>
Returns true if the bitmap is empty (width=0, height=0, etc...).
!!}
function TIEBitmap.IsEmpty:boolean;
begin
  result:= (fWidth=0) or (fHeight=0) or (fRowLen=0) or (fBitCount=0);
end;

// before call AllocateImage make sure to call FreeImage
// returns false on fail
function TIEBitmap.AllocateImage:boolean;
var
  ms: int64;
begin
  result:=false;
  if (fWidth > 0) and (fHeight > 0) and (fPixelFormat <> ienull) then
  begin
    if fPixelFormat = ie8p then
    begin
      getmem(fRGBPalette, sizeof(TRGB) * 256);
      if fRGBPalette=nil then
        exit; // FAIL!
      fRGBPaletteLen := 256;
    end;
    fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
    fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
    fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
    ms := int64(fRowLen) * fHeight;
    if (fLocation = ieFile) and (ms < fMinFileSize) then
      fLocation := ieMemory;
    if (fLocation = ieMemory) and (ms > fMinFileSize) then
      fLocation := ieFile;
    if fLocation = ieFile then
    begin
      // use file memory
      if not fmemmap.AllocateFile(ms,'IMG',true) then
        fLocation := ieMemory;
    end;
    if fLocation = ieMemory then
    begin
      // use memory
      AllocateMemory(ms, fRealMemory, fMemory);
      if fRealMemory=nil then
      begin
        FragmentedAlloc;
        if fFragments=nil then
        begin
          // failed to allocate memory
          if not iegAutoLocateOnDisk then
            exit;
          // use file (3.0.1)
          fLocation := ieFile;
          if not fmemmap.AllocateFile(ms,'IMG',true) then
            exit; // 3.0.2
        end;
      end;
    end;
    if fLocation = ieTBitmap then
    begin
      // use VCL TBitmap
      if int64(fHeight)*fRowlen > IEGetMemory(false) then
        exit;
      if not fEncapsulatedFromTBitmap then
        fBitmap := TBitmap.Create;
      try
      fBitmap.Width  := 1;
      fBitmap.Height := 1;
      fBitmap.PixelFormat := pfDevice;  // needed, otherwise when switch to pe1bit the bitmap could not work well (!)
      case fPixelFormat of
        ie1g:
          fBitmap.PixelFormat := pf1bit;
        ie8p:
          fBitmap.PixelFormat := pf8bit;
        ie8g:
          fBitmap.PixelFormat := pf8bit;
        ie16g: // ie16g in TBitmap converted to ie8g
          begin
            fBitmap.PixelFormat := pf8bit;
            fPixelFormat := ie8g;
            fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
            fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
            fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
          end;
        ie32f: // ie32f not supported when Location=ieTBitmap
          raise Exception.Create('ie32f pixel format not allowed when Location=ieTBitmap Please set TImageEnView.LegacyBitmap=false.');
        ieCMYK: // ieCMYK not supported when Location=ieTBitmap
          raise Exception.Create('ieCMYK pixel format not allowed when Location=ieTBitmap. Please set TImageEnView.LegacyBitmap=false.');
        ieCIELab: // ieCIELab not supported when Location=ieTBitmap
          raise Exception.Create('ieCIELab pixel format not allowed when Location=ieTBitmap Please set TImageEnView.LegacyBitmap=false.');
        ie24RGB:
          fBitmap.PixelFormat := pf24bit;
        ie48RGB: // ieRGB48 not supported when Location=ieTBitmap
          raise Exception.Create('ieRGB48 pixel format not allowed when Location=ieTBitmap Please set TImageEnView.LegacyBitmap=false.');
        ie32RGB:
          fBitmap.PixelFormat := pf32bit;
      end;
      fBitmap.Width  := fWidth;
      fBitmap.Height := fHeight;
      if fPixelFormat=ie8g then
        IESetGrayPalette(fBitmap); // this must be executed after set the bitmap sizes
      BuildBitmapScanlines;
      except
        exit;
      end;
    end;
    fFull  := false;
    result := true;
  end;
end;

// AlignedBuffer is StartBuffer align by 64 bytes
// StartBuffer and AlignedBuffer are "nil" on fail
procedure TIEBitmap.AllocateMemory(size:integer; var StartBuffer:pointer; var AlignedBuffer:pointer);
begin
  AlignedBuffer:=nil;
  case fMemoryAllocator of
    iemaVCL:
      begin
        try
          getmem(StartBuffer, size+128);
        except
          StartBuffer:=nil;
        end;
      end;
    iemaSystem : StartBuffer:=IESystemAlloc(size+128);
    iemaAuto   : StartBuffer:=IEAutoAlloc(size+128);
  end;
  if StartBuffer<>nil then
  begin
    AlignedBuffer := StartBuffer;
    while (int64(DWORD(AlignedBuffer)) mod 64)<>0 do
      inc(pbyte(AlignedBuffer));
  end;
end;

procedure TIEBitmap.FreeFragments;
var
  i:integer;
begin
  if fFragments<>nil then
  begin
    for i:=0 to fFragmentsCount-1 do
      if fFragments[i]<>nil then
        IESystemFree(fFragments[i]);
    freemem(fFragments);
  end;
  fFragments:=nil;
  fFragmentsCount:=0;
  fRowsPerFragment:=0;
end;

// allocates in chunks
procedure TIEBitmap.FragmentedAlloc;
const
  STARTWITH = 4;
  MINIMUMSIZE = 10*1024*1024;
var
  i:integer;
  exitLoop:boolean;
  fc:integer;
  bufSize:integer;
begin
  FreeFragments;

  if not iegAutoFragmentBitmap then
    exit;

  fc:=STARTWITH; // start with 4 blocks (fragments)

  repeat
    exitLoop:=true;
    fFragmentsCount := fc;
    fRowsPerFragment := IECeil( fHeight / fFragmentsCount );
    bufSize := fRowLen * fRowsPerFragment;
    if (bufSize<MINIMUMSIZE) and (fFragmentsCount>STARTWITH) then
    begin
      // to avoid excessive framentation we cannot allow framents minor than MINIMUMSIZE
      FreeFragments;
      break;
    end;
    fFragments := allocmem(sizeof(pointer)*fFragmentsCount);  // zero filled
    for i:=0 to fFragmentsCount-1 do
    begin
      fFragments[i]:=IESystemAlloc(bufSize);
      if fFragments[i] = nil then
      begin
        // FAIL! Reduce block size
        FreeFragments;
        fc := fc*2;
        if (fc<fHeight) then
          exitLoop := false;
        break;
      end;
    end;
  until exitLoop;
end;

{!!
<FS>TIEBitmap.Allocate

<FM>Declaration<FC>
function Allocate(ImageWidth, ImageHeight: integer; ImagePixelFormat: <A TIEPixelFormat>=ie24RGB):boolean;

<FM>Description<FN>
Allocate prepares space for an image with ImageWidth and ImageHeight sizes.
When TIEBitmap is connected to <A TImageEnView>, make sure that <A TImageEnView.LegacyBitmap> is <FC>False<FN> before set pixel formats other than ie1g and ie24RGB.
Returns <FC>true<FN> on successful.

<FM>Example<FC>
ImageEnView1.LegacyBitmap := False;
ImageEnView1.IEBitmap.Allocate(1000, 1000, ieCMYK);
!!}
function TIEBitmap.Allocate(ImageWidth, ImageHeight: integer; ImagePixelFormat: TIEPixelFormat):boolean;
begin
  result:=true;
  if fFullReallocate or (ImageWidth<>fWidth) or (ImageHeight<>fHeight) or (ImagePixelFormat<>fPixelFormat) then  // 2.2.4
  begin
    if not fEncapsulatedFromTBitmap then
      FreeImage(true)
    else
    begin
      if assigned(fAlphaChannel) then
        FreeAndNil(fAlphaChannel)
    end;
    fWidth := ImageWidth;
    fHeight := ImageHeight;
    fPixelFormat := ImagePixelFormat;
    result := AllocateImage;
    if result=false then
    begin
      fWidth  := 0;
      fHeight := 0;
    end;
    fFullReallocate := false;
  end;
end;

{!!
<FS>TIEBitmap.EncapsulateTBitmap

<FM>Declaration<FC>
procedure EncapsulateTBitmap(obj:TBitmap; DoFreeImage:boolean);

<FM>Description<FN>
EncapsulateTBitmap encapsulates an existing TBitmap object.
It is useful to pass a TBitmap object to routines that require a TIEBitmap.
If <FC>DoFreeImage<FN> is true, the TBitmap object will be freed when the object is destroyed.
Supports only TBitmap with PixelFormat pf1bit or pf24bit
!!}
//
procedure TIEBitmap.EncapsulateTBitmap(obj: TBitmap; DoFreeImage: boolean);
begin
  if DoFreeImage then
    FreeImage(true);
  if (obj<>nil) and ((obj<>fBitmap) or (obj.Width<>fWidth) or (obj.Height<>fHeight) or (IEVCLPixelFormat2ImageEnPixelFormat(obj.PixelFormat)<>fPixelFormat)) then
  begin
    fWidth := obj.Width;
    fHeight := obj.Height;
    case obj.PixelFormat of
      pf1bit: fPixelFormat := ie1g;
      pf24bit: fPixelFormat := ie24RGB;
      pf32bit: fPixelFormat := ie32RGB;
    end;
    fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
    fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
    fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
    fLocation := ieTBitmap;
    fEncapsulatedFromTBitmap := true;
    fBitmap := obj;
    BuildBitmapScanlines;
  end;
end;

{!!
<FS>TIEBitmap.EncapsulateMemory

<FM>Declaration<FC>
procedure EncapsulateMemory(mem:pointer; bmpWidth, bmpHeight:integer; bmpPixelFormat:<A TIEPixelFormat>; DoFreeImage:boolean; Origin:TIEBitmapOrigin = ieboBOTTOMLEFT);

<FM>Description<FN>
Encapsulates an existing bitmap from its buffer.
It is useful to pass a TBitmap object to routines that require a TIEBitmap.
If <FC>DoFreeImage<FN> is true, the buffer will be freed when the object is destroyed.
<FC>Origin<FN> specifies the image orientation (default is bottom-left, that is Windows default. For example set ieboTOPLEFT with OpenCV images).
!!}
// note: an encapsulated from memory cannot be allocated/resized/freedom, but just used
procedure TIEBitmap.EncapsulateMemory(mem:pointer; bmpWidth, bmpHeight:integer; bmpPixelFormat:TIEPixelFormat; DoFreeImage:boolean; Origin:TIEBitmapOrigin);
begin
  if DoFreeImage then
    FreeImage(true);
  if mem <> nil then
  begin
    fWidth := bmpWidth;
    fHeight := bmpHeight;
    fPixelFormat := bmpPixelFormat;
    fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
    fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
    fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
    fLocation := ieMemory;
    fEncapsulatedFromMemory := true;
    fMemory := mem;
    fRealMemory := mem;
    fOrigin := Origin;
    if (bmpPixelFormat=ie8p) and (fRGBPalette=nil) then
    begin
      getmem(fRGBPalette, sizeof(TRGB) * 256);
      fRGBPaletteLen := 256;
    end;
    BuildBitmapScanlines;
  end;
end;

{!!
<FS>TIEBitmap.Assign

<FM>Declaration<FC>
procedure Assign(Source:TObject);

<FM>Description<FN>
Assign copies an image from source object. Source can be a <A TIEBitmap> or a TBitmap.
!!}
procedure TIEBitmap.Assign(Source: TObject);
var
  src: TIEBitmap;
  row, mi: integer;
  l1, l2: TIEDataAccess;
begin
  fFullReallocate:=true;
  if Source is TIEBitmap then
  begin
    src := Source as TIEBitmap;
    if fLocation = ieTBitmap then
    begin
      // works with fBitmap (TBitmap)
      if src.IsEmpty then
        exit;
      fWidth := src.fWidth;
      fHeight := src.fHeight;
      fPixelFormat := src.fPixelFormat;
      fBitAlignment := src.fBitAlignment;
      fFull := src.fFull;
      if fBitmap = nil then
        fBitmap := TBitmap.Create;
      fBitmap.Width := 1;
      fBitmap.Height := 1;
      case fPixelFormat of
        ie1g    : fBitmap.PixelFormat := pf1bit;
        ie8p    : fBitmap.PixelFormat := pf8bit;
        ie8g    : fBitmap.PixelFormat := pf8bit;
        ie16g   : ; // not supported
        ie32f   : ; // not supported
        ieCMYK  : ; // not supported
        ieCIELab: ; // not supported
        ie24RGB : fBitmap.PixelFormat := pf24bit;
        ie48RGB : ; // not supported
        ie32RGB : fBitmap.PixelFormat := pf32bit;
      end;
      fBitmap.Width := fWidth;
      fBitmap.Height := fHeight;
      if fPixelFormat=ie8g then
        IESetGrayPalette(fBitmap);  // this must be executed after set the bitmap sizes
      fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
      fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
      fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
      BuildBitmapScanlines;
    end
    else
    begin
      // works with native mapped file or memory bitmap
      FreeImage(true);
      fWidth := src.fWidth;
      fHeight := src.fHeight;
      fPixelFormat := src.fPixelFormat;
      fFull := src.fFull;
      fBitAlignment := src.fBitAlignment;
      AllocateImage;
    end;
    // copy image
    l1 := src.Access;
    l2 := Access;
    src.Access := [iedRead];
    Access := [iedWrite];
    if (fLocation = ieFile) and (src.fLocation = ieFile) then
    begin
      // do raw copy
      FreeAllMaps;
      src.FreeAllMaps;
      src.fmemmap.CopyTo(fmemmap, 0, fRowLen * fHeight);
    end
    else
    begin
      mi:=imin(fRowLen,src.RowLen);
      for row := 0 to fHeight - 1 do
        copymemory(ScanLine[row], src.ScanLine[row], mi);
    end;
    src.Access := l1;
    Access := l2;
    // copy alpha channel
    if (not fIsAlpha) then
    begin
      if src.HasAlphaChannel then
        // here we use GetAlphaChannel instead of fAlphaChannel to create alphachannel on the fly
        AlphaChannel.Assign(src.AlphaChannel)
      else
        RemoveAlphaChannel; // remove if there was an alpha channel
    end;
    // copy palette
    src.CopyPaletteTo(self);
    // Copy other params
    fDefaultDitherMethod := src.fDefaultDitherMethod;
  end
  else if Source is TBitmap then
  begin
    CopyFromTBitmap(Source as TBitmap);
  end;
end;

{!!
<FS>TIEBitmap.AssignImage

<FM>Declaration<FC>
procedure AssignImage(Source:<A TIEBitmap>);

<FM>Description<FN>
Assign copies an image from Source object, but not the alpha channel.
!!}
// assign only from TIEBitmap and without alpha channel
// do not assign BitAlignment
procedure TIEBitmap.AssignImage(Source: TIEBitmap);
var
  row, mi: integer;
  l1, l2: TIEDataAccess;
begin
  if Source.IsEmpty then
    exit;
  fFullReallocate:=true;
  if fLocation = ieTBitmap then
  begin
    // works with fBitmap (TBitmap)
    fWidth := Source.fWidth;
    fHeight := Source.fHeight;
    fPixelFormat := Source.fPixelFormat;
    fFull := false;
    if fBitmap = nil then
      fBitmap := TBitmap.Create;
    fBitmap.Width := 1;
    fBitmap.Height := 1;
    case fPixelFormat of
      ie1g: fBitmap.PixelFormat := pf1bit;
      ie8p: fBitmap.PixelFormat := pf8bit;
      ie8g: fBitmap.PixelFormat := pf8bit;
      ie16g: ; //not supported
      ie32f: ; //not supported
      ieCMYK: ; // not supported
      ieCIELab: ; // not supported
      ie24RGB: fBitmap.PixelFormat := pf24bit;
      ie48RGB: ; // not supported
      ie32RGB: fBitmap.PixelFormat := pf32bit;
    end;
    fBitmap.Width := fWidth;
    fBitmap.Height := fHeight;
    if fPixelFormat=ie8g then
      IESetGrayPalette(fBitmap); // this must be executed after set the bitmap sizes
    fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
    fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
    fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
    BuildBitmapScanlines;
  end
  else
  begin
    // works with native mapped file or memory bitmap
    FreeImage(false); // this doesn't free alpha channel
    fWidth := Source.fWidth;
    fHeight := Source.fHeight;
    fPixelFormat := Source.fPixelFormat;
    fFull := false;
    AllocateImage;
  end;
  // copy image
  l1 := Source.Access;
  l2 := Access;
  Source.Access := [iedRead];
  Access := [iedWrite];
  if (fLocation = ieFile) and (Source.fLocation = ieFile) then
  begin
    // do a raw copy
    FreeAllMaps;
    Source.FreeAllMaps;
    Source.fmemmap.CopyTo(fmemmap, 0, fRowLen * fHeight);
  end
  else
  begin
    mi:=imin(fRowLen,Source.RowLen);
    for row := 0 to fHeight - 1 do
      CopyMemory(ScanLine[row], Source.ScanLine[row], mi);
  end;
  Source.Access := l1;
  Access := l2;
  // copy palette
  Source.CopyPaletteTo(self);
end;

{!!
<FS>TIEBitmap.Scanline

<FM>Declaration<FC>
property Scanline[row:integer]:pointer

<FM>Description<FN>
Scanline gets an entire line of pixels at a time.
For <A TIEBitmap.Location>=ieFile you can use only last line obtained from Scanline[].
!!}
// for performance we never control if Row is valid
function TIEBitmap.GetScanLine(Row: integer): pointer;
begin

  if fOrigin = ieboTOPLEFT then
    Row := fHeight - Row - 1;

  case fLocation of

    ieMemory:
      if fFragments=nil then
        result := pointer(int64(DWORD(fMemory)) + (fHeight - Row - 1) * fRowlen)
      else
        result := pointer( int64(DWORD(fFragments[Row div fRowsPerFragment])) + fRowlen * (Row mod fRowsPerFragment) );

    ieTBitmap:
      result := fBitmapScanlines[row];

    ieFile:
      begin
        if fWorkingMap <> nil then
          fmemmap.UnMap(fWorkingMap);
        fWorkingMap := fmemmap.Map(int64(Row) * fRowLen, fRowLen, fAccess); // int64(Row) to promote expression to 64 bit
        result := fWorkingMap;
      end;

  else
    result := nil;
  end;
end;

{!!
<FS>TIEBitmap.GetRow

<FM>Declaration<FC>
function GetRow(Row:integer):pointer;

<FM>Description<FN>
GetRow gets a pointer to the specified Row. Returned pointer is valid until the application calls <A TIEBitmap.FreeRow>.
Just like <A TIEBitmap.Scanline> if <A TIEBitmap.Location> is ieMemory or ieTBitmap.
!!}
// for performance we never control if Row is valid
function TIEBitmap.GetRow(Row: integer): pointer;
begin
  case fLocation of

    ieMemory:
      if fFragments=nil then
        result := pointer(int64(DWORD(fMemory)) + (fHeight - Row - 1) * fRowlen)
      else
        result := pointer( int64(DWORD(fFragments[Row div fRowsPerFragment])) + fRowlen * (Row mod fRowsPerFragment) );

    ieTBitmap:
      result := fBitmapScanlines[row];

    ieFile:
      begin
        if fWorkingMap<>nil then
        begin
          // flushes the working map (from Scnaline[])
          fmemmap.UnMap(fWorkingMap);
          fWorkingMap:=nil;
        end;
        result := fmemmap.Map(Row * fRowLen, fRowLen, fAccess);
        fScanlinesToUnMapPtr.Add(result);
        fScanlinesToUnMapRow.Add(pointer(Row));
      end;

  else
    result := nil;
  end;
end;

{!!
<FS>TIEBitmap.FreeRow

<FM>Declaration<FC>
procedure FreeRow(Row:integer);

<FM>Description<FN>
FreeRow frees a row obtained using <A TIEBitmap.GetRow>.
Does nothing if <A TIEBitmap.Location> is ieMemory or ieTBitmap.
!!}
// for performance we never control if Row is valid
// 2.2.5
procedure TIEBitmap.FreeRow(Row: integer);
var
  idx:integer;
begin
  if (fLocation = ieFile) then
  begin
    idx:=fScanlinesToUnMapRow.IndexOf(pointer(Row));
    if idx>=0 then
    begin
      fmemmap.UnMap(fScanlinesToUnMapPtr[idx]);
      fScanlinesToUnMapPtr.Delete(idx);
      fScanlinesToUnMapRow.Delete(idx);
    end;
  end;
end;

{!!
<FS>TIEBitmap.CopyFromMemory

<FM>Declaration<FC>
procedure CopyFromMemory(SrcBuffer:pointer; SrcWidth:integer; SrcHeight:integer; SrcPixelFormat:TIEPixelFormat; SrcOrigin:TIEBitmapOrigin; SrcRowLen:integer);

<FM>Description<FN>
Copies an image from memory buffer.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>SrcBuffer<FN></C> <C>Source memory buffer.</C> </R>
<R> <C><FC>SrcWidth<FN></C> <C>Source image width.</C> </R>
<R> <C><FC>SrcHeight<FN></C> <C>Source image height.</C> </R>
<R> <C><FC>SrcPixelFormat<FN></C> <C>Source pixel format.</C> </R>
<R> <C><FC>SrcOrigin<FN></C> <C>Source orientation.</C> </R>
<R> <C><FC>SrcRowLen<FN></C> <C>Source row length.</C> </R>
</TABLE>

!!}
procedure TIEBitmap.CopyFromMemory(SrcBuffer:pointer; SrcWidth:integer; SrcHeight:integer; SrcPixelFormat:TIEPixelFormat; SrcOrigin:TIEBitmapOrigin; SrcRowLen:integer);
var
  bmp:TIEBitmap;
  row:integer;
begin
  bmp := TIEBitmap.Create;
  try
    bmp.EncapsulateMemory(SrcBuffer, SrcWidth, SrcHeight, SrcPixelFormat, false, SrcOrigin);
    bmp.fRowlen := SrcRowLen;
    Allocate(SrcWidth, SrcHeight, SrcPixelFormat);
    for row:=0 to SrcHeight-1 do
      CopyMemory(Scanline[row], bmp.Scanline[row], bmp.RowLen);
    fFull := false;
  finally
    bmp.Free;
  end;
end;

{!!
<FS>TIEBitmap.CopyAndConvertFormat

<FM>Declaration<FC>
procedure CopyAndConvertFormat(Source:<A TIEBitmap>);

<FM>Description<FN>
Copies from specified source image converting to current pixel format.
Uses color quantizers when convert from a true color to a paletted.
ieTBitmap is not supported.
!!}
procedure TIEBitmap.CopyAndConvertFormat(Source:TIEBitmap);
var
  old: TIEBitmap;
  row, col, q, v: integer;
  px_src, px_dst: pbyte;
  px_src_w, px_dst_w: pword;
  px_src_rgb: PRGB;
  px_dst_f, px_src_f: psingle;
  px_dst_cmyk, px_src_cmyk:PCMYK;
  px_dst_cielab, px_src_cielab:PCIELAB;
  px_dst_48rgb:pword;
  px_dst_rgb:PRGB;
  px_src_48rgb:PRGB48;
  px_dst_rgb32:PRGBA;
  qt: TIEQuantizer;
  tmpcolormap: array[0..255] of TRGB;
  nullpr: TProgressRec;
  range:double;
  black, white:integer;
begin
  if (fWidth<>Source.fWidth) or (fHeight<>Source.fHeight) or (fLocation=ieTBitmap) then
    exit;
  with nullpr do
  begin
    Aborting := nil;
    fOnProgress := nil;
    Sender := nil;
  end;
  old := Source;
  if old.fPixelFormat <> ienull then
  begin
    case old.fPixelFormat of

      ie1g:
        case fPixelFormat of
          ie8p:
            begin
              // 1bit gray scale ==> 8bit paletted
              with fRGBPalette[0] do
              begin
                r := 0;
                b := 0;
                g := 0;
              end;
              with fRGBPalette[1] do
              begin
                r := 255;
                b := 255;
                g := 255;
              end;
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := ord(GetPixelbw_inline(px_src, col) <> 0);
                  inc(px_dst);
                end;
              end;
            end;
          ie8g:
            begin
              // 1bit gray scale ==> 8bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := ord(GetPixelbw_inline(px_src, col) <> 0) * 255;
                  inc(px_dst);
                end;
              end;
            end;
          ie16g:
            begin
              // 1bit gray scale ==> 16bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_w := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_w^ := ord(GetPixelbw_inline(px_src, col) <> 0) * 65535;
                  inc(px_dst_w);
                end;
              end;
            end;
          ie24RGB:
            begin
              // 1bit gray scale ==> 24bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  v := ord(GetPixelbw_inline(px_src, col) <> 0) * 255;
                  px_dst^ := v;
                  inc(px_dst);
                  px_dst^ := v;
                  inc(px_dst);
                  px_dst^ := v;
                  inc(px_dst);
                end;
              end;
            end;
          ie32RGB:
            begin
              // 1bit gray scale ==> 32bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  v := ord(GetPixelbw_inline(px_src, col) <> 0) * 255;
                  px_dst^ := v; inc(px_dst);
                  px_dst^ := v; inc(px_dst);
                  px_dst^ := v; inc(px_dst);
                  px_dst^ := 255;
                  inc(px_dst);
                end;
              end;
            end;
          ie32f:
            begin
              // 1bit gray scale ==> 32bit float point gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_f := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_f^ := ord(GetPixelbw_inline(px_src, col) <> 0);
                  inc(px_dst_f);
                end;
              end;
            end;
          ieCMYK:
            begin
              // 1bit gray scale ==> CMYK
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ieCIELab:
            begin
              // 1bit gray scale ==> CIELab
              old.ConvertToPixelFormat(ieCIELab);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie48RGB:
            begin
              // 1bit gray scale ==> 48bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_48RGB := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  v := ord(GetPixelbw_inline(px_src, col) <> 0) * 65535;
                  px_dst_48rgb^ := v;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := v;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := v;
                  inc(px_dst_48rgb);
                end;
              end;
            end;
        end;

      ie8p:
        case fPixelFormat of
          ie1g:
            begin
              // 8bit paletted ==> 1bit gray scale
              case fDefaultDitherMethod of
                ieOrdered:
                  // use ordered black/white conversion
                  for row := 0 to fHeight - 1 do
                  begin
                    px_src := old.ScanLine[row];
                    px_dst := ScanLine[row];
                    for col := 0 to fWidth - 1 do
                    begin
                      with old.fRGBPalette[px_src^] do
                        v := ((r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100) shr 2;
                      SetPixelbw_inline(px_dst, col, ord(v > BWORDERPATTERN[col and 7][row and 7]));
                      inc(px_src);
                    end;
                  end;
                ieThreshold:
                  // use threshold conversion
                  _ConvertToBWThresholdEx(old, self, -1, nullpr);
              end;
            end;
          ie8g:
            begin
              // 8bit paletted ==> 8bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with old.fRGBPalette[px_src^] do
                    px_dst^ := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
                  inc(px_dst);
                  inc(px_src);
                end;
              end;
            end;
          ie16g:
            begin
              // 8bit paletted ==> 16bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_w := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with old.fRGBPalette[px_src^] do
                    px_dst_w^ := (212 * (r*257) + 713 * (g*257) + 75 * (b*257)) div 1000;
                  inc(px_dst_w);
                  inc(px_src);
                end;
              end;
            end;
          ie24RGB:
            begin
              // 8bit paletted ==> 24bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with old.fRGBPalette[px_src^] do
                  begin
                    px_dst^ := b;
                    inc(px_dst);
                    px_dst^ := g;
                    inc(px_dst);
                    px_dst^ := r;
                    inc(px_dst);
                  end;
                  inc(px_src);
                end;
              end;
            end;
          ie32RGB:
            begin
              // 8bit paletted ==> 32bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with old.fRGBPalette[px_src^] do
                  begin
                    px_dst^ := b;
                    inc(px_dst);
                    px_dst^ := g;
                    inc(px_dst);
                    px_dst^ := r;
                    inc(px_dst);
                    px_dst^ := 255;
                    inc(px_dst);
                  end;
                  inc(px_src);
                end;
              end;
            end;
          ie32f:
            begin
              // 8bit paletted ==> 32bit float point gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_f := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with old.fRGBPalette[px_src^] do
                    px_dst_f^ := (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255; // Rec 709
                  inc(px_dst_f);
                  inc(px_src);
                end;
              end;
            end;
          ieCMYK:
            begin
              // 8bit paletted ==> CMYK
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ieCIELab:
            begin
              // 8bit paletted ==> CIELab
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie48RGB:
            begin
              // 8bit paletted ==> 48bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_48rgb := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with old.fRGBPalette[px_src^] do
                  begin
                    px_dst_48rgb^ := r *257;
                    inc(px_dst_48rgb);
                    px_dst_48rgb^ := g *257;
                    inc(px_dst_48rgb);
                    px_dst_48rgb^ := b *257;
                    inc(px_dst_48rgb);
                  end;
                  inc(px_src);
                end;
              end;
            end;
        end;

      ie8g:
        case fPixelFormat of
          ie1g:
            begin
              // 8bit gray scale ==> 1bit gray scale
              case fDefaultDitherMethod of
                ieOrdered:
                  // use ordered black/white conversion
                  for row := 0 to fHeight - 1 do
                  begin
                    px_src := old.ScanLine[row];
                    px_dst := ScanLine[row];
                    for col := 0 to fWidth - 1 do
                    begin
                      SetPixelbw_inline(px_dst, col, ord((px_src^ shr 2) > BWORDERPATTERN[col and 7][row and 7]));
                      inc(px_src);
                    end;
                  end;
                ieThreshold:
                  // use threshold conversion
                  _ConvertToBWThresholdEx(old, self, -1, nullpr);
              end;
            end;
          ie8p:
            begin
              // 8bit gray scale ==> 8bit paletted
              for q := 0 to 255 do
                with fRGBPalette[q] do
                begin
                  r := q;
                  g := q;
                  b := q;
                end;
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                CopyMemory(px_dst, px_src, fRowLen);
              end;
            end;
          ie16g:
            begin
              // 8bit gray scale ==> 16bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_w := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_w^ := px_src^ *257;
                  inc(px_src);
                  inc(px_dst_w);
                end;
              end;
            end;
          ie24RGB:
            begin
              // 8bit gray scale ==> 24bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := px_src^;
                  inc(px_dst);
                  px_dst^ := px_src^;
                  inc(px_dst);
                  px_dst^ := px_src^;
                  inc(px_dst);
                  inc(px_src);
                end;
              end;
            end;
          ie32RGB:
            begin
              // 8bit gray scale ==> 32bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := px_src^;
                  inc(px_dst);
                  px_dst^ := px_src^;
                  inc(px_dst);
                  px_dst^ := px_src^;
                  inc(px_dst);
                  px_dst^ := 255;
                  inc(px_dst);
                  inc(px_src);
                end;
              end;
            end;
          ie32f:
            begin
              // 8bit gray scale ==> 32bit float point gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_f := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_f^ := px_src^ / 255;
                  inc(px_src);
                  inc(px_dst_f);
                end;
              end;
            end;
          ieCMYK:
            begin
              // 8bit gray scale ==> CMYK
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ieCIELab:
            begin
              // 8bit gray scale ==> CIELab
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie48RGB:
            begin
              // 8bit gray scale ==> 48bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst_48rgb := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_48rgb^ := px_src^ *257;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := px_src^ *257;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := px_src^ *257;
                  inc(px_dst_48rgb);
                  inc(px_src);
                end;
              end;
            end;
        end;

      ie16g:
        case fPixelFormat of
          ie1g:
            begin
              // 16bit gray scale ==> 1bit gray scale
              case fDefaultDitherMethod of
                ieOrdered:
                  // use ordered black/white conversion
                  for row := 0 to fHeight - 1 do
                  begin
                    px_src_w := old.ScanLine[row];
                    px_dst := ScanLine[row];
                    for col := 0 to fWidth - 1 do
                    begin
                      SetPixelbw_inline(px_dst, col, ord((px_src_w^ shr 10) > BWORDERPATTERN[col and 7][row and 7]));
                      inc(px_src_w);
                    end;
                  end;
                ieThreshold:
                  // use threshold conversion
                  _ConvertToBWThresholdEx(old, self, -1, nullpr);
              end;
            end;
          ie8p:
            begin
              // 16bit gray scale ==> 8bit paletted
              for q := 0 to 255 do
                with fRGBPalette[q] do
                begin
                  r := q;
                  g := q;
                  b := q;
                end;
              for row := 0 to fHeight - 1 do
              begin
                px_src_w := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := px_src_w^ shr 8;
                  inc(px_dst);
                  inc(px_src_w);
                end;
              end;
            end;
          ie8g:
            begin
              // 16bit gray scale ==> 8bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_w := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := px_src_w^ shr 8;
                  inc(px_dst);
                  inc(px_src_w);
                end;
              end;
            end;
          ie24RGB:
            begin
              // 16bit gray scale ==> 24bit RGB
              range := fWhiteValue - fBlackValue;
              if range=0 then
              begin
                for row := 0 to fHeight - 1 do
                begin
                  px_src_w := old.ScanLine[row];
                  px_dst := ScanLine[row];
                  for col := 0 to fWidth - 1 do
                  begin
                    px_dst^ := px_src_w^ shr 8;
                    inc(px_dst);
                    px_dst^ := px_src_w^ shr 8;
                    inc(px_dst);
                    px_dst^ := px_src_w^ shr 8;
                    inc(px_dst);
                    inc(px_src_w);
                  end;
                end;
              end
              else
              begin
                black := trunc(fBlackValue);
                white := trunc(fWhiteValue);
                for row := 0 to fHeight - 1 do
                begin
                  px_src_w := old.ScanLine[row];
                  px_dst := ScanLine[row];
                  for col := 0 to fWidth - 1 do
                  begin
                    v := px_src_w^;
                    if v <= black then
                      v := black;
                    if v >= white then
                      v := white;
                    v := trunc(((v - black) / range) * 255);
                    px_dst^ := v;
                    inc(px_dst);
                    px_dst^ := v;
                    inc(px_dst);
                    px_dst^ := v;
                    inc(px_dst);
                    inc(px_src_w);
                  end;
                end;
              end;
            end;
          ie32RGB:
            begin
              // 16bit gray scale ==> 32bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_w := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := px_src_w^ shr 8;
                  inc(px_dst);
                  px_dst^ := px_src_w^ shr 8;
                  inc(px_dst);
                  px_dst^ := px_src_w^ shr 8;
                  inc(px_dst);
                  px_dst^ := 255;
                  inc(px_dst);
                  inc(px_src_w);
                end;
              end;
            end;
          ie32f:
            begin
              // 16bit gray scale ==> 32bit float point gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_w := old.ScanLine[row];
                px_dst_f := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_f^ := px_src_w^ / 65535;
                  inc(px_dst_f);
                  inc(px_src_w);
                end;
              end;
            end;
          ieCMYK:
            begin
              // 16bit gray scale ==> CMYK
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ieCIELab:
            begin
              // 16bit gray scale ==> CIELab
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie48RGB:
            begin
              // 16bit gray scale ==> 48bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_w := old.ScanLine[row];
                px_dst_48rgb := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_48rgb^ := px_src_w^;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := px_src_w^;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := px_src_w^;
                  inc(px_dst_48rgb);
                  inc(px_src_w);
                end;
              end;
            end;
        end;

      ie24RGB:
        case fPixelFormat of
          ie1g:
            begin
              // 24bit RGB ==> 1bit gray scale
              case fDefaultDitherMethod of
                ieOrdered:
                  // use ordered black/white conversion
                  for row := 0 to fHeight - 1 do
                  begin
                    px_src_rgb := old.ScanLine[row];
                    px_dst := ScanLine[row];
                    for col := 0 to fWidth - 1 do
                    begin
                      with px_src_rgb^ do
                        v := ((r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100) shr 2;
                      SetPixelbw_inline(px_dst, col, ord(v > BWORDERPATTERN[col and 7][row and 7]));
                      inc(px_src_rgb);
                    end;
                  end;
                ieThreshold:
                  // use threshold conversion
                  _ConvertToBWThresholdEx(old, self, -1, nullpr);
              end;
            end;
          ie8p:
            begin
              // 24bit RGB ==> 8bit paletted
              // use color reduction
              qt := TIEQuantizer.Create(old, tmpcolormap, fPaletteUsed);
              for q := 0 to 255 do
              begin
                fRGBPalette[q].r := tmpcolormap[q].r;
                fRGBPalette[q].g := tmpcolormap[q].g;
                fRGBPalette[q].b := tmpcolormap[q].b;
              end;
              for row := 0 to fHeight - 1 do
              begin
                px_src_rgb := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := qt.RGBIndex[px_src_rgb^];
                  inc(px_dst);
                  inc(px_src_rgb);
                end;
              end;
              FreeAndNil(qt);
            end;
          ie8g:
            begin
              // 24bit RGB ==> 8bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_rgb := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_src_rgb^ do
                    px_dst^ := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
                  inc(px_src_rgb);
                  inc(px_dst);
                end;
              end;
            end;
          ie16g:
            begin
              // 24bit RGB ==> 16bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_rgb := old.ScanLine[row];
                px_dst_w := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_src_rgb^ do
                    px_dst_w^ := (212 * (r*257) + 713 * (g*257) + 75 * (b*257)) div 1000;
                  inc(px_src_rgb);
                  inc(px_dst_w);
                end;
              end;
            end;
          ie32f:
            begin
              // 24bit RGB ==> 32bit float point gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_rgb := old.ScanLine[row];
                px_dst_f := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_src_rgb^ do
                    px_dst_f^ := (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255; // Rec 709
                  inc(px_src_rgb);
                  inc(px_dst_f);
                end;
              end;
            end;
          ieCMYK:
            begin
              // 24bit RGB ==> CMYK
              for row:=0 to fHeight-1 do
              begin
                px_src_rgb := old.ScanLine[row];
                px_dst_cmyk := ScanLine[row];
                for col:=0 to fWidth-1 do
                begin
                  px_dst_cmyk^:=IERGB2CMYK(px_src_rgb^);
                  inc(px_src_rgb);
                  inc(px_dst_cmyk);
                end;
              end;
            end;
          ieCIELab:
            begin
              // 24bit RGB ==> CIELab
              for row:=0 to fHeight-1 do
              begin
                px_src_rgb := old.ScanLine[row];
                px_dst_cielab := ScanLine[row];
                for col:=0 to fWidth-1 do
                begin
                  px_dst_cielab^:=IERGB2CIELAB(px_src_rgb^);
                  inc(px_src_rgb);
                  inc(px_dst_cielab);
                end;
              end;
            end;
          ie48RGB:
            begin
              // 24bit RGB ==> 48bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_rgb := old.ScanLine[row];
                px_dst_48rgb := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_48rgb^ := px_src_rgb^.r *257; inc(px_dst_48rgb);
                  px_dst_48rgb^ := px_src_rgb^.g *257; inc(px_dst_48rgb);
                  px_dst_48rgb^ := px_src_rgb^.b *257; inc(px_dst_48rgb);
                  inc(px_src_rgb);
                end;
              end;
            end;
          ie32RGB:
            begin
              // 24bit RGB ==> 32bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := px_src^; inc(px_dst); inc(px_src);
                  px_dst^ := px_src^; inc(px_dst); inc(px_src);
                  px_dst^ := px_src^; inc(px_dst); inc(px_src);
                  px_dst^ := 255; inc(px_dst);
                end;
              end;
            end;
        end;

      ie32f:
        case fPixelFormat of
          ie1g:
            begin
              // 32bit float pointgray scale ==> 1bit gray scale
              case fDefaultDitherMethod of
                ieOrdered:
                  // use ordered black/white conversion
                  for row := 0 to fHeight - 1 do
                  begin
                    px_src_f := old.ScanLine[row];
                    px_dst := ScanLine[row];
                    for col := 0 to fWidth - 1 do
                    begin
                      SetPixelbw_inline(px_dst, col, ord((px_src_f^ / 2) > BWORDERPATTERN[col and 7][row and 7]));
                      inc(px_src_f);
                    end;
                  end;
                ieThreshold:
                  // use threshold conversion
                  _ConvertToBWThresholdEx(old, self, -1, nullpr);
              end;
            end;
          ie8p:
            begin
              // 32bit float point gray scale ==> 8bit paletted
              for q := 0 to 255 do
                with fRGBPalette[q] do
                begin
                  r := q;
                  g := q;
                  b := q;
                end;
              for row := 0 to fHeight - 1 do
              begin
                px_src_f := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := trunc(px_src_f^ * 255);
                  inc(px_src_f);
                  inc(px_dst);
                end;
              end;
            end;
          ie8g:
            begin
              // 32bit float point gray scale ==> 8bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_f := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst^ := trunc(px_src_f^ * 255);
                  inc(px_src_f);
                  inc(px_dst);
                end;
              end;
            end;
          ie16g:
            begin
              // 32bit float point gray scale ==> 16bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_f := old.ScanLine[row];
                px_dst_w := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  px_dst_w^ := trunc(px_src_f^ * 65535);
                  inc(px_src_f);
                  inc(px_dst_w);
                end;
              end;
            end;
          ie24RGB:
            begin
              // 32bit float point gray scale ==> 24bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_f := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  v := trunc(px_src_f^ * 255);
                  px_dst^ := v;
                  inc(px_dst);
                  px_dst^ := v;
                  inc(px_dst);
                  px_dst^ := v;
                  inc(px_dst);
                  inc(px_src_f);
                end;
              end;
            end;
          ie32RGB:
            begin
              // 32bit float point gray scale ==> 32bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_f := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  v := trunc(px_src_f^ * 255);
                  px_dst^ := v;
                  inc(px_dst);
                  px_dst^ := v;
                  inc(px_dst);
                  px_dst^ := v;
                  inc(px_dst);
                  px_dst^ := 255;
                  inc(px_dst);
                  inc(px_src_f);
                end;
              end;
            end;
          ieCMYK:
            begin
              // 32bit float point gray scale ==> CMYK
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ieCIELab:
            begin
              // 32bit float point gray scale ==> CIELab
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie48RGB:
            begin
              // 32bit float point gray scale ==> 48bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_f := old.ScanLine[row];
                px_dst_48rgb := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  v := trunc(px_src_f^ * 65535);
                  px_dst_48rgb^ := v;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := v;
                  inc(px_dst_48rgb);
                  px_dst_48rgb^ := v;
                  inc(px_dst_48rgb);
                  inc(px_src_f);
                end;
              end;
            end;
        end;

      ieCMYK:
        case fPixelFormat of
          ie1g:
            begin
              // CMYK ==> 1bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie8p:
            begin
              // CMYK ==> 8bit paletted
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie8g:
            begin
              // CMYK ==> 8bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie16g:
            begin
              // CMYK ==> 16bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie32f:
            begin
              // CMYK ==> 32bit float point gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ieCIELab:
            begin
              // CMYK ==> CIELab
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie24RGB:
            begin
              // CMYK ==> RGB24
              for row:=0 to fHeight-1 do
              begin
                px_src_cmyk:=old.ScanLine[row];
                px_dst_rgb:=ScanLine[row];
                for col:=0 to fWidth-1 do
                begin
                  px_dst_rgb^:=IECMYK2RGB(px_src_cmyk^);
                  inc(px_src_cmyk);
                  inc(px_dst_rgb);
                end;
              end;
            end;
          ie32RGB:
            begin
              // CMYK ==> RGB32
              for row:=0 to fHeight-1 do
              begin
                px_src_cmyk:=old.ScanLine[row];
                px_dst_rgb32:=ScanLine[row];
                for col:=0 to fWidth-1 do
                begin
                  with IECMYK2RGB(px_src_cmyk^) do
                  begin
                    px_dst_rgb32^.r:=r;
                    px_dst_rgb32^.g:=g;
                    px_dst_rgb32^.b:=b;
                    px_dst_rgb32^.a:=255;
                  end;
                  inc(px_src_cmyk);
                  inc(px_dst_rgb32);
                end;
              end;
            end;
          ie48RGB:
            begin
              // CMYK ==> 48 BIT RGB
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
        end;

      ieCIELab:
        case fPixelFormat of
          ie1g:
            begin
              // CIELab ==> 1bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie8p:
            begin
              // CIELab ==> 8bit paletted
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie8g:
            begin
              // CIELab ==> 8bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie16g:
            begin
              // CIELab ==> 16bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie32f:
            begin
              // CIELab ==> 32bit float point gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie24RGB:
            begin
              // CIELab ==> RGB24
              for row:=0 to fHeight-1 do
              begin
                px_src_cielab:=old.ScanLine[row];
                px_dst_rgb:=ScanLine[row];
                for col:=0 to fWidth-1 do
                begin
                  px_dst_rgb^:=IECIELAB2RGB(px_src_cielab^);
                  inc(px_src_cielab);
                  inc(px_dst_rgb);
                end;
              end;
            end;
          ie32RGB:
            begin
              // CIELab ==> RGB32
              for row:=0 to fHeight-1 do
              begin
                px_src_cielab:=old.ScanLine[row];
                px_dst_rgb32:=ScanLine[row];
                for col:=0 to fWidth-1 do
                begin
                  with IECIELAB2RGB(px_src_cielab^) do
                  begin
                    px_dst_rgb32^.r:=r;
                    px_dst_rgb32^.g:=g;
                    px_dst_rgb32^.b:=b;
                    px_dst_rgb32^.a:=255;
                  end;
                  inc(px_src_cielab);
                  inc(px_dst_rgb32);
                end;
              end;
            end;
          ieCMYK:
            begin
              // CIELab ==> CMYK
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie48RGB:
            begin
              // CIELab ==> 48 BIT RGB
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
        end;

      ie48RGB:
        case fPixelFormat of
          ie1g:
            begin
              // 48bit RGB ==> 1bit gray scale
              case fDefaultDitherMethod of
                ieOrdered:
                  // use ordered black/white conversion
                  for row := 0 to fHeight - 1 do
                  begin
                    px_src_48rgb := old.ScanLine[row];
                    px_dst := ScanLine[row];
                    for col := 0 to fWidth - 1 do
                    begin
                      with px_src_48rgb^ do
                        v := (((r shr 8) * gRedToGrayCoef + (g shr 8) * gGreenToGrayCoef + (b shr 8) * gBlueToGrayCoef) div 100) shr 2;
                      SetPixelbw_inline(px_dst, col, ord(v > BWORDERPATTERN[col and 7][row and 7]));
                      inc(px_src_48rgb);
                    end;
                  end;
                ieThreshold:
                  // use threshold conversion
                  begin
                    old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
                    _ConvertToBWThresholdEx(old, self, -1, nullpr);
                  end;
              end;
            end;
          ie8p,ieCMYK,ieCIELab:
            begin
              // 48bit RGB ==> 8bit paletted, CMYK, CIELab
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie8g:
            begin
              // 48bit RGB ==> 8bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_48rgb := old.ScanLine[row];
                px_dst := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_src_48rgb^ do
                    px_dst^ := ((r shr 8) * gRedToGrayCoef + (g shr 8) * gGreenToGrayCoef + (b shr 8) * gBlueToGrayCoef) div 100;
                  inc(px_src_48rgb);
                  inc(px_dst);
                end;
              end;
            end;
          ie16g:
            begin
              // 24bit RGB ==> 16bit gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_48rgb := old.ScanLine[row];
                px_dst_w := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_src_48rgb^ do
                    px_dst_w^ := (212 * (r) + 713 * (g) + 75 * (b)) div 1000;
                  inc(px_src_48rgb);
                  inc(px_dst_w);
                end;
              end;
            end;
          ie32f:
            begin
              // 24bit RGB ==> 32bit float point gray scale
              for row := 0 to fHeight - 1 do
              begin
                px_src_48rgb := old.ScanLine[row];
                px_dst_f := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_src_48rgb^ do
                    px_dst_f^ := (0.2126 * r/256 + 0.7152 * g/256 + 0.0722 * b/256) / 255; // Rec 709
                  inc(px_src_48rgb);
                  inc(px_dst_f);
                end;
              end;
            end;
          ie24RGB:
            begin
              // 48bit RGB ==> 24bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_48rgb := old.ScanLine[row];
                px_dst_rgb := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_dst_rgb^ do
                  begin
                    r := px_src_48rgb^.r shr 8;
                    g := px_src_48rgb^.g shr 8;
                    b := px_src_48rgb^.b shr 8;
                  end;
                  inc(px_src_48rgb);
                  inc(px_dst_rgb);
                end;
              end;
            end;
          ie32RGB:
            begin
              // 48bit RGB ==> 32bit RGB
              for row := 0 to fHeight - 1 do
              begin
                px_src_48rgb := old.ScanLine[row];
                px_dst_rgb32 := ScanLine[row];
                for col := 0 to fWidth - 1 do
                begin
                  with px_dst_rgb32^ do
                  begin
                    r := px_src_48rgb^.r shr 8;
                    g := px_src_48rgb^.g shr 8;
                    b := px_src_48rgb^.b shr 8;
                    a := 255;
                  end;
                  inc(px_src_48rgb);
                  inc(px_dst_rgb32);
                end;
              end;
            end;
        end;

      ie32RGB:
        case fPixelFormat of
          ie1g:
            begin
              // ie32RGB ==> 1bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie8p:
            begin
              // ie32RGB ==> 8bit paletted
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie8g:
            begin
              // ie32RGB ==> 8bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie16g:
            begin
              // ie32RGB ==> 16bit gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie32f:
            begin
              // ie32RGB ==> 32bit float point gray scale
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie24RGB:
            begin
              // ie32RGB ==> RGB24
              for row:=0 to fHeight-1 do
              begin
                px_src:=old.ScanLine[row];
                px_dst:=ScanLine[row];
                for col:=0 to fWidth-1 do
                begin
                  px_dst^:=px_src^; inc(px_dst); inc(px_src);
                  px_dst^:=px_src^; inc(px_dst); inc(px_src);
                  px_dst^:=px_src^; inc(px_dst); inc(px_src);
                  inc(px_src);  // bypass last byte
                end;
              end;
            end;
          ieCIELab:
            begin
              // ie32RGB ==> ieCIELab
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ieCMYK:
            begin
              // ie32RGB ==> CMYK
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
          ie48RGB:
            begin
              // ie32RGB ==> 48 BIT RGB
              old.ConvertToPixelFormat(ie24RGB);  // ie24RGB intermediate
              CopyAndConvertFormat(old);
            end;
        end;

    end; // end of src PixelFormat case
  end;

  // alpha channel
  if old.HasAlphaChannel then
    AlphaChannel.Assign(old.AlphaChannel);  // 3.0.4

  UpdateTBitmapPalette;
end;

// if fLocation is ieTBitmap only ie1g and ie24RGB are supported
procedure TIEBitmap.ConvertToPixelFormat(DestPixelFormat: TIEPixelFormat);
var
  old:TIEBitmap;
  bold: TBitmap;
  nullpr: TProgressRec;
  tmp: TIEBitmap;
begin
  with nullpr do
  begin
    Aborting := nil;
    fOnProgress := nil;
    Sender := nil;
  end;
  case fLocation of
    ieMemory,
    ieFile:
      begin
        old := TIEBitmap.Create;
        SwitchTo(old);
        fWidth := old.fWidth;
        fHeight := old.fHeight;
        fPixelFormat := DestPixelFormat;
        AllocateImage;
        if old.fPixelFormat <> ienull then
          CopyAndConvertFormat(old);
        FreeAndNil(old);
      end;
    ieTBitmap:
      begin
        if (fBitmap.Width<>0) and (fBitmap.Height<>0) then
        begin
          case fBitmap.PixelFormat of
            pf1bit:
              case DestPixelFormat of
                ie24RGB:  // from pf1bit to ie24RGB
                  begin
                    bold := IECloneBitmap(fBitmap);
                    _Conv1To24(bold, fBitmap, nullpr);
                    FreeAndNil(bold);
                  end;
              end;
            pf24bit:
              case DestPixelFormat of
                ie1g:     // from pf24bit to ie1g
                  begin
                    tmp := TIEBitmap.Create;
                    tmp.EncapsulateTBitmap(fBitmap, true);
                    case fDefaultDitherMethod of
                      ieOrdered:
                        // use ordered conversion
                        _ConvertToBWOrdered(tmp, nullpr);
                      ieThreshold:
                        // use threshold conversion
                        _ConvertToBWThreshold(tmp, -1, nullpr);
                    end;
                    FreeAndNil(tmp);
                  end;
                ie8g:     // from pf24bit to ie8g
                  begin
                    tmp := TIEBitmap.Create;
                    tmp.AssignImage(self);
                    tmp.PixelFormat:=ie8g;
                    AssignImage(tmp);
                    FreeAndNil(tmp);
                  end;
              end;
          end;
        end else
        begin
          // empty bitmap
          case DestPixelFormat of
            ie1g: fBitmap.PixelFormat:=pf1bit;
            ie24RGB: fBitmap.PixelFormat:=pf24bit;
          end;
        end;
        fPixelFormat := DestPixelFormat;
        fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
        fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
        fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
        BuildBitmapScanlines;
      end;
  end;
end;

{!!
<FS>TIEBitmap.CopyToTBitmap

<FM>Declaration<FC>
procedure CopyToTBitmap(Dest:TBitmap);

<FM>Description<FN>
CopyToTBitmap copies the image to the Dest TBitmap object. These <A TIEBitmap.PixelFormat> conversions are applied:
ie1g -> pf1bit
ie8p -> pf8bit
ie8g -> pf8bit (create gray scale palette)
ie16g -> pf8bit	(copy only high 8 bit)
ie24RGB -> pf24bit
!!}
procedure TIEBitmap.CopyToTBitmap(Dest: TBitmap);
var
  i, row, col, mi: integer;
  ppee: array[0..255] of TPALETTEENTRY;
  px_w: pword;
  px_b: pbyte;
  px_f: psingle;
begin
  Dest.Width := 1;
  Dest.Height := 1;
  case fPixelFormat of
    ie1g: // gray scale (black/white) ==>> pf1bit
      begin
        Dest.PixelFormat := pf1bit;
        ppee[0].peRed := 0;
        ppee[0].peGreen := 0;
        ppee[0].peBlue := 0;
        ppee[0].peFlags := 0;
        ppee[1].peRed := 255;
        ppee[1].peGreen := 255;
        ppee[1].peBlue := 255;
        ppee[1].peFlags := 0;
        SetPaletteEntries(dest.palette, 0, 2, ppee);
        dest.Monochrome := true;
      end;
    ie8p: // color (palette)	==>> pf8bit
      begin
        Dest.PixelFormat := pf8bit;
        for i := 0 to 255 do
        begin
          ppee[i].peRed := fRGBPalette[i].r;
          ppee[i].peGreen := fRGBPalette[i].g;
          ppee[i].peBlue := fRGBPalette[i].b;
          ppee[i].peFlags := 0;
        end;
        SetPaletteEntries(dest.palette, 0, 256, ppee);
      end;
    ie8g: // gray scale (256 levels) ==>> pf8bit
      begin
        Dest.PixelFormat := pf8bit;
        for i := 0 to 255 do
        begin
          ppee[i].peRed := i;
          ppee[i].peGreen := i;
          ppee[i].peBlue := i;
          ppee[i].peFlags := 0;
        end;
        SetPaletteEntries(dest.palette, 0, 256, ppee);
      end;
    ie16g: //	gray scale (65536 levels) ==>> pf8bit
      begin
        Dest.PixelFormat := pf8bit;
        for i := 0 to 255 do
        begin
          ppee[i].peRed := i;
          ppee[i].peGreen := i;
          ppee[i].peBlue := i;
          ppee[i].peFlags := 0;
        end;
        SetPaletteEntries(dest.palette, 0, 256, ppee);
        Dest.Width := fWidth;
        Dest.Height := fHeight;
        for row := 0 to fHeight - 1 do
        begin
          px_w := Scanline[row];
          px_b := Dest.Scanline[row];
          for col := 0 to fWidth - 1 do
          begin
            px_b^ := px_w^ shr 8;
            inc(px_b);
            inc(px_w);
          end;
        end;
      end;
    ie32f: //	gray scale (32bit float point) ==>> pf8bit
      begin
        Dest.PixelFormat := pf8bit;
        for i := 0 to 255 do
        begin
          ppee[i].peRed := i;
          ppee[i].peGreen := i;
          ppee[i].peBlue := i;
          ppee[i].peFlags := 0;
        end;
        SetPaletteEntries(dest.palette, 0, 256, ppee);
        Dest.Width := fWidth;
        Dest.Height := fHeight;
        for row := 0 to fHeight - 1 do
        begin
          px_f := Scanline[row];
          px_b := Dest.Scanline[row];
          for col := 0 to fWidth - 1 do
          begin
            px_b^ := trunc(px_f^ * 255);
            inc(px_b);
            inc(px_f);
          end;
        end;
      end;
    ie24RGB: // color (true color) ==>> pf24bit
      begin
        Dest.PixelFormat := pf24bit;
      end;
    ie32RGB: // color (true color) ==>> pf32bit
      begin
        Dest.PixelFormat := pf32bit;
      end;
    ieCMYK: // CMYK
      begin
        raise Exception.Create('CMYK to TBitmap not supported');
      end;
    ieCIELab: // CIELab
      begin
        raise Exception.Create('CIELab to TBitmap not supported');
      end;
    ie48RGB: // 48RGB
      begin
        raise Exception.Create('RGB48 to TBitmap not supported');
      end;
  end;
  if (fPixelFormat <> ie16g) and (fPixelFormat <> ie32f) then
  begin
    Dest.Width := fWidth;
    Dest.Height := fHeight;
    mi:=imin(fRowLen,_PixelFormat2RowLen(Dest.Width,Dest.PixelFormat));
    for row := 0 to fHeight - 1 do
      CopyMemory(Dest.Scanline[row], Scanline[row], mi);
  end;
end;

{!!
<FS>TIEBitmap.CopyRectTo

<FM>Declaration<FC>
procedure CopyRectTo(Dest:<A TIEBitmap>; SrcX, SrcY, DstX, DstY:integer; RectWidth,RectHeight:integer);

<FM>Description<FN>
Copies a rectangle to the Dest image.  <FC>SrcX, SrcY, DstX, DstY<FN> specify the source and destination positions.
<FC>DstX<FN> and <FC>DstY<FN> can be negative (cut top-left rectangle and reduces size).
<FC>RectWidth<FN> and <FC>RectHeight<FN> specify the rectangle's width and height.
<FC>Dest<FN> must have same <A TIEBitmap.PixelFormat> as the source image.
CopyRectTo doesn't copy the alpha channel.
!!}
// do not copy alpha channel
// also works with negative values for DstX, DstY (cut the top-left rectangle and reduce sizes)
procedure TIEBitmap.CopyRectTo(Dest: TIEBitmap; SrcX, SrcY, DstX, DstY: integer; RectWidth, RectHeight: integer);
var
  y, x, ml, v: integer;
  ps, pd: pbyte;
begin
  // adjust DstX and DstY
  if DstX < 0 then
  begin
    inc(SrcX, -DstX);
    dec(RectWidth, -DstX);
    DstX := 0;
  end;
  if DstY < 0 then
  begin
    inc(SrcY, -DstY);
    dec(RectHeight, -DstY);
    DstY := 0;
  end;
  DstX := imin(DstX, Dest.Width - 1);
  DstY := imin(DstY, Dest.Height - 1);
  // adjust SrcX and SrcY
  SrcX := imin(imax(SrcX, 0), Width - 1);
  SrcY := imin(imax(SrcY, 0), Height - 1);
  // adjust rect size comparing with Source
  if SrcX + RectWidth > Width then
    RectWidth := Width - SrcX;
  if SrcY + RectHeight > Height then
    RectHeight := Height - SrcY;
  // adjust rect size comparing with Dest
  if DstX + RectWidth > Dest.Width then
    RectWidth := Dest.Width - DstX;
  if DstY + RectHeight > Dest.Height then
    RectHeight := Dest.Height - DstY;
  //
  if (PixelFormat = ie1g) and (Dest.PixelFormat = ie1g) then
  begin
    // gray scale (black/white)
    for y := 0 to RectHeight - 1 do
    begin
      ps := Scanline[SrcY + y];
      pd := Dest.Scanline[DstY + y];
      IECopyBits_large(pd, ps, DstX, SrcX, RectWidth, Rowlen);
    end;
  end
  else if (PixelFormat = ie1g) and (dest.PixelFormat = ie24RGB) then
  begin
    // blackwhite to rgb
    for y := 0 to RectHeight - 1 do
    begin
      ps := Scanline[SrcY + y];
      pd := Dest.Scanline[DstY + y];
      inc(pd, DstX * 3);
      for x := SrcX to SrcX + RectWidth - 1 do
      begin
        v := ord(GetPixelbw_inline(ps, x) <> 0) * 255;
        pd^ := v;
        inc(pd);
        pd^ := v;
        inc(pd);
        pd^ := v;
        inc(pd);
      end;
    end;
  end
  else if (PixelFormat = Dest.PixelFormat) then
  begin
    // same format
    case PixelFormat of
      ie8p, ie8g: ml := 1;
      ie16g: ml := 2;
      ie24RGB: ml := 3;
      ie32f: ml := 4;
      ieCMYK: ml:=4;
      ieCIELab: ml:=3;
      ie48RGB: ml:=6;
    else
      exit;
    end;
    for y := 0 to RectHeight - 1 do
    begin
      ps := Scanline[SrcY + y];
      inc(ps, SrcX * ml);
      pd := Dest.Scanline[DstY + y];
      inc(pd, DstX * ml);
      CopyMemory(pd, ps, RectWidth * ml);
    end;
  end;
end;

{!!
<FS>TIEBitmap.MergeAlphaRectTo

<FM>Declaration<FC>
procedure MergeAlphaRectTo(Dest: <A TIEBitmap>; SrcX, SrcY, DstX, DstY: integer; RectWidth, RectHeight: integer);

<FM>Description<FN>
This method copies the alpha channel to <FC>Dest<FN> bitmap alpha channel.
!!}
procedure TIEBitmap.MergeAlphaRectTo(Dest: TIEBitmap; SrcX, SrcY, DstX, DstY: integer; RectWidth, RectHeight: integer);
var
  y, x: integer;
  ps, pd: pbyte;
  dst:TIEBitmap;
begin
  dst:=Dest.AlphaChannel;
  with AlphaChannel do
  begin
    if (PixelFormat<>ie8g) or (dst.PixelFormat<>ie8g) then
      exit;
    // adjust DstX and DstY
    if DstX < 0 then
    begin
      inc(SrcX, -DstX);
      dec(RectWidth, -DstX);
      DstX := 0;
    end;
    if DstY < 0 then
    begin
      inc(SrcY, -DstY);
      dec(RectHeight, -DstY);
      DstY := 0;
    end;
    DstX := imin(DstX, Dst.Width - 1);
    DstY := imin(DstY, Dst.Height - 1);
    // adjust SrcX and SrcY
    SrcX := imin(imax(SrcX, 0), Width - 1);
    SrcY := imin(imax(SrcY, 0), Height - 1);
    // adjust rect size comparing with Source
    if SrcX + RectWidth > Width then
      RectWidth := Width - SrcX;
    if SrcY + RectHeight > Height then
      RectHeight := Height - SrcY;
    // adjust rect size comparing with Dst
    if DstX + RectWidth > Dst.Width then
      RectWidth := Dst.Width - DstX;
    if DstY + RectHeight > Dst.Height then
      RectHeight := Dst.Height - DstY;
    //
    for y := 0 to RectHeight - 1 do
    begin
      ps := Scanline[SrcY + y];
      pd := dst.Scanline[DstY + y];
      inc(pd, DstX );
      inc(ps, SrcX );
      for x := SrcX to SrcX + RectWidth - 1 do
      begin
        pd^:=imax(ps^,pd^);

        inc(pd);
        inc(ps);
      end;
    end;
  end;
end;


{!!
<FS>TIEBitmap.CopyFromTBitmap

<FM>Declaration<FC>
procedure CopyFromTBitmap(Source:TBitmap);

<FM>Description<FN>
CopyFromTBitmap gets the image from the Source TBitmap object.
The source's TBitmap.PixelFormat allowed values are: pf1bit, pf4bit, pf8bit, pf15bit, pf16bit, pf24bit, pf32bit.
If <A TIEBitmap.Location> is ieTBitmap, accepts only pf1bit and pf24bit and pf32bit.
!!}
procedure TIEBitmap.CopyFromTBitmap(Source: TBitmap);
var
  row, col, mi: integer;
  pxb1, pxb2: pbyte;
  pxw1: pword;
  pxrgb: PRGB;
  //az:boolean;
  ppee: array[0..255] of TPALETTEENTRY;
  //
  procedure CopyPalette(cols: integer);
  var
    j: integer;
  begin
    ZeroMemory(@(ppee[0]), sizeof(TPALETTEENTRY) * cols);
    getpaletteentries(Source.Palette, 0, cols, ppee);
    for j := 0 to cols - 1 do
    begin
      fRGBPalette[j].r := ppee[j].peRed;
      fRGBPalette[j].g := ppee[j].peGreen;
      fRGBPalette[j].b := ppee[j].peBlue;
    end;
  end;
  //
begin
  case fLocation of
    ieMemory, ieFile:
      begin
        case Source.PixelFormat of
          pf1bit: // pf1bit ==>> ie1g or ie8p
            begin
              if Source.Monochrome then
              begin
                // pf1bit to ie1g
                Allocate(Source.Width, Source.Height, ie1g);
                mi:=imin(fRowLen,_PixelFormat2RowLen(Source.Width,Source.PixelFormat));
                for row := 0 to fHeight - 1 do
                  CopyMemory(Scanline[row], Source.Scanline[row], mi);
              end
              else
              begin
                // pf1bit to ie8p
                Allocate(Source.Width, Source.Height, ie8p);
                CopyPalette(2);
                for row := 0 to fHeight - 1 do
                begin
                  pxb1 := Source.Scanline[row];
                  pxb2 := Scanline[row];
                  for col := 0 to fWidth - 1 do
                  begin
                    pxb2^ := ord(GetPixelbw_inline(pxb1, col) <> 0);
                    inc(pxb2);
                  end;
                end;
              end;
            end;
          pf4bit: // pf4bit ==>> ie8p
            begin
              Allocate(Source.Width, Source.Height, ie8p);
              CopyPalette(16);
              for row := 0 to fHeight - 1 do
              begin
                pxb1 := Source.Scanline[row];
                pxb2 := Scanline[row];
                for col := 0 to fWidth - 1 do
                begin
                  if (col mod 2) = 0 then
                  begin
                    pxb2^ := (pxb1^ and $F0) shr 4;
                  end
                  else
                  begin
                    pxb2^ := pxb1^ and $0F;
                    inc(pxb1);
                  end;
                  inc(pxb2);
                end;
              end;
            end;
          pf8bit: // pf8bit ==>> ie8p
            begin
              Allocate(Source.Width, Source.Height, ie8p);
              CopyPalette(256);
              mi:=imin(fRowLen,_PixelFormat2RowLen(Source.Width,Source.PixelFormat));
              for row := 0 to fHeight - 1 do
                CopyMemory(Scanline[row], Source.Scanline[row], mi);
            end;
          pf15bit: // pf15bit ==>> ie24RGB
            // 5 43210 98765 43210
            // 0 rrrrr ggggg bbbbb
            //   0-31   0-31  0-31
            begin
              Allocate(Source.Width, Source.Height, ie24RGB);
              for row := 0 to fHeight - 1 do
              begin
                pxw1 := Source.Scanline[row];
                pxrgb := Scanline[row];
                for col := 0 to fWidth - 1 do
                begin
                  with pxrgb^ do
                  begin
                    r := ((pxw1^ and $7C00) shr 10) shl 3;
                    g := ((pxw1^ and $03E0) shr 5) shl 3;
                    b := (pxw1^ and $001F) shl 3;
                  end;
                  inc(pxw1);
                  inc(pxrgb);
                end;
              end;
            end;
          pf16bit: // pf16bit ==>> ie24RGB
            // 54321 098765 43210
            // rrrrr gggggg bbbbb
            // 0-31   0-63   0-31
            begin
              Allocate(Source.Width, Source.Height, ie24RGB);
              for row := 0 to fHeight - 1 do
              begin
                pxw1 := Source.Scanline[row];
                pxrgb := Scanline[row];
                for col := 0 to fWidth - 1 do
                begin
                  with pxrgb^ do
                  begin
                    r := ((pxw1^ and $F800) shr 11) shl 3;
                    g := ((pxw1^ and $07E0) shr 5) shl 2;
                    b := (pxw1^ and $001F) shl 3;
                  end;
                  inc(pxw1);
                  inc(pxrgb);
                end;
              end;
            end;
          pf24bit:
            begin // pf24bit ==>> ie24RGB
              Allocate(Source.Width, Source.Height, ie24RGB);
              mi:=imin(fRowLen,_PixelFormat2RowLen(Source.Width,Source.PixelFormat));
              for row := 0 to fHeight - 1 do
                CopyMemory(Scanline[row], Source.Scanline[row], mi);
            end;
          // 2.3.1
          (*
          pf32bit: // pf32bit ==>> ie24RGB
            begin
              Allocate(Source.Width, Source.Height, ie24RGB);
              for row := 0 to fHeight - 1 do
              begin
                pxrgba := Source.Scanline[row];
                pxrgb := Scanline[row];
                for col := 0 to fWidth - 1 do
                begin
                  pxrgb^ := PRGB(pxrgba)^; // the "a" comes after bgr
                  inc(pxrgb);
                  inc(pxrgba);
                end;
              end;
            end;
          *)
          pf32bit:
            begin // pf32bit ==>> ie32RGB
              Allocate(Source.Width, Source.Height, ie32RGB);
              mi:=imin(fRowLen,_PixelFormat2RowLen(Source.Width,Source.PixelFormat));
              for row := 0 to fHeight - 1 do
                CopyMemory(Scanline[row], Source.Scanline[row], mi);
            end;
        end;
        fFull := false;
      end;

    ieTBitmap:
      begin
        if fBitmap = nil then
          fBitmap := TBitmap.Create;
        // 2.3.1
        if (Source.PixelFormat<>pf1bit) and (Source.PixelFormat<>pf24bit) and (Source.PixelFormat<>pf32bit) then
          Source.PixelFormat:=pf24bit;  // 3.0.1
        IECopyBitmap(Source, fBitmap);
        fWidth := fBitmap.Width;
        fHeight := fBitmap.Height;
        case fBitmap.PixelFormat of
          pf1bit: fPixelFormat := ie1g;
          pf24bit: fPixelFormat := ie24RGB;
          pf32bit: fPixelFormat := ie32RGB;
        end;
        fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
        fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
        fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
        BuildBitmapScanlines;
      end;

  end; // end case
end;

{!!
<FS>TIEBitmap.CopyFromTIEMask

<FM>Declaration<FC>
procedure CopyFromTIEMask(Source:<A TIEMask>);

<FM>Description<FN>
CopyFromTIEMask gets the image from a <A TIEMask> object.
If Source is <FC>nil<FN> then fills the bitmap with all 255.
!!}
procedure TIEBitmap.CopyFromTIEMask(Source: TIEMask);
var
  row,mi: integer;
begin
  if assigned(Source) then
  begin
    case Source.BitsPerPixel of
      1:
        begin
          Allocate(Source.Width, Source.Height, ie1g);
          mi:=imin(fRowLen,Source.RowLen);
          for row := 0 to fHeight - 1 do
            CopyMemory(Scanline[row], Source.Scanline[row], mi);
          fFull := Source.fFull;
        end;
      8:
        begin
          Allocate(Source.Width, Source.Height, ie8g);
          mi:=imin(fRowLen,Source.RowLen);
          for row := 0 to fHeight - 1 do
            CopyMemory(Scanline[row], Source.Scanline[row], mi);
          fFull := Source.fFull;
        end;
    end;
  end
  else
    self.Fill(255);
end;

{!!
<FS>TIEBitmap.CopyFromTDibBitmap

<FM>Declaration<FC>
procedure CopyFromTDibBitmap(Source:<A TIEDibBitmap>);

<FM>Description<FN>
CopyFromTDibBitmap gets the image from a <A TIEDibBitmap> object.
!!}
procedure TIEBitmap.CopyFromTDibBitmap(Source: TIEDibBitmap);
var
  row,mi: integer;
begin
  if assigned(Source) then
  begin
    if fLocation = ieTBitmap then
    begin
      fWidth := Source.Width;
      fHeight := Source.Height;
      if fBitmap = nil then
        fBitmap := TBitmap.Create;
      case Source.BitCount of
        1:
          begin
            fPixelFormat := ie1g;
            fBitmap.Width := 1;
            fBitmap.Height := 1;
            fBitmap.PixelFormat := pf1bit;
          end;
        24:
          begin
            fPixelFormat := ie24RGB;
            fBitmap.Width := 1;
            fBitmap.Height := 1;
            fBitmap.PixelFormat := pf24bit;
          end;
      end;
      fBitmap.Width := fWidth;
      fBitmap.Height := fHeight;
      fBitCount := PIXELFORMAT2BITCOUNT[fPixelFormat];
      fChannelCount:=PIXELFORMAT2CHANNELCOUNT[fPixelFormat];
      fRowLen := IEBitmapRowLen(fWidth, fBitCount, fBitAlignment);
      BuildBitmapScanlines;
    end
    else
    begin
      case Source.BitCount of
        1: Allocate(Source.Width, Source.Height, ie1g);
        8: Allocate(Source.Width, Source.Height, ie8g); // don't copy palette (useful only when source is an alpha channel)
        24: Allocate(Source.Width, Source.Height, ie24RGB);
      end;
    end;
    mi:=imin(fRowLen,Source.RowLen);
    for row := 0 to fHeight - 1 do
      CopyMemory(Scanline[row], Source.Scanline[row], mi);
  end;
end;

{!!
<FS>TIEBitmap.CopyFromDIB

<FM>Declaration<FC>
procedure CopyFromDIB(Source:THandle);
procedure CopyFromDIB(BitmapInfo:pointer; Pixels:pointer=nil);

<FM>Description<FN>
Copies from the specified DIB handle.
The second overload copies from a DIB composed by a BitmapInfo structure and pixels buffer pointer.
When Pixels is null, pixels are supposed to stay just after BitmapInfo structure.
!!}
procedure TIEBitmap.CopyFromDIB(Source:THandle);
begin
  _CopyDIB2BitmapEx(Source,self,nil,false);
end;

procedure TIEBitmap.CopyFromDIB(BitmapInfo:pointer; Pixels:pointer=nil);
begin
  _CopyDIB2BitmapEx(THandle(BitmapInfo),self,Pixels,true);
end;

{!!
<FS>TIEBitmap.CreateDIB

<FM>Declaration<FC>
function CreateDIB:THandle;
function CreateDIB(x1,y1,x2,y2:integer):THandle;

<FM>Description<FN>
Creates a DIB from current image. You are responsible to free memory (calling GlobalFree).
The second overload creates a DIB from specified rectangle of current image.
!!}
function TIEBitmap.CreateDIB:THandle;
begin
  result:=_CopyBitmaptoDIBEx(self,0,0,0,0,gDefaultDPIX,gDefaultDPIY);
end;

function TIEBitmap.CreateDIB(x1,y1,x2,y2:integer):THandle;
begin
  result:=_CopyBitmaptoDIBEx(self,x1,y1,x2,y2,gDefaultDPIX,gDefaultDPIY);
end;

{!!
<FS>TIEBitmap.MergeFromTDibBitmap

<FM>Declaration<FC>
procedure MergeFromTDibBitmap(Source:<A TIEDibBitmap>; x,y:integer);

<FM>Description<FN>
MergeFromTDibBitmap gets the image from a <A TIEDibBitmap> object placing it at the specified coordinates.
It doesn't destroy original image.
Source.<A TIEDibBitmap.PixelFormat> and <A TIEBitmap.PixelFormat> must be both 1 bit or both 24 bit
!!}
//
procedure TIEBitmap.MergeFromTDibBitmap(Source: TIEDibBitmap; x, y: integer);
var
  ww, hh, row: integer;
  ps, pd: pbyte;
begin
  if assigned(Source) then
  begin
    ww := imin(Source.Width, fWidth - x);
    hh := imin(Source.Height, fHeight - y);
    case Source.BitCount of
      1:
        begin
          for row := 0 to hh - 1 do
          begin
            ps := Source.Scanline[row];
            pd := Scanline[row + y];
            IECopyBits_large(pd, ps, x, 0, ww, Source.Rowlen);
          end;
        end;
      24:
        begin
          for row := 0 to hh - 1 do
          begin
            ps := Source.Scanline[row];
            pd := Scanline[row + y];
            inc(pd, x * 3);
            copymemory(pd, ps, ww * 3);
          end;
        end;
    end;
  end;
end;

{!!
<FS>TIEBitmap.CopyToTDibBitmap

<FM>Declaration<FC>
procedure CopyToTDibBitmap(Dest:<A TIEDibBitmap>; source_x, source_y, sourceWidth, sourceHeight:integer);

<FM>Description<FN>
CopyToTDibBitmap copies specified source rectangle inside <FC>Dest<FN> (at top-left side).
Dest.<A TIEDibBitmap.PixelFormat> and <A TIEBitmap.PixelFormat> must both be 1 bit or both 24 bit.
!!}
procedure TIEBitmap.CopyToTDibBitmap(Dest: TIEDibBitmap; source_x, source_y, sourceWidth, sourceHeight: integer);
var
  ww, hh, row: integer;
  ps, pd: pbyte;
begin
  ww := imin(Dest.Width, sourceWidth);
  hh := imin(Dest.Height, sourceHeight);
  case Dest.BitCount of
    1:
      begin
        for row := 0 to hh - 1 do
        begin
          ps := Scanline[row + source_y];
          pd := Dest.Scanline[row];
          IECopyBits_large(pd, ps, 0, source_x, ww, RowLen);
        end;
      end;
    24:
      begin
        for row := 0 to hh - 1 do
        begin
          ps := Scanline[row + source_y];
          inc(ps, 3 * source_x);
          pd := Dest.Scanline[row];
          CopyMemory(pd, ps, ww * 3);
        end;
      end;
  end;
end;

{!!
<FS>TIEBitmap.CopyToTIEMask

<FM>Declaration<FC>
procedure CopyToTIEMask(Dest:<A TIEMask>);

<FM>Description<FN>
CopyToIEMask copies the image to a <A TIEMask> object.
It works only with ie1g and ie8g pixelformats. ie24RGB is converted to ie8g.
!!}
procedure TIEBitmap.CopyToTIEMask(Dest: TIEMask);
var
  row,mi,col: integer;
  pxrgb:PRGB;
  pxb:pbyte;
begin
  case PixelFormat of
    ie1g:
      begin
        Dest.AllocateBits(fWidth, fHeight, 1);
        mi:=imin(fRowLen,Dest.RowLen);
        for row := 0 to fHeight - 1 do
          CopyMemory(Dest.Scanline[row], Scanline[row], mi);
        Dest.fFull := fFull;
      end;
    ie8g:
      begin
        Dest.AllocateBits(fWidth, fHeight, 8);
        mi:=imin(fRowLen,Dest.RowLen);
        for row := 0 to fHeight - 1 do
          CopyMemory(Dest.Scanline[row], Scanline[row], mi);
        Dest.fFull := fFull;
      end;
    ie24RGB:
      begin
        Dest.AllocateBits(fWidth, fHeight, 8);
        for row := 0 to fHeight-1 do
        begin
          pxrgb:=Scanline[row];
          pxb:=Dest.Scanline[row];
          for col:=0 to fWidth-1 do
          begin
            with pxrgb^ do
              pxb^ := ((r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100) shr 2;
            inc(pxrgb);
            inc(pxb);
          end;
        end;
      end;
  end;
end;

function TIEBitmap.GetPalette(index: integer): TRGB;
begin
  if (index < fRGBPaletteLen) and (index >= 0) then
    result := fRGBPalette[index];
end;

function TIEBitmap.GetPaletteBuffer:pointer;
begin
  result := fRGBPalette;
end;

procedure TIEBitmap.SetPalette(index: integer; Value: TRGB);
begin
  if (index < fRGBPaletteLen) and (index >= 0) then
  begin
    fRGBPalette[index] := Value;
    UpdateTBitmapPalette;
  end;
end;

function TIEBitmap.GetPaletteLen:integer;
begin
  result:=fRGBPaletteLen;
end;

function TIEBitmap.GetPixels_ie1g(x, y: integer): boolean;
begin
  result := (pbytearray(Scanline[y])^[x shr 3] and iebitmask1[x and $7]) <> 0;
end;

{!!
<FS>TIEBitmap.Pixels_ie1g

<FM>Declaration<FC>
property Pixels_ie1g[x,y:integer]:boolean;

<FM>Description<FN>
Gets/sets one pixel value in black/white images (ie1g pixelformat). <FC>False<FN> is black, <FC>True<FN> is white.
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ie1g(x, y: integer; Value: boolean);
begin
  SetPixelbw_inline(Scanline[y], x, ord(Value));
  if not Value then
    fFull := false;
end;

function TIEBitmap.GetPixels_ie8(x, y: integer): byte;
begin
  result := pbytearray(Scanline[y])^[x];
end;

{!!
<FS>TIEBitmap.Pixels_ie8

<FM>Declaration<FC>
property Pixels_ie8[x,y:integer]:byte;

<FM>Description<FN>
Gets/sets one pixel value in palette or gray scale images (ie8p or ie8p pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ie8(x, y: integer; Value: byte);
begin
  pbytearray(Scanline[y])^[x] := Value;
  if Value < 255 then
    fFull := false;
end;

function TIEBitmap.GetPixels_ie16g(x, y: integer): word;
begin
  result := pwordarray(Scanline[y])^[x];
end;

{!!
<FS>TIEBitmap.Pixels_ie16g

<FM>Declaration<FC>
property Pixels_ie16g[x,y:integer]:word;

<FM>Description<FN>
Gets/sets one pixel value in 16 bit gray scale images (ie16g pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ie16g(x, y: integer; Value: word);
begin
  pwordarray(Scanline[y])^[x] := Value;
  if Value < 65535 then
    fFull := false;
end;

function TIEBitmap.GetPixels_ie32f(x, y: integer): single;
begin
  result := psinglearray(Scanline[y])^[x];
end;

{!!
<FS>TIEBitmap.Pixels_ie32f

<FM>Declaration<FC>
property Pixels_ie32f[x,y:integer]:single;

<FM>Description<FN>
Gets/sets one pixel value in 32 bit floating point value (single) for gray scale images (ie32f pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ie32f(x, y: integer; Value: single);
begin
  psinglearray(Scanline[y])^[x] := Value;
  if Value < 1 then
    fFull := false;
end;

function TIEBitmap.GetPixels_ieCMYK(x, y: integer): TCMYK;
begin
  result := PCMYKROW(Scanline[y])^[x];
end;

{!!
<FS>TIEBitmap.Pixels_ieCMYK

<FM>Declaration<FC>
property Pixels_ieCMYK[x,y:integer]:<A TCMYK>;

<FM>Description<FN>
Gets/sets one pixel value in CMYK true color images (ieCMYK pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ieCMYK(x, y: integer; Value: TCMYK);
begin
  PCMYKROW(Scanline[y])^[x] := Value;
end;

function TIEBitmap.GetPixels_ieCIELab(x, y: integer): TCIELab;
begin
  result := PCIELABROW(Scanline[y])^[x];
end;

{!!
<FS>TIEBitmap.Pixels_ieCIELab

<FM>Declaration<FC>
property Pixels_ieCIELab[x,y:integer]:<A TCIELab>

<FM>Description<FN>
Gets/sets one pixel value in CIELab color space (ieCIELab pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ieCIELab(x, y: integer; Value: TCIELab);
begin
  PCIELABROW(Scanline[y])^[x] := Value;
end;

function TIEBitmap.GetPixels_ie24RGB(x, y: integer): TRGB;
begin
  result := PRGBROW(Scanline[y])^[x];
end;

function TIEBitmap.GetPixels_ie32RGB(x, y: integer): TRGBA;
begin
  result := PRGB32ROW(Scanline[y])^[x];
end;


{!!
<FS>TIEBitmap.PPixels_ie24RGB

<FM>Declaration<FC>
property PPixels_ie24RGB[x, y: integer]: <A PRGB>;

<FM>Description<FN>
Returns a pointer to spefied pixel.
This function doesn't perform a range check test.
!!}
function TIEBitmap.GetPPixels_ie24RGB(x, y: integer): PRGB;
begin
  result := @(PRGBROW(Scanline[y])^[x]);
end;

{!!
<FS>TIEBitmap.PPixels_ie32RGB

<FM>Declaration<FC>
property PPixels_ie32RGB[x, y: integer]: <A PRGBA>;

<FM>Description<FN>
Returns a pointer to spefied pixel.
This function doesn't perform a range check test.
!!}
function TIEBitmap.GetPPixels_ie32RGB(x, y: integer): PRGBA;
begin
  result := @(PRGB32ROW(Scanline[y])^[x]);
end;


{!!
<FS>TIEBitmap.PPixels_ie48RGB

<FM>Declaration<FC>
property PPixels_ie48RGB[x, y: integer]: <A PRGB48>;

<FM>Description<FN>
Returns a pointer to spefied pixel.
This function doesn't perform a range check test.
!!}
function TIEBitmap.GetPixels_ie48RGB(x, y: integer): TRGB48;
begin
  result := PRGB48ROW(Scanline[y])^[x];
end;

function TIEBitmap.GetPPixels_ie48RGB(x, y: integer): PRGB48;
begin
  result := @(PRGB48ROW(Scanline[y])^[x]);
end;

{!!
<FS>TIEBitmap.Pixels

<FM>Declaration<FC>
property Pixels[x,y:integer]:<A TRGB>;

<FM>Description<FN>
Gets the RGB value for the specified pixel. For black/white images it can be (0, 0, 0) or (255, 255, 255).
This function doesn't perform a range check test.
!!}
function TIEBitmap.GetPixels(x, y: integer): TRGB;
begin
  case fPixelFormat of
    ie1g:
      if (pbytearray(Scanline[y])^[x shr 3] and iebitmask1[x and $7]) = 0 then
        with result do
        begin
          r := 0;
          g := 0;
          b := 0;
        end
      else
        with result do
        begin
          r := 255;
          g := 255;
          b := 255;
        end;
    ie8p:
      result := fRGBPalette[pbytearray(Scanline[y])^[x]];
    ie8g:
      with result do
      begin
        r := pbytearray(Scanline[y])^[x];
        g := r;
        b := r;
      end;
    ie16g:
      with result do
      begin
        r := pwordarray(Scanline[y])^[x] shr 8;
        g := pwordarray(Scanline[y])^[x] shr 8;
        b := pwordarray(Scanline[y])^[x] shr 8;
      end;
    ie32f:
      with result do
      begin
        r := trunc(psinglearray(Scanline[y])^[x] * 255);
        g := trunc(psinglearray(Scanline[y])^[x] * 255);
        b := trunc(psinglearray(Scanline[y])^[x] * 255);
      end;
    ie24RGB:
      result := PRGBROW(Scanline[y])^[x];
    ie32RGB:
      result := PRGB(@PRGB32ROW(Scanline[y])^[x])^;
    ieCMYK:
      result := IECMYK2RGB(PCMYKROW(Scanline[y])^[x]);
    ieCIELab:
      result := IECIELAB2RGB(PCIELABROW(Scanline[y])^[x]);
    ie48RGB:
      with result do
      begin
        r:=PRGB48ROW(Scanline[y])^[x].r shr 8;
        g:=PRGB48ROW(Scanline[y])^[x].g shr 8;
        b:=PRGB48ROW(Scanline[y])^[x].b shr 8;
      end;
  else
    result := CreateRGB(0, 0, 0);
  end;
end;

procedure TIEBitmap.SetPixels(x, y:integer; value:TRGB);
begin
  case fPixelFormat of
    ie1g:
      if (value.r=0) and (value.g=0) and (value.b=0) then
        SetPixelbw_inline(Scanline[y], x, 0)
      else
        SetPixelbw_inline(Scanline[y], x, 1);
    // ie8p: not implemented
    ie8g:     Pixels_ie8[x, y] := (value.r * gRedToGrayCoef + value.g * gGreenToGrayCoef + value.b * gBlueToGrayCoef) div 100;
    ie16g:    Pixels_ie16g[x, y] := (value.r * gRedToGrayCoef + value.g * gGreenToGrayCoef + value.b * gBlueToGrayCoef) div 100 * 257;
    ie32f:    Pixels_ie32f[x, y] := (value.r * gRedToGrayCoef + value.g * gGreenToGrayCoef + value.b * gBlueToGrayCoef) div 100 / 255;
    ie24RGB:  Pixels_ie24RGB[x, y] := value;
    ie32RGB:  Pixels_ie32RGB[x, y] := CreateRGBA(value.r, value.g, value.b, 255);
    ieCMYK:   Pixels_ieCMYK[x, y] := IERGB2CMYK(value);
    ieCIELab: Pixels_ieCIELab[x, y] := IERGB2CIELab(value);
    ie48RGB:  Pixels_ie48RGB[x, y] := CreateRGB48(value.r*257, value.g*257, value.b*257);
  end;
end;


{!!
<FS>TIEBitmap.Pixels_ie24RGB

<FM>Declaration<FC>
property Pixels_ie24RGB[x,y:integer]:<A TRGB>;

<FM>Description<FN>
Gets/sets one pixel value in true color images (ie24RGB pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ie24RGB(x, y: integer; Value: TRGB);
begin
  PRGBROW(Scanline[y])^[x] := Value;
  with Value do
    if (r < 255) or (g < 255) or (b < 255) then
      fFull := false;
end;

{!!
<FS>TIEBitmap.Pixels_ie32RGB

<FM>Declaration<FC>
property Pixels_ie32RGB[x,y:integer]:<A TRGBA>;

<FM>Description<FN>
Gets/sets one pixel value in true color images (ie32RGB pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ie32RGB(x, y: integer; Value: TRGBA);
begin
  PRGB32ROW(Scanline[y])^[x] := Value;
  with Value do
    if (r < 255) or (g < 255) or (b < 255) then
      fFull := false;
end;

{!!
<FS>TIEBitmap.Pixels_ie48RGB

<FM>Declaration<FC>
property Pixels_ie48RGB[x,y:integer]:<A TRGB48>

<FM>Description<FN>
Gets/sets one pixel value in true color 48 bit images (ie48RGB pixelformat).
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetPixels_ie48RGB(x, y: integer; Value: TRGB48);
begin
  PRGB48ROW(Scanline[y])^[x] := Value;
  with Value do
    if (r < 65535) or (g < 65535) or (b < 65535) then
      fFull := false;
end;

function TIEBitmap.GetAlpha(x, y: integer): byte;
begin
  if fIsAlpha then
    result := GetPixels_ie8(x, y)
  else
    result := GetAlphaChannel.GetPixels_ie8(x, y); // use GetAlphaChannel instead of fAlphaChannel to create it on the fly
end;

{!!
<FS>TIEBitmap.Alpha

<FM>Declaration<FC>
property Alpha[x,y:integer]:byte;

<FM>Description<FN>
Gets/sets one pixel alpha value. 0 is transparent, 255 is opaque.
This function doesn't perform a range check test.
!!}
procedure TIEBitmap.SetAlpha(x, y: integer; Value: byte);
begin
  if fIsAlpha then
    SetPixels_ie8(x, y, Value)
  else
    GetAlphaChannel.SetPixels_ie8(x, y, Value); // use GetAlphaChannel instead of fAlphaChannel to create it on the fly
  if Value < 255 then
    fFull := false;
end;

{!!
<FS>TIEBitmap.Fill

<FM>Declaration<FC>
procedure Fill(Value:double);

<FM>Description<FN>
Fills the image with a specified value.
For ie1g images, Value can be 0 or 1. For ie8g and ie8p, it can be from 0 to 255.
For ie16g images, it can be from 0 to 65535.
For ie24RGB, ie32RGB, ieCMYK and ieCIELab Value is a TColor value.
!!}
procedure TIEBitmap.Fill(Value: double);
var
  row, col, iValue: integer;
  pxw: pword;
  pxrgb: PRGB;
  pxrgb48:PRGB48;
  vrgb: TRGB;
  vrgb48:TRGB48;
  pxf: psingle;
  pxcmyk:PCMYK;
  cmyk:TCMYK;
  pxcielab:PCIELab;
  cielab:TCIELab;
  pxb:pbyte;
  laccess: TIEDataAccess;
begin
  laccess := Access;
  Access := [iedWrite];
  ivalue := trunc(Value);
  case fPixelFormat of
    ie1g:
      begin
        if iValue <> 0 then
          iValue := 255;
        for row := 0 to fHeight - 1 do
          fillchar(pbyte(Scanline[row])^, fRowLen, iValue);
        fFull := (iValue <> 0);
      end;
    ie8p, ie8g:
      begin
        // 3.0.1
        for row := 0 to fHeight - 1 do
          fillchar(pbyte(Scanline[row])^, fRowLen, iValue);
        fFull := (iValue = 255);
      end;
    ie16g:
      begin
        for row := 0 to fHeight - 1 do
        begin
          pxw := Scanline[row];
          for col := 0 to fWidth - 1 do
          begin
            pxw^ := iValue;
            inc(pxw);
          end;
        end;
        fFull := (iValue = 65535);
      end;
    ie32f:
      begin
        for row := 0 to fHeight - 1 do
        begin
          pxf := Scanline[row];
          for col := 0 to fWidth - 1 do
          begin
            pxf^ := Value;
            inc(pxf);
          end;
        end;
        fFull := (Value = 1);
      end;
    ie24RGB:
      begin
        vrgb := TColor2TRGB(TColor(iValue));
        if fHeight>0 then
        begin
          getmem(pxb,fRowlen);
          pxrgb:=PRGB(pxb);
          for col := 0 to fWidth - 1 do
          begin
            pxrgb^ := vrgb;
            inc(pxrgb);
          end;
          for row :=0 to fHeight-1 do
            CopyMemory(Scanline[row],pxb,fRowLen);
          freemem(pxb);
        end;
        with vrgb do
          fFull := (r = 255) and (g = 255) and (b = 255);
      end;
    ie32RGB:
      begin
        vrgb := TColor2TRGB(TColor(iValue));
        if fHeight>0 then
        begin
          for row :=1 to fHeight-1 do
          begin
            pxb := Scanline[row];
            for col := 0 to fWidth - 1 do
            begin
              pxb^ := vrgb.b; inc(pxb);
              pxb^ := vrgb.g; inc(pxb);
              pxb^ := vrgb.r; inc(pxb);
              inc(pxb); // bypass
            end;
          end;
        end;
        with vrgb do
          fFull := (r = 255) and (g = 255) and (b = 255);
      end;
    ieCMYK:
      begin
        cmyk := IERGB2CMYK(TColor2TRGB(TColor(iValue)));
        for row := 0 to fHeight - 1 do
        begin
          pxcmyk := Scanline[row];
          for col := 0 to fWidth - 1 do
          begin
            pxcmyk^ := cmyk;
            inc(pxcmyk);
          end;
        end;
        with vrgb do
          fFull := (r = 255) and (g = 255) and (b = 255);
      end;
    ieCIELab:
      begin
        cielab := IERGB2CIELAB(TColor2TRGB(TColor(iValue)));
        for row := 0 to fHeight - 1 do
        begin
          pxcielab := Scanline[row];
          for col := 0 to fWidth - 1 do
          begin
            pxcielab^ := cielab;
            inc(pxcielab);
          end;
        end;
        with vrgb do
          fFull := (r = 255) and (g = 255) and (b = 255);
      end;
    ie48RGB:
      begin
        vrgb := TColor2TRGB(TColor(iValue));
        vrgb48.r:=vrgb.r *257;
        vrgb48.g:=vrgb.g *257;
        vrgb48.b:=vrgb.b *257;
        for row := 0 to fHeight - 1 do
        begin
          pxrgb48 := Scanline[row];
          for col := 0 to fWidth - 1 do
          begin
            pxrgb48^ := vrgb48;
            inc(pxrgb48);
          end;
        end;
        with vrgb do
          fFull := (r = 255) and (g = 255) and (b = 255);
      end;
  end;
  Access := laccess;
end;

{!!
<FS>TIEBitmap.FillRect

<FM>Declaration<FC>
procedure FillRect(x1,y1,x2,y2:integer; Value:double);

<FM>Description<FN>
Fills the rectangle with a specified value.
For ie1g images, Value can be 0 or 1. For ie8g and ie8p, it can be from 0 to 255.
For ie16g images, it can be from 0 to 65535.
For ie24RGB, ie32RGB, ieCMYK and ieCIELab Value is a TColor value.
!!}
procedure TIEBitmap.FillRect(x1, y1, x2, y2: integer; Value: double);
var
  row, col, iValue: integer;
  pxb: pbyte;
  pxw: pword;
  pxrgb: PRGB;
  pxrgb48:PRGB48;
  vrgb: TRGB;
  vrgb48:TRGB48;
  pxf: psingle;
  cmyk:TCMYK;
  pxcmyk:PCMYK;
  cielab:TCIELab;
  pxcielab:PCIELab;
begin
  x1 := imax(x1, 0);
  y1 := imax(y1, 0);
  x2 := imin(x2, fWidth - 1);
  y2 := imin(y2, fHeight - 1);
  iValue := trunc(Value);
  case fPixelFormat of
    ie1g:
      for row := y1 to y2 do
      begin
        pxb := Scanline[row];
        for col := x1 to x2 do
          SetPixelbw_inline(pxb, col, iValue);
      end;
    ie8p, ie8g:
      begin
        for row := y1 to y2 do
        begin
          pxb := Scanline[row];
          inc(pxb, x1);
          fillchar(pxb^, x2 - x1 + 1, iValue);
        end;
      end;
    ie16g:
      begin
        for row := y1 to y2 do
        begin
          pxw := Scanline[row];
          inc(pxw, x1);
          for col := x1 to x2 do
          begin
            pxw^ := iValue;
            inc(pxw);
          end;
        end;
      end;
    ie32f:
      begin
        for row := y1 to y2 do
        begin
          pxf := Scanline[row];
          inc(pxf, x1);
          for col := x1 to x2 do
          begin
            pxf^ := iValue;
            inc(pxf);
          end;
        end;
      end;
    ie24RGB:
      begin
        vrgb := TColor2TRGB(TColor(iValue));
        for row := y1 to y2 do
        begin
          pxrgb := Scanline[row];
          inc(pxrgb, x1);
          for col := x1 to x2 do
          begin
            pxrgb^ := vrgb;
            inc(pxrgb);
          end;
        end;
      end;
    ie32RGB:
      begin
        vrgb := TColor2TRGB(TColor(iValue));
        for row := y1 to y2 do
        begin
          pxb := Scanline[row];
          inc(pxb, x1*4);
          for col := x1 to x2 do
          begin
            pxb^ := vrgb.b; inc(pxb);
            pxb^ := vrgb.g; inc(pxb);
            pxb^ := vrgb.r; inc(pxb);
            inc(pxb); // bypass
          end;
        end;
      end;
    ieCMYK:
      begin
        cmyk := IERGB2CMYK(TColor2TRGB(TColor(iValue)));
        for row := y1 to y2 do
        begin
          pxcmyk := Scanline[row];
          inc(pxcmyk, x1);
          for col := x1 to x2 do
          begin
            pxcmyk^ := cmyk;
            inc(pxcmyk);
          end;
        end;
      end;
    ieCIELab:
      begin
        cielab := IERGB2CIELAB(TColor2TRGB(TColor(iValue)));
        for row := y1 to y2 do
        begin
          pxcielab := Scanline[row];
          inc(pxcielab, x1);
          for col := x1 to x2 do
          begin
            pxcielab^ := cielab;
            inc(pxcielab);
          end;
        end;
      end;
    ie48RGB:
      begin
        vrgb := TColor2TRGB(TColor(iValue));
        vrgb48.r:=vrgb.r *257;
        vrgb48.g:=vrgb.g *257;
        vrgb48.b:=vrgb.b *257;
        for row := y1 to y2 do
        begin
          pxrgb48 := Scanline[row];
          inc(pxrgb48, x1);
          for col := x1 to x2 do
          begin
            pxrgb48^ := vrgb48;
            inc(pxrgb48);
          end;
        end;
      end;
  end;
end;

{!!
<FS>TIEBitmap.Location

<FM>Declaration<FC>
property Location:<A TIELocation>;

<FM>Description<FN>
Location specifies where store the image.
!!}
procedure TIEBitmap.SetLocation(Value: TIELocation);
var
  old: TIEBitmap;
  row, i: integer;
  mi:integer;
begin
  if fLocation <> Value then
  begin
    fFullReallocate := true;
    old := TIEBitmap.Create;
    SwitchTo(old);
    fLocation := Value;
    Allocate(old.fWidth, old.fHeight, old.fPixelFormat);

    if old.Location = fLocation then
    begin
      // failed to change location, maintain old bitmap
      old.SwitchTo(self);
      old.Free;
    end
    else
    begin
      // changed location, copy data
      mi := imin(fRowLen, old.RowLen);
      for row := 0 to fHeight - 1 do
        CopyMemory(Scanline[row], old.Scanline[row], mi);
      for i := 0 to fRGBPaletteLen - 1 do
        fRGBPalette[i] := old.fRGBPalette[i];
      UpdateTBitmapPalette;
      fIsAlpha := old.fIsAlpha;
      fAlphaChannel := old.fAlphaChannel;
      old.fAlphaChannel := nil;
      FreeAndNil(old);
    end;

  end;
end;

procedure TIEBitmap.UpdateTBitmapPalette;
var
  i: integer;
  ppee: array[0..255] of TPALETTEENTRY;
begin
  if fLocation = ieTBitmap then
  begin
    if fRGBPaletteLen > 0 then
    begin
      for i := 0 to fRGBPaletteLen - 1 do
      begin
        ppee[i].peRed := fRGBPalette[i].r;
        ppee[i].peGreen := fRGBPalette[i].g;
        ppee[i].peBlue := fRGBPalette[i].b;
        ppee[i].peFlags := 0;
      end;
      SetPaletteEntries(fBitmap.palette, 0, fRGBPaletteLen, ppee);
    end;
  end;
end;

procedure TIEBitmap.AdjustCanvasOrientation;
var
  xform:TagXForm;
begin
  if fOrigin = ieboTOPLEFT then
  begin
    // set world transform to draw correctly y-axis
    SetGraphicsMode(fBitmap.Canvas.Handle, GM_ADVANCED);
    xform.eM11 := 1.0;
    xform.eM12 := 0;
    xform.eM21 := 0;
    xform.eM22 := -1.0;
    xform.eDx := 0;
    xform.eDy := fHeight-1;
    SetWorldTransform(fBitmap.Canvas.Handle, xform);
  end
  else
  begin
    if GetGraphicsMode(fBitmap.Canvas.Handle) = GM_ADVANCED then
    begin
      // restore world transform to draw correctly y-axis. GM_ADVANCED means that world transform may be changed
      FillChar(xform, sizeof(TagXForm), 0);
      ModifyWorldTransform(fBitmap.Canvas.Handle, xform, MWT_IDENTITY);
    end;
  end;
end;

{!!
<FS>TIEBitmap.Canvas

<FM>Declaration<FC>
property Canvas:TCanvas;

<FM>Description<FN>
Canvas property is available only when <A TIEBitmap.Location> is ieTBitmap.
Anyway accessing Canvas property <A TIEBitmap.Location> is automatically converted to ieTBitmap.
!!}
function TIEBitmap.GetCanvas: TCanvas;
begin
  if (fLocation = ieFile) or (fLocation = ieMemory) then
    SetLocation(ieTBitmap);

  AdjustCanvasOrientation;

  result := fBitmap.Canvas;
end;

(*
procedure PrintPict(DestCanvas:TCanvas; x,y:integer; const Bitmap: TBitmap);
var
   Info: PBitmapInfo;
   InfoSize: DWORD;
   Image: Pointer;
   ImageSize: DWORD;
   Bits: HBITMAP;
   iSrcWidth, iSrcHeight: LongInt;
begin
 try
 DestCanvas.Lock;
   Bits := Bitmap.Handle;
   GetDIBSizes(Bits, InfoSize, ImageSize);
   Info := AllocMem(InfoSize);
   Image := AllocMem(ImageSize);
   GetDIB(Bits, 0, Info^, Image^);
   with Info^.bmiHeader do begin
      iSrcWidth := biWidth;
      iSrcHeight := biHeight;
   end;
   StretchDIBits(DestCanvas.Handle, x,y, iSrcWidth,iSrcHeight,0, 0, iSrcWidth,iSrcHeight, Image,Info^, DIB_RGB_COLORS,SRCCOPY);
   FreeMem(Image, ImageSize);
   FreeMem(Info, InfoSize);
   finally
    DestCanvas.Unlock;
   end;
end;
//*)
//(*
// draw an hdib in a canvas

procedure _DIBDrawTo(DestCanvas: TCanvas; fhdib: THANDLE; orgx, orgy, orgdx, orgdy, destx, desty, destdx, destdy: integer);
var
  bminfo: ^TBITMAPINFO;
begin
  bminfo := GlobalLock(fhdib);
  SetStretchBltMode(destcanvas.handle, COLORONCOLOR);
  if bminfo^.bmiHeader.biBitCount <= 8 then
    // <=256 colors
    StretchDIBits(destcanvas.Handle, destx, desty, destdx, destdy, orgx, orgy, orgdx, orgdy,
      pointer(cardinal(bminfo) + sizeof(TBITMAPINFOHEADER) + (1 shl bminfo^.bmiHeader.biBitCount) * 4),
      bminfo^, DIB_RGB_COLORS, SRCCOPY)
  else
    // >256 colors
    StretchDIBits(destcanvas.Handle, destx, desty, destdx, destdy, orgx, orgy, orgdx, orgdy,
      pointer(cardinal(bminfo) + sizeof(TBITMAPINFOHEADER)),
      bminfo^, DIB_RGB_COLORS, SRCCOPY);
  GlobalUnLock(fhdib);
end;

procedure PrintPict(DestCanvas: TCanvas; x, y: integer; const Bitmap: TIEBitmap; srcx, srcy, srcdx, srcdy: integer);
var
  hdib: THandle;
begin
  IEPrintLogWrite('PrintPict: calling _CopyBitmaptoDIBEx');
  hdib := _CopyBitmaptoDIBEx(Bitmap, srcx, srcy, srcx + srcdx, srcy + srcdy,200,200);
  IEPrintLogWrite('PrintPict: calling _DIBDrawTo');
  _DIBDrawTo(DestCanvas, hdib, 0, 0, srcdx, srcdy, x, y, srcdx, srcdy);
  IEPrintLogWrite('PrintPict: calling GlobalFree');
  GlobalFree(hdib);
end;
//*)

{!!
<FS>TIEBitmap.RenderToCanvas

<FM>Declaration<FC>
procedure RenderToCanvas(DestCanvas:TCanvas; xDst,yDst,dxDst,dyDst:integer; Filter:<A TResampleFilter>; Gamma:double);

<FM>Description<FN>
Draws the rectangle specified by <FC>xDst, yDst, dxDst, dyDst<FN> to <FC>DestCanvas<FN>.
<FC>Filter<FN> specifies the filter if the image needs to be resampled.
<FC>Gamma<FN> is the gamma correction.
!!}
// render the tiebitmap to a canvas, converting a strip at the time to TBitmap then drawing it to the cnvas
// the tbitmap memory size will be minor than fMinFileSize
procedure TIEBitmap.RenderToCanvas(DestCanvas: TCanvas; xDst, yDst, dxDst, dyDst: integer; Filter: TResampleFilter; Gamma: double);
const
  Inv255 = 1.0 / 255;
var
  i: Integer;
  InvGamma: double;
  lut: array[0..255] of byte;
  resbmp: TIEBitmap;
  stripHeight, y, y1, x1: integer;
  px: PRGB;
  hdib: THandle;
begin
  IEPrintLogWrite('TIEBitmap.RenderToCanvas: begin');
  if (fWidth = 0) or (fHeight = 0) or (dxDst=0) or (dyDst=0) then
    exit;
  if (Filter = rfNone) (*and ((Gamma = 1) or (Gamma = 0))*) then
  begin

    IEPrintLogWrite('TIEBitmap.RenderToCanvas: filter=none, gamma=1, gamma=0');
    hdib := _CopyBitmaptoDIBEx(Self, 0, 0, fWidth, fHeight, 200,200);
    if (Gamma<>1) and (Gamma<>0) then
      IEDIBGamma(hdib,Gamma);
    IEPrintLogWrite('TIEBitmap.RenderToCanvas: calling _DIBDrawTo');
    _DIBDrawTo(DestCanvas, hdib, 0, 0, fWidth, fHeight, xDst, yDst, dxDst, dyDst);
    GlobalFree(hdib);

  end
  else
  begin
    // calc stripHeight
    stripHeight := (fMinFileSize div 4) div IEBitmapRowLen(dxDst, 24, fBitAlignment);
    stripHeight := imax(1,imin(dyDst, stripHeight));
    while (stripHeight>1) and (IEBitmapRowLen(dxDst, 24, fBitAlignment)*stripHeight>40*1024*1024) do
      dec(stripHeight);
    IEPrintLogWrite('TIEBitmap.RenderToCanvas: stripHeight='+IntToStr(stripHeight));
    // resample to resbmp
    resbmp := TIEBitmap.Create;
    IEPrintLogWrite('TIEBitmap.RenderToCanvas: allocating '+IntToStr(dxDst)+'x'+IntToStr(dyDst));
    if (Filter = rfNone) or ((PixelFormat<>ie1g) and (PixelFormat<>ie24RGB)) then
    begin
      // 1bit or 24bit unfiltered
      resbmp.Allocate(dxDst, dyDst, fPixelFormat);
      IEPrintLogWrite('TIEBitmap.RenderToCanvas: _IEBmpStretchEx');
      _IEBmpStretchEx(self, resbmp, nil, nil);
    end
    else if (fPixelFormat = ie1g) then
    begin
      // 1bit filtered
      if (Filter=rfProjectBW) or (Filter=rfProjectWB) then
        resbmp.Allocate(dxDst, dyDst, ie1g)
      else
        resbmp.Allocate(dxDst, dyDst, ie24RGB);
      IEPrintLogWrite('TIEBitmap.RenderToCanvas: _Resample1BitEx');
      _Resample1BitEx(self, resbmp, Filter);
    end
    else
    begin
      // 24bit filtered
      resbmp.Allocate(dxDst, dyDst, ie24RGB);
      IEPrintLogWrite('TIEBitmap.RenderToCanvas: _ResampleEx');
      _ResampleEx(self, resbmp, Filter, nil, nil);
    end;
    // copy strips
    DestCanvas.CopyMode := cmSrcCopy;
    // apply gamma
    if (resbmp.PixelFormat = ie24RGB) and (Gamma <> 1) and (Gamma > 0) then
    begin
      // calc gamma LUT
      IEPrintLogWrite('TIEBitmap.RenderToCanvas: gamma');
      InvGamma := 1.0 / Gamma;
      for i := 0 to 255 do
        lut[i] := blimit(round(255 * iepower(i * Inv255, InvGamma)));
      for y1 := 0 to resbmp.Height - 1 do
      begin
        px := resbmp.Scanline[y1];
        for x1 := 0 to resbmp.Width - 1 do
        begin
          with px^ do
          begin
            r := lut[r];
            g := lut[g];
            b := lut[b];
          end;
          inc(px);
        end;
      end;
    end;
    //
    y := 0;
    while y < dyDst do
    begin
      // draw to canvas
      IEPrintLogWrite('TIEBitmap.RenderToCanvas: PrintPict y='+IntToStr(y));
      PrintPict(DestCanvas, xDst, yDst, resbmp, 0, y, resbmp.Width, stripHeight);
      // next strip
      inc(yDst, stripHeight);
      inc(y, stripHeight);
      stripHeight := imin((dyDst - y), stripHeight);
    end;
    //
    FreeAndNil(resbmp);
  end;
  IEPrintLogWrite('TIEBitmap.RenderToCanvas: end');
end;

{!!
<FS>TIEBitmap.DrawToCanvas

<FM>Declaration<FC>
procedure DrawToCanvas(DestCanvas:TCanvas; xDst,yDst:integer);

<FM>Description<FN>
Draws the whole bitmap to specified <FC>DestCanvas<FN> canvas, at <FC>xDst, yDst<FN> coordinates.
!!}
procedure TIEBitmap.DrawToCanvas(DestCanvas:TCanvas; xDst,yDst:integer);
begin
  RenderToCanvas(DestCanvas,xDst,YDst,fwidth,fheight,rfNone,0);
end;

{!!
<FS>TIEBitmap.RenderToTBitmapEx

<FM>Declaration<FC>
procedure RenderToTBitmapEx(Dest:TBitmap; xDst,yDst,dxDst,dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: <A TResampleFilter>; RenderOperation: <A TIERenderOperation>);

<FM>Description<FN>
Draws the rectangle <FC>xSrc,ySrc,dxSrc,dySrc<FN> inside the destination rectangle <FC>xDst,yDst,dxDst,dyDst<FN> of <FC>Dest<FN> TBitmap object.
<FC>Dest.<A TIEBitmap.PixelFormat><FN> must be pf24bit.
<FC>Transparency<FN> specifies the transparency value (0 to 255).
<FC>Filter<FN> the resampling filter.
<FC>RenderOperation<FN> the rendering operation.
!!}
procedure TIEBitmap.RenderToTBitmapEx(Dest:TBitmap; xDst,yDst,dxDst,dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: TResampleFilter; RenderOperation: TIERenderOperation);
var
  ptr:ppointerarray;
  XLUT,YLUT:pinteger;
begin
  XLUT:=nil;
  YLUT:=nil;
  ptr:=nil;
  RenderToTBitmap(Dest,ptr,XLUT,YLUT,nil,xDst,yDst,dxDst,dyDst, xSrc, ySrc, dxSrc, dySrc, true, false, Transparency,Filter,true,RenderOperation);
end;

{!!
<FS>TIEBitmap.RenderToTIEBitmapEx

<FM>Declaration<FC>
procedure RenderToTIEBitmapEx(Dest:<A TIEBitmap>; xDst,yDst,dxDst,dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: <A TResampleFilter>; RenderOperation: <A TIERenderOperation>);

<FM>Description<FN>
Draws the rectangle <FC>xSrc,ySrc,dxSrc,dySrc<FN> inside the destination rectangle <FC>xDst,yDst,dxDst,dyDst<FN> of <FC>Dest<FN> TIEBitmap object.
<FC>Dest.<A TIEBitmap.PixelFormat><FN> must be ie24RGB.
<FC>Transparency<FN> specifies the transparency value (0 to 255).
<FC>Filter<FN> the resampling filter.
<FC>RenderOperation<FN> the rendering operation.
!!}
procedure TIEBitmap.RenderToTIEBitmapEx(Dest:TIEBitmap; xDst,yDst,dxDst,dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: TResampleFilter; RenderOperation: TIERenderOperation);
var
  ptr:ppointerarray;
  XLUT,YLUT:pinteger;
begin
  XLUT:=nil;
  YLUT:=nil;
  ptr:=nil;
  RenderToTIEBitmap(Dest,ptr,XLUT,YLUT,nil,xDst,yDst,dxDst,dyDst, xSrc, ySrc, dxSrc, dySrc, true, false, Transparency,Filter,true,RenderOperation);
end;

{!!
<FS>TIEBitmap.RenderToCanvasWithAlpha

<FM>Declaration<FC>
procedure RenderToCanvasWithAlpha(Dest:TCanvas; xDst,yDst,dxDst,dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: <A TResampleFilter>; RenderOperation: <A TIERenderOperation>);

<FM>Description<FN>
Draws the rectangle <FC>xSrc, ySrc, dxSrc, dySrc<FN> inside the destination rectangle <FC>xDst, yDst, dxDst, dyDst<FN> of <FC>Dest<FN> TCanvas object.
<FC>Transparency<FN> specifies the transparency value (0 to 255).
<FC>Filter<FN> the resampling filter.
<FC>RenderOperation<FN> the rendering operation.

This functions reads the destination canvas pixels and merges them with image using alpha channel mask.
!!}
procedure TIEBitmap.RenderToCanvasWithAlpha(Dest:TCanvas; xDst,yDst,dxDst,dyDst:integer; xSrc, ySrc, dxSrc, dySrc: integer; Transparency:integer; Filter: TResampleFilter; RenderOperation: TIERenderOperation);
var
  tempdib:TIEDIBBitmap;
  tempbmp:TIEBitmap;
begin
  tempdib:=TIEDIBBitmap.Create;
  tempdib.AllocateBits(dxDst,dyDst,24);
  BitBlt(tempdib.HDC,0,0,dxDst,dyDst,Dest.Handle,xDst,yDst,SRCCOPY);
  tempbmp:=TIEBitmap.Create;
  tempbmp.EncapsulateMemory(tempdib.Bits,dxDst,dyDst,ie24RGB,false);
  RenderToTIEBitmapEx(tempbmp,0,0,dxDst,dyDst,xSrc,ySrc,dxSrc,dySrc,Transparency,Filter,RenderOperation);
  BitBlt(Dest.Handle,xDst,yDst,dxDst,dyDst,tempdib.HDC,0,0,SRCCOPY);
  tempbmp.free;
  tempdib.free;
end;


{!!
<FS>TIEBitmap.RenderToTBitmap

<FM>Declaration<FC>
procedure RenderToTBitmap(ABitmap: TBitmap; var ABitmapScanline: <A ppointerarray>; var XLUT, YLUT: pinteger; UpdRect: PRect; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; EnableAlpha: boolean; SolidBackground: boolean; Transparency: integer; Filter: <A TResampleFilter>; FreeTables: boolean; RenderOperation: <A TIERenderOperation>);

<FM>Description<FN>
Used internally to render a TIEBitmap in <A TImageEnView> object.
ABitmap must be pf24bit
!!}
procedure TIEBitmap.RenderToTBitmap(ABitmap: TBitmap; var ABitmapScanline: ppointerarray; var XLUT, YLUT: pinteger; UpdRect: PRect; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; EnableAlpha: boolean; SolidBackground: boolean; Transparency: integer; Filter: TResampleFilter; FreeTables: boolean; RenderOperation: TIERenderOperation);
var
  bmp:TIEBitmap;
begin
  bmp:=TIEBitmap.Create;
  bmp.EncapsulateTBitmap(ABitmap,false);
  RenderToTIEBitmap(bmp, ABitmapScanline,XLUT, YLUT,UpdRect,xDst, yDst, dxDst, dyDst,xSrc, ySrc, dxSrc, dySrc,EnableAlpha,SolidBackground,Transparency,Filter,FreeTables,RenderOperation);
  FreeAndNil(bmp);
end;

{!!
<FS>TIEBitmap.RenderToTIEBitmap

<FM>Declaration<FC>
procedure RenderToTIEBitmap(ABitmap: <A TIEBitmap>; var ABitmapScanline: <A ppointerarray>; var XLUT, YLUT: pinteger; UpdRect: PRect; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; EnableAlpha: boolean; SolidBackground: boolean; Transparency: integer; Filter: <A TResampleFilter>; FreeTables: boolean; RenderOperation: <A TIERenderOperation>);

<FM>Description<FN>
Used internally to render a TIEBitmap in <A TImageEnView> object.
ABitmap must be 24 bit.
ABitmapScanline can be nil
XLUT,YLUT: x and y screen to bitmap conversion table, can be NIL
!!}
procedure TIEBitmap.RenderToTIEBitmap(ABitmap: TIEBitmap; var ABitmapScanline: ppointerarray; var XLUT, YLUT: pinteger; UpdRect: PRect; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; EnableAlpha: boolean; SolidBackground: boolean; Transparency: integer; Filter: TResampleFilter; FreeTables: boolean; RenderOperation: TIERenderOperation);
var
  i, y, x, ww, hh: integer;
  DBitmapScanline: ppointerarray;
  x1, y1, x2, y2: integer;
  rx, ry: integer;
  cx1, cy1, cx2, cy2: integer;
  SimAlphaRow: pbyte; // the simulated alpha channel, needed when TIELayer.GlobalAlpha is not 255 (255=opaque)
  UseAlpha: boolean;
  sxarr, psx, syarr, psy: pinteger;
  ietmp1, ietmp2: TIEBitmap;
{$IFDEF IEDEBUG}
  deb1: dword;
{$ENDIF}
  dummy1, dummy2: pinteger;
  zx, zy: double;
  laccess: TIEDataAccess;
begin
  try
    laccess := Access;
    Access := [iedRead];
    if (dxDst = 0) or (dyDst = 0) or (dxSrc = 0) or (dySrc = 0) then
      exit;
    if yDst > ABitmap.Height - 1 then
      exit;
    if xDst > ABitmap.Width - 1 then
      exit;
    zy := dySrc / dyDst;
    zx := dxSrc / dxDst;
    if yDst < 0 then
    begin
      y := -yDst;
      yDst := 0;
      dec(dyDst, y);
      inc(ySrc, round(y * zy));   // 3.0.2 (24/09/2008, 23:21)
      dec(dySrc, round(y * zy));  // 3.0.2 (24/09/2008, 23:21)
    end;
    if xDst < 0 then
    begin
      x := -xDst;
      xDst := 0;
      dec(dxDst, x);
      inc(xSrc, round(x * zx));   // 3.0.2 (24/09/2008, 23:21)
      dec(dxSrc, round(x * zx));  // 3.0.2 (24/09/2008, 23:21)
    end;
    if yDst + dyDst > ABitmap.Height then
    begin
      y := yDst + dyDst - ABitmap.Height;
      dyDst := ABitmap.Height - yDst;
      dec(dySrc, trunc(y * zy));
    end;
    if xDst + dxDst > ABitmap.Width then
    begin
      x := xDst + dxDst - ABitmap.Width;
      dxDst := ABitmap.Width - xDst;
      dec(dxSrc, trunc(x * zx));
    end;
    xDst := imax(imin(xDst, ABitmap.Width - 1), 0);
    yDst := imax(imin(yDst, ABitmap.Height - 1), 0);
    dxDst := imax(imin(dxDst, ABitmap.Width), 0);
    dyDst := imax(imin(dyDst, ABitmap.Height), 0);
    xSrc := imax(imin(xSrc, Width - 1), 0);
    ySrc := imax(imin(ySrc, Height - 1), 0);
    dxSrc := imax(imin(dxSrc, Width), 0);
    dySrc := imax(imin(dySrc, Height), 0);
    //
    if (dxDst=0) or (dyDst=0) or (dxSrc=0) or (dySrc=0) then  // 2.2.4
      exit;
    //
    if (Filter <> rfNone) and ((dxSrc <> dxDst) or (dySrc <> dyDst)) and ((PixelFormat = ie1g) or (PixelFormat = ie24RGB)) then
    begin
      dummy1 := nil;
      dummy2 := nil;
      // need to resample using a filter
      if (dxDst <= dxSrc) and (PixelFormat = ie1g) and ((not EnableAlpha) or (not HasAlphaChannel)) and (Filter<>rfProjectBW) and (Filter<>rfProjectWB) then
      begin
        // subsample 1 bit bitmap
        if (dxDst > 0) and (dyDst > 0) then
        begin
          ietmp1 := TIEBitmap.Create;
          ietmp1.Allocate(dxDst, dyDst, ie24RGB);
          _SubResample1bitFilteredEx(self, xSrc, ySrc, xSrc + dxSrc - 1, ySrc + dySrc - 1, ietmp1);
          ietmp1.RenderToTIEBitmap(ABitmap, ABitmapScanline, dummy1, dummy2, UpdRect, xDst, yDst, dxDst, dyDst, 0, 0, dxDst, dyDst, EnableAlpha, SolidBackground, Transparency, rfNone, true, RenderOperation);
          FreeAndNil(ietmp1);
        end;
      end
      else if (PixelFormat = ie24RGB) or (PixelFormat = ie1g) and ((dxSrc > 0) and (dySrc > 0)) then
      begin
        // sub/over resample 1/24 bits bitmap
        ietmp1 := TIEBitmap.Create;
        ietmp1.Allocate(dxSrc, dySrc, PixelFormat);
        CopyRectTo(ietmp1, xSrc, ySrc, 0, 0, dxSrc, dySrc);
        if EnableAlpha and HasAlphaChannel then
        begin
          AlphaChannel.CopyRectTo(ietmp1.AlphaChannel, xSrc, ySrc, 0, 0, dxSrc, dySrc);
          ietmp1.AlphaChannel.Full := AlphaChannel.Full;
        end;
        ietmp2 := TIEBitmap.Create;
        if PixelFormat = ie1g then
        begin
          if (Filter=rfProjectBW) or (Filter=rfProjectWB) then
            ietmp2.Allocate(dxDst, dyDst, ie1g)
          else
            ietmp2.Allocate(dxDst, dyDst, ie24RGB);
          _Resample1bitEx(ietmp1, ietmp2, Filter);
        end
        else
        begin
          ietmp2.Allocate(dxDst, dyDst, ie24RGB);
          _ResampleEx(ietmp1, ietmp2, Filter, nil, nil);
        end;
        if EnableAlpha and HasAlphaChannel then
        begin
          _Resampleie8g(ietmp1.AlphaChannel, ietmp2.AlphaChannel, Filter);
          ietmp2.AlphaChannel.Full := ietmp1.AlphaChannel.Full;
        end;
        for i := 0 to IEMAXCHANNELS - 1 do
          ietmp2.fChannelOffset[i] := fChannelOffset[i];
        ietmp2.fEnableChannelOffset := fEnableChannelOffset;
        ietmp2.fContrast := fContrast;
        ietmp2.RenderToTIEBitmap(ABitmap, ABitmapScanline, dummy1, dummy2, UpdRect, xDst, yDst, dxDst, dyDst, 0, 0, dxDst, dyDst, EnableAlpha, SolidBackground, Transparency, rfNone, true, RenderOperation);
        FreeAndNil(ietmp2);
        FreeAndNil(ietmp1);
      end;
      exit; // EXIT POINT
    end;
{$IFDEF IEDEBUG}
    deb1 := gettickcount;
{$ENDIF}
    if (dxDst = 0) or (dyDst = 0) or (dxSrc = 0) or (dySrc = 0) then
      exit;
    ww := ABitmap.Width;
    hh := ABitmap.Height;
    if ABitmapScanline = nil then
    begin
      getmem(DBitmapScanline, hh * sizeof(pointer));
      for y := 0 to hh - 1 do
        DBitmapScanline[y] := ABitmap.Scanline[y];
    end
    else
      DBitmapScanline := ABitmapScanline;
    //
    if (dxDst <> 0) and (dyDst <> 0) then
    begin
      SimAlphaRow := nil;
      if (Transparency < 255) then
      begin
        if SimAlphaRow = nil then
          getmem(SimAlphaRow, Width);
        fillchar(SimAlphaRow^, Width, Transparency);
      end;
      sxarr := nil;
      syarr := nil;
      try
        ry := trunc((dySrc / dyDst) * 16384); // 2^14
        rx := trunc((dxSrc / dxDst) * 16384);
        y2 := imin(yDst + dyDst - 1, hh - 1);
        x2 := imin(xDst + dxDst - 1, ww - 1);
        // set update rect
        if UpdRect <> nil then
        begin
          cx1 := UpdRect^.Left;
          cy1 := UpdRect^.Top;
          cx2 := UpdRect^.Right;
          cy2 := UpdRect^.Bottom;
        end
        else
        begin
          cx1 := -2147483646;
          cy1 := -2147483646;
          cx2 := 2147483646;
          cy2 := 2147483646;
        end;
        cx1 := imax(cx1, xDst);
        cx2 := imin(cx2, x2);
        cy1 := imax(cy1, yDst);
        cy2 := imin(cy2, y2);
        //
        cx1 := imax(cx1, 0);
        cx1 := imin(cx1, ABitmap.Width - 1);
        cx2 := imax(cx2, 0);
        cx2 := imin(cx2, ABitmap.Width - 1);
        cy1 := imax(cy1, 0);
        cy1 := imin(cy1, ABitmap.Height - 1);
        cy2 := imax(cy2, 0);
        cy2 := imin(cy2, ABitmap.Height - 1);

        while (assigned(YLUT) and (pintegerarray(YLUT)[cy2-cy1]>=fHeight)) do
        begin
          dec(cy2);
        end;
        while (assigned(XLUT) and (pintegerarray(XLUT)[cx2-cx1]>=fWidth)) do
        begin
          dec(cx2);
        end;

        UseAlpha := EnableAlpha and HasAlphaChannel and (not AlphaChannel.Full);
        if (ry <> 16384) or (rx <> 16384) or (PixelFormat = ie1g) or (PixelFormat = ie16g) or (PixelFormat = ie32f) or (PixelFormat = ieCMYK) or (PixelFormat=ie48RGB) or (PixelFormat=ieCIELab) or
        (PixelFormat = ie8g) or (PixelFormat = ie8p) or (PixelFormat = ie32RGB) or (Transparency < 255) or UseAlpha or fEnableChannelOffset or (fContrast <> 0) or (RenderOperation <> ielNormal) or ((fBlackValue<>0) or (fWhiteValue<>0)) then
        begin
          if XLUT <> nil then
          begin
            // set provided horizontal LUT
            sxarr := XLUT;
            inc(sxarr, cx1 - xDst);
          end
          else
          begin
            // build horizontal LUT
            getmem(sxarr, (cx2 - cx1 + 1) * sizeof(integer));
            psx := sxarr;

            for x := cx1 to cx2 do
            begin
              psx^:=ilimit(trunc( zx*(x-xDst) + xSrc ), 0,fWidth-1);  // 3.0.0
              inc(psx);
            end;

          end;
          if YLUT <> nil then
          begin
            // set provided vertical LUT
            syarr := YLUT;
            inc(syarr, cy1 - yDst);
          end
          else
          begin
            // build vertical LUT
            getmem(syarr, (cy2 - cy1 + 1) * sizeof(integer));
            psy := syarr;

            for y := cy1 to cy2 do
            begin
              psy^:=ilimit(trunc( zy*(y-yDst) + ySrc ), 0,fHeight-1); // 3.0.0
              inc(psy);
            end;

          end;
        end;

{$IFDEF IEDEBUG}

        OutputDebugString(PAnsiChar('TIEBitmap.RenderToTIEBitmap'));
        OutputDebugString(PAnsiChar('  ABitmap.Width='+IEIntToStr(ABitmap.Width)+'  ABitmap.Height='+IEIntToStr(ABitmap.Height) ));
        OutputDebugString(PAnsiChar('  IEBitmap.Width='+IEIntToStr(Width)+'  IEBitmap.Height='+IEIntToStr(Height) ));
        OutputDebugString(PAnsiChar('  xSrc='+IEIntToStr(xSrc)+'  ySrc='+IEIntToStr(ySrc) ));
        OutputDebugString(PAnsiChar('  dxSrc='+IEIntToStr(dxSrc)+'  dySrc='+IEIntToStr(dySrc) ));
        OutputDebugString(PAnsiChar('  xDst='+IEIntToStr(xDst)+'  yDst='+IEIntToStr(yDst) ));
        OutputDebugString(PAnsiChar('  dxDst='+IEIntToStr(dxDst)+'  dyDst='+IEIntToStr(dyDst) ));
        OutputDebugString(PAnsiChar('  cx1='+IEIntToStr(cx1)+'  cy1='+IEIntToStr(cy1)+'  cx2='+IEIntToStr(cx2)+'  cy2='+IEIntToStr(cy2) ));
        OutputDebugString(PAnsiChar('  rx='+IEIntToStr(rx)+'  ry='+IEIntToStr(ry) ));

{$ENDIF}
        if (Transparency < 255) or UseAlpha then
        begin
          // Draw with alpha channel
          case PixelFormat of
            ie1g:
              // 1 bit per pixel
              Render_ie1g_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie8g:
              // 8 bit gray scale
              Render_ie8g_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie8p:
              // 8 bit color mapped
              Render_ie8p_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie16g:
              // 16 bit gray scale
              Render_ie16g_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie24RGB:
              // 24 bits per pixel
              Render_ie24RGB_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground, RenderOperation);
            ie32RGB:
              // 32 bits per pixel
              Render_ie32RGB_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground, RenderOperation);
            ie32f:
              // 32 bit float point gray scale
              Render_ie32f_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ieCMYK:
              // CMYK
              Render_ieCMYK_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ieCIELab:
              // CIELab
              Render_ieCIELab_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie48RGB:
              // 48 bit per pixel
              Render_ie48RGB_alpha(dbitmapscanline, ABitmap, Transparency, UseAlpha, SimAlphaRow, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground, RenderOperation);
          end;
        end
        else
        begin
          // Draw without alpha channel
          case PixelFormat of
            ie1g:
              // 1 bit per pixel
              Render_ie1g(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie8g:
              // 8 bit gray scale
              Render_ie8g(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie8p:
              // 8 bit color mapped
              Render_ie8p(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie16g:
              // 16 bit gray scale
              Render_ie16g(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie24RGB:
              // 24 bits per pixel
              Render_ie24RGB(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground, RenderOperation);
            ie32RGB:
              // 32 bits per pixel
              Render_ie32RGB(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground, RenderOperation);
            ie32f:
              // 32 bit float point gray scale
              Render_ie32f(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ieCMYK:
              // CMYK
              Render_ieCMYK(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ieCIELab:
              // CIELab
              Render_ieCIELab(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground);
            ie48RGB:
              // 48 bits per pixel
              Render_ie48RGB(dbitmapscanline, ABitmap, sxarr, syarr, xSrc, ySrc, xDst, yDst, cx1, cy1, cx2, cy2, rx, ry, SolidBackground, RenderOperation);
          end;
        end;
      except
{$IFDEF IEDEBUG}
        OutputDebugString('TIEBitmap.RenderToTBitmap: EXCEPTION!');
{$ENDIF}
      end;
      if SimAlphaRow <> nil then
        FreeMem(SimAlphaRow);
      if (sxarr <> nil) and (XLUT = nil) then
      begin
        if FreeTables then
          freemem(sxarr)
        else
          XLUT := sxarr;
      end;
      if (syarr <> nil) and (YLUT = nil) then
      begin
        if FreeTables then
          freemem(syarr)
        else
          YLUT := syarr;
      end;
    end;
    //
    if ABitmapScanline = nil then
    begin
      if FreeTables then
        freemem(DBitmapScanline)
      else
        ABitmapScanline := DBitmapScanline;
    end;
{$IFDEF IEDEBUG}
    deb1 := gettickcount - deb1;
    OutputDebugString(PAnsiChar('TIEBitmap.RenderToTBitmap: ' + IEIntToStr(deb1) + 'ms'));
{$ENDIF}
  finally
    Access := laccess;
  end;
end;

procedure TIEBitmap.Render_ie8p(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y: integer;
  px2: prgb;
  pwb: pbytearray;
  sr, sg, sb: integer;
begin
  if fRGBPalette=nil then exit;
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwb := Scanline[psy^];
    psx := sxarr;
    for x := cx1 to cx2 do
    begin
      with fRGBPalette[pwb[psx^]] do
      begin
        sr := r;
        sg := g;
        sb := b;
      end;
      with px2^ do
      begin
        r := sr;
        g := sg;
        b := sb;
      end;
      inc(px2);
      inc(psx);
    end;
    inc(psy);
  end
end;

procedure TIEBitmap.Render_ie8p_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y, rl, l: integer;
  px2: prgb;
  px1: PRGBROW;
  px3: pbytearray;
  rl2, rl4: integer;
  pwb: pbytearray;
  sr, sg, sb: integer;
begin
  if fRGBPalette=nil then exit;
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwb := Scanline[psy^];
    if UseAlpha then
      px3 := AlphaChannel.ScanLine[psy^]
    else
      px3 := PByteArray(SimAlphaRow);
    psx := sxarr;
    for x := cx1 to cx2 do
    begin
      alpha := imin(Transparency, px3[psx^]) shl 10;
      with fRGBPalette[pwb[psx^]] do
      begin
        sr := r;
        sg := g;
        sb := b;
      end;
      with px2^ do
      begin
        r := (alpha * (sr - r) shr 18 + r);
        g := (alpha * (sg - g) shr 18 + g);
        b := (alpha * (sb - b) shr 18 + b);
      end;
      inc(px2);
      inc(psx);
    end;
    inc(psy);
  end
end;

procedure TIEBitmap.Render_ie8g(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y, v: integer;
  pwb: pbytearray;
  black, white: integer;
  range: double;
  px2: prgb;
begin
  black := trunc(fBlackValue);
  white := trunc(fWhiteValue);
  range := fWhiteValue - fBlackValue;
  //
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwb := Scanline[psy^];
    psx := sxarr;
    if range = 0 then
    begin
      for x := cx1 to cx2 do
      begin
        with px2^ do
        begin
          r := pwb[psx^];
          g := r;
          b := r;
        end;
        inc(px2);
        inc(psx);
      end;
    end
    else
    begin
      // applies fBlackValue and fWhiteValue
      for x := cx1 to cx2 do
      begin
        v := pwb[psx^];
        if v <= black then
          v := black;
        if v >= white then
          v := white;
        v := trunc(((v - black) / range) * 255);
        with px2^ do
        begin
          r := v;
          g := v;
          b := v;
        end;
        inc(px2);
        inc(psx);
      end;
    end;
    inc(psy);
  end
end;

procedure TIEBitmap.Render_ie8g_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y, rl, l: integer;
  px2: prgb;
  px1: PRGBROW;
  px3: pbytearray;
  rl2, rl4: integer;
  pwb: pbytearray;
  black, white: integer;
  range: double;
begin
  black := trunc(fBlackValue);
  white := trunc(fWhiteValue);
  range := fWhiteValue - fBlackValue;
  //
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwb := Scanline[psy^];
    if UseAlpha then
      px3 := AlphaChannel.ScanLine[psy^]
    else
      px3 := PByteArray(SimAlphaRow);
    psx := sxarr;
    if range = 0 then
    begin
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        l := pwb[psx^];
        with px2^ do
        begin
          r := (alpha * (l - r) shr 18 + r);
          g := (alpha * (l - g) shr 18 + g);
          b := (alpha * (l - b) shr 18 + b);
        end;
        inc(px2);
        inc(psx);
      end;
    end
    else
    begin
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        l := pwb[psx^];
        if l <= black then
          l := black;
        if l >= white then
          l := white;
        l := trunc(((l - black) / range) * 255);
        with px2^ do
        begin
          r := (alpha * (l - r) shr 18 + r);
          g := (alpha * (l - g) shr 18 + g);
          b := (alpha * (l - b) shr 18 + b);
        end;
        inc(px2);
        inc(psx);
      end;
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ie16g(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y, v: integer;
  px2: prgb;
  pwa: pwordarray;
  black, white: integer;
  range: double;
begin
  black := trunc(fBlackValue);
  white := trunc(fWhiteValue);
  range := fWhiteValue - fBlackValue;
  //
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    psx := sxarr;
    if range = 0 then
    begin
      for x := cx1 to cx2 do
      begin
        with px2^ do
        begin
          r := pwa[psx^] shr 8;
          g := r;
          b := r;
        end;
        inc(px2);
        inc(psx);
      end;
    end
    else
    begin
      // applies fBlackValue and fWhiteValue
      for x := cx1 to cx2 do
      begin
        v := pwa[psx^];
        if v <= black then
          v := black;
        if v >= white then
          v := white;
        v := trunc(((v - black) / range) * 255);
        with px2^ do
        begin
          r := v;
          g := v;
          b := v;
        end;
        inc(px2);
        inc(psx);
      end;
    end;
    inc(psy);
  end
end;

procedure TIEBitmap.Render_ie16g_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y, l, rl: integer;
  px2: prgb;
  px1: PRGBROW;
  px3: pbytearray;
  rl2, rl4: integer;
  pwa: pwordarray;
  pwb: pbytearray;
  black, white: integer;
  range: double;
begin
  black := trunc(fBlackValue);
  white := trunc(fWhiteValue);
  range := fWhiteValue - fBlackValue;
  //
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    if UseAlpha then
      px3 := AlphaChannel.ScanLine[psy^]
    else
      px3 := PByteArray(SimAlphaRow);
    psx := sxarr;
    if range = 0 then
    begin
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        l := pwa[psx^] shr 8;
        with px2^ do
        begin
          r := (alpha * (l - r) shr 18 + r);
          g := (alpha * (l - g) shr 18 + g);
          b := (alpha * (l - b) shr 18 + b);
        end;
        inc(px2);
        inc(psx);
      end;
    end
    else
    begin
      // applies fBlackValue and fWhiteValue
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        l := pwa[psx^];
        if l <= black then
          l := black;
        if l >= white then
          l := white;
        l := trunc(((l - black) / range) * 255);
        with px2^ do
        begin
          r := (alpha * (l - r) shr 18 + r);
          g := (alpha * (l - g) shr 18 + g);
          b := (alpha * (l - b) shr 18 + b);
        end;
        inc(px2);
        inc(psx);
      end;
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ie32f(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y, l: integer;
  px2: prgb;
  pwa: psinglearray;
  range: double;
  v: single;
begin
  range := fWhiteValue - fBlackValue;
  //
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    psx := sxarr;
    if range = 0 then
    begin
      for x := cx1 to cx2 do
      begin
        with px2^ do
        begin
          r := trunc(pwa[psx^] * 255);
          g := r;
          b := r;
        end;
        inc(px2);
        inc(psx);
      end;
    end
    else
    begin
      // applies fBlackValue and fWhiteValue
      for x := cx1 to cx2 do
      begin
        v := pwa[psx^];
        if v <= fBlackValue then
          v := fBlackValue;
        if v >= fWhiteValue then
          v := fWhiteValue;
        l := trunc(((v - fBlackValue) / range) * 255);
        with px2^ do
        begin
          r := l;
          g := l;
          b := l;
        end;
        inc(px2);
        inc(psx);
      end;
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ie32f_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y, l, rl: integer;
  px2: prgb;
  px1: PRGBROW;
  px3: pbytearray;
  rl2, rl4: integer;
  pwa: psinglearray;
  pwb: pbytearray;
  range: double;
  v: single;
begin
  range := fWhiteValue - fBlackValue;
  //
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    if UseAlpha then
      px3 := AlphaChannel.ScanLine[psy^]
    else
      px3 := PByteArray(SimAlphaRow);
    psx := sxarr;
    if range = 0 then
    begin
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        l := trunc(pwa[psx^] * 255);
        with px2^ do
        begin
          r := (alpha * (l - r) shr 18 + r);
          g := (alpha * (l - g) shr 18 + g);
          b := (alpha * (l - b) shr 18 + b);
        end;
        inc(px2);
        inc(psx);
      end;
    end
    else
    begin
      // applies fBlackValue and fWhiteValue
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        v := pwa[psx^];
        if v <= fBlackValue then
          v := fBlackValue;
        if v >= fWhiteValue then
          v := fWhiteValue;
        l := trunc(((v - fBlackValue) / range) * 255);
        with px2^ do
        begin
          r := (alpha * (l - r) shr 18 + r);
          g := (alpha * (l - g) shr 18 + g);
          b := (alpha * (l - b) shr 18 + b);
        end;
        inc(px2);
        inc(psx);
      end;
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ieCMYK(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y: integer;
  px2: prgb;
  pwa: PCMYKROW;
  rgb:TRGB;
begin
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    psx := sxarr;
    for x := cx1 to cx2 do
    begin
      rgb:=IECMYK2RGB( pwa[psx^] );
      with px2^ do
      begin
        r := rgb.r;
        g := rgb.g;
        b := rgb.b;
      end;
      inc(px2);
      inc(psx);
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ieCMYK_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y: integer;
  px2: prgb;
  px3: pbytearray;
  pwa: PCMYKROW;
  rgb:TRGB;
begin
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    if UseAlpha then
      px3 := AlphaChannel.ScanLine[psy^]
    else
      px3 := PByteArray(SimAlphaRow);
    psx := sxarr;
    for x := cx1 to cx2 do
    begin
      alpha := imin(Transparency, px3[psx^]) shl 10;
      rgb:=IECMYK2RGB( pwa[psx^] );

      with px2^ do
      begin
        r := (alpha * (rgb.r - r) shr 18 + r);
        g := (alpha * (rgb.g - g) shr 18 + g);
        b := (alpha * (rgb.b - b) shr 18 + b);
      end;

      inc(px2);
      inc(psx);
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ieCIELab(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y: integer;
  px2: prgb;
  pwa: PCIELABROW;
  rgb:TRGB;
begin
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    psx := sxarr;
    for x := cx1 to cx2 do
    begin
      rgb:=IECIELAB2RGB( pwa[psx^] );
      with px2^ do
      begin
        r := rgb.r;
        g := rgb.g;
        b := rgb.b;
      end;
      inc(px2);
      inc(psx);
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ieCIELab_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y: integer;
  px2: prgb;
  px3: pbytearray;
  pwa: PCIELABROW;
  rgb:TRGB;
begin
  sxarr := XLUT;
  syarr := YLUT;
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    px2 := dBitmapScanline[y];
    inc(px2, cx1);
    pwa := Scanline[psy^];
    if UseAlpha then
      px3 := AlphaChannel.ScanLine[psy^]
    else
      px3 := PByteArray(SimAlphaRow);
    psx := sxarr;
    for x := cx1 to cx2 do
    begin
      alpha := imin(Transparency, px3[psx^]) shl 10;
      rgb:=IECIELAB2RGB( pwa[psx^] );

      with px2^ do
      begin
        r := (alpha * (rgb.r - r) shr 18 + r);
        g := (alpha * (rgb.g - g) shr 18 + g);
        b := (alpha * (rgb.b - b) shr 18 + b);
      end;

      inc(px2);
      inc(psx);
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ie1g(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y, l, rl: integer;
  //ww:integer;
  px2: prgb;
  px1: PRGBROW;
begin
  //ww := ABitmap.Width;
  sxarr := XLUT;
  syarr := YLUT;
  l := -1;
  rl := abitmap.RowLen; //_PixelFormat2RowLen(ww, abitmap.pixelformat);
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    if (l = psy^) and SolidBackground then
    begin
      copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
    end
    else
    begin
      px2 := dBitmapScanline[y];
      inc(px2, cx1);
      px1 := Scanline[psy^];
      psx := sxarr;
      for x := cx1 to cx2 do
      begin
        if (pbytearray(px1)^[psx^ shr 3] and iebitmask1[psx^ and $7]) = 0 then
        begin
          pword(px2)^ := 0; // set b,g
          inc(pword(px2));
          pbyte(px2)^ := 0; // set r
          inc(pbyte(px2));
        end
        else
        begin
          pword(px2)^ := $FFFF; // set b,g
          inc(pword(px2));
          pbyte(px2)^ := $FF; // set r
          inc(pbyte(px2));
        end;
        inc(psx);
      end;
      l := psy^;
    end;
    inc(psy);
  end;
end;

procedure TIEBitmap.Render_ie1g_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y, l, rl: integer;
  ww:integer;
  px2: prgb;
  px1: PRGBROW;
  px3: pbytearray;
  rl2, rl4: integer;
begin
  //ww := ABitmap.Width;
  sxarr := XLUT;
  syarr := YLUT;
  l := -1;
  rl := ABitmap.RowLen; //_PixelFormat2RowLen(ww, abitmap.pixelformat);
  psy := syarr;
  for y := cy1 to cy2 do
  begin
    if (l = psy^) and SolidBackground then
    begin
      copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
    end
    else
    begin
      px2 := dBitmapScanline[y];
      inc(px2, cx1);
      px1 := Scanline[psy^];
      if UseAlpha then
        px3 := AlphaChannel.ScanLine[psy^]
      else
        px3 := PByteArray(SimAlphaRow);
      psx := sxarr;
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        if (pbytearray(px1)^[psx^ shr 3] and iebitmask1[psx^ and $7]) = 0 then
          with px2^ do
          begin
            r := (alpha * (0 - r) shr 18 + r);
            g := (alpha * (0 - g) shr 18 + g);
            b := (alpha * (0 - b) shr 18 + b);
          end
        else
          with px2^ do
          begin
            r := (alpha * (255 - r) shr 18 + r);
            g := (alpha * (255 - g) shr 18 + g);
            b := (alpha * (255 - b) shr 18 + b);
          end;
        inc(px2);
        inc(psx);
      end;
      l := psy^;
    end;
    inc(psy);
  end;
end;

{!!
<FS>TIEBitmap.ChannelOffset

<FM>Declaration<FC>
property ChannelOffset[idx:integer]:integer;

<FM>Description<FN>
ChannelOffset allows setting an offset for each channel. Idx is the channel where 0=red, 1=green and 2=blue
At the moment ChannelOffset works only with ie24RGB pixelformat.

For example, if you want to display only the red channel, just set green and blue to -255:
<FC>
ImageEnView.IEBitmap.ChannelOffset[1]:=-255;  // hide green
ImageEnView.IEBitmap.ChannelOffset[2]:=-255;  // hide blue
ImageEnView.Update;

<FN>ChannelOffset is useful also to increase or decrease luminosity (brightness). Example:
<FC>
// trackbar1 has min=-255 and max=255.
ImageEnView.IEBitmap.ChannelOffset[0] := trackbar1.Position;
ImageEnView.IEBitmap.ChannelOffset[1] := trackbar1.Position;
ImageEnView.IEBitmap.ChannelOffset[2] := trackbar1.Position;
ImageEnView.Update;
<FN>
Finally you can use ChannelOffset to display the alpha channel as a black image, hiding all channels. Example:
<FC>
ImageEnView.IEBitmap.ChannelOffset[0] := -255;
ImageEnView.IEBitmap.ChannelOffset[1] := -255;
ImageEnView.IEBitmap.ChannelOffset[2] := -255;
ImageEnView.Update;
!!}
procedure TIEBitmap.SetChannelOffset(idx: integer; value: integer);
var
  i: integer;
begin
  if (idx >= 0) and (idx < IEMAXCHANNELS) then
    fChannelOffset[idx] := value;
  fEnableChannelOffset := false;
  for i := 0 to IEMAXCHANNELS - 1 do
    if fChannelOffset[i] <> 0 then
    begin
      fEnableChannelOffset := true;
      break;
    end;
end;

function TIEBitmap.GetChannelOffset(idx: integer): integer;
begin
  if (idx >= 0) and (idx < IEMAXCHANNELS) then
    result := fChannelOffset[idx]
  else
    result := 0;
end;

procedure IEBlendRGBA(var src:TRGBA; var dst:TRGBA; RenderOperation:TIERenderOperation; row:integer);
var
  osrc,odst:TRGB;
begin
  osrc.r:=src.r;
  osrc.g:=src.g;
  osrc.b:=src.b;
  odst.r:=dst.r;
  odst.g:=dst.g;
  odst.b:=dst.b;
  IEBlend(osrc, odst, RenderOperation, row);
  src.r:=osrc.r;
  src.g:=osrc.g;
  src.b:=osrc.b;
  dst.r:=odst.r;
  dst.g:=odst.g;
  dst.b:=odst.b;
end;

procedure IEBlend(var src:TRGB; var dst:TRGB; RenderOperation:TIERenderOperation; row:integer);
// filters
  function softlight(ib, ia: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    a, b, r: double;
  begin
    a := ia / 255;
    b := ib / 255;
    if b < 0.5 then
      r := 2 * a * b + sqr(a) * (1 - 2 * b)
    else
      r := sqrt(a) * (2 * b - 1) + (2 * a) * (1 - b);
    result := trunc(r * 255);
  end;
  function xfader(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    c := a * b shr 8;
    result := c + a * (255 - ((255 - a) * (255 - b) shr 8) - c) shr 8;
  end;
  function coloredge(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if b = 255 then
      result := 255
    else
    begin
      c := (a shl 8) div (255 - b);
      if c > 255 then
        result := 255
      else
        result := c;
    end;
  end;
  function colorburn(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if b = 0 then
      result := 0
    else
    begin
      c := 255 - (((255 - a) shl 8) div b);
      if c < 0 then
        result := 0
      else
        result := c;
    end;
  end;
  function inversecolordodge(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if a = 255 then
      result := 255
    else
    begin
      c := (b shl 8) div (255 - a);
      if c > 255 then
        result := 255
      else
        result := c;
    end;
  end;
  function inversecolorburn(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if a = 0 then
      result := 0
    else
    begin
      c := 255 - (((255 - b) shl 8) div a);
      if c < 0 then
        result := 0
      else
        result := c;
    end;
  end;
  function softdodge(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if a + b < 256 then
    begin
      if b = 255 then
        result := 255
      else
      begin
        c := (a shl 7) div (255 - b);
        if c > 255 then
          result := 255
        else
          result := c;
      end;
    end
    else
    begin
      c := 255 - (((255 - b) shl 7) div a);
      if c < 0 then
        result := 0
      else
        result := c;
    end;
  end;
  function softburn(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if a + b < 256 then
    begin
      if a = 255 then
        Result := 255
      else
      begin
        c := (b shl 7) div (255 - a);
        if c > 255 then
          Result := 255
        else
          Result := c;
      end;
    end
    else
    begin
      c := 255 - (((255 - a) shl 7) div b);
      if c < 0 then
        Result := 0
      else
        Result := c;
    end;
  end;
  function reflect(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if b = 255 then
      result := 255
    else
    begin
      c := a * a div (255 - b);
      if c > 255 then
        result := 255
      else
        result := c;
    end;
  end;
  function glow(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if a = 255 then
      result := 255
    else
    begin
      c := b * b div (255 - a);
      if c > 255 then
        result := 255
      else
        result := c;
    end;
  end;
  function freeze(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if b = 0 then
      result := 0
    else
    begin
      c := 255 - sqr(255 - a) div b;
      if c < 0 then
        result := 0
      else
        result := c;
    end;
  end;
  function eat(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    if a = 0 then
      result := 0
    else
    begin
      c := 255 - sqr(255 - b) div a;
      if c < 0 then
        result := 0
      else
        result := c;
    end;
  end;
  function interpolation(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    c := IECosineTab[b] + IECosineTab[a];
    if c > 255 then
      result := 255
    else
      result := c;
  end;
  function stamp(b, a: integer): integer; {$ifdef IESUPPORTINLINE} inline; {$endif}
  var
    c: integer;
  begin
    c := a + 2 * b - 256;
    if c < 0 then
      result := 0
    else if c > 255 then
      result := 255
    else
      result := c;
  end;
  //
var
  Ha, Sa, La: double;
  Hb, Sb, Lb: double;
  tmp: TRGB;
  v1, v2: byte;
begin
  case RenderOperation of
    ielNormal:
      begin
        dst := src;
      end;
    ielAdd:
      begin
        dst.r := blimit(dst.r + src.r);
        dst.g := blimit(dst.g + src.g);
        dst.b := blimit(dst.b + src.b);
      end;
    ielSub:
      begin
        dst.r := abs(dst.r - src.r);
        dst.g := abs(dst.g - src.g);
        dst.b := abs(dst.b - src.b);
      end;
    ielDiv:
      begin
        dst.r := blimit(dst.r div ilimit(src.r, 1, 255));
        dst.g := blimit(dst.g div ilimit(src.g, 1, 255));
        dst.b := blimit(dst.b div ilimit(src.b, 1, 255));
      end;
    ielMul:
      begin
        dst.r := (dst.r * src.r) shr 8;
        dst.g := (dst.g * src.g) shr 8;
        dst.b := (dst.b * src.b) shr 8;
      end;
    ielOR:
      begin
        dst.r := blimit(dst.r or src.r);
        dst.g := blimit(dst.g or src.g);
        dst.b := blimit(dst.b or src.b);
      end;
    ielAND:
      begin
        dst.r := blimit(dst.r and src.r);
        dst.g := blimit(dst.g and src.g);
        dst.b := blimit(dst.b and src.b);
      end;
    ielXOR:
      begin
        dst.r := blimit(dst.r xor src.r);
        dst.g := blimit(dst.g xor src.g);
        dst.b := blimit(dst.b xor src.b);
      end;
    ielMAX:
      begin
        dst.r := imax(dst.r, src.r);
        dst.g := imax(dst.g, src.g);
        dst.b := imax(dst.b, src.b);
      end;
    ielMIN:
      begin
        dst.r := imin(dst.r, src.r);
        dst.g := imin(dst.g, src.g);
        dst.b := imin(dst.b, src.b);
      end;
    ielAverage:
      begin
        dst.r := (dst.r + src.r) shr 1;
        dst.g := (dst.g + src.g) shr 1;
        dst.b := (dst.b + src.b) shr 1;
      end;
    ielScreen:
      begin
        dst.r := trunc( 255 - ((255 - dst.r) * (255 - src.r) / 255) );
        dst.g := trunc( 255 - ((255 - dst.g) * (255 - src.g) / 255) );
        dst.b := trunc( 255 - ((255 - dst.b) * (255 - src.b) / 255) );
      end;
    ielNegation:
      begin
        dst.r := 255 - abs(255 - src.r - dst.r);
        dst.g := 255 - abs(255 - src.g - dst.g);
        dst.b := 255 - abs(255 - src.b - dst.b);
      end;
    ielExclusion:
      begin
        dst.r := src.r + dst.r - (src.r * dst.r shr 7);
        dst.g := src.g + dst.g - (src.g * dst.g shr 7);
        dst.b := src.b + dst.b - (src.b * dst.b shr 7);
      end;
    ielOverlay:
      begin
        if dst.r < 128 then
          dst.r := (src.r * dst.r) shr 7
        else
          dst.r := 255 - ((255 - src.r) * (255 - dst.r) shr 7);
        if dst.g < 128 then
          dst.g := (src.g * dst.g) shr 7
        else
          dst.g := 255 - ((255 - src.g) * (255 - dst.g) shr 7);
        if dst.b < 128 then
          dst.b := (src.b * dst.b) shr 7
        else
          dst.b := 255 - ((255 - src.b) * (255 - dst.b) shr 7);
      end;
    ielHardLight:
      begin
        if src.r < 128 then
          dst.r := (src.r * dst.r) shr 7
        else
          dst.r := 255 - ((255 - src.r) * (255 - dst.r) shr 7);
        if src.g < 128 then
          dst.g := (src.g * dst.g) shr 7
        else
          dst.g := 255 - ((255 - src.g) * (255 - dst.g) shr 7);
        if src.b < 128 then
          dst.b := (src.b * dst.b) shr 7
        else
          dst.b := 255 - ((255 - src.b) * (255 - dst.b) shr 7);
      end;
    ielSoftLight:
      begin
        dst.r := softlight(src.r, dst.r);
        dst.g := softlight(src.r, dst.g);
        dst.b := softlight(src.r, dst.b);
      end;
    ielXFader:
      begin
        dst.r := XFader(src.r, dst.r);
        dst.g := XFader(src.g, dst.g);
        dst.b := XFader(src.b, dst.b);
      end;
    ielColorEdge:
      begin
        dst.r := ColorEdge(src.r, dst.r);
        dst.g := ColorEdge(src.g, dst.g);
        dst.b := ColorEdge(src.b, dst.b);
      end;
    ielColorBurn:
      begin
        dst.r := ColorBurn(src.r, dst.r);
        dst.g := ColorBurn(src.g, dst.g);
        dst.b := ColorBurn(src.b, dst.b);
      end;
    ielInverseColorDodge:
      begin
        dst.r := InverseColorDodge(src.r, dst.r);
        dst.g := InverseColorDodge(src.g, dst.g);
        dst.b := InverseColorDodge(src.b, dst.b);
      end;
    ielInverseColorBurn:
      begin
        dst.r := InverseColorBurn(src.r, dst.r);
        dst.g := InverseColorBurn(src.g, dst.g);
        dst.b := InverseColorBurn(src.b, dst.b);
      end;
    ielSoftDodge:
      begin
        dst.r := SoftDodge(src.r, dst.r);
        dst.g := SoftDodge(src.g, dst.g);
        dst.b := SoftDodge(src.b, dst.b);
      end;
    ielSoftBurn:
      begin
        dst.r := SoftBurn(src.r, dst.r);
        dst.g := SoftBurn(src.g, dst.g);
        dst.b := SoftBurn(src.b, dst.b);
      end;
    ielReflect:
      begin
        dst.r := Reflect(src.r, dst.r);
        dst.g := Reflect(src.g, dst.g);
        dst.b := Reflect(src.b, dst.b);
      end;
    ielGlow:
      begin
        dst.r := Glow(src.r, dst.r);
        dst.g := Glow(src.g, dst.g);
        dst.b := Glow(src.b, dst.b);
      end;
    ielFreeze:
      begin
        dst.r := Freeze(src.r, dst.r);
        dst.g := Freeze(src.g, dst.g);
        dst.b := Freeze(src.b, dst.b);
      end;
    ielEat:
      begin
        dst.r := Eat(src.r, dst.r);
        dst.g := Eat(src.g, dst.g);
        dst.b := Eat(src.b, dst.b);
      end;
    ielSubtractive:
      begin
        dst.r := blimit(dst.r + src.r - 256);
        dst.g := blimit(dst.g + src.g - 256);
        dst.b := blimit(dst.b + src.b - 256);
      end;
    ielInterpolation:
      begin
        dst.r := Interpolation(src.r, dst.r);
        dst.g := Interpolation(src.g, dst.g);
        dst.b := Interpolation(src.b, dst.b);
      end;
    ielStamp:
      begin
        dst.r := Stamp(src.r, dst.r);
        dst.g := Stamp(src.g, dst.g);
        dst.b := Stamp(src.b, dst.b);
      end;
    ielRed:
      begin
        dst.r := src.r;
      end;
    ielGreen:
      begin
        dst.g := src.g;
      end;
    ielBlue:
      begin
        dst.b := src.b;
      end;
    ielHue:
      begin
        RGB2HSL(src, Ha, Sa, La);
        RGB2HSL(dst, Hb, Sb, Lb);
        HSL2RGB(dst, Ha, Sb, Lb);
      end;
    ielSaturation:
      begin
        RGB2HSL(src, Ha, Sa, La);
        RGB2HSL(dst, Hb, Sb, Lb);
        HSL2RGB(dst, Hb, Sa, Lb);
      end;
    ielColor:
      begin
        RGB2HSL(src, Ha, Sa, La);
        RGB2HSL(dst, Hb, Sb, Lb);
        HSL2RGB(dst, Ha, Sa, Lb);
      end;
    ielLuminosity:
      begin
        RGB2HSL(src, Ha, Sa, La);
        RGB2HSL(dst, Hb, Sb, Lb);
        HSL2RGB(dst, Ha, Sb, La);
      end;
   ielStereoBW:   // black&white
     begin
       v1 := (src.r * gRedToGrayCoef + src.g * gGreenToGrayCoef + src.b * gBlueToGrayCoef) div 100;
       v2 := (dst.r * gRedToGrayCoef + dst.g * gGreenToGrayCoef + dst.b * gBlueToGrayCoef) div 100;
       dst.r := v2;
       dst.g := v1;
       dst.b := v1;
     end;
   ielStereoColor:
     begin
       dst.r := dst.r;
       dst.g := src.g;
       dst.b := src.b;
     end;
   ielStereoColorDubois:
     begin
       tmp.r := blimit(round(
          0.456100*dst.r
         +0.500484*dst.g
         +0.176381*dst.b
         -0.0434706*src.r
         -0.0879388*src.g
         -0.00155529*src.b));
       tmp.g := blimit(round(
         -0.0400822*dst.r
         -0.0378246*dst.g
         -0.0157589*dst.b
         +0.378476*src.r
         +0.73364*src.g
         -0.0184503*src.b));
       tmp.b := blimit(round(
         -0.0152161*dst.r
         -0.0205971*dst.g
         -0.00546856*dst.b
         -0.0721527*src.r
         -0.112961*src.g
         +1.2264*src.b));
       dst := tmp;
     end;
    ielStereoEven:
      if not Odd(row) then
        dst := src;
    ielStereoOdd:
      if Odd(row) then
        dst := src;   end;
end;

procedure TIEBitmap.Render_ie24RGB(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y, l, rl: integer;
  px4,px2: prgb;
  vv: TRGB;
  px1: PRGBROW;
  rl2, rl4: integer;
  vi: integer;
  black, white: integer;
  range: double;
begin
  black := trunc(fBlackValue);
  white := trunc(fWhiteValue);
  range := fWhiteValue - fBlackValue;
  sxarr := XLUT;
  syarr := YLUT;
  l := -1;
  rl := ABitmap.RowLen;
  if fEnableChannelOffset or (fContrast <> 0) or (RenderOperation <> ielNormal) or (range <> 0) then
  begin
    // special drawing
    if fContrast >= 0 then
      vi := trunc((1 + fContrast / 10) * 65536)
    else
      vi := trunc((1 - sqrt(-fContrast) / 10) * 65536);
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground and (range = 0) then
      begin
        CopyMemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        psx := sxarr;
        for x := cx1 to cx2 do
        begin
          vv.r := blimit(128 + (((px1[psx^].r + fChannelOffset[0] - 128) * vi) div 65536));
          vv.g := blimit(128 + (((px1[psx^].g + fChannelOffset[1] - 128) * vi) div 65536));
          vv.b := blimit(128 + (((px1[psx^].b + fChannelOffset[2] - 128) * vi) div 65536));
          if range<>0 then
          begin
            vv.r := trunc(((ilimit(vv.r, black, white)-black)/range)*255);
            vv.g := trunc(((ilimit(vv.g, black, white)-black)/range)*255);
            vv.b := trunc(((ilimit(vv.b, black, white)-black)/range)*255);
          end;
          IEBLend(vv, px2^, RenderOperation, y);
          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end
  else if (ry = 16384) and (rx = 16384) then
  begin
    // original sizes
    rl2 := int64(DWORD(dbitmapscanline[1])) - int64(DWORD(dbitmapscanline[0]));
    px2 := dbitmapscanline[cy1];
    inc(px2, cx1);
    rl4 := (cx2 - cx1 + 1) * 3;
    for y := cy1 to cy2 do
    begin
      px4 := scanline[ySrc + (y - yDst)];
      inc(px4, xSrc + (cx1 - xDst));
      copymemory(px2, px4, rl4);
      inc(pbyte(px2), rl2);
    end;
  end
  else
  begin
    // subsample/oversample
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground then
      begin
        copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        psx := sxarr;
        for x := cx1 to cx2 do
        begin
          px2^ := px1[psx^];
          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end;
end;

procedure TIEBitmap.Render_ie24RGB_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y, l, rl: integer;
  px2: prgb;
  vv, v1: TRGB;
  px4: prgb;
  px1: PRGBROW;
  px3: pbytearray;
  rl2, rl4: integer;
  vi: integer;
begin
  sxarr := XLUT;
  syarr := YLUT;
  l := -1;
  rl := ABitmap.RowLen; //_PixelFormat2RowLen(ww, abitmap.pixelformat);
  if fEnableChannelOffset or (fContrast <> 0) or (RenderOperation <> ielNormal) then
  begin
    // special drawing (channels separation)
    if fContrast >= 0 then
      vi := trunc((1 + fContrast / 10) * 65536)
    else
      vi := trunc((1 - sqrt(-fContrast) / 10) * 65536);
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground then
      begin
        copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        if UseAlpha then
          px3 := AlphaChannel.ScanLine[psy^]
        else
          px3 := PByteArray(SimAlphaRow);
        psx := sxarr;
        for x := cx1 to cx2 do
        begin
          alpha := imin(Transparency, px3[psx^]) shl 10;
          vv.r := blimit(128 + (((px1[psx^].r + fChannelOffset[0] - 128) * vi) div 65536));
          vv.g := blimit(128 + (((px1[psx^].g + fChannelOffset[1] - 128) * vi) div 65536));
          vv.b := blimit(128 + (((px1[psx^].b + fChannelOffset[2] - 128) * vi) div 65536));

          v1 := px2^;
          IEBLend(vv, v1, RenderOperation, y);

          px2^.r := (alpha * (v1.r - px2^.r) shr 18 + px2^.r);
          px2^.g := (alpha * (v1.g - px2^.g) shr 18 + px2^.g);
          px2^.b := (alpha * (v1.b - px2^.b) shr 18 + px2^.b);

          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end
  else
  begin

    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground then
      begin
        copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        if UseAlpha then
          px3 := AlphaChannel.ScanLine[psy^]
        else
          px3 := PByteArray(SimAlphaRow);
        psx := sxarr;

        for x := cx1 to cx2 do
        begin

          //alpha := imin(Transparency, px3[psx^]) shl 10;
          if Transparency < px3[psx^] then
            alpha := Transparency shl 10
          else
            alpha := px3[psx^] shl 10;

          with px2^ do
          begin
            r := (alpha * (px1[psx^].r - r) shr 18 + r);
            g := (alpha * (px1[psx^].g - g) shr 18 + g);
            b := (alpha * (px1[psx^].b - b) shr 18 + b);
          end;
          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end;
end;

procedure TIEBitmap.Render_ie32RGB(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y, l, rl: integer;
  px2: prgb;
  vv: TRGB;
  px1: PRGB32ROW;
  vi: integer;
begin
  sxarr := XLUT;
  syarr := YLUT;
  l := -1;
  rl := ABitmap.RowLen;
  if fEnableChannelOffset or (fContrast <> 0) or (RenderOperation <> ielNormal) or ((ry = 16384) and (rx = 16384)) then
  begin
    // special drawing
    if fContrast >= 0 then
      vi := trunc((1 + fContrast / 10) * 65536)
    else
      vi := trunc((1 - sqrt(-fContrast) / 10) * 65536);
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground then
      begin
        copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        psx := sxarr;
        for x := cx1 to cx2 do
        begin
          vv.r := blimit(128 + (((px1[psx^].r + fChannelOffset[0] - 128) * vi) div 65536));
          vv.g := blimit(128 + (((px1[psx^].g + fChannelOffset[1] - 128) * vi) div 65536));
          vv.b := blimit(128 + (((px1[psx^].b + fChannelOffset[2] - 128) * vi) div 65536));
          IEBLend(vv, px2^, RenderOperation, y);
          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end
  else
  begin
    // subsample/oversample
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground then
      begin
        copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        psx := sxarr;
        for x := cx1 to cx2 do
        begin
          px2^.r := px1[psx^].r;
          px2^.g := px1[psx^].g;
          px2^.b := px1[psx^].b;
          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end;
end;

procedure TIEBitmap.Render_ie32RGB_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y, l, rl: integer;
  px2: prgb;
  vv, v1: TRGB;
  px4: prgb;
  px1: PRGB32ROW;
  px3: pbytearray;
  rl2, rl4: integer;
  vi: integer;
begin
  sxarr := XLUT;
  syarr := YLUT;
  l := -1;
  rl := ABitmap.RowLen; //_PixelFormat2RowLen(ww, abitmap.pixelformat);
  if fEnableChannelOffset or (fContrast <> 0) or (RenderOperation <> ielNormal) then
  begin
    // special drawing (channels separation)
    if fContrast >= 0 then
      vi := trunc((1 + fContrast / 10) * 65536)
    else
      vi := trunc((1 - sqrt(-fContrast) / 10) * 65536);
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground then
      begin
        copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        if UseAlpha then
          px3 := AlphaChannel.ScanLine[psy^]
        else
          px3 := PByteArray(SimAlphaRow);
        psx := sxarr;
        for x := cx1 to cx2 do
        begin
          alpha := imin(Transparency, px3[psx^]) shl 10;
          vv.r := blimit(128 + (((px1[psx^].r + fChannelOffset[0] - 128) * vi) div 65536));
          vv.g := blimit(128 + (((px1[psx^].g + fChannelOffset[1] - 128) * vi) div 65536));
          vv.b := blimit(128 + (((px1[psx^].b + fChannelOffset[2] - 128) * vi) div 65536));

          v1 := px2^;
          IEBLend(vv, v1, RenderOperation, y);

          px2^.r := (alpha * (v1.r - px2^.r) shr 18 + px2^.r);
          px2^.g := (alpha * (v1.g - px2^.g) shr 18 + px2^.g);
          px2^.b := (alpha * (v1.b - px2^.b) shr 18 + px2^.b);

          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end
  else
  begin
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      if (l = psy^) and SolidBackground then
      begin
        copymemory(dbitmapscanline[y], dbitmapscanline[y - 1], rl);
      end
      else
      begin
        px2 := dBitmapScanline[y];
        inc(px2, cx1);
        px1 := Scanline[psy^];
        if UseAlpha then
          px3 := AlphaChannel.ScanLine[psy^]
        else
          px3 := PByteArray(SimAlphaRow);
        psx := sxarr;

        for x := cx1 to cx2 do
        begin

          alpha := imin(Transparency, px3[psx^]) shl 10;
          with px2^ do
          begin
            r := (alpha * (px1[psx^].r - r) shr 18 + r);
            g := (alpha * (px1[psx^].g - g) shr 18 + g);
            b := (alpha * (px1[psx^].b - b) shr 18 + b);
          end;
          inc(px2);
          inc(psx);
        end;
        l := psy^;
      end;
      inc(psy);
    end
  end;
end;


procedure TIEBitmap.Render_ie48RGB(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation);
var
  psy, syarr, psx, sxarr: pinteger;
  x, y: integer;
  px2: prgb;
  vv: TRGB;
  px1: PRGB48ROW;
  vi: double;
begin
  sxarr := XLUT;
  syarr := YLUT;
  if fEnableChannelOffset or (fContrast <> 0) or (RenderOperation <> ielNormal) then
  begin
    // special drawing (channels separation)
    if fContrast >= 0 then
      vi := (1 + fContrast / 10)
    else
      vi := (1 - sqrt(-fContrast) / 10);
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      px2 := dBitmapScanline[y];
      inc(px2, cx1);
      px1 := Scanline[psy^];
      psx := sxarr;
      for x := cx1 to cx2 do
      begin
        vv.r := blimit(trunc( (32768 + ((px1[psx^].r + fChannelOffset[0] - 32768) * vi)) ) shr 8);
        vv.g := blimit(trunc( (32768 + ((px1[psx^].g + fChannelOffset[1] - 32768) * vi)) ) shr 8);
        vv.b := blimit(trunc( (32768 + ((px1[psx^].b + fChannelOffset[2] - 32768) * vi)) ) shr 8);
        IEBLend(vv, px2^, RenderOperation, y);
        inc(px2);
        inc(psx);
      end;
      inc(psy);
    end
  end
  else
  begin

    psy := syarr;
    for y := cy1 to cy2 do
    begin
      px2 := dBitmapScanline[y];
      inc(px2, cx1);
      px1 := Scanline[psy^];
      psx := sxarr;
      for x := cx1 to cx2 do
      begin

        with px1[psx^] do
        begin
          px2^.r := r shr 8;
          px2^.g := g shr 8;
          px2^.b := b shr 8;
        end;

        inc(px2);
        inc(psx);
      end;
      inc(psy);
    end
  end;
end;

procedure TIEBitmap.Render_ie48RGB_alpha(dbitmapscanline: ppointerarray; var ABitmap: TIEBitmap; Transparency: integer; UseAlpha: boolean; SimAlphaRow: pbyte; XLUT, YLUT: pinteger; xSrc, ySrc: integer; xDst, yDst: integer; cx1, cy1, cx2, cy2: integer; rx, ry: integer; SolidBackground: boolean; RenderOperation: TIERenderOperation);
var
  psy, syarr, psx, sxarr: pinteger;
  alpha, x, y: integer;
  px2: prgb;
  vv, v1: TRGB;
  px4: prgb;
  px1: PRGB48ROW;
  px3: pbytearray;
  rl2, rl4: integer;
  vi: double;
begin
  sxarr := XLUT;
  syarr := YLUT;
  if fEnableChannelOffset or (fContrast <> 0) or (RenderOperation <> ielNormal) then
  begin
    // special drawing (channels separation)
    if fContrast >= 0 then
      vi := (1 + fContrast / 10)
    else
      vi := (1 - sqrt(-fContrast) / 10);
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      px2 := dBitmapScanline[y];
      inc(px2, cx1);
      px1 := Scanline[psy^];
      if UseAlpha then
        px3 := AlphaChannel.ScanLine[psy^]
      else
        px3 := PByteArray(SimAlphaRow);
      psx := sxarr;
      for x := cx1 to cx2 do
      begin
        alpha := imin(Transparency, px3[psx^]) shl 10;
        vv.r := blimit(trunc( (32768 + ((px1[psx^].r + fChannelOffset[0] - 32768) * vi)) ) shr 8);
        vv.g := blimit(trunc( (32768 + ((px1[psx^].g + fChannelOffset[1] - 32768) * vi)) ) shr 8);
        vv.b := blimit(trunc( (32768 + ((px1[psx^].b + fChannelOffset[2] - 32768) * vi)) ) shr 8);

        v1 := px2^;
        IEBLend(vv, v1, RenderOperation, y);

        px2^.r := (alpha * (v1.r - px2^.r) shr 18 + px2^.r);
        px2^.g := (alpha * (v1.g - px2^.g) shr 18 + px2^.g);
        px2^.b := (alpha * (v1.b - px2^.b) shr 18 + px2^.b);

        inc(px2);
        inc(psx);
      end;
      inc(psy);
    end
  end
  else
  begin
    psy := syarr;
    for y := cy1 to cy2 do
    begin
      px2 := dBitmapScanline[y];
      inc(px2, cx1);
      px1 := Scanline[psy^];
      if UseAlpha then
        px3 := AlphaChannel.ScanLine[psy^]
      else
        px3 := PByteArray(SimAlphaRow);
      psx := sxarr;

      for x := cx1 to cx2 do
      begin

        alpha := imin(Transparency, px3[psx^]) shl 10;
        with px2^ do
        begin
          r := (alpha * (px1[psx^].r shr 8 - r) shr 18 + r);
          g := (alpha * (px1[psx^].g shr 8 - g) shr 18 + g);
          b := (alpha * (px1[psx^].b shr 8 - b) shr 18 + b);
        end;
        inc(px2);
        inc(psx);
      end;
      inc(psy);
    end;
  end;
end;


{!!
<FS>TIEBitmap.StretchRectTo

<FM>Declaration<FC>
procedure StretchRectTo(Dest: <A TIEBitmap>; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; Filter: <A TResampleFilter>; Transparency: integer);

<FM>Description<FN>
Stretches source rectangle in destination rectangle.
This method doesn't merge the image with the background, but just replace it (image and alpha).
This function assumes that there is an alpha channel (if not creates it).
<FC>Dest<FN> must be ie24RGB
!!}
procedure TIEBitmap.StretchRectTo(Dest: TIEBitmap; xDst, yDst, dxDst, dyDst: integer; xSrc, ySrc, dxSrc, dySrc: integer; Filter: TResampleFilter; Transparency: integer);
var
  y, x, ww, hh: integer;
  px2, px4: prgb;
  px1: PRGBROW;
  px3: pbytearray;
  pb1, pb2: pbyte;
  x1, y1, x2, y2: integer;
  rx, ry: integer;
  a: integer;
  sr, sg, sb: integer;
  rl, rl2, rl4: integer;
  xx: integer;
  cx1, cy1, cx2, cy2: integer;
  fOffX, fOffY, frx, fry, fo1x, fo1y, fo2x, fo2y: integer;
  UseAlpha: boolean;
  sxarr, psx, syarr, psy: pinteger;
  ietmp1, ietmp2: TIEBitmap;
begin
  if (Filter <> rfNone) and ((dxSrc <> dxDst) or (dySrc <> dyDst)) then
  begin
    // need to resample using a filter
    if (dxDst <= dxSrc) and (PixelFormat = ie1g) and (not HasAlphaChannel) then
    begin
      // subsample 1 bit bitmap
      if (dxDst > 0) and (dyDst > 0) then
      begin
        ietmp1 := TIEBitmap.Create;
        ietmp1.Allocate(dxDst, dyDst, ie24RGB);
        _SubResample1bitFilteredEx(self, xSrc, ySrc, xSrc + dxSrc - 1, ySrc + dySrc - 1, ietmp1);
        ietmp1.StretchRectTo(Dest, xDst, yDst, dxDst, dyDst, 0, 0, dxDst, dyDst, rfNone, Transparency);
        FreeAndNil(ietmp1);
      end;
    end
    else
    begin
      // sub/over resample 1/24 bits bitmap
      ietmp1 := TIEBitmap.Create;
      ietmp1.Allocate(dxSrc, dySrc, PixelFormat);
      CopyRectTo(ietmp1, xSrc, ySrc, 0, 0, dxSrc, dySrc);
      if HasAlphaChannel then
      begin
        AlphaChannel.CopyRectTo(ietmp1.AlphaChannel, xSrc, ySrc, 0, 0, dxSrc, dySrc);
        ietmp1.AlphaChannel.Full := AlphaChannel.Full;
      end;
      ietmp2 := TIEBitmap.Create;
      if PixelFormat = ie1g then
      begin
        if (Filter=rfProjectBW) or (Filter=rfProjectWB) then
          ietmp2.Allocate(dxDst, dyDst, ie1g)
        else
          ietmp2.Allocate(dxDst, dyDst, ie24RGB);
        _Resample1bitEx(ietmp1, ietmp2, Filter);
      end
      else
      begin
        ietmp2.Allocate(dxDst, dyDst, ie24RGB);
        _ResampleEx(ietmp1, ietmp2, Filter, nil, nil);
      end;
      if HasAlphaChannel then
      begin
        _Resampleie8g(ietmp1.AlphaChannel, ietmp2.AlphaChannel, Filter);
        ietmp2.AlphaChannel.Full := ietmp1.AlphaChannel.Full;
      end;
      ietmp2.StretchRectTo(Dest, xDst, yDst, dxDst, dyDst, 0, 0, dxDst, dyDst, rfNone, Transparency);
      FreeAndNil(ietmp2);
      FreeAndNil(ietmp1);
    end;
    exit; // EXIT POINT
  end;
  fOffX := xDst;
  fOffY := yDst;
  frx := dxDst;
  fry := dyDst;
  fo1x := xSrc;
  fo1y := ySrc;
  fo2x := dxSrc;
  fo2y := dySrc;
  if (dxDst = 0) or (dyDst = 0) then
    exit;
  ww := Dest.Width;
  hh := Dest.Height;
  //
  if (dxDst <> 0) and (dyDst <> 0) then
  begin
    sxarr := nil;
    syarr := nil;
    try
      ry := trunc((fo2y / fry) * 16384); // 2^14
      rx := trunc((fo2x / frx) * 16384);
      y2 := imin(fOffY + fry - 1, hh - 1);
      x2 := imin(fOffX + frx - 1, ww - 1);
      cx1 := -2147483646;
      cy1 := -2147483646;
      cx2 := 2147483646;
      cy2 := 2147483646;
      cx1 := imax(cx1, fOffX);
      cx2 := imin(cx2, x2);
      cy1 := imax(cy1, fOffY);
      cy2 := imin(cy2, y2);
      //
      cx1 := imax(cx1, 0);
      cx2 := imin(cx2, Dest.Width - 1);
      cy1 := imax(cy1, 0);
      cy2 := imin(cy2, Dest.Height - 1);
      //
      rl := Dest.RowLen;
      //l:=-1;
      UseAlpha := HasAlphaChannel and (not AlphaChannel.Full);
      if (ry <> 16384) or (rx <> 16384) or (PixelFormat = ie1g) or UseAlpha then
      begin
        // build horizontal LUT
        getmem(sxarr, (cx2 - cx1 + 1) * sizeof(integer));
        psx := sxarr;
        for x := cx1 to cx2 do
        begin
          psx^ := (rx * (x - fOffX) shr 14) + fo1x;
          inc(psx);
        end;
        // build vertical LUT
        getmem(syarr, (cy2 - cy1 + 1) * sizeof(integer));
        psy := syarr;
        for y := cy1 to cy2 do
        begin
          psy^ := (ry * (y - fOffy) shr 14) + fo1y;
          inc(psy);
        end;
      end;
      if UseAlpha then
      begin
        // copy alpha channel
        if (ry = 16384) and (rx = 16384) then
        begin
          // original sizes
          rl4 := (cx2 - cx1 + 1);
          for y := cy1 to cy2 do
          begin
            pb1 := dest.AlphaChannel.Scanline[y];
            inc(pb1, cx1);
            pb2 := AlphaChannel.scanline[fo1y + (y - fOffY)];
            inc(pb2, fo1x + (cx1 - fOffX));
            copymemory(pb1, pb2, rl4);
          end;
        end
        else
        begin
          // subsample/oversample
          psy := syarr;
          for y := cy1 to cy2 do
          begin
            pb2 := Dest.AlphaChannel.Scanline[y];
            inc(pb2, cx1);
            pb1 := AlphaChannel.Scanline[psy^];
            psx := sxarr;
            for x := cx1 to cx2 do
            begin
              pb2^ := pbytearray(pb1)[psx^];
              inc(pb2);
              inc(psx);
            end;
            inc(psy);
          end
        end;
        for y := cy1 to cy2 do
        begin
          pb1 := Dest.AlphaChannel.Scanline[y];
          inc(pb1, cx1);
          for x := cx1 to cx2 do
          begin
            pb1^ := imin(Transparency, pb1^);
            inc(pb1);
          end;
        end;
      end
      else
        dest.AlphaChannel.FillRect(cx1, cy1, cx2, cy2, Transparency);
      case PixelFormat of
        ie24RGB:
          // 24 bits per pixel
          begin
            if (ry = 16384) and (rx = 16384) then
            begin
              // original sizes
              rl4 := (cx2 - cx1 + 1) * 3;
              for y := cy1 to cy2 do
              begin
                px2 := dest.Scanline[y];
                inc(px2, cx1);
                px4 := scanline[fo1y + (y - fOffY)];
                inc(px4, fo1x + (cx1 - fOffX));
                copymemory(px2, px4, rl4);
              end;
            end
            else
            begin
              // subsample/oversample
              psy := syarr;
              for y := cy1 to cy2 do
              begin
                px2 := Dest.Scanline[y];
                inc(px2, cx1);
                px1 := Scanline[psy^];
                psx := sxarr;
                for x := cx1 to cx2 do
                begin
                  px2^ := px1[psx^];
                  inc(px2);
                  inc(psx);
                end;
                inc(psy);
              end
            end;
          end;
        ie1g:
          // 1 bit per pixel
          begin
            psy := syarr;
            for y := cy1 to cy2 do
            begin
              px2 := Dest.Scanline[y];
              inc(px2, cx1);
              px1 := Scanline[psy^];
              psx := sxarr;
              for x := cx1 to cx2 do
              begin
                if (pbytearray(px1)^[psx^ shr 3] and iebitmask1[psx^ and $7]) = 0 then
                begin
                  pword(px2)^ := 0; // set b,g
                  inc(pword(px2));
                  pbyte(px2)^ := 0; // set r
                  inc(pbyte(px2));
                end
                else
                begin
                  pword(px2)^ := $FFFF; // set b,g
                  inc(pword(px2));
                  pbyte(px2)^ := $FF; // set r
                  inc(pbyte(px2));
                end;
                inc(psx);
              end;
              inc(psy);
            end
          end;
      end; // end of case
    except
    end;
    if (sxarr <> nil) then
      freemem(sxarr);
    if (syarr <> nil) then
      freemem(syarr);
  end;
end;

{!!
<FS>TIEBitmap.SyncFull

<FM>Declaration<FC>
procedure SyncFull;

<FM>Description<FN>
SyncFull sets <A TIEBitmap.Full> to True if all values of the image are 255.
!!}
// works with all pixelformats
procedure TIEBitmap.SyncFull;
var
  px: pbyte;
  y, x, l: integer;
begin
  l := IEBitmapRowLen(fWidth,fBitCount,8);  // do not use fRowLen because here we take account only 8 bit alignment
  for y := 0 to fHeight - 1 do
  begin
    px := Scanline[y];
    for x := 0 to l - 1 do
    begin
      if (px^<$FF) then
      begin
        fFull := False;
        exit;
      end;
      inc(px);
    end;
  end;
  fFull := True;
end;

{!!
<FS>TIEBitmap.IsAllBlack

<FM>Declaration<FC>
function IsAllBlack:boolean;

<FM>Description<FN>
Return true if all pixels are Zero.
!!}
function TIEBitmap.IsAllBlack:boolean;
var
  px:pbyte;
  y, x, l: integer;
begin
  l := IEBitmapRowLen(fWidth, fBitcount, 8);
  for y := 0 to fHeight - 1 do
  begin
    px := Scanline[y];
    for x := 0 to l - 1 do
    begin
      if px^ <>0 then
      begin
        result:=false;
        exit;
      end;
      inc(px);
    end;
  end;
  result:=true;
end;

{!!
<FS>TIEBitmap.IsGrayScale

<FM>Declaration<FC>
function IsGrayScale: boolean;

<FM>Description<FN>
Checks if all pixels have have R=G=B values (the bitmap is grayscale)
!!}
function TIEBitmap.IsGrayScale: boolean;
var
  x, y: integer;
  pp: PRGB;
  p48: PRGB48;
  p32: PRGBA;
begin
  result := true;
  case fPixelFormat of
    ie8p:
      for y := 0 to fRGBPaletteLen - 1 do
      begin
        with fRGBPalette[y] do
          if (r <> b) or (b <> g) then
          begin
            result := false;
            exit;
          end;
      end;
    ie24RGB:
      for y := 0 to fHeight - 1 do
      begin
        pp := scanline[y];
        for x := 0 to fWidth - 1 do
        begin
          with pp^ do
            if (r <> b) or (b <> g) then
            begin
              result := false;
              exit;
            end;
          inc(pp);
        end;
      end;
    ie32RGB:
      for y := 0 to fHeight - 1 do
      begin
        p32 := scanline[y];
        for x := 0 to fWidth - 1 do
        begin
          with p32^ do
            if (r <> b) or (b <> g) then
            begin
              result := false;
              exit;
            end;
          inc(p32);
        end;
      end;
    ie48RGB:
      for y := 0 to fHeight - 1 do
      begin
        p48 := scanline[y];
        for x := 0 to fWidth - 1 do
        begin
          with p48^ do
            if (r <> b) or (b <> g) then
            begin
              result := false;
              exit;
            end;
          inc(p48);
        end;
      end;
  end;
end;

const
  IERAWVERSION:integer=0;
  IEMAGIKRAW:AnsiString='TIEBITMAPRAW'; // 12 chars

{!!
<FS>TIEBitmap.CalcRAWSize

<FM>Declaration<FC>
function CalcRAWSize:integer;

<FM>Description<FN>
Calculates the space required for <A TIEBitmap.SaveRAWToBufferOrStream> method, when used with 'Buffer" parameter.
!!}
function TIEBitmap.CalcRAWSize:integer;
begin
  // main image
  result:=12;                                   // magik
  inc(result, sizeof(integer));                 // RAW version
  inc(result, sizeof(fRGBPaletteLen));          // fRGBPaletteLen
  inc(result, sizeof(TRGB)*fRGBPaletteLen);     // fRGBPalette
  inc(result, sizeof(fWidth) );                 // fWidth
  inc(result, sizeof(fHeight) );                // fHeight
  inc(result, sizeof(TIEPixelFormat) );         // fPixelFormat
  inc(result, sizeof(fFull) );                  // fFull
  inc(result, sizeof(fPaletteUsed) );           // fPaletteUsed
  inc(result, sizeof(fBlackValue) );            // fBlackValue
  inc(result, sizeof(fWhiteValue) );            // fWhiteValue
  inc(result, sizeof(integer)*IEMAXCHANNELS );  // fChannelOffset[]
  inc(result, sizeof(fEnableChannelOffset) );   // fEnableChannelOffset
  inc(result, sizeof(fContrast) );              // fContrast
  inc(result, sizeof(fBitAlignment) );          // fBitAlignment
  inc(result, fRowLen * fHeight );              // the actual image
  inc(result, sizeof(boolean) );                // true if has alpha channel
  // alpha channel
  if HasAlphaChannel then
  begin
    inc(result, sizeof(boolean)); // fFull of alpha channel
    inc(result, AlphaChannel.RowLen * AlphaChannel.Height );
  end;
end;

{!!
<FS>TIEBitmap.SaveRAWToBufferOrStream

<FM>Declaration<FC>
procedure SaveRAWToBufferOrStream(Buffer:pointer; Stream:TStream);

<FM>Description<FN>
Saves the image as internal format preserving pixel format and alpha channel.
Location field will be lost. Only the image and its description is saved.
If the image has alpha channel this is also saved.
You can save the image inside a buffer or a stream.
Saving in a buffer you have to specify a valid <FC>Buffer<FN> (of size returned by <A TIEBitmap.CalcRAWSize>) and <FC>Stream<FN> must be <FC>nil<FN>.
Saving in a <FC>Stream<FN> the <FC>Buffer<FN> parameter must be <FC>nil<FN>.

<FM>Look also<FN>
  <A TIEBitmap.LoadRAWFromBufferOrStream>
  <A TIEBitmap.CalcRAWSize>
!!}
procedure TIEBitmap.SaveRAWToBufferOrStream(Buffer:pointer; Stream:TStream);
var
  pw:integer; // writing position
  buf:PAnsiChar;

  procedure Write(const v; sz:integer);
  begin
    if Buffer<>nil then
    begin
      move(v, buf[pw], sz);
      inc(pw, sz);
    end
    else if assigned(Stream) then
      Stream.Write(v, sz);
  end;

var
  row,sz:integer;
  bb:boolean;

begin

  //// prepare for writing

  buf := Buffer;
  pw := 0;

  //// writing

  Write( IEMAGIKRAW[1], 12);                            // magik
  Write( IERAWVERSION, sizeof(integer));                // RAW version
  Write( fRGBPaletteLen, sizeof(fRGBPaletteLen));       // fRGBPaletteLen
  Write( fRGBPalette[0], sizeof(TRGB)*fRGBPaletteLen);  // fRGBPalette
  Write( fWidth, sizeof(fWidth) );                      // fWidth
  Write( fHeight, sizeof(fHeight) );                    // fHeight
  Write( fPixelFormat, sizeof(TIEPixelFormat) );        // fPixelFormat
  Write( fFull, sizeof(fFull) );                        // fFull
  Write( fPaletteUsed, sizeof(fPaletteUsed) );          // fPaletteUsed
  Write( fBlackValue, sizeof(fBlackValue) );            // fBlackValue
  Write( fWhiteValue, sizeof(fWhiteValue) );            // fWhiteValue
  Write( fChannelOffset[0], sizeof(integer)*IEMAXCHANNELS );    // fChannelOffset
  Write( fEnableChannelOffset, sizeof(fEnableChannelOffset) );  // fEnableChannelOffset
  Write( fContrast, sizeof(fContrast) );          // fContrast
  Write( fBitAlignment, sizeof(fBitAlignment) );  // fBitAlignment

  if assigned(Stream) then
  begin
    sz := Stream.Position + fRowLen * fHeight;
    if sz > Stream.Size then
      try
        Stream.Size := sz;
      except
      end;
  end;

  for row:=0 to fHeight-1 do
    Write( pbyte(Scanline[row])^, fRowLen );

  bb := HasAlphaChannel;
  Write( bb, sizeof(boolean) ); // has alpha channel
  if bb then
  begin
    if assigned(Stream) then
      Stream.Size := Stream.Size+AlphaChannel.RowLen*fHeight;
    for row:=0 to fHeight-1 do
      Write( pbyte(AlphaChannel.Scanline[row])^, AlphaChannel.RowLen );
    Write( AlphaChannel.fFull, sizeof(boolean) );
  end;

end;

{!!
<FS>TIEBitmap.LoadRAWFromBufferOrStream

<FM>Declaration<FC>
function LoadRAWFromBufferOrStream(Buffer:pointer; Stream:TStream):boolean;

<FM>Description<FN>
Loads the image saved using <A TIEBitmap.SaveRAWToBufferOrStream>.
Return true on success.
!!}
// creates the image from the specified buffer (created using SaveRAWToBufferOrStream)
function TIEBitmap.LoadRAWFromBufferOrStream(Buffer:pointer; Stream:TStream):boolean;
var
  pr:integer; // reading position
  buf:PAnsiChar;

  procedure Read(var v; sz:integer);
  begin
    if Buffer<>nil then
    begin
      move( buf[pr], v, sz );
      inc(pr,sz);
    end
    else if assigned(Stream) then
      Stream.Read(v,sz);
  end;

var
  mag:AnsiString;
  ver:integer;  // version
  NewRGBPaletteLen:integer;
  NewRGBPalette:pointer;
  NewWidth,NewHeight:integer;
  NewPixelFormat:TIEPixelFormat;
  NewFull:boolean;
  NewPaletteUsed:integer;
  NewBlackValue,NewWhiteValue:double;
  NewChannelOffset:array[0..IEMAXCHANNELS - 1] of integer;
  NewEnableChannelOffset:boolean;
  NewContrast:integer;
  NewBitAlignment:integer;
  NewHasAlpha:boolean;
  row:integer;
begin
  result:=false;
  pr:=0;
  buf:=Buffer;

  // magik
  SetLength(mag,12);
  Read(mag[1],12);
  if mag<>IEMAGIKRAW then
    exit;

  // version
  Read(ver, sizeof(integer) );

  if ver>=0 then
  begin

    // palette
    Read(NewRGBPaletteLen, sizeof(integer));
    getmem(NewRGBPalette, NewRGBPaletteLen*sizeof(TRGB));
    Read(NewRGBPalette^, NewRGBPaletteLen*sizeof(TRGB));

    // other info
    Read(NewWidth, sizeof(integer));
    Read(NewHeight, sizeof(integer));
    Read(NewPixelFormat, sizeof(TIEPixelFormat));
    Read(NewFull, sizeof(boolean));
    Read(NewPaletteUsed, sizeof(integer));
    Read(NewBlackValue, sizeof(double));
    Read(NewWhiteValue, sizeof(double));
    Read(NewChannelOffset, sizeof(integer)*IEMAXCHANNELS);
    Read(NewEnableChannelOffset, sizeof(boolean));
    Read(NewContrast, sizeof(integer));
    Read(NewBitAlignment, sizeof(integer));

    // allocate bitmap
    BitAlignment:=NewBitAlignment;
    Allocate(NewWidth, NewHeight, NewPixelFormat);
    fFull:=NewFull;
    fPaletteUsed:=NewPaletteUsed;
    fBlackValue:=NewBlackValue;
    fWhiteValue:=NewWhiteValue;
    move(NewChannelOffset[0],fChannelOffset,sizeof(integer)*IEMAXCHANNELS);
    fEnableChannelOffset:=NewEnableChannelOffset;
    fContrast:=NewContrast;

    // get image
    for row:=0 to fHeight-1 do
      Read( pbyte(Scanline[row])^, fRowLen);

    // get alpha
    Read( NewHasAlpha, sizeof(boolean) );
    if NewHasAlpha then
    begin
      for row:=0 to fHeight-1 do
        Read( pbyte(AlphaChannel.Scanline[row])^, AlphaChannel.RowLen );
      Read( AlphaChannel.fFull, sizeof(boolean) );
    end
    else
      FreeAndNil(fAlphaChannel);

    result:=true;
  end;

end;

{!!
<FS>TIEBitmap.CopyWithMask1

<FM>Declaration<FC>
procedure CopyWithMask1(Dest: <A TIEBitmap>; SourceMask:<A TIEMask>; Background:TColor);
procedure CopyWithMask1(Dest: <A TIEBitmap>; SourceMask:<A TIEMask>);

<FM>Description<FN>
Copies current bitmap to <FC>Dest<FN>, using the <FC>SourceMask<FN> referred to the source.
!!}
procedure TIEBitmap.CopyWithMask1(Dest: TIEBitmap; SourceMask:TIEMask; Background:TColor);
begin
  if not SourceMask.IsEmpty then
  begin
    Dest.Allocate( SourceMask.x2 - SourceMask.x1 + 1, SourceMask.y2 - SourceMask.y1 + 1, PixelFormat );
    Dest.Fill(Background);
    SourceMask.CopyIEBitmap(Dest, self, true, false, true);
  end;
end;

procedure TIEBitmap.CopyWithMask1(Dest: TIEBitmap; SourceMask:TIEMask);
begin
  if not SourceMask.IsEmpty then
  begin
    Dest.Allocate( SourceMask.x2 - SourceMask.x1 + 1, SourceMask.y2 - SourceMask.y1 + 1, PixelFormat );
    CopyRectTo(Dest,SourceMask.x1,SourceMask.y1,0,0,Dest.Width,Dest.Height);
    SourceMask.CopyIEBitmap(Dest, self, true, false, true);
  end;
end;


{!!
<FS>TIEBitmap.CopyWithMask2

<FM>Declaration<FC>
procedure CopyWithMask2(Dest: <A TIEBitmap>; DestMask:<A TIEMask>);

<FM>Description<FN>
Copies current bitmap to <FC>Dest<FN> using <FC>DestMask<FN> referred to the destination.
!!}
procedure TIEBitmap.CopyWithMask2(Dest: TIEBitmap; DestMask:TIEMask);
begin
  if not DestMask.IsEmpty then
  begin
    DestMask.CopyIEBitmap(Dest,self, false,true, false);
    if HasAlphaChannel then
    begin
      DestMask.CopyIEBitmap(Dest.AlphaChannel,self.AlphaChannel, false,true, false);
      Dest.AlphaChannel.Full:=false;
    end;
  end;
end;

{!!
<FS>TIEBitmap.AutoCalcBWValues

<FM>Declaration<FC>
procedure AutoCalcBWValues;

<FM>Description<FN>
Auto calculates <A TIEBitmap.BlackValue> and <A TIEBitmap.WhiteValue> to display correctly the image.
This method finds the low and high values of image pixels and sets them to BlackValue and WhiteValue properties.
!!}
procedure TIEBitmap.AutoCalcBWValues;
var
  x, y, colcount:integer;
  pw:pword;
  pb:pbyte;
  ps:psingle;
begin
  case fPixelFormat of
    ie8g:
      begin
        fBlackValue:= 255;
        fWhiteValue:=-255;
        for y:=0 to fHeight-1 do
        begin
          pb:=Scanline[y];
          for x:=0 to fWidth-1 do
          begin
            if pb^>fWhiteValue then
              fWhiteValue:=pb^;
            if pb^<fBlackValue then
              fBlackValue:=pb^;
            inc(pb);
          end;
        end;
      end;
    ie16g:
      begin
        fBlackValue:= 65535;
        fWhiteValue:=-65535;
        for y:=0 to fHeight-1 do
        begin
          pw:=Scanline[y];
          for x:=0 to fWidth-1 do
          begin
            if pw^>fWhiteValue then
              fWhiteValue:=pw^;
            if pw^<fBlackValue then
              fBlackValue:=pw^;
            inc(pw);
          end;
        end;
      end;
    ie24RGB:
      begin
        fBlackValue :=  255;
        fWhiteValue := -255;
        colCount := fWidth * 3;
        for y:=0 to fHeight-1 do
        begin
          pb := Scanline[y];
          for x:=0 to colCount-1 do
          begin
            if pb^>fWhiteValue then
              fWhiteValue := pb^;
            if pb^<fBlackValue then
              fBlackValue := pb^;
            inc(pb);
          end;
        end;
      end;
    ie32f:
      begin
        fBlackValue:= 100000000;
        fWhiteValue:=-100000000;
        for y:=0 to fHeight-1 do
        begin
          ps:=Scanline[y];
          for x:=0 to fWidth-1 do
          begin
            if ps^>fWhiteValue then
              fWhiteValue:=ps^;
            if ps^<fBlackValue then
              fBlackValue:=ps^;
            inc(ps);
          end;
        end;
      end;
  end;
end;

{!!
<FS>TIEBitmap.SynchronizeRGBA

<FM>Declaration<FC>
procedure SynchronizeRGBA(RGBAtoAlpha:boolean);

<FM>Description<FN>
When ie32RGB (RGBA) pixel format is used, the A channel is not used. Alpha channel is stored in a separated plane (<A TIEBitmap.AlphaChannel>).
To copy from A channel to Alpha channel you have to call SynchronizeRGBA with RGBAToAlpha=true.
Viceversa to copy from Alpha channel to A channel call SynchronizeRGBA with RGBAToAlpha=false.
!!}
procedure TIEBitmap.SynchronizeRGBA(RGBAtoAlpha:boolean);
var
  pb1,pb2:pbyte;
  row,col:integer;
begin
  if RGBAToAlpha then
  begin
    // A of RGBA to AlphaChannel
    for row:=0 to fHeight-1 do
    begin
      pb1:=Scanline[row];
      pb2:=AlphaChannel.ScanLine[row];
      for col:=0 to fWidth-1 do
      begin
        inc(pb1,3);
        pb2^:=pb1^;
        inc(pb1);
        inc(pb2);
      end;
    end;
    AlphaChannel.SyncFull;
  end
  else
  begin
    // AlphaChannel to A of RGBA
    for row:=0 to fHeight-1 do
    begin
      pb1:=Scanline[row];
      pb2:=AlphaChannel.ScanLine[row];
      for col:=0 to fWidth-1 do
      begin
        inc(pb1,3);
        pb1^:=pb2^;
        inc(pb1);
        inc(pb2);
      end;
    end;
  end;
end;

{!!
<FS>TIEBitmap.CopyPaletteTo

<FM>Declaration<FC>
procedure CopyPaletteTo(Dest:TIEBaseBitmap);

<FM>Description<FN>
Copies all palette colors to destination bitmap. Dest must be a <A TIEBitmap> object.
!!}
procedure TIEBitmap.CopyPaletteTo(Dest:TIEBaseBitmap);
var
  dst:TIEBitmap;
begin
  if Dest is TIEBitmap then
  begin
    dst:=Dest as TIEBitmap;
    if assigned(dst.fRGBPalette) then
    begin
      freemem(dst.fRGBPalette);
      dst.fRGBPalette:=nil;
      dst.fRGBPaletteLen:=0;
      dst.PaletteUsed:=256;
    end;
    if fRGBPaletteLen>0 then
    begin
      getmem(dst.fRGBPalette, sizeof(TRGB) * fRGBPaletteLen);
      CopyMemory(dst.fRGBPalette, fRGBPalette, sizeof(TRGB)*fRGBPaletteLen);
      dst.fRGBPaletteLen:=fRGBPaletteLen;
      dst.fPaletteUsed:=fPaletteUsed;
      dst.UpdateTBitmapPalette;
    end;
  end;
end;


{!!
<FS>TIEBitmap.MergeWithAlpha

<FM>Declaration<FC>
procedure MergeWithAlpha(Bitmap:<A TIEBitmap>; DstX:integer=0; DstY:integer=0; DstWidth:integer=-1; DstHeight:integer=-1; Transparency:integer=255; ResampleFilter:<A TResampleFilter> = rfNone; Operation:<A TIERenderOperation>=ielNormal);

<FM>Description<FN>
Merges pixels and alpha channel of <FC>Bitmap<FN> with the background.
Supports only ie24RGB pixel format.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Bitmap<FN></C> <C>Image with alpha channel to merge with the background.</C> </R>
<R> <C><FC>DstX<FN></C> <C>Horizontal destination position.</C> </R>
<R> <C><FC>DstY<FN></C> <C>Vertical destination position.</C> </R>
<R> <C><FC>DstWidth<FN></C> <C>Destination width (Bitmap will be resampled to this value). -1 = the same width of source bitmap.</C> </R>
<R> <C><FC>DstHeight<FN></C> <C>Destination height (Bitmap will be resampled to this value). -1 = the same height of source bitmap.</C> </R>
<R> <C><FC>Transparency<FN></C> <C>Transparency of source bitmap. 0 = fully transparent, 255 = fully opaque.</C> </R>
<R> <C><FC>ResampleFilter<FN></C> <C>Interpolation filter used when source bitmap needs to be resampled.</C> </R>
<R> <C><FC>Operation<FN></C> <C>Blender operation to perform.</C> </R>
</TABLE>

<FM>Example<FC>

// merges uplayer.png over background.png
ImageEnView1.IO.LoadFromFile('background.png');
ImageEnView2.IO.LoadFromFile('uplayer.png');
ImageEnView1.IEBitmap.MergeWithAlpha(ImageEnView2.IEBitmap);
ImageEnView1.Update;
ImageEnView1.IO.SaveToFile('output.png');
!!}
procedure TIEBitmap.MergeWithAlpha(Bitmap:TIEBitmap; DstX:integer; DstY:integer; DstWidth:integer; DstHeight:integer;
                                   Transparency:integer; ResampleFilter:TResampleFilter; Operation:TIERenderOperation);
var
  i, j:integer;
  prgb0:PRGB;     // prgb0 is this bitmap and destination color
  prgb1:PRGB;     // prgb1 is upper bitmap
  palpha0:pbyte;  // palpha0 is this bitmap alpha
  palpha1:pbyte;  // palpha1 is upper layer alpha
  aa, bb, cc, opt1:double;
  w, h, r, g, b:integer;
  vv:TRGB;
  negDstX, negDstY:integer;
  WorkingBitmap:TIEBitmap;
begin

  if DstWidth=-1 then
    DstWidth := Bitmap.Width;
  if DstHeight=-1 then
    DstHeight := Bitmap.Height;

  if (DstWidth<>Bitmap.Width) or (DstHeight<>Bitmap.Height) then
  begin
    WorkingBitmap := TIEBitmap.Create(DstWidth, DstHeight, Bitmap.PixelFormat);
    _IEResampleIEBitmap(Bitmap, WorkingBitmap, ResampleFilter, nil, nil);
  end
  else
    WorkingBitmap := Bitmap;

  negDstX := 0;
  negDstY := 0;

  if DstX<0 then
  begin
    negDstX := -DstX;
    DstX := 0;
  end;
  if DstY<0 then
  begin
    negDstY := -DstY;
    DstY := 0;
  end;

  w := imin(fWidth, WorkingBitmap.Width+DstX-negDstX);
  h := imin(fHeight, WorkingBitmap.Height+DstY-negDstY);

  for i:=DstY to h-1 do
  begin

    prgb0 := Scanline[i]; inc(prgb0, DstX);
    palpha0 := AlphaChannel.ScanLine[i]; inc(palpha0, DstX);
    prgb1 := WorkingBitmap.Scanline[i-DstY+negDstY]; inc(prgb1, negDstX);
    palpha1 := WorkingBitmap.AlphaChannel.Scanline[i-DstY+negDstY]; inc(palpha1, negDstX);

    for j:=DstX to w-1 do
    begin
      aa := palpha0^ / 255;
      bb := imin(palpha1^, Transparency) / 255;
      opt1 := (1 - bb) * aa;
      cc := bb + opt1;

      vv.r := prgb0^.r;
      vv.g := prgb0^.g;
      vv.b := prgb0^.b;
      IEBlend(prgb1^, vv, Operation, i);

      if cc<>0 then
      begin
        r := round((bb * vv.r + opt1 * prgb0^.r) / cc);
        g := round((bb * vv.g + opt1 * prgb0^.g) / cc);
        b := round((bb * vv.b + opt1 * prgb0^.b) / cc);
        if r<0 then prgb0^.r := 0 else if r>255 then prgb0^.r := 255 else prgb0^.r := r;
        if g<0 then prgb0^.g := 0 else if g>255 then prgb0^.g := 255 else prgb0^.g := g;
        if b<0 then prgb0^.b := 0 else if b>255 then prgb0^.b := 255 else prgb0^.b := b;
      end
      else
        prgb0^:=vv;

      palpha0^ := round(cc*255);

      inc(prgb0);
      inc(prgb1);
      inc(palpha0);
      inc(palpha1);
    end;
  end;

  if WorkingBitmap<>Bitmap then
    WorkingBitmap.Free;
end;

procedure TIEBitmap.SetOrigin(value:TIEBitmapOrigin);
begin
  if fOrigin = value then
    exit;
  _FlipEx(self, fdVertical);
  AdjustCanvasOrientation;
  fOrigin := value;
end;


{!!
<FS>TIEBitmap.GetHash

<FM>Declaration<FC>
function GetHash(Algorithm:<A TIEHashAlgorithm> = iehaMD5):AnsiString;

<FM>Description<FN>
Calculates the hash (using the specified hash algorithm) of the bitmap and returns the string representation of the hash.

<FM>Example<FC>

// calculates MD5 hash of input.jpg raster bitmap
ImageEnView1.IO.LoadFromFile('input.jpg');
ShowMessage( ImageEnView1.IEBitmap.GetHash() );

// calculates MD5 hash of input.jpg
with TIEHashStream.Create() do
begin
  LoadFromFile('input.jpg');
  ShowMessage( GetHash() );
end;
!!}
{$ifdef IEINCLUDEHASHSTREAM}
function TIEBitmap.GetHash(Algorithm:TIEHashAlgorithm):AnsiString;
var
  hashStream:TIEHashStream;
  i:integer;
  rowbuf:pointer;
begin
  hashStream := TIEHashStream.Create(Algorithm, false);
  try

    // hash of pixmap
    for i:=fHeight-1 downto 0 do
    begin
      rowbuf := GetRow(i);
      try
        hashStream.Write(pbyte(rowbuf)^, fRowLen);
      finally
        FreeRow(i);
      end;
    end;

    if PixelFormat = ie8p then
      // hash of colormap
      hashStream.Write(pbyte(fRGBPalette)^, sizeof(TRGB)*fRGBPaletteLen);

    result := hashStream.GetHash();

  finally
    hashStream.Free;
  end;
end;
{$endif}


// end of TIEBitmap
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


procedure IEDrawHint(Canvas: TCanvas; var x, y: integer; const ss: string; Font: TFont; Brush: TBrush; var SaveBitmap: TBitmap; MaxWidth, MaxHeight: integer; Border1, Border2: TColor);
const
  ox = 6;
  oy = 6;
var
  tw, th: integer;
begin
  Canvas.Font.Assign(Font);
  Canvas.Brush.Assign(Brush);
  tw := Canvas.TextWidth(ss) + 6 + ox;
  th := Canvas.TextHeight(ss) + 6 + oy;
  if x < 0 then
    x := 0;
  if y < 0 then
    y := 0;
  x := imin(x, MaxWidth - 1 - tw);
  y := imin(y, MaxHeight - 1 - th);
  SaveBitmap.PixelFormat := pf24bit;
  SaveBitmap.Width := tw;
  SaveBitmap.Height := th;
  SaveBitmap.Canvas.CopyMode := cmSrcCopy;
  SaveBitmap.Canvas.CopyRect(rect(0, 0, tw, th), Canvas, rect(x, y, x + tw, y + th));
  canvas.FillRect(rect(x + ox, y + oy, x + tw, y + th));
  IEDraw3DRect(Canvas, x + ox, y + oy, x + tw - 1, y + th - 1, Border1, Border2);
  Canvas.TextOut(x + 3 + ox, y + 3 + oy, string(ss));
end;

procedure IEDrawHint2(Canvas: TCanvas; var x, y: integer; const ss: string; const minText:string);
const
  ox = 6;
  oy = 6;
var
  tw, th: integer;
  iec:TIECanvas;
begin
  iec:=TIECanvas.Create(Canvas,true,true);
  iec.Font.Name:='Arial';
  iec.Font.Size:=9;
  iec.Font.Color:=clBlack;
  iec.Brush.Color:=$0060FFFF;
  iec.Brush.Style:=bsSolid;
  iec.Brush.Transparency:=128;
  tw := imax( iec.TextWidth(ss) + 6 + ox , iec.TextWidth(minText) + 6 + ox );
  th := iec.TextHeight(ss) + 6 + oy;
  if x < 0 then
    x := 0;
  if y < 0 then
    y := 0;
  iec.FillRect(rect(x + ox, y + oy, x + tw, y + th));
  IEDraw3DRect2(iec, x + ox, y + oy, x + tw - 1, y + th - 1, clWhite, clGray);
  iec.Brush.Style:=bsClear;
  iec.TextOut(x + 3 + ox, y + 3 + oy, ss);
  iec.Free;
end;

function IEDrawDibClose(hdd: hDrawDib): Boolean;
begin
  result := DrawDibClose(hdd);
end;

function IEDrawDibDraw(hdd: hDrawDib; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer; var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer; wFlags: UInt): Boolean;
begin
  result := DrawDibDraw(hdd, hDC, xDst, yDst, dxDst, dyDst, lpbi, Bits, xSrc, ySrc, dxSrc, dySrc, wFlags);
end;

function IEDrawDibOpen: hDrawDib;
begin
  result := DrawDibOpen;
end;

function IEDrawDibRealize(hdd: hDrawDib; hDC: THandle; fBackground: Bool): UInt;
begin
  result := DrawDibRealize(hdd, hDC, fBackground);
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// TIETagsHandler

constructor TIETagsHandler.Create;
begin
  inherited;
  fUnparsedData := nil;
  fUnparsedDataLength := 0;
  fData := TMemoryStream.Create;
  fTIFFEnv.Intel := true;
  fTIFFEnv.Stream := fData;
  fTIFFEnv.StreamBase := 0;
  fTIFFEnv.NumTags := 0;
  fTIFFEnv.IFD := nil;
  fEXIFMakerInfo.signature := '';
  fEXIFMakerInfo.base := iemnAbsolute;
  fEXIFMakerInfo.headerType := iemnNONE;
  fEXIFMakerInfo.byteOrder := ieboFromEXIF;
end;

destructor TIETagsHandler.Destroy;
begin
  Clear;
  fData.Free;
  inherited;
end;

procedure TIETagsHandler.Clear;
begin
  if fTIFFEnv.IFD<>nil then
    freemem(fTIFFEnv.IFD);
  fTIFFEnv.IFD := nil;

  if assigned(fUnparsedData) then
    freemem(fUnparsedData);
  fUnparsedData := nil;
  fUnparsedDataLength := 0;

  fEXIFMakerInfo.signature := '';
  fEXIFMakerInfo.base := iemnAbsolute;
  fEXIFMakerInfo.headerType := iemnNONE;
  fEXIFMakerInfo.byteOrder := ieboFromEXIF;

  fTIFFEnv.Intel := true;
  fTIFFEnv.StreamBase := 0;
  fTIFFEnv.NumTags := 0;

  fData.Clear;

end;

procedure TIETagsHandler.Assign(source:TIETagsHandler);
begin
  Clear;
  IECopyFrom(fData, source.fData, 0);
  Update;
  if assigned(source.fUnparsedData) then
  begin
    fUnparsedDataLength := source.fUnparsedDataLength;
    getmem(fUnparsedData, fUnparsedDataLength);
    CopyMemory(fUnparsedData, source.fUnparsedData, fUnparsedDataLength);
  end;
  fEXIFMakerInfo := source.fEXIFMakerInfo;
end;

// find EXIF Maker note type and bypass header
procedure TIETagsHandler.CheckHeader;
const
  devices:array [0..8] of TIEEXIFMakerNoteDeviceInfo = (
    (signature:'';                 base:iemnAbsolute;   headerType:iemnNONE;      byteOrder:ieboFromEXIF),       // default
    (signature:'SONY CAM '#0#0#0;  base:iemnAbsolute;   headerType:iemnNONE;      byteOrder:ieboFromEXIF),       // Maker1
    (signature:'SONY DSC '#0#0#0;  base:iemnAbsolute;   headerType:iemnNONE;      byteOrder:ieboFromEXIF),       // Maker2
    (signature:'Nikon'#0#2#16#0#0; base:iemnTIFFHeader; headerType:iemnTIFF;      byteOrder:ieboFromTIFFHeader), // Maker3
    (signature:'QVC'#0#0#0;        base:iemnAbsolute;   headerType:iemnNONE;      byteOrder:ieboBigEndian),      // Maker4
    (signature:'EPSON'#0#1#0;      base:iemnAbsolute;   headerType:iemnNONE;      byteOrder:ieboFromEXIF),       // Maker5
    (signature:'Nikon'#0#1#0;      base:iemnAbsolute;   headerType:iemnNONE;      byteOrder:ieboFromEXIF),       // Maker6
    (signature:'Panasonic'#0#0#0;  base:iemnAbsolute;   headerType:iemnNONE;      byteOrder:ieboFromEXIF),       // Maker7
    (signature:'FUJIFILM';         base:iemnTIFFHeader; headerType:iemnIFDOFFSET; byteOrder:ieboLittleEndian)    // Maker8
  );
var
  i:integer;
begin
  fEXIFMakerInfo := devices[0]; // the default
  for i:=1 to High(devices) do
    if CompareMem(@devices[i].signature[1], fUnparsedData, imin(fUnparsedDataLength, length(devices[i].signature))) then
    begin
      fEXIFMakerInfo := devices[i];
      break;
    end;
end;

procedure TIETagsHandler.ReadFromStream(stream:TStream; size:integer; littleEndian:boolean);
const
  SZ:array [0..12] of integer=(
      1,  // 0 = unknown (assume one byte)
      1,  // 1 = byte (8 bit)
      1,  // 2 = ascii (8 bit)
      2,  // 3 = short (16 bit)
      4,  // 4 = long (32 bit)
      8,  // 5 = rational (64 bit)
      1,  // 6 = signed byte (8 bit)
      1,  // 7 = undefined (8 bit)
      2,  // 8 = signed short (16 bit)
      4,  // 9 = signed long (32 bit)
      8,  // 10 = signed rational (64 bit)
      4,  // 11 = ieee float (32 bit)
      8   // 12 = ieee double (64 bit)
      );
var
  i, z: integer;
  buffer:PAnsiChar;
  tagscount:word;
  tag:PTIFFTAG;
  good:boolean;
  datapos:dword;
  datasize:integer;
  tagpos:dword;
  basePos:int64;
  bufferPos:integer;
  dpos:integer;
  headPos:int64;
  dw:dword;
begin
  Clear;
  good := false;
  dpos := 0;
  headPos := 0;
  getmem(buffer, size);

  try

    basePos := stream.Position;

    stream.Read(buffer^, size);
    bufferPos := 0;
    UnparsedData := pointer(buffer);
    UnparsedDataLength := size;
    if size<sizeof(word) then
      exit;

    CheckHeader;

    inc(bufferPos, length(fEXIFMakerInfo.signature));

    case fEXIFMakerInfo.headerType of
      iemnTIFF:
        begin
          // read header as TIFF header
          headPos := bufferPos;
          CopyMemory(@fEXIFMakerInfo.TIFFHeader, @buffer[bufferPos], sizeof(TTIFFHeader));
          inc(bufferPos, sizeof(TTIFFHeader));
        end;
      iemnIFDOFFSET:
        begin
          // read IFD offset and move
          CopyMemory(@dw, @buffer[bufferPos], sizeof(dword));
          inc(bufferPos, dw-8);
        end;
    end;

    case fEXIFMakerInfo.byteOrder of
      ieboFromTIFFHeader: littleEndian := fEXIFMakerInfo.TIFFHeader.Id = $4949;
      ieboLittleEndian:   littleEndian := true;
      ieboBigEndian:      littleEndian := false;
    end;

    tagscount := IECSwapWord(pword(@buffer[bufferPos])^, not littleEndian);
    inc(bufferPos, sizeof(word));
    if (tagscount>256) or (size<sizeof(TTIFFTAG)*tagscount) then
      exit; // maximum 256 tags (it is very large...)
    Data.Write(tagscount, sizeof(word));
    tagpos := Data.Position;
    datapos := tagpos + sizeof(TTIFFTAG)*tagscount;
    for i:=0 to tagscount-1 do
    begin
      tag := PTIFFTAG( @buffer[bufferPos] );
      tag^.IdTag := IECSwapWord(tag^.IdTag, not littleEndian);
      tag^.DataType := IECSwapWord(tag^.DataType, not littleEndian);
      tag^.DataNum := IECSwapDWord(tag^.DataNum, not littleEndian);
      tag^.DataPos := IECSwapDWord(tag^.DataPos, not littleEndian);
      if tag^.DataType < High(SZ) then
        datasize := SZ[tag^.DataType]
      else
        datasize := 1; // unknown data type, assume one byte per item
      z := tag^.DataNum*datasize;  // size in bytes
      if z>4 then
      begin
        case fEXIFMakerInfo.base of
          iemnAbsolute:      dpos := tag^.DataPos-basePos;
          iemnTIFFHeader:    dpos := tag^.DataPos+headPos;
        end;
        if (dpos<0) or (dpos>=size) then
        begin
          // invalid data position, make tag invalid
          tag^.DataNum := 0;
          tag^.DataPos := 0;
        end
        else
        begin
          tag^.DataPos := datapos;
          Data.Position := datapos;             // go to position to write tag data
          Data.Write(pbyte(@buffer[dpos])^, z); // write tag data
          datapos := Data.Position;             // save tag data position for next writing
        end;
      end;
      // write the tag
      Data.Position := tagpos;
      Data.Write(tag^, sizeof(TTIFFTAG));
      tagpos := Data.Position;
      // go to next tag to read
      inc(bufferPos, sizeof(TTIFFTAG));
    end;
    Update;
    good:=true;

  finally
    if not good then
      Clear;
  end;
end;

// returns written stream size
function TIETagsHandler.WriteToStream(stream:TStream):integer;
const
  SZ:array [0..12] of integer=(
      1,  // 0 = unknown (assume one byte)
      1,  // 1 = byte (8 bit)
      1,  // 2 = ascii (8 bit)
      2,  // 3 = short (16 bit)
      4,  // 4 = long (32 bit)
      8,  // 5 = rational (64 bit)
      1,  // 6 = signed byte (8 bit)
      1,  // 7 = undefined (8 bit)
      2,  // 8 = signed short (16 bit)
      4,  // 9 = signed long (32 bit)
      8,  // 10 = signed rational (64 bit)
      4,  // 11 = ieee float (32 bit)
      8   // 12 = ieee double (64 bit)
      );
var
  i, z:integer;
  tagscount:word;
  tag:TTIFFTAG;
  indexPos_read, indexPos_write:integer;
  dataPos_write:integer;
  datasize:integer;
  dw:dword;
  ww:word;
  streamBase:int64;
  littleEndian:boolean;
begin

  streamBase := stream.Position;

  stream.Write(fEXIFMakerInfo.signature[1], length(fEXIFMakerInfo.signature));

  littleEndian := true;

  if fEXIFMakerInfo.headerType = iemnTIFF then
  begin
    // prepare and write TIFF header
    littleEndian := fEXIFMakerInfo.TIFFHeader.Id = $4949;
    case fEXIFMakerInfo.base of
      iemnAbsolute:   fEXIFMakerInfo.TIFFHeader.PosIFD := stream.Position + length(fEXIFMakerInfo.signature) + sizeof(TTIFFHeader);
      iemnTIFFHeader: fEXIFMakerInfo.TIFFHeader.PosIFD := sizeof(TTIFFHeader);
    end;
    fEXIFMakerInfo.TIFFHeader.PosIFD := IECSwapDWord(fEXIFMakerInfo.TIFFHeader.PosIFD, not littleEndian);
    stream.Write(fEXIFMakerInfo.TIFFHeader, sizeof(TTIFFHeader));
  end;

  Data.Position := 0;
  Data.Read(tagscount, 2);

  // write new tags count
  ww := IECSwapWord(tagscount, not littleEndian);
  stream.Write(ww, 2);

  indexPos_read := 2;
  indexPos_write := stream.Position;
  dataPos_write := stream.Position + tagscount*sizeof(TTIFFTAG) + 4; // +4 = next IFD pointer

  for i:=0 to tagscount-1 do
  begin
    Data.Position := indexPos_read;
    Data.Read(tag, sizeof(TTIFFTAG));
    inc(indexPos_read, sizeof(TTIFFTAG));
    if tag.DataType <= high(SZ) then
      datasize := SZ[tag.DataType]
    else
      datasize := 1;  // unknown data size, assume 1 byte per item
    z := tag.DataNum * datasize;
    if z>4 then
    begin
      Data.Position := tag.DataPos;
      case fEXIFMakerInfo.base of
        iemnAbsolute:   tag.DataPos := dataPos_write;
        iemnTIFFHeader: tag.DataPos := dataPos_write - streamBase - length(fEXIFMakerInfo.signature);
      end;
      stream.Position := dataPos_write;
      if (Data.Position+z <= Data.Size) and (z > 0) then // 3.0.2
        IECopyFrom(stream, Data, z);
      inc(dataPos_write, z);
      if (dataPos_write and $1)<>0 then
        inc(dataPos_write);
    end;
    tag.IdTag := IECSwapWord(tag.IdTag, not littleEndian);
    tag.DataType := IECSwapWord(tag.DataType, not littleEndian);
    tag.DataNum := IECSwapDWord(tag.DataNum, not littleEndian);
    tag.DataPos := IECSwapDWord(tag.DataPos, not littleEndian);
    stream.Position := indexPos_write;
    stream.Write(tag, sizeof(TTIFFTAG));
    inc(indexPos_write, sizeof(TTIFFTAG));
  end;

  // next IFD (always none)
  dw := 0;
  stream.Position := indexPos_write;
  stream.Write(dw, sizeof(dword));

  result := dataPos_write - streamBase;
  stream.Position := dataPos_write;
  if result>65000 then
  begin
    // abort
    stream.Position := streamBase;
    result := 0;
  end;

end;

procedure TIETagsHandler.SetUnparsedData(value:pointer);
begin
  if assigned(fUnparsedData) then
    freemem(fUnparsedData);
  fUnparsedData := value;
  if fUnparsedData = nil then
    fUnparsedDataLength := 0;
end;

procedure TIETagsHandler.Update;
var
  w:word;
  i:integer;
begin
  if fData.Size>0 then
  begin
    fData.Position:=0;
    fData.Read(w,sizeof(word));
    fTIFFEnv.NumTags:=w;
    if fTIFFEnv.IFD<>nil then
      freemem(fTIFFEnv.IFD);
    fTIFFEnv.IFD := nil;
    getmem(fTIFFEnv.IFD, w*sizeof(TTIFFTAG));
    for i:=0 to w-1 do
      fData.Read(fTIFFEnv.IFD[i], sizeof(TTIFFTAG));
  end;
end;

{!!
<FS>TIETagsHandler.GetMiniString

<FM>Declaration<FC>
function GetMiniString(Tag: integer): AnsiString;

<FM>Description<FN>
Returns the specified tag as a string of 4 bytes.
!!}
function TIETagsHandler.GetMiniString(Tag: integer): AnsiString;
begin
  result := TIFFReadMiniString(fTIFFEnv, Tag);
end;

{!!
<FS>TIETagsHandler.GetString

<FM>Declaration<FC>
function GetString(Tag: integer): AnsiString;

<FM>Description<FN>
Returns the specified tag as string.
!!}
function TIETagsHandler.GetString(Tag: integer): AnsiString;
begin
  result := TIFFReadString(fTIFFEnv, Tag);
end;

{!!
<FS>TIETagsHandler.GetRawData

<FM>Declaration<FC>
function GetRawData(Tag: integer): pointer;

<FM>Description<FN>
Returns the specified tag as a raw bytes buffer.
!!}
function TIETagsHandler.GetRawData(Tag: integer): pointer;
var
  Size: integer;
begin
  result := TIFFReadRawData(fTIFFEnv, Tag, Size);
end;

{!!
<FS>TIETagsHandler.GetIntegerArray

<FM>Declaration<FC>
function GetIntegerArray(Tag: integer; var ar: <A PDWordArray>): integer;

<FM>Description<FN>
Returns the speicifed tag as an array of integers.
!!}
function TIETagsHandler.GetIntegerArray(Tag: integer; var ar: PDWordArray): integer;
begin
  result := TIFFReadArrayIntegers(fTIFFEnv, ar, Tag);
end;

{!!
<FS>TIETagsHandler.GetIntegerIndexed

<FM>Declaration<FC>
function GetIntegerIndexed(Tag: integer; index: integer): integer;

<FM>Description<FN>
Returns the specified tag as an array of integers.
!!}
function TIETagsHandler.GetIntegerIndexed(Tag: integer; index: integer): integer;
begin
  result := TIFFReadIndexValN(fTIFFEnv, Tag, index, 0);
end;

{!!
<FS>TIETagsHandler.GetRationalIndexed

<FM>Declaration<FC>
function GetRationalIndexed(Tag:integer; index:integer; defVal:double = 0.0): double;

<FM>Description<FN>
Returns the specified tag as an array of doubles.
!!}
function TIETagsHandler.GetRationalIndexed(Tag:integer; index:integer; defVal:double):double;
begin
  result := TIFFReadRationalIndex(fTIFFEnv, Tag, index, defVal);
end;

{!!
<FS>TIETagsHandler.GetRational

<FM>Declaration<FC>
function GetRational(Tag: integer; defaultValue:double = 0): double;

<FM>Description<FN>
Returns the specified tag as double.
!!}
function TIETagsHandler.GetRational(Tag:integer; defaultValue:double): double;
begin
  result := TIFFReadSingleRational(fTIFFEnv, Tag, defaultValue);
end;

{!!
<FS>TIETagsHandler.GetInteger

<FM>Declaration<FC>
function GetInteger(Tag: integer): integer;

<FM>Description<FN>
Returns the specified tag as integer.
!!}
function TIETagsHandler.GetInteger(Tag: integer): integer;
begin
  result := TIFFReadSingleValDef(fTIFFEnv, tag, 0);
end;

{!!
<FS>TIETagsHandler.TagLength

<FM>Declaration<FC>
function TagLength(Tag: integer): integer;

<FM>Description<FN>
Returns the tag length in bytes.
!!}
function TIETagsHandler.TagLength(Tag: integer): integer;
begin
  result := TIFFGetDataLength(fTIFFEnv, Tag);
end;

{!!
<FS>TIETagsHandler.TagExists

<FM>Declaration<FC>
function TagExists(Tag: integer): boolean;

<FM>Description<FN>
Returns True if the specified tag exists.
!!}
function TIETagsHandler.TagExists(Tag: integer): boolean;
begin
  result := TIFFFindTAG(Tag, fTIFFEnv) > -1;
end;


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// TIETIFTagsReader

{!!
<FS>TIETIFTagsReader.GetMiniString

<FM>Declaration<FC>
function GetMiniString(Tag:integer):AnsiString;

<FM>Description<FN>
Returns a string value (maximum four characters) for the specified Tag number.
!!}
function TIETIFTagsReader.GetMiniString(Tag: integer): AnsiString;
begin
  result := TIFFReadMiniString(fTIFFEnv, Tag);
end;


{!!
<FS>TIETIFTagsReader.GetString

<FM>Declaration<FC>
function GetString(Tag:integer):AnsiString;

<FM>Description<FN>
Returns a string value for the specified Tag number.
!!}
function TIETIFTagsReader.GetString(Tag: integer): AnsiString;
begin
  result := TIFFReadString(fTIFFEnv, Tag);
end;

{!!
<FS>TIETIFTagsReader.GetRawData

<FM>Declaration<FC>
function GetRawData(Tag:integer):pointer;

<FM>Description<FN>
Returns a raw buffer for the specified Tag number. You have to free the buffer using FreeMem.
!!}
function TIETIFTagsReader.GetRawData(Tag: integer): pointer;
var
  Size: integer;
begin
  result := TIFFReadRawData(fTIFFEnv, Tag, Size);
end;

{!!
<FS>TIETIFTagsReader.GetIntegerArray

<FM>Declaration<FC>
function GetIntegerArray(Tag:integer; var ar:<A pintegerarray>):integer;

<FM>Description<FN>
Returns an array of integers for the specified Tag number.
!!}
function TIETIFTagsReader.GetIntegerArray(Tag: integer; var ar: PDWordArray): integer;
begin
  result := TIFFReadArrayIntegers(fTIFFEnv, ar, Tag);
end;

{!!
<FS>TIETIFTagsReader.GetIntegerIndexed

<FM>Declaration<FC>
function GetIntegerIndexed(Tag:integer; index:integer):integer;

<FM>Description<FN>
Returns the indexed integer value for the specified Tag number.
!!}
function TIETIFTagsReader.GetIntegerIndexed(Tag: integer; index: integer): integer;
begin
  result := TIFFReadIndexValN(fTIFFEnv, Tag, index, 0);
end;

{!!
<FS>TIETIFTagsReader.GetRationalIndexed

<FM>Declaration<FC>
function GetRationalIndexed(Tag:integer; index:integer; defVal:double=0.0):double;

<FM>Description<FN>
Returns the indexed double (rational) value for the specified Tag number.
!!}
function TIETIFTagsReader.GetRationalIndexed(Tag:integer; index:integer; defVal:double): double;
begin
  result := TIFFReadRationalIndex(fTIFFEnv, Tag, index, defVal);
end;

{!!
<FS>TIETIFTagsReader.GetRational

<FM>Declaration<FC>
function GetRational(Tag:integer; defaultValue:double = 0):double;

<FM>Description<FN>
Returns the double (rational) value for the specified Tag number.
!!}
function TIETIFTagsReader.GetRational(Tag:integer; defaultValue:double): double;
begin
  result := TIFFReadSingleRational(fTIFFEnv, Tag, defaultValue);
end;

{!!
<FS>TIETIFTagsReader.GetInteger

<FM>Declaration<FC>
function GetInteger(Tag:integer):integer;

<FM>Description<FN>
Returns the integer value for the specified Tag number.
!!}
function TIETIFTagsReader.GetInteger(Tag: integer): integer;
begin
  result := TIFFReadSingleValDef(fTIFFEnv, tag, 0);
end;

{!!
<FS>TIETIFTagsReader.TagLength

<FM>Declaration<FC>
function TagLength(Tag:integer):integer;

<FM>Description<FN>
For indexed tags TagLength returns the tags count.
!!}
function TIETIFTagsReader.TagLength(Tag: integer): integer;
begin
  result := TIFFGetDataLength(fTIFFEnv, Tag);
end;

{!!
<FS>TIETIFTagsReader.TagExists

<FM>Declaration<FC>
function TagExists(Tag:integer):boolean;

<FM>Description<FN>
TagExists returns True if the specified tag exists.
!!}
function TIETIFTagsReader.TagExists(Tag: integer): boolean;
begin
  result := TIFFFindTAG(Tag, fTIFFEnv) > -1;
end;

{!!
<FS>TIETIFTagsReader.CreateFromFile

<FM>Declaration<FC>
constructor CreateFromFile(const FileName:string; ImageIndex:integer);

<FM>Description<FN>
This constructor loads the tags from a file, at the ImageIndex page (0 is the first page).
!!}
constructor TIETIFTagsReader.CreateFromFile(const FileName: string; ImageIndex: integer);
begin
  inherited;
  fFileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  fStream := fFileStream;
  TIFFLoadTags(fStream, fNumi, ImageIndex, fTIFFEnv);
end;

{!!
<FS>TIETIFTagsReader.CreateFromStream

<FM>Declaration<FC>
constructor CreateFromStream(Stream:TStream; ImageIndex:integer);

<FM>Description<FN>
This constructor loads the tags from a stream, at the ImageIndex page (0 is the first page).
!!}
constructor TIETIFTagsReader.CreateFromStream(Stream: TStream; ImageIndex: integer);
begin
  inherited;
  fFileStream := nil;
  fStream := Stream;
  TIFFLoadTags(fStream, fNumi, ImageIndex, fTIFFEnv);
end;

{!!
<FS>TIETIFTagsReader.CreateFromIFD

<FM>Declaration<FC>
constructor CreateFromIFD(tagReader: <A TIETIFTagsReader>; IFDTag: integer);

<FM>Description<FN>
Creates a new <A TIETIFTagsReader> from a tag. This is useful to read tiff trees.
!!}
constructor TIETIFTagsReader.CreateFromIFD(tagReader: TIETIFTagsReader; IFDTag: integer);
var
  pos: integer;
begin
  inherited;
  fFileStream := nil;
  fStream := tagReader.fStream;
  pos := tagReader.GetInteger(IFDTag);
  fillmemory(@fTIFFEnv, sizeof(TTIFFEnv), 0);
  fTIFFEnv.Stream := fStream;
  fTIFFEnv.Intel := tagReader.fTIFFEnv.Intel;
  fTIFFEnv.IFD := nil;
  TIFFReadIFD(0, pos, fTIFFEnv, fnumi);
end;

destructor TIETIFTagsReader.Destroy;
begin
  TIFFFreeTags(fTIFFEnv);
  if assigned(fFileStream) then
    FreeAndNil(fFileStream);
  //
  inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// TIETIFFHandler
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

{$ifdef IEINCLUDETIFFHANDLER}

procedure TIETIFFHandler.init;
begin
  fPages:=TList.Create;
  fIsMotorola := false;
  fVersion := $2A;
end;


constructor TIETIFFHandler.Create;
begin
  inherited Create;
  init;
end;


{!!
<FS>TIETIFFHandler.Create

<FM>Declaration<FC>
constructor Create(const FileName:string);
constructor Create(Stream:TStream);

<FM>Description<FN>
Creates TIETIFFHandler object reading image data from file or stream.
!!}
constructor TIETIFFHandler.Create(const FileName:string);
begin
  inherited Create;
  init;
  ReadFile(FileName);
end;


constructor TIETIFFHandler.Create(Stream:TStream);
begin
  inherited Create;
  init;
  ReadStream(Stream);
end;


destructor TIETIFFHandler.Destroy;
begin
  FreeData;
  FreeAndNil(fPages);
  inherited;
end;


function TIETIFFHandler.xword(value:word):word;
begin
  if fIsMotorola then
    result:=IESwapWord(value)
  else
    result:=value;
end;


function TIETIFFHandler.xdword(value:dword):dword;
begin
  if fIsMotorola then
    result:=IESWapDWord(value)
  else
    result:=value;
end;


{!!
<FS>TIETIFFHandler.ReadFile

<FM>Declaration<FC>
function ReadFile(const FileName:string):boolean;

<FM>Description<FN>
Reads the TIFF from file.
!!}
function TIETIFFHandler.ReadFile(const FileName:string):boolean;
var
  fs:TFileStream;
begin
  result:=false;
  if not IEFileExists(FileName) then
    exit;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := ReadStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;


// fills tgpos and tglen with position tag and length tag of tagCode, if it is a special tag (a data-tag with associated len-tag)
// otherwise sets tgpos=-1 and tglen=-1.
procedure TIETIFFHandler.CheckPairTag(tagCode:integer; var tgpos:integer; var tglen:integer);
begin
  tgpos := -1;
  tglen := -1;
  // canonical tiff tags
  case tagCode of
    273:  // StripOffsets
      begin
        tgpos := 273;
        tglen := 279;
      end;
    324:  // TileOffsets
      begin
        tgpos := 324;
        tglen := 325;
      end;
    513:  // JPEGInterchangeFormat
      begin
        tgpos := 513;
        tglen := 514;
      end;
  end;
  // HDPhoto tags
  if fVersion=$1BC then
    case tagCode of
      48320:  // ImageOffset and byte count
        begin
          tgpos := 48320;
          tglen := 48321;
        end;
      48322:  // AlphaOffset and byte count
        begin
          tgpos := 48322;
          tglen := 48323;
        end;
    end;
end;


function TIETIFFHandler.CheckPairTag(tagCode:integer):boolean;
var
  tgpos, tglen:integer;
begin
  CheckPairTag(tagCode, tgpos, tglen);
  result := tgpos<>-1;
end;


// returns true if tagCode is a sub-IFD (ie EXIF)
function TIETIFFHandler.CheckIFD(tagCode:integer):boolean;
begin
  case tagCode of
    34665,  // EXIF
    40965,  // Interoperability IFD (defined in EXIF)
    34853:  // GPS Info
      result := true;
    else
      result := false;
  end;
end;


// if Pages<>nil read multiple ifd (ifd must be nil)
// if ifd<>nil read a single ifd (Pages must be nil, insertPos don't care)
function TIETIFFHandler.ReadIFD(Stream:TStream; Pages:TList; ifd:TList; insertPos:integer):boolean;
var
  w:word;
  dw:dword;
  i,j,l:integer;
  subifd:TList;
  tag:PTIFFTAG;
  sz:integer;
  ip,lp:int64;
  buf:pointer;
  newlist:pintegerarray;
  tglen,tgpos:integer;
  datanum:integer;
begin
  result:=true;
  ip:=Stream.Position;

  if Pages<>nil then
  begin
    ifd := TList.Create;
    if insertPos=Pages.Count then
    begin
      // add page
      Pages.Add(ifd);
    end
    else
    begin
      // insert page
      Pages.Insert(insertPos, ifd);
    end;
  end;

  assert(ifd<>nil);

  Stream.Read(w, sizeof(word));  // tags count
  w := xword(w);

  // read tags
  for i:=0 to w-1 do
  begin
    new(tag);
    Stream.Read(tag^,sizeof(TTIFFTAG));
    datanum := xdword(tag^.DataNum);
    sz := IETAGSIZE[xword(tag^.DataType)]*datanum;
    if sz > 4 then
    begin
      lp := Stream.Position;

      if (sz < Stream.Size) then
      begin
        getmem(buf,sz);
        Stream.Position := xdword(tag^.DataPos);
        Stream.Read(pbyte(buf)^, sz);
        tag^.DataPos := xdword(int64(DWORD(buf)));
      end
      else
      begin
        // invalid tag
        dispose(tag);
        //tag := nil;
        break;  // different behavior. Since 3.1.2 stops reading first invalid tag.
      end;

      Stream.Position:=lp;
    end;
    if assigned(tag) and CheckIFD(xword(tag^.IdTag)) then
    begin
      // this is a SubIFD (ie EXIF)
      // note: actually a subifd could contain multiple pages (like thumbnail in EXIF, which is stored in second page).
      //       Here we ignore other pages other than first one.
      subifd := TList.Create;
      lp := Stream.Position;
      Stream.Position := xdword(tag^.DataPos);
      ReadIFD(Stream, nil, subifd, 0);
      Stream.Position := lp;
      tag^.DataPos := integer(pointer(subifd));
    end;
    if tag<>nil then
      ifd.Add( tag );
  end;

  // read sub tags (like StripOffsets and TileOffsets)
  lp:=Stream.Position;
  for i:=0 to ifd.Count-1 do
  begin
    tag:=ifd[i];
    CheckPairTag(xword(tag^.IdTag), tgpos, tglen);
    if tgpos>-1 then
    begin
      if xdword(tag^.DataNum)>1 then
        getmem(newlist, xdword(tag^.DataNum) * sizeof(integer))
      else
        newlist:=@tag^.DataPos;
      for j:=0 to xdword(tag^.DataNum)-1 do
      begin
        l:=GetIntegerByCode(ifd, tglen, j);  // length in bytes
        getmem(buf, l);
        Stream.Position:=GetIntegerByCode(ifd, tgpos, j);  // position
        Stream.Read(pbyte(buf)^, l);
        newlist[j]:=xdword(int64(DWORD(buf)));
      end;
      if IETAGSIZE[xword(tag^.DataType)]*xdword(tag^.DataNum) > 4 then
        freemem(pointer(xdword(tag^.DataPos)));
      tag^.DataType:=xword(4); // long type
      if xdword(tag^.DataNum)>1 then
        tag^.DataPos:=xdword(int64(DWORD(newlist))); // replace with the new list
    end;
  end;

  // convert from jpeg-6 to jpeg-7
  (*
  if (GetIntegerByCode(pageIndex,259,0)=6) and (FindTag(pageIndex,273)>-1) then
  begin
    DeleteTag(pageIndex, FindTag(pageIndex,519));
    DeleteTag(pageIndex, FindTag(pageIndex,520));
    DeleteTag(pageIndex, FindTag(pageIndex,521));
    DeleteTag(pageIndex, FindTag(pageIndex,512));
    DeleteTag(pageIndex, FindTag(pageIndex,273));
    DeleteTag(pageIndex, FindTag(pageIndex,279));
    SetValue(pageIndex,259,ttShort,7);
    ChangeTagCode(pageIndex,FindTag(pageIndex,513),273);
    ChangeTagCode(pageIndex,FindTag(pageIndex,514),279);
  end;
  *)
  // normalize jpeg-6 format
  if (GetIntegerByCode(ifd, 259, 0)=6) and (FindTag(ifd, 273)>-1) and (FindTag(ifd, 513)>-1) then
  begin
    DeleteTag(ifd, FindTag(ifd, 273), true); // stripoffsets
    DeleteTag(ifd, FindTag(ifd, 519), true); // jpegqtables
    DeleteTag(ifd, FindTag(ifd, 520), true); // jpegdctables
    DeleteTag(ifd, FindTag(ifd, 521), true); // jpegatables
  end;

  SortTags(ifd);

  Stream.Position:=lp;

  // next ifd
  Stream.Read(dw,sizeof(dword));
  dw:=xdword(dw);
  if (int64(dw)<>ip) and (dw<>0) and (dw<dword(Stream.Size)) and assigned(Pages) then
  begin
    Stream.Position:=dw;
    ReadIFD(Stream, Pages, nil, insertPos+1);
  end;
end;


{!!
<FS>TIETIFFHandler.ReadStream

<FM>Declaration<FC>
function ReadStream(Stream:TStream):boolean;

<FM>Description<FN>
Reads the TIFF from stream.
!!}
function TIETIFFHandler.ReadStream(Stream:TStream):boolean;
begin
  FreeData;
  result:=ReadHeader(Stream);
  if not result then exit;
  result:=ReadIFD(Stream, fPages, nil, 0);
end;


{!!
<FS>TIETIFFHandler.InsertTIFFStream

<FM>Declaration<FC>
function InsertTIFFStream(Stream:TStream; pageIndex:integer):boolean;

<FM>Description<FN>
Inserts a TIFF (even if multipage file) at specified page index.
The first page has pageIndex=0.
!!}
function TIETIFFHandler.InsertTIFFStream(Stream:TStream; pageIndex:integer):boolean;
begin
  result:=ReadHeader(Stream); // warning all files must have the same byte orders
  if not result then exit;
  result:=ReadIFD(Stream, fPages, nil, pageIndex);
end;


{!!
<FS>TIETIFFHandler.InsertTIFFFile

<FM>Declaration<FC>
function InsertTIFFFile(const FileName:string; pageIndex:integer):boolean;

<FM>Description<FN>
Inserts a TIFF (even if multipage file) at specified page index.
The first page has pageIndex=0.
!!}
function TIETIFFHandler.InsertTIFFFile(const FileName:string; pageIndex:integer):boolean;
var
  fs:TFileStream;
begin
  result:=false;
  if not IEFileExists(FileName) then
    exit;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := InsertTIFFStream(fs,pageIndex);
  finally
    FreeAndNil(fs);
  end;
end;


{!!
<FS>TIETIFFHandler.InsertPageAsFile

<FM>Declaration<FC>
function InsertPageAsFile(const FileName:string; pageIndex:integer):boolean;

<FM>Description<FN>
Inserts a supported file format (jpeg, bmp, ..) at the specified page index.
!!}
function TIETIFFHandler.InsertPageAsFile(const FileName:string; pageIndex:integer):boolean;
var
  fs:TFileStream;
begin
  result:=false;
  if not IEFileExists(FileName) then
    exit;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := InsertPageAsStream(fs,pageIndex);
  finally
    FreeAndNil(fs);
  end;
end;


{!!
<FS>TIETIFFHandler.InsertPageAsStream

<FM>Declaration<FC>
function InsertPageAsStream(Stream:TStream; pageIndex:integer):boolean;

<FM>Description<FN>
Inserts a supported file format (jpeg, bmp, ..) at the specified page index.
!!}
function TIETIFFHandler.InsertPageAsStream(Stream:TStream; pageIndex:integer):boolean;
var
  tmpie:TImageEnView;
  tmpStream:TMemoryStream;
begin
  tmpie:=TImageEnView.Create(nil);
  tmpie.IO.LoadFromStream( Stream );
  tmpStream:=TMemoryStream.Create;
  tmpStream.Size:=Stream.Size;
  tmpie.IO.SaveToStreamTIFF(tmpStream);
  tmpStream.Position:=0;
  result:=InsertTIFFStream( tmpStream, pageIndex );
  FreeAndNil(tmpStream);
  FreeAndNil(tmpie);
end;


{!!
<FS>TIETIFFHandler.InsertPageAsImage

<FM>Declaration<FC>
function InsertPageAsImage(viewer:TObject; pageIndex:integer):boolean;

<FM>Description<FN>
Inserts a loaded image at the specified index. Viewer must be a <A TImageEnView> object or <A TImageEnIO>.
!!}
function TIETIFFHandler.InsertPageAsImage(viewer:TObject; pageIndex:integer):boolean;
var
  tmpio:TImageEnIO;
  tmpStream:TMemoryStream;
begin
  result:=false;
  if viewer is TImageEnView then
    tmpio:=(viewer as TImageEnView).IO
  else if viewer is TImageEnIO then
    tmpio:=(viewer as TImageEnIO)
  else
    exit;

  tmpStream:=TMemoryStream.Create;
  tmpStream.Size:=1024*1024*3;
  tmpio.SaveToStreamTIFF(tmpStream);
  tmpStream.Position:=0;
  result:=InsertTIFFStream( tmpStream, pageIndex );
  FreeAndNil(tmpStream);
end;


function TIETIFFHandler.ReadHeader(Stream:TStream):boolean;
var
  fHeader:TTIFFHeader;
begin
  Stream.Read(fHeader,sizeof(TTIFFHeader));
  fIsMotorola := fHeader.Id = $4D4D;
  fVersion := xword(fHeader.Ver);
  result:= (fHeader.Id = $4949) or (fHeader.id = $4D4D);
  if result then
    Stream.Position:=xdword(fHeader.PosIFD);
end;


{!!
<FS>TIETIFFHandler.LittleEndian

<FM>Declaration<FC>
property LittleEndian:boolean;

<FM>Description<FN>
Returns true if file has little-endian byte order (Intel byte order). Returns false when it has big-endian (Motorola, PowerPC byte order).
It is not possible to change byte order.
!!}
function TIETIFFHandler.GetLittleEndian:boolean;
begin
  result := not fIsMotorola;
end;


{!!
<FS>TIETIFFHandler.FreeData

<FM>Declaration<FC>
procedure FreeData;

<FM>Description<FN>
Frees memory used by the object.
!!}
procedure TIETIFFHandler.FreeData;
begin
  while fPages.Count>0 do
    DeletePage(0);
  fPages.Clear;
end;


{!!
<FS>TIETIFFHandler.DeletePage

<FM>Declaration<FC>
procedure DeletePage(pageIndex:integer);

<FM>Description<FN>
Deletes the specified page.
!!}
procedure TIETIFFHandler.DeletePage(pageIndex:integer);
var
  ifd:TList;
begin
  ifd:=fPages[pageIndex];
  while ifd.Count>0 do
    DeleteTag(pageIndex, 0);
  ifd.Free;
  fPages.Delete(pageIndex);
end;


{!!
<FS>TIETIFFHandler.ExchangePage

<FM>Declaration<FC>
procedure ExchangePage(Index1, Index2:integer);

<FM>Description<FN>
Exchanges specified pages.
!!}
procedure TIETIFFHandler.ExchangePage(Index1, Index2:integer);
begin
  fPages.Exchange(Index1, Index2);
end;


{!!
<FS>TIETIFFHandler.MovePage

<FM>Declaration<FC>
procedure MovePage(CurIndex, NewIndex:integer);

<FM>Description<FN>
Moves specified page to a new position.
!!}
procedure TIETIFFHandler.MovePage(CurIndex, NewIndex:integer);
begin
  fPages.Move(CurIndex, NewIndex);
end;


{!!
<FS>TIETIFFHandler.InsertPage

<FM>Declaration<FC>
function InsertPage(pageIndex:integer = -1):integer;
function InsertPage(pageIndex:integer; sourceHandler:TIETIFFHandler; sourcePage:integer):integer;

<FM>Description<FN>
First overload inserts a new blank page at specified index.
Second overload inserts <FC>sourcePage<FN> from <FC>sourceHandler<FN> at specified index.
If <FC>pageIndex<FN> is -1 or equal to <A TIETIFFHandler.GetPagesCount> the page is added at end.
Returns the index of added page.
!!}
function TIETIFFHandler.InsertPage(pageIndex:integer):integer;
begin
  if (pageIndex<0) or (pageIndex>=fPages.Count) then
    result := fPages.Add(TList.Create)
  else
  begin
    fPages.Insert(pageIndex, TList.Create);
    result := pageIndex;
  end;
end;

function TIETIFFHandler.InsertPage(pageIndex:integer; sourceHandler:TIETIFFHandler; sourcePage:integer):integer;
var
  i:integer;
  tagCount:integer;
begin
  result := InsertPage(pageIndex);
  tagCount := sourceHandler.GetTagsCount(sourcePage);
  for i:=0 to tagCount-1 do
    CopyTag(sourcePage, i, sourceHandler, result);
end;


{!!
<FS>TIETIFFHandler.DeleteTag

<FM>Declaration<FC>
procedure DeleteTag(pageIndex:integer; tagIndex:integer);

<FM>Description<FN>
Deletes specified tag.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
procedure TIETIFFHandler.DeleteTag(pageIndex:integer; tagIndex:integer);
begin
  DeleteTag(pageIndex, tagIndex, true);
end;


procedure TIETIFFHandler.DeleteTag(ifd:TList; tagIndex:integer; checkOffsetTags:boolean);
var
  j:integer;
  tag:PTIFFTAG;
  sz:integer;
  datanum:integer;
  tagcode:integer;
  ptr:pointer;
  tgpos, tglen:integer;
  subifd:TList;
begin
  if tagIndex>=0 then
  begin
    tag:=ifd[tagIndex];
    datanum:=xdword(tag^.DataNum);
    tagcode:=xword(tag^.IdTag);

    if checkOffsetTags then
    begin
      CheckPairTag(xword(tag^.IdTag), tgpos, tglen);
      if tgpos>-1 then
        for j:=0 to datanum-1 do
        begin
          ptr := GetValueRAWEx(ifd[FindTag(ifd, tagCode)], j);
          ptr := pointer(xdword(pdword(ptr)^));
          freemem(ptr);
        end;
    end;

    if checkIFD(tagcode) then
    begin
      // this is an IFD
      subifd := pointer(tag^.DataPos);
      while subifd.Count>0 do
        DeleteTag(subifd, 0, true);
      subifd.Free;
    end
    else
    begin
      // normal tag, remove data if necessary
      sz:=IETAGSIZE[xword(tag^.DataType)]*datanum;
      if sz>4 then
        freemem(pointer(xdword(tag^.DataPos)));
    end;

    dispose(tag);
    ifd.Delete(tagIndex);
  end;
end;


procedure TIETIFFHandler.DeleteTag(pageIndex:integer; tagIndex:integer; checkOffsetTags:boolean);
var
  ifd:TList;
begin
  ifd:=fPages[pageIndex];
  DeleteTag(ifd, tagIndex, checkOffsetTags);
end;


function TIETIFFHandler.FindTag(ifd:TList; tagCode:integer):integer;
var
  i:integer;
begin
  result:=-1;
  for i:=0 to ifd.Count-1 do
    with PTIFFTAG(ifd[i])^ do
      if xword(IdTag)=tagCode then
      begin
        result:=i;
        break;
      end;
end;


{!!
<FS>TIETIFFHandler.FindTag

<FM>Declaration<FC>
function FindTag(pageIndex:integer; tagCode:integer):integer;

<FM>Description<FN>
Returns the tag index of the first tag which has specified tagCode.
If no tag is found, it returns -1.
!!}
function TIETIFFHandler.FindTag(pageIndex:integer; tagCode:integer):integer;
var
  ifd:TList;
begin
  result := -1;
  if pageIndex<fPages.Count then
  begin
    ifd := fPages[pageIndex];
    result := FindTag(ifd, tagCode);
  end;
end;


{!!
<FS>TIETIFFHandler.ChangeTagCode

<FM>Declaration<FC>
procedure ChangeTagCode(pageIndex:integer; tagIndex:integer; newCode:integer);

<FM>Description<FN>
Changes the tag code of an existing tag.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
procedure TIETIFFHandler.ChangeTagCode(pageIndex:integer; tagIndex:integer; newCode:integer);
var
  ifd:TList;
  tag:PTIFFTAG;
begin
  ifd:=fPages[pageIndex];
  tag:=ifd[tagIndex];
  if not CheckIFD(xword(tag^.IdTag)) and not CheckPairTag(xword(tag^.IdTag)) then // special tags cannot be changed to avoid mem leaks
    tag^.IdTag:=xword(newCode);
end;


function TIETIFFHandler.GetValueRAWEx(tag:PTIFFTAG; arrayIndex: integer): pointer;
var
  sz:integer;
  pt:pbyte;
begin
  sz:=IETAGSIZE[xword(tag^.DataType)]*xdword(tag^.DataNum);

  if sz>4 then
    pt:=pointer(xdword(tag^.DataPos))
  else
    pt:=@(tag^.DataPos);

  inc(pt, IETAGSIZE[xword(tag^.DataType)]*arrayIndex );
  result:=pt;
end;


// good also to read tags with only one value
function TIETIFFHandler.GetValueRAWEx(pageIndex:integer; tagindex: integer; arrayIndex: integer; var tagType:integer): pointer;
var
  ifd:TList;
  tag:PTIFFTAG;
begin
  ifd := fPages[pageIndex];
  tag := ifd[tagindex];
  result := GetValueRAWEx(tag, arrayIndex);
  tagType := xword(tag^.DataType);
end;


{!!
<FS>TIETIFFHandler.GetValueRAW

<FM>Declaration<FC>
function GetValueRAW(pageIndex:integer; tagIndex: integer; arrayIndex: integer): pointer;

<FM>Description<FN>
Returns a pointer to the tag value. arrayIndex is used only if the tag contains an array of values, otherwise it must be 0.
Use <A TIETIFFHandler.GetTagLength> or <A TIETIFFHandler.GetTagLengthInBytes> to know the size of buffer.
The returned buffer must not be freed.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetValueRAW(pageIndex:integer; tagIndex: integer; arrayIndex: integer): pointer;
var
  tagType:integer;
begin
  result:=GetValueRAWEx(pageIndex,tagIndex,arrayIndex,tagType);
end;


function TIETIFFHandler.GetIntegerByCode(page:integer; tagcode:integer; idx:integer):integer;
var
  ifd:TList;
begin
  ifd := fPages[page];
  result := GetIntegerByCode(ifd, tagcode, idx);
end;


function TIETIFFHandler.GetIntegerByCode(ifd:TList; tagcode:integer; idx:integer):integer;
var
  tagindex:integer;
begin
  result:=0;
  tagindex:=FindTAG(ifd, tagcode);
  if tagindex>-1 then
    result:=GetInteger(ifd, tagindex, idx);
end;


{!!
<FS>TIETIFFHandler.WriteFile

<FM>Declaration<FC>
procedure WriteFile(const FileName:string; pageIndex:integer = -1);

<FM>Description<FN>
Saves back the modified TIFF.
<FC>page<FN> specifies the page index to write. -1 = all pages.
!!}
procedure TIETIFFHandler.WriteFile(const FileName:string; page:integer);
var
  fs: TFileStream;
begin
  fs := nil;
  try
    fs := TFileStream.Create(FileName, fmCreate);
    WriteStream(fs, page);
  finally
    FreeAndNil(fs);
  end;
end;


{!!
<FS>TIETIFFHandler.SaveTagToFile

<FM>Declaration<FC>
procedure SaveTagToFile(pageIndex:integer; tagIndex:integer; const fileName:string);

<FM>Description<FN>
Saves the content of a tag to file.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
procedure TIETIFFHandler.SaveTagToFile(pageIndex:integer; tagIndex:integer; const fileName:string);
var
  ifd:TList;
  tag:PTIFFTAG;
  datanum:integer;
  tgpos,tglen:integer;
  i,l,sz:integer;
  buf:pdwordarray;
  Stream:TFileStream;
begin
  if tagIndex>-1 then
  begin
    Stream:=TFileStream.Create(fileName,fmCreate);
    ifd:=fPages[pageIndex];
    tag:=ifd[tagIndex];
    datanum:=xdword(tag^.DataNum);
    CheckPairTag(xword(tag^.IdTag), tgpos, tglen);
    if tgpos>-1 then
    begin
      getmem(buf,datanum*sizeof(dword));
      for i:=0 to datanum-1 do
      begin
        l:=GetIntegerByCode(pageIndex,tglen,i);
        buf[i]:=xdword(Stream.Position);
        Stream.Write( pbyte(pointer(GetIntegerByCode(pageIndex,tgpos,i)))^, l );
      end;
      freemem(buf);
    end
    else
    begin
      sz:=IETAGSIZE[xword(tag^.DataType)]*datanum;
      if sz>4 then
        Stream.Write( pbyte(pointer(xdword(tag^.DataPos)))^, sz )
      else
        Stream.Write( tag^.DataPos,sz );
    end;
    FreeAndNil(Stream);
  end;
end;


function CompareTags(Item1, Item2: Pointer): Integer;
var
  i1,i2:PTIFFTAG;
begin
  i1:=Item1;
  i2:=Item2;
  if i1^.IdTag < i2^.IdTag then
    result:=-1
  else if i1^.IdTag = i2^.IdTag then
    result:=0
  else
    result:=1;
end;


procedure TIETIFFHandler.SortTags(pageIndex:integer);
begin
  if (pageIndex<fPages.Count) and assigned(fPages[pageIndex]) then
    SortTags(TList(fPages[pageIndex]));
end;

procedure TIETIFFHandler.SortTags(ifd:TList);
begin
  ifd.Sort( CompareTags );
end;


(*
procedure reorderTagsInStream(Stream:TStream);
var
  head:TTIFFHeader;
  IsMotorola:boolean;
  w:word;
  dw,dw2:dword;
  tags:TList;
  i:integer;
  tag:PTIFFTAG;
  function xword(value:word):word;
  begin
    if IsMotorola then
      result:=IESwapWord(value)
    else
      result:=value;
  end;
  function xdword(value:dword):dword;
  begin
    if IsMotorola then
      result:=IESWapDWord(value)
    else
      result:=value;
  end;
begin
  tags:=TList.Create;
  Stream.Position:=0;
  Stream.Read(head,sizeof(TTIFFHeader));
  IsMotorola := head.Id = $4D4D;
  dw:=xdword(head.PosIFD);
  repeat
    if dw=0 then
      break;
    Stream.Position:=dw;
    Stream.Read(w,sizeof(word));  // tags count
    w:=xword(w);
    for i:=0 to w-1 do
    begin
      new(tag);
      tags.Add(tag);
      Stream.Read(tag^,sizeof(TTIFFTAG));
    end;
    Stream.Read(dw2,sizeof(dword));
    tags.Sort( CompareTags );
    Stream.Position:=xdword(dw)+2;
    for i:=0 to w-1 do
    begin
      Stream.Write(PTIFFTAG(tags[i])^,sizeof(TTIFFTAG));
      dispose(tags[i]);
    end;
    tags.Clear;
    Stream.Read(dw,sizeof(dword));
    dw:=xdword(dw);
  until false;
  FreeAndNil(tags);
end;
*)


{!!
<FS>TIETIFFHandler.WriteStream

<FM>Declaration<FC>
procedure WriteStream(Stream:TStream; page:integer = -1);

<FM>Description<FN>
Saves back the modified TIFF.
<FC>page<FN> specifies the page index to write. -1 = all pages.
!!}
procedure TIETIFFHandler.WriteStream(Stream:TStream; page:integer);
var
  fHeader:TTIFFHeader;
  i:integer;
  dw:dword;
  dataPos:int64;
begin

  if fIsMotorola then
    fHeader.Id := $4D4D
  else
    fHeader.Id := $4949;
  fHeader.Ver := xword(fVersion); // 3.0.3
  fHeader.PosIFD := xdword(Stream.Position+sizeof(TTIFFHeader));
  Stream.Write(fHeader, sizeof(TTIFFHeader));

  if (page>-1) and (page<fPages.Count) then
  begin
    // write specified page
    SortTags(page);
    WriteIFD(Stream, fPages[page], dataPos);
  end
  else
  begin
    // write all pages
    for i:=0 to fPages.Count-1 do
    begin
      SortTags(i);
      WriteIFD(Stream, fPages[i], dataPos);

      // position of next IFD
      if i<fPages.Count-1 then
      begin
        dw := xdword(dataPos);
        Stream.Write(dw, sizeof(dword));
        Stream.Position := dataPos;
      end;
    end;
  end;

  // no more IFD
  dw := 0;
  Stream.Write(dw, sizeof(dword));

end;

function WordAlignStream(Stream:TStream):int64;
var
  b:byte;
begin
  result := Stream.Position;
  if (result and $1)<>0 then
  begin
    // word align offset
    inc(result);
    b := 0;
    Stream.Write(b, 1);
  end;
end;

procedure TIETIFFHandler.WriteIFD(Stream:TStream; ifd:TList; var dataPos:int64);

  procedure WriteTagData(ifd:TList; intag, outtag:PTIFFTAG);
  var
    i,l,sz:integer;
    buf:pdwordarray;
    tgpos,tglen:integer;
    datanum:integer;
    idtag:word;
    subifd:TList;
    p:int64;
    dw:dword;
  begin
    buf := nil;
    move(intag^, outtag^, sizeof(TTIFFTAG));
    datanum := xdword(intag^.DataNum);
    idtag := xword(intag^.IdTag);
    sz := IETAGSIZE[xword(intag^.DataType)]*datanum;

    try

      // check for offset tags
      CheckPairTag(idtag, tgpos, tglen);
      if tgpos>-1 then
      begin
        getmem(buf, datanum*sizeof(dword));
        for i:=0 to datanum-1 do
        begin
          l := GetIntegerByCode(ifd, tglen, i);
          buf[i] := xdword(Stream.Position);
          Stream.Write(pbyte(pointer(GetIntegerByCode(ifd, tgpos, i)))^, l);
        end;
        if datanum>1 then
          outtag^.DataPos := xdword(int64(DWORD(buf)))
        else
          move(buf[0], outtag^.DataPos, sizeof(dword));
      end;

      // check for IFD tags
      if CheckIFD(idtag) then
      begin
        subifd := pointer(intag^.DataPos);
        p := WordAlignStream(Stream);
        outtag^.DataPos := xdword(p);     // save start of SUB-IFD
        WriteIFD(Stream, subifd, p);      // "p" updated to the end of tag-data
        dw := 0;
        Stream.Write(dw, sizeof(dword));  // 0 = end of subifd
        Stream.Position := p;             // go to end of tag-data
      end;

      // writes actual tag data (now in "outtag")
      if sz>4 then
      begin
        p := WordAlignStream(Stream);
        Stream.Write(pbyte(pointer(xdword(outtag^.DataPos)))^, sz);
        outtag^.DataPos := xdword(p);
      end;

    finally
      if buf<>nil then
        freemem(buf);
    end;
  end;

var
  j,k,l:integer;
  p1:int64;
  wtag:TTIFFTAG;
  tag:PTIFFTAG;
  w:word;
  temptag:integer;
  ifdcount:integer;
  pw:pword;
begin
  ifdcount := ifd.Count;

  //if fdebug1 then ifdcount:=30;
  //if fdebug1 then dec(ifdcount);

  // bypass tag 273 when 513 exists (for jpeg compression)
  if (FindTag(ifd, 513)<>-1) and (FindTag(ifd, 273)=-1) then
    inc(ifdcount);

  // write ifd items count
  w := xword(ifdcount);
  Stream.Write(w, sizeof(word));

  //if fdebug1 then inc(ifdcount);

  // tags data will begin at "dataPos" position
  dataPos := Stream.Position+ifdcount*sizeof(TTIFFTAG)+sizeof(dword);

  temptag := -1;
  j := 0;
  while j<ifdCount do
  begin

    tag := ifd[j];
    p1 := Stream.Position;

    (*
    if fdebug1 and (tag^.IdTag=40965) then
    begin
      inc(j);
      continue;
    end;
    *)

    Stream.Position := dataPos;  // go to data position
    WriteTagData(ifd, tag, @wtag);

    // handles jpeg compression case
    if xword(wtag.IdTag)=513 then
    begin
      // we need to add the tag 273 (stripoffsets)
      // search for begin of jpeg-raw ($FFDA)
      pw := pword(pointer(GetIntegerByCode(ifd, 513, 0)));
      l := GetIntegerByCode(ifd, 514, 0);
      k := 0;
      while k<l do
      begin
        if pw^=$DAFF then
          break;
        inc(pbyte(pw));
        inc(k);
      end;
      SetValue(ifd, 273, ttLong, variant(xdword(xdword(wtag.DataPos) +dword(k))));
      temptag := FindTag(ifd, 273);
    end;

    dataPos := Stream.Position;  // save next tags-data position
    Stream.Position := p1;  // go to ifd-tag position
    Stream.Write(wtag, sizeof(TTIFFTAG));  // write tag

    inc(j);
  end;

  // remove temp tag
  if temptag<>-1 then
    DeleteTag(ifd, temptag, false);

end;


{!!
<FS>TIETIFFHandler.GetTagsCount

<FM>Declaration<FC>
function GetTagsCount(pageIndex:integer):integer;

<FM>Description<FN>
Gets the number of tags presents at specified page.
!!}
function TIETIFFHandler.GetTagsCount(pageIndex:integer):integer;
begin
  if (pageIndex<fPages.Count) and assigned(fPages[pageIndex]) then
    result:=TList(fPages[pageIndex]).Count
  else
    result:=0;
end;


{!!
<FS>TIETIFFHandler.GetPagesCount

<FM>Declaration<FC>
function GetPagesCount:integer;

<FM>Description<FN>
Gets the number of pages.
!!}
function TIETIFFHandler.GetPagesCount:integer;
begin
  result:=fPages.Count;
end;


{!!
<FS>TIETIFFHandler.GetTagCode

<FM>Declaration<FC>
function GetTagCode(pageIndex:integer; tagIndex:integer):integer;

<FM>Description<FN>
Gets the tag code (also named 'tag-id') indexed by tagIndex at specified page.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetTagCode(pageIndex:integer; tagIndex:integer):integer;
begin
  if (pageIndex<fPages.Count) and assigned(fPages[pageIndex]) then
    result:= xword( PTIFFTAG(TList(fPages[pageIndex])[tagIndex])^.IdTag )
  else
    result:=-1;
end;


{!!
<FS>TIETIFFHandler.GetTagType

<FM>Declaration<FC>
function GetTagType(pageIndex:integer; tagIndex:integer):<A TIETagType>;

<FM>Description<FN>
Gets the tag type of a tag.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetTagType(pageIndex:integer; tagIndex:integer):TIETagType;
begin
  if (pageIndex<fPages.Count) and assigned(fPages[pageIndex]) then
    result:= TIETagType( xword( PTIFFTAG(TList(fPages[pageIndex])[tagIndex])^.DataType ) )
  else
    result:=ttUnknown;
end;


{!!
<FS>TIETIFFHandler.GetTagLength

<FM>Declaration<FC>
function GetTagLength(pageIndex:integer; tagIndex:integer):integer;

<FM>Description<FN>
Gets the tag length of a tag. Look at tag type to know the size of each item.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetTagLength(pageIndex:integer; tagIndex:integer):integer;
begin
  if (pageIndex<fPages.Count) and assigned(fPages[pageIndex]) then
    result:= xdword( PTIFFTAG(TList(fPages[pageIndex])[tagIndex])^.DataNum )
  else
    result:=0;
end;


{!!
<FS>TIETIFFHandler.GetTagLengthInBytes

<FM>Declaration<FC>
function GetTagLengthInBytes(pageIndex:integer; tagIndex:integer):integer;

<FM>Description<FN>
Gets the tag length in bytes.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetTagLengthInBytes(pageIndex:integer; tagIndex:integer):integer;
begin
  if (pageIndex<fPages.Count) and assigned(fPages[pageIndex]) then
    with PTIFFTAG(TList(fPages[pageIndex])[tagIndex])^ do
      result:= IETAGSIZE[xword(DataType)]*xdword(DataNum)
  else
    result:=0;
end;


{!!
<FS>TIETIFFHandler.GetInteger

<FM>Declaration<FC>
function GetInteger(pageIndex:integer; tagIndex:integer; arrayIndex:integer):integer;

<FM>Description<FN>
Returns the tag value as Integer. arrayIndex is used only if the tag contains an array of values, otherwise it must be 0.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetInteger(pageIndex:integer; tagIndex:integer; arrayIndex:integer):integer;
var
  ifd:TList;
begin
  ifd := fPages[pageIndex];
  result := GetInteger(ifd, tagIndex, arrayIndex);
end;


function TIETIFFHandler.GetInteger(ifd:TList; tagIndex:integer; arrayIndex:integer):integer;
type
  pshortint=^shortint;
var
  ptr:pointer;
  tag:PTIFFTAG;
begin
  result := 0;
  tag := ifd[tagIndex];
  ptr := GetValueRAWEx(tag, arrayIndex);
  case xword(tag^.DataType) of
    1,2,7:  // byte,ascii,undefined
      result := pbyte(ptr)^;
    3:  // short
      result := xword(pword(ptr)^);
    4:  // long
      result := xdword(pdword(ptr)^);
    6:  // sbyte
      result := pshortint(ptr)^;
    8:  // sshort
      result := xword(psmallint(ptr)^);
    9:  // slong
      result := xdword(plongint(ptr)^);
  end;
end;


{!!
<FS>TIETIFFHandler.GetString

<FM>Declaration<FC>
function GetString(pageIndex:integer; tagIndex:integer):AnsiString;

<FM>Description<FN>
Returns the tag value as string.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetString(pageIndex:integer; tagIndex:integer):AnsiString;
var
  ptr:PAnsiChar;
  tagType,i,l:integer;
begin
  result:='';
  if tagIndex>-1 then
  begin
    ptr:=GetValueRAWEx(pageIndex,tagIndex,0,tagType);
    l:=GetTagLength(pageIndex,tagIndex);
    for i:=0 to l-1 do
    begin
      result:=result+ptr^;
      inc(ptr);
    end;
  end;
end;


{!!
<FS>TIETIFFHandler.GetFloat

<FM>Declaration<FC>
function GetFloat(pageIndex:integer; tagIndex:integer; arrayIndex:integer):double;

<FM>Description<FN>
Returns the tag value as floating point value. arrayIndex is used only if the tag contains an array of values, otherwise it must be 0.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetFloat(pageIndex:integer; tagIndex:integer; arrayIndex:integer):double;
var
  ptr:pointer;
  tagType:integer;
  num, den: dword;
  inum, iden: integer;
begin
  result:=0;
  ptr:=GetValueRAWEx(pageIndex,tagIndex,arrayIndex,tagType);
  case tagType of
    5:  // rational
      begin
        num:=xdword( pdwordarray(ptr)[0] );
        den:=xdword( pdwordarray(ptr)[1] );
        if den=0 then den:=1;
        result:=num/den;
      end;
    10: // srational
      begin
        inum:=xdword( pintegerarray(ptr)[0] );
        iden:=xdword( pintegerarray(ptr)[1] );
        if iden=0 then iden:=1;
        result:=inum/iden;
      end;
    11: // float
      result:=psingle(ptr)^;
    12: // double
      result:=pdouble(ptr)^;
  end;
end;


{!!
<FS>TIETIFFHandler.GetValue

<FM>Declaration<FC>
function GetValue(pageIndex:integer; tagIndex:integer; arrayIndex:integer):variant;

<FM>Description<FN>
Returns the tag value as variant. arrayIndex is used only if the tag contains an array of values, otherwise it must be 0.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetValue(pageIndex:integer; tagIndex:integer; arrayIndex:integer):variant;
begin
  case integer(GetTagType(pageIndex,tagIndex)) of
    1,3,4,6,7,8,9:
      result:=GetInteger(pageIndex,tagIndex,arrayIndex);
    2:
      result:=GetString(pageIndex,tagIndex);
    5,10,11,12:
      result:=GetFloat(pageIndex,tagIndex,arrayIndex);
  end;
end;


{!!
<FS>TIETIFFHandler.SetValue

<FM>Declaration<FC>
procedure SetValue(pageIndex:integer; tagCode:integer; tagType:<A TIETagType>; value:variant);

<FM>Description<FN>
Set the value of a tag. If the tag doesn't exist a new one is created.
!!}
procedure TIETIFFHandler.SetValue(pageIndex:integer; tagCode:integer; tagType:TIETagType; value:variant);
var
  ifd:TList;
begin
  ifd := fPages[pageIndex];
  SetValue(ifd, tagCode, tagType, value);
end;


procedure TIETIFFHandler.SetValue(ifd:TList; tagCode:integer; tagType:TIETagType; value:variant);
type
  trat=packed record
    num:dword;
    den:dword;
  end;
  tsrat=packed record
    num:longint;
    den:longint;
  end;
var
  t:integer;
  tag:PTIFFTAG;
  ss:AnsiString;
  ptr,dst:pointer;
  bb:byte;
  si:smallint;
  li:longint;
  rat:trat;
  srat:tsrat;
  hi:shortint;
  ww:word;
  dw:dword;
  fl:single;
  db:double;
begin
  // remove the old tag
  t:=FindTag(ifd, tagCode);
  if t>-1 then
    DeleteTag(ifd, t, true);
  // add the tag
  new(tag);
  ifd.Add( tag );
  tag^.IdTag:=xword( tagCode );
  tag^.DataType:=xword( integer(tagType) );
  ptr:=nil;
  case tagType of
    ttByte:
      begin
        tag^.DataNum:=xdword(1);
        bb:=integer(value);
        ptr:=@bb;
      end;
    ttAscii:
      begin
        ss:=AnsiString(value);
        tag^.DataNum:=xdword(length(ss)+1);
        ptr:=PAnsiChar(ss);
      end;
    ttShort:
      begin
        tag^.DataNum:=xdword(1);
        ww:=xword(word(value));
        ptr:=@ww;
      end;
    ttLong:
      begin
        tag^.DataNum:=xdword(1);
        dw:=xdword(dword(value));
        ptr:=@dw;
      end;
    ttRational:
      begin
        tag^.DataNum:=xdword(1);
        rat.num:=xdword(trunc(double(value)*10000));
        rat.den:=xdword(10000);
        ptr:=@rat;
      end;
    ttSByte:
      begin
        tag^.DataNum:=xdword(1);
        hi:=shortint(value);
        ptr:=@hi;
      end;
    ttUndefined: ;
    ttSShort:
      begin
        tag^.DataNum:=xdword(1);
        si:=xword(smallint(value));
        ptr:=@si;
      end;
    ttSLong:
      begin
        tag^.DataNum:=xdword(1);
        li:=xdword(longint(value));
        ptr:=@li;
      end;
    ttSRational:
      begin
        tag^.DataNum:=xdword(1);
        srat.num:=xdword(trunc(double(value)*10000));
        srat.den:=xdword(10000);
        ptr:=@srat;
      end;
    ttFloat:
      begin
        tag^.DataNum:=xdword(1);
        fl:=single(value);
        ptr:=@fl;
      end;
    ttDouble:
      begin
        tag^.DataNum:=xdword(1);
        db:=double(value);
        ptr:=@db;
      end;
  end;
  t:=xdword(tag^.DataNum) * IETAGSIZE[xword(tag^.DataType)];  // length in bytes 2.2.5
  if t>4 then
  begin
    getmem(dst,t);
    tag^.DataPos:=xdword(int64(DWORD(dst)));
  end
  else
    dst:=@tag^.DataPos;
  if ptr<>nil then
    copymemory(dst,ptr,t);
end;


{!!
<FS>TIETIFFHandler.SetValueRAW

<FM>Declaration<FC>
procedure SetValueRAW(pageIndex:integer; tagCode:integer; tagType:<A TIETagType>; dataNum:integer; buffer:pointer);

<FM>Description<FN>
Sets the value of tag as raw buffer. If the tag doesn't exist a new one is created.
<FC>dataNum<FN> is the number of items of type <FC>tagType<FN> in the buffer. This is not the buffer length in bytes.
!!}
procedure TIETIFFHandler.SetValueRAW(pageIndex:integer; tagCode:integer; tagType:TIETagType; dataNum:integer; buffer:pointer);
var
  ifd:TList;
  t:integer;
  tag:PTIFFTAG;
  dst:pointer;
begin
  ifd:=fPages[pageIndex];
  // remove the old tag
  t:=FindTag(pageIndex,tagCode);
  if t>-1 then
    DeleteTag(pageIndex,t);
  // add the tag
  new(tag);
  ifd.Add( tag );
  tag^.IdTag:=xword( tagCode );
  tag^.DataType:=xword( integer(tagType) );
  tag^.DataNum:=xdword(dataNum);
  t:=xdword(tag^.DataNum) * IETAGSIZE[xword(tag^.DataType)];  // length in bytes   2.2.5
  if t>4 then
  begin
    getmem(dst,t);
    tag^.DataPos:=xdword(int64(DWORD(dst)));
  end
  else
    dst:=@tag^.DataPos;
  if buffer<>nil then
    copymemory(dst,buffer,t);
end;


{!!
<FS>TIETIFFHandler.CopyTag

<FM>Declaration<FC>
procedure CopyTag(srcPageIndex:integer; srcTagIndex:integer; source:TIETIFFHandler; dstPageIndex:integer);

<FM>Description<FN>
Copies a tag from another <A TIETIFFHandler> object (that is, from another TIFF).
Applications obtain <FC>srcTagIndex<FN> calling <A TIETIFFHandler.FindTag>.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>srcPageIndex<FN></C> <C>Source page index (0=first page)</C> </R>
<R> <C><FC>srcTagIndex<FN></C> <C>Source tag index (use <A TIETIFFHandler.FindTag> to get an index from tag code)</C> </R>
<R> <C><FC>source<FN></C> <C>Source <A TIETIFFHandler> object, that is the source TIFF file</C> </R>
<R> <C><FC>dstPageIndex<FN></C> <C>Destination page index (0=first page)</C> </R>
</TABLE>

<FM>Example<FC>
// copy tiff tag 271 (Manufacturer) from file1.tif to file2.tif
var
  file1:TIETIFFHandler;
  file2:TIETIFFHandler;
begin
  file1:=TIETIFFHandler.Create('file1.tif');
  file2:=TIETIFFHandler.Create('file2.tif');

  file2.CopyTag(0, file1.FindTag(0, 271), file1, 0);

  file2.WriteFile('file2.tif');

  file2.Free;
  file1.Free;
end;
!!}
procedure TIETIFFHandler.CopyTag(srcPageIndex:integer; srcTagIndex:integer; source:TIETIFFHandler; dstPageIndex:integer);
var
  src_ifd:TList;
  dst_ifd:TList;
begin
  if (srcPageIndex<source.fPages.Count) and (dstPageIndex<fPages.Count) then
  begin
    src_ifd := source.fPages[srcPageIndex];
    dst_ifd := fPages[dstPageIndex];
    CopyTag(src_ifd, srcTagIndex, source, dst_ifd);
  end;
end;

procedure TIETIFFHandler.CopyTag(src_ifd:TList; srcTagIndex:integer; source:TIETIFFHandler; dst_ifd:TList);
var
  src_tag:PTIFFTAG;
  dst_tag:PTIFFTAG;
  datanum:integer;
  tagcode:integer;
  tgpos, tglen:integer;
  i, l, sz:integer;
  dwbuf_dst:pdwordarray;
  buf_dst, buf_src:pointer;
  src_subifd:TList;
  dst_subifd:TList;
begin

  if (srcTagIndex>-1) and (source.fIsMotorola=fIsMotorola) then
  begin
    src_tag := src_ifd[srcTagIndex];
    datanum := xdword(src_tag^.DataNum);
    tagcode := xword(src_tag^.IdTag);

    // delete destination tag
    DeleteTag(dst_ifd, FindTag(dst_ifd, tagcode), true);

    // create new-destination tag
    new(dst_tag);
    dst_tag^ := src_tag^;

    // fill tag data
    source.CheckPairTag(tagcode, tgpos, tglen);
    if tgpos>-1 then
    begin
      // offsets tag //

      // create destination buffer and get source buffer
      if datanum>1 then
      begin
        getmem(dwbuf_dst, datanum*sizeof(integer));
        dst_tag^.DataPos := xdword(int64(DWORD(dwbuf_dst)));
      end
      else
        dwbuf_dst := pdwordarray(@dst_tag^.DataPos);

      // copy data
      for i:=0 to datanum-1 do
      begin
        l := source.GetIntegerByCode(src_ifd, tglen, i);  // length in bytes
        getmem(buf_dst, l);
        buf_src := pointer(source.GetIntegerByCode(src_ifd, tgpos, i));  // get pointer from position
        CopyMemory(buf_dst, buf_src, l);
        dwbuf_dst[i] := xdword(int64(DWORD(buf_dst)));
      end;

    end
    else
    begin
      // normal tag //
      sz := IETAGSIZE[xword(src_tag^.DataType)]*datanum;
      if sz>4 then
      begin
        getmem(buf_dst, sz);
        CopyMemory(buf_dst, pointer(xdword(src_tag^.DataPos)), sz);
        dst_tag^.DataPos := xdword(int64(DWORD(buf_dst)));
      end;
      // Is SUB-EXIF?
      if CheckIFD(tagcode) then
      begin
        dst_subifd := TList.Create;
        dst_tag^.DataPos := integer(pointer(dst_subifd));
        src_subifd := pointer(src_tag^.DataPos);
        for i:=0 to src_subifd.Count-1 do
        begin
          CopyTag(src_subifd, i, source, dst_subifd);
        end;
      end;
    end;

    dst_ifd.Add(dst_tag);

  end;

end;


{!!
<FS>TIETIFFHandler.GetTagDescription

<FM>Declaration<FC>
function GetTagDescription(pageIndex:integer; tagIndex:integer):AnsiString;

<FM>Description<FN>
Returns a short description of specified tag.
Applications obtain <FC>tagIndex<FN> calling <A TIETIFFHandler.FindTag>.
!!}
function TIETIFFHandler.GetTagDescription(pageIndex:integer; tagIndex:integer):AnsiString;
begin
  case GetTagCode(pageindex,tagIndex) of
    254: result:='NewSubfileType';
    255: result:='SubfileType';
    256: result:='ImageWidth';
    257: result:='ImageLength';
    258: result:='BitsPerSample';
    259: result:='Compression';
    262: result:='PhotometricInterpretation';
    263: result:='Thresholding';
    264: result:='CellWidth';
    265: result:='CellHeight';
    266: result:='FillOrder';
    269: result:='DocumentName';
    270: result:='ImageDescription';
    271: result:='Manufacturer';
    272: result:='Model';
    273: result:='StripOffsets';
    274: result:='Orientation';
    277: result:='SamplesPerPixel';
    278: result:='RowsPerStrip';
    279: result:='StripByteCounts';
    280: result:='MinSampleValue';
    281: result:='MaxSampleValue';
    282: result:='XResolution';
    283: result:='YResolution';
    284: result:='PlanarConfiguration';
    285: result:='PageName';
    286: result:='XPosition';
    287: result:='YPosition';
    288: result:='FreeOffsets';
    289: result:='FreeByteCounts';
    290: result:='GratResponseUnit';
    291: result:='GrayResponseCurve';
    292: result:='T4Options';
    293: result:='T6Options';
    296: result:='ResolutionUnit';
    297: result:='PageNumber';
    301: result:='TransferFunction';
    305: result:='Software';
    306: result:='DateTime';
    315: result:='Artist';
    316: result:='HostComputer';
    317: result:='Predictor';
    318: result:='WhitePoint';
    319: result:='PrimaryChromaticities';
    320: result:='ColorMap';
    321: result:='HalftoneHints';
    322: result:='TileWidth';
    323: result:='TileLength';
    324: result:='TileOffsets';
    325: result:='TileByteCounts';
    326: result:='BadFaxLines';
    327: result:='CleanFaxData';
    328: result:='ConsecutiveBadFaxLines';
    330: result:='SubIFDs';
    332: result:='InkSet';
    333: result:='InkNames';
    334: result:='NumberOfInks';
    336: result:='DotRange';
    337: result:='TargetPrinter';
    338: result:='ExtraSamples';
    339: result:='SampleFormat';
    340: result:='SMinSampleValue';
    341: result:='SMaxSampleValue';
    342: result:='TransferRange';
    347: result:='JPEGTables';
    512: result:='JPEGProc';
    513: result:='JPEGInterchangeFormat';
    514: result:='JPEGInterchangeFormatLength';
    515: result:='JPEGRestartInterval';
    517: result:='JPEGLosslessPredictors';
    518: result:='JPEGPointTransforms';
    519: result:='JPEGQTables';
    520: result:='JPEGDCTables';
    521: result:='JPEGACTables';
    529: result:='YCbCrCoefficients';
    530: result:='YCbCrSubSampling';
    531: result:='YCbCrPositioning';
    532: result:='ReferenceBlackWhite';
    700: result:='XMP';
    33432: result:='Copyright';
    33723: result:='IPTC info';
    32932: result:='Imaging Wang annot.';
    34377: result:='PhotoshopTags';
    34665: result:='Sub EXIF';
    34675: result:='ICC Color Profile';
    34853: result:='GPS IFD';
    37398: result:='EP Standard';
    40965: result:='Interoperability IFD';
    50706: result:='DNGVersion';
    else
      result:='Unknown';
  end;
end;

{$endif}

// end of TIETIFFHandler
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// TIEFileBuffer
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

constructor TIEFileBuffer.Create;
begin
  inherited;
  fFileName := '';
  fMapped := TList.Create;
  fSimFile := nil;
end;

destructor TIEFileBuffer.Destroy;
begin
  DeAllocate;
  FreeAndNil(fMapped);
  inherited;
end;

procedure TIEFileBuffer.DeAllocate;
begin
  if IsAllocated then
  begin
    UnMapAll;
    FreeAndNil(fSimFile);
    DeleteFile(fFileName);
  end;
end;

function TIEFileBuffer.IsAllocated: boolean;
begin
  result := fSimFile <> nil
end;

// if FileName is '', creates a temp file name in DefTEMPPATH
function TIEFileBuffer.AllocateFile(InSize: int64; const Descriptor:string; UseDisk:boolean): boolean;
var
  temppath: array[0..MAX_PATH] of Char;
  tp:string;
begin
  if IsAllocated then
    DeAllocate;
  result:=false;
  if DefTEMPPATH = '' then
  begin
    GetTempPath(250, temppath);
    tp:=string(temppath);
  end
  else
    tp:=DefTEMPPATH;
  fFileName:=IEGetTempFileName(Descriptor,tp);
  try
    if UseDisk then
    begin
      (*
        problems of DiskFree: cannot detect disk>2GB, (0)=current directory (imagine changing directory to USB disk or CDROM)
      if InSize>(DiskFree(0)-128000000) then
        exit;
      *)
      fSimFile := TIETemporaryFileStream.Create(fFileName);
    end
    else
      fSimFile := TMemoryStream.Create;
    fSimFile.Size := InSize;
    result := true;
  except
  end;
end;

procedure TIEFileBuffer.ReAllocateFile(NewSize: int64);
begin
  fSimFile.Size := NewSize;
end;

// can copy maximum 2^31 bytes

procedure TIEFileBuffer.CopyTo(Dest: TIEFileBuffer; InPos, InSize: int64);
const
  BUFSIZE = 1024 * 1024;
var
  i: integer;
  buf: pbyte;
begin
  if (not IsAllocated) or (not Dest.IsAllocated) then
    exit;
  UnMapAll;
  Dest.UnMapAll;
  (*
  // disabled because since 2.2.7 we use TIETemporaryFileStream instead of TFileStream
  if (InPos = 0) and (InSize = fSimFile.Size) then
  begin
    // copy the full file using operating system functions
    FreeAndNil(fSimFile);
    FreeAndNil(Dest.fSimFile);
    deletefile(Dest.fFileName);
    copyfile(PAnsiChar(fFileName), PAnsiChar(Dest.fFileName), false);
    Dest.fSimFile := TFileStream.Create(Dest.fFileName, fmOpenReadWrite);
    fSimFile := TFileStream.Create(fFileName, fmOpenReadWrite);
  end
  else
  *)
  begin
    fSimFile.Position := InPos;
    Dest.fSimFile.Position := InPos;
    getmem(buf, BUFSIZE);
    repeat
      if InSize < BUFSIZE then
        i := InSize
      else
        i := BUFSIZE;
      fSimFile.Read(buf^, i);
      Dest.fSimFile.Write(buf^, i);
      dec(InSize, i);
    until InSize <= 0;
    freemem(buf);
  end;
end;

procedure TIEFileBuffer.CopyTo(Dest: TStream; InPos, InSize: int64);
begin
  if (not IsAllocated) then
    exit;
  UnMapAll;
  fSimFile.Position := InPos;
  IECopyFrom(Dest, fSimFile, InSize);
end;

function TIEFileBuffer.IndexOf(ptr: pointer): integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to fMapped.Count - 1 do
    if PIEFileBufferItem(fMapped[i])^.ptr = ptr then
    begin
      result := i;
      break;
    end;
end;

function TIEFileBuffer.Map(InPos, InSize: int64; DataAccess: TIEDataAccess): pointer;
var
  item: PIEFileBufferItem;
begin
  getmem(result, InSize);
  if (fSimFile<>nil) and (iedRead in DataAccess) then
  begin
    fSimFile.Position := InPos;
    fSimFile.Read(pbyte(result)^, InSize);
  end;
  new(item);
  item^.Pos := InPos;
  item^.Size := InSize;
  item^.ptr := result;
  item^.access := DataAccess;
  fMapped.Add(item);
end;

procedure TIEFileBuffer.UnMap(ptr: pointer);
var
  i: integer;
  item: PIEFileBufferItem;
begin
  i := IndexOf(ptr);
  item := fMapped[i];
  if (fSimFile<>nil) and (iedWrite in item^.access) then
  begin
    fSimFile.Position := item^.Pos;
    fSimFile.Write(pbyte(ptr)^, item^.Size);
  end;
  dispose(item);
  fMapped.Delete(i);
  freemem(ptr);
end;

procedure TIEFileBuffer.UnMapAll;
begin
  if IsAllocated then
    while fMapped.Count > 0 do
      UnMap(PIEFileBufferItem(fMapped[fMapped.Count - 1]).ptr);
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
// TIETemporaryFileStream

constructor TIETemporaryFileStream.Create(const FileName: string);
begin
  FHandle := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_FLAG_DELETE_ON_CLOSE or FILE_ATTRIBUTE_TEMPORARY, 0);
  if FHandle = INVALID_HANDLE_VALUE then
    raise EInOutError.Create('Unable to create '+FileName);
  inherited Create(FHandle);
end;

destructor TIETemporaryFileStream.Destroy;
begin
  if FHandle <> INVALID_HANDLE_VALUE then
    FileClose(FHandle);
  inherited Destroy;
end;

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////



procedure IECenterWindow(Wnd: HWnd);
var
  Rect: TRect;
  Monitor: TMonitor;
begin
  if @IEDefDialogCenter <> nil then
    IEDefDialogCenter(Wnd)
  else
  begin
    GetWindowRect(Wnd, Rect);
    if Application.MainForm <> nil then
    begin
      if Assigned(Screen.ActiveForm) then
        Monitor := Screen.ActiveForm.Monitor
      else
        Monitor := Application.MainForm.Monitor;
    end
    else
      Monitor := Screen.Monitors[0];
    SetWindowPos(Wnd, 0,
                 Monitor.Left + ((Monitor.Width - Rect.Right + Rect.Left) div 2),
                 Monitor.Top + ((Monitor.Height - Rect.Bottom + Rect.Top) div 3),
                 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;
end;



type
  TMEMORYSTATUSEX=packed record
    dwLength:DWORD;
    dwMemoryLoad:DWORD;
    ullTotalPhys:int64;
    ullAvailPhys:int64;
    ullTotalPageFile:int64;
    ullAvailPageFile:int64;
    ullTotalVirtual:int64;
    ullAvailVirtual:int64;
    ullAvailExtendedVirtual:int64;
  end;
  PMEMORYSTATUSEX=^TMEMORYSTATUSEX;

TIEGlobalMemoryStatusEx=function(lpBuffer:PMEMORYSTATUSEX): longbool; stdcall;

// freememory = false -> total memory
// freememory = true -> free memory
function IEGetMemory(freememory:boolean): int64;
var
  ms:TMemoryStatus;
  msx:TMEMORYSTATUSEX;
  h:THandle;
  IEGlobalMemoryStatusEx:TIEGlobalMemoryStatusEx;
begin

  h := LoadLibrary('Kernel32.dll');
  if h<>0 then
  begin
    @IEGlobalMemoryStatusEx:=GetProcAddress(h,'GlobalMemoryStatusEx');
    if @IEGlobalMemoryStatusEx<>nil then
    begin
      FillChar(msx,sizeof(TMEMORYSTATUSEX),0);
      msx.dwLength:=sizeof(TMEMORYSTATUSEX);
      IEGlobalMemoryStatusEx(@msx);
      if freememory then
        result:=msx.ullAvailPhys
      else
        result:=msx.ullTotalPhys;
      FreeLibrary(h);
      exit;
    end;
    FreeLibrary(h);
  end;

  ms.dwLength := sizeof(ms);
  GlobalMemoryStatus(ms);
  if freememory then
    result := ms.dwAvailPhys
  else
    result := ms.dwTotalPhys;
end;


procedure IESetplim(var plim: trect; x, y: integer);
begin
  if x < plim.Left then
    plim.left := x;
  if x > plim.Right then
    plim.right := x;
  if y < plim.Top then
    plim.top := y;
  if y > plim.Bottom then
    plim.bottom := y;
end;

function IEArcTan2(Y, X: Extended): Extended;
asm
   FLD     Y
   FLD     X
   FPATAN
   FWAIT
end;

function IEArcCos(X: Extended): Extended;
begin
  if (X = 1) or (X = -1) then
    result := 0
  else
    Result := IEArcTan2(Sqrt(1 - X * X), X);
end;

// calculates the angle (rad) of the specified triangle. x2,y2 is the angle center
function IEAngle(x1, y1, x2, y2, x3, y3: integer): double;
var
  vx1, vy1, vx2, vy2: integer;
  d1, d2: double;
begin
  vx1 := x2 - x1;
  vy1 := y2 - y1;
  vx2 := x3 - x2;
  vy2 := y3 - y2;
  try
  d1 := sqrt(vx1 * vx1 + vy1 * vy1);
  except
    d1:=0;
  end;
  try
  d2 := sqrt(vx2 * vx2 + vy2 * vy2);
  except
    d2:=0;
  end;
  if (d1 = 0) or (d2 = 0) then
    result := 0
  else
  begin
    d1 := (vx1 * vx2 + vy1 * vy2) / (d1 * d2);
    if abs(d1) <= 1 then
      result := IEArcCos(d1)
    else
      result := 0;
  end;
end;

// Calc angle (rad) of segment x1,y1-x2,y2 relative to the X axis
function IEAngle2(x1, y1, x2, y2: integer): double;
begin
  if (x1 < x2) and (y2 < y1) then // 1
    result := pi - ieangle(x2, y2, x1, y1, x2, y1)
  else if (x1 < x2) and (y1 < y2) then // 4
    result := pi + ieangle(x2, y1, x1, y1, x2, y2)
  else if (x2 < x1) and (y1 < y2) then // 3
    result := 2 * pi - ieangle(x2, y1, x1, y1, x2, y2)
  else if (x2 < x1) and (y2 < y1) then // 2
    result := ieangle(x2, y1, x1, y1, x2, y2)
  else if (x2 = x1) and (y1 > y2) then
    result := pi / 2
  else if (x2 = x1) and (y1 < y2) then
    result := 1.5 * pi
  else if (y1 = y2) and (x1 > x2) then
    result := pi
  else
    result := 0;
end;

function ccw(x0, y0, x1, y1, x2, y2: integer): integer;
var
  dx1, dx2, dy1, dy2: integer;
begin
  dx1 := x1 - x0;
  dy1 := y1 - y0;
  dx2 := x2 - x0;
  dy2 := y2 - y0;
  if dx1 * dy2 > dy1 * dx2 then
    result := 1
  else if dx1 * dy2 < dy1 * dx2 then
    result := -1
  else if (dx1 * dx2 < 0) or (dy1 * dy2 < 0) then
    result := -1
  else if (dx1 * dx1 + dy1 * dy1) < (dx2 * dx2 + dy2 * dy2) then
    result := 1
  else
    result := 0;
end;

function IEAngle3(x1, y1, xc, yc, x2, y2: integer): double;
var
  a, b, c: double;
begin
  // a is (xc,yc)-(x2,y2)
  // b is (x1,y1)-(x2,y2)
  // c is (xc,yc)-(x1,y1)
  a := sqrt(sqr(x2 - xc) + sqr(y2 - yc));
  if a = 0 then
    a := 1;
  b := sqrt(sqr(x2 - x1) + sqr(y2 - y1));
  if b = 0 then
    b := 1;
  c := sqrt(sqr(xc - x1) + sqr(yc - y1));
  if c = 0 then
    c := 1;
  result := iearccos((sqr(a) + sqr(c) - sqr(b)) / (2 * a * c));
  if ccw(x1, y1, xc, yc, x2, y2) = -1 then
    result := 2 * PI - result;
end;


function IEExtractStylesFromLogFont(logfont: PLogFontA): TFontStyles;
begin
  result := [];
  if LogFont <> nil then
    with LogFont^ do
    begin
      if lfItalic <> 0 then
        include(result, fsItalic);
      if lfUnderline <> 0 then
        include(result, fsUnderline);
      if lfStrikeOut <> 0 then
        include(result, fsStrikeOut);
      if lfWeight >= FW_BOLD then
        include(result, fsBold);
    end;
end;

function CompareGUID(const g1,g2:TGuid):boolean;
begin
  result:=CompareMem(@g1,@g2,sizeof(TGuid));
end;

function IEConvertGUIDToString(g: PGUID): AnsiString;
var
  p: pbyte;
  i: integer;
begin
  p := pbyte(g);
  result := '{' + IEIntToHex(pinteger(p)^, 8) + '-';
  inc(p, 4);
  result := result + IEIntToHex(pword(p)^, 4) + '-';
  inc(p, 2);
  result := result + IEIntToHex(pword(p)^, 4) + '-';
  inc(p, 2);
  result := result + IEIntToHex(p^, 2);
  inc(p);
  result := result + IEIntToHex(p^, 2) + '-';
  inc(p);
  for i := 0 to 5 do
  begin
    result := result + IEIntToHex(p^, 2);
    inc(p);
  end;
  result := IELowerCase(result) + '}';
end;

procedure IEConvertWStringToGUID(invar: WideString; gg: PGUID);
begin
  IEConvertAStringToGUID(AnsiString(invar),gg);
end;

procedure IEConvertAStringToGUID(invar: AnsiString; gg: PGUID);
const
  cv: array[48..70] of integer = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0, 10, 11, 12, 13, 14, 15);
  mm: array[0..7] of integer = (268435456, 16777216, 1048576, 65536, 4096, 256, 16, 1);
var
  i: integer;
  v: cardinal;
begin
  invar := IEUpperCase(invar);
  v := 0;
  for i := 2 to 9 do
    v := v + cardinal(cv[ord(invar[i])] * mm[i - 2]);
  gg^.D1 := v;
  gg^.D2 := 0;
  for i := 11 to 14 do
    gg^.D2 := gg^.D2 + cv[ord(invar[i])] * mm[i - 11 + 4];
  gg^.D3 := 0;
  for i := 16 to 19 do
    gg^.D3 := gg^.D3 + cv[ord(invar[i])] * mm[i - 16 + 4];
  invar := IECopy(invar, 21, 4) + IECopy(invar, 26, 12);
  for i := 0 to 7 do
  begin
    gg^.D4[i] := cv[ord(invar[i * 2 + 1])] * mm[6] + cv[ord(invar[i * 2 + 2])] * mm[7];
  end;
end;

procedure IEResetPrinter;
var
  Device, Driver, Port: pointer;
  DevMode: THandle;
  lCopies:integer;
  lOrient:TPrinterOrientation;
  lTitle:WideString;
begin
  lCopies:=Printer.Copies;
  lOrient:=Printer.Orientation;
  lTitle:=Printer.Title;
  getmem(Device,512);
  getmem(Driver,512);
  getmem(Port,512);
  try
  Printer.GetPrinter(Device, Driver, Port, DevMode);
  Printer.SetPrinter(Device, Driver, Port, 0);
  finally
    freemem(Device);
    freemem(Driver);
    freemem(Port);
  end;
  Printer.Copies:=lCopies;
  Printer.Orientation:=lOrient;
  Printer.Title:=lTitle;
end;

// Adjust the resampling size to match fwidth and fheight
// owidth, oheight: source image size
// fwidth, fheight: container box size
// rwidth, rheight: output - new size
procedure IEFitResample(owidth, oheight, fwidth, fheight: integer; var rwidth, rheight: integer);
var
  zz: double;
begin
  if (owidth <> 0) and (oheight <> 0) then
  begin
    zz := dmin(fwidth / owidth, fheight / oheight);
    rwidth := trunc(owidth * zz);
    if rwidth = 0 then
      rwidth := 1;
    rheight := trunc(oheight * zz);
    if rheight = 0 then
      rheight := 1;
  end;
end;

// encode maximum 4 bytes (len can be 1 to 4)
// pad if len<4
// return chars wrote
function _IEASCII85Encode4(var inbytes: pbyte; inlen: integer; var outstr: PAnsiChar): integer;
var
  c: array[1..5] of dword;
  value: dword;
  i: integer;
begin

  // 2.2.4rc2
  value:=0;
  for i:=0 to inlen-1 do
  begin
    value:=value or (inbytes^ shl (24-i*8));
    inc(inbytes);
  end;
  (*
  value := inbytes^ shl 24;
  inc(inbytes);
  value := value or (inbytes^ shl 16);
  inc(inbytes);
  value := value or (inbytes^ shl 8);
  inc(inbytes);
  value := value or inbytes^;
  inc(inbytes);
  *)

  if (value = 0) and (inlen = 4) then
  begin
    outstr^ := 'z';
    inc(outstr);
    result := 1;
  end
  else
  begin
    c[1] := value div 52200625;
    value := value - c[1] * 52200625;
    c[2] := value div 614125;
    value := value - c[2] * 614125;
    c[3] := value div 7225;
    value := value - c[3] * 7225;
    c[4] := value div 85;
    value := value - c[4] * 85;
    c[5] := value;
    for i := 1 to inlen + 1 do
    begin
      outstr^ := AnsiChar(c[i] + 33);
      inc(outstr);
    end;
    result := inlen + 1;
  end;
end;

function IEASCII85EncodeBlock(var inbytes: pbyte; buflen: integer; var outstr: PAnsiChar; var asciilen: integer): integer;
var
  w: integer;
  row: integer;
begin
  result := 0;
  row := 0;
  repeat
    w := _IEASCII85Encode4(inbytes, imin(4, buflen), outstr);
    inc(result, w);
    inc(asciilen, w);
    inc(row, w);
    dec(buflen, 4);
    if row >= 75 then
    begin
      outstr^ := #13;
      inc(outstr);
      outstr^ := #10;
      inc(outstr);
      inc(result, 2);
      row := 0;
    end;
  until buflen <= 0;
  outstr^ := '~';
  inc(outstr);
  outstr^ := '>';
  inc(outstr);
  outstr^ := #13;
  inc(outstr);
  outstr^ := #10;
  inc(outstr);
  inc(result, 4);
end;

// decode maximum 5 characters (inlen)

procedure _IEASCII85Decode5(var instr: PAnsiChar; inlen: integer; var outbytes: pbyte);
var
  value: cardinal;
begin
  if instr^ = 'z' then
  begin
    value := 0;
    inc(instr);
  end
  else
  begin
    value := (ord(instr^) - 33) * 52200625;
    inc(instr);
    if inlen >= 2 then
    begin
      value := value + cardinal(ord(instr^) - 33) * 614125;
      inc(instr);
    end;
    if inlen >= 3 then
    begin
      value := value + cardinal(ord(instr^) - 33) * 7225;
      inc(instr);
    end;
    if inlen >= 4 then
    begin
      value := value + cardinal(ord(instr^) - 33) * 85;
      inc(instr);
    end;
    if inlen >= 5 then
    begin
      value := value + cardinal(ord(instr^) - 33);
      inc(instr);
    end;
  end;
  outbytes^ := value div 16777216;
  value := value - (outbytes^ * 16777216);
  inc(outbytes);
  outbytes^ := value div 65536;
  value := value - (outbytes^ * 65536);
  inc(outbytes);
  outbytes^ := value div 256;
  value := value - (outbytes^ * 256);
  inc(outbytes);
  outbytes^ := value;
  inc(outbytes);
end;

// a block is terminates with a '~>' (EOD)
// buflen refers to instr length
// return output length

function IEASCII85DecodeBlock(var instr: PAnsiChar; buflen: integer; var outbytes: pbyte): integer;
var
  i, l, flatlen: integer;
  flatbuf, ptr, instr2: PAnsiChar;
begin
  result := 0;
  flatlen := 0;
  getmem(flatbuf, buflen);
  ptr := flatbuf;
  i := 0;
  while i < buflen do
  begin
    while ((ord(instr^) < 33) or (ord(instr^) > 117)) and (instr^ <> '~') and (instr^ <> '>') do
    begin
      inc(instr);
      inc(i);
    end;
    if instr^ = '~' then
    begin
      instr2 := instr;
      l := i;
      inc(instr);
      while ((ord(instr^) < 33) or (ord(instr^) > 117)) and (instr^ <> '~') and (instr^ <> '>') do
        inc(instr);
      if instr^ = '>' then
      begin
        inc(instr);
        break;
      end
      else
      begin
        instr := instr2;
        i := l;
      end;
    end;
    ptr^ := instr^;
    inc(instr);
    inc(i);
    inc(ptr);
    inc(flatlen);
  end;
  ptr := flatbuf;
  repeat
    i := imin(flatlen, 5);
    _IEASCII85Decode5(ptr, i, outbytes);
    inc(result, i - 1);
    dec(flatlen, i);
  until flatlen <= 0;
  freemem(flatbuf);
end;

// return the number of bytes actually written

function IEPSRunLengthEncode(inbytes: pbytearray; inlen: integer; outbytes: pbytearray): integer;
var
  inpos, i, l, j: integer;
begin
  result := 0; // this is output position
  inpos := 0;
  while inpos < inlen do
  begin

    // search for run lengths

    i := inpos + 1;
    while (i < inlen) and (inbytes[inpos] = inbytes[i]) and (i-inpos < 128) do
      inc(i);
    l := i - inpos;
    if (l > 1) then
    begin
      // do run length
      outbytes[result] := 257 - l;
      inc(result);
      outbytes[result] := inbytes[inpos];
      inc(result);
      inpos := i;
    end
    else
    begin

      // search for literals

      i := inpos + 1;
      while (i < inlen) and (inbytes[i-1] <> inbytes[i]) and (i-inpos < 128) do
        inc(i);
      l := i - inpos;
      // do literals
      outbytes[result] := l - 1;
      inc(result);
      for j := 0 to l - 1 do
      begin
        outbytes[result] := inbytes[inpos];
        inc(result);
        inc(inpos);
      end;

    end;

  end;

  // do EOD
  outbytes[result] := 128;
  inc(result);

end;

procedure IEWriteStrLn(s: TStream; ss: AnsiString);
begin
  ss := ss + #13#10;
  s.Write(PAnsiChar(ss)^, length(ss));
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEGraphicBase

procedure TIEGraphicBase.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  bmp.RenderToCanvas(ACanvas, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, fResampleFilter, 1);
end;

function TIEGraphicBase.GetEmpty: Boolean;
begin
  result := false;
end;

function TIEGraphicBase.GetHeight: Integer;
begin
  result := bmp.Height;
end;

function TIEGraphicBase.GetWidth: Integer;
begin
  result := bmp.Width;
end;

procedure TIEGraphicBase.SetHeight(Value: Integer);
begin
  bmp.Height := Value;
end;

procedure TIEGraphicBase.SetWidth(Value: Integer);
begin
  bmp.Width := Value;
end;

constructor TIEGraphicBase.Create;
begin
  inherited;
  fResampleFilter:=rfNone;
  bmp := TIEBitmap.Create;
  fio := TImageEnIO.CreateFromBitmap(bmp);
  if self is TIETIFFImage then
    fFileType := ioTIFF
  else if self is TIEJpegImage then
    fFileType := ioJPEG
  else if self is TIEPCXImage then
    fFileType := ioPCX
  else if self is TIEBMPImage then
    fFileType := ioBMP
  else if self is TIEICOImage then
    fFileType := ioICO
{$IFDEF IEINCLUDEPNG}
  else if self is TIEPNGImage then
    fFileType := ioPNG
{$ENDIF}
  else if self is TIETGAImage then
    fFileType := ioTGA
  else if self is TIEPXMImage then
    fFileType := ioPXM
  else if self is TIEGIFImage then
    fFileType := ioGIF
{$IFDEF IEINCLUDEJPEG2000}
  else if self is TIEJP2Image then
    fFileType := ioJP2
  else if self is TIEJ2KImage then
    fFileType := ioJ2K
{$ENDIF}
  else if self is TIEPSDImage then
    fFileType := ioPSD;
end;

destructor TIEGraphicBase.Destroy;
begin
  FreeAndNil(fio);
  FreeAndNil(bmp);
  inherited;
end;

procedure TIEGraphicBase.Assign(Source: TPersistent);
var
  vclbmp: TBitmap;
begin
  if (Source <> nil) and (Source is TIEGraphicBase) then
  begin
    bmp.Assign((Source as TIEGraphicBase).bmp);
    Changed(Self);
  end
  else if (Source <> nil) and (Source is TBitmap) then
  begin
    vclbmp := Source as TBitmap;
    if (vclbmp.PixelFormat <> pf24bit) and (vclbmp.PixelFormat <> pf1bit) then
      vclbmp.PixelFormat := pf24bit;
    bmp.Assign(vclbmp);
    Changed(Self);
  end
  else
    inherited Assign(Source);
end;

procedure TIEGraphicBase.AssignTo(Dest: TPersistent);
begin
  if (Dest <> nil) and (Dest is TIEGraphicBase) then
  begin
    (Dest as TIEGraphicBase).bmp.Assign(bmp);
  end
  else if (Dest <> nil) and (Dest is TBitmap) then
  begin
    bmp.CopyToTBitmap(Dest as TBitmap);
  end
  else
    inherited AssignTo(Dest);
end;

procedure TIEGraphicBase.LoadFromStream(Stream: TStream);
begin
  if assigned(fio) then
    TImageEnIO(fio).LoadFromStreamFormat(Stream, fFileType);
end;

procedure TIEGraphicBase.SaveToStream(Stream: TStream);
begin
  if assigned(fio) then
    TImageEnIO(fio).SaveToStream(Stream, fFiletype);
end;

procedure TIEGraphicBase.WriteData(Stream: TStream);
var
  ms: TMemoryStream;
  sz: integer;
begin
  ms := TMemoryStream.Create;
  SaveToStream(ms);
  ms.Position := 0;
  sz := ms.Size;
  Stream.Write(sz, sizeof(integer));
  IECopyFrom(Stream, ms, ms.Size);
  FreeAndNil(ms);
end;

procedure TIEGraphicBase.ReadData(Stream: TStream);
var
  sz: integer;
begin
  if (Stream.Read(sz, sizeof(integer)) > 0) and (sz > 0) then
    LoadFromStream(Stream);
end;

procedure TIEGraphicBase.LoadFromClipboardFormat(AFormat: Word; AData: THandle; APalette: HPALETTE);
begin
  if AFormat = CF_DIB then
    _CopyDIB2BitmapEx(AData, bmp, nil, false);
end;

procedure TIEGraphicBase.SaveToClipboardFormat(var AFormat: Word; var AData: THandle; var APalette: HPALETTE);
begin
  AData := _CopyBitmaptoDIBEx(bmp, 0,0,0,0, 200,200);
  AFormat := CF_DIB;
end;

procedure IERegisterFormats;
begin
  TPicture.RegisterFileFormat('TIF', 'TIFF Bitmap', TIETIFFImage);
  TPicture.RegisterFileFormat('TIFF', 'TIFF Bitmap', TIETIFFImage);
  TPicture.RegisterFileFormat('FAX', 'TIFF Bitmap', TIETIFFImage);
  TPicture.RegisterFileFormat('G3N', 'TIFF Bitmap', TIETIFFImage);
  TPicture.RegisterFileFormat('G3F', 'TIFF Bitmap', TIETIFFImage);

  TPicture.RegisterFileFormat('GIF', 'CompuServe Bitmap', TIEGIFImage);

  TPicture.RegisterFileFormat('JPG', 'JPEG Bitmap', TIEJpegImage);
  TPicture.RegisterFileFormat('JPEG', 'JPEG Bitmap', TIEJpegImage);
  TPicture.RegisterFileFormat('JPE', 'JPEG Bitmap', TIEJpegImage);

  TPicture.RegisterFileFormat('PCX', 'PaintBrush', TIEPCXImage);

  // BMP extension disabled to avoid conflicts with VCL version
  //TPicture.RegisterFileFormat('BMP', 'Windows Bitmap', TIEBMPImage);
  TPicture.RegisterFileFormat('DIB', 'Windows Bitmap', TIEBMPImage);
  TPicture.RegisterFileFormat('RLE', 'Windows Bitmap', TIEBMPImage);

  // ICO is disabled to avoid conflicts with VCL version
//TPicture.RegisterFileFormat('ICO','Windows Icon',TIEICOImage);

{$IFDEF IEINCLUDEPNG}
  TPicture.RegisterFileFormat('PNG', 'Portable Network Graphics', TIEPNGImage);
{$ENDIF}

  TPicture.RegisterFileFormat('TGA', 'Targa Bitmap', TIETGAImage);
  TPicture.RegisterFileFormat('TARGA', 'Targa Bitmap', TIETGAImage);
  TPicture.RegisterFileFormat('VDA', 'Targa Bitmap', TIETGAImage);
  TPicture.RegisterFileFormat('ICB', 'Targa Bitmap', TIETGAImage);
  TPicture.RegisterFileFormat('VST', 'Targa Bitmap', TIETGAImage);
  TPicture.RegisterFileFormat('PIX', 'Targa Bitmap', TIETGAImage);

  TPicture.RegisterFileFormat('PXM', 'Portable Pixmap, GreyMap, BitMap', TIEPXMImage);
  TPicture.RegisterFileFormat('PPM', 'Portable Pixmap, GreyMap, BitMap', TIEPXMImage);
  TPicture.RegisterFileFormat('PGM', 'Portable Pixmap, GreyMap, BitMap', TIEPXMImage);
  TPicture.RegisterFileFormat('PBM', 'Portable Pixmap, GreyMap, BitMap', TIEPXMImage);

{$IFDEF IEINCLUDEJPEG2000}
  TPicture.RegisterFileFormat('JP2', 'JPEG2000', TIEJP2Image);
  TPicture.RegisterFileFormat('J2K', 'JPEG2000 Code Stream', TIEJ2KImage);
  TPicture.RegisterFileFormat('JPC', 'JPEG2000 Code Stream', TIEJ2KImage);
  TPicture.RegisterFileFormat('J2C', 'JPEG2000 Code Stream', TIEJ2KImage);
{$ENDIF}

  TPicture.RegisterFileFormat('PSD', 'Adobe PSD', TIEPSDImage);

end;

procedure IEUnregisterFormats;
begin
  try
    TPicture.UnregisterGraphicClass(TIETIFFImage);
    TPicture.UnregisterGraphicClass(TIEGIFImage);
    TPicture.UnregisterGraphicClass(TIEJpegImage);
    TPicture.UnregisterGraphicClass(TIEPCXImage);
    TPicture.UnregisterGraphicClass(TIEBMPImage);
    //TPicture.UnregisterGraphicClass(TIEICOImage); // ICO is disabled to avoid conflicts with VCL version
    {$ifdef IEINCLUDEPNG}
    TPicture.UnregisterGraphicClass(TIEPNGImage);
    {$endif}
    TPicture.UnregisterGraphicClass(TIETGAImage);
    TPicture.UnregisterGraphicClass(TIEPXMImage);
    {$ifdef IEINCLUDEJPEG2000}
    TPicture.UnregisterGraphicClass(TIEJP2Image);
    TPicture.UnregisterGraphicClass(TIEJ2KImage);
    {$endif}
    TPicture.UnregisterGraphicClass(TIEPSDImage);
  except
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEMemStream

constructor TIEMemStream.Create(Ptr: pointer; Size: integer);
begin
  inherited Create;
  SetPointer(Ptr, Size);
end;

procedure TIEMemStream.SetSize(NewSize: Longint);
begin
  // not implemented
end;

function TIEMemStream.Write(const Buffer; Count: Longint): Longint;
begin
  // not implemented
  result := 0;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEImagingAnnot

{$ifdef IEINCLUDEIMAGINGANNOT}

constructor TIEImagingAnnot.Create;
begin
  inherited Create;
  fParent := nil;
  fObjects := TList.Create;
end;

destructor TIEImagingAnnot.Destroy;
begin
  Clear;
  FreeAndNil(fObjects);
  inherited;
end;

{!!
<FS>TIEImagingAnnot.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Removes all annotations.
!!}
procedure TIEImagingAnnot.Clear;
var
  i:integer;
begin
  for i:=0 to fObjects.Count-1 do
    TIEImagingObject(fObjects[i]).Free;
  fObjects.Clear;
end;

{!!
<FS>TIEImagingAnnot.Assign

<FM>Declaration<FC>
procedure Assign(Source:<A TIEImagingAnnot>);

<FM>Description<FN>
Copy from another <A TIEImagingAnnot> object.
!!}
procedure TIEImagingAnnot.Assign(Source: TIEImagingAnnot);
var
  i, l: integer;
  dst, src: TIEImagingObject;
begin
  Clear;
  for i := 0 to Source.fObjects.Count - 1 do
  begin
    dst := TIEImagingObject.Create;
    src := TIEImagingObject(Source.fObjects[i]);
    move(src.attrib, dst.attrib, sizeof(OIAN_MARK_ATTRIBUTES));
    if assigned(src.points) then
    begin
      getmem(dst.points, sizeof(TPoint) * src.pointsLen);
      move(src.points[0], dst.points[0], sizeof(TPoint) * src.pointsLen);
      dst.pointsLen := src.pointsLen;
    end;
    if assigned(src.text) then
    begin
      l := strlen(src.text) + 1;
      getmem(dst.text, l);
      move(src.text[0], dst.text[0], l);
    end;
    if assigned(src.image) then
    begin
      dst.image := TIEBitmap.Create;
      dst.image.Assign(src.image);
    end;
    fObjects.Add(dst);
  end;
end;

{!!
<FS>TIEImagingAnnot.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream: TStream);

<FM>Description<FN>
For internal use only.
!!}
procedure TIEImagingAnnot.SaveToStream(Stream: TStream);
begin
  // not implemented
end;

{!!
<FS>TIEImagingAnnot.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream: TStream);

<FM>Description<FN>
For internal use only.
!!}
procedure TIEImagingAnnot.LoadFromStream(Stream: TStream);
begin
  // not implemented
end;

{!!
<FS>TIEImagingAnnot.Objects

<FM>Declaration<FC>
property Objects[idx:integer]:<A TIEImagingObject>;

<FM>Description<FN>
Contains the internal representation of an object.
!!}
function TIEImagingAnnot.GetObject(idx: integer): TIEImagingObject;
begin
  result := TIEImagingObject(fObjects[idx]);
end;

{!!
<FS>TIEImagingAnnot.ObjectsCount

<FM>Declaration<FC>
property ObjectsCount:integer;

<FM>Description<FN>
Objects (annotations) count.
!!}
function TIEImagingAnnot.GetObjectsCount: integer;
begin
  result := fObjects.Count;
end;

{!!
<FS>TIEImagingAnnot.DrawToBitmap

<FM>Declaration<FC>
procedure DrawToBitmap(target:<A TIEBitmap>; Antialias:boolean);

<FM>Description<FN>
Draws all annotations to the specified bitmap.

<FM>Example<FC>
ImageEnView.IO.ImagingAnnot.DrawToBitmap( ImageEnView.IEBitmap, true );
ImageEnView.Update;
!!}
procedure TIEImagingAnnot.DrawToBitmap(target: TIEBitmap; Antialias: boolean);
var
  ievect: TImageEnVect;
begin
  ievect := TImageEnVect.Create(nil);
  CopyToTImageEnVect(ievect);
  ievect.ObjGraphicRender := true;
  ievect.DrawObjectsToBitmap(target, Antialias);
  FreeAndNil(ievect);
end;

constructor TIEImagingObject.Create;
begin
  inherited Create;
  points := nil;
  pointsLen := 0;
  text := nil;
  image := nil;
end;

destructor TIEImagingObject.Destroy;
begin
  if assigned(points) then
    freemem(points);
  if assigned(text) then
    freemem(text);
  if assigned(image) then
    FreeAndNil(image);
  inherited;
end;

function TRGBQuad2TColor(q: TRGBQuad): TColor;
var
  rgb: TRGB;
begin
  rgb.r := q.rgbRed;
  rgb.g := q.rgbGreen;
  rgb.b := q.rgbBlue;
  result := TRGB2TColor(rgb);
end;

function TColor2TRGBQuad(q: TColor): TRGBQuad;
var
  rgb: TRGB;
begin
  rgb := TColor2TRGB(q);
  result.rgbRed := rgb.r;
  result.rgbGreen := rgb.g;
  result.rgbBlue := rgb.b;
  result.rgbReserved := 0;
end;


{!!
<FS>TIEImagingAnnot.CopyFromTImageEnVect

<FM>Declaration<FC>
procedure CopyFromTImageEnVect(Target:TObject=nil);

<FM>Description<FN>
Copy vectorial objects from a <A TImageEnVect> object.
If <FC>Target<FN> is <FC>nil<FN> then the parent TImageEnVect is given.

<FM>Example<FC>
ImageEnVect1.IO.Params.ImagingAnnot.CopyFromTImageEnVect( ImageEnVect1 );
!!}
procedure TIEImagingAnnot.CopyFromTImageEnVect(Target: TObject);
var
  vect: TImageEnVect;
  i, j, hobj: integer;
  obj: TIEImagingObject;
  rect: TRect;
  procedure AddNew;
  var
    rc: TRect;
  begin
    obj := TIEImagingObject.Create;
    fillchar(obj.attrib, sizeof(OIAN_MARK_ATTRIBUTES), 0);
    obj.attrib.dwReserved4 := $FF83F;
    fObjects.Add(obj);
    vect.GetObjRect(hobj, rect);
    rc := rect;
    if rc.Left > rc.Right then
      iswap(rc.Left, rc.Right);
    if rc.Top > rc.Bottom then
      iswap(rc.Top, rc.Bottom);
    obj.attrib.lrBounds := rc;
    obj.attrib.bVisible := true;
  end;
  procedure PutCommonMemoData;
  var
    l: integer;
    s1, s2: AnsiString;
  begin
    //obj.attrib.lfFont.lfHeight := -round((vect.ObjFontHeight[hobj] / gSystemDPIY) * 72);
    obj.attrib.lfFont.lfHeight := -trunc( vect.ObjFontHeight[hobj] * (iegAnnotCreationScale / 1000) );

    strcopy(obj.attrib.lfFont.lfFaceName, PAnsiChar(vect.ObjFontName[hobj]));
    if fsBold in vect.ObjFontStyles[hobj] then
      obj.attrib.lfFont.lfWeight := FW_BOLD
    else
      obj.attrib.lfFont.lfWeight := FW_NORMAL;
    obj.attrib.lfFont.lfItalic := byte(fsItalic in vect.ObjFontStyles[hobj]);
    obj.attrib.lfFont.lfUnderline := byte(fsUnderline in vect.ObjFontStyles[hobj]);
    obj.attrib.lfFont.lfStrikeOut := byte(fsStrikeOut in vect.ObjFontStyles[hobj]);
    s1 := '';
    s2 := vect.ObjText[hobj];
    for l := 1 to length(s2) do
      if s2[l] = #10 then
        s1 := s1 + #13#10
      else
        s1 := s1 + s2[l];
    l := length(s1) + 1;
    getmem(obj.text, l);
    strcopy(obj.text, PAnsiChar(s1));
  end;
begin
  if not assigned(Target) and assigned(fParent) then
    Target := (fParent as TIOParamsVals).ImageEnIO.AttachedImageEn;
  vect := Target as TImageEnVect;
  Clear;
  for i := 0 to vect.ObjectsCount - 1 do
  begin
    hobj := vect.GetObjFromIndex(i);
    case vect.ObjKind[hobj] of
      iekBITMAP:
        begin
          AddNew;
          obj.attrib.uType := IEAnnotImageEmbedded;
          obj.image := TIEBitmap.Create;
          obj.image.Assign(vect.ObjBitmap[hobj]);
        end;
      iekLINE:
        begin
          AddNew;
          obj.attrib.uType := IEAnnotStraightLine;
          obj.attrib.rgbColor1 := TColor2TRGBQuad(vect.ObjPenColor[hobj]);
          obj.attrib.uLineSize := vect.ObjPenWidth[hobj];
          obj.attrib.bHighlighting := vect.ObjTransparency[hobj] < 200;
          getmem(obj.points, 2 * sizeof(TPoint));
          obj.pointslen := 2;
          obj.points[0].x := rect.Left - obj.attrib.lrBounds.Left;
          obj.points[0].y := rect.Top - obj.attrib.lrBounds.Top;
          obj.points[1].x := rect.Right - obj.attrib.lrBounds.Left;
          obj.points[1].y := rect.Bottom - obj.attrib.lrBounds.Top;
        end;
      iekPOLYLINE:
        begin
          AddNew;
          obj.attrib.uType := IEAnnotFreehandLine;
          obj.attrib.rgbColor1 := TColor2TRGBQuad(vect.ObjPenColor[hobj]);
          obj.attrib.uLineSize := vect.ObjPenWidth[hobj];
          obj.attrib.bHighlighting := vect.ObjTransparency[hobj] < 200;
          obj.pointslen := vect.ObjPolylinePointsCount[hobj];
          getmem(obj.points, obj.pointslen * sizeof(TPoint));
          for j := 0 to obj.pointslen - 1 do
          begin
            obj.points[j].x := vect.ObjPolylinePoints[hobj, j].x - obj.attrib.lrBounds.Left;
            obj.points[j].y := vect.ObjPolylinePoints[hobj, j].y - obj.attrib.lrBounds.Top;
          end;
        end;
      iekBOX:
        begin
          AddNew;
          if vect.ObjBrushStyle[hobj] = bsClear then
          begin
            obj.attrib.uType := IEAnnotHollowRectangle;
            obj.attrib.rgbColor1 := TColor2TRGBQuad(vect.ObjPenColor[hobj]);
            obj.attrib.uLineSize := vect.ObjPenWidth[hobj];
            obj.attrib.bHighlighting := vect.ObjBoxHighLight[hobj];
          end
          else
          begin
            obj.attrib.uType := IEAnnotFilledRectangle;
            obj.attrib.rgbColor1 := TColor2TRGBQuad(vect.ObjBrushColor[hobj]);
            obj.attrib.bHighlighting := vect.ObjBoxHighLight[hobj];
          end;
        end;
      iekMEMO, iekTEXT:
        begin
          AddNew;
          if vect.ObjBrushStyle[hobj] = bsClear then
          begin
            obj.attrib.uType := IEAnnotTypedText;
            obj.attrib.rgbColor1 := TColor2TRGBQuad(vect.ObjPenColor[hobj]);
            PutCommonMemoData;
          end
          else
          begin
            obj.attrib.uType := IEAnnotAttachANote;
            obj.attrib.rgbColor1 := TColor2TRGBQuad(vect.ObjBrushColor[hobj]);
            obj.attrib.rgbColor2 := TColor2TRGBQuad(vect.ObjPenColor[hobj]);
            PutCommonMemoData;
          end;
        end;
    end;
  end;
end;

{!!
<FS>TIEImagingAnnot.CopyToTImageEnVect

<FM>Declaration<FC>
procedure CopyToTImageEnVect(Target:TObject=nil);

<FM>Description<FN>
Copy to a TImageEnVect object (as vectorial objects).
If <FC>Target<FN> is <FC>nil<FN> then the parent TImageEnVect is given.

<FM>Example<FC>
ImageEnVect1.IO.Params.ImagingAnnot.CopyToTImageEnVect( ImageEnVect1 );
!!}
procedure TIEImagingAnnot.CopyToTImageEnVect(Target: TObject);
var
  vect: TImageEnVect;
  idx, i, j: integer;
  o: TIEImagingObject;
  x1, y1, x2, y2: integer;
  poly: PPointArray;
begin
  if not assigned(Target) and assigned(fParent) then
    Target := (fParent as TIOParamsVals).ImageEnIO.AttachedImageEn;
  vect := Target as TImageEnVect;
  for i := 0 to fObjects.Count - 1 do
  begin
    o := fObjects[i];
    case o.attrib.uType of
      IEAnnotImageEmbedded:
        begin
          idx := vect.AddNewObject;
          vect.ObjKind[idx] := iekBITMAP;
          vect.SetObjRect(idx, o.attrib.lrBounds);
          vect.ObjBitmap[idx] := o.image;
        end;
      IEAnnotImageReference:
        begin
        end;
      IEAnnotStraightLine:
        begin
          idx := vect.AddNewObject;
          vect.ObjKind[idx] := iekLINE;
          x1 := o.attrib.lrBounds.Left + o.points[0].x;
          y1 := o.attrib.lrBounds.Top + o.points[0].y;
          x2 := o.attrib.lrBounds.Left + o.points[1].x;
          y2 := o.attrib.lrBounds.Top + o.points[1].y;
          vect.SetObjRect(idx, rect(x1, y1, x2, y2));
          vect.ObjPenColor[idx] := TRGBQuad2TColor(o.attrib.rgbColor1);
          vect.ObjPenStyle[idx] := psSolid;
          vect.ObjPenWidth[idx] := o.attrib.uLineSize;
          vect.ObjBeginShape[idx] := iesNONE;
          vect.ObjEndShape[idx] := iesNONE;
          if o.attrib.bHighlighting then
            vect.ObjTransparency[idx] := 127
          else
            vect.ObjTransparency[idx] := 255;
        end;
      IEAnnotFreehandLine:
        begin
          idx := vect.AddNewObject;
          vect.ObjKind[idx] := iekPOLYLINE;
          getmem(poly, sizeof(TPoint) * o.pointslen);
          for j := 0 to o.pointslen - 1 do
          begin
            poly[j].x := o.attrib.lrBounds.Left + o.points[j].x;
            poly[j].y := o.attrib.lrBounds.Top + o.points[j].y;
          end;
          vect.SetObjPolylinePoints(idx, slice(poly^, o.pointslen));
          freemem(poly);
          vect.ObjPenColor[idx] := TRGBQuad2TColor(o.attrib.rgbColor1);
          vect.ObjPenStyle[idx] := psSolid;
          vect.ObjPenWidth[idx] := o.attrib.uLineSize;
          if o.attrib.bHighlighting then
            vect.ObjTransparency[idx] := 127
          else
            vect.ObjTransparency[idx] := 255;
        end;
      IEAnnotHollowRectangle:
        begin
          idx := vect.AddNewObject;
          vect.ObjKind[idx] := iekBOX;
          vect.SetObjRect(idx, rect(o.attrib.lrBounds.Left, o.attrib.lrBounds.Top, o.attrib.lrBounds.Right, o.attrib.lrBounds.Bottom));
          vect.ObjPenColor[idx] := TRGBQuad2TColor(o.attrib.rgbColor1);
          vect.ObjPenWidth[idx] := o.attrib.uLineSize;
          vect.ObjPenStyle[idx] := psSolid;
          vect.ObjBrushStyle[idx] := bsClear;
          vect.ObjMemoCharsBrushStyle[idx] := bsClear;
          vect.ObjBoxHighLight[idx] := o.attrib.bHighlighting;
        end;
      IEAnnotFilledRectangle:
        begin
          idx := vect.AddNewObject;
          vect.ObjKind[idx] := iekBOX;
          vect.SetObjRect(idx, rect(o.attrib.lrBounds.Left, o.attrib.lrBounds.Top, o.attrib.lrBounds.Right, o.attrib.lrBounds.Bottom));
          vect.ObjBrushColor[idx] := TRGBQuad2TColor(o.attrib.rgbColor1);
          vect.ObjBrushStyle[idx] := bsSolid;
          vect.ObjMemoCharsBrushStyle[idx] := bsSolid;
          vect.ObjPenStyle[idx] := psClear;
          vect.ObjBoxHighLight[idx] := o.attrib.bHighlighting;
        end;
      IEAnnotTypedText, IEAnnotTextStamp, IEAnnotTextFromFile:
        begin
          idx := vect.AddNewObject;
          vect.ObjKind[idx] := iekMEMO;
          vect.SetObjRect(idx, rect(o.attrib.lrBounds.Left, o.attrib.lrBounds.Top, o.attrib.lrBounds.Right, o.attrib.lrBounds.Bottom));
          vect.ObjPenColor[idx] := TRGBQuad2TColor(o.attrib.rgbColor1);
          vect.ObjBrushColor[idx] := clwhite;
          vect.ObjBrushStyle[idx] := bsClear;
          vect.ObjMemoCharsBrushStyle[idx] := bsClear;
          vect.ObjMemoBorderStyle[idx] := psClear;

          //vect.ObjFontHeight[idx] := -round((o.attrib.lfFont.lfHeight/72)*gSystemDPIY);
          vect.ObjFontHeight[idx] := -trunc( o.attrib.lfFont.lfHeight * 1000 / iegAnnotCreationScale );

          vect.ObjFontName[idx] := o.attrib.lfFont.lfFaceName;
          vect.ObjFontStyles[idx] := IEExtractStylesFromLogFont(@o.attrib.lfFont);
          vect.ObjTextAlign[idx] := iejLeft;
          vect.objFontLocked[idx] := true;
          vect.ObjText[idx] := o.text;
        end;
      IEAnnotAttachANote:
        begin
          idx := vect.AddNewObject;
          vect.ObjKind[idx] := iekMEMO;
          vect.SetObjRect(idx, rect(o.attrib.lrBounds.Left, o.attrib.lrBounds.Top, o.attrib.lrBounds.Right, o.attrib.lrBounds.Bottom));
          vect.ObjPenColor[idx] := TRGBQuad2TColor(o.attrib.rgbColor2);
          vect.ObjBrushColor[idx] := TRGBQuad2TColor(o.attrib.rgbColor1);
          vect.ObjBrushStyle[idx] := bsSolid;
          vect.ObjMemoCharsBrushStyle[idx] := bsSolid;
          vect.ObjMemoBorderStyle[idx] := psClear;

          //vect.ObjFontHeight[idx] := -round((o.attrib.lfFont.lfHeight/72)*gSystemDPIY);
          vect.ObjFontHeight[idx] := -trunc( o.attrib.lfFont.lfHeight * 1000 / iegAnnotCreationScale );

          vect.ObjFontName[idx] := o.attrib.lfFont.lfFaceName;
          vect.ObjFontStyles[idx] := IEExtractStylesFromLogFont(@o.attrib.lfFont);
          vect.ObjTextAlign[idx] := iejLeft;
          vect.objFontLocked[idx] := true;
          vect.ObjText[idx] := o.text;
        end;
      IEAnnotForm:
        begin
        end;
      IEAnnotOCRRegion:
        begin
        end;
    end;
  end;
end;

type
  AN_POINTS = packed record
    nMaxPoints: integer;
    nPoints: integer;
    ptPoint: PPointArray;
  end;
  PAN_POINTS = ^AN_POINTS;

  AN_NEW_ROTATE_STRUCT = packed record
    rotation: integer;
    scale: integer;
    nHRes: integer;
    nVRes: integer;
    nOrigHRes: integer;
    nOrigVRes: integer;
    bReserved1: integer;
    bReserved2: integer;
    nReserved: array[0..5] of integer;
  end;
  PAN_NEW_ROTATE_STRUCT = ^AN_NEW_ROTATE_STRUCT;

  OIAN_TEXTPRIVDATA = packed record
    nCurrentOrientation: integer;
    uReserved1: dword;
    uCreationScale: dword;
    uAnoTextLength: dword;
    szAnoText: AnsiChar;
  end;
  POIAN_TEXTPRIVDATA = ^OIAN_TEXTPRIVDATA;

  HYPERLINK_NB = packed record
    nVersion: integer;
    nLinkSize: integer;
    LinkString: PAnsiChar;
    nLocationSize: integer;
    LocationString: PAnsiChar;
    nWorkDirSize: integer;
    WorkDirString: PAnsiChar;
    nFlags: integer;
  end;
  PHYPERLINK_NB = ^HYPERLINK_NB;

  TNamedBlocks = record
    // OiAnoDat_lines - AN_POINTS
    p_OiAnoDat_lines: PAN_POINTS;
    // OiAnoDat_images - AN_NEW_ROTATE_STRUCT
    p_OiAnoDat_images: PAN_NEW_ROTATE_STRUCT;
    // OiFilNam - AN_NAME_STRUCT
    p_OiFilNam: PAnsiChar;
    // OiDIB - AN_IMAGE_STRUCT
    p_OiDIB: pointer;
    // OiGroup - STR
    p_OiGroup: PAnsiChar;
    // OiIndex - STR
    p_OiIndex: PAnsiChar;
    // OiAnText - OIAN_TEXTPRIVDATA
    p_OiAnText: POIAN_TEXTPRIVDATA;
    // OiHypLnk - HYPERLINK_NB
    p_OiHypLnk: PHYPERLINK_NB;
  end;

procedure LoadNamedBlock(var namedblocks: TNamedBlocks; ptr: pbytearray; buflen: integer; var pos: integer; IntegerLen: integer; CurrentMark: integer);
var
  name: AnsiString;
  size: integer;
  l: integer;
  pc: PAnsiChar;
begin
  pc := @ptr[pos];
  name := '';
  while (pc^ <> #0) and (length(name) < 8) do
  begin
    name := name + pc^;
    inc(pc);
  end;
  inc(pos, 8);
  size := pinteger(@ptr[pos])^;
  inc(pos, 4);
  if IntegerLen = 0 then
    inc(pos, 4);
  if name = 'OiAnoDat' then
  begin
    if (CurrentMark = IEAnnotForm) or (CurrentMark = IEAnnotImageEmbedded) or (CurrentMark = IEAnnotImageReference) then
    begin
      // AN_NEW_ROTATE_STRUCT
      if assigned(namedblocks.p_OiAnoDat_images) then
        dispose(namedblocks.p_OiAnoDat_images);
      new(namedblocks.p_OiAnoDat_images);
      move(ptr[pos], namedblocks.p_OiAnoDat_images^, sizeof(AN_NEW_ROTATE_STRUCT));
    end
    else if (CurrentMark = IEAnnotFreehandLine) or (CurrentMark = IEAnnotStraightLine) then
    begin
      // AN_POINTS
      if assigned(namedblocks.p_OiAnoDat_lines) then
        dispose(namedblocks.p_OiAnoDat_lines);
      new(namedblocks.p_OiAnoDat_lines);
      move(ptr[pos], namedblocks.p_OiAnoDat_lines^, sizeof(AN_POINTS) - sizeof(PPointArray));
      l := sizeof(TPoint) * namedblocks.p_OiAnoDat_lines.nPoints;
      getmem(namedblocks.p_OiAnoDat_lines.ptPoint, l);
      move(ptr[pos + sizeof(AN_POINTS) - sizeof(PPointArray)], namedblocks.p_OiAnoDat_lines.ptPoint^[0], l);
    end;
  end
  else if name = 'OiFilNam' then
  begin
    // STR
    if assigned(namedblocks.p_OiFilNam) then
      freemem(namedblocks.p_OiFilNam);
    l := strlen(PAnsiChar(@ptr[pos]));
    getmem(namedblocks.p_OiFilNam, l + 1);
    move(ptr[pos], namedblocks.p_OiFilNam^, l + 1);
  end
  else if name = 'OiDIB' then
  begin
    // DIB
    if assigned(namedblocks.p_OiDIB) then
      freemem(namedblocks.p_OiDIB);
    getmem(namedblocks.p_OiDIB, size);
    move(ptr[pos], namedblocks.p_OiDIB^, size);
  end
  else if name = 'OiGroup' then
  begin
    // STR
    if assigned(namedblocks.p_OiGroup) then
      freemem(namedblocks.p_OiGroup);
    l := strlen(PAnsiChar(@ptr[pos]));
    getmem(namedblocks.p_OiGroup, l + 1);
    move(ptr[pos], namedblocks.p_OiGroup^, l + 1);
  end
  else if name = 'OiIndex' then
  begin
    // STR
    if assigned(namedblocks.p_OiIndex) then
      freemem(namedblocks.p_OiIndex);
    l := strlen(PAnsiChar(@ptr[pos]));
    getmem(namedblocks.p_OiIndex, l + 1);
    move(ptr[pos], namedblocks.p_OiIndex^, l + 1);
  end
  else if name = 'OiAnText' then
  begin
    // OIAN_TEXTPRIVDATA
    if assigned(namedblocks.p_OiAnText) then
      freemem(namedblocks.p_OiAnText);
    getmem(namedblocks.p_OiAnText, size);
    move(ptr[pos], namedblocks.p_OiAnText^, size);
  end;
  // OiHypLnk not supported
  inc(pos, size);
end;

procedure FreeNamedBlocks(var namedblocks: TNamedBlocks);
begin
  if assigned(namedblocks.p_OiAnoDat_images) then
    dispose(namedblocks.p_OiAnoDat_images);
  if assigned(namedblocks.p_OiAnoDat_lines) then
  begin
    if assigned(namedblocks.p_OiAnoDat_lines.ptPoint) then
      freemem(namedblocks.p_OiAnoDat_lines.ptPoint);
    dispose(namedblocks.p_OiAnoDat_lines);
  end;
  if assigned(namedblocks.p_OiFilNam) then
    freemem(namedblocks.p_OiFilNam);
  if assigned(namedblocks.p_OiDIB) then
    freemem(namedblocks.p_OiDIB);
  if assigned(namedblocks.p_OiGroup) then
    freemem(namedblocks.p_OiGroup);
  if assigned(namedblocks.p_OiIndex) then
    freemem(namedblocks.p_OiIndex);
  if assigned(namedblocks.p_OiAnText) then
    freemem(namedblocks.p_OiAnText);
  fillchar(namedblocks, sizeof(TNamedBlocks), 0);
end;

// add only if Mark.uType<>0

procedure AddMark(annot: TIEImagingAnnot; const DefaultNamedBlocks: TNamedBlocks; const CurrentNamedBlocks: TNamedBlocks; const Mark: OIAN_MARK_ATTRIBUTES);
var
  obj: TIEImagingObject;
  //
  procedure Get_OiAnoDat;
  begin
    if assigned(CurrentNamedBlocks.p_OiAnoDat_lines) then
    begin
      obj.pointsLen := CurrentNamedBlocks.p_OiAnoDat_lines^.nPoints;
      getmem(obj.points, sizeof(TPoint) * obj.pointslen);
      move(CurrentNamedBlocks.p_OiAnoDat_lines^.ptPoint^[0], obj.points[0], sizeof(TPoint) * obj.pointslen);
    end;
  end;
  procedure Get_OiAnText;
  var
    l: integer;
  begin
    if assigned(CurrentNamedBlocks.p_OiAnText) then
    begin
      l := strlen(PAnsiChar(@CurrentNamedBlocks.p_OiAnText^.szAnoText)) + 1;
      getmem(obj.text, l);
      move(CurrentNamedBlocks.p_OiAnText^.szAnoText, obj.text^, l);

      if CurrentNamedBlocks.p_OiAnText^.uCreationScale = 0 then
        //CurrentNamedBlocks.p_OiAnText^.uCreationScale := trunc(72000 / gSystemDPIY);
        CurrentNamedBlocks.p_OiAnText^.uCreationScale := iegAnnotCreationScale;

      //obj.attrib.lfFont.lfHeight := round((obj.attrib.lfFont.lfHeight*(72000/CurrentNamedBlocks.p_OiAnText^.uCreationScale))/gSystemDPIY);
      l := -trunc(obj.attrib.lfFont.lfHeight * (1000 / CurrentNamedBlocks.p_OiAnText^.uCreationScale)); // object height
      obj.attrib.lfFont.lfHeight := -trunc( l * (iegAnnotCreationScale / 1000) ); // now uses iegAnnotCreationScale instead of uCreationScale

    end;
  end;
  //
begin
  if Mark.uType > 0 then
  begin
    obj := TIEImagingObject.Create;
    move(Mark, obj.attrib, sizeof(OIAN_MARK_ATTRIBUTES));
    case Mark.uType of
      IEAnnotImageEmbedded:
        begin
          if assigned(CurrentNamedBlocks.p_OiDIB) then
          begin
            obj.image := TIEBitmap.Create;
            _CopyDIB2BitmapEx(cardinal(CurrentNamedBlocks.p_OiDIB), obj.image, nil, true);
          end;
        end;
      IEAnnotImageReference:
        begin
        end;
      IEAnnotStraightLine, IEAnnotFreehandLine:
        Get_OiAnoDat;
      IEAnnotHollowRectangle, IEAnnotFilledRectangle:
        ; // nothing to do
      IEAnnotTypedText, IEAnnotTextStamp, IEAnnotAttachANote, IEAnnotTextFromFile:
        Get_OiAnText;
      IEAnnotForm:
        begin
        end;
      IEAnnotOCRRegion:
        begin
        end;
    end;
    annot.fObjects.Add(obj);
  end;
end;

{!!
<FS>TIEImagingAnnot.LoadFromStandardBuffer

<FM>Declaration<FC>
procedure LoadFromStandardBuffer(buffer: pointer; buflen: integer);

<FM>Description<FN>
Loads imaging annotations from the specified buffer.
Used when ImageEn loads image files, to extract imaging annotations.
!!}
procedure TIEImagingAnnot.LoadFromStandardBuffer(buffer: pointer; buflen: integer);
var
  ptr: pbytearray;
  pos: integer;
  IntegerLen: integer; // integer length (0=16 bit, 1=32 bit)
  DataType: integer; // 2=default named blocks, 5=mark data, 6=named block
  //DataSize:integer;		// size of the block
  DefaultNamedBlocks: TNamedBlocks;
  CurrentNamedBlocks: TNamedBlocks;
  CurrentMark: OIAN_MARK_ATTRIBUTES;
begin
  if buflen = 0 then
    exit;
  pos := 0;
  ptr := buffer;
  inc(pos, 4); // bypass 4 bytes null header
  IntegerLen := pinteger(@ptr[pos])^;
  inc(pos, 4);
  fillchar(DefaultNamedBlocks, sizeof(TNamedBlocks), 0);
  fillchar(CurrentNamedBlocks, sizeof(TNamedBlocks), 0);
  fillchar(CurrentMark, sizeof(OIAN_MARK_ATTRIBUTES), 0);
  while pos < buflen do
  begin
    DataType := pinteger(@ptr[pos])^;
    inc(pos, 4);
    (*DataSize:=pinteger(@ptr[pos])^; *) inc(pos, 4);
    case DataType of
      2: // default named block
        begin
          LoadNamedBlock(DefaultNamedBlocks, ptr, buflen, pos, IntegerLen, CurrentMark.uType);
        end;
      5: // mark data
        begin
          AddMark(self, DefaultNamedBlocks, CurrentNamedBlocks, CurrentMark); // add previuos mark
          FreeNamedBlocks(CurrentNamedBlocks);
          move(ptr[pos], CurrentMark, sizeof(OIAN_MARK_ATTRIBUTES));
          inc(pos, sizeof(OIAN_MARK_ATTRIBUTES));
        end;
      6: // named block
        begin
          LoadNamedBlock(CurrentNamedBlocks, ptr, buflen, pos, IntegerLen, CurrentMark.uType);
        end;
    end;
  end;
  AddMark(self, DefaultNamedBlocks, CurrentNamedBlocks, CurrentMark); // add last mark
  FreeNamedBlocks(CurrentNamedBlocks);
  FreeNamedBlocks(DefaultNamedBlocks);
  fUserChanged := false; // the user should not call LoadFromStandardBuffer, then this is not an user changement
end;

{!!
<FS>TIEImagingAnnot.SaveToStandardBuffer

<FM>Declaration<FC>
procedure SaveToStandardBuffer(var Buffer: pointer; var BufferLength: integer);

<FM>Description<FN>
Saves imaging objects to buffer. You have to free the buffer.
This method is used to embed imaging annotations inside image files.
!!}
procedure TIEImagingAnnot.SaveToStandardBuffer(var Buffer: pointer; var BufferLength: integer);
const
  OiAnoDat: PAnsiChar = 'OiAnoDat';
  OiAnText: PAnsiChar = 'OiAnText';
  OiDIB: PAnsiChar = 'OiDIB'#0#0#0;
  OiIndex: PAnsiChar = 'OiIndex'#0;
  OiGroup: PAnsiChar = 'OiGroup'#0;
var
  ms: TMemoryStream;
  i: integer;
  ii: integer;
  l: integer;
  o: TIEImagingObject;
  anp: AN_POINTS;
  tex: OIAN_TEXTPRIVDATA;
  rot: AN_NEW_ROTATE_STRUCT;
  hdib: THandle;
  ptr1: pbyte;
  stk: TList;
  ss: AnsiString;
  //
  procedure PostPos;
  var
    ii: integer;
  begin
    stk.add(pointer(ms.Position));
    ii := 0;
    ms.Write(ii, 4); // dummy value: fill with the data size
  end;
  procedure SavePos;
  var
    pp, p1, ii: integer;
  begin
    pp := ms.Position;
    p1 := integer(stk[stk.count - 1]);
    ms.position := p1;
    ii := pp - p1 - 4;
    ms.Write(ii, 4);
    stk.delete(stk.Count - 1);
    ms.position := pp;
  end;
begin
  if fObjects.Count = 0 then
  begin
    Buffer := nil;
    BufferLength := 0;
    exit;
  end;
  stk := TList.Create;
  ms := TMemoryStream.Create;
  ii := 0;
  ms.write(ii, 4);
  ii := 1;
  ms.Write(ii, 4);
  // default OiGroup
  ii := 2;
  ms.Write(ii, 4); // named block
  ii := 12;
  ms.Write(ii, 4);
  ms.Write(OiGroup[0], 8); // name
  PostPos;
  ss := '0';
  ms.Write(PAnsiChar(ss)[0], length(ss) + 1);
  SavePos;
  // default OiIndex
  ii := 2;
  ms.Write(ii, 4); // named block
  ii := 12;
  ms.Write(ii, 4);
  ms.Write(OiIndex[0], 8); // name
  PostPos;
  ss := '1';
  ms.Write(PAnsiChar(ss)[0], length(ss) + 1);
  SavePos;
  //
  for i := 0 to fObjects.Count - 1 do
  begin
    ii := 5;
    ms.Write(ii, 4); // mark data
    PostPos;
    o := TIEImagingObject(fObjects[i]);
    ms.Write(o.attrib, sizeof(OIAN_MARK_ATTRIBUTES));
    SavePos;
    //
    case o.attrib.uType of
      IEAnnotImageEmbedded:
        begin
          // OiAnoDat
          ii := 6;
          ms.Write(ii, 4); // named block
          ii := 12;
          ms.Write(ii, 4);
          ms.Write(OiAnoDat[0], 8); // name
          PostPos;
          //
          rot.rotation := 1;
          rot.scale := 1000;
          rot.nHRes := gSystemDPIX;
          rot.nVRes := gSystemDPIY;
          rot.nOrigHRes := gSystemDPIX;
          rot.nOrigVRes := gSystemDPIY;
          rot.bReserved1 := 0;
          rot.bReserved2 := 0;
          fillchar(rot.nReserved[0], 4 * 6, 0);
          ms.Write(rot, sizeof(AN_NEW_ROTATE_STRUCT));
          //
          SavePos;
          // OiDIB
          ii := 6;
          ms.Write(ii, 4); // named block
          ii := 12;
          ms.Write(ii, 4);
          ms.Write(OiDIB[0], 8); // name
          PostPos;
          //
          hdib := _CopyBitmaptoDIBEx(o.image, 0,0,0,0, 200,200);
          ptr1 := GlobalLock(hdib);
          ms.Write(ptr1^, GlobalSize(hdib));
          GlobalUnlock(hdib);
          GlobalFree(hdib);
          //
          SavePos;
        end;
      IEAnnotStraightLine, IEAnnotFreehandLine:
        begin
          // OiAnoDat
          ii := 6;
          ms.Write(ii, 4); // named block
          ii := 12;
          ms.Write(ii, 4);
          ms.Write(OiAnoDat[0], 8); // name
          PostPos;
          //
          anp.nMaxPoints := o.pointsLen;
          anp.nPoints := o.pointsLen;
          ms.Write(anp, sizeof(AN_POINTS) - sizeof(PPointArray));
          ms.Write(o.points[0], sizeof(TPoint) * o.pointsLen);
          //
          SavePos;
        end;
      IEAnnotHollowRectangle, IEAnnotFilledRectangle:
        ; // nothing to do
      IEAnnotTypedText, IEAnnotTextStamp, IEAnnotAttachANote, IEAnnotTextFromFile:
        begin
          // OiAnText
          ii := 6;
          ms.Write(ii, 4); // named block
          ii := 12;
          ms.Write(ii, 4);
          ms.Write(OiAnText[0], 8); // name
          PostPos;
          //
          l := strlen(o.text) + 1;
          tex.nCurrentOrientation := 0;
          tex.uReserved1 := 1000;

          //tex.uCreationScale := trunc(72000 / gSystemDPIY);
          tex.uCreationScale := iegAnnotCreationScale;

          tex.uAnoTextLength := l - 1;
          ms.Write(tex, sizeof(OIAN_TEXTPRIVDATA) - 1);
          ms.Write(o.text[0], l);
          //
          SavePos;
        end;
    end;
    // OiGroup
    ii := 6;
    ms.Write(ii, 4); // named block
    ii := 12;
    ms.Write(ii, 4);
    ms.Write(OiGroup[0], 8); // name
    PostPos;
    ss := '0';
    ms.Write(PAnsiChar(ss)[0], length(ss) + 1);
    SavePos;
    // OiIndex
    ii := 6;
    ms.Write(ii, 4); // named block
    ii := 12;
    ms.Write(ii, 4);
    ms.Write(OiIndex[0], 8); // name
    PostPos;
    ss := IEIntToStr(i);
    ms.Write(PAnsiChar(ss)[0], length(ss) + 1);
    SavePos;
  end;
  getmem(Buffer, ms.Size);
  CopyMemory(Buffer, ms.Memory, ms.Size);
  BufferLength := ms.Size;
  FreeAndNil(ms);
  FreeAndNil(stk);
end;

{$endif}  // {$ifdef IEINCLUDEIMAGINGANNOT}

// TIEImagingAnnot
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////






///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PDF Support

{$ifdef IEINCLUDEPDFWRITING}

procedure iepdf_WriteLn(Stream: TStream; line: AnsiString);
begin
  line := line + #10;
  Stream.Write(PAnsiChar(line)^, length(line));
end;

procedure iepdf_Write(Stream: TStream; line: AnsiString);
begin
  Stream.Write(PAnsiChar(line)^, length(line))
end;

constructor TIEPDFObject.Create;
begin
  DontFree := false;
  inherited;
end;

destructor TIEPDFObject.Destroy;
begin
  inherited;
end;

constructor TIEPDFRefObject.Create(ObjNumber: integer; GenNumber: integer);
begin
  inherited Create;
  ObjectNumber := ObjNumber;
  GenerationNumber := GenNumber;
end;

constructor TIEPDFNumericObject.Create(vv: double);
begin
  inherited Create;
  Value := vv;
end;

constructor TIEPDFBooleanObject.Create(vv: boolean);
begin
  inherited Create;
  Value := vv;
end;

constructor TIEPDFStringObject.Create(vv: AnsiString);
begin
  inherited Create;
  Value := vv;
end;

constructor TIEPDFNameObject.Create(vv: AnsiString);
begin
  inherited Create;
  Value := vv;
end;

constructor TIEPDFArrayObject.Create;
begin
  inherited Create;
  Items := TList.Create;
end;

destructor TIEPDFArrayObject.Destroy;
var
  i: integer;
begin
  for i := Items.Count - 1 downto 0 do
    if not TIEPDFObject(Items[i]).DontFree then
    begin
      TIEPDFObject(Items[i]).Free;
      Items[i]:=nil;
    end;
  FreeAndNil(Items);
  inherited;
end;

constructor TIEPDFDictionaryObject.Create;
begin
  inherited Create;
  Items := TStringList.Create;
end;

destructor TIEPDFDictionaryObject.Destroy;
var
  i: integer;
begin
  for i := Items.Count - 1 downto 0 do
    if not TIEPDFObject(Items.Objects[i]).DontFree then
    begin
      TIEPDFObject(Items.Objects[i]).Free;
      Items.Objects[i]:=nil;
    end;
  FreeAndNil(Items);
  inherited;
end;

constructor TIEPDFStreamObject.Create;
begin
  inherited Create;
  data := nil;
  length := 0;
  dict := TIEPDFDictionaryObject.Create;
  dict.items.AddObject('Length', TIEPDFNumericObject.Create(0))
end;

constructor TIEPDFStreamObject.CreateCopy(copydata: pointer; copylength: integer);
begin
  inherited Create;
  Create;
  getmem(data, copylength);
  length := copylength;
  copymemory(data, copydata, length);
end;

destructor TIEPDFStreamObject.Destroy;
begin
  FreeAndNil(dict);
  if data <> nil then
    freemem(data);
  inherited;
end;

procedure TIEPDFRefObject.Write(Stream: TStream);
begin
  Position := Stream.Position;
  iepdf_Write(Stream, IEIntToStr(ObjectNumber) + #32 + IEIntToStr(GenerationNumber) + #32 + 'R');
end;

procedure TIEPDFBooleanObject.Write(Stream: TStream);
const
  ar: array[false..true] of AnsiString = ('false', 'true');
begin
  Position := Stream.Position;
  iepdf_Write(Stream, ar[value]);
end;

procedure TIEPDFNumericObject.Write(Stream: TStream);
begin
  Position := Stream.Position;
  iepdf_Write(Stream, IEFloatToStrA(Value));
end;

procedure TIEPDFStringObject.Write(Stream: TStream);
var
  ss: AnsiString;
  i: integer;
begin
  Position := Stream.Position;
  // writes only normal strings (not hex)
  for i := 1 to length(Value) do
    case Value[i] of
      #10: ss := ss + '\n';
      #13: ss := ss + '\r';
      #9: ss := ss + '\t';
      #8: ss := ss + '\b';
      #12: ss := ss + '\f';
      '(': ss := ss + '\(';
      ')': ss := ss + '\)';
      '\': ss := ss + '\\';
    else
      ss := ss + Value[i];
    end;
  iepdf_Write(Stream, '(' + ss + ')');
end;

procedure TIEPDFNameObject.Write(Stream: TStream);
var
  ss: AnsiString;
  i: integer;
begin
  Position := Stream.Position;
  for i := 1 to length(Value) do
    if (Value[i] < #33) or (Value[i] > #126) then
      ss := ss + '#' + IEIntToHex(ord(Value[i]), 2)
    else
      ss := ss + Value[i];
  iepdf_Write(Stream, '/' + ss);
end;

procedure TIEPDFArrayObject.Write(Stream: TStream);
var
  i: integer;
begin
  Position := Stream.Position;
  iepdf_Write(Stream, '[');
  for i := 0 to items.Count - 1 do
  begin
    TIEPDFObject(items[i]).Write(Stream);
    iepdf_Write(Stream, ' '); // space among items
  end;
  iepdf_Write(Stream, ']');
end;

procedure TIEPDFDictionaryObject.Write(Stream: TStream);
var
  i: integer;
begin
  Position := Stream.Position;
  iepdf_Write(Stream, '<< ');
  for i := 0 to items.count - 1 do
  begin
    iepdf_Write(Stream, '/' + AnsiString(items[i]) + ' ');
    TIEPDFObject(items.Objects[i]).Write(Stream);
    iepdf_Write(Stream, #10);
  end;
  iepdf_Write(Stream, '>>');
end;

procedure TIEPDFStreamObject.Write(Stream: TStream);
var
  i: integer;
begin
  Position := Stream.Position;
  //
  i := dict.items.IndexOf('Length');
  TObject(dict.items.Objects[i]).free;
  dict.items.Objects[i] := TIEPDFNumericObject.Create(length);
  //
  dict.Write(Stream);
  iepdf_Write(Stream, #10);
  iepdf_WriteLn(Stream, 'stream');
  Stream.Write(pbyte(data)^, length);
  iepdf_Write(Stream, #10);
  iepdf_Write(Stream, 'endstream');
end;

// write version and binary comment

procedure iepdf_WriteHeader(Stream: TStream);
begin
  iepdf_WriteLn(Stream, '%PDF-1.4'); // version
  iepdf_WriteLn(Stream, #200#210#240#254); // binary four random bytes
end;

function Pad(val: AnsiString; reqLen: integer; padchar: AnsiChar): AnsiString;
begin
  result := val;
  while length(result) < reqLen do
    result := padchar + result;
end;

// write cross reference table (xref), trailer, startxref and the end of file

procedure iepdf_WriteFooter(Stream: TStream; IndirectObjects: TList; info: TIEPDFObject);
var
  i: integer;
  xrefPos: integer;
begin
  // xref (cross reference table)
  xrefPos := Stream.Position;
  iepdf_WriteLn(Stream, 'xref'); // cross reference keyword
  iepdf_WriteLn(Stream, '0 ' + IEIntToStr(IndirectObjects.Count + 1)); // first object number and objects count
  iepdf_WriteLn(Stream, '0000000000 65535 f '); // first free object
  for i := 0 to IndirectObjects.Count - 1 do
    iepdf_Write(Stream, Pad(IEIntToStr(TIEPDFObject(IndirectObjects[i]).Position), 10, '0') + #32 + '00000' + #32 + 'n ' + #10);
  // trailer
  iepdf_WriteLn(Stream, 'trailer'); // trailer keyword
  iepdf_WriteLn(Stream, '<< /Size ' + IEIntToStr(IndirectObjects.Count + 1));
  iepdf_WriteLn(Stream, '/Root 1 0 R'); // root must be object number 1 (the first object defined)
  iepdf_WriteLn(Stream, '/Info ' + IEIntToStr(info.Index) + ' 0 R');
  iepdf_WriteLn(Stream, '>>');
  // startxref (defines xref position)
  iepdf_WriteLn(Stream, 'startxref');
  iepdf_WriteLn(Stream, IEIntToStr(xrefPos));
  // end of file
  iepdf_WriteLn(Stream, '%%EOF');
end;

procedure iepdf_AddIndirectObject(IndirectObjects: TList; obj: TIEPDFObject);
begin
  IndirectObjects.Add(obj);
  obj.Index := IndirectObjects.Count;
end;

// encloses an object to make as indirect object

procedure iepdf_WriteIndirectObjects(Stream: TStream; IndirectObjects: TList);
var
  i, j: integer;
  obj: TIEPDFObject;
begin
  for i := 0 to IndirectObjects.Count - 1 do
  begin
    obj := TIEPDFObject(IndirectObjects[i]);
    j := Stream.Position;
    iepdf_WriteLn(Stream, IEIntToStr(obj.Index) + ' 0 obj');
    obj.Write(Stream);
    iepdf_Write(Stream, #10); // just new line
    iepdf_WriteLn(Stream, 'endobj');
    obj.Position := j; // adjust position to include indirect object info
  end;
end;

// prepares the empty root catalog, adding it to IndirectObjects list (must be empty but not nil)

function iepdf_AddCatalog(IndirectObjects: TList):TIEPDFDictionaryObject;
begin
  result := TIEPDFDictionaryObject.Create;
  result.items.AddObject('Type', TIEPDFNameObject.Create('Catalog'));
  iepdf_AddIndirectObject(IndirectObjects, result);
end;

// * add /Pages for the specified list of /Page tags
// * the list of pages is a list of indexes at the IndirectObjects list
// * add "/Parent" for each page

function iepdf_AddPageTree(IndirectObjects: TList; pages: TList):TIEPDFDictionaryObject;
var
  root, page: TIEPDFDictionaryObject;
  parr: TIEPDFArrayObject;
  i: integer;
begin
  result := TIEPDFDictionaryObject.Create;
  iepdf_AddIndirectObject(IndirectObjects, result);
  result.items.AddObject('Type', TIEPDFNameObject.Create('Pages'));
  parr := TIEPDFArrayObject.Create;
  for i := 0 to pages.Count - 1 do
  begin
    page := TIEPDFDictionaryObject(pages[i]);
    parr.Items.Add(TIEPDFRefObject.Create(page.Index, 0));
    // add parent tag foreach page
    page.items.AddObject('Parent', TIEPDFRefObject.Create(result.Index, 0));
  end;
  result.items.AddObject('Kids', parr);
  result.items.AddObject('Count', TIEPDFNumericObject.Create(pages.count));
  // update root catalog
  root := TIEPDFDictionaryObject(IndirectObjects[0]);
  root.items.AddObject('Pages', TIEPDFRefObject.Create(result.Index, 0));
end;

// add /Page object
// pages is updated with the new page index inside IndirectObjects
// Resources can be nil

procedure iepdf_AddPage(IndirectObjects: TList; pages: TList; Resources: TIEPDFDictionaryObject; MediaBox: TIEPDFArrayObject; Content: integer);
var
  page: TIEPDFDictionaryObject;
begin
  page := TIEPDFDictionaryObject.Create;
  page.items.AddObject('Type', TIEPDFNameObject.Create('Page'));
  if assigned(Resources) then
    page.items.AddObject('Resources', TIEPDFRefObject.Create(Resources.Index, 0));
  page.items.AddObject('MediaBox', MediaBox);
  page.items.AddObject('Contents', TIEPDFRefObject.Create(Content, 0));
  iepdf_AddIndirectObject(IndirectObjects, page);
  pages.Add(page); // do not free items of pages list
end;

{$endif}  // IEINCLUDEPDFWRITING

// End of PDF Support
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Windows CMS functions




var
  mscms:THandle;

function LoadMSCMS:boolean;
begin
  if mscms = 0 then
  begin
    // try to load the mscms.dll dynamic library
    mscms := LoadLibrary('mscms.dll');
    if mscms<>0 then
    begin
      IE_OpenColorProfile := GetProcAddress(mscms, 'OpenColorProfileA');
      IE_CloseColorProfile := GetProcAddress(mscms, 'CloseColorProfile');
      IE_CreateMultiProfileTransform := GetProcAddress(mscms, 'CreateMultiProfileTransform');
      IE_DeleteColorTransform := GetProcAddress(mscms, 'DeleteColorTransform');
      IE_TranslateColors := GetProcAddress(mscms, 'TranslateColors');
    end;
  end;
  result:=mscms<>0;
end;

// End of Windows CMS functions
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEICC

// UseLCMS=true works only when IEINCLUDECMS is defined, otherwise it is always False
constructor TIEICC.Create(UseLCMS:boolean=true);
begin
  inherited Create;
  {$ifdef IEINCLUDECMS}
    fUseLCMS:=UseLCMS;
  {$else}
    fUseLCMS:=false;
  {$endif}
  fRaw:=nil;
  fRawLen:=0;
  fProfile:=nil;
  fProfileStream:=nil;
  fTransform:=nil;
  fInputFormat:=0;
  fOutputFormat:=0;
  fDestination:=nil;
  fIntent:=0;
  fFlags:=0;
  fApplied:=false;
  fMSProfile:=0;
  fMSTransform:=0;
end;

destructor TIEICC.Destroy;
begin
  Clear;
  inherited Destroy;
end;

{!!
<FS>TIEICC.LoadFromBuffer

<FM>Declaration<FC>
procedure LoadFromBuffer(buffer:pointer; bufferlen:integer);

<FM>Description<FN>
Loads the ICC profile from the specified buffer. This is called automatically when you load an image from file.
!!}
procedure TIEICC.LoadFromBuffer(buffer:pointer; bufferlen:integer);
begin
  Clear;
  fRawLen:=bufferlen;
  getmem(fRaw,bufferlen);
  copymemory(fRaw,buffer,bufferlen);
  OpenProfileFromRaw;
end;

{!!
<FS>TIEICC.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Close the profile and free all allocated buffers.
!!}
procedure TIEICC.Clear;
begin
  CloseProfileFromRaw;
  if fRaw<>nil then
    freemem(fRaw);
  fRaw:=nil;
  fRawLen:=0;
  fApplied:=false;
end;

{!!
<FS>TIEICC.IsValid

<FM>Declaration<FC>
function IsValid:boolean;

<FM>Description<FN>
Returns true if the current loaded ICC profile is valid.
!!}
function TIEICC.IsValid:boolean;
begin
  result:= (fProfile<>nil) or (fMSProfile<>0);
end;

{!!
<FS>TIEICC.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream:TStream; StandardICC:boolean);

<FM>Description<FN>
Saves current ICC to a stream. If StandardICC is False an header which specifies the ICC block size is added. Otherwise saves as standard ICC.
!!}
procedure TIEICC.SaveToStream(Stream:TStream; StandardICC:boolean);
begin
  if not StandardICC then
  begin
    // non standard ICC (this means it has a 32 bit header with the ICC size)
    // use this only inside TIOParamsVals.SaveToStream and LoadFromStream!
    Stream.Write(fRawLen,sizeof(integer));
    Stream.Write(fRaw^,fRawLen);
  end
  else
  begin
    // standard ICC
    Stream.Write(fRaw^,fRawLen);
  end;
end;

{!!
<FS>TIEICC.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream:TStream; StandardICC:boolean);

<FM>Description<FN>
Loads an ICC from the stream. If StandardICC is False an header is espected to know the ICC block size.
!!}
procedure TIEICC.LoadFromStream(Stream:TStream; StandardICC:boolean);
begin
  Clear;
  if not StandardICC then
  begin
    // non standard ICC (this means it has a 32 bit header with the ICC size)
    // use this only inside TIOParamsVals.SaveToStream and LoadFromStream!
    Stream.Read(fRawLen,sizeof(integer));
    getmem(fRaw,fRawLen);
    Stream.Read(fRaw^,fRawLen);
  end
  else
  begin
    // standard ICC
    // it assumes the stream contains only the ICC profile
    fRawLen:=Stream.Size;
    getmem(fRaw,fRawLen);
    Stream.Read(fRaw^,fRawLen);
  end;
  OpenProfileFromRaw;
end;

{!!
<FS>TIEICC.LoadFromFile

<FM>Declaration<FC>
procedure LoadFromFile(const FileName:string);

<FM>Description<FN>
Loads an ICC from the file. The file should have .icc extension.
!!}
procedure TIEICC.LoadFromFile(const FileName:string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(fs,true);
  finally
    fs.free;
  end;
end;

{!!
<FS>TIEICC.Assign

<FM>Declaration<FC>
procedure Assign(source:<A TIEICC>);

<FM>Description<FN>
Copies a profile from source.
!!}
procedure TIEICC.Assign(source:TIEICC);
begin
  Clear;
  fRawLen:=source.fRawLen;
  getmem(fRaw,fRawLen);
  copymemory(fRaw,source.fRaw,fRawLen);
  OpenProfileFromRaw;
end;

procedure TIEICC.OpenProfileFromRaw;
var
  prof:IE_PROFILE;
begin
  if fUseLCMS then
  begin
    {$ifdef IEINCLUDECMS}
    // use lcms
    fProfileStream := TIEMemStream.Create(fRaw,fRawLen);
    fProfile := IEcmsOpenProfileFromFile(fProfileStream,false,false);
    {$endif}
  end
  else
  begin
    // use mscms
    if LoadMSCMS then
    begin
      prof.dwType:=IE_PROFILE_MEMBUFFER;
      prof.pProfileData:=fRaw;
      prof.cbDataSize:=fRawLen;
      fMSProfile:=IE_OpenColorProfile(@prof,IE_PROFILE_READ,FILE_SHARE_READ,OPEN_EXISTING);
    end;
  end;
  ExtractInfo;
end;

procedure TIEICC.CloseProfileFromRaw;
begin
  FreeTransform; // in case it was actived
  if fUseLCMS then
  begin
    {$ifdef IEINCLUDECMS}
    if fProfile<>nil then
      IEcmsCloseProfile(fProfile);
    if fProfileStream<>nil then
      FreeAndNil(fProfileStream);
    {$endif}
  end
  else
  begin
    // use mscms
    if fMSProfile<>0 then
      IE_CloseColorProfile(fMSProfile);
  end;
  fMSProfile:=0;
  fProfile:=nil;
  fProfileStream:=nil;
  fInputFormat:=0;
  fOutputFormat:=0;
  fDestination:=nil;
  fIntent:=0;
  fFlags:=0;
end;

function TIEICC.IsTransforming:boolean;
begin
  if fUseLCMS then
    result:=fTransform<>nil
  else
    result:=fMSTransform<>0;
end;

{!!
<FS>TIEICC.FreeTransform

<FM>Declaration<FC>
procedure FreeTransform;

<FM>Description<FN>
Free memory allocated to perform Transform, <A TIEICC.Apply> or <A TIEICC.Apply2>.
!!}
procedure TIEICC.FreeTransform;
begin
  if fUseLCMS then
  begin
    {$ifdef IEINCLUDECMS}
    if fTransform<>nil then
    begin
      IEcmsDeleteTransform(fTransform);
      fApplied:=true;
    end;
    {$endif}
  end
  else
  begin
    // use mscms
    if fMSTransform<>0 then
    begin
      IE_DeleteColorTransform(fMSTransform);
      fApplied:=true;
    end;
  end;
  fMSTransform:=0;
  fTransform:=nil;
end;

{!!
<FS>TIEICC.Transform

<FM>Declaration<FC>
function Transform(Destination:<A TIEICC>; InputFormat:integer; OutputFormat:integer; Intent:integer; Flags:integer; InputBuffer:pointer; OutputBuffer:pointer; ImageWidth:integer):boolean;

<FM>Description<FN>
Transforms a row from current profile to the destination profile. You have to call FreeTransform after the whole image has been transformed.
Returns False if it cannot perform the transformation.
InputFormat and OutputFormat : The color format for the input and the output. Look below for a list of supported color formats.
Intent: The ICC intent to apply. If an appropiate tag for this intent is not found, no error is raised and the intent is reverted to perceptual.
              INTENT_PERCEPTUAL
              INTENT_RELATIVE_COLORIMETRIC
              INTENT_SATURATION
              INTENT_ABSOLUTE_COLORIMETRIC
Flags: This value commands on how to handle the whole process. Some or none of this values can be joined via the 'or' operator.
<TABLE>
<R> <C>cmsFLAGS_MATRIXINPUT</C> <C>CLUT ignored on input profile, matrix-shaper used instead (for speed, and debugging purposes)</C>
<R> <C>cmsFLAGS_MATRIXOUTPUT</C> <C>Same as anterior, but for output profile only.</C>
<R> <C>cmsFLAGS_NOTPRECALC</C> <C>By default, lcms smelt luts into a device-link CLUT. This speedup whole transform greatly. If you don't wanna this, and wish every value to be translated to PCS and back to output space, include this flag.</C>
<R> <C>vcmsFLAGS_NULLTRANFORM</C> <C>Don't transform anyway, only apply pack/unpack routines (usefull to deactivate color correction but keep formatting capabilities)</C>
<R> <C>cmsFLAGS_HIGHRESPRECALC</C> <C>Use 48 points instead of 33 for device-link CLUT precalculation. Not needed but for the most extreme cases of mismatch of "impedance" between profiles.</C>
<R> <C>cmsFLAGS_LOWRESPRECALC</C> <C>Use lower resolution table. Usefull when memory is a preciated resource.</C>
<R> <C>cmsFLAGS_BLACKPOINTCOMPENSATION</C> <C>Use BPC algorithm.
</TABLE>

<A TIEICC Supported Color Formats>
!!}
function TIEICC.Transform(Destination:TIEICC; InputFormat:integer; OutputFormat:integer; Intent:integer; Flags:integer; InputBuffer:pointer; OutputBuffer:pointer; ImageWidth:integer):boolean;
var
  mshprofs:array [0..1] of IE_HPROFILE;
  msintent:array [0..1] of dword;
  i:integer;
  buf_src,buf_dst:pword;
  pw,pw2:pword;
  pb:pbyte;
begin

  if fUseLCMS then
  begin

    {$ifdef IEINCLUDECMS}
    if (fTransform=nil) or (fInputFormat<>InputFormat) or (fOutputFormat<>OutputFormat) or (fIntent<>Intent) or (fFlags<>Flags) then
    begin
      // initialize transform
      FreeTransform;  // if it was already created
      fTransform:=IEcmsCreateTransform(fProfile,InputFormat,Destination.fProfile,OutputFormat,Intent,Flags);
      fInputFormat:=InputFormat;
      fOutputFormat:=OutputFormat;
      fIntent:=Intent;
      fFlags:=Flags;
    end;
    if fTransform<>nil then
    begin
      IEcmsDoTransform(fTransform,InputBuffer,OutputBuffer,ImageWidth);
    end;
    {$endif}

  end
  else
  begin

    // use mscms
    if (fMSTransform=0) or (fInputFormat<>InputFormat) or (fOutputFormat<>OutputFormat) or (fIntent<>Intent) or (fFlags<>Flags) then
    begin
      FreeTransform;
      msintent[0]:=IE_INTENT_PERCEPTUAL;
      msintent[1]:=IE_INTENT_PERCEPTUAL;
      mshprofs[0]:=fMSProfile;
      mshprofs[1]:=Destination.fMSProfile;
      fMSTransform:=IE_CreateMultiProfileTransform(@mshprofs[0],2,@msintent[0],2,IE_BEST_MODE or IE_USE_RELATIVE_COLORIMETRIC,IE_INDEX_DONT_CARE);
      fInputFormat:=InputFormat;
      fOutputFormat:=OutputFormat;
      fIntent:=Intent;
      fFlags:=Flags;
    end;
    if fMSTransform<>0 then
    begin
      getmem(buf_src,8*ImageWidth);
      getmem(buf_dst,8*ImageWidth);

      case TIEColorSpace(InputFormat) of
        iecmsRGB:
          begin
            pw:=buf_src;
            pb:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=pb^ *257; inc(pw); inc(pb); // r
              pw^:=pb^ *257; inc(pw); inc(pb); // g
              pw^:=pb^ *257; inc(pw); inc(pb); // b
              inc(pw);
            end;
          end;
        iecmsBGR:
          begin
            _BGR2RGB(InputBuffer,ImageWidth);
            pw:=buf_src;
            pb:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=pb^ *257; inc(pw); inc(pb); // r
              pw^:=pb^ *257; inc(pw); inc(pb); // g
              pw^:=pb^ *257; inc(pw); inc(pb); // b
              inc(pw);
            end;
          end;
        iecmsCMYK:
          begin
            pw:=buf_src;
            pb:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=(255-pb^) *257; inc(pw); inc(pb); // c
              pw^:=(255-pb^) *257; inc(pw); inc(pb); // m
              pw^:=(255-pb^) *257; inc(pw); inc(pb); // y
              pw^:=(255-pb^) *257; inc(pw); inc(pb); // k
            end;
          end;
        iecmsCMYK6:
          begin
            pw:=buf_src;
            pb:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=pb^ *257; inc(pw); inc(pb); // c
              pw^:=pb^ *257; inc(pw); inc(pb); // m
              pw^:=pb^ *257; inc(pw); inc(pb); // y
              pw^:=pb^ *257; inc(pw); inc(pb); // k
              inc(pb,2);
            end;
          end;
        iecmsCIELab:
          begin
            pw:=buf_src;
            pb:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=pb^ *257; inc(pw); inc(pb);
              pw^:=pb^ *257; inc(pw); inc(pb);
              pw^:=pb^ *257; inc(pw); inc(pb);
              inc(pw);
            end;
          end;
        iecmsGray8:
          begin
            pw:=buf_src;
            pb:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=pb^ *257; inc(pw); inc(pb);
              inc(pw,3);
            end;
          end;
        iecmsRGB48:
          begin
            pw:=buf_src;
            pw2:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=pw2^; inc(pw); inc(pw2); // r
              pw^:=pw2^; inc(pw); inc(pw2); // g
              pw^:=pw2^; inc(pw); inc(pw2); // b
              inc(pw);
            end;
          end;
        iecmsRGB48_SE:
          begin
            pw:=buf_src;
            pw2:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=IESwapWord(pw2^); inc(pw); inc(pw2); // r
              pw^:=IESwapWord(pw2^); inc(pw); inc(pw2); // g
              pw^:=IESwapWord(pw2^); inc(pw); inc(pw2); // b
              inc(pw);
            end;
          end;
        iecmsYCBCR:
          begin
            pw:=buf_src;
            pb:=InputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pw^:=pb^ *257 ; inc(pw); inc(pb);
              pw^:=pb^ *257 ; inc(pw); inc(pb);
              pw^:=pb^ *257 ; inc(pw); inc(pb);
              inc(pw);
            end;
          end;
      end;

      IE_TranslateColors(fMSTransform, buf_src, ImageWidth, IE_CS2IF[InputFormat], buf_dst, IE_CS2IF[OutputFormat]);

      case TIEColorSpace(OutputFormat) of
        iecmsRGB:
          begin
          end;
        iecmsBGR:
          begin
            pw:=buf_dst;
            pb:=OutputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pb^:=pw^ shr 8; inc(pw); inc(pb);  // r
              pb^:=pw^ shr 8; inc(pw); inc(pb);  // g
              pb^:=pw^ shr 8; inc(pw); inc(pb);  // b
              inc(pw);
            end;
            _BGR2RGB(OutputBuffer,ImageWidth);
          end;
        iecmsCMYK:
          begin
            pw:=buf_dst;
            pb:=OutputBuffer;
            for i:=0 to ImageWidth-1 do
            begin
              pb^:=255- pw^ shr 8; inc(pw); inc(pb);  // c
              pb^:=255- pw^ shr 8; inc(pw); inc(pb);  // m
              pb^:=255- pw^ shr 8; inc(pw); inc(pb);  // y
              pb^:=255- pw^ shr 8; inc(pw); inc(pb);  // k
              inc(pw);
            end;
          end;
        iecmsCMYK6:
          begin
          end;
        iecmsCIELab:
          begin
          end;
        iecmsGray8:
          begin
          end;
        iecmsRGB48:
          begin
          end;
        iecmsRGB48_SE:
          begin
          end;
      end;


      freemem(buf_src);
      freemem(buf_dst);

    end;

  end;

  result:= (fTransform<>nil) or (fMSTransform<>0);
  
end;

{!!
<FS>TIEICC.Apply

<FM>Declaration<FC>
function Apply(SourceBitmap:<A TIEBitmap>; SourceFormat:integer; DestinationBitmap:<A TIEBitmap>; DestinationFormat:integer; DestinationProfile:<A TIEICC>; Intent:integer; Flags:integer):boolean;

<FM>Description<FN>
Transforms a bitmap from current profile to the destination profile. Look at <A TIEICC.Transform> for parameters description.
You have to call <A TIEICC.FreeTransform> after the whole image has been transformed.
Returns False if it cannot perform the transformation.

<A TIEICC Supported Color Formats>
!!}
function TIEICC.Apply(SourceBitmap:TIEBitmap; SourceFormat:integer; DestinationBitmap:TIEBitmap; DestinationFormat:integer; DestinationProfile:TIEICC; Intent:integer; Flags:integer):boolean;
var
  y:integer;
begin
  result:=false;

  // make sure sizes match
  DestinationBitmap.Width:=SourceBitmap.Width;
  DestinationBitmap.Height:=SourceBitmap.Height;

  for y:=0 to SourceBitmap.Height-1 do
  begin
    result:=Transform(DestinationProfile,SourceFormat,DestinationFormat,Intent,Flags,SourceBitmap.Scanline[y],DestinationBitmap.Scanline[y],SourceBitmap.Width);
    if not result then
      exit;
  end;
end;

{!!
<FS>TIEICC.Apply2

<FM>Declaration<FC>
function Apply2(Bitmap:<A TIEBitmap>; SourceFormat:integer; DestinationFormat:integer; DestinationProfile:<A TIEICC>; Intent:integer; Flags:integer):boolean;

<FM>Description<FN>
Transforms the same bitmap from current profile to the destination profile. Look at <A TIEICC.Transform> for parameters description.
You have to call <A TIEICC.FreeTransform> after the whole image has been transformed.
Returns False if it cannot perform the transformation.

<A TIEICC Supported Color Formats>
!!}
function TIEICC.Apply2(Bitmap:TIEBitmap; SourceFormat:integer; DestinationFormat:integer; DestinationProfile:TIEICC; Intent:integer; Flags:integer):boolean;
var
  y:integer;
begin
  result:=false;

  for y:=0 to Bitmap.Height-1 do
  begin
    result:=Transform(DestinationProfile,SourceFormat,DestinationFormat,Intent,Flags,Bitmap.Scanline[y],Bitmap.Scanline[y],Bitmap.Width);
    if not result then
      exit;
  end;
end;

{!!
<FS>TIEICC.ConvertBitmap

<FM>Declaration<FC>
function ConvertBitmap(Bitmap:TIEBitmap; DestPixelFormat:TIEPixelFormat; DestProfile:TIEICC):boolean;

<FM>Description<FN>
Transforms the same bitmap from current profile to the destination profile.
Returns False if it cannot perform the transformation.

<A TIEICC Supported Color Formats>
!!}
function TIEICC.ConvertBitmap(Bitmap:TIEBitmap; DestPixelFormat:TIEPixelFormat; DestProfile:TIEICC):boolean;
{$ifdef IEINCLUDECMS}
const
  CCTOCMS:array [iecmsRGB..iecmsYCBCR] of integer = (TYPE_RGB_8, TYPE_BGR_8, TYPE_CMYK_8_REV, TYPE_CMYKcm_8, TYPE_Lab_8, TYPE_GRAY_8, TYPE_RGB_16, TYPE_RGB_16_SE, TYPE_YCbCr_8);
{$endif}
var
  y:integer;
  dest:TIEBitmap;
  SourceFormat, DestinationFormat:TIEColorSpace;
begin
  result:=false;

  case Bitmap.PixelFormat of
    ie8g:
      SourceFormat:=iecmsGray8;
    ie24RGB:
      SourceFormat:=iecmsBGR;
    ieCMYK:
      SourceFormat:=iecmsCMYK;
    ie48RGB:
      SourceFormat:=iecmsRGB48;
    ieCIELab:
      SourceFormat:=iecmsCIELab;
    else
      exit;
  end;

  case DestPixelFormat of
    ie8g:
      DestinationFormat:=iecmsGray8;
    ie24RGB:
      DestinationFormat:=iecmsBGR;
    ieCMYK:
      DestinationFormat:=iecmsCMYK;
    ie48RGB:
      DestinationFormat:=iecmsRGB48;
    ieCIELab:
      DestinationFormat:=iecmsCIELab;
    else
      exit;
  end;

  dest:=TIEBitmap.Create(Bitmap.Width,Bitmap.Height,DestPixelFormat);

  for y:=0 to Bitmap.Height-1 do
    {$ifdef IEINCLUDECMS}
      Transform(DestProfile,CCTOCMS[SourceFormat],CCTOCMS[DestinationFormat],INTENT_PERCEPTUAL, 0 ,Bitmap.ScanLine[y],dest.Scanline[y],Bitmap.Width);
    {$else}
      Transform(DestProfile,integer(SourceFormat),integer(DestinationFormat),0, 0 ,Bitmap.ScanLine[y],dest.Scanline[y],Bitmap.Width);
    {$endif}

  FreeTransform;
  Bitmap.AssignImage( dest );
  dest.Free;
  result:=true;
end;

{!!
<FS>TIEICC.Assign_sRGBProfile

<FM>Declaration<FC>
procedure Assign_sRGBProfile;

<FM>Description<FN>
Loads the predefined sRGB profile.
!!}
procedure TIEICC.Assign_sRGBProfile;
var
  prof:IE_PROFILE;
begin
  Clear;

  if fUseLCMS then
  begin

    {$ifdef IEINCLUDECMS}
    fProfile := IEcmsCreate_sRGBProfile;
    {$endif}

  end
  else
  begin

    // use mscms, reading the system file 'sRGB Color Space Profile.icm'
    if LoadMSCMS then
    begin
      prof.dwType:=IE_PROFILE_FILENAME;
      prof.pProfileData:=PAnsiChar('sRGB Color Space Profile.icm');
      prof.cbDataSize:=length('sRGB Color Space Profile.icm');
      fMSProfile:=IE_OpenColorProfile(@prof,IE_PROFILE_READ,FILE_SHARE_READ,OPEN_EXISTING);
    end;

  end;
  
end;


{!!
<FS>TIEICC.Assign_LabProfile

<FM>Declaration<FC>
procedure Assign_LabProfile(WhitePoint_x, WhitePoint_y, WhitePoint_Y_:double);

<FM>Description<FN>
Creates a new Lab profile based on specified white points.
!!}
procedure TIEICC.Assign_LabProfile(WhitePoint_x, WhitePoint_y, WhitePoint_Y_:double);
begin
  Clear;
  if fUseLCMS then
  begin
    {$ifdef IEINCLUDECMS}
    fProfile := IEcmsCreateLabProfile( WhitePoint_x, WhitePoint_y, WhitePoint_Y_ );
    {$endif}
  end;
end;

{!!
<FS>TIEICC.Assign_LabProfileFromTemp

<FM>Declaration<FC>
procedure Assign_LabProfileFromTemp(TempK:integer);

<FM>Description<FN>
Creates a new Lab color profile based on specified temperature.
!!}

procedure TIEICC.Assign_LabProfileFromTemp(TempK:integer);
{$ifdef IEINCLUDECMS}
var
  WhitePoint_x, WhitePoint_y, WhitePoint_Y_:double;
{$endif}
begin
  Clear;
  if fUseLCMS then
  begin
    {$ifdef IEINCLUDECMS}
    IEcmsWhitePointFromTemp(TempK,WhitePoint_x, WhitePoint_y, WhitePoint_Y_);
    fProfile := IEcmsCreateLabProfile( WhitePoint_x, WhitePoint_y, WhitePoint_Y_ );
    {$endif}
  end;
end;

{!!
<FS>TIEICC.Assign_LabProfileD50

<FM>Declaration<FC>
procedure Assign_LabProfileD50;

<FM>Description<FN>
Creates a new Lab D59 color profile.
!!}
procedure TIEICC.Assign_LabProfileD50;
begin
  Clear;
  if fUseLCMS then
  begin
    {$ifdef IEINCLUDECMS}
    fProfile := IEcmsCreateLabProfileD50;
    {$endif}
  end;
end;

{!!
<FS>TIEICC.Assign_XYZProfile

<FM>Declaration<FC>
procedure Assign_XYZProfile;

<FM>Description<FN>
Creates a XYZ color profile.
!!}
procedure TIEICC.Assign_XYZProfile;
begin
  Clear;
  if fUseLCMS then
  begin
    {$ifdef IEINCLUDECMS}
    fProfile := IEcmsCreateXYZProfile;
    {$endif}
  end;
end;

// parses the raw profile to extract info
procedure TIEICC.ExtractInfo;
var
  p:pbyte;
  tagCount,i:integer;
  tagSign:array [0..3] of AnsiChar;
  tagOffset:integer;
  tagSize:integer;

  procedure ParseTag;
  var
    tp:pbyte;
  begin
    tp:=fRaw;
    inc(tp,tagOffset);
    if (tagSign='cprt') and (tagSize<1000) then
    begin
      inc(tp,8);
      if strlen(PAnsiChar(tp))<1000 then
        fCopyright:=PAnsiChar(tp);
    end
    else if (tagSign='desc') and (tagSize<1000) then
    begin
      inc(tp,12);
      if strlen(PAnsiChar(tp))<1000 then
        fDescription:=PAnsiChar(tp);
    end;
  end;

begin
  fCopyright:='';
  fDescription:='';
  if (fRaw<>nil) and (fRawLen>128) then
  begin
    p:=pbyte(fRaw);
    // by pass header
    inc(p,128);
    // tag count
    tagCount:=IESwapDWord(pinteger(p)^); inc(p,4);
    if (tagCount>1000) or (tagCount<0) then
      exit;
    // read tags
    for i:=0 to tagCount-1 do
    begin
      Move(p^,tagSign[0],4); inc(p,4);
      tagOffset:=IESwapDWord(pinteger(p)^); inc(p,4);
      tagSize:=IESwapDWord(pinteger(p)^); inc(p,4);
      if (tagOffset>fRawLen) or (tagOffset<0) then
        exit;
      if (tagSize>fRawLen) or (tagSize<0) then
        exit;
      ParseTag;
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function IEIsRemoteSession : boolean;
const
  SM_REMOTESESSION = $1000;
begin
  result := Windows.GetSystemMetrics( SM_REMOTESESSION ) <> 0;
end;


procedure InitIECosineTab;
var
  i: integer;
begin
  for i := 0 to 255 do
    IECosineTab[i] := Round(64 - Cos(i * Pi / 255) * 64);
end;

procedure IEBezier2D4Controls(p0:TPoint; c0:TPoint; c1:TPoint; p1:TPoint; pResultArray:PPointArray; nSteps:integer);
var
  t, t_sq, t_cb, incr, r1, r2, r3, r4:double   ;
  i:integer      ;
begin
  incr:=1.0/nSteps;
  t:=incr;
  for i:=0 to nSteps-1 do
  begin
     t_sq := t * t;
     t_cb := t * t_sq;
     r1   := 1 - 3*t + 3*t_sq -   t_cb;
     r2   :=     3*t - 6*t_sq + 3*t_cb;
     r3   :=           3*t_sq - 3*t_cb;
     r4   :=                      t_cb;
     pResultArray[i].x := round(r1*p0.x + r2*c0.x + r3*c1.x + r4*p1.x);
     pResultArray[i].y := round(r1*p0.y + r2*c0.y + r3*c1.y + r4*p1.y);
     t:=t+incr;
  end;
end;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


procedure IEencodeblock64( xin:pbytearray; xout:PAnsiChar; len:integer );
const
  cb64:array [0..63] of AnsiChar='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  function myif(e:boolean; v1,v2:AnsiChar):AnsiChar;
  begin
    if e then
      result:=v1
    else
      result:=v2;
  end;
begin
  xout[0] := cb64[ xin[0] shr 2 ];
  xout[1] := cb64[ ((xin[0] and $03) shl 4) or ((xin[1] and $f0) shr 4) ];
  xout[2] := myif(len > 1 , cb64[ ((xin[1] and $0f) shl 2) or ((xin[2] and $c0) shr 6) ] , '=');
  xout[3] := myif(len > 2 , cb64[ xin[2] and $3f ] , '=');
end;

procedure IEencode64( infile:TStream; var outfile:textfile; linesize:integer );
var
  xin:array [0..2] of byte;
  xout:array [0..3] of AnsiChar;
  i, len, blocksout:integer;
begin
  blocksout := 0;
  while infile.Position<infile.Size do
  begin
    len := 0;
    for i:=0 to 2 do
    begin
      infile.Read( xin[i] , 1);
      if infile.Position<infile.Size then
        inc(len)
      else
        xin[i] := 0;
    end;
    if( len>0 ) then
    begin
      IEencodeblock64( @xin, xout, len );
      for i:=0 to 3 do
        Write(outfile,xout[i]);
      inc(blocksout);
    end;
    if( blocksout >= (linesize/4)) or (infile.Position>=infile.Size) then
    begin
      if( blocksout>0 ) then
        WriteLn(outfile,'');
      blocksout := 0;
    end;
  end;
end;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


const
WSB_PROP_CYVSCROLL  =$00000001;
WSB_PROP_CXHSCROLL  =$00000002;
WSB_PROP_CYHSCROLL  =$00000004;
WSB_PROP_CXVSCROLL  =$00000008;
WSB_PROP_CXHTHUMB   =$00000010;
WSB_PROP_CYVTHUMB   =$00000020;
WSB_PROP_VBKGCOLOR  =$00000040;
WSB_PROP_HBKGCOLOR  =$00000080;
WSB_PROP_VSTYLE     =$00000100;
WSB_PROP_HSTYLE     =$00000200;
WSB_PROP_WINSTYLE   =$00000400;
WSB_PROP_PALETTE    =$00000800;
WSB_PROP_MASK       =$00000FFF;

FSB_FLAT_MODE        =   2;
FSB_ENCARTA_MODE     =   1;
FSB_REGULAR_MODE     =   0;

procedure IESetScrollBar(hWnd:HWND; nBar:integer; nMinPos:integer; nMaxPos:integer; PageSize:integer; nPos:integer; bRedraw:boolean; flat:boolean);
var
  ScrollInfo: TScrollInfo;
begin
  FillChar(ScrollInfo, sizeof(ScrollInfo), 0);
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
  ScrollInfo.fMask := SIF_RANGE or SIF_POS or SIF_PAGE;
  ScrollInfo.nMin := nMinPos;
  ScrollInfo.nMax := nMaxPos;
  ScrollInfo.nPos := nPos;
  ScrollInfo.nPage := PageSize;
  IESetScrollInfo(hWnd, nBar, ScrollInfo, bRedraw, flat);
end;


// 3.0.3
function IESetScrollRange(hWnd: HWND; nBar, nMinPos, nMaxPos: Integer; bRedraw: BOOL; flat:boolean): BOOL;
var
  ScrollInfo: TScrollInfo;
begin
  FillChar(ScrollInfo, sizeof(ScrollInfo), 0);
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
  ScrollInfo.fMask := SIF_RANGE;
  ScrollInfo.nMin := nMinPos;
  ScrollInfo.nMax := nMaxPos;
  IESetScrollInfo(hWnd, nBar, ScrollInfo, bRedraw, flat);
  result := true;
end;

// 3.0.3
function IESetScrollPos(hWnd: HWND; nBar, nPos: Integer; bRedraw: BOOL; flat:boolean): Integer;
var
  ScrollInfo: TScrollInfo;
begin
  FillChar(ScrollInfo, sizeof(ScrollInfo), 0);
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
  ScrollInfo.fMask := SIF_POS;
  ScrollInfo.nPos := nPos;
  result := IESetScrollInfo(hWnd, nBar, ScrollInfo, bRedraw, flat);
end;

// Set cursor size (pagesize) of a scroll bar
// fnBar can be SB_HORZ or SB_VERT
procedure IESetSBPageSize(HScrollBar: THandle; fnBar: integer; PageSize: Integer; Redraw: boolean; flat:boolean);
var
  ScrollInfo: TScrollInfo;
begin
  FillChar(ScrollInfo, sizeof(ScrollInfo), 0);
  ScrollInfo.cbSize := Sizeof(ScrollInfo);
  ScrollInfo.fMask := SIF_PAGE;
  ScrollInfo.nPage := PageSize;
  IESetScrollInfo(HScrollBar, fnBar, ScrollInfo, Redraw, flat);
end;

function IESetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL; flat:boolean): Integer;
begin
  {$ifdef IEINCLUDEFLATSB}
  if flat then
    result:=FlatSB_SetScrollInfo(hWnd,BarFlag,ScrollInfo,Redraw)
  else
    result:=SetScrollInfo(hWnd,BarFlag,ScrollInfo,Redraw);
  {$else}
  result:=SetScrollInfo(hWnd,BarFlag,ScrollInfo,Redraw);
  {$endif}
end;

function IEEnableScrollBar(hWnd: HWND; wSBflags, wArrows: UINT; flat:boolean): BOOL;
begin
  {$ifdef IEINCLUDEFLATSB}
  if flat then
  begin
    result:=FlatSB_EnableScrollBar(hWnd,wSBflags, wArrows);
  end
  else
    result:=EnableScrollBar(hWnd,wSBflags, wArrows);
  {$else}
  result:=EnableScrollBar(hWnd,wSBflags, wArrows);
  {$endif}
end;

function IEShowScrollBar(hWnd: HWND; wBar: Integer; bShow: BOOL; flat:boolean): BOOL;
begin
  {$ifdef IEINCLUDEFLATSB}
  if flat then
  begin
    result:=FlatSB_ShowScrollBar(hWnd,wBar,bShow);
  end
  else
    result:=ShowScrollBar(hWnd,wBar,bShow);
  {$else}
  result:=ShowScrollBar(hWnd,wBar,bShow);
  {$endif}
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function IEIFI(cond:boolean; val1,val2:integer):integer;
begin
  if cond then
    result:=val1
  else
    result:=val2;
end;

function IEIFD(cond:boolean; val1,val2:double):double;
begin
  if cond then
    result:=val1
  else
    result:=val2;
end;

procedure IEAdjustEXIFOrientation(Bitmap:TIEBitmap; Orientation:integer);
begin
  if (Orientation <> 1) then
  begin
    case Orientation of
      2: // 0th row = top of the image, 0th column = right-hand side.
        begin
          _FlipEx(Bitmap, fdHorizontal);
        end;
      3: // 0th row = bottom of the image, 0th column = right-hand side.
        begin
          _FlipEx(Bitmap, fdVertical);
          _FlipEx(Bitmap, fdHorizontal);
        end;
      4: // 0th row = bottom of the image, 0th column = left-hand side.
        begin
          _FlipEx(Bitmap, fdVertical);
        end;
      5: // 0th row = left-hand side of the image, 0th column = visual top.
        begin
          _RotateEx(Bitmap, 90, false, creatergb(0, 0, 0), nil, nil);
          _FlipEx(Bitmap, fdHorizontal);
        end;
      6: // 0th row = right-hand side of the image, 0th column = visual top.
        begin
          _RotateEx(Bitmap, -90, false, creatergb(0, 0, 0), nil, nil);
        end;
      7: // 0th row = right-hand side of the image, 0th column = visual bottom.
        begin
          _RotateEx(Bitmap, -90, false, creatergb(0, 0, 0), nil, nil);
          _FlipEx(Bitmap, fdHorizontal);
        end;
      8: // 0th row = left-hand side of the image, 0th column = visual bottom.
        begin
          _RotateEx(Bitmap, 90, false, creatergb(0, 0, 0), nil, nil);
        end;
    end;
  end;
end;

// swap word if sc=true
function IECSwapWord(i: word; sc: boolean): word;
begin
  if sc then
    result := hibyte(i) or (lobyte(i) shl 8)
  else
    result := i;
end;

// swap dword if sc=true
function IECSwapDWord(i: integer; sc: boolean): integer;
begin
  if sc then
  begin
    asm
         mov EAX,i
         bswap EAX
         mov @result,EAX
    end;
  end
  else
    result := i;
end;

procedure QuickSort1(L, R: Integer; CompareFunction:TIECompareFunction; SwapFunction:TIESwapFunction);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := L + (R - L) shr 1; // 3.0.4
    repeat
      while CompareFunction(I, P) < 0 do Inc(I);
      while CompareFunction(J, P) > 0 do Dec(J);
      if I <= J then
      begin
        if I=P then P:=J else if J=P then P:=I; // 2.2.5
        SwapFunction(I,J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort1(L, J, CompareFunction,SwapFunction);
    L := I;
  until I >= R;
end;

procedure IEQuickSort(ItemsCount:integer; CompareFunction:TIECompareFunction; SwapFunction:TIESwapFunction);
begin
  if ItemsCount>0 then
    QuickSort1(0, ItemsCount - 1, CompareFunction,SwapFunction);
end;

// returns the full file path
// Directory must contain the last '\'
function IEGetTempFileName(const Descriptor:string; const Directory:string):string;
begin
  repeat
    result := Directory + Descriptor + '-' + IntToHex(random(MAXINT),8) + '.tmp';
  until not IEFileExists(result);
end;

// returns the full file path
function IEGetTempFileName2:string;
var
  temppath:array[0..MAX_PATH] of Char;
  tp:string;
begin
  if DefTEMPPATH = '' then
  begin
    GetTempPath(250, temppath);
    tp := string(temppath);
  end
  else
    tp := DefTEMPPATH;
  result := IEGetTempFileName('ietemp',tp);
end;

function IEGetMem(ASize: dword): pointer;
begin
  result := VirtualAlloc(nil, ASize, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE);
end;
//  Frees memory
procedure IEFreeMem(var P);
begin
  VirtualFree(pointer(P), 0, MEM_RELEASE);
  pointer(P) := nil;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

{$ifdef IEUSEBUFFEREDSTREAM}
constructor TIEBufferedReadStream.Create(InputStream:TStream; BufferSize:integer; UseRelativePosition:boolean);
begin
  inherited Create;
  if UseRelativePosition then
    fRelativePosition := InputStream.Position
  else
    fRelativePosition := 0;
  fStream := InputStream;
  fSize := InputStream.Size;
  fPosition := InputStream.Position;
  fMemory := nil;
  fOverPosition := false;
  AllocBufferSize(BufferSize);
end;

procedure TIEBufferedReadStream.AllocBufferSize(BufferSize:integer);
begin
  if fMemory<>nil then
    freemem(fMemory);
  fBufferSize := BufferSize;
  getmem(fMemory, BufferSize);
  LoadData;
end;

destructor TIEBufferedReadStream.Destroy;
begin
  freemem(fMemory);
  inherited Destroy;
end;

// read data of length fBufferSize
procedure TIEBufferedReadStream.LoadData;
begin
  fStream.Position := fPosition;
  fStream.Read(pbyte(fMemory)^, fBufferSize);
  fPositionBuf := 0;
end;

// 3.0.0b3, 3.0.1
function TIEBufferedReadStream.Read(var Buffer; Count: longint): Longint;
var
  mx:integer;
  b:pbyte;
begin

  fOverPosition := false;

  result := 0;
  if Count > (fSize-fPosition) then
  begin
    Count := fSize-fPosition;
    fOverPosition := true;
  end;

  b := pbyte(@Buffer);
  if Count=1 then
  begin
    if fBufferSize=fPositionBuf then
      LoadData;
    b^ := fMemory[fPositionBuf];
    inc(fPositionBuf);
    inc(fPosition);
    result := 1;
  end
  else if Count>1 then
  begin
    while true do
    begin
      if Count < (fBufferSize-fPositionBuf) then
        mx := Count
      else
        mx := fBufferSize-fPositionBuf;
      CopyMemory(b, @fMemory[fPositionBuf], mx);
      inc(fPositionBuf, mx);
      inc(fPosition, mx);
      inc(result, mx);
      dec(Count, mx);

      if Count=0 then
        break;

      LoadData;
      inc(b,mx);
    end;
  end;

end;

function TIEBufferedReadStream.Write(const Buffer; Count: longint): Longint;
begin
  raise Exception.Create('TIEBufferedReadStream cannot write!');
end;

{$ifdef IEOLDSEEKDEF}
function TIEBufferedReadStream.Seek(Offset: longint; Origin: word): longint;
{$else}
function TIEBufferedReadStream.Seek(const Offset: int64; Origin: TSeekOrigin): int64;
{$endif}
var
  newpos:int64;
  posbuf:int64;
begin
  fOverPosition := false;
  newpos := fPosition;
  case integer(Origin) of
    soFromBeginning:
      begin
        newpos := fRelativePosition + Offset;
      end;
    soFromCurrent:
      begin
        newpos := fPosition + Offset;
      end;
    soFromEnd:
      begin
        newpos := fSize - Offset;
      end;
  end;

  if newpos<0 then  // 3.0.4 to avoid negative positions
    newpos := 0;
  if newpos>=fSize then
  begin
    newpos := fSize;
    fOverPosition := true;
  end;

  // 3.0.4
  posbuf := fPositionBuf+(newpos-fPosition);
  if (posbuf >= fBufferSize) or (posbuf < 0) then
  begin
    fPosition:=newpos;
    LoadData;
  end
  else
  begin
    fPositionBuf := posbuf;
    fPosition := newpos;
  end;

  result:=fPosition - fRelativePosition;
end;

/////////////////////////////////////////////////////////////////////////

constructor TIEBufferedWriteStream.Create(InputStream:TStream; BufferSize:integer);
begin
  inherited Create;
  fStream:=InputStream;
  fBufferSize:=BufferSize;
  getmem(fMemory,fBufferSize);
  fBufferPos:=0;
end;

destructor TIEBufferedWriteStream.Destroy;
begin
  FlushData;
  freemem(fMemory);
  inherited Destroy;
end;

function TIEBufferedWriteStream.Read(var Buffer; Count: longint): Longint;
begin
  raise Exception.Create('TIEBufferedWriteStream cannot read!');
end;

procedure TIEBufferedWriteStream.FlushData;
begin
  if fBufferPos>0 then
    fStream.Write(fMemory[0],fBufferPos);
  fBufferPos:=0;
end;

function TIEBufferedWriteStream.Write(const Buffer; Count: longint): Longint;
var
  c,m:integer;
  inbuf:pbyte;
begin
  inbuf:=pbyte(@Buffer);
  c:=Count;
  while c>0 do
  begin
    m:=imin(c,fBufferSize-fBufferPos);
    move(inbuf^,fMemory[fBufferPos],m);
    inc(inbuf,m);
    inc(fBufferPos,m);
    if fBufferPos=fBufferSize then
      FlushData;
    dec(c,m);
  end;
  result:=Count-c;
end;

{$ifdef IEOLDSEEKDEF}
function TIEBufferedWriteStream.Seek(Offset: longint; Origin: word): longint;
{$else}
function TIEBufferedWriteStream.Seek(const Offset: int64; Origin: TSeekOrigin): int64;
{$endif}
begin
  FlushData;
  result:=fStream.Seek(Offset,Origin);
end;

/////////////////////////////////////////////////////////////////////////////


{$else}
constructor TIEBufferedReadStream.Create(InputStream:TStream; BufferSize:integer; UseRelativePosition:boolean);
begin
  inherited Create;
  fStream:=InputStream;
end;

destructor TIEBufferedReadStream.Destroy;
begin
  inherited Destroy;
end;

function TIEBufferedReadStream.Read(var Buffer; Count: longint): Longint;
begin
  result:=fStream.Read(Buffer,Count);
end;

function TIEBufferedReadStream.Write(const Buffer; Count: longint): Longint;
begin
  raise Exception.Create('TIEBufferedReadStream cannot write!');
end;

{$ifdef IEOLDSEEKDEF}
function TIEBufferedReadStream.Seek(Offset: longint; Origin: word): longint;
{$else}
function TIEBufferedReadStream.Seek(const Offset: int64; Origin: TSeekOrigin): int64;
{$endif}
begin
  result:=fStream.Seek(Offset,Origin);
end;

/////////////////////////////////////////////////////////////////////////////

constructor TIEBufferedWriteStream.Create(InputStream:TStream; BufferSize:integer);
begin
  inherited Create;
  fStream:=InputStream;
end;

destructor TIEBufferedWriteStream.Destroy;
begin
  inherited Destroy;
end;

function TIEBufferedWriteStream.Read(var Buffer; Count: longint): Longint;
begin
  raise Exception.Create('TIEBufferedWriteStream cannot read!');
end;

function TIEBufferedWriteStream.Write(const Buffer; Count: longint): Longint;
begin
  result:=fStream.Write(Buffer,Count);
end;

{$ifdef IEOLDSEEKDEF}
function TIEBufferedWriteStream.Seek(Offset: longint; Origin: word): longint;
{$else}
function TIEBufferedWriteStream.Seek(const Offset: int64; Origin: TSeekOrigin): int64;
{$endif}
begin
  result:=fStream.Seek(Offset,Origin);
end;

{$endif}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

function IEGetDecimalSeparator:Char;
begin
  {$ifdef IEDC15}
  result := FormatSettings.DecimalSeparator;
  {$else}
  result := DecimalSeparator;
  {$endif}
end;

procedure IESetDecimalSeparator(c:Char);
begin
  {$ifdef IEDC15}
  FormatSettings.DecimalSeparator := c;
  {$else}
  DecimalSeparator := c;
  {$endif}
end;

function IEFloatToStrA(Value:Extended):AnsiString;
var
  i:integer;
begin
  result:=AnsiString(floattostr(Value));
  for i:=1 to length(result) do
    if (result[i]=',') or (result[i]=AnsiChar(IEGetDecimalSeparator)) then
      result[i]:='.';
end;

function IEFloatToStrS(Value:Extended):string;
var
  i:integer;
begin
  result:=FloatToStr(Value);
  for i:=1 to length(result) do
    if (result[i]=',') or (result[i]=IEGetDecimalSeparator()) then
      result[i]:='.';
end;

function IEFloatToStrW(Value:Extended):WideString;
var
  i:integer;
begin
  result:=floattostr(Value);
  for i:=1 to length(result) do
    if (result[i]=',') or (result[i]=WideString(IEGetDecimalSeparator())) then
      result[i]:='.';
end;

function IERemoveCtrlCharsA(const text:AnsiString):AnsiString;
var
  q:integer;
  c:integer;
begin
  result:='';
  for q:=1 to length(text) do
  begin
		c:=ord(text[q]);
   	if (c>31) and (c<>127) then
      result:=result+AnsiChar(c);
  end;
end;

function IERemoveCtrlCharsS(const text:String):String;
begin
  result:=IERemoveCtrlCharsW(text);
end;

function IERemoveCtrlCharsW(const text:WideString):WideString;
var
  q:integer;
  c:integer;
begin
  result:='';
  for q:=1 to length(text) do
  begin
		c:=ord(text[q]);
   	if (c>31) and (c<>127) then
      result:=result+WideChar(c);
  end;
end;

function IERGB2StrS(c:TRGB):string;
begin
  with c do
    result:=IntToStr(r)+','+IntToStr(g)+','+IntToStr(b);
end;

function IERGB2StrW(c:TRGB):WideString;
begin
  with c do
    result:=IntToStr(r)+','+IntToStr(g)+','+IntToStr(b);
end;

function IEBool2StrS(v:boolean):string;
begin
	if v then
    result:='1'
  else
   	result:='0';
end;

function IEBool2StrW(v:boolean):WideString;
begin
	if v then
    result:='1'
  else
   	result:='0';
end;

function IEStr2RGBW(const rgbstr:WideString):TRGB;
begin
  result := IEStr2RGBS(string(rgbstr));
end;

function IEStr2RGBS(const rgbstr:string):TRGB;
var
  p:integer;
  ps1,q:integer;
  ss:string;
  l:integer;
begin
	try
  l:=length(rgbstr);
  ps1:=1;
  p:=0;
	for q:=1 to l+1 do
  begin
    if (rgbstr[q]=',') or (q=l+1) then
    begin
      ss:=Trim(copy(rgbstr,ps1,(q-ps1)));
      case p of
        0: result.r:=StrToIntDef(ss,0);
        1: result.g:=StrToIntDef(ss,0);
        2: result.b:=StrToIntDef(ss,0);
      end;
      inc(p);
      ps1:=q+1;
    end;
  end;
  except
    result:=creatergb(0,0,0);
  end;
end;

function IEStr2BoolS(const v:string):boolean;
var
  ss:string;
begin
	ss:=UpperCase(v);
  result:= (ss='1') or (ss='TRUE') or (ss='T');
end;

function IEStr2BoolW(const v:WideString):boolean;
begin
  result := IEStr2BoolS(string(v));
end;

procedure IESetGrayPalette(Bitmap:TBitmap);
var
  pe: array[0..255] of TRGBQuad;
  i: integer;
begin
  for i := 0 to 255 do
    with pe[i] do
    begin
      rgbRed := i;
      rgbGreen := i;
      rgbBlue := i;
      rgbReserved := 0;
    end;
  SetDIBColorTable(Bitmap.Canvas.Handle, 0, 256, pe);
end;

function IEIsGrayPalette(Bitmap:TBitmap):boolean;
var
  pe: array[0..255] of TRGBQuad;
  i,n: integer;
begin
  result:=false;
  n:=GetDIBColorTable(Bitmap.Canvas.Handle,0,256,pe);
  for i:=0 to n-1 do
    with pe[i] do
      if (rgbRed<>i) or (rgbGreen<>i) or (rgbBlue<>i) then
        exit;
  result:=true;
end;

// note: source.PixelFormat must be pf8bit and dest.PixelFormat must be ie8p
procedure IECopyTBitmapPaletteToTIEBitmap(source:TBitmap; dest:TIEBitmap);
var
  pe: array[0..255] of TRGBQuad;
  i,n: integer;
begin
  if (source.PixelFormat<>pf8bit) or (dest.fPixelFormat<>ie8p) then
    exit;
  n:=GetDIBColorTable(source.Canvas.Handle,0,256,pe);
  for i:=0 to n-1 do
    with pe[i] do
      dest.Palette[i]:=CreateRGB( rgbRed, rgbGreen,rgbBlue );
end;



(*
      CCIR Recommendation 601-1  (lumaRed=0.299, lumaGreen=0.587, lumaBlue=0.114)

      R = Y                + 1.40200 * Cr
      G = Y - 0.34414 * Cb - 0.71414 * Cr
      B = Y + 1.77200 * Cb

      Y  =  0.29900 * R + 0.58700 * G + 0.11400 * B
      Cb = -0.16874 * R - 0.33126 * G + 0.50000 * B  + 128
      Cr =  0.50000 * R - 0.41869 * G - 0.08131 * B  + 128
*)
procedure IERGB2YCbCr(rgb:TRGB; var Y,Cb,Cr:integer);
begin
  with rgb do
  begin
    Y  := blimit(trunc(0.29900 * R + 0.58700 * G + 0.11400 * B));
    Cb := blimit(trunc(-0.16874 * R - 0.33126 * G + 0.50000 * B  + 128));
    Cr := blimit(trunc(0.50000 * R - 0.41869 * G - 0.08131 * B  + 128));
  end;
end;

procedure IEYCbCr2RGB(var rgb:TRGB; Y,Cb,Cr:integer);
begin
  Cb:=Cb-128;
  Cr:=Cr-128;
  rgb.r:=blimit(trunc(Y + 1.40200 * Cr));
  rgb.g:=blimit(trunc(Y - 0.34414 * Cb - 0.71414 * Cr));
  rgb.b:=blimit(trunc(Y + 1.77200 * Cb));
end;

{$ifndef IEHASFREEANDNIL}
procedure FreeAndNil(var Obj);
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;
{$endif}

function IESystemAlloc(ASize: dword): pointer;
begin
  // 2.2.4rc2
  //result := VirtualAlloc(nil, ASize, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE);
  result:=pointer(GlobalAlloc(GPTR,ASize));
end;

//  Frees memory
procedure IESystemFree(var P);
begin
  //VirtualFree(pointer(P), 0, MEM_RELEASE);
  GlobalFree(THandle(pointer(P)));  // 2.2.4rc2
  pointer(P) := nil;
end;

const IEMINSYSALLOC = 1048576;

function IEAutoAlloc(ASize:dword):pointer;
begin
  if ASize>=IEMINSYSALLOC then
  begin
    result:=IESystemAlloc(ASize+4);
    if result=nil then
      exit; // FAIL
    pboolean(result)^:=true;
  end
  else
  begin
    try
      GetMem(result, ASize+4);
      pboolean(result)^:=false;
    except
      result:=IESystemAlloc(ASize+4);
      if result=nil then
        exit; // FAIL
      pboolean(result)^:=true;
    end;
  end;
  inc(pboolean(result));
end;

procedure IEAutoFree(var P);
begin
  dec(pboolean(P));
  if pboolean(P)^ then
    IESystemFree(P)
  else
    FreeMem(pointer(P));
end;

procedure IESilentGetMem(var P; Size: Integer);
begin
  try
    GetMem(pointer(P), Size);
  except
    pointer(P) := nil;
  end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////
// XMP support functions

const
  xmpnamespace:AnsiString='http://ns.adobe.com/xap/1.0/';

function IEFindXMPFromJpegTag(Buffer:pointer; BufferLength:integer):pbyte;
begin
  if (BufferLength>29) and CompareMem(Buffer,PAnsiChar(xmpnamespace),24) then  // 24 because we don't compare version
  begin
    result:=Buffer;
    while result^<>0 do
      inc(result);
    inc(result);
  end
  else
    result:=nil;
end;

function IELoadXMPFromJpegTag(Buffer:pointer; BufferLength:integer; params:TObject):boolean;
var
  pt:pbyte;
  info:AnsiString;
  sz:integer;
begin
  pt:=IEFindXMPFromJpegTag(Buffer,BufferLength);
  result:=pt<>nil;
  if result then
  begin
    sz:=BufferLength-(int64(DWORD(pt))-int64(DWORD(Buffer)));
    SetLength(info,sz);
    Move(pt^,info[1],sz);
    (params as TIOParamsVals).XMP_Info:=info;
  end;
end;

procedure IESaveXMPToJpegTag(params:TObject; var Buffer:pointer; var BufferLength:integer);
var
  info:AnsiString;
  pb:pbyte;
begin
  info:=(params as TIOParamsVals).XMP_Info;
  BufferLength:=29+length(info);
  getmem(Buffer, BufferLength);
  pb:=Buffer;
  move(xmpnamespace[1],pb^,29);
  inc(pb,29);
  move(info[1],pb^,length(info));
end;

// end of XMP support functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Back propagation multilayer neural net
(*
        Network:      Backpropagation Network with Bias Terms and Momentum
                      ====================================================

        Application:  Time-Series Forecasting
                      Prediction of the Annual Number of Sunspots

        Author:       Karsten Kutza

        Reference:    D.E. Rumelhart, G.E. Hinton, R.J. Williams
                      Learning Internal Representations by Error Propagation
                      in:
                      D.E. Rumelhart, J.L. McClelland (Eds.)
                      Parallel Distributed Processing, Volume 1
                      MIT Press, Cambridge, MA, pp. 318-362, 1986
*)

{$ifdef IEINCLUDENEURALNET}
constructor TIENeurNet.Create(layerUnits:array of integer);
var
  i:integer;
begin
  inherited Create;
  LayersDefCount:=length(layerUnits);
  getmem(LayersDef,sizeof(integer)*LayersDefCount);
  for i:=0 to LayersDefCount-1 do
    LayersDef[i]:=layerUnits[i];
  GenerateNetwork;
  RandomWeights;
end;

destructor TIENeurNet.Destroy;
var
  l,i:integer;
begin
  for l:=0 to LayersDefCount-1 do
  begin

    if (l <> 0) then
    begin
      for i:=1 to LayersDef[l] do
      begin
        freemem(Layer[l].Weight[i]);
        freemem(Layer[l].WeightSave[i]);
        freemem(Layer[l].dWeight[i]);
      end;
    end;

    freemem(Layer[l].Output);
    freemem(Layer[l].Error);
    freemem(Layer[l].Weight);
    freemem(Layer[l].WeightSave);
    freemem(Layer[l].dWeight);

  end;

  freemem( Layer );
  freemem( LayersDef );

  inherited;
end;

procedure TIENeurNet.GenerateNetwork;
var
  l,i:integer;
begin

  Layer := allocmem(LayersDefCount*sizeof(TLAYER));

  for l:=0 to LayersDefCount-1 do
  begin

    Layer[l].Units      := LayersDef[l];
    Layer[l].Output     := allocmem( (LayersDef[l]+1) * sizeof(double) );
    Layer[l].Error      := allocmem( (LayersDef[l]+1) * sizeof(double) );
    Layer[l].Weight     := allocmem( (LayersDef[l]+1) * sizeof(pdoublearray) );
    Layer[l].WeightSave := allocmem( (LayersDef[l]+1) * sizeof(pdoublearray) );
    Layer[l].dWeight    := allocmem( (LayersDef[l]+1) * sizeof(pdoublearray) );
    Layer[l].Output[0]  := 1; // BIAS

    if (l <> 0) then
    begin
      for i:=1 to LayersDef[l] do
      begin
        Layer[l].Weight[i]     := allocmem( (LayersDef[l-1]+1) * sizeof(double) );
        Layer[l].WeightSave[i] := allocmem( (LayersDef[l-1]+1) * sizeof(double) );
        Layer[l].dWeight[i]    := allocmem( (LayersDef[l-1]+1) * sizeof(double) );
      end;
    end;
  end;
  InputLayer  := @Layer[0];
  OutputLayer := @Layer[LayersDefCount - 1];
  Alpha       := 0.9;
  Eta         := 0.25;
  Gain        := 1;
end;

function RandomEqualREAL(Low, High:double):double;
begin
  result:= random * (High-Low) + Low;
end;

procedure TIENeurNet.RandomWeights;
var
  l,i,j:integer;
begin
  for l:=1 to LayersDefCount-1 do
  begin
    for i:=1 to Layer[l].Units do
    begin
      for j:=0 to Layer[l-1].Units do
      begin
        Layer[l].Weight[i][j] := RandomEqualREAL(-0.5, 0.5);
      end;
    end;
  end;
end;

procedure TIENeurNet.SetInput(idx:integer; value:double);
begin
  InputLayer.Output[idx+1]:=value;
end;

function TIENeurNet.GetOutput(idx:integer):double;
begin
  result:=OutputLayer.Output[idx+1];
end;

procedure TIENeurNet.SetInput(fromIdx:integer; Input:pdoublearray);
var
  i:integer;
begin
  for i:=1 to InputLayer.Units do
    InputLayer.Output[fromIdx+i] := Input[i-1];
end;

procedure TIENeurNet.GetOutput(Output:pdoublearray);
var
  i:integer;
begin
  for i:=1 to OutputLayer.Units do
    Output[i-1] := OutputLayer.Output[i];
end;

procedure TIENeurNet.GetOutput(Bitmap:TIEBitmap; w,h:integer);
var
  i,j,k:integer;
  pb:pbyte;
  max,min,v,range:double;
begin
  max:=-10000000;
  min:=10000000;
  for i:=1 to Outputlayer.Units do
  begin
    v:=OutputLayer.Output[i];
    if v>max then
      max:=v
    else if v<min then
      min:=v;
  end;
  range:=max-min;
  Bitmap.allocate(w,h,ie8g);
  k:=1;
  for i:=0 to h-1 do
  begin
    pb:=Bitmap.Scanline[i];
    for j:=0 to w-1 do
    begin
      pb^:= trunc((OutputLayer.Output[k]-min)/range*255);
      inc(pb);
      inc(k);
    end;
  end;
end;

procedure TIENeurNet.SaveWeights;
var
  l,i,j:integer;
begin
  for l:=1 to LayersDefCount-1 do
    for i:=1 to Layer[l].Units do
      for j:=0 to Layer[l-1].Units do
        Layer[l].WeightSave[i][j] := Layer[l].Weight[i][j];
end;

procedure TIENeurNet.RestoreWeights;
var
  l,i,j:integer;
begin
  for l:=1 to LayersDefCount-1 do
    for i:=1 to Layer[l].Units do
      for j:=0 to Layer[l-1].Units do
        Layer[l].Weight[i][j] := Layer[l].WeightSave[i][j];
end;

procedure TIENeurNet.SaveToStream(Stream:TStream);
var
  l,i,j:integer;
begin
  for l:=1 to LayersDefCount-1 do
    for i:=1 to Layer[l].Units do
      for j:=0 to Layer[l-1].Units do
        Stream.Write( Layer[l].Weight[i][j], sizeof(double) );
end;

procedure TIENeurNet.LoadFromStream(Stream:TStream);
var
  l,i,j:integer;
begin
  for l:=1 to LayersDefCount-1 do
    for i:=1 to Layer[l].Units do
      for j:=0 to Layer[l-1].Units do
        Stream.Read( Layer[l].Weight[i][j], sizeof(double) );
end;

procedure TIENeurNet.SaveToFile(const FileName:string);
var
  fs:TFileStream;
begin
  fs:=TFileStream.Create(FileName,fmCreate);
  SaveToStream(fs);
  fs.free;
end;

procedure TIENeurNet.LoadFromFile(const FileName:string);
var
  fs:TFileStream;
begin
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

procedure TIENeurNet.PropagateLayer(Lower,Upper:PTLAYER);
var
  i,j:integer;
  Sum:double;
begin
  for i:=1 to Upper.Units do
  begin
    Sum := 0;
    for j:=0 to Lower.Units do
    begin
      Sum := Sum + Upper.Weight[i][j] * Lower.Output[j];
    end;
    Upper.Output[i] := 1 / (1 + exp(-Gain * Sum));
  end;
end;

procedure TIENeurNet.Run;
var
  l:integer;
begin
  for l:=0 to LayersDefCount-2 do
  begin
    PropagateLayer(@Layer[l], @Layer[l+1]);
  end;
end;

procedure TIENeurNet.Train(Target:array of double; DoTrain:boolean);
var
  i:integer;
  xOut, Err:double;
begin
  Run;
  Error := 0;
  for i:=1 to OutputLayer.Units do
  begin
    xOut := OutputLayer.Output[i];
    Err := Target[i-1]-xOut;
    OutputLayer.Error[i] := Gain * xOut * (1-xOut) * Err;
    Error := Error + 0.5 * sqr(Err);
  end;
  if DoTrain then
  begin
    BackpropagateNet;
    AdjustWeights;
  end;
end;

procedure TIENeurNet.BackpropagateLayer(Upper,Lower:PTLAYER);
var
  i,j:integer;
  xOut, Err:double;
begin
  for i:=1 to Lower.Units do
  begin
    xOut := Lower.Output[i];
    Err := 0;
    for j:=1 to Upper.Units do
    begin
      Err := Err + Upper.Weight[j][i] * Upper.Error[j];
    end;
    Lower.Error[i] := Gain * xOut * (1-xOut) * Err;
  end;
end;

procedure TIENeurNet.BackpropagateNet;
var
  l:integer;
begin
  for l:=LayersDefCount-1 downto 2 do
    BackpropagateLayer(@Layer[l], @Layer[l-1]);
end;

procedure TIENeurNet.AdjustWeights;
var
  l,i,j:integer;
  xOut, Err, dWeight:double;
begin
  for l:=1 to LayersDefCount-1 do
  begin
    for i:=1 to Layer[l].Units do
    begin
      for j:=0 to Layer[l-1].Units do
      begin
        xOut := Layer[l-1].Output[j];
        Err := Layer[l].Error[i];
        dWeight := Layer[l].dWeight[i][j];
        Layer[l].Weight[i][j] := Layer[l].Weight[i][j] + (Eta * Err * xOut + Alpha * dWeight);
        Layer[l].dWeight[i][j] := Eta * Err * xOut;
      end;
    end;
  end;
end;

procedure TIENeurNet.SetInputAsHist(fromIdx:integer; bitmap:TIEBitmap);
var
  hist:THistogram;
  proc:TImageEnProc;
  i:integer;
  k:integer;
begin
  proc:=TImageEnProc.CreateFromBitmap(bitmap);
  proc.AutoUndo:=false;
  proc.GetHistogram(@hist);
  proc.free;
  k:=1+fromIdx;
  for i:=0 to 255 do
    with hist[i] do
    begin
      InputLayer.Output[k]:=r/255; inc(k);
      InputLayer.Output[k]:=g/255; inc(k);
      InputLayer.Output[k]:=b/255; inc(k);
    end;
end;

// Set input as bitmap. The input rectangle is converted to specified color space and resized to dstWidth and dstHeight.
// bitmap must be ie24RGB.
// The first dstWidth x dstHeight * channels inputs are filled.
// colorSpace: 0=gray scale, 1=RGB (valid only when src size is equal to dst size)
procedure TIENeurNet.SetInput(fromIdx:integer; bitmap:TIEBitmap; colorSpace:integer; srcX,srcY,srcWidth,srcHeight:integer; dstWidth,dstHeight:integer);
var
  proc:TImageEnProc;
  tmp:TIEBitmap;
  i,j:integer;
  ps:psingle;
  k:integer;
  px:PRGB;
  pf:psingle;
begin
  if (srcWidth=0) or (srcHeight=0) or (dstWidth=0) or (dstHeight=0) then
    exit;

  if (srcWidth=dstWidth) and (srcHeight=dstHeight) then
  begin

    if (bitmap.PixelFormat=ie32f) and (colorSpace=0) then
    begin

      k:=0+fromIdx;
      for i:=0 to dstHeight-1 do
      begin
        pf:=bitmap.Scanline[i+srcY]; inc(pf,srcX);
        for j:=0 to dstWidth-1 do
        begin
          InputLayer.Output[k+1]:=pf^;
          inc(pf);
          inc(k);
        end;
      end;

    end
    else
    begin

      k:=0+fromIdx;
      for i:=0 to dstHeight-1 do
      begin
        px:=bitmap.Scanline[i+srcY]; inc(px,srcX);
        for j:=0 to dstWidth-1 do
        begin
          with px^ do
            case colorSpace of
              0:
                begin
                  InputLayer.Output[k+1]:=(0.2126 * r + 0.7152 * g + 0.0722 * b) / 255; // Rec 709
                  inc(k);
                end;
              1:
                begin
                  InputLayer.Output[k+1]:=r/255; inc(k);
                  InputLayer.Output[k+1]:=g/255; inc(k);
                  InputLayer.Output[k+1]:=b/255; inc(k);
                end;
            end;
          inc(px);
        end;
      end;
      
    end;

  end

  else
  begin

    tmp:=TIEBitmap.Create;
    proc:=TImageEnProc.CreateFromBitmap(tmp);
    proc.AutoUndo:=false;
    try
      tmp.Allocate(srcWidth,srcHeight,ie24RGB);
      bitmap.CopyRectTo(tmp,srcX,srcY,0,0,srcWidth,srcHeight);

      if (tmp.Width<>dstWidth) or (tmp.Height<>dstHeight) then
        proc.Resample(dstWidth,dstHeight,rfTriangle);

      tmp.PixelFormat:=ie32f;

      k:=0+fromIdx;
      for i:=0 to dstHeight-1 do
      begin
        ps:=tmp.Scanline[i];
        for j:=0 to dstWidth-1 do
        begin
          InputLayer.Output[k+1]:=ps^;
          inc(ps);
          inc(k);
        end;
      end;
    finally
      proc.free;
      tmp.free;
    end;

  end;
end;

procedure TIENeurNet.Train(bitmap:TIEBitmap; srcX,srcY,srcWidth,srcHeight:integer; dstWidth,dstHeight:integer; DoTrain:boolean);
var
  proc:TImageEnProc;
  tmp:TIEBitmap;
  i,j:integer;
  ps:psingle;
  k:integer;
  px:PRGB;
  xOut, Err:double;
  v:double;
begin

  Run;

  Error := 1;

  if (srcWidth=0) or (srcHeight=0) or (dstWidth=0) or (dstHeight=0) then
    exit;

  Error := 0;

  if (srcWidth=dstWidth) and (srcHeight=dstHeight) then
  begin

    k:=0;
    for i:=0 to dstHeight-1 do
    begin
      px:=bitmap.Scanline[i+srcY]; inc(px,srcX);
      for j:=0 to dstWidth-1 do
      begin
        with px^ do
          v:=(0.2126 * r + 0.7152 * g + 0.0722 * b) / 255; // Rec 709

        xOut := OutputLayer.Output[k+1];
        Err := v-xOut;
        OutputLayer.Error[k+1] := Gain * xOut * (1-xOut) * Err;
        Error := Error + 0.5 * sqr(Err);

        inc(k);
        inc(px);
      end;
    end;

  end

  else
  begin

    tmp:=TIEBitmap.Create;
    proc:=TImageEnProc.CreateFromBitmap(tmp);
    proc.AutoUndo:=false;

    try

      tmp.Allocate(srcWidth,srcHeight,ie24RGB);
      bitmap.CopyRectTo(tmp,srcX,srcY,0,0,srcWidth,srcHeight);

      if (tmp.Width<>dstWidth) or (tmp.Height<>dstHeight) then
        proc.Resample(dstWidth,dstHeight,rfTriangle);

      tmp.PixelFormat:=ie32f;

      k:=0;
      for i:=0 to dstHeight-1 do
      begin
        ps:=tmp.Scanline[i];
        for j:=0 to dstWidth-1 do
        begin

          xOut := OutputLayer.Output[k+1];
          Err := ps^-xOut;
          OutputLayer.Error[k+1] := Gain * xOut * (1-xOut) * Err;
          Error := Error + 0.5 * sqr(Err);

          inc(ps);
          inc(k);
        end;
      end;

    finally
      proc.free;
      tmp.free;
    end;
  end;

  if DoTrain then
  begin
    BackpropagateNet;
    AdjustWeights;
  end;
end;

{$endif}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Extra backgrounds

(*
f(x)=(1/(sqrt(2*pi)*var))*e^((-1/2*(var^2))*(x-mean)^2)
mean: center of highest value. 0=centered on zero
var: width of the curve. 0.1=maximum width, 1=minimum, ref=0.2
*)
procedure IECreateGaussCurve(variance:double; curveCount:integer; curveMin,curveMax:integer; var curve:array of double);
const
  mean=0;
var
  i:integer;
  x:double;
  mx:double;
begin
  mx:=-100000;
  for i:=0 to curveCount-1 do
  begin
    x:=(i/curveCount)*2-1;
    curve[i]:=(1/(sqrt(2*pi)*variance))*exp((-1/2*(iepower(variance,2)))*iepower(x-mean,2));
    if curve[i]>mx then
      mx:=curve[i];
  end;
  for i:=0 to curveCount-1 do
    curve[i]:=curveMin+ curve[i]/mx*(curveMax-curveMin);
end;

procedure IECreateOSXBackgroundPaper(bmp:TBitmap; width,height:integer);
var
  px:PRGB;
  col:TRGB;
  x,y:integer;
  c:integer;
  gauss:array [0..3] of double;
begin
  bmp.Width:=width;
  bmp.Height:=height;
  bmp.PixelFormat:=pf24bit;
  IECreateGaussCurve(0.5, 4, 130,255, gauss);
  c:=0;
  for y:=0 to bmp.Height-1 do
  begin
    px:=bmp.Scanline[y];
    col.r:=trunc(gauss[c]);
    col.g:=col.r;
    col.b:=col.r;
    for x:=0 to bmp.Width-1 do
    begin
      px^:=col;
      inc(px);
    end;
    inc(c);
    if c=4 then
      c:=0;
  end;
end;

procedure IECreateOSXBackgroundMetal(bmp:TBitmap; width,height:integer);
var
  px:PRGB;
  x,y:integer;
  c,a:integer;
  gauss:pdoublearray;
  bmpWidth,bmpHeight:integer;
begin
  bmp.Width:=width;
  bmp.Height:=height;
  bmp.PixelFormat:=pf24bit;
  bmpWidth:=bmp.Width;
  bmpHeight:=bmp.Height;
  getmem(gauss,bmpWidth*sizeof(double));
  IECreateGaussCurve(3, bmpWidth, 160,208, gauss^);
  a:=0;
  for y:=0 to bmpHeight-1 do
  begin
    c:=0;
    px:=bmp.Scanline[y];
    for x:=0 to bmpWidth-1 do
    begin
      px^.r:=trunc(gauss[x])+a;
      px^.g:=px^.r;
      px^.b:=px^.r;
      inc(px);
      inc(c);
      if c>(100+random(bmpWidth)) then
      begin
        c:=0;
        a:=random(11);
      end;
    end;
  end;
  freemem(gauss);
end;

// Extra backgrounds
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Clipboard helper functions

// you have to call OpenClipboard before call this function
function IEEnumClipboardNames:TStringList;
const
  MX=512;
var
  cf:cardinal;
  pc:PChar;
  len:integer;
begin
  getmem(pc,(MX+1)*sizeof(Char));
  result:=TStringList.Create;
  cf:=0;
  while true do
  begin
    cf:=EnumClipboardFormats(cf);
    if cf=0 then
      break;
    len := GetClipboardFormatName(cf,pc,MX);
    if len > 0 then
    	result.AddObject( copy(pc, 1, len), pointer(cf) );
  end;
  freemem(pc);
end;

// you have to call OpenClipboard before call this function
function IEGetClipboardDataByName(const name:string):THandle;
var
  l:TStringList;
  i:integer;
begin
  result:=0;
  l:=IEEnumClipboardNames;
  i:=l.IndexOf(name);
  if i>-1 then
    result:=cardinal(l.Objects[i]);
  l.free;
end;

// Clipboard helper functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEDICOMTags

{$ifdef IEINCLUDEDICOM}

constructor TIEDICOMTags.Create;
begin
  inherited Create;
  fTags:=TList.Create;
end;

destructor TIEDICOMTags.Destroy;
begin
  Clear;
  fTags.Free;
  inherited;
end;

{!!
<FS>TIEDICOMTags.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Removes all loaded DICOM tags.
!!}
procedure TIEDICOMTags.Clear;
var
  i:integer;
begin
  for i:=0 to fTags.Count-1 do
  begin
    freemem( PIEDICOMTag(fTags[i])^.data );
    dispose( PIEDICOMTag(fTags[i]) );
  end;
  fTags.Clear;
end;

{!!
<FS>TIEDICOMTags.Count

<FM>Declaration<FC>
property Count:integer;

<FM>Description<FN>
Returns number of loaded DICOM tags.
!!}
function TIEDICOMTags.GetCount:integer;
begin
  result:=fTags.Count;
end;

{!!
<FS>TIEDICOMTags.AddTag

<FM>Declaration<FC>
function AddTag(Group:word; Element:word; DataType:AnsiString; Data:pointer; DataLen:integer):integer;

<FM>Description<FN>
Adds a new DICOM tag.
Please look at DICOM documentation for details about Group, Element and DataType.
Data is the pointer to data buffer (of DataLen length). You don't have to free this buffer.
Returns the tag position.
!!}
function TIEDICOMTags.AddTag(Group:word; Element:word; DataType:AnsiString; Data:pointer; DataLen:integer):integer;
var
  p:PIEDICOMTag;
begin
  new(p);
  FillChar(p^,sizeof(TIEDICOMTag),0);
  p^.Group:=Group;
  p^.Element:=Element;
  if length(DataType)=2 then
  begin
    p^.DataType[0]:=DataType[1];
    p^.DataType[1]:=DataType[2];
  end;
  if DataLen<0 then
  begin
    p^.DataLen:=0;  // undefined size or length=0
    p^.Data:=nil;
  end
  else
  begin
    p^.DataLen:=DataLen;
    p^.Data:=Data;
  end;
  result:=fTags.Add(p);
end;

procedure TIEDICOMTags.SaveToStream(Stream:TStream);
var
  b:byte;
  i:integer;
begin
  b:=1; Stream.Write(b,1);  // version
  i:=fTags.Count; Stream.Write(i,4);  // tags count
  for i:=0 to fTags.Count-1 do
  begin
    Stream.Write( PIEDICOMTag(fTags[i])^, sizeof(TIEDICOMTag) );
    with PIEDICOMTag(fTags[i])^ do
      if DataLen>0 then
        Stream.Write( pbyte(Data)^, DataLen );
  enD;
end;

procedure TIEDICOMTags.LoadFromStream(Stream:TStream);
var
  b:byte;
  i,l:integer;
  p:PIEDICOMTag;
begin
  Stream.Read(b,1); // version
  if b>=1 then
  begin
    Stream.Read(l,4);  // tags count
    for i:=0 to l-1 do
    begin
      new(p);
      Stream.Read( p^, sizeof(TIEDICOMTag) );
      if p^.DataLen>0 then
      begin
        getmem(p^.data,p^.DataLen+1);
        Stream.Read( pbyte(p^.data)^, p^.Datalen );
        PAnsiChar(p^.data)[p^.DataLen]:=#0;
      end
      else
        p^.data:=nil;
      fTags.Add(p);
    end;
  end;
end;

procedure TIEDICOMTags.Assign(Source:TIEDICOMTags);
var
  i:integer;
  p_src,p_dst:PIEDICOMTag;
begin
  Clear;
  for i:=0 to Source.fTags.Count-1 do
  begin
    p_src:=PIEDICOMTag(Source.fTags[i]);
    new(p_dst);

    CopyMemory(p_dst,p_src,sizeof(TIEDICOMtag));
    if p_src^.DataLen>0 then
    begin
      getmem(p_dst^.data,p_src^.DataLen+1);
      CopyMemory(p_dst^.data,p_src^.data,p_src^.DataLen+1);
    end
    else
      p_dst^.data:=nil;

    fTags.Add(p_dst);
  end;
end;

{!!
<FS>TIEDICOMTags.IndexOf

<FM>Declaration<FC>
function IndexOf(Group:word; Element:word):integer;

<FM>Description<FN>
Returns the index of tag identified by Group and Element.
Please look at DICOM documentation for details about Group and Element.
!!}
function TIEDICOMTags.IndexOf(Group:word; Element:word):integer;
var
  i:integer;
  p:PIEDICOMTag;
begin
  result:=-1;
  for i:=0 to fTags.Count-1 do
  begin
    p:=PIEDICOMTag(fTags[i]);
    if (p^.Group=Group) and (p^.Element=Element) then
    begin
      result:=i;
      break;
    end;
  enD;
end;

{!!
<FS>TIEDICOMTags.GetTag

<FM>Declaration<FC>
function GetTag(index:integer):<A PIEDICOMTag>;

<FM>Description<FN>
Returns pointer to raw tag at specified index.
!!}
function TIEDICOMTags.GetTag(index:integer):PIEDICOMTag;
begin
  if (index>-1) and (index<fTags.Count) then
    result:=fTags[index]
  else
    result:=nil;
end;

{!!
<FS>TIEDICOMTags.GetTagString

<FM>Declaration<FC>
function GetTagString(index:integer):AnsiString;

<FM>Description<FN>
Returns the DICOM tag at specified index, as string.

<FM>Example<FC>
ImageType := ImageEnView1.IO.Params.DICOM_Tags.GetTagString( tags.IndexOf($0008,$0008) );
PatientName := ImageEnView1.IO.Params.DICOM_Tags.GetTagString( tags.IndexOf($0010,$0010) );

!!}
function TIEDICOMTags.GetTagString(index:integer):AnsiString;
var
  p:PIEDICOMTag;
begin
  p:=GetTag(index);
  if p<>nil then
    result:=StrPas(PAnsiChar(p^.data))
  else
    result:='';
end;

{!!
<FS>TIEDICOMTags.DeleteTag

<FM>Declaration<FC>
procedure DeleteTag(index:integer);

<FM>Description<FN>
Removes the tag at specified index.

<FM>Example<FC>
// removes patient name
ImageEnView1.IO.Params.DICOM_Tags.DeleteTag( tags.IndexOf($0010,$0010) );

!!}
procedure TIEDICOMTags.DeleteTag(index:integer);
begin
  if (index>-1) and (index<fTags.Count) then
  begin
    freemem( PIEDICOMTag(fTags[index])^.data );
    dispose( PIEDICOMTag(fTags[index]) );
    fTags.Delete(index);
  end;
end;

{$endif}

// TIEDICOMTags
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// sometime OpenClipboard fails. In particular when big images are just copied in and a Past is done immediately.
function IEOpenClipboard:boolean;
var
  i:integer;
begin
  for i:=1 to 10 do
  begin
    if OpenClipboard(0) then
    begin
      result:=true;
      exit;
    end;
    sleep(20);  // up to 200 ms (20*10)
  end;
  result:=false;
end;

{!!
<FS>IEAlphaToOpacity

<FM>Declaration<FC>
function IEAlphaToOpacity(Alpha:integer ):integer;

<FM>Description<FN>
AlphaToOpacity returns an integer of the alpha channel value.
Opacity is generally referred to as percent.  ( Alpha = 255 then Opacity = 100% )
!!}
function IEAlphaToOpacity(Alpha:integer ):integer;
begin
 Result := Round( Alpha / 255 * 100 );
end;

{!!
<FS>IEOpacityToAlpha

<FM>Declaration<FC>
function IEOpacityToAlpha(Opacity:integer):integer;

<FM>Description<FN>
OpacityToAlpha returns an integer of an opacity value.  ( Opacity = 100% then Alpha = 255 )
!!}
function IEOpacityToAlpha(Opacity:integer):integer;
begin
 Result := ( Opacity * 255 ) div 100;
end;


/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEWideFileStream

function IECreateFileW(lpFileName: PWideChar; dwDesiredAccess, dwShareMode: DWORD;
  lpSecurityAttributes: PSecurityAttributes; dwCreationDisposition, dwFlagsAndAttributes: DWORD;
    hTemplateFile: THandle): THandle;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := CreateFileW(lpFileName, dwDesiredAccess, dwShareMode,
      lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile)
  else
    Result := CreateFileA(PAnsiChar(AnsiString(lpFileName)), dwDesiredAccess, dwShareMode,
      lpSecurityAttributes, dwCreationDisposition, dwFlagsAndAttributes, hTemplateFile)
end;

function WideFileCreate(const FileName: WideString): THandle;
begin
  Result := IECreateFileW(PWideChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
end;

function WideFileOpen(const FileName:WideString; Mode:LongWord):THandle;
const
  AccessMode: array[0..2] of LongWord = (
    GENERIC_READ,
    GENERIC_WRITE,
    GENERIC_READ or GENERIC_WRITE);
  ShareMode: array[0..4] of LongWord = (
    0,
    0,
    FILE_SHARE_READ,
    FILE_SHARE_WRITE,
    FILE_SHARE_READ or FILE_SHARE_WRITE);
begin
  Result := INVALID_HANDLE_VALUE;
  if ((Mode and 3) <= fmOpenReadWrite) and ((Mode and $F0) <= fmShareDenyNone) then
    Result := IECreateFileW(PWideChar(FileName), AccessMode[Mode and 3], ShareMode[(Mode and $F0) shr 4], nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
end;

constructor TIEWideFileStream.Create(const FileName:WideString; Mode:Word);
const
  SFCreateError = 'Cannot create file %s';
  SFCreateErrorEx = 'Cannot create file "%s". %s';
  SFOpenError = 'Cannot open file %s';
  SFOpenErrorEx = 'Cannot open file "%s". %s';
var
  CreateHandle:THandle;
  ErrorMessage:WideString;
begin
  if Mode = fmCreate then
  begin
    CreateHandle := WideFileCreate(FileName);
    if CreateHandle = INVALID_HANDLE_VALUE then
    begin
      ErrorMessage := SysErrorMessage(GetLastError);
      raise EFCreateError.CreateFmt(SFCreateErrorEx, [ExpandFileName(FileName), ErrorMessage]);
    end;
  end else
  begin
    CreateHandle := WideFileOpen(FileName, Mode);
    if CreateHandle = INVALID_HANDLE_VALUE then
    begin
      ErrorMessage := SysErrorMessage(GetLastError);
      raise EFOpenError.CreateFmt(SFOpenErrorEx, [ExpandFileName(FileName), ErrorMessage]);
    end;
  end;
  inherited Create(CreateHandle);
end;

destructor TIEWideFileStream.Destroy;
begin
  if THandle(Handle) <> INVALID_HANDLE_VALUE then
    FileClose(Handle);
  inherited Destroy;
end;

function IEWStrCopy(Dest: PWideChar; const Source: PWideChar): PWideChar;
var
  Src : PWideChar;
begin
  Result := Dest;
  Src := Source;
  while (Src^ <> #$00) do
  begin
    Dest^ := Src^;
    Inc(Src);
    Inc(Dest);
  end;
  Dest^ := #$00;
end;

// TIEWideFileStream
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure IERotatePoints(var rpt:array of TPoint; angle:double; CenterX,CenterY:integer);
var
  aa:double;
  i, x, y:integer;
begin
  aa := -angle * pi / 180;
  for i:=0 to High(rpt) do
  begin
    x := rpt[i].X;
    y := rpt[i].Y;
    rpt[i].X := CenterX + trunc( (x-CenterX)*cos(aa) - (y-CenterY)*sin(aa) );
    rpt[i].Y := CenterY + trunc( (x-CenterX)*sin(aa) + (y-CenterY)*cos(aa) );
  end;
end;

procedure IERotatePoint(var px,py:integer; angle:double; CenterX,CenterY:integer);
var
  aa:double;
  x,y:integer;
begin
  aa:=-angle * pi / 180;
  x:=px;
  y:=py;
  px := CenterX + trunc( (x-CenterX)*cos(aa) - (y-CenterY)*sin(aa) );
  py := CenterY + trunc( (x-CenterX)*sin(aa) + (y-CenterY)*cos(aa) );
end;

function IEISPointInPoly(x,y:integer; poly:array of TPoint):boolean;
var
  i,j:integer;
begin
  result := false;
  j := High(poly);
  for i := Low(poly) to High(poly) do
  begin
    if ((((poly[i].y <= y) and (y < poly[j].y)) or ((poly[j].y <= y) and (y < poly[i].y)) ) and (x < ((poly[j].x - poly[i].x) * (y - poly[i].y) / (poly[j].y - poly[i].y) + poly[i].x))) then
      result := not result;
    j := i
  end;
end;

function IEISPointInPoly2(x, y: integer; PolyPoints: PPointArray; PolyPointsCount: integer; ToSubX, ToSubY, ToAddX, ToAddY: integer; ToMulX, ToMulY:double):boolean;
var
  i,j:integer;
  xi,yi,xj,yj:double;
begin
  result := false;
  j := PolyPointsCount-1;
  for i := 0 to PolyPointsCount-1 do
  begin
    xi := (PolyPoints[i].x-ToSubX)*ToMulX+ToAddX;
    yi := (PolyPoints[i].y-ToSubY)*ToMulY+ToAddY;
    xj := (PolyPoints[j].x-ToSubX)*ToMulX+ToAddX;
    yj := (PolyPoints[j].y-ToSubY)*ToMulY+ToAddY;
    if ((((yi <= y) and (y < yj)) or ((yj <= y) and (y < yi)) ) and (x < ((xj - xi) * (y - yi) / (yj - yi) + xi))) then
      result := not result;
    j := i
  end;
end;

function IEIsLeftMouseButtonPressed:boolean;
begin
  result := (((GetAsyncKeyState(VK_LBUTTON) and $8000)<>0) and (GetSystemMetrics(SM_SWAPBUTTON)=0)) or
            (((GetAsyncKeyState(VK_RBUTTON) and $8000)<>0) and (GetSystemMetrics(SM_SWAPBUTTON)<>0));
end;

function IERGBToStr(rgb:TRGB):AnsiString;
begin
  with rgb do
    result:=IEIntToStr(r)+','+IEIntToStr(g)+','+IEIntToStr(b);
end;

function IEGetURLTypeW(const URL:WideString):TIEURLType;
begin
  result := IEGetURLTypeA(AnsiString(URL));
end;

function IEGetURLTypeA(const URL:AnsiString):TIEURLType;
var
  tmp:AnsiString;
begin
  tmp:=IELowerCase(URL);
  if IECopy(tmp,1,7)='http://' then
    result:=ieurlHTTP
  else if IECopy(tmp,1,8)='https://' then
    result:=ieurlHTTPS
  else if IECopy(tmp,1,6)='ftp://' then
    result:=ieurlFTP
  else
    result:=ieurlUNKNOWN;
end;

// Return distance between (x,y) and the ellipse inside x1,y1,x2,y2
// Coordinates x1,y1,x2,y2 must be ordered
// 3.0.2 (penWidth)
function IEDistPoint2Ellipse(x, y, x1, y1, x2, y2: integer; filled:boolean; penWidth:integer): double;
var
  g, xr1, yr1, xr2, yr2, rx, ry, p, pw, ox, oy: integer;
  d: double;
begin
  result := 2147483647;
  for pw:=-penWidth div 2 to penWidth div 2 do
  begin
    rx := (x2 - x1) div 2 + pw; // ray x
    ry := (y2 - y1) div 2 + pw; // ray y
    ox := x - (x1 + rx)+pw;
    oy := y - (y1 + ry)+pw;
    if filled then
      p := trunc(2 * pi * imin(rx, ry))
    else
      p := trunc(2 * pi * imin(rx, ry)) shr 3;

    if p<2 then p:=2;

    xr1 := rx;
    yr1 := 0;
    for g := 1 to p - 1 do
    begin
      xr2 := trunc(cos((2 * pi / p) * g) * rx);
      yr2 := trunc(sin((2 * pi / p) * g) * ry);
      if filled then
        d := trunc(_DistPoint2Seg(ox, oy, 0, 0, xr2, yr2))
      else
        d := _DistPoint2Seg(ox, oy, xr1, yr1, xr2, yr2);
      if d < result then
        result := d;
      xr1 := xr2;
      yr1 := yr2;
    end;
  end;
end;


// 3.0.2 (penWidth)
function IEDist2Box(x,y, x1,y1,x2,y2:integer; filled:boolean; penWidth:integer):double;
var
  pw:integer;
begin
  result := 2147483647;
  for pw:=-penWidth div 2 to penWidth div 2 do
  begin
    result := dmin(result, dmin(_DistPoint2Seg(x, y, x1+pw, y1+pw, x2+pw, y1+pw),
                           dmin(_DistPoint2Seg(x, y, x2+pw, y1+pw, x2+pw, y2+pw),
                           dmin(_DistPoint2Seg(x, y, x2+pw, y2+pw, x1+pw, y2+pw),
                                _DistPoint2Seg(x, y, x1+pw, y2+pw, x1+pw, y1+pw)))));
    if filled and _InRect(x, y, x1+pw, y1+pw, x2+pw, y2+pw) then
    begin
      result := 0;
      break;
    end;
  end;
end;



function IETrim(const v:AnsiString):AnsiString;
begin
{$IFDEF UNICODE}
  result := AnsiString(trim(string(v)));
{$ELSE}
  result := trim(v);
{$ENDIF}
end;

function IEExtractFileExtS(const FileName:String; includeDot:boolean=true):String;
begin
  result:=ExtractFileExt(LowerCase(FileName));
  if not includeDot then
    result := Copy(result, 2, length(result)-1);
end;

function IEExtractFileExtA(const FileName:AnsiString; includeDot:boolean):AnsiString;
begin
  result:=AnsiString(IEExtractFileExtS(string(FileName),includeDot));
end;

function IEExtractFileExtW(const FileName:WideString; includeDot:boolean):WideString;
begin
  result:=WideString(IEExtractFileExtS(string(FileName),includeDot));
end;

function IEUpperCase(const v:AnsiString):AnsiString;
begin
{$IFDEF UNICODE}
  result := AnsiString(UpperCase(string(v)));
{$ELSE}
  result := UpperCase(v);
{$ENDIF}
end;

function IELowerCase(const v:AnsiString):AnsiString;
begin
{$IFDEF UNICODE}
  result := AnsiString(LowerCase(string(v)));
{$ELSE}
  result := LowerCase(v);
{$ENDIF}
end;

function IEIntToStr(v:integer):AnsiString;
begin
{$IFDEF UNICODE}
  result := AnsiString(IntToStr(v));
{$ELSE}
  result := IntToStr(v);
{$ENDIF}
end;

function IEStrToIntDef(const s:AnsiString; def:integer):integer;
begin
{$IFDEF UNICODE}
  result := StrToIntDef(string(s),def);
{$ELSE}
  result := StrToIntDef(s,def);
{$ENDIF}
end;

function IECopy(S:AnsiString; Index, Count: Integer): AnsiString;
begin
{$IFDEF UNICODE}
  result := AnsiString(Copy(string(S),Index,Count));
{$ELSE}
  result := Copy(S,Index,Count);
{$ENDIF}
end;

function IEFloatToStrFA(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): AnsiString;
begin
  result := AnsiString(FloatToStrF(Value,Format,Precision,Digits));
end;

function IEFloatToStrFS(Value: Extended; Format: TFloatFormat; Precision, Digits: Integer): string;
begin
  result := FloatToStrF(Value,Format,Precision,Digits);
end;

function IEIntToHex(Value: Integer; Digits: Integer): AnsiString;
begin
{$IFDEF UNICODE}
  result := AnsiString(IntToHex(Value,Digits));
{$ELSE}
  result := IntToHex(Value,Digits);
{$ENDIF}
end;

function IEPos(Substr: AnsiString; S: AnsiString): Integer;
begin
{$IFDEF UNICODE}
  result := Pos(string(Substr),string(S));
{$ELSE}
  result := Pos(Substr,S);
{$ENDIF}
end;

function IEExtractFilePathA(const FileName: AnsiString): AnsiString;
begin
{$IFDEF UNICODE}
  result := AnsiString(ExtractFilePath(string(FileName)));
{$ELSE}
  result := ExtractFilePath(FileName);
{$ENDIF}
end;

function IEExtractFilePathW(const FileName: WideString): WideString;
var
  I: Integer;
begin
  I := LastDelimiter('\:', FileName);
  Result := Copy(FileName, 1, I);
end;

function IEExtractFileNameW(const FileName: WideString): WideString;
var
  I: Integer;
begin
  I := LastDelimiter('\:', FileName);
  Result := Copy(FileName, I + 1, MaxInt);
end;


function IEStrDup(s: PAnsiChar): PAnsiChar;
begin
  if s <> nil then
  begin
    getmem(result, strlen(s) + 1);
    StrCopy(result, s);
  end
  else
    result := nil;
end;

function IEFileExists(const FileName: string): Boolean;
var
  Attr: Cardinal;
begin
  if iegUseDefaultFileExists then
    result := FileExists(FileName)
  else
  begin
    // FileGetSize is very slow, GetFileAttributes is much faster
    Attr := GetFileAttributes(Pointer(Filename));
    Result := (Attr <> $FFFFFFFF) and (Attr and FILE_ATTRIBUTE_DIRECTORY = 0);
  end;
end;

function IEFileExistsW(const FileName: WideString): Boolean;
var
  Attr: Cardinal;
begin
  {$IFDEF UNICODE}
  if iegUseDefaultFileExists then
    result := FileExists(string(FileName))
  else
  begin
  {$ENDIF}
    if iegUnicodeOS then
      Attr := GetFileAttributesW(PWideChar(Filename))
    else
      Attr := GetFileAttributesA(PAnsiChar(AnsiString(Filename)));
    Result := (Attr <> $FFFFFFFF) and (Attr and FILE_ATTRIBUTE_DIRECTORY = 0);
  {$IFDEF UNICODE}
  end;
  {$ENDIF}
end;


procedure IEDrawGrayedOut(Canvas:TCanvas; XDst, YDst, WidthDst, HeightDst:integer; SX1, SY1, SX2, SY2:integer);
var
  iec:TIECanvas;
begin
  if (SX1<SX2) and (SY1<SY2) then
  begin
    iec := TIECanvas.Create(Canvas, false);

    iec.Brush.Color := clBlack;
    iec.Brush.Style := bsSolid;
    iec.Brush.Transparency := 150;

    inc(WidthDst);
    inc(HeightDst);

    inc(SX1);
    inc(SY1);
    inc(SX2);
    inc(SY2);

    iec.FillRect(Rect(XDst, YDst, SX1+1, YDst+HeightDst));
    iec.FillRect(Rect(SX2-1, YDst, XDst+WidthDst, YDst+HeightDst));
    iec.FillRect(Rect(SX1, YDst, SX2, SY1+1));
    iec.FillRect(Rect(SX1, SY2, SX2, YDst+HeightDst));

    iec.Free;
  end;
end;

// A TStream.CopyFrom that adjusts "Count" (or autocalculated Count) to source size without raise exceptions
function IECopyFrom(Dest:TStream; Source:TStream; Count: int64):int64;
const
  MaxBufSize = $2FFFF;
var
  BufSize, N: Integer;
  Buffer: pbyte;
begin
  if Count = 0 then
  begin
    Source.Position := 0;
    Count := Source.Size;
  end;

  if not (Source is TZDecompressionStream) and
     not (Source is TZCompressionStream) and
     not (Source is TIEHashStream) then
  begin
    Count := imax(0, imin(Count, Source.Size-Source.Position));
  end;

  Result := Count;

  if Count > MaxBufSize then
    BufSize := MaxBufSize
  else
    BufSize := Count;

  GetMem(Buffer, BufSize);
  try
    while Count <> 0 do
    begin
      if Count > BufSize then N := BufSize else N := Count;
      Source.ReadBuffer(Buffer^, N);
      Dest.WriteBuffer(Buffer^, N);
      Dec(Count, N);
    end;
  finally
    FreeMem(Buffer, BufSize);
  end;
end;


procedure IEDecimalToFraction(value:double; var numerator:integer; var denominator:integer; accuracy:double = 0.000000005);
var
  z: double;
  prevDenominator, sign, sVal:integer;
begin
  if value < 0.0 then
    sign := -1
  else
    sign := +1;
  value := abs(value);
  if value = trunc(value) then
  begin
    numerator := trunc(value * sign);
    denominator := 1;
    exit
  end;
  if value < 1.0E-19 then
  begin
    numerator := sign;
    denominator := 999999999;
    exit
  end;
  if value > 1.0E+19 then
  begin
    numerator := 999999999 * sign;
    denominator := 1;
    exit
  end;
  z := value;
  prevDenominator := 0;
  denominator := 1;
  repeat
    z := 1.0 / (z - trunc(z));
    sVal := denominator;
    denominator := denominator * trunc(z) + prevDenominator;
    prevDenominator := sVal;
    numerator := trunc(value * denominator + 0.5);
  until (abs((value - (numerator / denominator))) < accuracy) or (z = trunc(z));
  numerator := sign * numerator;
end;


procedure IECopyTList(source:TList; dest:TList);
var
  i:integer;
begin
  dest.Count := source.Count;
  for i:=0 to source.Count-1 do
    dest[i] := source[i];
end;

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
// TIEWideStrings


constructor TIEWideStrings.Create;
begin
  inherited;
  fStrings := TList.Create;
end;

destructor TIEWideStrings.Destroy;
begin
  Clear;
  fStrings.Free;
  inherited;
end;

procedure TIEWideStrings.Clear;
var
  i:integer;
begin
  for i:=0 to fStrings.Count-1 do
    FreeMem(fStrings[i]);
  fStrings.Clear;
end;

function TIEWideStrings.GetCount:integer;
begin
  result := fStrings.Count;
end;

function TIEWideStrings.CreateCopyBuffer(const S:WideString):PWideChar;
var
  lenInBytes:integer;
begin
  lenInBytes := (length(S)+1)*sizeof(WideChar);
  getmem(result, lenInBytes);
  CopyMemory(result, @S[1], lenInBytes);
end;

function TIEWideStrings.Add(const S:WideString):integer;
begin
  result := fStrings.Add( CreateCopyBuffer(S) );
end;

procedure TIEWideStrings.SetString(idx:integer; const S:WideString);
begin
  FreeMem(fStrings[idx]);
  fStrings[idx] := CreateCopyBuffer(S);
end;

function TIEWideStrings.GetString(idx:integer):WideString;
begin
  result := WideString(PWideChar(fStrings[idx]));
end;



//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
// TIEDirContent

constructor TIEDirContent.Create(const dir:WideString);
begin
  inherited Create;
  fHandle := Windows.FindFirstFileW(PWChar(dir), fFindData);
  fFirstGot := false;
end;

destructor TIEDirContent.Destroy;
begin
  if fHandle <> INVALID_HANDLE_VALUE then
    Windows.FindClose(fHandle);
  inherited;
end;

function TIEDirContent.getItem(var filename:WideString; getFiles:boolean; getDirs:boolean):boolean;
  function allowIt:boolean;
  begin
    result := (getFiles and not boolean(fFindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY)) or
              (getDirs and boolean(fFindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY));
  end;
begin
  result := true;
  repeat
    if fFirstGot then
      result := Windows.FindNextFileW(fHandle, fFindData);  // return false also when fHandle is INVALID_HANDLE_VALUE
    fFirstGot := true;
  until not result or allowIt;
  filename := fFindData.cFileName;
end;


//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
// TIEHashStream

{$ifdef IEINCLUDEHASHSTREAM}

type HCRYPTPROV = pointer;
type HCRYPTKEY = pointer;
type HCRYPTHASH = pointer;
type ALG_ID = DWORD;


function CryptAcquireContext(out phProv:HCRYPTPROV; pszContainer:PAnsiChar; pszProvider:PAnsiChar; dwProvType:DWORD; dwFlags:DWORD):longbool; stdcall; external 'Advapi32.dll' name 'CryptAcquireContextA';
function CryptCreateHash(hProv:HCRYPTPROV; Algid:ALG_ID; hKey:HCRYPTKEY; dwFlags:DWORD; out phHash:HCRYPTHASH):longbool; stdcall; external 'Advapi32.dll' name 'CryptCreateHash';
function CryptHashData(hHash:HCRYPTHASH; pbData:pbyte; dwDataLen:DWORD; dwFlags:DWORD):longbool; stdcall; external 'Advapi32.dll' name 'CryptHashData';
function CryptGetHashParam(hHash:HCRYPTHASH; dwParam:DWORD; pbData:pbyte; pdwDataLen:PDWORD; dwFlags:DWORD):longbool; stdcall; external 'Advapi32.dll' name 'CryptGetHashParam';
function CryptDestroyHash(hHash:HCRYPTHASH):longbool; stdcall; external 'Advapi32.dll' name 'CryptDestroyHash';
function CryptReleaseContext(hProv:HCRYPTPROV; dwFlags:DWORD):longbool; stdcall; external 'Advapi32.dll' name 'CryptReleaseContext';




// ALG_ID values
const
  CALG_3DES                 = $00006603;  // Triple DES encryption algorithm.
  CALG_3DES_112             = $00006609;  // Two-key triple DES encryption with effective key length equal to 112 bits.
  CALG_AES                  = $00006611;  // Advanced Encryption Standard (AES). This algorithm is supported by the Microsoft AES Cryptographic Provider. Windows 2000/NT:  This algorithm is not supported.
  CALG_AES_128              = $0000660e;  // 128 bit AES. This algorithm is supported by the Microsoft AES Cryptographic Provider. Windows 2000/NT:  This algorithm is not supported.
  CALG_AES_192              = $0000660f;  // 192 bit AES. This algorithm is supported by the Microsoft AES Cryptographic Provider. Windows 2000/NT:  This algorithm is not supported.
  CALG_AES_256              = $00006610;  // 256 bit AES. This algorithm is supported by the Microsoft AES Cryptographic Provider. Windows 2000/NT:  This algorithm is not supported.
  CALG_AGREEDKEY_ANY        = $0000aa03;  // Temporary algorithm identifier for handles of Diffie-Hellman–agreed keys.
  CALG_CYLINK_MEK           = $0000660c;  // An algorithm to create a 40-bit DES key that has parity bits and zeroed key bits to make its key length 64 bits. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_DES                  = $00006601;  // DES encryption algorithm.
  CALG_DESX                 = $00006604;  // DESX encryption algorithm.
  CALG_DH_EPHEM             = $0000aa02;  // Diffie-Hellman ephemeral key exchange algorithm.
  CALG_DH_SF                = $0000aa01;  // Diffie-Hellman store and forward key exchange algorithm.
  CALG_DSS_SIGN             = $00002200;  // DSA public key signature algorithm.
  CALG_ECDH                 = $0000aa05;  // Elliptic curve Diffie-Hellman key exchange algorithm. Windows Server 2003, Windows XP, and Windows 2000/NT:  This algorithm is not supported.
  CALG_ECDSA                = $00002203;  // Elliptic curve digital signature algorithm. Windows Server 2003, Windows XP, and Windows 2000/NT:  This algorithm is not supported.
  CALG_ECMQV                = $0000a001;  // Elliptic curve Menezes, Qu, and Vanstone (MQV) key exchange algorithm. Windows Server 2003, Windows XP, and Windows 2000/NT:  This algorithm is not supported.
  CALG_HASH_REPLACE_OWF     = $0000800b;  // One way function hashing algorithm. Windows 2000/NT:  This algorithm is not supported.
  CALG_HUGHES_MD5           = $0000a003;  // Hughes MD5 hashing algorithm.
  CALG_HMAC                 = $00008009;  // HMAC keyed hash algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_KEA_KEYX             = $0000aa04;  // KEA key exchange algorithm (FORTEZZA).
  CALG_MAC                  = $00008005;  // MAC keyed hash algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_MD2                  = $00008001;  // MD2 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_MD4                  = $00008002;  // MD4 hashing algorithm.
  CALG_MD5                  = $00008003;  // MD5 hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_NO_SIGN              = $00002000;  // No signature algorithm. Windows 2000/NT:  This algorithm is not supported.
  CALG_OID_INFO_CNG_ONLY    = $ffffffff;  // The algorithm is only implemented in CNG. The macro, IS_SPECIAL_OID_INFO_ALGID, can be used to determine whether a cryptography algorithm is only supported by using the CNG functions.
  CALG_OID_INFO_PARAMETERS  = $fffffffe;  // The algorithm is defined in the encoded parameters. The algorithm is only supported by using CNG. The macro, IS_SPECIAL_OID_INFO_ALGID, can be used to determine whether a cryptography algorithm is only supported by using the CNG functions.
  CALG_PCT1_MASTER          = $00004c04;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_RC2                  = $00006602;  // RC2 block encryption algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_RC4                  = $00006801;  // RC4 stream encryption algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_RC5                  = $0000660d;  // RC5 block encryption algorithm.
  CALG_RSA_KEYX             = $0000a400;  // RSA public key exchange algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_RSA_SIGN             = $00002400;  // RSA public key signature algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_SCHANNEL_ENC_KEY     = $00004c07;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_SCHANNEL_MAC_KEY     = $00004c03;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_SCHANNEL_MASTER_HASH = $00004c02;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_SEAL                 = $00006802;  // SEAL encryption algorithm.
  CALG_SHA                  = $00008004;  // SHA hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_SHA1                 = $00008004;  // Same as CALG_SHA. This algorithm is supported by the Microsoft Base Cryptographic Provider.
  CALG_SHA_256              = $0000800c;  // 256 bit SHA hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider. Windows XP and Windows 2000/NT:  This algorithm is not supported.
  CALG_SHA_384              = $0000800d;  // 384 bit SHA hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider. Windows XP and Windows 2000/NT:  This algorithm is not supported.
  CALG_SHA_512              = $0000800e;  // 512 bit SHA hashing algorithm. This algorithm is supported by the Microsoft Base Cryptographic Provider. Windows XP and Windows 2000/NT:  This algorithm is not supported.
  CALG_SKIPJACK             = $0000660a;  // Skipjack block encryption algorithm (FORTEZZA).
  CALG_SSL2_MASTER          = $00004c05;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_SSL3_MASTER          = $00004c01;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_SSL3_SHAMD5          = $00008008;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_TEK                  = $0000660b;  // TEK (FORTEZZA).
  CALG_TLS1_MASTER          = $00004c06;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.
  CALG_TLS1PRF              = $0000800a;  // Used by the Schannel.dll operations system. This ALG_ID should not be used by applications.

// Providers (predefined only)
const
  PROV_RSA_FULL           = 1;
  PROV_RSA_SIG            = 2;
  PROV_DSS                = 3;
  PROV_FORTEZZA           = 4;
  PROV_MS_EXCHANGE        = 5;
  PROV_SSL                = 6;
  PROV_RSA_SCHANNEL       = 12;
  PROV_DSS_DH             = 13;
  PROV_DH_SCHANNEL        = 18;
  PROV_RSA_AES            = 24;

// dwFlags definitions for CryptAcquireContext
const
  CRYPT_VERIFYCONTEXT               = $F0000000;
  CRYPT_NEWKEYSET                   = $00000008;
  CRYPT_DELETEKEYSET                = $00000010;
  CRYPT_MACHINE_KEYSET              = $00000020;
  CRYPT_SILENT                      = $00000040;
  CRYPT_DEFAULT_CONTAINER_OPTIONAL  = $00000080;

const
  HP_ALGID         = $0001;  // Hash algorithm
  HP_HASHVAL       = $0002;  // Hash value
  HP_HASHSIZE      = $0004;  // Hash value size
  HP_HMAC_INFO     = $0005;  // information for creating an HMAC
  HP_TLS1PRF_LABEL = $0006;  // label for TLS1 PRF
  HP_TLS1PRF_SEED  = $0007;  // seed for TLS1 PRF


{!!
<FS>TIEHashStream.Create

<FM>Declaration<FC>
constructor Create(Algorithm:<A TIEHashAlgorithm> = iehaMD5; Buffered:boolean = true);

<FM>Description<FN>
Creates a TIEHashStream which will use specified hash algorithm.
If <FC>Buffered<FN> is true the stream data is written in a temporary memory stream. This is necessary when Seek and Read methods are necessary.

<FM>Example<FC>
// saves the file with an unique name (create hash from the jpeg content and use it as file name)
var
  hashStream:TIEHashStream;
begin
  ImageEnView1.IO.LoadFromFile('input.jpg');
  hashStream := TIEHashStream.Create(iehaMD5);
  try
    ImageEnView1.IO.SaveToStreamJpeg(hashStream);
    hashStream.SaveToFile(hashStream.GetHash()+'.jpg');
  finally
    hashStream.Free;
  end;
end;
!!}
constructor TIEHashStream.Create(Algorithm:TIEHashAlgorithm; Buffered:boolean);
begin
  inherited Create;

  if Buffered then
    m_MemStream := TMemoryStream.Create
  else
    m_MemStream := nil;

  if not CryptAcquireContext(m_CryptProvider, nil, nil, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT or CRYPT_MACHINE_KEYSET) then
    raise Exception.Create('Unable to use CryptoAPI');

  try
    if not CryptCreateHash(m_CryptProvider, DWORD(Algorithm), nil, 0, m_CryptHash) then
      raise Exception.Create('Unable to create Crypto Hash');
  except
    CryptReleaseContext(m_CryptProvider, 0);
    raise;
  end;
end;


destructor TIEHashStream.Destroy;
begin
  m_MemStream.Free;
  CryptDestroyHash(m_CryptHash);
  CryptReleaseContext(m_CryptProvider, 0);
  inherited Destroy;
end;


{!!
<FS>TIEHashStream.GetHash

<FM>Declaration<FC>
function GetHash:AnsiString;

<FM>Description<FN>
Calculates the hash and returns the string representation of the hash.

<FM>Example<FC>
// saves the file with an unique name (create hash from the jpeg content and use it as file name)
var
  hashStream:TIEHashStream;
begin
  ImageEnView1.IO.LoadFromFile('input.jpg');
  hashStream := TIEHashStream.Create(iehaMD5);
  try
    ImageEnView1.IO.SaveToStreamJpeg(hashStream);
    hashStream.SaveToFile(hashStream.GetHash()+'.jpg');
  finally
    hashStream.Free;
  end;
end;
!!}
function TIEHashStream.GetHash:AnsiString;
var
  hash:pbytearray;
  hashSize:DWORD;
  i:integer;
  dw:DWORD;
begin
  result := '';

  if assigned(m_MemStream) then
    if not CryptHashData(m_CryptHash, pbyte(m_MemStream.Memory), m_MemStream.Size, 0) then
      raise Exception.Create('Unable to add hash data');

  // get hash size
  dw := 4;
  if not CryptGetHashParam(m_CryptHash, HP_HASHSIZE, @hashSize, @dw, 0) then
    raise Exception.Create('Unable to create hash');

  getmem(hash, hashSize);

  // get hash data
  dw := hashSize;
  if CryptGetHashParam(m_CryptHash, HP_HASHVAL, @hash[0], @dw, 0) then
    for i := 0 to hashSize - 1 do
      result := result + AnsiString(Format('%.2x', [hash[i]]));

  freemem(hash);

  result := IELowerCase(result);
end;


{!!
<FS>TIEHashStream.Write

<FM>Declaration<FC>
function Write(const Buffer; Count:longint):longint;

<FM>Description<FN>
Writes data in the hash stream.
!!}
function TIEHashStream.Write(const Buffer; Count:longint):longint;
begin
  if assigned(m_MemStream) then
    result := m_MemStream.Write(Buffer, Count)
  else
  begin
    if not CryptHashData(m_CryptHash, pbyte(@Buffer), Count, 0) then
      raise Exception.Create('Unable to add hash data');
    result := Count;
  end;
end;


{!!
<FS>TIEHashStream.Read

<FM>Declaration<FC>
function Read(var Buffer; Count: longint): Longint;

<FM>Description<FN>
Reads data in the hash stream. It is necessary to create the stream as "buffered" to use this method.
!!}
function TIEHashStream.Read(var Buffer; Count: longint): Longint;
begin
  if assigned(m_MemStream) then
    result := m_MemStream.Read(Buffer, Count)
  else
    raise Exception.Create('Read error. Hash stream not Buffered, please create Buffered stream.');
end;


{!!
<FS>TIEHashStream.Seek

<FM>Declaration<FC>
function Seek(const Offset:int64; Origin:TSeekOrigin):int64;

<FM>Description<FN>
Seeks data in the hash stream. It is necessary to create the stream as "buffered" to use this method.
!!}
{$ifdef IEOLDSEEKDEF}
function TIEHashStream.Seek(Offset:longint; Origin:word):longint;
{$else}
function TIEHashStream.Seek(const Offset:int64; Origin:TSeekOrigin):int64;
{$endif}
begin
  if assigned(m_MemStream) then
    result := m_MemStream.Seek(Offset, Origin)
  else
    raise Exception.Create('Seek error. Hash stream not Buffered, please create Buffered stream.');
end;


{!!
<FS>TIEHashStream.SaveToFile

<FM>Declaration<FC>
procedure TIEHashStream.SaveToFile(const filename:AnsiString);

<FM>Description<FN>
Saves the stream to file (this is the actual data written, not the hash). This is useful to save the hashed data one time.
It is necessary to create the stream as "buffered" to use this method.

See also <A TIEHashStream.SaveToStream>.

<FM>Example<FC>
// saves the file with an unique name (create hash from the jpeg content and use it as file name)
var
  hashStream:TIEHashStream;
begin
  ImageEnView1.IO.LoadFromFile('input.jpg');
  hashStream := TIEHashStream.Create(iehaMD5);
  try
    ImageEnView1.IO.SaveToStreamJpeg(hashStream);
    hashStream.SaveToFile(hashStream.GetHash()+'.jpg');
  finally
    hashStream.Free;
  end;
end;
!!}
procedure TIEHashStream.SaveToFile(const filename:AnsiString);
begin
  if assigned(m_MemStream) then
    m_MemStream.SaveToFile(string(filename))
  else
    raise Exception.Create('SaveToFile error. Hash stream not Buffered, please create Buffered stream.');
end;


{!!
<FS>TIEHashStream.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream:TStream);

<FM>Description<FN>
Saves data to stream (this is the actual data written, not the hash). This is useful to save the hashed data one time.
It is necessary to create the stream as "buffered" to use this method.

See also <A TIEHashStream.SaveToFile>.
!!}
procedure TIEHashStream.SaveToStream(Stream:TStream);
begin
  if assigned(m_MemStream) then
    m_MemStream.SaveToStream(Stream)
  else
    raise Exception.Create('SaveToStream error. Hash stream not Buffered, please create Buffered stream.');
end;


{!!
<FS>TIEHashStream.LoadFromFile

<FM>Declaration<FC>
procedure LoadFromFile(const filename:AnsiString);

<FM>Description<FN>
Loads data to hash from specified file.
It is necessary to create the stream as "buffered" to use this method.
!!}
procedure TIEHashStream.LoadFromFile(const filename:AnsiString);
begin
  if assigned(m_MemStream) then
    m_MemStream.LoadFromFile(string(filename))
  else
    raise Exception.Create('LoadFromFile error. Hash stream not Buffered, please create Buffered stream.');
end;


{!!
<FS>TIEHashStream.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream:TStream);

<FM>Description<FN>
Loads data to hash from specified stream.
It is necessary to create the stream as "buffered" to use this method.
!!}
procedure TIEHashStream.LoadFromStream(Stream:TStream);
begin
  if assigned(m_MemStream) then
    m_MemStream.LoadFromStream(Stream)
  else
    raise Exception.Create('LoadFromStream error. Hash stream not Buffered, please create Buffered stream.');
end;

{$endif}

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
// IEGetCoresCount


const

// LOGICAL_PROCESSOR_RELATIONSHIP
  RelationProcessorCore     = 0;
  RelationNumaNode          = 1;
  RelationCache             = 2;
  RelationProcessorPackage  = 3;

// PROCESSOR_CACHE_TYPE
  CacheUnified      = 0;
  CacheInstruction  = 1;
  CacheData         = 2;
  CacheTrace        = 3;

type

  CACHE_DESCRIPTOR = packed record
    Level:BYTE;
    Associativity:BYTE;
    LineSize:WORD;
    Size:DWORD;
    Type_:DWORD;  //PROCESSOR_CACHE_TYPE
  end;

  SYSTEM_LOGICAL_PROCESSOR_INFORMATION = packed record
    ProcessorMask:DWORD;
    Relationship:DWORD; // LOGICAL_PROCESSOR_RELATIONSHIP
    case integer of
      0: (ProcessorCore : packed record Flags:BYTE; end);
      1: (NumaNode : packed record NodeNumber:DWORD; end);
      2: (Cache:CACHE_DESCRIPTOR);
      3: (Reserved : packed record d1:int64; d2:int64; end);
  end;
  PSYSTEM_LOGICAL_PROCESSOR_INFORMATION = ^SYSTEM_LOGICAL_PROCESSOR_INFORMATION;

  TIEGetLogicalProcessorInformation = function(buffer:PSYSTEM_LOGICAL_PROCESSOR_INFORMATION; ReturnLength:PDWORD):longbool; stdcall;

function IEGetCoresCount():integer;
var
  buffer:pointer;
  l, c:integer;
  byteOff:integer;
  curInfo:PSYSTEM_LOGICAL_PROCESSOR_INFORMATION;
  hLib:THandle;
  IEGetLogicalProcessorInformation:TIEGetLogicalProcessorInformation;
begin
  if iegDefaultCoresCount = -1 then
  begin
    iegDefaultCoresCount := 1;
    l := 0;
    buffer := nil;
    hLib := LoadLibrary('Kernel32.dll');
    if hlib<>0 then
    begin
      @IEGetLogicalProcessorInformation := GetProcAddress(hLib, 'GetLogicalProcessorInformation');
      if @IEGetLogicalProcessorInformation<>nil then
      begin
        IEGetLogicalProcessorInformation(buffer, @l); // get length of buffer to allocate
        if GetLastError() = ERROR_INSUFFICIENT_BUFFER then
        begin
          getmem(buffer, l);
          if IEGetLogicalProcessorInformation(buffer, @l) then
          begin
            c := 0;
            curInfo := PSYSTEM_LOGICAL_PROCESSOR_INFORMATION(buffer);
            byteOff := 0;
            while byteOff < l do
            begin
              if curInfo^.Relationship = RelationProcessorCore then
                inc(c);
              inc(curInfo);
              inc(byteOff, sizeof(SYSTEM_LOGICAL_PROCESSOR_INFORMATION));
            end;
            iegDefaultCoresCount := c;
          end;
        end;
      end;
      FreeLibrary(hLib);
    end;
    freemem(buffer);
  end;
  result := iegDefaultCoresCount;
end;

constructor TIEThreadPool.Create;
begin
  inherited;
  fThreads := TList.Create;
end;

destructor TIEThreadPool.Destroy;
begin
  Join();
  fThreads.Free;
  inherited;
end;

procedure TIEThreadPool.Join;
var
  i:integer;
begin
  for i:=0 to fThreads.Count-1 do
  begin
    (TObject(fThreads[i]) as TThread).WaitFor();
    (TObject(fThreads[i]) as TThread).Free;
  end;
  fThreads.Clear;
end;

procedure TIEThreadPool.Add(Thread:TThread);
begin
  fThreads.Add(Thread);
  {$ifdef IEHASTTHREADSTART}
  Thread.Start;
  {$else}
  Thread.Resume;
  {$endif}
end;

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

function IETextWidthW(Canvas:TCanvas; const Text:WideString):integer;
var
  Size:TSize;
begin
  Size.cx := 0;
  Size.cy := 0;
  Windows.GetTextExtentPoint32W(Canvas.Handle, PWideChar(Text), Length(Text), Size);
  result := Size.cx;
end;

function IETextHeightW(Canvas:TCanvas; const Text:WideString):integer;
var
  Size:TSize;
begin
  Size.cx := 0;
  Size.cy := 0;
  Windows.GetTextExtentPoint32W(Canvas.Handle, PWideChar(Text), Length(Text), Size);
  result := Size.cy;
end;



//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIEResourceExtractor

{$ifdef IEINCLUDERESOURCEEXTRACTOR}

function IEIS_INTRESOURCE(const ResID:PAnsiChar):boolean;
begin
  Result := (Windows.HiWord(Windows.DWORD(ResID)) = 0);
end;

function EnumTypesProc(hModule:THandle; lpszType:PAnsiChar; lParam:pointer):longbool; stdcall;
var
  typesList:TStringList;
begin
  typesList := TStringList(lParam);
  if IEIS_INTRESOURCE(lpszType) then
    typesList.Add('INTRESOURCE:'+IntToStr(integer(lpszType)))
  else
    typesList.Add(string(AnsiString(lpszType)));
  result := true;
end;

function EnumNamesProc(hModule:THandle; lpszType:PAnsiChar; lpszName:PAnsiChar; lParam:pointer):longbool; stdcall;
var
  namesList:TStringList;
begin
  namesList := TStringList(lParam);
  if IEIS_INTRESOURCE(lpszName) then
    namesList.Add('INTRESOURCE:'+IntToStr(integer(lpszName)))
  else
    namesList.Add(string(AnsiString(lpszName)));
  result := true;
end;



{!!
<FS>TIEResourceExtractor.Create

<FM>Declaration<FC>
constructor Create(const Filename:WideString);

<FM>Description<FN>

Creates a new instance of TIEResourceExtractor loading the specified PE file (EXE, DLL, OCX, ICL, BPL, etc..).
It is possible to check the success of loading reading <A TIEResourceExtractor.IsValid> property.
<FC>FileName<FN> specifies the path and filename of PE module.

<FM>Example<FC>
  re := TIEResourceExtractor.Create('explorer.exe');
  try
    ...
  finally
    re.Free;
  end;
!!}
constructor TIEResourceExtractor.Create(const Filename:WideString);
const
  LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE = $00000040;
  LOAD_LIBRARY_AS_IMAGE_RESOURCE = $00000020;
var
  resType:PAnsiChar;
  resTypeStr:AnsiString;
  i:integer;
begin
  inherited Create;

  m_hlib := 0;
  m_typesList := nil;
  m_resourceBookmarks := nil;

  if iegOpSys < ieosWinVista then
    m_hlib := LoadLibraryExW(PWideChar(Filename), 0, LOAD_LIBRARY_AS_DATAFILE or DONT_RESOLVE_DLL_REFERENCES)
  else
    m_hlib := LoadLibraryExW(PWideChar(Filename), 0, LOAD_LIBRARY_AS_DATAFILE_EXCLUSIVE or LOAD_LIBRARY_AS_IMAGE_RESOURCE);
  if m_hlib=0 then
    exit;

  // enum types
  m_typesList := TStringList.Create;
  EnumResourceTypesA(m_hlib, @EnumTypesProc, integer(m_typesList));

  // enum names
  for i:=0 to m_typesList.Count-1 do
  begin
    m_typesList.Objects[i] := TStringList.Create;  // associates a list of names to this resource type
    resTypeStr := AnsiString(m_typesList[i]);
    if copy(resTypeStr, 1, 12) = 'INTRESOURCE:' then
      resType := MakeIntResourceA(IEStrToIntDef(IECopy(resTypeStr, 13, length(resTypeStr)-12), 0))
    else
      resType := PAnsiChar(resTypeStr);
    EnumResourceNamesA(m_hlib, resType, @EnumNamesProc, integer(m_typesList.Objects[i]));
  end;

  m_resourceBookmarks := TList.Create;

end;


destructor TIEResourceExtractor.Destroy;
var
  i:integer;
begin

  if assigned(m_resourceBookmarks) then
  begin
    for i:=0 to m_resourceBookmarks.Count-1 do
      TIEResourceBookmark(m_resourceBookmarks[i]).Free;
    m_resourceBookmarks.Free;
  end;

  if assigned(m_typesList) then
  begin
    for i:=0 to m_typesList.Count-1 do
      if assigned(TStringList(m_typesList.Objects[i])) then
        TStringList(m_typesList.Objects[i]).Free;
    m_typesList.Free;
  end;

  if m_hlib<>0 then
    FreeLibrary(m_hlib);

  inherited;
end;



type
  TRES_ICOHEADER = packed record
    wReserved:word;
    wResID:word;
    wNumImages:word;
  end;
  PRES_ICOHEADER = ^TRES_ICOHEADER;

  TRES_ICODIRENTRY = packed record
    bWidth:byte;
    bHeight:byte;
    bColors:byte;
    bReserved:byte;
    wPlanes:word;
    wBitCount:word;
    dwBytesInImage:dword;
    wID:word;
  end;
  PRES_ICODIRENTRY = ^TRES_ICODIRENTRY;

  TRES_CURHEADER = packed record
    wReserved:word;
    wResID:word;
    wNumImages:word;
  end;
  PRES_CURHEADER = ^TRES_CURHEADER;

  TRES_CURDIRENTRY = packed record
    wWidth:word;
    wHeight:word;
    wPlanes:word;
    wBitCount:word;
    dwBytesInImage:dword;
    wID:word;
  end;
  PRES_CURDIRENTRY = ^TRES_CURDIRENTRY;


{!!
<FS>TIEResourceExtractor.IsGroup

<FM>Declaration<FC>
property IsGroup[TypeIndex:integer]:boolean;

<FM>Description<FN>

Returns <FC>true<FN> if the resource type is "GroupIcon" (RT_GROUP_ICON) or "GroupCursor" (RT_GROUP_CURSOR).
This means that resources inside this type must be handled as groups.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
</TABLE>

!!}
function TIEResourceExtractor.GetIsGroup(TypeIndex:integer):boolean;
begin
  result := (FriendlyTypes[TypeIndex] = 'GroupIcon') or (FriendlyTypes[TypeIndex] = 'GroupCursor');
end;


{!!
<FS>TIEResourceExtractor.IsGrouped

<FM>Declaration<FC>
property IsGrouped[TypeIndex:integer]:boolean;

<FM>Description<FN>

Returns <FC>true<FN> if the resource type is "Icon" (RT_ICON) or "Cursor" (RT_CURSOR).
This means that resources inside this type must be grouped in "GroupIcon" or "GroupCursor" resources.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
</TABLE>
!!}
function TIEResourceExtractor.GetIsGrouped(TypeIndex:integer):boolean;
begin
  result := (FriendlyTypes[TypeIndex] = 'Icon') or (FriendlyTypes[TypeIndex] = 'Cursor');
end;


{!!
<FS>TIEResourceExtractor.GroupCountFrames

<FM>Declaration<FC>
property GroupCountFrames[TypeIndex:integer; NameIndex:integer]:integer;

<FM>Description<FN>

Returns the number of frames of specified resource (can be Icon or Cursor resource).

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
</TABLE>
!!}
function TIEResourceExtractor.GetGroupCountFrames(TypeIndex:integer; NameIndex:integer):integer;
var
  iconGroupIndex:integer;
  iconHeader:PRES_ICOHEADER;
  curGroupIndex:integer;
  curHeader:PRES_CURHEADER;
  buffer:pointer;
  bufferLen:integer;
begin
  if FriendlyTypes[TypeIndex] = 'GroupIcon' then
  begin
    iconGroupIndex := IndexOfType('GroupIcon');
    buffer := GetBuffer(iconGroupIndex, NameIndex, bufferLen);
    iconHeader := PRES_ICOHEADER(buffer);
    result := iconHeader^.wNumImages;
  end
  else if FriendlyTypes[TypeIndex] = 'GroupCursor' then
  begin
    curGroupIndex := IndexOfType('GroupCursor');
    buffer := GetBuffer(curGroupIndex, NameIndex, bufferLen);
    curHeader := PRES_CURHEADER(buffer);
    result := curHeader^.wNumImages;
  end
  else
    result := 0;
end;

function GetIconFrameInfo(ResourceExtractor:TIEResourceExtractor; TypeIndex:integer; IconIndex:integer; FrameIndex:integer):PRES_ICODIRENTRY;
var
  buffer:pointer;
  bufferLen:integer;
begin
  result := nil;

  buffer := ResourceExtractor.GetBuffer(TypeIndex, IconIndex, bufferLen);

  // check for buffer overrun
  if sizeof(TRES_ICOHEADER) + sizeof(TRES_ICODIRENTRY)*(FrameIndex+1) > bufferLen then
    exit;

  inc(PRES_ICOHEADER(buffer));                // bypass TRES_ICOHEADER
  inc(PRES_ICODIRENTRY(buffer), FrameIndex);  // bypass unwanted frames (TRES_ICODIRENTRY)
  result := PRES_ICODIRENTRY(buffer);
end;

function GetCurFrameInfo(ResourceExtractor:TIEResourceExtractor; TypeIndex:integer; CurIndex:integer; FrameIndex:integer):PRES_CURDIRENTRY;
var
  buffer:pointer;
  bufferLen:integer;
begin
  buffer := ResourceExtractor.GetBuffer(TypeIndex, CurIndex, bufferLen);
  inc(pbyte(buffer), sizeof(TRES_CURHEADER)); // bypass TRES_CURHEADER
  inc(pbyte(buffer), sizeof(TRES_CURDIRENTRY)*FrameIndex);  // bypass unwanted frames (TRES_CURDIRENTRY)
  result := PRES_CURDIRENTRY(buffer);
end;


{!!
<FS>TIEResourceExtractor.GroupFrameWidth

<FM>Declaration<FC>
property GroupFrameWidth[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:integer;

<FM>Description<FN>

Returns the icon or cursor width. <FC>TypeIndex<FN> must refer to a "GroupIcon" or "GroupCursor" resource type.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
</TABLE>
!!}
function TIEResourceExtractor.GetGroupFrameWidth(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):integer;
begin
  if FriendlyTypes[TypeIndex] = 'GroupIcon' then
  begin
    result := GetIconFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.bWidth;
    if result = 0 then
      result := 256;
  end
  else if FriendlyTypes[TypeIndex] = 'GroupCursor' then
    result := GetCurFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.wWidth
  else
    result := 0;
end;


{!!
<FS>TIEResourceExtractor.GroupFrameHeight

<FM>Declaration<FC>
property GroupFrameHeight[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:integer;

<FM>Description<FN>

Returns the icon or cursor height. <FC>TypeIndex<FN> must refer to a "GroupIcon" or "GroupCursor" resource type.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
</TABLE>
!!}
function TIEResourceExtractor.GetGroupFrameHeight(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):integer;
begin
  if FriendlyTypes[TypeIndex] = 'GroupIcon' then
  begin
    result := GetIconFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.bHeight;
    if result = 0 then
      result := 256;
  end
  else if FriendlyTypes[TypeIndex] = 'GroupCursor' then
    result := GetCurFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.wHeight div 2
  else
    result := 0;
end;


{!!
<FS>TIEResourceExtractor.GroupFrameDepth

<FM>Declaration<FC>
property GroupFrameDepth[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:integer;

<FM>Description<FN>

Returns the icon or cursor bit depth. <FC>TypeIndex<FN> must refer to a "GroupIcon" or "GroupCursor"  resource type.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
</TABLE>
!!}
function TIEResourceExtractor.GetGroupFrameDepth(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):integer;
begin
  if FriendlyTypes[TypeIndex] = 'GroupIcon' then
    result := GetIconFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.wBitCount
  else if FriendlyTypes[TypeIndex] = 'GroupCursor' then
    result := GetCurFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.wBitCount
  else
    result := 0;
end;


{!!
<FS>TIEResourceExtractor.GroupFrameName

<FM>Declaration<FC>
property GroupFrameName[TypeIndex:integer; NameIndex:integer; FrameIndex:integer]:AnsiString;

<FM>Description<FN>

Returns the icon or cursor resource name. <FC>TypeIndex<FN> must refer to a "GroupIcon" or "GroupCursor"  resource type.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
</TABLE>
!!}
function TIEResourceExtractor.GetGroupFrameName(TypeIndex:integer; NameIndex:integer; FrameIndex:integer):AnsiString;
begin
  if FriendlyTypes[TypeIndex] = 'GroupIcon' then
    result := 'INTRESOURCE:'+IEIntToStr(GetIconFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.wID)
  else if FriendlyTypes[TypeIndex] = 'GroupCursor' then
    result := 'INTRESOURCE:'+IEIntToStr(GetCurFrameInfo(self, TypeIndex, NameIndex, FrameIndex)^.wID)
  else
    result := '';
end;


{!!
<FS>TIEResourceExtractor.GetGroupAndFrame

<FM>Declaration<FC>
procedure GetGroupAndFrame(TypeIndex:integer; NameIndex:integer; var GroupTypeIndex:integer; var GroupIndex:integer; var GroupFrameIndex:integer);

<FM>Description<FN>

This method finds the associated grouping resource for the specified resource.
Grouping resources types are "GroupIcon" or "GroupCursor".

<FC>TypeIndex<FN> must be "Icon" or "Cursor", otherwise returns values are undefined.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
<R> <C><FC>GroupTypeIndex<FN></C> <C><Return value: associated group resource type./C> </R>
<R> <C><FC>GroupIndex<FN></C> <C><Return value: associated group resource name./C> </R>
<R> <C><FC>GroupFrameIndex<FN></C> <C><Return value: associated group resource frame./C> </R>
</TABLE>
!!}
procedure TIEResourceExtractor.GetGroupAndFrame(TypeIndex:integer; NameIndex:integer; var GroupTypeIndex:integer; var GroupIndex:integer; var GroupFrameIndex:integer);
var
  a_GroupCount:integer;
  a_GroupCountFrames:integer;
begin
  if FriendlyTypes[TypeIndex] = 'Icon' then
    GroupTypeIndex := IndexOfType('GroupIcon')
  else if FriendlyTypes[TypeIndex] = 'Cursor' then
    GroupTypeIndex := IndexOfType('GroupCursor')
  else
    exit;

  a_GroupCount := NamesCount[GroupTypeIndex];
  GroupIndex := 0;
  while GroupIndex < a_GroupCount do
  begin
    a_GroupCountFrames := GroupCountFrames[GroupTypeIndex, GroupIndex];
    GroupFrameIndex := 0;
    while GroupFrameIndex < a_GroupCountFrames do
    begin
      if GroupFrameName[GroupTypeIndex, GroupIndex, GroupFrameIndex] = Names[TypeIndex, NameIndex] then
        exit;
      inc(GroupFrameIndex);
    end;
    inc(GroupIndex);
  end;
end;


{!!
<FS>TIEResourceExtractor.GetFrameBuffer

<FM>Declaration<FC>
function GetFrameBuffer(TypeIndex:integer; NameIndex:integer; FrameIndex:integer; var BufferLength:integer):pointer;

<FM>Description<FN>

Returns the buffer of specified frame, for multi-frame resources.
TypeIndex must be 'GroupIcon' or 'GroupCursor'.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
<R> <C><FC>FrameIndex<FN></C> <C>The frame index. 0 is first resource name, <A TIEResourceExtractor.GroupCountFrames>-1 is last frame.</C> </R>
<R> <C><FC>BufferLength<FN></C> <C></C> </R>
</TABLE>

!!}
function TIEResourceExtractor.GetFrameBuffer(TypeIndex:integer; NameIndex:integer; FrameIndex:integer; var BufferLength:integer):pointer;
begin
  if FriendlyTypes[TypeIndex] = 'GroupIcon' then
    result := GetBuffer('Icon', GroupFrameName[TypeIndex, NameIndex, FrameIndex], BufferLength)
  else
    result := GetBuffer('Cursor', GroupFrameName[TypeIndex, NameIndex, FrameIndex], BufferLength);
end;


{!!
<FS>TIEResourceExtractor.IndexOfType

<FM>Declaration<FC>
function IndexOfType(TypeName:AnsiString):integer;

<FM>Description<FN>

Finds the index of specified type name (ex. 'Icon', 'Cursor', 'GroupIcon'...).
!!}
function TIEResourceExtractor.IndexOfType(TypeName:AnsiString):integer;
var
  i:integer;
begin
  result := m_typesList.IndexOf(string(TypeName));
  if result=-1 then
    // search as friendly type
    for i:=0 to m_typesList.Count-1 do
      if FriendlyTypes[i] = TypeName then
      begin
        result := i;
        break;
      end;
end;


{!!
<FS>TIEResourceExtractor.IsValid

<FM>Declaration<FC>
property IsValid:boolean;

<FM>Description<FN>

Checks if TIEResourceExtractor contains valid data.

<FM>Example<FC>
re := TIEResourceExtractor.Create('explorer.exe');
if re.IsValid then
begin
  ...
end;
re.Free;
!!}
function TIEResourceExtractor.GetIsValid:boolean;
begin
  result := (m_hlib<>0);
end;


{!!
<FS>TIEResourceExtractor.TypesCount

<FM>Declaration<FC>
property TypesCount:integer;

<FM>Description<FN>

Returns number of resource types found in the PE module.
!!}
function TIEResourceExtractor.GetTypesCount:integer;
begin
  result := m_typesList.Count;
end;


{!!
<FS>TIEResourceExtractor.NamesCount

<FM>Declaration<FC>
property NamesCount[TypeIndex:integer]:integer;

<FM>Description<FN>

Returns number of resource names found in the PE module, for the specified resource type.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
</TABLE>

!!}
function TIEResourceExtractor.GetNamesCount(TypeIndex:integer):integer;
begin
  if TypeIndex < 0 then
    result := 0
  else
    result := TStringList(m_typesList.Objects[TypeIndex]).Count;
end;


{!!
<FS>TIEResourceExtractor.Types

<FM>Declaration<FC>
property Types[TypeIndex:integer]:AnsiString;

<FM>Description<FN>

Returns the specified resource type name.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
</TABLE>

Look also <A TIEResourceExtractor.FriendlyTypes> for more friendly type strings.
!!}
function TIEResourceExtractor.GetTypes(TypeIndex:integer):AnsiString;
begin
  result := AnsiString(m_typesList[TypeIndex]);
end;


{!!
<FS>TIEResourceExtractor.Names

<FM>Declaration<FC>
property Names[TypeIndex:integer; NameIndex:integer]:AnsiString;

<FM>Description<FN>

Returns the resource name for specified type and name index.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
</TABLE>

!!}
function TIEResourceExtractor.GetNames(TypeIndex:integer; NameIndex:integer):AnsiString;
begin
  result := AnsiString(TStringList(m_typesList.Objects[TypeIndex])[NameIndex]);
end;

{!!
<FS>TIEResourceExtractor.FriendlyTypes

<FM>Declaration<FC>
property FriendlyTypes[TypeIndex:integer]:AnsiString;

<FM>Description<FN>

Returns the specified resource type friendly name (for know types like RT_CURSOR, RT_BITMAP, etc...).

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
</TABLE>

Look also <A TIEResourceExtractor.Types> for no so friendly type strings.
!!}
function TIEResourceExtractor.GetFriendlyTypes(TypeIndex:integer):AnsiString;
const
  RT_ACCELERATOR  = $00000009;
  RT_ANICURSOR    = $00000015;
  RT_ANIICON      = $00000016;
  RT_BITMAP       = $00000002;
  RT_CURSOR       = $00000001;
  RT_DIALOG       = $00000005;
  RT_DLGINCLUDE   = $00000011;
  RT_FONT         = $00000008;
  RT_FONTDIR      = $00000007;
  RT_GROUP_CURSOR = $0000000C;
  RT_GROUP_ICON   = $0000000E;
  RT_HTML         = $00000017;
  RT_ICON         = $00000003;
  RT_MANIFEST     = $00000018;
  RT_MENU         = $00000004;
  RT_MESSAGETABLE = $0000000B;
  RT_PLUGPLAY     = $00000013;
  RT_RCDATA       = $0000000A;
  RT_STRING       = $00000006;
  RT_VERSION      = $00000010;
  RT_VXD          = $00000014;
var
  resInt:integer;
begin
  result := Types[TypeIndex];
  if copy(result, 1, 12) = 'INTRESOURCE:' then
  begin
    resInt := IEStrToIntDef(copy(result, 13, length(result)-12), 0);
    case resInt of
      integer(RT_ACCELERATOR): result := 'Accelerator';
      integer(RT_ANICURSOR): result := 'AniCursor';
      integer(RT_ANIICON): result := 'AniIcon';
      integer(RT_BITMAP): result := 'Bitmap';
      integer(RT_CURSOR): result := 'Cursor';
      integer(RT_DIALOG): result := 'Dialog';
      integer(RT_DLGINCLUDE): result := 'DlgInclude';
      integer(RT_FONT): result := 'Font';
      integer(RT_FONTDIR): result := 'FontDir';
      integer(RT_GROUP_CURSOR): result := 'GroupCursor';
      integer(RT_GROUP_ICON): result := 'GroupIcon';
      integer(RT_HTML): result := 'HTML';
      integer(RT_ICON): result := 'Icon';
      integer(RT_MANIFEST): result := 'Manifest';
      integer(RT_MENU): result := 'Menu';
      integer(RT_MESSAGETABLE): result := 'MessageTable';
      integer(RT_PLUGPLAY): result := 'PlugPlay';
      integer(RT_RCDATA): result := 'RCData';
      integer(RT_STRING): result := 'String';
      integer(RT_VERSION): result := 'Version';
      integer(RT_VXD): result := 'VXD';
    end;
  end;
end;


{!!
<FS>TIEResourceExtractor.GetBuffer

<FM>Declaration<FC>
function GetBuffer(TypeIndex:integer; NameIndex:integer; var BufferLength:integer):pointer;
function GetBuffer(const TypeStr:AnsiString; const NameStr:AnsiString; var BufferLength:integer):pointer;
function GetBuffer(ResourceBookmark:<A TIEResourceBookmark>; var BufferLength:integer):pointer;

<FM>Description<FN>

Returns memory buffer for the specified resource.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
<R> <C><FC>BufferLength<FN></C> <C>Field filled with the resulting buffer length (in bytes).</C> </R>
<R> <C><FC>TypeStr<FN></C> <C>Type as string (ie 'Bitmap', 'Cursor').</C> </R>
<R> <C><FC>NameStr<FN></C> <C>Resource name as string (ie 'INTRESOURCE:100', 'Hand').</C> </R>
<R> <C><FC>ResourceBookmark<FN></C> <C>A resource bookmark returned by <A TIEResourceExtractor.GetResourceBookmark>.</C> </R>
</TABLE>

The buffer must not be freed.

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


// loads the resource specified by parameters "resTypeIndex" and "resNameIndex"
var
  buffer:pointer;
  bufferLen:integer;
begin
  buffer := m_ResourceExtractor.GetBuffer(resTypeIndex, resNameIndex, bufferLen);

  ImageEnView1.IO.Params.IsResource := true;

  if m_ResourceExtractor.FriendlyTypes[resTypeIndex] = 'Bitmap' then
    ImageEnView1.IO.LoadFromBuffer(buffer, bufferLen, ioBMP)
  else if m_ResourceExtractor.FriendlyTypes[resTypeIndex] = 'Cursor' then
    ImageEnView1.IO.LoadFromBuffer(buffer, bufferLen, ioCUR)
  else if m_ResourceExtractor.FriendlyTypes[resTypeIndex] = 'Icon' then
    ImageEnView1.IO.LoadFromBuffer(buffer, bufferLen, ioICO)
  else
    // We cannot use ioUnknown (autodect) for BMP, CUR and ICO because it is not possible to autodetect BMP, CUR and ICO when they are resources.
    ImageEnView1.IO.LoadFromBuffer(buffer, bufferLen, ioUnknown)  // for jpegs, GIF, etc...

end;
!!}
function TIEResourceExtractor.GetBuffer(TypeIndex:integer; NameIndex:integer; var BufferLength:integer):pointer;
var
  resName:PAnsiChar;
  resType:PAnsiChar;
  resNameStr:AnsiString;
  resTypeStr:AnsiString;
  resInfo:THandle;
  resData:THandle;
begin
  result := nil;
  BufferLength := 0;

  resTypeStr := Types[TypeIndex];
  if copy(resTypeStr, 1, 12) = 'INTRESOURCE:' then
    resType := MakeIntResourceA(IEStrToIntDef(copy(resTypeStr, 13, length(resTypeStr)-12), 0))
  else
    resType := PAnsiChar(resTypeStr);

  resNameStr := Names[TypeIndex, NameIndex];
  if copy(resNameStr, 1, 12) = 'INTRESOURCE:' then
    resName := MakeIntResourceA(IEStrToIntDef(IECopy(resNameStr, 13, length(resNameStr)-12), 0))
  else
    resName := PAnsiChar(resNameStr);

  resInfo := FindResourceA(m_hlib, resName, resType);
  if resInfo = 0 then
    exit;

  resData := LoadResource(m_hlib, resInfo);
  if resData = 0 then
    exit;

  BufferLength := SizeOfResource(m_hlib, resInfo);
  result := LockResource(resData);
end;

function TIEResourceExtractor.GetBuffer(const TypeStr:AnsiString; const NameStr:AnsiString; var BufferLength:integer):pointer;
var
  TypeIndex:integer;
  NameIndex:integer;
  i:integer;
begin
  result := nil;

  TypeIndex := m_typesList.IndexOf(string(TypeStr));
  if TypeIndex=-1 then
    for i:=0 to m_typesList.Count-1 do
      if FriendlyTypes[i] = TypeStr then
      begin
        TypeIndex := i;
        break;
      end;

  if TypeIndex>-1 then
  begin
    NameIndex := TStringList(m_typesList.Objects[TypeIndex]).IndexOf(string(NameStr));
    if NameIndex>-1 then
      result := GetBuffer(TypeIndex, NameIndex, BufferLength);
  end;
end;


{!!
<FS>TIEResourceExtractor.GetResourceBookmark

<FM>Declaration<FC>
function GetResourceBookmark(TypeIndex:integer; NameIndex:integer; FrameIndex:integer = -1):<A TIEResourceBookmark>;

<FM>Description<FN>

Creates a bookmark for the specified resource (or resource frame).
Bookmarks are automatically freed.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>TypeIndex<FN></C> <C>Index of resource type. 0 is first resource type, <A TIEResourceExtractor.TypesCount>-1 is last resource type.</C> </R>
<R> <C><FC>NameIndex<FN></C> <C>Index of actual resource. 0 is first resource name, <A TIEResourceExtractor.NamesCount>-1 is last resource name.</C> </R>
<R> <C><FC>FrameIndex<FN></C> <C>The frame index. 0 is first resource name, <A TIEResourceExtractor.GroupCountFrames>-1 is last frame.</C> </R>
</TABLE>

!!}
function TIEResourceExtractor.GetResourceBookmark(TypeIndex:integer; NameIndex:integer; FrameIndex:integer = -1):TIEResourceBookmark;
begin
  result := TIEResourceBookmark.Create(TypeIndex, NameIndex, FrameIndex);
  m_resourceBookmarks.Add(result);
end;

function TIEResourceExtractor.GetBuffer(ResourceBookmark:TIEResourceBookmark; var BufferLength:integer):pointer;
begin
  if ResourceBookmark.m_FrameIndex < 0 then
    result := GetBuffer(ResourceBookmark.m_TypeIndex, ResourceBookmark.m_NameIndex, BufferLength)
  else
    result := GetFrameBuffer(ResourceBookmark.m_TypeIndex, ResourceBookmark.m_NameIndex, ResourceBookmark.m_FrameIndex, BufferLength);
end;

constructor TIEResourceBookmark.Create(TypeIndex_, NameIndex_, FrameIndex_:integer);
begin
  inherited Create;
  m_TypeIndex := TypeIndex_;
  m_NameIndex := NameIndex_;
  m_FrameIndex := FrameIndex_;
end;

{$endif}  // IEINCLUDERESOURCEEXTRACTOR

// TIEResourceExtractor
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////



{$ifdef IERFBPROTOCOL}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
// TIE3DES

(*
 * This is D3DES (V5.09) by Richard Outerbridge with the double and
 * triple-length support removed for use in VNC.  Also the bytebit[] array
 * has been reversed so that the most significant bit in each byte of the
 * key is ignored, not the least significant.
 *
 * These changes are
 * Copyright (C) 1999 AT&T Laboratories Cambridge. All Rights Reserved.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *)

(* D3DES (V5.09) -
 *
 * A portable, public domain, version of the Data Encryption Standard.
 *
 * Written with Symantec's THINK (Lightspeed) C by Richard Outerbridge.
 * Thanks to: Dan Hoey for his excellent Initial and Inverse permutation
 * code;  Jim Gillogly & Phil Karn for the DES key schedule code; Dennis
 * Ferguson, Eric Young and Dana How for comparing notes; and Ray Lau,
 * for humouring me on.
 *
 * Copyright (c) 1988,1989,1990,1991,1992 by Richard Outerbridge.
 * (GEnie : OUTER; CIS : [71755,204]) Graven Imagery, 1992.
 *)
(* d3des.h -
 *
 *      Headers and defines for d3des.c
 *      Graven Imagery, 1992.
 *
 * Copyright (c) 1988,1989,1990,1991,1992 by Richard Outerbridge
 *      (GEnie : OUTER; CIS : [71755,204])
 *)

// port to Delphi by HiComponents

// password length max 8 characters
constructor TIE3DES.Create(const Password:AnsiString; Mode:TIE3DESMode);
var
  charbuf:array of AnsiChar;
  i:integer;
begin
  inherited Create;
  ZeroMemory(@KnL[0], length(KnL)*sizeof(dword));
  ZeroMemory(@KnR[0], length(KnL)*sizeof(dword));
  ZeroMemory(@Kn3[0], length(KnL)*sizeof(dword));

  SetLength(charbuf, 8);
  FillChar(charbuf[0], 8, 0);
  for i:=0 to imin(length(Password), 8)-1 do
    charbuf[i] := Password[i+1];
  deskey(@charbuf[0], mode);
end;

destructor TIE3DES.Destroy;
begin
  inherited;
end;

procedure TIE3DES.transform(InBlock:pbyte; OutBlock:pbyte; Length:integer);
var
  i:integer;
begin
  if (Length and $7)<>0 then
    raise EIERFBError.Create('transform length must be multiple of 8');
  i := 0;
  while i < Length do
  begin
    des(InBlock, OutBlock);
    inc(InBlock, 8);
    inc(OutBlock, 8);
    inc(i, 8);
  end;
end;

const
  Df_Key:array [0..23] of byte = (
        $01,$23,$45,$67,$89,$ab,$cd,$ef,
        $fe,$dc,$ba,$98,$76,$54,$32,$10,
        $89,$ab,$cd,$ef,$01,$23,$45,$67 );

  bytebit:array [0..7] of word = ( 1, 2, 4, 8, 16, 32, 64, 128 );

  bigbyte:array [0..23] of dword = (
        $800000,      $400000,      $200000,      $100000,
        $80000,       $40000,       $20000,       $10000,
        $8000,        $4000,        $2000,        $1000,
        $800,         $400,         $200,         $100,
        $80,          $40,          $20,          $10,
        $8,           $4,           $2,           $1    );

  pc1:array [0..55] of byte = (
        56, 48, 40, 32, 24, 16,  8,      0, 57, 49, 41, 33, 25, 17,
         9,  1, 58, 50, 42, 34, 26,     18, 10,  2, 59, 51, 43, 35,
        62, 54, 46, 38, 30, 22, 14,      6, 61, 53, 45, 37, 29, 21,
        13,  5, 60, 52, 44, 36, 28,     20, 12,  4, 27, 19, 11,  3 );

  totrot:array [0..15] of byte = (1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28);

  pc2:array [0..47] of byte = (
        13, 16, 10, 23,  0,  4,  2, 27, 14,  5, 20,  9,
        22, 18, 11,  3, 25,  7, 15,  6, 26, 19, 12,  1,
        40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47,
        43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31 );

// key length must be 8 bytes
procedure TIE3DES.deskey(key:pbytearray; edf:TIE3DESMode);
var
  i, j, l, m, n:integer;
  pc1m:array [0..55] of byte;
  pcr:array [0..55] of byte;
  kn:array [0..31] of dword;
begin
  for j := 0 to 55 do
  begin
    l := pc1[j];
    m := l and 7;
    if (key[l shr 3] and bytebit[m])<>0 then
      pc1m[j] := 1
    else
      pc1m[j] := 0;
  end;
  for i := 0 to 15 do
  begin
    if ( edf = ie3desDECRYPT ) then
      m := (15 - i) shl 1
    else
      m := i shl 1;
    n := m + 1;
    kn[n] := 0;
    kn[m] := 0;
    for j := 0 to 27 do
    begin
      l := j + totrot[i];
      if l < 28 then
        pcr[j] := pc1m[l]
      else
        pcr[j] := pc1m[l - 28];
    end;
    for j := 28 to 55 do
    begin
      l := j + totrot[i];
      if l < 56 then
        pcr[j] := pc1m[l]
      else
        pcr[j] := pc1m[l - 28];
    end;
    for j := 0 to 23 do
    begin
      if pcr[pc2[j]]<>0 then
        kn[m] := kn[m] or bigbyte[j];
      if pcr[pc2[j+24]]<>0 then
        kn[n] := kn[n] or bigbyte[j];
    end;
  end;
  cookey(@kn[0]);
end;

procedure TIE3DES.cookey(raw1:pdword);
var
  cook:pdword;
  raw0:pdword;
  dough:array [0..31] of dword;
  i:integer;
begin
  cook := @dough[0];
  for i := 0 to 15 do
  begin
    raw0 := raw1;
    inc(raw1);
    cook^   := (raw0^ and $00fc0000) shl 6;
    cook^   := cook^ or ((raw0^ and $00000fc0) shl 10);
    cook^   := cook^ or ((raw1^ and $00fc0000) shr 10);
    cook^   := cook^ or ((raw1^ and $00000fc0) shr 6);
    inc(cook);
    cook^   := (raw0^ and $0003f000) shl 12;
    cook^   := cook^ or ((raw0^ and $0000003f) shl 16);
    cook^   := cook^ or ((raw1^ and $0003f000) shr 4);
    cook^   := cook^ or (raw1^ and $0000003f);
    inc(cook);
    inc(raw1);
  end;
  usekey(@dough[0]);
end;

procedure TIE3DES.usekey(from:pdword);
var
  i:integer;
begin
  for i:=0 to 31 do
  begin
    KnL[i] := from^;
    inc(from);
  end;
end;

// 8 bytes buffers
procedure TIE3DES.des(inblock:pbyte; outblock:pbyte);
var
  work:array [0..1] of dword;
begin
  scrunch(inblock, @work[0]);
  desfunc(@work[0], @KnL[0]);
  unscrun(@work[0], outblock);
end;

procedure TIE3DES.scrunch(outof:pbyte; into:pdword);
begin
  into^   := (outof^ and $ff) shl 24; inc(outof);
  into^   := into^ or ((outof^ and $ff) shl 16); inc(outof);
  into^   := into^ or ((outof^ and $ff) shl 8);  inc(outof);
  into^   := into^ or (outof^ and $ff);          inc(outof); inc(into);
  into^   := (outof^ and $ff) shl 24;            inc(outof);
  into^   := into^ or ((outof^ and $ff) shl 16); inc(outof);
  into^   := into^ or ((outof^ and $ff) shl 8);  inc(outof);
  into^   := into^ or (outof^ and $ff);
end;

procedure TIE3DES.unscrun(outof:pdword; into:pbyte);
begin
  into^ := ((outof^ shr 24) and $ff); inc(into);
  into^ := ((outof^ shr 16) and $ff); inc(into);
  into^ := ((outof^ shr  8) and $ff); inc(into);
  into^ := (outof^ and $ff);          inc(into); inc(outof);
  into^ := ((outof^ shr 24) and $ff); inc(into);
  into^ := ((outof^ shr 16) and $ff); inc(into);
  into^ := ((outof^ shr  8) and $ff); inc(into);
  into^ := (outof^ and $ff);
end;

const
  SP1:array [0..63] of dword = (
        $01010400, $00000000, $00010000, $01010404,
        $01010004, $00010404, $00000004, $00010000,
        $00000400, $01010400, $01010404, $00000400,
        $01000404, $01010004, $01000000, $00000004,
        $00000404, $01000400, $01000400, $00010400,
        $00010400, $01010000, $01010000, $01000404,
        $00010004, $01000004, $01000004, $00010004,
        $00000000, $00000404, $00010404, $01000000,
        $00010000, $01010404, $00000004, $01010000,
        $01010400, $01000000, $01000000, $00000400,
        $01010004, $00010000, $00010400, $01000004,
        $00000400, $00000004, $01000404, $00010404,
        $01010404, $00010004, $01010000, $01000404,
        $01000004, $00000404, $00010404, $01010400,
        $00000404, $01000400, $01000400, $00000000,
        $00010004, $00010400, $00000000, $01010004 );

  SP2:array [0..63] of dword = (
        $80108020, $80008000, $00008000, $00108020,
        $00100000, $00000020, $80100020, $80008020,
        $80000020, $80108020, $80108000, $80000000,
        $80008000, $00100000, $00000020, $80100020,
        $00108000, $00100020, $80008020, $00000000,
        $80000000, $00008000, $00108020, $80100000,
        $00100020, $80000020, $00000000, $00108000,
        $00008020, $80108000, $80100000, $00008020,
        $00000000, $00108020, $80100020, $00100000,
        $80008020, $80100000, $80108000, $00008000,
        $80100000, $80008000, $00000020, $80108020,
        $00108020, $00000020, $00008000, $80000000,
        $00008020, $80108000, $00100000, $80000020,
        $00100020, $80008020, $80000020, $00100020,
        $00108000, $00000000, $80008000, $00008020,
        $80000000, $80100020, $80108020, $00108000 );

  SP3:array [0..63] of dword = (
        $00000208, $08020200, $00000000, $08020008,
        $08000200, $00000000, $00020208, $08000200,
        $00020008, $08000008, $08000008, $00020000,
        $08020208, $00020008, $08020000, $00000208,
        $08000000, $00000008, $08020200, $00000200,
        $00020200, $08020000, $08020008, $00020208,
        $08000208, $00020200, $00020000, $08000208,
        $00000008, $08020208, $00000200, $08000000,
        $08020200, $08000000, $00020008, $00000208,
        $00020000, $08020200, $08000200, $00000000,
        $00000200, $00020008, $08020208, $08000200,
        $08000008, $00000200, $00000000, $08020008,
        $08000208, $00020000, $08000000, $08020208,
        $00000008, $00020208, $00020200, $08000008,
        $08020000, $08000208, $00000208, $08020000,
        $00020208, $00000008, $08020008, $00020200 );

  SP4:array [0..63] of dword = (
        $00802001, $00002081, $00002081, $00000080,
        $00802080, $00800081, $00800001, $00002001,
        $00000000, $00802000, $00802000, $00802081,
        $00000081, $00000000, $00800080, $00800001,
        $00000001, $00002000, $00800000, $00802001,
        $00000080, $00800000, $00002001, $00002080,
        $00800081, $00000001, $00002080, $00800080,
        $00002000, $00802080, $00802081, $00000081,
        $00800080, $00800001, $00802000, $00802081,
        $00000081, $00000000, $00000000, $00802000,
        $00002080, $00800080, $00800081, $00000001,
        $00802001, $00002081, $00002081, $00000080,
        $00802081, $00000081, $00000001, $00002000,
        $00800001, $00002001, $00802080, $00800081,
        $00002001, $00002080, $00800000, $00802001,
        $00000080, $00800000, $00002000, $00802080 );

  SP5:array [0..63] of dword = (
        $00000100, $02080100, $02080000, $42000100,
        $00080000, $00000100, $40000000, $02080000,
        $40080100, $00080000, $02000100, $40080100,
        $42000100, $42080000, $00080100, $40000000,
        $02000000, $40080000, $40080000, $00000000,
        $40000100, $42080100, $42080100, $02000100,
        $42080000, $40000100, $00000000, $42000000,
        $02080100, $02000000, $42000000, $00080100,
        $00080000, $42000100, $00000100, $02000000,
        $40000000, $02080000, $42000100, $40080100,
        $02000100, $40000000, $42080000, $02080100,
        $40080100, $00000100, $02000000, $42080000,
        $42080100, $00080100, $42000000, $42080100,
        $02080000, $00000000, $40080000, $42000000,
        $00080100, $02000100, $40000100, $00080000,
        $00000000, $40080000, $02080100, $40000100 );

  SP6:array [0..63] of dword = (
        $20000010, $20400000, $00004000, $20404010,
        $20400000, $00000010, $20404010, $00400000,
        $20004000, $00404010, $00400000, $20000010,
        $00400010, $20004000, $20000000, $00004010,
        $00000000, $00400010, $20004010, $00004000,
        $00404000, $20004010, $00000010, $20400010,
        $20400010, $00000000, $00404010, $20404000,
        $00004010, $00404000, $20404000, $20000000,
        $20004000, $00000010, $20400010, $00404000,
        $20404010, $00400000, $00004010, $20000010,
        $00400000, $20004000, $20000000, $00004010,
        $20000010, $20404010, $00404000, $20400000,
        $00404010, $20404000, $00000000, $20400010,
        $00000010, $00004000, $20400000, $00404010,
        $00004000, $00400010, $20004010, $00000000,
        $20404000, $20000000, $00400010, $20004010 );

  SP7:array [0..63] of dword = (
        $00200000, $04200002, $04000802, $00000000,
        $00000800, $04000802, $00200802, $04200800,
        $04200802, $00200000, $00000000, $04000002,
        $00000002, $04000000, $04200002, $00000802,
        $04000800, $00200802, $00200002, $04000800,
        $04000002, $04200000, $04200800, $00200002,
        $04200000, $00000800, $00000802, $04200802,
        $00200800, $00000002, $04000000, $00200800,
        $04000000, $00200800, $00200000, $04000802,
        $04000802, $04200002, $04200002, $00000002,
        $00200002, $04000000, $04000800, $00200000,
        $04200800, $00000802, $00200802, $04200800,
        $00000802, $04000002, $04200802, $04200000,
        $00200800, $00000000, $00000002, $04200802,
        $00000000, $00200802, $04200000, $00000800,
        $04000002, $04000800, $00000800, $00200002 );

  SP8:array [0..63] of dword = (
        $10001040, $00001000, $00040000, $10041040,
        $10000000, $10001040, $00000040, $10000000,
        $00040040, $10040000, $10041040, $00041000,
        $10041000, $00041040, $00001000, $00000040,
        $10040000, $10000040, $10001000, $00001040,
        $00041000, $00040040, $10040040, $10041000,
        $00001040, $00000000, $00000000, $10040040,
        $10000040, $10001000, $00041040, $00040000,
        $00041040, $00040000, $10041000, $00001000,
        $00000040, $10040040, $00001000, $00041040,
        $10001000, $00000040, $10000040, $10040000,
        $10040040, $10000000, $00040000, $10001040,
        $00000000, $10041040, $00040040, $10000040,
        $10040000, $10001000, $10001040, $00000000,
        $10041040, $00041000, $00041000, $00001040,
        $00001040, $00040040, $10000000, $10041000 );

procedure TIE3DES.desfunc(block:pdwordarray; keys:pdword);
var
  fval, work, right, leftt:dword;
  round:integer;
begin
  leftt := block[0];
  right := block[1];
  work := ((leftt shr 4) xor right) and $0f0f0f0f;
  right := right xor work;
  leftt := leftt xor (work shl 4);
  work := ((leftt shr 16) xor right) and $0000ffff;
  right := right xor work;
  leftt := leftt xor (work shl 16);
  work := ((right shr 2) xor leftt) and $33333333;
  leftt := leftt xor work;
  right := right xor (work shl 2);
  work := ((right shr 8) xor leftt) and $00ff00ff;
  leftt := leftt xor work;
  right := right xor (work shl 8);
  right := ((right shl 1) or ((right shr 31) and 1)) and $ffffffff;
  work := (leftt xor right) and $aaaaaaaa;
  leftt := leftt xor work;
  right := right xor work;
  leftt := ((leftt shl 1) or ((leftt shr 31) and 1)) and $ffffffff;

  for round := 0 to 7 do
  begin
    work := (right shl 28) or (right shr 4);
    work := work xor keys^; inc(keys);
    fval := SP7[ work and $3f];
    fval := fval or SP5[(work shr 8) and $3f];
    fval := fval or SP3[(work shr 16) and $3f];
    fval := fval or SP1[(work shr 24) and $3f];
    work := right xor keys^; inc(keys);
    fval := fval or SP8[work and $3f];
    fval := fval or SP6[(work shr 8) and $3f];
    fval := fval or SP4[(work shr 16) and $3f];
    fval := fval or SP2[(work shr 24) and $3f];
    leftt := leftt xor fval;
    work  := (leftt shl 28) or (leftt shr 4);
    work := work xor keys^; inc(keys);
    fval := SP7[ work and $3f];
    fval := fval or SP5[(work shr 8) and $3f];
    fval := fval or SP3[(work shr 16) and $3f];
    fval := fval or SP1[(work shr 24) and $3f];
    work := leftt xor keys^; inc(keys);
    fval := fval or SP8[work and $3f];
    fval := fval or SP6[(work shr 8) and $3f];
    fval := fval or SP4[(work shr 16) and $3f];
    fval := fval or SP2[(work shr 24) and $3f];
    right := right xor fval;
  end;

  right := (right shl 31) or (right shr 1);
  work := (leftt xor right) and $aaaaaaaa;
  leftt := leftt xor work;
  right := right xor work;
  leftt := (leftt shl 31) or (leftt shr 1);
  work := ((leftt shr 8) xor right) and $00ff00ff;
  right := right xor work;
  leftt := leftt xor (work shl 8);
  work := ((leftt shr 2) xor right) and $33333333;
  right := right xor work;
  leftt := leftt xor (work shl 2);
  work := ((right shr 16) xor leftt) and $0000ffff;
  leftt := leftt xor work;
  right := right xor (work shl 16);
  work := ((right shr 4) xor leftt) and $0f0f0f0f;
  leftt := leftt xor work;
  right := right xor (work shl 4);
  pdword(block)^ := right; inc(pdword(block));
  pdword(block)^ := leftt;
end;


// TIE3DES
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
// TIEClientSocket


const

  WSADESCRIPTION_LEN = 256;
  WSASYS_STATUS_LEN  = 128;
  INVALID_SOCKET     = pointer(-1);
  SOCKET_ERROR       = -1;
  AF_INET            = 2;
  SOCK_STREAM        = 1;
  AF_UNSPEC          = 0;
  IPPROTO_TCP        = 6;
  TCP_NODELAY        = $0001;
  SD_BOTH            = 2;

type

  TWSAData = record
    wVersion:Word;
    wHighVersion:Word;
    szDescription:array[0..WSADESCRIPTION_LEN] of AnsiChar;
    szSystemStatus:array[0..WSASYS_STATUS_LEN] of AnsiChar;
    iMaxSockets:Word;
    iMaxUdpDg:Word;
    lpVendorInfo:PAnsiChar;
  end;

  SunB = packed record
    s_b1, s_b2, s_b3, s_b4: byte;
  end;

  SunW = packed record
    s_w1, s_w2: word;
  end;

  in_addr = record
    case integer of
      0: (S_un_b: SunB);
      1: (S_un_w: SunW);
      2: (S_addr: dword);
  end;

  TInAddr = in_addr;

  sockaddr_in = record
    case Integer of
      0: (sin_family: word;
          sin_port: word;
          sin_addr: TInAddr;
          sin_zero: array[0..7] of AnsiChar);
      1: (sa_family: word;
          sa_data: array[0..13] of AnsiChar)
  end;

  TSockAddr = sockaddr_in;
  PSOCKADDR = ^TSockAddr;

  paddrinfoA = ^addrinfoA;
  addrinfoA = packed record
    ai_flags:integer;
    ai_family:integer;
    ai_socktype:integer;
    ai_protocol:integer;
    ai_addrlen:dword;
    ai_canonname:PAnsiChar;
    ai_addr:PSOCKADDR;
    ai_next:paddrinfoA;
  end;

  TIE_WSAStartup = function(wVersionRequired: word; var WSData:TWSAData):Integer; stdcall;
  TIE_WSACleanup = function():Integer; stdcall;
  TIE_recv = function(s:pointer; var Buf; len, flags:Integer):Integer; stdcall;
  TIE_send = function(s:pointer; var Buf; len, flags:Integer):Integer; stdcall;
  TIE_socket = function(af, Struct, protocol:Integer):pointer; stdcall;
  TIE_getaddrinfo = function(nodename:PAnsiChar; servname:PAnsiChar; hints:paddrinfoA; var res:paddrinfoA):integer; stdcall;
  TIE_freeaddrinfo = procedure(addr:paddrinfoA); stdcall;
  TIE_connect = function(s:pointer; var name:TSockAddr; namelen:Integer):Integer; stdcall;
  TIE_setsockopt = function(s:pointer; level, optname:Integer; optval:PAnsiChar; optlen:Integer):Integer; stdcall;
  TIE_shutdown = function(s:pointer; how:Integer):Integer; stdcall;
  TIE_closesocket = function(s:pointer):Integer; stdcall;

var
  IE_SockLibInitCS:TRTLCriticalSection;
  IE_SockLib:THandle = 0;
  IE_SockLibCount:integer = 0;
  IE_WSAStartup:TIE_WSAStartup = nil;
  IE_WSACleanup:TIE_WSACleanup = nil;
  IE_recv:TIE_recv = nil;
  IE_send:TIE_send = nil;
  IE_socket:TIE_socket = nil;
  IE_getaddrinfo:TIE_getaddrinfo = nil;
  IE_freeaddrinfo:TIE_freeaddrinfo = nil;
  IE_connect:TIE_connect = nil;
  IE_setsockopt:TIE_setsockopt = nil;
  IE_shutdown:TIE_shutdown = nil;
  IE_closesocket:TIE_closesocket = nil;



function IEInitializeSocketLib:boolean;
begin
  EnterCriticalSection(IE_SockLibInitCS);
  result:= true;
  try
    if IE_SockLibCount = 0 then
    begin
      result := false;
      IE_SockLib := LoadLibrary('Ws2_32.dll');
      if IE_SockLib<>0 then
      begin
        IE_WSAStartup := GetProcAddress(IE_SockLib, 'WSAStartup');
        IE_WSACleanup := GetProcAddress(IE_SockLib, 'WSACleanup');
        IE_recv := GetProcAddress(IE_SockLib, 'recv');
        IE_send := GetProcAddress(IE_SockLib, 'send');
        IE_socket := GetProcAddress(IE_SockLib, 'socket');
        IE_getaddrinfo := GetProcAddress(IE_SockLib, 'getaddrinfo');
        IE_freeaddrinfo := GetProcAddress(IE_SockLib, 'freeaddrinfo');
        IE_connect := GetProcAddress(IE_SockLib, 'connect');
        IE_setsockopt := GetProcAddress(IE_SockLib, 'setsockopt');
        IE_shutdown := GetProcAddress(IE_SockLib, 'shutdown');
        IE_closesocket := GetProcAddress(IE_SockLib, 'closesocket');
        result := assigned(@IE_WSAStartup) and assigned(@IE_WSACleanup) and assigned(@IE_recv) and
                  assigned(@IE_send) and assigned(@IE_socket) and assigned(@IE_getaddrinfo) and assigned(@IE_freeaddrinfo) and
                  assigned(@IE_connect) and assigned(@IE_setsockopt) and assigned(@IE_shutdown) and assigned(@IE_closesocket);
        if not result then
          FreeLibrary(IE_SockLib);
      end;
    end;
    if result then
      inc(IE_SockLibCount);
  finally
    LeaveCriticalSection(IE_SockLibInitCS);
  end;
end;

procedure IEFinalizeSocketLib;
begin
  EnterCriticalSection(IE_SockLibInitCS);
  try
    dec(IE_SockLibCount);
    if IE_SockLibCount = 0 then
    begin
      FreeLibrary(IE_SockLib);
      IE_SockLib := 0;
    end;
  finally
    LeaveCriticalSection(IE_SockLibInitCS);
  end;
end;

constructor TIEClientSocket.Create;
var
  versionRequired:word;
  WSData:TWSAData;
begin
  inherited;

  m_socket := INVALID_SOCKET;
  m_littleEndian := false;

  versionRequired := 2 or (2 shl 8);
  if not IEInitializeSocketLib() or (IE_WSAStartUp(versionRequired, WSData)<>0) then
    raise EIERFBError.Create('Failed to startup WinSock');
end;

destructor TIEClientSocket.Destroy;
begin
  IE_WSACleanUp();
  IEFinalizeSocketLib();
  inherited;
end;

procedure TIEClientSocket.ReceiveBuffer(buf:pointer; len:integer);
var
  r, tr:integer;
begin
  tr := 0;
  while tr < len do
  begin
    r := IE_recv(m_socket, pbyte(buf)^, len-tr, 0);
    if r = 0 then
      raise EIERFBError.Create('Connection closed')
    else if r = SOCKET_ERROR then
      raise EIERFBError.Create('Receive error');
    inc(tr, r);
    inc(pbyte(buf), r);
  end;
end;

procedure TIEClientSocket.SendBuffer(buf:pointer; len:integer);
var
  s, ts:integer;
begin
  ts := 0;
  while ts < len do
  begin
    s := IE_send(m_socket, pbyte(buf)^, len-ts, 0);
    if s = SOCKET_ERROR then
      raise EIERFBError.Create('Send error');
    inc(ts, s);
    inc(pbyte(buf), s);
  end;
end;

function TIEClientSocket.ReceiveByte():byte;
begin
  ReceiveBuffer(@result, 1);
end;

procedure TIEClientSocket.ReceivePad(len:integer);
begin
  while len>0 do
  begin
    ReceiveByte();
    dec(len);
  end;
end;

function TIEClientSocket.ReceiveWord():word;
begin
  ReceiveBuffer(@result, 2);
  if not m_littleEndian then
    result := IESwapWord(result);
end;

function TIEClientSocket.ReceiveDWord():dword;
begin
  ReceiveBuffer(@result, 4);
  if not m_littleEndian then
    result := IESwapDWord(result);
end;

procedure TIEClientSocket.SendByte(value:byte);
begin
  SendBuffer(@value, 1);
end;

procedure TIEClientSocket.SendPad(len:integer);
begin
  while len>0 do
  begin
    SendByte(0);
    dec(len);
  end;
end;

procedure TIEClientSocket.SendWord(value:word);
begin
  if not m_littleEndian then
    value := IESwapWord(value);
  SendBuffer(@value, 2);
end;

procedure TIEClientSocket.SendDWord(value:dword);
begin
  if not m_littleEndian then
    value := IESwapDWord(value);
  SendBuffer(@value, 4);
end;

procedure TIEClientSocket.Connect(const Address:string; Port:word);
var
  addr:paddrinfoA;
  hints:addrinfoA;
  PortStr:AnsiString;
  i:integer;
  dw:dword;
begin
  try
    m_socket := IE_socket(AF_INET, SOCK_STREAM, 0);
    if m_socket = INVALID_SOCKET then
      raise EIERFBError.Create('Failed to open socket');

    addr := nil;
    ZeroMemory(@hints, sizeof(addrinfoA));
    hints.ai_family := AF_UNSPEC;
    hints.ai_socktype := SOCK_STREAM;
    hints.ai_protocol := IPPROTO_TCP;
    PortStr := IEIntToStr(Port);
    if IE_getaddrinfo(PAnsiChar(AnsiString(Address)), PAnsiChar(PortStr), @hints, addr) <> 0 then
      raise EIERFBError.Create('Cannot resolve host name');
    i := IE_connect(m_socket, addr^.ai_addr^, addr^.ai_addrlen);
    IE_freeaddrinfo(addr);
    if i = SOCKET_ERROR then
      raise EIERFBError.Create('Connection error');

    dw := 1;
    IE_setsockopt(m_socket, IPPROTO_TCP, TCP_NODELAY, PAnsiChar(@dw), sizeof(BOOL));
  except
    if m_socket<>INVALID_SOCKET then
    begin
      IE_shutdown(m_socket, SD_BOTH);
      IE_closesocket(m_socket);
      m_socket := INVALID_SOCKET;
    end;
    raise;
  end;
end;

procedure TIEClientSocket.Disconnect();
begin
  if Connected then
  begin
    IE_shutdown(m_socket, SD_BOTH);
    IE_closesocket(m_socket);
    m_socket := INVALID_SOCKET;
  end;
end;

function TIEClientSocket.GetConnected:boolean;
begin
  result := m_socket <> INVALID_SOCKET;
end;

// TIEClientSocket
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
// TIERFBClient


{!!
<FS>TIERFBClient.Create

<FM>Declaration<FC>
constructor Create(FrameBuffer:<A TIEBitmap> = nil);

<FM>Description<FN>
Creates a new instance of TIERFBClient using the specified bitmap as framebuffer.
If FrameBuffer is nil then a new bitmap is allocated and owned by the TIERFBClient object.

<FM>Example<FC>

var
  rfb:TIERFBClient;
begin
  rfb := TIERFBClient.Create( ImageEnView1.IEBitmap );
  rfb.OnUpdate := OnVNCUpdate;
  rfb.Connect('My_VNC_Server');
  ...
end;

procedure TForm1.OnVNCUpdate(Sender:TNotifyEvent);
begin
  ImageEnView1.Update;
end;
!!}
constructor TIERFBClient.Create(FrameBuffer:TIEBitmap);
begin
  inherited Create;
  m_socket := TIEClientSocket.Create;
  m_pixelFormat := ierfbRGB32;
  m_OnUpdate := nil;
  m_OnUpdateNonSync := nil;
  m_OnUpdateRect := nil;
  m_OnBell := nil;
  m_OnClipboardText := nil;
  m_OnCursorShapeUpdated := nil;
  m_OnUpdateScreenSize := nil;
  if assigned(FrameBuffer) then
  begin
    m_frameBuffer := FrameBuffer;
    m_freeFrameBuffer := false;
  end
  else
  begin
    m_frameBuffer := TIEBitmap.Create;
    m_freeFrameBuffer := true;
  end;
  m_cursor := TIEBitmap.Create;
  SetLength(m_colorMap, 256);
  m_cursorPos := Point(0, 0);
  m_cursorHotSpot := Point(0, 0);
  m_savedCursorArea := TIEBitmap.Create;
  m_suspended := false;
  InitializeCriticalSection(m_frameBufferLock);
  InitializeCriticalSection(m_socketSendLock);
end;

destructor TIERFBClient.Destroy;
begin
  Disconnect();
  m_socket.Free;
  m_cursor.Free;
  m_savedCursorArea.Free;
  DeleteCriticalSection(m_socketSendLock);
  DeleteCriticalSection(m_frameBufferLock);
  if m_freeFrameBuffer and assigned(m_frameBuffer) then
    FreeAndNil(m_frameBuffer); 
  inherited;
end;


{!!
<FS>TIERFBClient.Connect

<FM>Declaration<FC>
procedure Connect(const Address:string; Port:word = 5900; const Password:AnsiString = '');

<FM>Description<FN>
Connects to the specified RFB (VNC) server.
May throw <A EIERFBError> exception if an error occurs (wrong address, wrong port, unsupported protocol version, authentication failure, etc..).

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Address<FN></C> <C>IP4, IP6 or name of the RFB server.</C> </R>
<R> <C><FC>Port<FN></C> <C>TCP Port of the RFB server.</C> </R>
<R> <C><FC>Password<FN></C> <C>Optional password. Max 8 characters.</C> </R>
</TABLE>


<FM>Example<FC>

var
  rfb:TIERFBClient;
begin
  rfb := TIERFBClient.Create( ImageEnView1.IEBitmap );
  rfb.OnUpdate := OnVNCUpdate;
  try
    rfb.Connect('My_VNC_Server', 5900, '12345678');
  except
    on E:Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

procedure TForm1.OnVNCUpdate(Sender:TNotifyEvent);
begin
  ImageEnView1.Update;
end;
!!}
procedure TIERFBClient.Connect(const Address:string; Port:word; const Password:AnsiString);
const
  supportedEncodings:array [0..4] of integer = (
      0,    // RAW encoding
      2,    // RRE
      1,    // CopyRect encoding
     -239,  // Cursor pseudo-encoding
     -223   // DesktopSize pseudo-encoding
  );
var
  charbuf:array of AnsiChar;
  securityType:dword;
  securityTypesCount:byte;
  securityTypes:array of byte;
  dw:dword;
  challenge:array of byte;
  i:integer;
  des:TIE3DES;
  version:integer; // ie 003.007: 3007
  versionStr:AnsiString;
begin

  m_msgThread := nil;
  securityType := 0;  // invalid

  try

    m_socket.Connect(Address, Port);

    // receive ProtocolVersion
    SetLength(charbuf, 13);
    m_socket.ReceiveBuffer(@charbuf[0], 12);
    charbuf[12] := #0;
    version := IEStrToIntDef(IECopy(AnsiString(charbuf), 5, 3), 0)*1000 + IEStrToIntDef(IECopy(AnsiString(charbuf), 9, 3), 0);

    // decide a protocol version
    if version >= 3008 then // >= 003.008?
      version := 3008   // set 003.008
    else if (version >= 3003) and (version < 3007) then // >= 003.003 and < 003.007?
      version := 3003   // set 003.003
    else if (version <> 3007) then // <> 003.007?
      raise EIERFBError.Create('Unsupported protocol version');

    // send ProtocolVersion
    versionStr := 'RFB 00'+IEIntToStr(version div 1000)+'.00'+IEIntToStr(version - (version div 1000)*1000)+#10;
    m_socket.SendBuffer(PAnsiChar(versionStr), 12);

    if version >= 3007 then // >= 003.007?
    begin

      // receive number-of-security-types (securityTypesCount)
      securityTypesCount := m_socket.ReceiveByte();
      if securityTypesCount = 0 then
      begin
        // failed, describe reason
        dw := m_socket.ReceiveDWord();
        SetLength(charbuf, dw+1);
        m_socket.ReceiveBuffer(@charbuf[0], dw);
        charbuf[dw] := #0;
        raise EIERFBError.Create(string(AnsiString(charbuf)));
      end;

      // receive list of security types (securityTypes)
      SetLength(securityTypes, securityTypesCount);
      m_socket.ReceiveBuffer(@securityTypes[0], securityTypesCount);

      for dw:=0 to securityTypesCount-1 do
        if (securityTypes[dw] = 1) or (securityTypes[dw] = 2) then
        begin
          securityType := securityTypes[dw];  // select "VNC Authentication" or "none"
          break;
        end;

      if securityType = 0 then
        raise EIERFBError.Create('Client unsupports authentication');

      // send selected security type
      m_socket.SendByte(securityType);

    end;

    if version = 3003 then // = 003.003?
    begin
      // server decides and sends security type
      securityType := m_socket.ReceiveDWord();
    end;

    case securityType of
      1: // no authentication
        begin
          if version >= 3008 then  // >= 003.008?
            // receive security result (should also receive failure reason, but we ignore it)
            if m_socket.ReceiveDWord() <> 0 then
              raise EIERFBError.Create('Authentication failed');
        end;
      2: // VNC authentication
        begin
          // receive challenge
          SetLength(challenge, 16);
          m_socket.ReceiveBuffer(@challenge[0], 16);

          // encode challenge
          des := TIE3DES.Create(Password, ie3desENCRYPT);
          des.transform(@challenge[0], @challenge[0], 16);
          des.Free;

          // send encoded challenge
          m_socket.SendBuffer(@challenge[0], 16);

          // receive security result
          if m_socket.ReceiveDWord() <> 0 then  // for 3.008 we should also receive failure reason, but we ignore it
            raise EIERFBError.Create('Authentication failed');
        end;
    end;

    // send Client init message
    m_socket.SendByte(1); // 1 = shared

    // receive Server init message
    m_frameBufferSize.cx := m_socket.ReceiveWord();
    m_frameBufferSize.cy := m_socket.ReceiveWord();
    m_bitsPerPixel       := m_socket.ReceiveByte();
    m_depth              := m_socket.ReceiveByte();
    m_bigEndianFlag      := m_socket.ReceiveByte();
    m_trueColorFlag      := m_socket.ReceiveByte();
    m_redMax             := m_socket.ReceiveWord();
    m_greenMax           := m_socket.ReceiveWord();
    m_blueMax            := m_socket.ReceiveWord();
    m_redShift           := m_socket.ReceiveByte();
    m_greenShift         := m_socket.ReceiveByte();
    m_blueShift          := m_socket.ReceiveByte();
    m_socket.ReceivePad(3);        // pad 3 bytes
    dw := m_socket.ReceiveDWord(); // name length
    SetLength(charbuf, dw+1);
    m_socket.ReceiveBuffer(@charbuf[0], dw);  // name
    charbuf[dw] := #0;
    m_name := AnsiString(charbuf);

    m_frameBuffer.Allocate(m_frameBufferSize.cx, m_frameBufferSize.cy, ie24RGB);

    // send SetEncodings message
    m_socket.SendByte(2); // SetEncodings message
    m_socket.SendPad(1);  // padding
    m_socket.SendWord(length(supportedEncodings)); // number of encodings
    for i:=0 to high(supportedEncodings) do
      m_socket.SendDWord(supportedEncodings[i]);

    m_msgThread := TIERFBMessageThread.Create(self);

    // send SetPixelFormat message
    SendSetPixelFormat(m_pixelFormat);

    // request for the first update
    SendRequestUpdate(false);

  except
    m_msgThread.Free;
    m_msgThread := nil;
    m_socket.Disconnect();
    raise;
  end;

end;

function TIERFBClient.GetConnected:boolean;
begin
  result := m_socket.Connected;
end;


{!!
<FS>TIERFBClient.Disconnect

<FM>Declaration<FC>
procedure Disconnect();

<FM>Description<FN>
Disconnets from the server. Waits for message handler thread terminates, so this function could require some time.
!!}
procedure TIERFBClient.Disconnect();
begin
  if assigned(m_msgThread) then
    m_msgThread.Terminate;
  m_socket.Disconnect();
  if assigned(m_msgThread) then
  begin
    m_msgThread.WaitFor;
    FreeAndNil(m_msgThread);
  end;
end;


{!!
<FS>TIERFBClient.SendRequestUpdate

<FM>Declaration<FC>
procedure SendRequestUpdate(x, y, width, height:word; incremental:boolean);
procedure SendRequestUpdate(incremental:boolean = true);

<FM>Description<FN>
Sends an update request to the server for the specified rectangle or for the whole frame buffer.
May throw <A EIERFBError> exception if a communication error occurs.

Update requests are sent automatically by TIERFBClient, so under normal circumstances, it is not necessary to call this method.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>x<FN></C> <C>Horizontal position of the rectangle to update.</C> </R>
<R> <C><FC>y<FN></C> <C>Vertical position of the rectangle to udpate.</C> </R>
<R> <C><FC>width<FN></C> <C>Width of the rectangle to update.</C> </R>
<R> <C><FC>height<FN></C> <C>Height of the rectangle to update.</C> </R>
<R> <C><FC>incremental<FN></C> <C>If true only we need only changes occurred since last update.</C> </R>
</TABLE>

!!}
procedure TIERFBClient.SendRequestUpdate(x, y, width, height:word; incremental:boolean);
begin
  if not m_suspended then
  begin
    EnterCriticalSection(m_socketSendLock);
    try
      m_socket.SendByte(3);                 // FramebufferUpdateRequest
      m_socket.SendByte(byte(incremental)); // incremental
      m_socket.SendWord(x);                 // x-position
      m_socket.SendWord(y);                 // y-position
      m_socket.SendWord(width);             // width
      m_socket.SendWord(height);            // height
    finally
      LeaveCriticalSection(m_socketSendLock);
    end;
  end;
end;

procedure TIERFBClient.SendRequestUpdate(incremental:boolean);
begin
  SendRequestUpdate(0, 0, m_frameBufferSize.cx, m_frameBufferSize.cy, incremental);
end;


{!!
<FS>TIERFBClient.SendPointerEvent

<FM>Declaration<FC>
procedure SendPointerEvent(x, y:integer; LeftButton:boolean; MiddleButton:boolean; RightButton:boolean);

<FM>Description<FN>
Communicates a new mouse pointer position and mouse buttons state to the server.
SendPointerEvent also updates the frame buffer drawing the mouse cursor, so you should refresh the screen just after.

May throw <A EIERFBError> exception if a communication error occurs.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>x<FN></C> <C>Horizontal coordinate of the mouse (hotspot), relative to the frame buffer.</C> </R>
<R> <C><FC>y<FN></C> <C>Vertical coordinate of the mouse (hotspot), relative to the frame buffer..</C> </R>
<R> <C><FC>LeftButton<FN></C> <C>True if the left button is down.</C> </R>
<R> <C><FC>MiddleButton<FN></C> <C>True if the middle button is down.</C> </R>
<R> <C><FC>RightButton<FN></C> <C>True if the right button is down.</C> </R>
</TABLE>


<FM>Example<FC>

procedure TForm1.ImageEnViewMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if RFB.Connected then
  begin
    RFB.SendPointerEvent(ImageEnView.XScr2Bmp(X), ImageEnView.YScr2Bmp(Y), ssLeft in Shift, ssMiddle in Shift, ssRight in Shift);
    ImageEnView.Update;
  end;
end;
!!}
procedure TIERFBClient.SendPointerEvent(x, y:integer; LeftButton:boolean; MiddleButton:boolean; RightButton:boolean);
var
  bb:byte;
  wx, wy:word;
begin
  LockFrameBuffer();
  wx := imax(0, imin(x, m_frameBufferSize.cx - 1));
  wy := imax(0, imin(y, m_frameBufferSize.cy - 1));
  try
    m_cursorPos := Point(wx, wy);
    RemoveCursor;
    PaintCursor;
  finally
    UnlockFrameBuffer();
  end;

  EnterCriticalSection(m_socketSendLock);
  try
    m_socket.SendByte(5);   // msg-id

    bb := 0;
    if LeftButton then bb := bb or 1;
    if MiddleButton then bb := bb or 2;
    if RightButton then bb := bb or 4;
    m_socket.SendByte(bb);  // button mask

    m_socket.SendWord(wx);  // x-position
    m_socket.SendWord(wy);  // y-position
  finally
    LeaveCriticalSection(m_socketSendLock);
  end;
end;


{!!
<FS>TIERFBClient.SendClipboard

<FM>Declaration<FC>
procedure SendClipboard(const Text:AnsiString);

<FM>Description<FN>
Sends text to the server clipboard. Only ISO 8859-1 (Latin-1) text is supported by the protocol.

May throw <A EIERFBError> exception if a communication error occurs.
!!}
// send ClientCutText message
procedure TIERFBClient.SendClipboard(const Text:AnsiString);
begin
  EnterCriticalSection(m_socketSendLock);
  try
    m_socket.SendByte(6);             // msg-id
    m_socket.SendPad(3);              // 3 bytes padding
    m_socket.SendDWord(length(Text)); // text length
    m_socket.SendBuffer(PAnsiChar(Text), length(Text)); // Text
  finally
    LeaveCriticalSection(m_socketSendLock);
  end;
end;

{!!
<FS>TIERFBClient.SendKeyEvent

<FM>Declaration<FC>
procedure SendKeyEvent(xkey:dword; down:boolean);
procedure SendKeyEvent(VirtualKey:dword; KeyData:dword; down:boolean);

<FM>Description<FN>
Sends a Windows Virtual Key or a XWindow key to the server.
The first overload (XWindow) is fully supported (you can send any XWindow key).
The second overload (VirtualKey) doesn't support all key combinations (like CTRL-?, ALT-?, etc...), so applications should handle these combination manually.

May throw <A EIERFBError> exception if a communication error occurs.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>xkey<FN></C> <C>XWindow key code.</C> </R>
<R> <C><FC>down<FN></C> <C>True when the key is down, False otherwise.</C> </R>
<R> <C><FC>VirtualKey<FN></C> <C>Windows Virtual Key code.</C> </R>
<R> <C><FC>KeyData<FN></C> <C>Windows Virtual Key data.</C> </R>
</TABLE>


<FM>Example<FC>

// send CTRL-ALT-DEL
procedure TForm1.Send_CTRL_ALT_DEL();
begin
  if RFB.Connected then
  begin
    RFB.SendKeyEvent(VK_CONTROL, 0, true);
    RFB.SendKeyEvent(VK_MENU, 0, true);
    RFB.SendKeyEvent(VK_DELETE, 0, true);
    RFB.SendKeyEvent(VK_DELETE, 0, false);
    RFB.SendKeyEvent(VK_MENU, 0, false);
    RFB.SendKeyEvent(VK_CONTROL, 0, false);
  end;
end;

// a very primitive and buggy keyboard sender. Some combinations could not work (ie CTRL-C, ALTR-?...)
procedure TForm1.ImageEnViewVirtualKey(Sender: TObject; VirtualKey, KeyData: Cardinal; KeyDown: Boolean);
begin
  if RFB.Connected then
    RFB.SendKeyEvent(Virtualkey, KeyData, KeyDown);
end;

// we need to handle TABS and ARROWS
procedure TForm1.ImageEnViewSpecialKey(Sender: TObject; CharCode: Word; Shift: TShiftState; var Handled: Boolean);
begin
  Handled := true;
end;
!!}
// send X-Windows key event
procedure TIERFBClient.SendKeyEvent(xkey:dword; down:boolean);
begin
  EnterCriticalSection(m_socketSendLock);
  try
    m_socket.SendByte(4);          // msg-id
    m_socket.SendByte(byte(down)); // down-flag
    m_socket.SendPad(2);           // 2 bytes pad
    m_socket.SendDWord(xkey);      // key
  finally
    LeaveCriticalSection(m_socketSendLock);
  end;
end;

// send Microsoft Windows key event (WM_KEYDOWN, WM_KEYUP, WM_SYSKEYDOWN, WM_SYSKEYUP)
// note: this is a very primitive routine (CTRL-key is missing, and some other combination could not work)
procedure TIERFBClient.SendKeyEvent(VirtualKey:dword; KeyData:dword; down:boolean);
const
  KEYMAP:array [0..73] of array [0..1] of dword = (
    (VK_CANCEL,   $FF6B),  // XK_Break
    (VK_BACK,		  $FF08),  // XK_BackSpace
    (VK_TAB,		  $FF09),  // XK_Tab
    (VK_CLEAR,		$FF0B),  // XK_Clear
    (VK_RETURN,		$FF0D),  // XK_Return
    (VK_SHIFT,    $FFE1),  // XK_Shift_L
    (VK_CONTROL,	$FFE3),  // XK_Control_L
    (VK_MENU,		  $FFE9),  // XK_Alt_L
    (VK_PAUSE,		$FF13),  // XK_Pause
    (VK_CAPITAL,	$FFE5),  // XK_Caps_Lock
    (VK_ESCAPE,		$FF1B),  // XK_Escape
    (VK_SPACE,		$0020),  // XK_space
    (VK_PRIOR,		$FF55),  // XK_Page_Up
    (VK_NEXT,		  $FF56),  // XK_Page_Down
    (VK_END,		  $FF57),  // XK_End
    (VK_HOME,		  $FF50),  // XK_Home
    (VK_LEFT,		  $FF51),  // XK_Left
    (VK_UP,			  $FF52),  // XK_Up
    (VK_RIGHT,		$FF53),  // XK_Right
    (VK_DOWN,		  $FF54),  // XK_Down
    (VK_SELECT,		$FF60),  // XK_Select
  //(VK_PRINT,    $????),
    (VK_EXECUTE,	$FF62),  // XK_Execute
    (VK_SNAPSHOT,	$FF61),  // XK_Print
    (VK_INSERT,		$FF63),  // XK_Insert
    (VK_DELETE,		$FFFF),  // XK_Delete
    (VK_HELP,		  $FF6A),  // XK_Help
  //(VK_LWIN,     $????),
  //(VK_RWIN,     $????),
  //(VK_APPS,     $????),
  //(VK_SLEEP,    $????),
    (VK_NUMPAD0,	$FFB0),  // XK_KP_0
    (VK_NUMPAD1,	$FFB1),  // XK_KP_1
    (VK_NUMPAD2,	$FFB2),  // XK_KP_2
    (VK_NUMPAD3,	$FFB3),  // XK_KP_3
    (VK_NUMPAD4,	$FFB4),  // XK_KP_4
    (VK_NUMPAD5,	$FFB5),  // XK_KP_5
    (VK_NUMPAD6,	$FFB6),  // XK_KP_6
    (VK_NUMPAD7,	$FFB7),  // XK_KP_7
    (VK_NUMPAD8,	$FFB8),  // XK_KP_8
    (VK_NUMPAD9,	$FFB9),  // XK_KP_9
    (VK_MULTIPLY,	$FFAA),  // XK_KP_Multiply
    (VK_ADD,		  $FFAB),  // XK_KP_Add
    (VK_SEPARATOR,$FFAC),  // XK_KP_Separator
    (VK_SUBTRACT,	$FFAD),  // XK_KP_Subtract
    (VK_DECIMAL,	$FFAE),  // XK_KP_Decimal
    (VK_DIVIDE,		$FFAF),  // XK_KP_Divide
    (VK_F1,			  $FFBE),  // XK_F1
    (VK_F2,			  $FFBF),  // XK_F2
    (VK_F3,			  $FFC0),  // XK_F3
    (VK_F4,			  $FFC1),  // XK_F4
    (VK_F5,			  $FFC2),  // XK_F5
    (VK_F6,			  $FFC3),  // XK_F6
    (VK_F7,			  $FFC4),  // XK_F7
    (VK_F8,			  $FFC5),  // XK_F8
    (VK_F9,			  $FFC6),  // XK_F9
    (VK_F10,		  $FFC7),  // XK_F10
    (VK_F11,		  $FFC8),  // XK_F11
    (VK_F12,		  $FFC9),  // XK_F12
    (VK_F13,		  $FFCA),  // XK_F13
    (VK_F14,		  $FFCB),  // XK_F14
    (VK_F15,		  $FFCC),  // XK_F15
    (VK_F16,		  $FFCD),  // XK_F16
    (VK_F17,		  $FFCE),  // XK_F17
    (VK_F18,		  $FFCF),  // XK_F18
    (VK_F19,		  $FFD0),  // XK_F19
    (VK_F20,		  $FFD1),  // XK_F20
    (VK_F21,		  $FFD2),  // XK_F21
    (VK_F22,		  $FFD3),  // XK_F22
    (VK_F23,		  $FFD4),  // XK_F23
    (VK_F24,		  $FFD5),  // XK_F24
    (VK_NUMLOCK,	$FF7F),  // XK_Num_Lock
    (VK_SCROLL,		$FF14),  // XK_Scroll_Lock
    (VK_LSHIFT,		$FFE1),  // XK_Shift_L
    (VK_RSHIFT,		$FFE2),  // XK_Shift_R
    (VK_LCONTROL,	$FFE3),  // XK_Control_L
    (VK_RCONTROL,	$FFE4),  // XK_Control_R
    (VK_LMENU,		$FFE9),  // XK_Alt_L
    (VK_RMENU,		$FFEA)   // XK_Alt_R
);
var
  keyState:TKeyboardState;
  ch:array [0..8] of AnsiChar;
  xkey:dword;
  i:integer;
begin
  Windows.GetKeyboardState(keyState);

  if (KeyData and $1000000)<>0 then
    case VirtualKey of
      VK_RETURN  :
        begin
          SendKeyEvent($FF8D, Down);  // send XK_KP_Enter
          exit;
        end;
      VK_CONTROL :
        VirtualKey := VK_RCONTROL;
      VK_MENU    :
        VirtualKey := VK_RMENU;
    end;

  xkey := 0;
  for i:=0 to high(KEYMAP) do
    if KEYMAP[i][0] = VirtualKey then
    begin
      xkey := KEYMAP[i][1];
      break;
    end;
  if xkey <> 0 then
  begin
    SendKeyEvent(xkey, down);
  end
  else
  begin
    if Windows.ToAscii(VirtualKey, 0, keyState, @ch[0], 0) = 1 then
    begin
      SendKeyEvent(dword(ch[0]), Down);
    end;
  end;
end;

procedure TIERFBClient.SendSetPixelFormat(pixelFormat:TIERFBPixelFormat);
begin
  case pixelFormat of
    ierfbPalette256:
      begin
        m_bitsPerPixel  := 8;
        m_depth         := 8;
        m_bigEndianFlag := 0;
        m_trueColorFlag := 0;
        m_redMax        := 255;
        m_greenMax      := 255;
        m_blueMax       := 255;
        m_redShift      := 0;
        m_greenShift    := 0;
        m_blueShift     := 0;
      end;
    ierfbRGB16:
      begin
        m_bitsPerPixel  := 16;
        m_depth         := 16;
        m_bigEndianFlag := 0;
        m_trueColorFlag := 1;
        m_redMax        := 31;
        m_greenMax      := 63;
        m_blueMax       := 31;
        m_redShift      := 11;
        m_greenShift    := 5;
        m_blueShift     := 0;
      end;
    ierfbRGB32:
      begin
        m_bitsPerPixel  := 32;
        m_depth         := 24;
        m_bigEndianFlag := 0;
        m_trueColorFlag := 1;
        m_redMax        := 255;
        m_greenMax      := 255;
        m_blueMax       := 255;
        m_redShift      := 16;
        m_greenShift    := 8;
        m_blueShift     := 0;
      end;
  end;
  EnterCriticalSection(m_socketSendLock);
  try
    m_socket.SendByte(0);               // msg id
    m_socket.SendPad(3);                // padding 3 bytes
    m_socket.SendByte(m_bitsPerPixel);  // bitsPerPixel
    m_socket.SendByte(m_depth);         // depth
    m_socket.SendByte(m_bigEndianFlag); // big endian flag
    m_socket.SendByte(m_trueColorFlag); // true color flag
    m_socket.SendWord(m_redMax);        // red-max
    m_socket.SendWord(m_greenMax);      // green-max
    m_socket.SendWord(m_blueMax);       // blue-max
    m_socket.SendByte(m_redShift);      // red-shift
    m_socket.SendByte(m_greenShift);    // green-shift
    m_socket.SendByte(m_blueShift);     // blue-shift
    m_socket.SendPad(3);                // padding 3 bytes
  finally
    LeaveCriticalSection(m_socketSendLock);
  end;
end;

procedure TIERFBClient.RemoveCursor;
begin
  if not m_suspended then
  begin
    LockFrameBuffer();
    try
      if not m_savedCursorArea.IsEmpty then
      begin
        m_savedCursorArea.CopyRectTo(m_frameBuffer,
                                     0, 0,                                              // SrcX, SrcY
                                     m_savedCursorPos.X, m_savedCursorPos.Y,            // DstX, DstY
                                     m_savedCursorArea.Width, m_savedCursorArea.Height  // RectWidth, RectHeight
                                     );
        m_savedCursorArea.FreeImage(true);
      end;
    finally
      UnlockFrameBuffer();
    end;
  end;
end;

procedure TIERFBClient.PaintCursor;
var
  neg:TPoint;
begin
  if not m_suspended then
  begin
    LockFrameBuffer();
    try
      if not m_cursor.IsEmpty then
      begin
        // save cursor area
        m_savedCursorPos := Point(m_cursorPos.X - m_cursorHotSpot.X, m_cursorPos.Y - m_cursorHotSpot.Y);
        neg := Point(-imin(0, m_savedCursorPos.X), -imin(0, m_savedCursorPos.Y));
        inc(m_savedCursorPos.X, neg.X);
        inc(m_savedCursorPos.Y, neg.Y);
        m_savedCursorArea.Allocate(m_cursor.Width - neg.X, m_cursor.Height - neg.Y, ie24RGB);
        m_frameBuffer.CopyRectTo(m_savedCursorArea,
                                 m_savedCursorPos.X, m_savedCursorPos.Y,            // sourceX, sourceY
                                 0, 0,                                              // destX, destY
                                 m_savedCursorArea.Width, m_savedCursorArea.Height  // rect width, rect height
                                 );
        // paint cursor
        m_cursor.RenderToTIEBitmapEx(m_frameBuffer,
                                     m_savedCursorPos.X-neg.X, m_savedCursorPos.Y-neg.Y,  // xDst, yDst
                                     m_cursor.Width, m_cursor.Height,         // dxDst, dyDst
                                     0, 0,                                    // xSrc, ySrc
                                     m_cursor.Width, m_cursor.Height,         // dxSrc, dySrc
                                     255, rfNone, ielNormal);
      end;
    finally
      UnlockFrameBuffer();
    end;
  end;
end;


{!!
<FS>TIERFBClient.LockFrameBuffer

<FM>Declaration<FC>
procedure LockFrameBuffer;

<FM>Description<FN>
Locks frame buffer and cursor bitmap preventing writing operations.
This method could freeze message handler thread so make sure to call <A TIERFBClient.UnlockFrameBuffer> and to maintain frame buffer locked for less time as possible.

Applications could prevent frame buffer updates just setting <A TIERFBClient.Suspended> = true, which does not freeze the connection.

<FM>Example<FC>

rfb.LockFrameBuffer;
try
  ImageEnMView1.SetIEBitmap(imageIndex, rfb.FrameBuffer);
finally
  rfb.UnlockFrameBuffer;
end;
!!}
procedure TIERFBClient.LockFrameBuffer;
begin
  EnterCriticalSection(m_frameBufferLock);
end;

{!!
<FS>TIERFBClient.UnlockFrameBuffer

<FM>Declaration<FC>
procedure UnlockFrameBuffer;

<FM>Description<FN>
Unlocks frame buffer and cursor bitmap, locked by <A TIERFBClient.LockFrameBuffer>.

Applications could prevent frame buffer updates just setting <A TIERFBClient.Suspended> = true, which does not freeze the connection.

<FM>Example<FC>

rfb.LockFrameBuffer;
try
  ImageEnMView1.SetIEBitmap(imageIndex, rfb.FrameBuffer);
finally
  rfb.UnlockFrameBuffer;
end;
!!}
procedure TIERFBClient.UnlockFrameBuffer;
begin
  LeaveCriticalSection(m_frameBufferLock);
end;

procedure TIERFBClient.SetSuspended(value:boolean);
begin
  if m_suspended <> value then
  begin
    m_suspended := value;
    if not m_suspended then
      SendRequestUpdate(false);
  end;
end;


// TIERFBClient
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
// TIERFBMessageThread

constructor TIERFBMessageThread.Create(Client:TIERFBClient);
begin
  m_client := Client;
  inherited Create(false);
end;

destructor TIERFBMessageThread.Destroy();
begin
  inherited;
end;

procedure TIERFBMessageThread.execute;
begin
  while not Terminated do
  begin

    try

      // read message type
      case m_client.m_socket.ReceiveByte() of
        0: msg_FrameBufferUpdate();   // FrameBufferUpdate
        1: msg_SetColourMapEntries(); // SetColourMapEntries
        2: msg_Bell();                // Bell
        3: msg_ServerCutText();       // ServerCutText
      end;

      sleep(0);

    except
      break; // exit thread on exception
    end;

  end;

end;


procedure TIERFBMessageThread.msg_FrameBufferUpdate;

  procedure ReceiveBitmap(dst:TIEBitmap; dstX, dstY, rectWidth, rectHeight:integer);
  var
    rowbuf:array of byte;
    p_src:pbyte;
    p_dst:pbyte;
    row:integer;
  begin
    SetLength(rowbuf, rectWidth * rectHeight * m_client.m_bitsPerPixel div 8);
    m_client.m_socket.ReceiveBuffer(@rowbuf[0], length(rowbuf)); // receive frame buffer
    if not m_client.m_suspended then
    begin
      p_src := @rowbuf[0];  // setup source
      for row:=0 to rectHeight-1 do
      begin
        // setup destination
        p_dst := dst.ScanLine[dstY+row];
        inc(p_dst, dstX*3);
        // copy row
        CopyRawRow(p_src, p_dst, rectWidth);
      end;
    end;
  end;

  procedure RAWEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight:word);
  begin
    m_client.LockFrameBuffer();
    try
      m_client.RemoveCursor;
      ReceiveBitmap(m_client.m_FrameBuffer, rectXPosition, rectYPosition, rectWidth, rectHeight);
      m_client.PaintCursor;
    finally
      m_client.UnlockFrameBuffer();
    end;
    if assigned(m_client.m_OnUpdateRect) then
      synchronize(DoOnUpdateRect);
  end;

  procedure CopyRectEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight:word);
  var
    srcX, srcY:word;
  begin
    srcX := m_client.m_socket.ReceiveWord();
    srcY := m_client.m_socket.ReceiveWord();
    if not m_client.m_suspended then
    begin
      m_client.LockFrameBuffer();
      try
        m_client.RemoveCursor;
        m_client.m_frameBuffer.MoveRegion(srcX, srcY, srcX+rectWidth-1, srcY+rectHeight-1, rectXPosition, rectYPosition, 0, false);
        m_client.PaintCursor;
      finally
        m_client.UnlockFrameBuffer();
      end;
      if assigned(m_client.m_OnUpdateRect) then
        synchronize(DoOnUpdateRect);
    end;
  end;

  procedure RREEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight:word);
    function ReadPixel:TRGB;
    var
      pixelbuf:array of byte;
      pb:pbyte;
    begin
      SetLength(pixelbuf, m_client.m_bitsPerPixel div 8);
      m_client.m_socket.ReceiveBuffer(@pixelbuf[0], length(pixelbuf));
      pb := @pixelbuf[0];
      CopyRawRow(pb, pbyte(@result), 1);
    end;
  var
    subRectCount:dword;
    backPixelColor:TRGB;
    subRectPixelColor:TRGB;
    subRectXPos:word;
    subRectYPos:word;
    subRectWidth:word;
    subRectHeight:word;
    i:integer;
  begin
    m_client.LockFrameBuffer();
    try
      m_client.RemoveCursor;
      subRectCount := m_client.m_socket.ReceiveDWord();
      backPixelColor := ReadPixel();
      if not m_client.m_suspended then
        m_client.m_frameBuffer.FillRect(rectXPosition, rectYPosition,
                                        rectXPosition + rectWidth - 1, rectYPosition + rectHeight - 1,
                                        TRGB2TColor(backPixelColor));
      if subRectCount>0 then
      begin
        for i:=0 to subRectCount-1 do
        begin
          subRectPixelColor := ReadPixel();
          subRectXPos := m_client.m_socket.ReceiveWord();
          subRectYPos := m_client.m_socket.ReceiveWord();
          subRectWidth := m_client.m_socket.ReceiveWord();
          subRectHeight := m_client.m_socket.ReceiveWord();
          if not m_client.m_suspended then
          begin
            if (subRectWidth = 1) and (subRectHeight = 1) then
              m_client.m_frameBuffer.Pixels_ie24RGB[rectXPosition + subRectXPos, rectYPosition + subRectYPos] := subRectPixelColor
            else
              m_client.m_frameBuffer.FillRect(rectXPosition + subRectXPos, rectYPosition + subRectYPos,
                                              rectXPosition + subRectXPos + subRectWidth - 1, rectYPosition + subRectYPos + subRectHeight - 1,
                                              TRGB2TColor(subRectPixelColor));
          end;
        end;
      end;
      m_client.PaintCursor;
    finally
      m_client.UnlockFrameBuffer();
    end;
    if assigned(m_client.m_OnUpdateRect) then
      synchronize(DoOnUpdateRect);
  end;

  procedure CursorPseudoEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight:word);
  var
    cursorMask:array of byte;
    cursorMaskLength:integer;
    row, col:integer;
    pb:pbyte;
  begin
    m_client.LockFrameBuffer();
    try
      m_client.m_cursorHotSpot := Point(rectXPosition, rectYPosition);
      m_client.m_cursor.Allocate(rectWidth, rectHeight, ie24RGB);
      ReceiveBitmap(m_client.m_cursor, 0, 0, rectWidth, rectHeight);
      cursorMaskLength := IEFloor((rectWidth+7)/8)*rectHeight;
      SetLength(cursorMask, cursorMaskLength);
      m_client.m_socket.ReceiveBuffer(@cursorMask[0], cursorMaskLength);
      for row:=0 to rectHeight-1 do
      begin
        pb := @cursorMask[ IEFloor((rectWidth+7)/8) * row ];
        for col:=0 to rectWidth-1 do
          if GetPixelbw_inline(pb, col)=0 then
            m_client.m_cursor.Alpha[col, row] := 0;
      end;
      m_client.m_cursor.AlphaChannel.SyncFull;
      m_client.RemoveCursor;
      m_client.PaintCursor;
    finally
      m_client.UnlockFrameBuffer();
    end;
    if assigned(m_client.m_OnCursorShapeUpdated) then
      synchronize(UpdateCursorShape);
  end;

  procedure DesktopSizePseudoEncoding(rectWidth, rectHeight:word);
  begin
    m_client.LockFrameBuffer();
    try
      m_client.RemoveCursor;
      m_client.m_frameBufferSize.cx := rectWidth;
      m_client.m_frameBufferSize.cy := rectHeight;
      if not m_client.m_suspended then
        m_client.m_frameBuffer.Allocate(rectWidth, rectHeight, ie24RGB);
    finally
      m_client.UnlockFrameBuffer();
    end;
    m_client.SendRequestUpdate(false);
    if assigned(m_client.m_OnUpdateScreenSize) then
      synchronize(DoOnUpdateScreenSize);
  end;

var
  rectCount:word;
  rectXPosition:word;
  rectYPosition:word;
  rectWidth:word;
  rectHeight:word;
  rectEncoding:integer;
  rectIdx:integer;
begin

  m_client.m_socket.ReceivePad(1);  // padding
  rectCount := m_client.m_socket.ReceiveWord(); // number of rectangles
  for rectIdx:=0 to rectCount-1 do
  begin
    rectXPosition := m_client.m_socket.ReceiveWord();
    rectYPosition := m_client.m_socket.ReceiveWord();
    rectWidth := m_client.m_socket.ReceiveWord();
    rectHeight := m_client.m_socket.ReceiveWord();
    rectEncoding := m_client.m_socket.ReceiveDWord();

    m_updatedRect := Rect(rectXPosition, rectYPosition,
                          rectXPosition + rectWidth -1, rectYPosition + rectHeight - 1);

    case rectEncoding of

      // RAW encoding
      0: RAWEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight);

      // CopyRect encoding
      1: CopyRectEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight);

      // RRE encoding
      2: RREEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight);

      // Cursor pseudo-encoding

      -239: CursorPseudoEncoding(rectXPosition, rectYPosition, rectWidth, rectHeight);
      // DesktopSize pseudo-encoding
      -223: DesktopSizePseudoEncoding(rectWidth, rectHeight);

      else
        raise EIERFBError.Create('Unsupported encoding');
    end;

  end;

  DoOnUpdateNonSync;  // Non synchronized
  if assigned(m_client.m_OnUpdate) then
    synchronize(DoOnUpdate);
  m_client.SendRequestUpdate();  // always send incremental update
end;

procedure TIERFBMessageThread.UpdateCursorShape;
begin
  m_client.m_OnCursorShapeUpdated(m_client);
end;

// modifies "src"
procedure TIERFBMessageThread.CopyRawRow(var src:pbyte; dst:pbyte; columns:integer);
var
  dw:dword;
  ww:word;
begin
  if m_client.m_trueColorFlag <> 0 then
  begin
    // true color
    case m_client.m_bitsPerPixel of
      16:
        while columns>0 do
        begin
          ww := pword(src)^;
          if m_client.m_bigEndianFlag<>0 then
            ww := IESwapWord(ww);  // convert to littleendian
          // Blue
          dst^ := trunc(((ww shr m_client.m_blueShift) and m_client.m_blueMax)/m_client.m_blueMax*255);
          inc(dst);
          // Green
          dst^ := trunc(((ww shr m_client.m_greenShift) and m_client.m_greenMax)/m_client.m_greenMax*255);
          inc(dst);
          // Red
          dst^ := trunc(((ww shr m_client.m_redShift) and m_client.m_redMax)/m_client.m_redMax*255);
          inc(dst);

          inc(pword(src));
          dec(columns);
        end;
      32:
        while columns>0 do
        begin
          dw := pdword(src)^;
          if m_client.m_bigEndianFlag<>0 then
            dw := IESwapDWord(dw);  // convert to littleendian
          // Blue
          dst^ := (dw shr m_client.m_blueShift) and m_client.m_blueMax;
          inc(dst);
          // Green
          dst^ := (dw shr m_client.m_greenShift) and m_client.m_greenMax;
          inc(dst);
          // Red
          dst^ := (dw shr m_client.m_redShift) and m_client.m_redMax;
          inc(dst);

          inc(pdword(src));
          dec(columns);
        end;
    end;
  end
  else
  begin
    case m_client.m_bitsPerPixel of
      8:
        // palette 256
        while columns>0 do
        begin
          // Blue
          dst^ := m_client.m_colorMap[src^].b and $FF;
          inc(dst);
          // Green
          dst^ := m_client.m_colorMap[src^].g and $FF;
          inc(dst);
          // Red
          dst^ := m_client.m_colorMap[src^].r and $FF;
          inc(dst);

          inc(src);
          dec(columns);
        end;
    end;
  end;
end;

procedure TIERFBMessageThread.DoOnUpdateRect;
begin
  if not m_client.m_suspended then
    m_client.m_OnUpdateRect(m_client, m_updatedRect);
end;

procedure TIERFBMessageThread.DoOnUpdateScreenSize;
begin
  m_client.m_OnUpdateScreenSize(m_client);
end;

procedure TIERFBMessageThread.DoOnUpdate;
begin
  if not m_client.m_suspended then
    m_client.m_OnUpdate(m_client);
end;

procedure TIERFBMessageThread.DoOnUpdateNonSync;
begin
  if assigned(m_client.m_OnUpdateNonSync) and not m_client.m_suspended then
    m_client.m_OnUpdateNonSync(m_client);
end;

procedure TIERFBMessageThread.DoOnBell;
begin
  m_client.m_OnBell(m_client);
end;

procedure TIERFBMessageThread.DoOnClipboardText;
begin
  m_client.m_OnClipboardText(m_client, m_clipboardText);
end;

procedure TIERFBMessageThread.msg_SetColourMapEntries;
var
  firstColor:word;
  numColors:word;
  i:integer;
begin
  m_client.m_socket.ReceivePad(1);  // padding
  firstColor := m_client.m_socket.ReceiveWord(); // first color
  numColors := m_client.m_socket.ReceiveWord();  // number of colors
  if firstColor+numColors > 256 then
    raise EIERFBError.Create('Unsupported number of palette colors');
  for i:=firstColor to numColors-1 do
  begin
    m_client.m_colorMap[i].r := m_client.m_socket.ReceiveWord();
    m_client.m_colorMap[i].g := m_client.m_socket.ReceiveWord();
    m_client.m_colorMap[i].b := m_client.m_socket.ReceiveWord();
  end;
end;

procedure TIERFBMessageThread.msg_Bell;
begin
  if assigned(m_client.m_OnBell) then
    Synchronize(DoOnBell);
end;

procedure TIERFBMessageThread.msg_ServerCutText;
var
  dw:dword;
  charbuf:array of AnsiChar;
begin
  m_client.m_socket.ReceivePad(3); // padding 3 bytes
  dw := m_client.m_socket.ReceiveDWord();
  SetLength(charbuf, dw+1);
  m_client.m_socket.ReceiveBuffer(@charbuf[0], dw);
  charbuf[dw] := #0;
  m_clipboardText := AnsiString(charbuf);
  if assigned(m_client.m_OnClipboardText) then
    Synchronize(DoOnClipboardText);
end;

// TIERFBMessageThread
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

{$endif} // IERFBPROTOCOL






////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////



var
  ieImageEnInitializedMagik:AnsiString;
  ieImageEnInitialized:integer; // 0=not inizialized >0 initialized n times
  ieImageEnInit_CS:TRTLCriticalSection;

// IEInitializeImageEn and IEFinalizeImageEn must be called in initialization/finalization section only of hyieutils
// or in constructor/descructors of objects, or in functions, but not in initialization/finalization section of other units.
// Attention to deadlocks (for example you cannot call IEInitializeImageEn in TImageEnIO creator).

procedure IEInitializeImageEn;
begin
  if ieImageEnInitializedMagik<>'STATICINIT' then
  begin
    // static variables not still intialized, do it here
    ieImageEnInitializedMagik:='STATICINIT';
    ieImageEnInitialized:=0;
    InitializeCriticalSection(ieImageEnInit_CS);
  end;
  EnterCriticalSection(ieImageEnInit_CS);
  try
    if ieImageEnInitialized=0 then
    begin
      // initialize
      IEInitialize_iegdiplus;
      IEInitialize_hyiedefs;
      IEInitialize_hyieutils;
      {$IFDEF IEINCLUDEJPEG2000}
      IEInitialize_iej2000;
      {$ENDIF}
      IEInitialize_ievect;
      IEInitialize_imageenio;
      IEInitialize_imageenproc;
      IEInitialize_imageenview;
      IEInitialize_tifccitt;
      IEInitialize_ietextc;
      IEInitialize_iepresetim;
    end;
    inc(ieImageEnInitialized);
  finally
    LeaveCriticalSection(ieImageEnInit_CS);
  end;
end;

procedure IEFinalizeImageEn;
var
  freecriticalsec:boolean;
begin
  if ieImageEnInitializedMagik<>'STATICINIT' then
    exit;
  freecriticalsec:=false;
  EnterCriticalSection(ieImageEnInit_CS);
  try
    dec(ieImageEnInitialized);
    if ieImageEnInitialized=0 then
    begin
      // finalize
      IEFinalize_iepresetim;
      IEFinalize_ietextc;
      IEFinalize_tifccitt;
      IEFinalize_imageenview;
      IEFinalize_imageenproc;
      IEFinalize_imageenio;
      IEFinalize_ievect;
      {$IFDEF IEINCLUDEJPEG2000}
      IEFinalize_iej2000;
      {$ENDIF}
      IEFinalize_hyieutils;
      IEFinalize_hyiedefs;
      IEFinalize_iegdiplus;
      //
      ieImageEnInitializedMagik:='';
      freecriticalsec:=true;
    end;
  finally
    LeaveCriticalSection(ieImageEnInit_CS);
    if freecriticalsec then
      DeleteCriticalSection(ieImageEnInit_CS);
  end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

procedure IEInitialize_hyieutils;
begin
  begin
    iegDefaultCoresCount := -1;
    iegOpSys := IEGetOpSys;
    iegUnicodeOS := iegOpSys > ieosWinME;
    IESetDefaultTranslationWords;
    IEDefDialogCenter := nil;
    IEDefMinFileSize := -1;
    iegAutoLocateOnDisk := true;
    iegAutoFragmentBitmap := true;
    mscms := 0;
    InitIECosineTab;
    {$ifdef IERFBPROTOCOL}
    InitializeCriticalSection(IE_SockLibInitCS);
    {$endif}
  end;
end;

procedure IEFinalize_hyieutils;
begin
  {$ifdef IERFBPROTOCOL}
  DeleteCriticalSection(IE_SockLibInitCS);
  {$endif}
  if mscms <> 0 then
    FreeLibrary(mscms);
end;



initialization
  IEInitializeImageEn;

finalization
  IEFinalizeImageEn;

end.




