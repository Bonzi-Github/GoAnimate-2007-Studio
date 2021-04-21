package
{
   import anifire.components.studio.SpeechComponent;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_SpeechComponentWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_SpeechComponentWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SpeechComponent.watcherSetupUtil = new _anifire_components_studio_SpeechComponentWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[17] = new PropertyWatcher("_boxCloseBtn",{"propertyChange":true},[param3[13]],param2);
         param4[3] = new PropertyWatcher("_boxOpenBtn",{"propertyChange":true},[param3[3],param3[14]],param2);
         param4[4] = new PropertyWatcher("height",{"heightChanged":true},[param3[3]],null);
         param4[12] = new PropertyWatcher("_btnDelete",{"propertyChange":true},[param3[9]],param2);
         param4[13] = new PropertyWatcher("enabled",{"enabledChanged":true},[param3[9]],null);
         param4[5] = new PropertyWatcher("_advPanel",{"propertyChange":true},[param3[17],param3[16],param3[18],param3[4],param3[15]],param2);
         param4[6] = new PropertyWatcher("height",{"heightChanged":true},[param3[16],param3[18],param3[4]],null);
         param4[10] = new PropertyWatcher("_btnSave",{"propertyChange":true},[param3[8]],param2);
         param4[11] = new PropertyWatcher("enabled",{"enabledChanged":true},[param3[8]],null);
         param4[21] = new PropertyWatcher("_images",{"propertyChange":true},[param3[22]],param2);
         param4[22] = new PropertyWatcher("item",{"propertyChange":true},[param3[22]],null);
         param4[17].updateParent(param1);
         param4[3].updateParent(param1);
         param4[3].addChild(param4[4]);
         param4[12].updateParent(param1);
         param4[12].addChild(param4[13]);
         param4[5].updateParent(param1);
         param4[5].addChild(param4[6]);
         param4[10].updateParent(param1);
         param4[10].addChild(param4[11]);
         param4[21].updateParent(param1);
         param4[21].addChild(param4[22]);
      }
   }
}
