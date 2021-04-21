package mochi.as3
{
   public class MochiEventDispatcher
   {
       
      
      private var eventTable:Object;
      
      public function MochiEventDispatcher()
      {
         super();
         this.eventTable = {};
      }
      
      public function triggerEvent(param1:String, param2:Object) : void
      {
         var _loc3_:* = null;
         if(this.eventTable[param1] == undefined)
         {
            return;
         }
         for(_loc3_ in this.eventTable[param1])
         {
            this.eventTable[param1][_loc3_](param2);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         var _loc3_:* = null;
         if(this.eventTable[param1] == undefined)
         {
            this.eventTable[param1] = [];
            return;
         }
         for(_loc3_ in this.eventTable[param1])
         {
            if(this.eventTable[param1][_loc3_] == param2)
            {
               this.eventTable[param1].splice(Number(_loc3_),1);
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         this.removeEventListener(param1,param2);
         this.eventTable[param1].push(param2);
      }
   }
}
