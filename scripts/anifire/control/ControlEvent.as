package anifire.control
{
   import flash.events.Event;
   
   public class ControlEvent extends Event
   {
      
      public static const TAIL_MOVE:String = "tailMove";
      
      public static const TAIL_MOVE_START:String = "tailMoveStart";
      
      public static const RESIZE_COMPLETE:String = "resizeComplete";
      
      public static const CALL_LATER:String = "callLater";
      
      public static const RESIZE:String = "resize";
      
      public static const RESIZE_START:String = "resizeStart";
      
      public static const TAIL_MOVE_COMPLETE:String = "tailMoveComplete";
      
      public static const ROTATE:String = "rotate";
      
      public static const OUTLINE_DOWN:String = "outlineDown";
       
      
      public function ControlEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
