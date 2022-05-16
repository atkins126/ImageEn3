(*
Copyright (c) 1998-2010 by HiComponents. All rights reserved.

This software comes without express or implied warranty.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE.

ImageEn, IEvolution and ImageEn ActiveX may not be included in any
commercial, shareware or freeware libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com
*)

(*
File version 1001
*)

unit pngfilt;

{$R-}
{$Q-}

{$I ie.inc}

{$IFDEF IEINCLUDEPNG}

interface

uses Windows, Graphics, classes, sysutils, ImageEnProc, ImageEnIO, hyiedefs, hyieutils, iezlib, dialogs;

procedure ReadPNGStream(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var xProgress: TProgressRec; Preview: boolean);
function IsPNGStream(Stream: TStream): boolean;

{$Z4}

type
  png_uint_32 = Cardinal;
  png_uint_32p = ^png_uint_32;
  png_int_32 = integer;
  png_uint_16 = Word;
  png_int_16 = Smallint;
  png_byte = Byte;
  png_size_t = png_uint_32;
  png_charpp = ^png_charp;
  png_charp = PAnsiChar;
  float = single;
  int = Integer;
  png_bytepp = ^png_bytep;
  png_bytep = ^png_byte;
  png_uint_16p = ^png_uint_16;
  png_uint_16pp = ^png_uint_16p;
  png_voidp = pointer;
  time_t = Longint;
  png_doublep = ^png_double;
  png_double = double;

  user_error_ptr = Pointer;
  png_error_ptrp = ^png_error_ptr;
  png_error_ptr = procedure(png_ptr: Pointer; msg: Pointer); cdecl;
  png_rw_ptrp = ^png_rw_ptr;
  png_rw_ptr = procedure(png_ptr: Pointer; data: Pointer;
    length: png_size_t); cdecl;
  png_flush_ptrp = ^png_flush_ptr;
  png_flush_ptr = procedure(png_ptr: Pointer); cdecl;
  png_progressive_info_ptrp = ^png_progressive_info_ptr;
  png_progressive_info_ptr = procedure(png_ptr: Pointer;
    info_ptr: Pointer); cdecl;
  png_progressive_end_ptrp = ^png_progressive_end_ptr;
  png_progressive_end_ptr = procedure(png_ptr: Pointer;
    info_ptr: Pointer); cdecl;
  png_progressive_row_ptrp = ^png_progressive_row_ptr;
  png_progressive_row_ptr = procedure(png_ptr: Pointer;
    data: Pointer; length: png_uint_32;
    count: int); cdecl;
  png_read_status_ptr = procedure(png_ptr: Pointer;
    row_number: png_uint_32; pass: int); cdecl;
  png_write_status_ptr = procedure(png_ptr: Pointer;
    row_number: png_uint_32; pass: int); cdecl;
  png_user_transform_ptr = procedure(png_ptr: Pointer;
    row_info: Pointer; data: png_bytep); cdecl;

  png_colorpp = ^png_colorp;
  png_colorp = ^png_color;
  png_color = packed record
    red, green, blue: png_byte;
  end;

  png_color_16pp = ^png_color_16p;
  png_color_16p = ^png_color_16;
  png_color_16 = packed record
    index: png_byte; //used for palette files
    red, green, blue: png_uint_16; //for use in red green blue files
    gray: png_uint_16; //for use in grayscale files
  end;

  png_color_8pp = ^png_color_8p;
  png_color_8p = ^png_color_8;
  png_color_8 = packed record
    red, green, blue: png_byte; //for use in red green blue files
    gray: png_byte; //for use in grayscale files
    alpha: png_byte; //for alpha channel files
  end;

  png_textpp = ^png_textp;
  png_textp = ^tpng_text;
  tpng_text = packed record
    compression: int; //compression value
    key: png_charp; //keyword, 1-79 character description of "text"
    text: png_charp; //comment, may be empty ("")
    text_length: png_size_t; //length of text field
