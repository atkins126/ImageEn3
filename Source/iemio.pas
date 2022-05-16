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
File version 1011
*)

unit iemio;

{$R-}
{$Q-}

{$I ie.inc}

{$IFDEF IEINCLUDEMULTIVIEW}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Printers,
  ImageEnView, ImageEnProc, ExtCtrls, hyiedefs, ImageEnIO, ieview,
{$IFDEF IEINCLUDEWIA}
  iewia,
{$ENDIF}
  hyieutils, pcxfilter;

type

{!!
<FS>TImageEnMIO

<FM>Description<FN>
TImageEnMIO loads/saves and acquires multi-images. It must be attached to <A TImageEnMView>.
TImageEnMIO can load animated GIF, multi-image TIFF, AVI and acquire multi-page from TWain scanners.
It can also save animated GIF, multi-images TIFF and AVI.

Note: Users often attach a <A TImageEnIO> component to <A TImageEnMView> component. This is not correct. The TImageEnMIO component must be attached only to a <A TImageEnMView> component.



<FM>Methods and Properties<FN>


  <FI>TWain/WIA scanner<FN>
  <A TImageEnMIO.AcquireClose>
  <A TImageEnMIO.AcquireOpen>
  <A TImageEnMIO.Acquire>
  <A TImageEnMIO.SelectAcquireSource>
  <A TImageEnMIO.TWainParams>
  <A TImageEnMIO.WIAParams>

  <FI>Generic input/output<FN>
  <A TImageEnMIO.Aborting>
  <A TImageEnMIO.AllowMalformedPages>
  <A TImageEnMIO.AutoAdjustDPI>
  <A TImageEnMIO.AttachedMView>
  <A TImageEnMIO.DefaultDitherMethod>
  <A TImageEnMIO.DuplicateCompressionInfo>
  <A TImageEnMIO.ExecuteOpenDialog>
  <A TImageEnMIO.ExecuteSaveDialog>
  <A TImageEnMIO.FilteredAdjustDPI>
  <A TImageEnMIO.LoadFromBuffer>
  <A TImageEnMIO.LoadFromFileAuto>
  <A TImageEnMIO.LoadFromFileFormat>
  <A TImageEnMIO.LoadFromFile>
  <A TImageEnMIO.LoadFromFiles>
  <A TImageEnMIO.LoadFromStreamFormat>
  <A TImageEnMIO.LoadFromStream>
  <A TImageEnMIO.LoadFromURL>
  <A TImageEnMIO.NativePixelFormat>
  <A TImageEnMIO.Params>
  <A TImageEnMIO.ParamsCount>
  <A TImageEnMIO.ProxyAddress>
  <A TImageEnMIO.ProxyPassword>
  <A TImageEnMIO.ProxyUser>
  <A TImageEnMIO.SaveToFile>
  <A TImageEnMIO.Update>

  <FI>Dialogs<FN>
  <A TImageEnMIO.DialogsMeasureUnit>
  <A TImageEnMIO.DoPreviews>
  <A TImageEnMIO.MsgLanguage>
  <A TImageEnMIO.PreviewFont>
  <A TImageEnMIO.PreviewsParams>
  <A TImageEnMIO.SimplifiedParamsDialogs>

  <FI>Printing<FN>
  <A TImageEnMIO.DoPrintPreviewDialog>
  <A TImageEnMIO.PrintImage>
  <A TImageEnMIO.PrintImagePos>
  <A TImageEnMIO.PrintImages>
  <A TImageEnMIO.PrintingFilterOnSubsampling>
  <A TImageEnMIO.PrintPreviewParams>

  <FI>AVI<FN>
  <A TImageEnMIO.LoadFromFileAVI>
  <A TImageEnMIO.SaveToFileAVI>

  <FI>DCX<FN>
  <A TImageEnMIO.LoadFromFileDCX>
  <A TImageEnMIO.LoadFromStreamDCX>
  <A TImageEnMIO.SaveToFileDCX>
  <A TImageEnMIO.SaveToStreamDCX>

  <FI>GIF<FN>
  <A TImageEnMIO.LoadFromFileGIF>
  <A TImageEnMIO.LoadFromStreamGIF>
  <A TImageEnMIO.SaveToFileGIF>
  <A TImageEnMIO.SaveToStreamGIF>

  <FI>ICO<FN>
  <A TImageEnMIO.LoadFromFileICO>
  <A TImageEnMIO.LoadFromStreamICO>
  <A TImageEnMIO.SaveToFileICO>
  <A TImageEnMIO.SaveToStreamICO>

  <FI>TIFF<FN>
  <A TImageEnMIO.LoadFromFileTIFF>
  <A TImageEnMIO.LoadFromStreamTIFF>
  <A TImageEnMIO.SaveToFileTIFF>
  <A TImageEnMIO.SaveToStreamTIFF>

  <FI>DirectShow media files<FN>
  <A TImageEnMIO.LoadFromMediaFile>

  <FI>Adobe PDF<FN>
  <A TImageEnMIO.SaveToFilePDF>
  <A TImageEnMIO.SaveToStreamPDF>

  <FI>PostScript<FN>
  <A TImageEnMIO.SaveToFilePS>
  <A TImageEnMIO.SaveToStreamPS>

  <FI>DICOM medical imaging<FN>
  <A TImageEnMIO.LoadFromFileDICOM>
  <A TImageEnMIO.LoadFromStreamDICOM>


<FM>Events<FN>

  <A TImageEnMIO.OnAcquireBitmap>
  <A TImageEnMIO.OnAfterAcquireBitmap>
  <A TImageEnMIO.OnDoPreviews>
  <A TImageEnMIO.OnFinishWork>
  <A TImageEnMIO.OnProgress>
!!}
  TImageEnMIO = class(TComponent)
  private
    { Private declarations }
    fImageEnMView: TIEView;
    fImageEnMViewBitmapChangeHandle:pointer; // bitmap change handler (nil=none)
    fParams: TList; // list of TIOParamasVals
    fSimplifiedParamsDialogs: boolean;
{$IFDEF IEINCLUDETWAIN}
    fTwainParams: TIETWainParams;
{$ENDIF}
    // WIA
{$IFDEF IEINCLUDEWIA}
    fWIA: TIEWia;
{$ENDIF}
    fMsgLanguage: TMsgLanguage;
    fPreviewsParams: TIOPreviewsParams;
    fPreviewFont: TFont;
    fTWainNextToInsert: integer; // index of next image to insert (twain multipage acq.)
    fAutoAdjustDPI: boolean;
    fFilteredAdjustDPI: boolean;
    fDefaultDitherMethod: TIEDitherMethod;
    fResetPrinter: boolean;
    fDialogsMeasureUnit: TIEDialogsMeasureUnit;
    fNativePixelFormat:boolean;
    fPrintingFilterOnSubsampling: TResampleFilter;
    fOnDoPreviews: TIEDoPreviewsEvent;
    fLoadingFileName:string;  // used when a LoadFromFile calls LoadFromStream to fill Params.FileName
    fAllowMalformedPages:boolean;
    // TWain modeless
    fgrec: pointer;
    // proxy settings
    fProxyAddress, fProxyUser, fProxyPassword: string;
    {$IFDEF IEINCLUDEPRINTDIALOGS}
    fPrintPreviewParams:TIOPrintPreviewParams;
    {$ENDIF}
    //
    procedure SetAttachedMView(v: TIEView);
    procedure RemoveIOParam(idx: integer);
    procedure InsertIOParam(idx: integer);
    procedure MoveIOParams(idx:integer; destination:integer);
    procedure SwapIOParams(idx1,idx2:integer);
    function GetParams(idx: integer): TIOParamsVals;
    procedure SetPreviewFont(f: TFont);
    function GetParamsCount: integer;
    procedure SetIOPreviewParams(v: TIOPreviewsParams);
    function GetIOPreviewParams: TIOPreviewsParams;
  protected
    { Protected declarations }
    fAborting: boolean;
    fOnProgress: TIEProgressEvent;
    fOnAcquireBitmap: TIEAcquireBitmapEvent;
    fOnAfterAcquireBitmap: TIEAfterAcquireBitmapEvent;
    fOnFinishWork: TNotifyEvent;
    procedure TWMultiCallBack(Bitmap: TIEBitmap; var IOParams: TObject); virtual;
    procedure TWCloseCallBack; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure OnBitmapChange(Sender: TObject; destroying: boolean);
    procedure DoFinishWork; virtual;
{$IFDEF IEINCLUDEWIA}
    function GetWIAParams: TIEWia; virtual;
    function WiaOnProgress(Percentage: integer): boolean;
{$ENDIF}
    procedure CheckDPI(p: TIOParamsVals);
  public
    { Public declarations }
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure Update;

{!!
<FS>TImageEnMIO.DefaultDitherMethod

<FM>Declaration<FC>
property DefaultDitherMethod:<A TIEDitherMethod>;

<FM>Description<FN>
DefaultDitherMethod specifies the default dithering method to apply when a color image needs to be converted to black/white.
ieThreshold is the default.
!!}
    property DefaultDitherMethod: TIEDitherMethod read fDefaultDitherMethod write fDefaultDitherMethod;

    // Other
    property Params[idx: integer]: TIOParamsVals read GetParams;
    property ParamsCount: integer read GetParamsCount;
    procedure DuplicateCompressionInfo;

{!!
<FS>TImageEnMIO.AllowMalformedPages

<FM>Declaration<FC>
property AllowMalformedPages:boolean;

<FM>Description<FN>
If true malformed pages (for example loading a corrupted or out of standard TIFF), if possible, will be loaded anyway.
Default is False (stop loading).
!!}
    property AllowMalformedPages:boolean read fAllowMalformedPages write fAllowMalformedPages;

{$IFDEF IEINCLUDEDIALOGIO}
    function DoPreviews(idx: integer; pp: TPreviewParams): boolean;
{$ENDIF}
{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnMIO.TWainParams

<FM>Declaration<FC>
property TWainParams:<A TIETWainParams>;

<FM>Description<FN>
Use the TWainParams property to control scanner acquisition. You can enable/disable standard user interface, set pixeltype (Grayscale, RGB...), DPI, or select the acquire scanner without user interaction.
Look at <A TIETWainParams> object for more details.

<FM>Example<FC>

// Acquires a black/white (1bit) image
ImageEnMView1.MIO.TWainParams.PixelType.CurrentValue:=0;
ImageEnMView1.MIO.TWainParams.VisibleDialog:=False;
ImageEnMView1.MIO.Acquire;
!!}
    property TWainParams: TIETWainParams read fTWainParams;

{$ENDIF}
{$IFDEF IEINCLUDEWIA}
    property WIAParams: TIEWia read GetWIAParams;
{$ENDIF}

{!!
<FS>TImageEnMIO.Aborting

<FM>Declaration<FC>
property Aborting: boolean;

<FM>Description<FN>
Applications can abort save/load processing by assigning True to the Aborting property. On loading, the image will be truncated. On saving, the file will be closed and truncated (and will be unreadable).
You can also read the <A TImageEnMIO.Aborting> property to know when aborting is in progress.
!!}
    property Aborting: boolean read fAborting write fAborting;

    // GIF
    procedure LoadFromFileGIF(const FileName: string);
    procedure LoadFromStreamGIF(Stream: TStream);
    procedure SaveToFileGIF(const FileName: string);
    procedure SaveToStreamGIF(Stream: TStream);
    // DCX
    procedure LoadFromFileDCX(const FileName:string);
    procedure LoadFromStreamDCX(Stream:TStream);
    procedure SaveToFileDCX(const FileName:string);
    procedure SaveToStreamDCX(Stream:TStream);
    // DICOM
    {$ifdef IEINCLUDEDICOM}
    procedure LoadFromFileDICOM(const FileName:string);
    procedure LoadFromStreamDICOM(Stream:TStream);
    {$endif}
    // TIFF
    procedure LoadFromFileTIFF(const FileName: string);
    procedure LoadFromStreamTIFF(Stream: TStream);
    procedure SaveToFileTIFF(const FileName:string; SaveSelected:boolean = false);
    procedure SaveToStreamTIFF(Stream:TStream; SaveSelected:boolean = false);
    // AVI
    procedure LoadFromFileAVI(const FileName: string);
    procedure SaveToFileAVI(const FileName: string; const codec: AnsiString = '');
    // PostScript (PS)
    procedure SaveToFilePS(const FileName: string);
    procedure SaveToStreamPS(Stream: TStream);
    // Adobe PDF
    {$ifdef IEINCLUDEPDFWRITING}
    procedure SaveToFilePDF(const FileName: string);
    procedure SaveToStreamPDF(Stream: TStream);
    {$endif}
    // ICO
    procedure LoadFromFileICO(const FileName: string);
    procedure LoadFromStreamICO(Stream: TStream);
    procedure SaveToFileICO(const FileName:string);
    procedure SaveToStreamICO(Stream:TStream);
    // URL
    procedure LoadFromURL(URL: string);
    // DirectShow media
    {$ifdef IEINCLUDEDIRECTSHOW}
    procedure LoadFromMediaFile(const FileName:string);
    {$endif}
    // TWAIN
{$IFDEF IEINCLUDETWAIN}
    function Acquire(api: TIEAcquireApi = ieaTWain): boolean;
    function SelectAcquireSource(api: TIEAcquireApi = ieaTWain): boolean;
    function AcquireOpen: boolean;
    procedure AcquireClose;
{$ENDIF}
    // General
    procedure LoadFromBuffer(Buffer:pointer; BufferSize:integer; Format:TIOFileType = ioUnknown);
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromFiles(const FileName: string; AutoDetect:boolean=false; LoadWhenViewed:boolean=false);
    procedure SaveToFile(const FileName: string);
    procedure LoadFromFileFormat(const FileName:string; FileFormat: TIOFileType);
    procedure LoadFromFileAuto(const FileName:string);
    procedure LoadFromStream(Stream:TStream);
    procedure LoadFromStreamFormat(Stream:TStream; FileFormat:TIOFileType);
{$IFDEF IEINCLUDEOPENSAVEDIALOGS}
    function ExecuteOpenDialog(InitialDir: string = ''; InitialFileName: string = ''; AlwaysAnimate: boolean = True; FilterIndex: integer = 1; ExtendedFilters: string = ''; MultiSelect:boolean=false; Title:WideString=''; Filter:WideString=''): string;
    function ExecuteSaveDialog(InitialDir: string = ''; InitialFileName: string = ''; AlwaysAnimate: boolean = False; FilterIndex: integer = 1; ExtendedFilters: string = ''; Title:WideString=''; Filter:WideString=''): string;
{$ENDIF}
{$IFDEF IEINCLUDEPRINTDIALOGS}
    function DoPrintPreviewDialog(const TaskName: string = ''; PrintAnnotations:boolean=false; const Caption:string=''): boolean;
{$ENDIF}
    property ResetPrinter: boolean read fResetPrinter write fResetPrinter;

{!!
<FS>TImageEnMIO.PrintPreviewParams

<FM>Declaration<FC>
property PrintPreviewParams:<A TIOPrintPreviewParams>;

<FM>Description<FN>
This property allows you to set/get parameters of print preview dialog.

All measure units are specified by <A TImageEnMIO.DialogsMeasureUnit> property.
!!}
{$IFDEF IEINCLUDEPRINTDIALOGS}
    property PrintPreviewParams:TIOPrintPreviewParams read fPrintPreviewParams;
{$ENDIF}


