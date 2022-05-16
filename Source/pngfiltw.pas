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
File version 1000
*)

unit pngfiltw;

{$R-}
{$Q-}

{$I ie.inc}

{$IFDEF IEINCLUDEPNG}

interface

uses Windows, Graphics, classes, sysutils, ImageEnProc, ImageEnIO, hyiedefs, hyieutils, iezlib;

procedure WritePNGStream(Stream: TStream; bitmap: TIEBitmap; var IOParams: TIOParamsVals; var xProgress: TProgressRec; AlphaChannel: TIEMask);

implementation

uses pngfilt, neurquant;

{$R-}

var
  __turboFloat: LongBool = False;

type
  TIOData = record
    Stream: TStream;
    Aborting: pboolean;
  end;
  PIOData = ^TIOData;

function memcmp(buf1, buf2: pbyte; count: integer): integer; cdecl;
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

function memmove(dest, source: Pointer; count: Integer): pointer; cdecl;
begin
  Move(source^, dest^, count);
  result := dest;
end;

function strlen(str: PAnsiChar): integer; cdecl;
begin
  result := Sysutils.strlen(str);
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


{$L pngset.obj}
{$L pngtrans.obj}
{$L pngmem.obj}
{$L pngerror.obj}

{$L pngwrite.obj}
{$L pngwio.obj}
{$L pngwtran.obj}
{$L pngwutil.obj}

{$L pngget.obj}
{$L png.obj}

procedure png_set_error_fn(png_ptr: png_structp; error_ptr: png_voidp;
  error_fn, warning_fn: png_error_ptr);
  cdecl; external;
function png_set_interlace_handling(png_ptr: png_structp): int;
  cdecl; external;
procedure png_chunk_warning(png_ptr: png_structp;
  const mess: png_charp);
  cdecl; external;
function png_create_write_struct(user_png_ver: png_charp;
  error_ptr: user_error_ptr; error_fn: png_error_ptr;
  warn_fn: png_error_ptr): png_structp;
  cdecl; external;
function png_create_info_struct(png_ptr: png_structp): png_infop;
  cdecl; external;
procedure png_destroy_write_struct(png_ptr_ptr: png_structpp;
  info_ptr_ptr: png_infopp);
  cdecl; external;
procedure png_set_IHDR(png_ptr: png_structp; info_ptr: png_infop;
  width, height: png_uint_32; bit_depth, color_type,
  interlace_type, compression_type, filter_type: int);
  cdecl; external;
procedure png_set_PLTE(png_ptr: png_structp; info_ptr: png_infop;
  palette: png_colorp; num_palette: int);
  cdecl; external;
procedure png_set_bKGD(png_ptr: png_structp; info_ptr: png_infop;
  background: png_color_16p);
  cdecl; external;
procedure png_set_tRNS(png_ptr: png_structp; info_ptr: png_infop;
  trans: png_bytep; num_trans: integer; trans_values: png_color_16p);
  cdecl; external;
procedure png_write_info(png_ptr: png_structp; info_ptr: png_infop);
  cdecl; external;
procedure png_set_bgr(png_ptr: png_structp);
  cdecl; external;
procedure png_set_write_fn(png_ptr: png_structp;
  io_ptr: png_voidp; write_data_fn: png_rw_ptr;
  output_flush_fn: png_flush_ptr);
  cdecl; external;
function png_get_io_ptr(png_ptr: png_structp): png_voidp;
  cdecl; external;
procedure png_write_rows(png_ptr: png_structp; row: png_bytepp;
  num_rows: png_uint_32);
  cdecl; external;
procedure png_write_end(png_ptr: png_structp; info_ptr: png_infop);
  cdecl; external;
procedure png_set_pHYs(png_ptr: png_structp; info_ptr: png_infop;
  res_x, res_y: png_uint_32; unit_type: int);
  cdecl; external;
procedure png_set_filter(png_ptr: png_structp; method, filters: int);
  cdecl; external;
procedure png_set_compression_level(png_ptr: png_structp; level: int);
  cdecl; external;
procedure png_set_sBIT(png_ptr: png_structp; info_ptr: png_infop;
  sig_bits: png_color_8p);
  cdecl; external;
procedure png_set_text(png_ptr: png_structp; info_ptr: png_infop;
  text_ptr: png_textp; num_text: int);
  cdecl; external;

