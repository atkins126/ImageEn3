unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, ComCtrls, Dialogs, IEOpenSaveDlg, IEView, ImageENView,
  ImageEnProc, HYIEDefs, HYIEUtils, XPMan;

type
  TForm1 = class ( TForm )
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    UpDownRows: TUpDown;
    Edit2: TEdit;
    UpDownColumns: TUpDown;
    ColorBoxGrid: TColorBox;
    Button2: TButton;
    ImageENView1: TImageEnView;
    OpenImageEnDialog1: TOpenImageEnDialog;
    GroupBox1: TGroupBox;
    XPManifest1: TXPManifest;
    Button3: TButton;
    ImageENView2: TImageEnView;
    Label6: TLabel;
    Label7: TLabel;
    Bevel1: TBevel;
    CheckBoxProportional: TCheckBox;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Button4: TButton;
    SaveImageEnDialog1: TSaveImageEnDialog;
    Label4: TLabel;
    Label10: TLabel;
    FontSizeEdit: TEdit;
    FontSizeUpDown: TUpDown;
    FontComboBox: TComboBox;
    Label11: TLabel;
    Splitter1: TSplitter;
    NegativeCheckBox: TCheckBox;
    procedure FormCreate ( Sender: TObject );
    procedure FormActivate ( Sender: TObject );
    procedure ImageENView1DrawBackBuffer ( Sender: TObject );
    procedure ImageENView1MouseDown ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
    procedure ImageENView1MouseMove ( Sender: TObject; Shift: TShiftState; X,
      Y: Integer );
    procedure Button2Click ( Sender: TObject );
    procedure Button3Click ( Sender: TObject );
    procedure Button4Click ( Sender: TObject );
    procedure Edit1Change ( Sender: TObject );
    procedure Edit2Change ( Sender: TObject );
    procedure ColorBoxGridChange ( Sender: TObject );
    procedure ImageENView1MouseUp ( Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer );
  private
    { Private declarations }
    function GridPos ( view: TImageEnView; col, row: integer ): TPoint;
  public
    { Public declarations }
    Columns: integer;
    Rows: integer;
    Cells: integer;
    ImageWidth: integer;
    ImageHeight: integer;
    CellWidth: double;
    CellHeight: double;
    Z: double;
    SelectionCount: integer;
    AllSelected: boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate ( Sender: TObject );
begin
  SelectionCount := 0;
  Cells := 0;
  AllSelected := false;
  ImageENView1.SelectionOptions := ImageENView1.SelectionOptions - [ iesoSizeable ];
  ImageENView1.SelectionOptions := ImageENView1.SelectionOptions - [ iesoMoveable ];
  ImageENView1.SelectionOptions := ImageENView1.SelectionOptions + [ iesoFilled ];
  FontComboBox.Items := Screen.Fonts;
end;

procedure TForm1.FormActivate ( Sender: TObject );
begin
  Rows := StrToIntDef ( Edit1.Text, 2 );
  Columns := StrToIntDef ( Edit2.Text, 2 );
  Cells := Rows * Columns;
  ImageHeight := ImageENView1.Bitmap.Height;
  FontSizeUpDown.Position := Trunc ( ImageHeight ) div 5;
  CellHeight := ImageHeight / Rows;
  FontComboBox.Text := 'Arial';
  Label4.Caption := 'Cells: ' + IntToStr ( Cells );
  ImageENView1.SelColor1 := ColorBoxGrid.Selected;
  ImageENView1.Update;
end;

function TForm1.GridPos ( view: TImageEnView; col, row: integer ): TPoint;
begin
  Z := view.Zoom / 100;
  ImageWidth := view.IEBitmap.Width;
  ImageHeight := view.IEBitmap.Height;
  CellWidth := ImageWidth / Columns;
  CellHeight := ImageHeight / Rows;
  // Column position
  if col = Columns then
    Result.X := ImageWidth
  else
    Result.X := Round ( CellWidth * col );
  // Row position
  if Row = Rows then
    Result.Y := ImageHeight
  else
    Result.Y := Round ( CellHeight * row );
end;

procedure TForm1.ImageENView1DrawBackBuffer ( Sender: TObject );
var
  i: integer;
  pt: TPoint;
begin
  with ImageENView1.BackBuffer.Canvas do
  begin
    Pen.Color := ColorBoxGrid.Selected;
    Pen.Mode := pmNotXor;
    MoveTo ( 0, 0 );
    for i := 0 to Rows do
    begin
      pt := GridPos ( ImageENView1, 0, i );
      MoveTo ( 0, trunc ( pt.Y * z ) ); // draw rows
      LineTo ( Trunc ( ImageWidth * z ), trunc ( pt.Y * z ) );
    end;
    for i := 0 to Columns do
    begin
      pt := GridPos ( ImageENView1, i, 0 );
      MoveTo ( trunc ( pt.X * z ), 0 ); // draw columns
      LineTo ( trunc ( pt.X * z ), Trunc ( ImageHeight * z ) );
    end;
  end;
