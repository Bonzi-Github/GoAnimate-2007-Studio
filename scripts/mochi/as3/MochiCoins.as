package mochi.as3
{
   public class MochiCoins
   {
      
      public static const STORE_HIDE:String = "StoreHide";
      
      public static const NO_USER:String = "NoUser";
      
      public static const IO_ERROR:String = "IOError";
      
      public static const ITEM_NEW:String = "ItemNew";
      
      public static const ITEM_OWNED:String = "ItemOwned";
      
      public static var _inventory:MochiInventory;
      
      public static const STORE_ITEMS:String = "StoreItems";
      
      public static const ERROR:String = "Error";
      
      public static const STORE_SHOW:String = "StoreShow";
      
      {
         MochiSocial.addEventListener(MochiSocial.LOGGED_IN,function(param1:Object):void
         {
            _inventory = new MochiInventory();
         });
         MochiSocial.addEventListener(MochiSocial.LOGGED_OUT,function(param1:Object):void
         {
            _inventory = null;
         });
      }
      
      public function MochiCoins()
      {
         super();
      }
      
      public static function triggerEvent(param1:String, param2:Object) : void
      {
         MochiSocial.triggerEvent(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         MochiSocial.removeEventListener(param1,param2);
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         MochiSocial.addEventListener(param1,param2);
      }
      
      public static function getStoreItems() : void
      {
         MochiServices.send("coins_getStoreItems");
      }
      
      public static function get inventory() : MochiInventory
      {
         return _inventory;
      }
      
      public static function showStore(param1:Object = null) : void
      {
         MochiServices.bringToTop();
         MochiServices.send("coins_showStore",{"options":param1},null,null);
      }
      
      public static function showItem(param1:Object = null) : void
      {
         if(!param1 || typeof param1.item != "string")
         {
            trace("ERROR: showItem call must pass an Object with an item key");
            return;
         }
         MochiServices.bringToTop();
         MochiServices.send("coins_showItem",{"options":param1},null,null);
      }
      
      public static function getVersion() : String
      {
         return MochiServices.getVersion();
      }
      
      public static function showVideo(param1:Object = null) : void
      {
         if(!param1 || typeof param1.item != "string")
         {
            trace("ERROR: showVideo call must pass an Object with an item key");
            return;
         }
         MochiServices.bringToTop();
         MochiServices.send("coins_showVideo",{"options":param1},null,null);
      }
   }
}
