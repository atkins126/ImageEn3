(*
File version 1014
*)

// This unit contains only documentation that is not part of class, methods or properties.
// It is not linked or included in packages.

unit iedocum;
interface
implementation

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
INDEX
<AC><FT>ImageEn 3.1.2
<FS>Imaging Components

<FN>Copyright © 1998-2010 by HiComponents. All rights reserved.

<L mailto://support@hicomponents.com>support@hicomponents.com</L>

<L http://www.hicomponents.com>www.hicomponents.com</L>

This software comes without express or implied warranty.
In no case shall the author be liable for any damage or unwanted behavior of any computer hardware and/or software.
HiComponents grants you the right to include the compiled component in your application, whether COMMERCIAL, SHAREWARE or FREEWARE.
ImageEn may not be included in any commercial, shareware or freeware "libraries" or "components".

THE SOFTWARE IS NOT INTENDED FOR USE IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION, COMMUNICATIONS SYSTEMS, OR AIR TRAFFIC CONTROL OR SIMILAR ACTIVITIES IN WHICH CASE THE FAILURE OF THE SOFTWARE COULD LEAD TO DEATH, PERSONAL INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE.
No Rental. Customer may not rent or lease the SOFTWARE to someone else.
All title and copyrights in and to the SOFTWARE (including but not limited to all images, photographs, animations, video, audio, music, text, and other information incorporated into the SOFTWARE),
the accompanying printed materials, and any copies of the SOFTWARE, are owned by HiComponents.
The SOFTWARE is protected by copyright laws and international treaty provisions.
Accordingly, Customer is required to treat the SOFTWARE like any other copyrighted material, except as otherwise allowed pursuant to this LICENSE and that it may make one copy of the SOFTWARE solely for backup or archive purposes.



<FB>C R E D I T S<FN>

<FB>For demos, suggestions and bug fixes<FN>

Bill Miller
<L mailto://w2m@hicomponents.com>w2m@hicomponents.com</L>

Extra transitions implemented by Nigel Cross (nigel@xequte.com) based on TCustomPicShow by Kambiz R. Khojasteh (kambiz@delphiarea.com)

Nitin Chandra
<L mailto://nitinchandra@airtelbroadband.in>nitinchandra@airtelbroadband.in</L>
<L mailto://nitinchandra@yahoo.com>nitinchandra@yahoo.com</L>

Sebastian Zierer
<L mailto://mail@zierer.info>mail@zierer.info</L>
<L http://www.songbeamer.com</L>


<FB>Redeye Removal Algorithm<FN>
"Redeye removal" algorithm developed by Valentim Batista
The author can be contacted at:
<L mailto://timsara@softhome.net>timsara@softhome.net</L>
<L http://timsara.zetafleet.com>http://timsara.zetafleet.com</L>
<L http://www.geocities.com/gc_timsara>http://www.geocities.com/gc_timsara</L>

<FB>Little cms<FN>
Copyright (C) 1998-2004 Marti Maria

<FB>JPEG<FN>
This software is based in part on the work of the Independent JPEG Group

<FB>PNG<FN>
PNG Development Group
Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.
Copyright (c) 1996, 1997 Andreas Dilger
Copyright (c) 1998, 1999 Glenn Randers-Pehrson

<FB>JPEG2000<FN>
This software is based in part on JasPer library
Copyright (c) 1999-2000, Image Power, Inc. and the University of British - Columbia, Canada.
Copyright (c) 2001-2002 Michael David Adams.


!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS><AC>License agreement

<FN>
All users of the ImageEn/IEvolution/ImageEn OCX/ImageEnASP/ImageEnCMD components should agree with the following Licence agreement statements:

1. LEGAL NOTICE
This License Agreement constitutes a valid and binding agreement between you and "HiComponents" (Calandra
Carlotta) for the use of the software named ImageEn/IEvolution/ImageEn OCX/ImageEnASP/ImageEnCMD.
You are required to read this Agreement and agree to all of its terms and conditions in order to download and use the software.

2. LICENSE & USAGE:
You are granted a License to use this Software product by HiComponents without royalties.
Modify, Translate or Create derivative components/libraries from the Software are prohibited!
HiComponents grants you the right to include the compiled component in your application, whether COMMERCIAL, SHAREWARE or FREEWARE.
The Software may not be included in any commercial, shareware or freeware "libraries" or "components".
THE SOFTWARE IS NOT INTENDED FOR USE IN THE OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION, COMMUNICATIONS SYSTEMS,
OR AIR TRAFFIC CONTROL OR SIMILAR ACTIVITIES IN WHICH CASE THE FAILURE OF THE SOFTWARE COULD LEAD TO DEATH, PERSONAL
INJURY, OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE.

4.  DISCLAIMER OF WARRANTY:
This software is provided "as is" without express or implied warranties, including warranties of merchantability and
fitness for a particular purpose or non infringement. HiComponents shall not be liable under any theory or any damages
suffered by you or any user of the software. In no event will the author be liable for any loss of information, damage to
computer or monitor, any incidental, special, indirect or similar damages, or consequential damages (including damages for
loss of business profits, business interruption, loss of business information and the like) arising out of the use of or
inability to use the software or its documentation even if the author has been advised and warned of the possibility of
such damages.
In no event does HiComponents warrant that the Software is error free or that Customer will be able to operate the
Software without problems or interruptions.
This warranty does not apply if the sofware has been altered, except by HiComponents, has not been installed, operated,
repaired, or maintained in accordance with instructions supplied by HiComponents, has been subjected to abnormal physical
or electrical stress, misuse, negligence, or accident, or is used in ultra-hazardous activities.

5.  COPYRIGHT:
ImageEn/IEvolution/ImageEn OCX/ImageEnASP/ImageEnCMD is protected by copyright laws and international treaty provisions.
You acknowledge that no title to the intellectual property of ImageEn/IEvolution/ImageEn OCX/ImageEnASP/ImageEnCMD is transferred to you.
You further acknowledge that title and full ownership rights to ImageEn/IEvolution/ImageEn OCX/ImageEnASP/ImageEnCMD will remain the exclusive property
of HiComponents and you will not acquire any rights to ImageEn/IEvolution/ImageEn OCX/ImageEnASP/ImageEnCMD except as expressly set forth in this license.
No Rental. Customer may not rent or lease the SOFTWARE to someone else.
All title and copyrights in and to the SOFTWARE (including but not limited to all images, photographs, animations, video,
audio, music, text, and other information incorporated into the SOFTWARE), the accompanying printed materials, and any
copies of the SOFTWARE, are owned by HiComponents.

6.  MISCELLANEOUS:
Should you have any questions concerning ImageEn/IEvolution/ImageEn OCX/ImageEnASP/ImageEnCMD license, please contact by electronic mail at:
support@hicomponents.com
Upon using the Software, the user is agreeing with the above statements.
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
CONTENTS
Introduction
 ImageEn=MAININDEX
 Features=Features
 Installation=Installation
 What's new=What's new
 ImageEn hierarchy=ImageEn hierarchy
 Helper functions=Helper functions
 Public variables=Public variables
 The Color Management System=The Color Management System
 Compatibility issues=Compatibility issues
 Supported RAW Camera Formats=List of supported Camera RAW formats
 FAQ=FAQ
 License agreement=License agreement
Display
 TImageEnView component Reference=TImageEnView
 TImageEnVect component Reference=TImageEnVect
 TImageEnMView component Reference=TImageEnMView
Image processing
 TImageEnProc component Reference=TImageEnProc
 TIEICC class reference=TIEICC
Input/output
 TImageEnIO component Reference=TImageEnIO
 TImageEnMIO component Reference=TImageEnMIO
 TOpenImageEnDialog component Reference=TOpenImageEnDialog
 TSaveImageEnDialog component Reference=TSaveImageEnDialog
 TIEHashStream class reference=TIEHashStream
 TIEResourceExtractor class reference=TIEResourceExtractor
 TIETIFFHandler class reference=TIETIFFHandler
 TIETagsHandler class reference=TIETagsHandler
 TIEWICReader class reference=TIEWICReader
 TIEWICWriter class reference=TIEWICWriter
 TIOParamsVals class reference=TIOParamsVals
 TIERFBClient class reference=TIERFBClient
 Custom file format support=Custom file format support
 Lossless Jpeg transformations=Jpeg lossless transformations functions
 Multipage Tiff/Gif functions=Multipage Tiff-Gif functions
Capture
 TImageEnVideoView component Reference=TImageEnVideoView
 TImageEnVideoCap component Reference=TImageEnVideoCap
 TIEDirectShow class reference=TIEDirectShow
 TIEWia class reference=TIEWia
 TIEMediaReader class reference=TIEMediaReader
 TIETWainParams class reference=TIETWainParams
Database
 TImageEnDBView component Reference=TImageEnDBView
 TImageEnDBVect component Reference=TImageEnDBVect
Other components
 THSVBox component Reference=THSVBox
 TRulerBox component Reference=TRulerBox
 TIEGradientBar component Reference=TIEGradientBar
 THistogramBox component Reference=THistogramBox
Other classes
 TIEBitmap class reference=TIEBitmap
 TIEMask class reference=TIEMask
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Features

