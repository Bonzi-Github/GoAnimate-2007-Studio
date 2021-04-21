package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.event.ExtraDataEvent;
   import anifire.util.ExtraDataTimer;
   import anifire.util.UtilDict;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.controls.Label;
   import mx.controls.ToolTip;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.managers.CursorManager;
   import mx.managers.ToolTipManager;
   import mx.styles.CSSStyleDeclaration;
   
   use namespace mx_internal;
   
   public class SoundContainer extends Canvas implements ITimelineContainer, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var _wingLeft:UIComponent;
      
      private var _dragObjPoint:Point;
      
      private var left_arrow_orig_x:Number = 0;
      
      private var right_arrow_orig_x:Number = 0;
      
      private var _1729822083arrow_left:Canvas;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _orgObjPos:Point;
      
      private var _2079216026arrow_right:Canvas;
      
      private var _tempSoundInfo2:ElementInfo;
      
      private var _indicator:ToolTip;
      
      private var _controlClickStatus:Boolean = false;
      
      public var _wingHeight:Number;
      
      private var _stime:Number = 0;
      
      private var _items:Array;
      
      private var _currDraggedControl:UIComponent;
      
      private const MAX_WIDTH:Number = 90000;
      
      private var cursorID:int = -1;
      
      private var E_Symbol:Class;
      
      private var _inner_volume:Number = 1;
      
      public var _wingWidth:Number;
      
      private var _controlPrevW:Number = 0;
      
      private var _controlPrevX:Number = 0;
      
      private var _tempSoundInfo:ElementInfo;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _977672194ArrowIcon:Class;
      
      private var _itemsCollect:ArrayCollection;
      
      private var isArrowCursor:Boolean = false;
      
      private var timer:ExtraDataTimer;
      
      private var _controlCreateStatus:Boolean = false;
      
      private var _wingRight:UIComponent;
      
      private var _enableFocus:Boolean = true;
      
      private const MIN_WIDTH:Number = 30;
      
      private var _734000883soundItem_cs:Canvas;
      
      private var onArrow:Boolean = false;
      
      private var _soundReady:Boolean = false;
      
      private var _1812817726soundItem:SoundElement;
      
      mx_internal var _watchers:Array;
      
      private var _timelineControl:Timeline = null;
      
      private var _id:String;
      
      private const SOUNDCONTAINER_HEIGHT:int = 18;
      
      private var isResizing:Boolean = false;
      
      private var _currItem:ITimelineElement;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _2135423153title_lbl:Label;
      
      private var _focus:Boolean = false;
      
      private var _slength:Number = 100;
      
      mx_internal var _bindings:Array;
      
      private var _label:String;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function SoundContainer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {
                  "width":400,
                  "height":300,
                  "childDescriptors":[new UIComponentDescriptor({
                     "type":Label,
                     "id":"title_lbl",
                     "events":{"creationComplete":"__title_lbl_creationComplete"},
                     "stylesFactory":function():void
                     {
                        this.verticalCenter = "0";
                        this.left = "5";
                        this.fontWeight = "bold";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "visible":false,
                           "width":60,
                           "text":"Element"
                        };
                     }
                  }),new UIComponentDescriptor({
                     "type":Canvas,
                     "id":"soundItem_cs",
                     "stylesFactory":function():void
                     {
                        this.left = "0";
                     },
                     "propertiesFactory":function():Object
                     {
                        return {
                           "percentWidth":100,
                           "percentHeight":100,
                           "verticalScrollPolicy":"off",
                           "horizontalScrollPolicy":"off",
                           "clipContent":false,
                           "childDescriptors":[new UIComponentDescriptor({
                              "type":SoundElement,
                              "id":"soundItem",
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "width":49,
                                    "buttonMode":true
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"arrow_left",
                              "events":{
                                 "rollOver":"__arrow_left_rollOver",
                                 "rollOut":"__arrow_left_rollOut",
                                 "mouseDown":"__arrow_left_mouseDown"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "name":"CONTROL_L",
                                    "alpha":0,
                                    "width":10,
                                    "percentHeight":100
                                 };
                              }
                           }),new UIComponentDescriptor({
                              "type":Canvas,
                              "id":"arrow_right",
                              "events":{
                                 "rollOver":"__arrow_right_rollOver",
                                 "rollOut":"__arrow_right_rollOut",
                                 "mouseDown":"__arrow_right_mouseDown"
                              },
                              "propertiesFactory":function():Object
                              {
                                 return {
                                    "name":"CONTROL_R",
                                    "alpha":0,
                                    "width":10,
                                    "percentHeight":100
                                 };
                              }
                           })]
                        };
                     }
                  })]
               };
            }
         });
         this._orgObjPos = new Point();
         this._dragObjPoint = new Point();
         this._tempSoundInfo = new ElementInfo(ElementInfo.SCENE,"");
         this._tempSoundInfo2 = new ElementInfo(ElementInfo.SCENE,"");
         this.E_Symbol = SoundContainer_E_Symbol;
         this._977672194ArrowIcon = SoundContainer_ArrowIcon;
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
            this.backgroundColor = 16777215;
         };
         this.width = 400;
         this.height = 300;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.clipContent = false;
         this.addEventListener("creationComplete",this.___SoundContainer_Canvas1_creationComplete);
         this.addEventListener("mouseOver",this.___SoundContainer_Canvas1_mouseOver);
         this.addEventListener("mouseOut",this.___SoundContainer_Canvas1_mouseOut);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         SoundContainer._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      private function get ArrowIcon() : Class
      {
         return this._977672194ArrowIcon;
      }
      
      public function __title_lbl_creationComplete(param1:FlexEvent) : void
      {
         this.showTitle();
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
      
      private function setStartTime(param1:Number) : void
      {
         this.x = param1;
         this.soundItem.updateLabel(this.getLabel());
      }
      
      public function set soundItem_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._734000883soundItem_cs;
         if(_loc2_ !== param1)
         {
            this._734000883soundItem_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundItem_cs",_loc2_,param1));
         }
      }
      
      public function ___SoundContainer_Canvas1_mouseOut(param1:MouseEvent) : void
      {
         this.onMouseOutHandler(param1);
      }
      
      private function onSoundElementMoveHandler(param1:MouseEvent) : void
      {
         var _loc3_:ColorTransform = null;
         param1.updateAfterEvent();
         this.y = this.fixedChannelY(param1.stageY);
         var _loc2_:Number = this.nearToOtherSound(this.x,this.y);
         if(_loc2_ != -1)
         {
            this.x = _loc2_;
         }
         if(this._timelineControl.checkSoundOverlap())
         {
            _loc3_ = new ColorTransform(1,0,0,1,255,0,0,0);
            this.soundItem._bg.transform.colorTransform = _loc3_;
         }
         else
         {
            _loc3_ = new ColorTransform();
            this.soundItem._bg.transform.colorTransform = _loc3_;
         }
         this._stime = this.x;
         this.showIndicator();
         var _loc4_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOVE,_loc4_,this.id));
         this.soundItem.updateLabel(this.getLabel());
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
         this._dragObjPoint = new Point(this.x,this.y);
         this.invalidateProperties();
         this.invalidateDisplayList();
      }
      
      public function set slength(param1:Number) : void
      {
         this._slength = param1;
         this.setLength(this._slength);
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      public function stopIndicator() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
         }
      }
      
      override public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function clearIndicator() : void
      {
         if(this.timer != null)
         {
            this.timer.stop();
         }
         this.soundItem.clearIndicator();
      }
      
      private function onSoundElementDownHandler(param1:MouseEvent) : void
      {
         this._timelineControl.bringUp(this);
         this._timelineControl.allSoundsSetFocus(false);
         if(param1.target.name != "CONTROL_L" && param1.target.name != "CONTROL_R")
         {
            this.startDrag(false,new Rectangle(0,0,this.MAX_WIDTH,this._timelineControl.sound_cs.height));
            stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onSoundElementMoveHandler);
            stage.addEventListener(MouseEvent.MOUSE_UP,this.onSoundElementUpHandler);
            this.showIndicator();
            this.alpha = 0.75;
            this._originalX = this.stage.mouseX;
            this._originalY = this.stage.mouseY;
            this._orgObjPos = new Point(this.x,this.y);
            this.dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_DOWN));
         }
      }
      
      public function set inner_volume(param1:Number) : void
      {
         this._inner_volume = param1;
         this.soundItem.inner_volume = param1;
         this.soundItem.redraw();
         this.soundItem.updateLabel(this.getLabel());
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         if(this._currDraggedControl == this.arrow_right)
         {
            _loc2_ = Number(this._currDraggedControl.x - this.right_arrow_orig_x);
            this.slength = this.slength + _loc2_;
            this.right_arrow_orig_x = this.arrow_right.x;
            dispatchEvent(new TimelineEvent(TimelineEvent.CONTROL_RIGHT_MOVE));
         }
         else
         {
            _loc4_ = this.arrow_right.x;
            _loc2_ = -(this._currDraggedControl.x - this.left_arrow_orig_x);
            _loc3_ = this._currDraggedControl.x - this.left_arrow_orig_x;
            this.slength = this.slength + _loc2_;
            this.stime = this._stime + _loc3_;
            this.arrow_right.x = _loc4_;
            this.left_arrow_orig_x = this.arrow_left.x;
            dispatchEvent(new TimelineEvent(TimelineEvent.CONTROL_LEFT_MOVE));
         }
         this.soundItem.redraw();
         this.soundItem.updateLabel(this.getLabel());
         param1.updateAfterEvent();
         this.showIndicator();
      }
      
      private function changeArrowCurosr(param1:Boolean) : void
      {
         this.onArrow = param1;
         if(!this.isResizing)
         {
            if(param1)
            {
               this.cursorID = CursorManager.setCursor(this.ArrowIcon,3,-10.5,-6);
               this.isArrowCursor = true;
            }
            else
            {
               CursorManager.removeCursor(this.cursorID);
               this.isArrowCursor = false;
            }
         }
      }
      
      public function get tempSoundInfo2() : ElementInfo
      {
         return this._tempSoundInfo2;
      }
      
      [Bindable(event="propertyChange")]
      public function get arrow_right() : Canvas
      {
         return this._2079216026arrow_right;
      }
      
      public function __arrow_right_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      private function createIndicator(param1:Number, param2:Number) : ToolTip
      {
         var _loc3_:String = this.getLabel();
         var _loc4_:ToolTip;
         (_loc4_ = ToolTipManager.createToolTip(_loc3_,param1,param2) as ToolTip).setStyle("backgroundColor",16763904);
         return _loc4_;
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         this.isResizing = true;
         this._currDraggedControl = param1.currentTarget as UIComponent;
         if(this._currDraggedControl == this.arrow_right)
         {
            this.right_arrow_orig_x = this._currDraggedControl.x;
            _loc3_ = this._timelineControl.getNextSoundOnSameTrack(this.y,this.x);
            this._currDraggedControl.startDrag(true,new Rectangle(0,this._currDraggedControl.y,_loc3_ - 10,0));
         }
         else
         {
            this.left_arrow_orig_x = this._currDraggedControl.x;
            if((_loc4_ = this._timelineControl.getPrevSoundOnSameTrack(this.y,this.x)) == 99999)
            {
               _loc4_ = this.x;
            }
            else
            {
               _loc4_ = _loc4_ + 0;
            }
            this._currDraggedControl.startDrag(false,new Rectangle(-_loc4_,this._currDraggedControl.y,_loc4_ + width - 10,0));
         }
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.showIndicator();
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_START,_loc2_,this.id));
      }
      
      [Bindable(event="propertyChange")]
      public function get arrow_left() : Canvas
      {
         return this._1729822083arrow_left;
      }
      
      public function __arrow_right_rollOver(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(true);
      }
      
      public function __arrow_left_rollOver(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(true);
      }
      
      public function set title_lbl(param1:Label) : void
      {
         var _loc2_:Object = this._2135423153title_lbl;
         if(_loc2_ !== param1)
         {
            this._2135423153title_lbl = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"title_lbl",_loc2_,param1));
         }
      }
      
      public function addItemAt(param1:UIComponent, param2:int) : void
      {
      }
      
      private function _SoundContainer_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.SOUNDCONTAINER_HEIGHT;
         _loc1_ = this.width - 10;
      }
      
      private function timelineChangeHandler(param1:Event) : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         if(!this._focus && this._enableFocus)
         {
            styleName = "containerNormal";
         }
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         if(this.isArrowCursor)
         {
            this.isResizing = false;
            if(!this.onArrow)
            {
               CursorManager.removeCursor(this.cursorID);
            }
         }
         this.arrow_right.x = UtilUnitConvert.snapToPixelWithTime(this.arrow_right.x);
         this.arrow_left.x = UtilUnitConvert.snapToPixelWithTime(this.arrow_left.x);
         this._currDraggedControl.stopDrag();
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         if(this._currDraggedControl == this.arrow_right && this._slength != this.arrow_right.x + 10 - this.arrow_left.x)
         {
            this.slength = this.arrow_right.x + 10 - this.arrow_left.x;
         }
         if(this._currDraggedControl == this.arrow_left)
         {
            this.arrow_left.x = 0;
            this.arrow_right.x = this.width - 10;
         }
         this.soundItem.updateLabel(this.getLabel());
         this.soundItem.redraw();
         this.removeIndicator();
         this.dispatchEvent(new Event("TIMELINE_CHANGE_COMPLETE"));
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_COMPLETE,_loc2_,this.id));
      }
      
      public function set arrow_right(param1:Canvas) : void
      {
         var _loc2_:Object = this._2079216026arrow_right;
         if(_loc2_ !== param1)
         {
            this._2079216026arrow_right = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrow_right",_loc2_,param1));
         }
      }
      
      public function get time() : Number
      {
         return this._stime;
      }
      
      public function disableFocus() : void
      {
         this._enableFocus = false;
      }
      
      [Bindable(event="propertyChange")]
      public function get soundItem() : SoundElement
      {
         return this._1812817726soundItem;
      }
      
      public function set tempSoundInfo2(param1:ElementInfo) : void
      {
         this._tempSoundInfo2 = param1;
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      public function __arrow_right_rollOut(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(false);
      }
      
      public function get tempSoundInfo() : ElementInfo
      {
         return this._tempSoundInfo;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
         this.soundItem.setTimelineReferer(param1);
      }
      
      public function ___SoundContainer_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      override public function get label() : String
      {
         return this._label;
      }
      
      public function get length() : Number
      {
         return this._slength;
      }
      
      private function initApp() : void
      {
         this._items = new Array();
         this._itemsCollect = new ArrayCollection(this._items);
         this.soundItem.setSoundContainerReferer(this);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onSoundElementDownHandler);
         this.addEventListener(TimelineEvent.CONTROL_LEFT_MOVE,this.onControlLeftMoveHandler);
         this.addEventListener(TimelineEvent.CONTROL_RIGHT_MOVE,this.onControlRightMoveHandler);
         this.soundItem.updateLabel(this.getLabel());
         this.mouseEnabled = false;
      }
      
      public function set arrow_left(param1:Canvas) : void
      {
         var _loc2_:Object = this._1729822083arrow_left;
         if(_loc2_ !== param1)
         {
            this._1729822083arrow_left = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"arrow_left",_loc2_,param1));
         }
      }
      
      private function nearToOtherSound(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = this._timelineControl.getPrevSoundOnSameTrack(param2,param1);
         if(Math.abs(_loc3_) <= UtilUnitConvert.secToPixel(0.1) && (Math.abs(this._orgObjPos.x - param1) > 10 || Math.abs(this._orgObjPos.y - param2) > 10))
         {
            return param1 - _loc3_;
         }
         _loc3_ = this._timelineControl.getNextSoundOnSameTrack(param2,param1) - this.width;
         if(Math.abs(_loc3_) <= UtilUnitConvert.secToPixel(0.1) && (Math.abs(this._orgObjPos.x - param1) > 10 || Math.abs(this._orgObjPos.y - param2) > 10))
         {
            return param1 + _loc3_;
         }
         return -1;
      }
      
      public function getCurrIndex() : int
      {
         return 0;
      }
      
      [Bindable(event="propertyChange")]
      public function get soundItem_cs() : Canvas
      {
         return this._734000883soundItem_cs;
      }
      
      public function get count() : int
      {
         return this._itemsCollect.length;
      }
      
      public function enableFocus() : void
      {
         this._enableFocus = true;
      }
      
      public function get slength() : Number
      {
         return this._slength;
      }
      
      override public function get id() : String
      {
         return this._id;
      }
      
      public function get inner_volume() : Number
      {
         return this._inner_volume;
      }
      
      private function onSoundElementUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         this.soundItem._bg.transform.colorTransform = _loc2_;
         this._timelineControl.allSoundsSetFocus(true);
         this.x = UtilUnitConvert.snapToPixelWithTime(this.x);
         this.soundItem.stopDrag();
         this.alpha = 1;
         this.removeIndicator();
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onSoundElementMoveHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onSoundElementUpHandler);
         this.y = this.fixedChannelY(param1.stageY);
         if(this._timelineControl.checkSoundOverlap())
         {
            this.x = this._orgObjPos.x;
            this.y = this._orgObjPos.y;
         }
         this._stime = this.x;
         this.soundItem.updateLabel(this.getLabel());
         var _loc3_:int = this._timelineControl.getSoundIndexById(this.id);
         if(this.stage.mouseX == this._originalX && this.stage.mouseY == this._originalY)
         {
            trace("show menu:" + _loc3_ + "," + this.id);
            dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_CLICK,_loc3_,this.id));
         }
         this.dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_MOUSE_UP,_loc3_,this.id));
      }
      
      private function onControlRightMoveHandler(param1:TimelineEvent) : void
      {
         this.soundItem.updateLabel(this.getLabel());
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      public function getLabel() : String
      {
         this._slength = this.width;
         var _loc1_:Number = Math.round(UtilUnitConvert.pixelToSec(this._stime) * 10) / 10;
         var _loc2_:Number = Math.round(UtilUnitConvert.pixelToSec(this._slength) * 10) / 10;
         return this.label + " [" + UtilDict.toDisplay("go","timeline_starttime") + ": " + _loc1_ + ", " + UtilDict.toDisplay("go","timeline_duration") + ": " + _loc2_ + ", " + UtilDict.toDisplay("go","timeline_volume") + ": " + Math.round(this.inner_volume * 100) + "%]";
      }
      
      private function _SoundContainer_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Number
         {
            return SOUNDCONTAINER_HEIGHT;
         },function(param1:Number):void
         {
            soundItem.height = param1;
         },"soundItem.height");
         result[0] = binding;
         binding = new Binding(this,function():Number
         {
            return this.width - 10;
         },function(param1:Number):void
         {
            arrow_right.x = param1;
         },"arrow_right.x");
         result[1] = binding;
         return result;
      }
      
      public function removeAllItems() : void
      {
      }
      
      private function updateIndicator(param1:TimerEvent) : void
      {
         var _loc2_:Array = ExtraDataTimer(param1.currentTarget).getData() as Array;
         var _loc3_:Number = _loc2_[0];
         var _loc4_:Number = _loc2_[1];
         var _loc5_:Number = new Date().time - _loc4_;
         this.soundItem.updateIndicator(_loc3_,_loc5_ / 1000 * AnimeConstants.PIXEL_PER_SEC);
      }
      
      [Bindable(event="propertyChange")]
      public function get title_lbl() : Label
      {
         return this._2135423153title_lbl;
      }
      
      private function fixedChannelY(param1:Number) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc2_:Number = 4;
         var _loc3_:Number = param1 - (this._timelineControl.y + Timeline.SCENECONTAINER_VISUAL_HEIGHT);
         if(_loc3_ > 0)
         {
            _loc5_ = this._timelineControl.sound_cs.height - this.SOUNDCONTAINER_HEIGHT;
            _loc6_ = (_loc6_ = int(UtilUnitConvert.getTargetPoint(0,_loc5_,_loc3_,_loc2_))) == 0?int(_loc2_ - 1):int(_loc6_ - 1);
            _loc4_ = UtilUnitConvert.trackToPixel(_loc6_);
         }
         else
         {
            _loc4_ = 0;
         }
         return _loc4_;
      }
      
      public function addItem(param1:UIComponent) : void
      {
      }
      
      public function showTitle() : void
      {
         try
         {
            this.title_lbl.text = this._label;
         }
         catch(e:Error)
         {
         }
      }
      
      private function onControlLeftMoveHandler(param1:TimelineEvent) : void
      {
         this._stime = this.x;
         this.soundItem.updateLabel(this.getLabel());
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      public function hasMarker() : Boolean
      {
         return this.soundItem.hasMarker();
      }
      
      public function set stime(param1:Number) : void
      {
         this._stime = param1;
         this.setStartTime(this._stime);
      }
      
      public function set soundItem(param1:SoundElement) : void
      {
         var _loc2_:Object = this._1812817726soundItem;
         if(_loc2_ !== param1)
         {
            this._1812817726soundItem = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"soundItem",_loc2_,param1));
         }
      }
      
      public function moveStartTime(param1:Number) : void
      {
         this.stime = this._tempSoundInfo.startPixel + param1;
      }
      
      public function __arrow_left_mouseDown(param1:MouseEvent) : void
      {
         this.onMouseDownHandler(param1);
      }
      
      override public function initialize() : void
      {
         var target:SoundContainer = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._SoundContainer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SoundContainerWatcherSetupUtil");
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
      
      public function showIndicator() : void
      {
         var _loc1_:Point = this.getSoundGlobalPosition();
         if(this._indicator == null)
         {
            this._indicator = this.createIndicator(_loc1_.x,_loc1_.y);
         }
         this._indicator.x = _loc1_.x;
         this._indicator.y = _loc1_.y - this._indicator.height;
         this._indicator.text = this.getLabel();
      }
      
      public function getItemAt(param1:int) : ITimelineElement
      {
         return null;
      }
      
      public function changeProperty(param1:int, param2:String, param3:* = null) : void
      {
      }
      
      public function set soundReady(param1:Boolean) : void
      {
         this._soundReady = param1;
      }
      
      public function __arrow_left_rollOut(param1:MouseEvent) : void
      {
         this.changeArrowCurosr(false);
      }
      
      public function set focus(param1:Boolean) : void
      {
         this._focus = param1;
         if(this._focus && this._enableFocus)
         {
            styleName = "containerClicked";
            this.soundItem.focus = true;
         }
         else
         {
            styleName = "containerNormal";
            this.soundItem.focus = false;
         }
      }
      
      public function removeItem(param1:Number = -1) : Boolean
      {
         return false;
      }
      
      private function getSoundGlobalPosition() : Point
      {
         var _loc1_:Point = null;
         return this.localToGlobal(new Point(this.soundItem_cs.x,this.soundItem_cs.y));
      }
      
      public function startIndicator(param1:Number = 0) : void
      {
         var _loc2_:Array = new Array();
         _loc2_.push(param1 / 1000 * AnimeConstants.PIXEL_PER_SEC);
         _loc2_.push(new Date().time);
         var _loc3_:Number = 1000 / AnimeConstants.PIXEL_PER_SEC;
         this.timer = new ExtraDataTimer(_loc3_,this.slength - param1 / 1000 * AnimeConstants.PIXEL_PER_SEC,_loc2_);
         this.timer.addEventListener(TimerEvent.TIMER,this.updateIndicator);
         this.timer.start();
      }
      
      public function set tempSoundInfo(param1:ElementInfo) : void
      {
         this._tempSoundInfo = param1;
      }
      
      public function get soundReady() : Boolean
      {
         return this._soundReady;
      }
      
      public function getCurrItem() : ITimelineElement
      {
         return null;
      }
      
      public function getHorizontalView() : Number
      {
         return this.soundItem_cs.getStyle("left");
      }
      
      public function ___SoundContainer_Canvas1_mouseOver(param1:MouseEvent) : void
      {
         this.onMouseOverHandler(param1);
      }
      
      private function onSoundResizeStartHandler(param1:TimelineEvent) : void
      {
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_START,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      private function onSoundResizeCompleteHandler(param1:TimelineEvent) : void
      {
         var _loc2_:int = this._timelineControl.getSoundIndexById(this.id);
         dispatchEvent(new TimelineEvent(TimelineEvent.SOUND_RESIZE_COMPLETE,_loc2_,this.id));
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this));
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.showTitle();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this._focus && this._enableFocus)
         {
            styleName = "containerOver";
         }
      }
      
      public function removeIndicator() : void
      {
         if(this._indicator != null)
         {
            ToolTipManager.destroyToolTip(this._indicator);
            this._indicator = null;
         }
      }
      
      private function setLength(param1:Number) : void
      {
         this.width = param1;
         this.soundItem.length = param1;
         this.soundItem.redraw();
         this.soundItem.updateLabel(this.getLabel());
      }
      
      public function setHorizontalView(param1:Number = 0) : void
      {
         this.soundItem_cs.setStyle("left",-param1);
      }
   }
}
