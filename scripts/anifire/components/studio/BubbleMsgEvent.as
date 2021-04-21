package anifire.components.studio
{
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   
   public class BubbleMsgEvent extends ExtraDataEvent
   {
      
      public static const ITEM_CHOOSEN:String = "item_choosen";
       
      
      public var bubbleMsgItem:BubbleMsgChooserItem;
      
      public function BubbleMsgEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function clone() : Event
      {
         var _loc1_:BubbleMsgEvent = new BubbleMsgEvent(this.type,this.getEventCreater(),this.getData(),this.bubbles,this.cancelable);
         _loc1_.bubbleMsgItem = this.bubbleMsgItem;
         return _loc1_;
      }
   }
}
