package
{
   import anifire.component.DoubleStateButton;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_component_DoubleStateButtonWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_component_DoubleStateButtonWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         DoubleStateButton.watcherSetupUtil = new _anifire_component_DoubleStateButtonWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("but1Label",{"propertyChange":true},[param3[0]],param2);
         param4[1] = new PropertyWatcher("but1StyleName",{"propertyChange":true},[param3[1]],param2);
         param4[3] = new PropertyWatcher("but2StyleName",{"propertyChange":true},[param3[3]],param2);
         param4[2] = new PropertyWatcher("but2Label",{"propertyChange":true},[param3[2]],param2);
         param4[0].updateParent(param1);
         param4[1].updateParent(param1);
         param4[3].updateParent(param1);
         param4[2].updateParent(param1);
      }
   }
}
