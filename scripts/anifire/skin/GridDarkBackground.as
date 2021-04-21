package anifire.skin
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import mx.skins.ProgrammaticSkin;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class GridDarkBackground extends ProgrammaticSkin
   {
       
      
      private var backgroundBitmapData:BitmapData;
      
      private var backgroundImage:Bitmap;
      
      public function GridDarkBackground()
      {
         super();
         var _loc1_:CSSStyleDeclaration = StyleManager.getStyleDeclaration(".sceneTimeline");
         var _loc2_:Class = _loc1_.getStyle("bgDark") as Class;
         this.backgroundImage = new _loc2_();
         this.backgroundBitmapData = new BitmapData(this.backgroundImage.width,this.backgroundImage.height);
         this.backgroundBitmapData.draw(this.backgroundImage);
      }
      
      override public function get measuredWidth() : Number
      {
         return 0;
      }
      
      override public function get measuredHeight() : Number
      {
         return 0;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:Graphics = graphics;
         _loc3_.clear();
         _loc3_.beginBitmapFill(this.backgroundBitmapData);
         _loc3_.drawRect(0,0,param1,param2);
         _loc3_.endFill();
      }
   }
}
