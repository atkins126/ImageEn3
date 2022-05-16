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
File version 1028
*)

unit imageenproc;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}


{$R-}
{$Q-}

{$I ie.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ieview,
  ExtCtrls, hyiedefs, hyieutils, iefft
  {$ifdef IEINCLUDEEXTRATRANSITIONS}
  ,ieXtraTransitions
  {$endif}
  ;

type

{!!
<FS>TGraphFilter

<FM>Declaration<FC>
}
  TGraphFilter = record
    Values: array[0..2, 0..2] of integer;
    Divisor: integer;
  end;
  PIEGraphFilter = ^TGraphFilter;

  // filter exception
  EFilterInvalid = class(Exception);
{!!}

{!!
<FS>TFlipDir
              
<FM>Declaration<FC>
}
  TFlipDir = (fdHorizontal, fdVertical);
{!!}

  // channels and gray level histogram
{!!
<FS>THistogramItem

<FM>Declaration<FC>
}
  THistogramItem = record
    R: DWord;
    G: DWord;
    B: DWord;
    Gray: DWord;
  end;
{!!}

{!!
<FS>THistogram

<FM>Declaration<FC>
THistogram = array[0..255] of <A THistogramItem>;
!!}
  THistogram = array[0..255] of THistogramItem;

  PHistogram = ^THistogram;

{!!
<FS>TPreviewEffects

<FM>Declaration<FC>
}
  TPreviewEffects = set of (peAll, peContrast, peHSV, peHSL, peRGB, peUserFilt, peEqualize, peBumpMap, peLens, peWave, peMorph, peRotate, peFFT, peGamma, peSharpen);
{!!}

{!!
<FS>TPRPreviewsParamsItems

<FM>Declaration<FC>
TPRPreviewsParamsItems = (prppDefaultLockPreview, prppShowResetButton, prppHardReset, prppResetSelectedTab);

<FM>Description<FN>
Specifies some features that the image processing preview dialog will have.

<TABLE>
<R> <H>Value</H> <H>Description</H> </R>
<R> <C><FC>prppDefaultLockPreview<FN></C> <C>Set down the "Lock preview" button when the dialog is shown.</C> </R>
<R> <C><FC>prppShowResetButton<FN></C> <C>Show a "Reset" button, which resets parameters to previous values.</C> </R>
<R> <C><FC>prppHardReset<FN></C> <C>Allow Reset button to reset to default values instead of previous values.</C> </R>
<R> <C><FC>prppResetSelectedTab<FN></C> <C>Allow Reset button to reset only selected tab instead of all tabs.</C> </R>
</TABLE>
!!}
  TPRPreviewsParamsItems = (prppDefaultLockPreview, prppShowResetButton, prppHardReset, prppResetSelectedTab);


{!!
<FS>TPRPreviewsParams

<FM>Declaration<FC>
TPRPreviewsParams = set of <A TPRPreviewsParamsItems>;
!!}
  TPRPreviewsParams = set of TPRPreviewsParamsItems;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TIPDialogParams

{!!
<FS>TIPDialogParams

<FM>Description<FN>
This class allows to get/set several parameters used to control Image Processing Dialog called by <A TImageEnProc.DoPreviews> method.

<FM>Fields<FN>

  CONTRAST_Contrast:integer;
  CONTRAST_Brightness:integer;
  HSV_H:integer;
  HSV_S:integer;
  HSV_V:integer;
  HSL_H:integer;
  HSL_S:integer;
  HSL_L:integer;
  RGB_R:integer;
  RGB_G:integer;
  RGB_B:integer;
  USERFILTER_Values:TGraphFilter;
  EQUALIZATION_ThresholdDown:TRGB;
  EQUALIZATION_ThresholdUp:TRGB;
  EQUALIZATION_EqDown:TRGB;
  EQUALIZATION_EqUp:TRGB;
  EQUALIZATION_EqualizeButton:boolean;
  BUMPMAP_Left:integer;
  BUMPMAP_Top:integer;
  BUMPMAP_Width:integer;
  BUMPMAP_Height:integer;
  BUMPMAP_Col:TRGB;
  BUMPMAP_Src:integer;
  BUMPMAP_Auto:boolean;
  LENS_Left:integer;
  LENS_Top:integer;
  LENS_Width:integer;
  LENS_Height:integer;
  LENS_Ref: double;
  LENS_Auto:boolean;
  WAVE_Amplitude: integer;
  WAVE_WaveLength: integer;
  WAVE_Phase: integer;
  WAVE_Reflect: boolean;
  MORPH_Filter: integer;
  MORPH_WinSize: integer;
  ROTATE_Angle: double;
  GAMMACORRECTION_Value:double;
  SHARPEN_Sharpen: integer;
  SHARPEN_Size: integer;
  FFT_Left:integer;
  FFT_Top:integer;
  FFT_Right:integer;
  FFT_Bottom:integer;
  FFT_GrayScale:boolean;
  FFT_Selection:TMemoryStream;


<FM>Methods<FN>

<A TIPDialogParams.SaveToFile>
<A TIPDialogParams.LoadFromFile>
<A TIPDialogParams.SaveToStream>
<A TIPDialogParams.LoadFromStream>
<A TIPDialogParams.SetProperty>
<A TIPDialogParams.GetProperty>
<A TIPDialogParams.SetDefaultParams>
!!}
  {$ifdef IEINCLUDEDIALOGIP}
  TIPDialogParams = class
  private
    fFFT_Left:integer;
    fFFT_Top:integer;
    fFFT_Right:integer;
    fFFT_Bottom:integer;
    procedure SetFFT_Left(v:integer);
    procedure SetFFT_Top(v:integer);
    procedure SetFFT_Right(v:integer);
    procedure SetFFT_Bottom(v:integer);
  public
    CONTRAST_Contrast:integer;
    CONTRAST_Brightness:integer;
    HSV_H:integer;
    HSV_S:integer;
    HSV_V:integer;
    HSL_H:integer;
    HSL_S:integer;
    HSL_L:integer;
    RGB_R:integer;
    RGB_G:integer;
    RGB_B:integer;
    USERFILTER_Values:TGraphFilter;
    EQUALIZATION_ThresholdDown:TRGB;
    EQUALIZATION_ThresholdUp:TRGB;
    EQUALIZATION_EqDown:TRGB;
    EQUALIZATION_EqUp:TRGB;
    EQUALIZATION_EqualizeButton:boolean;
    BUMPMAP_Left:integer;
    BUMPMAP_Top:integer;
    BUMPMAP_Width:integer;
    BUMPMAP_Height:integer;
    BUMPMAP_Col:TRGB;
    BUMPMAP_Src:integer;
    BUMPMAP_Auto:boolean;
    LENS_Left:integer;
    LENS_Top:integer;
    LENS_Width:integer;
    LENS_Height:integer;
    LENS_Ref: double;
    LENS_Auto:boolean;
    WAVE_Amplitude: integer;
    WAVE_WaveLength: integer;
    WAVE_Phase: integer;
    WAVE_Reflect: boolean;
    MORPH_Filter: integer;
    MORPH_WinSize: integer;
    ROTATE_Angle: double;
    GAMMACORRECTION_Value:double;
    SHARPEN_Sharpen: integer;
    SHARPEN_Size: integer;
    FFT_GrayScale:boolean;
    FFT_Selection:TMemoryStream;
    property FFT_Left:integer read fFFT_Left write SetFFT_Left;
    property FFT_Top:integer read fFFT_Top write SetFFT_Top;
    property FFT_Right:integer read fFFT_Right write SetFFT_Right;
    property FFT_Bottom:integer read fFFT_Bottom write SetFFT_Bottom;
    constructor Create;
    destructor Destroy; override;
    procedure SaveToFile(const FileName:string);
    procedure LoadFromFile(const FileName:string);
    procedure SaveToStream(Stream:TStream);
    procedure LoadFromStream(Stream:TStream);
    procedure SetProperty(Prop,Value:string);
    function GetProperty(const Prop:string):string;
    procedure SetDefaultParams;
  end;
  {$endif}

// TIPDialogParams
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
<FS>TIEFilterPresets

<FM>Declaration<FC>
}
  TIEFilterPresets = integer;
{!!}

{!!
<FS>TIEPreviewEvent

<FM>Declaration<FC>
}
  TIEPreviewEvent = procedure(Sender: TObject; PreviewForm: TForm) of object;
{!!}

{!!
<FS>TIEChannels

<FM>Declaration<FC>
}
  TIEChannels = set of (iecRed, iecGreen, iecBlue);
{!!}

{!!
<FS>TIEUndoSource

<FM>Declaration<FC>
}
  TIEUndoSource = (ieuUnknown, ieuImage, ieuSelection, ieuObject, ieuLayer, ieuFullLayer, ieuObjectsAndLayers);
{!!}

{!!
<FS>TIEAntialiasMode

<FM>Declaration<FC>
}
  TIEAntialiasMode = (ierFast, ierBilinear, ierBicubic);
{!!}



{!!
<FS>TIEMedFilType

<FM>Declaration<FC>
}
  TIEMedFilType = (mfMedianFilter, mfSharpen, mfEdgeExtract);
{!!}

{!!
<FS>TIESaveUndoEvent

<FM>Declaration<FC>
TIESaveUndoEvent = procedure(Sender:TObject; source:<A TIEUndoSource>) of object;
!!}
  TIESaveUndoEvent = procedure(Sender:TObject; source:TIEUndoSource) of object;


{!!
<FS>TIEDeinterlaceMode

<FM>Declaration<FC>
TIEDeinterlaceMode = (iedDiscard, iedIntelliMerge);

<FM>Description<FN>
<FC>iedDiscard<FN> just discards one row every two.
<FC>iedIntelliMerge<FN> merges only if the two fields are similar (less movement).
!!}
  TIEDeinterlaceMode = (iedDiscard, iedIntelliMerge);

{!!
<FS>TIEThreshMode

<FM>Declaration<FC>
}
TIEThreshMode = (ietMean, ietMedian, ietMeanMinMax);
{!!}

{!!
<FS>TIECmpMode

<FM>Declaration<FC>
}
TIECmpMode = (
  iecmpRMSE,        // Root Mean Square error
  iecmpHamming,     // Hamming distance
  iecmpCovariance   // Covariance
);
{!!}

{!!
<FS>TImageEnProc

<FM>Description<FN>
TImageEnProc provides image processing and analysis tasks on attached <A TImageEnView>,  <A TImageEnDBView>, <A TImageEn>, <A TIEBitmap>, TImage or TBitmap components. Also, it handles all clipboard operations.
It includes an area selection capability for most of image processing tasks (only if the attached component isn't TImageEnView, which already has the area selection capability).

<A TImageEnView> already encapsulates <A TImageEnIO> and TImageEnProc, so you don't actually need to put a TImageEnProc on the form.



<FM>Methods and Properties<FN>

  <FI>Connected component<FN>

  <A TImageEnProc.AttachedBitmap>
  <A TImageEnProc.AttachedIEBitmap>
  <A TImageEnProc.AttachedImageEn>
  <A TImageEnProc.AttachedTImage>

  <FI>Dialogs<FN>

  <A TImageEnProc.DoPreviews>
  <A TImageEnProc.IPDialogParams>
  <A TImageEnProc.MsgLanguage>
  <A TImageEnProc.PreviewFont>
  <A TImageEnProc.PreviewsLog>
  <A TImageEnProc.PreviewsParams>

  <FI>Shadows<FN>

  <A TImageEnProc.AddInnerShadow>
  <A TImageEnProc.AddSoftShadow>

  <FI>Fourier Analysis (FFT)<FN>

  <A TImageEnProc.FTClearZone>
  <A TImageEnProc.FTConvertFrom>
  <A TImageEnProc.FTCreateImage>
  <A TImageEnProc.FTDisplayFrom>

  <FI>Paint<FN>

  <A TImageEnProc.CastColor>
  <A TImageEnProc.ClearSel>
  <A TImageEnProc.Clear>
  <A TImageEnProc.Fill>
  <A TImageEnProc.PaintMark>
  <A TImageEnProc.PaintPenMarker>

  <FI>Alpha channel<FN>

  <A TImageEnProc.CastAlpha>
  <A TImageEnProc.SetTransparentColors>

  <FI>Custom Image Processing<FN>

  <A TImageEnProc.BeginImageProcessing>
  <A TImageEnProc.EndImageProcessing>

  <FI>Custom Image Analysis<FN>

  <A TImageEnProc.BeginImageAnalysis>
  <A TImageEnProc.EndImageAnalysis>

  <FI>Analysis<FN>

  <A TImageEnProc.CalcAverageRGB>
  <A TImageEnProc.CalcDensityHistogram>
  <A TImageEnProc.CalcImageNumColors>
  <A TImageEnProc.CalcImagePalette>
  <A TImageEnProc.CalcOrientation>
  <A TImageEnProc.CompareWith>
  <A TImageEnProc.CompareHistogramWith>
  <A TImageEnProc.ComputeImageEquality>
  <A TImageEnProc.GetDominantColor>
  <A TImageEnProc.GetHistogram>
  <A TImageEnProc.GetHSVChannelAll>
  <A TImageEnProc.GetHSVChannel>
  <A TImageEnProc.GetRGBChannelAll>
  <A TImageEnProc.GetRGBChannel>
  <A TImageEnProc.SeparateObjects>

  <FI>Noise<FN>

  <A TImageEnProc.RemoveIsolatedPixels>
  <A TImageEnProc.RemoveNoise>

  <FI>Pixels<FN>

  <A TImageEnProc.AdjustBrightnessContrastSaturation>
  <A TImageEnProc.AdjustLumSatHistogram>
  <A TImageEnProc.AdjustSaturation>
  <A TImageEnProc.AdjustTemperature>
  <A TImageEnProc.AdjustTint>
  <A TImageEnProc.ApplyFilterPreset>
  <A TImageEnProc.ApplyFilter>
  <A TImageEnProc.Blur>
  <A TImageEnProc.BumpMapping>
  <A TImageEnProc.CastColorRange>
  <A TImageEnProc.Closing>
  <A TImageEnProc.Colorize>
  <A TImageEnProc.Contrast2>
  <A TImageEnProc.Contrast3>
  <A TImageEnProc.Contrast>
  <A TImageEnProc.ConvertTo24Bit>
  <A TImageEnProc.ConvertToBW_FloydSteinberg>
  <A TImageEnProc.ConvertToBWLocalThreshold>
  <A TImageEnProc.ConvertToBWOrdered>
  <A TImageEnProc.ConvertToBWThreshold>
  <A TImageEnProc.ConvertToGray>
  <A TImageEnProc.ConvertToPalette>
  <A TImageEnProc.ConvertTo>
  <A TImageEnProc.Convolve>
  <A TImageEnProc.DisposeChannels>
  <A TImageEnProc.Deinterlace>
  <A TImageEnProc.EdgeDetect_ShenCastan>
  <A TImageEnProc.EdgeDetect_Sobel>
  <A TImageEnProc.FiltersInitialDir>
  <A TImageEnProc.GammaCorrect>
  <A TImageEnProc.HistEqualize>
  <A TImageEnProc.HSLvar>
  <A TImageEnProc.HSVvar>
  <A TImageEnProc.IntensityRGBall>
  <A TImageEnProc.Intensity>
  <A TImageEnProc.Lens>
  <A TImageEnProc.MapGrayToColor>
  <A TImageEnProc.Maximum>
  <A TImageEnProc.MedianFilter>
  <A TImageEnProc.MergeIEBitmap>
  <A TImageEnProc.Merge>
  <A TImageEnProc.MatchHSVRange>
  <A TImageEnProc.Minimum>
  <A TImageEnProc.MotionBlur>
  <A TImageEnProc.Negative>
  <A TImageEnProc.Opening>
  <A TImageEnProc.Random>
  <A TImageEnProc.RemoveRedEyes>
  <A TImageEnProc.Sharpen>
  <A TImageEnProc.Threshold>
  <A TImageEnProc.Threshold2>
  <A TImageEnProc.UnsharpMask>
  <A TImageEnProc.WallisFilter>
  <A TImageEnProc.Wave>
  <A TImageEnProc.WhiteBalance_coef>
  <A TImageEnProc.WhiteBalance_WhiteAt>

  <FI>Clipboard<FN>

  <A TImageEnProc.CopyToClipboard>
  <A TImageEnProc.IsClipboardAvailable>
  <A TImageEnProc.PasteFromClipboard>
  <A TImageEnProc.PointPasteFromClip>
  <A TImageEnProc.SelCopyToClip>
  <A TImageEnProc.SelCutToClip>
  <A TImageEnProc.SelPasteFromClipStretch>
  <A TImageEnProc.SelPasteFromClip>

  <FI>Steganographie<FN>

  <A TImageEnProc.ClearHiddenText>
  <A TImageEnProc.GetHiddenDataSpace>
  <A TImageEnProc.ReadHiddenData>
  <A TImageEnProc.ReadHiddenText>
  <A TImageEnProc.WriteHiddenData>
  <A TImageEnProc.WriteHiddenText>

  <FI>Encrypting<FN>

  <A TImageEnProc.Decrypt>
  <A TImageEnProc.Encrypt>

  <FI>Geometric<FN>

  <A TImageEnProc.AutoCrop>
  <A TImageEnProc.AutoCrop2>
  <A TImageEnProc.CropSel>
  <A TImageEnProc.Crop>
  <A TImageEnProc.Flip>
  <A TImageEnProc.ImageResize>
  <A TImageEnProc.MakeTile>
  <A TImageEnProc.PerspectiveDraw>
  <A TImageEnProc.ProjectDraw>
  <A TImageEnProc.RadialStretch>
  <A TImageEnProc.Reflection>
  <A TImageEnProc.Resample>
  <A TImageEnProc.ResampleTo>
  <A TImageEnProc.RotateAndCrop>
  <A TImageEnProc.Rotate>
  <A TImageEnProc.RoundImage>
  <A TImageEnProc.ShiftChannel>
  <A TImageEnProc.SkewDetectionFine>
  <A TImageEnProc.SkewDetection>

  <FI>Automatic Image Enhancement<FN>

  <A TImageEnProc.AdjustGainOffset>
  <A TImageEnProc.AutoImageEnhance1>
  <A TImageEnProc.AutoImageEnhance2>
  <A TImageEnProc.AutoImageEnhance3>
  <A TImageEnProc.AutoSharp>
  <A TImageEnProc.HistAutoEqualize>
  <A TImageEnProc.WhiteBalance_AutoWhite>
  <A TImageEnProc.WhiteBalance_GrayWorld>

  <FI>Undo<FN>

  <A TImageEnProc.AutoUndo>
  <A TImageEnProc.CanUndo>
  <A TImageEnProc.ClearAllUndo>
  <A TImageEnProc.ClearUndoAt>
  <A TImageEnProc.ClearUndo>
  <A TImageEnProc.SaveUndoCaptioned>
  <A TImageEnProc.SaveUndo>
  <A TImageEnProc.UndoAt>
  <A TImageEnProc.UndoCaptions>
  <A TImageEnProc.UndoCount>
  <A TImageEnProc.UndoLimit>
  <A TImageEnProc.UndoLocation>
  <A TImageEnProc.UndoPeekAt>
  <A TImageEnProc.UndoRect>
  <A TImageEnProc.Undo>

  <FI>Redo<FN>

  <A TImageEnProc.CanRedo>
  <A TImageEnProc.ClearAllRedo>
  <A TImageEnProc.ClearRedo>
  <A TImageEnProc.RedoAt>
  <A TImageEnProc.RedoCaptions>
  <A TImageEnProc.RedoCount>
  <A TImageEnProc.RedoPeekAt>
  <A TImageEnProc.Redo>
  <A TImageEnProc.SaveRedoCaptioned>
  <A TImageEnProc.SaveRedo>

  <FI>Others<FN>

  <A TImageEnProc.AutoConvertFormat>
  <A TImageEnProc.Background>
  <A TImageEnProc.Create>
  <A TImageEnProc.CreateFromBitmap>
  <A TImageEnProc.GetReSel>
  <A TImageEnProc.Update>


<FM>Events<FN>

  <A TImageEnProc.OnFinishWork>
  <A TImageEnProc.OnPreview>
  <A TImageEnProc.OnProgress>
  <A TImageEnProc.OnSaveUndo>
!!}
  TImageEnProc = class(TComponent)
  private
    { Private declarations }
    fAutoUndo: boolean;
    fImageEnView: TIEView; // refers to TIEView (fbitmap=fimageenview.bitmap)
    fImageEnViewBitmapChangeHandle:pointer; // bitmap change handle (nil=none)
    fBackground: TColor; // valid only if fImageEnview=nil
    fMsgLanguage: TMsgLanguage;
    fPreviewsParams: TPRPreviewsParams;
    fPreviewFont: TFont;
    fOnPreview: TIEPreviewEvent;
    fTImage: TImage; // riferimento a TImage
    fFiltersInitialDir: string;
    fIEBitmap: TIEBitmap; // encapsulates fBitmap if SetBitmap, SetAttachedBitmap, SetAttachedImageEn, SetTImage are called
    fIEBitmapCreated: boolean; // true is fIEBitmap is created by TImageEnIO
    {$ifdef IEINCLUDEDIALOGIP}
    fIPDialogParams:TIPDialogParams;
    fPreviewsLog:TStringList;
    {$endif}
    fAutoConvertFormat:boolean; // if true functions that call MakeConsistentBitmap will convert the pixelformat to the requested one
    procedure SetAttachedBitmap(atBitmap: TBitmap);
    procedure SetAttachedImageEn(atImageEn: TIEView);
    function GetReBackground: TColor;
    procedure SetReBackground(v: TColor);
    procedure SetPreviewFont(f: TFont);
    procedure SetTImage(v: TImage);
    procedure SetPRPreviewParams(v: TPRPreviewsParams);
    function GetPRPreviewParams: TPRPreviewsParams;
    procedure SetUndoCaptions(index: integer; const Value: string);
    procedure SetUndoLimit(v: integer);
  protected
    { Protected declarations }
    fUndoList: TList;   // list of undo objects
    fUndoSource: TList; // list of undo sources
    fUndoLocation: TIELocation;
    fUndoLimit: integer;
    fUndoCaptions: TStringList;
    fRedoList: TList;   // list of redo objects
    fRedoSource: TList; // list of redo sources
    fRedoCaptions: TStringList;
    fBitmap: TBitmap; // working bitmap (if fImageEnView is <>nil then fBitmap=FImageEnView.bitmap)
    fOnProgress: TIEProgressEvent;
    fOnFinishWork: TNotifyEvent;
    fOnSaveUndo: TIESaveUndoEvent;

    function GetCanUndo: boolean; virtual;
    function GetCanRedo: boolean; virtual;
    function GetUndoCount: integer; virtual;
    function GetRedoCount: integer; virtual;
    function GetRedoCaptions(index: integer): string; virtual;
    function GetUndoCaptions(index: integer): string; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OnBitmapChange(Sender: TObject; destroying: boolean);
    procedure SetIEBitmap(bmp: TIEBitmap);
    procedure SetAttachedIEBitmap(bmp: TIEBitmap);
    function MakeConsistentBitmap(allowedFormats: TIEPixelFormatSet): boolean;
    procedure DoFinishWork; virtual;
    function CheckFormat(allowedFormats: TIEPixelFormatSet):boolean;
    function GetDPIX:integer;
    function GetDPIY:integer;
  public
    { Public declarations }
    constructor Create(Owner: TComponent); overload; override;
    constructor CreateFromBitmap(Bitmap:TIEBitmap); overload;
    constructor CreateFromBitmap(Bitmap:TBitmap); overload;
    destructor Destroy; override;
    property AttachedBitmap: TBitmap read fBitmap write SetAttachedBitmap;
    property AttachedIEBitmap: TIEBitmap read fIEBitmap write SetAttachedIEBitmap;
    procedure Update;



{!!
<FS>TImageEnProc.FiltersInitialDir

<FM>Declaration<FC>
property FiltersInitialDir:string;

<FM>Description<FN>
FiltersInitialDir contains the initial directory in the previews dialog for the 'user filters' effect.
!!}
    property FiltersInitialDir: string read fFiltersInitialDir write fFiltersInitialDir;

    // Image processing
    function BeginImageProcessing(allowedFormats: TIEPixelFormatSet; var x1, y1, x2, y2: integer; const OpName: string; var ProcBitmap: TIEBitmap; var mask: TIEMask): boolean;
    procedure EndImageProcessing(ProcBitmap: TIEBitmap; mask: TIEMask);
    function BeginImageAnalysis(allowedFormats: TIEPixelFormatSet; var x1, y1, x2, y2: integer; var ProcBitmap: TIEBitmap; var mask: TIEMask): boolean;
    procedure EndImageAnalysis(ProcBitmap: TIEBitmap);
    procedure Negative;
    procedure HSLvar(oHue, oSat, oLum: integer);
    procedure HSVvar(oHue, oSat, oVal: integer);
    procedure IntensityRGBall(r, g, b: integer);
    procedure Intensity(LoLimit,HiLimit,Change:integer; UseAverageRGB:boolean; DoRed,DoGreen,DoBlue:boolean);
    procedure Contrast(vv: double=2);
    procedure ApplyFilter(filter: TGraphFilter);
    procedure ApplyFilterPreset(filter: TIEFilterPresets);
    procedure Convolve(Kernel:array of double; KernelWidth, KernelHeight:integer; Factor:double);
    procedure ConvertToGray;
    procedure CastColorRange(BeginColor, EndColor, CastColor: TRGB);
    function MatchHSVRange(HueBegin, HueEnd, SatBegin, SatEnd, ValBegin, ValEnd:integer; ColorizeMatched:boolean; MatchColor:TRGB; ColorizeNonMatched:boolean; NonMatchColor:TRGB):integer;
    procedure CastColor(x,y:integer; newColor:TRGB; tolerance:integer);
    procedure CastAlpha(x,y:integer; newAlpha:integer; tolerance:integer);
    procedure Flip(dir: TFlipDir);
    procedure RemoveRedEyes;
    procedure ConvertToBW_FloydSteinberg;
    procedure ConvertToBWLocalThreshold(WinSize:integer=4; Mode:TIEThreshMode=ietMean; Offset:integer=4);
    procedure ImageResize(newWidth, newHeight: integer; HorizAlign: TIEHAlign = iehLeft; VertAlign: TIEVAlign = ievTop; FillAlpha:integer=255);
    procedure Resample(NewWidth, NewHeight: integer; FilterType: TResampleFilter = rfNone);
    procedure Rotate(fangle: double; antialias: boolean = false; AntialiasMode: TIEAntialiasMode = ierFast; BackgroundColor: TColor = -1);
    procedure RotateAndCrop(Angle:double; antialias: boolean = true; AntialiasMode: TIEAntialiasMode = ierFast);
    procedure ConvertToBWThreshold(Threshold: integer = -1);
    procedure EdgeDetect_ShenCastan(Ratio: double = 0.99; Smooth: double = 0.9; WindowSize: integer = 7; ThinFactor: integer = 0; DoHysteresis: boolean = true);
    procedure EdgeDetect_Sobel;
    procedure RemoveIsolatedPixels(NoiseColor: integer = 1; PixelsCount: integer = 2);
    procedure RemoveNoise(Iterations: integer = 2; InvertImage: boolean = false);
    procedure PaintMark(Frequency: integer; Color: TRGB);
    procedure GammaCorrect(Gamma: double; Channel: TIEChannels = [iecRed, iecGreen, iecBlue]);
    procedure PaintPenMarker(x, y: integer; Width: integer = 20; Color: TColor = clYellow; BackgroundColor: TColor = clWhite; Tolerance: integer = 10);
    procedure ConvertToPalette(NumColors: integer; Palette: pointer; DitherMethod: TIEDitherMethod = ieOrdered);
    procedure ConvertTo(NumColors: integer; DitherMethod: TIEDitherMethod = ieOrdered);
{$IFDEF IEINCLUDEDIALOGIP}
    function DoPreviews(pe: TPreviewEffects = [peAll]; IsResizeable:boolean=true; FormWidth:integer=-1; FormHeight:integer=-1; FormLeft:integer=-1; FormTop:integer=-1): boolean;

{!!
<FS>TImageEnProc.IPDialogParams

<FM>Declaration<FC>
property IPDialogParams:<A TIPDialogParams>;

<FM>Description<FN>
This property contains <A TIPDialogParams> object which allows to get/set several parameters used to control Image Processing Dialog called by DoPreviews method.

<FM>Example<FC>

// preset brightness in CONTRAST tab
ImageEnView1.Proc.IPDialogParams.CONTRAST_Brightness:=20;
ImageEnView1.Proc.DoPreviews;

// make parameters persistent
if FileExists('previews.dat') then
  ImageEnView1.Proc.IPDialogParams.LoadFromFile('previews.dat');
If ImageEnView1.Proc.DoPreviews then
  ImageEnView1.Proc.IPDialogParams.SaveToFile('previews.dat');
!!}
    property IPDialogParams:TIPDialogParams read fIPDialogParams;

{!!
<FS>TImageEnProc.PreviewsLog

<FM>Declaration<FC>
property PreviewsLog:TStringList;

<FM>Description<FN>
Represents a log of operations executed inside preview dialog (<A TImageEnProc.DoPreviews>).

<FM>Example<FC>

ImageEnView1.Proc.DoPreviews;
Memo1.Lines.Assign( ImageEnView1.Proc.PreviewsLog );
!!}
    property PreviewsLog:TStringList read fPreviewsLog;

{$ENDIF}
    procedure AddSoftShadow(radius: double=4; OffSetX: integer=4; OffSetY: integer=4; AdaptSize: boolean = true; ShadowColor: TColor = clBlack; Intensity:integer=100);
    procedure AddInnerShadow(radius: double=4; OffSetX: integer=0; OffSetY: integer=0; ShadowColor: TColor = clBlack);
    procedure MedianFilter(WindowX: integer = 5; WindowY: integer = 5; Brightness: integer = 50; Contrast: integer = 50; Multiplier: integer = 1; Threshold: integer = 50; MedianOp: TIEMedFilType = mfMedianFilter);
    procedure WallisFilter(WinWidth: integer = 2; WinHeight: integer = 2; Mean: integer = 50; StDev: integer = 50; InGain: integer = 50; Edge: integer = 10; Limit: integer = 50; Thresholding: boolean = false);
    procedure Sharpen(Intensity: integer=10; Neighbourhood: integer = 4);
    procedure UnsharpMask(Radius:integer = 4; Amount:double = 1.0; Threshold:double = 0.05);
    procedure Clear;
    procedure ClearSel;
    procedure Merge(DBitmap: TBitmap; pcf: integer=50);
    procedure MergeIEBitmap(DBitmap: TIEBitmap; pcf: integer=50);
    procedure Threshold(DownLimit, UpLimit, DownVal, UpVal: TRGB);
    procedure Threshold2(LoThreshold,HiThreshold:integer; Red,Green,Blue:boolean);
    procedure HistEqualize(LoThresh, HiThresh: TRGB);
    procedure HistAutoEqualize;
    procedure CropSel(TransparencyOnly:boolean=false);
    procedure BumpMapping(LightX, LightY, LampX, LampY, pcf: integer; Color: TRGB);
    procedure Lens(cx, cy, Width, Height: integer; Refraction: double);
    procedure Wave(amplitude, wavelength, phase: integer; reflective: boolean);
    procedure ConvertToBWOrdered;
    procedure ConvertTo24Bit;
    function WriteHiddenText(text: AnsiString): integer;
    function WriteHiddenData(data: PAnsiChar; count: integer): integer;
    procedure Maximum(WindowSize: integer);
    procedure Minimum(WindowSize: integer);
    procedure Opening(WindowSize: integer);
    procedure Closing(WindowSize: integer);
    procedure Fill(FillColor: TRGB); overload;
    procedure Fill(FillColor: TColor); overload;
    procedure Blur(radius: double);
    procedure MotionBlur(angle:double; radius:integer=8; sigma:integer=7);
    procedure Random(mean:double=0.5; stdDev:double=0.123);
    procedure SetTransparentColors(MinColor, MaxColor: TRGB; Alpha: integer=0);
    procedure ResampleTo(Target: TIEBitmap; TargetWidth, TargetHeight: integer; FilterType: TResampleFilter);
    procedure RoundImage(RoundWidth,RoundHeight:integer);
    procedure RadialStretch(ARed,BRed,CRed,DRed, AGreen,BGreen,CGreen,DGreen, ABlue,BBlue,CBlue,DBlue:double);
    procedure Crop(x1,y1,x2,y2:integer); overload;
    procedure Crop(Rect:TRect); overload;
    procedure CutTransparentBorder;
    function AutoCrop(Tolerance:integer; Background:TRGB; DoCrop:boolean=true):TRect; overload;
    function AutoCrop(Tolerance:integer; Background:TColor; DoCrop:boolean=true):TRect; overload;
    function AutoCrop2(BorderRate:double=6; DoCrop:boolean=true):TRect;
    procedure MakeTile(columns:integer=2; rows:integer=2);
    procedure ShiftChannel(offsetX, offsetY:integer; channel:integer; fillValue:integer);
    procedure DisposeChannels(newDispo:string);
    procedure Deinterlace(mode:TIEDeinterlaceMode);
    procedure Encrypt(Passkey:array of byte); overload;
    procedure Encrypt(Passkey:AnsiString); overload;
    procedure Decrypt(Passkey:array of byte); overload;
    procedure Decrypt(Passkey:AnsiString); overload;
    procedure Reflection(minAlpha:integer=0; maxAlpha:integer=200; percentage:integer=100);
    procedure PerspectiveDraw(Source:TIEBitmap; x0, y0, x1, y1, x2, y2, x3, y3:integer; alphaMin:integer=-1; alphaMax:integer=-1);
    function ProjectDraw(Source:TIEBitmap; centerDestX:integer; centerDestY:integer; destWidth:integer; destHeight:integer;
                         depth:double; translateX:integer; translateY:integer; rotateX:double; rotateY:double;
                         specularAlphaMin:integer=-1; specularAlphaMax:integer=-1):TIEQuadCoords; overload;
    function ProjectDraw(Source:TIEBitmap; centerDestX:integer; centerDestY:integer; scale:double; depth:double;
                         translateX:integer; translateY:integer; rotateX:double; rotateY:double;
                         specularAlphaMin:integer=-1; specularAlphaMax:integer=-1):TIEQuadCoords; overload;
    procedure MapGrayToColor(map:array of TRGB);
    // Image adjust
    procedure WhiteBalance_coef(Red,Green,Blue:double);
    procedure WhiteBalance_GrayWorld;
    procedure WhiteBalance_WhiteAt(WhiteX,WhiteY:integer);
    procedure WhiteBalance_AutoWhite;
    procedure AdjustGainOffset;
    procedure AutoImageEnhance1(SubsampledSize:integer=60; Slope:integer=20; Cut:integer=25; Neightbour:integer=2);
    procedure AutoImageEnhance2(ScaleCount:integer=3;ScaleCurve:integer=2; Variance:double=1.8; ScaleHigh:integer=200; Luminance:boolean=true);
    procedure AutoImageEnhance3(Gamma:double=0.35; Saturation:integer=80);
    procedure AutoSharp(Intensity:integer=68; rate:double=0.035);
    procedure Colorize(hue:integer; saturation:integer; luminosity:double);
    procedure AdjustBrightnessContrastSaturation(Brightness, Contrast, Saturation:integer);
    procedure Contrast2(Amount:double);
    procedure AdjustSaturation(Amount:integer);
    procedure AdjustTemperature(temperature:integer);
    procedure AdjustTint(Amount:integer);
    procedure AdjustLumSatHistogram(Saturation, Luminance:double);
    procedure Contrast3(Change, Midpoint:integer; DoRed,DoGreen,DoBlue:boolean);
    // Image analysis
    function CalcOrientation: integer;
    procedure GetHistogram(Hist: pointer);
    procedure CalcImagePalette(var Palette: array of TRGB; MaxCol: integer=256);
    function CalcImageNumColors: integer;
    function GetHSVChannel(ch: integer): TIEBitmap;
    procedure GetHSVChannelAll(BitmapH, BitmapS, BitmapV: TIEBitmap);
    function GetRGBChannel(ch: integer): TIEBitmap;
    procedure GetRGBChannelAll(BitmapR, BitmapG, BitmapB: TIEBitmap);
    function ReadHiddenText: AnsiString;
    function ReadHiddenData(data: PAnsiChar; maxlen: integer): integer;
    function GetHiddenDataSpace: integer;
    procedure ClearHiddenText;
    {$ifdef IEINCLUDEFFT}
    function FTCreateImage(ImageType: TIEFtImageType; NewWidth:integer=-1; NewHeight: integer=-1): TIEFtImage;
    procedure FTConvertFrom(ft: TIEftImage);
    procedure FTDisplayFrom(ft: TIEftImage);
    procedure FTClearZone(tx1, ty1, tx2, ty2:integer; GrayScale:boolean);
    {$endif}
    function SkewDetection(ResampleWidth: integer = 0; AngleRange: integer = 30; Precision: double = 0.1; EdgeDetect: boolean = false): double;
    function SkewDetectionFine(StartingAngle: double=0; resolution: double=0.1; range: integer=10; maxQuality: boolean=true): double;
    procedure CalcDensityHistogram(VertHist, HorizHist: pointer; norm_vert, norm_horiz: integer);
    function ComputeImageEquality(SecondImage: TIEBitmap; var psnr_min, psnr_max: double; var mse_min, mse_max: double; var rmse_min, rmse_max: double; var pae_min, pae_max: double; var mae_min, mae_max: double): boolean;
    function CompareWith(SecondImage: TIEBitmap; DiffBitmap: TIEBitmap): double;
    function CompareHistogramWith(SecondImage: TIEBitmap; Mode:TIECmpMode; GrayScale:boolean):double;
    function GetDominantColor(var Color: TRGB): double;
    function SeparateObjects(Quality:integer=4; MergeCommonAreas:boolean=true):TList; overload;
    function SeparateObjects(Quality:integer; MergeCommonAreas:boolean; BackgroundColorBegin, BackgroundColorEnd:TRGB):TList; overload;
    function CalcAverageRGB():TRGB;
    // Undo
    procedure SaveUndo(Source: TIEUndoSource = ieuImage); virtual;
    procedure SaveUndoCaptioned(const Caption: string; Source: TIEUndoSource = ieuImage); virtual;
    procedure ClearUndo; virtual;
    procedure ClearUndoAt(Position: integer);
    procedure ClearAllUndo; virtual;
    procedure Undo(AutoRedo:boolean=false); virtual;
    procedure UndoRect(x1,y1,x2,y2:integer);
    procedure UndoAt(Position: integer; AutoRedo:boolean=false); virtual;
    property CanUndo: boolean read GetCanUndo;
    property CanRedo: boolean read GetCanRedo;

{!!
<FS>TImageEnProc.UndoLocation

<FM>Declaration<FC>
property UndoLocation:<A TIELocation>;

<FM>Description<FN>
UndoLocation specifies where ImageEn saves 'Undo' images.

Default is ieFile.
!!}
    property UndoLocation: TIELocation read fUndoLocation write fUndoLocation;

    property UndoCount: integer read GetUndoCount;
    property UndoCaptions[index: integer]: string read GetUndoCaptions write SetUndoCaptions;
    function UndoPeekAt(Position: integer): TIEUndoSource;
    // Redo
    procedure SaveRedo(Source: TIEUndoSource = ieuImage); virtual;
    procedure SaveRedoCaptioned(const Caption: string; Source: TIEUndoSource = ieuImage); virtual;
    property RedoCaptions[index: integer]: string read GetRedoCaptions;
    property RedoCount: integer read GetRedoCount;
    procedure ClearAllRedo; virtual;
    procedure ClearRedo; virtual;
    procedure Redo; virtual;
    procedure RedoAt(Position: integer); virtual;
    function RedoPeekAt(Position: integer): TIEUndoSource;
    // copy/cut and paste
    function CopyToClipboard(UseInternalFormat:boolean=true):boolean;
    function SelCopyToClip(UseInternalFormat:boolean=true):boolean;
    function SelCutToClip(UseInternalFormat:boolean=true):boolean;
    procedure SelPasteFromClipStretch(MergeAlpha:boolean=true);
    procedure SelPasteFromClip(MergeAlpha:boolean=true);
    procedure PointPasteFromClip(x1, y1: integer; MergeAlpha:boolean=true);
    procedure PasteFromClipboard;
    function IsClipboardAvailable:boolean;
    // selection area
    function GetReSel(var fsX1, fsY1, fsX2, fsY2: integer; var PolySel: PPointArray; var PolySelCount: integer; var mask: TIEMask): boolean; dynamic;
  published
    { Published declarations }
    property AttachedImageEn: TIEView read fImageEnView write SetAttachedImageEn;

{!!
<FS>TImageEnProc.AutoUndo

<FM>Declaration<FC>
property AutoUndo: boolean;

<FM>Description<FN>
If AutoUndo isTrue, all image processing and load operations automatically call the SaveUndo method.

<FM>Example<FC>

this code:

ImageEnView1.Proc.AutoUndo:=true;
ImageEnView1.Proc.Negative;
ImageEnView1.Proc.ConvertToGray;

is equivalent to:

ImageEnView1.Proc.AutoUndo:=false;
ImageEnView1.Proc.SaveUndo;
ImageEnView1.Proc.Negative;
ImageEnView1.Proc.SaveUndo;
ImageEnView1.Proc.ConvertToGray;
!!}
    property AutoUndo: boolean read fAutoUndo write fAutoUndo default true;

    property Background: TColor read GetReBackground write SetReBackground default clBlack;

{!!
<FS>TImageEnProc.OnProgress

<FM>Declaration<FC>
property OnProgress: <A TIEProgressEvent>;

<FM>Description<FN>
The OnProgress event is called when image processing operations are executed.
!!}
    property OnProgress: TIEProgressEvent read fOnProgress write fOnProgress;

{!!
<FS>TImageEnProc.MsgLanguage

<FM>Declaration<FC>
property MsgLanguage: <A TMsgLanguage>;

<FM>Description<FN>
This property sets the language for the image processing previews dialog (Previews).

<FM>Example<FC>

ImageEnView1.Proc.MsgLanguage:=msEnglish;  // This is the default
!!}
    property MsgLanguage: TMsgLanguage read fMsgLanguage write fMsgLanguage default msSystem;

    property PreviewsParams: TPRPreviewsParams read GetPRPreviewParams write SetPRPreviewParams default [];
    property PreviewFont: TFont read fPreviewFont write SetPreviewFont;
    property AttachedTImage: TImage read fTImage write SetTImage;

{!!
<FS>TImageEnProc.OnPreview

<FM>Declaration<FC>
property OnPreview:<A TIEPreviewEvent>;

<FM>Description<FN>
The OnPreview event is called before the preview form is displayed (running DoPreviews method).

<FM>Example<FC>

procedure TForm1.ImageEnProc1Preview(Sender: TObject; PreviewForm:TForm);
begin
  with (PreviewForm as TfPreviews) do begin
    PageControl1.MultiLine:=True;
  end;
end;
!!}
    property OnPreview: TIEPreviewEvent read fOnPreview write fOnPreview;

    property UndoLimit: integer read fUndoLimit write SetUndoLimit default 1;

{!!
<FS>TImageEnProc.OnFinishWork

<FM>Declaration<FC>
property OnFinishWork: TNotifyEvent;

<FM>Description<FN>
This event occurs whenever an image processing task terminates. This event is called after the last call to OnProgress, so you can reset here your progress bar.
!!}
    property OnFinishWork: TNotifyEvent read fOnFinishWork write fOnFinishWork;

{!!
<FS>TImageEnProc.AutoConvertFormat

<FM>Declaration<FC>
property AutoConvertFormat:boolean;

<FM>Description<FN>
When true (default) all image processing functions converts automatically the source pixel format to the request one. For example, Contrast method requires RGB24 pixel format. If your image is black/white or any other format, it is converted automatically to RGB24.
If you set AutoConvertFormat=False and call Contrast with a black/white image, Contrast just will don't work.
!!}
    property AutoConvertFormat:boolean read fAutoConvertFormat write fAutoConvertFormat default true;

{!!
<FS>TImageEnProc.OnSaveUndo

<FM>Declaration<FC>
property OnSaveUndo: <A TIESaveUndoEvent>;

<FM>Description<FN>
OnSaveUndo is called after SaveUndo is called by user action or by code. source is the same parameter used calling SaveUndo.
!!}
    property OnSaveUndo: TIESaveUndoEvent read fOnSaveUndo write fOnSaveUndo;

  end;

{!!
<FS>TIETransitionType

<FM>Declaration<FC>
}
  TIETransitionType = (iettNone,
                       iettCrossDissolve,                   // Cross Fade
                       iettFadeOut,                         // Fade Out
                       iettFadeIn,                          // Fade In
                       iettFadeOutIn,                       // Fade Out then In
                       iettLeftRight1,                      // Wipe Left to Right
                       iettLeftRight2,                      // Wipe Left to Right 2
                       iettRightLeft1,                      // Wipe Right to Left
                       iettRightLeft2,                      // Wipe Right to Left 2
                       iettUpDown1,                         // Wipe Top to Bottom
                       iettUpDown2,                         // Wipe Top to Bottom 2
                       iettDownUp1,                         // Wipe Bottom to Top
                       iettDownUp2,                         // Wipe Bottom to Top 2
                       iettFromUpLeft,                      // Slide from Top Left
                       iettFromUpRight,                     // Slide from Top Right
                       iettFromBottomLeft,                  // Slide from Bottom Left
                       iettFromBottomRight,                 // Slide from Bottom Right
                       iettMoveLeftRight1,                  // Push Left to Right
                       iettMoveLeftRight2,                  // Slide Out Left to Right
                       iettMoveRightLeft1,                  // Push Right to Left
                       iettMoveRightLeft2,                  // Slide Out Right to Left
                       iettMoveUpDown1,                     // Push Top to Bottom
                       iettMoveUpDown2,                     // Slide Out Top to Bottom
                       iettMoveDownUp1,                     // Push Bottom to Top
                       iettMoveDownUp2,                     // Slide Out Bottom to Top
                       iettRandomPoints,                    // Random Points
                       iettRandomBoxes,                     // Random Boxes
                       iettCenter1,                         // Wipe Out from Center
                       iettCenter2,                         // Wipe In to Center
                       iettCenterZoom1,                     // Expand Out from Center
                       iettCenterZoom2                      // Expand In to Center

                       {$ifdef IEINCLUDEEXTRATRANSITIONS}
                       ,iettExpandFromLeft,                        // Expand from Left
                       iettExpandFromRight,                        // Expand from Right
                       iettExpandFromTop,                          // Expand from Top
                       iettExpandFromBottom,                       // Expand from Bottom
                       iettExpandFromTopLeft,                      // Expand from Top Left
                       iettExpandFromTopRight,                     // Expand from Top Right
                       iettExpandFromBottomLeft,                   // Expand from Bottom Left
                       iettExpandFromBottomRight,                  // Expand from Bottom Right
                       iettExpandInFromLeft,                       // Expand in from Left
                       iettExpandInFromRight,                      // Expand in from Right
                       iettExpandInFromTop,                        // Expand in from Top
                       iettExpandInFromBottom,                     // Expand in from Bottom
                       iettExpandInToVerticalCenter,               // Expand in to Vertical Center
                       iettExpandInToHorizon,                      // Expand in to Horizon
                       iettExpandInFromSides,                      // Expand in from Sides
                       iettExpandInFromTopAndBottom,               // Expand in from Top and Bottom
                       iettExpandOutFromHorizon,                   // Expand out from Horizon
                       iettExpandOutFromVerticalCenter,            // Expand out from Vertical Center
                       iettWipeFromTopLeft,                        // Wipe from Top Left
                       iettWipeFromTopRight,                       // Wipe from Top Right
                       iettWipeFromBottomLeft,                     // Wipe from Bottom Left
                       iettWipeFromBottomRight,                    // Wipe from Bottom Right
                       iettWipeInFromTopAndBottom,                 // Wipe in from Top and Bottom
                       iettWipeFromHorizon,                        // Wipe from Horizon
                       iettWipeInFromSides,                        // Wipe in from Sides
                       iettWipeOutFromVerticalCenter,              // Wipe out from Vertical Center
                       iettBuildUpFromLeft,                        // Build up from Left
                       iettBuildUpFromRight,                       // Build up from Right
                       iettBuildUpFromTop,                         // Build up from Top
                       iettBuildUpFromBottom,                      // Build up from Bottom
                       iettUnrollFromLeft,                         // Unroll from Left
                       iettUnrollFromRight,                        // Unroll from Right
                       iettUnrollFromTop,                          // Unroll from Top
                       iettUnrollFromBottom,                       // Unroll from Bottom
                       iettSlideInFromLeft,                        // Slide in from Left
                       iettSlideInFromRight,                       // Slide in from Right
                       iettSlideInFromTop,                         // Slide in from Top
                       iettSlideInFromBottom,                      // Slide in from Bottom
                       iettShrinkToTopLeft,                        // Shrink to Top Left
                       iettShrinkToTopRight,                       // Shrink to Top Right
                       iettShrinkToBottomLeft,                     // Shrink to Bottom Left
                       iettShrinkToBottomRight,                    // Shrink to Bottom Right
                       iettShrinkToCenter,                         // Shrink to Center
                       iettQuartersWipeInToCenter,                 // Quarters Wipe in to Center
                       iettQuartersExpandToCenter,                 // Quarters Expand to Center
                       iettQuartersSlideInToCenter,                // Quarters Slide in to Center
                       iettCurvedWipeFromLeft,                     // Curved Wipe from Left
                       iettCurvedWipeFromRight,                    // Curved Wipe from Right
                       iettCurvedWipeFromTop,                      // Curved Wipe from Top
                       iettCurvedWipeFromBottom,                   // Curved Wipe from Bottom
                       iettCurvedWipeFromTopLeft,                  // Curved Wipe from Top Left
                       iettCurvedWipeFromTopRight,                 // Curved Wipe from Top Right
                       iettCurvedWipeFromBottomLeft,               // Curved Wipe from Bottom Left
                       iettCurvedWipeFromBottomRight,              // Curved Wipe from Bottom Right
                       iettBarsInFromLeft,                         // Bars in from Left
                       iettBarsInFromRight,                        // Bars in from Right
                       iettBarsFromTop,                            // Bars from Top
                       iettBarsFromBottom,                         // Bars from Bottom
                       iettBarsLeftThenRight,                      // Bars Left then Right
                       iettBarsRightThenLeft,                      // Bars Right then Left
                       iettBarsTopThenBottom,                      // Bars Top then Bottom
                       iettBarsBottomThenTop,                      // Bars Bottom then Top
                       iettBarsFrombothSides,                      // Bars from both Sides
                       iettBarsFromTopAndBottom,                   // Bars from Top and Bottom
                       iettShreddedFromLeft,                       // Shredded from Left
                       iettShreddedFromRight,                      // Shredded from Right
                       iettShreddedFromTop,                        // Shredded from Top
                       iettShreddedFromBottom,                     // Shredded from Bottom
                       iettShreddedFromTopAndLeft,                 // Shredded from Top and Left
                       iettShreddedFromTopAndRight,                // Shredded from Top and Right
                       iettShreddedFromBottomAndLeft,              // Shredded from Bottom and Left
                       iettShreddedFromBottomAndRight,             // Shredded from Bottom and Right
                       iettShreddedFromHorizonAndLeft,             // Shredded from Horizon and Left
                       iettShreddedFromHorizonAndRight,            // Shredded from Horizon and Right
                       iettShreddedFromTopAndVerticalCenter,       // Shredded from Top and Vertical Center
                       iettShreddedFromBottomAndVerticalCenter,    // Shredded from Bottom and Vertical Center
                       iettShreddedFromCenter,                     // Shredded from Center
                       iettShreddedToCenter,                       // Shredded to Center
                       iettShreddedInToHorizon,                    // Shredded in to Horizon
                       iettShreddedInToVerticalCenter,             // Shredded in to Vertical Center
                       iettShreddedOutFromHorizon,                 // Shredded out from Horizon
                       iettShreddedOutFromVerticalCenter,          // Shredded out from Vertical Center
                       iettExpandingRectangles,                    // Expanding Rectangles
                       iettExpandingTriangles,                     // Expanding Triangles
                       iettExpandingCircles,                       // Expanding Circles
                       iettExpandingDiamonds,                      // Expanding Diamonds
                       iettCircularWipeFromCenter,                 // Circular Wipe from Center
                       iettCircularWipeToCenter,                   // Circular Wipe to Center
                       iettCrisscrossWipeFromTopLeft,              // Crisscross Wipe from Top Left
                       iettCrisscrossWipeFromTopRight,             // Crisscross Wipe from Top Right
                       iettCrisscrossWipeFromBottomLeft,           // Crisscross Wipe from Bottom Left
                       iettCrisscrossWipeFromBottomRight,          // Crisscross Wipe from Bottom Right
                       iettCrisscrossWipeBounceFromTopLeft,        // Crisscross Wipe Bounce from Top Left
                       iettCrisscrossWipeBounceFromTopRight,       // Crisscross Wipe Bounce from Top Right
                       iettCrisscrossWipeBounceFromBottomLeft,     // Crisscross Wipe Bounce from Bottom Left
                       iettCrisscrossWipeBounceFromBottomRight,    // Crisscross Wipe Bounce from Bottom Right
                       iettCrisscrossWipeFromLeftRightAndTop,      // Crisscross Wipe from Left Right and Top
                       iettCrisscrossWipeFromLeftRightAndBottom,   // Crisscross Wipe from Left Right and Bottom
                       iettCrisscrossWipeFromLeftTopAndBottom,     // Crisscross Wipe from Left Top and Bottom
                       iettCrisscrossWipeFromTopLeftRightAndBottom,// Crisscross Wipe from Top Left Right and Bottom
                       iettCrisscrossWipeFromRightTopAndBottom,    // Crisscross Wipe from Right Top and Bottom
                       iettCrisscrossWipeFromBottomLeftTopRight,   // Crisscross Wipe from Bottom Left Top Right
                       iettWipeDiagonalFromTopLeft,                // Wipe diagonal from Top Left
                       iettWipeDiagonalFromTopRight,               // Wipe diagonal from Top Right
                       iettWipeDiagonalFromBottomLeft,             // Wipe diagonal from Bottom Left
                       iettWipeDiagonalFromBottomRight,            // Wipe diagonal from Bottom Right
                       iettDiagonalSweepClockwise,                 // Diagonal Sweep Clockwise
                       iettDiagonalSweepCounterClockwise,          // Diagonal Sweep Counter-Clockwise
                       iettSweepClockwise,                         // Sweep Clockwise
                       iettSweepCounterClockwise,                  // Sweep Counter-Clockwise
                       iettStarburstClockwiseFromCenter,           // Starburst Clockwise from Center
                       iettStarburstCounterClockwiseFromCenter,    // Starburst Clockwise from Center
                       iettRotationalRectangle,                    // Rotational Rectangle - Clockwise
                       iettRotationalRectangleCounterClockwise,    // Rotational Rectangle - Counter Clockwise
                       iettRotationalStar,                         // Rotational Star - Clockwise
                       iettRotationalStarCounterClockwise,         // Rotational Star - Counter Clockwise
                       iettSpeckledWipeFromLeft,                   // Speckled Wipe from Left
                       iettSpeckledWipeFromRight,                  // Speckled Wipe from Right
                       iettSpeckledWipeFromTop,                    // Speckled Wipe from Top
                       iettSpeckledWipeFromBottom,                 // Speckled Wipe from Bottom
                       iettPushLeftAndSlideOut,                    // Push Left and Slide out
                       iettPushRightAndSlideOut,                   // Push Right and Slide out
                       iettPushUpAndSlideOut,                      // Push up and Slide out
                       iettPushDownAndSlideOut,                    // Push down and Slide out
                       iettPushAndSqueezeLeft,                     // Push and Squeeze Left
                       iettPushAndSqueezeRight,                    // Push and Squeeze Right
                       iettPushAndSqueezeUp,                       // Push and Squeeze up
                       iettPushAndSqueezeDown,                     // Push and Squeeze down
                       iettHorizontalBlinds,                       // Horizontal Blinds
                       iettVerticalBlinds,                         // Vertical Blinds
                       iettUnevenBlindsFromLeft,                   // Uneven Blinds from Left
                       iettUnevenBlindsFromRight,                  // Uneven Blinds from Right
                       iettUnevenBlindsFromTop,                    // Uneven Blinds from Top
                       iettUnevenBlindsFromBottom,                 // Uneven Blinds from Bottom
                       iettRectanglesFromTheLeft,                  // Rectangles from the Left
                       iettRectanglesFromTheRight,                 // Rectangles from the Right
                       iettRectanglesFromTheTop,                   // Rectangles from the Top
                       iettRectanglesFromTheBottom,                // Rectangles from the Bottom
                       iettSpirallingRectangleClockwise,           // Spiralling Rectangle Clockwise
                       iettSpirallingRectangleCounterClockwise,    // Spiralling Rectangle Counter-Clockwise
                       iettArrowWipeFromLeft,                      // Arrow Wipe from Left
                       iettArrowWipeFromRight,                     // Arrow Wipe from Right
                       iettArrowWipeFromTop,                       // Arrow Wipe from Top
                       iettArrowWipeFromBottom,                    // Arrow Wipe from Bottom
                       iettHorizontalBowTieWipe,                   // Horizontal Bow Tie Wipe
                       iettVerticalBowTieWipe,                     // Vertical Bow Tie Wipe
                       iettDiagonalCrossFromCenter,                // Diagonal Cross from Center
                       iettDiagonalCrossToCenter,                  // Diagonal Cross to Center
                       iettZigzagWipeFromHorizon,                  // Zigzag Wipe from Horizon
                       iettZigzagWipeFromVerticalCenter,           // Zigzag Wipe from Vertical Center
                       iettDiamondWipeFromCenter,                  // Diamond Wipe from Center
                       iettDiamondWipeToCenter,                    // Diamond Wipe to Center
                       iettDiagonalBoxWipe,                        // Diagonal Box Wipe
                       iettTriangularWipeEffect,                   // Triangular Wipe
                       iettRandomBigBoxesEffect,                   // Random Big Boxes
                       iettPageFlipEffect,                         // Page Flip
                       iettPageFlipEffect2,                        // Page Flip 2
                       iettZigzagWipeToHorizon,                    // Zigzag Wipe To Horizon
                       iettZigzagWipeToVerticalCenter,             // Zigzag Wipe To Vertical Center
                       iettRandomHearts,                           // Random Hearts
                       iettRandomStar5s,                           // Random 5 Pointed Stars
                       iettRandomStar6s,                           // Random 6 Pointed Stars
                       iettRandomExplosions,                       // Random Explosions
                       iettExpandingHearts,                        // Expanding Hearts
                       iettExpandingStar5,                         // Expanding 5 Pointed Stars
                       iettExpandingStar6,                         // Expanding 6 Pointed Stars
                       iettExpandingExplosions,                    // Expanding Explosions
                       iettExpandingLightningBolts,                // Expanding Lightning Bolts
                       iettHeartWipeOut,                           // Heart Wipe from Center
                       iettHeartWipeIn,                            // Heart Wipe to Center
                       iettStar5WipeOut,                           // 5 Pointed Star Wipe from Center
                       iettStar5WipeIn,                            // 5 Pointed Star Wipe to Center
                       iettStar6WipeOut,                           // 6 Pointed Star Wipe from Center
                       iettStar6WipeIn,                            // 6 Pointed Star Wipe to Center
                       iettExplosionWipeOut,                       // Explosion Wipe from Center
                       iettExplosionWipeIn,                        // Explosion Wipe to Center
                       iettCrossWipeOut,                           // Cross Wipe from Center
                       iettCrossWipeIn,                            // Cross Wipe to Center
                       iettHeartWipeInAndOut,                      // Heart Wipe In and Out
                       iettStar5WipeInAndOut,                      // 5 Pointed Star Wipe In and Out
                       iettStar6WipeInAndOut,                      // 6 Pointed Star Wipe In and Out
                       iettExplosionWipeInAndOut                   // Explosion Wipe In and Out
                       {$endif}

                       ,iettPanZoom
                       );
{!!}

{!!
<FS>TIETransitionTiming

<FM>Declaration<FC>
}
  TIETransitionTiming=(iettLinear, iettExponential, iettLogarithmic);
{!!}

{!!
<FS>TIETransitionStepEvent

<FM>Declaration<FC>
}
  TIETransitionStepEvent=procedure(Sender:TObject; step:integer) of object;
{!!}

  TIETransitionEffects = class;

{!!
<FS>TIEOnTransitionPaint

<FM>Declaration<FC>
}
  TIEOnTransitionPaint = procedure(Sender: TObject; Bitmap: TBitmap; Transition: TIETransitionEffects; Step: Integer) of object;
{!!}

  // transition effects class
  TIETransitionEffects = class
  private
    fSourceShot, fTargetShot, fCurrentView: TBitmap;
    fFullImage:TIEBitmap;
    fSourceShotLines, fTargetShotLines, fCurrentViewLines: PPointerArray;
    fWidth, fHeight: integer;
    fRunning: boolean;
    fOwner: TIEView;
    fTimer: TTimer;
    fStep: integer;
    fAccum1: integer;
    fTransition: TIETransitionType;
    fDuration: integer; // time in millisecs
    fStartTick: dword;
    fUpdateOnStop: boolean;
    fStartRect:TRect;
    fEndRect:TRect;
    fOnTransitionStop:TNotifyEvent;
    fOnTransitionStep:TIETransitionStepEvent;
    fTiming:TIETransitionTiming;
    fOnTransitionPaint: TIEOnTransitionPaint;
    procedure SetOnTransitionPaint(const Value: TIEOnTransitionPaint);
  protected
    fFrames: integer; // debug counter
    procedure TimerEvent(Sender: TObject);
    //
    procedure CrossDissolve(Step: integer);
    procedure FadeOut(Step: integer);
    procedure FadeIn(Step: integer);
    procedure FadeOutIn(Step: integer);
    procedure LeftRight1(Step: integer);
    procedure LeftRight2(Step: integer);
    procedure RightLeft1(Step: integer);
    procedure RightLeft2(Step: integer);
    procedure UpDown1(Step: integer);
    procedure UpDown2(Step: integer);
    procedure DownUp1(Step: integer);
    procedure DownUp2(Step: integer);
    procedure MoveLeftRight1(Step: integer);
    procedure MoveLeftRight2(Step: integer);
    procedure MoveRightLeft1(Step: integer);
    procedure MoveRightLeft2(Step: integer);
    procedure MoveUpDown1(Step: integer);
    procedure MoveUpDown2(Step: integer);
    procedure MoveDownUp1(Step: integer);
    procedure MoveDownUp2(Step: integer);
    procedure RandomPoints(Step: integer);
    procedure FromUpLeft(Step: integer);
    procedure FromUpRight(Step: integer);
    procedure FromBottomLeft(Step: integer);
    procedure FromBottomRight(Step: integer);
    procedure RandomBoxes(Step: integer);
    procedure Center1(Step: integer);
    procedure Center2(Step: integer);
    procedure CenterZoom1(Step: integer);
    procedure CenterZoom2(Step: integer);
    procedure PanZoom(Step: integer);
  public
    constructor Create(Owner: TIEView);
    destructor Destroy; override;
    property SourceShot: TBitmap read fSourceShot;
    property TargetShot: TBitmap read fTargetShot;
    property Running: boolean read fRunning;
    procedure Run(UpdateOnStop: boolean);
    procedure Stop;
    property Transition: TIETransitionType read fTransition write fTransition;
    procedure SetSizes(Width, Height: integer);
    property Duration: integer read fDuration write fDuration;
    procedure PrepareBitmap(OriginalBitmap,TargetBitmap:TBitmap);
    procedure CreateBitmapFrame(iStep:Integer; { a value out of 100} ToBitmap:TBitmap {the bimtap to write it to} );
    property FullImage:TIEBitmap read fFullImage write fFullImage;
    property StartRect:TRect read fStartRect write fStartRect;
    property EndRect:TRect read fEndRect write fEndRect;
    property OnTransitionStop:TNotifyEvent read fOnTransitionStop write fOnTransitionStop;
    property OnTransitionStep:TIETransitionStepEvent read fOnTransitionStep write fOnTransitionStep;
    property OnTransitionPaint: TIEOnTransitionPaint read fOnTransitionPaint write SetOnTransitionPaint;
    property Timing:TIETransitionTiming read fTiming write fTiming;
  end;

const

{!!
<FS>ppeColorAdjust

<FM>Declaration<FC>
}
  ppeColorAdjust = [peContrast, peHSV, peHSL, peRGB, peEqualize, peFFT, peGamma, peSharpen];
{!!}

{!!
<FS>ppeEffects

<FM>Declaration<FC>
}
  ppeEffects = [peUserFilt, peBumpMap, peLens, peWave, peMorph, peRotate];
{!!}

  // Filter presets
  fpNone=0;                                                       
  fpBlur=1;
  fpEdge=2;
  fpEmboss=3;
  fpHighPass1=4;
  fpHighPass2=5;
  fpHighPass3=6;
  fpLowPass1=7;
  fpLowPass2=8;

  BWORDERPATTERN: array[0..7, 0..7] of integer = (
    (0, 32, 8, 40, 2, 34, 10, 42),
    (48, 16, 56, 24, 50, 18, 58, 26),
    (12, 44, 4, 36, 14, 46, 6, 38),
    (60, 28, 52, 20, 62, 30, 54, 22),
    (3, 35, 11, 43, 1, 33, 9, 41),
    (51, 19, 59, 27, 49, 17, 57, 25),
    (15, 47, 7, 39, 13, 45, 5, 37),
    (63, 31, 55, 23, 61, 29, 53, 21));

  IERAWCLIPFORMAT_NAME: AnsiString = 'IMAGEEN RAW FORMAT';


procedure IEInitialize_imageenproc;
procedure IEFinalize_imageenproc;

procedure _GetMediaContrastRGB(bitmap: TIEBitmap; var mR, mG, mB: integer);
procedure _HSLvar(bitmap: TIEBitmap; oHue, oSat, oLum: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _HSVvar(bitmap: TIEBitmap; oHue, oSat, oVal: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IntensityRGBall(bitmap: TIEBitmap; r, g, b: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _ContrastRGB(bitmap: TIEBitmap; vv: double; mR, mG, mB: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _ApplyFilter(bitmap: TIEBitmap; filter: TGraphFilter; fSelx1, fSely1, fSelx2, fSely2: integer; var Progress: TProgressRec);
procedure _CastColorRange(bitmap: TIEBitmap; BeginColor, EndColor, CastColor: TRGB; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _Rot90oEx(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
procedure _Rot90oEx8(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
procedure _Rot90Ex(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
procedure _Rot90Ex8(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
procedure _Negative(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _Sharpen(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; Intensity: integer; Neighbourhood: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _SetTransparentColors(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; MinColor, MaxColor: TRGB; alpha: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _ConvertToGray(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _Merge(bitmap: TIEBitmap; DBitmap: TIEBitmap; pcf: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEApplyThreshold(bitmap: TIEBitmap; DownLimit, UpLimit, DownVal, UpVal: TRGB; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEHistEqualize(bitmap: TIEBitmap; LoThresh, HiThresh: TRGB; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _GetHistogram(Bitmap: TIEBitmap; Hist: PHistogram; fSelx1, fSely1, fSelx2, fSely2: integer; mask:TIEMask);
procedure _HistAutoEqualize(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
//procedure _Resample(Src, Dst: TBitmap; FilterType:TResampleFilter; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleEx(SrcImg, DstImg: TIEBaseBitmap; FilterType: TResampleFilter; fOnProgress: TIEProgressEvent; Sender: TObject);
function _GetImageNumColors(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer): integer;
//procedure _ConvertTo(Bitmap:TBitmap; NumColors:integer; OutPalette: PRGBROW; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ConvertToEx(Bitmap: TIEBitmap; NumColors: integer; OutPalette: PRGBROW; fOnProgress: TIEProgressEvent; Sender: TObject);
//procedure _Negative1Bit(Bitmap: TBitmap);
procedure _Negative1BitEx(Bitmap: TIEBitmap);
function _GetHSVChannel(bitmap: TIEBitmap; ch: integer; fOnProgress: TIEProgressEvent; Sender: TObject): TIEBitmap;
procedure _GetHSVChannelAll(bitmap: TIEBitmap; BitmapH, BitmapS, BitmapV: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
function _GetRGBChannel(bitmap: TIEBitmap; ch: integer; fOnProgress: TIEProgressEvent; Sender: TObject): TIEBitmap;
procedure _GetRGBChannelAll(bitmap: TIEBitmap; BitmapR, BitmapG, BitmapB: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
function _RGBToGray(const rgb: TRGB): integer;
function _GetSimilColor(const ColorMap: array of TRGB; nc: integer; Col: TRGB): integer;
procedure _RGB2BGR(var ColorMap: array of TRGB; nc: integer);
procedure _BGR2RGB(buff: PRGB; width: integer);
procedure _BGR2RGB48(buff: PRGB48; width: integer);
procedure IECopyBits_large(Dest, Source: pbyte; DestStart, SourceStart, Len: integer; SourceRowLen: integer);
procedure IECopyBits_small(Dest, Source: pbyte; DestStart, SourceStart, Len: integer; SourceRowLen: integer);
procedure _CopyBitmapRect(Source, Dest: TBitmap; x1, y1, x2, y2: integer);
//function _ConvertTo1bit(Bitmap:TBitmap; var BackCol,ForeCol:TRGB):TBitmap;
function _ConvertTo1bitEx(Bitmap: TIEBitmap; var BackCol, ForeCol: TRGB): TIEBitmap;
procedure _Conv1to24(var SrcBitmap, DstBitmap: TBitmap; var Progress: TProgressRec);
procedure _CopyPolygonBitmap(Dest: TBitmap; Source: TBitmap; x1, y1: integer; SelPoly: PPointArray; SelPolyCount: integer);
function _BitmapCompareX(Bitmap1, Bitmap2: TBitmap): boolean;
function _BitmapCompareXEx(Bitmap1, Bitmap2: TIEBitmap): boolean;
//procedure _ClearSel(fBitmap:TBitmap; SelPoly:PPointArray; SelPolyCount:integer; Background:TColor);
//procedure _ClearSelMask(fBitmap:TBitmap; mask:TIEMask; Background:TColor);
procedure _ClearSelMaskEx(fIEBitmap: TIEBitmap; mask: TIEMask; Background: TColor);
//procedure _CopyBitmapPoly(Source:TBitmap; Dest:TBitmap; sx1,sy1,sx2,sy2:integer; SelPoly:PPointArray; SelPolyCount:integer);
procedure _ConvertToBWOrdered(bitmap: TIEBitmap; var Progress: TProgressRec);
procedure _ConvertToBWThreshold(bitmap: TIEBitmap; Threshold: integer; var Progress: TProgressRec);
procedure _ConvertToBWThresholdEx(origbitmap, destbitmap: TIEBitmap; Threshold: integer; var Progress: TProgressRec);
procedure _BumpMapping(Bitmap: TIEBitmap; LightX, LightY, LAmpX, LAmpY, pcf: integer; Color: TRGB; fselx1, fsely1, fselx2, fsely2: integer; var Progress: TProgressRec);
procedure _lens(Bitmap: TIEBitmap; xx, yy: integer; width, height: integer; refraction: double; var Progress: TProgressRec);
procedure IEAdjustTemperature(bitmap:TIEBitmap; x1, y1, x2, y2:integer; temperature:integer; fOnProgress:TIEProgressEvent; Sender:TObject);

procedure _rotate1bit(fBitmap: TBitmap; angle: double; background: integer; var Progress: TProgressRec);
procedure _rotate1bitEx(fBitmap: TIEBitmap; angle: double; background: integer; var Progress: TProgressRec);
procedure _rotate8bit(fBitmap: TIEBitmap; angle: double; background: integer);
procedure IEGRotate(src: TIEBitmap; angle: double; Background: TColor; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEGRotateTo(src,dst: TIEBitmap; angle: double; Background: TColor; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _RotateEx(fBitmap: TIEBitmap; fangle: double; antialias: boolean; Background: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _RotateEx8(fBitmap: TIEBitmap; fangle: double; antialias: boolean; Background: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEQRotate(src: TIEBitmap; angle: double; Background: TColor; Filter: TIEAntialiasMode; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEQRotate8(src: TIEBitmap; angle: double; Background: integer; Filter: TIEAntialiasMode);

function _GetPixelbw(row: pbyte; pix: integer): integer;
procedure _SetPixelbw(row: pbyte; pix: integer; vv: integer);
procedure _wave(Bitmap: TIEBitmap; amplitude, wavelength, phase: integer; reflective: boolean; var Progress: TProgressRec);
function _CreateWinPalette(var ColorMap: array of TRGB; NCol: integer): HPalette;
function _CopyDIB2Bitmap(hbi: THandle; fBitmap: TBitmap; xbits: pbyte; unlck: boolean): integer;
function _CopyDIB2BitmapEx(hbi: THandle; fBitmap: TIEBaseBitmap; xbits: pbyte; unlck: boolean): integer;
//function _CopyBitmaptoDIB(fBitmap: TBitmap; x1, y1, x2, y2: integer): THandle;
function _CopyBitmaptoDIBEx(fBitmap: TIEBaseBitmap; x1, y1, x2, y2: integer; dpix,dpiy:integer): THandle;
//function _IECopyDIB2Bitmap2(hbi:THandle; fBitmap:TBitmap; xbits:pbyte; unlck:boolean):integer;
function _IECopyDIB2Bitmap2Ex(hbi: THandle; fBitmap: TIEDibBitmap; xbits: pbyte; unlck: boolean): integer;
procedure IEDIBGamma(hbi: THandle; gamma:double);
procedure _CopyIYU1ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyIYU2ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyUYVYToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyYUY2ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyYVYUToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyY41PToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyY211ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyCLJRToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyYVU9ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyYV12ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyI420ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
procedure _CopyPolygonToPoint(Source: TBitmap; Polygon: PPointArray; PolygonLen: integer; Dest: TBitmap; const Position: TPoint);
procedure _CopyPointToPolygon(Source: TBitmap; Polygon: PPointArray; PolygonLen: integer; Dest: TBitmap; const Position: TPoint);
procedure _CopyBGR_RGB(dst: PRGB; src: PRGB; width: integer);
procedure _CopyBGR_RGB48(dst: PRGB48; src: PRGB48; width: integer);
procedure _MorphFilter(bitmap: TIEBitmap; WindowSize: integer; op: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEmorph1bit(Bitmap:TIEBitmap; nIter:integer; opType:integer; size:integer; invertFlag:boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
function _MakeMagicWandPoints(fBitmap: TIEBitmap; x, y: integer; maxfilter: boolean; tolerance: integer; var pcount: integer): PPointArray;
procedure _MakeMagicWandPointsEx(fBitmap: TIEBitmap; x, y: integer; maxfilter: boolean; tolerance: integer; mask: TIEMask; selintensity:integer);
procedure _MakeMagicWandPointsEx2(fBitmap: TIEBitmap; x, y: integer; tolerance: integer; mask: TIEMask; selintensity:integer);
procedure _IEBmpStretch(origBmp, destBmp: TBitmap);
procedure _IEBmpStretchEx(origBmp, destBmp: TIEBaseBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
function _ConvertXBitsToYBits(var Input, Output: TBYTEROW; Xbits, Ybits, Width: Word; Palette: array of TRGB; Quantizer: TObject): integer;
//procedure _SubResample1bitFiltered(src:TBitmap; sx1,sy1,sx2,sy2:integer; dst:TBitmap);
procedure _SubResample1bitFilteredEx(src: TIEBaseBitmap; sx1, sy1, sx2, sy2: integer; dst: TIEBitmap);
//function _SubResample1bitFilteredDIB(src:pbyte; sxx,syy:integer; sx1,sy1,sx2,sy2:integer; dxx,dyy:integer):pbyte;
procedure _IEResampleIEBitmap(source, dest: TIEBitmap; FilterType: TResampleFilter; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEResampleIEBitmap2(sourceANDdest: TIEBitmap; FilterType: TResampleFilter; NewWidth,NewHeight:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _Resampleie8g(Src, Dst: TIEBitmap; FilterType: TResampleFilter);
//procedure _Resample1bit(Src, Dst: TBitmap; FilterType:TResampleFilter);
procedure _Resample1bitEx(Src, Dst: TIEBitmap; FilterType: TResampleFilter);
function _iehough(image: TIEBitmap; var Progress: TProgressRec; anglerange: integer; Precision: Double): double;
procedure _Fill(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; FillColor: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
//procedure _ResampleLinear(Src, Dst: TBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleLinearEx(Src, Dst: TIEBaseBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
//procedure _ResampleLinear1Bit(Src, Dst: TBitmap; fOnProgress:TIEProgressEvent; Sender:TObject);
procedure _ResampleLinear1BitEx(Src, Dst: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _ResampleLinearAlpha(Src, Dst: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEEdgeDetect_ShenCastan(SrcBitmap, DstBitmap: TIEBitmap; Ratio: double; Smooth: double; WindowSize: integer; ThinFactor: integer; DoHysteresis: boolean; var Progress: TProgressRec);
procedure _CalcDensityHistogram(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject; VertHist, HorizHist: pintegerarray; norm_vert, norm_horiz: integer);
procedure _FlipEx(bmp: TIEBitmap; dir: TFlipDir);
procedure _IERemoveIsolatedPixels1Bit(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; NoiseColor: integer; IsolationMax: integer);
procedure _kf_kfill(bitmap: TIEBitmap; RetainConnectivity: boolean; RetainEndpoints: boolean; MaxIterations: integer; WindowSize: integer; InvertImage: boolean);
procedure _IEComputeDiff(x, y: TIEBitmap; var psnr_min, psnr_max: double; var mse_min, mse_max: double;
  var rmse_min, rmse_max: double; var pae_min, pae_max: double;
  var mae_min, mae_max: double; var equal: boolean);
procedure _IEGammaCorrect_RGB8(ABitmap: TIEBitmap; AGamma: double; AChannel: TIEChannels; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _NegativeBuffer(buf: pbyte; WidthBytes: integer);
procedure _ConvRow1To24(spx, dpx: pbyte; Width: integer);
procedure _IEGBlur(Bitmap: TIEBitmap; radius: double; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEGBlurRect8(Bitmap: TIEBitmap; x1, y1, x2, y2: integer; radius: double);
procedure _IEAddSoftShadow(bitmap: TIEBitmap; radius: double; OffSetX: integer; OffSetY: integer; Intensity:integer; AdaptBitmap: boolean; ShadowColor: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
function _IEAddSoftShadowRect(bitmap: TIEBitmap; radius: double; OffSetX: integer; OffSetY: integer; Intensity:integer; ShadowColor: TRGB; x1, y1, x2, y2: integer): integer;
procedure _IEAddInnerShadow(bitmap: TIEBitmap; radius: double; OffSetX: integer; OffSetY: integer; ShadowColor: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEQResampleBytes(SrcImg, DstImg: TIEBaseBitmap; filter: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEQResampleWords(SrcImg, DstImg: TIEBaseBitmap; filter: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEMedianFilter(image: TIEBitmap; WindowX, WindowY: integer; Brightness, Contrast, Multiplier, Threshold: integer; MedianOp: TIEMedFilType; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEWallisFilter(image: TIEBitmap; WinWidth, WinHeight: integer; Mean, StDev, InGain, Edge, Limit: integer; Thresholding: boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
function _IECalcVertOrientationFitness(bitmap: TIEBitmap): integer;
//procedure _IEAddSoftShadowRect2(bitmap: TIEBitmap; size: integer; Intensity: double; OffsetX, OffsetY: integer; rx1, ry1, rx2, ry2: integer);
procedure _IESetAlpha0Color(bitmap: TIEBitmap; cl: TRGB);
procedure _Conv1to24Ex(var SrcBitmap, DstBitmap: TIEBitmap; var Progress: TProgressRec);
procedure _IERemoveRedEyes(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEFields_warp(source: TIEBitmap; asource_lines: PIELineArray; adest_lines: PIELineArray; num_lines:integer; num_frames: integer; outimages: TList);
procedure _IERoundImage(ProcBitmap:TIEBitmap; RoundWidth,RoundHeight:integer; fOnProgress: TIEProgressEvent; self:TObject);
function _IESkewDetectionFine(Bitmap:TIEBitmap; StartingAngle: double; resolution: double; range: integer; maxQuality: boolean): double;
procedure _IERadialStretch(bitmap: TIEBitmap; ARed,BRed,CRed,DRed, AGreen,BGreen,CGreen,DGreen, ABlue,BBlue,CBlue,DBlue:double; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _IEfsdither(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
function _IESkewDetection(Bitmap:TIEBitmap; ResampleWidth: integer; AngleRange: integer; Precision: double; EdgeDetect: boolean; fOnProgress: TIEProgressEvent; Sender: TObject): double;
procedure _ResampleProject1Bit(origBmp, DestBmp: TIEBaseBitmap; Negative:boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure _ResampleProject24Bit(origBmp, DestBmp: TIEBaseBitmap; Negative:boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
//procedure _ResampleProject(origBmp, DestBmp: TIEBaseBitmap; Negative:boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEWhiteBalance_grayworld(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEWhiteBalance_2(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEWhiteBalance_3(bitmap:TIEBitmap; white_x, white_y:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEGetAverageValues(bitmap:TIEBitmap; var avg:array of double);
procedure IEApplyCoefficients(bitmap:TIEBitmap; var coeff: array of double; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEAdjustGainOffset(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IECastColor(Bitmap:TIEBitmap; x,y:integer; newColor:TRGB; tolerance:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IECastAlpha(Bitmap:TIEBitmap; x,y:integer; newAlpha:integer; tolerance:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
procedure IEPatternSearch(InputBitmap:TIEBitmap; pattern:TIEBitmap; var FoundRect:TRect; precision:double; scaleSteps:integer);
procedure IEACE(OrigBitmap:TIEBitmap; subwidth:integer; Slope:integer; Cut:integer; Neightbour:integer; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IELLLUT( SubOriginal, SubFiltered:TIEBitmap; Bitmap:TIEBitmap; Neightbour:integer; OnProgress: TIEProgressEvent; Sender: TObject; ProgressOffset:integer; ProgressMultiplier:double);
procedure IEAutoSharp(bitmap:TIEBitmap; Intensity:integer; rate:double; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IERetinex(bitmap:TIEBitmap; ScaleCount:integer; ScaleCurve:integer; Variance:single; ScaleHigh:integer; Luma:boolean; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IEChangeYCbCrCoefficients(Bitmap:TIEBitmap; srcLumaRed,srcLumaGreen,srcLumaBlue, dstLumaRed,dstLumaGreen,dstLumaBlue:double);
procedure IEAdjustBrightnessContrastSaturation(Bitmap: TIEBitmap; b, c, s: integer; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IEContrast2(src: TIEBitmap; z: single; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IEAdjustSaturation(Src: TIEBitmap; Amount: integer; pr:TProgressRec);
procedure IEAdjustTint(Src: TIEBitmap; Amount: integer; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IEAutoSBHist(src: TIEBitmap; z1, z2: single; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IESobel(bitmap:TIEBitmap; OnProgress: TIEProgressEvent; Sender: TObject);
function IEAutoCrop2(bitmap:TIEBitmap; BorderRate:double):TRect;
procedure IEDisposeChannels(Bitmap:TIEBitmap; newDispo:string; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IELuminanceEnhancement(Bitmap: TIEBitmap; Gamma:double; Saturation:integer; OnProgress: TIEProgressEvent; Sender: TObject);
function IEGetVisibleArea(Bitmap:TIEBitmap; OnProgress: TIEProgressEvent; Sender: TObject):TRect;
function IECompareImagesHistogram(bitmap1, bitmap2: TIEBitmap; Mode:TIECmpMode; GrayScale:boolean):double;
procedure IEReflectionEffect(bitmap:TIEBitmap; minAlpha, maxAlpha:integer; percentage:integer; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IEPerspectiveTransform(SrcBitmap, DstBitmap:TIEBitmap; xx0, yy0, xx1, yy1, xx2, yy2, xx3, yy3:integer; alphaMin, alphaMax:integer);
procedure IEProjectBitmap1(Bitmap:TIEBitmap; DstBitmap:TIEBitmap; scale:double; centerDstX, centerDstY:integer; translateX, translateY:integer; depth:double; rotateX, rotateY:double; specularAlphaMin, specularAlphaMax:integer; var outCoords:TIEQuadCoords);
procedure IEProjectBitmap2(Bitmap:TIEBitmap; DstBitmap:TIEBitmap; centerDstX, centerDstY:integer; dstWidth, dstHeight:integer; translateX, translateY:integer; depth:double; rotateX, rotateY:double; specularAlphaMin, specularAlphaMax:integer; var outCoords:TIEQuadCoords);
procedure IEMotionBlur(bitmap:TIEBitmap; angle:double; radius:integer; sigma:integer; OnProgress:TIEProgressEvent; Sender:TObject);
procedure IERandom(bitmap:TIEBitmap; mean:double; stdDev:double; x1, y1, x2, y2:integer; OnProgress:TIEProgressEvent; Sender:TObject);
procedure IEMapGrayToColor(Bitmap:TIEBitmap; map:array of TRGB; x1, y1, x2, y2:integer; OnProgress:TIEProgressEvent; Sender:TObject);
procedure IEConvolve(bitmap:TIEBitmap; kernel:array of double; kernelWidth, kernelHeight:integer; factor:double; x1, y1, x2, y2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
function IEAverageRGB(bitmap:TIEBitmap; mask:TIEMask; x1, y1, x2, y2:integer):TRGB;


type
TIEPrecalcTransform = record
  rotateX, rotateY: double; // in degrees
  dst_x1, dst_y1, dst_x2, dst_y2: integer;
  destX, destY: integer;
  width: integer;
  height: integer;
  src: pword;
end;
PIEPrecalcTransform = ^TIEPrecalcTransform;


function IEPerspectiveTransform_precalc(SrcWidth, SrcHeight:integer; xx0, yy0, xx1, yy1, xx2, yy2, xx3, yy3:integer):PIEPrecalcTransform;
procedure IEProjectBitmap_precalc(Bitmap:TIEBitmap; DstBitmap:TIEBitmap; centerDstX, centerDstY:integer; dstWidth, dstHeight:integer; translateX, translateY:integer; depth:double; rotateX, rotateY:double; specularAlphaMin, specularAlphaMax:integer; var outCoords:TIEQuadCoords; var precalclist:TList);
procedure IEProjectBitmap_free_precalclist(var precalclist:TList);
procedure IEPerspectiveTransform_exec(SrcBitmap:TIEBitmap; DstBitmap:TIEBitmap; precalclist:TList; destX, destY:integer; rotateX, rotateY:double);

function IEVectorize(bitmap:TIEMask; x1,y1,x2,y2:integer; SCALE:integer=4):TList;
function IESeparateObjects(Bitmap:TIEBitmap; MergeCommonAreas:boolean; Quality:integer; UseBackgroundColor:boolean; BackgroundColorBegin,BackgroundColorEnd:TRGB):TList;

procedure IETEAEncipher64(v,w,k:pdwordarray);
procedure IETEADecipher64(v,w,k:pdwordarray);
procedure IEEncipherBitmap(Bitmap:TIEBitmap; key:pdwordarray; OnProgress: TIEProgressEvent; Sender: TObject);
procedure IEDecipherBitmap(Bitmap:TIEBitmap; key:pdwordarray; OnProgress: TIEProgressEvent; Sender: TObject);

function IEGraphFilterToString(filter:TGraphFilter):string;

procedure IELocalBinarize(InBitmap,OutBitmap:TIEBitmap; WinSize:integer; Mode:TIEThreshMode; Offset:integer; OnProgress: TIEProgressEvent; Sender: TObject);


{!!
<FS>IECloneBitmap

<FM>Declaration<FC>
function IECloneBitmap(Source: TBitmap): TBitmap;

<FM>Description<FN>
IECloneBitmap creates a new TBitmap object that is a copy of the Source bitmap.

<FM>Example<FC>

Var
  mybmp:TBitmap;
Begin
...
  mybmp:=IECloneBitmap( ImageEnView1.Bitmap );
...
  mybmp.free;
End;
!!}
function IECloneBitmap(Source: TBitmap): TBitmap;

{!!
<FS>IECopyBitmap

<FM>Declaration<FC>
procedure IECopyBitmap(Source,Dest: TBitmap);

<FM>Description<FN>
IECopyBitmap copies Source bitmap to Dest bitmap.

<FM>Example<FC>

IECopyBitmap( ImageEnView1.Bitmap , ImageEnView2.Bitmap );
!!}
procedure IECopyBitmap(Source, Dest: TBitmap);

function IECompareImages(image1, image2: TIEBitmap; diffmap: TIEBitmap): double;
procedure IEGetLuminosityDiff(image1,image2:TIEBitmap; var Red,Green,Blue:integer);
procedure IEAdjustColors(templateimage,targetimage:TIEBitmap);

procedure IEShift(Bitmap:TIEBitmap; offsetx,offsety:integer; channel:integer; FillValue:integer; OnProgress: TIEProgressEvent; Sender: TObject);

{!!
<FS>dmin

<FM>Declaration<FC>
function dmin(v1, v2: double): double;

<FM>Description<FN>
Returns min of v1 and v2.
!!}
function dmin(v1, v2: double): double;

{!!
<FS>dmax

<FM>Declaration<FC>
function dmax(v1, v2: double): double;

<FM>Description<FN>
Returns max of v1 and v2.
!!}
function dmax(v1, v2: double): double;

{!!
<FS>imin

<FM>Declaration<FC>
function imin(v1, v2: integer): integer;

<FM>Description<FN>
Returns the minimum of v1 and v2.
!!}
function imin(v1, v2: integer): integer;

{!!
<FS>imax

<FM>Declaration<FC>
function imax(v1, v2: integer): integer;

<FM>Description<FN>
Returns the maximum of v1 and v2.
!!}
function imax(v1, v2: integer): integer;

{!!
<FS>ilimit

<FM>Declaration<FC>
function ilimit(vv, min, max: integer): integer;

<FM>Description<FN>
Truncates vv to min and max.
!!}
function ilimit(vv, min, max: integer): integer;

{!!
<FS>blimit

<FM>Declaration<FC>
function blimit(vv: integer): integer;

<FM>Description<FN>
The blimit function truncates vv in the range 0 to 255.
!!}
function blimit(vv: integer): integer;

{!!
<FS>blimit

<FM>Declaration<FC>
function wlimit(vv: integer): word;

<FM>Description<FN>
The wlimit function truncates vv in the range 0 to 65535.
!!}
function wlimit(vv: integer):word;

{!!
<FS>iswap

<FM>Declaration<FC>
procedure iswap(var B1, B2: LongInt);

<FM>Description<FN>
Swaps B1 with B2.
!!}
procedure iswap(var B1, B2: LongInt); assembler;

procedure dwswap(var B1, B2: dword); assembler;

{!!
<FS>bswap

<FM>Declaration<FC>
procedure bswap(var B1, B2: Byte);

<FM>Description<FN>
Swaps B1 with B2.
!!}
procedure bswap(var B1, B2: Byte); assembler;

procedure iedswap(var d1, d2: double);

procedure i64swap(var v1,v2:int64);

{!!
<FS>OrdCor

<FM>Declaration<FC>
procedure OrdCor(var x1, y1, x2, y2: integer);

<FM>Description<FN>
Sorts x1, y1, x2, y2 so that x1, y1 is at the top-left and x2, y2 is at the bottom-right vertex of the rectangle.
!!}
procedure OrdCor(var x1, y1, x2, y2: integer);

{!!
<FS>TRGB2TColor

<FM>Declaration<FC>
function TRGB2TColor(rgb: TRGB): TColor;

<FM>Description<FN>
The TRGB2TColor function converts TRGB color to TColor.

<FM>Example<FC>
Panel1.Color:=TRGB2TColor(CreateRGB(255,0,0)); // Create a clRed
!!}
function TRGB2TColor(rgb: TRGB): TColor;


{!!
<FS>RGB2TColor

<FM>Declaration<FC>
function RGB2TColor(r, g, b: integer): TColor;

<FM>Description<FN>
The RGB2TColor function converts R,G,B color to TColor.

<FM>Example<FC>
Panel1.Color:=RGB2TColor(255,0,0); // Create a clRed
!!}
function RGB2TColor(r, g, b: integer): TColor;

{!!
<FS>TColor2TRGB

<FM>Declaration<FC>
function TColor2TRGB(cl: TColor): <A TRGB>;

<FM>Description<FN>
The TColor2TRGB function converts TColor to TRGB.

<FM>Example<FC>

var
  rgb:TRGB;
Begin
  rgb:=TColor2TRGB( clRed );
...
End;
!!}
function TColor2TRGB(cl: TColor): TRGB;


{!!
<FS>TColor2TRGBA

<FM>Declaration<FC>
function TColor2TRGBA(cl: TColor; transparency:integer): <A TRGBA>;

<FM>Description<FN>
The TColor2TRGBA function converts TColor and transparency to TRGBA.

<FM>Example<FC>

var
  rgb:TRGBA;
Begin
  rgb:=TColor2TRGBA( clRed, 255 );
...
End;
!!}
function TColor2TRGBA(cl: TColor; transparency:integer): TRGBA;



{!!
<FS>RGB2HSL

<FM>Declaration<FC>
procedure RGB2HSL(px: TRGB; var Hue, Sat, Lum: double);

<FM>Description<FN>
This method converts a TRGB color to HSL.

iHue, iSat and iLum will be in range 0 to 1.
!!}
procedure RGB2HSL(px: TRGB; var Hue, Sat, Lum: double);

{!!
<FS>HSL2RGB

<FM>Declaration<FC>
procedure HSL2RGB(var px: <A TRGB>; iHue, iSat, iLum: double);

<FM>Description<FN>
Converts an HSL value (iHue, iSat, iLum) with a TRGB (px).

iHue, iSat and iLum are in range 0 to 1.
!!}
procedure HSL2RGB(var px: TRGB; iHue, iSat, iLum: double);

{!!
<FS>HSV2RGB

<FM>Declaration<FC>
procedure HSV2RGB(var px: <A TRGB>; H, S, V: integer);

<FM>Description<FN>
This method converts an HSV color to TRGB.

H (Hue) is from 0 to 359 (corresponding to 0..359 degrees around hexcone).
S (Saturation) is from 0 (shade of gray) to 99 (pure color).
V (Value) is from 0 (black) to 99 {white).
!!}
procedure HSV2RGB(var px: TRGB; H, S, V: integer);

{!!
<FS>RGB2HSV

<FM>Declaration<FC>
procedure RGB2HSV(RGB: <A TRGB>; var h, s, v: integer);

<FM>Description<FN>
This method converts a TRGB color to HSV.

h (Hue) will be from 0 to 359 (corresponding to 0..359 degrees around hexcone).
s (Saturation) will be from 0 (shade of gray) to 99 (pure color).
v (Value) will be from 0 (black) to 99 {white).
!!}
procedure RGB2HSV(RGB: TRGB; var h, s, v: integer);

{!!
<FS>CreateRGB

<FM>Declaration<FC>
function CreateRGB(r, g, b: byte): <A TRGB>;

<FM>Description<FN>
Returns a TRGB record.
!!}
function CreateRGB(r, g, b: byte): TRGB;

{!!
<FS>CreateRGB48

<FM>Declaration<FC>
function CreateRGB48(r, g, b: word): <A TRGB48>;

<FM>Description<FN>
Returns a TRGB48 record.
!!}
function CreateRGB48(r, g, b: word): TRGB48;


{!!
<FS>CreateCMYK

<FM>Declaration<FC>
function CreateCMYK(c,m,y,k: byte): <A TCMYK>;

<FM>Description<FN>
Returns a TCMYK record.
!!}
function CreateCMYK(c,m,y,k: byte): TCMYK;


{!!
<FS>CreateRGBA

<FM>Declaration<FC>
function CreateRGBA(r, g, b, a: byte): <A TRGBA>;

<FM>Description<FN>
Returns a TRGBA record.
!!}
function CreateRGBA(r, g, b, a: byte): TRGBA;


function CreateRGBFromInt(r, g, b: integer): TRGB;

{!!
<FS>EqualRGB

<FM>Declaration<FC>
function EqualRGB(rgb1, rgb2: <A TRGB>): boolean;

<FM>Description<FN>
Returns True if rgb1 is equal to rgb2.

!!}
function EqualRGB(rgb1, rgb2: TRGB): boolean;

{!!
<FS>LoadFilterFromFile

<FM>Declaration<FC>
function LoadFilterFromFile(const FileName: string): <A TGraphFilter>;

<FM>Description<FN>
Loads a filter.

ng is the file name of the filter.

<FM>Example<FC>

var
  Filter:TGraphFilter;
Begin
  Filter:=LoadFilterFromFile('myfilter.flt')
  ImageEnView1.Proc.ApplyFilter( Filter );
End;
!!}
function LoadFilterFromFile(const FileName: string): TGraphFilter;

{!!
<FS>SaveFilterToFile

<FM>Declaration<FC>
procedure SaveFilterToFile(const FileName: string; const filt: <A TGraphFilter>);

<FM>Description<FN>
Saves filter (filt) to a file.

FileName is the file name.
!!}
procedure SaveFilterToFile(const FileName: string; const filt: TGraphFilter);

procedure YUV2RGB(y, u, v: integer; var RGB: TRGB);
function IECeil(X: Extended): Integer;
procedure IERGBtoHSB(const cRed, cGreen, cBlue: byte; var H, S, B: word);
procedure IEHSBtoRGB(const H, S, B: word; var cRed, cGreen, cBlue: byte);


{!!
<FS>IEAddNewFilter

<FM>Declaration<FC>
function IEAddNewFilter( const filter:<A TGraphFilter> ; const name:string):integer;

<FM>Description<FN>
Creates a new public filter (3x3 convolution matrix). You can call filters using ApplyFilter or using preview dialog.

<FM>Example<FC>

Const
  Myfilter:TgraphFilter=
   (Values: ((-1, 0, 1),
    (-1, 1, 1),
    (-1, 0, 1)); Divisor: 1);
..
IEAddNewFilter( MyFilter, 'my filter');
..
ImageEnView.Proc.DoPreviews();	// at 'user filters' tab you will see your filter
!!}
function IEAddNewFilter( const filter:TGraphFilter ; const name:string):integer;

function IEGetFilter( index:integer ):PIEGraphFilter;
function IEGetFilterName( index:integer ):string;
function IEGetFiltersCount:integer;


var
  C1TO24: array[0..255, 0..7] of TRGB; // to convert 1bit to 24bit
  IERAWCLIPFORMAT: integer;



{!!
<FS>iegPanZoomQualityFilter

<FM>Declaration<FC>
iegPanZoomQualityFilter:<A TResampleFilter> = rfNone;

<FM>Description<FN>
Specifies zoom filter for iettPanZoom transition effect.
!!}
  iegPanZoomQualityFilter:TResampleFilter = rfNone;



resourcestring

  IERS_CONVOLVE = 'Convolve';
  IERS_APPLYFILTER = 'ApplyFilter';
  IERS_HSLVAR = 'HSLvar %d, %d, %d';
  IERS_HSVVAR = 'HSVvar %d, %d, %d';
  IERS_CONVERTTOGRAY = 'ConvertToGray';
  IERS_MERGE = 'Merge %d';
  IERS_THRESHOLD = 'Threshold';
  IERS_THRESHOLD2 = 'Threshold2';
  IERS_HISTAUTOEQUALIZE = 'HistAutoEqualize';
  IERS_HISTEQUALIZE = 'HistEqualize';
  IERS_CONTRAST = 'Contrast %f';
  IERS_INTENSITYRGBALL = 'IntensityRGBall %d, %d, %d';
  IERS_NEGATIVE = 'Negative';
  IERS_CASTCOLORRANGE = 'CastColorRange';
  IERS_MATCHHSVRANGE = 'MatchHSVRange';
  IERS_BUMPMAPPING = 'BumpMapping';
  IERS_LENS = 'Lens';
  IERS_WAVE = 'Wave';
  IERS_MAXIMUM = 'Maximum %d';
  IERS_MINIMUM = 'Minimum %d';
  IERS_OPENING = 'Opening %d';
  IERS_CLOSING = 'Closing %d';
  IERS_FILL = 'Fill (%d, %d, %d)';
  IERS_REMOVEISOLATEDPIXELS = 'RemoveIsolatedPixels %d, %d';
  IERS_PAINTMARK = 'PaintMark %d, (%d, %d, %d)';
  IERS_GAMMACORRECT = 'GammaCorrect';
  IERS_BLUR = 'Blur %f';
  IERS_SETTRANSPARENTCOLORS = 'SetTransparentColors';
  IERS_MEDIANFILTER = 'MedianFilter';
  IERS_WALLISFILTER = 'WallisFilter';
  IERS_SHARPEN = 'Sharpen %d, %d';
  IERS_UNSHARPMASK = 'UnsharpMask %d, %f, %f';
  IERS_REMOVEREDEYES = 'RemoveRedEyes';
  IERS_ROUNDIMAGE = 'RoundImage %d, %d';
  IERS_RADIALSTRETCH = 'RadialStretch';
  IERS_WHITEBALANCE_COEF = 'WhiteBalance_coef %f, %f, %f';
  IERS_WHITEBALANCE_GRAYWORLD = 'WhiteBalance_GrayWorld';
  IERS_WHITEBALANCE_WHITEAT = 'WhiteBalance_WhiteAt %d, %d';
  IERS_WHITEBALANCE_AUTOWHITE = 'WhiteBalance_AutoWhite';
  IERS_ADJUSTGAINOFFSET = 'AdjustGainOffset';
  IERS_CASTCOLOR = 'CastColor';
  IERS_CASTALPHA = 'CastAlpha %d, %d, %d, %d';
  IERS_COLORIZE = 'Colorize %d, %d, %f';
  IERS_AUTOIMAGEENHANCE1 = 'AutoImageEnhance1 %d, %d, %d, %d';
  IERS_AUTOSHARP = 'AutoSharp %d, %f';
  IERS_AUTOIMAGEENHANCE2 = 'AutoImageEnhance2';
  IERS_SHIFTCHANNEL = 'ShiftChannel %d, %d, %d, %d';
  IERS_ADJUSTBRIGHTNESSCONTRASTSATURATION = 'AdjustBrightnessContrastSaturation %d, %d, %d';
  IERS_CONTRAST2 = 'Contrast2 %f';
  IERS_ADJUSTSATURATION = 'AdjustSaturation %d';
  IERS_ADJUSTTINT = 'AdjustTint %d';
  IERS_ADJUSTLUMSATHISTOGRAM = 'AdjustLumSatHistogram %f, %f';
  IERS_DISPOSECHANNELS = 'DisposeChannels %s';
  IERS_INTENSITY = 'Intensity';
  IERS_CONTRAST3 = 'Contrast3';
  IERS_AUTOIMAGEENHANCE3 = 'AutoImageEnhance3 %f, %d';
  IERS_REFLECTION = 'Reflection %d, %d, %d';
  IERS_PERSPECTIVEDRAW = 'PerspectiveDraw';
  IERS_PROJECTDRAW = 'ProjectDraw';
  IERS_ADJUSTTEMPERATURE = 'AdjustTemperature';
  IERS_MOTIONBLUR = 'MotionBlur %f, %d, %d';
  IERS_RANDOM = 'Random %f, %f';
  IERS_MAPGRAYTOCOLOR = 'MapGrayToColor';
  IERS_FTCLEARZONE = 'FTClearZone';
  IERS_RESAMPLE = 'Resample %d, %d';
  IERS_PASTEFROMCLIPBOARD = 'PasteFromClipboard';
  IERS_POINTPASTEFROMCLIP = 'PointPasteFromClip %d, %d';
  IERS_SELPASTEFROMCLIPSTRETCH = 'SelPasteFromClipStretch';
  IERS_SELPASTEFROMCLIP = 'SelPasteFromClip';
  IERS_FLIP = 'Flip';
  IERS_SELCUTTOCLIP = 'SelCutToClip';
  IERS_CLEAR = 'Clear';
  IERS_CLEARSEL = 'ClearSel';
  IERS_CROPSEL = 'CropSel';
  IERS_CONVERTTO = 'ConvertTo %d';
  IERS_CONVERTTOPALETTE = 'ConvertToPalette';
  IERS_CONVERTTOBWORDERED = 'ConvertToBWOrdered';
  IERS_CONVERTTOBWTHRESHOLD = 'ConvertToBWThreshold %d';
  IERS_CONVERTTO24BIT = 'ConvertTo24Bit';
  IERS_ROTATE = 'Rotate %f';
  IERS_WRITEHIDDENDATA = 'WriteHiddenData';
  IERS_EDGEDETECT = 'EdgeDetect';
  IERS_REMOVENOISE = 'RemoveNoise';
  IERS_ADDSOFTSHADOW = 'AddSoftShadow';
  IERS_ADDINNERSHADOW = 'AddInnerShadow';
  IERS_CONVERTTOBW_FLOYDSTEINBERG = 'ConvertToBW_FloydSteinberg';
  IERS_CROP = 'Crop %d, %d, %d, %d';
  IERS_MAKETILE = 'MakeTile %d, %d';
  IERS_ROTATEANDCROP = 'RotateAndCrop';
  IERS_DEINTERLACE = 'Deinterlace';
  IERS_EDGEDETECT_SOBEL = 'EdgeDetect_Sobel';
  IERS_ENCRYPT = 'Encrypt';
  IERS_DECRYPT = 'Decrypt';
  IERS_CONVERTTOBWLOCALTHRESHOLD = 'ConvertToBWLocalThreshold';

  IERS_FLT_NONE = 'None';
  IERS_FLT_BLUR = 'Blur';
  IERS_FLT_EDGES = 'Edges';
  IERS_FLT_EMBOSS = 'Emboss';
  IERS_FLT_HIGH_PASS_1 = 'High Pass 1';
  IERS_FLT_HIGH_PASS_2 = 'High Pass 2';
  IERS_FLT_HIGH_PASS_3 = 'High Pass 3';
  IERS_FLT_LOW_PASS_1 = 'Low Pass 1';
  IERS_FLT_LOW_PASS_2 = 'Low Pass 2';


implementation

uses Previews, clipbrd, NeurQuant, ImageEnView, imageenio, ievect;

{$R-}

var
  IEFiltPres: TList;
  IEFiltPresNames: TStringList;

function IECeil(X: Extended): Integer;
begin
  Result := Trunc(X);
  if Frac(X) > 0 then
    Inc(Result);
end;

procedure iedswap(var d1, d2: double);
var
  v: double;
begin
  v := d1;
  d1 := d2;
  d2 := v;
end;

procedure i64swap(var v1,v2:int64);
var
  v:int64;
begin
  v := v1;
  v1 := v2;
  v2 := v;
end;

/////////////////////////////////////////////////////////////////////////////////////

function Floor(X: Extended): Integer;
begin
  Result := Trunc(X);
  if Frac(X) < 0 then
    Dec(Result);
end;

function CreateCMYK(c, m, y, k: byte): TCMYK;
begin
  result.c := c;
  result.m := m;
  result.y := y;
  result.k := k;
end;

function CreateRGB(r, g, b: byte): TRGB;
begin
  result.r := r;
  result.g := g;
  result.b := b;
end;

function CreateRGB48(r, g, b: word): TRGB48;
begin
  result.r := r;
  result.g := g;
  result.b := b;
end;


function CreateRGBA(r, g, b, a: byte): TRGBA;
begin
  result.r := r;
  result.g := g;
  result.b := b;
  result.a := a;
end;

function CreateRGBFromInt(r, g, b: integer): TRGB;
begin
  result.r := blimit(r);
  result.g := blimit(g);
  result.b := blimit(b);
end;


/////////////////////////////////////////////////////////////////////////////////////

function _RGBToGray(const rgb: TRGB): integer;
begin
  with rgb do
    //result:=(r*30 + g*59 + b*11) div 100;
    result := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
end;

/////////////////////////////////////////////////////////////////////////////////////

function TRGB2TColor(rgb: TRGB): TColor;
begin
  with rgb do
    result := r or (g shl 8) or (b shl 16);
end;

/////////////////////////////////////////////////////////////////////////////////////

function RGB2TColor(r, g, b: integer): TColor;
begin
  result := r or (g shl 8) or (b shl 16);
end;

/////////////////////////////////////////////////////////////////////////////////////

function TColor2TRGB(cl: TColor): TRGB;
var
  rgb: longint;
begin
  rgb := colortorgb(cl);
  result.r := $FF and rgb;
  result.g := ($FF00 and rgb) shr 8;
  result.b := ($FF0000 and rgb) shr 16;
end;

function TColor2TRGBA(cl: TColor; transparency:integer): TRGBA;
var
  rgb: longint;
begin
  rgb := colortorgb(cl);
  result.r := $FF and rgb;
  result.g := ($FF00 and rgb) shr 8;
  result.b := ($FF0000 and rgb) shr 16;
  result.a := transparency;
end;


/////////////////////////////////////////////////////////////////////////////////////

function dmin(v1, v2: double): double;
begin
  if v1 < v2 then
    dmin := v1
  else
    dmin := v2;
end;

function dmax(v1, v2: double): double;
begin
  if v1 > v2 then
    dmax := v1
  else
    dmax := v2;
end;

function IMax(v1, v2: Integer): Integer;
asm
	cmp	edx,eax
	jng	@1
	mov	eax,edx
@1:
end;

function IMin(v1, v2: Integer): Integer;
asm
	cmp	eax,edx
	jng	@1
	mov	eax,edx
@1:
end;

// vv=eax       result=eax
// min=edx
// max=ecx

function ilimit(vv, min, max: integer): integer;
asm
	cmp eax,edx
   jg @1		// vv>min
   mov eax,edx
   ret
@1:
	cmp eax,ecx
   jl @2		// vv<min
   mov eax,ecx
   ret
@2:
end;
(*
begin
 result:= IMin(IMax(vv,min),max);
end;
//*)

// limit 0 between 255

function blimit(vv: integer): integer;
asm
         OR EAX, EAX
         JNS @@plus
         XOR EAX, EAX
         RET

@@plus:
         CMP EAX, 255
         JBE @@END
         MOV EAX, 255
@@END:
end;

function wlimit(vv:integer):word;
begin
  if vv<0 then result:=0 else if vv>65535 then result:=65535 else result:=vv;
end;

/////////////////////////////////////////////////////////////////////////////////////

procedure iswap(var B1, B2: LongInt); assembler;
asm
   push EBX
   mov  ecx, [EAX];
   mov  ebx, [EDX];
   mov  [EDX], ecx
   mov  [EAX], ebx
   pop EBX
end;

procedure dwswap(var B1, B2: dword); assembler;
asm
   push EBX
   mov  ecx, [EAX];
   mov  ebx, [EDX];
   mov  [EDX], ecx
   mov  [EAX], ebx
   pop EBX
end;


/////////////////////////////////////////////////////////////////////////////////////

function EqualRGB(rgb1, rgb2: TRGB): boolean;
begin
  result := (rgb1.r = rgb2.r) and (rgb1.g = rgb2.g) and (rgb1.b = rgb2.b);
end;

/////////////////////////////////////////////////////////////////////////////////////

procedure bswap(var B1, B2: Byte); assembler;
asm
  mov  cl, Byte Ptr [EAX];
  mov  ch, Byte Ptr [EDX];
  mov  Byte Ptr [EDX], cl
  mov  Byte Ptr [EAX], ch
end;

// order two coordinaqtes, putting the first as top-left

procedure OrdCor(var x1, y1, x2, y2: integer);
begin
  if x1 > x2 then
    iswap(x1, x2);
  if y1 > y2 then
    iswap(y1, y2);
end;

function ArcTan2(Y, X: Extended): Extended;
asm
   FLD     Y
   FLD     X
   FPATAN
   FWAIT
end;

function ACos(X: Extended): Extended;
begin
  Result := ArcTan2(Sqrt(1 - X * X), X);
end;

function ASin(X: Extended): Extended;
begin
  Result := ArcTan2(X, Sqrt(1 - X * X))
end;

function Tan(X: Extended): Extended;
asm
   FLD    X
   FPTAN
   FSTP   ST(0)
   FWAIT
end;

function Log2(X: Extended): Extended;
asm
   FLD1
   FLD     X
   FYL2X
   FWAIT
end;

function Log10(X: Extended): Extended;
asm
        FLDLG2
        FLD     X
        FYL2X
        FWAIT
end;

(*
function LogN(Base, X: Extended): Extended;
asm
   FLD1
   FLD     X
   FYL2X
   FLD1
   FLD     Base
   FYL2X
   FDIV
   FWAIT
end;
*)

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnProc.Create

<FM>Declaration<FC>
constructor Create(Owner: TComponent);

<FM>Description<FN>
Creates a new instance. You can set Owner=nil to create a component without owner.
!!}
constructor TImageEnProc.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  //
  fIEBitmap := TIEBitmap.Create;
  fIEBitmapCreated := true; // we create fIEBitmap
  fImageEnViewBitmapChangeHandle := nil;
  fOnPreview := nil;
  fBitmap := nil;
  fImageEnView := nil;
  fTImage := nil;
  fPreviewsParams := [prppShowResetButton, prppHardReset];
  fOnProgress := nil;
  fOnFinishWork := nil;
  fUndoList := TList.Create;
  fRedoList := TList.Create;
  fUndoSource := TList.Create;
  fRedoSource := TList.Create;
  fUndoLocation := ieFile;
  fAutoUndo := assigned(Owner);
  fBackground := clBlack;
  fMsgLanguage := msSystem;
  fPreviewFont := TFont.Create;
  fUndoLimit := 1;
  fUndoCaptions := TStringList.Create;
  fRedoCaptions := TStringList.Create;
  fFiltersInitialDir := '';
  {$ifdef IEINCLUDEDIALOGIP}
  fIPDialogParams := TIPDialogParams.Create;
  fPreviewsLog := TStringList.Create;
  {$endif}
  fAutoConvertFormat:=true;
  fOnSaveUndo:=nil;
end;

{!!
<FS>TImageEnProc.CreateFromBitmap

<FM>Declaration<FC>
constructor CreateFromBitmap(Bitmap:TIEBitmap);
constructor CreateFromBitmap(Bitmap:TBitmap);

<FM>Description<FN>
Creates a new instance assigning property <A TImageEnProc.AttachedIEBitmap> or <A TImageEnProc.AttachedBitmap>.
Sets <A TImageEnProc.AutoUndo> to <FC>false<FN>.

<FM>Example<FC>
with TImageEnProc.CreateFromBitmap(myBitmap) do
begin
  Resample(100, 100);
  Free;
end;
!!}
constructor TImageEnProc.CreateFromBitmap(Bitmap:TIEBitmap);
begin
  Create(nil);
  AutoUndo := false;
  AttachedIEBitmap := Bitmap;
end;

constructor TImageEnProc.CreateFromBitmap(Bitmap:TBitmap);
begin
  Create(nil);
  AutoUndo := false;
  AttachedBitmap := Bitmap;
end;

/////////////////////////////////////////////////////////////////////////////////////

destructor TImageEnProc.Destroy;
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle);
  ClearAllUndo;
  ClearAllRedo;
  FreeAndNil(fUndoList);
  FreeAndNil(fRedoList);
  FreeAndNil(fUndoSource);
  FreeAndNil(fRedoSource);
  FreeAndNil(fPreviewFont);
  FreeAndNil(fUndoCaptions);
  FreeAndNil(fRedoCaptions);
  {$ifdef IEINCLUDEDIALOGIP}
  FreeAndNil(fIPDialogParams);
  FreeAndNil(fPreviewsLog);
  {$endif}
  if fIEBitmapCreated then
    FreeAndNil(fIEBitmap);
  //
  inherited;
end;

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnProc.Update

<FM>Declaration<FC>
procedure Update;

<FM>Description<FN>
If TImageEnProc is attached to a <A TImageEnView> (or inherited) object, Update calls relative TImageEnView.Update method.
If TImageEnProc is attached to a TBitmap object, Update sets the modified property to True.
!!}
procedure TImageEnProc.Update;
begin
  // remove alpha if attached to fBitmap
  if assigned(fBitmap) then
    fIEBitmap.RemoveAlphaChannel;
  //
  if assigned(fImageEnView) then
    with fImageEnView do
    begin
      Update;
      ImageChange;
    end
  else if assigned(fBitmap) then
    fBitmap.modified := true;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Undo/Redo

{!!
<FS>TImageEnProc.ClearAllUndo

<FM>Declaration<FC>
procedure ClearAllUndo;

<FM>Description<FN>
ClearAllUndo removes all images in the Undo stack.
!!}
procedure TImageEnProc.ClearAllUndo;
var
  i:integer;
begin
  for i:=0 to fUndoList.Count-1 do
    TObject(fUndoList[i]).free;
  fUndoList.Clear;
  fUndoSource.Clear;
  fUndoCaptions.Clear;
end;

{!!
<FS>TImageEnProc.ClearAllRedo

<FM>Declaration<FC>
procedure ClearAllRedo;

<FM>Description<FN>
ClearAllRedo removes all images from the Redo stack.
!!}
procedure TImageEnProc.ClearAllRedo;
var
  i:integer;
begin
  for i:=0 to fRedoList.Count-1 do
    TObject(fRedoList[i]).free;
  fRedoList.Clear;
  fRedoSource.Clear;
  fRedoCaptions.Clear;
end;

// remove only last undo

{!!
<FS>TImageEnProc.ClearUndo

<FM>Declaration<FC>
procedure ClearUndo;

<FM>Description<FN>
The ClearUndo method empties the last undo buffer and frees memory allocated for it.
!!}
procedure TImageEnProc.ClearUndo;
var
  uc: integer;
begin
  uc := fUndoList.Count;
  if uc > 0 then
  begin
    TObject(fUndoList[uc - 1]).free;
    fUndoList.delete(uc - 1);
    fUndoSource.delete(uc - 1);
    fUndoCaptions.delete(uc - 1);
  end;
end;

{!!
<FS>TImageEnProc.ClearRedo

<FM>Declaration<FC>
procedure ClearRedo;

<FM>Description<FN>
ClearRedo clears only the last undo entry.
!!}
procedure TImageEnProc.ClearRedo;
var
  uc: integer;
begin
  uc := fRedoList.Count;
  if uc > 0 then
  begin
    TObject(fRedoList[uc - 1]).free;
    fRedoList.delete(uc - 1);
    fRedoSource.delete(uc - 1);
    fRedoCaptions.delete(uc - 1);
  end;
end;

{!!
<FS>TImageEnProc.Undo

<FM>Declaration<FC>
procedure Undo(AutoRedo:boolean=false);

<FM>Description<FN>
This method makes the last Undo buffer as the current image.
When AutoRedo is true the current state (before redo) is saved in redo stack.
!!}
procedure TImageEnProc.Undo(AutoRedo:boolean);
begin
  UndoAt(0,AutoRedo);
end;

{!!
<FS>TImageEnProc.UndoAt

<FM>Declaration<FC>
procedure UndoAt(Position:integer; AutoRedo:boolean=false);

<FM>Description<FN>
UndoAt restores the image at Position in the Undo stack.
Position: 0=last saved undo, 1=before last saved undo,  2...  up to <A TImageEnProc.UndoCount>-1
When <FC>AutoRedo<FN> is <FC>true<FN> the current state (before redo) is saved in redo-stack.
!!}
procedure TImageEnProc.UndoAt(Position: integer; AutoRedo:boolean);
var
  uc: integer;
  obj: TObject;
  ms: TMemoryStream;
  src: TIEUndoSource;
  guid:TGuid;
  ieview:TImageEnView;
  i,l,sz:integer;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  uc := fUndoList.Count;
  if (uc > 0) and (Position < uc) then
  begin
    src := TIEUndoSource(fUndoSource[uc-1-Position]);
    obj := fUndoList[uc-1-Position];
    if AutoRedo then
      SaveRedo(src);
    case src of
      ieuImage:
        begin
          // is an image
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) and (integer(TIEBitmap(obj).UndoInfo)>=0) then
          begin
            with (fImageEnView as TImageEnView) do
              Layers[ imin(imax(integer(TIEBitmap(obj).UndoInfo),0),LayersCount-1) ].Bitmap.Assign( TIEBitmap(obj) );
          end
          else
            fIEBitmap.Assign(TIEBitmap(obj));
          Update;
        end;
      ieuSelection:
        begin
          // is a selection
          ms := TMemoryStream(obj);
          ms.Position := 0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
            (fImageEnView as TImageEnView).LoadSelectionFromStream(ms,iersMoveToAdapt);
        end;
      ieuObject:
        begin
          // is a TImageEnVect object/s
          ms := TMemoryStream(obj);
          ms.Position:=0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
            (fImageEnView as TImageEnVect).LoadFromStreamIEV(ms);
        end;
      ieuLayer, ieuFullLayer:
        begin
          // is a layer info block
          ms := TMemoryStream(obj);
          ms.Position:=0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
          begin
            ieview:=fImageEnView as TImageEnView;
            while ms.Position<ms.Size do
            begin
              l:=ms.Position;
              ms.Read(sz,sizeof(integer));
              ms.Read(Guid,sizeof(TGuid));
              for i:=0 to ieview.LayersCount-1 do
                if CompareGUID(ieview.layers[i].GUID,Guid) then
                begin
                  ms.Position:=l;
                  ieview.Layers[i].LoadInfo(ms);
                  l:=-1;  // found!
                  break;
                end;
              if l<>-1 then
                ms.Position:=l+sz;  // not found, bypass
            end;
            ieview.Update;
          end;
        end;
      ieuObjectsAndLayers:
        begin
          // objects and layers
          ms := TMemoryStream(obj);
          ms.Position:=0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
            (fImageEnView as TImageEnVect).LoadFromStreamALL(ms)
          else if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
            (fImageEnView as TImageEnView).LayersLoadFromStream(ms);
        end;
    end;
  end;
end;

{!!
<FS>TImageEnProc.UndoRect

<FM>Declaration<FC>
procedure UndoRect(x1, y1, x2, y2:integer);

<FM>Description<FN>
This is like <A TImageEnProc.Undo> but restores only the specified rectangle.
This is useful when you are performing interactive user drawing like in icon editor example or 'brush' example.
!!}
// works only with images
procedure TImageEnProc.UndoRect(x1, y1, x2, y2:integer);
var
  uc: integer;
  obj: TObject;
  src: TIEUndoSource;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  uc := fUndoList.Count;
  if (uc > 0) then
  begin
    obj := fUndoList[uc-1];
    src := TIEUndoSource(fUndoSource[uc-1]);
    if src=ieuImage then
    begin
      // it is an image
      OrdCor(x1,y1,x2,y2);
      TIEBitmap(obj).CopyRectTo(fIEBitmap,x1,y1,x1,y1,x2-x1+1,y2-y1+1);
      if TIEBitmap(obj).HasAlphaChannel then
        TIEBitmap(obj).AlphaChannel.CopyRectTo(fIEBitmap.AlphaChannel,x1,y1,x1,y1,x2-x1+1,y2-y1+1);
      Update;
    end;
  end;
end;

{!!
<FS>TImageEnProc.UndoPeekAt

<FM>Declaration<FC>
function UndoPeekAt(Position:integer):<A TIEUndoSource>;

<FM>Description<FN>
UndoPeekAt returns the type of undo located at Position. It can be an image or a selection.
!!}
function TImageEnProc.UndoPeekAt(Position: integer): TIEUndoSource;
begin
  if (Position >= 0) and (Position < fUndoList.Count) then
    result:=TIEUndoSource(fUndoSource[Position])
  else
    result:=ieuUnknown;
end;

{!!
<FS>TImageEnProc.RedoPeekAt

<FM>Declaration<FC>
function RedoPeekAt(Position:integer):<A TIEUndoSource>;

<FM>Description<FN>
RedoPeekAt returns the type of redo located at Position. It can be an image or a selection.
!!}
function TImageEnProc.RedoPeekAt(Position: integer): TIEUndoSource;
begin
  if (Position >= 0) and (Position < fRedoList.Count) then
    result:=TIEUndoSource(fRedoSource[Position])
  else
    result:=ieuUnknown;
end;

{!!
<FS>TImageEnProc.Redo

<FM>Declaration<FC>
procedure Redo;

<FM>Description<FN>
Makes last Redo buffer as current image.
!!}
procedure TImageEnProc.Redo;
begin
  RedoAt(0);
end;

{!!
<FS>TImageEnProc.RedoAt

<FM>Declaration<FC>
procedure RedoAt(Position:integer);

<FM>Description<FN>
RedoAt restores the image at Position in the redo-stack.

Position: 0=last saved redo, 1=before last saved redo, 2...  up to <A TImageEnProc.RedoCount>-1.
!!}
procedure TImageEnProc.RedoAt(Position: integer);
var
  uc: integer;
  obj: TObject;
  src: TIEUndoSource;
  ms: TMemoryStream;
  guid:TGuid;
  ieview:TImageEnView;
  i,l,sz:integer;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  uc := fRedoList.Count;
  if (uc > 0) and (Position < uc) then
  begin
    obj := fRedoList[uc-1-Position];
    src := TIEUndoSource(fRedoSource[uc-1-Position]);
    case src of
      ieuImage:
        begin
          // is an image
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) and (integer(TIEBitmap(obj).UndoInfo)>=0) then
          begin
            with (fImageEnView as TImageEnView) do
              Layers[ imin(imax(integer(TIEBitmap(obj).UndoInfo),0),LayersCount-1) ].Bitmap.Assign( TIEBitmap(obj) );
          end
          else
            fIEBitmap.Assign(TIEBitmap(obj));
          Update;
        end;
      ieuSelection:
        begin
          // is a selection
          ms := TMemoryStream(obj);
          ms.Position := 0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
            (fImageEnView as TImageEnView).LoadSelectionFromStream(ms,iersMoveToAdapt);
        end;
      ieuObject:
        begin
          // is a TImageEnVect object/s
          ms := TMemoryStream(obj);
          ms.Position:=0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
            (fImageEnView as TImageEnVect).LoadFromStreamIEV(ms);
        end;
      ieuLayer, ieuFullLayer:
        begin
          // is a layer info block
          ms := TMemoryStream(obj);
          ms.Position:=0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
          begin
            ieview:=fImageEnView as TImageEnView;
            while ms.Position<ms.Size do
            begin
              l:=ms.Position;
              ms.Read(sz,sizeof(integer));
              ms.Read(Guid,sizeof(TGuid));
              for i:=0 to ieview.LayersCount-1 do
                if CompareGUID(ieview.layers[i].GUID,Guid) then
                begin
                  ms.Position:=l;
                  ieview.Layers[i].LoadInfo(ms);
                  l:=-1;  // found!
                  break;
                end;
              if l<>-1 then
                ms.Position:=l+sz;  // not found, bypass
            end;
            ieview.Update;
          end;
        end;
      ieuObjectsAndLayers:
        begin
          // objects and layers
          ms := TMemoryStream(obj);
          ms.Position:=0;
          if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
            (fImageEnView as TImageEnVect).LoadFromStreamALL(ms)
          else if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
            (fImageEnView as TImageEnView).LayersLoadFromStream(ms);
        end;
    end;
  end;
end;

// remove specified undo
{!!
<FS>TImageEnProc.ClearUndoAt

<FM>Declaration<FC>
procedure ClearUndoAt(Position:integer);

<FM>Description<FN>
ClearUndoAt removes the image at Position in the undo-stack.

Position: 0=last saved undo, 1=before last saved undo,  2...  up to <A TImageEnProc.UndoCount>-1.
!!}
procedure TImageEnProc.ClearUndoAt(Position: integer);
var
  uc: integer;
begin
  uc := fUndoList.Count;
  if (uc > 0) and (Position < uc) then
  begin
    TObject(fUndoList[uc - 1 - Position]).free;
    fUndoList.delete(uc - 1 - Position);
    fUndoSource.delete(uc-1-Position);
    fUndoCaptions.delete(uc - 1 - Position);
  end;
end;

{!!
<FS>TImageEnProc.CanUndo

<FM>Declaration<FC>
property CanUndo:boolean;

<FM>Description<FN>
CanUndo is True when the undo-buffer contains an image.

<A TImageEnProc.ClearAllUndo> or <A TImageEnProc.ClearUndo> if there is only one saved image, sets CanUndo to false.

<FM>Example<FC>

If ImageEnView1.Proc.CanUndo then
  ImageEnView1.Proc.Undo
else
  ShowMessage('Can''t undo');
!!}
function TImageEnProc.GetCanUndo: boolean;
begin
  result := fUndoList.Count > 0;
end;

{!!
<FS>TImageEnProc.CanRedo

<FM>Declaration<FC>
property CanRedo:boolean;

<FM>Description<FN>
CanRedo is True when the Redo buffer contains an image.
!!}
function TImageEnProc.GetCanRedo: boolean;
begin
  result := fRedoList.Count > 0;
end;

{!!
<FS>TImageEnProc.UndoCount

<FM>Declaration<FC>
property UndoCount:integer;

<FM>Description<FN>
UndoCount returns how many images there are in the undo-stack.
!!}
function TImageEnProc.GetUndoCount: integer;
begin
  result := fUndoList.Count;
end;

{!!
<FS>TImageEnProc.RedoCount

<FM>Declaration<FC>
property RedoCount:integer;

<FM>Description<FN>
RedoCount returns how many images there are in the redo-stack.
!!}
function TImageEnProc.GetRedoCount: integer;
begin
  result := fRedoList.Count;
end;

procedure TImageEnProc.SetUndoCaptions(index: integer; const Value: string);
begin
  if (index >= 0) and (index < fUndoCaptions.Count) then
    fUndoCaptions[fUndoCaptions.Count - index - 1] := Value;
end;

{!!
<FS>TImageEnProc.UndoCaptions

<FM>Declaration<FC>
property UndoCaptions[index:integer]:string;

<FM>Description<FN>
Applications can associate a string with saved images in the undo-stack. All ImageEn image processing functions save a little description of the last task performed.
The UndoCaptions property is useful to build a list of Undo/Redo with description of the all functions executed.
Index: 0=last saved undo, 1=before last saved undo,  2...  up to <A TImageEnProc.UndoCount>-1

<FM>Example<FC>
// works only when AutoUndo=True and UndoLimit=2
ImageEnView1.Proc.Contrast(10);
ImageEnView1.Proc.Negative;
ShowMessage( ImageEnView1.Proc.UndoCaptions[ 0 ] );	// this shows 'Negative'
ShowMessage( ImageEnView1.Proc.UndoCaptions[ 1 ] );	// this shows 'Contrast 10'
!!}
function TImageEnProc.GetUndoCaptions(index: integer): string;
begin
  if (index >= 0) and (index < fUndoCaptions.Count) then
    result := fUndoCaptions[fUndoCaptions.Count - index - 1];
end;

{!!
<FS>TImageEnProc.RedoCaptions

<FM>Declaration<FC>
property RedoCaptions[index:integer]:string;

<FM>Description<FN>
Applications can associate a string to a saved image in the redo-stack. All ImageEn image processing functions save a little description (RedoCaptions) of the last task performed.
This property is useful to build a list of Undo/Redo with description of the all functions executed.
Index: 0=last saved redo, 1=before last saved redo, 2...  up to <A TImageEnProc.RedoCount>-1
!!}
function TImageEnProc.GetRedoCaptions(index: integer): string;
begin
  if (index >= 0) and (index < fRedoCaptions.Count) then
    result := fRedoCaptions[fRedoCaptions.Count - index - 1];
end;

{!!
<FS>TImageEnProc.SaveUndo

<FM>Declaration<FC>
procedure SaveUndo(Source:<A TIEUndoSource>=ieuImage);

<FM>Description<FN>
This method saves the current image in the undo-buffer list.

Source specifies if the image (ieuImage), the selected region (ieuSelection) or vectorial objects (ieuObject) is saved or layers info (ieuLayer)
!!}
procedure TImageEnProc.SaveUndo(Source: TIEUndoSource);
//
  procedure SaveUndoObject(obj: TObject);
  begin
    while fUndoList.Count >= fUndoLimit do
    begin
      TObject(fUndoList[0]).free;
      fUndoList.delete(0);
      fUndoSource.delete(0);
      fUndoCaptions.delete(0);
    end;
    fUndoList.Add(obj);
    fUndoSource.Add(pointer(Source));
    fUndoCaptions.Add('');
  end;
var
  ieb: TIEBitmap;
  ms: TMemoryStream;
  ieview:TImageEnView;
  i:integer;
begin
  if fUndoLimit=0 then
    exit;
  case Source of
    ieuImage:
      begin
        // save the bitmap
        if not MakeConsistentBitmap([]) then
          exit;
        if (fIEBitmap.Width > 1) and (fIEBitmap.Height > 1) then
        begin
          ieb := TIEBitmap.Create;
          ieb.MinFileSize := 0;
          ieb.Location := fUndoLocation;
          ieb.Assign(fIEBitmap);
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
            ieb.UndoInfo:=pointer((fImageEnView as TImageEnView).LayersCurrent)
          else
            ieb.UndoInfo:=pointer(-1);
          SaveUndoObject(ieb);
        end;
      end;
    ieuSelection:
      begin
        // save the selection (if connected to TImageEnView)
        if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
        begin
          ms := TMemoryStream.Create;
          (fImageEnView as TImageEnView).SaveSelectionToStream(ms);
          SaveUndoObject(ms);
        end;
      end;
    ieuObject:
      begin
        // save object, if fImageEnView is a TImageEnVect.
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
        begin
          ms := TMemoryStream.Create;
          (fImageEnView as TImageEnVect).SaveToStreamIEV(ms);
          SaveUndoObject(ms);
        end;
      end;
    ieuLayer, ieuFullLayer:
      begin
        // save layer info
        if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
        begin
          ieview:=fImageEnView as TImageEnView;
          ms := TMemoryStream.Create;
          for i:=0 to ieview.LayersCount-1 do
            ieview.Layers[i].SaveInfo(ms, (Source=ieuFullLayer) and (i=ieview.LayersCurrent));
          SaveUndoObject(ms);
        end;
      end;
    ieuObjectsAndLayers:
      begin
        // layers and objects
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
        begin
          ms := TMemoryStream.Create;
          (fImageEnView as TImageEnVect).SaveToStreamALL(ms);
          SaveUndoObject(ms);
        end
        else if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
        begin
          ms := TMemoryStream.Create;
          (fImageEnView as TImageEnView).LayersSaveToStream(ms, -2);
          SaveUndoObject(ms);
        end;
      end;
  end;
  if assigned(fOnSaveUndo) then
    fOnSaveUndo(self,Source);
end;

{!!
<FS>TImageEnProc.SaveRedo

<FM>Declaration<FC>
procedure SaveRedo(Source:<A TIEUndoSource>=ieuImage);

<FM>Description<FN>
SaveRedo saves the current image in the redo-buffer list.

Source specifies if the image (ieuImage), the current selection (ieuSelection) or vectorial objects (ieuObject) or layer is to be saved.
!!}
procedure TImageEnProc.SaveRedo(Source: TIEUndoSource);
//
  procedure SaveRedoObject(obj: TObject);
  begin
    while fRedoList.Count >= fUndoLimit do
    begin
      TObject(fRedoList[0]).free;
      fRedoList.delete(0);
      fRedoSource.delete(0);
      fRedoCaptions.delete(0);
    end;
    fRedoList.Add(obj);
    fRedoSource.Add(pointer(Source));
    fRedoCaptions.Add('');
  end;
var
  ieb: TIEBitmap;
  ms: TMemoryStream;
  ieview:TImageEnView;
  i:integer;
begin
  if fUndoLimit=0 then
    exit;
  case Source of
    ieuImage:
      begin
        // save the bitmap
        if not MakeConsistentBitmap([]) then
          exit;
        if (fIEBitmap.Width > 1) and (fIEBitmap.Height > 1) then
        begin
          ieb := TIEBitmap.Create;
          ieb.MinFileSize := 0;
          ieb.Location := fUndoLocation;
          ieb.Assign(fIEBitmap);
          if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
            ieb.UndoInfo:=pointer((fImageEnView as TImageEnView).LayersCurrent)
          else
            ieb.UndoInfo:=pointer(-1);
          SaveRedoObject(ieb);
        end;
      end;
    ieuSelection:
      // save the selection (if connected to TImageEnView)
      if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
      begin
        ms := TMemoryStream.Create;
        (fImageEnView as TImageEnView).SaveSelectionToStream(ms);
        SaveRedoObject(ms);
      end;
    ieuObject:
      begin
        // save object, if fImageEnView is a TImageEnVect.
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
        begin
          ms := TMemoryStream.Create;
          (fImageEnView as TImageEnVect).SaveToStreamIEV(ms);
          SaveRedoObject(ms);
        end;
      end;
    ieuLayer, ieuFullLayer:
      begin
        // save layer info
        if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
        begin
          ieview:=fImageEnView as TImageEnView;
          ms := TMemoryStream.Create;
          for i:=0 to ieview.LayersCount-1 do
            ieview.Layers[i].SaveInfo(ms, (Source=ieuFullLayer) and (i=ieview.LayersCurrent));
          SaveRedoObject(ms);
        end;
      end;
    ieuObjectsAndLayers:
      begin
        // layers and objects
        if assigned(fImageEnView) and (fImageEnView is TImageEnVect) then
        begin
          ms := TMemoryStream.Create;
          (fImageEnView as TImageEnVect).SaveToStreamALL(ms);
          SaveRedoObject(ms);
        end
        else if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
        begin
          ms := TMemoryStream.Create;
          (fImageEnView as TImageEnView).LayersSaveToStream(ms, -2);
          SaveRedoObject(ms);
        end;
      end;
  end;
end;

{!!
<FS>TImageEnProc.SaveRedoCaptioned

<FM>Declaration<FC>
procedure SaveRedoCaptioned(const Caption:string; Source:<A TIEUndoSource>=ieuImage);

<FM>Description<FN>
SaveRedoCaptioned is like <A TImageEnProc.SaveRedo>, but allows specification of a description associated to the saved image.

Source specifies if the image (ieuImage), the current selection (ieuSelection) or vectorial objects (ieuObject) or layer is to be saved.
!!}
procedure TImageEnProc.SaveRedoCaptioned(const Caption: string; Source: TIEUndoSource);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.Width > 1) and (fIEBitmap.Height > 1) then
  begin
    SaveRedo(Source);
    fRedoCaptions[fRedoList.Count - 1] := Caption;
  end;
end;

{!!
<FS>TImageEnProc.SaveUndoCaptioned

<FM>Declaration<FC>
procedure SaveUndoCaptioned(const Caption:string; Source:<A TIEUndoSource>=ieuImage);

<FM>Description<FN>
SaveUndoCaptioned  is like <A TImageEnProc.SaveUndo>, but allows specifying a description associated to the saved image.
Source specifies if the image (ieuImage), the current selection (ieuSelection) or vectorial objects (ieuObject) or layer is to be saved.

<FM>Example<FC>
ImageEnView1.Proc.SaveUndoCaptioned('Negative and contrast');
ImageEnView1.Proc.Negative;
ImageEnView1.Proc.Contrast(5);
!!}
procedure TImageEnProc.SaveUndoCaptioned(const Caption: string; Source: TIEUndoSource);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.Width > 1) and (fIEBitmap.Height > 1) then
  begin
    SaveUndo(Source);
    fUndoCaptions[fUndoList.Count - 1] := Caption;
  end;
end;

{!!
<FS>TImageEnProc.UndoLimit

<FM>Declaration<FC>
property UndoLimit:integer;

<FM>Description<FN>
UndoLimit specifies how many images can be saved using the <A TImageEnProc.SaveUndo> method. Default is 1.

When you call <A TImageEnProc.SaveUndo> ImageEn pushes the current image in an image stack.
Calling <A TImageEnProc.Undo> ImageEn restore last saved image.
Calling <A TImageEnProc.ClearUndo> ImageEn removes last saved image.
!!}
procedure TImageEnProc.SetUndoLimit(v: integer);
begin
  fUndoLimit := v;
end;

// Undo/Redo
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

function TImageEnProc.CheckFormat(allowedFormats: TIEPixelFormatSet):boolean;
const
  MAXDEST=6;
  TConvSource:array [TIEPixelFormat] of array [0..MAXDEST] of TIEPixelFormat=
    ( (ienull,ienull,ienull,ienull,ienull,ienull,ienull),     // ienull
      (ie8g,ie16g,ie32f,ie24RGB,ienull,ienull,ienull),        // ie1g
      (ie24RGB,ieCMYK,ie48RGB,ieCIELab,ienull,ienull,ienull), // ie8p
      (ie16g,ie32f,ie24RGB,ieCMYK,ie48RGB,ienull,ienull),     // ie8g
      (ie32f,ie8g,ie48RGB,ie24RGB,ieCMYK,ienull,ienull),      // ie16g
      (ieCMYK,ieCIELab,ie48RGB,ie8p,ie16g,ie8g,ienull),       // ie24RGB
      (ie16g,ie8g,ie24RGB,ie48RGB,ieCIELab,ienull,ienull),    // ie32f
      (ie24RGB,ie48RGB,ieCIELab,ie8g,ienull,ienull,ienull),   // ieCMYK
      (ie24RGB,ieCMYK,ieCIELab,ie16g,ienull,ienull,ienull),   // ie48RGB
      (ie24RGB,ieCMYK,ie48RGB,ie8g,ienull,ienull,ienull),     // ieCIELab
      (ie24RGB,ieCMYK,ie48RGB,ie8g,ienull,ienull,ienull)      // ie32RGB
    );
var
  i:integer;
  l:TIEPixelFormat;
begin
  result:= (allowedFormats = []) or (fIEBitmap.PixelFormat in allowedFormats);
  if not result and fAutoConvertFormat then
  begin
    // convert to one allowed format
    // try according to TConvSource table
    for i:=0 to MAXDEST do
    begin
      l:=TConvSource[fIEBitmap.PixelFormat, i];
      if l in allowedFormats then
      begin
        fIEBitmap.PixelFormat:=l;
        result:=true;
        break;
      end;
    end;
    // try the first format available
    if l=ienull then
    begin
      for l:=high(TIEPixelFormat) downto low(TIEPixelFormat) do
        if l in allowedFormats then
        begin
          fIEBitmap.PixelFormat:=l;
          result:=true;
          break;
        end;
    end;
  end;
end;

function TImageEnProc.MakeConsistentBitmap(allowedFormats: TIEPixelFormatSet): boolean;
begin
  result := false;
  if not assigned(fIEBitmap) then
    exit;
  if assigned(fBitmap) then
    fIEBitmap.EncapsulateTBitmap(fBitmap, false); // synchronize fBitmap with fIEBitmap
  result:=CheckFormat(allowedFormats);
end;


//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
// Convolution

type

  TConvolveSharedFields = record
    kernel:PDoubleArray;
    factor:double;
    bitmap:TIEBitmap;
    ksize:integer;
    newbmp:TIEBitmap;
    coXMap:pintegerarray;  // map of X coordinates
    coYMap:pintegerarray;  // map of Y coordinates
    bitmapMaxX, bitmapMaxY:integer;
    OnProgress:TIEProgressEvent;
    Sender:TObject;
  end;

  TConvolveThread = class(TThread)
  private
    sharedFields:TConvolveSharedFields;
    x1, y1, x2, y2:integer;
    threadIndex:integer;
    percentage:integer;
  public
    procedure Execute; override;
    constructor Create(x1_, y1_, x2_, y2_:integer; const sharedFields_:TConvolveSharedFields; threadIndex_:integer);
    procedure DoProgress;
  end;

constructor TConvolveThread.Create(x1_, y1_, x2_, y2_:integer; const sharedFields_:TConvolveSharedFields; threadIndex_:integer);
begin
  inherited Create(true);
  x1 := x1_;
  y1 := y1_;
  x2 := x2_;
  y2 := y2_;
  sharedFields := sharedFields_;
  threadIndex := threadIndex_;
end;

procedure TConvolveThread.DoProgress;
begin
  sharedFields.OnProgress(sharedFields.Sender, percentage);
end;

procedure TConvolveThread.Execute();
var
  row, col, kpos:integer;
  new_r, new_g, new_b:double;
  real_col, real_row:integer;
  px_src:PRGB;
  px_dst:PRGB;
  kern:pdouble;
  lper:integer;
begin
  lper := -1;
  for row:=y1 to y2 do
  begin
    px_dst := sharedFields.newbmp.Scanline[row];
    inc(px_dst, x1);
    for col:=x1 to x2 do
    begin
      new_r := 0.0;
      new_g := 0.0;
      new_b := 0.0;
      kern := pdouble(sharedFields.kernel);
      for kpos:=0 to sharedFields.ksize-1 do
      begin
        real_row := row + sharedFields.coYMap[kpos];
        if real_row<0 then real_row := 0 else if real_row>sharedFields.bitmapMaxY then real_row := sharedFields.bitmapMaxY;
        real_col := col + sharedFields.coXMap[kpos];
        if real_col<0 then real_col := 0 else if real_col>sharedFields.bitmapMaxX then real_col := sharedFields.bitmapMaxX;
        px_src := sharedFields.bitmap.Scanline[real_row];
        inc(px_src, real_col);
        with px_src^ do
        begin
          new_r := new_r + kern^ * r;
          new_g := new_g + kern^ * g;
          new_b := new_b + kern^ * b;
        end;
        inc(kern);
      end;
      with px_dst^ do
      begin
        r := blimit(round(sharedFields.factor * new_r));
        g := blimit(round(sharedFields.factor * new_g));
        b := blimit(round(sharedFields.factor * new_b));
      end;
      inc(px_dst);
    end;
    if (threadIndex=0) and assigned(sharedFields.OnProgress) then
    begin
      percentage := trunc(row/(y2-y1)*100);
      if percentage<>lper then
      begin
        lper := percentage;
        Synchronize(DoProgress);
      end;
    end;
  end;
  sharedFields.newbmp.CopyRectTo(sharedFields.bitmap, x1, y1, x1, y1, x2-x1+1, y2-y1+1);
end;



// kernelWidth and kernelHeight must be odd and >=3
procedure IEConvolve(bitmap:TIEBitmap; kernel:array of double; kernelWidth, kernelHeight:integer; factor:double; x1, y1, x2, y2:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
  row, col, kpos:integer;
  threads:TIEThreadPool;
  threadsCount:integer;
  rowsPerThread:integer;
  ty1, ty2:integer;
  i:integer;
  sharedFields:TConvolveSharedFields;
begin

  // check parameters
  if (Bitmap.Pixelformat<>ie24RGB) or (factor=0) then
    exit;

  x2 := imin(x2, bitmap.Width); dec(x2);
  y2 := imin(y2, bitmap.Height); dec(y2);

  sharedFields.kernel := @kernel[0];
  sharedFields.ksize := kernelWidth*kernelHeight;
  sharedFields.factor := factor;
  sharedFields.bitmap := bitmap;
  sharedFields.bitmapMaxX := bitmap.Width-1;
  sharedFields.bitmapMaxY := bitmap.Height-1;
  sharedFields.OnProgress := fOnProgress;
  sharedFields.Sender := Sender;

  // build coXMap and coYMap (kernel linear coordinates to kernel X,Y coordinates)
  getmem(sharedFields.coXMap, sharedFields.ksize * sizeof(integer));
  getmem(sharedFields.coYMap, sharedFields.ksize * sizeof(integer));
  kpos := 0;
  for row:=-(kernelHeight div 2) to (kernelHeight div 2) do
    for col:=-(kernelWidth div 2) to (kernelWidth div 2) do
    begin
      sharedFields.coXMap[kpos] := col;
      sharedFields.coYMap[kpos] := row;
      inc(kpos);
    end;

  sharedFields.newbmp := TIEBitmap.Create(bitmap.Width, bitmap.Height, ie24RGB);

  if bitmap.Location = ieFile then
    threadsCount := 1
  else
    threadsCount := IEGetCoresCount();

  threads := TIEThreadPool.Create;
  rowsPerThread := (y2-y1) div threadsCount;
  ty1 := y1;
  ty2 := y1 + rowsPerThread;
  for i:=0 to threadsCount-1 do
  begin
    threads.Add( TConvolveThread.Create(x1, ty1, x2, ty2, sharedFields, i) );
    ty1 := ty2 + 1;
    if i = threadsCount-2 then
      ty2 := y2 // last thread gets up to y2 (does not apply when threadsCount=1)
    else
      ty2 := ty1 + rowsPerThread;
  end;
  threads.Join();
  threads.Free;

  sharedFields.newbmp.Free;
  freemem(sharedFields.coXMap);
  freemem(sharedFields.coYMap);

end;

{!!
<FS>TImageEnProc.Convolve

<FM>Declaration<FC>
procedure Convolve(Kernel:array of double; KernelWidth, KernelHeight:integer; Factor:double);

<FM>Description<FN>
Convolves the specified kernel over the selected region.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Kernel<FN></C> <C>The convolution kernel (just a matrix made array).</C> </R>
<R> <C><FC>KernelWidth<FN></C> <C>The kernel matrix width (number of columns).</C> </R>
<R> <C><FC>KernelHeight<FN></C> <C>The kernel matrix height (number of rows).</C> </R>
<R> <C><FC>Factor<FN></C> <C>Multiplication factor.</C> </R>
</TABLE>


<FM>Example<FC>

// performs "blur" effect, using 3x3 kernel
ImageEnView.Proc.Convolve([0.0, 1.0, 0.0,
                           1.0, 1.0, 1.0,
                           0.0, 1.0, 0.0],
                           3, 3, 1/5);

// performs "blur" effect using 5x5 kernel
ImageEnView.Proc.Convolve([0.0, 0.0, 1.0, 0.0, 0.0,
                           0.0, 1.0, 1.0, 1.0, 0.0,
                           1.0, 1.0, 1.0, 1.0, 1.0,
                           0.0, 1.0, 1.0, 1.0, 0.0,
                           0.0, 0.0, 1.0, 0.0, 0.0],
                           5, 5, 1/13);

!!}
procedure TImageEnProc.Convolve(Kernel:array of double; KernelWidth, KernelHeight:integer; Factor:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_CONVOLVE, ProcBitmap, mask) then
    exit;
  IEConvolve(ProcBitmap, Kernel, KernelWidth, KernelHeight, factor, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


// Convolution
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

function IEAverageRGB(bitmap:TIEBitmap; mask:TIEMask; x1, y1, x2, y2:integer):TRGB;
var
  row, col:integer;
  px:PRGB;
  ar, ag, ab:double;
  pixelsCount:integer;
begin
  // check parameters
  if (Bitmap.Pixelformat<>ie24RGB) then
    exit;

  x2 := imin(x2, bitmap.Width); dec(x2);
  y2 := imin(y2, bitmap.Height); dec(y2);

  ar := 0.0;
  ag := 0.0;
  ab := 0.0;
  pixelsCount := 0;

  for row:=y1 to y2 do
  begin
    px := bitmap.Scanline[row];
    inc(px, x1);
    for col:=x1 to x2 do
    begin
      if not assigned(mask) or mask.IsEmpty or mask.IsPointInside(col+mask.X1, row+mask.Y1) then
      begin
        with px^ do
        begin
          ar := ar + r;
          ag := ag + g;
          ab := ab + b;
        end;
        inc(pixelsCount);
      end;
      inc(px);
    end;
  end;

  if pixelsCount<>0 then
  begin
    result.r := trunc(ar / pixelsCount);
    result.g := trunc(ag / pixelsCount);
    result.b := trunc(ab / pixelsCount);
  end
  else
    result := CreateRGB(0,0,0);
end;



{!!
<FS>TImageEnProc.CalcAverageRGB

<FM>Declaration<FC>
function CalcAverageRGB():TRGB;

<FM>Description<FN>
Returns the average RGB values inside the selected area.

<FM>Example<FC>

// fill the selected are with the average
ImageEnView.Proc.Fill( ImageEnView.Proc.CalcAverageRGB() );
!!}
function TImageEnProc.CalcAverageRGB():TRGB;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  result := CreateRGB(0, 0, 0);
  if not BeginImageAnalysis([ie24RGB], x1, y1, x2, y2, ProcBitmap, mask) then
    exit;
  result := IEAverageRGB(ProcBitmap, mask, x1, y1, x2, y2);
  EndImageAnalysis(ProcBitmap);
  DoFinishWork;
end;


//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////


// Apply filter inside the specified area
// fSel.. in bitmap coordinates
procedure _ApplyFilter(bitmap: TIEBitmap; filter: TGraphFilter; fSelx1, fSely1, fSelx2, fSely2: integer; var Progress: TProgressRec);
var
  x, y: integer;
  newbitmap: TIEBitmap;
  mxh: integer;
  l1, l2, l3: pRGBROW;
  lr1, lr3: integer;
  px: pRGB;
  xl, xr, q, w: integer;
  multix: array[0..8, 0..255] of integer;
  bitmapwidth1: integer;
  lper, per:integer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width); dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  if filter.divisor = 0 then
    filter.divisor := 1;
  // calc multix
  with filter do
    for q := 0 to 255 do
    begin
      w := 0;
      for x := 0 to 2 do
        for y := 0 to 2 do
        begin
          multix[w][q] := Values[x][y] * q;
          inc(w);
        end;
    end;
  //
  newbitmap := TIEBitmap.create;
  newbitmap.Allocate(bitmap.Width, bitmap.Height, ie24RGB);
  mxh := bitmap.Height - 1;
  Progress.per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  lper := -1;
  bitmapwidth1 := bitmap.width - 1;
  for y := fSelY1 to fSelY2 do
  begin
    lr1 := ilimit(y - 1, 0, mxh);
    l1 := PRGBROW(bitmap.GetRow(lr1));
    l2 := PRGBROW(bitmap.GetRow(y));
    lr3 := ilimit(y + 1, 0, mxh);
    l3 := PRGBROW(bitmap.GetRow(lr3));
    px := PRGB(newbitmap.Scanline[y]);
    inc(px, fSelX1);
    for x := fSelX1 to fSelX2 do
      with filter do
      begin
        xl := imax(x - 1, 0);
        xr := imin(x + 1, bitmapwidth1);
        px^.r := blimit(abs(multix[0, l1[xl].r] + multix[1, l1[x].r] + multix[2, l1[xr].r] +
          multix[3, l2[xl].r] + multix[4, l2[x].r] + multix[5, l2[xr].r] +
          multix[6, l3[xl].r] + multix[7, l3[x].r] + multix[8, l3[xr].r]) div Divisor);
        px^.g := blimit(abs(multix[0, l1[xl].g] + multix[1, l1[x].g] + multix[2, l1[xr].g] +
          multix[3, l2[xl].g] + multix[4, l2[x].g] + multix[5, l2[xr].g] +
          multix[6, l3[xl].g] + multix[7, l3[x].g] + multix[8, l3[xr].g]) div Divisor);
        px^.b := blimit(abs(multix[0, l1[xl].b] + multix[1, l1[x].b] + multix[2, l1[xr].b] +
          multix[3, l2[xl].b] + multix[4, l2[x].b] + multix[5, l2[xr].b] +
          multix[6, l3[xl].b] + multix[7, l3[x].b] + multix[8, l3[xr].b]) div Divisor);
        inc(px);
      end;
    with Progress do
      if assigned(fOnProgress) then
      begin
        per := trunc(per1 * (y - fSelY1 + 1));
        if per<>lper then
        begin
          fOnProgress(Sender, per);
          lper := per;
        end;
      end;
    bitmap.FreeRow(lr3);
    bitmap.FreeRow(y);
    bitmap.FreeRow(lr1);
  end;
  newbitmap.CopyRectTo(bitmap, fSelX1, fSelY1, fSelX1, fSelY1, fSelX2 - fSelX1 + 1, fSelY2 - fSelY1 + 1);
  FreeAndNil(newbitmap);
end;

procedure _ApplyFilter8g(bitmap: TIEBitmap; filter: TGraphFilter; fSelx1, fSely1, fSelx2, fSely2: integer);
var
  x, y: integer;
  newbitmap: TIEBitmap;
  mxh: integer;
  l1, l2, l3: pbytearray;
  lr1, lr3: integer;
  px: pbyte;
  xl, xr, q, w: integer;
  multix: array[0..8, 0..255] of integer;
  bitmapwidth1: integer;
begin
  if Bitmap.Pixelformat <> ie8g then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width); dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  if filter.divisor = 0 then
    filter.divisor := 1;
  // calc multix
  with filter do
    for q := 0 to 255 do
    begin
      w := 0;
      for x := 0 to 2 do
        for y := 0 to 2 do
        begin
          multix[w][q] := Values[x][y] * q;
          inc(w);
        end;
    end;
  //
  newbitmap := tiebitmap.create;
  newbitmap.Allocate(bitmap.width, bitmap.height, ie8g);
  mxh := bitmap.Height - 1;
  bitmapwidth1 := bitmap.width - 1;
  for y := fSely1 to fSely2 do
  begin
    lr1 := ilimit(y - 1, 0, mxh);
    l1 := pbytearray(bitmap.GetRow(lr1));
    l2 := pbytearray(bitmap.GetRow(y));
    lr3 := ilimit(y + 1, 0, mxh);
    l3 := pbytearray(bitmap.GetRow(lr3));
    px := pbyte(newbitmap.Scanline[y]);
    inc(px, fSelX1);
    for x := fSelx1 to fSelx2 do
      with filter do
      begin
        xl := imax(x - 1, 0);
        xr := imin(x + 1, bitmapwidth1);
        px^ := blimit(abs(multix[0, l1[xl]] + multix[1, l1[x]] + multix[2, l1[xr]] +
          multix[3, l2[xl]] + multix[4, l2[x]] + multix[5, l2[xr]] +
          multix[6, l3[xl]] + multix[7, l3[x]] + multix[8, l3[xr]]) div Divisor);
        inc(px);
      end;
    bitmap.FreeRow(lr3);
    bitmap.FreeRow(y);
    bitmap.FreeRow(lr1);
  end;
  newbitmap.CopyRectTo(bitmap, fSelX1, fSelY1, fSelX1, fSelY1, fSelX2 - fSelX1 + 1, fSelY2 - fSelY1 + 1);
  FreeAndNil(newbitmap);
end;

{!!
<FS>TImageEnProc.ApplyFilter

<FM>Declaration<FC>
procedure ApplyFilter(filter: <A TGraphFilter>);

<FM>Description<FN>
This method applies a 3x3 filter to the current image (or to selected region).

<FM>Example<FC>

// apply emboss filter
Const
  filter:TGraphFilter= (Values:( (-1,0,1), (-1,1,1),(-1,0,1) ); Divisor:1);
Begin
  ImageEnView1.Proc.ApplyFilter(filter);
End;
!!}
procedure TImageEnProc.ApplyFilter(filter: TGraphFilter);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
  Progress: TProgressRec;
begin
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_APPLYFILTER, ProcBitmap, mask) then
    exit;
  _ApplyFilter(ProcBitmap, filter, x1, y1, x2, y2, Progress);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// changes HSL
// fSel.. are in bitmap coordinates
// oHue [-180,+180]
// oSat,oLum [-100,+100]
procedure _HSLvar(bitmap: TIEBitmap; oHue, oSat, oLum: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  Hue, Sat, Lum, doHue, doSat, doLum: double;
  ppx: pRGB;
  per1: double;
begin
  if bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width); dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  doHue := oHue / 360;
  doSat := oSat / 100;
  doLum := oLum / 100;
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for y := fSelY1 to fSelY2 do
  begin
    ppx := bitmap.ScanLine[y];
    inc(ppx, fSelx1);
    for x := fSelX1 to fSelX2 do
    begin
      RGB2HSL(ppx^, Hue, Sat, Lum);
      HSL2RGB(ppx^, Hue + doHue, Sat + doSat, Lum + doLum);
      inc(ppx);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;


{!!
<FS>TImageEnProc.HSLvar

<FM>Declaration<FC>
procedure HSLvar(oHue, oSat, oLum: integer);

<FM>Description<FN>
This method changes Hue, Saturation and Luminosity of the selected region.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>oHue<FN></C> <C>Offset to add to the Hue channel, from -180 to +180.</C> </R>
<R> <C><FC>oSat<FN></C> <C>Offset to add to the Saturation channel, from -100 to +100.</C> </R>
<R> <C><FC>oLum<FN></C> <C>Offset to add to the Luminosity channel, from -100 to +100.</C> </R>
</TABLE>

<FM>Example<FC>
ImageEnView1.Proc.HSLVar(0,-100,0); // convert to gray
ImageEnView1.Proc.HSLVar(0,0,30); 	  // increase luminosity
!!}
// Change sHSL inside the specified selection
// fSel.. are in bitmap coordinates
// oHue [-180,+180]
// oSat,oLum [-100,+100]
procedure TImageEnProc.HSLvar(oHue, oSat, oLum: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_HSLVAR, [oHue, oSat, oLum]), ProcBitmap, mask) then
    exit;
  _HSLvar(ProcBitmap, oHue, oSat, oLum, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Changes HSV inside the specified selection
// fSel.. are in bitmap coordinates
procedure _HSVvar(bitmap: TIEBitmap; oHue, oSat, oVal: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  Hue, Sat, Val: integer;
  ppx: pRGB;
  per1: double;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width); dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for y := fSely1 to fSely2 do
  begin
    ppx := bitmap.ScanLine[y];
    inc(ppx, fSelx1);
    for x := fSelx1 to fSelx2 do
    begin
      RGB2HSV(ppx^, Hue, Sat, Val);
      HSV2RGB(ppx^, Hue + oHue, Sat + oSat, Val + oVal);
      inc(ppx);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;

{!!
<FS>TImageEnProc.HSVvar

<FM>Declaration<FC>
procedure HSVvar(oHue, oSat, oVal: integer);

<FM>Description<FN>
This method changes Hue, Saturation and Value of the selected region.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>oHue<FN></C> <C>Offset to add to the Hue channel, from -180 to +180.</C> </R>
<R> <C><FC>oSat<FN></C> <C>Offset to add to the Saturation channel, from -100 to +100.</C> </R>
<R> <C><FC>oVal<FN></C> <C>Offset to add to the Value channel, from -100 to +100.</C> </R>
</TABLE>

<FM>Example<FC>
ImageEnView1.Proc.HSVvar(0,-100,0); // convert to gray
ImageEnView1.Proc.HSVvar(0,0,30);   // increase luminosity/brightness
!!}
procedure TImageEnProc.HSVvar(oHue, oSat, oVal: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_HSVVAR, [oHue, osat, oVal]), ProcBitmap, mask) then
    exit;
  _HSVvar(ProcBitmap, oHue, oSat, oVal, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// returns current background color

function TImageEnProc.GetReBackground: TColor;
begin
  if assigned(fImageEnView) then
    result := fImageEnView.background
  else
    result := fBackground;
end;

{!!
<FS>TImageEnProc.Background

<FM>Declaration<FC>
property Background: TColor;

<FM>Description<FN>
This property specifies the background color.
The background color is the color shown in the unoccupied area when the current image is less than the control's size.
This color is used also in geometric processing (such as rotation) to fill blank areas.

When TImageEnProc is attached to <A TImageEnView>, the TImageEnProc.Background is equal to TImageEnView.<A TImageEnView.Background>.
!!}
procedure TImageEnProc.SetReBackground(v: TColor);
begin
  if assigned(fImageEnView) then
    fImageEnView.background := v
  else
    fBackground := v;
end;


{!!
<FS>TImageEnProc.GetReSel

<FM>Declaration<FC>
function GetReSel(var fsX1, fsY1, fsX2, fsY2:integer; var PolySel:<A PPointArray>; var PolySelCount:integer; var mask:<A TIEMask>):boolean;

<FM>Description<FN>
The GetReSel function returns the selected area. Returns False if there isn't a selected area.
!!}
// return selected area (bitmap coordinates)
// return true when there is a selected area
// note: x2,y2 are the bottom/right side plus 1
function TImageEnProc.GetReSel(var fsX1, fsY1, fsX2, fsY2: integer; var PolySel: PPointArray; var PolySelCount: integer; var mask: TIEMask): boolean;
var
  ImageEnView: TImageEnView;
begin
  if assigned(fBitmap) then
    fIEBitmap.EncapsulateTBitmap(fBitmap, false); // synchronize fBitmap with fIEBitmap
  PolySelCount := 0;
  mask := nil;
  // default apply full image
  fSX1 := 0;
  fSY1 := 0;
  fSX2 := fiebitmap.width;
  fSY2 := fiebitmap.height;
  result := false;
  //
  if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
  begin
    // get selection from TImageEnView
    ImageEnView := fImageEnView as TImageEnView;
    mask := ImageEnView.SelectionMask;
    if ImageEnView.Selected then
    begin
      if not mask.IsEmpty then
      begin
        fSX1 := mask.X1;
        fSY1 := mask.Y1;
        fSX2 := mask.X2 + 1;
        fSY2 := mask.Y2 + 1;
      end;
      PolySel := ImageEnView.PolySelPoints;
      PolySelCount := ImageEnView.PolySelCount;
      result := true;
    end;
  end;
end;

{!!
<FS>TImageEnProc.ApplyFilterPreset

<FM>Declaration<FC>
procedure ApplyFilterPreset(filter:<A TIEFilterPresets>);

<FM>Description<FN>
ApplyFilterPreset  applies a preset filter to the current image.

TIEFilterPresets is defined as integer and can be one of following constants:
  fpNone
  fpBlur
  fpEdge
  fpEmboss
  fpHighPass1
  fpHighPass2
  fpHighPass3
  fpLowPass1
  fpLowPass2

<FM>Example<FC>
ImageEnView1.Proc.ApplyFilterPreset(fpEdge);
!!}
procedure TImageEnProc.ApplyFilterPreset(filter: TIEFilterPresets);
begin
  ApplyFilter(PIEGraphFilter(IEFiltPres[filter])^);
end;

// clockwise rotate by 90 degrees
procedure _Rot90oEx(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
var
  x, y: integer;
  dx, dy: integer;
  newpx, oldpx: pRGB;
begin
  dx := bakbmp.width;
  dy := bakbmp.Height;
  newbitmap.Allocate(dy, dx, bakbmp.PixelFormat);
  for x := 0 to dx - 1 do
  begin
    newpx := newbitmap.ScanLine[x];
    for y := 0 to dy - 1 do
    begin
      oldpx := bakbmp.scanline[dy - y - 1];
      inc(oldpx, x);
      newpx^ := oldpx^;
      inc(newpx);
    end;
  end;
end;

// accept ie8g and ie8p

procedure _Rot90oEx8(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
var
  x, y: integer;
  dx, dy: integer;
  newpx, oldpx: pbyte;
begin
  dx := bakbmp.width;
  dy := bakbmp.Height;
  newbitmap.Allocate(dy, dx, bakbmp.PixelFormat);
  for x := 0 to dx - 1 do
  begin
    newpx := newbitmap.ScanLine[x];
    for y := 0 to dy - 1 do
    begin
      oldpx := bakbmp.scanline[dy - y - 1];
      inc(oldpx, x);
      newpx^ := oldpx^;
      inc(newpx);
    end;
  end;
end;

// rotates counter-clockwise by 90 degrees
procedure _Rot90Ex(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
var
  x, y: integer;
  dx, dy: integer;
  newpx, oldpx: pRGB;
begin
  dx := bakbmp.width;
  dy := bakbmp.Height;
  newbitmap.Allocate(dy, dx, bakbmp.PixelFormat);
  for x := 0 to dx - 1 do
  begin
    newpx := newbitmap.ScanLine[dx - x - 1];
    for y := 0 to dy - 1 do
    begin
      oldpx := bakbmp.scanline[y];
      inc(oldpx, x);
      newpx^ := oldpx^;
      inc(newpx);
    end;
  end;
end;

// accept ie8g and ie8p

procedure _Rot90Ex8(bakbmp: TIEBitmap; newbitmap: TIEBitmap);
var
  x, y: integer;
  dx, dy: integer;
  newpx, oldpx: pbyte;
begin
  dx := bakbmp.width;
  dy := bakbmp.Height;
  newbitmap.Allocate(dy, dx, bakbmp.PixelFormat);
  for x := 0 to dx - 1 do
  begin
    newpx := newbitmap.ScanLine[dx - x - 1];
    for y := 0 to dy - 1 do
    begin
      oldpx := bakbmp.scanline[y];
      inc(oldpx, x);
      newpx^ := oldpx^;
      inc(newpx);
    end;
  end;
end;

// resize the bitmap without loss its content

{!!
<FS>TImageEnProc.ImageResize

<FM>Declaration<FC>
procedure ImageResize(newWidth, newHeight: integer; HorizAlign:<A TIEHAlign>=iehLeft; VertAlign:<A TIEVAlign>=ievTop; FillAlpha:integer=255);

<FM>Description<FN>
This method resizes the current image to newWidth and newHeight. The content of the image doesn't change (no stretch).

HorizAlign specifies the horizontal alignment of the old image.
VertAlign specifies the vertical alignment of the old image.
FillAlpha specifies the transparency to use on added areas.

<FM>Example<FC>

ImageEnView1.Proc.ImageResize(1000,1000); // resize fimage to 1000x1000

ImageEnView1.Proc.ImageResize(1000,1000, iehCenter, ievCenter);  // make a contour around the image
!!}
procedure TImageEnProc.ImageResize(newWidth, newHeight: integer; HorizAlign: TIEHAlign; VertAlign: TIEVAlign; FillAlpha:integer);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (newWidth = 0) or (newHeight = 0) or ((newWidth=fIEBitmap.Width) and (newHeight=fIEBitmap.Height)) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned('ImageResize ' + IntToStr(newWidth) + ',' + IntToStr(newHeight), ieuImage);
  if (fIEBitmap.Width < 2) and (fIEBitmap.Height < 2) then
    // image empty
    Clear;
  if FillAlpha<255 then
    fIEBitmap.AlphaChannel; // creates alpha channel if not present
  fIEBitmap.Resize(newWidth, newHeight, GetReBackground, FillAlpha, HorizAlign, VertAlign);
  Update;
  DoFinishWork;
end;

// h,s,l (Hue Saturation Luminosity) from 0 to 1

procedure RGB2HSL(px: TRGB; var Hue, Sat, Lum: double);
var
  delta, r, g, b, cmax, cmin: double;
begin
  r := px.r / 255;
  g := px.g / 255;
  b := px.b / 255;
  cmax := dmax(r, dmax(g, b));
  cmin := dmin(r, dmin(g, b));
  Lum := (cmax + cmin) / 2;
  if cmax = cmin then
  begin
    Sat := 0;
    Hue := 0;
  end
  else
  begin
    if Lum < 0.5 then
      Sat := (cmax - cmin) / (cmax + cmin)
    else
      Sat := (cmax - cmin) / (2 - cmax - cmin);
    delta := cmax - cmin;
    if r = cmax then
      Hue := (g - b) / delta
    else if g = cmax then
      Hue := 2 + (b - r) / delta
    else
      Hue := 4 + (r - g) / delta;
    Hue := Hue / 6;
    if Hue < 0 then
      Hue := Hue + 1;
  end;
end;

// iHue,iSat,iLum 0..1

procedure HSL2RGB(var px: TRGB; iHue, iSat, iLum: double);
  function HueToRGB(m1, m2, h: double): double;
  const
    C1 = 2 / 3;
  begin
    if h < 0 then
      h := h + 1
    else if h > 1 then
      h := h - 1;
    if 6 * h < 1 then
      result := (m1 + (m2 - m1) * h * 6)
    else if 2 * h < 1 then
      result := m2
    else if 3 * h < 2 then
      result := (m1 + (m2 - m1) * (C1 - h) * 6)
    else
      result := m1;
  end;
const
  C1 = 1 / 3;
var
  r, g, b: double;
  m1, m2: double;
begin
  // check limits
  if iHue < 0 then
    iHue := 1 + iHue
  else if iHue > 1 then
    iHue := iHue - 1;
  if iSat < 0 then
    iSat := 0
  else if iSat > 1 then
    iSat := 1;
  if iLum < 0 then
    iLum := 0
  else if iLum > 1 then
    iLum := 1;
  //
  if iSat = 0 then
  begin
    r := iLum;
    g := iLum;
    b := iLum;
  end
  else
  begin
    if iLum <= 0.5 then
      m2 := iLum * (1 + iSat)
    else
      m2 := iLum + iSat - iLum * iSat;
    m1 := 2 * iLum - m2;
    r := HueToRGB(m1, m2, iHue + C1);
    g := HueToRGB(m1, m2, iHue);
    b := HueToRGB(m1, m2, iHue - C1);
  end;
  px.r := blimit(round(r * 255));
  px.g := blimit(round(g * 255));
  px.b := blimit(round(b * 255));
end;

// HSV to RGB.
//    H = 0 to 359 (corresponding to 0..359 degrees around hexcone)
//    S = 0 (shade of gray) to 99 (pure color)
//    V = 0 (black) to 99 {white)
//
//    Based on C Code in "Computer Graphics -- Principles and Practice,"
//    Foley et al, 1996, p. 594.  Floating point fractions, 0..1, replaced with
//    integer values, 0..99.

procedure HSV2RGB(var px: TRGB; H, S, V: integer);
const
  divisor: INTEGER = 99 * 60;
var
  f: INTEGER;
  hTemp: INTEGER;
  p, q, t: INTEGER;
  VS: INTEGER;
begin
  // check limits (changed at 2.1.1)
  if H < 0 then
    H := 360 + H
  else if H > 359 then
    H := H - 360;
  if S < 0 then
    S := 0
  else if S > 99 then
    S := 99;
  if V < 0 then
    V := 0
  else if V > 99 then
    V := 99;
  //
  if S = 0 then
  begin
    px.r := v;
    px.g := v;
    px.b := v;
  end
  else
  begin
    if H = 360 then
      hTemp := 0
    else
      hTemp := H;
    f := hTemp mod 60;
    hTemp := hTemp div 60;
    VS := V * S;
    p := V - VS div 99;
    q := V - (VS * f) div divisor;
    t := V - (VS * (60 - f)) div divisor;
    with px do
    begin
      case hTemp of
        0:
          begin
            R := V;
            G := t;
            B := p
          end;
        1:
          begin
            R := q;
            G := V;
            B := p
          end;
        2:
          begin
            R := p;
            G := V;
            B := t
          end;
        3:
          begin
            R := p;
            G := q;
            B := V
          end;
        4:
          begin
            R := t;
            G := p;
            B := V
          end;
        5:
          begin
            R := V;
            G := p;
            B := q
          end;
      end
    end
  end;
  px.r := round(px.r / 99 * 255);
  px.g := round(px.g / 99 * 255);
  px.b := round(px.b / 99 * 255);
end;

// RGB, each 0 to 255, to HSV.
//   H = 0 to 359 (corresponding to 0..359 degrees around hexcone)
//   S = 0 (shade of gray) to 99 (pure color)
//   V = 0 (black) to 99 {white)
//
//   Based on C Code in "Computer Graphics -- Principles and Practice,"
//   Foley et al, 1996, p. 592.  Floating point fractions, 0..1, replaced with
//   integer values, 0..99.

procedure RGB2HSV(RGB: TRGB; var h, s, v: integer);
  procedure MinMax3(const i, j, k: integer; var min, max: integer);
  begin
    if i > j then
    begin
      if i > k then
        max := i
      else
        max := k;
      if j < k then
        min := j
      else
        min := k
    end
    else
    begin
      if j > k then
        max := j
      else
        max := k;
      if i < k then
        min := i
      else
        min := k
    end;
  end;
var
  Delta: integer;
  MinValue: integer;
  r, g, b: integer;
begin
  r := round(RGB.r / 255 * 99);
  g := round(RGB.g / 255 * 99);
  b := round(RGB.b / 255 * 99);
  MinMax3(R, G, B, MinValue, V);
  Delta := V - MinValue;
  if V = 0 then
    S := 0
  else
    S := (99 * Delta) div V;
  if S = 0 then
    H := 0
  else
  begin
    if R = V then
      h := (60 * (G - B)) div Delta
    else if G = V then
      h := 120 + (60 * (B - R)) div Delta
    else if B = V then
      h := 240 + (60 * (R - G)) div Delta;
    if H < 0 then
      H := H + 360;
  end;
end;

// read filter file 3x3 version 1
function LoadFilterFromFile(const FileName: string): TGraphFilter;
var
  bb, dx, dy: byte;
  fr: TFileStream;
begin
  fr := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  fr.Read(bb, 1); // version
  fr.Read(dx, 1); // width (byte) = 3
  fr.Read(dy, 1); // height (byte) = 3
  if (bb <> 1) or (dx <> 3) or (dy <> 3) then
    FreeAndNil(fr)
  else
  begin
    // load
    fr.read(result, sizeof(TGraphFilter));
    FreeAndNil(fr);
  end;
end;

// write 3x3 filter (version 1)
procedure SaveFilterToFile(const FileName: string; const filt: TGraphFilter);
var
  bb: byte;
  fw: TFileStream;
begin
  fw := TFileStream.Create(FileName, fmCreate);
  bb := 1;
  fw.Write(bb, 1); // v.1
  bb := 3;
  fw.Write(bb, 1);
  fw.Write(bb, 1); // 3x3
  fw.Write(filt, sizeof(TGraphFilter));
  FreeAndNil(fw);
end;

// applies contrast to the specified area
(*
procedure _ContrastRGB(bitmap: TIEBitmap; vv: integer; mR, mG, mB: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  vi: integer;
  x, y: integer;
  ppx: pRGB;
  per1: double;
  LUTR:array [0..255] of byte;
  LUTG:array [0..255] of byte;
  LUTB:array [0..255] of byte;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  if vv >= 0 then
    vi := trunc((1 + vv / 10) * 65536)
  else
    vi := trunc((1 - sqrt(-vv) / 10) * 65536);

  for x:=0 to 255 do
  begin
    LUTR[x]:=blimit(mR + (((x - mR) * vi) div 65536));
    LUTG[x]:=blimit(mG + (((x - mG) * vi) div 65536));
    LUTB[x]:=blimit(mB + (((x - mB) * vi) div 65536));
  end;

  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for y := fSely1 to fSely2 do
  begin
    ppx := bitmap.ScanLine[y];
    inc(ppx, fSelX1);
    for x := fSelX1 to fSelX2 do
    begin
      with ppx^ do
      begin
        r := LUTR[r];
        g := LUTG[g];
        b := LUTB[b];
      end;
      inc(ppx);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;
//*)
procedure _ContrastRGB(bitmap: TIEBitmap; vv: double; mR, mG, mB: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  vi: double;
  x, y: integer;
  ppx: pRGB;
  per1: double;
  LUTR:array [0..255] of byte;
  LUTG:array [0..255] of byte;
  LUTB:array [0..255] of byte;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  if vv >= 0 then
    vi := 1 + vv / 10
  else
    vi := 1 - sqrt(-vv) / 10;

  for x:=0 to 255 do
  begin
    LUTR[x]:=blimit( round( mR + ((x - mR) * vi) ) );
    LUTG[x]:=blimit( round( mG + ((x - mG) * vi) ) );
    LUTB[x]:=blimit( round( mB + ((x - mB) * vi) ) );
  end;

  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for y := fSely1 to fSely2 do
  begin
    ppx := bitmap.ScanLine[y];
    inc(ppx, fSelX1);
    for x := fSelX1 to fSelX2 do
    begin
      with ppx^ do
      begin
        r := LUTR[r];
        g := LUTG[g];
        b := LUTB[b];
      end;
      inc(ppx);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;


{!!
<FS>TImageEnProc.ConvertToGray

<FM>Declaration<FC>
procedure ConvertToGray;

<FM>Description<FN>
This method converts selected region to gray levels. The image always will be in true color (16M of colors).
When <A TImageEnView.LegacyBitmap> is True, ImageEn can handle only black/white (pf1bit) or true color images (pf24bit).
ConvertToGray just set R,G,B channels to the same value.

<FM>Example<FC>

ImageEnView1.Proc.ConvertToGray;
!!}
procedure TImageEnProc.ConvertToGray;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_CONVERTTOGRAY, ProcBitmap, mask) then
    exit;
  _ConvertToGray(ProcBitmap, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Merges selected area of "bitmap" with the full DBitmap
// pcf: merge percentage (100=all of bitmap, 0=all of DBitmap)
// DBitmap will be resized to the specified selection
procedure _Merge(bitmap: TIEBitmap; DBitmap: TIEBitmap; pcf: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  ppx, ppx2: pRGB;
  per1: double;
  bitmap2: TIEBitmap;
  c1, c2: double;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  //
  bitmap2 := TIEBitmap.Create;
  bitmap2.Allocate(fSelX2 - fSelX1 + 1, fSelY2 - fSelY1 + 1, ie24RGB);
  _IEBmpStretchEx(DBitmap, bitmap2, nil, nil);
  //
  per1 := 100 / (fSelY2 - fSelY1 + 0.5); // progress
  c1 := pcf / 100;
  c2 := (100 - pcf) / 100;
  for y := fSelY1 to fSelY2 do
  begin
    ppx := bitmap.ScanLine[y];
    ppx2 := bitmap2.ScanLine[y - fSelY1];
    inc(ppx, fSelX1);
    for x := fSelX1 to fSelX2 do
    begin
      ppx^.r := blimit(round(ppx^.r * c1 + ppx2^.r * c2));
      ppx^.g := blimit(round(ppx^.g * c1 + ppx2^.g * c2));
      ppx^.b := blimit(round(ppx^.b * c1 + ppx2^.b * c2));
      inc(ppx);
      inc(ppx2);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
  FreeAndNil(bitmap2);
end;

{!!
<FS>TImageEnProc.MergeIEBitmap

<FM>Declaration<FC>
procedure MergeIEBitmap(DBitmap:<A TIEBitmap>; pcf:integer);

<FM>Description<FN>
MergeIEBitmap merges the current image with a specified bitmap (like Merge but works with TIEBitmap instead of TBitmap).

DBitmap is the bitmap to merge with the current image.
pcf is the percentage of current image (100=only current image, 0=only DBitmap).
!!}
procedure TImageEnProc.MergeIEBitmap(DBitmap: TIEBitmap; pcf: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_MERGE, [pcf]), ProcBitmap, mask) then
    exit;
  _Merge(ProcBitmap, Dbitmap, pcf, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.Merge

<FM>Declaration<FC>
procedure Merge(DBitmap: TBitmap; pcf: integer);

<FM>Description<FN>
The Merge method merges the current image with a specified bitmap.

DBitmap is the bitmap to merge with current image.
pcf is the percentage of current image (100=only current image, 0=only DBitmap).

<FM>Example<FC>

// Merge 50% of ImageEn2 with ImageEn1
ImageEnView1.Proc.Merge( ImageEnView2.Bitmap, 50 );
!!}
procedure TImageEnProc.Merge(DBitmap: TBitmap; pcf: integer);
var
  iebmp: TIEBitmap;
begin
  iebmp := TIEBitmap.Create;
  iebmp.EncapsulateTBitmap(DBitmap, true);
  MergeIEBitmap(iebmp, pcf);
  FreeAndNil(iebmp);
  DoFinishWork;
end;

// sets a color range to a specified color
procedure _CastColorRange(bitmap: TIEBitmap; BeginColor, EndColor, CastColor: TRGB; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  e: pRGB;
  per1: double;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for y := fSely1 to fSely2 do
  begin
    e := bitmap.ScanLine[y];
    inc(e, fSelx1);
    for x := fSelx1 to fSelx2 do
    begin
      if (e^.r >= BeginColor.r) and (e^.g >= BeginColor.g) and (e^.b >= BeginColor.b) and
        (e^.r <= EndColor.r) and (e^.g <= EndColor.g) and (e^.b <= EndColor.b) then
        e^ := CastColor;
      inc(e);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;

// Performs threshold
// Assign DownVal to all pixels which have values less than DownLimit and
// UpVal to all pixels upper than UpLimit.
procedure IEApplyThreshold(bitmap: TIEBitmap; DownLimit, UpLimit, DownVal, UpVal: TRGB; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  e: pRGB;
  per1: double;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  if EqualRGB(DownLimit, CreateRGB(0, 0, 0)) and EqualRGB(UpLimit, CreateRGB(255, 255, 255)) then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for y := fSely1 to fSely2 do
  begin
    e := bitmap.ScanLine[y];
    inc(e, fSelx1);
    for x := fSelx1 to fSelx2 do
    begin
      if (e^.r <= DownLimit.r) then
        e^.r := DownVal.r;
      if (e^.g <= DownLimit.g) then
        e^.g := DownVal.g;
      if (e^.b <= DownLimit.b) then
        e^.b := DownVal.b;
      if (e^.r > UpLimit.r) then
        e^.r := UpVal.r;
      if (e^.g > UpLimit.g) then
        e^.g := UpVal.g;
      if (e^.b > UpLimit.b) then
        e^.b := UpVal.b;
      inc(e);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;


{!!
<FS>TImageEnProc.Threshold

<FM>Declaration<FC>
procedure Threshold(DownLimit, UpLimit, DownVal, UpVal: <A TRGB>);

<FM>Description<FN>
The Threshold method assigns the DownVal color to all colors smaller or equal to DownLimit, and UpVal to all colors greater than UpLimit.
!!}
// Performs threshold
// look at _Threshold
procedure TImageEnProc.Threshold(DownLimit, UpLimit, DownVal, UpVal: TRGB);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_THRESHOLD, ProcBitmap, mask) then
    exit;
  IEApplyThreshold(ProcBitmap, DownLimit, UpLimit, DownVal, UpVal, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


procedure IEThreshold2(bitmap: TIEBitmap; LoThreshold, HiThreshold:integer; Red,Green,Blue:boolean; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  LoKonstant:double;
  HiKonstant:double;
  x,y:integer;
  RGB:PRGB;
  per1:double;
  LUT:array [0..255] of byte;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;

  if LoThreshold = 0 then
    LoKonstant := 255
  else
    LoKonstant := 255 / LoThreshold;

  if HiThreshold = 0 then
    HiKonstant := 255
  else
    HiKonstant := 255 / HiThreshold;

  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);

  // calculates the LUT
  for x:=0 to 255 do
  begin
    LUT[x]:=blimit(trunc( x + ((255 - x) / LoKonstant) ));
    if LUT[x]>LoThreshold then
      LUT[x]:=trunc(LUT[x]/HiKonstant);
  end;

  for y := fSely1 to fSely2 do
  begin
    RGB:=bitmap.Scanline[y];
    for x := fSelx1 to fSelx2 do
    begin
      with RGB^ do
      begin
        if Red then
          r := LUT[r];
        if Green then
          g := LUT[g];
        if Blue then
          b := LUT[b];
      end;
      inc(RGB);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;

end;

{!!
<FS>TImageEnProc.Threshold2

<FM>Declaration<FC>
procedure Threshold2(LoThreshold, HiThreshold:integer; Red, Green, Blue:boolean);

<FM>Description<FN>
This is a variant of original Threshold algorithm.
LoThreshold and HiThreshold specify the low and high pixel value.
Red, Green and Blue specify where to apply the threshold operation.
!!}
procedure TImageEnProc.Threshold2(LoThreshold, HiThreshold:integer; Red, Green, Blue:boolean);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_THRESHOLD2, ProcBitmap, mask) then
    exit;
  IEThreshold2(ProcBitmap, LoThreshold, HiThreshold, Red,Green,Blue, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


{!!
<FS>TImageEnProc.HistAutoEqualize

<FM>Declaration<FC>
procedure HistAutoEqualize;

<FM>Description<FN>
This method equalizes the colors histogram of the selected region.

<FM>Example<FC>

ImageEnView1.Proc.HistAutoEqualize;
!!}
procedure TImageEnProc.HistAutoEqualize;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_HISTAUTOEQUALIZE, ProcBitmap, mask) then
    exit;
  _HistAutoEqualize(ProcBitmap, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Automatically equalizes the image histogram
procedure _HistAutoEqualize(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y, i, mxh, xl, xr: integer;
  e, s: pRGB;
  per1: double;
  Hist: THistogram;
  Left, Right: array[0..255] of integer;
  current: integer;
  newbitmap: TIEBitmap;
  average: TRGB;
  gaverage: integer;
  l1, l2, l3: pRGBROW;
  i1, i3: integer;
  g: integer;
  bitmapwidth1: integer;
  n_av, total: double;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  _GetHistogram(bitmap, @Hist, 0, 0, bitmap.width - 1, bitmap.height - 1, nil);
  n_av := bitmap.width * bitmap.height / 256;
  //
  current := 0;
  total := 0;
  for i := 0 to 255 do
  begin
    left[i] := blimit(current);
    total := total + Hist[i].gray;
    while total > n_av do
    begin
      total := total - n_av;
      inc(current);
    end;
    right[i] := blimit(current);
  end;
  //
  mxh := bitmap.Height - 1;
  newbitmap := TIEBitmap.create;
  newbitmap.Allocate(bitmap.width, bitmap.height, ie24RGB);
  bitmapwidth1 := bitmap.width - 1;
  for y := fSely1 to fSely2 do
  begin
    e := bitmap.GetRow(y);
    s := newbitmap.ScanLine[y];
    inc(e, fSelx1);
    inc(s, fSelx1);
    i1 := ilimit(y - 1, 0, mxh);
    l1 := bitmap.GetRow(i1);
    l2 := pRGBROW(e);
    i3 := ilimit(y + 1, 0, mxh);
    l3 := bitmap.GetRow(i3);
    for x := fSelx1 to fSelx2 do
    begin
      xl := imax(x - 1, 0);
      xr := imin(x + 1, bitmapwidth1);
      average.r := blimit((l1[xl].r + l1[x].r + l1[xr].r +
        l2[xl].r + l2[x].r + l2[xr].r +
        l3[xl].r + l3[x].r + l3[xr].r) div 9);
      average.g := blimit((l1[xl].g + l1[x].g + l1[xr].g +
        l2[xl].g + l2[x].g + l2[xr].g +
        l3[xl].g + l3[x].g + l3[xr].g) div 9);
      average.b := blimit((l1[xl].b + l1[x].b + l1[xr].b +
        l2[xl].b + l2[x].b + l2[xr].b +
        l3[xl].b + l3[x].b + l3[xr].b) div 9);
      gaverage := (average.r * gRedToGrayCoef + average.g * gGreenToGrayCoef + average.b * gBlueToGrayCoef) div 100;
      g := (e^.r * gRedToGrayCoef + e^.g * gGreenToGrayCoef + e^.b * gBlueToGrayCoef) div 100;
      //
      if left[g] = right[g] then
      begin
        s^.r := left[e^.r];
        s^.g := left[e^.g];
        s^.b := left[e^.b];
      end
      else
      begin
        if gaverage > right[g] then
        begin
          s^.r := right[e^.r];
          s^.g := right[e^.g];
          s^.b := right[e^.b];
        end
        else if gaverage < left[g] then
        begin
          s^.r := left[e^.r];
          s^.g := left[e^.g];
          s^.b := left[e^.b];
        end
        else
        begin
          s^.r := average.r;
          s^.g := average.g;
          s^.b := average.b;
        end;
      end;
      //
      inc(e);
      inc(s);
    end;
    bitmap.FreeRow(y);
    bitmap.FreeRow(i1);
    bitmap.FreeRow(i3);
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
  newbitmap.CopyRectTo(bitmap, fSelX1, fSelY1, fSelX1, fSelY1, (fSelX2 - fSelX1 + 1), (fSelY2 - fSelY1 + 1));
  FreeAndNil(newbitmap);
end;

{!!
<FS>TImageEnProc.HistEqualize

<FM>Declaration<FC>
procedure HistEqualize(LoThresh, HiThresh: <A TRGB>);

<FM>Description<FN>
This method equalizes the colors histogram of the selected region in the range LoThresh and HiThresh.

<FM>Example<FC>

// Compress the color histogram in the range LoThresh to HiThresh
var
  LoThresh, HiThresh:TRGB;
Begin
  LoThresh:=CreateRGB(50,50,50);
  HiThresh:=CreateRGB(150,150,150);
  ImageEnView1.Proc.HistEqualize(LoThresh,HiThresh);
End;
!!}
procedure TImageEnProc.HistEqualize(LoThresh, HiThresh: TRGB);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_HISTEQUALIZE, ProcBitmap, mask) then
    exit;
  IEHistEqualize(ProcBitmap, LoThresh, HiThresh, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Equalize Histogram
procedure IEHistEqualize(bitmap: TIEBitmap; LoThresh, HiThresh: TRGB; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y, q: integer;
  e: pRGB;
  per1: double;
  LoMap, HiMap: THistogram;
  dx: integer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  HiThresh.r := imax(HiThresh.r, 1);
  HiThresh.g := imax(HiThresh.g, 1);
  HiThresh.b := imax(HiThresh.b, 1);
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  if equalrgb(LoThresh, HiThresh) then
    exit;
  for q := 0 to 255 do
  begin
    // work on LoThreh
    dx := 255 - LoThresh.r;
    if dx = 0 then
      dx := 1;
    LoMap[q].r := blimit(round(((q - LoThresh.r) / dx) * 255));
    dx := 255 - LoThresh.g;
    if dx = 0 then
      dx := 1;
    LoMap[q].g := blimit(round(((q - LoThresh.g) / dx) * 255));
    dx := 255 - LoThresh.b;
    if dx = 0 then
      dx := 1;
    LoMap[q].b := blimit(round(((q - LoThresh.b) / dx) * 255));
    // work on HiThresh
    HiMap[q].r := blimit(round((q / HiThresh.r) * 255));
    HiMap[q].g := blimit(round((q / HiThresh.g) * 255));
    HiMap[q].b := blimit(round((q / HiThresh.b) * 255));
  end;
  for y := fSely1 to fSely2 do
  begin
    e := bitmap.ScanLine[y];
    inc(e, fSelx1);
    for x := fSelx1 to fSelx2 do
    begin
      e^.r := LoMap[e^.r].r;
      e^.r := HiMap[e^.r].r;
      e^.g := LoMap[e^.g].g;
      e^.g := HiMap[e^.g].g;
      e^.b := LoMap[e^.b].b;
      e^.b := HiMap[e^.b].b;
      //
      inc(e);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;

// execute preview dialog
{$IFDEF IEINCLUDEDIALOGIP}

{!!
<FS>TImageEnProc.DoPreviews

<FM>Declaration<FC>
function DoPreviews(pe: <A TPreviewEffects> = [peAll]; IsResizeable:boolean=true; FormWidth:integer=-1; FormHeight:integer=-1; FormLeft:integer=-1; FormTop:integer=-1): boolean;

<FM>Description<FN>
This method executes the image processing preview dialog.
When IsResizeable is true then user can resize the dialog.
FormWidth and FormHeight controls the initial form size. -1 = default value.
FormLeft and FormTop controls the initial form position. -1 = default value (centered).

pe is the set of the image effects to show in the dialog.

There are two constants for color adjustment and general effect sets:
  <A ppeColorAdjust>
  <A ppeEffects>


<FM>Example<FC>

ImageEnView1.Proc.DoPreviews([peAll]); // show all effects
ImageEnView1.Proc.DoPreviews([peContrast,peUserFilt]); // show contrast and user filters
ImageEnView1.Proc.DoPreviews(ppeColorAdjust);
ImageEnView1.Proc.DoPreviews(ppeEffects);
!!}
function TImageEnProc.DoPreviews(pe: TPreviewEffects; IsResizeable:boolean; FormWidth:integer; FormHeight:integer; FormLeft:integer; FormTop:integer): boolean;
var
  fPreviews: TfPreviews;
  x1, y1, x2, y2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  mask: TIEMask;
begin
  result := false;
  if assigned(fImageEnView) then
    fImageEnView.GetCanvas.Lock;
  try
    if not MakeConsistentBitmap([]) then
      exit;
    if (fIEBitmap.Width < 2) and (fIEBitmap.Height < 2) then
      exit;
    GetReSel(x1, y1, x2, y2, fPolyS, fPolySCount, mask);
    fPreviews := TfPreviews.Create(self);
    if IsResizeable then
    begin
      fPreviews.BorderIcons:=[biSystemMenu,biMaximize];
      fPreviews.BorderStyle:=bsSizeable;
    end
    else
    begin
      fPreviews.BorderIcons:=[biSystemMenu];
      fPreviews.BorderStyle:=bsDialog;
    end;
    fPreviews.ImageEn1.Background := Background;
    fPreviews.ImageEn2.Background := Background;
    if FormWidth>0 then
      fPreviews.Width := FormWidth
    else
      fPreviews.Width := trunc(536*(fPreviews.PixelsPerInch/96));
    if FormHeight>0 then
      fPreviews.Height:= FormHeight
    else
      fPreviews.Height := trunc(421*(fPreviews.PixelsPerInch/96));
    if (FormLeft>=0) or (FormTop>=0) then
    begin
      fPreviews.Left:=FormLeft;
      fPreviews.Top:=FormTop;
      fPreviews.Position:=poDesigned;
    end
    else
      fPreviews.Position:=poScreenCenter;
    fPreviews.DefaultLockPreview := prppDefaultLockPreview in PreviewsParams;
    fPreviews.ShowReset := prppShowResetButton in PreviewsParams;
    fPreviews.HardReset := prppHardReset in PreviewsParams;
    fPreviews.ResetAllTabs := not (prppResetSelectedTab in PreviewsParams);
    fPreviews.SetLanguage(fMsgLanguage);
    fPreviews.Font.assign(fPreviewFont);
    fPreviews.Progress.fOnProgress := fOnProgress;
    fPreviews.Progress.Sender := self;
    fPreviews.ImageEn1.LegacyBitmap:=false;
    fPreviews.OpenDialog1.InitialDir := fFiltersInitialDir;
    fPreviews.SaveDialog1.InitialDir := fFiltersInitialDir;
    with fPreviews do
    begin
      ImageEn1.IEBitmap.Allocate( (x2 - x1), (y2 - y1), fIEBitmap.PixelFormat );
      fIEBitmap.CopyRectTo(ImageEn1.IEBitmap, x1, y1, 0, 0, (x2 - x1), (y2 - y1));
      ImageEn1.Proc.MakeConsistentBitmap([ie24RGB]);
      if fIEBitmap.HasAlphaChannel then begin
        fIEBitmap.AlphaChannel.CopyRectTo(ImageEn1.IEBitmap.AlphaChannel, x1, y1, 0, 0, (x2 - x1), (y2 - y1));
        ImageEn1.IEBitmap.AlphaChannel.full:=fIEBitmap.AlphaChannel.Full;
      end;
      ImageEn1.Update;
      Update;
    end;
    fPreviews.pe := pe;
    fPreviews.InitialPage := nil;
    fPreviews.fIPDialogParams:=fIPDialogParams;
    fPreviews.OpList:=fPreviewsLog;
    if assigned(fOnPreview) then
      fOnPreview(self, fPreviews);
    if fPreviews.ShowModal = mrOk then
    begin
      result := true;

      // update lock preview
      if fPreviews.DefaultLockPreview then
        PreviewsParams:= PreviewsParams + [prppDefaultLockPreview]
      else
        PreviewsParams:= PreviewsParams - [prppDefaultLockPreview];

      if fAutoUndo then
        SaveUndoCaptioned(fPreviews.UndoCaption, ieuImage);

      MakeConsistentBitmap([ie24RGB]);

      // apply results
      with fPreviews do
      begin
        if assigned(mask) and (not mask.IsEmpty) and ((x1 > 0) or (y1 > 0) or (x2 <= fIEBitmap.width) or (y2 <= fIEBitmap.Height)) then
        begin
          // polygonal selection
          mask.CopyIEBitmap(fIEBitmap, ImageEn1.IEBitmap, false, true, false);
        end
        else
        begin
          // change size if needed
          fIEBitmap.Width := ImageEn1.IEBitmap.Width;
          fIEBitmap.Height := ImageEn1.IEBitmap.Height;
          imageen1.IEBitmap.CopyRectTo(fIEBitmap, 0, 0, x1, y1, imageen1.IEBitmap.Width, imageen1.IEBitmap.Height);
          if imageen1.IEBitmap.HasAlphaChannel then
            imageen1.IEBitmap.AlphaChannel.CopyRectTo(fIEBitmap.AlphaChannel, 0, 0, x1, y1, imageen1.IEBitmap.Width, imageen1.IEBitmap.Height);
        end;
      end;
      update;
    end
    else
      result := false;
    fPreviews.Release;
  finally
    if assigned(fImageEnView) then
      fImageEnView.GetCanvas.UnLock;
    DoFinishWork;
  end;
end;

{$ENDIF}

{!!
<FS>TImageEnProc.Resample

<FM>Declaration<FC>
procedure Resample(NewWidth, NewHeight: integer; FilterType: <A TResampleFilter>);

<FM>Description<FN>
This method resizes the current image. The content of the image changes (stretched to new size).

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>NewWidth<FN></C> <C>New image width in pixels. If NewWidth is -1 then it is calculated automatically, respecting the proportions.</C> </R>
<R> <C><FC>NewHeight<FN></C> <C>New image height in pixels. If NewHeight is -1 then it is calculated automatically, respecting the proportions.</C> </R>
<R> <C><FC>FilterType<FN></C> <C>Resampling interpolation algorithm.</C> </R>
</TABLE>

See also <A TImageEnProc.ResampleTo>.

<FM>Example<FC>

ImageEnView1.Proc.Resample(50,-1,rfNone); // resizes the image to 50xY (y=automatic) FAST
ImageEnView1.Proc.Resample(50,-1,rfFastLinear); // resizes the image to 50xY with rfFastLinear filter

!!}
// Resample the image to NewWidth and NewHeight
// if NewWidth or NewHeight is -1, it is calculated maintain aspect ratio
// if NewWidth or NewHeight is 0, it doesn't change
// 2.2.5
procedure TImageEnProc.Resample(NewWidth, NewHeight: integer; FilterType: TResampleFilter);
var
  newbitmap: TIEBitmap;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.Width = 0) or (fIEBitmap.Height = 0) or ((NewWidth=fIEBitmap.Width) and (NewHeight=fIEBitmap.Height)) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(Format(IERS_RESAMPLE, [NewWidth, NewHeight]), ieuImage);
  //
  newbitmap := TIEBitmap.create;
  ResampleTo(newbitmap, NewWidth, NewHeight, FilterType); // ResampleTo resizes the bitmap and set pixelformat
  fIEBitmap.Assign(newbitmap);
  FreeAndNil(newbitmap);
  //
  Update;
  DoFinishWork;
end;


{!!
<FS>TImageEnProc.ResampleTo

<FM>Declaration<FC>
procedure ResampleTo(Target:<A TIEBitmap>; TargetWidth, TargetHeight:integer; FilterType:<A TResampleFilter>);

<FM>Description<FN>
ResampleTo copies a resampled instance of the current image to a Target TIEBitmap. The content of the destination image changes (stretched to new size).

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Target<FN></C> <C>The target (destination) image.</C> </R>
<R> <C><FC>TargetWidth<FN></C> <C>Width in pixels of the target size. If TargetWidth is -1 then it is calculated automatically, respecting the proportions.</C> </R>
<R> <C><FC>TargetHeight<FN></C> <C>Height in pixels of the target size. If TargetHeight is -1 then it is calculated automatically, respecting the proportions.</C> </R>
<R> <C><FC>FilterType<FN></C> <C>Resampling interpolation algorithm.</C> </R>
</TABLE>

Resampling black/white (1bit) images with FilterType is not rfNone, Resample converts the image to 24bit.

See also <A TImageEnProc.Resample>.

<FM>Example<FC>
// creates a thumbnail of image in ImageEnView1 to ImageEnView2
ImageEnView1.Proc.ResampleTo( ImageEnView2.IEBitmap, 100,-1, rfFastLinear );
ImageEnView2.Update;
!!}
// if TargetWidth or TargetHeight is -1, it is calculated maintain aspect ratio
// if TargetWidth or TargetHeight is 0, it doesn't change
procedure TImageEnProc.ResampleTo(Target: TIEBitmap; TargetWidth, TargetHeight: integer; FilterType: TResampleFilter);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.Width = 0) or (fIEBitmap.Height = 0) then
    exit;
  // check and adjust TargetWidth and NewHeight
  if (TargetWidth < 0) and (TargetHeight < 0) then
    exit; // ERROR
  case TargetWidth of
    -1: TargetWidth := (fIEbitmap.Width * TargetHeight) div fIEbitmap.Height;
     0: TargetWidth := fIEBitmap.Width;
    else
      TargetWidth := abs(TargetWidth);
  end;
  if TargetWidth < 1 then
    TargetWidth := 1;
  case TargetHeight of
    -1: TargetHeight := (fIEbitmap.Height * TargetWidth) div fIEbitmap.Width;
    0: TargetHeight := fIEBitmap.Height;
  else
    TargetHeight := abs(TargetHeight);
  end;
  if TargetHeight < 1 then
    TargetHeight := 1;
  Target.Allocate(TargetWidth, TargetHeight, fIEBitmap.PixelFormat);
  _IEResampleIEBitmap(fIEBitmap, Target, FilterType, fOnProgress, self);
  DoFinishWork;
end;

procedure _IESetAlpha0Color(bitmap: TIEBitmap; cl: TRGB);
var
  x, y: integer;
  a: pbyte;
  p: PRGB;
begin
  if bitmap.PixelFormat=ie24RGB then
  begin
    for y := 0 to bitmap.height - 1 do
    begin
      a := bitmap.AlphaChannel.Scanline[y];
      p := bitmap.Scanline[y];
      for x := 0 to bitmap.width - 1 do
      begin
        if a^ = 0 then
          p^ := cl;
        inc(p);
        inc(a);
      end;
    end;
  end;
end;

// if FilterType is not rfNone, it must be ie24RGB or ie1g (when rfProjectBW or rfProjectWB)
// Resample also alphachannel
procedure _IEResampleIEBitmap(source, dest: TIEBitmap; FilterType: TResampleFilter; fOnProgress: TIEProgressEvent; Sender: TObject);
begin

  if (source.Width = dest.Width) and (source.Height = dest.Height) then
  begin
    dest.Assign(source);
    exit;
  end;

  (* issue: 16 Jul 2009, 9:53. Now to remove artifacts due resampling transparent areas it is necessary to manually set transparent areas to gray
  if source.HasAlphaChannel then
    // this avoids transparent color merges with image colors
    _IESetAlpha0Color(source, CreateRGB(128, 128, 128)); *)

  if (FilterType = rfNone) then
    // all pixel formats unfiltered
    _IEBmpStretchEx(source, dest, fOnProgress, Sender)
  else if (source.pixelformat = ie1g) then
  begin
    // 1bit filtered
    if (FilterType=rfProjectBW) or (FilterType=rfProjectWB) then
      dest.PixelFormat := ie1g
    else
      dest.PixelFormat := ie24RGB;
    _Resample1BitEx(source, dest, FilterType);
  end
  else
    // 24bit filtered. Bicubic/bilinear support ie8g, ie16g, ie24rgb, ie48rgb
    _ResampleEx(source, dest, FilterType, fOnProgress, Sender);

  if source.HasAlphaChannel then
  begin
    if (FilterType = rfNone) then
      _IEBmpStretchEx(source.AlphaChannel, dest.AlphaChannel, nil, nil)
    else
      _Resampleie8g(source.AlphaChannel, dest.AlphaChannel, FilterType);
    dest.AlphaChannel.Full := source.AlphaChannel.Full;
  end;
end;

procedure _IEResampleIEBitmap2(sourceANDdest: TIEBitmap; FilterType: TResampleFilter; NewWidth,NewHeight:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  temp:TIEBitmap;
begin
  temp:=TIEBitmap.Create;
  temp.Assign(sourceANDdest);
  sourceANDdest.Resize(NewWidth,NewHeight,0,255,iehLeft,ievTop);
  _IEResampleIEBitmap(temp, sourceANDdest, FilterType,fOnProgress,Sender);
  FreeAndNil(temp);
end;

procedure TImageEnProc.Notification(AComponent: TComponent; Operation: TOperation);
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

// accept all pixelformats

procedure _GetMediaContrastRGB(bitmap: TIEBitmap; var mR, mG, mB: integer);
var
  w, h, v: integer;
  tr, tg, tb, ww, hh: integer;
  x, y: integer;
  ppx: pRGB;
  bpx: pbyte;
  wpx: pword;
  fpx: psingle;
  pxcmyk:PCMYK;
  pxcielab:PCIELab;
  pxrgb48:PRGB48;
  rgb:TRGB;
begin
  mR := 0;
  mG := 0;
  mB := 0;
  ww := bitmap.Width;
  hh := bitmap.Height;
  w := ww - 1;
  h := hh - 1;
  try
    for y := 0 to h do
    begin
      tr := 0;
      tg := 0;
      tb := 0;
      case bitmap.PixelFormat of
        ie1g: // gray scale (black/white)
          begin
            bpx := bitmap.ScanLine[y];
            for x := 0 to w do
              if pbytearray(bpx)^[x shr 3] and iebitmask1[x and $7] <> 0 then
              begin
                inc(tr, 255);
                inc(tg, 255);
                inc(tb, 255);
              end;
          end;
        ie8p: // color (palette)
          begin
            bpx := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              with bitmap.Palette[bpx^] do
              begin
                inc(tr, r);
                inc(tg, g);
                inc(tb, b);
              end;
              inc(bpx);
            end;
          end;
        ie8g: // gray scale (256 levels)
          begin
            bpx := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              inc(tr, bpx^);
              inc(tg, bpx^);
              inc(tb, bpx^);
              inc(bpx);
            end;
          end;
        ie16g: //	gray scale (65536 levels)
          begin
            wpx := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              inc(tr, wpx^);
              inc(tg, wpx^);
              inc(tb, wpx^);
              inc(wpx);
            end;
          end;
        ie24RGB: // color (true color)
          begin
            ppx := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              with ppx^ do
              begin
                inc(tr, r);
                inc(tg, g);
                inc(tb, b);
              end;
              inc(ppx);
            end;
          end;
        ie32RGB: // color (true color)
          begin
            bpx := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              inc(tr, bpx^); inc(bpx);
              inc(tg, bpx^); inc(bpx);
              inc(tb, bpx^); inc(bpx);
              inc(bpx); // bypass
            end;
          end;
        ie32f: //	float point gray scale
          begin
            fpx := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              v := trunc(fpx^ * 255);
              inc(tr, v);
              inc(tg, v);
              inc(tb, v);
              inc(fpx);
            end;
          end;
        ieCMYK: // CMYK
          begin
            pxcmyk := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              rgb:=IECMYK2RGB(pxcmyk^);
              inc(tr, rgb.r);
              inc(tg, rgb.g);
              inc(tb, rgb.b);
              inc(pxcmyk);
            end;
          end;
        ieCIELab: // CIELab
          begin
            pxcielab := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              rgb:=IECIELAB2RGB(pxcielab^);
              inc(tr, rgb.r);
              inc(tg, rgb.g);
              inc(tb, rgb.b);
              inc(pxcielab);
            end;
          end;
        ie48RGB: // RGB48
          begin
            pxrgb48 := bitmap.ScanLine[y];
            for x := 0 to w do
            begin
              inc(tr, trunc(pxrgb48^.r/255*65535));
              inc(tg, trunc(pxrgb48^.g/255*65535));
              inc(tb, trunc(pxrgb48^.b/255*65535));
              inc(pxrgb48);
            end;
          end;
      end;
      mR := mR + (tr div ww);
      mG := mG + (tg div ww);
      mB := mB + (tb div ww);
    end;
    mR := mR div hh;
    mG := mG div hh;
    mB := mB div hh;
  except
    // on overflow
    mR := 128;
    mG := 128;
    mB := 128;
  end;
end;

{!!
<FS>TImageEnProc.GetHistogram

<FM>Declaration<FC>
procedure GetHistogram(Hist: pointer);

<FM>Description<FN>
The GetHistogram method fills Hist with the histogram of the current image.
Hist is a pointer to <A THistogram> array.
!!}
procedure TImageEnProc.GetHistogram(Hist: pointer);
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  mask: TIEMask;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  GetReSel(fSX1, fSY1, fSX2, fSY2, fPolyS, fPolySCount, mask);
  _GetHistogram(fIEBitmap, Hist, fSx1, fSy1, fSx2, fSy2, mask);
end;

// make an histogram of r,g,b and gray channels
procedure _GetHistogram(Bitmap: TIEBitmap; Hist: PHistogram; fSelx1, fSely1, fSelx2, fSely2: integer; mask:TIEMask);
var
  x, y: integer;
  e: PRGB;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  fillmemory(Hist, sizeof(THistogram), 0); // zero fill
  for y := fSely1 to fSely2 do
  begin
    e := Bitmap.ScanLine[y];
    inc(e, fSelx1);
    for x := fSelx1 to fSelx2 do
    begin
      if not assigned(mask) or mask.IsEmpty or mask.IsPointInside(x,y) then
      begin
        inc(Hist[e^.r].r);
        inc(Hist[e^.g].g);
        inc(Hist[e^.b].b);
        inc(Hist[(e^.r * gRedToGrayCoef + e^.g * gGreenToGrayCoef + e^.b * gBlueToGrayCoef) div 100].Gray);
      end;
      inc(e);
    end;
  end;
end;

// return the number of colors in the specified selection
function _GetImageNumColors(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer): integer;
var
  x, y, c: integer;
  e: pRGB;
  hash: THash1;
begin
  result := 0;
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  hash := THash1.Create(13);
  for y := fSely1 to fSely2 do
  begin
    e := Bitmap.ScanLine[y];
    inc(e, fSelx1);
    for x := fSelx1 to fSelx2 do
    begin
      c := (e^.r shl 16) or (e^.g shl 8) or (e^.b);
      hash.Insert(c);
      inc(e);
    end;
  end;
  result := hash.nkeys;
  FreeAndNil(hash);
end;

{!!
<FS>TImageEnProc.CalcImageNumColors

<FM>Declaration<FC>
function CalcImageNumColors: integer;

<FM>Description<FN>
CalcImageNumColors returns how any colors the current image is using. This value doesn't depend on the internal format of the image (so 24 bit images don't necessarily have 16 million colors).
The result is the number of found colors in the current image (without limits).
!!}
function TImageEnProc.CalcImageNumColors: integer;
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  mask: TIEMask;
begin
  result := 0;
  if not MakeConsistentBitmap([]) then
    exit;
  if fIEBitmap.PixelFormat = ie1g then
  begin
    result := 2;
    exit;
  end;
  if fIEBitmap.Pixelformat <> ie24RGB then
    exit;
  GetReSel(fSX1, fSY1, fSX2, fSY2, fPolyS, fPolySCount, mask);
  result := _GetImageNumColors(fIEBitmap, fSx1, fSy1, fSx2, fSy2);
end;

{!!
<FS>TImageEnProc.Contrast

<FM>Declaration<FC>
procedure Contrast(vv: double);

<FM>Description<FN>
This method changes the contrast of selected region.
vv is the contrast value which may range from -100 to +100, where 0 is no change.

<FM>Example<FC>

ImageEnView1.Proc.Contrast(50);
!!}
procedure TImageEnProc.Contrast(vv: double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
  mR, mG, mB: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_CONTRAST, [vv]), ProcBitmap, mask) then
    exit;
  _GetMediaContrastRGB(fIEBitmap, mR, mG, mB); // media over full image (not selection)
  _ContrastRGB(ProcBitmap, vv, mR, mG, mB, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// supports all TIEBitmap pixelformats
function _ConvertTo1bitEx(Bitmap: TIEBitmap; var BackCol, ForeCol: TRGB): TIEBitmap;
var
  x, y, c: integer;
  e: TRGB;
  d: pbyte;
  hash: THash1;
  bitpos: integer;
  bb, ff: byte;
  t: TRGB;
  bitmapwidth1, bitmapheight1: integer;
begin
  hash := THash1.Create(13);
  result := TIEBitmap.Create;
  result.Allocate(Bitmap.Width, Bitmap.Height, ie1g);
  bitmapwidth1 := bitmap.width - 1;
  bitmapheight1 := bitmap.height - 1;
  for y := 0 to Bitmapheight1 do
  begin
    if hash.nkeys > 2 then
      break;
    d := result.ScanLine[y];
    bitpos := 0;
    for x := 0 to BitmapWidth1 do
    begin
      e := Bitmap.Pixels[x, y];
      c := (e.r shl 16) or (e.g shl 8) or (e.b);
      if hash.Insert(c) then
      begin
        if hash.nkeys = 1 then
          BackCol := e
        else
          ForeCol := e;
      end;
      if (e.r = BackCol.r) and (e.g = BackCol.g) and (e.b = BackCol.b) then
        d^ := d^ and (not iebitmask1[bitpos])
      else
        d^ := d^ or iebitmask1[bitpos];
      inc(bitpos);
      if bitpos = 8 then
      begin
        bitpos := 0;
        inc(d);
      end;
    end;
  end;
  if hash.nkeys <> 2 then
  begin
    FreeAndNil(result);
  end
  else
  begin
    bb := Round((BackCol.r * gRedToGrayCoef + BackCol.g * gGreenToGrayCoef + BackCol.b * gBlueToGrayCoef) / 100);
    ff := Round((ForeCol.r * gRedToGrayCoef + ForeCol.g * gGreenToGrayCoef + ForeCol.b * gBlueToGrayCoef) / 100);
    if bb > ff then
    begin
      _Negative1BitEx(result);
      t := BackCol;
      BackCol := ForeCol;
      ForeCol := t;
    end;
  end;
  FreeAndNil(hash);
end;

// make LUT needed to convert 1bit to 24bit
procedure MakeC1TO24;
var
  q, w, v: integer;
begin
  for q := 0 to 255 do
  begin
    for w := 0 to 7 do
    begin
      if (q and iebitmask1[w]) <> 0 then
        v := 255
      else
        v := 0;
      C1TO24[q][w].r := v;
      C1TO24[q][w].g := v;
      C1TO24[q][w].b := v;
    end;
  end;
end;

// Creates a palette for the bitmap
// palette: the palette found
// max: size of the palette
// note: if the color count is larger than "max", they will be quantized
procedure _GetImagePalette(bitmap: TIEBitmap; var palette: array of TRGB; max: integer);
var
  qt: TIEQuantizer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  qt := TIEQuantizer.Create(Bitmap, palette, max);
  FreeAndNil(qt);
end;

{!!
<FS>TImageEnProc.CalcImagePalette

<FM>Declaration<FC>
procedure CalcImagePalette(var Palette: array of <A TRGB>; MaxCol: integer);

<FM>Description<FN>
The CalcImagePalette method fills the Palette array with the colors found in the current image.
Palette is the array to fill.
MaxCol is the size of Palette. If image has more than MaxCol colors, the image is quantized to match the number of colors specified (MaxCol).


<FM>Example<FC>

var MyColorMap256:array [0..255] of TRGB;
  MyColorMap1000:array [0..999] of TRGB;
Begin
  ImageEnView1.Proc.CalcImagePalette(MyColorMap256,256);
  ImageEnView1.Proc.CalcImagePalette(MyColorMap1000,1000);
End;

!!}
procedure TImageEnProc.CalcImagePalette(var Palette: array of TRGB; MaxCol: integer);
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  _GetImagePalette(fIEBitmap, Palette, MaxCol);
end;

{!!
<FS>TImageEnProc.CopyToClipboard

<FM>Declaration<FC>
function TImageEnProc.CopyToClipboard(UseInternalFormat:boolean):boolean;

<FM>Description<FN>
This method copies whole image to the clipboard.
If UseInternalFormat is True, two bitmap are saved: one in standard DIB format and one in internal format which preserves pixelformat and alpha channel.
Returns True on successful.

<FM>Example<FC>

ImageEnView1.Proc.CopyToClipboard;
!!}
function TImageEnProc.CopyToClipboard(UseInternalFormat:boolean):boolean;
var
  hbi: THandle;
  memHandle:THandle;
begin
  result:=false;
  if not MakeConsistentBitmap([]) then
    exit;
  if IEOpenClipboard then
  begin
    try

      // initialize
      EmptyClipboard;

      // set CF_DIB image
      hbi := _CopyBitmaptoDIBEx(fIEBitmap, 0, 0, 0, 0, GetDPIX, GetDPIY);
      if hbi=0 then
        exit;

      if SetClipboardData(CF_DIB, hbi)=0 then  // free only on fail
      begin
        GlobalFree(hbi);
        exit;
      end;

      // Using internal format
      if UseInternalFormat then
      begin
        memHandle := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, fIEBitmap.CalcRAWSize);
        if memHandle<>0 then
        begin
          fIEBitmap.SaveRAWToBufferOrStream( GlobalLock(memHandle),nil );
          GlobalUnLock(memHandle);
          if SetClipboardData(IERAWCLIPFORMAT, memHandle)=0 then  // free only on fail
            GlobalFree(memHandle);  // don't set result=false because CF_DIB had success
        end;
      end;

      result:=true;

    finally
      CloseClipboard;
    end;

  end;
end;

{!!
<FS>TImageEnProc.PasteFromClipboard

<FM>Declaration<FC>
procedure PasteFromClipboard;

<FM>Description<FN>
This method makes the clipboard image as the current image.
All uncompressed DBI formats are handled (1, 4, 8, 15, 16, 24 and 32 bits).
If the clipboard image is 4, 8, 15, 16, 24 or 32 bits, it is converted to 24 bit.  Otherwise (1 bit) it remains 1 bit.

<FM>Example<FC>

ImageEnView1.Proc.PasteFromClipboard;
!!}
procedure TImageEnProc.PasteFromClipboard;
var
  hbi: THandle;
  memPtr:pointer;
  meta:TMetaFile;
  io:TImageEnIO;
begin
  if not MakeConsistentBitmap([]) then
    exit;

  if IEOpenClipboard then
  begin

    try

    if IsClipboardFormatAvailable(IERAWCLIPFORMAT) then
    begin
      // internal format
      hbi := GetClipboardData(IERAWCLIPFORMAT);
      if hbi <> 0 then
      begin
        if fAutoUndo then
          SaveUndoCaptioned(IERS_PASTEFROMCLIPBOARD, ieuImage);
        memPtr:=GlobalLock(hbi);
        fIEBitmap.LoadRAWFromBufferOrStream(memPtr,nil);
        GlobalUnLock(hbi);
        Update;
      end;
    end

    {$ifdef IEINCLUDEPNG}
    else if IEGetClipboardDataByName('PNG')>0 then
    begin
      // PNG format
      hbi := GetClipboardData( IEGetClipboardDataByName('PNG') );
      if hbi <> 0 then
      begin
        if fAutoUndo then
          SaveUndoCaptioned(IERS_PASTEFROMCLIPBOARD, ieuImage);
        io:=TImageEnIO.CreateFromBitmap(fIEBitmap);
        try
          memPtr:=GlobalLock(hbi);
          io.LoadFromBuffer( memPtr, GlobalSize(hbi), ioPNG );
          GlobalUnLock(hbi);
        finally
          io.Free;
        end;
        Update;
      end;
    end
    {$endif}

    else if IsClipboardFormatAvailable(CF_DIB) then
    begin
      // DIB format
      hbi := GetClipboardData(CF_DIB);
      if hbi <> 0 then
      begin
        if fAutoUndo then
          SaveUndoCaptioned(IERS_PASTEFROMCLIPBOARD, ieuImage);
        _CopyDIB2BitmapEx(hbi, fIEBitmap, nil, false);
        Update;
      end;
    end

    else if IsClipboardFormatAvailable(CF_ENHMETAFILE) then
    begin
      // EMF format
      hbi := GetClipboardData(CF_ENHMETAFILE);
      if hbi <> 0 then
      begin
        if fAutoUndo then
          SaveUndoCaptioned(IERS_PASTEFROMCLIPBOARD, ieuImage);
        io:=TImageEnIO.CreateFromBitmap(fIEBitmap);
        meta:=TMetaFile.Create;
        try
          meta.Handle:=hbi;
          io.ImportMetafile(meta,-1,-1,true);
        finally
          meta.free;
          io.Free;
        end;
        Update;
      end;
    end;

    finally
      CloseClipboard;
    end;
  end;
end;


{!!
<FS>TImageEnProc.IsClipboardAvailable

<FM>Declaration<FC>
function IsClipboardAvailable:boolean;

<FM>Description<FN>
This method returns <FC>true<FN> if clipboard contains data valid for TImageEnProc.

<FM>See also<FN>
<A TImageEnProc.PasteFromClipboard>
<A TImageEnProc.PointPasteFromClip>
<A TImageEnProc.SelPasteFromClipStretch>
<A TImageEnProc.SelPasteFromClip>

<FM>Example<FC>

if ImageEnView1.Proc.IsClipboardAvailable then
  ImageEnView1.Proc.PasteFromClipboard;
!!}
function TImageEnProc.IsClipboardAvailable:boolean;
begin

  result := false;

  if IEOpenClipboard then
  begin
    try
      result :=
        IsClipboardFormatAvailable(IERAWCLIPFORMAT) or
        {$ifdef IEINCLUDEPNG}
        (IEGetClipboardDataByName('PNG')>0) or
        {$endif}
        IsClipboardFormatAvailable(CF_DIB) or
        IsClipboardFormatAvailable(CF_ENHMETAFILE);

    finally
      CloseClipboard;
    end;
  end;

end;


{!!
<FS>TImageEnProc.PointPasteFromClip

<FM>Declaration<FC>
procedure PointPasteFromClip(x1, y1: integer; MergeAlpha:boolean=true);

<FM>Description<FN>
This method pastes the clipboard image at x1, y1 position (component coordinates). All uncompressed DBI formats are handled (1, 4, 8, 15, 16, 24 and 32 bits). If clipboard image is 4, 8, 15, 16, 24 or 32 bits, it is converted to 24 bit, otherwise (1 bit) it remains 1 bit.

If MergeAlpha is valid only trasfering image in internal format. It merges the pasting bitmap alphachannel with the background bitmap.

<FM>Example<FC>

// Paste clipboard image at the current mouse position
procedure TForm1.ImageEn1MouseDown(Sender:TObject; Button:TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ImageEnView1.Proc.PointPasteFromClip(X,Y);
end;

!!}
procedure TImageEnProc.PointPasteFromClip(x1, y1: integer; MergeAlpha:boolean);
var
  pabitmap: tiebitmap;
  hbi: THandle;
  memPtr:pointer;
  mask:TIEMask;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if IEOpenClipboard then
  begin

    try

    if assigned(fImageEnView) and (fImageEnView is TImageEnView) then
      with fImageEnView as TImageEnView do
        if SelectionBase = iesbClientArea then
        begin
          x1 := XScr2Bmp(x1);
          y1 := YScr2Bmp(y1);
        end;

    if IsClipboardFormatAvailable(IERAWCLIPFORMAT) then
    begin
      // internal format
      hbi := GetClipboardData(IERAWCLIPFORMAT);
      if hbi <> 0 then
      begin
        pabitmap := TIEBitmap.create;
        if fAutoUndo then
          SaveUndoCaptioned(Format(IERS_POINTPASTEFROMCLIP, [x1, y1]), ieuImage);
        memPtr:=GlobalLock(hbi);
        pabitmap.LoadRAWFromBufferOrStream(memPtr,nil);
        GlobalUnLock(hbi);
        mask:=TIEMask.Create;
        mask.AllocateBits(fIEBitmap.Width,fIEBitmap.Height,1);
        mask.Fill(255);
        mask.x1:=x1; mask.y1:=y1; mask.x2:=x1+paBitmap.Width-1; mask.y2:=y1+paBitmap.Height-1;
        if paBitmap.HasAlphaChannel and MergeAlpha then
          mask.CombineWithAlpha(paBitmap.AlphaChannel,mask.x1,mask.y1,false);
        paBitmap.CopyWithMask2(fIEBitmap,mask);
        mask.free;
        FreeAndNil(pabitmap);
        Update;
      end;
    end

    // DIB format
    else if IsClipboardFormatAvailable(CF_DIB) then
    begin
      hbi := GetClipboardData(CF_DIB);
      if hbi <> 0 then
      begin
        pabitmap := TIEBitmap.create;
        _CopyDIB2BitmapEx(hbi, paBitmap, nil, false);
        if fAutoUndo then
          SaveUndoCaptioned(Format(IERS_POINTPASTEFROMCLIP, [x1, y1]), ieuImage);
        pabitmap.CopyRectTo(fIEBitmap, 0, 0, x1, y1, pabitmap.Width, pabitmap.Height);
        FreeAndNil(pabitmap);
        Update;
      end;

    end;

    finally
      CloseClipboard;
    end;
  end;
end;

{!!
<FS>TImageEnProc.SelPasteFromClipStretch

<FM>Declaration<FC>
procedure SelPasteFromClipStretch(MergeAlpha:boolean=true);

<FM>Description<FN>
This method pastes the clipboard image to the selected region, stretching the image to fit the selection. All uncompressed DBI formats are handled (1, 4, 8, 15, 16, 24 and 32 bits). If clipboard image is 4, 8, 15, 16, 24 or 32 bits, it is converted to 24 bit, otherwise (1 bit) it remains 1 bit.

If MergeAlpha is valid only trasfering image in internal format.
It merges the pasting bitmap alphachannel with the background bitmap.
!!}
procedure TImageEnProc.SelPasteFromClipStretch(MergeAlpha:boolean);
var
  pabitmap, pbBitmap: TIEBitmap;
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  hbi: THandle;
  mask: TIEMask;
  memPtr:pointer;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if GetReSel(fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask) then
  begin
    if IEOpenClipboard then
    begin

      try

      if IsClipboardFormatAvailable(IERAWCLIPFORMAT) then
      begin
        // internal format
        hbi := GetClipboardData(IERAWCLIPFORMAT);
        if hbi <> 0 then
        begin
          pabitmap := TIEBitmap.create;
          if fAutoUndo then
            SaveUndoCaptioned(IERS_SELPASTEFROMCLIPSTRETCH, ieuImage);
          memPtr:=GlobalLock(hbi);
          pabitmap.LoadRAWFromBufferOrStream(memPtr,nil);
          GlobalUnLock(hbi);
          pbBitmap := TIEBitmap.Create;
          pbBitmap.Allocate(fsx2 - fsx1, fsy2 - fsy1, paBitmap.PixelFormat);
          _IEBmpStretchEx(paBitmap, pbBitmap, nil, nil);
          if paBitmap.HasAlphaChannel then
          begin
            _IEBmpStretchEx(paBitmap.AlphaChannel, pbBitmap.AlphaChannel, nil, nil);
            if MergeAlpha then
              mask.CombineWithAlpha(pbBitmap.AlphaChannel,mask.x1,mask.y1,false);
          end;
          pbBitmap.CopyWithMask2(fIEBitmap,mask);
          FreeAndNil(pbBitmap);
          FreeAndNil(pabitmap);
          Update;
        end;
      end

      else if IsClipboardFormatAvailable(CF_DIB) then
      begin
        // DIB format
        hbi := GetClipboardData(CF_DIB);
        if hbi <> 0 then
        begin
          pabitmap := TIEBitmap.create;
          if fAutoUndo then
            SaveUndoCaptioned(IERS_SELPASTEFROMCLIPSTRETCH, ieuImage);
          _CopyDIB2BitmapEx(hbi, paBitmap, nil, false);
          pbBitmap := TIEBitmap.Create;
          pbBitmap.Allocate(fsx2 - fsx1, fsy2 - fsy1, paBitmap.PixelFormat);
          _IEBmpStretchEx(paBitmap, pbBitmap, nil, nil);
          pbBitmap.CopyRectTo(fIEBitmap, 0, 0, fsx1, fsy1, pbBitmap.Width, pbBitmap.Height);
          FreeAndNil(pbBitmap);
          FreeAndNil(pabitmap);
          Update;
        end;
      end;

      finally
        CloseClipboard;
      end;
    end;
  end
  else
    PasteFromClipboard;
end;

{!!
<FS>TImageEnProc.SelPasteFromClip

<FM>Declaration<FC>
procedure SelPasteFromClip(MergeAlpha:boolean=true);

<FM>Description<FN>
This method pastes the contents of the Clipboard inside the selected area. The image will be stretched to the selection size.
If MergeAlpha is valid only trasfering image in internal format. It merges the pasting bitmap alphachannel with the background bitmap.
!!}
procedure TImageEnProc.SelPasteFromClip(MergeAlpha:boolean);
var
  pabitmap, pbBitmap: TIEBitmap;
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  hbi: THandle;
  mask: TIEMask;
  memPtr:pointer;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if GetReSel(fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask) then
  begin
    if IEOpenClipboard then
    begin

      try

      if IsClipboardFormatAvailable(IERAWCLIPFORMAT) then
      begin
        // internal format
        hbi := GetClipboardData(IERAWCLIPFORMAT);
        if hbi <> 0 then
        begin
          pabitmap := TIEBitmap.create;
          if fAutoUndo then
            SaveUndoCaptioned(IERS_SELPASTEFROMCLIP, ieuImage);
          memPtr:=GlobalLock(hbi);
          pabitmap.LoadRAWFromBufferOrStream(memPtr,nil);
          GlobalUnLock(hbi);
          pbBitmap := TIEBitmap.Create;
          pbBitmap.Allocate(fsx2 - fsx1, fsy2 - fsy1, paBitmap.PixelFormat);
          _IEBmpStretchEx(paBitmap, pbBitmap, nil, nil);
          if paBitmap.HasAlphaChannel then
          begin
            _IEBmpStretchEx(paBitmap.AlphaChannel, pbBitmap.AlphaChannel, nil, nil);
            if MergeAlpha then
              mask.CombineWithAlpha(pbBitmap.AlphaChannel,mask.x1,mask.y1,false);
          end;
          pbBitmap.CopyWithMask2(fIEBitmap,mask);
          FreeAndNil(pbBitmap);
          FreeAndNil(pabitmap);
          Update;
        end;
      end

      // DIB format
      else if IsClipboardFormatAvailable(CF_DIB) then
      begin
        hbi := GetClipboardData(CF_DIB);
        if hbi <> 0 then
        begin
          pabitmap := TIEBitmap.create;
          if fAutoUndo then
            SaveUndoCaptioned(IERS_SELPASTEFROMCLIP, ieuImage);
          _CopyDIB2BitmapEx(hbi, paBitmap, nil, false);
          pbBitmap := TIEBitmap.Create;
          pbBitmap.Allocate(fsx2 - fsx1, fsy2 - fsy1, paBitmap.PixelFormat);
          _IEBmpStretchEx(paBitmap, pbBitmap, nil, nil);
          mask.CopyIEBitmap(fIEBitmap, pbBitmap, false, true, false);
          FreeAndNil(pbBitmap);
          FreeAndNil(pabitmap);
          Update;
        end;
      end;

      finally
        CloseClipboard;
      end;
    end;
  end
  else
    PasteFromClipboard;
end;

{!!
<FS>TImageEnProc.IntensityRGBall

<FM>Declaration<FC>
procedure IntensityRGBall(r, g, b: integer);

<FM>Description<FN>
This method changes the RGB channels of the current image or of the selected region.
r, g and b are the channel offsets, from -255 to +255.

<FM>Example<FC>

ImageEnView1.Proc.IntensityRGBall(-255,0,0); // subtracts the Red channel

// apply a Red filter (subtracts the Green and Blue channels)
ImageEnView1.Proc.IntensityRGBall(0,-255,-255);
!!}
procedure TImageEnProc.IntensityRGBall(r, g, b: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_INTENSITYRGBALL, [r, g, b]), ProcBitmap, mask) then
    exit;
  _IntensityRGBall(ProcBitmap, r, g, b, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Changes RGB values inside the specified selection. r,g,b, are offsets.

procedure _IntensityRGBall(bitmap: TIEBitmap; r, g, b: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  e: pRGB;
  per1: double;
  LUTR,LUTG,LUTB:array [0..255] of byte;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);

  for x:=0 to 255 do
  begin
    LUTR[x]:=blimit(x+r);
    LUTG[x]:=blimit(x+g);
    LUTB[x]:=blimit(x+b);
  end;

  for y := fSely1 to fSely2 do
  begin
    e := bitmap.ScanLine[y];
    inc(e, fSelx1);
    for x := fSelx1 to fSelx2 do
    begin
      with e^ do
      begin
        r:=LUTR[r];
        g:=LUTG[g];
        b:=LUTB[b];
      end;
      inc(e);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;

// Returns a Bitmap which represents only one channel H,S or B
// ch: 0=H 1=S 2=V
// The resulting bitmap is always ie24RGB
function _GetHSVChannel(bitmap: TIEBitmap; ch: integer; fOnProgress: TIEProgressEvent; Sender: TObject): TIEBitmap;
var
  x, y: integer;
  e, d: pRGB;
  per1: double;
  hsv: array[0..2] of integer;
  dv, r: integer;
  bitmapwidth1, bitmapheight1: integer;
begin
  result := nil;
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  result := TIEBitmap.Create;
  result.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  per1 := 100 / Bitmap.Height;
  case ch of
    0: dv := 359;
    1: dv := 99;
    2: dv := 99;
  else
    begin
      // when ch is not valid gets Hue
      ch := 0;
      dv := 359;
    end;
  end;
  bitmapheight1 := bitmap.height - 1;
  bitmapwidth1 := bitmap.width - 1;
  for y := 0 to BitmapHeight1 do
  begin
    e := bitmap.ScanLine[y];
    d := result.ScanLine[y];
    for x := 0 to BitmapWidth1 do
    begin
      RGB2HSV(e^, hsv[0], hsv[1], hsv[2]);
      r := trunc((hsv[ch] / dv) * 255);
      d^.r := r;
      d^.g := r;
      d^.b := r;
      inc(e);
      inc(d);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * y));
  end;
end;

// Returns a Bitmap that represents only one channel R,G or B
// ch: B=0 G=1 R=2
// The resulting bitmap is always ie24RGB
function _GetRGBChannel(bitmap: TIEBitmap; ch: integer; fOnProgress: TIEProgressEvent; Sender: TObject): TIEBitmap;
var
  x, y: integer;
  e: pbytearray;
  d: pRGB;
  per1: double;
  bitmapwidth1, bitmapheight1: integer;
begin
  result := nil;
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  result := TIEBitmap.Create;
  result.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  per1 := 100 / Bitmap.Height;
  if ch > 2 then
    ch := 2;
  bitmapheight1 := bitmap.height - 1;
  bitmapwidth1 := bitmap.width - 1;
  for y := 0 to BitmapHeight1 do
  begin
    e := bitmap.ScanLine[y];
    d := result.ScanLine[y];
    for x := 0 to BitmapWidth1 do
    begin
      d^.b := e[ch];
      d^.g := e[ch];
      d^.r := e[ch];
      inc(pbyte(e), 3);
      inc(d);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * y));
  end;
end;

{!!
<FS>TImageEnProc.GetHSVChannel

<FM>Declaration<FC>
function GetHSVChannel(ch: integer): <A TIEBitmap>;

<FM>Description<FN>
The GetHSVChannel function obtains a Bitmap with the HSV specified channel. The result Bitmap is a gray levels representation of specified channel.

ch is the HSV channel. 0 is Hue, 1 is Saturation, and 2 is Value.


<FM>Example<FC>

Hue:= ImageEnView1.Proc.GetHSVChannel(0);
Sat:= ImageEnView1.Proc.GetHSVChannel(1);
Val:= ImageEnView1.Proc.GetHSVChannel(2);
ImageEnView2.IEBitmap.Assign(Hue); // copy Hue channel
ImageEnView3.IEBitmap.Assign(Sat); // copy Sat channel
ImageEnView4.IEBitmap.Assign(Val); // copy Val channel
Hue.Free;
Sat.Free;
Val.Free;
ImageEnView2.Update;
ImageEnView3.Update;
ImageEnView4.Update;

!!}
function TImageEnProc.GetHSVChannel(ch: integer): TIEBitmap;
begin
  result := nil;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  result := _GetHSVChannel(fIEBitmap, ch, fOnProgress, self);
  DoFinishWork;
end;


{!!
<FS>TImageEnProc.GetRGBChannel

<FM>Declaration<FC>
function GetRGBChannel(ch: integer): <A TIEBitmap>;

<FM>Description<FN>
GetRGBChannel obtains a Bitmap with the RGB specified channel. The resulting Bitmap is a gray levels representation of specified channel.

ch is the RGB channel. 0 is Blue, 1 is Green and 2 is Red.

<FM>Example<FC>

blue:= ImageEnView1.Proc.GetRGBChannel(0);
green:= ImageEnView1.Proc.GetRGBChannel(1);
red:= ImageEnView1.Proc.GetRGBChannel(2);

ImageEnView2.IEBitmap.Assign(blue); // shows Blue channel
ImageEnView3.IEBitmap.Assign(green); // shows Green channel
ImageEnView4.IEBitmap.Assign(red); // shows Red channel

ImageEnView2.Update;
ImageEnView3.Update;
ImageEnView4.Update;

red.Free;
green.Free;
blue.Free;
!!}
// Returns a Bitmap that contains only one channel of R,G or B
// ch: B=0 G=1 R=2
function TImageEnProc.GetRGBChannel(ch: integer): TIEBitmap;
begin
  result := nil;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  result := _GetRGBChannel(fIEBitmap, ch, fOnProgress, self);
  DoFinishWork;
end;

// Returns three Bitmaps for each H,S or B channel
// ch: 0=H 1=S 2=V
// The resulting bitmap are always ie24RGB
// The caller must create the bitmaps
procedure _GetHSVChannelAll(bitmap: TIEBitmap; BitmapH, BitmapS, BitmapV: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  e, d1, d2, d3: pRGB;
  per1: double;
  h, s, v: integer;
  r: integer;
  bitmapwidth1, bitmapheight1: integer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  BitmapH.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  BitmapS.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  BitmapV.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  per1 := 100 / Bitmap.Height;
  bitmapheight1 := bitmap.height - 1;
  bitmapwidth1 := bitmap.width - 1;
  for y := 0 to BitmapHeight1 do
  begin
    e := bitmap.ScanLine[y];
    d1 := BitmapH.ScanLine[y];
    d2 := BitmapS.ScanLine[y];
    d3 := BitmapV.ScanLine[y];
    for x := 0 to BitmapWidth1 do
    begin
      RGB2HSV(e^, h, s, v);
      // Sat
      r := trunc((s / 99) * 255);
      d2^.r := r;
      d2^.g := r;
      d2^.b := r;
      inc(d2);
      // Val
      r := trunc((v / 99) * 255);
      d3^.r := r;
      d3^.g := r;
      d3^.b := r;
      inc(d3);
      // Hue
      r := trunc((h / 359) * 255);
      d1^.r := r;
      d1^.g := r;
      d1^.b := r;
      //HSV2RGB(d1^,h,99,99);	// to obtain the Hue channel colorized
      inc(d1);
      //
      inc(e);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * y));
  end;
end;

{!!
<FS>TImageEnProc.GetHSVChannelAll

<FM>Declaration<FC>
procedure GetHSVChannelAll(BitmapH, BitmapS, BitmapV: <A TIEBitmap>);

<FM>Description<FN>
The GetHSVChannelAll method copies the H, S and V channels to BitmapH, BitmapS and BitmapV bitmaps.

<FM>Example<FC>

ImageEnView1.Proc.GetHSVChannelAll( ImageEnView2.IEBitmap, ImageEnView3.IEBitmap, ImageEnView4.IEBitmap);
ImageEnView2.Update;
ImageEnView3.Update;
ImageEnVIew4.Update;
!!}
procedure TImageEnProc.GetHSVChannelAll(BitmapH, BitmapS, BitmapV: TIEBitmap);
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  _GetHSVChannelAll(fIEBitmap, BitmapH, BitmapS, BitmapV, fOnProgress, self);
  DoFinishWork;
end;

// Returns three Bitmaps for each R,G,B channel
// ch: 0=R 1=G 2=B
// The resulting bitmaps are ie24RGB
// The caller must create the Bitmaps
procedure _GetRGBChannelAll(bitmap: TIEBitmap; BitmapR, BitmapG, BitmapB: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  e, d1, d2, d3: pRGB;
  per1: double;
  bitmapwidth1, bitmapheight1: integer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  BitmapR.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  BitmapG.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  BitmapB.Allocate(Bitmap.Width, Bitmap.Height, ie24RGB);
  per1 := 100 / Bitmap.Height;
  bitmapheight1 := bitmap.height - 1;
  bitmapwidth1 := bitmap.width - 1;
  for y := 0 to BitmapHeight1 do
  begin
    e := bitmap.ScanLine[y];
    d1 := BitmapR.ScanLine[y];
    d2 := BitmapG.ScanLine[y];
    d3 := BitmapB.ScanLine[y];
    for x := 0 to BitmapWidth1 do
    begin
      d1^.r := e^.r;
      d1^.g := e^.r;
      d1^.b := e^.r;
      inc(d1);
      d2^.r := e^.g;
      d2^.g := e^.g;
      d2^.b := e^.g;
      inc(d2);
      d3^.r := e^.b;
      d3^.g := e^.b;
      d3^.b := e^.b;
      inc(d3);
      //
      inc(e);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * y));
  end;
end;

{!!
<FS>TImageEnProc.GetRGBChannelAll

<FM>Declaration<FC>
procedure GetRGBChannelAll(BitmapR,BitmapG,BitmapB:<A TIEBitmap>);

<FM>Description<FN>
GetRGBChannelAll copies the R, G and B channels to BitmapR, BitmapG and BitmapB bitmaps.

<FM>Example<FC>

ImageEnView1.Proc.GetRGBChannelAll(ImageEnView2.IEBitmap,ImageEnView3.IEBitmap, ImageEnView4.IEBitmap);

ImageEnView2.Update;
ImageEnView3.Update;
ImageEnView4.Update;
!!}
procedure TImageEnProc.GetRGBChannelAll(BitmapR, BitmapG, BitmapB: TIEBitmap);
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  _GetRGBChannelAll(fIEBitmap, BitmapR, BitmapG, BitmapB, fOnProgress, self);
  DoFinishWork;
end;

// Find the palette index that are more similar to specified color
// Col: color to find
// nc: number of colors in ColorMap
function _GetSimilColor(const ColorMap: array of TRGB; nc: integer; Col: TRGB): integer;
var
  q: integer;
  Diff, ADiff: integer;
begin
  ADiff := 1000;
  result := 0;
  for q := 0 to nc - 1 do
  begin
    Diff := abs(Col.R - ColorMap[q].R) + abs(Col.G - ColorMap[q].G) + abs(Col.B - ColorMap[q].B);
    if Diff < ADiff then
    begin
      result := q;
      ADiff := Diff;
    end;
  end;
end;

// clone the bitmap
function IECloneBitmap(Source: TBitmap): TBitmap;
begin
  result := TBitmap.Create;
  IECopyBitmap(Source, result);
end;

// Copies bitmap Source to Dest
// Width,Height and PixelFormat of Source are assigned to Dest
procedure IECopyBitmap(Source, Dest: TBitmap);
var
  ps, pd: pbyte;
  l: integer;
  procedure ClearDest;
  begin
    Dest.Width := 1;
    Dest.Height := 1;
    Dest.Pixelformat := Source.PixelFormat;
  end;
begin
  if (Source.Width = 0) or (Source.Height = 0) then
  begin
    ClearDest;
  end
  else
  begin
    if (Dest.Width <> Source.Width) or (Dest.Height <> Source.Height) or (Dest.PixelFormat <> Source.PixelFormat) then
    begin
      ClearDest;
      Dest.Width := Source.Width;
      Dest.Height := Source.height;
    end;
    ps := pbyte(imin(int64(DWORD(Source.Scanline[0])), int64(DWORD(Source.Scanline[Source.Height - 1]))));
    pd := pbyte(imin(int64(DWORD(Dest.Scanline[0])), int64(DWORD(Dest.Scanline[Dest.Height - 1]))));
    l := IEBitmapRowlen(Dest.Width, _Pixelformat2Bitcount(Dest.Pixelformat), 32);
    copymemory(pd, ps, l * Dest.height);
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////
// Create a DIB from a TIEDibBitmap object (that can be only ie1g or ie24RGB)
// returns the handle of the DIB (you have do release with GlobalFree() )
// x1,y1,x2,y2: selection to copy (if x2 and y2 are zero it copy entire bitmap)
// it works with other pixel formats only if fBitmap is a TIEBitmap object
function _CopyBitmaptoDIBEx(fBitmap: TIEBaseBitmap; x1, y1, x2, y2: integer; dpix, dpiy:integer): THandle;
var
  pbi: PBITMAPINFO;
  i,q: integer;
  pb,pc: pbyte;
  px: PRGB;
  hh, ww, lw: integer;
  y: integer;
  tmpbmp:TIEBitmap;
begin
  IEPrintLogWrite('_CopyBitmaptoDIBEx: begin');
  if (fBitmap.PixelFormat<>ie1g) and (fBitmap.PixelFormat<>ie24RGB) and (fBitmap.PixelFormat<>ie8g) and (fBitmap.PixelFormat<>ie8p) then
  begin
    IEPrintLogWrite('_CopyBitmaptoDIBEx: not supported pixel format, converting to 24bit and recurse');
    tmpbmp:=TIEBitmap.Create;
    tmpbmp.Assign( fBitmap );
    if not tmpbmp.IsEmpty then
    begin
      tmpbmp.PixelFormat:=ie24RGB;
      result:=_CopyBitmapToDIBEx(tmpbmp,x1,y1,x2,y2,dpix,dpiy);
      FreeAndNil(tmpbmp);
      exit;
    end;
    FreeAndNil(tmpbmp);
  end;

  if x2 = 0 then
    x2 := fBitmap.Width;
  if y2 = 0 then
    y2 := fBitmap.Height;
  hh := y2 - y1;
  ww := x2 - x1;
  lw := IEBitmapRowLen(ww,fBitmap.BitCount,32);
  case fBitmap.PixelFormat of
    ie1g:
      q:=sizeof(TRGBQUAD)*2;
    ie8g, ie8p:
      q:=sizeof(TRGBQUAD)*256;
    else
      q:=0;
  end;
  IEPrintLogWrite('_CopyBitmaptoDIBEx: allocate '+IntToStr(sizeof(TBITMAPINFO) + q + lw * hh)+' bytes');
  result := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, sizeof(TBITMAPINFO) + q + lw * hh);
  if result=0 then
    exit;
  pbi := GlobalLock(result);
  fillchar(pbi^.bmiHeader, sizeof(TBITMAPINFOHEADER), 0);
  with pbi^.bmiHeader do
  begin
    biSize := sizeof(TBITMAPINFOHEADER);
    biWidth := ww;
    biHeight := hh;
    biPlanes := 1;
    biCompression := BI_RGB;
    biXPelsPerMeter := trunc(dpix*39.3700787);  // 2.2.9
    biYPelsPerMeter := trunc(dpiy*39.3700787);  // 2.2.9
  end;
  case fBitmap.PixelFormat of
    ie1g:
      begin
        // 1 bit gray scale
        IEPrintLogWrite('_CopyBitmaptoDIBEx: ie1g');
        pbi^.bmiHeader.biBitCount := 1;
        pb := @(pbi^.bmiColors);
        // write colormap
        pdword(pb)^ := 0; // black
        inc(pb, sizeof(TRGBQUAD));
        pdword(pb)^ := $FFFFFFFF; // white
        inc(pb, sizeof(TRGBQUAD));
        // write image
        for y := y2 - 1 downto y1 do
        begin
          px := fBitmap.Scanline[y];
          IECopyBits_large(pb, pbyte(px), 0, x1, ww, lw);
          inc(pb, lw);
        end;
      end;
    ie8g, ie8p:
      begin
        // 8 bit gray scale or palette
        IEPrintLogWrite('_CopyBitmaptoDIBEx: ie8g or ie8p');
        pbi^.bmiHeader.biBitCount := 8;
        pb := @(pbi^.bmiColors);
        case fBitmap.PixelFormat of
          ie8p:
            begin
              // write color map
              for i:=0 to fBitmap.PaletteLength-1 do
              begin
                with fBitmap.Palette[i],PRGBQUAD(pb)^ do
                begin
                  rgbBlue:=b;
                  rgbGreen:=g;
                  rgbRed:=r;
                  rgbReserved:=0;
                end;
                inc(pb,sizeof(TRGBQUAD));
              end;
            end;
          ie8g:
            begin
              // write gray map
              for i:=0 to 255 do
              begin
                with PRGBQUAD(pb)^ do
                begin
                  rgbBlue:=i;
                  rgbGreen:=i;
                  rgbRed:=i;
                  rgbReserved:=0;
                end;
                inc(pb,sizeof(TRGBQUAD));
              end;
            end;
        end;
        // write image
        for q:=y2-1 downto y1 do
        begin
          pc := fBitmap.Scanline[q];
          inc(pc, x1);
          CopyMemory(pb, pc, lw);
          inc(pb, lw);
        end;
      end;
    ie24RGB:
      begin
        // 24 bit RGB
        IEPrintLogWrite('_CopyBitmaptoDIBEx: ie24RGB');
        pbi^.bmiHeader.biBitCount := 24;
        //pbi^.bmiHeader.biSizeImage:=_BitmapRowlen(ww,24)*hh;
        pb := @(pbi^.bmiColors);
        for q := y2 - 1 downto y1 do
        begin
          px := fbitmap.Scanline[q];
          inc(px, x1);
          CopyMemory(pb, px, lw);
          inc(pb, lw);
        end;
      end;
  end;
  GlobalUnLock(result);
end;

// Copy Len bits from Source to Dest
// Dest: pointer to destination buffer
// Source: pointer to source buffer
// DestStart: start bit of Dest
// SourceStart: start bit of Source
// Len: number of bits to copy
//
// for large "Len"s
procedure IECopyBits_large(Dest, Source: pbyte; DestStart, SourceStart, Len: integer; SourceRowLen: integer);
const
  mask1: array[0..7] of byte = ($0, $80, $C0, $E0, $F0, $F8, $FC, $FE);
  mask2: array[0..7] of byte = ($0, $1, $3, $7, $F, $1F, $3F, $7F);
  mask3: array[0..7] of byte = ($FF, $FE, $FC, $F8, $F0, $E0, $C0, $80);
var
  normalSourceStart, normalDestStart: integer;
  saveleft, saveright: byte;
  bitstosaveinright: integer;
  destrequiredbytes: integer;
  bytestocopy: integer;
  q: integer;
  pred, t, xmask3, xmask1, xmask2: byte;
  p1, p2, pr: pbyte;
  tbuf: pbyte;
begin
  if (Len <= 0) or (DestStart < 0) or (SourceStart < 0) then
    exit;
  inc(Dest, DestStart shr 3);
  inc(Source, SourceStart shr 3);
  dec(SourceRowLen, SourceStart shr 3);
  normalDestStart := DestStart and $7;
  normalSourceStart := SourceStart and $7;
  destrequiredbytes := (normalDestStart + Len + 7) shr 3;
  xmask3 := mask3[normalSourceStart];
  xmask2 := mask2[normalDestStart];
  xmask1 := mask1[normalSourceStart];
  // 1 save
  saveleft := Dest^ and mask1[normalDestStart];
  bitstosaveinright := (destrequiredbytes shl 3) - normalDestStart - Len;
  pr := @(pbytearray(Dest)[destrequiredbytes - 1]);
  saveright := pr^ and mask2[bitstosaveinright];
  // 2 copy
  bytestocopy := (normalSourceStart + Len + 7) shr 3;
  tbuf := allocmem(bytestocopy + 8); // we need 0 filled from SourceRowLen to bytestocopy+8
  copymemory(tbuf, Source, imin(bytestocopy + 8, SourceRowLen));
  //
  if ((Len and $7) <> 0) or (normalDestStart > 0) or (normalSourceStart > 0) then
  begin
    // 3 shift left
    if normalSourceStart > 0 then
    begin
      p1 := tbuf;
      p2 := tbuf;
      inc(p2);
      for q := 0 to bytestocopy - 1 do
      begin
        p1^ := ((p1^ shl normalSourceStart) and xmask3) or ((p2^ and xmask1) shr (8 - normalSourceStart));
        inc(p1);
        inc(p2);
      end;
    end;
    // 4 shift right
    if normalDestStart > 0 then
    begin
      pred := 0;
      p1 := tbuf;
      for q := 0 to destrequiredbytes - 1 do
      begin
        t := (p1^ and xmask2) shl (8 - normalDestStart);
        p1^ := (p1^ shr normalDestStart) or pred;
        pred := t;
        inc(p1);
      end;
    end;
    // 5 restore
    tbuf^ := (tbuf^ and (not mask1[normalDestStart])) or saveleft;
    pr := @(pbytearray(tbuf)[destrequiredbytes - 1]);
    pr^ := (pr^ and (not mask2[bitstosaveinright])) or saveright;
  end;
  copymemory(Dest, tbuf, destrequiredbytes);
  freemem(tbuf);
end;

// for small "Len"s
procedure IECopyBits_small(Dest, Source: pbyte; DestStart, SourceStart, Len: integer; SourceRowLen: integer);
var
 dx, sx:integer;
 bp:pbyte;
begin
  sx := SourceStart;
  for dx:=DestStart to DestStart+Len-1 do
  begin
    bp := @(pbytearray(Dest)^[dx shr 3]);
    if (pbytearray(Source)^[sx shr 3] and iebitmask1[sx and $7])<>0 then
      bp^ := bp^ or iebitmask1[dx and 7]
    else
      bp^ := bp^ and not iebitmask1[dx and 7];
    inc(sx);
  end;
end;



// Copies the specified area of Source in Dest
// PixelFormat of Source can be only pf24bit or pf1bit
// Width and Height of Dest are calculated from the specified area
// x1,y1,x2,y2: selection to copy (if x2 and y2 are Zero it copies the full bitmap)
procedure _CopyBitmapRect(Source, Dest: TBitmap; x1, y1, x2, y2: integer);
var
  pb, px: pbyte;
  hh, ww, lw: integer;
  y: integer;
  sinc, dinc: integer;
begin
  if x2 = 0 then
    x2 := Source.Width;
  if x2 > Source.Width then
    x2 := Source.Width;
  if y2 = 0 then
    y2 := Source.Height;
  if y2 > Source.Height then
    y2 := Source.Height;
  hh := y2 - y1;
  ww := x2 - x1;
  Dest.width := 1;
  Dest.height := 1;
  Dest.PixelFormat := Source.PixelFormat;
  Dest.Width := ww;
  Dest.Height := hh;
  dinc := -_PixelFormat2RowLen(Dest.Width, Dest.PixelFormat);
  sinc := -_PixelFormat2RowLen(Source.Width, Source.PixelFormat);
  if Source.Pixelformat = pf24bit then
  begin
    //// pf24bit
    lw := ww * 3;
    px := Source.Scanline[y1];
    inc(px, x1 * 3);
    pb := Dest.scanline[0];
    for y := 0 to hh - 1 do
    begin
      CopyMemory(pb, px, lw);
      inc(pb, dinc);
      inc(px, sinc);
    end;
  end
  else if Source.Pixelformat = pf1bit then
  begin
    //// pf1bit
    px := Source.Scanline[y1];
    pb := Dest.scanline[0];
    for y := 0 to hh - 1 do
    begin
      IECopyBits_large(pb, px, 0, x1, ww, -sinc);
      inc(pb, dinc);
      inc(px, sinc);
    end;
  end;
end;

{!!
<FS>TImageEnProc.BeginImageProcessing

<FM>Declaration<FC>
function BeginImageProcessing(allowedFormats:<A TIEPixelFormatSet>; var x1,y1,x2,y2:integer; const OpName:string; var ProcBitmap:<A TIEBitmap>; var mask:<A TIEMask>):boolean;

<FM>Description<FN>
BeginImageProcessing and <TImageEnProc.EndImageProcessing> allow you to create custom image processing functions handling automatically selection area, pixel format consistency and undo.

AllowedFormats specifies the pixel formats allowed.
x1, y1, x2, y2 are the destination rectangle coordinates where to apply the function.
OpName is a string describing the function.
ProcBitmap is the processing bitmap.
mask is the selection mask.

Using BeginImageProcessing/EndImageProcessing you can avoid considering if the selection is rectangle, elliptical, irregular or magic wand, just process the bitmap as a rectangle.

<FM>Example<FC>
procedure CustomNegative( proc:TImageEnProc );
var
  ProcBitmap:TIEBitmap;
  mask:TIEMask;
  x1,y1,x2,y2:integer;
  x,y:integer;
  px:PRGB;
begin
  // we support only ie24RGB format
  if not proc.BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'CustomNegative',ProcBitmap,mask) then
    exit;
  for y:=y1 to y2-1 do begin
    px:=ProcBitmap.Scanline[y];
    for x:=x1 to x2-1 do begin
      with px^ do begin
        r := 255-r;
        g := 255-g;
        b := 255-b;
      end;
      inc(px);
    end;
  end;
  // finalize
  proc.EndImageProcessing(ProcBitmap,mask);
end;

..
ImageEnView.SelectEllipse( 100,100, 100,100 );
CustomNegative( ImageEnView.Proc );
!!}
function TImageEnProc.BeginImageProcessing(allowedFormats: TIEPixelFormatSet; var x1, y1, x2, y2: integer; const OpName: string; var ProcBitmap: TIEBitmap; var mask: TIEMask): boolean;
var
  fPolyS: PPointArray;
  fPolySCount: integer;
begin
  result := false;
  if fAutoUndo then
    SaveUndoCaptioned(OpName, ieuImage);
  if not MakeConsistentBitmap(allowedFormats) then
    exit;
  GetReSel(x1, y1, x2, y2, fPolyS, fPolySCount, mask);
  if assigned(mask) and (not mask.IsEmpty) then
  begin
    ProcBitmap := TIEBitmap.Create;
    ProcBitmap.Allocate(mask.x2 - mask.x1 + 1, mask.y2 - mask.y1 + 1, fIEBitmap.PixelFormat);
    fIEBitmap.CopyRectTo(ProcBitmap, mask.x1, mask.y1, 0, 0, ProcBitmap.Width, ProcBitmap.Height);

    // 3.0.5:07012010:15:32
    if fIEBitmap.HasAlphaChannel then
      fIEBitmap.AlphaChannel.CopyRectTo(ProcBitmap.AlphaChannel, mask.x1, mask.y1, 0, 0, ProcBitmap.Width, ProcBitmap.Height);

    x1 := 0;
    y1 := 0;
    x2 := ProcBitmap.width;
    y2 := ProcBitmap.height;
  end
  else
    ProcBitmap := fIEBitmap;
  result := true;
end;

{!!
<FS>TImageEnProc.EndImageProcessing

<FM>Declaration<FC>
procedure EndImageProcessing(ProcBitmap:<A TIEBitmap>; mask:<A TIEMask>);

<FM>Description<FN>
BeginImageProcessing and EndImageProcessing allow you to create custom image processing functions handling automatically selection area, pixel format consistency and undo.

ProcBitmap is the processing bitmap coming from <TImageEnProc.BeginImageProcessing>.
mask is the selection mask coming from <TImageEnProc.BeginImageProcessing>.

Using BeginImageProcessing/EndImageProcessing you can avoid considering if the selection is rectangle, elliptical, irregular or magic wand, just process the bitmap as a rectangle.

<FM>Example<FC>
procedure CustomNegative( proc:TImageEnProc );
var
  ProcBitmap:TIEBitmap;
  mask:TIEMask;
  x1,y1,x2,y2:integer;
  x,y:integer;
  px:PRGB;
begin
  // we support only ie24RGB format
  if not proc.BeginImageProcessing([ie24RGB],x1,y1,x2,y2,'CustomNegative',ProcBitmap,mask) then
    exit;
  for y:=x1 to x2-1 do begin
    px:=ProcBitmap.Scanline[y];
    for x:=y1 to y2-1 do begin
      with px^ do begin
        r := 255-r;
        g := 255-g;
        b := 255-b;
      end;
      inc(px);
    end;
  end;
  // finalize
  proc.EndImageProcessing(ProcBitmap,mask);
end;

..
ImageEnView.SelectEllipse( 100,100, 100,100 );
CustomNegative( ImageEnView.Proc );
!!}
procedure TImageEnProc.EndImageProcessing(ProcBitmap: TIEBitmap; mask: TIEMask);
begin
  if ProcBitmap <> fIEBitmap then
  begin
    mask.CopyIEBitmap(fIEBitmap, ProcBitmap, false, true, false);
    if ProcBitmap.HasAlphaChannel and not ProcBitmap.AlphaChannel.Full then
    begin
      mask.CopyIEBitmap(fIEBitmap.AlphaChannel, ProcBitmap.AlphaChannel, false, true, false);
      fIEBitmap.AlphaChannel.Full := false;
    end;
    FreeAndNil(ProcBitmap);
  end;
  Update;
end;

{!!
<FS>TImageEnProc.BeginImageAnalysis

<FM>Declaration<FC>
function BeginImageAnalysis(allowedFormats: <A TIEPixelFormatSet>; var x1, y1, x2, y2: integer; var ProcBitmap: <A TIEBitmap>; var mask: <A TIEMask>): boolean;

<FM>Description<FN>
BeginImageAnalysis and <TImageEnProc.EndImageAnalysis> allow you to create custom image analysis functions handling automatically selection area, pixel format consistency.

AllowedFormats specifies the pixel formats allowed.
x1, y1, x2, y2 are the destination rectangle coordinates where to apply the function.
ProcBitmap is the processing bitmap.
mask is the selection mask.

Using BeginImageAnalysis/EndImageAnalysis you can avoid considering if the selection is rectangle, elliptical, irregular or magic wand, just process the bitmap as a rectangle.

<FM>Example<FC>

procedure SearchWhitePixel( proc:TImageEnProc );
var
  ProcBitmap:TIEBitmap;
  mask:TIEMask;
  x1,y1,x2,y2:integer;
  x,y:integer;
  px:PRGB;
begin
  // we support only ie24RGB format
  if not proc.BeginImageAnalysis([ie24RGB],x1,y1,x2,y2,ProcBitmap,mask) then
    exit;
  for y:=y1 to y2-1 do begin
    px:=ProcBitmap.Scanline[y];
    for x:=x1 to x2-1 do begin
      with px^ do
         if (r=255) and (g=255) and (b=255) then
	ShowMessage('Found White Pixel!');
      inc(px);
    end;
  end;
  // finalize
  proc.EndImageAnalysis(ProcBitmap);
end;

..
ImageEnView.SelectEllipse( 100,100, 100,100 );
SearchWhitePixel( ImageEnView.Proc );
!!}
function TImageEnProc.BeginImageAnalysis(allowedFormats: TIEPixelFormatSet; var x1, y1, x2, y2: integer; var ProcBitmap: TIEBitmap; var mask: TIEMask): boolean;
var
  fPolyS: PPointArray;
  fPolySCount: integer;
begin
  result := false;
  if not MakeConsistentBitmap(allowedFormats) then
    exit;
  GetReSel(x1, y1, x2, y2, fPolyS, fPolySCount, mask);
  if assigned(mask) and (not mask.IsEmpty) then
  begin
    ProcBitmap := TIEBitmap.Create;
    ProcBitmap.Allocate(mask.x2 - mask.x1 + 1, mask.y2 - mask.y1 + 1, fIEBitmap.PixelFormat);
    fIEBitmap.CopyRectTo(ProcBitmap, mask.x1, mask.y1, 0, 0, ProcBitmap.Width, ProcBitmap.Height);
    x1 := 0;
    y1 := 0;
    x2 := ProcBitmap.width;
    y2 := ProcBitmap.height;
  end
  else
    ProcBitmap := fIEBitmap;
  result := true;
end;

{!!
<FS>TImageEnProc.EndImageAnalysis

<FM>Declaration<FC>
procedure EndImageAnalysis(ProcBitmap: <A TIEBitmap>);

<FM>Description<FN>
<TImageEnProc.BeginImageAnalysis> and EndImageAnalysis allow you to create custom image analysis functions handling automatically selection area, pixel format consistency.

ProcBitmap is the processing bitmap coming from BeginImageAnalysis.

Using BeginImageAnalysis/EndImageAnalysis you can avoid considering if the selection is rectangle, elliptical, irregular or magic wand, just process the bitmap as a rectangle.

<FM>Example<FC>

procedure SearchWhitePixel( proc:TImageEnProc );
var
  ProcBitmap:TIEBitmap;
  mask:TIEMask;
  x1,y1,x2,y2:integer;
  x,y:integer;
  px:PRGB;
begin
  // we support only ie24RGB format
  if not proc.BeginImageAnalysis([ie24RGB],x1,y1,x2,y2,ProcBitmap,mask) then
    exit;
  for y:=y1 to y2-1 do begin
    px:=ProcBitmap.Scanline[y];
    for x:=x1 to x2-1 do begin
      with px^ do
         if (r=255) and (g=255) and (b=255) then
	ShowMessage('Found White Pixel!');
      inc(px);
    end;
  end;
  // finalize
  proc.EndImageAnalysis(ProcBitmap);
end;

..
ImageEnView.SelectEllipse( 100,100, 100,100 );
SearchWhitePixel( ImageEnView.Proc );
!!}
procedure TImageEnProc.EndImageAnalysis(ProcBitmap: TIEBitmap);
begin
  if ProcBitmap <> fIEBitmap then
    FreeAndNil(ProcBitmap);
end;

{!!
<FS>TImageEnProc.Negative

<FM>Declaration<FC>
procedure Negative;

<FM>Description<FN>
Negative method inverts all colors of the selected region.

<FM>Example<FC>
ImageEnView1.Proc.Negative;
!!}
procedure TImageEnProc.Negative;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([], x1, y1, x2, y2, IERS_NEGATIVE, ProcBitmap, mask) then
    exit;
  _Negative(ProcBitmap, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// negate the buffers
procedure _NegativeBuffer(buf: pbyte; WidthBytes: integer);
begin
  while WidthBytes > 0 do
  begin
    buf^ := not buf^;
    inc(buf);
    dec(WidthBytes);
  end;
end;

// As _Negative1Bit but works with TIEBitmap
// works only with ie1g
procedure _Negative1BitEx(Bitmap: TIEBitmap);
var
  x, y, dx: integer;
  w: pword;
begin
  dx := Bitmap.Rowlen div 2;
  for y := 0 to bitmap.Height - 1 do
  begin
    w := bitmap.scanline[y];
    for x := 0 to dx - 1 do
    begin
      w^ := not w^;
      inc(w);
    end;
  end;
end;

function IEMMX_Negative(bitmap:TIEBitmap; x1,y1,x2,y2:integer; fOnProgress: TIEProgressEvent; Sender: TObject):boolean;
const
  v255:int64=-1;
var
  row:integer;
  ppx: pRGB;
  per1: double;
  ww:integer;
begin
  result:=false;
  {$ifdef IEMMXSUPPORTED}
  if gMMX then
  begin
    per1 := 100 / (y2 - y1 + 0.5);
    ww:=x2-x1+1;  // width in pixels
    case Bitmap.PixelFormat of
      ie1g:
        begin
          if ((x1 mod 8)=0) and ((ww mod 8)=0) then
          begin
            result:=true;
            x1:=x1 div 8; // left position in bytes
            ww:=ww div 8; // width in bytes
          end;
        end;
      ie24RGB:
        begin
          result:=true;
          x1:=x1*3; // left position in bytes
          ww:=ww*3; // width in bytes
        end;
    end;

    if result and ((ww mod 8)=0) then
    begin
      for row := y1 to y2 do
      begin
        ppx := bitmap.ScanLine[row];
        asm
          MOV EAX, [ppx]
          ADD EAX, [x1]

          MOV EDX, EAX
          ADD EDX, [x1]
          ADD EDX, [ww]

          MOVQ mm2, [QWORD PTR v255]

          @loop:
            MOVQ mm0, [QWORD PTR EAX]
            MOVQ mm1, mm2
            PSUBB mm1,mm0
            MOVQ [EAX], mm1

            ADD EAX, 8
            CMP EAX, EDX
            JL @loop

          EMMS
        end;
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * (row - y1 + 1)));
      end;
    end
    else
      result:=false;

  end;
  {$endif}
end;

procedure _Negative(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  col, row: integer;
  ppx: pRGB;
  p_byte:pbyte;
  p_word:pword;
  p_48rgb:PRGB48;
  p_float:psingle;
  p_cmyk:PCMYK;
  p_cielab:PCIELAB;
  per1: double;
  bx: pbyte;
  tb: byte;
  bb: integer;
  cr,cg,cb:byte;
  rgb:TRGB;
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  if not IEMMX_Negative(bitmap,fSelX1,fSelY1,fSelX2,fSelY2,fOnProgress,Sender) then
  begin
    case Bitmap.PixelFormat of
      ie24RGB:
        for row := fSelY1 to fSelY2 do
        begin
          ppx := bitmap.ScanLine[row];
          inc(ppx, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            ppx^.r := 255 - ppx^.r;
            ppx^.g := 255 - ppx^.g;
            ppx^.b := 255 - ppx^.b;
            inc(ppx);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ie32RGB:
        for row := fSelY1 to fSelY2 do
        begin
          p_byte := bitmap.ScanLine[row];
          inc(p_byte, fSelX1*4);
          for col := fSelX1 to fSelX2 do
          begin
            p_byte^ := 255 - p_byte^; inc(p_byte);
            p_byte^ := 255 - p_byte^; inc(p_byte);
            p_byte^ := 255 - p_byte^; inc(p_byte);
            inc(p_byte);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ie1g:
        for row := fSelY1 to fSelY2 do
        begin
          bx := Bitmap.Scanline[row];
          inc(bx, fSelX1 shr 3);
          bb := 7 - (fSelX1 and 7);
          tb := bx^;
          for col := fSelX1 to fSelX2 do
          begin
            if (bx^ and (1 shl bb)) = 0 then
              tb := tb or (1 shl bb)
            else
              tb := tb and not (1 shl bb);
            dec(bb);
            if bb = -1 then
            begin
              bx^ := tb;
              inc(bx);
              tb := bx^;
              bb := 7;
            end;
          end;
          if bb < 7 then
            bx^ := tb;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ie8g:
        for row := fSelY1 to fSelY2 do
        begin
          p_byte := bitmap.ScanLine[row];
          inc(p_byte, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            p_byte^ := 255 - p_byte^;
            inc(p_byte);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ie8p:
        for bb:=0 to bitmap.PaletteLength-1 do
        begin
          with bitmap.Palette[bb] do
          begin
            cr:=r;
            cg:=g;
            cb:=b;
          end;
          bitmap.Palette[bb] := CreateRGB(255-cr,255-cg,255-cb);
        end;
      ie16g:
        for row := fSelY1 to fSelY2 do
        begin
          p_word := bitmap.ScanLine[row];
          inc(p_word, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            p_word^ := 65535 - p_word^;
            inc(p_word);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ie48RGB:
        for row := fSelY1 to fSelY2 do
        begin
          p_48rgb := bitmap.ScanLine[row];
          inc(p_48rgb, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            p_48rgb^.r := 255 - p_48rgb^.r;
            p_48rgb^.g := 255 - p_48rgb^.g;
            p_48rgb^.b := 255 - p_48rgb^.b;
            inc(p_48rgb);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ie32f:
        for row := fSelY1 to fSelY2 do
        begin
          p_float := bitmap.ScanLine[row];
          inc(p_float, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            p_float^ := 1 - p_float^;
            inc(p_float);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ieCIELab:
        for row := fSelY1 to fSelY2 do
        begin
          p_cielab := bitmap.ScanLine[row];
          inc(p_cielab, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            rgb:=IECIELAB2RGB(p_cielab^);
            with rgb do
            begin
              r:=255-r;
              g:=255-g;
              b:=255-b;
            end;
            p_cielab^:=IERGB2CIELAB(rgb);
            inc(p_cielab);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      ieCMYK:
        for row := fSelY1 to fSelY2 do
        begin
          p_cmyk := bitmap.ScanLine[row];
          inc(p_cmyk, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            rgb:=IECMYK2RGB(p_cmyk^);
            with rgb do
            begin
              r:=255-r;
              g:=255-g;
              b:=255-b;
            end;
            p_cmyk^:=IERGB2CMYK(rgb);
            inc(p_cmyk);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
    end;  // end case
  end;
end;

{!!
<FS>TImageEnProc.Flip

<FM>Declaration<FC>
procedure Flip(dir: <A TFlipDir>);

<FM>Description<FN>
This method flips (mirrors) the current image across the horizontal or vertical axis.  Flipping is not the same as rotation.
dir is the flip direction.

<FM>Example<FC>

Image1.Flip(fdHorizontal);
Image1.Flip(fdVertical);
!!}
procedure TImageEnProc.Flip(dir: TFlipDir);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_FLIP,ieuImage);
  _FlipEx(fIEBitmap, dir);
  Update;
  DoFinishWork;
end;

// Accepts TIEBitmap
// work with only ie24RGB, ie1g, ie8p, ie8g
procedure _FlipEx(bmp: TIEBitmap; dir: TFlipDir);
var
  x, y, w, h, xl: integer;
  newbitmap: TIEBitmap;
  newpx, oldpx: PRGB;
  newb, oldb, tbuf: pbyte;
begin
  newbitmap := TIEBitmap.create;
  newbitmap.Allocate(bmp.Width, bmp.Height, bmp.PixelFormat);
  w := bmp.width - 1;
  h := bmp.height - 1;
  case dir of
    fdHorizontal:
      if bmp.PixelFormat = ie24RGB then
        // ie24RGB
        for y := 0 to h do
        begin
          newpx := newbitmap.ScanLine[y];
          oldpx := bmp.ScanLine[y];
          inc(oldpx, w);
          for x := 0 to w do
          begin
            newpx^ := oldpx^;
            inc(newpx);
            dec(oldpx);
          end;
        end
      else
      if (bmp.PixelFormat = ie8p) or (bmp.PixelFormat = ie8g) then
      begin
        // ie8g/ie8p
        for y := 0 to h do
        begin
          newb := newbitmap.ScanLine[y];
          oldb := bmp.ScanLine[y];
          inc(oldb, w);
          for x := 0 to w do
          begin
            newb^ := oldb^;
            inc(newb);
            dec(oldb);
          end;
        end
      end
      else
      if bmp.PixelFormat = ie1g then
      begin
        // ie1g
        w := bmp.width div 8;
        if (bmp.width and 7) <> 0 then
        begin
          inc(w);
          xl := 8 - (bmp.width and 7); // we need to shift left the image
        end
        else
          xl := 0;
        if xl = 0 then
        begin
          for y := 0 to h do
          begin
            newb := newbitmap.ScanLine[y];
            oldb := bmp.ScanLine[y];
            inc(oldb, w - 1);
            for x := 0 to w - 1 do
            begin
              newb^ := oldb^;
              ReverseBitsB(newb^);
              inc(newb);
              dec(oldb);
            end;
          end;
        end
        else
        begin
          // need to shift
          getmem(tbuf, w);
          for y := 0 to h do
          begin
            newb := tbuf;
            oldb := bmp.ScanLine[y];
            inc(oldb, w - 1);
            for x := 0 to w - 1 do
            begin
              newb^ := oldb^;
              ReverseBitsB(newb^);
              inc(newb);
              dec(oldb);
            end;
            IECopyBits_large(newbitmap.scanline[y], tbuf, 0, xl, bmp.Width, w);
          end;
          freemem(tbuf);
        end;

      end;
    fdVertical:
      if bmp.PixelFormat=ie24RGB then
        for y := 0 to h do
          copymemory(newbitmap.scanline[y], bmp.scanline[h - y], 3 * bmp.Width)
      else
      begin
        for y := 0 to h do
          copymemory(newbitmap.scanline[y], bmp.scanline[h - y], bmp.RowLen)
      end;
  end;
  bmp.AssignImage(newbitmap);
  FreeAndNil(newbitmap);

  if bmp.HasAlphaChannel then
    _FlipEx(bmp.AlphaChannel,dir);
end;

{!!
<FS>TImageEnProc.PreviewFont

<FM>Declaration<FC>
property PreviewFont: TFont;

<FM>Description<FN>
The PreviewFont property contains the font used in the Previews dialog (<A TImageEnProc.DoPreviews>).
Make sure the size of the font matches label's length.

<FM>Example<FC>

ImageEnView1.Proc.PreviewFont.Name:='MS Times New Roman';
ImageEnView1.Proc.DoPreviews([peAll]);
!!}
procedure TImageEnProc.SetPreviewFont(f: TFont);
begin
  fPreviewFont.assign(f);
end;

{!!
<FS>TImageEnProc.CastColorRange

<FM>Declaration<FC>
procedure CastColorRange(BeginColor, EndColor, CastColor: <A TRGB>);

<FM>Description<FN>
Use this method to force all colors included in the range BeginColor and EndColor to be equal to CastColor.

<FM>Example<FC>

// Force to black all gray levels from 50 to 100
var
  BeginColor, EndColor, CastColor:TRGB;
Begin
  BeginColor:=CreateRGB(50,50,50);
  EndColor:=CreateRGB(100,100,100);
  CastColor:=CreateRGB(0,0,0);
  ImageEnView1.Proc.CastColorRange(BeginColor,EndColor,CastColor);
End;

!!}
procedure TImageEnProc.CastColorRange(BeginColor, EndColor, CastColor: TRGB);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_CASTCOLORRANGE, ProcBitmap, mask) then
    exit;
  _CastColorRange(ProcBitmap, BeginColor, EndColor, CastColor, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

// ret number of casted pixels
function IEMatchHSVRange(bitmap:TIEBitmap; HueBegin, HueEnd, SatBegin, SatEnd, ValBegin, ValEnd:integer; ColorizeMatched:boolean; MatchColor:TRGB; ColorizeNonMatched:boolean; NonMatchColor:TRGB; fSelx1, fSely1, fSelx2, fSely2:integer; fOnProgress:TIEProgressEvent; Sender:TObject):integer;
var
  row, col:integer;
  px:PRGB;
  h, s, v:integer;
  per1:double;
begin
  result := 0;
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for row:=fSelY1 to fSelY2 do
  begin
    px := bitmap.Scanline[row];
    inc(px, fSelX1);
    for col:=fSelX1 to fSelX2 do
    begin
      RGB2HSV(px^, h, s, v);
      if (h>=HueBegin) and (h<=HueEnd) and (s>=SatBegin) and (s<=SatEnd) and (v>=ValBegin) and (v<=ValEnd) then
      begin
        if ColorizeMatched then
          px^ := MatchColor;
        inc(result);
      end
      else if ColorizeNonMatched then
        px^ := NonMatchColor;
      inc(px);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
  end;
end;

{!!
<FS>TImageEnProc.MatchHSVRange

<FM>Declaration<FC>
function MatchHSVRange(HueBegin, HueEnd, SatBegin, SatEnd, ValBegin, ValEnd:integer; ColorizeMatched:boolean; MatchColor:TRGB; ColorizeNonMatched:boolean; NonMatchColor:TRGB):integer;

<FM>Description<FN>
If <FC>ColorizeMatched<FN> is true then this method colorizes pixels that match the specified HSV (Hue, Saturation and Value) range to <FC>MatchColor<FN> color.
If <FC>ColorizeNonMatched<FN> is true, non matching pixels are set to <FC>NonMatchColor<FN>.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>HueBegin<FN></C> <C>Starting Hue value. 0..359</C> </R>
<R> <C><FC>HueEnd<FN></C> <C>Ending Hue value. 0..359</C> </R>
<R> <C><FC>SatBegin<FN></C> <C>Starting Saturation value. 0..99</C> </R>
<R> <C><FC>SatEnd<FN></C> <C>Ending Saturation value. 0..99</C> </R>
<R> <C><FC>ValBegin<FN></C> <C>Starting Intensity value. 0..99</C> </R>
<R> <C><FC>ValEnd<FN></C> <C>Ending Intensity value. 0..99</C> </R>
<R> <C><FC>ColorizeMatched<FN></C> <C>If true next parameter specifies the matched color.</C> </R>
<R> <C><FC>MatchColor<FN></C> <C>New pixel color when HSV conversion fit inside specified ranges.</C> </R>
<R> <C><FC>ColorizeNonMatched<FN></C> <C>If true next parameter specifies the non-matched color.</C> </R>
<R> <C><FC>NonMatchColor<FN></C> <C>New pixel color when HSV conversion does not fit inside specified ranes.</C> </R>
</TABLE>

Returns the number of matching pixels.
!!}
function TImageEnProc.MatchHSVRange(HueBegin, HueEnd, SatBegin, SatEnd, ValBegin, ValEnd:integer; ColorizeMatched:boolean; MatchColor:TRGB; ColorizeNonMatched:boolean; NonMatchColor:TRGB):integer;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  result := 0;
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_MATCHHSVRANGE, ProcBitmap, mask) then
    exit;
  result := IEMatchHSVRange(ProcBitmap, HueBegin, HueEnd, SatBegin, SatEnd, ValBegin, ValEnd, ColorizeMatched, MatchColor, ColorizeNonMatched, NonMatchColor, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

// Compare Bitmap1 with Bitmap2, return True if the images are equals
function _BitmapCompareX(Bitmap1, Bitmap2: TBitmap): boolean;
var
  l: integer;
begin
  if (Bitmap1.Width <> Bitmap2.Width) or (Bitmap1.Height <> Bitmap2.Height) then
  begin
    result := false;
    exit;
  end;
  l := _PixelFormat2RowLen(bitmap1.width, bitmap1.pixelformat); // row length
  result := CompareMem(Bitmap1.ScanLine[Bitmap1.Height - 1],
    Bitmap2.ScanLine[Bitmap2.Height - 1],
    l * Bitmap1.Height);
end;

// Compare Bitmap1 with Bitmap2, return True if the images are equals
function _BitmapCompareXEx(Bitmap1, Bitmap2: TIEBitmap): boolean;
var
  y: integer;
begin
  if (Bitmap1.Width <> Bitmap2.Width) or (Bitmap1.Height <> Bitmap2.Height) then
  begin
    result := false;
    exit;
  end;
  if Bitmap1.HasAlphaChannel <> Bitmap2.HasAlphaChannel then
  begin
    result := false;
    exit;
  end;
  // compare image
  for y := 0 to bitmap1.Height - 1 do
  begin
    result := CompareMem(Bitmap1.ScanLine[y], Bitmap2.ScanLine[y], Bitmap1.RowLen);
    if not result then
      exit;
  end;
  // compare alpha
  if Bitmap1.hasalphaChannel then
  begin
    for y := 0 to bitmap1.AlphaChannel.Height - 1 do
    begin
      result := CompareMem(Bitmap1.AlphaChannel.ScanLine[y], Bitmap2.AlphaChannel.ScanLine[y], Bitmap1.AlphaChannel.RowLen);
      if not result then
        exit;
    end;
  end;
  result := true;
end;

// Creates a DIB from specified polygonal selection
function _CopyBitmaptoDibPolyEx(Source: TIEBitmap; sx1, sy1, sx2, sy2: integer; SelPoly: PPointArray; SelPolyCount: integer; mask: TIEMask; fillcolor: integer; dpix, dpiy:integer): THandle;
var
  tmpbmp: TIEBitmap;
begin
  tmpbmp := TIEBitmap.Create;
  tmpbmp.Allocate(mask.x2 - mask.x1 + 1, mask.y2 - mask.y1 + 1, Source.PixelFormat);
  tmpbmp.Fill(fillcolor);
  mask.CopyIEBitmap(tmpbmp, Source, true, false, false);
  result := _CopyBitmaptoDIBEx(tmpbmp, 0, 0, tmpbmp.width, tmpbmp.height, dpix,dpiy);
  FreeAndNil(tmpbmp);
end;

{!!
<FS>TImageEnProc.SelCopyToClip

<FM>Declaration<FC>
function SelCopyToClip(UseInternalFormat:boolean):boolean;

<FM>Description<FN>
This method copies the selected region to the clipboard.
If UseInternalFormat is True, two bitmap are saved: one in standard DIB format and one in internal format which preserves pixelformat and alpha channel.
Returns true on successful.
!!}
function TImageEnProc.SelCopyToClip(UseInternalFormat:boolean):boolean;
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  hbi: THandle;
  mask: TIEMask;
  memHandle:THandle;
  bmp:TIEBitmap;
begin
  result:=false;
  if not MakeConsistentBitmap([]) then
    exit;
  if GetReSel(fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask) then
  begin
    if IEOpenClipboard then
    begin

      try

        EmptyClipboard;

        // DIB format
        if assigned(mask) and (not mask.IsEmpty) then
          hbi := _CopyBitmaptoDibPolyEx(fIEBitmap, fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask, integer(GetReBackground), GetDPIX,GetDPIY)
        else
          hbi := _CopyBitmaptoDIBEx(fIEBitmap, fsx1, fsy1, fsx2, fsy2, GetDPIX, GetDPIY);

        if hbi=0 then
          exit;

        if SetClipboardData(CF_DIB, hbi)=0 then
        begin
          GlobalFree(hbi);
          exit;
        end;

        // internal format
        if UseInternalFormat then
        begin
          bmp:=TIEBitmap.Create;
          //fIEBitmap.CopyWithMask1(bmp, mask, clBlack);
          fIEBitmap.CopyWithMask1(bmp, mask); // 2.3.1
          memHandle := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, bmp.CalcRAWSize);
          if memHandle<>0 then
          begin
            bmp.SaveRAWToBufferOrStream( GlobalLock(memHandle), nil );
            GlobalUnLock(memHandle);
            if SetClipboardData(IERAWCLIPFORMAT, memHandle)=0 then
              GlobalFree(memHandle);  // fail
          end;
          bmp.free;
        end;

        result:=true;

      finally
        CloseClipboard;
      end;
    end;
  end
  else
    result:=CopyToClipboard(UseInternalFormat);
end;

{!!
<FS>TImageEnProc.SelCutToClip

<FM>Declaration<FC>
function SelCutToClip(UseInternalFormat:boolean):boolean;

<FM>Description<FN>
This method copies and cuts the selected region to the clipboard.
If UseInternalFormat is True, two bitmap are saved: one in standard DIB format and one in internal format which preserves pixelformat and alpha channel.
Returns true on successful.
!!}
function TImageEnProc.SelCutToClip(UseInternalFormat:boolean):boolean;
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  hbi: THandle;
  mask: TIEMask;
  memHandle:THandle;
  bmp:TIEBitmap;
begin
  result:=false;
  if not MakeConsistentBitmap([]) then
    exit;
  if GetReSel(fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask) then
  begin
    if fAutoUndo then
      SaveUndoCaptioned(IERS_SELCUTTOCLIP, ieuImage);
    if IEOpenClipboard then
    begin

      try

        EmptyClipboard;

        // DIB format
        if assigned(mask) and (not mask.IsEmpty) then
          hbi := _CopyBitmaptoDibPolyEx(fIEBitmap, fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask, GetReBackground, GetDPIX,GetDPIY)
        else
          hbi := _CopyBitmaptoDIBEx(fIEBitmap, fsx1, fsy1, fsx2, fsy2, GetDPIX,GetDPIY);

        if hbi=0 then
          exit;

        if SetClipboardData(CF_DIB, hbi)=0 then
        begin
          GlobalFree(hbi);
          exit;
        end;

        // internal format
        if UseInternalFormat then
        begin
          bmp:=TIEBitmap.Create;
          fIEBitmap.CopyWithMask1(bmp, mask);  // 2.3.1
          memHandle := GlobalAlloc(GMEM_MOVEABLE or GMEM_DDESHARE, bmp.CalcRAWSize);
          if memHandle<>0 then
          begin
            bmp.SaveRAWToBufferOrStream( GlobalLock(memHandle),nil );
            GlobalUnLock(memHandle);
            if SetClipboardData(IERAWCLIPFORMAT, memHandle)=0 then
              GlobalFree(memHandle);  // fail
          end;
          bmp.free;
        end;

        result:=true;

      finally
        CloseClipboard;
      end;
    end;
    if result then
    begin
      if assigned(mask) and (not mask.IsEmpty) then
        // polygonal selection
        _ClearSelMaskEx(fIEBitmap, mask, GetReBackground)
      else
        fIEBitmap.FillRect(fSx1, fSy1, fSx2 - 1, fSy2 - 1, GetReBackground);
      Update;
    end;
  end;
end;

{!!
<FS>TImageEnProc.Clear

<FM>Declaration<FC>
procedure Clear;

<FM>Description<FN>
Use this method to completely fill the current image with the Background color.

<FM>Example<FC>

ImageEnView1.Proc.Background:=clWhite;
ImageEnView1.Proc.Clear;

!!}
procedure TImageEnProc.Clear;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CLEAR, ieuImage);
  fIEBitmap.Fill(GetReBackground);
  Update;
  DoFinishWork;
end;

procedure _ClearSelMaskEx(fIEBitmap: TIEBitmap; mask: TIEMask; Background: TColor);
var
  tmpbmp: TIEBitmap;
begin
  tmpbmp := TIEBitmap.Create;
  tmpbmp.Allocate(mask.x2 - mask.x1 + 1, mask.y2 - mask.y1 + 1, fIEBitmap.PixelFormat);
  fIEBitmap.CopyRectTo(tmpbmp, mask.x1, mask.y1, 0, 0, tmpbmp.Width, tmpbmp.Height);
  tmpbmp.Fill(Background);
  mask.CopyIEBitmap(fIEBitmap, tmpbmp, false, true, false);
  FreeAndNil(tmpbmp);
end;

{!!
<FS>TImageEnProc.ClearSel

<FM>Declaration<FC>
procedure ClearSel;

<FM>Description<FN>
ClearSel fills the selected region with the current background color.

!!}
procedure TImageEnProc.ClearSel;
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  mask: TIEMask;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CLEARSEL, ieuImage);
  GetReSel(fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask);
  if assigned(mask) and (not mask.IsEmpty) then
    _ClearSelMaskEx(fIEBitmap, mask, GetReBackground);
  Update;
  DoFinishWork;
end;

// copy the DIB hbi to fBitmap
function _IECopyDIB2Bitmap2Ex(hbi: THandle; fBitmap: TIEDibBitmap; xbits: pbyte; unlck: boolean): integer;
var
  pbi: PBITMAPINFO;
  hdb: HDRAWDIB;
  Width, Height: integer; // image width and height
  BitCount, y: integer; // Bitcount
  bits: pbyte;
  Compression: DWORD; // compression type
begin
  if unlck then
    pbi := pointer(hbi)
  else
    pbi := GlobalLock(hbi);
  Width := pbi^.bmiHeader.biWidth;
  Height := pbi^.bmiHeader.biHeight;
  BitCount := pbi^.bmiHeader.biBitCount;
  Compression := pbi^.bmiHeader.biCompression;
  result := BitCount;
  bits := nil;
  case BitCount of
    1:
      begin
        fBitmap.AllocateBits(Width, Height, 1);
        bits := pbyte(pbi);
        inc(bits, pbi^.bmiHeader.biSize);
        y := pbi^.bmiHeader.biClrUsed;
        if y = 0 then
          y := 2;
        inc(bits, sizeof(TRGBQUAD) * y); // bypass colormap
      end;
    4:
      begin
        fBitmap.AllocateBits(Width, Height, 24);
        bits := pbyte(pbi);
        inc(bits, pbi^.bmiHeader.biSize);
        y := pbi^.bmiHeader.biClrUsed;
        if y = 0 then
          y := 16;
        inc(bits, sizeof(TRGBQUAD) * y); // bypass colormap
      end;
    8:
      begin
        fBitmap.AllocateBits(Width, Height, 24);
        bits := pbyte(pbi);
        inc(bits, pbi^.bmiHeader.biSize);
        y := pbi^.bmiHeader.biClrUsed;
        if y = 0 then
          y := 256;
        inc(bits, sizeof(TRGBQUAD) * y); // bypass colormap
      end;
    16:
      begin
        fBitmap.AllocateBits(Width, Height, 24);
        bits := pbyte(pbi);
        inc(bits, pbi^.bmiHeader.biSize);
      end;
    24:
      begin
        fBitmap.AllocateBits(Width, Height, 24);
        bits := pbyte(pbi);
        inc(bits, pbi^.bmiHeader.biSize);
      end;
    32:
      begin
        fBitmap.AllocateBits(Width, Height, 24);
        if Compression = BI_BITFIELDS then
        begin
          // BITFIELDS, bitfield must be FF,00FF and 0000FF
          bits := pbyte(pbi);
          inc(bits, pbi^.bmiHeader.biSize);
          inc(bits, 3 * sizeof(dword)); // bypass bitfield
        end
        else if Compression = BI_RGB then
        begin
          bits := pbyte(pbi);
          inc(bits, pbi^.bmiHeader.biSize);
        end;
      end;
  end;
  if xbits <> nil then
    bits := xbits;
  if bits <> nil then
  begin
    hdb := IEDrawDibOpen;
    IEDrawDibDraw(hdb, fBitmap.HDC, 0, 0, Width, Height, PBitmapInfoHeader(pbi)^, bits, 0, 0, Width, Height, 0);
    IEDrawDibClose(hdb);
  end;
  if not unlck then
    GlobalUnLock(hbi);
end;

{!!
<FS>TImageEnProc.CropSel

<FM>Declaration<FC>
procedure CropSel(TransparencyOnly:boolean=false);

<FM>Description<FN>
CropSel cuts the selected region and copies as current image, without use clipboard.
When TransparencyOnly is true only the alpha channel is cut.

<FM>Example<FC>

// Cut region 10,10,100,100
ImageEnView1.Select(10,10,100,100);
ImageEnView1.Proc.CropSel;

// Photoshop like cut
IMageEnView1.Select(10,10,100,100);
ImageEnView1.Proc.CropSel(true);
!!}
procedure TImageEnProc.CropSel(TransparencyOnly:boolean);
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  tmpbmp: TIEBitmap;
  mask: TIEMask;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CROPSEL, ieuImage);
  if GetReSel(fsx1, fsy1, fsx2, fsy2, fPolyS, fPolySCount, mask) and assigned(mask) and (not mask.IsEmpty) then
  begin
    if TransparencyOnly then
    begin
      fIEBitmap.AlphaChannel.CopyFromTIEMask(mask);
    end
    else
    begin
      tmpbmp := TIEBitmap.Create;
      tmpbmp.Allocate(mask.x2 - mask.x1 + 1, mask.y2 - mask.y1 + 1, fIEBitmap.PixelFormat);
      tmpbmp.Fill(GetReBackground);
      mask.CopyIEBitmap(tmpbmp, fIEBitmap, true, false, true);
      fIEBitmap.Assign(tmpbmp);
      FreeAndNil(tmpbmp);
      // do we need alpha channel?
      fIEBitmap.AlphaChannel.SyncFull;
      if fIEBitmap.AlphaChannel.Full then
        fIEBitmap.RemoveAlphaChannel;
    end;
  end;
  Update;
  DoFinishWork;
end;


{!!
<FS>TImageEnProc.ConvertTo

<FM>Declaration<FC>
procedure ConvertTo(NumColors: integer; DitherMethod:<A TIEDitherMethod>);

<FM>Description<FN>
The ConvertTo method reduces number of colors to NumColor value.
DitherMethod specifies how to convert a color image to a black/white. It can be ieOrdered or ieThreshold.


<FM>Example<FC>

// Converts current image to 256 colors
ImageEnView1.Proc.ConvertTo(256);

// Converts current image to 461 (!) colors
ImageEnView1.Proc.ConvertTo(461);
!!}
// Decreases the colors number
// NumColors: Desidered color count
// If NumColors=2 then calls ConvertToBWOrdered or ConvertTOBWThreshold
procedure TImageEnProc.ConvertTo(NumColors: integer; DitherMethod: TIEDitherMethod);
var
  Progress: TProgressRec;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(Format(IERS_CONVERTTO, [NumColors]), ieuImage);
  if NumColors < 3 then
  begin
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    if DitherMethod = ieOrdered then
      _ConvertToBWOrdered(fIEBitmap, Progress)
    else
      _ConvertToBWThreshold(fIEBitmap, -1, Progress);
  end
  else if NumColors < 1025 then
    _ConvertToEx(fIEBitmap, NumColors, nil, fOnProgress, self);
  Update;
  DoFinishWork;
end;

// Decreases the colors number
// NumColors: desidered color count
// If NumColors=2 then calls ConvertToBWOrdered

{!!
<FS>TImageEnProc.ConvertToPalette

<FM>Declaration<FC>
procedure ConvertToPalette(NumColors:integer; Palette:pointer; DitherMethod:<A TIEDitherMethod>);

<FM>Description<FN>
ConvertToPalette reduces number of colors to NumColor value and fills the Palette array with the color map used to reduce colors.

DitherMethod specifies how to convert a color image to a black/white. It can be ieOrdered or ieThreshold.

<FM>Example<FC>

var
  Palette:array [0..255] of TRGB;
begin
  ImageEnView1.Proc.ConvertToPalette(256,@Palette[0],ieOrdered);
...
end;

!!}
procedure TImageEnProc.ConvertToPalette(NumColors: integer; Palette: pointer; DitherMethod: TIEDitherMethod);
var
  Progress: TProgressRec;
  xpal: PRGBROW;
begin
  if NumColors = 0 then
    exit;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  xpal := Palette;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CONVERTTOPALETTE, ieuImage);
  if NumColors < 3 then
  begin
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    if DitherMethod = ieOrdered then
      _ConvertToBWOrdered(fIEBitmap, Progress)
    else
      _ConvertToBWThreshold(fIEBitmap, -1, Progress);
    xpal[0] := CreateRGB(0, 0, 0);
    xpal[1] := CreateRGB(255, 255, 255);
  end
  else if NumColors < 1025 then
    _ConvertToEx(fIEBitmap, NumColors, Palette, fOnProgress, self);
  Update;
  DoFinishWork;
end;

procedure _ConvertToEx(Bitmap: TIEBitmap; NumColors: integer; OutPalette: PRGBROW; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  per1: double;
  palette: PRGBROW;
  x, y, i: integer;
  e: pRGB;
  qt: TIEQuantizer;
  bitmapwidth1, bitmapheight1: integer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  if OutPalette = nil then
    getmem(palette, sizeof(TRGB) * NumColors)
  else
    palette := OutPalette;
  per1 := 100 / (bitmap.height + 0.5);
  qt := TIEQuantizer.Create(Bitmap, palette^, NumColors);
  bitmapheight1 := bitmap.height - 1;
  bitmapwidth1 := bitmap.width - 1;
  for y := 0 to bitmapheight1 do
  begin
    e := bitmap.ScanLine[y];
    for x := 0 to bitmapwidth1 do
    begin
      i := qt.RGBIndex[e^];
      e^ := palette^[i];
      inc(e);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y + 1)));
  end;
  FreeAndNil(qt);
  if OutPalette = nil then
    freemem(palette);
end;

procedure _ConvertToBWOrdered(bitmap: TIEBitmap; var Progress: TProgressRec);
var
  x, y, v, b: integer;
  newbmp: TIEBitmap;
  p1: pRGB;
  p2: pbyte;
  bitmapwidth1, bitmapheight1: integer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  progress.per1 := 100 / (bitmap.height + 0.5);
  newbmp := TIEBitmap.Create;
  newbmp.Allocate(bitmap.Width, bitmap.Height, ie1g);
  bitmapheight1 := bitmap.height - 1;
  bitmapwidth1 := bitmap.width - 1;
  for y := 0 to bitmapheight1 do
  begin
    p1 := bitmap.ScanLine[y];
    p2 := newbmp.ScanLine[y];
    for x := 0 to bitmapwidth1 do
    begin
      b := x and 7;
      with p1^ do
      begin
        if (r > 250) and (g > 250) and (b > 250) then
          v := 64
        else
          v := ((r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100) shr 2;
      end;
      if v > BWORDERPATTERN[x and 7][y and 7] then
        p2^ := p2^ or iebitmask1[b]
      else
        p2^ := p2^ and (not iebitmask1[b]);
      inc(p1);
      if b = 7 then
        inc(p2);
    end;
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + 1)));
  end;
  bitmap.AssignImage(newbmp);
  FreeAndNil(newbmp);
end;

// Converts current image to Black/White with ordered dithering (Bayer algorithm)
// The image must be pf24bit

{!!
<FS>TImageEnProc.ConvertToBWOrdered

<FM>Declaration<FC>
procedure ConvertToBWOrdered;

<FM>Description<FN>
Converts a true color image (24 bit) to black & white (1 bit) with a dithering ordered method.

!!}
procedure TImageEnProc.ConvertToBWOrdered;
var
  Progress: TProgressRec;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CONVERTTOBWORDERED, ieuImage);
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  _ConvertToBWOrdered(fIEBitmap, Progress);
  Update;
  DoFinishWork;
end;

// If Threshold is -1 this one is autocalculated (median value), -2 maximum entropy
// bitmap: Accept all TIEPixelFormat values

procedure _ConvertToBWThreshold(bitmap: TIEBitmap; Threshold: integer; var Progress: TProgressRec);
var
  newbmp: TIEBitmap;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  newbmp := TIEBitmap.Create;
  newbmp.Allocate(bitmap.width, bitmap.height, ie1g);
  _ConvertToBWThresholdEx(bitmap, newbmp, Threshold, Progress);
  bitmap.AssignImage(newbmp);
  FreeAndNil(newbmp);
end;

// Filter functions for resampling

function HermiteFilter(Value: double): double;
begin
  if (Value < 0.0) then
    Value := -Value;
  if (Value < 1.0) then
    Result := (2 * Value - 3) * sqr(Value) + 1
  else
    Result := 0.0;
end;
// Triangle filter

function TriangleFilter(Value: double): double;
begin
  if (Value < 0.0) then
    Value := -Value;
  if (Value < 1.0) then
    Result := 1.0 - Value
  else
    Result := 0.0;
end;
// Bell filter

function BellFilter(Value: double): double;
begin
  if (Value < 0.0) then
    Value := -Value;
  if (Value < 0.5) then
    Result := 0.75 - Sqr(Value)
  else if (Value < 1.5) then
  begin
    Value := Value - 1.5;
    Result := 0.5 * Sqr(Value);
  end
  else
    Result := 0.0;
end;
// B-spline filter

function SplineFilter(Value: double): double;
var
  tt: double;
begin
  if (Value < 0.0) then
    Value := -Value;
  if (Value < 1.0) then
  begin
    tt := Sqr(Value);
    Result := 0.5 * tt * Value - tt + 2.0 / 3.0;
  end
  else if (Value < 2.0) then
  begin
    Value := 2.0 - Value;
    Result := 1.0 / 6.0 * Sqr(Value) * Value;
  end
  else
    Result := 0.0;
end;
// Lanczos3 filter

function Lanczos3Filter(Value: double): double;
  function SinC(Value: double): double;
  begin
    if (Value <> 0.0) then
    begin
      Value := Value * Pi;
      Result := sin(Value) / Value
    end
    else
      Result := 1.0;
  end;
begin
  if (Value < 0.0) then
    Value := -Value;
  if (Value < 3.0) then
    Result := SinC(Value) * SinC(Value / 3.0)
  else
    Result := 0.0;
end;

function MitchellFilter(Value: double): double;
const
  B = (1.0 / 3.0);
  C = (1.0 / 3.0);
var
  tt: double;
begin
  if (Value < 0.0) then
    Value := -Value;
  tt := Sqr(Value);
  if (Value < 1.0) then
  begin
    Value := (((12.0 - 9.0 * B - 6.0 * C) * (Value * tt)) + ((-18.0 + 12.0 * B + 6.0 * C) * tt) + (6.0 - 2 * B));
    Result := Value / 6.0;
  end
  else if (Value < 2.0) then
  begin
    Value := (((-1.0 * B - 6.0 * C) * (Value * tt)) + ((6.0 * B + 30.0 * C) * tt) + ((-12.0 * B - 48.0 * C) * Value) + (8.0 * B + 24 * C));
    Result := Value / 6.0;
  end
  else
    Result := 0.0;
end;
// Nearest Filter

function NearestFilter(Value: Double): Double;
begin
  if (Value > -0.5) and (Value <= 0.5) then
    Result := 1
  else
    Result := 0;
end;
// Linear Filter

function LinearFilter(Value: Double): Double;
begin
  if Value < -1 then
    Result := 0
  else if Value < 0 then
    Result := 1 + Value
  else if Value < 1 then
    Result := 1 - Value
  else
    Result := 0;
end;

// Converts the current image to Black/White with threshold (0..255)
// If Threshold is -1 it is automatically calculated, -2 maximum entropy
// The image must be pf24bit

{!!
<FS>TImageEnProc.ConvertToBWThreshold

<FM>Declaration<FC>
procedure ConvertToBWThreshold(Threshold:integer);

<FM>Description<FN>
Converts a true color image (24 bit) to black & white (1 bit) using a thresholding algorithm.

The image is first converted to gray levels, then all levels that are less of Threshold will be set to black, otherwise will be set to white.
Threshold is an intensity value (0..255).
If Threshold is -1, the threshold value actualy used will be the average of all levels of the original image.
If Threshold is -2, a Maximum Entropy Algorithm is used.


<FM>Example<FC>

// All pixels < 128 wil be black >=128 will be white
ImageEnView1.Proc.ConvertToBWThreshold(128);

// auto calculate the threshold value as the average of all color levels
ImageEnView1.Proc.ConvertToBWThreshold(-1);

// use maximum entropy algorithm
ImageEnView1.Proc.ConvertToBWThreshold(-2);
!!}
procedure TImageEnProc.ConvertToBWThreshold(Threshold: integer);
var
  Progress: TProgressRec;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(Format(IERS_CONVERTTOBWTHRESHOLD, [Threshold]), ieuImage);
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  _ConvertToBWThreshold(fIEBitmap, Threshold, Progress);
  Update;
  DoFinishWork;
end;

// convert a row from 1bit to 24bit

procedure _ConvRow1To24(spx, dpx: pbyte; Width: integer);
var
  x, xx: integer;
begin
  xx := (Width div 8) - 1;
  for x := 0 to xx do
  begin
    CopyMemory(dpx, @(C1TO24[spx^]), 24);
    inc(spx);
    inc(dpx, 24);
  end;
  x := Width and 7;
  if x <> 0 then
    // copy remaining
    CopyMemory(dpx, @(C1TO24[spx^]), x * 3);
end;

// Converts from pf1bit (SrcBitmap) to pf24bit (DstBitmap)
// note: uses the table C1TO24

procedure _Conv1to24(var SrcBitmap, DstBitmap: TBitmap; var Progress: TProgressRec);
var
  spx, dpx: pbyte;
  x, y: integer;
  xx: integer;
begin
  DstBitmap.Width := 1;
  DstBitmap.Height := 1;
  DstBitmap.PixelFormat := pf24bit;
  DstBitmap.Width := SrcBitmap.Width;
  DstBitmap.Height := SrcBitmap.Height;
  xx := (SrcBitmap.Width div 8) - 1;
  progress.per1 := 100 / (SrcBitmap.height + 0.5);
  for y := 0 to SrcBitmap.Height - 1 do
  begin
    spx := SrcBitmap.ScanLine[y];
    dpx := DstBitmap.ScanLine[y];
    for x := 0 to xx do
    begin
      CopyMemory(dpx, @(C1TO24[spx^]), 24);
      inc(spx);
      inc(dpx, 24);
    end;
    x := SrcBitmap.Width and 7;
    if x <> 0 then
      // copy remaining
      CopyMemory(dpx, @(C1TO24[spx^]), x * 3);
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + 1)));
  end;
end;

procedure _Conv1to24Ex(var SrcBitmap, DstBitmap: TIEBitmap; var Progress: TProgressRec);
var
  spx, dpx: pbyte;
  x, y: integer;
  xx: integer;
begin
  DstBitmap.Allocate(SrcBitmap.Width, SrcBitmap.Height, ie24RGB);
  xx := (SrcBitmap.Width div 8) - 1;
  progress.per1 := 100 / (SrcBitmap.height + 0.5);
  for y := 0 to SrcBitmap.Height - 1 do
  begin
    spx := SrcBitmap.ScanLine[y];
    dpx := DstBitmap.ScanLine[y];
    for x := 0 to xx do
    begin
      CopyMemory(dpx, @(C1TO24[spx^]), 24);
      inc(spx);
      inc(dpx, 24);
    end;
    x := SrcBitmap.Width and 7;
    if x <> 0 then
      // copy remaining
      CopyMemory(dpx, @(C1TO24[spx^]), x * 3);
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + 1)));
  end;
end;

{!!
<FS>TImageEnProc.ConvertTo24Bit

<FM>Declaration<FC>
procedure ConvertTo24Bit;

<FM>Description<FN>
Converts a black&white (pf1bit) image to true color (pf24bit).

!!}
procedure TImageEnProc.ConvertTo24Bit;
var
  Progress: TProgressRec;
  ftmp: TIEBitmap;
begin
  if assigned(fIEBitmap) and (fIEBitmap.Pixelformat<>ie1g) then
    exit;
  if assigned(fBitmap) and (fBitmap.PixelFormat<>pf1bit) then
    exit;
  if not MakeConsistentBitmap([ie1g]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CONVERTTO24BIT, ieuImage);
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  ftmp := TIEBitmap.Create;
  ftmp.Assign(fIEBitmap);
  _Conv1To24Ex(ftmp, fIEBitmap, Progress);
  FreeAndNil(ftmp);
  Update;
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.BumpMapping

<FM>Declaration<FC>
procedure BumpMapping(LightX, LightY, LampX, LampY, pcf:integer; Color:<A TRGB>);

<FM>Description<FN>
BumpMapping applies the bump mapping effect to the current image. This effect is available in image processing preview dialog.

<FC>LightX<FN> and <FC>LightY<FN> specify source light position.
<FC>LampX<FN> and <FC>LampY<FN> specify width and height of the source light.
<FC>pcf<FN> is the percentage of the effect to apply to the original image (0..100).
<FC>Color<FN> is the source light color.

<FM>Example<FC>

ImageEnView1.Proc.BumpMapping(100,100,50,50,10,CreateRGB(255,255,255));
!!}
procedure TImageEnProc.BumpMapping(LightX, LightY, LampX, LampY, pcf: integer; Color: TRGB);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
  Progress: TProgressRec;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_BUMPMAPPING, ProcBitmap, mask) then
    exit;
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  _BumpMapping(ProcBitmap, LightX, LightY, LampX, LampY, pcf, Color, x1, y1, x2, y2, Progress);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure _ConvertToGray(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  v: byte;
  ppx: pRGB;
  per1: double;
begin
  if bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for y := fSelY1 to fSelY2 do
  begin
    ppx := bitmap.ScanLine[y];
    inc(ppx, fSelX1);
    for x := fSelX1 to fSelX2 do
    begin
      with ppx^ do
      begin
        v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
        r := v;
        g := v;
        b := v;
      end;
      inc(ppx);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
end;

// LightX,LightY: light center
// LAmpX,LAmpY: light size (in pixels)
// pcf: percentage of the effect
// Color: bump color
procedure _BumpMapping(Bitmap: TIEBitmap; LightX, LightY, LAmpX, LAmpY, pcf: integer; Color: TRGB; fselx1, fsely1, fselx2, fsely2: integer; var Progress: TProgressRec);
type
  tenvmap = array[0..255, 0..255] of byte;
  penvmap = ^tenvmap;
var
  envmap: penvmap;
  x, y: integer;
  dnx, dny, dnz: double;
  nx, ny: integer;
  px1: pRGB;
  b1: pbyte;
  l1, l2, l3: pbytearray;
  bumpmap: TIEBitmap;
  lx, ly: integer;
  e: integer;
  c1, c2, c3: double;
  cr, cg, cb: double;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  if (LAmpX = 0) or (LAmpY = 0) then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  Progress.per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  // calc environment map
  getmem(envmap, 256 * 256);
  for x := 0 to 255 do
    for y := 0 to 255 do
    begin
      dnx := (x - 128) / 128;
      dny := (y - 128) / 128;
      dnz := 1 - sqrt(dnx * dnx + dny * dny);
      if dnz < 0 then
        dnz := 0;
      envmap^[x, y] := trunc(dnz * 256);
    end;
  envmap[128,128]:=(envmap[129,129]+envmap[127,127]) div 2;
  // create bumpmap
  bumpmap := TIEBitmap.Create;
  bumpmap.Allocate(bitmap.width, bitmap.height, ie8g);
  for y := fSelY1 to fSelY2 do
  begin
    px1 := bitmap.ScanLine[y];
    b1 := bumpmap.ScanLine[y];
    inc(px1, fSelX1);
    inc(b1, fSelX1);
    for x := fSelX1 to fSelX2 do
    begin
      with px1^ do
        b1^ := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
      inc(px1);
      inc(b1);
    end;
  end;
  // make bump mapping
  c1 := pcf / 100;
  c3 := (100 - pcf) / 100;
  cr := Color.r / 255;
  cg := Color.g / 255;
  cb := Color.b / 255;
  for y := fSelY1 to fSelY2 do
  begin
    px1 := bitmap.ScanLine[y];
    inc(px1, fSelX1);
    l1 := bumpmap.ScanLine[imax(y - 1, 0)];
    l2 := bumpmap.ScanLine[y];
    l3 := bumpmap.ScanLine[imin(y + 1, fSelY2)];
    for x := fSelX1 to fSelX2 do
    begin
      nx := l2^[imin(x + 1, fSelX2)] - l2^[imax(x - 1, fSelX1)];
      ny := l3^[x] - l1[x];
      nx := blimit(nx + 128 - trunc((x - LightX) / LAmpX * 128));
      ny := blimit(ny + 128 - trunc((y - LightY) / LAmpY * 128));
      with px1^ do
      begin
        c2 := envmap[nx, ny] * c3;
        r := blimit(round(r * c1 + c2 * cr));
        g := blimit(round(g * c1 + c2 * cg));
        b := blimit(round(b * c1 + c2 * cb));
      end;
      inc(px1);
    end;
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
  //
  FreeAndNil(bumpmap);
  freemem(envmap);
end;

// ret True is angle is 90,180,270,360 etc

function IsRectAngle(angle: double): boolean;
begin
  result := (trunc(angle) = angle) and ((trunc(angle) mod 90) = 0);
end;

// angle hasn't limits
// counter-clockwise

{!!
<FS>TImageEnProc.Rotate

<FM>Declaration<FC>
procedure Rotate(fangle: double; antialias: boolean = false; AntialiasMode: <A TIEAntialiasMode> = ierFast; BackgroundColor: TColor = -1);

<FM>Description<FN>
The Rotate method rotates the current image of fangle angle (negative or positive degrees).
If antialias is True, an anti-alias algorithm is used. Applications can select the anti-alias algorithm using AntialiasMode parameter, values of this parameter can be:
  ierFast : fast but with low quality
  ierBilinear : bilinear, high quality
  ierBicubic : bicubic, high quality (maximum quality)

BackgroundColor specifies an alternative background color. If it is -1, Rotate uses the default background.


!!}
procedure TImageEnProc.Rotate(fangle: double; antialias: boolean; AntialiasMode: TIEAntialiasMode; BackgroundColor: TColor);
var
  alpha: TIEBitmap;
  bcol: TColor;
begin
  if fangle = 0 then
    exit;
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(Format(IERS_ROTATE, [fangle]), ieuImage);
  if BackgroundColor = -1 then
    bcol := GetReBackGround
  else
    bcol := BackgroundColor;
  if fIEBitmap.HasAlphaChannel then
  begin
    alpha := TIEBitmap.Create;
    alpha.Assign(fIEBitmap.AlphaChannel);
  end
  else
    alpha := nil;

  if (antialias=true) and ((fIEBitmap.PixelFormat=ie24RGB) or (fIEBitmap.PixelFormat=ie1g)) then
  begin
    // SHEAR
    if (AntialiasMode = ierFast) or IsRectAngle(fangle) or (fIEBitmap.PixelFormat <> ie24RGB) then
    begin
      // rotate alpha channel
      if assigned(alpha) then
      begin
        if fIEBitmap.PixelFormat = ie1g then
          // if the image is black/white we haven't to apply a filter to the alpha channel (so have better result)
          _rotate8bit(alpha, fangle, 0)
        else
          // we need to rotate alpha using a filter, because the image is colored
          _RotateEx8(alpha, fangle, antialias, 0, fOnProgress, self);
      end;
      // rotate image
      _RotateEx(fIEBitmap, fangle, antialias, TColor2TRGB(bcol), fOnProgress, self);
    end
    else
    begin
      // rotate alpha channel
      if assigned(alpha) then
        _IEQRotate8(alpha, fangle, 0, AntialiasMode);
      // rotate image
      _IEQRotate(fIEBitmap, fangle, bcol, AntialiasMode, fOnProgress, self);
    end;
  end
  else
  begin
    // SINCOS
    if assigned(alpha) then
      IEGRotate(alpha,fangle,0,nil,nil);
    IEGRotate(fIEBitmap,fangle,bcol,fOnProgress,self);
  end;

  if assigned(alpha) then
  begin
    fIEBitmap.AlphaChannel.Assign(alpha);
    FreeAndNil(alpha);
  end;
  Update;
  DoFinishWork;
end;

// accept TIEBitmap and works only with ie24RGB and ie1g
procedure _RotateEx(fBitmap: TIEBitmap; fangle: double; antialias: boolean; Background: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
const
  SCALE = 4096;
  HALFSCALE = 2048;
var
  rangle: double; // angle in radiants
  bakBitmap: tiebitmap;
  xshearfac, yshearfac, new0: double;
  cols, rows, tempcols, yshearjunk, newrows, x2shearjunk, newcols, row, intnew0: integer;
  col, fracnew0, omfracnew0, neww, xnew: integer;
  bgxel, prevxel, xel: TRGB;
  temp1xels, temp2xels: pRGBROW;
  xP, nxP: pRGB;
  ppx, ppx2: pRGB;
  Progress: TProgressRec;
  iangle: integer;
  nullpr: TProgressRec;
  per: double;
begin
  if fangle = 0 then
    exit;
  if fbitmap.PixelFormat = ie24RGB then
  begin
    iangle := trunc(fangle * 1000);
    iangle := iangle mod 360000;
    fangle := iangle / 1000;
    bakBitmap := TIEBitmap.Create;
    //
    if (fangle >= -45) and (fangle <= 45) then
      bakBitmap.AssignImage(fBitmap);
    // rotates by 90 degrees until the angle is not equal or less than 45 degrees
    while fangle > 45 do
    begin
      fangle := fangle - 90;
      _Rot90Ex(fBitmap, bakbitmap);
      if fangle <= 45 then
        break;
      fBitmap.AssignImage(bakBitmap);
    end;
    // rotates by -90 degrees until the angle is not equal or less than -45 degrees
    while fangle < -45 do
    begin
      fangle := fangle + 90;
      _Rot90oEx(fBitmap, bakbitmap);
      if fangle >= -45 then
        break;
      fBitmap.AssignImage(bakbitmap);
    end;
    if fangle = 0 then
    begin
      fBitmap.AssignImage(bakBitmap);
      FreeAndNil(bakbitmap);
      exit;
    end;
    // now "fangle" is inside the range -45...45
    // in bakbitmap there is the working image
    rangle := fangle * PI / 180; // converts fangle to radiants
    cols := bakbitmap.Width; // columns original image
    rows := bakbitmap.Height; // rows original image
    xshearfac := abs(sin(rangle / 2) / cos(rangle / 2)); // horizontal shear
    yshearfac := abs(sin(rangle)); // vertical shear
    tempcols := round(rows * xshearfac + cols + 1); // columns in horizontal shear buffer
    yshearjunk := round((tempcols - cols) * yshearfac);
    newrows := round(tempcols * yshearfac + rows + 1);
    x2shearjunk := round((newrows - rows - yshearjunk) * xshearfac);
    newrows := round(newrows - (2 * yshearjunk));
    newcols := round(newrows * xshearfac + tempcols + 1 - 2 * x2shearjunk);
    per := 100 / (rows + tempcols + newrows);
    /////// STEP-1, horizontal shear
    bgxel := Background; // fill color
    getmem(temp1xels, tempcols * rows * 3); // horizontal shear buffer
    for row := 0 to rows - 1 do
    begin
      if rangle > 0 then
        new0 := row * xshearfac
      else
        new0 := (rows - row) * xshearfac;
      intnew0 := round(new0);
      if antialias then
      begin
        // ANTIALIAS
        fracnew0 := trunc((new0 - intnew0) * SCALE);
        omfracnew0 := trunc(SCALE - fracnew0);
        nxP := @temp1xels[row * tempcols];
        for col := 0 to tempcols - 1 do
        begin
          nxP^ := bgxel;
          inc(nxP);
        end;
        prevxel := bgxel;
        nxP := @(temp1xels[row * tempcols + intnew0]);
        xP := pRGB(bakbitmap.scanline[row]);
        for col := 0 to cols - 1 do
        begin
          nxP^.r := blimit(round((fracnew0 * prevxel.r + omfracnew0 * xP^.r + HALFSCALE) / SCALE));
          nxP^.g := blimit(round((fracnew0 * prevxel.g + omfracnew0 * xP^.g + HALFSCALE) / SCALE));
          nxP^.b := blimit(round((fracnew0 * prevxel.b + omfracnew0 * xP^.b + HALFSCALE) / SCALE));
          prevxel := xP^;
          inc(nxP);
          inc(xP);
        end;
        if (fracnew0 > 0) and (intnew0 + cols < tempcols) then
        begin
          nxP^.r := blimit(round((fracnew0 * prevxel.r + omfracnew0 * bgxel.r + HALFSCALE) / SCALE));
          nxP^.g := blimit(round((fracnew0 * prevxel.g + omfracnew0 * bgxel.g + HALFSCALE) / SCALE));
          nxP^.b := blimit(round((fracnew0 * prevxel.b + omfracnew0 * bgxel.b + HALFSCALE) / SCALE));
        end
      end
      else
      begin
        // NO ANTIALIAS
        // fills the left area with the Background
        nxP := @(temp1xels[row * tempcols]);
        for col := 0 to intnew0 - 1 do
        begin
          nxP^ := bgxel;
          inc(nxP);
        end;
        // copies the image area
        CopyMemory(nxP, bakbitmap.scanline[row], cols * 3);
        inc(nxP, cols);
        // fills the other with Background
        for col := (intnew0 + cols) to tempcols - 1 do
        begin
          nxP^ := bgxel;
          inc(nxP);
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per * (row)));
    end;
    /////// STEP-2, vertical shear
    getmem(temp2xels, tempcols * newrows * 3);
    for col := 0 to tempcols - 1 do
    begin
      if rangle > 0 then
        new0 := (tempcols - col) * yshearfac
      else
        new0 := (col * yshearfac);

      intnew0 := round(new0);
      fracnew0 := round((new0 - intnew0) * SCALE);

      omfracnew0 := SCALE - fracnew0;
      dec(intnew0, yshearjunk);
      // fills the column col with background
      for row := 0 to newrows - 1 do
        temp2xels[row * tempcols + col] := bgxel;
      if antialias then
      begin
        // ANTIALIAS
        prevxel := bgxel;
        for row := 0 to rows - 1 do
        begin
          xnew := row + intnew0;
          if (xnew >= 0) and (xnew < newrows) then
          begin
            nxP := @temp2xels[xnew * tempcols + col];
            xel := temp1xels[row * tempcols + col];
            nxP^.r := blimit(round((fracnew0 * prevxel.r + omfracnew0 * xel.r + HALFSCALE) / SCALE));
            nxP^.g := blimit(round((fracnew0 * prevxel.g + omfracnew0 * xel.g + HALFSCALE) / SCALE));
            nxP^.b := blimit(round((fracnew0 * prevxel.b + omfracnew0 * xel.b + HALFSCALE) / SCALE));
            prevxel := xel;
          end;
        end;
        if (fracnew0 > 0) and (intnew0 + rows < newrows) then
        begin
          nxP := @temp2xels[(intnew0 + rows) * tempcols + col];
          nxP^.r := blimit(round((fracnew0 * prevxel.r + omfracnew0 * bgxel.r + HALFSCALE) / SCALE));
          nxP^.g := blimit(round((fracnew0 * prevxel.g + omfracnew0 * bgxel.g + HALFSCALE) / SCALE));
          nxP^.b := blimit(round((fracnew0 * prevxel.b + omfracnew0 * bgxel.b + HALFSCALE) / SCALE));
        end;
      end
      else
      begin
        // NO ANTIALIAS
        // traslate columns vertically
        for row := 0 to rows - 1 do
        begin
          neww := row + intnew0;
          if (neww >= 0) and (neww < newrows) then
            temp2xels[neww * tempcols + col] := temp1xels[row * tempcols + col];
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per * (rows + col)));
    end;
    freemem(temp1xels);
    /////// STEP-3, horizontal shear
    fbitmap.height := newrows;
    fbitmap.width := newcols;
    fbitmap.fill(TRGB2TColor(Background));
    for row := 0 to newrows - 1 do
    begin
      if rangle > 0 then
        new0 := row * xshearfac
      else
        new0 := (newrows - row) * xshearfac;

      intnew0 := round(new0);
      fracnew0 := round((new0 - intnew0) * SCALE);

      omfracnew0 := SCALE - fracnew0;
      dec(intnew0, x2shearjunk);
      if antialias then
      begin
        // ANTIALIAS
        prevxel := bgxel;
        xP := @temp2xels[row * tempcols];
        ppx := fbitmap.scanline[row];
        for col := 0 to tempcols - 1 do
        begin
          neww := intnew0 + col;
          if (neww >= 0) and (neww < newcols) then
          begin
            nxP := ppx;
            inc(nxP, neww);
            //
            nxP^.r := blimit(round((fracnew0 * prevxel.r + omfracnew0 * xP^.r + HALFSCALE) / SCALE));
            nxP^.g := blimit(round((fracnew0 * prevxel.g + omfracnew0 * xP^.g + HALFSCALE) / SCALE));
            nxP^.b := blimit(round((fracnew0 * prevxel.b + omfracnew0 * xP^.b + HALFSCALE) / SCALE));
            prevxel := xP^;
          end;
          inc(xP);
        end;
        if (fracnew0 > 0) and (intnew0 + tempcols < newcols) then
        begin
          nxP := ppx;
          inc(nxP, (intnew0 + tempcols));
          //
          nxP^.r := blimit(round((fracnew0 * prevxel.r + omfracnew0 * bgxel.r + HALFSCALE) / SCALE));
          nxP^.g := blimit(round((fracnew0 * prevxel.g + omfracnew0 * bgxel.g + HALFSCALE) / SCALE));
          nxP^.b := blimit(round((fracnew0 * prevxel.b + omfracnew0 * bgxel.b + HALFSCALE) / SCALE));
        end;
        //
      end
      else
      begin
        // NO ANTIALIAS
        xP := pRGB(@(temp2xels[row * tempcols]));
        ppx := fbitmap.scanline[row];
        for col := 0 to tempcols - 1 do
        begin
          neww := intnew0 + col;
          if (neww >= 0) and (neww < newcols) then
          begin
            ppx2 := ppx;
            inc(ppx2, neww);
            ppx2^ := xP^;
          end;
          inc(xP);
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per * (rows + tempcols + row)));
    end;
    freemem(temp2xels);
    FreeAndNil(bakBitmap);
  end
  else
  begin
    // ie1g
    nullpr.Aborting := nil;
    nullpr.Sender := Sender;
    nullpr.fOnProgress := fOnProgress;
    if (BackGround.r <> 0) and (background.g <> 0) and (background.b <> 0) then
      _rotate1bitEx(fBitmap, fangle, 1, nullpr)
    else
      _rotate1bitEx(fBitmap, fangle, 0, nullpr);
  end;
end;

// accept ie8g and ie8p
procedure _RotateEx8(fBitmap: TIEBitmap; fangle: double; antialias: boolean; Background: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
const
  SCALE = 4096;
  HALFSCALE = 2048;
var
  rangle: double; // angle in radiants
  bakBitmap: tiebitmap;
  xshearfac, yshearfac, new0: double;
  cols, rows, tempcols, yshearjunk, newrows, x2shearjunk, newcols, row, intnew0: integer;
  col, fracnew0, omfracnew0, neww, xnew: integer;
  bgxel, prevxel, xel: byte;
  temp1xels, temp2xels: pbytearray;
  xP, nxP: pbyte;
  ppx, ppx2: pbyte;
  Progress: TProgressRec;
  iangle: integer;
  nullpr: TProgressRec;
  per: double;
begin
  if fangle = 0 then
    exit;
  if (fbitmap.PixelFormat = ie8g) or (fBitmap.PixelFormat = ie8p) then
  begin
    iangle := trunc(fangle * 1000);
    iangle := iangle mod 360000;
    fangle := iangle / 1000;
    bakBitmap := tiebitmap.create;
    //
    if (fangle >= -45) and (fangle <= 45) then
      bakBitmap.AssignImage(fBitmap);
    // rotates by 90 degrees until the angle is not equal or less than 45 degrees
    while fangle > 45 do
    begin
      fangle := fangle - 90;
      _Rot90Ex8(fBitmap, bakbitmap);
      if fangle <= 45 then
        break;
      fBitmap.Assign(bakBitmap);
    end;
    // rotates by -90 degrees until the angle is not equal or less than -45 degrees
    while fangle < -45 do
    begin
      fangle := fangle + 90;
      _Rot90oEx8(fBitmap, bakbitmap);
      if fangle >= -45 then
        break;
      fBitmap.Assign(bakbitmap);
    end;
    if fangle = 0 then
    begin
      fBitmap.Assign(bakBitmap);
      FreeAndNil(bakbitmap);
      exit;
    end;
    // now "fangle" is inside the range -45...45
    // in bakbitmap there is the working image
    rangle := fangle * PI / 180; // converts fangle to radiants
    cols := bakbitmap.Width; // columns original image
    rows := bakbitmap.Height; // rows original image
    xshearfac := abs(sin(rangle / 2) / cos(rangle / 2)); // horizontal shear
    yshearfac := abs(sin(rangle)); // vertical shear
    tempcols := round(rows * xshearfac + cols + 1); // columns in horizontal shear buffer
    yshearjunk := round((tempcols - cols) * yshearfac);
    newrows := round(tempcols * yshearfac + rows + 1);
    x2shearjunk := round((newrows - rows - yshearjunk) * xshearfac);
    newrows := round(newrows - (2 * yshearjunk));
    newcols := round(newrows * xshearfac + tempcols + 1 - 2 * x2shearjunk);
    per := 100 / (rows + tempcols + newrows);
    /////// STEP-1, horizontal shear
    bgxel := Background; // fill color
    getmem(temp1xels, tempcols * rows); // horizontal shear buffer
    for row := 0 to rows - 1 do
    begin
      if rangle > 0 then
        new0 := row * xshearfac
      else
        new0 := (rows - row) * xshearfac;
      intnew0 := round(new0);
      if antialias then
      begin
        // ANTIALIAS
        fracnew0 := trunc((new0 - intnew0) * SCALE);
        omfracnew0 := trunc(SCALE - fracnew0);
        nxP := @temp1xels[row * tempcols];
        for col := 0 to tempcols - 1 do
        begin
          nxP^ := bgxel;
          inc(nxP);
        end;
        prevxel := bgxel;
        nxP := @(temp1xels[row * tempcols + intnew0]);
        xP := pbyte(bakbitmap.scanline[row]);
        for col := 0 to cols - 1 do
        begin
          nxP^ := blimit(round((fracnew0 * prevxel + omfracnew0 * xP^ + HALFSCALE) / SCALE));
          prevxel := xP^;
          inc(nxP);
          inc(xP);
        end;
        if (fracnew0 > 0) and (intnew0 + cols < tempcols) then
          nxP^ := blimit(round((fracnew0 * prevxel + omfracnew0 * bgxel + HALFSCALE) / SCALE));
      end
      else
      begin
        // NO ANTIALIAS
        // fills the left area with the Background
        nxP := @(temp1xels[row * tempcols]);
        for col := 0 to intnew0 - 1 do
        begin
          nxP^ := bgxel;
          inc(nxP);
        end;
        // copies the image area
        CopyMemory(nxP, bakbitmap.scanline[row], cols);
        inc(nxP, cols);
        // fills the other with Background
        for col := (intnew0 + cols) to tempcols - 1 do
        begin
          nxP^ := bgxel;
          inc(nxP);
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per * (row)));
    end;
    /////// STEP-2, vertical shear
    getmem(temp2xels, tempcols * newrows);
    for col := 0 to tempcols - 1 do
    begin
      if rangle > 0 then
        new0 := (tempcols - col) * yshearfac
      else
        new0 := (col * yshearfac);
      intnew0 := round(new0);
      fracnew0 := round((new0 - intnew0) * SCALE);
      omfracnew0 := SCALE - fracnew0;
      dec(intnew0, yshearjunk);
      // fills the column col with background
      for row := 0 to newrows - 1 do
        temp2xels[row * tempcols + col] := bgxel;
      if antialias then
      begin
        // ANTIALIAS
        prevxel := bgxel;
        for row := 0 to rows - 1 do
        begin
          xnew := row + intnew0;
          if (xnew >= 0) and (xnew < newrows) then
          begin
            nxP := @temp2xels[xnew * tempcols + col];
            xel := temp1xels[row * tempcols + col];
            nxP^ := blimit(round((fracnew0 * prevxel + omfracnew0 * xel + HALFSCALE) / SCALE));
            prevxel := xel;
          end;
        end;
        if (fracnew0 > 0) and (intnew0 + rows < newrows) then
        begin
          nxP := @temp2xels[(intnew0 + rows) * tempcols + col];
          nxP^ := blimit(round((fracnew0 * prevxel + omfracnew0 * bgxel + HALFSCALE) / SCALE));
        end;
      end
      else
      begin
        // NO ANTIALIAS
        // traslate columns vertically
        for row := 0 to rows - 1 do
        begin
          neww := row + intnew0;
          if (neww >= 0) and (neww < newrows) then
            temp2xels[neww * tempcols + col] := temp1xels[row * tempcols + col];
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per * (rows + col)));
    end;
    freemem(temp1xels);
    /////// STEP-3, horizontal shear
    fbitmap.height := newrows;
    fbitmap.width := newcols;
    fbitmap.fill(Background);
    for row := 0 to newrows - 1 do
    begin
      if rangle > 0 then
        new0 := row * xshearfac
      else
        new0 := (newrows - row) * xshearfac;
      intnew0 := round(new0);
      fracnew0 := round((new0 - intnew0) * SCALE);
      omfracnew0 := SCALE - fracnew0;
      dec(intnew0, x2shearjunk);
      if antialias then
      begin
        // ANTIALIAS
        prevxel := bgxel;
        xP := @temp2xels[row * tempcols];
        ppx := fbitmap.scanline[row];
        for col := 0 to tempcols - 1 do
        begin
          neww := intnew0 + col;
          if (neww >= 0) and (neww < newcols) then
          begin
            nxP := ppx;
            inc(nxP, neww);
            //
            nxP^ := blimit(round((fracnew0 * prevxel + omfracnew0 * xP^ + HALFSCALE) / SCALE));
            prevxel := xP^;
          end;
          inc(xP);
        end;
        if (fracnew0 > 0) and (intnew0 + tempcols < newcols) then
        begin
          nxP := ppx;
          inc(nxP, (intnew0 + tempcols));
          //
          nxP^ := blimit(round((fracnew0 * prevxel + omfracnew0 * bgxel + HALFSCALE) / SCALE));
        end;
        //
      end
      else
      begin
        // NO ANTIALIAS
        xP := pbyte(@(temp2xels[row * tempcols]));
        ppx := fbitmap.scanline[row];
        for col := 0 to tempcols - 1 do
        begin
          neww := intnew0 + col;
          if (neww >= 0) and (neww < newcols) then
          begin
            ppx2 := ppx;
            inc(ppx2, neww);
            ppx2^ := xP^;
          end;
          inc(xP);
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per * (rows + tempcols + row)));
    end;
    freemem(temp2xels);
    FreeAndNil(bakBitmap);
  end;
end;

// xx,yy: lens center
// width,height: lens size
// refraction: refraction value (1.7)

procedure _lens(Bitmap: TIEBitmap; xx, yy: integer; width, height: integer; refraction: double; var Progress: TProgressRec);
  procedure find_projected_pos(refraction: double; a, b, x, y: double; projx, projy: pdouble);
  var
    c: double;
    n: array[0..2] of double;
    nxangle, nyangle, theta1, theta2: double;
    ri1, ri2: double;
  begin
    ri1 := 1.0;
    ri2 := abs(refraction);
    c := dmin(a, b);
    n[0] := x;
    n[1] := y;
    // 2.2.6
    if refraction>0 then
      n[2] := sqrt((1 - x * x / (a * a) - y * y / (b * b)) * (c * c))
    else
      n[2] := -sqrt((1 - x * x / (a * a) - y * y / (b * b)) * (c * c));
    nxangle := cos(n[0] / sqrt(n[0] * n[0] + n[2] * n[2]));
    theta1 := PI / 2 - nxangle;
    theta2 := asin(sin(theta1) * ri1 / ri2);
    theta2 := PI / 2 - nxangle - theta2;
    projx^ := x - tan(theta2) * n[2];
    nyangle := acos(n[1] / sqrt(n[1] * n[1] + n[2] * n[2]));
    theta1 := PI / 2 - nyangle;
    theta2 := asin(sin(theta1) * ri1 / ri2);
    theta2 := PI / 2 - nyangle - theta2;
    projy^ := y - tan(theta2) * n[2];
  end;
var
  row: integer;
  i, col, scol, srow: integer;
  regionwidth, regionheight: integer;
  dx, dy, xsqr, ysqr: double;
  a, b, asqr, bsqr, x, y: double;
  bgr_red, bgr_blue, bgr_green, alphaval: byte;
  origbmp, destbmp: TIEBitmap;
  src, dest: pPRGBArray; // lista di puntatori a scanline (verticale)
  x1, y1, x2, y2: integer;
  bitmapwidth1, bitmapheight1: integer;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  if (Refraction<1) and (Refraction>-1) then
    exit;
  x1 := xx - (width div 2);
  y1 := yy - (height div 2);
  x2 := xx + (width div 2);
  y2 := yy + (height div 2);
  x1 := ilimit(x1, 0, bitmap.width - 1);
  y1 := ilimit(y1, 0, bitmap.height - 1);
  x2 := ilimit(x2, 0, bitmap.width - 1);
  y2 := ilimit(y2, 0, bitmap.height - 1);
  Progress.per1 := 100 / (Y2 - Y1 + 0.5);
  //
  regionwidth := x2 - x1;
  a := regionwidth / 2;
  regionheight := y2 - y1;
  b := regionheight / 2;
  asqr := a * a;
  bsqr := b * b;
  destbmp := TIEBitmap.Create;
  destbmp.Location := ieMemory; // needed to set dest[]
  destbmp.Allocate(x2 - x1, y2 - y1, ie24RGB);
  origbmp := TIEBitmap.Create;
  origbmp.Location := ieMemory; // needed to set src[]
  origbmp.AssignImage(Bitmap);
  // costruisce puntatori a linee
  getmem(src, origbmp.height * sizeof(pRGB));
  for row := 0 to origbmp.height - 1 do
    src[row] := origbmp.scanline[row];
  getmem(dest, destbmp.height * sizeof(pRGB));
  for row := 0 to destbmp.height - 1 do
    dest[row] := destbmp.scanline[row];
  //
  bitmapwidth1 := origbmp.width - 1;
  bitmapheight1 := origbmp.height - 1;
  for col := 0 to regionwidth - 1 do
  begin
    dx := col - a + 0.5;
    xsqr := dx * dx;
    for row := 0 to regionheight - 1 do
    begin
      dy := -(row - b) - 0.5;
      ysqr := dy * dy;
      if (ysqr < (bsqr - (bsqr * xsqr) / asqr)) then
      begin
        find_projected_pos(refraction, a, b, dx, dy, @x, @y);
        y := -y;
        srow := trunc(y + b);
        srow := ilimit(srow, 0, bitmapheight1);
        scol := trunc(x + a);
        scol := ilimit(scol, 0, bitmapwidth1);
        PRGBROW(dest^[row])[col] := PRGBROW(src^[y1 + srow])[x1 + scol];
      end
      else
        PRGBROW(dest^[row])[col] := PRGBROW(src^[y1 + row])[x1 + col];
    end;
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (col - X1 + 1)));
  end;
  destbmp.CopyRectTo(Bitmap, 0, 0, x1, y1, destbmp.Width, destbmp.Height);
  FreeAndNil(destbmp);
  FreeAndNil(origbmp);
  freemem(dest);
  freemem(src);
end;


{!!
<FS>TImageEnProc.Lens

<FM>Declaration<FC>
procedure Lens(cx, cy, Width, Height:integer; Refraction:double);

<FM>Description<FN>
Lens applies the lens effect to the current image. This effect is available in image processing preview dialog.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>cx<FN></C> <C>Horizontal lens position.</C> </R>
<R> <C><FC>cy<FN></C> <C>Vertical lens position.</C> </R>
<R> <C><FC>Width<FN></C> <C>Lens width.</C> </R>
<R> <C><FC>Height<FN></C> <C>Lens height.</C> </R>
<R> <C><FC>Refraction<FN></C> <C>Lens refraction (from 1).</C> </R>
</TABLE>
!!}
// cx,cy: lens center
// Width,Height: lens size
// Refraction: refraction value (from 1)
procedure TImageEnProc.Lens(cx, cy, Width, Height: integer; Refraction: double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
  Progress: TProgressRec;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_LENS, ProcBitmap, mask) then
    exit;
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  _lens(ProcBitmap, cx, cy, Width, Height, Refraction, Progress);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure TImageEnProc.OnBitmapChange(Sender: TObject; destroying: boolean);
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
        fIEBitmap.EncapsulateTBitmap(fBitmap, true);
    end;

  end;
end;

// return <>0 if active /   0=disattive
function _GetPixelbw(row: pbyte; pix: integer): integer;  {$ifdef IESUPPORTINLINE} inline; {$endif}
begin
  result := pbytearray(row)^[pix shr 3] and iebitmask1[pix and $7];
end;

// Set pixel "pix" to vv (<>0=1 0=0)
procedure _SetPixelbw(row: pbyte; pix: integer; vv: integer); {$ifdef IESUPPORTINLINE} inline; {$endif}
var
  bp: pbyte;
begin
  bp := pbyte(int64(DWORD(row)) + (int64(pix) shr 3));
  if vv <> 0 then
    bp^ := bp^ or iebitmask1[pix and 7]
  else
    bp^ := bp^ and not iebitmask1[pix and 7];
end;

// fBitmap.PixelFormat must be ie1g
procedure _rotate1bitex(fBitmap: TIEBitmap; angle: double; background: integer; var Progress: TProgressRec);
var
  xrotimage: TIEBitmap;
  nx, ny, newheight, newwidth, oldheight, oldwidth, i, j, x, x7, x6, y, w, xl, x3: integer;
  halfnewheight, halfnewwidth, halfoldheight, halfoldwidth: double;
  radians: double;
  cosval, sinval: double;
  drow, bp, newb, oldb, tbuf: pbyte;
  anx, any: pintegerarray;
begin
  oldheight := fBitmap.height;
  oldwidth := fBitmap.width;
  xrotimage := TIEBitmap.Create;
  xrotimage.Location := ieMemory;
  if (angle = 90) or (angle = -90) or (angle = 270) or (angle = 180) or (angle = -180) then
  begin
    if angle = 90 then
    begin
      // +90
      newwidth := oldheight;
      newheight := oldwidth;
      xrotimage.allocate(newwidth, newheight, ie1g);
      xrotimage.Fill(0);
      for x := 0 to oldwidth - 1 do
      begin
        drow := xrotimage.ScanLine[oldwidth - x - 1];
        x7 := iebitmask1[x and $7];
        x3 := x shr 3;
        for y := 0 to oldheight - 1 do
        begin
          if (pbytearray(fBitmap.Scanline[y])[x3] and x7) <> 0 then
          begin
            bp := pbyte(int64(DWORD(drow)) + (int64(y) shr 3));
            bp^ := bp^ or (iebitmask1[y and 7]);
          end;
        end;
      end;
    end
    else if (angle = -90) or (angle = 270) then
    begin
      // -90, 270
      newwidth := oldheight;
      newheight := oldwidth;
      xrotimage.allocate(newwidth, newheight, ie1g);
      xrotimage.Fill(0);
      for x := 0 to oldwidth - 1 do
      begin
        drow := xrotimage.ScanLine[x];
        x7 := iebitmask1[x and $7];
        x3 := x shr 3;
        for y := 0 to oldheight - 1 do
          if (pbytearray(fBitmap.Scanline[oldheight - y - 1])[x3] and x7) <> 0 then
          begin
            bp := pbyte(int64(DWORD(drow)) + (int64(y) shr 3));
            bp^ := bp^ or (iebitmask1[y and 7]);
          end;
      end;
    end
    else if (angle = 180) or (angle = -180) then
    begin
      // 180, -180
      newwidth := oldwidth;
      newheight := oldheight;
      xrotimage.allocate(newwidth, newheight, ie1g);
      w := oldwidth div 8;
      if (oldwidth and 7) <> 0 then
      begin
        inc(w);
        xl := 8 - (oldwidth and 7); // we need to shift left the image
      end
      else
        xl := 0;
      if xl = 0 then
      begin
        for y := 0 to oldheight - 1 do
        begin
          newb := xrotimage.ScanLine[y];
          oldb := fBitmap.Scanline[oldheight - 1 - y];
          inc(oldb, w - 1);
          for x := 0 to w - 1 do
          begin
            newb^ := oldb^;
            ReverseBitsB(newb^);
            inc(newb);
            dec(oldb);
          end;
        end;
      end
      else
      begin
        // need to shift
        getmem(tbuf, w);
        for y := 0 to oldheight - 1 do
        begin
          newb := tbuf;
          oldb := fBitmap.Scanline[oldheight - 1 - y];
          inc(oldb, w - 1);
          for x := 0 to w - 1 do
          begin
            newb^ := oldb^;
            ReverseBitsB(newb^);
            inc(newb);
            dec(oldb);
          end;
          IECopyBits_large(xrotimage.scanline[y], tbuf, 0, xl, oldWidth, w);
        end;
        freemem(tbuf);
      end;
    end;
  end
  else
  begin
    radians := -(angle) / ((180 / PI));
    cosval := trunc(cos(radians) * 10000) / 10000;
    sinval := trunc(sin(radians) * 10000) / 10000;
    newwidth := trunc(abs(oldwidth * cosval) + abs(oldheight * sinval));
    newheight := trunc(abs(-oldwidth * sinval) + abs(oldheight * cosval));
    halfnewheight := newheight / 2 - 0.5;
    halfnewwidth := newwidth / 2 - 0.5;
    halfoldwidth := oldwidth / 2 - 0.5;
    halfoldheight := oldheight / 2 - 0.5;
    xrotimage.allocate(newwidth, newheight, ie1g);
    //
    Progress.per1 := 100 / (newheight);
    xrotimage.Fill(0);
    getmem(anx, sizeof(integer) * newwidth);
    getmem(any, sizeof(integer) * newwidth);
    for j := 0 to newwidth - 1 do
    begin
      anx[j] := trunc((j - halfnewwidth) * cosval);
      any[j] := trunc((0 - (j - halfnewwidth)) * sinval);
    end;
    for i := 0 to newheight - 1 do
    begin
      drow := xrotimage.scanline[i];
      x6 := trunc((i - halfnewheight) * sinval + halfoldwidth);
      x7 := trunc((i - halfnewheight) * cosval + halfoldheight);
      for j := 0 to newwidth - 1 do
      begin
        nx := anx[j] + x6;
        ny := any[j] + x7;
        if ((nx < oldwidth) and (ny < oldheight) and (nx >= 0) and (ny >= 0)) then
        begin
          if (pbytearray(fBitmap.Scanline[ny])^[nx shr 3] and iebitmask1[nx and $7]) <> 0 then
          begin
            bp := pbyte(int64(DWORD(drow)) + (int64(j) shr 3));
            bp^ := bp^ or (iebitmask1[j and 7]);
          end;
        end
        else if background <> 0 then
        begin
          bp := pbyte(int64(DWORD(drow)) + (int64(j) shr 3));
          bp^ := bp^ or (iebitmask1[j and 7]);
        end;
      end;
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * i));
    end;
    freemem(anx);
    freemem(any);
  end;
  fBitmap.Assign(xrotimage);
  FreeAndNil(xrotimage);
end;

procedure _rotate1bit(fBitmap: TBitmap; angle: double; background: integer; var Progress: TProgressRec);
var
  bmp: TIEBitmap;
begin
  bmp := TIEBitmap.Create;
  bmp.EncapsulateTBitmap(fBitmap, true);
  _rotate1bitex(bmp, angle, background, Progress);
  FreeAndNil(bmp);
end;

// fBitmap must be ie8g or ie8p

procedure _rotate8bit(fBitmap: TIEBitmap; angle: double; background: integer);
var
  xrotimage: TIEBitmap;
  nx, ny, newheight, newwidth, oldheight, oldwidth, i, j, x, x7, x6, y: integer;
  halfnewheight, halfnewwidth, halfoldheight, halfoldwidth: double;
  radians: double;
  cosval, sinval: double;
  drow, bp: pbyte;
  anx, any: pintegerarray;
begin
  if (fBitmap.PixelFormat <> ie8g) and (fBitmap.PixelFormat <> ie8p) then
    exit;
  oldheight := fBitmap.height;
  oldwidth := fBitmap.width;
  xrotimage := TIEBitmap.Create;
  xrotimage.Location := ieMemory;
  if (angle = 90) or (angle = -90) or (angle = 270) or (angle = 180) or (angle = -180) then
  begin
    if angle = 90 then
    begin
      // +90
      newwidth := oldheight;
      newheight := oldwidth;
      xrotimage.allocate(newwidth, newheight, fBitmap.PixelFormat);
      for x := 0 to oldwidth - 1 do
      begin
        drow := xrotimage.ScanLine[oldwidth - x - 1];
        for y := 0 to oldheight - 1 do
        begin
          drow^ := pbytearray(fBitmap.Scanline[y])[x];
          inc(drow);
        end;
      end;
    end
    else if (angle = -90) or (angle = 270) then
    begin
      // -90, 270
      newwidth := oldheight;
      newheight := oldwidth;
      xrotimage.allocate(newwidth, newheight, fBitmap.PixelFormat);
      for x := 0 to oldwidth - 1 do
      begin
        drow := xrotimage.ScanLine[x];
        for y := 0 to oldheight - 1 do
        begin
          drow^ := pbytearray(fBitmap.Scanline[oldheight - y - 1])[x];
          inc(drow);
        end;
      end;
    end
    else if (angle = 180) or (angle = -180) then
    begin
      // 180, -180
      newwidth := oldwidth;
      newheight := oldheight;
      xrotimage.allocate(newwidth, newheight, fBitmap.PixelFormat);
      for y := 0 to newheight - 1 do
      begin
        drow := xrotimage.Scanline[y];
        bp := fBitmap.Scanline[newheight - y - 1];
        inc(bp, newwidth - 1);
        for x := 0 to newwidth - 1 do
        begin
          drow^ := bp^;
          inc(drow);
          dec(bp);
        end;
      end;
    end;
  end
  else
  begin
    radians := -(angle) / ((180 / PI));
    cosval := trunc(cos(radians) * 10000) / 10000;
    sinval := trunc(sin(radians) * 10000) / 10000;
    newwidth := trunc(abs(oldwidth * cosval) + abs(oldheight * sinval));
    newheight := trunc(abs(-oldwidth * sinval) + abs(oldheight * cosval));
    halfnewheight := newheight / 2 - 0.5;
    halfnewwidth := newwidth / 2 - 0.5;
    halfoldwidth := oldwidth / 2 - 0.5;
    halfoldheight := oldheight / 2 - 0.5;
    xrotimage.allocate(newwidth, newheight, fBitmap.PixelFormat);
    //
    getmem(anx, sizeof(integer) * newwidth);
    getmem(any, sizeof(integer) * newwidth);
    for j := 0 to newwidth - 1 do
    begin
      anx[j] := trunc((j - halfnewwidth) * cosval);
      any[j] := trunc((0 - (j - halfnewwidth)) * sinval);
    end;
    for i := 0 to newheight - 1 do
    begin
      drow := xrotimage.scanline[i];
      x6 := trunc((i - halfnewheight) * sinval + halfoldwidth);
      x7 := trunc((i - halfnewheight) * cosval + halfoldheight);
      for j := 0 to newwidth - 1 do
      begin
        nx := anx[j] + x6;
        ny := any[j] + x7;
        if ((nx < oldwidth) and (ny < oldheight) and (nx >= 0) and (ny >= 0)) then
        begin
          drow^ := pbytearray(fBitmap.Scanline[ny])[nx];
        end
        else
        begin
          drow^ := background;
        end;
        inc(drow);
      end;
    end;
    freemem(anx);
    freemem(any);
  end;
  fBitmap.Assign(xrotimage);
  FreeAndNil(xrotimage);
end;

{!!
<FS>TImageEnProc.PreviewsParams

<FM>Declaration<FC>
property PreviewsParams: <A TPRPreviewsParams>;

<FM>Description<FN>
This property specifies some features that the image processing preview dialog will have.
!!}
procedure TImageEnProc.SetPRPreviewParams(v: TPRPreviewsParams);
begin
  fPreviewsParams := v;
end;

function TImageEnProc.GetPRPreviewParams: TPRPreviewsParams;
begin
  result := fPreviewsParams;
end;

{!!
<FS>TImageEnProc.Wave

<FM>Declaration<FC>
procedure Wave(amplitude, wavelength, phase:integer; reflective:boolean);

<FM>Description<FN>
Wave applies a wave effect to the current image. This effect is available in the image processing preview dialog.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>amplitude<FN></C> <C>Amplitude (height) of the wave (from 0).</C> </R>
<R> <C><FC>wavelength<FN></C> <C>Length of the wave (from 0).</C> </R>
<R> <C><FC>phase<FN></C> <C>phase of the wave in degress (0..359).</C> </R>
<R> <C><FC>reflective<FN></C> <C>If <FC>true<FN> makes a special effect.</C> </R>
</TABLE>


<FM>Example<FC>

ImageEnView1.Proc.Wave(10,10,0,false);

!!}
procedure TImageEnProc.Wave(amplitude, wavelength, phase: integer; reflective: boolean);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
  Progress: TProgressRec;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_WAVE, ProcBitmap, mask) then
    exit;
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  _wave(ProcBitmap, amplitude, wavelength, phase, reflective, Progress);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// amplitude
// wavelength
// phase (angle in degrees)
// reflective
procedure _wave(Bitmap: TIEBitmap; amplitude, wavelength, phase: integer; reflective: boolean; var Progress: TProgressRec);
  function bilinear(x, y: double; v: array of byte): byte;
  var
    m0, m1: double;
  begin
    x := x - trunc(x);
    y := y - trunc(y);
    if (x < 0) then
      x := x + 1.0;
    if (y < 0) then
      y := y + 1.0;
    m0 := (1.0 - x) * v[0] + x * v[1];
    m1 := (1.0 - x) * v[2] + x * v[3];
    result := trunc((1.0 - y) * m0 + y * m1);
  end;
const
  BYPP = 3; // channels number
  BITCOUNT = 8; // bits per pixel
var
  src, dst: pbyte;
  srcbmp, dstbmp: TIEBitmap;
  width, height: integer;
  fphase: double;
  rowsiz: integer;
  p: pbyte;
  dest: pbyte;
  x1, y1, x2, y2: integer;
  x, y: integer;
  x1_in, y1_in, x2_in, y2_in: boolean;
  cen_x, cen_y: double;
  xhsiz, yhsiz: double;
  radius, radius2: double;
  amnt, d: double;
  needx, needy: double;
  dx, dy: double;
  xscale, yscale: double;
  xi, yi: integer;
  values: array[0..3] of byte;
  val: byte;
  k: integer;
begin
  // check values (moved in 3.0.3 to avoid memory leak)
  if (amplitude = 0) or (wavelength = 0) then
    exit;
  // Assign src and dst
  width := Bitmap.Width;
  height := Bitmap.Height;
  dstbmp := TIEBitmap.Create;
  dstbmp.Location := ieMemory; // to allow use of dst pointer
  dstbmp.Allocate(width, height, ie24RGB);
  dst := dstbmp.Scanline[height - 1];
  srcbmp := TIEBitmap.Create;
  srcbmp.Location := ieMemory; // to allow use of src pointer
  srcbmp.AssignImage(Bitmap);
  src := srcbmp.Scanline[height - 1];
  //
  Progress.per1 := 100 / (height);
  fphase := phase * PI / 180;
  rowsiz := IEBitmapRowLen(width, BITCOUNT * BYPP, 32); //width * BYPP;
  x1 := 0;
  y1 := 0;
  x2 := width;
  y2 := height;
  cen_x := (x2 - 1 + x1) / 2.0;
  cen_y := (y2 - 1 + y1) / 2.0;
  xhsiz := (x2 - x1) / 2.0;
  yhsiz := (y2 - y1) / 2.0;
  if (xhsiz < yhsiz) then
  begin
    xscale := yhsiz / xhsiz;
    yscale := 1.0;
  end
  else if (xhsiz > yhsiz) then
  begin
    xscale := 1.0;
    yscale := xhsiz / yhsiz;
  end
  else
  begin
    xscale := 1.0;
    yscale := 1.0;
  end;
  radius := DMAX(xhsiz, yhsiz);
  radius2 := radius * radius;
  inc(dst, y1 * rowsiz + x1 * BYPP);
  wavelength := (wavelength * 2);
  for y := y1 to y2 - 1 do
  begin
    dest := dst;
    for x := x1 to x2 - 1 do
    begin
      dx := (x - cen_x) * xscale;
      dy := (y - cen_y) * yscale;
      d := sqrt(dx * dx + dy * dy);
      if reflective then
      begin
        amnt := amplitude * abs(sin(((d / wavelength) * (2.0 * PI) + fphase)));
        needx := (amnt * dx) / xscale + cen_x;
        needy := (amnt * dy) / yscale + cen_y;
      end
      else
      begin
        amnt := amplitude * sin(((d / wavelength) * (2.0 * PI) + fphase));
        needx := (amnt + dx) / xscale + cen_x;
        needy := (amnt + dy) / yscale + cen_y;
      end;
      xi := trunc(needx);
      yi := trunc(needy);
      if (xi > width - 2) then
        xi := width - 2
      else if (xi < 0) then
        xi := 0;
      if (yi > height - 2) then
        yi := height - 2
      else if (yi < 0) then
        yi := 0;
      p := pbyte(int64(DWORD(src))+ rowsiz * yi + xi * BYPP);
      x1_in := (0 <= xi) and (xi <= width - 1);
      y1_in := (0 <= yi) and (yi <= height - 1);
      x2_in := (0 <= xi + 1) and (xi + 1 <= width - 1);
      y2_in := (0 <= yi + 1) and (yi + 1 <= height - 1);
      for k := 0 to BYPP - 1 do
      begin
        if x1_in and y1_in then
          values[0] := pbyte(int64(DWORD(p)) + k)^
        else
          values[0] := 0;
        if x2_in and y1_in then
          values[1] := pbyte(int64(DWORD(p)) + BYPP + k)^
        else
          values[1] := 0;
        if x1_in and y2_in then
          values[2] := pbyte(int64(DWORD(p)) + rowsiz + k)^
        else
          values[2] := 0;
        if x2_in then
        begin
          if y2_in then
            values[3] := pbyte(int64(DWORD(p)) + BYPP + k + rowsiz)^
          else
            values[3] := 0;
        end
        else
          values[3] := 0;
        val := bilinear(needx, needy, values);
        dest^ := val;
        inc(dest);
      end;
    end;
    inc(dst, rowsiz);
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
  end;
  Bitmap.AssignImage(dstbmp);
  FreeAndNil(srcbmp);
  FreeAndNil(dstbmp);
end;

// creates a palette from ColorMap
// Ncol max 256
// destroy with DeleteObject
function _CreateWinPalette(var ColorMap: array of TRGB; NCol: integer): HPalette;
type
  tpal = record
    palVersion: word;
    palNumEntries: word;
    PaletteEntry: array[0..255] of TPALETTEENTRY;
  end;
  plogpalette = ^tlogpalette;
var
  pa: tpal;
  q: integer;
begin
  pa.palVersion := $300;
  pa.palNumEntries := NCol;
  for q := 0 to NCol - 1 do
  begin
    pa.PaletteEntry[q].peRed := ColorMap[q].r;
    pa.PaletteEntry[q].peGreen := ColorMap[q].g;
    pa.PaletteEntry[q].peBlue := ColorMap[q].b;
    pa.PaletteEntry[q].peFlags := 0;
  end;
  result := CreatePalette(plogpalette(@pa)^);
end;

const
  IEHIDDENFILEVERSION=0;
  IEHIDDENENCODEALG=0;

type
  TIEHiddenRec = packed record
    Version: byte; // version: IEHIDDENFILEVERSION
    EncodeAlg: byte; // crypt algorithm : IEHIDDENENCODEALG
    res1, res2: byte; // reserved
    DataLen: integer; // data length
  end;


{!!
<FS>TImageEnProc.WriteHiddenData

<FM>Declaration<FC>
function WriteHiddenData(data:PAnsiChar; count:integer):integer;

<FM>Description<FN>
<A TImageEnProc.WriteHiddenText> or <A TImageEnProc.WriteHiddenData> writes hidden text or hidden raw data in a true color image, respectively. Hidden information is stored inside the image (uses a pixel color modulation) and is independent of the image file format.

The hidden text will be lost if you save the image with Jpeg or if you subsample the colors.
Use WriteHiddenText to write a simple string and WriteHiddenData to write a block of count bytes (you can write to a hidden image or sound).

<FM>Example<FC>

// Hides image "alfa.jpg" in "beta.jpg", then saves in "gamma.png"
procedure TForm1.Button2(Sender: TObject);
var
  ms:TMemoryStream;
begin
  ImageEnView1.IO.LoadFromFile('beta.jpg');
  ms:=TMemoryStream.Create;
  ms.LoadFromFile('alfa.jpg');
  ImageEnView1.Proc.WriteHiddenData(ms.Memory,ms.Size);
  ms.free;
  ImageEnView1.IO.SaveToFile('gamma.png');
end;

// Read an hidden Jpeg image
procedure TForm1.Button1Click(Sender: TObject);
var
  ms:TMemoryStream;
Begin
  ImageEnView1.IO.LoadFromFile('gamma.png');
  ms:=TMemoryStream.Create;
  ms.Size:=ImageEnView1.Proc.ReadHiddenData(nil,0) );
  ImageEnView1.Proc.ReadHiddenData(ms.Memory,ms.Size);
  ImageEnView2.IO.LoadFromStreamJpeg(ms);
  ms.Free;
End;

!!}
function TImageEnProc.WriteHiddenData(data: PAnsiChar; count: integer): integer;
var
  row, col: integer;
  px: pbyte;
  wb, bc: integer;
  hr: TIEHiddenRec;
  bb: byte;
begin
  result := 0;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_WRITEHIDDENDATA, ieuImage);
  fillchar(hr, sizeof(TIEHiddenRec), 0);
  if count=-1 then
  begin
    // writes a wrong header
    hr.DataLen := -1;
    hr.Version := 255;
    hr.EncodeAlg := 255;
    hr.res1 := 255;
    hr.res2 := 255;
  end
  else
    hr.DataLen := count;
  wb := 0; // bit 0..7
  bc := 0;
  inc(count, sizeof(TIEHiddenRec));
  for row := 0 to fIEBitmap.Height - 1 do
  begin
    px := fIEBitmap.ScanLine[row];
    for col := 0 to (fIEBitmap.Width * 3 - 1) do
    begin
      if bc < sizeof(TIEHiddenRec) then
        bb := pbytearray(@hr)^[bc]
      else
        bb := pbyte(data)^;
      if (bb and (1 shl wb)) <> 0 then
      begin
        // write 1: make px^ odd
        if (px^ and 1) = 0 then
          inc(px^);
      end
      else
      begin
        // write 0: make px^ even
        if (px^ and 1) <> 0 then
        begin
          if px^ = 255 then
            dec(px^)
          else
            inc(px^);
        end;
      end;
      inc(wb);
      if wb = 8 then
      begin
        wb := 0;
        inc(bc);
        if bc = count then
          break;
        if bc > sizeof(TIEHiddenRec) then
          inc(data);
      end;
      inc(px);
    end;
    if bc = count then
      break;
  end;
  Update;
  result := count - sizeof(TIEHiddenRec);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.WriteHiddenText

<FM>Declaration<FC>
function WriteHiddenText(text:AnsiString):integer;
function WriteHiddenData(data:PAnsiChar; count:integer):integer;

<FM>Description<FN>
<A TImageEnProc.WriteHiddenText> or <A TImageEnProc.WriteHiddenData> writes hidden text or hidden raw data in a true color image, respectively. Hidden information is stored inside the image (uses a pixel color modulation) and is independent of the image file format.

The hidden text will be lost if you save the image with Jpeg or if you subsample the colors.
Use WriteHiddenText to write a simple string and WriteHiddenData to write a block of count bytes (you can write to a hidden image or sound).

<FM>Example<FC>

// Hides "copyright by HiComponents" in 'alfa.tif'
ImageEnView1.Proc.WriteHiddenText('Copyright by HiComponents');
ImageEnView1.IO.SaveToFile('alfa.tif');

// Read simple string from 'alfa.tif'
ImageEnView1.IO.LoadFromFile('alfa.tif');
mystring:=ImageEnView1.Proc.ReadHiddenText;
!!}
// return written bytes
function TImageEnProc.WriteHiddenText(text: AnsiString): integer;
begin
  result := WriteHiddenData(PAnsiChar(text), length(text));
end;

{!!
<FS>TImageEnProc.ClearHiddenText

<FM>Declaration<FC>
procedure ClearHiddenText;

<FM>Description<FN>
This method removes the text added using WriteHiddenText or WriteHiddenData.

!!}
procedure TImageEnProc.ClearHiddenText;
var
  space:PAnsiChar;
  dim:integer;
begin
  dim := GetHiddenDataSpace;
  space := Allocmem(dim); // zero filled
  try
    WriteHiddenData(space, dim); // zero fill
    WriteHiddenData(space, 0); // directory fill
  finally
    freemem(space);
  end;
  DoFinishWork;
end;

// calculates hidden space

{!!
<FS>TImageEnProc.GetHiddenDataSpace

<FM>Declaration<FC>
function GetHiddenDataSpace:integer;

<FM>Description<FN>
GetHiddenDataSpace returns the available hidden space inside the current image (in bytes).

<FM>Example<FC>

// Shows how much hidden chars 'alfa.tif' can contains.
ImageEnView1.IO.LoadFromFile('alfa.tif');
freesp:=ImageEnView1.Proc.GetHiddenDataSpace;
ShowMessage('You can type '+IntToStr(freesp)+' hidden chars');
!!}
function TImageEnProc.GetHiddenDataSpace: integer;
begin
  result := 0;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  result := fIEBitmap.Width * fIEBitmap.Height * 3 div 8 - sizeof(TIEHiddenRec);
end;

{!!
<FS>TImageEnProc.ReadHiddenData

<FM>Declaration<FC>
function ReadHiddenData(data:PAnsiChar; maxlen:integer):integer;

<FM>Description<FN>
<A TImageEnProc.ReadHiddenText> or <A TImageEnProc.ReadHiddenData> returns hidden text or hidden raw data written with WriteHiddenText or WriteHiddenData.

Hidden information is stored inside the image (uses a pixel color modulation) and is independent of the image file format.
The hidden text will be lost if you save an image with Jpeg or subsample colors.
Use ReadHiddenText to read simple string and ReadHiddenData to read buffer of raw data.
If you set data to nil and maxlen to 0 ReadHiddenData returns the length of data to read.


<FM>Example<FC>

// Hides image "alfa.jpg" in "beta.jpg", then saves in "gamma.png"
procedure TForm1.Button2(Sender: TObject);
var
  ms:TMemoryStream;
begin
  ImageEnView1.IO.LoadFromFile('beta.jpg');
  ms:=TMemoryStream.Create;
  ms.LoadFromFile('alfa.jpg');
  ImageEnView.Proc.WriteHiddenData(ms.Memory,ms.Size);
  ms.free;
  ImageEnView1.IO.SaveToFile('gamma.png');
end;

// Read an hidden Jpeg image
procedure TForm1.Button1Click(Sender: TObject);
var
  ms:TMemoryStream;
Begin
  ImageEnView1.IO.LoadFromFile('gamma.png');
  ms:=TMemoryStream.Create;
  ms.Size:=ImageEnView1.Proc.ReadHiddenData(nil,0) );
  ImageEnView1.Proc.ReadHiddenData(ms.Memory,ms.Size);
  ImageEnView2.IO.LoadFromStreamJPeg(ms);
  ms.Free;
End;
!!}
// if maxlen is 0 and data=nil returns the data length
function TImageEnProc.ReadHiddenData(data: PAnsiChar; maxlen: integer): integer;
var
  row, col: integer;
  px: pbyte;
  rb, rc: integer;
  hr: TIEHiddenRec;
  bb: byte;
  buflen: integer;
  function IsValidHeader:boolean;
  begin
    with hr do
      result:= (DataLen<buflen) and (Version<=IEHIDDENFILEVERSION) and (EncodeAlg<=IEHIDDENENCODEALG) and (res1=0) and (res2=0);
  end;
  function ExitMainLoop:boolean;
  begin
    result:= (maxlen = 0) or (rc >= hr.DataLen + sizeof(TIEHiddenRec)) or (not IsValidHeader);
  end;
begin
  result := 0;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  buflen:=fIEBitmap.Width*fIEBitmap.Height*3;
  rb := 0; // read bits
  rc := 0; // read bytes
  bb := 0;
  for row := 0 to fIEBitmap.Height - 1 do
  begin
    px := fIEBitmap.ScanLine[row];
    for col := 0 to (fIEBitmap.Width * 3) - 1 do
    begin
      if (px^ and 1) <> 0 then
        // odd: 1
        bb := bb or (1 shl rb);
      inc(rb);
      if rb = 8 then
      begin
        // filled a byte
        if rc < sizeof(TIEHiddenRec) then
          pbytearray(@hr)^[rc] := bb
        else
        begin
          if ExitMainLoop then
            break;
          pbyte(data)^ := bb;
          inc(data);
          dec(maxlen);
        end;
        inc(rc);
        rb := 0;
        bb := 0;
      end;
      inc(px);
    end;
    if ExitMainLoop then
      break;
  end;
  if IsValidHeader then
    result := hr.DataLen;
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.ReadHiddenText

<FM>Declaration<FC>
function ReadHiddenText:AnsiString;

<FM>Description<FN>
<A TImageEnProc.ReadHiddenText> or <A TImageEnProc.ReadHiddenData> returns hidden text or hidden raw data written with WriteHiddenText or WriteHiddenData.

Hidden information is stored inside the image (uses a pixel color modulation) and is independent of the image file format.
The hidden text will be lost if you save an image with Jpeg or subsample colors.
Use ReadHiddenText to read simple string and ReadHiddenData to read buffer of raw data.
If you set data to nil and maxlen to 0 ReadHiddenData returns the length of data to read.


<FM>Example<FC>

// Hides "copyright by HiComponents" in 'alfa.tif'
ImageEnView1.Proc.WriteHiddenText('Copyright by HiComponents');
ImageEnView1.IO.SaveToFile('alfa.tif');

// Read simple string from 'alfa.tif'
ImageEnView1.IO.LoadFromFile('alfa.tif');
mystring:=ImageEnView1.Proc.ReadHiddenText;
!!}
function TImageEnProc.ReadHiddenText: AnsiString;
var
  ln: integer;
begin
  ln := ReadHiddenData(nil, 0);
  if ln>0 then
  begin
    SetLength(result, ln);
    ReadHiddenData(PAnsiChar(result), ln);
  end
  else
    result:='';
end;

procedure YUV2RGB(y, u, v: integer; var RGB: TRGB);
begin
  with RGB do
  begin
    b := blimit(round(1.164 * (y - 16) + 2.018 * (u - 128)));
    g := blimit(round(1.164 * (y - 16) - 0.813 * (v - 128) - 0.391 * (u - 128)));
    r := blimit(round(1.164 * (y - 16) + 1.596 * (v - 128)));
  end;
end;

// Convert IYU1 to Bitmap (24bit)
// YUV (4:1:1)
// "12 bit format used in mode 2 of the IEEE 1394 Digital Camera 1.04 spec"
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyIYU1ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
type
  TIYU1 = packed record
    u0: byte;
    y0: byte;
    y1: byte;
    v0: byte;
    y2: byte;
    y3: byte;
  end;
  PIYU1 = ^TIYU1;
var
  row, col, rr: integer;
  yuv: PIYU1;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PIYU1(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
      with yuv^ do
      begin
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        YUV2RGB(y1, u0, v0, px^);
        inc(px);
        YUV2RGB(y2, u0, v0, px^);
        inc(px);
        YUV2RGB(y3, u0, v0, px^);
        inc(px);
        inc(col, 4);
        inc(yuv);
      end;
    inc(row, zinc);
  end;
end;

// Convert IYU2 to Bitmap (24bit)
// YUV (4:4:4)
// "24 bit format used in mode 2 of the IEEE 1394 Digital Camera 1.04 spec"
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyIYU2ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
type
  TIYU2 = packed record
    u0: byte;
    y0: byte;
    v0: byte;
  end;
  PIYU2 = ^TIYU2;
var
  row, col, rr: integer;
  yuv: PIYU2;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PIYU2(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
      with yuv^ do
      begin
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        inc(col);
        inc(yuv);
      end;
    inc(row, zinc);
  end;
end;

// Convert UYVY to Bitmap (24bit)
// YUV (4:2:2)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyUYVYToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
type
  TUYVY = packed record
    u0: byte;
    y0: byte;
    v0: byte;
    y1: byte;
  end;
  PUYVY = ^TUYVY;
var
  row, col, rr: integer;
  yuv: PUYVY;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PUYVY(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
      with yuv^ do
      begin
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        YUV2RGB(y1, u0, v0, px^);
        inc(px);
        inc(col, 2);
        inc(yuv);
      end;
    inc(row, zinc);
  end;
end;

// Convert YUY2 to Bitmap (24bit)
// YUV (4:2:2)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyYUY2ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
type
  TYUY2 = packed record
    y0: byte;
    u0: byte;
    y1: byte;
    v0: byte;
  end;
  PYUY2 = ^TYUY2;
var
  row, col, rr: integer;
  yuv: PYUY2;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PYUY2(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
      with yuv^ do
      begin
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        YUV2RGB(y1, u0, v0, px^);
        inc(px);
        inc(col, 2);
        inc(yuv);
      end;
    inc(row, zinc);
  end;
end;

// Convert YVYU to Bitmap (24bit)
// YUV (4:2:2)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyYVYUToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
type
  TYVYU = packed record
    y0: byte;
    v0: byte;
    y1: byte;
    u0: byte;
  end;
  PYVYU = ^TYVYU;
var
  row, col, rr: integer;
  yuv: PYVYU;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PYVYU(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
      with yuv^ do
      begin
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        YUV2RGB(y1, u0, v0, px^);
        inc(px);
        inc(col, 2);
        inc(yuv);
      end;
    inc(row, zinc);
  end;
end;

// Convert Y41P to Bitmap (24bit)
// YUV (4:1:1)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyY41PToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
type
  TY41P = packed record
    u0: byte;
    y0: byte;
    v0: byte;
    y1: byte;
    u4: byte;
    y2: byte;
    v4: byte;
    y3: byte;
    y4: byte;
    y5: byte;
    y6: byte;
    y7: byte;
  end;
  PY41P = ^TY41P;
var
  row, col, rr: integer;
  yuv: PY41P;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PY41P(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
      with yuv^ do
      begin
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        YUV2RGB(y1, u0, v0, px^);
        inc(px);
        YUV2RGB(y2, u0, v0, px^);
        inc(px);
        YUV2RGB(y3, u0, v0, px^);
        inc(px);
        YUV2RGB(y4, u4, v4, px^);
        inc(px);
        YUV2RGB(y5, u4, v4, px^);
        inc(px);
        YUV2RGB(y6, u4, v4, px^);
        inc(px);
        YUV2RGB(y7, u4, v4, px^);
        inc(px);
        inc(col, 8);
        inc(yuv);
      end;
    inc(row, zinc);
  end;
end;

// Convert Y211 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyY211ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
type
  TY211 = packed record
    y0: byte;
    u0: byte;
    y2: byte;
    v0: byte;
  end;
  PY211 = ^TY211;
var
  row, col, rr: integer;
  yuv: PY211;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PY211(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
      with yuv^ do
      begin
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        YUV2RGB(y0, u0, v0, px^);
        inc(px);
        YUV2RGB(y2, u0, v0, px^);
        inc(px);
        YUV2RGB(y2, u0, v0, px^);
        inc(px);
        inc(col, 4);
        inc(yuv);
      end;
    inc(row, zinc);
  end;
end;

// Convert CLJR to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyCLJRToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
var
  row, col, rr: integer;
  u, v: integer;
  yuv: PDWORD;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  yuv := PDWORD(xbits);
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    while col < fBitmap.Width - 1 do
    begin
      v := yuv^ and $3F;
      u := (yuv^ shr 6) and $3F;
      YUV2RGB(((yuv^ shr 12) and $1F), u, v, px^);
      inc(px);
      YUV2RGB(((yuv^ shr 17) and $1F), u, v, px^);
      inc(px);
      YUV2RGB(((yuv^ shr 22) and $1F), u, v, px^);
      inc(px);
      YUV2RGB(((yuv^ shr 27) and $1F), u, v, px^);
      inc(px);
      inc(col, 4);
      inc(yuv);
    end;
    inc(row, zinc);
  end;
end;

// Convert YVU9 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyYVU9ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
var
  row, col, rr: integer;
  y, u, v: pbyte;
  bu, bv: pbyte;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  y := xbits;
  v := pbyte(int64(DWORD(xbits)) + fBitmap.Height * fBitmap.Width);
  u := pbyte(int64(DWORD(xbits)) + fBitmap.Height * fBitmap.Width + (fBitmap.Height div 4) * (fBitmap.Width div 4));
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    bv := v;
    bu := u;
    while col < fBitmap.Width - 1 do
    begin
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      inc(u);
      inc(v);
      inc(col, 4);
    end;
    inc(row, zinc);
    if (row mod 4) <> 0 then
    begin
      v := bv;
      u := bu;
    end;
  end;
end;

// Converts YV12 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyYV12ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
var
  row, col, rr: integer;
  y, u, v: pbyte;
  bu, bv: pbyte;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  y := xbits;
  v := pbyte(int64(DWORD(xbits)) + fBitmap.Height * fBitmap.Width);
  u := pbyte(int64(DWORD(xbits)) + fBitmap.Height * fBitmap.Width + (fBitmap.Height div 2) * (fBitmap.Width div 2));
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    bv := v;
    bu := u;
    while col < fBitmap.Width - 1 do
    begin
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      inc(u);
      inc(v);
      inc(col, 2);
    end;
    inc(row, zinc);
    if (row mod 2) <> 0 then
    begin
      v := bv;
      u := bu;
    end;
  end;
end;

// Convert I420 to Bitmap (24bit)
//
// xbits : image buffer
// fBitmap : TIEBaseBitmap object. PixelFormat, Height and Width must be assigned
// dirc : direction. True= Top->down  False=Down->Top

procedure _CopyI420ToBitmap(xbits: pbyte; fBitmap: TIEBaseBitmap; dirc: boolean);
var
  row, col, rr: integer;
  y, u, v: pbyte;
  bu, bv: pbyte;
  px: PRGB;
  zinc: integer;
begin
  if dirc then
  begin
    zinc := 1;
    row := 0;
  end
  else
  begin
    zinc := -1;
    row := fBitmap.Height - 1;
  end;
  y := xbits;
  u := pbyte(int64(DWORD(xbits)) + fBitmap.Height * fBitmap.Width);
  v := pbyte(int64(DWORD(xbits)) + fBitmap.Height * fBitmap.Width + (fBitmap.Height div 2) * (fBitmap.Width div 2));
  for rr := 0 to fBitmap.Height - 1 do
  begin
    px := fBitmap.Scanline[row];
    col := 0;
    bv := v;
    bu := u;
    while col < fBitmap.Width - 1 do
    begin
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      YUV2RGB(y^, u^, v^, px^);
      inc(px);
      inc(y);
      inc(u);
      inc(v);
      inc(col, 2);
    end;
    inc(row, zinc);
    if (row mod 2) <> 0 then
    begin
      v := bv;
      u := bu;
    end;
  end;
end;

// Copy a DIB in fBitmap (fBitmap must exists)
// fBitmap will be pf1bit or pf24bit
// NOTE: desn't process DIB's colormap for 1 bpp bitmaps
// xbits: bitmap pixels. If "nil" the pixels are inside hbi.
// return bitcount of hbi
// unlck: If true hbi represents a pointer (then doesn't call GlobalLock)
// NOTE: for YUV formats xbits must point to image data
function _CopyDIB2Bitmap(hbi: THandle; fBitmap: TBitmap; xbits: pbyte; unlck: boolean): integer;
var
  tbmp: TIEBitmap;
begin
  tbmp := TIEBitmap.Create;
  tbmp.EncapsulateTBitmap(fBitmap, true);
  result := _CopyDIB2BitmapEx(hbi, tbmp, xbits, unlck);
  FreeAndNil(tbmp);
end;

// assume that fBitmap is already allocated
// supports only BI_RGB, BI_RLE8, BI_RLE4, BI_BITFIELDS (not YUV...)
function _CopyDIB2BitmapEx(hbi: THandle; fBitmap: TIEBaseBitmap; xbits: pbyte; unlck: boolean): integer;
type
  TRGBQUADARRAY = array[0..Maxint div 16] of TRGBQUAD;
  PRGBQUADARRAY = ^TRGBQUADARRAY;
var
  pbi: PBITMAPINFO;
  lw: integer; // row length in bytes
  Compression: DWORD; // compressino type
  Width, Height: integer; // image width and height
  BitCount: integer; // Bitcount
  y, x, z, zz, c: integer;
  bits, bits2: pbyte;
  wbits: pword;
  px: PRGB;
  bfdw: array[0..2] of dword;
  gbitcount, rbitcount, bbitcount: integer;
  rshift, gshift, bshift: integer;
  ColorMap: PRGBQUADARRAY;
begin
  result := 0;
  if unlck then
    pbi := pointer(hbi)
  else
    pbi := GlobalLock(hbi);
  if pbi=nil then
    exit;
  try
    Width := pbi^.bmiHeader.biWidth;
    Height := pbi^.bmiHeader.biHeight;
    BitCount := pbi^.bmiHeader.biBitCount;
    result := BitCount;
    Compression := pbi^.bmiHeader.biCompression;
    lw := (((Width * BitCount) + 31) div 32) * 4;
    if BitCount = 1 then
      fBitmap.Allocate(Width, Height, ie1g)
    else
      fBitmap.Allocate(Width, Height, ie24RGB);
    case Compression of
      BI_RGB, BI_RLE8, BI_RLE4, BI_BITFIELDS:
        case BitCount of
          1:
            begin
              // 1 bit per pixel
              bits := pbyte(pbi);
              inc(bits, pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
              y := pbi^.bmiHeader.biClrUsed;
              if y = 0 then
                y := 2;
              inc(bits, sizeof(TRGBQUAD) * y); // salta colormap
              if xbits <> nil then
                bits := xbits;
              CopyMemory(fBitmap.Scanline[height - 1], bits, lw * fbitmap.height);
            end;
          4:
            begin
              // 4 bit per pixel
              bits := pbyte(pbi);
              inc(bits, pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
              Colormap := PRGBQUADARRAY(bits);
              y := pbi^.bmiHeader.biClrUsed;
              if y = 0 then
                y := 16;
              inc(bits, sizeof(TRGBQUAD) * y); // salta colormap
              if xbits <> nil then
                bits := xbits;
              zz := Width div 2;
              z := zz + (Width and 1); // if odd inc of 1
              dec(zz);
              for y := Height - 1 downto 0 do
              begin
                px := fbitmap.Scanline[y];
                bits2 := bits;
                for x := 0 to z - 1 do
                begin
                  c := bits2^ shr 4;
                  px^.b := ColorMap^[c].rgbBlue;
                  px^.g := ColorMap^[c].rgbGreen;
                  px^.r := ColorMap^[c].rgbRed;
                  inc(px);
                  if x = zz then
                    break;
                  c := bits2^ and $0F;
                  px^.b := ColorMap^[c].rgbBlue;
                  px^.g := ColorMap^[c].rgbGreen;
                  px^.r := ColorMap^[c].rgbRed;
                  inc(px);
                  inc(bits2);
                end;
                inc(bits, lw);
              end;
            end;
          8:
            begin
              // 8 bit per pixel
              bits := pbyte(pbi);
              inc(bits, pbi^.bmiHeader.biSize); //inc(bits,sizeof(TBITMAPINFOHEADER));
              Colormap := PRGBQUADARRAY(bits);
              y := pbi^.bmiHeader.biClrUsed;
              if y = 0 then
                y := 256;
              inc(bits, sizeof(TRGBQUAD) * y); // salta colormap
              if xbits <> nil then
                bits := xbits;
              for y := Height - 1 downto 0 do
              begin
                px := fbitmap.Scanline[y];
                bits2 := bits;
                for x := 0 to Width - 1 do
                begin
                  px^.b := ColorMap^[bits2^].rgbBlue;
                  px^.g := ColorMap^[bits2^].rgbGreen;
                  px^.r := ColorMap^[bits2^].rgbRed;
                  inc(bits2);
                  inc(px);
                end;
                inc(bits, lw);
              end;
            end;
          16: // 16 bit per pixel
            begin
              bits := pbyte(pbi);
              inc(bits, pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
              if xbits <> nil then
                bits := xbits;
              if Compression = BI_RGB then
              begin
                // configurazione 5-5-5
                bfdw[0] := $7C00;
                bfdw[1] := $03E0;
                bfdw[2] := $001F;
              end
              else if Compression = BI_BITFIELDS then
              begin
                CopyMemory(@bfdw, bits, 3 * sizeof(dword));
                inc(bits, 3 * sizeof(dword)); // bypass bitfield
              end;
              rbitcount := _GetBitCount(bfdw[0]);
              gbitcount := _GetBitCount(bfdw[1]);
              bbitcount := _GetBitCount(bfdw[2]);
              rshift := (gbitCount + bbitCount) - (8 - rbitCount);
              gshift := bbitCount - (8 - gbitCount);
              bshift := 8 - bbitCount;
              for y := Height - 1 downto 0 do
              begin
                px := fbitmap.Scanline[y];
                wbits := pword(bits);
                for x := 0 to Width - 1 do
                begin
                  px^.r := (wbits^ and bfdw[0]) shr rshift;
                  px^.g := (wbits^ and bfdw[1]) shr gshift;
                  px^.b := (wbits^ and bfdw[2]) shl bshift;
                  inc(px);
                  inc(wbits);
                end;
                inc(bits, lw);
              end;
            end;
          24: // 24 bit per pixel
            begin
              if Compression = BI_RGB then
              begin
                bits := pbyte(pbi);
                inc(bits, pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                if xbits <> nil then
                  bits := xbits;
                for y := Height - 1 downto 0 do
                begin
                  CopyMemory(fbitmap.Scanline[y], bits, lw);
                  inc(bits, lw);
                end;
              end;
            end;
          32: // 32 bit per pixel
            begin
              if Compression = BI_BITFIELDS then
              begin
                // BITFIELDS, bitfield must be FF,00FF and 0000FF
                bits := pbyte(pbi);
                inc(bits, pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
                inc(bits, 3 * sizeof(dword)); // bypass bitfield
              end
              else if Compression = BI_RGB then
              begin
                bits := pbyte(pbi);
                inc(bits, pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
              end
              else
              begin
                if not unlck then
                  GlobalUnLock(hbi);
                exit; // EXIT POINT!!
              end;
              if xbits <> nil then
                bits := xbits;
              for y := Height - 1 downto 0 do
              begin
                px := fbitmap.Scanline[y];
                bits2 := bits;
                for x := 0 to Width - 1 do
                begin
                  px^.b := bits2^;
                  inc(bits2);
                  px^.g := bits2^;
                  inc(bits2);
                  px^.r := bits2^;
                  inc(bits2, 2);
                  inc(px);
                end;
                inc(bits, lw);
              end;
            end;
        end; // Case of Bitcount
      IEBI_IYU1: _CopyIYU1ToBitmap(xbits, fBitmap, Height > 0);
      IEBI_IYU2: _CopyIYU2ToBitmap(xbits, fBitmap, Height > 0);
      IEBI_UYVY, IEBI_UYNV: _CopyUYVYToBitmap(xbits, fBitmap, Height > 0);
      IEBI_cyuv: _CopyUYVYToBitmap(xbits, fBitmap, Height < 0);
      IEBI_YUY2, IEBI_YUNV: _CopyYUY2ToBitmap(xbits, fBitmap, Height > 0);
      IEBI_YVYU: _CopyYVYUToBitmap(xbits, fBitmap, Height > 0);
      IEBI_Y41P: _CopyY41PToBitmap(xbits, fBitmap, Height < 0);
      IEBI_Y211: _CopyY211ToBitmap(xbits, fBitmap, Height > 0);
      IEBI_CLJR: _CopyCLJRToBitmap(xbits, fBitmap, Height > 0);
      IEBI_YVU9: _CopyYVU9ToBitmap(xbits, fBitmap, Height > 0);
      IEBI_YV12: _CopyYV12ToBitmap(xbits, fBitmap, Height > 0);
      IEBI_I420, IEBI_IYUV: _CopyI420ToBitmap(xbits, fBitmap, Height > 0);
      // not supported...
      IEBI_Y41T: ;
      IEBI_Y42T: ;
      IEBI_CLPL: ;
      IEBI_IF09: ;
    end;
  finally
    if not unlck then
      GlobalUnLock(hbi);
  end;
end;


procedure IEDIBGamma(hbi: THandle; gamma:double);
const
  Inv255 = 1.0 / 255;
var
  pbi: PBITMAPINFO;
  lw: integer; // row length in bytes
  Compression: DWORD; // compressino type
  Width, Height: integer; // image width and height
  BitCount: integer; // Bitcount
  y, x: integer;
  bits: pbyte;
  px: PRGB;
  i: Integer;
  InvGamma: double;
  lut: array[0..255] of byte;
begin
  pbi := GlobalLock(hbi);
  Width := pbi^.bmiHeader.biWidth;
  Height := pbi^.bmiHeader.biHeight;
  BitCount := pbi^.bmiHeader.biBitCount;
  Compression := pbi^.bmiHeader.biCompression;
  lw := (((Width * BitCount) + 31) div 32) * 4;
  // prepare LUT
  InvGamma := 1.0 / Gamma;
  for i := 0 to 255 do
    lut[i] := blimit(round(255 * iepower(i * Inv255, InvGamma)));
  // apply LUT
  case Compression of
    BI_RGB, BI_RLE8, BI_RLE4, BI_BITFIELDS:
      case BitCount of
        24: // 24 bit per pixel
          begin
            if Compression = BI_RGB then
            begin
              bits := pbyte(pbi);
              inc(bits, pbi^.bmiHeader.biSize); // inc(bits,sizeof(TBITMAPINFOHEADER));
              for y := Height - 1 downto 0 do
              begin
                px:=PRGB(bits);
                for x := 0 to Width-1 do
                begin
                  with px^ do      
                  begin
                    r := lut[r];
                    g := lut[g];
                    b := lut[b];
                  end;
                  inc(px);
                end;
                inc(bits, lw);
              end;
            end;
          end;
      end;
  end;
  GlobalUnLock(hbi);
end;

// Copy polygon "Polygon" of Source inside Position of Dest
procedure _CopyPolygonToPoint(Source: TBitmap; Polygon: PPointArray; PolygonLen: integer; Dest: TBitmap; const Position: TPoint);
var
  hrgn: THandle;
  NewPoly: PPointArray;
  q: integer;
  sx1, sy1, sx2, sy2: integer;
  drect: TRect;
  p1, p2: integer;
begin
  if PolygonLen < 3 then
    exit;
  // find sx1,sy1,sx2,sy2, source rectangle
  sx1 := Polygon^[0].x;
  sy1 := Polygon^[0].y;
  sx2 := Polygon^[1].x;
  sy2 := Polygon^[1].y;
  OrdCor(sx1, sy1, sx2, sy2);
  for q := 2 to PolygonLen - 1 do
  begin
    if Polygon^[q].x <> IESELBREAK then
    begin
      sx1 := imin(sx1, Polygon^[q].x);
      sy1 := imin(sy1, Polygon^[q].y);
      sx2 := imax(sx2, Polygon^[q].x);
      sy2 := imax(sy2, Polygon^[q].y);
    end;
  end;
  //
  GetMem(NewPoly, sizeof(TPoint) * PolygonLen);
  // traslate Polygon, destination polygon
  for q := 0 to PolygonLen - 1 do
  begin
    if Polygon^[q].x = IESELBREAK then
      NewPoly^[q] := Polygon^[q]
    else
    begin
      NewPoly^[q].x := Polygon^[q].x - sx1 + Position.x;
      NewPoly^[q].y := Polygon^[q].y - sy1 + Position.y;
    end;
  end;
  //
  drect.Left := Position.x;
  drect.Top := Position.y;
  drect.Right := Position.x + sx2 - sx1;
  drect.Bottom := Position.y + sy2 - sy1;
  if Dest.Width <= drect.Right then
    Dest.Width := drect.Right;
  if Dest.Height <= drect.Bottom then
    Dest.Height := drect.bottom;
  p1 := 0;
  for q := 0 to PolygonLen do
    if (NewPoly^[q].x = IESELBREAK) or (q = PolygonLen) then
    begin
      p2 := q - p1;
      hrgn := CreatePolygonRgn(NewPoly^[p1], p2, ALTERNATE);
      SelectClipRgn(Dest.Canvas.Handle, hrgn);
      Dest.Canvas.CopyRect(drect, Source.Canvas, rect(sx1, sy1, sx2, sy2));
      SelectClipRgn(Dest.Canvas.Handle, 0);
      DeleteObject(hrgn);
      p1 := q + 1;
    end;
  freemem(NewPoly);
end;

// Copy rectangle that starts in Position of Source to polygon "Polygon" of Dest
procedure _CopyPointToPolygon(Source: TBitmap; Polygon: PPointArray; PolygonLen: integer; Dest: TBitmap; const Position: TPoint);
var
  hrgn: THandle;
  q: integer;
  sx1, sy1, sx2, sy2: integer;
  p1, p2: integer;
begin
  if PolygonLen < 3 then
    exit;
  // find sx1,sy1,sx2,sy2, destination rectangle
  sx1 := Polygon^[0].x;
  sy1 := Polygon^[0].y;
  sx2 := Polygon^[1].x;
  sy2 := Polygon^[1].y;
  OrdCor(sx1, sy1, sx2, sy2);
  for q := 2 to PolygonLen - 1 do
  begin
    if Polygon^[q].x <> IESELBREAK then
    begin
      sx1 := imin(sx1, Polygon^[q].x);
      sy1 := imin(sy1, Polygon^[q].y);
      sx2 := imax(sx2, Polygon^[q].x);
      sy2 := imax(sy2, Polygon^[q].y);
    end;
  end;
  //
  if Dest.Width < sx2 then
    Dest.Width := sx2;
  if Dest.Height < sy2 then
    Dest.Height := sy2;
  p1 := 0;
  for q := 0 to PolygonLen do
    if (Polygon^[q].x = IESELBREAK) or (q = PolygonLen) then
    begin
      p2 := q - p1;
      hrgn := CreatePolygonRgn(Polygon^[p1], p2, ALTERNATE);
      SelectClipRgn(Dest.Canvas.Handle, hrgn);
      Dest.Canvas.CopyRect(rect(sx1, sy1, sx2, sy2), Source.Canvas, rect(Position.x, Position.y, Position.x + sx2 - sx1, Position.y + sy2 - sy1));
      SelectClipRgn(Dest.Canvas.Handle, 0);
      DeleteObject(hrgn);
      p1 := q + 1;
    end;
end;

// copy a BGR row to RGB (and viceversa)

procedure _CopyBGR_RGB(dst: PRGB; src: PRGB; width: integer);
var
  q: integer;
begin
  CopyMemory(dst, src, width * 3);
  for q := 0 to width - 1 do
  begin
    bswap(dst^.r, dst^.b);
    inc(dst);
  end;
end;

procedure _CopyBGR_RGB48(dst: PRGB48; src: PRGB48; width: integer);
var
  q: integer;
  w:word;
begin
  CopyMemory(dst, src, width * 6);
  for q := 0 to width - 1 do
  begin
    with dst^ do
    begin
      w:=r;
      r:=b;
      b:=w;
    end;
    inc(dst);
  end;
end;

procedure _BGR2RGB(buff: PRGB; width: integer);
var
  q: integer;
begin
  for q := 0 to width - 1 do
  begin
    bswap(buff^.r, buff^.b);
    inc(buff);
  end;
end;

procedure _BGR2RGB48(buff: PRGB48; width: integer);
var
  q: integer;
  w: word;
begin
  for q := 0 to width - 1 do
  begin
    with buff^ do
    begin
      w:=r;
      r:=b;
      b:=w;
    end;
    inc(buff);
  end;
end;

// Swaps R and B in a TRGB array
// nc:numero of colors to swap

procedure _RGB2BGR(var ColorMap: array of TRGB; nc: integer);
var
  q: integer;
begin
  for q := 0 to nc - 1 do
    BSwap(ColorMap[q].R, ColorMap[q].B);
end;

// op:
//   0=maximum (dilation)
//   1=minimum (erosion)
//   2=open (erosion+dilation)
//   3=close (dilation+erosion)

procedure _MorphFilter(bitmap: TIEBitmap; WindowSize: integer; op: integer; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  col, row, x, y, w, e, xx, yy, q1, q2, xxx, yyy: integer;
  e1: integer;
  ppx: pRGB;
  per1: double;
  graypix: pbyte;
  rgbpix: PRGB;
  ww, hh: integer;
  mm: byte;
  subop: integer; // 0=dilate 1=erode
  it: integer;
  canexit: boolean;
begin
  if Bitmap.Pixelformat <> ie24RGB then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  // alloc graypix and rgbpix
  ww := (fSelX2 - fSelX1 + 1);
  hh := (fSelY2 - fSelY1 + 1);
  getmem(graypix, (ww + 2) * hh);
  getmem(rgbpix, (ww + 2) * hh * 3);
  //
  q1 := -WindowSize;
  q2 := WindowSize;
  it := 0;
  canexit := false;
  subop := 0;
  per1 := 0;
  repeat
    if op < 2 then
    begin
      subop := op;
      canexit := true;
      per1 := 100 / (fSelY2 - fSelY1 + 0.5);
    end
    else
    begin
      if op = 2 then
      begin
        // open (erosion(1) + dilation(0))
        per1 := 100 / (fSelY2 - fSelY1 + 0.5) / 2;
        if it = 0 then
          subop := 1
        else
        begin
          subop := 0;
          canexit := true;
        end;
      end
      else if op = 3 then
      begin
        // close (dilation(0) + erosion(1))
        per1 := 100 / (fSelY2 - fSelY1 + 0.5) / 2;
        if it = 0 then
          subop := 0
        else
        begin
          subop := 1;
          canexit := true;
        end;
      end
      else
        break;
    end;
    // fill graypix and rgbpix
    y := 0;
    for row := fSelY1 to fSelY2 do
    begin
      ppx := bitmap.ScanLine[row];
      inc(ppx, fSelX1);
      x := 0;
      for col := fSelX1 to fSelX2 do
      begin
        with ppx^ do
          pbyte(int64(DWORD(graypix)) + y + x)^ := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
        prgb(int64(DWORD(rgbpix)) + (y + x) * 3)^ := ppx^;
        inc(ppx);
        inc(x);
      end;
      inc(y, ww);
    end;
    //
    y := 0;
    for row := fsely1 to fsely2 do
    begin
      ppx := bitmap.ScanLine[row];
      inc(ppx, fSelX1);
      x := 0;
      case subop of
        0: // maximum
          for col := fselx1 to fselx2 do
          begin
            mm := 0;
            xxx := 0;
            yyy := 0;
            for yy := q1 to q2 do
            begin
              e := int64(DWORD(graypix)) + ilimit(y + yy, 0, hh - 1) * ww;
              for xx := q1 to q2 do
              begin
                w := pbyte(e + ilimit(x + xx, 0, ww - 1))^;
                if w > mm then
                begin
                  xxx := xx;
                  yyy := yy;
                  mm := w;
                end;
              end;
            end;
            ppx^ := prgb(int64(DWORD(rgbpix)) + (ilimit(y + yyy, 0, hh - 1) * ww + ilimit(x + xxx, 0, ww - 1)) * 3)^;
            inc(x);
            inc(ppx);
          end;
        1: // minimum
          for col := fselx1 to fselx2 do
          begin
            mm := 255;
            xxx := 0;
            yyy := 0;
            for yy := q1 to q2 do
            begin
              e := int64(DWORD(graypix)) + ilimit(y + yy, 0, hh - 1) * ww;
              for xx := q1 to q2 do
              begin
                w := pbyte(e + ilimit(xx + x, 0, ww - 1))^;
                if w < mm then
                begin
                  xxx := xx;
                  yyy := yy;
                  mm := w;
                end;
              end;
            end;
            ppx^ := prgb(int64(DWORD(rgbpix)) + (ilimit(y + yyy, 0, hh - 1) * ww + ilimit(x + xxx, 0, ww - 1)) * 3)^;
            inc(x);
            inc(ppx);
          end;
      end;
      inc(y);
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1 + it * hh)));
    end;
    inc(it);
  until canexit;
  //
  freemem(graypix);
  freemem(rgbpix);
end;

// nIter = number of iterations to perform [1]
// opType = operation type (1=dilation, 2=erosion, 3=closing, 4=opening)
// size = structuring element size (must be odd) [3]
// invertFlag = invert input image before processing [true]
procedure IEmorph1bit(Bitmap:TIEBitmap; nIter:integer; opType:integer; size:integer; invertFlag:boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  width, height:integer;
  sizeD2:integer;
  xEnd, yEnd:integer;
  sum:integer;
  sumAll:integer;
  x, y, i, j, n:integer;
  imgI:TIEBitmap;
  imgO:TIEBitmap;
  per1: double;
begin
  sizeD2 := size div 2;

  height := Bitmap.Height;
  width := Bitmap.Width;

  imgI:=Bitmap;
  imgO:=TIEBitmap.Create;
  imgO.Allocate(width,height,ie1g);

  if (invertFlag) then
    _Negative1BitEx(imgI);

  yEnd := height - sizeD2;
  xEnd := width - sizeD2;

  for y := 0 to height-1 do
  begin
    for x := 0 to sizeD2 do
      imgI.Pixels_ie1g[x,y]:=false;
    for x := xEnd - 1 to width-1 do
      imgI.Pixels_ie1g[x,y]:=false;
  end;

  for x := 0 to width-1 do
  begin
    for y := 0 to sizeD2 do
      imgI.Pixels_ie1g[x,y]:=false;
    for y := yEnd - 1 to height-1 do
      imgI.Pixels_ie1g[x,y]:=false;
  end;

  imgO.AssignImage(imgI);

  sumAll := size * size;
  per1 := 100 / (height);

  for n := 0 to nIter-1 do
  begin
    for y := sizeD2 to yEnd-1 do
    begin
      for x := sizeD2 to xEnd-1 do
      begin
        sum := 0;
        for i := -sizeD2 to sizeD2 do
          for j := -sizeD2 to sizeD2 do
            if imgI.Pixels_ie1g[x+j,y+i] then
              inc(sum);

        case (opType) of
          1:                // dilation
          if (sum > 0) then
          begin
            imgO.pixels_ie1g[x,y]:=true;
          end;
          2:                // erosion
          if (sum < sumAll) then
          begin
            imgO.Pixels_ie1g[x,y]:=false;
          end;
          3:                // dilation-erosion
          if (sum > 0) then
          begin
            imgO.Pixels_ie1g[x,y]:=true;
          end;
          4:                // erosion-dilation
          if (sum < sumAll) then
          begin
            imgO.Pixels_ie1g[x,y]:=false;
          end;
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));

    end;

    imgI.AssignImage( imgO );
    if (opType = 4) then
      opType := 3
    else if (opType = 3) then
      opType := 4;
  end;

  if (invertFlag) then
    _Negative1BitEx(imgO);
  Bitmap.AssignImage(imgO);
  FreeAndNil(imgO);
end;

// Maximum (dilation)

{!!
<FS>TImageEnProc.Maximum

<FM>Declaration<FC>
procedure Maximum(WindowSize:integer);

<FM>Description<FN>
The method Maximum sets each pixel in the output image to the maximum value of all the current image pixel values in the neighborhood of size WindowSize.

The maximum filter is typically applied to an image to remove negative outlier noise.
!!}
procedure TImageEnProc.Maximum(WindowSize: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie1g, ie24RGB], x1, y1, x2, y2, Format(IERS_MAXIMUM, [WindowSize]), ProcBitmap, mask) then
    exit;
  case ProcBitmap.PixelFormat of
    ie1g:
      IEmorph1bit(ProcBitmap, 1, 1, WindowSize, true, fOnProgress, self);
    ie24RGB:
      _MorphFilter(ProcBitmap, WindowSize, 0, x1, y1, x2, y2, fOnProgress, self)
  end;
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Minimum (erosion)

{!!
<FS>TImageEnProc.Minimum

<FM>Declaration<FC>
procedure Minimum(WindowSize:integer);

<FM>Description<FN>
The method Minimum sets each pixel in the output image as the minimum value of all the current image pixel values in the neighborhood of size WindowSize.

The minimum filter is typically applied to an image to remove positive outlier noise.

!!}
procedure TImageEnProc.Minimum(WindowSize: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie1g, ie24RGB], x1, y1, x2, y2, Format(IERS_MINIMUM, [WindowSize]), ProcBitmap, mask) then
    exit;
  case ProcBitmap.PixelFormat of
    ie1g:
      IEmorph1bit(ProcBitmap, 1, 2, WindowSize, true, fOnProgress, self);
    ie24RGB:
      _MorphFilter(ProcBitmap, WindowSize, 1, x1, y1, x2, y2, fOnProgress, self);
  end;
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Open (erosion+dilation)

{!!
<FS>TImageEnProc.Opening

<FM>Declaration<FC>
procedure Opening(WindowSize:integer);

<FM>Description<FN>
The method Opening performs an erosion (Minimum filter with WindowSize paramter) followed by a dilation (Maximum filter with WindowSize parameter).

The opening filter operation will reduce small positive oriented regions and positive noise regions.
!!}
procedure TImageEnProc.Opening(WindowSize: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie1g, ie24RGB], x1, y1, x2, y2, Format(IERS_OPENING, [WindowSize]), ProcBitmap, mask) then
    exit;
  case ProcBitmap.PixelFormat of
    ie1g:
      IEmorph1bit(ProcBitmap, 1, 4, WindowSize, true, fOnProgress, self);
    ie24RGB:
      _MorphFilter(ProcBitmap, WindowSize, 2, x1, y1, x2, y2, fOnProgress, self);
  end;
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


{!!
<FS>TImageEnProc.Closing

<FM>Declaration<FC>
procedure Closing(WindowSize:integer);

<FM>Description<FN>
The method Closing performs a dilation (Maximum filter with WindowSize paramter) followed by an erosion (Minimum filter with WindowSize parameter).

The closing filter operation will reduce small negative oriented regions and negative noise regions.

!!}
//   close (dilation+erosion)
procedure TImageEnProc.Closing(WindowSize: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie1g, ie24RGB], x1, y1, x2, y2, Format(IERS_CLOSING, [WindowSize]), ProcBitmap, mask) then
    exit;
  case ProcBitmap.PixelFormat of
    ie1g:
      IEmorph1bit(ProcBitmap, 1, 3, WindowSize, true, fOnProgress, self);
    ie24RGB:
    _MorphFilter(ProcBitmap, WindowSize, 3, x1, y1, x2, y2, fOnProgress, self);
  end;
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Create a Fourier transformations of current image
// ImageType can be ieitRGB or ieitGrayscale
// NewWidth and NewHeight can be each -1 (autocalc) or the new image sizes

{!!
<FS>TImageEnProc.FTCreateImage

<FM>Declaration<FC>
function FTCreateImage(ImageType:<A TIEFtImageType>; NewWidth,NewHeight:integer):TIEFtImage;

<FM>Description<FN>
FTCreateImage creates an object that contains the Fourier transformation of the current image.

ImageType specifies the kind of the output transformation and can be ieitRGB (to build a RGB Fourier transformation) or ieitGrayscale (to build a gray scaled Fourier transformation).
NewWidth and NewHeight are useful to resample the current image before applying the Fourier transformation (to speed up the job). Set -1 to get original values.
TIEFtImage is a Delphi object and can be destroyed with the Free method.

To access to the complex data of the transformed image you have to use the TIEFtImage object that is declared in the iefft unit.
TIEFtImage exports ComplexPixel[], ComplexWidth and ComplexHeight properties.
ComplexPixel[] is defined as:
  ComplexPixel[x,y:integer]:TIEComplexColor;

ComplexPixel[] returns the complex pixel at x,y coordinate.
TIEComplexColor is defined as:
  TIEComplexColor=packed record
    // red channel
    real_Red:PIEsingle;
    imag_Red:PIEsingle;
    // blue channel
    real_Blue:PIEsingle;
    imag_Blue:PIEsingle;
    // green channel
    real_Green:PIEsingle;
    imag_Green:PIEsingle;
    // gray scale
    imag_gray:PIEsingle;
    real_gray:PIEsingle;
  end;
The fields ???_Red, ???_Blue and ???_Green are filled if ImageType is ieitRGB.
The fields ???_gray are filled if ImageType is ieitGrayscale.
ComplexWidth and ComplexHeight are the width and the height of complex image.

For example, to set complex pixel 0,0 to 0.1 write (for ImageType=ieitRGB):
ftimage.ComplexPixel[0,0].real_Red^:=0.1;
ftimage.ComplexPixel[0,0].imag_Red^:=0.1;
ftimage.ComplexPixel[0,0].real_Green^:=0.1;
ftimage.ComplexPixel[0,0].imag_Green^:=0.1;
ftimage.ComplexPixel[0,0].real_Blue^:=0.1;
ftimage.ComplexPixel[0,0].imag_Blue^:=0.1;


<FM>Example<FC>

// this code shows in ImageEnView2 the displayable Fourier transformation 
// of ImageEnView1 image
// notes: ImageEnProc1 attached with ImageEnView1 and ImageEnProc2 attached with
// ImageEnView2
var
  ftimage:TIEFtImage;
begin
  ftimage:=ImageEnView1.Proc.FTCreateImage(ieitRGB,-1,-1);
  ImageEnView2.Proc.FTDisplayFrom(ftimage);
  ftimage.free;
end;
!!}
{$ifdef IEINCLUDEFFT}
function TImageEnProc.FTCreateImage(ImageType: TIEFtImageType; NewWidth, NewHeight: integer): TIEFtImage;
var
  newbitmap: TIEBitmap;
begin
  result := nil;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if (NewWidth < 0) and (NewHeight < 0) then
    newbitmap := fIEBitmap
  else
  begin
    if NewWidth < 0 then
      NewWidth := (fIEbitmap.width * NewHeight) div fIEbitmap.Height
    else if NewHeight < 0 then
      NewHeight := (fIEbitmap.Height * NewWidth) div fIEbitmap.Width;
    newbitmap := TIEBitmap.Create;
    newbitmap.Allocate(NewWidth, NewHeight, fIEBitmap.PixelFormat);
    // Resample (you can use _ResampleEx(fIEBitmap,newbitmap,rfFastLinear,nil,nil); )
    _IEBmpStretchEx(fIEBitmap, newbitmap, nil, nil);
  end;
  result := TIEFtImage.Create;
  result.OnProgress := fOnProgress;
  result.BuildFT(newbitmap, ImageType);
  if newbitmap <> fIEBitmap then
    FreeAndNil(newbitmap);
  DoFinishWork;
end;

{$endif}



{!!
<FS>TImageEnProc.FTConvertFrom

<FM>Declaration<FC>
procedure FTConvertFrom(ft:TIEftImage);

<FM>Description<FN>
FTConvertFrom performs an inverse Fourier Transformation of ft (Fourier transformed image).

ft is created by FTCreateImage method.


<FM>Example<FC>

// This example performs the Fourier transformation of image contained in ImageEnView1,
// then an inverse Fourier transformation and store result image to ImageEnView2
// ImageEnView2 should be equal to ImageEnView2
// notes: ImageEnProc1 attached with ImageEnView1 and ImageEnProc2 attached with ImageEnView2
var
  ftimage:TIEFtImage;
begin
  ftimage:=ImageEnView1.Proc.FTCreateImage(ieitRGB,-1,-1);
  ImageEnView2.Proc.FTConvertFrom(ftimage);
  ftimage.free;
end;
!!}
{$ifdef IEINCLUDEFFT}
procedure TImageEnProc.FTConvertFrom(ft: TIEftImage);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  ft.BuildBitmap(fIEBitmap);
  Update;
  DoFinishWork;
end;
{$endif}


{!!
<FS>TImageEnProc.FTDisplayFrom


<FM>Declaration<FC>
procedure FTDisplayFrom(ft:TIEftImage);

<FM>Description<FN>
FTDisplayFrom builds an image that is the "visible" representation of Fourier transformation ft.
ft is created by FTCreateImage method.


<FM>Example<FC>

// this code shows in ImageEnView2 the displayable Fourier transformation 
// of ImageEnView1 image
// notes: ImageEnProc1 attached with ImageEnView1 and ImageEnProc2 attached with ImageEnView2
var
  ftimage:TIEFtImage;
begin
  ftimage:=ImageEnView1.Proc.FTCreateImage(ieitRGB,-1,-1);
  ImageEnView2.Proc.FTDisplayFrom(ftimage);
  ftimage.free;
end;

!!}
{$ifdef IEINCLUDEFFT}
procedure TImageEnProc.FTDisplayFrom(ft: TIEftImage);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  ft.GetFTImage(fIEBitmap);
  Update;
  DoFinishWork;
end;
{$endif}

procedure addPt(var a, b, c: TPoint);
begin
  c.x := a.x + b.x;
  c.y := a.y + b.y;
end;

procedure subPt(var a, b, c: TPoint);
begin
  c.x := a.x - b.x;
  c.y := a.y - b.y;
end;

// Return a closed and non nested polygon from a flood-fill at (x,y)
function _MakeMagicWandPoints(fBitmap: TIEBitmap; x, y: integer; maxfilter: boolean; tolerance: integer; var pcount: integer): PPointArray;
type
  TItem = record
    yy, xl, xr, dy: integer;
  end;
  PItem = ^TItem;
const
  CONTOUR = 3; //'c'
  VISITED = 2; //'v'
  BLACK = 1; //'1'
  WHITE = 0; //'0'
  xcontour_dir: array[0..7] of TPoint = ((x: 1; y: 0), (x: 0; y: - 1), (x: - 1; y: 0), (x: 0; y: 1),
    (x: 1; y: - 1), (x: - 1; y: - 1), (x: - 1; y: 1), (x: 1; y: 1));
  xdirection_code: array[0..7] of byte = (0, 2, 4, 6, 1, 3, 5, 7);
var
  BUFALLOC: integer; // allocation cluster size
  Buffer: TIERecordList;
  dy, sp, start, x1, x2, y1, y2: integer;
  c: integer;
  seed_color: TRGB;
  outbmp: PPRGBArray;
  outbmpptr: pbyte;
  obmp: ppointerarray;
  fbmp: PBYTEROWS;
  fbmpptr:pbyte;
  fdx, fdy: integer;
  fdx1, fdy1: integer;
  j, i, v, u, q, w, row, col: integer;
  enter: boolean;
  rr: pbyte;
  xx1, yy1, xx2, yy2: integer;
  xx, yy: integer;
  dx: integer;
  pix: PRGB;
  flag: boolean;
  bbox: array[0..1] of TPoint;
  pixel, start_pixel, test_pixel: TPoint;
  distance, d, last_dir: integer;
  code: TIEByteArray;
  rs: TIERecordList;
  pv: byte;
  pcode: pbyte;
  bitmapwidth, bitmapheight, opt1, opt2: integer;
  contour_dir: array[0..7] of TPoint;
  direction_code: array[0..7] of byte;
  //
  function _eqpixel: boolean;
  var
    dr, dg, db: integer;
    col: TRGB;
    //pxrgb:PRGB;
  begin
    (*
    if (x >= BitmapWidth) or (y >= BitmapHeight) then
      result := false
    else
    begin
      case fBitmap.PixelFormat of
        ie24RGB:
          begin
            pxrgb := fBitmap.Scanline[y];
            inc(pxrgb, x);
            dr := abs(seed_color.r - pxrgb^.r);
            dg := abs(seed_color.g - pxrgb^.g);
            db := abs(seed_color.b - pxrgb^.b);
          end;
        else
        begin
          col := fBitmap.Pixels[x, y];
          dr := abs(seed_color.r - col.r);
          dg := abs(seed_color.g - col.g);
          db := abs(seed_color.b - col.b);
        end;
      end;
      result := (dr <= tolerance) and (dg <= tolerance) and (db <= tolerance);
    end;
    *)
    if (x >= BitmapWidth) or (y >= BitmapHeight) then
      result := false
    else
    begin
      col := fBitmap.Pixels[x, y];
      dr := abs(seed_color.r - col.r);
      dg := abs(seed_color.g - col.g);
      db := abs(seed_color.b - col.b);
      result := (dr <= tolerance) and (dg <= tolerance) and (db <= tolerance);
    end;
  end;
  //
begin
  for j := 0 to high(xcontour_dir) do
    contour_dir[j] := xcontour_dir[j];
  for j := 0 to high(xdirection_code) do
    direction_code[j] := xdirection_code[j];
  pcount := 0;
  bitmapwidth := fbitmap.width;
  bitmapheight := fbitmap.height;
  // Makes a flood fill bitmap (B/W) in outbmp
  if (x < 0) or (x >= BitmapWidth) or (y < 0) or (y >= BitmapHeight) then
    exit;
  BUFALLOC := 2 * fBitmap.Width;
  Buffer := TIERecordList.CreateList(sizeof(TItem));
  Buffer.Count := BUFALLOC;
  // make outbmp and fill with 0
  getmem(outbmp, fbitmap.height * sizeof(pRGB));
  j := (fbitmap.width shr 3 + 1);
  outbmpptr := allocmem( j * bitmapHeight );  // zero filled
  for q := 0 to bitmapHeight - 1 do
  begin
    outbmp[q] := PRGB(outbmpptr);
    inc(outbmpptr, j);
  end;
  //
  seed_color := fBitmap.Pixels[x, y];
  start := 0;
  sp := 0;
  PItem(buffer[sp])^.yy := y;
  PItem(buffer[sp])^.xl := x;
  PItem(buffer[sp])^.xr := x;
  PItem(buffer[sp])^.dy := 1;
  inc(sp);
  PItem(buffer[sp])^.yy := y + 1;
  PItem(buffer[sp])^.xl := x;
  PItem(buffer[sp])^.xr := x;
  PItem(buffer[sp])^.dy := -1;
  inc(sp);
  xx1 := 2147483647;
  yy1 := 2147483647;
  xx2 := 0;
  yy2 := 0;
  while sp > 0 do
  begin
    dec(sp);
    if sp < 0 then
      break;
    if sp > buffer.Count - 1 then
      buffer.Count := buffer.Count + BUFALLOC;
    dy := PItem(buffer[sp])^.dy;
    y := PItem(buffer[sp])^.yy + dy;
    x1 := PItem(buffer[sp])^.xl;
    x2 := PItem(buffer[sp])^.xr;
    x := x1;
    if (y >= 0) and (y < BitmapHeight) then
    begin
      c := _GetPixelBw(pbyte(outbmp[y]), x);
      while (x >= 0) and (x < BitmapWidth) and _eqpixel and (c = 0) do
      begin
        _SetPixelBw(pbyte(outbmp[y]), x, 1);
        if x < xx1 then
          xx1 := x;
        if x > xx2 then
          xx2 := x;
        if y < yy1 then
          yy1 := y;
        if y > yy2 then
          yy2 := y;
        dec(x);
        if x < 0 then
          break;
        c := _GetPixelBw(pbyte(outbmp[y]), x);
      end;
    end;
    if (y < 0) then
      continue;
    if (y >= BitmapHeight) then
      dy := -dy;
    enter := (x >= x1);
    if not enter then
    begin
      start := x + 1;
      if (start < x1) then
      begin
        PItem(buffer[sp])^.yy := y;
        PItem(buffer[sp])^.xl := start;
        PItem(buffer[sp])^.xr := x1 - 1;
        PItem(buffer[sp])^.dy := -dy;
        inc(sp);
        if (sp < 0) then
          break;
        if sp > buffer.Count - 1 then
          buffer.Count := buffer.Count + BUFALLOC;
      end;
      x := x1 + 1;
    end;
    repeat
      if not enter then
      begin
        if (y >= 0) and (y < BitmapHeight) then
        begin
          if x < bitmapwidth then
            c := _GetPixelBw(pbyte(outbmp[y]), x)
          else
            c := 0;
          while (x >= 0) and (x < BitmapWidth) and _eqpixel and (c = 0) do
          begin
            _SetPixelBw(pbyte(outbmp[y]), x, 1);
            if x < xx1 then
              xx1 := x;
            if x > xx2 then
              xx2 := x;
            if y < yy1 then
              yy1 := y;
            if y > yy2 then
              yy2 := y;
            inc(x);
            if x = BitmapWidth then
              break;
            c := _GetPixelBw(pbyte(outbmp[y]), x);
          end;
        end;
        PItem(buffer[sp])^.yy := y;
        PItem(buffer[sp])^.xl := start;
        PItem(buffer[sp])^.xr := x - 1;
        PItem(buffer[sp])^.dy := dy;
        inc(sp);
        if sp < 0 then
          break;
        if sp > buffer.Count - 1 then
          buffer.Count := buffer.Count + BUFALLOC;
        if (x > (x2 + 1)) then
        begin
          PItem(buffer[sp])^.yy := y;
          PItem(buffer[sp])^.xl := x2 + 1;
          PItem(buffer[sp])^.xr := x - 1;
          PItem(buffer[sp])^.dy := -dy;
          inc(sp);
          if sp < 0 then
            break;
          if sp > buffer.Count - 1 then
            buffer.Count := buffer.Count + BUFALLOC;
        end;
      end
      else
        enter := false;
      inc(x);
      if (y >= 0) and (y < BitmapHeight) then
      begin
        if x < bitmapwidth then
          c := _GetPixelBw(pbyte(outbmp[y]), x)
        else
          c := 0;
        if (x2 >= bitmapWidth) then
          x2 := BitmapWidth - 1;
        while (x <= x2) and ((not _eqpixel) or (c = 1)) do
        begin
          inc(x);
          if x = BitmapWidth then
            break;
          c := _GetPixelBw(pbyte(outbmp[y]), x);
        end;
      end;
      start := x;
    until not (x <= x2);
    if sp > buffer.Count - 1 then
      buffer.Count := buffer.Count + BUFALLOC;
  end;
  FreeAndNil(Buffer);
  // apply maximum filter in outbmp (result in obmp)
  dx := xx2 - xx1 + 1;
  dy := yy2 - yy1 + 1;
  getmem(obmp, sizeof(pointer) * dy);
  for q := 0 to dy - 1 do
    obmp[q] := allocmem(dx shr 3 + 1); // zero filled
  yy := 0;
  for row := yy1 to yy2 do
  begin
    y1 := imax(0, yy - 1);
    y2 := imin(dy - 1, yy + 1);
    xx := 0;
    for col := xx1 to xx2 do
    begin
      if _GetPixelBw(pbyte(outbmp[row]), col) <> 0 then
      begin
        if maxfilter then
        begin
          x1 := imax(0, xx - 1);
          x2 := imin(dx - 1, xx + 1);
          for q := y1 to y2 do
            for w := x1 to x2 do
            begin
              _SetPixelBw(obmp[q], w, 1)
            end;
        end
        else
        begin
          _SetPixelBw(obmp[yy], xx, 1)
        end;
      end;
      inc(xx);
    end;
    inc(yy);
  end;
  // free outbmp
  freemem(outbmp[0]);
  freemem(outbmp);
  // resample obmp to 4x4 (result in fbmp)
  fdx := 2 + 4 * dx + 2;
  fdy := 2 + 4 * dy + 2;
  getmem(fbmp, fdy * sizeof(PBYTEROW));
  fbmpptr := allocmem(fdx * fdy); // zero filled (WHITE)
  for q := 0 to fdy - 1 do
  begin
    fbmp[q] := PBYTEROW(fbmpptr);
    inc(fbmpptr, fdx);
  end;
  for j := 0 to dy - 1 do
  begin
    opt1 := 2 + (j shl 2);
    for i := 0 to dx - 1 do
    begin
      if pbytearray(obmp[j])^[i shr 3] and iebitmask1[i and $7] <> 0 then
      begin
        opt2 := 2 + (i shl 2);
        for v := 0 to 3 do
          for u := 0 to 3 do
            fbmp[opt1 + v][opt2 + u] := BLACK;
      end;
    end;
  end;
  // free obmp
  for q := 0 to dy - 1 do
    freemem(obmp[q]);
  freemem(obmp);

  fdx1 := fdx-1;
  fdy1 := fdy-1;

  // PASS 1: LEFTWARDS
  flag := false;
  for j := 0 to fdy1 do
  begin
    fbmpptr := pbyte(fbmp[j]); inc(fbmpptr);
    for i := 1 to fdx1 do
    begin
      if fbmpptr^ = BLACK then
      begin
        if not flag then
        begin
          fbmp[j, i - 1] := CONTOUR;
          flag := true;
        end;
      end
      else
        flag := false;
      inc(fbmpptr);
    end;
  end;
  // PASS 2: RIGHTWARDS
  for j := 0 to fdy1 do
    for i := fdx1 downto 0 do
      if (fbmp[j, i] = BLACK) then
      begin
        if not flag then
        begin
          fbmp[j, i + 1] := CONTOUR;
          flag := true;
        end;
      end
      else
        flag := false;
  // PASS 3: DOWNWARDS
  flag := false;
  for i := 0 to fdx1 do
    for j := 0 to fdy1 do
      if (fbmp[j, i] = BLACK) then
      begin
        if not flag then
        begin
          fbmp[j - 1, i] := CONTOUR;
          flag := true;
        end;
      end
      else
        flag := false;
  // PASS 4: UPWARDS
  flag := false;
  for i := 0 to fdx1 do
    for j := fdy1 downto 0 do
      if (fbmp[j, i] = BLACK) then
      begin
        if not flag then
        begin
          fbmp[j + 1, i] := CONTOUR;
          flag := true;
        end;
      end
      else
        flag := false;
  //
  (*
  bbox[0] := point(2147483647, 2147483647);
  bbox[1] := point(0, 0);
  for j := 0 to fdy1 do
    for i := 1 to fdx1 do
      if fbmp[j, i] = CONTOUR then
      begin
        if i < bbox[0].x then bbox[0].x := i;
        if j < bbox[0].y then bbox[0].y := j;
        if i > bbox[1].x then bbox[1].x := i;
        if j > bbox[1].y then bbox[1].y := j;
      end;
      *)
  bbox[0] := point(2147483647, 2147483647);
  bbox[1] := point(0, 0);
  for j := 0 to fdy1 do
  begin
    fbmpptr := pbyte(fbmp[j]); inc(fbmpptr);
    for i := 1 to fdx1 do
    begin
      if fbmpptr^ = CONTOUR then
      begin
        if i < bbox[0].x then bbox[0].x := i;
        if j < bbox[0].y then bbox[0].y := j;
        if i > bbox[1].x then bbox[1].x := i;
        if j > bbox[1].y then bbox[1].y := j;
      end;
      inc(fbmpptr);
    end;
  end;
  //
  distance := 2147483647;
  for j := 0 to fdy1 do
    for i := 1 to fdx1 do
      if (fbmp[j, i] = CONTOUR) then
      begin
        d := (i - bbox[0].x) * (i - bbox[0].x) + (j - bbox[0].y) * (j - bbox[0].y);
        if (d < distance) then
        begin
          distance := d;
          start_pixel.x := i;
          start_pixel.y := j;
        end;
      end;
  //
  code := TIEByteArray.Create;
  pixel.x := start_pixel.x;
  pixel.y := start_pixel.y;
  fbmp[pixel.y, pixel.x] := VISITED;
  last_dir := 4;
  while true do
  begin
    addPt(pixel, contour_dir[last_dir], test_pixel);
    if (fbmp[test_pixel.y, test_pixel.x] = CONTOUR) then
    begin
      pixel.x := test_pixel.x;
      pixel.y := test_pixel.y;
      fbmp[pixel.y, pixel.x] := VISITED;
      code.AddByte(direction_code[last_dir]);
    end;
    i:=0;
    while i<8 do
    begin
      addPt(pixel, contour_dir[i], test_pixel);
      if (fbmp[test_pixel.y, test_pixel.x] = CONTOUR) then
      begin
        pixel.x := test_pixel.x;
        pixel.y := test_pixel.y;
        fbmp[pixel.y, pixel.x] := VISITED;
        code.AddByte(direction_code[i]);
        last_dir := i;
        break;
      end;
      inc(i);
    end;
    if (i = 8) then
      break;
  end;
  for i := 0 to 7 do
  begin
    subPt(start_pixel, pixel, test_pixel);
    if (test_pixel.x = contour_dir[i].x) and (test_pixel.y = contour_dir[i].y) then
    begin
      code.AddByte(direction_code[i]);
      break;
    end;
  end;
  // free fbmp
  freemem(fbmp[0]);
  freemem(fbmp);
  //
  pixel.x := (start_pixel.x - 1) + xx1 * 4;
  pixel.y := (start_pixel.y - 1) + yy1 * 4;
  rs := TIERecordList.CreateList(sizeof(TPoint));
  rs.Add(@pixel);
  pcode := pbyte(code.Data);
  pv := pcode^;
  for q := 0 to code.Size - 1 do
  begin
    if pv <> pcode^ then
    begin
      rs.add(@pixel);
      pv := pcode^;
    end;
    case pcode^ of
      0: // right
        inc(pixel.x);
      2: // up
        dec(pixel.y);
      4: // left
        dec(pixel.x);
      6: // down
        inc(pixel.y);
      1:
        begin
          // up-right
          dec(pixel.y);
          inc(pixel.x);
        end;
      3:
        begin
          // up-left
          dec(pixel.y);
          dec(pixel.x);
        end;
      5:
        begin
          // down-left
          inc(pixel.y);
          dec(pixel.x);
        end;
      7:
        begin
          // down-right
          inc(pixel.y);
          inc(pixel.x);
        end;
    end;
    inc(pcode);
  end;
  FreeAndNil(code);
  for q := 0 to rs.count - 1 do
  begin
    with ppoint(rs[q])^ do
    begin
      x := x shr 2;
      y := y shr 2;
    end;
  end;
  //
  pcount := rs.Count;
  if pcount > 0 then
  begin
    getmem(result, sizeof(TPoint) * pcount);
    copymemory(result, rs.Items[0], sizeof(TPoint) * pcount);
  end;
  FreeAndNil(rs);
end;

// Make a mask with a flood-fill at (x,y)
procedure _MakeMagicWandPointsEx(fBitmap: TIEBitmap; x, y: integer; maxfilter: boolean; tolerance: integer; mask: TIEMask; selintensity:integer);
type
  TItem = record
    yy, xl, xr, dy: integer;
  end;
  PItem = ^TItem;
var
  BUFALLOC: integer; // allocation cluster size
  Buffer: TIERecordList;
  dy, sp, start, x1, x2, y1, y2: integer;
  c: integer;
  seed_color: TRGB;
  outbmp: pPRGBArray;
  j, i, v, u, q, w, row, col: integer;
  enter: boolean;
  xx1, yy1, xx2, yy2: integer;
  bitmapwidth, bitmapheight, opt1, opt2: integer;
  //
  function _eqpixel: boolean;
  var
    dr, dg, db: integer;
    col: TRGB;
  begin
    if (x >= BitmapWidth) or (y >= BitmapHeight) then
      result := false
    else
    begin
      col := fBitmap.Pixels[x, y];
      dr := abs(seed_color.r - col.r);
      dg := abs(seed_color.g - col.g);
      db := abs(seed_color.b - col.b);
      result := (dr <= tolerance) and (dg <= tolerance) and (db <= tolerance);
    end;
  end;
  //
begin
  bitmapwidth := fbitmap.width;
  bitmapheight := fbitmap.height;
  // Makes a flood fill bitmap (B/W) in outbmp
  if (x < 0) or (x >= BitmapWidth) or (y < 0) or (y >= BitmapHeight) then
    exit;
  BUFALLOC := 2 * fBitmap.Width;
  Buffer := TIERecordList.CreateList(sizeof(TItem));
  Buffer.Count := BUFALLOC;
  // make outbmp and fills with 0
  getmem(outbmp, fbitmap.height * sizeof(pRGB));
  for q := 0 to bitmapHeight - 1 do
    outbmp[q] := allocmem(fbitmap.width shr 3 + 1); // zero filled
  //
    //seed_color:=PRGBROW(fBitmap.Scanline[y])[x];
  seed_color := fBitmap.Pixels[x, y];
  //col2 := pbytearray(@seed_color);
  start := 0;
  sp := 0;
  PItem(buffer[sp])^.yy := y;
  PItem(buffer[sp])^.xl := x;
  PItem(buffer[sp])^.xr := x;
  PItem(buffer[sp])^.dy := 1;
  inc(sp);
  PItem(buffer[sp])^.yy := y + 1;
  PItem(buffer[sp])^.xl := x;
  PItem(buffer[sp])^.xr := x;
  PItem(buffer[sp])^.dy := -1;
  inc(sp);
  xx1 := 2147483647;
  yy1 := 2147483647;
  xx2 := 0;
  yy2 := 0;
  while sp > 0 do
  begin
    dec(sp);
    if sp < 0 then
      break;
    if sp > buffer.Count - 1 then
      buffer.Count := buffer.Count + BUFALLOC;
    dy := PItem(buffer[sp])^.dy;
    y := PItem(buffer[sp])^.yy + dy;
    x1 := PItem(buffer[sp])^.xl;
    x2 := PItem(buffer[sp])^.xr;
    x := x1;
    if (y >= 0) and (y < BitmapHeight) then
    begin
      c := _GetPixelBw(pbyte(outbmp[y]), x);
      while (x >= 0) and (x < BitmapWidth) and _eqpixel and (c = 0) do
      begin
        _SetPixelBw(pbyte(outbmp[y]), x, 1);
        if x < xx1 then
          xx1 := x;
        if x > xx2 then
          xx2 := x;
        if y < yy1 then
          yy1 := y;
        if y > yy2 then
          yy2 := y;
        dec(x);
        if x < 0 then
          break;
        c := _GetPixelBw(pbyte(outbmp[y]), x);
      end;
    end;
    if (y < 0) then
      continue;
    if (y >= BitmapHeight) then
      dy := -dy;
    enter := (x >= x1);
    if not enter then
    begin
      start := x + 1;
      if (start < x1) then
      begin
        PItem(buffer[sp])^.yy := y;
        PItem(buffer[sp])^.xl := start;
        PItem(buffer[sp])^.xr := x1 - 1;
        PItem(buffer[sp])^.dy := -dy;
        inc(sp);
        if (sp < 0) then
          break;
        if sp > buffer.Count - 1 then
          buffer.Count := buffer.Count + BUFALLOC;
      end;
      x := x1 + 1;
    end;
    repeat
      if not enter then
      begin
        if (y >= 0) and (y < BitmapHeight) then
        begin
          if x < bitmapwidth then
            c := _GetPixelBw(pbyte(outbmp[y]), x)
          else
            c := 0;
          while (x >= 0) and (x < BitmapWidth) and _eqpixel and (c = 0) do
          begin
            _SetPixelBw(pbyte(outbmp[y]), x, 1);
            if x < xx1 then
              xx1 := x;
            if x > xx2 then
              xx2 := x;
            if y < yy1 then
              yy1 := y;
            if y > yy2 then
              yy2 := y;
            inc(x);
            if x = BitmapWidth then
              break;
            c := _GetPixelBw(pbyte(outbmp[y]), x);
          end;
        end;
        PItem(buffer[sp])^.yy := y;
        PItem(buffer[sp])^.xl := start;
        PItem(buffer[sp])^.xr := x - 1;
        PItem(buffer[sp])^.dy := dy;
        inc(sp);
        if sp < 0 then
          break;
        if sp > buffer.Count - 1 then
          buffer.Count := buffer.Count + BUFALLOC;
        if (x > (x2 + 1)) then
        begin
          PItem(buffer[sp])^.yy := y;
          PItem(buffer[sp])^.xl := x2 + 1;
          PItem(buffer[sp])^.xr := x - 1;
          PItem(buffer[sp])^.dy := -dy;
          inc(sp);
          if sp < 0 then
            break;
          if sp > buffer.Count - 1 then
            buffer.Count := buffer.Count + BUFALLOC;
        end;
      end
      else
        enter := false;
      inc(x);
      if (y >= 0) and (y < BitmapHeight) then
      begin
        if x < bitmapwidth then
          c := _GetPixelBw(pbyte(outbmp[y]), x)
        else
          c := 0;
        if (x2 >= bitmapWidth) then
          x2 := BitmapWidth - 1;
        while (x <= x2) and ((not _eqpixel) or (c = 1)) do
        begin
          inc(x);
          if x = BitmapWidth then
            break;
          c := _GetPixelBw(pbyte(outbmp[y]), x);
        end;
      end;
      start := x;
    until not (x <= x2);
    if sp > buffer.Count - 1 then
      buffer.Count := buffer.Count + BUFALLOC;
  end;
  FreeAndNil(Buffer);
  // apply maximum filter in outbmp (result in obmp)
  for row := yy1 to yy2 do
  begin
    y1 := imax(0, row - 1);
    y2 := imin(bitmapheight - 1, row + 1);
    for col := xx1 to xx2 do
    begin
      if _GetPixelBw(pbyte(outbmp[row]), col) <> 0 then
      begin
        if maxfilter then
        begin
          x1 := imax(0, col - 1);
          x2 := imin(bitmapwidth - 1, col + 1);
          for q := y1 to y2 do
            for w := x1 to x2 do
            begin
              mask.SetPixel(w, q, selintensity);
            end;
        end
        else
        begin
          mask.SetPixel(col, row, selintensity)
        end;
      end;
    end;
  end;
  // free outbmp
  for q := 0 to bitmapHeight - 1 do
    freemem(outbmp[q]);
  freemem(outbmp);
end;

// create a mask with all colors like (x,y)
// works only with pf24bit images
procedure _MakeMagicWandPointsEx2(fBitmap: TIEBitmap; x, y: integer; tolerance: integer; mask: TIEMask; selintensity:integer);
var
  row, col: integer;
  rowhi, colhi: integer;
  seed_color: TRGB;
  dr, dg, db: integer;
  v: TRGB;
begin
  rowhi := fBitmap.Height - 1;
  colhi := fBitmap.Width - 1;
  seed_color := fBitmap.Pixels[x, y];
  for row := 0 to rowhi do
  begin
    for col := 0 to colhi do
    begin
      v := fBitmap.Pixels[col, row];
      dr := abs(seed_color.r - v.r);
      dg := abs(seed_color.g - v.g);
      db := abs(seed_color.b - v.b);
      if (dr <= tolerance) and (dg <= tolerance) and (db <= tolerance) then
        mask.SetPixel(col, row, selintensity);
    end;
  end;
end;

// Stretch origBmp to width,height of destBmp
// Use DrawDib api functions

procedure _IEBmpStretch(origBmp, destBmp: TBitmap);
var
  hdb: HDRAWDIB;
  BitmapInfoHeader256: ^TBitmapInfoHeader256;
begin
  destBmp.PixelFormat := origBmp.PixelFormat;
  new(BitmapInfoHeader256);
  ZeroMemory(BitmapInfoHeader256, sizeof(TBitmapInfoHeader256));
  with BitmapInfoHeader256^ do
  begin
    biSize := sizeof(TBitmapInfoHeader);
    biWidth := origBmp.Width;
    biHeight := origBmp.Height;
    biPlanes := 1;
    if origBmp.pixelformat = pf1bit then
    begin
      biBitCount := 1;
      Palette[1].rgbRed := 255;
      Palette[1].rgbGreen := 255;
      Palette[1].rgbBlue := 255;
    end
    else
      biBitCount := 24;
    biCompression := BI_RGB;
  end;
  hdb := IEDrawDibOpen;
  if destBmp.PixelFormat = pf1bit then
    destBmp.HandleType := bmDDB;
  IEDrawDibDraw(hdb, destBmp.canvas.handle, 0, 0, destBmp.Width, destBmp.Height, PBitmapInfoHeader(BitmapInfoHeader256)^, origBmp.ScanLine[origBmp.height - 1],
    0, 0, origBmp.Width, origBmp.Height, 0);
  if destBmp.HandleType = bmDDB then
    destBmp.HandleType := bmDIB;
  IEDrawDibClose(hdb);
  dispose(BitmapInfoHeader256);
end;

// origBmp.PixelFormat must be = detBmp.PixelFormat
procedure _IEBmpStretchEx(origBmp, destBmp: TIEBaseBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y, sx: integer;
  zx, zy: double;
  sxarr: pintegerarray;
  d_rgb: PRGB;
  s_rgb: PRGBROW;
  d_rgb32: PRGBA;
  s_rgb32: PRGB32ROW;
  d_rgb48: PRGB48;
  s_rgb48: PRGB48ROW;
  d_cmyk: PCMYK;
  s_cmyk: PCMYKROW;
  d_cielab: PCIELAB;
  s_cielab: PCIELABROW;
  d_g, s_g, bp: pbyte;
  s_ga: pbytearray;
  d_w: pword;
  s_wa: pwordarray;
  d_f: psingle;
  s_fa: psinglearray;
  l1, l2: TIEDataAccess;
  per1: double;
  lper:integer;
begin
  lper:=-1;
  per1 := 100 / (destBmp.Height + 0.5);
  l1 := origBmp.Access;
  l2 := destBmp.Access;
  origBmp.Access := [iedRead];
  destBmp.Access := [iedWrite];
  zx := origBmp.Width / destBmp.Width;
  zy := origBmp.Height / destBmp.Height;
  getmem(sxarr, sizeof(integer) * destBmp.Width);
  for x := 0 to destBmp.Width - 1 do
    sxarr[x] := trunc(x * zx);
  case origBmp.PixelFormat of
    ie1g:
      for y := 0 to destBmp.Height - 1 do
      begin
        s_g := origBmp.Scanline[trunc(y * zy)];
        d_g := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          sx := sxarr[x];
          bp := pbyte(int64(DWORD(d_g)) + (int64(x) shr 3));
          if (pbytearray(s_g)^[sx shr 3] and iebitmask1[sx and $7]) <> 0 then
            bp^ := bp^ or iebitmask1[x and 7]
          else
            bp^ := bp^ and not iebitmask1[x and 7];
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
    ie8p, ie8g:
      begin
        for y := 0 to destBmp.Height - 1 do
        begin
          s_ga := origBmp.Scanline[trunc(y * zy)];
          d_g := destBmp.Scanline[y];
          for x := 0 to destBmp.Width - 1 do
          begin
            d_g^ := s_ga[sxarr[x]];
            inc(d_g);
          end;
          if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
          begin
            lper:=trunc(per1 * y);
            fOnProgress(Sender, lper);
          end;
        end;
        if origBmp.PixelFormat=ie8p then
          origBmp.CopyPaletteTo(destBmp);
      end;
    ie16g:
      // to optimize
      for y := 0 to destBmp.Height - 1 do
      begin
        s_wa := origBmp.Scanline[trunc(y * zy)];
        d_w := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          d_w^ := s_wa[sxarr[x]];
          inc(d_w);
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
    ie24RGB:
      for y := 0 to destBmp.Height - 1 do
      begin
        s_rgb := origBmp.Scanline[trunc(y * zy)];
        d_rgb := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          d_rgb^ := s_rgb[sxarr[x]];
          inc(d_rgb);
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
    ie32RGB:
      for y := 0 to destBmp.Height - 1 do
      begin
        s_rgb32 := origBmp.Scanline[trunc(y * zy)];
        d_rgb32 := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          d_rgb32^ := s_rgb32[sxarr[x]];
          inc(d_rgb32);
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
    ie32f:
      // to optimize
      for y := 0 to destBmp.Height - 1 do
      begin
        s_fa := origBmp.Scanline[trunc(y * zy)];
        d_f := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          d_f^ := s_fa[sxarr[x]];
          inc(d_f);
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
    ieCMYK:
      for y := 0 to destBmp.Height - 1 do
      begin
        s_cmyk := origBmp.Scanline[trunc(y * zy)];
        d_cmyk := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          d_cmyk^ := s_cmyk[sxarr[x]];
          inc(d_cmyk);
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
    ieCIELab:
      for y := 0 to destBmp.Height - 1 do
      begin
        s_cielab := origBmp.Scanline[trunc(y * zy)];
        d_cielab := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          d_cielab^ := s_cielab[sxarr[x]];
          inc(d_cielab);
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
    ie48RGB:
      for y := 0 to destBmp.Height - 1 do
      begin
        s_rgb48 := origBmp.Scanline[trunc(y * zy)];
        d_rgb48 := destBmp.Scanline[y];
        for x := 0 to destBmp.Width - 1 do
        begin
          d_rgb48^ := s_rgb48[sxarr[x]];
          inc(d_rgb48);
        end;
        if assigned(fOnProgress) and (trunc(per1 * y)<>lper) then
        begin
          lper:=trunc(per1 * y);
          fOnProgress(Sender, lper);
        end;
      end;
  end;
  freemem(sxarr);
  origBmp.Access := l1;
  destBmp.Access := l2;
end;

// Converts a row from a bit format to an other
// Allowed combinations:
//    "Xbits_to_Ybits"
//    1_to_1
//    1_to_4
//    1_to_8
//    1_to_24 (palette[2] required)
//    4_to_4
//    4_to_8
//    4_to_24 (palette[16] required)
//    8_to_1 (each byte in input must be 0 or 1. Compact input to output)
//    8_to_8
//    8_to_24 (palette[256] required)
//   	24_to_4 (Quantizer required)
//    24_to_8 (Quantizer required)
//    24_to_24
//    32_to_24 (remove alpha channel)
// true color are in BGR (or BGRA)
// returns the byte width of Output

function _ConvertXBitsToYBits(var Input, Output: TBYTEROW; Xbits, Ybits, Width: Word; Palette: array of TRGB; Quantizer: TObject): integer;
var
  X, Z, i: integer;
  B1: Byte;
  Q: TIEQuantizer;
begin
  Q := TIEQuantizer(Quantizer);
  case Xbits of
    1: // from 1 bit...
      case Ybits of
        1: // ...to 1 bit
          copymemory(@Output[0], @Input[0], (Width + 7) div 8);
        4: // ...to 4 bit
          for X := 0 to Width - 1 do
          begin
            B1 := (Input[X shr 3] shr (7 - (X mod 8))) and 1;
            OutPut[X shr 1] := OutPut[X shr 1] or (B1 shl ((1 - (X mod 2)) * 4));
          end;
        8: // ...to 8 bit
          for X := 0 to Width - 1 do
          begin
            B1 := (Input[X shr 3] shr (7 - (X mod 8))) and 1;
            OutPut[X] := B1;
          end;
        24: // ...to 8*3 bit
          begin
            Z := 0;
            for X := 0 to Width - 1 do
            begin
              B1 := (Input[X shr 3] shr (7 - (X mod 8))) and 1;
              OutPut[Z + 0] := Palette[B1].b;
              OutPut[Z + 1] := Palette[B1].g;
              OutPut[Z + 2] := Palette[B1].r;
              inc(Z, 3);
            end;
          end;
      end;
    4: // from 4 bit to...
      case Ybits of
        4: // ...to 4 bit
          CopyMemory(@Output[0], @Input[0], (Width + 1) div 2);
        8: // ...to 8 bit
          for X := 0 to Width - 1 do
          begin
            B1 := (Input[X shr 1] shr ((1 - (X mod 2)) * 4)) and $0F;
            OutPut[X] := B1;
          end;
        24: // ...to 24 bit
          begin
            Z := 0;
            for X := 0 to Width - 1 do
            begin
              B1 := (Input[X shr 1] shr ((1 - (X mod 2)) * 4)) and $0F;
              OutPut[Z + 0] := Palette[B1].b;
              OutPut[Z + 1] := Palette[B1].g;
              OutPut[Z + 2] := Palette[B1].r;
              inc(Z, 3);
            end;
          end;
      end;
    8: // from 8 bit to...
      case Ybits of
        1: // ...to 1 bit (compact 8 bit to 1 bit)
          begin
            zeromemory(@Output[0], (Width + 7) div 8);
            for X := 0 to Width - 1 do
            begin
              B1 := InPut[X];
              OutPut[X shr 3] := OutPut[X shr 3] or (B1 shl (7 - (X mod 8)));
            end;
          end;
        8: // ...to 8 bit
          CopyMemory(@Output[0], @Input[0], Width);
        24: // ...to 24 bit
          begin
            Z := 0;
            for X := 0 to Width - 1 do
            begin
              B1 := Input[X];
              OutPut[Z + 0] := Palette[B1].b;
              OutPut[Z + 1] := Palette[B1].g;
              OutPut[Z + 2] := Palette[B1].r;
              inc(Z, 3);
            end;
          end;
      end;
    24: // from 24 bit...
      case Ybits of
        4: // ...to 4 bit
          begin
            Z := 0;
            for X := 0 to Width - 1 do
            begin
              B1 := Q.RGBIndex[CreateRGB(Input[Z + 2], Input[Z + 1], Input[Z])];
              OutPut[X shr 1] := OutPut[X shr 1] or (B1 shl ((1 - (X mod 2)) * 4));
              inc(Z, 3);
            end;
          end;
        8: // ...to 8 bit
          begin
            Z := 0;
            for X := 0 to Width - 1 do
            begin
              Output[X] := Q.RGBIndex[CreateRGB(Input[Z + 2], Input[Z + 1], Input[Z])];
              inc(Z, 3);
            end;
          end;
        24: // ...to 24 bit
          CopyMemory(@Output[0], @Input[0], Width * 3);
      end;
    32: // from 32 bit...
      case Ybits of
        24: //...to 24 bit (bypass alpha channel)
          begin
            X := 0;
            Z := 0;
            for i := 0 to Width - 1 do
            begin
              Output[X] := Input[Z];
              Output[X + 1] := Input[Z + 1];
              Output[X + 2] := Input[Z + 2];
              inc(X, 3);
              inc(Z, 4);
            end;
          end;
      end;
  end;
  case Ybits of
    1: result := (Width + 7) div 8;
    4: result := (Width + 1) div 2;
    8: result := Width;
    24: result := Width * 3;
  else
    result := 0;
  end;
end;

// Copy Source in Dest, inside area delimited by SelPoly
// x1,y1 up-left polygon limit

procedure _CopyPolygonBitmap(Dest: TBitmap; Source: TBitmap; x1, y1: integer; SelPoly: PPointArray; SelPolyCount: integer);
var
  hrgn: THandle;
  p1, p2, q: integer;
begin
  p1 := 0;
  for q := 0 to SelPolyCount do
    if (q = SelPolyCount) or (SelPoly^[q].x = IESELBREAK) then
    begin
      p2 := q - p1;
      hrgn := CreatePolygonRgn(SelPoly^[p1], p2, ALTERNATE);
      SelectClipRgn(Dest.Canvas.Handle, hrgn);
      SetPolyFillMode(Dest.Canvas.Handle, ALTERNATE);
      Dest.Canvas.Draw(x1, y1, Source);
      SelectClipRgn(Dest.Canvas.Handle, 0);
      DeleteObject(hrgn);
      p1 := q + 1;
    end;
end;

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// TIETransitionEffects

//

constructor TIETransitionEffects.Create(Owner: TIEView);
begin
  inherited Create;
  //
  fOwner := Owner;
  fSourceShot := TBitmap.Create;
  fSourceShot.Width := 1;
  fSourceShot.Height := 1;
  fSourceShot.PixelFormat := pf24bit;
  fTargetShot := TBitmap.Create;
  fTargetShot.Width := 1;
  fTargetShot.Height := 1;
  fTargetShot.PixelFormat := pf24bit;
  fCurrentView := TBitmap.Create;
  fCurrentView.Width := 1;
  fCurrentView.Height := 1;
  fCurrentView.PixelFormat := pf24bit;
  fRunning := false;
  fTransition := iettNone;
  fDuration := 1000;
  fSourceShotLines := nil;
  fTargetShotLines := nil;
  fCurrentViewLines := nil;
  fUpdateOnStop := false;
  fTimer := TTimer.Create(fOwner);
  fTimer.Enabled := false;
  fTimer.OnTimer := TimerEvent;
  fTimer.Interval := 1;
  fFullImage:=nil;
  fOnTransitionStop:=nil;
  fOnTransitionStep:=nil;
  fTiming:=iettLinear;
end;

destructor TIETransitionEffects.Destroy;
begin
  if fSourceShotLines <> nil then
    freemem(fSourceShotLines);
  if fTargetShotLines <> nil then
    freemem(fTargetShotLines);
  if fCurrentViewLines <> nil then
    freemem(fCurrentViewLines);
  fSourceShotLines := nil;
  fTargetShotLines := nil;
  fCurrentViewLines := nil;
  FreeAndNil(fTimer);
  FreeAndNil(fSourceShot);
  FreeAndNil(fTargetShot);
  FreeAndNil(fCurrentView);
  //
  inherited;
end;

procedure TIETransitionEffects.SetOnTransitionPaint(const Value: TIEOnTransitionPaint);
begin
  fOnTransitionPaint := Value;
end;

procedure TIETransitionEffects.SetSizes(Width, Height: integer);
begin
  Stop;
  fWidth := Width;
  fHeight := Height;
  fCurrentView.Width := fWidth;
  fCurrentView.Height := fHeight;
  fSourceShot.Width := fWidth;
  fSourceShot.Height := fHeight;
  fTargetShot.Width := fWidth;
  fTargetShot.Height := fHeight;
end;

procedure TIETransitionEffects.Run(UpdateOnStop: boolean);
var
  q: integer;
begin
  if fTransition = iettNone then
    exit;
  if fRunning then
    fOwner.NPUnLockPaint;
  fUpdateOnStop := UpdateOnStop;
  fRunning := true;
  fStep := 0;
  fAccum1 := 0;
  fFrames := 0;
  if ((fWidth < 2) and (fHeight < 2)) or (fHeight<>fSourceShot.Height) then
  begin
    fRunning := false;
    exit;
  end;
  fOwner.LockPaint;
  if fSourceShotLines <> nil then
    freemem(fSourceShotLines);
  if fTargetShotLines <> nil then
    freemem(fTargetShotLines);
  if fCurrentViewLines <> nil then
    freemem(fCurrentViewLines);
  getmem(fSourceShotLines, sizeof(pointer) * fHeight);
  getmem(fTargetShotLines, sizeof(pointer) * fHeight);
  getmem(fCurrentViewLines, sizeof(pointer) * fHeight);
  for q := 0 to fHeight - 1 do
  begin
    fSourceShotLines[q] := fSourceShot.Scanline[q];
    fTargetShotLines[q] := fTargetShot.Scanline[q];
    fCurrentViewLines[q] := fCurrentView.scanline[q];
  end;
  fStartTick := GetTickCount;
  fTimer.Enabled := true;
end;

procedure TIETransitionEffects.PrepareBitmap(OriginalBitmap,TargetBitmap:TBitmap);
var
	q:integer;
begin
	if fTransition=iettNone then
   	exit;
	fRunning:=true;
  fStep:=0;
  fAccum1:=0;
  fFrames:=0;

  SetSizes(OriginalBitmap.Width,OriginalBitmap.Height);

  fSourceShot.assign(OriginalBitmap);
  fCurrentView.assign(OriginalBitmap);
  fTargetShot.assign(TargetBitmap);

  if ((fWidth<2) and (fHeight<2)) or (fHeight<>fSourceShot.Height) then
  begin
    fRunning:=false;
    exit;
  end;

	if fSourceShotLines<>nil then
    freemem(fSourceShotLines);
  if fTargetShotLines<>nil then
    freemem(fTargetShotLines);
  if fCurrentViewLines<>nil then
    freemem(fCurrentViewLines);
  getmem(fSourceShotLines,sizeof(pointer)*fHeight);
  getmem(fTargetShotLines,sizeof(pointer)*fHeight);
  getmem(fCurrentViewLines,sizeof(pointer)*fHeight);
	for q:=0 to fHeight-1 do begin
    fSourceShotLines[q]:=fSourceShot.Scanline[q];
    fTargetShotLines[q]:=fTargetShot.Scanline[q];
    fCurrentViewLines[q]:=fCurrentView.scanline[q];
  end;
end;

procedure TIETransitionEffects.Stop;
begin
  if not fRunning then
    exit;
  if fTransition = iettNone then
    exit;
  fTimer.Enabled := false;
  fRunning := false;
  fCurrentView.Width := 1;
  fCurrentView.Height := 1;
  fSourceShot.Width := 1;
  fSourceShot.Height := 1;
  fTargetShot.Width := 1;
  fTargetShot.Height := 1;
  fOwner.NPUnLockPaint;
  if fUpdateOnStop then
    fOwner.Update;
  if assigned(fOnTransitionStop) then
    fOnTransitionStop(fOwner);
end;

procedure TIETransitionEffects.TimerEvent(Sender: TObject);

  {$ifdef IEINCLUDEEXTRATRANSITIONS}
  procedure XtraTransitions(iStyle:Integer; iStep:Integer);
  begin
    if FStep=0 then
      fCurrentView.assign(fSourceShot)
    else
    if Assigned(IETransitionList[iStyle].proc) then
    begin
      SetStretchBltMode(fCurrentView.Canvas.Handle, HALFTONE);
      IETransitionList[iStyle].Proc(fCurrentView.Canvas,
                                    fSourceShot,
                                    fTargetShot,
                                    Rect(0,0,fCurrentView.Width,fCurrentView.Height),
                                    1,
                                    Round(iStep/1024*100) );
    end;
  end;
  {$endif}
var
  elap: dword;
begin
  if not fRunning then
    exit;
  if assigned(fOnTransitionStep) then
    fOnTransitionStep(fOwner,fStep);
  inc(fFrames);
  // make transition
  case fTransition of
    iettCrossDissolve:
      CrossDissolve(fStep);
    iettFadeOut:
      FadeOut(fStep);
    iettFadeIn:
      FadeIn(fStep);
    iettFadeOutIn:
      FadeOutIn(fStep);
    iettLeftRight1:
      LeftRight1(fStep);
    iettLeftRight2:
      LeftRight2(fStep);
    iettRightLeft1:
      RightLeft1(fStep);
    iettRightLeft2:
      RightLeft2(fStep);
    iettUpDown1:
      UpDown1(fStep);
    iettUpDown2:
      UpDown2(fStep);
    iettDownUp1:
      DownUp1(fStep);
    iettDownUp2:
      DownUp2(fStep);
    iettMoveLeftRight1:
      MoveLeftRight1(fStep);
    iettMoveLeftRight2:
      MoveLeftRight2(fStep);
    iettMoveRightLeft1:
      MoveRightLeft1(fStep);
    iettMoveRightLeft2:
      MoveRightLeft2(fStep);
    iettMoveUpDown1:
      MoveUpDown1(fStep);
    iettMoveUpDown2:
      MoveUpDown2(fStep);
    iettMoveDownUp1:
      MoveDownUp1(fStep);
    iettMoveDownUp2:
      MoveDownUp2(fStep);
    iettRandomPoints:
      RandomPoints(fStep);
    iettFromUpLeft:
      FromUpLeft(fStep);
    iettFromUpRight:
      FromUpRight(fStep);
    iettFromBottomLeft:
      FromBottomLeft(fStep);
    iettFromBottomRight:
      FromBottomRight(fStep);
    iettRandomBoxes:
      RandomBoxes(fStep);
    iettCenter1:
      Center1(fStep);
    iettCenter2:
      Center2(fStep);
    iettCenterZoom1:
      CenterZoom1(fStep);
    iettCenterZoom2:
      CenterZoom2(fStep);
    iettPanZoom:
      PanZoom(fStep);
    {$ifdef IEINCLUDEEXTRATRANSITIONS}
    else
      XtraTransitions(Integer(fTransition),FStep);
    {$endif}
  end;
  // paint result
  BitBlt(fOwner.GetCanvas.handle, 0, 0, fWidth, fHeight, fCurrentView.Canvas.Handle, 0, 0, SRCCOPY);
  if Assigned(FOnTransitionPaint) then
    fOnTransitionPaint(fOwner, FCurrentView, Self, fStep);
  //
  elap := GetTickCount - fStartTick;
  if elap >= dword(fDuration) then
  begin
    if FUpdateOnStop and (fTransition<>iettPanZoom) then
    begin
      BitBlt(fOwner.GetCanvas.handle, 0, 0, fWidth, fHeight, fTargetShot.Canvas.Handle, 0, 0, SRCCOPY);
      if Assigned(FOnTransitionPaint) then
        fOnTransitionPaint(fOwner, fTargetShot, Self, 1024);
    end;
    Stop;
  end;

  case fTiming of
    iettLinear: fStep := trunc((elap / fDuration) * 1024);  // linear
    iettExponential: fStep := trunc( exp((elap/fDuration)*5-2.718)/10 * 1024); // exponential
    iettLogarithmic: fStep := trunc( (ln((elap/fDuration)*10)+2.718)/5 * 1024 );  // logarithmic
  end;

  if fStep > 1024 then
    fStep := 1024;
end;

procedure TIETransitionEffects.CreateBitmapFrame(iStep:Integer; ToBitmap:TBitmap);
  {$ifdef IEINCLUDEEXTRATRANSITIONS}
  procedure XtraTransitions(iStyle:Integer; iStep:Integer);
  begin
    if FStep=0 then
      fCurrentView.assign(fSourceShot)
    else
    if Assigned(IETransitionList[iStyle].proc) then
    begin
      SetStretchBltMode(fCurrentView.Canvas.Handle, HALFTONE);
      IETransitionList[iStyle].Proc(fCurrentView.canvas,
                                    fSourceShot,
                                    fTargetShot,
                                    Rect(0,0,fCurrentview.width,fCurrentview.height),
                                    1,
                                    Round(iStep/1024*100) );
    end;
  end;
  {$endif}
begin
  ToBitmap.width:=fWidth;
  ToBitmap.Height:=fHeight;
  ToBitmap.pixelformat:=pf24bit;

	fStep:=  (1024 * iStep) div 1000 ;
  if fStep>1024 then
    fStep:=1024;

  inc(fFrames);

  // make transition
	case fTransition of
    iettCrossDissolve:
      CrossDissolve(fStep);
    iettFadeOut:
      FadeOut(fStep);
    iettFadeIn:
      FadeIn(fStep);
    iettFadeOutIn:
      FadeOutIn(fStep);
    iettLeftRight1:
      LeftRight1(fStep);
    iettLeftRight2:
      LeftRight2(fStep);
    iettRightLeft1:
      RightLeft1(fStep);
    iettRightLeft2:
      RightLeft2(fStep);
    iettUpDown1:
      UpDown1(fStep);
    iettUpDown2:
      UpDown2(fStep);
    iettDownUp1:
      DownUp1(fStep);
    iettDownUp2:
      DownUp2(fStep);
    iettMoveLeftRight1:
      MoveLeftRight1(fStep);
    iettMoveLeftRight2:
      MoveLeftRight2(fStep);
    iettMoveRightLeft1:
      MoveRightLeft1(fStep);
    iettMoveRightLeft2:
      MoveRightLeft2(fStep);
    iettMoveUpDown1:
      MoveUpDown1(fStep);
    iettMoveUpDown2:
      MoveUpDown2(fStep);
    iettMoveDownUp1:
      MoveDownUp1(fStep);
    iettMoveDownUp2:
      MoveDownUp2(fStep);
    iettRandomPoints:
      RandomPoints(fStep);
    iettFromUpLeft:
      FromUpLeft(fStep);
    iettFromUpRight:
      FromUpRight(fStep);
    iettFromBottomLeft:
      FromBottomLeft(fStep);
    iettFromBottomRight:
      FromBottomRight(fStep);
    iettRandomBoxes:
      RandomBoxes(fStep);
    iettCenter1:
      Center1(fStep);
    iettCenter2:
      Center2(fStep);
    iettCenterZoom1:
      CenterZoom1(fStep);
    iettCenterZoom2:
      CenterZoom2(fStep);
    {$ifdef IEINCLUDEEXTRATRANSITIONS}
    else
      XtraTransitions(Integer(fTransition),FStep);
    {$endif}

  end;

  // paint result
	BitBlt(ToBitmap.Canvas.handle,0,0,fWidth,fHeight,fCurrentView.Canvas.Handle,0,0,SRCCOPY);

end;

procedure TIETransitionEffects.RandomPoints(Step: integer);
var
  y, fRowLen: integer;
  px1, px2: PRGBROW;
  r: integer;
  s, q: integer;
begin
  fRowLen := IEBitmapRowLen(fWidth, 24, 32);
  if fStep = 0 then
    CopyMemory(fCurrentViewLines[fHeight - 1], fSourceShotLines[fHeight - 1], fRowLen * fHeight)
  else
  begin
    q := round(Step * fWidth * (Step / 180) / 1024);
    s := q - fAccum1;
    fAccum1 := q;
    for y := 0 to fHeight - 1 do
    begin
      px1 := fCurrentViewLines[y];
      px2 := fTargetShotLines[y];
      for q := 0 to s - 1 do
      begin
        r := random(fWidth);
        px1^[r].r := px2^[r].r;
        px1^[r].b := px2^[r].b;
        px1^[r].g := px2^[r].g;
      end;
    end;
  end;
end;

// fade from background

procedure TIETransitionEffects.FadeIn(Step: integer);
var
  x, y: integer;
  ppx, ppx3: pRGB;
  c1: integer;
  rr, gg, bb: integer;
begin
  c1 := 1024 - Step;
  with TColor2TRGB(fOwner.Background) do
  begin
    rr := r * c1;
    gg := g * c1;
    bb := b * c1;
  end;
  for y := 0 to fHeight - 1 do
  begin
    ppx := fTargetShotLines[y];
    ppx3 := fCurrentViewLines[y];
    for x := 0 to fWidth - 1 do
    begin
      with ppx3^ do
      begin
        r := (ppx^.r * Step + rr) shr 10;
        g := (ppx^.g * Step + gg) shr 10;
        b := (ppx^.b * Step + bb) shr 10;
      end;
      inc(ppx);
      inc(ppx3);
    end;
  end;
end;

procedure TIETransitionEffects.FadeOutIn(Step: integer);
begin
  if Step < 512 then
    FadeOut(Step * 2)
  else
    FadeIn((Step - 512) * 2);
end;

// dissolve to background

procedure TIETransitionEffects.FadeOut(Step: integer);
var
  x, y: integer;
  ppx, ppx3: pRGB;
  c1: integer;
  rr, gg, bb: integer;
begin
  c1 := 1024 - Step;
  with TColor2TRGB(fOwner.Background) do
  begin
    rr := r * Step;
    gg := g * Step;
    bb := b * Step;
  end;
  for y := 0 to fHeight - 1 do
  begin
    ppx := fSourceShotLines[y];
    ppx3 := fCurrentViewLines[y];
    for x := 0 to fWidth - 1 do
    begin
      with ppx3^ do
      begin
        r := (ppx^.r * c1 + rr) shr 10;
        g := (ppx^.g * c1 + gg) shr 10;
        b := (ppx^.b * c1 + bb) shr 10;
      end;
      inc(ppx);
      inc(ppx3);
    end;
  end;
end;

procedure TIETransitionEffects.CrossDissolve(Step: integer);
var
  x, y: integer;
  ppx, ppx2, ppx3: pRGB;
  c1: integer;
begin
  c1 := 1024 - Step;
  for y := 0 to fHeight - 1 do
  begin
    ppx := fSourceShotLines[y];
    ppx2 := fTargetShotLines[y];
    ppx3 := fCurrentViewLines[y];
    for x := 0 to fWidth - 1 do
    begin
      with ppx3^ do
      begin
        r := (ppx^.r * c1 + ppx2^.r * Step) shr 10;
        g := (ppx^.g * c1 + ppx2^.g * Step) shr 10;
        b := (ppx^.b * c1 + ppx2^.b * Step) shr 10;
      end;
      inc(ppx);
      inc(ppx2);
      inc(ppx3);
    end;
  end;
end;

procedure TIETransitionEffects.LeftRight1(Step: integer);
begin
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, 0, 0, ((Step * fWidth) shr 10), fHeight, fTargetShot.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TIETransitionEffects.LeftRight2(Step: integer);
var
  sx: integer;
begin
  sx := (Step * fWidth) shr 10;
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, 0, 0, sx, fHeight, fTargetShot.Canvas.Handle, 0, 0, SRCCOPY);
  fCurrentView.Canvas.Pen.color := clRed;
  fCurrentView.Canvas.MoveTo(sx, 0);
  fCurrentView.canvas.LineTo(sx, fHeight);
end;

procedure TIETransitionEffects.RightLeft1(Step: integer);
var
  sx, sx2: integer;
begin
  sx := round(((1024 - Step) * fWidth) / 1024);
  sx2 := round((Step * fWidth) / 1024);
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, sx, 0, sx2, fHeight, fTargetShot.Canvas.Handle, sx, 0, SRCCOPY);
end;

procedure TIETransitionEffects.RightLeft2(Step: integer);
var
  sx, sx2: integer;
begin
  sx := round(((1024 - Step) * fWidth) / 1024);
  sx2 := round((Step * fWidth) / 1024);
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, sx, 0, sx2, fHeight, fTargetShot.Canvas.Handle, sx, 0, SRCCOPY);
  fCurrentView.Canvas.Pen.color := clRed;
  fCurrentView.Canvas.MoveTo(sx, 0);
  fCurrentView.canvas.LineTo(sx, fHeight);
end;

procedure TIETransitionEffects.UpDown1(Step: integer);
var
  sy: integer;
begin
  sy := round((Step * fHeight) / 1024);
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, 0, 0, fWidth, sy, fTargetShot.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TIETransitionEffects.UpDown2(Step: integer);
var
  sy: integer;
begin
  sy := round((Step * fHeight) / 1024);
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, 0, 0, fWidth, sy, fTargetShot.Canvas.Handle, 0, 0, SRCCOPY);
  fCurrentView.Canvas.Pen.Color := clRed;
  fCurrentView.Canvas.MoveTo(0, sy);
  fCurrentView.Canvas.LineTo(fWidth, sy);
end;

procedure TIETransitionEffects.DownUp1(Step: integer);
var
  sy, sy2: integer;
begin
  sy := round(((1024 - Step) * fHeight) / 1024);
  sy2 := round((Step * fHeight) / 1024);
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, 0, sy, fWidth, sy2, fTargetShot.Canvas.Handle, 0, sy, SRCCOPY);
end;

procedure TIETransitionEffects.DownUp2(Step: integer);
var
  sy, sy2: integer;
begin
  sy := round(((1024 - Step) * fHeight) / 1024);
  sy2 := round((Step * fHeight) / 1024);
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, 0, sy, fWidth, sy2, fTargetShot.Canvas.Handle, 0, sy, SRCCOPY);
  fCurrentView.Canvas.Pen.Color := clRed;
  fCurrentView.Canvas.MoveTo(0, sy);
  fCurrentView.Canvas.LineTo(fWidth, sy);
end;

procedure TIETransitionEffects.MoveLeftRight1(Step: integer);
var
  sx, y: integer;
  ppx, ppx2: PRGB;
begin
  sx := Step * fWidth shr 10;
  for y := 0 to fHeight - 1 do
  begin
    ppx := fCurrentViewLines[y];
    ppx2 := fTargetShotLines[y];
    inc(ppx2, fWidth - sx);
    CopyMemory(ppx, ppx2, sx * 3);
    inc(ppx, sx);
    CopyMemory(ppx, fSourceShotLines[y], (fWidth - sx) * 3);
  end;
end;

procedure TIETransitionEffects.MoveLeftRight2(Step: integer);
var
  sx, y: integer;
  ppx: PRGB;
begin
  sx := Step * fWidth shr 10;
  for y := 0 to fHeight - 1 do
  begin
    ppx := fCurrentViewLines[y];
    CopyMemory(ppx, fTargetShotLines[y], sx * 3);
    inc(ppx, sx);
    CopyMemory(ppx, fSourceShotLines[y], (fWidth - sx) * 3);
  end;
end;

procedure TIETransitionEffects.MoveRightLeft1(Step: integer);
var
  sx, y: integer;
  ppx, ppx2: PRGB;
begin
  sx := (1024 - Step) * fWidth shr 10;
  for y := 0 to fHeight - 1 do
  begin
    ppx := fCurrentViewLines[y];
    ppx2 := fSourceShotLines[y];
    inc(ppx2, fWidth - sx);
    CopyMemory(ppx, ppx2, sx * 3);
    inc(ppx, sx);
    CopyMemory(ppx, fTargetShotLines[y], (fWidth - sx) * 3);
  end;
end;

procedure TIETransitionEffects.MoveRightLeft2(Step: integer);
var
  sx, y: integer;
  ppx: PRGB;
begin
  sx := (1024 - Step) * fWidth shr 10;
  for y := 0 to fHeight - 1 do
  begin
    ppx := fCurrentViewLines[y];
    CopyMemory(ppx, fSourceShotLines[y], sx * 3);
    inc(ppx, sx);
    CopyMemory(ppx, fTargetShotLines[y], (fWidth - sx) * 3);
  end;
end;

procedure TIETransitionEffects.MoveUpDown1(Step: integer);
var
  sy, fRowLen, y: integer;
begin
  sy := Step * fHeight shr 10;
  fRowLen := IEBitmapRowLen(fWidth, 24, 32);
  for y := 0 to sy - 1 do
    CopyMemory(fCurrentViewLines[y], fTargetShotLines[fHeight - sy + y], fRowLen);
  for y := sy to fHeight - 1 do
    CopyMemory(fCurrentViewLines[y], fSourceShotLines[y - sy], fRowLen);
end;

// source image go away

procedure TIETransitionEffects.MoveUpDown2(Step: integer);
var
  sy, fRowLen, y: integer;
begin
  sy := Step * fHeight shr 10;
  fRowLen := IEBitmapRowLen(fWidth, 24, 32);
  for y := 0 to sy - 1 do
    CopyMemory(fCurrentViewLines[y], fTargetShotLines[y], fRowLen);
  for y := sy to fHeight - 1 do
    CopyMemory(fCurrentViewLines[y], fSourceShotLines[y - sy], fRowLen);
end;

procedure TIETransitionEffects.MoveDownUp1(Step: integer);
var
  sy, fRowLen, y: integer;
begin
  sy := (1024 - Step) * fHeight shr 10;
  fRowLen := IEBitmapRowLen(fWidth, 24, 32);
  for y := 0 to sy - 1 do
    CopyMemory(fCurrentViewLines[y], fSourceShotLines[fHeight - sy + y], fRowLen);
  for y := sy to fHeight - 1 do
    CopyMemory(fCurrentViewLines[y], fTargetShotLines[y - sy], fRowLen);
end;

// source image go away

procedure TIETransitionEffects.MoveDownUp2(Step: integer);
var
  sy, fRowLen, y: integer;
begin
  sy := (1024 - Step) * fHeight shr 10;
  fRowLen := IEBitmapRowLen(fWidth, 24, 32);
  for y := 0 to sy - 1 do
    CopyMemory(fCurrentViewLines[y], fSourceShotLines[fHeight - sy + y], fRowLen);
  for y := sy to fHeight - 1 do
    CopyMemory(fCurrentViewLines[y], fTargetShotLines[y], fRowLen);
end;

procedure TIETransitionEffects.FromUpLeft(Step: integer);
var
  sx, sy: integer;
begin
  sx := (1024 - Step) * fWidth shr 10;
  sy := (1024 - Step) * fHeight shr 10;
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  fCurrentView.Canvas.Draw(-sx, -sy, fTargetShot)
end;

procedure TIETransitionEffects.FromUpRight(Step: integer);
var
  sx, sy: integer;
begin
  sx := (1024 - Step) * fWidth shr 10;
  sy := (1024 - Step) * fHeight shr 10;
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  fCurrentView.Canvas.Draw(sx, -sy, fTargetShot);
end;

procedure TIETransitionEffects.FromBottomLeft(Step: integer);
var
  sx, sy: integer;
begin
  sx := (1024 - Step) * fWidth shr 10;
  sy := (1024 - Step) * fHeight shr 10;
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  fCurrentView.Canvas.Draw(-sx, sy, fTargetShot);
end;

procedure TIETransitionEffects.FromBottomRight(Step: integer);
var
  sx, sy: integer;
begin
  sx := (1024 - Step) * fWidth shr 10;
  sy := (1024 - Step) * fHeight shr 10;
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  fCurrentView.Canvas.Draw(sx, sy, fTargetShot);
end;

procedure TIETransitionEffects.RandomBoxes(Step: integer);
const
  boxdim = 8;
var
  s, q, x, y: integer;
begin
  if fStep = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot)
  else
  begin
    q := round(Step * (fWidth * fHeight div (boxdim * boxdim)) * (Step / 180) / 1024);
    s := q - fAccum1;
    fAccum1 := q;
    for q := 0 to s - 1 do
    begin
      x := random(fWidth) and $FFFFFFF8;
      y := random(fheight) and $FFFFFFF8;
      BitBlt(fCurrentView.Canvas.Handle, x, y, boxdim, boxdim, fTargetShot.Canvas.Handle, x, y, SRCCOPY);
    end;
  end;
end;

// the new image begin from center

procedure TIETransitionEffects.Center1(Step: integer);
var
  sx, sy: integer;
  sx2, sy2: integer;
  cx, cy: integer;
begin
  cx := fWidth shr 1;
  cy := fheight shr 1;
  sx := (Step * cx) shr 10;
  sx2 := Step * fWidth shr 10;
  sy := (Step * cy) shr 10;
  sy2 := step * fHeight shr 10;
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  BitBlt(fCurrentView.Canvas.Handle, cx - sx, cy - sy, sx2, sy2, fTargetShot.Canvas.Handle, cx - sx, cy - sy, SRCCOPY);
end;

// the old image collapse in the center

procedure TIETransitionEffects.Center2(Step: integer);
var
  sx, sy: integer;
  sx2, sy2: integer;
  cx, cy: integer;
begin
  cx := fWidth shr 1;
  cy := fheight shr 1;
  sx := ((1024 - Step) * cx) shr 10;
  sx2 := (1024 - Step) * fWidth shr 10;
  sy := ((1024 - Step) * cy) shr 10;
  sy2 := (1024 - step) * fHeight shr 10;
  fCurrentView.Canvas.Draw(0, 0, fTargetShot);
  BitBlt(fCurrentView.Canvas.Handle, cx - sx, cy - sy, sx2, sy2, fSourceShot.Canvas.Handle, cx - sx, cy - sy, SRCCOPY);
end;

procedure TIETransitionEffects.CenterZoom1(Step: integer);
var
  sx, sy: integer;
  sx2, sy2: integer;
  cx, cy: integer;
begin
  cx := fWidth shr 1;
  cy := fheight shr 1;
  sx := (Step * cx) shr 10;
  sx2 := Step * fWidth shr 10;
  sy := (Step * cy) shr 10;
  sy2 := step * fHeight shr 10;
  if Step = 0 then
    fCurrentView.Canvas.Draw(0, 0, fSourceShot);
  SetStretchBltMode(fCurrentView.Canvas.Handle, HALFTONE);
  StretchBlt(fCurrentView.Canvas.Handle, cx - sx, cy - sy, sx2, sy2, fTargetShot.Canvas.Handle, 0, 0, fWidth, fHeight, SRCCOPY);
end;

procedure TIETransitionEffects.CenterZoom2(Step: integer);
var
  sx, sy: integer;
  sx2, sy2: integer;
  cx, cy: integer;
begin
  cx := fWidth shr 1;
  cy := fheight shr 1;
  sx := ((1024 - Step) * cx) shr 10;
  sx2 := (1024 - Step) * fWidth shr 10;
  sy := ((1024 - Step) * cy) shr 10;
  sy2 := (1024 - step) * fHeight shr 10;
  fCurrentView.Canvas.Draw(0, 0, fTargetShot);
  SetStretchBltMode(fCurrentView.Canvas.Handle, HALFTONE);
  StretchBlt(fCurrentView.Canvas.Handle, cx - sx, cy - sy, sx2, sy2, fSourceShot.Canvas.Handle, 0, 0, fWidth, fHeight, SRCCOPY);
end;

procedure TIETransitionEffects.PanZoom(Step: integer);

  // Center the displayed portion of image within the window at the correct aspect ratio
  procedure _AdjustDestPos(iShowImgWidth,iShowImgHeight:Integer;  // height and width of the part of the image currently visible
                           iIEViewWidth,iIEViewHeight:Integer;    // the dimensions of the display window
                           var iResultLeft:Integer;
                           var iResultTop:Integer;
                           var iResultWidth:Integer;
                           var iResultHeight:Integer);
  var
    dResizeRatio:Double;
  begin
    iResultLeft:=0;
    iResultTop:=0;
    iResultWidth:=0;
    iResultHeight:=0;
    try
      if (iShowImgHeight / iIEViewHeight)<(iShowImgWidth / iIEViewWidth) then
      // WIDTH IS IMPORTANT
      begin
        // calulate the amount to increase the object size by
        dResizeRatio := iIEViewWidth/iShowImgWidth;

        // now get the new image dimensions
        iResultHeight:=round(iShowImgHeight*dResizeRatio);
        iResultWidth:=round(iShowImgWidth*dResizeRatio);
      end
      ELSE
      // HEIGHT IS IMPORTANT
      begin
        // calulate the amount to increase the object size by
        dResizeRatio := iIEViewHeight/iShowImgHeight;

        // now get the new image dimensions
        iResultWidth:=round(iShowImgWidth*dResizeRatio);
        iResultHeight:=round(iShowImgHeight*dResizeRatio);
      end;

      // center image in hte available area
      iResultLeft:= trunc((iIEViewWidth /2)-(iResultWidth /2));
      iResultTop:= trunc((iIEViewHeight / 2)-(iResultHeight / 2));

    except
      // DIV BY ZERO ERROR DUE TO NULL IMAGE SIZES
    end;
  end;

var
  bHasBorders: boolean;
  xdst,ydst,dxdst,dydst:Integer;
  xSrc,ySrc,dxSrc,dySrc:integer;
  q:double;
begin
  bHasBorders:=false;

  xdst:=0;
  ydst:=0;
  dxdst:=fWidth;
  dydst:=fHeight;

  q:=(startRect.Left-endRect.Left)/1024;
  xSrc:= trunc(startRect.Left-q*Step);
  q:=(startRect.Top-endRect.Top)/1024;
  ySrc:= trunc(startRect.Top-q*Step);
  q:=(startRect.Right-endRect.Right)/1024;
  dxSrc:= trunc(startRect.Right-q*Step)-xSrc;
  q:=(startRect.Bottom-endRect.Bottom)/1024;
  dySrc:= trunc(startRect.Bottom-q*Step)-ySrc;

  // Are we showing some border area?
  if xSrc<0 then
  begin
    inc(dxSrc,xSrc);
    xSrc:=0;
    bHasBorders:=true;
  end;

  if dxSrc>fFullImage.width then
  begin
    dxSrc:= fFullImage.width;
    bHasBorders:=true;
  end;

  if ySrc<0 then
  begin
    inc(dySrc,ySrc);
    ySrc:=0;    
    bHasBorders:=true;
  end;

  if dySrc>fFullImage.height then
  begin
    dySrc:= fFullImage.height;
    bHasBorders:=true;
  end;

  if bHasBorders then
  begin
    // Center the visible image portion within the window (and maintain the aspect ratio)
    _AdjustDestPos(dxSrc,dySrc,fwidth,fheight,
                   xdst,ydst,dxdst,dydst);

    // Draw the background
    if fowner is TImageEnView then
      TImageEnView(fowner).DrawBackgroundToCanvas(fCurrentView.Canvas)
    else
    begin                             
      fCurrentView.Canvas.brush.color:= fowner.Background;
      fCurrentView.Canvas.FillRect(rect(0,0,fCurrentView.width,fCurrentView.height));
    end;
  end;

  fFullImage.RenderToTBitmapEx(fCurrentView, xdst, ydst, dxdst, dydst, xSrc, ySrc, dxSrc, dySrc, 255, iegPanZoomQualityFilter, ielNormal);
end;


// end of TIETransitionEffects
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

type
  // Type of a filter for use with Stretch()
  TFilterProc = function(Value: double): double;
  // Contributor for a pixel
  TContributor = record
    pixel: integer; // Source pixel
    weight: integer; // Pixel weight
  end;
  PContributor = ^TContributor;
  TContributorList = array[0..0] of TContributor;
  PContributorList = ^TContributorList;
  TRGBList = packed array[0..0] of TRGB;
  PRGBList = ^TRGBList;
  TFRGB = packed record
    r, g, b: double;
  end;
const
  ResampleFilters: array[0..7] of record
    Filter: TFilterProc;
    Width: double;
  end = ((Filter: TriangleFilter; Width: 1.0),
    (Filter: HermiteFilter; Width: 1.0),
    (Filter: BellFilter; Width: 1.5),
    (Filter: SplineFilter; Width: 2.0),
    (Filter: Lanczos3Filter; Width: 3.0),
    (Filter: MitchellFilter; Width: 2.0),
    (Filter: NearestFilter; Width: 1.0),
    (Filter: LinearFilter; Width: 1.0));

/////////////////////////////////////////////////////////////////////////////////////
// resample only specified bitmap (ie8g)
// The algorithms and methods used in this function are based on the article
// "General Filtered Image Rescaling" by Dale Schumacher which appeared in the
// book Graphics Gems III, published by Academic Press, Inc.
procedure _Resampleie8g(Src, Dst: TIEBitmap; FilterType: TResampleFilter);
type
  TContributorList = array[0..0] of TContributor;
  PContributorList = ^TContributorList;
  // List of source pixels contributing to a destination pixel
  TCList = record
    n: integer;
    p: PContributorList;
  end;
  TCListList = array[0..0] of TCList;
  PCListList = ^TCListList;
  TByteList = array[0..0] of byte;
  PByteLIst = ^TByteList;
var
  filter: TFilterProc;
  fwidth: double;
  xscale, yscale: double; // Zoom scale factors
  i, j, k, cn: integer; // Loop variables
  center: double; // Filter calculation variables
  weight: integer;
  width, fscale: double; // Filter calculation variables
  left, right: integer; // Filter calculation variables
  n: integer; // Pixel number
  Work: TIEMask;
  contrib: PCListList;
  vv, tt: integer;
  color: byte;
  SourceLine(*, DestLine*): pbytelist;
  SourcePixel, DestPixel: pbyte;
  //Delta, DestDelta: integer;
  SrcWidth, SrcHeight, DstWidth, DstHeight: integer;
  per1: double;
  t:integer;
  cl:TCList;
begin
  if (FilterType = rfFastLinear) or (FilterType = rfBicubic) or (FilterType = rfBilinear) or (FilterType=rfProjectBW) or (FilterType=rfProjectWB) then
  begin
    _ResampleLinearAlpha(Src, Dst, nil, nil);
    exit;
  end;
  filter := ResampleFilters[ord(FilterType) - 1].Filter;
  fwidth := ResampleFilters[ord(FilterType) - 1].Width;
  DstWidth := Dst.Width;
  DstHeight := Dst.Height;
  SrcWidth := Src.Width;
  SrcHeight := Src.Height;
  if (SrcWidth = 0) or (SrcHeight = 0) then
    exit;
  if (SrcWidth < 2) and (SrcHeight < 2) then
    exit;
  //
  per1 := 100 / (SrcHeight + DstWidth + 0.5);
  // Create intermediate image to hold horizontal zoom
  Work := TIEMask.Create;
  try
    Work.AllocateBits(DstWidth, SrcHeight, 8);
    if (SrcWidth = 1) or (DstWidth = 1) then
      xscale := DstWidth / SrcWidth
    else
      xscale := (DstWidth - 1) / (SrcWidth - 1);
    if (SrcHeight = 1) or (DstHeight = 1) then
      yscale := DstHeight / SrcHeight
    else
      yscale := (DstHeight - 1) / (SrcHeight - 1);
    // --------------------------------------------
    // Pre-calculate filter contributions for a row
    // -----------------------------------------------
    GetMem(contrib, DstWidth * sizeof(TCList));
    // Horizontal sub-sampling
    // Scales from bigger to smaller width
    if (xscale < 1.0) then
    begin
      width := fwidth / xscale;
      fscale := 1.0 / xscale;
      for i := 0 to DstWidth - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
        center := i / xscale;
        left := floor(center - width);
        right := ieceil(center + width);
        for j := left to right do
        begin
          weight := round(256 * filter((center - j) / fscale) / fscale);
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcWidth) then
            n := SrcWidth - j + SrcWidth - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end;
    end
    else
    begin
      // Horizontal super-sampling
        // Scales from smaller to bigger width
      for i := 0 to DstWidth - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
        center := i / xscale;
        left := floor(center - fwidth);
        right := ieceil(center + fwidth);
        for j := left to right do
        begin
          weight := round(256 * filter(center - j));
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcWidth) then
            n := SrcWidth - j + SrcWidth - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end;
    end;
    // ----------------------------------------------------
    // Apply filter to sample horizontally from Src to Work
    // ----------------------------------------------------
    for k := 0 to SrcHeight - 1 do
    begin
      SourceLine := Src.ScanLine[k];
      DestPixel := Work.ScanLine[k];
      for i := 0 to DstWidth - 1 do
      begin
        vv := 0;
        tt := 0;
        for j := 0 to contrib^[i].n - 1 do
        begin
          t := contrib^[i].p^[j].pixel;
          if t >= SrcWidth then
            t := SrcWidth - 1
          else if t < 0 then
            t := 0;
          color := SourceLine^[t];
          weight := contrib^[i].p^[j].weight;
          inc(tt, weight);
          if (weight = 0) then
            continue;
          inc(vv, color * weight);
        end;
        if tt = 0 then
          color := blimit(vv shr 8)
        else
          color := blimit(vv div tt);
        // Set new pixel value
        DestPixel^ := color;
        // Move on to next column
        inc(DestPixel);
      end;
    end;
    // Free the memory allocated for horizontal filter weights
    for i := 0 to DstWidth - 1 do
      FreeMem(contrib^[i].p);
    FreeMem(contrib);
    // Pre-calculate filter contributions for a column
    GetMem(contrib, DstHeight * sizeof(TCList));
    // Vertical sub-sampling
    // Scales from bigger to smaller height
    if (yscale < 1.0) then
    begin
      width := fwidth / yscale;
      fscale := 1.0 / yscale;
      for i := 0 to DstHeight - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
        center := i / yscale;
        left := floor(center - width);
        right := ieceil(center + width);
        for j := left to right do
        begin
          weight := round(256 * filter((center - j) / fscale) / fscale);
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcHeight) then
            n := SrcHeight - j + SrcHeight - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end
    end
    else
    begin
      // Vertical super-sampling
        // Scales from smaller to bigger height
      for i := 0 to DstHeight - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
        center := i / yscale;
        left := floor(center - fwidth);
        right := ieceil(center + fwidth);
        for j := left to right do
        begin
          weight := round(256 * filter(center - j));
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcHeight) then
            n := SrcHeight - j + SrcHeight - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end;
    end;

    // Apply filter to sample vertically from Work to Dst
    // 3.0.1
    for i := 0 to DstHeight - 1 do
    begin
      DestPixel:=Dst.Scanline[i];
      cl:=contrib[i];
      cn:=cl.n-1;
      for k := 0 to DstWidth - 1 do
      begin
        vv := 0;
        tt := 0;
        for j := 0 to cn do
        begin
          t:=cl.p[j].pixel;
          if t<0 then t:=0 else if t>=SrcHeight then t:=SrcHeight-1;
          SourcePixel := Work.Scanline[t];
          inc(SourcePixel,k);
          weight := cl.p^[j].weight;
          inc(tt, weight);
          inc(vv, SourcePixel^ * weight);
        end;
        if tt = 0 then
          DestPixel^ := blimit(vv shr 8)
        else
          DestPixel^ := blimit(vv div tt);
        inc(DestPixel);
      end;
      //Inc(SourceLine, 1);
      //Inc(DestLine, 1);
    end;

    // Free the memory allocated for vertical filter weights
    for i := 0 to DstHeight - 1 do
      FreeMem(contrib^[i].p);
    FreeMem(contrib);
  finally
    FreeAndNil(Work);
  end;
end;

// if FilterType=rfProjectBW or FilterType=rfProjectWB then Dst must be ie1g
procedure _Resample1bitEx(Src, Dst: TIEBitmap; FilterType: TResampleFilter);
type
  TContributorList = array[0..0] of TContributor;
  PContributorList = ^TContributorList;
  // List of source pixels contributing to a destination pixel
  TCList = record
    n: integer;
    p: PContributorList;
  end;
  TCListList = array[0..0] of TCList;
  PCListList = ^TCListList;
  TByteList = array[0..0] of byte;
  PByteLIst = ^TByteList;
var
  filter: TFilterProc;
  fwidth: double;
  xscale, yscale: double; // Zoom scale factors
  i, j, k: integer; // Loop variables
  center: double; // Filter calculation variables
  weight: integer;
  width, fscale: double; // Filter calculation variables
  left, right: integer; // Filter calculation variables
  n: integer; // Pixel number
  Work: TIEMask;
  contrib: PCListList;
  tt, vv: integer;
  color: byte;
  SourceLine: pbytelist;
  SourcePixel, DestPixel: pbyte;
  DestPixelRGB: PRGB;
  //Delta: integer;
  SrcWidth, SrcHeight, DstWidth, DstHeight: integer;
  per1: double;
  //t, t1, t2: int64;
  DestCol:integer;
  cl:TCList;
  t,cn:integer;
begin
  if (FilterType = rfFastLinear) or (FilterType = rfBicubic) or (FilterType = rfBilinear) then
  begin
    _ResampleLinear1BitEx(Src, Dst, nil, nil);
    exit;
  end;
  if (FilterType=rfProjectBW) then
  begin
    _ResampleProject1Bit(Src,Dst,false,nil,nil);
    exit;
  end;
  if (FilterType=rfProjectWB) then
  begin
    _ResampleProject1Bit(Src,Dst,true,nil,nil);
    exit;
  end;
  filter := ResampleFilters[ord(FilterType) - 1].Filter;
  fwidth := ResampleFilters[ord(FilterType) - 1].Width;
  DstWidth := Dst.Width;
  DstHeight := Dst.Height;
  SrcWidth := Src.Width;
  SrcHeight := Src.Height;
  if (SrcWidth = 0) or (SrcHeight = 0) then
    exit;
  if (SrcWidth < 2) and (SrcHeight < 2) then
    exit;
  //
  per1 := 100 / (SrcHeight + DstWidth + 0.5);
  // Create intermediate image to hold horizontal zoom
  Work := TIEMask.Create;
  try
    Work.AllocateBits(DstWidth, SrcHeight, 8);
    if (SrcWidth = 1) or (DstWidth = 1) then
      xscale := DstWidth / SrcWidth
    else
      xscale := (DstWidth - 1) / (SrcWidth - 1);
    if (SrcHeight = 1) or (DstHeight = 1) then
      yscale := DstHeight / SrcHeight
    else
      yscale := (DstHeight - 1) / (SrcHeight - 1);
    // --------------------------------------------
    // Pre-calculate filter contributions for a row
    // -----------------------------------------------
    GetMem(contrib, DstWidth * sizeof(TCList));
    // Horizontal sub-sampling
    // Scales from bigger to smaller width
    if (xscale < 1.0) then
    begin
      width := fwidth / xscale;
      fscale := 1.0 / xscale;
      for i := 0 to DstWidth - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
        center := i / xscale;
        left := floor(center - width);
        right := ieceil(center + width);
        for j := left to right do
        begin
          weight := round(256 * filter((center - j) / fscale) / fscale);
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcWidth) then
            n := SrcWidth - j + SrcWidth - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end;
    end
    else
    begin
      // Horizontal super-sampling
        // Scales from smaller to bigger width
      for i := 0 to DstWidth - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
        center := i / xscale;
        left := floor(center - fwidth);
        right := ieceil(center + fwidth);
        for j := left to right do
        begin
          weight := round(256 * filter(center - j));
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcWidth) then
            n := SrcWidth - j + SrcWidth - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end;
    end;
    // ----------------------------------------------------
    // Apply filter to sample horizontally from Src to Work
    // ----------------------------------------------------
    for k := 0 to SrcHeight - 1 do
    begin
      SourceLine := Src.ScanLine[k];
      DestPixel := Work.ScanLine[k];
      for i := 0 to DstWidth - 1 do
      begin
        vv := 0;
        tt := 0;
        for j := 0 to contrib^[i].n - 1 do
        begin
          t := contrib^[i].p^[j].pixel;
          if t >= SrcWidth then
            t := SrcWidth - 1
          else if t < 0 then
            t := 0;
          if pbytearray(SourceLine)^[t shr 3] and iebitmask1[t and $7] = 0 then
            color := 0
          else
            color := 255;
          weight := contrib^[i].p^[j].weight;
          inc(tt, weight);
          if (weight = 0) then
            continue;
          inc(vv, color * weight);
        end;
        if tt = 0 then
          color := blimit(vv shr 8)
        else
          color := blimit(vv div tt);
        // Set new pixel value
        DestPixel^ := color;
        // Move on to next column
        inc(DestPixel);
      end;
    end;
    // Free the memory allocated for horizontal filter weights
    for i := 0 to DstWidth - 1 do
      FreeMem(contrib^[i].p);
    FreeMem(contrib);
    // Pre-calculate filter contributions for a column
    GetMem(contrib, DstHeight * sizeof(TCList));
    // Vertical sub-sampling
    // Scales from bigger to smaller height
    if (yscale < 1.0) then
    begin
      width := fwidth / yscale;
      fscale := 1.0 / yscale;
      for i := 0 to DstHeight - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
        center := i / yscale;
        left := floor(center - width);
        right := ieceil(center + width);
        for j := left to right do
        begin
          weight := round(256 * filter((center - j) / fscale) / fscale);
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcHeight) then
            n := SrcHeight - j + SrcHeight - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end
    end
    else
    begin
      // Vertical super-sampling
        // Scales from smaller to bigger height
      for i := 0 to DstHeight - 1 do
      begin
        contrib^[i].n := 0;
        GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
        center := i / yscale;
        left := floor(center - fwidth);
        right := ieceil(center + fwidth);
        for j := left to right do
        begin
          weight := round(256 * filter(center - j));
          if (weight = 0) then
            continue;
          if (j < 0) then
            n := -j
          else if (j >= SrcHeight) then
            n := SrcHeight - j + SrcHeight - 1
          else
            n := j;
          k := contrib^[i].n;
          contrib^[i].n := contrib^[i].n + 1;
          contrib^[i].p^[k].pixel := n;
          contrib^[i].p^[k].weight := weight;
        end;
      end;
    end;

    // Apply filter to sample vertically from Work to Dst
    for i := 0 to DstHeight - 1 do
    begin
      DestPixelRGB := Dst.Scanline[i];
      cl:=contrib[i];
      cn:=cl.n-1;
      for k := 0 to DstWidth - 1 do
      begin
        vv := 0;
        tt := 0;
        for j := 0 to cn do
        begin
          t:=cl.p[j].pixel;
          if t<0 then t:=0 else if t>=SrcHeight then t:=SrcHeight-1;
          SourcePixel := Work.Scanline[t];
          inc(SourcePixel,k);
          weight := contrib^[i].p^[j].weight;
          inc(tt, weight);
          inc(vv, SourcePixel^ * weight);
        end;
        if tt = 0 then
          color := blimit(vv shr 8)
        else
          color := blimit(vv div tt);
        with DestPixelRGB^ do
        begin
          r := color;
          g := color;
          b := color;
        end;
        inc(DestPixelRGB);
      end;
    end;

    // Free the memory allocated for vertical filter weights
    for i := 0 to DstHeight - 1 do
      FreeMem(contrib^[i].p);
    FreeMem(contrib);
  finally
    FreeAndNil(Work);
  end;
end;



///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

type

(*
  TContributorList = array[0..0] of TContributor;
  PContributorList = ^TContributorList;
  *)
  // List of source pixels contributing to a destination pixel
  TCList = record
    n: integer;
    p: PContributorList;
  end;
  PCList = ^TCList;
  TCListList = array[0..0] of TCList;
  PCListList = ^TCListList;

  TResampleHorizSharedFields = record
    ThreadsCount:integer;
    DstWidth:integer;
    contrib:PCListList;
    Src:TIEBaseBitmap;
    Work:TIEWorkBitmap;
    per1:double;
    OnProgress:TIEProgressEvent;
    Sender:TObject;
  end;

  TResampleHorizThread = class(TThread)
  private
    sharedFields:TResampleHorizSharedFields;
    startY, rowCount:integer;
    threadIndex:integer;
    percentage:integer;
  public
    procedure Execute; override;
    constructor Create(startY_, rowCount_:integer; const sharedFields_:TResampleHorizSharedFields; threadIndex_:integer);
    procedure DoProgress;
  end;

constructor TResampleHorizThread.Create(startY_, rowCount_:integer; const sharedFields_:TResampleHorizSharedFields; threadIndex_:integer);
begin
  inherited Create(true);
  startY := startY_;
  rowCount := rowCount_;
  sharedFields := sharedFields_;
  threadIndex := threadIndex_;
end;

procedure TResampleHorizThread.DoProgress;
begin
  sharedFields.OnProgress(sharedFields.Sender, percentage);
end;

procedure TResampleHorizThread.Execute();
var
  k, i, j:integer;
  SourceLine:PRGBList;
  DestPixel:PRGB;
  rr, gg, bb, tt:integer;
  aper, lper:integer;
  contributor:PContributor;
begin
  lper := -1;
  for k := startY to startY + rowCount - 1 do
  begin
    SourceLine := sharedFields.Src.ScanLine[k];
    DestPixel := sharedFields.Work.ScanLine[k];
    for i := 0 to sharedFields.DstWidth - 1 do
    begin
      rr := 0;
      gg := 0;
      bb := 0;
      tt := 0;
      contributor := @(sharedFields.contrib^[i].p^[0]);
      for j := 0 to sharedFields.contrib^[i].n - 1 do
      begin
        inc(tt, contributor^.weight);
        with SourceLine^[ contributor^.pixel ] do
        begin
          inc(rr, r * contributor^.weight);
          inc(gg, g * contributor^.weight);
          inc(bb, b * contributor^.weight);
        end;
        inc(contributor);
      end;
      if tt=0 then tt:=256;
      rr := rr div tt;
      if rr<0 then rr := 0 else if rr>255 then rr := 255;
      gg := gg div tt;
      if gg<0 then gg := 0 else if gg>255 then gg := 255;
      bb := bb div tt;
      if bb<0 then bb := 0 else if bb>255 then bb := 255;
      with DestPixel^ do
      begin
        r := rr;
        g := gg;
        b := bb;
      end;
      inc(DestPixel); // Move on to next column
    end;
    if (threadIndex=0) and assigned(sharedFields.OnProgress) then
    begin
      aper := trunc(sharedFields.per1 * (k*sharedFields.ThreadsCount + 1));
      if aper<>lper then
      begin
        sharedFields.OnProgress(sharedFields.Sender, aper);
        lper:=aper;
      end;
    end;
  end;
end;


// if FilterType=rfProjectBW or FilterType=rfProjectWB then Dst must be ie1g
procedure _ResampleEx(SrcImg, DstImg: TIEBaseBitmap; FilterType: TResampleFilter; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  Src:TIEBaseBitmap;
  filter: TFilterProc;
  fwidth: double;
  xscale, yscale: double; // Zoom scale factors
  i, j, k: integer;       // Loop variables
  t,cn:integer;
  center: double;         // Filter calculation variables
  weight: integer;
  width, fscale: double;  // Filter calculation variables
  left, right: integer;   // Filter calculation variables
  n: integer;             // Pixel number
  Work: TIEWorkBitmap;
  contrib: PCListList;
  rgb: TFRGB;
  color: TRGB;
  SourceLine: PRGBList;
  SourcePixel, DestPixel: PRGB;
  SrcWidth, SrcHeight, DstWidth, DstHeight: integer;
  per1: double;
  rr, gg, bb, tt, DestCol: integer;
  lper, aper:integer;
  cl:TCList;
  horizSharedFields:TResampleHorizSharedFields;
  threads:TIEThreadPool;
  threadsCount:integer;
  rowsPerThread:integer;
  startY, rowCount:integer;
begin

  if (SrcImg.Width = 0) or (SrcImg.Height = 0) or ((SrcImg.Width < 2) and (SrcImg.Height < 2)) then
    exit;

  case FilterType of
    rfBicubic:
      if ((SrcImg.PixelFormat=ie24RGB) or (SrcImg.PixelFormat=ie8g)) then
      begin
        _IEQResampleBytes(SrcImg, DstImg, 1, fOnProgress, Sender);
        exit;
      end
      else if ((SrcImg.PixelFormat=ie48RGB) or (SrcImg.PixelFormat=ie16g)) then
      begin
        _IEQResampleWords(SrcImg, DstImg, 1, fOnProgress, Sender);
        exit;
      end
      else
        FilterType := rfTriangle; // resample anyway
    rfBilinear:
      if ((SrcImg.PixelFormat=ie24RGB) or (SrcImg.PixelFormat=ie8g)) then
      begin
        _IEQResampleBytes(SrcImg, DstImg, 0, fOnProgress, Sender);
        exit;
      end
      else if ((SrcImg.PixelFormat=ie48RGB) or (SrcImg.PixelFormat=ie16g)) then
      begin
        _IEQResampleWords(SrcImg, DstImg, 0, fOnProgress, Sender);
        exit;
      end
      else
        FilterType := rfTriangle; // resample anyway
  end;

  if (SrcImg.PixelFormat=ie8g) then
  begin
    _Resampleie8g(SrcImg as TIEBitmap, DstImg as TIEBitmap, FilterType);
    exit;
  end;

  if SrcImg.Pixelformat <> ie24RGB then
  begin
    if (SrcImg is TIEBitmap) and (DstImg is TIEBitmap) then
    begin
      // create a temporary ie24RGB bitmap
      Src := TIEBitmap.Create(SrcImg.Width, SrcImg.Height, ie24RGB);
      TIEBitmap(Src).CopyAndConvertFormat(TIEBitmap(SrcImg));
      TIEBitmap(DstImg).PixelFormat := ie24RGB;
    end
    else
      exit; // fail, cannot convert non-TIEBitmap to TIEBitmap
  end
  else
    Src := SrcImg;

  try

    if (FilterType = rfFastLinear) then
    begin
      _ResampleLinearEx(Src, DstImg, fOnProgress, Sender);
      exit;
    end;
    if (FilterType = rfProjectBW) then
    begin
      _ResampleProject24Bit(Src, DstImg, false, fOnProgress, Sender);
      exit;
    end;
    if (FilterType = rfProjectWB) then
    begin
      _ResampleProject24Bit(Src, DstImg, true, fOnProgress, Sender);
      exit;
    end;

    lper:=-1;

    filter := ResampleFilters[ord(FilterType) - 1].Filter;
    fwidth := ResampleFilters[ord(FilterType) - 1].Width;
    DstWidth  := DstImg.Width;
    DstHeight := DstImg.Height;
    SrcWidth  := Src.Width;
    SrcHeight := Src.Height;

    per1 := 100 / (SrcHeight + DstWidth + 0.5);

    // Create intermediate image to hold horizontal zoom
    work := nil;
    try
      if (SrcWidth = 1) or (DstWidth = 1) then
        xscale := DstWidth / SrcWidth
      else
        xscale := (DstWidth - 1) / (SrcWidth - 1);
      if (SrcHeight = 1) or (DstHeight = 1) then
        yscale := DstHeight / SrcHeight
      else
        yscale := (DstHeight - 1) / (SrcHeight - 1);
      // This implementation only works on 24-bit images
      Work := TIEWorkBitmap.Create(DstWidth, SrcHeight, 24);
      // --------------------------------------------
      // Pre-calculate filter contributions for a row
      // -----------------------------------------------
      GetMem(contrib, DstWidth * sizeof(TCList));
      // Horizontal sub-sampling
      // Scales from bigger to smaller width
      if (xscale < 1.0) then
      begin
        width := fwidth / xscale;
        fscale := 1.0 / xscale;
        for i := 0 to DstWidth - 1 do
        begin
          contrib^[i].n := 0;
          GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
          center := i / xscale;
          left := floor(center - width);
          right := ieceil(center + width);
          for j := left to right do
          begin
            weight := round(256 * filter((center - j) / fscale) / fscale);
            if (weight = 0) then
              continue;
            if (j < 0) then
              n := -j
            else if (j >= SrcWidth) then
              n := SrcWidth - j + SrcWidth - 1
            else
              n := j;
            k := contrib^[i].n;
            inc(contrib^[i].n);
            if n<0 then n:=0 else if n>=SrcWidth then n:=SrcWidth-1;
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
          end;
        end;
      end
      else
      begin
        // Horizontal super-sampling
        // Scales from smaller to bigger width
        for i := 0 to DstWidth - 1 do
        begin
          contrib^[i].n := 0;
          GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
          center := i / xscale;
          left := floor(center - fwidth);
          right := ieceil(center + fwidth);
          for j := left to right do
          begin
            weight := round(256 * filter(center - j));
            if (weight = 0) then
              continue;
            if (j < 0) then
              n := -j
            else if (j >= SrcWidth) then
              n := SrcWidth - j + SrcWidth - 1
            else
              n := j;
            k := contrib^[i].n;
            inc(contrib^[i].n);
            if n<0 then n:=0 else if n>=SrcWidth then n:=SrcWidth-1;
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
          end;
        end;
      end;

      // ----------------------------------------------------
      // Apply filter to sample horizontally from Src to Work
      // ----------------------------------------------------
      horizSharedFields.DstWidth := DstWidth;
      horizSharedFields.contrib := contrib;
      horizSharedFields.Src := Src;
      horizSharedFields.Work := Work;
      horizSharedFields.per1 := per1;
      horizSharedFields.OnProgress := fOnProgress;
      horizSharedFields.Sender := Sender;
      if (Src is TIEBitmap) and ((Src as TIEBitmap).Location = ieFile) then
        threadsCount := 1
      else
        threadsCount := IEGetCoresCount();
      horizSharedFields.ThreadsCount := threadsCount;
      threads := TIEThreadPool.Create;
      rowsPerThread := SrcHeight div threadsCount;
      startY := 0;
      rowCount := rowsPerThread;
      for i:=0 to threadsCount-1 do
      begin
        threads.Add( TResampleHorizThread.Create(startY, rowCount, horizSharedFields, i) );
        inc(startY, rowCount);
        if i = threadsCount-2 then
          rowCount := SrcHeight-startY; // last thread gets remaining rows
      end;
      threads.Join();
      threads.Free;

      // Free the memory allocated for horizontal filter weights
      for i := 0 to DstWidth - 1 do
        FreeMem(contrib^[i].p);
      FreeMem(contrib);

      // Pre-calculate filter contributions for a column
      GetMem(contrib, DstHeight * sizeof(TCList));
      // Vertical sub-sampling
      // Scales from bigger to smaller height
      if (yscale < 1.0) then
      begin
        width := fwidth / yscale;
        fscale := 1.0 / yscale;
        for i := 0 to DstHeight - 1 do
        begin
          contrib^[i].n := 0;
          GetMem(contrib^[i].p, trunc(width * 2.0 + 1) * sizeof(TContributor));
          center := i / yscale;
          left := floor(center - width);
          right := ieceil(center + width);
          for j := left to right do
          begin
            weight := round(256 * filter((center - j) / fscale) / fscale);
            if (weight = 0) then
              continue;
            if (j < 0) then
              n := -j
            else if (j >= SrcHeight) then
              n := SrcHeight - j + SrcHeight - 1
            else
              n := j;
            k := contrib^[i].n;
            inc(contrib^[i].n);
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
          end;
        end
      end
      else
      begin
        // Vertical super-sampling
        // Scales from smaller to bigger height
        for i := 0 to DstHeight - 1 do
        begin
          contrib^[i].n := 0;
          GetMem(contrib^[i].p, trunc(fwidth * 2.0 + 1) * sizeof(TContributor));
          center := i / yscale;
          left := floor(center - fwidth);
          right := ieceil(center + fwidth);
          for j := left to right do
          begin
            weight := round(256 * filter(center - j));
            if (weight = 0) then
              continue;
            if (j < 0) then
              n := -j
            else if (j >= SrcHeight) then
              n := SrcHeight - j + SrcHeight - 1
            else
              n := j;
            k := contrib^[i].n;
            inc(contrib^[i].n);
            contrib^[i].p^[k].pixel := n;
            contrib^[i].p^[k].weight := weight;
          end;
        end;
      end;

      // Apply filter to sample vertically from Work to Dst
      for i := 0 to DstHeight - 1 do
      begin
        DestPixel := DstImg.Scanline[i];
        cl:=contrib[i];
        cn:=cl.n-1;
        for k := 0 to DstWidth - 1 do
        begin
          rr := 0;
          gg := 0;
          bb := 0;
          tt := 0;
          for j := 0 to cn do
          begin
            t:=cl.p[j].pixel;
            if t<0 then t:=0 else if t>=SrcHeight then t:=SrcHeight-1;
            SourcePixel := Work.Scanline[t];
            inc(SourcePixel,k);
            weight := cl.p[j].weight;
            inc(tt, weight);
            with SourcePixel^ do
            begin
              inc(rr, r * weight);
              inc(gg, g * weight);
              inc(bb, b * weight);
            end;
          end;
          if tt = 0 then
            with DestPixel^ do
            begin
              r := blimit(rr shr 8);
              g := blimit(gg shr 8);
              b := blimit(bb shr 8);
            end
          else
            with DestPixel^ do
            begin
              rr := rr div tt; if rr < 0 then r := 0 else if rr > 255 then r := 255 else r := rr;
              gg := gg div tt; if gg < 0 then g := 0 else if gg > 255 then g := 255 else g := gg;
              bb := bb div tt; if bb < 0 then b := 0 else if bb > 255 then b := 255 else b := bb;
            end;
          inc(DestPixel);
        end;
        if assigned(fOnProgress) then
        begin
          aper:=trunc(per1 * (i + SrcHeight + 1));
          if aper<>lper then
          begin
            fOnProgress(Sender, aper);
            lper:=aper;
          end;
        end;
      end;

      // Free the memory allocated for vertical filter weights
      for i := 0 to DstHeight - 1 do
        FreeMem(contrib^[i].p);
      FreeMem(contrib);
    finally
      FreeAndNil(Work);
    end;
  finally
    if Src<>SrcImg then
      Src.Free;
  end;
end;


///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Shen-Castan edge detector

// Create TIEWorkBitmap filled with gray scale of the original bitmap (pf24bit)

function sh_CreateGrayPixMap(Source: TIEBitmap): TIEWorkBitmap;
var
  x, y, width, height: integer;
  px: pbyte;
  rgb: PRGB;
begin
  width := Source.Width;
  height := Source.Height;
  result := TIEWorkBitmap.Create(width, height, 8);
  for y := 0 to height - 1 do
  begin
    px := result.Scanline[y];
    rgb := Source.Scanline[y];
    for x := 0 to width - 1 do
    begin
      with rgb^ do
        px^ := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
      inc(px);
      inc(rgb);
    end;
  end;
end;

const
  sh_OUTLINE = 25;

type
  tsh_rc = record
    imwidth, imheight: integer;
    b: double;
    high_thresh, low_thresh: double;
    ratio: double;
    window_size: integer;
    do_hysteresis: boolean;
    lap: TIEWorkBitmap;
    nr, nc: integer;
    edges: TIEWorkBitmap;
    thinFactor: integer;
    Progress: TProgressRec;
  end;

procedure sh_embed(var im: TIEWorkBitmap; width: integer; var rc: tsh_rc);
var
  i, j, _I, _J: integer;
  xnew: TIEWorkBitmap;
  pb: pbyte;
begin
  inc(width, 2);
  xnew := TIEWorkBitmap.Create(im.Width + width + width, im.Height + width + width, 8);
  for i := 0 to xnew.Height - 1 do
  begin
    pb := xnew.Scanline[i];
    _I := (i - width + im.Height) mod im.Height;
    for j := 0 to xnew.Width - 1 do
    begin
      _J := (j - width + im.Width) mod im.Width;
      pb^ := im.GetPByte(_I, _J)^;
      inc(pb);
    end;
  end;
  FreeAndNil(im);
  im := xnew;
end;

procedure sh_apply_ISEF_vertical(var x: TIEWorkBitmap; var y: TIEWorkBitmap; var A: TIEWorkBitmap; var B: TIEWorkBitmap; nrows, ncols: integer; var rc: tsh_rc);
var
  row, col: integer;
  b1, b2: double;
  ps1, ps2, ps3: psingle;
begin
  b1 := (1.0 - rc.b) / (1.0 + rc.b);
  b2 := rc.b * b1;
  for col := 0 to ncols - 1 do
  begin
    A.GetPSingle(0, col)^ := b1 * x.GetPSingle(0, col)^;
    B.GetPSingle(nrows - 1, col)^ := b2 * x.GetPSingle(nrows - 1, col)^;
  end;
  for row := 1 to nrows - 1 do
  begin
    ps1 := A.Scanline[row];
    ps2 := A.Scanline[row - 1];
    ps3 := x.Scanline[row];
    for col := 0 to ncols - 1 do
    begin
      ps1^ := b1 * ps3^ + rc.b * ps2^;
      inc(ps1);
      inc(ps2);
      inc(ps3);
    end;
  end;
  for row := nrows - 2 downto 0 do
  begin
    ps1 := B.Scanline[row];
    ps2 := x.Scanline[row];
    ps3 := B.Scanline[row + 1];
    for col := 0 to ncols - 1 do
    begin
      ps1^ := b2 * ps2^ + rc.b * ps3^;
      inc(ps1);
      inc(ps2);
      inc(ps3);
    end;
  end;
  ps1 := y.Scanline[nrows - 1];
  ps2 := A.Scanline[nrows - 1];
  for col := 0 to ncols - 1 do
  begin
    ps1^ := ps2^;
    inc(ps1);
    inc(ps2);
  end;
  for row := 0 to nrows - 2 do
  begin
    ps1 := y.Scanline[row];
    ps2 := A.Scanline[row];
    ps3 := B.Scanline[row + 1];
    for col := 0 to ncols - 1 do
    begin
      ps1^ := ps2^ + ps3^;
      inc(ps1);
      inc(ps2);
      inc(ps3);
    end;
  end;
end;

procedure sh_apply_ISEF_horizontal(var x: TIEWorkBitmap; var y: TIEWorkBitmap; var A: TIEWorkBitmap; var B: TIEWorkBitmap; nrows, ncols: integer; var rc: tsh_rc);
var
  row, col: integer;
  b1, b2: double;
  ps1, ps2, ps3: psingle;
  rlA, rlx, rlB: integer;
begin
  b1 := (1.0 - rc.b) / (1.0 + rc.b);
  b2 := rc.b * b1;
  for row := 0 to nrows - 1 do
  begin
    A.GetPSingle(row, 0)^ := b1 * x.GetPSingle(row, 0)^;
    B.GetPSingle(row, ncols - 1)^ := b2 * x.GetPSingle(row, ncols - 1)^;
  end;
  rlA := A.Rowlen div 4;
  rlx := x.Rowlen div 4;
  rlB := B.Rowlen div 4;
  for col := 1 to ncols - 1 do
  begin
    ps1 := A.GetPSingle(0, col);
    ps2 := x.GetPSingle(0, col);
    ps3 := A.GetPSingle(0, col - 1);
    for row := 0 to nrows - 1 do
    begin
      ps1^ := b1 * ps2^ + rc.b * ps3^;
      dec(ps1, rlA);
      dec(ps2, rlx);
      dec(ps3, rlA);
    end;
  end;
  for col := ncols - 2 downto 0 do
  begin
    ps1 := B.GetPSingle(0, col);
    ps2 := x.GetPSingle(0, col);
    ps3 := B.GetPSingle(0, col + 1);
    for row := 0 to nrows - 1 do
    begin
      ps1^ := b2 * ps2^ + rc.b * ps3^;
      dec(ps1, rlB);
      dec(ps2, rlx);
      dec(ps3, rlB);
    end;
  end;
  for row := 0 to nrows - 1 do
    y.GetPSingle(row, ncols - 1)^ := A.GetPSingle(row, ncols - 1)^;
  for row := 0 to nrows - 1 do
  begin
    ps1 := y.Scanline[row];
    ps2 := A.Scanline[row];
    ps3 := B.Scanline[row];
    inc(ps3);
    for col := 0 to ncols - 2 do
    begin
      ps1^ := ps2^ + ps3^;
      inc(ps1);
      inc(ps2);
      inc(ps3);
    end;
  end;
end;

//	Recursive filter realization of the ISEF (Shen and Castan CVIGP March 1992)

procedure sh_compute_ISEF(var x: TIEWorkBitmap; y: TIEWorkBitmap; nrows, ncols: integer; var rc: tsh_rc);
var
  A, B: TIEWorkBitmap;
begin
  A := TIEWorkBitmap.Create(ncols, nrows, 32);
  B := TIEWorkBitmap.Create(ncols, nrows, 32);
  sh_apply_ISEF_vertical(x, y, A, B, nrows, ncols, rc);
  sh_apply_ISEF_horizontal(y, y, A, B, nrows, ncols, rc);
  FreeAndNil(B);
  FreeAndNil(A);
end;

// compute the band-limited laplacian of the input image

function sh_compute_bli(var buff1: TIEWorkBitmap; var buff2: TIEWorkBitmap; nrows, ncols: integer; var rc: tsh_rc): TIEWorkBitmap;
var
  row, col: integer;
  bli_buffer: TIEWorkBitmap;
  ps1: pbyte;
  ps2, ps3: psingle;
begin
  bli_buffer := TIEWorkBitmap.Create(ncols, nrows, 8);
  zeromemory(bli_buffer.Bits, bli_buffer.Rowlen * bli_buffer.Height);
  for row := 0 to nrows - 1 do
  begin
    ps1 := bli_buffer.Scanline[row];
    ps2 := buff1.Scanline[row];
    ps3 := buff2.Scanline[row];
    for col := 0 to ncols - 1 do
    begin
      if (row < sh_OUTLINE) or (row >= nrows - sh_OUTLINE) or (col < sh_OUTLINE) or (col >= ncols - sh_OUTLINE) then
      begin
        inc(ps1);
        inc(ps2);
        inc(ps3);
        continue;
      end;
      ps1^ := byte((ps2^ - ps3^) > 0);
      inc(ps1);
      inc(ps2);
      inc(ps3);
    end;
  end;
  result := bli_buffer;
end;

function sh_compute_adaptive_gradient(var BLI_buffer: TIEWorkBitmap; var orig_buffer: TIEWorkBitmap; row, col: integer; var rc: tsh_rc): double;
var
  i, j: integer;
  sum_on, sum_off: double;
  avg_on, avg_off: double;
  num_on, num_off: integer;
  wd2: integer;
  ps1: pbyte;
  ps2: psingle;
begin
  sum_on := 0;
  sum_off := 0;
  num_on := 0;
  num_off := 0;
  wd2 := rc.window_size div 2;
  for i := -wd2 to wd2 do
  begin
    ps1 := BLI_buffer.Scanline[row + i];
    inc(ps1, col - wd2);
    ps2 := orig_buffer.Scanline[row + i];
    inc(ps2, col - wd2);
    for j := -wd2 to wd2 do
    begin
      if ps1^ <> 0 then
      begin
        sum_on := sum_on + ps2^;
        inc(num_on);
      end
      else
      begin
        sum_off := sum_off + ps2^;
        inc(num_off);
      end;
      inc(ps1);
      inc(ps2);
    end;
  end;
  if (sum_off <> 0) then
    avg_off := sum_off / num_off
  else
    avg_off := 0;
  if (sum_on <> 0) then
    avg_on := sum_on / num_on
  else
    avg_on := 0;
  result := (avg_off - avg_on);
end;

// finds zero-crossings in laplacian (buff)  orig is the smoothed image

function sh_is_candidate_edge(var buff: TIEWorkBitmap; var orig: TIEWorkBitmap; row, col: integer; var rc: tsh_rc): boolean;
begin
  if (buff.GetPByte(row, col)^ = 1) and (buff.GetPByte(row + 1, col)^ = 0) then
  begin
    result := (orig.GetPSingle(row + 1, col)^ - orig.GetPSingle(row - 1, col)^) > 0;
  end
  else if (buff.GetPByte(row, col)^ = 1) and (buff.GetPByte(row, col + 1)^ = 0) then
  begin
    result := (orig.GetPSingle(row, col + 1)^ - orig.GetPSingle(row, col - 1)^) > 0;
  end
  else if (buff.GetPByte(row, col)^ = 1) and (buff.GetPByte(row - 1, col)^ = 0) then
  begin
    result := (orig.GetPSingle(row + 1, col)^ - orig.GetPSingle(row - 1, col)^) < 0;
  end
  else if (buff.GetPByte(row, col)^ = 1) and (buff.GetPByte(row, col - 1)^ = 0) then
  begin
    result := (orig.GetPSingle(row, col + 1)^ - orig.GetPSingle(row, col - 1)^) < 0;
  end
  else
    result := false;
end;

procedure sh_locate_zero_crossings(var orig: TIEWorkBitmap; var smoothed: TIEWorkBitmap; var bli: TIEWorkBitmap; nrows, ncols: integer; var rc: tsh_rc);
var
  row, col: integer;
  ps1: psingle;
begin
  for row := 0 to nrows - 1 do
  begin
    ps1 := orig.Scanline[row];
    zeromemory(ps1, orig.rowlen);
    inc(ps1, sh_OUTLINE);
    if (row >= sh_OUTLINE) and (row < nrows - sh_OUTLINE) then
      for col := sh_OUTLINE to ncols - 1 - sh_OUTLINE do
      begin
        if (sh_is_candidate_edge(bli, smoothed, row, col, rc)) then
          ps1^ := sh_compute_adaptive_gradient(bli, smoothed, row, col, rc);
        inc(ps1);
      end;
  end;
end;

procedure sh_estimate_thresh(low: pdouble; hi: pdouble; nr, nc: integer; var rc: tsh_rc);
var
  vmax, vmin, scale, x: double;
  i, j, k, count: integer;
  hist: array[0..255] of integer;
  ps1: psingle;
begin
  vmax := abs(rc.lap.GetPSingle(20, 20)^);
  vmin := vmax;
  for i := 0 to nr - 1 do
  begin
    ps1 := rc.lap.Scanline[i];
    for j := 0 to nc - 1 do
    begin
      if (i < sh_OUTLINE) or (i >= nr - sh_OUTLINE) or (j < sh_OUTLINE) or (j >= nc - sh_OUTLINE) then
      begin
        inc(ps1);
        continue;
      end;
      x := ps1^;
      if (vmin > x) then
        vmin := x;
      if (vmax < x) then
        vmax := x;
      inc(ps1);
    end;
  end;
  for k := 0 to 255 do
    hist[k] := 0;
  scale := 256 / (vmax - vmin + 1);
  for i := 0 to nr - 1 do
  begin
    ps1 := rc.lap.Scanline[i];
    for j := 0 to nc - 1 do
    begin
      if (i < sh_OUTLINE) or (i >= nr - sh_OUTLINE) or (j < sh_OUTLINE) or (j >= nc - sh_OUTLINE) then
      begin
        inc(ps1);
        continue;
      end;
      x := ps1^;
      k := trunc(((x - vmin) * scale));
      hist[k] := hist[k] + 1;
      inc(ps1);
    end;
  end;
  k := 255;
  j := trunc(rc.ratio * nr * nc);
  count := hist[255];
  while (count < j) do
  begin
    dec(k);
    if (k < 0) then
      break;
    inc(count, hist[k]);
  end;
  hi^ := k / scale + vmin;
  low^ := (hi^) / 2;
end;

//	return true if it marked something

function sh_mark_connected(i, j, level: integer; var rc: tsh_rc): boolean;
var
  notChainEnd: boolean;
begin
  if (i >= rc.nr) or (i < 0) or (j >= rc.nc) or (j < 0) then
  begin
    result := false;
    exit;
  end;
  if (rc.edges.GetPByte(i, j)^ <> 0) then
  begin
    result := false;
    exit;
  end;
  if (rc.lap.GetPSingle(i, j)^ = 0) then
  begin
    result := false;
    exit;
  end;
  if rc.lap.GetPSingle(i, j)^ > rc.low_thresh then
  begin
    rc.edges.GetPByte(i, j)^ := 1;
  end
  else
  begin
    rc.edges.GetPByte(i, j)^ := 255;
  end;
  notChainEnd := false;
  notChainEnd := notChainEnd or sh_mark_connected(i, j + 1, level + 1, rc);
  notChainEnd := notChainEnd or sh_mark_connected(i, j - 1, level + 1, rc);
  notChainEnd := notChainEnd or sh_mark_connected(i + 1, j + 1, level + 1, rc);
  notChainEnd := notChainEnd or sh_mark_connected(i + 1, j, level + 1, rc);
  notChainEnd := notChainEnd or sh_mark_connected(i + 1, j - 1, level + 1, rc);
  notChainEnd := notChainEnd or sh_mark_connected(i - 1, j - 1, level + 1, rc);
  notChainEnd := notChainEnd or sh_mark_connected(i - 1, j, level + 1, rc);
  notChainEnd := notChainEnd or sh_mark_connected(i - 1, j + 1, level + 1, rc);
  if (notChainEnd and (level > 0)) then
  begin
    if (rc.thinFactor > 0) then
      if ((level mod rc.thinFactor) <> 0) then
      begin
        rc.edges.GetPByte(i, j)^ := 255;
      end;
  end;
  result := true;
end;

procedure sh_threshold_edges(var xin: TIEWorkbitmap; var xout: TIEWorkBitmap; nrows, ncols: integer; var rc: tsh_rc);
var
  i, j: integer;
  pb1: pbyte;
  ps1: psingle;
begin
  rc.lap := xin;
  rc.edges := xout;
  rc.nr := nrows;
  rc.nc := ncols;
  sh_estimate_thresh(@rc.low_thresh, @rc.high_thresh, rc.nr, rc.nc, rc);
  if (not rc.do_hysteresis) then
    rc.low_thresh := rc.high_thresh;
  for i := 0 to nrows - 1 do
  begin
    pb1 := rc.edges.Scanline[i];
    for j := 0 to ncols - 1 do
    begin
      //rc.edges.GetPByte(i,j)^ := 0;
      pb1^ := 0;
      inc(pb1);
    end;
  end;
  for i := 0 to nrows - 1 do
  begin
    ps1 := rc.lap.Scanline[i];
    for j := 0 to ncols - 1 do
    begin
      if (i < sh_OUTLINE) or (i >= nrows - sh_OUTLINE) or (j < sh_OUTLINE) or (j >= ncols - sh_OUTLINE) then
      begin
        inc(ps1);
        continue;
      end;
      //if ((rc.lap.GetPSingle(i,j)^) > rc.high_thresh) then
      if ((ps1^) > rc.high_thresh) then
        sh_mark_connected(i, j, 0, rc);
      inc(ps1);
    end;
  end;
  for i := 0 to nrows - 1 do
  begin
    pb1 := rc.edges.Scanline[i];
    for j := 0 to ncols - 1 do
    begin
      if (pb1^ = 255) then
        pb1^ := 0;
      inc(pb1);
    end;
  end;
end;

procedure sh_shen(var im: TIEWorkBitmap; var res: TIEWorkBitmap; var rc: tsh_rc);
var
  i, j: integer;
  buffer: TIEWorkBitmap;
  smoothed_buffer: TIEWorkBitmap;
  bli_buffer: TIEWorkBitmap;
  ps1: psingle;
  pb1: pbyte;
begin
  rc.Progress.per1 := 100 / 6;
  buffer := TIEWorkBitmap.Create(im.Width, im.Height, 32); // bitmap of float points
  for i := 0 to im.height - 1 do
  begin
    ps1 := buffer.scanline[i];
    pb1 := im.scanline[i];
    for j := 0 to im.width - 1 do
    begin
      ps1^ := pb1^;
      inc(ps1);
      inc(pb1);
    end;
  end;
  with rc.Progress do
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (1)));
  // 1
  smoothed_buffer := TIEWorkBitmap.Create(im.Width, im.Height, 32);
  sh_compute_ISEF(buffer, smoothed_buffer, im.Height, im.Width, rc);
  with rc.Progress do
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (2)));
  // 2
  bli_buffer := sh_compute_bli(smoothed_buffer, buffer, im.Height, im.Width, rc);
  with rc.Progress do
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (3)));
  // 3
  sh_locate_zero_crossings(buffer, smoothed_buffer, bli_buffer, im.Height, im.Width, rc);
  with rc.Progress do
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (4)));
  // 4
  FreeAndNil(smoothed_buffer);
  FreeAndNil(bli_buffer);
  sh_threshold_edges(buffer, res, im.Height, im.Width, rc);
  with rc.Progress do
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (5)));
  // 5
  for i := 0 to im.Height - 1 do
  begin
    pb1 := res.scanline[i];
    for j := 0 to im.Width - 1 do
    begin
      if (pb1^ > 0) then
        pb1^ := 0
      else
        pb1^ := 255;
      inc(pb1);
    end;
  end;
  FreeAndNil(buffer);
  with rc.Progress do
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (6)));
end;

procedure sh_debed2(var im: TIEWorkBitmap; Bitmap: TIEBitmap; width: integer; var rc: tsh_rc);
var
  i, j: integer;
  hh, ww: integer;
  pb: pbyte;
begin
  inc(width, 2);
  ww := im.Width - width - width;
  hh := im.Height - width - width;
  Bitmap.Allocate(ww, hh, ie1g);
  for i := 0 to hh - 2 do
  begin
    pb := Bitmap.Scanline[i];
    for j := 1 to ww - 1 do
      _SetPixelbw(pb, j, im.GetPByte(i + width, j + width)^);
    _SetPixelbw(pb, 0, 255);
  end;
  pb := Bitmap.Scanline[hh - 1];
  for j := 0 to ww - 1 do
    _SetPixelbw(pb, j, 255);
end;

// SrcBitmap and DstBitmap can refer to some bitmap object

procedure _IEEdgeDetect_ShenCastan(SrcBitmap, DstBitmap: TIEBitmap; Ratio: double; Smooth: double; WindowSize: integer; ThinFactor: integer; DoHysteresis: boolean; var Progress: TProgressRec);
var
  rc: tsh_rc;
  im, res: TIEWorkBitmap;
begin
  fillchar(rc, sizeof(tsh_rc), 0);
  with rc do
  begin
    imwidth := SrcBitmap.Width;
    imheight := SrcBitmap.Height;
    b := Smooth;
    low_thresh := 20;
    high_thresh := 22;
    window_size := WindowSize;
    do_hysteresis := DoHysteresis;
  end;
  rc.Progress := Progress;
  rc.Ratio := Ratio;
  rc.thinFactor := ThinFactor;
  im := sh_CreateGrayPixMap(SrcBitmap);
  sh_embed(im, sh_OUTLINE, rc);
  res := TIEWorkBitmap.Create(im.Width, im.Height, 8);
  sh_shen(im, res, rc);
  sh_debed2(res, DstBitmap, sh_OUTLINE, rc);
  FreeAndNil(res);
  FreeAndNil(im);
end;

{!!
<FS>TImageEnProc.EdgeDetect_ShenCastan

<FM>Declaration<FC>
procedure EdgeDetect_ShenCastan(Ratio:double; Smooth:double; WindowSize:integer; ThinFactor:integer; DoHysteresis:boolean);

<FM>Description<FN>
EdgeDetect_ShenCastan converts the current color image to black/white (1 bit) with a Shen-Castan (ISEF) edge detection algorithm.

Shen-Castan algorithm convolves the image with the Infinite Symmetric Exponential Filter, computes the binary Laplacian image, suppresses false zero crossing, performs adaptive gradient thresholding, and, finally, also applies hysteresis thresholding. (Algorithms for Image Processing and Computer Vision - J.R.Parker).

Ratio : percent of pixels to be above High threshold (suggested 0.99)
Smooth : Smoothing factor (suggested 0.9)
WindowSize : Size of window for adaptive gradient (suggested 7)
ThinFactor : Thinning factor (suggested 0)
DoHysteresis : If True tun on the hysteresis thresholding (suggested True)

<FM>Example<FC>

ImageEnView1.Proc.EdgeDetect_ShenCastan(0.99,0.9,7,0,true);

!!}
procedure TImageEnProc.EdgeDetect_ShenCastan(Ratio: double; Smooth: double; WindowSize: integer; ThinFactor: integer; DoHysteresis: boolean);
var
  Progress: TProgressRec;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_EDGEDETECT, ieuImage);
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  _IEEdgeDetect_ShenCastan(fIEBitmap, fIEBitmap, Ratio, Smooth, WindowSize, ThinFactor, DoHysteresis, Progress);
  Update;
  DoFinishWork;
end;

// end of Shen-Castan edge detector
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Skew Detection

function _iehough(image: TIEBitmap; var Progress: TProgressRec; anglerange: integer; Precision: Double): double;
const
  conv: double = 3.1415926535 / 180;
  ar: array[-1..1] of integer = (-1, 1, -1);
var
  z: TIEWorkBitmap;
  r1, r2, r, rr, center_x, center_y, i, s, j, jj, jj8, rl, rmax, rmax2, tmax: integer;
  oc: double;
  tmval: integer;
  nc, nr, om, omi, omr: integer;
  row: pbyte;
  pf: pinteger;
  precmul: Integer;
  s1, s2, totaldegrees: Integer;
  px, ps: pinteger;
  ksin, kcos: pintegerarray;
  dsin, dcos: pdoublearray;
begin
  result := 0;
  if image.pixelformat <> ie1g then
    exit;
  Precision := trunc(Precision * 10) / 10; // allow only first decimal digit
  if (Precision < 0.1) or (Precision > 1) then
    exit;
  if (AngleRange < 0) or (AngleRange > 180) then
    exit;
  precmul := round(1 / Precision);
  Precision := (1 / PrecMul) * conv; // now is in radians
  totaldegrees := 180 * precmul;
  nc := image.Width;
  nr := image.Height;
  center_x := nc div 2;
  center_y := nr div 2;
  rmax := trunc(sqrt(nc * nc + nr * nr) / 2);
  z := TIEWorkBitmap.Create(2 * rmax + 1, totaldegrees, 32);
  ZeroMemory(z.Bits, z.Height * z.RowLen);
  omr := (anglerange * precmul) div 2;
  omi := (totaldegrees div 2);
  Progress.per1 := 100 / (nr);
  getmem(ksin, sizeof(integer) * 1800);
  getmem(kcos, sizeof(integer) * 1800);
  getmem(dsin, sizeof(double) * 1800);
  getmem(dcos, sizeof(double) * 1800);
  oc := 0;
  for om := 0 to 1799 do
  begin
    ksin[om] := trunc(sin(oc) * 131072);
    kcos[om] := trunc(cos(oc) * 131072);
    dsin[om] := sin(oc);
    dcos[om] := cos(oc);
    oc := oc + Precision;
  end;
  rl := IEBitmapRowLen(image.width, 1, 32);
  for i := 0 to nr - 1 do
  begin
    row := image.Scanline[i];
    jj := 0;
    while jj < rl do
    begin
      if (row^ < 255) then
      begin
        jj8 := jj * 8;
        for j := 0 to 7 do
          if row^ and iebitmask1[j] = 0 then
          begin // found a "black"
            om := omi - omr;
            while om < omi + omr - 1 do
            begin
              r1 := (i - center_y) * ksin[om];
              if r1 < 0 then
              begin
                r1 := -r1;
                s1 := r1 and $1FFFF;
                r1 := -(r1 shr 17);
                if s1 > 65535 then
                  dec(r1);
              end
              else
              begin
                s1 := r1 and $1FFFF;
                r1 := r1 shr 17;
                if s1 > 65535 then
                  inc(r1);
              end;
              r2 := (jj8 + j - center_x) * kcos[om];
              if r2 < 0 then
              begin
                r2 := -r2;
                s2 := r2 and $1FFFF;
                r2 := -(r2 shr 17);
                if s2 > 65535 then
                  dec(r2);
              end
              else
              begin
                s2 := r2 and $1FFFF;
                r2 := r2 shr 17;
                if s2 > 65535 then
                  inc(r2);
              end;

              with z do
                px := pinteger(int64(DWORD(Bits)) + int64((Height - om - 1) * Rowlen + (rmax + r1 + r2) * 4));
              inc(px^);
              inc(om);
            end;
          end;
      end;
      inc(jj);
      inc(row);
    end;
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (i)));
  end;
  tmax := 0;
  tmval := 0;
  rmax2 := 2 * rmax;
  for i := (omi - omr) to omi + omr - 1 do
  begin
    pf := z.Scanline[i];
    for j := 0 to rmax2 do
    begin
      if pf^ > tmval then
      begin
        tmval := pf^;
        tmax := i;
      end;
      inc(pf);
    end;
  end;
  result := tmax / PrecMul - 90;
  FreeAndNil(z);
  freemem(ksin);
  freemem(kcos);
  freemem(dsin);
  freemem(dcos);
end;

function _IESkewDetection(Bitmap:TIEBitmap; ResampleWidth: integer; AngleRange: integer; Precision: double; EdgeDetect: boolean; fOnProgress: TIEProgressEvent; Sender: TObject): double;
var
  tmpbmp: TIEBitmap;
  nullpr: TProgressRec;
  Progress: TProgressRec;
begin
  with nullpr do
  begin
    fOnProgress := nil;
    Sender := nil;
  end;
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Sender;
  if (ResampleWidth > 0) and (ResampleWidth <> Bitmap.Width) then
  begin
    tmpbmp := TIEBitmap.Create;
    tmpbmp.Allocate(ResampleWidth, (Bitmap.Height * ResampleWidth) div Bitmap.Width, Bitmap.pixelformat);
    if tmpbmp.Pixelformat = ie1g then
    begin
      if EdgeDetect then
      begin
        tmpbmp.Allocate(tmpbmp.Width, tmpbmp.Height, ie24RGB);
        _Resample1BitEx(Bitmap, tmpbmp, rfFastLinear);
      end
      else
        _IEBmpStretchEx(Bitmap, tmpbmp, nil, nil);
    end
    else
      _ResampleEx(Bitmap, tmpbmp, rfFastLinear, nil, nil);
    if EdgeDetect then
      _IEEdgeDetect_ShenCastan(tmpbmp, tmpbmp, 0.99, 0.9, 7, 0, true, nullpr);
  end
  else
  begin
    if Bitmap.PixelFormat = ie1g then
    begin
      if EdgeDetect then
      begin
        tmpbmp := TIEBitmap.Create;
        _Conv1To24Ex(Bitmap, tmpbmp, nullpr);
        _IEEdgeDetect_ShenCastan(tmpbmp, tmpbmp, 0.99, 0.9, 7, 0, true, nullpr);
      end
      else
        tmpbmp := Bitmap;
    end
    else
    begin
      tmpbmp := TIEBitmap.Create;
      _IEEdgeDetect_ShenCastan(Bitmap, tmpbmp, 0.99, 0.9, 7, 0, true, nullpr);
    end;
  end;
  result := _iehough(tmpbmp, Progress, AngleRange, Precision);
  if tmpbmp <> Bitmap then
    FreeAndNil(tmpbmp);
end;

// If ResampleWidth is Zero (0) doesn't resample original image (more slow)

{!!
<FS>TImageEnProc.SkewDetection

<FM>Declaration<FC>
function SkewDetection(ResampleWidth:integer; AngleRange:integer; Precision:double; EdgeDetect:boolean):double;

<FM>Description<FN>
SkewDetection estimates the orientation angle (in degrees) of the lines of text. Apply this method only to images that contains printed text.
If there is a selected area, SkewDetection works only on this one.

SkewDetection can be very slow on large images, so applications can resample analyzed image using ResampleWidth parameter to enhance performance. No resampling is performed when ResampleWidth is zero.
AngleRange specifies the working range in degrees. Low values enhance performance and accuracy. For example specifying 30 SkewDetection will scan the image searching for pixels inside a range of -15 to 15 degrees. AngleRange can be from 1 to 180.
Precision specifies the angle precision in degrees. It must be >0 and <=1 with only one decimal digit. Typical value is 0.1.
EdgeDetect specifies if to apply and edge detect algorithm before detect the orientation.

<FM>Example<FC>

// this example adjust image orientation with range -15 to 15 and 0.1 degrees of precision
Var angle:double;
begin
  angle:=ImageEnView1.Proc.SkewDetection( ImageEnView1.Bitmap.Width div 4, 30,0.1,false);
  ImageEnView1.Proc.Rotate( angle, true );
End;

!!}
function TImageEnProc.SkewDetection(ResampleWidth: integer; AngleRange: integer; Precision: double; EdgeDetect: boolean): double;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  result:=0;
  if not BeginImageAnalysis([ie24RGB,ie1g], x1, y1, x2, y2, ProcBitmap, mask) then
    exit;
  result := _IESkewDetection(ProcBitmap,ResampleWidth,AngleRange,Precision,EdgeDetect,fOnProgress,Self);
  EndImageAnalysis(ProcBitmap);
  DoFinishWork;
end;

// Skew Detection
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnProc.Fill

<FM>Declaration<FC>
procedure Fill(FillColor:<A TRGB>);
procedure Fill(FillColor:TColor);

<FM>Description<FN>
Fill sets all colors of the selected area with FillColor color. For black/white images FillColor can be only (0,0,0) for black and (255,255,255) for white.

<FM>Example<FC>

ImageEnView1.Proc.Fill( CreateRGB(127,50,200) );

!!}
procedure TImageEnProc.Fill(FillColor: TRGB);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([], x1, y1, x2, y2, Format(IERS_FILL, [FillColor.r, FillColor.g, FillColor.b]), ProcBitmap, mask) then
    exit;
  _Fill(ProcBitmap, x1, y1, x2, y2, FillColor, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure TImageEnProc.Fill(FillColor:TColor);
begin
  Fill( TColor2TRGB(FillColor) );
end;

// on ie1g images FillColor can be only (0,0,0) for black and (255,255,255) for white
procedure _Fill(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; FillColor: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  col, row: integer;
  ppx: pRGB;
  per1: double;
  bx: pbyte;
  tb: byte;
  bb: integer;
  bw: boolean;
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  case bitmap.Pixelformat of
    ie24RGB:
      begin
        // ie24RGB
        for row := fSelY1 to fSelY2 do
        begin
          ppx := bitmap.ScanLine[row];
          inc(ppx, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            ppx^.r := FillColor.r;
            ppx^.g := FillColor.g;
            ppx^.b := FillColor.b;
            inc(ppx);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      end;
    ie8g:
      begin
        // ie8g
        with FillColor do
          bb := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
        for row := fSelY1 to fSelY2 do
        begin
          bx := bitmap.ScanLine[row];
          inc(bx, fSelX1);
          for col := fSelX1 to fSelX2 do
          begin
            bx^ := bb;
            inc(bx);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      end;
    ie1g:
      begin
        // ie1g
        bw := (FillColor.r <> 0);
        for row := fSelY1 to fSelY2 do
        begin
          bx := Bitmap.Scanline[row];
          inc(bx, fSelX1 shr 3);
          bb := 7 - (fSelX1 and 7);
          tb := bx^;
          for col := fSelX1 to fSelX2 do
          begin
            if bw then
              tb := tb or (1 shl bb)
            else
              tb := tb and not (1 shl bb);
            dec(bb);
            if bb = -1 then
            begin
              bx^ := tb;
              inc(bx);
              tb := bx^;
              bb := 7;
            end;
          end;
          if bb < 7 then
            bx^ := tb;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
        end;
      end;
    else
      Bitmap.FillRect(fSelX1, fSelY1, fSelX2, fSelY2, TRGB2TColor(FillColor));
  end;  // end case
end;

// Src and Dst must be ie24RGB
procedure _ResampleLinearEx(Src, Dst: TIEBaseBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  zx, zy, rold, d: double;
  iold, iold2, x, y, idiff, xx, yy: integer;
  a, mm_r, mm_g, mm_b, mc: integer;
  OldWidth, OldHeight, NewWidth, NewHeight: integer;
  OldImRow, NewImRow, OldImRow2: PRGBROW;
  OldScanline: ppointerarray;
  bmp1: TIEWorkBitmap;
  darr1: pintegerarray;
  iarr1, iarr2: pintegerarray;
  per1: double;
begin
  if (Src.Width=0) or (Src.Height=0) or (Dst.Width=0) or (Dst.Height=0) then
    exit;
  OldWidth := Src.Width;
  OldHeight := Src.Height;
  NewWidth := Dst.Width;
  NewHeight := Dst.Height;
  zx := NewWidth / OldWidth;
  zy := NewHeight / OldHeight;
  if (zx = 1) and (zy = 1) then
  begin
    Dst.Assign(Src);
    exit;
  end;
  getmem(darr1, sizeof(integer) * NewWidth);
  getmem(iarr1, sizeof(integer) * NewWidth);
  getmem(iarr2, sizeof(integer) * NewWidth);
  for x := 0 to NewWidth - 1 do
  begin
    d := x / zx;
    iarr1[x] := trunc(d);
    darr1[x] := trunc((d - iarr1[x]) * 131072); // 2^17
    iarr2[x] := trunc(imin(x + 1, NewWidth - 1) / zx + 0.0000000001); // the 0.0000000001 avoids a Delphi math bug
  end;
  bmp1 := TIEWorkBitmap.Create(NewWidth, OldHeight, 24);
  ////// horizontal
  per1 := 100 / (OldHeight + NewHeight + 0.5);
  if zx > 1 then
  begin
    // zoom-in (linear interpolation)
    for y := 0 to OldHeight - 1 do
    begin
      OldImRow := Src.Scanline[y];
      NewImRow := bmp1.Scanline[y];
      for x := 0 to NewWidth - 1 do
      begin
        iold := iarr1[x];
        idiff := darr1[x];
        iold2 := imin(iold + 1, OldWidth - 1);
        // r
        a := OldImRow[iold].r;
        NewImRow[x].r := a + (((OldImRow[iold2].r - a) * idiff) shr 17);
        // g
        a := OldImRow[iold].g;
        NewImRow[x].g := a + (((OldImRow[iold2].g - a) * idiff) shr 17);
        // b
        a := OldImRow[iold].b;
        NewImRow[x].b := a + (((OldImRow[iold2].b - a) * idiff) shr 17);
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end;
  end
  else
  begin
    // zoom-out (median)
    for y := 0 to OldHeight - 1 do
    begin
      OldImRow := Src.Scanline[y];
      NewImRow := bmp1.Scanline[y];
      for x := 0 to NewWidth - 1 do
      begin
        iold := iarr1[x];
        iold2 := iarr2[x];
        mm_r := 0;
        mm_g := 0;
        mm_b := 0;
        mc := 0;
        for xx := iold to iold2 do
        begin
          with OldImRow[xx] do
          begin
            inc(mm_r, r);
            inc(mm_g, g);
            inc(mm_b, b);
          end;
          inc(mc);
        end;
        with NewImRow[x] do
        begin
          r := mm_r div mc;
          g := mm_g div mc;
          b := mm_b div mc;
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end;
  end;
  // vertical
  if zy > 1 then
  begin
    // zoom-in (linear interpolation)
    for y := 0 to NewHeight - 1 do
    begin
      rold := y / zy;
      iold := trunc(rold);
      idiff := trunc((rold - iold) * 131072); // 2^17
      OldImRow := bmp1.Scanline[iold];
      NewImRow := Dst.Scanline[y];
      if iold + 1 < OldHeight then
        OldImRow2 := bmp1.Scanline[iold + 1]
      else
        OldImRow2 := OldImRow;
      for x := 0 to NewWidth - 1 do
      begin
        // r
        a := OldImRow[x].r;
        NewImRow[x].r := a + (((OldImRow2[x].r - a) * idiff) shr 17);
        // b
        a := OldImRow[x].b;
        NewImRow[x].b := a + (((OldImRow2[x].b - a) * idiff) shr 17);
        // g
        a := OldImRow[x].g;
        NewImRow[x].g := a + (((OldImRow2[x].g - a) * idiff) shr 17);
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + OldHeight)));
    end;
  end
  else
  begin
    // zoom-out (median)
    getmem(OldScanline, sizeof(pointer) * OldHeight);
    for y := 0 to OldHeight - 1 do
      OldScanline[y] := bmp1.Scanline[y];
    for y := 0 to NewHeight - 1 do
    begin
      iold := trunc(y / zy);
      iold2 := trunc(imin(y + 1, NewHeight - 1) / zy);
      NewImRow := Dst.Scanline[y];
      for x := 0 to NewWidth - 1 do
      begin
        mm_r := 0;
        mm_g := 0;
        mm_b := 0;
        mc := 0;
        for yy := iold to iold2 do
        begin
          OldImRow := OldScanline[yy];
          with OldImRow[x] do
          begin
            inc(mm_r, r);
            inc(mm_g, g);
            inc(mm_b, b);
          end;
          inc(mc);
        end;
        with NewImRow[x] do
        begin
          r := mm_r div mc;
          g := mm_g div mc;
          b := mm_b div mc;
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + OldHeight)));
    end;
    freemem(OldScanline);
  end;
  FreeAndNil(bmp1);
  freemem(darr1);
  freemem(iarr1);
  freemem(iarr2);
end;

// destBmp must be ie1g
procedure _ResampleProject1Bit(origBmp, DestBmp: TIEBaseBitmap; Negative:boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y, sx, sy, psx, psy: integer;
  zx, zy: double;
  l1, l2: TIEDataAccess;
  per1: double;
  dst:pbyte;
  xx,yy:integer;
  arx:pintegerarray;
  brk:boolean;
  row,bp:pbyte;
begin
  if DestBmp.PixelFormat<>ie1g then
    DestBmp.Allocate( DestBmp.Width, DestBmp.Height, ie1g);

  per1 := 100 / (destBmp.Height + 0.5);
  l1 := origBmp.Access;
  l2 := destBmp.Access;
  origBmp.Access := [iedRead];
  destBmp.Access := [iedWrite];
  zx := origBmp.Width / destBmp.Width;
  zy := origBmp.Height / destBmp.Height;

  getmem(arx,sizeof(integer)*destBmp.Width);
  for x:=0 to destBmp.Width-1 do
    arx[x]:=trunc(x*zx);

  if Negative then
  begin

    for y := 0 to destBmp.Height - 1 do
    begin
      dst := destBmp.Scanline[y];
      fillchar(dst^,destBmp.RowLen,0);
      if y>0 then
      begin
        psy := trunc((y-1) * zy);
        sy := trunc(y * zy);
      end
      else
      begin
        psy := 0;
        sy := 0;
      end;
      for x := 0 to destBmp.Width - 1 do
      begin
        if x>0 then
        begin
          psx := arx[x-1];
          sx  := arx[x];
        end
        else
        begin
          psx:=0;
          sx:=0;
        end;
        brk:=false;
        for yy:=psy to sy do
        begin
          row:=origBmp.Scanline[yy];
          for xx:=psx to sx do
          begin
            if pbytearray(row)^[xx shr 3] and iebitmask1[xx and $7] <> 0 then
            begin
              bp:=pbyte(int64(DWORD(dst)) + (int64(x) shr 3));
              bp^ := bp^ or iebitmask1[x and 7];  // set to 1
              brk:=true;
              break;
            end;
          end;
          if brk then
            break;
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end

  end
  else
  begin

    for y := 0 to destBmp.Height - 1 do
    begin
      dst := destBmp.Scanline[y];
      fillchar(dst^,destBmp.RowLen,255);
      if y>0 then
      begin
        psy := trunc((y-1) * zy);
        sy := trunc(y * zy);
      end
      else
      begin
        psy := 0;
        sy := 0;
      end;
      for x := 0 to destBmp.Width - 1 do
      begin
        if x>0 then
        begin
          psx := arx[x-1];
          sx  := arx[x];
        end
        else
        begin
          psx:=0;
          sx:=0;
        end;
        brk:=false;
        for yy:=psy to sy do
        begin
          row:=origBmp.Scanline[yy];
          for xx:=psx to sx do
          begin
            if pbytearray(row)^[xx shr 3] and iebitmask1[xx and $7] = 0 then
            begin
              bp:=pbyte(int64(DWORD(dst)) + (int64(x) shr 3));
              bp^ := bp^ and not iebitmask1[x and 7]; // set to 0
              brk:=true;
              break;
            end;
          end;
          if brk then
            break;
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end;

  end;

  freemem(arx);

  origBmp.Access := l1;
  destBmp.Access := l2;
end;

// destBmp must be ie1g
procedure _ResampleProject24Bit(origBmp, DestBmp: TIEBaseBitmap; Negative:boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y, sx, sy, psx, psy: integer;
  zx, zy: double;
  l1, l2: TIEDataAccess;
  per1: double;
  dst:pbyte;
  xx,yy:integer;
  arx:pintegerarray;
  row:PRGB;
  bp:pbyte;
begin
  if DestBmp.PixelFormat<>ie1g then
    DestBmp.Allocate( DestBmp.Width, DestBmp.Height, ie1g);

  per1 := 100 / (destBmp.Height + 0.5);
  l1 := origBmp.Access;
  l2 := destBmp.Access;
  origBmp.Access := [iedRead];
  destBmp.Access := [iedWrite];
  zx := origBmp.Width / destBmp.Width;
  zy := origBmp.Height / destBmp.Height;

  getmem(arx,sizeof(integer)*destBmp.Width);
  for x:=0 to destBmp.Width-1 do
    arx[x]:=trunc(x*zx);

  if Negative then
  begin

    for y := 0 to destBmp.Height - 1 do
    begin
      dst := destBmp.Scanline[y];
      fillchar(dst^,destBmp.RowLen,0);
      if y>0 then
      begin
        psy := trunc((y-1) * zy);
        sy := trunc(y * zy);
      end
      else
      begin
        psy := 0;
        sy := 0;
      end;
      for x := 0 to destBmp.Width - 1 do
      begin
        if x>0 then
        begin
          psx := arx[x-1];
          sx  := arx[x];
        end
        else
        begin
          psx:=0;
          sx:=0;
        end;
        for yy:=psy to sy do
        begin
          row:=origBmp.Scanline[yy]; inc(row,psx);
          for xx:=psx to sx do
          begin
            if (row^.r>128) and (row^.g>128) and (row^.b>128) then
            begin
              bp:=pbyte(int64(DWORD(dst)) + (int64(x) shr 3));
              bp^ := bp^ or iebitmask1[x and 7];  // set to 1
            end;
            inc(row);
          end;
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end;


  end
  else
  begin

    for y := 0 to destBmp.Height - 1 do
    begin
      dst := destBmp.Scanline[y];
      fillchar(dst^,destBmp.RowLen,255);
      if y>0 then
      begin
        psy := trunc((y-1) * zy);
        sy := trunc(y * zy);
      end
      else
      begin
        psy := 0;
        sy := 0;
      end;
      for x := 0 to destBmp.Width - 1 do
      begin
        if x>0 then
        begin
          psx := arx[x-1];
          sx  := arx[x];
        end
        else
        begin
          psx:=0;
          sx:=0;
        end;
        for yy:=psy to sy do
        begin
          row:=origBmp.Scanline[yy]; inc(row,psx);
          for xx:=psx to sx do
          begin
            if (row^.r<128) and (row^.g<128) and (row^.b<128) then
            begin
              bp:=pbyte(int64(DWORD(dst)) + (int64(x) shr 3));
              bp^ := bp^ and not iebitmask1[x and 7]; // set to 0
            end;
            inc(row);
          end;
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end;

  end;

  freemem(arx);

  origBmp.Access := l1;
  destBmp.Access := l2;
end;


// for zoom-out call _SubResample1bitFilteredEx
// Src must be 1bit
// Dst must be 24bit
procedure _ResampleLinear1BitEx(Src, Dst: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  zx, zy, rold, d: double;
  iold, iold2, x, y, idiff: integer;
  OldWidth, OldHeight, NewWidth, NewHeight: integer;
  SrcImRow: pbyte;
  OldImRow, NewImRow, OldImRow2: PRGBROW;
  OldScanline: ppointerarray;
  bmp1: TIEWorkBitmap;
  darr1: pintegerarray;
  iarr1: pintegerarray;
  per1: double;
  v1, v2: integer;
begin
  OldWidth := Src.Width;
  OldHeight := Src.Height;
  NewWidth := Dst.Width;
  NewHeight := Dst.Height;
  zx := NewWidth / OldWidth;
  zy := NewHeight / OldHeight;
  if (zx = 1) and (zy = 1) then
  begin
    Dst.Assign(Src);
    exit;
  end;
  if (zx < 1) and (zy < 1) then
  begin
    _SubResample1bitFilteredEx(Src, 0, 0, Src.Width - 1, Src.Height - 1, Dst);
    exit;
  end;
  getmem(darr1, sizeof(integer) * NewWidth);
  getmem(iarr1, sizeof(integer) * NewWidth);
  for x := 0 to NewWidth - 1 do
  begin
    d := x / zx;
    iarr1[x] := trunc(d);
    darr1[x] := trunc((d - iarr1[x]) * 131072); // 2^17
  end;
  bmp1 := TIEWorkBitmap.Create(NewWidth, OldHeight, 24);
  ////// horizontal
  per1 := 100 / (OldHeight + NewHeight + 0.5);
  for y := 0 to OldHeight - 1 do
  begin
    SrcImRow := Src.Scanline[y];
    NewImRow := bmp1.Scanline[y];
    for x := 0 to NewWidth - 1 do
    begin
      iold := iarr1[x];
      idiff := darr1[x];
      iold2 := imin(iold + 1, OldWidth - 1);
      v1 := pbytearray(SrcImRow)^[iold2 shr 3] and iebitmask1[iold2 and $7];
      if v1 <> 0 then
        v1 := 255
      else
        v1 := 0;
      v2 := pbytearray(SrcImRow)^[iold shr 3] and iebitmask1[iold and $7];
      if v2 <> 0 then
        v2 := 255
      else
        v2 := 0;
      with NewImRow[x] do
      begin
        r := v2 + (((v1 - v2) * idiff) shr 17);
        b := r;
        g := r;
      end;
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * y));
  end;
  // vertical
  for y := 0 to NewHeight - 1 do
  begin
    rold := y / zy;
    iold := trunc(rold);
    idiff := trunc((rold - iold) * 131072); // 2^17
    OldImRow := bmp1.Scanline[iold];
    NewImRow := Dst.Scanline[y];
    if iold + 1 < OldHeight then
      OldImRow2 := bmp1.Scanline[iold + 1]
    else
      OldImRow2 := OldImRow;
    for x := 0 to NewWidth - 1 do
    begin
      v1 := OldImRow[x].r;
      with NewImRow[x] do
      begin
        r := v1 + (((OldImRow2[x].r - v1) * idiff) shr 17);
        g := r;
        b := r;
      end;
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y + OldHeight)));
  end;
  FreeAndNil(bmp1);
  freemem(darr1);
  freemem(iarr1);
end;

// Src and Dst must 8 bit

procedure _ResampleLinearAlpha(Src, Dst: TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  zx, zy, rold, d: double;
  iold, iold2, x, y, idiff, xx, yy: integer;
  a, mm, mc: integer;
  OldWidth, OldHeight, NewWidth, NewHeight: integer;
  OldImRow, NewImRow, OldImRow2: pbytearray;
  OldScanline: ppointerarray;
  bmp1: TIEWorkBitmap;
  darr1: pintegerarray;
  iarr1, iarr2: pintegerarray;
  per1: double;
begin
  OldWidth := Src.Width;
  OldHeight := Src.Height;
  NewWidth := Dst.Width;
  NewHeight := Dst.Height;
  zx := NewWidth / OldWidth;
  zy := NewHeight / OldHeight;
  if (zx = 1) and (zy = 1) then
  begin
    Dst.Assign(Src);
    exit;
  end;
  getmem(darr1, sizeof(integer) * NewWidth);
  getmem(iarr1, sizeof(integer) * NewWidth);
  getmem(iarr2, sizeof(integer) * NewWidth);
  for x := 0 to NewWidth - 1 do
  begin
    d := x / zx;
    iarr1[x] := trunc(d);
    darr1[x] := trunc((d - iarr1[x]) * 131072); // 2^17
    iarr2[x] := trunc(imin(x + 1, NewWidth - 1) / zx + 0.0000000001); // the 0.0000000001 avoid a math problem of Delphi
  end;
  bmp1 := TIEWorkBitmap.Create(NewWidth, OldHeight, 8);
  ////// horizontal
  per1 := 100 / (OldHeight + NewHeight + 0.5);
  if zx > 1 then
  begin
    // zoom-in (linear interpolation)
    for y := 0 to OldHeight - 1 do
    begin
      OldImRow := Src.Scanline[y];
      NewImRow := bmp1.Scanline[y];
      for x := 0 to NewWidth - 1 do
      begin
        iold := iarr1[x];
        idiff := darr1[x];
        iold2 := imin(iold + 1, OldWidth - 1);
        a := OldImRow[iold];
        NewImRow[x] := a + (((OldImRow[iold2] - a) * idiff) shr 17);
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end;
  end
  else
  begin
    // zoom-out (median)
    for y := 0 to OldHeight - 1 do
    begin
      OldImRow := Src.Scanline[y];
      NewImRow := bmp1.Scanline[y];
      for x := 0 to NewWidth - 1 do
      begin
        iold := iarr1[x];
        iold2 := iarr2[x];
        mm := 0;
        mc := 0;
        for xx := iold to iold2 do
        begin
          inc(mm, OldImRow[xx]);
          inc(mc);
        end;
        NewImRow[x] := mm div mc;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * y));
    end;
  end;
  // vertical
  if zy > 1 then
  begin
    // zoom-in (linear interpolation)
    for y := 0 to NewHeight - 1 do
    begin
      rold := y / zy;
      iold := trunc(rold);
      idiff := trunc((rold - iold) * 131072); // 2^17
      OldImRow := bmp1.Scanline[iold];
      NewImRow := Dst.Scanline[y];
      if iold + 1 < OldHeight then
        OldImRow2 := bmp1.Scanline[iold + 1]
      else
        OldImRow2 := OldImRow;
      for x := 0 to NewWidth - 1 do
      begin
        a := OldImRow[x];
        NewImRow[x] := a + (((OldImRow2[x] - a) * idiff) shr 17);
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + OldHeight)));
    end;
  end
  else
  begin
    // zoom-out (median)
    getmem(OldScanline, sizeof(pointer) * OldHeight);
    for y := 0 to OldHeight - 1 do
      OldScanline[y] := bmp1.Scanline[y];
    for y := 0 to NewHeight - 1 do
    begin
      iold := trunc(y / zy);
      iold2 := trunc(imin(y + 1, NewHeight - 1) / zy);
      NewImRow := Dst.Scanline[y];
      for x := 0 to NewWidth - 1 do
      begin
        mm := 0;
        mc := 0;
        for yy := iold to iold2 do
        begin
          OldImRow := OldScanline[yy];
          inc(mm, OldImRow[x]);
          inc(mc);
        end;
        NewImRow[x] := mm div mc;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + OldHeight)));
    end;
    freemem(OldScanline);
  end;
  FreeAndNil(bmp1);
  freemem(darr1);
  freemem(iarr1);
  freemem(iarr2);
end;

// Subsample with filter sx? area of src to dst sizes
// note: works only with 1 bpp images
// the dst bitmap MUST BE ie24RGB

procedure _SubResample1bitFilteredEx(src: TIEBaseBitmap; sx1, sy1, sx2, sy2: integer; dst: TIEBitmap);
var
  x, y: integer;
  zdx, zdy, zdx1, zdy1: double;
  pxx: PRGB;
  wx, wy, t, tt, wy1, wy2, wx1, wx2: integer;
  rzdx, rzdy: integer;
  px2: pbytearray;
  twy1, twy2: pintegerarray;
  twx1, twx2: pintegerarray;
  bmask: pbytearray;
  dww1, dhh1: integer;
begin
  if (src.Width = 0) or (src.Height = 0) or (dst.Width = 0) or (dst.Height = 0) then
    exit;
  dhh1 := dst.height - 1;
  dww1 := dst.width - 1;
  // subsample horizontal rate
  zdx := (sx2 - sx1 + 1) / dst.width;
  rzdx := trunc(zdx);
  // subsample vertical rate
  zdy := (sy2 - sy1 + 1) / dst.height;
  rzdy := trunc(zdy);
  // precalculate x and y coef
  getmem(twy1, dst.height * sizeof(integer));
  getmem(twy2, dst.height * sizeof(integer));
  for y := 0 to dhh1 do
  begin
    zdy1 := y * zdy;
    twy1^[y] := trunc(zdy1 - zdy / 2);
    if twy1^[y] < 0 then
      twy1^[y] := 0;
    if twy1^[y] >= src.Height then
      twy1^[y] := src.Height - 1;
    twy2^[y] := trunc(zdy1 + rzdy / 2);
    if twy2^[y] < 0 then
      twy2^[y] := 0;
    if twy2^[y] >= src.Height then
      twy2^[y] := src.Height - 1;
  end;
  getmem(twx1, dst.width * sizeof(integer));
  getmem(twx2, dst.width * sizeof(integer));
  for x := 0 to dww1 do
  begin
    zdx1 := x * zdx;
    twx1^[x] := trunc(zdx1 - zdx / 2) + sx1;
    if twx1^[x] < 0 then
      twx1^[x] := 0;
    if (twx1^[x] - sx1) > src.Width then
      twx1^[x] := src.Width - 1;
    twx2^[x] := trunc(zdx1 + zdx / 2) + sx1;
    if twx2^[x] < 0 then
      twx2^[x] := 0;
    if (twx2^[x] - sx1) > src.Width then
      twx2^[x] := src.Width - 1;
  end;
  // precalculate bitmask
  getmem(bmask, src.width);
  for x := 0 to src.width - 1 do
    bmask^[x] := iebitmask1[x mod 8];
  // subsample
  for y := 0 to dhh1 do
  begin
    pxx := PRGB(dst.scanline[y]);
    wy1 := twy1^[y];
    wy2 := twy2^[y];
    for x := 0 to dww1 do
    begin
      wx1 := twx1^[x];
      wx2 := twx2^[x];
      t := 0;
      tt := 0;
      for wy := wy1 to wy2 do
      begin
        px2 := pbytearray(src.scanline[wy + sy1]);
        for wx := wx1 to wx2 do
        begin
          if (px2^[wx shr 3] and bmask^[wx]) <> 0 then
            inc(tt, 255);
          inc(t);
        end;
      end;
      with pxx^ do
      begin
        r := tt div t;
        g := r;
        b := r;
      end;
      inc(pxx);
    end;
  end;
  //
  freemem(twy1);
  freemem(twy2);
  freemem(twx1);
  freemem(twx2);
  freemem(bmask);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////
// VertHist and HorizHist are outputs
// norm_vert, norm_horiz are inputs

{!!
<FS>TImageEnProc.CalcDensityHistogram

<FM>Declaration<FC>
procedure CalcDensityHistogram(VertHist,HorizHist:pointer; norm_vert,norm_horiz:integer);

<FM>Description<FN>
CalcDensityHistogram calculates the pixel vertical and density histograms. See the example 'DensityAnalysis' for more information.
Here is the output of DensityAnalysis demo:
<IMG help_images\66.bmp>
!!}
procedure TImageEnProc.CalcDensityHistogram(VertHist, HorizHist: pointer; norm_vert, norm_horiz: integer);
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  tmpbmp: TIEBitmap;
  mask: TIEMask;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  GetReSel(fSX1, fSY1, fSX2, fSY2, fPolyS, fPolySCount, mask);
  if assigned(mask) and (not mask.IsEmpty) then
  begin
    tmpbmp := TIEBitmap.Create;
    tmpbmp.Allocate(mask.x2 - mask.x1 + 1, mask.y2 - mask.y1 + 1, fIEBitmap.PixelFormat);
    fIEBitmap.CopyRectTo(tmpbmp, mask.x1, mask.y1, 0, 0, tmpbmp.Width, tmpbmp.Height);
    _CalcDensityHistogram(tmpbmp, 0, 0, tmpbmp.width, tmpbmp.height, fOnProgress, self, VertHist, HorizHist, norm_vert, norm_horiz);
    FreeAndNil(tmpbmp);
  end
  else
    _CalcDensityHistogram(fiebitmap, fSx1, fSy1, fSx2, fSy2, fOnProgress, self, VertHist, HorizHist, norm_vert, norm_horiz);
  DoFinishWork;
end;

// for ie24RGB and ie1g
// VertHist and HorizHist are outputs
// norm_vert, norm_horiz are inputs

procedure _CalcDensityHistogram(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject; VertHist, HorizHist: pintegerarray; norm_vert, norm_horiz: integer);
var
  col, row, pp: integer;
  ppx: pRGB;
  per1: double;
  bx: pbyte;
  tb: byte;
  bb, i, vmax, hmax, ww, hh: integer;
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  if Bitmap.Pixelformat = ie24RGB then
  begin
    // ie24RGB
    for col := fSelX1 to fSelX2 do
      HorizHist[col - fSelX1] := 0;
    for row := fSelY1 to fSelY2 do
    begin
      ppx := bitmap.ScanLine[row];
      inc(ppx, fSelX1);
      VertHist[row - fSelY1] := 0;
      for col := fSelX1 to fSelX2 do
      begin
        with ppx^ do
          pp := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
        inc(VertHist[row - fSelY1], pp);
        inc(HorizHist[col - fSelX1], pp);
        inc(ppx);
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
    end;
  end
  else if Bitmap.Pixelformat = ie1g then
  begin
    // ie1g
    for col := fSelX1 to fSelX2 do
      HorizHist[col - fSelX1] := 0;
    for row := fSelY1 to fSelY2 do
    begin
      bx := Bitmap.Scanline[row];
      inc(bx, fSelX1 shr 3);
      bb := 7 - (fSelX1 and 7);
      tb := bx^;
      VertHist[row - fSelY1] := 0;
      for col := fSelX1 to fSelX2 do
      begin
        if (bx^ and (1 shl bb)) <> 0 then
        begin
          inc(VertHist[row - fSelY1]);
          inc(HorizHist[col - fSelX1]);
        end;
        dec(bb);
        if bb = -1 then
        begin
          bx^ := tb;
          inc(bx);
          tb := bx^;
          bb := 7;
        end;
      end;
      if bb < 7 then
        bx^ := tb;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
    end;
  end;
  // normalize outputs
  ww := fSelX2 - fSelX1 + 1;
  hh := fSelY2 - fSelY1 + 1;
  vmax := VertHist[0];
  for i := 1 to hh - 1 do
    if VertHist[i] > vmax then
      vmax := VertHist[i];
  hmax := HorizHist[0];
  for i := 1 to ww - 1 do
    if HorizHist[i] > hmax then
      hmax := HorizHist[i];
  if vmax <> 0 then
    for i := 0 to hh - 1 do
      VertHist[i] := trunc((VertHist[i] / vmax) * norm_vert);
  if hmax <> 0 then
    for i := 0 to ww - 1 do
      HorizHist[i] := trunc((HorizHist[i] / hmax) * norm_horiz);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnProc.RemoveIsolatedPixels

<FM>Declaration<FC>
procedure RemoveIsolatedPixels(NoiseColor:integer; PixelsCount:integer);

<FM>Description<FN>
RemoveIsolatedPixels removes all groups of PixelCount isolated pixels.
The RemoveIsolatedPixels method works only with black/white images (1bit).

NoiseColor specifies the "text" color, 0 is black and 1 is white (for example if you have a document where the text is black NoiseColor must be 0, otherwise it must be 1).

<FM>Example<FC>
// removes single isolated pixels (black pixels)
ImageEnProc.RemoveIsolatedPixels(0, 1);

// removes groups of two isolated pixels (black pixels)
ImageEnProc.RemoveIsolatedPixels(0,2);

!!}
procedure TImageEnProc.RemoveIsolatedPixels(NoiseColor: integer; PixelsCount: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if PixelsCount = 0 then
    exit;
  if not BeginImageProcessing([ie1g], x1, y1, x2, y2, Format(IERS_REMOVEISOLATEDPIXELS, [NoiseColor, PixelsCount]), ProcBitmap, mask) then
    exit;
  _IERemoveIsolatedPixels1Bit(ProcBitmap, x1, y1, x2, y2, NoiseColor, PixelsCount);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure _IERemoveIsolatedPixels1Bit(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; NoiseColor: integer; IsolationMax: integer);
var
  col, row, y: integer;
  nmap: TIEWorkBitmap;
  ww, hh, vv: integer;
  pb: pbyte;
  r_lefttop, r_top, r_righttop, r_left, r_central, r_right, r_leftbottom, r_bottom, r_rightbottom: pbyte;
  lc: integer;
begin
  if IsolationMax = 0 then
    exit;
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  if Bitmap.Pixelformat = ie1g then
  begin
    // ie1g
    ww := fSelX2 - fSelX1 + 1;
    hh := fSelY2 - fSelY1 + 1;
    nmap := TIEWorkBitmap.Create(ww + 2, hh + 2, 8);
    zeromemory(nmap.Scanline[nmap.Height - 1], nmap.RowLen * nmap.height);
    // calc map
    y := 1;
    if NoiseColor = 0 then
    begin
      // Noise (foreground) is BLACK
      for row := fSelY1 to fSelY2 do
      begin
        pb := bitmap.Scanline[row];
        r_top := nmap.Scanline[y - 1];
        inc(r_top);
        r_lefttop := r_top;
        dec(r_lefttop);
        r_righttop := r_top;
        inc(r_righttop);
        r_central := nmap.Scanline[y];
        inc(r_central);
        r_left := r_central;
        dec(r_left);
        r_right := r_central;
        inc(r_right);
        r_bottom := nmap.Scanline[y + 1];
        inc(r_bottom);
        r_leftbottom := r_bottom;
        dec(r_leftbottom);
        r_rightbottom := r_bottom;
        inc(r_rightbottom);
        lc := 0;
        for col := fSelX1 to fSelX2 do
        begin
          if (pbytearray(pb)^[col shr 3] and iebitmask1[col and $7]) = 0 then
          begin
            lc := col - lc;
            inc(r_lefttop, lc);
            inc(r_top, lc);
            inc(r_righttop, lc);
            inc(r_left, lc);
            inc(r_central, lc);
            inc(r_right, lc);
            inc(r_leftbottom, lc);
            inc(r_bottom, lc);
            inc(r_rightbottom, lc);
            lc := col;
            //
            inc(r_lefttop^);
            inc(r_top^);
            inc(r_righttop^);
            inc(r_left^);
            inc(r_central^);
            inc(r_right^);
            inc(r_leftbottom^);
            inc(r_bottom^);
            inc(r_rightbottom^);
          end;
        end;
        inc(y);
      end;
    end
    else
    begin
      // Noise (foreground) is WHITE
      for row := fSelY1 to fSelY2 do
      begin
        pb := bitmap.Scanline[row];
        r_top := nmap.Scanline[y - 1];
        inc(r_top);
        r_lefttop := r_top;
        dec(r_lefttop);
        r_righttop := r_top;
        inc(r_righttop);
        r_central := nmap.Scanline[y];
        inc(r_central);
        r_left := r_central;
        dec(r_left);
        r_right := r_central;
        inc(r_right);
        r_bottom := nmap.Scanline[y + 1];
        inc(r_bottom);
        r_leftbottom := r_bottom;
        dec(r_leftbottom);
        r_rightbottom := r_bottom;
        inc(r_rightbottom);
        lc := 0;
        for col := fSelX1 to fSelX2 do
        begin
          if (pbytearray(pb)^[col shr 3] and iebitmask1[col and $7]) <> 0 then
          begin
            lc := col - lc;
            inc(r_lefttop, lc);
            inc(r_top, lc);
            inc(r_righttop, lc);
            inc(r_left, lc);
            inc(r_central, lc);
            inc(r_right, lc);
            inc(r_leftbottom, lc);
            inc(r_bottom, lc);
            inc(r_rightbottom, lc);
            lc := col;
            //
            inc(r_lefttop^);
            inc(r_top^);
            inc(r_righttop^);
            inc(r_left^);
            inc(r_central^);
            inc(r_right^);
            inc(r_leftbottom^);
            inc(r_bottom^);
            inc(r_rightbottom^);
          end;
        end;
        inc(y);
      end;
    end;
    // apply map
    if NoiseColor = 0 then
      vv := 1
    else
      vv := 0;
    y := 1;
    for row := fSelY1 to fSelY2 do
    begin
      pb := bitmap.Scanline[row];
      r_central := nmap.Scanline[y];
      inc(r_central);
      for col := fSelX1 to fSelX2 do
      begin
        if (r_central^ > 0) and (r_central^ <= IsolationMax) then
          _SetPixelbw(pb, col, vv);
        inc(r_central);
      end;
      inc(y);
    end;
    FreeAndNil(nmap);
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Kfill - binary noise removal from "Practical Algorithms for Image Analysis" - Seul - O'Gorman - J.Sammon
const
  kf_MAXKMAX = 21;
const
  kf_DFLTDIRTY = 0;
const
  kf_MIN0RUN = 5;
const
  kf_FILLINITIAL = false;

type
  tpintegerarray = array[0..maxint div 16] of pintegerarray;
type
  ppintegerarray = ^tpintegerarray;
type
  tpbyte = array[0..maxint div 16] of pbytearray;
type
  ppbyte = ^tpbyte;

  kf_rec = record
    _OFF, _ON: integer; // initial/final values of pixels
    FILL0, FILL1: byte; // values of OFF fill, ON fill
    fDiff: integer; // fNum difference from default
    cFlag: boolean; // if =1, retain connectivity; if 0, don't
    eFlag: boolean; // if =1, retain endpoint; if 0, don't
    imgSizex, imgSizey: integer;
    ySizeM1, xSizeM1: integer; // y,x lengths minus 1
    xRun: ppintegerarray; // no., then x locns of 1/0 runs for each y
    image: TIEWorkBitmap;
  end;

function kf_GetPByte(image: TIEWorkBitmap; row, col: integer): pbyte;
begin
  with image do
    result := pbyte(int64(DWORD(Bits)) + int64((Height - row - 1) * Rowlen + col));
end;

function kf_ksize(x, y, kMax: integer; fillFlag: boolean; var rc: kf_rec): integer;
var
  xMask, yMask, xEnd, yEnd, k: integer;
  upHalf, downHalf, xStart, yStart: integer;
  px: pbyte;
begin
  with rc do
  begin
    if (fillFlag = false) then
    begin
      if (kf_GetPByte(image, y, x)^ <= FILL0) then
      begin
        result := 0;
        exit;
      end
      else if (kMax = 3) then
      begin
        result := 3;
        exit;
      end;
    end
    else
    begin
      if (kf_GetPByte(image, y, x)^ >= FILL1) then
      begin
        result := 0;
        exit;
      end
      else if (kMax = 3) then
      begin
        result := 3;
        exit;
      end;
    end;
    for k := 4 to kMax do
    begin
      if (k and 1 = 1) then
      begin
        upHalf := (k - 3) shr 1;
        downHalf := upHalf;
      end
      else
      begin
        upHalf := (k - 2) shr 1;
        downHalf := (k - 4) shr 1;
      end;
      xStart := x - downHalf;
      xEnd := x + upHalf;
      yStart := y - downHalf;
      yEnd := y + upHalf;
      if ((xStart <= 0) or (yStart <= 0) or (xEnd >= (imgSizex - 1)) or (yEnd >= ySizeM1)) then
      begin
        result := (k - 1);
        exit;
      end;
      for yMask := yStart to yEnd do
      begin
        px := image.scanline[yMask];
        inc(px, xStart);
        for xMask := xStart to xEnd do
        begin
          if (fillFlag = false) then
          begin
            if (px^ < FILL0) then
            begin
              result := (k - 1);
              exit;
            end;
          end
          else if (px^ > FILL1) then
          begin
            result := (k - 1);
            exit;
          end;
          inc(px);
        end;
      end;
    end;
    result := kMax;
  end;
end;

function kf_getring(x, y, k: integer; fillFlag: boolean; ring: pinteger; var rc: kf_rec): integer;
var
  xEnd, yEnd, i, xStart, yStart: integer;
  upHalf, downHalf: integer;
  px: pbyte;
begin
  with rc do
  begin
    if (k and 1 = 1) then
    begin
      upHalf := (k - 1) shr 1;
      downHalf := upHalf;
    end
    else
    begin
      upHalf := k shr 1;
      downHalf := (k - 2) shr 1;
    end;
    xStart := x - downHalf;
    xEnd := x + upHalf;
    yStart := y - downHalf;
    yEnd := y + upHalf;
    i := 0;
    ring^ := 0;
    if (fillFlag = false) then
    begin
      px := image.scanline[yStart];
      inc(px, xStart);
      for x := xStart to xEnd do
      begin
        if (px^ >= FILL0) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        inc(px);
      end;
      px := kf_GetPByte(image, yStart + 1, xEnd);
      for y := yStart + 1 to yEnd do
      begin
        if (px^ >= FILL0) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        dec(px, image.rowlen);
      end;
      px := image.scanline[yEnd];
      inc(px, xEnd - 1);
      for x := xEnd - 1 downto xStart do
      begin
        if (px^ >= FILL0) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        dec(px);
      end;
      px := kf_GetPByte(image, yEnd - 1, xStart);
      for y := yEnd - 1 downto yStart + 1 do
      begin
        if (px^ >= FILL0) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        inc(px, image.rowlen);
      end;
    end
    else
    begin
      px := image.scanline[yStart];
      inc(px, xStart);
      for x := xStart to xEnd do
      begin
        if (px^ > FILL1) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        inc(px);
      end;
      px := kf_GetPByte(image, yStart + 1, xEnd);
      for y := yStart + 1 to yEnd do
      begin
        if (px^ > FILL1) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        dec(px, image.rowlen);
      end;
      px := image.scanline[yEnd];
      inc(px, xEnd - 1);
      for x := xEnd - 1 downto xStart do
      begin
        if (px^ > FILL1) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        dec(px);
      end;
      px := kf_GetPByte(image, yEnd - 1, xStart);
      for y := yEnd - 1 downto yStart + 1 do
      begin
        if (px^ > FILL1) then
          ring^ := ring^ or (01 shl i);
        inc(i);
        inc(px, image.rowlen);
      end;
    end;
    result := 0;
  end;
end;

function kf_fillsqr(x, y, k: integer; fillFlag: boolean; nFill: pinteger; var rc: kf_rec): integer;
var
  xEnd, yEnd: integer;
  upHalf, downHalf, yStart, xStart: integer;
  px: pbyte;
begin
  with rc do
  begin
    if (k = 3) then
    begin
      if (fillFlag = false) then
      begin
        if (kf_GetPByte(image, y, x)^ > FILL0) then
        begin
          inc(nFill^);
          kf_GetPByte(image, y, x)^ := FILL0;
        end;
      end
      else
      begin
        if (kf_GetPByte(image, y, x)^ < FILL1) then
        begin
          inc(nFill^);
          kf_GetPByte(image, y, x)^ := FILL1;
        end;
      end;
    end
    else
    begin
      if (k and 1 = 1) then
      begin
        upHalf := (k - 3) shr 1;
        downHalf := upHalf;
      end
      else
      begin
        upHalf := (k - 2) shr 1;
        downHalf := (k - 4) shr 1;
      end;
      xStart := x - downHalf;
      xEnd := x + upHalf;
      yStart := y - downHalf;
      yEnd := y + upHalf;
      for y := yStart to yEnd do
      begin
        px := image.scanline[y];
        inc(px, xStart);
        for x := xStart to xEnd do
        begin
          if (fillFlag = false) then
          begin
            if (px^ > FILL0) then
            begin
              inc(nFill^);
              px^ := FILL0;
            end;
          end
          else if (px^ < FILL1) then
          begin
            inc(nFill^);
            px^ := FILL1;
          end;
          inc(px);
        end;
      end;
    end;
    result := 0;
  end;
end;

function kf_fill(f0Table, f1Table: ppbyte; fillFlag: boolean; kMax: integer; change: pintegerarray; nFill: pinteger; var rc: kf_rec): integer;
var
  x, y, xStart, xEnd, iXRun, k, kM1: integer;
  ring, nChange, fillValue: integer;
begin
  with rc do
  begin
    nChange := 0;
    for y := 1 to ySizeM1 - 1 do
    begin
      iXRun := 1;
      x := 1;
      while iXRun <= xRun[y][0] do
      begin
        xStart := xRun[y][iXRun] - kMax + 2;
        if (xStart > x) then
          xStart := xStart
        else
          xStart := x;
        xEnd := xRun[y][iXRun + 1] + kMax - 2;
        if (xEnd > xSizeM1) then
          xEnd := xSizeM1;
        x := xStart;
        while x <= xEnd do
        begin
          k := kf_ksize(x, y, kMax, fillFlag, rc);
          if (k > 3) then
            kM1 := k - 1
          else
            kM1 := 3;
          while (k >= kM1) do
          begin
            kf_getring(x, y, k, fillFlag, @ring, rc);
            if (fillFlag = false) then
              fillValue := f0Table[k - 3][ring]
            else
              fillValue := f1Table[k - 3][ring];
            if (fillValue = 1) then
            begin
              inc(nChange);
              inc(change[k]);
              kf_fillsqr(x, y, k, fillFlag, nFill, rc);
              break;
            end;
            dec(k);
          end;
          inc(x);
        end;
        inc(iXRun, 2);
      end;
    end;
    result := nChange;
  end;
end;

function kf_filltest(pack, k, fill01: integer; var rc: kf_rec): integer;
var
  nRing, n, i: integer;
  ring: pbytearray;
  fNum, cNum, m: integer;
  lower, upper: integer;
  nCornerOn, fNumThresh: integer;
begin
  with rc do
  begin
    getmem(ring, 4 * (k - 1));
    try
      // unpack ring from word to array
      nRing := 4 * k - 4;
      for i := 0 to nRing - 1 do
        ring[i] := (pack shr i) and 01;
      // calculate CNUM, first skipping corners
      cNum := 0;
      i := 2;
      while i < nRing do
      begin
        lower := ring[i - 1];
        if ((i mod (k - 1)) = 0) then
          inc(i); // skip the corner pixels
        upper := ring[i];
        if ((upper <> 0) and (lower = 0)) then
          inc(cNum);
        inc(i);
      end;
      if ((ring[1] <> 0) and (ring[nRing - 1] = 0)) then
        inc(cNum);
      // CNUM at corners
      nCornerOn := 0;
      for n := 1 to 4 - 1 do
      begin
        m := n * (k - 1);
        if (ring[m] <> 0) then
        begin
          if ((ring[m - 1] = 0) and (ring[m + 1] = 0)) then
            inc(cNum);
          inc(nCornerOn);
        end;
      end;
      if (ring[0] <> 0) then
      begin
        if ((ring[1] = 0) and (ring[nRing - 1] = 0)) then
          inc(cNum);
        inc(nCornerOn);
      end;
      // calculate FNUM
      if (fill01 = FILL1) then
      begin
        fNum := 0;
        for i := 0 to nRing - 1 do
          if (ring[i] <> 0) then
            inc(fNum);
      end
      else
      begin
        fNum := 0;
        for i := 0 to nRing - 1 do
          if (ring[i] = 0) then
            inc(fNum);
      end;
      // to fill or not to fill
      if ((cFlag = false) or ((cFlag) and (cNum <= 1))) then
      begin
        fNumThresh := 3 * (k - 1) - 1 + fDiff;
        if ((fill01 = FILL1) or (eFlag = false)) then
        begin
          if (fNum > fNumThresh) then
          begin
            result := 1;
            exit;
          end;
          if ((fNum = fNumThresh) and (nCornerOn = 2)) then
          begin
            result := 1;
            exit;
          end;
        end
        else
        begin
          if (fNum = nRing) then
          begin
            result := 1;
            exit;
          end;
          if ((fNum = fNumThresh) and (nCornerOn = 2)) then
          begin
            result := 1;
            exit;
          end;
        end;
      end;
      result := 0;
    finally
      freemem(ring);
    end;
  end; // end with
end;

function kf_fill0(f0Table, f1Table: ppbyte; fillFlag: boolean; kMax: integer; change: pintegerarray; nONs, nFill: pinteger; var rc: kf_rec): integer;
var
  x, y, iXRun, k, kM1: integer;
  ring, nChange, fillValue, onRun: integer;
  image_px: pbyte;
begin
  with rc do
  begin
    nChange := 0;
    nONs^ := 0;
    for y := 1 to ySizeM1 - 1 do
    begin
      getmem(xRun[y], (imgSizex + 1) * sizeof(integer));
      xRun[y][0] := -kf_MIN0RUN;
      iXRun := 1;
      onRun := 0;
      x := 1;
      image_px := image.scanline[y];
      inc(image_px);
      while x < xSizeM1 do
      begin
        if (image_px^ <= FILL0) then
        begin
          if (onRun = 1) then
          begin
            onRun := 0;
            if (x - 1 >= imgSizex) then
              xRun[y][iXRun] := xSizeM1
            else
              xRun[y][iXRun] := x - 1;
            inc(iXRun);
          end;
        end
        else
        begin
          if (onRun = 0) then
          begin
            onRun := 1;
            if ((x - xRun[y][iXRun - 1]) < kf_MIN0RUN) then
              dec(iXRun)
            else
            begin
              if (x < 0) then
                xRun[y][iXRun] := 1
              else
                xRun[y][iXRun] := x;
              inc(iXRun);
            end;
          end;
          inc(nONs^);
        end;
        k := kf_ksize(x, y, kMax, fillFlag, rc);
        if (k > 3) then
          kM1 := k - 1
        else
          kM1 := 3;
        while (k >= kM1) do
        begin
          kf_getring(x, y, k, fillFlag, @ring, rc);
          if (fillFlag = false) then
            fillValue := f0Table[k - 3][ring]
          else
            fillValue := f1Table[k - 3][ring];
          if (fillValue = 1) then
          begin
            inc(nChange);
            inc(change[k]);
            kf_fillsqr(x, y, k, fillFlag, nFill, rc);
            break;
          end;
          dec(k);
        end;
        inc(x);
        inc(image_px);
      end;
      dec(iXRun);
      if (iXRun and 1 = 1) then
        inc(iXRun);
      xRun[y][iXRun] := x;
      xRun[y][0] := iXRun;
      reallocmem(xRun[y], sizeof(integer) * (iXRun + 1));
    end;
    result := nChange;
  end; // end with
end;

procedure _kf_kfill(bitmap: TIEBitmap; RetainConnectivity: boolean; RetainEndpoints: boolean; MaxIterations: integer; WindowSize: integer; InvertImage: boolean);
var
  x, y, i, k: integer;
  f0Table: ppbyte;
  f1Table: ppbyte;
  kMax, maxIter, nTable, nIter,
    pctDirty, nChange, nChangeB4,
    nChangeMax, nChangeThresh,
    nONs, nFill: integer;
  invertFlag: boolean;
  fillflag: boolean;
  change: array[0..kf_MAXKMAX - 1] of integer;
  rc: kf_rec;
  ps, pd: pbyte;
begin
  with rc do
  begin
    // inputs
    fDiff := 0;
    cFlag := RetainConnectivity;
    eFlag := RetainEndpoints;
    maxIter := MaxIterations;
    pctDirty := kf_DFLTDIRTY;
    kMax := WindowSize;
    fillFlag := kf_FILLINITIAL;
    invertFlag := InvertImage;
    //
    imgSizex := bitmap.width;
    imgSizey := bitmap.height;
    ySizeM1 := imgSizey - 1;
    xSizeM1 := imgSizex - 1;
    // invert image
    if invertFlag then
      _Negative1BitEx(bitmap);
    // create image (working bitmap)
    image := TIEWorkBitmap.Create(bitmap.width, bitmap.height, 8);
    fillchar(pbyte(image.Scanline[image.Height - 1])^, image.RowLen * image.height, 255);
    for y := 0 to image.height - 1 do
    begin
      ps := bitmap.scanline[y];
      pd := image.scanline[y];
      for x := 0 to image.width - 1 do
      begin
        if (pbytearray(ps)^[x shr 3] and iebitmask1[x and $7]) = 0 then
          pd^ := 0;
        inc(pd);
      end;
    end;
    //
    getmem(xRun, imgSizey * sizeof(integer));
    _OFF := 0;
    FILL0 := _OFF + 1;
    _ON := 255;
    FILL1 := _ON - 1;
    // make table of fill-values for FILL0 and FILL1
    getmem(f0Table, (kMax - 2) * sizeof(pointer));
    getmem(f1Table, (kMax - 2) * sizeof(pointer));
    for k := 3 to kMax do
    begin
      nTable := trunc(iepower(2.0, 4.0 * (k - 1.0)));
      getmem(f0Table[k - 3], nTable * sizeof(byte));
      getmem(f1Table[k - 3], nTable * sizeof(byte));
      for i := 0 to nTable - 1 do
      begin
        f0Table[k - 3][i] := kf_filltest(i, k, FILL0, rc);
        f1Table[k - 3][i] := kf_filltest(i, k, FILL1, rc);
      end;
    end;
    // zero image borders
    for y := 0 to imgSizey - 1 do
    begin
      kf_GetPByte(image, y, imgSizex - 1)^ := _OFF;
      kf_GetPByte(image, y, 0)^ := _OFF;
    end;
    for x := 0 to imgSizex - 1 do
    begin
      kf_GetPByte(image, ySizeM1, x)^ := _OFF;
      kf_GetPByte(image, 0, x)^ := _OFF;
    end;
    for k := 0 to kMax do
      change[k] := 0;
    // iteratively convolve through image until filled
      // on first iteration, perform filling and accumulate x-run info
    nChange := kf_fill0(f0Table, f1Table, fillFlag, kMax, @change[0], @nONs, @nFill, rc);
    nChangeMax := nChange;
    nChangeThresh := 0;
    nChangeB4 := nChangeThresh + 1;
    for i := 3 to kMax do
      change[i] := 0;
    if (fillFlag = true) then
    begin
      fillFlag := false;
      inc(FILL0);
    end
    else
    begin
      fillFlag := true;
      dec(FILL1);
    end;
    // on subsequent iterations, perform filling
    nIter := 1;
    while (nIter < maxIter) and ((nChange > nChangeThresh) or (nChangeB4 > nChangeThresh)) do
    begin
      nChangeB4 := nChange;
      nChange := kf_fill(f0Table, f1Table, fillFlag, kMax, @change[0], @nFill, rc);
      for i := 3 to kMax do
        change[i] := 0;
      if (fillFlag = true) then
      begin
        inc(FILL0);
        if (nChangeB4 <> 0) then
          fillFlag := false;
      end
      else
      begin
        dec(FILL1);
        if (nChangeB4 <> 0) then
          fillFlag := true;
      end;
      if (nChange > nChangeMax) then
        nChangeMax := nChange;
      nChangeThresh := (pctDirty * nChangeMax) div 100;
      inc(nIter);
    end;
    for y := 1 to ySizeM1 - 1 do
    begin
      pd := image.scanline[y];
      inc(pd);
      for x := 1 to imgSizex - 2 do
      begin
        if (pd^ <= FILL0) then
          pd^ := _OFF
        else if (pd^ >= FILL1) then
          pd^ := _ON;
        inc(pd);
      end;
    end;
    // un-invert image
    (*
    if invertFlag then
    begin
      for y := 1 to imgSizey - 2 do
        for x := 1 to imgSizex - 2 do
          kf_GetPByte(image, y, x)^ := 255 - kf_GetPByte(image, y, x)^;
    end;
    *)
    // finish, get bitmap from image
    for y := 1 to image.height - 2 do
    begin
      ps := bitmap.scanline[y];
      pd := image.scanline[y];
      inc(pd);
      for x := 1 to image.width - 2 do
      begin
        _setpixelbw(ps, x, pd^);
        inc(pd);
      end;
    end;
    //
    for y := 1 to ySizeM1 - 1 do
      freemem(xRun[y]);
    freemem(xRun);
    for k := 3 to kMax do
    begin
      freemem(f0Table[k - 3]);
      freemem(f1Table[k - 3]);
    end;
    freemem(f0Table);
    freemem(f1Table);
    //
    FreeAndNil(image);
  end; // end with
  if invertFlag then
    _Negative(bitmap, 0, 0, bitmap.width, bitmap.height, nil, nil);
end;

// works only with black/white images

{!!
<FS>TImageEnProc.RemoveNoise

<FM>Declaration<FC>
procedure RemoveNoise(Iterations:integer; InvertImage:boolean);

<FM>Description<FN>
RemoveNoise removes noise pixels using the Kfill algorithm.  The RemoveNoise method works only with black/white images (1bit).

Iterations is the maximum number of iterations (from 1).
If InvertImage is True, the image is inverted (negative) when the algorithm works.

<FM>Example<FC>
ImageEnProc.RemoveNoise(2,false);

!!}
procedure TImageEnProc.RemoveNoise(Iterations: integer; InvertImage: boolean);
var
  fSX1, fSY1, fSX2, fSY2: integer;
  fPolyS: PPointArray;
  fPolySCount: integer;
  tmpbmp: TIEBitmap;
  mask: TIEMask;
begin
  if not MakeConsistentBitmap([ie1g]) then
    exit;
  if Iterations = 0 then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_REMOVENOISE, ieuImage);
  GetReSel(fSX1, fSY1, fSX2, fSY2, fPolyS, fPolySCount, mask);
  if assigned(mask) and (not mask.IsEmpty) then
  begin
    tmpbmp := TIEBitmap.Create;
    tmpbmp.Allocate(mask.x2 - mask.x1 + 1, mask.y2 - mask.y1 + 1, fIEBitmap.PixelFormat);
    fIEBitmap.CopyRectTo(tmpbmp, mask.x1, mask.y1, 0, 0, tmpbmp.Width, tmpbmp.Height);
    _kf_kfill(tmpbmp, true, true, Iterations, 3, InvertImage);
    mask.CopyIEBitmap(fIEBitmap, tmpbmp, false, true, false);
    FreeAndNil(tmpbmp);
  end
  else
    _kf_kfill(fIEBitmap, true, true, Iterations, 3, InvertImage);
  Update;
  DoFinishWork;
end;

// end of kfill
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure _IEPaintMark(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; frequency: integer; color: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  col, row: integer;
  frx, fry: integer;
  px: PRGB;
  per1: double;
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  if Bitmap.Pixelformat = ie24RGB then
  begin
    fry := 0;
    for row := fSelY1 to fSelY2 do
    begin
      if fry = 0 then
      begin
        frx := 0;
        px := Bitmap.Scanline[row];
        for col := fSelX1 to fSelX2 do
        begin
          if frx = 0 then
            px^ := color;
          inc(frx);
          if frx > frequency then
            frx := 0;
          inc(px);
        end;
      end;
      inc(fry);
      if fry > frequency then
        fry := 0;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
    end;
  end;
end;

{!!
<FS>TImageEnProc.PaintMark

<FM>Declaration<FC>
procedure PaintMark(Frequency:integer; Color:<A TRGB>);

<FM>Description<FN>
PaintMark paints a pixel of Color every Frequency pixels, over the selected area.

<FM>Example<FC>

ImageEnProc.PaintMark(1,CreateRGB(0,0,0));  // a black marker

Above code makes following effect over the selected area:
<IMG help_images\67.bmp>
!!}
procedure TImageEnProc.PaintMark(Frequency: integer; Color: TRGB);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_PAINTMARK, [Frequency, Color.r, Color.g, Color.b]), ProcBitmap, mask) then
    exit;
  _IEPaintMArk(ProcBitmap, x1, y1, x2, y2, frequency, color, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// images must have some size

{!!
<FS>TImageEnProc.ComputeImageEquality

<FM>Declaration<FC>
function ComputeImageEquality(SecondImage:<A TIEBitmap>; var psnr_min,psnr_max:double; var mse_min,mse_max:double; var rmse_min,rmse_max:double; var pae_min,pae_max:double; var mae_min,mae_max:double):boolean;

<FM>Description<FN>
ComputeImageEquality calculates some values to find the similitude of current image with the SecondImage.

The method returns True if the images are equal.
Images must have some size and have PixelFormat=ie24RGB.

Returned values:

psnr_min,psnr_max : minimum and maximum peak signal to noise ratio
mse_min,mse_max : minimum and maximum mean squared error
rmse_min,rmse_max : minimum and maximum root mean squared error
pae_min,pae_max : minimum and maximum peak absolute error
mae_min,mae_max : minimum and maximum mean absolute error

<FM>Example<FC>

Var
  psnr_min,psnr_max:double;
  mse_min,mse_max:double;
  rmse_min,rmse_max:double;
  pae_min,pae_max:double;
  mae_min,mae_max:double;
..
  if ImageEnView1.Proc.ComputeImageEquality(ImageEnView2.Bitmap,psnr_min,psnr_max,mse_min,mse_max,rmse_min,rmse_max,pae_min,pae_max,mae_min,mae_max) then
    showmessage('Images are equals')
  else begin
	// shows the similitude values
  end;

!!}
function TImageEnProc.ComputeImageEquality(SecondImage: TIEBitmap; var psnr_min, psnr_max: double; var mse_min, mse_max: double; var rmse_min, rmse_max: double; var pae_min, pae_max: double; var mae_min, mae_max: double): boolean;
begin
  result := false;
  if not MakeConsistentBitmap([]) then
    exit;
  if (fIEBitmap.PixelFormat <> ie24RGB) or (SecondImage.PixelFormat <> ie24RGB) then
    exit;
  if (fIEBitmap.Width <> SecondImage.Width) or (fIEBitmap.Height <> SecondImage.Height) then
    exit;
  _IEComputeDiff(fIEBitmap, SecondImage, psnr_min, psnr_max, mse_min, mse_max, rmse_min, rmse_max, pae_min, pae_max, mae_min, mae_max, result);
  DoFinishWork;
end;

// must be x.width=y.width and x.height=y.height and x.pixelformat=y.pixelformat
// psnr .... peak signal to noise ratio
// mse ..... mean squared error
// rmse .... root mean squared error
// pae ..... peak absolute error
// mae ..... mean absolute error
// equal ... equality (boolean)
procedure _IEComputeDiff(x, y: TIEBitmap; var psnr_min, psnr_max: double; var mse_min, mse_max: double;
  var rmse_min, rmse_max: double; var pae_min, pae_max: double;
  var mae_min, mae_max: double; var equal: boolean);
var
  compno: integer;
  msen1, msen2, pae, psnr: double;
  d: double;
  i, j: integer;
  px, py: pbyte;
begin
  psnr_min := 1000000000;
  psnr_max := 0;
  mse_min := 1000000000;
  mse_max := 0;
  rmse_min := 1000000000;
  rmse_max := 0;
  pae_min := 1000000000;
  pae_max := 0;
  mae_min := 1000000000;
  mae_max := 0;
  equal := true;
  for compno := 0 to 2 do
  begin
    msen1 := 0;
    msen2 := 0;
    pae := 0;
    for i := 0 to x.height - 1 do
    begin
      px := x.Scanline[i];
      inc(px, compno);
      py := y.Scanline[i];
      inc(py, compno);
      for j := 0 to x.width - 1 do
      begin
        d := py^ - px^;
        msen1 := msen1 + abs(d);
        msen2 := msen2 + (d * d);
        if (d > pae) then
          pae := d;
        inc(px, 3);
        inc(py, 3);
      end;
    end;
    msen1 := msen1 / (x.height * x.width);
    msen2 := msen2 / (x.height * x.width);
    if msen2 <> 0 then
      psnr := 20 * log10(255 / sqrt(msen2))
    else
      psnr := 0;
    //
    if psnr > psnr_max then
      psnr_max := psnr;
    if psnr < psnr_min then
      psnr_min := psnr;
    if msen2 > mse_max then
      mse_max := msen2;
    if msen2 < mse_min then
      mse_min := msen2;
    d := sqrt(msen2);
    if d < rmse_min then
      rmse_min := d;
    if d > rmse_max then
      rmse_max := d;
    if pae < pae_min then
      pae_min := pae;
    if pae > pae_max then
      pae_max := pae;
    if msen1 < mae_min then
      mae_min := msen1;
    if msen1 > mae_max then
      mae_max := msen1;
    if pae <> 0 then
      equal := false;
  end;
end;

{!!
<FS>TImageEnProc.CompareWith

<FM>Declaration<FC>
function CompareWith(SecondImage:<A TIEBitmap>; DiffBitmap:<A TIEBitmap>):double;

<FM>Description<FN>
Compares current image with SecondImage and returns a floating point value from 0 to 1 which specifies the percentage of equality. 1 means that two images are equal.
The algorithm compares only the intensity of the pixels, not the colors.

The DiffBitmap can be nil, otherwise it must be an 8 bit bitmap (ie8g or ie8p PixelFormat) which will contain a bitmap with the differences.

Images must have same size and have <A TIEBitmap.PixelFormat>=ie24RGB.

See 'motiondetector' example for more info.

<FM>Example<FC>
Eq := ImageEnView1.CompareWith( ImageEnView2.IEBitmap, nil );

!!}
function TImageEnProc.CompareWith(SecondImage: TIEBitmap; DiffBitmap: TIEBitmap): double;
begin
  result := 0;
  if not MakeConsistentBitmap([]) then
    exit;
  result := IECompareImages(fIEBitmap, SecondImage, DiffBitmap);
  DoFinishWork;
end;

// diffmap must be ie8g or ie8p
function IECompareImages(image1, image2: TIEBitmap; diffmap: TIEBitmap): double;
var
  x, y: integer;
  w, h: integer;
  prgb1, prgb2: PRGB;
  i1, i2: integer;
  di: integer;
  d: double;
  dm: pbyte;
begin
  result := 0;
  if (image1.PixelFormat <> ie24RGB) or (image2.PixelFormat <> ie24RGB) then
    exit;
  if assigned(diffmap) and (diffmap.PixelFormat<>ie8g) and (diffmap.PixelFormat<>ie8p) then
    diffmap:=nil;
  w := imin(image1.Width,image2.Width);
  h := imin(image1.Height,image2.Height);
  if assigned(diffmap) then
  begin
    diffmap.Allocate(w,h,diffmap.PixelFormat);
    diffmap.Fill(255);
  end;
  d := 0;
  dm := nil;
  for y := 0 to h - 1 do
  begin
    prgb1 := image1.Scanline[y];
    prgb2 := image2.Scanline[y];
    if assigned(diffmap) then
      dm := diffmap.Scanline[y];
    for x := 0 to w - 1 do
    begin

      with prgb1^ do
        i1 := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
      with prgb2^ do
        i2 := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;

      di := abs(i1 - i2);

      d := d + di / 255;

      inc(prgb1);
      inc(prgb2);
      if assigned(dm) then
      begin
        dm^ := di;
        inc(dm);
      end;
    end;
  end;
  d := d / (w * h);
  result := 1 - d;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure _IEGammaCorrect_RGB8(ABitmap: TIEBitmap; AGamma: double; AChannel: TIEChannels; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  LUT: array[byte] of byte;
  C1, C2: integer;
  px: PRGB;
  per1: double;
  procedure BuildLUT(AValue: double); // Build Look-Up-Table
  var
    C1: integer;
  begin
    for C1 := 0 to 255 do
      LUT[C1] := blimit(Round(iepower(C1 / 255, 1 / AValue) * 255));
  end;
  //
begin
  per1 := 100 / ABitmap.Height;
  BuildLUT(AGamma);
  with ABitmap do
    for C1 := 0 to (Height - 1) do
    begin
      px := ScanLine[C1];
      if AChannel = [iecRed, iecGreen, iecBlue] then
      begin
        for C2 := 0 to (width - 1) do
        begin
          with px^ do
          begin
            r := LUT[r];
            g := LUT[g];
            b := LUT[b];
          end;
          inc(px);
        end;
      end
      else
      begin
        for C2 := 0 to (width - 1) do
        begin
          with px^ do
          begin
            if iecRed in AChannel then
              r := LUT[r];
            if iecGreen in AChannel then
              g := LUT[g];
            if iecBlue in AChannel then
              b := LUT[b];
          end;
          inc(px);
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * C1));
    end;
end;

procedure _IEGammaCorrect_RGB16(ABitmap: TIEBitmap; AGamma: double; AChannel: TIEChannels; fOnProgress: TIEProgressEvent; Sender: TObject);
type
  TLUT16 = array [0..65535] of word;
  PLUT16 = ^TLUT16;
var
  LUT: PLUT16;
  C1, C2, v: integer;
  px: PRGB48;
  per1: double;
  procedure BuildLUT(AValue: double); // Build Look-Up-Table
  var
    C1: integer;
  begin
    for C1 := 0 to 65535 do
    begin
      v := Round(iepower(C1 / 65535, 1 / AValue) * 65535);
      if v<0 then v:=0 else if v>65535 then v:=65535;
      LUT[C1]:=v;
    end;
  end;
  //
begin
  getmem(LUT, sizeof(TLUT16));
  per1 := 100 / ABitmap.Height;
  BuildLUT(AGamma);
  with ABitmap do
    for C1 := 0 to (Height - 1) do
    begin
      px := ScanLine[C1];
      if AChannel = [iecRed, iecGreen, iecBlue] then
      begin
        for C2 := 0 to (width - 1) do
        begin
          with px^ do
          begin
            r := LUT[r];
            g := LUT[g];
            b := LUT[b];
          end;
          inc(px);
        end;
      end
      else
      begin
        for C2 := 0 to (width - 1) do
        begin
          with px^ do
          begin
            if iecRed in AChannel then
              r := LUT[r];
            if iecGreen in AChannel then
              g := LUT[g];
            if iecBlue in AChannel then
              b := LUT[b];
          end;
          inc(px);
        end;
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * C1));
    end;
  freemem(LUT);
end;


{!!
<FS>TImageEnProc.GammaCorrect

<FM>Declaration<FC>
procedure GammaCorrect(Gamma:double; Channel:<A TIEChannels>);

<FM>Description<FN>
GammaCorrect performs a gamma correction.

Gamma is the gamma correction value. A value of 1.0 causes no gamma correction processing.
Channel is the channel where to apply the gamma.

<FM>Example<FC>
//  applies a gamma correction over all channels (RGB)
ImageEnProc.GammaCorrect( 2, [iecRed,iecGreen,iecBlue] );

!!}
procedure TImageEnProc.GammaCorrect(Gamma: double; Channel: TIEChannels);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB,ie48RGB], x1, y1, x2, y2, IERS_GAMMACORRECT, ProcBitmap, mask) then
    exit;
  case ProcBitmap.PixelFormat of
    ie24RGB: _IEGammaCorrect_RGB8(ProcBitmap, Gamma, Channel, fOnProgress, Self);
    ie48RGB: _IEGammaCorrect_RGB16(ProcBitmap, Gamma, Channel, fOnProgress, Self);
  end;
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure TImageEnProc.SetIEBitmap(bmp: TIEBitmap);
begin
  fBitmap := nil;
  if fIEBitmapCreated then
    FreeAndNil(fIEBitmap);
  fIEBitmapCreated := false;
  fIEBitmap := bmp;
end;

{!!
<FS>TImageEnProc.AttachedIEBitmap

<FM>Declaration<FC>
property AttachedIEBitmap:<A TIEBitmap>;

<FM>Description<FN>
AttachedIEBitmap specifies the attached TIEBitmap object.
Using TIEBitmap instead of TBitmap allows TImageEnProc to be thread safe and to handle large images.

<FM>Example<FC>
// load an image in a TIEBitmap, make it negative then save back to output.tif

var iebmp:TIEBitmap;

iebmp:=TIEBitmap.Create;
ImageEnProc.AttachedIEBitmap:=iebmp;
ImageEnIO.AttachedIEBitmap:=iebmp;

ImageEnIO.LoadFromFile('animage.tif');
ImageEnProc.Negative;
ImageEnIO.SaveToFile('output.tif');
!!}
procedure TImageEnProc.SetAttachedIEBitmap(bmp: TIEBitmap);
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

{!!
<FS>TImageEnProc.AttachedBitmap

<FM>Declaration<FC>
property AttachedBitmap: TBitmap;

<FM>Description<FN>
Use this property if you want to attach TImageEnProc to a normal TBitmap object. This property is mutually exclusive with <A TImageEnProc.AttachedTImage> and <A TImageEnProc.AttachedImageEn>.

<FM>Example<FC>

ImageEnView1.Proc.AttachedBitmap:=Image1.Picture.Bitmap; // Image1 is a TImage object
ImageEnView1.Proc.DoPreviews([peAll]); // apply effects to a normal TImage object
!!}
procedure TImageEnProc.SetAttachedBitmap(atBitmap: TBitmap);
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle); // rimuove precedente, se c'è
  if (not assigned(atBitmap)) and (assigned(fImageEnView) or assigned(fTImage)) then
    exit; // error
  fBitmap := atBitmap;
  fIEBitmap.EncapsulateTBitmap(fBitmap, true);
  if assigned(fBitmap) then
  begin
    fImageEnView := nil;
    fTImage := nil;
  end;
end;

{!!
<FS>TImageEnProc.AttachedImageEn

<FM>Declaration<FC>
property AttachedImageEn: <A TIEView>;

<FM>Description<FN>
Use this property if you want to attach <A TImageEnProc> to a <A TImageEn>, <A TImageEnView> or <A TImageEnDBView> (or any other inherited object) component.
This property is mutually exclusive with <A TImageEnProc.AttachedTImage> and <A TImageEnProc.AttachedBitmap>.

<FM>Example<FC>

ImageEnView1.Proc.AttachedImageEn:=ImageEnView1;
!!}
procedure TImageEnProc.SetAttachedImageEn(atImageEn: TIEView);
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle);
  fImageEnView := atImageEn;
  if assigned(fImageEnView) then
  begin // fImageEnView now could be nil
    if fIEBitmapCreated then
    begin
      fIEBitmapCreated := false;
      FreeAndNil(fIEBitmap);
    end;
    fIEBitmap := fImageEnView.IEBitmap;
    if assigned(fIEBitmap) then
      // use TIEBitmap
      fBitmap := nil // both fBitmap and fIEBitmap not allowed
    else
    begin
      // use TBitmap
      fBitmap := fImageEnView.Bitmap;
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
<FS>TImageEnProc.AttachedTImage

<FM>Declaration<FC>
property AttachedTImage: TImage;

<FM>Description<FN>
Use this property if you want to attach TImageEnProc to a TImage (any other inherited object) component.
This property is mutually exclusive with <A TImageEnProc.AttachedImageEn> and <TImageEnProc.AttachedBitmap>.

<FM>Example<FC>

ImageEnView1.Proc.AttachedTImage:=Image1;
!!}
procedure TImageEnProc.SetTImage(v: TImage);
begin
  if assigned(fImageEnView) then
    fImageEnView.RemoveBitmapChangeEvent(fImageEnViewBitmapChangeHandle);
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

// this function doesn't SaveUndo
// call UpdateRect if connected to TImageEnView
// just draw a circle at x,y of "Width" size

{!!
<FS>TImageEnProc.PaintPenMarker

<FM>Declaration<FC>
procedure PaintPenMarker(x,y:integer; Width:integer=20; Color:TColor=clYellow; BackgroundColor:TColor=clWhite; Tolerance:integer=10);

<FM>Description<FN>
PaintPenMarker emulates a pen marker over the image (that must be in true color). 

x and y specify the position of the pen in bitmap coordinates. Width specifies the size of the circle. BackgroundColor is the background color to change, replaced with Color. Tolerance is the maximum difference from BackgroundColor to allow drawing the marker.

PaintPenMarker doesn't save the previous image into an Undo buffer.

!!}
procedure TImageEnProc.PaintPenMarker(x, y: integer; Width: integer; Color: TColor; BackgroundColor: TColor; Tolerance: integer);
var
  rgbColor, rgbBack: TRGB;
  //
  procedure DrawPix(px, py: integer);
  var
    bk: TRGB;
    max, v: integer;
  begin
    bk := fIEBitmap.Pixels_ie24RGB[px, py];
    max := abs(bk.r - rgbBack.r);
    v := abs(bk.g - rgbBack.g);
    if v > max then
      max := v;
    v := abs(bk.b - rgbBack.b);
    if v > max then
      max := v;
    if max <= Tolerance then
    begin
      fIEBitmap.Pixels_ie24RGB[px, py] := rgbColor;
      if fIEBitmap.HasAlphaChannel then
        fIEBitmap.Alpha[px, py] := 255;
    end;
  end;
  //
var
  p, xx, yy, g, w: integer;
  a, p2: double;
  iv: TImageEnView;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if (x < 0) or (y < 0) or (x >= fIEBitmap.Width) or (y >= fIEBitmap.Height) then
    exit;
  rgbColor := TColor2TRGB(Color);
  rgbBack := TColor2TRGB(BackgroundColor);
  DrawPix(x, y); // draw central pixel
  Width := Width div 2;
  for w := 1 to Width do
  begin
    p := round(2 * pi * w) shl 1;
    p2 := (2 * pi / p);
    for g := 0 to p - 1 do
    begin
      a := p2 * g;
      xx := round(x + cos(a) * w);
      if xx < 0 then
        xx := 0
      else if xx >= fIEBitmap.Width then
        xx := fIEBitmap.Width - 1;
      yy := round(y + sin(a) * w);
      if yy < 0 then
        yy := 0
      else if yy >= fIEBitmap.Height then
        yy := fIEBitmap.Height - 1;
      DrawPix(xx, yy);
    end;
  end;
  // update rect if attached to TImageEnView
  if assigned(AttachedImageEn) and (AttachedImageEn is TImageEnView) then
  begin
    iv := AttachedImageEn as TImageEnView;
    xx := iv.XBmp2Scr(x);
    yy := iv.YBmp2Scr(y);
    w := round((Width + 1) * (iv.Zoom / 100));
    iv.UpdateRect(rect(xx - w, yy - w, xx + w + 1, yy + w + 1));
  end;
end;

// fills the hist array (256 elements) with the gray levels histogram
// accept all TIEPixelFormat values
procedure _IEGetHistogram(Bitmap: TIEBitmap; hist: pintegerarray);
var
  y, x, v: integer;
  p_byte: pbyte;
  p_word: pword;
  p_rgb: PRGB;
  p_rgb32: PRGBA;
  p_rgb48:PRGB48;
  p_single: psingle;
  p_cmyk:PCMYK;
  p_cielab:PCIELAB;
  rgb:TRGB;
begin
  zeromemory(hist, 256 * sizeof(integer));
  for y := 0 to Bitmap.Height - 1 do
  begin
    case Bitmap.PixelFormat of
      ie1g: // black/white
        begin
          p_byte := Bitmap.Scanline[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            if pbytearray(p_byte)^[x shr 3] and iebitmask1[x and $7] = 0 then
              inc(hist[0])
            else
              inc(hist[1]);
          end;
        end;
      ie8p: // color (palette)
        begin
          p_byte := Bitmap.Scanline[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            with Bitmap.Palette[p_byte^] do
              v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            inc(hist[v]);
            inc(p_byte);
          end;
        end;
      ie8g: // gray scale (256 levels)
        begin
          p_byte := Bitmap.Scanline[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            inc(hist[p_byte^]);
            inc(p_byte);
          end;
        end;
      ie16g: //	gray scale (65536 levels), the array is always 256 levels
        begin
          p_word := Bitmap.Scanline[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            inc(hist[p_word^ shr 8]);
            inc(p_word);
          end;
        end;
      ie24RGB: // color (true color)
        begin
          p_rgb := Bitmap.ScanLine[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            with p_rgb^ do
              v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            inc(hist[v]);
            inc(p_rgb);
          end;
        end;
      ie32RGB: // color (true color)
        begin
          p_rgb32 := Bitmap.ScanLine[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            with p_rgb32^ do
              v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            inc(hist[v]);
            inc(p_rgb32);
          end;
        end;
      ie32f: //	32bit float point gray scale, the array is always 256 levels
        begin
          p_single := Bitmap.Scanline[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            inc(hist[trunc(p_single^ * 255)]);
            inc(p_single);
          end;
        end;
      ieCMYK: // CMYK
        begin
          p_cmyk := Bitmap.ScanLine[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            rgb:=IECMYK2RGB(p_cmyk^);
            with rgb do
              v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            inc(hist[v]);
            inc(p_cmyk);
          end;
        end;
      ieCIELab: // CIELab
        begin
          p_cielab := Bitmap.ScanLine[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            rgb:=IECIELAB2RGB(p_cielab^);
            with rgb do
              v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            inc(hist[v]);
            inc(p_cielab);
          end;
        end;
      ie48RGB: // 48 bit color
        begin
          p_rgb48 := Bitmap.ScanLine[y];
          for x := 0 to Bitmap.Width - 1 do
          begin
            with p_rgb48^ do
              v := ( (r shr 8) * gRedToGrayCoef + trunc(g shr 8) * gGreenToGrayCoef + trunc(b shr 8) * gBlueToGrayCoef) div 100;
            inc(hist[v]);
            inc(p_rgb48);
          end;
        end;
    end;
  end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// binarization

// If Threshold is:
// >=0 : apply just specified threshold
// -1  : autocalculated using media
// -2 : calc Threshold, maximum entropy mode
// origbitmap and destbitmap must have some size
// destbitmap must be ie1g
// origbitmap: Accept all TIEPixelFormat values
procedure _ConvertToBWThresholdEx(OrigBitmap, DestBitmap: TIEBitmap; Threshold: integer; var Progress: TProgressRec);
var
  i, j, n: integer;
  x, y, v, b, mR, mG, mB: integer;
  rgb:TRGB;
  p_rgb: PRGB;
  p_rgb32: PRGBA;
  p_byte: pbyte;
  p_word: pword;
  p_single: psingle;
  p_cmyk:PCMYK;
  p_cielab:PCIELAB;
  p_rgb48:PRGB48;
  p2: pbyte;
  hist: pintegerarray;
  prob: pdoublearray;
  hn, psiMax, Ps, Hs, psi: double;
  //
  procedure ConvPixel(Color: TRGB);
  begin
    b := x and 7;
    with Color do
      v := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
    if v >= Threshold then
      p2^ := p2^ or iebitmask1[b]
    else
      p2^ := p2^ and (not iebitmask1[b]);
    if b = 7 then
      inc(p2);
  end;
begin
  if OrigBitmap.PixelFormat = ie1g then
  begin
    // already black/white, just copy
    DestBitmap.AssignImage(OrigBitmap);
    exit;
  end;
  progress.per1 := 100 / (OrigBitmap.Height + 0.5);
  hist := nil;
  prob := nil;
  case Threshold of
    -1:
      begin
        // calc Threshold, media mode
        _GetMediaContrastRGB(origBitmap, mR, mG, mB);
        Threshold := (mR * gRedToGrayCoef + mG * gGreenToGrayCoef + mB * gBlueToGrayCoef) div 100;
      end;
    -2:
      begin
        // calc Threshold, maximum entropy mode
        getmem(hist, 256 * sizeof(integer));
        _IEGetHistogram(origBitmap, hist);
        getmem(prob, 256 * sizeof(double));
        n := OrigBitmap.Width * OrigBitmap.Height;
        for i := 0 to 255 do
          prob[i] := hist[i] / n;
        hn := 0;
        psi := 0;
        for i := 0 to 255 do
          if prob[i] <> 0 then
            hn := hn - prob[i] * ln(prob[i]);
        psiMax := 0;
        for i := 1 to 255 do
        begin
          Ps := 0;
          Hs := 0;
          for j := 0 to i - 1 do
          begin
            Ps := Ps + prob[j];
            if prob[j] > 0 then
              Hs := Hs - prob[j] * ln(prob[j]);
          end;
          if (Ps > 0) and (Ps < 1) then
            psi := ln(Ps - Ps * Ps) + Hs / Ps + (Hn - Hs) / (1.0 - Ps);
          if psi > psiMax then
          begin
            psiMax := psi;
            Threshold := i;
          end;
        end;
      end;
  end;
  if hist <> nil then
    freemem(hist);
  if prob <> nil then
    freemem(prob);
  for y := 0 to OrigBitmap.Height - 1 do
  begin
    p2 := DestBitmap.ScanLine[y];
    case OrigBitmap.PixelFormat of
      ie8p: // color (palette)
        begin
          p_byte := OrigBitmap.Scanline[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            ConvPixel(OrigBitmap.Palette[p_byte^]);
            inc(p_byte);
          end;
        end;
      ie8g: // gray scale (256 levels)
        begin
          p_byte := OrigBitmap.Scanline[y];
          for x := 0 to OrigBitmap.width - 1 do
          begin
            ConvPixel(CreateRGB(p_byte^, p_byte^, p_byte^));
            inc(p_byte);
          end;
        end;
      ie16g: //	gray scale (65536 levels)
        begin
          p_word := OrigBitmap.Scanline[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            ConvPixel(CreateRGB(p_word^ shr 8, p_word^ shr 8, p_word^ shr 8));
            inc(p_word);
          end;
        end;
      ie24RGB: // color (true color)
        begin
          p_rgb := OrigBitmap.ScanLine[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            ConvPixel(p_rgb^);
            inc(p_rgb);
          end;
        end;
      ie32RGB: // color (true color)
        begin
          p_rgb32 := OrigBitmap.ScanLine[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            with p_rgb32^ do
              ConvPixel(CreateRGB(r,g,b));
            inc(p_rgb32);
          end;
        end;
      ie32f: //	32bit float point gray scale
        begin
          p_single := OrigBitmap.Scanline[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            ConvPixel(CreateRGB(trunc(p_single^ * 255), trunc(p_single^ * 255), trunc(p_single^ * 255)));
            inc(p_single);
          end;
        end;
      ieCMYK: // CMYK
        begin
          p_cmyk := OrigBitmap.ScanLine[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            ConvPixel(IECMYK2RGB(p_cmyk^));
            inc(p_cmyk);
          end;
        end;
      ieCIELab: // CIELab
        begin
          p_cielab := OrigBitmap.ScanLine[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            ConvPixel(IECIELAB2RGB(p_cielab^));
            inc(p_cielab);
          end;
        end;
      ie48RGB: // RGB48
        begin
          p_rgb48 := OrigBitmap.ScanLine[y];
          for x := 0 to OrigBitmap.Width - 1 do
          begin
            rgb.r:=p_rgb48^.r;
            rgb.g:=p_rgb48^.g;
            rgb.b:=p_rgb48^.b;
            ConvPixel(rgb);
            inc(p_rgb48);
          end;
        end;
    end;
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * (y + 1)));
  end;
end;

// binarization
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// blur
// thanks to Roy Magne Klever for optimized code

const
  IEMaxGaussKernelSize = 100; // New Gaussian Blur optimized
  IEKernelScale = 16;
  IEKernelMultiplier = 1 shl IEKernelScale;
  IEKernelMultiplierd2 = IEKernelMultiplier div 2;

type
  TIEGaussKernelSize = 1..IEMaxGaussKernelSize;
  TIEGaussKernel = record
    Size: TIEGaussKernelSize;
    RealWeights: array[-IEMaxGaussKernelSize..IEMaxGaussKernelSize] of double;
    IntWeights: array[-IEMaxGaussKernelSize..IEMaxGaussKernelSize] of integer;
  end;

procedure _IEMakeGaussKernel(var Kernel: TIEGaussKernel; Radius: double);
var
  J: Integer;
  Temp: double;
begin
  for J := Low(Kernel.RealWeights) to High(Kernel.RealWeights) do
  begin
    Temp := J / Radius;
    // warning! values of divisor less than 2 could make float point exception on Windows 98 (!?)
    Kernel.RealWeights[J] := Exp(-Temp * Temp / 2);
  end;
  // normalize kernel
  Temp := 0;
  for J := Low(Kernel.RealWeights) to High(Kernel.RealWeights) do
    Temp := Temp + Kernel.RealWeights[J];
  for J := Low(Kernel.RealWeights) to High(Kernel.RealWeights) do
    Kernel.IntWeights[j] := round(Kernel.RealWeights[j] * IEKernelMultiplier / Temp);
  Kernel.Size := IEMaxGaussKernelSize;
  // optimize size
  while (Kernel.Size > 1) and (Kernel.IntWeights[Kernel.Size] = 0) and (Kernel.IntWeights[-Kernel.Size] = 0) do
    dec(Kernel.Size);
end;

procedure _IEBlurRow24Bit(const Kernel: TIEGaussKernel; SourcePtr, DestPtr: PRGBROW; RowLen: Integer);
var
  RowIndex, LoopIndex, KernelIndex, StopIndex: Integer;
  Src, Dst: PRGB;
  MaxLen: Integer;
  RR, GG, BB: Integer;
  W: Integer;
begin
  MaxLen := RowLen - 1;
  Dst := @DestPtr^[0];
  for RowIndex := 0 to MaxLen do
  begin
    KernelIndex := -Kernel.Size;
    LoopIndex := RowIndex - Kernel.Size;
    StopIndex := RowIndex + Kernel.Size;
    if StopIndex > MaxLen then
      StopIndex := MaxLen;
    // start values
    RR := IEKernelMultiplierd2;
    GG := IEKernelMultiplierd2;
    BB := IEKernelMultiplierd2;
    // left part
    W := 0;
    while LoopIndex < 0 do
    begin
      inc(W, Kernel.IntWeights[KernelIndex]);
      inc(KernelIndex);
      inc(LoopIndex);
    end;
    with PRGB(SourcePtr)^ do
    begin
      inc(RR, W * r);
      inc(GG, W * g);
      inc(BB, W * b);
    end;
    Src := @SourcePtr^[LoopIndex];
    // center part
    while LoopIndex <= StopIndex do
    begin
      W := Kernel.IntWeights[KernelIndex];
      with Src^ do
      begin
        inc(RR, W * r);
        inc(GG, W * g);
        inc(BB, W * b);
      end;
      inc(KernelIndex);
      inc(LoopIndex);
      inc(Src);
    end;
    W := 0;
    while KernelIndex <= Kernel.Size do
    begin
      inc(W, Kernel.IntWeights[KernelIndex]);
      inc(KernelIndex);
    end;
    with SourcePtr^[MaxLen] do
    begin
      inc(RR, W * r);
      inc(GG, W * g);
      inc(BB, W * b);
    end;
    // set pixel
    with Dst^ do
    begin
      r := RR shr IEKernelScale;
      g := GG shr IEKernelScale;
      b := BB shr IEKernelScale;
    end;
    inc(Dst);
  end;
end;

procedure _IEBlurRow8Bit(const Kernel: TIEGaussKernel; SourcePtr, DestPtr: pbytearray; RowLen: Integer);
var
  RowIndex, LoopIndex, StopIndex: Integer;
  KernelPt,KernelEnd:pinteger;
  KernelSize:integer;
  Src, Dst, Stp: pbyte;
  MaxLen: Integer;
  GR: Integer;
  W: Integer;
begin
  MaxLen := RowLen - 1;
  Dst := @DestPtr^[0];
  KernelEnd:=@Kernel.IntWeights[Kernel.Size];
  KernelSize:=Kernel.Size;
  for RowIndex := 0 to MaxLen do
  begin
    GR := IEKernelMultiplierd2;
    KernelPt := @Kernel.IntWeights[-KernelSize];
    LoopIndex := RowIndex - KernelSize;
    StopIndex := RowIndex + KernelSize;
    if StopIndex > MaxLen then
      StopIndex := MaxLen;
    W := 0;
    while LoopIndex < 0 do
    begin
      inc(W, KernelPt^);
      inc(KernelPt);
      inc(LoopIndex);
    end;
    inc(GR, W * SourcePtr[0]);
    Src := @SourcePtr^[LoopIndex];
    Stp := @SourcePtr^[StopIndex];
    while longword(Src) <= longword(Stp) do
    begin
      W := KernelPt^;
      inc(GR, W * Src^);
      inc(KernelPt);
      inc(Src);
    end;
    W := 0;
    while longword(KernelPt) <= longword(KernelEnd) do
    begin
      inc(W, KernelPt^);
      inc(KernelPt);
    end;
    inc(GR, W * SourcePtr^[MaxLen]);
    // set pixel
    Dst^ := GR shr IEKernelScale;
    inc(Dst);
  end;
end;

procedure _IEGBlur(Bitmap: TIEBitmap; radius: double; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  X, Y: Integer;
  RowPtr, ColPtr: PRGBROW;
  RowPtr8, ColPtr8: pbytearray;
  Kernel: TIEGaussKernel;
  per: double;
begin
  if Radius > 0 then
  begin
    // calculate kernel
    per := 100 / (Bitmap.Height + Bitmap.Width);
    _IEMakeGaussKernel(Kernel, Radius);
    case Bitmap.PixelFormat of
      ie24RGB:
        begin
          if Bitmap.Width > Bitmap.Height then
            GetMem(RowPtr, Bitmap.Width * SizeOf(TRGB))
          else
            GetMem(RowPtr, Bitmap.Height * SizeOf(TRGB));
          // blur rows
          for Y := 0 to Bitmap.Height - 1 do
          begin
            _IEBlurRow24Bit(Kernel, Bitmap.ScanLine[y], RowPtr, Bitmap.Width);
            copymemory(Bitmap.ScanLine[Y], RowPtr, Bitmap.Width * SizeOf(TRGB));
            if assigned(fOnProgress) then
              fOnProgress(Sender, trunc(per * Y));
          end;
          // blur columns
          GetMem(ColPtr, Bitmap.Height * SizeOf(TRGB));
          for X := 0 to Bitmap.Width - 1 do
          begin
            for Y := 0 to Bitmap.Height - 1 do
              RowPtr[Y] := PRGBROW(Bitmap.Scanline[y])[x];
            _IEBlurRow24Bit(Kernel, RowPtr, ColPtr, Bitmap.Height);
            for Y := 0 to Bitmap.Height - 1 do
              PRGBROW(Bitmap.Scanline[y])[x] := ColPtr[Y];
            if assigned(fOnProgress) then
              fOnProgress(Sender, trunc(per * (X + Bitmap.Height)));
          end;
          FreeMem(ColPtr);
          FreeMem(RowPtr);
        end;
      ie8g:
        begin
          if Bitmap.Width > Bitmap.Height then
            GetMem(RowPtr8, Bitmap.Width)
          else
            GetMem(RowPtr8, Bitmap.Height);
          // blur rows
          for Y := 0 to Bitmap.Height - 1 do
          begin
            _IEBlurRow8Bit(Kernel, Bitmap.ScanLine[y], RowPtr8, Bitmap.Width);
            copymemory(Bitmap.ScanLine[Y], RowPtr8, Bitmap.Width);
            if assigned(fOnProgress) then
              fOnProgress(Sender, trunc(per * Y));
          end;
          // blur columns
          GetMem(ColPtr8, Bitmap.Height);
          for X := 0 to Bitmap.Width - 1 do
          begin
            for Y := 0 to Bitmap.Height - 1 do
              RowPtr8[Y] := pbytearray(Bitmap.Scanline[y])[x];
            _IEBlurRow8Bit(Kernel, RowPtr8, ColPtr8, Bitmap.Height);
            for Y := 0 to Bitmap.Height - 1 do
              pbytearray(Bitmap.Scanline[y])[x] := ColPtr8[Y];
            if assigned(fOnProgress) then
              fOnProgress(Sender, trunc(per * (X + Bitmap.Height)));
          end;
          FreeMem(ColPtr8);
          FreeMem(RowPtr8);
        end;
    end;
  end;
end;

procedure _IEGBlurRect8(Bitmap: TIEBitmap; x1, y1, x2, y2: integer; radius: double);
var
  X, Y, ww, hh: Integer;
  RowPtr8, ColPtr8: pbytearray;
  Kernel: TIEGaussKernel;
  p: pbyte;
begin
  if Bitmap.PixelFormat <> ie8g then
    exit;
  x1:=ilimit(x1,0,Bitmap.Width-1);
  y1:=ilimit(y1,0,Bitmap.Height-1);
  x2:=ilimit(x2,0,Bitmap.Width-1);
  y2:=ilimit(y2,0,Bitmap.Height-1);
  if Radius > 0 then
  begin
    // calculate kernel
    _IEMakeGaussKernel(Kernel, Radius);
    ww := x2 - x1 + 1;
    hh := y2 - y1 + 1;
    if ww > hh then
      GetMem(RowPtr8, ww)
    else
      GetMem(RowPtr8, hh);
    // blur rows
    for Y := y1 to y2 do
    begin
      p := Bitmap.ScanLine[y];
      inc(p, x1);
      _IEBlurRow8Bit(Kernel, pointer(p), RowPtr8, ww);
      copymemory(p, RowPtr8, ww);
    end;
    // blur columns
    GetMem(ColPtr8, hh);
    for X := x1 to x2 do
    begin
      for Y := y1 to y2 do
        RowPtr8[Y - y1] := pbytearray(Bitmap.Scanline[y])[x];
      _IEBlurRow8Bit(Kernel, RowPtr8, ColPtr8, hh);
      for Y := y1 to y2 do
        pbytearray(Bitmap.Scanline[y])[x] := ColPtr8[Y - y1];
    end;
    FreeMem(ColPtr8);
    FreeMem(RowPtr8);
  end;
end;

// make gaussian blur
// PixelFormat can be: ie8g and ie24RGB

{!!
<FS>TImageEnProc.Blur

<FM>Declaration<FC>
procedure Blur(radius:double);

<FM>Description<FN>
Blur performs a Gaussian Blur filter with specified radius (>0).

<FM>Example<FC>
ImageEnProc.Blur(4);

!!}
procedure TImageEnProc.Blur(radius: double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB, ie8g], x1, y1, x2, y2, Format(IERS_BLUR, [radius]), ProcBitmap, mask) then
    exit;
  _IEGBlur(ProcBitmap, radius, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// blur
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// intensity 0..100
procedure _IEAddSoftShadow(bitmap: TIEBitmap; radius: double; OffSetX: integer; OffSetY: integer; Intensity:integer; AdaptBitmap: boolean; ShadowColor: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  oldalpha: TIEBitmap;
  x, y, sz, omax: integer;
  po, pn, pb: pbyte;
  px: PRGB;
  dint:double;
  bint:boolean;
  dd,ao,an:double;
  s:TRGB;
begin
  bitmap.AlphaChannel.Full := false; // here we also create the alphachannel if doesn't exists
  if AdaptBitmap then
  begin
    // enlarge bitmap
    omax := imax(abs(OffSetX), abs(OffsetY)) * 2;
    sz := imax(trunc(radius * 5) + omax, 1);
    bitmap.Resize(bitmap.Width + sz, bitmap.Height + sz, 0, 0, iehCenter, ievCenter);
  end;

  oldalpha := TIEBitmap.Create;
  oldalpha.Assign(bitmap.AlphaChannel);
  _IEGBlur(bitmap.AlphaChannel, radius, fOnProgress, Sender);

  if (offsetx <> 0) or (offsety <> 0) then
    bitmap.AlphaChannel.MoveRegion(0, 0, bitmap.AlphaChannel.Width - 1, bitmap.AlphaChannel.Height - 1, offsetx, offsety, 0);

  dint:=3-(ilimit(Intensity,0,100)/100*2); // 1=max 3=min
  bint:=dint<>1;

  case bitmap.PixelFormat of
    ie24RGB:
      for y := 0 to bitmap.AlphaChannel.Height - 1 do
      begin
        po := oldalpha.Scanline[y];
        pn := bitmap.AlphaChannel.scanline[y];
        px := bitmap.Scanline[y];
        for x := 0 to bitmap.AlphaChannel.Width - 1 do
        begin

          if (po^ = 0) and (po^ <> pn^) then
          begin
            px^ := ShadowColor;
            if bint then
              pn^ := trunc(pn^ / dint);
          end
          else
          begin
            if (po^<255) and (po^>0) then
            begin
              ao:=po^/255;
              an:=pn^/255;
              dd:=ao + an*(1-ao);
              s.r:=trunc( ShadowColor.r*an + (1-an)*px^.r );
              s.g:=trunc( ShadowColor.g*an + (1-an)*px^.g );
              s.b:=trunc( ShadowColor.b*an + (1-an)*px^.b );
              px^.r:= trunc( px^.r*ao + (1-ao)*s.r );
              px^.g:= trunc( px^.g*ao + (1-ao)*s.g );
              px^.b:= trunc( px^.b*ao + (1-ao)*s.b );
              pn^:=trunc(dd*255);
            end
            else
              pn^ := po^;
          end;

          inc(po);
          inc(pn);
          inc(px);
        end;
      end;
    ie1g:
      for y := 0 to bitmap.AlphaChannel.Height - 1 do
      begin
        po := oldalpha.Scanline[y];
        pn := bitmap.AlphaChannel.scanline[y];
        pb := bitmap.Scanline[y];
        for x := 0 to bitmap.AlphaChannel.Width - 1 do
        begin
          if (po^ = 0) and (po^ <> pn^) then
          begin
            _SetPixelbw(pb, x, 0);
            if bint then
              pn^ := trunc(pn^ / dint);
          end
          else
          begin
            pn^ := po^;
          end;
          inc(po);
          inc(pn);
        end;
      end;
  end;
  FreeAndNil(oldalpha);
end;

procedure _IEAddInnerShadow(bitmap: TIEBitmap; radius: double; OffSetX: integer; OffSetY: integer; ShadowColor: TRGB; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  tmpalpha: TIEBitmap;
  omax,sz,x, y,a: integer;
  px: PRGB;
  pb: pbyte;
begin
  bitmap.AlphaChannel.Full := false; // here we also create the alphachannel if doesn't exists
  //
  tmpalpha := TIEBitmap.Create;
  tmpalpha.Assign(bitmap.AlphaChannel);

  omax := imax(abs(OffSetX), abs(OffsetY)) * 2;
  sz := imax(trunc(radius * 5) + omax, 1);
  tmpalpha.Resize(tmpalpha.Width + sz, tmpalpha.Height + sz, 0, 0, iehCenter, ievCenter);

  _IEGBlur(tmpalpha, radius, fOnProgress, Sender);

  if (offsetx <> 0) or (offsety <> 0) then
    tmpalpha.MoveRegion(0, 0, bitmap.Width - 1, bitmap.Height - 1, offsetx, offsety, 0);

  case bitmap.PixelFormat of
    ie24RGB:
      begin
        for y := 0 to bitmap.Height - 1 do
        begin
          px:=bitmap.Scanline[y];
          pb:=tmpalpha.Scanline[sz div 2 +y]; inc(pb, sz div 2);
          for x := 0 to bitmap.Width - 1 do
          begin

            a:=(255-pb^) shl 10;
            with px^ do
            begin
              r := (a * (ShadowColor.r - r) shr 18 + r);
              g := (a * (ShadowColor.g - g) shr 18 + g);
              b := (a * (ShadowColor.b - b) shr 18 + b);
            end;

            inc(px);
            inc(pb);
          end;
        end;
      end;
  end;

  FreeAndNil(tmpalpha);
end;

{!!
<FS>TImageEnProc.AddSoftShadow

<FM>Declaration<FC>
procedure AddSoftShadow(radius: double; OffSetX: integer; OffSetY: integer; AdaptSize: boolean; ShadowColor: TColor; Intensity:integer);

<FM>Description<FN>
AddSoftShadow adds a soft shadow (Gaussian Shadow) to the image.
AddSoftShadow creates the shadow effect using the image's alpha channel (creates it if it doesn't exist).
To see the effect, set <A TImageEnView.EnableAlphaChannel>=true.

<FC>radius<FN> specifies the shadow wide.
<FC>OffsetX<FN> and <FC>OffsetY<FN> specify the shadow offset from the image.
If <FC>AdaptSize<FN> is true (the default) the image is resized to contain the shadow.
<FC>ShadowColor<FN> (default black) is the shadow color.
<FC>Intensity<FN> (default 100) is the shadow intensity, with values in the range 0 and 100 (maximum).

<FM>Example<FC>
// the light comes from top-left
ImageEnProc.AddSoftShadow(5, 4,4);

// the light comes from bottom-right
ImageEnProc.AddSoftShadow(5, -4, -4);
!!}
// radius is the half of the shadow (ex radius=2, the shadow is 4 pixels)
procedure TImageEnProc.AddSoftShadow(radius: double; OffSetX: integer; OffSetY: integer; AdaptSize: boolean; ShadowColor: TColor; Intensity:integer);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_ADDSOFTSHADOW, ieuImage);
  _IEAddSoftShadow(fIEBitmap, radius, OffSetX, OffSetY, Intensity, AdaptSize, TColor2TRGB(ShadowColor), fOnProgress, self);
  Update;
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.AddInnerShadow

<FM>Declaration<FC>
procedure AddInnerShadow(radius: double; OffSetX: integer; OffSetY: integer; ShadowColor: TColor = clBlack);

<FM>Description<FN>
AddInnserShadow creates a shadow in the inner border of the image.

!!}
procedure TImageEnProc.AddInnerShadow(radius: double; OffSetX: integer; OffSetY: integer; ShadowColor: TColor);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_ADDINNERSHADOW, ieuImage);
  _IEAddInnerShadow(fIEBitmap, radius, OffSetX, OffSetY, TColor2TRGB(ShadowColor), fOnProgress, self);
  Update;
  DoFinishWork;
end;

// radius is 0 use a 3x3 filter (fast)
// intensity 0..100
function _IEAddSoftShadowRect(bitmap: TIEBitmap; radius: double; OffSetX: integer; OffSetY: integer; Intensity:integer; ShadowColor: TRGB; x1, y1, x2, y2: integer): integer;
var
  oldalpha: TIEBitmap;
  x, y: integer;
  po, pn, pb: pbyte;
  px: PRGB;
  sz, omax, sz2: integer;
  xx1, yy1, xx2, yy2: integer;
  filt: boolean;
  dint:double;
  bint:boolean;
  dd,ao,an:double;
  s:TRGB;
begin
  filt := radius = 0;
  if filt then
    radius := 2;
  omax := imax(abs(OffSetX), abs(OffsetY)) * 2;
  sz := imax(trunc(radius * 5) + omax, 1);
  sz2 := sz div 2;
  result := sz;
  //
  bitmap.AlphaChannel.Full := false; // here we also create the alphachannel if doesn't exists
  //
  oldalpha := TIEBitmap.Create;
  oldalpha.Assign(bitmap.AlphaChannel);
  xx1 := x1 - sz2;
  yy1 := y1 - sz2;
  xx2 := x2 + sz2;
  yy2 := y2 + sz2;
  xx1 := imin(imax(0, xx1), Bitmap.Width - 1);
  yy1 := imin(imax(0, yy1), Bitmap.Height - 1);
  xx2 := imin(imax(0, xx2), Bitmap.Width - 1);
  yy2 := imin(imax(0, yy2), Bitmap.Height - 1);
  if filt then
  begin
    _ApplyFilter8g(Bitmap.AlphaChannel, PIEGraphFilter(IEFiltPres[1])^, xx1, yy1, xx2, yy2);
  end
  else
    _IEGBlurRect8(Bitmap.AlphaChannel, xx1, yy1, xx2, yy2, radius);
  //
  if (offsetx <> 0) or (offsety <> 0) then
    bitmap.AlphaChannel.MoveRegion(xx1, yy1, xx2, yy2, xx1 + offsetx, yy1 + offsety, 0);
  //
  dec(x1, sz);
  inc(x2, sz);
  dec(y1, sz);
  inc(y2, sz);
  x1 := imin(imax(x1, 0), bitmap.Width - 1);
  y1 := imin(imax(y1, 0), bitmap.Height - 1);
  x2 := imin(imax(x2, 0), bitmap.Width - 1);
  y2 := imin(imax(y2, 0), bitmap.Height - 1);

  dint:=3-(ilimit(Intensity,0,100)/100*2); // 1=max 3=min
  bint:=dint<>1;

  case bitmap.PixelFormat of
    ie24RGB:
      for y := y1 to y2 do
      begin
        po := oldalpha.Scanline[y];
        inc(po, x1);
        pn := bitmap.AlphaChannel.Scanline[y];
        inc(pn, x1);
        px := bitmap.Scanline[y];
        inc(px, x1);
        for x := x1 to x2 do
        begin
          if (po^ = 0) and (po^ <> pn^) then
          begin
            px^:=ShadowColor;
            if bint then
              pn^ := trunc(pn^ / dint);
          end
          else
          begin
            if (po^<255) and (po^>0) then
            begin
              ao:=po^/255;
              an:=pn^/255;
              dd:=ao + an*(1-ao);
              s.r:=trunc( ShadowColor.r*an + (1-an)*px^.r );
              s.g:=trunc( ShadowColor.g*an + (1-an)*px^.g );
              s.b:=trunc( ShadowColor.b*an + (1-an)*px^.b );
              px^.r:= trunc( px^.r*ao + (1-ao)*s.r );
              px^.g:= trunc( px^.g*ao + (1-ao)*s.g );
              px^.b:= trunc( px^.b*ao + (1-ao)*s.b );
              pn^:=trunc(dd*255);
            end
            else
              pn^ := po^;
          end;

          inc(po);
          inc(pn);
          inc(px);
        end;
      end;
    ie1g:
      for y := y1 to y2 do
      begin
        po := oldalpha.Scanline[y];
        pn := bitmap.AlphaChannel.scanline[y];
        pb := bitmap.Scanline[y];
        for x := x1 to x2 do
        begin
          if (po^ = 0) and (po^ <> pn^) then
            _SetPixelbw(pb, x, 0)
          else
            pn^ := po^;
          inc(po);
          inc(pn);
        end;
      end;
  end;
  FreeAndNil(oldalpha);
end;

(*
procedure _IEAddSoftShadowRect2(bitmap: TIEBitmap; size: integer; Intensity: double; OffsetX, OffsetY: integer; rx1, ry1, rx2, ry2: integer);
var
  x, y: integer;
  outbitmap: TIEBitmap;
  halfsize: integer;
  kk: pdoublearray;
  p0, p1, p2,
    p3, p4,
    p5, p6, p7: integer;
  x1, x2: integer;
  y1, y2: integer;
  k2d: ppointerarray;
  pym1, py, pyp1: pbyte;
  inp, oup: pbyte;
  width, height: integer;
  rrx1, rrx2: integer;
  rry1, rry2: integer;
  prgb1: PRGB;
  //
  procedure MakeGaussKernel1D(Kernel: pdoublearray; KernelLen: integer; Radius: double);
  var
    J: Integer;
    Temp: double;
    d: integer;
  begin
    d := KernelLen div 2;
    for J := 0 to KernelLen - 1 do
    begin
      Temp := (J - d) / Radius;
      Kernel[J] := Exp(-Intensity - Temp * Temp / 2);
    end;
  end;
  //
  procedure IEDrawSpot8g;
  var
    xx, yy: integer;
    px: pbyte;
    pi: pinteger;
  begin
    for yy := y1 to y2 do
    begin
      px := outbitmap.Scanline[yy - ry1];
      inc(px, x1 - rx1);
      pi := k2d[yy - (y + OffsetY) + halfsize];
      inc(pi, x1 - (x + OffsetX) + halfsize);
      for xx := x1 to x2 do
      begin
        px^ := imax(px^, pi^ * inp^ shr 16);
        inc(px);
        inc(pi);
      end;
    end;
  end;
  //
begin
  Intensity := (100 - Intensity) / 100;
  halfsize := size div 2;
  getmem(kk, sizeof(double) * size);

  MakeGaussKernel1D(kk, size, size / 5);

  getmem(k2d, sizeof(pointer) * size);
  for y := 0 to size - 1 do
  begin
    getmem(k2d[y], sizeof(integer) * size);
    for x := 0 to size - 1 do
      pintegerarray(k2d[y])[x] := trunc(kk[x] * kk[y] * 65536);
  end;
  freemem(kk);

  rx1 := imax(rx1 - halfsize, 0);
  ry1 := imax(ry1 - halfsize, 0);
  rx2 := imin(rx2 + halfsize, bitmap.width - 1);
  ry2 := imin(ry2 + halfsize, bitmap.height - 1);

  width := rx2 - rx1 + 1;
  height := ry2 - ry1 + 1;
  outbitmap := TIEBitmap.Create;
  outbitmap.Allocate(width, height, ie8g);
  outbitmap.Fill(0);
  //
  rrx1 := imax(rx1, 1);
  rrx2 := imin(rx2, bitmap.width - 2);
  rry1 := imax(ry1, 1);
  rry2 := imin(ry2, bitmap.height - 2);
  for y := rry1 to rry2 do
  begin
    y1 := imax(y + OffsetY - halfsize, 0);
    y2 := imin(y + OffsetY + halfsize - 1, bitmap.height - 1);
    pym1 := bitmap.alphachannel.GetRow(y - 1);
    py := bitmap.alphachannel.GetRow(y);
    pyp1 := bitmap.alphachannel.GetRow(y + 1);
    inp := py;
    oup := outbitmap.GetRow(y - ry1);
    inc(oup, rrx1 - rx1);
    inc(inp, rrx1);
    for x := rrx1 to rrx2 do
    begin
      if inp^ > 0 then
      begin
        p0 := pbytearray(pym1)[x - 1];
        p1 := pbytearray(pym1)[x];
        p2 := pbytearray(pym1)[x + 1];
        //
        p3 := pbytearray(py)[x - 1];
        p4 := pbytearray(py)[x + 1];
        //
        p5 := pbytearray(pyp1)[x - 1];
        p6 := pbytearray(pyp1)[x];
        p7 := pbytearray(pyp1)[x + 1];
        if p0 + p1 + p2 + p3 + p4 + p5 + p6 + p7 < 2040 then
        begin
          x1 := imax(x + OffsetX - halfsize, 0);
          x2 := imin(x + OffsetX + halfsize - 1, bitmap.width - 1);
          IEDrawSpot8g;
        end;
        oup^ := inp^;
      end;
      inc(inp);
      inc(oup);
    end;
    bitmap.alphachannel.FreeRow(y - 1);
    bitmap.alphachannel.FreeRow(y);
    bitmap.alphachannel.FreeRow(y + 1);
    outbitmap.FreeRow(y);
  end;
  //
  for y := ry1 to ry2 do
  begin
    prgb1 := bitmap.Scanline[y];
    inc(prgb1, rx1);
    inp := outbitmap.Scanline[y - ry1];
    oup := bitmap.alphachannel.Scanline[y];
    inc(oup, rx1);
    for x := rx1 to rx2 do
    begin
      if oup^ = 0 then
        with prgb1^ do
        begin
          r := 0;
          g := 0;
          b := 0;
        end;
      oup^ := inp^;
      inc(inp);
      inc(oup);
      inc(prgb1);
    end;
  end;
  //
  for y := 0 to size - 1 do
    freemem(k2d[y]);
  freemem(k2d);
end;
*)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// QRotate

// for AntialiasMode supports only Bilinear and Bicubic
procedure _IEQRotate(src: TIEBitmap; angle: double; Background: TColor; Filter: TIEAntialiasMode; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  fx, fy, a, tsin, tcos, cxSrc, cySrc, cxDest, cyDest: double;
  dw, dh, width, height, x, y: integer;
  bColor: TRGB;
  dest: TIEBitmap;
  //
  procedure RC(x, y: integer; var rgb: TRGB);
  begin
    if (x <= width - 1) and (x >= 0) and (y <= height - 1) and (y >= 0) then
      rgb := PRGBROW(src.Scanline[y])^[x]
    else
      rgb := bColor;
  end;
  //
  function Bilinear(x, y: double): TRGB;
  var
    j, k, rr, gg, bb: integer;
    cx, cy, m0, m1: double;
    p0, p1, p2, p3: TRGB;
  begin
    j := trunc(x);
    k := trunc(y);
    cx := x - floor(x);
    cy := y - floor(y);
    RC(j, k, p0);
    RC(j + 1, k, p1);
    RC(j, k + 1, p2);
    RC(j + 1, k + 1, p3);
    with p0 do
      m0 := r + cx * (p1.r - r);
    with p2 do
      m1 := r + cx * (p3.r - r);
    rr := trunc(m0 + cy * (m1 - m0));
    with p0 do
      m0 := g + cx * (p1.g - g);
    with p2 do
      m1 := g + cx * (p3.g - g);
    gg := trunc(m0 + cy * (m1 - m0));
    with p0 do
      m0 := b + cx * (p1.b - b);
    with p2 do
      m1 := b + cx * (p3.b - b);
    bb := trunc(m0 + cy * (m1 - m0));
    with result do
    begin
      r := rr;
      g := gg;
      b := bb;
    end;
  end;
  //
  function Bicubic(x, y: double): TRGB;
  var
    cr, cg, cb, j, k: integer;
    a, aa, b, bb, cc, dd, ee, ff, gg, hh, fr, fg, fb: double;
    t1, t2, t3, t4: double;
    p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16: TRGB;
  begin
    j := trunc(x);
    k := trunc(y);
    a := x - j;
    b := y - k;
    aa := -a * (1 - a) * (1 - a);
    bb := (1 - 2 * a * a + a * a * a);
    cc := a * (1 + a - a * a);
    dd := a * a * (1 - a);
    ee := -b * (1 - b) * (1 - b);
    ff := (1 - 2 * b * b + b * b * b);
    gg := b * (1 + b - b * b);
    hh := b * b * (b - 1);
    RC(j - 1, k - 1, p1);
    RC(j, k - 1, p2);
    RC(j + 1, k - 1, p3);
    RC(j + 2, k - 1, p4);
    RC(j - 1, k, p5);
    RC(j, k, p6);
    RC(j + 1, k, p7);
    RC(j + 2, k, p8);
    RC(j - 1, k + 1, p9);
    RC(j, k + 1, p10);
    RC(j + 1, k + 1, p11);
    RC(j + 2, k + 1, p12);
    RC(j - 1, k + 2, p13);
    RC(j, k + 2, p14);
    RC(j + 1, k + 2, p15);
    RC(j + 2, k + 2, p16);
    t1 := aa * p1.r + bb * p2.r + cc * p3.r - dd * p4.r;
    t2 := aa * p5.r + bb * p6.r + cc * p7.r - dd * p8.r;
    t3 := aa * p9.r + bb * p10.r + cc * p11.r - dd * p12.r;
    t4 := aa * p13.r + bb * p14.r + cc * p15.r - dd * p16.r;
    fr := ee * t1 + ff * t2 + gg * t3 + hh * t4;
    t1 := aa * p1.g + bb * p2.g + cc * p3.g - dd * p4.g;
    t2 := aa * p5.g + bb * p6.g + cc * p7.g - dd * p8.g;
    t3 := aa * p9.g + bb * p10.g + cc * p11.g - dd * p12.g;
    t4 := aa * p13.g + bb * p14.g + cc * p15.g - dd * p16.g;
    fg := ee * t1 + ff * t2 + gg * t3 + hh * t4;
    t1 := aa * p1.b + bb * p2.b + cc * p3.b - dd * p4.b;
    t2 := aa * p5.b + bb * p6.b + cc * p7.b - dd * p8.b;
    t3 := aa * p9.b + bb * p10.b + cc * p11.b - dd * p12.b;
    t4 := aa * p13.b + bb * p14.b + cc * p15.b - dd * p16.b;
    fb := ee * t1 + ff * t2 + gg * t3 + hh * t4;
    cr := trunc(fr);
    cg := trunc(fg);
    cb := trunc(fb);
    if cr < 0 then
      cr := abs(cr);
    if (cr > 255) then
      cr := 255;
    if cg < 0 then
      cg := abs(cg);
    if (cg > 255) then
      cg := 255;
    if cb < 0 then
      cb := abs(cb);
    if (cb > 255) then
      cb := 255;
    with result do
    begin
      r := cr;
      g := cg;
      b := cb;
    end;
  end;
  //
var
  px: PRGB;
  arx1, arx2: pdoublearray;
  ary1, ary2: double;
  per: double;
begin
  bColor := TColor2TRGB(Background);
  src.Resize(src.Width + 6, src.Height + 6, Background, 255, iehLeft, ievTop);
  src.MoveRegion(0, 0, src.Width - 1 - 3, src.Height - 1 - 3, 3, 3, Background);
  width := src.Width;
  height := src.Height;
  a := angle * pi / 180;
  dw := round(abs((width - 1) * cos(a)) + abs((height - 1) * sin(a)));
  dh := round(abs((width - 1) * sin(a)) + abs((height - 1) * cos(a)));
  dest := TIEBitmap.Create;
  dest.Allocate(dw, dh, ie24RGB);
  tsin := sin(a);
  tcos := cos(a);
  cxSrc := (src.Width - 1) / 2;
  cySrc := (src.Height - 1) / 2;
  cxDest := (dest.Width - 1) / 2;
  cyDest := (dest.Height - 1) / 2;
  getmem(arx1, sizeof(double) * dest.Width);
  getmem(arx2, sizeof(double) * dest.Width);
  for x := 0 to dest.Width - 1 do
  begin
    arx1[x] := cxSrc + (x - cxDest) * tcos;
    arx2[x] := cySrc + (x - cxDest) * tsin;
  end;
  per := 100 / (dest.Height);
  for y := 0 to dest.Height - 1 do
  begin
    px := dest.Scanline[y];
    ary1 := (y - cyDest) * tsin;
    ary2 := (y - cyDest) * tcos;
    for x := 0 to dest.Width - 1 do
    begin
      fx := arx1[x] - ary1;
      fy := arx2[x] + ary2;
      case Filter of
        ierBilinear: px^ := Bilinear(fx, fy);
        ierBicubic: px^ := BiCubic(fx, fy);
      end;
      inc(px);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per * y));
  end;
  freemem(arx1);
  freemem(arx2);
  src.AssignImage(dest);
  src.MoveRegion(3, 3, src.Width - 1 - 3, src.Height - 1 - 3, 0, 0, Background);
  src.Resize(src.Width - 6, src.Height - 6, Background, 255, iehLeft, ievTop);
  FreeAndNil(dest);
end;

// accept ie8g and ie8p

procedure _IEQRotate8(src: TIEBitmap; angle: double; Background: integer; Filter: TIEAntialiasMode);
var
  fx, fy, a, tsin, tcos, cxSrc, cySrc, cxDest, cyDest: double;
  dw, dh, width, height, x, y: integer;
  bColor: integer;
  dest: TIEBitmap;
  //
  procedure RC(x, y: integer; var col: integer);
  begin
    if (x <= width - 1) and (x >= 0) and (y <= height - 1) and (y >= 0) then
      col := pbytearray(src.Scanline[y])^[x]
    else
      col := bColor;
  end;
  //
  function Bilinear(x, y: double): integer;
  var
    j, k: integer;
    cx, cy, m0, m1: double;
    p0, p1, p2, p3: integer;
  begin
    j := trunc(x);
    k := trunc(y);
    cx := x - floor(x);
    cy := y - floor(y);
    RC(j, k, p0);
    RC(j + 1, k, p1);
    RC(j, k + 1, p2);
    RC(j + 1, k + 1, p3);
    m0 := p0 + cx * (p1 - p0);
    m1 := p2 + cx * (p3 - p2);
    result := trunc(m0 + cy * (m1 - m0));
  end;
  //
  function Bicubic(x, y: double): integer;
  var
    cr, j, k: integer;
    a, aa, b, bb, cc, dd, ee, ff, gg, hh, fr: double;
    t1, t2, t3, t4: double;
    p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16: integer;
  begin
    j := trunc(x);
    k := trunc(y);
    a := x - j;
    b := y - k;
    aa := -a * (1 - a) * (1 - a);
    bb := (1 - 2 * a * a + a * a * a);
    cc := a * (1 + a - a * a);
    dd := a * a * (1 - a);
    ee := -b * (1 - b) * (1 - b);
    ff := (1 - 2 * b * b + b * b * b);
    gg := b * (1 + b - b * b);
    hh := b * b * (b - 1);
    RC(j - 1, k - 1, p1);
    RC(j, k - 1, p2);
    RC(j + 1, k - 1, p3);
    RC(j + 2, k - 1, p4);
    RC(j - 1, k, p5);
    RC(j, k, p6);
    RC(j + 1, k, p7);
    RC(j + 2, k, p8);
    RC(j - 1, k + 1, p9);
    RC(j, k + 1, p10);
    RC(j + 1, k + 1, p11);
    RC(j + 2, k + 1, p12);
    RC(j - 1, k + 2, p13);
    RC(j, k + 2, p14);
    RC(j + 1, k + 2, p15);
    RC(j + 2, k + 2, p16);
    t1 := aa * p1 + bb * p2 + cc * p3 - dd * p4;
    t2 := aa * p5 + bb * p6 + cc * p7 - dd * p8;
    t3 := aa * p9 + bb * p10 + cc * p11 - dd * p12;
    t4 := aa * p13 + bb * p14 + cc * p15 - dd * p16;
    fr := ee * t1 + ff * t2 + gg * t3 + hh * t4;
    cr := trunc(fr);
    if cr < 0 then
      cr := abs(cr);
    if (cr > 255) then
      cr := 255;
    result := cr;
  end;
  //
var
  px: pbyte;
  arx1, arx2: pdoublearray;
  ary1, ary2: double;
begin
  bColor := Background;
  src.Resize(src.Width + 6, src.Height + 6, Background, 255, iehLeft, ievTop);
  src.MoveRegion(0, 0, src.Width - 1 - 3, src.Height - 1 - 3, 3, 3, Background);
  width := src.Width;
  height := src.Height;
  a := angle * pi / 180;
  dw := round(abs((width - 1) * cos(a)) + abs((height - 1) * sin(a)));
  dh := round(abs((width - 1) * sin(a)) + abs((height - 1) * cos(a)));
  dest := TIEBitmap.Create;
  dest.Allocate(dw, dh, src.PixelFormat);
  tsin := sin(a);
  tcos := cos(a);
  cxSrc := (src.Width - 1) / 2;
  cySrc := (src.Height - 1) / 2;
  cxDest := (dest.Width - 1) / 2;
  cyDest := (dest.Height - 1) / 2;
  getmem(arx1, sizeof(double) * dest.Width);
  getmem(arx2, sizeof(double) * dest.Width);
  for x := 0 to dest.Width - 1 do
  begin
    arx1[x] := cxSrc + (x - cxDest) * tcos;
    arx2[x] := cySrc + (x - cxDest) * tsin;
  end;
  for y := 0 to dest.Height - 1 do
  begin
    px := dest.Scanline[y];
    ary1 := (y - cyDest) * tsin;
    ary2 := (y - cyDest) * tcos;
    for x := 0 to dest.Width - 1 do
    begin
      fx := arx1[x] - ary1;
      fy := arx2[x] + ary2;
      case Filter of
        ierBilinear: px^ := Bilinear(fx, fy);
        ierBicubic: px^ := BiCubic(fx, fy);
      end;
      inc(px);
    end;
  end;
  freemem(arx1);
  freemem(arx2);
  src.AssignImage(dest);
  src.MoveRegion(3, 3, src.Width - 1 - 3, src.Height - 1 - 3, 0, 0, Background);
  src.Resize(src.Width - 6, src.Height - 6, Background, 255, iehLeft, ievTop);
  FreeAndNil(dest);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// generic rotate

procedure IEGRotate(src: TIEBitmap; angle: double; Background: TColor; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  a: double;
  dw, dh, width, height: integer;
  dest: TIEBitmap;
begin
  width := src.Width;
  height := src.Height;
  a := angle * pi / 180;
  dw := round(abs(width * cos(a)) + abs(height * sin(a)));
  dh := round(abs(width * sin(a)) + abs(height * cos(a)));
  dest := TIEBitmap.Create;
  dest.Allocate(dw, dh, src.PixelFormat);
  dest.Fill(Background);
  IEGRotateTo(src,dest,angle,Background,fOnProgress,Sender);
  src.AssignImage(dest);
  FreeAndNil(dest);
end;


procedure IEGRotateTo(src,dst: TIEBitmap; angle: double; Background: TColor; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  a, tsin, tcos, cxSrc, cySrc, cxDest, cyDest: double;
  fx,fy:integer;
  dx,dy:double;
  dw, dh, width, height, x, y: integer;
  px: pbyte;
  arx1, arx2: pintegerarray;
  ary1, ary2: integer;
  per: double;
  bytesPerPixel:integer;
  ps,pd:pbyte;
  c,d:integer;
  dw1,dh1:integer;
  prgb_s,prgb_d:PRGB;
  srcrows:ppointerarray;
  iangle:integer;

  procedure Rot90(inv:boolean);
  var
    x,y,c:integer;
    mulx,muly,addx,addy:integer;
  begin
    dw:=height; dw1:=dw-1;
    dh:=Width;  dh1:=dh-1;
    dst.Allocate(dw, dh, src.PixelFormat);
    if src.PixelFormat=ie8p then
      src.CopyPaletteTo(dst);
    if bytesPerPixel=0 then
      dst.Fill(0);
    if inv then
    begin
      mulx:=-1;
      muly:=1;
      addx:=dw1;
      addy:=0;
    end
    else
    begin
      mulx:=1;
      muly:=-1;
      addx:=0;
      addy:=dh1;
    end;
    for x := 0 to dw1 do
    begin
      ps := src.ScanLine[addx+x*mulx];
      case bytesPerPixel of
        0 : // black/white (1bit)
          for y := 0 to dh1 do
          begin
            if pbytearray(ps)^[y shr 3] and iebitmask1[y and $7] <>0 then
            begin
              pd := dst.Scanline[addy+y*muly];
              inc(pd, x shr 3);
              pd^ := pd^ or iebitmask1[x and 7];
            end;
          end;
        1 : // 1 byte
          for y := 0 to dh1 do
          begin
            pd := dst.Scanline[addy+y*muly];
            inc(pd, x);
            pd^ := ps^;
            inc(ps);
          end;
        3 : // 3 channels
          begin
            prgb_s := PRGB(ps);
            for y := 0 to dh1 do
            begin
              prgb_d := dst.Scanline[addy+y*muly];
              inc(prgb_d, x);
              prgb_d^ := prgb_s^;
              inc(prgb_s);
            end;
          end;
        else // other cases
          for y := 0 to dh1 do
          begin
            pd := dst.Scanline[addy+y*muly];
            inc(pd, x*bytesPerPixel);
            for c:=1 to bytesPerPixel do
            begin
              pd^ := ps^;
              inc(ps);
              inc(pd);
            end;
          end;

      end;
    end;
  end;

  procedure Rot180;
  var
    x,y,c:integer;
  begin
    dw:=width; dw1:=dw-1;
    dh:=height;  dh1:=dh-1;
    dst.Allocate(dw, dh, src.PixelFormat);
    if src.PixelFormat=ie8p then
      src.CopyPaletteTo(dst);
    if bytesPerPixel=0 then
      dst.Fill(0);
    for y := 0 to dh1 do
    begin
      pd:=dst.ScanLine[dh1 - y];
      ps:=src.Scanline[y];
      case bytesPerPixel of
        0 : // black/white (1bit)
          for x:=0 to dw1 do
          begin
            if pbytearray(ps)^[x shr 3] and iebitmask1[x and $7] <>0 then
            begin
              px:=pd;
              inc(px, (dw1-x) shr 3);
              px^ := px^ or iebitmask1[(dw1-x) and 7];
            end;
          end;
        1 : // 1 byte
          begin
            inc(ps,dw1);
            for x:=0 to dw1 do
            begin
              pd^ := ps^;
              inc(pd);
              dec(ps);
            end;
          end;
        3 : // 3 channels
          begin
            prgb_d := PRGB(pd);
            prgb_s := PRGB(ps);
            inc(prgb_s,dw1);
            for x := 0 to dw1 do
            begin
              prgb_d^ := prgb_s^;
              inc(prgb_d);
              dec(prgb_s);
            end;
          end;
        else  // other cases
          begin
            inc(ps,dw1*bytesPerPixel);
            for x:=0 to dw1 do
            begin
              for c:=1 to bytesPerPixel do
              begin
                pd^ := ps^;
                inc(pd);
                inc(ps);
              end;
              dec(ps,2*bytesPerPixel);
            end;
          end;
      end;
    end;
  end;

  var
    parx1, parx2:pinteger;

begin

  width := src.Width;
  height := src.Height;
  bytesPerPixel := src.BitCount div 8;

  if (Frac(angle)=0) and ((trunc(angle) mod 90) = 0) then
  begin
    iangle:=trunc(angle) mod 360;
    case iangle of
      90 : Rot90(false);
      180 : Rot180;
      270 : Rot90(true);
      -90 : Rot90(true);
      -180 : Rot180;
      -270 : Rot90(false);
      else
        dst.Assign( src );
    end;
    exit;
  end;

  a := angle * pi / 180;
  dw := round(abs(width * cos(a)) + abs(height * sin(a)));
  dh := round(abs(width * sin(a)) + abs(height * cos(a)));
  dw1:=dw-1;
  dh1:=dh-1;
  dst.Allocate(dw, dh, src.PixelFormat);
  if src.PixelFormat=ie8p then
    src.CopyPaletteTo(dst);

  if bytesPerPixel=0 then
    dst.Fill(0)
  else
    dst.Fill(Background);
  tsin := sin(a);
  tcos := cos(a);
  cxSrc := (src.Width - 1) / 2;
  cySrc := (src.Height - 1) / 2;
  cxDest := (dst.Width - 1) / 2;
  cyDest := (dst.Height - 1) / 2;
  getmem(arx1, sizeof(integer) * dst.Width);
  getmem(arx2, sizeof(integer) * dst.Width);
  for x := 0 to dst.Width - 1 do
  begin
    arx1[x] := round( cxSrc + (x - cxDest) * tcos );
    arx2[x] := round( cySrc + (x - cxDest) * tsin );
  end;
  per := 100 / (dst.Height);

  getmem(srcrows,height*sizeof(pointer));
  for y:=0 to height-1 do
    srcrows[y]:=src.GetRow(y);

  for y := 0 to dh1 do
  begin
    px := dst.Scanline[y];
    ary1 := round( (y - cyDest) * tsin );
    ary2 := round( (y - cyDest) * tcos );

    parx1 := @arx1[0];
    parx2 := @arx2[0];

    case bytesPerPixel of

      0:  // black/white (1bit)
        for x := 0 to dw1 do
        begin
          fx := parx1^ - ary1;
          fy := parx2^ + ary2;
          if (fx < width ) and (fx >= 0) and (fy < height) and (fy >= 0) then
            if pbytearray(srcrows[fy])^[fx shr 3] and iebitmask1[fx and $7] <>0 then
            begin
              pd := px;
              inc(pd, x shr 3);
              pd^ := pd^ or iebitmask1[x and 7];
            end;
          inc(parx1);
          inc(parx2);
        end;

      1:  // gray scale 8 bit
        for x := 0 to dw1 do
        begin
          fx := parx1^ - ary1;
          if (fx < width ) and (fx >= 0) then
          begin
            fy := parx2^ + ary2;
            if (fy < height) and (fy >= 0) then
            begin
              ps := srcrows[fy];
              inc(ps, fx);
              px^ := ps^;
            end;
          end;
          inc(px,bytesPerPixel);
          inc(parx1);
          inc(parx2);
        end;

      3:  // 3 channels
        begin
          prgb_d := prgb(px);
          for x := 0 to dw1 do
          begin
            fx := parx1^ - ary1;
            if (fx >= 0) and (fx < width )then
            begin
              fy := parx2^ + ary2;
              if (fy >= 0) and (fy < height) then
              begin
                prgb_s := srcrows[fy];
                inc(prgb_s, fx);
                prgb_d^ := prgb_s^;
              end;
            end;
            inc(prgb_d);
            inc(parx1);
            inc(parx2);
          end;
        end

      else

        // other cases
        for x := 0 to dw1 do
        begin
          fx := parx1^ - ary1;
          fy := parx2^ + ary2;
          if (fy < height) and (fy >= 0) and (fx < width ) and (fx >= 0) then
          begin
            ps:=srcrows[fy]; inc(ps,fx*bytesPerPixel);
            pd:=px;
            for c:=1 to bytesPerPixel do
            begin
              pd^:=ps^;
              inc(pd);
              inc(ps);
            end;
          end;
          inc(px,bytesPerPixel);
          inc(parx1);
          inc(parx2);
        end;
    end;

    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per * y));
  end;

  for y:=0 to height-1 do
    src.FreeRow(y);
  freemem(srcrows);

  freemem(arx1);
  freemem(arx2);
end;



// end of generic rotate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Bicubic and Bilinear resample

function Cubic(dx: double; jm1, j, jp1, jp2: integer; min,max:double): double;
var
  dx1, dx2, dx3: double;
  h1, h2, h3, h4: double;
begin
  dx1 := abs(dx);
  dx2 := dx1 * dx1;
  dx3 := dx2 * dx1;
  h1 := dx3 - 2 * dx2 + 1;
  result := h1 * j;
  dx1 := abs(dx - 1.0);
  dx2 := dx1 * dx1;
  dx3 := dx2 * dx1;
  h2 := dx3 - 2 * dx2 + 1;
  result := result + h2 * jp1;
  dx1 := abs(dx - 2.0);
  dx2 := dx1 * dx1;
  dx3 := dx2 * dx1;
  h3 := -dx3 + 5 * dx2 - 8 * dx1 + 4;
  result := result + h3 * jp2;
  dx1 := abs(dx + 1.0);
  dx2 := dx1 * dx1;
  dx3 := dx2 * dx1;
  h4 := -dx3 + 5 * dx2 - 8 * dx1 + 4;
  result := result + h4 * jm1;
  if (result < min) then
    result := min;
  if (result > max) then
    result := max;
end;

// filter 0=bilinear 1=bicubic
// works with ie24RGB and ie8g
procedure _IEQResampleBytes(SrcImg, DstImg: TIEBaseBitmap; filter: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  src_m1, src, src_p1, src_p2,s_m1, s, s_p1, s_p2: PByteArray;
  d, dest: PByteArray;
  r, row: PDoubleArray;
  src_row, src_col: integer;
  bytes, b: integer;
  width, height: integer;
  orig_width, orig_height: integer;
  x_rat, y_rat: double;
  x_cum, y_cum: double;
  x_last, y_last: double;
  x_frac: PDoubleArray;
  y_frac, tot_frac: Double;
  dx, dy: double;
  i, j: integer;
  frac: integer;
  advance_dest_x, advance_dest_y: boolean;
  ix, minus_x, plus_x, plus2_x: integer;
  scale_type: (MAX_MAY, MAX_MIY, MIX_MAY, MIX_MIY);
  cancel: boolean;
  lp:integer;
begin
  lp := 0;
  cancel := false;
  orig_width := SrcImg.width;
  orig_height := SrcImg.height;
  width := DstImg.width;
  height := DstImg.height;
  case SrcImg.PixelFormat of
    ie24RGB: bytes := 3;
    ie8g: bytes := 1;
  else
    exit;
  end;
  x_rat := orig_width / width;
  y_rat := orig_height / height;
  if (x_rat < 1.0) and (y_rat < 1.0) then
    scale_type := MAX_MAY
  else if (x_rat < 1.0) and (y_rat >= 1.0) then
    scale_type := MAX_MIY
  else if (x_rat >= 1.0) and (y_rat < 1.0) then
    scale_type := MIX_MAY
  else
    scale_type := MIX_MIY;
  GetMem(src_m1, orig_width * bytes);
  GetMem(src, orig_width * bytes);
  GetMem(src_p1, orig_width * bytes);
  GetMem(src_p2, orig_width * bytes);
  GetMem(dest, width * bytes);
  GetMem(row, sizeof(double) * width * bytes);
  GetMem(x_frac, sizeof(double) * (width + orig_width));
  src_col := 0;
  x_cum := src_col;
  x_last := x_cum;
  for i := 0 to (width + orig_width - 1) do
  begin
    if (x_cum + x_rat) <= (src_col + 1 + 0.0001) then
    begin
      x_cum := x_cum + x_rat;
      x_frac[i] := x_cum - x_last;
    end
    else
    begin
      inc(src_col);
      x_frac[i] := src_col - x_last;
    end;
    x_last := x_last + x_frac[i];
  end;
  FillChar(row^, sizeof(double) * width * bytes, 0);
  src_row := 0;
  y_cum := src_row;
  y_last := y_cum;
  CopyMemory(src, SrcImg.Scanline[0], orig_width * bytes);
  if src_row < (orig_height - 1) then
    CopyMemory(src_p1, SrcImg.ScanLine[1], orig_width * bytes);
  if (src_row + 1) < (orig_height - 1) then
    CopyMemory(src_p2, SrcImg.Scanline[2], orig_width * bytes);
  i := height;
  while i > 0 do
  begin
    src_col := 0;
    x_cum := src_col;
    if ((y_cum + y_rat) <= (src_row + 1 + 0.0001)) then
    begin
      y_cum := y_cum + y_rat;
      dy := y_cum - src_row;
      y_frac := y_cum - y_last;
      advance_dest_y := true;
    end
    else
    begin
      y_frac := (src_row + 1) - y_last;
      dy := 1.0;
      advance_dest_y := false;
    end;
    y_last := y_last + y_frac;
    s := src;
    if src_row > 0 then
      s_m1 := src_m1
    else
      s_m1 := src;
    if src_row < (orig_height - 1) then
      s_p1 := src_p1
    else
      s_p1 := src;
    if (src_row + 1) < (orig_height - 1) then
      s_p2 := src_p2
    else
      s_p2 := s_p1;
    r := row;
    frac := 0;
    j := width;
    while j <> 0 do
    begin
      if (x_cum + x_rat) <= (src_col + 1 + 0.0001) then
      begin
        x_cum := x_cum + x_rat;
        dx := x_cum - src_col;
        advance_dest_x := true;
      end
      else
      begin
        dx := 1.0;
        advance_dest_x := false;
      end;
      tot_frac := x_frac[frac] * y_frac;
      inc(frac);
      if src_col > 0 then
        minus_x := -bytes
      else
        minus_x := 0;
      if src_col < (orig_width - 1) then
        plus_x := bytes
      else
        plus_x := 0;
      if (src_col + 1) < (orig_width - 1) then
        plus2_x := bytes * 2
      else
        plus2_x := plus_x;
      if filter = 1 then
      begin
        // bicubic
        case scale_type of
          MAX_MAY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + cubic(dy, round(cubic(dx, s_m1[b + minus_x], s_m1[b], s_m1[b + plus_x], s_m1[b + plus2_x],0,255)),
                round(cubic(dx, s[b + minus_x], s[b], s[b + plus_x], s[b + plus2_x],0,255)),
                round(cubic(dx, s_p1[b + minus_x], s_p1[b], s_p1[b + plus_x], s_p1[b + plus2_x],0,255)),
                round(cubic(dx, s_p2[b + minus_x], s_p2[b], s_p2[b + plus_x], s_p2[b + plus2_x],0,255)),0,255) * tot_frac;  // 3.0.2
          MAX_MIY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + cubic(dx, s[b + minus_x], s[b], s[b + plus_x], s[b + plus2_x],0,255) * tot_frac;
          MIX_MAY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + cubic(dy, s_m1[b], s[b], s_p1[b], s_p2[b],0,255) * tot_frac;
          MIX_MIY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + s[b] * tot_frac;
        end;
      end
      else
      begin
        // bilinear
        case scale_type of
          MAX_MAY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + ((1 - dy) * ((1 - dx) * s[b] + dx * s[b + plus_x]) + dy * ((1 - dx) * s_p1[b] + dx * s_p1[b + plus_x])) * tot_frac;
          MAX_MIY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + (s[b] * (1 - dx) + s[b + plus_x] * dx) * tot_frac;
          MIX_MAY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + (s[b] * (1 - dy) + s_p1[b] * dy) * tot_frac;
          MIX_MIY:
            for b := 0 to bytes - 1 do
              r[b] := r[b] + s[b] * tot_frac;
        end;
      end;
      if (advance_dest_x) then
      begin
        inc(pbyte(r), bytes * sizeof(double));
        dec(j);
      end
      else
      begin
        inc(pbyte(s_m1), bytes);
        inc(pbyte(s), bytes);
        inc(pbyte(s_p1), bytes);
        inc(pbyte(s_p2), bytes);
        inc(src_col);
      end;
    end;
    if advance_dest_y then
    begin
      tot_frac := 1.0 / (x_rat * y_rat);
      d := dest;
      r := row;
      ix := 0;
      for j := 0 to width - 1 do
      begin
        for b := 1 to bytes do
        begin
          d[ix] := blimit(round(r[ix] * tot_frac)); // 3.0.2
          inc(ix);
        end;
      end;
      CopyMemory(DstImg.scanline[height - i], dest, width * bytes);
      FillChar(row^, sizeof(double) * width * bytes, 0);
      dec(i);
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc((height - i) / height * 100));
    end
    else
    begin
      s := src_m1;
      src_m1 := src;
      src := src_p1;
      src_p1 := src_p2;
      src_p2 := s;
      inc(src_row);
      if (src_row + 1) < (orig_height - 1) then
        CopyMemory(src_p2, SrcImg.Scanline[src_row + 2], orig_width * bytes);
    end;
  end;
  FreeMem(src_m1);
  FreeMem(src);
  FreeMem(src_p1);
  FreeMem(src_p2);
  FreeMem(dest);
  FreeMem(row);
  FreeMem(x_frac);
end;

// filter 0=bilinear 1=bicubic
// works with ie48RGB and ie16g
procedure _IEQResampleWords(SrcImg, DstImg: TIEBaseBitmap; filter: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  src_m1, src, src_p1, src_p2,s_m1, s, s_p1, s_p2: PWordArray;
  d, dest: PWordArray;
  r, row: PDoubleArray;
  src_row, src_col: integer;
  words, b: integer;
  width, height: integer;
  orig_width, orig_height: integer;
  x_rat, y_rat: double;
  x_cum, y_cum: double;
  x_last, y_last: double;
  x_frac: PDoubleArray;
  y_frac, tot_frac: Double;
  dx, dy: double;
  i, j: integer;
  frac: integer;
  advance_dest_x, advance_dest_y: boolean;
  ix, minus_x, plus_x, plus2_x: integer;
  scale_type: (MAX_MAY, MAX_MIY, MIX_MAY, MIX_MIY);
  cancel: boolean;
  lp: integer;
begin
  lp := 0;
  cancel := false;
  orig_width := SrcImg.width;
  orig_height := SrcImg.height;
  width := DstImg.width;
  height := DstImg.height;
  case SrcImg.PixelFormat of
    ie48RGB: words := 3;
    ie16g: words := 1;
  else
    exit;
  end;
  x_rat := orig_width / width;
  y_rat := orig_height / height;
  if (x_rat < 1.0) and (y_rat < 1.0) then
    scale_type := MAX_MAY
  else if (x_rat < 1.0) and (y_rat >= 1.0) then
    scale_type := MAX_MIY
  else if (x_rat >= 1.0) and (y_rat < 1.0) then
    scale_type := MIX_MAY
  else
    scale_type := MIX_MIY;
  GetMem(src_m1, orig_width * words*2);
  GetMem(src, orig_width * words*2);
  GetMem(src_p1, orig_width * words*2);
  GetMem(src_p2, orig_width * words*2);
  GetMem(dest, width * words*2);
  GetMem(row, sizeof(double) * width * words);
  GetMem(x_frac, sizeof(double) * (width + orig_width));
  src_col := 0;
  x_cum := src_col;
  x_last := x_cum;
  for i := 0 to (width + orig_width - 1) do
  begin
    if (x_cum + x_rat) <= (src_col + 1 + 0.0001) then
    begin
      x_cum := x_cum + x_rat;
      x_frac[i] := x_cum - x_last;
    end
    else
    begin
      inc(src_col);
      x_frac[i] := src_col - x_last;
    end;
    x_last := x_last + x_frac[i];
  end;
  FillChar(row^, sizeof(double) * width * words, 0);
  src_row := 0;
  y_cum := src_row;
  y_last := y_cum;
  CopyMemory(src, SrcImg.Scanline[0], orig_width * words*2);
  if src_row < (orig_height - 1) then
    CopyMemory(src_p1, SrcImg.ScanLine[1], orig_width * words*2);
  if (src_row + 1) < (orig_height - 1) then
    CopyMemory(src_p2, SrcImg.Scanline[2], orig_width * words*2);
  i := height;
  while i > 0 do
  begin
    src_col := 0;
    x_cum := src_col;
    if ((y_cum + y_rat) <= (src_row + 1 + 0.0001)) then
    begin
      y_cum := y_cum + y_rat;
      dy := y_cum - src_row;
      y_frac := y_cum - y_last;
      advance_dest_y := true;
    end
    else
    begin
      y_frac := (src_row + 1) - y_last;
      dy := 1.0;
      advance_dest_y := false;
    end;
    y_last := y_last + y_frac;
    s := src;
    if src_row > 0 then
      s_m1 := src_m1
    else
      s_m1 := src;
    if src_row < (orig_height - 1) then
      s_p1 := src_p1
    else
      s_p1 := src;
    if (src_row + 1) < (orig_height - 1) then
      s_p2 := src_p2
    else
      s_p2 := s_p1;
    r := row;
    frac := 0;
    j := width;
    while j <> 0 do
    begin
      if (x_cum + x_rat) <= (src_col + 1 + 0.0001) then
      begin
        x_cum := x_cum + x_rat;
        dx := x_cum - src_col;
        advance_dest_x := true;
      end
      else
      begin
        dx := 1.0;
        advance_dest_x := false;
      end;
      tot_frac := x_frac[frac] * y_frac;
      inc(frac);
      if src_col > 0 then
        minus_x := -words
      else
        minus_x := 0;
      if src_col < (orig_width - 1) then
        plus_x := words
      else
        plus_x := 0;
      if (src_col + 1) < (orig_width - 1) then
        plus2_x := words * 2
      else
        plus2_x := plus_x;
      if filter = 1 then
      begin
        // bicubic
        case scale_type of
          MAX_MAY:
            for b := 0 to words - 1 do
              r[b] := r[b] + cubic(dy, round(cubic(dx, s_m1[b + minus_x], s_m1[b], s_m1[b + plus_x], s_m1[b + plus2_x],0,65535)),
                round(cubic(dx, s[b + minus_x], s[b], s[b + plus_x], s[b + plus2_x],0,65535)),
                round(cubic(dx, s_p1[b + minus_x], s_p1[b], s_p1[b + plus_x], s_p1[b + plus2_x],0,65535)),
                round(cubic(dx, s_p2[b + minus_x], s_p2[b], s_p2[b + plus_x], s_p2[b + plus2_x],0,65535)),0,65535) * tot_frac;  // 3.0.2
          MAX_MIY:
            for b := 0 to words - 1 do
              r[b] := r[b] + cubic(dx, s[b + minus_x], s[b], s[b + plus_x], s[b + plus2_x],0,65535) * tot_frac;
          MIX_MAY:
            for b := 0 to words - 1 do
              r[b] := r[b] + cubic(dy, s_m1[b], s[b], s_p1[b], s_p2[b],0,65535) * tot_frac;
          MIX_MIY:
            for b := 0 to words - 1 do
              r[b] := r[b] + s[b] * tot_frac;
        end;
      end
      else
      begin
        // bilinear
        case scale_type of
          MAX_MAY:
            for b := 0 to words - 1 do
              r[b] := r[b] + ((1 - dy) * ((1 - dx) * s[b] + dx * s[b + plus_x]) + dy * ((1 - dx) * s_p1[b] + dx * s_p1[b + plus_x])) * tot_frac;
          MAX_MIY:
            for b := 0 to words - 1 do
              r[b] := r[b] + (s[b] * (1 - dx) + s[b + plus_x] * dx) * tot_frac;
          MIX_MAY:
            for b := 0 to words - 1 do
              r[b] := r[b] + (s[b] * (1 - dy) + s_p1[b] * dy) * tot_frac;
          MIX_MIY:
            for b := 0 to words - 1 do
              r[b] := r[b] + s[b] * tot_frac;
        end;
      end;
      if (advance_dest_x) then
      begin
        inc(pbyte(r), words * sizeof(double));
        dec(j);
      end
      else
      begin
        inc(pbyte(s_m1), words*2);
        inc(pbyte(s), words*2);
        inc(pbyte(s_p1), words*2);
        inc(pbyte(s_p2), words*2);
        inc(src_col);
      end;
    end;
    if advance_dest_y then
    begin
      tot_frac := 1.0 / (x_rat * y_rat);
      d := dest;
      r := row;
      ix := 0;
      for j := 0 to width - 1 do
      begin
        for b := 1 to words do
        begin
          d[ix] := ilimit(round(r[ix] * tot_frac),0,65535); // 3.0.2
          inc(ix);
        end;
      end;
      copymemory(DstImg.scanline[height - i], dest, width * words*2);
      FillChar(row^, sizeof(double) * width * words, 0);
      dec(i);
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc((height - i) / height * 100));
    end
    else
    begin
      s := src_m1;
      src_m1 := src;
      src := src_p1;
      src_p1 := src_p2;
      src_p2 := s;
      inc(src_row);
      if (src_row + 1) < (orig_height - 1) then
        CopyMemory(src_p2, SrcImg.Scanline[src_row + 2], orig_width * words*2);
    end;
  end;
  FreeMem(src_m1);
  FreeMem(src);
  FreeMem(src_p1);
  FreeMem(src_p2);
  FreeMem(dest);
  FreeMem(row);
  FreeMem(x_frac);
end;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnProc.SetTransparentColors

<FM>Declaration<FC>
procedure SetTransparentColors(MinColor,MaxColor:<A TRGB>; Alpha:integer);

<FM>Description<FN>
SetTransparentColors sets as transparent all pixels inside the MinColor and MaxColor range. The trasparency value comes from Alpha parameter (0=fully transparent, 255=fully visible).
If you are sure of the RGB value of the transparent colors, just set MinColor and MaxColor to the same value. If you want all colors from gray (128,128,128) to white (255,255,255) to be transparent, write SetTransparentColors(CreateRGB(128,128,128),CreateRGB(255,255,255),0).

<FM>Example<FC>
// this example draws a text with soft shadow over a background image
ImageEnView1.IO.LoadFromfile('background.jpg');  // load background image
ImageEnView1.LayersAdd;  // add a new layer
ImageEnView1.Bitmap.Canvas.Font.Name:='Times New Roman';
ImageEnView1.Bitmap.Canvas.Font.Height:=45;
ImageEnView1.Bitmap.Canvas.Font.Color:=clYellow;
ImageEnView1.Bitmap.Canvas.TextOut(0,250,'Hello World!');  // draw text on second layer
ImageEnView1.Proc.SetTransparentColors(CreateRGB(255,255,255),CreateRGB(255,255,255),0);  // remove the white, making it as transparent
ImageEnView1.Proc.AddSoftShadow(2,3,3);  // add the shadow

Here is the result:
<IMG help_images\70.bmp>
!!}
procedure TImageEnProc.SetTransparentColors(MinColor, MaxColor: TRGB; Alpha: integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie1g, ie24RGB], x1, y1, x2, y2, IERS_SETTRANSPARENTCOLORS, ProcBitmap, mask) then
    exit;
  _SetTransparentColors(ProcBitmap, x1, y1, x2, y2, MinColor, MaxColor, Alpha, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// works with ie24RGB and ie1g
// for ie1g only MinColor.r cares
procedure _SetTransparentColors(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; MinColor, MaxColor: TRGB; alpha: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y: integer;
  px: PRGB;
  pa, pb: pbyte;
  per1: double;
  st: boolean;
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  case bitmap.PixelFormat of
    ie24RGB:
      for y := fSelY1 to fSelY2 do
      begin
        px := bitmap.Scanline[y];
        inc(px, fSelX1);
        pa := bitmap.AlphaChannel.Scanline[y];
        inc(pa, fSelX1);
        for x := fSelX1 to fSelX2 do
        begin
          with px^ do
            if (r >= MinColor.r) and (g >= MinColor.g) and (b >= MinColor.b) and (r <= MaxColor.r) and (g <= MaxColor.g) and (b <= MaxColor.b) then
              pa^ := alpha;
          inc(px);
          inc(pa);
        end;
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
      end;
    ie1g:
      begin
        st := MinColor.r > 0;
        for y := fSelY1 to fSelY2 do
        begin
          pb := bitmap.Scanline[y];
          pa := bitmap.AlphaChannel.Scanline[y];
          inc(pa, fSelX1);
          for x := fSelX1 to fSelX2 do
          begin
            if pbytearray(pb)^[x shr 3] and iebitmask1[x and $7] = 0 then
            begin
              if not st then
                pa^ := alpha;
            end
            else
            begin
              if st then
                pa^ := alpha;
            end;
            inc(pa);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
        end;
      end;
  end;
  bitmap.AlphaChannel.SyncFull;
end;

// return:
//   in Color the dominant color
//   in result the percentage
// works with ie1g and ie24RGB

{!!
<FS>TImageEnProc.GetDominantColor

<FM>Declaration<FC>
function GetDominantColor(var Color:<A TRGB>):double;

<FM>Description<FN>
GetDominantColor returns the dominant (most used) color in the image.
Color will contain the dominant color, and the returned result will contain the percentage of the dominant color.

<FM>Example<FC>
Percentage := ImageEnView.Proc.GetDominantColor(cl);
If Percentage=100 then
   ShowMessage('the image is blank!');

!!}
function TImageEnProc.GetDominantColor(var Color: TRGB): double;
var
  hist: array[0..255] of integer;
  x, y, tot, c, v, i: integer;
  hash: THash1;
  ptr1: integer;
  ptr2: Thash1Item;
  pxrgb: PRGB;
  maxv, maxi: integer;
  clist, vlist: TList;
begin
  result := -1;
  if not MakeConsistentBitmap([]) then
    exit;
  tot := fIEBitmap.Width * fIEBitmap.Height;
  if tot = 0 then
    exit;
  case fIEBitmap.PixelFormat of
    ie1g:
      begin
        _IEGetHistogram(fIEBitmap, @hist);
        if hist[0] > hist[1] then
        begin
          result := (hist[0] / tot) * 100;
          Color := CreateRGB(0, 0, 0);
        end
        else
        begin
          result := (hist[1] / tot) * 100;
          Color := CreateRGB(255, 255, 255);
        end;
      end;
    ie24RGB:
      begin
        clist := TList.Create;
        vlist := TList.Create;
        hash := THash1.Create(13);
        for y := 0 to fIEBitmap.Height - 1 do
        begin
          pxrgb := fIEBitmap.ScanLine[y];
          for x := 0 to fIEBitmap.Width - 1 do
          begin
            with pxrgb^ do
              c := (r shl 16) or (g shl 8) or (b);
            if not hash.Insert2(c, ptr1, ptr2) then
            begin
              // the key (color) already exists
              v := hash.GetValue(ptr1, ptr2);
              vlist[v] := pointer(int64(DWORD(vlist[v])) + 1);
            end
            else
            begin
              // the key (color) is new
              v := vlist.Add(pointer(1));
              clist.Add(pointer(TRGB2TColor(pxrgb^)));
              hash.SetValue(ptr1, ptr2, v);
            end;
            inc(pxrgb);
          end;
        end;
        maxv := 0;
        maxi := 0;
        hash.IterateBegin;
        repeat
          i := hash.IterateGetValue;
          v := int64(DWORD(vlist[i]));
          if v > maxv then
          begin
            maxv := v;
            maxi := i;
          end;
        until not hash.IterateNext;
        Color := TColor2TRGB(integer(clist[maxi]));
        result := (maxv / tot) * 100;
        FreeAndNil(hash);
        FreeAndNil(clist);
        FreeAndNil(vlist);
      end;
  end;
  DoFinishWork;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(* Median Filtering

 purpose:

 Carry out fast median filtering on images using windows from 3x3 to 19x19
 maximum size.  Filtering can be of three types:

 1) substitute median if central point differs from median by a threshold amount,
 2) high pass sharpening
 3) edge extraction

 operation:

 Histogram in moving window at beginning of line is initiated. Histogram is
 updated after each move subtracting left column values from previous
 window, adding right column values.  Median updated by counting up
 or down number of pixels less than or greater than old median.

 For color images, the grayscale intensity of a pixel is computed as a weighted
 linear combination of RGB and counted in the histogram. The pixel with the
 nearest (L1 norm) color to the average of all pixels in the moving window except
 the central point is used in place of the median.
 The computation of the median for a color image has a complexity of O(N^4),
 whereas this technique is only O(N^2) or less and is as good when
 the window size is 19x19 when the median differs only by a
 small amount from the mean. For smaller windows performance degrades as
 the mean differs from the median, but it is still satisfactory down to
 a 5x5 window.

 Adaptive thresholding is used to preserve sharp edges. A pixel is replaced by
 the median or its nearast average color equivalent if it lies outside the 1st
 and 3rd quantile of the intensity distribution. The user may modify the
 position of the quantiles interactively. Defaults are the first and third
 quartiles. For grayscale images, the quantiles and medians are used directly.
 The green element of a TRGB record is used as an intensity measurement.
 The user must provide means of detecting whether or not an image is color
 or grayscale.

 author:

 I.Scollar, following Huang, Yang, Tang, unpublished report
 submitted under Defence Advanced Research Projects Agency contract
 no. MDA 903-77-G-1,"A fast two dimensional median filtering algorithm"
 T.S.Huang, G.J.Yang, G.Y.Tang, School of Electrical Engineering,
 Purdue University, West Lafayette, Indiana 47907, USA.

 First publication: T.S.Huang, G.J.Yang, G.Y.Tang, Proceedings IEEE Conference
 Pattern Recognition and Image Processing, Chicago 1978, p. 128 ff.

 I.Scollar, B.Weidner, T.S.Huang, Image enhancement using the median and the interquartile
 distance, Computer Vision, Graphics and Image Processing, 25 1984 236-251

 Original Fortran IV, 512x512 grayscale images G.Y.Tang, 1976
 Modifications:
 Large images on DEC PDP11, I. Scollar Sept. 1978
 Normalized sharpening, I.Scollar Sept. 1980
 Adaptive quantile thresholding, I.Scollar Sept. 1980
 Ported from DEC Fortran IV to Delphi 7 Pascal, I.Scollar March 11, 2003
 Extenstion to color images, I. Scollar, March 13, 2003
*)

type
  TSource = array[0..0] of pRGBRow;
  pSourcePtr = ^TSource;

{!!
<FS>TImageEnProc.MedianFilter

<FM>Declaration<FC>
procedure MedianFilter(WindowX:integer=5; WindowY:integer=5; Brightness:integer=50; Contrast:integer=50; Multiplier:integer=1; Threshold:integer=50; MedianOp:<A TIEMedFilType>=mfMedianFilter);

<FM>Description<FN>
Carry out fast median filtering on images using windows from 3x3 to 19x19
maximum size. MedianFilter works only with true color images.
Filtering can be of three types:

 1) substitute median if central point differs from median by a threshold amount,
 2) high pass sharpening
 3) edge extraction

 Operation:

 Histogram in moving window at beginning of line is initiated. Histogram is
 updated after each move subtracting left column values from previous
 window, adding right column values.  Median updated by counting up
 or down number of pixels less than or greater than old median.

 For color images, the grayscale intensity of a pixel is computed as a weighted
 linear combination of RGB and counted in the histogram. The pixel with the
 nearest (L1 norm) color to the average of all pixels in the moving window except
 the central point is used in place of the median.
 The computation of the median for a color image has a complexity of O(N^4),
 Whereas this technique is only O(N^2) or less and is as good when the window size
 is 19x19 when the median differs only by a small amount from the mean. For
 smaller windows performance degrades as the mean differs from the median,
 but it is still satisfactory down to a 5x5 window.

 Adaptive thresholding is used to preserve sharp edges. A pixel is replaced by
 the median or its nearast average color equivalent if it lies outside the 1st
 and 3rd quantile of the intensity distribution. The user may modify the
 position of the quantiles interactively. Defaults are the first and third
 quartiles. For grayscale images, the quantiles and medians are used directly.
 The green element of a TRGB record is used as an intensity measurement.
 The user must provide means of detecting whether or not an image is color
 or grayscale.

 author:

 I.Scollar, following Huang, Yang, Tang, unpublished report
 submitted under Defense Advanced Research Projects Agency contract
 no. MDA 903-77-G-1, "A fast two dimensional median filtering algorithm"
 T.S.Huang, G.J.Yang, G.Y.Tang, School of Electrical Engineering,
 Purdue University, West Lafayette, Indiana 47907, USA.

 First publication: T.S.Huang, G.J.Yang, G.Y.Tang, Proceedings IEEE Conference
 Pattern Recognition and Image Processing, Chicago 1978, p. 128 ff.

 I.Scollar, B.Weidner, T.S.Huang, Image enhancement using the median and the interquartile
 distance, Computer Vision, Graphics and Image Processing, 25 1984 236-251

 Original Fortran IV, 512x512 grayscale images G.Y.Tang, 1976
 Modifications:
 Large images on DEC PDP11, I. Scollar Sept. 1978
 Normalized sharpening, I.Scollar Sept. 1980
 Adaptive quantile thresholding, I.Scollar Sept. 1980
 Ported from DEC Fortran IV to Delphi 7 Pascal, I.Scollar March 11, 2003
 Extenstion to color images, I. Scollar, March 13, 2003

!!}
procedure TImageEnProc.MedianFilter(WindowX, WindowY: integer; Brightness, Contrast, Multiplier, Threshold: integer; MedianOp: TIEMedFilType);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_MEDIANFILTER, ProcBitmap, mask) then
    exit;
  _IEMedianFilter(ProcBitmap, WindowX, WindowY, Brightness, Contrast, Multiplier, Threshold, MedianOp, fOnProgress, Self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


procedure _IEMedianFilter(image: TIEBitmap; WindowX, WindowY: integer; Brightness, Contrast, Multiplier, Threshold: integer; MedianOp: TIEMedFilType; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  aHeight, aHeight32, aWidth, aWidth32: integer;
  pTarget: pRGB;
  pSource: pRGB;
  Source: TIEBitmap;
  Target: TIEBitmap;
  Nwx, Nwx2, Nwx21, Nwy, Nwy2, WinTot, WinTot2: Integer;
  i, j, k, m, n: Integer;
  ii, jj: integer;
  Hist: array[0..255] of integer;
  HistIndex: integer;
  Sum, LTMedian, Median: integer;
  left1, right1: integer;
  Thresh: integer;
  CenterPixel: PRGB;
  CP, CPM, Gain, Off: double;
  Value: integer;
  Pix: TRGB;
  PixOut: TRGB;
  WinTot1: double;
  Diff, LastDiff: integer;
  Q, Q25, Q75, TQ25, TQ75, LTQ25, LTQ75: integer;

  procedure GetAveragePixelColor;
  var
    ii, jj: Integer;
    px:PRGB;
    rr, gg, bb:integer;
    avg_r, avg_g, avg_b:integer;
  begin
    // compute average value of pixels in the window, excluding central pixel
    FillChar(PixOut, SizeOf(PixOut), #255);
    rr:=0; gg:=0; bb:=0;
    for ii := -Nwy2 to Nwy2 do
    begin
      // 3.0.2
      px := Source.Scanline[ii+i]; inc(px,-Nwx2+j);
      for jj := -Nwx2 to Nwx2 do
      begin
        if (ii<>0) or (jj<>0) then
          with px^ do
          begin
            inc(rr, r);
            inc(gg, g);
            inc(bb, b);
          end;
        inc(px);
      end;
    end;
    avg_r := blimit(trunc(rr * WinTot1));
    avg_g := blimit(trunc(gg * WinTot1));
    avg_b := blimit(trunc(bb * WinTot1));
    // get the pixel in the window whose color is nearest to the average so that there are no color shifts}
    LastDiff := MaxInt;
    for ii := -Nwy2 to Nwy2 do
    begin
      // 3.0.2
      px := Source.Scanline[ii+i]; inc(px, -Nwx2+j);
      for jj := -Nwx2 to Nwx2 do
      begin
        if (ii<>0) or (jj<>0) then
        begin
          with px^ do
            Diff := Abs(r - avg_r) + Abs(g - avg_g) + Abs(b - avg_b);
          if (Diff = 0) then
          begin
            PixOut := px^;
            break;
          end;
          if (Diff < LastDiff) then
          begin
            PixOut := px^;
            LastDiff := Diff;
          end;
        end;
      end;
    end;
    pTarget^ := PixOut;
  end;

var
  px:PRGB;

begin
  //pSource := nil;
  Target := nil;
  try
    Source := image;
    aHeight := Source.Height - 1;
    aWidth := Source.Width;
    Target := TIEBitmap.Create;
    Target.Location := ieMemory;
    Target.Allocate(Source.Width, Source.Height, IE24RGB);
    {get processing window sizes}
    Nwx := WindowX;
    Nwy := WindowY;
    WinTot := Nwx * Nwy;
    WinTot1 := 1.0 / (WinTot - 1);
    Nwx2 := Nwx div 2;
    Nwy2 := Nwy div 2;
    Nwx21 := Nwx2 + 1;
    WinTot2 := Nwx * Nwy div 2;
    TQ25 := WinTot div 4;
    TQ75 := 3 * TQ25;
    aWidth32 := Source.Width - Nwx2;
    aHeight32 := Source.Height - Nwy2;
    CP := WinTot;
    Off := 5.1 * (Brightness - 50);
    CPM := Multiplier;
    Gain := Contrast;
    Thresh := trunc(Threshold * 2.56);
    {set other parameters}
    case MedianOp of
      mfMedianFilter:
        begin
          Thresh := trunc(Threshold * 2.56);
          TQ25 := (WinTot div 4) - trunc((Threshold - 50) * 0.02 * TQ25);
          TQ75 := 3 * (WinTot div 4) + trunc((Threshold - 50) * 0.02 * TQ25);
        end;
      mfSharpen:
        begin
          CPM := 6.36 - (1.0 + Multiplier * 0.04);
          CPM := CPM * (WinTot - 1);
          CP := CPM + 1.0;
          Gain := 1.0 / (CP - WinTot);
        end;
      mfEdgeExtract:
        begin
          CP := Wintot;
          Gain := 0.5 * Contrast / (WinTot - 1);
          Thresh := trunc(Threshold * 2.56);
        end;
    end;
    i := 0;
    {copy top of image or set it to white}
    while (i < Nwy2) do
    begin
      if assigned(fOnProgress) then
        fOnProgress(Sender, Trunc(i / Source.Height * 100) + 1);
      if (MedianOp = mfEdgeExtract) then
        FillChar(Target.Scanline[i]^, Source.Width * SizeOf(TRGB), #255)
      else
        Move(Source.ScanLine[i]^, Target.Scanline[i]^, Source.Width * SizeOf(TRGB));
      Inc(i);
    end;
    {main loop}
    while (i < aHeight32) do
    begin
      if (i mod 10) = 0 then
        if assigned(fOnProgress) then
          fOnProgress(Sender, Trunc(i / Source.Height * 100) + 1);
      pSource := pRGB(Source.Scanline[i]);
      pTarget := pRGB(Target.Scanline[i]);
      {copy left unprocessed side of image}
      if (MedianOp = mfEdgeExtract) then
        FillChar(Target.Scanline[i]^, Nwx2 * SizeOf(TRGB), #255)
      else
        Move(pSource^, pTarget^, SizeOf(TRGB) * Nwx2);
      inc(pTarget, Nwx2);
      {Initialize histogram for this line}
      FillChar(Hist, Sizeof(Hist), #0);
      for k := -Nwy2 to Nwy2 do
      begin
        for n := -Nwx2 to Nwx2 do
        begin
          with Source.Pixels_ie24RGB[n + Nwx2, k + i] do
            HistIndex := (r * 54 + g * 182 + b * 20) shr 8;
          Inc(Hist[HistIndex]);
        end;
      end;
      Sum := 0;
      for m := 0 to 255 do
      begin
        Sum := Sum + Hist[m];
        if (Sum > TQ25) then
          break;
      end;
      Q25 := m;
      LTQ25 := Sum - Hist[m];
      Sum := 0;
      for m := 0 to 255 do
      begin
        Sum := Sum + Hist[m];
        if (Sum > WinTot2) then
          break;
      end;
      Median := m;
      LTMedian := Sum - Hist[m];
      Sum := 0;
      for m := 0 to 255 do
      begin
        Sum := Sum + Hist[m];
        if (Sum > TQ75) then
          break;
      end;
      Q75 := m;
      LTQ75 := Sum - Hist[m];
      {process all pixels in this line}
      CenterPixel := Source.Scanline[i];
      inc(CenterPixel, Nwx21);
      for j := Nwx21 to aWidth32 - 1 do
      begin

        left1 := j - Nwx21;
        right1 := j + Nwx2;
        for k := -Nwy2 to Nwy2 do
        begin
          {remove left side counts of window from histogram}
          with Source.Pixels_ie24RGB[left1, k + i] do
            HistIndex := (r * 54 + g * 182 + b * 20) shr 8;
          Dec(Hist[HistIndex]);
          if (HistIndex < Q25) then
            Dec(LTQ25);
          if (HistIndex < Median) then
            Dec(LTMedian);
          if (HistIndex < Q75) then
            Dec(LTQ75);
          {add right side counts of window to histogram}
          with Source.Pixels_ie24RGB[right1, k + i] do
            HistIndex := (r * 54 + g * 182 + b * 20) shr 8;
          Inc(Hist[HistIndex]);
          if (HistIndex < Q25) then
            Inc(LTQ25);
          if (HistIndex < Median) then
            Inc(LTMedian);
          if (HistIndex < Q75) then
            Inc(LTQ75);
        end;
        {update quartiles and median}
        if (LTQ25 < TQ25) then
        begin
          while ((LTQ25 + HIST[Q25]) < TQ25) do
          begin
            LTQ25 := LTQ25 + HIST[Q25];
            Inc(Q25);
          end;
        end
        else
        begin
          repeat
            Dec(Q25);
            LTQ25 := LTQ25 - HIST[Q25];
          until (LTQ25 < TQ25);
        end;
        if (LTMedian < WinTot2) then
        begin
          while ((LTMedian + HIST[Median]) < WinTot2) do
          begin
            LTMedian := LTMedian + HIST[Median];
            Inc(Median);
          end;
        end
        else
        begin
          repeat
            Dec(Median);
            LTMedian := LTMedian - HIST[Median];
          until (LTMedian < WinTot2);
        end;
        if (LTQ75 < TQ75) then
        begin
          while ((LTQ75 + HIST[Q75]) < TQ75) do
          begin
            LTQ75 := LTQ75 + HIST[Q75];
            Inc(Q75);
          end;
        end
        else
        begin
          repeat
            Dec(Q75);
            LTQ75 := LTQ75 - HIST[Q75];
          until (LTQ75 < TQ75);
        end;
        case MedianOp of
          mfMedianFilter:
            if (Thresh = 0) then
              GetAveragePixelColor
            else
            begin
              Q := Q75 - Q25;
              if (abs(CenterPixel^.g - Median) < Q) and
                 (abs(CenterPixel^.r - Median) < Q) and
                 (abs(CenterPixel^.b - Median) < Q) then
                pTarget^ := CenterPixel^
              else
                GetAveragePixelColor;
            end;
          mfSharpen:
            begin
              GetAveragePixelColor;
              pTarget^.r := blimit(trunc((CP * CenterPixel^.r - PixOut.r * WinTot) * Gain + Off));
              pTarget^.g := blimit(trunc((CP * CenterPixel^.g - PixOut.g * WinTot) * Gain + Off));
              pTarget^.b := blimit(trunc((CP * CenterPixel^.b - PixOut.b * WinTot) * Gain + Off));
            end;
          mfEdgeExtract:
            begin
              value := 255 - blimit(trunc((CP * CenterPixel^.g - Median * WinTot) * Gain + Off));
              if value < Thresh then
                value := 0
              else
                value := 255;
              pTarget^.r := value;
              pTarget^.g := value;
              pTarget^.b := value;
            end;
        end;
        inc(pTarget);
        inc(CenterPixel);
      end;
      {copy right unprocessed side of image}
      // 3.0.2 (22082008 1005)
      pSource := pRGB(Source.Scanline[i]); inc(pSource,aWidth32-1);
      pTarget := pRGB(Target.Scanline[i]); inc(pTarget,aWidth32-1);
      for j:=aWidth32-1 to Source.Width-1 do
      begin
        if (MedianOp = mfEdgeExtract) then
        begin
          pTarget^.r:=255;
          pTarget^.g:=255;
          pTarget^.b:=255;
        end
        else
          pTarget^ := pSource^;
        inc(pTarget);
        inc(pSource);
      end;
      inc(i);
    end;
    {copy bottom of image}
    while (i <= aHeight) do
    begin
      if assigned(fOnProgress) then
        fOnProgress(Sender, Trunc(i / Source.Height * 100) + 1);
      if (MedianOp = mfEdgeExtract) then
        FillChar(Target.Scanline[i]^, Source.Width * SizeOf(TRGB), #255)
      else
        Move(Source.ScanLine[i]^, Target.Scanline[i]^, Source.Width * SizeOf(TRGB));
      Inc(i);
    end;
    Source.AssignImage(Target);
  finally
    FreeAndNil(Target);
  end;
end;


// Median Filtering
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
{
Locally adaptive image enhancement based on:

Wallis, R. An approach to the space variant restoration and enhancement of images. Proceedings, Symposium on Current Mathematical Problems in Image Science, Monterey CA,  1976 10-12 reprinted in C.O. Wilde E. Barrett, eds. Image Science Mathematics, Western Periodicals, North hollywood,CA, 1977. Summarised in Pratt:

Pratt, W.K. Digital Image Processing, 2nd. ed. John Wiley & Sons, New York, 1991, 248, 503

Programming for Delphi:

I. Scollar 2003

  W A L L I S  -  STATISTICAL DIFFERENCING USING WALLIS ALGORITHM

  PURPOSE:

  IMPLEMENT THE STATISTICAL DIFFERENCING FILTER OF WALLIS (SEE
  W. PRATT, DIGITAL IMAGE PROCESSING) FOR LARGE PICTURES
  AND LARGE WINDOWS GREATER THAN 20X20

  EFFICIENT SAMPLING TECHNIQUE TO COMPUTE LOCAL MEANS AND VARIANCES.

  OPERATION:

  THE WINDOW DIMENSIONS AND 5 PARAMETERS FOR THE WALLIS FORMULA:
 MEAN		- DESIRED LOCAL MEAN OF OUTPUT
     A COMMONLY USED VALUE FOR MANY APPLICATIONS
     IS 128.ALLOWED RANGE 0-255.
 S.D.		  DESIRED LOCAL STANDARD DEVIATION (CONTRAST)
     OF OUTPUT PICTURE. ALLOWED RANGE 0-100.
     COMMONLY USED RANGE 50-75.
 GAIN		  CONTROLS RATIO OF MEASURED TO DESIRED
     LOCAL VARIANCE. ALLOWED RANGE 0-INFINITY
     EFFECT:
    0	NO VARIANCE EQUALIZATION
     THIS IS THE SAME AS LEE'S
     ALGORITHM (IEEE PROC. PRIP 1978,P.56)

    INF	MAXIMUM VARIANCE EQUALIZATION
     THIS IS EQUIVALENT TO WATKIN'S
     ALGORITHM.
     COMMONLY USED RANGE 4-25.
 EDGE FACT.	  CONTROLS AMOUNT OF MEAN EQUALIZATION
     ALLOWED RANGE 0-1.
     EFFECT:
    1	FULL MEAN EQUALIZATION
    0	MEASURED MEAN RESTORED

  AUTHORS:

  B. WEIDNER, RLMB, 1979
  BASED ON IDEAS TAKEN FROM MVEQN/F BY I. SCOLLAR 1979
  BASED ON IDEAS TAKEN FROM ANAY14 BY G. TANG, 1977

}

procedure _IEWallisFilter(image: TIEBitmap; WinWidth, WinHeight: integer; Mean, StDev, InGain, Edge, Limit: integer; Thresholding: boolean; fOnProgress: TIEProgressEvent; Sender: TObject);
const
  VH = 15;
  VW = 15;
type
  ColumnSums = array[0..0] of Extended;
  ColumnSumsPtr = ^ColumnSums;
var
  Target: TIEBitmap;
  aHeight, aWidth, aWidth32: Integer;
  Pix, White, Black: TRGB;
  r, g, b, h, l, s: double;
  ColSum: ColumnSumsPtr;
  ColSqs: ColumnSumsPtr;
  Nwx, Nwx2, Nwy, Nwy2: Integer;
  Bndx, Bndy: Boolean;
  i, j, jp: Integer;
  Total, W, C1, C2, C3, AMean, SDev, Gain, EF, ALim,
    Sum, SumSq, Asd, Amy, F1, F2: double;
  vwidth, vheight: integer;
  function getpx(x, y: integer): TRGB;
  begin
    dec(x, VW);
    dec(y, VH);
    if y < 0 then
      y := 0
    else if y > image.Height - 1 then
      y := image.Height - 1;
    if x < 0 then
      x := 0
    else if x > image.Width - 1 then
      x := image.Width - 1;
    result := image.Pixels_ie24RGB[x, y];
  end;
  procedure setpx(x, y: integer; v: TRGB);
  begin
    dec(x, VW);
    dec(y, VH);
    if y < 0 then
      y := 0
    else if y > image.Height - 1 then
      y := image.Height - 1;
    if x < 0 then
      x := 0
    else if x > image.Width - 1 then
      x := image.Width - 1;
    target.Pixels_ie24RGB[x, y] := v;
  end;
begin
  ColSum := nil;
  ColSqs := nil;
  White.b := 255;
  White.g := 255;
  White.r := 255;
  Black.b := 0;
  Black.g := 0;
  Black.r := 0;
  try
    Target := TIEBitmap.Create;
    Target.Location := ieFile;
    Target.Allocate(image.Width, image.Height, IE24RGB);
    //
    vwidth := image.Width + VW * 2;
    vheight := image.height + VH * 2;
    {get window sizes and half sizes}
    aHeight := vHeight - 1;
    aWidth := vWidth - 1;
    if aHeight < aWidth then
    begin
      Nwx := Trunc(WinWidth / 100 * aHeight);
      Nwy := Trunc(WinHeight / 100 * aHeight);
    end
    else
    begin
      Nwx := Trunc(WinWidth / 100 * aWidth);
      Nwy := Trunc(WinHeight / 100 * aWidth);
    end;
    Nwx := iMax(Nwx, 21);
    Nwy := iMax(Nwy, 21);
    Nwx2 := (Nwx + 1) div 2;
    Nwy2 := (Nwy + 1) div 2;
    aWidth32 := aWidth - Nwx2;
    Total := Nwx * Nwy;
    W := 1 / Total;
    {get memory for the column sums and the column sum squared buffers}
    GetMem(ColSum, (vWidth + Nwx) * SizeOf(Extended));
    GetMem(ColSqs, (vWidth + Nwx) * SizeOf(Extended));
    FillChar(ColSum^, (vWidth + Nwx) * SizeOf(Extended), #0);
    FillChar(ColSqs^, (vWidth + Nwx) * SizeOf(Extended), #0);
    {initialization of Wallis formula parameters}
    Amean := (1.0 * Mean / 100);
    Sdev := (3.0 * StDev / 100);
    Gain := (100.0 * InGain / 100);
    EF := (1.0 * Edge / 100);
    Alim := (6.0 * Limit / 100);
    C1 := Gain * Sdev;
    C2 := EF * Amean;
    C3 := 1.0 - EF;
    {initialize column sums and squares of sums for first window swath}
    i := 0;
    while (i < Nwy) do
    begin
      jp := 0;
      while (jp < aWidth) do
      begin
        Pix := getpx(jp, i);
        RGB2HSL(Pix, h, s, l);
        ColSum^[jp] := ColSum^[jp] + l;
        ColSqs^[jp] := ColSqs^[jp] + Sqr(l);
        Inc(jp);
      end;
      Inc(i);
    end;
    {main loop}
    for i := 0 to aHeight do
    begin
      if assigned(fOnProgress) then
        fOnProgress(Sender, Trunc(i / vHeight * 100) + 1);
      if not ((i - Nwy2 < 0) or (i + Nwy2 > aHeight)) then
      begin

        {initialize sums in window for beginning of new line}
        Sum := 0.0;
        Sumsq := 0.0;
        jp := 0;
        while (jp <= Nwx - 1) do
        begin
          Sum := Sum + Colsum^[jp];
          Sumsq := Sumsq + Colsqs^[jp];
          Inc(jp);
        end;
        {new line}
        j := 0;
        while j < Nwx2 do
        begin
          if not Thresholding then
            setpx(j, i, getpx(j, i))
          else
            setpx(j, i, White);
          Inc(j);
        end;
        jp := 0;
        while (j <= aWidth32) do
        begin
          {do the Wallis correction on the luminance l}
          Pix := getpx(j, i);
          RGB2HSL(Pix, h, s, l);
          amy := sum * w;
          asd := sqrt((sumsq * w - Sqr(amy)) + 1.0);
          if (asd > alim) then
            asd := alim;
          f1 := c1 / (gain * asd + sdev + 0.00001);
          f2 := c2 + c3 * amy;
          l := (l - amy) * f1 + f2;
          if (l > 1.0) then
            l := 1.0;
          if (l < 0.0) then
            l := 0.0;
          HSL2RGB(Pix, h, s, l);
          if not Thresholding then
            setpx(j, i, Pix)
          else if l > 0.5 then
            setpx(j, i, White)
          else
            setpx(j, i, Black);
          {update window}
          sum := sum + colsum^[jp + nwx] - colsum^[jp];
          sumsq := sumsq + colsqs^[jp + nwx] - colsqs^[jp];
          Inc(j);
          Inc(jp);
        end;
        {fill in the non-computable remainder of the line}
        while j <= aWidth do
        begin
          if not Thresholding then
            setpx(j, i, getpx(j, i))
          else
            setpx(j, i, White);
          Inc(j);
        end;
        {update column sums for a new line}
        j := 0;
        l := 127;
        while (j <= aWidth32) do
        begin
          Pix := getpx(j, i - Nwy2);
          RGB2HSL(Pix, h, s, l);
          ColSum^[j] := ColSum^[j] - l;
          ColSqs^[j] := ColSqs^[j] - Sqr(l);
          Pix := getpx(j, i + Nwy2);
          RGB2HSL(Pix, h, s, l);
          ColSum^[j] := ColSum^[j] + l;
          ColSqs^[j] := ColSqs^[j] + Sqr(l);
          Inc(j);
        end;

      end;

    end; // end for
    image.AssignImage(Target);
  finally
    FreeMem(ColSum);
    FreeMem(ColSqs);
    FreeAndNil(Target);
  end;
end;

{!!
<FS>TImageEnProc.WallisFilter

<FM>Declaration<FC>
procedure WallisFilter(WinWidth:integer=2; WinHeight:integer=2; Mean:integer=50; StDev:integer=50; InGain:integer=50; Edge:integer=10; Limit:integer=50; Thresholding:boolean=false);

<FM>Description<FN>

WallisFilter works only with true color images.
Locally adaptive image enhancement based on:

Wallis, R. An approach to the space variant restoration and enhancement of images. Proceedings, Symposium on Current Mathematical Problems in Image Science, Monterey CA, 1976 10-12 reprinted in C.O. Wilde E. Barrett, eds. Image Science Mathematics, Western Periodicals, North Hollywood, CA, 1977. Summarised in Pratt:

Pratt, W.K. Digital Image Processing, 2nd. ed. John Wiley & Sons, New York, 1991, 248, 503

Programming for Delphi:

I. Scollar 2003

  W A L L I S  -  STATISTICAL DIFFERENCING USING WALLIS ALGORITHM

  PURPOSE:

  IMPLEMENT THE STATISTICAL DIFFERENCING FILTER OF WALLIS (SEE
  W. PRATT, DIGITAL IMAGE PROCESSING) FOR LARGE PICTURES
  AND LARGE WINDOWS GREATER THAN 20X20

  EFFICIENT SAMPLING TECHNIQUE TO COMPUTE LOCAL MEANS AND VARIANCES.

  OPERATION:

  THE WINDOW DIMENSIONS AND 5 PARAMETERS FOR THE WALLIS FORMULA:
	MEAN		- DESIRED LOCAL MEAN OF OUTPUT
			  A COMMONLY USED VALUE FOR MANY APPLICATIONS
			  IS 128.ALLOWED RANGE 0-255.
	S.D.		  DESIRED LOCAL STANDARD DEVIATION (CONTRAST)
			  OF OUTPUT PICTURE. ALLOWED RANGE 0-100.
			  COMMONLY USED RANGE 50-75.
	GAIN		  CONTROLS RATIO OF MEASURED TO DESIRED
			  LOCAL VARIANCE. ALLOWED RANGE 0-INFINITY
			  EFFECT:
				0	NO VARIANCE EQUALIZATION
					THIS IS THE SAME AS LEE'S
					ALGORITHM (IEEE PROC. PRIP 1978,P.56)

				INF	MAXIMUM VARIANCE EQUALIZATION
					THIS IS EQUIVALENT TO WATKIN'S
					ALGORITHM.
			  COMMONLY USED RANGE 4-25.
	EDGE FACT.	  CONTROLS AMOUNT OF MEAN EQUALIZATION
			  ALLOWED RANGE 0-1.
			  EFFECT:
				100	FULL MEAN EQUALIZATION
				0	MEASURED MEAN RESTORED

  AUTHORS:

  B. WEIDNER, RLMB, 1979
  BASED ON IDEAS TAKEN FROM MVEQN/F BY I. SCOLLAR 1979
  BASED ON IDEAS TAKEN FROM ANAY14 BY G. TANG, 1977

!!}
procedure TImageEnProc.WallisFilter(WinWidth, WinHeight: integer; Mean, StDev, InGain, Edge, Limit: integer; Thresholding: boolean);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_WALLISFILTER, ProcBitmap, mask) then
    exit;
  _IEWallisFilter(ProcBitmap, WinWidth, WinHeight, Mean, StDev, InGain, Edge, Limit, Thresholding, fOnProgress, Self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Wallis filter
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// works for ie24RGB ie1g
// return 0 or 90 (cannot detect down-up, inverted text)

{!!
<FS>TImageEnProc.CalcOrientation

<FM>Declaration<FC>
function CalcOrientation:integer;

<FM>Description<FN>
Apply only to document images (images with text) to get their orientation. CalcOrientation can detect only 0° or 90° orientation.  It cannot detect upside down, inverted text.
CalcOrientation is useful to adjust a document from portrait to landscape.

<FM>Example<FC>
Adjust := ImageEnView.Proc.CalcOrientation;
ImageEnView.Proc.Rotate( Adjust );

!!}
function TImageEnProc.CalcOrientation: integer;
var
  VertHist, HorizHist: pintegerarray;
  i: integer;
  rh, rv: double;
begin
  result := 0;
  if not MakeConsistentBitmap([]) then
    exit;
  getmem(HorizHist, sizeof(integer) * fIEBitmap.Width);
  getmem(VertHist, sizeof(integer) * fIEBitmap.Height);
  _CalcDensityHistogram(fIEBitmap, 0, 0, fIEBitmap.Width, fIEBitmap.Height, fOnProgress, self, VertHist, HorizHist, 1000, 1000);
  rh := 0;
  for i := 0 to fIEBitmap.Width - 2 do
    rh := rh + sqr(HorizHist[i + 1] - HorizHist[i]);
  rv := 0;
  for i := 0 to fIEBitmap.Height - 2 do
    rv := rv + sqr(VertHist[i + 1] - VertHist[i]);
  if rh > rv then
    result := 90;
  freemem(VertHist);
  freemem(horizHist);
  DoFinishWork;
end;

function _IECalcVertOrientationFitness(bitmap: TIEBitmap): integer;
var
  VertHist, HorizHist: pintegerarray;
  i: integer;
  rv: double;
begin
  getmem(HorizHist, sizeof(integer) * bitmap.Width);
  getmem(VertHist, sizeof(integer) * bitmap.Height);
  _CalcDensityHistogram(bitmap, 0, 0, bitmap.Width, bitmap.Height, nil, nil, VertHist, HorizHist, 1000, 1000);
  rv := 0;
  for i := 0 to bitmap.Height - 2 do
    rv := rv + sqr(VertHist[i + 1] - VertHist[i]);
  freemem(VertHist);
  freemem(horizHist);
  result := trunc(rv);
end;

function _IESkewDetectionFine(Bitmap:TIEBitmap; StartingAngle: double; resolution: double; range: integer; maxQuality: boolean): double;
var
  orgbmp, tmpbmp: TIEBitmap;
  bestfit, curfit, w, h: integer;
  bestangle: double;
  aa, r: double;
begin
  orgbmp := TIEBitmap.Create;
  if not maxQuality then
  begin
    w := imax(imin(Bitmap.Width div 8, Bitmap.Width), 256);
    h := trunc(Bitmap.Height / Bitmap.Width * w);
    orgbmp.Allocate(w, h, ie24RGB);
    if Bitmap.PixelFormat = ie1g then
      _Resample1BitEx(Bitmap, orgbmp, rfFastLInear)
    else
      _ResampleEx(Bitmap, orgbmp, rfFastLInear, nil, nil);
  end
  else
    orgbmp.Assign(Bitmap);
  tmpbmp := TIEBitmap.Create;
  r := range / 2;
  // try left (including 0°)
  bestfit := 0;
  bestangle := 0;
  aa := 0;
  while abs(aa) < r do
  begin
    tmpbmp.assign(orgbmp);
    _RotateEx(tmpbmp, StartingAngle + aa, false, CreateRGB(0, 0, 0), nil, nil);
    curfit := _IECalcVertOrientationFitness(tmpbmp);
    if curfit > bestfit then
    begin
      bestfit := curfit;
      bestangle := aa;
    end;
    aa := aa - resolution;
  end;
  // try right
  aa := resolution;
  while abs(aa) < r do
  begin
    tmpbmp.assign(orgbmp);
    _RotateEx(tmpbmp, StartingAngle + aa, false, CreateRGB(0, 0, 0), nil, nil);
    curfit := _IECalcVertOrientationFitness(tmpbmp);
    if curfit > bestfit then
    begin
      bestfit := curfit;
      bestangle := aa;
    end;
    aa := aa + resolution;
  end;
  result := StartingAngle + bestangle;
  FreeAndNil(tmpbmp);
  FreeAndNil(orgbmp);
end;

{!!
<FS>TImageEnProc.SkewDetectionFine

<FM>Declaration<FC>
function SkewDetectionFine(StartingAngle:double; resolution:double; range:integer; maxQuality:boolean):double;

<FM>Description<FN>
SkewDetectionFine estimates the orientation angle (in degrees) of the lines of text.
Apply this method only to images that contains printed text.  SkewDetectionFine doesn't use a Hough transform (like <A TImageEnProc.SkewDetection>), but progressive rotations to find the best orientation.

<FC>StartingAngle<FN> specifies the starting angle, if you know it (0 otherwise).
<FC>Resolution<FN> is the angle increment (0.1 is good).
<FC>Range<FN> specifies the angle range (example 10, try from -5 to +5).
<FC>MaxQuality<FN> : if <FC>False<FN>, creates a thumbnail of the image and works on it.

<FM>Example<FC>
D := ImageEnView.Proc.SkewDetectionFine( 0, 0.1, 10, true );
ImageEnView.Proc.Rotate( D );

!!}
function TImageEnProc.SkewDetectionFine(StartingAngle: double; resolution: double; range: integer; maxQuality: boolean): double;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  result := StartingAngle;
  if not BeginImageAnalysis([ie24RGB,ie1g], x1, y1, x2, y2, ProcBitmap, mask) then
    exit;
  result := _IESkewDetectionFine(ProcBitmap,StartingAngle,resolution,range,maxQuality);
  EndImageAnalysis(ProcBitmap);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.Sharpen

<FM>Declaration<FC>
procedure Sharpen(Intensity:integer = 10; Neighbourhood:integer = 4);

<FM>Description<FN>
Sharpen performs sharpening filter.

<FC>Intensity<FN> specifies the intensity of the sharpening (1..100).
<FC>Neighbourhood<FN> specifies the window size.

<FM>Example<FC>
ImageEnView1.Proc.Sharpen( 10, 4 );

!!}
procedure TImageEnProc.Sharpen(Intensity:integer; Neighbourhood:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_SHARPEN, [Intensity, Neighbourhood]), ProcBitmap, mask) then
    exit;
  _Sharpen(ProcBitmap, x1, y1, x2, y2, Intensity, Neighbourhood, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// Intensity from 1 to 100 (but allowed more than 100 values)
// Neighbourhood from 2, must be divisible by 2 (2,4,6,8,10...)
procedure _Sharpen(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; Intensity: integer; Neighbourhood: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  per1: double;
  x, y: integer;
  nsize: integer; // neighbourhood size / 2
  nr, ng, nb: integer;
  newbmp: TIEBitmap;
  ps, pd: PRGB;
  k: double;
  //
  procedure GetNeighbourhood;
  var
    i, j: integer;
    px: PRGB;
    x1, x2, y1, y2: integer;
  begin
    nr := 0;
    ng := 0;
    nb := 0;
    x1 := imax(0, x - nsize);
    x2 := imin(bitmap.Width - 1, x + nsize);
    y1 := imax(0, y - nsize);
    y2 := imin(bitmap.Height - 1, y + nsize);
    for i := y1 to y - 1 do
    begin
      px := bitmap.Scanline[i];
      inc(px, x1);
      for j := x1 to x - 1 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
      for j := x + 1 to x2 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
    end;
    for i := y + 1 to y2 do
    begin
      px := bitmap.Scanline[i];
      inc(px, x1);
      for j := x1 to x - 1 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
      for j := x + 1 to x2 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
    end;
    i := y2 - y1;
    j := i * (x2 - x1);
    if j <> 0 then
    begin
      nr := nr div j;
      ng := ng div j;
      nb := nb div j;
    end;
  end;
  //
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  nsize := Neighbourhood div 2;
  k := Intensity / 10;
  newbmp := TIEBitmap.Create;
  newbmp.Allocate(bitmap.width, bitmap.height, ie24rgb);
  for y := fSelY1 to fSelY2 do
  begin
    ps := bitmap.GetRow(y);
    inc(ps, fSelX1);
    pd := newbmp.Scanline[y];
    inc(pd, fSelX1);
    for x := fSelX1 to fSelX2 do
    begin
      GetNeighbourhood;
      with ps^ do
      begin
        pd^.r := blimit(trunc(r + k * (r - nr)));
        pd^.g := blimit(trunc(g + k * (g - ng)));
        pd^.b := blimit(trunc(b + k * (b - nb)));
      end;
      inc(pd);
      inc(ps);
    end;
    bitmap.FreeRow(y);
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (y - fSelY1 + 1)));
  end;
  bitmap.AssignImage(newbmp);
  FreeAndNil(newbmp);
end;


procedure IEUnsharpMask(Bitmap:TIEBitmap; fSelx1, fSely1, fSelx2, fSely2:integer; Radius:integer; Amount:double; Threshold:double; fOnProgress:TIEProgressEvent; Sender:TObject);
var
  blurImage:TIEBitmap;
  px, pblur:PRGB;
  row, col:integer;
  v:double;
  qt:double;
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);

  qt := Threshold * 255;

  blurImage := TIEBitmap.Create(Bitmap);
  try
    _IEGBlur(blurImage, Radius, fOnProgress, Sender);
    for row:=fSelY1 to fSelY2 do
    begin
      px := Bitmap.Scanline[row]; inc(px, fSelX1);
      pblur := blurImage.Scanline[row]; inc(pblur, fSelX1);
      for col:=fSelX1 to fSelX2 do
      begin
        v := px^.r - pblur^.r;
        if abs(2*v) >= qt then
          px^.r := blimit(round(px^.r + v * Amount));

        v := px^.g - pblur^.g;
        if abs(2*v) >= qt then
          px^.g := blimit(round(px^.g + v * Amount));

        v := px^.b - pblur^.b;
        if abs(2*v) >= qt then
          px^.b := blimit(round(px^.b + v * Amount));

        inc(px);
        inc(pblur);
      end;
    end;
  finally
    blurImage.Free;
  end;
end;

{!!
<FS>TImageEnProc.UnsharpMask

<FM>Declaration<FC>
procedure UnsharpMask(Radius:integer = 4; Amount:double = 1.0; Threshold:double = 0.05);

<FM>Description<FN>
Substracts the image to its gaussian blurred version.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Radius<FN></C> <C>Radius of gaussian blur matrix. (1..)</C> </R>
<R> <C><FC>Amount<FN></C> <C>Difference between origianl and blur image. (0.0 to 5.0) </C> </R>
<R> <C><FC>Threshold<FN></C> <C>Threshold of maximum luminosity value to apply the effect. (0.0 to 1.0)</C> </R>
</TABLE>

<FM>Example<FC>
ImageEnView1.Proc.UnsharpMask(2, 2.0, 0.05);
!!}
procedure TImageEnProc.UnsharpMask(Radius:integer; Amount:double; Threshold:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_UNSHARPMASK, [Radius, Amount, Threshold]), ProcBitmap, mask) then
    exit;
  IEUnsharpMask(ProcBitmap, x1, y1, x2, y2, Radius, Amount, Threshold, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


{!!
<FS>TImageEnProc.RemoveRedEyes

<FM>Declaration<FC>
procedure RemoveRedEyes;

<FM>Description<FN>
Applies a simple algorithm which helps to remove red eyes. You can apply this function to the whole image, but it is better to select only the area which contains the eye, otherwise other parts of the image could be changed.

!!}
procedure TImageEnProc.RemoveRedEyes;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_REMOVEREDEYES, ProcBitmap, mask) then
    exit;
  _IERemoveRedEyes(ProcBitmap, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure _IERemoveRedEyes(bitmap: TIEBitmap; fSelx1, fSely1, fSelx2, fSely2: integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  row, col: integer;
  nrv, bluf, redq, powr, powb, powg: double;
  per1: double;
  px: PRGB;
begin
  fSelX2 := imin(fSelX2, bitmap.Width);  dec(fSelX2);
  fSelY2 := imin(fSelY2, bitmap.Height); dec(fSelY2);
  per1 := 100 / (fSelY2 - fSelY1 + 0.5);
  for row := fSelY1 to fSelY2 do
  begin
    px := bitmap.Scanline[row];
    for col := fSelX1 to fSelX2 do
    begin
      nrv := px^.g + px^.b;
      if nrv < 1 then
        nrv := 1;
      if px^.g > 1 then
        bluf := px^.b / px^.g
      else
        bluf := px^.b;
      bluf := dMax(0.5, dMin(1.5, Sqrt(bluf)));
      redq := (px^.r / nrv) * bluf;
      if redq > 0.7 then
      begin
        powr := 1.775 - (redq * 0.75 + 0.25);
        if powr < 0 then
          powr := 0;
        powr := powr * powr;
        powb := 1 - (1 - powr) / 2;
        powg := 1 - (1 - powr) / 4;
        with px^ do
        begin
          r := Round(powr * r);
          b := Round(powb * b);
          g := Round(powg * g);
        end;
      end;
      inc(px);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * (row - fSelY1 + 1)));
  end;
end;

procedure IEFields_warp(source: TIEBitmap; asource_lines: PIELineArray; adest_lines: PIELineArray; num_lines:integer; num_frames: integer; outimages: TList);
type
  TPDPoint = record
    x, y: double;
  end;
  TLINE = record
    P: TPDPoint;
    Q: TPDPoint;
    dx: double;
    dy: double;
    length_squared: double;
    length: double;
  end;
  TLINEARRAY = array[0..65535] of TLINE;
  PLINEARRAY = ^TLINEARRAY;
const
  a: double = 0.001;
  b: double = 2.0;
  p: double = 0.75;
var
  frame: integer;
  line: integer;
  x, y: integer;
  source_x, source_y: integer;
  u, v: double;
  source_index: integer;
  dest_index: integer;
  warp_lines: array[0..99] of TLINE;
  fweight: double;
  last_row, last_col: integer;
  fraction, distance: double;
  fdist: double;
  qdx, qdy: double;
  weight_sum: double;
  numerator: double;
  denominator: double;
  sum_x, sum_y: double;
  weight: double;
  sourcep: PRGB;
  destp: PRGB;
  cols, rows: integer;
  dest: TIEBitmap;
  source_lines: PLINEARRAY;
  dest_lines: PLINEARRAY;
  px:PRGB;
begin
  getmem(source_lines, sizeof(TLINE) * num_lines);
  getmem(dest_lines, sizeof(TLINE) * num_lines);
  for x := 0 to num_lines - 1 do
  begin
    source_lines[x].P.x := asource_lines[x].P.x;
    source_lines[x].P.y := asource_lines[x].P.y;
    source_lines[x].Q.x := asource_lines[x].Q.x;
    source_lines[x].Q.y := asource_lines[x].Q.y;
    source_lines[x].dx := source_lines[x].Q.x - source_lines[x].P.x;
    source_lines[x].dy := source_lines[x].Q.y - source_lines[x].P.y;
    source_lines[x].length_squared := source_lines[x].dx * source_lines[x].dx + source_lines[x].dy * source_lines[x].dy;
    source_lines[x].length := sqrt(source_lines[x].length_squared);
    dest_lines[x].P.x := adest_lines[x].P.x;
    dest_lines[x].P.y := adest_lines[x].P.y;
    dest_lines[x].Q.x := adest_lines[x].Q.x;
    dest_lines[x].Q.y := adest_lines[x].Q.y;
    dest_lines[x].dx := dest_lines[x].Q.x - dest_lines[x].P.x;
    dest_lines[x].dy := dest_lines[x].Q.y - dest_lines[x].P.y;
    dest_lines[x].length_squared := dest_lines[x].dx * dest_lines[x].dx + dest_lines[x].dy * dest_lines[x].dy;
    dest_lines[x].length := sqrt(dest_lines[x].length_squared);
  end;

  cols := source.Width;
  rows := source.Height;
  last_row := rows - 1;
  last_col := cols - 1;

  for frame := 1 to num_frames - 1 do
  begin

    dest := TIEBitmap.Create;
    dest.Allocate(source.Width, source.Height, source.PixelFormat);
    outimages.Add(dest);

    fweight := frame / num_frames;

    for line := 0 to num_lines - 1 do
    begin
      warp_lines[line].P.x := source_lines[line].P.x + ((dest_lines[line].P.x - source_lines[line].P.x) * fweight);
      warp_lines[line].P.y := source_lines[line].P.y + ((dest_lines[line].P.y - source_lines[line].P.y) * fweight);
      warp_lines[line].Q.x := source_lines[line].Q.x + ((dest_lines[line].Q.x - source_lines[line].Q.x) * fweight);
      warp_lines[line].Q.y := source_lines[line].Q.y + ((dest_lines[line].Q.y - source_lines[line].Q.y) * fweight);
      warp_lines[line].dx := warp_lines[line].Q.x - warp_lines[line].P.x;
      warp_lines[line].dy := warp_lines[line].Q.y - warp_lines[line].P.y;
      warp_lines[line].length_squared := warp_lines[line].dx * warp_lines[line].dx + warp_lines[line].dy * warp_lines[line].dy;
      warp_lines[line].length := sqrt(warp_lines[line].length_squared);
    end;

    for y := 0 to rows - 1 do
    begin
      px:=dest.Scanline[y];
      for x := 0 to cols - 1 do
      begin
        weight_sum := 0;
        sum_x := 0;
        sum_y := 0;
        for line := 0 to num_lines - 1 do
        begin
          qdx := x - warp_lines[line].P.x;
          qdy := y - warp_lines[line].P.y;

          with warp_lines[line] do
          begin
            fraction := (qdx * dx + qdy * dy) / length_squared;
            fdist    := (qdy * dx - qdx * dy) / length;
          end;

          if fraction <= 0 then
            distance := sqrt(qdx * qdx + qdy * qdy)
          else if fraction >= 1 then
          begin
            qdx := x - warp_lines[line].Q.x;
            qdy := y - warp_lines[line].Q.y;
            distance := sqrt(qdx * qdx + qdy * qdy);
          end else if fdist >= 0 then
            distance := fdist
          else
            distance := -1 * fdist;

          with source_lines[line] do
          begin
            u := P.x + fraction * dx - fdist * dy / length;
            v := P.y + fraction * dy + fdist * dx / length;
          end;

          numerator := iepower(warp_lines[line].length, p);
          denominator := a + distance;
          weight := iepower((numerator / denominator), b);

          sum_x := sum_x + ((u - x) * weight);
          sum_y := sum_y + ((v - y) * weight);
          weight_sum := weight_sum + weight;

        end;

        source_x := trunc(x + sum_x / weight_sum + 0.5);
        source_y := trunc(y + sum_y / weight_sum + 0.5);
        if source_x<0 then
          source_x:=0
        else if source_x>last_col then
          source_x:=last_col;
        if source_y<0 then
          source_y:=0
        else if source_y>last_row then
          source_y:=last_row;

        px^:=source.Pixels_ie24RGB[source_x, source_y];

        inc(px);
      end;
    end;

  end;

  freemem(source_lines);
  freemem(dest_lines);
end;

function IEAddNewFilter( const filter:TGraphFilter; const name:string ):integer;
var
  f:PIEGraphFilter;
begin
  new(f);
  result:=IEFiltPres.Add(f);
  move(filter,f^,sizeof(TGraphFilter));
  IEFiltPresNames.Add(name);
end;

function IEGetFilter( index:integer ):PIEGraphFilter;
begin
  result:=IEFiltPres[index];
end;

function IEGetFilterName( index:integer ):string;
begin
  result:=IEFiltPresNames[index]
end;

function IEGetFiltersCount:integer;
begin
  result:=IEFiltPres.Count;
end;

procedure IEInitFilterPresets;
const
  FiltPres: array[0..8] of TGraphFilter = (
    (Values: ((0, 0, 0), // None
              (0, 1, 0),
              (0, 0, 0)); Divisor: 0),
    (Values: ((1, 1, 1), // blur 1
              (1, 1, 1),
              (1, 1, 1)); Divisor: 9),
    (Values: ((1, 1, 1), // edge
              (1, -8, 1),
              (1, 1, 1)); Divisor: 1),
    (Values: ((-1, 0, 1), // emboss
              (-1, 1, 1),
              (-1, 0, 1)); Divisor: 1),
    (Values: ((0, -1, 0), // high pass 1
              (-1, 5, -1),
              (0, -1, 0)); Divisor: 1),
    (Values: ((-1, -1, -1), // high pass 2
              (-1, 9, -1),
              (-1, -1, -1)); Divisor: 1),
    (Values: ((1, -2, 1), // high pass 3
              (-2, 5, -2),
              (1, -2, 1)); Divisor: 1),
    (Values: ((1, 1, 1), // Low pass 1
              (1, 1, 1),
              (1, 1, 1)); Divisor: 10),
    (Values: ((1, 2, 1), // Low pass 2
              (2, 4, 2),
              (1, 2, 1)); Divisor: 16)
    );
  FiltPresNames: array [0..8] of string = (
    IERS_FLT_NONE,
    IERS_FLT_BLUR,
    IERS_FLT_EDGES,
    IERS_FLT_EMBOSS,
    IERS_FLT_HIGH_PASS_1,
    IERS_FLT_HIGH_PASS_2,
    IERS_FLT_HIGH_PASS_3,
    IERS_FLT_LOW_PASS_1,
    IERS_FLT_LOW_PASS_2 );
var
  i:integer;
begin
  IEFiltPres:=TList.Create;
  IEFiltPresNames:=TStringList.Create;
  for i:=0 to high(Filtpres) do
    IEAddNewFilter( FiltPres[i] , FiltPresNames[i]);
end;

procedure IEFreeFilterPresets;
var
  i:integer;
begin
  for i:=0 to IEFiltPres.Count-1 do
  begin
    dispose( IEFiltPres[i] );
  end;
  FreeAndNil(IEFiltPres);
  FreeAndNil(IEFiltPresNames);
end;

procedure _IERoundImage(ProcBitmap:TIEBitmap; RoundWidth,RoundHeight:integer; fOnProgress: TIEProgressEvent; self:TObject);
var
  x,y:integer;
  nsteps:integer;
  ptr:ppointarray;
  i:integer;
  xrect:TRect;
  xx,yy:integer;
begin
  if (ProcBitmap.Width=0) or (ProcBitmap.Height=0) or (RoundWidth=0) or (RoundHeight=0) then
    exit;
  xrect:=rect(0,0,ProcBitmap.Width,ProcBitmap.Height);
  nsteps:=(RoundWidth+RoundHeight);
  getmem(ptr,sizeof(TPoint)*nsteps);
  // top-left round
  IEBezier2D4Controls(Point(xrect.Left,xrect.Top+RoundHeight),xrect.TopLeft,Point(xrect.Left+RoundWidth,xrect.Top),Point(xrect.Left+RoundWidth,xrect.Top),ptr,nsteps);
  for i:=0 to nsteps-1 do
  begin
    xx:=imin(ptr[i].X,ProcBitmap.Height-1);
    yy:=imin(ptr[i].Y,ProcBitmap.Width-1);
    for y:=0 to yy do
      for x:=0 to xx do
      begin
        ProcBitmap.Alpha[x,y]:=0;
        ProcBitmap.Alpha[ProcBitmap.Width-x-1,y]:=0;
      end;
  end;
  // bottom-right round
  IEBezier2D4Controls(Point(xrect.Right,xrect.Bottom-RoundHeight),Point(xrect.Right,xrect.Bottom),Point(xrect.Right-RoundWidth,xrect.Bottom),Point(xrect.Right-RoundWidth,xrect.Bottom),ptr,nsteps);
  for i:=0 to nsteps-1 do
  begin
    xx:=imax(ptr[i].X,0);
    yy:=imax(ptr[i].Y,0);
    for y:=ProcBitmap.Height-1 downto yy do
      for x:=ProcBitmap.Width-1 downto xx do
      begin
        ProcBitmap.Alpha[x,y]:=0;
        ProcBitmap.Alpha[ProcBitmap.Width-x-1,y]:=0;
      end;
  end;
  freemem(ptr);
  ProcBitmap.AlphaChannel.SyncFull;
end;

{!!
<FS>TImageEnProc.RoundImage

<FM>Declaration<FC>
procedure RoundImage(RoundWidth, RoundHeight:integer);

<FM>Description<FN>
Makes corners rounded.
<FC>RoundWidth<FN> and <FC>RoundHeight<FN> specify the round size.

<FM>Example<FC>

ImageEnView1.Proc.RoundImage( 100, 100 );

!!}
procedure TImageEnProc.RoundImage(RoundWidth, RoundHeight:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([], x1, y1, x2, y2, Format(IERS_ROUNDIMAGE, [RoundWidth, RoundHeight]), ProcBitmap, mask) then
    exit;
  _IERoundImage(ProcBitmap, RoundWidth,RoundHeight, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.RadialStretch

<FM>Declaration<FC>
procedure RadialStretch(ARed, BRed, CRed, DRed, AGreen, BGreen, CGreen, DGreen, ABlue, BBlue, CBlue, DBlue:double);

<FM>Description<FN>
This functions performs a radial stretch for each color component (R,G,B). This allows manual correction of Barrel Distortion and Pincushion distortion (lens distortion, underwater distortion).
A,B,C,D (followed by channel name) are the coefficients

Look at the demo for more details.

!!}
procedure TImageEnProc.RadialStretch(ARed, BRed, CRed, DRed, AGreen, BGreen, CGreen, DGreen, ABlue, BBlue, CBlue, DBlue:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_RADIALSTRETCH, ProcBitmap, mask) then
    exit;
  _IERadialStretch(ProcBitmap,ARed,BRed,CRed,DRed, AGreen,BGreen,CGreen,DGreen, ABlue,BBlue,CBlue,DBlue, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure _IERadialStretch(bitmap: TIEBitmap; ARed,BRed,CRed,DRed, AGreen,BGreen,CGreen,DGreen, ABlue,BBlue,CBlue,DBlue:double; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  a,b,c,d:array [0..2] of double;
  tmpbmp:TIEBitmap;
  x,y:integer;
  dst,src:pbyte;
  xx,yy:integer;
  r,scale:double;
  xs,ys:integer;
  wh2:double;
  i,w2,h2:integer;
  o1:double;
  lper, per:integer;
begin

  a[0]:=ABlue;
  a[1]:=AGreen;
  a[2]:=ARed;

  b[0]:=BBlue;
  b[1]:=BGreen;
  b[2]:=BRed;

  c[0]:=CBlue;
  c[1]:=CGreen;
  c[2]:=CRed;

  d[0]:=DBlue;
  d[1]:=DGreen;
  d[2]:=DRed;

  w2:=bitmap.Width div 2;
  h2:=bitmap.Height div 2;

  if bitmap.Width<bitmap.Height then
    wh2:=bitmap.Width / 2
  else
    wh2:=bitmap.Height / 2;

  tmpbmp:=TIEBitmap.Create;
  tmpbmp.Allocate( bitmap.Width, bitmap.Height, ie24RGB );

  lper := -1;

  for i:=0 to 2 do
  begin

    for y:=0 to tmpbmp.Height-1 do
    begin

      dst:=tmpbmp.Scanline[y];
      inc(dst,i);

      ys:=y-h2;
      o1:=ys*ys;

      for x:=0 to tmpbmp.width-1 do
      begin

        xs:=x-w2;
        r := sqrt( xs*xs + o1 ) / wh2;
        scale := ((a[i] * r + b[i]) * r + c[i]) * r + d[i];
        xx:=round( xs* scale ) + w2;
        yy:=round( ys* scale ) + h2;

        if (xx<tmpbmp.Width) and (yy<tmpbmp.Height) and (xx>=0) and (yy>=0) then
        begin
          src:=bitmap.ScanLine[yy];
          inc(src, xx*3+i );
          dst^:=src^;
        end
        else
          dst^:=0;

        inc(dst,3);

      end;

      if assigned(fOnProgress) then
      begin
        per := trunc((i/3+(y/tmpbmp.Height/3))*100);
        if per<>lper then
        begin
          fOnProgress(Sender, per);
          lper := per;
        end;
      end;

    end;

  end;

  bitmap.assign(tmpbmp);
  FreeAndNil(tmpbmp);

end;

// Floyd-Steinberg dithering
procedure fsditherRow(src_row:PRGBROW; dest_row:pbyte; error:pdoublearray; nexterror:pdoublearray; row_width:integer; var dir:integer);
var
  col:integer;
  xstart, xend:integer;
  newval:double;
  cerror:double;
  v:integer;
begin
  ZeroMemory(nexterror,row_width*sizeof(double));

  if (dir=1) then
  begin
    xstart:=0;
    xend:=row_width;
  end
  else
  begin
    xstart:=row_width-1;
    xend:=-1;
  end;

  col:=xstart;
  while col<>xend do
  begin
    with src_row[col] do
      v:=(r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;

    newval := iefloor ((v + error[col]) + 0.5);

    if newval<128 then
      newval:=0
    else
      newval:=255;

    _SetPixelbw(dest_row,col, round(newval) );

    cerror := v + error[col] - newval;
    nexterror[col] := nexterror[col] + (cerror * 5/16);

    if (col+dir >= 0) and (col+dir < row_width) then
    begin
      error[col+dir] := error[col+dir] + (cerror * 7/16);
      nexterror[col+dir] := nexterror[col+dir] + (cerror * 1/16);
    end;
    if (col-dir >= 0) and (col-dir < row_width) then
      nexterror[col-dir] := nexterror[col-dir] + (cerror * 3/16);

    inc(col,dir);
  end;

  dir := -dir;
end;

// Floyd-Steinberg dithering
procedure _IEfsdither(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  error, nexterror, tmp:pdoublearray;
  row:integer;
  newbitmap:TIEBitmap;
  dir:integer;
  per1: double;
begin
  per1 := 100 / (bitmap.height);

  newbitmap:=TIEBitmap.Create;
  newbitmap.Allocate(bitmap.width,bitmap.height,ie1g);

  getmem(error , bitmap.Width*sizeof(double) );
  getmem(nexterror , bitmap.Width*sizeof(double) );

  ZeroMemory(error,bitmap.Width*sizeof(double));
  ZeroMemory(nexterror,bitmap.Width*sizeof(double));

  dir:=1;
  for row:=0 to bitmap.height-1 do
  begin
      fsditherRow(bitmap.Scanline[row],newbitmap.Scanline[row],error,nexterror,bitmap.width,dir);
      tmp:=error;
      error:=nexterror;
      nexterror:=tmp;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * row) );
  end;

  freemem(error);
  freemem(nexterror);

  bitmap.assign(newbitmap);
  FreeAndNil(newbitmap);
end;

{!!
<FS>TImageEnProc.ConvertToBW_FloydSteinberg

<FM>Declaration<FC>
procedure ConvertToBW_FloydSteinberg;

<FM>Description<FN>
Converts current image to black/white using Floyd-Steinberg algorithm.

!!}
procedure TImageEnProc.ConvertToBW_FloydSteinberg;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CONVERTTOBW_FLOYDSTEINBERG, ieuImage);
  _IEfsdither(fIEBitmap,fOnProgress, self);
  Update;
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.Crop

<FM>Declaration<FC>
procedure Crop(x1, y1, x2, y2:integer);
procedure Crop(Rect:TRect);

<FM>Description<FN>
Crop gets as current image the specified rectangle, cutting off the remaining image.

<FM>Example<FC>

ImageEnView1.Proc.Crop(10, 10, 100, 100);

!!}
procedure TImageEnProc.Crop(x1, y1, x2, y2:integer);
var
  tmpImage:TIEBitmap;
  w,h:integer;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if (x1=0) and (y1=0) and (x2=fIEBitmap.Width-1) and (y2=fIEBitmap.Height-1) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(Format(IERS_CROP, [x1, y1, x2, y2]), ieuImage);
  w:=x2-x1+1;
  h:=y2-y1+1;
  tmpImage:=TIEBitmap.Create;
  tmpImage.Allocate(w, h, fIEBitmap.PixelFormat);

  fIEBitmap.CopyRectTo(tmpImage, x1, y1, 0, 0, w, h);
  fIEBitmap.AssignImage(tmpImage);
  if fIEBitmap.HasAlphaChannel then
  begin
    // suppose AssignImage has not changed AlphaChannel size
    fIEBitmap.AlphaChannel.CopyRectTo(tmpImage.AlphaChannel, x1, y1, 0, 0, w, h);
    fIEBitmap.AlphaChannel.AssignImage(tmpImage.AlphaChannel);
  end;

  FreeAndNil(tmpImage);
  Update;
  DoFinishWork;
end;

procedure TImageEnProc.Crop(Rect:TRect);
begin
  Crop(Rect.Left,Rect.Top,Rect.Right,Rect.Bottom);
end;

{!!
<FS>TImageEnProc.AutoCrop

<FM>Declaration<FC>
function AutoCrop(Tolerance:integer; Background:TRGB; DoCrop:boolean):TRect;
function AutoCrop(Tolerance:integer; Background:TColor; DoCrop:boolean):TRect;

<FM>Description<FN>
AutoCrop removes the border with color like Background from the image borders.
The Tolerance specifies how much background color must be equal to actual pixel.
When optional DoCrop parameter is False then AutoCrop doesn't crop the image, but just return the suggested area to crop.

Returns the area to crop or cropped.

<FM>Example<FC>

// removes the black border from a scanned document
ImageEnView1.IO.Acquire;
ImageEnView1.Proc.AutoCrop(10, CreateRGB(0,0,0) );
!!}
function TImageEnProc.AutoCrop(Tolerance:integer; Background:TRGB; DoCrop:boolean):TRect;
var
  x,y,x1,y1,x2,y2:integer;
  done:boolean;
  function isbackground: boolean;
  var
    dr, dg, db: integer;
    col: TRGB;
  begin
    col := fIEBitmap.Pixels[x, y];
    dr := abs(Background.r - col.r);
    dg := abs(Background.g - col.g);
    db := abs(Background.b - col.b);
    result := (dr <= tolerance) and (dg <= tolerance) and (db <= tolerance);
  end;
begin
  if not MakeConsistentBitmap([]) then
    exit;

  x1:=0; y1:=0;
  //x2:=fIEBitmap.Width-1;
  y2:=fIEBitmap.Height-1;

  // find top
  done:=false;
  for y:=0 to fIEBitmap.Height-1 do
  begin
    for x:=0 to fIEBitmap.Width-1 do
    begin
      if not isbackground then
      begin
        y1:=y;
        x1:=x;
        done:=true;
        break;
      end;
    end;
    if done then break;
  end;

  // find left
  for y:=y1 to fIEBitmap.Height-1 do
  begin
    for x:=0 to fIEBitmap.Width-1 do
    begin
      if not isbackground then
      begin
        if x<x1 then
          x1:=x;
        break;
      end;
    end;
  end;

  // find right
  x2:=x1;
  for y:=y1 to fIEBitmap.Height-1 do
  begin
    for x:=fIEBitmap.Width-1 downto x1 do
    begin
      if not isbackground then
      begin
        if x>x2 then
          x2:=x;
        break;
      end;
    end;
  end;

  // find bottom
  done:=false;
  for y:=fIEBitmap.Height-1 downto 0 do
  begin
    for x:=0 to fIEBitmap.Width-1 do
    begin
      if not isbackground then
      begin
        y2:=y;
        done:=true;
        break;
      end;
    end;
    if done then break;
  end;

  if DoCrop then
    Crop(x1,y1,x2,y2);

  result:=Rect(x1,y1,x2,y2);
end;

function TImageEnProc.AutoCrop(Tolerance:integer; Background:TColor; DoCrop:boolean):TRect;
begin
  result:=AutoCrop(Tolerance,TColor2TRGB(Background),DoCrop);
end;

// detect useful area with density analysis
// BorderRate: suggested 6, the difference between border and text
// works only when paper is white and text is black
function IEAutoCrop2(bitmap:TIEBitmap; BorderRate:double):TRect;
var
  rows,cols:pintegerarray;
  i,j,v:integer;
  rows_media,cols_media:double;
  x1,y1,x2,y2:integer;
begin

  // rows
  getmem(rows,sizeof(integer)*bitmap.Height);
  for i:=0 to bitmap.Height-1 do
  begin
    v:=0;
    for j:=0 to bitmap.Width-1 do
    begin
      with bitmap.Pixels[j,i] do
        inc(v, (r+g+b) div 3);
    end;
    rows[i]:=v;
  end;

  // cols
  getmem(cols,sizeof(integer)*bitmap.Width);
  for i:=0 to bitmap.Width-1 do
  begin
    v:=0;
    for j:=0 to bitmap.Height-1 do
    begin
      with bitmap.Pixels[i,j] do
        inc(v, (r+g+b) div 3);
    end;
    cols[i]:=v;
  end;

  // row media
  rows_media:=0;
  for i:=0 to bitmap.Height-1 do
    rows_media := rows_media + rows[i];
  rows_media:=rows_media / bitmap.Height;

  // col media
  cols_media:=0;
  for i:=0 to bitmap.Width-1 do
    cols_media := cols_media + cols[i];
  cols_media := cols_media / bitmap.Width;

  // check current and next pixel

  // find left (x1)
  for x1:=0 to bitmap.Width-2 do
    if (abs(cols[x1]-cols_media) < cols_media / BorderRate) and (abs(cols[x1+1]-cols_media) < cols_media / BorderRate) then
      break;

  // find right (x2)
  for x2:=bitmap.Width-1 downto 1 do
    if (abs(cols[x2]-cols_media) < cols_media / BorderRate) and (abs(cols[x2-1]-cols_media) < cols_media / BorderRate) then
      break;

  // find top (y1)
  for y1:=0 to bitmap.Height-2 do
    if (abs(rows[y1]-rows_media) < rows_media / BorderRate) and (abs(rows[y1+1]-rows_media) < rows_media / BorderRate) then
      break;

  // find bottom (y2)
  for y2:=bitmap.Height-1 downto 1 do
    if (abs(rows[y2]-rows_media) < rows_media / BorderRate) and (abs(rows[y2-1]-rows_media) < rows_media / BorderRate) then
      break;

  freemem(cols);
  freemem(rows);

  result:=Rect(x1,y1,x2,y2);

end;

{!!
<FS>TImageEnProc.AutoCrop2

<FM>Declaration<FC>
function AutoCrop2(BorderRate:double=6; DoCrop:boolean):TRect;

<FM>Description<FN>
AutoCrop2 automatically removes the border using a density analysis algorithm.
BorderRate is the difference between border and text. Must be >0.
This method works only when paper is white and text is black.
When optional DoCrop parameter is False then AutoCrop2 doesn't crop the image, but just return the suggested area to crop.

Returns the area to crop or cropped.

<FM>Example<FC>
// removes the black border from a scanned document
ImageEnView1.IO.Acquire;
ImageEnView1.Proc.AutoCrop2;
!!}
function TImageEnProc.AutoCrop2(BorderRate:double; DoCrop:boolean):TRect;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if BorderRate<=0 then
    exit;

  result:=IEAutoCrop2(fIEbitmap,BorderRate);

  if DoCrop then
    Crop(result);
end;


// returns the average Red,Green,Blue intensity difference between two images
// the bitmaps must have the same size and pixelformat
// works only with ie24RGB and ie48RGB
procedure IEGetLuminosityDiff(image1,image2:TIEBitmap; var Red,Green,Blue:integer);
var
  x,y,wh:integer;
  rgb1,rgb2:PRGB;
  rgb481,rgb482:PRGB48;
  r1,g1,b1,r2,g2,b2:integer;
begin
  Red:=0;
  Green:=0;
  Blue:=0;
  if (image1.Width<>image2.Width) or (image1.Height<>image2.Height) or (image1.PixelFormat<>image2.PixelFormat) then
    exit;
  r1:=0; g1:=0; b1:=0;
  r2:=0; g2:=0; b2:=0;
  case image1.PixelFormat of
    ie24RGB:
      for y:=0 to image1.Height-1 do
      begin
        rgb1:=image1.Scanline[y];
        rgb2:=image2.Scanline[y];
        for x:=0 to image1.Width-1 do
        begin
          inc(r1,rgb1.r);
          inc(g1,rgb1.g);
          inc(b1,rgb1.b);
          inc(r2,rgb2.r);
          inc(g2,rgb2.g);
          inc(b2,rgb2.b);
          inc(rgb1);
          inc(rgb2);
        end;
      end;
    ie48RGB:
      for y:=0 to image1.Height-1 do
      begin
        rgb481:=image1.Scanline[y];
        rgb482:=image2.Scanline[y];
        for x:=0 to image1.Width-1 do
        begin
          inc(r1,rgb481.r);
          inc(g1,rgb481.g);
          inc(b1,rgb481.b);
          inc(r2,rgb482.r);
          inc(g2,rgb482.g);
          inc(b2,rgb482.b);
          inc(rgb481);
          inc(rgb482);
        end;
      end;
  end;
  wh:=image1.Width*image1.Height;
  r1:=r1 div wh;
  g1:=g1 div wh;
  b1:=b1 div wh;
  r2:=r2 div wh;
  g2:=g2 div wh;
  b2:=b2 div wh;

  Red:=(r1-r2);
  Green:=(g1-g2);
  Blue:=(b1-b2);
end;


// desiredHistogram must be of 256 values and each value must be from 0 to 255
// image.PixelFormat can be ie24RGB or ie48RGB
procedure IEHistogramSpecification(image:TIEBitmap; channel:integer; var desiredHistogram:array of integer; desiredHistPixelsCount:integer);
const
  maxval=255;
var
  histogram:pintegerarray;
  sum_hist:pdoublearray;
  scale_factor:double;
  difference:double;
  i,j:integer;
  sum:integer;
  inv_hist:pintegerarray;
  min:integer;
  pb:pbyte;
  pw:pword;
begin
  if (image.Width=0) or (image.Height=0) then
    exit;

  getmem(histogram,sizeof(integer)*(maxval+1));
  getmem(sum_hist,sizeof(double)*(maxval+1));
  getmem(inv_hist,sizeof(integer)*(maxval+1));

  for i:=0 to maxval do
    histogram[i]:=0;

  case image.PixelFormat of
    ie24RGB:
      for i:=0 to image.Height-1 do
      begin
        pb:=image.Scanline[i];
        inc(pb,channel);
        for j:=0 to image.Width-1 do
        begin
          inc(histogram[pb^]);
          inc(pb,3);
        end;
      end;
    ie48RGB:
      for i:=0 to image.Height-1 do
      begin
        pw:=image.Scanline[i];
        inc(pw,2-channel);
        for j:=0 to image.Width-1 do
        begin
          inc(histogram[pw^ shr 8]);
          inc(pw,3);
        end;
      end;
  end;

  sum:=0;
  scale_factor:=maxval / (image.Width*image.Height);
  for i:=0 to maxval do
  begin
    sum:=sum+histogram[i];
    sum_hist[i]:=sum*scale_factor;
  end;

  case image.PixelFormat of
    ie24RGB:
      for i:=0 to image.Height-1 do
      begin
        pb:=image.Scanline[i];
        inc(pb,channel);
        for j:=0 to image.Width-1 do
        begin
          pb^:=trunc(sum_hist[pb^]);
          inc(pb,3);
        end;
      end;
    ie48RGB:
      for i:=0 to image.Height-1 do
      begin
        pw:=image.Scanline[i];
        inc(pw,2-channel);
        for j:=0 to image.Width-1 do
        begin
          pw^:=trunc(sum_hist[pw^ shr 8]) *257;
          inc(pw,3);
        end;
      end;
  end;

  sum:=0;
  scale_factor:=maxval / desiredHistPixelsCount;
  for i:=0 to maxval do
  begin
    sum:=sum+desiredHistogram[i];
    sum_hist[i]:=sum*scale_factor;
  end;

  for i:=0 to maxval do
  begin
    difference:=abs(i-sum_hist[0]);
    min:=0;
    for j:=0 to maxval do
    begin
      if abs(i-sum_hist[j])<difference then
      begin
        difference:=abs(i-sum_hist[j]);
        min:=j;
      end;
    end;
    inv_hist[i]:=min;
  end;

  case image.PixelFormat of
    ie24RGB:
      for i:=0 to image.Height-1 do
      begin
        pb:=image.Scanline[i];
        inc(pb,channel);
        for j:=0 to image.Width-1 do
        begin
          pb^:=inv_hist[pb^];
          inc(pb,3);
        end;
      end;
    ie48RGB:
      for i:=0 to image.Height-1 do
      begin
        pw:=image.Scanline[i];
        inc(pw,2-channel);
        for j:=0 to image.Width-1 do
        begin
          pw^:=inv_hist[pw^ shr 8] *257;
          inc(pw,3);
        end;
      end;
  end;

  freemem(histogram);
  freemem(sum_hist);
  freemem(inv_hist);
end;

// compare colors levels of templateimage and adjust targetimage
// works with ie24RGB and ie48RGB
// images can be of different sizes but must contain the same subject
// template image must be ie24RGB
procedure IEAdjustColors(templateimage,targetimage:TIEBitmap);
var
  x,y:integer;
  rgb:PRGB;
  red,green,blue:array [0..255] of integer;
  c:integer;
begin
  if (templateimage.PixelFormat<>ie24RGB) or (templateimage.Width=0) or (templateimage.Height=0) or (targetimage.Width=0) or (targetimage.Height=0) then
    exit;

  for y:=0 to 255 do
  begin
    red[y]:=0;
    green[y]:=0;
    blue[y]:=0;
  end;
  c:=0;
  for y:=0 to templateimage.Height-1 do
  begin
    rgb:=templateimage.Scanline[y];
    for x:=0 to templateimage.Width-1 do
    begin
      with rgb^ do
      begin
        inc(red[r]);
        inc(green[g]);
        inc(blue[b]);
      end;
      inc(rgb);
      inc(c);
    end;
  end;

  IEHistogramSpecification(targetimage,0,blue,c);
  IEHistogramSpecification(targetimage,1,green,c);
  IEHistogramSpecification(targetimage,2,red,c);
end;

// works only with ie24RGB
procedure IEApplyCoefficients(bitmap:TIEBitmap; var coeff: array of double; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  row,col,v:integer;
  px:PRGB;
  per1: double;
  LUTR,LUTG,LUTB:array [0..255] of byte;
begin
  for v:=0 to 255 do
  begin
    LUTB[v]:=blimit(trunc(v * coeff[0]));
    LUTG[v]:=blimit(trunc(v * coeff[1]));
    LUTR[v]:=blimit(trunc(v * coeff[2]));
  end;
  per1 := 100 / bitmap.Height;
  for row:=0 to bitmap.Height-1 do
  begin
    px:=bitmap.Scanline[row];
    for col:=0 to bitmap.Width-1 do
    begin
      with px^ do
      begin
        r:=LUTR[r];
        g:=LUTG[g];
        b:=LUTB[b];
      end;
      inc(px);
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * row));
  end;
end;

// working only with ie24RGB
procedure IEGetAverageValues(bitmap:TIEBitmap; var avg:array of double);
var
  c,row,col:integer;
  px:pbyte;
  count:array [0..2] of integer;
begin
  for c:=0 to 2 do
  begin
    count[c]:=0;
    avg[c]:=0;
  end;

  for row:=0 to bitmap.Height-1 do
  begin
    px:=bitmap.Scanline[row];
    for col:=0 to bitmap.Width-1 do
      for c:=0 to 2 do
      begin
        if px^>0 then
        begin
          avg[c]:=avg[c]+px^;
          inc(count[c]);
        end;
        inc(px);
      end;
  end;
  for c:=0 to 2 do
    avg[c]:=avg[c] / count[c];
end;

procedure IEGetStandardDeviation(bitmap:TIEBitmap; var stddev:array of double);
var
  avg:array [0..2] of double;
  c,row,col:integer;
  px:pbyte;
begin
  IEGetAverageValues(bitmap, avg);
  for row:=0 to bitmap.Height-1 do
  begin
    px:=bitmap.Scanline[row];
    for col:=0 to bitmap.Width-1 do
      for c:=0 to 2 do
      begin
        stddev[c]:=stddev[c]+ sqr(px^-avg[c]);
        inc(px);
      end;
  end;
  for c:=0 to 2 do
    stddev[c]:=sqrt( stddev[c]/(bitmap.Width*bitmap.Height-1) );
end;

// ie24RGB ie48RGB
procedure IEGetMinMax(bitmap:TIEBitmap; var min,max:array of integer);
var
  c,row,col:integer;
  px:pbyte;
  pw:pword;
begin
  for c:=0 to 2 do
  begin
    min[c]:=65535;
    max[c]:=0;
  end;
  case bitmap.PixelFormat of
    ie24RGB:
      for row:=0 to bitmap.Height-1 do
      begin
        px:=bitmap.Scanline[row];
        for col:=0 to bitmap.Width-1 do
          for c:=0 to 2 do
          begin
            if min[c]>px^ then
              min[c]:=px^;
            if max[c]<px^ then
              max[c]:=px^;
            inc(px);
          end;
      end;
    ie48RGB:
      for row:=0 to bitmap.Height-1 do
      begin
        pw:=bitmap.Scanline[row];
        for col:=0 to bitmap.Width-1 do
          for c:=0 to 2 do
          begin
            if min[c]>pw^ then
              min[c]:=pw^;
            if max[c]<pw^ then
              max[c]:=pw^;
            inc(pw);
          end;
      end;
  end;
end;

// working only with ie24RGB
procedure IEWhiteBalance_grayworld(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  avg:array [0..2] of double;
  c:integer;
  dmax:double;
  coef:array [0..2] of double;
begin
  IEGetAverageValues(bitmap, avg);

  dmax:=0;
  for c:=0 to 2 do
    if dmax<avg[c] then
      dmax:=avg[c];
  for c:=0 to 2 do
    coef[c] := dmax/avg[c];

  IEApplyCoefficients(bitmap, coef, fOnProgress,Sender);
end;

procedure IEGetAverageWhites(bitmap:TIEBitmap; var wavg:array of double);
var
  c,row,col:integer;
  px:pbyte;
  count:array [0..2] of integer;
  h,s,l:double;
  function ToRemove:boolean;
  begin
    result:= ((h>=0.01) and (h<=0.04)) or   // skin
             ((h>=0.35) and (h<=0.50)) or   // vegetation
             ((h>=0.57) and (h<=0.59));     // sky
  end;
begin
  for c:=0 to 2 do
  begin
    count[c]:=0;
    wavg[c]:=0;
  end;

  for row:=0 to bitmap.Height-1 do
  begin
    px:=bitmap.Scanline[row];
    for col:=0 to bitmap.Width-1 do
    begin
      RGB2HSL(PRGB(px)^,h,s,l);
      if not ToRemove and (s<0.30) and (l>0.70) then
      begin
        for c:=0 to 2 do
        begin
          wavg[c]:=wavg[c]+px^;
          inc(count[c]);
          inc(px);
        end;
      end
      else
        inc(PRGB(px));
    end;
  end;
  for c:=0 to 2 do
    if count[c]=0 then
      wavg[c]:=255
    else
      wavg[c]:=wavg[c] / count[c];
end;


// working only with ie24RGB
procedure IEWhiteBalance_2(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  wavg:array [0..2] of double;
  c:integer;
  coef:array [0..2] of double;
begin
  IEGetAverageWhites(bitmap, wavg);
  for c:=0 to 2 do
    coef[c] := 255/wavg[c];
  IEApplyCoefficients(bitmap, coef, fOnProgress,Sender);
end;

procedure IEWhiteBalance_3(bitmap:TIEBitmap; white_x, white_y:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  wavg:array [0..2] of double;
  c:integer;
  coef:array [0..2] of double;
  min,max:array [0..2] of integer;
begin
  IEGetMinMax(bitmap, min,max);

  wavg[0]:=imax(1,bitmap.Pixels_ie24RGB[white_x,white_y].b);
  wavg[1]:=imax(1,bitmap.Pixels_ie24RGB[white_x,white_y].g);
  wavg[2]:=imax(1,bitmap.Pixels_ie24RGB[white_x,white_y].r);

  for c:=0 to 2 do
    coef[c] := max[c]/wavg[c];

  IEApplyCoefficients(bitmap, coef, fOnProgress,Sender);
end;

// ie24rgb and ie48rgb
procedure IEAdjustGainOffset(bitmap:TIEBitmap; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  min,max:array [0..2] of integer;
  cb,cg,cr:double;
  row,col:integer;
  px:PRGB;
  px48:PRGB48;
  per1:double;
  mx:integer;
begin
  IEGetMinMax(bitmap, min,max);
  case bitmap.PixelFormat of
    ie24RGB: mx:=255;
    ie48RGB: mx:=65535;
    else
      mx:=0;
  end;
  cb:=(mx/(max[0]-min[0]));
  cg:=(mx/(max[1]-min[1]));
  cr:=(mx/(max[2]-min[2]));
  per1 := 100 / bitmap.Height;
  for row:=0 to bitmap.Height-1 do
  begin
    case bitmap.PixelFormat of
      ie24RGB:
        begin
          px:=bitmap.Scanline[row];
          for col:=0 to bitmap.Width-1 do
          begin
            with px^ do
            begin
              b:=trunc( cb * (b-min[0]) );
              g:=trunc( cg * (g-min[1]) );
              r:=trunc( cr * (r-min[2]) );
            end;
            inc(px);
          end;
        end;
      ie48RGB:
        begin
          px48:=bitmap.Scanline[row];
          for col:=0 to bitmap.Width-1 do
          begin
            with px48^ do
            begin
              b:=trunc( cb * (b-min[0]) );
              g:=trunc( cg * (g-min[1]) );
              r:=trunc( cr * (r-min[2]) );
            end;
            inc(px48);
          end;
        end;
    end;
    if assigned(fOnProgress) then
      fOnProgress(Sender, trunc(per1 * row));
  end;
end;

{!!
<FS>TImageEnProc.WhiteBalance_coef

<FM>Declaration<FC>
procedure WhiteBalance_coef(Red, Green, Blue:double);

<FM>Description<FN>
This method applies specified coefficients to each pixel of the image. Coefficients (Red, Green, Blue) are values in the range 0 to 1.

<FM>Example<FC>

// decreases RED by 0.8
ImageEnView1.Proc.WhiteBalance_coef(0.8,1,1);

!!}
procedure TImageEnProc.WhiteBalance_coef(Red, Green, Blue:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
  coef:array [0..2] of double;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_WHITEBALANCE_COEF, [Red, Green, Blue]), ProcBitmap, mask) then
    exit;
  coef[0]:=Blue;
  coef[1]:=Green;
  coef[2]:=Red;
  IEApplyCoefficients(ProcBitmap,coef,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.WhiteBalance_GrayWorld

<FM>Declaration<FC>
procedure WhiteBalance_GrayWorld;

<FM>Description<FN>
Adjust image colors applying the white balance algorithm named Gray World.

<FM>Example<FC>

ImageEnView1.Proc.WhiteBalance_GrayWorld;

!!}
procedure TImageEnProc.WhiteBalance_GrayWorld;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_WHITEBALANCE_GRAYWORLD, ProcBitmap, mask) then
    exit;
  IEWhiteBalance_grayworld(ProcBitmap,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.WhiteBalance_WhiteAt

<FM>Declaration<FC>
procedure WhiteBalance_WhiteAt(WhiteX, WhiteY:integer);

<FM>Description<FN>
Adjust image colors adjusting the white range. WhiteX and WhiteY are the coordinates of a white pixel.

<FM>Example<FC>

ImageEnView1.Proc.WhiteBalance_WhiteAt( 150,200 );

!!}
procedure TImageEnProc.WhiteBalance_WhiteAt(WhiteX, WhiteY:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_WHITEBALANCE_WHITEAT, [WhiteX, WhiteY]), ProcBitmap, mask) then
    exit;
  IEWhiteBalance_3(ProcBitmap,WhiteX,WhiteY,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.WhiteBalance_AutoWhite

<FM>Declaration<FC>
procedure WhiteBalance_AutoWhite;

<FM>Description<FN>
Adjusts image colors adjusting the white range. This method is like WhiteBalance_WhiteAt, but try to find the white automatically.

<FM>Example<FC>

ImageEnView1.Proc.WhiteBalance_AutoWhite;

!!}
procedure TImageEnProc.WhiteBalance_AutoWhite;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_WHITEBALANCE_AUTOWHITE, ProcBitmap, mask) then
    exit;
  IEWhiteBalance_2(ProcBitmap,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.AdjustGainOffset

<FM>Declaration<FC>
procedure AdjustGainOffset;

<FM>Description<FN>
Adjust image luminosity calculating the min and max pixels values and stretching colors to the maximum allowed value.

<FM>Example<FC>
ImageEnView1.Proc.AdjustGainOffset;

!!}
procedure TImageEnProc.AdjustGainOffset;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB,ie48RGB], x1, y1, x2, y2, IERS_ADJUSTGAINOFFSET, ProcBitmap, mask) then
    exit;
  IEAdjustGainOffset(ProcBitmap,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure IECastColor(Bitmap:TIEBitmap; x,y:integer; newColor:TRGB; tolerance:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  pixmap:TIEMask;
  row,col:integer;
  px:pbyte;
  p_rgb:PRGB;
  per1:double;
begin
  pixmap:=TIEMask.Create;
  pixmap.AllocateBits(Bitmap.Width, Bitmap.Height, 8);
  _MakeMagicWandPointsEx(Bitmap, x, y, false, tolerance, pixmap, 255);
  //if (pixmap.Y2 <> pixmap.Y1) and (pixmap.X1 <> pixmap.X2) then
  if not pixmap.IsEmpty then  // 2.3.1
  begin
    per1 := 100 / (pixmap.y2-pixmap.y1+1);
    for row:=pixmap.y1 to pixmap.y2 do
    begin
      px:=pixmap.Scanline[row];     inc(px,pixmap.x1);
      p_rgb:=Bitmap.Scanline[row];  inc(p_rgb,pixmap.x1);
      for col:=pixmap.x1 to pixmap.x2 do
      begin
        if px^<>0 then
          p_rgb^ := newColor;
        inc(px);
        inc(p_rgb);
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * row));
    end;
  end;
  FreeAndNil(pixmap);
end;

{!!
<FS>TImageEnProc.CastColor

<FM>Declaration<FC>
procedure CastColor(x, y:integer; newColor:TRGB; tolerance:integer);

<FM>Description<FN>
Performs a flood-fill starting at <FC>x, y<FN> coordinates. <FC>newColor<FN> is the color used to paint.
<FC>tolerance<FN> specifies the maximum difference from the starting pixel (0=no tolerance, pixels must be equals).

<FM>Example<FC>

// assuming X,Y = mouse coordinates, paints points to red
ImageEnView1.Proc.CastColor(ImageEnView1.XScr2Bmp(X), ImageEnView1.Yscr2Bmp(Y), CreateRGB(255,0,0), 0);
!!}
procedure TImageEnProc.CastColor(x, y:integer; newColor:TRGB; tolerance:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_CASTCOLOR, ProcBitmap, mask) then
    exit;
  IECastColor(ProcBitmap,x,y,newColor,tolerance,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure IECastAlpha(Bitmap:TIEBitmap; x,y:integer; newAlpha:integer; tolerance:integer; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  pixmap:TIEMask;
  row,col:integer;
  px:pbyte;
  pb:pbyte;
  per1:double;
begin
  pixmap:=TIEMask.Create;
  pixmap.AllocateBits(Bitmap.Width,Bitmap.Height,8);
  _MakeMagicWandPointsEx(Bitmap,x,y,false,tolerance,pixmap,255);
  //if (pixmap.Y2 <> pixmap.Y1) and (pixmap.X1 <> pixmap.X2) then
  if not pixmap.IsEmpty then  // 2.3.1
  begin
    per1 := 100 / (pixmap.y2-pixmap.y1);
    for row:=pixmap.y1 to pixmap.y2 do
    begin
      px:=pixmap.Scanline[row];     inc(px,pixmap.x1);
      pb:=Bitmap.AlphaChannel.Scanline[row];  inc(pb,pixmap.x1);
      for col:=pixmap.x1 to pixmap.x2 do
      begin
        if px^<>0 then
          pb^ := newAlpha;
        inc(px);
        inc(pb);
      end;
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * row));
    end;
  end;
  FreeAndNil(pixmap);
  Bitmap.AlphaChannel.SyncFull;
end;

{!!
<FS>TImageEnProc.CastAlpha

<FM>Declaration<FC>
procedure CastAlpha(x, y:integer; newAlpha:integer; tolerance:integer);

<FM>Description<FN>
Performs a flood-fill starting at x,y coordinates. newAlpha is the transparent value used to fill the area.
tolerance specifies the maximum difference from the starting pixel (0=no tolerance, pixels must be equals).

<FM>Example<FC>

// assuming X,Y = mouse coordinates, makes the area transparent
ImageEnView1.Proc.CastAlpha( ImageEnView1.XScr2Bmp(X), ImageEnView1.Yscr2Bmp(Y), 0,0);

!!}
procedure TImageEnProc.CastAlpha(x, y:integer; newAlpha:integer; tolerance:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_CASTALPHA, [x, y, newAlpha, tolerance]), ProcBitmap, mask) then
    exit;
  IECastAlpha(ProcBitmap,x,y,newAlpha,tolerance,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// supports: ie24RGB; ie8p
procedure IEColorize(bitmap:TIEBitmap; hue:integer; saturation:integer; luminosity:double; fOnProgress: TIEProgressEvent; Sender: TObject);
var
  i, row, col:integer;
  px:PRGB;
  rgb:TRGB;
  v:integer;
  per1:double;
begin
  case bitmap.PixelFormat of
    ie24RGB:
      begin
        per1 := 100 / (bitmap.Height);
        for row:=0 to bitmap.Height-1 do
        begin
          px:=bitmap.Scanline[row];
          for col:=0 to bitmap.Width-1 do
          begin
            with px^ do
              v:=trunc( (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) shr 8 * luminosity );
            HSV2RGB(px^, hue, saturation, v);
            inc(px);
          end;
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * row));
        end;
      end;
    ie8p:
      begin
        for i := 0 to 255 do
        begin
          with bitmap.Palette[i] do
            v:=trunc( (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) shr 8 * luminosity );
          HSV2RGB(rgb, hue, saturation, v);
          bitmap.Palette[i] := rgb;
        end;
      end;
  end;
end;

{!!
<FS>TImageEnProc.Colorize

<FM>Declaration<FC>
procedure Colorize(hue:integer; saturation:integer; luminosity:double);

<FM>Description<FN>
Colorize sets hue and saturation for all pixels of the image. It also changes the luminosity using this paramter as a multiplicator to increase or decrease the luminosity.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>hue<FN></C> <C>Assumes values between 0 and 359 (corresponding to 0..359 degrees around hexcone).</C> </R>
<R> <C><FC>saturation<FN></C> <C>Assumes values between 0 (shade of gray) to 99 (pure color).</C> </R>
<R> <C><FC>luminosity<FN></C> <C>This is 1 when you don't touch the original luminosity.</C> </R>
</TABLE>

This function could be used to obtain a sepia effect, using following parameters:
<FC>ImageEnView.Proc.Colorize(40, 50, 1.1);<FN>
!!}
procedure TImageEnProc.Colorize(hue:integer; saturation:integer; luminosity:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB, ie8p], x1, y1, x2, y2, Format(IERS_COLORIZE, [hue, saturation, luminosity]), ProcBitmap, mask) then
    exit;
  IEColorize(ProcBitmap, hue, saturation, luminosity, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

function IEPatternCompare(x,y:integer; InputBitmap:TIEBitmap; pattern:TIEBitmap; precision:double):double;
var
  yi:integer;     // input coordinates
  xp,yp:integer;  // pattern coordinates
  pi,pp:pbyte;
  mx:integer;
begin
  result:=0;
  yp:=0;
  yi:=y;
  mx:=1;
  precision:=1-precision;
  while yp<pattern.Height do
  begin
    xp:=0;
    pi:=InputBitmap.Scanline[yi]; inc(pi,x);
    pp:=pattern.Scanline[yp];
    while xp<pattern.Width do
    begin
      result:=result + abs( pi^ - pp^ )/255;
      if result/mx > precision then
      begin
        result:=pattern.Width*pattern.Height;
        yp:=pattern.Height;
        break;
      end;
      inc(xp);
      inc(pi);
      inc(pp);
      inc(mx);
    end;
    inc(yi);
    inc(yp);
  end;
  result :=  1-(result / (pattern.Width * pattern.Height));
end;

type
TPatt=record
  score:double;
  x:integer;
  y:integer;
  s:integer;  // scale (1..)
end;
PPatt=^TPatt;

// Founds is a list of PPatt pointers to TPatt structures
// pattern must be at scale 1
// InputBitmap and pattern MUST BE ie8g
// precision: >0 and <=1   (if =-1 it is autocalculated)
// scaleSteps: 0=no multiscale, >1 divide for scaleSteps scales
procedure IEPatternSearch8g(InputBitmap:TIEBitmap; pattern:TIEBitmap; Founds:TList; precision:double; scaleSteps:integer);
var
  scalecount:integer;
  s,x,y:integer;
  eq:double;
  scaledpattern:TIEBitmap;
  found:PPatt;
  maxp:double;
begin
  scalecount:= imin( InputBitmap.Width-pattern.Width , InputBitmap.Height-pattern.Height );

  scaledpattern:=TIEBitmap.Create;

  try

  maxp:=-1;
  found:=nil;
  s:=0;
  while s<scalecount do
  begin

    // scale input pattern
    scaledpattern.Allocate( pattern.Width+s, pattern.Height+s, pattern.PixelFormat );
    _IEResampleIEBitmap(pattern, scaledpattern, rfNone,nil,nil );

    for x:=0 to InputBitmap.Width-scaledpattern.Width-1 do
    begin
      for y:=0 to InputBitmap.Height-scaledpattern.Height-1 do
      begin

        eq:=IEPatternCompare(x,y,InputBitmap,scaledpattern,dmax(precision,maxp));
        if precision=-1 then
        begin
          if eq>maxp then
          begin
            if found=nil then
            begin
              new(found);
              founds.Add(found);
            end;
            found^.score:=eq;
            found^.x:=x;
            found^.y:=y;
            found^.s:=s;
            maxp:=eq;
          end;
        end
        else if eq>=precision then
        begin
          new(found);
          found^.score:=eq;
          found^.x:=x;
          found^.y:=y;
          found^.s:=s;
          founds.Add( found );
        end;

      end;
    end;

    if scaleSteps=0 then
      break
    else
      inc(s,scalecount div scaleSteps);

  end;

  finally
    FreeAndNil(scaledpattern);
  end;
end;

function IEPatternSortCompare(Item1, Item2: Pointer): Integer;
var
  i1,i2:PPatt;
begin
  i1:=PPatt(Item1);
  i2:=PPatt(Item2);
  if i1^.score < i2^.score then
    result:=1
  else if i1^.score = i2^.score then
    result:=0
  else
    result:=-1;
end;

procedure IEPatternSearch(InputBitmap:TIEBitmap; pattern:TIEBitmap; var FoundRect:TRect; precision:double; scaleSteps:integer);
var
  ibitmap:TIEBitmap;
  xpattern:TIEBitmap;
  founds:TList;
  i:integer;
begin
  if InputBitmap.PixelFormat<>ie8g then
  begin
    ibitmap:=TIEBitmap.Create;
    ibitmap.AssignImage( InputBitmap );
    ibitmap.PixelFormat:=ie8g;
  end
  else
    ibitmap:=InputBitmap;
  if pattern.PixelFormat<>ie8g then
  begin
    xpattern:=TIEBitmap.Create;
    xpattern.AssignImage( pattern );
    xpattern.PixelFormat:=ie8g;
  end
  else
    xpattern:=pattern;

  founds:=TList.Create;
  IEPatternSearch8g(ibitmap,xpattern,founds,precision,scaleSteps);

  // sort founds array
  founds.Sort( IEPatternSortCompare );

  FoundRect.Left:=PPatt(founds[0])^.x;
  FoundRect.Top:=PPatt(founds[0])^.y;
  FoundRect.Right:=FoundRect.Left + xpattern.Width+PPatt(founds[0])^.s;
  FoundRect.Bottom:=FoundRect.Top + xpattern.Height+PPatt(founds[0])^.s;

  for i:=0 to founds.Count-1 do
  begin
    with inputbitmap.Canvas do
    begin
      pen.color:=clred;
      brush.Style:=bsClear;

      FoundRect.Left:=PPatt(founds[i])^.x;
      FoundRect.Top:=PPatt(founds[i])^.y;
      FoundRect.Right:=FoundRect.Left + xpattern.Width+PPatt(founds[i])^.s;
      FoundRect.Bottom:=FoundRect.Top + xpattern.Height+PPatt(founds[i])^.s;

      with FoundRect do
        rectangle(left,top,right,bottom);
    end;
  end;

  for i:=0 to founds.Count-1 do
    dispose( founds[i] );
  FreeAndNil(founds);

  if ibitmap<>InputBitmap then
    FreeAndNil(ibitmap);
  if xpattern<>pattern then
    FreeAndNil(xpattern);
end;

{!!
<FS>TImageEnProc.MakeTile

<FM>Declaration<FC>
procedure MakeTile(columns, rows:integer);

<FM>Description<FN>
MakeTile replicates current image for the specified columns and rows numbers. The final image will be resized by columns*ImageWidth and rows*ImageHeight.
This is useful to create tiled images.

<FM>Example<FC>

// replicates image.jpg 6x6 times
ImageEnView1.IO.LoadFromFile('image.jpg');
ImageEnView1.Proc.MakeTile(6,6);
ImageEnView1.IO.SaveToFile('tiled.jpg');

!!}
procedure TImageEnProc.MakeTile(columns, rows:integer);
var
  oldWidth,oldHeight:integer;
  x,y:integer;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(Format(IERS_MAKETILE, [columns, rows]), ieuImage);
  oldWidth:=fIEBitmap.Width;
  oldHeight:=fIEBitmap.Height;
  fIEBitmap.Resize(columns*oldWidth,rows*oldHeight,0,255,iehLeft,ievTop);
  for x:=0 to columns-1 do
    for y:=0 to rows-1 do
    begin
      fIEBitmap.CopyRectTo(fIEBitmap,0,0,x*oldWidth,y*oldHeight,oldWidth,oldHeight);
      if fIEBitmap.HasAlphaChannel then
        fIEBitmap.AlphaChannel.CopyRectTo(fIEBitmap.AlphaChannel,0,0,x*oldWidth,y*oldHeight,oldWidth,oldHeight);
    end;
  Update;
  DoFinishWork;
end;

{$ifdef IEINCLUDEDIALOGIP}
constructor TIPDialogParams.Create;
begin
  inherited;
  FFT_Selection:=TMemoryStream.Create;
  SetDefaultParams;
end;

destructor TIPDialogParams.Destroy;
begin
  FFT_Selection.Free;
  inherited;
end;

{!!
<FS>TIPDialogParams.SetDefaultParams

<FM>Declaration<FC>
procedure SetDefaultParams;

<FM>Description<FN>
Loads default parameters for image processing dialog. You could call this method to reset parameters before display the dialog.
!!}
procedure TIPDialogParams.SetDefaultParams;
var
  x,y:integer;
begin
  CONTRAST_Contrast:=0;
  CONTRAST_Brightness:=0;
  HSV_H:=0;
  HSV_S:=0;
  HSV_V:=0;
  HSL_H:=0;
  HSL_S:=0;
  HSL_L:=0;
  RGB_R:=0;
  RGB_G:=0;
  RGB_B:=0;
  for x := 0 to 2 do
    for y := 0 to 2 do
      USERFILTER_Values.Values[x, y] := 0;
  USERFILTER_Values.Values[1, 1] := 1;
  USERFILTER_Values.Divisor := 0;
  EQUALIZATION_ThresholdDown:=CreateRGB(0,0,0);
  EQUALIZATION_ThresholdUp:=CreateRGB(255,255,255);
  EQUALIZATION_EqDown:=CreateRGB(0,0,0);
  EQUALIZATION_EqUp:=CreateRGB(255,255,255);
  EQUALIZATION_EqualizeButton:=false;
  BUMPMAP_Left:=0;
  BUMPMAP_Top:=0;
  BUMPMAP_Width:=150;
  BUMPMAP_Height:=150;
  BUMPMAP_Col:=CreateRGB(255, 255, 255);
  BUMPMAP_Src:=0;
  BUMPMAP_Auto:=true;
  LENS_Left:=0;
  LENS_Top:=0;
  LENS_Width:=150;
  LENS_Height:=150;
  LENS_Ref:=1.7;
  LENS_Auto:=true;
  WAVE_Amplitude:=10;
  WAVE_WaveLength:=10;
  WAVE_Phase:=0;
  WAVE_Reflect:=false;
  MORPH_Filter:=0;
  MORPH_WinSize:=1;
  ROTATE_Angle:=0;
  GAMMACORRECTION_Value:=1;
  SHARPEN_Sharpen:=1;
  SHARPEN_Size:=4;
  FFT_Left:=-1;
  FFT_Top:=-1;
  FFT_Right:=-1;
  FFT_Bottom:=-1;
  FFT_GrayScale:=true;
  FFT_Selection.Clear;
end;

procedure TIPDialogParams.SetFFT_Left(v:integer);
begin
  fFFT_Left:=v;
  FFT_Selection.Clear;
end;

procedure TIPDialogParams.SetFFT_Top(v:integer);
begin
  fFFT_Top:=v;
  FFT_Selection.Clear;
end;

procedure TIPDialogParams.SetFFT_Right(v:integer);
begin
  fFFT_Right:=v;
  FFT_Selection.Clear;
end;

procedure TIPDialogParams.SetFFT_Bottom(v:integer);
begin
  fFFT_Bottom:=v;
  FFT_Selection.Clear;
end;

{!!
<FS>TIPDialogParams.SaveToFile

<FM>Declaration<FC>
procedure SaveToFile(const FileName:string);

<FM>Description<FN>
Save all parameters to file.
!!}
procedure TIPDialogParams.SaveToFile(const FileName:string);
var
  fs: TFileStream;
begin
  fs:=TFileStream.Create(FileName, fmCreate);
  SaveToStream(fs);
  FreeAndNil(fs);
end;

{!!
<FS>TIPDialogParams.LoadFromFile

<FM>Declaration<FC>
procedure LoadFromFile(const FileName:string);

<FM>Description<FN>
Load all parameters from file.
!!}
procedure TIPDialogParams.LoadFromFile(const FileName:string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TIPDialogParams.SaveToStream

<FM>Declaration<FC>
procedure SaveToStream(Stream:TStream);

<FM>Description<FN>
Save all parameters to stream.
!!}
// 2.3.2
procedure TIPDialogParams.SaveToStream(Stream:TStream);
var
  sz:integer;
  ver:integer;
begin
  ver:=10000;
  Stream.Write(ver, sizeof(integer));
  Stream.Write(CONTRAST_Contrast,sizeof(integer));
  Stream.Write(CONTRAST_Brightness,sizeof(integer));
  Stream.Write(HSV_H,sizeof(integer));
  Stream.Write(HSV_S,sizeof(integer));
  Stream.Write(HSV_V,sizeof(integer));
  Stream.Write(HSL_H,sizeof(integer));
  Stream.Write(HSL_S,sizeof(integer));
  Stream.Write(HSL_L,sizeof(integer));
  Stream.Write(RGB_R,sizeof(integer));
  Stream.Write(RGB_G,sizeof(integer));
  Stream.Write(RGB_B,sizeof(integer));
  Stream.Write(USERFILTER_Values,sizeof(TGraphFilter));
  Stream.Write(EQUALIZATION_ThresholdDown,sizeof(TRGB));
  Stream.Write(EQUALIZATION_ThresholdUp,sizeof(TRGB));
  Stream.Write(EQUALIZATION_EqDown,sizeof(TRGB));
  Stream.Write(EQUALIZATION_EqUp,sizeof(TRGB));
  Stream.Write(EQUALIZATION_EqualizeButton,sizeof(boolean));
  Stream.Write(BUMPMAP_Left,sizeof(integer));
  Stream.Write(BUMPMAP_Top,sizeof(integer));
  Stream.Write(BUMPMAP_Width,sizeof(integer));
  Stream.Write(BUMPMAP_Height,sizeof(integer));
  Stream.Write(BUMPMAP_Col,sizeof(TRGB));
  Stream.Write(BUMPMAP_Src,sizeof(integer));
  Stream.Write(BUMPMAP_Auto,sizeof(boolean));
  Stream.Write(LENS_Left,sizeof(integer));
  Stream.Write(LENS_Top,sizeof(integer));
  Stream.Write(LENS_Width,sizeof(integer));
  Stream.Write(LENS_Height,sizeof(integer));
  Stream.Write(LENS_Ref,sizeof( double));
  Stream.Write(LENS_Auto,sizeof(boolean));
  Stream.Write(WAVE_Amplitude,sizeof( integer));
  Stream.Write(WAVE_WaveLength,sizeof( integer));
  Stream.Write(WAVE_Phase,sizeof( integer));
  Stream.Write(WAVE_Reflect,sizeof( boolean));
  Stream.Write(MORPH_Filter,sizeof( integer));
  Stream.Write(MORPH_WinSize,sizeof( integer));
  Stream.Write(ROTATE_Angle,sizeof( double));
  Stream.Write(GAMMACORRECTION_Value,sizeof(double));
  Stream.Write(SHARPEN_Sharpen,sizeof( integer));
  Stream.Write(SHARPEN_Size,sizeof( integer));
  Stream.Write(fFFT_Left,sizeof(integer));
  Stream.Write(fFFT_Top,sizeof(integer));
  Stream.Write(fFFT_Right,sizeof(integer));
  Stream.Write(fFFT_Bottom,sizeof(integer));
  Stream.Write(FFT_GrayScale,sizeof(boolean));
  sz:=FFT_Selection.Size;
  Stream.Write(sz,sizeof(integer));
  IECopyFrom(Stream, FFT_Selection,0);
end;

{!!
<FS>TIPDialogParams.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream:TStream);

<FM>Description<FN>
Load all parameters from stream.
!!}
// 2.3.2
procedure TIPDialogParams.LoadFromStream(Stream:TStream);
var
  sz:integer;
  ver:integer;
begin
  Stream.Read(ver, sizeof(integer));
  if ver<10000 then
    Stream.Position := 0; // Old versions do not write version
  Stream.Read(CONTRAST_Contrast,sizeof(integer));
  Stream.Read(CONTRAST_Brightness,sizeof(integer));
  Stream.Read(HSV_H,sizeof(integer));
  Stream.Read(HSV_S,sizeof(integer));
  Stream.Read(HSV_V,sizeof(integer));
  Stream.Read(HSL_H,sizeof(integer));
  Stream.Read(HSL_S,sizeof(integer));
  Stream.Read(HSL_L,sizeof(integer));
  Stream.Read(RGB_R,sizeof(integer));
  Stream.Read(RGB_G,sizeof(integer));
  Stream.Read(RGB_B,sizeof(integer));
  Stream.Read(USERFILTER_Values,sizeof(TGraphFilter));
  Stream.Read(EQUALIZATION_ThresholdDown,sizeof(TRGB));
  Stream.Read(EQUALIZATION_ThresholdUp,sizeof(TRGB));
  Stream.Read(EQUALIZATION_EqDown,sizeof(TRGB));
  Stream.Read(EQUALIZATION_EqUp,sizeof(TRGB));
  if ver>=10000 then
    Stream.Read(EQUALIZATION_EqualizeButton,sizeof(boolean));
  Stream.Read(BUMPMAP_Left,sizeof(integer));
  Stream.Read(BUMPMAP_Top,sizeof(integer));
  Stream.Read(BUMPMAP_Width,sizeof(integer));
  Stream.Read(BUMPMAP_Height,sizeof(integer));
  Stream.Read(BUMPMAP_Col,sizeof(TRGB));
  Stream.Read(BUMPMAP_Src,sizeof(integer));
  Stream.Read(BUMPMAP_Auto,sizeof(boolean));
  Stream.Read(LENS_Left,sizeof(integer));
  Stream.Read(LENS_Top,sizeof(integer));
  Stream.Read(LENS_Width,sizeof(integer));
  Stream.Read(LENS_Height,sizeof(integer));
  Stream.Read(LENS_Ref,sizeof( double));
  Stream.Read(LENS_Auto,sizeof(boolean));
  Stream.Read(WAVE_Amplitude,sizeof( integer));
  Stream.Read(WAVE_WaveLength,sizeof( integer));
  Stream.Read(WAVE_Phase,sizeof( integer));
  Stream.Read(WAVE_Reflect,sizeof( boolean));
  Stream.Read(MORPH_Filter,sizeof( integer));
  Stream.Read(MORPH_WinSize,sizeof( integer));
  Stream.Read(ROTATE_Angle,sizeof( double));
  Stream.Read(GAMMACORRECTION_Value,sizeof(double));
  Stream.Read(SHARPEN_Sharpen,sizeof( integer));
  Stream.Read(SHARPEN_Size,sizeof( integer));
  Stream.Read(fFFT_Left,sizeof(integer));
  Stream.Read(fFFT_Top,sizeof(integer));
  Stream.Read(fFFT_Right,sizeof(integer));
  Stream.Read(fFFT_Bottom,sizeof(integer));
  Stream.Read(FFT_GrayScale,sizeof(boolean));
  FFT_Selection.Clear;
  if Stream.Position<Stream.Size+4 then
  begin
    Stream.Read(sz,sizeof(integer));
    if sz > 0 then
      IECopyFrom(FFT_Selection, Stream, sz);
  end;
end;

{!!
<FS>TIPDialogParams.GetProperty

<FM>Declaration<FC>
function GetProperty(const Prop:string):string;

<FM>Description<FN>
Gets a proprierty as string.
!!}
function TIPDialogParams.GetProperty(const Prop:string):string;
var
	ss:string;
  q,w:integer;
begin
	ss:=UpperCase(IERemoveCtrlCharsS(Prop));
  if ss='CONTRAST_CONTRAST' then
    result:=IntToStr(CONTRAST_Contrast)
  else if ss='CONTRAST_BRIGHTNESS' then
    result:=IntToStr(CONTRAST_Brightness)
  else if ss='HSV_H' then
    result:=IntToStr(HSV_H)
  else if ss='HSV_S' then
    result:=IntToStr(HSV_S)
  else if ss='HSV_V' then
    result:=IntToStr(HSV_V)
  else if ss='HSL_H' then
    result:=IntToStr(HSL_H)
  else if ss='HSL_S' then
    result:=IntToStr(HSL_S)
  else if ss='HSL_L' then
    result:=IntToStr(HSL_L)
  else if ss='RGB_R' then
    result:=IntToStr(RGB_R)
  else if ss='RGB_G' then
    result:=IntToStr(RGB_G)
  else if ss='RGB_B' then
    result:=IntToStr(RGB_B)
  else if Copy(ss,1,17)='USERFILTER_VALUES' then   // example USERFILTER_VALUES02  (x=0 y=2)
  begin
		q:=StrToIntDef(Copy(ss,18,1),0);
    w:=StrToIntDef(Copy(ss,19,1),0);
    result:=IntToStr(USERFILTER_Values.Values[q,w]);
  end
  else if ss='USERFILTER_DIVISOR' then
    result:=IntToStr(USERFILTER_Values.Divisor)
  else if ss='EQUALIZATION_THRESHOLDDOWN' then
    result:=IERGB2StrS(EQUALIZATION_ThresholdDown)
  else if ss='EQUALIZATION_THRESHOLDUP' then
    result:=IERGB2StrS(EQUALIZATION_ThresholdUp)
  else if ss='EQUALIZATION_EQDOWN' then
    result:=IERGB2StrS(EQUALIZATION_EqDown)
  else if ss='EQUALIZATION_EQUP' then
    result:=IERGB2StrS(EQUALIZATION_EqUp)
  else if ss='EQUALIZATION_EQUALIZEBUTTON' then
    result:=IEBool2StrS(EQUALIZATION_EqualizeButton)
  else if ss='BUMPMAP_LEFT' then
    result:=IntToStr(BUMPMAP_Left)
  else if ss='BUMPMAP_TOP' then
    result:=IntToStr(BUMPMAP_Top)
  else if ss='BUMPMAP_WIDTH' then
    result:=IntToStr(BUMPMAP_Width)
  else if ss='BUMPMAP_HEIGHT' then
    result:=IntToStr(BUMPMAP_Height)
  else if ss='BUMPMAP_COL' then
    result:=IERGB2StrS(BUMPMAP_Col)
  else if ss='BUMPMAP_SRC' then
    result:=IntToStr(BUMPMAP_Src)
  else if ss='BUMPMAP_AUTO' then
    result:=IEBool2StrS(BUMPMAP_Auto)
  else if ss='LENS_LEFT' then
    result:=IntToStr(LENS_Left)
  else if ss='LENS_TOP' then
    result:=IntToStr(LENS_Top)
  else if ss='LENS_WIDTH' then
    result:=IntToStr(LENS_Width)
  else if ss='LENS_HEIGHT' then
    result:=IntToStr(LENS_Height)
  else if ss='LENS_REF' then
    result:=IEFloatToStrS(LENS_Ref)
  else if ss='LENS_AUTO' then
    result:=IEBool2StrS(LENS_Auto)
  else if ss='WAVE_AMPLITUDE' then
    result:=IntToStr(WAVE_Amplitude)
  else if ss='WAVE_WAVELENGTH' then
    result:=IntToStr(WAVE_WaveLength)
  else if ss='WAVE_PHASE' then
    result:=IntToStr(WAVE_Phase)
  else if ss='WAVE_REFLECT' then
    result:=IEBool2StrS(WAVE_Reflect)
  else if ss='MORPH_FILTER' then
    result:=IntToStr(MORPH_Filter)
  else if ss='MORPH_WINSIZE' then
    result:=IntToStr(MORPH_WinSize)
  else if ss='ROTATE_ANGLE' then
    result:=IEFloatToStrS(ROTATE_Angle)
  else if ss='GAMMACORRECTION_VALUE' then
    result:=IEFloatToStrS(GAMMACORRECTION_Value)
  else if ss='SHARPEN_SHARPEN' then
    result:=IntToStr(SHARPEN_Sharpen)
  else if ss='SHARPEN_SIZE' then
    result:=IntToStr(SHARPEN_Size)
  else if ss='FFT_LEFT' then
    result:=IntToStr(FFT_Left)
  else if ss='FFT_TOP' then
    result:=IntToStr(FFT_Top)
  else if ss='FFT_RIGHT' then
    result:=IntToStr(FFT_Right)
  else if ss='FFT_BOTTOM' then
    result:=IntToStr(FFT_Bottom)
  else if ss='FFT_GRAYSCALE' then
    result:=IEBool2StrS(FFT_GrayScale)
  else
   	result:='INVALID PROPERTY';
end;

{!!
<FS>TIPDialogParams.SetProperty

<FM>Declaration<FC>
procedure SetProperty(Prop,Value:string);

<FM>Description<FN>
Set a proprierty as string. Example:
<FC>SetProperty('ROTATE_Angle','45');<FN>
is the same of
<FC>Rotate_Angle:=45;<FN>
!!}
procedure TIPDialogParams.SetProperty(Prop, Value:string);
var
	ss:string;
  q,w:integer;
begin
	ss:=UpperCase(IERemoveCtrlCharsS(Prop));
  Value:=IERemoveCtrlCharsS(Value);
  if ss='CONTRAST_CONTRAST' then
    CONTRAST_Contrast:=StrToIntDef(value,0)
  else if ss='CONTRAST_BRIGHTNESS' then
    CONTRAST_Brightness:=StrToIntDef(value,0)
  else if ss='HSV_H' then
    HSV_H:=StrToIntDef(value,0)
  else if ss='HSV_S' then
    HSV_S:=StrToIntDef(value,0)
  else if ss='HSV_V' then
    HSV_V:=StrToIntDef(value,0)
  else if ss='HSL_H' then
    HSL_H:=StrToIntDef(value,0)
  else if ss='HSL_S' then
    HSL_S:=StrToIntDef(value,0)
  else if ss='HSL_L' then
    HSL_L:=StrToIntDef(value,0)
  else if ss='RGB_R' then
    RGB_R:=StrToIntDef(value,0)
  else if ss='RGB_G' then
    RGB_G:=StrToIntDef(value,0)
  else if ss='RGB_B' then
    RGB_B:=StrToIntDef(value,0)
  else if ss='USERFILTER_VALUES' then   // example USERFILTER_VALUES02  (x=0 y=2)
  begin
		q:=StrToIntDef(Copy(ss,18,1),0);
    w:=StrToIntDef(Copy(ss,19,1),0);
    USERFILTER_Values.Values[q,w]:=StrToIntDef(value,0)
  end
  else if ss='USERFILTER_DIVISOR' then
    USERFILTER_Values.Divisor:=StrToIntDef(value,0)
  else if ss='EQUALIZATION_THRESHOLDDOWN' then
    EQUALIZATION_ThresholdDown:=IEStr2RGBS(value)
  else if ss='EQUALIZATION_THRESHOLDUP' then
    EQUALIZATION_ThresholdUp:=IEStr2RGBS(value)
  else if ss='EQUALIZATION_EQDOWN' then
    EQUALIZATION_EqDown:=IEStr2RGBS(value)
  else if ss='EQUALIZATION_EQUP' then
    EQUALIZATION_EqUp:=IEStr2RGBS(value)
  else if ss='EQUALIZATION_EQUALIZEBUTTON' then
    EQUALIZATION_EqualizeButton:=IEStr2BoolS(value)
  else if ss='BUMPMAP_LEFT' then
    BUMPMAP_Left:=StrToIntDef(value,0)
  else if ss='BUMPMAP_TOP' then
    BUMPMAP_Top:=StrToIntDef(value,0)
  else if ss='BUMPMAP_WIDTH' then
    BUMPMAP_Width:=StrToIntDef(value,0)
  else if ss='BUMPMAP_HEIGHT' then
    BUMPMAP_Height:=StrToIntDef(value,0)
  else if ss='BUMPMAP_COL' then
    BUMPMAP_Col:=IEStr2RGBS(value)
  else if ss='BUMPMAP_SRC' then
    BUMPMAP_Src:=StrToIntDef(value,0)
  else if ss='BUMPMAP_AUTO' then
    BUMPMAP_Auto:=IEStr2BoolS(value)
  else if ss='LENS_LEFT' then
    LENS_Left:=StrToIntDef(value,0)
  else if ss='LENS_TOP' then
    LENS_Top:=StrToIntDef(value,0)
  else if ss='LENS_WIDTH' then
    LENS_Width:=StrToIntDef(value,0)
  else if ss='LENS_HEIGHT' then
    LENS_Height:=StrToIntDef(value,0)
  else if ss='LENS_REF' then
    LENS_Ref:=IEStrToFloatDefS(value,1.7)
  else if ss='LENS_AUTO' then
    LENS_Auto:=IEStr2BoolS(value)
  else if ss='WAVE_AMPLITUDE' then
    WAVE_Amplitude:=StrToIntDef(value,0)
  else if ss='WAVE_WAVELENGTH' then
    WAVE_WaveLength:=StrToIntDef(value,0)
  else if ss='WAVE_PHASE' then
    WAVE_Phase:=StrToIntDef(value,0)
  else if ss='WAVE_REFLECT' then
    WAVE_Reflect:=IEStr2BoolS(value)
  else if ss='MORPH_FILTER' then
    MORPH_Filter:=StrToIntDef(value,0)
  else if ss='MORPH_WINSIZE' then
    MORPH_WinSize:=StrToIntDef(value,0)
  else if ss='ROTATE_ANGLE' then
    ROTATE_Angle:=IEStrToFloatDefS(value,0)
  else if ss='GAMMACORRECTION_VALUE' then
    GAMMACORRECTION_Value:=IEStrToFloatDefS(value,0)
  else if ss='SHARPEN_SHARPEN' then
    SHARPEN_Sharpen:=StrToIntDef(value,0)
  else if ss='SHARPEN_SIZE' then
    SHARPEN_Size:=StrToIntDef(value,0)
  else if ss='FFT_LEFT' then
    FFT_Left:=StrToIntDef(value,0)
  else if ss='FFT_TOP' then
    FFT_Top:=StrToIntDef(value,0)
  else if ss='FFT_RIGHT' then
    FFT_Right:=StrToIntDef(value,0)
  else if ss='FFT_BOTTOM' then
    FFT_Bottom:=StrToIntDef(value,0)
  else if ss='FFT_GRAYSCALE' then
    FFT_GrayScale:=IEStr2BoolS(value);
end;

{$endif}

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
// Automatic Color Equalization with linear local LUT

// apply a local LUT
// SubOriginal : the original image (Bitmap) subsampled
// SubFiltered : the filtered image, got filtering SubOriginal
// Bitmap      : the original image and the output
procedure IELLLUT( SubOriginal, SubFiltered:TIEBitmap; Bitmap:TIEBitmap; Neightbour:integer; OnProgress: TIEProgressEvent; Sender: TObject; ProgressOffset:integer; ProgressMultiplier:double);
var
  xx,yy:integer;
  x,y:integer;
  xk,yk:integer;
  d:double;
  psf,pso:PRGB;
  R_Dleft,R_Dright:integer;
  R_kleft,R_kright:integer;
  R_kfleft,R_kfright:integer;
  G_Dleft,G_Dright:integer;
  G_kleft,G_kright:integer;
  G_kfleft,G_kfright:integer;
  B_Dleft,B_Dright:integer;
  B_kleft,B_kright:integer;
  B_kfleft,B_kfright:integer;
  BitmapWidth,BitmapHeight:integer;
  SubOriginalWidth,SubOriginalHeight:integer;
  pb:PRGB;
  s:integer;
  x1,y1,x2,y2:integer;
  hh,ss,ll:double;
  lper,per:integer;
begin
  lper:=-1;
  BitmapWidth:=Bitmap.Width;
  BitmapHeight:=Bitmap.Height;
  SubOriginalWidth:=SubOriginal.Width;
  SubOriginalHeight:=SubOriginal.Height;
  d:=BitmapWidth / SubOriginal.Width;  // calculates decimation (divisor)
  R_kleft:=0;
  R_kfleft:=0;
  G_kleft:=0;
  G_kfleft:=0;
  B_kleft:=0;
  B_kfleft:=0;
  R_kright:=0;
  R_kfright:=0;
  G_kright:=0;
  G_kfright:=0;
  B_kright:=0;
  B_kfright:=0;
  for y:=0 to BitmapHeight-1 do
  begin
    pb:=Bitmap.Scanline[y];
    yk:=trunc( y / d );
    y1:=imax(0,yk-1);
    y2:=imin(SubOriginalHeight-1,yk+1);
    for x:=0 to BitmapWidth-1 do
    begin

      R_Dright:=100000;
      R_Dleft :=100000;
      G_Dright:=100000;
      G_Dleft :=100000;
      B_Dright:=100000;
      B_Dleft :=100000;

      xk:=trunc(x / d);

      x1:=imax(0,xk-Neightbour);
      x2:=imin(SubOriginalWidth-1,xk+Neightbour);

      for yy:=y1 to y2 do
      begin
        pso:=SubOriginal.Scanline[yy]; inc(pso,x1);
        psf:=SubFiltered.Scanline[yy]; inc(psf,x1);
        for xx:=x1 to x2 do
        begin
          // R
          s:=pb^.r-pso^.r;
          if (s<=0) and (-s<R_Dright) then
          begin
            R_Dright:=-s;
            R_kright:=pso^.r;
            R_kfright:=psf^.r;
          end;
          if (s>=0) and (s<R_Dleft) then
          begin
            R_Dleft:=s;
            R_kleft:=pso^.r;
            R_kfleft:=psf^.r;
          end;
          // G
          s:=pb^.g-pso^.g;
          if (s<=0) and (-s<G_Dright) then
          begin
            G_Dright:=-s;
            G_kright:=pso^.g;
            G_kfright:=psf^.g;
          end;
          if (s>=0) and (s<G_Dleft) then
          begin
            G_Dleft:=s;
            G_kleft:=pso^.g;
            G_kfleft:=psf^.g;
          end;
          // B
          s:=pb^.b-pso^.b;
          if (s<=0) and (-s<B_Dright) then
          begin
            B_Dright:=-s;
            B_kright:=pso^.b;
            B_kfright:=psf^.b;
          end;
          if (s>=0) and (s<B_Dleft) then
          begin
            B_Dleft:=s;
            B_kleft:=pso^.b;
            B_kfleft:=psf^.b;
          end;
          inc(pso);
          inc(psf);
        end;
      end;

      if R_Dleft=100000 then
      begin
        R_kleft:=0;
        R_kfleft:=0;
      end;
      if R_Dright=100000 then
      begin
        R_kright:=255;
        R_kfright:=255;
      end;
      if G_Dleft=100000 then
      begin
        G_kleft:=0;
        G_kfleft:=0;
      end;
      if G_Dright=100000 then
      begin
        G_kright:=255;
        G_kfright:=255;
      end;
      if B_Dleft=100000 then
      begin
        B_kleft:=0;
        B_kfleft:=0;
      end;
      if B_Dright=100000 then
      begin
        B_kright:=255;
        B_kfright:=255;
      end;

      with pb^ do
      begin
        r:= blimit( round( (r-R_kleft)*(R_kfright-R_kfleft)/imax(1,R_kright-R_kleft)+R_kfleft ) );
        g:= blimit( round( (g-G_kleft)*(G_kfright-G_kfleft)/imax(1,G_kright-G_kleft)+G_kfleft ) );
        b:= blimit( round( (b-B_kleft)*(B_kfright-B_kfleft)/imax(1,B_kright-B_kleft)+B_kfleft ) );
      end;

      inc(pb);

      if assigned(OnProgress) then
      begin
        per:=trunc(ProgressOffset+y/BitmapHeight*ProgressMultiplier);
        if per<>lper then
          OnProgress(Sender, per );
        lper:=per;
      end;

    end;
  end;
end;

// slope is in degree and can be from 0 to 90
// cut varies from 0 to 100 for all values of slope
procedure IEACE(OrigBitmap:TIEBitmap; subwidth:integer; Slope:integer; Cut:integer; Neightbour:integer; OnProgress: TIEProgressEvent; Sender: TObject);
var
  SubBitmap,dst,MidBitmap:TIEBitmap;
  maxv,minv:array [0..2] of double;
  pxin:integer;
  px_in:pbyte;  // input pixel
  px_out:psingle; // output pixel
  x,y,c:integer;
  width,height:integer;
  optp1,optm1:pdouble;
  slom:double;
  cutm:double;
  //
  procedure ProcessPixelMid;
  var
    sum1:double;  // numerator
    sum2:double;  // denominator
    xx,yy:integer;
    px_cur:pbyte;
    rmax:double;
    r:double;
  begin
    optp1:=optm1;
    sum1:=0;
    rmax:=0;
    for yy:=0 to height-1 do
    begin
      px_cur:=SubBitmap.Scanline[yy]; inc(px_cur,c);
      for xx:=0 to width-1 do
      begin

        r:=slom*(pxin-px_cur^);
        //r:=1* ( iepower(pxin, 1.1) - iepower(px_cur^, 1.1) );

        if r>cutm then r:=cutm else if r<-cutm then r:=-cutm;

        if abs(r)>rmax then
          rmax:=abs(r);

        sum1:=sum1 + r / optp1^;

        inc(px_cur,3);
        inc(optp1);
      end;
    end;

    optp1:=optm1;
    sum2:=0;
    yy:=width*height-1;
    for xx:=0 to yy do
    begin
      sum2:=sum2 + rmax / optp1^;
      inc(optp1);
    end;

    if sum2=0 then
      sum2:=1;
    px_out^:= sum1 / sum2;

    if px_out^>maxv[c] then
      maxv[c]:=px_out^;
    if px_out^<minv[c] then
      minv[c]:=px_out^;
  end;
  //
  procedure CalcOpt1;
  var
    xx,yy:integer;
    dd:psinglearray;
  begin
    optp1:=optm1;
    yy:=0;
    while yy<height do
    begin
      dd:=dst.Scanline[abs(y-yy)];
      xx:=0;
      while xx<width do
      begin
        optp1^:=dd[abs(x-xx)];
        inc(xx);
        inc(optp1);
      end;
      inc(yy);
    end;
  end;
  //
var
  md:psingle;
  px:pbyte;
  sc:array [0..2] of double;
  decimation:integer;
begin

  slom:=tan(pi*slope/180);
  cutm:=(cut/100)*(slom*255);

  decimation:=trunc( OrigBitmap.Width / subwidth );
  if decimation=0 then
    decimation:=1;

  SubBitmap:=TIEBitmap.Create;
  SubBitmap.Allocate( OrigBitmap.Width div decimation, OrigBitmap.Height div decimation, ie24RGB );
  _IEResampleIEBitmap(OrigBitmap,SubBitmap,rfNone,nil,nil);

  width:=SubBitmap.Width;
  height:=SubBitmap.Height;

  MidBitmap:=TIEBitmap.Create;
  MidBitmap.allocate(width*3,height,ie32f);

  dst:=TIEBitmap.Create;
  dst.Allocate(width,height,ie32f);
  for y:=0 to Height-1 do
  begin
    md:=dst.Scanline[y];
    for x:=0 to Width-1 do
    begin
      md^:=sqrt( x*x+y*y );
      if md^=0 then md^:=1000000;
      inc(md);
    end;
  end;

  for c:=0 to 2 do
  begin
    maxv[c]:=-100000;
    minv[c]:=+100000;
  end;

  getmem(optm1,width*height*sizeof(double));

  for y:=0 to Height-1 do
  begin
    px_in:=SubBitmap.Scanline[y];
    px_out:=MidBitmap.Scanline[y];
    for x:=0 to Width-1 do
    begin
      CalcOpt1;
      for c:=0 to 2 do
      begin
        pxin:=px_in^;
        ProcessPixelMid;
        inc(px_in);
        inc(px_out);
      end;
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y/Height*50));
  end;

  freemem(optm1);

  for c:=0 to 2 do
  begin
    if maxv[c]-minv[c] <>0 then
      sc[c] := 255 / (maxv[c]-minv[c])
    else
      sc[c] := 255;
  end;

  dst.Allocate( width, height, ie24RGB );

  for y:=0 to Height-1 do
  begin
    px:=dst.Scanline[y];
    md:=MidBitmap.Scanline[y];
    for x:=0 to Width-1 do
      for c:=0 to 2 do
      begin
        px^ := blimit(round( sc[c]*(md^-minv[c]) ));

        inc(px);
        inc(md);
      end;
  end;

  FreeAndNil(MidBitmap);

  IELLLUT(SubBitmap, dst, OrigBitmap, Neightbour, OnProgress,Sender,50,50);

  FreeAndNil(dst);
  FreeAndNil(SubBitmap);
end;

{!!
<FS>TImageEnProc.AutoImageEnhance1

<FM>Declaration<FC>
procedure AutoImageEnhance1(SubsampledSize:integer; Slope:integer; Cut:integer; Neightbour:integer);

<FM>Description<FN>
This is the first of a group of functions already implemented or that will be implemented in future which help to perform an automatic image adjustment.
AutoImageEnhance1 performs complex operations on the image to simulate how humans see the world to make the image to have better contrast and colors.

Parameters:
SumsamplesSize: to make it fast operations are performed on a subsampled image. This parameter specifies the image width. (default 60)
Slope: slope specifies the core function slope and it is measured in degrees. This value contribute to change contrast. Allowed values 0..90°, default 20.
Cut: cut specifies the code function range. This value contribute to change contrast. Allowed values are 0..100, default 25.
Neightbour: when the subsampled image is used to change the full size image, Neighbour specifies the window size of the conversion. High values slow down process but produce better results. Default is 2.

The default parameters was good for our set of test images.

!!}
procedure TImageEnProc.AutoImageEnhance1(SubsampledSize:integer; Slope:integer; Cut:integer; Neightbour:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_AUTOIMAGEENHANCE1, [SubsampledSize, Slope, Cut, Neightbour]), ProcBitmap, mask) then
    exit;
  IEACE(ProcBitmap, SubsampledSize,Slope,Cut,Neightbour,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
// Auto Sharp

procedure SharpAt(source:TIEBitmap; dest:TIEBitmap; x,y:integer; Intensity: integer; Neighbourhood: integer);
var
  nsize: integer; // neighbourhood size / 2
  nr, ng, nb: integer;
  k: double;
  //
  procedure GetNeighbourhood;
  var
    i, j: integer;
    px: PRGB;
    x1, x2, y1, y2: integer;
  begin
    nr := 0;
    ng := 0;
    nb := 0;
    x1 := imax(0, x - nsize);
    x2 := imin(source.Width - 1, x + nsize);
    y1 := imax(0, y - nsize);
    y2 := imin(source.Height - 1, y + nsize);
    for i := y1 to y - 1 do
    begin
      px := source.Scanline[i];
      inc(px, x1);
      for j := x1 to x - 1 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
      for j := x + 1 to x2 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
    end;
    for i := y + 1 to y2 do
    begin
      px := source.Scanline[i];
      inc(px, x1);
      for j := x1 to x - 1 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
      for j := x + 1 to x2 do
      begin
        with px^ do
        begin
          inc(nr, r);
          inc(ng, g);
          inc(nb, b);
        end;
        inc(px);
      end;
    end;
    i := y2 - y1;
    j := i * (x2 - x1);
    if j <> 0 then
    begin
      nr := nr div j;
      ng := ng div j;
      nb := nb div j;
    end;
  end;
  //
  var px:PRGB;
begin
  nsize := Neighbourhood div 2;
  k := Intensity / 10;
  GetNeighbourhood;
  px:=dest.PPixels_ie24RGB[x,y];
  with source.PPixels_ie24RGB[x,y]^ do
  begin
    px^.r := blimit(trunc(r + k * (r - nr)));
    px^.g := blimit(trunc(g + k * (g - ng)));
    px^.b := blimit(trunc(b + k * (b - nb)));
  end;
end;

// ref values: Intensity=68, rate=0.035
procedure IEAutoSharp(bitmap:TIEBitmap; Intensity:integer; rate:double; OnProgress: TIEProgressEvent; Sender: TObject);
var
  edge,dest:TIEBitmap;
  nullpr: TProgressRec;
  x,y:integer;
  width,height:integer;
begin
  width:=bitmap.Width;
  height:=bitmap.Height;

  dest:=TIEBitmap.Create;
  dest.Allocate(width,height,ie24RGB);

  edge:=TIEBitmap.Create;

  with nullpr do
  begin
    fOnProgress := nil;
    Sender := nil;
  end;
  _IEEdgeDetect_ShenCastan(bitmap,edge,rate, 0.9, 7, 0, true, nullpr);
  edge.PixelFormat:=ie8g;
  _IEGBlur(edge,4,nil,nil);

  for y:=0 to height-1 do
  begin
    for x:=0 to width-1 do
      SharpAt(bitmap,dest,x,y, round((255-edge.Pixels_ie8[x,y])/255*Intensity),4);
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y/height*100) );
  end;

  bitmap.AssignImage(dest);

  FreeAndNil(dest);
  FreeAndNil(edge);
end;

{!!
<FS>TImageEnProc.AutoSharp

<FM>Declaration<FC>
procedure AutoSharp(Intensity:integer; rate:double);

<FM>Description<FN>
AutoSharp enhances image sharpness, increasing the sharping of detected objects contours.
<FC>Intensity<FN> (0..100) controls the intensity of the effect (default 68)
<FC>Rate<FN> (0..1) controls the borders detection rate (default 0.035).

<FM>Example<FC>

ImageEnView.Proc.AutoSharp;
!!}
procedure TImageEnProc.AutoSharp(Intensity:integer; rate:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_AUTOSHARP, [Intensity, rate]), ProcBitmap, mask) then
    exit;
  IEAutoSharp(ProcBitmap, Intensity, rate, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
// MRSCR

const
  GOS=3;

  ICHANNEL0 =0;  // input channel 0
  ICHANNEL1 =1;  // input channel 1
  ICHANNEL2 =2;  // input channel 2

  MCHANNEL0 =3;  // mid channel 0
  MCHANNEL1 =4;  // mid channel 1
  MCHANNEL2 =5;  // mid channel 2

  OCHANNEL0 =6;  // output channel 0
  OCHANNEL1 =7;  // output channel 1
  OCHANNEL2 =8;  // output channel 2

procedure GaussX(sourceflt:psingle; destflt:psingle; fltmap:psinglearray; width:integer; alpha:single; beta:psinglearray);
var
  i:integer;
  fltmapm:psinglearray;
begin
  inc(sourceflt , (width-1));
  fltmap[0] := alpha * sourceflt^;
  dec(sourceflt);
  inc(psingle(fltmap));
  fltmapm:=fltmap; dec(psingle(fltmapm),1);
  fltmap[0] := alpha * sourceflt^ + beta[1]*fltmapm[0];
  dec(sourceflt);
  inc(psingle(fltmap));
  fltmapm:=fltmap; dec(psingle(fltmapm),2);
  fltmap[0] := alpha * sourceflt^ + beta[1]*fltmapm[1] + beta[2]*fltmapm[0];
  dec(sourceflt);
  inc(psingle(fltmap));
  for i := GOS to width-1 do
  begin
    fltmapm:=fltmap; dec(psingle(fltmapm),3);
    fltmap[0] := alpha * sourceflt^ + (beta[1]*fltmapm[2] + beta[2]*fltmapm[1] + beta[3]*fltmapm[0]);
    dec(sourceflt);
    inc(psingle(fltmap));
  end;
  for i := 0 to width-1 do
  begin
    fltmapm:=fltmap; dec(psingle(fltmapm),3);
    fltmap[0] := alpha * sourceflt^ + (beta[1]*fltmapm[2] + beta[2]*fltmapm[1] + beta[3]*fltmapm[0]);
    inc(sourceflt);
    inc(psingle(fltmap));
  end;
  for i := 0 to width-1 do
  begin
    fltmapm:=fltmap; dec(psingle(fltmapm),3);
    fltmap[0] := alpha * sourceflt^ + (beta[1]*fltmapm[2] + beta[2]*fltmapm[1] + beta[3]*fltmapm[0]);
    dec(sourceflt);
    inc(psingle(fltmap));
  end;
  dec(psingle(fltmap));
  fltmap[0] := alpha * fltmap[0];
  dec(psingle(fltmap));
  fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1]);
  dec(psingle(fltmap));
  fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1] + beta[2]*fltmap[2]);
  dec(psingle(fltmap));
  for i := GOS to width-1 do
  begin
    fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1] + beta[2]*fltmap[2] + beta[3]*fltmap[3]);
    dec(psingle(fltmap));
  end;
  inc(psingle(destflt) , width-1);
  for i := 0 to width-1 do
  begin
    fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1] + beta[2]*fltmap[2] + beta[3]*fltmap[3]);
    destflt^ := fltmap[0];
    dec(psingle(destflt));
    dec(psingle(fltmap));
  end;
end;

procedure GaussY(src:psingle; srcoff:integer; dst:psingle; dstoff:integer; fltmap:psinglearray; height:integer; alpha:single; beta:psinglearray);
var
  i:integer;
  fltmapm:psinglearray;
begin
  inc( src , srcoff*(height-1) );
  fltmap[0] := alpha * src^;
  dec( src , srcoff);
  inc(psingle(fltmap));
  fltmapm:=fltmap; dec(psingle(fltmapm),1);
  fltmap[0] := alpha * src^ + beta[1]*fltmapm[0];
  dec(src , srcoff);
  inc(psingle(fltmap));
  fltmapm:=fltmap; dec(psingle(fltmapm),2);
  fltmap[0] := alpha * src^ + beta[1]*fltmapm[1] + beta[2]*fltmapm[0];
  dec(src , srcoff);
  inc(psingle(fltmap));
  for i := GOS to height-1 do
  begin
    fltmapm:=fltmap; dec(psingle(fltmapm),3);
    fltmap[0] := alpha * src^ + (beta[1]*fltmapm[2] + beta[2]*fltmapm[1] + beta[3]*fltmapm[0]);
    dec(src , srcoff);
    inc(psingle(fltmap));
  end;
  for i := 0 to height-1 do
  begin
    fltmapm:=fltmap; dec(psingle(fltmapm),3);
    fltmap[0] := alpha * src^ + (beta[1]*fltmapm[2] + beta[2]*fltmapm[1] + beta[3]*fltmapm[0]);
    inc(src , srcoff);
    inc(psingle(fltmap));
  end;
  for i := 0 to height-1 do
  begin
    fltmapm:=fltmap; dec(psingle(fltmapm),3);
    fltmap[0] := alpha * src^ + (beta[1]*fltmapm[2] + beta[2]*fltmapm[1] + beta[3]*fltmapm[0]);
    dec(src , srcoff);
    inc(psingle(fltmap));
  end;
  dec(psingle(fltmap));
  fltmap[0] := alpha * fltmap[0];
  dec(psingle(fltmap));
  fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1]);
  dec(psingle(fltmap));
  fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1] + beta[2]*fltmap[2]);
  dec(psingle(fltmap));
  for i := GOS to height-1 do
  begin
    fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1] + beta[2]*fltmap[2] + beta[3]*fltmap[3]);
    dec(psingle(fltmap));
  end;
  inc(dst , dstoff*(height-1));
  for i := 0 to height-1 do
  begin
    fltmap[0] := alpha * fltmap[0] + (beta[1]*fltmap[1] + beta[2]*fltmap[2] + beta[3]*fltmap[3]);
    dst^ := fltmap[0];
    dec(dst , dstoff);
    dec(psingle(fltmap));
  end;
end;

procedure DoGauss(src:psingle; dst:psingle; width, height:integer; alpha:single; beta:psinglearray);
var
  i:integer;
  fltmap:psinglearray;
  vin:psingle;
  vout:psingle;
  xin:psingle;
  xinoff:integer;
  xout:psingle;
  xoutoff:integer;
begin
  getmem( fltmap , 3*(width+height) * sizeof(single));
  vin := src;
  vout := dst;
  for i:=0 to height-1 do
  begin
    GaussX(vin,vout,fltmap,width,alpha,beta);
    inc(vin , width);
    inc(vout , width);
  end;
  xin := dst;
  xinoff := width;
  xout := xin;
  xoutoff := xinoff;
  for i := 0 to width-1 do
  begin
    GaussY(xin,xinoff,xout,xoutoff,fltmap,height,alpha,beta);
    xin := @psinglearray(dst)[i];
    xout := @psinglearray(dst)[i];
  end;
  freemem(fltmap);
end;

procedure CalcCoef(sigma:single; var alpha:single; beta:psinglearray);
var
  c1, c2, c3:single;
begin
  if sigma >= 2.5 then
    c1 := 0.98711*sigma-0.96330
  else if (sigma >= 0.5) and (sigma < 2.5) then
    c1 := 3.97156-4.14554 * sqrt(1-0.26891 * sigma)
  else
    c1 := 0.1147705018520355224609375;
  c2 := c1*c1;
  c3 := c1*c2;
  beta[0] := 1.57825+2.44413*c1+1.4281*c2+0.422205*c3;
  beta[1] := (2.44413*c1+2.85619*c2+1.26661*c3)/beta[0];
  beta[2] := -(1.4281*c2+1.26661*c3)/beta[0];
  beta[3] := (0.422205*c3)/beta[0];
  alpha := 1-(beta[1]+beta[2]+beta[3]);
end;

function IELN(v:double):double;
begin
  if v <= 0.0 then
    result := ln(5.0e-324)
  else
    result := ln(v);
end;

procedure MRSCR(fltmap:psinglearray; width, height:integer; scales:psinglearray; ScaleCount:integer; Luma:boolean; OnProgress: TIEProgressEvent; Sender: TObject);
var
  i,j:integer;
  size:integer;
  weight:single;
  vout:psinglearray;
  opt:single;
  alpha:single;
  beta:array [0..3] of single;
begin
  size := width*height;
  weight := 1/ScaleCount;
  for i := 0 to ScaleCount-1 do
  begin
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(20+i/ScaleCount*50) );
    CalcCoef(scales[i],alpha,@beta);
    DoGauss(@fltmap[ICHANNEL0*size], @fltmap[MCHANNEL0*size], width, height,alpha,@beta);
    if not Luma then
    begin
      DoGauss(@fltmap[ICHANNEL1*size], @fltmap[MCHANNEL1*size], width, height,alpha,@beta);
      DoGauss(@fltmap[ICHANNEL2*size], @fltmap[MCHANNEL2*size], width, height,alpha,@beta);
    end;
    vout := fltmap;
    for j:=0 to size-1 do
    begin
      vout[OCHANNEL0*size] := vout[OCHANNEL0*size] + weight * (IELN(vout[ICHANNEL0*size]) - IELN(vout[MCHANNEL0*size]));
      if not Luma then
      begin
        vout[OCHANNEL1*size] := vout[OCHANNEL1*size] + weight * (IELN(vout[ICHANNEL1*size]) - IELN(vout[MCHANNEL1*size]));
        vout[OCHANNEL2*size] := vout[OCHANNEL2*size] + weight * (IELN(vout[ICHANNEL2*size]) - IELN(vout[MCHANNEL2*size]));
      end;
      inc(psingle(vout));
    end;
  end;
  if assigned(OnProgress) then
    OnProgress(Sender, 80 );
  vout := fltmap;
  for i:=0 to size-1 do
  begin
    if Luma then
    begin
      opt := ln(vout[ICHANNEL0*size]);
      vout[OCHANNEL0*size] := (ln(128 * vout[ICHANNEL0*size]) - opt) * vout[OCHANNEL0*size];
    end
    else
    begin
      opt := ln(vout[ICHANNEL0*size] + vout[ICHANNEL1*size] + vout[ICHANNEL2*size]);
      vout[OCHANNEL0*size] := (ln(128 * vout[ICHANNEL0*size]) - opt) * vout[OCHANNEL0*size];
      vout[OCHANNEL1*size] := (ln(128 * vout[ICHANNEL1*size]) - opt) * vout[OCHANNEL1*size];
      vout[OCHANNEL2*size] := (ln(128 * vout[ICHANNEL2*size]) - opt) * vout[OCHANNEL2*size];
    end;
    inc(psingle(vout));
  end;
end;

procedure CalcMeanVar(src:psingle; mean:psingle; xvar:psingle; size:integer);
var
  q:single;
  i:integer;
begin
  q := 0;
  mean^ := 0;
  for i:=0 to size-1 do
  begin
    mean^ := mean^ + src^;
    q := q + src^ * src^;
    inc(src);
  end;
  mean^ := mean^ / size;
  q := q / size;
  xvar^ := ( q - (mean^ * mean^) );
  xvar^ := sqrt(xvar^);
end;

// ScaleCurve:
// 0:low;
// 1:high
// 2:linear
// ScaleHigh: from 16 to 250 (ref. 150)
// ScaleCount: 1...
procedure IERetinex(bitmap:TIEBitmap; ScaleCount:integer; ScaleCurve:integer; Variance:single; ScaleHigh:integer; Luma:boolean; OnProgress: TIEProgressEvent; Sender: TObject);
var
  width,height:integer;
  size:integer;
  fltmap:psinglearray;
  mean, xvar:single;
  minval, maxval, rangeval:single;
  px_flt:psinglearray;
  px_rgb:PRGB;
  i,j:integer;
  Scales:psinglearray;
  YY,Cb,Cr:integer;
begin

  if assigned(OnProgress) then
    OnProgress(Sender, 0 );

  width := bitmap.Width;
  height := bitmap.Height;
  size := width*height;

  fltmap:=AllocMem( sizeof(single)* 9*size ); // zero filled

  // From bitmap to float
  px_flt := fltmap;
  for i:=0 to height-1 do
  begin
    px_rgb:=bitmap.Scanline[i];
    for j:=0 to width-1 do
    begin
      if Luma then
      begin
        IERGB2YCbCr(px_rgb^,YY,Cb,Cr);
        px_flt[ICHANNEL0*size] := 1 + YY;
      end
      else
        with px_rgb^ do
        begin
          px_flt[ICHANNEL0*size] := 1 + b;
          px_flt[ICHANNEL1*size] := 1 + g;
          px_flt[ICHANNEL2*size] := 1 + r;
        end;
      inc(px_rgb);
      inc(psingle(px_flt));
    end;
  end;

  if assigned(OnProgress) then
    OnProgress(Sender, 10 );

  getmem(Scales,sizeof(single)*(ScaleCount+1));
  scales[0] := ScaleHigh / 2;
  scales[1] := ScaleHigh;
  if ScaleCount>2 then
    case ScaleCurve of
      0:
        // low
        for i:=0 to ScaleCount-1 do
          scales[i] := 2 + iepower(10,(i*(ln(ScaleHigh-2)/ScaleCount))/ln(10));
      1:
        // high
        for i:=0 to ScaleCount-1 do
          scales[i] := ScaleHigh - iepower(10,(i*(ln(ScaleHigh-2)/ScaleCount))/ln(10));
      2:
        // linear
        for i:=0 to ScaleCount-1 do
          scales[i] := 2 + i * (ScaleHigh/ScaleCount);
    end;

  MRSCR(fltmap, width, height, Scales, ScaleCount, Luma, OnProgress,Sender);
  if Luma then
    CalcMeanVar(@fltmap[OCHANNEL0*size], @mean, @xvar, size)
  else
    CalcMeanVar(@fltmap[OCHANNEL0*size], @mean, @xvar, 3*size);
  minval := mean - Variance*xvar;
  maxval := mean + Variance*xvar;
  rangeval := maxval - minval;
  if rangeval=0 then
    rangeval := 1;

  if assigned(OnProgress) then
    OnProgress(Sender, 90 );

  // from float to bitmap
  px_flt := fltmap;
  for i := 0 to height-1 do
	begin
    px_rgb:=bitmap.Scanline[i];
	  for j := 0 to width-1 do
    begin
      if Luma then
      begin
        IERGB2YCbCr(px_rgb^,YY,Cb,Cr);
        YY := blimit(trunc(255 * ( px_flt[OCHANNEL0*size] - minval) / rangeval));
        IEYCbCr2RGB(px_rgb^,YY,Cb,Cr);
      end
      else
        with px_rgb^ do
        begin
          b := blimit(trunc(255 * ( px_flt[OCHANNEL0*size] - minval) / rangeval));
          g := blimit(trunc(255 * ( px_flt[OCHANNEL1*size] - minval) / rangeval));
          r := blimit(trunc(255 * ( px_flt[OCHANNEL2*size] - minval) / rangeval));
        end;
      inc(px_rgb);
      inc(psingle(px_flt));
    end;
	end;

  freemem(fltmap);
  freemem(Scales);

  if assigned(OnProgress) then
    OnProgress(Sender, 100 );
end;

{!!
<FS>TImageEnProc.AutoImageEnhance2


<FM>Declaration<FC>
procedure AutoImageEnhance2(ScaleCount:integer; ScaleCurve:integer; Variance:double; ScaleHigh:integer; Luminance:boolean);

<FM>Description<FN>
AutoImageEnhance2 performs complex operations on the image to simulate how humans see the world to make the image to have better contrast and colors.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>ScaleCount<FN></C> <C>The algorithm is applied to different scales of the image. This parameter specifies the number of scales. Default 3.</C> </R>
<R> <C><FC>ScaleCurve<FN></C> <C>Specifies how build the size of each scale. Allowed values 0..2. Default 2.</C> </R>
<R> <C><FC>Variance<FN></C> <C>The output variance. Default 1.8.</C> </R>
<R> <C><FC>ScaleHigh<FN></C> <C>Allowed values from 16 to 250. Default 200.</C> </R>
<R> <C><FC>Lumincance<FN></C> <C>If true the algorithm is applied only to luminance (luminosity) channel, so the algorithm doesn't touch colors.</C> </R>
</TABLE>

The default parameters was good for our set of test images.
!!}
procedure TImageEnProc.AutoImageEnhance2(ScaleCount:integer; ScaleCurve:integer; Variance:double; ScaleHigh:integer; Luminance:boolean);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_AUTOIMAGEENHANCE2, ProcBitmap, mask) then
    exit;
  IERetinex(ProcBitmap, ScaleCount,ScaleCurve,Variance,ScaleHigh,Luminance, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

// shift a channel by the specified offset
// blank pixels are padded with the old one
// the alpha channel is not shifted
// channel: 0=blue, 1=green, 2=red
// works only with ie24RGB
// if FillValue=-1 the previous value is set
// if FillValue>=0 this is the value to fill
procedure IEShift(Bitmap:TIEBitmap; offsetx,offsety:integer; channel:integer; FillValue:integer; OnProgress: TIEProgressEvent; Sender: TObject);
var
  i,j:integer;
  newbmp:TIEBitmap;
  width,height,v:integer;
  src,dst:PRGB;
  newsrc,dst2:pbyte;
  src_48,dst_48:PRGB48;
  newsrc_48,dst2_48:pword;
  ox,oy:integer;
begin
  width:=Bitmap.Width;
  height:=Bitmap.Height;
  newbmp:=TIEBitmap.Create;
  newbmp.Allocate(width,height,Bitmap.PixelFormat);
  case Bitmap.PixelFormat of
    ie24RGB:
      begin
        for i:=0 to height-1 do
        begin
          src:=Bitmap.Scanline[i];
          dst:=newbmp.Scanline[i];
          for j:=0 to width-1 do
          begin
            if FillValue>-1 then
            begin
              ox:=j-offsetx;
              oy:=i-offsety;
              if (ox>=0) and (ox<width) and (oy>=0) and (oy<height) then
              begin
                newsrc:=pbyte(Bitmap.PPixels_ie24RGB[ox,oy]); inc(newsrc,channel);
                v:=newsrc^;
              end
              else
                v:=FillValue;
            end
            else
            begin
              ox:=imin(imax(0,j-offsetx),width-1);
              oy:=imin(imax(0,i-offsety),height-1);
              newsrc:=pbyte(Bitmap.PPixels_ie24RGB[ox,oy]); inc(newsrc,channel);
              v:=newsrc^;
            end;
            dst2:=pbyte(dst); inc(dst2,channel);
            dst^:=src^;
            dst2^:=v;
            inc(src);
            inc(dst);
          end;
          if assigned(OnProgress) then
            OnProgress(Sender, trunc(i/height) );
        end;
      end;
    ie48RGB:
      begin
        for i:=0 to height-1 do
        begin
          src_48:=Bitmap.Scanline[i];
          dst_48:=newbmp.Scanline[i];
          for j:=0 to width-1 do
          begin
            if FillValue>-1 then
            begin
              ox:=j-offsetx;
              oy:=i-offsety;
              if (ox>=0) and (ox<width) and (oy>=0) and (oy<height) then
              begin
                newsrc_48:=pword(Bitmap.PPixels_ie48RGB[ox,oy]); inc(newsrc_48,channel);
                v:=newsrc_48^;
              end
              else
                v:=FillValue;
            end
            else
            begin
              ox:=imin(imax(0,j-offsetx),width-1);
              oy:=imin(imax(0,i-offsety),height-1);
              newsrc_48:=pword(Bitmap.PPixels_ie48RGB[ox,oy]); inc(newsrc_48,channel);
              v:=newsrc_48^;
            end;
            dst2_48:=pword(dst_48); inc(dst2_48,channel);
            dst_48^:=src_48^;
            dst2_48^:=v;
            inc(src_48);
            inc(dst_48);
          end;
          if assigned(OnProgress) then
            OnProgress(Sender, trunc(i/height) );
        end;
      end;
  end;
  Bitmap.AssignImage(newbmp);
  FreeAndNil(newbmp);
end;

{!!
<FS>TImageEnProc.ShiftChannel


<FM>Declaration<FC>
procedure ShiftChannel(offsetX, offsetY:integer; channel:integer; fillValue:integer);

<FM>Description<FN>
ShiftChannel moves the specified channel by an offset filling blank position with a color.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>offsetX<FN></C> <C>Specifies the horizontal offset in pixels. This can have negative values.</C> </R>
<R> <C><FC>offsetY<FN></C> <C>Specifies the vertical offset in pixels. This can have negative values.</C> </R>
<R> <C><FC>channel<FN></C> <C>The channel to shift. 0=Blue, 1=Green and 2=Red.</C> </R>
<R> <C><FC>fillValue<FN></C> <C>The filling color (this is the channel intensity, because ShiftChannel works on a channel at the time).</C> </R>
</TABLE>


<FM>Example<FC>

// shift to -2 in horizontal and -1 in vertical the channel Blue, filling right new areas with 0.
ImageEnView1.Proc.ShiftChannel(-2,-1, 0,0);

!!}
procedure TImageEnProc.ShiftChannel(offsetX, offsetY:integer; channel:integer; fillValue:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB,ie48RGB], x1, y1, x2, y2, Format(IERS_SHIFTCHANNEL, [offsetX, offsetY, channel, fillValue]), ProcBitmap, mask) then
    exit;
  IEShift(ProcBitmap, offsetX,offsetY,channel,fillValue, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure IEChangeYCbCrCoefficients(Bitmap:TIEBitmap; srcLumaRed,srcLumaGreen,srcLumaBlue, dstLumaRed,dstLumaGreen,dstLumaBlue:double);
var
  row,col:integer;
  rgb:PRGB;
  width,height:integer;
  Y,Cb,Cr:double;
  rr,gg,bb:double;
begin
  width:=Bitmap.Width;
  height:=Bitmap.Height;
  for row:=0 to height-1 do
  begin
    rgb:=Bitmap.Scanline[row];
    for col:=0 to width-1 do
    begin
      with rgb^ do
      begin
        rr:=r/255;
        gg:=g/255;
        bb:=b/255;
      end;
      Y := (srcLumaRed*rr + srcLumaGreen*gg + srcLumaBlue*bb);
      Cb:= (bb-Y)/(2-2*srcLumaBlue);
      Cr:= (rr-Y)/(2-2*srcLumaRed);

      rr:= Cr*(2-2*dstLumaRed)+Y;
      gg:= (Y-dstLumaBlue*bb - dstLumaRed*rr)/dstLumaGreen;
      bb:= Cb*(2-2*dstLumaBlue)+Y;

      with rgb^ do
      begin
        r:=blimit(round(rr*255));
        g:=blimit(round(gg*255));
        b:=blimit(round(bb*255));
      end;

      inc(rgb);
    end;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Thanks to Roy Klever

procedure MinMax(const i, j, k: byte; var min: integer; var max: word);
begin
  if i > j then
  begin
    if i > k then
      max := i
    else
      max := k;
    if j < k then
      min := j
    else
      min := k
  end
  else
  begin
    if j > k then
      max := j
    else
      max := k;
    if i < k then
      min := i
    else
      min := k
  end;
end;

procedure IERGBtoHSB(const cRed, cGreen, cBlue: byte; var H, S, B: word);
var
  Delta: Integer;
  MinValue: Integer;
  tmpH: Integer;
begin
  tmpH := 0;
  MinMax(cRed, cGreen, cBlue, MinValue, B);
  Delta := B - MinValue;
  if B = 0 then
    S := 0
  else
    S := (255 * Delta) div B;
  if S = 0 then
    tmpH := 0
  else
  begin
    if cRed = B then
      tmpH := (60 * (cGreen - cBlue)) div Delta
    else if cGreen = B then
      tmpH := 120 + (60 * (cBlue - cRed)) div Delta
    else if cBlue = B then
      tmpH := 240 + (60 * (cRed - cGreen)) div Delta;
    if tmpH < 0 then
      tmpH := tmpH + 360;
  end;
  H := tmpH;
end;

procedure IEHSBtoRGB(const H, S, B: word; var cRed, cGreen, cBlue: byte);
const
  divisor: Integer = 255 * 60;
var
  f: Integer;
  hTemp: Integer;
  p, q, t: Integer;
  VS: Integer;
begin
  if s = 0 then
  begin
    cRed := B;
    cGreen := B;
    cBlue := B;
  end
  else
  begin
    if H = 360 then
      hTemp := 0
    else
      hTemp := H;
    f := hTemp mod 60;
    hTemp := hTemp div 60;
    VS := B * S;
    p := B - VS div 255;
    q := B - (VS * f) div divisor;
    t := B - (VS * (60 - f)) div divisor;

    case hTemp of
      0:
        begin
          cRed := B;
          cGreen := t;
          cBlue := p
        end;
      1:
        begin
          cRed := q;
          cGreen := B;
          cBlue := p
        end;
      2:
        begin
          cRed := p;
          cGreen := B;
          cBlue := t
        end;
      3:
        begin
          cRed := p;
          cGreen := q;
          cBlue := B
        end;
      4:
        begin
          cRed := t;
          cGreen := p;
          cBlue := B
        end;
      5:
        begin
          cRed := B;
          cGreen := p;
          cBlue := q
        end;
    end;
  end;
end;

// Brightnes, Contrast and Saturation
// b [0 .. 512]
// c [-100 .. 100]
// s [0 .. 512]

procedure IEAdjustBrightnessContrastSaturation(Bitmap: TIEBitmap; b, c, s: integer; OnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y, i, k, v: Integer;
  ci1, ci2, ci3: integer;
  alpha: integer;
  a: double;
  ContrastLut: array[0..255] of byte;
  BCLut: array[0..255] of byte;
  SaturationLut: record
    Grays: array[0..767] of Integer;
    Alpha: array[Byte] of Word;
  end;
  color: PRGB;
  width,height:integer;
begin

  width:=Bitmap.Width;
  height:=Bitmap.Height;

  if c = 100 then
    c := 99;
  for i := 0 to 255 do
  begin
    if c > 0 then
      a := 1 / cos(c * (PI / 200))
    else
      a := 1 * cos(c * (3.1416 / 200));
    v := Round(a * (i - 170) + 170);
    if v > 255 then
      v := 255
    else if v < 0 then
      v := 0;
    ContrastLut[i] := v;
  end;

  for i := 0 to 255 do
  begin
    alpha := b;
    k := 256 - alpha;
    v := (k + alpha * i) div 256;
    if v < 0 then
      v := 0;
    if v > 255 then
      v := 255;
    BCLut[i] := ContrastLut[v];
  end;

  //  Calculate saturation
  x := 0;
  for i := 1 to 256 do
    SaturationLut.Alpha[i - 1] := (i * s) shr 8;
  for i := 0 to 255 do
  begin
    y := i - SaturationLut.Alpha[i];
    SaturationLut.Grays[x] := y;
    Inc(x);
    SaturationLut.Grays[x] := y;
    Inc(x);
    SaturationLut.Grays[x] := y;
    Inc(x);
  end;
  // Done saturation

  // Then apply them...
  for y := 0 to height - 1 do
  begin
    Color:=Bitmap.Scanline[y];
    for x := 0 to width - 1 do
    begin
      v := Color.R + Color.G + Color.B;
      ci1 := SaturationLut.Grays[v] + SaturationLut.Alpha[Color.B];
      ci2 := SaturationLut.Grays[v] + SaturationLut.Alpha[Color.G];
      ci3 := SaturationLut.Grays[v] + SaturationLut.Alpha[Color.R];

      if ci1 < 0 then
        ci1 := 0
      else if ci1 > 255 then
        ci1 := 255;
      if ci2 < 0 then
        ci2 := 0
      else if ci2 > 255 then
        ci2 := 255;
      if ci3 < 0 then
        ci3 := 0
      else if ci3 > 255 then
        ci3 := 255;

      with Color^ do
      begin
        B := BCLut[ci1];
        G := BCLut[ci2];
        R := BCLut[ci3];
      end;

      inc(Color);
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y/height*100) );
  end;
end;

// b [-100 .. 100]     (the internal function has 0..512)
// c [-100 .. 100]
// s [-100 .. 100]     (the internal function has 0..512)
{!!
<FS>TImageEnProc.AdjustBrightnessContrastSaturation

<FM>Declaration<FC>
procedure AdjustBrightnessContrastSaturation(Brightness, Contrast, Saturation:integer);

<FM>Description<FN>
This method adjust brightness, contrast and color saturation in one step.
Brightness can assume values from -100 to 512.
Contrast can assume values from -100 to 100.
Saturation can assume values from 0 to 512.

If a parameter is zero, it doesn't change the image.

<FM>Example<FC>

// enhances brightness, contrast and color saturation
ImageEnView1.Proc.AdjustBrightnessContrastSaturation(50, 10, 10);

!!}
procedure TImageEnProc.AdjustBrightnessContrastSaturation(Brightness, Contrast, Saturation:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_ADJUSTBRIGHTNESSCONTRASTSATURATION, [Brightness, Contrast, Saturation]), ProcBitmap, mask) then
    exit;
  IEAdjustBrightnessContrastSaturation(ProcBitmap, trunc((Brightness/100+1)*256),Contrast,trunc((Saturation/100+1)*256), fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// z: ref. 0.3
procedure IEContrast2(src: TIEBitmap; z: single; OnProgress: TIEProgressEvent; Sender: TObject);
type
  THistSingle = array[0..255] of Single;
  THistogram = array[0..255] of integer;
var
  p0: PRGB;
  x, y: integer;
  q1: Single;
  histB: Thistogram;
  Hist, VCumSumR: THistSingle;
  wH, wS, wB: Word;
  width, height:integer;

  procedure HistCalc(src: TIEBitmap; var histB: THistogram);
  var
    p0: PRGB;
    sx, sy, x, y: Integer;
    wH, wS, wB: Word;
  begin
    sx := width - 1;
    sy := height - 1;

    for x := 0 to 255 do
      histB[x] := 0;

    for y := 0 to sy do
    begin
      p0 := src.ScanLine[y];
      for x := 0 to sx do
      begin
        with p0^ do
          IERGBToHSB(r,g, b, wH, wS, wB);
        inc(histB[wB]);
        inc(p0);
      end;
    end;
  end;

  function CumSum(hist: THistSingle): THistSingle;
  var
    x: Byte;
    Temp: THistsingle;
  begin
    Temp[0] := Hist[0];
    for x := 1 to 255 do
      Temp[x] := Temp[x - 1] + Hist[x];
    CumSum := Temp;
  end;

begin

  width:=src.Width;
  height:=src.Height;

  HistCalc(src, histB);

  // Intensity Channel B
  q1 := 0;
  for x := 0 to 255 do
  begin
    Hist[x] := iepower(HistB[x], z);
    q1 := q1 + Hist[x];
  end;
  vcumsumR := cumsum(Hist);

  for y := 0 to height - 1 do
  begin
    p0 := src.scanline[y];
    for x := 0 to width - 1 do
    begin
      with p0^ do
      begin
        IERGBToHSB(r,g, b, wH, wS, wB);
        wB:= Trunc((255 / q1) * vcumsumR[wB]);
        IEHSBToRGB(wH, wS, wB, r, g, b);
      end;
      inc(p0);
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y/height*100) );
  end;
end;

// amount: 0..1 (ref 0.3)
{!!
<FS>TImageEnProc.Contrast2

<FM>Declaration<FC>
procedure Contrast2(Amount:double);

<FM>Description<FN>
This is another contrast adjustment function. Amount assumes floating point values from 0 to 1.

<FM>Example<FC>

ImageEnView1.Proc.Contrast2(0.3);

!!}
procedure TImageEnProc.Contrast2(Amount:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_CONTRAST2, [Amount]), ProcBitmap, mask) then
    exit;
  IEContrast2(ProcBitmap, Amount, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// 2.3.1
//Amount [0 .. 1000]
procedure IEAdjustSaturation(Src: TIEBitmap; Amount: integer; pr:TProgressRec);
var
  x, y1: integer;
  ry1, by1, gy1, y:double;
  cr, cg, cb: integer;
  RGB: PRGB;
  width,height:integer;
  amt:double;
begin
  width:=Src.Width;
  height:=Src.Height;
  amt:=Amount/100;
  for y1 := 0 to height - 1 do
  begin
    RGB:=Src.Scanline[y1];
    for x := 0 to width - 1 do
    begin
      with RGB^ do
      begin
        ry1 :=  0.70 * r - 0.59 * g - 0.11 * b;
        by1 := -0.30 * r - 0.59 * g + 0.89 * b;
        gy1 := -0.30 * r + 0.41 * g - 0.11 * b;
        y   :=  0.30 * r + 0.59 * g + 0.11 * b;
        cr := round(ry1*amt + y);
        cg := round(gy1*amt + y);
        cb := round(by1*amt + y);
        if cr < 0 then
          r := 0
        else if cr > 255 then
          r := 255
        else
          r := cr;
        if cg < 0 then
          g := 0
        else if cg > 255 then
          g := 255
        else
          g := cg;
        if cb < 0 then
          b := 0
        else if cb > 255 then
          b := 255
        else
          b := cb;
      end;
      inc(RGB);
    end;
    with pr do
      if assigned(fOnProgress) then
        fOnProgress(Sender, tot + trunc(y1/height*per1*100) );
  end;
end;

{!!
<FS>TImageEnProc.AdjustSaturation

<FM>Declaration<FC>
procedure AdjustSaturation(Amount:integer);

<FM>Description<FN>
AdjustSaturation adjusts color saturation. Amount allows values from -100 to 100.

!!}
procedure TImageEnProc.AdjustSaturation(Amount:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
  pr:TProgressRec;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_ADJUSTSATURATION, [Amount]), ProcBitmap, mask) then
    exit;
  pr.fOnProgress:=fOnProgress;
  pr.Sender:=self;
  pr.tot:=0;
  pr.per1:=1;
  IEAdjustSaturation(ProcBitmap, Amount+100, pr);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

//Amount [-180 .. 180]

procedure IEAdjustTint(Src: TIEBitmap; Amount: integer; OnProgress: TIEProgressEvent; Sender: TObject);
var
  x, ry, by, gy, ry1, by1, (*gy1, *)y1: integer;
  y, cr, cg, cb, r1, b1, g1: integer;
  RGB: PRGB;
  C, S, Theta: Single;
  width,height:integer;
begin
  width:=Src.Width;
  height:=Src.Height;

  Theta := (3.14159 * Amount) / 180;
  C := 256 * Cos(Theta);
  S := 256 * Sin(Theta);
  for y1 := 0 to height - 1 do
  begin
    RGB:=Src.Scanline[y1];
    for x := 0 to width - 1 do
    begin
      r1 := RGB.R;
      g1 := RGB.G;
      b1 := RGB.B;
      ry1 := Round((70 * r1 - 59 * g1 - 11 * b1) / 100);
      by1 := Round((-30 * r1 - 59 * g1 + 89 * b1) / 100);
      //gy1 := Round((-30 * r1 + 41 * g1 - 11 * b1) / 100);
      y := Round((30 * r1 + 59 * g1 + 11 * b1) / 100);
      by := Round((C * by1 - S * ry1) / 256);
      ry := Round((S * by1 + C * ry1) / 256);
      gy := Round((-51 * ry - 19 * by) / 100);
      cr := ry + y;
      cg := gy + y;
      cb := by + y;
      if cr < 0 then
        cr := 0
      else if cr > 255 then
        cr := 255;
      if cg < 0 then
        cg := 0
      else if cg > 255 then
        cg := 255;
      if cb < 0 then
        cb := 0
      else if cb > 255 then
        cb := 255;
      with RGB^ do
      begin
        r := cr;
        g := cg;
        b := cb;
      end;
      inc(RGB);
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y1/height*100) );
  end;
end;

{!!
<FS>TImageEnProc.AdjustTint

<FM>Declaration<FC>
procedure AdjustTint(Amount:integer);

<FM>Description<FN>
AdjustTint adjusts color tint. Amount is measured in degrees and allows values from -180 to 180.

!!}
procedure TImageEnProc.AdjustTint(Amount:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_ADJUSTTINT, [Amount]), ProcBitmap, mask) then
    exit;
  IEAdjustTint(ProcBitmap, Amount, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


// z1=saturation  (ref. 0.1)
// z2=contrast    (ref. 0.3)

procedure IEAutoSBHist(src: TIEBitmap; z1, z2: single; OnProgress: TIEProgressEvent; Sender: TObject);
type
  THistSingle = array[0..255] of Single;
  THistogram = array[0..255] of Integer;
var
  p0: PRGBROW;
  x, y: integer;
  q1, q2: Single;
  HistS, HistB: THistogram;
  Hist1, VCumSumS: THistSingle;
  Hist2, VCumSumB: THistSingle;
  cy, ccr, ccb: word;
  width,height:integer;

  procedure HistCalc(src: TIEBitmap; var HS, HB: THistogram);
  var
    p0: PRGBROW;
    sx, sy, x, y: Integer;
    cy, ccr, ccb: word;
  begin
    sx := width - 1;
    sy := height - 1;

    for x := 0 to 255 do
    begin
      HS[x] := 0;
      HB[x] := 0;
    end;

    for y := 0 to sy do
    begin
      p0 := src.ScanLine[y];
      for x := 0 to sx do
        with p0[x] do
        begin
          IERGBtoHSB(r, g, b, ccb, cy, ccr);
          Inc(HS[cy]);
          Inc(HB[ccr]);
        end;
    end;
  end;

  function CumSum(hist: THistSingle): THistSingle;
  var
    x: Byte;
    Temp: THistsingle;
  begin
    Temp[0] := Hist[0];
    for x := 1 to 255 do
      Temp[x] := Temp[x - 1] + Hist[x];
    CumSum := Temp;
  end;

begin

  width:=src.Width;
  height:=src.Height;

  HistCalc(src, HistS, HistB);

  q1 := 0;
  for x := 0 to 255 do
  begin
    Hist1[x] := IEPower(HistS[x], z1);
    q1 := q1 + Hist1[x];
  end;
  vcumsumS := cumsum(Hist1);

  q2 := 0;
  for x := 0 to 255 do
  begin
    Hist2[x] := IEPower(HistB[x], z2);
    q2 := q2 + Hist2[x];
  end;
  vcumsumB := cumsum(Hist2);

  for y := 0 to height - 1 do
  begin
    p0 := src.scanline[y];
    for x := 0 to width - 1 do
      with p0[x] do
      begin
        IERGBtoHSB(r, g, b, ccb, cy, ccr);
        cy := Trunc((255 / q1) * vcumsumS[cy]);
        ccr := Trunc((255 / q2) * vcumsumB[ccr]);
        IEHSBtoRGB(ccb, cy, ccr, r, g, b);
      end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y/height*100) );
  end;
end;

{!!
<FS>TImageEnProc.AdjustLumSatHistogram

<FM>Declaration<FC>
procedure AdjustLumSatHistogram(Saturation, Luminance:double);

<FM>Description<FN>
Adjusts Saturation, Luminance and the histogram.
Saturation allows values from 0 to 1.
Luminance allows values from 0 to 1.

!!}
procedure TImageEnProc.AdjustLumSatHistogram(Saturation, Luminance:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_ADJUSTLUMSATHISTOGRAM, [Saturation, Luminance]), ProcBitmap, mask) then
    exit;
  IEAutoSBHist(ProcBitmap, Saturation,Luminance, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////


procedure IEDisposeChannels(Bitmap:TIEBitmap; newDispo:string; OnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y:integer;
  s8:array [0..3] of byte;
  s16:array [0..3] of word;
  p:array [0..2] of integer;
  d_rgb8:PRGB;
  d_rgb16:PRGB48;
  width, height:integer;

  procedure DoProgress;
  begin
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y/height*100) );
  end;

begin
  width  := Bitmap.Width;
  height := Bitmap.Height;
  newDispo := UpperCase(newDispo);
  for y:=1 to 3 do
    case newDispo[y] of
      'R': p[y-1]:=2;
      'G': p[y-1]:=1;
      'B': p[y-1]:=0;
      '0': p[y-1]:=3;
    end;

  case Bitmap.PixelFormat of
    ie24RGB:
      begin
        s8[3] := 0;  // const '0' value
        for y:=0 to height-1 do
        begin
          d_rgb8 := Bitmap.Scanline[y];
          for x:=0 to width-1 do
          begin
            s8[0] := d_rgb8^.b;
            s8[1] := d_rgb8^.g;
            s8[2] := d_rgb8^.r;
            d_rgb8^.b := s8[ p[0] ];
            d_rgb8^.g := s8[ p[1] ];
            d_rgb8^.r := s8[ p[2] ];
            inc(d_rgb8);
          end;
          DoProgress;
        end;
      end;
    ie48RGB:
      begin
        s16[3] := 0;  // const '0' value
        for y:=0 to height-1 do
        begin
          d_rgb16 := Bitmap.Scanline[y];
          for x:=0 to width-1 do
          begin
            s16[0] := d_rgb16^.b;
            s16[1] := d_rgb16^.g;
            s16[2] := d_rgb16^.r;
            d_rgb16^.b := s16[ p[0] ];
            d_rgb16^.g := s16[ p[1] ];
            d_rgb16^.r := s16[ p[2] ];
            inc(d_rgb16);
          end;
          DoProgress;
        end;
      end;
  end;
end;


{!!
<FS>TImageEnProc.DisposeChannels

<FM>Declaration<FC>
procedure DisposeChannels(newDispo:string);

<FM>Description<FN>
This method changes the channels order from BGR (default) to the specified one.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>newDispo<FN></C> <C>A string of three characters, one for each channel ('RGB', 'RBG', etc). Can contain also '0' to set a channel to zero. You can also replicate the same channel: 'RRR' or 'GGG', etc.</C> </R>
</TABLE>


<FM>Example<FC>

// invert R with B
ImageEnView1.Proc.DisposeChannels('RGB');

// set channels B and G to 0, leaving only R
ImageEnView1.Proc.DisposeChannels('00R');

!!}
procedure TImageEnProc.DisposeChannels(newDispo:string);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB, ie48RGB], x1, y1, x2, y2, Format(IERS_DISPOSECHANNELS, [newDispo]), ProcBitmap, mask) then
    exit;
  IEDisposeChannels(ProcBitmap, newDispo, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure IEIntensity(Bitmap:TIEBitmap; LoLimit,HiLimit,Change:integer; UseAverageRGB:boolean; DoRed,DoGreen,DoBlue:boolean; OnProgress: TIEProgressEvent; Sender: TObject);
var
  MidPoint:integer;
  Steps:double;
  VInc:double;
  Accum:double;
  i:integer;
  LUT1,LUT2:array [0..255] of integer;
  x,y,width,height:integer;
  rgb:PRGB;
  AverageRGB:integer;
begin
  // control parameters
  if (LoLimit=255) or (HiLimit=0) or (HiLimit<=LoLimit) or (Change=0) then
    exit;
  if Abs(HiLimit - LoLimit) <= 1 then
    exit;     

  width:=Bitmap.Width;
  height:=Bitmap.Height;

  MidPoint := trunc( LoLimit + ((HiLimit - LoLimit) / 2) );

  Steps := MidPoint - LoLimit;
  VInc := Change / Steps;
  Accum := 0;

  // Initialise look-up tables
  for i := 0 To 255 do
  begin
    LUT1[i] := i;
    LUT2[i] := 0;
  end;

  // Populate the tables with increasing gradient values
  for i := LoLimit to MidPoint do
  begin
    Accum := Accum + VInc;
    LUT1[i] := trunc(LUT1[i] + Accum);
    LUT2[i] := trunc(Accum) ;
  end;

  // Populate the tables with decreasing gradient values
  for i := MidPoint + 1 to HiLimit do
  begin
    Accum := Accum - VInc;
    LUT1[i] := trunc(LUT1[i] + Accum);
    LUT2[i] := trunc(Accum);
  end;

  for i := 0 To 255 do
  begin
    if Change < 0 Then
    begin
      if LUT1[i] < 0 then
        LUT1[i] := 0;
    end
    else
    begin
      If LUT1[i] > 255 then
        LUT1[i] := 255
    end;
  end;

  if UseAverageRGB then
  begin

    for y := 0 to height - 1 do
    begin
      rgb:=Bitmap.Scanline[y];
      for x := 0 To width - 1 do
      begin
        with rgb^ do
        begin
          AverageRGB := (r + g + b) div 3;
          // UPDATE the existing value with the entry in the 2nd table
          if DoRed then
            r := blimit(r + LUT2[AverageRGB]);
          if DoGreen then
            g := blimit(g + LUT2[AverageRGB]);
          if DoBlue then
            b := blimit(b + LUT2[AverageRGB]);
        end;
        inc(rgb);
      end;
      if assigned(OnProgress) then
        OnProgress(Sender, trunc(y/height*100) );
    end;

  end
  else
  begin

    for y := 0 to height - 1 do
    begin
      rgb:=Bitmap.Scanline[y];
      for x := 0 To width - 1 do
      begin
        with rgb^ do
        begin
          if DoRed then
            r := LUT1[r];
          if DoGreen then
            g := LUT1[g];
          if DoBlue then
            b := LUT1[b];
        end;
        inc(rgb);
      end;
      if assigned(OnProgress) then
        OnProgress(Sender, trunc(y/height*100) );
    end;

  end;

end;

{!!
<FS>TImageEnProc.Intensity

<FM>Declaration<FC>
procedure Intensity(LoLimit, HiLimit, Change:integer; UseAverageRGB:boolean; DoRed, DoGreen, DoBlue:boolean);

<FM>Description<FN>
Changes the value of a pixel by an amount determined by the input Red, Green and Blue channel RGB values individually, or as an averaged value. The change is graduated starting from LoLimit, with a maximum change applied to the midpoint between LoLimit and HiLimit, then reduced again to HiLimit.

Typically this method can be used to effectively progressively brighten or darken any range of colors as requested without affecting colors outside the range.  RGB values in the range of 0 to 127 are considered as darker, and 128 to 255 as lighter.

LoLimit - an integer between 0 and 255 that indicates the start point of the range.

HiLimit - an integer between 0 and 255 that indicates the end point of the range.

Change - an integer between -255 and 255 that indicates the maximum or minimum value to be applied to the midpoint, and used to determine the slope of the increment/decrement used over the range.

UseAverageRGB - If True, uses the average value of the input Red, Green and Blue channels to determine the amount to change all RGB channels in the pixel.

DoRed
DoGreen
DoBlue - If True, applies the change to this RGB channel.

<FM>Example<FC>

// Apply an Intensity gradient peaking at +40 to all RGB values between 80 and 255
ImageEnView.Proc.Intensity( 80, 255, 40, False, True, True, True );

// Apply an Intensity gradient dropping to -24, to the Red RGB channel only, when Red values are between 20 and 127
ImageEnView.Proc.Intensity( 20, 127, -24, False, True, False, False );

!!}
procedure TImageEnProc.Intensity(LoLimit, HiLimit, Change:integer; UseAverageRGB:boolean; DoRed, DoGreen, DoBlue:boolean);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_INTENSITY, ProcBitmap, mask) then
    exit;
  IEIntensity(ProcBitmap, LoLimit,HiLimit,Change,UseAverageRGB,DoRed,DoGreen,DoBlue, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

procedure IEContrast3(Bitmap:TIEBitmap; Change, Midpoint:integer; DoRed,DoGreen,DoBlue:boolean; OnProgress: TIEProgressEvent; Sender: TObject);
var
  i,x,y:integer;
  rgb:PRGB;
  width,height:integer;
  contrast:double;
  modifier:integer;
  LUT1:array [0..255] of integer;
begin
  if Change = 0 then
    exit;

  if change < -255 then
    Change := -255;
  if change > 255 then
    Change := 255;

  if Midpoint < -100 then
    Midpoint := -100;
  if Midpoint > 100 then
    Midpoint := 100;

  i := Change + 100;

  if i = 100 then
    Contrast := 1
  else if i < 100 then
    contrast := 1 / (5 - (i / 25))
  else
    Contrast := ((i - 100) / 50) + 1;

  Modifier := 100 + Midpoint;
  for i := 0 to 255 do
    LUT1[i] := blimit( trunc(((i - Modifier) * Contrast) + Modifier) );

  width:=Bitmap.Width;
  height:=Bitmap.Height;

  for y:=0 to height-1 do
  begin
    rgb:=Bitmap.Scanline[y];
    for x:=0 to width-1 do
    begin
      with rgb^ do
      begin
        if DoRed then
          r := LUT1[r];
        if DoGreen then
          g := LUT1[g];
        if DoBlue then
          b := LUT1[b];
      end;
      inc(rgb);
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(y/height*100) );
  end;

end;

{!!
<FS>TImageEnProc.Contrast3

<FM>Declaration<FC>
procedure Contrast3(Change, Midpoint:integer; DoRed, DoGreen, DoBlue:boolean);

<FM>Description<FN>
Applies contrast to the image by lightening or darkening pixels depending on whether they are above or below a threshold. The Midpoint value determines that threshold, the point at which the Change value influences the pixel value lighter or darker.

When Change values are positive, INCreasing the Midpoint value darkens the contrast.

When Change values are negative, INCreasing the Midpoint value lightens the contrast.

Midpoint - an integer between -100 and +100 that determines the threshold of light and dark.

Change - an integer between -255 and 255 that indicates the level of contrast to be applied each side of the midpoint.

DoRed
DoGreen
DoBlue - If True, applies the change to this RGB channel.

<FM>Examples<FC>

// Apply Contrast of +20 to all RGB values around the default Midpoint value:
ImageEnView.Proc.Contrast3 (0, 20, True, True, True);

// Apply Contrast of -24, to the Red and Blue RGB channels only, around a Midpoint of +10, to lighten the overall result:
ImageEnView.Proc.Intensity (10, -24, True, False, True);

// Apply Contrast of +15, to the Green RGB channel only, around a Midpoint of +30, to darken the overall result:
ImageEnView.Proc.Intensity (30, 15, False, True, False);

!!}
procedure TImageEnProc.Contrast3(Change, Midpoint:integer; DoRed, DoGreen, DoBlue:boolean);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_CONTRAST3, ProcBitmap, mask) then
    exit;
  IEContrast3(ProcBitmap, Change,Midpoint,DoRed,DoGreen,DoBlue, fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// vectorization routines

const
  DEFAULT_CODE_LENGTH=512;
  CONTOUR=2;//'c';
  VISITED=3;//'v';
  BLACK=1;
  WHITE=0;


type

pt2=record
  x,y:integer;
end;
ppt2=^pt2;

TIEChainCode=class
  SCALE:integer;
  code:PAnsiChar;
  alength:integer;  // actual length
  length:integer;
  constructor Create(aSCALE:integer);
  destructor Destroy; override;
  procedure add(c:AnsiChar);
  function postProcess:TIEChainCode;
end;

constructor TIEChainCode.Create(aSCALE:integer);
begin
  inherited Create;
  SCALE:=aSCALE;
  code := allocmem(DEFAULT_CODE_LENGTH * sizeof(AnsiChar));
  code[0] := #0;
  length := DEFAULT_CODE_LENGTH;
  alength := 0;
end;

destructor TIEChainCode.Destroy;
begin
  freemem(code);
  inherited Destroy;
end;

// 2.2.6
procedure TIEChainCode.add(c:AnsiChar);
begin
  if (alength >= length-1) then
  begin
    length := length*2;
    reallocmem(code, length);
  end;
  code[alength] := c;
  inc(alength);
  code[alength] := #0;
end;

function TIEChainCode.postProcess:TIEChainCode;
var
  i, j:integer;
  filtCode:TIEChainCode;
begin
  i:=0;

  filtCode := TIEChainCode.Create(SCALE);
  while (i<alength) do
  begin
    if (i+SCALE-1 < alength) then
    begin
      for j:=0 to SCALE-1-1 do
        if (code[i+j] <> code[i+j+1]) then
          break;
      if (j = SCALE-1) then
      begin
        filtCode.add(code[i]);
        inc(i , SCALE);
        continue;
      end;
    end;

    if (i+SCALE-2 < alength) then
    begin
      for j:=0 to SCALE-2-1 do
        if (code[i+j] <> code[i+j+1]) then
          break;
      if (j = SCALE-2) then
      begin
        inc(i , SCALE-1);
        continue;
      end;
    end;
    filtCode.add(code[i]);
    inc(i);
  end;
  result:=filtCode;
end;

function addPt2(a:ppt2; b:ppt2; c:ppt2):ppt2;
begin
  c^.x := a^.x + b^.x;
  c^.y := a^.y + b^.y;
  result:=c;
end;

function subPt2(a:ppt2; b:ppt2; c:ppt2):ppt2;
begin
  c^.x := a^.x - b^.x;
  c^.y := a^.y - b^.y;
  result:=c;
end;

function IEVectorize(bitmap:TIEMask; x1,y1,x2,y2:integer; SCALE:integer):TList;
const
  contour_dir:array [0..7] of pt2 = (( x:1; y:0),
                (x: 0; y:-1),
                (x:-1; y: 0),
                (x: 0; y: 1),
                (x: 1; y:-1),
                (x:-1; y:-1),
                (x:-1; y: 1),
                (x: 1; y: 1));
var
  code4,tmpcode:TIEChainCode;
  fatmap:pbytearray;
  direction_code:array [0..8-1] of AnsiChar;
  i,j,u,v,l,
  last_dir:integer;
  flag:boolean;
  pixel,
  test_pixel,
  start_pixel:pt2;
  fwidth,fheight:integer;
  pt:PPoint;
  x,y:integer;
  origX,origY:integer;
  fatmap_size:integer;
  pb:pbyte;
  ly,lx:integer;

  function ROW(y:integer):pbyte;
  begin
    result:=pbyte(fatmap);
    inc(result,fwidth*y);
  end;

begin

  result:=TList.Create;

  direction_code[0]:='0';
  direction_code[1]:='2';
  direction_code[2]:='4';
  direction_code[3]:='6';
  direction_code[4]:='1';
  direction_code[5]:='3';
  direction_code[6]:='5';
  direction_code[7]:='7';

  flag:=true;

  fwidth  := 2 + SCALE*(x2-x1+1) + 2;
  fheight := 2 + SCALE*(y2-y1+1) + 2;
  fatmap_size:=fwidth * fheight;
  getmem(fatmap, fatmap_size);
  FillChar(fatmap^,fatmap_size,BLACK);

  case bitmap.BitsPerPixel of
    1:
      begin
        for j:=y1 to y2 do
        begin
          pb:=bitmap.ScanLine[j];
          for i:=x1 to x2 do
          begin
            if pbytearray(pb)^[i shr 3] and iebitmask1[i and $7] <>0 then
            begin
              lx:=2+SCALE*(i-x1);
              ly:=2+SCALE*(j-y1);
              for v:=0 to SCALE-1 do
                for u:=0 to SCALE-1 do
                  fatmap[ lx+u + (ly+v)*fwidth ] := WHITE;
            end;
          end;
        end;
      end;
    8:
      begin
        for j:=y1 to y2 do
        begin
          pb:=bitmap.ScanLine[j]; inc(pb,x1);
          for i:=x1 to x2 do
          begin
            if pb^ <>0 then
            begin
              lx:=2+SCALE*(i-x1);
              ly:=2+SCALE*(j-y1);
              for v:=0 to SCALE-1 do
                for u:=0 to SCALE-1 do
                  fatmap[ lx+u + (ly+v)*fwidth ] := WHITE;
            end;
            inc(pb);
          end;
        end;
      end;
    else
      for j:=y1 to y2 do
        for i:=x1 to x2 do
          if (bitmap.GetPixel(i,j) <>0) then
            for v:=0 to SCALE-1 do
              for u:=0 to SCALE-1 do
                fatmap[ 2+SCALE*(i-x1)+u + (2+SCALE*(j-y1)+v)*fwidth ] := WHITE;
  end;

  for j:=0 to fheight-1 do
  begin
    pb:=ROW(j); inc(pb);
    for i:=1 to fwidth-1 do
    begin
      if (pb^ = BLACK) then
      begin
        if flag then
        begin
          dec(pb);
          pb^ := CONTOUR;
          inc(pb);
          flag := false;
        end
      end
      else
        flag := true;
      inc(pb);
    end;
  end;

  for j:=0 to fheight-1 do
  begin
    pb:=ROW(j); inc(pb,fwidth-2);
    for i:=fwidth - 3 downto 0 do
    begin
      if (pb^ = BLACK) then
      begin
        if flag then
        begin
          inc(pb);
          pb^ := CONTOUR;
          dec(pb);
          flag := false;
        end
      end
      else
        flag := true;
      dec(pb);
    end;
  end;

  // 2.2.6
  flag := true;
  for i:=0 to fwidth-1 do
  begin
    pb:=pbyte(fatmap); inc(pb,i+fwidth);
    for j:=1 to fheight-1 do
    begin
      if (pb^ = BLACK) then
      begin
        if flag then
        begin
          dec(pb,fwidth);
          pb^ := CONTOUR;
          inc(pb,fwidth);

          flag := false;
        end
      end
      else
        flag := true;
      inc(pb,fwidth);
    end;
  end;

  // 2.2.6
  flag := true;
  for i:=0 to fwidth-1 do
  begin
    pb:=pbyte(fatmap); inc(pb,fwidth*(fheight-2)+i);
    for j:=fheight - 3 downto 0 do
    begin
      if (pb^ = BLACK) then
      begin
        if flag then
        begin
          inc(pb,fwidth);
          pb^ := CONTOUR;
          dec(pb,fwidth);
          flag := false;
        end
      end
      else
        flag := true;
      dec(pb,fwidth);
    end;
  end;

  ly:=0;

  code4:=nil;
  while true do
  begin

    code4:=TIEChainCode.Create(SCALE);

    l:=0;
    for j:=ly to fheight-1 do
    begin
      pb:=ROW(j); inc(pb);
      for i:=1 to fwidth-1 do
      begin
        if (pb^=CONTOUR) then
        begin
          start_pixel.x := i;
          start_pixel.y := j;
          ly := j;
          l:=1;
          break;
        end;
        inc(pb);
      end;
      if l=1 then
        break;
    end;

    if l=0 then
      break;

    origX := x1+ (start_pixel.x-2) div SCALE;
    origY := y1+ (start_pixel.y-2) div SCALE;

    pixel.x := start_pixel.x;
    pixel.y := start_pixel.y;

    fatmap[pixel.x+pixel.y*fwidth] := VISITED;  // 2.2.6

    last_dir := 4;
    while true do
    begin
      addPt2(@pixel, @contour_dir[last_dir], @test_pixel);
      if (fatmap[test_pixel.x+test_pixel.y*fwidth] = CONTOUR) then
      begin
        pixel.x := test_pixel.x;
        pixel.y := test_pixel.y;
        fatmap[pixel.x+pixel.y*fwidth] := VISITED;
        code4.add(direction_code[last_dir]);
      end;
      i:=0;
      while i<8 do
      begin
        addPt2(@pixel, @contour_dir[i], @test_pixel);
        if (fatmap[test_pixel.x+test_pixel.y*fwidth] = CONTOUR) then
        begin
          pixel.x := test_pixel.x;
          pixel.y := test_pixel.y;
          fatmap[pixel.x+pixel.y*fwidth] := VISITED;
          code4.add(direction_code[i]);
          last_dir := i;
          break;
        end;
        inc(i);
      end;
      if (i = 8) then
        break;
    end;

    for i:=0 to 7 do
    begin
      subPt2(@start_pixel, @pixel, @test_pixel);
      if (test_pixel.x=contour_dir[i].x) and (test_pixel.y=contour_dir[i].y) then
      begin
        code4.add(direction_code[i]);
        break;
      end;
    end;

    tmpCode := code4.postProcess;
    // put marker
    new(pt);
    pt^.x:=MAXINT;
    pt^.y:=MAXINT;
    result.Add(pt);
    //
    l:=strlen(tmpCode.code);
    x:=origX;
    y:=origY;
    for i:=0 to l-1 do
    begin
      if (i=0) or (i=l-1) or (tmpCode.code[i]<>tmpCode.code[i-1]) then
      begin
        new(pt);
        pt^.x:=x;
        pt^.y:=y;
        result.Add(pt);
      end;
      case tmpCode.code[i] of
        '0': begin inc(x);          end;
        '1': begin inc(x); dec(y);  end;
        '2': begin dec(y);          end;
        '3': begin dec(x); dec(y);  end;
        '4': begin dec(x);          end;
        '5': begin dec(x); inc(y);  end;
        '6': begin inc(y);          end;
        '7': begin inc(x); inc(y);  end;
      end;
    end;
    tmpCode.free;

    FreeAndNil(code4);

  end;

  if assigned(code4) then
    FreeAndNil(code4);

  freemem(fatmap);

  // put final marker (2.2.6)
  new(pt);
  pt^.x:=MAXINT;
  pt^.y:=MAXINT;
  result.Add(pt);

end;

// returns a list (TList) or TRect records (caller must free TList and dispose records)
// Quality (SCALE used in IEVectorize), from 1... (4=suggested)
// possible enhancements:
//  - instead of merge rectangles, merge polygons
//  - better algorithm to discard the background
function IESeparateObjects(Bitmap:TIEBitmap; MergeCommonAreas:boolean; Quality:integer; UseBackgroundColor:boolean; BackgroundColorBegin,BackgroundColorEnd:TRGB):TList;
var
  mask:TIEMask;
  vect:TList;
  i,c,j,t:integer;
  pp1:PPoint;
  x1,y1,x2,y2:integer;
  rects:TList;  // a list of TRect
  pr1,pr2:PRect;
  pxrgb:PRGB;
  pxb,pxs:pbyte;
  mR,mG,mB:integer;

  function compRect(ax1,ay1,ax2,ay2, bx1,by1,bx2,by2:integer):boolean;
  begin
    if MergeCommonAreas then
      result:=_RectXRect(ax1,ay1,ax2,ay2, bx1,by1,bx2,by2)    // must intersect
    else
      result:=_RectPRect(ax1,ay1,ax2,ay2, bx1,by1,bx2,by2)=2; // must be inclusive
  end;

  function FindMergingRect(x1,y1,x2,y2:integer):integer;
  var
    i:integer;
    r:PRect;
  begin
    for i:=0 to rects.Count-1 do
    begin
      r:=PRect(rects[i]);
      if compRect(x1,y1,x2,y2,r^.Left,r^.Top,r^.Right,r^.Bottom) then
      begin
        result:=i;
        exit;
      end;
    end;
    result:=-1;
  end;

begin

  mask:=TIEMask.Create;
  mask.AllocateBits(Bitmap.Width+2,Bitmap.Height+2,8);
  mask.Fill(255);

  // convert bitmap to mask (0 or 255 values)
  case Bitmap.PixelFormat of
    ie1g:
      for i:=0 to Bitmap.Height-1 do
      begin
        pxb:=mask.Scanline[i+1]; inc(pxb);
        pxs:=Bitmap.Scanline[i];
        for j:=0 to Bitmap.Width-1 do
        begin
          if pbytearray(pxs)^[j shr 3] and iebitmask1[j and $7] <>0 then
            pxb^:=255
          else
            pxb^:=0;
          inc(pxb);
        end;
      end;
    ie24RGB:
      begin
        if UseBackgroundColor then
        begin
          for i:=0 to Bitmap.Height-1 do
          begin
            pxrgb:=Bitmap.Scanline[i];
            pxb:=mask.Scanline[i+1]; inc(pxb);
            for j:=0 to Bitmap.Width-1 do
            begin
              with pxrgb^ do
                if (r>=BackgroundColorBegin.r) and (g>=BackgroundColorBegin.g) and (b>=BackgroundColorBegin.b) and
                   (r<=BackgroundColorEnd.r) and (g<=BackgroundColorEnd.g) and (b<=BackgroundColorEnd.b) then
                  pxb^:=0
                else
                  pxb^:=255;
              inc(pxrgb);
              inc(pxb);
            end;
          end;
        end
        else
        begin
          _GetMediaContrastRGB(Bitmap, mR, mG, mB);
          t := (mR * gRedToGrayCoef + mG * gGreenToGrayCoef + mB * gBlueToGrayCoef) div 100;
          for i:=0 to Bitmap.Height-1 do
          begin
            pxrgb:=Bitmap.Scanline[i];
            pxb:=mask.Scanline[i+1]; inc(pxb);
            for j:=0 to Bitmap.Width-1 do
            begin
              with pxrgb^ do
                c := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
              if c>=t then
                pxb^:=255
              else
                pxb^:=0;
              inc(pxrgb);
              inc(pxb);
            end;
          end;
        end;
      end;
    else
      for i:=0 to Bitmap.Height-1 do
      begin
        pxb:=mask.Scanline[i+1]; inc(pxb);
        for j:=0 to Bitmap.Width-1 do
        begin
          with Bitmap.Pixels[j,i] do
            c := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
          if c>=200 then
            pxb^:=255
          else
            pxb^:=0;
          inc(pxb);
        end;
      end;
  end;

  // raster to vect conversion
  vect:=IEVectorize(mask,0,0,mask.Width-1,mask.Height-1,Quality);

  // converts polygons to rectangles (bounding boxes)
  rects:=TList.Create;
  x1:=MAXINT;  y1:=MAXINT;  x2:=-MAXINT;  y2:=-MAXINT;
  c:=0;
  for i:=0 to vect.Count-1 do
  begin
    pp1:=PPoint(vect[i]);
    if pp1^.x=MAXINT then
    begin
      if (c>3) and not ((x1=0) and (y1=0) and (x2=mask.Width-1) and (y2=mask.Height-1)) then
      begin
        j:=FindMergingRect(x1,y1,x2,y2);
        if j=-1 then
        begin
          new(pr1);
          pr1^.Left:=x1; pr1^.Top:=y1; pr1^.Right:=x2; pr1^.Bottom:=y2;
          rects.Add(pr1);
        end
        else
        begin
          pr1:=PRect(rects[j]);
          pr1^.Left:=imin(x1,pr1^.Left);
          pr1^.Top:=imin(y1,pr1^.Top);
          pr1^.Right:=imax(x2,pr1^.Right);
          pr1^.Bottom:=imax(y2,pr1^.Bottom);
        end;
      end;
      x1:=MAXINT;  y1:=MAXINT;  x2:=-MAXINT;  y2:=-MAXINT;
      c:=0;
    end
    else
    begin
      with pp1^ do
      begin
        if x<x1 then x1:=x;
        if y<y1 then y1:=y;
        if x>x2 then x2:=x;
        if y>y2 then y2:=y;
        inc(c);
      end;
    end;
  end;

  // groups intersecting rectangles
  i:=0;
  while i<rects.Count do
  begin
    for j:=i+1 to rects.Count-1 do
    begin
      pr1:=PRect(rects[i]);
      pr2:=PRect(rects[j]);
      if compRect(pr1^.Left,pr1^.Top,pr1^.Right,pr1^.Bottom,pr2^.Left,pr2^.Top,pr2^.Right,pr2^.Bottom) then
      begin
        pr1^.Left:=imin(pr1^.Left,pr2^.Left);
        pr1^.Top:=imin(pr1^.Top,pr2^.Top);
        pr1^.Right:=imax(pr1^.Right,pr2^.Right);
        pr1^.Bottom:=imax(pr1^.Bottom,pr2^.Bottom);
        dispose(pr2);
        rects.Delete(j);
        dec(i);
        break;
      end;
    end;
    inc(i);
  end;

  // remove zero size objects
  i:=0;
  while i<rects.Count do
  begin
    pr1:=PRect(rects[i]);
    if (pr1^.Left>=pr1^.Right-1) or (pr1^.Top>=pr1^.Bottom-1) then
    begin
      dispose(pr1);
      rects.Delete(i);
    end
    else
      inc(i);
  end;

  // remove empty rectangles
  for i:=0 to rects.Count-1 do
    with PRect(rects[i])^ do
    begin
      dec(Right,2);
      dec(Bottom,2);
    end;

  mask.free;
  // free vect
  for i:=0 to vect.Count-1 do
    dispose( PPoint(vect[i]) );
  vect.free;

  result:=rects;

end;


// end of vectorization routines
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
<FS>TImageEnProc.SeparateObjects

<FM>Declaration<FC>
function SeparateObjects(Quality:integer=4; MergeCommonAreas:boolean=true):TList;
function SeparateObjects(Quality:integer; MergeCommonAreas:boolean; BackgroundColorBegin, BackgroundColorEnd:<A TRGB>):TList; overload;

<FM>Description<FN>
SeparateObjects creates a list (TList) of TRect pointers. Each rectangle encloses a found objects.
This method works well to separate photos or simple objects over a white or black background. The background cannot contain a pattern.

Quality specifies the contour search routine definition. Minimum value is 1, suggested is 4. Lower values increases speed, but could not recognize complex objects like characters.
If MergeCommonAreas is true, when two rectangles intersects they are merged. When it is false, two rectangles are merged only if they are inclusive.
BackgroundColorBegin and BackgroundColorEnd specifies the background color range. This helps the function to separate the background and the objects.

You have to free the returned list executing:<FC>
  Rects:=ImageEnView1.Proc.SeparateObjects;
  ..process rects..
  // free rects
  for i:=0 to rects.Count-1 do
    dispose(Prect(rects[i]));
  rects.free;

<FN>Look at imageprocessing1\SeparateObjects example.

<FM>Example<FC>

// draws a red box around each found object
var rects:Tlist;
..
rects:=ImageEnView1.Proc.SeparateObjects;
for i:=0 to rects.Count-1 do
begin
  with PRect(rects[i])^, ImageEnView1.IEBitmap.Canvas do
  begin
    Pen.Color:=clRed;
    Brush.Style:=bsClear;
    Rectangle(Left,Top,Right+1,Bottom+1);
  end;
  dispose(PRect(rects[i]));
end;
rects.free;
ImageEnView1.Update;
!!}
// returns a list (TList) or TRect records (caller must free TList and dispose records)
// Quality (SCALE) from 1... (4=suggested)
function TImageEnProc.SeparateObjects(Quality:integer; MergeCommonAreas:boolean):TList;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  result:=nil;
  if not BeginImageAnalysis([], x1, y1, x2, y2, ProcBitmap, mask) then
    exit;
  result := IESeparateObjects(ProcBitmap,MergeCommonAreas,Quality,false,CreateRGB(0,0,0),CreateRGB(0,0,0));
  EndImageAnalysis(ProcBitmap);
  DoFinishWork;
end;

function TImageEnProc.SeparateObjects(Quality:integer; MergeCommonAreas:boolean; BackgroundColorBegin, BackgroundColorEnd:TRGB):TList;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  result:=nil;
  if not BeginImageAnalysis([], x1, y1, x2, y2, ProcBitmap, mask) then
    exit;
  result := IESeparateObjects(ProcBitmap,MergeCommonAreas,Quality,true,BackgroundColorBegin,BackgroundColorEnd);
  EndImageAnalysis(ProcBitmap);
  DoFinishWork;
end;

procedure TImageEnProc.DoFinishWork;
begin
  if assigned(fOnProgress) then
    fOnProgress(self, 100);
  if assigned(fOnFinishWork) then
    fOnFinishWork(self);
end;

{!!
<FS>TImageEnProc.RotateAndCrop

<FM>Declaration<FC>
procedure RotateAndCrop(Angle:double; antialias: boolean = true; AntialiasMode: <A TIEAntialiasMode> = ierFast);

<FM>Description<FN>
This function rotates the image by Angle (in degrees) and crops the borders of the original bitmap.
It is useful to deskew an image knowing the rotation angle.
Angle must be in the range -90 and +90 degrees. Other parameters are like <A TImageEnProc.Rotate> method.

If you have this image:
<IMG help_images\77.bmp>

You can know the rotation needed to deskew it executing:
<FC>D:=ImageEnView1.Proc.SkewDetection;<FN>

Now you can rotate the image executing <FC>ImageEnView1.Proc.Rotate(D)<FN>, but you get:
<IMG help_images\78.bmp>

The gray border (which is part of the original bitmap) is rotated with the image.
If you need to remove that border you have to execute <FC>ImageEnView1.Proc.RotateAndCrop(D)<FN>, so you will have:
<IMG help_images\79.bmp>
!!}
procedure TImageEnProc.RotateAndCrop(Angle:double; antialias: boolean; AntialiasMode: TIEAntialiasMode);
var
  w,h,nw,nh,mm,ww,hh:integer;
  r,z:double;
  i,j:integer;
  found:boolean;
  cosr,sinr:double;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_ROTATEANDCROP, ieuImage);

  w:=fIEBitmap.width;
  h:=fIEBitmap.height;
  Rotate(Angle, antialias, AntialiasMode);
  r:=abs(Angle*PI/180);
  cosr:=cos(r);
  sinr:=sin(r);
  mm:=trunc(sqrt( w*w+h*h )); // rectangle's diagonal
  nw:=0;
  nh:=0;
  found:=false;
  for i:=1 to mm do
  begin
    for j:=1 to mm do
    begin
      z:=i/j;
      ww:=trunc(i*cosr+(i/z)*sinr);
      hh:=trunc(j*cosr+(j*z)*sinr);
      if ((ww=w) or (ww=w-1) or (ww=w+1)) and ((hh=h) or (hh=h-1) or (hh=h+1)) then
      begin
        nw:=i;
        nh:=j;
        found:=true;
        break;
      end;
    end;
    if found then
      break;
  end;
  ImageResize(nw,nh,iehCenter,ievCenter); // calls Update and FinishWork

end;

{!!
<FS>TImageEnProc.Deinterlace

<FM>Declaration<FC>
procedure Deinterlace(mode:<A TIEDeinterlaceMode>);

<FM>Description<FN>
Deinterlaces current image with the specified algorithm.
!!}
procedure TImageEnProc.Deinterlace(mode:TIEDeinterlaceMode);
var
  row,col:integer;
  w,h:integer;
  px1,px2:PRGB;
  i1,i2:integer;
  d:double;
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_DEINTERLACE, ieuImage);

  case mode of
    iedDiscard:
      begin
        // just discard one row every two
        row:=fIEBitmap.Height-1;
        while row>1 do
        begin
          CopyMemory( fIEBitmap.Scanline[row-1], fIEBitmap.Scanline[row], fIEBitmap.Rowlen );
          dec(row,2);
        end;
      end;
    iedIntelliMerge:
      begin
        // merge only if the two fields are similar (less movement)
        w:=fIEBitmap.Width;
        h:=fIEBitmap.Height;
        d:=0;
        row:=0;
        while row<h-2 do
        begin
          px1:=fIEBitmap.Scanline[row];
          px2:=fIEBitmap.Scanline[row+1];
          for col:=0 to w-1 do
          begin
            with px1^ do
              i1 := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            with px2^ do
              i2 := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
            d:=d+sqrt(sqr(i1-i2));
            inc(px1);
            inc(px2);
          end;
          inc(row,2);
        end;
        d:=d / (w*h);
        if d>5 then
          Deinterlace(iedDiscard)
        else
        begin
          beep;
        end;
      end;
  end;

  DoFinishWork;
  Update;

end;

// output will ie8g or ie24RGB (when locaton is ieTBitmap)
// doesn't produce a black/white edge map (suggested _ConvertToBWThreshold(-2))
procedure IESobel(bitmap:TIEBitmap; OnProgress: TIEProgressEvent; Sender: TObject);
var
	i,j,n,m:integer;
	x:TIEBitmap;
  w,h:integer;
  p1:pbyte;
  p2:PRGB;
  i0,i1,i2,i3,i4,i5,i6,i7:pbyte;
begin

  w:=bitmap.Width;
  h:=bitmap.Height;

  x:=TIEBitmap.Create(w,h,ie8g);
  x.CopyAndConvertFormat(bitmap);

  if bitmap.Location=ieTBitmap then
  begin
    // out is ie24RGB
    bitmap.Allocate(w,h,ie24RGB);
    bitmap.Fill(0); // to clear unset areas (left,top,right,bottom borders)
    for i:=1 to h-2 do
    begin
      p2:=bitmap.Scanline[i]; inc(p2);
      i0:=x.Scanline[i-1]; inc(i0,2); // j+1, i-1
      i1:=x.Scanline[i]; inc(i1,2);   // j+1, i
      i2:=x.Scanline[i+1]; inc(i2,2); // j+1, i+1
      i3:=x.Scanline[i-1]; // j-1, i-1
      i4:=x.Scanline[i];   // j-1, i
      i5:=x.Scanline[i+1]; // j-1, i+1
      i6:=x.Scanline[i+1]; inc(i6); // j, i+1
      i7:=x.Scanline[i-1]; inc(i7); // j, i-1
      for j:=1 to w-2 do
      begin
        n := (i0^ + 2*i1^ + i2^) -
             (i3^ + 2*i4^ + i5^);
        m := (i5^ + 2*i6^ + i2^) -
             (i3^ + 2*i7^ + i0^);
        with p2^ do
        begin
          r := trunc( sqrt( (n*n + m*m) )/4 );
          g := r;
          b := r;
        end;
        inc(p2);
        inc(i0); inc(i1); inc(i2); inc(i3); inc(i4); inc(i5); inc(i6); inc(i7);
      end;
      if assigned(OnProgress) then
        OnProgress(Sender, trunc(i/h*100) );
    end;
  end
  else
  begin
    // out is ie8g
    bitmap.Allocate(w,h,ie8g);
    bitmap.Fill(0); // to clear unset areas (left,top,right,bottom borders)
    for i:=1 to h-2 do
    begin
      p1:=bitmap.Scanline[i]; inc(p1);
      i0:=x.Scanline[i-1]; inc(i0,2); // j+1, i-1
      i1:=x.Scanline[i]; inc(i1,2);   // j+1, i
      i2:=x.Scanline[i+1]; inc(i2,2); // j+1, i+1
      i3:=x.Scanline[i-1]; // j-1, i-1
      i4:=x.Scanline[i];   // j-1, i
      i5:=x.Scanline[i+1]; // j-1, i+1
      i6:=x.Scanline[i+1]; inc(i6); // j, i+1
      i7:=x.Scanline[i-1]; inc(i7); // j, i-1
      for j:=1 to w-2 do
      begin
        n := (i0^ + 2*i1^ + i2^) -
             (i3^ + 2*i4^ + i5^);
        m := (i5^ + 2*i6^ + i2^) -
             (i3^ + 2*i7^ + i0^);
        p1^ := trunc( sqrt( (n*n + m*m) )/4 );
        inc(p1);
        inc(i0); inc(i1); inc(i2); inc(i3); inc(i4); inc(i5); inc(i6); inc(i7);
      end;
      if assigned(OnProgress) then
        OnProgress(Sender, trunc(i/h*100) );
    end;
  end;

  x.free;
end;

{!!
<FS>TImageEnProc.EdgeDetect_Sobel

<FM>Declaration<FC>
procedure EdgeDetect_Sobel;

<FM>Description<FN>
Performs an edge detect using Sobel filter.
The result is a gray scale bitmap: high values (closed to 255) are edges.
When <A TIEBitmap.Location> is ieTBitmap, the output pixel format is i24RGB, otherwise it is ie8g.
To make result black/white (with 1=edge) it is suggested to call <A TImageEnProc.ConvertToBWThreshold> using parameter -2 (Maximum Entropy Algorithm).

<FM>Example<FC>
ImageEnView1.Proc.EdgeDetect_Sobel;
ImageEnView1.proc.ConvertToBWThreshold(-2);
!!}
procedure TImageEnProc.EdgeDetect_Sobel;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_EDGEDETECT_SOBEL, ieuImage);
  IESobel(fIEBitmap,fOnProgress,self);
  Update;
  DoFinishWork;
end;

function TImageEnProc.GetDPIX:integer;
begin
  if assigned(fImageEnView) then
    result:=fImageEnView.DpiX
  else
    result:=gDefaultDPIX;
end;

function TImageEnProc.GetDPIY:integer;
begin
  if assigned(fImageEnView) then
    result:=fImageEnView.DpiY
  else
    result:=gDefaultDPIY;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Local adaptation tone mapping
// by Irwin Scollar

const NaN=0.0/0.0;

type TISCommonData = record
  filter: array[0..6] of double;
  M: array[0..8] of double;
  MeanLuminance2: double;
  pr:TProgressRec;
end;

function ISMakeLuminanceBitmap(var context:TISCommonData; SourceBitmap: TIEBitmap):TIEBitmap;
const
  one255 = 1 / 255;
var
  x, y: integer;
  Source: pRGB;
  Luminance: pSingle;
  w1, h1: integer;
  YY, Cb, Cr: Integer;
  MeanLuminance: double;
begin

  with context do
  begin

    result := TIEBitmap.Create(SourceBitmap.Width, SourceBitmap.Height, ie32f);
    result.Fill(0);
    w1 := result.Width - 1;
    h1 := result.Height - 1;
    MeanLuminance := 0.0;

    for y := 0 to h1 do
    begin
      Source := SourceBitmap.ScanLine[y];
      Luminance := result.Scanline[y];

      for x := 0 to w1 do
      begin
        IERGB2YCbCr(Source^, YY, Cb, Cr);
        Luminance^ := YY * one255;
        MeanLuminance := MeanLuminance + Luminance^;
        inc(Source);
        inc(Luminance);
      end;

      if assigned(pr.fOnProgress) then
        pr.fOnProgress(pr.Sender, pr.tot+trunc(y/h1*pr.per1*100) );

    end;

    MeanLuminance2 := (0.5 * MeanLuminance) / (w1 * h1);

    inc(pr.tot,trunc(pr.per1*100));
  end;
end;

procedure ISTriggsM(var context:TISCommonData);
var
  scale: double;
  a1, a2, a3: double;

begin

  with context do
  begin

    a3 := filter[0];
    a2 := filter[1];
    a1 := filter[2];

    scale := 1.0 / ((1.0 + a1 - a2 + a3) * (1.0 - a1 - a2 - a3) * (1.0 + a2 + (a1 - a3) * a3));
    M[0] := scale * (-a3 * a1 + 1.0 - a3 * a3 - a2);
    M[1] := scale * (a3 + a1) * (a2 + a3 * a1);
    M[2] := scale * a3 * (a1 + a3 * a2);
    M[3] := scale * (a1 + a3 * a2);
    M[4] := -scale * (a2 - 1.0) * (a2 + a3 * a1);
    M[5] := -scale * a3 * (a3 * a1 + a3 * a3 + a2 - 1.0);
    M[6] := scale * (a3 * a1 + a2 + a1 * a1 - a2 * a2);
    M[7] := scale * (a1 * a2 + a3 * a2 * a2 - a1 * a3 * a3 - a3 * a3 * a3 - a3 * a2 + a3);
    M[8] := scale * a3 * (a1 + a3 * a2);

  end;
end;

procedure ISYvVfilterCoef(var context:TISCommonData; sigma: double);
const
  m0 = 1.16680;
  m1 = 1.10783;
  m2 = 1.40586;
  m1sq = m1 * m1;
  m2sq = m2 * m2;
var
  q, qsq,
  scale,
  B, b1, b2, b3: double;
begin

  with context do
  begin

    if (sigma < 3.556) then
      q := -0.2568 + 0.5784 * sigma + 0.0561 * sigma * sigma
    else
      q := 2.5091 + 0.9804 * (sigma - 3.556);

    qsq := q * q;

    scale := (m0 + q) * (m1sq + m2sq + 2 * m1 * q + qsq);
    b1 := -q * (2 * m0 * m1 + m1sq + m2sq + (2 * m0 + 4 * m1) * q + 3 * qsq) / scale;
    b2 := qsq * (m0 + 2 * m1 + 3 * q) / scale;
    b3 := -qsq * q / scale;

    B := (m0 * (m1sq + m2sq)) / scale;

    filter[0] := -b3;
    filter[1] := -b2;
    filter[2] := -b1;
    filter[3] := B;
    filter[4] := -b1;
    filter[5] := -b2;
    filter[6] := -b3;

  end;
end;

function ISGaussX(var context:TISCommonData; SourceBitmap: TIEBitmap):TIEBitmap;
var
  x, y: integer;
  w1, h1: integer;
  sum, sumsq, b1, b2, b3, iplus, uplus, vplus, unp, unp1, unp2,
  pix, p1, p2, p3: double;
  Source, Dest: psingle;
  denom1, denom2: double;
begin

  with context do
  begin

    w1 := SourceBitmap.Width - 1;
    h1 := SourceBitmap.Height - 1;
    result := TIEBitmap.Create(SourceBitmap.Width, SourceBitmap.Height, ie32f);
    result.Fill(0);

    sumsq := filter[3];
    sum := sumsq * sumsq;

    for y := 0 to h1 do
    begin
      Source := SourceBitmap.ScanLine[y];
      Dest := result.ScanLine[y];
      b1 := filter[2];
      b2 := filter[1];
      b3 := filter[0];
      denom1 := 1 / (1.0 - b1 - b2 - b3);
      p1 := Source^ / sumsq;
      p2 := p1;
      p3 := p1;
      for x := 0 to w1 do
      begin
        pix := Source^ + b1 * p1 + b2 * p2 + b3 * p3;
        dest^ := pix;
        p3 := p2;
        p2 := p1;
        p1 := pix;
        inc(Source);
        inc(Dest);
      end;

      dec(Source, 3);
      iplus := Source^;
      dec(Dest);

      uplus := iplus * denom1;
      b1 := filter[4];
      b2 := filter[5];
      b3 := filter[6];
      denom2 := 1 / (1.0 - b1 - b2 - b3);
      vplus := uplus * denom2;

      unp := p1 - uplus;
      unp1 := p2 - uplus;
      unp2 := p3 - uplus;

      pix := sum * (M[0] * unp + M[1] * unp1 + M[2] * unp2 + vplus);
      p1 := sum * (M[3] * unp + M[4] * unp1 + M[5] * unp2 + vplus);
      p2 := sum * (M[6] * unp + M[7] * unp1 + M[8] * unp2 + vplus);

      dest^ := pix;
      dec(Dest);
      p3 := p2;
      p2 := p1;
      p1 := pix;

      for x := w1 - 2 downto 0 do
      begin
        pix := sum * dest^ + b1 * p1 + b2 * p2 + b3 * p3;
        dest^ := pix;
        p3 := p2;
        p2 := p1;
        p1 := pix;
        dec(Dest);
      end;

      if assigned(pr.fOnProgress) then
        pr.fOnProgress(pr.Sender, pr.tot+trunc(y/h1*pr.per1*100) );

    end;

    inc(pr.tot,trunc(pr.per1*100));

  end;

end;

function ISGaussY(var context:TISCommonData; SourceBitmap: TIEBitmap):TIEBitmap;
var
  x, y: integer;
  w1, h1: integer;
  sum, sumsq, b1, b2, b3, iplus, uplus, vplus,
    onesumsq, unp, unp1, unp2, pix, denom1: double;
  buf0, buf1, buf2, buf3: psinglearray;
  p0, p1, p2, p3: psinglearray;
  pswap: psinglearray;
  uplusbuf: psinglearray;
  Source, Dest: psingle;
  bufsize: integer;
  MeanLuminance: double;
begin

  with context do
  begin

    dest:=nil;

    w1 := SourceBitmap.Width - 1;
    h1 := SourceBitmap.Height - 1;

    result := TIEBitmap.Create(SourceBitmap.Width, SourceBitmap.Height, ie32f);
    result.Fill(0);

    sumsq := filter[3];
    onesumsq := 1 / sumsq;
    sum := sumsq * sumsq;
    MeanLuminance := MeanLuminance2;

    bufsize := SourceBitmap.Width * sizeof(single);
    GetMem(buf0, bufsize);
    GetMem(buf1, bufsize);
    GetMem(buf2, bufsize);
    GetMem(buf3, bufsize);
    GetMem(uplusbuf, bufsize);
    p0 := buf0;
    p1 := buf1;
    p2 := buf2;
    p3 := buf3;

    b1 := filter[2];
    b2 := filter[1];
    b3 := filter[0];

    Source := SourceBitmap.ScanLine[0];
    for x := 0 to w1 do
    begin
      pix := Source^ * onesumsq;
      inc(Source);
      p1[x] := pix;
      p2[x] := pix;
      p3[x] := pix;
    end;

    denom1 := 1 / (1.0 - b1 - b2 - b3);
    Source := SourceBitmap.ScanLine[h1];
    for x := 0 to w1 do
    begin
      uplusbuf[x] := Source^ * denom1;
      inc(Source);
    end;

    for y := 0 to h1 do
    begin
      Source := SourceBitmap.ScanLine[y];
      Dest := result.ScanLine[y];
      for x := 0 to w1 do
      begin
        pix := Source^ + b1 * p1[x] + b2 * p2[x] + b3 * p3[x];
        inc(Source);
        dest^ := pix;
        inc(Dest);
        p0[x] := pix;
      end;

      pswap := p3;
      p3 := p2;
      p2 := p1;
      p1 := p0;
      p0 := pswap;

      if assigned(pr.fOnProgress) then
        pr.fOnProgress(pr.Sender, pr.tot+trunc(y/h1*pr.per1*100) );

    end;
    inc(pr.tot,trunc(pr.per1*100));

    b1 := filter[4];
    b2 := filter[5];
    b3 := filter[6];

    p0 := uplusbuf;
    denom1 := 1 / (1.0 - b1 - b2 - b3);

    for x := w1 downto 0 do
    begin
      uplus := p0[x];
      vplus := uplus * denom1;

      unp := p1[x] - uplus;
      unp1 := p2[x] - uplus;
      unp2 := p3[x] - uplus;

      pix := M[0] * unp + M[1] * unp1 + M[2] * unp2 + vplus;
      pix := pix + sum;

      dec(Dest);
      Dest^ := pix;

      p1[x] := pix;

      pix := M[3] * unp + M[4] * unp1 + M[5] * unp2 + vplus;
      p2[x] := pix * sum;

      pix := M[6] * unp + M[7] * unp1 + M[8] * unp2 + vplus;
      p3[x] := pix * sum;
    end;

    for y := h1 - 2 downto 0 do
    begin
      Dest := result.ScanLine[y];
      inc(Dest, w1);
      for x := w1 downto 0 do
      begin
        pix := sum * dest^ + b1 * p1[x] + b2 * p2[x] + b3 * p3[x];
        dest^ := pix + MeanLuminance;
        dec(Dest);
        p0[x] := pix;
      end;

      pswap := p3;
      p3 := p2;
      p2 := p1;
      p1 := p0;
      p0 := pswap;

      if assigned(pr.fOnProgress) then
        pr.fOnProgress(pr.Sender, pr.tot+trunc((h1-y)/h1*pr.per1*100) );
    end;
    inc(pr.tot,trunc(pr.per1*100));

    FreeMem(buf0);
    FreeMem(buf1);
    FreeMem(buf2);
    FreeMem(buf3);
    FreeMem(uplusbuf);

  end;
end;

function ISNRprocess(var context:TISCommonData; InputBitmap, X0Bitmap: TIEBitmap):TIEBitmap;
var
  x, y: integer;
  w1, h1: integer;
  Input, X0, NR: pSingle;
  NewInputMean2: double;
begin

  with context do
  begin

    w1 := InputBitmap.Width - 1;
    h1 := InputBitmap.Height - 1;
    result := TIEBitmap.Create(InputBitmap.Width, InputBitmap.Height, ie32f);
    result.Fill(0);

    NewInputMean2 := 0.0;

    for y := 0 to h1 do
    begin
      Input := InputBitmap.ScanLine[y];
      X0 := X0Bitmap.ScanLine[y];
      NR := result.Scanline[y];
      for x := 0 to w1 do
      begin
        if ((Input^ + X0^) > 0) then
        begin
          NR^ := ((1 + x0^) * Input^) / (Input^ + X0^);
          NewInputMean2 := NewInputMean2 + NR^;
        end;
        inc(Input);
        inc(X0);
        inc(NR);
      end;
      if assigned(pr.fOnProgress) then
        pr.fOnProgress(pr.Sender, pr.tot+trunc(y/h1*pr.per1*100) );
    end;
    inc(pr.tot,trunc(pr.per1*100));
    MeanLuminance2 := (0.5 * NewInputMean2) / (w1 * h1);

  end;
end;

procedure ISBuildLUT(AValue: double; var LUT:array of byte);
var
  C1: integer;
begin
  for C1 := 0 to 255 do
    LUT[C1] := blimit(Round(iepower(C1 / 255, 1 / AValue) * 255));
end;

function ISRestoreChrominance(var context:TISCommonData; Gamma: double; Gamma2:double; SourceBitmap: TIEBitmap; LuminanceBitmap, NRBitmap: TIEBitmap):TIEBitmap;
const
  one255 = 1 / 255;
var
  x, y: integer;
  Source, Target: pRGB;
  NR: pSingle;
  Lum: pSingle;
  w1, h1: integer;
  GammaLUT,GammaLUT2: array[0..255] of byte;
  Ratio: double;
  LUTSource: TRGB;
  Ygamma: double;

begin

  with context do
  begin

    ISBuildLUT(Gamma,GammaLUT);
    GammaLUT[0] := 1;

    ISBuildLUT(Gamma2,GammaLUT2);

    w1 := NRBitmap.Width - 1;
    h1 := NRBitmap.Height - 1;
    result := TIEBitmap.Create(SourceBitmap.Width, SourceBitmap.Height, ie24RGB);

    for y := 0 to h1 do
    begin
      Source := SourceBitmap.ScanLine[y];
      NR := NRBitmap.ScanLine[y];
      Lum := LuminanceBitmap.ScanLine[y];
      Target := result.Scanline[y];

      for x := 0 to w1 do
      begin
        LUTSource.r := GammaLUT[Source^.r];
        LUTSource.g := GammaLUT[Source^.g];
        LUTSource.b := GammaLUT[Source^.b];

        YGamma := GammaLUT[trunc(Lum^ * 255)];
        Ratio := (NR^ * 255) / YGamma;

        Target^.r := GammaLUT2[blimit(trunc(LUTSource.r * ratio))];
        Target^.g := GammaLUT2[blimit(trunc(LUTSource.g * ratio))];
        Target^.b := GammaLUT2[blimit(trunc(LUTSource.b * ratio))];

        inc(Source);
        inc(Lum);
        inc(NR);
        inc(Target);
      end;

      if assigned(pr.fOnProgress) then
        pr.fOnProgress(pr.Sender, pr.tot+trunc(y/h1*pr.per1*100) );
    end;
    inc(pr.tot,trunc(pr.per1*100));

  end;

end;

procedure IELuminanceEnhancement(Bitmap: TIEBitmap; Gamma:double; Saturation:integer; OnProgress: TIEProgressEvent; Sender: TObject);
var
  context:TISCommonData;
  LuminanceBitmap: TIEBitmap;
  X0Bitmap, X1Bitmap, X01Bitmap, X02Bitmap, NRBitmap, NR2Bitmap: TIEBitmap;
  r:TIEBitmap;
begin
  with context do
  begin

    pr.fOnProgress:=OnProgress;
    pr.Sender:=Sender;
    pr.val:=0;

    FillChar(Filter, SizeOf(Filter), #0);
    FillChar(M, SizeOf(M), #0);

    Bitmap.Resize(Bitmap.Width+8,Bitmap.Height+8,0.5,255,iehRight,ievTop);

    pr.tot:=0;
    pr.per1:=0.09;
    LuminanceBitmap:=ISMakeLuminanceBitmap(context, Bitmap);

    ISYvVfilterCoef(context, 3.0);
    ISTriggsM(context);

    X1Bitmap:=ISGaussX(context, LuminanceBitmap);
    X0Bitmap:=ISGaussY(context, X1Bitmap);
    X1Bitmap.Free;

    NRBitmap:=ISNRprocess(context, LuminanceBitmap, X0Bitmap);
    X0Bitmap.Free;

    ISYvVfilterCoef(context, 1.5);
    ISTriggsM(context);

    X01Bitmap:=ISGaussX(context, NRBitmap);
    X02Bitmap:=ISGaussY(context, X01Bitmap);
    X01Bitmap.Free;

    NR2Bitmap:=ISNRprocess(context, NRBitmap, X02Bitmap);
    NRBitmap.Free;
    X02Bitmap.Free;

    r:=ISRestoreChrominance(context, 2.2, Gamma, Bitmap, LuminanceBitmap, NR2Bitmap);
    LuminanceBitmap.Free;
    NR2Bitmap.Free;

    IEAdjustSaturation(r, Saturation, pr);
    r.Resize(r.Width-8,r.Height-8,0.5,255,iehRight,ievTop);

    Bitmap.Assign(r);
    r.Free;

  end;

end;

{!!
<FS>TImageEnProc.AutoImageEnhance3


<FM>Declaration<FC>
procedure AutoImageEnhance3(Gamma:double; Saturation:integer);

<FM>Description<FN>
Enhances luminosity applying a local adaptation tone mapping algorithm (thanks to Prof. Irwin Scollar).
<FC>Gamma<FN> adjusts resulting luminosity. Allowed values >0
<FC>Saturation<FN> adjusts color saturation and allows values from -100 to 100.

<FM>Example<FC>
ImageEnView1.Proc.AutoImageEnhance3;
!!}
procedure TImageEnProc.AutoImageEnhance3(Gamma:double; Saturation:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_AUTOIMAGEENHANCE3, [Gamma, Saturation]), ProcBitmap, mask) then
    exit;
  IELuminanceEnhancement(ProcBitmap,Gamma,Saturation,fOnProgress,self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


// end of "Local adaptation tone mapping"
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////

(*
function IEGetVisibleArea(Bitmap:TIEBitmap; OnProgress: TIEProgressEvent; Sender: TObject):TRect;
var
  x,y:integer;
  pb:pbyte;
  w,h:integer;
begin
  w:=Bitmap.Width;
  h:=Bitmap.Height;
  with result do
    if Bitmap.HasAlphaChannel then
    begin
      Left:=w-1;
      Top:=h-1;
      Right:=0;
      Bottom:=0;
      for y:=0 to h-1 do
      begin
        pb:=Bitmap.AlphaChannel.Scanline[y];
        for x:=0 to w-1 do
        begin
          if pb^>0 then
          begin
            if x<Left then
              Left:=x;
            if x>Right then
              Right:=x;
            if y<Top then
              Top:=y;
            if y>Bottom then
              Bottom:=y;
          end;
          inc(pb);
        end;
        if assigned(OnProgress) then
          OnProgress(Sender, trunc(y/h*100) );
      end;
    end
    else
      begin
        Left:=0;
        Top:=0;
        Right:=w-1;
        Bottom:=h-1;
      end;
end;
//*)
//(*
function IEGetVisibleArea(Bitmap:TIEBitmap; OnProgress: TIEProgressEvent; Sender: TObject):TRect;
var
  x,y:integer;
  pb:pbyte;
  w,h:integer;
  endloop:boolean;
begin
  w:=Bitmap.Width;
  h:=Bitmap.Height;
  with result do
  begin
    Left:=0;
    Top:=0;
    Right:=w-1;
    Bottom:=h-1;
    if Bitmap.HasAlphaChannel then
    begin
      // left
      endloop:=false;
      while Left<w do
      begin
        for y:=0 to h-1 do
        begin
          pb:=Bitmap.AlphaChannel.Scanline[y];
          inc(pb,Left);
          if pb^>0 then
          begin
            endloop:=true;
            break;
          end;
        end;
        if endloop then
          break;
        inc(Left);
      end;
      // right
      endloop:=false;
      while Right>=0 do
      begin
        for y:=0 to h-1 do
        begin
          pb:=Bitmap.AlphaChannel.Scanline[y];
          inc(pb,Right);
          if pb^>0 then
          begin
            endloop:=true;
            break;
          end;
        end;
        if endloop then
          break;
        dec(Right);
      end;
      // top
      endloop:=false;
      while Top<h do
      begin
        pb:=Bitmap.AlphaChannel.Scanline[Top];
        for x:=0 to w-1 do
        begin
          if pb^>0 then
          begin
            endloop:=true;
            break;
          end;
          inc(pb);
        end;
        if endloop then
          break;
        inc(Top);
      end;
      // bottom
      endloop:=false;
      while Bottom>=0 do
      begin
        pb:=Bitmap.AlphaChannel.Scanline[Bottom];
        for x:=0 to w-1 do
        begin
          if pb^>0 then
          begin
            endloop:=true;
            break;
          end;
          inc(pb);
        end;
        if endloop then
          break;
        dec(Bottom);
      end;
    end;
  end;
end;
//*)

{!!
<FS>TImageEnProc.CutTransparentBorder

<FM>Declaration<FC>
procedure CutTransparentBorder;

<FM>Description<FN>
Removes transparent border, resizing the resulting image to the visible rectangle.
!!}
procedure TImageEnProc.CutTransparentBorder;
var
  r:TRect;
  lAutoUndo:boolean;
begin
  if not MakeConsistentBitmap([]) then
    exit;
  r:=IEGetVisibleArea(fIEBitmap,nil,nil);
  lAutoUndo:=fAutoUndo;
  fAutoUndo:=false;
  Crop(r);
  fautoUndo:=lAutoUndo;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TEA Tiny Encryption Algorithm

procedure IETEAEncipher64(v,w,k:pdwordarray);
var
  y,z,sum,delta,a,b,c,d,n:cardinal;
begin
  y:=v[0];
  z:=v[1];
  sum:=0;
  delta:=$9E3779B9;
  a:=k[0];
  b:=k[1];
  c:=k[2];
  d:=k[3];
  for n:=32 downto 1 do
  begin
    inc(sum , delta);
    inc(y , (z shl 4)+a xor z+sum xor (z shr 5)+b);
    inc(z , (y shl 4)+c xor y+sum xor (y shr 5)+d);
  end;
  w[0]:=y;
  w[1]:=z;
end;

procedure IETEADecipher64(v,w,k:pdwordarray);
var
  y,z,sum,delta,a,b,c,d,n:cardinal;
begin
  y:=v[0];
  z:=v[1];
  sum:=$C6EF3720;
  delta:=$9E3779B9;
  a:=k[0];
  b:=k[1];
  c:=k[2];
  d:=k[3];
  for n:=32 downto 1 do
  begin
    dec(z , (y shl 4)+c xor y+sum xor (y shr 5)+d );
    dec(y , (z shl 4)+a xor z+sum xor (z shr 5)+b );
    dec( sum , delta );
  end;
  w[0]:=y;
  w[1]:=z;
end;

// for sizes or exceeds less than 64 (22 pixels in RGB) width uses XOR, otherwise uses TEA algorithm
procedure IEEncipherBitmap(Bitmap:TIEBitmap; key:pdwordarray; OnProgress: TIEProgressEvent; Sender: TObject);
var
  row,col,i,c:integer;
  ww,hh:integer;
  pb:pbyte;
  buf:pbytearray;
begin
  getmem(buf,8);
  ww:=IEBitmapRowlen(Bitmap.Width, Bitmap.BitCount, 8);
  hh:=Bitmap.Height;
  for row:=0 to hh-1 do
  begin
    pb:=Bitmap.Scanline[row];
    col:=0;
    while col<ww do
    begin
      c:=imin(8,ww-col);
      CopyMemory(buf,pb,c);
      if c<8 then
      begin
        for i:=0 to c-1 do
          buf[i]:=buf[i] xor pbytearray(key)[i];
      end
      else
        IETEAEncipher64(pdwordarray(buf),pdwordarray(buf),key );
      CopyMemory(pb,buf,c);
      inc(pb,c);
      inc(col,c);
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(row/hh*100));
  end;
  freemem(buf);
end;

procedure IEDecipherBitmap(Bitmap:TIEBitmap; key:pdwordarray; OnProgress: TIEProgressEvent; Sender: TObject);
var
  row,col,i,c:integer;
  ww,hh:integer;
  pb:pbyte;
  buf:pbytearray;
begin
  getmem(buf,8);
  ww:=IEBitmapRowlen(Bitmap.Width,Bitmap.BitCount,8);
  hh:=Bitmap.Height;
  for row:=0 to hh-1 do
  begin
    pb:=Bitmap.Scanline[row];
    col:=0;
    while col<ww do
    begin
      c:=imin(8,ww-col);
      CopyMemory(buf,pb,c);
      if c<8 then
      begin
        for i:=0 to c-1 do
          buf[i]:=buf[i] xor pbytearray(key)[i];
      end
      else
        IETEADecipher64(pdwordarray(buf),pdwordarray(buf),key );
      CopyMemory(pb,buf,c);
      inc(pb,c);
      inc(col,c);
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(row/hh*100));
  end;
  freemem(buf);
end;

{!!
<FS>TImageEnProc.Encrypt

<FM>Declaration<FC>
procedure Encrypt(Passkey:AnsiString);
procedure Encrypt(Passkey:array of byte);

<FM>Description<FN>
This function encrypts current image (layer).
The image should be saved using lossless formats and in full rgb color spaces (no palette).
To decrypt use <A TImageEnProc.Decrypt>.
The algorithm used is TEA Tiny Encryption Algorithm with a key of 128 bits.
Using PassKey as a string you should specify a string password, which will be hashed to a 128 bits key.
Using PassKey as array of bytes you should specify a binary key of 16 bytes.
There is no way to know when an image is crypted, unless you insert special tags (like EXIF or IPTC) manually.

<FM>Example<FC>
ImageEnView1.IO.LoadFromFile('input.jpg');
ImageEnView1.Proc.Encrypt('captiva');
ImageEnView1.IO.SaveToFile('crypted.png');

<FM>Demo<FC>
imageprocessing2\encrypt
!!}
procedure TImageEnProc.Encrypt(Passkey:array of byte);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_ENCRYPT, ieuImage);
  IEEncipherBitmap(fIEBitmap, pdwordarray(@Passkey[0]), fOnProgress, self);
  if fIEBitmap.HasAlphaChannel then
    IEEncipherBitmap(fIEBitmap.AlphaChannel, pdwordarray(@Passkey[0]), fOnProgress, self);
  Update;
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.Decrypt

<FM>Declaration<FC>
procedure Decrypt(Passkey:AnsiString);
procedure Decrypt(Passkey:array of byte);

<FM>Description<FN>
This function decrypts current image (layer), crypted using <A TImageEnProc.Encrypt>.
The algorithm used is TEA Tiny Encryption Algorithm with a key of 128 bits.
Using PassKey as a string you should specify a string password, which will be hashed to a 128 bits key.
Using PassKey as array of bytes you should specify a binary key of 16 bytes.

<FM>Example<FC>
ImageEnView1.IO.LoadFromFile('crypted.png');
ImageEnView1.Proc.Decrypt('captiva');

<FM>Demo<FC>
imageprocessing2\encrypt
!!}
procedure TImageEnProc.Decrypt(Passkey:array of byte);
begin
  if not MakeConsistentBitmap([]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_DECRYPT, ieuImage);
  IEDecipherBitmap(fIEBitmap, pdwordarray(@Passkey[0]), fOnProgress, self);
  if fIEBitmap.HasAlphaChannel then
    IEDecipherBitmap(fIEBitmap.AlphaChannel, pdwordarray(@Passkey[0]), fOnProgress, self);
  Update;
  DoFinishWork;
end;

procedure IECreatePasskey(Passkey:AnsiString; var key:array of byte);
var
  i:integer;
  pd:pdwordarray;
begin
  pd:=@(key[0]);
  for i:=0 to 3 do
    pd[i] := 0;
  for i:=1 to length(Passkey) do
  begin
    pd[0] := ord(Passkey[i]) + (pd[0] shl 3) + (pd[0] shl 13) - pd[0];
    pd[1] := ord(Passkey[i]) + (pd[1] shl 4) + (pd[1] shl 14) - pd[1];
    pd[2] := ord(Passkey[i]) + (pd[2] shl 5) + (pd[2] shl 15) - pd[2];
    pd[3] := ord(Passkey[i]) + (pd[3] shl 6) + (pd[3] shl 16) - pd[3];
  end;
end;

procedure TImageEnProc.Encrypt(Passkey:AnsiString);
var
  key:array [0..15] of byte;  // 128 bit generated key
begin
  IECreatePasskey(Passkey,key);
  Encrypt(key);
end;

procedure TImageEnProc.Decrypt(Passkey:AnsiString);
var
  key:array [0..15] of byte;  // 128 bit generated key
begin
  IECreatePasskey(Passkey,key);
  Decrypt(key);
end;


// End of TEA Tiny Encryption Algorithm
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function IEGraphFilterToString(filter:TGraphFilter):string;
var
  i,j:integer;
begin
  result:='';
  for i:=0 to 2 do
    for j:=0 to 2 do
      result:=result+IntToStr(filter.Values[i,j])+'/'+IntToStr(filter.Divisor);
end;


procedure IELocalBinarize(InBitmap,OutBitmap:TIEBitmap; WinSize:integer; Mode:TIEThreshMode; Offset:integer; OnProgress: TIEProgressEvent; Sender: TObject);
var
  GrayBitmap:TIEBitmap;
  width,height:integer;
  i,j:integer;
  CurrentThreshold:integer;
  WinSize2:integer;
  med:pbytearray;
  b:integer;
  p,ps:pbyte;

  procedure CalcThreshold_MeanMinMax;
  var
    x,y:integer;
    pb:pbyte;
    max,min:integer;
  begin
    max:=0; min:=255;
    for y:=i-WinSize2+1 to i+WinSize2 do
    begin
      if (y>=0) and (y<height) then
      begin
        pb:=GrayBitmap.Scanline[y]; inc(pb,j-WinSize2);
        for x:=j-WinSize2+1 to j+WinSize2 do
        begin
          if (x>=0) and (x<width) then
          begin
            if pb^>max then max:=pb^;
            if pb^<min then min:=pb^;
          end;
          inc(pb);
        end;
      end;
    end;
    CurrentThreshold:=(max+min) div 2 - Offset;
  end;

  procedure CalcThreshold_Mean;
  var
    x,y:integer;
    s,c:integer;
    pb:pbyte;
  begin
    s:=0; c:=0;
    for y:=i-WinSize2+1 to i+WinSize2 do
    begin
      if (y>=0) and (y<height) then
      begin
        pb:=GrayBitmap.Scanline[y]; inc(pb,j-WinSize2);
        for x:=j-WinSize2+1 to j+WinSize2 do
        begin
          if (x>=0) and (x<width) then
          begin
            s:=s+pb^;
            inc(c);
          end;
          inc(pb);
        end;
      end;
    end;
    CurrentThreshold:=s div c - Offset;
  end;

  procedure QuickSort(L, R: Integer);
  var
    I, J, P: Integer;
  begin
    repeat
      I := L;
      J := R;
      P := L + (R - L) shr 1; // 3.0.4
      repeat
        while med[I]<med[P] do Inc(I);
        while med[J]>med[P] do Dec(J);
        if I <= J then
        begin
          if I=P then P:=J else if J=P then P:=I; // 2.2.5
          bswap(med[I],med[J]);
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then QuickSort(L, J);
      L := I;
    until I >= R;
  end;

  procedure CalcThreshold_Median;
  var
    x,y:integer;
    c:integer;
    pb:pbyte;
  begin
    c:=0;
    for y:=i-WinSize2+1 to i+WinSize2 do
    begin
      if (y>=0) and (y<height) then
      begin
        pb:=GrayBitmap.Scanline[y]; inc(pb,j-WinSize2);
        for x:=j-WinSize2+1 to j+WinSize2 do
        begin
          if (x>=0) and (x<width) then
          begin
            med[c]:=pb^;
            inc(c);
          end;
          inc(pb);
        end;
      end;
    end;
    QuickSort(0,c-1);
    CurrentThreshold:= med[c div 2] - Offset;
  end;

begin
  width:=InBitmap.Width;
  height:=InBitmap.height;
  GrayBitmap:=TIEBitmap.Create(width,height,ie8g);
  GrayBitmap.CopyAndConvertFormat(InBitmap);
  OutBitmap.Allocate(width,height,ie1g);

  WinSize2:=WinSize div 2;

  if Mode=ietMedian then
    getmem(med,WinSize*WinSize);

  for i:=0 to height-1 do
  begin
    p:=OutBitmap.Scanline[i];
    ps:=GrayBitmap.Scanline[i];
    for j:=0 to width-1 do
    begin
      case Mode of
        ietMean: CalcThreshold_Mean;
        ietMedian: CalcThreshold_Median;
        ietMeanMinMax: CalcThreshold_MeanMinMax;
      end;
      b := j and 7;
      if ps^>=CurrentThreshold then
        p^ := p^ or iebitmask1[b]
      else
        p^ := p^ and (not iebitmask1[b]);
      if b = 7 then
        inc(p);
      inc(ps);
    end;
    if assigned(OnProgress) then
      OnProgress(Sender, trunc(i/height*100));
  end;

  if Mode=ietMedian then
    freemem(med);

  GrayBitmap.Free;

end;

{!!
<FS>TImageEnProc.ConvertToBWLocalThreshold

<FM>Declaration<FC>
procedure ConvertToBWLocalThreshold(WinSize:integer; Mode:<A TIEThreshMode>; Offset:integer);

<FM>Description<FN>
Converts a true color image (24 bit) to black & white (1 bit) using local threshold algorithms (mean, median, min/max mean).
WinSize specifies the window size, minimum value is 2.
Offset substracts an offset to the calculated local threshold.
Mode specifies the algorithm to use.

<FM>Example<FN>
ImageEnView1.Proc.ConvertToBWLocalThreshold(8, ietMean);

!!}
procedure TImageEnProc.ConvertToBWLocalThreshold(WinSize:integer; Mode:TIEThreshMode; Offset:integer);
begin
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  if fAutoUndo then
    SaveUndoCaptioned(IERS_CONVERTTOBWLOCALTHRESHOLD, ieuImage);
  IELocalBinarize(fIEBitmap,fIEBitmap,WinSize,Mode,Offset,fOnProgress,self);
  Update;
  DoFinishWork;
end;

{!!
<FS>TImageEnProc.CompareHistogramWith

<FM>Declaration<FC>
function CompareHistogramWith(SecondImage: <A TIEBitmap>; Mode:<A TIECmpMode>; GrayScale:boolean):double;

<FM>Description<FN>
Compares histograms of current image with SecondImage and returns a floating point value from 0 to 1 which specifies the percentage of equality.
Mode specifies the algorithm to compare.
If GrayScale is True, only gray scale histogram is compared.
!!}
function TImageEnProc.CompareHistogramWith(SecondImage: TIEBitmap; Mode:TIECmpMode; GrayScale:boolean):double;
begin
  result := 0;
  if not MakeConsistentBitmap([ie24RGB]) then
    exit;
  result := IECompareImagesHistogram(fIEBitmap, SecondImage, Mode, GrayScale);
  DoFinishWork;
end;

// channel: 0=R, 1=G, 2=B, 3=gray
function IECompareHistograms(h1,h2:THistogram; Mode:TIECmpMode; channel:integer):double;
var
  i:integer;
  v1,v2:PDWORD;
  max,min:DWORD;
  m1,m2,d1,d2:double;
begin
  result:=0;
  case Mode of
    iecmpRMSE: // Root Mean Square error
      begin
        max:=0;
        min:=$FFFFFFFF;
        for i:=0 to 255 do
        begin
          v1:=PDWORD(@h1[i]); inc(v1,channel);
          v2:=PDWORD(@h2[i]); inc(v2,channel);
          result:=result + sqr(v1^-v2^);
          if v1^>max then max:=v1^;
          if v2^>max then max:=v2^;
          if v1^<min then min:=v1^;
          if v2^<min then min:=v2^;
        end;
        result:=sqrt(result/256) / (max-min);
      end;
    iecmpHamming: // Hamming distance
      begin
        for i:=0 to 255 do
        begin
          v1:=PDWORD(@h1[i]); inc(v1,channel);
          v2:=PDWORD(@h2[i]); inc(v2,channel);
          if v1^<>v2^ then
            result:=result+1;
        end;
        result:=result/256;
      end;
    iecmpCovariance: // Covariance
      begin
        m1:=0; m2:=0;
        for i:=0 to 255 do
        begin
          v1:=PDWORD(@h1[i]); inc(v1,channel);
          v2:=PDWORD(@h2[i]); inc(v2,channel);
          m1:=m1+v1^;
          m2:=m2+v2^;
        end;
        m1:=m1/256;
        m2:=m2/256;
        for i:=0 to 255 do
        begin
          v1:=PDWORD(@h1[i]); inc(v1,channel);
          v2:=PDWORD(@h2[i]); inc(v2,channel);
          d1:=v1^-m1;
          d2:=v2^-m2;
          result:=result+(d1 * d2 - result) / (i + 1);
        end;
      end;
  end;
end;

function IECompareImagesHistogram(bitmap1, bitmap2: TIEBitmap; Mode:TIECmpMode; GrayScale:boolean):double;
var
  hist1,hist2:THistogram;
  er,eg,eb,ei:double;
begin
  _GetHistogram(bitmap1, @hist1, 0,0,bitmap1.Width,bitmap2.Height, nil);
  _GetHistogram(bitmap2, @hist2, 0,0,bitmap1.Width,bitmap2.Height, nil);
  if GrayScale then
  begin
    ei:=IECompareHistograms(hist1,hist2,Mode,3);
    result:=1-ei;
  end
  else
  begin
    er:=IECompareHistograms(hist1,hist2,Mode,0);
    eg:=IECompareHistograms(hist1,hist2,Mode,1);
    eb:=IECompareHistograms(hist1,hist2,Mode,2);
    result:=1-(er+eg+eb)/3;
  end;
end;


///////////////////////////////////////////////////////////////////////////////////////
// Reflection effect

{!!
<FS>TImageEnProc.Reflection


<FM>Declaration<FC>
procedure Reflection(minAlpha:integer = 0; maxAlpha:integer=200; percentage:integer=100);

<FM>Description<FN>
Extends image vertically to simulate a reflection (like reflection of "cover flow" presentations).

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>minAlpha<FN></C> <C>Minimum alpha value (0=fully transparent, 255=fully opaque).</C> </R>
<R> <C><FC>maxAlpha<FN></C> <C>Maximum alpha value (0=fully transparent, 255=fully opaque).</C> </R>
<R> <C><FC>percentage<FN></C> <C>Effect percentage (0=no effect, 100=maximum effect).</C> </R>
</TABLE>


<FM>Example<FC>
ImageEnView1.Reflection();
!!}
procedure TImageEnProc.Reflection(minAlpha:integer; maxAlpha:integer; percentage:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, Format(IERS_REFLECTION, [minAlpha, maxAlpha, percentage]), ProcBitmap, mask) then
    exit;
  IEReflectionEffect(ProcBitmap, minAlpha, maxAlpha, percentage, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


// accept only ie24RGB
procedure IEReflectionEffect(bitmap:TIEBitmap; minAlpha, maxAlpha:integer; percentage:integer; OnProgress: TIEProgressEvent; Sender: TObject);
var
  x, y, dst_y :integer;
  w, h :integer;
  src, dst :PRGB;
  src_alpha, dst_alpha :pbyte;
  mul:double;
  prevPer, per:integer;
begin
  prevPer := -1;
  w := bitmap.Width;
  h := bitmap.Height;
  bitmap.Resize(w, h*2);
  for y:=0 to h-1 do
  begin
    dst_y := h*2-y-1;

    src := bitmap.GetRow(y);
    src_alpha := bitmap.AlphaChannel.GetRow(y);
    dst := bitmap.GetRow(dst_y);
    dst_alpha := bitmap.AlphaChannel.GetRow(dst_y);

    CopyMemory(dst, src, bitmap.Rowlen);

    mul := (y/h-((100-percentage)/100));

    for x:=0 to w-1 do
    begin
      dst_alpha^ := imax(minAlpha, imin(maxAlpha, imin(src_alpha^, trunc(src_alpha^ * mul))));
      inc(dst_alpha);
      inc(src_alpha);
    end;

    bitmap.FreeRow(y);
    bitmap.FreeRow(dst_y);
    bitmap.AlphaChannel.FreeRow(y);
    bitmap.AlphaChannel.FreeRow(dst_y);

    if assigned(OnProgress) then
    begin
      per := trunc(y/h*100);
      if per<>prevPer then
      begin
        prevPer := per;
        OnProgress(Sender, per);
      end;
    end;
  end;

  bitmap.AlphaChannel.Full:=false;
end;


///////////////////////////////////////////////////////////////////////////////////////
// Perspective transformation and coverflow support


// merges source Bitmap to destination coordinates
// if alphaMin>-1 and alphaMax>-1 then draws with specified alpha range
procedure IEPerspectiveTransform(SrcBitmap, DstBitmap:TIEBitmap; xx0, yy0, xx1, yy1, xx2, yy2, xx3, yy3:integer; alphaMin, alphaMax:integer);
var
  srccols, srcrows:double;
  dstcols, dstrows:integer;
  dstWidth, dstHeight:integer;
  x0, y0, x1, y1, x2, y2, x3, y3:double;
  delx1, dely1, delx2, dely2, delx3, dely3:double;
  a11, a12, a13, a21, a22, a23, a31, a32:double;
  u, v, i, j:integer;
  floatu, floatv, x, y:double;
  AA, BB, CC, DD, EE, FF, GG, HH, II:double;
  px:PRGB;
  pa:pbyte;
  v1, v2, v3, v4:double;
  dst_x1, dst_x2, dst_y1, dst_y2:integer;
  aap:integer;
begin


  dst_x1 := imin(xx0, imin(xx1, imin(xx2, xx3)));
  dst_y1 := imin(yy0, imin(yy1, imin(yy2, yy3)));
  dst_x2 := imax(xx0, imax(xx1, imax(xx2, xx3)));
  dst_y2 := imax(yy0, imax(yy1, imax(yy2, yy3)));

  dstrows := imax( imax( imax( yy0, yy1 ), yy2 ), yy3) +1;
  dstcols := imax( imax( imax( xx0, xx1 ), xx2 ), xx3) +1;

  if (dstrows=0) or (dstcols=0) then
    exit;
  if (xx0=xx1) or (yy0=yy2) then
    exit;

  x0 := xx0 / dstcols;
  y0 := yy0 / dstrows;
  x1 := xx1 / dstcols;
  y1 := yy1 / dstrows;
  x2 := xx2 / dstcols;
  y2 := yy2 / dstrows;
  x3 := xx3 / dstcols;
  y3 := yy3 / dstrows;

  srccols := SrcBitmap.Width;
  srcrows := SrcBitmap.Height;

  dstWidth  := DstBitmap.Width;
  dstHeight := DstBitmap.Height;

  delx1 := x1-x2;
  dely1 := y1-y2;
  delx2 := x3-x2;
  dely2 := y3-y2;
  delx3 := x0-x1+x2-x3;
  dely3 := y0-y1+y2-y3;

  if (delx3=0) and (dely3=0) then
  begin
    a11 := x1-x0;
    a21 := x2-x1;
    a31 := x0;
    a12 := y1-y0;
    a22 := y2-y1;
    a32 := y0;
    a13 :=0;
    a23 := 0;
  end
  else
  begin
    a13 := (delx3*dely2-delx2*dely3)/(delx1*dely2-dely1*delx2);
    a23 := (delx1*dely3-dely1*delx3)/(delx1*dely2-dely1*delx2);
    a11 := x1-x0+a13*x1;
    a21 := x3-x0+a23*x3;
    a31 := x0;
    a12 := y1-y0+a13*y1;
    a22 := y3-y0+a23*y3;
    a32 := y0;
  end;

  AA := a22-a32*a23;
  BB := a31*a23-a21;
  CC := a21*a32-a31*a22;
  DD := a32*a13-a12;
  EE := a11-a31*a13;
  FF := a31*a12-a11*a32;
  GG := a12*a23-a22*a13;
  HH := a21*a13-a11*a23;
  II := a11*a22-a21*a12;

  if (alphaMin>-1) and (alphaMax>-1) then
  begin
    // alpha modified (in the range)

    for i:=dst_y1 to dst_y2 do
    begin
      if (i>=0) and (i<dstHeight) then
      begin
        px := DstBitmap.ScanLine[i]; inc(px, dst_x1);
        pa := DstBitmap.AlphaChannel.ScanLine[i]; inc(pa, dst_x1);
        y := i/dstrows;
        v2 := HH*y+II;
        v3 := BB*y+CC;
        v4 := EE*y+FF;
        for j:=dst_x1 to dst_x2 do
        begin
          x := j/dstcols;
          v1 := (GG*x+v2);
          if v1=0 then v1:=1;
          floatu := ((AA*x+v3)/v1)*srccols +0.5;
          floatv := ((DD*x+v4)/v1)*srcrows +0.5;
          if (floatu<srccols) and (floatu>=0.0) and (floatv<srcrows) and (floatv>=0.0) and (j>=0) and (j<dstWidth) then
          begin
            u := trunc(floatu);
            v := trunc(floatv);
            px^ := SrcBitmap.Pixels_ie24RGB[u,v];
            pa^ := SrcBitmap.AlphaChannel.Pixels_ie8[u,v];
            if yy0 < yy3 then
              aap := trunc( pa^ * (1-v/srcrows) )
            else
              aap := trunc( pa^ * (v/srcrows) );
            if pa^ < aap then
              aap := pa^;
            if aap < alphaMin then
              pa^ := alphaMin
            else if aap > alphaMax then
              pa^ := alphaMax
            else
              pa^ := aap;
          end;
          inc(px);
          inc(pa);
        end;
      end;
    end;
    DstBitmap.AlphaChannel.Full := false;

  end
  else
  begin
    // alpha unmodified

    for i:=dst_y1 to dst_y2 do
    begin
      if (i>=0) and (i<dstHeight) then
      begin
        px := DstBitmap.ScanLine[i]; inc(px, dst_x1);
        pa := DstBitmap.AlphaChannel.ScanLine[i]; inc(pa, dst_x1);
        y := i/dstrows;
        v2 := HH*y+II;
        v3 := BB*y+CC;
        v4 := EE*y+FF;
        for j:=dst_x1 to dst_x2 do
        begin
          x := j/dstcols;
          v1 := (GG*x+v2);
          if v1=0 then v1:=1;
          floatu := ((AA*x+v3)/v1)*srccols +0.5;
          floatv := ((DD*x+v4)/v1)*srcrows +0.5;
          if (floatu<srccols) and (floatu>=0.0) and (floatv<srcrows) and (floatv>=0.0) and (j>=0) and (j<dstWidth) then
          begin
            u := trunc(floatu);
            v := trunc(floatv);
            px^ := SrcBitmap.Pixels_ie24RGB[u,v];
            pa^ := SrcBitmap.AlphaChannel.Pixels_ie8[u,v];
          end;
          inc(px);
          inc(pa);
        end;
      end;
    end;

  end;

end;


{!!
<FS>TImageEnProc.PerspectiveDraw


<FM>Declaration<FC>
procedure PerspectiveDraw(Source:<A TIEBitmap>; x0, y0, x1, y1, x2, y2, x3, y3:integer; alphaMin:integer=-1; alphaMax:integer=-1);

<FM>Description<FN>
Draws source bitmap over current layer, stretching bitmap inside four points.
x0, y0 = left/top point
x1, y1 = right/top point
x2, y2 = right/bottom point
x4, y3 = left/bottom point
It is possible to invert the image making, for example, (x0,y0) > (x1,y1).

If alphaMin>-1 and alphaMax>-1 then alpha (transparency) will be set in the specified range. This is useful to compose "cover-flow" like reflection.
alphaMin (0..255) specifies minimum transparency. alphaMax (0..255) specifies maximum transparency.

<FM>Example<FC>
// stretch the image to ((0,0),(100,100),(120,200),(10,180))
ImageEnView1.Proc.PerspectiveDraw(ImageEnView2.IEBitmap, 0,0, 100,100, 120,200, 10,180);
!!}
procedure TImageEnProc.PerspectiveDraw(Source:TIEBitmap; x0, y0, x1, y1, x2, y2, x3, y3:integer; alphaMin:integer; alphaMax:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  sx1, sy1, sx2, sy2: integer;
begin
  if not BeginImageProcessing([ie24RGB], sx1, sy1, sx2, sy2, IERS_PERSPECTIVEDRAW, ProcBitmap, mask) then
    exit;
  IEPerspectiveTransform(Source, ProcBitmap, x0, y0, x1, y1, x2, y2, x3, y3, alphaMin, alphaMax);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;



type

T3DPoint = record
  x: double;
  y: double;
  z: double;
end;

// rotate about Y axis
procedure IERotateCoordsY(var p:T3DPoint; angle:double);
var
  rx, ry, rz:double;
begin
  rx := p.z*sin(angle) + p.x*cos(angle);
  ry := p.y;
  rz := p.z*cos(angle) - p.x*sin(angle);
  p.x := rx;
  p.y := ry;
  p.z := rz;
end;

// rotate about X axis
procedure IERotateCoordsX(var p:T3DPoint; angle:double);
var
  rx, ry, rz:double;
begin
  rx := p.x;
  ry := p.y*cos(angle) - p.z*sin(angle);
  rz := p.y*sin(angle) + p.z*cos(angle);
  p.x := rx;
  p.y := ry;
  p.z := rz;
end;

procedure IEProjectCoords(const p:T3DPoint; distance:double; var xp, yp:double);
begin
  xp := (p.x*distance) / (p.z + distance);
  yp := (p.y*distance) / (p.z + distance);
end;

procedure IERotateRectangle(const rect:TRect; viewerX, viewerY:double; var p1, p2, p3, p4:T3DPoint; angleX, angleY:double);
var
  ox, oy:double;
begin
  ox := (rect.Right+rect.Left)/2-viewerX;
  oy := (rect.Bottom+rect.Top)/2-viewerY;

  p1.x := rect.Left - ox;
  p1.y := rect.Top  - oy;
  p1.z := 0;
  IERotateCoordsY(p1, angleY);
  IERotateCoordsX(p1, angleX);

  p2.x := rect.Right - ox;
  p2.y := rect.Top   - oy;
  p2.z := 0;
  IERotateCoordsY(p2, angleY);
  IERotateCoordsX(p2, angleX);

  p3.x := rect.Right  - ox;
  p3.y := rect.Bottom - oy;
  p3.z := 0;
  IERotateCoordsY(p3, angleY);
  IERotateCoordsX(p3, angleX);

  p4.x := rect.Left   - ox;
  p4.y := rect.Bottom - oy;
  p4.z := 0;
  IERotateCoordsY(p4, angleY);
  IERotateCoordsX(p4, angleX);
end;

procedure IEProjectRectangle(const p1, p2, p3, p4:T3DPoint; distance:double; var x1,y1, x2,y2, x3,y3, x4,y4:double);
begin
  IEProjectCoords(p1, distance, x1, y1);
  IEProjectCoords(p2, distance, x2, y2);
  IEProjectCoords(p3, distance, x3, y3);
  IEProjectCoords(p4, distance, x4, y4);
end;

// angles in degrees
procedure IEProjectBitmap1(Bitmap:TIEBitmap; DstBitmap:TIEBitmap; scale:double; centerDstX, centerDstY:integer; translateX, translateY:integer; depth:double; rotateX, rotateY:double; specularAlphaMin, specularAlphaMax:integer; var outCoords:TIEQuadCoords);
var
  r:TRect;
  p1, p2, p3, p4:T3DPoint;
  x0, y0, x1, y1, x2, y2, x3, y3:double;
  h1, h2: integer;
begin
  rotateX := rotateX * (PI/180);
  rotateY := rotateY * (PI/180);
  r := rect(0, 0, trunc(Bitmap.Width*scale), trunc(Bitmap.Height*scale));
  IERotateRectangle(r, translateX, translateY, p1, p2, p3, p4, rotateX, rotateY);
  IEProjectRectangle(p1, p2, p3, p4, depth, x0, y0, x1, y1, x2, y2, x3, y3);
  outCoords.x0 := trunc(x0 + centerDstX - translateX);
  outCoords.y0 := trunc(y0 + centerDstY - translateY);
  outCoords.x1 := trunc(x1 + centerDstX - translateX);
  outCoords.y1 := trunc(y1 + centerDstY - translateY);
  outCoords.x2 := trunc(x2 + centerDstX - translateX);
  outCoords.y2 := trunc(y2 + centerDstY - translateY);
  outCoords.x3 := trunc(x3 + centerDstX - translateX);
  outCoords.y3 := trunc(y3 + centerDstY - translateY);
  IEPerspectiveTransform(Bitmap, DstBitmap, outCoords.x0, outCoords.y0, outCoords.x1, outCoords.y1, outCoords.x2, outCoords.y2, outCoords.x3, outCoords.y3, -1, -1);

  h1:=abs(outCoords.y3-outCoords.y0);
  h2:=abs(outCoords.y2-outCoords.y1);
  if (specularAlphaMin>-1) and (specularAlphaMax>-1) then
  begin
    IEPerspectiveTransform(Bitmap, DstBitmap, outCoords.x0, outCoords.y3+h1, outCoords.x1, outCoords.y2+h2, outCoords.x2, outCoords.y1+h2, outCoords.x3, outCoords.y0+h1, specularAlphaMin, specularAlphaMax);
  end;
end;

// autocalculates scale from dstWidth and dstHeight
procedure IEProjectBitmap2(Bitmap:TIEBitmap; DstBitmap:TIEBitmap; centerDstX, centerDstY:integer; dstWidth, dstHeight:integer; translateX, translateY:integer; depth:double; rotateX, rotateY:double; specularAlphaMin, specularAlphaMax:integer; var outCoords:TIEQuadCoords);
var
  scale:double;
  w, h:integer;
begin
  IEFitResample(Bitmap.Width, Bitmap.Height, dstWidth, dstHeight, w, h);
  scale := w / Bitmap.Width;
  IEProjectBitmap1(Bitmap, DstBitmap, scale, centerDstX, centerDstY, translateX, translateY, depth, rotateX, rotateY, specularAlphaMin, specularAlphaMax, outCoords);
end;

{!!
<FS>TImageEnProc.ProjectDraw


<FM>Declaration<FC>
function ProjectDraw(Source:<A TIEBitmap>; centerDestX:integer; centerDestY:integer; destWidth:integer; destHeight:integer; depth:double; translateX:integer; translateY:integer; rotateX:double; rotateY:double; specularAlphaMin:integer; specularAlphaMax:integer):<A TIEQuadCoords>;
function ProjectDraw(Source:<A TIEBitmap>; centerDestX:integer; centerDestY:integer; scale:double; depth:double; translateX:integer; translateY:integer; rotateX:double; rotateY:double; specularAlphaMin:integer; specularAlphaMax:integer):<A TIEQuadCoords>;

<FM>Description<FN>
Draws source bitmap over current layer, performing translations, rotations and perspective transform.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Source<FN></C> <C>Source bitmap to draw.</C> </R>
<R> <C><FC>centerDestX<FN></C> <C>Horizontal position of center of destination position.</C> </R>
<R> <C><FC>centerDestY<FN></C> <C>Vertical position of center of destination position.</C> </R>
<R> <C><FC>destWidth<FN></C> <C>Destination bounding box width, not including specular bitmap. The resulting bitmap will be adapted (but not stretched) to this size.</C> </R>
<R> <C><FC>destHeight<FN></C> <C>Destination bounding box height, not including specular bitmap. The resulting bitmap will be adapted (but not stretched) to this size.</C> </R>
<R> <C><FC>scale<FN></C> <C>Replaces destWidth and destHeight in the second overload. Specifies a multiplier of the original size (1=same size, 0.5=half size, etc..).</C> </R>
<R> <C><FC>depth<FN></C> <C>Destination depth of field.</C> </R>
<R> <C><FC>translateX<FN></C> <C>Horizontal offset in 3D space (before perspective projection)</C> </R>
<R> <C><FC>translateY<FN></C> <C>Vertical offset in 3D space (before perspective projection)</C> </R>
<R> <C><FC>rotateX<FN></C> <C>X axis rotations in 3D space (before perspective projection). Angles are in degrees.</C> </R>
<R> <C><FC>rotateY<FN></C> <C>Y axis rotations in 3D space (before perspective projection). Angles are in degrees.</C> </R>
<R> <C><FC>specularAlphaMin<FN></C> <C>If >-1 a reflection bitmap will be drawn, using specified alpha range.</C> </R>
<R> <C><FC>specularAlphaMax<FN></C> <C>If >-1 a reflection bitmap will be drawn, using specified alpha range.</C> </R>
</TABLE>

Returns coordinates of four points of stretched bitmap.
This function is the base to build cover-flow like effects.


<FM>Example<FC>
// draw at 200,200 (center), inside a box of 150x150, depth 400, rotating by 30° on Y axis, with specular effect
ImageEnView1.Proc.ProjectDraw( ImageEnView2.IEBitmap, 200,200, 150,150, 400, 0,0, 0,30, 0,100 );

!!}
function TImageEnProc.ProjectDraw(Source:TIEBitmap; centerDestX:integer; centerDestY:integer; destWidth:integer; destHeight:integer;
                                  depth:double; translateX:integer; translateY:integer; rotateX:double; rotateY:double;
                                  specularAlphaMin:integer; specularAlphaMax:integer):TIEQuadCoords;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  sx1, sy1, sx2, sy2: integer;
begin
  if not BeginImageProcessing([ie24RGB], sx1, sy1, sx2, sy2, IERS_PROJECTDRAW, ProcBitmap, mask) then
    exit;
  IEProjectBitmap2(Source, ProcBitmap, centerDestX, centerDestY, destWidth, destHeight, translateX, translateY, depth,
                   rotateX, rotateY, specularAlphaMin, specularAlphaMax, result);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

function TImageEnProc.ProjectDraw(Source:TIEBitmap; centerDestX:integer; centerDestY:integer; scale:double;
                                  depth:double; translateX:integer; translateY:integer; rotateX:double; rotateY:double;
                                  specularAlphaMin:integer; specularAlphaMax:integer):TIEQuadCoords;
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  sx1, sy1, sx2, sy2: integer;
begin
  if not BeginImageProcessing([ie24RGB], sx1, sy1, sx2, sy2, IERS_PROJECTDRAW, ProcBitmap, mask) then
    exit;
  IEProjectBitmap1(Source, ProcBitmap, scale, centerDestX, centerDestY, translateX, translateY, depth,
                  rotateX, rotateY, specularAlphaMin, specularAlphaMax, result);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;



function IEPerspectiveTransform_precalc(SrcWidth, SrcHeight:integer; xx0, yy0, xx1, yy1, xx2, yy2, xx3, yy3:integer):PIEPrecalcTransform;
var
  srccols, srcrows:double;
  dstcols, dstrows:integer;
  x0, y0, x1, y1, x2, y2, x3, y3:double;
  delx1, dely1, delx2, dely2, delx3, dely3:double;
  a11, a12, a13, a21, a22, a23, a31, a32:double;
  u, v, i, j:integer;
  floatu, floatv, x, y:double;
  AA, BB, CC, DD, EE, FF, GG, HH, II:double;
  v1, v2, v3, v4:double;
  dst_x1, dst_x2, dst_y1, dst_y2:integer;
  pw:pword;
begin

  dst_x1 := imin(xx0, imin(xx1, imin(xx2, xx3)));
  dst_y1 := imin(yy0, imin(yy1, imin(yy2, yy3)));
  dst_x2 := imax(xx0, imax(xx1, imax(xx2, xx3)));
  dst_y2 := imax(yy0, imax(yy1, imax(yy2, yy3)));

  dstrows := imax( imax( imax( yy0, yy1 ), yy2 ), yy3) +1;
  dstcols := imax( imax( imax( xx0, xx1 ), xx2 ), xx3) +1;

  result := new(PIEPrecalcTransform);
  result^.width := dst_x2-dst_x1+1;
  result^.height := dst_y2-dst_y1+1;
  result^.dst_x1 := dst_x1;
  result^.dst_y1 := dst_y1;
  result^.dst_x2 := dst_x2;
  result^.dst_y2 := dst_y2;
  getmem(result^.src, sizeof(word) * (2*result^.width*result^.height+1));
  pw := result^.src;
  pw^ := $FFFF;

  if (dstrows=0) or (dstcols=0) then
    exit;
  if (xx0=xx1) or (yy0=yy2) then
    exit;

  x0 := xx0 / dstcols;
  y0 := yy0 / dstrows;
  x1 := xx1 / dstcols;
  y1 := yy1 / dstrows;
  x2 := xx2 / dstcols;
  y2 := yy2 / dstrows;
  x3 := xx3 / dstcols;
  y3 := yy3 / dstrows;

  srccols := SrcWidth;
  srcrows := SrcHeight;

  delx1 := x1-x2;
  dely1 := y1-y2;
  delx2 := x3-x2;
  dely2 := y3-y2;
  delx3 := x0-x1+x2-x3;
  dely3 := y0-y1+y2-y3;

  if (delx3=0) and (dely3=0) then
  begin
    a11 := x1-x0;
    a21 := x2-x1;
    a31 := x0;
    a12 := y1-y0;
    a22 := y2-y1;
    a32 := y0;
    a13 :=0;
    a23 := 0;
  end
  else
  begin
    a13 := (delx3*dely2-delx2*dely3)/(delx1*dely2-dely1*delx2);
    a23 := (delx1*dely3-dely1*delx3)/(delx1*dely2-dely1*delx2);
    a11 := x1-x0+a13*x1;
    a21 := x3-x0+a23*x3;
    a31 := x0;
    a12 := y1-y0+a13*y1;
    a22 := y3-y0+a23*y3;
    a32 := y0;
  end;

  AA := a22-a32*a23;
  BB := a31*a23-a21;
  CC := a21*a32-a31*a22;
  DD := a32*a13-a12;
  EE := a11-a31*a13;
  FF := a31*a12-a11*a32;
  GG := a12*a23-a22*a13;
  HH := a21*a13-a11*a23;
  II := a11*a22-a21*a12;

  for i:=dst_y1 to dst_y2 do
  begin
    y := i/dstrows;
    v2 := HH*y+II;
    v3 := BB*y+CC;
    v4 := EE*y+FF;
    for j:=dst_x1 to dst_x2 do
    begin
      x := j/dstcols;
      v1 := (GG*x+v2);
      if v1=0 then v1:=1;
      floatu := ((AA*x+v3)/v1)*srccols +0.5;
      floatv := ((DD*x+v4)/v1)*srcrows +0.5;
      if (floatu<srccols) and (floatu>=0.0) and (floatv<srcrows) and (floatv>=0.0) then
      begin
        u := trunc(floatu);
        v := trunc(floatv);
        pw^ := u; inc(pw);
        pw^ := v; inc(pw);
      end
      else
      begin
        pw ^:= $FFFF; inc(pw);
      end;
    end;
  end;
end;

// precalclist is a list of TIEPrecalcTransform
// rotateX, rotateY in degrees
procedure IEPerspectiveTransform_exec(SrcBitmap:TIEBitmap; DstBitmap:TIEBitmap; precalclist:TList; destX, destY:integer; rotateX, rotateY:double);
var
  pw:pword;
  i, j:integer;
  ww, hh:integer;
  u, v:integer;
  px: PRGB;
  pa: pbyte;
  precalc:PIEPrecalcTransform;
begin
  precalc := nil;
  for i:=0 to precalclist.Count-1 do
  begin
    precalc:=PIEPrecalcTransform(precalclist[i]);
    if (precalc^.rotateX=rotateX) and (precalc^.rotateY=rotateY) then
      break;
  end;
  if not assigned(precalc) then
    exit;
  ww := precalc^.width;
  hh := precalc^.height;
  if (ww<=1) or (hh<=1) then
    exit;
  destX := precalc^.dst_x1 + (destX - precalc^.destX);
  destY := precalc^.dst_y1 + (destY - precalc^.destY);
  pw := precalc^.src;
  for i:=0 to hh-1 do
  begin

    px := DstBitmap.ScanLine[i+destY]; inc(px, destX);
    pa := DstBitmap.AlphaChannel.ScanLine[i+destY]; inc(pa, destX);

    for j:=0 to ww-1 do
    begin
      u := pw^; inc(pw);
      if u<>$FFFF then
      begin
          v := pw^; inc(pw);
          px^ := SrcBitmap.Pixels_ie24RGB[u,v];
          pa^ := SrcBitmap.AlphaChannel.Pixels_ie8[u,v];
      end;
      inc(px);
      inc(pa);
    end;

  end;
end;

procedure IEProjectBitmap_free_precalclist(var precalclist:TList);
var
  i:integer;
  precalc:PIEPrecalcTransform;
begin
  for i:=0 to precalclist.Count-1 do
  begin
    precalc:=PIEPrecalcTransform(precalclist[i]);
    freemem(precalc^.src);
    freemem(precalc);
  end;
  precalclist.Free;
end;

procedure IEProjectBitmap_precalc(Bitmap:TIEBitmap; DstBitmap:TIEBitmap; centerDstX, centerDstY:integer; dstWidth, dstHeight:integer; translateX, translateY:integer; depth:double; rotateX, rotateY:double; specularAlphaMin, specularAlphaMax:integer; var outCoords:TIEQuadCoords; var precalclist:TList);
var
  r:TRect;
  p1, p2, p3, p4:T3DPoint;
  x0, y0, x1, y1, x2, y2, x3, y3:double;
  //h1, h2: integer;
  scale:double;
  w, h:integer;
  rotX, rotY: double;
  precalc:PIEPrecalcTransform;
begin
  IEFitResample(Bitmap.Width, Bitmap.Height, dstWidth, dstHeight, w, h);
  scale := w / Bitmap.Width;

  rotX := rotateX * (PI/180);
  rotY := rotateY * (PI/180);
  r := rect(0, 0, trunc(Bitmap.Width*scale), trunc(Bitmap.Height*scale));
  IERotateRectangle(r, translateX, translateY, p1, p2, p3, p4, rotX, rotY);
  IEProjectRectangle(p1, p2, p3, p4, depth, x0, y0, x1, y1, x2, y2, x3, y3);
  outCoords.x0 := trunc(x0 + centerDstX - translateX);
  outCoords.y0 := trunc(y0 + centerDstY - translateY);
  outCoords.x1 := trunc(x1 + centerDstX - translateX);
  outCoords.y1 := trunc(y1 + centerDstY - translateY);
  outCoords.x2 := trunc(x2 + centerDstX - translateX);
  outCoords.y2 := trunc(y2 + centerDstY - translateY);
  outCoords.x3 := trunc(x3 + centerDstX - translateX);
  outCoords.y3 := trunc(y3 + centerDstY - translateY);
  precalc := IEPerspectiveTransform_precalc(Bitmap.Width, Bitmap.Height, outCoords.x0, outCoords.y0, outCoords.x1, outCoords.y1, outCoords.x2, outCoords.y2, outCoords.x3, outCoords.y3);
  precalc^.destX := centerDstX;
  precalc^.destY := centerDstY;
  precalc^.rotateX := rotateX;
  precalc^.rotateY := rotateY;
  precalclist.Add( precalc );

  //h1:=abs(outCoords.y3-outCoords.y0);
  //h2:=abs(outCoords.y2-outCoords.y1);
  if (specularAlphaMin>-1) and (specularAlphaMax>-1) then
  begin
    // todo
    //IEPerspectiveTransform(Bitmap, DstBitmap, outCoords.x0, outCoords.y3+h1, outCoords.x1, outCoords.y2+h2, outCoords.x2, outCoords.y1+h2, outCoords.x3, outCoords.y0+h1, specularAlphaMin, specularAlphaMax);
  end;
end;



///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnProc.AdjustTemperature

<FM>Declaration<FC>
procedure AdjustTemperature(temperature:integer);


<FM>Description<FN>
Adjusts image temperature.
<FC>temperature<FN> is measured in degrees Kelvin. Minimum value is 1000 (K) and maximum is 40000 (K). Resolution is 100K (so allowed values are 1000, 1100, 1200, etc).

<FM>Example<FC>
ImageEnView1.Proc.AdjustTemperature(6500);
!!}
procedure TImageEnProc.AdjustTemperature(temperature:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_ADJUSTTEMPERATURE, ProcBitmap, mask) then
    exit;
  IEAdjustTemperature(ProcBitmap, x1, y1, x2, y2, temperature, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

const temps:array [0..390, 0..2] of byte = (
(255,56,0),(255,71,0),(255,83,0),(255,93,0),(255,101,0),(255,109,0),(255,115,0),(255,121,0),(255,126,0),(255,131,0),(255,137,18),(255,142,33),
(255,147,44),(255,152,54),(255,157,63),(255,161,72),(255,165,79),(255,169,87),(255,173,94),(255,177,101),(255,180,107),(255,184,114),(255,187,120),(255,190,126),
(255,193,132),(255,196,137),(255,199,143),(255,201,148),(255,204,153),(255,206,159),(255,209,163),(255,211,168),(255,213,173),(255,215,177),(255,217,182),(255,219,186),
(255,221,190),(255,223,194),(255,225,198),(255,227,202),(255,228,206),(255,230,210),(255,232,213),(255,233,217),(255,235,220),(255,236,224),(255,238,227),(255,239,230),
(255,240,233),(255,242,236),(255,243,239),(255,244,242),(255,245,245),(255,246,248),(255,248,251),(255,249,253),(254,249,255),(252,247,255),(249,246,255),(247,245,255),
(245,243,255),(243,242,255),(240,241,255),(239,240,255),(237,239,255),(235,238,255),(233,237,255),(231,236,255),(230,235,255),(228,234,255),(227,233,255),(225,232,255),
(224,231,255),(222,230,255),(221,230,255),(220,229,255),(218,228,255),(217,227,255),(216,227,255),(215,226,255),(214,225,255),(212,225,255),(211,224,255),(210,223,255),
(209,223,255),(208,222,255),(207,221,255),(207,221,255),(206,220,255),(205,220,255),(204,219,255),(203,219,255),(202,218,255),(201,218,255),(201,217,255),(200,217,255),
(199,216,255),(199,216,255),(198,216,255),(197,215,255),(196,215,255),(196,214,255),(195,214,255),(195,214,255),(194,213,255),(193,213,255),(193,212,255),(192,212,255),
(192,212,255),(191,211,255),(191,211,255),(190,211,255),(190,210,255),(189,210,255),(189,210,255),(188,210,255),(188,209,255),(187,209,255),(187,209,255),(186,208,255),
(186,208,255),(185,208,255),(185,208,255),(185,207,255),(184,207,255),(184,207,255),(183,207,255),(183,206,255),(183,206,255),(182,206,255),(182,206,255),(182,205,255),
(181,205,255),(181,205,255),(181,205,255),(180,205,255),(180,204,255),(180,204,255),(179,204,255),(179,204,255),(179,204,255),(178,203,255),(178,203,255),(178,203,255),
(178,203,255),(177,203,255),(177,202,255),(177,202,255),(177,202,255),(176,202,255),(176,202,255),(176,202,255),(175,201,255),(175,201,255),(175,201,255),(175,201,255),
(175,201,255),(174,201,255),(174,201,255),(174,200,255),(174,200,255),(173,200,255),(173,200,255),(173,200,255),(173,200,255),(173,200,255),(172,199,255),(172,199,255),
(172,199,255),(172,199,255),(172,199,255),(171,199,255),(171,199,255),(171,199,255),(171,198,255),(171,198,255),(170,198,255),(170,198,255),(170,198,255),(170,198,255),
(170,198,255),(170,198,255),(169,198,255),(169,197,255),(169,197,255),(169,197,255),(169,197,255),(169,197,255),(169,197,255),(168,197,255),(168,197,255),(168,197,255),
(168,197,255),(168,196,255),(168,196,255),(168,196,255),(167,196,255),(167,196,255),(167,196,255),(167,196,255),(167,196,255),(167,196,255),(167,196,255),(166,196,255),
(166,195,255),(166,195,255),(166,195,255),(166,195,255),(166,195,255),(166,195,255),(166,195,255),(165,195,255),(165,195,255),(165,195,255),(165,195,255),(165,195,255),
(165,195,255),(165,194,255),(165,194,255),(165,194,255),(164,194,255),(164,194,255),(164,194,255),(164,194,255),(164,194,255),(164,194,255),(164,194,255),(164,194,255),
(164,194,255),(164,194,255),(163,194,255),(163,194,255),(163,193,255),(163,193,255),(163,193,255),(163,193,255),(163,193,255),(163,193,255),(163,193,255),(163,193,255),
(163,193,255),(162,193,255),(162,193,255),(162,193,255),(162,193,255),(162,193,255),(162,193,255),(162,193,255),(162,193,255),(162,192,255),(162,192,255),(162,192,255),
(162,192,255),(162,192,255),(161,192,255),(161,192,255),(161,192,255),(161,192,255),(161,192,255),(161,192,255),(161,192,255),(161,192,255),(161,192,255),(161,192,255),
(161,192,255),(161,192,255),(161,192,255),(161,192,255),(160,192,255),(160,192,255),(160,191,255),(160,191,255),(160,191,255),(160,191,255),(160,191,255),(160,191,255),
(160,191,255),(160,191,255),(160,191,255),(160,191,255),(160,191,255),(160,191,255),(160,191,255),(159,191,255),(159,191,255),(159,191,255),(159,191,255),(159,191,255),
(159,191,255),(159,191,255),(159,191,255),(159,191,255),(159,191,255),(159,191,255),(159,190,255),(159,190,255),(159,190,255),(159,190,255),(159,190,255),(159,190,255),
(159,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),
(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(158,190,255),(157,190,255),(157,190,255),
(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),
(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(157,189,255),(156,189,255),(156,189,255),
(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),(156,189,255),
(156,189,255),(156,189,255),(156,188,255),(156,188,255),(156,188,255),(156,188,255),(156,188,255),(156,188,255),(156,188,255),(156,188,255),(156,188,255),(156,188,255),
(156,188,255),(156,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),
(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255),(155,188,255));


procedure IEAdjustTemperature(bitmap:TIEBitmap; x1, y1, x2, y2:integer; temperature:integer; fOnProgress:TIEProgressEvent; Sender:TObject);
var
  i, j:integer;
  px:PRGB;
  temp_idx:integer;
  LUT_R, LUT_G, LUT_B:array [0..255] of byte;
  lprog, prog:integer;
begin
  x2 := imin(x2, bitmap.Width);  dec(x2);
  y2 := imin(y2, bitmap.Height); dec(y2);

  temperature := imax(1000, imin(40000, temperature));
  temp_idx := imin(trunc(temperature/100-10), high(temps));

  for i:=0 to 255 do
  begin
    LUT_R[i] := trunc( i * temps[temp_idx][0] / 255  );
    LUT_G[i] := trunc( i * temps[temp_idx][1] / 255  );
    LUT_B[i] := trunc( i * temps[temp_idx][2] / 255  );
  end;

  lprog := -1;
  for i:=y1 to y2 do
  begin
    px := bitmap.Scanline[i]; inc(px, x1);
    for j:=x1 to x2 do
    begin
      px^.r := LUT_R[px^.r];
      px^.g := LUT_G[px^.g];
      px^.b := LUT_B[px^.b];
      inc(px);
    end;
    if assigned(fOnProgress) then
    begin
      prog := trunc(i/(y2-y1)*100);
      if prog<>lprog then
        fOnProgress(Sender, prog);
      lprog := prog;
    end;
  end;
end;

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
// Motion blur

{!!
<FS>TImageEnProc.MotionBlur

<FM>Declaration<FC>
procedure MotionBlur(angle:double; radius:integer = 8; sigma:integer = 7);

<FM>Description<FN>
Applies motion blur effect.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>angle<FN></C> <C>Specifies angle in degrees (0..360).</C> </R>
<R> <C><FC>radius<FN></C> <C>Radius of Gaussian kernel in pixels (>0).</C> </R>
<R> <C><FC>sigma<FN></C> <C>Standard deviation of Gaussian kernel in pixels (>0).</C> </R>
</TABLE>

<FM>Example<FC>
ImageEnView1.Proc.MotionBlur(45);
!!}
procedure TImageEnProc.MotionBlur(angle:double; radius:integer; sigma:integer);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB, ie8g], x1, y1, x2, y2, Format(IERS_MOTIONBLUR, [angle, radius, sigma]), ProcBitmap, mask) then
    exit;
  IEMotionBlur(ProcBitmap, angle, radius, sigma, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;


// supports: ie24RGB, ie8g
// sigma must be >0
procedure IEMotionBlur(bitmap:TIEBitmap; angle:double; radius:integer; sigma:integer; OnProgress:TIEProgressEvent; Sender:TObject);
var
  rangle:double;
  kernel:pdoublearray;
  i, ii, u, v, row, col:integer;
  gm, vx, vy:double;
  coords:pdouble;
  rr, gg, bb:double;
  kval:pdouble;
  dstrgb8, srcrgb8:PRGB;
  dstg8, srcg8:pbyte;
  kwidth:integer;
  bitmapWidth1, bitmapHeight1:integer;
  crd:pdouble;
  sg, sq:double;
  kwidth3, kwidth1:integer;
  dst:TIEBitmap;
begin

  if sigma<1 then
    exit;

  coords := nil;
  kernel := nil;
  dst := TIEBitmap.Create(bitmap.Width, bitmap.Height, bitmap.PixelFormat);

  try

    bitmapWidth1  := bitmap.Width-1;
    bitmapHeight1 := bitmap.Height-1;

    kwidth := imax(2*radius+1, 3);
    kwidth1 := kwidth-1;
    kwidth3 := kwidth*3-1;

    kernel := allocmem(sizeof(double)*kwidth);
    sg := 18*sigma*sigma;
    sq := sqrt(2*PI)*sigma;
    for i:=0 to kwidth3 do
    begin
      ii := i div 3;
      kernel[ii] := kernel[ii] + exp(-(i*i)/sg)/sq;
    end;
    gm := 0.0;
    for i:=0 to kwidth1 do
      gm := gm+kernel[i];
    for i:=0 to kwidth1 do
      kernel[i] := kernel[i]/gm;

    coords := allocmem(2*kwidth*sizeof(double));

    rangle := PI*angle/180;

    vx := round(kwidth*sin(rangle));
    vy := round(kwidth*cos(rangle));
    vx := vx/sqrt(vx*vx+vy*vy);
    vy := vy/sqrt(vx*vx+vy*vy);
    crd := coords;
    for i:=0 to kwidth1 do
    begin
      crd^ := i*vy; inc(crd);
      crd^ := i*vx; inc(crd);
    end;

    for row:=0 to bitmapHeight1 do
    begin
      case bitmap.PixelFormat of
        ie24RGB:
          begin
            dstrgb8 := dst.Scanline[row];
            for col:=0 to bitmapWidth1 do
            begin
              rr := 0.0;
              gg := 0.0;
              bb := 0.0;
              gm := 0.0;
              kval := @kernel[0];
              crd := coords;
              for i:=0 to kwidth1 do
              begin
                u := round(col+crd^); inc(crd); if u<0 then u:=0 else if u>bitmapWidth1 then u:=bitmapWidth1;
                v := round(row+crd^); inc(crd); if v<0 then v:=0 else if v>bitmapHeight1 then v:=bitmapHeight1;
                srcrgb8 := bitmap.Scanline[v]; inc(srcrgb8, u);
                rr := rr + kval^ * srcrgb8^.r;
                gg := gg + kval^ * srcrgb8^.g;
                bb := bb + kval^ * srcrgb8^.b;
                gm := gm + kval^;
                inc(kval);
              end;
              if abs(gm) <= 1.0e-6 then
                with dstrgb8^ do
                begin
                  r := blimit(trunc(rr));
                  g := blimit(trunc(gg));
                  b := blimit(trunc(bb));
                end
              else
                with dstrgb8^ do
                begin
                  gm := 1/gm;
                  r := blimit(trunc(gm*rr));
                  g := blimit(trunc(gm*gg));
                  b := blimit(trunc(gm*bb));
                end;
              inc(dstrgb8);
            end;
          end;
        ie8g:
          begin
            dstg8 := dst.Scanline[row];
            for col:=0 to bitmapWidth1 do
            begin
              gg := 0.0;
              gm := 0.0;
              kval := @kernel[0];
              crd := coords;
              for i:=0 to kwidth1 do
              begin
                u := round(col+crd^); inc(crd); if u<0 then u:=0 else if u>bitmapWidth1 then u:=bitmapWidth1;
                v := round(row+crd^); inc(crd); if v<0 then v:=0 else if v>bitmapHeight1 then v:=bitmapHeight1;
                srcg8 := bitmap.Scanline[v]; inc(srcg8, u);
                gg := gg + kval^ * srcg8^;
                gm := gm + kval^;
                inc(kval);
              end;
              if abs(gm) <= 1.0e-6 then
                dstg8^ := blimit(trunc(gg))
              else
                dstg8^ := blimit(trunc(gm*gg));
              inc(dstg8);
            end;
          end;
      end;
      if assigned(OnProgress) then
        OnProgress(Sender, trunc(row/bitmapHeight1*100));
    end;
    bitmap.AssignImage(dst);

    if bitmap.HasAlphaChannel then
      IEMotionBlur(bitmap.AlphaChannel, angle, radius, sigma, nil, nil);

  finally
    freemem(kernel);
    freemem(coords);
    dst.Free;
  end;
end;


///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
// Random

{!!
<FS>TImageEnProc.Random

<FM>Declaration<FC>
procedure Random(mean:double = 0.5; stdDev:double = 0.123);

<FM>Description<FN>
Fills selected pixels with random values (Gaussian distribution).
Random values are mutiplied by 255 and truncated to the range 0..255.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>mean<FN></C> <C>Mean value. 0.5 = gray (128).</C> </R>
<R> <C><FC>stdDev<FN></C> <C>Standard deviation about mean.</C> </R>
</TABLE>
!!}
procedure TImageEnProc.Random(mean:double; stdDev:double);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB, ie8g], x1, y1, x2, y2, Format(IERS_RANDOM, [mean, stdDev]), ProcBitmap, mask) then
    exit;
  IERandom(ProcBitmap, mean, stdDev, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

function IERandG(Mean, StdDev: double):double;
var
  U1, S2: double;
begin
  repeat
    U1 := 2*Random - 1;
    S2 := Sqr(U1) + Sqr(2*Random-1);
  until S2 < 1;
  Result := Sqrt(-2*Ln(S2)/S2) * U1 * StdDev + Mean;
end;

procedure IERandom(bitmap:TIEBitmap; mean:double; stdDev:double; x1, y1, x2, y2:integer; OnProgress:TIEProgressEvent; Sender:TObject);
var
  i, j:integer;
  dstrgb8:PRGB;
  dstg8:pbyte;
begin
  x2 := imin(x2, bitmap.Width);  dec(x2);
  y2 := imin(y2, bitmap.Height); dec(y2);
  case bitmap.PixelFormat of

    ie24RGB:
      for i:=y1 to y2 do
      begin
        dstrgb8 := bitmap.Scanline[i]; inc(dstrgb8, x1);
        for j:=x1 to x2 do
        begin
          dstrgb8^.r := blimit(round(IERandG(mean, stdDev)*255));
          dstrgb8^.g := blimit(round(IERandG(mean, stdDev)*255));
          dstrgb8^.b := blimit(round(IERandG(mean, stdDev)*255));
          inc(dstrgb8);
        end;
      end;

    ie8g:
      for i:=y1 to y2 do
      begin
        dstg8 := bitmap.Scanline[i]; inc(dstg8, x1);
        for j:=x1 to x2 do
        begin
          dstg8^ := blimit(round(IERandG(mean, stdDev)*255));
          inc(dstg8);
        end;
      end;

  end;
end;



///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnProc.MapGrayToColor

<FM>Declaration<FC>
procedure MapGrayToColor(map:array of TRGB);

<FM>Description<FN>
Maps each gray scale level to specified RGB color, using provided map.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>map<FN></C> <C>Array of 256 elements of TRGB values.</C> </R>
</TABLE>

<FM>Example<FC>
var
  map:array [0..255] of TRGB;
  i:integer;
begin
  for i:=0 to 255 do
  begin
    map[i].r := i;
    map[i].g := 255-i;
    map[i].b := i;
  end;
  ImageEnView1.IO.LoadFromFile('grayimage.jpg');
  ImageEnView1.Proc.MapGrayToColor(map);
end;
!!}
procedure TImageEnProc.MapGrayToColor(map:array of TRGB);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_MAPGRAYTOCOLOR, ProcBitmap, mask) then
    exit;
  IEMapGrayToColor(ProcBitmap, map, x1, y1, x2, y2, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

// accepts only ie24RGB format.
// output is always ie24RGB
procedure IEMapGrayToColor(Bitmap:TIEBitmap; map:array of TRGB; x1, y1, x2, y2:integer; OnProgress:TIEProgressEvent; Sender:TObject);
var
  p_rgb:PRGB;
  i, j, gray:integer;
begin
  x2 := imin(x2, bitmap.Width);  dec(x2);
  y2 := imin(y2, bitmap.Height); dec(y2);
  for i:=y1 to y2 do
  begin
    p_rgb := Bitmap.Scanline[i]; inc(p_rgb, x1);
    for j:=x1 to x2 do
    begin
      with p_rgb^ do
        gray := (r * gRedToGrayCoef + g * gGreenToGrayCoef + b * gBlueToGrayCoef) div 100;
      p_rgb^ := map[gray];
      inc(p_rgb);
    end;
  end;
end;


///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

{$ifdef IEINCLUDEFFT}

procedure IEFTClearZone(Bitmap:TIEBitmap; x1, y1, x2, y2:integer; tx1, ty1, tx2, ty2:integer; GrayScale:boolean; OnProgress:TIEProgressEvent; Sender:TObject);
var
  FTImage:TIEFtImage;
  nw, nh, wh:integer;
  zx, zy:double;
begin
  FTImage := TIEFtImage.Create;
  try
    FTImage.OnProgress := OnProgress;
    if GrayScale then
      FTImage.BuildFT(Bitmap, ieitGRAYSCALE)
    else
      FTImage.BuildFT(Bitmap, ieitRGB);

    TIEFtImage.CalcSuitableSourceSize(Bitmap.Width, Bitmap.Height, nw, nh);
    TIEFtImage.CalcFFTImageSize(nw, nh, wh);
    zx := FTImage.ComplexWidth / wh;
    zy := FTImage.ComplexHeight / wh;

    FTImage.ClearZone(trunc(tx1*zx), trunc(ty1*zy), trunc(tx2*zx), trunc(ty2*zy));

    FTImage.BuildBitmap(Bitmap);

  finally
    FTImage.Free;
  end;
end;


{!!
<FS>TImageEnProc.FTClearZone

<FM>Declaration<FC>
procedure FTClearZone(tx1, ty1, tx2, ty2:integer; GrayScale:boolean);

<FM>Description<FN>


<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>tx1<FN></C> <C>Left coordinate of reduced FFT map. Corresponds to <A TImageEnProc.IPDialogParams>.FFT_Left.</C> </R>
<R> <C><FC>ty1<FN></C> <C>Top coordinate of reduced FFT map. Corresponds to <A TImageEnProc.IPDialogParams>.FFT_Top.</C> </R>
<R> <C><FC>tx2<FN></C> <C>Right coordinate of reduced FFT map. Corresponds to <A TImageEnProc.IPDialogParams>.FFT_Right.</C> </R>
<R> <C><FC>ty2<FN></C> <C>Bottom coordinate of reduced FFT map. Corresponds to <A TImageEnProc.IPDialogParams>.FFT_Bottom.</C> </R>
<R> <C><FC>GrayScale<FN></C> <C>Makes the bitmap grayscale. Corresponds to <A TImageEnProc.IPDialogParams>.FFT_GrayScale.</C> </R>
</TABLE>

<FM>Example<FC>
ImageEnView1.Proc.FTClearZone(ImageEnView1.Proc.IPDialogParams.FFT_Left, ImageEnView1.Proc.IPDialogParams.FFT_Top, ImageEnView1.Proc.IPDialogParams.FFT_Right, ImageEnView1.Proc.IPDialogParams.FFT_Bottom, ImageEnView1.Proc.IPDialogParams.FFT_GrayScale);
!!}
procedure TImageEnProc.FTClearZone(tx1, ty1, tx2, ty2:integer; GrayScale:boolean);
var
  ProcBitmap: TIEBitmap;
  mask: TIEMask;
  x1, y1, x2, y2: integer;
begin
  if not BeginImageProcessing([ie24RGB], x1, y1, x2, y2, IERS_FTCLEARZONE, ProcBitmap, mask) then
    exit;
  IEFTClearZone(ProcBitmap, x1, y1, x2, y2, tx1, ty1, tx2, ty2, GrayScale, fOnProgress, self);
  EndImageProcessing(ProcBitmap, mask);
  DoFinishWork;
end;

{$endif}

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////



procedure IEInitialize_imageenproc;
begin
  MakeC1TO24;
  IEInitFilterPresets;
  IERAWCLIPFORMAT := RegisterClipboardFormat(PChar(string(IERAWCLIPFORMAT_NAME)));
end;

procedure IEFinalize_imageenproc;
begin
  IEFreeFilterPresets;
end;


end.



