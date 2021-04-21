package anifire.timeline
{
   import flash.events.Event;
   
   public class TimelineEvent extends Event
   {
      
      public static const SOUND_RESIZE:String = "soundResize";
      
      public static const CONTROL_LEFT_MOVE:String = "controlLeftMove";
      
      public static const SCENE_MOUSE_UP:String = "sceneMouseUp";
      
      public static const SCENE_MOUSE_DOWN:String = "sceneMouseDown";
      
      public static const SCENE_RESIZE_COMPLETE:String = "sceneResizeComplete";
      
      public static const SOUND_RESIZE_START:String = "soundResizeStart";
      
      public static const SOUND_CLICK:String = "soundClick";
      
      public static const SOUND_RESIZE_COMPLETE:String = "soundResizeComplete";
      
      public static const PREV_CLICK:String = "prevClick";
      
      public static const SOUND_MOVE:String = "soundMove";
      
      public static const NEXT_CLICK:String = "nextClick";
      
      public static const SOUND_MOUSE_UP:String = "soundMouseUp";
      
      public static const SCENE_RESIZE:String = "sceneResize";
      
      public static const SCENE_RESIZE_START:String = "sceneResizeStart";
      
      public static const SOUND_MOUSE_DOWN:String = "soundMouseDown";
      
      public static const CONTROL_RIGHT_MOVE:String = "controlRightMove";
      
      public static const SOUND_REMOVED:String = "soundRemoved";
       
      
      private var _soundContainer:SoundContainer;
      
      private var _index:int;
      
      private var _id:String;
      
      public function TimelineEvent(param1:String, param2:Number = -1, param3:String = null, param4:SoundContainer = null, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this._index = param2;
         this._id = param3;
         this.soundContainer = param4;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
      
      public function set soundContainer(param1:SoundContainer) : void
      {
         this._soundContainer = param1;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get soundContainer() : SoundContainer
      {
         return this._soundContainer;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      override public function clone() : Event
      {
         return new TimelineEvent(type,this._index,this._id,this.soundContainer,this.bubbles,this.cancelable);
      }
   }
}
