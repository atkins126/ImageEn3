(*
PanZoom Example Application

Developed 2005 by Nigel Cross, Xequte Software

There is no limitation in the distribution, reuse or abuse of this application,
other than those imposed by HiComponents.

http://www.xequte.com

*)

unit uGetSelection;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ieview, imageenview;

type
  TdlgGetSelection = class(TForm)
    ieSelect: TImageEnView;
    Button1: TButton;
    OK: TButton;
    rdbWholeImage: TRadioButton;
    rdbSelImage: TRadioButton;
    chkLockAR: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure rdbWholeImageClick(Sender: TObject);
    procedure ieSelectSelectionChange(Sender: TObject);
    procedure chkLockARClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgGetSelection: TdlgGetSelection;

implementation

{$R *.DFM}

procedure TdlgGetSelection.FormCreate(Sender: TObject);
begin
  // Set the selection aspect ratio
  chkLockARClick(nil);
end;

procedure TdlgGetSelection.rdbWholeImageClick(Sender: TObject);
begin
  if rdbWholeImage.checked then
  begin
    ieSelect.SaveSelection;
    ieSelect.Deselect;
  end
  ELSE
  begin
    ieSelect.RestoreSelection;
  end;
end;

procedure TdlgGetSelection.ieSelectSelectionChange(Sender: TObject);
begin
  rdbSelImage.checked:=true;
end;

procedure TdlgGetSelection.chkLockARClick(Sender: TObject);
begin
  if chkLockAR.checked then
    ieSelect.SelectionAspectRatio:=ieSelect.ClientHeight/ieSelect.ClientWidth
  else
    ieSelect.SelectionAspectRatio:=-1;
end;

end.
