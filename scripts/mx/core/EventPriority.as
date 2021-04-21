package mx.core
{
   use namespace mx_internal;
   
   public final class EventPriority
   {
      
      public static const DEFAULT:int = 0;
      
      public static const BINDING:int = 100;
      
      public static const DEFAULT_HANDLER:int = -50;
      
      public static const EFFECT:int = -100;
      
      public static const CURSOR_MANAGEMENT:int = 200;
      
      mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      public function EventPriority()
      {
         super();
      }
   }
}
