package anifire.components.studio
{
   import anifire.event.ExtraDataEvent;
   import flash.events.Event;
   
   public class EffectTrayEvent extends ExtraDataEvent
   {
      
      public static const EFFECT_OUT:String = "effect_out";
      
      public static const EFFECT_PRESS:String = "effect_press";
      
      public static const EFFECT_OVER:String = "effect_over";
       
      
      private var _id:String;
      
      public function EffectTrayEvent(param1:String, param2:Object, param3:String, param4:Object = null, param5:Boolean = false, param6:Boolean = false)
      {
         this._id = param3;
         super(param1,param2,param4,param5,param6);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      override public function clone() : Event
      {
         return new EffectTrayEvent(this.type,this.getEventCreater(),this.id,this.getData(),this.bubbles,this.cancelable);
      }
   }
}
