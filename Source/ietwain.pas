(*
File version 1000
*)

unit ietwain;

{$R-}
{$Q-}

{$I ie.inc}

interface

uses
  Windows;

type

  TW_UINT32 = ULONG;
  TW_UINT16 = Word;
  TW_MEMREF = Pointer;
  TW_INT32 = LongInt;
  TW_INT16 = SmallInt;
  TW_STR32 = array[0..33] of AnsiChar;
  TW_STR255 = array[0..255] of AnsiChar;
  TW_BOOL = WordBool;
  TW_HANDLE = THandle;
  TW_UINT8 = Byte;

  pTW_ONEVALUE = ^TW_ONEVALUE;
  pTW_BOOL = ^TW_BOOL;
  pTW_IMAGEMEMXFER = ^TW_IMAGEMEMXFER;
  pTW_FIX32 = ^TW_FIX32;
  pTW_ENUMERATION = ^TW_ENUMERATION;
  pTW_ARRAY = ^TW_ARRAY;
  pTW_RANGE = ^TW_RANGE;
  pTW_UINT16 = ^TW_UINT16;
  pTW_IDENTITY = ^TW_IDENTITY;
  pTW_INT32 = ^TW_INT32;

  TW_RANGE = packed record
    ItemType: TW_UINT16;
    MinValue: TW_UINT32;
    MaxValue: TW_UINT32;
    StepSize: TW_UINT32;
    DefaultValue: TW_UINT32;
    CurrentValue: TW_UINT32;
  end;

  TW_ARRAY = packed record
    ItemType: TW_UINT16;
    NumItems: TW_UINT32;
    ItemList: array[0..1] of TW_UINT8;
  end;

  TW_ENUMERATION = packed record
    ItemType: TW_UINT16;
    NumItems: TW_UINT32;
    CurrentIndex: TW_UINT32;
    DefaultIndex: TW_UINT32;
    ItemList: array[0..1] of TW_UINT8;
  end;

  TW_FIX32 = packed record
    Whole: TW_INT16;
    Frac: TW_UINT16;
  end;

  TW_FRAME = packed record
    Left: TW_FIX32;
    Top: TW_FIX32;
    Right: TW_FIX32;
    Bottom: TW_FIX32;
  end;

  TW_IMAGELAYOUT = packed record
    Frame: TW_FRAME;
    DocumentNumber: TW_UINT32;
    PageNumber: TW_UINT32;
    FrameNumber: TW_UINT32;
  end;

  TW_EVENT = packed record
    pEvent: TW_MEMREF;
    TWMessage: TW_UINT16;
  end;

  TW_SETUPMEMXFER = packed record
    MinBufSize: TW_UINT32;
    MaxBufSize: TW_UINT32;
    Preferred: TW_UINT32;
  end;

  TW_SETUPFILEXFER = packed record
    FileName: TW_STR255;
    Format: TW_UINT16;
    VRefNum: TW_INT16;
  end;

  TW_MEMORY = packed record
    Flags: TW_UINT32;
    Length: TW_UINT32;
    TheMem: TW_MEMREF;
  end;

  TW_IMAGEMEMXFER = packed record
    Compression: TW_UINT16;
    BytesPerRow: TW_UINT32;
    Columns: TW_UINT32;
    Rows: TW_UINT32;
    XOffset: TW_UINT32;
    YOffset: TW_UINT32;
    BytesWritten: TW_UINT32;
    Memory: TW_MEMORY;
  end;

  TW_IMAGEINFO = packed record
    XResolution: TW_FIX32;
    YResolution: TW_FIX32;
    ImageWidth: TW_INT32;
    ImageLength: TW_INT32;
    SamplesPerPixel: TW_INT16;
    BitsPerSample: array[0..7] of TW_INT16;
    BitsPerPixel: TW_INT16;
    Planar: TW_BOOL;
    PixelType: TW_INT16;
    Compression: TW_UINT16;
  end;

  TW_ONEVALUE = packed record
    ItemType: TW_UINT16;
    Item: TW_UINT32;
  end;

  TW_CAPABILITY = packed record
    Cap: TW_UINT16;
    ConType: TW_UINT16;
    hContainer: TW_HANDLE;
  end;

  TW_STATUS = packed record
    ConditionCode: TW_UINT16;
    Reserved: TW_UINT16;
  end;

  TW_PENDINGXFERS = packed record
    Count: TW_UINT16;
    case boolean of
      False: (EOJ: TW_UINT32);
      True: (Reserved: TW_UINT32);
  end;

  TW_USERINTERFACE = packed record
    ShowUI: TW_BOOL;
    ModalUI: TW_BOOL;
    hParent: TW_HANDLE;
  end;

  TW_VERSION = packed record
    MajorNum: TW_UINT16;
    MinorNum: TW_UINT16;
    Language: TW_UINT16;
    Country: TW_UINT16;
    Info: TW_STR32;
  end;

  TW_IDENTITY = packed record
    Id: TW_UINT32;
    Version: TW_VERSION;
    ProtocolMajor: TW_UINT16;
    ProtocolMinor: TW_UINT16;
    SupportedGroups: TW_UINT32;
    Manufacturer: TW_STR32;
    ProductFamily: TW_STR32;
    ProductName: TW_STR32;
  end;

  TW_CUSTOMDSDATA = packed record
    InfoLength: TW_UINT32;
    hData: TW_HANDLE;
  end;