<FM>Input/output:<FN>
  Asynchronous load/save operations
  Load and save JPEG (RGB, GrayScale, YCbCr, CMYK, YCbCrK) to file or stream (with also 1/2, 1/4 and 1/8 subsizes for fast preview). Read/write APP0-APP15,COM Jpeg markers.
  JPEG2000: JP2, J2K and JPC code stream formats (JPEG-2000 Part-1 standard, ISO/IEC 15444-1)
  Readonly baseline support for single page and multipage DICOM (for medical imaging)
  Jpeg Lossless transformations and cut
  Estimation of Jpeg file quality
  Optional Color Management System (CMS) to process ICC profiles
  Support for Microsoft Color Management System to process ICC profiles
  Read/write of Exif information (in Jpeg, TIFF, RAW, PSD and HD Photo). Can replace EXIF information without loading or changing the original image. Read/write EXIF maker note.
  Read/write EXIF-GPS tags
  Read/write Adobe XMP info from Jpeg, TIFF, HD Photo and PSD file formats.
  Load and save TIFF (rev.6.0 and Tech.Note #2, Packbits, JPEG, LZW, CCITT G.3 and G.4, ZIP) with RGB, CMYK, B/W, CIELab color spaces to file or stream. Also FAX (CCITT3), G3F and G3N (Zetafax) formats supported for loading. Supports paletted 4, 8, 16, 32, 64, 128 and 256 colors  images. Supported Adobe Deflate compression (readonly).
  Load and save Adobe PSD files. Handling of multiple layers.
  Load and save Microsoft HD Photo (also named WMP)
  Available external plugins to load and/or save JBIG, RAW, FITS, PCD and many others.
  Powerful class to handle TIFF files (add/edit/remove tags, add/delete pages, merge TIFFs, etc...)
  Supported several RAW Camera formats (CRW, NEF, ..)
  Native operations on TIFF files supports add/remove/extract/enum without decompressing resulting in 450 times faster processing
  Read of single TIFF tags
  Save PostScript (PS and EPS) format - single and multipage using RLE, G3Fax, G4Fax and Jpeg compression
  Save Adobe PDF format - single and multipage images using G3Fax, G4Fax and Jpeg compression
  Load and save PNG with various compression levels
  Load and save compressed and uncompressed BMP in 2,16, 256 or 16M color images to files or streams
  Load and save uncompressed and black/white WBMP (Wireless Bitmap)
  Load and save compressed and uncompressed PCX images in 2,16, 256 or 16M colors to file or stream
  Support for RAW files, specifing width, height, color format, bit alignment, etc..
  Load and save 2, 4, 8,16, 32, 64, 128 or 256 color GIFs to files or streams
  Load and save DCX (multipage PCX) files
  Load and save DIB, RLE, TGA (TARGA, VDA, ICB, VST, PIX)
  Load and save Portable Bitmap PBM, PGM and PPM
  Load and save ICO (provisions to compose ICO with multi resolution and color depth)
  Load WMF, EMF and CUR
  Load and save AVI, animated GIF and multi page TIFF
  Load and save Window Media formats (MPEG, WMV, etc...), using DirectShow api
  Read of a single AVI frame
  Read/Write IPTC (IIMV4) information (like PhotoShop file info) from JPEG and TIFF. Can replace IPTC information without loading or changing original image
  Support for user defined file formats
  Support for Alpha Channel (transparent and semi-transparent images)
  Editing animated GIF: extract, insert and delete single images
  Editing multi TIFF: extract, insert and delete single images
  Included source code of a sample plug-in to read/write LZW Gif and TIFF
  Get image properties without loading
  Image acquisition from TWAIN scanners with full control of scanner capabilities and without default scanner user interface. Supports both modal and modeless acquisition
  Image acquisition from WIA scanners and cameras
  Save/load specific file format parameters and save/load preview dialogs (e.g. you can set quality of a Jpeg and immediately view the quality loss). Places bar on Win2000/Xp/Me.
  A property to select language used in dialogs: English, Italian, German, Spanish, French, Portuguese, Greek, Russian, Dutch, Swedish, Polish, Japanese, Czech, Finnish, Farsi, Chinese (experimental), Danish, Turkish, Hungarian or customized by user.
  Supports connections with standard TImage component.
  OnProgress/OnFinish events for monitoring saving and loading.
  Support for aborting input/output processing
  Load alpha channel for GIF, TIFF, PNG, ICO, CUR, TGA, PSD
  Capture from screen
  Load images from the network, using http/ftp protocol (LoadFromURL)
  Registration of ImageEn formats in TPicture (TImage and VCL open/save dialogs)
  Wang Imaging annotations (load/edit/save)
  Read/write XP properties of jpeg and tiff files.
  Quality CMYK->RGB and RGB->CMYK conversion using an embedded profile
  RFB (VNC) client to handle a single or multiple VNC connections

<FM>Printing:<FN>
  Printing (and print preview) functions to print single images specifying page alignment or absolute position
  Printing of multiple images (organize images in a sheet or in multiple sheets)

<FM>Video capture:<FN>
  VCL visual component for video capture (freeze frames, save AVI files and real time frames processing). Supports all codec installed and video capture cards
  VCL non-visual component for video capture (capture without display the video input)
  Settable audio capture parameters
  Video capture: using DirectShow (WDM) capture drivers. This allows video sources to be selected by code from video input, tuner, etc
  Video capture of multimedia files supported by DirectShow
  Saving of multimedia files with compressions supported by DirectShow

<FM>Image processing & analysis:<FN>
  Flexible image area selections (rectangle, ellipse, polygon and magicwand) including "soft" selection (you specify the selection intensity from 0 to 100%) and feathering selections
  Regulation of contrast, HSL, HSV/HSB and RGB components
  11 filters for quality resampling (Triangle, Hermite, Bell, BSpline, Lanczos3, Mitchell, Nearest, Linear, FastLinear, Bilinear, Bicubic, ProjectBW, ProjectWB)
  Application of 3x3 filters
  Several automatic color/contrast/luminosity enhancement algorithms
  Merge two images
  Crop selected region
  Fast Fourier Transformation (FFT) with preview
  Frequency domain (FFT) filtering
  Preview of all applied effects in a single dialog, with 8 preset filters (blur, edge detection, emboss, highpass1/ 2/ 3, lowpass1/ 2) and save and load filters from files
  Conversion to gray scale and negative
  Conversions of true color to black/white images with ordered or threshold dithering
  Casting of a group of colors to a single color
  Rotate to any angle (with enhanced quality)
  Horizontal and vertical flip
  Edge detection (to convert color images to black/white using edge detection algorithms)
  Skew detection (to estimate the orientation angle of the lines of text)
  Simple algorithm which helps to remove red eye effect
  Bump mapping effect
  Lens effect
  Wave effect
  Write/read hidden text, picture and raw data inside images (pixel amplitude modulation)
  Copy, cut, paste and paste into a rectangle of all or part of the image
  Multilevel Undo/Redo operations
  Application effects to the selected zones (also irregular)
  OnProgress event for monitoring lengthy image processing tasks
  Histogram equalization (auto and manual) and threshold
  Median cut and Neural network color quantizers, for fast and accurate color reduction
  Reduction to any number of colors (with colormap output)
  HSV channel separations
  A property to select language used by dialogs: English, Italian, German, Spanish, French, Portuguese, Greek, Russian, Swedish, Polish, Japanese, Czech, Finnish, Farsi, Chinese (experimental), Danish, Turkish, Hungarian or customized by user
  A dialog to view a palette and select a color from it
  VCL component for HSV/HSB color selection
  VCL component for displaying histogram of gray levels (or RGB channels)
  Connections with standard TImage component
  Maximum (dilation), Minimum (erosion), Opening and Closing filters with preview
  Horizontal/vertical pixel density histograms
  Noise removal from Black/white images
  Gamma correction
  Gaussian Blur effect
  Soft Shadow effect
  Inner Shadow effect
  Sharpening effect
  Motion blur effect
  Optional Color Management System (CMS) to process ICC profiles
  Manual correction of Barrel Distortion and Pincushion distortion (lens distortion, underwater distortion)
  Supported following native pixel formats: 1bit, 8 bit paletted, 8 bit gray scale, 16 bit gray scale, 24 bit RGB, 32 bit float point, 24 bit CMYK, 48 bit RGB, CIELab
  Crop and AutoCrop functions
  Encrypt/decrypt function using a 128 bit symmetric key algorithm
  Cover-flow style reflection and sperpective effects (this is not fully cover-flow effect, just support routines)
  Adjust of color temperature

<FM>Image rendering:<FN>
  Real time Zoom-in and zoom-out (by percentage, zoom-in rectangular area or by one mouse click, accepts floating point values)
  Support for multiple layers with separated transparency and layer mask
  Select from 37 layer operations (blend modes)
  Moveable, resizeable and rotatable layers (by code or by user interaction)
  Magnify layers (rectangle or like a lens/glass)
  More than 200 transition effects
  Quality zoom effects with six filters (select between fast zoom or quality zoom)
  Alpha Channel (transparent images)
  B/W filtered zoom-in and zoom-out (for optimal display large B/W images inside small rectangles)
  Scrollbar in two dimensions (real time) for the fast exploration of images, and "hand navigation" (click and drag the image with mouse)
  Animate bi-color contour of a selected region (polygonal, irregular, circular and rectangular selections)
  Magic wand selection (inclusive, exclusive and global)
  Multiple selections
  Sizeable and moveable selected regions
  Save/Restore of selections
  Multi-polygonal animated regions
  Dithering for non-true color display adapters
  VCL component to implement interactive rules with grips and numeric labels
  VCL component for interactive gradient bar
  Full support for mouse wheel actions
  Quality view for projects (ZoomFilter = ProjectBW and ProjectWB)

<FM>Thumbnails:<FN>
  Single VCL component to display and animating thumbnails and grids of images. Handles big image sequences without allocating system memory
  3D style and customized thumbnails
  Save a snapshot (save images, caches, texts...) in a single file to instantly reload the component content
  Multi-selection
  Load/Save AVI, GIF, DCX, multimedia formats (using DirectShow), multi-page TIFF images
  Allows to set a wallpaper (background image)
  Multi-threading image loading
  Cache to speed-up image rendering
  Show a custom or preset background under thumbnails
  Loading of EXIF thumbnails to speedup displayes
  Load of entire directories of images using multiple threads and extracting EXIF thumbnails

<FM>Database handling:<FN>
  Data aware component (TImageEnDBView) integrated with Delphi database environment (saves and loads Bmp,Pcx,Jpeg,TIFF,PNG,TGA,PBM,PGM,PPM and Gif inside Blob fields or path reference).
  Data aware component (TImageEnDBVect) integrated with Delphi database environment (saves and loads Bmp,Pcx,Jpeg,TIFF,PNG,TGA,PBM,PGM,PPM and Gif and vectorial objects inside Blob fields or path reference).

<FM>Vectorial objects handling:<FN>
  Vectorial objects (lines, box, circles, ellipses, bitmaps, text, multiline text, static ruler, polylines, polygons, angles, arrows-with text, curved text, highlight box) over background image.
  Save/Load these objects and import a sub-set of Autocad DXF files.
  Undo/Redo capability.
  Support to add/edit/delete points of a polygon.
  Anti-alias capability.
  Settable object transparency.
  Object soft shadow effects.
  Measurement of lines, perimeters and areas (in pixel, inch, cm, mm or Km units).
  Angle measurements.
  Saves/loads IEV format (compressed with Deflate, variation of LZ77 algorithm) that includes images and vectorial objects.
  Anti-aliased text.
  Alpha channel for images objects (transparent images).
  Clipboard Cut/Copy/Paste of vectorial objects.
  Create polygons from raster image edges.
  Remove jagged edges from polygons.
  Polygon simplification.
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
<FS>What's new




<FM>VERSION 3.1.2



<FM>New features<FN>

- added Delphi/C++Builder XE compatibility
- Dicom: supported new compression types
- TIFF: reading TIFF with bogus StripByteCount tag
- TImageEnProc: now motion blur applies also to alpha channel, if present
- improved RGB to CIELab conversion
- added new 25 transitions
- DICOM: added ".v2" extension
- optimized layers rotation
- optimized TImageEnView.LayersMerge and TImageEnView.LayersMergeTo methods
- TIETIFFHandler: enhanced stability on corrupted tags


<FM>Fixed bugs<FN>

- BUGFIX: bug creating a polyline with MouseInteract and after a previous SetObjPolylinePoints
- BUGFIX: fixed some Floating point exceptions using TImageEnVect
- BUGFIX: TImageEnMView.Proc doesn't work after Deselect calls
- BUGFIX: fixed bug mixing multiselections with keyboard and mouse


<FM>New units, classes, methods, properties and events<FN>

- TImageEnView: added OnSetCursor event
- added <A iegPanZoomQualityFilter> public field
- added unit ieXCanvasUtils.pas
- TIEBitmap: added <A TIEBitmap.CopyFromMemory> method
- TIECanvas: added Rotate method
- TIECanvas: added Translate method
- TIECanvas: added ResetTransform method


<FM>New/Changed/Deleted parameters<FN>

- none


<FM>Compatibility issues<FN>

- unknown








<FM>VERSION 3.1.1


<FM>New features<FN>

- now it is possible to abort dcraw loading (using future dcraw versions)


<FM>Fixed bugs<FN>

- BUGFIX: now TIEDirectShow.SetCurrentVideoFormat works (it is possible to change DirectShow video capture resolution in code)
- BUGFIX: now asynchronous loading works (break in 3.1.0)
- BUGFIX: fixed bug saving GIF (break in 3.1.0)
- BUGFIX: wrong TIOParamsVals.ImageCount for multipage TIFF with jpeg compression
- BUGFIX: fixed bug in TImageEnMView.LoadSnapshot and SaveSnapshot (break in 3.1.0)
- BUGFIX: fixed bug in GetPolylineArea


<FM>New classes, methods, properties and events<FN>

- TImageEnVect: added <A TImageEnVect.ObjBlendOperation> property
- TImageEnIO: added <A TImageEnIO.LoadFromResource> method
- TImageEnView: added <A TImageEnView.ResetState> method
- TImageEnVect: added <A TImageEnvect.MaxMovingDistance> property
- TImageEnMView: added <A TImageEnMView.LockUpdateCount> property
- TImageEnMView: added <A TImageEnMView.LockUpdate> method
- TImageEnMView: added <A TImageEnMView.UnLockUpdate> method
- TIEIPTCInfoList: added <A TIEIPTCInfoList.GetItemData> method
- TIEIPTCInfoList: added <A TIEIPTCInfoList.GetItemLength> method


<FM>New/Changed/Deleted parameters<FN>

- none


<FM>Compatibility issues<FN>

- unknown












<FM>VERSION 3.1.0


<FM>New features<FN>

- now it is possible to create a RFB (VNC) client using <A TIERFBClient> objects
- now it is possible to load images from resources in PE files (EXE, DLL, OCX, ICL, etc...)
- optimized rfTriangle, rfHermite, rfBell, rfBSpline, rfLanczos3, rfMitchell, rfNearest, rfLinear filters for multicore processing
- supported MD2, MD4, MD5 and SHA hashing algorithms (to create hash of a image file or of a bitmap)
- now it is possible to remove EXIF tags setting their defaults
- optimized <A TImageEnProc.Reflection> method
- Preview dialog: now "Reset" button can reset only visible tag (optional behavior)
- EXIF Make note: supported FUJIFILM tags
- TImageEnMView: now it is possible to save only selected images using SaveToStreamTIFF and SaveToFileTIFF methods
- added NxN convolution
- TImageEnVect: optimized polyline drawings
- EMF/WMF: now metafiles are loadable from streams
- TIFF: optimized TIFF-CCITT G4 writing
- now TIEBitmap.BlackValue and WhiteValue are applicable also to ie24RGB pixel format
- TImageEnMView.FillFromDirectory: supported Unicode file names for non-Unicode Delphi versions
- open/save dialog: support for non-Unicode OS (Win98/WinME)
- supported Unicode characters on preview, opensave and printing dialogs, for Delphi 2009 and Delphi 2010
- now it is possible to change TImageEnVect measure unit strings
- now TImageEnProc.Fill works with all pixel formats
- added Hungarian translation


<FM>Fixed bugs<FN>

- BUGFIX: now TImageEnMView.OnViewChange works when moving scrollbars
- BUGFIX: in ExtractTIFFImageFile procedure
- BUGFIX: fixed rounding math problem with ielScreen layer blend operation
- BUGFIX: bug making undo of angle and polyline objects
- BUGFIX: fixed bug in TIEBitmap.LoadRAWFromBufferOrStream related to alpha channel
- BUGFIX: dialogs now are center on the same desktop of the parent window
- BUGFIX: now TImageEnMIO.LoadFromFiles calls OnProgress events
- BUGFIX: image processing preview, FFT area is not restored correctly
- BUGFIX: layers cannot be moved dragging the center
- BUGFIX: fixed some minor bugs
- BUGFIX: fixed bug reading/processing jpeg tags with zero length
- BUGFIX: fixed bug reading planar-CMYK with predictor, ZIP compressed
- BUGFIX: TImageEnVect, memo texts now are correctly displayed with vertical bounding box size is not enough
- BUGFIX: better font size handling for Wang Imaging annotations


<FM>New classes, methods, properties and events<FN>

- added <A TIERFBClient> class
- added <A TIEResourceExtractor> class
- added <A TIEHashStream> class
- TImageEnProc: added <A TImageEnProc.Convolve> method
- TImageEnProc: added <A TImageEnProc.UnsharpMask> method
- TPRPreviewsParamsItems: added prppResetSelectedTab value
- TIEBitmap: added <A TIEBitmap.GetHash> method
- TIERenderOperation: added ielStereoEven and ielStereoOdd values
- added <A IEGetCoresCount> public function
- added <A iegDefaultCoresCount> public field
- TImageEnProc: added <A TImageEnProc.CalcAverageRGB> method
- ievect unit: added <A ieMeasureUnits> public field
- TImageEnView: added <A TImageEnView.LayersResizeAspectRatio> property
- TImageEnProc: added <A TImageEnProc.FTClearZone> method
- TImageEnMIO: added <A TImageEnMIO.LoadFromBuffer> method
- TIOParamsVals: added <A TIOParamsVals.IsResource> property
- TImageEnIO: added <A TImageEnIO.ParamsFromBuffer> method
- TImageEnView: added <A TImageEnView.OnVirtualKey> event
- TImageEnProc: added <A TImageEnProc.MatchHSVRange> method
- TImageEnView: added <A TImageEnView.SetLayersBoxStyle> method
- TImageEnMView: added <A TImageEnMView.ImageUserPointer> property
- TImageEnMView: added <A TImageEnMView.DefaultBottomTextFont> property
- TImageEnMView: added <A TImageEnMView.DefaultTopTextFont> property
- TImageEnMView: added <A TImageEnMView.DefaultInfoTextFont> property
- TIEUnits: added ieuFEET, ieuYARDS, ieuMILES values
- TImageEnVect: added <A TImageEnVect.OnPresentMeasure> event
- TIEMultiSelectionOptions: added iemoLeaveOneSelected value (<A TImageEnMView.MultiSelectionOptions> property)
- TIELayerEvent: added ielBeginResizing and ielBeginMoving values (and related events)


<FM>New/Changed/Deleted parameters<FN>

- <A TImageEnProc.Reflection>: added "percentage" parameter
- <A TImageEnMIO.SaveToStreamTIFF>: added optional SaveSelected parameter
- <A TImageEnMIO.SaveToFileTIFF>: added optional SaveSelected parameter
- TImageEnMView.FillFromDirectory: added FilterMask optional parameter
- now TImageEnIO.CreateAVIFile returns an error value


<FM>Compatibility issues<FN>

- unknown











<FM>VERSION 3.0.5


<FM>New features<FN>

- EXIF: set several tags defaults to -1 instead of 0
- TImageEnMView: now SaveSnapshot saves also StoreType property
- TImageEnMView.SaveSnapshot: now can save input/output parameters and tags
- TIOParamsVals.SaveToStream/SaveToFile now saves EXIF tags
- TImageEnMView.SaveSnapshot: now can save EXIF tags


<FM>Fixed bugs<FN>

- BUGFIX: fixed problem reading some unicode EXIF_UserComment tags
- BUGFIX: fixed problems reading RLE encoded images
- BUGFIX: fixed some minor bugs reading DICOM files
- BUGFIX: TaskName parameter of printing preview dialogs now works
- fixed minor bugs


<FM>New classes, methods, properties and events<FN>

- TIERenderOperation: added ielStereoBW, ielStereoColor, ielStereoColorDubois values


<FM>New/Changed/Deleted parameters<FN>

- TImageEnIO.ExecuteOpenDialog: added Filter optional parameter
- TImageEnIO.ExecuteSaveDialog: added Filter optional parameter
- TImageEnMIO.ExecuteOpenDialog: added Filter optional parameter
- TImageEnMIO.ExecuteSaveDialog: added Filter optional parameter
- TImageEnMView.FillFromDirectory: added DetectFileFormat optional parameter
- TIETIFTagsReader.GetRational: added defaultValue optional parameter
- TIETagsHandler.GetRational: added defaultValue optional parameter
- TImageEnMView.SaveSnapshot: added optional parameter SaveParams, to save input/output parameters and tags


<FM>Compatibility issues<FN>

- EXIF: set several tags defaults to <0 instead of 0












<FM>VERSION 3.0.4


<FM>New features<FN>

- added Delphi 2010 compatibility
- TIFF: added support for reading >2GB TIFF files (max 4GB)
- added 22 extra transitions
- open/save dialogs now support Unicode file names (for Delphi non Unicode versions)
- TImageEnMView: better disk cache handling
- DICOM: added jpeg2000 (lossy) decompression
- Optimized MagicWand performance
- now supported reading of 16 bit gray scale PGM
- TImageEnVect: now bitmaps transparent areas aren't selectable
- TIEBitmap: added <A TIEBitmap.Origin> property (improved compatibility with OpenCV)
- now SaveToFileBMPRAW/SaveToStreamBMPRAW/LoadFromFileBMPRAW/LoadFromStreamBMPRAW supports text data
- TImageEnProc: now <A TImageEnProc.DisposeChannels> accepts "0" value
- now <A TImageEnProc.DisposeChannels> works also with ie48RGB pixel format
- now object aspect ratio works on all grips
- TImageEnMView: now SetImageRect copies also transparency
- better Unicode support for EXIF user comment tag
- TImageEnProc.AdjustTemperature: now works on current selection
- enhanced support for EXIF_UserComment tag
- DICOM: now OnProgress works
- now ImageEn writes only changed or new EXIF tags
- now TImageEnMView supports native pixel formats
- ICO: enhanced compatibility
- TImageEnProc: now ieuObjectsAndLayers applied to TImageEnView saves all layers to undo/redo stack
- now it is possible to create a layer from alpha channel
- now it is possible to copy a layer in image alpha channel
- now when <A TIOParamsVals.TIFF_EnableAdjustOrientation>/<A TIOParamsVals.EnableAdjustOrientation> is true, then EXIF orientation becomes 1
- TImageEnSaveDialog: when AttachedImageEnIO is empty now raises an exception instead of silently exit
- now TImageEnIO.ParamsFromFile and ParamsFromFileFormat read parameters from WMF/EMF
- now setting XMP_Info='' removes XMP info from jpegs
- added motion blur, random and map gray color image processing tools

<FM>Fixed bugs<FN>

- FIXED BUG: THistogramBox cannot be placed on forms using Delphi 2009
- FIXED BUG: reading big-endian 16 bit CMYK-TIFF
- FIXED BUG: wrong width/height reading some HDP
- FIXED BUG: memory leak in TIEMediaReader
- FIXED BUG: ondisk cached images cannot exceed 2GB
- FIXED BUG: reading some TIFF files
- FIXED BUG: bad selection precision
- FIXED BUG: reading Unicode file names with ParamsFromFile
- FIXED BUG: now Deinterlace, EdgeDetect_Sobel, ApplyFilter
- FIXED BUG: TIEIPTCInfoList.InsertStringItem now works

<FM>New classes, methods, properties and events<FN>

- TImageEnProc: added <A TImageEnProc.MotionBlur> method
- TImageEnProc: added <A TImageEnProc.Random> method
- TImageEnProc: added <A TImageEnProc.MapGrayToColor> method
- TImageEnView: added <A TImageEnView.SaveState> method
- TImageEnview: added <A TImageEnView.LoadState> method
- TIOParamsVals: added <A TIOParamsVals.BMPRAW_DataFormat> property
- TImageEnView: added <A TImageEnView.OnTransitionPaint> event
- TImageEnView: added <A TImageEnView.SetSelectionMarkOuterStyle> method
- TIPDialogParams: added EQUALIZATION_EqualizeButton field
- TImageEnMView: added <A TImageEnMView.DisplayImageAt> method
- TImageEnVect: added <A TImageEnVect.InsertingPen> property
- TImageEnMView: added <A TImageEnMView.AppendSplit> method
- TImageEnProc: added <A TImageEnProc.CreateFromBitmap> method
- TImageEnIO: added <A TImageEnIO.CreateFromBitmap> method
- TOpenImageEnDialog: added <A TOpenImageEnDialog.FileNameW> property
- TSaveImageEnDialog: added <A TOpenImageEnDialog.FileNameW> property
- TIEBitmap: added <A TIEBitmap.UpdateFromTBitmap> method
- TImageEnVect: added <A TImageEnVect.GetIndexFromObj> method
- TImageEnMView: added <A TImageEnMView.ImageTag> property
- TImageEnVect: added <A TImageEnVect.ObjBitmapHandleTransparencyOnSel> property

<FM>New/Changed/Deleted parameters<FN>

- TImageEnView, LayersAdd: added two optional parameters, PosX and PosY
- TIEDirectShow.GetSample: added "resample" parameter
- TIOParamsVals.EXIF_UserComment: changed type from AnsiString to WideString
- TIEBitmap.EncapsulateMemory: added Origin optional parameter
- TIETransitionType: added iettPageFlipEffect and iettPageFlipEffect2 effects

<FM>Compatibility issues<FN>

- TImageEnSaveDialog: when AttachedImageEnIO is empty now raises an exception instead of silently exit
- now setting XMP_Info='' removes XMP info from jpegs
- TImageEnVect: now bitmaps transparent areas aren't selectable (previous behavior was ObjBitmapHandleTransparencyOnSel=false)
- TIOParamsVals.EXIF_UserComment: changed type from AnsiString to WideString







<FM>VERSION 3.0.3


<FM>New features<FN>

- TWain: now it is possible to set language and country of dialog (when available)
- TImageEnMView: now clicking on current visible image (when <A TImageEnMView.DisplayMode>=grid) selects it
- now it is possible to draw rectangular selection grid guides
- added cover-flow style reflection and perspecive effect (this is not fully cover-flow effect, just support routines)
- optimized TIFF-LZW loading
- TImageEnView: now it is possible to save layers with non-compressed native format (-2 option instead of -1)
- now it is possible to terminate a polyline selection using right mouse button (optional)
- TWain: now it is possible to open scanner dialog only to specify settings (without acquire images)
- TWain: now it is possible to save/load all (supported and unsupported) scanner settings to file or stream
- <A TIETIFFHandler>: now is able to handle HDPhoto files
- now <A FindFileFormat>/<A FindStreamFormat> detects Microsoft HDPhoto image format
- <A TIETIFFHandler>: now handles correctly EXIF and EXIF/GPS tags
- now it is possible to zoom navigator rect using mouse wheel
- now it is possible to create TIFF from scratch using <A TIETIFFHandler>
- now it is possible to copy pages among <A TIETIFFHandler> objects
- now it is possible to extract (or write) a single page from TIFF using <A TIETIFFHandler>
- improved TImageEnView navigator performance
- now it is possible to inject EXIF in a TIFF file or stream
- supported loading/saving of Microsoft HD Photo (WMPhoto) file format (requires Windows XP (SP2) with .Net 3.0, Windows Vista)
- TImageEnVect: now antialiasing is active also with softshadow

<FM>Fixed bugs<FN>

- FIXED BUG: now selection grip shape can be iegsBox
- FIXED BUG: fixed bug using LoadFromBuffer with ioBMPRAW format
- FIXED BUG: TImageEnVect, memo with high font size is displayed incorrectly
- FIXED BUG: fixed memory leak saving ICO
- FIXED BUG: fixed bug in TImageEnMView.RemoveBlankPages
- FIXED BUG: fixed minor bugs reading/writing XP Exif tags
- FIXED BUG: RotateAndCrop ignores "antialias" and "antialiasMode" parameters
- FIXED BUG: wrong image reading color TIFF with inverted fill order
- FIXED BUG: EXIF, ISO Speed Ratings is written when unset or written twice
- FIXED BUG: TImageEnProc.MakeTile doesn't save image in Undo stack
- FIXED BUG: calling TImageEnView.LayersClear or TImageEnView.LayersMergeAll the background layer become unlocked
- FIXED BUG: zooming with mouse wheel on negative placed screens produces wrong results
- FIXED BUG: TImageEnProc.RadialStretch, OnProgress percentage is wrong
- FIXED BUG: memory leak in TImageEnProc.Wave when amplitude=0 and wavelength=0 (the default in image processing dialog)

<FM>New classes, methods and properties<FN>

- TIEBitmap: added <TIEBitmap.PPixels_ie32RGB> property
- TIEBitmap: added <TIEBitmap.Pixels_ie32RGB> property
- TImageEnView: added <A TImageEnView.GetSelectionGripStyle> method
- TImageEnMView: added <A TImageEnMView.ImageCacheUseDisk> property
- TImageEnView: added new overloads of LayersAdd method
- TImageEnView: added <A TImageEnView.LayersCopyToAlpha> method
- TImageEnView: added <A TImageEnView.LayersCreateFromAlpha> method
- imageenio: added iegUseDefaultFileExists public variable
- hyieutils: added <A iegAutoLocateOnDisk> public field
- TIETWainParams: added <A TIETWainParams.Language> property
- TIETWainParams: added <A TIETWainParams.Country> property
- hyieutils: added <A iegAutoFragmentBitmap> public field
- TImageEnView: added <A TImageEnView.SelectionGridSize> property
- TIETIFFHandler: added <A TIETIFFHandler.MovePage> method
- TIETIFFHandler: added <A TIETIFFHandler.ExchangePage> method
- TImageEnView: added <A TImageEnView.OnViewChanging> event
- TImageEnVIew: added <A TImageEnView.GetMaxViewXY> method
- TWain properties: addded <A TIETWainParams.AutoDiscardBlankPages> property
- TImageEnProc: added <A TImageEnProc.Reflection> method
- TImageEnProc: added <A TImageEnProc.PerspectiveDraw> method
- TImageEnProc: added <A TImageEnProc.ProjectDraw> method
- TImageEnProc: added <A TImageEnProc.AdjustTemperature> method
- TIESelectionOptions: added iesoRightButtonTerminatePolySelect value
- TIETWainParams: added <A TIETWainParams.ShowSettingsOnly> property
- TIETWainParams: added <A TIETWainParams.SourceSettings> property
- TIETIFFHandler: added <A TIETIFFHandler.LittleEndian> property
- TIETIFFHandler: added <A TIETIFFHandler.Version> property
- TImageEnProc: added <A TImageEnProc.IsClipboardAvailable> method
- TImageEnView: <A TImageEnView.SetNavigator>, added "options" parameter
- TImageEnVect: added <A TImageEnVect.ObjIsClipboardAvailable> method
- TIETIFFHandler: added <A TIETIFFHandler.InsertPage> method
- TIETIFFHandler: added <A TIETIFFHandler.CopyTag> method
- TImageEnView: added <A TImageEnView.IsNavigator> property
- TImageEnView: added <A TImageEnView.UpdateReason> property
- TImageEnIO: added <A TImageEnIO.InjectTIFFEXIF> method
- added <A IEWICAvailable> public field
- TIOParamsVals: added <A TIOParamsVals.HDP_ImageQuality> property
- TIOParamsVals: added <A TIOParamsVals.HDP_Lossless> property
- TImageEnIO: added <A TImageEnIO.LoadFromFileHDP> method
- TImageEnIO: added <A TImageEnIO.LoadFromStreamHDP> method
- TImageEnIO: added <A TImageEnIO.SaveToFileHDP> method
- TImageEnIO: added <A TImageEnIO.SaveToStreamHDP> method
- add new classes <A TIEWICReader> and <A TIEWICWriter> to support Microsoft Windows Imaging Component (requires Windows XP (SP2) with .Net 3.0, Windows Vista)
- TIEBitmap: added <A TIEBitmap.MergeWithAlpha> method
- TIEBitmap: added <A TIEBitmap.Create> overload
- added iewic unit
- TIEBitmap: added <A TIEBitmap.Write> method
- TIEBitmap: added <A TIEBitmap.Read> method

<FM>New/Changed/Deleted parameters<FN>

- TImageEnProc.<A TImageEnProc.AutoCrop2>: changed type of BorderRate to double
- TImageEnProc: now <A TImageEnProc.Contrast> accepts double values
- TIETIFFHandler, <A TIETIFFHandler.WriteFile>: added "page" optional parameter

<FM>Compatibility issues<FN>

- TImageEnVect: now antialiasing is active also with softshadow
- <A iegUseDefaultFileExists>: default is -false-, meaning ImageEn will use GetFileAttributes instead of FileExists






<FM>VERSION 3.0.2


<FM>New features<FN>

- Delphi 2009 compatibility
- now TImageEnMView can load preview of IEV, ALL and LYR ImageEn formats
- now selection of objects with penWidth>1 works better
- optimized about 2x MedianFilter
- now it is possible to save ICO using <A TImageEnMIO> (or <A TImageEnMView.MIO>)
- now it is possible to send frames from a TImageEnView to another, with delay and a specific time intervals
- TIFF: added support for planar CMYK (8 bit)


<FM>Fixed bugs<FN>

- BUG: fixed bug updating component inside OnCreate event
- BUG: fixed bug in MedianFilter
- BUG: fixed bug loading DICOM, with lossless jpeg encoding
- BUG: fixed bug displaying layers box and grips
- BUG: fixed math rounding problems displaying multiple layers
- BUG: fixed bug with miScroll and multiple layers
- BUG: fixed math rounding problems in Bicubic/Bilinear resampling methods


<FM>New classes, methods and properties<FN>

- TIESelectionOptions: added iesoRightButtonSelectLayers value
- TIOParamsVals: added <A TIOParamsVals.OriginalWidth> property
- TIOParamsVals: added <A TIOParamsVals.OriginalHeight> property
- TImageEnMIO: added <A TImageEnMIO.SaveToFileICO> method
- TImageEnMIO: added <A TImageEnMIO.SaveToStreamICO> method
- TImageEnView: added <A TImageEnView.LayersSelectConstrains> property
- TImageEnView: added <A TImageEnView.BeginPostFrames> method
- TImageEnView: added <A TImageEnView.EndPostFrames> method
- TIERulerBox: added <A TRulerBox.Inverted> property
- TIERulerBox: added <A TRulerBox.ScrollRate> property
- TIEUndoSource: added <A TIEUndoSource> ieuObjectsAndLayers value
- TImageEnView: added <A TImageEnView.UnLockUpdateEx> mehotd
- TImageEnMView: added two overloads to <A TImageEnMView.AppendImage> method
- TImageEnMView: added <A TImageEnMView.RemoveBlankPages> method
- TImageEnMIO: added <A TImageEnMIO.AllowMalformedPages> property


<FM>New/Changed/Deleted parameters<FN>

- TImageEnMView.FillFromDirectory: added ExcludeExtensions optional parameter
- TImageEnMView: <A TImageEnMView.SetImageFromFile> added SourceImageIndex optional parameter
- TImageEnMView: <A TImageEnMView.SetImageFromStream> added SourceImageIndex optional parameter


<FM>Compatibility issues<FN>

- <A TIEFileFormatInfo> is a class instead of a record, so it must be created and sent to IEFileFormatADD
- several demos could raise warnings or not compile under Delphi 2009









<FM>VERSION 3.0.1


<FM>New features<FN>

- improved GIF loading speed
- supported filtered resampling for ie8g images
- now pressing SHIFT rotating a layer, it is rotated in steps of LayersRotateStep values (default 45 degrees)
- added support for Turkish and Korean languages
- now it is possible to smooth scroll moving mouse (without click and drag)
- enhanced quality of Rotate method (without antialias)
- supported loading EXIF from Photoshop CS3
- added sample capture\captFromIPCamera to show how capture live frames from Gran IP Camera III
- now it is possible to enhance jpeg quality with <A TIOParamsVals.JPEG_CromaSubsampling>
- enhanced jpeg quality when <A TIOparamsVals.JPEG_Quality> is 100
- improved speed of filtered resampling routines (like rfTriangle,etc..) and filtered display
- supports for ICC profiles reading PSD files
- now it is possible to load a single tile from a tiled TIFF
- added a strategy to allocate large images in fragmented blocks (to avoid out of memory on fragmented memory)
- TIFF: now supported LZW compressed TIFF with inverted fill order
- TIFF: supported extra channels with premultipled and unassociated alpha channel


<FM>Fixed bugs<FN>

- BUG FIX: now preview dialog is correctly displayed under Vista
- BUG FIX: preview dialog is slow on resizing
- BUG FIX: AV when enough memory is available to allocate a large bitmap
- BUG FIX: fixed memory leak loading some RAW formats
- BUG FIX: fixed memory leak in SeparateObjects and CreatePolygonsFromSelection
- BUG FIX: fixed bug on LayersMergeAll and LayersDrawTo with negative PosX and PosY and without Crop activated
- BUG FIX: TImageEnView, fixed bug setting DisplayGrid=true
- BUG FIX: fixed memory leak saving PNG with text comments
- BUG FIX: sometime multilayer PSD cannot be handled correctly by Photoshop
- BUG FIX: fail to read alpha channel from some PNG files
- BUG FIX: fixed several bugs reading RAW formats
- BUG FIX: now polyline lines are round joined
- BUG FIX: saving GIF (with TImageEnIO) doesn't work with unicode file names


<FM>New classes, methods and properties<FN>

- TImageEnView: added <A TImageenView.LayersRotateStep> property
- TImageEnView: added <A TImageEnView.SetViewXYSmooth> method
- TImageEnView: added <A TImageEnView.SmoothScrollValue> property
- TIEMouseInteractItems: added <A TIEMouseInteractItems> miMovingScroll value
- TImageEnView: added <A TImageEnView.SelectColors> method
- TImageEnProc: added <A TIEBitmap.CopyPaletteTo> method
- TImageEnView: added LayersRotationAntialias property
- TImageEnProc: added CompareHistogramWith method
- TIOParamsVals: added <A TIOParamsVals.EXIF_XPRating> property
- <A TMsgLanguage>: added msKorean value
- TImageEnVect: added <A TImageEnVect.ObjFontQuality> property
- TImageEnVect: added <A TImageEnVect.ObjEnableFastDrawing> property
- TIOParamsVals: added <A TIOParamsVals.JPEG_CromaSubsampling> property
- TIOParamsVals: added <A TIOParamsVals.TIFF_GetTile> property
- TImageEnView: added FixRotationBorders property


<FM>New/Changed/Deleted parameters<FN>

- restored default JPEG_DCTMethod = ioJPEG_ISLOW







<FM>VERSION 3.0.0


<FM>New features<FN>

- now it is possible to load IPTC from DNG (using external plugin)
- added layers mouse action hints
- now it is possible to encrypt/decrypt an image (limitations for lossy file formats)
- now it is possible to rotate layers with mouse
- TImageEnMView, TImageEnVect: now it is possible to set shadow intensity and color
- now selection grips can be circles (now the default) and boxes
- now image processing dialog has a "reset" button (allowing hard and soft reset)
- now image processing preview is correctly displayed at dpi different by 96
- now it is possibile to print multiple images per sheet
- now it is possible to log operation executed inside previews dialog
- TImageEnMIO.Params[].FileName: now is filled for all file formats
- added three binarize algorithms (mean, median and min/max mean)
- improved CMYK->RGB and RGB->CMYK conversion using an embedded profile
- improved DICOM compatibility
- improved scrolling speed of layers with mask
- now it is possible to load URL from secure http (https://...)
- now it is possible to load URL from FTP (ftp://...)
- now TImageEnView, TImageEnMView and inherited components has OnEnter and OnExit events
- improved IPTC compatibility
- TImageEnVect: now filled and closed polygons can be selectable also inside they area
- now <A TImageEnMView> displays file icon instead of question mark for unknown files
- now border of iekLINELABEL objects are modificable
- now iekLINELABEL can be selected also clicking on text
- now iekLINELABEL ending position (text) can be changed without change the whole object position

<FM>Fixed bugs<FN>

- BUG FIX: fixed artifacs in BumpMapping method
- BUG FIX: fixed bug loading URL in <A TImageEnIO>
- BUG FIX: fixed bug enabling multiselect and <A TImageEnMView.SetPresetThumbnailFrame>
- BUG FIX: fixed memory leak loading DICOM
- BUG FIX: now WIA trasnfers with TImageEnMIO fire OnProgress events
- BUG FIX: fixed memory leak reading DICOM images (lossless jpeg encoded)
- BUG FIX: fixed bug saving PSD files (sometime PSD are unreadable by Photoshop)
- BUG FIX: fixed bug in TImageEnMView.LoadSnapshot and SaveSnapShot
- fixed several minor bugs

<FM>New classes, methods and properties<FN>

- TImageEnVect: added <A TImageEnVect.ObjIsVisible> method
- added iegdiplus unit
- TImageEnView: added <A TImageEnView.EnableInteractionHints> property
- TImageEnProc: added <A TImageEnProc.Encrypt> method
- TImageEnProc: added <A TImageEnProc.Decrypt> method
- TIELayer: added <A TIELayer.Rotate> property
- TIELayer: added <A TIELayer.RotateCenterX> property
- TIELayer: added <A TIELayer.RotateCenterY> property
- TImageEnView: added <A TImageEnView.LayersFixRotations> method
- TImageEnView: added <A TImageEnView.LayersFixBorders> method
- <A TIEVSoftShadow>: added Intensity property
- <A TIEVSoftShadow>: added ShadowColor property
- added <A iegUseGDIPlus> public field
- TImageEnView: added <A TImageEnView.SetLayersGripStyle> method
- TImageEnVect: added <A TImageEnVect.ObjGripShape> property
- TImageEnMIO: added <A TImageEnMIO.PrintImages> method
- TImageEnMView: added <A TImageEnMView.MoveSelectedImagesTo>
- TImageEnProc: added <A TImageEnProc.PreviewsLog> property
- TImageEnMView: added <A TImageEnMView.SelectionAntialiased> property
- TImageEnView: added <A TImageEnView.HighlightedPixel> property
- TImageEnProc: added ConvertToBWLocalThreshold method
- imageenio unit: added <A iegUseCMYKProfile> public field
- imageenio: added iegMaxImageEMFSize public field
- TImageEnMView: added OnPlayFrame event
- TIOParamsVals: added <A TIOParamsVals.EnableAdjustOrientation> property
- TImageEnView: added <A TImageEnView.LayersRotationFilter> property
- TImageEnMView: added <A TImageEnMView.LoadIconOnUnknownFormat> property
- TImageEnView: added <A TImageEnView.MoveContentTo> method
- TImageEnVect: added <A TImageEnVect.ObjLabelBorder> property

<FM>New/Changed/Deleted parameters<FN>

- changed <A TIEBitmap.MinFileSize> and <A IEDefMinFileSize> from integer to int64
- <A TImageEnProc.ImageResize>: added optional parameter FillAlpha
- <A TIEMouseInteractItems>: added miRotateLayers value
- <A TIELayerEvent>: added ielRotating value
- <A TIELayerEvent>: added ielRotated value
- now TImageEnVect.ObjAntialias is true for default
- disabled TImageEnVect.ObjGraphicRender modality when gdiplus is available
- <A TImageEnView.SetSelectionGripStyle>: added Shape parameter
- TImageEnVect: renamed GripPen, GripBrush, GripImage and GripSize to <A TImageEnVect.ObjGripPen>, <A TImageEnVect.ObjGripImage>, <A TImageEnVect.ObjGripBrush> and <A TImageEnVect.ObjGripPen>
- TImageEnVect: documented <A TImageEnVect.DrawOneObjectToBitmap> method
- <A TPRPreviewsParamsItems> (<A TImageEnProc.PreviewsParams> property): added prppShowResetButton and prppHardReset values
- TImageEnView: now <A TImageEnView.EnableAlphaChannel> is true for default
- <A TImageEnProc.AutoCrop>: returns the cropped rectangle
- <A TImageEnProc.AutoCrop>: added DoCrop optional parameter
- <A TImageEnIO.ExecuteOpenDialog>: added Title optional parameter
- <A TImageEnIO.ExecuteSaveDialog>: added Title optional parameter
- <A TImageEnMIO.ExecuteOpenDialog>: added Title optional parameter
- <A TImageEnMIO.ExecuteSaveDialog>: added Title optional parameter
- now <A TImageEnMView.Sort> accepts methods other than static functions
- <A TImageEnMView.FillFromDirectory>: added AllowUnknowFormats parameter


!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Installation<FN>

IMPORTANT: Before installing ImageEn, remove old versions of it (remove all pkie*.bpl files).
In order to remove ImageEn you could use <L http://www.hi-components.com/downloads/IERemovalTool.zip>IERemovalTool</L> tool.

Compile pkiectrl, pkiedb, dpkiectrl and dpkiedb packages.
Install packages named DPKIECTRL.BPL and DPKIEDB.BPL in components palette.
Also copy runtime packages named PKIECTRL.BPL and PKIEDB.BPL in a system directory, like C:\Windows\System32, or in Delphi "bin" directory like "C:\Program Files\Embarcadero\Rad Studio\7.0\bin".
On 64 bit operating systems copy runtime packages in "c:\Windows\SysWOW64" directory.

Finally add ImageEn path to C++Builder or Delphi "Library path".
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


{!!
<FS>IPTC items compatible with Adobe PhotoShop<FN>

Record Number=2
DataSet=5
<FB>Object name (max 64 chars)<FN>

Record Number=2
DataSet=7
<FB>Edit status  (max 7 chars)<FN>

Record Number=2
DataSet=10
<FB>Urgency (1 numeric char)<FN>

Record Number=2
DataSet=15
<FB>Category (3 chars)<FN>

Record Number=2
DataSet=20
<FB>Supplemental Category (max 32 chars)<FN>

Record Number=2
DataSet=22
<FB>Fixture Identifier (max 32 chars)<FN>

Record Number=2
DataSet=25
<FB>Keywords (max 64 chars)<FN>

Record Number=2
DataSet=30
<FB>Release Date (CCYYMMDD date)<FN>

Record Number=2
DataSet=35
<FB>Release Time (HHMMSS±HHMM time)<FN>

Record Number=2
DataSet=40
<FB>Special Instructions (max 256 chars)<FN>

Record Number=2
DataSet=45
<FB>Reference Service (max 10 chars)<FN>

Record Number=2
DataSet=47
<FB>Reference Date (CCYYMMDD date)<FN>

Record Number=2
DataSet=50
<FB>Reference Number (max 8 chars)<FN>

Record Number=2
DataSet=55
<FB>Date Created (CCYYMMDD date)<FN>

Record Number=2
DataSet=60
<FB>Time Created (HHMMSS±HHMM time)<FN>

Record Number=2
DataSet=65
<FB>Originating Program (max 32 chars)<FN>

Record Number=2
DataSet=70
<FB>Program Version (max 10 chars)<FN>

Record Number=2
DataSet=75
<FB>Object Cycle (1 char where ‘a’=morning, ‘b’=evening, ‘c’=both)<FN>

Record Number=2
DataSet=80
<FB>By-line (max 32 chars)<FN>

Record Number=2
DataSet=85
<FB>By-line Title (max 32 chars)<FN>

Record Number=2
DataSet=90
<FB>City (max 32 chars)<FN>

Record Number=2
DataSet=95
<FB>Province/State (max 32 chars)<FN>

Record Number=2
DataSet=100
<FB>Country/Primary Location Code (3 chars, see ISO 3166)<FN>

Record Number=2
DataSet=101
<FB>Country/Primary Location Name (max 64 chars)<FN>

Record Number=2
DataSet=103
<FB>Original Transmission Reference (max 32 chars)<FN>

Record Number=2
DataSet=110
<FB>Credit (max 32 chars)<FN>

Record Number=2
DataSet=115
<FB>Source (max 32 chars)<FN>

Record Number=2
DataSet=116
<FB>Copyright Notice (max 128 chars)<FN>

Record Number=2
DataSet=120
<FB>Caption/Abstract (max 2000 chars, carriage-returns, linefeeds and spaces allowed)<FN>

Record Number=2
DataSet=122
<FB>Writer/Editor (max 32 chars)<FN>

Record Number=2
DataSet=130
<FB>Image Type (2 char, see IIMV4 specifications) For all IPTC items, please see the IPTC - NAA Information Interchange Model Version 4 (October 1997). Download the pdf manual from www.iptc.org<FN>
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Helper functions

<FM>Generic file formats<FN>

  <A FindFileFormat>
  <A FindStreamFormat>
  <A IEAddExtIOPlugin>
  <A IEExtToFileFormat>
  <A IEFindNumberWithKnownFormat>
  <A IEGetFileFramesCount>
  <A IEIsInternalFormat>
  <A IsKnownFormat>

<FM>GIF file format<FN>

  <A CheckAniGIF>
  <A DeleteGifIm>
  <A EnumGifIm>
  <A IEOptimizeGIF>

<FM>TIFF file format<FN>

  <A DeleteTIFFImGroup>
  <A DeleteTIFFIm>
  <A EnumTIFFIm>
  <A EnumTIFFStream>
  <A ExtractTIFFImageFile>
  <A ExtractTIFFImageStream>
  <A InsertTIFFImageFile>
  <A InsertTIFFImageStream>

<FM>ICO file format<FN>

  <A EnumICOIm>
  <A IEWriteICOImages>

<FM>DCX file format<FN>

  <A DeleteDCXIm>
  <A EnumDCXIm>

<FM>JPEG<FN>

  <A JpegLosslessTransform>
  <A JpegLosslessTransform2>
  <A JpegLosslessTransformStream>
  <A IECalcJpegFileQuality>
  <A IECalcJpegStreamQuality>

<FM>Register ImageEn file formats in VCL<FN>

  <A IERegisterFormats>
  <A IEUnregisterFormats>

<FM>AVI file format<FN>

  <A IEAVISelectCodec>
  <A IEAVIGetCodecs>
  <A IEAVIGetCodecsDescription>

<FM>Layers<FN>

  <A IELayersMerge>

<FM>Utilities<FN>

  <A IEAlphaToOpacity>
  <A IEGetCoresCount>
  <A IEOpacityToAlpha>
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Jpeg lossless transformations functions

<FM>Defined in ImageEnIO unit<FN>

<A JpegLosslessTransform>
<A JpegLosslessTransform2>
<A JpegLosslessTransformStream>
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Multipage Tiff-Gif functions

<FM>Defined in ImageEnIO unit<FN>

  <FI>GIF file format<FN>

  <A CheckAniGif>
  <A DeleteGifIm>
  <A EnumGifIm>

  <FI>TIFF file format<FN>

  <A DeleteTIFFIm>
  <A EnumTIFFIm>
  <A EnumTIFFStream>
  <A ExtractTIFFImageFile>
  <A ExtractTIFFImageStream>
  <A InsertTIFFImageFile>
  <A InsertTIFFImageStream>
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>The Color Management System<FN>

ImageEn includes a Color Management System (CMS) which if enabled allows to render the image with the original colors.

To enable the CMS you have to write:<FC>

iegEnableCMS := True;

<A iegEnableCMS> <FN>public variable is defined in the unit <FC>imageenio<FN>.


If you want to use LCMS instead of Windows CMS you need to recompile ImageEn (with source code). Make sure that following line inside ie.inc is enabled:

<FC>(*$define IEINCLUDECMS*)<FN>



Enabling the CMS the loading of images with a color profile will be slow.

If you don't define <FC>IEINCLUDECMS<FN> or if you have only compiled version of ImageEn, only Windows CMS will be used. Note that Windows CMS is more quick than LCMS.

See also <A TIEICC>

ImageEn includes parts of Little cms by Marti Maria
Here is the copyright notice of lcms:

Little cms
Copyright (C) 1998-2004 Marti Maria

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Public variables<FN>

  <A DefTEMPPATH>
  <A gBlueToGrayCoef>
  <A gDefaultDPIX>
  <A gDefaultDPIY>
  <A gGreenToGrayCoef>
  <A gRedToGrayCoef>
  <A IEConvertColorFunction>
  <A IEDefDialogCenter>
  <A IEDefMinFileSize>
  <A iegAutoFragmentBitmap>
  <A iegAutoLocateOnDisk>
  <A iegColorReductionAlgorithm>
  <A iegColorReductionQuality>
  <A iegDialogsBackground>
  <A iegDefaultCoresCount>
  <A iegEnableCMS>
  <A iegGRIDPEN>
  <A iegMemoShortCuts>
  <A iegMINZOOMDISPLAYGRID>
  <A iegObjectsTIFFTag>
  <A iegOpSys>
  <A iegPanZoomQualityFilter>
  <A iegPreviewImageBackgroundColor>
  <A iegPreviewImageBackgroundStyle>
  <A iegUseCMYKProfile>
  <A iegUseGDIPlus>
  <A iegUseRelativeStreams>
  <A iegUseDefaultFileExists>

!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Compatibility issues<FN>


* from previous versions to 3.0.4
  - TImageEnSaveDialog: when AttachedImageEnIO is empty now raises an exception instead of silently exit
  - now setting XMP_Info='' removes XMP info from jpegs
  - TImageEnVect: now bitmaps transparent areas aren't selectable (previous behavior was ObjBitmapHandleTransparencyOnSel=false)
  - TIOParamsVals.EXIF_UserComment: changed type from AnsiString to WideString

* from previous versions to 3.0.3
  - TImageEnVect: now antialiasing is active also with softshadow
  - <A iegUseDefaultFileExists>: default is -false-, meaning ImageEn will use GetFileAttributes instead of FileExists

* from previous versions to 3.0.2
  - <A TIEFileFormatInfo> is a class instead of a record, so it must be created and sent to IEFileFormatADD
  - several demos could raise warnings or not compile under Delphi 2009


* from previous versions to 3.0.1
  - to rotate layers with antialias set TImageEnView.LayersRotationAntialias:=true
  - using TImageEnProc.Rotate, set parameter Antialias=true to rotate with antialias
  - now with iegEnableCMS=true, reading PSD profiles are applied and discarded


* from previous versions to 3.0.0
  - sometime text inside MEMO objects could be not visible: enlarge the bounding box.
  - now TImageEnVect.ObjAntialias is true for default
  - TImageEnView: now <A TImageEnView.EnableAlphaChannel> is true for default
  - disabled TImageEnVect.ObjGraphicRender modality when gdiplus is available
  - TImageEnVect: renamed GripPen, GripBrush, GripImage and GripSize to <A TImageEnVect.ObjGripPen>, <A TImageEnVect.ObjGripImage>, <A TImageEnVect.ObjGripBrush> and <A TImageEnVect.ObjGripPen>


Please communicate bugs to support@hicomponents.com

!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>Custom file format support

<FM>Description<FN>
<A IEFileFormatAdd>, <A IEFileFormatRemove>, <A IEFileFormatGetInfo> or <A IEFileFormatGetInfo2> allow applications to register custom file format readers/writers.
Please look at examples to learn how add custom file formats to ImageEn.

The only function you need to add custom file format is <A IEFileFormatAdd>.
You have to allocate and fill a <A TIEFileFormatInfo> structure to the above function.
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>WIA device properties

<FM>Device Information Property Constants

<FM>WIA_DIP_BAUDRATE<FN>
The baud rate of serial devices.

<FM>WIA_DIP_DEV_DESC<FN>
A description of the device.

<FM>WIA_DIP_DEV_ID<FN>
A device ID that is unique per physical device. This ID is composed of the Still Image class name followed by the device index. This ID is generated by the operating system.

<FM>WIA_DIP_DEV_NAME<FN>
A user-readable device name.

<FM>WIA_DIP_DEV_TYPE<FN>
An STI device type constant. Use the GET_STI_DEVICE_TYPE macro to get the device type. Currently, device types are defined as follows.
Type	Definition
stiDeviceTypeDefault	When enumerating devices, any device that matches.
stiDeviceTypeScanner	Device that is represented as a scanner (see the WIA_DPS_DOCUMENT_HANDLING_CAPABILITIES to determine if the scanner is flatbed or sheet-fed).
stiDeviceTypeDigitalCamera	Device that is represented as a camera.
stiDeviceTypeStreamingVideo	Device that is represented as streaming video.

<FM>WIA_DIP_DRIVER_VERSION<FN>
The DLL version number of the driver's USD file.

<FM>WIA_DIP_HW_CONFIG<FN>
The "hardwareConfig" entry in the driver's INF file.

<FM>WIA_DIP_PORT_NAME<FN>
Name of the port through which the device is connected.

<FM>WIA_DIP_REMOTE_DEV_ID<FN>
The ID of the remote device.

<FM>WIA_DIP_SERVER_NAME<FN>
The name of the server where the WIA server for this device is running.

<FM>WIA_DIP_STI_GEN_CAPABILITIES<FN>
The driver's "STI_USD_CAPS.dwGenericCaps" value. This value contains the driver's "DeviceType" and "DeviceSubType" values.

<FM>WIA_DIP_UI_CLSID<FN>
The class ID of the UI component.

<FM>WIA_DIP_VEND_DESC<FN>
The device manufactures name.

<FM>WIA_DIP_WIA_VERSION<FN>
The version of WIA.


<FM>Common Device Property Constants

<FM>WIA_DPA_CONNECT_STATUS<FN>
Device connect status. This is intended for serial devices or other non-Plug and Play devices where the operating system cannot determine if the device is connected. There are only two defined values for this property, as follows.
Connect Status	Definition

<FM>WIA_DEVICE_NOT_CONNECTED<FN>
Device is not connected

<FM>WIA_DEVICE_CONNECTED<FN>
Device is connected and operational

<FM>WIA_DPA_FIRMWARE_VERSION<FN>
Firmware version number. The value for the firmware version number is up to the device. For example, "4.2.3".



<FM>Scanner Device Property Constants<FN>

<FM>WIA_DPS_DITHER_PATTERN_DATA<FN>
Reserved for future use.

<FM>WIA_DPS_DITHER_SELECT<FN>
Reserved for future use.

<FM>WIA_DPS_DOCUMENT_HANDLING_CAPABILITIES<FN>
This property reports the document handling capabilities of a scanner. This property is mandatory for sheet-fed, scroll-fed, and hand-held scanners, and for scanners that have an automatic document feeder. If this property is not present, the application can assume that the scanner does not have an automatic document feeder. The document handling capability flags include the following:
Flags	Description
WIA_FEED	The scanner has an automatic document handler installed.
WIA_FLAT	The scanner has a flatbed platen.
WIA_DETECT_FLAT	The scanner can detect a document on the flatbed platen.
WIA_DETECT_SCAN	The scanner can detect a document in the feeder only by scanning.
WIA_DETECT_FEED	The scanner can detect a document in the feeder.
WIA_DETECT_DUP	The scanner can detect a duplex scan request from the user.
WIA_DETECT_FEED_AVAIL	The scanner can tell when the automatic document feeder is installed.
WIA_DETECT_DUP_AVAIL	The scanner can tell when the duplexer is installed.
WIA_DUP	The scanner has a duplexer.

<FM>WIA_DPS_DOCUMENT_HANDLING_CAPACITY<FN>
This property reports the maximum number of pages that the document handler input tray can accept. Do not use this property. Use the WIA_DPS_PAGES property instead.

<FM>WIA_DPS_DOCUMENT_HANDLING_SELECT<FN>
On scanners with an automatic document feeder, this property selects the document-handling mode. This property is mandatory for scanners with an automatic document feeder. The mode flags include the following.
Flags	Description
WIA_FEEDER	Scan from the document feeder.
WIA_FLATBED	Scan from flatbed platen.
WIA_DUPLEX	Place feeder in duplex mode.
WIA_AUTO_ADVANCE	Enables automatic feeding of the next document after a scan.
WIA_FRONT_FIRST	Scan the front (top) of a document first when doing duplex scanning.
WIA_BACK_FIRST	Scan the back (bottom) of a document first when doing duplex scanning.
WIA_FRONT_ONLY	Scan only the front (top) of a document.
WIA_BACK_ONLY	Scan only the back (bottom) of a document.
WIA_NEXT_PAGE	Scan the next page of the document.
WIA_PREFEED	Enable pre-feed mode. Pre-position next document while scanning.

Because this property is read/write, the driver implements two values for this property: a valid value and a current value. The bits in the valid value indicate values the driver and device support.
For example, if the scanner supports allowing the application to select feeder mode, the FEEDER bit in the valid value for this property is set. The application selects feeder mode by setting the FEEDER bit in the current value.
Scanners have a device item associated with each scan head in the scanner. These items, together with the "Document Handling Select" property, completely specify the source of a scan. The following examples are provided to clarify the use of the "Document Handling Select" property on different scanner hardware configurations:
"	For a flatbed or hand held scanner with no automatic document handling, this property would not be implemented.
"	If a duplex scanner does not support programmable (front/back) page order, either FRONT_FIRST or BACK_FIRST must still be available as a flag so that applications can detect the page order. An error should be generated if an application tries to change the order.
"	A non-duplex scanner with automatic document handling must support either the FRONT_ONLY or BACK_ONLY flag so that applications can detect the page orientation. An error should be generated if an application tries to change the page orientation.
WIA_DPS_DOCUMENT_HANDLING_STATUS
This property reports the real-time document handling status of a scanner. This property is mandatory for sheet-fed, scroll-fed, and hand-held scanners, and for scanners that have an automatic document feeder. The status flags include the following.
Flags	Description
WIA_FEED_READY	The document handler has a page ready to feed.
WIA_FLAT_READY	The scanner has a document on the flatbed platen.
WIA_DUP_READY	The scanner has detected a duplex request from the user.
WIA_FLAT_COVER_UP	The flat bed cover is up.
WIA_PATH_COVER_UP	The paper path cover is up.
WIA_PAPER_JAM	There is a document jam in the paper path.

<FM>WIA_DPS_ENDORSER_CHARACTERS<FN>
Returns a string that contains all of the valid characters that are printed by the endorser. This property is optional.

<FM>WIA_DPS_ENDORSER_STRING<FN>
Specifies a string that is printed onto the document when it is scanned. The endorser string supports using tokens that are replaced with values by the system. This property is optional. The following tokens are supported.
Token	Description
$DATE$	The date in the form YYYY/MM/DD.
$DAY$	The day in the form DD.
$MONTH$	The month of the year in the form MM.
$PAGE_COUNT$	The number of pages transferred.
$TIME$	The time of day in the form HH:MM:SS.
$YEAR$	The year in the form YYYY.

<FM>WIA_DPS_FILTER_SELECT<FN>
Reserved for future use.

<FM>WIA_DPS_HORIZONTAL_BED_REGISTRATION<FN>
Indicates how the sheet is positioned horizontally on the platen of a flatbed scanner. It is used to predict where a document is placed across the platen. It takes one of the following constants.
Constant	Description
WIA_LEFT_JUSTIFIED	The sheet is positioned to the left with respect to the platen.
WIA_CENTERED	The sheet is centered on the platen.
WIA_RIGHT_JUSTIFIED	The sheet is positioned to the right with respect to the platen.

On scanners that support more than one scan head, this property is relative to the top scan head. This property is mandatory for scanners that have a platen.

<FM>WIA_DPS_HORIZONTAL_BED_SIZE<FN>
Specifies the maximum width, in thousandths of an inch, that is scanned in the horizontal (X) axis from the platen of a flatbed scanner at the current resolution. This property also applies to automatic document feeders that move sheets to the platen of a flatbed scanner for scanning. This property is mandatory for scanners that have a platen.. Other scanner types will instead implement the WIA_DPS_HORIZONTAL_SHEET_FEED_SIZE property.

<FM>WIA_DPS_HORIZONTAL_SHEET_FEED_SIZE<FN>
Specifies the maximum width, in thousandths of an inch, that is scanned in the horizontal (X) axis from a handheld or sheet feed scanner at the current resolution. This property also applies to automatic document feeders that scan without moving sheets to the platen of a flatbed scanner. This property is mandatory for sheet-fed, scroll-fed, and hand-held scanners.

<FM>WIA_DPS_MAX_SCAN_TIME<FN>
This property reports the maximum time, in milliseconds, to scan a page with the current property settings. Applications use this value for detecting hung device error conditions. This property is required for all scanners.

<FM>WIA_DPS_MIN_HORIZONTAL_SHEET_FEED_SIZE<FN>
Specifies the minimum width, in thousandths of an inch, that is scanned in the horizontal (X) axis from a handheld or sheet feed scanner at the current resolution. This property also applies to automatic document feeders that scan without moving sheets to the platen of a flatbed scanner. This property is mandatory for sheet-fed, scroll-fed, and hand-held scanners.

<FM>WIA_DPS_MIN_VERTICAL_SHEET_FEED_SIZE<FN>
Specifies the maximum width, in thousandths of an inch, that is scanned in the vertical (Y) axis from a handheld or sheet feed scanner at the current resolution. This property also applies to automatic document feeders that scan without moving sheets to the platen of a flatbed scanner. This property is mandatory for sheet-fed, scroll-fed, and hand-held scanners.

<FM>WIA_DPS_OPTICAL_XRES<FN>
Horizontal Optical Resolution. Highest supported horizontal optical resolution in DPI. This property is a single value. This is not a list of all resolutions that can be generated by the device. Rather, this is the resolution of the device's optics. This property is required for all scanners.

<FM>WIA_DPS_OPTICAL_YRES<FN>
Vertical Optical Resolution. Highest supported vertical optical resolution in DPI. This property is a single value. This is not a list of all resolutions that are generated by the device. Rather, this is the resolution of the device's optics. This property is required for all scanners.

<FM>WIA_DPS_PAGE_HEIGHT<FN>
Indicates the maximum height, in thousandths of an inch, of the page to be scanned This property is optional.

<FM>WIA_DPS_PAGE_WIDTH<FN>
Indicates the maximum width, in thousandths of an inch, of the page to be scanned. This property is optional.

<FM>WIA_DPS_PAGES<FN>
Specifies the number of pages to scan. The valid values for this property are represented as a range of values. For scanners with an automatic document feeder, the maximum value of the range represents the document feeder's capacity. If WIA_DPS_DOCUMENT_HANDLING_CAPACITY is used, the maximum value in this range must be the same as the value of WIA_DPS_DOCUMENT_HANDLING_CAPACITY. This property is mandatory for all scanners with an automatic document feeder, and for all sheet-fed, scroll-fed, and hand-held scanners.

<FM>WIA_DPS_PREVIEW<FN>
This property indicates whether or not the device supports preview scans. For example, sheet-fed and hand-held scanners cannot preview. The application should set this property when it does a preview scan so that the device can be optimized for previewing. This property is optional for all scanners..

<FM>WIA_DPS_SCAN_AHEAD_PAGES<FN>
Specifies the number of pages that are scanned ahead to local scanner or driver memory on scanners that support scan ahead. A value of zero disables scan ahead. The following negative value constant is supported.
Constant	Description
WIA_SCAN_AHEAD_ALL	Scan ahead as far as possible.

Doing normal data transfers on the buffered scan head item retrieves the buffered pages. Device and item properties may not be changed during a scan-ahead operation. Scanners that support only WIA_SCAN_AHEAD_ALL would report only this value as min, max, and nominal in the valid values for one property. This property is optional.
WIA_DPS_SHEET_FEEDER_REGISTRATION
Indicates how the sheet is positioned horizontally on the scanning head of a hand-held or sheet-fed scanner. It is used to predict where a document is placed across the scan head. It takes one of the following constants.
Constant	Description
WIA_LEFT_JUSTIFIED	The sheet is positioned to the left with respect to the scanning head.
WIA_CENTERED	The sheet is centered on the scanning head.
WIA_RIGHT_JUSTIFIED	The sheet is positioned to the right with respect to the scanning head.

On scanners that support more than one scan head, this property is relative to the top scan head. This property is mandatory for sheet-fed, scroll-fed, and hand-held scanners.
WIA_DPS_SHOW_PREVIEW_CONTROL
Indicates whether the user interface displays a preview control for the scanner. This property has one of the following constant values:
Constant	Description
WIA_SHOW_PREVIEW_CONTROL	The scanner supports displaying a preview control.
WIA_DONT_SHOW_PREVIEW_CONTROL	The scanner does not support displaying a preview control.

<FM>WIA_DPS_TRANSPARENCY<FN>
Indicates the capabilities and status of an alternate light source/path (transparency adapter) in the scanner for scanning transparencies or slides. This property is mandatory for scanners that have a transparency attachment. The following flags are defined:
Flag	Description
WIA_LIGHT_SOURCE_PRESENT_DETECT	The scanner detects when the transparency adapter is present.
WIA_LIGHT_SOURCE_PRESENT	A transparency adapter is present.
WIA_LIGHT_SOURCE_DETECT_READY	The scanner detects when media is placed on the transparency scanning bed.
WIA_LIGHT_SOURCE_READY	The user selected the transparency adapter at the scanner.

<FM>WIA_DPS_TRANSPARENCY_SELECT<FN>
Used by the application to select the alternate light source/path or transparency adapter. This property is mandatory for scanners that have a transparency attachment. The following flags are defined:
Flag	Description
WIA_LIGHT_SOURCE_SELECT	Turns on the transparency adapter.

<FM>WIA_DPS_VERTICAL_BED_REGISTRATION<FN>
Indicates how the sheet is positioned vertically on the platen of a flatbed scanner. It is used to predict where a document is placed on the platen. It takes one of the following constants.
Constant	Description
WIA_TOP_JUSTIFIED	The sheet is positioned to the top with respect to the platen.
WIA_CENTERED	The sheet is centered on the platen.
WIA_BOTTOM_JUSTIFIED	The sheet is positioned to the bottom with respect to the platen.

On scanners that support more than one scan head, this property is relative to the top scan head. This property is mandatory for scanners that have a platen.
WIA_DPS_VERTICAL_BED_SIZE
Specifies the maximum height, in thousandths of an inch, that is scanned in the vertical (Y) axis from the platen of a flatbed scanner at the current resolution. This property also applies to automatic document feeders, that move sheets to the platen of a flatbed scanner for scanning. This property is mandatory for scanners that have a platen. Other scanner types will instead implement the WIA_DPS_VERTICAL_SHEET_FEED_SIZE property.
WIA_DPS_VERTICAL_SHEET_FEED_SIZE
Specifies the maximum height, in thousandths of an inch, that is scanned in the vertical (Y) axis from a handheld or sheet feed scanner at the current resolution. This property also applies to automatic document feeders that scan without moving sheets to the platen of a flatbed scanner. This property is mandatory for sheet-fed scanners. Scroll-fed and hand-held scanners should not implement this property.
WIA_DPS_WARM_UP_TIME
Indicates to the application how long, in milliseconds, it takes the scanner and/or lamp to warm up before scanning commences. The application can display a progress indicator to the user based on this value. If the device requires no warm-up, the value should be zero. This property is required for all scanners.


<FM>Camera Device Property Constants<FN>

<FM>WIA_DPC_ARTIST<FN>
The name of the photographer.

<FM>WIA_DPC_BATTERY_STATUS<FN>
Camera battery life remaining, represented as a value from 100 (full charge) to 0.

<FM>WIA_DPC_BURST_INTERVAL<FN>
The time, in milliseconds, between image captures during a burst operation.

<FM>WIA_DPC_BURST_NUMBER<FN>
The number of images the device attempts to capture during a burst operation.

<FM>WIA_DPC_CAPTURE_DELAY<FN>
The time, in milliseconds, between the firing of the capture trigger and the actual initiation of the data capture. For no pre-capture delay, set this property to zero.
This property is not intended to be used to describe the time between frames for single-initiation multiple captures such as burst or time-lapse.

<FM>WIA_DPC_CAPTURE_MODE<FN>
Sets the image-capturing mode.
Capture Mode	Description
WIA_CAPTUREMODE_NORMAL	Normal mode for the camera.
WIA_CAPTUREMODE_BURST	Capture more than one image in quick succession as defined by the values of WIA_DPC_BURST_NUMBER and WIA_DPC_BURST_INTERVAL.
WIA_CAPTURMODE_TIMELAPSE	Capture more than one image in succession as defined by WIA_DPC_TIMELAPSE_NUMBER and WIA_DPC_TIMELAPSE_INTERVAL.

<FM>WIA_DPC_COMPRESSION_SETTING<FN>
A numeric value that specifies relative image quality. This property is device-specific.

<FM>WIA_DPC_CONTRAST<FN>
The perceived contrast of captured images. This property can use either an enumeration or a range.

<FM>WIA_DPC_COPYRIGHT_INFO<FN>
Copyright information for the image.

<FM>WIA_DPC_DIGITAL_ZOOM<FN>
The effective zoom ratio of the digital camera's acquired image scaled by a factor of 10. No digital zoom (1X) corresponds to a value of 10, which is the standard scene size captured by the camera. A value of 20 corresponds to a 2X zoom where 1/4 of the standard scene size is captured by the camera.

<FM>WIA_DPC_DIMENSION<FN>
Reserved, do not use.

<FM>WIA_DPC_EFFECT_MODE<FN>
Specifies the special image acquisition mode of the camera.
Effect Mode	Description
WIA_EFFECTMODE_STANDARD	The standard mode for the camera.
WIA_EFECTMODE_BW	Capture a grayscale image.
WIA_EFFECTMODE_SEPIA	Capture a sepia image.

<FM>WIA_DPC_EXPOSURE_COMP<FN>
Exposure compensation when using automatic exposure mode. Valid values are from -200 to 200 in increments of 50. These values represent the range -2.0 to +2.0.

<FM>WIA_DPC_EXPOSURE_INDEX<FN>
Specifies the film speed for digital cameras that can emulate ISO (ASA/DIN) speed settings. Typically, a device supports discrete enumerated values, but continuous control over a range is possible.
A value of 0xFFFF corresponds to Automatic ISO setting.

<FM>WIA_DPC_EXPOSURE_METERING_MODE<FN>
Specifies the mode the camera uses to automatically adjust the exposure setting.
Exposure Metering Mode	Description
WIA_EXPOSUREMETERING_AVERAGE	Set the exposure based on an average of the entire scene.
WIA_EXPOSUREMETERING_CENTERWEIGHT	Set the exposure based on a center-weighted average.
WIA_EXPOSUREMETERING_MULTISPOT	Set the exposure based on a multi-spot pattern.
WIA_EXPOSUREMETERING_CENTERSPOT	Set the exposure based on a center spot.

<FM>WIA_DPC_EXPOSURE_MODE<FN>
Camera exposure mode.
Exposure Mode	Description
WIA_EXPOSURE_MODE_MANUAL 	The shutter speed and aperture are set by the user.
WIA_EXPOSUREMODE_AUTO	The shutter speed and aperture are automatically set by the camera.
WIA_EXPOSUREMODE_APERTURE_PRIORITY	The aperture is set by the user, and the camera automatically sets the shutter speed.
WIA_EXPOSUREMODE_SHUTTER_PRIORITY	The shutter speed is set by the user, and the camera automatically sets the aperture.
WIA_EXPOSUREMODE_PROGRAM_CREATIVE	The shutter speed and aperture are automatically set by the camera, optimized for still subject matter.
WIA_EXPOSUREMODE_PROGRAM_ACTION	The shutter speed and aperture are automatically set by the camera, optimized for scenes containing fast motion.
WIA_EXPOSUREMODE_PORTRAIT	The shutter speed and aperture are automatically set by the camera, optimized for portrait photography.

<FM>WIA_DPC_EXPOSURE_TIME<FN>
Manual exposure time. Units are milliseconds. The camera may represent the range of manual exposure settings it supports through the property attributes. Manual exposure time is only used when the camera is in manual exposure mode.
WIA_DPC_FLASH_MODE
Camera flash mode. Flash modes include the following.
Flash Mode	Definition
WIA_FLASH_MODE_AUTO	Camera determines whether to flash.
WIA_FLASH_MODE_FILL	Camera flashes, regardless of light conditions.
WIA_FLASH_MODE_OFF	Camera will not flash.
WIA_FLASH_MODE_REDEYE_AUTO	Camera determines whether to flash, using red eye reduction.
WIA_FLASH_MODE_REDEYE_FILL	Camera flashes, regardless of light conditions, using red eye reduction.
WIA_FLASH_MODE_EXTERNALSYNC	Camera syncs external flash units.

<FM>WIA_DPC_FNUMBER<FN>
Manual F-number setting for use when the camera is in F-number exposure mode. Exposure mode is represented as camera F-number x 100. For example, Number 5.0 = 500.

<FM>WIA_DPC_FOCAL_LENGTH<FN>
The 35mm equivalent focal length, in 100ths of a millimeter.

<FM>WIA_DPC_FOCUS_DISTANCE<FN>
The distance, in millimeters, between the image-capturing plane of the digital camera and the point of focus.
A value of $FFFF corresponds to a setting greater than 655 meters.

<FM>WIA_DPC_FOCUS_MANUAL_DIST<FN>
Reserved, do not use.

<FM>WIA_DPC_FOCUS_METERING<FN>
Reserved, do not use.

<FM>WIA_DPC_FOCUS_METERING_MODE<FN>
Specifies the mode the camera uses to automatically adjust the focus.
Focus Metering Mode	Description
WIA_FOCUSMETERING_CENTERSPOT	Adjust the focus based on a center spot.
WIA_FOCUSMETERING_MULTISPOT	Adjust the focus based on a multi-spot pattern.

<FM>WIA_DPC_FOCUS_MODE<FN>
Specifies the focus mode of the digital camera.
Focus Mode	Description
WIA_FOCUSMODE_MANUAL	The focus is set by the user.
WIA_FOCUSMODE_AUTO	The focus is automatically set by the camera.
WIA_FOCUSMODE_MACROAUTO	The focus is automatically set by the camera to a macro (short-range) setting.

<FM>WIA_DPC_PAN_POSITION<FN>
Specifies the pan position for aiming the camera.

<FM>WIA_DPC_PICT_HEIGHT<FN>
The height to use for newly captured images. The list of valid values for this property has a one-to-one correspondence to the list of valid values for the WIA_DPC_PICT_WIDTH property.

<FM>WIA_DPC_PICT_WIDTH<FN>
The width to use for newly captured images. The list of valid values for this property has a one-to-one correspondence to the list of valid values for the WIA_DPC_PICT_HEIGHT property.

<FM>WIA_DPC_PICTURES_REMAINING<FN>
Number of pictures the device may still capture based on the current device capture settings.

<FM>WIA_DPC_PICTURES_TAKEN<FN>
Number of pictures taken. This property is mandatory for all cameras.

<FM>WIA_DPC_POWER_MODE<FN>
This property is used to determine whether the device is operating on battery or line power.
Power Mode	Description
WIA_POWERMODE_LINE	AC or other power adapter.
WIA_POWERMODE_BATTERY	Running off batteries.

<FM>WIA_DPC_RGB_GAIN<FN>
A null-terminated Unicode string that represents the red, green, and blue gain applied to image data, respectively. For example, "4:25:50" (null-terminated) represents a red gain of 4, a green gain of 25, and a blue gain of 50.

<FM>WIA_DPC_SHARPNESS<FN>
The perceived sharpness of captured images. This property can use either an enumeration or a range.

<FM>WIA_DPC_THUMB_HEIGHT<FN>
The height, in pixels, of thumbnails created for captured images. The list of valid values for this property have a one-to-one correspondence to the list of valid values for the WIA_DPC_THUMB_WIDTH property.

<FM>WIA_DPC_THUMB_WIDTH<FN>
The width, in pixels, of thumbnails created for captured images. The list of valid values for this property have a one-to-one correspondence to the list of valid values for the WIA_DPC_THUMB_HEIGHT property.

<FM>WIA_DPC_TILT_POSITION<FN>
Specifies the tilt position for aiming the camera.

<FM>WIA_DPC_TIMELAPSE_INTERVAL<FN>
The time, in milliseconds, between image captures in a time-lapse capture operation.

<FM>WIA_DPC_TIMELAPSE_NUMBER<FN>
The number of images the device attempts to capture during a time-lapse capture.

<FM>WIA_DPC_TIMER_MODE<FN>
Automatic picture timer mode.

<FM>WIA_DPC_TIMER_VALUE<FN>
Automatic picture timer time setting in milliseconds. This value is only used when taking a picture through computer control and when the timer mode is on.

<FM>WIA_DPC_UPLOAD_URL<FN>
A URL to which to upload images from a digital camera.

<FM>WIA_DPC_WHITE_BALANCE<FN>
Specifies how the digital camera weights color channels.
White Balance	Description
WIA_WHITEBALANCE_MANUAL	White balance is set directly with the WIA_DPC_RGBGAIN property.
WIA_WHITEBALANCE_AUTO	The camera uses an automatic mechanism to set the white balance.
WIA_WHITEBALANCE_ONEPUSH_AUTO	The camera determines the white balance setting when a user presses the capture button while pointing the camera at a white surface.
WIA_WHITEBALANCE_DAYLIGHT	The camera sets the white balance to a value appropriate for use in daylight conditions.
WIA_WHITEBALANCE_FLORESCENT	The camera sets the white balance to a value appropriate for use with a fluorescent light source.
WIA_WHITEBALANCE_TUNGSTEN	The camera sets the white balance to a value appropriate for use with a tungsten light source.
WIA_WHITEBALANCE_FLASH	The camera sets the white balance to a value appropriate for use with an electronic flash.

<FM>WIA_DPC_ZOOM_POSITION<FN>
Reserved, do not use

!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>WIA item properties

<FM>Common WIA Item Property Constants<FN>

<FM>WIA_IPA_ACCESS_RIGHTS<FN>
This flag controls access to the item as well as whether the item is deleted. This property is read only for scanners and read/write for cameras, depending on whether the camera supports changing the access rights
Access Right	Description
WIA_ITEM_READ 	Item has read-only access.
WIA_ITEM_WRITE	Item has write-only access.
WIA_ITEM_CAN_BE_DELETED	Item has delete-only access.
WIA_ITEM_RD	Item has read and delete access.
WIA_ITEM_RWD	Item has read, write, and delete access.

<FM>WIA_IPA_APP_COLOR_MAPPING<FN>
By default, it is the responsibility of the driver to map images from the user-selected profile to SRGB. If an application uses the ICM system to handle color profiles, it sets this property to instruct the driver to stop mapping automatically. The image is then in the color space specified by the WIA_IPA_COLOR_PROFILE property.

<FM>WIA_IPA_BITS_PER_CHANNEL<FN>
Bits per color channel. 1 for 1 bit per pixel black and white; 8 for 8-bit-per-pixel RGB. This property is read/write for scanners that support different bits-per-pixel settings. Otherwise it is read only.

<FM>WIA_IPA_BYTES_PER_LINE<FN>
Bytes per line of scan data. Some scanners may pad scan lines with extra bytes to make the scan line a fixed number of DWORDS. This is a read-only property and is set by the device, based on the scan settings.

<FM>WIA_IPA_CHANNELS_PER_PIXEL<FN>
Number of color channels per pixel. Typical values are 1 for black and white data; 3 for RGB.

<FM>WIA_IPA_COLOR_PROFILE<FN>
This property specifies the International Color Consortium (ICC) color profile for the images produced by the item.
When the WIA_IPA_APP_COLOR_MAPPING property is set, the current value of this property indicates the color profile for images produced by the WIA item. If the color mapping property is not set, the driver will map images from the current value of this property to sRGB.
This property should not be set by the application or driver. It is managed by WIA based on user input. The valid values setting lists the profiles the user has associated with the device.

<FM>WIA_IPA_COMPRESSION<FN>
Specifies the compression within the given data format. Useful for data formats like TIFF and DIB that have optional compressed modes.
This property is read/write for devices that support more than one compression type. For all other devices, it is read only.
Compression Type	Description
WIA_COMPRESSION_NONE	No compression.
WIA_COMPRESSION_BI_RLE4	DIB 4 bit run length encoding.
WIA_COMPRESSION_BI_RLE8	DIB 8 bit run length encoding.
WIA_COMPRESSION_G3	TIFF CCITT G3
WIA_COMPRESSION_G4	TIFF CCITT G4
WIA_COMPRESSION_JPEG	JPEG encoding.

<FM>WIA_IPA_DATATYPE<FN>
This property indicates the image type of the item. This property is read-only for cameras and read/write for scanners.
Data Type	Description
WIA_DATA_THRESHOLD	One bit-per-pixel black-and-white threshold. Data over the current value of WIA_IPS_THRESHOLD is converted to white; data under this value is converted to black.
WIA_DATA_DITHER	Scan data is dithered using the currently selected dither pattern.
WIA_DATA_GRAYSCALE	Scan data represents intensity. The palette is a fixed, equally-spaced gray scale with a depth specified by WIA_IPA_DEPTH property.
WIA_DATA_COLOR	Scan data is red, green, blue (RGB) color. The full color format is described using the following WIA properties:
WIA_IPA_CHANNELS_PER_PIXEL
WIA_IPA_BITS_PER_CHANNEL
WIA_IPA_PLANAR
WIA_IPA_PIXELS_PER_LINE
WIA_IPA_BYTES_PER_LINE
WIA_IPA_NUMBER_OF_LINES
WIA_DATA_COLOR_THRESHOLD	Same as WIA_DATA_COLOR except that the threshold value is used when scanning the data. Color values over the WIA_IPS_THRESHOLD value are converted to full brightness; colors under this value are converted to black.
WIA_DATA_COLOR_DITHER	Same as WIA_DATA_COLOR except that the data is dithered using the currently selected dither pattern.

<FM>WIA_IPA_DEPTH<FN>
Requested number of bits per pixel. On devices that allow for multiple color-space resolutions per data type, this property is a list of values (a WIA_PROP_LIST) specifying the color-space resolutions. On devices that allow only a single color-space resolution per data type, this is a read-only property that tracks the WIA_IPA_DATATYPE set above, otherwise it is read/write. This property is always read-only for cameras.

<FM>WIA_IPA_FILENAME_EXTENSION<FN>
This property specifies the preferred filename extension for a particular file format. The driver updates this property to reflect the current value of the WIA_IPA_FORMAT property.
This property is recommended for drivers that support standard formats. However, it is required for drivers that implement custom-defined formats. It is needed to allow the application to know the correct filename extension to use during file transfer of private formats.
For example, if WIA_IPA_FORMAT is WiaImgFmt_JPEG, then WIA_IPA_FILENAME_EXTENSION should be "jpg", or if WIA_IPA_FORMAT is WiaImgFmt_BMP, then WIA_IPA_FILENAME_EXTENSION should be "bmp". Notice that the file name extension does not include the ".".

<FM>WIA_IPA_FORMAT<FN>
This property controls the data format returned to the application.
This property is read/write for devices that support more than one format. Otherwise, it is read only.
Format Type	Description
WiaImgFmt_MEMORYBMP	Windows bitmap without a BITMAPFILEHEADER header.
WiaImgFmt_BMP	Windows bitmap with a BITMAPFILEHEADER header.
WiaImgFmt_EMF	Extended Windows metafile.
WiaImgFmt_WMF	Windows metafile.
WiaImgFmt_JPEG	JPEG compressed format.
WiaImgFmt_PNG	W3C PNG format.
WiaImgFmt_GIF	GIF image format.
WiaImgFmt_TIFF	Tag Image File Format.
WiaImgFmt_EXIF	Exchangeable File Format.
WiaImgFmt_PHOTOCD	Eastman Kodak file format.
WiaImgFmt_FLASHPIX	FlashPix format.
WiaImgFmt_ICO	Microsoft icon file format.
WiaImgFmt_CIFF	Camera Image File format.
WiaImgFmt_PICT	Apple file format.
WiaImgFmt_JPEG2K	JPEG 2000 compressed format.
WiaImgFmt_JPEG2KX	JPEG 2000 compressed format.
WiaImgFmt_RTF	Rich Text File format.
WiaImgFmt_XML	XML file.
WiaImgFmt_TXT	Text file.
WiaImgFmt_MPG	MPG video format.
WiaImgFmt_AVI	AVI video format.
WiaImgFmt_ASF	ASF video format.
WiaImgFmt_SCRIPT	Script file.
WiaImgFmt_EXEC	Executable file.
WiaImgFmt_UNICODE16	UNICODE 16-bit encoding.
WiaImgFmt_DPOF	DPOF printing format.
WiaAudFmt_WAV	WAV audio format.
WiaAudFmt_MP3	MP3 audio format.
WiaAudFmt_AIFF	AIFF audio format.
WiaAudFmt_WMA	WMA audio format.
WiaImgFmt_HTML	HTML format.
WiaImgFmt_RAWRGB	Raw RGB format.

The valid values for this property match the values returned by drvGetWiaFormatInfo based on the setting of WIA_IPA_TYMED. When WIA_IPA_TYMED is set to TYMED_CALLBACK, the valid values for this property include at least IMGFMT_MEMORYBMP. When WIA_IPA_TYMED is set to TYMED_FILE, the valid values for this property include at least IMGFMT_BMP.
When an application uses WiaImgFmt_RAWRGB, the accuracy of the image transfer depends on the following properties:
"	WIA_IPA_DATATYPE
"	WIA_IPA_CHANNELS_PER_PIXEL
"	WIA_IPA_BITS_PER_CHANNEL
"	WIA_IPA_DEPTH
"	WIA_IPA_PIXELS_PER_LINE
"	WIA_IPA_NUMBER_OF_LINES
"	WIA_IPS_XRES
"	WIA_IPS_YRES
For WiaImgFmt_RAWRGB valid values for these properties are the following:
WIA_IPA_DATATYPE - set to WIA_DATA_COLOR
WIA_IPA_DEPTH - set to 24 or higher.
The data transferred for RAWRGB should be uncompressed, in RGB byte order, DWORD aligned, and transferred with no image header.
Supporting the WiaImgFmt_RAWRGB format GUID allows TWAIN applications to transfer images higher than 32 bit using the memory transfer method.

<FM>WIA_IPA_FULL_ITEM_NAME<FN>
Complete item name, that includes hierarchy. This property is supplied by WIA. The full hierarchy includes the Plug and Play device index followed by the root item name, ROOT, followed by the item name. For example, a picture at the highest level in a camera could be named:
0001\Root\Image0001

<FM>WIA_IPA_GAMMA_CURVES<FN>
Gamma Correction curves for each color channel. Format is TBD. This property is optional.

<FM>WIA_IPA_ICM_PROFILE_NAME<FN>
The name of the color management device profile for the scanner.

<FM>WIA_IPA_ITEM_FLAGS<FN>
Flags that specify the item type and accessibility. This property is supplied by WIA. For information about these flags

<FM>WIA_IPA_ITEM_NAME<FN>
Name of the item object, for example, "\Image0001". This property is supplied by WIA.

<FM>WIA_IPA_ITEM_SIZE<FN>
Total data transfer size including data and data-specific header information, if the size is known. If the size is not known, this property must be set to zero.

<FM>WIA_IPA_MIN_BUFFER_SIZE<FN>
This property is used to specify the minimum buffer size used in data transfers. If the data transfer is done via callback, it may be as small as 64K, but if the transfer is to file, then it is the number of bytes needed to transfer a page of data at a time.

<FM>WIA_IPA_NUMBER_OF_LINES<FN>
Number of lines in the final image. This is a read-only property and is set by the device, based on the scan settings.

<FM>WIA_IPA_PIXELS_PER_LINE<FN>
Number of pixels per line in the current image. This is a read-only property and is set by the device based on the scan settings.

<FM>WIA_IPA_PLANAR<FN>
Describes whether the data is returned in a planar or packed-pixel format.

<FM>WIA_IPA_PREFERRED_FORMAT<FN>
The preferred data format the driver or device supplies to the application.
Format Type	Description
WiaImgFmt_MEMORYBMP	Windows bitmap without a header file.
WiaImgFmt_BMP	Windows bitmap with header file.
WiaImgFmt_EMF	Extended Windows metafile.
WiaImgFmt_WMF	Windows metafile.
WiaImgFmt_JPEG	JPEG compressed format.
WiaImgFmt_PNG	W3C PNG format.
WiaImgFmt_GIF	GIF image format.
WiaImgFmt_TIFF	Tag Image File Format.
WiaImgFmt_EXIF	Exchangeable File Format.
WiaImgFmt_PHOTOCD	Eastman Kodak file format.
WiaImgFmt_FLASHPIX	FlashPix format.
WiaImgFmt_ICO	Microsoft icon file format.

<FM>WIA_IPA_PROP_STREAM_COMPAT_ID<FN>
This property specifies a CLSID that represents a set of device property values. If a device driver implements this feature, applications use this property to determine if the device supports a set of values. This property is optional.

<FM>WIA_IPA_REGION_TYPE<FN>
This property is used to specify the type of region the image analysis has created. This property is optional. The following region types are supported:
Region Type	Description
WIA_TEXT_ITEM	Region contains text.
WIA_PHOTO_ITEM	Region contains a photo.
WIA_DRAWING_ITEM	Region contains a line drawing.
WIA_LOGO_ITEM	Region contains a logo.
WIA_HANDWRITING_ITEM	Region contains handwriting.
WIA_CHART_ITEM	Region contains a chart or graph.
WIA_TABLE_ITEM	Region contains tabular data.

<FM>WIA_IPA_SUPPRESS_PROPERTY_PAGE<FN>
Specifies whether to suppress the property pages for items on this device. This property takes one of the following constant values:
Constant	Description
WIA_PROPPAGE_CAMERA_ITEM_GENERAL	Suppress the general item property page for a camera.
WIA_PROPPAGE_SCANNER_ITEM_GENERAL	Suppress the general item property page for a scanner.

<FM>WIA_IPA_TYMED<FN>
Specifies data transfer type.
Transfer Type	Description
WIA_TYMED_CALLBACK	Use callback based data transfer.
WIA_TYMED_MULTIPAGE_CALLBACK	Use callback based data transfer for multi-page or finished file scans.
WIA_TYMED_FILE	Use file based data transfer.
WIA_TYMED_MULTIPAGE_FILE	Use file based data transfer for multi-page or finished file scans.



<FM>Scanner WIA Item Property Constants<FN>


<FM>WIA_IPS_BRIGHTNESS<FN>
The image brightness values available within the scanner.
It is up to the scanner driver to supply a range of valid values for this property. Applications query the device for the valid values. Smaller values make the image darker. Larger values make the image brighter. This property is mandatory for all scanners.

<FM>WIA_IPS_CONTRAST<FN>
The image contrast values available within the scanner. It is up to the scanner driver to supply a range of valid values for this property. Applications query the device for the valid values. Smaller values make the image darker. Larger values make the image brighter. This property is mandatory for all scanners.

<FM>WIA_IPS_CUR_INTENT<FN>
Allows a driver to preset item properties based on the intended use of the image of an application. To provide an intent, use an intended image type flag and an intended size/quality flag OR'd together. Note that an image cannot be both grayscale and color. This property is mandatory for all scanners.
Intended image type flags	Description
WIA_INTENT_NONE	Default value. Do not preset any properties.
WIA_INTENT_IMAGE_TYPE_COLOR	Preset properties for color content.
WIA_INTENT_IMAGE_TYPE_GRAYSCALE	Preset properties for grayscale content.
WIA_INTENT_IMAGE_TYPE_TEXT	Preset properties for text content.
WIA_INTENT_IMAGE_TYPE_MASK	Mask for all of the image type flags.

Intended image size/quality flags	Description
WIA_INTENT_MINIMIZE_SIZE	Preset properties to minimize image size.
WIA_INTENT_MAXIMIZE_QUALITY	Preset properties to maximize image quality.
WIA_INTENT_SIZE_MASK	Mask for all of the size/quality flags.

<FM>WIA_IPS_INVERT<FN>
Specifies a photo-negative scan. This property is optional.

<FM>WIA_IPS_MIRROR<FN>
If a scanner supports the detection of document mirroring, this property is implemented with read-only access. If a scanner supports mirroring during scanning, this property is implemented with read/write access. The mirroring flags include the following.
Constant	Description
WIA_MIRRORED	The image data is in mirrored orientation, or requests the device to mirror-invert the image.

<FM>WIA_IPS_ORIENTATION<FN>
If a scanner can support the detection of document orientation, this property is implemented. The orientation flags include the following.
Constant	Description
WIA_PORTRAIT	The image data is in portrait orientation(0 degrees rotation).
WIA_LANSCAPE	The image data is in landscape orientation (the page is rotated 90 degrees counter-clockwise).
WIA_ROT180	The image data is in an upside-down orientation (180 degrees rotation).
WIA_ROT270	The image data is in an upside-down landscape orientation (the page is rotated 270 degrees counter-clockwise).

<FM>WIA_IPS_PHOTOMETRIC_INTERP<FN>
Photometric interpretation. The default color interpretation of image data.
WIA_PHOTO_WHITE_1 : white is 1, black is 0.
WIA_PHOTO_WHITE_0 : white is 0, black is 1.
For devices or drivers that support selectable photometric interpretation, the access for this property is read/write. For all others, it is read only. This property is mandatory for all scanners.

<FM>WIA_IPS_ROTATION<FN>
If a scanner supports internal rotation during scanning, this property is implemented. The rotation flags include the following.
Constant	Description
WIA_PORTRAIT	The driver or device will not rotate the image (0 degrees counter-clockwise).
WIA_LANSCAPE	The driver or device rotates the image 90 degrees counter-clockwise.
WIA_ROT180	The driver or device rotates the image 180 degrees counter-clockwise.
WIA_ROT270	The driver or device rotates the image 270 degrees counter-clockwise.

<FM>WIA_IPS_THRESHOLD<FN>
Specifies the dividing line between black and white. This is the value the scanner uses to threshold, when the WIA_IPA_DATATYPE property is set to WIA_DATA_THRESHOLD. Higher positive values represent lighter pixel values.
The device driver specifies a range of valid values for this property. Applications query the device for the range of valid values. This property is optional.

<FM>WIA_IPS_WARM_UP_TIME<FN>
Indicates to the application how long, in milliseconds, it takes the scanner and/or lamp to warm up before scanning commences. The application displays a progress indicator to the user based on this value. If the device requires no warm-up, the value should be zero. This property is optional.
WIA_IPS_XEXTENT - Horizontal Extent
The width of the scan in pixels. This property is mandatory for all scanners.
WIA_IPS_XPOS - Horizontal Start Position
The horizontal start position in pixels of the image to be scanned. This property is mandatory for all scanners.
WIA_IPS_XRES - Horizontal Resolution
Specifies the current horizontal (X) axis resolution, in dots per inch (DPI).For scanners that do not support the independent setting of horizontal and vertical resolutions, the vertical resolution tracks the Horizontal Resolution property. To find out if the scanner supports independent resolutions, query the Vertical Resolution property.
The following properties are dependent on the Horizontal Resolution property for the independent resolution case:
Horizontal Start Position
Horizontal Extent
Pixels per Line
Bytes Per Line
File Size
In addition, the following properties are also reliant in the dependent resolution case:
Vertical Start Position
Vertical Extent
Number of Lines
This property is either a range or a list. This property is mandatory for all scanners.
WIA_IPS_YEXTENT - Vertical Extent
The height of the scan in lines. This property is mandatory for all scanners.
WIA_IPS_YPOS - Vertical Start Position
The vertical start position in pixels of the image to be scanned. This property is mandatory for all scanners.
WIA_IPS_YRES - Vertical Resolution
For scanners that support the independent setting of horizontal and vertical resolution, this property specifies the current vertical (Y) axis resolution, in DPI. It is implemented as read/write. For scanners that do not support independent setting of horizontal and vertical resolutions, this property is implemented as read-only and tracks the WIA_IPS_XRES property. This property is mandatory for all scanners.
The following properties are dependent on the Vertical Resolution property:
Vertical Start Position
Vertical Extent
Number of Lines
File Size
Camera WIA Item Property Constants


<FM>WIA_IPC_AUDIO_AVAILABLE<FN>
The camera item has audio data available.

<FM>WIA_IPC_AUDIO_DATA<FN>
Camera Audio data.

<FM>WIA_IPC_AUDIO_DATA_FORMAT<FN>
Audio formats for WIA are TBD.

<FM>WIA_IPC_NUM_PICT_PER_ROW<FN>
The number of pictures in a horizontal row for this camera.

<FM>WIA_IPC_SEQUENCE<FN>
Indicates the relative temporal position of this image in a multi-image time sequence. The numbers are not required to be sequential or start at any particular value. The values increase with time.

<FM>WIA_IPC_THUMB_HEIGHT<FN>
Specifies the height of the thumbnail in pixels.

<FM>WIA_IPC_THUMB_WIDTH<FN>
Specifies the width of the thumbnail in pixels.

<FM>WIA_IPC_THUMBNAIL<FN>
The thumbnail data. This is a fixed format consisting of raw, 24 bit, DWORD aligned, Blue-Green-Red color order, DIB bits with no DIB header.

<FM>WIA_IPC_TIMEDELAY<FN>
Indicates the amount of time, in milliseconds, that transpired between the capture of the current image and the previous image.

!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TIEICC Supported Color Formats<FN>

  TYPE_GRAY_8
  TYPE_GRAY_8_REV
  TYPE_GRAY_16
  TYPE_GRAY_16_REV
  TYPE_GRAY_16_SE
  TYPE_GRAYA_8
  TYPE_GRAYA_16
  TYPE_GRAYA_16_SE
  TYPE_GRAYA_8_PLANAR
  TYPE_GRAYA_16_PLANAR
  TYPE_RGB_8
  TYPE_RGB_8_PLANAR
  TYPE_BGR_8
  TYPE_BGR_8_PLANAR
  TYPE_RGB_16
  TYPE_RGB_16_PLANAR
  TYPE_RGB_16_SE
  TYPE_BGR_16
  TYPE_BGR_16_PLANAR
  TYPE_BGR_16_SE
  TYPE_RGBA_8
  TYPE_RGBA_8_PLANAR
  TYPE_RGBA_16
  TYPE_RGBA_16_PLANAR
  TYPE_RGBA_16_SE
  TYPE_ARGB_8
  TYPE_ARGB_16
  TYPE_ABGR_8
  TYPE_ABGR_16
  TYPE_ABGR_16_PLANAR
  TYPE_ABGR_16_SE
  TYPE_BGRA_8
  TYPE_BGRA_16
  TYPE_BGRA_16_SE
  TYPE_CMY_8
  TYPE_CMY_8_PLANAR
  TYPE_CMY_16
  TYPE_CMY_16_PLANAR
  TYPE_CMY_16_SE
  TYPE_CMYK_8
  TYPE_CMYK_8_REV
  TYPE_YUVK_8
  TYPE_CMYK_8_PLANAR
  TYPE_CMYK_16
  TYPE_CMYK_16_REV
  TYPE_YUVK_16
  TYPE_CMYK_16_PLANAR
  TYPE_CMYK_16_SE
  TYPE_KYMC_8
  TYPE_KYMC_16
  TYPE_KYMC_16_SE
  TYPE_KCMY_8
  TYPE_KCMY_8_REV
  TYPE_KCMY_16
  TYPE_KCMY_16_REV
  TYPE_KCMY_16_SE
  TYPE_CMYK5_8
  TYPE_CMYK5_16
  TYPE_CMYK5_16_SE
  TYPE_KYMC5_8
  TYPE_KYMC5_16
  TYPE_KYMC5_16_SE
  TYPE_CMYKcm_8
  TYPE_CMYKcm_8_PLANAR
  TYPE_CMYKcm_16
  TYPE_CMYKcm_16_PLANAR
  TYPE_CMYKcm_16_SE
  TYPE_CMYK7_8
  TYPE_CMYK7_16
  TYPE_CMYK7_16_SE
  TYPE_KYMC7_8
  TYPE_KYMC7_16
  TYPE_KYMC7_16_SE
  TYPE_CMYK8_8
  TYPE_CMYK8_16
  TYPE_CMYK8_16_SE
  TYPE_KYMC8_8
  TYPE_KYMC8_16
  TYPE_KYMC8_16_SE
  TYPE_CMYK9_8
  TYPE_CMYK9_16
  TYPE_CMYK9_16_SE
  TYPE_KYMC9_8
  TYPE_KYMC9_16
  TYPE_KYMC9_16_SE
  TYPE_CMYK10_8
  TYPE_CMYK10_16
  TYPE_CMYK10_16_SE
  TYPE_KYMC10_8
  TYPE_KYMC10_16
  TYPE_KYMC10_16_SE
  TYPE_CMYK11_8
  TYPE_CMYK11_16
  TYPE_CMYK11_16_SE
  TYPE_KYMC11_8
  TYPE_KYMC11_16
  TYPE_KYMC11_16_SE
  TYPE_CMYK12_8
  TYPE_CMYK12_16
  TYPE_CMYK12_16_SE
  TYPE_KYMC12_8
  TYPE_KYMC12_16
  TYPE_KYMC12_16_SE
  TYPE_XYZ_16
  TYPE_Lab_8
  TYPE_ALab_8
  TYPE_Lab_16
  TYPE_Yxy_16
  TYPE_YCbCr_8
  TYPE_YCbCr_8_PLANAR
  TYPE_YCbCr_16
  TYPE_YCbCr_16_PLANAR
  TYPE_YCbCr_16_SE
  TYPE_YUV_8
  TYPE_YUV_8_PLANAR
  TYPE_YUV_16
  TYPE_YUV_16_PLANAR
  TYPE_YUV_16_SE
  TYPE_HLS_8
  TYPE_HLS_8_PLANAR
  TYPE_HLS_16
  TYPE_HLS_16_PLANAR
  TYPE_HLS_16_SE
  TYPE_HSV_8
  TYPE_HSV_8_PLANAR
  TYPE_HSV_16
  TYPE_HSV_16_PLANAR
  TYPE_HSV_16_SE
  TYPE_XYZ_DBL
  TYPE_Lab_DBL
  TYPE_GRAY_DBL
  TYPE_RGB_DBL
  TYPE_CMYK_DBL
!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>FAQ

<FN>
<L #2>How can I prevent the scrollwheel from causing the image to zoom? I want it to remain the orginal size at all times.</L>
<L #3>I was wondering if it was possible to convert, say, a GIF image to a TIFF image without a visual component. In other words, how could I convert among image formats in a console application?</L>
<L #4>You can also create a TIEBitmap (or TBitmap) object that contains the image. This is the code:</L>
<L #5>Can I modify brightness?</L>
<L #6>Can I modify scanner resolution?</L>
<L #7>Is there any way to save a CMYK tif using ImageEn?</L>
<L #8>I want to resample a normal picture but i've got everytime the same compiler error : TResampleFilter.... is not definied.</L>
<L #9>Is it possible to de/activate duplex on scanner ?</L>
<L #10>I'm trying to insert some text (the current time) in the raw frame using the event OnVideoFrameRaw , my question is : how can I get a canvas from the parameters passed to this event ?</L>
<L #11>Can your component take a series of single page TIFF files and create a Multi-Page file from them?</L>
<L #12>How to change the current page of a TIFF image in ImageEn, or do I use another control?</L>
<L #13>I have downloaded some of your components and its format is MSI. Unfortunately i dont know how i can install it.</L>
<L #14>Is it possible, using ImageEn, to convert a multipage-image to a different encoding? G3 and G4 specifically?</L>
<L #15>How do I get the transparent PNGs to work inside your vector view control?</L>
<L #16>I would like users to be able to resize and move vectorial objects when they are displayed on the screen. Is it possible ? How can I do that ?</L>
<L #17>Using TImageEnMView, how display images "on demand"?</L>
<L #18>We tried to install using the given user name/registration number but we still get the nag reminder saying that this is a demo.</L>
<L #19>Is it possible to save the Lines,Ellipses .... into the image ? Burn into the jpg file ?</L>
<L #20>How do i load / change the IPTC info without loading the original image?</L>
<L #21>We need to print all the 'pages' in a multipage tiff.</L>
<L #22>How I can save my jpeg without EXIF or other metadata?</L>
<L #23>I have a question. How can I check if the TImageEnView is empty (no bitmap loaded)?</L>
<L #24>What I need to do is, when a user selects a page of the multipage tiff image (using TImageEnMView) this image should be copied/displayed on ImageEnView1.</L>
<L #25>How is it possible to assign the image in one ImageEnView to another ImageEnView?</L>
<L #26>Which is the correct way to load a Resource Image at runtime into an TImageEnView component, in C++?</L>
<L #27>How read custom TIFF tags?</L>
<L #28>Why my jpegs are so big?</L>
<L #29>In ImageEnVect, how to save a image with many objects? And how can I load the objects if I'd saved them?</L>
<L #30>How do I store/retrieve multiple pages in a blob field using TImagenDBView?</L>
<L #32>How to load embedded jpeg-RAW images?</L>
<L #33>How terminate a polyline without doubleclick?</L>
<L #34>I am unable to read recent Camera RAW files. Why?</L>
<L #35>Measuring line length using miLineLen (or miArea) does not work. The mouse pointer only shows 0.00 pixels and nothing happens.<L>
<L #36>I get "Floating point overflow" on printing.<L>
<L #37>I see horizontal/vertical bands loading images using TImageEnMView. Why?<L>


<# 2><FM>How can I prevent the scrollwheel from causing the image to zoom? I want it to remain the orginal size at all times.<FN>

Just write:

<FC>ImageEnView1.MouseWheelParams.Action:=iemwNone;<FN>

other values are iemwVScroll and iemwZoom (default).


<# 3><FM>I was wondering if it was possible to convert, say, a GIF image to a TIFF image without a visual component. In other words, how could I convert among image formats in a console application?<FN>

There are several ways. The simplest is:
<FC>
var
  ie:TImageEnView;
begin
  ie:=TImageEnView.Create(nil);
  ie.IO.LoadFromFile('in.gif');
  ie.IO.SaveToFile('out.gif');
  ie.free;
end;
<FN>

<# 4><FM>You can also create a TIEBitmap (or TBitmap) object that contains the image. This is the code:<FN>

<FC>
var
  bmp:TIEBitmap;
  io:TImageEnIO;
Begin
  bmp:=TIEBitmap.Create;
  io:=TImageEnIO.CreateFromBitmap(bmp);
  io.LoadFromFile('in.gif');
  io.SaveToFile('out.gif');
  io.free;
  bmp.free;
End;
<FN>

<# 5><FM>Can I modify brightness?<FN>

You can change brightness (luminosity) using several methods.

Using IntensityRGBall method:

  <FC>ImageEnView1.Proc.IntensityRGBall(20,20,20); // increment luminosity of 20 (the fastest)<FN>

Using HSLvar method:

  <FC>ImageEnView1.Proc.HSLvar(0,0,20); // increment luminosity of 20 (slow but more accurate)<FN>

Using HSVvar method:

  <FC>ImageEnView1.Proc.HSVvar(0,0,20); // increment luminosity of 20 (slow but more accurate)<FN>


<# 6><FM>Can I modify scanner resolution?<FN>

To change scan resolution to 300 on your scanner use:
<FC>
ImageEnView1.IO.TWainParams.XResolution.CurrentValue:=300;
ImageEnView1.IO.TWainParams.YResolution.CurrentValue:=300;
ImageEnView1.IO.Acquire;
<FN>

<# 7><FM>Is there any way to save a CMYK tif using ImageEn?<FN>

To save TIFF with CMYK write:
<FC>
ImageEnView1.IO.Params.TIFF_PhotometInterpret:=ioTIFF_CMYK;

ImageEnView1.IO.SaveToFile('xxx.tif');
<FN>

<# 8><FM>I want to resample a normal picture but i've got everytime the same compiler error : TResampleFilter.... is not definied.<FN>

You have to add to the "uses" list the "hyiedefs" unit:
<FC>
uses hyiedefs;
<FN>

<# 9><FM>Is it possible to de/activate duplex on scanner ?<FN>

Write <FC>ImageEnView1.IO.TWainParams.DuplexEnabled:=True<FN> (or False if you want disable).


<# 10><FM>I'm trying to insert some text (the current time) in the raw frame using the event OnVideoFrameRaw , my question is : how can I get a canvas from the parameters passed to this event ?<FN>

Instead of use OnVideoFrameRaw you have to use OnVideoFrame that returns a Bitmap object.

From Bitmap object you can obtain the Canvas with:

Bitmap.Canvas


<# 11><FM>Can your component take a series of single page TIFF files and create a Multi-Page file from them?<FN>

You can load the page using:

  <FC>ImageEnView1.IO.LoadFromFile('page1.tif');<FN>

then save the page with:
<FC>
  ImageEnView1.IO.Params.TIFF_ImageIndex:=0; // increment this for each page

  ImageEnView1.IO.InsertToFileTIFF('multipage.tif');
<FN>
Otherwise you can use TImageEnMView and TImageEnMIO component. See "multi" example for more details.


<# 12><FM>How to change the current page of a TIFF image in ImageEn, or do I use another control?<FN>

In order to load several pages from a TIFF you have two ways:

1) load a page at the time, using TImageEnView, example:
<FC>
ImageEnView1.IO.Params.TIFF_ImageIndex:= page_number; // page_number stars from 0 (first page)

ImageEnView1.IO.LoadFromFile('mytiff.tiff');
<FN>
First instruction select the page to load. To know how many pages there are use:

<FC>page_count:=EnumTIFFIm('mytiff.tiff');<FN>

2) load all pages, using TImageEnMView. Just write:

<FC>ImageEnMView1.MIO.LoadFromFile('mytiff.tiff');<FN>

and you will see all pages.



<# 13><FM>I have downloaded some of your components and its format is MSI. Unfortunately i dont know how i can install it.<FN>

First download updated Windows Installer from Microsoft:

<L http://www.microsoft.com/downloads/details.aspx?FamilyID=4b6140f9-2d36-4977-8fa1-6f8a0f5dca8f&DisplayLang=en>(for NT and 2000)</L>

Then just double click on the MSI file.


<# 14><FM>Is it possible, using ImageEn, to convert a multipage-image to a different encoding? G3 and G4 specifically?<FN>

Using TImageEnMView you have to change the compression property for all pages:
<FC>
ImageEnMView1.MIO.LoadFromFile('original.tif');
// change compression for the first page
ImageEnMView1.MIO.Params[0].TIFF_Compression := ioTIFF_G4FAX;
// change compression for the other pages
ImageEnMView1.MIO.DuplicateCompressionInfo;
// now save
ImageEnMView1.Mio.SaveToFile('output.tif');
<FN>

<# 15><FM>How do I get the transparent PNGs to work inside your vector view control?<FN>

To load the alpha channel from PNG (and others) you have to use SetObjBitmapFromFile method:

<FC>ImageEnVect1.SetObjBitmapFromFile(hobj, 'test.png');<FN>


<# 16><FM>I would like users to be able to resize and move vectorial objects when they are displayed on the screen. Is it possible ? How can I do that ?<FN>

To enable users to modify (move,resize) objects just set:

<FC>ImageEnVect1.MouseInteractVt:=[miObjectSelect];<FN>

The users can select then modify objects.


<# 17><FM>Using TImageEnMView, how display images "on demand"?<FN>

There are several ways to display images "on demand":

1)  If you have a directory where are all files just write:
<FC>ImageEnMView1.FillFromDirectory('c:\myimages');<FN>

2) When you add a new image just set ImageFileName[] index, and ImageEn will load automatically specified file when needed. Example:
<FC>
idx:=ImageEnMView1.AppendImage;
ImageEnMView1.ImageFileName[idx]:='first.jpg';
<FN>
3) When you add a new image just set the ImageID[] property. You have to create by hand an array of filenames where to get images. Example:
<FC>
var
  files:array [0..1] of string;
