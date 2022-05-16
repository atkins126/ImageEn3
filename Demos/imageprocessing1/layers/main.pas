unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, iemview, ieview, imageenview, ExtCtrls, StdCtrls, ComCtrls, hyiedefs, hyieutils, imageenproc,
  ieopensavedlg, imageenio, Buttons;

type
  Tfmain = class(TForm)
    Panel1: TPanel;
    MainMenu1: TMainMenu;
    Panel2: TPanel;
    ImageEnView1: TImageEnView;
    ImageEnMView1: TImageEnMView;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label2: TLabel;
    TrackBar2: TTrackBar;
    CheckBox2: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    N2: TMenuItem;
    Loadalllayers1: TMenuItem;
    Savealllayers1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N3: TMenuItem;
    Savemergedlayers1: TMenuItem;
    CheckBox9: TCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox10: TCheckBox;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label7: TLabel;
    TrackBar1: TTrackBar;
    ComboBox2: TComboBox;
    TabSheet3: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    CheckBox4: TCheckBox;
    TrackBar3: TTrackBar;
    ComboBox1: TComboBox;
    ComboBox3: TComboBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    SpeedButton1: TSpeedButton;
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ImageEnView1LayerNotify(Sender: TObject; layer: Integer;
      event: TIELayerEvent);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Loadalllayers1Click(Sender: TObject);
    procedure Savealllayers1Click(Sender: TObject);
    procedure Savemergedlayers1Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure ImageEnView1DrawLayerBox(Sender: TObject; ABitmap: TBitmap;
      layer: Integer);
    procedure CheckBox12Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshControls;
    procedure RefreshLayerViewer;
  end;

var
  fmain: Tfmain;

implementation

{$R *.DFM}

procedure Tfmain.FormActivate(Sender: TObject);
begin
  ImageEnView1.SetLayersGripStyle(clBlack,clLime,bsSolid,5,iegsCircle);
  ImageEnView1.ForceALTkey:=true; // aspect ratio
  ImageEnView1.Blank;
  ImageEnView1.LayersSync := false;
  ImageEnView1.MouseInteract := [miMoveLayers, miResizeLayers];

  RefreshControls;
  RefreshLayerViewer;
end;


// open...

