package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class SoundTileCell__embed_mxml__________styles_note_music_swf_1053227495 extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function SoundTileCell__embed_mxml__________styles_note_music_swf_1053227495()
      {
         this.dataClass = SoundTileCell__embed_mxml__________styles_note_music_swf_1053227495_dataClass;
         super();
         initialWidth = 326 / 20;
         initialHeight = 400 / 20;
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