{!!
<FS>TImageEnMIO.NativePixelFormat

<FM>Declaration<FC>
property NativePixelFormat:boolean;

<FM>Description<FN>
By setting this property to True, you disable the conversion of paletted images and gray scale to 24 bit.
By default, ImageEn converts all paletted images to 24 bit (true color). Only black/white images are stored in the original format with 1 bit per pixel.

Note that setting NativePixelFormat=True, you will not be able to execute some image processing operations.
!!}
    property NativePixelFormat:boolean read fNativePixelFormat write fNativePixelFormat;

{!!
<FS>TImageEnMIO.PrintingFilterOnSubsampling

<FM>Declaration<FC>
property PrintingFilterOnSubsampling: <A TResampleFilter>;

<FM>Description<FN>
Specifies a filter when the image needs to be printed and it must be resampled. Filtering enhances the image quality but slows processing.
!!}
    property PrintingFilterOnSubsampling: TResampleFilter read fPrintingFilterOnSubsampling write fPrintingFilterOnSubsampling;

{!!
<FS>TImageEnMIO.ProxyAddress

<FM>Declaration<FC>
property ProxyAddress:string;

<FM>Description<FN>
ProxyAddress specifies the proxy address and port when using <A TImageEnMIO.LoadFromURL> method. The syntax is: 'domain:port'.

<FM>Example<FC>
ImageEnMView.MIO.ProxyAddress:='10.2.7.2:8080';
ImageEnMView.MIO.LoadFromURL('http://www.hicomponents.com/image.gif');
!!}
    property ProxyAddress: string read fProxyAddress write fProxyAddress;

{!!
<FS>TImageEnMIO.ProxyUser

<FM>Declaration<FC>
property ProxyUser:string;

<FM>Description<FN>
ProxyUser specifies the proxy userid when using <A TImageEnMIO.LoadFromURL> method.

<FM>Example<FC>
ImageEnMView.MIO.ProxyAddress:='10.2.7.2:8080';
ImageEnMView.MIO.ProxyUser:='testuser';
ImageEnMView.MIO.ProxyPassword:='testpassword';
ImageEnMView.MIO.LoadFromURL('http://www.hicomponents.com/image.gif');
!!}
    property ProxyUser: string read fProxyUser write fProxyUser;

{!!
<FS>TImageEnMIO.ProxyPassword

<FM>Declaration<FC>
property ProxyPassword:string;

<FM>Description<FN>
ProxyPassword specifies the proxy password when using <A TImageEnMIO.LoadFromURL> method.

<FM>Example<FC>
ImageEnMView.MIO.ProxyAddress:='10.2.7.2:8080';
ImageEnMView.MIO.ProxyUser:='testuser';
ImageEnMView.MIO.ProxyPassword:='testpassword';
ImageEnMView.MIO.LoadFromURL('http://www.hicomponents.com/image.gif');
!!}
    property ProxyPassword: string read fProxyPassword write fProxyPassword;

    procedure PrintImagePos(ImageIndex:integer; PrtCanvas:TCanvas; x,y:double; Width,Height:double; GammaCorrection:double=1);
    procedure PrintImage(ImageIndex:integer; PrtCanvas:TCanvas=nil; MarginLeft:double=1; MarginTop:double=1; MarginRight:double=1; MarginBottom:double=1; VerticalPos:TIEVerticalPos=ievpCENTER; HorizontalPos:TIEHorizontalPos=iehpCENTER; Size:TIESize=iesFITTOPAGE; SpecWidth:double=0; SpecHeight:double=0; GammaCorrection:double=1);
    procedure PrintImages(Columns:integer=2; Rows:integer=2; HorizSpace:double=0.5; VertSpace:double=0.5; PrintSelected:boolean=false; MarginLeft:double=0; MarginTop:double=0; MarginRight:double=0; MarginBottom:double=0; DrawBox:boolean=true; DrawText:boolean=true; DrawShadow:boolean=false);

  published
    { Published declarations }
    property AttachedMView: TIEView read fImageEnMView write SetAttachedMView;

{!!
<FS>TImageEnMIO.OnProgress

<FM>Declaration<FC>
property OnProgress: <A TIEProgressEvent>;

<FM>Description<FN>
OnProgress event is called upon input/output operations.
!!}
    property OnProgress: TIEProgressEvent read fOnProgress write fOnProgress;

{!!
<FS>TImageEnMIO.OnAcquireBitmap

<FM>Declaration<FC>
property OnAcquireBitmap:<A TIEAcquireBitmapEvent>;

<FM>Description<FN>

OnAcquireBitmap occurs whenever the scanner acquires an image.
!!}
    property OnAcquireBitmap: TIEAcquireBitmapEvent read fOnAcquireBitmap write fOnAcquireBitmap;

{!!
<FS>TImageEnMIO.OnAfterAcquireBitmap

<FM>Declaration<FC>
property OnAfterAcquireBitmap:<A TIEAfterAcquireBitmapEvent>;

<FM>Description<FN>

OnAfterAcquireBitmap occurs just after an image acquired from scanner and hence added to the image list.
!!}
    property OnAfterAcquireBitmap: TIEAfterAcquireBitmapEvent read fOnAfterAcquireBitmap write fOnAfterAcquireBitmap;

{!!
<FS>TImageEnMIO.MsgLanguage

<FM>Declaration<FC>
property MsgLanguage: <A TMsgLanguage>;

<FM>Description<FN>
This property sets the language for Input/output previews (IOPreviews) dialogs (Previews).
!!}
    property MsgLanguage: TMsgLanguage read fMsgLanguage write fMsgLanguage default msSystem;

    property PreviewsParams: TIOPreviewsParams read GetIOPreviewParams write SetIOPreviewParams default [];
    property PreviewFont: TFont read fPreviewFont write SetPreviewFont;

{!!
<FS>TImageEnMIO.AutoAdjustDPI

<FM>Declaration<FC>
property AutoAdjustDPI:boolean;

<FM>Description<FN>
When AutoAdjustDPI is True and last loaded/scanned image has horizontal DPI not equal to vertical DPI, ImageEn resizes the image making DPIX=DPIY.
The default is False.
!!}
    property AutoAdjustDPI: boolean read fAutoAdjustDPI write fAutoAdjustDPI default false;

{!!
<FS>TImageEnMIO.FilteredAdjustDPI

<FM>Declaration<FC>
property FilteredAdjustDPI:boolean;

<FM>Description<FN>
The FilteredAdjustDPI property is valid when <A TImageEnMIO.AutoAdjustDPI> is true. If set to True, ImageEn applies a resampling filter to the image to enhance quality.
It can slow down the loading process.
!!}
    property FilteredAdjustDPI: boolean read fFilteredAdjustDPI write fFilteredAdjustDPI default false;

{!!
<FS>TImageEnMIO.SimplifiedParamsDialogs

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
<FS>TImageEnMIO.OnFinishWork

<FM>Declaration<FC>
property OnFinishWork:TNotifyEvent;

<FM>Description<FN>
OnFinishWork occurs when an input/output task ends. It is useful in resetting progress bars, or to know when a thread ends in a asynchronous mode.
!!}
    property OnFinishWork: TNotifyEvent read fOnFinishWork write fOnFinishWork;

{!!
<FS>TImageEnMIO.DialogsMeasureUnit

<FM>Declaration<FC>
property DialogsMeasureUnit:<A TIEDialogsMeasureUnit>

<FM>Description<FN>
The DialogsMeasureUnit property specifies the measurement unit used in the print preview dialog (see <A TImageEnMIO.DoPrintPreviewDialog>).

<FM>Example<FC>

ImageEnView.MIO.DialogsMeasureUnit:=ieduCm;
ImageEnView.MIO.DoPrintPreviewDialog('');
!!}
    property DialogsMeasureUnit: TIEDialogsMeasureUnit read fDialogsMeasureUnit write fDialogsMeasureUnit default ieduInches;

{!!
<FS>TImageEnMIO.OnDoPreviews

<FM>Declaration<FC>
property OnDoPreviews: <A TIEDoPreviewsEvent>;

<FM>Description<FN>
OnDoPreviews occurs just before DoPreviews is called or “Advanced” button is clicked (save dialog).
You can avoid to display the dialog setting Handled parameter True so to display a custom dialog.
!!}
    property OnDoPreviews: TIEDoPreviewsEvent read fOnDoPreviews write fOnDoPreviews;

  end;

implementation

uses Dialogs, GIFFilter, TIFFilt, IEVfw, imscan, iopreviews, IEMView, IEOpenSaveDlg, bmpfilt, ieprnform3, ieds, iedicom, iewic;

{$R-}

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.AttachedMView

<FM>Declaration<FC>
property AttachedMView: <A TImageEnMView>;

<FM>Description<FN>
This property specifies the attached TImageEnMView component. You must set this property to use TImageEnMIO.
!!}
procedure TImageEnMIO.SetAttachedMView(v: TIEView);
begin
  if assigned(fImageEnMView) then
    fImageEnMView.RemoveBitmapChangeEvent(fImageEnMViewBitmapChangeHandle); // remove previous, if exists
  fImageEnMView := v;
  if assigned(fImageEnMView) then
  begin // fImageEnMView now could be "nil"
    fImageEnMView.FreeNotification(self);
    fImageEnMViewBitmapChangeHandle := fImageEnMView.RegisterBitmapChangeEvent(OnBitmapChange);
    // synchronize parameters count
    while ParamsCount < (fImageEnMview as TImageEnMView).ImageCount do
      InsertIOParam(ParamsCount);
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////

procedure TImageEnMIO.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = fImageEnMView) and (Operation = opRemove) then
  begin
    fImageEnMView.RemoveBitmapChangeEvent(fImageEnMViewBitmapChangeHandle);
    fImageEnMView := nil;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////

constructor TImageEnMIO.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  //
  fImageEnMViewBitmapChangeHandle := nil;
  fAborting := false;
  fImageEnMView := nil;
  fOnProgress := nil;
  fOnFinishWork := nil;
  fParams := TList.Create;
{$IFDEF IEINCLUDETWAIN}
  fTWainParams := TIETWainParams.Create(Self);
{$ENDIF}
  fPreviewsParams := [];
  fPreviewFont := TFont.Create;
  fMsgLanguage := msSystem;
  fAutoAdjustDPI := false;
  fFilteredAdjustDPI := false;
  fOnAcquireBitmap := nil;
  fOnAfterAcquireBitmap := nil;
  fOnDoPreviews := nil;
  fgrec := nil;
  fDefaultDitherMethod := ieThreshold;
  SimplifiedParamsDialogs := true;
{$IFDEF IEINCLUDEWIA}
  fWIA := nil;
{$ENDIF}
  fResetPrinter := true;
  fDialogsMeasureUnit := ieduInches;
  fNativePixelFormat:=false;
  fPrintingFilterOnSubsampling := rfFastLinear;
  ProxyAddress := '';
  ProxyUser := '';
  ProxyPassword := '';
  {$IFDEF IEINCLUDEPRINTDIALOGS}
  fPrintPreviewParams:=TIOPrintPreviewParams.Create;
  {$ENDIF}
  fLoadingFileName := '';
  fAllowMalformedPages := false;
end;

/////////////////////////////////////////////////////////////////////////////////////

destructor TImageEnMIO.Destroy;
begin
  if assigned(fImageEnMView) then
    fImageEnMView.RemoveBitmapChangeEvent(fImageEnMViewBitmapChangeHandle);
  while fParams.Count > 0 do
    RemoveIOParam( fParams.Count-1 );
  FreeAndNil(fParams);
{$IFDEF IEINCLUDETWAIN}
  FreeAndNil(fTWainParams);
{$ENDIF}
{$IFDEF IEINCLUDEWIA}
  if assigned(fWia) then
    FreeAndNil(fWia);
{$ENDIF}
  FreeAndNil(fPreviewFont);
  {$IFDEF IEINCLUDEPRINTDIALOGS}
  FreeAndNil(fPrintPreviewParams);
  {$ENDIF}
  inherited;
end;

{!!
<FS>TImageEnMIO.Update

<FM>Declaration<FC>
procedure Update;

<FM>Description<FN>
Update calls the Update method of the attached <A TImageEnMView> component.
!!}
procedure TImageEnMIO.Update;
begin
  if assigned(fImageEnMView) then
    with fImageEnMView do
    begin
      Update;
      ImageChange;
    end;
end;


// called after registering using RegisterBitmapChangeEvent
// Realign I/O parameters with TImageEnMView
procedure TImageEnMIO.OnBitmapChange(Sender: TObject; destroying: boolean);
var
  lop, lidx, p1: integer;
begin
  if destroying then
    fImageEnMView := nil
  else if assigned(fImageEnMView) then
  begin
    lop := (fImageEnMView as TImageEnMView).GetLastOp;
    lidx := (fImageEnMView as TImageEnMView).GetLastOpIdx;
    p1 := (fImageEnMView as TImageEnMView).GetLastOpP1;
    case lop of
      1:
        // Inserting lidx
        InsertIOParam(lidx);
      2:
        // deleting lidx
        RemoveIOParam(lidx);
      3:
        // moving
        MoveIOParams(lidx,p1);
      4:
        // swap
        SwapIOParams(lidx,p1);
    end;
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.ParamsCount

<FM>Declaration<FC>
property ParamsCount:integer;

<FM>Description<FN>
ParamsCount is the number of elements in the Params property (alias number of images contained in <A TImageEnMView> attached object).

Read-only

!!}
function TImageEnMIO.GetParamsCount: integer;
begin
  result := fParams.Count;
end;

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.LoadFromFileGIF

<FM>Declaration<FC>
procedure LoadFromFileGIF(const FileName: string);

<FM>Description<FN>
Use LoadFromFileGIF to cause loading a GIF file.

If the file does not represent a valid image format, the <A TImageEnMIO.Aborting> property is True.
FileName is the file name with extension.

!!}
procedure TImageEnMIO.LoadFromFileGIF(const FileName: string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
  fLoadingFileName:=FileName;
  LoadFromStreamGIF(fs);
  finally
    fLoadingFileName:='';
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnMIO.LoadFromStreamGIF

<FM>Declaration<FC>
procedure LoadFromStreamGIF(Stream: TStream);

<FM>Description<FN>
LoadFromStreamGIF a GIF from a stream. Inserts the image from <A TImageEnMView.SelectedImage>.

If the stream does not represent a valid image format, the <A TImageEnMIO.Aborting> property is True.

!!}
procedure TImageEnMIO.LoadFromStreamGIF(Stream: TStream);
var
  bmp, xbmp, merged: TIEBitmap;
  p1:int64;
  numi, idx: integer;
  Progress, Progress2: TProgressRec;
  Param: TIOParamsVals;
  ld, im: integer; // last delay
  tempAlphaChannel: TIEMask;
  dummy1: ppointerarray;
  dummy2, dummy3: pinteger;
  act: TIEGIFAction;
  backx, backy, backw, backh: integer;
  dx, dy: integer;
  OriginalPixelFormat:TIEPixelFormat;
