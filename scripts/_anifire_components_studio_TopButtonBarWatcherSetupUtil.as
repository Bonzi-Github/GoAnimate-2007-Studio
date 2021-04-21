package
{
   import anifire.components.studio.TopButtonBar;
   import anifire.util.Util;
   import flash.display.Sprite;
   import mx.binding.FunctionReturnWatcher;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_TopButtonBarWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_TopButtonBarWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         TopButtonBar.watcherSetupUtil = new _anifire_components_studio_TopButtonBarWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         var target:Object = param1;
         var propertyGetter:Function = param2;
         var bindings:Array = param3;
         var watchers:Array = param4;
         watchers[14] = new PropertyWatcher("_btnPreview",{"propertyChange":true},[bindings[12]],propertyGetter);
         watchers[19] = new PropertyWatcher("_vRule",{"propertyChange":true},[bindings[18]],propertyGetter);
         watchers[20] = new PropertyWatcher("_btnMoreMenu",{"propertyChange":true},[bindings[19]],propertyGetter);
         watchers[12] = new PropertyWatcher("_btnSave",{"propertyChange":true},[bindings[10],bindings[13]],propertyGetter);
         watchers[15] = new PropertyWatcher("_container",{"propertyChange":true},[bindings[20],bindings[14]],propertyGetter);
         watchers[9] = new FunctionReturnWatcher("getFlashVar",target,function():Array
         {
            return [];
         },null,[bindings[9]],null);
         watchers[18] = new PropertyWatcher("_btnRecord",{"propertyChange":true},[bindings[17]],propertyGetter);
         watchers[14].updateParent(target);
         watchers[19].updateParent(target);
         watchers[20].updateParent(target);
         watchers[12].updateParent(target);
         watchers[15].updateParent(target);
         watchers[9].updateParent(Util);
         watchers[18].updateParent(target);
      }
   }
}