(*
function png_get_bKGD(png_ptr: png_structp; info_ptr: png_infop;
             var background: png_color_16p): png_uint_32;
              cdecl; external;
*)

procedure PNG_MEMSET_CHECK; external;
procedure PNG_CREATE_STRUCT; external;
procedure PNG_DESTROY_STRUCT; external;
procedure png_warning; external;
procedure png_malloc; external;
procedure png_free; external;
procedure png_memcpy_check; external;
procedure PNG_DO_STRIP_FILLER; external;
procedure PNG_DO_PACKSWAP; external;
procedure PNG_DO_SWAP; external;
procedure PNG_DO_BGR; external;
procedure PNG_DO_INVERT; external;
procedure PNG_WRITE_DATA; external;
procedure png_create_struct_2; external;
procedure PNG_SET_MEM_FN; external;
procedure png_destroy_struct_2; external;
procedure PNG_SET_INVERT_ALPHA; external;
procedure PNG_SET_INVERT_MONO; external;
procedure PNG_SET_SHIFT; external;
procedure PNG_SET_PACKING; external;
procedure PNG_SET_SWAP_ALPHA; external;
procedure PNG_SET_FILLER; external;
procedure PNG_SET_SWAP; external;
procedure PNG_SET_PACKSWAP; external;
procedure PNG_WRITE_FLUSH; external;


procedure ErrorFunc(png_ptr: Pointer; msg: Pointer); cdecl;
begin
  raise EInvalidGraphic.create('Error on creating PNG');
end;

procedure WarnFunc(png_ptr: Pointer; msg: Pointer);  cdecl;
begin
end;

procedure WriteFunc(png_ptr: png_structp; data: Pointer; length: png_size_t); cdecl;
var
  iodata: PIOData;
begin
  iodata := png_get_io_ptr(png_ptr);
  if dword(iodata.Stream.Write(PAnsiChar(data)^, length)) < length then
    iodata.Aborting^ := true;
end;

procedure FlushFunc(png_ptr: png_structp); cdecl;
begin
end;

///////////////////////////////////////////////////////////////////////////////////////

procedure WritePNGStream(Stream: TStream; bitmap: TIEBitmap; var IOParams: TIOParamsVals; var xProgress: TProgressRec; AlphaChannel: TIEMask);
var
  png_ptr: png_structp;
  info_ptr: png_infop;
  Error_ptr: pointer;
  bit_depth, color_type, interlace_type: integer;
  WBitmap: TIEBitmap;
  BackCol, ForeCol: TRGB;
  FreeW: boolean; // se true liberare WBitmap
  qt: TIEQuantizer;
  palette: array[0..255] of TRGB;
  ppalette: PRGBROW;
  background: png_color_16;
  number_passes, pass, y, x, height, width: integer;
  px, ppx: pointer;
  pp: PRGB;
  brow: pbyte;
  pw: pword;
  nullpr: TProgressRec;
  bitmapwidth1: integer;
  iodata: TIOData;
  px2, px4: PRGBA;
  px_byte, px3: pbyte;
  bb: byte;
  bps: integer;
  hasalpha: boolean;
  px_word: pword;
  p8: png_color_8;
  i,altindex:integer;
  d,dt:double;
  tcl:TRGB;
  png_text_mem:png_textp;
  png_text_idx:png_textp;
  num_text:integer;
