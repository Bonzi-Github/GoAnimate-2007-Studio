package anifire.event
{
   import flash.events.Event;
   
   public class SharingEvent extends Event
   {
      
      public static const CLOSE_EVENT:String = "Close";
       
      
      public function SharingEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
