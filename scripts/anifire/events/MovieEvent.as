package anifire.events
{
   import flash.events.Event;
   
   public class MovieEvent extends Event
   {
      
      public static const SCENE_MOVED:String = "SCENE_MOVED";
      
      public static const SCENE_REMOVED:String = "SCENE_REMOVED";
      
      public static const SCENE_ADDED:String = "SCENE_ADDED";
      
      public static const SCENE_SELECTED:String = "SCENE_SELECTED";
       
      
      private var _destIndex:int = -1;
      
      private var _index:int = -1;
      
      private var _sourceIndex:int = -1;
      
      public function MovieEvent(param1:String, param2:int = -1, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._index = param2;
      }
      
      public function set destIndex(param1:int) : void
      {
         this._destIndex = param1;
      }
      
      public function set sourceIndex(param1:int) : void
      {
         this._sourceIndex = param1;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function get sourceIndex() : int
      {
         return this._sourceIndex;
      }
      
      override public function clone() : Event
      {
         return new MovieEvent(type,this._index);
      }
      
      public function get destIndex() : int
      {
         return this._destIndex;
      }
   }
}
