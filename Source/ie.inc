// ie.inc

(*
File version 1010
*)


{.$define IEDEBUG}


{$A+}
{$T-}
{$B-}
{$R-}
{$Q-}

//////////////////////////////////////////////////////////////
// Specify the modules to include
//////////////////////////////////////////////////////////////

// support for Jpeg2000
{$define IEINCLUDEJPEG2000}

// support for PNG  (requires IEINCLUDEZLIB under Delphi)
{$define IEINCLUDEPNG}

// ZLib support
{$define IEINCLUDEZLIB}

// support for VFW video capture (TImageEnVideoCap and TImageEnVideoView)
{$define IEINCLUDEVIDEOCAPTURE}

// support for multi view/thumbnails (TImageEnMIO and TImageEnMView)
{$define IEINCLUDEMULTIVIEW}

// support for TWain acquisition
{$define IEINCLUDETWAIN}

// support for database components (TImageEnDBVect and TImageEnDBView)
{$define IEINCLUDEDB}

// support for TImageEn component
{$define IEINCLUDETIMAGEEN}

// support for image processing dialog
{$define IEINCLUDEDIALOGIP}

// support for input/output dialog (button "Advanced" in save dialog)
{$define IEINCLUDEDIALOGIO}

// support for open/save dialogs
{$define IEINCLUDEOPENSAVEDIALOGS}

// support for print dialogs
{$define IEINCLUDEPRINTDIALOGS}

// WIA support (requires IEINCLUDETWAIN)
{$define IEINCLUDEWIA}

// WIC - Windows Imaging Component support. Requires IEINCLUDEWIA and IEINCLUDEDIRECTSHOW
{$define IEINCLUDEWIC}

// DirectShow support (requires IEINCLUDEWIA)
{$define IEINCLUDEDIRECTSHOW}

// Includes Color Management System (LCMS) - default disabled
{.$define IEINCLUDECMS}

// Includes extra transitions
{$define IEINCLUDEEXTRATRANSITIONS}

// Includes preset images
{$define IEINCLUDEPRESETIMAGES}

// Includes raw formats
{$define IEINCLUDERAWFORMATS}

// register QuickReport ImageEn components - default disabled
{.$define IEREGISTERQR}

// Use TIEBufferedReadStream instead of TStream to read files
{$define IEUSEBUFFEREDSTREAM}

// Include TIENeurNet class - default disabled
{.$define IEINCLUDENEURALNET}

// Support for DICOM file format
{$define IEINCLUDEDICOM}

// Support for TIEResourceExtractor class
{$define IEINCLUDERESOURCEEXTRACTOR}

// Support for TIEHashStream class (and TIEBitmap.GetHash)
{$define IEINCLUDEHASHSTREAM}

// Support for PDF writing
{$define IEINCLUDEPDFWRITING}

// Support for TIEImagingAnnot (and related services)
{$define IEINCLUDEIMAGINGANNOT}

// Support for TIETIFFHandler (and related services)
{$define IEINCLUDETIFFHANDLER}

// Support for PSD file format
{$define IEINCLUDEPSD}

// Support for FFT processing
{$define IEINCLUDEFFT}

// Support for RFB (VNC client) protocol
{$define IERFBPROTOCOL}

//////////////////////////////////////////////////////////////
// conditional modules
//////////////////////////////////////////////////////////////

{$ifndef IEINCLUDEPNG}
  {$undef IEINCLUDEPRESETIMAGES}
  {$undef IEINCLUDEZLIB}
{$endif}

{$ifndef IEINCLUDEZLIB}
  {$undef IEINCLUDEPNG}
  {$undef IEINCLUDEPRESETIMAGES}
{$endif}

//////////////////////////////////////////////////////////////
// supported languages
//////////////////////////////////////////////////////////////

{$define IESUPPORTENGLISH}				// English
{$define IESUPPORTITALIAN}				// Italian
{$define IESUPPORTGERMAN}				  // German
{$define IESUPPORTSPANISH}				// Spanish
{$define IESUPPORTFRENCH}				  // French
{$define IESUPPORTPORTUGUESE}			// Portuguese
{$define IESUPPORTGREEK}				  // Greek
{$define IESUPPORTRUSSIAN}				// Russian
{$define IESUPPORTDUTCH}				  // Dutch
{$define IESUPPORTSWEDISH}				// Swedish
{$define IESUPPORTPOLISH}				  // Polish
{$define IESUPPORTJAPANESE}       // Japanese
{$define IESUPPORTCZECH}          // Czech
{$define IESUPPORTFINNISH}        // Finnish
{$define IESUPPORTFARSI}          // Farsi
{$define IESUPPORTCHINESE}        // Chinese and Chinese Traditional
{$define IESUPPORTDANISH}         // Danish
{$define IESUPPORTTURKISH}        // Turkish
{$define IESUPPORTKOREAN}         // Korean
{$define IESUPPORTHUNGARIAN}      // Hungarian
{$define IESUPPORTUSER}					  // User--