(*
    itxt_length:png_size_t; // length of the itxt string
    lang:png_charp;         // language code, 0-79 characters or a NULL pointer
    lang_key:png_charp;     // keyword translated UTF-8 string, 0 or more chars or a NULL pointer
    *)
  end;

  png_timepp = ^png_timep;
  png_timep = ^tpng_time;
  tpng_time = packed record
    year: png_uint_16; //yyyy
    month: png_byte; //1..12
    day: png_byte; //1..31
    hour: png_byte; //0..23
    minute: png_byte; //0..59
    second: png_byte; //0..60 (leap seconds)
  end;

  png_infopp = ^png_infop;
  png_infop = Pointer;

  png_row_infopp = ^png_row_infop;
  png_row_infop = ^png_row_info;
  png_row_info = packed record
    width: png_uint_32; //width of row
    rowbytes: png_size_t; //number of bytes in row
    color_type: png_byte; //color type of row
    bit_depth: png_byte; //bit depth of row
    channels: png_byte; //number of channels (1, 2, 3, or 4)
    pixel_depth: png_byte; //bits per pixel (depth * channels)
  end;

  png_structpp = ^png_structp;
  png_structp = Pointer;

  // Supported compression types for text in PNG files (tEXt, and zTXt).
  // The values of the PNG_TEXT_COMPRESSION_ defines should NOT be changed.

