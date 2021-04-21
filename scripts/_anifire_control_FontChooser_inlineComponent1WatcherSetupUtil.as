package
{
   import anifire.control.FontChooser_inlineComponent1;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_control_FontChooser_inlineComponent1WatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_control_FontChooser_inlineComponent1WatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         FontChooser_inlineComponent1.watcherSetupUtil = new _anifire_control_FontChooser_inlineComponent1WatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("data",{"dataChange":true},[param3[0],param3[1]],param2);
         param4[1] = new PropertyWatcher("data",null,[param3[0],param3[1]],null);
         param4[0].updateParent(param1);
         param4[0].addChild(param4[1]);
      }
   }
}
