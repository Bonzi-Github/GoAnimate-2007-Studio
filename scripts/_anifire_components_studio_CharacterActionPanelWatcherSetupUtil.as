package
{
   import anifire.components.studio.CharacterActionPanel;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_CharacterActionPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_CharacterActionPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         CharacterActionPanel.watcherSetupUtil = new _anifire_components_studio_CharacterActionPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[6] = new PropertyWatcher("btnFacial",{"propertyChange":true},[param3[5]],param2);
         param4[7] = new PropertyWatcher("enabled",{"enabledChanged":true},[param3[5]],null);
         param4[13] = new PropertyWatcher("btnHeadGear",{"propertyChange":true},[param3[10]],param2);
         param4[14] = new PropertyWatcher("enabled",{"enabledChanged":true},[param3[10]],null);
         param4[10] = new PropertyWatcher("btnHandHeld",{"propertyChange":true},[param3[8]],param2);
         param4[11] = new PropertyWatcher("enabled",{"enabledChanged":true},[param3[8]],null);
         param4[1] = new PropertyWatcher("btnAction",{"propertyChange":true},[param3[1]],param2);
         param4[2] = new PropertyWatcher("enabled",{"enabledChanged":true},[param3[1]],null);
         param4[17] = new PropertyWatcher("btnRestoreHead",{"propertyChange":true},[param3[13]],param2);
         param4[18] = new PropertyWatcher("enabled",{"enabledChanged":true},[param3[13]],null);
         param4[6].updateParent(param1);
         param4[6].addChild(param4[7]);
         param4[13].updateParent(param1);
         param4[13].addChild(param4[14]);
         param4[10].updateParent(param1);
         param4[10].addChild(param4[11]);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[17].updateParent(param1);
         param4[17].addChild(param4[18]);
      }
   }
}
