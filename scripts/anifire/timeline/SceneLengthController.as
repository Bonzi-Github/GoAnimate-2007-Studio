package anifire.timeline
{
   public class SceneLengthController
   {
      
      public static const ONLY_LENGTHEN:String = "lengthen";
      
      public static const FULL_MANUAL:String = "full_manual";
      
      public static const FULL_AUTO:String = "full_auto";
       
      
      private var _userPreference:String = "full_auto";
      
      private var _timelineControl:Timeline = null;
      
      public function SceneLengthController()
      {
         super();
      }
      
      private function get timelineControl() : Timeline
      {
         return this._timelineControl;
      }
      
      public function get userPreference() : String
      {
         return this._userPreference;
      }
      
      public function doChangeSceneLength(param1:Number, param2:int = -1, param3:Boolean = false) : void
      {
         this.timelineControl.updateSceneLength(param1,param2,param3);
      }
      
      public function setTimelineReferer(param1:Timeline) : void
      {
         this._timelineControl = param1;
      }
      
      public function set userPreference(param1:String) : void
      {
         this._userPreference = param1;
      }
      
      public function doSystemUpdateSceneLength(param1:Number, param2:Number, param3:int, param4:Boolean = false) : void
      {
         var _loc5_:Number = 0;
         if(this.userPreference == FULL_MANUAL)
         {
            return;
         }
         if(param2 > -1)
         {
            _loc5_ = param2;
         }
         else if(this.userPreference == ONLY_LENGTHEN)
         {
            if(param1 > this.timelineControl.getSceneWidthByIndex(param3))
            {
               _loc5_ = param1;
            }
         }
         else
         {
            _loc5_ = param1;
         }
         if(_loc5_)
         {
            this.doChangeSceneLength(_loc5_,param3,param4);
         }
      }
   }
}
