package anifire.events
{
   import anifire.event.ExtraDataEvent;
   
   public class MicLevelEvent extends ExtraDataEvent
   {
      
      public static const ACTIVITY_LEVEL:String = "Activity_Level";
       
      
      public var level:Number;
      
      public function MicLevelEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
