package
{
   import anifire.components.studio.Feedback;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_components_studio_FeedbackWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_components_studio_FeedbackWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         Feedback.watcherSetupUtil = new _anifire_components_studio_FeedbackWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[3] = new PropertyWatcher("headingText",{"propertyChange":true},[param3[7]],param2);
         param4[0] = new PropertyWatcher("actionButton",{"propertyChange":true},[param3[0],param3[1],param3[3],param3[4],param3[5],param3[13]],param2);
         param4[5] = new PropertyWatcher("line1",{"propertyChange":true},[param3[9]],param2);
         param4[7] = new PropertyWatcher("line2",{"propertyChange":true},[param3[11]],param2);
         param4[3].updateParent(param1);
         param4[0].updateParent(param1);
         param4[5].updateParent(param1);
         param4[7].updateParent(param1);
      }
   }
}