//////////////////////////////////////////////////////////////
// components behavior
//////////////////////////////////////////////////////////////

{$define IESINGLE_CLICK_SELECTION_REMOVE}	// single click out of a selection
{$define IETWAINTASKWINDOWS}					    // enhances TWain compatibility
{.$define IEREGISTERTPICTUREFORMATS}		  // register ImageEn file formats in the VCL

//////////////////////////////////////////////////////////////
// detect Borland compiler version
//////////////////////////////////////////////////////////////

// IEDCPPBUILDER = C++Builder (3,4,5,6...)
// IEDC3 = Delphi 3 or C++Builder 3
// IEDELPHI3 = Delphi 3
// IECPPBUILDER3 = C++Builder 3
// IEDC4 = Delphi 4 or C++Builder 4
// IEDELPHI4 = Delphi 4
// IECPPBUILDER4 = C++Builder 4
// IEDC5 = Delphi 5 or C++Builder 5
// IEDELPHI5 = Delphi 5
// IECPPBUILDER5 = C++Builder 5
// IEDC6 = Delphi 6 or C++Builder 6
// IEDELPHI6 = Delphi 6
// IECPPBUILDER6 = C++Builder 6
// IEDC7 = Delphi 7 or C++Builder 7 (??)
// IEDELPHI7 = Delphi 7
// IEKYLIX = Kylix 1,2,3
// IEDELPHI = Delphi or C++Builder
// IEDELPHI9 = Delphi 2005
// IEDELPHI10 = Delphi 2006
// IEDELPHI11 = Delphi 2007
// IEDELPHI12 = Delphi 2009
// IEDELPHI14 = Delphi 2010
// IEDELPHI15 = Delphi XE

// Delphi 3
{$ifdef VER100}
  {$define IEDC3}
  {$define IEDELPHI3}
  {$define IEHASTHREADSBUG}
  {$define IEOLDSEEKDEF}
  {$ifndef WIN32}
    {$define WIN32}
  {$endif}
{$endif}

// C++Builder 3
{$ifdef VER110}
  {$define IEDC3}
  {$define IECPPBUILDER3}
  {$define IECPPBUILDER}
  {$define IEHASTHREADSBUG}
  {$define IEOLDSEEKDEF}
  {$ObjExportAll On}
  {$ifndef WIN32}
    {$define WIN32}
  {$endif}
{$endif}

// Delphi 4
{$ifdef VER120}
  {$define IEDC4}
  {$define IEDELPHI4}
  {$define IEFIXPREVIEWS}
  {$define IESUPPORTDEFPARAMS}
  {$define IEHASINT64}
  {$define IEHASTHREADSBUG}
  {$define IEOLDSEEKDEF}
  {$define IESUPPORTOVERLOAD}
  {$ifndef WIN32}
    {$define WIN32}
  {$endif}
{$endif}

// C++Builder 4
{$ifdef VER125}
  {$define IEDC4}
  {$define IECPPBUILDER4}
  {$define IECPPBUILDER}
  {$ObjExportAll On}
  {$define IEFIXPREVIEWS}
  {$define IESUPPORTDEFPARAMS}
  {$define IEHASINT64}
  {$define IEHASTHREADSBUG}
  {$define IEOLDSEEKDEF}
  {$ifndef WIN32}
    {$define WIN32}
  {$endif}
{$endif}

// C++Builder 5 or Delphi 5
{$ifdef VER130}
  {$define IEDC5}
  {$ifdef BCB}
    {$define IECPPBUILDER5}
    {$define IECPPBUILDER}
    {$ObjExportAll On}
  {$else}
    {$define IEDELPHI5}
  {$endif}
  {$define IEHASINT64}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEINCLUDEFLATSB}         // Use FlatSB unit
  {$define IESUPPORTOVERLOAD}
  {$define IEHASTHREADSBUG}
  {$define IEHASFREEANDNIL}
  {$define IEOLDSEEKDEF}
  {$ifndef WIN32}
    {$define WIN32}
  {$endif}
{$endif}