begin
  if not assigned(fImageEnMView) then
    exit;

  merged := nil;
  xbmp := nil;

  try
    (fImageEnMView as TImageEnMView).LockPaint;
    fAborting := False;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    Progress2.fOnProgress := nil;
    Progress2.Sender := nil;
    Progress2.Aborting := @fAborting;
    p1 := Stream.Position;

    idx:=(fImageEnMView as TImageEnMView).SelectedImage;
    if idx=-1 then
      idx:=(fImageEnMView as TImageEnMView).ImageCount;

    ld := 100; // 10ms default
    im := 0;
    merged := TIEBitmap.Create;
    merged.Location := ieMemory;
    act := ioGIF_None;
    backw := 0;
    backh := 0;
    backx := 0;
    backy := 0;
    repeat
      (fImageEnMView as TImageEnMView).InsertImageEx(idx);
      bmp := TIEBitmap.Create;
      try
        Param := Params[idx];
        Stream.position := p1;
        Param.GIF_ImageIndex := im;
        Param.IsNativePixelFormat := fNativePixelFormat;
        tempAlphaChannel := nil;
        ReadGIFStream(Stream, bmp, numi, Param, Progress2, False, tempAlphaChannel, false);
        if (bmp.Width=0) or (bmp.Height=0) then
          fAborting := true;
        OriginalPixelFormat:=bmp.PixelFormat;
        dx := imax(Param.GIF_WinWidth, bmp.Width);
        dy := imax(Param.GIF_WinHeight, bmp.Height);
        if assigned(tempAlphaChannel) then
        begin
          bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
          FreeAndNil(tempAlphaChannel);
        end;
        if fAutoAdjustDPI then
          xbmp := IEAdjustDPI(bmp, Param, fFilteredAdjustDPI)
        else
          xbmp := bmp;
      finally
        if bmp <> xbmp then
          FreeAndNil(bmp);
      end;
      bmp := xbmp;

      if numi > 1 then
      begin
        if act = ioGIF_DrawBackground then
        begin
          merged.FillRect(backx, backy, backx + backw - 1, backy + backh - 1, TRGB2TColor(param.GIF_Background));
          merged.AlphaChannel.FillRect(backx, backy, backx + backw - 1, backy + backh - 1, 0);  //*
        end;
        if (merged.Width = 0) then
        begin
          //merged.Allocate(dx, dy, bmp.PixelFormat);
          merged.Allocate(dx, dy, ie24RGB);
          merged.Fill(TRGB2TColor(param.GIF_Background));
          merged.AlphaChannel.Fill(0);//*
        end;
        if merged.PixelFormat<>ie24RGB then
          merged.PixelFormat:=ie24RGB;
        if (dx > merged.Width) or (dy > merged.Height) then
          merged.Resize(dx, dy, TRGB2TColor(param.GIF_Background), 255, iehLeft, ievTop);
        dummy1 := nil;
        dummy2 := nil;
        dummy3 := nil;

        bmp.RenderToTIEBitmap(merged, dummy1, dummy2, dummy3, nil, Param.GIF_XPos, Param.GIF_YPos, bmp.Width, bmp.Height, 0, 0, bmp.Width, bmp.Height, true, false, 255, rfNone, true, ielNormal);

        bmp.MergeAlphaRectTo(merged, 0,0, Param.GIF_XPos, Param.GIF_YPos, bmp.Width,bmp.Height);
        merged.AlphaChannel.Full:=False;

        backw := bmp.Width;
        backh := bmp.Height;
        backx := Param.GIF_XPos;
        backy := Param.GIF_YPos;
        FreeAndNil(bmp);
        bmp := merged;
        act := param.GIF_Action; // act refers to the action of next image
        Param.GIF_Action:=ioGIF_DrawBackground;
        Param.GIF_XPos:=0;
        Param.GIF_YPos:=0;
      end;

      Param.GIF_ImageIndex := idx;
      Param.TIFF_ImageIndex := idx;
      Param.DCX_ImageIndex := idx;
      Param.ICO_ImageIndex := idx;
      Param.FileType := ioGIF;
      Param.FileName := WideString(fLoadingFileName);
      if fAborting then
      begin
        (fImageEnMView as TImageEnMView).DeleteImage(idx);
        if bmp<>merged then
          FreeAndNil(bmp);
        break;
      end;
      if numi = 0 then
        (fImageEnMView as TImageEnMView).DeleteImage(idx)
      else
      begin
        Progress.per1 := 100 / numi;
        bmp.PixelFormat := originalPixelFormat;
        (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx, bmp);
        (fImageEnMView as TImageEnMView).ImageBackground[idx] := TRGB2TColor(Param.GIF_Background);
        if Param.GIF_DelayTime > 0 then
        begin
          (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := Param.GIF_DelayTime * 10;
          ld := Param.GIF_DelayTime * 10;
        end
        else
          (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := ld;
      end;
      if bmp <> merged then
        FreeAndNil(bmp)
      else
        bmp := nil;
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * im));
      if fAborting then
        break;
      inc(idx);
      inc(im);
    until im >= numi;
  finally
    FreeAndNil(merged);
    Update;
    (fImageEnMView as TImageEnMView).UnLockPaint;
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnMIO.SaveToFileGIF

<FM>Declaration<FC>
procedure SaveToFileGIF(const FileName: string);

<FM>Description<FN>
SaveToFileGif force to save a multi-image file as GIF.
FileName is the file name with extension.

!!}
procedure TImageEnMIO.SaveToFileGIF(const FileName: string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmCreate);
  try
  SaveToStreamGIF(fs);
  finally
    FreeAndNil(fs);
  end;
  _GIFMakeAnimate(FileName, 0, 0, 0);
end;

{!!
<FS>TImageEnMIO.SaveToStreamGIF

<FM>Declaration<FC>
procedure SaveToStreamGIF(Stream: TStream);

<FM>Description<FN>
SaveToStreamGif saves a GIF to a stream.

!!}
procedure TImageEnMIO.SaveToStreamGIF(Stream: TStream);
var
  p1:int64;
  q: integer;
  Param: TIOParamsVals;
  Progress: TProgressRec;
  bmp: TIEBitmap;
  nullpr: TProgressRec;
begin
  bmp := nil;
  try
    fAborting := False;
    if not assigned(fImageEnMView) then
      exit;
    if (fImageEnMView as TImageEnMView).ImageCount = 0 then
      exit;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    with nullpr do
    begin
      Aborting := Progress.Aborting;
      fOnProgress := nil;
      Sender := nil;
    end;
    p1 := Stream.Position;
    Progress.per1 := 100 / (fImageEnMView as TImageEnMView).ImageCount;
    bmp := TIEBitmap.Create;
    for q := 0 to (fImageEnMView as TImageEnMView).ImageCount - 1 do
    begin
      Param := Params[q];
      Param.GIF_ImageIndex:=q;
      Stream.position := p1;
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q, bmp);
      if bmp.HasAlphaChannel then
      begin
        bmp.AlphaChannel.SyncFull;
        if bmp.AlphaChannel.Full then
          bmp.RemoveAlphaChannel;
      end;
      bmp.DefaultDitherMethod := fDefaultDitherMethod;
      if q = 0 then
        WriteGIFStream(Stream, bmp, Param, NullPr)
      else
        _InsertGIFImStream(Stream, bmp, Param, NullPr);
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * q));
      if fAborting then
        break;
    end;
  finally
    FreeAndNil(bmp);
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnMIO.LoadFromFileTIFF

<FM>Declaration<FC>
procedure LoadFromFileTIFF(const FileName: string);

<FM>Description<FN>
Use LoadFromFileTIFF to cause loading a TIFF file.

If the file does not represent a valid image format, the <A TImageEnMIO.Aborting> property is True.
FileName is the file name with extension.

!!}
procedure TImageEnMIO.LoadFromFileTIFF(const FileName: string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    fLoadingFileName := FileName;
    LoadFromStreamTIFF(fs);
  finally
    fLoadingFileName := '';
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnMIO.LoadFromStreamTIFF

<FM>Declaration<FC>
procedure LoadFromStreamTIFF(Stream: TStream);

<FM>Description<FN>
Load a TIFF from a stream.

If the stream does not represent a valid image format, the <A TImageEnMIO.Aborting> property is True.
!!}
// default delay is 100ms
procedure TImageEnMIO.LoadFromStreamTIFF(Stream: TStream);
var
  p1:int64;
  xbmp, bmp: TIEBitmap;
  numi, idx: integer;
  Progress, Progress2: TProgressRec;
  Param: TIOParamsVals;
  im: integer;
  tempAlphaChannel: TIEMask;
begin
  fAborting := False;
  if not assigned(fImageEnMView) then
    exit;
  try
    (fImageEnMView as TImageEnMView).LockPaint;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    Progress2.fOnProgress := nil;
    Progress2.Sender := nil;
    Progress2.Aborting := @fAborting;
    p1 := Stream.Position;

    idx := (fImageEnMView as TImageEnMView).SelectedImage;
    if idx = -1 then
      idx := (fImageEnMView as TImageEnMView).ImageCount;

    im := 0;
    repeat
      (fImageEnMView as TImageEnMView).InsertImageEx(idx);
      bmp := TIEBitmap.Create;
      try
        Param := Params[idx];
        Stream.position := p1;
        Param.TIFF_ImageIndex := im;
        Param.IsNativePixelFormat := fNativePixelFormat;
        tempAlphaChannel := nil;
        TIFFReadStream(bmp, Stream, numi, Param, Progress2, false, tempAlphaChannel, true, false, false);
        CheckDPI(Param);
        if assigned(tempAlphaChannel) then
        begin
          bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
          FreeAndNil(tempAlphaChannel);
        end;
        if fAutoAdjustDPI then
        begin
          xbmp := IEAdjustDPI(bmp, Param, fFilteredAdjustDPI);
          if bmp <> xbmp then
          begin
            FreeAndNil(bmp);
            bmp := xbmp
          end;
        end;
        Param.TIFF_ImageIndex := idx;
        Param.GIF_ImageIndex := idx;
        Param.DCX_ImageIndex := idx;
        Param.ICO_ImageIndex := idx;
        Param.FileType := ioTIFF;
        Param.FileName := WideString(fLoadingFileName);
        if fAborting and not fAllowMalformedPages then
        begin
          (fImageEnMView as TImageEnMView).DeleteImage(idx);
          break;
        end;
        if fAborting then
          fAborting := false;
        if numi = 0 then
          (fImageEnMView as TImageEnMView).DeleteImage(idx)
        else
        begin
          Progress.per1 := 100 / numi;
          (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx, bmp);
          (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := 100;
        end;
      finally
        FreeAndNil(bmp);
      end;
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * im));
      if fAborting and not fAllowMalformedPages then
        break;
      inc(idx);
      inc(im);
    until im >= numi;
    Update;
  finally
    (fImageEnMView as TImageEnMView).UnLockPaint;
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnMIO.SaveToFileTIFF

<FM>Declaration<FC>
procedure SaveToFileTIFF(const FileName:string; SaveSelected:boolean=false);

<FM>Description<FN>
SaveToFileTIFF saves a multi-image file as TIFF format.

FileName is the file name with extension.
Save only selected pages if SaveSelected is true.
!!}
procedure TImageEnMIO.SaveToFileTIFF(const FileName:string; SaveSelected:boolean);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStreamTIFF(fs, SaveSelected);
  finally
    FreeAndNil(fs);
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.SaveToStreamTIFF

<FM>Declaration<FC>
procedure SaveToStreamTIFF(Stream:TStream; SaveSelected:boolean=false);

<FM>Description<FN>
SaveToStreamTIFF saves a TIFF to a stream.
Save only selected pages if SaveSelected is true.
!!}
procedure TImageEnMIO.SaveToStreamTIFF(Stream:TStream; SaveSelected:boolean);
var
  p1:int64;
  Param:TIOParamsVals;
  Progress:TProgressRec;
  bmp:TIEBitmap;
  nullpr:TProgressRec;
  imgCount:integer;

  procedure save(imgIdx, fileIdx:integer);
  begin
    Param := Params[imgIdx];
    Param.TIFF_ImageIndex := fileIdx;
    Stream.position := p1;
    (fImageEnMView as TImageEnMView).CopyToIEBitmap(imgIdx, bmp);
    bmp.DefaultDitherMethod := fDefaultDitherMethod;
    if fileIdx = 0 then
      TIFFWriteStream(Stream, false, bmp, Param, NullPr)
    else
      TIFFWriteStream(Stream, true, bmp, Param, NullPr);
    with Progress do
      if assigned(fOnProgress) then
        fOnProgress(Sender, trunc(per1 * fileIdx));
  end;

var
  i:integer;
begin
  bmp := nil;
  try
    fAborting := False;
    if not assigned(fImageEnMView) then
      exit;

    if SaveSelected then
      imgCount := (fImageEnMView as TImageEnMView).MultiSelectedImagesCount
    else
      imgCount := (fImageEnMView as TImageEnMView).ImageCount;

    if imgCount = 0 then
      exit;

    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    with nullpr do
    begin
      Aborting := Progress.Aborting;
      fOnProgress := nil;
      Sender := nil;
    end;

    bmp := TIEBitmap.Create;
    p1 := Stream.Position;
    Progress.per1 := 100 / imgCount;

    i := 0;
    while not fAborting and (i < imgCount) do
    begin
      if SaveSelected then
        save((fImageEnMView as TImageEnMView).MultiSelectedImages[i], i )
      else
        save(i, i);
      inc(i);
    end;

  finally
    FreeAndNil(bmp);
    DoFinishWork;
  end;
end;



{!!
<FS>TImageEnMIO.LoadFromFileAVI

<FM>Declaration<FC>
procedure LoadFromFileAVI(const FileName: string);

<FM>Description<FN>
Use LoadFromFileAVI to cause loading of an AVI file.

If the file does not represent a valid image format, the <A TImageEnMIO.Aborting> Property is True.
FileName is the file name with extension.
!!}
procedure TImageEnMIO.LoadFromFileAVI(const FileName: string);
var
  avf: PAVIFILE;
  avs: PAVISTREAM;
  gf: PGETFRAME;
  pt: pointer;
  ln, idx, im: integer;
  Progress: TProgressRec;
  bmp: TIEDibBitmap;
  Param: TIOParamsVals;
  psi: TAVISTREAMINFO;
  dt: integer;
  bitcount: integer;
  trymediafile:boolean;
