package
{
   import anifire.timeline.SceneElement;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_timeline_SceneElementWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_timeline_SceneElementWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         SceneElement.watcherSetupUtil = new _anifire_timeline_SceneElementWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[3] = new PropertyWatcher("_sceneThumb",{"propertyChange":true},[param3[2],param3[3]],param2);
         param4[4] = new PropertyWatcher("width",{"widthChanged":true},[param3[2],param3[3]],null);
         param4[1] = new PropertyWatcher("data",{"dataChange":true},[param3[1]],param2);
         param4[2] = new PropertyWatcher("label",null,[param3[1]],null);
         param4[0] = new PropertyWatcher("cce",{"propertyChange":true},[param3[0]],param2);
         param4[6] = new PropertyWatcher("_bg",{"propertyChange":true},[param3[5]],param2);
         param4[7] = new PropertyWatcher("width",{"widthChanged":true},[param3[5]],null);
         param4[3].updateParent(param1);
         param4[3].addChild(param4[4]);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[0].updateParent(param1);
         param4[6].updateParent(param1);
         param4[6].addChild(param4[7]);
      }
   }
}
