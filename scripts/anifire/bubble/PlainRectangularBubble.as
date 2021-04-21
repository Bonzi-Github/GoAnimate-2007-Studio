package anifire.bubble
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class PlainRectangularBubble extends Bubble
   {
       
      
      public function PlainRectangularBubble()
      {
         super();
         type = BubbleMgr.RECTANGULAR;
         this.redraw();
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
         _loc1_.graphics.drawRect(x,y,width,height);
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
