package
{
   import anifire.components.containers.HyperLinkWindow;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_containers_HyperLinkWindowWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_containers_HyperLinkWindowWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         HyperLinkWindow.watcherSetupUtil = new _anifire_components_containers_HyperLinkWindowWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[8] = new PropertyWatcher("_btnRemove",{"propertyChange":true},[param3[3]],param2);
         param4[9] = new PropertyWatcher("width",{"widthChanged":true},[param3[3]],null);
         param4[5] = new PropertyWatcher("txtURLReal",{"propertyChange":true},[param3[3]],param2);
         param4[7] = new PropertyWatcher("width",{"widthChanged":true},[param3[3]],null);
         param4[6] = new PropertyWatcher("x",{"xChanged":true},[param3[3]],null);
         param4[2] = new PropertyWatcher("hostURL",{"propertyChange":true},[param3[2]],param2);
         param4[4] = new PropertyWatcher("width",{"widthChanged":true},[param3[2]],null);
         param4[3] = new PropertyWatcher("x",{"xChanged":true},[param3[2]],null);
         param4[8].updateParent(param1);
         param4[8].addChild(param4[9]);
         param4[5].updateParent(param1);
         param4[5].addChild(param4[7]);
         param4[5].addChild(param4[6]);
         param4[2].updateParent(param1);
         param4[2].addChild(param4[4]);
         param4[2].addChild(param4[3]);
      }
   }
}
