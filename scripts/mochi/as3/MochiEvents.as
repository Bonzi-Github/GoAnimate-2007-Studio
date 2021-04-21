package mochi.as3
{
   import flash.display.MovieClip;
   
   public class MochiEvents
   {
      
      public static const ALIGN_BOTTOM_LEFT:String = "ALIGN_BL";
      
      public static const FORMAT_LONG:String = "LongForm";
      
      public static const ALIGN_BOTTOM:String = "ALIGN_B";
      
      private static var _dispatcher:MochiEventDispatcher = new MochiEventDispatcher();
      
      private static var gameStart:Number;
      
      public static const ACHIEVEMENT_RECEIVED:String = "AchievementReceived";
      
      public static const FORMAT_SHORT:String = "ShortForm";
      
      public static const ALIGN_TOP_RIGHT:String = "ALIGN_TR";
      
      public static const ALIGN_BOTTOM_RIGHT:String = "ALIGN_BR";
      
      public static const ALIGN_TOP:String = "ALIGN_T";
      
      public static const ALIGN_LEFT:String = "ALIGN_L";
      
      public static const ALIGN_RIGHT:String = "ALIGN_R";
      
      public static const ALIGN_TOP_LEFT:String = "ALIGN_TL";
      
      public static const ALIGN_CENTER:String = "ALIGN_C";
      
      private static var levelStart:Number;
       
      
      public function MochiEvents()
      {
         super();
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.addEventListener(param1,param2);
      }
      
      public static function removeEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.removeEventListener(param1,param2);
      }
      
      public static function startSession(param1:String) : void
      {
         MochiServices.send("events_beginSession",{"achievementID":param1},null,null);
      }
      
      public static function triggerEvent(param1:String, param2:Object) : void
      {
         _dispatcher.triggerEvent(param1,param2);
      }
      
      public static function setNotifications(param1:MovieClip, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc3_:Object = {};
         for(_loc4_ in param2)
         {
            _loc3_[_loc4_] = param2[_loc4_];
         }
         _loc3_.clip = param1;
         MochiServices.send("events_setNotifications",_loc3_,null,null);
      }
      
      public static function endGame() : void
      {
         var _loc1_:Number = new Date().time - gameStart;
         trigger("end_game",{"time":_loc1_});
      }
      
      public static function startGame() : void
      {
         gameStart = new Date().time;
         trigger("start_game");
      }
      
      public static function trigger(param1:String, param2:Object = null) : void
      {
         if(param2 == null)
         {
            param2 = {};
         }
         else if(param2["kind"] != undefined)
         {
            trace("WARNING: optional arguments package contains key \'id\', it will be overwritten");
            param2["kind"] = param1;
         }
         MochiServices.send("events_triggerEvent",{"eventObject":param2},null,null);
      }
      
      public static function getVersion() : String
      {
         return MochiServices.getVersion();
      }
      
      public static function startLevel() : void
      {
         levelStart = new Date().time;
         trigger("start_level");
      }
      
      public static function endLevel() : void
      {
         var _loc1_:Number = new Date().time - levelStart;
         trigger("end_level",{"time":_loc1_});
      }
   }
}
