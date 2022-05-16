{------------------------------------------------------------------------------}
{                                                                              }
{  Based on code from TCustomPicShow v4.10 (PSEffect.pas) by:                  }  
{                                                                              }
{  Kambiz R. Khojasteh                                                         }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{                                                                              }
{  And code created by:                                                        }
{                                                                              }
{  Nigel Cross                                                                 }
{  Xequte Software                                                             }
{  nigel@xequte.com                                                            }
{  http://www.xequte.com                                                       }
{                                                                              }
{  XEQUTE CHANGES:                                                             }
{  - 30 extra transition effects                                               }
{  - Change procedures to write to canvas rather than bitmap                   }
{  - Removed transitions that are duplicated in ImageEn or incompatible        }
{  - Renamed transitions to be more consistent with standard naming            }
{  - Categorized transition effects                                            }
{  - Changed order of transitions to match those in ImageEn                    }
{  - Added names for ImageEn transitions so entire transition list can         }
{      be retrieved via the IETransitionList array                             }
{  - Other changes required to integrate with ImageEn                          }
{                                                                              }
{  Xequte Code is Copyright Xequte Software 2010                               }
{                                                                              }
{------------------------------------------------------------------------------}

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

{$IFDEF VER150}
  {$DEFINE DELPHI7}
  {$DEFINE DELPHI7_UP}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF VER140}
  {$DEFINE DELPHI6}
  {$DEFINE DELPHI6_UP}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF VER130}
  {$DEFINE DELPHI5}
  {$DEFINE DELPHI5_UP}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF VER120}
  {$DEFINE DELPHI4}
  {$DEFINE DELPHI4_UP}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF VER100}
  {$DEFINE DELPHI3}
  {$DEFINE DELPHI3_UP}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF VER90}
  {$DEFINE DELPHI2}
  {$DEFINE DELPHI2_UP}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$IFDEF VER80}
  {$DEFINE DELPHI1}
  {$DEFINE DELPHI1_UP}
{$ENDIF}

{$I ie.inc}

{$R-}

unit ieXtraTransitions;

interface

{$ifdef IEINCLUDEEXTRATRANSITIONS}

uses
  Windows, Messages, SysUtils, Classes, Graphics;

