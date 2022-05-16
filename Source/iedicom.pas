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
File version 1010
*)

unit iedicom;

{$R-}
{$Q-}

{$I ie.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  hyieutils, jpegfilt, imageenio, hyiedefs, imageenproc, iej2000;

{$ifdef IEINCLUDEDICOM}
procedure IEDICOMRead(Stream:TStream; Params:TIOParamsVals; DstBitmap:TIEBitmap; var xProgress: TProgressRec; Preview: boolean);
function IEDICOMTryStream(Stream:TStream):boolean;
function IEDICOMImageCount(Stream:TStream):integer; overload;
function IEDICOMImageCount(FileName:string):integer; overload;
{$endif}

implementation

{$ifdef IEINCLUDEDICOM}

function DecodeJPEG(lStream: TStream; lOutSmallRA: PIESmallIntArray; lImgRAz: PByteArray; lCptSize: integer; OnProgress:TIEProgressEvent; Sender:TObject):boolean; forward;
function DecodeRLE(Stream:TStream; Buffer:pbyte; BufferLen:integer):integer; forward;


type TTagInfo = record
  Group:word;
  Element:word;
  vr:string[2];
end;

// code parts from ImageMagick - Copyright 1999-2007 ImageMagick Studio LLC
// This list must be sorted by Group and Element
const TagInfoSize = 2525;
const TagInfo : array [0..TagInfoSize-1] of TTagInfo =
  (
    (Group: $0; Element: $0; vr: 'UL' ),
    (Group: $0; Element: $1; vr: 'UL' ),
    (Group: $0; Element: $2; vr: 'UI' ),
    (Group: $0; Element: $3; vr: 'UI' ),
    (Group: $0; Element: $10; vr: 'LO' ),
    (Group: $0; Element: $100; vr: 'US' ),
    (Group: $0; Element: $110; vr: 'US' ),
    (Group: $0; Element: $120; vr: 'US' ),
    (Group: $0; Element: $200; vr: 'AE' ),
    (Group: $0; Element: $300; vr: 'AE' ),
    (Group: $0; Element: $400; vr: 'AE' ),
    (Group: $0; Element: $600; vr: 'AE' ),
    (Group: $0; Element: $700; vr: 'US' ),
    (Group: $0; Element: $800; vr: 'US' ),
    (Group: $0; Element: $850; vr: 'US' ),
    (Group: $0; Element: $860; vr: 'US' ),
    (Group: $0; Element: $900; vr: 'US' ),
    (Group: $0; Element: $901; vr: 'AT' ),
    (Group: $0; Element: $902; vr: 'LO' ),
    (Group: $0; Element: $903; vr: 'US' ),
    (Group: $0; Element: $1000; vr: 'UI' ),
    (Group: $0; Element: $1001; vr: 'UI' ),
    (Group: $0; Element: $1002; vr: 'US' ),
    (Group: $0; Element: $1005; vr: 'AT' ),
    (Group: $0; Element: $1008; vr: 'US' ),
    (Group: $0; Element: $1020; vr: 'US' ),
    (Group: $0; Element: $1021; vr: 'US' ),
    (Group: $0; Element: $1022; vr: 'US' ),
    (Group: $0; Element: $1023; vr: 'US' ),
    (Group: $0; Element: $1030; vr: 'AE' ),
    (Group: $0; Element: $1031; vr: 'US' ),
    (Group: $0; Element: $4000; vr: 'LO' ),
    (Group: $0; Element: $4010; vr: 'LO' ),
    (Group: $0; Element: $5010; vr: 'SH' ),
    (Group: $0; Element: $5020; vr: 'SH' ),
    (Group: $0; Element: $5110; vr: 'LO' ),
    (Group: $0; Element: $5120; vr: 'LO' ),
    (Group: $0; Element: $5130; vr: 'LO' ),
    (Group: $0; Element: $5140; vr: 'LO' ),
    (Group: $0; Element: $5150; vr: 'LO' ),
    (Group: $0; Element: $5160; vr: 'LO' ),
    (Group: $0; Element: $5170; vr: 'IS' ),
    (Group: $0; Element: $5180; vr: 'LO' ),
    (Group: $0; Element: $5190; vr: 'LO' ),
    (Group: $0; Element: $51a0; vr: 'LO' ),
    (Group: $0; Element: $51b0; vr: 'US' ),
    (Group: $2; Element: $0; vr: 'UL' ),
    (Group: $2; Element: $1; vr: 'OB' ),
    (Group: $2; Element: $2; vr: 'UI' ),
    (Group: $2; Element: $3; vr: 'UI' ),
    (Group: $2; Element: $10; vr: 'UI' ),
    (Group: $2; Element: $12; vr: 'UI' ),
    (Group: $2; Element: $13; vr: 'SH' ),
    (Group: $2; Element: $16; vr: 'AE' ),
    (Group: $2; Element: $100; vr: 'UI' ),
    (Group: $2; Element: $102; vr: 'OB' ),
    (Group: $3; Element: $0; vr: 'US' ),
    (Group: $3; Element: $8; vr: 'US' ),
    (Group: $3; Element: $11; vr: 'US' ),
    (Group: $3; Element: $12; vr: 'UL' ),
    (Group: $3; Element: $13; vr: 'DA' ),
    (Group: $3; Element: $14; vr: 'TM' ),
    (Group: $3; Element: $20; vr: 'US' ),
    (Group: $3; Element: $30; vr: 'DA' ),
    (Group: $3; Element: $31; vr: 'TM' ),
    (Group: $4; Element: $0; vr: 'UL' ),
    (Group: $4; Element: $1130; vr: 'CS' ),
    (Group: $4; Element: $1141; vr: 'CS' ),
    (Group: $4; Element: $1142; vr: 'CS' ),
    (Group: $4; Element: $1200; vr: 'UL' ),
    (Group: $4; Element: $1202; vr: 'UL' ),
    (Group: $4; Element: $1212; vr: 'US' ),
    (Group: $4; Element: $1220; vr: 'SQ' ),
    (Group: $4; Element: $1400; vr: 'UL' ),
    (Group: $4; Element: $1410; vr: 'US' ),
    (Group: $4; Element: $1420; vr: 'UL' ),
    (Group: $4; Element: $1430; vr: 'CS' ),
    (Group: $4; Element: $1432; vr: 'UI' ),
    (Group: $4; Element: $1500; vr: 'CS' ),
    (Group: $4; Element: $1504; vr: 'UL' ),
    (Group: $4; Element: $1510; vr: 'UI' ),
    (Group: $4; Element: $1511; vr: 'UI' ),
    (Group: $4; Element: $1512; vr: 'UI' ),
    (Group: $4; Element: $1600; vr: 'UL' ),
    (Group: $5; Element: $0; vr: 'US' ),
    (Group: $6; Element: $0; vr: 'US' ),
    (Group: $8; Element: $0; vr: 'UL' ),
    (Group: $8; Element: $1; vr: 'UL' ),
    (Group: $8; Element: $5; vr: 'CS' ),
    (Group: $8; Element: $8; vr: 'CS' ),
    (Group: $8; Element: $10; vr: 'LO' ),
    (Group: $8; Element: $12; vr: 'DA' ),
    (Group: $8; Element: $13; vr: 'TM' ),
    (Group: $8; Element: $14; vr: 'UI' ),
    (Group: $8; Element: $16; vr: 'UI' ),
    (Group: $8; Element: $18; vr: 'UI' ),
    (Group: $8; Element: $20; vr: 'DA' ),
    (Group: $8; Element: $21; vr: 'DA' ),
    (Group: $8; Element: $22; vr: 'DA' ),
    (Group: $8; Element: $23; vr: 'DA' ),
    (Group: $8; Element: $24; vr: 'DA' ),
    (Group: $8; Element: $25; vr: 'DA' ),
    (Group: $8; Element: $30; vr: 'TM' ),
    (Group: $8; Element: $31; vr: 'TM' ),
    (Group: $8; Element: $32; vr: 'TM' ),
    (Group: $8; Element: $33; vr: 'TM' ),
    (Group: $8; Element: $34; vr: 'TM' ),
    (Group: $8; Element: $35; vr: 'TM' ),
    (Group: $8; Element: $40; vr: 'xs' ),
    (Group: $8; Element: $41; vr: 'xs' ),
    (Group: $8; Element: $42; vr: 'CS' ),
    (Group: $8; Element: $50; vr: 'SH' ),
    (Group: $8; Element: $52; vr: 'CS' ),
    (Group: $8; Element: $54; vr: 'AE' ),
    (Group: $8; Element: $58; vr: 'UI' ),
    (Group: $8; Element: $60; vr: 'CS' ),
    (Group: $8; Element: $62; vr: 'SQ' ),
    (Group: $8; Element: $64; vr: 'CS' ),
    (Group: $8; Element: $68; vr: 'CS' ),
    (Group: $8; Element: $70; vr: 'LO' ),
    (Group: $8; Element: $80; vr: 'LO' ),
    (Group: $8; Element: $81; vr: 'ST' ),
    (Group: $8; Element: $82; vr: 'SQ' ),
    (Group: $8; Element: $90; vr: 'PN' ),
    (Group: $8; Element: $92; vr: 'ST' ),
    (Group: $8; Element: $94; vr: 'SH' ),
    (Group: $8; Element: $100; vr: 'SH' ),
    (Group: $8; Element: $102; vr: 'SH' ),
    (Group: $8; Element: $103; vr: 'SH' ),
    (Group: $8; Element: $104; vr: 'LO' ),
    (Group: $8; Element: $105; vr: 'CS' ),
    (Group: $8; Element: $106; vr: 'DT' ),
    (Group: $8; Element: $10b; vr: 'CS' ),
    (Group: $8; Element: $10c; vr: 'UI' ),
    (Group: $8; Element: $10d; vr: 'UI' ),
    (Group: $8; Element: $10f; vr: 'CS' ),
    (Group: $8; Element: $1000; vr: 'LT' ),
    (Group: $8; Element: $1010; vr: 'SH' ),
    (Group: $8; Element: $1030; vr: 'LO' ),
    (Group: $8; Element: $1032; vr: 'SQ' ),
    (Group: $8; Element: $103e; vr: 'LO' ),
    (Group: $8; Element: $1040; vr: 'LO' ),
    (Group: $8; Element: $1048; vr: 'PN' ),
    (Group: $8; Element: $1050; vr: 'PN' ),
    (Group: $8; Element: $1060; vr: 'PN' ),
    (Group: $8; Element: $1070; vr: 'PN' ),
    (Group: $8; Element: $1080; vr: 'LO' ),
    (Group: $8; Element: $1084; vr: 'SQ' ),
    (Group: $8; Element: $1090; vr: 'LO' ),
    (Group: $8; Element: $1100; vr: 'SQ' ),
    (Group: $8; Element: $1110; vr: 'SQ' ),
    (Group: $8; Element: $1111; vr: 'SQ' ),
    (Group: $8; Element: $1115; vr: 'SQ' ),
    (Group: $8; Element: $1120; vr: 'SQ' ),
    (Group: $8; Element: $1125; vr: 'SQ' ),
    (Group: $8; Element: $1130; vr: 'SQ' ),
    (Group: $8; Element: $1140; vr: 'SQ' ),
    (Group: $8; Element: $1145; vr: 'SQ' ),
    (Group: $8; Element: $1148; vr: 'SQ' ),
    (Group: $8; Element: $114a; vr: 'SQ' ),
    (Group: $8; Element: $114c; vr: 'SQ' ),
    (Group: $8; Element: $1150; vr: 'UI' ),
    (Group: $8; Element: $1155; vr: 'UI' ),
    (Group: $8; Element: $1160; vr: 'IS' ),
    (Group: $8; Element: $1195; vr: 'UI' ),
    (Group: $8; Element: $1197; vr: 'US' ),
    (Group: $8; Element: $1198; vr: 'SQ' ),
    (Group: $8; Element: $1199; vr: 'SQ' ),
    (Group: $8; Element: $2110; vr: 'CS' ),
    (Group: $8; Element: $2111; vr: 'ST' ),
    (Group: $8; Element: $2112; vr: 'SQ' ),
    (Group: $8; Element: $2120; vr: 'SH' ),
    (Group: $8; Element: $2122; vr: 'IS' ),
    (Group: $8; Element: $2124; vr: 'IS' ),
    (Group: $8; Element: $2128; vr: 'IS' ),
    (Group: $8; Element: $2129; vr: 'IS' ),
    (Group: $8; Element: $212a; vr: 'IS' ),
    (Group: $8; Element: $2130; vr: 'DS' ),
    (Group: $8; Element: $2132; vr: 'LO' ),
    (Group: $8; Element: $2142; vr: 'IS' ),
    (Group: $8; Element: $2143; vr: 'IS' ),
    (Group: $8; Element: $2144; vr: 'IS' ),
    (Group: $8; Element: $2200; vr: 'CS' ),
    (Group: $8; Element: $2204; vr: 'CS' ),
    (Group: $8; Element: $2208; vr: 'CS' ),
    (Group: $8; Element: $2218; vr: 'SQ' ),
    (Group: $8; Element: $2220; vr: 'SQ' ),
    (Group: $8; Element: $2228; vr: 'SQ' ),
    (Group: $8; Element: $2230; vr: 'SQ' ),
    (Group: $8; Element: $2240; vr: 'SQ' ),
    (Group: $8; Element: $2242; vr: 'SQ' ),
    (Group: $8; Element: $2244; vr: 'SQ' ),
    (Group: $8; Element: $2246; vr: 'SQ' ),
    (Group: $8; Element: $2251; vr: 'SQ' ),
    (Group: $8; Element: $2253; vr: 'SQ' ),
    (Group: $8; Element: $2255; vr: 'SQ' ),
    (Group: $8; Element: $2256; vr: 'ST' ),
    (Group: $8; Element: $2257; vr: 'SQ' ),
    (Group: $8; Element: $2258; vr: 'ST' ),
    (Group: $8; Element: $2259; vr: 'SQ' ),
    (Group: $8; Element: $225a; vr: 'SQ' ),
    (Group: $8; Element: $225c; vr: 'SQ' ),
    (Group: $8; Element: $4000; vr: 'LT' ),
    (Group: $9; Element: $0; vr: 'xs' ),
    (Group: $9; Element: $1; vr: 'xs' ),
    (Group: $9; Element: $2; vr: 'xs' ),
    (Group: $9; Element: $3; vr: 'xs' ),
    (Group: $9; Element: $4; vr: 'xs' ),
    (Group: $9; Element: $5; vr: 'UN' ),
    (Group: $9; Element: $6; vr: 'UN' ),
    (Group: $9; Element: $7; vr: 'UN' ),
    (Group: $9; Element: $8; vr: 'xs' ),
    (Group: $9; Element: $9; vr: 'LT' ),
    (Group: $9; Element: $a; vr: 'IS' ),
    (Group: $9; Element: $b; vr: 'IS' ),
    (Group: $9; Element: $c; vr: 'IS' ),
    (Group: $9; Element: $d; vr: 'IS' ),
    (Group: $9; Element: $e; vr: 'IS' ),
    (Group: $9; Element: $f; vr: 'UN' ),
    (Group: $9; Element: $10; vr: 'xs' ),
    (Group: $9; Element: $11; vr: 'xs' ),
    (Group: $9; Element: $12; vr: 'xs' ),
    (Group: $9; Element: $13; vr: 'xs' ),
    (Group: $9; Element: $14; vr: 'xs' ),
    (Group: $9; Element: $15; vr: 'xs' ),
    (Group: $9; Element: $16; vr: 'xs' ),
    (Group: $9; Element: $17; vr: 'LT' ),
    (Group: $9; Element: $18; vr: 'LT' ),
    (Group: $9; Element: $1a; vr: 'US' ),
    (Group: $9; Element: $1e; vr: 'UI' ),
    (Group: $9; Element: $20; vr: 'xs' ),
    (Group: $9; Element: $21; vr: 'xs' ),
    (Group: $9; Element: $22; vr: 'SH' ),
    (Group: $9; Element: $23; vr: 'SL' ),
    (Group: $9; Element: $24; vr: 'xs' ),
    (Group: $9; Element: $25; vr: 'xs' ),
    (Group: $9; Element: $26; vr: 'xs' ),
    (Group: $9; Element: $27; vr: 'xs' ),
    (Group: $9; Element: $29; vr: 'xs' ),
    (Group: $9; Element: $2a; vr: 'SL' ),
    (Group: $9; Element: $2c; vr: 'LO' ),
    (Group: $9; Element: $2d; vr: 'SL' ),
    (Group: $9; Element: $2e; vr: 'FD' ),
    (Group: $9; Element: $2f; vr: 'LT' ),
    (Group: $9; Element: $30; vr: 'xs' ),
    (Group: $9; Element: $31; vr: 'xs' ),
    (Group: $9; Element: $32; vr: 'LT' ),
    (Group: $9; Element: $34; vr: 'xs' ),
    (Group: $9; Element: $35; vr: 'SL' ),
    (Group: $9; Element: $37; vr: 'SL' ),
    (Group: $9; Element: $38; vr: 'xs' ),
    (Group: $9; Element: $39; vr: 'SL' ),
    (Group: $9; Element: $3a; vr: 'SL' ),
    (Group: $9; Element: $3e; vr: 'US' ),
    (Group: $9; Element: $3f; vr: 'US' ),
    (Group: $9; Element: $40; vr: 'xs' ),
    (Group: $9; Element: $41; vr: 'xs' ),
    (Group: $9; Element: $42; vr: 'xs' ),
    (Group: $9; Element: $43; vr: 'xs' ),
    (Group: $9; Element: $50; vr: 'LT' ),
    (Group: $9; Element: $51; vr: 'xs' ),
    (Group: $9; Element: $60; vr: 'LT' ),
    (Group: $9; Element: $61; vr: 'LT' ),
    (Group: $9; Element: $70; vr: 'LT' ),
    (Group: $9; Element: $80; vr: 'LT' ),
    (Group: $9; Element: $91; vr: 'LT' ),
    (Group: $9; Element: $e2; vr: 'LT' ),
    (Group: $9; Element: $e3; vr: 'UI' ),
    (Group: $9; Element: $e6; vr: 'SH' ),
    (Group: $9; Element: $e7; vr: 'UL' ),
    (Group: $9; Element: $e8; vr: 'UL' ),
    (Group: $9; Element: $e9; vr: 'SL' ),
    (Group: $9; Element: $f2; vr: 'UN' ),
    (Group: $9; Element: $f3; vr: 'UN' ),
    (Group: $9; Element: $f4; vr: 'LT' ),
    (Group: $9; Element: $f5; vr: 'xs' ),
    (Group: $9; Element: $f6; vr: 'LT' ),
    (Group: $9; Element: $f8; vr: 'US' ),
    (Group: $9; Element: $fb; vr: 'IS' ),
    (Group: $9; Element: $1002; vr: 'OB' ),
    (Group: $9; Element: $1003; vr: 'OB' ),
    (Group: $9; Element: $1010; vr: 'UN' ),
    (Group: $10; Element: $0; vr: 'UL' ),
    (Group: $10; Element: $10; vr: 'PN' ),
    (Group: $10; Element: $20; vr: 'LO' ),
    (Group: $10; Element: $21; vr: 'LO' ),
    (Group: $10; Element: $30; vr: 'DA' ),
    (Group: $10; Element: $32; vr: 'TM' ),
    (Group: $10; Element: $40; vr: 'CS' ),
    (Group: $10; Element: $50; vr: 'SQ' ),
    (Group: $10; Element: $1000; vr: 'LO' ),
    (Group: $10; Element: $1001; vr: 'PN' ),
    (Group: $10; Element: $1005; vr: 'PN' ),
    (Group: $10; Element: $1010; vr: 'AS' ),
    (Group: $10; Element: $1020; vr: 'DS' ),
    (Group: $10; Element: $1030; vr: 'DS' ),
    (Group: $10; Element: $1040; vr: 'LO' ),
    (Group: $10; Element: $1050; vr: 'LT' ),
    (Group: $10; Element: $1060; vr: 'PN' ),
    (Group: $10; Element: $1080; vr: 'LO' ),
    (Group: $10; Element: $1081; vr: 'LO' ),
    (Group: $10; Element: $1090; vr: 'LO' ),
    (Group: $10; Element: $2000; vr: 'LO' ),
    (Group: $10; Element: $2110; vr: 'LO' ),
    (Group: $10; Element: $2150; vr: 'LO' ),
    (Group: $10; Element: $2152; vr: 'LO' ),
    (Group: $10; Element: $2154; vr: 'SH' ),
    (Group: $10; Element: $2160; vr: 'SH' ),
    (Group: $10; Element: $2180; vr: 'SH' ),
    (Group: $10; Element: $21a0; vr: 'CS' ),
    (Group: $10; Element: $21b0; vr: 'LT' ),
    (Group: $10; Element: $21c0; vr: 'US' ),
    (Group: $10; Element: $21d0; vr: 'DA' ),
    (Group: $10; Element: $21f0; vr: 'LO' ),
    (Group: $10; Element: $4000; vr: 'LT' ),
    (Group: $11; Element: $1; vr: 'xs' ),
    (Group: $11; Element: $2; vr: 'US' ),
    (Group: $11; Element: $3; vr: 'LT' ),
    (Group: $11; Element: $4; vr: 'LT' ),
    (Group: $11; Element: $a; vr: 'xs' ),
    (Group: $11; Element: $b; vr: 'SL' ),
    (Group: $11; Element: $c; vr: 'SL' ),
    (Group: $11; Element: $d; vr: 'LO' ),
    (Group: $11; Element: $10; vr: 'xs' ),
    (Group: $11; Element: $11; vr: 'xs' ),
    (Group: $11; Element: $12; vr: 'LO' ),
    (Group: $11; Element: $13; vr: 'LO' ),
    (Group: $11; Element: $15; vr: 'xs' ),
    (Group: $11; Element: $16; vr: 'SL' ),
    (Group: $11; Element: $17; vr: 'SL' ),
    (Group: $11; Element: $18; vr: 'SL' ),
    (Group: $11; Element: $19; vr: 'FD' ),
    (Group: $11; Element: $1a; vr: 'SL' ),
    (Group: $11; Element: $1b; vr: 'SL' ),
    (Group: $11; Element: $1c; vr: 'SL' ),
    (Group: $11; Element: $1d; vr: 'SL' ),
    (Group: $11; Element: $1f; vr: 'SL' ),
    (Group: $11; Element: $20; vr: 'xs' ),
    (Group: $11; Element: $21; vr: 'xs' ),
    (Group: $11; Element: $22; vr: 'xs' ),
    (Group: $11; Element: $23; vr: 'xs' ),
    (Group: $11; Element: $24; vr: 'SL' ),
    (Group: $11; Element: $25; vr: 'xs' ),
    (Group: $11; Element: $26; vr: 'SL' ),
    (Group: $11; Element: $27; vr: 'SL' ),
    (Group: $11; Element: $28; vr: 'SL' ),
    (Group: $11; Element: $30; vr: 'xs' ),
    (Group: $11; Element: $31; vr: 'xs' ),
    (Group: $11; Element: $32; vr: 'UN' ),
    (Group: $11; Element: $33; vr: 'LO' ),
    (Group: $11; Element: $34; vr: 'LO' ),
    (Group: $11; Element: $35; vr: 'xs' ),
    (Group: $11; Element: $36; vr: 'LO' ),
    (Group: $11; Element: $37; vr: 'LO' ),
    (Group: $11; Element: $38; vr: 'SL' ),
    (Group: $11; Element: $3a; vr: 'SL' ),
    (Group: $11; Element: $3b; vr: 'FD' ),
    (Group: $11; Element: $3c; vr: 'FD' ),
    (Group: $11; Element: $3e; vr: 'SL' ),
    (Group: $11; Element: $3f; vr: 'SL' ),
    (Group: $11; Element: $40; vr: 'xs' ),
    (Group: $11; Element: $41; vr: 'LT' ),
    (Group: $11; Element: $42; vr: 'LT' ),
    (Group: $11; Element: $44; vr: 'FD' ),
    (Group: $11; Element: $45; vr: 'FD' ),
    (Group: $11; Element: $46; vr: 'SL' ),
    (Group: $11; Element: $55; vr: 'FD' ),
    (Group: $11; Element: $56; vr: 'FD' ),
    (Group: $11; Element: $a1; vr: 'DA' ),
    (Group: $11; Element: $a2; vr: 'TM' ),
    (Group: $11; Element: $b0; vr: 'LT' ),
    (Group: $11; Element: $b2; vr: 'LT' ),
    (Group: $11; Element: $b4; vr: 'LT' ),
    (Group: $11; Element: $bc; vr: 'TM' ),
    (Group: $11; Element: $c0; vr: 'LT' ),
    (Group: $11; Element: $d0; vr: 'LT' ),
    (Group: $11; Element: $d2; vr: 'LT' ),
    (Group: $13; Element: $0; vr: 'LT' ),
    (Group: $13; Element: $10; vr: 'xs' ),
    (Group: $13; Element: $11; vr: 'SL' ),
    (Group: $13; Element: $12; vr: 'xs' ),
    (Group: $13; Element: $16; vr: 'SL' ),
    (Group: $13; Element: $17; vr: 'SL' ),
    (Group: $13; Element: $18; vr: 'FD' ),
    (Group: $13; Element: $19; vr: 'FD' ),
    (Group: $13; Element: $1a; vr: 'FD' ),
    (Group: $13; Element: $1c; vr: 'FD' ),
    (Group: $13; Element: $1d; vr: 'FD' ),
    (Group: $13; Element: $1e; vr: 'FD' ),
    (Group: $13; Element: $20; vr: 'LT' ),
    (Group: $13; Element: $22; vr: 'LT' ),
    (Group: $13; Element: $26; vr: 'LT' ),
    (Group: $13; Element: $30; vr: 'DA' ),
    (Group: $13; Element: $31; vr: 'DS' ),
    (Group: $13; Element: $32; vr: 'LT' ),
    (Group: $13; Element: $33; vr: 'LT' ),
    (Group: $13; Element: $34; vr: 'LT' ),
    (Group: $13; Element: $35; vr: 'LT' ),
    (Group: $13; Element: $40; vr: 'LT' ),
    (Group: $13; Element: $42; vr: 'LT' ),
    (Group: $13; Element: $44; vr: 'LT' ),
    (Group: $13; Element: $46; vr: 'LT' ),
    (Group: $15; Element: $1; vr: 'DS' ),
    (Group: $15; Element: $2; vr: 'DS' ),
    (Group: $15; Element: $3; vr: 'DS' ),
    (Group: $18; Element: $0; vr: 'UL' ),
    (Group: $18; Element: $10; vr: 'LO' ),
    (Group: $18; Element: $12; vr: 'SQ' ),
    (Group: $18; Element: $14; vr: 'SQ' ),
    (Group: $18; Element: $15; vr: 'CS' ),
    (Group: $18; Element: $20; vr: 'CS' ),
    (Group: $18; Element: $21; vr: 'CS' ),
    (Group: $18; Element: $22; vr: 'CS' ),
    (Group: $18; Element: $23; vr: 'CS' ),
    (Group: $18; Element: $24; vr: 'SH' ),
    (Group: $18; Element: $25; vr: 'CS' ),
    (Group: $18; Element: $26; vr: 'SQ' ),
    (Group: $18; Element: $27; vr: 'TM' ),
    (Group: $18; Element: $28; vr: 'DS' ),
    (Group: $18; Element: $29; vr: 'SQ' ),
    (Group: $18; Element: $2a; vr: 'SQ' ),
    (Group: $18; Element: $30; vr: 'LO' ),
    (Group: $18; Element: $31; vr: 'LO' ),
    (Group: $18; Element: $32; vr: 'DS' ),
    (Group: $18; Element: $33; vr: 'DS' ),
    (Group: $18; Element: $34; vr: 'LO' ),
    (Group: $18; Element: $35; vr: 'TM' ),
    (Group: $18; Element: $36; vr: 'SQ' ),
    (Group: $18; Element: $37; vr: 'CS' ),
    (Group: $18; Element: $38; vr: 'CS' ),
    (Group: $18; Element: $39; vr: 'CS' ),
    (Group: $18; Element: $40; vr: 'IS' ),
    (Group: $18; Element: $50; vr: 'DS' ),
    (Group: $18; Element: $60; vr: 'DS' ),
    (Group: $18; Element: $70; vr: 'IS' ),
    (Group: $18; Element: $71; vr: 'CS' ),
    (Group: $18; Element: $72; vr: 'DS' ),
    (Group: $18; Element: $73; vr: 'CS' ),
    (Group: $18; Element: $74; vr: 'IS' ),
    (Group: $18; Element: $75; vr: 'IS' ),
    (Group: $18; Element: $80; vr: 'DS' ),
    (Group: $18; Element: $81; vr: 'DS' ),
    (Group: $18; Element: $82; vr: 'DS' ),
    (Group: $18; Element: $83; vr: 'DS' ),
    (Group: $18; Element: $84; vr: 'DS' ),
    (Group: $18; Element: $85; vr: 'SH' ),
    (Group: $18; Element: $86; vr: 'IS' ),
    (Group: $18; Element: $87; vr: 'DS' ),
    (Group: $18; Element: $88; vr: 'DS' ),
    (Group: $18; Element: $89; vr: 'IS' ),
    (Group: $18; Element: $90; vr: 'DS' ),
    (Group: $18; Element: $91; vr: 'IS' ),
    (Group: $18; Element: $93; vr: 'DS' ),
    (Group: $18; Element: $94; vr: 'DS' ),
    (Group: $18; Element: $95; vr: 'DS' ),
    (Group: $18; Element: $1000; vr: 'LO' ),
    (Group: $18; Element: $1004; vr: 'LO' ),
    (Group: $18; Element: $1010; vr: 'LO' ),
    (Group: $18; Element: $1012; vr: 'DA' ),
    (Group: $18; Element: $1014; vr: 'TM' ),
    (Group: $18; Element: $1016; vr: 'LO' ),
    (Group: $18; Element: $1018; vr: 'LO' ),
    (Group: $18; Element: $1019; vr: 'LO' ),
    (Group: $18; Element: $1020; vr: 'LO' ),
    (Group: $18; Element: $1022; vr: 'SH' ),
    (Group: $18; Element: $1023; vr: 'LO' ),
    (Group: $18; Element: $1030; vr: 'LO' ),
    (Group: $18; Element: $1040; vr: 'LO' ),
    (Group: $18; Element: $1041; vr: 'DS' ),
    (Group: $18; Element: $1042; vr: 'TM' ),
    (Group: $18; Element: $1043; vr: 'TM' ),
    (Group: $18; Element: $1044; vr: 'DS' ),
    (Group: $18; Element: $1045; vr: 'IS' ),
    (Group: $18; Element: $1046; vr: 'DS' ),
    (Group: $18; Element: $1047; vr: 'DS' ),
    (Group: $18; Element: $1048; vr: 'CS' ),
    (Group: $18; Element: $1049; vr: 'DS' ),
    (Group: $18; Element: $1050; vr: 'DS' ),
    (Group: $18; Element: $1060; vr: 'DS' ),
    (Group: $18; Element: $1061; vr: 'LO' ),
    (Group: $18; Element: $1062; vr: 'IS' ),
    (Group: $18; Element: $1063; vr: 'DS' ),
    (Group: $18; Element: $1064; vr: 'LO' ),
    (Group: $18; Element: $1065; vr: 'DS' ),
    (Group: $18; Element: $1066; vr: 'DS' ),
    (Group: $18; Element: $1067; vr: 'DS' ),
    (Group: $18; Element: $1068; vr: 'DS' ),
    (Group: $18; Element: $1069; vr: 'DS' ),
    (Group: $18; Element: $106a; vr: 'CS' ),
    (Group: $18; Element: $106b; vr: 'UI' ),
    (Group: $18; Element: $106e; vr: 'UL' ),
    (Group: $18; Element: $1070; vr: 'LO' ),
    (Group: $18; Element: $1071; vr: 'DS' ),
    (Group: $18; Element: $1072; vr: 'TM' ),
    (Group: $18; Element: $1073; vr: 'TM' ),
    (Group: $18; Element: $1074; vr: 'DS' ),
    (Group: $18; Element: $1075; vr: 'DS' ),
    (Group: $18; Element: $1076; vr: 'DS' ),
    (Group: $18; Element: $1077; vr: 'DS' ),
    (Group: $18; Element: $1080; vr: 'CS' ),
    (Group: $18; Element: $1081; vr: 'IS' ),
    (Group: $18; Element: $1082; vr: 'IS' ),
    (Group: $18; Element: $1083; vr: 'IS' ),
    (Group: $18; Element: $1084; vr: 'IS' ),
    (Group: $18; Element: $1085; vr: 'LO' ),
    (Group: $18; Element: $1086; vr: 'IS' ),
    (Group: $18; Element: $1088; vr: 'IS' ),
    (Group: $18; Element: $1090; vr: 'IS' ),
    (Group: $18; Element: $1094; vr: 'IS' ),
    (Group: $18; Element: $1100; vr: 'DS' ),
    (Group: $18; Element: $1110; vr: 'DS' ),
    (Group: $18; Element: $1111; vr: 'DS' ),
    (Group: $18; Element: $1114; vr: 'DS' ),
    (Group: $18; Element: $1120; vr: 'DS' ),
    (Group: $18; Element: $1121; vr: 'DS' ),
    (Group: $18; Element: $1130; vr: 'DS' ),
    (Group: $18; Element: $1131; vr: 'DS' ),
    (Group: $18; Element: $1134; vr: 'CS' ),
    (Group: $18; Element: $1135; vr: 'DS' ),
    (Group: $18; Element: $1136; vr: 'DS' ),
    (Group: $18; Element: $1137; vr: 'DS' ),
    (Group: $18; Element: $1138; vr: 'DS' ),
    (Group: $18; Element: $113a; vr: 'CS' ),
    (Group: $18; Element: $1140; vr: 'CS' ),
    (Group: $18; Element: $1141; vr: 'DS' ),
    (Group: $18; Element: $1142; vr: 'DS' ),
    (Group: $18; Element: $1143; vr: 'DS' ),
    (Group: $18; Element: $1144; vr: 'DS' ),
    (Group: $18; Element: $1145; vr: 'DS' ),
    (Group: $18; Element: $1146; vr: 'DS' ),
    (Group: $18; Element: $1147; vr: 'CS' ),
    (Group: $18; Element: $1149; vr: 'IS' ),
    (Group: $18; Element: $1150; vr: 'IS' ),
    (Group: $18; Element: $1151; vr: 'IS' ),
    (Group: $18; Element: $1152; vr: 'IS' ),
    (Group: $18; Element: $1153; vr: 'IS' ),
    (Group: $18; Element: $1154; vr: 'DS' ),
    (Group: $18; Element: $1155; vr: 'CS' ),
    (Group: $18; Element: $1156; vr: 'CS' ),
    (Group: $18; Element: $115a; vr: 'CS' ),
    (Group: $18; Element: $115e; vr: 'DS' ),
    (Group: $18; Element: $1160; vr: 'SH' ),
    (Group: $18; Element: $1161; vr: 'LO' ),
    (Group: $18; Element: $1162; vr: 'DS' ),
    (Group: $18; Element: $1164; vr: 'DS' ),
    (Group: $18; Element: $1166; vr: 'CS' ),
    (Group: $18; Element: $1170; vr: 'IS' ),
    (Group: $18; Element: $1180; vr: 'SH' ),
    (Group: $18; Element: $1181; vr: 'CS' ),
    (Group: $18; Element: $1182; vr: 'IS' ),
    (Group: $18; Element: $1183; vr: 'DS' ),
    (Group: $18; Element: $1184; vr: 'DS' ),
    (Group: $18; Element: $1190; vr: 'DS' ),
    (Group: $18; Element: $1191; vr: 'CS' ),
    (Group: $18; Element: $11a0; vr: 'DS' ),
    (Group: $18; Element: $11a2; vr: 'DS' ),
    (Group: $18; Element: $1200; vr: 'DA' ),
    (Group: $18; Element: $1201; vr: 'TM' ),
    (Group: $18; Element: $1210; vr: 'SH' ),
    (Group: $18; Element: $1240; vr: 'IS' ),
    (Group: $18; Element: $1242; vr: 'IS' ),
    (Group: $18; Element: $1243; vr: 'IS' ),
    (Group: $18; Element: $1244; vr: 'US' ),
    (Group: $18; Element: $1250; vr: 'SH' ),
    (Group: $18; Element: $1251; vr: 'SH' ),
    (Group: $18; Element: $1260; vr: 'SH' ),
    (Group: $18; Element: $1261; vr: 'LO' ),
    (Group: $18; Element: $1300; vr: 'DS' ),
    (Group: $18; Element: $1301; vr: 'CS' ),
    (Group: $18; Element: $1302; vr: 'IS' ),
    (Group: $18; Element: $1310; vr: 'US' ),
    (Group: $18; Element: $1312; vr: 'CS' ),
    (Group: $18; Element: $1314; vr: 'DS' ),
    (Group: $18; Element: $1315; vr: 'CS' ),
    (Group: $18; Element: $1316; vr: 'DS' ),
    (Group: $18; Element: $1318; vr: 'DS' ),
    (Group: $18; Element: $1400; vr: 'LO' ),
    (Group: $18; Element: $1401; vr: 'LO' ),
    (Group: $18; Element: $1402; vr: 'CS' ),
    (Group: $18; Element: $1403; vr: 'CS' ),
    (Group: $18; Element: $1404; vr: 'US' ),
    (Group: $18; Element: $1405; vr: 'IS' ),
    (Group: $18; Element: $1450; vr: 'DS' ),
    (Group: $18; Element: $1460; vr: 'DS' ),
    (Group: $18; Element: $1470; vr: 'DS' ),
    (Group: $18; Element: $1480; vr: 'DS' ),
    (Group: $18; Element: $1490; vr: 'CS' ),
    (Group: $18; Element: $1491; vr: 'CS' ),
    (Group: $18; Element: $1495; vr: 'IS' ),
    (Group: $18; Element: $1500; vr: 'CS' ),
    (Group: $18; Element: $1508; vr: 'CS' ),
    (Group: $18; Element: $1510; vr: 'DS' ),
    (Group: $18; Element: $1511; vr: 'DS' ),
    (Group: $18; Element: $1520; vr: 'DS' ),
    (Group: $18; Element: $1521; vr: 'DS' ),
    (Group: $18; Element: $1530; vr: 'DS' ),
    (Group: $18; Element: $1531; vr: 'DS' ),
    (Group: $18; Element: $1600; vr: 'CS' ),
    (Group: $18; Element: $1602; vr: 'IS' ),
    (Group: $18; Element: $1604; vr: 'IS' ),
    (Group: $18; Element: $1606; vr: 'IS' ),
    (Group: $18; Element: $1608; vr: 'IS' ),
    (Group: $18; Element: $1610; vr: 'IS' ),
    (Group: $18; Element: $1612; vr: 'IS' ),
    (Group: $18; Element: $1620; vr: 'IS' ),
    (Group: $18; Element: $1622; vr: 'US' ),
    (Group: $18; Element: $1623; vr: 'US' ),
    (Group: $18; Element: $1700; vr: 'CS' ),
    (Group: $18; Element: $1702; vr: 'IS' ),
    (Group: $18; Element: $1704; vr: 'IS' ),
    (Group: $18; Element: $1706; vr: 'IS' ),
    (Group: $18; Element: $1708; vr: 'IS' ),
    (Group: $18; Element: $1710; vr: 'IS' ),
    (Group: $18; Element: $1712; vr: 'IS' ),
    (Group: $18; Element: $1720; vr: 'IS' ),
    (Group: $18; Element: $1800; vr: 'CS' ),
    (Group: $18; Element: $1801; vr: 'SH' ),
    (Group: $18; Element: $1802; vr: 'CS' ),
    (Group: $18; Element: $4000; vr: 'LT' ),
    (Group: $18; Element: $5000; vr: 'SH' ),
    (Group: $18; Element: $5010; vr: 'LO' ),
    (Group: $18; Element: $5012; vr: 'DS' ),
    (Group: $18; Element: $5020; vr: 'LO' ),
    (Group: $18; Element: $5021; vr: 'LO' ),
    (Group: $18; Element: $5022; vr: 'DS' ),
    (Group: $18; Element: $5024; vr: 'DS' ),
    (Group: $18; Element: $5026; vr: 'DS' ),
    (Group: $18; Element: $5027; vr: 'DS' ),
    (Group: $18; Element: $5028; vr: 'DS' ),
    (Group: $18; Element: $5029; vr: 'DS' ),
    (Group: $18; Element: $5030; vr: 'DS' ),
    (Group: $18; Element: $5040; vr: 'DS' ),
    (Group: $18; Element: $5050; vr: 'IS' ),
    (Group: $18; Element: $5100; vr: 'CS' ),
    (Group: $18; Element: $5101; vr: 'CS' ),
    (Group: $18; Element: $5104; vr: 'SQ' ),
    (Group: $18; Element: $5210; vr: 'DS' ),
    (Group: $18; Element: $5212; vr: 'DS' ),
    (Group: $18; Element: $6000; vr: 'DS' ),
    (Group: $18; Element: $6011; vr: 'IS' ),
    (Group: $18; Element: $6012; vr: 'US' ),
    (Group: $18; Element: $6014; vr: 'US' ),
    (Group: $18; Element: $6016; vr: 'UL' ),
    (Group: $18; Element: $6018; vr: 'UL' ),
    (Group: $18; Element: $601a; vr: 'UL' ),
    (Group: $18; Element: $601c; vr: 'UL' ),
    (Group: $18; Element: $601e; vr: 'UL' ),
    (Group: $18; Element: $6020; vr: 'SL' ),
    (Group: $18; Element: $6022; vr: 'SL' ),
    (Group: $18; Element: $6024; vr: 'US' ),
    (Group: $18; Element: $6026; vr: 'US' ),
    (Group: $18; Element: $6028; vr: 'FD' ),
    (Group: $18; Element: $602a; vr: 'US' ),
    (Group: $18; Element: $602c; vr: 'US' ),
    (Group: $18; Element: $602e; vr: 'US' ),
    (Group: $18; Element: $6030; vr: 'UL' ),
    (Group: $18; Element: $6031; vr: 'CS' ),
    (Group: $18; Element: $6032; vr: 'UL' ),
    (Group: $18; Element: $6034; vr: 'FD' ),
    (Group: $18; Element: $6036; vr: 'FD' ),
    (Group: $18; Element: $6038; vr: 'UL' ),
    (Group: $18; Element: $603a; vr: 'UL' ),
    (Group: $18; Element: $603c; vr: 'UL' ),
    (Group: $18; Element: $603e; vr: 'UL' ),
    (Group: $18; Element: $6040; vr: 'UL' ),
    (Group: $18; Element: $6042; vr: 'UL' ),
    (Group: $18; Element: $6044; vr: 'US' ),
    (Group: $18; Element: $6046; vr: 'UL' ),
    (Group: $18; Element: $6048; vr: 'UL' ),
    (Group: $18; Element: $604a; vr: 'UL' ),
    (Group: $18; Element: $604c; vr: 'US' ),
    (Group: $18; Element: $604e; vr: 'US' ),
    (Group: $18; Element: $6050; vr: 'UL' ),
    (Group: $18; Element: $6052; vr: 'UL' ),
    (Group: $18; Element: $6054; vr: 'FD' ),
    (Group: $18; Element: $6056; vr: 'UL' ),
    (Group: $18; Element: $6058; vr: 'UL' ),
    (Group: $18; Element: $605a; vr: 'FL' ),
    (Group: $18; Element: $7000; vr: 'CS' ),
    (Group: $18; Element: $7001; vr: 'DS' ),
    (Group: $18; Element: $7004; vr: 'CS' ),
    (Group: $18; Element: $7005; vr: 'CS' ),
    (Group: $18; Element: $7006; vr: 'LT' ),
    (Group: $18; Element: $7008; vr: 'LT' ),
    (Group: $18; Element: $700a; vr: 'SH' ),
    (Group: $18; Element: $700c; vr: 'DA' ),
    (Group: $18; Element: $700e; vr: 'TM' ),
    (Group: $18; Element: $7010; vr: 'IS' ),
    (Group: $18; Element: $7011; vr: 'IS' ),
    (Group: $18; Element: $7012; vr: 'DS' ),
    (Group: $18; Element: $7014; vr: 'DS' ),
    (Group: $18; Element: $7016; vr: 'DS' ),
    (Group: $18; Element: $701a; vr: 'DS' ),
    (Group: $18; Element: $7020; vr: 'DS' ),
    (Group: $18; Element: $7022; vr: 'DS' ),
    (Group: $18; Element: $7024; vr: 'CS' ),
    (Group: $18; Element: $7026; vr: 'DS' ),
    (Group: $18; Element: $7028; vr: 'DS' ),
    (Group: $18; Element: $7030; vr: 'DS' ),
    (Group: $18; Element: $7032; vr: 'DS' ),
    (Group: $18; Element: $7034; vr: 'CS' ),
    (Group: $18; Element: $7040; vr: 'LT' ),
    (Group: $18; Element: $7041; vr: 'LT' ),
    (Group: $18; Element: $7042; vr: 'DS' ),
    (Group: $18; Element: $7044; vr: 'DS' ),
    (Group: $18; Element: $7046; vr: 'IS' ),
    (Group: $18; Element: $7048; vr: 'DS' ),
    (Group: $18; Element: $704c; vr: 'DS' ),
    (Group: $18; Element: $7050; vr: 'LT' ),
    (Group: $18; Element: $7052; vr: 'DS' ),
    (Group: $18; Element: $7054; vr: 'DS' ),
    (Group: $18; Element: $7060; vr: 'CS' ),
    (Group: $18; Element: $7062; vr: 'LT' ),
    (Group: $18; Element: $7064; vr: 'CS' ),
    (Group: $18; Element: $7065; vr: 'DS' ),
    (Group: $19; Element: $0; vr: 'xs' ),
    (Group: $19; Element: $1; vr: 'xs' ),
    (Group: $19; Element: $2; vr: 'xs' ),
    (Group: $19; Element: $3; vr: 'xs' ),
    (Group: $19; Element: $4; vr: 'xs' ),
    (Group: $19; Element: $5; vr: 'xs' ),
    (Group: $19; Element: $6; vr: 'xs' ),
    (Group: $19; Element: $7; vr: 'xs' ),
    (Group: $19; Element: $8; vr: 'xs' ),
    (Group: $19; Element: $9; vr: 'xs' ),
    (Group: $19; Element: $a; vr: 'xs' ),
    (Group: $19; Element: $b; vr: 'DS' ),
    (Group: $19; Element: $c; vr: 'US' ),
    (Group: $19; Element: $d; vr: 'TM' ),
    (Group: $19; Element: $e; vr: 'xs' ),
    (Group: $19; Element: $f; vr: 'DS' ),
    (Group: $19; Element: $10; vr: 'xs' ),
    (Group: $19; Element: $11; vr: 'xs' ),
    (Group: $19; Element: $12; vr: 'xs' ),
    (Group: $19; Element: $13; vr: 'xs' ),
    (Group: $19; Element: $14; vr: 'xs' ),
    (Group: $19; Element: $15; vr: 'xs' ),
    (Group: $19; Element: $16; vr: 'xs' ),
    (Group: $19; Element: $17; vr: 'xs' ),
    (Group: $19; Element: $18; vr: 'xs' ),
    (Group: $19; Element: $19; vr: 'xs' ),
    (Group: $19; Element: $1a; vr: 'xs' ),
    (Group: $19; Element: $1b; vr: 'xs' ),
    (Group: $19; Element: $1c; vr: 'CS' ),
    (Group: $19; Element: $1d; vr: 'IS' ),
    (Group: $19; Element: $1e; vr: 'xs' ),
    (Group: $19; Element: $1f; vr: 'DS' ),
    (Group: $19; Element: $20; vr: 'xs' ),
    (Group: $19; Element: $21; vr: 'xs' ),
    (Group: $19; Element: $22; vr: 'xs' ),
    (Group: $19; Element: $23; vr: 'xs' ),
    (Group: $19; Element: $24; vr: 'xs' ),
    (Group: $19; Element: $25; vr: 'xs' ),
    (Group: $19; Element: $26; vr: 'xs' ),
    (Group: $19; Element: $27; vr: 'xs' ),
    (Group: $19; Element: $28; vr: 'xs' ),
    (Group: $19; Element: $29; vr: 'IS' ),
    (Group: $19; Element: $2a; vr: 'xs' ),
    (Group: $19; Element: $2b; vr: 'DS' ),
    (Group: $19; Element: $2c; vr: 'xs' ),
    (Group: $19; Element: $2d; vr: 'US' ),
    (Group: $19; Element: $2e; vr: 'xs' ),
    (Group: $19; Element: $2f; vr: 'DS' ),
    (Group: $19; Element: $30; vr: 'xs' ),
    (Group: $19; Element: $31; vr: 'xs' ),
    (Group: $19; Element: $32; vr: 'xs' ),
    (Group: $19; Element: $33; vr: 'UN' ),
    (Group: $19; Element: $34; vr: 'US' ),
    (Group: $19; Element: $36; vr: 'US' ),
    (Group: $19; Element: $38; vr: 'US' ),
    (Group: $19; Element: $39; vr: 'xs' ),
    (Group: $19; Element: $3a; vr: 'xs' ),
    (Group: $19; Element: $3b; vr: 'LT' ),
    (Group: $19; Element: $3c; vr: 'xs' ),
    (Group: $19; Element: $3e; vr: 'xs' ),
    (Group: $19; Element: $3f; vr: 'UN' ),
    (Group: $19; Element: $40; vr: 'xs' ),
    (Group: $19; Element: $41; vr: 'xs' ),
    (Group: $19; Element: $42; vr: 'xs' ),
    (Group: $19; Element: $43; vr: 'xs' ),
    (Group: $19; Element: $44; vr: 'xs' ),
    (Group: $19; Element: $45; vr: 'xs' ),
    (Group: $19; Element: $46; vr: 'xs' ),
    (Group: $19; Element: $47; vr: 'xs' ),
    (Group: $19; Element: $48; vr: 'xs' ),
    (Group: $19; Element: $49; vr: 'US' ),
    (Group: $19; Element: $4a; vr: 'xs' ),
    (Group: $19; Element: $4b; vr: 'SL' ),
    (Group: $19; Element: $4c; vr: 'US' ),
    (Group: $19; Element: $4e; vr: 'US' ),
    (Group: $19; Element: $50; vr: 'xs' ),
    (Group: $19; Element: $51; vr: 'xs' ),
    (Group: $19; Element: $52; vr: 'xs' ),
    (Group: $19; Element: $53; vr: 'LT' ),
    (Group: $19; Element: $54; vr: 'xs' ),
    (Group: $19; Element: $55; vr: 'DS' ),
    (Group: $19; Element: $56; vr: 'xs' ),
    (Group: $19; Element: $57; vr: 'SS' ),
    (Group: $19; Element: $58; vr: 'xs' ),
    (Group: $19; Element: $5a; vr: 'xs' ),
    (Group: $19; Element: $5c; vr: 'xs' ),
    (Group: $19; Element: $5d; vr: 'US' ),
    (Group: $19; Element: $5e; vr: 'xs' ),
    (Group: $19; Element: $5f; vr: 'SL' ),
    (Group: $19; Element: $60; vr: 'xs' ),
    (Group: $19; Element: $61; vr: 'xs' ),
    (Group: $19; Element: $62; vr: 'xs' ),
    (Group: $19; Element: $63; vr: 'xs' ),
    (Group: $19; Element: $64; vr: 'xs' ),
    (Group: $19; Element: $65; vr: 'xs' ),
    (Group: $19; Element: $66; vr: 'xs' ),
    (Group: $19; Element: $67; vr: 'xs' ),
    (Group: $19; Element: $68; vr: 'xs' ),
    (Group: $19; Element: $69; vr: 'UL' ),
    (Group: $19; Element: $6a; vr: 'xs' ),
    (Group: $19; Element: $6b; vr: 'SS' ),
    (Group: $19; Element: $6c; vr: 'US' ),
    (Group: $19; Element: $6e; vr: 'US' ),
    (Group: $19; Element: $70; vr: 'xs' ),
    (Group: $19; Element: $71; vr: 'xs' ),
    (Group: $19; Element: $72; vr: 'xs' ),
    (Group: $19; Element: $73; vr: 'xs' ),
    (Group: $19; Element: $74; vr: 'xs' ),
    (Group: $19; Element: $75; vr: 'xs' ),
    (Group: $19; Element: $76; vr: 'xs' ),
    (Group: $19; Element: $77; vr: 'US' ),
    (Group: $19; Element: $78; vr: 'US' ),
    (Group: $19; Element: $7a; vr: 'US' ),
    (Group: $19; Element: $7c; vr: 'US' ),
    (Group: $19; Element: $7d; vr: 'DS' ),
    (Group: $19; Element: $7e; vr: 'xs' ),
    (Group: $19; Element: $7f; vr: 'DS' ),
    (Group: $19; Element: $80; vr: 'xs' ),
    (Group: $19; Element: $81; vr: 'xs' ),
    (Group: $19; Element: $82; vr: 'xs' ),
    (Group: $19; Element: $83; vr: 'xs' ),
    (Group: $19; Element: $84; vr: 'xs' ),
    (Group: $19; Element: $85; vr: 'xs' ),
    (Group: $19; Element: $86; vr: 'xs' ),
    (Group: $19; Element: $87; vr: 'xs' ),
    (Group: $19; Element: $88; vr: 'xs' ),
    (Group: $19; Element: $8a; vr: 'xs' ),
    (Group: $19; Element: $8b; vr: 'SS' ),
    (Group: $19; Element: $8c; vr: 'US' ),
    (Group: $19; Element: $8d; vr: 'DS' ),
    (Group: $19; Element: $8e; vr: 'US' ),
    (Group: $19; Element: $8f; vr: 'SS' ),
    (Group: $19; Element: $90; vr: 'xs' ),
    (Group: $19; Element: $91; vr: 'xs' ),
    (Group: $19; Element: $92; vr: 'xs' ),
    (Group: $19; Element: $93; vr: 'xs' ),
    (Group: $19; Element: $94; vr: 'xs' ),
    (Group: $19; Element: $95; vr: 'SS' ),
    (Group: $19; Element: $96; vr: 'xs' ),
    (Group: $19; Element: $97; vr: 'xs' ),
    (Group: $19; Element: $98; vr: 'xs' ),
    (Group: $19; Element: $99; vr: 'US' ),
    (Group: $19; Element: $9a; vr: 'US' ),
    (Group: $19; Element: $9b; vr: 'SS' ),
    (Group: $19; Element: $9c; vr: 'xs' ),
    (Group: $19; Element: $9d; vr: 'DT' ),
    (Group: $19; Element: $9e; vr: 'xs' ),
    (Group: $19; Element: $9f; vr: 'xs' ),
    (Group: $19; Element: $a0; vr: 'xs' ),
    (Group: $19; Element: $a1; vr: 'xs' ),
    (Group: $19; Element: $a2; vr: 'xs' ),
    (Group: $19; Element: $a3; vr: 'xs' ),
    (Group: $19; Element: $a4; vr: 'xs' ),
    (Group: $19; Element: $a5; vr: 'xs' ),
    (Group: $19; Element: $a6; vr: 'xs' ),
    (Group: $19; Element: $a7; vr: 'xs' ),
    (Group: $19; Element: $a8; vr: 'xs' ),
    (Group: $19; Element: $a9; vr: 'xs' ),
    (Group: $19; Element: $aa; vr: 'xs' ),
    (Group: $19; Element: $ab; vr: 'xs' ),
    (Group: $19; Element: $ac; vr: 'xs' ),
    (Group: $19; Element: $ad; vr: 'xs' ),
    (Group: $19; Element: $ae; vr: 'xs' ),
    (Group: $19; Element: $af; vr: 'xs' ),
    (Group: $19; Element: $b0; vr: 'xs' ),
    (Group: $19; Element: $b1; vr: 'xs' ),
    (Group: $19; Element: $b2; vr: 'xs' ),
    (Group: $19; Element: $b3; vr: 'xs' ),
    (Group: $19; Element: $b4; vr: 'xs' ),
    (Group: $19; Element: $b5; vr: 'xs' ),
    (Group: $19; Element: $b6; vr: 'DS' ),
    (Group: $19; Element: $b7; vr: 'DS' ),
    (Group: $19; Element: $b8; vr: 'DS' ),
    (Group: $19; Element: $b9; vr: 'DS' ),
    (Group: $19; Element: $ba; vr: 'DS' ),
    (Group: $19; Element: $bb; vr: 'DS' ),
    (Group: $19; Element: $bc; vr: 'DS' ),
    (Group: $19; Element: $bd; vr: 'DS' ),
    (Group: $19; Element: $be; vr: 'DS' ),
    (Group: $19; Element: $c0; vr: 'xs' ),
    (Group: $19; Element: $c1; vr: 'xs' ),
    (Group: $19; Element: $c2; vr: 'xs' ),
    (Group: $19; Element: $c3; vr: 'xs' ),
    (Group: $19; Element: $c4; vr: 'xs' ),
    (Group: $19; Element: $c5; vr: 'xs' ),
    (Group: $19; Element: $c6; vr: 'SS' ),
    (Group: $19; Element: $c7; vr: 'SS' ),
    (Group: $19; Element: $c8; vr: 'SS' ),
    (Group: $19; Element: $c9; vr: 'SS' ),
    (Group: $19; Element: $ca; vr: 'SS' ),
    (Group: $19; Element: $cb; vr: 'xs' ),
    (Group: $19; Element: $cc; vr: 'xs' ),
    (Group: $19; Element: $cd; vr: 'SS' ),
    (Group: $19; Element: $ce; vr: 'SS' ),
    (Group: $19; Element: $cf; vr: 'SS' ),
    (Group: $19; Element: $d0; vr: 'SH' ),
    (Group: $19; Element: $d1; vr: 'DS' ),
    (Group: $19; Element: $d2; vr: 'xs' ),
    (Group: $19; Element: $d3; vr: 'xs' ),
    (Group: $19; Element: $d4; vr: 'xs' ),
    (Group: $19; Element: $d5; vr: 'xs' ),
    (Group: $19; Element: $d6; vr: 'xs' ),
    (Group: $19; Element: $d7; vr: 'xs' ),
    (Group: $19; Element: $d8; vr: 'xs' ),
    (Group: $19; Element: $d9; vr: 'xs' ),
    (Group: $19; Element: $da; vr: 'xs' ),
    (Group: $19; Element: $db; vr: 'DS' ),
    (Group: $19; Element: $dc; vr: 'SS' ),
    (Group: $19; Element: $dd; vr: 'SS' ),
    (Group: $19; Element: $de; vr: 'DS' ),
    (Group: $19; Element: $df; vr: 'DS' ),
    (Group: $19; Element: $e0; vr: 'DS' ),
    (Group: $19; Element: $e1; vr: 'xs' ),
    (Group: $19; Element: $e2; vr: 'xs' ),
    (Group: $19; Element: $e3; vr: 'xs' ),
    (Group: $19; Element: $e4; vr: 'LT' ),
    (Group: $19; Element: $e5; vr: 'IS' ),
    (Group: $19; Element: $e6; vr: 'US' ),
    (Group: $19; Element: $e8; vr: 'DS' ),
    (Group: $19; Element: $e9; vr: 'DS' ),
    (Group: $19; Element: $eb; vr: 'DS' ),
    (Group: $19; Element: $ec; vr: 'US' ),
    (Group: $19; Element: $f0; vr: 'xs' ),
    (Group: $19; Element: $f1; vr: 'xs' ),
    (Group: $19; Element: $f2; vr: 'xs' ),
    (Group: $19; Element: $f3; vr: 'xs' ),
    (Group: $19; Element: $f4; vr: 'LT' ),
    (Group: $19; Element: $f9; vr: 'DS' ),
    (Group: $19; Element: $1015; vr: 'UN' ),
    (Group: $20; Element: $0; vr: 'UL' ),
    (Group: $20; Element: $d; vr: 'UI' ),
    (Group: $20; Element: $e; vr: 'UI' ),
    (Group: $20; Element: $10; vr: 'SH' ),
    (Group: $20; Element: $11; vr: 'IS' ),
    (Group: $20; Element: $12; vr: 'IS' ),
    (Group: $20; Element: $13; vr: 'IS' ),
    (Group: $20; Element: $14; vr: 'IS' ),
    (Group: $20; Element: $15; vr: 'IS' ),
    (Group: $20; Element: $16; vr: 'IS' ),
    (Group: $20; Element: $17; vr: 'IS' ),
    (Group: $20; Element: $18; vr: 'IS' ),
    (Group: $20; Element: $20; vr: 'CS' ),
    (Group: $20; Element: $22; vr: 'IS' ),
    (Group: $20; Element: $24; vr: 'IS' ),
    (Group: $20; Element: $26; vr: 'IS' ),
    (Group: $20; Element: $30; vr: 'DS' ),
    (Group: $20; Element: $32; vr: 'DS' ),
    (Group: $20; Element: $35; vr: 'DS' ),
    (Group: $20; Element: $37; vr: 'DS' ),
    (Group: $20; Element: $50; vr: 'DS' ),
    (Group: $20; Element: $52; vr: 'UI' ),
    (Group: $20; Element: $60; vr: 'CS' ),
    (Group: $20; Element: $62; vr: 'CS' ),
    (Group: $20; Element: $70; vr: 'LT' ),
    (Group: $20; Element: $80; vr: 'LO' ),
    (Group: $20; Element: $100; vr: 'IS' ),
    (Group: $20; Element: $105; vr: 'IS' ),
    (Group: $20; Element: $110; vr: 'DS' ),
    (Group: $20; Element: $1000; vr: 'IS' ),
    (Group: $20; Element: $1001; vr: 'DS' ),
    (Group: $20; Element: $1002; vr: 'IS' ),
    (Group: $20; Element: $1003; vr: 'IS' ),
    (Group: $20; Element: $1004; vr: 'IS' ),
    (Group: $20; Element: $1005; vr: 'IS' ),
    (Group: $20; Element: $1020; vr: 'LO' ),
    (Group: $20; Element: $1040; vr: 'LO' ),
    (Group: $20; Element: $1041; vr: 'DS' ),
    (Group: $20; Element: $1070; vr: 'IS' ),
    (Group: $20; Element: $1200; vr: 'IS' ),
    (Group: $20; Element: $1202; vr: 'IS' ),
    (Group: $20; Element: $1204; vr: 'IS' ),
    (Group: $20; Element: $1206; vr: 'IS' ),
    (Group: $20; Element: $1208; vr: 'IS' ),
    (Group: $20; Element: $3100; vr: 'LO' ),
    (Group: $20; Element: $3401; vr: 'LO' ),
    (Group: $20; Element: $3402; vr: 'LO' ),
    (Group: $20; Element: $3403; vr: 'xs' ),
    (Group: $20; Element: $3404; vr: 'LO' ),
    (Group: $20; Element: $3405; vr: 'xs' ),
    (Group: $20; Element: $3406; vr: 'xs' ),
    (Group: $20; Element: $4000; vr: 'LT' ),
    (Group: $20; Element: $5000; vr: 'AT' ),
    (Group: $20; Element: $5002; vr: 'LO' ),
    (Group: $21; Element: $0; vr: 'xs' ),
    (Group: $21; Element: $1; vr: 'xs' ),
    (Group: $21; Element: $2; vr: 'xs' ),
    (Group: $21; Element: $3; vr: 'xs' ),
    (Group: $21; Element: $4; vr: 'DS' ),
    (Group: $21; Element: $5; vr: 'xs' ),
    (Group: $21; Element: $6; vr: 'IS' ),
    (Group: $21; Element: $7; vr: 'xs' ),
    (Group: $21; Element: $8; vr: 'DS' ),
    (Group: $21; Element: $9; vr: 'DS' ),
    (Group: $21; Element: $10; vr: 'xs' ),
    (Group: $21; Element: $11; vr: 'xs' ),
    (Group: $21; Element: $12; vr: 'xs' ),
    (Group: $21; Element: $13; vr: 'xs' ),
    (Group: $21; Element: $14; vr: 'xs' ),
    (Group: $21; Element: $15; vr: 'xs' ),
    (Group: $21; Element: $16; vr: 'xs' ),
    (Group: $21; Element: $17; vr: 'DS' ),
    (Group: $21; Element: $18; vr: 'xs' ),
    (Group: $21; Element: $19; vr: 'xs' ),
    (Group: $21; Element: $20; vr: 'xs' ),
    (Group: $21; Element: $21; vr: 'xs' ),
    (Group: $21; Element: $22; vr: 'xs' ),
    (Group: $21; Element: $24; vr: 'xs' ),
    (Group: $21; Element: $25; vr: 'US' ),
    (Group: $21; Element: $26; vr: 'IS' ),
    (Group: $21; Element: $30; vr: 'xs' ),
    (Group: $21; Element: $31; vr: 'xs' ),
    (Group: $21; Element: $32; vr: 'xs' ),
    (Group: $21; Element: $34; vr: 'xs' ),
    (Group: $21; Element: $35; vr: 'SS' ),
    (Group: $21; Element: $36; vr: 'xs' ),
    (Group: $21; Element: $37; vr: 'SS' ),
    (Group: $21; Element: $39; vr: 'DS' ),
    (Group: $21; Element: $40; vr: 'xs' ),
    (Group: $21; Element: $41; vr: 'xs' ),
    (Group: $21; Element: $42; vr: 'xs' ),
    (Group: $21; Element: $43; vr: 'xs' ),
    (Group: $21; Element: $44; vr: 'xs' ),
    (Group: $21; Element: $45; vr: 'xs' ),
    (Group: $21; Element: $46; vr: 'xs' ),
    (Group: $21; Element: $47; vr: 'xs' ),
    (Group: $21; Element: $48; vr: 'xs' ),
    (Group: $21; Element: $49; vr: 'xs' ),
    (Group: $21; Element: $4a; vr: 'xs' ),
    (Group: $21; Element: $4e; vr: 'US' ),
    (Group: $21; Element: $4f; vr: 'xs' ),
    (Group: $21; Element: $50; vr: 'xs' ),
    (Group: $21; Element: $51; vr: 'xs' ),
    (Group: $21; Element: $52; vr: 'xs' ),
    (Group: $21; Element: $53; vr: 'xs' ),
    (Group: $21; Element: $54; vr: 'xs' ),
    (Group: $21; Element: $55; vr: 'xs' ),
    (Group: $21; Element: $56; vr: 'xs' ),
    (Group: $21; Element: $57; vr: 'xs' ),
    (Group: $21; Element: $58; vr: 'xs' ),
    (Group: $21; Element: $59; vr: 'xs' ),
    (Group: $21; Element: $5a; vr: 'SL' ),
    (Group: $21; Element: $5b; vr: 'DS' ),
    (Group: $21; Element: $5c; vr: 'DS' ),
    (Group: $21; Element: $5d; vr: 'DS' ),
    (Group: $21; Element: $5e; vr: 'DS' ),
    (Group: $21; Element: $5f; vr: 'DS' ),
    (Group: $21; Element: $60; vr: 'xs' ),
    (Group: $21; Element: $61; vr: 'DS' ),
    (Group: $21; Element: $62; vr: 'IS' ),
    (Group: $21; Element: $63; vr: 'DS' ),
    (Group: $21; Element: $65; vr: 'US' ),
    (Group: $21; Element: $6a; vr: 'DS' ),
    (Group: $21; Element: $6b; vr: 'DS' ),
    (Group: $21; Element: $70; vr: 'xs' ),
    (Group: $21; Element: $71; vr: 'xs' ),
    (Group: $21; Element: $72; vr: 'xs' ),
    (Group: $21; Element: $73; vr: 'DS' ),
    (Group: $21; Element: $75; vr: 'DS' ),
    (Group: $21; Element: $76; vr: 'DS' ),
    (Group: $21; Element: $7a; vr: 'IS' ),
    (Group: $21; Element: $7b; vr: 'IS' ),
    (Group: $21; Element: $7c; vr: 'IS' ),
    (Group: $21; Element: $80; vr: 'xs' ),
    (Group: $21; Element: $81; vr: 'DS' ),
    (Group: $21; Element: $82; vr: 'xs' ),
    (Group: $21; Element: $83; vr: 'DS' ),
    (Group: $21; Element: $84; vr: 'DS' ),
    (Group: $21; Element: $90; vr: 'xs' ),
    (Group: $21; Element: $91; vr: 'xs' ),
    (Group: $21; Element: $92; vr: 'xs' ),
    (Group: $21; Element: $93; vr: 'xs' ),
    (Group: $21; Element: $94; vr: 'DS' ),
    (Group: $21; Element: $95; vr: 'DS' ),
    (Group: $21; Element: $96; vr: 'DS' ),
    (Group: $21; Element: $a0; vr: 'xs' ),
    (Group: $21; Element: $a1; vr: 'DS' ),
    (Group: $21; Element: $a2; vr: 'xs' ),
    (Group: $21; Element: $a3; vr: 'LT' ),
    (Group: $21; Element: $a4; vr: 'LT' ),
    (Group: $21; Element: $a7; vr: 'LT' ),
    (Group: $21; Element: $b0; vr: 'IS' ),
    (Group: $21; Element: $c0; vr: 'IS' ),
    (Group: $23; Element: $0; vr: 'xs' ),
    (Group: $23; Element: $1; vr: 'SL' ),
    (Group: $23; Element: $2; vr: 'SL' ),
    (Group: $23; Element: $10; vr: 'xs' ),
    (Group: $23; Element: $20; vr: 'xs' ),
    (Group: $23; Element: $30; vr: 'xs' ),
    (Group: $23; Element: $40; vr: 'xs' ),
    (Group: $23; Element: $50; vr: 'xs' ),
    (Group: $23; Element: $60; vr: 'xs' ),
    (Group: $23; Element: $70; vr: 'xs' ),
    (Group: $23; Element: $74; vr: 'SL' ),
    (Group: $23; Element: $7d; vr: 'SS' ),
    (Group: $23; Element: $80; vr: 'xs' ),
    (Group: $23; Element: $90; vr: 'xs' ),
    (Group: $23; Element: $ff; vr: 'US' ),
    (Group: $25; Element: $0; vr: 'UL' ),
    (Group: $25; Element: $6; vr: 'SS' ),
    (Group: $25; Element: $7; vr: 'SL' ),
    (Group: $25; Element: $10; vr: 'SS' ),
    (Group: $25; Element: $11; vr: 'SS' ),
    (Group: $25; Element: $14; vr: 'SL' ),
    (Group: $25; Element: $17; vr: 'SL' ),
    (Group: $25; Element: $18; vr: 'SL' ),
    (Group: $25; Element: $19; vr: 'SL' ),
    (Group: $25; Element: $1a; vr: 'SH' ),
    (Group: $27; Element: $0; vr: 'US' ),
    (Group: $27; Element: $6; vr: 'SL' ),
    (Group: $27; Element: $10; vr: 'SS' ),
    (Group: $27; Element: $11; vr: 'UN' ),
    (Group: $27; Element: $12; vr: 'IS' ),
    (Group: $27; Element: $13; vr: 'IS' ),
    (Group: $27; Element: $14; vr: 'IS' ),
    (Group: $27; Element: $15; vr: 'IS' ),
    (Group: $27; Element: $16; vr: 'LT' ),
    (Group: $27; Element: $1c; vr: 'SL' ),
    (Group: $27; Element: $1d; vr: 'SS' ),
    (Group: $27; Element: $1e; vr: 'SL' ),
    (Group: $27; Element: $1f; vr: 'SL' ),
    (Group: $27; Element: $20; vr: 'SS' ),
    (Group: $27; Element: $30; vr: 'SH' ),
    (Group: $27; Element: $31; vr: 'SS' ),
    (Group: $27; Element: $32; vr: 'SS' ),
    (Group: $27; Element: $33; vr: 'SL' ),
    (Group: $27; Element: $35; vr: 'SS' ),
    (Group: $27; Element: $36; vr: 'SL' ),
    (Group: $27; Element: $40; vr: 'SH' ),
    (Group: $27; Element: $41; vr: 'FL' ),
    (Group: $27; Element: $42; vr: 'FL' ),
    (Group: $27; Element: $43; vr: 'FL' ),
    (Group: $27; Element: $44; vr: 'FL' ),
    (Group: $27; Element: $45; vr: 'FL' ),
    (Group: $27; Element: $46; vr: 'FL' ),
    (Group: $27; Element: $47; vr: 'FL' ),
    (Group: $27; Element: $48; vr: 'FL' ),
    (Group: $27; Element: $49; vr: 'FL' ),
    (Group: $27; Element: $4a; vr: 'FL' ),
    (Group: $27; Element: $4b; vr: 'FL' ),
    (Group: $27; Element: $4c; vr: 'FL' ),
    (Group: $27; Element: $4d; vr: 'FL' ),
    (Group: $27; Element: $50; vr: 'FL' ),
    (Group: $27; Element: $51; vr: 'FL' ),
    (Group: $27; Element: $52; vr: 'SH' ),
    (Group: $27; Element: $53; vr: 'SH' ),
    (Group: $27; Element: $54; vr: 'SH' ),
    (Group: $27; Element: $55; vr: 'SH' ),
    (Group: $27; Element: $60; vr: 'FL' ),
    (Group: $27; Element: $61; vr: 'FL' ),
    (Group: $27; Element: $62; vr: 'FL' ),
    (Group: $28; Element: $0; vr: 'UL' ),
    (Group: $28; Element: $2; vr: 'US' ),
    (Group: $28; Element: $4; vr: 'CS' ),
    (Group: $28; Element: $5; vr: 'US' ),
    (Group: $28; Element: $6; vr: 'US' ),
    (Group: $28; Element: $8; vr: 'IS' ),
    (Group: $28; Element: $9; vr: 'AT' ),
    (Group: $28; Element: $10; vr: 'US' ),
    (Group: $28; Element: $11; vr: 'US' ),
    (Group: $28; Element: $12; vr: 'US' ),
    (Group: $28; Element: $14; vr: 'US' ),
    (Group: $28; Element: $30; vr: 'DS' ),
    (Group: $28; Element: $31; vr: 'DS' ),
    (Group: $28; Element: $32; vr: 'DS' ),
    (Group: $28; Element: $34; vr: 'IS' ),
    (Group: $28; Element: $40; vr: 'LO' ),
    (Group: $28; Element: $50; vr: 'LT' ),
    (Group: $28; Element: $51; vr: 'CS' ),
    (Group: $28; Element: $5f; vr: 'LO' ),
    (Group: $28; Element: $60; vr: 'LO' ),
    (Group: $28; Element: $61; vr: 'SH' ),
    (Group: $28; Element: $62; vr: 'SH' ),
    (Group: $28; Element: $63; vr: 'SH' ),
    (Group: $28; Element: $65; vr: 'LO' ),
    (Group: $28; Element: $66; vr: 'AT' ),
    (Group: $28; Element: $68; vr: 'US' ),
    (Group: $28; Element: $69; vr: 'US' ),
    (Group: $28; Element: $70; vr: 'US' ),
    (Group: $28; Element: $71; vr: 'xs' ),
    (Group: $28; Element: $80; vr: 'US' ),
    (Group: $28; Element: $81; vr: 'US' ),
    (Group: $28; Element: $82; vr: 'US' ),
    (Group: $28; Element: $90; vr: 'LO' ),
    (Group: $28; Element: $91; vr: 'US' ),
    (Group: $28; Element: $92; vr: 'US' ),
    (Group: $28; Element: $93; vr: 'US' ),
    (Group: $28; Element: $94; vr: 'US' ),
    (Group: $28; Element: $100; vr: 'US' ),
    (Group: $28; Element: $101; vr: 'US' ),
    (Group: $28; Element: $102; vr: 'US' ),
    (Group: $28; Element: $103; vr: 'US' ),
    (Group: $28; Element: $104; vr: 'xs' ),
    (Group: $28; Element: $105; vr: 'xs' ),
    (Group: $28; Element: $106; vr: 'xs' ),
    (Group: $28; Element: $107; vr: 'xs' ),
    (Group: $28; Element: $108; vr: 'xs' ),
    (Group: $28; Element: $109; vr: 'xs' ),
    (Group: $28; Element: $110; vr: 'xs' ),
    (Group: $28; Element: $111; vr: 'xs' ),
    (Group: $28; Element: $120; vr: 'xs' ),
    (Group: $28; Element: $200; vr: 'xs' ),
    (Group: $28; Element: $300; vr: 'CS' ),
    (Group: $28; Element: $301; vr: 'CS' ),
    (Group: $28; Element: $400; vr: 'xs' ),
    (Group: $28; Element: $401; vr: 'xs' ),
    (Group: $28; Element: $402; vr: 'xs' ),
    (Group: $28; Element: $403; vr: 'xs' ),
    (Group: $28; Element: $404; vr: 'AT' ),
    (Group: $28; Element: $700; vr: 'LO' ),
    (Group: $28; Element: $701; vr: 'LO' ),
    (Group: $28; Element: $702; vr: 'AT' ),
    (Group: $28; Element: $710; vr: 'US' ),
    (Group: $28; Element: $720; vr: 'US' ),
    (Group: $28; Element: $721; vr: 'AT' ),
    (Group: $28; Element: $722; vr: 'US' ),
    (Group: $28; Element: $730; vr: 'US' ),
    (Group: $28; Element: $740; vr: 'US' ),
    (Group: $28; Element: $800; vr: 'LO' ),
    (Group: $28; Element: $802; vr: 'US' ),
    (Group: $28; Element: $803; vr: 'AT' ),
    (Group: $28; Element: $804; vr: 'US' ),
    (Group: $28; Element: $808; vr: 'AT' ),
    (Group: $28; Element: $1040; vr: 'CS' ),
    (Group: $28; Element: $1041; vr: 'SS' ),
    (Group: $28; Element: $1050; vr: 'DS' ),
    (Group: $28; Element: $1051; vr: 'DS' ),
    (Group: $28; Element: $1052; vr: 'DS' ),
    (Group: $28; Element: $1053; vr: 'DS' ),
    (Group: $28; Element: $1054; vr: 'LO' ),
    (Group: $28; Element: $1055; vr: 'LO' ),
    (Group: $28; Element: $1080; vr: 'LO' ),
    (Group: $28; Element: $1090; vr: 'CS' ),
    (Group: $28; Element: $1100; vr: 'xs' ),
    (Group: $28; Element: $1101; vr: 'xs' ),
    (Group: $28; Element: $1102; vr: 'xs' ),
    (Group: $28; Element: $1103; vr: 'xs' ),
    (Group: $28; Element: $1111; vr: 'OW' ),
    (Group: $28; Element: $1112; vr: 'OW' ),
    (Group: $28; Element: $1113; vr: 'OW' ),
    (Group: $28; Element: $1199; vr: 'UI' ),
    (Group: $28; Element: $1200; vr: 'xs' ),
    (Group: $28; Element: $1201; vr: 'OW' ),
    (Group: $28; Element: $1202; vr: 'OW' ),
    (Group: $28; Element: $1203; vr: 'OW' ),
    (Group: $28; Element: $1211; vr: 'OW' ),
    (Group: $28; Element: $1212; vr: 'OW' ),
    (Group: $28; Element: $1213; vr: 'OW' ),
    (Group: $28; Element: $1214; vr: 'UI' ),
    (Group: $28; Element: $1221; vr: 'OW' ),
    (Group: $28; Element: $1222; vr: 'OW' ),
    (Group: $28; Element: $1223; vr: 'OW' ),
    (Group: $28; Element: $1300; vr: 'CS' ),
    (Group: $28; Element: $2110; vr: 'CS' ),
    (Group: $28; Element: $2112; vr: 'DS' ),
    (Group: $28; Element: $3000; vr: 'SQ' ),
    (Group: $28; Element: $3002; vr: 'US' ),
    (Group: $28; Element: $3003; vr: 'LO' ),
    (Group: $28; Element: $3004; vr: 'LO' ),
    (Group: $28; Element: $3006; vr: 'US' ),
    (Group: $28; Element: $3010; vr: 'xs' ),
    (Group: $28; Element: $4000; vr: 'LT' ),
    (Group: $28; Element: $5000; vr: 'SQ' ),
    (Group: $28; Element: $6010; vr: 'US' ),
    (Group: $28; Element: $6020; vr: 'US' ),
    (Group: $28; Element: $6022; vr: 'LO' ),
    (Group: $28; Element: $6030; vr: 'US' ),
    (Group: $28; Element: $6040; vr: 'US' ),
    (Group: $28; Element: $6100; vr: 'SQ' ),
    (Group: $28; Element: $6101; vr: 'CS' ),
    (Group: $28; Element: $6102; vr: 'US' ),
    (Group: $28; Element: $6110; vr: 'US' ),
    (Group: $28; Element: $6112; vr: 'US' ),
    (Group: $28; Element: $6114; vr: 'FL' ),
    (Group: $28; Element: $6120; vr: 'SS' ),
    (Group: $28; Element: $6190; vr: 'ST' ),
    (Group: $29; Element: $0; vr: 'xs' ),
    (Group: $29; Element: $1; vr: 'xs' ),
    (Group: $29; Element: $2; vr: 'xs' ),
    (Group: $29; Element: $3; vr: 'xs' ),
    (Group: $29; Element: $4; vr: 'xs' ),
    (Group: $29; Element: $5; vr: 'xs' ),
    (Group: $29; Element: $6; vr: 'xs' ),
    (Group: $29; Element: $7; vr: 'SL' ),
    (Group: $29; Element: $8; vr: 'SH' ),
    (Group: $29; Element: $9; vr: 'SH' ),
    (Group: $29; Element: $a; vr: 'SS' ),
    (Group: $29; Element: $c; vr: 'xs' ),
    (Group: $29; Element: $e; vr: 'CS' ),
    (Group: $29; Element: $f; vr: 'CS' ),
    (Group: $29; Element: $10; vr: 'xs' ),
    (Group: $29; Element: $11; vr: 'xs' ),
    (Group: $29; Element: $13; vr: 'LT' ),
    (Group: $29; Element: $15; vr: 'xs' ),
    (Group: $29; Element: $16; vr: 'SL' ),
    (Group: $29; Element: $17; vr: 'SL' ),
    (Group: $29; Element: $18; vr: 'SL' ),
    (Group: $29; Element: $1a; vr: 'SL' ),
    (Group: $29; Element: $1e; vr: 'xs' ),
    (Group: $29; Element: $1f; vr: 'xs' ),
    (Group: $29; Element: $20; vr: 'xs' ),
    (Group: $29; Element: $22; vr: 'IS' ),
    (Group: $29; Element: $25; vr: 'LT' ),
    (Group: $29; Element: $26; vr: 'SS' ),
    (Group: $29; Element: $30; vr: 'xs' ),
    (Group: $29; Element: $31; vr: 'xs' ),
    (Group: $29; Element: $32; vr: 'xs' ),
    (Group: $29; Element: $33; vr: 'xs' ),
    (Group: $29; Element: $34; vr: 'xs' ),
    (Group: $29; Element: $35; vr: 'SL' ),
    (Group: $29; Element: $38; vr: 'US' ),
    (Group: $29; Element: $40; vr: 'xs' ),
    (Group: $29; Element: $41; vr: 'DS' ),
    (Group: $29; Element: $43; vr: 'DS' ),
    (Group: $29; Element: $44; vr: 'US' ),
    (Group: $29; Element: $4e; vr: 'CS' ),
    (Group: $29; Element: $4f; vr: 'CS' ),
    (Group: $29; Element: $50; vr: 'xs' ),
    (Group: $29; Element: $51; vr: 'LT' ),
    (Group: $29; Element: $52; vr: 'LT' ),
    (Group: $29; Element: $53; vr: 'LT' ),
    (Group: $29; Element: $60; vr: 'xs' ),
    (Group: $29; Element: $61; vr: 'xs' ),
    (Group: $29; Element: $67; vr: 'LT' ),
    (Group: $29; Element: $70; vr: 'xs' ),
    (Group: $29; Element: $71; vr: 'xs' ),
    (Group: $29; Element: $72; vr: 'xs' ),
    (Group: $29; Element: $77; vr: 'CS' ),
    (Group: $29; Element: $78; vr: 'LT' ),
    (Group: $29; Element: $79; vr: 'CS' ),
    (Group: $29; Element: $7e; vr: 'CS' ),
    (Group: $29; Element: $7f; vr: 'CS' ),
    (Group: $29; Element: $80; vr: 'xs' ),
    (Group: $29; Element: $81; vr: 'xs' ),
    (Group: $29; Element: $82; vr: 'IS' ),
    (Group: $29; Element: $83; vr: 'IS' ),
    (Group: $29; Element: $8e; vr: 'CS' ),
    (Group: $29; Element: $8f; vr: 'CS' ),
    (Group: $29; Element: $90; vr: 'IS' ),
    (Group: $29; Element: $99; vr: 'LT' ),
    (Group: $29; Element: $a0; vr: 'US' ),
    (Group: $29; Element: $a1; vr: 'US' ),
    (Group: $29; Element: $a2; vr: 'US' ),
    (Group: $29; Element: $b0; vr: 'US' ),
    (Group: $29; Element: $b2; vr: 'US' ),
    (Group: $29; Element: $c0; vr: 'LT' ),
    (Group: $29; Element: $c1; vr: 'xs' ),
    (Group: $29; Element: $c3; vr: 'IS' ),
    (Group: $29; Element: $c4; vr: 'IS' ),
    (Group: $29; Element: $c5; vr: 'LT' ),
    (Group: $29; Element: $ce; vr: 'CS' ),
    (Group: $29; Element: $cf; vr: 'CS' ),
    (Group: $29; Element: $d0; vr: 'IS' ),
    (Group: $29; Element: $d1; vr: 'IS' ),
    (Group: $29; Element: $d5; vr: 'LT' ),
    (Group: $31; Element: $10; vr: 'LT' ),
    (Group: $31; Element: $12; vr: 'LT' ),
    (Group: $31; Element: $30; vr: 'DA' ),
    (Group: $31; Element: $32; vr: 'TM' ),
    (Group: $31; Element: $33; vr: 'TM' ),
    (Group: $31; Element: $45; vr: 'LT' ),
    (Group: $31; Element: $4a; vr: 'TM' ),
    (Group: $31; Element: $50; vr: 'LT' ),
    (Group: $31; Element: $80; vr: 'LT' ),
    (Group: $32; Element: $0; vr: 'UL' ),
    (Group: $32; Element: $a; vr: 'CS' ),
    (Group: $32; Element: $c; vr: 'CS' ),
    (Group: $32; Element: $12; vr: 'LO' ),
    (Group: $32; Element: $32; vr: 'DA' ),
    (Group: $32; Element: $33; vr: 'TM' ),
    (Group: $32; Element: $34; vr: 'DA' ),
    (Group: $32; Element: $35; vr: 'TM' ),
    (Group: $32; Element: $1000; vr: 'DA' ),
    (Group: $32; Element: $1001; vr: 'TM' ),
    (Group: $32; Element: $1010; vr: 'DA' ),
    (Group: $32; Element: $1011; vr: 'TM' ),
    (Group: $32; Element: $1020; vr: 'LO' ),
    (Group: $32; Element: $1021; vr: 'AE' ),
    (Group: $32; Element: $1030; vr: 'LO' ),
    (Group: $32; Element: $1032; vr: 'PN' ),
    (Group: $32; Element: $1033; vr: 'LO' ),
    (Group: $32; Element: $1040; vr: 'DA' ),
    (Group: $32; Element: $1041; vr: 'TM' ),
    (Group: $32; Element: $1050; vr: 'DA' ),
    (Group: $32; Element: $1051; vr: 'TM' ),
    (Group: $32; Element: $1055; vr: 'CS' ),
    (Group: $32; Element: $1060; vr: 'LO' ),
    (Group: $32; Element: $1064; vr: 'SQ' ),
    (Group: $32; Element: $1070; vr: 'LO' ),
    (Group: $32; Element: $4000; vr: 'LT' ),
    (Group: $33; Element: $1; vr: 'UN' ),
    (Group: $33; Element: $2; vr: 'UN' ),
    (Group: $33; Element: $5; vr: 'UN' ),
    (Group: $33; Element: $6; vr: 'UN' ),
    (Group: $33; Element: $10; vr: 'LT' ),
    (Group: $37; Element: $10; vr: 'LO' ),
    (Group: $37; Element: $20; vr: 'US' ),
    (Group: $37; Element: $40; vr: 'SH' ),
    (Group: $37; Element: $42; vr: 'SH' ),
    (Group: $37; Element: $50; vr: 'CS' ),
    (Group: $37; Element: $60; vr: 'US' ),
    (Group: $38; Element: $0; vr: 'UL' ),
    (Group: $38; Element: $4; vr: 'SQ' ),
    (Group: $38; Element: $8; vr: 'CS' ),
    (Group: $38; Element: $10; vr: 'LO' ),
    (Group: $38; Element: $11; vr: 'LO' ),
    (Group: $38; Element: $16; vr: 'LO' ),
    (Group: $38; Element: $1a; vr: 'DA' ),
    (Group: $38; Element: $1b; vr: 'TM' ),
    (Group: $38; Element: $1c; vr: 'DA' ),
    (Group: $38; Element: $1d; vr: 'TM' ),
    (Group: $38; Element: $1e; vr: 'LO' ),
    (Group: $38; Element: $20; vr: 'DA' ),
    (Group: $38; Element: $21; vr: 'TM' ),
    (Group: $38; Element: $30; vr: 'DA' ),
    (Group: $38; Element: $32; vr: 'TM' ),
    (Group: $38; Element: $40; vr: 'LO' ),
    (Group: $38; Element: $44; vr: 'SQ' ),
    (Group: $38; Element: $50; vr: 'LO' ),
    (Group: $38; Element: $300; vr: 'LO' ),
    (Group: $38; Element: $400; vr: 'LO' ),
    (Group: $38; Element: $500; vr: 'LO' ),
    (Group: $38; Element: $4000; vr: 'LT' ),
    (Group: $39; Element: $80; vr: 'IS' ),
    (Group: $39; Element: $85; vr: 'DA' ),
    (Group: $39; Element: $90; vr: 'TM' ),
    (Group: $39; Element: $95; vr: 'LO' ),
    (Group: $39; Element: $aa; vr: 'CS' ),
    (Group: $3a; Element: $2; vr: 'SQ' ),
    (Group: $3a; Element: $5; vr: 'US' ),
    (Group: $3a; Element: $10; vr: 'UL' ),
    (Group: $3a; Element: $1a; vr: 'DS' ),
    (Group: $3a; Element: $20; vr: 'SH' ),
    (Group: $3a; Element: $103; vr: 'CS' ),
    (Group: $3a; Element: $122; vr: 'OB' ),
    (Group: $3a; Element: $200; vr: 'SQ' ),
    (Group: $3a; Element: $202; vr: 'IS' ),
    (Group: $3a; Element: $203; vr: 'SH' ),
    (Group: $3a; Element: $205; vr: 'CS' ),
    (Group: $3a; Element: $208; vr: 'SQ' ),
    (Group: $3a; Element: $209; vr: 'SQ' ),
    (Group: $3a; Element: $20a; vr: 'SQ' ),
    (Group: $3a; Element: $20b; vr: 'SQ' ),
    (Group: $3a; Element: $210; vr: 'DS' ),
    (Group: $3a; Element: $211; vr: 'SQ' ),
    (Group: $3a; Element: $212; vr: 'DS' ),
    (Group: $3a; Element: $213; vr: 'DS' ),
    (Group: $3a; Element: $214; vr: 'DS' ),
    (Group: $3a; Element: $215; vr: 'DS' ),
    (Group: $3a; Element: $216; vr: 'OB' ),
    (Group: $3a; Element: $217; vr: 'OB' ),
    (Group: $3a; Element: $218; vr: 'DS' ),
    (Group: $3a; Element: $21a; vr: 'US' ),
    (Group: $3a; Element: $220; vr: 'DS' ),
    (Group: $3a; Element: $221; vr: 'DS' ),
    (Group: $3a; Element: $222; vr: 'DS' ),
    (Group: $3a; Element: $223; vr: 'DS' ),
    (Group: $3a; Element: $1000; vr: 'OB' ),
    (Group: $40; Element: $1; vr: 'AE' ),
    (Group: $40; Element: $2; vr: 'DA' ),
    (Group: $40; Element: $3; vr: 'TM' ),
    (Group: $40; Element: $4; vr: 'DA' ),
    (Group: $40; Element: $5; vr: 'TM' ),
    (Group: $40; Element: $6; vr: 'PN' ),
    (Group: $40; Element: $7; vr: 'LO' ),
    (Group: $40; Element: $8; vr: 'SQ' ),
    (Group: $40; Element: $9; vr: 'SH' ),
    (Group: $40; Element: $10; vr: 'SH' ),
    (Group: $40; Element: $11; vr: 'SH' ),
    (Group: $40; Element: $12; vr: 'LO' ),
    (Group: $40; Element: $20; vr: 'CS' ),
    (Group: $40; Element: $100; vr: 'SQ' ),
    (Group: $40; Element: $302; vr: 'US' ),
    (Group: $40; Element: $303; vr: 'US' ),
    (Group: $40; Element: $306; vr: 'DS' ),
    (Group: $40; Element: $307; vr: 'DS' ),
    (Group: $40; Element: $310; vr: 'ST' ),
    (Group: $40; Element: $312; vr: 'DS' ),
    (Group: $40; Element: $314; vr: 'DS' ),
    (Group: $40; Element: $316; vr: 'DS' ),
    (Group: $40; Element: $318; vr: 'CS' ),
    (Group: $40; Element: $400; vr: 'LT' ),
    (Group: $40; Element: $50a; vr: 'LO' ),
    (Group: $40; Element: $550; vr: 'SQ' ),
    (Group: $40; Element: $551; vr: 'LO' ),
    (Group: $40; Element: $552; vr: 'SQ' ),
    (Group: $40; Element: $553; vr: 'ST' ),
    (Group: $40; Element: $555; vr: 'SQ' ),
    (Group: $40; Element: $556; vr: 'ST' ),
    (Group: $40; Element: $59a; vr: 'SQ' ),
    (Group: $40; Element: $6fa; vr: 'LO' ),
    (Group: $40; Element: $71a; vr: 'SQ' ),
    (Group: $40; Element: $72a; vr: 'DS' ),
    (Group: $40; Element: $73a; vr: 'DS' ),
    (Group: $40; Element: $74a; vr: 'DS' ),
    (Group: $40; Element: $8d8; vr: 'SQ' ),
    (Group: $40; Element: $8da; vr: 'SQ' ),
    (Group: $40; Element: $8ea; vr: 'SQ' ),
    (Group: $40; Element: $9f8; vr: 'SQ' ),
    (Group: $40; Element: $1001; vr: 'SH' ),
    (Group: $40; Element: $1002; vr: 'LO' ),
    (Group: $40; Element: $1003; vr: 'SH' ),
    (Group: $40; Element: $1004; vr: 'LO' ),
    (Group: $40; Element: $1005; vr: 'LO' ),
    (Group: $40; Element: $1006; vr: 'SH' ),
    (Group: $40; Element: $1007; vr: 'SH' ),
    (Group: $40; Element: $1008; vr: 'LO' ),
    (Group: $40; Element: $1009; vr: 'SH' ),
    (Group: $40; Element: $1010; vr: 'PN' ),
    (Group: $40; Element: $1400; vr: 'LT' ),
    (Group: $40; Element: $2001; vr: 'LO' ),
    (Group: $40; Element: $2004; vr: 'DA' ),
    (Group: $40; Element: $2005; vr: 'TM' ),
    (Group: $40; Element: $2006; vr: 'SH' ),
    (Group: $40; Element: $2007; vr: 'SH' ),
    (Group: $40; Element: $2008; vr: 'PN' ),
    (Group: $40; Element: $2009; vr: 'SH' ),
    (Group: $40; Element: $2010; vr: 'SH' ),
    (Group: $40; Element: $2400; vr: 'LT' ),
    (Group: $40; Element: $3001; vr: 'LO' ),
    (Group: $40; Element: $a007; vr: 'CS' ),
    (Group: $40; Element: $a020; vr: 'SQ' ),
    (Group: $40; Element: $a021; vr: 'UI' ),
    (Group: $40; Element: $a022; vr: 'UI' ),
    (Group: $40; Element: $a023; vr: 'DA' ),
    (Group: $40; Element: $a024; vr: 'TM' ),
    (Group: $40; Element: $a026; vr: 'SQ' ),
    (Group: $40; Element: $a027; vr: 'LO' ),
    (Group: $40; Element: $a028; vr: 'SQ' ),
    (Group: $40; Element: $a032; vr: 'LO' ),
    (Group: $40; Element: $a043; vr: 'SQ' ),
    (Group: $40; Element: $a047; vr: 'LO' ),
    (Group: $40; Element: $a057; vr: 'CS' ),
    (Group: $40; Element: $a060; vr: 'LO' ),
    (Group: $40; Element: $a066; vr: 'SQ' ),
    (Group: $40; Element: $a067; vr: 'PN' ),
    (Group: $40; Element: $a068; vr: 'SQ' ),
    (Group: $40; Element: $a070; vr: 'SQ' ),
    (Group: $40; Element: $a073; vr: 'LO' ),
    (Group: $40; Element: $a074; vr: 'OB' ),
    (Group: $40; Element: $a075; vr: 'PN' ),
    (Group: $40; Element: $a076; vr: 'SQ' ),
    (Group: $40; Element: $a078; vr: 'SQ' ),
    (Group: $40; Element: $a080; vr: 'SQ' ),
    (Group: $40; Element: $a085; vr: 'SQ' ),
    (Group: $40; Element: $a088; vr: 'LO' ),
    (Group: $40; Element: $a089; vr: 'OB' ),
    (Group: $40; Element: $a090; vr: 'CS' ),
    (Group: $40; Element: $a0a0; vr: 'CS' ),
    (Group: $40; Element: $a0b0; vr: 'US' ),
    (Group: $40; Element: $a110; vr: 'DA' ),
    (Group: $40; Element: $a112; vr: 'TM' ),
    (Group: $40; Element: $a121; vr: 'DA' ),
    (Group: $40; Element: $a122; vr: 'TM' ),
    (Group: $40; Element: $a123; vr: 'PN' ),
    (Group: $40; Element: $a124; vr: 'SQ' ),
    (Group: $40; Element: $a125; vr: 'CS' ),
    (Group: $40; Element: $a130; vr: 'CS' ),
    (Group: $40; Element: $a132; vr: 'UL' ),
    (Group: $40; Element: $a136; vr: 'US' ),
    (Group: $40; Element: $a138; vr: 'DS' ),
    (Group: $40; Element: $a13a; vr: 'DT' ),
    (Group: $40; Element: $a160; vr: 'UT' ),
    (Group: $40; Element: $a167; vr: 'SQ' ),
    (Group: $40; Element: $a168; vr: 'SQ' ),
    (Group: $40; Element: $a16a; vr: 'ST' ),
    (Group: $40; Element: $a170; vr: 'CS' ),
    (Group: $40; Element: $a171; vr: 'UI' ),
    (Group: $40; Element: $a172; vr: 'UI' ),
    (Group: $40; Element: $a173; vr: 'CS' ),
    (Group: $40; Element: $a174; vr: 'CS' ),
    (Group: $40; Element: $a180; vr: 'US' ),
    (Group: $40; Element: $a192; vr: 'DA' ),
    (Group: $40; Element: $a193; vr: 'TM' ),
    (Group: $40; Element: $a194; vr: 'CS' ),
    (Group: $40; Element: $a195; vr: 'SQ' ),
    (Group: $40; Element: $a224; vr: 'ST' ),
    (Group: $40; Element: $a290; vr: 'CS' ),
    (Group: $40; Element: $a296; vr: 'SQ' ),
    (Group: $40; Element: $a297; vr: 'ST' ),
    (Group: $40; Element: $a29a; vr: 'SL' ),
    (Group: $40; Element: $a300; vr: 'SQ' ),
    (Group: $40; Element: $a307; vr: 'PN' ),
    (Group: $40; Element: $a30a; vr: 'DS' ),
    (Group: $40; Element: $a313; vr: 'SQ' ),
    (Group: $40; Element: $a33a; vr: 'ST' ),
    (Group: $40; Element: $a340; vr: 'SQ' ),
    (Group: $40; Element: $a352; vr: 'PN' ),
    (Group: $40; Element: $a353; vr: 'ST' ),
    (Group: $40; Element: $a354; vr: 'LO' ),
    (Group: $40; Element: $a358; vr: 'SQ' ),
    (Group: $40; Element: $a380; vr: 'SQ' ),
    (Group: $40; Element: $a402; vr: 'UI' ),
    (Group: $40; Element: $a403; vr: 'CS' ),
    (Group: $40; Element: $a404; vr: 'SQ' ),
    (Group: $40; Element: $a600; vr: 'CS' ),
    (Group: $40; Element: $a601; vr: 'CS' ),
    (Group: $40; Element: $a603; vr: 'CS' ),
    (Group: $40; Element: $a730; vr: 'SQ' ),
    (Group: $40; Element: $a731; vr: 'SQ' ),
    (Group: $40; Element: $a732; vr: 'SQ' ),
    (Group: $40; Element: $a744; vr: 'SQ' ),
    (Group: $40; Element: $a992; vr: 'ST' ),
    (Group: $40; Element: $b020; vr: 'SQ' ),
    (Group: $40; Element: $db73; vr: 'SQ' ),
    (Group: $41; Element: $0; vr: 'LT' ),
    (Group: $41; Element: $10; vr: 'xs' ),
    (Group: $41; Element: $11; vr: 'xs' ),
    (Group: $41; Element: $12; vr: 'UL' ),
    (Group: $41; Element: $13; vr: 'SQ' ),
    (Group: $41; Element: $14; vr: 'SQ' ),
    (Group: $41; Element: $15; vr: 'US' ),
    (Group: $41; Element: $20; vr: 'xs' ),
    (Group: $41; Element: $21; vr: 'UI' ),
    (Group: $41; Element: $22; vr: 'UI' ),
    (Group: $41; Element: $30; vr: 'xs' ),
    (Group: $41; Element: $31; vr: 'xs' ),
    (Group: $41; Element: $32; vr: 'xs' ),
    (Group: $41; Element: $34; vr: 'DA' ),
    (Group: $41; Element: $36; vr: 'TM' ),
    (Group: $41; Element: $40; vr: 'LT' ),
    (Group: $41; Element: $41; vr: 'UI' ),
    (Group: $41; Element: $42; vr: 'UI' ),
    (Group: $41; Element: $50; vr: 'xs' ),
    (Group: $41; Element: $60; vr: 'UL' ),
    (Group: $41; Element: $62; vr: 'UL' ),
    (Group: $41; Element: $a0; vr: 'LT' ),
    (Group: $41; Element: $a1; vr: 'US' ),
    (Group: $41; Element: $a2; vr: 'LT' ),
    (Group: $41; Element: $a3; vr: 'UL' ),
    (Group: $41; Element: $b0; vr: 'LT' ),
    (Group: $41; Element: $b1; vr: 'US' ),
    (Group: $41; Element: $b2; vr: 'UL' ),
    (Group: $41; Element: $b3; vr: 'UL' ),
    (Group: $43; Element: $1; vr: 'SS' ),
    (Group: $43; Element: $2; vr: 'SS' ),
    (Group: $43; Element: $3; vr: 'SS' ),
    (Group: $43; Element: $4; vr: 'SS' ),
    (Group: $43; Element: $5; vr: 'SS' ),
    (Group: $43; Element: $6; vr: 'SS' ),
    (Group: $43; Element: $7; vr: 'SS' ),
    (Group: $43; Element: $8; vr: 'SS' ),
    (Group: $43; Element: $9; vr: 'SS' ),
    (Group: $43; Element: $a; vr: 'SS' ),
    (Group: $43; Element: $b; vr: 'DS' ),
    (Group: $43; Element: $c; vr: 'DS' ),
    (Group: $43; Element: $d; vr: 'DS' ),
    (Group: $43; Element: $e; vr: 'DS' ),
    (Group: $43; Element: $f; vr: 'DS' ),
    (Group: $43; Element: $10; vr: 'US' ),
    (Group: $43; Element: $11; vr: 'US' ),
    (Group: $43; Element: $12; vr: 'SS' ),
    (Group: $43; Element: $13; vr: 'SS' ),
    (Group: $43; Element: $14; vr: 'SS' ),
    (Group: $43; Element: $15; vr: 'SS' ),
    (Group: $43; Element: $16; vr: 'SS' ),
    (Group: $43; Element: $17; vr: 'DS' ),
    (Group: $43; Element: $18; vr: 'DS' ),
    (Group: $43; Element: $19; vr: 'SS' ),
    (Group: $43; Element: $1a; vr: 'SL' ),
    (Group: $43; Element: $1b; vr: 'SS' ),
    (Group: $43; Element: $1c; vr: 'SS' ),
    (Group: $43; Element: $1d; vr: 'SS' ),
    (Group: $43; Element: $1e; vr: 'xs' ),
    (Group: $43; Element: $1f; vr: 'SL' ),
    (Group: $43; Element: $20; vr: 'DS' ),
    (Group: $43; Element: $21; vr: 'SS' ),
    (Group: $43; Element: $25; vr: 'SS' ),
    (Group: $43; Element: $26; vr: 'US' ),
    (Group: $43; Element: $27; vr: 'xs' ),
    (Group: $43; Element: $28; vr: 'OB' ),
    (Group: $43; Element: $29; vr: 'OB' ),
    (Group: $43; Element: $2a; vr: 'OB' ),
    (Group: $43; Element: $2b; vr: 'SS' ),
    (Group: $43; Element: $2c; vr: 'SS' ),
    (Group: $43; Element: $2d; vr: 'SH' ),
    (Group: $43; Element: $2e; vr: 'SH' ),
    (Group: $43; Element: $2f; vr: 'SS' ),
    (Group: $43; Element: $30; vr: 'SS' ),
    (Group: $43; Element: $31; vr: 'DS' ),
    (Group: $43; Element: $32; vr: 'SS' ),
    (Group: $43; Element: $33; vr: 'FL' ),
    (Group: $43; Element: $34; vr: 'IS' ),
    (Group: $43; Element: $35; vr: 'UL' ),
    (Group: $43; Element: $36; vr: 'UL' ),
    (Group: $43; Element: $37; vr: 'UL' ),
    (Group: $43; Element: $38; vr: 'FL' ),
    (Group: $43; Element: $39; vr: 'IS' ),
    (Group: $43; Element: $40; vr: 'FL' ),
    (Group: $43; Element: $41; vr: 'FL' ),
    (Group: $43; Element: $42; vr: 'SL' ),
    (Group: $43; Element: $43; vr: 'SL' ),
    (Group: $43; Element: $44; vr: 'SL' ),
    (Group: $43; Element: $45; vr: 'SL' ),
    (Group: $43; Element: $46; vr: 'SL' ),
    (Group: $43; Element: $47; vr: 'SL' ),
    (Group: $43; Element: $48; vr: 'SL' ),
    (Group: $43; Element: $49; vr: 'SL' ),
    (Group: $43; Element: $4a; vr: 'SS' ),
    (Group: $43; Element: $4b; vr: 'SL' ),
    (Group: $43; Element: $4c; vr: 'SS' ),
    (Group: $43; Element: $4d; vr: 'FL' ),
    (Group: $43; Element: $4e; vr: 'FL' ),
    (Group: $44; Element: $0; vr: 'UI' ),
    (Group: $45; Element: $4; vr: 'CS' ),
    (Group: $45; Element: $6; vr: 'DS' ),
    (Group: $45; Element: $9; vr: 'DS' ),
    (Group: $45; Element: $b; vr: 'CS' ),
    (Group: $45; Element: $c; vr: 'DS' ),
    (Group: $45; Element: $d; vr: 'DS' ),
    (Group: $45; Element: $11; vr: 'DS' ),
    (Group: $45; Element: $12; vr: 'IS' ),
    (Group: $45; Element: $13; vr: 'ST' ),
    (Group: $45; Element: $14; vr: 'DS' ),
    (Group: $45; Element: $15; vr: 'IS' ),
    (Group: $45; Element: $16; vr: 'IS' ),
    (Group: $45; Element: $1b; vr: 'CS' ),
    (Group: $45; Element: $1d; vr: 'DS' ),
    (Group: $45; Element: $1e; vr: 'DS' ),
    (Group: $45; Element: $1f; vr: 'DS' ),
    (Group: $45; Element: $20; vr: 'DS' ),
    (Group: $45; Element: $21; vr: 'DS' ),
    (Group: $45; Element: $22; vr: 'DS' ),
    (Group: $45; Element: $23; vr: 'DS' ),
    (Group: $45; Element: $24; vr: 'DS' ),
    (Group: $45; Element: $25; vr: 'DS' ),
    (Group: $45; Element: $26; vr: 'OB' ),
    (Group: $45; Element: $27; vr: 'IS' ),
    (Group: $45; Element: $28; vr: 'CS' ),
    (Group: $45; Element: $29; vr: 'DS' ),
    (Group: $45; Element: $2a; vr: 'IS' ),
    (Group: $45; Element: $2b; vr: 'IS' ),
    (Group: $45; Element: $39; vr: 'US' ),
    (Group: $45; Element: $3a; vr: 'US' ),
    (Group: $45; Element: $3b; vr: 'US' ),
    (Group: $45; Element: $3c; vr: 'US' ),
    (Group: $45; Element: $3d; vr: 'US' ),
    (Group: $45; Element: $3e; vr: 'US' ),
    (Group: $45; Element: $3f; vr: 'OB' ),
    (Group: $47; Element: $1; vr: 'SQ' ),
    (Group: $47; Element: $50; vr: 'UL' ),
    (Group: $47; Element: $51; vr: 'UL' ),
    (Group: $47; Element: $53; vr: 'US' ),
    (Group: $47; Element: $54; vr: 'US' ),
    (Group: $47; Element: $55; vr: 'SL' ),
    (Group: $47; Element: $57; vr: 'DS' ),
    (Group: $47; Element: $58; vr: 'DS' ),
    (Group: $47; Element: $59; vr: 'US' ),
    (Group: $47; Element: $60; vr: 'DS' ),
    (Group: $47; Element: $61; vr: 'DS' ),
    (Group: $47; Element: $63; vr: 'SL' ),
    (Group: $47; Element: $64; vr: 'DS' ),
    (Group: $47; Element: $65; vr: 'DS' ),
    (Group: $47; Element: $70; vr: 'DS' ),
    (Group: $47; Element: $71; vr: 'IS' ),
    (Group: $47; Element: $72; vr: 'IS' ),
    (Group: $47; Element: $80; vr: 'LO' ),
    (Group: $47; Element: $85; vr: 'SQ' ),
    (Group: $47; Element: $89; vr: 'DS' ),
    (Group: $47; Element: $8a; vr: 'US' ),
    (Group: $47; Element: $8b; vr: 'US' ),
    (Group: $47; Element: $96; vr: 'IS' ),
    (Group: $47; Element: $91; vr: 'LO' ),
    (Group: $47; Element: $92; vr: 'CS' ),
    (Group: $47; Element: $93; vr: 'DA' ),
    (Group: $47; Element: $94; vr: 'TM' ),
    (Group: $47; Element: $95; vr: 'CS' ),
    (Group: $47; Element: $98; vr: 'US' ),
    (Group: $47; Element: $99; vr: 'SQ' ),
    (Group: $47; Element: $9a; vr: 'DS' ),
    (Group: $47; Element: $9b; vr: 'DS' ),
    (Group: $47; Element: $9c; vr: 'LO' ),
    (Group: $47; Element: $b1; vr: 'US' ),
    (Group: $47; Element: $b2; vr: 'US' ),
    (Group: $47; Element: $b0; vr: 'SQ' ),
    (Group: $47; Element: $b5; vr: 'LO' ),
    (Group: $47; Element: $b6; vr: 'LO' ),
    (Group: $47; Element: $b7; vr: 'LO' ),
    (Group: $47; Element: $b8; vr: 'SL' ),
    (Group: $47; Element: $b9; vr: 'SL' ),
    (Group: $47; Element: $ba; vr: 'SL' ),
    (Group: $47; Element: $bb; vr: 'SQ' ),
    (Group: $47; Element: $bc; vr: 'DS' ),
    (Group: $47; Element: $c0; vr: 'DS' ),
    (Group: $47; Element: $c1; vr: 'DS' ),
    (Group: $47; Element: $c2; vr: 'DS' ),
    (Group: $47; Element: $d1; vr: 'OB' ),
    (Group: $47; Element: $d2; vr: 'OB' ),
    (Group: $47; Element: $d3; vr: 'OB' ),
    (Group: $47; Element: $d4; vr: 'OB' ),
    (Group: $47; Element: $d5; vr: 'OB' ),
    (Group: $50; Element: $0; vr: 'UL' ),
    (Group: $50; Element: $4; vr: 'CS' ),
    (Group: $50; Element: $10; vr: 'SQ' ),
    (Group: $50; Element: $14; vr: 'DS' ),
    (Group: $50; Element: $16; vr: 'DS' ),
    (Group: $50; Element: $17; vr: 'CS' ),
    (Group: $50; Element: $18; vr: 'DS' ),
    (Group: $50; Element: $19; vr: 'DS' ),
    (Group: $50; Element: $20; vr: 'LO' ),
    (Group: $50; Element: $30; vr: 'SQ' ),
    (Group: $51; Element: $10; vr: 'xs' ),
    (Group: $54; Element: $0; vr: 'UL' ),
    (Group: $54; Element: $10; vr: 'US' ),
    (Group: $54; Element: $11; vr: 'US' ),
    (Group: $54; Element: $12; vr: 'SQ' ),
    (Group: $54; Element: $13; vr: 'SQ' ),
    (Group: $54; Element: $14; vr: 'DS' ),
    (Group: $54; Element: $15; vr: 'DS' ),
    (Group: $54; Element: $16; vr: 'SQ' ),
    (Group: $54; Element: $17; vr: 'IS' ),
    (Group: $54; Element: $18; vr: 'SH' ),
    (Group: $54; Element: $20; vr: 'US' ),
    (Group: $54; Element: $21; vr: 'US' ),
    (Group: $54; Element: $22; vr: 'SQ' ),
    (Group: $54; Element: $30; vr: 'US' ),
    (Group: $54; Element: $31; vr: 'US' ),
    (Group: $54; Element: $32; vr: 'SQ' ),
    (Group: $54; Element: $33; vr: 'US' ),
    (Group: $54; Element: $36; vr: 'IS' ),
    (Group: $54; Element: $38; vr: 'IS' ),
    (Group: $54; Element: $50; vr: 'US' ),
    (Group: $54; Element: $51; vr: 'US' ),
    (Group: $54; Element: $52; vr: 'SQ' ),
    (Group: $54; Element: $53; vr: 'US' ),
    (Group: $54; Element: $60; vr: 'US' ),
    (Group: $54; Element: $61; vr: 'US' ),
    (Group: $54; Element: $62; vr: 'SQ' ),
    (Group: $54; Element: $63; vr: 'SQ' ),
    (Group: $54; Element: $70; vr: 'US' ),
    (Group: $54; Element: $71; vr: 'US' ),
    (Group: $54; Element: $72; vr: 'SQ' ),
    (Group: $54; Element: $73; vr: 'DS' ),
    (Group: $54; Element: $80; vr: 'US' ),
    (Group: $54; Element: $81; vr: 'US' ),
    (Group: $54; Element: $90; vr: 'US' ),
    (Group: $54; Element: $100; vr: 'US' ),
    (Group: $54; Element: $101; vr: 'US' ),
    (Group: $54; Element: $200; vr: 'DS' ),
    (Group: $54; Element: $202; vr: 'CS' ),
    (Group: $54; Element: $210; vr: 'IS' ),
    (Group: $54; Element: $211; vr: 'US' ),
    (Group: $54; Element: $220; vr: 'SQ' ),
    (Group: $54; Element: $222; vr: 'SQ' ),
    (Group: $54; Element: $300; vr: 'SQ' ),
    (Group: $54; Element: $302; vr: 'SQ' ),
    (Group: $54; Element: $304; vr: 'SQ' ),
    (Group: $54; Element: $306; vr: 'SQ' ),
    (Group: $54; Element: $308; vr: 'US' ),
    (Group: $54; Element: $400; vr: 'SH' ),
    (Group: $54; Element: $410; vr: 'SQ' ),
    (Group: $54; Element: $412; vr: 'SQ' ),
    (Group: $54; Element: $414; vr: 'SQ' ),
    (Group: $54; Element: $1000; vr: 'CS' ),
    (Group: $54; Element: $1001; vr: 'CS' ),
    (Group: $54; Element: $1002; vr: 'CS' ),
    (Group: $54; Element: $1004; vr: 'CS' ),
    (Group: $54; Element: $1100; vr: 'CS' ),
    (Group: $54; Element: $1101; vr: 'LO' ),
    (Group: $54; Element: $1102; vr: 'CS' ),
    (Group: $54; Element: $1103; vr: 'LO' ),
    (Group: $54; Element: $1104; vr: 'LO' ),
    (Group: $54; Element: $1105; vr: 'LO' ),
    (Group: $54; Element: $1200; vr: 'DS' ),
    (Group: $54; Element: $1201; vr: 'IS' ),
    (Group: $54; Element: $1202; vr: 'IS' ),
    (Group: $54; Element: $1203; vr: 'DS' ),
    (Group: $54; Element: $1210; vr: 'DS' ),
    (Group: $54; Element: $1220; vr: 'CS' ),
    (Group: $54; Element: $1300; vr: 'DS' ),
    (Group: $54; Element: $1310; vr: 'IS' ),
    (Group: $54; Element: $1311; vr: 'IS' ),
    (Group: $54; Element: $1320; vr: 'DS' ),
    (Group: $54; Element: $1321; vr: 'DS' ),
    (Group: $54; Element: $1322; vr: 'DS' ),
    (Group: $54; Element: $1323; vr: 'DS' ),
    (Group: $54; Element: $1324; vr: 'DS' ),
    (Group: $54; Element: $1330; vr: 'US' ),
    (Group: $54; Element: $1400; vr: 'CS' ),
    (Group: $54; Element: $1401; vr: 'CS' ),
    (Group: $55; Element: $46; vr: 'LT' ),
    (Group: $58; Element: $0; vr: 'SQ' ),
    (Group: $60; Element: $3000; vr: 'SQ' ),
    (Group: $60; Element: $3002; vr: 'US' ),
    (Group: $60; Element: $3004; vr: 'xs' ),
    (Group: $60; Element: $3006; vr: 'xs' ),
    (Group: $60; Element: $3008; vr: 'US' ),
    (Group: $60; Element: $3010; vr: 'LO' ),
    (Group: $60; Element: $3020; vr: 'UL' ),
    (Group: $70; Element: $1; vr: 'SQ' ),
    (Group: $70; Element: $2; vr: 'CS' ),
    (Group: $70; Element: $3; vr: 'CS' ),
    (Group: $70; Element: $4; vr: 'CS' ),
    (Group: $70; Element: $5; vr: 'CS' ),
    (Group: $70; Element: $6; vr: 'ST' ),
    (Group: $70; Element: $8; vr: 'SQ' ),
    (Group: $70; Element: $9; vr: 'SQ' ),
    (Group: $70; Element: $10; vr: 'FL' ),
    (Group: $70; Element: $11; vr: 'FL' ),
    (Group: $70; Element: $14; vr: 'FL' ),
    (Group: $70; Element: $15; vr: 'CS' ),
    (Group: $70; Element: $20; vr: 'US' ),
    (Group: $70; Element: $21; vr: 'US' ),
    (Group: $70; Element: $22; vr: 'FL' ),
    (Group: $70; Element: $23; vr: 'CS' ),
    (Group: $70; Element: $24; vr: 'CS' ),
    (Group: $70; Element: $40; vr: 'IS' ),
    (Group: $70; Element: $41; vr: 'CS' ),
    (Group: $70; Element: $50; vr: 'US' ),
    (Group: $70; Element: $51; vr: 'US' ),
    (Group: $70; Element: $60; vr: 'SQ' ),
    (Group: $70; Element: $62; vr: 'IS' ),
    (Group: $70; Element: $66; vr: 'US' ),
    (Group: $70; Element: $68; vr: 'LO' ),
    (Group: $70; Element: $80; vr: 'CS' ),
    (Group: $70; Element: $81; vr: 'LO' ),
    (Group: $70; Element: $82; vr: 'DA' ),
    (Group: $70; Element: $83; vr: 'TM' ),
    (Group: $70; Element: $84; vr: 'PN' ),
    (Group: $87; Element: $10; vr: 'CS' ),
    (Group: $87; Element: $20; vr: 'CS' ),
    (Group: $87; Element: $50; vr: 'IS' ),
    (Group: $88; Element: $0; vr: 'UL' ),
    (Group: $88; Element: $130; vr: 'SH' ),
    (Group: $88; Element: $140; vr: 'UI' ),
    (Group: $88; Element: $200; vr: 'SQ' ),
    (Group: $88; Element: $904; vr: 'LO' ),
    (Group: $88; Element: $906; vr: 'ST' ),
    (Group: $88; Element: $910; vr: 'LO' ),
    (Group: $88; Element: $912; vr: 'LO' ),
    (Group: $95; Element: $1; vr: 'LT' ),
    (Group: $95; Element: $4; vr: 'UL' ),
    (Group: $95; Element: $5; vr: 'LT' ),
    (Group: $95; Element: $7; vr: 'LT' ),
    (Group: $99; Element: $2; vr: 'UL' ),
    (Group: $e1; Element: $1; vr: 'US' ),
    (Group: $e1; Element: $14; vr: 'LT' ),
    (Group: $e1; Element: $22; vr: 'DS' ),
    (Group: $e1; Element: $23; vr: 'DS' ),
    (Group: $e1; Element: $24; vr: 'LT' ),
    (Group: $e1; Element: $25; vr: 'LT' ),
    (Group: $e1; Element: $40; vr: 'SH' ),
    (Group: $193; Element: $2; vr: 'DS' ),
    (Group: $307; Element: $1; vr: 'UN' ),
    (Group: $309; Element: $1; vr: 'UN' ),
    (Group: $601; Element: $0; vr: 'SH' ),
    (Group: $601; Element: $20; vr: 'DS' ),
    (Group: $601; Element: $21; vr: 'DS' ),
    (Group: $601; Element: $30; vr: 'SH' ),
    (Group: $601; Element: $31; vr: 'DS' ),
    (Group: $601; Element: $50; vr: 'SH' ),
    (Group: $601; Element: $70; vr: 'DS' ),
    (Group: $601; Element: $71; vr: 'DS' ),
    (Group: $601; Element: $72; vr: 'DS' ),
    (Group: $1000; Element: $0; vr: 'xs' ),
    (Group: $1000; Element: $1; vr: 'US' ),
    (Group: $1000; Element: $2; vr: 'US' ),
    (Group: $1000; Element: $3; vr: 'US' ),
    (Group: $1000; Element: $4; vr: 'US' ),
    (Group: $1000; Element: $5; vr: 'US' ),
    (Group: $1010; Element: $0; vr: 'xs' ),
    (Group: $1369; Element: $0; vr: 'US' ),
    (Group: $2000; Element: $0; vr: 'UL' ),
    (Group: $2000; Element: $10; vr: 'IS' ),
    (Group: $2000; Element: $20; vr: 'CS' ),
    (Group: $2000; Element: $30; vr: 'CS' ),
    (Group: $2000; Element: $40; vr: 'CS' ),
    (Group: $2000; Element: $50; vr: 'LO' ),
    (Group: $2000; Element: $60; vr: 'IS' ),
    (Group: $2000; Element: $500; vr: 'SQ' ),
    (Group: $2010; Element: $0; vr: 'UL' ),
    (Group: $2010; Element: $10; vr: 'ST' ),
    (Group: $2010; Element: $30; vr: 'CS' ),
    (Group: $2010; Element: $40; vr: 'CS' ),
    (Group: $2010; Element: $50; vr: 'CS' ),
    (Group: $2010; Element: $60; vr: 'CS' ),
    (Group: $2010; Element: $80; vr: 'CS' ),
    (Group: $2010; Element: $100; vr: 'CS' ),
    (Group: $2010; Element: $110; vr: 'CS' ),
    (Group: $2010; Element: $120; vr: 'US' ),
    (Group: $2010; Element: $130; vr: 'US' ),
    (Group: $2010; Element: $140; vr: 'CS' ),
    (Group: $2010; Element: $150; vr: 'ST' ),
    (Group: $2010; Element: $500; vr: 'SQ' ),
    (Group: $2010; Element: $510; vr: 'SQ' ),
    (Group: $2010; Element: $520; vr: 'SQ' ),
    (Group: $2020; Element: $0; vr: 'UL' ),
    (Group: $2020; Element: $10; vr: 'US' ),
    (Group: $2020; Element: $20; vr: 'CS' ),
    (Group: $2020; Element: $30; vr: 'DS' ),
    (Group: $2020; Element: $110; vr: 'SQ' ),
    (Group: $2020; Element: $111; vr: 'SQ' ),
    (Group: $2020; Element: $130; vr: 'SQ' ),
    (Group: $2020; Element: $140; vr: 'SQ' ),
    (Group: $2030; Element: $0; vr: 'UL' ),
    (Group: $2030; Element: $10; vr: 'US' ),
    (Group: $2030; Element: $20; vr: 'LO' ),
    (Group: $2040; Element: $0; vr: 'UL' ),
    (Group: $2040; Element: $10; vr: 'SQ' ),
    (Group: $2040; Element: $11; vr: 'US' ),
    (Group: $2040; Element: $60; vr: 'CS' ),
    (Group: $2040; Element: $70; vr: 'CS' ),
    (Group: $2040; Element: $80; vr: 'CS' ),
    (Group: $2040; Element: $90; vr: 'CS' ),
    (Group: $2040; Element: $100; vr: 'CS' ),
    (Group: $2040; Element: $500; vr: 'SQ' ),
    (Group: $2050; Element: $10; vr: 'SQ' ),
    (Group: $2050; Element: $20; vr: 'CS' ),
    (Group: $2100; Element: $0; vr: 'UL' ),
    (Group: $2100; Element: $20; vr: 'CS' ),
    (Group: $2100; Element: $30; vr: 'CS' ),
    (Group: $2100; Element: $40; vr: 'DA' ),
    (Group: $2100; Element: $50; vr: 'TM' ),
    (Group: $2100; Element: $70; vr: 'AE' ),
    (Group: $2100; Element: $500; vr: 'SQ' ),
    (Group: $2110; Element: $0; vr: 'UL' ),
    (Group: $2110; Element: $10; vr: 'CS' ),
    (Group: $2110; Element: $20; vr: 'CS' ),
    (Group: $2110; Element: $30; vr: 'LO' ),
    (Group: $2110; Element: $99; vr: 'SH' ),
    (Group: $3002; Element: $2; vr: 'SH' ),
    (Group: $3002; Element: $3; vr: 'LO' ),
    (Group: $3002; Element: $4; vr: 'ST' ),
    (Group: $3002; Element: $a; vr: 'CS' ),
    (Group: $3002; Element: $c; vr: 'CS' ),
    (Group: $3002; Element: $e; vr: 'DS' ),
    (Group: $3002; Element: $10; vr: 'DS' ),
    (Group: $3002; Element: $11; vr: 'DS' ),
    (Group: $3002; Element: $12; vr: 'DS' ),
    (Group: $3002; Element: $20; vr: 'SH' ),
    (Group: $3002; Element: $22; vr: 'DS' ),
    (Group: $3002; Element: $24; vr: 'DS' ),
    (Group: $3002; Element: $26; vr: 'DS' ),
    (Group: $3002; Element: $28; vr: 'DS' ),
    (Group: $3002; Element: $29; vr: 'IS' ),
    (Group: $3002; Element: $30; vr: 'SQ' ),
    (Group: $3002; Element: $32; vr: 'DS' ),
    (Group: $3004; Element: $1; vr: 'CS' ),
    (Group: $3004; Element: $2; vr: 'CS' ),
    (Group: $3004; Element: $4; vr: 'CS' ),
    (Group: $3004; Element: $6; vr: 'LO' ),
    (Group: $3004; Element: $8; vr: 'DS' ),
    (Group: $3004; Element: $a; vr: 'CS' ),
    (Group: $3004; Element: $c; vr: 'DS' ),
    (Group: $3004; Element: $e; vr: 'DS' ),
    (Group: $3004; Element: $10; vr: 'SQ' ),
    (Group: $3004; Element: $12; vr: 'DS' ),
    (Group: $3004; Element: $40; vr: 'DS' ),
    (Group: $3004; Element: $42; vr: 'DS' ),
    (Group: $3004; Element: $50; vr: 'SQ' ),
    (Group: $3004; Element: $52; vr: 'DS' ),
    (Group: $3004; Element: $54; vr: 'CS' ),
    (Group: $3004; Element: $56; vr: 'IS' ),
    (Group: $3004; Element: $58; vr: 'DS' ),
    (Group: $3004; Element: $60; vr: 'SQ' ),
    (Group: $3004; Element: $62; vr: 'CS' ),
    (Group: $3004; Element: $70; vr: 'DS' ),
    (Group: $3004; Element: $72; vr: 'DS' ),
    (Group: $3004; Element: $74; vr: 'DS' ),
    (Group: $3006; Element: $2; vr: 'SH' ),
    (Group: $3006; Element: $4; vr: 'LO' ),
    (Group: $3006; Element: $6; vr: 'ST' ),
    (Group: $3006; Element: $8; vr: 'DA' ),
    (Group: $3006; Element: $9; vr: 'TM' ),
    (Group: $3006; Element: $10; vr: 'SQ' ),
    (Group: $3006; Element: $12; vr: 'SQ' ),
    (Group: $3006; Element: $14; vr: 'SQ' ),
    (Group: $3006; Element: $16; vr: 'SQ' ),
    (Group: $3006; Element: $20; vr: 'SQ' ),
    (Group: $3006; Element: $22; vr: 'IS' ),
    (Group: $3006; Element: $24; vr: 'UI' ),
    (Group: $3006; Element: $26; vr: 'LO' ),
    (Group: $3006; Element: $28; vr: 'ST' ),
    (Group: $3006; Element: $2a; vr: 'IS' ),
    (Group: $3006; Element: $2c; vr: 'DS' ),
    (Group: $3006; Element: $30; vr: 'SQ' ),
    (Group: $3006; Element: $33; vr: 'CS' ),
    (Group: $3006; Element: $36; vr: 'CS' ),
    (Group: $3006; Element: $38; vr: 'LO' ),
    (Group: $3006; Element: $39; vr: 'SQ' ),
    (Group: $3006; Element: $40; vr: 'SQ' ),
    (Group: $3006; Element: $42; vr: 'CS' ),
    (Group: $3006; Element: $44; vr: 'DS' ),
    (Group: $3006; Element: $45; vr: 'DS' ),
    (Group: $3006; Element: $46; vr: 'IS' ),
    (Group: $3006; Element: $50; vr: 'DS' ),
    (Group: $3006; Element: $80; vr: 'SQ' ),
    (Group: $3006; Element: $82; vr: 'IS' ),
    (Group: $3006; Element: $84; vr: 'IS' ),
    (Group: $3006; Element: $85; vr: 'SH' ),
    (Group: $3006; Element: $86; vr: 'SQ' ),
    (Group: $3006; Element: $88; vr: 'ST' ),
    (Group: $3006; Element: $a0; vr: 'SQ' ),
    (Group: $3006; Element: $a4; vr: 'CS' ),
    (Group: $3006; Element: $a6; vr: 'PN' ),
    (Group: $3006; Element: $b0; vr: 'SQ' ),
    (Group: $3006; Element: $b2; vr: 'CS' ),
    (Group: $3006; Element: $b4; vr: 'DS' ),
    (Group: $3006; Element: $c0; vr: 'SQ' ),
    (Group: $3006; Element: $c2; vr: 'UI' ),
    (Group: $3006; Element: $c4; vr: 'CS' ),
    (Group: $3006; Element: $c6; vr: 'DS' ),
    (Group: $3006; Element: $c8; vr: 'LO' ),
    (Group: $300a; Element: $2; vr: 'SH' ),
    (Group: $300a; Element: $3; vr: 'LO' ),
    (Group: $300a; Element: $4; vr: 'ST' ),
    (Group: $300a; Element: $6; vr: 'DA' ),
    (Group: $300a; Element: $7; vr: 'TM' ),
    (Group: $300a; Element: $9; vr: 'LO' ),
    (Group: $300a; Element: $a; vr: 'CS' ),
    (Group: $300a; Element: $b; vr: 'LO' ),
    (Group: $300a; Element: $c; vr: 'CS' ),
    (Group: $300a; Element: $e; vr: 'ST' ),
    (Group: $300a; Element: $10; vr: 'SQ' ),
    (Group: $300a; Element: $12; vr: 'IS' ),
    (Group: $300a; Element: $14; vr: 'CS' ),
    (Group: $300a; Element: $16; vr: 'LO' ),
    (Group: $300a; Element: $18; vr: 'DS' ),
    (Group: $300a; Element: $1a; vr: 'DS' ),
    (Group: $300a; Element: $20; vr: 'CS' ),
    (Group: $300a; Element: $21; vr: 'DS' ),
    (Group: $300a; Element: $22; vr: 'DS' ),
    (Group: $300a; Element: $23; vr: 'DS' ),
    (Group: $300a; Element: $25; vr: 'DS' ),
    (Group: $300a; Element: $26; vr: 'DS' ),
    (Group: $300a; Element: $27; vr: 'DS' ),
    (Group: $300a; Element: $28; vr: 'DS' ),
    (Group: $300a; Element: $2a; vr: 'DS' ),
    (Group: $300a; Element: $2b; vr: 'DS' ),
    (Group: $300a; Element: $2c; vr: 'DS' ),
    (Group: $300a; Element: $2d; vr: 'DS' ),
    (Group: $300a; Element: $40; vr: 'SQ' ),
    (Group: $300a; Element: $42; vr: 'IS' ),
    (Group: $300a; Element: $43; vr: 'SH' ),
    (Group: $300a; Element: $44; vr: 'DS' ),
    (Group: $300a; Element: $46; vr: 'DS' ),
    (Group: $300a; Element: $48; vr: 'SQ' ),
    (Group: $300a; Element: $4a; vr: 'DS' ),
    (Group: $300a; Element: $4c; vr: 'DS' ),
    (Group: $300a; Element: $4e; vr: 'DS' ),
    (Group: $300a; Element: $51; vr: 'DS' ),
    (Group: $300a; Element: $52; vr: 'DS' ),
    (Group: $300a; Element: $53; vr: 'DS' ),
    (Group: $300a; Element: $55; vr: 'CS' ),
    (Group: $300a; Element: $70; vr: 'SQ' ),
    (Group: $300a; Element: $71; vr: 'IS' ),
    (Group: $300a; Element: $78; vr: 'IS' ),
    (Group: $300a; Element: $79; vr: 'IS' ),
    (Group: $300a; Element: $7a; vr: 'IS' ),
    (Group: $300a; Element: $7b; vr: 'LT' ),
    (Group: $300a; Element: $80; vr: 'IS' ),
    (Group: $300a; Element: $82; vr: 'DS' ),
    (Group: $300a; Element: $84; vr: 'DS' ),
    (Group: $300a; Element: $86; vr: 'DS' ),
    (Group: $300a; Element: $a0; vr: 'IS' ),
    (Group: $300a; Element: $a2; vr: 'DS' ),
    (Group: $300a; Element: $a4; vr: 'DS' ),
    (Group: $300a; Element: $b0; vr: 'SQ' ),
    (Group: $300a; Element: $b2; vr: 'SH' ),
    (Group: $300a; Element: $b3; vr: 'CS' ),
    (Group: $300a; Element: $b4; vr: 'DS' ),
    (Group: $300a; Element: $b6; vr: 'SQ' ),
    (Group: $300a; Element: $b8; vr: 'CS' ),
    (Group: $300a; Element: $ba; vr: 'DS' ),
    (Group: $300a; Element: $bc; vr: 'IS' ),
    (Group: $300a; Element: $be; vr: 'DS' ),
    (Group: $300a; Element: $c0; vr: 'IS' ),
    (Group: $300a; Element: $c2; vr: 'LO' ),
    (Group: $300a; Element: $c3; vr: 'ST' ),
    (Group: $300a; Element: $c4; vr: 'CS' ),
    (Group: $300a; Element: $c6; vr: 'CS' ),
    (Group: $300a; Element: $c8; vr: 'IS' ),
    (Group: $300a; Element: $ca; vr: 'SQ' ),
    (Group: $300a; Element: $cc; vr: 'LO' ),
    (Group: $300a; Element: $ce; vr: 'CS' ),
    (Group: $300a; Element: $d0; vr: 'IS' ),
    (Group: $300a; Element: $d1; vr: 'SQ' ),
    (Group: $300a; Element: $d2; vr: 'IS' ),
    (Group: $300a; Element: $d3; vr: 'CS' ),
    (Group: $300a; Element: $d4; vr: 'SH' ),
    (Group: $300a; Element: $d5; vr: 'IS' ),
    (Group: $300a; Element: $d6; vr: 'DS' ),
    (Group: $300a; Element: $d8; vr: 'DS' ),
    (Group: $300a; Element: $da; vr: 'DS' ),
    (Group: $300a; Element: $e0; vr: 'IS' ),
    (Group: $300a; Element: $e1; vr: 'SH' ),
    (Group: $300a; Element: $e2; vr: 'DS' ),
    (Group: $300a; Element: $e3; vr: 'SQ' ),
    (Group: $300a; Element: $e4; vr: 'IS' ),
    (Group: $300a; Element: $e5; vr: 'SH' ),
    (Group: $300a; Element: $e6; vr: 'DS' ),
    (Group: $300a; Element: $e7; vr: 'IS' ),
    (Group: $300a; Element: $e8; vr: 'IS' ),
    (Group: $300a; Element: $e9; vr: 'DS' ),
    (Group: $300a; Element: $ea; vr: 'DS' ),
    (Group: $300a; Element: $eb; vr: 'DS' ),
    (Group: $300a; Element: $ec; vr: 'DS' ),
    (Group: $300a; Element: $ed; vr: 'IS' ),
    (Group: $300a; Element: $f0; vr: 'IS' ),
    (Group: $300a; Element: $f2; vr: 'DS' ),
    (Group: $300a; Element: $f4; vr: 'SQ' ),
    (Group: $300a; Element: $f5; vr: 'SH' ),
    (Group: $300a; Element: $f6; vr: 'DS' ),
    (Group: $300a; Element: $f8; vr: 'CS' ),
    (Group: $300a; Element: $fa; vr: 'CS' ),
    (Group: $300a; Element: $fc; vr: 'IS' ),
    (Group: $300a; Element: $fe; vr: 'LO' ),
    (Group: $300a; Element: $100; vr: 'DS' ),
    (Group: $300a; Element: $102; vr: 'DS' ),
    (Group: $300a; Element: $104; vr: 'IS' ),
    (Group: $300a; Element: $106; vr: 'DS' ),
    (Group: $300a; Element: $107; vr: 'SQ' ),
    (Group: $300a; Element: $108; vr: 'SH' ),
    (Group: $300a; Element: $109; vr: 'CS' ),
    (Group: $300a; Element: $10a; vr: 'LO' ),
    (Group: $300a; Element: $10c; vr: 'DS' ),
    (Group: $300a; Element: $10e; vr: 'DS' ),
    (Group: $300a; Element: $110; vr: 'IS' ),
    (Group: $300a; Element: $111; vr: 'SQ' ),
    (Group: $300a; Element: $112; vr: 'IS' ),
    (Group: $300a; Element: $114; vr: 'DS' ),
    (Group: $300a; Element: $115; vr: 'DS' ),
    (Group: $300a; Element: $116; vr: 'SQ' ),
    (Group: $300a; Element: $118; vr: 'CS' ),
    (Group: $300a; Element: $11a; vr: 'SQ' ),
    (Group: $300a; Element: $11c; vr: 'DS' ),
    (Group: $300a; Element: $11e; vr: 'DS' ),
    (Group: $300a; Element: $11f; vr: 'CS' ),
    (Group: $300a; Element: $120; vr: 'DS' ),
    (Group: $300a; Element: $121; vr: 'CS' ),
    (Group: $300a; Element: $122; vr: 'DS' ),
    (Group: $300a; Element: $123; vr: 'CS' ),
    (Group: $300a; Element: $124; vr: 'DS' ),
    (Group: $300a; Element: $125; vr: 'DS' ),
    (Group: $300a; Element: $126; vr: 'CS' ),
    (Group: $300a; Element: $128; vr: 'DS' ),
    (Group: $300a; Element: $129; vr: 'DS' ),
    (Group: $300a; Element: $12a; vr: 'DS' ),
    (Group: $300a; Element: $12c; vr: 'DS' ),
    (Group: $300a; Element: $12e; vr: 'DS' ),
    (Group: $300a; Element: $130; vr: 'DS' ),
    (Group: $300a; Element: $134; vr: 'DS' ),
    (Group: $300a; Element: $180; vr: 'SQ' ),
    (Group: $300a; Element: $182; vr: 'IS' ),
    (Group: $300a; Element: $184; vr: 'LO' ),
    (Group: $300a; Element: $190; vr: 'SQ' ),
    (Group: $300a; Element: $192; vr: 'CS' ),
    (Group: $300a; Element: $194; vr: 'SH' ),
    (Group: $300a; Element: $196; vr: 'ST' ),
    (Group: $300a; Element: $198; vr: 'SH' ),
    (Group: $300a; Element: $1a0; vr: 'SQ' ),
    (Group: $300a; Element: $1a2; vr: 'CS' ),
    (Group: $300a; Element: $1a4; vr: 'SH' ),
    (Group: $300a; Element: $1a6; vr: 'ST' ),
    (Group: $300a; Element: $1a8; vr: 'SH' ),
    (Group: $300a; Element: $1b0; vr: 'CS' ),
    (Group: $300a; Element: $1b2; vr: 'ST' ),
    (Group: $300a; Element: $1b4; vr: 'SQ' ),
    (Group: $300a; Element: $1b6; vr: 'CS' ),
    (Group: $300a; Element: $1b8; vr: 'SH' ),
    (Group: $300a; Element: $1ba; vr: 'ST' ),
    (Group: $300a; Element: $1bc; vr: 'DS' ),
    (Group: $300a; Element: $1d0; vr: 'ST' ),
    (Group: $300a; Element: $1d2; vr: 'DS' ),
    (Group: $300a; Element: $1d4; vr: 'DS' ),
    (Group: $300a; Element: $1d6; vr: 'DS' ),
    (Group: $300a; Element: $200; vr: 'CS' ),
    (Group: $300a; Element: $202; vr: 'CS' ),
    (Group: $300a; Element: $206; vr: 'SQ' ),
    (Group: $300a; Element: $210; vr: 'SQ' ),
    (Group: $300a; Element: $212; vr: 'IS' ),
    (Group: $300a; Element: $214; vr: 'CS' ),
    (Group: $300a; Element: $216; vr: 'LO' ),
    (Group: $300a; Element: $218; vr: 'DS' ),
    (Group: $300a; Element: $21a; vr: 'DS' ),
    (Group: $300a; Element: $222; vr: 'DS' ),
    (Group: $300a; Element: $224; vr: 'DS' ),
    (Group: $300a; Element: $226; vr: 'LO' ),
    (Group: $300a; Element: $228; vr: 'DS' ),
    (Group: $300a; Element: $22a; vr: 'DS' ),
    (Group: $300a; Element: $22c; vr: 'DA' ),
    (Group: $300a; Element: $22e; vr: 'TM' ),
    (Group: $300a; Element: $230; vr: 'SQ' ),
    (Group: $300a; Element: $232; vr: 'CS' ),
    (Group: $300a; Element: $234; vr: 'IS' ),
    (Group: $300a; Element: $236; vr: 'LO' ),
    (Group: $300a; Element: $238; vr: 'LO' ),
    (Group: $300a; Element: $240; vr: 'IS' ),
    (Group: $300a; Element: $242; vr: 'SH' ),
    (Group: $300a; Element: $244; vr: 'LO' ),
    (Group: $300a; Element: $250; vr: 'DS' ),
    (Group: $300a; Element: $260; vr: 'SQ' ),
    (Group: $300a; Element: $262; vr: 'IS' ),
    (Group: $300a; Element: $263; vr: 'SH' ),
    (Group: $300a; Element: $264; vr: 'CS' ),
    (Group: $300a; Element: $266; vr: 'LO' ),
    (Group: $300a; Element: $26a; vr: 'DS' ),
    (Group: $300a; Element: $26c; vr: 'DS' ),
    (Group: $300a; Element: $280; vr: 'SQ' ),
    (Group: $300a; Element: $282; vr: 'IS' ),
    (Group: $300a; Element: $284; vr: 'DS' ),
    (Group: $300a; Element: $286; vr: 'DS' ),
    (Group: $300a; Element: $288; vr: 'CS' ),
    (Group: $300a; Element: $28a; vr: 'IS' ),
    (Group: $300a; Element: $28c; vr: 'DS' ),
    (Group: $300a; Element: $290; vr: 'IS' ),
    (Group: $300a; Element: $291; vr: 'SH' ),
    (Group: $300a; Element: $292; vr: 'CS' ),
    (Group: $300a; Element: $294; vr: 'LO' ),
    (Group: $300a; Element: $296; vr: 'DS' ),
    (Group: $300a; Element: $298; vr: 'LO' ),
    (Group: $300a; Element: $29c; vr: 'DS' ),
    (Group: $300a; Element: $29e; vr: 'DS' ),
    (Group: $300a; Element: $2a0; vr: 'DS' ),
    (Group: $300a; Element: $2a2; vr: 'IS' ),
    (Group: $300a; Element: $2a4; vr: 'DS' ),
    (Group: $300a; Element: $2b0; vr: 'SQ' ),
    (Group: $300a; Element: $2b2; vr: 'IS' ),
    (Group: $300a; Element: $2b3; vr: 'SH' ),
    (Group: $300a; Element: $2b4; vr: 'LO' ),
    (Group: $300a; Element: $2b8; vr: 'DS' ),
    (Group: $300a; Element: $2ba; vr: 'DS' ),
    (Group: $300a; Element: $2c8; vr: 'DS' ),
    (Group: $300a; Element: $2d0; vr: 'SQ' ),
    (Group: $300a; Element: $2d2; vr: 'DS' ),
    (Group: $300a; Element: $2d4; vr: 'DS' ),
    (Group: $300a; Element: $2d6; vr: 'DS' ),
    (Group: $300c; Element: $2; vr: 'SQ' ),
    (Group: $300c; Element: $4; vr: 'SQ' ),
    (Group: $300c; Element: $6; vr: 'IS' ),
    (Group: $300c; Element: $7; vr: 'IS' ),
    (Group: $300c; Element: $8; vr: 'DS' ),
    (Group: $300c; Element: $9; vr: 'DS' ),
    (Group: $300c; Element: $a; vr: 'SQ' ),
    (Group: $300c; Element: $c; vr: 'IS' ),
    (Group: $300c; Element: $e; vr: 'IS' ),
    (Group: $300c; Element: $20; vr: 'SQ' ),
    (Group: $300c; Element: $22; vr: 'IS' ),
    (Group: $300c; Element: $40; vr: 'SQ' ),
    (Group: $300c; Element: $42; vr: 'SQ' ),
    (Group: $300c; Element: $50; vr: 'SQ' ),
    (Group: $300c; Element: $51; vr: 'IS' ),
    (Group: $300c; Element: $55; vr: 'SQ' ),
    (Group: $300c; Element: $60; vr: 'SQ' ),
    (Group: $300c; Element: $6a; vr: 'IS' ),
    (Group: $300c; Element: $80; vr: 'SQ' ),
    (Group: $300c; Element: $a0; vr: 'IS' ),
    (Group: $300c; Element: $b0; vr: 'SQ' ),
    (Group: $300c; Element: $c0; vr: 'IS' ),
    (Group: $300c; Element: $d0; vr: 'IS' ),
    (Group: $300c; Element: $e0; vr: 'IS' ),
    (Group: $300c; Element: $f0; vr: 'IS' ),
    (Group: $300e; Element: $2; vr: 'CS' ),
    (Group: $300e; Element: $4; vr: 'DA' ),
    (Group: $300e; Element: $5; vr: 'TM' ),
    (Group: $300e; Element: $8; vr: 'PN' ),
    (Group: $4000; Element: $0; vr: 'UL' ),
    (Group: $4000; Element: $10; vr: 'LT' ),
    (Group: $4000; Element: $4000; vr: 'LT' ),
    (Group: $4008; Element: $0; vr: 'UL' ),
    (Group: $4008; Element: $40; vr: 'SH' ),
    (Group: $4008; Element: $42; vr: 'LO' ),
    (Group: $4008; Element: $50; vr: 'SQ' ),
    (Group: $4008; Element: $ff; vr: 'CS' ),
    (Group: $4008; Element: $100; vr: 'DA' ),
    (Group: $4008; Element: $101; vr: 'TM' ),
    (Group: $4008; Element: $102; vr: 'PN' ),
    (Group: $4008; Element: $103; vr: 'LO' ),
    (Group: $4008; Element: $108; vr: 'DA' ),
    (Group: $4008; Element: $109; vr: 'TM' ),
    (Group: $4008; Element: $10a; vr: 'PN' ),
    (Group: $4008; Element: $10b; vr: 'ST' ),
    (Group: $4008; Element: $10c; vr: 'PN' ),
    (Group: $4008; Element: $111; vr: 'SQ' ),
    (Group: $4008; Element: $112; vr: 'DA' ),
    (Group: $4008; Element: $113; vr: 'TM' ),
    (Group: $4008; Element: $114; vr: 'PN' ),
    (Group: $4008; Element: $115; vr: 'LT' ),
    (Group: $4008; Element: $117; vr: 'SQ' ),
    (Group: $4008; Element: $118; vr: 'SQ' ),
    (Group: $4008; Element: $119; vr: 'PN' ),
    (Group: $4008; Element: $11a; vr: 'LO' ),
    (Group: $4008; Element: $200; vr: 'SH' ),
    (Group: $4008; Element: $202; vr: 'LO' ),
    (Group: $4008; Element: $210; vr: 'CS' ),
    (Group: $4008; Element: $212; vr: 'CS' ),
    (Group: $4008; Element: $300; vr: 'ST' ),
    (Group: $4008; Element: $4000; vr: 'ST' ),
    (Group: $4009; Element: $1; vr: 'LT' ),
    (Group: $4009; Element: $20; vr: 'LT' ),
    (Group: $4009; Element: $30; vr: 'DA' ),
    (Group: $4009; Element: $70; vr: 'LT' ),
    (Group: $4009; Element: $e0; vr: 'LT' ),
    (Group: $4009; Element: $e1; vr: 'LT' ),
    (Group: $4009; Element: $e3; vr: 'LT' ),
    (Group: $5000; Element: $0; vr: 'UL' ),
    (Group: $5000; Element: $5; vr: 'US' ),
    (Group: $5000; Element: $10; vr: 'US' ),
    (Group: $5000; Element: $20; vr: 'CS' ),
    (Group: $5000; Element: $22; vr: 'LO' ),
    (Group: $5000; Element: $30; vr: 'SH' ),
    (Group: $5000; Element: $40; vr: 'SH' ),
    (Group: $5000; Element: $103; vr: 'US' ),
    (Group: $5000; Element: $104; vr: 'US' ),
    (Group: $5000; Element: $105; vr: 'US' ),
    (Group: $5000; Element: $106; vr: 'SH' ),
    (Group: $5000; Element: $110; vr: 'US' ),
    (Group: $5000; Element: $112; vr: 'US' ),
    (Group: $5000; Element: $114; vr: 'US' ),
    (Group: $5000; Element: $1001; vr: 'CS' ),
    (Group: $5000; Element: $2000; vr: 'US' ),
    (Group: $5000; Element: $2002; vr: 'US' ),
    (Group: $5000; Element: $2004; vr: 'US' ),
    (Group: $5000; Element: $2006; vr: 'UL' ),
    (Group: $5000; Element: $2008; vr: 'UL' ),
    (Group: $5000; Element: $200a; vr: 'UL' ),
    (Group: $5000; Element: $200c; vr: 'xs' ),
    (Group: $5000; Element: $200e; vr: 'LT' ),
    (Group: $5000; Element: $2500; vr: 'LO' ),
    (Group: $5000; Element: $2600; vr: 'SQ' ),
    (Group: $5000; Element: $2610; vr: 'US' ),
    (Group: $5000; Element: $3000; vr: 'OW' ),
    (Group: $6000; Element: $0; vr: 'UL' ),
    (Group: $6000; Element: $1; vr: 'US' ),
    (Group: $6000; Element: $2; vr: 'US' ),
    (Group: $6000; Element: $10; vr: 'US' ),
    (Group: $6000; Element: $11; vr: 'US' ),
    (Group: $6000; Element: $12; vr: 'US' ),
    (Group: $6000; Element: $15; vr: 'IS' ),
    (Group: $6000; Element: $22; vr: 'LO' ),
    (Group: $6000; Element: $40; vr: 'CS' ),
    (Group: $6000; Element: $45; vr: 'CS' ),
    (Group: $6000; Element: $50; vr: 'SS' ),
    (Group: $6000; Element: $51; vr: 'US' ),
    (Group: $6000; Element: $52; vr: 'US' ),
    (Group: $6000; Element: $60; vr: 'LO' ),
    (Group: $6000; Element: $61; vr: 'SH' ),
    (Group: $6000; Element: $62; vr: 'SH' ),
    (Group: $6000; Element: $63; vr: 'SH' ),
    (Group: $6000; Element: $66; vr: 'AT' ),
    (Group: $6000; Element: $68; vr: 'US' ),
    (Group: $6000; Element: $69; vr: 'US' ),
    (Group: $6000; Element: $100; vr: 'US' ),
    (Group: $6000; Element: $102; vr: 'US' ),
    (Group: $6000; Element: $110; vr: 'LO' ),
    (Group: $6000; Element: $200; vr: 'xs' ),
    (Group: $6000; Element: $800; vr: 'LO' ),
    (Group: $6000; Element: $802; vr: 'US' ),
    (Group: $6000; Element: $803; vr: 'AT' ),
    (Group: $6000; Element: $804; vr: 'US' ),
    (Group: $6000; Element: $1001; vr: 'CS' ),
    (Group: $6000; Element: $1100; vr: 'US' ),
    (Group: $6000; Element: $1101; vr: 'US' ),
    (Group: $6000; Element: $1102; vr: 'US' ),
    (Group: $6000; Element: $1103; vr: 'US' ),
    (Group: $6000; Element: $1200; vr: 'US' ),
    (Group: $6000; Element: $1201; vr: 'US' ),
    (Group: $6000; Element: $1202; vr: 'US' ),
    (Group: $6000; Element: $1203; vr: 'US' ),
    (Group: $6000; Element: $1301; vr: 'IS' ),
    (Group: $6000; Element: $1302; vr: 'DS' ),
    (Group: $6000; Element: $1303; vr: 'DS' ),
    (Group: $6000; Element: $1500; vr: 'LO' ),
    (Group: $6000; Element: $3000; vr: 'OW' ),
    (Group: $6000; Element: $4000; vr: 'LT' ),
    (Group: $6001; Element: $0; vr: 'UN' ),
    (Group: $6001; Element: $10; vr: 'LO' ),
    (Group: $6001; Element: $1010; vr: 'xs' ),
    (Group: $6001; Element: $1030; vr: 'xs' ),
    (Group: $6021; Element: $0; vr: 'xs' ),
    (Group: $6021; Element: $10; vr: 'xs' ),
    (Group: $7000; Element: $4; vr: 'ST' ),
    (Group: $7000; Element: $5; vr: 'IS' ),
    (Group: $7000; Element: $7; vr: 'IS' ),
    (Group: $7001; Element: $10; vr: 'LT' ),
    (Group: $7003; Element: $10; vr: 'LT' ),
    (Group: $7005; Element: $10; vr: 'LT' ),
    (Group: $7f00; Element: $0; vr: 'UL' ),
    (Group: $7f00; Element: $10; vr: 'xs' ),
    (Group: $7f00; Element: $11; vr: 'US' ),
    (Group: $7f00; Element: $20; vr: 'OW' ),
    (Group: $7f00; Element: $30; vr: 'OW' ),
    (Group: $7f00; Element: $40; vr: 'OW' ),
    (Group: $7fe0; Element: $0; vr: 'UL' ),
    (Group: $7fe0; Element: $10; vr: 'xs' ),
    (Group: $7fe0; Element: $20; vr: 'OW' ),
    (Group: $7fe0; Element: $30; vr: 'OW' ),
    (Group: $7fe0; Element: $40; vr: 'OW' ),
    (Group: $7fe1; Element: $10; vr: 'xs' ),
    (Group: $7fe1; Element: $0; vr: 'OB' ),
    (Group: $7fe3; Element: $0; vr: 'LT' ),
    (Group: $7fe3; Element: $10; vr: 'OB' ),
    (Group: $7fe3; Element: $20; vr: 'OB' ),
    (Group: $7ff1; Element: $1; vr: 'US' ),
    (Group: $7ff1; Element: $2; vr: 'US' ),
    (Group: $7ff1; Element: $3; vr: 'xs' ),
    (Group: $7ff1; Element: $4; vr: 'IS' ),
    (Group: $7ff1; Element: $5; vr: 'US' ),
    (Group: $7ff1; Element: $7; vr: 'US' ),
    (Group: $7ff1; Element: $8; vr: 'US' ),
    (Group: $7ff1; Element: $9; vr: 'US' ),
    (Group: $7ff1; Element: $a; vr: 'LT' ),
    (Group: $7ff1; Element: $b; vr: 'US' ),
    (Group: $7ff1; Element: $c; vr: 'US' ),
    (Group: $7ff1; Element: $d; vr: 'US' ),
    (Group: $7ff1; Element: $10; vr: 'US' ),
    (Group: $fffc; Element: $fffc; vr: 'OB' ),
    (Group: $fffe; Element: $e000; vr: '!!' ),
    (Group: $fffe; Element: $e00d; vr: '!!' ),
    (Group: $fffe; Element: $e0dd; vr: '!!' ),
    (Group: $ffff; Element: $ffff; vr: 'xs' )

  );


type TDICOMContext = record
  IOParams:TIOParamsVals;
  Bitmap:TIEBitmap;
  Progress:TProgressRec;
  Stream:TIEBufferedReadStream;
  StreamSize:int64;

  Implicit:boolean;
  LittleEndian:boolean; // Intel=LittleEndian
  TransferSyntax:AnsiString;

  SamplesPerPixel:integer;
  PhotometricInterpretation:AnsiString;
  PlanarConfiguration:integer;
  FrameCount:integer;
  PixelRepresentation:integer;
  Width:integer;
  Height:integer;
  BitsAllocated:integer;
  BitsStored:integer;
  BytesPerChannel:integer;
  RMap:pwordarray;
  GMap:pwordarray;
  BMap:pwordarray;
  GrayMap:pointer;
  WindowCenter:double;
  WindowWidth:double;
  RescaleIntercept:double;
  RescaleSlope:double;

end;

function IsUpper(c:AnsiChar):boolean;
begin
  result:=(c>='A') and (c<='Z');
end;

function ReadByte(var ctx:TDICOMContext):byte;
begin
  ctx.Stream.Read(result,1);
end;

function ReadWord(var ctx:TDICOMContext; rev:boolean):word;
begin
  ctx.Stream.Read(result,2);
  if rev then
    result:=IESwapWord(result);
end;

function ReadDWord(var ctx:TDICOMContext; rev:boolean):dword;
begin
  ctx.Stream.Read(result,4);
  if rev then
    result:=IESwapDWord(result);
end;

procedure AdjustRange16g(var ctx:TDICOMContext);
var
  LMin,LMax:integer;
  VMin,VMax:integer;
  v:double;
  row,col:integer;
  pw:pword;
  useWindow:boolean;
  offset:double;
begin
  with ctx do
  begin
    VMin := MAXINT;
    VMax := -MAXINT;
    offset := 0;
    UseWindow := (WindowCenter <> -1) and (WindowWidth <> -1);
    LMin := trunc( (WindowCenter-0.5)-((WindowWidth-1) / 2) );
    LMax := trunc( (WindowCenter-0.5)+((WindowWidth-1) / 2) );
    for row := 0 to Height-1 do
    begin
      pw := Bitmap.Scanline[row];
      for col := 0 to Width-1 do
      begin
      
        (*
        if PixelRepresentation = 1 then
          v := smallint(pw^)
        else
          v := word(pw^);
        *)
        v := smallint(pw^); // 3.1.2 (testcase20100407_2244.dcm)

        v := v * RescaleSlope + RescaleIntercept;
        if useWindow then
        begin
          if v <= LMin then
            v := 0
          else if v >= LMax then
            v := 65535
          else
            v := ((v-(WindowCenter-0.5))/(WindowWidth-1)+0.5)*65535;
        end;
        if v < 0 then
          offset := dmax(offset, -v);
        pw^ := trunc(v+offset);
        if pw^ < VMin then VMin := pw^;
        if pw^ > VMax then VMax := pw^;
        inc(pw);
      end;
    end;

    // adjust to full range
    VMax := VMax-VMin;
    for row := 0 to Height-1 do
    begin
      pw := Bitmap.Scanline[row];
      for col := 0 to Width-1 do
      begin
        pw^ := trunc((pw^-VMin)/VMax*65535);
        inc(pw);
      end;
    end;
  end;
end;

// works also for 24 bit rgb
procedure AdjustRange8g(var ctx:TDICOMContext);
var
  LMin,LMax:integer;
  VMin,VMax:integer;
  v:double;
  row,col:integer;
  pb:pbyte;
  useWindow:boolean;
  offset:double;
begin
  with ctx do
  begin
    VMin:=MAXINT;
    VMax:=-MAXINT;
    offset:=0;
    UseWindow:=(WindowCenter<>-1) and (WindowWidth<>-1);
    LMin:=trunc( (WindowCenter-0.5)-((WindowWidth-1) / 2) );
    LMax:=trunc( (WindowCenter-0.5)+((WindowWidth-1) / 2) );
    for row:=0 to Height-1 do
    begin
      pb:=Bitmap.Scanline[row];
      for col:=0 to Width*SamplesPerPixel-1 do
      begin
        if PixelRepresentation=1 then
          v:=shortint(pb^)
        else
          v:=byte(pb^);
        v:=v*RescaleSlope+RescaleIntercept;
        if useWindow then
        begin
          if v<=LMin then
            v:=0
          else if v>=LMax then
            v:=255
          else
            v:=((v-(WindowCenter-0.5))/(WindowWidth-1)+0.5)*255;
        end;
        if v<0 then
          offset:=dmax(offset,-v);
        pb^:=trunc(v+offset);
        if pb^<VMin then VMin:=pb^;
        if pb^>VMax then VMax:=pb^;
        inc(pb);
      end;
    end;
    // adjust to full range
    VMax:=VMax-VMin;
    for row:=0 to Height-1 do
    begin
      pb:=Bitmap.Scanline[row];
      for col:=0 to Width-1 do
      begin
        pb^:=trunc((pb^-VMin)/VMax*255);
        inc(pb);
      end;
    end;
  end;
end;

procedure AdjustMonochrome16g(var ctx:TDICOMContext);
var
  row,col:integer;
  pw:pword;
begin
  with ctx do
  begin
    if IEUpperCase(IETrim(PhotometricInterpretation))='MONOCHROME1' then
    begin
      // low values high intensity
      for row:=0 to Height-1 do
      begin
        pw:=Bitmap.Scanline[row];
        for col:=0 to Width-1 do
        begin
          pw^:=65535-pw^;
          inc(pw);
        end;
      end;
    end;
  end;
end;

// works also for 24 bit
procedure AdjustMonochrome8g(var ctx:TDICOMContext);
var
  row,col:integer;
  pb:pbyte;
begin
  with ctx do
  begin
    if IEUpperCase(IETrim(PhotometricInterpretation))='MONOCHROME1' then
    begin
      // low values high intensity
      for row:=0 to Height-1 do
      begin
        pb:=Bitmap.Scanline[row];
        for col:=0 to Width*SamplesPerPixel-1 do
        begin
          pb^:=255-pb^;
          inc(pb);
        end;
      end;
    end;
  end;
end;

procedure VerticalFlip(var ctx:TDICOMContext);
var
  row,srow:integer;
  h:integer;
  temp:pointer;
begin
  with ctx do
  begin
    getmem(temp,Bitmap.RowLen);
    h:=Bitmap.Height div 2 -1;
    srow:=Bitmap.Height-1;
    for row:=0 to h do
    begin
      CopyMemory(temp,Bitmap.Scanline[row],Bitmap.RowLen);
      CopyMemory(Bitmap.Scanline[row],Bitmap.Scanline[srow],Bitmap.RowLen);
      CopyMemory(Bitmap.Scanline[srow],temp,Bitmap.RowLen);
      dec(srow);
    end;
    freemem(temp);
  end;
end;

(*
procedure FindJpegBegin(var ctx:TDICOMContext);
var
  bb:byte;
  idx:integer;
begin
  with ctx do
  begin
    // search start of jpeg (FFD8 FF)
    idx:=0;
    while Stream.Position<StreamSize do
    begin
      Stream.Read(bb,1);
      if bb=$FF then
      begin
        Stream.Read(bb,1);
        if bb=$D8 then
        begin
          Stream.Read(bb,1);
          if bb=$FF then
          begin
            if idx=IOParams.ImageIndex then
            begin
              Stream.Seek(-3, soCurrent);
              break;
            end
            else
              inc(idx);
          end;
        end;
      end;
    end;
  end;
end;
*)

procedure ReadImage(var ctx:TDICOMContext);
var
  bb,b1,b2,b3:byte;
  pw:pword;
  pb,pb2:pbyte;
  row,col:integer;
  ww,w1,w2:word;
  idx:PDWORDARRAY;
  dw:dword;
  base:int64;
  buffer:pbyte;
  ch:integer;
  tempParams:TIOParamsVals;
  imageLength:integer;
  lper:integer;
  i:integer;
  p_rgb:PRGB;
  p_rgb48:PRGB48;

  procedure DoProgress(row, height:integer);
  var
    per:integer;
  begin
    if assigned(ctx.Progress.fOnProgress) then
    begin
      per := trunc(row/Height*100);
      if per<>lper then
      begin
        lper := per;
        ctx.Progress.fOnProgress(ctx.Progress.Sender, per);
      end;
    end;
  end;

begin

  lper := -1;

  with ctx do
  begin

    imageLength := 0;
    IOParams.ImageIndex := imin(IOParams.ImageIndex, FrameCount-1);

    // select frame
    Stream.Read(w1, 2);
    Stream.Read(w2, 2);

    if (w1<>$FFFE) or (w2<>$E000) then
    begin
      Stream.Seek(-2, soCurrent);
      // select frame calculating frames length (for uncompressed images only)
      if (TransferSyntax = '1.2.840.10008.1.2')   or
         (TransferSyntax = '1.2.840.10008.1.2.1') or
         (TransferSyntax = '1.2.840.10008.1.2.2') then
        Stream.Position := Stream.Position + IOParams.ImageIndex * Width * Height * SamplesPerPixel * BytesPerChannel;
    end
    else
    begin
      Stream.Read(dw, 4);  // frames index length
      if dw>0 then
      begin
        getmem(idx, 4*FrameCount);
        try
          Stream.Read(idx[0], imin(dw, 4*FrameCount));
          Stream.Position := Stream.Position + int64(idx[IOParams.ImageIndex]);
        finally
          freemem(idx);
        end;
      end
      else
      begin
        // indexes directory not available, loop until reach wanted frame
        for i:=0 to IOParams.ImageIndex-2 do
        begin
          Stream.Read(w1, 2);
          Stream.Read(w2, 2);
          if (w1<>$FFFE) or (w2<>$E000) then
          begin
            Progress.Aborting^ := true;
            exit;
          end;
          Stream.Read(dw, 4);  // image length
          Stream.Position := Stream.Position + int64(dw);
        end;
      end;
      // this is the begin of the frame
      Stream.Read(w1, 2);
      Stream.Read(w2, 2);
      if (w1 <> $FFFE) or (w2 <> $E000) then
      begin
        Progress.Aborting^ := true;
        exit;
      end;
      Stream.Read(dw, 4);  // image length
      imageLength := dw;
    end;

    if imageLength + Stream.Position > Stream.Size then
    begin
      Progress.Aborting^ := true;
      exit;
    end;

    // Lossy jpeg?
    if TransferSyntax = '1.2.840.10008.1.2.4.50' then
    begin
      tempParams := TIOParamsVals.Create(IOParams.ImageEnIO);
      try
        ReadJPegStream(Stream,nil,Bitmap,tempParams,Progress,false,false,false,false,true,true,-1,true);
      finally
        tempParams.Free;
      end;
      if SamplesPerPixel = 1 then
      begin
        AdjustRange8g(ctx);
        AdjustMonochrome8g(ctx);
      end;
      exit;
    end;

    // Lossy jpeg2000?
    {$ifdef IEINCLUDEJPEG2000}
    if TransferSyntax = '1.2.840.10008.1.2.4.91' then
    begin
      tempParams := TIOParamsVals.Create(IOParams.ImageEnIO);
      try
        J2KReadStream(Stream, Bitmap, tempParams, Progress, false);
      finally
        tempParams.Free;
      end;
      if SamplesPerPixel = 1 then
      begin
        AdjustRange8g(ctx);
        AdjustMonochrome8g(ctx);
      end;
      exit;
    end;
    {$endif}

    // Lossless jpeg?
    if (TransferSyntax = '1.2.840.10008.1.2.4.70') or (TransferSyntax = '1.2.840.10008.1.2.4.57') then
    begin
      if imageLength = 0 then
        imageLength := Stream.Size - Stream.Position;
      case SamplesPerPixel of

        1:
          begin
            // gray scale
            if BitsStored <= 8 then
            begin
              // up to 8 bit
              Bitmap.Allocate(Width, Height, ie8g);
              Bitmap.BitAlignment := 8;
              if DecodeJpeg(Stream, nil, Bitmap.Scanline[Height-1], imageLength, Progress.fOnProgress, Progress.Sender) then
              begin
                VerticalFlip(ctx);
                AdjustRange8g(ctx);
                AdjustMonochrome8g(ctx);
              end
              else
              begin
                Progress.Aborting^ := true;
                exit;
              end;
            end
            else if BitsStored<=16 then
            begin
              // up to 16 bit
              Bitmap.Allocate(Width, Height, ie16g);
              Bitmap.BitAlignment := 8;
              if DecodeJpeg(Stream, Bitmap.Scanline[Height-1], nil, imageLength, Progress.fOnProgress, Progress.Sender) then
              begin
                VerticalFlip(ctx);
                AdjustRange16g(ctx);
                AdjustMonochrome16g(ctx);
              end
              else
              begin
                Progress.Aborting^ := true;
                exit;
              end;
            end;

          end;
        3:
          begin
            // color
            if BitsStored <= 8 then
            begin
              // up to 8 bit
              Bitmap.Allocate(Width, Height, ie24RGB);
              Bitmap.BitAlignment := 8;
              if DecodeJpeg(Stream, nil, Bitmap.Scanline[Height-1], imageLength, Progress.fOnProgress, Progress.Sender) then
              begin
                VerticalFlip(ctx);
                //AdjustRange8g(ctx);
                //AdjustMonochrome8g(ctx);
                IEDisposeChannels(Bitmap, 'RGB', nil, nil);
              end
              else
              begin
                Progress.Aborting^ := true;
                exit;
              end;
            end;
          end;

      end;
      exit;
    end;

    // mpeg compression? Unsupported.
    if TransferSyntax = '1.2.840.10008.1.2.4.100' then
    begin
      Progress.Aborting^ := true;
      exit;
    end;

    // RLE compression?
    if TransferSyntax = '1.2.840.10008.1.2.5' then
    begin
      // read header
      base := Stream.Position;
      Stream.Read(dw, 4);  // used indexes?

      getmem(idx, sizeof(DWORD)*16);

      dec(imageLength, sizeof(DWORD)*16 + 4);

      try
        Stream.Read(idx[0], sizeof(DWORD)*16);

        if (SamplesPerPixel = 1) and (BitsStored <= 8) and (IEUpperCase(IETrim(PhotometricInterpretation)) = 'PALETTE COLOR') then
        begin
          // 8 bit RGB palette
          Bitmap.Allocate(Width, Height, ie24RGB);
          getmem(Buffer, Width*Height*4);
          try
            Stream.Position := base+idx[0];
            if imageLength + Stream.Position > Stream.Size then
            begin
              Progress.Aborting^ := true;
              exit;
            end;
            DecodeRLE(Stream, Buffer, Width*Height);
            pb2 := pbyte(Buffer);
            for row:=0 to Height-1 do
            begin
              p_rgb := Bitmap.Scanline[row];
              for col:=0 to Width-1 do
              begin
                p_rgb^.r := RMap[pb2^] div 257;
                p_rgb^.g := GMap[pb2^] div 257;
                p_rgb^.b := BMap[pb2^] div 257;
                inc(p_rgb);
                inc(pb2);
              end;
              DoProgress(row, Height);
            end;
          finally
            freemem(Buffer);
          end;
        end
        else if (SamplesPerPixel = 1) and (BitsStored <= 8) then
        begin
          // 8 bit gray scale
          Bitmap.Allocate(Width, Height, ie8g);
          getmem(Buffer, Width*Height*4);
          try
            // low byte
            Stream.Position := base+idx[0];
            if imageLength + Stream.Position > Stream.Size then
            begin
              Progress.Aborting^ := true;
              exit;
            end;
            DecodeRLE(Stream, Buffer, Width*Height);
            pb2 := pbyte(Buffer);
            for row:=0 to Height-1 do
            begin
              pb := Bitmap.Scanline[row];
              for col:=0 to Width-1 do
              begin
                pb^ := pb2^;
                inc(pb);
                inc(pb2);
              end;
              DoProgress(row, Height);
            end;
          finally
            freemem(Buffer);
          end;
          AdjustRange8g(ctx);
          AdjustMonochrome8g(ctx);
        end
        else if (SamplesPerPixel = 1) and (BitsStored <= 16) then
        begin
          // 16 bit gray scale
          Bitmap.Allocate(Width, Height, ie16g);
          getmem(Buffer, Width*Height*4);
          try
            // high byte
            Stream.Position := base+idx[0];
            if imageLength + Stream.Position > Stream.Size then
            begin
              Progress.Aborting^ := true;
              exit;
            end;
            DecodeRLE(Stream, Buffer, Width*Height);
            pb := pbyte(Buffer);
            for row:=0 to Height-1 do
            begin
              pw := Bitmap.Scanline[row];
              for col:=0 to Width-1 do
              begin
                pw^ := pb^ shl 8;
                inc(pw);
                inc(pb);
              end;
              DoProgress(row, Height);
            end;
            // low byte
            Stream.Position := base+idx[1];
            if imageLength + Stream.Position > Stream.Size then
            begin
              Progress.Aborting^ := true;
              exit;
            end;
            DecodeRLE(Stream, Buffer, Width*Height);
            pb := pbyte(Buffer);
            for row:=0 to Height-1 do
            begin
              pw := Bitmap.Scanline[row];
              for col:=0 to Width-1 do
              begin
                pw^ := pw^ or pb^;
                inc(pw);
                inc(pb);
              end;
            end;
          finally
            freemem(Buffer);
          end;
          AdjustRange16g(ctx);
          AdjustMonochrome16g(ctx);
        end
        else if (SamplesPerPixel = 3) and (BitsStored <= 8) then
        begin
          // 24 bit color
          Bitmap.Allocate(Width, Height, ie24RGB);
          getmem(Buffer, Width*Height);
          try
            for ch:=0 to 2 do  // loop channels
            begin
              Stream.Position := base + idx[ch];
              if imageLength + Stream.Position > Stream.Size then
              begin
                Progress.Aborting^ := true;
                exit;
              end;
              dec(imageLength, DecodeRLE(Stream, Buffer, Width*Height));
              pb2 := pbyte(Buffer);
              for row:=0 to Height-1 do
              begin
                pb := Bitmap.Scanline[row]; // select row
                inc(pb, 2-ch); // select channel
                for col:=0 to Width-1 do
                begin
                  pb^ := pb2^;
                  inc(pb, 3);
                  inc(pb2);
                end;
                DoProgress(row+ch*Height, Height*3);
              end;
            end;
          finally
            freemem(Buffer);
          end;
          AdjustRange8g(ctx);
          AdjustMonochrome8g(ctx);
        end

      finally
        freemem(idx);
      end;
      exit;
    end;

    if Stream.Position + Width * Height * (SamplesPerPixel * BitsStored div 8) > Stream.Size + 2 then
    begin
      Progress.Aborting^ := True;
      exit;
    end;

    // NO compression
    if SamplesPerPixel = 1 then
    begin
      // gray scale
      if BitsStored <= 8 then
      begin

        if Stream.Position + Width * Height  > Stream.Size + 2 then
        begin
          Progress.Aborting^ := True;
          exit;
        end;

        // up to 8 bit gray scale
        if (IEUpperCase(IETrim(PhotometricInterpretation)) = 'PALETTE COLOR') then
        begin
          // with palette
          Bitmap.Allocate(Width, Height, ie24RGB);
          for row:=0 to Height-1 do
          begin
            p_rgb := Bitmap.Scanline[row];
            for col:=0 to Width-1 do
            begin
              Stream.Read(bb, 1);
              bb := bb shl (8-BitsStored);
              p_rgb^.r := RMap[bb] div 257;
              p_rgb^.g := GMap[bb] div 257;
              p_rgb^.b := BMap[bb] div 257;
              inc(p_rgb);
            end;
            DoProgress(row, Height);
          end;
        end
        else
        begin
          Bitmap.Allocate(Width, Height, ie8g);
          for row:=0 to Height-1 do
          begin
            pb := Bitmap.Scanline[row];
            for col:=0 to Width-1 do
            begin
              Stream.Read(bb, 1);
              pb^ := bb shl (8-BitsStored);
              inc(pb);
              if BitsAllocated = 16 then
                Stream.Seek(1, soFromCurrent);
            end;
            DoProgress(row, Height);
          end;
          AdjustMonochrome8g(ctx);
        end
      end
      else if (BitsStored = 12) and (BitsAllocated = 12) and ((IEUpperCase(IETrim(PhotometricInterpretation)) <> 'PALETTE COLOR')) then
      begin
        // converted to 16 bit gray scale
        if Stream.Position + Width * Height * 1.5 > Stream.Size + 2 then
        begin
          Progress.Aborting^ := True;
          EXIT;
        end;

        // Gray scale
        Stream.Seek(-2, soCurrent);

        Bitmap.Allocate(Width, Height, ie16g);
        for row:=0 to Height-1 do
        begin
          pw := Bitmap.Scanline[row];
          col := 0;

          while col < Width do
          begin
            Stream.Read(b1, 1);
            Stream.Read(b2, 1);
            Stream.Read(b3, 1);

            pw^ := b1 + ((b2 and 15) shl 8);
            inc(pw);
            inc(col);

            pw^ := (b3 shl 4) + ((b2 and 240) shr 4);
            inc(pw);
            inc(col);
          end;

          DoProgress(row, Height);
        end;

        AdjustRange16g(ctx);
        AdjustMonochrome16g(ctx);

      end
      else if BitsStored <= 16 then
      begin
        // converted to 16 bit gray scale

        if Stream.Position + Width * Height * 2 > Stream.Size + 2 then
        begin
          Progress.Aborting^ := True;
          EXIT;
        end;

        if (IEUpperCase(IETrim(PhotometricInterpretation)) = 'PALETTE COLOR') then
        begin
          // with RGB palette
          Bitmap.Allocate(Width, Height, ie48RGB);
          for row:=0 to Height-1 do
          begin
            p_rgb48 := Bitmap.Scanline[row];
            for col:=0 to Width-1 do
            begin
              Stream.Read(ww, 2);
              ww := trunc( IECSwapWord(ww, not LittleEndian) );
              p_rgb48^.r := RMap[ww];
              p_rgb48^.g := GMap[ww];
              p_rgb48^.b := BMap[ww];
              inc(p_rgb48);
            end;
            DoProgress(row, Height);
          end;
        end
        else
        begin
          // Gray scale
          Bitmap.Allocate(Width, Height, ie16g);
          for row:=0 to Height-1 do
          begin
            pw:=Bitmap.Scanline[row];
            for col:=0 to Width-1 do
            begin
              Stream.Read(ww,2);
              pw^:=trunc( IECSwapWord(ww, not LittleEndian) );
              inc(pw);
            end;
            DoProgress(row, Height);
          end;
          AdjustRange16g(ctx);
          AdjustMonochrome16g(ctx);
        end;

      end;
    end;

    if (SamplesPerPixel = 3) and (PlanarConfiguration = 1) then
    begin
      // planar channels

      // 24 bit
      if BitsStored <= 8 then
      begin
        Bitmap.Allocate(Width, Height, ie24RGB);
        // R
        for row:=0 to Height-1 do
        begin
          pb := Bitmap.Scanline[row]; inc(pb, 2);
          for col:=0 to Width-1 do
          begin
            Stream.Read(bb, 1);
            pb^ := bb shl (8-BitsStored);
            inc(pb, 3);
          end;
          DoProgress(row div 3, Height);
        end;
        // G
        for row:=0 to Height-1 do
        begin
          pb := Bitmap.Scanline[row]; inc(pb, 1);
          for col:=0 to Width-1 do
          begin
            Stream.Read(bb, 1);
            pb^:=bb shl (8-BitsStored);
            inc(pb, 3);
          end;
          DoProgress(Height div 3 + row div 3, Height);
        end;
        // B
        for row:=0 to Height-1 do
        begin
          pb := Bitmap.Scanline[row];
          for col:=0 to Width-1 do
          begin
            Stream.Read(bb, 1);
            pb^ := bb shl (8-BitsStored);
            inc(pb, 3);
          end;
          DoProgress(Height div 3 *2 + row div 3, Height);
        end;
      end;

    end;

    if (SamplesPerPixel = 3) and (PlanarConfiguration = 0) then
    begin
      // interlaced channels

      // 24 bit
      if BitsStored<=8 then
      begin
        Bitmap.Allocate(Width,Height,ie24RGB);
        for row:=0 to Height-1 do
        begin
          pb:=Bitmap.Scanline[row];
          for col:=0 to Width-1 do
          begin
            Stream.Read(b1,1);  // B
            Stream.Read(b2,1);  // R
            Stream.Read(b3,1);  // G
            pb^:=1 * b1 shl (8-BitsStored); inc(pb);  // B
            pb^:=1 * b3 shl (8-BitsStored); inc(pb);  // G
            pb^:=1 * b2 shl (8-BitsStored); inc(pb);  // R
          end;
          DoProgress(row, Height);
        end;
      end;

    end;

  end;
end;

function IEStrToFloatDefExt(s:AnsiString; def:double):double;
var
  p:integer;
begin
  p:=IEPos('\',s);
  if p>0 then
    s:=IECopy(s,1,p-1);
  result:=IEStrToFloatDefA(s,def);
end;

// this function cannot detect DICOMs without the DICM tag, even IEDICOMRead can read them.
function IEDICOMTryStream(Stream:TStream):boolean;
var
  lpos:int64;
  MAGIK:AnsiString;
begin
  lpos:=Stream.Position;
  result:=false;
  try
    // bypass 128 bytes (Preamble)
    Stream.Seek(128, soCurrent);
    // look for 'DICM'
    SetLength(MAGIK,4);
    Stream.Read(MAGIK[1],4);
    if MAGIK='DICM' then
    begin
      result:=true;
      exit;
    end;
  finally
    Stream.Position:=lpos;
  end;
end;

function IEDICOMImageCount(Stream:TStream):integer;
var
  lpos:int64;
  nullrc:TProgressRec;
  abort:boolean;
  tempParams:TIOParamsVals;
begin
  lpos:=Stream.Position;
  result:=0;
  abort:=false;
  nullrc.fOnProgress := nil;
  nullrc.Sender := nil;
  nullrc.Aborting := @abort;
  tempParams:=TIOParamsVals.Create(nil);
  try
    IEDICOMRead(Stream,tempParams,nil,nullrc,true);
    if not abort then
      result:=tempParams.ImageCount;
  finally
    tempParams.Free;
    Stream.Position:=lpos;
  end;
end;

function IEDICOMImageCount(FileName:string):integer;
var
  fs:TFileStream;
begin
  fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    result := IEDICOMImageCount(fs);
  finally
    FreeAndNil(fs);
  end;
end;

procedure IEDICOMRead(Stream:TStream; Params:TIOParamsVals; DstBitmap:TIEBitmap; var xProgress: TProgressRec; Preview: boolean);
var
  ctx:TDICOMContext;
  MAGIK:AnsiString;
  Group,Element:word;
  exp_vr, vr:AnsiString;
  i,c:integer;
  lensize:integer;
  datasize:integer;
  itemsize:integer;
  itemcount:integer;
  data:PAnsiChar;
  dataint:integer;  // data as integer
  w1, w2:word;
  thumbPos, imagePos:int64;
  minPos, maxPos, midPos:integer;

  procedure GetImage;
  begin
    with ctx do
    begin
      IOParams.BitsPerSample:=BitsStored;
      IOParams.SamplesPerPixel:=SamplesPerPixel;
      IOParams.Width:=Width;
      IOParams.Height:=Height;
      IOParams.OriginalWidth:=Width;
      IOParams.OriginalHeight:=Height;
      IOParams.ImageCount:=FrameCount;
      if not Preview then
        ReadImage(ctx);
    end;
  end;

begin
  FillChar(ctx,sizeof(TDICOMContext),0);

  thumbPos := -1;
  imagePos := -1;

  ctx.IOParams := Params;

  if assigned(DstBitmap) and (DstBitmap.Location=ieTBitmap) then
    ctx.Bitmap := TIEBitmap.Create
  else
    ctx.Bitmap := DstBitmap;

  ctx.Stream := TIEBufferedReadStream.Create(Stream, 8192, iegUseRelativeStreams);
  ctx.Progress := xProgress;
  ctx.StreamSize := Stream.Size;
  ctx.LittleEndian := true;

  ctx.FrameCount := 1;
  ctx.SamplesPerPixel := 1;
  ctx.WindowCenter := -1;
  ctx.WindowWidth := -1;
  ctx.RescaleIntercept := 0;
  ctx.RescaleSlope := 1;

  with ctx do
  begin

    // bypass 128 bytes (Preamble)
    Stream.Seek(128, soCurrent);

    // look for 'DICM'
    SetLength(MAGIK,4);
    Stream.Read(MAGIK[1], 4);
    if MAGIK <> 'DICM' then
    begin
      // implicit dicom
      Stream.Seek(-(128+4), soCurrent);  // return to start
      Implicit := true;
    end
    else
    begin
      // explicit dicom
      Implicit := false;
    end;

    // read tags
    while Stream.Position < StreamSize do
    begin

      Group := ReadWord(ctx,false);
      Element := ReadWord(ctx,false);

      if (Group<>$2) and not LittleEndian then
      begin
        Group := IESwapWord(Group);
        Element := IESwapWord(Element);
      end;

      // binsearch for implicit vr
      vr := TagInfo[TagInfoSize-1].vr;
      minPos := 0;
      maxPos := TagInfoSize-1;
      repeat
        midPos := (minPos + maxPos) div 2;
        if (Group > TagInfo[midPos].Group) or ((Group = TagInfo[midPos].Group) and (Element > TagInfo[midPos].Element)) then
          minPos := midPos + 1
        else
          maxPos := midPos - 1;
      until ((TagInfo[midPos].Group = Group) and (TagInfo[midPos].Element = Element)) or (minPos > maxPos);
      if (TagInfo[midPos].Group = Group) and (TagInfo[midPos].Element = Element) then
        vr := TagInfo[midPos].vr;

      // load explicit vr (also if it is not available)
      SetLength(exp_vr, 2);
      Stream.Read(exp_vr[1], 2);

      // search for vr
      if (Group=$0002) or (IsUpper(exp_vr[1]) and IsUpper(exp_vr[2])) then
      begin
        // vr is explicit
        if vr = 'xs' then
          vr := exp_vr;
        if vr = '!!' then
        begin
          Stream.Seek(-2, soCurrent);
          lensize := 4;
        end
        else
        begin
          lensize := 2;
          if (exp_vr='OB') or (exp_vr='UN') or (exp_vr='OW') or (exp_vr='SQ') then
          begin
            Stream.Seek(2, soCurrent); // bypass two unused
            lensize:=4;
          end;
        end;
      end
      else
      begin
        Stream.Seek(-2, soCurrent);
        lensize:=4;
      end;

      // read data size in bytes
      datasize:=0;
      if lensize=1 then
        datasize:=ReadByte(ctx)
      else if lensize=2 then
        datasize:=ReadWord(ctx,(Group<>$2) and not LittleEndian)
      else if lensize=4 then
        datasize:=ReadDWord(ctx,(Group<>$2) and not LittleEndian);

      // calculate item size and items count
      itemsize:=0;
      itemcount:=1;
      if datasize>0 then
      begin
        if (vr='SS') or (vr='US') then
          itemsize:=2
        else if (vr='UL') or (vr='SL') or (vr='FL') then
          itemsize:=4
        else if (vr<>'FD') then
          itemsize:=1
        else
          itemsize:=8;
        itemcount:=datasize div itemsize;
      end
      else if datasize<0 then
      begin
        // undefined size
        itemsize:=0;
        itemcount:=0;
      end;

      // found image tag, read it
      if (Group=$7FE0) and (Element=$0010) then
      begin
        // check for thumbnail
        Stream.Read(w1,2);
        Stream.Read(w2,2);
        Stream.Seek(-4, soCurrent);
        if (w1=$D8FF) and (w2=$E0FF) then
        begin
          // is this a thumbnail? Store position and bypass
          thumbPos := Stream.Position;
        end
        else
        begin
          imagePos := Stream.Position;
          GetImage;
          break;
        end;
      end;

      // read tag data
      data:=nil;
      dataint:=0;
      if (datasize>0) and (datasize<StreamSize) then
      begin
        if itemcount=1 then
        begin
          case itemsize of
            1: begin dataint := ReadByte(ctx); Stream.Seek(-1, soCurrent); end;
            2: begin dataint := ReadWord(ctx,(Group<>$2) and not LittleEndian); Stream.Seek(-2, soCurrent); end;
            4: begin dataint := ReadDWord(ctx,(Group<>$2) and not LittleEndian); Stream.Seek(-4, soCurrent); end;
          end;
        end;
        getmem(data,datasize+1);
        Stream.Read(data^,datasize);
        data[itemsize*itemcount]:=#0;
      end;

      IOParams.DICOM_Tags.AddTag(Group,Element,vr,data,datasize);

      case group of

        $0002:

          case element of
            $0010:  // Tansfer Syntax
              begin
                TransferSyntax:=strpas(data);
                if TransferSyntax='1.2.840.10008.1.2.2' then
                  LittleEndian:=false;
              end;
          end;

        $0028:

          case element of
            $0002:  // Samples per Pixel
              SamplesPerPixel:=dataint;
            $0004:  // photometric interpretation
              PhotometricInterpretation:=strpas(data);
            $0006:  // planar configuration
              PlanarConfiguration:=dataint;
            $0008:  // Frame count
              FrameCount:=IEStrToIntDef( IETrim(AnsiString(data)), 1 );
            $0010:  // Height
              Height:=dataint;
            $0011:  // Width
              Width:=dataint;
            $0100:  // Bits allocated
              begin
                BitsAllocated:=dataint;
                i:=IEBitmapRowLen(1,BitsAllocated,8);
                BytesPerChannel:=imax(BytesPerChannel,i);
                if BitsStored=0 then
                  BitsStored:=BitsAllocated;
              end;
            $0101:  // Bits stored
              begin
                BitsStored:=dataint;
                i:=IEBitmapRowLen(1,BitsStored,8);
                BytesPerChannel:=imax(BytesPerChannel,i);
                if BitsAllocated=0 then
                  BitsAllocated:=BitsStored;
              end;
            $0103:  // Pixel representation (signed or unsigned)
              PixelRepresentation:=dataint;
            $1050:  // Window Center
              begin
                WindowCenter:=IEStrToFloatDefExt(strpas(data),-1);
                if WindowCenter=0 then  // 3.0.0
                  WindowCenter:=-1;
              end;
            $1051:  // Window Width
              WindowWidth:=IEStrToFloatDefExt(strpas(data),-1);
            $1052:  // Rescale intercept
              RescaleIntercept:=IEStrToFloatDefExt(strpas(data),-1);
            $1053:  // Rescale slope
              RescaleSlope:=IEStrToFloatDefExt(strpas(data),-1);
            $1201:  // Red Color Map
              begin
                c:=1 shl BitsAllocated;
                getmem(RMap,c*sizeof(word));
                for i:=0 to c-1 do
                  RMap[i] := IECSwapWord( pwordarray(data)[i], not LittleEndian );
              end;
            $1202:  // Green Color Map
              begin
                c:=1 shl BitsAllocated;
                getmem(GMap,c*sizeof(word));
                for i:=0 to c-1 do
                  GMap[i] := IECSwapWord( pwordarray(data)[i], not LittleEndian );
              end;
            $1203:  // Blue Color Map
              begin
                c:=1 shl BitsAllocated;
                getmem(BMap,c*sizeof(word));
                for i:=0 to c-1 do
                  BMap[i] := IECSwapWord( pwordarray(data)[i], not LittleEndian );
              end;
            $3006:  // Gray Map
              begin
                if data<>nil then
                begin
                  // todo...
                  (*
                  c:=1 shl BitsAllocated;
                  getmem(GrayMap,c*sizeof(byte));
                  CopyMemory(GrayMap,data,c*sizeof(byte));
                  *)
                end;
              end;
          end;

      end;  // End of "group" cases

    end;  // End of read tags loop

    if (imagePos=-1) and (thumbPos>-1) then
    begin
      ctx.Stream.Position := thumbPos;
      GetImage;
    end;

    if DstBitmap<>Bitmap then
    begin
      if not Bitmap.IsEmpty() then
      begin
        if Bitmap.PixelFormat<>ie1g then
          Bitmap.PixelFormat := ie24RGB;
        DstBitmap.Assign( Bitmap );
      end;
      Bitmap.Free;
    end;

    IOParams.ImageCount := FrameCount;

    // free allocated buffers
    if assigned(RMap) then
      freemem(RMap);
    if assigned(GMap) then
      freemem(GMap);
    if assigned(BMap) then
      freemem(BMap);
    if assigned(GrayMap) then
      freemem(GrayMap);
    // others
    Stream.Free;

  end;  // End of ctx context

end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Lossless jpeg

function DecodeJPEG(lStream: TStream; lOutSmallRA: PIESmallIntArray; lImgRAz: PByteArray; lCptSize: integer; OnProgress:TIEProgressEvent; Sender:TObject):boolean;
type
  ByteRA = array[1..1] of byte;
  Bytep = ^ByteRA;
  WordRA = array[1..1] of Word;
  Wordp = ^WordRA;
  HufRA = record
    HufSz, HufCode, HufVal: Integer;
  end;
const
  kmaxFrames = 4;
var
  lRawRA: bytep;
  lImgRA: WordP;
  lHufVal, lAbba, lOffset, lLineStart, lPredicted, lPredictedG, lPredictedB, lRestartSegmentSz,
    lSz, k, Code, Si, lIncX, lIncY, lInc, lPredA, lPredB, lPredC, lCurrentBitPos, btS1, btS2, btMarkerType,
    DHTnLi, DHTtcth, SOFprecision, SOSpttrans, SOFnf, SOFarrayPos, SOSns, SOSarrayPos, SOSss, SOSse, SOSahal: integer;
  lHufTable, lnHufTables, lImgStart, lRawSz, lRawPos, lItems, SOFydim, SOFxdim: integer;
  lMaxHufSi, lMaxHufVal: array[1..kmaxFrames] of integer;
  DHTLiRA, DHTstartRA: array[1..kmaxFrames, 0..31] of integer;
  lBitMask: array[1..17] of integer;
  lSSSSszRA: array[1..kMaxFrames, 0..17] of byte;
  lLookUpRA: array[1..kMaxFrames, 0..255] of byte;
  lHufRA: array[1..kMaxFrames, 0..31] of HufRA;
  lFrameCount, lSegmentLength, lSegmentEnd, lI: integer;
  lImgTypeC3, lHdrOK: boolean;
  lpos:integer;

  function ReadBit: integer;
  begin
    result := (lRawRA[lRawPos] shr (7 - lCurrentBitPos)) and 1;
    lCurrentBitPos := lCurrentBitPos + 1;
    if (lCurrentBitPos = 8) then
    begin
      lRawPos := 1 + lRawPos;
      lCurrentBitPos := 0;
    end;
  end;

  function ReadBits(lNum: integer): integer;
  var
    p:integer;
  begin
    if assigned(OnProgress) then
    begin
      p := trunc(lRawPos/lRawSz*100);
      if p<>lpos then
      begin
        OnProgress(Sender, p);
        lpos := p;
      end;
    end;
    result := lRawRA[lRawPos];
    result := result shl 8 + lRawRA[lRawPos + 1];
    result := result shl 8 + lRawRA[lRawPos + 2];
    result := (result shr (24 - lCurrentBitPos - lNum)) and lBitMask[lNum];
    lCurrentBitPos := lCurrentBitPos + lNum;
    if (lCurrentBitPos > 7) then
    begin
      lRawPos := lRawPos + (lCurrentBitPos shr 3);
      lCurrentBitPos := (lCurrentBitPos and 7 );
    end;
  end;

  function DecodePixelDifference(lFrame: integer): integer;
  var
    lByte, lHufValSSSS, lInput, lInputbits, lDiff, lI: integer;
  begin
    lByte := (lRawRA[lRawPos] shl lCurrentBitPos) + (lRawRA[lRawPos + 1] shr (8 - lCurrentBitPos));
    lByte := lByte and 255;
    lHufValSSSS := lLookUpRA[lFrame, lByte];
    if lHufValSSSS < 255 then
    begin
      lCurrentBitPos := lSSSSszRA[lFrame, lHufValSSSS] + lCurrentBitPos;
      lRawPos := lRawPos + (lCurrentBitpos shr 3);
      lCurrentBitpos := lCurrentBitpos and 7;
    end
    else
    begin
      lInput := lByte;
      lInputBits := 8;
      inc(lRawPos);
      repeat
        Inc(lInputBits);
        lInput := lInput shl 1 + ReadBit;
        if DHTLiRA[lFrame, lInputBits] <> 0 then
        begin
          for lI := DHTstartRA[lFrame, lInputBits] to (DHTstartRA[lFrame, lInputBits] + DHTLiRA[lFrame, lInputBits] - 1) do
          begin
            if (lInput = lHufRA[lFrame, lI].HufCode) then
              lHufValSSSS := lHufRA[lFrame, lI].HufVal;
          end;
        end;
        if (lInputBits >= lMaxHufSi[lFrame]) and (lHufValSSSS > 254) then
        begin
          lHufValSSSS := lMaxHufVal[lFrame];
        end;
      until (lHufValSSSS < 255);
    end;
    case lHufValSSSS of
      0: result := 0;
      1: if ReadBit = 0 then
          result := -1
        else
          result := 1;
      2..15:
        begin
          lDiff := ReadBits(lHufValSSSS);
          if (lDiff > (lBitMask[lHufValSSSS - 1])) then
            result := lDiff
          else
            result := lDiff - lBitMask[lHufValSSSS];
        end;
    else
      result := 32768;
    end;
  end;

  procedure ReadByte(var lByte: integer);
  begin
    inc(lRawPos);
    lByte := lRawRA[lRawPos];
  end;

  function ReadWord: word;
  var
    lbtL1, lbtL2: byte;
  begin
    inc(lRawPos);
    lbtL1 := lRawRA[lRawPos];
    inc(lRawPos);
    lbtL2 := lRawRA[lRawPos];
    result := (256 * lbtL1 + lbtL2)
  end;

begin
  result:=true;
  lpos := -1;
  lAbba := 4;
  lnHufTables := 0;
  lRawSz := lCptSize;
  lRawPos := 0;
  lRestartSegmentSz := 0;
  lImgTypeC3 := false;
  SOFxdim := 1;
  if lRawSz < 32 then
  begin
    result := false;
    exit;
  end;

  for lFrameCount := 1 to kMaxFrames do
    for lInc := 1 to 16 do
      DHTstartRA[lFrameCount, lInc] := 0;
  SOFydim := 1;
  SOSpttrans := 0;
  lHdrOK := false;
  SOFnf := 0;
  SOSns := 0;
  GetMem(lRawRA, lRawSz);
  try
    lStream.readBuffer(lRawRA^, lRawSz);
    ReadByte(btS1);
    ReadByte(btS1);
    repeat
      repeat

        if lRawPos <= lRawSz then
          ReadByte(btS1);
        if btS1 <> $FF then
        begin
          result := false;
          exit;
        end;
        if lRawPos <= lRawSz then
          ReadByte(btMarkerType);
        case btMarkerType of
          $0, $1, $D0..$D7, $FF: btMarkerType := 0;
        end;
      until (lRawPos >= lRawSz) or (btMarkerType <> 0);
      lSegmentLength := ReadWord;
      lSegmentEnd := lRawPos + (lSegmentLength - 2);
      if lSegmentEnd > lRawSz then
      begin
        result := false;
        exit;
      end;
      if (btMarkerType = $C3) then
        lImgTypeC3 := true;
      case btMarkerType of
        $0: ;
        $C0..$C3, $C5..$CB, $CD..$CF:
          begin
            ReadByte(SOFprecision);
            SOFydim := ReadWord;
            SOFxdim := ReadWord;
            ReadByte(SOFnf);
            SOFarrayPos := lRawPos;
            lRawPos := (lSegmentEnd);
          end;
        $C4:
          begin
            lFrameCount := 1;
            repeat
              ReadByte(DHTtcth);
              DHTnLi := 0;
              for lInc := 1 to 16 do
              begin
                ReadByte(DHTliRA[lFrameCount, lInc]);
                DHTnLi := DHTnLi + DHTliRA[lFrameCount, lInc];
                if DHTliRA[lFrameCount, lInc] <> 0 then
                  lMaxHufSi[lFrameCount] := lInc;
              end;
              if DHTnLi > 17 then
              begin
                result := false;
                exit;
              end;
              lIncY := 0;

              for lInc := 0 to 31 do
              begin
                lHufRA[lFrameCount, lInc].HufVal := -1;
                lHufRA[lFrameCount, lInc].HufSz := -1;
                lHufRA[lFrameCount, lInc].HufCode := -1;
              end;

              for lInc := 1 to 16 do
              begin
                if DHTliRA[lFrameCount, lInc] > 0 then
                begin
                  DHTstartRA[lFrameCount, lInc] := lIncY + 1;
                  for lIncX := 1 to DHTliRA[lFrameCount, lInc] do
                  begin
                    inc(lIncY);
                    ReadByte(btS1);
                    lHufRA[lFrameCount, lIncY].HufVal := btS1;
                    lMaxHufVal[lFrameCount] := btS1;
                    if (btS1 >= 0) and (btS1 <= 16) then
                      lHufRA[lFrameCount, lIncY].HufSz := lInc
                    else
                    begin
                      result := false;
                      exit;
                    end;
                  end;
                end;
              end;
              K := 1;
              Code := 0;
              Si := lHufRA[lFrameCount, K].HufSz;
              repeat
                while (Si = lHufRA[lFrameCount, K].HufSz) do
                begin
                  lHufRA[lFrameCount, K].HufCode := Code;
                  Code := Code + 1;
                  Inc(K);
                end;
                if K <= DHTnLi then
                begin
                  while lHufRA[lFrameCount, K].HufSz > Si do
                  begin
                    Code := Code shl 1;
                    Si := Si + 1;
                  end;
                end;
              until K > DHTnLi;
              inc(lFrameCount);
            until (lSegmentEnd - lRawPos) < 18;
            lnHufTables := lFrameCount - 1;
            lRawPos := (lSegmentEnd);
          end;
        $DD:
          begin
            lRestartSegmentSz := Readword;
            lRawPos := (lSegmentEnd);
          end;
        $DA:
          begin
            if SOSns > 0 then
            begin
              result := false;
              exit;
            end;
            ReadByte(SOSns);
            SOSarrayPos := lRawPos;
            if SOSns > 0 then
            begin
              for lInc := 1 to SOSns do
              begin
                ReadByte(btS1);
                ReadByte(btS2);
              end;
            end;
            ReadByte(SOSss);
            ReadByte(SOSse);
            ReadByte(SOSahal);
            SOSpttrans := SOSahal and 16;
            lRawPos := (lSegmentEnd);
          end;
      else
        begin
          lRawPos := (lSegmentEnd);
        end;
      end;
    until (lRawPos >= lRawSz) or (btMarkerType = $DA);

    lHdrOK := true;
    lImgStart := lRawPos;

    if (not lImgTypeC3) then
      exit;

    lINc := lRawPos;
    lIncX := lRawPos;
    repeat
      lRawRA[lIncX] := lRawRA[lInc];
      if lRawRA[lInc] = 255 then
      begin
        if (lRawRA[lInc + 1] = $00) then
          lInc := lInc + 1
        else
        begin
          if (lRawRA[lInc + 1] = $D9) then
            lIncX := -666;
        end;
      end;
      inc(lInc);
      inc(lIncX);
    until lIncX < 0;
    lBitMask[1] := 1;
    lBitMask[2] := 3;
    lBitMask[3] := 7;
    lBitMask[4] := 15;
    lBitMask[5] := 31;
    lBitMask[6] := 63;
    lBitMask[7] := 127;
    lBitMask[8] := 255;
    lBitMask[9] := 511;
    lBitMask[10] := 1023;
    lBitMask[11] := 2047;
    lBitMask[12] := 4095;
    lBitMask[13] := 8191;
    lBitMask[14] := 16383;
    lBitMask[15] := 32767;
    lBitMask[16] := 65535;
    lBitMask[17] := 131071;
    if (lnHufTables < SOFnf) then
    begin
      if lnHufTables < 1 then
      begin
        result:=false;
        exit;
      end;

      for lFrameCount := 2 to SOFnf do
      begin
        for lInc := 1 to 16 do
          DHTstartRA[lFrameCount, lInc] := DHTstartRA[1, lInc];

        for lInc := 0 to 31 do
        begin
          lHufRA[lFrameCount, lInc].HufCode := lHufRA[1, lInc].HufCode;
          lHufRA[lFrameCount, lInc].HufVal := lHufRA[1, lInc].HufVal;
          lHufRA[lFrameCount, lInc].HufSz := lHufRA[1, lInc].HufSz;
          DHTliRA[lFrameCount, lInc] := DHTliRA[1, lInc];
        end;
      end;
    end;
    for lFrameCount := 1 to kMaxFrames do
      for lInc := 0 to 17 do
        lSSSSszRA[lFrameCount, lInc] := 123;
    for lFrameCount := 1 to kMaxFrames do
      for lInc := 0 to 255 do
        lLookUpRA[lFrameCount, lInc] := 255;
    for lFrameCount := 1 to SOFnf do
    begin
      lIncY := 0;
      for lSz := 1 to 8 do
      begin
        if DHTliRA[lFrameCount, lSz] > 0 then
        begin
          for lIncX := 1 to DHTliRA[lFrameCount, lSz] do
          begin
            inc(lIncY);
            lHufVal := lHufRA[lFrameCount, lIncY].HufVal;
            lSSSSszRA[lFrameCount, lHufVal] := lSz;
            k := (lHufRA[lFrameCount, lIncY].HufCode shl (8 - lSz)) and 255;
            if lSz < 8 then
            begin
              lInc := lBitMask[8 - lSz];
              for lCurrentBitPos := 0 to lInc do
              begin
                lLookUpRA[lFrameCount, k + lCurrentBitPos] := lHufVal;
              end;
            end
            else
              lLookUpRA[lFrameCount, k] := lHufVal;

          end;
        end;
      end;
    end;
    SOFxdim := SOFnf * SOFxdim;
    inc(lRawPos);
    lCurrentBitPos := 0;
    lItems := SOFxdim * SOFydim;
    lPredicted := 1 shl (SOFPrecision - 1 - SOSpttrans);
    lInc := 0;
    if (SOFPrecision <> 8) then
    begin
      lImgRA := @lOutSmallRA[0]; // set to 1 for MRIcro, else 0
      FillChar(lImgRA^, lItems * sizeof(word), 0);
      lPredB := 0;
      lPredC := 0;
      case SOSss of
        2: lPredA := SOFxDim - 1;
        3: lPredA := SOFxDim;
        4, 5:
          begin
            lPredA := 0;
            lPredB := SOFxDim - 1;
            lPredC := SOFxDim;
          end;
        6:
          begin
            lPredB := 0;
            lPredA := SOFxDim - 1;
            lPredC := SOFxDim;
          end;
      else
        lPredA := 0;
      end;
      for lIncX := 1 to SOFxdim do
      begin
        inc(lInc);
        if lInc > 1 then
          lPredicted := lImgRA[lInc - 1];
        lImgRA[lInc] := lPredicted + DecodePixelDifference(1);
      end;
      if lRestartSegmentSz = 0 then
      begin
        for lIncY := 2 to SOFyDim do
        begin
          inc(lInc);
          lPredicted := lImgRA[lInc - SOFxdim];
          lImgRA[lInc] := lPredicted + DecodePixelDifference(1);
          if SOSss = 4 then
          begin
            for lIncX := 2 to SOFxdim do
            begin
              lPredicted := lImgRA[lInc - lPredA] + lImgRA[lInc - lPredB] - lImgRA[lInc - lPredC];
              inc(lInc);
              lImgRA[lInc] := lPredicted + DecodePixelDifference(1);
            end;
          end
          else if (SOSss = 5) or (SOSss = 6) then
          begin
            for lIncX := 2 to SOFxdim do
            begin
              lPredicted := lImgRA[lInc - lPredA] + ((lImgRA[lInc - lPredB] - lImgRA[lInc - lPredC]) shr 1);
              inc(lInc);
              lImgRA[lInc] := lPredicted + DecodePixelDifference(1);
            end;
          end
          else if SOSss = 7 then
          begin
            for lIncX := 2 to SOFxdim do
            begin
              inc(lInc);
              lPredicted := (lImgRA[lInc - 1] + lImgRA[lInc - SOFxdim]) shr 1;
              lImgRA[lInc] := lPredicted + DecodePixelDifference(1);
            end;
          end
          else
          begin
            for lIncX := 2 to SOFxdim do
            begin
              lPredicted := lImgRA[lInc - lPredA];
              inc(lInc);
              lImgRA[lInc] := lPredicted + DecodePixelDifference(1);
            end;
          end;

        end;
      end
      else
      begin
        lSegmentEnd := lRestartSegmentSz;
        repeat
          if lSegmentEnd > lItems then
            lSegmentEnd := lItems;
          lLineStart := (((lInc div SOFxDim) + 1) * SOFxDim);
          if lInc > (SOFxDim + 1) then
            lPredicted := 1 shl (SOFPrecision - 1 - SOSpttrans)
          else
            lPredicted := lImgRA[lInc - SOFxdim];

          while lInc < lSegmentEnd do
          begin
            lImgRA[lInc] := lPredicted + DecodePixelDifference(1);
            if lInc + 1 = lLineStart then
            begin
              lPredicted := lImgRA[lInc + 1 - SOFxdim];
              lLineStart := lLineStart + SOFxDim;
            end
            else
              lPredicted := lImgRA[lInc - lPredA];
            inc(lInc);
          end;
          if (lSegmentEnd + 1) < lItems then
          begin
            dec(lRawPos);
            repeat
              while (lRawRA[lRawPos] <> 255) do
                inc(lRawPos);
              inc(lRawPos);
            until (lRawRA[lRawPos] >= $D0) and (lRawRA[lRawPos] <= $D7);
            lCurrentBitPos := 0;
            inc(lRawPos);
          end;
          lSegmentEnd := lSegmentEnd + lRestartSegmentSz;
        until (lRestartSegmentSz < 1) or ((lSegmentEnd - 2) > lItems);
      end;
    end
    else if SOFnf = 3 then
    begin
      lPredB := 0;
      lPredC := 0;
      case SOSss of
        2: lPredA := SOFxDim - 3;
        3: lPredA := SOFxDim;
        5:
          begin
            lPredA := 0;
            lPredB := SOFxDim - 3;
            lPredC := SOFxDim;
          end;
        6:
          begin
            lPredB := 0;
            lPredA := SOFxDim - 3;
            lPredC := SOFxDim;
          end;
      else
        lPredA := 0;
      end;
      lPredictedG := lPredicted;
      lPredictedB := lPredicted;
      lOffset := 0;
      lInc := lOffset;
      for lIncX := 1 to (SOFxdim div 3) do
      begin
        lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
        lPredicted := lImgRAz[lInc];
        inc(lInc);
        lImgRAz[lInc] := lPredictedG + DecodePixelDifference(2);
        lPredictedG := lImgRAz[lInc];
        inc(lInc);
        lImgRAz[lInc] := lPredictedB + DecodePixelDifference(3);
        lPredictedB := lImgRAz[lInc];
        inc(lInc);
      end;
      if lRestartSegmentSz = 0 then
        lSegmentEnd := lItems
      else
        lSegmentEnd := lRestartSegmentSz;
      repeat
        if lSegmentEnd > lItems then
          lSegmentEnd := lItems;
        lLineStart := (((lInc div SOFxDim) + 1) * SOFxDim) + lOffset;
        if lInc > (SOFxDim + 1) then
        begin
          lPredicted := 1 shl (SOFPrecision - 1 - SOSpttrans);
          lPredictedG := lPredicted;
          lPredictedB := lPredicted;
        end
        else
        begin
          lPredicted := lImgRAz[lInc - SOFxdim + lOffset];
          lPredictedG := lImgRAz[1 + lInc - SOFxdim + lOffset];
          lPredictedB := lImgRAz[2 + lInc - SOFxdim + lOffset];
        end;
        if SOSss = 4 then
        begin
          while lInc < (lSegmentEnd - 1) do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            inc(lInc);
            lImgRAz[lInc] := lPredictedG + DecodePixelDifference(2);
            inc(lInc);
            lImgRAz[lInc] := lPredictedB + DecodePixelDifference(3);
            inc(lInc);
            if lInc = lLineStart then
            begin
              lPredicted := lImgRAz[lInc - SOFxdim];
              lPredictedG := lImgRAz[lInc - SOFxdim + 1];
              lPredictedB := lImgRAz[lInc - SOFxdim + 2];
              lLineStart := lLineStart + (SOFxDim);
            end
            else
            begin
              lPredicted := lImgRAz[lInc - 3] + lImgRAz[lInc - 3 - (SOFxDim - 3)] - lImgRAz[lInc - 3 - SOFxDim];
              lPredictedG := lImgRAz[lInc - 2] + lImgRAz[lInc - 2 - (SOFxDim - 3)] - lImgRAz[lInc - 2 - SOFxDim];
              lPredictedB := lImgRAz[lInc - 1] + lImgRAz[lInc - 1 - (SOFxDim - 3)] - lImgRAz[lInc - 1 - SOFxDim];
            end;
          end;
        end
        else if (SOSss = 5) or (SOSss = 6) then
        begin
          while lInc < (lSegmentEnd - 1) do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            inc(lInc);
            lImgRAz[lInc] := lPredictedG + DecodePixelDifference(2);
            inc(lInc);
            lImgRAz[lInc] := lPredictedB + DecodePixelDifference(3);
            inc(lInc);
            if lInc = lLineStart then
            begin
              lPredicted := lImgRAz[lInc - SOFxdim];
              lPredictedG := lImgRAz[lInc - SOFxdim + 1];
              lPredictedB := lImgRAz[lInc - SOFxdim + 2];
              lLineStart := lLineStart + (SOFxDim);
            end
            else
            begin
              lPredicted := lImgRAz[lInc - 3 - lPredA] + ((lImgRAz[lInc - 3 - lPredB] - lImgRAz[lInc - 3 - lPredC]) shr 1);
              lPredictedG := lImgRAz[lInc - 2 - lPredA] + ((lImgRAz[lInc - 2 - lPredB] - lImgRAz[lInc - 2 - lPredC]) shr 1);
              lPredictedB := lImgRAz[lInc - 1 - lPredA] + ((lImgRAz[lInc - 1 - lPredB] - lImgRAz[lInc - 1 - lPredC]) shr 1);
            end;
          end;
        end
        else if SOSss = 7 then
        begin
          while lInc < (lSegmentEnd - 1) do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            inc(lInc);
            lImgRAz[lInc] := lPredictedG + DecodePixelDifference(2);
            inc(lInc);
            lImgRAz[lInc] := lPredictedB + DecodePixelDifference(3);
            inc(lInc);
            if lInc = lLineStart then
            begin
              lPredicted := lImgRAz[lInc - SOFxdim];
              lPredictedG := lImgRAz[lInc - SOFxdim + 1];
              lPredictedB := lImgRAz[lInc - SOFxdim + 2];
              lLineStart := lLineStart + (SOFxDim);
            end
            else
            begin
              lPredicted := (lImgRAz[lInc - 3] + lImgRAz[lInc - 3 - (SOFxDim - 3)]) shr 1;
              lPredictedG := (lImgRAz[lInc - 2] + lImgRAz[lInc - 2 - (SOFxDim - 3)]) shr 1;
              lPredictedB := (lImgRAz[lInc - 1] + lImgRAz[lInc - 1 - (SOFxDim - 3)]) shr 1;
            end;
          end;

        end
        else
        begin
          while lInc < (lSegmentEnd - 1) do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            inc(lInc);
            lImgRAz[lInc] := lPredictedG + DecodePixelDifference(2);
            inc(lInc);
            lImgRAz[lInc] := lPredictedB + DecodePixelDifference(3);
            inc(lInc);
            if lInc = lLineStart then
            begin
              lPredicted := lImgRAz[lInc - SOFxdim];
              lPredictedG := lImgRAz[lInc - SOFxdim + 1];
              lPredictedB := lImgRAz[lInc - SOFxdim + 2];
              lLineStart := lLineStart + (SOFxDim);
            end
            else
            begin
              lPredicted := lImgRAz[lInc - 3 - lPredA];
              lPredictedG := lImgRAz[lInc - 2 - lPredA];
              lPredictedB := lImgRAz[lInc - 1 - lPredA];
            end;
          end;
        end;
      until (lRestartSegmentSz < 1) or ((lSegmentEnd - 2) > lItems);
    end
    else
    begin
      lInc := 0;
      lPredB := 0;
      lPredC := 0;
      case SOSss of
        2: lPredA := SOFxDim - 1;
        3: lPredA := SOFxDim;
        5:
          begin
            lPredA := 0;
            lPredB := SOFxDim - 1;
            lPredC := SOFxDim;
          end;
        6:
          begin
            lPredB := 0;
            lPredA := SOFxDim - 1;
            lPredC := SOFxDim;
          end;
      else
        lPredA := 0;
      end;
      for lIncX := 1 to SOFxdim do
      begin
        lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
        inc(lInc);
        lPredicted := lImgRAz[lInc - 1];
      end;
      if lRestartSegmentSz = 0 then
        lSegmentEnd := lItems
      else
        lSegmentEnd := lRestartSegmentSz;
      repeat
        if lSegmentEnd > lItems then
          lSegmentEnd := lItems;
        lLineStart := (((lInc div SOFxDim) + 1) * SOFxDim);
        if lInc > (SOFxDim + 1) then
          lPredicted := 1 shl (SOFPrecision - 1 - SOSpttrans)
        else
          lPredicted := lImgRAz[lInc - SOFxdim];
        if SOSss = 4 then
        begin
          while lInc < lSegmentEnd do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            if lInc + 1 = lLineStart then
            begin
              lPredicted := lImgRAz[lInc + 1 - SOFxdim];
              lLineStart := lLineStart + SOFxDim;
            end
            else
              lPredicted := lImgRAz[lInc] + lImgRAz[lInc - (SOFxDim - 1)] - lImgRAz[lInc - SOFxDim];
            inc(lInc);
          end;

        end
        else if (SOSss = 5) or (SOSss = 6) then
        begin
          while lInc < lSegmentEnd do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            if lInc + 1 = lLineStart then
            begin
              lPredicted := lImgRAz[lInc + 1 - SOFxdim];
              lLineStart := lLineStart + SOFxDim;
            end
            else
              lPredicted := lImgRAz[lInc - lPredA] + ((lImgRAz[lInc - lPredB] - lImgRAz[lInc - lPredC]) shr 1);
            inc(lInc);
          end;
        end
        else if SOSss = 7 then
        begin
          while lInc < lSegmentEnd do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            if lInc + 1 = lLineStart then
              lLineStart := lLineStart + SOFxDim
            else
              lPredA := lImgRAz[lInc];
            lPredB := lImgRAz[lInc - SOFxDim + 1];
            lPredicted := (lPredA + lPredB) shr 1;
            inc(lInc);
          end;
        end
        else
        begin
          while lInc < lSegmentEnd do
          begin
            lImgRAz[lInc] := lPredicted + DecodePixelDifference(1);
            if lInc + 1 = lLineStart then
            begin
              lPredicted := lImgRAz[lInc + 1 - SOFxdim];
              lLineStart := lLineStart + SOFxDim;
            end
            else
              lPredicted := lImgRAz[lInc - lPredA];
            inc(lInc);
          end;
        end;
        if (lSegmentEnd + 1) < lItems then
        begin
          dec(lRawPos);
          repeat
            while (lRawRA[lRawPos] <> 255) do
              inc(lRawPos);
            inc(lRawPos);
          until (lRawRA[lRawPos] >= $D0) and (lRawRA[lRawPos] <= $D7);
          lCurrentBitPos := 0;
          inc(lRawPos);
        end;
        lSegmentEnd := lSegmentEnd + lRestartSegmentSz;
      until (lRestartSegmentSz < 1) or ((lSegmentEnd - 2) > lItems);
    end;

  finally
    freemem(lRawRA);
  end;
end;

// Lossless jpeg
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// RLE

// returns bytes read
function DecodeRLE(Stream:TStream; Buffer:pbyte; BufferLen:integer):integer;
var
  wpos:integer;
  s:shortint;
  i:integer;
  b:byte;
  slen:integer;
begin
  result := 0;
  slen := Stream.Size;
  wpos := 0;
  while (wpos < BufferLen) and (Stream.Position < slen) do
  begin
    inc(result, Stream.Read(s, 1));
    i := s;
    if (i >= 0) and (i <= 127) then
    begin
      inc(i);
      inc(result, Stream.Read(Buffer^, i));
      inc(wpos, i);
      inc(Buffer, i);
    end
    else if (i <= -1) and (i >= -127) then
    begin
      inc(result, Stream.Read(b, 1));
      i := -i+1;
      FillChar(Buffer^, i, b);
      inc(wpos, i);
      inc(Buffer, i);
    end;
  end;
end;


// RLE
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$endif}

end.