const
  PNG_TEXT_COMPRESSION_NONE_WR = -3;
  PNG_TEXT_COMPRESSION_zTXt_WR = -2;
  PNG_TEXT_COMPRESSION_NONE = -1;
  PNG_TEXT_COMPRESSION_zTXt = 0;

  // These describe the color_type field in png_info.
  // color type masks

  PNG_COLOR_MASK_PALETTE = 1;
  PNG_COLOR_MASK_COLOR = 2;
  PNG_COLOR_MASK_ALPHA = 4;

  // color types.  Note that not all combinations are legal

  PNG_COLOR_TYPE_GRAY = 0;
  PNG_COLOR_TYPE_PALETTE = PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_PALETTE;
  PNG_COLOR_TYPE_RGB = PNG_COLOR_MASK_COLOR;
  PNG_COLOR_TYPE_RGB_ALPHA = PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_ALPHA;
  PNG_COLOR_TYPE_GRAY_ALPHA = PNG_COLOR_MASK_ALPHA;

  // This is for compression type. PNG 1.0 only defines the single type.

  PNG_COMPRESSION_TYPE_BASE = 0; // Deflate method 8, 32K window
  PNG_COMPRESSION_TYPE_DEFAULT = PNG_COMPRESSION_TYPE_BASE;

  // This is for filter type. PNG 1.0 only defines the single type.

  PNG_FILTER_TYPE_BASE = 0; // Single row per-byte filtering
  PNG_FILTER_TYPE_DEFAULT = PNG_FILTER_TYPE_BASE;

  // These are for the interlacing type.  These values should NOT be changed.

  PNG_INTERLACE_NONE = 0; // Non-interlaced image
  PNG_INTERLACE_ADAM7 = 1; // Adam7 interlacing

  // These are for the oFFs chunk.  These values should NOT be changed.

  PNG_OFFSET_PIXEL = 0; // Offset in pixels
  PNG_OFFSET_MICROMETER = 1; // Offset in micrometers (1/10^6 meter)

  // These are for the pCAL chunk.  These values should NOT be changed.

  PNG_EQUATION_LINEAR = 0; // Linear transformation
  PNG_EQUATION_BASE_E = 1; // Exponential base e transform
  PNG_EQUATION_ARBITRARY = 2; // Arbitrary base exponential transform
  PNG_EQUATION_HYPERBOLIC = 3; // Hyperbolic sine transformation

  // These are for the pHYs chunk.  These values should NOT be changed.

  PNG_RESOLUTION_UNKNOWN = 0; // pixels/unknown unit (aspect ratio)
  PNG_RESOLUTION_METER = 1; // pixels/meter

  // These are for the sRGB chunk.  These values should NOT be changed.
  PNG_sRGB_INTENT_SATURATION = 0;
  PNG_sRGB_INTENT_PERCEPTUAL = 1;
  PNG_sRGB_INTENT_ABSOLUTE = 2;
  PNG_sRGB_INTENT_RELATIVE = 3;

  // Handle alpha and tRNS by replacing with a background color.
  PNG_BACKGROUND_GAMMA_UNKNOWN = 0;
  PNG_BACKGROUND_GAMMA_SCREEN = 1;
  PNG_BACKGROUND_GAMMA_FILE = 2;
  PNG_BACKGROUND_GAMMA_UNIQUE = 3;

  // Values for png_set_crc_action() to say how to handle CRC errors in
  // ancillary and critical chunks, and whether to use the data contained
  // therein.  Note that it is impossible to "discard" data in a critical
  // chunk.  For versions prior to 0.90, the action was always error/quit,
  // whereas in version 0.90 and later, the action for CRC errors in ancillary
  // chunks is warn/discard.  These values should NOT be changed.

  //      value                   action:critical     action:ancillary

  PNG_CRC_DEFAULT = 0; // error/quit          warn/discard data
  PNG_CRC_ERROR_QUIT = 1; // error/quit          error/quit
  PNG_CRC_WARN_DISCARD = 2; // (INVALID)           warn/discard data
  PNG_CRC_WARN_USE = 3; // warn/use data       warn/use data
  PNG_CRC_QUIET_USE = 4; // quiet/use data      quiet/use data
  PNG_CRC_NO_CHANGE = 5; // use current value   use current value

  // Flags for png_set_filter() to say which filters to use.  The flags
  // are chosen so that they don't conflict with real filter types
  // below, in case they are supplied instead of the #defined constants.
  // These values should NOT be changed.

  PNG_NO_FILTERS = $00;
  PNG_FILTER_NONE = $08;
  PNG_FILTER_SUB = $10;
  PNG_FILTER_UP = $20;
  PNG_FILTER_AVG = $40;
  PNG_FILTER_PAETH = $80;
  PNG_ALL_FILTERS = PNG_FILTER_NONE or PNG_FILTER_SUB or
    PNG_FILTER_UP or PNG_FILTER_AVG or
    PNG_FILTER_PAETH;

  // Filter values (not flags) - used in pngwrite.c, pngwutil.c for now.
  // These defines should NOT be changed.

  PNG_FILTER_VALUE_NONE = 0;
  PNG_FILTER_VALUE_SUB = 1;
  PNG_FILTER_VALUE_UP = 2;
  PNG_FILTER_VALUE_AVG = 3;
  PNG_FILTER_VALUE_PAETH = 4;

  // Heuristic used for row filter selection.  These defines should NOT be
  // changed.

  PNG_FILTER_HEURISTIC_DEFAULT = 0; // Currently "UNWEIGHTED"
  PNG_FILTER_HEURISTIC_UNWEIGHTED = 1; // Used by libpng < 0.95
  PNG_FILTER_HEURISTIC_WEIGHTED = 2; // Experimental feature
  PNG_FILTER_HEURISTIC_LAST = 3; // Not a valid value


implementation

uses ImageEnView, ieview;

{$R-}

var
  __turboFloat: LongBool = False;


function memcmp(buf1, buf2: pbyte; count: integer): integer;  cdecl;
begin
  if count = 0 then
    result := 0
  else
  begin
    while true do
    begin
      dec(count);
      if (count=0) or (buf1^<>buf2^) then
        break;
      inc(buf1);
      inc(buf2);
    end;
    result := buf1^ - buf2^;
  end;
end;

function strncpy(dest, src: PAnsiChar; maxlen: integer): PAnsiChar; cdecl;
begin
  result := strmove(dest, src, maxlen);
end;

function strcpy(dest, src: PAnsiChar): PAnsiChar; cdecl;
begin
  result := sysutils.StrCopy(dest, src);
end;

function fabs(v: double): double; cdecl;
begin
  result := abs(v);
end;

function IntPower(Base: Extended; Exponent: Integer): Extended;
asm
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;