begin
  files[0]:='first.jpg';
  files[1]:='second.jpg';
  ImageEnMView1.ImageID[ ImageEnMView1.AppendImage ] := 0;
  ImageEnMView1.ImageID[ ImageEnMView1.AppendImage ] := 1;
end;
<FN>
You have also to create OnImageIDRequest event, on this you can write:
<FC>
procedure TForm1.OnImageIDRequest(Sender: TObject; ID:integer; var Bitmap:TBitmap);
var
  io:TImageEnIO;
begin
  io:=TImageEnIO.Create(self);
  io.AttachedBitmap:=bmp; // bmp is a TBitmap object, defined at class level (must exists after the OnImageIDRequest exits)
  io.LoadFromFile( files[ID] );
  io.free;
  Bitmap:=bmp;
end;
<FN>
4) If the images are frames of a media file (like AVI, MPEG, etc..) you can write:
<FC>
ImageEnMView1.LoadFromFileOnDemand('film.mpeg');
<FN>

<# 18><FM>We tried to install using the given user name/registration number but we still get the nag reminder saying that this is a demo.<FN>

Probably you have still an unregistered version of ImageEn in the Delphi paths. Remove old ImageEn files (also in Windows\System32 directory searching for pkie*.* files) and reinstall ImageEn.


<# 19><FM>Is it possible to save the Lines,Ellipses .... into the image ? Burn into the jpg file ?<FN>

