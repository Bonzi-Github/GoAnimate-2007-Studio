package anifire.control
{
   import anifire.bubble.Bubble;
   import anifire.core.Console;
   import anifire.event.AddedToStage;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BubbleControl extends Control
   {
      
      private static var _instance:BubbleControl;
       
      
      private var addedToStage:AddedToStage;
      
      private var _tailPad:Sprite;
      
      private var _prevx:Number = 0;
      
      private var _prevy:Number = 0;
      
      private var _tailx:Number = 0;
      
      private var _taily:Number = 0;
      
      private var _currTailController:Sprite;
      
      public function BubbleControl()
      {
         super();
         try
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler);
         }
         catch(e:Error)
         {
            addedToStage = new AddedToStage(this);
            addedToStage.addEventListener("AddedToStageEv",onAddedToStageHandler);
         }
      }
      
      public static function getInstance() : BubbleControl
      {
         if(!_instance)
         {
            _instance = new BubbleControl();
         }
         return _instance;
      }
      
      private function drawTailPoint(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         this._tailPad = new Sprite();
         var _loc5_:Sprite;
         (_loc5_ = new controlSymbol() as Sprite).name = "tail";
         _loc5_.scaleX = _loc5_.scaleY = 1 / Console.getConsole().stageScale;
         _loc5_.x = this._tailx - _loc5_.width / 2 - param1;
         _loc5_.y = this._taily - _loc5_.height / 2 - param2;
         this._tailPad.addChild(_loc5_);
         this._tailPad.visible = false;
         addChild(this._tailPad);
      }
      
      private function removeControlListener() : void
      {
         this._tailPad.removeEventListener(MouseEvent.MOUSE_DOWN,this.controlDownHandler);
      }
      
      private function onAddedToStageHandler(param1:Event) : void
      {
         var _loc2_:AddedToStage = null;
         if(param1.target is AddedToStage)
         {
            _loc2_ = param1.target as AddedToStage;
            if(_loc2_ != null && _loc2_.hasEventListener("AddedToStageEv"))
            {
               _loc2_.removeEventListener("AddedToStageEv",this.onAddedToStageHandler);
               _loc2_ = null;
            }
         }
         this.redraw(x,y,this._tailx,this._taily);
      }
      
      private function addControlListener() : void
      {
         this._tailPad.addEventListener(MouseEvent.MOUSE_DOWN,this.controlDownHandler);
      }
      
      override public function setPos(param1:Number, param2:Number) : void
      {
         super.setPos(param1,param2);
         this.setTail(this._tailx + param1,this._taily + param2);
      }
      
      override public function enableResize() : void
      {
         super.enableResize();
         try
         {
            this._tailPad.visible = false;
            this.addControlListener();
         }
         catch(e:Error)
         {
         }
      }
      
      public function get xTailOffset() : Number
      {
         return _relx;
      }
      
      public function get yTailOffset() : Number
      {
         return _rely;
      }
      
      override protected function resetRegisterPoint() : void
      {
         super.resetRegisterPoint();
         this.redraw(x,y,this._tailx,this._taily);
         if(this._tailPad != null)
         {
            this._tailPad.visible = true;
         }
      }
      
      override public function set asset(param1:DisplayObject) : void
      {
         var _loc2_:Bubble = param1 as Bubble;
         setSize(_loc2_.width,_loc2_.height);
         this.setTail(_loc2_.tailx,_loc2_.taily);
         super.asset = param1;
      }
      
      public function setTail(param1:Number, param2:Number) : void
      {
         this._tailx = param1;
         this._taily = param2;
         this.redraw(x,y,param1,param2);
      }
      
      private function controlDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = null;
         this._prevx = (this._currTailController = Sprite(param1.target)).x;
         this._prevy = _loc2_.y;
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.controlMoveHandler);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.controlUpHandler);
         _loc2_.startDrag();
         dispatchEvent(new ControlEvent(ControlEvent.TAIL_MOVE_START));
      }
      
      override public function showControl(param1:Number = 1) : void
      {
         var scale:Number = param1;
         super.showControl(scale);
         try
         {
            this._tailPad.visible = true;
         }
         catch(e:Error)
         {
         }
      }
      
      private function clearDraw() : void
      {
         if(this._tailPad != null)
         {
            removeChild(this._tailPad);
         }
      }
      
      private function controlMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
         _relx = this._currTailController.x - this._prevx;
         _rely = this._currTailController.y - this._prevy;
         this._tailx = this._currTailController.x + x + _offset / 2;
         this._taily = this._currTailController.y + y + _offset / 2;
         dispatchEvent(new ControlEvent(ControlEvent.TAIL_MOVE));
      }
      
      private function redraw(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0) : void
      {
         if(asset != null)
         {
            if(Bubble(asset).isTailEnable())
            {
               this.clearDraw();
               this.drawTailPoint(param1,param2,param3,param4);
               this.addControlListener();
            }
         }
      }
      
      override public function hideControl() : void
      {
         super.hideControl();
         try
         {
            this._tailPad.visible = false;
         }
         catch(e:Error)
         {
         }
      }
      
      override public function disableResize() : void
      {
         super.disableResize();
         try
         {
            this._tailPad.visible = false;
            this.removeControlListener();
         }
         catch(e:Error)
         {
         }
      }
      
      private function controlUpHandler(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         try
         {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.controlMoveHandler);
            this._currTailController.stopDrag();
            _relx = this._currTailController.x - this._prevx;
            _rely = this._currTailController.y - this._prevy;
            dispatchEvent(new ControlEvent(ControlEvent.TAIL_MOVE_COMPLETE));
         }
         catch(e:Error)
         {
         }
      }
   }
}
