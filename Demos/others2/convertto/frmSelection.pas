//------------------------------------------------------------------------------
//  ImageEN Convert To  & Lossless Transform Demo: 1.0
//------------------------------------------------------------------------------

unit frmSelection;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls;

type
  TSelectionDialog = class ( TForm )
    OKBtn: TButton;
    CancelBtn: TButton;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    UpDownSize: TUpDown;
    Label2: TLabel;
    ColorBoxColor1: TColorBox;
    ColorBoxColor2: TColorBox;
    Label3: TLabel;
    Label4: TLabel;
    CheckBoxExtendedSelectionDrawing: TCheckBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ColorBox1: TColorBox;
    Label5: TLabel;
    ColorBox2: TColorBox;
    procedure OKBtnClick ( Sender: TObject );
    procedure ColorBoxColor1Change ( Sender: TObject );
    procedure ColorBoxColor2Change ( Sender: TObject );
    procedure UpDownSizeChanging ( Sender: TObject;
      var AllowChange: Boolean );
    procedure CheckBoxExtendedSelectionDrawingClick ( Sender: TObject );
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorBox2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelectionDialog: TSelectionDialog;

implementation

uses FrmMain;

{$R *.dfm}

procedure TSelectionDialog.OKBtnClick ( Sender: TObject );
begin with FormMain do
    ImageENView1.SetSelectionGripStyle ( ColorBoxColor1.Selected,
      ColorBoxColor2.Selected, bsSolid, UpDownSize.Position, CheckBoxExtendedSelectionDrawing.Checked );
end;

procedure TSelectionDialog.ColorBoxColor1Change ( Sender: TObject );
begin
  with FormMain do begin
    ImageENView1.SetSelectionGripStyle ( ColorBoxColor1.Selected,
      ColorBoxColor2.Selected, bsSolid, UpDownSize.Position, CheckBoxExtendedSelectionDrawing.Checked );
  end;
end;

procedure TSelectionDialog.ColorBoxColor2Change ( Sender: TObject );
begin
  with FormMain do begin
    ImageENView1.SetSelectionGripStyle ( ColorBoxColor1.Selected,
      ColorBoxColor2.Selected, bsSolid, UpDownSize.Position, CheckBoxExtendedSelectionDrawing.Checked );
  end;
end;

procedure TSelectionDialog.UpDownSizeChanging ( Sender: TObject;
  var AllowChange: Boolean );
begin
  with FormMain do
    ImageENView1.SetSelectionGripStyle ( ColorBoxColor1.Selected,
      ColorBoxColor2.Selected, bsSolid, UpDownSize.Position, CheckBoxExtendedSelectionDrawing.Checked );
end;

procedure TSelectionDialog.CheckBoxExtendedSelectionDrawingClick (
  Sender: TObject );
begin
  with FormMain do
    ImageENView1.SetSelectionGripStyle ( ColorBoxColor1.Selected,
      ColorBoxColor2.Selected, bsSolid, UpDownSize.Position, CheckBoxExtendedSelectionDrawing.Checked );
end;

procedure TSelectionDialog.ColorBox1Change(Sender: TObject);
begin
  with FormMain do
  begin
  ImageENView1.SelColor1 := ColorBox1.Selected;
  ImageENView1.SelColor2 := ColorBox2.Selected;
  end;
end;

procedure TSelectionDialog.ColorBox2Change(Sender: TObject);
begin
  with FormMain do
  begin
  ImageENView1.SelColor1 := ColorBox1.Selected;
  ImageENView1.SelColor2 := ColorBox2.Selected;
  end;
end;

end.