Use <A TImageEnVect.CopyObjectsToBack> method, then save the background image.


<# 20><FM>How do i load / change the IPTC info without loading the original image?<FN>

To load IPTC info from a jpeg, just use LoadFromFile method. After this you have in ImageEnView.IO.Params.IPTC_Info object all IPTC informations loaded. To read the caption you can write:
<FC>
ImageEnView.IO.LoadFromFile('image.jpg');
Idx:=ImageEnView.IO. Params.IPTC_Info.IndexOf(2,120);
Caption:= ImageEnView.IO.Params.IPTC_Info.StringItem[idx];
<FN>
this modify the caption:
<FC>
ImageEnView.IO.Params.IPTC_Info.StringItem[idx] := 'new caption';
ImageEnView.IO.SaveToFile('image2.jpg');
<FN>
If you want to modify IPTC info without load the image use ParamsFromFile and InjectJpegIPTC methods, in this way:

<FC>ImageEnView.IO.ParamsFromFile('one.jpg');<FN>

...here modify the IPTC info

<FC>ImageEnView.IO.InjectJpegIPTC('two.jpg');<FN>


<# 21><FM>We need to print all the 'pages' in a multipage tiff.<FN>

You can connect a TImageEnIO to a TImageEnMView. TImageEnIO.PrintImage will print the selected image (use SelectedImage to change current selected image). In this way you can print all pages:
<FC>
for i:=0 to ImageEnMView1.ImageCount-1 do
begin
  ImageEnMView1.SeletedImage := i;
  ImageEnIO.PrintImage...