begin
  trymediafile:=false;
  try
    (fImageEnMView as TImageEnMView).LockPaint;
    fAborting := False;
    if not assigned(fImageEnMView) then
      exit;
    if not gAVIFILEinit then
    begin
      AVIFileInit;
      gAVIFILEinit := true;
    end;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    //
    if AVIFileOpen(avf, pchar(FileName), OF_READ, nil) <> 0 then
    begin
      fAborting := True;
      exit;
    end;
    if AVIFileGetStream(avf, avs, streamtypeVIDEO, 0) <> 0 then
    begin
      AVIFileRelease(avf);
      fAborting := True;
      trymediafile:=true;
      exit;
    end;
    if AVIStreamInfo(avs, psi, sizeof(TAVISTREAMINFO)) <> 0 then
    begin
      AVIFileRelease(avf);
      AVIStreamRelease(avs);
      fAborting := True;
      trymediafile:=true;
      exit;
    end;
    gf := AVIStreamGetFrameOpen(avs, nil);
    if gf = nil then
    begin
      AVIFileRelease(avf);
      AVIStreamRelease(avs);
      fAborting := True;
      trymediafile:=true;
      exit;
    end;
    //
    ln := psi.dwLength;
    dt := trunc((1 / (psi.dwRate / psi.dwScale)) * 1000);
    Progress.per1 := 100 / ln;

    idx:=(fImageEnMView as TImageEnMView).SelectedImage;
    if idx=-1 then
      idx:=(fImageEnMView as TImageEnMView).ImageCount;

    bmp := TIEDibBitmap.Create;
    for im := 0 to ln - 1 do
    begin
      pt := AVIStreamGetFrame(gf, im);
      if pt <> nil then
      begin
        (fImageEnMView as TImageEnMView).InsertImageEx(idx);
        Param := Params[idx];
        bitcount := _IECopyDIB2Bitmap2Ex(integer(pt), bmp, nil, true); // uses drawdibdraw
        (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx, bmp);
        if im = 0 then
          (fImageEnMView as TImageEnMView).PrepareSpaceFor(bmp.Width, bmp.Height, BitCount, ln - 1);
        (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := dt;
        Param.GIF_DelayTime := dt;
        case BitCount of
          1:
            begin
              Param.BitsPerSample := 1;
              Param.SamplesPerPixel := 1;
            end;
          4:
            begin
              Param.BitsPerSample := 4;
              Param.SamplesPerPixel := 1;
            end;
          8:
            begin
              Param.BitsPerSample := 8;
              Param.SamplesPerPixel := 1;
            end;
          15:
            begin
              Param.BitsPerSample := 5;
              Param.SamplesPerPixel := 3;
            end;
          16, 24, 32:
            begin
              Param.BitsPerSample := 8;
              Param.SamplesPerPixel := 3;
            end;
        end;
        Param.GIF_ImageIndex := idx;
        Param.TIFF_ImageIndex := idx;
        Param.DCX_ImageIndex := idx;
        Param.ICO_ImageIndex := idx;
        Param.DpiX := gDefaultDPIX;
        Param.DpiY := gDefaultDPIY;
        Param.Width := bmp.Width;
        Param.Height := bmp.Height;
        Param.FileName := WideString(FileName);
        Param.FileType := ioAVI;
        Param.FreeColorMap;
        with Progress do
          if assigned(fOnProgress) then
            fOnProgress(Sender, trunc(per1 * im));
      end
      else
        fAborting := true;
      if fAborting then
        break;
      inc(idx);
    end;
    FreeAndNil(bmp);
    AVIStreamGetFrameClose(gf);
    AVIStreamRelease(avs);
    AVIFileRelease(avf);
    Update;
  finally
    (fImageEnMView as TImageEnMView).UnLockPaint;
    if trymediafile then
    begin
      {$ifdef IEINCLUDEDIRECTSHOW}
      LoadFromMediaFile(FileName);
      {$endif}
    end
    else
      DoFinishWork;
  end;
end;


{!!
<FS>TImageEnMIO.SaveToFileAVI

<FM>Declaration<FC>
procedure SaveToFileAVI(const FileName:string; const codec:AnsiString);

<FM>Description<FN>
SaveToFileAVI saves a multi-image file as AVI format.

Images in <A TImageEnMView> must be of the same size.
FileName is the file name with extension.

codec specifies the compression codec to use (must be installed on system) as four characters length string. Example:
'cvid' : cinepak by Radius
'msvc' : Microsoft Video 1
'mp42' : Microsoft MPEG4 V2
more codecs at <L http://www.fourcc.org>www.fourcc.org</L> or <L http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnwmt/html/registeredfourcccodesandwaveformats.asp>Microsoft</L> (or at msdn.microsoft.com searching for registered fourcc codes and wave formats).

If codec is not specified (or if it is an empty string), a dialog box appears to allow the user to select a compression.

!!}
procedure TImageEnMIO.SaveToFileAVI(const FileName: string; const codec: AnsiString);
var
  io: TImageEnIO;
  Progress: TProgressRec;
  q: integer;
begin
  if not assigned(fImageEnMView) then
    exit;
  if (fImageEnMView as TImageEnMView).ImageCount = 0 then
    exit;
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  Progress.per1 := 100 / (fImageEnMView as TImageEnMView).ImageCount;
  Progress.Aborting := @fAborting;
  io := TImageEnIO.Create(nil);
  try
    io.Params.Width := (fImageEnMView as TImageEnMView).ImageWidth[0];
    io.Params.Height := (fImageEnMView as TImageEnMView).ImageHeight[0];
    io.Params.BitsPerSample := Params[0].BitsPerSample;
    io.Params.SamplesPerPixel := Params[0].SamplesPerPixel;
    io.CreateAVIFile(FileName, trunc(1 / (imax((fImageEnMView as TImageEnMView).ImageDelayTime[0], 1) / 1000)), codec);
    if io.Aborting then
      exit;
    for q := 0 to (fImageEnMView as TImageEnMView).ImageCount - 1 do
    begin
      io.AttachedIEBitmap := (fImageEnMView as TImageEnMView).GetTIEBitmap(q);
      io.SaveToAVI;
      (fImageEnMView as TImageEnMView).ReleaseBitmap(q);
      with Progress do
       if assigned(fOnProgress) then
         fOnProgress(Sender,trunc(per1*q));
      if fAborting then
       break;
    end;
    io.CloseAVIFile;
  finally
    FreeAndNil(io);
  end;
end;


{!!
<FS>TImageEnMIO.LoadFromFile

<FM>Declaration<FC>
procedure LoadFromFile(const FileName: string);

<FM>Description<FN>
LoadFromFile loads a multi-image file. It detects the file format from the file name extension.
The source can be also an URL, if it has the form 'http://'.

If the file does not represent a valid image format, the <A TImageEnMIO.Aborting> Property is True.
FileName is the file name with extension.


<FM>Example<FC>

ImageEnMView1.MIO.LoadFromFile('film.avi');

ImageEnMView1.MIO.LoadFromFile('pages.tiff');

ImageEnMView1.MIO.LoadFromFile('anim.gif');
!!}
procedure TImageEnMIO.LoadFromFile(const FileName: string);
var
  ex: string;
  idx: integer;
begin
  if trim(FileName) = '' then
  begin
    fAborting := true;
    exit;
  end;

  if IEGetURLTypeW(FileName)<>ieurlUNKNOWN then
  begin
    LoadFromURL(WideString(FileName));
    exit;
  end;

  fAborting := False;
  ex := IEExtractFileExtS(FileName);
  if (ex = '.gif') then
    LoadFromFileGIF(FileName)
  else if (ex = '.tif') or (ex = '.tiff') or (ex = '.fax') or (ex = '.g3f') or (ex = '.g3n') or (ex = '.xif') then
    LoadFromFileTIFF(FileName)
  else if (ex = '.avi') then
    LoadFromFileAVI(FileName)
  else if (ex = '.ico') then
    LoadFromFileICO(FileName)
  else if (ex = '.dcx') then
    LoadFromFileDCX(FileName)
  {$ifdef IEINCLUDEDICOM}
  else if (ex = '.dicom') or (ex = '.dcm') or (ex = '.dic') or (ex = '.v2') then
    LoadFromFileDICOM(FileName)
  {$endif}
  else if assigned(fImageEnMView) and IsKnownFormat(WideString(FileName)) then
  begin
    // try single image
    idx:=(fImageEnMView as TImageEnMView).SelectedImage;
    if idx=-1 then
      idx:=(fImageEnMView as TImageEnMView).ImageCount;

    (fImageEnMView as TImageEnMView).InsertImageEx(idx);
    (fImageEnMView as TImageEnMView).SetImageFromFile(idx, WideString(FileName));
  end
  {$ifdef IEINCLUDEDIRECTSHOW}
  else
    LoadFromMediaFile(FileName);
  {$endif}
end;

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.SaveToFile

<FM>Declaration<FC>
procedure SaveToFile(const FileName: string);

<FM>Description<FN>
SaveToFile save a multi-image file as a GIF, TIFF, DCX, ICO, AVI. It detects the file's format from the extension.

FileName is the file name with extension.

!!}
procedure TImageEnMIO.SaveToFile(const FileName: string);
var
  ex: string;
begin
  if Trim(FileName) = '' then
  begin
    fAborting := true;
    exit;
  end;
  fAborting := False;
  ex := IEExtractFileExtS(FileName);
  if (ex = '.gif') then
    SaveToFileGIF(FileName)
  else if (ex = '.tif') or (ex = '.tiff') or (ex = '.fax') or (ex = '.g3f') or (ex = '.g3n') then
    SaveToFileTIFF(FileName)
  else if (ex = '.avi') then
    SaveToFileAVI(FileName, '')
  else if (ex = '.ps') or (ex = '.eps') then
    SaveToFilePS(FileName)
  {$ifdef IEINCLUDEPDFWRITING}
  else if (ex = '.pdf') then
    SaveToFilePDF(FileName)
  {$endif}
  else if (ex = '.dcx') then
    SaveToFileDCX(FileName)
  else if (ex = '.ico') then
    SaveToFileICO(FileName);
end;

/////////////////////////////////////////////////////////////////////////////////////
{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnMIO.SelectAcquireSource

<FM>Declaration<FC>
function SelectAcquireSource(api:<A TIEAcquireApi>):boolean;

<FM>Description<FN>
Shows a dialog where the user can select a TWain or WIA device.

Returns False if user press "Cancel" button.
!!}
function TImageEnMIO.SelectAcquireSource(api: TIEAcquireApi): boolean;
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

procedure TImageEnMIO.TWMultiCallBack(Bitmap: TIEBitmap; var IOParams: TObject);
var
  bHandled: boolean; // Flag indicating whether the user has handled the acquired bitmap themselves
  bmp: TIEBitmap;
begin
  bHandled := false;
  if assigned(fOnAcquireBitmap) then
    fOnAcquireBitmap(Self, Bitmap, bHandled);
  if (bHandled = false) and assigned(fImageEnMView) then
  begin
    fTWainNextToInsert := imax(imin(fTWainNextToInsert, (fImageEnMView as TImageEnMView).ImageCount), 0);
    (fImageEnMView as TImageEnMView).InsertImageEx(fTWainNextToInsert);
    IOParams := Params[fTWainNextToInsert];
    if fAutoAdjustDPI then
      bmp := IEAdjustDPI(Bitmap, IOParams as TIOParamsVals, fFilteredAdjustDPI)
    else
      bmp := Bitmap;
    (fImageEnMView as TImageEnMView).SetIEBitmapEx(fTWainNextToInsert, bmp);
    if bmp <> Bitmap then
      FreeAndNil(bmp);
    (fImageEnMView as TImageEnMView).ImageDelayTime[fTWainNextToInsert] := 100;
    if assigned(fOnAfterAcquireBitmap) then
      fOnAfterAcquireBitmap(Self, fTWainNextToInsert);
    inc(fTWainNextToInsert);
  end;
end;

/////////////////////////////////////////////////////////////////////////////////////
{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnMIO.Acquire

<FM>Declaration<FC>
function Acquire(api:<A TIEAcquireApi>): boolean;

<FM>Description<FN>
Perform multi-page image acquisition from TWain or WIA devices. Returns True if the acquisition has succeeded, False otherwise.
!!}
function TImageEnMIO.Acquire(api: TIEAcquireApi): boolean;
var
  Progress: TProgressRec;
  {$IFDEF IEINCLUDEWIA}
  tmpbitmap: TIEBitmap;
  {$ENDIF}
begin
  // calling Acquire after AcquireOpen!!!!
  if assigned(fgrec) then
  begin
    result := true; // there is already a scanner dialog open
    exit;
  end;
  try
    fAborting := False;
    result := false;
    if assigned(fImageEnMView) then
    begin
      if (fImageEnMView as TImageEnMView).SelectedImage >= 0 then
        fTWainNextToInsert := (fImageEnMView as TImageEnMView).SelectedImage
      else
        fTWainNextToInsert := (fImageEnMView as TImageEnMView).ImageCount;
    end
    else
      fTWainNextToInsert := 0;
    Progress.Aborting := @fAborting;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    case api of
      ieaTWain:
        begin
          result := IETW_Acquire(nil, true, TWMultiCallBack, fTWainParams, nil, Progress, @fTWainParams.TWainShared, IEFindHandle(self),fNativePixelFormat);
          SetFocus(IEFindHandle(self));
        end;
      ieaWIA:
        begin
{$IFDEF IEINCLUDEWIA}
          tmpbitmap := TIEBitmap.Create;
          WIAParams.ProcessingBitmap := tmpbitmap;
          WIAParams.OnGetPage := TWMultiCallBack;
          WIAParams.SetDeviceProperty(WIA_DPS_DOCUMENT_HANDLING_SELECT, 1); // select feeder
          WIAParams.SetDeviceProperty(WIA_DPS_PAGES, 0); // unlimited number of pages
          result:=WIAParams.Transfer(nil, true); // transfer in multi page mode
          FreeAndNil(tmpbitmap);
{$ENDIF}
        end;
    end;
    Update;
  except
    result := false;
  end;
end;
{$ENDIF}

/////////////////////////////////////////////////////////////////////////////////////
// show the input/output parameters preview dialog
// return True if the user press OK
// if idx=-1 applies the some compression parameters to all images
{$IFDEF IEINCLUDEDIALOGIO}

{!!
<FS>TImageEnMIO.DoPreviews

<FM>Declaration<FC>
function DoPreviews(idx:integer; pp: <A TPreviewParams>): boolean;

<FM>Description<FN>
DoPreviews executes the Previews dialog for the image idx. This dialog gets/sets the parameters of image file formats.

pp is the set of the image format parameters to be displayed by the dialog.
If idx is -1, the dialogs act on all images.

<FM>Example<FC>
ImageEnMView1.MIO.LoadFromFile('myimage.gif');  // loads a GIF image
ImageEnMView1.MIO.DoPreviews(-1,[ppGIF]); // sets GIF parameters (background, transparency...) for ALL images
ImageEnMView1.MIO.SaveToFile('newimae.gif'); // saves some image with new parameters

!!}
function TImageEnMIO.DoPreviews(idx: integer; pp: TPreviewParams): boolean;
var
  fIOPreviews: TfIOPreviews;
  fBitmap: TBitmap;
  //q: integer;
  Handled:boolean;
begin
  Handled := false;
  if assigned(fOnDoPreviews) then
    fOnDoPreviews(self, Handled);
  if not Handled then
  begin
    result := false;
    if not assigned(fImageEnMView) then
      exit;
    if ((fImageEnMView as TImageEnMView).ImageCount > 0) and ((fImageEnMView as TImageEnMView).SelectedImage < 0) then
      (fImageEnMView as TImageEnMView).SelectedImage := 0;
    fBitmap := fImageEnMView.Bitmap;
    if not assigned(fBitmap) then
      exit;
    fIOPreviews := TfIOPreviews.Create(self);
    fIOPreviews.DefaultLockPreview := ioppDefaultLockPreview in PreviewsParams;
    fIOPreviews.Button4.Visible := ioppApplyButton in PreviewsParams;
    fIOPreviews.fSimplified := fSimplifiedParamsDialogs;
    if fSimplifiedParamsDialogs then
    begin
      fIOPreviews.PageControl1.Height := trunc(122 / 96 * Screen.PixelsPerInch);
      fIOPreviews.Height := trunc(330 / 96 * Screen.PixelsPerInch);
    end;
    fIOPreviews.fDefaultDitherMethod := fDefaultDitherMethod;
    if idx < 0 then
      fIOPreviews.fParams := Params[0]
    else
      fIOPreviews.fParams := Params[idx];
    //
    fIOPreviews.SetLanguage(fMsgLanguage);
    fIOPreviews.Font.assign(fPreviewFont);
    //
    with fIOPreviews.ImageEn1 do
    begin
      IECopyBitmap(fBitmap, Bitmap);
      Update;
    end;
    if fIOPreviews.SetPreviewParams(pp) then
      result := fIOPreviews.ShowModal = mrOk
    else
      result := false;
    fIOPreviews.Release;
    // duplicate compression parameters
    if idx < 0 then
      DuplicateCompressionInfo;
    // reorder image indexes
    (*
    for q := 0 to ParamsCount - 1 do
    begin
      Params[q].TIFF_ImageIndex := q;
      Params[q].GIF_ImageIndex := q;
      Params[q].DCX_ImageIndex := q;
      Params[q].ICO_ImageIndex := idx;
    end;
    *)
    Update;
  end
  else
    result:=true; // handled
