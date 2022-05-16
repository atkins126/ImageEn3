//------------------------------------------------------------------------------
  //  ImageEN Painter    : Version 1.0
  //  Copyright (c) 2007 : Adirondack Software & Graphics
  //  Created            : 05-25-2007
  //  Last Modification  : 05-25-2007
  //  Description        : Pick Transparent Color Unit
//------------------------------------------------------------------------------
unit upick;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TPickDialog = class ( TForm )
    Label1: TLabel;
    PickColor: TPanel;
    Label2: TLabel;
    ColorDialog1: TColorDialog;
    Button1: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Button2: TButton;
    ColorUnderCursor1: TPanel;
    Label5: TLabel;
    procedure PickColorClick ( Sender: TObject );
    procedure Button1Click ( Sender: TObject );
    procedure Button2Click ( Sender: TObject );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PickDialog: TPickDialog;

implementation

uses umain, imageenproc, hyiedefs;

{$R *.DFM}

procedure TPickDialog.Button2Click ( Sender: TObject );
begin
  PickDialog.Free;
end;

procedure TPickDialog.PickColorClick ( Sender: TObject );
begin
  ColorDialog1.Color := PickColor.Color;
  if ColorDialog1.Execute then
  begin
    PickColor.Color := ColorDialog1.Color;
    with TColor2TRGB ( PickColor.Color ) do
      Label3.Caption := IntToStr ( r ) + ',' + IntToStr ( g ) + ',' + IntToStr ( b );
  end;
end;

procedure TPickDialog.Button1Click ( Sender: TObject );
begin
  FrmMain.SetTransparent;
end;

end.

