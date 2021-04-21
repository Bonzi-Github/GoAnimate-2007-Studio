package
{
   import anifire.control.FontChooser;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_control_FontChooserWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_control_FontChooserWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         FontChooser.watcherSetupUtil = new _anifire_control_FontChooserWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[6] = new PropertyWatcher("_bgColor",{"propertyChange":true},[param3[6]],param2);
         param4[4] = new PropertyWatcher("_color",{"propertyChange":true},[param3[4]],param2);
         param4[7] = new PropertyWatcher("_italic",{"propertyChange":true},[param3[7]],param2);
         param4[0] = new PropertyWatcher("_bold",{"propertyChange":true},[param3[0]],param2);
         param4[6].updateParent(param1);
         param4[4].updateParent(param1);
         param4[7].updateParent(param1);
         param4[0].updateParent(param1);
      }
   }
}