end;
{$ENDIF}

{!!
<FS>TImageEnMIO.DuplicateCompressionInfo

<FM>Declaration<FC>
procedure DuplicateCompressionInfo;

<FM>Description<FN>
DuplicateCompressionInfo clones the compression information of page 0 to all pages.

!!}
procedure TImageEnMIO.DuplicateCompressionInfo;
var
  i: integer;
  tmp:TIOParamsVals;
begin
  tmp:=TIOParamsVals.Create(nil);
  tmp.AssignCompressionInfo(Params[0]);
  for i := 1 to ParamsCount - 1 do
    Params[i].AssignCompressionInfo(tmp);
  FreeAndNil(tmp);
end;

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.PreviewFont

<FM>Declaration<FC>
property PreviewFont: TFont;

<FM>Description<FN>
The PreviewFont property contains the font used in the Previews dialog. Make sure the size of the font match label's length.
!!}
procedure TImageEnMIO.SetPreviewFont(f: TFont);
begin
  fPreviewFont.assign(f);
end;

/////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.PreviewsParams

<FM>Declaration<FC>
property PreviewsParams:<A TIOPreviewsParams>;

<FM>Description<FN>
This property specifies the features that the input/output preview dialog will have.
!!}
procedure TImageEnMIO.SetIOPreviewParams(v: TIOPreviewsParams);
begin
  fPreviewsParams := v;
end;

/////////////////////////////////////////////////////////////////////////////////////

function TImageEnMIO.GetIOPreviewParams: TIOPreviewsParams;
begin
  result := fPreviewsParams;
end;

procedure TImageEnMIO.TWCloseCallBack;
begin
  fgrec := nil;
end;

{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnMIO.AcquireOpen

<FM>Declaration<FC>
function AcquireOpen:boolean;

<FM>Description<FN>
AcquireOpen opens a connection to the selected scanner. It is useful to do a modeless acquisition.

AcquireOpen returns False if fail.
Whenever ImageEn gets an image the <A TImageEnMIO.OnAcquireBitmap> and <A TImageEnMIO.OnAfterAcquireBitmap> events occur.

<FM>Example<FC>
ImageEnMIO.AcquireOpen;
..
ImageEnMIO.AcquireClose;
!!}
function TImageEnMIO.AcquireOpen: boolean;
var
  tempio: TIOParamsVals;
begin
  if (not assigned(fgrec)) and assigned(fImageEnMView) then
  begin
    if assigned(fImageEnMView) then
    begin
      if (fImageEnMView as TImageEnMView).SelectedImage >= 0 then
        fTWainNextToInsert := (fImageEnMView as TImageEnMView).SelectedImage
      else
        fTWainNextToInsert := (fImageEnMView as TImageEnMView).ImageCount;
    end
    else
      fTWainNextToInsert := 0;
    fAborting := false;
    fTWainParams.FreeResources;
    tempio := TIOParamsVals.Create(nil);
    fgrec := IETWAINAcquireOpen(TWCloseCallBack, TWMultiCallBack, fTWainParams, @fTWainParams.TWainShared, tempio, fImageEnMView, fNativePixelFormat);
    FreeAndNil(tempio);
    result := fgrec <> nil;
  end
  else
    result := false;
end;
{$ENDIF}

{$IFDEF IEINCLUDETWAIN}

{!!
<FS>TImageEnMIO.AcquireClose

<FM>Declaration<FC>
procedure AcquireClose;

<FM>Description<FN>
AcquireClose closes a connection opened with <A TImageEnMIO.AcquireOpen>. It is useful to do a modeless acquisition.
Whenever ImageEn gets an image, the <A TImageEnMIO.OnAcquireBitmap> and and <A TImageEnMIO.OnAfterAcquireBitmap> event occur.

<FM>Example<FC>
ImageEnMIO.AcquireOpen;
..
ImageEnMIO.AcquireClose;
!!}
procedure TImageEnMIO.AcquireClose;
begin
  if fgrec <> nil then
  begin
    IETWAINAcquireClose(fgrec);
    fgrec := nil;
  end;
end;
{$ENDIF}

procedure TImageEnMIO.DoFinishWork;
begin
  if assigned(fOnProgress) then
    fOnProgress(self, 100);
  if assigned(fOnFinishWork) then
    fOnFinishWork(self);
end;

{$IFDEF IEINCLUDEOPENSAVEDIALOGS}

{!!
<FS>TImageEnMIO.ExecuteOpenDialog

<FM>Declaration<FC>
function ExecuteOpenDialog(InitialDir: string; InitialFileName: string; AlwaysAnimate: boolean; FilterIndex: integer; ExtendedFilters: string; MultiSelect:boolean; Title:WideString; Filter:WideString=''):string;

<FM>Description<FN>
The ExecuteOpenDialog shows and executes the open dialog. It encapsulates the <A TOpenImageEnDialog> component.
InitialDir is the starting directory.
InitialFileName is the default file name with extension.
AlwaysAnimate if true auto-animate GIF and AVI
FilterIndex specifies what file format to select for default. Allowed values:
1 : Common graphics formats
2 : All files
3 : TIFF Bitmap (TIF;TIFF;FAX)
4 : GIF (GIF) - if enabled
5 : JPEG Bitmap (JPG;JPEG;JPE)
6 : PaintBrush (PCX)
7 : Windows Bitmap (BMP;DIB;RLE)
8 : Windows Icon (ICO)
9 : Windows Cursor (CUR)
10 : Portable Network Graphics (PNG)
11 : Windows Metafile (WMF)
12 : Enhanced Windows Metafile (EMF)
13 : Targa Bitmap (TGA;TARGA;VDA;ICB;VST;PIX)
14 : Portable Pixmap, GreyMap, BitMap (PXM;PPM;PGM;PBM)
15 : Wireless bitmap (WBMP)
16 : Jpeg2000 (JP2)
17 : Jpeg2000 Code Stream (J2K;JPC;J2C)
18 : Multipage PCX (DCX)
19 : Camera RAW (RAW;CR2;CRW...)
20 : Video for Windows (AVI)
21 : Video Mpeg (MPEG)
22 : Windows Media Video (WMV)

ExtendedFilters specifies additional file formats (example: 'Fun Bitmap|*.fun;*.fan' )
If MultiSelect is True then it is possible to select multiple files. The returned string contains a list of filename separated by '|' character ('one.jpg|two.jpg').

<FC>Title<FN> specifies the dialog title. Empty string means operating system default value.

<FC>Filter<FN> specifies file extensions to enable (i.e. 'JPEG Bitmap (JPG)|*.jpg|CompuServe Bitmap (GIF)|*.gif').

Returns null string ('') if the user clicks on Cancel.
!!}
function TImageEnMIO.ExecuteOpenDialog(InitialDir: string; InitialFileName: string; AlwaysAnimate: boolean; FilterIndex: integer; ExtendedFilters: string; MultiSelect:boolean; Title:WideString; Filter:WideString): string;
var
  fOpenImageEnDialog: TOpenImageEnDialog;
  i:integer;
begin
  fOpenImageEnDialog := TOpenImageEnDialog.create(self);
  fOpenImageEnDialog.InitialDir := InitialDir;
  fOpenImageEnDialog.FileName := InitialFileName;
  fOpenImageEnDialog.AlwaysAnimate := AlwaysAnimate;
  fOpenImageEnDialog.PreviewBorderStyle := iepsSoftShadow;
  if Filter<>'' then
  begin
    fOpenImageEnDialog.AutoSetFilter := false;
    fOpenImageEnDialog.Filter := Filter;
  end;
  fOpenImageEnDialog.FilterIndex := FilterIndex;
  fOpenImageEnDialog.AutoAdjustDPI := AutoAdjustDPI;
  fOpenImageEnDialog.FilteredAdjustDPI := FilteredAdjustDPI;
  fOpenImageEnDialog.ExtendedFilters := ExtendedFilters;
  fOpenImageEnDialog.MsgLanguage := fMsgLanguage;
  if MultiSelect then
    fOpenImageEnDialog.Options:=fOpenImageEnDialog.Options+[ofAllowMultiSelect];
  if Title<>'' then
    fOpenImageEnDialog.Title:=Title;
  result:='';
  if fOpenImageEnDialog.Execute then
  begin
    if MultiSelect then
      for i:=0 to fOpenImageEnDialog.Files.Count-1 do
      begin
        result:=result+fOpenImageEnDialog.Files[i];
        if i<fOpenImageEnDialog.Files.Count-1 then
          result:=result+'|';
      end
    else
      result := fOpenImageEnDialog.FileName;
  end;
  FreeAndNil(fOpenImageEnDialog);
end;

{$ENDIF}

{$IFDEF IEINCLUDEOPENSAVEDIALOGS}

{!!
<FS>TImageEnMIO.ExecuteSaveDialog

<FM>Declaration<FC>
function ExecuteSaveDialog(InitialDir:string; InitialFileName:string; AlwaysAnimate:boolean; FilterIndex:integer; ExtendedFilters:string; Title:WideString; Filter:WideString):string;

<FM>Description<FN>
The ExecuteSaveDialog shows and executes the save dialog. It encapsulates the <A TSaveImageEnDialog> component.
InitialDir is the starting directory.
InitialFileName is the default file name with extension.
AlwaysAnimate if true auto-animate GIF and AVI
FilterIndex specifies what file format to select by default. The InitialFileName extension, if specified, in the second parameter, will over-ride the specified index. Valid values are:
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
16 : Video for Windows (AVI)

ExtendedFilters specifies additional file formats (example: 'Fun Bitmap|*.fun;*.fan' )

Title specifies the dialog title. Empty string means operating system default value.

<FC>Filter<FN> specifies file extensions to enable (i.e. 'JPEG Bitmap (JPG)|*.jpg|CompuServe Bitmap (GIF)|*.gif').

Returns a null string ('') if the user clicks on Cancel.
!!}
function TImageEnMIO.ExecuteSaveDialog(InitialDir: string; InitialFileName: string; AlwaysAnimate: boolean; FilterIndex: integer; ExtendedFilters: string; Title:WideString; Filter:WideString): string;
var
  fSaveImageEnDialog: TSaveImageEnDialog;
begin
  fSaveImageEnDialog := TSaveImageEnDialog.create(self);
  fSaveImageEnDialog.InitialDir := InitialDir;
  fSaveImageEnDialog.FileName := TFileName(InitialFileName);
  fSaveImageEnDialog.AlwaysAnimate := AlwaysAnimate;
  fsaveImageEnDialog.AttachedImageEnIO := self;
  fSaveImageEnDialog.PreviewBorderStyle := iepsSoftShadow;
  if Filter<>'' then
  begin
    fSaveImageEnDialog.AutoSetFilter := false;
    fSaveImageEnDialog.Filter := Filter;
  end;
  fSaveImageEnDialog.FilterIndex := FilterIndex;
  fSaveImageEnDialog.AutoAdjustDPI := AutoAdjustDPI;
  fSaveImageEnDialog.FilteredAdjustDPI := FilteredAdjustDPI;
  fSaveImageEnDialog.ExtendedFilters := ExtendedFilters;
  fSaveImageEnDialog.MsgLanguage := fMsgLanguage;
  if Title<>'' then
    fSaveImageEnDialog.Title := Title;
  if fSaveImageEnDialog.Execute then
    result := fSaveImageEnDialog.FileName
  else
    result := '';
  FreeAndNil(fSaveImageEnDialog);
end;

{$ENDIF}


{$IFDEF IEINCLUDEWIA}

{!!
<FS>TImageEnMIO.WIAParams

<FM>Declaration<FC>
property WIAParams: <A TIEWia>;

<FM>Description<FN>

WIAParams allows you to set/get parameters, show dialogs and control WIA devices.
Look at <A TIEWia> for more info.
!!}
function TImageEnMIO.GetWIAParams: TIEWia;
begin
  if not assigned(fWIA) then
  begin
    fWIA := TIEWia.Create(self);
    fWIA.OnProgress := WiaOnProgress;
  end;
  result := fWIA;
end;

function TImageEnMIO.WiaOnProgress(Percentage: integer): boolean;
begin
  if assigned(fOnProgress) then
    fOnProgress(self, Percentage);
  result := not fAborting;
end;

{$ENDIF}  // end of IEINCLUDEWIA


{!!
<FS>TImageEnMIO.SaveToStreamPS

<FM>Declaration<FC>
procedure SaveToStreamPS(Stream:TStream);

<FM>Description<FN>
SaveToStreamPS creates a multi-page PostScript file with all images loaded in the attached TImageEnMView component.

!!}
procedure TImageEnMIO.SaveToStreamPS(Stream: TStream);
var
  q: integer;
  Param: TIOParamsVals;
  Progress: TProgressRec;
  bmp: TIEBitmap;
  nullpr: TProgressRec;
  han: pointer;
begin
  try
    fAborting := False;
    if not assigned(fImageEnMView) then
      exit;
    if (fImageEnMView as TImageEnMView).ImageCount = 0 then
      exit;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    with nullpr do
    begin
      Aborting := Progress.Aborting;
      fOnProgress := nil;
      Sender := nil;
    end;
    Progress.per1 := 100 / (fImageEnMView as TImageEnMView).ImageCount;
    bmp := TIEBitmap.Create;
    han := nil;
    for q := 0 to (fImageEnMView as TImageEnMView).ImageCount - 1 do
    begin
      Param := Params[q];
      if q = 0 then
        han := IEPostScriptCreate(Stream, Param);
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q, bmp);
      bmp.DefaultDitherMethod := fDefaultDitherMethod;
      IEPostScriptSave(han, Stream, bmp, Param, nullpr);
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * q));
      if fAborting then
        break;
    end;
    IEPostScriptClose(han, Stream);
    FreeAndNil(bmp);
  finally
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnMIO.SaveToFilePS

<FM>Declaration<FC>
procedure SaveToFilePS(const FileName:string);

<FM>Description<FN>
SaveToFilePS creates a multi-page PostScript file with all images loaded in the attached TImageEnMView component.

<FM>Example<FC>
// load a multipage TIFF and save back to a multipage PostScript file
ImageEnMView.MIO.LoadFromFile('multipage.tiff');
ImageEnMView.MIO.SaveToFilePS('output.ps');

