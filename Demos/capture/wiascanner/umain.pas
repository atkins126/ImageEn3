unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ieview, imageenview, StdCtrls, imageenio, hyieutils, ComCtrls, hyiedefs, iewia;

type
  Tfmain = class(TForm)
    ImageEnView1: TImageEnView;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    GroupBox2: TGroupBox;
    Button4: TButton;
    Button5: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label7: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Label8: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Label9: TLabel;
    Label6: TLabel;
    Edit6: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Edit7: TEdit;
    Label12: TLabel;
    Edit8: TEdit;
    Label13: TLabel;
    Edit9: TEdit;
    Label14: TLabel;
    ComboBox1: TComboBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Label32: TLabel;
    Edit18: TEdit;
    Label33: TLabel;
    Edit19: TEdit;
    Label34: TLabel;
    Edit20: TEdit;
    TabSheet5: TTabSheet;
    Label35: TLabel;
    Edit21: TEdit;
    Label36: TLabel;
    Edit22: TEdit;
    Label37: TLabel;
    Edit23: TEdit;
    Label38: TLabel;
    Edit24: TEdit;
    Label39: TLabel;
    Edit25: TEdit;
    Label40: TLabel;
    Edit26: TEdit;
    Label41: TLabel;
    Edit27: TEdit;
    Label42: TLabel;
    Edit28: TEdit;
    Label43: TLabel;
    Edit29: TEdit;
    Label44: TLabel;
    ComboBox4: TComboBox;
    Label45: TLabel;
    Edit30: TEdit;
    Label46: TLabel;
    Edit31: TEdit;
    Label47: TLabel;
    Edit32: TEdit;
    Label48: TLabel;
    Edit33: TEdit;
    TabSheet6: TTabSheet;
    Label23: TLabel;
    Edit13: TEdit;
    Label24: TLabel;
    Edit14: TEdit;
    Label27: TLabel;
    Label25: TLabel;
    Edit15: TEdit;
    Label28: TLabel;
    Label26: TLabel;
    Edit16: TEdit;
    Label29: TLabel;
    Label30: TLabel;
    Edit17: TEdit;
    Label31: TLabel;
    Label49: TLabel;
    ComboBox5: TComboBox;
    Label50: TLabel;
    Edit34: TEdit;
    Label51: TLabel;
    ComboBox6: TComboBox;
    Label52: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    Label53: TLabel;
    Edit35: TEdit;
    Label54: TLabel;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    TabSheet7: TTabSheet;
    Label55: TLabel;
    Edit36: TEdit;
    Label56: TLabel;
    Edit37: TEdit;
    Label57: TLabel;
    Edit38: TEdit;
    Label18: TLabel;
    Edit10: TEdit;
    Label19: TLabel;
    Edit11: TEdit;
    Label22: TLabel;
    Edit12: TEdit;
    Label20: TLabel;
    ComboBox2: TComboBox;
    Label21: TLabel;
    ComboBox3: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label58: TLabel;
    Edit39: TEdit;
    Label59: TLabel;
    Edit40: TEdit;
    Label60: TLabel;
    Edit41: TEdit;
    Label61: TLabel;
    Edit42: TEdit;
    Label62: TLabel;
    Edit43: TEdit;
    Label63: TLabel;
    ComboBox7: TComboBox;
    Label64: TLabel;
    Edit44: TEdit;
    Label65: TLabel;
    ComboBox8: TComboBox;
    Label66: TLabel;
    Edit45: TEdit;
    Label67: TLabel;
    ComboBox9: TComboBox;
    Label68: TLabel;
    Edit46: TEdit;
    Label69: TLabel;
    Edit47: TEdit;
    Label70: TLabel;
    ComboBox10: TComboBox;
    Label71: TLabel;
    Edit48: TEdit;
    Label72: TLabel;
    Edit49: TEdit;
    Label73: TLabel;
    Edit50: TEdit;
    Label74: TLabel;
    Edit51: TEdit;
    Label75: TLabel;
    ComboBox11: TComboBox;
    Label76: TLabel;
    Edit52: TEdit;
    Edit53: TEdit;
    Label77: TLabel;
    Label78: TLabel;
    ComboBox12: TComboBox;
    Button6: TButton;
    CheckBox18: TCheckBox;
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ImageEnView1Progress(Sender: TObject; per: Integer);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox18Click(Sender: TObject);
  private
    { Private declarations }
    procedure ShowLimits(Edit: TEdit; prop: integer);
  public
    { Public declarations }
    SelectedItem: TIEWiaItem;
  end;

