package
{
   import anifire.components.studio.MaskImage;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_MaskImageWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_MaskImageWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MaskImage.watcherSetupUtil = new _anifire_components_studio_MaskImageWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[2] = new PropertyWatcher("_canStep3",{"propertyChange":true},[param3[2],param3[5],param3[8],param3[9]],param2);
         param4[1] = new PropertyWatcher("_canStep2",{"propertyChange":true},[param3[1],param3[4],param3[7],param3[9]],param2);
         param4[0] = new PropertyWatcher("_canStep1",{"propertyChange":true},[param3[0],param3[3],param3[6],param3[9]],param2);
         param4[2].updateParent(param1);
         param4[1].updateParent(param1);
         param4[0].updateParent(param1);
      }
   }
}
