unit uselitem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, iewia;

type
  Tfselitem = class(TForm)
    TreeView1: TTreeView;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fselitem: Tfselitem;

implementation

uses umain;

{$R *.DFM}


// build item tree

procedure Tfselitem.FormActivate(Sender: TObject);
begin
  TreeView1.Items.Clear;
  fmain.ImageEnView1.IO.WIAParams.FillTreeView(TreeView1.Items,true);
  TreeView1.FullExpand;
end;

// Unselect

procedure Tfselitem.Button3Click(Sender: TObject);
begin
  TreeView1.Selected := nil;
end;

end.
