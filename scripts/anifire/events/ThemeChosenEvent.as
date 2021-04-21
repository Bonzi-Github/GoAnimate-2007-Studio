package anifire.events
{
   import anifire.event.ExtraDataEvent;
   
   public class ThemeChosenEvent extends ExtraDataEvent
   {
      
      public static const THEME_CHOSEN:String = "theme_chosen";
       
      
      public var assetType:String;
      
      public var themeId:String;
      
      public function ThemeChosenEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
