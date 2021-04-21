package anifire.bubble
{
   import anifire.util.UtilDraw;
   import anifire.util.UtilString;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class BlankTailBubble extends Bubble
   {
       
      
      private var _border:Boolean = false;
      
      public function BlankTailBubble()
      {
         super();
         tailEnable = true;
         outlineEnable = false;
         type = BubbleMgr.BLANKTAIL;
         this.redraw();
      }
      
      override protected function returnTail() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "tail";
         var _loc2_:Number = x + width / 2;
         var _loc3_:Number = y + height / 2;
         var _loc4_:Point = new Point(_loc2_,_loc3_);
         var _loc5_:Number;
         var _loc6_:Number = (_loc5_ = Math.min(this.height,this.width)) / 4;
         var _loc7_:Point = new Point(tailx,taily);
         var _loc8_:Circle = new Circle(_loc2_,_loc3_,_loc6_);
         var _loc9_:Point = new Point();
         var _loc10_:Point = new Point();
         var _loc11_:Rectangle = new Rectangle(x,y,width,height);
         if(taily < y)
         {
            _loc9_.x = _loc2_;
            _loc9_.y = _loc3_ - height / 2;
            _loc10_ = new Point(_loc9_.x,taily);
         }
         else if(taily > y + height)
         {
            _loc9_.x = _loc2_;
            _loc9_.y = _loc3_ + height / 2;
            _loc10_ = new Point(_loc9_.x,taily);
         }
         else
         {
            _loc9_.y = _loc3_;
            if(tailx < _loc2_)
            {
               _loc9_.x = _loc2_ - width / 2;
            }
            else
            {
               _loc9_.x = _loc2_ + width / 2;
            }
            _loc10_ = new Point(tailx,_loc9_.y);
         }
         _loc1_.graphics.lineStyle(4,this.fillRgb);
         _loc1_.graphics.moveTo(_loc9_.x,_loc9_.y);
         _loc1_.graphics.curveTo(_loc10_.x,_loc10_.y,tailx,taily);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      override protected function drawTail() : void
      {
         if(super.tail != null)
         {
            content.removeChild(super.tail);
         }
         var _loc1_:Sprite = this.returnTail();
         super.tail = content.addChild(_loc1_) as Sprite;
      }
      
      override protected function drawBody() : void
      {
         if(super.body != null)
         {
            content.removeChild(super.body);
         }
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "body";
         if(UtilString.trim(text," ") == "")
         {
            this._border = true;
         }
         else
         {
            this._border = false;
         }
         if(this._border)
         {
            _loc1_.graphics.lineStyle(0,this.lineRgb);
            _loc1_.graphics.beginFill(16777215,0);
            UtilDraw.drawDashRect(_loc1_,x,y,width,height,3,3);
            _loc1_.graphics.endFill();
         }
         super.body = content.addChild(_loc1_) as Sprite;
      }
      
      override protected function drawLabel() : void
      {
         if(mver >= 2)
         {
            super.drawLabel();
         }
         if(super.label != null)
         {
            removeChild(super.label);
         }
         var _loc1_:TextField = super.returnLabel();
         _loc1_.x = x;
         _loc1_.y = y;
         _loc1_.addEventListener(Event.CHANGE,this.iTextChangeHandler);
         boundHeight = height;
         boundWidth = width;
         super.label = addChild(_loc1_) as TextField;
         if(mver >= 2)
         {
            updateVerticalAlign();
         }
         else
         {
            super.drawLabel();
         }
      }
      
      private function iTextChangeHandler(param1:Event) : void
      {
         var _loc2_:String = param1.currentTarget.text;
         if(UtilString.trim(_loc2_," ") == "")
         {
            this._border = true;
            body.graphics.lineStyle(0,this.lineRgb);
            UtilDraw.drawDashRect(body,x,y,width,height,3,3);
         }
         else
         {
            this._border = false;
            body.graphics.clear();
         }
      }
      
      override public function redraw() : void
      {
         this.drawTail();
         this.drawBody();
         this.drawLabel();
      }
      
      override public function getSize() : Rectangle
      {
         var _loc1_:Rectangle = new Rectangle();
         _loc1_.x = x;
         _loc1_.y = y;
         _loc1_.width = width;
         _loc1_.height = height;
         return _loc1_;
      }
   }
}
