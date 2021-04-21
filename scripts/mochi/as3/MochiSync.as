package mochi.as3
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public dynamic class MochiSync extends Proxy
   {
      
      public static var SYNC_PROPERTY:String = "UpdateProperty";
      
      public static var SYNC_REQUEST:String = "SyncRequest";
       
      
      private var _syncContainer:Object;
      
      public function MochiSync()
      {
         super();
         this._syncContainer = {};
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         if(this._syncContainer[param1] == param2)
         {
            return;
         }
         var _loc3_:String = param1.toString();
         this._syncContainer[_loc3_] = param2;
         MochiServices.send("sync_propUpdate",{
            "name":_loc3_,
            "value":param2
         });
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this._syncContainer[param1];
      }
      
      public function triggerEvent(param1:String, param2:Object) : void
      {
         switch(param1)
         {
            case SYNC_REQUEST:
               MochiServices.send("sync_syncronize",this._syncContainer);
               break;
            case SYNC_PROPERTY:
               this._syncContainer[param2.name] = param2.value;
         }
      }
   }
}