function pow(Base, Exponent: double): double; cdecl;
begin
  if Exponent = 0.0 then
    Result := 1.0 { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0 { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Trunc(Exponent))
  else
    Result := Exp(Exponent * Ln(Base))
end;

function strtod(s: PAnsiChar; var vp: PAnsiChar): double; cdecl;
begin
  vp := @s[strlen(s) - 1]; // !!
  result := IEStrToFloatDefA(s, 0);
end;

function malloc(size: Integer): Pointer; cdecl;
begin
  result := allocmem(size);
end;

procedure free(P: Pointer); cdecl;
begin
  FreeMem(P);
end;

function memset(P: Pointer; B: Byte; count: Integer): pointer; cdecl;
begin
  FillChar(P^, count, B);
  result := P;
end;

function memcpy(dest, source: Pointer; count: Integer): pointer; cdecl;
begin
  Move(source^, dest^, count);
  result := dest;
end;

function _ftol: integer; cdecl;
var
  f: double;
begin
  asm
   	lea    eax, f             //  BC++ passes floats on the FPU stack
    	fstp  qword ptr [eax]     //  Delphi passes floats on the CPU stack
  end;
  if f > 2147483647.0 then
    f := 2147483647.0;
  if f < -2147483648.0 then
    f := 2147483648.0;
  result := integer(Trunc(f));
end;

procedure _assert(__cond: PAnsiChar; __file: PAnsiChar; __line: integer); cdecl;
begin
end;

function memmove(dest, source: Pointer; count: Integer): pointer; cdecl;
begin
  Move(source^, dest^, count);
  result := dest;
end;

function strlen(str: PAnsiChar): integer; cdecl;
begin
  result := sysutils.strlen(str);
end;

function realloc(block: pointer; size: integer): pointer; cdecl;
begin
  reallocmem(block, size);
  result := block;
end;

function fscanf(f: pointer; format: PAnsiChar): integer; cdecl;
begin
  result := 0;
end;


{$L pngread.obj}
{$L pngset.obj}
{$L pngtrans.obj}
{$L pngrtran.obj}
{$L pngrio.obj}
{$L pngmem.obj}
{$L pngerror.obj}
{$L pngrutil.obj}
{$L pngget.obj}
{$L png.obj}

function png_create_read_struct(user_png_ver: png_charp;
  error_ptr: user_error_ptr; error_fn: png_error_ptr;
  warn_fn: png_error_ptr): png_structp;
  cdecl; external;
procedure png_chunk_warning(png_ptr: png_structp;
  const mess: png_charp);
  cdecl; external;
procedure png_chunk_error(png_ptr: png_structp;
  const mess: png_charp);
  cdecl; external;
procedure png_set_IHDR(png_ptr: png_structp; info_ptr: png_infop;
  width, height: png_uint_32; bit_depth, color_type,
  interlace_type, compression_type, filter_type: int);
  cdecl; external;
procedure png_set_PLTE(png_ptr: png_structp; info_ptr: png_infop;
  palette: png_colorp; num_palette: int);
  cdecl; external;
procedure png_set_gAMA(png_ptr: png_structp; info_ptr: png_infop;
  file_gamma: double);
  cdecl; external;
procedure png_set_sBIT(png_ptr: png_structp; info_ptr: png_infop;
  sig_bits: png_color_8p);
  cdecl; external;
procedure png_set_cHRM(png_ptr: png_structp; info_ptr: png_infop;
  white_x, white_y, red_x, red_y, green_x, green_y,
  blue_x, blue_y: double);
  cdecl; external;
procedure png_set_sRGB_gAMA_and_cHRM(png_ptr: png_structp;
  info_ptr: png_infop; intent: int);
  cdecl; external;
procedure png_set_tRNS(png_ptr: png_structp; info_ptr: png_infop;
  trans: png_bytep; num_trans: int;
  trans_values: png_color_16p);
  cdecl; external;
procedure png_set_bKGD(png_ptr: png_structp; info_ptr: png_infop;
  background: png_color_16p);
  cdecl; external;
procedure png_set_hIST(png_ptr: png_structp; info_ptr: png_infop;
  hist: png_uint_16p);
  cdecl; external;
procedure png_set_pHYs(png_ptr: png_structp; info_ptr: png_infop;
  res_x, res_y: png_uint_32; unit_type: int);
  cdecl; external;
procedure png_set_oFFs(png_ptr: png_structp; info_ptr: png_infop;
  offset_x, offset_y: png_uint_32; unit_type: int);
  cdecl; external;
procedure png_set_pCAL(png_ptr: png_structp; info_ptr: png_infop;
  purpose: png_charp; X0, X1: png_int_32;
  typ, nparams: int; units: png_charp;
  params: png_charpp);
  cdecl; external;
procedure png_set_tIME(png_ptr: png_structp; info_ptr: png_infop;
  mod_time: png_timep);
  cdecl; external;
procedure png_set_text(png_ptr: png_structp; info_ptr: png_infop;
  text_ptr: png_textp; num_text: int);
  cdecl; external;
function png_get_text(png_ptr: png_structp; info_ptr:png_infop; text_ptr:png_textpp; num_text:pinteger):png_uint_32; cdecl;  external;
function png_create_info_struct(png_ptr: png_structp): png_infop;
  cdecl; external;
procedure png_destroy_read_struct(png_ptr_ptr: png_structpp;
  info_ptr_ptr, end_info_ptr_ptr: png_infopp);
  cdecl; external;
procedure png_set_read_fn(png_ptr: png_structp;
  io_ptr: png_voidp; read_data_fn: png_rw_ptr);
  cdecl; external;
procedure png_read_info(png_ptr: png_structp; info_ptr: png_infop);
  cdecl; external;
function png_get_IHDR(png_ptr: png_structp; info_ptr: png_infop;
  var width, height: png_uint_32; var bit_depth,
  color_type, interlace_type, compression_type,
  filter_type: int): png_uint_32;
  cdecl; external;
procedure png_set_expand(png_ptr: png_structp);
  cdecl; external;
procedure png_set_bgr(png_ptr: png_structp);
  cdecl; external;
procedure png_set_swap(png_ptr: png_structp);
  cdecl; external;
procedure png_set_strip_16(png_ptr: png_structp);
  cdecl; external;
procedure png_set_packing(png_ptr: png_structp);
  cdecl; external;
procedure png_set_gray_to_rgb(png_ptr: png_structp);
  cdecl; external;
procedure png_read_update_info(png_ptr: png_structp; info_ptr: png_infop);
  cdecl; external;
function png_set_interlace_handling(png_ptr: png_structp): int;
  cdecl; external;
procedure png_read_rows(png_ptr: png_structp; row, display_row:
  png_bytepp; num_rows: png_uint_32);
  cdecl; external;
procedure png_read_end(png_ptr: png_structp; info_ptr: png_infop);
  cdecl; external;
function png_get_io_ptr(png_ptr: png_structp): png_voidp;
  cdecl; external;
function png_get_rowbytes(png_ptr: png_structp; info_ptr: png_infop):
  png_uint_32;
  cdecl; external;
function png_get_bKGD(png_ptr: png_structp; info_ptr: png_infop;
  var background: png_color_16p): png_uint_32;
  cdecl; external;
procedure png_set_background(png_ptr: png_structp;
  background_color: png_color_16p;
  background_gamma_code, need_expand: int;
  background_gamma: double);
  cdecl; external;
function png_get_x_pixels_per_meter(png_ptr: png_structp;
  info_ptr: png_infop): png_uint_32;
  cdecl; external;
function png_get_y_pixels_per_meter(png_ptr: png_structp;
  info_ptr: png_infop): png_uint_32;
  cdecl; external;
function png_get_interlace_type(png_ptr: png_structp;
  info_ptr: png_infop): png_byte;
  cdecl; external;
procedure png_set_gamma(png_ptr: png_structp; screen_gamma,
  default_file_gamma: double);
  cdecl; external;
function png_get_gAMA(png_ptr: png_structp; info_ptr: png_infop;
  var file_gamma: double): png_uint_32;
  cdecl; external;
function png_get_PLTE(png_ptr: png_structp; info_ptr: png_infop;
  var palette: png_colorp; var num_palette: int):
  png_uint_32;
  cdecl; external;
function png_sig_cmp(sig: png_bytep; start, num_to_check: png_size_t):
  int;
  cdecl; external;
function png_get_channels(png_ptr: png_structp; info_ptr: png_infop): png_byte;
  cdecl; external;
procedure png_set_tRNS_to_alpha(png_ptr: png_structp); cdecl; external;

procedure PNG_MEMSET_CHECK; external;
procedure PNG_DO_STRIP_FILLER; external;
procedure PNG_DO_INVERT; external;
procedure PNG_DO_BGR; external;
procedure PNG_DO_PACKSWAP; external;
procedure PNG_DO_SWAP; external;
procedure PNG_INIT_READ_TRANSFORMATIONS; external;
procedure PNG_SET_GAMA_FIXED; external;
procedure PNG_SET_CHRM_FIXED; external;
procedure PNG_SET_ICCP; external;
procedure PNG_SET_SPLT; external;
procedure PNG_SET_SCAL; external;
procedure PNG_SET_UNKNOWN_CHUNKS; external;
procedure png_set_text_2; external;


procedure ErrorFunc(png_ptr: Pointer; msg: Pointer); cdecl;
begin
  pboolean(png_ptr)^ := true;
  Abort;
end;

procedure WarnFunc(png_ptr: Pointer; msg: Pointer); cdecl;
begin

end;

procedure ReadFunc(png_ptr: png_structp; data: Pointer; length: png_size_t); cdecl;
var
  Stream: TStream;
begin
  Stream := png_get_io_ptr(png_ptr);
  if png_size_t(Stream.Read(PAnsiChar(data)^, length)) < length then
    Abort;
end;

///////////////////////////////////////////////////////////////////////////////////////

procedure ReadPNGStream(Stream: TStream; Bitmap: TIEBitmap; var IOParams: TIOParamsVals; var xProgress: TProgressRec; Preview: boolean);
var
  png_ptr: png_structp;
  info_ptr: png_infop;
  width, height: png_uint_32;
  compression_type: integer;
  filter_type: integer;
  bit_depth, color_type, interlace_type: integer;
  Error_ptr: pointer;
  i, number_passes, pass, y: integer;
  px: pointer;
  bgrnd:png_color_16p;
  palette: png_colorp;
  num_palette: integer;
  channels, x: integer;
  arowbuf, apx, apx2: pbyte;
  native: boolean;
  text_ptr:png_textp;
  lper,per:integer;
begin
{$WARNINGS OFF}
  try
    try
      Error_ptr := xProgress.Aborting;
      png_ptr := nil;
      png_ptr := png_create_read_struct('1.2.14', Error_ptr, @ErrorFunc, @WarnFunc);
      if png_ptr = nil then
      begin
        xProgress.Aborting^ := true;
        Abort;
      end;
      info_ptr := png_create_info_struct(png_ptr);
      if info_ptr = nil then
      begin
        png_destroy_read_struct(@png_ptr, nil, nil);
        png_ptr := nil;
        xProgress.Aborting^ := true;
        Abort;
      end;
      png_set_read_fn(png_ptr, Stream, @ReadFunc);
      png_read_info(png_ptr, info_ptr);

      png_get_IHDR(png_ptr, info_ptr, width, height, bit_depth, color_type,
        interlace_type, Compression_type, filter_type);

      // get text
      x:=png_get_text(png_ptr,info_ptr,@text_ptr,nil);
      IOParams.PNG_TextKeys.Clear;
      IOParams.PNG_TextValues.Clear;
      for i:=0 to x-1 do
      begin
        IOParams.PNG_TextKeys.Add( text_ptr^.key );
        IOParams.PNG_TextValues.Add( text_ptr^.text );
        inc(text_ptr);
      end;

      // 2.2.9
      bgrnd:=nil;
      png_get_bKGD(png_ptr,info_ptr,bgrnd);
      if bgrnd<>nil then
        IOParams.PNG_Background := CreateRGB( bgrnd^.red shr 8, bgrnd^.green shr 8, bgrnd^.blue shr 8 );

      if (not IOParams.IsNativePixelFormat) or
         ((bit_depth <> 8) and (bit_depth<>16)) or
         ((color_type <> PNG_COLOR_TYPE_PALETTE) and (color_type <> PNG_COLOR_TYPE_GRAY)) then
      begin

        // Is paletted? (from 2 to 8 bit)
        if (color_type = PNG_COLOR_TYPE_PALETTE) and (bit_depth <= 8) and (bit_depth > 1) then
          png_set_expand(png_ptr);
        // Is grayscale? (from 2 to 7 bit)
        if (color_type = PNG_COLOR_TYPE_GRAY) and (bit_depth < 8) and (bit_depth > 1) then
          png_set_expand(png_ptr);
        // Is grayscale? (only 16 bit)
        if (bit_depth = 16) then
          png_set_strip_16(png_ptr);
        //
        if (bit_depth < 8) and (bit_depth > 1) then
          png_set_packing(png_ptr);
        // Is grayscale and not blackwhite?
        if ((color_type = PNG_COLOR_TYPE_GRAY) or (color_type = PNG_COLOR_TYPE_GRAY_ALPHA)) and (bit_depth > 1) then
          png_set_gray_to_rgb(png_ptr);

        if (bit_depth > 1) then
          png_set_bgr(png_ptr);

        native := false;

      end
      else
      begin

        if bit_depth=16 then
          png_set_swap(png_ptr);

        native := true;

      end;

      // 3.0.1
      if (bit_depth>1) and (not native) then  // 3.0.3
        png_set_tRNS_to_alpha(png_ptr);

      number_passes := png_set_interlace_handling(png_ptr);
      png_read_update_info(png_ptr, info_ptr);
      //
      ioparams.ImageCount := 1;
      ioparams.Width := width;
      ioparams.Height := height;
      ioparams.OriginalWidth := width;
      ioparams.OriginalHeight := height;
      ioparams.bitspersample := bit_depth;
      case color_type of
        PNG_COLOR_TYPE_GRAY: ioparams.samplesperpixel := 1;
        PNG_COLOR_TYPE_PALETTE: ioparams.samplesperpixel := 1;
        PNG_COLOR_TYPE_RGB: ioparams.samplesperpixel := 3;
        PNG_COLOR_TYPE_RGB_ALPHA: ioparams.samplesperpixel := 4;
        PNG_COLOR_TYPE_GRAY_ALPHA: ioparams.samplesperpixel := 2;
      end;
      ioparams.dpix := round(png_get_x_pixels_per_meter(png_ptr, info_ptr) / 100 * 2.54);
      if ioparams.dpix = 0 then
        ioparams.dpix := gDefaultDPIX;
      ioparams.dpiy := round(png_get_y_pixels_per_meter(png_ptr, info_ptr) / 100 * 2.54);
      if ioparams.dpiy = 0 then
        ioparams.dpiy := gDefaultDPIY;
      IOParams.FreeColorMap;
      if color_type = PNG_COLOR_TYPE_PALETTE then
      begin
        // copy palette
        png_get_PLTE(png_ptr, info_ptr, palette, num_palette);
        IOParams.FreeColorMap;
        IOParams.fColorMapCount := num_palette;
        getmem(IOParams.fColorMap, 3 * num_palette);
        for y := 0 to num_palette - 1 do
        begin
          IOParams.fColorMap^[y].r := palette^.red;
          IOParams.fColorMap^[y].g := palette^.green;
          IOParams.fColorMap^[y].b := palette^.blue;
          inc(palette);
        end;
      end;
      if png_get_interlace_type(png_ptr, info_ptr) = PNG_INTERLACE_NONE then
        ioparams.PNG_Interlaced := false
      else
        ioparams.PNG_Interlaced := true;
      //
      if Preview then
      begin
        png_destroy_read_struct(@png_ptr, @info_ptr, nil);
        exit;
      end;
      //
      if (bit_depth = 1) and not (color_type = PNG_COLOR_TYPE_PALETTE) then
        Bitmap.Allocate(Width, Height, ie1g)
      else if native and (IOParams.SamplesPerPixel = 1) then
      begin
        if (IOParams.BitsPerSample <= 8) and (color_type = PNG_COLOR_TYPE_PALETTE) then
        begin
          Bitmap.Allocate(Width, Height, ie8p);
          Bitmap.PaletteUsed := 1 shl IOParams.BitsPerSample;
          for i := 0 to IOParams.ColorMapCount - 1 do
            Bitmap.Palette[i] := IOParams.ColorMap[i]
        end
        else if (IOParams.BitsPerSample = 8) and (color_type = PNG_COLOR_TYPE_GRAY) then
          Bitmap.Allocate(Width, Height, ie8g)
        else if (IOParams.BitsPerSample = 16) and (color_type = PNG_COLOR_TYPE_GRAY) then
          Bitmap.Allocate(Width, Height, ie16g);
      end
      else
        Bitmap.Allocate(Width, Height, ie24RGB);
      //
      xProgress.per1 := 100 / (height * number_passes);
      xProgress.val := 0;
      channels := png_get_channels(png_ptr, info_ptr);
      if (channels = 4) and (number_passes=1) then
        getmem(arowbuf, width * 4)
      else if (channels=4) and (number_passes>1) then
        getmem(arowbuf, width*height*4)
      else
        arowbuf := nil;
      if (channels = 4) then
        bitmap.AlphaChannel.Full := false;
      for pass := 0 to number_passes - 1 do
      begin
        lper:=-1;
        for y := 0 to height - 1 do
        begin
          px := bitmap.scanline[y];
          if (channels = 4) then
          begin
            if number_passes>1 then
            begin
              apx := pointer(int64(DWORD(arowbuf))+y*width*4);
              png_read_rows(png_ptr, @apx, nil, 1);
            end
            else
            begin
              png_read_rows(png_ptr, @arowbuf, nil, 1);
              apx := arowbuf;
            end;
            apx2 := bitmap.AlphaChannel.ScanLine[y];
            for x := 0 to width - 1 do
            begin
              PRGB(px)^ := PRGB(apx)^;
              inc(apx, 3);
              apx2^ := apx^;
              inc(apx2);
              inc(apx);
              inc(pbyte(px), 3);
            end;
          end
          else if (bit_depth=1) and (color_type = PNG_COLOR_TYPE_PALETTE) and (bitmap.PixelFormat=ie24RGB) then
          begin
            // 1 bit depth with color map, convert to ie24RGB
            getmem(apx,width div 8 +1);
            png_read_rows(png_ptr, @apx, nil, 1);
            for x:=0 to width-1 do
            begin
              if _GetPixelbw(apx,x)=0 then
                PRGB(px)^:=IOParams.fColorMap^[0]
              else
                PRGB(px)^:=IOParams.fColorMap^[1];
              inc(PRGB(px));
            end;
            freemem(apx);
          end
          else
            png_read_rows(png_ptr, @px, nil, 1);
          // OnProgress
          with xProgress do
          begin
            inc(val);
            if assigned(fOnProgress) then
            begin
              per:=trunc(per1 * val);
              if per <> lper then
              fOnProgress(Sender, per);
              lper:=per;
            end;
          end;
          if xProgress.Aborting^ then
            break;
        end;
        if xProgress.Aborting^ then
          break;
      end;
      if channels = 4 then
        freemem(arowbuf);
      if not xProgress.Aborting^ then
        png_read_end(png_ptr, info_ptr);
    finally
      if png_ptr <> nil then
        png_destroy_read_struct(@png_ptr, @info_ptr, nil);
    end;
  except
    xProgress.Aborting^ := true;
  end;
{$WARNINGS ON}
end;

// return true it is a PNG stream

function IsPNGStream(Stream: TStream): boolean;
var
  buf: array[0..7] of byte;
begin
  Stream.read(buf, 8);
  result := png_sig_cmp(@(buf[0]), 0, 4) = 0;
  Stream.Seek(-8, soCurrent);
end;

{$else} // IEINCLUDEPNG

interface

implementation

{$endif}

end.