!!}
procedure TImageEnMIO.SaveToFilePS(const FileName: string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmCreate);
  try
  SaveToStreamPS(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnMIO.SaveToStreamPDF

<FM>Declaration<FC>
procedure SaveToStreamPDF(Stream:TStream);

<FM>Description<FN>
SaveToStreamPDF creates a multipage Adobe PDF file with all images loaded within the attached TImageEnMView component.

!!}
{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnMIO.SaveToStreamPDF(Stream: TStream);
var
  q: integer;
  Param: TIOParamsVals;
  Progress: TProgressRec;
  bmp: TIEBitmap;
  nullpr: TProgressRec;
  han: pointer;
begin
  try
    fAborting := False;
    if not assigned(fImageEnMView) then
      exit;
    if (fImageEnMView as TImageEnMView).ImageCount = 0 then
      exit;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    with nullpr do
    begin
      Aborting := Progress.Aborting;
      fOnProgress := nil;
      Sender := nil;
    end;
    Progress.per1 := 100 / (fImageEnMView as TImageEnMView).ImageCount;
    bmp := TIEBitmap.Create;
    han := nil;
    for q := 0 to (fImageEnMView as TImageEnMView).ImageCount - 1 do
    begin
      Param := Params[q];
      if q = 0 then
        han := IEPDFCreate(Param);
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q, bmp);
      bmp.DefaultDitherMethod := fDefaultDitherMethod;
      IEPDFSave(han, bmp, Param, nullpr);
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * q));
      if fAborting then
        break;
    end;
    if (fImageEnMView as TImageEnMView).ImageCount > 0 then
      Param := Params[0];
    IEPDFClose(han, Stream, Param);
    FreeAndNil(bmp);
  finally
    DoFinishWork;
  end;
end;
{$endif}

{!!
<FS>TImageEnMIO.SaveToFilePDF

<FM>Declaration<FC>
procedure SaveToFilePDF(const FileName:string);

<FM>Description<FN>
SaveToFilePDF creates a multipage Adobe PDF file with all images loaded within the attached TImageEnMView component.

<FM>Example<FC>
// load a multipage TIFF and save back to a multipage PDF file
ImageEnMView.MIO.LoadFromFile('multipage.tiff');
ImageEnMView.MIO.SaveToFilePDF('output.pdf');

!!}
{$ifdef IEINCLUDEPDFWRITING}
procedure TImageEnMIO.SaveToFilePDF(const FileName: string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmCreate);
  try
  SaveToStreamPDF(fs);
  finally
    FreeAndNil(fs);
  end;
end;
{$endif}



{$IFDEF IEINCLUDEPRINTDIALOGS}

{!!
<FS>TImageEnMIO.DoPrintPreviewDialog

<FM>Declaration<FC>
function DoPrintPreviewDialog(const TaskName:string; PrintAnnotations:boolean; const Caption:string):boolean;

<FM>Description<FN>
Executes the multi-page print preview dialog. This function is like DoPrintPreviewDialog of <A TImageEnIO>, but allows working with multiple pages.
If <FC>PrintAnnotation<FN> is true and the image contains Imaging Annotations they will be printed out.
<FC>Caption<FN> specifies the caption of preview dialog.

See also <A TImageEnMIO.PrintPreviewParams>.

<FM>Example<FC>
ImageEnMView1.MIO.DoPrintPreviewDialog('');
<IMG help_images\74.bmp>
!!}
function TImageEnMIO.DoPrintPreviewDialog(const TaskName: string; PrintAnnotations:boolean; const Caption:string): boolean;
var
  fieprnform: tfieprnform3;
begin
  if fResetPrinter then
    IEResetPrinter;
  fieprnform := tfieprnform3.Create(self);
  try
    fieprnform.mio := self;
    fieprnform.SetLanguage(fMsgLanguage);
    fieprnform.Font.assign(fPreviewFont);
    fieprnform.fTaskName := TaskName;
    fieprnform.fDialogsMeasureUnit := fDialogsMeasureUnit;
    fieprnform.fPrintPreviewParams:=fPrintPreviewParams;
    fieprnform.PrintAnnotations:=PrintAnnotations;
    fieprnform.Caption:=Caption;
    result := fieprnform.ShowModal = mrOk;
  finally
    fieprnform.Release;
  end;
end;
{$ENDIF}


{!!
<FS>TImageEnMIO.LoadFromFileICO

<FM>Declaration<FC>
procedure LoadFromFileICO(const FileName:string);

<FM>Description<FN>
Load all images contained in a multi-image ICO file.
!!}
procedure TImageEnMIO.LoadFromFileICO(const FileName: string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    fLoadingFileName:=FileName;
    LoadFromStreamICO(fs);
  finally
    fLoadingFileName:='';
    FreeAndNil(fs);
  end;
end;


{!!
<FS>TImageEnMIO.LoadFromStreamICO

<FM>Declaration<FC>
procedure LoadFromStreamICO(Stream:TStream);

<FM>Description<FN>
Load all images contained in a multi-image ICO stream.
!!}
procedure TImageEnMIO.LoadFromStreamICO(Stream: TStream);
var
  p1:int64;
  bmp: TIEBitmap;
  numi, idx: integer;
  Progress, Progress2: TProgressRec;
  Param: TIOParamsVals;
  im: integer;
  tempAlphaChannel: TIEMask;
begin
  fAborting := False;
  if not assigned(fImageEnMView) then
    exit;
  try
    (fImageEnMView as TImageEnMView).LockPaint;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    Progress2.fOnProgress := nil;
    Progress2.Sender := nil;
    Progress2.Aborting := @fAborting;
    p1 := Stream.Position;

    idx:=(fImageEnMView as TImageEnMView).SelectedImage;
    if idx=-1 then
      idx:=(fImageEnMView as TImageEnMView).ImageCount;

    im := 0;
    numi := _EnumICOImStream(Stream);
    repeat
      (fImageEnMView as TImageEnMView).InsertImageEx(idx);
      bmp := TIEBitmap.Create;
      try
        Param := Params[idx];
        Stream.position := p1;
        Param.ICO_ImageIndex := im;
        Param.IsNativePixelFormat := fNativePixelFormat;
        tempAlphaChannel := nil;
        ICOReadStream(Stream, bmp, Param, false, Progress2, tempAlphaChannel, false);
        if assigned(tempAlphaChannel) then
        begin
          bmp.AlphaChannel.CopyFromTIEMask(tempAlphaChannel);
          FreeAndNil(tempAlphaChannel);
        end;
        Param.TIFF_ImageIndex := idx;
        Param.GIF_ImageIndex  := idx;
        Param.ICO_ImageIndex  := idx;
        Param.DCX_ImageIndex  := idx;
        Param.FileType := ioICO;
        Param.FileName := WideString(fLoadingFileName);
        if fAborting then
        begin
          (fImageEnMView as TImageEnMView).DeleteImage(idx);
          break;
        end;
        if numi = 0 then
          (fImageEnMView as TImageEnMView).DeleteImage(idx)
        else
        begin
          Progress.per1 := 100 / numi;
          (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx, bmp);
          (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := 100;
        end;
      finally
        FreeAndNil(bmp);
      end;
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * im));
      if fAborting then
        break;
      inc(idx);
      inc(im);
    until im >= numi;
    Update;
  finally
    (fImageEnMView as TImageEnMView).UnLockPaint;
    DoFinishWork;
  end;
end;


procedure TImageEnMIO.CheckDPI(p: TIOParamsVals);
begin
  if p.DpiX < 2 then
    p.DpiX := gDefaultDPIX;
  if p.DpiY < 2 then
    p.DpiY := gDefaultDPIY;
end;

{!!
<FS>TImageEnMIO.LoadFromFileDCX

<FM>Declaration<FC>
procedure LoadFromFileDCX(const FileName:string);

<FM>Description<FN>
Loads all images contained in a multi-image DCX file.

!!}
procedure TImageEnMIO.LoadFromFileDCX(const FileName:string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
  fLoadingFileName:=FileName;
  LoadFromStreamDCX(fs);
  finally
    fLoadingFileName:='';
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnMIO.LoadFromStreamDCX

<FM>Declaration<FC>
procedure LoadFromStreamDCX(Stream:TStream);

<FM>Description<FN>
Loads all images contained in a multi-image DCX stream.

!!}
procedure TImageEnMIO.LoadFromStreamDCX(Stream:TStream);
var
  p1:int64;
  xbmp, bmp: TIEBitmap;
  numi, idx: integer;
  Progress, Progress2: TProgressRec;
  Param: TIOParamsVals;
  im: integer;
begin
  fAborting := False;
  if not assigned(fImageEnMView) then
    exit;
  try
    (fImageEnMView as TImageEnMView).LockPaint;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    Progress2.fOnProgress := nil;
    Progress2.Sender := nil;
    Progress2.Aborting := @fAborting;
    p1 := Stream.Position;

    //idx := imax((fImageEnMView as TImageEnMView).SelectedImage, 0);
    idx:=(fImageEnMView as TImageEnMView).SelectedImage;
    if idx=-1 then
      idx:=(fImageEnMView as TImageEnMView).ImageCount;

    numi := IEDCXCountStream(Stream);
    for im:=0 to numi-1 do
    begin
      (fImageEnMView as TImageEnMView).InsertImageEx(idx);
      bmp := TIEBitmap.Create;
      Param := Params[idx];
      Stream.position := p1;
      Param.DCX_ImageIndex := im;
      Param.IsNativePixelFormat := fNativePixelFormat;
      IEDCXReadStream(Stream,bmp,Param,Progress2,false);
      CheckDPI(Param);
      if fAutoAdjustDPI then
        xbmp := IEAdjustDPI(bmp, Param, fFilteredAdjustDPI)
      else
        xbmp := bmp;
      if bmp <> xbmp then
        FreeAndNil(bmp);
      bmp := xbmp;
      Param.TIFF_ImageIndex := idx;
      Param.GIF_ImageIndex := idx;
      Param.DCX_ImageIndex := idx;
      Param.ICO_ImageIndex := idx;
      Param.FileType := ioDCX;
      Param.FileName := WideString(fLoadingFileName);
      if fAborting then
      begin
        (fImageEnMView as TImageEnMView).DeleteImage(idx);
        FreeAndNil(bmp);
        break;
      end;
      Progress.per1 := 100 / numi;
      (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx, bmp);
      (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := 100;
      //if xbmp=bmp then xbmp:=nil;
      FreeAndNil(bmp);
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * im));
      if fAborting then
        break;
      inc(idx);
    end;
    Update;
  finally
    (fImageEnMView as TImageEnMView).UnLockPaint;
    DoFinishWork;
  end;
end;

{!!
<FS>TImageEnMIO.SaveToFileDCX

<FM>Declaration<FC>
procedure SaveToFileDCX(const FileName:string);

<FM>Description<FN>
Saves all images in DCX format to the specified file.
!!}
procedure TImageEnMIO.SaveToFileDCX(const FileName:string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmCreate);
  try
  SaveToStreamDCX(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnMIO.SaveToStreamDCX

<FM>Declaration<FC>
procedure SaveToStreamDCX(Stream:TStream);

<FM>Description<FN>
Saves all images in DCX format to the specified stream.
!!}
procedure TImageEnMIO.SaveToStreamDCX(Stream:TStream);
var
  p1:int64;
  q: integer;
  Param: TIOParamsVals;
  Progress: TProgressRec;
  bmp: TIEBitmap;
  nullpr: TProgressRec;
begin
  try
    fAborting := False;
    if not assigned(fImageEnMView) then
      exit;
    if (fImageEnMView as TImageEnMView).ImageCount = 0 then
      exit;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    with nullpr do
    begin
      Aborting := Progress.Aborting;
      fOnProgress := nil;
      Sender := nil;
    end;
    p1 := Stream.Position;
    Progress.per1 := 100 / (fImageEnMView as TImageEnMView).ImageCount;
    bmp := TIEBitmap.Create;
    for q := 0 to (fImageEnMView as TImageEnMView).ImageCount - 1 do
    begin
      Param := Params[q];
      Param.DCX_ImageIndex:=q;
      Stream.position := p1;
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q, bmp);
      bmp.DefaultDitherMethod := fDefaultDitherMethod;
      IEDCXInsertStream(Stream,bmp,Param,NullPr);
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * q));
      if fAborting then
        break;
    end;
    FreeAndNil(bmp);
  finally
    DoFinishWork;
  end;
end;

{$ifdef IEINCLUDEDICOM}

{!!
<FS>TImageEnMIO.LoadFromFileDICOM

<FM>Declaration<FC>
procedure LoadFromFileDICOM(const FileName:string);

<FM>Description<FN>
Loads a DICOM image or a multipage DICOM.
This method is necessary when the DICOM file hasn't extension and hasn't a valid DICOM header, but you are sure that is a DICOM file.
DICOM parameters are stored in <A TIOParamsVals.DICOM_Tags>.

<FM>Example<FC>

ImageEnMView1.MIO.LoadFromFileDICOM('heart-sequence');

!!}
procedure TImageEnMIO.LoadFromFileDICOM(const FileName:string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
  fLoadingFileName:=FileName;
  LoadFromStreamDICOM(fs);
  finally
    fLoadingFileName:='';
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnMIO.LoadFromStreamDICOM

<FM>Declaration<FC>
procedure TImageEnMIO.LoadFromStreamDICOM(Stream:TStream);

<FM>Description<FN>
Loads a DICOM image or a sequence of images from stream.
DICOM parameters are stored in <A TIOParamsVals.DICOM_Tags>.
!!}
procedure TImageEnMIO.LoadFromStreamDICOM(Stream:TStream);
var
  p1:int64;
  xbmp, bmp: TIEBitmap;
  numi, idx: integer;
  Progress, Progress2: TProgressRec;
  Param: TIOParamsVals;
  im: integer;
begin
  fAborting := False;
  if not assigned(fImageEnMView) then
    exit;
  try
    (fImageEnMView as TImageEnMView).LockPaint;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    Progress2.fOnProgress := nil;
    Progress2.Sender := nil;
    Progress2.Aborting := @fAborting;
    p1 := Stream.Position;

    //idx := imax((fImageEnMView as TImageEnMView).SelectedImage, 0);
    idx:=(fImageEnMView as TImageEnMView).SelectedImage;
    if idx=-1 then
      idx:=(fImageEnMView as TImageEnMView).ImageCount;


    numi := IEDICOMImageCount(Stream);
    for im:=0 to numi-1 do
    begin
      (fImageEnMView as TImageEnMView).InsertImageEx(idx);
      bmp := TIEBitmap.Create;
      Param := Params[idx];
      Stream.position := p1;
      Param.ImageIndex := im;
      Param.IsNativePixelFormat := fNativePixelFormat;
      IEDICOMRead(Stream,Param,bmp,Progress2,false);
      CheckDPI(Param);
      if fAutoAdjustDPI then
        xbmp := IEAdjustDPI(bmp, Param, fFilteredAdjustDPI)
      else
        xbmp := bmp;
      if bmp <> xbmp then
        FreeAndNil(bmp);
      bmp := xbmp;
      Param.TIFF_ImageIndex := idx;
      Param.GIF_ImageIndex := idx;
      Param.DCX_ImageIndex := idx;
      Param.ICO_ImageIndex := idx;
      Param.FileType := ioDICOM;
      Param.FileName := WideString(fLoadingFileName);
      if fAborting then
      begin
        (fImageEnMView as TImageEnMView).DeleteImage(idx);
        FreeAndNil(bmp);
        break;
      end;
      Progress.per1 := 100 / numi;
      (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx, bmp);
      (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := 100;
      FreeAndNil(bmp);
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * im));
      if fAborting then
        break;
      inc(idx);
    end;
    Update;
  finally
    (fImageEnMView as TImageEnMView).UnLockPaint;
    DoFinishWork;
  end;
