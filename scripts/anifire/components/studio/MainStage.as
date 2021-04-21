package anifire.components.studio
{
   import anifire.command.CommandStack;
   import anifire.command.ICommand;
   import anifire.component.GoAlert;
   import anifire.component.IconTextButton;
   import anifire.component.MiniMap;
   import anifire.component.MiniMapEvent;
   import anifire.component.ZoomSliderThumb;
   import anifire.constant.AnimeConstants;
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.AssetGroup;
   import anifire.core.Background;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.EffectAsset;
   import anifire.core.ProgramEffectAsset;
   import anifire.core.Prop;
   import anifire.core.SelectionTool;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilUser;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.BindingManager;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.HSlider;
   import mx.controls.Label;
   import mx.controls.Menu;
   import mx.controls.Spacer;
   import mx.core.DeferredInstanceFromFunction;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.effects.Pause;
   import mx.effects.Sequence;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.events.SliderEvent;
   import mx.formatters.NumberFormatter;
   import mx.managers.PopUpManager;
   import mx.states.AddChild;
   import mx.states.RemoveChild;
   import mx.states.SetProperty;
   import mx.states.State;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class MainStage extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _1282133823fadeIn:Fade;
      
      private var _1452717514_btnHistoryMenu:IconTextButton;
      
      private var _1918949473_panControl:Canvas;
      
      private var _1091436750fadeOut:Fade;
      
      private var _1931449851percentFormatter:NumberFormatter;
      
      private var _51913824_bottomControlBar:HBox;
      
      private var _71437831isContentOnBottom:Boolean = false;
      
      private var _1731020110_btnCopy:IconTextButton;
      
      private var _1570224285_txtAutoSave:Label;
      
      private var _784383908_stageViewStack:ViewStack;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _607259319_maskCanvasScene:Canvas;
      
      private var _targetUploadType_in_importer:String;
      
      private var _784031479_documentLayer:Canvas;
      
      private var _2110424330_btnPaste:IconTextButton;
      
      private var _599927733_zoomControl:HBox;
      
      private const MINI_MAP_FACTOR:Number = 0.2;
      
      private var _355954324panDropShadow:DropShadowFilter;
      
      public var _MainStage_AddChild2:AddChild;
      
      public var _MainStage_AddChild3:AddChild;
      
      public var _MainStage_AddChild4:AddChild;
      
      public var _MainStage_AddChild1:AddChild;
      
      private var _239874490_sceneArea:Canvas;
      
      private var _766696848_cameraBorder:UIComponent;
      
      private var _sceneIndexStr:String;
      
      private var _872235962_miniMap:MiniMap;
      
      private var _2089711414fadeOutMap:Fade;
      
      private var _2002216470_addSceneEffectLayer:Canvas;
      
      public var _MainStage_RemoveChild1:RemoveChild;
      
      public var _MainStage_RemoveChild2:RemoveChild;
      
      private var _766521513_uiCanvasAutoSave:Canvas;
      
      private var _55520327isContentOnTop:Boolean = false;
      
      private var _435778611_zoomSlider:HSlider;
      
      private var _1144153660_sceneLayer:Canvas;
      
      private var _1960351742_btnDelScene:Button;
      
      public var _MainStage_Button1:Button;
      
      public var _MainStage_Button2:Button;
      
      public var _MainStage_Button3:Button;
      
      public var _MainStage_Button4:Button;
      
      public var _MainStage_Button5:Button;
      
      public var _MainStage_Button6:Button;
      
      public var _MainStage_Button7:Button;
      
      public var _MainStage_Button8:Button;
      
      public var _MainStage_Button9:Button;
      
      public var _MainStage_Label2:Label;
      
      public var _MainStage_Label3:Label;
      
      public var _MainStage_Label4:Label;
      
      private var _2046797976_lookInToolBar:HBox;
      
      private var _isCameraMode:Boolean = false;
      
      private var _1813395598isContentOnRight:Boolean = false;
      
      private var _selectionTool:SelectionTool;
      
      private var _1720882005isContentOnLeft:Boolean = false;
      
      public var _MainStage_SetProperty1:SetProperty;
      
      public var _MainStage_SetProperty2:SetProperty;
      
      public var _MainStage_SetProperty3:SetProperty;
      
      public var _MainStage_SetProperty4:SetProperty;
      
      public var _MainStage_SetProperty5:SetProperty;
      
      public var _MainStage_SetProperty6:SetProperty;
      
      public var _MainStage_SetProperty7:SetProperty;
      
      public var _MainStage_SetProperty8:SetProperty;
      
      private var _106440182pause:Pause;
      
      private var _1730485215_btnUndo:IconTextButton;
      
      private var _1035034878zoomFactor:Number = 1;
      
      private var _347427628_stageArea:Canvas;
      
      mx_internal var _watchers:Array;
      
      private var _89648856_btnAddScene:Button;
      
      private var _loggedIn:Boolean = true;
      
      private var _240112165_maskCanvasSceneButton:Canvas;
      
      private var _246888748_efAutoSave:Sequence;
      
      private var _1575126697_microMap:MiniMap;
      
      private var _1858283664_assetButtonBar:AssetButtonBar;
      
      private var _1730583237_btnRedo:IconTextButton;
      
      private var _1566867516_dpMovieMenu:XMLList;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _904480549fadeInMap:Fade;
      
      private var _1034752274_btnSceneMenu:Button;
      
      private var _1558819770_maskLayer:Canvas;
      
      private var _74363220_topControlBar:HBox;
      
      private var _550419411_controlLayer:Canvas;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function MainStage()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentHeight":100,
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_topControlBar",
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"topControlBar",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":IconTextButton,
                                    "id":"_btnCopy",
                                    "events":{"mouseUp":"___btnCopy_mouseUp"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnCopy",
                                          "buttonMode":true,
                                          "labelPlacement":"right"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":IconTextButton,
                                    "id":"_btnPaste",
                                    "events":{"mouseUp":"___btnPaste_mouseUp"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnPaste",
                                          "buttonMode":true,
                                          "labelPlacement":"right"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":IconTextButton,
                                    "id":"_btnUndo",
                                    "events":{"click":"___btnUndo_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnUndo",
                                          "buttonMode":true,
                                          "labelPlacement":"right"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":IconTextButton,
                                    "id":"_btnRedo",
                                    "events":{"click":"___btnRedo_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "styleName":"btnRedo",
                                          "buttonMode":true,
                                          "labelPlacement":"right"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":IconTextButton,
                                    "id":"_btnHistoryMenu",
                                    "events":{"click":"___btnHistoryMenu_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "buttonMode":true,
                                          "styleName":"btnMore"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainStage_Button1",
                                    "events":{"click":"___MainStage_Button1_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"get scene xml",
                                          "buttonMode":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainStage_Button2",
                                    "events":{"click":"___MainStage_Button2_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"show Log",
                                          "buttonMode":true
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainStage_Button3",
                                    "events":{"click":"___MainStage_Button3_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"test",
                                          "buttonMode":true
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_stageArea",
                           "events":{
                              "mouseOver":"___stageArea_mouseOver",
                              "mouseOut":"___stageArea_mouseOut",
                              "mouseDown":"___stageArea_mouseDown",
                              "mouseUp":"___stageArea_mouseUp"
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentHeight":100,
                                 "percentWidth":100,
                                 "verticalScrollPolicy":"off",
                                 "horizontalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_documentLayer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Canvas,
                                          "id":"_sceneLayer",
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "verticalScrollPolicy":"off",
                                                "horizontalScrollPolicy":"off",
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Canvas,
                                                   "id":"_sceneArea",
                                                   "events":{"rollOut":"___sceneArea_rollOut"},
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "percentHeight":100,
                                                         "percentWidth":100,
                                                         "childDescriptors":[new UIComponentDescriptor({
                                                            "type":ViewStack,
                                                            "id":"_stageViewStack",
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {"clipContent":false};
                                                            }
                                                         }),new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_maskLayer",
                                                            "events":{"creationComplete":"___maskLayer_creationComplete"},
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "percentWidth":100,
                                                                  "percentHeight":100,
                                                                  "styleName":"canvasTheater",
                                                                  "mouseChildren":false,
                                                                  "mouseEnabled":false,
                                                                  "mouseFocusEnabled":true
                                                               };
                                                            }
                                                         })]
                                                      };
                                                   }
                                                })]
                                             };
                                          }
                                       })]};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":UIComponent,
                                    "id":"_cameraBorder",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "mouseChildren":false,
                                          "mouseEnabled":false,
                                          "percentWidth":100,
                                          "percentHeight":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_panControl",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "visible":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_MainStage_Button4",
                                             "events":{"mouseDown":"___MainStage_Button4_mouseDown"},
                                             "stylesFactory":function():void
                                             {
                                                this.left = "10";
                                                this.verticalCenter = "0";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnPanLeft",
                                                   "buttonMode":true
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_MainStage_Button5",
                                             "events":{"mouseDown":"___MainStage_Button5_mouseDown"},
                                             "stylesFactory":function():void
                                             {
                                                this.right = "40";
                                                this.verticalCenter = "0";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnPanRight",
                                                   "buttonMode":true
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_MainStage_Button6",
                                             "events":{"mouseDown":"___MainStage_Button6_mouseDown"},
                                             "stylesFactory":function():void
                                             {
                                                this.top = "10";
                                                this.horizontalCenter = "0";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnPanUp",
                                                   "buttonMode":true
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_MainStage_Button7",
                                             "events":{"mouseDown":"___MainStage_Button7_mouseDown"},
                                             "stylesFactory":function():void
                                             {
                                                this.bottom = "10";
                                                this.horizontalCenter = "0";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnPanDown",
                                                   "buttonMode":true
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":AssetButtonBar,
                                    "id":"_assetButtonBar",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "scaleX":0.8,
                                          "scaleY":0.8,
                                          "isFullVersion":false,
                                          "styleName":"controlButtonBar",
                                          "visible":false
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_uiCanvasAutoSave",
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalCenter = "0";
                                       this.top = "2";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "alpha":0,
                                          "styleName":"popupMessage",
                                          "mouseChildren":false,
                                          "mouseEnabled":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_txtAutoSave",
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalCenter = "0";
                                                this.verticalCenter = "0";
                                                this.fontWeight = "bold";
                                                this.color = 2631720;
                                                this.textAlign = "center";
                                                this.fontSize = 16;
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_controlLayer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentHeight":100,
                                          "percentWidth":100,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_addSceneEffectLayer",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "verticalScrollPolicy":"off",
                                          "horizontalScrollPolicy":"off",
                                          "mouseChildren":false,
                                          "mouseEnabled":false
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_bottomControlBar",
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "styleName":"bottomControlBar",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_lookInToolBar",
                                    "stylesFactory":function():void
                                    {
                                       this.backgroundColor = 3355443;
                                       this.borderColor = 3355443;
                                       this.borderStyle = "solid";
                                       this.cornerRadius = 5;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "visible":false,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_MainStage_Button8",
                                             "events":{"click":"___MainStage_Button8_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "styleName":"btnZoomOut",
                                                   "focusEnabled":false,
                                                   "buttonMode":true
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"percentWidth":100};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_MainStage_Button9",
                                          "events":{"click":"___MainStage_Button9_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnAddScene",
                                                "buttonMode":true
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "id":"_btnSceneMenu",
                                          "events":{"click":"___btnSceneMenu_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "styleName":"btnAddSceneArrow",
                                                "buttonMode":true
                                             };
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___MainStage_Button11_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Test",
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":VBox,
                  "events":{
                     "rollOver":"___MainStage_VBox2_rollOver",
                     "rollOut":"___MainStage_VBox2_rollOut",
                     "mouseUp":"___MainStage_VBox2_mouseUp"
                  },
                  "stylesFactory":function():void
                  {
                     this.left = "0";
                     this.bottom = "0";
                     this.verticalGap = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":MiniMap,
                        "id":"_miniMap",
                        "events":{"viewChanged":"___miniMap_viewChanged"},
                        "propertiesFactory":function():Object
                        {
                           return {
                              "visible":false,
                              "includeInLayout":false
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_zoomControl",
                        "stylesFactory":function():void
                        {
                           this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "styleName":"topControlBar",
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":MiniMap,
                                 "id":"_microMap",
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "factor":0.04,
                                       "mouseChildren":false,
                                       "mouseEnabled":false
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":HSlider,
                                 "id":"_zoomSlider",
                                 "events":{"change":"___zoomSlider_change"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "minimum":0.5,
                                       "maximum":4,
                                       "snapInterval":0.05,
                                       "value":1,
                                       "liveDragging":true,
                                       "sliderThumbClass":ZoomSliderThumb,
                                       "buttonMode":true,
                                       "dataTipFormatFunction":zoomSliderDataTip,
                                       "styleName":"zoomSlider"
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Label,
                                 "id":"_MainStage_Label2",
                                 "stylesFactory":function():void
                                 {
                                    this.paddingTop = 10;
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Button,
                                 "events":{"click":"___MainStage_Button12_click"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "label":"1:1",
                                       "visible":false,
                                       "includeInLayout":false
                                    };
                                 }
                              })]
                           };
                        }
                     })]};
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_maskCanvasSceneButton",
                  "stylesFactory":function():void
                  {
                     this.right = "0";
                     this.bottom = "0";
                     this.backgroundColor = 16777215;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":200,
                        "height":200,
                        "alpha":0,
                        "visible":false
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"_maskCanvasScene",
                  "stylesFactory":function():void
                  {
                     this.backgroundColor = 16777215;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "alpha":0,
                        "visible":false
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.styleName = "mainStage";
         this.states = [this._MainStage_State1_c(),this._MainStage_State2_c(),this._MainStage_State3_c(),this._MainStage_State4_c()];
         this._MainStage_XMLList1_i();
         this._MainStage_Sequence1_i();
         this._MainStage_Fade3_i();
         this._MainStage_Fade4_i();
         this._MainStage_DropShadowFilter1_i();
         this._MainStage_NumberFormatter1_i();
         this.addEventListener("resize",this.___MainStage_Canvas1_resize);
         this.addEventListener("creationComplete",this.___MainStage_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MainStage._watcherSetupUtil = param1;
      }
      
      private function _MainStage_State4_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "emessage";
         _loc1_.basedOn = "simple";
         _loc1_.overrides = [this._MainStage_RemoveChild1_i(),this._MainStage_RemoveChild2_i()];
         return _loc1_;
      }
      
      private function get sceneCenter() : Point
      {
         return new Point(AnimeConstants.STAGE_WIDTH / 2 + AnimeConstants.STAGE_PADDING,AnimeConstants.STAGE_HEIGHT / 2 + AnimeConstants.STAGE_PADDING);
      }
      
      public function set _btnPaste(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._2110424330_btnPaste;
         if(_loc2_ !== param1)
         {
            this._2110424330_btnPaste = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnPaste",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnDelScene() : Button
      {
         return this._1960351742_btnDelScene;
      }
      
      public function set percentFormatter(param1:NumberFormatter) : void
      {
         var _loc2_:Object = this._1931449851percentFormatter;
         if(_loc2_ !== param1)
         {
            this._1931449851percentFormatter = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"percentFormatter",_loc2_,param1));
         }
      }
      
      public function ___MainStage_VBox2_rollOver(param1:MouseEvent) : void
      {
         this.showMiniMap(param1);
      }
      
      private function onStageAreaMouseOut(param1:MouseEvent) : void
      {
         if(param1.target is Canvas)
         {
            if(Canvas(param1.target).name == "_stageArea" || Canvas(param1.target).name == "_sceneArea" || Canvas(param1.target).name == "AnimeScene")
            {
               this._selectionTool.deactivate();
            }
         }
      }
      
      private function onSceneAreaRollOut(param1:MouseEvent) : void
      {
         var _loc2_:Asset = null;
         if(this.currentScene)
         {
            this.currentScene.assetGroup.stopDraggingGroup();
            _loc2_ = Console.getConsole().currDragObject;
            if(_loc2_ is Prop && Prop(_loc2_).motionShadow && Prop(_loc2_).motionShadow.bundle)
            {
               Prop(_loc2_).motionShadow.bundle.stopDrag();
            }
            else if(_loc2_ is Character && Character(_loc2_).motionShadow && Character(_loc2_).motionShadow.bundle)
            {
               Character(_loc2_).motionShadow.bundle.stopDrag();
            }
         }
      }
      
      private function _MainStage_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_copy");
         _loc1_ = UtilDict.toDisplay("go","Copy");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_paste");
         _loc1_ = UtilDict.toDisplay("go","Paste");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_undo");
         _loc1_ = UtilDict.toDisplay("go","Undo");
         _loc1_ = UtilDict.toDisplay("go","topbtnbar_redo");
         _loc1_ = UtilDict.toDisplay("go","Redo");
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = UtilUser.isDeveloper;
         _loc1_ = AnimeConstants.STAGE_WIDTH + AnimeConstants.STAGE_PADDING * 2;
         _loc1_ = AnimeConstants.STAGE_HEIGHT + AnimeConstants.STAGE_PADDING * 2;
         _loc1_ = AnimeConstants.STAGE_PADDING;
         _loc1_ = AnimeConstants.STAGE_PADDING;
         _loc1_ = [this.panDropShadow];
         _loc1_ = UtilDict.toDisplay("go","Pan Left");
         _loc1_ = this.isContentOnLeft;
         _loc1_ = UtilDict.toDisplay("go","Pan Right");
         _loc1_ = this.isContentOnRight;
         _loc1_ = UtilDict.toDisplay("go","Pan Up");
         _loc1_ = this.isContentOnTop;
         _loc1_ = UtilDict.toDisplay("go","Pan Down");
         _loc1_ = this.isContentOnBottom;
         _loc1_ = UtilDict.toDisplay("go","mainstage_autosavedone");
         _loc1_ = UtilDict.toDisplay("go","ctrlbtnbar_lookout");
         _loc1_ = UtilDict.toDisplay("go","Add Scene");
         _loc1_ = this._sceneLayer;
         _loc1_ = this._sceneLayer;
         _loc1_ = this.percentFormatter.format(this._zoomSlider.value * 100) + " %";
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = this._uiCanvasAutoSave;
         _loc1_ = UtilDict.toDisplay("go","Add Scene");
         _loc1_ = UtilDict.toDisplay("go","Add Blank Scene");
         _loc1_ = this._zoomControl;
         _loc1_ = this._zoomControl;
         _loc1_ = this._panControl;
         _loc1_ = this._panControl;
         _loc1_ = this._btnCopy;
         _loc1_ = this._btnPaste;
         _loc1_ = this._btnUndo;
         _loc1_ = this._btnRedo;
         _loc1_ = this._bottomControlBar;
         _loc1_ = UtilDict.toDisplay("go","mainstage_displaying");
         _loc1_ = this._bottomControlBar;
         _loc1_ = UtilDict.toDisplay("go","mainstage_scene") + " " + this.sceneIndexStr;
         _loc1_ = this._bottomControlBar;
         _loc1_ = UtilDict.toDisplay("go","mainstage_addscene");
         _loc1_ = this._bottomControlBar;
         _loc1_ = UtilDict.toDisplay("go","mainstage_delscene");
         _loc1_ = this._topControlBar;
         _loc1_ = this._bottomControlBar;
      }
      
      private function onAddSceneBtnClick() : void
      {
         Console.getConsole().addNextScene();
      }
      
      public function ___MainStage_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get pause() : Pause
      {
         return this._106440182pause;
      }
      
      [Bindable(event="propertyChange")]
      public function get percentFormatter() : NumberFormatter
      {
         return this._1931449851percentFormatter;
      }
      
      public function enableRedo(param1:Boolean) : void
      {
         this._btnRedo.enabled = param1;
      }
      
      private function _MainStage_SetProperty3_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty3 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_MainStage_SetProperty3",this._MainStage_SetProperty3);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvasSceneButton() : Canvas
      {
         return this._240112165_maskCanvasSceneButton;
      }
      
      public function ___maskLayer_creationComplete(param1:FlexEvent) : void
      {
         this.drawOffStage();
      }
      
      public function set _btnDelScene(param1:Button) : void
      {
         var _loc2_:Object = this._1960351742_btnDelScene;
         if(_loc2_ !== param1)
         {
            this._1960351742_btnDelScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnDelScene",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _addSceneEffectLayer() : Canvas
      {
         return this._2002216470_addSceneEffectLayer;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnUndo() : IconTextButton
      {
         return this._1730485215_btnUndo;
      }
      
      private function drawOffStage() : void
      {
         this._maskLayer.graphics.clear();
         this._maskLayer.graphics.lineStyle(0,0,0);
         this._maskLayer.graphics.beginFill(StyleManager.getStyleDeclaration(".mainStage").getStyle("backgroundColor"),0.5);
         this._maskLayer.graphics.drawRect(0,0,this._maskLayer.width,this._maskLayer.height);
         this._maskLayer.graphics.drawRect((this._maskLayer.width - AnimeConstants.SCREEN_WIDTH) / 2,(this._maskLayer.height - AnimeConstants.SCREEN_HEIGHT) / 2,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this._maskLayer.graphics.endFill();
      }
      
      private function _MainStage_RemoveChild1_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._MainStage_RemoveChild1 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_RemoveChild1",this._MainStage_RemoveChild1);
         return _loc1_;
      }
      
      private function _MainStage_State3_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "domo";
         _loc1_.basedOn = "cn";
         return _loc1_;
      }
      
      public function set pause(param1:Pause) : void
      {
         var _loc2_:Object = this._106440182pause;
         if(_loc2_ !== param1)
         {
            this._106440182pause = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pause",_loc2_,param1));
         }
      }
      
      public function ___stageArea_mouseOut(param1:MouseEvent) : void
      {
         this.onStageAreaMouseOut(param1);
      }
      
      private function _MainStage_SetProperty2_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty2 = _loc1_;
         _loc1_.name = "includeInLayout";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_MainStage_SetProperty2",this._MainStage_SetProperty2);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskLayer() : Canvas
      {
         return this._1558819770_maskLayer;
      }
      
      public function get loggedIn() : Boolean
      {
         return this._loggedIn;
      }
      
      public function ___MainStage_Button2_click(param1:MouseEvent) : void
      {
         this.showLog();
      }
      
      public function set _btnUndo(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1730485215_btnUndo;
         if(_loc2_ !== param1)
         {
            this._1730485215_btnUndo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnUndo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _zoomControl() : HBox
      {
         return this._599927733_zoomControl;
      }
      
      [Bindable(event="propertyChange")]
      public function get _miniMap() : MiniMap
      {
         return this._872235962_miniMap;
      }
      
      public function showCameraView() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         if(!this._isCameraMode && this.currentScene && this.currentScene.sizingAsset)
         {
            this.currentScene.hideEffects(true,true);
            _loc1_ = this.currentScene.sizingAsset.getBounds(this._sceneLayer);
            _loc2_ = Math.min(this._stageArea.width / this.currentScene.sizingAsset.width,this._stageArea.height / this.currentScene.sizingAsset.height);
            this.zoomTo(_loc2_,_loc1_.x + _loc1_.width / 2,_loc1_.y + _loc1_.height / 2);
            this._lookInToolBar.visible = true;
            this._zoomControl.includeInLayout = this._zoomControl.visible = false;
            this.drawCameraBorder(this.currentScene.sizingAsset.height / this.currentScene.sizingAsset.width);
            this.showAssetButtonBar();
            this.hideMiniMap();
            this._isCameraMode = true;
         }
      }
      
      public function set _btnAddScene(param1:Button) : void
      {
         var _loc2_:Object = this._89648856_btnAddScene;
         if(_loc2_ !== param1)
         {
            this._89648856_btnAddScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnAddScene",_loc2_,param1));
         }
      }
      
      public function ___MainStage_Button11_click(param1:MouseEvent) : void
      {
         this.showAutoSaveHints();
      }
      
      [Bindable(event="propertyChange")]
      public function get _zoomSlider() : HSlider
      {
         return this._435778611_zoomSlider;
      }
      
      [Bindable(event="propertyChange")]
      public function get isContentOnTop() : Boolean
      {
         return this._55520327isContentOnTop;
      }
      
      public function set _addSceneEffectLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._2002216470_addSceneEffectLayer;
         if(_loc2_ !== param1)
         {
            this._2002216470_addSceneEffectLayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_addSceneEffectLayer",_loc2_,param1));
         }
      }
      
      public function hideAssetButtonBar() : void
      {
         this._assetButtonBar.visible = false;
      }
      
      public function hideCameraView() : void
      {
         if(this._isCameraMode)
         {
            if(this.currentScene)
            {
               this.currentScene.showEffects(true);
            }
            this.zoomTo(1,this.sceneCenter.x,this.sceneCenter.y);
            this._zoomSlider.value = 1;
            this._lookInToolBar.visible = false;
            if(this.currentState != "cn" && this.currentState != "domo")
            {
               this._zoomControl.includeInLayout = this._zoomControl.visible = true;
            }
            this._cameraBorder.graphics.clear();
            this.currentScene.selectedAsset = null;
            this._isCameraMode = false;
         }
      }
      
      private function _MainStage_Button14_i() : Button
      {
         var _loc1_:Button = new Button();
         this._btnDelScene = _loc1_;
         _loc1_.styleName = "btnDelScene";
         _loc1_.buttonMode = true;
         _loc1_.addEventListener("click",this.___btnDelScene_click);
         _loc1_.id = "_btnDelScene";
         BindingManager.executeBindings(this,"_btnDelScene",this._btnDelScene);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _bottomControlBar() : HBox
      {
         return this._51913824_bottomControlBar;
      }
      
      public function ___MainStage_Canvas1_resize(param1:ResizeEvent) : void
      {
         this.onResize(param1);
      }
      
      public function showAutoSaveHints() : void
      {
         if(UtilUser.loggedIn)
         {
            this._txtAutoSave.text = UtilDict.toDisplay("go","mainstage_autosavedone");
         }
         else
         {
            this.pause.duration = 5000;
            this._txtAutoSave.text = UtilDict.toDisplay("go","mainstage_remind_to_save");
         }
         this._efAutoSave.play();
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
         }
      }
      
      public function ___btnHistoryMenu_click(param1:MouseEvent) : void
      {
         this.showHistoryMenu(param1);
      }
      
      public function set _efAutoSave(param1:Sequence) : void
      {
         var _loc2_:Object = this._246888748_efAutoSave;
         if(_loc2_ !== param1)
         {
            this._246888748_efAutoSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_efAutoSave",_loc2_,param1));
         }
      }
      
      public function set _btnHistoryMenu(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1452717514_btnHistoryMenu;
         if(_loc2_ !== param1)
         {
            this._1452717514_btnHistoryMenu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnHistoryMenu",_loc2_,param1));
         }
      }
      
      public function set _zoomSlider(param1:HSlider) : void
      {
         var _loc2_:Object = this._435778611_zoomSlider;
         if(_loc2_ !== param1)
         {
            this._435778611_zoomSlider = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_zoomSlider",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnHistoryMenu() : IconTextButton
      {
         return this._1452717514_btnHistoryMenu;
      }
      
      public function set _stageArea(param1:Canvas) : void
      {
         var _loc2_:Object = this._347427628_stageArea;
         if(_loc2_ !== param1)
         {
            this._347427628_stageArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_stageArea",_loc2_,param1));
         }
      }
      
      public function get updatable() : Boolean
      {
         return this._bottomControlBar.enabled;
      }
      
      public function set zoomFactor(param1:Number) : void
      {
         var _loc2_:Object = this._1035034878zoomFactor;
         if(_loc2_ !== param1)
         {
            this._1035034878zoomFactor = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zoomFactor",_loc2_,param1));
         }
      }
      
      private function _MainStage_DropShadowFilter1_i() : DropShadowFilter
      {
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         this.panDropShadow = _loc1_;
         _loc1_.distance = 3;
         return _loc1_;
      }
      
      private function _MainStage_SetProperty1_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty1 = _loc1_;
         _loc1_.name = "visible";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_MainStage_SetProperty1",this._MainStage_SetProperty1);
         return _loc1_;
      }
      
      private function _MainStage_State2_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "cn";
         _loc1_.basedOn = "simple";
         _loc1_.overrides = [this._MainStage_SetProperty5_i(),this._MainStage_SetProperty6_i(),this._MainStage_SetProperty7_i(),this._MainStage_SetProperty8_i(),this._MainStage_AddChild1_i(),this._MainStage_AddChild2_i(),this._MainStage_AddChild3_i(),this._MainStage_AddChild4_i()];
         return _loc1_;
      }
      
      private function onMovieMenuItemClick(param1:MenuEvent) : void
      {
         if(param1.index == 0)
         {
            Console.getConsole().addNextScene();
         }
         else if(param1.index == 1)
         {
            Console.getConsole().addNextScene(true);
         }
      }
      
      public function set _maskLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1558819770_maskLayer;
         if(_loc2_ !== param1)
         {
            this._1558819770_maskLayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskLayer",_loc2_,param1));
         }
      }
      
      public function set _btnRedo(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1730583237_btnRedo;
         if(_loc2_ !== param1)
         {
            this._1730583237_btnRedo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnRedo",_loc2_,param1));
         }
      }
      
      private function onLinkClick(param1:String) : void
      {
         var _loc2_:GoAlert = null;
         if(Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            _loc2_ = GoAlert(PopUpManager.createPopUp(this,GoAlert,true));
            _loc2_._lblConfirm.text = "";
            _loc2_._txtDelete.text = "To import your own graphics, please use goanimate.com";
            _loc2_._btnDelete.visible = false;
            _loc2_._btnCancel.label = "OK";
            _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
            _loc2_.y = 100;
            return;
         }
         this._targetUploadType_in_importer = param1;
         Console.getConsole().thumbTray.showUserGoodies(param1);
         this.doShowImporterWindow();
      }
      
      [Bindable(event="propertyChange")]
      public function get _assetButtonBar() : AssetButtonBar
      {
         return this._1858283664_assetButtonBar;
      }
      
      private function _MainStage_AddChild4_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         this._MainStage_AddChild4 = _loc1_;
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Button14_i);
         BindingManager.executeBindings(this,"_MainStage_AddChild4",this._MainStage_AddChild4);
         return _loc1_;
      }
      
      public function set _maskCanvasScene(param1:Canvas) : void
      {
         var _loc2_:Object = this._607259319_maskCanvasScene;
         if(_loc2_ !== param1)
         {
            this._607259319_maskCanvasScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvasScene",_loc2_,param1));
         }
      }
      
      public function get currentScene() : AnimeScene
      {
         if(Console.getConsole())
         {
            return Console.getConsole().currentScene;
         }
         return null;
      }
      
      [Bindable(event="propertyChange")]
      public function set loggedIn(param1:Boolean) : void
      {
         var _loc2_:Object = this.loggedIn;
         if(_loc2_ !== param1)
         {
            this._2020648519loggedIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loggedIn",_loc2_,param1));
         }
      }
      
      public function set _zoomControl(param1:HBox) : void
      {
         var _loc2_:Object = this._599927733_zoomControl;
         if(_loc2_ !== param1)
         {
            this._599927733_zoomControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_zoomControl",_loc2_,param1));
         }
      }
      
      private function _MainStage_Button13_i() : Button
      {
         var _loc1_:Button = new Button();
         this._btnAddScene = _loc1_;
         _loc1_.styleName = "btnAddScene";
         _loc1_.buttonMode = true;
         _loc1_.addEventListener("click",this.___btnAddScene_click);
         _loc1_.id = "_btnAddScene";
         BindingManager.executeBindings(this,"_btnAddScene",this._btnAddScene);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function pan(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = this._documentLayer.scrollRect;
         if(_loc3_.width <= this._sceneLayer.width)
         {
            if(_loc3_.x + param1 <= 0)
            {
               _loc3_.x = 0;
            }
            else if(_loc3_.x + param1 + _loc3_.width >= this._sceneLayer.width)
            {
               _loc3_.x = this._sceneLayer.width - _loc3_.width;
            }
            else
            {
               _loc3_.x = _loc3_.x + param1;
            }
         }
         else
         {
            _loc3_.x = (this._sceneLayer.width - _loc3_.width) / 2;
         }
         if(_loc3_.height <= this._sceneLayer.height)
         {
            if(_loc3_.y + param2 <= 0)
            {
               _loc3_.y = 0;
            }
            else if(_loc3_.y + param2 + _loc3_.height >= this._sceneLayer.height)
            {
               _loc3_.y = this._sceneLayer.height - _loc3_.height;
            }
            else
            {
               _loc3_.y = _loc3_.y + param2;
            }
         }
         else
         {
            _loc3_.y = (this._sceneLayer.height - _loc3_.height) / 2;
         }
         this._documentLayer.scrollRect = _loc3_;
         this.updateBindable();
         this._microMap.viewRect = this._documentLayer.scrollRect;
         this._miniMap.viewRect = this._documentLayer.scrollRect;
         if(this.currentScene)
         {
            this.currentScene.assetGroup.hideControl();
         }
         this.hideAssetButtonBar();
      }
      
      private function _MainStage_NumberFormatter1_i() : NumberFormatter
      {
         var _loc1_:NumberFormatter = new NumberFormatter();
         this.percentFormatter = _loc1_;
         _loc1_.precision = 0;
         _loc1_.rounding = "nearest";
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _lookInToolBar() : HBox
      {
         return this._2046797976_lookInToolBar;
      }
      
      public function get sceneIndexStr() : String
      {
         if(this._sceneIndexStr == null)
         {
            this._sceneIndexStr = "";
         }
         return this._sceneIndexStr;
      }
      
      public function set isContentOnLeft(param1:Boolean) : void
      {
         var _loc2_:Object = this._1720882005isContentOnLeft;
         if(_loc2_ !== param1)
         {
            this._1720882005isContentOnLeft = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isContentOnLeft",_loc2_,param1));
         }
      }
      
      public function ___MainStage_Button6_mouseDown(param1:MouseEvent) : void
      {
         this.pan(0,-100);
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnCopy() : IconTextButton
      {
         return this._1731020110_btnCopy;
      }
      
      private function _MainStage_State1_c() : State
      {
         var _loc1_:State = new State();
         _loc1_.name = "simple";
         _loc1_.overrides = [this._MainStage_SetProperty1_i(),this._MainStage_SetProperty2_i(),this._MainStage_SetProperty3_i(),this._MainStage_SetProperty4_i()];
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _txtAutoSave() : Label
      {
         return this._1570224285_txtAutoSave;
      }
      
      public function set _bottomControlBar(param1:HBox) : void
      {
         var _loc2_:Object = this._51913824_bottomControlBar;
         if(_loc2_ !== param1)
         {
            this._51913824_bottomControlBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bottomControlBar",_loc2_,param1));
         }
      }
      
      private function _MainStage_Sequence1_i() : Sequence
      {
         var _loc1_:Sequence = new Sequence();
         this._efAutoSave = _loc1_;
         _loc1_.children = [this._MainStage_Fade1_i(),this._MainStage_Pause1_i(),this._MainStage_Fade2_i()];
         return _loc1_;
      }
      
      private function onStageAreaMouseDown(param1:MouseEvent) : void
      {
         if(param1.target is Canvas)
         {
            if(Canvas(param1.target).name == "_stageArea" || Canvas(param1.target).name == "_sceneArea" || Canvas(param1.target).name == "AnimeScene")
            {
               if(this.currentScene)
               {
                  this.currentScene.selectedAsset = null;
               }
               this.setFocus();
            }
         }
      }
      
      private function _MainStage_Label4_i() : Label
      {
         var _loc1_:Label = new Label();
         this._MainStage_Label4 = _loc1_;
         _loc1_.styleName = "textColoring";
         _loc1_.setStyle("textDecoration","underline");
         _loc1_.id = "_MainStage_Label4";
         BindingManager.executeBindings(this,"_MainStage_Label4",this._MainStage_Label4);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _MainStage_SetProperty8_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty8 = _loc1_;
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         BindingManager.executeBindings(this,"_MainStage_SetProperty8",this._MainStage_SetProperty8);
         return _loc1_;
      }
      
      public function set _miniMap(param1:MiniMap) : void
      {
         var _loc2_:Object = this._872235962_miniMap;
         if(_loc2_ !== param1)
         {
            this._872235962_miniMap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_miniMap",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get isContentOnRight() : Boolean
      {
         return this._1813395598isContentOnRight;
      }
      
      private function _MainStage_AddChild3_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         this._MainStage_AddChild3 = _loc1_;
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Button13_i);
         BindingManager.executeBindings(this,"_MainStage_AddChild3",this._MainStage_AddChild3);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOutMap() : Fade
      {
         return this._2089711414fadeOutMap;
      }
      
      public function showAssetButtonBar() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.currentScene == null || Console.getConsole().isTutorialOn)
         {
            return;
         }
         var _loc1_:Asset = this.currentScene.selectedAsset;
         var _loc2_:AssetGroup = this.currentScene.assetGroup;
         var _loc3_:Rectangle = null;
         if(_loc2_.length > 1)
         {
            this._assetButtonBar.target = _loc2_;
            _loc3_ = _loc2_.getBounds(this._stageArea);
         }
         else if(_loc1_)
         {
            if(_loc1_ is ProgramEffectAsset && ProgramEffectAsset(_loc1_).getExactType() != "zoom")
            {
               return;
            }
            this._assetButtonBar.target = _loc1_;
            _loc3_ = _loc1_.getBounds(this._stageArea);
         }
         if(_loc3_)
         {
            if(!(_loc1_ && _loc1_ is Background) && !(_loc1_ && _loc1_ is EffectAsset && EffectAsset(_loc1_).isCamera))
            {
               _loc3_.inflate(10,10);
            }
            _loc4_ = this._assetButtonBar.height;
            _loc5_ = this._assetButtonBar.width;
            _loc6_ = _loc3_.x;
            if((_loc7_ = _loc3_.y - _loc4_) < 0)
            {
               _loc7_ = 0;
               if(_loc6_ + _loc3_.width + _loc5_ > this._stageArea.width)
               {
                  _loc6_ = _loc6_ - _loc5_;
               }
               else
               {
                  _loc6_ = _loc6_ + _loc3_.width;
               }
            }
            if(_loc6_ < 0)
            {
               _loc6_ = 0;
            }
            else if(_loc6_ + _loc5_ > this._stageArea.width)
            {
               _loc6_ = this._stageArea.width - _loc5_;
            }
            this._assetButtonBar.x = _loc6_;
            this._assetButtonBar.y = _loc7_;
            this._assetButtonBar.visible = true;
         }
      }
      
      public function set _microMap(param1:MiniMap) : void
      {
         var _loc2_:Object = this._1575126697_microMap;
         if(_loc2_ !== param1)
         {
            this._1575126697_microMap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_microMap",_loc2_,param1));
         }
      }
      
      public function set isContentOnTop(param1:Boolean) : void
      {
         var _loc2_:Object = this._55520327isContentOnTop;
         if(_loc2_ !== param1)
         {
            this._55520327isContentOnTop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isContentOnTop",_loc2_,param1));
         }
      }
      
      private function showHistoryMenu(param1:MouseEvent) : void
      {
         var _loc2_:Array = CommandStack.getInstance().stack;
         _loc2_.reverse();
         var _loc3_:Menu = Menu.createMenu(null,_loc2_,true);
         _loc3_.labelField = "_type";
         _loc3_.show(param1.stageX - 20,param1.stageY + 12);
      }
      
      public function set panDropShadow(param1:DropShadowFilter) : void
      {
         var _loc2_:Object = this._355954324panDropShadow;
         if(_loc2_ !== param1)
         {
            this._355954324panDropShadow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"panDropShadow",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _topControlBar() : HBox
      {
         return this._74363220_topControlBar;
      }
      
      public function set _uiCanvasAutoSave(param1:Canvas) : void
      {
         var _loc2_:Object = this._766521513_uiCanvasAutoSave;
         if(_loc2_ !== param1)
         {
            this._766521513_uiCanvasAutoSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_uiCanvasAutoSave",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeInMap() : Fade
      {
         return this._904480549fadeInMap;
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      private function _MainStage_Fade4_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeOutMap = _loc1_;
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         return _loc1_;
      }
      
      public function set updatable(param1:Boolean) : void
      {
         this._bottomControlBar.enabled = this._bottomControlBar.mouseChildren = this._bottomControlBar.mouseEnabled = param1;
      }
      
      private function onStageAreaMouseOver(param1:MouseEvent) : void
      {
         if(param1.target is Canvas)
         {
            if(Canvas(param1.target).name == "_stageArea" || Canvas(param1.target).name == "_sceneArea" || Canvas(param1.target).name == "AnimeScene")
            {
               this._selectionTool.activate();
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnSceneMenu() : Button
      {
         return this._1034752274_btnSceneMenu;
      }
      
      public function ___MainStage_Button1_click(param1:MouseEvent) : void
      {
         Console.getConsole().alertSceneXml();
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnPaste() : IconTextButton
      {
         return this._2110424330_btnPaste;
      }
      
      public function ___MainStage_Button9_click(param1:MouseEvent) : void
      {
         this.onAddSceneBtnClick();
      }
      
      private function onStageAreaMouseUp(param1:MouseEvent) : void
      {
         if(this.currentScene)
         {
            this.currentScene.assetGroup.showControl();
         }
         this.showAssetButtonBar();
      }
      
      public function changeToMessageMode() : void
      {
         this.currentState = "emessage";
      }
      
      private function updateBindable() : void
      {
         var _loc1_:Number = 5;
         this.isContentOnTop = this._documentLayer.scrollRect.y - _loc1_ > this._sceneLayer.y?true:false;
         this.isContentOnBottom = this._documentLayer.scrollRect.y + this._documentLayer.scrollRect.height + _loc1_ < this._sceneLayer.height?true:false;
         this.isContentOnLeft = this._documentLayer.scrollRect.x - _loc1_ > this._sceneLayer.x?true:false;
         this.isContentOnRight = this._documentLayer.scrollRect.x + this._documentLayer.scrollRect.width + _loc1_ < this._sceneLayer.width?true:false;
      }
      
      private function _MainStage_Label3_i() : Label
      {
         var _loc1_:Label = new Label();
         this._MainStage_Label3 = _loc1_;
         _loc1_.styleName = "textColoring";
         _loc1_.id = "_MainStage_Label3";
         BindingManager.executeBindings(this,"_MainStage_Label3",this._MainStage_Label3);
         if(!_loc1_.document)
         {
            _loc1_.document = this;
         }
         return _loc1_;
      }
      
      private function _MainStage_SetProperty7_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty7 = _loc1_;
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         BindingManager.executeBindings(this,"_MainStage_SetProperty7",this._MainStage_SetProperty7);
         return _loc1_;
      }
      
      private function _MainStage_AddChild2_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         this._MainStage_AddChild2 = _loc1_;
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Label4_i);
         BindingManager.executeBindings(this,"_MainStage_AddChild2",this._MainStage_AddChild2);
         return _loc1_;
      }
      
      private function set _2020648519loggedIn(param1:Boolean) : void
      {
         this._loggedIn = param1;
      }
      
      private function drawCameraBorder(param1:Number) : void
      {
         this._cameraBorder.graphics.clear();
         this._cameraBorder.graphics.lineStyle(5);
         var _loc2_:Rectangle = new Rectangle(0,0,this._stageArea.width,this._stageArea.height);
         if(_loc2_.height / _loc2_.width > param1)
         {
            _loc2_.height = param1 * _loc2_.width;
            _loc2_.y = (this._stageArea.height - _loc2_.height) / 2;
         }
         else
         {
            _loc2_.width = _loc2_.height / param1;
            _loc2_.x = (this._stageArea.width - _loc2_.width) / 2;
         }
         UtilDraw.drawDashRect(this._cameraBorder,_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height,6,8);
      }
      
      public function enableUndo(param1:Boolean) : void
      {
         this._btnUndo.enabled = param1;
      }
      
      public function setLoadingStatus(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            this._maskCanvasScene.visible = param1;
         }
         else
         {
            this._maskCanvasSceneButton.visible = param1;
         }
      }
      
      public function ___zoomSlider_change(param1:SliderEvent) : void
      {
         this.onZoomSliderChange(param1);
      }
      
      public function ___MainStage_VBox2_rollOut(param1:MouseEvent) : void
      {
         this.hideMiniMap();
      }
      
      public function ___btnSceneMenu_click(param1:MouseEvent) : void
      {
         this.showSceneMenu(param1);
      }
      
      private function init() : void
      {
         this._selectionTool = new SelectionTool(this._stageArea);
         this._sceneLayer.scrollRect = new Rectangle(0,0,AnimeConstants.STAGE_WIDTH + AnimeConstants.STAGE_PADDING * 2,AnimeConstants.STAGE_HEIGHT + AnimeConstants.STAGE_PADDING * 2);
         this.onResize();
      }
      
      public function set isContentOnRight(param1:Boolean) : void
      {
         var _loc2_:Object = this._1813395598isContentOnRight;
         if(_loc2_ !== param1)
         {
            this._1813395598isContentOnRight = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isContentOnRight",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _documentLayer() : Canvas
      {
         return this._784031479_documentLayer;
      }
      
      public function set _assetButtonBar(param1:AssetButtonBar) : void
      {
         var _loc2_:Object = this._1858283664_assetButtonBar;
         if(_loc2_ !== param1)
         {
            this._1858283664_assetButtonBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_assetButtonBar",_loc2_,param1));
         }
      }
      
      private function _MainStage_Fade3_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeInMap = _loc1_;
         _loc1_.duration = 500;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         return _loc1_;
      }
      
      private function showLog() : void
      {
         PopUpManager.createPopUp(this,LogWindow,true);
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnAddScene() : Button
      {
         return this._89648856_btnAddScene;
      }
      
      public function set _lookInToolBar(param1:HBox) : void
      {
         var _loc2_:Object = this._2046797976_lookInToolBar;
         if(_loc2_ !== param1)
         {
            this._2046797976_lookInToolBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_lookInToolBar",_loc2_,param1));
         }
      }
      
      public function get isCameraMode() : Boolean
      {
         return this._isCameraMode;
      }
      
      public function ___MainStage_Button4_mouseDown(param1:MouseEvent) : void
      {
         this.pan(-100,0);
      }
      
      public function set _cameraBorder(param1:UIComponent) : void
      {
         var _loc2_:Object = this._766696848_cameraBorder;
         if(_loc2_ !== param1)
         {
            this._766696848_cameraBorder = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cameraBorder",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnRedo() : IconTextButton
      {
         return this._1730583237_btnRedo;
      }
      
      private function _MainStage_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_copy");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCopy.toolTip = param1;
         },"_btnCopy.toolTip");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Copy");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnCopy.label = param1;
         },"_btnCopy.label");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_paste");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnPaste.toolTip = param1;
         },"_btnPaste.toolTip");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Paste");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnPaste.label = param1;
         },"_btnPaste.label");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_undo");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnUndo.toolTip = param1;
         },"_btnUndo.toolTip");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Undo");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnUndo.label = param1;
         },"_btnUndo.label");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","topbtnbar_redo");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnRedo.toolTip = param1;
         },"_btnRedo.toolTip");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Redo");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnRedo.label = param1;
         },"_btnRedo.label");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _btnHistoryMenu.visible = param1;
         },"_btnHistoryMenu.visible");
         result[8] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _btnHistoryMenu.includeInLayout = param1;
         },"_btnHistoryMenu.includeInLayout");
         result[9] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _MainStage_Button1.visible = param1;
         },"_MainStage_Button1.visible");
         result[10] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _MainStage_Button1.includeInLayout = param1;
         },"_MainStage_Button1.includeInLayout");
         result[11] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _MainStage_Button2.visible = param1;
         },"_MainStage_Button2.visible");
         result[12] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _MainStage_Button2.includeInLayout = param1;
         },"_MainStage_Button2.includeInLayout");
         result[13] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _MainStage_Button3.visible = param1;
         },"_MainStage_Button3.visible");
         result[14] = binding;
         binding = new Binding(this,function():Boolean
         {
            return UtilUser.isDeveloper;
         },function(param1:Boolean):void
         {
            _MainStage_Button3.includeInLayout = param1;
         },"_MainStage_Button3.includeInLayout");
         result[15] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_WIDTH + AnimeConstants.STAGE_PADDING * 2;
         },function(param1:Number):void
         {
            _sceneLayer.width = param1;
         },"_sceneLayer.width");
         result[16] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_HEIGHT + AnimeConstants.STAGE_PADDING * 2;
         },function(param1:Number):void
         {
            _sceneLayer.height = param1;
         },"_sceneLayer.height");
         result[17] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },function(param1:Number):void
         {
            _stageViewStack.x = param1;
         },"_stageViewStack.x");
         result[18] = binding;
         binding = new Binding(this,function():Number
         {
            return AnimeConstants.STAGE_PADDING;
         },function(param1:Number):void
         {
            _stageViewStack.y = param1;
         },"_stageViewStack.y");
         result[19] = binding;
         binding = new Binding(this,function():Array
         {
            return [panDropShadow];
         },function(param1:Array):void
         {
            _panControl.filters = param1;
         },"_panControl.filters");
         result[20] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Pan Left");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button4.toolTip = param1;
         },"_MainStage_Button4.toolTip");
         result[21] = binding;
         binding = new Binding(this,function():Boolean
         {
            return isContentOnLeft;
         },function(param1:Boolean):void
         {
            _MainStage_Button4.visible = param1;
         },"_MainStage_Button4.visible");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Pan Right");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button5.toolTip = param1;
         },"_MainStage_Button5.toolTip");
         result[23] = binding;
         binding = new Binding(this,function():Boolean
         {
            return isContentOnRight;
         },function(param1:Boolean):void
         {
            _MainStage_Button5.visible = param1;
         },"_MainStage_Button5.visible");
         result[24] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Pan Up");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button6.toolTip = param1;
         },"_MainStage_Button6.toolTip");
         result[25] = binding;
         binding = new Binding(this,function():Boolean
         {
            return isContentOnTop;
         },function(param1:Boolean):void
         {
            _MainStage_Button6.visible = param1;
         },"_MainStage_Button6.visible");
         result[26] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Pan Down");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button7.toolTip = param1;
         },"_MainStage_Button7.toolTip");
         result[27] = binding;
         binding = new Binding(this,function():Boolean
         {
            return isContentOnBottom;
         },function(param1:Boolean):void
         {
            _MainStage_Button7.visible = param1;
         },"_MainStage_Button7.visible");
         result[28] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_autosavedone");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _txtAutoSave.text = param1;
         },"_txtAutoSave.text");
         result[29] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","ctrlbtnbar_lookout");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button8.toolTip = param1;
         },"_MainStage_Button8.toolTip");
         result[30] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add Scene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Button9.label = param1;
         },"_MainStage_Button9.label");
         result[31] = binding;
         binding = new Binding(this,function():Canvas
         {
            return _sceneLayer;
         },function(param1:Canvas):void
         {
            _miniMap.map = param1;
         },"_miniMap.map");
         result[32] = binding;
         binding = new Binding(this,function():Canvas
         {
            return _sceneLayer;
         },function(param1:Canvas):void
         {
            _microMap.map = param1;
         },"_microMap.map");
         result[33] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = percentFormatter.format(_zoomSlider.value * 100) + " %";
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Label2.text = param1;
         },"_MainStage_Label2.text");
         result[34] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            fadeIn.target = param1;
         },"fadeIn.target");
         result[35] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            pause.target = param1;
         },"pause.target");
         result[36] = binding;
         binding = new Binding(this,function():Object
         {
            return _uiCanvasAutoSave;
         },function(param1:Object):void
         {
            fadeOut.target = param1;
         },"fadeOut.target");
         result[37] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Add Scene");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            _dpMovieMenu[0].@label = param1;
         },"_dpMovieMenu.node[0]");
         result[38] = binding;
         binding = new Binding(this,function():*
         {
            return UtilDict.toDisplay("go","Add Blank Scene");
         },function(param1:*):void
         {
            var _loc2_:* = new Namespace("");
            _dpMovieMenu[1].@label = param1;
         },"_dpMovieMenu.node[1]");
         result[39] = binding;
         binding = new Binding(this,function():Object
         {
            return _zoomControl;
         },function(param1:Object):void
         {
            _MainStage_SetProperty1.target = param1;
         },"_MainStage_SetProperty1.target");
         result[40] = binding;
         binding = new Binding(this,function():Object
         {
            return _zoomControl;
         },function(param1:Object):void
         {
            _MainStage_SetProperty2.target = param1;
         },"_MainStage_SetProperty2.target");
         result[41] = binding;
         binding = new Binding(this,function():Object
         {
            return _panControl;
         },function(param1:Object):void
         {
            _MainStage_SetProperty3.target = param1;
         },"_MainStage_SetProperty3.target");
         result[42] = binding;
         binding = new Binding(this,function():Object
         {
            return _panControl;
         },function(param1:Object):void
         {
            _MainStage_SetProperty4.target = param1;
         },"_MainStage_SetProperty4.target");
         result[43] = binding;
         binding = new Binding(this,function():Object
         {
            return _btnCopy;
         },function(param1:Object):void
         {
            _MainStage_SetProperty5.target = param1;
         },"_MainStage_SetProperty5.target");
         result[44] = binding;
         binding = new Binding(this,function():Object
         {
            return _btnPaste;
         },function(param1:Object):void
         {
            _MainStage_SetProperty6.target = param1;
         },"_MainStage_SetProperty6.target");
         result[45] = binding;
         binding = new Binding(this,function():Object
         {
            return _btnUndo;
         },function(param1:Object):void
         {
            _MainStage_SetProperty7.target = param1;
         },"_MainStage_SetProperty7.target");
         result[46] = binding;
         binding = new Binding(this,function():Object
         {
            return _btnRedo;
         },function(param1:Object):void
         {
            _MainStage_SetProperty8.target = param1;
         },"_MainStage_SetProperty8.target");
         result[47] = binding;
         binding = new Binding(this,function():UIComponent
         {
            return _bottomControlBar;
         },function(param1:UIComponent):void
         {
            _MainStage_AddChild1.relativeTo = param1;
         },"_MainStage_AddChild1.relativeTo");
         result[48] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_displaying");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Label3.text = param1;
         },"_MainStage_Label3.text");
         result[49] = binding;
         binding = new Binding(this,function():UIComponent
         {
            return _bottomControlBar;
         },function(param1:UIComponent):void
         {
            _MainStage_AddChild2.relativeTo = param1;
         },"_MainStage_AddChild2.relativeTo");
         result[50] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_scene") + " " + this.sceneIndexStr;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _MainStage_Label4.text = param1;
         },"_MainStage_Label4.text");
         result[51] = binding;
         binding = new Binding(this,function():UIComponent
         {
            return _bottomControlBar;
         },function(param1:UIComponent):void
         {
            _MainStage_AddChild3.relativeTo = param1;
         },"_MainStage_AddChild3.relativeTo");
         result[52] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_addscene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnAddScene.toolTip = param1;
         },"_btnAddScene.toolTip");
         result[53] = binding;
         binding = new Binding(this,function():UIComponent
         {
            return _bottomControlBar;
         },function(param1:UIComponent):void
         {
            _MainStage_AddChild4.relativeTo = param1;
         },"_MainStage_AddChild4.relativeTo");
         result[54] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","mainstage_delscene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnDelScene.toolTip = param1;
         },"_btnDelScene.toolTip");
         result[55] = binding;
         binding = new Binding(this,function():DisplayObject
         {
            return _topControlBar;
         },function(param1:DisplayObject):void
         {
            _MainStage_RemoveChild1.target = param1;
         },"_MainStage_RemoveChild1.target");
         result[56] = binding;
         binding = new Binding(this,function():DisplayObject
         {
            return _bottomControlBar;
         },function(param1:DisplayObject):void
         {
            _MainStage_RemoveChild2.target = param1;
         },"_MainStage_RemoveChild2.target");
         result[57] = binding;
         return result;
      }
      
      private function _MainStage_XMLList1_i() : XMLList
      {
         var _loc1_:XMLList = new XMLList("<node></node><node></node>");
         this._dpMovieMenu = _loc1_;
         BindingManager.executeBindings(this,"_dpMovieMenu",this._dpMovieMenu);
         return _loc1_;
      }
      
      public function set _txtAutoSave(param1:Label) : void
      {
         var _loc2_:Object = this._1570224285_txtAutoSave;
         if(_loc2_ !== param1)
         {
            this._1570224285_txtAutoSave = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_txtAutoSave",_loc2_,param1));
         }
      }
      
      private function _MainStage_SetProperty6_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty6 = _loc1_;
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         BindingManager.executeBindings(this,"_MainStage_SetProperty6",this._MainStage_SetProperty6);
         return _loc1_;
      }
      
      public function get selectionTool() : SelectionTool
      {
         return this._selectionTool;
      }
      
      private function _MainStage_AddChild1_i() : AddChild
      {
         var _loc1_:AddChild = new AddChild();
         this._MainStage_AddChild1 = _loc1_;
         _loc1_.targetFactory = new DeferredInstanceFromFunction(this._MainStage_Label3_i);
         BindingManager.executeBindings(this,"_MainStage_AddChild1",this._MainStage_AddChild1);
         return _loc1_;
      }
      
      public function set _stageViewStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._784383908_stageViewStack;
         if(_loc2_ !== param1)
         {
            this._784383908_stageViewStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_stageViewStack",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _maskCanvasScene() : Canvas
      {
         return this._607259319_maskCanvasScene;
      }
      
      private function _MainStage_Pause1_i() : Pause
      {
         var _loc1_:Pause = new Pause();
         this.pause = _loc1_;
         _loc1_.duration = 1000;
         BindingManager.executeBindings(this,"pause",this.pause);
         return _loc1_;
      }
      
      public function ___MainStage_Button7_mouseDown(param1:MouseEvent) : void
      {
         this.pan(0,100);
      }
      
      [Bindable(event="propertyChange")]
      public function get isContentOnLeft() : Boolean
      {
         return this._1720882005isContentOnLeft;
      }
      
      private function set _1575404715sceneIndexStr(param1:String) : void
      {
         this._sceneIndexStr = param1;
      }
      
      public function set _panControl(param1:Canvas) : void
      {
         var _loc2_:Object = this._1918949473_panControl;
         if(_loc2_ !== param1)
         {
            this._1918949473_panControl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_panControl",_loc2_,param1));
         }
      }
      
      public function get viewCenter() : Point
      {
         return new Point((this._documentLayer.scrollRect.x + this._documentLayer.scrollRect.width / 2) / this.zoomFactor,(this._documentLayer.scrollRect.y + this._documentLayer.scrollRect.height / 2) / this.zoomFactor);
      }
      
      private function zoomSliderDataTip(param1:Number) : String
      {
         return this.percentFormatter.format(100 * param1) + " %";
      }
      
      [Bindable(event="propertyChange")]
      public function get _efAutoSave() : Sequence
      {
         return this._246888748_efAutoSave;
      }
      
      [Bindable(event="propertyChange")]
      public function get _microMap() : MiniMap
      {
         return this._1575126697_microMap;
      }
      
      private function _MainStage_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeOut = _loc1_;
         _loc1_.alphaFrom = 1;
         _loc1_.alphaTo = 0;
         _loc1_.duration = 1500;
         BindingManager.executeBindings(this,"fadeOut",this.fadeOut);
         return _loc1_;
      }
      
      private function onZoomSliderChange(param1:SliderEvent) : void
      {
         this.zoom(HSlider(param1.currentTarget).value);
      }
      
      public function ___btnRedo_click(param1:MouseEvent) : void
      {
         Console.getConsole().redo();
      }
      
      [Bindable(event="propertyChange")]
      public function get panDropShadow() : DropShadowFilter
      {
         return this._355954324panDropShadow;
      }
      
      [Bindable(event="propertyChange")]
      public function get _uiCanvasAutoSave() : Canvas
      {
         return this._766521513_uiCanvasAutoSave;
      }
      
      public function set _topControlBar(param1:HBox) : void
      {
         var _loc2_:Object = this._74363220_topControlBar;
         if(_loc2_ !== param1)
         {
            this._74363220_topControlBar = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_topControlBar",_loc2_,param1));
         }
      }
      
      public function ___MainStage_Button3_click(param1:MouseEvent) : void
      {
         Console.getConsole().onTestButtonClick();
      }
      
      [Bindable(event="propertyChange")]
      public function get _stageArea() : Canvas
      {
         return this._347427628_stageArea;
      }
      
      private function onResize(param1:Event = null) : void
      {
         this.validateNow();
         var _loc2_:Number = this.width;
         var _loc3_:Number = this.height - this._bottomControlBar.height - this._topControlBar.height;
         this._stageArea.width = _loc2_;
         this._stageArea.height = _loc3_;
         this._documentLayer.scrollRect = new Rectangle((this._sceneLayer.width - _loc2_) / 2,(this._sceneLayer.height - _loc3_) / 2,_loc2_,_loc3_);
         this.updateBindable();
         this._microMap.viewRect = this._documentLayer.scrollRect;
         this._microMap.show();
         this.hideCameraView();
      }
      
      public function ___stageArea_mouseDown(param1:MouseEvent) : void
      {
         this.onStageAreaMouseDown(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get zoomFactor() : Number
      {
         return this._1035034878zoomFactor;
      }
      
      [Bindable(event="propertyChange")]
      public function set sceneIndexStr(param1:String) : void
      {
         var _loc2_:Object = this.sceneIndexStr;
         if(_loc2_ !== param1)
         {
            this._1575404715sceneIndexStr = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sceneIndexStr",_loc2_,param1));
         }
      }
      
      public function ___btnCopy_mouseUp(param1:MouseEvent) : void
      {
         Console.getConsole().copyAsset();
      }
      
      public function set _sceneArea(param1:Canvas) : void
      {
         var _loc2_:Object = this._239874490_sceneArea;
         if(_loc2_ !== param1)
         {
            this._239874490_sceneArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sceneArea",_loc2_,param1));
         }
      }
      
      public function set _btnCopy(param1:IconTextButton) : void
      {
         var _loc2_:Object = this._1731020110_btnCopy;
         if(_loc2_ !== param1)
         {
            this._1731020110_btnCopy = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnCopy",_loc2_,param1));
         }
      }
      
      private function _MainStage_SetProperty5_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty5 = _loc1_;
         _loc1_.name = "labelPlacement";
         _loc1_.value = "bottom";
         BindingManager.executeBindings(this,"_MainStage_SetProperty5",this._MainStage_SetProperty5);
         return _loc1_;
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
         }
      }
      
      public function get stageViewStack() : ViewStack
      {
         return this._stageViewStack;
      }
      
      private function showSceneMenu(param1:MouseEvent) : void
      {
         var _loc2_:Menu = Menu.createMenu(this,this._dpMovieMenu,false);
         _loc2_.labelField = "@label";
         _loc2_.buttonMode = true;
         _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.onMovieMenuItemClick);
         _loc2_.show(param1.stageX - 130,param1.stageY + 12);
      }
      
      public function set _dpMovieMenu(param1:XMLList) : void
      {
         var _loc2_:Object = this._1566867516_dpMovieMenu;
         if(_loc2_ !== param1)
         {
            this._1566867516_dpMovieMenu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_dpMovieMenu",_loc2_,param1));
         }
      }
      
      public function ___btnAddScene_click(param1:MouseEvent) : void
      {
         Console.getConsole().addNextScene();
      }
      
      public function set fadeOutMap(param1:Fade) : void
      {
         var _loc2_:Object = this._2089711414fadeOutMap;
         if(_loc2_ !== param1)
         {
            this._2089711414fadeOutMap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOutMap",_loc2_,param1));
         }
      }
      
      public function ___MainStage_Button12_click(param1:MouseEvent) : void
      {
         this._zoomSlider.value = 1;
         this.zoom(1);
      }
      
      override public function initialize() : void
      {
         var target:MainStage = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._MainStage_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_components_studio_MainStageWatcherSetupUtil");
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
      
      public function set _sceneLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._1144153660_sceneLayer;
         if(_loc2_ !== param1)
         {
            this._1144153660_sceneLayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sceneLayer",_loc2_,param1));
         }
      }
      
      public function ___MainStage_VBox2_mouseUp(param1:MouseEvent) : void
      {
         this.onStageAreaMouseUp(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _stageViewStack() : ViewStack
      {
         return this._784383908_stageViewStack;
      }
      
      private function zoomTo(param1:Number, param2:Number, param3:Number) : void
      {
         if(param1 <= 0)
         {
            param1 = 1;
         }
         this.zoomFactor = param1;
         this._sceneLayer.scaleX = this._sceneLayer.scaleY = param1;
         this._sceneLayer.validateNow();
         this.panTo(param2,param3);
      }
      
      private function _MainStage_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeIn = _loc1_;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 1500;
         BindingManager.executeBindings(this,"fadeIn",this.fadeIn);
         return _loc1_;
      }
      
      public function ___MainStage_Button8_click(param1:MouseEvent) : void
      {
         this.hideCameraView();
      }
      
      [Bindable(event="propertyChange")]
      public function get _sceneArea() : Canvas
      {
         return this._239874490_sceneArea;
      }
      
      public function ___miniMap_viewChanged(param1:MiniMapEvent) : void
      {
         this.onMiniMapViewChange(param1);
      }
      
      public function ___stageArea_mouseOver(param1:MouseEvent) : void
      {
         this.onStageAreaMouseOver(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _panControl() : Canvas
      {
         return this._1918949473_panControl;
      }
      
      [Bindable(event="propertyChange")]
      public function get _dpMovieMenu() : XMLList
      {
         return this._1566867516_dpMovieMenu;
      }
      
      public function set _maskCanvasSceneButton(param1:Canvas) : void
      {
         var _loc2_:Object = this._240112165_maskCanvasSceneButton;
         if(_loc2_ !== param1)
         {
            this._240112165_maskCanvasSceneButton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_maskCanvasSceneButton",_loc2_,param1));
         }
      }
      
      private function _MainStage_SetProperty4_i() : SetProperty
      {
         var _loc1_:SetProperty = new SetProperty();
         this._MainStage_SetProperty4 = _loc1_;
         _loc1_.name = "includeInLayout";
         _loc1_.value = false;
         BindingManager.executeBindings(this,"_MainStage_SetProperty4",this._MainStage_SetProperty4);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _cameraBorder() : UIComponent
      {
         return this._766696848_cameraBorder;
      }
      
      public function ___btnUndo_click(param1:MouseEvent) : void
      {
         Console.getConsole().undo();
      }
      
      [Bindable(event="propertyChange")]
      public function get _sceneLayer() : Canvas
      {
         return this._1144153660_sceneLayer;
      }
      
      public function set fadeInMap(param1:Fade) : void
      {
         var _loc2_:Object = this._904480549fadeInMap;
         if(_loc2_ !== param1)
         {
            this._904480549fadeInMap = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeInMap",_loc2_,param1));
         }
      }
      
      public function ___MainStage_Button5_mouseDown(param1:MouseEvent) : void
      {
         this.pan(100,0);
      }
      
      private function zoom(param1:Number) : void
      {
         this.zoomTo(param1,this.viewCenter.x,this.viewCenter.y);
      }
      
      private function showMiniMap(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this._microMap.viewRect = this._documentLayer.scrollRect;
            this._miniMap.viewRect = this._documentLayer.scrollRect;
            this._microMap.show();
            this._miniMap.show();
            this._miniMap.visible = this._miniMap.includeInLayout = true;
         }
      }
      
      public function set _controlLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._550419411_controlLayer;
         if(_loc2_ !== param1)
         {
            this._550419411_controlLayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_controlLayer",_loc2_,param1));
         }
      }
      
      private function onHistoryMenuItemClick(param1:MenuEvent) : void
      {
         trace(param1.index);
         var _loc2_:ICommand = ICommand(param1.item);
         trace(_loc2_.toString());
         var _loc3_:CommandStack = CommandStack.getInstance();
         var _loc4_:Number = 0;
         while(_loc4_ < param1.index + 1)
         {
            if(_loc3_.hasPreviousCommands())
            {
               _loc3_.previous().undo();
            }
            _loc4_++;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _controlLayer() : Canvas
      {
         return this._550419411_controlLayer;
      }
      
      private function hideMiniMap() : void
      {
         this._miniMap.visible = this._miniMap.includeInLayout = false;
      }
      
      public function ___btnDelScene_click(param1:MouseEvent) : void
      {
         Console.getConsole().deleteCurrentScene();
      }
      
      public function set _btnSceneMenu(param1:Button) : void
      {
         var _loc2_:Object = this._1034752274_btnSceneMenu;
         if(_loc2_ !== param1)
         {
            this._1034752274_btnSceneMenu = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnSceneMenu",_loc2_,param1));
         }
      }
      
      public function ___stageArea_mouseUp(param1:MouseEvent) : void
      {
         this.onStageAreaMouseUp(param1);
      }
      
      public function set _documentLayer(param1:Canvas) : void
      {
         var _loc2_:Object = this._784031479_documentLayer;
         if(_loc2_ !== param1)
         {
            this._784031479_documentLayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_documentLayer",_loc2_,param1));
         }
      }
      
      private function doShowImporterWindow() : void
      {
         if(Console.getConsole().thumbTray.assetTheme != ThumbTray.USER_THEME)
         {
            Console.getConsole().thumbTray.assetTheme = ThumbTray.USER_THEME;
         }
         var _loc1_:String = Console.getConsole().thumbTray.uploadType;
         Console.getConsole().showImporterWindow(this._targetUploadType_in_importer);
      }
      
      public function set isContentOnBottom(param1:Boolean) : void
      {
         var _loc2_:Object = this._71437831isContentOnBottom;
         if(_loc2_ !== param1)
         {
            this._71437831isContentOnBottom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isContentOnBottom",_loc2_,param1));
         }
      }
      
      public function ___sceneArea_rollOut(param1:MouseEvent) : void
      {
         this.onSceneAreaRollOut(param1);
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this.drawOffStage();
      }
      
      [Bindable(event="propertyChange")]
      public function get isContentOnBottom() : Boolean
      {
         return this._71437831isContentOnBottom;
      }
      
      private function onMiniMapViewChange(param1:MiniMapEvent) : void
      {
         this.panTo(param1.viewPoint.x,param1.viewPoint.y);
      }
      
      private function _MainStage_RemoveChild2_i() : RemoveChild
      {
         var _loc1_:RemoveChild = new RemoveChild();
         this._MainStage_RemoveChild2 = _loc1_;
         BindingManager.executeBindings(this,"_MainStage_RemoveChild2",this._MainStage_RemoveChild2);
         return _loc1_;
      }
      
      public function ___btnPaste_mouseUp(param1:MouseEvent) : void
      {
         Console.getConsole().pasteAsset();
      }
      
      private function panTo(param1:Number, param2:Number) : void
      {
         this.pan(param1 * this.zoomFactor - this._documentLayer.scrollRect.x - this._documentLayer.scrollRect.width / 2,param2 * this.zoomFactor - this._documentLayer.scrollRect.y - this._documentLayer.scrollRect.height / 2);
      }
   }
}
