package anifire.events
{
   import anifire.core.Thumb;
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   
   public class CopyThumbEvent extends ExtraDataEvent
   {
      
      public static const USER_WANT_TO_COPY_THUMB:String = "user_want_to_copy_thumb";
       
      
      public var thumb:Thumb;
      
      public function CopyThumbEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function clone() : Event
      {
         var _loc1_:CopyThumbEvent = new CopyThumbEvent(this.type,this.getEventCreater(),this.getData(),this.bubbles,this.cancelable);
         _loc1_.thumb = this.thumb;
         return _loc1_;
      }
   }
}
