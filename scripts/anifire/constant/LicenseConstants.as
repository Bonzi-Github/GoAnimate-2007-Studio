package anifire.constant
{
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class LicenseConstants
   {
      
      public static const PUBLISH_SHARING_MUST_ON:Number = 2;
      
      public static var THUMBNAIL_HINT_API_SERVERS:Array = ["staging.goanimate.org","bernard.goanimate.org","bernardcn.goanimate.org","alvin.goanimate.org","alvincn.goanimate.org"];
      
      public static const PUBLISH_PRIVATE_OFF_ONLY:Number = 4;
      
      private static var _specialModes:Object = {};
      
      public static const PUBLISH_PRIVATE_ONLY:Number = 1;
      
      public static const PUBLISH_PRIVATE_ON_ONLY:Number = 5;
      
      public static const PUBLISH_PUBLIC_ONLY:Number = 6;
      
      public static const PUBLISH_ALL:Number = 0;
      
      public static var TEST_API_SERVERS:Array = ["alvin.goanimate.org","alvincn.goanimate.org"];
       
      
      public function LicenseConstants()
      {
         super();
      }
      
      public static function get DONT_SHOW_COMMON_BG_THEME_IDS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("ben10");
         _loc1_.push("chowder");
         _loc1_.push("toonadv");
         return _loc1_;
      }
      
      public static function get PUBLISH_LEVEL() : UtilHashArray
      {
         var _loc1_:UtilHashArray = new UtilHashArray();
         _loc1_.push("8",PUBLISH_SHARING_MUST_ON);
         return _loc1_;
      }
      
      public static function get DONT_SHOW_HEADGEAR_SECTION_IN_THUMBTRAY_LICENSE_ID() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("10");
         return _loc1_;
      }
      
      public static function isThumbnailTestHost() : Boolean
      {
         return isHostMatch(THUMBNAIL_HINT_API_SERVERS,"thumb");
      }
      
      public static function get SHOULD_SHOW_EFFECT_CHANGED_TIP() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("0");
         _loc1_.push("1");
         _loc1_.push("2");
         _loc1_.push("3");
         _loc1_.push("4");
         _loc1_.push("5");
         _loc1_.push("6");
         _loc1_.push("9");
         _loc1_.push("10");
         return _loc1_;
      }
      
      public static function get BAN_SOUND_UPLOAD_LICENSE_IDS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("3");
         _loc1_.push("5");
         return _loc1_;
      }
      
      public static function get DONT_SHOW_COMMON_PROP_THEME_IDS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("ben10");
         _loc1_.push("chowder");
         _loc1_.push("custom");
         _loc1_.push("toonadv");
         return _loc1_;
      }
      
      public static function get SHOULD_USE_EXTERNAL_PREVIEW_PLAYER() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("0");
         _loc1_.push("1");
         _loc1_.push("2");
         _loc1_.push("3");
         _loc1_.push("4");
         _loc1_.push("5");
         _loc1_.push("6");
         _loc1_.push("9");
         return _loc1_;
      }
      
      public static function get DONT_SHOW_HEADGEAR_SECTION_IN_THUMBTRAY_THEME_ID() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("0pBZ9UF7FrRU");
         return _loc1_;
      }
      
      public static function isTestHost() : Boolean
      {
         return isHostMatch(TEST_API_SERVERS,"default");
      }
      
      public static function visitStudioByTheme(param1:String) : void
      {
         var _loc2_:String = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_SITE_ID) as String;
         var _loc3_:String = "";
         var _loc4_:String = "_top";
         if(_loc2_ != "go")
         {
            _loc3_ = ServerConstants.STUDIO_PAGE_PATH;
         }
         else
         {
            _loc3_ = ServerConstants.STUDIO_FULLSCREEN_PAGE_PATH;
            _loc4_ = "wndstudio";
         }
         _loc3_ = _loc3_ + ("theme/" + param1);
         navigateToURL(new URLRequest(_loc3_),_loc4_);
      }
      
      private static function isHostMatch(param1:Array, param2:String) : Boolean
      {
         var apiserver:String = null;
         var list:Array = param1;
         var cat:String = param2;
         if(int(_specialModes[cat]) != 0)
         {
            return int(_specialModes[cat]) > 0;
         }
         var permittedHosts:Array = list;
         apiserver = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_APISERVER);
         var result:Boolean = permittedHosts.some(function(param1:*, param2:int, param3:Array):Boolean
         {
            return apiserver.indexOf(param1 as String) >= 0;
         });
         _specialModes[cat] = !!result?1:-1;
         return result;
      }
      
      public static function get DONT_SHOW_HEAD_SECTION_IN_THUMBTRAY() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("7");
         _loc1_.push("8");
         _loc1_.push("10");
         return _loc1_;
      }
      
      public static function get DONT_SHOW_COMMON_SOUND_THEME_IDS() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("akon");
         _loc1_.push("sf");
         _loc1_.push("underdog");
         _loc1_.push("willie");
         return _loc1_;
      }
      
      public static function get DONT_ALLOW_TAKING_SCREENSHOT() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("8");
         return _loc1_;
      }
   }
}
