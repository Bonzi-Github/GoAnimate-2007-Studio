package
{
   import anifire.component.SharingPanel;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_component_SharingPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_component_SharingPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SharingPanel.watcherSetupUtil = new _anifire_component_SharingPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("_hboxEmail",{"propertyChange":true},[param3[1],param3[2]],param2);
         param4[3] = new PropertyWatcher("y",{"yChanged":true},[param3[2]],null);
         param4[2] = new PropertyWatcher("x",{"xChanged":true},[param3[1]],null);
         param4[45] = new PropertyWatcher("_btnNewAnimation",{"propertyChange":true},[param3[36]],param2);
         param4[46] = new PropertyWatcher("width",{"widthChanged":true},[param3[36]],null);
         param4[43] = new PropertyWatcher("lblCreateTitle",{"propertyChange":true},[param3[35]],param2);
         param4[44] = new PropertyWatcher("width",{"widthChanged":true},[param3[35]],null);
         param4[41] = new PropertyWatcher("_canCreate",{"propertyChange":true},[param3[35],param3[36]],param2);
         param4[42] = new PropertyWatcher("width",{"widthChanged":true},[param3[35],param3[36]],null);
         param4[31] = new PropertyWatcher("_emailSentText",{"propertyChange":true},[param3[28]],param2);
         param4[4] = new PropertyWatcher("_txtRecEmail",{"propertyChange":true},[param3[2]],param2);
         param4[5] = new PropertyWatcher("y",{"yChanged":true},[param3[2]],null);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[3]);
         param4[1].addChild(param4[2]);
         param4[45].updateParent(param1);
         param4[45].addChild(param4[46]);
         param4[43].updateParent(param1);
         param4[43].addChild(param4[44]);
         param4[41].updateParent(param1);
         param4[41].addChild(param4[42]);
         param4[31].updateParent(param1);
         param4[4].updateParent(param1);
         param4[4].addChild(param4[5]);
      }
   }
}
