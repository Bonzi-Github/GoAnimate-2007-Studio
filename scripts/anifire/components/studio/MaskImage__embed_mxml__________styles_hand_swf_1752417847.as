package anifire.components.studio
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class MaskImage__embed_mxml__________styles_hand_swf_1752417847 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function MaskImage__embed_mxml__________styles_hand_swf_1752417847()
      {
         this.dataClass = MaskImage__embed_mxml__________styles_hand_swf_1752417847_dataClass;
         super();
         initialWidth = 740 / 20;
         initialHeight = 660 / 20;
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
