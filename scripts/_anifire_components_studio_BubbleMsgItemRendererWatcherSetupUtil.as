package
{
   import anifire.components.studio.BubbleMsgItemRenderer;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_BubbleMsgItemRendererWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_BubbleMsgItemRendererWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         BubbleMsgItemRenderer.watcherSetupUtil = new _anifire_components_studio_BubbleMsgItemRendererWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[1] = new PropertyWatcher("displayText",null,[param3[0]],param2);
         param4[0] = new PropertyWatcher("data",{"dataChange":true},[param3[0]],param2);
         param4[1].updateParent(param1);
         param4[0].updateParent(param1);
      }
   }
}
