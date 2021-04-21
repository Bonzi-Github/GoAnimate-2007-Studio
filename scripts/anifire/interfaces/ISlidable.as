package anifire.interfaces
{
   import anifire.core.MotionData;
   
   public interface ISlidable
   {
       
      
      function set motionData(param1:MotionData) : void;
      
      function get isSliding() : Boolean;
      
      function startSlideMotion() : void;
      
      function get slideEnabled() : Boolean;
      
      function removeSlideMotion() : void;
   }
}
