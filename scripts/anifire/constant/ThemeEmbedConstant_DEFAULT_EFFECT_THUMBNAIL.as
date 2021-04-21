package anifire.constant
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class ThemeEmbedConstant_DEFAULT_EFFECT_THUMBNAIL extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function ThemeEmbedConstant_DEFAULT_EFFECT_THUMBNAIL()
      {
         this.dataClass = ThemeEmbedConstant_DEFAULT_EFFECT_THUMBNAIL_dataClass;
         super();
         initialWidth = 1000 / 20;
         initialHeight = 1000 / 20;
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