end;
{$endif}


{$ifdef IEINCLUDEDIRECTSHOW}
{!!
<FS>TImageEnMIO.LoadFromMediaFile

<FM>Declaration<FC>
procedure LoadFromMediaFile(const FileName: string); dynamic;

<FM>Description<FN>
Loads a video using DirectShow. When LoadFromFileAVI fails, you should try this method.
Also use LoadFromMediaFile to load DirectShow supported files, like wmv, mpeg, avi.

!!}
procedure TImageEnMIO.LoadFromMediaFile(const FileName:string);
var
  dshow:TIEDirectShow;
  idx,i,l:integer;
  Progress: TProgressRec;
  Param: TIOParamsVals;
  bmp:TIEBitmap;
  rate:double;
  avgtime,ltime:int64;
  mul:integer;
begin
  if not assigned(fImageEnMView) then
    exit;
  fAborting := False;
  Progress.fOnProgress := fOnProgress;
  Progress.Sender := Self;
  Progress.Aborting := @fAborting;
  bmp:=TIEBitmap.Create;
  dshow:=TIEDirectShow.Create;
  try
    (fImageEnMView as TImageEnMView).LockPaint;

    dshow.FileInput:=AnsiString(FileName);
    dshow.EnableSampleGrabber:=true;
    dshow.Connect;
    dshow.Pause;

    dshow.TimeFormat:=tfTime;
    ltime:=dshow.Duration;
    if (ltime=0) then begin
      fAborting:=true;
      exit;
    end;
    dshow.TimeFormat:=tfFrame;
    l:=dshow.Duration;
    avgtime:=dshow.GetAverageTimePerFrame;

    idx:=(fImageEnMView as TImageEnMView).SelectedImage;
    if idx=-1 then
      idx:=(fImageEnMView as TImageEnMView).ImageCount;

    if l=ltime then
    begin
      l:=l div avgtime;
      mul:=avgtime;
    end
    else
      mul:=1;
    rate:=(ltime/10000000)/l*100;
    Progress.per1 := 100 / l;
    for i:=0 to l-1 do
    begin
      (fImageEnMView as TImageEnMView).InsertImageEx(idx);
      Param := Params[idx];
      Param.TIFF_ImageIndex := idx;
      Param.GIF_ImageIndex := idx;
      Param.DCX_ImageIndex := idx;
      Param.ICO_ImageIndex := idx;
      Param.FileType := ioUnknown;
      Param.FileName := WideString(FileName);
      Param.IsNativePixelFormat := fNativePixelFormat;

      dshow.position:= int64(i) * int64(mul);
      dshow.GetSample( bmp );

      (fImageEnMView as TImageEnMView).SetIEBitmapEx(idx, bmp);
      (fImageEnMView as TImageEnMView).ImageDelayTime[idx] := trunc(rate);

      if i = 0 then
        with (fImageEnMView as TImageEnMView) do
          if StoreType=ietNormal then
            PrepareSpaceFor(bmp.Width, bmp.Height, bmp.BitCount, l - 1)  // full size
          else
            PrepareSpaceFor(ThumbWidth, ThumbHeight, bmp.BitCount, l - 1); // thumbnails

      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * i));
      if fAborting then
        break;
      inc(idx);
    end;

    dshow.Disconnect;
    Update;
  finally
    FreeAndNil(dshow);
    FreeAndNil(bmp);
    (fImageEnMView as TImageEnMView).UnLockPaint;
    DoFinishWork;
  end;
end;
{$endif}

{!!
<FS>TImageEnMIO.Params

<FM>Declaration<FC>
property Params[idx:integer]: <A TIOParamsVals>;

<FM>Description<FN>
This property contains a TIOParamsVals object for the idx image. This one contains some parameters (as bits per sample, type of compression, etc) of each image file format. The parameters are updated when you load files or streams. Also you can modify these parameters before saving images.

Read-only

!!}
function TImageEnMIO.GetParams(idx: integer): TIOParamsVals;
begin
  if (idx >= 0) and (idx < fParams.Count) then
    result := TIOParamsVals(fParams[idx])
  else
    result:=nil;
end;

procedure TImageEnMIO.RemoveIOParam(idx: integer);
begin
  if idx<fParams.Count then
  begin
    TIOParamsVals(fParams[idx]).free;
    fParams.Delete(idx);
  end;
end;

procedure TImageEnMIO.InsertIOParam(idx: integer);
var
  iop: TIOParamsVals;
  //q: integer;
begin
  iop := TIOparamsVals.Create(nil);
  if fParams.Count > 0 then
  begin
    if idx >= fParams.Count then
      iop.AssignCompressionInfo(TIOParamsVals(fParams[idx - 1]))
    else
      iop.AssignCompressionInfo(TIOParamsVals(fParams[idx]));
  end;
  if idx < fParams.Count then
    // insert
    fParams.Insert(idx, iop)
  else
    // add
    fParams.Add(iop);
  // sort image indexes
  (*
  for q := idx to ParamsCount - 1 do
  begin
    Params[q].TIFF_ImageIndex := q;
    Params[q].GIF_ImageIndex := q;
    Params[q].DCX_ImageIndex := q;
  end;
  *)
end;

procedure TImageEnMIO.MoveIOParams(idx:integer; destination:integer);
begin
  if (idx >= 0) and (idx < fParams.Count) and (destination >= 0) and (destination <> idx) then
  begin
    if destination >= fParams.Count then
    begin
      fParams.Add(fParams[idx]);
      fParams.Delete(idx);
    end
    else
      fParams.Move(idx, destination);
  end;
end;

procedure TImageEnMIO.SwapIOParams(idx1,idx2:integer);
var
  tmp:pointer;
begin
  tmp:=fParams[idx1];
  fParams[idx1]:=fParams[idx2];
  fParams[idx2]:=tmp;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// load from url


{!!
<FS>TImageEnMIO.LoadFromURL

<FM>Declaration<FC>
procedure LoadFromURL(URL:string);

<FM>Description<FN>
LoadFromURL loads a multipage file from the network using the HTTP or FTP protocol, specifing the URL.
This function doesn't support password authentication for HTTP, while it is necessary for FTP (also conntecting to anonymous server).

URL must have the syntax:
'http://domain[:port]/resource'
'https://domain[:port]/resource'
'ftp://user:password@domain[:port]/resource'

It is possible to set proxy parameters using <A TImageEnMIO.ProxyAddress>, <A TImageEnMIO.ProxyUser> and <A TImageEnMIO.ProxyPassword> properties.

<FM>Example<FC>
// load from standard port 80
ImageEnMView.MIO.LoadFromURL('http://www.hicomponents.com/image.gif');

// load from port 8080
ImageEnMView.MIO.LoadFromURL('http://www.hicomponents.com:8080/image.gif');

// load from FTP
ImageEnMView.MIO.LoadFromURL('ftp://space:shuttle@ftp.hicomponents.com/Pictures/test.jpg')

!!}
procedure TImageEnMIO.LoadFromURL(URL: string);
var
  ms:TMemoryStream;
  ft:TIOFileType;
  tempf:string;
  fileext:string;
begin

  ms:=TMemoryStream.Create;

  try

  if not IEGetFromURL(URL,ms,fProxyAddress,fProxyUser,fProxyPassword,fOnProgress,self,@fAborting,FileExt) then
  begin
    fAborting:=true;
    DoFinishWork;
  end
  else
  begin
    fLoadingFileName:=URL;
    ms.Position := 0;
    if not fAborting then
    begin
      ft:=FindStreamFormat(ms);
      case ft of
        ioGIF: LoadFromStreamGIF(ms);
        ioTIFF: LoadFromStreamTIFF(ms);
        ioICO: LoadFromStreamICO(ms);
        ioDCX: LoadFromStreamDCX(ms);
        {$ifdef IEINCLUDEDICOM}
        ioDICOM: LoadFromStreamDICOM(ms);
        {$endif}
        else
        begin
          // format not loadable from stream, need to save in a temporary file
          tempf:=string(IEGetTempFileName2)+'.'+fileExt;
          ms.SaveToFile( tempf );
          FreeAndNil(ms);
          LoadFromFile( tempf );
          DeleteFile( tempf );
        end;
      end;
    end;
  end;

  finally
    fLoadingFileName:='';
    if assigned(ms) then
      FreeAndNil(ms);
  end;
end;

// load from url
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TImageEnMIO.LoadFromFileFormat

<FM>Declaration<FC>
procedure LoadFromFileFormat(const FileName:string; FileFormat:<A TIOFileType>);

<FM>Description<FN>

LoadFromFileFormat loads an image from file. LoadFromFileFormat recognizes the file format from FileFormat parameter.

If the file does not represent a valid image format, the <A TImageEnMIO.Aborting> property is True.
FileName is the file name.

!!}
procedure TImageEnMIO.LoadFromFileFormat(const FileName:string; FileFormat: TIOFileType);
begin
  case FileFormat of
    ioGIF:  LoadFromFileGIF(FileName);
    ioTIFF: LoadFromFileTIFF(FileName);
    ioAVI:  LoadFromFileAVI(FileName);
    ioICO:  LoadFromFileICO(FileName);
    ioDCX:  LoadFromFileDCX(FileName);
    {$ifdef IEINCLUDEDICOM}
    ioDICOM: LoadFromFileDICOM(FileName);
    {$endif}
    else
      LoadFromFile(FileName);
  end;
end;

{!!
<FS>TImageEnMIO.LoadFromFileAuto

<FM>Declaration<FC>
procedure LoadFromFileAuto(const FileName:string);

<FM>Description<FN>

LoadFromFileAuto loads an image from file. To detect file format it doesn't look at the file extension, but at the file content.

<FM>Example<FC>

ImageEnMView1.MIO.LoadFromFileAuto('input.dat');

ImageEnMView1.MIO.LoadFromFileAuto('input.tif'); // a tiff or a RAW?

!!}
procedure TImageEnMIO.LoadFromFileAuto(const FileName:string);
var
  ff:TIOFileType;
begin
  ff:=FindFileFormat(FileName,false);
  if ff=ioUnknown then
    LoadFromFile(FileName)
  else
    LoadFromFileFormat(FileName,ff);
end;

{!!
<FS>TImageEnMIO.LoadFromStream

<FM>Declaration<FC>
procedure LoadFromStream(Stream:TStream);

<FM>Description<FN>

Loads an image (or multiple image) from the specified stream. LoadFromStream tries to detect file format reading the image header.
!!}
procedure TImageEnMIO.LoadFromStream(Stream:TStream);
var
  sf: TIOFileType;
  lp: int64;
begin
  lp:=Stream.Position;
  sf:=FindStreamFormat(Stream);
  Stream.Position:=lp;
  LoadFromStreamFormat(Stream,sf);
end;

{!!
<FS>TImageEnMIO.LoadFromBuffer

<FM>Declaration<FC>
procedure LoadFromBuffer(Buffer:pointer; BufferSize:integer; Format:<A TIOFileType> = ioUnknown);

<FM>Description<FN>
Loads an image or a multipage image from the specified buffer.

<TABLE>
<R> <H>Parameter</H> <H>Description</H> </R>
<R> <C><FC>Buffer<FN></C> <C>The buffer pointer.</C> </R>
<R> <C><FC>BufferSize<FN></C> <C>The buffer length in bytes.</C> </R>
<R> <C><FC>Format<FN></C> <C>Specifies the expected file format. If Format is ioUnknown, then try to find the format automatically.</C> </R>
</TABLE>


<FM>Example<FC>

ImageEnMView1.MIO.LoadFromBuffer(mybuffer, mybufferlength, ioJPEG);
!!}
procedure TImageEnMIO.LoadFromBuffer(Buffer:pointer; BufferSize:integer; Format:TIOFileType);
var
  stream:TIEMemStream;
begin
  stream := TIEMemStream.Create(Buffer, BufferSize);
  try
    if Format=ioUnknown then
      LoadFromStream(stream)
    else
      LoadFromStreamFormat(stream, Format);
  finally
    FreeAndNil(stream);
  end;
end;


{!!
<FS>TImageEnMIO.LoadFromStreamFormat

<FM>Declaration<FC>
procedure LoadFromStreamFormat(Stream:TStream; FileFormat:<A TIOFileType>);

<FM>Description<FN>

Loads an image (or multiple image) from the specified stream assuming that the image has FileFormat format.
!!}
procedure TImageEnMIO.LoadFromStreamFormat(Stream:TStream; FileFormat:TIOFileType);
var
  idx:integer;
begin
  case FileFormat of
    ioGIF:  LoadFromStreamGIF(Stream);
    ioTIFF: LoadFromStreamTIFF(Stream);
    //ioAVI:  LoadFromStreamAVI(Stream);  // not supported
    ioICO:  LoadFromStreamICO(Stream);
    ioDCX:  LoadFromStreamDCX(Stream);
    {$ifdef IEINCLUDEDICOM}
    ioDICOM: LoadFromStreamDICOM(Stream);
    {$endif}
    else
    begin
      if assigned(fImageEnMView) and (FileFormat<>ioUnknown) then
      begin
        // try single image
        idx:=(fImageEnMView as TImageEnMView).SelectedImage;
        if idx=-1 then
          idx:=(fImageEnMView as TImageEnMView).ImageCount;
        (fImageEnMView as TImageEnMView).InsertImageEx(idx);
        (fImageEnMView as TImageEnMView).SetImageFromStream(idx, Stream);
      end
    end;
  end;
end;

{!!
<FS>TImageEnMIO.LoadFromFiles

<FM>Declaration<FC>
procedure LoadFromFiles(const FileName: string; AutoDetect:boolean=false; LoadWhenViewed:boolean=false);

<FM>Description<FN>
Loads multiple files separated by '|' character.
If AutoDetect is true then ImageEn tries to detect file type from header, otherwise it looks only the file extension.
If LoadWhenViewed is true each file is actually loaded only when it needs to be displayed.

<FM>Examples<FC>

- loads three files
ImageEnMView1.MIO.LoadFromFiles('one.jpg|two.jpg|three.jpg');

- execute open dialog returns a list of selected files
filanames:=ImageEnMView1.MIO.ExecuteOpenDialog('','',true,1,'',true);
ImageEnMView1.MIO.LoadFromFiles(filenames);
!!}
procedure TImageEnMIO.LoadFromFiles(const FileName: string; AutoDetect:boolean; LoadWhenViewed:boolean);
var
  sl:TStringList;
  p1,p2,idx:integer;
  mv:TImageEnMView;
