package anifire.interfaces
{
   import anifire.core.CCManager;
   import flash.events.EventDispatcher;
   
   public interface ICustomCharacterMaker
   {
       
      
      function get eventDispatcher() : EventDispatcher;
      
      function get CCM() : CCManager;
      
      function getColorByName(param1:String) : uint;
   }
}
