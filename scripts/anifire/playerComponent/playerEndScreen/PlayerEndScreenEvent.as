package anifire.playerComponent.playerEndScreen
{
   import anifire.event.ExtraDataEvent;
   
   public class PlayerEndScreenEvent extends ExtraDataEvent
   {
      
      public static const BTN_NEXTMOVIE_CLICK:String = "btn_nextmovie_click";
      
      public static const BTN_SHARE_CLICK:String = "btn_share_click";
      
      public static const BTN_NEW_ANIMATION_CLICK:String = "btn_new_animation_click";
      
      public static const BTN_REPLAY_CLICK:String = "btn_replay_click";
      
      public static const NOR_SCREEN:String = "nor_screen";
      
      public static const BTN_CHANGE_CLICK:String = "btn_change_click";
       
      
      private var _eventCreator:Object;
      
      public function PlayerEndScreenEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         this._eventCreator = param2;
         super(param1,param2,param3,param4,param5);
      }
      
      public function get eventCreator() : Object
      {
         return this._eventCreator;
      }
   }
}
