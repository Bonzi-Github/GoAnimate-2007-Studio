package
{
   import anifire.playerComponent.playerEndScreen.PlayerEndScreen;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
       
      
      public function _anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         PlayerEndScreen.watcherSetupUtil = new _anifire_playerComponent_playerEndScreen_PlayerEndScreenWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[21] = new PropertyWatcher("_txtEndReminder1",{"propertyChange":true},[param3[22]],param2);
         param4[23] = new PropertyWatcher("_btnEndReminderPri",{"propertyChange":true},[param3[24],param3[26]],param2);
         param4[22] = new PropertyWatcher("_btnEndReminderPub",{"propertyChange":true},[param3[23],param3[25]],param2);
         param4[21].updateParent(param1);
         param4[23].updateParent(param1);
         param4[22].updateParent(param1);
      }
   }
}
