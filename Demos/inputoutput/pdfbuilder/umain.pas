unit umain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ieview, imageenview, ComCtrls, imageenio;

type
  Tmainform = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    RadioGroup1: TRadioGroup;
    Label3: TLabel;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    ComboBox2: TComboBox;
    TabSheet3: TTabSheet;
    ImageEnView1: TImageEnView;
    Label2: TLabel;
    Button2: TButton;
    TabSheet4: TTabSheet;
    Page1Next: TButton;
    Page2Next: TButton;
    Page3Next: TButton;
    Button1: TButton;
    Button3: TButton;
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Page1NextClick(Sender: TObject);
    procedure Page2NextClick(Sender: TObject);
    procedure Page3NextClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddPage;
  end;

var
  mainform: Tmainform;

implementation

{$R *.DFM}

// Changes file type

procedure Tmainform.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
    Edit1.Text := 'test.pdf'
  else
    Edit1.Text := 'test.ps';
end;

procedure Tmainform.FormActivate(Sender: TObject);
begin
  ComboBox1.ItemIndex := 4;
  ComboBox2.ItemIndex := 0;
  PageControl1.Pages[1].TabVisible := false;
  PageControl1.Pages[2].TabVisible := false;
  PageControl1.Pages[3].TabVisible := false;
  PageControl1.ActivePage := TabSheet1;
end;

// Page 1 Next

procedure Tmainform.Page1NextClick(Sender: TObject);
begin
  PageControl1.Pages[0].TabVisible := false;
  PageControl1.Pages[1].TabVisible := true;
  PageControl1.ActivePage := TabSheet2;
end;

// Page 2 Next

procedure Tmainform.Page2NextClick(Sender: TObject);
const
  PaperWidth: array[0..11] of integer = (2380, 1684, 1190, 842, 595, 421, 297, 501, 612, 612, 1224, 792);
  PaperHeight: array[0..11] of integer = (3368, 2380, 1684, 1190, 842, 595, 421, 709, 792, 1008, 792, 1224);
begin
  PageControl1.Pages[1].TabVisible := false;
  PageControl1.Pages[2].TabVisible := true;
  PageControl1.ActivePage := TabSheet3;
  // create file
  case RadioGroup1.ItemIndex of
    0:
      begin
        // Adobe PDF
        ImageEnView1.IO.Params.PDF_PaperWidth := PaperWidth[ComboBox1.ItemIndex];
        ImageEnView1.IO.Params.PDF_PaperHeight := PaperHeight[ComboBox1.ItemIndex];
        ImageEnView1.IO.CreatePDFFile(Edit1.Text);
      end;
    1:
      begin
        // PostScript (PS)
        ImageEnView1.IO.Params.PS_PaperWidth := PaperWidth[ComboBox1.ItemIndex];
        ImageEnView1.IO.Params.PS_PaperHeight := PaperHeight[ComboBox1.ItemIndex];
        ImageEnView1.IO.CreatePSFile(Edit1.Text);
      end;
  end;
  //
  ImageEnView1.Blank;
end;

// Page 3 Next

procedure Tmainform.Page3NextClick(Sender: TObject);
begin
  PageControl1.Pages[2].TabVisible := false;
  PageControl1.Pages[3].TabVisible := true;
  PageControl1.ActivePage := TabSheet4;
  //
  case RadioGroup1.ItemIndex of
    0:
      // Adobe PDF
      ImageEnView1.IO.ClosePDFFile;
    1:
      // PostScript (PS)
      ImageEnView1.IO.ClosePSFile;
  end;
end;

// Another!

procedure Tmainform.Button1Click(Sender: TObject);
begin
  PageControl1.Pages[3].TabVisible := false;
  PageControl1.Pages[0].TabVisible := true;
  PageControl1.ActivePage := TabSheet1;
end;

// put current image to the PDF/PS

procedure Tmainform.AddPage;
const
  PDFCompression: array[0..3] of TIOPDFCompression = (ioPDF_RLE, ioPDF_G3FAX2D, ioPDF_G4FAX, ioPDF_JPEG);
  PSCompression: array[0..3] of TIOPSCompression = (ioPS_RLE, ioPS_G3FAX2D, ioPS_G4FAX, ioPS_JPEG);
begin
  case RadioGroup1.ItemIndex of
    0:
      begin
        // Adobe PDF
        ImageEnView1.IO.Params.PDF_Compression := PDFCompression[ComboBox2.ItemIndex];
        ImageEnView1.IO.SaveToPDF;
      end;
    1:
      begin
        // PostScript (PS)
        ImageEnView1.IO.Params.PS_Compression := PSCompression[ComboBox2.ItemIndex];
        ImageEnView1.IO.SaveToPS;
      end;
  end;
end;

// New Page...

procedure Tmainform.Button2Click(Sender: TObject);
var
  filename: string;
begin
  filename := ImageEnView1.IO.ExecuteOpenDialog('', '', false, 1, '');
  if filename <> '' then
  begin
    ImageEnView1.IO.LoadFromFile(filename);
    (* uncomment if you want to convert the image to black/white
    ImageEnView1.proc.ConvertToBWOrdered;
    imageenview1.io.params.BitsPerSample:=1;
    imageenview1.io.params.SamplesPerPixel:=1;
    *)
    AddPage;
  end;
end;

// New page from scanner...

procedure Tmainform.Button3Click(Sender: TObject);
begin
  if ImageEnView1.IO.SelectAcquireSource(ieaTWain) and ImageEnView1.IO.Acquire(ieaTWain) then
    AddPage;
end;

end.
