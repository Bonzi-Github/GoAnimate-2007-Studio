package
{
   import anifire.components.studio.PublishWindow;
   import anifire.util.UtilUser;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_PublishWindowWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_PublishWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PublishWindow.watcherSetupUtil = new _anifire_components_studio_PublishWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[30] = new PropertyWatcher("_shareBtnBgEffect",{"propertyChange":true},[param3[27],param3[28]],param2);
         param4[28] = new StaticPropertyWatcher("loggedIn",null,[param3[25]],null);
         param4[14] = new PropertyWatcher("_vsCaptures",{"propertyChange":true},[param3[14]],param2);
         param4[15] = new PropertyWatcher("selectedIndex",{
            "valueCommit":true,
            "change":true
         },[param3[14]],null);
         param4[11] = new PropertyWatcher("LANG_ARRAY",null,[param3[11]],param2);
         param4[16] = new PropertyWatcher("_captures",{"propertyChange":true},[param3[14]],param2);
         param4[17] = new PropertyWatcher("length",null,[param3[14]],null);
         param4[30].updateParent(param1);
         param4[28].updateParent(UtilUser);
         param4[14].updateParent(param1);
         param4[14].addChild(param4[15]);
         param4[11].updateParent(param1);
         param4[16].updateParent(param1);
         param4[16].addChild(param4[17]);
      }
   }
}