type
  TEffectProc = procedure(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect;
    Step: Integer; Progress: Integer);

  procedure Effect001(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect002(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect003(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect004(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect007(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect008(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect009(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect010(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect011(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect012(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect013(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect014(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect015(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect016(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect017(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect018(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect019(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect020(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect021(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect024(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect025(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect026(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect027(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect028(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect029(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect030(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect031(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect032(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect033(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect034(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect035(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect036(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect037(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect038(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect043(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect044(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect045(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect046(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect047(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect048(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect049(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect050(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect051(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect055(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect056(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect057(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect058(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect059(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect060(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect061(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect062(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect063(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect064(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect065(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect066(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect067(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect068(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect069(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect070(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect071(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect072(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect073(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect074(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect075(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect076(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect077(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect078(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect079(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect080(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect081(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect082(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect083(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect084(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect085(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect086(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect087(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect088(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect089(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect090(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect091(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect092(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect093(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect094(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect095(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect096(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect097(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect098(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect099(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect100(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect101(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect102(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect103(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect104(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect105(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect106(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect107(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect108(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect109(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect110(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect111(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect112(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect113(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect114(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect115(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect116(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect117(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect118(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect124(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect125(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect126(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect127(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect129(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect130(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect131(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect132(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect133(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect134(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect135(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect136(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect137(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect138(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect139(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect140(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect141(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect142(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect143(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect144(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect145(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect146(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect147(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect148(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect149(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect150(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);   
  procedure Effect150B(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect151(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect151B(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect152(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);  
  procedure Effect152B(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect153(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect154(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect155(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect156(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect157(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect158(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect159(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect160(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect161(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect162(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect163(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect164(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect165(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect166(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  procedure Effect167(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Zigzag Wipe To Horizon
  procedure Effect162_Reverse(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Zigzag Wipe To Vertical Center
  procedure Effect163_Reverse(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Triangular Wipe
  procedure TriangularWipeEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Random Big Boxes
  procedure RandomBigBoxesEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Book Page Flip  - © Xequte Software 2010
  procedure BookFlipEffect_NoEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Book Page Flip (Showing page edge)  - © Xequte Software 2010
  procedure BookFlipEffect_WithEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // R to L Book Page Flip   - © Xequte Software 2010
  procedure ReverseBookFlipEffect_NoEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
  
  // R to L Book Page Flip (Showing page edge)  - © Xequte Software 2010
  procedure ReverseBookFlipEffect_WithEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Hearts at random positions  - © Xequte Software 2010
  procedure RandomHeartsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 5 Point Stars at random positions  - © Xequte Software 2010
  procedure RandomStar5sEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 6 Point Stars at random positions  - © Xequte Software 2010
  procedure RandomStar6sEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Explosions at random positions  - © Xequte Software 2010
  procedure RandomExplosionsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Expanding Hearts  - © Xequte Software 2010
  procedure ExpandingHeartsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Expanding 5 Point Stars  - © Xequte Software 2010
  procedure ExpandingStar5Effect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Expanding 6 Point Stars  - © Xequte Software 2010
  procedure ExpandingStar6Effect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Expanding Explosions  - © Xequte Software 2010
  procedure ExpandingExplosionsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Expanding Lightning Bolts  - © Xequte Software 2010
  procedure ExpandingLightningBoltsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Heart Wipe from Center  - © Xequte Software 2010
  procedure HeartWipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Heart Wipe to Center  - © Xequte Software 2010
  procedure HeartWipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 5 Point Star Wipe from Center  - © Xequte Software 2010
  procedure Star5WipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 5 Point Star Wipe to Center  - © Xequte Software 2010
  procedure Star5WipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 6 Point Star Wipe from Center  - © Xequte Software 2010
  procedure Star6WipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 6 Point Star Wipe to Center  - © Xequte Software 2010
  procedure Star6WipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Explosion Wipe from Center  - © Xequte Software 2010
  procedure ExplosionWipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Explosion Wipe to Center  - © Xequte Software 2010
  procedure ExplosionWipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Cross Wipe from Center  - © Xequte Software 2010
  procedure CrossWipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Cross Wipe to Center  - © Xequte Software 2010
  procedure CrossWipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Heart Wipe In and Out  - © Xequte Software 2010
  procedure HeartWipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 5 Point Star Wipe In and Out  - © Xequte Software 2010
  procedure Star5WipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // 6 Point Star Wipe In and Out  - © Xequte Software 2010
  procedure Star6WipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  // Explosion Wipe In and Out  - © Xequte Software 2010
  procedure ExplosionWipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  
type
  TTransitionCategory = (tcGeneral, tcWipes, tcSpecialWipes, tcCurvedWipes, tcAngledWipes, tcCenterWipes, tcInAndOuts,
                         tcShreds, tcBars, tcSlides, tcPushes, tcShrinks, tcExpands, tcMultiExpanders, tcRandoms,
                         tcRotates, tcOther, tcUnattractive);
  TEffect = record
    Name: String;
    Proc: TEffectProc;
    Category: TTransitionCategory;
    Overlay: Boolean;
  end;

const
  {
  NOTE:
  - REMOVED ALL EFFECTS THAT ARE THE SAME AS THOSE ALREADY IN IMAGEEN
  - ALSO RE-ORDERED TO MAKE MORE CONSISTENT WITH IMAGEEN
  }

  MAX_TRANSITIONS = 214;

  IETransitionList: array[1..MAX_TRANSITIONS] of TEffect = (

  // ADD IMAGEEN TRANSITIONS TO OUR ARRAY SO ALL TRANSITION NAMES CAN BE ACCESSED

    (Name: 'Cross Fade';                                      Proc: nil;                            Category: tcGeneral;           Overlay: True),
    (Name: 'Fade Out';                                        Proc: nil;                            Category: tcUnattractive;      Overlay: False),
    (Name: 'Fade In';                                         Proc: nil;                            Category: tcUnattractive;      Overlay: False),
    (Name: 'Fade Out then In';                                Proc: nil;                            Category: tcGeneral;           Overlay: False),
    (Name: 'Wipe Left to Right';                              Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe Left to Right 2';                            Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe Right to Left';                              Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe Right to Left 2';                            Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe Top to Bottom';                              Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe Top to Bottom 2';                            Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe Bottom to Top';                              Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe Bottom to Top 2';                            Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Slide from Top Left';                             Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Slide from Top Right';                            Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Slide from Bottom Left';                          Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Slide from Bottom Right';                         Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Push Left to Right';                              Proc: nil;                            Category: tcPushes;            Overlay: False),
    (Name: 'Slide Out Left to Right';                         Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Push Right to Left';                              Proc: nil;                            Category: tcPushes;            Overlay: False),
    (Name: 'Slide Out Right to Left';                         Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Push Top to Bottom';                              Proc: nil;                            Category: tcPushes;            Overlay: False),
    (Name: 'Slide Out Top to Bottom';                         Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Push Bottom to Top';                              Proc: nil;                            Category: tcPushes;            Overlay: False),
    (Name: 'Slide Out Bottom to Top';                         Proc: nil;                            Category: tcSlides;            Overlay: False),
    (Name: 'Random Points';                                   Proc: nil;                            Category: tcRandoms;           Overlay: True),
    (Name: 'Random Boxes';                                    Proc: nil;                            Category: tcRandoms;           Overlay: True),
    (Name: 'Wipe Out from Center';                            Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Wipe In to Center';                               Proc: nil;                            Category: tcWipes;             Overlay: True),
    (Name: 'Expand Out from Center';                          Proc: nil;                            Category: tcExpands;           Overlay: False),
    (Name: 'Expand In to Center';                             Proc: nil;                            Category: tcExpands;           Overlay: False),

     // PS EFFECTS START
    (Name: 'Expand from Left';	                              Proc: Effect002;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand from Right';	                              Proc: Effect001;                      Category: tcExpands;           Overlay: False),

    (Name: 'Expand from Top';	                              Proc: Effect019;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand from Bottom';	                      Proc: Effect018;                      Category: tcExpands;           Overlay: False),

    (Name: 'Expand from Top Left';	                      Proc: Effect037;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand from Top Right';	                      Proc: Effect036;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand from Bottom Left';	                      Proc: Effect038;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand from Bottom Right';	                      Proc: Effect035;                      Category: tcExpands;           Overlay: False),

    (Name: 'Expand in from Left';	                      Proc: Effect008;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand in from Right';	                      Proc: Effect007;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand in from Top';	                      Proc: Effect025;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand in from Bottom';	                      Proc: Effect024;                      Category: tcExpands;           Overlay: False),

    (Name: 'Expand in to Vertical Center';                    Proc: Effect009;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand in to Horizon';       	              Proc: Effect026;                      Category: tcExpands;           Overlay: False),

    (Name: 'Expand in from Sides';	                      Proc: Effect013;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand in from Top and Bottom';	              Proc: Effect030;                      Category: tcExpands;           Overlay: False),

    (Name: 'Expand out from Horizon';	                      Proc: Effect027;                      Category: tcExpands;           Overlay: False),
    (Name: 'Expand out from Vertical Center';	              Proc: Effect010;                      Category: tcExpands;           Overlay: False),

    (Name: 'Wipe from Top Left';	                      Proc: Effect043;                      Category: tcWipes;             Overlay: True),
    (Name: 'Wipe from Top Right';	                      Proc: Effect046;                      Category: tcWipes;             Overlay: True),
    (Name: 'Wipe from Bottom Left';	                      Proc: Effect044;                      Category: tcWipes;             Overlay: True),
    (Name: 'Wipe from Bottom Right';	                      Proc: Effect045;                      Category: tcWipes;             Overlay: True),

    (Name: 'Wipe in from Top and Bottom';	              Proc: Effect029;                      Category: tcWipes;             Overlay: True),
    (Name: 'Wipe from Horizon';	                              Proc: Effect028;                      Category: tcWipes;             Overlay: True),
    (Name: 'Wipe in from Sides';	                      Proc: Effect012;                      Category: tcWipes;             Overlay: True),
    (Name: 'Wipe out from Vertical Center';	              Proc: Effect011;                      Category: tcWipes;             Overlay: True),

    (Name: 'Build up from Left';	                      Proc: Effect017;                      Category: tcOther;             Overlay: False),
    (Name: 'Build up from Right';	                      Proc: Effect016;                      Category: tcOther;             Overlay: False),
    (Name: 'Build up from Top';	                              Proc: Effect034;                      Category: tcOther;             Overlay: False),
    (Name: 'Build up from Bottom';	                      Proc: Effect033;                      Category: tcOther;             Overlay: False),

    (Name: 'Unroll from Left';	                              Proc: Effect014;                      Category: tcSpecialWipes;      Overlay: True),
    (Name: 'Unroll from Right';	                              Proc: Effect015;                      Category: tcSpecialWipes;      Overlay: True),
    (Name: 'Unroll from Top';	                              Proc: Effect031;                      Category: tcSpecialWipes;      Overlay: True),
    (Name: 'Unroll from Bottom';	                      Proc: Effect032;                      Category: tcSpecialWipes;      Overlay: True),

    (Name: 'Slide in from Left';	                      Proc: Effect004;                      Category: tcSlides;            Overlay: False),
    (Name: 'Slide in from Right';	                      Proc: Effect003;                      Category: tcSlides;            Overlay: False),
    (Name: 'Slide in from Top';	                              Proc: Effect021;                      Category: tcSlides;            Overlay: False),
    (Name: 'Slide in from Bottom';                            Proc: Effect020;                      Category: tcSlides;            Overlay: False),

    (Name: 'Shrink to Top Left';	                      Proc: Effect047;                      Category: tcShrinks;           Overlay: False),
    (Name: 'Shrink to Top Right';	                      Proc: Effect050;                      Category: tcShrinks;           Overlay: False),
    (Name: 'Shrink to Bottom Left';	                      Proc: Effect048;                      Category: tcShrinks;           Overlay: False),
    (Name: 'Shrink to Bottom Right';	                      Proc: Effect049;                      Category: tcShrinks;           Overlay: False),
    (Name: 'Shrink to Center';	                              Proc: Effect051;                      Category: tcShrinks;           Overlay: False),

    (Name: 'Quarters Wipe in to Center';	              Proc: Effect055;                      Category: tcWipes;             Overlay: True),
    (Name: 'Quarters Expand to Center';	                      Proc: Effect056;                      Category: tcExpands;           Overlay: False),
    (Name: 'Quarters Slide in to Center';	              Proc: Effect057;                      Category: tcSlides;            Overlay: False),

    (Name: 'Curved Wipe from Left';	                      Proc: Effect058;                      Category: tcCurvedWipes;       Overlay: True),
    (Name: 'Curved Wipe from Right';	                      Proc: Effect059;                      Category: tcCurvedWipes;       Overlay: True),
    (Name: 'Curved Wipe from Top';	                      Proc: Effect069;                      Category: tcCurvedWipes;       Overlay: True),
    (Name: 'Curved Wipe from Bottom';	                      Proc: Effect070;                      Category: tcCurvedWipes;       Overlay: True),

    (Name: 'Curved Wipe from Top Left';	                      Proc: Effect080;                      Category: tcCurvedWipes;       Overlay: True),
    (Name: 'Curved Wipe from Top Right';	              Proc: Effect081;                      Category: tcCurvedWipes;       Overlay: True),
    (Name: 'Curved Wipe from Bottom Left';	              Proc: Effect082;                      Category: tcCurvedWipes;       Overlay: True),
    (Name: 'Curved Wipe from Bottom Right';	              Proc: Effect083;                      Category: tcCurvedWipes;       Overlay: True),

    (Name: 'Bars in from Left';	                              Proc: Effect061;                      Category: tcBars;              Overlay: True),
    (Name: 'Bars in from Right';	                      Proc: Effect060;                      Category: tcBars;              Overlay: True),
    (Name: 'Bars from Top';	                              Proc: Effect072;                      Category: tcBars;              Overlay: True),
    (Name: 'Bars from Bottom';	                              Proc: Effect071;                      Category: tcBars;              Overlay: True),

    (Name: 'Bars Left then Right';	                      Proc: Effect062;                      Category: tcBars;              Overlay: True),
    (Name: 'Bars Right then Left';	                      Proc: Effect063;                      Category: tcBars;              Overlay: True),
    (Name: 'Bars Top then Bottom';	                      Proc: Effect073;                      Category: tcBars;              Overlay: True),
    (Name: 'Bars Bottom then Top';	                      Proc: Effect074;                      Category: tcBars;              Overlay: True),

    (Name: 'Bars from both Sides';	                      Proc: Effect064;                      Category: tcBars;              Overlay: True),
    (Name: 'Bars from Top and Bottom';	                      Proc: Effect075;                      Category: tcBars;              Overlay: True),

    (Name: 'Shredded from Left';	                      Proc: Effect066;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Right';	                      Proc: Effect065;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Top';	                              Proc: Effect077;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Bottom';	                      Proc: Effect076;                      Category: tcShreds;            Overlay: True),

    (Name: 'Shredded from Top and Left';	              Proc: Effect103;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Top and Right';	              Proc: Effect101;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Bottom and Left';	              Proc: Effect102;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Bottom and Right';	              Proc: Effect100;                      Category: tcShreds;            Overlay: True),

    (Name: 'Shredded from Horizon and Left';	              Proc: Effect105;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Horizon and Right';	              Proc: Effect104;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Top and Vertical Center';	      Proc: Effect107;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded from Bottom and Vertical Center';	      Proc: Effect106;                      Category: tcShreds;            Overlay: True),

    (Name: 'Shredded from Center';	                      Proc: Effect108;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded to Center';	                      Proc: Effect109;                      Category: tcShreds;            Overlay: True),

    (Name: 'Shredded in to Horizon';	                      Proc: Effect079;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded in to Vertical Center';                  Proc: Effect068;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded out from Horizon';	                      Proc: Effect078;                      Category: tcShreds;            Overlay: True),
    (Name: 'Shredded out from Vertical Center';               Proc: Effect067;                      Category: tcShreds;            Overlay: True),

    (Name: 'Expanding Rectangles';                            Proc: Effect143;                      Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Expanding Triangles';                             Proc: Effect118;                      Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Expanding Circles';                               Proc: Effect153;                      Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Expanding Diamonds';                              Proc: Effect164;                      Category: tcMultiExpanders;    Overlay: True),

    (Name: 'Circular Wipe from Center';	                      Proc: Effect084;                      Category: tcCenterWipes;       Overlay: True),
    (Name: 'Circular Wipe to Center';	                      Proc: Effect085;                      Category: tcCenterWipes;       Overlay: True),

    (Name: 'Crisscross Wipe from Top Left';	              Proc: Effect089;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Top Right';	              Proc: Effect087;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Bottom Left';	              Proc: Effect088;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Bottom Right';	              Proc: Effect086;                      Category: tcBars;              Overlay: True),

    (Name: 'Crisscross Wipe Bounce from Top Left';	      Proc: Effect090;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe Bounce from Top Right';	      Proc: Effect092;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe Bounce from Bottom Left';         Proc: Effect091;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe Bounce from Bottom Right';	      Proc: Effect093;                      Category: tcBars;              Overlay: True),

    (Name: 'Crisscross Wipe from Left Right and Top';	      Proc: Effect097;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Left Right and Bottom';      Proc: Effect096;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Left Top and Bottom';	      Proc: Effect095;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Top Left Right and Bottom';  Proc: Effect098;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Right Top and Bottom';	      Proc: Effect094;                      Category: tcBars;              Overlay: True),
    (Name: 'Crisscross Wipe from Bottom Left Top Right';      Proc: Effect099;                      Category: tcBars;              Overlay: True),

    (Name: 'Wipe diagonal from Top Left';	              Proc: Effect110;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Wipe diagonal from Top Right';	              Proc: Effect111;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Wipe diagonal from Bottom Left';	              Proc: Effect112;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Wipe diagonal from Bottom Right';	              Proc: Effect113;                      Category: tcAngledWipes;       Overlay: True),

    (Name: 'Diagonal Sweep Clockwise';                        Proc: Effect115;                      Category: tcRotates;           Overlay: True),
    (Name: 'Diagonal Sweep Counter-Clockwise';                Proc: Effect114;                      Category: tcRotates;           Overlay: True),
    (Name: 'Sweep Clockwise';                                 Proc: Effect144;                      Category: tcRotates;           Overlay: True),
    (Name: 'Sweep Counter-Clockwise';                         Proc: Effect145;                      Category: tcRotates;           Overlay: True),

    (Name: 'Starburst Clockwise';	                      Proc: Effect116;                      Category: tcRotates;           Overlay: True),
    (Name: 'Starburst Counter-Clockwise';                     Proc: Effect117;                      Category: tcRotates;           Overlay: True),

    (Name: 'Rotational Rectangle Clockwise';                  Proc: Effect150;                      Category: tcRotates;           Overlay: True),
    (Name: 'Rotational Rectangle Counter-Clockwise';          Proc: Effect150B;                     Category: tcRotates;           Overlay: True),
    (Name: 'Rotational Star Clockwise';                       Proc: Effect151;                      Category: tcRotates;           Overlay: True),
    (Name: 'Rotational Star Counter-Clockwise';               Proc: Effect151B;                     Category: tcRotates;           Overlay: True),

    (Name: 'Speckled Wipe from Left';	                      Proc: Effect125;                      Category: tcSpecialWipes;      Overlay: True),
    (Name: 'Speckled Wipe from Right';	                      Proc: Effect124;                      Category: tcSpecialWipes;      Overlay: True),
    (Name: 'Speckled Wipe from Top';	                      Proc: Effect127;                      Category: tcSpecialWipes;      Overlay: True),
    (Name: 'Speckled Wipe from Bottom';	                      Proc: Effect126;                      Category: tcSpecialWipes;      Overlay: True),

    (Name: 'Push Left and Slide out';	                      Proc: Effect130;                      Category: tcPushes;            Overlay: False),
    (Name: 'Push Right and Slide out';                        Proc: Effect129;                      Category: tcPushes;            Overlay: False),
    (Name: 'Push up and Slide out';	                      Proc: Effect134;                      Category: tcPushes;            Overlay: False),
    (Name: 'Push down and Slide out';	                      Proc: Effect133;                      Category: tcPushes;            Overlay: False),

    (Name: 'Push and Squeeze Left';                           Proc: Effect132;                      Category: tcPushes;            Overlay: False),
    (Name: 'Push and Squeeze Right';                          Proc: Effect131;                      Category: tcPushes;            Overlay: False),
    (Name: 'Push and Squeeze up';                             Proc: Effect136;                      Category: tcPushes;            Overlay: False),
    (Name: 'Push and Squeeze down';                           Proc: Effect135;                      Category: tcPushes;            Overlay: False),

    (Name: 'Horizontal Blinds';                               Proc: Effect138;                      Category: tcOther;             Overlay: True),
    (Name: 'Vertical Blinds';                                 Proc: Effect137;                      Category: tcOther;             Overlay: True),

    (Name: 'Uneven Blinds from Left';                         Proc: Effect139;                      Category: tcOther;             Overlay: True),
    (Name: 'Uneven Blinds from Right';                        Proc: Effect140;                      Category: tcOther;             Overlay: True),
    (Name: 'Uneven Blinds from Top';	                      Proc: Effect141;                      Category: tcOther;             Overlay: True),
    (Name: 'Uneven Blinds from Bottom';                       Proc: Effect142;                      Category: tcOther;             Overlay: True),

    (Name: 'Rectangles from the Left';                        Proc: Effect146;                      Category: tcUnattractive;      Overlay: True),
    (Name: 'Rectangles from the Right';                       Proc: Effect147;                      Category: tcUnattractive;      Overlay: True),
    (Name: 'Rectangles from the Top';                         Proc: Effect148;                      Category: tcUnattractive;      Overlay: True),
    (Name: 'Rectangles from the Bottom';                      Proc: Effect149;                      Category: tcUnattractive;      Overlay: True),

    (Name: 'Spiralling Rectangle Clockwise';                  Proc: Effect152;                      Category: tcRotates;           Overlay: True),
    (Name: 'Spiralling Rectangle Counter-Clockwise';          Proc: Effect152B;                     Category: tcRotates;           Overlay: True),

    (Name: 'Arrow Wipe from Left';                            Proc: Effect154;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Arrow Wipe from Right';                           Proc: Effect155;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Arrow Wipe from Top';                             Proc: Effect156;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Arrow Wipe from Bottom';                          Proc: Effect157;                      Category: tcAngledWipes;       Overlay: True),

    (Name: 'Horizontal Bow Tie Wipe';                         Proc: Effect158;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Vertical Bow Tie Wipe';                           Proc: Effect159;                      Category: tcAngledWipes;       Overlay: True),

    (Name: 'Diagonal Cross from Center';                      Proc: Effect161;                      Category: tcCenterWipes;       Overlay: True),
    (Name: 'Diagonal Cross to Center';                        Proc: Effect160;                      Category: tcCenterWipes;       Overlay: True),

    (Name: 'Zigzag Wipe from Horizon';                        Proc: Effect162;                      Category: tcAngledWipes;       Overlay: True),
    (Name: 'Zigzag Wipe from Vertical Center';                Proc: Effect163;                      Category: tcAngledWipes;       Overlay: True),

    (Name: 'Diamond Wipe from Center';                        Proc: Effect165;                      Category: tcCenterWipes;       Overlay: True),
    (Name: 'Diamond Wipe to Center';                          Proc: Effect166;                      Category: tcCenterWipes;       Overlay: True),

    (Name: 'Diamond Wipe In and Out';                         Proc: Effect167;                      Category: tcInAndOuts;         Overlay: True),
    (Name: 'Triangular Wipe';                                 Proc: TriangularWipeEffect;           Category: tcAngledWipes;       Overlay: True),

    // Xequte Transitions start
    (Name: 'Random Big Boxes';                                Proc: RandomBigBoxesEffect;           Category: tcRandoms;           Overlay: True),
    (Name: 'Page Flip';                                       Proc: BookFlipEffect_NoEdge;          Category: tcGeneral;           Overlay: False),
    (Name: 'Page Flip 2';                                     Proc: BookFlipEffect_WithEdge;        Category: tcGeneral;           Overlay: False),
    (Name: 'Reverse Page Flip';                               Proc: ReverseBookFlipEffect_NoEdge;   Category: tcGeneral;           Overlay: False),
    (Name: 'Reverse Page Flip 2';                             Proc: ReverseBookFlipEffect_WithEdge; Category: tcGeneral;           Overlay: False),
    (Name: 'Zigzag Wipe To Horizon';                          Proc: Effect162_Reverse;              Category: tcAngledWipes;       Overlay: True),
    (Name: 'Zigzag Wipe To Vertical Center';                  Proc: Effect163_Reverse;              Category: tcAngledWipes;       Overlay: True),
    (Name: 'Random Hearts';                                   Proc: RandomHeartsEffect;             Category: tcRandoms;           Overlay: True),
    (Name: 'Random 5 Pointed Stars';                          Proc: RandomStar5sEffect;             Category: tcRandoms;           Overlay: True),
    (Name: 'Random 6 Pointed Stars';                          Proc: RandomStar6sEffect;             Category: tcRandoms;           Overlay: True),
    (Name: 'Random Explosions';                               Proc: RandomExplosionsEffect;         Category: tcRandoms;           Overlay: True),
    (Name: 'Expanding Hearts';                                Proc: ExpandingHeartsEffect;          Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Expanding 5 Pointed Stars';                       Proc: ExpandingStar5Effect;           Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Expanding 6 Pointed Stars';                       Proc: ExpandingStar6Effect;           Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Expanding Explosions';                            Proc: ExpandingExplosionsEffect;      Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Expanding Lightning Bolts';                       Proc: ExpandingLightningBoltsEffect;  Category: tcMultiExpanders;    Overlay: True),
    (Name: 'Heart Wipe from Center';                          Proc: HeartWipeOutEffect;             Category: tcCenterWipes;       Overlay: True),
    (Name: 'Heart Wipe to Center';                            Proc: HeartWipeInEffect;              Category: tcCenterWipes;       Overlay: True),
    (Name: '5 Pointed Star Wipe from Center';                 Proc: Star5WipeOutEffect;             Category: tcCenterWipes;       Overlay: True),
    (Name: '5 Pointed Star Wipe to Center';                   Proc: Star5WipeInEffect;              Category: tcCenterWipes;       Overlay: True),
    (Name: '6 Pointed Star Wipe from Center';                 Proc: Star6WipeOutEffect;             Category: tcCenterWipes;       Overlay: True),
    (Name: '6 Pointed Star Wipe to Center';                   Proc: Star6WipeInEffect;              Category: tcCenterWipes;       Overlay: True),
    (Name: 'Explosion Wipe from Center';                      Proc: ExplosionWipeOutEffect;         Category: tcCenterWipes;       Overlay: True),
    (Name: 'Explosion Wipe to Center';                        Proc: ExplosionWipeInEffect;          Category: tcCenterWipes;       Overlay: True),
    (Name: 'Cross Wipe from Center';                          Proc: CrossWipeOutEffect;             Category: tcCenterWipes;       Overlay: True),
    (Name: 'Cross Wipe to Center';                            Proc: CrossWipeInEffect;              Category: tcCenterWipes;       Overlay: True),
    (Name: 'Heart Wipe In and Out';                           Proc: HeartWipeInAndOutEffect;        Category: tcInAndOuts;         Overlay: True),
    (Name: '5 Pointed Star Wipe In and Out';                  Proc: Star5WipeInAndOutEffect;        Category: tcInAndOuts;         Overlay: True),
    (Name: '6 Pointed Star Wipe In and Out';                  Proc: Star6WipeInAndOutEffect;        Category: tcInAndOuts;         Overlay: True),
    (Name: 'Explosion Wipe In and Out';                       Proc: ExplosionWipeInAndOutEffect;    Category: tcInAndOuts;         Overlay: True)

    );


{ THE FOLLOWING EFFECTS WERE REMOVED, SEE RELEVANT PROCEDURE BELOW FOR REASON
    (Name: 'Wipe from Left';	                                        Proc: Effect005),
    (Name: 'Wipe from Right';	                                        Proc: Effect006),
    (Name: 'Wipe from Top';	                                        Proc: Effect022),
    (Name: 'Wipe from Bottom';	                                        Proc: Effect023),
    (Name: 'Slide in from Bottom Right';	                        Proc: Effect039),
    (Name: 'Slide in from Top Right';	                                Proc: Effect040),
    (Name: 'Slide in from Top Left';	                                Proc: Effect041),
    (Name: 'Slide in from Bottom Left';	                                Proc: Effect042), 
                                                                                         
    (Name: 'Expand out from centre';	                                Proc: Effect052),
    (Name: 'Wipe out from centre';	                                Proc: Effect053),
    (Name: 'Wipe in to centre';	                                        Proc: Effect054),
    (Name: 'Fade';	                                                Proc: Effect119),
    (Name: 'Pivot from Top Left';	                                Proc: Effect120),
    (Name: 'Pivot from Bottom Left';	                                Proc: Effect121),
    (Name: 'Pivot from Top Right';	                                Proc: Effect122),
    (Name: 'Pivot from Bottom Right';	                                Proc: Effect123),
    (Name: 'Random squares appear';	                                Proc: Effect128),  
    (Name: 'Pixelate';                                                  Proc: Effect168),
    (Name: 'Dissolve';                                                  Proc: Effect169),
    (Name: 'Random Bars Horizontal';                                    Proc: Effect170),
    (Name: 'Random Bars Vertical';                                      Proc: Effect171),
    (Name: 'Channel Mix';                                               Proc: Effect172)
}





{$endif}


implementation

{$ifdef IEINCLUDEEXTRATRANSITIONS}

uses
  imageenproc, hyieutils, ieXCanvasUtils, {$IFDEF DELPHI6_UP} Types, {$ENDIF} Math;

type
  {$IFNDEF DELPHI4_UP}
  HRGN = THandle;
  {$ENDIF}
  TComplexRegion = class(TObject)
  private
    RgnData: PRgnData;
    Capacity: Integer;
    Count: Integer;
    Bounds: TRect;
    Rect: PRect;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure AddRect(Left, Top, Right, Bottom: Integer);
    function CreateRegion: HRGN;
  end;




{ TComplexRegion }

constructor TComplexRegion.Create;
begin
  inherited Create;
  Clear;
end;

destructor TComplexRegion.Destroy;
begin
  ReallocMem(RgnData, 0);
  inherited Destroy;
end;

procedure TComplexRegion.Clear;
begin
  ReallocMem(RgnData, 0);
  Count := 0;
  Capacity := 0;
  with Bounds do
  begin
    Left := +MaxInt;
    Top := +MaxInt;
    Right := -MaxInt;
    Bottom := -MaxInt;
  end;
end;

procedure TComplexRegion.AddRect(Left, Top, Right, Bottom: Integer);
begin
  if Count = Capacity then
  begin
    Inc(Capacity, 500);
    ReallocMem(RgnData, SizeOf(TRgnData) + Capacity * SizeOf(TRect));
    Rect := PRect(@(RgnData^.Buffer));
    Inc(Rect, Count);
  end;
  Rect^.Left := Left;
  Rect^.Top := Top;
  Rect^.Right := Right;
  Rect^.Bottom := Bottom;
  Inc(Rect);
  Inc(Count);
  if Bounds.Left > Left then
    Bounds.Left := Left;
  if Bounds.Top > Top then
    Bounds.Top := Top;
  if Bounds.Right < Right then
    Bounds.Right := Right;
  if Bounds.Bottom < Bottom then
    Bounds.Bottom := Bottom;
end;

function TComplexRegion.CreateRegion: HRGN;
begin
  if Assigned(RgnData) then
  begin
    with RgnData^.rdh do
    begin
      dwSize := SizeOf(TRgnDataHeader);
      iType := RDH_RECTANGLES;
      nCount := Count;
      nRgnSize := SizeOf(TRect);
      rcBound := Bounds;
    end;
    Result := ExtCreateRegion(nil, SizeOf(TRgnData) + Count * SizeOf(TRect), RgnData^);
  end
  else
    Result := 0;
end;


{ Custom Shapes }


function CreateCustomShape(AShape: TXCustomShape; ARect: TRect): Hrgn;
var
  iLeft, iTop, iWidth, iHeight: Integer;
begin
  iLeft   := ARect.Left;
  iTop    := ARect.Top;
  iWidth  := ARect.Right - ARect.Left;
  iHeight := ARect.Bottom - ARect.Top;

  Result := CreateCustomShapeRegion(AShape, iLeft, iTop, iWidth, iHeight);
end;

                  
      
{ Global Functions }

procedure MirrorCopyRect(Canvas: TCanvas; dstRect: TRect;
  Bitmap: TBitmap; srcRect: TRect; Horz, Vert: Boolean);
var
  T: Integer;
begin
  IntersectRect(srcRect, srcRect, Rect(0, 0, Bitmap.Width, Bitmap.Height));
  if Horz then
  begin
    T := dstRect.Left;
    dstRect.Left := dstRect.Right+1;
    dstRect.Right := T-1;
  end;
  if Vert then
  begin
    T := dstRect.Top;
    dstRect.Top := dstRect.Bottom+1;
    dstRect.Bottom := T-1;
  end;
  SetStretchBltMode(Canvas.Handle, HALFTONE);
  StretchBlt(Canvas.Handle, dstRect.Left, dstRect.Top,
     dstRect.Right - dstRect.Left, dstRect.Bottom - dstRect.Top,
     Bitmap.Canvas.Handle, srcRect.Left, srcRect.Top,
     srcRect.Right - srcRect.Left, srcRect.Bottom - srcRect.Top, SRCCOPY);
end;

procedure RotatePoints(var Points: array of TPoint; xOrg, yOrg: Integer;
  Angle: Extended);
var
  Sin, Cos: Extended;
  xPrime, yPrime: Integer;
  I: Integer;
begin
 SinCos(Angle, Sin, Cos);
 for I := Low(Points) to High(Points) do
   with Points[I] do
   begin
     xPrime := X - xOrg;
     yPrime := Y - yOrg;
     X := Round(xPrime * Cos - yPrime * Sin) + xOrg;
     Y := Round(xPrime * Sin + yPrime * Cos) + yOrg;
   end;
end;

{ Helper Functions }

{$IFNDEF DELPHI4_UP}
function Min(A, B: Integer): Integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;
{$ENDIF}

{$IFNDEF DELPHI4_UP}
function Max(A, B: Integer): Integer;
begin
  if A > B then
    Result := A
  else
    Result := B;
end;
{$ENDIF}

// PS to IE Parameter conversion
// W and H remain constant regardless of Progress
// X and Y increase in proportion to progress
procedure CalcParams(const ARect: TRect; Progress: Integer; var W, H, X, Y: Integer);
begin
  W := ARect.Right  - ARect.Left;
  H := ARect.Bottom - ARect.Top;
  if W >= H then
  begin
    X := MulDiv(W, Progress, 100);
    Y := MulDiv(X, H, W);
  end
  else
  begin
    Y := MulDiv(H, Progress, 100);
    X := MulDiv(Y, W, H);
  end;
end;



function CreateBarRgn(X, Y, W, H: Integer; XMode, YMode: Integer): HRGN;
var
  X1, Y1, D: Integer;
  ComplexRgn: TComplexRegion;
begin
  D := (Min(W, H) div 50) + 1;
  ComplexRgn := TComplexRegion.Create;
  try
    if X <= W then
      Y1 := 0
    else
      Y1 := D;
    while Y1 < H + D do
    begin
      if X > W then
      begin
        if XMode in [1, 4] then
          ComplexRgn.AddRect(2 * W - X, Y1, W, Y1 + D)
        else if XMode in [2, 5] then
          ComplexRgn.AddRect(0, Y1, X - W, Y1 + D);
        ComplexRgn.AddRect(0, Y1 - D, W, Y1);
      end
      else
      begin
        if XMode in [1, 5] then
          ComplexRgn.AddRect(W - X, Y1, W, Y1 + D)
        else if XMode in [2, 4] then
          ComplexRgn.AddRect(0, Y1, X, Y1 + D)
        else if XMode = 3 then
        begin
          ComplexRgn.AddRect(0, Y1 + D, X, Y1 + D + D);
          ComplexRgn.AddRect(W - X, Y1, W, Y1 + D);
        end;
      end;
      Inc(Y1, 2 * D);
    end;
    if Y <= H then
      X1 := 0
    else
      X1 := D;
    while X1 < W + D do
    begin
      if Y > H then
      begin
        if YMode in [1, 4] then
          ComplexRgn.AddRect(X1, 2 * H - Y, X1 + D, H)
        else if YMode in [2, 5] then
          ComplexRgn.AddRect(X1, 0, X1 + D, Y - H);
        ComplexRgn.AddRect(X1 - D, 0, X1, H);
      end
      else
      begin
        if YMode in [1, 5] then
          ComplexRgn.AddRect(X1, H - Y, X1 + D, H)
        else if YMode in [2, 4] then
          ComplexRgn.AddRect(X1, 0, X1 + D, Y)
        else if YMode = 3 then
        begin
          ComplexRgn.AddRect(X1, H - Y, X1 + D, H);
          ComplexRgn.AddRect(X1 + D, 0, X1 + D + D, Y);
        end;
      end;
      Inc(X1, 2 * D);
    end;
    Result := ComplexRgn.CreateRegion;
  finally
    ComplexRgn.Free;
  end;
end;

function CreatePourRgn(X, Y, W, H, XMode, YMode: Integer): HRGN;
var
  X1, Y1, mW, mH, WD, HD, N, R, mR, D: Integer;
  ComplexRegion: TComplexRegion;
begin
  ComplexRegion := TComplexRegion.Create;
  try
    D := (Min(W, H) div 200) + 1;
    WD := W mod D;
    HD := H mod D;
    mW := W div 2;
    mH := H div 2;
    if XMode <> 0 then
    begin
      if X < W then
        N := W div 10
      else
        N := 0;
      Y1 := 0;
      while Y1 < H do
      begin
        R := X + (Random(2 * N) - N);
        if XMode = 1 then
          ComplexRegion.AddRect(W - R, Y1, W, Y1 + D + HD)
        else if XMode = 2 then
          ComplexRegion.AddRect(0, Y1, R, Y1 + D + HD)
        else if XMode = 3 then
        begin
          mR := R div 2;
          ComplexRegion.AddRect(mW - mR, Y1, mW, Y1 + D + HD);
          ComplexRegion.AddRect(mW, Y1, mW + mR, Y1 + D + HD);
        end
        else
        begin
          mR := R div 2;
          ComplexRegion.AddRect(W - mR, Y1, W, Y1 + D + HD);
          ComplexRegion.AddRect(0, Y1, mR, Y1 + D + HD);
        end;
        Inc(Y1, D);
      end;
    end;
    if YMode <> 0 then
    begin
      if Y < H then
        N := H div 10
      else
        N := 0;
      X1 := 0;
      while X1 < W do
      begin
        R := Y + Random(2 * N) - N;
        if YMode = 1 then
          ComplexRegion.AddRect(X1, H - R, X1 + D + WD, H)
        else if YMode = 2 then
          ComplexRegion.AddRect(X1, 0, X1 + D + WD, R)
        else if YMode = 3 then
        begin
          mR := R div 2;
          ComplexRegion.AddRect(X1, mH - mR, X1 + D + WD, mH);
          ComplexRegion.AddRect(X1, mH, X1 + D + WD, mH + mR);
        end
        else
        begin
          mR := R div 2;
          ComplexRegion.AddRect(X1, H - mR, X1 + D + WD, H);
          ComplexRegion.AddRect(X1, 0, X1 + D + WD, mR);
        end;
        Inc(X1, D);
      end;
    end;
    Result := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
end;

function CreateSwarmRgn(X, Y, W, H, XMode, YMode: Integer): HRGN;
var
  X1, Y1, N, M, I, C, L, S: Integer;
  ComplexRegion: TComplexRegion;
begin
  ComplexRegion := TComplexRegion.Create;
  try
    if XMode <> 0 then
    begin
      if X < W then
        N := W div 10
      else
        N := 0;
      M := N div 20;
      if M < 2 then
        M := 2;
      S := M div 2;
      L := N div M;
      C := (3 * N) div (4 * M);
      Y1 := 0;
      while Y1 < H do
      begin
        if XMode = 1 then
        begin
          ComplexRegion.AddRect(W - X, Y1, W, Y1 + M);
          for I := L downto 1 do
            if Random(I) <= Ord(I <= C) then
            begin
              X1 := (W - X) - (I * M);
              ComplexRegion.AddRect(X1, Y1, X1 + M, Y1 + M);
            end;
        end
        else
        begin
          ComplexRegion.AddRect(0, Y1, X, Y1 + M);
          for I := L downto 1 do
            if Random(I) <= Ord(I <= C) then
            begin
              X1 := X + (I * M);
              ComplexRegion.AddRect(X1 - M, Y1, X1, Y1 + M);
            end;
        end;
        Inc(Y1, S);
      end;
    end;
    if YMode <> 0 then
    begin
      if Y < H then
        N := H div 10
      else
        N := 0;
      M := N div 20;
      if M < 2 then
        M := 2;
      S := M div 2;
      L := N div M;
      C := (3 * N) div (4 * M);
      X1 := 0;
      while X1 < W do
      begin
        if YMode = 1 then
        begin
          ComplexRegion.AddRect(X1, H - Y, X1 + M, H);
          for I := L downto 1 do
            if Random(I) <= Ord(I <= C) then
            begin
              Y1 := (H - Y) - (I * M);
              ComplexRegion.AddRect(X1, Y1, X1 + M, Y1 + M);
            end;
        end
        else
        begin
          ComplexRegion.AddRect(X1, 0, X1 + M, Y);
          for I := N div M downto 1 do
            if Random(I) <= Ord(I <= C) then
            begin
              Y1 := Y + (I * M);
              ComplexRegion.AddRect(X1, Y1 - M, X1 + M, Y1);
            end;
        end;
        Inc(X1, S);
      end;
    end;
    Result := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
end;

function CreateSliceRgn(mX, mY, Radius: Integer; StartAngle, EndAngle: Extended;
  NumPts: Integer): HRGN;
var
  Pts, Pt: PPoint;
  Sin, Cos, Delta: Extended;
  I: Integer;
begin
  GetMem(Pts, (NumPts + 1) * SizeOf(TPoint));
  try
    Pt := Pts;
    Pt.X := mX;
    Pt.Y := mY;
    Delta := (EndAngle - StartAngle) / NumPts;
    for I := 1 to NumPts do
    begin
      Inc(Pt);
      SinCos(StartAngle, Sin, Cos);
      Pt.X := mX + Round(Radius * Cos);
      Pt.Y := mY + Round(Radius * Sin);
      StartAngle := StartAngle + Delta;
    end;
    Result := CreatePolygonRgn(Pts^, NumPts + 1, WINDING);
  finally
    FreeMem(Pts);
  end;
end;

function CreatePolygonRgnEx(const Pts: array of Integer): HRGN;
begin
  Result := CreatePolygonRgn(Pts, (High(Pts) - Low(Pts) + 1) shr 1, WINDING);
end;




{ Transition Effects }

// Expand from right
procedure Effect001(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, W - X, 0, X, H,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Expand from left
procedure Effect002(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, 0, X, H,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;



// Book Flip Transition
procedure BookFlipEffectEx(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer; bDrawPageEdge: Boolean);
var
  W, H, X: Integer;
begin
  W := ARect.Right  - ARect.Left;
  H := ARect.Bottom - ARect.Top;

  DestCanvas.Pen.Color := clBlack;
  DestCanvas.Pen.Width := 1;
  DestCanvas.Pen.Style := psSolid;

  // draw the new image on the RHS
  StretchBlt(DestCanvas.Handle, w div 2, 0, w div 2, H,
             NewImage.Canvas.Handle, w div 2, 0, W div 2, H,
             SRCCOPY);

  if Progress <= 50 then
  begin
    X := MulDiv(W, 50 - Progress, 100);

    // Right Hand side
    StretchBlt(DestCanvas.Handle, w div 2, 0, X, H,
               OldImage.Canvas.Handle, w div 2, 0, W div 2, H,
               SRCCOPY);

    if bDrawPageEdge then
    begin
      DestCanvas.MoveTo(w div 2 + X, 0);
      DestCanvas.LineTo(w div 2 + X, H);
    end;
  end
  else
  begin                  
    X := MulDiv(W, Progress - 50, 50) div 2;
                     
    // Left Hand side
    StretchBlt(DestCanvas.Handle, W div 2 - X, 0, X, H,
               NewImage.Canvas.Handle, 0, 0, W div 2, H,
               SRCCOPY);

    if bDrawPageEdge then
    begin
      DestCanvas.MoveTo(W div 2 - X, 0);
      DestCanvas.LineTo(W div 2 - X, H);
    end;
  end;
end;

// Book Flip Transition From Right to Left
procedure ReverseBookFlipEffectEx(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer; bDrawPageEdge: Boolean);
var
  W, H, X: Integer;
begin
  W := ARect.Right  - ARect.Left;
  H := ARect.Bottom - ARect.Top;

  DestCanvas.Pen.Color := clBlack;
  DestCanvas.Pen.Width := 1;
  DestCanvas.Pen.Style := psSolid;

  // draw the new image on the LHS
  StretchBlt(DestCanvas.Handle, 0, 0, w div 2, H,
             NewImage.Canvas.Handle, 0, 0, W div 2, H,
             SRCCOPY);

  if Progress <= 50 then
  begin
    X := MulDiv(W, Progress, 100);

    // Left Hand side
    StretchBlt(DestCanvas.Handle, X, 0, w div 2 - X, H,
               OldImage.Canvas.Handle, 0, 0, W div 2, H,
               SRCCOPY);

    if bDrawPageEdge then
    begin
      DestCanvas.MoveTo(X, 0);
      DestCanvas.LineTo(X, H);
    end;
  end
  else
  begin                  
    X := MulDiv(W, Progress - 50, 50) div 2;

    // Right Hand Side
    StretchBlt(DestCanvas.Handle, W div 2, 0, X, H,
               NewImage.Canvas.Handle, w div 2, 0, W div 2, H,
               SRCCOPY);

    if bDrawPageEdge then
    begin
      DestCanvas.MoveTo(w div 2 + X, 0);
      DestCanvas.LineTo(w div 2 + X, H);
    end;
  end;
end;

procedure BookFlipEffect_NoEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  BookFlipEffectEx(DestCanvas, OldImage, NewImage, ARect, Step, Progress, False);
end;

procedure BookFlipEffect_WithEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  BookFlipEffectEx(DestCanvas, OldImage, NewImage, ARect, Step, Progress, True);
end;


procedure ReverseBookFlipEffect_NoEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  ReverseBookFlipEffectEx(DestCanvas, OldImage, NewImage, ARect, Step, Progress, False);
end;

procedure ReverseBookFlipEffect_WithEdge(DestCanvas:TCanvas; OldImage, NewImage: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  ReverseBookFlipEffectEx(DestCanvas, OldImage, NewImage, ARect, Step, Progress, True);
end;

// Slide in from right
procedure Effect003(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, W - X, 0, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;

// Slide in from left
procedure Effect004(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, X - W, 0, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;

// Reveal from left      
{ Just like iettLeftRight1
procedure Effect005(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, 0, X, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;   }

// Reveal from right   
{ Just like iettRightLeft1
procedure Effect006(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, W - X, 0, X, H,
         Image.Canvas.Handle, W - X, 0,
         SRCCOPY);
end;    }

// Expand in from right
procedure Effect007(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, 0, (2 * W) - X, H,
             Image.Canvas.Handle, 0, 0, X, H,
             SRCCOPY);
end;

// Expand in from left
procedure Effect008(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, X - W, 0, (2 * W) - X, H,
             Image.Canvas.Handle, W - X, 0, X, H,
             SRCCOPY);
end;

// Expand in to middle
procedure Effect009(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, X - W, 0, (3 * W) - (2 * X), H,
             Image.Canvas.Handle, (W - X) div 2, 0, X, H,
             SRCCOPY);
end;

// Expand out from middle
procedure Effect010(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, (W - X) div 2, 0, X, H,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Reveal out from middle
procedure Effect011(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mWX: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mWX := (W - X) div 2;
  BitBlt(DestCanvas.Handle, mWX, 0, X, H,
         Image.Canvas.Handle, mWX, 0,
         SRCCOPY);
end;

// Reveal in from sides
procedure Effect012(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := X div 2;
  BitBlt(DestCanvas.Handle, 0, 0, mX, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, W - mX, 0, mX, H,
         Image.Canvas.Handle, W - mX, 0,
         SRCCOPY);
end;

// Expand in from sides
procedure Effect013(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX, mW: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := X div 2;
  mW := W div 2;
  StretchBlt(DestCanvas.Handle, 0, 0, mX, H,
             Image.Canvas.Handle, 0, 0, mW, H,
             SRCCOPY);
  StretchBlt(DestCanvas.Handle, W - mX, 0, mX, H,
             Image.Canvas.Handle, mW, 0, mW, H,
             SRCCOPY);
end;

// Unroll from left  
// 24bit verson
procedure Effect014(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect;
  Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
  R1, R2: TRect;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  R1 := ARect;
  R2 := ARect;
  R1.Left := X;
  if R1.Left < W div 5 then
   R1.Right := R1.Left + X div 2
  else if (R1.Left + W div 5) > W then
   R1.Right := R1.Left + (W - X) div 2
  else
   R1.Right := R1.Left + W div 10;
  R2.Left := R1.Right;
  R2.Right := R2.Left + R1.Right - R1.Left;
  MirrorCopyRect(DestCanvas, R1, Image, R2, True, False);
  R1.Left := 0;
  R1.Right := X;
  R2.Left := 0;
  R2.Right := X;
  DestCanvas.CopyRect(R1, Image.Canvas, R2);
end;

// Unroll from right
// 24bit verson
procedure Effect015(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect;
  Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
  R1, R2: TRect;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  R1 := ARect;
  R2 := ARect;
  R1.Right := W - X;
  if (R1.Right + W div 5) > W then
   R1.Left := R1.Right - X div 2
  else if R1.Right < W div 5 then
   R1.Left := R1.Right - (W - X) div 2
  else
   R1.Left := R1.Right - W div 10;
  R2.Right := R1.Left;
  R2.Left := R2.Right - R1.Right + R1.Left;
  MirrorCopyRect(DestCanvas, R1, Image, R2, True, False);
  R1.Left := W - X;
  R1.Right := W;
  R2.Left := W - X;
  R2.Right := W;
  DestCanvas.CopyRect(R1, Image.Canvas, R2);
end;


// Build up from right
procedure Effect016(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  N: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, 0, X, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
  N := Min(W - X, W div 10);
  StretchBlt(DestCanvas.Handle, X, 0, W - X, H,
             Image.Canvas.Handle, X, 0, N, H,
             SRCCOPY);
end;

// Build up from left
procedure Effect017(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  N: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, W - X, 0, X, H,
         Image.Canvas.Handle, W - X, 0,
         SRCCOPY);
  N := Max((W - X) - (W div 10), 0);
  StretchBlt(DestCanvas.Handle, 0, 0, W - X, H,
             Image.Canvas.Handle, N, 0, W - X - N, H,
             SRCCOPY);
end;

// Expand from bottom
procedure Effect018(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, H - Y, W, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Expand from top
procedure Effect019(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, 0, W, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Slide in from bottom
procedure Effect020(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, H - Y, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;

// Slide in from top
procedure Effect021(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, Y - H, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;

// Reveal from top  
{ Just like iettDownUp1
procedure Effect022(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, 0, W, Y,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;   }

// Reveal from bottom    
{ Just like iettUpDown1
procedure Effect023(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, H - Y, W, Y,
         Image.Canvas.Handle, 0, H - Y,
         SRCCOPY);
end; }

// Expand in from bottom
procedure Effect024(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, 0, W, (2 * H) - Y,
             Image.Canvas.Handle, 0, 0, W, Y,
             SRCCOPY);
end;

// Expand in from top
procedure Effect025(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, Y - H, W, (2 * H) - Y,
             Image.Canvas.Handle, 0, H - Y, W, Y,
             SRCCOPY);
end;

// Expand in to middle (horiz)
procedure Effect026(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, Y - H, W, (3 * H) - (2 * Y),
             Image.Canvas.Handle, 0, (H - Y) div 2, W, Y,
             SRCCOPY);
end;

// Expand out from middle (horiz)
procedure Effect027(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, (H - Y) div 2, W, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Reveal from middle (horiz)
procedure Effect028(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mHY: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mHY := (H - Y) div 2;
  BitBlt(DestCanvas.Handle, 0, mHY, W, Y,
         Image.Canvas.Handle, 0, mHY,
         SRCCOPY);
end;

// Slide in from top / bottom
procedure Effect029(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mY: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mY := Y div 2;
  BitBlt(DestCanvas.Handle, 0, 0, W, mY,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, 0, H - mY, W, mY,
         Image.Canvas.Handle, 0, H - mY,
         SRCCOPY);
end;

// Expand in from top / bottom
procedure Effect030(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mY, mH: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mY := Y div 2;
  mH := H div 2;
  StretchBlt(DestCanvas.Handle, 0, 0, W, mY,
             Image.Canvas.Handle, 0, 0, W, mH,
             SRCCOPY);
  StretchBlt(DestCanvas.Handle, 0, H - mY, W, mY,
             Image.Canvas.Handle, 0, mH, W, mH,
             SRCCOPY);
end;

// Unroll from top     
// 24bit verson
procedure Effect031(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect;
  Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
  R1, R2: TRect;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  R1 := ARect;
  R2 := ARect;
  R1.Top := Y;
  if R1.Top < H div 5 then
   R1.Bottom := R1.Top + Y div 2
  else if (R1.Top + H div 5) > H then
   R1.Bottom := R1.Top + (H - Y) div 2
  else
   R1.Bottom := R1.Top + H div 10;
  R2.Top := R1.Bottom;
  R2.Bottom := R2.Top + R1.Bottom - R1.Top;
  MirrorCopyRect(DestCanvas, R1, Image, R2, False, True);
  R1.Top := 0;
  R1.Bottom := Y;
  R2.Top := 0;
  R2.Bottom := Y;
  DestCanvas.CopyRect(R1, Image.Canvas, R2);
end;



// Unroll from bottom    
// 24bit verson
procedure Effect032(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect;
  Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
  R1, R2: TRect;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  R1 := ARect;
  R2 := ARect;
  R1.Bottom := H - Y;
  if (R1.Bottom + H div 5) > H then
   R1.Top := R1.Bottom - Y div 2
  else if R1.Bottom < H div 5 then
   R1.Top := R1.Bottom - (H - Y) div 2
  else
   R1.Top := R1.Bottom - H div 10;
  R2.Bottom := R1.Top;
  R2.Top := R2.Bottom - R1.Bottom + R1.Top;
  MirrorCopyRect(DestCanvas, R1, Image, R2, False, True);
  R1.Top := H - Y;
  R1.Bottom := H;
  R2.Top := H - Y;
  R2.Bottom := H;
  DestCanvas.CopyRect(R1, Image.Canvas, R2);
end;

// Expand from bottom
procedure Effect033(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  N: Integer;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, 0, W, Y,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
  N := Min(H - Y, H div 10);
  StretchBlt(DestCanvas.Handle, 0, Y, W, H - Y,
             Image.Canvas.Handle, 0, Y, W, N,
             SRCCOPY);
end;

// Expand in from top
procedure Effect034(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  N: Integer;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, H - Y, W, Y,
         Image.Canvas.Handle, 0, H - Y,
         SRCCOPY);
  N := Max((H - Y) - H div 10, 0);
  StretchBlt(DestCanvas.Handle, 0, 0, W, H - Y,
             Image.Canvas.Handle, 0, N, W, H - Y - N,
             SRCCOPY);
end;

// Expand from bottom right
procedure Effect035(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, W - X, H - Y, X, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Expand from top right
procedure Effect036(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, W - X, 0, X, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Expand from top left
procedure Effect037(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, 0, X, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Expand from bottom left
procedure Effect038(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, H - Y, X, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end;

// Slide in from bottom right   
{ Just like iettFromBottomRight
procedure Effect039(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, W - X, H - Y, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;
}

// Slide in from top right 
{ Just like iettFromUpRight
procedure Effect040(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, W - X, Y - H, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;
}

// Slide in from top left  
{ Just like iettFromUpLeft
procedure Effect041(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, X - W, Y - H, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;   
}

// Slide in from bottom left   
{ Just like iettFromBottomLeft
procedure Effect042(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, X - W, H - Y, W, H,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;   
}

// Reveal from top left
procedure Effect043(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, 0, X, Y,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
end;

// Reveal from bottom left
procedure Effect044(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, 0, H - Y, X, Y,
         Image.Canvas.Handle, 0, H - Y,
         SRCCOPY);
end;

// Reveal from bottom right
procedure Effect045(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, W - X, H - Y, X, Y,
         Image.Canvas.Handle, W - X, H - Y,
         SRCCOPY);
end;

// Reveal from top right
procedure Effect046(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, W - X, 0, X, Y,
         Image.Canvas.Handle, W - X, 0,
         SRCCOPY);
end;

// Appear and Contract to top left
procedure Effect047(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, 0, (2 * W) - X, (2 * H) - Y,
             Image.Canvas.Handle, 0, 0, X, Y,
             SRCCOPY);
end;

// Appear and Contract to bottom left
procedure Effect048(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, 0, Y - H, (2 * W) - X, (2 * H) - Y,
             Image.Canvas.Handle, 0, H - Y, X, Y,
             SRCCOPY);
end;

// Appear and Contract to bottom right
procedure Effect049(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, X - W, Y - H, (2 * W) - X, (2 * H) - Y,
             Image.Canvas.Handle, W - X, H - Y, X, Y,
             SRCCOPY);
end;

// Appear and Contract to top right
procedure Effect050(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, X - W, 0, (2 * W) - X, (2 * H) - Y,
             Image.Canvas.Handle, W - X, 0, X, Y,
             SRCCOPY);
end;

// Appear and Contract to middle
procedure Effect051(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, X - W, Y - H, (3 * W) - (2 * X), (3 * H) - (2 * Y),
             Image.Canvas.Handle, (W - X) div 2, (H - Y) div 2, X, Y,
             SRCCOPY);
end;

// Expand out from centre 
{ Just like iettCenterZoom1
procedure Effect052(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  StretchBlt(DestCanvas.Handle, (W - X) div 2, (H - Y) div 2, X, Y,
             Image.Canvas.Handle, 0, 0, W, H,
             SRCCOPY);
end; 
}

// Reveal out from centre   
{ Just like iettCenter1
procedure Effect053(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  BitBlt(DestCanvas.Handle, (W - X) div 2, (H - Y) div 2, X, Y,
         Image.Canvas.Handle, (W - X) div 2, (H - Y) div 2,
         SRCCOPY);
end;  
}

// Reveal in to centre
{ Just like iettCenter2
procedure Effect054(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX, mY: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := X div 2;
  mY := Y div 2;
  with DestCanvas do
  begin
    ExcludeClipRect(Handle, mX, mY, W - mX, H - mY);
    try
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
    finally
      SelectClipRgn(Handle, 0);
    end;
  end;
end;      
}

// Quarters Reveal in to middle
procedure Effect055(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX, mY: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := X div 2;
  mY := Y div 2;
  BitBlt(DestCanvas.Handle, 0, 0, mX, mY,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, 0, H - mY, mX, mY,
         Image.Canvas.Handle, 0, H - mY,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, W - mX, H - mY, mX, mY,
         Image.Canvas.Handle, W - mX, H - mY,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, W - mX, 0, mX, mY,
         Image.Canvas.Handle, W - mX, 0,
         SRCCOPY);
end;

// Quarters Expand to middle
procedure Effect056(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX, mY, mW, mH: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := X div 2;
  mY := Y div 2;
  mW := W div 2;
  mH := H div 2;
  StretchBlt(DestCanvas.Handle, 0, 0, mX, mY,
             Image.Canvas.Handle, 0, 0, mW, mH,
             SRCCOPY);
  StretchBlt(DestCanvas.Handle, 0, H - mY, mX, mY,
             Image.Canvas.Handle, 0, mH, mW, mH,
             SRCCOPY);
  StretchBlt(DestCanvas.Handle, W - mX, H - mY, mX, mY,
             Image.Canvas.Handle, mW, mH, mW, mH,
             SRCCOPY);
  StretchBlt(DestCanvas.Handle, W - mX, 0, mX, mY,
             Image.Canvas.Handle, mW, 0, mW, mH,
             SRCCOPY);
end;

// Quarters Slide in to middle
procedure Effect057(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX, mY, mW, mH: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := X div 2;
  mY := Y div 2;
  mW := W div 2;
  mH := H div 2;
  BitBlt(DestCanvas.Handle, mX - mW, 0, mW, mH,
         Image.Canvas.Handle, 0, 0,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, mW, mY - mH, mW, mH,
         Image.Canvas.Handle, mW, 0,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, W - mX, mH, mW, mH,
         Image.Canvas.Handle, mW, mH,
         SRCCOPY);
  BitBlt(DestCanvas.Handle, 0, H - mY, mW, mH,
         Image.Canvas.Handle, 0, mH,
         SRCCOPY);
end;

// Curved Reveal from left
procedure Effect058(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(-2 * W, 0, 2 * X, H + 1, 2 * W, 2 * W);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Curved Reveal from right
procedure Effect059(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(W - 2 * X, 0, 3 * W, H + 1, 2 * W, 2 * W);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars in from right
procedure Effect060(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 0, W, H, 1, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars in from left
procedure Effect061(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 0, W, H, 2, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars left then right
procedure Effect062(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 0, W, H, 4, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars right then left
procedure Effect063(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 0, W, H, 5, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars from both sides
procedure Effect064(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(X, 0, W, H, 3, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from right
procedure Effect065(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, 0, W, H, 1, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from left
procedure Effect066(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, 0, W, H, 2, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred out from middle (horiz)
procedure Effect067(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, 0, W, H, 3, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred in to middle (horiz)
procedure Effect068(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, 0, W, H, 4, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Curved Reveal from top
procedure Effect069(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(0, -2 * H, W + 1, 2 * Y, 2 * H, 2 * H);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Curved Reveal from bottom
procedure Effect070(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(0, H - 2 * Y, W + 1, 3 * H, 2 * H, 2 * H);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars from bottom
procedure Effect071(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(0, 2 * Y, W, H, 0, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars from top
procedure Effect072(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(0, 2 * Y, W, H, 0, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars top then bottom
procedure Effect073(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(0, 2 * Y, W, H, 0, 4);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars bottom then top
procedure Effect074(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(0, 2 * Y, W, H, 0, 5);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bars from top and bottom
procedure Effect075(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(0, Y, W, H, 0, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Unven shred from bottom
procedure Effect076(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(0, Y, W, H, 0, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from top
procedure Effect077(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(0, Y, W, H, 0, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from horizon
procedure Effect078(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(0, Y, W, H, 0, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred in to horizon
procedure Effect079(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(0, Y, W, H, 0, 4);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Curved reveal from top left
procedure Effect080(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(-W, -H, 3 * X div 2, 3 * Y div 2, 2 * W, 2 * H);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Curved reveal from top right
procedure Effect081(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(W - 3 * X div 2, -H, 2 * W, 3 * Y div 2, 2 * W, 2 * H);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Curved reveal from bottom left
procedure Effect082(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(-W, H - 3 * Y div 2, 3 * X div 2, 2 * H, 2 * W, 2 * H);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Curved reveal from bottom right
procedure Effect083(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateRoundRectRgn(W - 3 * X div 2, H - 3 * Y div 2, 2 * W, 2 * H, 2 * W, 2 * H);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

const
  Circular_Shape = -1;  
  Diamond_Shape  = -1;

procedure _PerformWipeEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Progress: Integer; AShape: TXCustomShape; bReverse: Boolean; rScale: Single = 1);
var
  mW, mH: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
  iScaledX, iScaledY: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y); 

  mW := W div 2;
  mH := H div 2;

  if bReverse then
  begin
    Rgn := CreateRectRgn(0, 0, W, H);
    if rScale <> 1 then
    begin
      iScaledX := Round(rScale * (W - X)) div 2;
      iScaledY := Round(rScale * (H - Y)) div 2;
      TmpRgn := CreateCustomShape(AShape, Rect(X - mW - iScaledX, Y - mH - iScaledY, 3 * mW - X + iScaledX, 3 * mH - Y + iScaledY))
    end
    else
    if ord(AShape) <> Circular_Shape then
      TmpRgn := CreateCustomShape(AShape, Rect(X - mW, Y - mH, 3 * mW - X, 3 * mH - Y))
    else
      TmpRgn := CreateRoundRectRgn(X - mW, Y - mH, 3 * mW - X, 3 * mH - Y, 9 * (W - X) div 5, 9 * (H - Y) div 5);
    CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
    DeleteObject(TmpRgn)
  end
  else
  begin
    if rScale <> 1 then
    begin
      iScaledX := Round(rScale * X);
      iScaledY := Round(rScale * Y);
      Rgn := CreateCustomShape(AShape, Rect(mW - iScaledX, mH - iScaledY, mW + iScaledX, mH + iScaledY))
    end
    else
    if ord(AShape) <> Circular_Shape then
      Rgn := CreateCustomShape(AShape, Rect(mW - X, mH - Y, mW + X, mH + Y))
    else
      Rgn := CreateRoundRectRgn(mW - X, mH - Y, mW + X, mH + Y, 9 * X div 5, 9 * Y div 5);
  end;

  try
    with DestCanvas do
    begin
      if AShape = xcsCross then
        BitBlt(Handle, 0, 0, W, H, Screen.Canvas.Handle, 0, 0, SRCCOPY);

      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;



// Circular Wipe from Center
procedure Effect084(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, TXCustomShape(Circular_Shape), False);
end;

// Circular Wipe to Center
procedure Effect085(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, TXCustomShape(Circular_Shape), True);
end;




// Heart Wipe from Center
procedure HeartWipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsHeart, False, 1.3);
end;

// Heart Wipe to Center
procedure HeartWipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsHeart, True, 1.3);
end;



// 5 Point Star Wipe from Center
procedure Star5WipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsStar5, False, 1.6);
end;

// 5 Point Star Wipe to Center
procedure Star5WipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsStar5, True, 1.6);
end;


// 6 Point Star Wipe from Center
procedure Star6WipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsStar6, False, 1.3);
end;

// 6 Point Star Wipe to Center
procedure Star6WipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsStar6, True, 1.3);
end;

// Explosion Wipe from Center
procedure ExplosionWipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsExplosion, False);
end;

// Explosion Wipe to Center
procedure ExplosionWipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsExplosion, True);
end;


// Cross Wipe from Center
procedure CrossWipeOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsCross, False, 3.6);
end;

// Cross Wipe to Center
procedure CrossWipeInEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformWipeEffect(DestCanvas, Screen, Image, ARect, Progress, xcsCross, True, 3.5);
end;



// Criss Cross reveal from bottom right
procedure Effect086(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 1, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from top right
procedure Effect087(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 1, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from bottom left
procedure Effect088(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 2, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from top left
procedure Effect089(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 2, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal bounce from top left
procedure Effect090(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 4, 4);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal bounce from bottom left
procedure Effect091(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 4, 5);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal bounce from top right
procedure Effect092(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 5, 4);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal bounce from bottom right
procedure Effect093(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 5, 5);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from right top and bottom
procedure Effect094(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(X, Y, W, H, 1, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from left top and bottom
procedure Effect095(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(X, Y, W, H, 2, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from left right and bottom
procedure Effect096(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(X, Y, W, H, 3, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from left right and top
procedure Effect097(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(X, Y, W, H, 3, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from top left right and bottom
procedure Effect098(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(X, Y, W, H, 3, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Criss Cross reveal from bottom left top right
procedure Effect099(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateBarRgn(2 * X, 2 * Y, W, H, 1, 1);
  TmpRgn := CreateBarRgn(2 * X, 2 * Y, W, H, 2, 2);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_AND);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from bottom and right
procedure Effect100(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 1, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from top and right
procedure Effect101(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 1, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from bottom and left
procedure Effect102(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 2, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from top and left
procedure Effect103(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 2, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from horiz and right
procedure Effect104(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 1, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from horiz and left
procedure Effect105(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 2, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from bottom and vert middle
procedure Effect106(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 3, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from top and vert middle
procedure Effect107(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 3, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred from centre
procedure Effect108(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 3, 3);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Uneven shred to centre
procedure Effect109(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePourRgn(X, Y, W, H, 4, 4);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal diagonal from top left
procedure Effect110(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePolygonRgnEx([0, 0, 2 * X, 0, 0, 2 * Y]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal diagonal from top right
procedure Effect111(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePolygonRgnEx([W, 0, W - 2 * X, 0, W, 2 * Y]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal diagonal from bottom left
procedure Effect112(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePolygonRgnEx([0, H, 2 * X, H, 0, H - 2 * Y]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal diagonal from bottom right
procedure Effect113(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePolygonRgnEx([W, H, W - 2 * X, H, W, H - 2 * Y]);
  SelectClipRgn(DestCanvas.Handle, Rgn);
  DeleteObject(Rgn);
  DestCanvas.Draw(0, 0, Image);
  SelectClipRgn(DestCanvas.Handle, 0);
end;

// Diagonal sweep from top left bottom right anticlockwise
procedure Effect114(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn, TmpRgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePolygonRgnEx([0, H, 0, 0, X, H]);
  TmpRgn := CreatePolygonRgnEx([W, H, W, 0, W - X, 0]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Diagonal sweep from top left bottom right clockwise
procedure Effect115(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn, TmpRgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreatePolygonRgnEx([W, 0, 0, 0, W, Y]);
  TmpRgn := CreatePolygonRgnEx([W, H, 0, H, 0, H - Y]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Starburst clockwise from center
procedure Effect116(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mH: Integer;
  Rgn, TmpRgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  Rgn := CreatePolygonRgnEx([mW, mH, 0, 0, X, 0]);
  TmpRgn := CreatePolygonRgnEx([mW, mH, 0, H, 0, H - Y]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW, mH, W, H, W - X, H]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW, mH, W, 0, W, Y]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Starburst anticlockwise from center
procedure Effect117(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mH: Integer;
  Rgn, TmpRgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  Rgn := CreatePolygonRgnEx([mW, mH, 0, 0, 0, Y]);
  TmpRgn := CreatePolygonRgnEx([mW, mH, 0, H, X, H]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW, mH, W, H, W, H - Y]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW, mH, W, 0, W - X, 0]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Triangular shred
procedure Effect118(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  sW, sH, dW, dH: Integer;
  Rgn, TmpRgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  sW := (W div 10) + 1;
  sH := (H div 10) + 1;
  dW := MulDiv(sW, Progress, 50);
  dH := MulDiv(sH, Progress, 50);
  Rgn := 0;
  X := 0;
  while X < W do
  begin
    Inc(X, sW);
    Y := 0;
    while Y < H + sH do
    begin
      Inc(Y, sH);
      TmpRgn := CreatePolygonRgnEx([X - dW, Y - dH, X, Y + dH, X + dW, Y - dH]);
      if Rgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);
      end
      else
        Rgn := TmpRgn;
      Inc(Y, sH);
    end;
    Inc(X, sW);
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Fade                      
{ Just like iettCrossDissolve
procedure Effect119(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  dstPixel, srcPixel: PRGBQuad;
  Weight: Integer;
  I: Integer;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  srcPixel := Image.ScanLine[H - 1];
  dstPixel := Display.ScanLine[H - 1];
  Weight := MulDiv(256, Progress, 100);
  for I := (W * H) - 1 downto 0 do
  begin
    with dstPixel^ do
    begin
      Inc(rgbRed, (Weight * (srcPixel^.rgbRed - rgbRed)) shr 8);
      Inc(rgbGreen, (Weight * (srcPixel^.rgbGreen - rgbGreen)) shr 8);
      Inc(rgbBlue, (Weight * (srcPixel^.rgbBlue - rgbBlue)) shr 8);
    end;
    Inc(srcPixel);
    Inc(dstPixel);
  end;
end;    }

// Pivot from top left       
{ Requires a 32 bit palette
procedure Effect120(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  MergeRotate(Display, Image, -1, -1, (100 - Progress) * PI / 200);
end; }

// Pivot from bottom left  
{ Requires a 32 bit palette
procedure Effect121(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  MergeRotate(Display, Image, -1, H, (Progress - 100) * PI / 200);
end;  }

// Pivot from top right   
{ Requires a 32 bit palette
procedure Effect122(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  MergeRotate(Display, Image, W, -1, (Progress - 100) * PI / 200);
end;   }

// Pivot from bottom right 
{ Requires a 32 bit palette
procedure Effect123(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  MergeRotate(Display, Image, W, H, (100 - Progress) * PI / 200);
end; }

// Speckle appear from right
procedure Effect124(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateSwarmRgn(X, Y, W, H, 1, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Speckle appear from left
procedure Effect125(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateSwarmRgn(X, Y, W, H, 2, 0);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Speckle appear from bottom
procedure Effect126(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateSwarmRgn(X, Y, W, H, 0, 1);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Speckle appear from top
procedure Effect127(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  Rgn := CreateSwarmRgn(X, Y, W, H, 0, 2);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Random squares appear  
{ Just like iettRandomBoxes
procedure Effect128(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, SavedRandSeed: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SavedRandSeed := RandSeed;
  RandSeed := Integer(Image.Handle);
  S := (Min(W, H) div 50) + 1;
  ComplexRegion := TComplexRegion.Create;
  try
    X := 0;
    while X < W do
    begin
      Inc(X, S);
      Y := 0;
      while Y < H do
      begin
        Inc(Y, S);
        if Random(100) < Progress then
          ComplexRegion.AddRect(X - S, Y - S, X + S, Y + S);
        Inc(Y, S);
      end;
      Inc(X, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
    RandSeed := SavedRandSeed;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end; }

// Push right
procedure Effect129(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    BitBlt(Handle, X, 0, W - X, H,
           Handle, 0, 0,
           SRCCOPY);
    BitBlt(Handle, 0, 0, X, H,
           Image.Canvas.Handle, W - X, 0,
           SRCCOPY);
  end;
end;

// Push left
procedure Effect130(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    BitBlt(Handle, 0, 0, W - X, H,
           Handle, X, 0,
           SRCCOPY);
    BitBlt(Handle, W - X, 0, X, H,
           Image.Canvas.Handle, 0, 0,
           SRCCOPY);
  end;
end;

// Push and squeeze right
procedure Effect131(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    StretchBlt(Handle, X, 0, W - X, H, Handle, 0, 0, W, H, SRCCOPY);
    BitBlt(Handle, 0, 0, X, H, Image.Canvas.Handle, W - X, 0, SRCCOPY);
  end;
end;

// Push and squeeze left
procedure Effect132(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    StretchBlt(Handle, 0, 0, W - X, H, Handle, 0, 0, W, H, SRCCOPY);
    BitBlt(Handle, W - X, 0, X, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;

// Push down
procedure Effect133(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    BitBlt(Handle, 0, Y, W, H - Y, Handle, 0, 0, SRCCOPY);
    BitBlt(Handle, 0, 0, W, Y, Image.Canvas.Handle, 0, H - Y, SRCCOPY);
  end;
end;

// Push up
procedure Effect134(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    BitBlt(Handle, 0, 0, W, H - Y, Handle, 0, Y, SRCCOPY);
    BitBlt(Handle, 0, H - Y, W, Y, Image.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;

// Push and sqeeze down
procedure Effect135(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    StretchBlt(Handle, 0, Y, W, H - Y, Handle, 0, 0, W, H, SRCCOPY);
    BitBlt(Handle, 0, 0, W, Y, Image.Canvas.Handle, 0, H - Y, SRCCOPY);
  end;
end;

// Push and sqeeze up
procedure Effect136(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  with DestCanvas do
  begin
    StretchBlt(Handle, 0, 0, W, H - Y, Handle, 0, 0, W, H, SRCCOPY);
    BitBlt(Handle, 0, H - Y, W, Y, Image.Canvas.Handle, 0, 0, SRCCOPY);
  end;
end;

// Blind vertically
procedure Effect137(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  S := (W div 40) + 1;
  D := MulDiv(S, Progress, 100);
  ComplexRegion := TComplexRegion.Create;
  try
    X := 0;
    while X < W do
    begin
      Inc(X, S);
      ComplexRegion.AddRect(X - D, 0, X + D, H);
      Inc(X, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Blind horizontally
procedure Effect138(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  S := (H div 40) + 1;
  D := MulDiv(S, Progress, 100);
  ComplexRegion := TComplexRegion.Create;
  try
    Y := 0;
    while Y < H do
    begin
      Inc(Y, S);
      ComplexRegion.AddRect(0, Y - D, W, Y + D);
      Inc(Y, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;



// Uneven blind from left
procedure Effect139(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  if X = 0 then Exit;
  S := X;
  D := MulDiv(S, Progress, 100);
  ComplexRegion := TComplexRegion.Create;
  try
    X := 0;
    while X < W do
    begin
      ComplexRegion.AddRect(X, 0, X + D, H);
      Inc(X, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Uneven blind from right
procedure Effect140(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  if X = 0 then Exit;
  S := X;
  D := MulDiv(S, Progress, 100);
  ComplexRegion := TComplexRegion.Create;
  try
    X := W;
    while X > 0 do
    begin
      ComplexRegion.AddRect(X - D, 0, X, H);
      Dec(X, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Uneven blind from top
procedure Effect141(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  if Y = 0 then Exit;
  S := Y;
  D := MulDiv(S, Progress, 100);
  ComplexRegion := TComplexRegion.Create;
  try
    Y := 0;
    while Y < H do
    begin
      ComplexRegion.AddRect(0, Y, W, Y + D);
      Inc(Y, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Uneven blind from bottom
procedure Effect142(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  if Y = 0 then Exit;
  S := Y;
  D := MulDiv(S, Progress, 100);
  ComplexRegion := TComplexRegion.Create;
  try
    Y := H;
    while Y > 0 do
    begin
      ComplexRegion.AddRect(0, Y - D, W, Y);
      Dec(Y, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;




// Rectangular shred
procedure Effect143(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  S := (Min(W, H) div 10) + 1;
  D := MulDiv(S, Progress, 100);
  ComplexRegion := TComplexRegion.Create;
  try
    X := 0;
    while X < W do
    begin
      Inc(X, S);
      Y := 0;
      while Y < H do
      begin
        Inc(Y, S);
        ComplexRegion.AddRect(X - D, Y - D, X + D, Y + D);
        Inc(Y, S);
      end;
      Inc(X, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Sweep clockwise
procedure Effect144(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX, mY: Integer;
  mPI: Extended;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := W div 2;
  mY := H div 2;
  mPI := PI / 2;
  Rgn := CreateSliceRgn(mX, mY, Ceil(Hypot(mX, mY)),
    -mPI, (PI * Progress / 50) - mPI, Progress);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Sweep anticlockwise
procedure Effect145(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mX, mY: Integer;
  mPI: Extended;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mX := W div 2;
  mY := H div 2;
  mPI := PI / 2;
  Rgn := CreateSliceRgn(mX, mY, Ceil(Hypot(mX, mY)), -mPI, (-PI * Progress / 50) - mPI, Progress);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;



// Rectangles apear from left and disapear to right
procedure Effect146(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  SW, SH, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SW := X;
  SH := H div 20;
  if (SW = 0) or (SH = 0) then Exit;
  ComplexRegion := TComplexRegion.Create;
  try
    D := MulDiv(SH, Progress, 100);
    Y := -SH;
    while Y < H do
    begin
      ComplexRegion.AddRect(0, Y - D, W, Y + D);
      Inc(Y, 3 * SH);
    end;
    D := MulDiv(SW, Progress, 100);
    X := 0;
    while X < W do
    begin
      ComplexRegion.AddRect(X, 0, X + D, H);
      Inc(X, SW);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Rectangles apear from right and disapear to left
procedure Effect147(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  SW, SH, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SW := X;
  SH := H div 20;
  if (SW = 0) or (SH = 0) then Exit;
  ComplexRegion := TComplexRegion.Create;
  try
    D := MulDiv(SH, Progress, 100);
    Y := -SH;
    while Y < H do
    begin
      ComplexRegion.AddRect(0, Y - D, W, Y + D);
      Inc(Y, 3 * SH);
    end;
    D := MulDiv(SW, Progress, 100);
    X := W;
    while X > 0 do
    begin
      ComplexRegion.AddRect(X - D, 0, X, H);
      Dec(X, SW);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Rectangles apear from up and disapear to bottom
procedure Effect148(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  SW, SH, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SW := W div 20;
  SH := Y;
  if (SW = 0) or (SH = 0) then Exit;
  ComplexRegion := TComplexRegion.Create;
  try
    D := MulDiv(SW, Progress, 100);
    X := -SW;
    while X < W do
    begin
      ComplexRegion.AddRect(X - D, 0, X + D, H);
      Inc(X, 3 * SW);
    end;
    D := MulDiv(SH, Progress, 100);
    Y := 0;
    while Y < H do
    begin
      ComplexRegion.AddRect(0, Y, W, Y + D);
      Inc(Y, SH);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Rectangles apear from bottom and disapear to up
procedure Effect149(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  SW, SH, D: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SW := W div 20;
  SH := Y;
  if (SW = 0) or (SH = 0) then Exit;
  ComplexRegion := TComplexRegion.Create;
  try
    D := MulDiv(SW, Progress, 100);
    X := -SW;
    while X < W do
    begin
      ComplexRegion.AddRect(X - D, 0, X + D, H);
      Inc(X, 3 * SW);
    end;
    D := MulDiv(SH, Progress, 100);
    Y := H;
    while Y > 0 do
    begin
      ComplexRegion.AddRect(0, Y - D, W, Y);
      Dec(Y, SH);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

      
procedure RotationalRectangleEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer;
                                    bClockwise: Boolean);
var
  mW, mH, mX, mY: Integer;
  Pts: array[1..4] of TPoint;
  Angle: Extended;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  mX := X div 2;
  mY := Y div 2;
  Pts[1].X := mW - mX;
  Pts[1].Y := mH - mY;
  Pts[2].X := mW + mX;
  Pts[2].Y := mH - mY;
  Pts[3].X := mW + mX;
  Pts[3].Y := mH + mY;
  Pts[4].X := mW - mX;
  Pts[4].Y := mH + mY;
  Angle := PI * Progress / 50;
  if bClockwise = False then
    Angle := -Angle;
  RotatePoints(Pts, mW, mH, Angle);
  Rgn := CreatePolygonRgn(Pts, 4, WINDING);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;



// Rotational rectangle in center - clockwise
procedure Effect150(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  RotationalRectangleEffect(DestCanvas, Screen, Image, ARect, Step, Progress, True);
end;

// Rotational rectangle in center - counter-clockwise
procedure Effect150B(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  RotationalRectangleEffect(DestCanvas, Screen, Image, ARect, Step, Progress, False);
end;


// Rotational star in center
procedure RotationalStarEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer;
                               bClockwise: Boolean);
var
  mW, mH, mX, mY, dX, dY: Integer;
  Pts: array[1..8] of TPoint;
  Angle: Extended;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  mX := X div 2;
  mY := Y div 2;
  dX := 2 * X;
  dY := 2 * Y;
  Pts[1].X := mW - dX;
  Pts[1].Y := mH;
  Pts[2].X := mW - mX;
  Pts[2].Y := mH - mY;
  Pts[3].X := mW;
  Pts[3].Y := mH - dY;
  Pts[4].X := mW + mX;
  Pts[4].Y := mH - mY;
  Pts[5].X := mW + dX;
  Pts[5].Y := mH;
  Pts[6].X := mW + mX;
  Pts[6].Y := mH + mY;
  Pts[7].X := mW;
  Pts[7].Y := mH + dY;
  Pts[8].X := mW - mX;
  Pts[8].Y := mH + mY;
  Angle := PI * Progress / 50;
  if bClockwise = False then
    Angle := -Angle;
  RotatePoints(Pts, mW, mH, Angle);
  Rgn := CreatePolygonRgn(Pts, 8, WINDING);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;


// Rotational star in center - clockwise
procedure Effect151(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  RotationalStarEffect(DestCanvas, Screen, Image, ARect, Step, Progress, True);
end;

// Rotational star in center - counter-clockwise
procedure Effect151B(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  RotationalStarEffect(DestCanvas, Screen, Image, ARect, Step, Progress, False);
end;

// Spiral rectangle
procedure RectangularSpiralEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer;
                                  bClockwise: Boolean);
var
  mW, mH, mX, mY: Integer;
  Pts: array[1..4] of TPoint;
  Angle: Extended;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  mX := X div 2;
  mY := Y div 2;
  Pts[1].X := mW - mX;
  Pts[1].Y := mH - mY;
  Pts[2].X := mW + mX;
  Pts[2].Y := mH - mY;
  Pts[3].X := mW + mX;
  Pts[3].Y := mH + mY;
  Pts[4].X := mW - mX;
  Pts[4].Y := mH + mY;
  Angle := PI * Progress / 50;
  if bClockwise = False then
    Angle := -Angle;
  RotatePoints(Pts, X, Y, Angle);
  Rgn := CreatePolygonRgn(Pts, 4, WINDING);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;



// Spiral rectangle - clockwise
procedure Effect152(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  RectangularSpiralEffect(DestCanvas, Screen, Image, ARect, Step, Progress, True);
end;


// Spiral rectangle - counter-clockwise
procedure Effect152B(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  RectangularSpiralEffect(DestCanvas, Screen, Image, ARect, Step, Progress, False);
end;


procedure _PerformExpandShape(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Progress: Integer; AShape: TXCustomShape; rSize: Single);
var
  S, D: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  S := (Min(W, H) div 10) + 1;
  D := MulDiv(Round(rSize * S), Progress, 200);
  Rgn := 0;
  X := 0;
  while X < W do
  begin
    Inc(X, S);
    Y := 0;
    while Y < H do
    begin
      Inc(Y, S);
      if ord(AShape) <> Circular_Shape then
        TmpRgn := CreateCustomShape(AShape, Rect(X - D, Y - D, X + D, Y + D))
      else
        TmpRgn := CreateEllipticRgn(X - D, Y - D, X + D, Y + D);
      if Rgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);
      end
      else
        Rgn := TmpRgn;
      Inc(Y, S);
    end;
    Inc(X, S);
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Expanding Circles
procedure Effect153(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformExpandShape(DestCanvas, Screen, Image, ARect, Progress, TXCustomShape(Circular_Shape), 3);
end;

// Expanding Hearts
procedure ExpandingHeartsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformExpandShape(DestCanvas, Screen, Image, ARect, Progress, xcsHeart, 3);
end;

// Expanding 5 Point Stars
procedure ExpandingStar5Effect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformExpandShape(DestCanvas, Screen, Image, ARect, Progress, xcsStar5, 4);
end;

// Expanding 6 Point Stars
procedure ExpandingStar6Effect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformExpandShape(DestCanvas, Screen, Image, ARect, Progress, xcsStar6, 4);
end;

// Expanding Explosions
procedure ExpandingExplosionsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformExpandShape(DestCanvas, Screen, Image, ARect, Progress, xcsExplosion, 4);
end;

// Expanding Lightning Bolts
procedure ExpandingLightningBoltsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformExpandShape(DestCanvas, Screen, Image, ARect, Progress, xcsLightningLeft, 6);
end;


// Reveal V from left
procedure Effect154(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mH: Integer;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mH := H div 2;
  Rgn := CreatePolygonRgnEx([0, mH - Y, 2 * X, mH, 0, mH + Y]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal V from right
procedure Effect155(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mH: Integer;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mH := H div 2;
  Rgn := CreatePolygonRgnEx([W, mH - Y, W - 2 * X, mH, W, mH + Y]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal V from top
procedure Effect156(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW: Integer;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  Rgn := CreatePolygonRgnEx([mW - X, 0, mW, 2 * Y, mW + X, 0]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal V from bottom
procedure Effect157(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW: Integer;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  Rgn := CreatePolygonRgnEx([mW - X, H, mW, H - 2 * Y, mW + X, H]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bow Tie Horizontal
procedure Effect158(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mH: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mH := H div 2;
  Rgn := CreatePolygonRgnEx([0, mH - Y, X, mH, 0, mH + Y]);
  TmpRgn := CreatePolygonRgnEx([W, mH - Y, W - X, mH, W, mH + Y]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Bow Tie Vertical
procedure Effect159(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  Rgn := CreatePolygonRgnEx([mW - X, 0, mW, 2 * Y, mW + X, 0]);
  TmpRgn := CreatePolygonRgnEx([mW - X, H, mW, H - 2 * Y, mW + X, H]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Diagonal Cross In
procedure Effect160(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mH, mX, mY: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  mX := X div 2;
  mY := Y div 2;
  Rgn := CreatePolygonRgnEx([0, mH - mY, mX, mH, 0, mH + mY]);
  TmpRgn := CreatePolygonRgnEx([W, mH - mY, W - mX, mH, W, mH + mY]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW - mX, 0, mW, mY, mW + mX, 0]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW - mX, H, mW, H - mY, mW + mX, H]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Diagonal Cross Out
procedure Effect161(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mH, mX, mY: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  X := W - X;
  Y := H - Y;
  mW := W div 2;
  mH := H div 2;
  mX := X div 2;
  mY := Y div 2;
  Rgn := CreateRectRgn(0, 0, W, H);
  TmpRgn := CreatePolygonRgnEx([0, mH - mY, mX, mH, 0, mH + mY]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([W, mH - mY, W - mX, mH, W, mH + mY]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW - mX, 0, mW, mY, mW + mX, 0]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
  DeleteObject(TmpRgn);
  TmpRgn := CreatePolygonRgnEx([mW - mX, H, mW, H - mY, mW + mX, H]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Zigzag Wipe from Horizon
procedure Effect162(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mH, mY, sH, sW: Integer;
  YY: array[1..4] of Integer;
  U, D, I, J: Integer;
  Pts: array[1..24] of TPoint;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  sH := H div 10;
  sW := W div 10;
  mH := H div 2;
  mY := Y div 2 + MulDiv(sH, Progress, 100);
  YY[1] := mH + sH - mY;
  YY[2] := mH - sH - mY;
  YY[3] := mH + sH + mY;
  YY[4] := mH - sH + mY;
  X := 0;
  U := Low(Pts);
  D := High(Pts);
  for I := 1 to 6 do
  begin
    for J := 1 to 2 do
    begin
      Pts[U].X := X;
      Pts[U].Y := YY[J];
      Inc(U);
      Pts[D].X := X;
      Pts[D].Y := YY[J + 2];
      Dec(D);
      Inc(X, sW);
    end;
  end;
  Rgn := CreatePolygonRgn(Pts, 24, WINDING);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;


// Zigzag Wipe To Horizon
procedure Effect162_Reverse(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mH, mY, sH, sW: Integer;
  YY: array[1..4] of Integer;
  U, D, I, J: Integer;
  Pts: array[1..24] of TPoint;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, 100 - Progress, W, H, X, Y);
  sH := H div 10;
  sW := W div 10;
  mH := H div 2;
  mY := Y div 2 + MulDiv(sH, 100 - Progress, 100);
  YY[1] := mH + sH - mY;
  YY[2] := mH - sH - mY;
  YY[3] := mH + sH + mY;
  YY[4] := mH - sH + mY;
  X := 0;
  U := Low(Pts);
  D := High(Pts);
  for I := 1 to 6 do
  begin
    for J := 1 to 2 do
    begin
      Pts[U].X := X;
      Pts[U].Y := YY[J];
      Inc(U);
      Pts[D].X := X;
      Pts[D].Y := YY[J + 2];
      Dec(D);
      Inc(X, sW);
    end;
  end;
  Rgn := CreatePolygonRgn(Pts, 24, WINDING);
  try
    with DestCanvas do
    begin
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Screen.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Zigzag Wipe from Vertical Center
procedure Effect163(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mX, sH, sW: Integer;
  XX: array[1..4] of Integer;
  L, R, I, J: Integer;
  Pts: array[1..24] of TPoint;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  sH := H div 10;
  sW := W div 10;
  mW := W div 2;
  mX := X div 2 + MulDiv(sW, Progress, 100);

  // LHS
  XX[1] := mW + sW - mX;
  XX[2] := mW - sW - mX;

  // RHS
  XX[3] := mW + sW + mX;
  XX[4] := mW - sW + mX;

  Y := 0;
  L := Low(Pts);
  R := High(Pts);
  for I := 1 to 6 do
  begin
    for J := 1 to 2 do
    begin
      // LHS
      Pts[L].X := XX[J];
      Pts[L].Y := Y;
      Inc(L);

      // RHS
      Pts[R].X := XX[J + 2];
      Pts[R].Y := Y;
      Dec(R);

      Inc(Y, sH);
    end;
  end;
  Rgn := CreatePolygonRgn(Pts, 24, WINDING);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;


// Zigzag Wipe To Vertical Center
procedure Effect163_Reverse(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mX, sH, sW: Integer;
  XX: array[1..4] of Integer;
  L, R, I, J: Integer;
  Pts: array[1..24] of TPoint;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, 100 - Progress, W, H, X, Y);
  sH := H div 10;
  sW := W div 10;
  mW := W div 2;
  mX := X div 2 + MulDiv(sW, 100 - Progress, 100);

  // LHS
  XX[1] := mW + sW - mX;
  XX[2] := mW - sW - mX;

  // RHS
  XX[3] := mW + sW + mX;
  XX[4] := mW - sW + mX;

  Y := 0;
  L := Low(Pts);
  R := High(Pts);
  for I := 1 to 6 do
  begin
    for J := 1 to 2 do
    begin
      // LHS
      Pts[L].X := XX[J];
      Pts[L].Y := Y;
      Inc(L);

      // RHS
      Pts[R].X := XX[J + 2];
      Pts[R].Y := Y;
      Dec(R);

      Inc(Y, sH);
    end;
  end;
  Rgn := CreatePolygonRgn(Pts, 24, WINDING);
  try
    with DestCanvas do
    begin                         
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Screen.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Diamond shred
procedure Effect164(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, D: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  S := (Min(W, H) div 10) + 1;
  D := MulDiv(S, Progress, 50);
  Rgn := 0;
  X := 0;
  while X < W do
  begin
    Inc(X, S);                                             
    Y := 0;
    while Y < H do
    begin
      Inc(Y, S);
      TmpRgn := CreatePolygonRgnEx([X - D, Y, X, Y - D, X + D, Y, X, Y + D]);
      if Rgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);
      end
      else
        Rgn := TmpRgn;
      Inc(Y, S);
    end;
    Inc(X, S);
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;

// Reveal diamond out from centre
procedure Effect165(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mH: Integer;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  Rgn := CreatePolygonRgnEx([mW - X, mH, mW, mH - Y, mW + X, mH, mW, mH + Y]);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Reveal diamond in to centre
procedure Effect166(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  mW, mH: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  Rgn := CreateRectRgn(0, 0, W, H);
  TmpRgn := CreatePolygonRgnEx([X - mW, mH, mW, Y - mH, 3 * mW - X, mH, mW, 3 * mH - Y]);
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

    

procedure _PeformShapeWipeInAndOut(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Progress: Integer; AShape: TXCustomShape; rScale: single = 1);
var
  mW, mH, mX, mY: Integer;
  Rgn, TmpRgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  mW := W div 2;
  mH := H div 2;
  mX := X div 2;
  mY := Y div 2;

  if ord(AShape) <> Diamond_Shape then
  begin
    Rgn := CreateCustomShape(AShape, Rect(-1 * Round(rScale * mX), -1 * Round(rScale * mY), 2 * mW + Round(rScale * mX), 2 * mH + Round(rScale * mY)));
    TmpRgn := CreateCustomShape(AShape, Rect(mx, mY, 2 * mW - mX, 2 * mH - mY));
  end
  else
  begin
    Rgn := CreatePolygonRgnEx([-mX, mH, mW, -mY, 2 * mW + mX, mH, mW, 2 * mH + mY]);
    TmpRgn := CreatePolygonRgnEx([mX, mH, mW, mY, 2 * mW - mX, mH, mW, 2 * mH - mY]);
  end;
  CombineRgn(Rgn, Rgn, TmpRgn, RGN_XOR);
  DeleteObject(TmpRgn);
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;


// Diamond Wipe In and Out
procedure Effect167(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PeformShapeWipeInAndOut(DestCanvas, Screen, Image, ARect, Progress, TXCustomShape(Diamond_Shape));
end;


// Heart Wipe In and Out
procedure HeartWipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PeformShapeWipeInAndOut(DestCanvas, Screen, Image, ARect, Progress, xcsHeart, 1.6);
end;

// 5 Point Star Wipe In and Out
procedure Star5WipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PeformShapeWipeInAndOut(DestCanvas, Screen, Image, ARect, Progress, xcsStar5, 2.4);
end;

// 6 Point Star Wipe In and Out
procedure Star6WipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PeformShapeWipeInAndOut(DestCanvas, Screen, Image, ARect, Progress, xcsStar6, 1.6);
end;

// Explosion Wipe In and Out
procedure ExplosionWipeInAndOutEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PeformShapeWipeInAndOut(DestCanvas, Screen, Image, ARect, Progress, xcsExplosion, 1.1);
end;


// Pixelate         
{ Requires a 32 bit palette
procedure Effect168(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, sW, sH: Integer;
  SrcDC, DstDC: HDC;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  DstDC := DestCanvas.Handle;
  if Progress <= 50 then    
  begin
    SrcDC := DstDC;
    S := 180 - MulDiv(Progress, 180 - 98, 50);
  end
  else
  begin
    SrcDC := Image.Canvas.Handle;
    X := W - X;
    Y := H - Y;
    S := 180 + MulDiv((Progress - 100), 180 - 98, 50);
  end;
  X := MulDiv(X, S, 100);
  Y := MulDiv(Y, S, 100);
  sW := Max(W - 2 * X, 2);
  sH := Max(H - 2 * Y, 2);
  if (Progress >= 41) and (Progress <= 59) then
  begin
    MergeTransparent(Display, Image, 5 + (Progress - 41) * 5, X, Y, sW, sH);
    SrcDC := DstDC;
  end;
  StretchBlt(DstDC, -2 * X, -2 * Y, W + 4 * X, H + 4 * Y,
             SrcDC, X, Y, sW, sH,
             SRCCOPY)
end;  }

// Dissolve         
{ Just like IE effect
procedure Effect169(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  SavedRandSeed: Integer;
  dstPixel, srcPixel: PRGBQuad;
  I: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SavedRandSeed := RandSeed;
  RandSeed := Integer(Image.Handle);
  srcPixel := Image.ScanLine[H - 1];
  dstPixel := Display.ScanLine[H - 1];
  for I := (W * H) - 1 downto 0 do
  begin
    if Random(100) < Progress then
      dstPixel^ := srcPixel^;
    Inc(srcPixel);
    Inc(dstPixel);
  end;
  RandSeed := SavedRandSeed;
end; }

// Random Bars Horizontal   
{ Uses TBitmap.ScanLine
procedure Effect170(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  SavedRandSeed: Integer;
  dstPixel, srcPixel: PRGBQuad;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SavedRandSeed := RandSeed;
  RandSeed := Integer(Image.Handle);
  srcPixel := Image.ScanLine[H - 1];
  dstPixel := Display.ScanLine[H - 1];
  for Y := 0 to H - 1 do
    if Random(100) < Progress then
    begin
      for X := 0 to W - 1 do
      begin
        dstPixel^ := srcPixel^;
        Inc(srcPixel);
        Inc(dstPixel);
      end;
    end
    else
    begin
      Inc(srcPixel, W);
      Inc(dstPixel, W);
    end;
  RandSeed := SavedRandSeed;
end;
}

// Random Bars Vertical     
{ Uses TBitmap.ScanLine
procedure Effect171(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  SavedRandSeed, N: Integer;
  dstPixel, srcPixel: PRGBQuad;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SavedRandSeed := RandSeed;
  RandSeed := Integer(Image.Handle);
  N := W * H;
  srcPixel := Image.ScanLine[H - 1];
  dstPixel := Display.ScanLine[H - 1];
  for X := 0 to W - 1 do
  begin
    if Random(100) < Progress then
    begin
      for Y := 0 to H - 1 do
      begin
        dstPixel^ := srcPixel^;
        Inc(srcPixel, W);
        Inc(dstPixel, W);
      end;
      Dec(srcPixel, N);
      Dec(dstPixel, N);
    end;
    Inc(srcPixel);
    Inc(dstPixel);
  end;
  RandSeed := SavedRandSeed;
end;
}
     
// Channel Mix
{ Uses TBitmap.ScanLine and 32 bit
procedure Effect172(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
type
  PRGBQuadChannles = ^TRGBQuadChannles;
  TRGBQuadChannles = array[0..3] of Byte;
var
  SavedRandSeed: Integer;
  dstPixel, srcPixel: PRGBQuadChannles;
  C1, C2, C3, Weight, I: Integer;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SavedRandSeed := RandSeed;
  RandSeed := Integer(Image.Handle);
  C1 := Random(3);
  repeat C2 := Random(3) until C1 <> C2;
  C3 := not (C1 or C2) and $03;
  RandSeed := SavedRandSeed;
  srcPixel := Image.ScanLine[H - 1];
  dstPixel := Display.ScanLine[H - 1];
  if Progress <= 33 then
  begin
    Weight := MulDiv(256, Progress, 33);
    for I := (W * H) - 1 downto 0 do
    begin
      Inc(dstPixel^[C1], (Weight * (srcPixel^[C1] - dstPixel^[C1])) shr 8);
      Inc(srcPixel);
      Inc(dstPixel);
    end;
  end
  else if Progress <= 66 then
  begin
    Weight := MulDiv(256, Progress - 33, 33);
    for I := (W * H) - 1 downto 0 do
    begin
      dstPixel^[C1] := srcPixel^[C1];
      Inc(dstPixel^[C2], (Weight * (srcPixel^[C2] - dstPixel^[C2])) shr 8);
      Inc(srcPixel);
      Inc(dstPixel);
    end;
  end
  else
  begin
    Weight := MulDiv(256, Progress - 66, 33);
    for I := (W * H) - 1 downto 0 do
    begin
      dstPixel^[C1] := srcPixel^[C1];
      dstPixel^[C2] := srcPixel^[C2];
      Inc(dstPixel^[C3], (Weight * (srcPixel^[C3] - dstPixel^[C3])) shr 8);
      Inc(srcPixel);
      Inc(dstPixel);
    end;
  end;
end;  }



// Wipe in Triangular pattern
procedure TriangularWipeEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);

  function CreateTriangleRgn(X1, Y1, X2, Y2, X3, Y3: Integer): HRGN;
  var
    Pts: array[1..3] of TPoint;
  begin
    Pts[1].X := X1;
    Pts[1].Y := Y1;
    Pts[2].X := X2;
    Pts[2].Y := Y2;
    Pts[3].X := X3;
    Pts[3].Y := Y3;
    Result := CreatePolygonRgn(Pts, High(Pts), WINDING);
  end;

var
  W, H, X, Y, S: Integer;
  I, J: Integer;
  Rgn, TmpRgn: HRGN;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  if W >= H then
   S := MulDiv(W, Step, 90)
  else
    S := MulDiv(H, Step, 90);
  Rgn := 0;
  if S < 1 then
    S := 1
  else
  if S > 1 then
    S := S div 2;
  X := X div S;
  Y := Y div S;
  W := W div S;
  H := H div S;
  for J := S downto 0 do
  begin
    for I := S downto 0 do
    begin
      TmpRgn := CreateTriangleRgn(I * W - X, J * H - Y, I * W + X, J * H - Y, I * W - X, J * H + Y);
      if Rgn <> 0 then
      begin
        CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
        DeleteObject(TmpRgn);
      end
      else
       Rgn := TmpRgn;
    end;
  end;
  SelectClipRgn(DestCanvas.Handle, Rgn);
  DeleteObject(Rgn);
  DestCanvas.Draw(0, 0, Image);
  SelectClipRgn(DestCanvas.Handle, 0);
end;

// Large boxes at random positions
procedure RandomBigBoxesEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  S, SavedRandSeed: Integer;
  ComplexRegion: TComplexRegion;
  Rgn: HRGN;
  W, H, X, Y: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SavedRandSeed := RandSeed;
  RandSeed := Integer(Image.Handle);
  S := (Min(W, H) div 20) + 1;
  ComplexRegion := TComplexRegion.Create;
  try
    X := 0;
    while X < W do
    begin
      Inc(X, S);
      Y := 0;
      while Y < H do
      begin
        Inc(Y, S);
        if Random(100) < Progress then
          ComplexRegion.AddRect(X - S, Y - S, X + S, Y + S);
        Inc(Y, S);
      end;
      Inc(X, S);
    end;
    Rgn := ComplexRegion.CreateRegion;
  finally
    ComplexRegion.Free;
    RandSeed := SavedRandSeed;
  end;
  if Rgn <> 0 then
    try
      with DestCanvas do
      begin
        SelectClipRgn(Handle, Rgn);
        BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
        SelectClipRgn(Handle, 0);
      end;
    finally
      DeleteObject(Rgn);
    end;
end;



procedure _PerformRandomShapesEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Progress: Integer;
                                     AShape: TXCustomShape; iCount: integer; rCoverage: Single);
var
  iSize, SavedRandSeed: Integer;
  Rgn: HRGN;
  W, H, X, Y: Integer;
  TmpRgn: HRGN;
  iMovementIncrement: Integer;
begin
  CalcParams(ARect, Progress, W, H, X, Y);
  SavedRandSeed := RandSeed;
  RandSeed := Integer(Image.Handle);
  iSize := (Min(W, H) div iCount) + 1;
  iMovementIncrement := Trunc(iSize * rCoverage);

  Rgn := 0;
  try
    X := 0;
    while X < W do
    begin
      Inc(X, iMovementIncrement);
      Y := 0;
      while Y < H do
      begin
        Inc(Y, iMovementIncrement);

        if Random(100) < Progress then
        begin
          TmpRgn := CreateCustomShape(AShape, Rect(X - iSize, Y - iSize, X + iSize, Y + iSize));
          if Rgn <> 0 then
          begin
            CombineRgn(Rgn, Rgn, TmpRgn, RGN_OR);
            DeleteObject(TmpRgn);
          end
          else
            Rgn := TmpRgn;
        end;

        Inc(Y, iMovementIncrement);
      end;
      Inc(X, iMovementIncrement);
    end;
  finally
    RandSeed := SavedRandSeed;
  end;
  if Rgn <> 0 then
  try
    with DestCanvas do
    begin
      SelectClipRgn(Handle, Rgn);
      BitBlt(Handle, 0, 0, W, H, Image.Canvas.Handle, 0, 0, SRCCOPY);
      SelectClipRgn(Handle, 0);
    end;
  finally
    DeleteObject(Rgn);
  end;
end;

// Hearts at random positions
procedure RandomHeartsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformRandomShapesEffect(DestCanvas, Screen, Image, ARect, Progress, xcsHeart, 12, 0.6);
end;

// 5 Point Stars at random positions
procedure RandomStar5sEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformRandomShapesEffect(DestCanvas, Screen, Image, ARect, Progress, xcsStar5, 14, 0.4);
end;

// 6 Point Stars at random positions
procedure RandomStar6sEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
begin
  _PerformRandomShapesEffect(DestCanvas, Screen, Image, ARect, Progress, xcsStar6, 14, 0.4);
end;

// Explosions at random positions
procedure RandomExplosionsEffect(DestCanvas:TCanvas; Screen, Image: TBitmap; const ARect: TRect; Step: Integer; Progress: Integer);
var
  AShape: TXCustomShape;
begin
  if Progress mod 2 = 0 then
    AShape := xcsExplosion
  else
    AShape := xcsExplosion_2;
  _PerformRandomShapesEffect(DestCanvas, Screen, Image, ARect, Progress, AShape, 18, 0.5);
end;
         
{$endif}

end.




