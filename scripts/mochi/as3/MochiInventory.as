package mochi.as3
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Proxy;
   import flash.utils.Timer;
   import flash.utils.flash_proxy;
   
   public dynamic class MochiInventory extends Proxy
   {
      
      public static const READY:String = "InvReady";
      
      public static const ERROR:String = "Error";
      
      private static var _dispatcher:MochiEventDispatcher = new MochiEventDispatcher();
      
      public static const IO_ERROR:String = "IoError";
      
      private static const KEY_SALT:String = " syncMaint\x01";
      
      public static const WRITTEN:String = "InvWritten";
      
      public static const NOT_READY:String = "InvNotReady";
      
      public static const VALUE_ERROR:String = "InvValueError";
      
      private static const CONSUMER_KEY:String = "MochiConsumables";
       
      
      private var _timer:Timer;
      
      private var _names:Array;
      
      private var _syncID:Number;
      
      private var _consumableProperties:Object;
      
      private var _storeSync:Object;
      
      private var _outstandingID:Number;
      
      private var _syncPending:Boolean;
      
      public function MochiInventory()
      {
         super();
         MochiCoins.addEventListener(MochiCoins.ITEM_OWNED,this.itemOwned);
         MochiCoins.addEventListener(MochiCoins.ITEM_NEW,this.newItems);
         MochiSocial.addEventListener(MochiSocial.LOGGED_IN,this.loggedIn);
         MochiSocial.addEventListener(MochiSocial.LOGGED_OUT,this.loggedOut);
         this._storeSync = new Object();
         this._syncPending = false;
         this._outstandingID = 0;
         this._syncID = 0;
         this._timer = new Timer(1000);
         this._timer.addEventListener(TimerEvent.TIMER,this.sync);
         this._timer.start();
         if(MochiSocial.loggedIn)
         {
            this.loggedIn();
         }
         else
         {
            this.loggedOut();
         }
      }
      
      public static function triggerEvent(param1:String, param2:Object) : void
      {
         _dispatcher.triggerEvent(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.removeEventListener(param1,param2);
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.addEventListener(param1,param2);
      }
      
      private function newItems(param1:Object) : void
      {
         if(!this[param1.id + KEY_SALT])
         {
            this[param1.id + KEY_SALT] = 0;
         }
         if(!this[param1.id])
         {
            this[param1.id] = 0;
         }
         this[param1.id + KEY_SALT] = this[param1.id + KEY_SALT] + param1.count;
         this[param1.id] = this[param1.id] + param1.count;
         if(param1.privateProperties.consumable)
         {
            if(!this[param1.privateProperties.tag])
            {
               this[param1.privateProperties.tag] = 0;
            }
            this[param1.privateProperties.tag] = this[param1.privateProperties.tag] + param1.privateProperties.inc * param1.count;
         }
      }
      
      public function release() : void
      {
         MochiCoins.removeEventListener(MochiCoins.ITEM_NEW,this.newItems);
         MochiSocial.removeEventListener(MochiSocial.LOGGED_IN,this.loggedIn);
         MochiSocial.removeEventListener(MochiSocial.LOGGED_OUT,this.loggedOut);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         if(this._consumableProperties == null)
         {
            triggerEvent(ERROR,{"type":NOT_READY});
            return -1;
         }
         if(this._consumableProperties[param1])
         {
            return MochiDigits(this._consumableProperties[param1]).value;
         }
         return undefined;
      }
      
      private function loggedIn(param1:Object = null) : void
      {
         MochiUserData.get(CONSUMER_KEY,this.getConsumableBag);
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         if(this._consumableProperties == null)
         {
            triggerEvent(ERROR,{"type":NOT_READY});
            return false;
         }
         if(this._consumableProperties[param1] == undefined)
         {
            return false;
         }
         return true;
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 >= this._names.length?0:int(param1 + 1);
      }
      
      private function putConsumableBag(param1:MochiUserData) : void
      {
         this._syncPending = false;
         if(param1.error)
         {
            triggerEvent(ERROR,{
               "type":IO_ERROR,
               "error":param1.error
            });
            this._outstandingID = -1;
         }
         triggerEvent(WRITTEN,{});
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:MochiDigits = null;
         if(this._consumableProperties == null)
         {
            triggerEvent(ERROR,{"type":NOT_READY});
            return;
         }
         if(!(param2 is Number))
         {
            triggerEvent(ERROR,{
               "type":VALUE_ERROR,
               "error":"Invalid type",
               "arg":param2
            });
            return;
         }
         if(this._consumableProperties[param1])
         {
            _loc3_ = MochiDigits(this._consumableProperties[param1]);
            if(_loc3_.value == param2)
            {
               return;
            }
            _loc3_.value = param2;
         }
         else
         {
            this._names.push(param1);
            this._consumableProperties[param1] = new MochiDigits(param2);
         }
         ++this._syncID;
      }
      
      private function itemOwned(param1:Object) : void
      {
         this._storeSync[param1.id] = {
            "properties":param1.properties,
            "count":param1.count
         };
      }
      
      private function sync(param1:Event = null) : void
      {
         var _loc3_:* = null;
         if(this._syncPending || this._syncID == this._outstandingID)
         {
            return;
         }
         this._outstandingID = this._syncID;
         var _loc2_:Object = {};
         for(_loc3_ in this._consumableProperties)
         {
            _loc2_[_loc3_] = MochiDigits(this._consumableProperties[_loc3_]).value;
         }
         MochiUserData.put(CONSUMER_KEY,_loc2_,this.putConsumableBag);
         this._syncPending = true;
      }
      
      override flash_proxy function nextName(param1:int) : String
      {
         return this._names[param1 - 1];
      }
      
      override flash_proxy function deleteProperty(param1:*) : Boolean
      {
         if(!this._consumableProperties[param1])
         {
            return false;
         }
         this._names.splice(this._names.indexOf(param1),1);
         delete this._consumableProperties[param1];
         return true;
      }
      
      private function getConsumableBag(param1:MochiUserData) : void
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         if(param1.error)
         {
            triggerEvent(ERROR,{
               "type":IO_ERROR,
               "error":param1.error
            });
            return;
         }
         this._consumableProperties = {};
         this._names = new Array();
         if(param1.data)
         {
            for(_loc2_ in param1.data)
            {
               this._names.push(_loc2_);
               this._consumableProperties[_loc2_] = new MochiDigits(param1.data[_loc2_]);
            }
         }
         for(_loc2_ in this._storeSync)
         {
            _loc3_ = this._storeSync[_loc2_].count;
            if(this._consumableProperties[_loc2_ + KEY_SALT])
            {
               _loc3_ = _loc3_ - this._consumableProperties[_loc2_];
            }
            if(_loc3_ != 0)
            {
               this.newItems({
                  "id":_loc2_,
                  "count":_loc3_,
                  "properties":this._storeSync[_loc2_].properties
               });
            }
         }
         triggerEvent(READY,{});
      }
      
      private function loggedOut(param1:Object = null) : void
      {
         this._consumableProperties = null;
      }
   }
}
