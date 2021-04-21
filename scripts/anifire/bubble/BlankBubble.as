package anifire.bubble
{
   import anifire.util.UtilDraw;
   import anifire.util.UtilString;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class BlankBubble extends Bubble
   {
       
      
      private var _border:Boolean = false;
      
      public function BlankBubble()
      {
         super();
         tailEnable = false;
         outlineEnable = false;
         type = BubbleMgr.BLANK;
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
      
      override protected function drawTail() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "tail";
         tail = content.addChild(_loc1_) as Sprite;
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
      
      override public function redraw() : void
      {
         this.drawTail();
         this.drawBody();
         this.drawLabel();
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
