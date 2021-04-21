package
{
   import anifire.components.studio.PropertiesWindow;
   import anifire.managers.FeatureManager;
   import anifire.util.UtilUser;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_PropertiesWindowWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_PropertiesWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PropertiesWindow.watcherSetupUtil = new _anifire_components_studio_PropertiesWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[12] = new StaticPropertyWatcher("hasAdminFeatures",null,[param3[22],param3[24]],null);
         param4[11] = new StaticPropertyWatcher("shouldBubbleUrlBeEditable",null,[param3[19],param3[21]],null);
         param4[0] = new PropertyWatcher("_target",{"propertyChange":true},[param3[0],param3[16],param3[1],param3[18],param3[3],param3[20],param3[5],param3[23],param3[10],param3[12],param3[14]],param2);
         param4[12].updateParent(UtilUser);
         param4[11].updateParent(FeatureManager);
         param4[0].updateParent(param1);
      }
   }
}
