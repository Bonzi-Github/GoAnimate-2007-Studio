package
{
   import anifire.components.studio.ThumbTray;
   import anifire.managers.FeatureManager;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_ThumbTrayWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_ThumbTrayWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         ThumbTray.watcherSetupUtil = new _anifire_components_studio_ThumbTrayWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[3] = new StaticPropertyWatcher("shouldCreateCcButtonBeShown",null,[param3[5],param3[6],param3[10],param3[11],param3[14],param3[15]],null);
         param4[42] = new PropertyWatcher("pnlShadow",{"propertyChange":true},[param3[72]],param2);
         param4[41] = new PropertyWatcher("VSThumbTray",{"propertyChange":true},[param3[71]],param2);
         param4[35] = new PropertyWatcher("btnImport",{"propertyChange":true},[param3[63]],param2);
         param4[37] = new PropertyWatcher("_uiCanvasUser",{"propertyChange":true},[param3[67]],param2);
         param4[36] = new PropertyWatcher("_vbTribe",{"propertyChange":true},[param3[64],param3[65],param3[66]],param2);
         param4[39] = new PropertyWatcher("_uiCanvasCommunity",{"propertyChange":true},[param3[69]],param2);
         param4[3].updateParent(FeatureManager);
         param4[42].updateParent(param1);
         param4[41].updateParent(param1);
         param4[35].updateParent(param1);
         param4[37].updateParent(param1);
         param4[36].updateParent(param1);
         param4[39].updateParent(param1);
      }
   }
}
