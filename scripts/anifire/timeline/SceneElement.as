package anifire.timeline
{
   import anifire.component.MultilineButton;
   import anifire.components.containers.InputWindow;
   import anifire.constant.AnimeConstants;
   import anifire.core.AnimeScene;
   import anifire.core.AnimeSound;
   import anifire.core.Asset;
   import anifire.core.AssetLinkage;
   import anifire.core.Console;
   import anifire.core.SoundThumb;
   import anifire.event.ExtraDataEvent;
   import anifire.events.InputWindowEvent;
   import anifire.tutorial.TutorialEvent;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilLicense;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilUser;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Menu;
   import mx.controls.ToolTip;
   import mx.core.DragSource;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.DragEvent;
   import mx.events.FlexEvent;
   import mx.events.MenuEvent;
   import mx.events.PropertyChangeEvent;
   import mx.events.ResizeEvent;
   import mx.managers.CursorManager;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import mx.managers.ToolTipManager;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   use namespace mx_internal;
   
   public class SceneElement extends Canvas implements ITimelineElement, IBindingClient
   {
      
      private static const FILTER_SELECTED:GlowFilter = new GlowFilter(16750899,1,3,3,5,1,false,false);
      
      private static const MENU_LABEL_SCENE_LENGTH:String = "timeline_duration";
      
      private static const MENU_LABEL_PASTE_BEFORE:String = "timeline_insertbefore";
      
      private static const MENU_LABEL_PREVIEW_SCENE:String = "Preview from here";
      
      private static const MENU_LABEL_DELETE:String = "timeline_delete";
      
      private static const COLOR_SELECTED:String = "0x000000";
      
      private static const SELECTED:int = 0;
      
      mx_internal static var _SceneElement_StylesInit_done:Boolean = false;
      
      private static const MENU_LABEL_PASTE_AFTER:String = "timeline_insertafter";
      
      private static const MENU_LABEL_COPY:String = "timeline_copy";
      
      private static const MENU_LABEL_CLEAR:String = "timeline_clear";
      
      private static const FILTER_UNSELECTED:GlowFilter = new GlowFilter(0,1,3,3,5,1,false,false);
      
      private static const MENU_LABEL_SCENE_LENGTH_INPUT:String = "Custom";
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const UNSELECTED:int = 1;
      
      private static const COLOR_UNSELECTED:String = "0xAAB3B3";
      
      private static const MENU_LABEL_SCENE_LENGTH_3:String = "timeline_3sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_4:String = "timeline_4sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_1:String = "timeline_1sec";
      
      private static const MENU_LABEL_SCENE_LENGTH_2:String = "timeline_2sec";
      
      private static const MENU_LABEL_RESET_TTS:String = "Reset to length of speech";
       
      
      private var cursorID:int;
      
      private var _635756001_dropIndicator:Canvas;
      
      private var _bitmapData:BitmapData;
      
      private var _1436079757right_cs:Canvas;
      
      private var _1136560567_sceneThumb:Canvas;
      
      private var _589577822btnSpeech:Button;
      
      private var _94436_bg:Canvas;
      
      private var _977672194ArrowIcon:Class;
      
      private var _738350834_boxSpeech:Canvas;
      
      private var _prop:Object;
      
      public const LABEL_COLOR:Number = 0;
      
      private var _98309cce:Fade;
      
      private var _motionTime:Number = 0;
      
      private var _1729673616scene_img:Image;
      
      private var _1729676163scene_lbl:Label;
      
      private var _bitmap:Bitmap;
      
      private var _mouseDown:Boolean = false;
      
      private var _1280011162arrow_cs:Canvas;
      
      private var _scene:AnimeScene;
      
      private var _timelineControl:Timeline = null;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _indicator:ToolTip;
      
      mx_internal var _watchers:Array;
      
      private var _89648856_btnAddScene:MultilineButton;
      
      private var _id:String;
      
      private var isResizing:Boolean = false;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _focus:Boolean = false;
      
      private var _55443368left_cs:Canvas;
      
      mx_internal var _bindings:Array;
      
      private var E_Symbol:Class;
      
      private var _label:String = "Blank";
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SceneElement()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":300,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_bg",
                     "stylesFactory":function():void
                     {
                        this.backgroundSize = "100%";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "styleName":"sceneTimelineOver"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_sceneThumb",
                     "events":{
                        "mouseDown":"___sceneThumb_mouseDown",
                        "mouseUp":"___sceneThumb_mouseUp",
                        "mouseOver":"___sceneThumb_mouseOver",
                        "mouseOut":"___sceneThumb_mouseOut"
                     },
                     "stylesFactory":function():void
                     {
                        this.horizontalCenter = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "height":52,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"left_cs",
                              "events":{"resize":"__left_cs_resize"},
                              "stylesFactory":function():void
                              {
                                 this.left = "2";
                                 this.verticalCenter = "0";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":50,
                                    "percentHeight":100,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"right_cs",
                              "events":{"resize":"__right_cs_resize"},
                              "stylesFactory":function():void
                              {
                                 this.right = "2";
                                 this.verticalCenter = "0";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":50,
                                    "percentHeight":100,
                                    "visible":false
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "events":{
                                 "mouseMove":"___SceneElement_Canvas6_mouseMove",
                                 "click":"___SceneElement_Canvas6_click"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "percentWidth":100,
                                    "percentHeight":100,
                                    "verticalScrollPolicy":"off",
                                    "horizontalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor({
                                       "type":Image,
                                       "id":"scene_img",
                                       "events":{"creationComplete":"__scene_img_creationComplete"},
                                       "stylesFactory":function():void
                                       {
                                          this.horizontalCenter = "0";
                                          this.verticalCenter = "0";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "maintainAspectRatio":false,
                                             "width":76,
                                             "height":51
                                          };
                                       }
                                    }),new UIComponentDescriptor({
                                       "type":Label,
                                       "id":"scene_lbl",
                                       "events":{"creationComplete":"__scene_lbl_creationComplete"},
                                       "stylesFactory":function():void
                                       {
                                          this.horizontalCenter = "0";
                                          this.bottom = "4";
                                          this.textAlign = "center";
                                          this.fontWeight = "bold";
                                          this.fontSize = 40;
                                          this.verticalCenter = "0";
                                       },
                                       "propertiesFactory":function():Object
                                       {
                                          return {
                                             "percentWidth":100,
                                             "selectable":false,
                                             "buttonMode":true,
                                             "useHandCursor":true,
                                             "mouseChildren":false
                                          };
                                       }
                                    })]
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"arrow_cs",
                              "events":{
                                 "rollOver":"__arrow_cs_rollOver",
                                 "rollOut":"__arrow_cs_rollOut",
                                 "mouseDown":"__arrow_cs_mouseDown"
                              },
                              "stylesFactory":function():void
                              {
                                 this.backgroundColor = 0;
                                 this.right = "0";
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "alpha":0,
                                    "width":10,
                                    "percentHeight":100
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_boxSpeech",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "y":52,
                           "height":18,
                           "horizontalScrollPolicy":"off",
                           "visible":false,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":Button,
                              "id":"btnSpeech",
                              "events":{"click":"__btnSpeech_click"},
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "height":18,
                                    "styleName":"btnSpeech",
                                    "buttonMode":true
                                 };
                              }
                           })]
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":MultilineButton,
                     "id":"_btnAddScene",
                     "events":{"click":"___btnAddScene_click"},
                     "propertiesFactory":function():Object
                     {
                        return {
                           "width":60,
                           "visible":false,
                           "styleName":"btnAddSceneOnTimeline"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"_dropIndicator",
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "mouseChildren":false
                        };
                     }
                  })]
               };
            }
         });
         this._977672194ArrowIcon = SceneElement_ArrowIcon;
         this.E_Symbol = SceneElement_E_Symbol;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         mx_internal::_SceneElement_StylesInit();
         this.width = 300;
         this.percentHeight = 100;
         this.clipContent = false;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this._SceneElement_Fade1_i();
         this.addEventListener("creationComplete",this.___SceneElement_Canvas1_creationComplete);
         this.addEventListener("dragEnter",this.___SceneElement_Canvas1_dragEnter);
         this.addEventListener("dragDrop",this.___SceneElement_Canvas1_dragDrop);
         this.addEventListener("dragOver",this.___SceneElement_Canvas1_dragOver);
         this.addEventListener("dragExit",this.___SceneElement_Canvas1_dragExit);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         SceneElement._watcherSetupUtil = param1;
      }
      
      private function onTextOut() : void
      {
      }
      
      private function set ArrowIcon(param1:Class) : void
      {
         var _loc2_:Object = this._977672194ArrowIcon;
         if(_loc2_ !== param1)
         {
            this._977672194ArrowIcon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"ArrowIcon",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cce() : Fade
      {
         return this._98309cce;
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:DragSource = null;
         var _loc3_:Image = null;
         if(!this.isResizing && this._focus && this._mouseDown)
         {
            _loc2_ = new DragSource();
            _loc2_.addData(this,"SceneElement");
            _loc3_ = new Image();
            _loc3_.source = new Bitmap(this.source);
            _loc3_.height = this.scene_img.height;
            _loc3_.width = this.scene_img.width;
            DragManager.doDrag(this,_loc2_,param1,_loc3_,-param1.localX,-param1.localY);
         }
         this.removeIndicator();
      }
      
      private function dragOverHandler(param1:DragEvent) : void
      {
         if(param1.dragSource.hasFormat("SceneElement") && param1.dragSource.dataForFormat("SceneElement") != this)
         {
            if(!this._dropIndicator.visible)
            {
               this._dropIndicator.visible = true;
            }
            if(this.mouseX > this.width / 2)
            {
               this._dropIndicator.styleName = "insertAfter";
            }
            else
            {
               this._dropIndicator.styleName = "insertBefore";
            }
         }
      }
      
      public function set cce(param1:Fade) : void
      {
         var _loc2_:Object = this._98309cce;
         if(_loc2_ !== param1)
         {
            this._98309cce = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cce",_loc2_,param1));
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.showMenu(this.stage.mouseX,this.stage.mouseY - 79);
      }
      
      public function set scene_lbl(param1:Label) : void
      {
         var _loc2_:Object = this._1729676163scene_lbl;
         if(_loc2_ !== param1)
         {
            this._1729676163scene_lbl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_lbl",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _boxSpeech() : Canvas
      {
         return this._738350834_boxSpeech;
      }
      
      private function _SceneElement_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.cce;
         _loc1_ = data.label;
         _loc1_ = this._sceneThumb.width;
         _loc1_ = this._sceneThumb.width;
         _loc1_ = UtilDict.toDisplay("go","Add Scene");
         _loc1_ = this._bg.width;
      }
      
      [Bindable(event="propertyChange")]
      private function get ArrowIcon() : Class
      {
         return this._977672194ArrowIcon;
      }
      
      public function updateImage(param1:BitmapData) : void
      {
         this.scene_img.source = new Bitmap(param1);
      }
      
      private function onAddSceneBtnClick() : void
      {
         Console.getConsole().addNextScene();
      }
      
      override public function get id() : String
      {
         return this._id;
      }
      
      public function set _boxSpeech(param1:Canvas) : void
      {
         var _loc2_:Object = this._738350834_boxSpeech;
         if(_loc2_ !== param1)
         {
            this._738350834_boxSpeech = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_boxSpeech",_loc2_,param1));
         }
      }
      
      private function doMenuClick(param1:MenuEvent) : void
      {
         var _loc5_:InputWindow = null;
         var _loc2_:XML = XML(param1.item);
         var _loc3_:Number = this.width;
         var _loc4_:Number = _loc3_;
         switch(_loc2_.attribute("value").toString())
         {
            case MENU_LABEL_SCENE_LENGTH_1:
               _loc4_ = 1 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_2:
               _loc4_ = 2 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_3:
               _loc4_ = 3 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_4:
               _loc4_ = 4 * AnimeConstants.PIXEL_PER_SEC;
               break;
            case MENU_LABEL_SCENE_LENGTH_INPUT:
               (_loc5_ = InputWindow(PopUpManager.createPopUp(this.getSceneCanvas(),InputWindow,true))).addEventListener(InputWindowEvent.INPUT_SUBMIT,this.onWindowInput);
               _loc5_.width = 490;
               _loc5_.height = 130;
               _loc5_.init(UtilDict.toDisplay("go","Scene Duration (sec):"),"popupWindow","slider",UtilUnitConvert.pixelToSec(this.width),AnimeConstants.SCENE_DURATION_MINIMUM,20,0.1);
               break;
            case MENU_LABEL_COPY:
               Console.getConsole().copyCurrentScene();
               break;
            case MENU_LABEL_DELETE:
               Console.getConsole().deleteCurrentScene();
               break;
            case MENU_LABEL_CLEAR:
               Console.getConsole().clearCurrentScene();
               break;
            case MENU_LABEL_PASTE_BEFORE:
               Console.getConsole().pasteScene(0);
               break;
            case MENU_LABEL_PASTE_AFTER:
               Console.getConsole().pasteScene();
               break;
            case MENU_LABEL_PREVIEW_SCENE:
               Console.getConsole().preview(null,true);
               break;
            case MENU_LABEL_RESET_TTS:
               _loc4_ = this.resetTTSLength();
         }
         if(_loc3_ != _loc4_)
         {
            _loc4_ = Math.floor(_loc4_);
            this._timelineControl.sceneLengthController.doChangeSceneLength(_loc4_,int(this.id),true);
            this._timelineControl.doPatchSceneResizeComplete(int(this.id));
         }
      }
      
      public function get actionTime() : Number
      {
         return this.totalTime - this.motionTime;
      }
      
      private function drawArrow(param1:String) : void
      {
         var _loc2_:Canvas = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = height / 2;
         if(param1 == "left")
         {
            _loc2_ = this.left_cs;
            _loc3_ = 5;
            _loc4_ = 180;
         }
         else
         {
            _loc2_ = this.right_cs;
            _loc3_ = this.right_cs.width - 5;
            _loc4_ = 0;
         }
         _loc2_.graphics.clear();
         if(width > this.scene_img.width + 6)
         {
            _loc2_.graphics.beginFill(6710886);
            _loc2_.graphics.lineStyle(0,6710886);
            UtilDraw.drawPoly(_loc2_,_loc3_,_loc5_,3,5,_loc4_);
            _loc2_.graphics.moveTo(0,_loc5_);
            _loc2_.graphics.lineTo(_loc2_.width,_loc5_);
            _loc2_.graphics.endFill();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _btnAddScene() : MultilineButton
      {
         return this._89648856_btnAddScene;
      }
      
      [Bindable(event="dataChange")]
      public function get source() : BitmapData
      {
         return this._bitmapData;
      }
      
      public function get totalTime() : Number
      {
         return width;
      }
      
      public function __arrow_cs_mouseDown(param1:MouseEvent) : void
      {
         this.enableDragScene(param1);
      }
      
      public function __left_cs_resize(param1:ResizeEvent) : void
      {
         this.drawArrow("left");
      }
      
      private function resetTTSLength() : Number
      {
         var _loc1_:SoundThumb = null;
         var _loc2_:AnimeSound = null;
         var _loc3_:AnimeScene = Console.getConsole().currentScene;
         var _loc4_:String = Console.getConsole().linkageController.getSpeechIdByScene(_loc3_);
         _loc2_ = Console.getConsole().speechManager.getValueByKey(_loc4_) as AnimeSound;
         _loc1_ = _loc2_.soundThumb;
         return _loc1_.duration / 1000 * AnimeConstants.PIXEL_PER_SEC;
      }
      
      override public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      private function _SceneElement_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return cce;
         },function(param1:*):void
         {
            this.setStyle("creationCompleteEffect",param1);
         },"this.creationCompleteEffect");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = data.label;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            scene_lbl.text = param1;
         },"scene_lbl.text");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return _sceneThumb.width;
         },function(param1:Number):void
         {
            _boxSpeech.width = param1;
         },"_boxSpeech.width");
         result[2] = binding;
         binding = new Binding(this,function():Number
         {
            return _sceneThumb.width;
         },function(param1:Number):void
         {
            btnSpeech.width = param1;
         },"btnSpeech.width");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = UtilDict.toDisplay("go","Add Scene");
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            _btnAddScene.label = param1;
         },"_btnAddScene.label");
         result[4] = binding;
         binding = new Binding(this,function():Number
         {
            return _bg.width;
         },function(param1:Number):void
         {
            _btnAddScene.x = param1;
         },"_btnAddScene.x");
         result[5] = binding;
         return result;
      }
      
      public function set motionTime(param1:Number) : void
      {
         this._motionTime = param1;
      }
      
      public function ___sceneThumb_mouseUp(param1:MouseEvent) : void
      {
         this.onMouseUpHandler(param1);
      }
      
      private function getLabel(param1:Number = -1, param2:Number = -1) : String
      {
         param1 = param1 < 0?Number(x):Number(param1);
         param2 = param2 < 0?Number(width):Number(param2);
         var _loc3_:Number = Math.round(UtilUnitConvert.pixelToSec(param1) * 100) / 100;
         var _loc4_:Number = Math.round(UtilUnitConvert.pixelToSec(param2) * 100) / 100;
         return "[" + UtilDict.toDisplay("go","timeline_starttime") + ": " + _loc3_ + ", " + UtilDict.toDisplay("go","timeline_duration") + ": " + _loc4_ + "]";
      }
      
      public function get startTime() : Number
      {
         return x;
      }
      
      public function set _btnAddScene(param1:MultilineButton) : void
      {
         var _loc2_:Object = this._89648856_btnAddScene;
         if(_loc2_ !== param1)
         {
            this._89648856_btnAddScene = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_btnAddScene",_loc2_,param1));
         }
      }
      
      public function set scene(param1:AnimeScene) : void
      {
         this._scene = param1;
      }
      
      public function __scene_lbl_creationComplete(param1:FlexEvent) : void
      {
         this.showLabel();
      }
      
      private function setState(param1:int) : void
      {
         if(param1 == SELECTED)
         {
            this.scene_lbl.setStyle("color",COLOR_SELECTED);
            this.scene_lbl.filters = [FILTER_SELECTED];
            this.scene_lbl.setStyle("fontSize",54);
            this.btnSpeech.styleName = "btnSpeechOnHightlight";
         }
         else if(param1 == UNSELECTED)
         {
            this.scene_lbl.setStyle("color",COLOR_UNSELECTED);
            this.scene_lbl.filters = [FILTER_UNSELECTED];
            this.scene_lbl.setStyle("fontSize",32);
            this.btnSpeech.styleName = "btnSpeech";
         }
      }
      
      public function set left_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._55443368left_cs;
         if(_loc2_ !== param1)
         {
            this._55443368left_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"left_cs",_loc2_,param1));
         }
      }
      
      public function ___SceneElement_Canvas1_dragDrop(param1:DragEvent) : void
      {
         this.dragDropHandler(param1);
      }
      
      public function get speechText() : String
      {
         return this.btnSpeech.label;
      }
      
      public function ___SceneElement_Canvas1_dragOver(param1:DragEvent) : void
      {
         this.dragOverHandler(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _sceneThumb() : Canvas
      {
         return this._1136560567_sceneThumb;
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this._mouseDown = true;
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.showIndicator();
      }
      
      [Bindable(event="dataChange")]
      public function get prop() : Object
      {
         return this._prop;
      }
      
      private function showImage() : void
      {
         try
         {
            this._bitmap = new Bitmap(this._bitmapData);
            this.scene_img.source = this._bitmap;
         }
         catch(e:Error)
         {
         }
      }
      
      private function changeArrowCurosr(param1:Boolean) : void
      {
         if(!this.isResizing)
         {
            if(param1)
            {
               this.cursorID = CursorManager.setCursor(this.ArrowIcon,3,-10.5,-6);
            }
            else
            {
               CursorManager.removeCursor(this.cursorID);
            }
         }
      }
      
      private function getSceneGlobalPosition() : Point
      {
         var _loc1_:Point = null;
         var _loc2_:Point = null;
         _loc1_ = parent.localToGlobal(new Point(x,y));
         if(this._timelineControl != null)
         {
            _loc2_ = this._timelineControl.scene_vb.localToGlobal(new Point(0,0));
            if(_loc1_.x <= _loc2_.x)
            {
               _loc1_.x = _loc2_.x;
            }
         }
         return _loc1_;
      }
      
      private function onWindowInput(param1:InputWindowEvent) : void
      {
         var _loc2_:Number = this.width;
         var _loc3_:Number = _loc2_;
         _loc3_ = Number(param1.inputValue) * AnimeConstants.PIXEL_PER_SEC;
         if(_loc2_ != _loc3_)
         {
            _loc3_ = Math.floor(_loc3_);
            this._timelineControl.sceneLengthController.doChangeSceneLength(_loc3_,int(this.id),true);
            this._timelineControl.doPatchSceneResizeComplete(int(this.id));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get arrow_cs() : Canvas
      {
         return this._1280011162arrow_cs;
      }
      
      private function onTextUp() : void
      {
         var _loc1_:String = Console.getConsole().linkageController.getSpeechIdByScene(Console.getConsole().currentScene);
         var _loc2_:String = Console.getConsole().linkageController.getCharIdOfSpeech(_loc1_);
         var _loc3_:Asset = Console.getConsole().currentScene.getCharacterById(_loc2_.split(AssetLinkage.LINK)[1]);
         Console.getConsole().currentScene.selectedAsset = _loc3_;
         Console.getConsole().currentScene.assetGroup.showControl();
         Console.getConsole().propertiesWindow.showSpeechPanel();
      }
      
      public function set showAddSceneBtn(param1:Boolean) : void
      {
         this._btnAddScene.visible = param1;
      }
      
      public function ___SceneElement_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      private function _SceneElement_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.cce = _loc1_;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 300;
         return _loc1_;
      }
      
      private function createIndicator(param1:Number, param2:Number) : ToolTip
      {
         var _loc3_:String = this.getLabel();
         var _loc4_:ToolTip;
         (_loc4_ = ToolTipManager.createToolTip(_loc3_,param1,param2) as ToolTip).setStyle("backgroundColor",16763904);
         return _loc4_;
      }
      
      private function enableDragScene(param1:MouseEvent) : void
      {
         this.isResizing = true;
         this.dispatchEvent(new ExtraDataEvent("ArrowClick",this,param1));
      }
      
      public function ___SceneElement_Canvas6_click(param1:MouseEvent) : void
      {
         this.onClick(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get right_cs() : Canvas
      {
         return this._1436079757right_cs;
      }
      
      public function set source(param1:BitmapData) : void
      {
         this._bitmapData = param1;
         this.showImage();
         dispatchEvent(new Event("dataChange"));
      }
      
      private function dragExitHandler(param1:DragEvent) : void
      {
         this._dropIndicator.visible = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get btnSpeech() : Button
      {
         return this._589577822btnSpeech;
      }
      
      public function __right_cs_resize(param1:ResizeEvent) : void
      {
         this.drawArrow("right");
      }
      
      public function ___SceneElement_Canvas6_mouseMove(param1:MouseEvent) : void
      {
         this.onMouseMove(param1);
      }
      
      public function ___sceneThumb_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseOutHandler(param1);
      }
      
      private function dragDropHandler(param1:DragEvent) : void
      {
         this._dropIndicator.visible = false;
         var _loc2_:SceneElement = SceneElement(param1.dragSource.dataForFormat("SceneElement"));
         var _loc3_:Number = Number(_loc2_.label) - 1;
         var _loc4_:Number = Number(this.label) - 1;
         if(this.mouseX > this.width / 2)
         {
            _loc4_++;
         }
         if(_loc3_ != _loc4_ && _loc4_ - _loc3_ != 1)
         {
            Console.getConsole().moveScene(_loc3_,_loc4_);
         }
      }
      
      public function ___SceneElement_Canvas1_dragExit(param1:DragEvent) : void
      {
         this.dragExitHandler(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get scene_lbl() : Label
      {
         return this._1729676163scene_lbl;
      }
      
      override public function initialize() : void
      {
         var target:SceneElement = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._SceneElement_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SceneElementWatcherSetupUtil");
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
      
      public function ___sceneThumb_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      public function showIndicator(param1:Number = -1, param2:Number = -1) : void
      {
         var _loc3_:Point = this.getSceneGlobalPosition();
         if(this._indicator == null)
         {
            this._indicator = this.createIndicator(_loc3_.x,_loc3_.y);
         }
         this._indicator.x = _loc3_.x;
         this._indicator.y = _loc3_.y - this._indicator.height;
         this._indicator.text = this.getLabel(param1,param2);
      }
      
      public function set scene_img(param1:Image) : void
      {
         var _loc2_:Object = this._1729673616scene_img;
         if(_loc2_ !== param1)
         {
            this._1729673616scene_img = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scene_img",_loc2_,param1));
         }
      }
      
      public function __btnSpeech_click(param1:MouseEvent) : void
      {
         this.onTextUp();
      }
      
      public function __arrow_cs_rollOut(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(false);
      }
      
      public function set _sceneThumb(param1:Canvas) : void
      {
         var _loc2_:Object = this._1136560567_sceneThumb;
         if(_loc2_ !== param1)
         {
            this._1136560567_sceneThumb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_sceneThumb",_loc2_,param1));
         }
      }
      
      private function onTextOver() : void
      {
      }
      
      mx_internal function _SceneElement_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_SceneElement_StylesInit_done)
         {
            return;
         }
         mx_internal::_SceneElement_StylesInit_done = true;
         style = StyleManager.getStyleDeclaration(".insertBefore");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".insertBefore",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderSides = "left";
               this.borderStyle = "solid";
               this.borderColor = 8602632;
               this.borderThickness = 4;
            };
         }
         style = StyleManager.getStyleDeclaration(".insertAfter");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration(".insertAfter",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.borderSides = "right";
               this.borderStyle = "solid";
               this.borderColor = 8602632;
               this.borderThickness = 4;
            };
         }
      }
      
      public function get motionTime() : Number
      {
         return this._motionTime;
      }
      
      private function dragEnterHandler(param1:DragEvent) : void
      {
         if(param1.dragSource.hasFormat("SceneElement") && param1.dragSource.dataForFormat("SceneElement") != this)
         {
            DragManager.acceptDragDrop(SceneElement(param1.currentTarget));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get left_cs() : Canvas
      {
         return this._55443368left_cs;
      }
      
      public function ___btnAddScene_click(param1:MouseEvent) : void
      {
         this.onAddSceneBtnClick();
      }
      
      public function ___SceneElement_Canvas1_dragEnter(param1:DragEvent) : void
      {
         this.dragEnterHandler(param1);
      }
      
      public function set focus(param1:Boolean) : void
      {
         if(this._focus != param1)
         {
            this._focus = param1;
            if(this._focus)
            {
               styleName = "elementClicked";
               this.setState(SELECTED);
            }
            else
            {
               styleName = "";
               this.setState(UNSELECTED);
            }
            this._bg.visible = param1;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get scene_img() : Image
      {
         return this._1729673616scene_img;
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(this._focus)
         {
         }
      }
      
      public function ___sceneThumb_mouseOver(param1:MouseEvent) : void
      {
         this.onMouseOverHandler(param1);
      }
      
      public function set _bg(param1:Canvas) : void
      {
         var _loc2_:Object = this._94436_bg;
         if(_loc2_ !== param1)
         {
            this._94436_bg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_bg",_loc2_,param1));
         }
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         this._mouseDown = false;
         if(this.isResizing)
         {
            this.isResizing = false;
            CursorManager.removeCursor(this.cursorID);
         }
         if(stage != null)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
            this.removeIndicator();
         }
      }
      
      public function __arrow_cs_rollOver(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(true);
      }
      
      public function set btnSpeech(param1:Button) : void
      {
         var _loc2_:Object = this._589577822btnSpeech;
         if(_loc2_ !== param1)
         {
            this._589577822btnSpeech = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"btnSpeech",_loc2_,param1));
         }
      }
      
      public function set prop(param1:Object) : void
      {
         this._prop = param1;
         dispatchEvent(new Event("dataChange"));
      }
      
      public function set _dropIndicator(param1:Canvas) : void
      {
         var _loc2_:Object = this._635756001_dropIndicator;
         if(_loc2_ !== param1)
         {
            this._635756001_dropIndicator = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_dropIndicator",_loc2_,param1));
         }
      }
      
      public function set arrow_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1280011162arrow_cs;
         if(_loc2_ !== param1)
         {
            this._1280011162arrow_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrow_cs",_loc2_,param1));
         }
      }
      
      public function updateSpeechComment(param1:String) : void
      {
         this._boxSpeech.visible = param1 != "";
         this.btnSpeech.label = param1;
      }
      
      protected function getSceneCanvas() : Canvas
      {
         if(Console.getConsole().timeline == null)
         {
            return null;
         }
         return Canvas(Console.getConsole().timeline);
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      [Bindable(event="propertyChange")]
      public function get _dropIndicator() : Canvas
      {
         return this._635756001_dropIndicator;
      }
      
      public function set right_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._1436079757right_cs;
         if(_loc2_ !== param1)
         {
            this._1436079757right_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"right_cs",_loc2_,param1));
         }
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.showLabel();
         dispatchEvent(new Event("dataChange"));
      }
      
      private function currentScenehasSpeech() : Boolean
      {
         var _loc1_:AnimeScene = Console.getConsole().currentScene;
         if(Console.getConsole().linkageController.getSpeechIdByScene(_loc1_) != "")
         {
            return true;
         }
         return false;
      }
      
      public function removeIndicator() : void
      {
         if(this._indicator)
         {
            ToolTipManager.destroyToolTip(this._indicator);
            this._indicator = null;
         }
      }
      
      public function __scene_img_creationComplete(param1:FlexEvent) : void
      {
         this.showImage();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._focus)
         {
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _bg() : Canvas
      {
         return this._94436_bg;
      }
      
      [Bindable(event="dataChange")]
      override public function get label() : String
      {
         return this._label;
      }
      
      private function initApp() : void
      {
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      private function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:Menu = null;
         if(Console.getConsole().isTutorialOn)
         {
            if(this.label == "1")
            {
               Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.SCENE_SELECTED,this));
            }
            return;
         }
         var _loc3_:* = "";
         var _loc6_:String = !!Console.getConsole().movie.copiedScene?"true":"false";
         var _loc7_:String = UtilLicense.getCurrentLicenseId();
         _loc3_ = "<root>";
         _loc3_ = _loc3_ + ("<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_COPY) + "\" value=\"" + MENU_LABEL_COPY + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PASTE_BEFORE) + "\" value=\"" + MENU_LABEL_PASTE_BEFORE + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PASTE_AFTER) + "\" value=\"" + MENU_LABEL_PASTE_AFTER + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_DELETE) + "\" value=\"" + MENU_LABEL_DELETE + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_CLEAR) + "\" value=\"" + MENU_LABEL_CLEAR + "\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH + "\" >" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_1) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_1 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_2) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_2 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_3) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_3 + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_4) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_4 + "\" />");
         if(this.currentScenehasSpeech())
         {
            _loc3_ = _loc3_ + ("<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_RESET_TTS) + "\" value=\"" + MENU_LABEL_RESET_TTS + "\" />");
         }
         if(UtilUser.hasPlusFeatures())
         {
            _loc3_ = _loc3_ + ("<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SCENE_LENGTH_INPUT) + "\" value=\"" + MENU_LABEL_SCENE_LENGTH_INPUT + "\" />");
         }
         _loc3_ = _loc3_ + "</menuItem>";
         if(!(_loc7_ == "7" || _loc7_ == "8"))
         {
            _loc3_ = _loc3_ + ("<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_PREVIEW_SCENE) + "\" value=\"" + MENU_LABEL_PREVIEW_SCENE + "\" />");
         }
         _loc3_ = _loc3_ + "</root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = Menu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         _loc8_ = 120;
         _loc9_ = 170;
         var _loc10_:Canvas;
         var _loc11_:Point = (_loc10_ = this.getSceneCanvas()).localToGlobal(new Point(0,0));
         var _loc12_:Number = param1;
         var _loc13_:Number = param2 - 90;
         if(_loc12_ + _loc8_ > _loc11_.x + _loc10_.width - 100)
         {
            _loc12_ = _loc11_.x + _loc10_.width - _loc8_ - 100;
         }
         if(_loc13_ + _loc9_ > _loc11_.y + _loc10_.height)
         {
            _loc13_ = _loc11_.y + _loc10_.height - _loc9_;
         }
         _loc5_.show(_loc12_,Console.getConsole().timeline.y - _loc9_);
         this._timelineControl.doPatchSceneResizeStart(int(this.id));
      }
      
      private function showLabel() : void
      {
         try
         {
            this.scene_lbl.text = this._label;
         }
         catch(e:Error)
         {
         }
      }
   }
}
