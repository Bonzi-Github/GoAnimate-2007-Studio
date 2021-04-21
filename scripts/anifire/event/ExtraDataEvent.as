package anifire.event
{
   import flash.events.Event;
   
   public class ExtraDataEvent extends Event
   {
      
      public static const UPDATE:String = "update";
       
      
      private var _data:Object;
      
      private var _eventCreater:Object;
      
      public function ExtraDataEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.setData(param3);
         this.setEventCreater(param2);
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function getEventCreater() : Object
      {
         return this._eventCreater;
      }
      
      private function setData(param1:Object) : void
      {
         this._data = param1;
      }
      
      override public function clone() : Event
      {
         return new ExtraDataEvent(this.type,this.getEventCreater(),this.getData(),this.bubbles,this.cancelable);
      }
      
      private function setEventCreater(param1:Object) : void
      {
         this._eventCreater = param1;
      }
   }
}
