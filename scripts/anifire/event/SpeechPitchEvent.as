package anifire.event
{
   import flash.events.Event;
   
   public class SpeechPitchEvent extends Event
   {
      
      public static var PITCH:String = "pitch";
      
      public static var DEMO_START:String = "demo_start";
      
      public static var DEMO_END:String = "demo_end";
       
      
      public var charId:String;
      
      public var sceneId:String;
      
      public var value:Number;
      
      public var soundId:String;
      
      public function SpeechPitchEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
