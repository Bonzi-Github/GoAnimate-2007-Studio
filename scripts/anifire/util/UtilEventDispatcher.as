package anifire.util
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class UtilEventDispatcher extends EventDispatcher
   {
       
      
      private var _events:UtilHashArray;
      
      public function UtilEventDispatcher(param1:IEventDispatcher = null)
      {
         super(param1);
         this._events = new UtilHashArray();
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0.0, param5:Boolean = false) : void
      {
         var _loc6_:Array = null;
         if(this._events.containsKey(param1))
         {
            (_loc6_ = this._events.getValueByKey(param1)).push(param2);
         }
         else
         {
            (_loc6_ = new Array()).push(param2);
            this._events.push(param1,_loc6_);
         }
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeAllListener(param1:String, param2:Boolean = false) : void
      {
         var listeners:Array = null;
         var i:int = 0;
         var type:String = param1;
         var useCapture:Boolean = param2;
         if(this._events.containsKey(type))
         {
            listeners = this._events.getValueByKey(type);
            i = 0;
            while(i < listeners.length)
            {
               try
               {
                  super.removeEventListener(type,listeners[i],useCapture);
               }
               catch(e:Error)
               {
               }
               i++;
            }
            this._events.remove(this._events.getIndex(type),1);
         }
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(this._events.containsKey(param1))
         {
            _loc5_ = (_loc4_ = this._events.getValueByKey(param1)).length - 1;
            while(_loc5_ >= 0)
            {
               if(_loc4_[_loc5_] == param2)
               {
                  _loc4_.splice(_loc5_,1);
               }
               _loc5_--;
            }
         }
         super.removeEventListener(param1,param2,param3);
      }
   }
}
