package anifire.util
{
   import anifire.event.ExtraDataEvent;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ExtraDataLoader extends Loader
   {
       
      
      public var extraData;
      
      public function ExtraDataLoader()
      {
         super();
      }
      
      override public function dispatchEvent(param1:Event) : Boolean
      {
         var _loc2_:ExtraDataEvent = new ExtraDataEvent(param1.type,new Object(),this.extraData,param1.bubbles,param1.cancelable);
         return super.dispatchEvent(_loc2_);
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.extraData = param1.readObject();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeObject(this.extraData);
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,true);
      }
   }
}