procedure Tfmain.Open1Click(Sender: TObject);
begin
  if not ImageEnView1.IsEmpty and (MessageDlg('Add a layer?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
    ImageEnView1.LayersAdd;

  ImageEnView1.IO.Params.PSD_LoadLayers:=true;
  with ImageEnView1.IO do
    LoadFromFile(ExecuteOpenDialog('', '', false, 1, ''));

  RefreshControls;
  RefreshLayerViewer
end;

// save...

procedure Tfmain.Save1Click(Sender: TObject);
begin
  with ImageenView1.IO do
    SaveToFile(ExecuteSaveDialog('', '', false, 1, ''));
end;

// add new layer

procedure Tfmain.Button1Click(Sender: TObject);
begin
  ImageEnView1.LayersAdd;
  RefreshControls;
  RefreshLayerViewer
end;

// insert new layer

procedure Tfmain.Button6Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersInsert(LayersCurrent);
  RefreshControls;
  RefreshLayerViewer
end;

// remove selected layer

procedure Tfmain.Button2Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersRemove(LayersCurrent);
  RefreshControls;
  RefreshLayerViewer
end;

// selected layer transparency

procedure Tfmain.TrackBar1Change(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    Layers[LayersCurrent].Transparency := TrackBar1.Position;
    Update;
  end;
end;

// select an image (layer) in ImageEnMView1

procedure Tfmain.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  with ImageEnView1 do
  begin
    LayersCurrent := idx;
    RefreshControls;
  end;
end;

// "Visible" checkbox

procedure Tfmain.CheckBox1Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    Layers[LayersCurrent].Visible := CheckBox1.checked;
    Update;
  end;
end;

// refresh controls with the layer content

procedure Tfmain.RefreshControls;
begin
  with ImageEnView1 do
  begin
    with CurrentLayer do
      label4.Caption := '(x=' + IntToStr(PosX) + ',y=' + IntToStr(PosY) + ',w=' + IntToStr(Width) + ',h=' + IntToStr(Height) + ')';
    TrackBar1.Position := CurrentLayer.Transparency;
    CheckBox1.Checked := CurrentLayer.Visible;
    CheckBox3.Checked := CurrentLayer.Cropped;
    CheckBox4.Checked := CurrentLayer.Magnify.Enabled;
    CheckBox5.Checked := CurrentLayer.VisibleBox;
    CheckBox6.Checked := CurrentLayer.Locked;
    CheckBox10.Checked := CurrentLayer.IsMask;
    TrackBar3.Position := trunc(CurrentLayer.Magnify.Rate * 10);
    ComboBox1.ItemIndex := integer(CurrentLayer.Magnify.Style);
    ComboBox2.ItemIndex := integer(CurrentLayer.Operation);
    ComboBox3.ItemIndex := integer(CurrentLayer.Magnify.Source);
    CheckBox11.Checked := CurrentLayer.Selectable;
  end;
end;

procedure Tfmain.RefreshLayerViewer;
var
  i, idx: integer;
begin
  // update ImageEnMView1 with the contents of ImageEnView1
  ImageEnMView1.Clear;
  for i := 0 to ImageEnView1.LayersCount - 1 do
  begin
    idx := ImageEnMView1.AppendImage;
    ImageEnMView1.SetIEBitmap(idx, ImageEnView1.Layers[i].Bitmap);
    ImageEnMView1.ImageTopText[i].Caption := 'Layer ' + inttostr(i);
    ImageEnMView1.ImageTopText[i].Font.Color := clWhite;
  end;
  ImageEnMView1.SelectedImage := ImageEnView1.LayersCurrent;
end;


// exit

procedure Tfmain.Exit1Click(Sender: TObject);
begin
  close;
end;

// merge selected layers

procedure Tfmain.Button3Click(Sender: TObject);
var
  i, idx_A, idx_B: integer;
begin
  with ImageEnMView1 do
    if MultiSelectedImagesCount > 1 then
    begin
      MultiSelectSortList; // here we need sorted items
      // we can merge only two layers at the time (idx_A and idx_B)
      idx_B := MultiSelectedImages[MultiSelectedImagesCount - 1]; // get last selected image
      for i := MultiSelectedImagesCount - 2 downto 0 do
      begin // we countdown to prevent out of index errors
        idx_A := MultiSelectedImages[i];
        ImageEnView1.LayersMerge(idx_A, idx_B, true);
        idx_B := idx_A;
      end;
    end;
  RefreshControls;
  RefreshLayerViewer;
end;

// move up

procedure Tfmain.Button4Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersMove(LayersCurrent, LayersCurrent - 1);
  RefreshControls;
  RefreshLayerViewer;
end;

// move down

procedure Tfmain.Button5Click(Sender: TObject);
begin
  with ImageEnView1 do
    LayersMove(LayersCurrent, LayersCurrent + 1);
  RefreshControls;
  RefreshLayerViewer;
end;

// zoom

procedure Tfmain.TrackBar2Change(Sender: TObject);
begin
  ImageEnView1.Zoom := TrackBar2.Position;
end;

// Show Layers Box

procedure Tfmain.CheckBox2Click(Sender: TObject);
begin
  ImageEnView1.LayersDrawBox := CheckBox2.Checked;
end;

// layer change by user action

procedure Tfmain.ImageEnView1LayerNotify(Sender: TObject; layer: Integer;
  event: TIELayerEvent);
begin
  with ImageEnView1.Layers[layer] do
    label4.Caption := '(x=' + IntToStr(PosX) + ',y=' + IntToStr(PosY) + ',w=' + IntToStr(Width) + ',h=' + IntToStr(Height) + ')';
  if event = ielSelected then
  begin
    ImageEnMView1.SelectedImage := layer;
    RefreshControls;
  end;
end;

// Cropped button

procedure Tfmain.CheckBox3Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Cropped := CheckBox3.checked;
    Update;
  end;
end;

// Magnify layer

procedure Tfmain.CheckBox4Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Magnify.Enabled := CheckBox4.checked;
    Update;
  end;
end;

// Magnification

procedure Tfmain.TrackBar3Change(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Magnify.Rate := TrackBar3.Position / 10;
    Update;
  end;
end;

// set magnify style

procedure Tfmain.ComboBox1Change(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Magnify.Style := TIEMagnifyStyle(ComboBox1.ItemIndex);
    Update;
  end;
end;

// Operation

procedure Tfmain.ComboBox2Change(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Operation := TIERenderOperation(ComboBox2.ItemIndex);
    Update;
  end;
end;

// Visible Box

procedure Tfmain.CheckBox5Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.VisibleBox := CheckBox5.Checked;
    Update;
  end;
end;

// Locked

procedure Tfmain.CheckBox6Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Locked := CheckBox6.Checked;
    Update;
  end;
end;

// Best Quality

procedure Tfmain.CheckBox7Click(Sender: TObject);
begin
  if CheckBox7.Checked then
    ImageEnView1.ZoomFilter := rfTriangle
  else
    ImageEnView1.ZoomFilter := rfNone;
end;

// Alpha channel

procedure Tfmain.CheckBox8Click(Sender: TObject);
begin
  ImageEnView1.EnableAlphaChannel := CheckBox8.Checked;
end;

// load all layers
procedure Tfmain.Loadalllayers1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    ImageEnView1.LayersLoadFromFile( OpenDialog1.FileName );
    RefreshControls;
    RefreshLayerViewer;
  end;
end;

procedure Tfmain.Savealllayers1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    //ImageEnView1.LayersSaveToFile( SaveDialog1.FileName, -1 );
    ImageEnView1.LayersSaveToFile( SaveDialog1.FileName, ioJPEG );
end;

// save layers merged
procedure Tfmain.Savemergedlayers1Click(Sender: TObject);
var
  tempIE:TImageEnView;
begin
  tempIE:=TImageEnView.Create(nil);

  ImageEnView1.LayersDrawTo(tempIE.IEBitmap);
  ImageEnView1.Update;

  with tempIE.IO do
    SaveToFile(ExecuteSaveDialog('', '', false, 1, ''));

  tempIE.free;
end;

// Aspect Ratio
procedure Tfmain.CheckBox9Click(Sender: TObject);
begin
  ImageEnView1.ForceALTkey:=CheckBox9.Checked;
end;


// Changes "Magnify Source"
procedure Tfmain.ComboBox3Change(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Magnify.Source := TIEMagnifySource(ComboBox3.ItemIndex);
    Update;
  end;
end;

// Is Layer Mask
procedure Tfmain.CheckBox10Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.IsMask := CheckBox10.Checked;
    Update;
  end;
end;

// Selectable
procedure Tfmain.CheckBox11Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.Selectable := CheckBox11.Checked;
    Update;
  end;
end;

// Draw Outer
procedure Tfmain.CheckBox12Click(Sender: TObject);
begin
  with ImageEnView1 do
  begin
    CurrentLayer.DrawOuter := CheckBox12.Checked;
    Update;
  end;
end;

procedure Tfmain.ImageEnView1DrawLayerBox(Sender: TObject;
  ABitmap: TBitmap; layer: Integer);
begin
  // a green line
  with ABitmap.Canvas do
  begin
    Pen.Style := psSolid;
    Pen.Width := 1;
    Pen.mode := pmCopy;
    Pen.Color := clGreen;
    Brush.Style := bsClear;
    with TIELayer(ImageEnView1.Layers[layer]).ClientAreaBox do
      Rectangle(Left-1, Top-1, Right+1, Bottom+1);
  end;
end;


// Rotate button
procedure Tfmain.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
    ImageEnView1.MouseInteract := [miRotateLayers]
  else
    ImageEnView1.MouseInteract := [miMoveLayers, miResizeLayers];
end;

end.