end;
<FN>
You can also use the predefined dialog of TImageEnMView componet. Just write:

<FC>ImageEnMView.MIO.DoPrintPreviewDialog;<FN>


<# 22><FM>How I can save my jpeg without EXIF or other metadata?<FN>

Call Params.ResetInfo. Example:
<FC>
ImageEnView.IO.LoadFromFile('input.jpg');
ImageEnView.IO.Params.ResetInfo;
ImageEnView.IO.SaveToFile('output.jpg');
<FN>

<# 23><FM>I have a question. How can I check if the TImageEnView is empty (no bitmap loaded)?<FN>

To empty the component use "Blank" method. To check if it is empty use IsEmpty:
<FC>
If ImageEnView1.IsEmpty then
	...
<FN>

<# 24><FM>What I need to do is, when a user selects a page of the multipage tiff image (using TImageEnMView) this image should be copied/displayed on ImageEnView1.<FN>

To handle image selection use OnImageSelect event. To transfer current selected image use simply the Assign method:
<FC>
procedure TForm1.ImageEnMView1ImageSelect(Sender: TObject; idx: Integer);
begin
  ImageEnView1.Assign( ImageEnMView1.Bitmap );
end;
<FN>

<# 25><FM>How is it possible to assign the image in one ImageEnView to another ImageEnView?<FN>

