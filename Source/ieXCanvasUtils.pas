{------------------------------------------------------------------------------}
{                                                                              }
{  Canvas code created by:                                                     }
{                                                                              }
{  Nigel Cross                                                                 }
{  Xequte Software                                                             }
{  nigel@xequte.com                                                            }
{  http://www.xequte.com                                                       }  
{                                                                              }
{  © Xequte Software 2010                                                      }
{                                                                              }
{------------------------------------------------------------------------------}

unit ieXCanvasUtils;

interface

uses                       
  Windows, Messages, SysUtils, Classes, Graphics, Controls, stdctrls;

type
  TXCustomShape = (xcsStar5, xcsStar6, xcsArrowNW, xcsArrowNE, xcsArrowSW, xcsArrowSE, xcsLightningLeft, xcsLightningRight,
                   xcsExplosion, xcsExplosion_2, xcsCross, xcsArrowNW2, xcsArrowNE2, xcsArrowSW2, xcsArrowSE2, xcsHeart);
  TShapeDirection = (_xsdNW, _xsdNE, _xsdSW, _xsdSE);

  procedure DrawCustomShape(ACanvas: TCanvas; AShape: TXCustomShape; iLeft, iTop, iWidth, iHeight: Integer);
  function CreateCustomShapeRegion(AShape: TXCustomShape; iLeft, iTop, iWidth, iHeight: Integer): Hrgn;

implementation

uses
  Math;


const
  Cross_Horz_Bar_Vert_Offset = 0.33;



function CreateHeartRegion(iLeft, iTop, iWidth, iHeight: Integer): Hrgn;
const
  Triangle_Start_Point_On_Circle = 0.69;     // start trinagle 62% down the circle
  Top_Circle_Bulge               = 2;        // two pixels bigger
  LHS_Circle_Intersect_Deg       = 233.14;  // Start triangle 1.5% in from edge
  RHS_Circle_Intersect_Deg       = 360 - LHS_Circle_Intersect_Deg; //126.86;
  LHS_Circle_Middle_Touch_Deg    = 83;
  RHS_Circle_Middle_Touch_Deg    = 360 - LHS_Circle_Middle_Touch_Deg;

  Function FindPointOnCircleEdge(Center: Tpoint; Angle: Real; Radius: Word): TPoint;
  Begin
     Result.X := Round(center.x + Radius*cos((angle-90)*pi/180));
     Result.Y := round(center.y + Radius*sin((angle-90)*pi/180));
  End;

var
  rgn1, rgn2, rgn3, rgn4 : Hrgn;
  iCircleSize: Integer;
  poly: array[0..2] of TPoint;
  iCircleRadius: Integer;
  LeftCircleIntersectPt: TPoint;
  RightCircleIntersectPt: TPoint;
  iHalfWidth: Integer;
  iQuarterWidth: Integer;
  iShortSide: Integer;
begin
  // Maintain the Aspect Ratio of the Heart
  if iWidth < iHeight then
    iShortSide := iWidth
  else
    iShortSide := iHeight;
  Inc(iLeft, (iWidth - iShortSide) div 2);
  Inc(iTop, (iHeight - iShortSide) div 2);
  iWidth  := iShortSide;
  iHeight := iShortSide;

  iHalfWidth    := iWidth div 2;
  iQuarterWidth := iWidth div 4;
  iCircleSize   := iHalfWidth + Top_Circle_Bulge;
  iCircleRadius := iCircleSize div 2;

  LeftCircleIntersectPt  := FindPointOnCircleEdge(Point(iQuarterWidth, iQuarterWidth), LHS_Circle_Intersect_Deg, iCircleRadius - 1);
  RightCircleIntersectPt := FindPointOnCircleEdge(Point(iWidth - iQuarterWidth, iQuarterWidth), RHS_Circle_Intersect_Deg, iCircleRadius - 1);
                
  Result :=  CreateEllipticRgn(iLeft, iTop, iWidth, iHeight);

  // Circles
  rgn1 := CreateEllipticRgn(iLeft,
                            iTop,
                            iLeft + iCircleSize,
                            iTop + iCircleSize);
  rgn2 := CreateEllipticRgn(iLeft + iWidth - iCircleSize,
                            iTop,
                            iLeft + iWidth,
                            iTop + iCircleSize);
  combineRgn(Result, rgn1, rgn2, RGN_OR);

  // Bottom Triangle
  poly[0] := point(iLeft + LeftCircleIntersectPt.X,  iTop + LeftCircleIntersectPt.Y);
  poly[1] := point(iLeft + RightCircleIntersectPt.X, iTop + RightCircleIntersectPt.Y);
  poly[2] := point(iLeft + iHalfWidth, iTop + iHeight);

  rgn3 :=  Windows.CreatePolygonRgn(poly, 3, WINDING);
  combineRgn(Result, Result, rgn3, RGN_OR);

  // Fill Hole
  rgn4 :=  Windows.CreateRectRgn(iLeft + iCircleRadius, iTop + iCircleRadius,
                                 iLeft + iWidth - iCircleRadius, iTop + iCircleSize);
  combineRgn(Result, Result, rgn4, RGN_OR);

  DeleteObject(rgn4);
  DeleteObject(rgn3);
  DeleteObject(rgn2);
  DeleteObject(rgn1);
end;

type
  TFloatPoint= record
    x: extended;
    y: extended;
  end;

                                                           
// Create square canvas to maintain the Aspect Ratio of the shape
procedure KeepAspectRatioForDimensions(var iLeft, iTop, iWidth, iHeight: integer);
var
  iShortSide: Integer;
begin
  if iWidth < iHeight then
    iShortSide := iWidth
  else
    iShortSide := iHeight;
  Inc(iLeft, (iWidth - iShortSide) div 2);
  Inc(iTop, (iHeight - iShortSide) div 2);
  iWidth  := iShortSide;
  iHeight := iShortSide;
end;


function Create5PointStarRegion(iLeft, iTop, iWidth, iHeight: Integer): Hrgn;
const
  Star_5_Point    : array[0 .. 10] of TFloatPoint = ((X: 0.5; Y: 0), (X: 0.62; Y: 0.36), (X: 1; Y: 0.36), (X: 0.7; Y: 0.59), (X: 0.81; Y: 0.95), (X: 0.5; Y: 0.73), (X: 0.19; Y: 0.95), (X: 0.31; Y: 0.59), (X: 0; Y: 0.36), (X: 0.39; Y: 0.36), (X: 0.5; Y: 0));
var
  iPointCount:  Integer;
  PointArray: array[0 .. 10] of TPoint;
  i: Integer;
begin
  KeepAspectRatioForDimensions(iLeft, iTop, iWidth, iHeight);

  iPointCount := 1 + High(Star_5_Point) - Low(Star_5_Point);
  for i := 0 to iPointCount - 1 do
  begin
    PointArray[i].x := iLeft + round(Star_5_Point[i].x * (iWidth - 1));
    PointArray[i].y := iTop  + round(Star_5_Point[i].y * (iHeight - 1));
  end;               
  Result :=  Windows.CreatePolygonRgn(PointArray, iPointCount, WINDING);
end;


function Create6PointStarRegion(iLeft, iTop, iWidth, iHeight: Integer): Hrgn;
const
  Star_6_Point: array[0 .. 12] of TFloatPoint = ((X: 0.5; Y: 0), (X: 0.625; Y: 0.25), (X: 0.9; Y: 0.25), (X: 0.75; Y: 0.5), (X: 0.9; Y: 0.75), (X: 0.625; Y: 0.75), (X: 0.5; Y: 1), (X: 0.375; Y: 0.75), (X: 0.1; Y: 0.75), (X: 0.25; Y: 0.5), (X: 0.1; Y: 0.25), (X: 0.375; Y: 0.25), (X: 0.5; Y: 0));
var
  iPointCount: Integer;
  PointArray: array[0 .. 12] of TPoint;
  i: Integer;
begin
  KeepAspectRatioForDimensions(iLeft, iTop, iWidth, iHeight);

  iPointCount := 1 + High(Star_6_Point) - Low(Star_6_Point);
  
  for i := 0 to iPointCount - 1 do
  begin
    PointArray[i].x := iLeft + round(Star_6_Point[i].x * (iWidth - 1));
    PointArray[i].y := iTop  + round(Star_6_Point[i].y * (iHeight - 1));
  end;

  Result :=  Windows.CreatePolygonRgn(PointArray, iPointCount, WINDING);
end;



function CreatePointingArrowRegion(iLeft, iTop, iWidth, iHeight: Integer; ADirection: TShapeDirection): Hrgn;
const
  Arrow_NW: array[0 ..  7] of TFloatPoint = ((X: 0; Y: 0), (X: 0.4; Y: 0), (X: 0.3; Y: 0.1), (X: 1; Y: 0.8), (X: 0.8; Y: 1), (X: 0.1; Y: 0.3), (X: 0; Y: 0.4), (X: 0; Y: 0));
var
  iPointCount: Integer;
  PointArray: array[0 .. 7] of TPoint;
  i: Integer;
  iX, iY: Extended;
begin
  KeepAspectRatioForDimensions(iLeft, iTop, iWidth, iHeight);

  iPointCount := 1 + High(Arrow_NW) - Low(Arrow_NW);
  
  for i := 0 to iPointCount - 1 do
  begin
    // FLIP HORZ
    if ADirection in [_xsdNE, _xsdSE] then
      iX := 1 - Arrow_NW[i].x
    else
      iX := Arrow_NW[i].x;

    // FLIP VERT
    if ADirection in [_xsdSE, _xsdSW] then
      iY := 1 - Arrow_NW[i].y
    else
      iY := Arrow_NW[i].y;

    PointArray[i].x := iLeft + round(iX * (iWidth - 1));
    PointArray[i].y := iTop  + round(iY * (iHeight - 1));
  end;

  Result :=  Windows.CreatePolygonRgn(PointArray, iPointCount, WINDING);
end;


function CreateShootingArrowRegion(iLeft, iTop, iWidth, iHeight: Integer; ADirection: TShapeDirection): Hrgn;
const
  Arrow_NW_2      : array[0 .. 30] of TFloatPoint = ((X: 0.85; Y: 1), (X: 0.8; Y: 0.95), (X: 0.8; Y: 0.85), (X: 0.775; Y: 0.825), (X: 0.775; Y: 0.925), (X: 0.725; Y: 0.875), (X: 0.725; Y: 0.775), (X: 0.7; Y: 0.75), (X: 0.7; Y: 0.85), (X: 0.65; Y: 0.8), (X: 0.65; Y: 0.7), (X: 0.15; Y: 0.2), (X: 0.15; Y: 0.3), (X: 0; Y: 0.15), (X: 0; Y: 0), (X: 0.15; Y: 0), (X: 0.3; Y: 0.15), (X: 0.2; Y: 0.15), (X: 0.7; Y: 0.65), (X: 0.8; Y: 0.65), (X: 0.85; Y: 0.7), (X: 0.75; Y: 0.7), (X: 0.775; Y: 0.725), (X: 0.875; Y: 0.725), (X: 0.925; Y: 0.775), (X: 0.825; Y: 0.775), (X: 0.85; Y: 0.8), (X: 0.95; Y: 0.8), (X: 1; Y: 0.85), (X: 0.85; Y: 0.85), (X: 0.85; Y: 1));
var
  iPointCount: Integer;
  PointArray: array[0 .. 30] of TPoint;
  i: Integer;
  iX, iY: Extended;
begin
  KeepAspectRatioForDimensions(iLeft, iTop, iWidth, iHeight);

  iPointCount := 1 + High(Arrow_NW_2) - Low(Arrow_NW_2);
  
  for i := 0 to iPointCount - 1 do
  begin
    // FLIP HORZ
    if ADirection in [_xsdNE, _xsdSE] then
      iX := 1 - Arrow_NW_2[i].x
    else
      iX := Arrow_NW_2[i].x;

    // FLIP VERT
    if ADirection in [_xsdSE, _xsdSW] then
      iY := 1 - Arrow_NW_2[i].y
    else
      iY := Arrow_NW_2[i].y;

    PointArray[i].x := iLeft + round(iX * (iWidth - 1));
    PointArray[i].y := iTop  + round(iY * (iHeight - 1));
  end;

  Result :=  Windows.CreatePolygonRgn(PointArray, iPointCount, WINDING);
end;



function CreateLightningRegion(iLeft, iTop, iWidth, iHeight: Integer; bLeft: Boolean): Hrgn;
const
  Lightning_Left  : array[0 .. 11] of TFloatPoint = ((X: 1; Y: 0.19), (X: 0.61; Y: 0.01), (X: 0.41; Y: 0.29), (X: 0.49; Y: 0.31), (X: 0.23; Y: 0.55), (X: 0.33; Y: 0.6), (X: 0; Y: 1), (X: 0.51; Y: 0.69), (X: 0.46; Y: 0.65), (X: 0.78; Y: 0.45), (X: 0.66; Y: 0.39), (X: 1; Y: 0.19));
var
  iPointCount: Integer;
  PointArray: array[0 .. 11] of TPoint;
  i: Integer;
  iX: Extended;
  iShortSide: Integer;
begin
  // Maintain the Aspect Ratio
  if iWidth > iHeight then
  begin
    iShortSide := iHeight;
    Inc(iLeft, (iWidth - iShortSide) div 2);
    iWidth  := iShortSide;
  end;

  iPointCount := 1 + High(Lightning_Left) - Low(Lightning_Left);
  
  for i := 0 to iPointCount - 1 do
  begin
    if bLeft then
      iX := Lightning_Left[i].x
    else
      iX := 1 - Lightning_Left[i].x;
   PointArray[i].x := iLeft + round(iX * (iWidth - 1));
   PointArray[i].y := iTop  + round(Lightning_Left[i].y * (iHeight - 1));
  end;

  Result :=  Windows.CreatePolygonRgn(PointArray, iPointCount, WINDING);
end;


function CreateExplosionRegion(iLeft, iTop, iWidth, iHeight: Integer; bReverse: Boolean): Hrgn;
const
  Explosion: array[0 .. 24] of TFloatPoint = ((X: 0.33; Y: 0), (X: 0.5; Y: 0.26), (X: 0.62; Y: 0.11), (X: 0.67; Y: 0.28), (X: 0.99; Y: 0.1), (X: 0.78; Y: 0.35), (X: 1; Y: 0.39), (X: 0.84; Y: 0.54), (X: 0.99; Y: 0.66), (X: 0.75; Y: 0.64), (X: 0.78; Y: 0.81), (X: 0.65; Y: 0.71), (X: 0.61; Y: 1), (X: 0.51; Y: 0.69), (X: 0.38; Y: 0.89), (X: 0.35; Y: 0.66), (X: 0.17; Y: 0.83), (X: 0.22; Y: 0.59), (X: 0; Y: 0.61), (X: 0.19; Y: 0.48), (X: 0.04; Y: 0.37), (X: 0.22; Y: 0.34), (X: 0.16; Y: 0.2), (X: 0.35; Y: 0.25), (X: 0.33; Y: 0.01));
var
  iPointCount: Integer;
  PointArray: array[0 .. 24] of TPoint;
  i: Integer;
  iX, iY: Extended;
begin
  iPointCount := 1 + High(Explosion) - Low(Explosion);
  
  for i := 0 to iPointCount - 1 do
  begin
    if bReverse then
    begin
      iX := 1 - Explosion[i].x;
      iY := 1 - Explosion[i].y;
    end
    else    
    begin
      iX := Explosion[i].x;
      iY := Explosion[i].y;
    end;
    PointArray[i].x := iLeft + round(iX * (iWidth - 1));
    PointArray[i].y := iTop  + round(iY * (iHeight - 1));
  end;

  Result :=  Windows.CreatePolygonRgn(PointArray, iPointCount, WINDING);
end;


function CreateCrossRegion(iLeft, iTop, iWidth, iHeight: Integer; rOffset: Single = Cross_Horz_Bar_Vert_Offset): Hrgn;
const
  Cross_Bar_Width = 0.22;
var
  iShortSide: Integer;
  iBarWidth: Integer;
  iBarLeft: Integer;
  iBarTop: Integer;
  HorzRgn: HRGN;
begin
  if iWidth > Round(iHeight * 0.75)  then
  begin
    iShortSide := Round(iHeight * 0.75);
    Inc(iLeft, (iWidth - iShortSide) div 2);
    iWidth  := iShortSide;
  end;

  iBarWidth := Min(Round(iWidth *0.2), Round(iHeight * Cross_Bar_Width));
  iBarLeft  := iLeft + ((iWidth - iBarWidth) div 2);
  iBarTop   := iTop + Round((iHeight - iBarWidth) * rOffset);

  // Vertical  
  Result :=  Windows.CreateRectRgn(iBarLeft, iTop, iBarLeft + iBarWidth, iTop + iHeight);

  // Horizontal
  HorzRgn :=  Windows.CreateRectRgn(iLeft, iBarTop, iLeft + iWidth, iBarTop + iBarWidth);

  combineRgn(Result, Result, HorzRgn, RGN_OR);

  DeleteObject(HorzRgn);
end;



function CreateCustomShapeRegion(AShape: TXCustomShape; iLeft, iTop, iWidth, iHeight: Integer): Hrgn;
begin
  case AShape of
    xcsStar5          : Result := Create5PointStarRegion(iLeft, iTop, iWidth, iHeight);
    xcsStar6          : Result := Create6PointStarRegion(iLeft, iTop, iWidth, iHeight);
    xcsArrowNW        : Result := CreatePointingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdNW);
    xcsArrowNE        : Result := CreatePointingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdNE);
    xcsArrowSW        : Result := CreatePointingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdSW);
    xcsArrowSE        : Result := CreatePointingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdSE);
    xcsLightningLeft  : Result := CreateLightningRegion(iLeft, iTop, iWidth, iHeight, True);
    xcsLightningRight : Result := CreateLightningRegion(iLeft, iTop, iWidth, iHeight, False);
    xcsExplosion      : Result := CreateExplosionRegion(iLeft, iTop, iWidth, iHeight, False);
    xcsExplosion_2    : Result := CreateExplosionRegion(iLeft, iTop, iWidth, iHeight, True);
    xcsCross          : Result := CreateCrossRegion(iLeft, iTop, iWidth, iHeight);
    xcsArrowNW2       : Result := CreateShootingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdNW);
    xcsArrowNE2       : Result := CreateShootingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdNE);
    xcsArrowSW2       : Result := CreateShootingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdSW);
    xcsArrowSE2       : Result := CreateShootingArrowRegion(iLeft, iTop, iWidth, iHeight, _xsdSE);
    xcsHeart          : Result := CreateHeartRegion(iLeft, iTop, iWidth, iHeight);
    else                Result := 0;
  end;
end;


procedure DrawCustomShape(ACanvas: TCanvas; AShape: TXCustomShape; iLeft, iTop, iWidth, iHeight: Integer);
var
  rgnMain: HRGN;
begin
  rgnMain := CreateCustomShapeRegion(AShape, iLeft, iTop, iWidth, iHeight);
  try                                  
    SelectClipRgn(ACanvas.handle, rgnMain);
    ACanvas.FillRect(Rect(iLeft, iTop, iWidth, iHeight));
    SelectClipRgn(ACanvas.handle, 0);
  finally
    DeleteObject(rgnMain);
  end;
end;

end.
