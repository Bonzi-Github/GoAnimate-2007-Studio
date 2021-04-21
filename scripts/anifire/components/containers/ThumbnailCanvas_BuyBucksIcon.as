package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class ThumbnailCanvas_BuyBucksIcon extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function ThumbnailCanvas_BuyBucksIcon()
      {
         this.dataClass = ThumbnailCanvas_BuyBucksIcon_dataClass;
         super();
         initialWidth = 1658 / 20;
         initialHeight = 668 / 20;
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
