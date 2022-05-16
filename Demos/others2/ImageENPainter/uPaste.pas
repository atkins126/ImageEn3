//------------------------------------------------------------------------------
  //  ImageEN Painter    : Version 1.0
  //  Copyright (c) 2007 : Adirondack Software & Graphics
  //  Created            : 05-25-2007
  //  Last Modification  : 05-25-2007
  //  Description        : Paste Unit
//------------------------------------------------------------------------------

unit uPaste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList;

type
  TfrmPaste = class(TForm)
    Label1: TLabel;
    PasteTypeRadioGroup1: TRadioGroup;
    Image1: TImage;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    ImageList1: TImageList;
    procedure PasteTypeRadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPaste: TfrmPaste;

implementation

{$R *.dfm}

procedure TfrmPaste.FormCreate(Sender: TObject);
begin
   ImageList1.GetBitmap( 0, Image1.Picture.Bitmap);
   Image1.Invalidate;
end;

procedure TfrmPaste.PasteTypeRadioGroup1Click(Sender: TObject);
begin
   case PasteTypeRadioGroup1.ItemIndex of
   0:  ImageList1.GetBitmap( 0, Image1.Picture.Bitmap);
   1:  ImageList1.GetBitmap( 1, Image1.Picture.Bitmap);
   end; // case
   Image1.Invalidate;
end;

end.
