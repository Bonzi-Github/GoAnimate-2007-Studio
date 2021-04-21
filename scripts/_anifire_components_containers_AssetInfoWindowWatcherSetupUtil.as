package
{
   import anifire.components.containers.AssetInfoWindow;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_AssetInfoWindowWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_containers_AssetInfoWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetInfoWindow.watcherSetupUtil = new _anifire_components_containers_AssetInfoWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("_assetTitle",{"propertyChange":true},[param3[1]],param2);
         param4[6] = new PropertyWatcher("_actionList",{"propertyChange":true},[param3[6]],param2);
         param4[3] = new PropertyWatcher("_tags",{"propertyChange":true},[param3[3]],param2);
         param4[1].updateParent(param1);
         param4[6].updateParent(param1);
         param4[3].updateParent(param1);
      }
   }
}