Just use Assign method:

<FC>ImageEnView1.Assign( ImageEnView2 );<FN>

or

<FC>ImageEnView1.Assign( ImageEnView1.Bitmap ); // this doesn't copy DPI, but just the image<FN>


<# 26><FM>Which is the correct way to load a Resource Image at runtime into an TImageEnView component, in C++?<FN>

Here is a sample code:
<FC>
    TResourceStream *ResourceImage;
    // Load from resource the About image ( a JPEG file).
    ResourceImage = new TResourceStream((int)HInstance, "ABOUTBITMAP",RT_RCDATA);
    MainForm->ImageAbout->IO->LoadFromStreamJpeg(ResourceImage);
    delete ResourceImage;
<FN>

Here is a single line text file named "resource.rc" with the sentence:

ABOUTBITMAP RCDATA "about.jpg"

Just add the Resource file to the project and compile.


<# 27><FM>How read custom TIFF tags?<FN>

This example shows how read EXIF tags saved with Canon cameras:
<FC>
var
  ms:TMemoryStream;
  tagReader1,tagReader2,tagReader3:TIETifTagsReader;
  i:integer;
  // some Canon tags
  m_nMacroMode,m_nLenghtTimer,m_Quality:integer;
  m_ImageType:string;
begin
  with imageenvect1 do begin

    IO.LoadFromFile('Capture_00006.JPG');
    with IO.Params.JPEG_MarkerList do begin
      i:=IndexOf( JPEG_APP1 );
      if i>=0 then begin
        // there are EXIF info
        ms:=TMemoryStream.Create;
        ms.Write( MarkerData[i][6], MarkerLength[i] );	// bypass first 4 bytes (must contain 'Exif')
        ms.Position:=0;

        tagReader1:= TIETifTagsReader.CreateFromStream( ms,0 );    // read TIFF's IFD

        tagReader2:= TIETifTagsReader.CreateFromIFD( tagReader1, 34665 );    // read IFD in tag 34665 (SubEXIF)

        tagReader3:= TIETifTagsReader.CreateFromIFD( tagReader2, $927c );    // read IFD in tag $927C (MarkerData - Canon IFD data)

        // read Canon EXIF tags
        m_nMacroMode:=tagReader3.GetIntegerIndexed(1,1);
        m_nLenghtTimer:=tagReader3.GetIntegerIndexed(1,2);
        m_Quality:=tagReader3.GetIntegerIndexed(1,3);
        m_ImageType:=tagReader3.GetString(6);

        tagReader3.Free;
        tagReader2.Free;
        tagReader1.Free;

        ms.Free;
      end;
    end;
  end;
