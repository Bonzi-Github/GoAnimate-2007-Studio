package anifire.components.studio
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class MaskImage__embed_mxml__________styles_body_swf_1523280369 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function MaskImage__embed_mxml__________styles_body_swf_1523280369()
      {
         this.dataClass = MaskImage__embed_mxml__________styles_body_swf_1523280369_dataClass;
         super();
         initialWidth = 1440 / 20;
         initialHeight = 2800 / 20;
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
