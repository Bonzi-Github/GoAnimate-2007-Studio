package
{
   import anifire.playerComponent.PreviewPlayer;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.binding.StaticPropertyWatcher;
   import mx.core.Application;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_playerComponent_PreviewPlayerWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_playerComponent_PreviewPlayerWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PreviewPlayer.watcherSetupUtil = new _anifire_playerComponent_PreviewPlayerWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[11] = new PropertyWatcher("fadeMoveHide",{"propertyChange":true},[param3[7]],param2);
         param4[6] = new PropertyWatcher("loading",{"propertyChange":true},[param3[3],param3[9]],param2);
         param4[7] = new PropertyWatcher("width",{"widthChanged":true},[param3[3]],null);
         param4[10] = new PropertyWatcher("fadeMoveShow",{"propertyChange":true},[param3[6]],param2);
         param4[1] = new PropertyWatcher("loadingScreen",{"propertyChange":true},[param3[1],param3[3]],param2);
         param4[2] = new PropertyWatcher("width",{"widthChanged":true},[param3[1],param3[3]],null);
         param4[3] = new PropertyWatcher("createYourOwn",{"propertyChange":true},[param3[1],param3[8]],param2);
         param4[4] = new PropertyWatcher("width",{"widthChanged":true},[param3[1]],null);
         param4[12] = new StaticPropertyWatcher("application",null,[param3[10],param3[11],param3[12]],null);
         param4[14] = new PropertyWatcher("height",null,[param3[11]],null);
         param4[13] = new PropertyWatcher("width",null,[param3[10],param3[12]],null);
         param4[11].updateParent(param1);
         param4[6].updateParent(param1);
         param4[6].addChild(param4[7]);
         param4[10].updateParent(param1);
         param4[1].updateParent(param1);
         param4[1].addChild(param4[2]);
         param4[3].updateParent(param1);
         param4[3].addChild(param4[4]);
         param4[12].updateParent(Application);
         param4[12].addChild(param4[14]);
         param4[12].addChild(param4[13]);
      }
   }
}
