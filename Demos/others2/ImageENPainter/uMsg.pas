//------------------------------------------------------------------------------
//  ImageEN Painter    : Version 1.0
//  Copyright (c) 2007 : Adirondack Software & Graphics
//  Created            : 05-15-2006
//  Last Modification  : 05-25-2007
//  Description        : Message Unit
//------------------------------------------------------------------------------

unit uMsg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmMsg = class ( TForm )
    Msg1: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMsg: TFrmMsg;

implementation

{$R *.dfm}

end.