// C++Builder 6 or Delphi 6
{$ifdef VER140}
  {$define IEDC6}
  {$ifdef BCB}
    {$define IECPPBUILDER6}
    {$define IECPPBUILDER}
    {$ObjExportAll On}
  {$else}
    {$define IEDELPHI6}
    {$define IEFIXDESIGNINT}
  {$endif}
  {$define IEHASINT64}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IEFIXOSDIALOGS}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEINCLUDEFLATSB}         // Use FlatSB unit
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
  {$define IEMMXSUPPORTED}
  {$ifndef WIN32}
    {$define WIN32}
  {$endif}
  {$define IEHASCONSTENUM}
  {$define IEHASAFTERCONSTRUCTION}
  {$define IEHASTYPES}
{$endif}

// Delphi 7
{$ifdef VER150}
  {$define IEDC7}
  {$define IEDELPHI7}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IEFIXOSDIALOGS}
  {$define IEFIXDESIGNINT}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEHASINT64}
  {$define IEINCLUDEFLATSB}     // Use FlatSB unit
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
  {$define IEMMXSUPPORTED}
  {$define IEHASTTHREADSTATICSYNCHRONIZE}
  {$define IEHASCONSTENUM}
  {$define IEHASAFTERCONSTRUCTION}
  {$define IEHASTYPES}

  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$endif}

// Delphi 2005
{$ifdef VER170}
  {$define IEDC9}
  {$define IEDELPHI9}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IEFIXOSDIALOGS}
  {$define IEFIXDESIGNINT}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEHASINT64}
  {$define IEINCLUDEFLATSB}     // Use FlatSB unit
  {$define IESUPPORTINLINE}
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
  {$define IEMMXSUPPORTED}
  {$define IEHASTTHREADSTATICSYNCHRONIZE}
  {$define IEHASCONSTENUM}
  {$define IEHASAFTERCONSTRUCTION}
  {$define IEHASACTIVEFORMHANDLE}
  {$define IEHASTYPES}

  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$endif}

// C++Builder 2006 or Delphi 2006
{$ifdef VER180}
  {$ifndef VER185}
    {$define IEDC10}
    {$ifdef BCB}
      {$define IECPPBUILDER10}
      {$define IECPPBUILDER}
      {$ObjExportAll On}
    {$else}
      {$define IEDELPHI10}
      {$define IEFIXDESIGNINT}
    {$endif}
    {$define IEFIXPREVIEWS}
    {$define IEFIXUPDATE}
    {$define IEFIXOSDIALOGS}
    {$define IESUPPORTDEFPARAMS}
    {$define IESUPPORTANCHORS}
    {$define IEMOUSEWHEELEVENTS}
    {$define IEHASINT64}
    {$define IEINCLUDEFLATSB}     // Use FlatSB unit
    {$define IESUPPORTINLINE}
    {$define IESUPPORTOVERLOAD}
    {$define IENEWVARIANTS}
    {$define IEHASFREEANDNIL}
    {$define IEMMXSUPPORTED}
    {$define IEHASTTHREADSTATICSYNCHRONIZE}
    {$define IEHASCONSTENUM}
    {$define IEHASAFTERCONSTRUCTION}
    {$define IEHASACTIVEFORMHANDLE}
    {$define IEHASTYPES}

    {$WARN SYMBOL_PLATFORM OFF}
    {$WARN UNIT_PLATFORM OFF}
  {$endif}
{$endif}

// Delphi 2007 or C++Builder 2007
{$ifdef VER185}
  {$define IEDC11}
  {$ifdef BCB}
    {$define IECPPBUILDER11}
    {$define IECPPBUILDER}
    {$ObjExportAll On}
  {$else}
    {$define IEDELPHI11}
    {$define IEFIXDESIGNINT}
  {$endif}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IEFIXOSDIALOGS}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEHASINT64}
  {$define IEINCLUDEFLATSB}     // Use FlatSB unit
  {$define IESUPPORTINLINE}
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
  {$define IEMMXSUPPORTED}
  {$define IEHASTTHREADSTATICSYNCHRONIZE}
  {$define IEHASCONSTENUM}
  {$define IEHASAFTERCONSTRUCTION}
  {$define IEHASACTIVEFORMHANDLE}
  {$define IEHASTYPES}

  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$endif}

// Delphi 2009 or C++Builder 2009
{$ifdef VER200}
  {$define IEDC12}
  {$ifdef BCB}
    {$define IECPPBUILDER12}
    {$define IECPPBUILDER}
    {$ObjExportAll On}
  {$else}
    {$define IEDELPHI12}
    {$define IEFIXDESIGNINT}
  {$endif}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IEFIXOSDIALOGS}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEHASINT64}
  {$define IEINCLUDEFLATSB}     // Use FlatSB unit
  {$define IESUPPORTINLINE}
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
  {$define IEMMXSUPPORTED}
  {$define IEHASTTHREADSTATICSYNCHRONIZE}
  {$define IEFIXFILTEDIT}
  {$define IEHASCONSTENUM}
  {$define IEHASAFTERCONSTRUCTION}
  {$define IEHASACTIVEFORMHANDLE}
  {$define IEHASTYPES}

  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$endif}

