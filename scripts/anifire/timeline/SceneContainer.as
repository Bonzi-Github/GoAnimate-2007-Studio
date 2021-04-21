package anifire.timeline
{
   import anifire.constant.AnimeConstants;
   import anifire.core.Console;
   import anifire.event.ExtraDataEvent;
   import anifire.util.Util;
   import anifire.util.UtilUnitConvert;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Label;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.effects.Fade;
   import mx.events.ChildExistenceChangedEvent;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class SceneContainer extends Canvas implements ITimelineContainer, IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      private var E_Symbol:Class;
      
      mx_internal var _bindings:Array;
      
      private var _controlPrevW:Number = 0;
      
      private var _controlPrevX:Number = 0;
      
      private var _originalX:Number;
      
      private var _itemsCollect:ArrayCollection;
      
      private var _originalY:Number;
      
      private var _67793216canvasSceneLabel:Canvas;
      
      private var _98309cce:Fade;
      
      private var _controlCreateStatus:Boolean = false;
      
      private var _enableFocus:Boolean = true;
      
      private var _351951448itemList_hb:HBox;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _controlClickStatus:Boolean = false;
      
      private var _timelineControl:Timeline = null;
      
      private var _wingHeight:Number;
      
      private const MOTION_TIME:Number = UtilUnitConvert.secToPixel(AnimeConstants.MOTION_DURATION);
      
      mx_internal var _watchers:Array;
      
      private var sceneChangeType:String = "Resize";
      
      private var _items:Array;
      
      private var _currItem:ITimelineElement;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _351951586itemList_cs:Canvas;
      
      private var _2135423153title_lbl:Label;
      
      private var _controlStageX:Number = 0;
      
      private var _focus:Boolean = false;
      
      private const MAX_WIDTH:Number = 2000;
      
      private var _label:String;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var _wingWidth:Number;
      
      public function SceneContainer()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"canvasSceneLabel",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "visible":false,
                        "width":72,
                        "percentHeight":100,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off"
                     };
                  }
               }),new UIComponentDescriptor({
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
                  "id":"itemList_cs",
                  "stylesFactory":function():void
                  {
                     this.verticalCenter = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "buttonMode":true,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"itemList_hb",
                           "events":{
                              "childAdd":"__itemList_hb_childAdd",
                              "childRemove":"__itemList_hb_childRemove",
                              "updateComplete":"__itemList_hb_updateComplete"
                           },
                           "stylesFactory":function():void
                           {
                              this.left = "0";
                              this.verticalCenter = "0";
                              this.horizontalGap = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off"
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this.E_Symbol = SceneContainer_E_Symbol;
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.styleName = "normal";
         this._SceneContainer_Fade1_i();
         this.addEventListener("initialize",this.___SceneContainer_Canvas1_initialize);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         SceneContainer._watcherSetupUtil = param1;
      }
      
      private function arrowEventHandler(param1:ExtraDataEvent) : void
      {
         this.currentScene = param1.getEventCreater() as SceneElement;
         this.onControlDownHandler(param1.getData() as MouseEvent);
      }
      
      private function onControlMoveHandler(param1:MouseEvent) : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"Resize"));
         param1.updateAfterEvent();
         var _loc2_:Number = this._controlPrevW + param1.stageX - this._controlPrevX;
         var _loc3_:Number = AnimeConstants.SCENE_LENGTH_MINIMUM;
         if(_loc2_ < _loc3_)
         {
            _loc2_ = _loc3_;
         }
         this._timelineControl.onSceneResize(SceneElement(this._currItem),_loc2_);
      }
      
      public function getCurrIndex() : int
      {
         return this._itemsCollect.getItemIndex(this._currItem);
      }
      
      public function get count() : int
      {
         return this._itemsCollect.length;
      }
      
      public function removeSceneMotionTimeByIndex(param1:int = -1) : void
      {
         if(param1 < 0)
         {
            param1 = this.getCurrIndex();
         }
         var _loc2_:SceneElement = this._itemsCollect.getItemAt(param1) as SceneElement;
         if(_loc2_.motionTime == this.MOTION_TIME)
         {
            _loc2_.width = _loc2_.width - this.MOTION_TIME;
         }
         _loc2_.motionTime = 0;
      }
      
      private function _SceneContainer_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.cce = _loc1_;
         _loc1_.alphaFrom = 0;
         _loc1_.alphaTo = 1;
         _loc1_.duration = 200;
         return _loc1_;
      }
      
      public function enableFocus() : void
      {
         this._enableFocus = true;
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
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
      
      public function __itemList_hb_childRemove(param1:ChildExistenceChangedEvent) : void
      {
         this.removeArrowListener(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get itemList_cs() : Canvas
      {
         return this._351951586itemList_cs;
      }
      
      public function __title_lbl_creationComplete(param1:FlexEvent) : void
      {
         this.showTitle();
      }
      
      private function onControlDownHandler(param1:MouseEvent) : void
      {
         this._controlClickStatus = true;
         this._controlPrevX = param1.stageX;
         this._controlPrevW = this._currItem.width;
         SceneElement(this._currItem).showIndicator();
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onControlMoveHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onControlUpHandler);
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_START));
      }
      
      private function _SceneContainer_bindingsSetup() : Array
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
         return result;
      }
      
      private function set currentScene(param1:ITimelineElement) : void
      {
         if(param1 && param1 != this._currItem)
         {
            if(this._currItem)
            {
               this._currItem.focus = false;
               SceneElement(this._currItem).showAddSceneBtn = false;
            }
            param1.focus = true;
            if(this._itemsCollect.length - 1 == this._itemsCollect.getItemIndex(param1) && !Console.getConsole().isTutorialOn)
            {
               SceneElement(param1).showAddSceneBtn = true;
            }
            this._currItem = param1;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get cce() : Fade
      {
         return this._98309cce;
      }
      
      public function getSceneBounds() : Array
      {
         var _loc4_:ITimelineElement = null;
         var _loc1_:Array = new Array();
         var _loc2_:Number = this._itemsCollect.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this.itemList_hb.getChildAt(_loc3_) as ITimelineElement;
            _loc1_.push(new Rectangle(_loc4_.x,_loc4_.y,_loc4_.width,_loc4_.height));
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function set itemList_cs(param1:Canvas) : void
      {
         var _loc2_:Object = this._351951586itemList_cs;
         if(_loc2_ !== param1)
         {
            this._351951586itemList_cs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemList_cs",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get canvasSceneLabel() : Canvas
      {
         return this._67793216canvasSceneLabel;
      }
      
      public function ___SceneContainer_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.initApp();
      }
      
      public function removeAllItems() : void
      {
         this._itemsCollect.removeAll();
         this.itemList_hb.removeAllChildren();
         this._currItem = null;
      }
      
      [Bindable(event="propertyChange")]
      public function get title_lbl() : Label
      {
         return this._2135423153title_lbl;
      }
      
      private function onControlUpHandler(param1:MouseEvent) : void
      {
         this._controlClickStatus = false;
         stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onControlMoveHandler);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.onControlUpHandler);
         this.itemList_hb.graphics.clear();
         SceneElement(this._currItem).removeIndicator();
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_RESIZE_COMPLETE));
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_MOUSE_UP));
         Util.gaTracking("/gostudio/timeline/ControlSceneResize",this.stage);
         this.dispatchEvent(new Event("TIMELINE_CHANGE_COMPLETE"));
      }
      
      public function addItem(param1:UIComponent) : void
      {
         this.addItemAt(param1,this._itemsCollect.length);
      }
      
      public function set itemList_hb(param1:HBox) : void
      {
         var _loc2_:Object = this._351951448itemList_hb;
         if(_loc2_ !== param1)
         {
            this._351951448itemList_hb = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemList_hb",_loc2_,param1));
         }
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
      
      private function addSceneHandler() : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"AddScene"));
      }
      
      private function _SceneContainer_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.cce;
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:ITimelineElement = param1.currentTarget as ITimelineElement;
         this.currentScene = _loc2_;
         SceneElement(_loc2_).id = String(this.getCurrIndex());
         dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_MOUSE_DOWN));
         this._originalX = this.stage.mouseX;
         this._originalY = this.stage.mouseY;
      }
      
      public function addSceneMotionTimeByIndex(param1:int = -1) : void
      {
         if(param1 < 0)
         {
            param1 = this.getCurrIndex();
         }
         var _loc2_:SceneElement = this._itemsCollect.getItemAt(param1) as SceneElement;
         if(_loc2_.motionTime <= 0)
         {
            _loc2_.width = _loc2_.width + this.MOTION_TIME;
         }
         _loc2_.motionTime = this.MOTION_TIME;
      }
      
      public function __itemList_hb_updateComplete(param1:FlexEvent) : void
      {
         this.onUpdateComplete(param1);
      }
      
      public function __itemList_hb_childAdd(param1:ChildExistenceChangedEvent) : void
      {
         this.addArrowListener(param1);
      }
      
      public function setCurrIndex(param1:Number) : void
      {
         this.currentIndex = param1;
      }
      
      public function set canvasSceneLabel(param1:Canvas) : void
      {
         var _loc2_:Object = this._67793216canvasSceneLabel;
         if(_loc2_ !== param1)
         {
            this._67793216canvasSceneLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvasSceneLabel",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var target:SceneContainer = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._SceneContainer_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_timeline_SceneContainerWatcherSetupUtil");
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
      
      public function updateSpeechTxtByIndex(param1:int = -1, param2:String = "") : void
      {
         if(param1 < 0)
         {
            param1 = this.getCurrIndex();
         }
         var _loc3_:SceneElement = this._itemsCollect.getItemAt(param1) as SceneElement;
         _loc3_.updateSpeechComment(param2);
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
      
      public function isSceneVisible(param1:int) : Boolean
      {
         var _loc2_:SceneElement = this._itemsCollect.getItemAt(param1) as SceneElement;
         var _loc3_:Number = _loc2_.x + this.itemList_hb.x;
         var _loc4_:Number = _loc2_.x + _loc2_.width + this.itemList_hb.x;
         var _loc5_:Number = 0;
         var _loc6_:Number = this.itemList_cs.width;
         if(_loc3_ > _loc5_ && _loc3_ < _loc6_ && (_loc4_ > _loc5_ && _loc4_ < _loc6_))
         {
            return true;
         }
         return false;
      }
      
      public function getItemAt(param1:int) : ITimelineElement
      {
         var index:int = param1;
         var item:ITimelineElement = null;
         try
         {
            item = this._itemsCollect.getItemAt(index) as ITimelineElement;
         }
         catch(e:RangeError)
         {
         }
         return item;
      }
      
      public function changeProperty(param1:int, param2:String, param3:* = null) : void
      {
         var _loc4_:ITimelineElement = null;
         if(param1 >= 0 && param1 < this._itemsCollect.length)
         {
            (_loc4_ = this._itemsCollect.getItemAt(param1) as ITimelineElement)[param2] = param3;
            this._itemsCollect.setItemAt(_loc4_,param1);
            this.itemList_hb.setChildIndex(_loc4_ as UIComponent,param1);
         }
      }
      
      public function addItemAt(param1:UIComponent, param2:int) : void
      {
         this._itemsCollect.addItemAt(param1,param2);
         var _loc3_:ITimelineElement = this.itemList_hb.addChildAt(param1,param2) as ITimelineElement;
         this.itemList_hb.validateNow();
         _loc3_.setTimelineReferer(this._timelineControl);
         param1.addEventListener("TIMELINE_CHANGE",this.timelineChangeHandler);
         SceneElement(_loc3_).id = String(param2);
         this.currentIndex = param2;
         param1.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         this.callLater(this.addSceneHandler);
      }
      
      [Bindable(event="propertyChange")]
      public function get itemList_hb() : HBox
      {
         return this._351951448itemList_hb;
      }
      
      public function set focus(param1:Boolean) : void
      {
         this._focus = param1;
         if(this._focus && this._enableFocus)
         {
         }
      }
      
      private function set currentIndex(param1:Number) : void
      {
         var _loc2_:ITimelineElement = null;
         if(param1 >= 0 && param1 < this._itemsCollect.length)
         {
            _loc2_ = this._itemsCollect.getItemAt(param1) as ITimelineElement;
            this.currentScene = _loc2_;
         }
      }
      
      private function addArrowListener(param1:ChildExistenceChangedEvent) : void
      {
         if(param1.relatedObject is SceneElement)
         {
            (param1.relatedObject as SceneElement).addEventListener("ArrowClick",this.arrowEventHandler);
         }
      }
      
      public function removeItem(param1:Number = -1) : Boolean
      {
         var index:Number = param1;
         try
         {
            if(index < 0)
            {
               index = this.getCurrIndex();
            }
            if(index <= this._itemsCollect.length)
            {
               this._itemsCollect.removeItemAt(index);
               this.itemList_hb.removeChildAt(index);
               if(index >= this._itemsCollect.length && index != 0)
               {
                  index = this._itemsCollect.length - 1;
               }
               if(this._itemsCollect.length > 0)
               {
                  this.currentIndex = index;
               }
               else
               {
                  this._currItem = null;
               }
               this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"RemoveScene"));
               return true;
            }
            return false;
         }
         catch(e:RangeError)
         {
            trace("SceneContainer: removeItem - ",e.message);
            return false;
         }
      }
      
      private function resetItemsFocus() : void
      {
      }
      
      private function timelineChangeHandler(param1:Event) : void
      {
         this.dispatchEvent(new ExtraDataEvent("TIMELINE_CHANGE",this,"SetSceneDuration"));
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
      }
      
      private function removeArrowListener(param1:ChildExistenceChangedEvent) : void
      {
         if(param1.relatedObject is SceneElement && (param1.relatedObject as SceneElement).hasEventListener("ArrowClick"))
         {
            (param1.relatedObject as SceneElement).removeEventListener("ArrowClick",this.arrowEventHandler);
         }
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         if(!this._controlClickStatus)
         {
            dispatchEvent(new TimelineEvent(TimelineEvent.SCENE_MOUSE_UP));
         }
      }
      
      public function disableFocus() : void
      {
         this._enableFocus = false;
      }
      
      public function getCurrItem() : ITimelineElement
      {
         return this._currItem;
      }
      
      private function onUpdateComplete(param1:Event) : void
      {
      }
      
      public function get length() : Number
      {
         return this._itemsCollect.length;
      }
      
      public function get focus() : Boolean
      {
         return this._focus;
      }
      
      public function selectSceneElement(param1:SceneElement) : void
      {
         this.currentScene = param1;
      }
      
      public function getHorizontalView() : Number
      {
         return this.itemList_hb.getStyle("left");
      }
      
      override public function set label(param1:String) : void
      {
         this._label = param1;
         this.showTitle();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function initApp() : void
      {
         this._items = new Array();
         this._itemsCollect = new ArrayCollection(this._items);
      }
      
      public function setCurrentItemByIndex(param1:int) : void
      {
         this.currentIndex = param1;
      }
      
      public function setHorizontalView(param1:Number = 0) : void
      {
         this.itemList_hb.setStyle("left",-param1);
      }
      
      override public function get label() : String
      {
         return this._label;
      }
   }
}
