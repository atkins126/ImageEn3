unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ieview, imageenview, ComCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    ImageEnView1: TImageEnView;
    BitBtn_OpenImage: TBitBtn;
    StatusBar1: TStatusBar;
    BitBtn_crop: TBitBtn;
    CheckBox_fit: TCheckBox;
    TrackBar_ImageEn_Zoom: TTrackBar;
    procedure BitBtn_OpenImageClick(Sender: TObject);
    procedure BitBtn_cropClick(Sender: TObject);
    procedure CheckBox_fitClick(Sender: TObject);
    procedure TrackBar_ImageEn_ZoomChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn_OpenImageClick(Sender: TObject);
begin
 imageenview1.IO.LoadFromFileJpeg('Deutsche Schoenheit 1.jpg');
 imageenview1.MouseInteract := [miSelect];   //go for rectangular area
 TrackBar_ImageEn_Zoom.Position := Round(ImageEnView1.Zoom); //zet trackbar for zoom in and out
end;

procedure TForm1.BitBtn_cropClick(Sender: TObject);
begin
  //ImageEnView1.AssignSelTo(ImageEnView1);
  if ( imageenview1.Selected )
    then ImageEnView1.Proc.CropSel
    else ShowMessage ('Please do select an area to crop with your mouse first!');
end;

procedure TForm1.CheckBox_fitClick(Sender: TObject);
begin
  if (sender as TCheckBox).Checked then
  begin
    ImageEnView1.AutoFit := true;
    ImageEnView1.Fit;
    TrackBar_ImageEn_Zoom.Position := Round(ImageEnView1.Zoom);
    TrackBar_ImageEn_Zoom.Enabled := false;
  end
  else
  begin
    ImageEnView1.AutoFit := false;
    TrackBar_ImageEn_Zoom.Enabled := true;
    ImageEnView1.Zoom := TrackBar_ImageEn_Zoom.Position;
  end;
end;

procedure TForm1.TrackBar_ImageEn_ZoomChange(Sender: TObject);
begin
    ImageEnView1.Zoom := TrackBar_ImageEn_Zoom.Position;;
end;

end.