begin
  sl:=TStringList.Create;
  mv:=nil;
  try

    p1:=1; p2:=1;
    while p2<=length(FileName) do
    begin
      if (FileName[p2]='|') then
      begin
        sl.Add( Trim(Copy(string(FileName),p1,p2-p1)) );
        p1:=p2+1;
      end;
      inc(p2);
    end;
    if (p1<>p2) then
      sl.Add( Trim(Copy(string(FileName),p1,p2-p1+1)) );

    if assigned(fImageEnMView) and (fImageEnMView is TImageEnMView) then
      mv:=fImageEnMView as TImageEnMView;
    if assigned(mv) then
      mv.LockPaint;

    idx:=0;

    for p1:=0 to sl.Count-1 do
    begin
      if assigned(mv) then
      begin
        idx:=(fImageEnMView as TImageEnMView).SelectedImage;
        if idx=-1 then
          idx:=(fImageEnMView as TImageEnMView).ImageCount;
      end;
      if AutoDetect then
        LoadFromFileAuto( sl[p1] )
      else if LoadWhenViewed and assigned(mv) then
      begin
        // note1: if the file contains multiple pages only the first one is loaded
        // note2: the image is added at the end of the image list
        idx:=mv.AppendImage;
        mv.ImageFileName[idx]:=sl[p1]+'::0';
      end
      else
        LoadFromFile( sl[p1] );
      if assigned(mv) then
        mv.ImageBottomText[idx].Caption := extractfilename(sl[p1]);
      if assigned(fOnProgress) then
        fOnProgress(self, trunc(p1 / sl.Count * 100));
    end;



  finally
    if assigned(mv) then
      mv.UnLockPaint;
    sl.free;
  end;
end;

{!!
<FS>TImageEnMIO.PrintImagePos

<FM>Declaration<FC>
procedure PrintImagePos(ImageIndex:integer; PrtCanvas:TCanvas; x,y:double; Width,Height:double; GammaCorrection:double);

<FM>Description<FN>
PrintImagePos prints the specified image, specifing absolute position and size.

PrtCanvas is the printing canvas. The application can set this parameter from Printer.Canvas.

ImageIndex is the page/image index (0=first page/image).
x,y is the top-left starting point, in inches.
Width,Height is the image size, in inches.
GammaCorrection is the gamma correction value.  Use a value of 1.0 to disable gamma correction.

<FM>Example<FC>

// print the image first page at the position 2, 2 and height 10 and width 10 (stretch the image)
Printer.BeginDoc;
ImageEnMView1.MIO.PrintImagePos(0,Printer.Canvas,2,2,10,10,1);
Printer.EndDoc;
!!}
procedure TImageEnMIO.PrintImagePos(ImageIndex:integer; PrtCanvas: TCanvas; x, y: double; Width, Height: double; GammaCorrection: double);
var
  bmp:TIEBitmap;
  io:TImageEnIO;
begin
  bmp := (fImageEnMView as TImageEnMView).GetTIEBitmap(ImageIndex);
  io := TImageEnIO.CreateFromBitmap(bmp);
  try
    io.PrintImagePos(PrtCanvas,x,y,Width,Height,GammaCorrection);
  finally
    (fImageEnMView as TImageEnMView).ReleaseBitmap(ImageIndex);
    io.free;
  end;
end;

{!!
<FS>TImageEnMIO.PrintImage

<FM>Declaration<FC>
procedure PrintImage(ImageIndex:integer; PrtCanvas:TCanvas; MarginLeft,MarginTop,MarginRight,MarginBottom:double; VerticalPos:<A TIEVerticalPos>; HorizontalPos:<A TIEHorizontalPos>; Size: <A TIESize>; SpecWidth,SpecHeight:double; GammaCorrection:double);

<FM>Description<FN>
PrintImage prints the specified image by specifying margins, vertical position, horizonal position and size.

ImageIndex is the index of the page/image to print (0=first image).
PrtCanvas is the printing canvas. The application can set this parameter from Printer.Canvas.
MarginLeft, MarginTop, MarginRight, MarginBottom are the page margins in inches. By specifying all zero values, no margins are used.
VerticalPos determines how the image vertically aligns within the page.
HorizontalPos determines how the image horizontally aligns within the page.
Size determines the size of the image.
SpecWidth, SpecHeight specify the absolute sizes of the image in inches. Valid only when Size=iesSPECIFIEDSIZE
GammaCorrection is the gamma correction value, use 1 to disable gamma correction.

<FM>Example<FC>

// print the first image in center of the page with original sizes
Printer.BeginDoc;
ImageEnMView1.MIO.PrintImage(0,Printer.Canvas,0,0,0,0,ievpCENTER,iehpCENTER,iesNORMAL,0,0,1);
Printer.EndDoc;

// print the second image in center of the page stretch to the page (respecting the proportions)
Printer.BeginDoc;
ImageEnMView1.MIO.PrintImage(1,Printer.Canvas,0,0,0,0,ievpCENTER,iehpCENTER,iesFITTOPAGE,0,0,1);
Printer.EndDoc;

!!}
procedure TImageEnMIO.PrintImage(ImageIndex:integer; PrtCanvas: TCanvas; MarginLeft: double; MarginTop: double; MarginRight: double; MarginBottom: double; VerticalPos: TIEVerticalPos; HorizontalPos: TIEHorizontalPos; Size: TIESize ; SpecWidth: double; SpecHeight: double; GammaCorrection: double);
var
  bmp:TIEBitmap;
  io:TImageEnIO;
begin
  bmp:=(fImageEnMView as TImageEnMView).GetTIEBitmap(ImageIndex);
  io:=TImageEnIO.CreateFromBitmap(bmp);
  try
    io.PrintImage(PrtCanvas,MarginLeft,MarginTop,MarginRight,MarginBottom,VerticalPos,HorizontalPos,Size,SpecWidth,SpecHeight,GammaCorrection);
  finally
    (fImageEnMView as TImageEnMView).ReleaseBitmap(ImageIndex);
    io.free;
  end;
end;


{!!
<FS>TImageEnMIO.PrintImages

<FM>Declaration<FC>
procedure PrintImages(Columns:integer; Rows:integer; HorizSpace:double; VertSpace:double; PrintSelected:boolean; MarginLeft:double; MarginTop:double; MarginRight:double; MarginBottom:double; DrawBox:boolean; DrawText:boolean; DrawShadow:boolean);

<FM>Description<FN>
PrintImages prints all images or only selected images.
You can specify number of columns and rows, spaces between images and margins. It is possible also to draw box around images, shadows and text.

Columns and Rows specifies how arrange images, specifying the number of columns and rows.
HorizSpace is the horizontal space in inches between images.
VertSpace is the vertical space in inches between images.
PrintSelected is true if you want to print only selected images.
MarginLeft, MarginTop, MarginRight, MarginBottom are the page margins in inches. By specifying all zero values, no margins are used.
DrawBox is true if you want to draw a box around the images (image space). Image is always stretched to maintain aspect ratio.
DrawText is true if you want to draw text associated with every image.
DrawShadow is true if you want a shadow around the image.


<FM>Example<FC>

Printer.BeginDoc;
ImageEnMView1.MIO.PrintImages(nil, 6,4);
Printer.EndDoc;
!!}
procedure TImageEnMIO.PrintImages(Columns:integer; Rows:integer; HorizSpace:double; VertSpace:double; PrintSelected:boolean; MarginLeft:double; MarginTop:double; MarginRight:double; MarginBottom:double; DrawBox:boolean; DrawText:boolean; DrawShadow:boolean);
var
  bmp,tbmp,xbmp:TIEBitmap;
  io:TImageEnIO;
  proc:TImageEnProc;
  mview:TImageEnMView;
  i:integer;
  row,col:integer;
  ww,hh,t1:double;
  pagewidth,pageheight:double;
  dpix,dpiy:integer;
  PrtCanvas:TCanvas;
  bx,by:double;
  bw,bh:double;
  z:double;
  h1,h2,h3:double;
  remaining:integer;

  procedure PrtImg(index:integer);
  begin
    bmp:=mview.GetTIEBitmap(index);

    try

    if DrawShadow then
    begin
      tbmp.Assign( bmp );
      tbmp.PixelFormat:=ie24RGB;
      proc.AddSoftShadow(mview.SoftShadow.Radius,mview.SoftShadow.OffsetX,mview.SoftShadow.OffsetY,true,0,mview.SoftShadow.Intensity);
      tbmp.RemoveAlphaChannel(true,clWhite);
      xbmp:=tbmp;
    end
    else
      xbmp:=bmp;

    io.AttachedIEBitmap:=xbmp;

    bx:=MarginLeft+col*(ww+HorizSpace);
    by:=MarginTop+row*(hh+VertSpace);

    h1:=0;
    h2:=0;
    h3:=0;

    if DrawText then
    begin
      if mview.ImageTopText[index].Caption<>'' then
      begin
        PrtCanvas.Font.Assign(mview.ImageTopText[index].Font);
        t1:=PrtCanvas.TextWidth(mview.ImageTopText[index].Caption);
        h1:=PrtCanvas.TextHeight(mview.ImageTopText[index].Caption);
        PrtCanvas.TextOut(trunc((bx+(ww-t1/dpix)/2)*dpix),trunc(by*dpiy),mview.ImageTopText[index].Caption);
      end;
      if mview.ImageInfoText[index].Caption<>'' then
      begin
        PrtCanvas.Font.Assign(mview.ImageInfoText[index].Font);
        t1:=PrtCanvas.TextWidth(mview.ImageInfoText[index].Caption);
        h2:=PrtCanvas.TextHeight(mview.ImageInfoText[index].Caption);
        PrtCanvas.TextOut(trunc((bx+(ww-t1/dpix)/2)*dpix),trunc((by+hh-h2*2/dpiy)*dpiy),mview.ImageInfoText[index].Caption);
      end;
      if mview.ImageBottomText[index].Caption<>'' then
      begin
        PrtCanvas.Font.Assign(mview.ImageBottomText[index].Font);
        t1:=PrtCanvas.TextWidth(mview.ImageBottomText[index].Caption);
        h3:=PrtCanvas.TextHeight(mview.ImageBottomText[index].Caption);
        PrtCanvas.TextOut(trunc((bx+(ww-t1/dpix)/2)*dpix),trunc((by+hh-h3/dpiy)*dpiy),mview.ImageBottomText[index].Caption);
      end;
    end;

    h1:=h1/dpiy;
    h2:=h2/dpiy;
    h3:=h3/dpiy;
    z:=dmin( ww/(xbmp.Width/dpix), (hh-h1-h2-h3)/(xbmp.Height/dpiy));
    bw:=xbmp.Width/dpix*z;
    bh:=xbmp.Height/dpiy*z;
    io.PrintImagePos(PrtCanvas, bx+(ww-bw)/2, by+(hh-bh-h1-h2-h3)/2+h1, bw,bh);

    if DrawBox then
    begin
      PrtCanvas.Pen.Color:=clBlack;
      PrtCanvas.Pen.Style:=psSolid;
      PrtCanvas.Brush.Style:=bsClear;
      PrtCanvas.Rectangle(trunc(bx*dpix),trunc(by*dpiy),trunc((bx+ww)*dpix),trunc((by+hh)*dpiy));
    end;

    dec(remaining);

    inc(col);
    if col=Columns then
    begin
      col:=0;
      inc(row);
      if row=Rows then
      begin
        row:=0;
        if remaining>0 then
          Printer.NewPage;
      end;
    end;
    finally
      mview.ReleaseBitmap(index);
    end;
  end;

begin
  fAborting := false;

  mview := (fImageEnMView as TImageEnMView);

  try

    io   := TImageEnIO.Create(nil);
    tbmp := TIEBitmap.Create;
    proc := TImageEnProc.CreateFromBitmap(tbmp);

    proc.AutoUndo := false;

    PrtCanvas := Printer.Canvas;
    dpix := GetDeviceCaps(PrtCanvas.Handle, LOGPIXELSX);
    dpiy := GetDeviceCaps(PrtCanvas.Handle, LOGPIXELSY);
    pagewidth  := GetDeviceCaps(PrtCanvas.Handle, 8) / dpix;
    pageheight := GetDeviceCaps(PrtCanvas.Handle, 10) / dpiy;

    row := 0;
    col := 0;
    ww  := (pagewidth-(MarginLeft+MarginRight+HorizSpace*(Columns-1))) / Columns;
    hh  := (pageheight-(MarginTop+MarginBottom+VertSpace*(Rows-1))) / Rows;

    if PrintSelected then
    begin
      // print only selected images
      remaining := mview.MultiSelectedImagesCount;
      for i:=0 to mview.MultiSelectedImagesCount-1 do
      begin
        PrtImg( mview.MultiSelectedImages[i] );
        if assigned(fOnProgress) then
          fOnProgress(self, trunc(i/mview.MultiSelectedImagesCount*100));
        if fAborting then
          break;
      end
    end
    else
    begin
      // print all images
      remaining := mview.ImageCount;
      for i:=0 to mview.ImageCount-1 do
      begin
        PrtImg(i);
        if assigned(fOnProgress) then
          fOnProgress(self, trunc(i/mview.ImageCount*100));
        if fAborting then
          break;
      end
    end;

  finally
    tbmp.Free;
    proc.Free;
    io.Free;
    DoFinishWork;
  end;
end;


{!!
<FS>TImageEnMIO.SaveToFileICO

<FM>Declaration<FC>
procedure SaveToFileICO(const FileName:string);

<FM>Description<FN>
Saves all images in ICO format to the specified file.
!!}
procedure TImageEnMIO.SaveToFileICO(const FileName:string);
var
  fs: TFileStream;
begin
  fAborting := False;
  fs := TFileStream.Create(FileName, fmCreate);
  try
  SaveToStreamICO(fs);
  finally
    FreeAndNil(fs);
  end;
end;

{!!
<FS>TImageEnMIO.SaveToStreamICO

<FM>Declaration<FC>
procedure SaveToStreamICO(Stream:TStream);

<FM>Description<FN>
Saves all images in ICO format to the specified stream.
!!}
procedure TImageEnMIO.SaveToStreamICO(Stream:TStream);
var
  q: integer;
  Progress: TProgressRec;
  nullpr: TProgressRec;
  ielist:array of TObject;
  ie:TImageEnView;
begin
  try
    fAborting := False;
    if not assigned(fImageEnMView) then
      exit;
    if (fImageEnMView as TImageEnMView).ImageCount = 0 then
      exit;
    Progress.fOnProgress := fOnProgress;
    Progress.Sender := Self;
    Progress.Aborting := @fAborting;
    with nullpr do
    begin
      Aborting := Progress.Aborting;
      fOnProgress := nil;
      Sender := nil;
    end;
    Progress.per1 := 100 / (fImageEnMView as TImageEnMView).ImageCount;
    SetLength(ielist, (fImageEnMView as TImageEnMView).ImageCount );
    for q := 0 to  length(ielist)-1 do
    begin
      ie:=TImageEnView.Create(nil);
      ie.LegacyBitmap := false;
      ielist[q] := ie;
      (fImageEnMView as TImageEnMView).CopyToIEBitmap(q, ie.IEBitmap);
      ie.IO.Params.Assign( Params[q] );
      ie.IO.Params.ICO_Sizes[q].cx := ie.IEBitmap.Width;
      ie.IO.Params.ICO_Sizes[q].cy := ie.IEBitmap.Height;
      ie.IO.Params.ICO_ImageIndex := q;
      ie.IO.Params.ICO_Background := Params[q].ICO_Background;
      ie.Update;
      with Progress do
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * q));
      if fAborting then
        break;
    end;
    ICOWriteStream2(Stream, ielist, Progress);
  finally
    for q:=0 to length(ielist)-1 do
      TImageEnView(ielist[q]).Free;
    DoFinishWork;
  end;
end;





{$ELSE} // {$ifdef IEINCLUDEMULTIVIEW}

interface
implementation

{$ENDIF}

end.




