package anifire.managers
{
   import anifire.util.UtilSite;
   import anifire.util.UtilUser;
   
   public class FeatureManager
   {
       
      
      public function FeatureManager()
      {
         super();
      }
      
      public static function get maxMovieDuration() : Number
      {
         if(UtilUser.userType == UtilUser.BASIC_USER)
         {
            return 120;
         }
         return 60 * 60 * 60;
      }
      
      public static function get shouldPlusActionPackBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
         }
         return true;
      }
      
      public static function get shouldSocialNetworkBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.SCHOOL || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldCcCharacterBeCopyable() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldStopTutorialButtonBeShown() : Boolean
      {
         return true;
      }
      
      public static function get isPremiumStuffVisible() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldActionPackBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return true;
         }
         return false;
      }
      
      public static function get shouldCreateCcButtonBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
         }
         return true;
      }
      
      public static function get shouldSoundSnapBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE || UtilSite.siteId == UtilSite.SCHOOL)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldCommunityStuffBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldTemplateCharacterBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
         }
         return true;
      }
      
      public static function get maxCharacterPerScene() : Number
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return 3;
         }
         return 999;
      }
      
      public static function get shouldTTSCreditBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.SCHOOL || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(UtilUser.userType == UtilUser.BASIC_USER)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function get shouldBubbleUrlBeEditable() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldUpgradeBannerBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.GOANIMATE || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(UtilUser.userType == UtilUser.BASIC_USER)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function get shouldGoPlusTTSVoiceBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
         }
         return true;
      }
      
      public static function get shouldFlickrBeShown() : Boolean
      {
         if(UtilSite.siteId == UtilSite.SCHOOL || UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldThemeColorBeSwitchable() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return false;
         }
         return true;
      }
      
      public static function get shouldAutoSaveBeEnabled() : Boolean
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
         }
         return true;
      }
   }
}