end;

procedure CustomNegative ( Proc: TImageEnProc );
var
  ProcBitmap: TIEBitmap;
  Mask: TIEMask;
  x1, y1, x2, y2: integer;
  x, y: integer;
  px: PRGB;
begin
  // we support only ie24RGB format
  if not Proc.BeginImageProcessing ( [ ie24RGB ], x1, y1, x2, y2, 'CustomNegative', ProcBitmap, Mask ) then
    exit;
  for y := y1 to y2 - 1 do
  begin
    px := ProcBitmap.Scanline [ y ];
    for x := x1 to x2 - 1 do
    begin
      with px^ do
      begin
        r := 255 - r;
        g := 255 - g;
        b := 255 - b;
      end;
      inc ( px );
    end;
  end;
  // finalize
  Proc.EndImageProcessing ( ProcBitmap, Mask );
end;

procedure TForm1.ImageENView1MouseDown ( Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  R: TRect;
  XP, YP, v: integer;
  pt1, pt2: TPoint;
  xx, yy: integer;
  x1, y1, x2, y2: integer;
  bx, by: Integer;
begin
  Screen.Cursor := crHourglass;
  try
    if ( Button = mbLeft ) and ( AllSelected ) then
      exit;
    BX := ImageENView1.XScr2Bmp ( X );
    BY := ImageENView1.YScr2Bmp ( Y );
    XP := Trunc ( BX / CellWidth );
    YP := Trunc ( BY / CellHeight );

    Label6.Caption := 'Column: ' + IntToStr ( XP + 1 );
    Label7.Caption := 'Row: ' + IntToStr ( YP + 1 );
    pt1 := GridPos ( ImageENView1, xp, yp );
    pt2 := GridPos ( ImageENView1, xp + 1, yp + 1 );
    R.TopLeft := pt1;
    R.BottomRight := pt2;

    R.Top := ImageENView1.YScr2Bmp ( R.Top );
    R.Bottom := ImageENView1.YScr2Bmp ( R.Bottom );
    R.Left := ImageENView1.XScr2Bmp ( R.Left );
    R.Right := ImageENView1.XScr2Bmp ( R.Right );

    if Button = mbLeft then
      v := 1
    else
      v := 0;

    if Button = mbRight then
      if ImageENView1.IsPointInsideSelection ( bx, by ) then
      begin
        Dec ( SelectionCount );
        Label9.Caption := 'Selected Cells: ' + IntToStr ( SelectionCount );
      end;

    with ImageENView1 do
    begin
      x1 := Round ( R.Left * z );
      x2 := Round ( R.Right * z );
      y1 := Round ( R.Top * z );
      y2 := Round ( R.Bottom * z );
      for yy := y1 to y2 do
        for xx := x1 to x2 do
          SelectionMask.SetPixel ( xx, yy, v );
      SelectCustom;
    end;

    if Button = mbLeft then
    begin
      if ImageENView1.IsPointInsideSelection ( trunc ( bx ), trunc ( by ) ) then
        if Cells <> SelectionCount then
          Inc ( SelectionCount );

    end;
    ImageENView1.CopySelectionToIEBitmap ( ImageENView2.IEBitmap );

    //ImageENView2.Proc.Negative;
    if NegativeCheckBox.Checked then
      CustomNegative ( ImageENView2.Proc );
    ImageENView2.Update;
    Label4.Caption := 'Cells: ' + IntToStr ( Cells );
    Label9.Caption := 'Selected Cells: ' + IntToStr ( SelectionCount );
    ImageENView1.Update;
    ImageENView2.Update;

  finally; Screen.Cursor := crDefault; end;
end;

procedure TForm1.ImageENView1MouseUp ( Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer );
var
  w: integer;
  h: integer;
begin
  if ( Button = mbLeft ) and ( AllSelected ) then
    exit;
  if ( Cells = SelectionCount ) then
    AllSelected := true
  else
    AllSelected := false;
  if ( Button = mbLeft ) and ( Cells = SelectionCount ) then
  begin
    ImageENView1.CopySelectionToIEBitmap ( ImageENView2.IEBitmap );
    MessageBox ( 0, 'All cells have been selected.', 'All Cells Selected', MB_ICONINFORMATION or MB_OK or MB_TOPMOST );
    ImageENView2.LayersAdd;
    ImageENView2.Layers [ 1 ].Transparency := 155;
    ImageENView2.Bitmap.Canvas.Font.Name := FontComboBox.Items [ FontComboBox.ItemIndex ];
    ImageENView2.Bitmap.Canvas.Font.Height := StrToInt ( FontSizeEdit.Text );
    ImageENView2.Bitmap.Canvas.Font.Color := ColorBoxGrid.Selected;
    ImageENView2.Bitmap.Canvas.Brush.Color := ColorBoxGrid.Selected;
    ImageENView2.Bitmap.Canvas.Brush.Style := bsClear; //bsBDiagonal; //bsDiagCross;
    ImageENView2.Bitmap.Canvas.Rectangle ( 0, 0, ImageENView2.Bitmap.Width, ImageENView2.Bitmap.Height );
    w := ( ImageENView2.Bitmap.Width div 2 ) - ( ImageENView2.Bitmap.Canvas.TextExtent ( 'All Selected' ).cx div 2 );
    h := ( ImageENView2.Bitmap.Height div 2 ) - ( ImageENView2.Bitmap.Canvas.TextExtent ( 'All Selected' ).cy div 2 );
    ImageENView2.Bitmap.Canvas.TextOut ( w, h, 'All Selected' ); // draw text
    ImageENView1.Update;
    ImageENView2.Update;
  end;
  if ( Button = mbRight ) then
  begin
    if ImageENView2.LayersCurrent = 1 then
      ImageENView2.LayersRemove ( 1 );
    ImageENView1.CopySelectionToIEBitmap ( ImageENView2.IEBitmap );
    ImageENView2.Update;
  end;
end;

procedure TForm1.ImageENView1MouseMove ( Sender: TObject; Shift: TShiftState;
  X, Y: Integer );
var
  XP, YP, BX, BY: integer;
begin
  if Z > 0 then
  begin
    BX := ImageENView1.XScr2Bmp ( X );
    BY := ImageENView1.YScr2Bmp ( Y );
    XP := Trunc ( BX / CellWidth );
    YP := Trunc ( BY / CellHeight );
    Label5.Caption := 'Column: ' + IntToStr ( XP + 1 );
    Label8.Caption := 'Row: ' + IntToStr ( YP + 1 );
  end;
end;

procedure TForm1.Button2Click ( Sender: TObject );
begin
  if OpenImageEnDialog1.Execute then
  begin
    Screen.Cursor := crHourglass;
    try
      ImageENView1.IO.LoadFromFile ( OpenImageEnDialog1.FileName );
      ImageENView1.Update;
      Rows := StrToIntDef ( Edit1.Text, 2 );
      Columns := StrToIntDef ( Edit2.Text, 2 );
      Cells := Rows * Columns;
      ImageHeight := ImageENView1.Bitmap.Height;
      FontSizeUpDown.Position := Trunc ( ImageHeight ) div 5;
    finally; Screen.Cursor := crDefault; end;
  end;
end;

procedure TForm1.Button3Click ( Sender: TObject );
begin
  ImageENView1.DeSelect;
  ImageENView1.Update;
  ImageENView2.Clear;
  SelectionCount := 0;
  Cells := Rows * Columns;
  Label4.Caption := 'Cells: ' + IntToStr ( Cells );
  Label9.Caption := 'Selected: ' + intToStr ( SelectionCount );
  Label6.Caption := 'Column:';
  Label7.Caption := 'Row:';
end;

procedure TForm1.Edit1Change ( Sender: TObject );
begin
  if CheckBoxProportional.Checked then
    Edit2.Text := Edit1.Text;
  Rows := StrToIntDef ( Edit1.Text, 2 );
  Columns := StrToIntDef ( Edit2.Text, 2 );
  Cells := Rows * Columns;
  Label4.Caption := 'Cells: ' + IntToStr ( Cells );
  ImageENView1.Update;
end;

procedure TForm1.Edit2Change ( Sender: TObject );
begin
  if CheckBoxProportional.Checked then
    Edit1.Text := Edit2.Text;
  Rows := StrToIntDef ( Edit1.Text, 2 );
  Columns := StrToIntDef ( Edit2.Text, 2 );
  Cells := Rows * Columns;
  Label4.Caption := 'Cells: ' + IntToStr ( Cells );
  ImageENView1.Update;
end;

procedure TForm1.Button4Click ( Sender: TObject );
begin
  SaveImageEnDialog1.FileName := '*.png';
  SaveImageEnDialog1.DefaultExt := '*.png';
  SaveImageEnDialog1.FilterIndex := 7;
  if SaveImageEnDialog1.Execute then
  begin
    Screen.Cursor := crHourglass;
    try
      if ImageENView2.LayersCurrent = 1 then
        ImageENView2.LayersMerge ( 0, 1 );
      ImageENView2.IO.SaveToFile ( SaveImageEnDialog1.FileName );
    finally; Screen.Cursor := crDefault; end;
  end;
end;

procedure TForm1.ColorBoxGridChange ( Sender: TObject );
begin
  ImageENView1.SelColor1 := ColorBoxGrid.Selected;
  ImageENView1.Update;
end;



end.

