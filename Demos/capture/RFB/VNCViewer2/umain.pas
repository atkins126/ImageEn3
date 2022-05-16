unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls, ieview, iemview, hyieutils, hyiedefs, ExtCtrls;

type
  TMainForm = class(TForm)
    MultiViewer: TImageEnMView;
    XPManifest1: TXPManifest;
    Panel1: TPanel;
    NewConnectionButton: TButton;
    DeleteConnectionButton: TButton;
    HiQualityCheck: TCheckBox;
    Label5: TLabel;
    procedure NewConnectionButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DeleteConnectionButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure HiQualityCheckClick(Sender: TObject);
    procedure MultiViewerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    ConnectionsOpen:integer;
    procedure OnRFBUpdate(Sender:TObject);
    procedure OnDestroyConnectionForm(Sender:TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses unewconnection, uconnectionform;

{$R *.dfm}


procedure TMainForm.FormCreate(Sender: TObject);
begin
  MultiViewer.ThumbnailResampleFilter := rfNone;  // default is low quality
  ConnectionsOpen := 0; // number of connection forms open
end;


procedure TMainForm.FormDestroy(Sender: TObject);
var
  i:integer;
begin
  // destroy open forms
  i := 0;
  while i < ComponentCount do
    if Components[i] is TConnectionForm then
    begin
      RemoveComponent(Components[i]);
      i := 0;
    end
    else
      inc(i);

  // destroy RFB objects
  for i:=0 to MultiViewer.ImageCount - 1 do
    TIERFBClient(MultiViewer.ImageUserPointer[i]).Free;
end;


// delete selected connection
procedure TMainForm.DeleteConnectionButtonClick(Sender: TObject);
var
  imageIndex:integer;
begin
  imageIndex := MultiViewer.SelectedImage;
  if (imageIndex > -1) and (ConnectionsOpen = 0) then
  begin
    TIERFBClient(MultiViewer.ImageUserPointer[imageIndex]).Free;
    MultiViewer.DeleteImage(imageIndex);
  end;
end;


// add a new connection
procedure TMainForm.NewConnectionButtonClick(Sender: TObject);
var
  rfb:TIERFBClient;
  imageIndex:integer;
begin
  if NewConnectionForm.ShowModal = mrOK then
  begin
    rfb := TIERFBClient.Create();
    rfb.OnUpdate := OnRFBUpdate;
    try
      rfb.Connect(NewConnectionForm.AddressEdit.text, StrToIntDef(NewConnectionForm.PortEdit.Text, 5900), NewConnectionForm.PasswordEdit.Text);
    except
      on E:Exception do
      begin
        rfb.Free;
        ShowMessage(E.Message);
        exit;
      end;
    end;
    imageIndex := MultiViewer.AppendImage();
    MultiViewer.ImageUserPointer[imageIndex] := rfb;
    MultiViewer.ImageBottomText[imageIndex].Caption := rfb.ScreenName;
  end;
end;


// update a thumbnail
procedure TMainForm.OnRFBUpdate(Sender:TObject);
var
  imageIndex:integer;
  rfb:TIERFBClient;
begin
  for imageIndex:=0 to MultiViewer.ImageCount-1 do
    if (MultiViewer.ImageUserPointer[imageIndex] = Sender) then // Sender should be TIERFBClient object
    begin
      rfb := MultiViewer.ImageUserPointer[imageIndex];
      rfb.LockFrameBuffer;
      MultiViewer.SetIEBitmap(imageIndex, rfb.FrameBuffer);
      rfb.UnlockFrameBuffer;
      break;
    end;
end;


// form resized. Adjust thumbnails sizes.
procedure TMainForm.FormResize(Sender: TObject);
begin
  MultiViewer.ThumbHeight := MultiViewer.ClientHeight - 25;
  MultiViewer.ThumbWidth := trunc(MultiViewer.ThumbHeight / 0.75);
end;


// Hi Quality checkbox
procedure TMainForm.HiQualityCheckClick(Sender: TObject);
begin
  if HiQualityCheck.Checked then
    MultiViewer.ThumbnailResampleFilter := rfFastLinear
  else
    MultiViewer.ThumbnailResampleFilter := rfNone;
end;


// double click on MultiViewer, port the connection to a new form to control session
procedure TMainForm.MultiViewerMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  imageIndex:integer;
  connForm:TConnectionForm;
begin
  if (Button = mbLeft) and (ssDouble in Shift) then
  begin
    imageIndex := MultiViewer.ImageAtPos(X, Y);
    if imageIndex > -1 then
    begin
      // double over the image "imageIndex" //

      // transfer connection ownership
      connForm := TConnectionForm.Create(self);
      connForm.rfb := MultiViewer.ImageUserPointer[imageIndex];
      connForm.OnDestroy := OnDestroyConnectionForm; // we need to know when form closes
      connForm.Show;
      inc(ConnectionsOpen);

      //
      MultiViewer.Proc.AdjustSaturation(-100);  // make thumbnail gray scale (means "controlling it...")
      MultiViewer.Update;

    end;
  end;

end;


// ConnectionForm destruction
procedure TMainForm.OnDestroyConnectionForm(Sender:TObject);
begin
  // now update events return to MultiViewer
  dec(ConnectionsOpen);
  TConnectionForm(Sender).Viewer.SetExternalBitmap(nil);
  TConnectionForm(Sender).rfb.OnUpdate := OnRFBUpdate;  // restore update events
  TConnectionForm(Sender).rfb.SendRequestUpdate(false); // refresh MultiViewer
end;

end.
