package anifire.effect
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class FireworkEffect extends ProgramEffect
   {
       
      
      private const RGB:Number = 13421772;
      
      private const LINESIZE:Number = 5;
      
      private var _myThumbnailSymbol:Class;
      
      private const ALPHA:Number = 0.6;
      
      public function FireworkEffect()
      {
         this._myThumbnailSymbol = FireworkEffect__myThumbnailSymbol;
         super();
         type = EffectMgr.TYPE_FIREWORK;
         thumbnailSymbol = this._myThumbnailSymbol;
         this.redraw();
      }
      
      override public function serialize() : XML
      {
         return <effect x="{x}" y="{y}" w="{width}" h="{height}" rotate='0' id="{id}" type="{type}">
											 </effect>;
      }
      
      override protected function drawBody() : void
      {
         if(super.body != null)
         {
            content.removeChild(super.body);
         }
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "body";
         super.body = content.addChild(_loc1_) as Sprite;
      }
      
      override public function showEffect(param1:DisplayObject) : void
      {
         var _loc4_:Firework = null;
         var _loc2_:Number = int(Math.random() * 5) + 3;
         var _loc3_:Number = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = new Firework()).init();
            _loc4_.show(_loc3_ * (Math.random() * 500) + 100);
            content.addChild(_loc4_) as Sprite;
            _loc3_++;
         }
      }
      
      override protected function drawLabel() : void
      {
      }
      
      override public function redraw() : void
      {
         this.drawBody();
         this.drawLabel();
      }
   }
}
