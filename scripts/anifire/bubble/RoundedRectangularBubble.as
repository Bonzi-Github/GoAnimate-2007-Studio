package anifire.bubble
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class RoundedRectangularBubble extends Bubble
   {
       
      
      private var _radius:Number = 0;
      
      private var _maxCorner:Number = 80;
      
      public function RoundedRectangularBubble()
      {
         super();
         type = BubbleMgr.ROUNDRECTANGULAR;
         this.redraw();
      }
      
      override protected function drawLabel() : void
      {
         var _loc1_:TextField = null;
         if(mver >= 2)
         {
            super.drawLabel();
         }
         if(super.label != null)
         {
            removeChild(super.label);
         }
         _loc1_ = super.returnLabel();
         _loc1_.x = x;
         _loc1_.y = y;
         var _loc2_:Rectangle = GMath.getBubbleBounds(width,height,BubbleMgr.ROUNDRECTANGULAR,null,this._radius);
         _loc1_.x = _loc2_.x + x;
         _loc1_.y = _loc2_.y + y;
         _loc1_.width = _loc2_.width;
         _loc1_.height = _loc2_.height;
         boundHeight = _loc2_.height;
         boundWidth = _loc2_.width;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.leftMargin = this._radius * (1 / 5);
         _loc3_.rightMargin = this._radius * (1 / 5);
         _loc1_.setTextFormat(_loc3_);
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
      
      override protected function drawBody() : void
      {
         if(super.body != null)
         {
            content.removeChild(super.body);
         }
         var _loc1_:Number = Math.min(width / 2,height / 2,this._maxCorner);
         this._radius = _loc1_;
         var _loc2_:Sprite = new Sprite();
         _loc2_.name = "body";
         _loc2_.graphics.beginFill(this.fillRgb,1);
         _loc2_.graphics.drawRoundRect(x,y,width,height,_loc1_,_loc1_);
         _loc2_.graphics.endFill();
         super.body = content.addChild(_loc2_) as Sprite;
      }
      
      override public function redraw() : void
      {
         this.drawTail();
         this.drawBody();
         this.drawLabel();
         drawOutline(content);
      }
      
      override protected function drawTail() : void
      {
         if(super.tail != null)
         {
            content.removeChild(super.tail);
         }
         var _loc1_:Sprite = super.returnTail();
         super.tail = content.addChild(_loc1_) as Sprite;
      }
   }
}
