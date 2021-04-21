package anifire.bubble
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class EllipseBubble extends Bubble
   {
       
      
      public function EllipseBubble()
      {
         super();
         type = BubbleMgr.ELLIPSE;
         this.redraw();
      }
      
      override protected function drawLabel() : void
      {
         var _loc1_:TextField = null;
         var _loc2_:Rectangle = null;
         if(mver >= 2)
         {
            super.drawLabel();
         }
         if(super.label != null)
         {
            removeChild(super.label);
         }
         _loc1_ = super.returnLabel();
         trace("get bound:" + [width,height]);
         _loc2_ = GMath.getBubbleBounds(width,height,type);
         _loc1_.x = _loc2_.x + x;
         _loc1_.y = _loc2_.y + y;
         _loc1_.width = _loc2_.width;
         _loc1_.height = _loc2_.height;
         boundHeight = _loc2_.height - _loc2_.y;
         boundWidth = _loc2_.width;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.leftMargin = 0;
         _loc3_.rightMargin = 0;
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
      
      override protected function drawTail() : void
      {
         if(super.tail != null)
         {
            content.removeChild(super.tail);
         }
         var _loc1_:Sprite = super.returnTail();
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
         _loc1_.graphics.beginFill(this.fillRgb,1);
         _loc1_.graphics.drawEllipse(x,y,width,height);
         _loc1_.graphics.endFill();
         super.body = content.addChild(_loc1_) as Sprite;
      }
      
      override public function redraw() : void
      {
         this.drawTail();
         this.drawBody();
         this.drawLabel();
         drawOutline(content);
      }
   }
}
