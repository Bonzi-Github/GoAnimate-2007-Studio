package mx.managers.systemClasses
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class StageEventProxy
   {
       
      
      private var weakRef:Dictionary;
      
      public function StageEventProxy(param1:Function)
      {
         weakRef = new Dictionary(true);
         super();
         this.weakRef[param1] = 1;
      }
      
      public function stageListener(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Function = null;
         if(param1.target is Stage)
         {
            for(_loc2_ in weakRef)
            {
               _loc3_ = _loc2_ as Function;
               _loc3_(param1);
            }
         }
      }
   }
}
