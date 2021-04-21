package anifire.control
{
   import anifire.event.ExtraDataEvent;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IResize;
   import anifire.interfaces.IRotatable;
   import anifire.util.UtilCursor;
   import flash.display.CapsStyle;
   import flash.display.DisplayObject;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import mx.events.ResizeEvent;
   
   public class Control extends Sprite
   {
      
      private static const MIDDLE_TOP:String = "middleTop";
      
      private static const LEFT_MIDDLE:String = "leftMiddle";
      
      private static const RIGHT_BOTTOM:String = "rightBottom";
      
      private static const MIDDLE_BOTTOM:String = "middleBottom";
      
      private static const ROTATE:String = "rotate";
      
      private static const LEFT_BOTTOM:String = "leftBottom";
      
      private static const RIGHT_TOP:String = "rightTop";
      
      private static var _instance:Control;
      
      private static const RIGHT_MIDDLE:String = "rightMiddle";
      
      private static const LEFT_TOP:String = "leftTop";
      
      private static var _instance2:Control;
       
      
      private var _outline:Sprite;
      
      protected var _rightBottomController_sp:Sprite;
      
      protected var slope_new:Number;
      
      protected var _middleBottomController_sp:Sprite;
      
      private var _rotatable:Boolean = false;
      
      private const HEIGHT:String = "height";
      
      private var _resizable:Boolean = true;
      
      private var _readyToDrag:Boolean = false;
      
      protected var _initH:Number = 0;
      
      protected var _initW:Number = 0;
      
      private var _lineAlpha:Number = 0.5;
      
      private var _lineColor:Number = 16290304;
      
      protected var _assetWidth:Number = 0;
      
      private var MIN_WIDTH:Number = 20;
      
      private const LINESZ:Number = 10;
      
      public var controlSymbol:Class;
      
      protected var _middleTopController_sp:Sprite;
      
      private var _lineSize:Number;
      
      protected var _prevH:Number = 0;
      
      protected var _assetHeight:Number = 0;
      
      private const BOTH:String = "both";
      
      private const MAX_HEIGHT:Number = 3000;
      
      protected var _leftMiddleController_sp:Sprite;
      
      protected var _rotateController_sp:Sprite;
      
      protected var _prevY:Number = 0;
      
      private var _originMode:Boolean = true;
      
      private var _stageScale:Number = 1;
      
      protected var _prevW:Number = 0;
      
      protected var _currController:Sprite;
      
      protected var _leftTopController_sp:Sprite;
      
      protected var slope_old:Number;
      
      protected var _controlPad:Sprite;
      
      protected var tSize:Number;
      
      protected var _prevX:Number = 0;
      
      private const WIDTH:String = "width";
      
      protected var _leftBottomController_sp:Sprite;
      
      private var _target:Object;
      
      protected var _offset:Number;
      
      protected var _originX:Number = 0;
      
      protected var _originY:Number = 0;
      
      protected var _rightTopController_sp:Sprite;
      
      private var MIN_HEIGHT:Number = 20;
      
      protected var _relx:Number = 0;
      
      protected var _rely:Number = 0;
      
      private var _assetAspectRatio:Number = 0;
      
      private const MAX_WIDTH:Number = 3000;
      
      protected var _rightMiddleController_sp:Sprite;
      
      private var _asset:DisplayObject;
      
      private const OFFST:Number = 10;
      
      public function Control()
      {
         this.controlSymbol = Control_controlSymbol;
         this._offset = this.OFFST / this.stageScale;
         this._lineSize = this.LINESZ / this.stageScale;
         super();
         this.addEventListener(ControlEvent.RESIZE_START,this.onResizeStart);
         this.addEventListener(ControlEvent.RESIZE_COMPLETE,this.onResizeEnd);
         this.addEventListener(ResizeEvent.RESIZE,this.onResizing);
         this.addEventListener(ControlEvent.OUTLINE_DOWN,this.onBorderDown);
         this.addEventListener(ControlEvent.ROTATE,this.onRotate);
      }
      
      private static function changeResizeCursor(param1:String) : void
      {
         var _loc2_:Class = Control_E_Symbol;
         var _loc3_:Class = Control_S_Symbol;
         var _loc4_:Class = Control_NE_Symbol;
         var _loc5_:Class = Control_SE_Symbol;
         if(param1 == "E" || param1 == "W")
         {
            UtilCursor.changeCursor(_loc2_);
         }
         else if(param1 == "S" || param1 == "N")
         {
            UtilCursor.changeCursor(_loc3_);
         }
         else if(param1 == "NE" || param1 == "SW")
         {
            UtilCursor.changeCursor(_loc4_);
         }
         else if(param1 == "SE" || param1 == "NW")
         {
            UtilCursor.changeCursor(_loc5_);
         }
         else
         {
            UtilCursor.changeCursor(null);
         }
      }
      
      public static function getInstance2() : Control
      {
         if(!_instance2)
         {
            _instance2 = new Control();
         }
         return _instance2;
      }
      
      public static function getInstance() : Control
      {
         if(!_instance)
         {
            _instance = new Control();
         }
         return _instance;
      }
      
      private function removeControlListener() : void
      {
         this._leftTopController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._leftTopController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._leftTopController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._middleTopController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._middleTopController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._middleTopController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._rightTopController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._rightTopController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._rightTopController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._leftMiddleController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._leftMiddleController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._leftMiddleController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._rightMiddleController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._rightMiddleController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._rightMiddleController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._leftBottomController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._leftBottomController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._leftBottomController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._middleBottomController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._middleBottomController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._middleBottomController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this._rightBottomController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         this._rightBottomController_sp.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         this._rightBottomController_sp.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         if(this.rotatable)
         {
            this._rotateController_sp.removeEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         }
      }
      
      public function get lineSize() : Number
      {
         return this._lineSize;
      }
      
      public function enableResize() : void
      {
         try
         {
            this._controlPad.visible = this._resizable = true;
            this.addControlListener();
         }
         catch(e:Error)
         {
            trace("Have\'t create control");
         }
      }
      
      public function set minWidth(param1:Number) : void
      {
         this.MIN_WIDTH = param1;
      }
      
      public function set target(param1:Object) : void
      {
         this._target = param1;
         this.x = 0;
         this.y = 0;
         this.reset();
      }
      
      public function get xOffset() : Number
      {
         return this._relx;
      }
      
      private function onBorderDown(param1:ControlEvent) : void
      {
         if(this._target is IDraggable)
         {
            IDraggable(this._target).startDragging();
         }
      }
      
      public function setOrigin(param1:Number = 0, param2:Number = 0) : void
      {
         this._originX = param1;
         this._originY = param2;
      }
      
      private function onRotate(param1:ControlEvent) : void
      {
         if(this._target is IRotatable)
         {
            IRotatable(this._target).rotate(this);
         }
      }
      
      public function get assetHeight() : Number
      {
         return this._assetHeight;
      }
      
      private function clearDraw() : void
      {
         if(this._controlPad != null)
         {
            removeChild(this._controlPad);
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
      }
      
      public function getStuff(param1:Number, param2:Number) : ControlStuff
      {
         var _loc3_:Number = param1 + this._leftTopController_sp.x + this._offset;
         var _loc4_:Number = param2 + this._leftTopController_sp.y + this._offset;
         var _loc5_:Number = this.assetWidth / this._initW;
         var _loc6_:Number = this.assetHeight / this._initH;
         return new ControlStuff(_loc3_,_loc4_,this.assetWidth,this.assetHeight,_loc5_,_loc6_,this._originX,this._originY);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         changeResizeCursor(null);
      }
      
      public function set minHeight(param1:Number) : void
      {
         this.MIN_HEIGHT = param1;
      }
      
      protected function checkAndKeepMinSize(param1:String = "both") : void
      {
         switch(param1)
         {
            case this.HEIGHT:
               if(this._assetHeight <= this.MIN_HEIGHT)
               {
                  this._assetHeight = this.MIN_HEIGHT;
               }
               break;
            case this.WIDTH:
               if(this._assetWidth <= this.MIN_WIDTH)
               {
                  this._assetWidth = this.MIN_WIDTH;
               }
               break;
            case this.BOTH:
               if(this._assetHeight <= this.MIN_HEIGHT)
               {
                  this._assetHeight = this.MIN_HEIGHT;
                  this._assetWidth = this._assetHeight * this._assetAspectRatio;
               }
               if(this._assetWidth <= this.MIN_WIDTH)
               {
                  this._assetWidth = this.MIN_WIDTH;
                  this._assetHeight = this._assetWidth / this._assetAspectRatio;
               }
         }
      }
      
      public function reset() : void
      {
         this._asset = null;
         this._assetWidth = 0;
         this._assetHeight = 0;
         this._assetAspectRatio = 0;
         this._relx = 0;
         this._rely = 0;
         this._resizable = true;
         this._originX = 0;
         this._originY = 0;
         this._originMode = true;
         this.MIN_WIDTH = 20;
         this.MIN_HEIGHT = 20;
         this._stageScale = 1;
         this._offset = this.OFFST / this.stageScale;
         this._lineSize = this.LINESZ / this.stageScale;
         this._lineColor = 16290304;
         this._lineAlpha = 0.5;
         this._rotatable = false;
         this._prevX = 0;
         this._prevY = 0;
         this._prevW = 0;
         this._prevH = 0;
         this._initW = 0;
         this._initH = 0;
         this.slope_old = 0;
         this.slope_new = 0;
         this.tSize = 0;
         this.visible = true;
      }
      
      private function onControlUpHandler(param1:MouseEvent) : void
      {
         if(this._currController != null)
         {
            this._currController.stopDrag();
            this._relx = this._currController.x - this._prevX;
            this._rely = this._currController.y - this._prevY;
         }
         this.resetRegisterPoint();
         this._currController = null;
         UtilCursor.changeCursor(null);
         this.addControlListener();
         param1.currentTarget.removeEventListener(MouseEvent.MOUSE_MOVE,this.onControlMoveHandler);
         param1.currentTarget.removeEventListener(MouseEvent.MOUSE_UP,this.onControlUpHandler);
         dispatchEvent(new ControlEvent(ControlEvent.RESIZE_COMPLETE));
         dispatchEvent(new Event("CtrlPointUp"));
      }
      
      private function setMinAspectSize() : void
      {
         if(this._assetHeight < this._assetWidth)
         {
            this._assetHeight = this.MIN_HEIGHT;
            this._assetWidth = this._assetHeight * this._assetAspectRatio;
         }
         else
         {
            this._assetWidth = this.MIN_WIDTH;
            this._assetHeight = this._assetWidth / this._assetAspectRatio;
         }
      }
      
      public function set rotatable(param1:Boolean) : void
      {
         this._rotatable = param1;
         if(this._rotateController_sp)
         {
            this._rotateController_sp.visible = param1;
         }
      }
      
      public function getGlobalCenter() : Point
      {
         var _loc1_:Point = new Point();
         _loc1_.x = this.assetWidth / 2;
         _loc1_.y = this.assetHeight / 2;
         return this.localToGlobal(_loc1_);
      }
      
      protected function drawOutline(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         param3 = param3 <= 0?Number(this._assetWidth):Number(param3);
         param4 = param4 <= 0?Number(this._assetHeight):Number(param4);
         if(this._outline != null)
         {
            removeChild(this._outline);
         }
         this._outline = new Sprite();
         this._outline.name = "outline";
         this._outline.graphics.clear();
         this._outline.graphics.lineStyle(this._lineSize,this._lineColor,this._lineAlpha,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND);
         this._outline.graphics.drawRect(0 - this._offset / 2,0 - this._offset / 2,param3 + this._offset,param4 + this._offset);
         this._outline.x = param1;
         this._outline.y = param2;
         addChild(this._outline);
         this._outline.addEventListener(MouseEvent.MOUSE_DOWN,this.onOutlineDownHandler);
      }
      
      private function onResizeEnd(param1:Event) : void
      {
         if(this._target is IResize)
         {
            IResize(this._target).endResize();
         }
      }
      
      public function get yOffset() : Number
      {
         return this._rely;
      }
      
      public function get currController() : Sprite
      {
         return this._currController;
      }
      
      private function onResizing(param1:Event) : void
      {
         if(this._target is IResize)
         {
            IResize(this._target).resizing(this);
         }
      }
      
      public function set assetWidth(param1:Number) : void
      {
         this._assetWidth = param1;
      }
      
      public function set assetHeight(param1:Number) : void
      {
         this._assetHeight = param1;
      }
      
      private function addControlListener() : void
      {
         if(this._resizable)
         {
            this._leftTopController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._leftTopController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._leftTopController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._middleTopController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._middleTopController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._middleTopController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._rightTopController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._rightTopController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._rightTopController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._leftMiddleController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._leftMiddleController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._leftMiddleController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._rightMiddleController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._rightMiddleController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._rightMiddleController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._leftBottomController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._leftBottomController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._leftBottomController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._middleBottomController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._middleBottomController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._middleBottomController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this._rightBottomController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
            this._rightBottomController_sp.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            this._rightBottomController_sp.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         }
         if(this.rotatable)
         {
            this._rotateController_sp.addEventListener(MouseEvent.MOUSE_DOWN,this.onControlDownHandler);
         }
      }
      
      public function get direction() : String
      {
         if(this._currController != null)
         {
            if(this._currController.name == LEFT_TOP)
            {
               return "NW";
            }
            if(this._currController.name == MIDDLE_TOP)
            {
               return "N";
            }
            if(this._currController.name == RIGHT_TOP)
            {
               return "NE";
            }
            if(this._currController.name == LEFT_MIDDLE)
            {
               return "W";
            }
            if(this._currController.name == RIGHT_MIDDLE)
            {
               return "E";
            }
            if(this._currController.name == LEFT_BOTTOM)
            {
               return "SW";
            }
            if(this._currController.name == MIDDLE_BOTTOM)
            {
               return "S";
            }
            if(this._currController.name == RIGHT_BOTTOM)
            {
               return "SE";
            }
         }
         return null;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._assetWidth = this._initW = param1;
         this._assetHeight = this._initH = param2;
         this.redraw();
         this.addControlListener();
      }
      
      public function setPos(param1:Number, param2:Number) : void
      {
         x = x + param1;
         y = y + param2;
         this.redraw();
         this.addControlListener();
      }
      
      public function setLineColor(param1:uint) : void
      {
         this._lineColor = param1;
         this.redraw();
      }
      
      public function get rotatable() : Boolean
      {
         return this._rotatable;
      }
      
      protected function resetRegisterPoint() : void
      {
         x = x + (this._leftTopController_sp.x + this._offset);
         y = y + (this._leftTopController_sp.y + this._offset);
         this._originX = this._originX - (this._leftTopController_sp.x + this._offset);
         this._originY = this._originY - (this._leftTopController_sp.y + this._offset);
         this.redraw();
      }
      
      public function showControl(param1:Number = 1) : void
      {
         var scale:Number = param1;
         try
         {
            if(scale != this.stageScale)
            {
               this.stageScale = scale;
               this.redraw();
               this.addControlListener();
            }
            this._outline.visible = true;
            this._controlPad.visible = this._resizable;
         }
         catch(e:Error)
         {
            trace("Have\'t create control");
         }
      }
      
      public function hideControl() : void
      {
         try
         {
            this._outline.visible = false;
            this._controlPad.visible = false;
         }
         catch(e:Error)
         {
            trace("Have\'t create control");
         }
      }
      
      public function get assetWidth() : Number
      {
         return this._assetWidth;
      }
      
      public function disableResize() : void
      {
         try
         {
            this._controlPad.visible = this._resizable = false;
            this.removeControlListener();
         }
         catch(e:Error)
         {
            trace("Have\'t create control");
         }
      }
      
      private function onResizeStart(param1:ControlEvent) : void
      {
         if(this._target is IResize)
         {
            IResize(this._target).startResize();
         }
      }
      
      protected function drawControlPoint(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         var _loc5_:Sprite = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:ColorTransform = null;
         if(this._controlPad == null)
         {
            this._controlPad = new Sprite();
         }
         param3 = param3 <= 0?Number(this._assetWidth):Number(param3);
         param4 = param4 <= 0?Number(this._assetHeight):Number(param4);
         if(this._resizable)
         {
            if(this._leftTopController_sp == null)
            {
               (_loc5_ = this._leftTopController_sp = new this.controlSymbol() as Sprite).name = LEFT_TOP;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._leftTopController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = 0 - _loc5_.width + param1;
            _loc5_.y = 0 - _loc5_.height + param2;
            if(this._middleTopController_sp == null)
            {
               (_loc5_ = this._middleTopController_sp = new this.controlSymbol() as Sprite).name = MIDDLE_TOP;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._middleTopController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = (param3 - _loc5_.width) / 2 + param1;
            _loc5_.y = 0 - _loc5_.height + param2;
            if(this._rightTopController_sp == null)
            {
               (_loc5_ = this._rightTopController_sp = new this.controlSymbol() as Sprite).name = RIGHT_TOP;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._rightTopController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = this.assetWidth + param1;
            _loc5_.y = 0 - _loc5_.height + param2;
            if(this._leftMiddleController_sp == null)
            {
               (_loc5_ = this._leftMiddleController_sp = new this.controlSymbol() as Sprite).name = LEFT_MIDDLE;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._leftMiddleController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = 0 - _loc5_.width + param1;
            _loc5_.y = (param4 - _loc5_.height) / 2 + param2;
            if(this._rightMiddleController_sp == null)
            {
               (_loc5_ = this._rightMiddleController_sp = new this.controlSymbol() as Sprite).name = RIGHT_MIDDLE;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._rightMiddleController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = this.assetWidth + param1;
            _loc5_.y = (param4 - _loc5_.height) / 2 + param2;
            if(this._leftBottomController_sp == null)
            {
               (_loc5_ = this._leftBottomController_sp = new this.controlSymbol() as Sprite).name = LEFT_BOTTOM;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._leftBottomController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = 0 - _loc5_.width + param1;
            _loc5_.y = param4 + param2;
            if(this._middleBottomController_sp == null)
            {
               (_loc5_ = this._middleBottomController_sp = new this.controlSymbol() as Sprite).name = MIDDLE_BOTTOM;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._middleBottomController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = (param3 - _loc5_.width) / 2 + param1;
            _loc5_.y = param4 + param2;
            if(this._rightBottomController_sp == null)
            {
               (_loc5_ = this._rightBottomController_sp = new this.controlSymbol() as Sprite).name = RIGHT_BOTTOM;
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._rightBottomController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = param3 + param1;
            _loc5_.y = param4 + param2;
         }
         if(this.rotatable)
         {
            _loc7_ = (_loc6_ = 15) / this.stageScale;
            if(this._rotateController_sp == null)
            {
               _loc5_ = new this.controlSymbol() as Sprite;
               this._rotateController_sp = _loc5_;
               _loc8_ = new ColorTransform(248 / 255,146 / 255,0 / 255);
               _loc5_.transform.colorTransform = _loc8_;
               _loc5_.name = ROTATE;
               this._rotateController_sp.graphics.beginFill(0);
               this._rotateController_sp.graphics.drawRect(-_loc6_,_loc5_.height / 2 - 1,_loc6_,2);
               this._rotateController_sp.graphics.endFill();
               this._controlPad.addChild(_loc5_);
            }
            else
            {
               _loc5_ = this._rotateController_sp;
            }
            _loc5_.scaleX = _loc5_.scaleY = 1 / this.stageScale;
            _loc5_.x = this.assetWidth + param1 + this._rightMiddleController_sp.width + _loc7_;
            _loc5_.y = (param4 - _loc5_.height) / 2 + param2;
         }
         addChild(this._controlPad);
      }
      
      public function set stageScale(param1:Number) : void
      {
         this._stageScale = param1;
         this._offset = this.OFFST / this.stageScale;
         this._lineSize = this.LINESZ / this.stageScale;
      }
      
      protected function onControlMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = 1;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:String = this._currController.name;
         var _loc6_:Point = this._controlPad.globalToLocal(new Point(param1.stageX,param1.stageY));
         switch(_loc5_)
         {
            case LEFT_TOP:
               this.slope_new = this.getSlope(new Point(_loc6_.x,_loc6_.y),new Point(this._rightBottomController_sp.x,this._rightBottomController_sp.y));
               if(_loc6_.x < this._rightBottomController_sp.x && _loc6_.y < this._rightBottomController_sp.y)
               {
                  if(this.slope_old <= this.slope_new)
                  {
                     this.tSize = this._prevW - _loc6_.x - this._offset / 2;
                     if(this._originX != 0)
                     {
                        _loc2_ = (this.tSize - this._prevW + this._originX) / this._originX;
                     }
                     this._assetWidth = _loc2_ * this._prevW;
                     this._assetHeight = this._assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     this.tSize = this._prevH - _loc6_.y - this._offset / 2;
                     if(this._originY != 0)
                     {
                        _loc2_ = (this.tSize - this._prevH + this._originY) / this._originY;
                     }
                     this._assetHeight = _loc2_ * this._prevH;
                     this._assetWidth = this._assetHeight * this._assetAspectRatio;
                  }
                  this.checkAndKeepMinSize();
               }
               break;
            case MIDDLE_TOP:
               this.tSize = this._prevH - _loc6_.y - this._offset / 2;
               if(this._originY != 0)
               {
                  _loc2_ = (this.tSize - this._prevH + this._originY) / this._originY;
               }
               this._assetHeight = _loc2_ * this._prevH;
               this.checkAndKeepMinSize(this.HEIGHT);
               break;
            case RIGHT_TOP:
               this.slope_new = this.getSlope(new Point(_loc6_.x,_loc6_.y),new Point(this._leftBottomController_sp.x + this._offset,this._leftBottomController_sp.y));
               if(_loc6_.x > this._leftBottomController_sp.x + this._offset && _loc6_.y < this._leftBottomController_sp.y)
               {
                  if(this.slope_old >= this.slope_new)
                  {
                     this.tSize = _loc6_.x - this._offset / 2;
                     if(this._prevW != this._originX)
                     {
                        _loc2_ = (this.tSize - this._originX) / (this._prevW - this._originX);
                     }
                     this._assetWidth = _loc2_ * this._prevW;
                     this._assetHeight = this._assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     this.tSize = this._prevH - _loc6_.y - this._offset / 2;
                     if(this._originY != 0)
                     {
                        _loc2_ = (this.tSize - this._prevH + this._originY) / this._originY;
                     }
                     this._assetHeight = _loc2_ * this._prevH;
                     this._assetWidth = this._assetHeight * this._assetAspectRatio;
                  }
                  this.checkAndKeepMinSize();
               }
               break;
            case LEFT_MIDDLE:
               this.tSize = this._prevW - _loc6_.x - this._offset / 2;
               if(this._originX != 0)
               {
                  _loc2_ = (this.tSize - this._prevW + this._originX) / this._originX;
               }
               this._assetWidth = _loc2_ * this._prevW;
               this.checkAndKeepMinSize(this.WIDTH);
               break;
            case RIGHT_MIDDLE:
               this.tSize = _loc6_.x - this._offset / 2;
               if(this._prevW != this._originX)
               {
                  _loc2_ = (this.tSize - this._originX) / (this._prevW - this._originX);
               }
               this._assetWidth = _loc2_ * this._prevW;
               this.checkAndKeepMinSize(this.WIDTH);
               break;
            case LEFT_BOTTOM:
               this.slope_new = this.getSlope(new Point(_loc6_.x,_loc6_.y),new Point(this._rightTopController_sp.x,this._rightTopController_sp.y + this._offset));
               if(_loc6_.x < this._rightTopController_sp.x && _loc6_.y > this._rightTopController_sp.y + this._offset)
               {
                  if(this.slope_old >= this.slope_new)
                  {
                     this.tSize = this._prevW - _loc6_.x - this._offset / 2;
                     if(this._originX != 0)
                     {
                        _loc2_ = (this.tSize - this._prevW + this._originX) / this._originX;
                     }
                     this._assetWidth = _loc2_ * this._prevW;
                     this._assetHeight = this._assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     this.tSize = _loc6_.y - this._offset / 2;
                     if(this._prevH != this._originY)
                     {
                        _loc2_ = (this.tSize - this._originY) / (this._prevH - this._originY);
                     }
                     this._assetHeight = _loc2_ * this._prevH;
                     this._assetWidth = this._assetHeight * this._assetAspectRatio;
                  }
                  this.checkAndKeepMinSize();
               }
               break;
            case MIDDLE_BOTTOM:
               this.tSize = _loc6_.y - this._offset / 2;
               if(this._prevH != this._originY)
               {
                  _loc2_ = (this.tSize - this._originY) / (this._prevH - this._originY);
               }
               this._assetHeight = _loc2_ * this._prevH;
               this.checkAndKeepMinSize(this.HEIGHT);
               break;
            case RIGHT_BOTTOM:
               this.slope_new = this.getSlope(new Point(_loc6_.x,_loc6_.y),new Point(this._leftTopController_sp.x + this._offset,this._leftTopController_sp.y + this._offset));
               if(_loc6_.x > this._leftTopController_sp.x + this._offset && _loc6_.y > this._leftTopController_sp.y + this._offset)
               {
                  if(this.slope_old <= this.slope_new)
                  {
                     this.tSize = _loc6_.x - this._offset / 2;
                     if(this._prevW != this._originX)
                     {
                        _loc2_ = (this.tSize - this._originX) / (this._prevW - this._originX);
                     }
                     this._assetWidth = _loc2_ * this._prevW;
                     this._assetHeight = this._assetWidth / this._assetAspectRatio;
                  }
                  else
                  {
                     this.tSize = _loc6_.y - this._offset / 2;
                     if(this._prevH != this._originY)
                     {
                        _loc2_ = (this.tSize - this._originY) / (this._prevH - this._originY);
                     }
                     this._assetHeight = _loc2_ * this._prevH;
                     this._assetWidth = this._assetHeight * this._assetAspectRatio;
                  }
                  this.checkAndKeepMinSize();
               }
         }
         _loc3_ = 0 - this._originX / this._prevW * (this._assetWidth - this._prevW);
         _loc4_ = 0 - this._originY / this._prevH * (this._assetHeight - this._prevH);
         this.drawOutline(_loc3_,_loc4_);
         this.drawControlPoint(_loc3_,_loc4_);
         this._relx = this._currController.x - this._prevX;
         this._rely = this._currController.y - this._prevY;
         if(this._currController == this._rotateController_sp)
         {
            dispatchEvent(new ControlEvent(ControlEvent.ROTATE));
         }
         else
         {
            dispatchEvent(new ControlEvent(ControlEvent.RESIZE));
            dispatchEvent(new ExtraDataEvent("CtrlPointMove",this,{
               "globalPt":this.localToGlobal(new Point(this._currController.x,this._currController.y)),
               "controlName":_loc5_,
               "assetWidth":this._assetWidth,
               "assetHeight":this._assetHeight
            }));
         }
         param1.updateAfterEvent();
      }
      
      private function onOutlineDownHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new ControlEvent(ControlEvent.OUTLINE_DOWN));
      }
      
      public function set asset(param1:DisplayObject) : void
      {
         this.setSize(param1.width,param1.height);
         this._asset = param1;
      }
      
      private function onControlDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = null;
         this._currController = _loc2_ = Sprite(param1.target);
         var _loc3_:Point = this._controlPad.globalToLocal(new Point(param1.stageX,param1.stageY));
         this._prevX = this._currController.x;
         this._prevY = this._currController.y;
         this._prevW = this._assetWidth;
         this._prevH = this._assetHeight;
         if(this._currController == this._rotateController_sp)
         {
            this._readyToDrag = true;
         }
         if(this._assetWidth != 0)
         {
            this._assetAspectRatio = this._assetWidth / this._assetHeight;
         }
         else
         {
            this._assetAspectRatio = Number.POSITIVE_INFINITY;
         }
         var _loc4_:Number = this.MIN_WIDTH;
         var _loc5_:Number = this.MIN_HEIGHT;
         _loc4_ = this._assetWidth >= this.MIN_WIDTH?Number(this.MIN_WIDTH):Number(this._assetWidth + this._offset);
         _loc5_ = this._assetHeight >= this.MIN_HEIGHT?Number(this.MIN_HEIGHT):Number(this._assetHeight + this._offset);
         var _loc6_:String = param1.target.name;
         switch(_loc6_)
         {
            case LEFT_TOP:
               this.slope_old = this.getSlope(new Point(this._leftTopController_sp.x + this._offset,this._leftTopController_sp.y + this._offset),new Point(this._rightBottomController_sp.x,this._rightBottomController_sp.y));
               if(!this._originMode)
               {
                  this._originX = this._assetWidth;
                  this._originY = this._assetHeight;
               }
               break;
            case MIDDLE_TOP:
               if(!this._originMode)
               {
                  this._originX = this._assetWidth / 2;
                  this._originY = this._assetHeight;
               }
               break;
            case RIGHT_TOP:
               this.slope_old = this.getSlope(new Point(this._rightTopController_sp.x,this._rightTopController_sp.y + this._offset),new Point(this._leftBottomController_sp.x + this._offset,this._leftBottomController_sp.y));
               if(!this._originMode)
               {
                  this._originX = 0;
                  this._originY = this._assetHeight;
               }
               break;
            case LEFT_MIDDLE:
               if(!this._originMode)
               {
                  this._originX = this._assetWidth;
                  this._originY = this._assetHeight / 2;
               }
               break;
            case RIGHT_MIDDLE:
               if(!this._originMode)
               {
                  this._originX = 0;
                  this._originY = this._assetHeight / 2;
               }
               break;
            case LEFT_BOTTOM:
               this.slope_old = this.getSlope(new Point(this._leftBottomController_sp.x + this._offset,this._leftBottomController_sp.y),new Point(this._rightTopController_sp.x,this._rightTopController_sp.y + this._offset));
               if(!this._originMode)
               {
                  this._originX = this._assetWidth;
                  this._originY = 0;
               }
               break;
            case MIDDLE_BOTTOM:
               if(!this._originMode)
               {
                  this._originX = this._assetWidth / 2;
                  this._originY = 0;
               }
               break;
            case RIGHT_BOTTOM:
               this.slope_old = this.getSlope(new Point(this._rightBottomController_sp.x,this._rightBottomController_sp.y),new Point(this._leftTopController_sp.x + this._offset,this._leftTopController_sp.y + this._offset));
               if(!this._originMode)
               {
                  this._originX = 0;
                  this._originY = 0;
               }
         }
         _loc2_.startDrag(false);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onControlMoveHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onControlUpHandler);
         dispatchEvent(new ControlEvent(ControlEvent.RESIZE_START));
         dispatchEvent(new ExtraDataEvent("CtrlPointDown",this,{
            "globalPt":this.localToGlobal(new Point(this._currController.x,this._currController.y)),
            "controlName":_loc6_,
            "assetWidth":this._assetWidth,
            "assetHeight":this._assetHeight
         }));
      }
      
      public function get stageScale() : Number
      {
         return this._stageScale;
      }
      
      protected function getSlope(param1:Point, param2:Point) : Number
      {
         return (param1.x - param2.x) / (param1.y - param2.y);
      }
      
      private function redraw(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         this.clearDraw();
         this.drawOutline(param1,param2,param3,param4);
         this.drawControlPoint(param1,param2,param3,param4);
      }
      
      public function get asset() : DisplayObject
      {
         return this._asset;
      }
   }
}

class ControlStuff
{
    
   
   private var _x:Number;
   
   private var _originX:Number;
   
   private var _y:Number;
   
   private var _h:Number;
   
   private var _scaleX:Number;
   
   private var _scaleY:Number;
   
   private var _w:Number;
   
   private var _originY:Number;
   
   function ControlStuff(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number = 1, param6:Number = 1, param7:Number = 0, param8:Number = 0)
   {
      super();
      this._x = param1;
      this._y = param2;
      this._w = param3;
      this._h = param4;
      this._scaleX = param5;
      this._scaleY = param6;
      this._originX = param7;
      this._originY = param8;
   }
   
   public function set x(param1:Number) : void
   {
      this._x = param1;
   }
   
   public function set y(param1:Number) : void
   {
      this._y = this.y;
   }
   
   public function get scaleX() : Number
   {
      return this._scaleX;
   }
   
   public function get scaleY() : Number
   {
      return this._scaleY;
   }
   
   public function set h(param1:Number) : void
   {
      this._h = this.h;
   }
   
   public function set scaleY(param1:Number) : void
   {
      this._scaleY = this.scaleY;
   }
   
   public function set scaleX(param1:Number) : void
   {
      this._scaleX = this.scaleX;
   }
   
   public function set originX(param1:Number) : void
   {
      param1 = this.originX;
   }
   
   public function get h() : Number
   {
      return this._h;
   }
   
   public function get originX() : Number
   {
      return this._originX;
   }
   
   public function set w(param1:Number) : void
   {
      this._w = this.w;
   }
   
   public function get w() : Number
   {
      return this._w;
   }
   
   public function get y() : Number
   {
      return this._y;
   }
   
   public function get originY() : Number
   {
      return this._originY;
   }
   
   public function set originY(param1:Number) : void
   {
      param1 = this.originY;
   }
   
   public function get x() : Number
   {
      return this._x;
   }
}
