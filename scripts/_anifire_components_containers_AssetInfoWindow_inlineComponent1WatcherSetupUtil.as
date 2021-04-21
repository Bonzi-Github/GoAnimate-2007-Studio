package
{
   import anifire.components.containers.AssetInfoWindow_inlineComponent1;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_AssetInfoWindow_inlineComponent1WatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_containers_AssetInfoWindow_inlineComponent1WatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         AssetInfoWindow_inlineComponent1.watcherSetupUtil = new _anifire_components_containers_AssetInfoWindow_inlineComponent1WatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("data",{"dataChange":true},[param3[0],param3[2],param3[3],param3[5]],param2);
         param4[3] = new PropertyWatcher("id",null,[param3[2]],null);
         param4[1] = new PropertyWatcher("name",null,[param3[0]],null);
         param4[4] = new PropertyWatcher("notDefault",null,[param3[3],param3[5]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[3]);
         param4[0].addChild(param4[1]);
         param4[0].addChild(param4[4]);
      }
   }
}