var
  fmain: Tfmain;

implementation

uses uselitem;

{$R *.DFM}

procedure Tfmain.FormCreate(Sender: TObject);
begin
  SelectedItem := nil;
end;

// file | exit

procedure Tfmain.Exit1Click(Sender: TObject);
begin
  close;
end;

// file | open...

procedure Tfmain.Open1Click(Sender: TObject);
begin
  with ImageEnView1 do
    IO.LoadFromFile(IO.ExecuteOpenDialog('', '', false, 1, ''));
end;

// file | save...

procedure Tfmain.Save1Click(Sender: TObject);
begin
  with ImageEnView1 do
    IO.SaveToFile(IO.ExecuteSaveDialog('', '', false, 1, ''));
end;

// Select Source

procedure Tfmain.Button2Click(Sender: TObject);
begin
  ImageEnView1.IO.SelectAcquireSource(ieaWIA);
  SelectedItem := nil;
  Button4Click(self); // read parameters
end;

// Acquire

procedure Tfmain.Button1Click(Sender: TObject);
begin
  ProgressBar1.Position := 0;
  if SelectedItem = nil then
    ImageEnView1.IO.Acquire(ieaWIA)
  else
  begin
    ImageEnView1.IO.WIAParams.ProcessingBitmap := ImageEnView1.IEBitmap;
    ImageEnView1.IO.WIAParams.Transfer(SelectedItem, false);
    ImageEnView1.Update;
  end;
end;

// Acquire with dialog

procedure Tfmain.Button3Click(Sender: TObject);
begin
  ProgressBar1.Position := 0;
  if ImageEnView1.IO.WIAParams.ShowAcquireDialog(true) then
    ImageEnView1.IO.Acquire(ieaWIA);
end;

procedure Tfmain.ImageEnView1Progress(Sender: TObject; per: Integer);
begin
  ProgressBar1.Position := per;
end;

procedure Tfmain.ShowLimits(Edit: TEdit; prop: integer);
var
  attrib: TIEWiaAttrib;
  values: TIEWiaValues;
begin
  ImageEnView1.IO.WIAParams.GetItemPropertyAttrib(prop, SelectedItem, attrib, values);
  Edit.Hint := 'Min=' + string(values.min) + ' Max=' + string(values.max);
  values.free;
end;

// Read parameters

procedure Tfmain.Button4Click(Sender: TObject);
var
  temp: integer;
