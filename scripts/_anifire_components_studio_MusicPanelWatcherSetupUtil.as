package
{
   import anifire.components.studio.MusicPanel;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_MusicPanelWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_MusicPanelWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MusicPanel.watcherSetupUtil = new _anifire_components_studio_MusicPanelWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[13] = new PropertyWatcher("width",{"widthChanged":true},[param3[13]],param2);
         param4[14] = new PropertyWatcher("height",{"heightChanged":true},[param3[14]],param2);
         param4[13].updateParent(param1);
         param4[14].updateParent(param1);
      }
   }
}
