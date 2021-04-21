package anifire.events
{
   import flash.events.Event;
   
   public class SceneEvent extends Event
   {
      
      public static const ASSET_REMOVED:String = "ASSET_REMOVED";
      
      public static const ASSET_MOVED:String = "ASSET_MOVED";
      
      public static const ASSET_ADDED:String = "ASSET_ADDED";
      
      public static const DURATION_CHANGE:String = "DURATION_CHANGE";
       
      
      public function SceneEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
