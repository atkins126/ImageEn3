(*
PanZoom Example Application

Developed 2005 by Nigel Cross, Xequte Software

There is no limitation in the distribution, reuse or abuse of this application,
other than those imposed by HiComponents.

http://www.xequte.com

*)



unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview, imageenproc, Spin, ieopensavedlg, Math;

type
  TfrmMain = class(TForm)
    ieDisplay: TImageEnView;
    btnViewEffect: TButton;
    Label1: TLabel;
    spnStartX1: TSpinEdit;
    spnStartY1: TSpinEdit;
    spnStartX2: TSpinEdit;
    spnStartY2: TSpinEdit;
    spnEndY2: TSpinEdit;
    spnEndX2: TSpinEdit;
    spnEndY1: TSpinEdit;
    spnEndX1: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    spnSeconds: TSpinEdit;
    Memo1: TMemo;
    btnBrowseFile: TButton;
    OpenImageEnDialog1: TOpenImageEnDialog;
    cmbPZEffect: TComboBox;
    cmbFilename: TComboBox;
    btnSelectStart: TButton;
    bnSelectEnd: TButton;
    btnViewStart: TButton;
    btnViewEnd: TButton;
    chkTransitionRectMaintainAspectRatio: TCheckBox;
    Label4: TLabel;
    cmbTiming: TComboBox;
    procedure btnViewEffectClick(Sender: TObject);
    procedure btnBrowseFileClick(Sender: TObject);
    procedure cmbPZEffectChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbFilenameChange(Sender: TObject);
    procedure btnSelectStartClick(Sender: TObject);
    procedure bnSelectEndClick(Sender: TObject);
    procedure btnViewStartClick(Sender: TObject);

  private
    { Private declarations }
    
    function PromptForDisplayRect(CurrentRect:TRect): TRect;

    procedure RunPanZoomTransition(AnImageEnView:TImageEnView;
                                   sFilename:string;
                                   StartRect:TRect;
                                   EndRect:TRect;
                                   iMilliseconds:Integer;
                                   Timing:TIETransitionTiming=iettLinear);
    function GetEndRect: TRect;
    function GetStartRect: TRect;
    procedure SetEndRect(const Value: TRect);
    procedure SetStartRect(const Value: TRect);
    procedure LoadImage;
  public
    { Public declarations }

    // The area of the image that will be displayed at the start of the transition
    property StartRect:TRect read GetStartRect write SetStartRect;

    // The area of the image that will be displayed at the end of the transition
    property EndRect:TRect read GetEndRect write SetEndRect;
  end;

var
  frmMain: TfrmMain;

const
  _pzZoom_In_Min     = 0;
  _pzZoom_In_Max     = 1;
  _pzZoom_Out_Min    = 2;
  _pzZoom_Out_Max    = 3;
  _pzSlide           = 4;
  _pzReverse_Slide   = 5;
  _pzCustom          = 6;

implementation

uses uGetSelection;

{$R *.DFM}   
{$R WindowsXP.RES}


// IMPORTED FUNCTIONS START

function RectWidth(ARect:Trect):Integer;
begin
  result:=ARect.right-Arect.left;
end;

function RectHeight(ARect:Trect):Integer;
begin
  result:=ARect.bottom-Arect.top;
end;

function PercentageOf(inval,percval:integer):integer;
begin
  result :=Round((inval * percval) / 100);
end;

// returns the path of Application.Exename
function ApplicationFolder: string;
begin
  result:=IncludeTrailingBackslash(extractfilepath(application.exename));
end;
         
// IMPORTED FUNCTIONS END



// Perform a Pan Zoom transition effect
procedure TfrmMain.RunPanZoomTransition(AnImageEnView:TImageEnView;
                                        sFilename:string;
                                        StartRect:TRect;
                                        EndRect:TRect;
                                        iMilliseconds:Integer;
                                        Timing:TIETransitionTiming=iettLinear);
