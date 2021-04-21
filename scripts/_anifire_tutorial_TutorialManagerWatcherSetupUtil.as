package
{
   import anifire.managers.FeatureManager;
   import anifire.tutorial.TutorialManager;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_tutorial_TutorialManagerWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_tutorial_TutorialManagerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TutorialManager.watcherSetupUtil = new _anifire_tutorial_TutorialManagerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("filterBlur",{"propertyChange":true},[param3[0]],param2);
         param4[7] = new PropertyWatcher("_effResize",{"propertyChange":true},[param3[6]],param2);
         param4[6] = new StaticPropertyWatcher("shouldStopTutorialButtonBeShown",null,[param3[5]],null);
         param4[1] = new PropertyWatcher("_effMove",{"propertyChange":true},[param3[1],param3[8]],param2);
         param4[10] = new PropertyWatcher("_effFadeOut",{"propertyChange":true},[param3[10],param3[13]],param2);
         param4[4] = new PropertyWatcher("_content",{"propertyChange":true},[param3[4]],param2);
         param4[5] = new PropertyWatcher("height",{"heightChanged":true},[param3[4]],null);
         param4[2] = new PropertyWatcher("_filterShadow",{"propertyChange":true},[param3[2]],param2);
         param4[9] = new PropertyWatcher("_effFadeIn",{"propertyChange":true},[param3[9],param3[12]],param2);
         param4[0].updateParent(param1);
         param4[7].updateParent(param1);
         param4[6].updateParent(FeatureManager);
         param4[1].updateParent(param1);
         param4[10].updateParent(param1);
         param4[4].updateParent(param1);
         param4[4].addChild(param4[5]);
         param4[2].updateParent(param1);
         param4[9].updateParent(param1);
      }
   }
}
