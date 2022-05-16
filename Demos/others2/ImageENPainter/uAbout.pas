//------------------------------------------------------------------------------
  //  ImageEN Painter    : Version 1.0
  //  Copyright (c) 2007 : Adirondack Software & Graphics
  //  Created            : 05-25-2007
  //  Last Modification  : 05-25-2007
  //  Description        : About Unit
//------------------------------------------------------------------------------

unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, hyieutils;

type
  TfrmAbout = class ( TForm )
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Button1: TButton;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    RichEdit1: TRichEdit;
    procedure FormCreate ( Sender: TObject );
    procedure Label1Click ( Sender: TObject );
    procedure Label1MouseEnter ( Sender: TObject );
    procedure Label1MouseLeave ( Sender: TObject );
    procedure Label4Click ( Sender: TObject );
    procedure Label4MouseEnter ( Sender: TObject );
    procedure Label4MouseLeave ( Sender: TObject );
    procedure Label5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

const
  VERSION = '1.0 Vista Ready';
  APP = 'ImageEN Painter';
  COPYRIGHT = 'Copyright © 1999-2007 Adirondack Software';

implementation

uses ShellAPI;

{$R *.dfm}

procedure TfrmAbout.FormActivate(Sender: TObject);
begin
  RichEdit1.Lines.LoadFromFile('ImageEN Painter Features.rtf');
end;

procedure TfrmAbout.FormCreate ( Sender: TObject );
begin
  Label2.Font.Color := RGB(0, 83, 196);
  Label2.Caption := APP;
  Label2.Invalidate;
  Label3.Caption := 'Version ' + VERSION;
  Label3.Invalidate;
  Label4.Caption := COPYRIGHT;
  Label4.Invalidate;
end;

procedure TfrmAbout.Label1Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'http://www.hicomponents.com' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmAbout.Label1MouseEnter ( Sender: TObject );
begin
  Label1.Font.Color := clRed;
  Label1.Font.Style := [ fsUnderline ];
end;

procedure TfrmAbout.Label1MouseLeave ( Sender: TObject );
begin
  Label1.Font.Color := clBlack;
  Label1.Font.Style := [ ];
end;

procedure TfrmAbout.Label4Click ( Sender: TObject );
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'http://www.vizacc.com' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

procedure TfrmAbout.Label4MouseEnter ( Sender: TObject );
begin
  Label4.Font.Color := clRed;
  Label4.Font.Style := [ fsUnderline ];
end;

procedure TfrmAbout.Label4MouseLeave ( Sender: TObject );
begin
  Label4.Font.Color := clBlack;
  Label4.Font.Style := [ ];
end;

procedure TfrmAbout.Label5Click(Sender: TObject);
begin
  Screen.Cursor := crHourglass;
  try
    ShellExecute ( Handle, 'open', PChar ( 'mailto: supportviz@vizacc.com?subject=HelpCommander Support' ), nil, nil, SW_SHOWNORMAL );
  finally; Screen.Cursor := crDefault; end;
end;

end.

