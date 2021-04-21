package anifire.core
{
   import anifire.bubble.Bubble;
   import anifire.bubble.BubbleEvent;
   import anifire.bubble.BubbleMgr;
   import anifire.command.ChangeBubbleCommand;
   import anifire.command.ICommand;
   import anifire.command.MoveBubbleTailCommand;
   import anifire.control.BubbleControl;
   import anifire.control.Control;
   import anifire.control.ControlEvent;
   import anifire.control.ControlMgr;
   import anifire.control.FontChooser;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IResize;
   import anifire.util.BadwordFilter;
   import anifire.util.Util;
   import anifire.util.UtilDict;
   import anifire.util.UtilErrorLogger;
   import anifire.util.UtilLicense;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilUser;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class BubbleAsset extends Asset implements IResize, IDraggable
   {
      
      public static var XML_NODE_NAME:String = "bubbleAsset";
      
      public static const MENU_LABEL_EDIT:String = "effecttray_edit";
      
      private static var _logger:ILogger = Log.getLogger("core.BubbleAsset");
       
      
      private var _edtime:Number = -1;
      
      private var _readyToDrag:Boolean = false;
      
      private var _fxName:String;
      
      private var _prevTailX:Number;
      
      private var _originalBubbleHeight:Number;
      
      private var _fxDuration:Number;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _bubble:Bubble;
      
      private var _fontChooser:FontChooser;
      
      private var _prevTailY:Number;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      private var _originalTailX:Number;
      
      private var _originalTailY:Number;
      
      private var _originalBubbleWidth:Number;
      
      private var _sttime:Number = -1;
      
      private var _originalAssetXML:XML;
      
      private var _editing:Boolean;
      
      private var _fromTray:Boolean = false;
      
      protected var _myBubbleXML:XML = null;
      
      public function BubbleAsset(param1:String = "")
      {
         super();
         _logger.debug("BubbleAsset initialized");
         if(param1 == "")
         {
            param1 = "BUBBLE" + this.assetCount;
         }
         this.id = this.bundle.id = param1;
         this._minHeight = 20;
         this._minWidth = 20;
      }
      
      function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      override public function serialize() : String
      {
         var canvas:Canvas = null;
         var timeStr:String = null;
         var fxStr:String = null;
         var logger:UtilErrorLogger = null;
         var xmlStr:String = "";
         try
         {
            canvas = getSceneCanvas();
            timeStr = "";
            if(this.sttime > -1 && this.edtime > -1)
            {
               if(UtilUnitConvert.secToFrame(this.sttime) <= this.scene.getLength(-1,false) && UtilUnitConvert.secToFrame(this.edtime) <= this.scene.getLength(-1,false))
               {
                  timeStr = "<st>" + UtilUnitConvert.secToFrame(this.sttime) + "</st>" + "<et>" + UtilUnitConvert.secToFrame(this.edtime) + "</et>";
               }
            }
            fxStr = "";
            if(UtilUser.userType == UtilUser.ADMIN_USER && this.fxName && this.fxDuration)
            {
               fxStr = "<fx>" + this.fxName + "</fx>" + "<fxdur>" + this.fxDuration + "</fxdur>";
            }
            xmlStr = xmlStr + ("<bubbleAsset id=\"" + this.id + "\" index=\"" + canvas.getChildIndex(this.bundle) + "\">" + "<x>" + Util.roundNum(this.x) + "</x>" + "<y>" + Util.roundNum(this.y) + "</y>" + timeStr + fxStr + this._bubble.serialize().toXMLString() + "</bubbleAsset>");
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("BubbleAsset::serialize()",e);
            trace("Error:" + e);
         }
         return xmlStr;
      }
      
      public function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         _loc3_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_EDIT) + "\"/>" + "</root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         _loc5_.show(param1 - 80,param2);
      }
      
      override public function deleteAsset(param1:Boolean = true) : void
      {
         this.hideFontChooser();
         this.hideControl();
         hideButtonBar();
         super.deleteAsset(param1);
      }
      
      public function get fxDuration() : Number
      {
         return this._fxDuration;
      }
      
      function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      public function setSize(param1:Number) : void
      {
         var _loc2_:Number = this.bubble.width * param1;
         var _loc3_:Number = this.bubble.height * param1;
         _loc2_ = Math.max(_loc2_,this._minWidth);
         _loc3_ = Math.max(_loc3_,this._minHeight);
         var _loc4_:Number;
         if((_loc4_ = this.bubble.height / this.bubble.width) > 1)
         {
            _loc3_ = _loc4_ * _loc2_;
         }
         else
         {
            _loc2_ = _loc3_ / _loc4_;
         }
         param1 = _loc3_ / this.bubble.height;
         this.bubble.x = this.bubble.x + (this.bubble.width - _loc2_) / 2;
         this.bubble.y = this.bubble.y + (this.bubble.height - _loc3_) / 2;
         this.bubble.setTail(this.bubble.tailx * param1 + (this.bubble.width - _loc2_) / 2,this.bubble.taily * param1 + (this.bubble.height - _loc3_) / 2);
         this.bubble.setSize(_loc2_,_loc3_);
      }
      
      public function set fxDuration(param1:Number) : void
      {
         this._fxDuration = param1;
      }
      
      public function playBubble() : void
      {
         this.bubble.playBubble();
      }
      
      public function updateOriginalBubbleSize() : void
      {
         this._originalBubbleWidth = this.bubble.width;
         this._originalBubbleHeight = this.bubble.height;
      }
      
      public function getOriginalTailPosition() : Point
      {
         return new Point(this._originalTailX,this._originalTailY);
      }
      
      public function stopBubble() : void
      {
         this.bubble.stopBubble();
      }
      
      private function doEditComplete(param1:Event = null) : void
      {
         trace("doEditComplete at bubbleAsset:" + [this.bubble.checkCharacterSupport(),this.bubble.textEmbed]);
         if(UtilLicense.isBubbleI18NPermitted())
         {
            if(this.bubble.textEmbed)
            {
               if(!this.bubble.checkCharacterSupport())
               {
                  this.bubble.textEmbed = false;
                  if(this._fontChooser != null)
                  {
                     this.bubble.textFont = this._fontChooser.listFonts()[0].data;
                  }
               }
               else
               {
                  this.bubble.textEmbed = true;
               }
            }
         }
         this.editComplete(param1);
      }
      
      override public function freeze(param1:Boolean = true) : void
      {
         super.freeze(param1);
         if(!param1)
         {
            this.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         else
         {
            this.displayElement.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
      
      public function set bubble(param1:Bubble) : void
      {
         this._bubble = param1;
      }
      
      public function get bubble() : Bubble
      {
         return this._bubble;
      }
      
      public function doMenuClick(param1:MenuEvent) : void
      {
         this.scene.selectedAsset = this;
         this.scene.assetGroup.showControl();
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(!Console.getConsole().isTutorialOn)
         {
            showButtonBar();
         }
      }
      
      private function onCallLaterHandler(param1:ControlEvent) : void
      {
         scene.selectedAsset = this;
         var _loc2_:XML = this.bubble.serialize();
         var _loc3_:ICommand = new ChangeBubbleCommand(id,_loc2_);
         _loc3_.execute();
      }
      
      public function get text() : String
      {
         return this._bubble.text;
      }
      
      public function get sttime() : Number
      {
         return this._sttime;
      }
      
      override public function set control(param1:Control) : void
      {
         super.control = param1;
         if(this.control != null)
         {
            this.control.addEventListener(ControlEvent.TAIL_MOVE_START,this.doTailMoveStart);
            this.control.addEventListener(ControlEvent.TAIL_MOVE,this.doTailMove);
            this.control.addEventListener(ControlEvent.TAIL_MOVE_COMPLETE,this.doTailMoveComplete);
         }
      }
      
      override function hideControl() : void
      {
         super.hideControl();
         if(this._fontChooser != null && displayElement != null)
         {
            if(!this._fontChooser.hitTestPoint(displayElement.stage.mouseX,displayElement.stage.mouseY) && !this._fontChooser.click)
            {
               this.hideFontChooser();
            }
         }
         hideButtonBar();
      }
      
      override public function startResize() : void
      {
         super.startResize();
         if(this._bubble)
         {
            this._originalAssetXML = this._bubble.serialize();
            this._prevDisplayElementPosX = this._bubble.x;
            this._prevDisplayElementPosY = this._bubble.y;
         }
      }
      
      private function onTextChangedHandler(param1:BubbleEvent) : void
      {
         trace("onTextChanged");
         this.scene.doUpdateTimelineLength(-1,true);
         if(Console.getConsole().goWalker.guideMode)
         {
            this.hideControl();
         }
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         super.thumb = param1;
         this.imageData = param1.imageData;
      }
      
      function doTailMoveComplete(param1:Event) : void
      {
         var _loc2_:ICommand = null;
         if(this._originalAssetXML != this._bubble.serialize())
         {
            _loc2_ = new MoveBubbleTailCommand(id,this._originalAssetXML);
            _loc2_.execute();
         }
      }
      
      override function doDragComplete(param1:DragEvent) : void
      {
         this._readyToDrag = false;
         var _loc2_:UIComponent = UIComponent(param1.dragInitiator);
         _loc2_.alpha = 1;
         _loc2_.setFocus();
         if(this == this.scene.selectedAsset)
         {
            this.showControl();
         }
      }
      
      override function onMouseDown(param1:MouseEvent) : void
      {
         if(!this._editing)
         {
            trace("not editing");
            this.hideFontChooser();
            super.onMouseDown(param1);
         }
         this._readyToDrag = true;
         if(!this._editing || this._editing && !this._bubble.isMouseOnLabel())
         {
            this._originalX = getSceneCanvas().mouseX;
            this._originalY = getSceneCanvas().mouseY;
            _originalAssetX = this.x;
            _originalAssetY = this.y;
            displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
            displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
            Console.getConsole().thumbTrayActive = true;
         }
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc9_:Image = null;
         var _loc2_:Number = getSceneCanvas().mouseX;
         var _loc3_:Number = getSceneCanvas().mouseY;
         var _loc4_:Point = new Point(_loc2_,_loc3_);
         var _loc5_:Point = new Point(this._originalX,this._originalY);
         var _loc6_:Number = _loc4_.x - _loc5_.x;
         var _loc7_:Number = _loc4_.y - _loc5_.y;
         var _loc8_:Number = Math.sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_);
         if(this == this.scene.selectedAsset)
         {
            if(_loc2_ == this._originalX && _loc3_ == this._originalY)
            {
               if(this.text != this.bubble.backupText)
               {
                  this.text = this.bubble.backupText;
                  this.bubble.redraw();
               }
            }
            this._readyToDrag = false;
         }
         if(Console.getConsole().currDragObject != null)
         {
            if(this.scene.selectedAsset == null)
            {
            }
            (_loc9_ = Console.getConsole().currDragObject.bundle as Image).stopDrag();
            Console.getConsole().currDragObject = null;
         }
         changed = true;
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().thumbTrayActive = true;
      }
      
      private function doEditBubbleTextComplete(param1:Event = null) : void
      {
         var _loc2_:BadwordFilter = new BadwordFilter(Console.getConsole().getBadTerms(),null,Console.getConsole().getWhiteTerms());
         this.bubble.backupText = this.text;
         this.text = _loc2_.filter(this.text);
         if(this.bubble.backupText != this.text)
         {
            this.bubble.redraw();
         }
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
      }
      
      public function getOriginalBubbleSize() : Point
      {
         return new Point(this._originalBubbleWidth,this._originalBubbleHeight);
      }
      
      public function set edtime(param1:Number) : void
      {
         this._edtime = param1;
      }
      
      public function set sttime(param1:Number) : void
      {
         this._sttime = param1;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:BubbleAsset = new BubbleAsset();
         _loc3_._myBubbleXML = this.bubble.serialize();
         _loc3_.id = this.id;
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.scene = this.scene;
         _loc3_.thumb = this.thumb;
         return _loc3_;
      }
      
      public function set text(param1:String) : void
      {
         this._bubble.text = param1;
      }
      
      public function editComplete(param1:Event = null) : void
      {
         this._editing = false;
         this.doEditBubbleTextComplete();
         this._bubble.hideEditMode();
         if(param1 == null)
         {
         }
         this.scene.doUpdateTimelineLength(-1,true);
      }
      
      function doTailMoveStart(param1:Event) : void
      {
         var _loc2_:Bubble = Bubble(param1.target.asset);
         this._originalAssetXML = _loc2_.serialize();
         this._prevTailX = _loc2_.tailx;
         this._prevTailY = _loc2_.taily;
      }
      
      public function updateTimeByScene(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 / param2;
         if(this.sttime != -1 && this.edtime != -1)
         {
            this.sttime = this.sttime * _loc3_;
            this.edtime = this.edtime * _loc3_;
            this.sttime = Util.roundNum(this.sttime);
            this.edtime = Util.roundNum(this.edtime);
         }
      }
      
      private function showFontChooser(param1:MouseEvent = null) : void
      {
         var _loc2_:Object = null;
         var _loc3_:FontChooser = null;
         var _loc4_:Canvas = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(this._bubble != null)
         {
            this._bubble.showEditMode();
            this._editing = true;
            if(this._fontChooser == null)
            {
               _loc2_ = this._bubble.showEditMode();
               _loc3_ = FontChooser(new _loc2_.fontChooser());
               this._fontChooser = _loc3_.getChooser(this._bubble,_loc2_.paras);
               this._fontChooser.scaleX = this._fontChooser.scaleY = 1 / Console.getConsole().stageScale;
               this._fontChooser.name = "FONTCHOOSER";
               this._fontChooser.alpha = 1;
               this._fontChooser.addEventListener(ControlEvent.CALL_LATER,this.onCallLaterHandler);
               if(param1 != null)
               {
                  _loc4_ = Console.getConsole().mainStage._stageArea;
                  (_loc5_ = this._bubble.getBounds(_loc4_)).inflate(10,10);
                  _loc6_ = this._fontChooser.height;
                  _loc7_ = this._fontChooser.width;
                  _loc8_ = _loc5_.x;
                  _loc9_ = _loc4_.height - _loc6_;
                  if(_loc5_.y > _loc4_.height / 2)
                  {
                     _loc9_ = 0;
                  }
                  if(_loc8_ < 0)
                  {
                     _loc8_ = 0;
                  }
                  else if(_loc8_ + _loc7_ > _loc4_.width)
                  {
                     _loc8_ = _loc4_.width - _loc7_;
                  }
                  this._fontChooser.x = 0;
                  this._fontChooser.y = 0;
               }
               Console.getConsole().mainStage._controlLayer.addChild(this._fontChooser);
            }
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:Bubble = null;
         var _loc2_:XML = XML(this.imageData);
         if(this._myBubbleXML == null)
         {
            _loc1_ = BubbleMgr.getBubbleByXML(_loc2_);
         }
         else
         {
            _loc1_ = BubbleMgr.getBubbleByXML(XML(this._myBubbleXML));
         }
         _loc1_.addEventListener(BubbleEvent.TEXT_CHANGED,this.onTextChangedHandler);
         this._bubble = _loc1_;
         if(this._fromTray)
         {
            if(this._bubble.text == _loc2_.text.text())
            {
               this._bubble.text = this._bubble.backupText = UtilDict.toDisplay("store",this._bubble.text);
               this._bubble.text = this._bubble.backupText = "";
               if(this._bubble.text != _loc2_.text.text())
               {
                  this._bubble.textEmbed = false;
               }
               _loc1_.textEmbed = true;
               this._bubble.textFont = "Accidental Presidency";
            }
         }
         this._bubble.useDeviceFont = true;
         this._bubble.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.doEditComplete);
         this._bubble.addEventListener(FocusEvent.FOCUS_IN,this.doEditBegin);
         this._bubble.addEventListener(FocusEvent.FOCUS_OUT,this.doEditComplete);
         var _loc3_:int = 0;
         while(_loc3_ < this.displayElement.numChildren)
         {
            if(this.displayElement.getChildAt(_loc3_) is Bubble)
            {
               this.displayElement.removeChildAt(_loc3_);
               break;
            }
            _loc3_++;
         }
         this.displayElement.addChild(_loc1_);
         if(this._fromTray)
         {
            bundle.x = bundle.x - _loc1_.width / 2;
            bundle.y = bundle.y - _loc1_.height / 2;
         }
      }
      
      public function get bubbleObject() : Object
      {
         if(this._bubble)
         {
            return this._bubble.bubbleObject;
         }
         return null;
      }
      
      public function get edtime() : Number
      {
         return this._edtime;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene) : void
      {
         var _loc3_:BubbleThumb = new BubbleThumb();
         _loc3_.imageData = param1.bubble;
         this.scene = param2;
         this.x = param1.x;
         this.y = param1.y;
         if(param1.child("st").length() > 0 && param1.child("st").length() > 0)
         {
            this.sttime = UtilUnitConvert.frameToSec(param1.st);
            this.edtime = UtilUnitConvert.frameToSec(param1.et);
         }
         else
         {
            this.sttime = -1;
            this.edtime = -1;
         }
         this.thumb = _loc3_;
         this.isLoadded = true;
      }
      
      public function endResize() : void
      {
         this.changed = true;
         if(this._originalAssetXML != this._bubble.serialize())
         {
         }
      }
      
      public function resizing(param1:Control) : void
      {
         if(this._editing)
         {
            this.doEditComplete();
         }
         var _loc2_:Bubble = Bubble(param1.asset);
         var _loc3_:Object = param1.getStuff(this._prevDisplayElementPosX,this._prevDisplayElementPosY);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _loc2_.setSize(_loc3_.w,_loc3_.h);
      }
      
      public function updateOriginalTailPosition() : void
      {
         this._originalTailX = this.bubble.tailx;
         this._originalTailY = this.bubble.taily;
      }
      
      private function doEditBegin(param1:Event = null) : void
      {
      }
      
      private function hideFontChooser() : void
      {
         if(this._bubble != null)
         {
            this._bubble.hideEditMode();
            this._editing = false;
            Console.getConsole().thumbTrayActive = true;
         }
         if(this._fontChooser != null)
         {
            Console.getConsole().mainStage._controlLayer.removeChild(this._fontChooser);
            this._fontChooser = null;
         }
      }
      
      public function set fxName(param1:String) : void
      {
         this._fxName = param1;
      }
      
      function doTailMove(param1:Event) : void
      {
         if(this._editing)
         {
            this.doEditComplete(param1);
         }
         var _loc2_:Bubble = Bubble(param1.target.asset);
         var _loc3_:Number = param1.target.xTailOffset;
         var _loc4_:Number = param1.target.yTailOffset;
         _loc2_.setTail(this._prevTailX + _loc3_,this._prevTailY + _loc4_);
      }
      
      override public function addControl() : void
      {
         var _loc1_:BubbleControl = ControlMgr.getControl(this._bubble,ControlMgr.BUBBLE) as BubbleControl;
         _loc1_.target = this;
         _loc1_.asset = this._bubble;
         _loc1_.setPos(this._bubble.x,this._bubble.y);
         _loc1_.setOrigin(this._bubble.width / 2,this._bubble.height / 2);
         _loc1_.setTail(this._bubble.tailx,this._bubble.taily);
         _loc1_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
         _loc1_.addEventListener("CtrlPointUp",onCtrlPointUpHandler);
         _loc1_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
         _loc1_.hideControl();
         this.control = _loc1_;
      }
      
      public function get fxName() : String
      {
         return this._fxName;
      }
      
      public function startDragging() : void
      {
         this.hideControl();
         var _loc1_:Image = Image(this.bundle);
         _loc1_.startDrag();
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
      }
   }
}
