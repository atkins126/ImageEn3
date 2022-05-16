unit umakernote;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TfMakerNote = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    ListView1: TListView;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMakerNote: TfMakerNote;

implementation

uses umain;

{$R *.DFM}

procedure TfMakerNote.FormActivate(Sender: TObject);
var
  i:integer;
  tag:string;

  procedure AddTag(const desc:string);
  begin
    with ListView1.Items.Add do
    begin
      Caption:=tag;
      SubItems.Append(desc);
    end;
  end;

begin
  ListView1.Items.Clear;

  // read Canon Maker note (look at http://www.burren.cx/david/canon.html )

  with MainForm.ImageEnView1.IO.Params.EXIF_MakerNote do
  begin

    if Data.Size=0 then exit;  // no info

    // Macro Mode
    tag:='Macro mode';
    case GetIntegerIndexed(1, 1) of
      1: AddTag('Macro');
      2: AddTag('Normal');
    end;

    // Self timer
    tag:='Self timer';
    i:=GetIntegerIndexed(1, 2);
    if i=0 then
      AddTag('Off')
    else
      AddTag(floattostr(i/10)+' s');

    // Quality
    tag:='Quality';
    case GetIntegerIndexed(1, 3) of
      2: AddTag('Normal');
      3: AddTag('Fine');
      5: AddTag('Superfine');
    end;

    // Flash mode
    tag:='Flash mode';
    case GetIntegerIndexed(1, 4) of
      0: AddTag('Flash not fired');
      1: AddTag('Auto');
      2: AddTag('On');
      3: AddTag('Red-eye reduction');
      4: AddTag('Slow synchro');
      5: AddTag('Auto + Red-eye reduction');
      6: AddTag('On + Red-eye reduction');
      16: AddTag('External flash');
    end;

    // Continuous drive mode
    tag:='Continuous drive mode';
    case GetIntegerIndexed(1, 5) of
      0: AddTag('Single or Timer');
      1: AddTag('Continuous');
    end;

    // Focus Mode
    tag:='Focus Mode';
    case GetIntegerIndexed(1, 7) of
      0: AddTag('One-Shot');
      1: AddTag('AI Servo');
      2: AddTag('AI Focus');
      3: AddTag('MF');
      4: AddTag('Single');
      5: AddTag('Continuous');
      6: AddTag('MF');
    end;

    // Image size
    tag:='Image size';
    case GetIntegerIndexed(1, 8) of
      0: AddTag('Large');
      1: AddTag('Medium');
      2: AddTag('Small');
    end;

    // "Easy shooting" mode
    tag:='"Easy shooting" mode';
    case GetIntegerIndexed(1, 11) of
      0: AddTag('Full Auto');
      1: AddTag('Manual');
      2: AddTag('Landscape');
      3: AddTag('Fast Shutter');
      4: AddTag('Slow Shutter');
      5: AddTag('Night');
      6: AddTag('B&W');
      7: AddTag('Sepia');
      8: AddTag('Portrait');
      9: AddTag('Sports');
      10: AddTag('Macro / Close-Up');
      11: AddTag('Pan Focus');
    end;

    // Digital Zoom
    tag:='Digital Zoom';
    case GetIntegerIndexed(1, 12) of
      0: AddTag('None');
      1: AddTag('2x');
      2: AddTag('4x');
    end;

    // Contrast
    tag:='Contrast';
    case GetIntegerIndexed(1, 13) of
      $ffff: AddTag('Low');
      $0000: AddTag('Normal');
      $0001: AddTag('High');
    end;

    // Saturation
    tag:='Saturation';
    case GetIntegerIndexed(1, 14) of
      $ffff: AddTag('Low');
      $0000: AddTag('Normal');
      $0001: AddTag('High');
    end;

    // Sharpness
    tag:='Sharpness';
    case GetIntegerIndexed(1, 15) of
      $ffff: AddTag('Low');
      $0000: AddTag('Normal');
      $0001: AddTag('High');
    end;

    // ISO
    tag:='ISO';
    case GetIntegerIndexed(1, 16) of
      15: AddTag('Auto');
      16: AddTag('50');
      17: AddTag('100');
      18: AddTag('200');
      19: AddTag('400');
    end;

    // Metering mode
    tag:='Metering mode';
    case GetIntegerIndexed(1, 17) of
      3: AddTag('Evaluative');
      4: AddTag('Partial');
      5: AddTag('Center-weighted');
    end;

    // Focus type
    tag:='Focus type';
    case GetIntegerIndexed(1, 18) of
      0: AddTag('Manual');
      1: AddTag('Auto');
      3: AddTag('Close-up (macro)');
      8: AddTag('Locked (pan mode)');
    end;

    // AF point selected
    tag:='AF point selected';
    case GetIntegerIndexed(1, 19) of
      $3000: AddTag('None (MF)');
      $3001: AddTag('Auto-selected');
      $3002: AddTag('Right');
      $3003: AddTag('Center');
      $3004: AddTag('Left');
    end;

    // Exposure mode
    tag:='Exposure mode';
    case GetIntegerIndexed(1, 20) of
      0: AddTag('"Easy shooting" (use field 11)');
      1: AddTag('Program');
      2: AddTag('Tv-priority');
      3: AddTag('Av-priority');
      4: AddTag('Manual');
      5: AddTag('A-DEP');
    end;

    // Focal length
    tag:='Focal length';
    i:=GetIntegerIndexed(1, 25);  // "focal units" per mm
    if i<>0 then
      AddTag(FloatToStr(GetIntegerIndexed(1,24)/i)+' - '+FloatToStr(GetIntegerIndexed(1,23)/i));

    // Flash Activity
    tag:='Flash Activity';
    case GetIntegerIndexed(1, 28) of
      0: AddTag('Did not fire');
      1: AddTag('fired');
    end;

    // Flash details
    tag:='Flash details';
    i:=GetIntegerIndexed(1, 29);
    if i and (1 shl 14) <>0 then AddTag('External E-TTL');
    if i and (1 shl 13) <>0 then AddTag('Internal flash');
    if i and (1 shl 11) <>0 then AddTag('FP sync used');
    if i and (1 shl 7)  <>0 then AddTag('2nd("rear")-curtain sync used');
    if i and (1 shl 4)  <>0 then AddTag('FP sync enabled');

    // Focus mode
    tag:='Focus mode';
    case GetIntegerIndexed(1, 32) of
      0: AddTag('Single');
      1: AddTag('Continuous');
    end;

    // White balance
    tag:='White balance';
    case GetIntegerIndexed(4, 7) of
      0: AddTag('Auto');
      1: AddTag('Sunny');
      2: AddTag('Cloudy');
      3: AddTag('Tungsten');
      4: AddTag('Flourescent');
      5: AddTag('Flash');
      6: AddTag('Custom');
    end;

    // Sequence number
    tag:='Sequence number';
    AddTag(inttostr( GetIntegerIndexed(4, 9) ));

    // AF point used
    tag:='AF point used';
    i:=GetIntegerIndexed(4, 14);
    if i and (1 shl 2) <>0 then AddTag('Left');
    if i and (1 shl 1) <>0 then AddTag('Center');
    if i and (1 shl 0) <>0 then AddTag('Right');

    // Flash bias
    tag:='Flash bias';
    case GetIntegerIndexed(4, 15) of
      $ffc0: AddTag('-2 EV');
      $ffcc: AddTag('-1.67 EV');
      $ffd0: AddTag('-1.50 EV');
      $ffd4: AddTag('-1.33 EV');
      $ffe0: AddTag('-1 EV');
      $ffec: AddTag('-0.67 EV');
      $fff0: AddTag('-0.50 EV');
      $fff4: AddTag('-0.33 EV');
      $0000: AddTag('0 EV');
      $000c: AddTag('0.33 EV');
      $0010: AddTag('0.50 EV');
      $0014: AddTag('0.67 EV');
      $0020: AddTag('1 EV');
      $002c: AddTag('1.33 EV');
      $0030: AddTag('1.50 EV');
      $0034: AddTag('1.67 EV');
      $0040: AddTag('2 EV');
    end;

    // Subject Distance
    tag:='Subject Distance';
    AddTag( IntToStr(GetIntegerIndexed(4, 19)) );

    // Image type
    tag:='Image type';
    AddTag( GetString(6) );

    // Firmware version
    tag:='Firmware version';
    AddTag( GetString(7) );

    // Image Number
    tag:='Image Number';
    AddTag( inttostr(GetInteger(8)) );

    // Owner name
    tag:='Owner name';
    AddTag( GetString(9) );

    // Camera serial number
    tag:='Camera serial number';
    AddTag( inttostr(GetInteger($c)) );

    

  end;
end;

end.
