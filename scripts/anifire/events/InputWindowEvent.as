package anifire.events
{
   import flash.events.Event;
   
   public class InputWindowEvent extends Event
   {
      
      public static const INPUT_SUBMIT:String = "inputSubmit";
       
      
      public var dataObject:Object;
      
      public var inputValue:Object;
      
      public function InputWindowEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
