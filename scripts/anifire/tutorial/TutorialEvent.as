package anifire.tutorial
{
   import flash.events.Event;
   
   public class TutorialEvent extends Event
   {
      
      public static const CHARACTER_ACTION_CHANGED:String = "CHARACTER_ACTION_CHANGED";
      
      public static const TUTORIAL_DONE:String = "TUTORIAL_DONE";
      
      public static const SCENE_ADDED:String = "SCENE_ADDED";
      
      public static const ACTION_TAB_SELECTED:String = "ACTION_TAB_SELECTED";
      
      public static const CHARACTER_SELECTED:String = "CHARACTER_SELECTED";
      
      public static const SCENE_SELECTED:String = "SCENE_SELECTED";
      
      public static const CHARACTER_TAB_SELECTED:String = "CHARACTER_TAB_SELECTED";
      
      public static const BG_TAB_SELECTED:String = "BG_TAB_SELECTED";
      
      public static const STUDIO_READY:String = "STUDIO_READY";
      
      public static const BG_ADDED:String = "BG_ADDED";
      
      public static const CHARACTER_ADDED:String = "CHARACTER_ADDED";
      
      public static const CHARACTER_FLIPPED:String = "CHARACTER_FLIPPED";
      
      public static const VOICE_TAB_SELECTED:String = "VOICE_TAB_SELECTED";
      
      public static const TTS_ADDED:String = "TTS_ADDED";
      
      public static const PREVIEW_DONE:String = "PREVIEW_DONE";
       
      
      private var _data:Object;
      
      public function TutorialEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._data = param2;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      override public function clone() : Event
      {
         return new TutorialEvent(type,this._data);
      }
   }
}