begin
  with nullpr do
  begin
    Aborting := xProgress.Aborting;
    fOnProgress := nil;
    Sender := nil;
  end;
  Error_ptr := nil;
  png_ptr := png_create_write_struct('1.2.14', Error_ptr, @ErrorFunc, @WarnFunc);
  if png_ptr = nil then
    raise EInvalidGraphic.create('Error on creating PNG');
  info_ptr := png_create_info_struct(png_ptr);
  if info_ptr = nil then
  begin
    png_destroy_write_struct(@png_ptr, nil);
    raise EInvalidGraphic.create('Error on creating PNG');
  end;
  iodata.Stream := Stream;
  iodata.Aborting := xProgress.Aborting;
  png_set_write_fn(png_ptr, @iodata, @WriteFunc, @FlushFunc);

  // Adjusts unsupported BitsPerSample and SamplesPerPixel
  if (IOParams.SamplesPerPixel=1) and (IOParams.BitsPerSample<>1) and (IOParams.BitsPerSample<>8) and (IOParams.BitsPerSample<>16) then
    IOParams.BitsPerSample:=8;  // 2.3.3

  // The bitmap to write will be contained in WBitmap
  FreeW := false;
  if (IOParams.BitsPerSample = 1) then
  begin
    // required to save to b/w
    if (Bitmap.PixelFormat = ie1g) then
      WBitmap := Bitmap
    else
    begin
      // convert to 1 bit
      WBitmap := _ConvertTo1bitEx(Bitmap, BackCol, ForeCol);
      if WBitmap = nil then
      begin
        // impossible to convert to 1 bit, convert to ordered dither
        WBitmap := TIEBitmap.Create;
        WBitmap.Assign(Bitmap);
        WBitmap.PixelFormat := ie1g;
      end;
      FreeW := true;
    end;
  end
  else
  begin
    // required to save in true color
    if Bitmap.pixelformat = ie1g then
    begin
      // convert to 24 bit
      WBitmap := TIEBitmap.Create;
      WBitmap.Assign(Bitmap);
      WBitmap.PixelFormat := ie24RGB;
      FreeW := true;
    end
    else
      WBitmap := Bitmap;
  end;
  // assign interlace_type
  if ioparams.PNG_Interlaced then
    interlace_type := PNG_INTERLACE_ADAM7
  else
    interlace_type := PNG_INTERLACE_NONE;
  // assign bit_depth and color_type
  if ioparams.SamplesPerPixel = 1 then
  begin
    // B/W or palette
    if wbitmap.pixelformat = ie1g then
    begin
      // B/W
      color_type := PNG_COLOR_TYPE_GRAY;
      bit_depth := 1;
    end
    else
    begin
      // palette
      color_type := PNG_COLOR_TYPE_PALETTE;
      bit_depth := ioparams.BitsPerSample;
    end;
  end
  else
  begin
    // true color
    color_type := PNG_COLOR_TYPE_RGB;
    bit_depth := 8;
  end;
  hasalpha := assigned(AlphaChannel) and (not AlphaChannel.Full);
  if hasalpha and (color_type = PNG_COLOR_TYPE_RGB) then
    color_type := color_type or PNG_COLOR_MASK_ALPHA;

  // Create palette if needed
  if (ioparams.SamplesPerPixel = 1) and (ioparams.BitsPerSample > 1) and (wbitmap.pixelformat <> ie1g) then
  begin
    if hasalpha then
    begin
      // save alpha channel as an entry in the color map (here 16 bit gray isn't supported)
      bit_depth := 8;
      bps := 1 shl ioparams.BitsPerSample;
      qt := TIEQuantizer.Create(wBitmap, palette, imin(bps, 255)); // entry 0 reserved for transparent layer
      getmem(ppalette, 256 * sizeof(TRGB));
      copymemory(@(ppalette[1]), @(palette[0]), 255 * sizeof(TRGB));
      with ppalette[0] do
      begin
        r := ioparams.PNG_Background.r;
        g := ioparams.PNG_Background.g;
        b := ioparams.PNG_Background.b;
      end;
      for x := 0 to 255 do
        bswap(ppalette^[x].r, ppalette^[x].b);
      png_set_PLTE(png_ptr, info_ptr, png_colorp(ppalette), imin(bps + 1, 256));
      if hasalpha then
      begin
        bb := 0;
        png_set_tRNS(png_ptr, info_ptr, @bb, 1, nil);
      end;
    end
    else
    begin
      // do not save alpha. Full gray and 16 bit gray supported
      qt := TIEQuantizer.Create(wBitmap, palette, 256);
      getmem(ppalette, 256 * sizeof(TRGB));
      copymemory(@(ppalette[0]), @(palette[0]), 256 * sizeof(TRGB));
      for x := 0 to 255 do
        bswap(ppalette^[x].r, ppalette^[x].b);
      if not qt.GrayScale then
        png_set_PLTE(png_ptr, info_ptr, png_colorp(ppalette), 256)
      else
        color_type := PNG_COLOR_TYPE_GRAY;
    end;
  end
  else
  begin
    qt := nil;
    ppalette := nil;
  end;
  png_set_IHDR(png_ptr, info_ptr, bitmap.width, bitmap.height, bit_depth, color_type,
    interlace_type, PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
  // DPI
  png_set_pHYs(png_ptr, info_ptr, round(ioparams.DPIX * 100 / 2.54), round(ioparams.DPIY * 100 / 2.54), PNG_RESOLUTION_METER);
  //
  case ioparams.PNG_Filter of
    ioPNG_FILTER_NONE: png_set_filter(png_ptr, 0, PNG_FILTER_NONE);
    ioPNG_FILTER_SUB: png_set_filter(png_ptr, 0, PNG_FILTER_SUB);
    ioPNG_FILTER_PAETH: png_set_filter(png_ptr, 0, PNG_FILTER_PAETH);
  end;
  // set background
  zeromemory(@background, sizeof(background));
  if assigned(qt) then
    background.index := qt.RGBIndex[ioparams.PNG_Background]
  else
  begin
    background.red := ioparams.PNG_Background.r *257;
    background.green := ioparams.PNG_Background.g *257;
    background.blue := ioparams.PNG_Background.b *257;
  end;
  png_set_bKGD(png_ptr, info_ptr, @background);
  //
  png_set_compression_level(png_ptr, ioparams.PNG_Compression);
  //
  png_set_bgr(png_ptr);

  // write text
  num_text:=imin(IOParams.PNG_TextKeys.Count, IOParams.PNG_TextValues.Count);
  getmem(png_text_mem, sizeof(tpng_text)*num_text);
  png_text_idx:=png_text_mem;
  for i:=0 to num_text-1 do
  begin
    png_text_idx^.compression:=-1;
    png_text_idx^.key  := IEStrDup(PAnsiChar(AnsiString(IOParams.PNG_TextKeys[i])));
    png_text_idx^.text := IEStrDup(PAnsiChar(AnsiString(IOParams.PNG_TextValues[i])));
    png_text_idx^.text_length:=length( IOParams.PNG_TextValues[i] );
    inc(png_text_idx);
  end;
  png_set_text(png_ptr,info_ptr, png_text_mem, num_text);

  png_write_info(png_ptr, info_ptr);
  // write rows
  number_passes := png_set_interlace_handling(png_ptr);
  height := wbitmap.height;
  width := wbitmap.width;
  xProgress.per1 := 100 / (height * number_passes);
  xProgress.val := 0;
  px2 := nil;
  if (color_type = PNG_COLOR_TYPE_PALETTE) or (color_type = PNG_COLOR_TYPE_GRAY) then
    getmem(px, wbitmap.width * imax(1, bit_depth div 8));
  if (color_type and PNG_COLOR_MASK_ALPHA) <> 0 then
    getmem(px2, wbitmap.width * sizeof(TRGBA));
  for pass := 0 to number_passes - 1 do
  begin
    for y := 0 to height - 1 do
    begin
      if (color_type and PNG_COLOR_MASK_PALETTE) <> 0 then
      begin
        // palette
        brow := px;
        pp := wbitmap.scanline[y];
        px_byte := pbyte(pp);
        bitmapwidth1 := wbitmap.width - 1;
        if assigned(AlphaChannel) and (not AlphaChannel.Full) then
        begin
          // alpha channel
          case wbitmap.PixelFormat of
            ie24RGB:
              begin
                px3 := alphachannel.scanline[y];
                for x := 0 to bitmapwidth1 do
                begin
                  if px3^ < 255 then
                    brow^ := 0
                  else
                    brow^ := qt.RGBIndex[pp^] + 1;
                  inc(brow);
                  inc(pp);
                  inc(px3);
                end;
              end;
            ie8p:
              begin
                // search an alternate color for indexes with transparent index
                d:=100000;
                tcl:=wbitmap.Palette[0];
                altindex:=0;
                for i:=1 to wbitmap.PaletteLength-1 do
                begin
                  with wbitmap.Palette[i] do
                  begin
                    dt := sqr(r-tcl.r)+sqr(g-tcl.g)+sqr(b-tcl.b);
                    if dt<d then
                    begin
                      d:=dt;
                      altindex:=i;
                    end;
                  end;
                end;

                for x := 0 to bitmapwidth1 do
                begin
                  brow^ := px_byte^;
                  if brow^=0 then
                    brow^:=altindex;
                  inc(brow);
                  inc(px_byte);
                end;
              end;
          end
        end
        else
        begin
          // simple palette
          case wbitmap.pixelformat of
            ie24RGB:
              for x := 0 to bitmapwidth1 do
              begin
                brow^ := qt.RGBIndex[pp^];
                inc(brow);
                inc(pp);
              end;
            ie8p:
              for x := 0 to bitmapwidth1 do
              begin
                brow^ := px_byte^;
                inc(brow);
                inc(px_byte);
              end;
          end;
        end;
        png_write_rows(png_ptr, @px, 1);
      end
      else if (color_type and PNG_COLOR_MASK_COLOR) <> 0 then
      begin
        // truecolor
        if (color_type and PNG_COLOR_MASK_ALPHA) <> 0 then
        begin
          // alpha channel
          pp := wbitmap.scanline[y];
          px3 := alphachannel.scanline[y];
          px4 := px2;
          for x := 0 to width - 1 do
          begin
            with px4^ do
            begin
              r := pp^.r;
              g := pp^.g;
              b := pp^.b;
              a := px3^;
            end;
            inc(pp);
            inc(px3);
            inc(px4);
          end;
          png_write_rows(png_ptr, @px2, 1);
        end
        else
        begin
          ppx := wbitmap.scanline[y];
          png_write_rows(png_ptr, @ppx, 1);
        end;
      end
      else if (color_type = PNG_COLOR_TYPE_GRAY) then
      begin
        // gray scale
        if bit_depth = 16 then
        begin
          case wbitmap.pixelformat of
            ie24RGB:
              begin
                pp := wbitmap.scanline[y];
                pw := px;
                for x := 0 to width - 1 do
                begin
                  pw^ := qt.RGBIndex[pp^];
                  inc(pw);
                  inc(pp);
                end;
              end;
            ie16g:
              begin
                px_word := wbitmap.scanline[y];
                pw := px;
                for x := 0 to width - 1 do
                begin
                  pw^ := px_word^ shr 8;
                  inc(pw);
                  inc(px_word);
                end;
              end;
          end;
          png_write_rows(png_ptr, @px, 1);
        end
        else if bit_depth = 8 then
        begin
          case wbitmap.pixelformat of
            ie24RGB:
              begin
                pp := wbitmap.scanline[y];
                brow := px;
                for x := 0 to width - 1 do
                begin
                  brow^ := qt.RGBIndex[pp^];
                  inc(brow);
                  inc(pp);
                end;
              end;
            ie8g:
              begin
                px_byte := wbitmap.scanline[y];
                brow := px;
                for x := 0 to width - 1 do
                begin
                  brow^ := px_byte^;
                  inc(brow);
                  inc(px_byte);
                end;
              end;
          end;
          png_write_rows(png_ptr, @px, 1);
        end
        else
        begin
          ppx := wbitmap.scanline[y];
          png_write_rows(png_ptr, @ppx, 1);
        end;
      end;
      // OnProgress
      with xProgress do
      begin
        inc(val);
        if assigned(fOnProgress) then
          fOnProgress(Sender, trunc(per1 * val));
      end;
      if xProgress.Aborting^ then
        break;
    end;
    if xProgress.Aborting^ then
      break;
  end;
  if (color_type and PNG_COLOR_MASK_ALPHA) <> 0 then
    freemem(px2);
  if (color_type = PNG_COLOR_TYPE_PALETTE) or (color_type = PNG_COLOR_TYPE_GRAY) then
    freemem(px);
  // end
  if not xProgress.Aborting^ then
    png_write_end(png_ptr, info_ptr);
  if ppalette <> nil then
    freemem(ppalette);
  png_destroy_write_struct(@png_ptr, @info_ptr);
  if FreeW then
    FreeAndNil(WBitmap);
  if assigned(qt) then
    FreeAndNil(qt);
  png_text_idx:=png_text_mem;
  for i:=0 to num_text-1 do
  begin
    freemem(png_text_idx^.key);
    freemem(png_text_idx^.text);
    inc(png_text_idx);
  end;
  freemem(png_text_mem);
end;

{$ELSE} // IEINCLUDEPNG

interface
implementation

{$ENDIF}

end.
