package anifire.components.studio
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class TopButtonBar_iconIdeas extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function TopButtonBar_iconIdeas()
      {
         this.dataClass = TopButtonBar_iconIdeas_dataClass;
         super();
         initialWidth = 360 / 20;
         initialHeight = 240 / 20;
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
