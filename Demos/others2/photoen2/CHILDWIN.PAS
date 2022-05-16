unit Childwin;

interface

uses Windows, Classes, Graphics, Forms, Controls, ImageEn, Menus,
  ImageEnView, RulerBox, ExtCtrls, SysUtils, ImageEnProc, ImageEnIO, ieview;

type
  TMDIChild = class(TForm)
    ImageEnView1: TImageEnView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageEn1ImageChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ImageEn1Progress(Sender: TObject; per: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Changed: boolean;
  end;

implementation

uses Main, Dialogs;

{$R *.DFM}

////////////////////////////////////////////////////////////////////////////////////

procedure TMDIChild.FormCreate(Sender: TObject);
begin
  ImageEnView1.SelColor1 := clBlack;
  ImageEnView1.SelColor2 := clWhite;
  ImageEnView1.SetChessboardStyle(6, bsSolid);
  ImageEnView1.SetSelectionGripStyle(clblack, clWhite, bsClear, 3, true);
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

////////////////////////////////////////////////////////////////////////////////////
// Imaged changed

procedure TMDIChild.ImageEn1ImageChange(Sender: TObject);
begin
  Changed := true;
  MainForm.Undo1.Enabled := ImageEnView1.Proc.CanUndo;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMDIChild.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := true;
  if Changed then
    case MessageDlg('Save Changes to ' + Caption + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        MainForm.FileSaveItemClick(self);
      mrCancel:
        CanClose := false;
    end;
end;

////////////////////////////////////////////////////////////////////////////////////

procedure TMDIChild.ImageEn1Progress(Sender: TObject; per: Integer);
begin
  MainForm.ProgressBar1.Position := per;
end;

end.