DSMENTRYPROC = function(pOrigin: pTW_IDENTITY; pDest: pTW_IDENTITY; DG: TW_UINT32; DAT: TW_UINT16; MSG: TW_UINT16; pData: TW_MEMREF): TW_UINT16; stdcall;

TDSMEntryProc = DSMENTRYPROC;

const

  TWON_PROTOCOLMAJOR = 1;
  TWON_PROTOCOLMINOR = 9;
  DG_IMAGE = $0002;
  DG_CONTROL = $0001;


  TWCC_SUCCESS = 0;
  TWCC_BUMMER = 1;
  TWCC_LOWMEMORY = 2;
  TWCC_NODS = 3;
  TWCC_MAXCONNECTIONS = 4;
  TWCC_OPERATIONERROR = 5;
  TWCC_BADCAP = 6;
  TWCC_BADPROTOCOL = 9;
  TWCC_BADVALUE = 10;
  TWCC_SEQERROR = 11;
  TWCC_BADDEST = 12;
  TWCC_CAPUNSUPPORTED = 13;
  TWCC_CAPBADOPERATION = 14;
  TWCC_CAPSEQERROR = 15;
  TWCC_DENIED = 16;
  TWCC_FILEEXISTS = 17;
  TWCC_FILENOTFOUND = 18;
  TWCC_NOTEMPTY = 19;
  TWCC_PAPERJAM = 20;
  TWCC_PAPERDOUBLEFEED = 21;
  TWCC_FILEWRITEERROR = 22;
  TWCC_CHECKDEVICEONLINE = 23;

  TWRC_SUCCESS = 0;
  TWRC_FAILURE = 1;

  DAT_CUSTOMDSDATA = $000c;
  DAT_PARENT = $0004;
  MSG_OPENDSM = $0301;
  MSG_CLOSEDSM = $0302;
  DAT_USERINTERFACE = $0009;
  MSG_DISABLEDS = $0501;
  DAT_IDENTITY = $0003;
  MSG_CLOSEDS = $0402;
  MSG_USERSELECT = $0403;
  DAT_STATUS = $0008;
  MSG_GET = $0001;
  MSG_GETFIRST = $0004;
  TWRC_ENDOFLIST = 7;
  MSG_GETNEXT = $0005;
  MSG_OPENDS = $0401;
  MSG_ENABLEDS = $0502;
  MSG_ENABLEDSUIONLY = $0503;
  TWON_DONTCARE16 = $FFFF;
  DAT_CAPABILITY = $0001;
  TWON_ONEVALUE = 5;
  TWTY_STR255 = $000C;
  MSG_SET = $0006;
  DAT_PENDINGXFERS = $0005;
  MSG_ENDXFER = $0701;
  MSG_RESET = $0007;
  TWTY_BOOL = $0006;
  DAT_IMAGEINFO = $0101;
  DAT_SETUPMEMXFER = $0006;
  TWON_DONTCARE32 = DWORD($FFFFFFFF);
  TWMF_APPOWNS = $1;
  TWMF_HANDLE = $10;
  DAT_IMAGEMEMXFER = $0103;
  TWRC_XFERDONE = 6;
  CAP_CAPTION = $1001;
  TWRC_CANCEL = 3;
  DAT_IMAGENATIVEXFER = $0104;
  DAT_SETUPFILEXFER = $0007;
  TWFF_BMP = 2;
  DAT_IMAGEFILEXFER = $0105;
  MSG_NULL = $0000;
  DAT_EVENT = $0002;
  MSG_PROCESSEVENT = $0601;
  TWRC_DSEVENT = 4;
  MSG_XFERREADY = $0101;
  MSG_CLOSEDSREQ = $0102;
  MSG_CLOSEDSOK = $0103;
  DAT_IMAGELAYOUT = $0102;
  TWON_ENUMERATION = 4;
  ICAP_XRESOLUTION = $1118;
  ICAP_YRESOLUTION = $1119;
  TWON_ARRAY = 3;
  TWON_RANGE = 6;
  TWTY_UINT16 = $0004;
  TWTY_INT32 = $0002;
  TWTY_FIX32 = $0007;
  ICAP_UNITS = $0102;
  TWPF_CHOCOLATE = 0;
  ICAP_PIXELFLAVOR = $111F;
  TWPF_VANILLA = 1;
  ICAP_UNDEFINEDIMAGESIZE = $112D;
  ICAP_CONTRAST = $1103;
  ICAP_BRIGHTNESS = $1101;
  ICAP_THRESHOLD = $1123;
  ICAP_ROTATION = $1121;
  ICAP_XSCALING = $1124;
  ICAP_YSCALING = $1125;
  ICAP_PIXELTYPE = $0101;
  ICAP_BITDEPTH = $112B;
  ICAP_PLANARCHUNKY = $1120;
  TWPC_CHUNKY = 0;
  ICAP_XFERMECH = $0103;
  TWSX_MEMORY = 2;
  CAP_FEEDERENABLED = $1002;
  CAP_AUTOFEED = $1007;
  ICAP_AUTOMATICDESKEW = $1151;
  ICAP_AUTOMATICBORDERDETECTION = $1150;
  ICAP_AUTOBRIGHT = $1100;
  ICAP_AUTOMATICROTATE = $1152;
  ICAP_ORIENTATION = $1110;
  ICAP_SUPPORTEDSIZES = $1122;
  CAP_INDICATORS = $100B;
  CAP_DUPLEXENABLED = $1013;
  ICAP_GAMMA = $1108;
  ICAP_PHYSICALHEIGHT = $1112;
  ICAP_PHYSICALWIDTH = $1111;
  CAP_FEEDERLOADED = $1003;
  CAP_PAPERDETECTABLE = $100D;
  CAP_DUPLEX = $1012;
  TWOR_ROT0 = 0;
  TWOR_PORTRAIT = TWOR_ROT0;
  MSG_GETDEFAULT = $0003;
  TWMF_POINTER = $8;
  ICAP_FILTER = $1106;
  ICAP_HIGHLIGHT = $110A;
  ICAP_SHADOW = $1113;
  TWCP_NONE = 0;
  ICAP_COMPRESSION = $0100;
  ICAP_AUTODISCARDBLANKPAGES = $1134;

  TWLG_DAN      =   0; { Danish }
  TWLG_DUT      =   1; { Dutch }
  TWLG_ENG      =   2; { International English }
  TWLG_FCF      =   3; { French Canadian }
  TWLG_FIN      =   4; { Finnish }
  TWLG_FRN      =   5; { French }
  TWLG_GER      =   6; { German }
  TWLG_ICE      =   7; { Icelandic }
  TWLG_ITN      =   8; { Italian }
  TWLG_NOR      =   9; { Norwegian }
  TWLG_POR      =  10; { Portuguese }
  TWLG_SPA      =  11; { Spanish }
  TWLG_SWE      =  12; { Swedish }
  TWLG_USA      =  13; { U.S. English }
{ Added for 1.8 }
  TWLG_USERLOCALE         =  $FFFF;
  TWLG_AFRIKAANS          =  14;
  TWLG_ALBANIA            =  15;
  TWLG_ARABIC             =  16;
  TWLG_ARABIC_ALGERIA     =  17;
  TWLG_ARABIC_BAHRAIN     =  18;
  TWLG_ARABIC_EGYPT       =  19;
  TWLG_ARABIC_IRAQ        =  20;
  TWLG_ARABIC_JORDAN      =  21;
  TWLG_ARABIC_KUWAIT      =  22;
  TWLG_ARABIC_LEBANON     =  23;
  TWLG_ARABIC_LIBYA       =  24;
  TWLG_ARABIC_MOROCCO     =  25;
  TWLG_ARABIC_OMAN        =  26;
  TWLG_ARABIC_QATAR       =  27;
  TWLG_ARABIC_SAUDIARABIA =  28;
  TWLG_ARABIC_SYRIA       =  29;
  TWLG_ARABIC_TUNISIA     =  30;
  TWLG_ARABIC_UAE         =  31; { United Arabic Emirates }
  TWLG_ARABIC_YEMEN       =  32;
  TWLG_BASQUE             =  33;
  TWLG_BYELORUSSIAN       =  34;
  TWLG_BULGARIAN          =  35;
  TWLG_CATALAN            =  36;
  TWLG_CHINESE            =  37;
  TWLG_CHINESE_HONGKONG   =  38;
  TWLG_CHINESE_PRC        =  39; { People's Republic of China }
  TWLG_CHINESE_SINGAPORE  =  40;
  TWLG_CHINESE_SIMPLIFIED =  41;
  TWLG_CHINESE_TAIWAN     =  42;
  TWLG_CHINESE_TRADITIONAL=  43;
  TWLG_CROATIA            =  44;
  TWLG_CZECH              =  45;
  TWLG_DANISH             =  TWLG_DAN;
  TWLG_DUTCH              =  TWLG_DUT;
  TWLG_DUTCH_BELGIAN      =  46;
  TWLG_ENGLISH            =  TWLG_ENG;
  TWLG_ENGLISH_AUSTRALIAN =  47;
  TWLG_ENGLISH_CANADIAN   =  48;
  TWLG_ENGLISH_IRELAND    =   49;
  TWLG_ENGLISH_NEWZEALAND =  50;
  TWLG_ENGLISH_SOUTHAFRICA=  51;
  TWLG_ENGLISH_UK           =  52;
  TWLG_ENGLISH_USA          =  TWLG_USA;
  TWLG_ESTONIAN             =  53;
  TWLG_FAEROESE             =  54;
  TWLG_FARSI                =  55;
  TWLG_FINNISH              =  TWLG_FIN;
  TWLG_FRENCH               =  TWLG_FRN;
  TWLG_FRENCH_BELGIAN       =  56;
  TWLG_FRENCH_CANADIAN      =  TWLG_FCF;
  TWLG_FRENCH_LUXEMBOURG    =  57;
  TWLG_FRENCH_SWISS         =  58;
  TWLG_GERMAN               =  TWLG_GER;
  TWLG_GERMAN_AUSTRIAN      =  59;
  TWLG_GERMAN_LUXEMBOURG    =  60;
  TWLG_GERMAN_LIECHTENSTEIN =  61;
  TWLG_GERMAN_SWISS         =  62;
  TWLG_GREEK                =  63;
  TWLG_HEBREW               =  64;
  TWLG_HUNGARIAN            =  65;
  TWLG_ICELANDIC            =  TWLG_ICE;
  TWLG_INDONESIAN           =  66;
  TWLG_ITALIAN              =  TWLG_ITN;
  TWLG_ITALIAN_SWISS        =  67;
  TWLG_JAPANESE             =  68;
  TWLG_KOREAN               =  69;
  TWLG_KOREAN_JOHAB         =  70;
  TWLG_LATVIAN              =  71;
  TWLG_LITHUANIAN           =  72;
  TWLG_NORWEGIAN            =  TWLG_NOR;
  TWLG_NORWEGIAN_BOKMAL     =  73;
  TWLG_NORWEGIAN_NYNORSK    =  74;
  TWLG_POLISH               =  75;
  TWLG_PORTUGUESE           =  TWLG_POR;
  TWLG_PORTUGUESE_BRAZIL    =  76;
  TWLG_ROMANIAN             =  77;
  TWLG_RUSSIAN              =  78;
  TWLG_SERBIAN_LATIN        =  79;
  TWLG_SLOVAK               =  80;
  TWLG_SLOVENIAN            =  81;
  TWLG_SPANISH              =  TWLG_SPA;
  TWLG_SPANISH_MEXICAN      =  82;
  TWLG_SPANISH_MODERN       =  83;
  TWLG_SWEDISH              =  TWLG_SWE;
  TWLG_THAI                 =  84;
  TWLG_TURKISH              =  85;
  TWLG_UKRANIAN             =  86;
  TWLG_ASSAMESE             =   87;
  TWLG_BENGALI              =   88;
  TWLG_BIHARI               =   89;
  TWLG_BODO                 =   90;
  TWLG_DOGRI                =   91;
  TWLG_GUJARATI             =   92;
  TWLG_HARYANVI             =   93;
  TWLG_HINDI                =   94;
  TWLG_KANNADA              =   95;
  TWLG_KASHMIRI             =   96;
  TWLG_MALAYALAM            =   97;
  TWLG_MARATHI              =   98;
  TWLG_MARWARI              =   99;
  TWLG_MEGHALAYAN           =   100;
  TWLG_MIZO                 =   101;
  TWLG_NAGA                 =   102;
  TWLG_ORISSI               =   103;
  TWLG_PUNJABI              =   104;
  TWLG_PUSHTU               =   105;
  TWLG_SERBIAN_CYRILLIC     =   106;
  TWLG_SIKKIMI              =   107;
  TWLG_SWEDISH_FINLAND      =   108;
  TWLG_TAMIL                =   109;
  TWLG_TELUGU               =   110;
  TWLG_TRIPURI              =   111;
  TWLG_URDU                 =   112;
  TWLG_VIETNAMESE           =   113;


  TWCY_AFGHANISTAN    =  1001;
  TWCY_ALGERIA        =  213;
  TWCY_AMERICANSAMOA  =  684;
  TWCY_ANDORRA        =  033;
  TWCY_ANGOLA         =  1002;
  TWCY_ANGUILLA       =  8090;
  TWCY_ANTIGUA        =  8091;
  TWCY_ARGENTINA      =   54;
  TWCY_ARUBA          =  297;
  TWCY_ASCENSIONI     =  247;
  TWCY_AUSTRALIA      =   61;
  TWCY_AUSTRIA        =   43;
  TWCY_BAHAMAS        =  8092;
  TWCY_BAHRAIN        =  973;
  TWCY_BANGLADESH     =  880;
  TWCY_BARBADOS       =  8093;
  TWCY_BELGIUM        =   32;
  TWCY_BELIZE         =  501;
  TWCY_BENIN          =  229;
  TWCY_BERMUDA        =  8094;
  TWCY_BHUTAN         =  1003;
  TWCY_BOLIVIA        =  591;
  TWCY_BOTSWANA       =  267;
  TWCY_BRITAIN        =   6;
  TWCY_BRITVIRGINIS   =  8095;
  TWCY_BRAZIL         =   55;
  TWCY_BRUNEI         =  673;
  TWCY_BULGARIA       =  359;
  TWCY_BURKINAFASO    =  1004;
  TWCY_BURMA          =  1005;
  TWCY_BURUNDI        =  1006;
  TWCY_CAMAROON       =  237;
  TWCY_CANADA         =   2;
  TWCY_CAPEVERDEIS    =  238;
  TWCY_CAYMANIS       =  8096;
  TWCY_CENTRALAFREP   =  1007;
  TWCY_CHAD           =  1008;
  TWCY_CHILE          =   56;
  TWCY_CHINA          =   86;
  TWCY_CHRISTMASIS    =  1009;
  TWCY_COCOSIS        =  1009;
  TWCY_COLOMBIA       =   57;
  TWCY_COMOROS        =  1010;
  TWCY_CONGO          =  1011;
  TWCY_COOKIS         =  1012;
  TWCY_COSTARICA      =  506 ;
  TWCY_CUBA           =  005;
  TWCY_CYPRUS         =  357;
  TWCY_CZECHOSLOVAKIA =  42;
  TWCY_DENMARK        =   45;
  TWCY_DJIBOUTI       =  1013;
  TWCY_DOMINICA       =  8097;
  TWCY_DOMINCANREP    =  8098;
  TWCY_EASTERIS       =  1014;
  TWCY_ECUADOR        =  593;
  TWCY_EGYPT          =   20;
  TWCY_ELSALVADOR     =  503;
  TWCY_EQGUINEA       =  1015;
  TWCY_ETHIOPIA       =  251;
  TWCY_FALKLANDIS     =  1016;
  TWCY_FAEROEIS       =  298;
  TWCY_FIJIISLANDS    =  679;
  TWCY_FINLAND        =  358;
  TWCY_FRANCE         =   33;
  TWCY_FRANTILLES     =  596;
  TWCY_FRGUIANA       =  594;
  TWCY_FRPOLYNEISA    =  689;
  TWCY_FUTANAIS       =  1043;
  TWCY_GABON          =  241;
  TWCY_GAMBIA         =  220;
  TWCY_GERMANY        =   49;
  TWCY_GHANA          =  233;
  TWCY_GIBRALTER      =  350;
  TWCY_GREECE         =   30;
  TWCY_GREENLAND      =  299;
  TWCY_GRENADA        =  8099;
  TWCY_GRENEDINES     =  8015;
  TWCY_GUADELOUPE     =  590;
  TWCY_GUAM           =  671;
  TWCY_GUANTANAMOBAY  =  5399;
  TWCY_GUATEMALA      =  502;
  TWCY_GUINEA         =  224;
  TWCY_GUINEABISSAU   =  1017;
  TWCY_GUYANA         =  592;
  TWCY_HAITI          =  509;
  TWCY_HONDURAS       =  504;
  TWCY_HONGKONG       =  852 ;
  TWCY_HUNGARY        =   36;
  TWCY_ICELAND        =  354;
  TWCY_INDIA          =   91;
  TWCY_INDONESIA      =   62;
  TWCY_IRAN           =   98;
  TWCY_IRAQ           =  964;
  TWCY_IRELAND        =  353;
  TWCY_ISRAEL         =  972;
  TWCY_ITALY          =   39;
  TWCY_IVORYCOAST     =  225 ;
  TWCY_JAMAICA        =  8010;
  TWCY_JAPAN          =   81;
  TWCY_JORDAN         =  962;
  TWCY_KENYA          =  254;
  TWCY_KIRIBATI       =  1018;
  TWCY_KOREA          =   82;
  TWCY_KUWAIT         =  965;
  TWCY_LAOS           =  1019;
  TWCY_LEBANON        =  1020;
  TWCY_LIBERIA        =  231;
  TWCY_LIBYA          =  218;
  TWCY_LIECHTENSTEIN  =   41;
  TWCY_LUXENBOURG     =  352;
  TWCY_MACAO          =  853;
  TWCY_MADAGASCAR     =  1021;
  TWCY_MALAWI         =  265;
  TWCY_MALAYSIA       =   60;
  TWCY_MALDIVES       =  960;
  TWCY_MALI           =  1022;
  TWCY_MALTA          =  356;
  TWCY_MARSHALLIS     =  692;
  TWCY_MAURITANIA     =  1023;
  TWCY_MAURITIUS      =  230;
  TWCY_MEXICO         =   3;
  TWCY_MICRONESIA     =  691;
  TWCY_MIQUELON       =  508;
  TWCY_MONACO         =   33;
  TWCY_MONGOLIA       =  1024;
  TWCY_MONTSERRAT     =  8011;
  TWCY_MOROCCO        =  212;
  TWCY_MOZAMBIQUE     =  1025;
  TWCY_NAMIBIA        =  264;
  TWCY_NAURU          =  1026;
  TWCY_NEPAL          =  977;
  TWCY_NETHERLANDS    =   31;
  TWCY_NETHANTILLES   =  599;
  TWCY_NEVIS          =  8012;
  TWCY_NEWCALEDONIA   =  687;
  TWCY_NEWZEALAND     =   64;
  TWCY_NICARAGUA      =  505;
  TWCY_NIGER          =  227;
  TWCY_NIGERIA        =  234;
  TWCY_NIUE           =  1027;
  TWCY_NORFOLKI       =  1028;
  TWCY_NORWAY         =   47;
  TWCY_OMAN           =  968;
  TWCY_PAKISTAN       =   92;
  TWCY_PALAU          =  1029;
  TWCY_PANAMA         =  507;
  TWCY_PARAGUAY       =  595;
  TWCY_PERU           =   51;
  TWCY_PHILLIPPINES   =   63;
  TWCY_PITCAIRNIS     =  1030;
  TWCY_PNEWGUINEA     =  675;
  TWCY_POLAND         =   48;
  TWCY_PORTUGAL       =  351;
  TWCY_QATAR          =  974;
  TWCY_REUNIONI       =  1031;
  TWCY_ROMANIA        =   40;
  TWCY_RWANDA         =  250;
  TWCY_SAIPAN         =  670;
  TWCY_SANMARINO      =   39;
  TWCY_SAOTOME        =  1033;
  TWCY_SAUDIARABIA    =  966;
  TWCY_SENEGAL        =  221;
  TWCY_SEYCHELLESIS   =  1034;
  TWCY_SIERRALEONE    =  1035;
  TWCY_SINGAPORE      =   65;
  TWCY_SOLOMONIS      =  1036;
  TWCY_SOMALI         =  1037;
  TWCY_SOUTHAFRICA    =  27 ;
  TWCY_SPAIN          =   34;
  TWCY_SRILANKA       =   94;
  TWCY_STHELENA       =  1032;
  TWCY_STKITTS        =  8013;
  TWCY_STLUCIA        =  8014;
  TWCY_STPIERRE       =  508;
  TWCY_STVINCENT      =  8015;
  TWCY_SUDAN          =  1038;
  TWCY_SURINAME       =  597;
  TWCY_SWAZILAND      =  268;
  TWCY_SWEDEN         =   46;
  TWCY_SWITZERLAND    =   41;
  TWCY_SYRIA          =  1039;
  TWCY_TAIWAN         =  886;
  TWCY_TANZANIA       =  255;
  TWCY_THAILAND       =   66;
  TWCY_TOBAGO         =  8016;
  TWCY_TOGO           =  228;
  TWCY_TONGAIS        =  676;
  TWCY_TRINIDAD       =  8016;
  TWCY_TUNISIA        =  216;
  TWCY_TURKEY         =   90;
  TWCY_TURKSCAICOS    =  8017;
  TWCY_TUVALU         =  1040;
  TWCY_UGANDA         =  256;
  TWCY_USSR           =   7;
  TWCY_UAEMIRATES     =  971;
  TWCY_UNITEDKINGDOM  =   44;
  TWCY_USA            =   1;
  TWCY_URUGUAY        =  598;
  TWCY_VANUATU        =  1041;
  TWCY_VATICANCITY    =   39;
  TWCY_VENEZUELA      =   58;
  TWCY_WAKE           =  1042;
  TWCY_WALLISIS       =  1043;
  TWCY_WESTERNSAHARA  =  1044;
  TWCY_WESTERNSAMOA   =  1045;
  TWCY_YEMEN          =  1046;
  TWCY_YUGOSLAVIA     =   38;
  TWCY_ZAIRE          =  243;
  TWCY_ZAMBIA         =  260;
  TWCY_ZIMBABWE       =  263;
{ Added for 1.8 }
  TWCY_ALBANIA        =  355;
  TWCY_ARMENIA        =  374;
  TWCY_AZERBAIJAN     =  994;
  TWCY_BELARUS        =  375;
  TWCY_BOSNIAHERZGO   =  387;
  TWCY_CAMBODIA       =  855;
  TWCY_CROATIA        =  385;
  TWCY_CZECHREPUBLIC  =  420;
  TWCY_DIEGOGARCIA    =  246;
  TWCY_ERITREA        =  291;
  TWCY_ESTONIA        =  372;
  TWCY_GEORGIA        =  995;
  TWCY_LATVIA         =  371;
  TWCY_LESOTHO        =  266;
  TWCY_LITHUANIA      =  370;
  TWCY_MACEDONIA      =  389;
  TWCY_MAYOTTEIS      =  269;
  TWCY_MOLDOVA        =  373;
  TWCY_MYANMAR        =  95 ;
  TWCY_NORTHKOREA     =  850;
  TWCY_PUERTORICO     =  787;
  TWCY_RUSSIA         =  7 ;
  TWCY_SERBIA         =  381;
  TWCY_SLOVAKIA       =  421;
  TWCY_SLOVENIA       =  386;
  TWCY_SOUTHKOREA     =  82 ;
  TWCY_UKRAINE        =  380;
  TWCY_USVIRGINIS     =  340;
  TWCY_VIETNAM        =  84 ;




implementation


end.
