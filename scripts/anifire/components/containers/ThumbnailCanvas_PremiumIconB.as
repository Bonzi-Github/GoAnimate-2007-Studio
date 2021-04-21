package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class ThumbnailCanvas_PremiumIconB extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function ThumbnailCanvas_PremiumIconB()
      {
         this.dataClass = ThumbnailCanvas_PremiumIconB_dataClass;
         super();
         initialWidth = 676 / 20;
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
