unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ieview, imageenview, ExtCtrls, imageenio;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ImageEnView1: TImageEnView;
    Label2: TLabel;
    EditIP: TEdit;
    EditAddress: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    EditUser: TEdit;
    Label5: TLabel;
    EditPassword: TEdit;
    ButtonConnect: TSpeedButton;
    procedure ButtonConnectClick(Sender: TObject);
  private
    { Private declarations }
    FAborting:boolean;
  public
    { Public declarations }
  end;

TIEJpegAcquireStream = class(TStream)
private
  fData:TMemoryStream;
  fStart:boolean;
public
  constructor Create;
  destructor Destroy; override;
  function Write(const Buffer; Count: Longint): Longint; override;
  function Read(var Buffer; Count: Longint): Longint; override;
  function Seek(Offset: Longint; Origin: Word): Longint; override;
end;


var
  Form1: TForm1;

implementation

{$R *.dfm}

constructor TIEJpegAcquireStream.Create;
begin
  inherited;
  fData:=TMemoryStream.Create;
  fStart:=false;
end;

destructor TIEJpegAcquireStream.Destroy;
begin
  fData.Free;
  inherited;
end;

function TIEJpegAcquireStream.Write(const Buffer; Count: Longint): Longint;
var
  buf:pbytearray;
  i:integer;
begin
  result:=Count;
  buf:=pbytearray(@Buffer);
  case fStart of
    false:
      // look for begin of jpeg (FFD8)
      for i:=0 to Count-2 do
        if (buf[i]=$FF) and (buf[i+1]=$D8) then
        begin
          fData.Write( buf[i], Count-i);
          fStart:=true;
          exit;
        end;
    true:
      begin
        // look for end of jpeg (FFD9)
        for i:=0 to Count-2 do
          if (buf[i]=$FF) and (buf[i+1]=$D9) then
          begin
            fData.Write( buf[0], i);
            fStart:=false;

            // acquire bitmap
            fData.Position:=0;
            Form1.ImageEnView1.IO.LoadFromStreamJpeg(fData);
            Application.ProcessMessages;
            fData.Clear;

            exit;
          end;
        // not found, write all
        fData.Write( buf[0], Count );
      end;
  end;
end;

function TIEJpegAcquireStream.Seek(Offset: Longint; Origin: Word): Longint;
begin
  result:=fData.Seek(Offset,Origin);
end;

function TIEJpegAcquireStream.Read(var Buffer; Count: Longint): Longint;
begin
  raise Exception.Create('TIEJpegAcquireStream cannot read.');
end;

// connect switch
procedure TForm1.ButtonConnectClick(Sender: TObject);
var
  stream:TIEJpegAcquireStream;
  fileext:string;
begin
  if ButtonConnect.Down then
  begin
    stream:=TIEJpegAcquireStream.Create;
    FAborting:=false;
    IEGetFromURL('http://'+EditUser.Text+':'+EditPassword.Text+'@'+EditIP.Text+EditAddress.Text,stream,'', '','', nil,nil,@FAborting,fileext);
    stream.Free;
  end
  else
    FAborting:=true;
end;



end.