begin
  AnImageEnView.PrepareTransition;
  AnImageEnView.io.loadfromfile(sFilename);

  // Ensure the image is displayed at the correct aspect ratio during the transition
  AnImageEnView.TransitionRectMaintainAspectRatio:=chkTransitionRectMaintainAspectRatio.checked;

  // Return a rectangle of the correct aspect ratio
  AnImageEnView.TransitionStartRect:= StartRect;
  AnImageEnView.TransitionEndRect:= EndRect;
  AnImageEnView.TransitionTiming:= Timing;

  Memo1.clear;
  Memo1.lines.add(format('Adjusted Start Rect: (%d,%d,%d,%d)  W: %d, H: %d',
                         [AnImageEnView.TransitionStartRect.left,
                          AnImageEnView.TransitionStartRect.top,
                          AnImageEnView.TransitionStartRect.right,
                          AnImageEnView.TransitionStartRect.bottom,
                          rectwidth(AnImageEnView.TransitionStartRect),
                          rectheight(AnImageEnView.TransitionStartRect)]));

  Memo1.lines.add(format('Adjusted End Rect: (%d,%d,%d,%d)  W: %d, H: %d',
                         [AnImageEnView.TransitionEndRect.left,
                          AnImageEnView.TransitionEndRect.top,
                          AnImageEnView.TransitionEndRect.right,
                          AnImageEnView.TransitionEndRect.bottom,
                          rectwidth(AnImageEnView.TransitionEndRect),
                          rectheight(AnImageEnView.TransitionEndRect)]));

  AnImageEnView.RunTransition(iettPanZoom,iMilliseconds);
  AnImageEnView.update;

  Memo1.lines.add(format('End Position: (%d,%d) %d%%',
                         [AnImageEnView.ViewX,AnImageEnView.ViewY,round(AnImageEnView.Zoom)]));
end;

        


procedure TfrmMain.btnViewEffectClick(Sender: TObject);
begin
  RunPanZoomTransition(ieDisplay,
                       cmbFilename.text,
                       StartRect,
                       EndRect,
                       spnSeconds.value*1000,
                       TIETransitionTiming(cmbTiming.itemindex));
end;


procedure TfrmMain.btnBrowseFileClick(Sender: TObject);
begin
  if not OpenImageEnDialog1.execute then exit;
  cmbFilename.items.insert(0,OpenImageEnDialog1.filename);
  cmbFilename.itemIndex:=0;
  LoadImage;
end;

// Load the currently selected image
procedure TfrmMain.LoadImage;
begin
  ieDisplay.io.loadfromfile(cmbFilename.text);
  ieDisplay.fit;

  // reset the Start/End rects
  cmbPZEffect.enabled:=true;
  cmbPZEffect.itemindex:=0;
  cmbPZEffectChange(nil);
end;


procedure TfrmMain.cmbPZEffectChange(Sender: TObject);
const
  MIN_ZOOM_IN_LEVEL=40;
  MAX_ZOOM_IN_LEVEL=70;
var
  rStartRect,rEndRect: TRect;
begin
  // Set the start/end rects to common pan zoom effects
  case cmbPZEffect.itemindex of
    _pzZoom_In_Min,_pzZoom_Out_Min:
          begin
            rStartRect:=rect(0,
                             0,
                             ieDisplay.bitmap.width-1,
                             ieDisplay.bitmap.height-1);
            rEndRect:=rect(PercentageOf(ieDisplay.bitmap.width,MIN_ZOOM_IN_LEVEL div 2),
                           PercentageOf(ieDisplay.bitmap.height,MIN_ZOOM_IN_LEVEL div 2),
                           PercentageOf(ieDisplay.bitmap.width,100-MIN_ZOOM_IN_LEVEL div 2),
                           PercentageOf(ieDisplay.bitmap.height,100-MIN_ZOOM_IN_LEVEL div 2));
          end;

    _pzZoom_In_Max,_pzZoom_Out_Max:
          begin
            rStartRect:=rect(0,
                             0,
                             ieDisplay.bitmap.width-1,
                             ieDisplay.bitmap.height-1);
            rEndRect:=rect(PercentageOf(ieDisplay.bitmap.width,MAX_ZOOM_IN_LEVEL div 2),
                           PercentageOf(ieDisplay.bitmap.height,MAX_ZOOM_IN_LEVEL div 2),
                           PercentageOf(ieDisplay.bitmap.width,100-MAX_ZOOM_IN_LEVEL div 2),
                           PercentageOf(ieDisplay.bitmap.height,100-MAX_ZOOM_IN_LEVEL div 2));
          end;

    _pzSlide,_pzReverse_Slide:
          if (ieDisplay.bitmap.height / ieDisplay.height)>(ieDisplay.bitmap.width / ieDisplay.width) then
          // Vertical Slide
          begin
            rStartRect:=rect(0,
                             0,
                             ieDisplay.bitmap.width,
                             round(ieDisplay.bitmap.width * ieDisplay.height / ieDisplay.width));
            rEndRect:=rect(0,
                           ieDisplay.bitmap.height - round(ieDisplay.bitmap.width * ieDisplay.height / ieDisplay.width),
                           ieDisplay.bitmap.width,
                           ieDisplay.bitmap.height);
          end
          ELSE
          // Horizontal Slide
          begin
            rStartRect:=rect(0,
                             0,
                             round(ieDisplay.bitmap.height * ieDisplay.width / ieDisplay.height),
                             ieDisplay.bitmap.height);
            rEndRect:=rect(ieDisplay.bitmap.width - round(ieDisplay.bitmap.height * ieDisplay.width / ieDisplay.height),
                           0,
                           ieDisplay.bitmap.width,
                           ieDisplay.bitmap.height);
          end;

    _pzCustom:
          begin
            exit;
          end;
  end;

 
  if cmbPZEffect.itemindex in [_pzZoom_Out_Min,_pzZoom_Out_Max,_pzReverse_Slide] then
  // Reverse Action
  begin
    StartRect:=rEndRect;
    EndRect:=rStartRect;
  end
  ELSE
  // Normal Action
  begin
    StartRect:=rStartRect;
    EndRect:=rEndRect;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  cmbTiming.itemindex:=0;
  cmbPZEffect.itemindex:= _pzCustom;
  if fileexists((ApplicationFolder)+'landscape.jpg') then
    cmbFilename.items.add(ApplicationFolder+'landscape.jpg');
  if fileexists((ApplicationFolder)+'portrait.jpg') then
    cmbFilename.items.add(ApplicationFolder+'portrait.jpg');
  if cmbFilename.items.count>0 then
  begin
    cmbFilename.itemIndex:=0;
    LoadImage;
  end;
