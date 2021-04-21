package
{
   import anifire.popups.SchoolUpgradeOnTts;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_popups_SchoolUpgradeOnTtsWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_popups_SchoolUpgradeOnTtsWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SchoolUpgradeOnTts.watcherSetupUtil = new _anifire_popups_SchoolUpgradeOnTtsWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
      }
   }
}
