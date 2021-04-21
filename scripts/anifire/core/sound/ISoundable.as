package anifire.core.sound
{
   import anifire.timeline.SoundContainer;
   import flash.events.IEventDispatcher;
   
   public interface ISoundable extends IEventDispatcher
   {
       
      
      function stop() : void;
      
      function play(param1:Number = 0, param2:SoundContainer = null) : void;
      
      function getIsReadyToPlay() : Boolean;
      
      function getDuration() : Number;
      
      function clone() : ISoundable;
   }
}
