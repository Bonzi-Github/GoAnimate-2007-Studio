package anifire.util
{
   import anifire.popups.GoUpgrade;
   import anifire.popups.SchoolUpgrade;
   import anifire.popups.YouTubeUpgrade;
   import flash.display.DisplayObject;
   import mx.core.Application;
   import mx.core.IFlexDisplayObject;
   import mx.managers.PopUpManager;
   
   public class UtilPopUp
   {
       
      
      public function UtilPopUp()
      {
         super();
      }
      
      public static function upgrade() : IFlexDisplayObject
      {
         if(UtilSite.siteId == UtilSite.YOUTUBE)
         {
            return PopUpManager.createPopUp(Application.application as DisplayObject,YouTubeUpgrade,true);
         }
         if(UtilSite.siteId == UtilSite.SCHOOL)
         {
            return PopUpManager.createPopUp(Application.application as DisplayObject,SchoolUpgrade,true);
         }
         return PopUpManager.createPopUp(Application.application as DisplayObject,GoUpgrade,true);
      }
   }
}
