package anifire.core
{
   import anifire.component.CcActionLoader;
   import anifire.util.UtilHashArray;
   
   public class CCLipSyncController
   {
      
      public static var LIPSYNC_LIB_ID:String = "lipsync.swf";
      
      public static var DEMO_LIPSYNC_LIB_ID:String = "demolipsync.swf";
      
      public static var LIPSYNC_FILE:String = "talk_sync.swf";
      
      public static var DEMO_LIPSYNC_FILE:String = "talk.swf";
      
      private static var _instance:CCLipSyncController;
       
      
      public function CCLipSyncController()
      {
         super();
      }
      
      public static function getInstance() : CCLipSyncController
      {
         if(!_instance)
         {
            _instance = new CCLipSyncController();
         }
         return _instance;
      }
      
      public static function getLipSyncComponentItems(param1:XML) : UtilHashArray
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:UtilHashArray = new UtilHashArray();
         _loc3_ = CcActionLoader.getStoreUrl(param1.@theme_id + "/" + param1.@type + "/" + param1.@path + "/" + CCLipSyncController.LIPSYNC_FILE);
         _loc4_ = param1.@theme_id + "." + param1.@type + "." + CCLipSyncController.LIPSYNC_LIB_ID;
         _loc2_.push(_loc3_,_loc4_);
         _loc3_ = CcActionLoader.getStoreUrl(param1.@theme_id + "/" + param1.@type + "/" + param1.@path + "/" + CCLipSyncController.DEMO_LIPSYNC_FILE);
         _loc4_ = param1.@theme_id + "." + param1.@type + "." + CCLipSyncController.DEMO_LIPSYNC_LIB_ID;
         _loc2_.push(_loc3_,_loc4_);
         return _loc2_;
      }
   }
}
