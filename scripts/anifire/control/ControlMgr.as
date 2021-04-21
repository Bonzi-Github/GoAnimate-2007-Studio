package anifire.control
{
   import flash.display.DisplayObject;
   import mx.logging.ILogger;
   
   public class ControlMgr
   {
      
      public static const SHADOW:String = "SHADOW";
      
      public static const NORMAL:String = "NORMAL";
      
      private static var _name:String = "ControlElement";
      
      public static const FIXED_SHADOW:String = "FIXED_SHADOW";
      
      public static const BUBBLE:String = "BUBBLE";
      
      private static var _logger:ILogger;
      
      public static const FIXED:String = "FIXED";
      
      private static var _control:Control;
       
      
      public function ControlMgr()
      {
         super();
      }
      
      private static function createControl(param1:DisplayObject, param2:String = "NORMAL") : Control
      {
         switch(param2)
         {
            case NORMAL:
               _control = Control.getInstance();
               break;
            case BUBBLE:
               _control = BubbleControl.getInstance();
               break;
            case FIXED:
               _control = FixedControl.getInstance();
               break;
            case FIXED_SHADOW:
               _control = FixedControl.getInstance2();
               break;
            case SHADOW:
               _control = Control.getInstance2();
               break;
            default:
               _control = Control.getInstance();
         }
         _name = "ControlElement_" + param2;
         _control.asset = param1;
         return _control;
      }
      
      public static function get name() : String
      {
         return _name;
      }
      
      public static function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public static function getControl(param1:DisplayObject, param2:String = "NORMAL") : Control
      {
         return createControl(param1,param2);
      }
   }
}