begin
  with ImageEnView1.IO.WIAParams do
  begin
    // Color and Size
    Edit1.Text := GetItemProperty(WIA_IPS_XRES, SelectedItem);
    Edit2.Text := GetItemProperty(WIA_IPS_YRES, SelectedItem);
    Edit3.Text := GetItemProperty(WIA_IPS_XPOS, SelectedItem);
    Edit4.Text := GetItemProperty(WIA_IPS_YPOS, SelectedItem);
    Edit5.Text := GetItemProperty(WIA_IPS_XEXTENT, SelectedItem);
    Edit6.Text := GetItemProperty(WIA_IPS_YEXTENT, SelectedItem);
    Edit7.Text := GetItemProperty(WIA_IPA_BITS_PER_CHANNEL, SelectedItem);
    Edit8.Text := GetItemProperty(WIA_IPA_CHANNELS_PER_PIXEL, SelectedItem);
    Edit9.Text := GetItemProperty(WIA_IPA_DEPTH, SelectedItem);
    ComboBox1.ItemIndex := GetItemProperty(WIA_IPA_DATATYPE, SelectedItem);
    // Adjust
    Edit10.Text := GetItemProperty(WIA_IPS_BRIGHTNESS, SelectedItem);
    Edit11.Text := GetItemProperty(WIA_IPS_CONTRAST, SelectedItem);
    ComboBox2.ItemIndex := GetItemProperty(WIA_IPS_ORIENTATION, SelectedItem);
    ComboBox3.ItemIndex := GetItemProperty(WIA_IPS_ROTATION, SelectedItem); // readonly
    CheckBox1.Checked := boolean(GetItemProperty(WIA_IPS_MIRROR, SelectedItem));
    Edit12.Text := GetItemProperty(WIA_IPS_THRESHOLD, SelectedItem);
    CheckBox2.Checked := boolean(GetItemProperty(WIA_IPS_INVERT, SelectedItem));
    // Image Info
    Edit18.Text := GetItemProperty(WIA_IPA_ITEM_NAME, SelectedItem); // readonly
    Edit19.Text := GetItemProperty(WIA_IPA_FULL_ITEM_NAME, SelectedItem); // readonly
    Edit20.Text := GetItemProperty(WIA_IPA_ITEM_SIZE, SelectedItem); // readonly
    // Device Info
    Edit13.Text := GetItemProperty(WIA_IPS_WARM_UP_TIME, SelectedItem); // readonly
    Edit14.Text := GetDeviceProperty(WIA_DPS_HORIZONTAL_BED_SIZE); // readonly
    Edit15.Text := GetDeviceProperty(WIA_DPS_VERTICAL_BED_SIZE); // readonly
    Edit16.Text := GetDeviceProperty(WIA_DPS_HORIZONTAL_SHEET_FEED_SIZE); // readonly
    Edit17.Text := GetDeviceProperty(WIA_DPS_VERTICAL_SHEET_FEED_SIZE); // readonly
    Edit23.Text := GetDeviceProperty(WIA_DIP_REMOTE_DEV_ID); // readonly
    Edit24.Text := GetDeviceProperty(WIA_DIP_HW_CONFIG); // readonly
    Edit25.Text := GetDeviceProperty(WIA_DIP_BAUDRATE); // readonly
    Edit26.Text := GetDeviceProperty(WIA_DIP_WIA_VERSION); // readonly
    Edit27.Text := GetDeviceProperty(WIA_DIP_DEV_DESC); // readonly
    Edit28.Text := GetDeviceProperty(WIA_DIP_DEV_ID); // readonly
    Edit29.Text := GetDeviceProperty(WIA_DIP_DEV_NAME); // readonly
    ComboBox4.ItemIndex := integer(GetDeviceProperty(WIA_DIP_DEV_TYPE)) and $3; // readonly
    Edit30.Text := GetDeviceProperty(WIA_DIP_DRIVER_VERSION); // readonly
    Edit31.Text := GetDeviceProperty(WIA_DIP_PORT_NAME); // readonly
    Edit32.Text := GetDeviceProperty(WIA_DIP_SERVER_NAME); // readonly
    Edit33.Text := GetDeviceProperty(WIA_DIP_VEND_DESC); // readonly
    ComboBox5.ItemIndex := GetDeviceProperty(WIA_DPA_CONNECT_STATUS); // readonly
    Edit34.Text := GetDeviceProperty(WIA_DPA_FIRMWARE_VERSION); // readonly
    temp := GetDeviceProperty(WIA_DPS_SHEET_FEEDER_REGISTRATION); // readonly
    ComboBox6.ItemIndex := temp and $3;
    temp := GetDeviceProperty(WIA_DPS_SHEET_FEEDER_REGISTRATION);
    CheckBox3.Checked := (temp and WIA_FEED) <> 0; // readonly
    CheckBox4.Checked := (temp and WIA_FLAT) <> 0; // readonly
    CheckBox5.Checked := (temp and WIA_DUP) <> 0; // readonly
    CheckBox6.Checked := (temp and WIA_DETECT_FLAT) <> 0; // readonly
    CheckBox7.Checked := (temp and WIA_DETECT_SCAN) <> 0; // readonly
    CheckBox8.Checked := (temp and WIA_DETECT_FEED) <> 0; // readonly
    CheckBox9.Checked := (temp and WIA_DETECT_DUP) <> 0; // readonly
    CheckBox10.Checked := (temp and WIA_DETECT_FEED_AVAIL) <> 0; // readonly
    CheckBox11.Checked := (temp and WIA_DETECT_DUP_AVAIL) <> 0; // readonly
    Edit35.Text := GetDeviceProperty(WIA_DPS_DOCUMENT_HANDLING_CAPACITY); // readonly
    temp := GetDeviceProperty(WIA_DPS_DOCUMENT_HANDLING_STATUS);
    CheckBox12.Checked := (temp and WIA_FEED_READY) <> 0; // readonly
    CheckBox13.Checked := (temp and WIA_FLAT_READY) <> 0; // readonly
    CheckBox14.Checked := (temp and WIA_DUP_READY) <> 0; // readonly
    CheckBox15.Checked := (temp and WIA_FLAT_COVER_UP) <> 0; // readonly
    CheckBox16.Checked := (temp and WIA_PATH_COVER_UP) <> 0; // readonly
    CheckBox17.Checked := (temp and WIA_PAPER_JAM) <> 0; // readonly
    Edit36.Text := GetDeviceProperty(WIA_DPS_MAX_SCAN_TIME); // readonly
    Edit37.Text := GetDeviceProperty(WIA_DPS_OPTICAL_XRES); // readonly
    Edit38.Text := GetDeviceProperty(WIA_DPS_OPTICAL_YRES); // readonly
    Edit39.Text := GetDeviceProperty(WIA_DPC_ARTIST);
    Edit40.Text := GetDeviceProperty(WIA_DPC_BATTERY_STATUS); // readonly
    Edit41.Text := GetDeviceProperty(WIA_DPC_COMPRESSION_SETTING);
    Edit42.Text := GetDeviceProperty(WIA_DPC_COPYRIGHT_INFO);
    Edit43.Text := GetDeviceProperty(WIA_DPC_DIGITAL_ZOOM);
    ComboBox7.ItemIndex := integer(GetDeviceProperty(WIA_DPC_EFFECT_MODE)) - 1;
    Edit44.Text := GetDeviceProperty(WIA_DPC_EXPOSURE_COMP);
    ComboBox8.ItemIndex := integer(GetDeviceProperty(WIA_DPC_EXPOSURE_MODE)) - 1;
    Edit45.Text := GetDeviceProperty(WIA_DPC_EXPOSURE_TIME);
    ComboBox9.ItemIndex := integer(GetDeviceProperty(WIA_DPC_FLASH_MODE)) - 1;
    Edit46.Text := GetDeviceProperty(WIA_DPC_FOCAL_LENGTH);
    Edit47.Text := GetDeviceProperty(WIA_DPC_FOCUS_DISTANCE);
    ComboBox10.ItemIndex := integer(GetDeviceProperty(WIA_DPC_FOCUS_MODE)) - 1;
    Edit48.Text := GetDeviceProperty(WIA_DPC_PICT_HEIGHT);
    Edit49.Text := GetDeviceProperty(WIA_DPC_PICT_WIDTH);
    Edit50.Text := GetDeviceProperty(WIA_DPC_PICTURES_REMAINING);
    Edit51.Text := GetDeviceProperty(WIA_DPC_PICTURES_TAKEN);
    ComboBox11.ItemIndex := integer(GetDeviceProperty(WIA_DPC_POWER_MODE)) - 1;
    Edit52.Text := GetDeviceProperty(WIA_DPC_THUMB_HEIGHT);
    Edit53.Text := GetDeviceProperty(WIA_DPC_THUMB_WIDTH);
    ComboBox12.ItemIndex := integer(GetDeviceProperty(WIA_DPC_WHITE_BALANCE)) - 1;

    // Endorser
    Edit21.TExt := GetDeviceProperty(WIA_DPS_ENDORSER_CHARACTERS); // readonly
    Edit22.TExt := GetDeviceProperty(WIA_DPS_ENDORSER_STRING);

    // hints (show minimum and maximum values)
    ShowLimits(Edit1, WIA_IPS_XRES);
    ShowLimits(Edit2, WIA_IPS_YRES);
    ShowLimits(Edit10, WIA_IPS_BRIGHTNESS);
    ShowLimits(Edit11, WIA_IPS_CONTRAST);
    ShowLimits(Edit12, WIA_IPS_THRESHOLD);
  end;
