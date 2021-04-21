package anifire.event
{
   public class AVM1SoundEvent extends ExtraDataEvent
   {
      
      public static const SOUND_DURATION_GOT:String = "sound_duration_got";
      
      public static const SOUND_INIT_COMPLETE:String = "sound_init_complete";
      
      public static const SOUND_COMPLETE:String = "sound_complete";
       
      
      public function AVM1SoundEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