end;

function TfrmMain.GetEndRect: TRect;
begin
  result:=rect(spnEndx1.value,
               spnEndy1.value,
               spnEndx2.value,
               spnEndy2.value);
end;

function TfrmMain.GetStartRect: TRect;
begin
  result:=rect(spnstartx1.value,
               spnstarty1.value,
               spnstartx2.value,
               spnstarty2.value);
end;

procedure TfrmMain.SetEndRect(const Value: TRect);
begin
  spnEndx1.value:= Value.left;
  spnEndy1.value:= Value.top;
  spnEndx2.value:= Value.right;
  spnEndy2.value:= Value.bottom;
end;

procedure TfrmMain.SetStartRect(const Value: TRect);
begin
  spnstartx1.value:= Value.left;
  spnstarty1.value:= Value.top;
  spnstartx2.value:= Value.right;
  spnstarty2.value:= Value.bottom;
end;

procedure TfrmMain.cmbFilenameChange(Sender: TObject);
begin
  LoadImage;
end;

// Return an area of the image for display
function TfrmMain.PromptForDisplayRect(CurrentRect:TRect): TRect;
var
  WholeImageRect: TRect;
begin
  result:=CurrentRect;
  WholeImageRect:=rect(0,
                       0,
                       ieDisplay.bitmap.width-1,
                       ieDisplay.bitmap.height-1);
  Application.CreateForm(TdlgGetSelection, dlgGetSelection);
  with dlgGetSelection do
    try
      ieSelect.assign(ieDisplay);
      rdbWholeImage.checked:= (CurrentRect.left=WholeImageRect.left) and
                              (CurrentRect.top=WholeImageRect.top) and
                              (CurrentRect.bottom=WholeImageRect.bottom) and
                              (CurrentRect.right=WholeImageRect.right);
                              
      if rdbWholeImage.checked=false then
        ieSelect.select(CurrentRect.left,
                        CurrentRect.top,
                        CurrentRect.right,
                        CurrentRect.bottom,
                        iespReplace);

      if dlgGetSelection.showmodal<>mrOk then exit;

      if rdbWholeImage.checked then
        result:=WholeImageRect
      else
        result:=rect(ieSelect.SelX1,
                     ieSelect.SelY1,
                     ieSelect.SelX2,
                     ieSelect.SelY2);

    finally
      dlgGetSelection.free;
    end;
end;


procedure TfrmMain.btnSelectStartClick(Sender: TObject);
begin
  StartRect:= PromptForDisplayRect(StartRect);
end;

procedure TfrmMain.bnSelectEndClick(Sender: TObject);
begin
  EndRect:= PromptForDisplayRect(EndRect);
end;

procedure TfrmMain.btnViewStartClick(Sender: TObject);
begin
  if Sender=btnViewStart then
    ieDisplay.DisplayImageRect(StartRect)
  else                             
    ieDisplay.DisplayImageRect(EndRect);

  Memo1.clear;

  Memo1.lines.add(format('Display: (%d,%d) %d%%',
                         [ieDisplay.ViewX,ieDisplay.ViewY,round(ieDisplay.Zoom)]));
end;


end.