end;
<FN>

<# 28><FM>Why my jpegs are so big?<FN>

Jpeg is a file format with variable compression rate. The property that regulates the compression (and the quality) is JPEG_Quality. So you should set this property before save. Example:
<FC>
ImageEnView.IO.LoadFromFile('input.jpg');
ImageEnView.IO.Params.JPEG_Quality:=70;
ImageEnView.IO.SaveToFile('output.jpg');
<FN>
The default is 80, while other software uses 70.
If you want estimate the value used to create your file, execute this:
<FC>quality:=IECalcJpegFileQuality('input.jpg');<FN>

So you could write:
<FC>
ImageEnView.IO.LoadFromFile('input.jpg');
ImageEnView.IO.Params.JPEG_Quality:=IECalcJpegFileQuality('input.jpg');
ImageEnView.IO.SaveToFile('output.jpg');
<FN>
If this is not enough, probably the file contains metatags (text info). To remove them execute:

<FC>ImageEnView.IO.Params.ResetInfo;<FN>

..just before save.


<# 29><FM>In ImageEnVect, how to save a image with many objects? And how can I load the objects if I'd saved them?<FN>

here is all options of ImageEn:

1)
if you want to save only objects:

<FC>ImageEnVect1.SaveToFileIEV('file.iev');<FN>

