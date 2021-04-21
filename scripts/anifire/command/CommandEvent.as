package anifire.command
{
   import flash.events.Event;
   
   public class CommandEvent extends Event
   {
      
      public static const ADDED:String = "added";
       
      
      private var _length:int;
      
      private var _command:String;
      
      public function CommandEvent(param1:String, param2:String, param3:int = 0, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._command = param2;
         this._length = param3;
      }
      
      public function get length() : int
      {
         return this._length;
      }
      
      public function get command() : String
      {
         return this._command;
      }
      
      override public function clone() : Event
      {
         return new CommandEvent(type,this._command,this._length,this.bubbles,this.cancelable);
      }
   }
}
