package anifire.events
{
   import flash.events.Event;
   
   public class PropertyWindowEvent extends Event
   {
      
      public static const VIEW_PROPERTY_WINDOW:String = "propwin";
      
      public static const EVENT_CLOSE:String = "propwinClose";
      
      public static const VIEW_THUMB:String = "thumb";
      
      public static const EVENT_OPEN:String = "propwinOpen";
       
      
      private var _view:String = "thumb";
      
      public function PropertyWindowEvent(param1:String)
      {
         super(param1);
      }
      
      public static function isCloseEvent(param1:Event) : Boolean
      {
         return param1.type === EVENT_CLOSE;
      }
      
      public static function isOpenEvent(param1:Event) : Boolean
      {
         return param1.type === EVENT_OPEN;
      }
      
      public function set view(param1:String) : void
      {
         if(([VIEW_THUMB,VIEW_PROPERTY_WINDOW] as Array).indexOf(param1) >= 0)
         {
            this._view = param1;
         }
      }
      
      public function get view() : String
      {
         return this._view;
      }
   }
}
