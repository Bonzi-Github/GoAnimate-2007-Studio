package anifire.util
{
   import anifire.constant.ServerConstants;
   import anifire.popups.GoPopUp;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import mx.core.Application;
   import mx.core.IFlexDisplayObject;
   import mx.managers.PopUpManager;
   
   public class UtilNavigate
   {
      
      private static var _themeId:String;
       
      
      public function UtilNavigate()
      {
         super();
      }
      
      public static function toUpgradePage() : void
      {
         var _loc1_:String = ServerConstants.ACTION_GOPLUS_SIGNUP;
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            _loc1_ = ServerConstants.ACTION_SCHOOLPLUS_SIGNUP;
         }
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("popUpgrade");
               UtilUser.showUpdatePopUp();
            }
         }
         else
         {
            navigateToURL(new URLRequest(_loc1_),ServerConstants.POPUP_WINDOW_NAME);
         }
      }
      
      public static function toBuyBuckPage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("popBuyBucks");
               UtilUser.showUpdatePopUp();
            }
         }
         else
         {
            navigateToURL(new URLRequest(ServerConstants.ACTION_BUY_BUCKS),ServerConstants.POPUP_WINDOW_NAME);
         }
      }
      
      public static function toCreateCc(param1:String) : void
      {
         var _loc2_:IFlexDisplayObject = null;
         if(UtilSite.siteId == UtilSite.GOANIMATE)
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("showCCBrowser");
            }
         }
         else
         {
            _themeId = param1;
            _loc2_ = PopUpManager.createPopUp(Application.application as DisplayObject,GoPopUp,true);
            GoPopUp(_loc2_).text = UtilDict.toDisplay("go","goalert_createMyChar");
            GoPopUp(_loc2_).addEventListener("okClick",onCreateCc);
            PopUpManager.centerPopUp(_loc2_);
            _loc2_.y = 100;
            _loc2_.width = 400;
         }
      }
      
      public static function toFaqdPage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqd"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqd"),ServerConstants.POPUP_WINDOW_NAME);
         }
      }
      
      private static function onCreateCc(param1:Event) : void
      {
         var _loc2_:String = null;
         if(_themeId)
         {
            _loc2_ = ServerConstants.CC_PAGE_PATH;
            _loc2_ = _loc2_ + ("/" + _themeId);
            if(UtilSite.siteId == UtilSite.YOUTUBE)
            {
               navigateToURL(new URLRequest(_loc2_),"_self");
            }
            else
            {
               navigateToURL(new URLRequest(_loc2_),ServerConstants.POPUP_WINDOW_NAME);
            }
         }
      }
      
      public static function toFaqcPage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqc"),"_blank");
         }
         else
         {
            navigateToURL(new URLRequest("http://goanimate.com/go/faq#faqc"),ServerConstants.POPUP_WINDOW_NAME);
         }
      }
      
      public static function toTribeOfNoisePage() : void
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            navigateToURL(new URLRequest("http://www.tribeofnoise.com"),ServerConstants.POPUP_WINDOW_NAME);
         }
         else
         {
            navigateToURL(new URLRequest("http://www.tribeofnoise.com"),"_blank");
         }
      }
   }
}
