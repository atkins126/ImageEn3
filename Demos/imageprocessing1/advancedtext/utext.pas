unit utext;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, StdCtrls, ToolWin, ievect, imageenview,
  ExtCtrls;

type
  Tftext = class(TForm)
    StandardToolBar: TToolBar;
    FontName: TComboBox;
    ToolButton11: TToolButton;
    FontSize: TEdit;
    UpDown1: TUpDown;
    ToolButton2: TToolButton;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton16: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    ToolButton20: TToolButton;
    ToolbarImages: TImageList;
    JustifyAlign: TToolButton;
    ColorSelect: TPanel;
    ColorDialog1: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure Controls2Text(Sender: TObject);
    procedure ColorSelectClick(Sender: TObject);
  private
    { Private declarations }
    CharInfo:TIEMemoEditCharInfo;
    changing:boolean;
    procedure GetFontNames;
  public
    { Public declarations }
    procedure Text2Controls;
  end;

var
  ftext: Tftext;

implementation

uses umain;

{$R *.dfm}

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure Tftext.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure Tftext.FormCreate(Sender: TObject);
begin
  changing:=false;
  GetFontNames;
end;

procedure Tftext.Controls2Text(Sender: TObject);
begin
  if not changing then
  begin
    changing:=true;
    CharInfo:=fmain.ImageEnVect1.MemoEditingGetCharInfo;
    // font
    if BoldButton.Down then
      CharInfo.Font.Style:=CharInfo.Font.Style + [fsBold]
    else
      CharInfo.Font.Style:=CharInfo.Font.Style - [fsBold];
    if ItalicButton.Down then
      CharInfo.Font.Style:=CharInfo.Font.Style + [fsItalic]
    else
      CharInfo.Font.Style:=CharInfo.Font.Style - [fsItalic];
    if UnderlineButton.Down then
      CharInfo.Font.Style:=CharInfo.Font.Style + [fsUnderline]
    else
      CharInfo.Font.Style:=CharInfo.Font.Style - [fsUnderline];
    CharInfo.Font.Name:=FontName.Text;
    CharInfo.Font.Size:=StrToIntDef( FontSize.Text , 8 );
    CharInfo.Font.Color:=ColorSelect.Color;
    // align
    if LeftAlign.Down then CharInfo.Align:=iejLeft;
    if CenterAlign.Down then CharInfo.Align:=iejCenter;
    if RightAlign.Down then CharInfo.Align:=iejRight;
    if JustifyAlign.Down then CharInfo.Align:=iejJustify;
    //
    fmain.ImageEnVect1.MemoEditingSetCharInfo(CharInfo);
    CharInfo.free;
    changing:=false;
  end;
end;

procedure Tftext.Text2Controls;
begin
  if not changing then
  begin
    changing:=true;
    CharInfo:=fmain.ImageEnVect1.MemoEditingGetCharInfo;
    // font
    FontName.ItemIndex := FontName.Items.IndexOf( CharInfo.Font.Name );
    FontSize.Text := IntToStr( CharInfo.Font.Size );
    UpDown1.Position := CharInfo.Font.Size;
    BoldButton.Down := fsBold in CharInfo.Font.Style;
    ItalicButton.Down := fsItalic in CharInfo.Font.Style;
    UnderlineButton.Down := fsUnderline in CharInfo.Font.Style;
    ColorSelect.Color := CharInfo.Font.Color;
    // align
    case CharInfo.Align of
      iejLeft: LeftAlign.Down:=true;
      iejCenter: CenterAlign.Down:=true;
      iejRight: RightAlign.Down:=true;
      iejJustify: JustifyAlign.Down:=true;
    end;
    //
    CharInfo.free;
    changing:=false;
  end;
end;

// select color
procedure Tftext.ColorSelectClick(Sender: TObject);
begin
  ColorDialog1.Color:=ColorSelect.Color;
  if ColorDialog1.Execute then
    ColorSelect.Color:=ColorDialog1.Color;
  Controls2Text(self);
  fmain.ImageEnVect1.SetFocus;
end;


end.


