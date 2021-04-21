package anifire.components.containers
{
   import flash.utils.ByteArray;
   import mx.core.MovieClipLoaderAsset;
   
   public class AssetPurchaseWindow_BuyBucksIcon extends MovieClipLoaderAsset
   {
      
      private static var bytes:ByteArray = null;
       
      
      public var dataClass:Class;
      
      public function AssetPurchaseWindow_BuyBucksIcon()
      {
         this.dataClass = AssetPurchaseWindow_BuyBucksIcon_dataClass;
         super();
         initialWidth = 2492 / 20;
         initialHeight = 678 / 20;
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