// Delphi 2010 or C++Builder 2010
{$ifdef VER210}
  {$define IEDC14}
  {$ifdef BCB}
    {$define IECPPBUILDER14}
    {$define IECPPBUILDER}
    {$ObjExportAll On}
  {$else}
    {$define IEDELPHI14}
    {$define IEFIXDESIGNINT}
  {$endif}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IEFIXOSDIALOGS}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEHASINT64}
  {$define IEINCLUDEFLATSB}     // Use FlatSB unit
  {$define IESUPPORTINLINE}
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
  {$define IEMMXSUPPORTED}
  {$define IEHASTTHREADSTATICSYNCHRONIZE}
  {$define IEFIXFILTEDIT}
  {$define IEHASTTHREADSTART}
  {$define IEHASCONSTENUM}
  {$define IEHASAFTERCONSTRUCTION}
  {$define IEHASACTIVEFORMHANDLE}
  {$define IEHASTYPES}

  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$endif}



// Delphi XE or C++Builder XE
{$ifdef VER220}
  {$define IEDC15}
  {$ifdef BCB}
    {$define IECPPBUILDER15}
    {$define IECPPBUILDER}
    {$ObjExportAll On}
  {$else}
    {$define IEDELPHI15}
    {$define IEFIXDESIGNINT}
  {$endif}
  {$define IEFIXPREVIEWS}
  {$define IEFIXUPDATE}
  {$define IEFIXOSDIALOGS}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTANCHORS}
  {$define IEMOUSEWHEELEVENTS}
  {$define IEHASINT64}
  {$define IEINCLUDEFLATSB}     // Use FlatSB unit
  {$define IESUPPORTINLINE}
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
  {$define IEMMXSUPPORTED}
  {$define IEHASTTHREADSTATICSYNCHRONIZE}
  {$define IEFIXFILTEDIT}
  {$define IEHASTTHREADSTART}
  {$define IEHASCONSTENUM}
  {$define IEHASAFTERCONSTRUCTION}
  {$define IEHASACTIVEFORMHANDLE}
  {$define IEHASTYPES}

  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$endif}


{$ifdef LINUX}
  {$define IEKYLIX}
  {$define IESUPPORTDEFPARAMS}
  {$define IESUPPORTOVERLOAD}
  {$define IEHASFREEANDNIL}
  {$undef WIN32}
{$else}
  {$define IEDELPHI}
{$endif}

// Free pascal support (actually does Not supported)
{$ifdef FPC}
  {$undef IEDELPHI}
  {$define IESUPPORTDEFPARAMS}
  {$define IEHASINT64}
  {$define IESUPPORTINLINE}
  {$define IESUPPORTOVERLOAD}
  {$define IENEWVARIANTS}
  {$define IEHASFREEANDNIL}
{$endif}

//////////////////////////////////////////////////////////////
// under Linux we cannot implement following features
// Note Kylix is no longer supported
//////////////////////////////////////////////////////////////

{$ifdef IEKYLIX}
{$define IEINCLUDESANE}         // support for SANE (Linux scanner API)
{$undef IEINCLUDEJPEG2000}
{$undef IEINCLUDEVIDEOCAPTURE}
{$undef IEINCLUDEMULTIVIEW}
{$undef IEINCLUDETWAIN}
{$undef IEINCLUDEDB}
{$undef IEINCLUDETIMAGEEN}
{$undef IEINCLUDEDIALOGIP}
{$undef IEINCLUDEDIALOGIO}
{$undef IEINCLUDEOPENSAVEDIALOGS}
{$undef IEINCLUDEWIA}
{$undef IEINCLUDEDIRECTSHOW}
{$undef IEINCLUDEZLIB}
{$undef IEINCLUDEEXTRATRANSITIONS}
{$undef IEINCLUDEFLATSB}
{$endif}


//////////////////////////////////////////////////////////////
// Target selection
//////////////////////////////////////////////////////////////

{$ifdef IEDELPHI}
  // SPECIALS
  {.$define OCXVERSION}
  {.$define IEDOTNETVERSION}
{$endif}

{$ifdef IEDOTNETVERSION}
  {$define OCXVERSION}
{$endif}

{$ifdef OCXVERSION}
  {$undef IEINCLUDEDB}
{$endif}



