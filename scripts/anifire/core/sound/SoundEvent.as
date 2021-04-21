package anifire.core.sound
{
   import anifire.event.ExtraDataEvent;
   
   public class SoundEvent extends ExtraDataEvent
   {
      
      public static const ADDED:String = "added";
      
      public static const PLAY_COMPLETE:String = "play_complete";
      
      public static const UPDATED:String = "updated";
      
      public static const READY_TO_PLAY:String = "ready_to_play";
       
      
      public var sceneId:String;
      
      public function SoundEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
