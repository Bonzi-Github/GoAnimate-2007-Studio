package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class ThumbnailCanvas_PremiumIcon extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function ThumbnailCanvas_PremiumIcon()
      {
         this.dataClass = ThumbnailCanvas_PremiumIcon_dataClass;
         super();
         initialWidth = 680 / 20;
         initialHeight = 680 / 20;
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
