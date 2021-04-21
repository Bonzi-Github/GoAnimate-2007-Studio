package com.google.analytics.debug
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Panel extends UISprite
   {
       
      
      private var _savedH:uint;
      
      private var _data:UISprite;
      
      private var _mask:Sprite;
      
      private var _background:Shape;
      
      private var _savedW:uint;
      
      private var _stickToEdge:Boolean;
      
      private var _border:Shape;
      
      private var _borderColor:uint;
      
      protected var baseAlpha:Number;
      
      private var _backgroundColor:uint;
      
      private var _title:Label;
      
      private var _colapsed:Boolean;
      
      private var _name:String;
      
      public function Panel(param1:String, param2:uint, param3:uint, param4:uint = 0, param5:uint = 0, param6:Number = 0.3, param7:Align = null, param8:Boolean = false)
      {
         super();
         _name = param1;
         this.name = param1;
         _colapsed = false;
         forcedWidth = param2;
         forcedHeight = param3;
         this.baseAlpha = param6;
         _background = new Shape();
         _data = new UISprite();
         _data.forcedWidth = param2;
         _data.forcedHeight = param3;
         _title = new Label(param1,"uiLabel",16777215,Align.topLeft,param8);
         _title.buttonMode = true;
         _title.margin.top = 0.6;
         _title.margin.left = 0.6;
         _title.addEventListener(MouseEvent.CLICK,onToggle);
         _title.mouseChildren = false;
         _border = new Shape();
         _mask = new Sprite();
         _mask.useHandCursor = false;
         _mask.mouseEnabled = false;
         if(param7 == null)
         {
            param7 = Align.none;
         }
         this.alignement = param7;
         this.stickToEdge = param8;
         if(param4 == 0)
         {
            param4 = Style.backgroundColor;
         }
         _backgroundColor = param4;
         if(param5 == 0)
         {
            param5 = Style.borderColor;
         }
         _borderColor = param5;
      }
      
      public function get stickToEdge() : Boolean
      {
         return _stickToEdge;
      }
      
      public function onToggle(param1:MouseEvent = null) : void
      {
         if(_colapsed)
         {
            _data.visible = true;
         }
         else
         {
            _data.visible = false;
         }
         _colapsed = !_colapsed;
         _update();
         resize();
      }
      
      public function set stickToEdge(param1:Boolean) : void
      {
         _stickToEdge = param1;
         _title.stickToEdge = param1;
      }
      
      override protected function dispose() : void
      {
         _title.removeEventListener(MouseEvent.CLICK,onToggle);
         super.dispose();
      }
      
      private function _draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         if(_savedW && _savedH)
         {
            forcedWidth = _savedW;
            forcedHeight = _savedH;
         }
         if(!_colapsed)
         {
            _loc1_ = forcedWidth;
            _loc2_ = forcedHeight;
         }
         else
         {
            _loc1_ = _title.width;
            _loc2_ = _title.height;
            _savedW = forcedWidth;
            _savedH = forcedHeight;
            forcedWidth = _loc1_;
            forcedHeight = _loc2_;
         }
         var _loc3_:Graphics = _background.graphics;
         _loc3_.clear();
         _loc3_.beginFill(_backgroundColor);
         Background.drawRounded(this,_loc3_,_loc1_,_loc2_);
         _loc3_.endFill();
         var _loc4_:Graphics;
         (_loc4_ = _data.graphics).clear();
         _loc4_.beginFill(_backgroundColor,0);
         Background.drawRounded(this,_loc4_,_loc1_,_loc2_);
         _loc4_.endFill();
         var _loc5_:Graphics;
         (_loc5_ = _border.graphics).clear();
         _loc5_.lineStyle(0.1,_borderColor);
         Background.drawRounded(this,_loc5_,_loc1_,_loc2_);
         _loc5_.endFill();
         var _loc6_:Graphics;
         (_loc6_ = _mask.graphics).clear();
         _loc6_.beginFill(_backgroundColor);
         Background.drawRounded(this,_loc6_,_loc1_ + 1,_loc2_ + 1);
         _loc6_.endFill();
      }
      
      public function get title() : String
      {
         return _title.text;
      }
      
      private function _update() : void
      {
         _draw();
         if(baseAlpha < 1)
         {
            _background.alpha = baseAlpha;
            _border.alpha = baseAlpha;
         }
      }
      
      public function addData(param1:DisplayObject) : void
      {
         _data.addChild(param1);
      }
      
      override protected function layout() : void
      {
         _update();
         addChild(_background);
         addChild(_data);
         addChild(_title);
         addChild(_border);
         addChild(_mask);
         mask = _mask;
      }
      
      public function set title(param1:String) : void
      {
         _title.text = param1;
      }
      
      public function close() : void
      {
         dispose();
         if(parent != null)
         {
            parent.removeChild(this);
         }
      }
   }
}