end;

// Write parameters

procedure Tfmain.Button5Click(Sender: TObject);
begin
  with ImageEnView1.IO.WIAParams do
  begin
    // Color and Size
    SetItemProperty(WIA_IPS_XRES, strtointdef(Edit1.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_YRES, strtointdef(Edit2.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_XPOS, strtointdef(Edit3.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_YPOS, strtointdef(Edit4.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_XEXTENT, strtointdef(Edit5.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_YEXTENT, strtointdef(Edit6.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPA_CHANNELS_PER_PIXEL, strtointdef(Edit8.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPA_DEPTH, strtointdef(Edit9.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPA_DATATYPE, ComboBox1.ItemIndex, SelectedItem);
    // Adjust
    SetItemProperty(WIA_IPS_BRIGHTNESS, strtointdef(Edit10.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_CONTRAST, strtointdef(Edit11.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_ROTATION, ComboBox3.ItemIndex, SelectedItem);
    SetItemProperty(WIA_IPS_MIRROR, integer(CheckBox1.Checked), SelectedItem);
    SetItemProperty(WIA_IPS_THRESHOLD, strtointdef(Edit12.Text, 0), SelectedItem);
    SetItemProperty(WIA_IPS_INVERT, integer(CheckBox2.Checked), SelectedItem);
    // camera info
    SetItemPropertyVariant(WIA_DPC_ARTIST, Edit39.Text, SelectedItem);
    SetItemPropertyVariant(WIA_DPC_COMPRESSION_SETTING, Edit41.Text, SelectedItem);
    SetItemPropertyVariant(WIA_DPC_COPYRIGHT_INFO, Edit42.Text, SelectedItem);
    SetItemProperty(WIA_DPC_DIGITAL_ZOOM, strtointdef(Edit43.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_EFFECT_MODE, ComboBox7.ItemIndex + 1, SelectedItem);
    SetItemProperty(WIA_DPC_EXPOSURE_COMP, strtointdef(Edit44.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_EXPOSURE_MODE, ComboBox8.ItemIndex + 1, SelectedItem);
    SetItemProperty(WIA_DPC_EXPOSURE_TIME, strtointdef(Edit45.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_FLASH_MODE, ComboBox9.ItemIndex + 1, SelectedItem);
    SetItemProperty(WIA_DPC_FOCAL_LENGTH, strtointdef(Edit46.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_FOCUS_DISTANCE, strtointdef(Edit47.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_FOCUS_MODE, ComboBox10.ItemIndex + 1, SelectedItem);
    SetItemProperty(WIA_DPC_PICT_HEIGHT, strtointdef(Edit48.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_PICT_WIDTH, strtointdef(Edit49.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_THUMB_HEIGHT, strtointdef(Edit52.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_THUMB_WIDTH, strtointdef(Edit53.Text, 0), SelectedItem);
    SetItemProperty(WIA_DPC_WHITE_BALANCE, ComboBox12.ItemIndex + 1, SelectedItem);
    // Endorser
    SetDevicePropertyVariant(WIA_DPS_ENDORSER_STRING, Edit22.Text);
  end;
  // re-read
  Button4Click(self);
end;

// Select Item

procedure Tfmain.Button6Click(Sender: TObject);
begin
  if (fselitem.ShowModal = mrOK) and assigned(fselitem.TreeView1.Selected) then
    SelectedItem := TIEWiaItem(fselitem.TreeView1.Selected.Data);
end;

// Take New Picture check box

procedure Tfmain.CheckBox18Click(Sender: TObject);
begin
  ImageEnView1.IO.WIAParams.TakePicture := CheckBox18.Checked;
end;

end.
