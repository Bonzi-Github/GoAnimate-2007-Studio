package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class ThumbnailCanvas_SmallBuyPointsIcon extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function ThumbnailCanvas_SmallBuyPointsIcon()
      {
         this.dataClass = ThumbnailCanvas_SmallBuyPointsIcon_dataClass;
         super();
         initialWidth = 960 / 20;
         initialHeight = 410 / 20;
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