to load back:

<FC>ImageEnVect1.LoadfromFileIEV('file.iev');<FN>


2)
If you want save objects and image:

<FC>ImageEnVect1.SaveToFileAll('file.all');<FN>

and to load:

<FC>ImageEnVect1.LoadFromFileAll('file.all');<FN>

3)
If you want save objects and image as standard tiff and using Imaging Annotations (readable by Windows Preview):
<FC>
ImageEnVect1.IO.SaveToFile('file.tif');
ImageEnVect1.SaveObjectsToTIFF('file.tif');
<FN>
to load:
<FC>
ImageEnVect1.IO.LoadFromFile('file.tif');
ImageEnVect1.LoadObjectsFromTIFF('file.tif');
<FN>
4)
If you want save objects inside a jpeg or other formats which do not support Imaing Annotations, or you just want to merge image and objects:
<FC>
ImageEnVect1.CopyObjectsToBack;
ImageEnVect1.IO.SaveToFile('file.jpg');
<FN>
<# 30><FM>How do I store/retrieve multiple pages in a blob field using TImagenDBView?<FN>

<A TImageEnDBView> cannot store/retrieve multiple pages in a blob. However there is a solution.
You should put a TImageEnMView component on the form and use it to load/save multiple pages as TIFFs in blobs using streams.
To store the content of TImageEnMView inside a blob write:
<FC>
var tempStream:TMemoryStream;

tempStream:=TMemoryStream.Create;
ImageEnMView1.MIO.SaveToStreamTIFF( tempStream );
BlobField.LoadFromStream( tempStream );
tempStream.free;
<FN>
To retrieve from a blob:
<FC>
tempStream:=TMemoryStream.Create;
BlobField.SaveToStream( tempStream );
tempStream.Position:=0;
ImageEnMView1.MIO.LoadFromStreamTIFF( tempStream );
tempStream.free;
<FN>
If you use a TDataSet inherited data set you can create a blob stream without using intermediate TMemoryStream: this will speedup operations. Example:
<FC>
BlobStream:= myDataSet.CreateBlobStream(field, bmWrite);
ImageEnMView1.MIO.SaveToStreamTIFF( BlobStream );
BlobStream.Free;
<FN>
..and..
<FC>
BlobStream:= myDataSet.CreateBlobStream(field,bmRead);
ImageEnMView1.MiO.LoadFromStreamTIFF( BlobStream );
BlobStream.Free;
<FN>

Finally, when save you can set compression info. For example, for black/white images you could write:
<FC>
ImageEnMView1.MIO.Params[0].TIFF_Compression:= ioTIFF_G4FAX;
ImageEnMView1.MIO. DuplicateCompressionInfo;
<FN>..just before save.


<# 32><FM>How to load embedded jpeg-RAW images?<FN>

Unfortunately Camera RAW formats aren't documented. Anyway it is possible to load embedded jpegs from NEF, CR2 and DNG raw formats. Examples:

<FN>DNG:<FC>
ImageEnView1.IO.Params.TIFF_SubIndex:=1;
ImageEnView1.IO.LoadFromFileTIFF('input.dng');

<FN>CR2:<FC>
ImageEnView1.IO.Params.ImageIndex:=0;
ImageEnView1.IO.LoadFromFileTIFF('input.cr2');

<FN>NEF:<FC>
ImageEnView1.IO.Params.ImageIndex:=1;
ImageEnView1.IO.LoadFromFileTIFF('input.nef');

<FN>CRW:<FC>
ImageEnView1.IO.LoadJpegFromFileCRW('input.crw');


<# 33><FM>How terminate a polyline without doubleclick?<FN>

Just set:

ImageEnVect.PolylineEndingMode:=ieemMouseUp;



<# 34><FM>I am unable to read recent Camera RAW files. Why?<FN>

In order to read recent Camera RAW files you should use the external dcraw plugin. For more details look at plugins download.




<# 35><FM>Measuring line length using miLineLen (or miArea) does not work. The mouse pointer only shows 0.00 pixels and nothing happens.<FN>

miLineLen measures the perimeter of current selection. So a selection must be present. The same is for miArea which measures the area of current selection.
To measure the length of a line write instead:
<FN>ImageEnVect.MouseInteractVt:=[miDragLen];<FN>



<# 36>I get "Floating point overflow" on printing.<L>

Sometime this happens on shared printers and depends by VCL or printer drivers bug.
Try to disable FPU exceptions executing this before your printing code:

Set8087CW($133F);



<# 37>I see horizontal/vertical bands loading images using TImageEnMView. Why?<L>

For default TImageEnMView loads EXIF-thumbnail when it is available (and when you asked to load thumbnails).
Sometime these thumbnails contain black bands (horizontal or vertical bands).
To disable EXIF-thumbnail loading set:

TImageEnMView.EnableLoadEXIFThumbnails := false;

!!}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>ImageEn hierarchy
<FN>

TObject

    <A TIEScrollBarParams>

    <A TIEMouseWheelParams>

    <A TIEList>

        <A TIEIntegerList>

        <A TIEDoubleList>

    <A TIEMarkerList>

    <A TIEIPTCInfoList>

    <A TIEImagingObject>

    <A TIEImagingAnnot>

    <A TIEMask>

    <A TIEBaseBitmap>

        <A TIEBitmap>

        <A TIEDibBitmap>

    <A TIETIFTagsReader>

    <A TIETagsHandler>

    <A TIETIFFHandler>

    <A TIEICC>

    <A TIEDICOMTags>

    <A TIEDirectShow>

    <A TIEMediaReader>

    <A TIEWia>

    <A TIEWICReader>

    <A TIEWICWriter>


    TComponent

        <A TImageEnMIO>

        <A TImageEnIO> (encapsulates <A TIEDirectShow>, <A TIEWia>)

        <A TImageEnProc>

        <A TImageEnVideoCap>

        <A TIECommonDialog>

            <A TOpenImageEnDialog>

                <A TSaveImageEnDialog>

        TCustomControl

            <A TIEView>

                <A TImageEnMView> (encapsulates <A TImageEnMIO>, <A TImageEnProc>)

                <A TImageEnView> (encapsulates <A TImageEnIO>, <A TImageEnProc>)

                    <A TImageEnDBView>

                        <A TImageEnVect>

                        <A TImageEnDBVect>

                        <A TImageEnVideoView>

                    <A TImageEn> alias of <A TImageEnView>

            <A THistogramBox>

            <A THSVBox>

            <A TIEGradientBar>

            <A TRulerBox>

            TForm

                <A TImageEnPaletteDialog>

!!}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{!!
<FS>TWain language constants
<FN>

  TWLG_DAN      =   0; // Danish
  TWLG_DUT      =   1; // Dutch
  TWLG_ENG      =   2; // International English
  TWLG_FCF      =   3; // French Canadian
  TWLG_FIN      =   4; // Finnish
  TWLG_FRN      =   5; // French
  TWLG_GER      =   6; // German
  TWLG_ICE      =   7; // Icelandic
  TWLG_ITN      =   8; // Italian
  TWLG_NOR      =   9; // Norwegian
  TWLG_POR      =  10; // Portuguese
  TWLG_SPA      =  11; // Spanish
  TWLG_SWE      =  12; // Swedish
  TWLG_USA      =  13; // U.S. English

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
  TWLG_ARABIC_UAE         =  31;  // United Arabic Emirates
  TWLG_ARABIC_YEMEN       =  32;
  TWLG_BASQUE             =  33;
  TWLG_BYELORUSSIAN       =  34;
  TWLG_BULGARIAN          =  35;
  TWLG_CATALAN            =  36;
  TWLG_CHINESE            =  37;
  TWLG_CHINESE_HONGKONG   =  38;
  TWLG_CHINESE_PRC        =  39; // People's Republic of China
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


!!}


{!!
<FS>TWain country constants
<FN>

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


!!}

end.
