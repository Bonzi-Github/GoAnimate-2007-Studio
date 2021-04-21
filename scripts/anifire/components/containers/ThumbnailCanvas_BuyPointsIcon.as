package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class ThumbnailCanvas_BuyPointsIcon extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function ThumbnailCanvas_BuyPointsIcon()
      {
         this.dataClass = ThumbnailCanvas_BuyPointsIcon_dataClass;
         super();
         initialWidth = 1410 / 20;
         initialHeight = 638 / 20;
      }
      
      override public function get movieClipData() : ByteArray
      {
         if(bytes == null)
         {
            bytes = ByteArray(new this.dataClass());
         }
         return bytes;
      }
   }
}
