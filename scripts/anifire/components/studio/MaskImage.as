package anifire.components.studio
{
   import anifire.component.DoubleStateButton;
   import anifire.component.GoAlert;
   import anifire.constant.ServerConstants;
   import anifire.core.Console;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.GradientType;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.Camera;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.TitleWindow;
   import mx.containers.VBox;
   import mx.controls.Alert;
   import mx.controls.Button;
   import mx.controls.HRule;
   import mx.controls.HSlider;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.RadioButton;
   import mx.controls.RadioButtonGroup;
   import mx.controls.TextArea;
   import mx.core.DragSource;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Move;
   import mx.effects.Parallel;
   import mx.effects.Sequence;
   import mx.events.DragEvent;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.SliderEvent;
   import mx.graphics.codec.PNGEncoder;
   import mx.managers.CursorManager;
   import mx.managers.CursorManagerPriority;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.states.Transition;
   import mx.styles.CSSStyleDeclaration;
   import mx.utils.Base64Encoder;
   
   use namespace mx_internal;
   
   public class MaskImage extends TitleWindow implements IBindingClient
   {
      
      private static const SMALL:String = "small";
      
      private static var _main:MaskImage;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const LARGE:String = "large";
       
      
      private var _2128854107btnUnLockImage:Button;
      
      private var point_seperation_coef:Number;
      
      private var _1238661901myImageBackgroundCan:Canvas;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _117924854btnCancel:Button;
      
      private var _1524443640_step1HBox1:HBox;
      
      private var total_dots:Number;
      
      private var _216437328scaleDownBtn:Button;
      
      private var _maxx:Number = 0;
      
      private var _maxy:Number = 0;
      
      private var _466094112pointCan:Canvas;
      
      private var _2085107856btnFlipY:DoubleStateButton;
      
      private var _762489709_txtDefShape:Label;
      
      private var radius:Number;
      
      private var _1067562475_canRotateContainer:Canvas;
      
      private var _headable:Boolean = false;
      
      private var _lineStyle:String;
      
      private var _skipFrameCount:Number = 0;
      
      private var _imageHeight:Number;
      
      private var _206195195btnSkip:Label;
      
      private var _1524443638_step1HBox3:HBox;
      
      private var _398777791myImageCan:Canvas;
      
      private var _1489557556_canRotate:Canvas;
      
      private var _197399556borderCan:Canvas;
      
      private var _46991788_canStep1:Canvas;
      
      private var _1411101201appCan:Canvas;
      
      private var _1755110271_hboxShape:HBox;
      
      private var _minx:Number = 999999;
      
      private var _miny:Number = 999999;
      
      private var _1584270309shadowImage:Image;
      
      private var dragging:Boolean;
      
      private var num_pt:Number;
      
      private var _placeable:Boolean = false;
      
      private var _lockImage:Boolean;
      
      private var _934862275refCan:Canvas;
      
      private var _58631450_canGap12:Canvas;
      
      private var _2085107855btnFlipX:DoubleStateButton;
      
      private var _104336004myCan:Canvas;
      
      private var _91294677_tip1:Button;
      
      private var _1352381102_btnCurved:RadioButton;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1481556916_bgCan:Canvas;
      
      private var _3029410body:Image;
      
      public var xOff:Number;
      
      private var _embed_mxml__________styles_body_swf_1523280369:Class;
      
      private var _1495814487_step2HBox3:HBox;
      
      private var customCursor:Class;
      
      public var yOff:Number;
      
      private var _1467185338_step3HBox1:HBox;
      
      private var _1524443639_step1HBox2:HBox;
      
      private var _398907829shadowImageCan:Canvas;
      
      private var _91294678_tip2:Button;
      
      private var _196495664btnExport:Button;
      
      private var currTarget:DisplayObject;
      
      private var _1914892951scaleUpBtn:Button;
      
      private var _currDraggingSprite:Sprite;
      
      private var variance:Number;
      
      private var _3645t1:Sequence;
      
      private var _1610907660btnLockImage:Button;
      
      public var _MaskImage_SetProperty1:SetProperty;
      
      public var _MaskImage_SetProperty2:SetProperty;
      
      public var _MaskImage_SetProperty3:SetProperty;
      
      public var _MaskImage_SetProperty4:SetProperty;
      
      public var _MaskImage_SetProperty5:SetProperty;
      
      public var _MaskImage_SetProperty6:SetProperty;
      
      public var _MaskImage_SetProperty7:SetProperty;
      
      public var _MaskImage_SetProperty8:SetProperty;
      
      public var _MaskImage_SetProperty9:SetProperty;
      
      private var _1366867201SldScale:HSlider;
      
      private var _embed_mxml__________styles_hand_swf_1752417847:Class;
      
      private var _443042323_canAppControl:Canvas;
      
      private var myMask:UIComponent;
      
      private var _imageWidth:Number;
      
      public var _MaskImage_Label1:Label;
      
      public var _MaskImage_Label2:Label;
      
      public var _MaskImage_Label3:Label;
      
      public var _MaskImage_Label4:Label;
      
      public var _MaskImage_Label5:Label;
      
      private var _46991786_canStep3:Canvas;
      
      public var _MaskImage_Label7:Label;
      
      private var maskArray:Array;
      
      private var _assetId:Number;
      
      private var pts:Array;
      
      private var _91294679_tip3:Button;
      
      private var _1773154204_canWorkSpace:Canvas;
      
      private var pressPoint:Point;
      
      private var _1188665678lineType:RadioButtonGroup;
      
      private var _3194991hand:Image;
      
      private var _cropImage:Boolean;
      
      private var _1349726281_btnStraight:RadioButton;
      
      private var _1455051876_step3Text1:TextArea;
      
      private var _613032367btnCropImage:Button;
      
      private var _1495814488_step2HBox2:HBox;
      
      private var _updated:Boolean = false;
      
      private var showMask:Boolean = false;
      
      private var _1023330954myBackgroundCan:Canvas;
      
      mx_internal var _watchers:Array;
      
      private var _660568935shadowImageBackgroundCan:Canvas;
      
      private var _58631418_canGap23:Canvas;
      
      private var _1488541455myImage:Image;
      
      private var _57826838btnUnCropImage:Button;
      
      public var cam:Camera;
      
      mx_internal var _bindings:Array;
      
      private var _46991787_canStep2:Canvas;
      
      private var _holdable:Boolean = false;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function MaskImage()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":TitleWindow,
            "propertiesFactory":function():Object
            {
               return {
                  "width":935,
                  "height":610,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_bgCan",
                     "events":{"creationComplete":"___bgCan_creationComplete"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.horizontalGap = 10;
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":50,
                           "percentWidth":100,
                           "percentHeight":100,
                           "horizontalScrollPolicy":"off",
                           "verticalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":VBox,
                              "stylesFactory":function():void
                              {
                                 this.paddingLeft = 20;
                                 this.verticalGap = 30;
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "x":0,
                                    "height":490,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "clipContent":false,
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_canStep1",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":260,
                                             "height":160,
                                             "styleName":"canCropperRect",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.verticalGap = 15;
                                                   this.paddingTop = 10;
                                                   this.paddingLeft = 10;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":95,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_MaskImage_Label1",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingLeft = 30;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "styleName":"txtCropperWhiteLight"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_tip1",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnCropperTip",
                                                                        "buttonMode":true
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_step1HBox1",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.verticalAlign = "middle";
                                                            this.horizontalGap = 0;
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_MaskImage_Label2",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"styleName":"txtCropperBlack"};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HSlider,
                                                                        "id":"SldScale",
                                                                        "events":{"change":"__SldScale_change"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "x":25,
                                                                              "y":0,
                                                                              "width":140,
                                                                              "minimum":20,
                                                                              "value":100,
                                                                              "snapInterval":1,
                                                                              "maximum":200,
                                                                              "allowTrackClick":true,
                                                                              "enabled":true,
                                                                              "styleName":"sliderCropper",
                                                                              "buttonMode":true
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"scaleDownBtn",
                                                                        "events":{"buttonDown":"__scaleDownBtn_buttonDown"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "x":15,
                                                                              "y":5,
                                                                              "height":15,
                                                                              "width":8,
                                                                              "styleName":"sliderCropperArrow",
                                                                              "buttonMode":true
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"scaleUpBtn",
                                                                        "events":{"buttonDown":"__scaleUpBtn_buttonDown"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "x":178,
                                                                              "y":5,
                                                                              "height":15,
                                                                              "width":8,
                                                                              "styleName":"sliderCropperArrow",
                                                                              "scaleX":-1,
                                                                              "buttonMode":true
                                                                           };
                                                                        }
                                                                     })]};
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_step1HBox2",
                                                         "events":{"creationComplete":"___step1HBox2_creationComplete"},
                                                         "stylesFactory":function():void
                                                         {
                                                            this.verticalGap = 10;
                                                            this.horizontalGap = 10;
                                                            this.verticalAlign = "middle";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_MaskImage_Label3",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"styleName":"txtCropperBlack"};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "id":"_canRotateContainer",
                                                                  "events":{"creationComplete":"___canRotateContainer_creationComplete"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "height":40,
                                                                        "width":40,
                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                           "type":Canvas,
                                                                           "id":"_canRotate",
                                                                           "propertiesFactory":function():Object
                                                                           {
                                                                              return {
                                                                                 "height":20,
                                                                                 "width":20,
                                                                                 "clipContent":false
                                                                              };
                                                                           }
                                                                        })]
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_MaskImage_Label4",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"styleName":"txtCropperBlack"};
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":DoubleStateButton,
                                                                  "id":"btnFlipX",
                                                                  "events":{"click":"__btnFlipX_click"},
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "buttonMode":true,
                                                                        "useHandCursor":true
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Canvas,
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":DoubleStateButton,
                                                                        "id":"btnFlipY",
                                                                        "events":{"click":"__btnFlipY_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "buttonMode":true,
                                                                              "useHandCursor":true
                                                                           };
                                                                        }
                                                                     })]};
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_step1HBox3",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.horizontalCenter = "0";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"btnLockImage",
                                                                  "events":{"click":"__btnLockImage_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.horizontalCenter = "0";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnCropperBlue",
                                                                        "buttonMode":true
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_canGap12",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "clipContent":false,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"btnUnLockImage",
                                                "events":{"click":"__btnUnLockImage_click"},
                                                "stylesFactory":function():void
                                                {
                                                   this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":25,
                                                      "visible":false,
                                                      "styleName":"btnCropperLightBlue",
                                                      "buttonMode":true
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_canStep2",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":260,
                                             "height":170,
                                             "styleName":"canCropperRect",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.verticalGap = 15;
                                                   this.paddingTop = 10;
                                                   this.paddingLeft = 10;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_MaskImage_Label5",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingLeft = 30;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "styleName":"txtCropperWhiteLight"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_tip2",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnCropperTip",
                                                                        "buttonMode":true
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_hboxShape",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalGap = 1;
                                                            this.verticalAlign = "middle";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"childDescriptors":[new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_txtDefShape",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "text":"",
                                                                     "styleName":"txtCropperBlack"
                                                                  };
                                                               }
                                                            })]};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_step2HBox2",
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {"childDescriptors":[new UIComponentDescriptor({
                                                               "type":RadioButton,
                                                               "id":"_btnCurved",
                                                               "events":{"creationComplete":"___btnCurved_creationComplete"},
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.textRollOverColor = 16777215;
                                                                  this.fontSize = 12;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "groupName":"lineType",
                                                                     "value":"curved",
                                                                     "selected":true,
                                                                     "styleName":"txtCropperWhiteLight",
                                                                     "buttonMode":true
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":RadioButton,
                                                               "id":"_btnStraight",
                                                               "events":{"creationComplete":"___btnStraight_creationComplete"},
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.textRollOverColor = 16777215;
                                                                  this.fontSize = 12;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "groupName":"lineType",
                                                                     "value":"straight",
                                                                     "styleName":"txtCropperWhiteLight",
                                                                     "buttonMode":true
                                                                  };
                                                               }
                                                            })]};
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_step2HBox3",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.horizontalCenter = "0";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"btnCropImage",
                                                                  "events":{"click":"__btnCropImage_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.horizontalCenter = "0";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "label":"",
                                                                        "styleName":"btnCropperBlue",
                                                                        "buttonMode":true
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_canGap23",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "clipContent":false,
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"btnUnCropImage",
                                                "events":{"click":"__btnUnCropImage_click"},
                                                "stylesFactory":function():void
                                                {
                                                   this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "y":25,
                                                      "visible":false,
                                                      "styleName":"btnCropperLightBlue",
                                                      "buttonMode":true
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Canvas,
                                       "id":"_canStep3",
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "width":260,
                                             "height":160,
                                             "styleName":"canCropperRect",
                                             "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function():void
                                                {
                                                   this.verticalGap = 15;
                                                   this.paddingTop = 10;
                                                   this.paddingLeft = 10;
                                                },
                                                "propertiesFactory":function():Object
                                                {
                                                   return {
                                                      "percentWidth":100,
                                                      "childDescriptors":[new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Label,
                                                                  "id":"_MaskImage_Label7",
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.paddingLeft = 30;
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "percentWidth":100,
                                                                        "styleName":"txtCropperWhiteLight"
                                                                     };
                                                                  }
                                                               }),new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"_tip3",
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnCropperTip",
                                                                        "buttonMode":true
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":TextArea,
                                                         "id":"_step3Text1",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.fontSize = 16;
                                                            this.textAlign = "center";
                                                            this.backgroundAlpha = 0;
                                                            this.borderStyle = "none";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "styleName":"txtCropperBlack",
                                                               "percentWidth":100,
                                                               "percentHeight":100,
                                                               "editable":false,
                                                               "selectable":false,
                                                               "focusEnabled":false
                                                            };
                                                         }
                                                      }),new UIComponentDescriptor({
                                                         "type":HBox,
                                                         "id":"_step3HBox1",
                                                         "stylesFactory":function():void
                                                         {
                                                            this.horizontalAlign = "center";
                                                            this.horizontalCenter = "0";
                                                         },
                                                         "propertiesFactory":function():Object
                                                         {
                                                            return {
                                                               "percentWidth":100,
                                                               "childDescriptors":[new UIComponentDescriptor({
                                                                  "type":Button,
                                                                  "id":"btnExport",
                                                                  "events":{"click":"__btnExport_click"},
                                                                  "stylesFactory":function():void
                                                                  {
                                                                     this.horizontalCenter = "0";
                                                                  },
                                                                  "propertiesFactory":function():Object
                                                                  {
                                                                     return {
                                                                        "styleName":"btnCropperBlue",
                                                                        "buttonMode":true
                                                                     };
                                                                  }
                                                               })]
                                                            };
                                                         }
                                                      })]
                                                   };
                                                }
                                             })]
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"_canWorkSpace",
                              "propertiesFactory":function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"myBackgroundCan",
                                    "events":{"creationComplete":"__myBackgroundCan_creationComplete"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":0,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "autoLayout":false,
                                          "clipContent":false,
                                          "height":390,
                                          "width":610,
                                          "y":0
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"appCan",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":0,
                                          "height":390,
                                          "width":610,
                                          "y":0,
                                          "clipContent":true,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"myCan",
                                             "events":{"creationComplete":"__myCan_creationComplete"},
                                             "stylesFactory":function():void
                                             {
                                                this.shadowDirection = "center";
                                                this.shadowDistance = 5;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "verticalScrollPolicy":"off",
                                                   "horizontalScrollPolicy":"off",
                                                   "autoLayout":false,
                                                   "clipContent":true,
                                                   "x":0,
                                                   "height":390,
                                                   "width":610,
                                                   "y":0,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"shadowImageCan",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "clipContent":false,
                                                            "useHandCursor":false,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":Canvas,
                                                               "id":"shadowImageBackgroundCan",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"clipContent":false};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Image,
                                                               "id":"shadowImage",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "source":"",
                                                                     "useHandCursor":false,
                                                                     "scaleContent":false
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"myImageCan",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "clipContent":false,
                                                            "useHandCursor":true,
                                                            "buttonMode":true,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":Canvas,
                                                               "id":"myImageBackgroundCan",
                                                               "events":{"creationComplete":"__myImageBackgroundCan_creationComplete"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"clipContent":false};
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Image,
                                                               "id":"myImage",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "source":"",
                                                                     "useHandCursor":true,
                                                                     "scaleContent":false
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"borderCan",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "verticalScrollPolicy":"off",
                                                            "horizontalScrollPolicy":"off",
                                                            "x":0,
                                                            "height":390,
                                                            "width":610,
                                                            "y":0
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Canvas,
                                                      "id":"pointCan",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "verticalScrollPolicy":"off",
                                                            "horizontalScrollPolicy":"off",
                                                            "x":0,
                                                            "height":390,
                                                            "width":610,
                                                            "y":0
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"refCan",
                                    "events":{"creationComplete":"__refCan_creationComplete"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "x":0,
                                          "y":0,
                                          "alpha":0.7,
                                          "clipContent":false,
                                          "scaleX":2,
                                          "scaleY":2,
                                          "mouseChildren":false,
                                          "mouseEnabled":false,
                                          "mouseFocusEnabled":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Image,
                                             "id":"hand",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "source":_embed_mxml__________styles_hand_swf_1752417847,
                                                   "scaleContent":false,
                                                   "width":300,
                                                   "height":300,
                                                   "mouseChildren":false,
                                                   "mouseEnabled":false,
                                                   "mouseFocusEnabled":false
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Image,
                                             "id":"body",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "source":_embed_mxml__________styles_body_swf_1523280369,
                                                   "scaleContent":false,
                                                   "width":300,
                                                   "height":300,
                                                   "mouseChildren":false,
                                                   "mouseEnabled":false,
                                                   "mouseFocusEnabled":false
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_canAppControl",
                                    "events":{"creationComplete":"___canAppControl_creationComplete"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":0,
                                          "height":390,
                                          "width":610,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "mouseChildren":true
                                       };
                                    }
                                 })]};
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HRule,
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "x":0,
                           "y":550
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":HBox,
                     "stylesFactory":function():void
                     {
                        this.horizontalAlign = "right";
                        this.horizontalGap = 15;
                        this.verticalAlign = "middle";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "x":0,
                           "y":570,
                           "percentWidth":100,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Label,
                              "id":"btnSkip",
                              "events":{"click":"__btnSkip_click"},
                              "stylesFactory":function():void
                              {
                                 this.fontSize = 12;
                                 this.textDecoration = "underline";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"txtCropperBlue",
                                    "buttonMode":true,
                                    "mouseChildren":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnCancel",
                              "events":{"click":"__btnCancel_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "styleName":"btnCropperBlue",
                                    "buttonMode":true
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this.customCursor = MaskImage_customCursor;
         this._embed_mxml__________styles_body_swf_1523280369 = MaskImage__embed_mxml__________styles_body_swf_1523280369;
         this._embed_mxml__________styles_hand_swf_1752417847 = MaskImage__embed_mxml__________styles_hand_swf_1752417847;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.borderColor = 16249847;
            this.borderStyle = "solid";
            this.borderThickness = 0;
            this.backgroundColor = 16777215;
            this.backgroundAlpha = 1;
            this.themeColor = 16742400;
         };
         this.layout = "absolute";
         this.width = 935;
         this.height = 610;
         this.clipContent = false;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.showCloseButton = false;
         this.styleName = "bgCropper";
         this.states = [this._MaskImage_State1_c(),this._MaskImage_State2_c(),this._MaskImage_State3_c()];
         this.transitions = [this._MaskImage_Transition1_c()];
         this._MaskImage_RadioButtonGroup1_i();
         this.addEventListener("mouseUp",this.___MaskImage_TitleWindow1_mouseUp);
      }
      
      public static function getConsole() : MaskImage
      {
         if(_main != null)
         {
            return _main;
         }
         return null;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MaskImage._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get borderCan() : Canvas
      {
         return this._197399556borderCan;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnCancel() : Button
      {
         return this._117924854btnCancel;
      }
      
      public function set borderCan(param1:Canvas) : void
      {
         var _loc2_:Object = this._197399556borderCan;
         if(_loc2_ !== param1)
         {
            this._197399556borderCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"borderCan",_loc2_,param1));
         }
      }
      
      public function moveImage(param1:Event) : void
      {
         if(this.dragging)
         {
            this.shadowImageCan.x = this.myImageCan.x;
            this.shadowImageCan.y = this.myImageCan.y;
         }
      }
      
      public function set _step1HBox1(param1:HBox) : void
      {
         var _loc2_:Object = this._1524443640_step1HBox1;
         if(_loc2_ !== param1)
         {
            this._1524443640_step1HBox1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step1HBox1",_loc2_,param1));
         }
      }
      
      private function drawTransBackground() : void
      {
         this.myCan.graphics.beginFill(0,0);
         this.myCan.graphics.drawRect(0,0,this.myCan.width,this.myCan.height);
         this.myCan.graphics.endFill();
         this.myCan.cacheAsBitmap = true;
      }
      
      public function set _step1HBox3(param1:HBox) : void
      {
         var _loc2_:Object = this._1524443638_step1HBox3;
         if(_loc2_ !== param1)
         {
            this._1524443638_step1HBox3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step1HBox3",_loc2_,param1));
         }
      }
      
      public function set _step1HBox2(param1:HBox) : void
      {
         var _loc2_:Object = this._1524443639_step1HBox2;
         if(_loc2_ !== param1)
         {
            this._1524443639_step1HBox2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step1HBox2",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shadowImage() : Image
      {
         return this._1584270309shadowImage;
      }
      
      public function initMask() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Number = NaN;
         var _loc8_:MaskPoint = null;
         if(!this._headable && !this._holdable)
         {
            this.num_pt = 8;
            _loc1_ = this.myCan.width - 340;
            _loc2_ = this.myCan.height - 250;
            this.radius = 100;
            this.variance = 20;
            this.point_seperation_coef = 10;
            this.maskArray = new Array();
            this.pts = new Array(this.num_pt);
            _loc3_ = new Point(this.myCan.width / 2,this.myCan.height / 2);
            _loc4_ = Math.PI * 2 / this.num_pt;
            _loc5_ = new Array(-1,0,1,1,1,0,-1,-1);
            _loc6_ = new Array(-1,-1,-1,0,1,1,1,0);
            _loc7_ = 0;
            while(_loc7_ < this.num_pt)
            {
               _loc8_ = new MaskPoint();
               this.pts[_loc7_] = _loc8_;
               this.pts[_loc7_].x = _loc3_.x + _loc5_[_loc7_] * _loc1_ / 2;
               this.pts[_loc7_].y = _loc3_.y + _loc6_[_loc7_] * _loc2_ / 2;
               this.pointCan.addChild(_loc8_);
               _loc8_.doubleClickEnabled = true;
               _loc8_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
               _loc8_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
               _loc7_++;
            }
         }
         else if(this._headable)
         {
            this.chgShape(null,"men");
         }
         else if(this._holdable)
         {
            this.chgShape(null,"rectangle");
         }
         this.drawBorder();
      }
      
      private function chgShape(param1:Event = null, param2:String = null) : void
      {
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:MaskPoint = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         var _loc15_:Point = null;
         var _loc16_:Point = null;
         var _loc17_:Point = null;
         var _loc18_:Point = null;
         var _loc19_:Point = null;
         var _loc20_:Point = null;
         var _loc21_:Point = null;
         var _loc22_:Point = null;
         var _loc23_:Point = null;
         var _loc24_:Point = null;
         var _loc25_:Point = null;
         var _loc26_:Number = NaN;
         var _loc27_:Array = null;
         var _loc28_:Array = null;
         var _loc29_:Array = null;
         if(param1 != null)
         {
            _loc3_ = param1.currentTarget.data;
         }
         else if(param2 != null)
         {
            _loc3_ = param2;
         }
         this.pointCan.removeAllChildren();
         this.maskArray = new Array();
         switch(_loc3_)
         {
            case "rectangle":
               this.num_pt = 8;
               this.point_seperation_coef = 10;
               _loc4_ = 60;
               _loc5_ = 90;
               this.pts = new Array(this.num_pt);
               _loc6_ = new Point(this.myCan.width / this.myCan.scaleX / 2,this.myCan.height / this.myCan.scaleY / 2);
               _loc28_ = new Array(-1,0,1,1,1,0,-1,-1);
               _loc29_ = new Array(-1,-1,-1,0,1,1,1,0);
               _loc7_ = 0;
               while(_loc7_ < this.num_pt)
               {
                  _loc8_ = new MaskPoint();
                  this.pts[_loc7_] = _loc8_;
                  this.pts[_loc7_].x = _loc6_.x + _loc28_[_loc7_] * _loc4_ / 2;
                  this.pts[_loc7_].y = _loc6_.y + _loc29_[_loc7_] * _loc5_ / 2;
                  this.pointCan.addChild(_loc8_);
                  _loc8_.doubleClickEnabled = true;
                  _loc8_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
                  _loc8_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
                  _loc7_++;
               }
               this.borderCan.removeAllChildren();
               this.lineStyle = "line";
               break;
            case "round":
               this.num_pt = 8;
               this.point_seperation_coef = 10;
               _loc4_ = 60;
               _loc5_ = 90;
               this.pts = new Array(this.num_pt);
               _loc6_ = new Point(this.myCan.width / this.myCan.scaleX / 2,this.myCan.height / this.myCan.scaleY / 2);
               _loc9_ = new Point(271.9,212.5);
               _loc10_ = new Point(301.4,201.5);
               _loc11_ = new Point(332.5,214.5);
               _loc12_ = new Point(344.4,241.5);
               _loc13_ = new Point(334.4,274.5);
               _loc14_ = new Point(301.5,287.5);
               _loc15_ = new Point(268.9,275);
               _loc16_ = new Point(259.5,243);
               _loc26_ = -27;
               _loc27_ = new Array(_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_);
               _loc7_ = 0;
               while(_loc7_ < this.num_pt)
               {
                  _loc8_ = new MaskPoint();
                  this.pts[_loc7_] = _loc8_;
                  this.pts[_loc7_].x = Point(_loc27_[_loc7_]).x;
                  this.pts[_loc7_].y = Point(_loc27_[_loc7_]).y + _loc26_;
                  this.pointCan.addChild(_loc8_);
                  _loc8_.doubleClickEnabled = true;
                  _loc8_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
                  _loc8_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
                  _loc7_++;
               }
               this.borderCan.removeAllChildren();
               this.lineStyle = "curve";
               break;
            case "triangle":
               this.num_pt = 6;
               this.point_seperation_coef = 10;
               _loc4_ = 60;
               _loc5_ = 90;
               this.pts = new Array(this.num_pt);
               _loc6_ = new Point(this.myCan.width / this.myCan.scaleX / 2,this.myCan.height / this.myCan.scaleY / 2);
               _loc9_ = new Point(_loc6_.x,_loc6_.y - _loc5_ / 2);
               _loc11_ = new Point(_loc6_.x + _loc4_ / 2,_loc6_.y + _loc5_ / 2);
               _loc13_ = new Point(_loc6_.x - _loc4_ / 2,_loc6_.y + _loc5_ / 2);
               _loc10_ = new Point((_loc9_.x + _loc11_.x) / 2,(_loc9_.y + _loc11_.y) / 2);
               _loc12_ = new Point((_loc11_.x + _loc13_.x) / 2,(_loc11_.y + _loc13_.y) / 2);
               _loc14_ = new Point((_loc13_.x + _loc9_.x) / 2,(_loc13_.y + _loc9_.y) / 2);
               _loc27_ = new Array(_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_);
               _loc7_ = 0;
               while(_loc7_ < this.num_pt)
               {
                  _loc8_ = new MaskPoint();
                  this.pts[_loc7_] = _loc8_;
                  this.pts[_loc7_].x = Point(_loc27_[_loc7_]).x;
                  this.pts[_loc7_].y = Point(_loc27_[_loc7_]).y;
                  this.pointCan.addChild(_loc8_);
                  _loc8_.doubleClickEnabled = true;
                  _loc8_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
                  _loc8_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
                  _loc7_++;
               }
               this.borderCan.removeAllChildren();
               this.lineStyle = "line";
               break;
            case "hat":
               this.num_pt = 15;
               this.point_seperation_coef = 10;
               this.pts = new Array(this.num_pt);
               _loc9_ = new Point(314.9,287.5);
               _loc10_ = new Point(332.9,272.5);
               _loc11_ = new Point(338.5,258.5);
               _loc12_ = new Point(342,241.5);
               _loc13_ = new Point(338,239.5);
               _loc14_ = new Point(338.4,218.5);
               _loc15_ = new Point(317.9,192.5);
               _loc16_ = new Point(293.9,194.5);
               _loc17_ = new Point(271.4,214.5);
               _loc18_ = new Point(275,227.5);
               _loc19_ = new Point(265.4,236.5);
               _loc20_ = new Point(267.9,246.5);
               _loc21_ = new Point(280.9,245.5);
               _loc22_ = new Point(281.9,261);
               _loc23_ = new Point(296,284.5);
               _loc26_ = -27;
               _loc27_ = new Array(_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_);
               _loc7_ = 0;
               while(_loc7_ < this.num_pt)
               {
                  _loc8_ = new MaskPoint();
                  this.pts[_loc7_] = _loc8_;
                  this.pts[_loc7_].x = Point(_loc27_[_loc7_]).x;
                  this.pts[_loc7_].y = Point(_loc27_[_loc7_]).y + _loc26_;
                  this.pointCan.addChild(_loc8_);
                  _loc8_.doubleClickEnabled = true;
                  _loc8_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
                  _loc8_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
                  _loc7_++;
               }
               this.borderCan.removeAllChildren();
               this.lineStyle = "curve";
               break;
            case "women":
               this.num_pt = 17;
               this.point_seperation_coef = 10;
               this.pts = new Array(this.num_pt);
               _loc9_ = new Point(304.9,284.5);
               _loc10_ = new Point(311.4,284.5);
               _loc11_ = new Point(324.9,273.5);
               _loc12_ = new Point(326.9,290);
               _loc13_ = new Point(349,293);
               _loc14_ = new Point(352.5,276.5);
               _loc15_ = new Point(345.5,261);
               _loc16_ = new Point(337.9,214);
               _loc17_ = new Point(319.9,193);
               _loc18_ = new Point(291.4,193);
               _loc19_ = new Point(269,213.5);
               _loc20_ = new Point(260.9,250.5);
               _loc21_ = new Point(254.9,273.5);
               _loc22_ = new Point(258.4,291);
               _loc23_ = new Point(281.9,289.5);
               _loc24_ = new Point(287.5,276.5);
               _loc25_ = new Point(298.4,284);
               _loc26_ = -27;
               _loc27_ = new Array(_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_,_loc24_,_loc25_);
               _loc7_ = 0;
               while(_loc7_ < this.num_pt)
               {
                  _loc8_ = new MaskPoint();
                  this.pts[_loc7_] = _loc8_;
                  this.pts[_loc7_].x = Point(_loc27_[_loc7_]).x;
                  this.pts[_loc7_].y = Point(_loc27_[_loc7_]).y + _loc26_;
                  this.pointCan.addChild(_loc8_);
                  _loc8_.doubleClickEnabled = true;
                  _loc8_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
                  _loc8_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
                  _loc7_++;
               }
               this.borderCan.removeAllChildren();
               this.lineStyle = "curve";
               break;
            case "men":
               this.num_pt = 17;
               this.point_seperation_coef = 10;
               this.pts = new Array(this.num_pt);
               _loc9_ = new Point(304.9,284.5);
               _loc10_ = new Point(311.4,284.5);
               _loc11_ = new Point(326.4,266.5);
               _loc12_ = new Point(328.9,252.5);
               _loc13_ = new Point(337.4,246.5);
               _loc14_ = new Point(337.4,230);
               _loc15_ = new Point(333.9,230.5);
               _loc16_ = new Point(332.5,212);
               _loc17_ = new Point(319.4,194.5);
               _loc18_ = new Point(290.9,193.5);
               _loc19_ = new Point(273.5,213);
               _loc20_ = new Point(274.9,235.5);
               _loc21_ = new Point(269.9,236);
               _loc22_ = new Point(274.4,255);
               _loc23_ = new Point(278.4,253.5);
               _loc24_ = new Point(281.9,264.5);
               _loc25_ = new Point(298.4,284);
               _loc26_ = -27;
               _loc27_ = new Array(_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,_loc20_,_loc21_,_loc22_,_loc23_,_loc24_,_loc25_);
               _loc7_ = 0;
               while(_loc7_ < this.num_pt)
               {
                  _loc8_ = new MaskPoint();
                  this.pts[_loc7_] = _loc8_;
                  this.pts[_loc7_].x = Point(_loc27_[_loc7_]).x;
                  this.pts[_loc7_].y = Point(_loc27_[_loc7_]).y + _loc26_;
                  this.pointCan.addChild(_loc8_);
                  _loc8_.doubleClickEnabled = true;
                  _loc8_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
                  _loc8_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
                  _loc7_++;
               }
               this.borderCan.removeAllChildren();
               this.lineStyle = "curve";
         }
         this.resizeMaskPoint();
      }
      
      [Bindable(event="propertyChange")]
      public function get pointCan() : Canvas
      {
         return this._466094112pointCan;
      }
      
      public function set _canRotateContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1067562475_canRotateContainer;
         if(_loc2_ !== param1)
         {
            this._1067562475_canRotateContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canRotateContainer",_loc2_,param1));
         }
      }
      
      public function get assetId() : Number
      {
         return this._assetId;
      }
      
      public function set btnUnCropImage(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._57826838btnUnCropImage;
         if(_loc2_ !== param1)
         {
            this._57826838btnUnCropImage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnUnCropImage",_loc2_,param1));
         }
      }
      
      public function __btnCancel_click(param1:MouseEvent) : void
      {
         this.cancel();
      }
      
      public function set shadowImage(param1:Image) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1584270309shadowImage;
         if(_loc2_ !== param1)
         {
            this._1584270309shadowImage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shadowImage",_loc2_,param1));
         }
      }
      
      public function set pointCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._466094112pointCan;
         if(_loc2_ !== param1)
         {
            this._466094112pointCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pointCan",_loc2_,param1));
         }
      }
      
      private function synShadowImage() : void
      {
         this.shadowImage.x = this.myImage.x;
         this.shadowImage.y = this.myImage.y;
         this.shadowImage.rotation = this.myImage.rotation;
         this.shadowImageCan.x = this.myImageCan.x;
         this.shadowImageCan.y = this.myImageCan.y;
         this.shadowImageCan.scaleX = this.myImageCan.scaleX;
         this.shadowImageCan.scaleY = this.myImageCan.scaleY;
         this.shadowImage.scaleX = this.myImage.scaleX;
         this.shadowImage.scaleY = this.myImage.scaleY;
         this.shadowImageCan.rotation = this.myImageCan.rotation;
      }
      
      public function set lineStyle(param1:String) : void
      {
         this._lineStyle = param1;
         this.drawBorder();
      }
      
      private function _MaskImage_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty1 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 160;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty1",this._MaskImage_SetProperty1);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bgCan() : Canvas
      {
         return this._1481556916_bgCan;
      }
      
      public function set assetId(param1:Number) : void
      {
         this._assetId = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnUnLockImage() : Button
      {
         return this._2128854107btnUnLockImage;
      }
      
      private function doDrag(param1:MouseEvent) : void
      {
         Console.getConsole().currentScene.dragEnter = true;
         var _loc2_:UIComponent = UIComponent(param1.currentTarget);
         var _loc3_:Object = new Object();
         _loc3_.target = _loc2_;
         var _loc4_:DragSource;
         (_loc4_ = new DragSource()).addData(_loc3_,"sourceObject");
         DragManager.doDrag(_loc2_,_loc4_,param1,null,0,0,0,true);
      }
      
      public function __lineType_itemClick(param1:ItemClickEvent) : void
      {
         this.switchLineStyle(param1);
      }
      
      private function flip(param1:String) : void
      {
         switch(param1)
         {
            case "x":
               this.myImage.scaleX = this.myImage.scaleX * -1;
               this.myImage.x = this.myImage.scaleX == 1?Number(-this._imageWidth / 2):Number(this._imageWidth / 2);
               this.myImageCan.rotation = -this.myImageCan.rotation;
               this._canRotate.rotation = this.myImageCan.rotation;
               this.synShadowImage();
               break;
            case "y":
               this.myImage.scaleY = this.myImage.scaleY * -1;
               this.myImage.y = this.myImage.scaleY == 1?Number(-this._imageHeight / 2):Number(this._imageHeight / 2);
               this.myImageCan.rotation = -this.myImageCan.rotation;
               this._canRotate.rotation = this.myImageCan.rotation;
               this.synShadowImage();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get hand() : Image
      {
         return this._3194991hand;
      }
      
      private function _MaskImage_Transition1_c() : Transition
      {
         var _loc1_:Transition = new Transition();
         _loc1_.fromState = "*";
         _loc1_.toState = "*";
         _loc1_.effect = this._MaskImage_Sequence1_i();
         return _loc1_;
      }
      
      private function _MaskImage_State3_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "theThirdStep";
         _loc1_.overrides = [this._MaskImage_SetProperty7_i(),this._MaskImage_SetProperty8_i(),this._MaskImage_SetProperty9_i()];
         return _loc1_;
      }
      
      private function _MaskImage_RadioButtonGroup1_i() : RadioButtonGroup
      {
         var _loc1_:RadioButtonGroup = new RadioButtonGroup();
         this.lineType = _loc1_;
         _loc1_.addEventListener("itemClick",this.__lineType_itemClick);
         _loc1_.initialized(this,"lineType");
         return _loc1_;
      }
      
      public function set refCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._934862275refCan;
         if(_loc2_ !== param1)
         {
            this._934862275refCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"refCan",_loc2_,param1));
         }
      }
      
      public function __btnUnLockImage_click(param1:MouseEvent) : void
      {
         this.goStep1();
      }
      
      [Bindable(event="propertyChange")]
      public function get _canWorkSpace() : Canvas
      {
         return this._1773154204_canWorkSpace;
      }
      
      public function set myImageCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._398777791myImageCan;
         if(_loc2_ !== param1)
         {
            this._398777791myImageCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myImageCan",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFlipX() : DoubleStateButton
      {
         return this._2085107855btnFlipX;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnFlipY() : DoubleStateButton
      {
         return this._2085107856btnFlipY;
      }
      
      public function set _bgCan(param1:Canvas) : void
      {
         var _loc2_:Object = this._1481556916_bgCan;
         if(_loc2_ !== param1)
         {
            this._1481556916_bgCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bgCan",_loc2_,param1));
         }
      }
      
      public function set t1(param1:Sequence) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3645t1;
         if(_loc2_ !== param1)
         {
            this._3645t1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"t1",_loc2_,param1));
         }
      }
      
      public function ___step1HBox2_creationComplete(param1:FlexEvent) : void
      {
         this.initPosition();
      }
      
      private function add() : void
      {
         var _loc1_:GoAlert = null;
         var _loc2_:Label = null;
         var _loc3_:Image = null;
         var _loc4_:BitmapData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Canvas = null;
         var _loc8_:Label = null;
         var _loc9_:Image = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:BitmapData = null;
         var _loc14_:Rectangle = null;
         var _loc15_:Matrix = null;
         var _loc16_:Canvas = null;
         if(this.cropImage)
         {
            this.save();
         }
         else
         {
            _loc1_ = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
            _loc1_.width = 600;
            _loc1_.height = 350;
            _loc1_._lblConfirm.text = UtilDict.toDisplay("go","goalert_confirmaddhead");
            _loc1_._txtDelete.text = "";
            _loc1_._btnDelete.label = UtilDict.toDisplay("go","goalert_add");
            _loc1_._btnDelete.addEventListener(MouseEvent.CLICK,this.skip);
            _loc2_ = new Label();
            _loc2_.text = UtilDict.toDisplay("go","goalert_addwholeimage");
            _loc2_.styleName = "textNormal";
            _loc1_._ans1Box.addChildAt(_loc2_,0);
            _loc3_ = new Image();
            (_loc4_ = new BitmapData(this._imageHeight,this._imageWidth)).draw(this.myImage);
            _loc3_.graphics.beginBitmapFill(_loc4_);
            _loc3_.graphics.drawRect(0,0,this._imageHeight,this._imageWidth);
            _loc3_.graphics.endFill();
            _loc5_ = 150 / this._imageHeight;
            _loc6_ = 150 / this._imageWidth;
            _loc3_.scaleX = _loc3_.scaleY = _loc5_ > _loc6_?Number(_loc5_):Number(_loc6_);
            (_loc7_ = new Canvas()).styleName = "imageBox";
            _loc7_.width = 300;
            _loc7_.height = 200;
            _loc7_.addChild(_loc3_);
            _loc3_.x = (_loc7_.width - this._imageWidth * _loc6_) / 2;
            _loc1_._ans1Box.addChildAt(_loc7_,1);
            _loc1_._btnCancel.label = UtilDict.toDisplay("go","goalert_add");
            _loc1_._btnCancel.addEventListener(MouseEvent.CLICK,this.save);
            (_loc8_ = new Label()).text = UtilDict.toDisplay("go","goalert_addcropimage");
            _loc8_.styleName = "textNormal";
            _loc1_._ans2Box.addChildAt(_loc8_,0);
            _loc9_ = new Image();
            _loc10_ = 0;
            while(_loc10_ < this.num_pt)
            {
               this.pts[_loc10_].visible = false;
               _loc10_++;
            }
            this.maskArray[1].visible = false;
            _loc11_ = this._maxx - this._minx;
            _loc12_ = this._maxy - this._miny;
            _loc13_ = new BitmapData(_loc11_,_loc12_,true,0);
            _loc14_ = new Rectangle(0,0,_loc11_,_loc12_);
            this.refCan.visible = false;
            this.shadowImageCan.visible = false;
            _loc15_ = new Matrix(1,0,0,1,-this._minx,-this._miny);
            _loc13_.draw(this.myCan,_loc15_,null,null,_loc14_,true);
            _loc9_.graphics.beginBitmapFill(_loc13_);
            _loc9_.graphics.drawRect(0,0,_loc11_,_loc12_);
            _loc9_.graphics.endFill();
            _loc5_ = 150 / _loc11_;
            if((_loc6_ = 150 / _loc12_) < 1 && _loc5_ < 1)
            {
               _loc9_.scaleX = _loc9_.scaleY = _loc5_ > _loc6_?Number(_loc5_):Number(_loc6_);
            }
            (_loc16_ = new Canvas()).width = 300;
            _loc16_.height = 200;
            _loc16_.addChild(_loc9_);
            _loc9_.x = (_loc16_.width - _loc11_ * _loc6_) / 2;
            _loc1_._ans2Box.addChildAt(_loc16_,1);
            _loc10_ = 0;
            while(_loc10_ < this.num_pt)
            {
               this.pts[_loc10_].visible = true;
               _loc10_++;
            }
            this.maskArray[1].visible = true;
            this.refCan.visible = true;
            this.shadowImageCan.visible = true;
            _loc1_.x = (_loc1_.stage.width - _loc1_.width) / 2;
            _loc1_.y = 100;
         }
      }
      
      public function ___btnCurved_creationComplete(param1:FlexEvent) : void
      {
         this.drawRadioBg(param1);
      }
      
      public function set _canStep1(param1:Canvas) : void
      {
         var _loc2_:Object = this._46991788_canStep1;
         if(_loc2_ !== param1)
         {
            this._46991788_canStep1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canStep1",_loc2_,param1));
         }
      }
      
      private function drawBg(param1:Event) : void
      {
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         var _loc3_:String = GradientType.LINEAR;
         var _loc4_:Array = [16777215,14474460];
         var _loc5_:Array = [1,1];
         var _loc6_:Array = [0,255];
         var _loc7_:Matrix;
         (_loc7_ = new Matrix()).createGradientBox(this.width,this.height,Math.PI / 2,0,0);
         var _loc8_:String = SpreadMethod.PAD;
         _loc2_.graphics.lineStyle(0,0,0);
         _loc2_.graphics.beginGradientFill(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc8_);
         _loc2_.graphics.drawRoundRect(0,0,this.width,this.height,10,10);
         _loc2_.graphics.endFill();
      }
      
      public function get cropImage() : Boolean
      {
         return this._cropImage;
      }
      
      public function set _canStep3(param1:Canvas) : void
      {
         var _loc2_:Object = this._46991786_canStep3;
         if(_loc2_ !== param1)
         {
            this._46991786_canStep3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canStep3",_loc2_,param1));
         }
      }
      
      public function set _canStep2(param1:Canvas) : void
      {
         var _loc2_:Object = this._46991787_canStep2;
         if(_loc2_ !== param1)
         {
            this._46991787_canStep2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canStep2",_loc2_,param1));
         }
      }
      
      private function showCursor(param1:Event = null) : void
      {
         CursorManager.setCursor(this.customCursor,CursorManagerPriority.HIGH,3,2);
      }
      
      private function _MaskImage_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "theSecondStep";
         _loc1_.overrides = [this._MaskImage_SetProperty4_i(),this._MaskImage_SetProperty5_i(),this._MaskImage_SetProperty6_i()];
         return _loc1_;
      }
      
      public function set btnUnLockImage(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._2128854107btnUnLockImage;
         if(_loc2_ !== param1)
         {
            this._2128854107btnUnLockImage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnUnLockImage",_loc2_,param1));
         }
      }
      
      public function __myBackgroundCan_creationComplete(param1:FlexEvent) : void
      {
         this.drawBackground();
      }
      
      public function set _canWorkSpace(param1:Canvas) : void
      {
         var _loc2_:Object = this._1773154204_canWorkSpace;
         if(_loc2_ !== param1)
         {
            this._1773154204_canWorkSpace = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canWorkSpace",_loc2_,param1));
         }
      }
      
      public function set hand(param1:Image) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._3194991hand;
         if(_loc2_ !== param1)
         {
            this._3194991hand = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hand",_loc2_,param1));
         }
      }
      
      public function ___btnStraight_creationComplete(param1:FlexEvent) : void
      {
         this.drawRadioBg(param1);
      }
      
      private function setScaleBar(param1:Number) : void
      {
         if(!this.lockImage)
         {
            this.SldScale.value = this.SldScale.value + param1;
            this.changeSize();
         }
      }
      
      public function ___bgCan_creationComplete(param1:FlexEvent) : void
      {
         this.drawBg(param1);
      }
      
      private function _MaskImage_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "theFirstStep";
         _loc1_.overrides = [this._MaskImage_SetProperty1_i(),this._MaskImage_SetProperty2_i(),this._MaskImage_SetProperty3_i()];
         return _loc1_;
      }
      
      public function __btnFlipY_click(param1:MouseEvent) : void
      {
         this.flip("y");
      }
      
      private function removeCursor(param1:Event = null) : void
      {
         CursorManager.removeAllCursors();
      }
      
      private function setTip(param1:Button, param2:Boolean = true) : void
      {
         var _loc3_:String = "";
         if(param1 == this._tip1)
         {
            _loc3_ = UtilDict.toDisplay("go","cropper_tip1");
         }
         else if(param1 == this._tip2)
         {
            _loc3_ = UtilDict.toDisplay("go","cropper_tip2");
         }
         else if(param1 == this._tip3)
         {
            _loc3_ = UtilDict.toDisplay("go","cropper_tip3");
         }
         if(param2)
         {
            param1.visible = true;
            param1.toolTip = _loc3_;
            param1.buttonMode = true;
            param1.useHandCursor = true;
            param1.mouseEnabled = true;
         }
         else
         {
            param1.visible = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get myImageBackgroundCan() : Canvas
      {
         return this._1238661901myImageBackgroundCan;
      }
      
      public function __scaleDownBtn_buttonDown(param1:FlexEvent) : void
      {
         this.setScaleBar(-5);
      }
      
      public function set myCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._104336004myCan;
         if(_loc2_ !== param1)
         {
            this._104336004myCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myCan",_loc2_,param1));
         }
      }
      
      public function __SldScale_change(param1:SliderEvent) : void
      {
         this.changeSize();
      }
      
      public function set btnFlipX(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._2085107855btnFlipX;
         if(_loc2_ !== param1)
         {
            this._2085107855btnFlipX = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFlipX",_loc2_,param1));
         }
      }
      
      private function changeRotate() : void
      {
         if(!this.lockImage)
         {
            this.myImageCan.rotation = this._canRotate.rotation;
            this.synShadowImage();
         }
      }
      
      private function initAppControl(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Button = null;
         var _loc2_:Canvas = Canvas(param1.currentTarget);
         var _loc5_:Point = new Point(_loc2_.width / 2,_loc2_.height / 2);
         (_loc4_ = new Button()).buttonMode = true;
         _loc4_.styleName = "btnCropperArrow";
         _loc4_.width = 22;
         _loc4_.height = 55;
         _loc4_.x = _loc2_.width - _loc4_.width * 1.3;
         _loc4_.y = _loc5_.y - _loc4_.height / 2;
         _loc4_.scaleX = -1;
         _loc4_.data = new Array(-5,0);
         _loc4_.addEventListener(MouseEvent.CLICK,this.doMoveImage);
         _loc2_.addChild(_loc4_);
         (_loc4_ = new Button()).buttonMode = true;
         _loc4_.styleName = "btnCropperArrow";
         _loc4_.width = 22;
         _loc4_.height = 55;
         _loc4_.rotation = 90;
         _loc4_.x = _loc5_.x + _loc4_.height / 2;
         _loc4_.y = _loc2_.height - _loc4_.width;
         _loc4_.scaleX = -1;
         _loc4_.data = new Array(0,-5);
         _loc4_.addEventListener(MouseEvent.CLICK,this.doMoveImage);
         _loc2_.addChild(_loc4_);
         (_loc4_ = new Button()).buttonMode = true;
         _loc4_.styleName = "btnCropperArrow";
         _loc4_.width = 22;
         _loc4_.height = 55;
         _loc4_.rotation = 180;
         _loc4_.x = _loc4_.width;
         _loc4_.y = _loc5_.y + _loc4_.height / 2;
         _loc4_.scaleX = -1;
         _loc4_.data = new Array(5,0);
         _loc4_.addEventListener(MouseEvent.CLICK,this.doMoveImage);
         _loc2_.addChild(_loc4_);
         (_loc4_ = new Button()).buttonMode = true;
         _loc4_.styleName = "btnCropperArrow";
         _loc4_.width = 22;
         _loc4_.height = 55;
         _loc4_.rotation = 270;
         _loc4_.x = _loc5_.x - _loc4_.height / 2;
         _loc4_.y = _loc4_.width;
         _loc4_.scaleX = -1;
         _loc4_.data = new Array(0,5);
         _loc4_.addEventListener(MouseEvent.CLICK,this.doMoveImage);
         _loc2_.addChild(_loc4_);
      }
      
      public function set scaleUpBtn(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1914892951scaleUpBtn;
         if(_loc2_ !== param1)
         {
            this._1914892951scaleUpBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scaleUpBtn",_loc2_,param1));
         }
      }
      
      public function set btnFlipY(param1:DoubleStateButton) : void
      {
         var _loc2_:Object = this._2085107856btnFlipY;
         if(_loc2_ !== param1)
         {
            this._2085107856btnFlipY = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnFlipY",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnExport() : Button
      {
         return this._196495664btnExport;
      }
      
      private function _MaskImage_Move1_c() : Move
      {
         var _loc1_:Move = new Move();
         _loc1_.duration = 500;
         return _loc1_;
      }
      
      public function set holdable(param1:Boolean) : void
      {
         var _loc2_:Button = null;
         var _loc3_:Button = null;
         var _loc4_:Button = null;
         this._holdable = param1;
         if(param1)
         {
            this._txtDefShape.text = UtilDict.toDisplay("go","cropper_objshape");
            _loc2_ = new Button();
            _loc2_.styleName = "btnCropperHandShapeRect";
            _loc2_.buttonMode = true;
            _loc2_.data = "rectangle";
            _loc2_.addEventListener(MouseEvent.CLICK,this.chgShape);
            this._hboxShape.addChild(_loc2_);
            _loc3_ = new Button();
            _loc3_.styleName = "btnCropperHandShapeRound";
            _loc3_.buttonMode = true;
            _loc3_.data = "round";
            _loc3_.addEventListener(MouseEvent.CLICK,this.chgShape);
            this._hboxShape.addChild(_loc3_);
            (_loc4_ = new Button()).styleName = "btnCropperHandShapeTri";
            _loc4_.buttonMode = true;
            _loc4_.data = "triangle";
            _loc4_.addEventListener(MouseEvent.CLICK,this.chgShape);
            this._hboxShape.addChild(_loc4_);
         }
      }
      
      private function drawArrow(param1:Canvas, param2:Number = 0, param3:uint = 5144765) : void
      {
         var _loc4_:Number = 60;
         var _loc5_:Number = 20;
         param1.width = 260;
         param1.height = 20;
         param1.graphics.clear();
         param1.graphics.lineStyle(4,16777215,1);
         param1.graphics.beginFill(param3,1);
         var _loc6_:Point = new Point(param1.width / 2,param1.height / 2);
         if(param2 == 0)
         {
            param1.graphics.moveTo(_loc6_.x - _loc4_ / 2,_loc6_.y - _loc5_ / 2);
            param1.graphics.lineTo(_loc6_.x + _loc4_ / 2,_loc6_.y - _loc5_ / 2);
            param1.graphics.lineTo(_loc6_.x,_loc6_.y + _loc5_ / 2);
            param1.graphics.lineTo(_loc6_.x - _loc4_ / 2,_loc6_.y - _loc5_ / 2);
         }
         else if(param2 == 1)
         {
            param1.graphics.moveTo(_loc6_.x - _loc4_ / 2,_loc6_.y + _loc5_ / 2);
            param1.graphics.lineTo(_loc6_.x + _loc4_ / 2,_loc6_.y + _loc5_ / 2);
            param1.graphics.lineTo(_loc6_.x,_loc6_.y - _loc5_ / 2);
            param1.graphics.lineTo(_loc6_.x - _loc4_ / 2,_loc6_.y + _loc5_ / 2);
         }
         if(param1 == this._canGap12)
         {
            if(param2 == 1)
            {
               this.btnUnLockImage.visible = true;
            }
            else
            {
               this.btnUnLockImage.visible = false;
            }
         }
         if(param1 == this._canGap23)
         {
            if(param2 == 1)
            {
               this.btnUnCropImage.visible = true;
            }
            else
            {
               this.btnUnCropImage.visible = false;
            }
         }
         param1.graphics.endFill();
      }
      
      private function _MaskImage_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._canStep1;
         _loc1_ = this._canStep2;
         _loc1_ = this._canStep3;
         _loc1_ = this._canStep1;
         _loc1_ = this._canStep2;
         _loc1_ = this._canStep3;
         _loc1_ = this._canStep1;
         _loc1_ = this._canStep2;
         _loc1_ = this._canStep3;
         _loc1_ = [this._canStep1,this._canStep2,this._canStep3];
         _loc1_ = [new GlowFilter(13421772)];
         _loc1_ = UtilDict.toDisplay("go","cropper_posimage");
         _loc1_ = UtilDict.toDisplay("go","cropper_size");
         _loc1_ = UtilDict.toDisplay("go","cropper_rotate");
         _loc1_ = UtilDict.toDisplay("go","cropper_flip");
         _loc1_ = UtilDict.toDisplay("go","cropper_fixpos");
         _loc1_ = [new GlowFilter(13421772)];
         _loc1_ = UtilDict.toDisplay("go","cropper_changepos");
         _loc1_ = [new GlowFilter(13421772)];
         _loc1_ = UtilDict.toDisplay("go","cropper_adjustcrop");
         _loc1_ = UtilDict.toDisplay("go","cropper_curve");
         _loc1_ = UtilDict.toDisplay("go","cropper_straight");
         _loc1_ = [new GlowFilter(13421772)];
         _loc1_ = UtilDict.toDisplay("go","cropper_modcrop");
         _loc1_ = [new GlowFilter(13421772)];
         _loc1_ = UtilDict.toDisplay("go","cropper_addmystuff");
         _loc1_ = UtilDict.toDisplay("go","cropper_readyimport");
         _loc1_ = UtilDict.toDisplay("go","cropper_addmystuff");
         _loc1_ = new Rectangle(0,0,610,490);
         _loc1_ = UtilDict.toDisplay("go","cropper_skip");
         _loc1_ = UtilDict.toDisplay("go","cropper_cancel");
      }
      
      private function switchLineStyle(param1:Event = null) : void
      {
         var _loc2_:String = param1.currentTarget.selectedValue;
         this.lineStyle = _loc2_ == "curved"?"curve":"line";
      }
      
      public function set _step2HBox2(param1:HBox) : void
      {
         var _loc2_:Object = this._1495814488_step2HBox2;
         if(_loc2_ !== param1)
         {
            this._1495814488_step2HBox2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step2HBox2",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCurved() : RadioButton
      {
         return this._1352381102_btnCurved;
      }
      
      public function set cropImage(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         this._cropImage = param1;
         this.btnCropImage.label = !!param1?UtilDict.toDisplay("go","cropper_undocrop"):UtilDict.toDisplay("go","cropper_crop");
         this.shadowImageCan.visible = !!param1?false:true;
         this.borderCan.visible = !!param1?false:true;
         this.pointCan.visible = !!param1?false:true;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < this._hboxShape.numChildren)
            {
               if(this._hboxShape.getChildAt(_loc2_) is Button)
               {
                  Button(this._hboxShape.getChildAt(_loc2_)).enabled = false;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < this._hboxShape.numChildren)
            {
               if(this._hboxShape.getChildAt(_loc2_) is Button)
               {
                  Button(this._hboxShape.getChildAt(_loc2_)).enabled = true;
               }
               _loc2_++;
            }
         }
         if(param1)
         {
            this.goStep3();
         }
      }
      
      public function set _step2HBox3(param1:HBox) : void
      {
         var _loc2_:Object = this._1495814487_step2HBox3;
         if(_loc2_ !== param1)
         {
            this._1495814487_step2HBox3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step2HBox3",_loc2_,param1));
         }
      }
      
      public function __btnLockImage_click(param1:MouseEvent) : void
      {
         this.switchLockImage();
      }
      
      [Bindable(event="propertyChange")]
      public function get lineType() : RadioButtonGroup
      {
         return this._1188665678lineType;
      }
      
      public function ___canAppControl_creationComplete(param1:FlexEvent) : void
      {
         this.initAppControl(param1);
      }
      
      public function __myCan_creationComplete(param1:FlexEvent) : void
      {
         this.drawTransBackground();
      }
      
      [Bindable(event="propertyChange")]
      public function get myBackgroundCan() : Canvas
      {
         return this._1023330954myBackgroundCan;
      }
      
      public function save(param1:Event = null) : void
      {
         var _loc11_:URLRequest = null;
         Console.getConsole().requestLoadStatus(true,true);
         var _loc2_:Number = 0;
         while(_loc2_ < this.num_pt)
         {
            this.pts[_loc2_].visible = false;
            _loc2_++;
         }
         this.maskArray[1].visible = false;
         var _loc3_:Number = this._maxx - this._minx;
         var _loc4_:Number = this._maxy - this._miny;
         var _loc5_:BitmapData = new BitmapData(_loc3_,_loc4_,true,0);
         var _loc6_:Rectangle = new Rectangle(0,0,_loc3_,_loc4_);
         this.refCan.visible = false;
         this.shadowImageCan.visible = false;
         var _loc7_:Matrix = new Matrix(1,0,0,1,-this._minx,-this._miny);
         _loc5_.draw(this.myCan,_loc7_,null,null,_loc6_,true);
         var _loc8_:PNGEncoder;
         var _loc9_:ByteArray = (_loc8_ = new PNGEncoder()).encode(_loc5_);
         var _loc10_:Base64Encoder;
         (_loc10_ = new Base64Encoder()).encodeBytes(_loc9_);
         var _loc12_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc12_);
         _loc11_ = new URLRequest(ServerConstants.ACTION_UPDATE_PROP);
         _loc12_[ServerConstants.PARAM_ASSET_ID] = this.assetId;
         _loc12_["shiftx"] = -1 * (this.refCan.x - this._minx);
         _loc12_["shifty"] = -1 * (this.refCan.y - 30 - this._miny);
         _loc12_["imageData"] = _loc10_.flush();
         _loc11_.data = _loc12_;
         _loc11_.method = URLRequestMethod.POST;
         var _loc13_:URLStream;
         (_loc13_ = new URLStream()).addEventListener(Event.COMPLETE,this.onUploadCustomAssetCompleteData);
         _loc13_.addEventListener(IOErrorEvent.IO_ERROR,this.onUploadCustomAssetCompleteData);
         _loc13_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onUploadCustomAssetCompleteData);
         _loc13_.load(_loc11_);
      }
      
      private function skip(param1:Event = null) : void
      {
         PopUpManager.removePopUp(this);
         Console.getConsole().currentScene.playScene();
         Console.getConsole().changeTempPropName();
      }
      
      private function drawBackground() : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc1_:Number = 10;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < this.myBackgroundCan.height)
         {
            _loc3_ = 0;
            _loc7_ = 0;
            while(_loc7_ < this.myBackgroundCan.width)
            {
               _loc8_ = 0;
               _loc8_ = _loc3_ % 2 == 0 && _loc2_ % 2 == 0 || _loc2_ % 2 != 0 && _loc3_ % 2 == 1?uint(14540253):uint(16777215);
               this.myBackgroundCan.graphics.beginFill(_loc8_,1);
               this.myBackgroundCan.graphics.drawRect(_loc3_ * _loc1_,_loc2_ * _loc1_,_loc1_,_loc1_);
               this.myBackgroundCan.graphics.endFill();
               _loc3_++;
               _loc7_ = _loc7_ + _loc1_;
            }
            _loc2_++;
            _loc4_ = _loc4_ + _loc1_;
         }
         var _loc5_:GlowFilter = new GlowFilter(5144765,1,10,10,10,1);
         var _loc6_:Array;
         (_loc6_ = new Array()).push(_loc5_);
         this.myBackgroundCan.filters = _loc6_;
         this.myBackgroundCan.cacheAsBitmap = true;
      }
      
      public function ___MaskImage_TitleWindow1_mouseUp(param1:MouseEvent) : void
      {
         this.stopMoveImage(param1);
      }
      
      private function initHand() : void
      {
         this.hand.x = -22;
         this.hand.y = -13;
         this.body.x = -39;
         this.body.y = -66;
         this.refCan.x = this.myCan.width / 2;
         this.refCan.y = 490 / 2 + 40;
         if(this._headable)
         {
            this.refCan.y = this.refCan.y - 4;
         }
         else if(this._holdable)
         {
            this.refCan.y = this.refCan.y - 40;
            this.refCan.x = this.refCan.x + 20;
         }
         this.refCan.cacheAsBitmap = true;
         this.scaleMyCan(true);
      }
      
      [Bindable(event="propertyChange")]
      public function get body() : Image
      {
         return this._3029410body;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnCropImage() : Button
      {
         return this._613032367btnCropImage;
      }
      
      public function __btnFlipX_click(param1:MouseEvent) : void
      {
         this.flip("x");
      }
      
      private function doDragEnter(param1:DragEvent) : void
      {
         DragManager.acceptDragDrop(UIComponent(param1.currentTarget));
      }
      
      public function __scaleUpBtn_buttonDown(param1:FlexEvent) : void
      {
         this.setScaleBar(5);
      }
      
      [Bindable(event="propertyChange")]
      public function get scaleDownBtn() : Button
      {
         return this._216437328scaleDownBtn;
      }
      
      public function set placeable(param1:Boolean) : void
      {
         this._placeable = param1;
         if(!this._holdable && !this._headable)
         {
            this._txtDefShape.text = "";
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get shadowImageCan() : Canvas
      {
         return this._398907829shadowImageCan;
      }
      
      public function startMoveImage(param1:MouseEvent) : void
      {
         if(!this.lockImage)
         {
            this.dragging = true;
            this.myImageCan.startDrag();
            this.myImageCan.addEventListener(Event.ENTER_FRAME,this.moveImage);
         }
      }
      
      public function set _canGap12(param1:Canvas) : void
      {
         var _loc2_:Object = this._58631450_canGap12;
         if(_loc2_ !== param1)
         {
            this._58631450_canGap12 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canGap12",_loc2_,param1));
         }
      }
      
      public function __btnExport_click(param1:MouseEvent) : void
      {
         this.add();
      }
      
      public function set lockImage(param1:Boolean) : void
      {
         this._lockImage = param1;
         this.btnLockImage.label = !!param1?UtilDict.toDisplay("go","cropper_changepos"):UtilDict.toDisplay("go","cropper_fixpos");
         this.SldScale.enabled = !this._lockImage;
         this.btnFlipX.enableBut1(!this._lockImage);
         this.btnFlipX.enableBut2(!this._lockImage);
         this.btnFlipY.enableBut1(!this._lockImage);
         this.btnFlipY.enableBut2(!this._lockImage);
         this._canAppControl.visible = !!param1?false:true;
         this.scaleUpBtn.enabled = this.scaleDownBtn.enabled = !this._lockImage;
         this.enablingRotate(!param1);
         if(param1)
         {
            this.goStep2();
            this.handleDragEventListenter(this.myImageCan,0);
            this.handleDragEventListenter(this.shadowImageCan,0);
         }
         else
         {
            this.handleDragEventListenter(this.myImageCan);
            this.handleDragEventListenter(this.shadowImageCan);
         }
      }
      
      public function set myImageBackgroundCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1238661901myImageBackgroundCan;
         if(_loc2_ !== param1)
         {
            this._1238661901myImageBackgroundCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myImageBackgroundCan",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canAppControl() : Canvas
      {
         return this._443042323_canAppControl;
      }
      
      [Bindable(event="propertyChange")]
      public function get appCan() : Canvas
      {
         return this._1411101201appCan;
      }
      
      private function doPressRotate(param1:Event) : void
      {
         this._currDraggingSprite = Sprite(param1.currentTarget);
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSkip() : Label
      {
         return this._206195195btnSkip;
      }
      
      public function set SldScale(param1:HSlider) : void
      {
         var _loc2_:Object = this._1366867201SldScale;
         if(_loc2_ !== param1)
         {
            this._1366867201SldScale = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"SldScale",_loc2_,param1));
         }
      }
      
      public function __btnUnCropImage_click(param1:MouseEvent) : void
      {
         this.goStep2();
      }
      
      public function ___canRotateContainer_creationComplete(param1:FlexEvent) : void
      {
         this.initRotate();
      }
      
      [Bindable(event="propertyChange")]
      public function get _step1HBox1() : HBox
      {
         return this._1524443640_step1HBox1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _step1HBox2() : HBox
      {
         return this._1524443639_step1HBox2;
      }
      
      [Bindable(event="propertyChange")]
      public function get _step1HBox3() : HBox
      {
         return this._1524443638_step1HBox3;
      }
      
      public function set _canGap23(param1:Canvas) : void
      {
         var _loc2_:Object = this._58631418_canGap23;
         if(_loc2_ !== param1)
         {
            this._58631418_canGap23 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canGap23",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canRotateContainer() : Canvas
      {
         return this._1067562475_canRotateContainer;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnUnCropImage() : Button
      {
         return this._57826838btnUnCropImage;
      }
      
      private function createNewDragPoint(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc4_:MaskPoint = new MaskPoint();
         switch(this._lineStyle)
         {
            case "line":
               _loc5_ = param3 % this.num_pt;
               break;
            case "curve":
               _loc5_ = (param3 + 2) % this.num_pt;
         }
         this.pts.splice(_loc5_,0,_loc4_);
         this.pts[_loc5_].x = param1;
         this.pts[_loc5_].y = param2;
         this.pointCan.addChild(_loc4_);
         _loc4_.doubleClickEnabled = true;
         _loc4_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteDragPoint);
         _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawBorder);
         this.num_pt = this.pts.length;
         this.drawBorder();
         this.resizeMaskPoint();
      }
      
      private function handleDragEventListenter(param1:Canvas, param2:Number = 1) : void
      {
         if(param2)
         {
            param1.buttonMode = true;
            param1.addEventListener(MouseEvent.ROLL_OVER,this.showCursor);
            param1.addEventListener(MouseEvent.ROLL_OUT,this.removeCursor);
            param1.addEventListener(MouseEvent.MOUSE_DOWN,this.startMoveImage);
            param1.addEventListener(MouseEvent.MOUSE_UP,this.stopMoveImage);
         }
         else
         {
            param1.buttonMode = false;
            param1.removeEventListener(MouseEvent.ROLL_OVER,this.showCursor);
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.removeCursor);
            param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.startMoveImage);
            param1.removeEventListener(MouseEvent.MOUSE_UP,this.stopMoveImage);
         }
      }
      
      public function get lineStyle() : String
      {
         return this._lineStyle;
      }
      
      private function switchLockImage() : void
      {
         this.lockImage = !!this.lockImage?false:true;
      }
      
      public function set myImage(param1:Image) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1488541455myImage;
         if(_loc2_ !== param1)
         {
            this._1488541455myImage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myImage",_loc2_,param1));
         }
      }
      
      public function stopMoveImage(param1:MouseEvent) : void
      {
         this.dragging = false;
         this.shadowImageCan.stopDrag();
         this.synShadowImage();
         this.myImageCan.removeEventListener(Event.ENTER_FRAME,this.moveImage);
      }
      
      private function doDrop(param1:MouseEvent) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get refCan() : Canvas
      {
         return this._934862275refCan;
      }
      
      [Bindable(event="propertyChange")]
      public function get myImageCan() : Canvas
      {
         return this._398777791myImageCan;
      }
      
      private function _MaskImage_SetProperty9_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty9 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 160;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty9",this._MaskImage_SetProperty9);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get t1() : Sequence
      {
         return this._3645t1;
      }
      
      private function showPoints(param1:Event) : void
      {
         var _loc2_:String = "";
         var _loc3_:Number = 0;
         while(_loc3_ < this.num_pt)
         {
            _loc2_ = _loc2_ + ("var pt" + (_loc3_ + 1) + ":Point = new Point(" + Util.roundNum(this.pts[_loc3_].x) + "," + Util.roundNum(this.pts[_loc3_].y) + ");\n");
            _loc3_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canStep1() : Canvas
      {
         return this._46991788_canStep1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canStep3() : Canvas
      {
         return this._46991786_canStep3;
      }
      
      private function initPosition() : void
      {
         this.btnFlipX.but1StyleName = "btnCropperFlip";
         this.btnFlipX.but2StyleName = "btnCropperFlipDown";
         this.btnFlipY.but1StyleName = "btnCropperFlip";
         this.btnFlipY.but2StyleName = "btnCropperFlipDown";
         this.btnFlipY.rotation = 90;
         this.btnFlipY.x = this.btnFlipY.x + (this.btnFlipY.height + 10);
      }
      
      [Bindable(event="propertyChange")]
      public function get _canStep2() : Canvas
      {
         return this._46991787_canStep2;
      }
      
      public function set btnExport(param1:Button) : void
      {
         var _loc2_:Object = this._196495664btnExport;
         if(_loc2_ !== param1)
         {
            this._196495664btnExport = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnExport",_loc2_,param1));
         }
      }
      
      public function __btnSkip_click(param1:MouseEvent) : void
      {
         this.skip();
      }
      
      public function set headable(param1:Boolean) : void
      {
         var _loc2_:Button = null;
         var _loc3_:Button = null;
         var _loc4_:Button = null;
         this._headable = param1;
         if(param1)
         {
            this._txtDefShape.text = UtilDict.toDisplay("go","cropper_faceshape");
            _loc2_ = new Button();
            _loc2_.styleName = "btnCropperHeadShapeMen";
            _loc2_.buttonMode = true;
            _loc2_.data = "men";
            _loc2_.addEventListener(MouseEvent.CLICK,this.chgShape);
            this._hboxShape.addChild(_loc2_);
            _loc3_ = new Button();
            _loc3_.styleName = "btnCropperHeadShapeWomen";
            _loc3_.buttonMode = true;
            _loc3_.data = "women";
            _loc3_.addEventListener(MouseEvent.CLICK,this.chgShape);
            this._hboxShape.addChild(_loc3_);
            (_loc4_ = new Button()).styleName = "btnCropperHeadShapeHat";
            _loc4_.buttonMode = true;
            _loc4_.data = "hat";
            _loc4_.addEventListener(MouseEvent.CLICK,this.chgShape);
            this._hboxShape.addChild(_loc4_);
         }
      }
      
      private function cancel(param1:Event = null) : void
      {
         Console.getConsole().deleteTempProp();
         PopUpManager.removePopUp(this);
         Console.getConsole().currentScene.playScene();
         Console.getConsole().changeTempPropName();
      }
      
      private function _MaskImage_SetProperty8_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty8 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 50;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty8",this._MaskImage_SetProperty8);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get myCan() : Canvas
      {
         return this._104336004myCan;
      }
      
      private function initRotate() : void
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Matrix = null;
         var _loc6_:String = null;
         if(this._canRotate != null)
         {
            this._canRotate.x = this._canRotate.y = 20;
            this._canRotate.graphics.lineStyle(4,5144765);
            this._canRotate.graphics.beginFill(16777215);
            this._canRotate.graphics.drawCircle(0,0,20);
            this._canRotate.graphics.lineStyle(2,5144765);
            this._canRotate.graphics.beginFill(5144765);
            this._canRotate.graphics.drawCircle(0,0,2);
            this._canRotate.graphics.moveTo(0,0);
            this._canRotate.graphics.lineTo(20,0);
            _loc1_ = GradientType.LINEAR;
            _loc2_ = [9749477,12442610];
            _loc3_ = [1,1];
            _loc4_ = [0,255];
            (_loc5_ = new Matrix()).createGradientBox(8,8,Math.PI / 2,0,0);
            _loc6_ = SpreadMethod.PAD;
            this._canRotate.graphics.beginGradientFill(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
            this._canRotate.graphics.drawCircle(16,0,4);
            this._canRotate.graphics.endFill();
            this._canRotate.buttonMode = true;
            this._canRotate.useHandCursor = true;
            this._canRotate.addEventListener(MouseEvent.MOUSE_DOWN,this.doPressRotate);
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
            stage.addEventListener(KeyboardEvent.KEY_UP,this.showPoints);
         }
      }
      
      private function locScrollBars(param1:Number, param2:Number) : void
      {
      }
      
      public function drawBorder(param1:Event = null) : void
      {
         var _loc2_:UIComponent = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         var _loc15_:Point = null;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:UIComponent = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         if(this.borderCan.getChildByName("myBorder") != null)
         {
            this.borderCan.removeChild(this.borderCan.getChildByName("myBorder"));
         }
         if(this.maskArray[1] != null)
         {
            this.maskArray[1].graphics.clear();
            this.maskArray[1] = null;
         }
         if(_loc2_ == null)
         {
            _loc2_ = new UIComponent();
         }
         _loc2_.graphics.lineStyle(0.5,26163);
         switch(this._lineStyle)
         {
            case "curve":
               _loc9_ = new Point();
               _loc10_ = new Point();
               _loc11_ = new Point();
               _loc12_ = new Point();
               _loc13_ = new Point();
               _loc14_ = new Point();
               _loc15_ = new Point();
               _loc23_ = 0;
               while(_loc23_ < this.num_pt)
               {
                  this.pts[_loc23_].name = _loc23_.toString();
                  _loc10_.x = this.pts[_loc23_].x;
                  _loc10_.y = this.pts[_loc23_].y;
                  _loc11_.x = this.pts[(_loc23_ + 1) % this.num_pt].x;
                  _loc11_.y = this.pts[(_loc23_ + 1) % this.num_pt].y;
                  _loc12_.x = this.pts[(_loc23_ + 2) % this.num_pt].x;
                  _loc12_.y = this.pts[(_loc23_ + 2) % this.num_pt].y;
                  _loc13_.x = this.pts[(_loc23_ + 3) % this.num_pt].x;
                  _loc13_.y = this.pts[(_loc23_ + 3) % this.num_pt].y;
                  _loc14_.x = (_loc12_.x - _loc10_.x) / 2;
                  _loc14_.y = (_loc12_.y - _loc10_.y) / 2;
                  _loc15_.x = (_loc13_.x - _loc11_.x) / 2;
                  _loc15_.y = (_loc13_.y - _loc11_.y) / 2;
                  _loc3_ = Math.floor(Point.distance(_loc11_,_loc12_)) / this.point_seperation_coef;
                  _loc3_ = _loc3_ < 2?Number(2):Number(_loc3_);
                  if(this.maskArray[_loc23_ + 2] != null)
                  {
                     this.maskArray[_loc23_ + 2].graphics.clear();
                     this.maskArray[_loc23_ + 2] = null;
                  }
                  (_loc24_ = new UIComponent()).graphics.lineStyle(5,65280,0);
                  _loc25_ = 0;
                  while(_loc25_ < _loc3_)
                  {
                     _loc4_ = _loc25_ / _loc3_;
                     _loc16_ = Math.pow(_loc4_,3);
                     _loc17_ = Math.pow(_loc4_,2);
                     _loc5_ = 2 * _loc16_ - 3 * _loc17_ + 1;
                     _loc6_ = -2 * _loc16_ + 3 * _loc17_;
                     _loc7_ = _loc16_ - 2 * _loc17_ + _loc4_;
                     _loc8_ = _loc16_ - _loc17_;
                     _loc9_.x = _loc5_ * _loc11_.x + _loc6_ * _loc12_.x + _loc7_ * _loc14_.x + _loc8_ * _loc15_.x;
                     _loc9_.y = _loc5_ * _loc11_.y + _loc6_ * _loc12_.y + _loc7_ * _loc14_.y + _loc8_ * _loc15_.y;
                     if(_loc23_ == 0 && _loc25_ == 0)
                     {
                        _loc24_.graphics.moveTo(_loc9_.x,_loc9_.y);
                     }
                     else if(_loc25_ == 0)
                     {
                        _loc24_.graphics.moveTo(_loc9_.x,_loc9_.y);
                     }
                     else
                     {
                        _loc24_.graphics.lineTo(_loc9_.x,_loc9_.y);
                     }
                     if(_loc23_ == 0 && _loc25_ == 0)
                     {
                        _loc2_.graphics.moveTo(_loc9_.x,_loc9_.y);
                     }
                     else
                     {
                        _loc2_.graphics.lineTo(_loc9_.x,_loc9_.y);
                     }
                     _loc24_.graphics.endFill();
                     _loc24_.name = "tmp" + (_loc23_ + 2);
                     _loc2_.addChild(_loc24_);
                     this.maskArray[_loc23_ + 2] = _loc24_;
                     _loc24_.name = _loc23_.toString();
                     _loc24_.addEventListener(MouseEvent.CLICK,this.onBorderClickHandler);
                     _loc25_++;
                  }
                  _loc23_++;
               }
               break;
            case "line":
               _loc23_ = 0;
               while(_loc23_ < this.num_pt)
               {
                  this.pts[_loc23_].name = _loc23_.toString();
                  if(this.maskArray[_loc23_ + 2] != null)
                  {
                     this.maskArray[_loc23_ + 2].graphics.clear();
                     this.maskArray[_loc23_ + 2] = null;
                  }
                  (_loc24_ = new UIComponent()).graphics.lineStyle(5,65280,0);
                  _loc26_ = _loc23_ % this.num_pt;
                  if(_loc23_ == 0)
                  {
                     _loc2_.graphics.moveTo(this.pts[_loc26_].x,this.pts[_loc26_].y);
                  }
                  else
                  {
                     _loc2_.graphics.lineTo(this.pts[_loc26_].x,this.pts[_loc26_].y);
                  }
                  if(_loc23_ == this.num_pt - 1)
                  {
                     _loc2_.graphics.lineTo(this.pts[0].x,this.pts[0].y);
                  }
                  if(_loc23_ == 0)
                  {
                     _loc24_.graphics.moveTo(this.pts[this.num_pt - 1].x,this.pts[this.num_pt - 1].y);
                     _loc24_.graphics.lineTo(this.pts[_loc26_].x,this.pts[_loc26_].y);
                  }
                  if(_loc23_ != 0)
                  {
                     _loc24_.graphics.moveTo(this.pts[(_loc26_ - 1) % this.num_pt].x,this.pts[(_loc26_ - 1) % this.num_pt].y);
                     _loc24_.graphics.lineTo(this.pts[_loc26_].x,this.pts[_loc26_].y);
                  }
                  _loc24_.graphics.endFill();
                  _loc2_.addChild(_loc24_);
                  this.maskArray[_loc23_ + 2] = _loc24_;
                  _loc24_.name = _loc23_.toString();
                  _loc24_.addEventListener(MouseEvent.CLICK,this.onBorderClickHandler);
                  _loc23_++;
               }
               break;
            case "curvenew":
               _loc18_ = this.pts.length;
               _loc19_ = (this.pts[0].x + this.pts[_loc18_ - 1].x) / 2;
               _loc20_ = (this.pts[0].y + this.pts[_loc18_ - 1].y) / 2;
               _loc2_.graphics.moveTo(_loc19_,_loc20_);
               _loc21_ = _loc19_;
               _loc22_ = _loc20_;
               _loc23_ = 0;
               while(_loc23_ < _loc18_ - 1)
               {
                  _loc27_ = (this.pts[_loc23_].x + this.pts[_loc23_ + 1].x) / 2;
                  _loc28_ = (this.pts[_loc23_].y + this.pts[_loc23_ + 1].y) / 2;
                  _loc2_.graphics.curveTo(this.pts[_loc23_].x,this.pts[_loc23_].y,_loc27_,_loc28_);
                  (_loc24_ = new UIComponent()).graphics.lineStyle(5,65280,0);
                  _loc24_.graphics.moveTo(_loc21_,_loc22_);
                  _loc24_.graphics.curveTo(this.pts[_loc23_].x,this.pts[_loc23_].y,_loc27_,_loc28_);
                  _loc24_.graphics.endFill();
                  _loc2_.addChild(_loc24_);
                  this.maskArray[_loc23_ + 2] = _loc24_;
                  _loc24_.name = _loc23_.toString();
                  _loc24_.addEventListener(MouseEvent.CLICK,this.onBorderClickHandler);
                  _loc21_ = _loc27_;
                  _loc22_ = _loc28_;
                  _loc23_++;
               }
               _loc2_.graphics.curveTo(this.pts[_loc23_].x,this.pts[_loc23_].y,_loc19_,_loc20_);
         }
         _loc2_.graphics.endFill();
         _loc2_.name = "myBorder";
         this.maskArray[1] = _loc2_;
         this.borderCan.addChild(_loc2_);
         this.showMask = false;
         this.preview();
      }
      
      public function set _step3HBox1(param1:HBox) : void
      {
         var _loc2_:Object = this._1467185338_step3HBox1;
         if(_loc2_ !== param1)
         {
            this._1467185338_step3HBox1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step3HBox1",_loc2_,param1));
         }
      }
      
      public function set lineType(param1:RadioButtonGroup) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1188665678lineType;
         if(_loc2_ !== param1)
         {
            this._1188665678lineType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lineType",_loc2_,param1));
         }
      }
      
      public function set _btnCurved(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1352381102_btnCurved;
         if(_loc2_ !== param1)
         {
            this._1352381102_btnCurved = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCurved",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scaleUpBtn() : Button
      {
         return this._1914892951scaleUpBtn;
      }
      
      [Bindable(event="propertyChange")]
      public function get _step2HBox2() : HBox
      {
         return this._1495814488_step2HBox2;
      }
      
      private function showCropTools(param1:MouseEvent) : void
      {
         if(!DragManager.isDragging)
         {
            if(param1.type == MouseEvent.MOUSE_OUT)
            {
               this.borderCan.visible = false;
               this.pointCan.visible = false;
            }
            else if(param1.type == MouseEvent.MOUSE_OVER)
            {
               this.borderCan.visible = true;
               this.pointCan.visible = true;
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _step2HBox3() : HBox
      {
         return this._1495814487_step2HBox3;
      }
      
      private function _MaskImage_SetProperty7_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty7 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 50;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty7",this._MaskImage_SetProperty7);
         return _loc1_;
      }
      
      private function _MaskImage_Parallel1_c() : Parallel
      {
         var _loc1_:Parallel = new Parallel();
         _loc1_.children = [this._MaskImage_Move1_c()];
         return _loc1_;
      }
      
      private function _MaskImage_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return _canStep1;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty1.target = param1;
         },"_MaskImage_SetProperty1.target");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep2;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty2.target = param1;
         },"_MaskImage_SetProperty2.target");
         result[1] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep3;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty3.target = param1;
         },"_MaskImage_SetProperty3.target");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep1;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty4.target = param1;
         },"_MaskImage_SetProperty4.target");
         result[3] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep2;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty5.target = param1;
         },"_MaskImage_SetProperty5.target");
         result[4] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep3;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty6.target = param1;
         },"_MaskImage_SetProperty6.target");
         result[5] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep1;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty7.target = param1;
         },"_MaskImage_SetProperty7.target");
         result[6] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep2;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty8.target = param1;
         },"_MaskImage_SetProperty8.target");
         result[7] = binding;
         binding = new Binding(this,function():Object
         {
            return _canStep3;
         },function(param1:Object):void
         {
            _MaskImage_SetProperty9.target = param1;
         },"_MaskImage_SetProperty9.target");
         result[8] = binding;
         binding = new Binding(this,function():Array
         {
            return [_canStep1,_canStep2,_canStep3];
         },function(param1:Array):void
         {
            t1.targets = param1;
         },"t1.targets");
         result[9] = binding;
         binding = new Binding(this,function():Array
         {
            return [new GlowFilter(13421772)];
         },function(param1:Array):void
         {
            _canStep1.filters = param1;
         },"_canStep1.filters");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_posimage");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MaskImage_Label1.text = param1;
         },"_MaskImage_Label1.text");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_size");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MaskImage_Label2.text = param1;
         },"_MaskImage_Label2.text");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_rotate");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MaskImage_Label3.text = param1;
         },"_MaskImage_Label3.text");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_flip");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MaskImage_Label4.text = param1;
         },"_MaskImage_Label4.text");
         result[14] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_fixpos");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnLockImage.label = param1;
         },"btnLockImage.label");
         result[15] = binding;
         binding = new Binding(this,function():Array
         {
            return [new GlowFilter(13421772)];
         },function(param1:Array):void
         {
            _canGap12.filters = param1;
         },"_canGap12.filters");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_changepos");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnUnLockImage.label = param1;
         },"btnUnLockImage.label");
         result[17] = binding;
         binding = new Binding(this,function():Array
         {
            return [new GlowFilter(13421772)];
         },function(param1:Array):void
         {
            _canStep2.filters = param1;
         },"_canStep2.filters");
         result[18] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_adjustcrop");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MaskImage_Label5.text = param1;
         },"_MaskImage_Label5.text");
         result[19] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_curve");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCurved.label = param1;
         },"_btnCurved.label");
         result[20] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_straight");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnStraight.label = param1;
         },"_btnStraight.label");
         result[21] = binding;
         binding = new Binding(this,function():Array
         {
            return [new GlowFilter(13421772)];
         },function(param1:Array):void
         {
            _canGap23.filters = param1;
         },"_canGap23.filters");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_modcrop");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnUnCropImage.label = param1;
         },"btnUnCropImage.label");
         result[23] = binding;
         binding = new Binding(this,function():Array
         {
            return [new GlowFilter(13421772)];
         },function(param1:Array):void
         {
            _canStep3.filters = param1;
         },"_canStep3.filters");
         result[24] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_addmystuff");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MaskImage_Label7.text = param1;
         },"_MaskImage_Label7.text");
         result[25] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_readyimport");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _step3Text1.text = param1;
         },"_step3Text1.text");
         result[26] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_addmystuff");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnExport.label = param1;
         },"btnExport.label");
         result[27] = binding;
         binding = new Binding(this,function():Rectangle
         {
            return new Rectangle(0,0,610,490);
         },function(param1:Rectangle):void
         {
            myCan.scrollRect = param1;
         },"myCan.scrollRect");
         result[28] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_skip");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnSkip.text = param1;
         },"btnSkip.text");
         result[29] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","cropper_cancel");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            btnCancel.label = param1;
         },"btnCancel.label");
         result[30] = binding;
         return result;
      }
      
      private function visibleRef() : void
      {
         if(this._headable)
         {
            this.body.visible = !this.body.visible;
         }
         else if(this._holdable)
         {
            this.hand.visible = !this.hand.visible;
         }
      }
      
      private function _MaskImage_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = new Sequence();
         this.t1 = _loc1_;
         _loc1_.children = [this._MaskImage_Parallel1_c()];
         BindingManager.executeBindings(this,"t1",this.t1);
         return _loc1_;
      }
      
      public function set shadowImageBackgroundCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._660568935shadowImageBackgroundCan;
         if(_loc2_ !== param1)
         {
            this._660568935shadowImageBackgroundCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shadowImageBackgroundCan",_loc2_,param1));
         }
      }
      
      public function __btnCropImage_click(param1:MouseEvent) : void
      {
         this.switchCropImage();
      }
      
      public function set _txtDefShape(param1:Label) : void
      {
         var _loc2_:Object = this._762489709_txtDefShape;
         if(_loc2_ !== param1)
         {
            this._762489709_txtDefShape = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtDefShape",_loc2_,param1));
         }
      }
      
      private function goStep1() : void
      {
         this.lockImage = false;
         this.borderCan.visible = this.pointCan.visible = false;
         this.myBackgroundCan.visible = this.shadowImageCan.visible = this._canAppControl.visible = true;
         currentState = "theFirstStep";
         this.setSize(this._canStep1,LARGE);
         this.setSize(this._canStep2,SMALL);
         this.setSize(this._canStep3,SMALL);
         this.setTip(this._tip1);
         this.setTip(this._tip2,false);
         this.setTip(this._tip3,false);
         this.drawArrow(this._canGap12,0);
         this.drawArrow(this._canGap23,0,14474460);
         this._canWorkSpace.setChildIndex(this.appCan,1);
      }
      
      private function goStep2() : void
      {
         this.cropImage = false;
         this.borderCan.visible = this.pointCan.visible = true;
         this.myBackgroundCan.visible = this.shadowImageCan.visible = this._canAppControl.visible = false;
         currentState = "theSecondStep";
         this.setSize(this._canStep1,SMALL);
         this.setSize(this._canStep2,LARGE);
         this.setSize(this._canStep3,SMALL);
         this.setTip(this._tip1,false);
         this.setTip(this._tip2);
         this.setTip(this._tip3,false);
         this.drawArrow(this._canGap12,1,11982831);
         this.drawArrow(this._canGap23,0);
         this._canWorkSpace.setChildIndex(this.refCan,1);
      }
      
      private function goStep3() : void
      {
         this.borderCan.visible = this.pointCan.visible = false;
         this.myBackgroundCan.visible = this.shadowImageCan.visible = this._canAppControl.visible = false;
         currentState = "theThirdStep";
         this.setSize(this._canStep1,SMALL);
         this.setSize(this._canStep2,SMALL);
         this.setSize(this._canStep3,LARGE);
         this.setTip(this._tip1,false);
         this.setTip(this._tip2,false);
         this.setTip(this._tip3);
         this.drawArrow(this._canGap12,1,11982831);
         this.drawArrow(this._canGap23,1,11982831);
      }
      
      public function imageUpdated(param1:Number, param2:Number) : void
      {
         if(!this._updated)
         {
            this._imageWidth = param1;
            this._imageHeight = param2;
            this.myImage.x = -param1 / 2;
            this.myImage.y = -param2 / 2;
            this.myImageCan.x = this.myCan.width / 2;
            this.myImageCan.y = this.myCan.height / 2;
            this.synShadowImage();
            this.pressPoint = new Point();
            this.handleDragEventListenter(this.myImageCan);
            this.handleDragEventListenter(this.shadowImageCan);
            this.initMask();
            this.lineStyle = "curve";
            this.lockImage = false;
            this.hand.visible = !!this._holdable?true:false;
            this.body.visible = !!this._headable?true:false;
            this._updated = true;
            this.goStep1();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canGap12() : Canvas
      {
         return this._58631450_canGap12;
      }
      
      public function get lockImage() : Boolean
      {
         return this._lockImage;
      }
      
      public function set editImage(param1:Object) : void
      {
         this._updated = false;
         var _loc2_:DisplayObject = DisplayObject(Bitmap(param1));
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc3_.draw(_loc2_);
         this.myImage.graphics.beginBitmapFill(_loc3_);
         this.myImage.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         this.myImage.graphics.endFill();
         var _loc4_:BitmapData = _loc3_.clone();
         this.shadowImage.graphics.beginBitmapFill(_loc4_);
         this.shadowImage.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         this.shadowImage.graphics.endFill();
         this.myImage.cacheAsBitmap = true;
         this.imageUpdated(_loc2_.width,_loc2_.height);
      }
      
      public function set myBackgroundCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._1023330954myBackgroundCan;
         if(_loc2_ !== param1)
         {
            this._1023330954myBackgroundCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"myBackgroundCan",_loc2_,param1));
         }
      }
      
      private function onMouseMove(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this._currDraggingSprite == this._canRotate)
         {
            _loc2_ = this._canRotateContainer.mouseX - this._canRotate.x;
            _loc3_ = this._canRotateContainer.mouseY - this._canRotate.y;
            _loc4_ = Math.atan2(_loc3_,_loc2_);
            this._canRotate.rotation = _loc4_ * 180 / Math.PI;
            this.changeRotate();
         }
      }
      
      private function enablingRotate(param1:Boolean) : void
      {
         var _loc2_:ColorTransform = null;
         if(param1)
         {
            _loc2_ = new ColorTransform(1,1,1);
            this._canRotate.transform.colorTransform = _loc2_;
            this._canRotate.buttonMode = true;
            this._canRotate.addEventListener(MouseEvent.MOUSE_DOWN,this.doPressRotate);
         }
         else
         {
            _loc2_ = new ColorTransform(0.5,0.5,0.5);
            this._canRotate.transform.colorTransform = _loc2_;
            this._canRotate.buttonMode = false;
            this._canRotate.removeEventListener(MouseEvent.MOUSE_DOWN,this.doPressRotate);
         }
      }
      
      public function set _hboxShape(param1:HBox) : void
      {
         var _loc2_:Object = this._1755110271_hboxShape;
         if(_loc2_ !== param1)
         {
            this._1755110271_hboxShape = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_hboxShape",_loc2_,param1));
         }
      }
      
      private function _MaskImage_SetProperty6_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty6 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 50;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty6",this._MaskImage_SetProperty6);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _canGap23() : Canvas
      {
         return this._58631418_canGap23;
      }
      
      [Bindable(event="propertyChange")]
      public function get SldScale() : HSlider
      {
         return this._1366867201SldScale;
      }
      
      [Bindable(event="propertyChange")]
      public function get myImage() : Image
      {
         return this._1488541455myImage;
      }
      
      public function __refCan_creationComplete(param1:FlexEvent) : void
      {
         this.initHand();
      }
      
      public function __myImageBackgroundCan_creationComplete(param1:FlexEvent) : void
      {
         this.drawFullTransBackground();
      }
      
      private function onBorderClickHandler(param1:MouseEvent) : void
      {
         this.createNewDragPoint(param1.localX,param1.localY,Number(param1.currentTarget.name));
      }
      
      private function _MaskImage_SetProperty5_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty5 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 170;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty5",this._MaskImage_SetProperty5);
         return _loc1_;
      }
      
      public function set _step3Text1(param1:TextArea) : void
      {
         var _loc2_:Object = this._1455051876_step3Text1;
         if(_loc2_ !== param1)
         {
            this._1455051876_step3Text1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_step3Text1",_loc2_,param1));
         }
      }
      
      private function onMouseUp(param1:Event) : void
      {
         if(this._currDraggingSprite != null)
         {
            this._currDraggingSprite = null;
         }
      }
      
      private function onUploadCustomAssetCompleteData(param1:Event) : void
      {
         var _loc6_:XML = null;
         if(param1.type != Event.COMPLETE)
         {
            Alert.show(UtilDict.toDisplay("go","constant_connecterr"));
         }
         Console.getConsole().requestLoadStatus(false,true);
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_);
         var _loc5_:String;
         var _loc4_:String;
         if((_loc5_ = (_loc4_ = _loc3_.toString()).substr(0,1)) == "0")
         {
            this.cancel();
            _loc6_ = new XML(_loc4_.substr(1));
            Console.getConsole().uploadedAssetXML = _loc6_;
            Console.getConsole().getUserAssetById(_loc6_.id);
            return;
         }
         Alert.show("the return code is: " + _loc5_ + "\n error message: \n" + _loc4_.substr(1));
         throw new Error("Can not get the asset\'s id. \n" + _loc4_.substr(1));
      }
      
      public function set body(param1:Image) : void
      {
         var _loc2_:Object = this._3029410body;
         if(_loc2_ !== param1)
         {
            this._3029410body = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"body",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _step3HBox1() : HBox
      {
         return this._1467185338_step3HBox1;
      }
      
      private function deleteDragPoint(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Number = NaN;
         if(this.num_pt > 3)
         {
            _loc2_ = DisplayObject(param1.currentTarget);
            this.pointCan.removeChild(_loc2_);
            _loc3_ = Number(_loc2_.name);
            this.pts.splice(_loc3_,1);
            this.num_pt = this.pts.length;
            this.drawBorder();
         }
      }
      
      private function scaleMyCan(param1:Boolean) : void
      {
         this.myCan.scaleX = this.myCan.scaleY = 200 / 100;
         this.myCan.x = (this.appCan.width - this.myCan.width * this.myCan.scaleX) / 2;
         this.myCan.y = (this.appCan.height - this.myCan.height * this.myCan.scaleY) / 2;
         this.resizeMaskPoint();
      }
      
      public function set btnCropImage(param1:Button) : void
      {
         var _loc2_:Object = this._613032367btnCropImage;
         if(_loc2_ !== param1)
         {
            this._613032367btnCropImage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnCropImage",_loc2_,param1));
         }
      }
      
      public function set scaleDownBtn(param1:Button) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._216437328scaleDownBtn;
         if(_loc2_ !== param1)
         {
            this._216437328scaleDownBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scaleDownBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtDefShape() : Label
      {
         return this._762489709_txtDefShape;
      }
      
      public function set _btnStraight(param1:RadioButton) : void
      {
         var _loc2_:Object = this._1349726281_btnStraight;
         if(_loc2_ !== param1)
         {
            this._1349726281_btnStraight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnStraight",_loc2_,param1));
         }
      }
      
      private function _MaskImage_SetProperty4_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty4 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 50;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty4",this._MaskImage_SetProperty4);
         return _loc1_;
      }
      
      public function set shadowImageCan(param1:Canvas) : void
      {
         var _loc2_:Object = null;
         _loc2_ = this._398907829shadowImageCan;
         if(_loc2_ !== param1)
         {
            this._398907829shadowImageCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"shadowImageCan",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _hboxShape() : HBox
      {
         return this._1755110271_hboxShape;
      }
      
      private function drawFullTransBackground() : void
      {
         this.myImageBackgroundCan.graphics.beginFill(65280,0);
         this.myImageBackgroundCan.graphics.drawRect(0,0,5760,5760);
         this.myImageBackgroundCan.graphics.endFill();
         this.myImageBackgroundCan.x = this.myImageBackgroundCan.y = -2880;
         this.shadowImageBackgroundCan.graphics.beginFill(65280,0);
         this.shadowImageBackgroundCan.graphics.drawRect(0,0,5760,5760);
         this.shadowImageBackgroundCan.graphics.endFill();
         this.shadowImageBackgroundCan.x = this.shadowImageBackgroundCan.y = -2880;
         this.myImageBackgroundCan.cacheAsBitmap = true;
         this.shadowImageBackgroundCan.cacheAsBitmap = true;
      }
      
      private function setSize(param1:Canvas, param2:String = "large") : void
      {
         var _loc3_:String = null;
         param1.clipContent = false;
         param1.horizontalScrollPolicy = "off";
         if(param1 == this._canStep1)
         {
            this._step1HBox1.visible = param2 == SMALL?false:true;
            this._step1HBox2.visible = param2 == SMALL?false:true;
            this._step1HBox3.visible = param2 == SMALL?false:true;
            _loc3_ = "1";
         }
         else if(param1 == this._canStep2)
         {
            this._hboxShape.visible = param2 == SMALL?false:true;
            this._step2HBox2.visible = param2 == SMALL?false:true;
            this._step2HBox3.visible = param2 == SMALL?false:true;
            _loc3_ = "2";
         }
         else if(param1 == this._canStep3)
         {
            this._step3Text1.visible = param2 == SMALL?false:true;
            this._step3HBox1.visible = param2 == SMALL?false:true;
            _loc3_ = "3";
         }
         if(param2 == LARGE)
         {
            param1.setStyle("backgroundColor",16750375);
            this.drawTag(null,_loc3_,16750375,param1);
         }
         else
         {
            param1.setStyle("backgroundColor",14474460);
            this.drawTag(null,_loc3_,14474460,param1);
         }
      }
      
      override public function initialize() : void
      {
         var target:MaskImage = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._MaskImage_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_MaskImageWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get shadowImageBackgroundCan() : Canvas
      {
         return this._660568935shadowImageBackgroundCan;
      }
      
      public function set _canRotate(param1:Canvas) : void
      {
         var _loc2_:Object = this._1489557556_canRotate;
         if(_loc2_ !== param1)
         {
            this._1489557556_canRotate = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canRotate",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _step3Text1() : TextArea
      {
         return this._1455051876_step3Text1;
      }
      
      public function set _tip1(param1:Button) : void
      {
         var _loc2_:Object = this._91294677_tip1;
         if(_loc2_ !== param1)
         {
            this._91294677_tip1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tip1",_loc2_,param1));
         }
      }
      
      public function set _tip2(param1:Button) : void
      {
         var _loc2_:Object = this._91294678_tip2;
         if(_loc2_ !== param1)
         {
            this._91294678_tip2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tip2",_loc2_,param1));
         }
      }
      
      private function resizeMaskPoint() : void
      {
         var _loc1_:Array = this.pointCan.getChildren();
         var _loc2_:Number = 0;
         while(_loc2_ < _loc1_.length)
         {
            this.pointCan.getChildAt(_loc2_).scaleX = this.pointCan.getChildAt(_loc2_).scaleY = 100 / 200;
            _loc2_++;
         }
      }
      
      private function _MaskImage_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty3 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 50;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty3",this._MaskImage_SetProperty3);
         return _loc1_;
      }
      
      private function drawTag(param1:Event, param2:String, param3:uint = 14474460, param4:Canvas = null) : void
      {
         var _loc5_:Number = 25;
         var _loc6_:Canvas;
         (_loc6_ = new Canvas()).graphics.clear();
         _loc6_.graphics.lineStyle(4,16777215);
         _loc6_.graphics.beginFill(param3);
         _loc6_.graphics.drawCircle(0,0,_loc5_);
         _loc6_.graphics.endFill();
         _loc6_.clipContent = false;
         _loc6_.x = 5;
         _loc6_.y = 0;
         _loc6_.removeAllChildren();
         var _loc7_:Canvas = new Canvas();
         _loc7_.width = _loc7_.height = 50;
         _loc7_.styleName = "imgCropperNum" + param2;
         _loc7_.x = _loc7_.y = -24;
         _loc7_.clipContent = false;
         _loc6_.addChild(_loc7_);
         if(param1 != null)
         {
            Canvas(param1.currentTarget).addChild(_loc6_);
         }
         else
         {
            param4.addChild(_loc6_);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnStraight() : RadioButton
      {
         return this._1349726281_btnStraight;
      }
      
      private function drawRadioBg(param1:Event) : void
      {
         var _loc2_:RadioButton = RadioButton(param1.currentTarget);
         _loc2_.graphics.lineStyle(3,16777215);
         _loc2_.graphics.beginFill(5144765);
         if(_loc2_ == this._btnCurved)
         {
            _loc2_.graphics.drawRoundRect(18,0,_loc2_.width - 18,_loc2_.height,10,10);
         }
         else if(_loc2_ == this._btnStraight)
         {
            _loc2_.graphics.drawRect(18,0,_loc2_.width - 18,_loc2_.height);
         }
         _loc2_.graphics.endFill();
      }
      
      public function set _tip3(param1:Button) : void
      {
         var _loc2_:Object = this._91294679_tip3;
         if(_loc2_ !== param1)
         {
            this._91294679_tip3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tip3",_loc2_,param1));
         }
      }
      
      private function doMoveImage(param1:Event) : void
      {
         var _loc2_:Number = (param1.currentTarget.data as Array)[0];
         var _loc3_:Number = (param1.currentTarget.data as Array)[1];
         this.myImageCan.x = this.myImageCan.x + _loc2_;
         this.myImageCan.y = this.myImageCan.y + _loc3_;
         this.synShadowImage();
      }
      
      public function preview() : void
      {
         var _loc1_:UIComponent = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Point = null;
         var _loc9_:Point = null;
         var _loc10_:Point = null;
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc13_:Point = null;
         var _loc14_:Point = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         if(!this.showMask)
         {
            this.btnExport.visible = true;
            this.showMask = true;
            this.myImageCan.mask = null;
            if(this.myCan.getChildByName("mask") != null)
            {
               this.myCan.removeChild(this.myCan.getChildByName("mask"));
               _loc1_ = null;
            }
            this._minx = 9999999;
            this._miny = 9999999;
            this._maxx = 0;
            this._maxy = 0;
            _loc1_ = new UIComponent();
            _loc1_.graphics.beginFill(16763904);
            _loc1_.graphics.lineStyle(0);
            switch(this._lineStyle)
            {
               case "curve":
                  _loc8_ = new Point();
                  _loc9_ = new Point();
                  _loc10_ = new Point();
                  _loc11_ = new Point();
                  _loc12_ = new Point();
                  _loc13_ = new Point();
                  _loc14_ = new Point();
                  _loc20_ = 0;
                  while(_loc20_ < this.num_pt)
                  {
                     _loc9_.x = this.pts[_loc20_].x;
                     _loc9_.y = this.pts[_loc20_].y;
                     _loc10_.x = this.pts[(_loc20_ + 1) % this.num_pt].x;
                     _loc10_.y = this.pts[(_loc20_ + 1) % this.num_pt].y;
                     _loc11_.x = this.pts[(_loc20_ + 2) % this.num_pt].x;
                     _loc11_.y = this.pts[(_loc20_ + 2) % this.num_pt].y;
                     _loc12_.x = this.pts[(_loc20_ + 3) % this.num_pt].x;
                     _loc12_.y = this.pts[(_loc20_ + 3) % this.num_pt].y;
                     _loc13_.x = (_loc11_.x - _loc9_.x) / 2;
                     _loc13_.y = (_loc11_.y - _loc9_.y) / 2;
                     _loc14_.x = (_loc12_.x - _loc10_.x) / 2;
                     _loc14_.y = (_loc12_.y - _loc10_.y) / 2;
                     _loc2_ = Math.floor(Point.distance(_loc10_,_loc11_)) / this.point_seperation_coef;
                     _loc2_ = _loc2_ < 2?Number(2):Number(_loc2_);
                     _loc21_ = 0;
                     while(_loc21_ < _loc2_)
                     {
                        _loc3_ = _loc21_ / _loc2_;
                        _loc15_ = Math.pow(_loc3_,3);
                        _loc16_ = Math.pow(_loc3_,2);
                        _loc4_ = 2 * _loc15_ - 3 * _loc16_ + 1;
                        _loc5_ = -2 * _loc15_ + 3 * _loc16_;
                        _loc6_ = _loc15_ - 2 * _loc16_ + _loc3_;
                        _loc7_ = _loc15_ - _loc16_;
                        _loc8_.x = _loc4_ * _loc10_.x + _loc5_ * _loc11_.x + _loc6_ * _loc13_.x + _loc7_ * _loc14_.x;
                        _loc8_.y = _loc4_ * _loc10_.y + _loc5_ * _loc11_.y + _loc6_ * _loc13_.y + _loc7_ * _loc14_.y;
                        if(_loc20_ == 0 && _loc21_ == 0)
                        {
                           _loc1_.graphics.moveTo(_loc8_.x,_loc8_.y);
                        }
                        else
                        {
                           _loc1_.graphics.lineTo(_loc8_.x,_loc8_.y);
                        }
                        this._minx = Math.min(_loc8_.x,this._minx);
                        this._miny = Math.min(_loc8_.y,this._miny);
                        this._maxx = Math.max(_loc8_.x,this._maxx);
                        this._maxy = Math.max(_loc8_.y,this._maxy);
                        _loc21_++;
                     }
                     _loc20_++;
                  }
                  break;
               case "line":
                  _loc20_ = 0;
                  while(_loc20_ < this.num_pt)
                  {
                     _loc22_ = _loc20_ % this.num_pt;
                     if(_loc20_ == 0)
                     {
                        _loc1_.graphics.moveTo(this.pts[_loc22_].x,this.pts[_loc22_].y);
                     }
                     else
                     {
                        _loc1_.graphics.lineTo(this.pts[_loc22_].x,this.pts[_loc22_].y);
                     }
                     if(_loc20_ == this.num_pt - 1)
                     {
                        _loc1_.graphics.lineTo(this.pts[0].x,this.pts[0].y);
                     }
                     this._minx = Math.min(this.pts[_loc22_].x,this._minx);
                     this._miny = Math.min(this.pts[_loc22_].y,this._miny);
                     this._maxx = Math.max(this.pts[_loc22_].x,this._maxx);
                     this._maxy = Math.max(this.pts[_loc22_].y,this._maxy);
                     _loc20_++;
                  }
                  break;
               case "curvenew":
                  _loc17_ = this.pts.length;
                  _loc18_ = (this.pts[0].x + this.pts[_loc17_ - 1].x) / 2;
                  _loc19_ = (this.pts[0].y + this.pts[_loc17_ - 1].y) / 2;
                  _loc1_.graphics.moveTo(_loc18_,_loc19_);
                  _loc20_ = 0;
                  while(_loc20_ < _loc17_ - 1)
                  {
                     _loc23_ = (this.pts[_loc20_].x + this.pts[_loc20_ + 1].x) / 2;
                     _loc24_ = (this.pts[_loc20_].y + this.pts[_loc20_ + 1].y) / 2;
                     _loc1_.graphics.curveTo(this.pts[_loc20_].x,this.pts[_loc20_].y,_loc23_,_loc24_);
                     this._minx = Math.min(this.pts[_loc20_].x,this._minx);
                     this._miny = Math.min(this.pts[_loc20_].y,this._miny);
                     this._maxx = Math.max(this.pts[_loc20_].x,this._maxx);
                     this._maxy = Math.max(this.pts[_loc20_].y,this._maxy);
                     _loc20_++;
                  }
                  _loc1_.graphics.curveTo(this.pts[_loc20_].x,this.pts[_loc20_].y,_loc18_,_loc19_);
            }
            _loc1_.graphics.endFill();
            _loc1_.name = "mask";
            this.myCan.addChild(_loc1_);
            this.myImageCan.mask = _loc1_;
            this.maskArray[0] = _loc1_;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _canRotate() : Canvas
      {
         return this._1489557556_canRotate;
      }
      
      private function changeSize() : void
      {
         if(!this.lockImage)
         {
            this.myImageCan.scaleX = this.myImageCan.scaleY = this.SldScale.value / 100;
            this.synShadowImage();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tip1() : Button
      {
         return this._91294677_tip1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tip2() : Button
      {
         return this._91294678_tip2;
      }
      
      private function switchCropImage() : void
      {
         this.cropImage = !!this.cropImage?false:true;
      }
      
      public function set appCan(param1:Canvas) : void
      {
         var _loc2_:Object = this._1411101201appCan;
         if(_loc2_ !== param1)
         {
            this._1411101201appCan = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"appCan",_loc2_,param1));
         }
      }
      
      public function set _canAppControl(param1:Canvas) : void
      {
         var _loc2_:Object = this._443042323_canAppControl;
         if(_loc2_ !== param1)
         {
            this._443042323_canAppControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_canAppControl",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tip3() : Button
      {
         return this._91294679_tip3;
      }
      
      private function getShiftPos() : void
      {
      }
      
      public function set btnCancel(param1:Button) : void
      {
         var _loc2_:Object = this._117924854btnCancel;
         if(_loc2_ !== param1)
         {
            this._117924854btnCancel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnCancel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get btnLockImage() : Button
      {
         return this._1610907660btnLockImage;
      }
      
      public function set btnSkip(param1:Label) : void
      {
         var _loc2_:Object = this._206195195btnSkip;
         if(_loc2_ !== param1)
         {
            this._206195195btnSkip = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSkip",_loc2_,param1));
         }
      }
      
      public function set btnLockImage(param1:Button) : void
      {
         var _loc2_:Object = this._1610907660btnLockImage;
         if(_loc2_ !== param1)
         {
            this._1610907660btnLockImage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnLockImage",_loc2_,param1));
         }
      }
      
      private function _MaskImage_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MaskImage_SetProperty2 = _loc1_;
         _loc1_.name = "height";
         _loc1_.value = 50;
         BindingManager.executeBindings(this,"_MaskImage_SetProperty2",this._MaskImage_SetProperty2);
         return _loc1_;
      }
   }
}
