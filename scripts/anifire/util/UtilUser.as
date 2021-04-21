package anifire.util
{
   import anifire.popups.UpdateAccount;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import mx.core.Application;
   import mx.managers.CursorManager;
   import mx.managers.PopUpManager;
   
   public class UtilUser
   {
      
      public static const BETA_USER:Number = 40;
      
      private static var _goPoint:Number = 0;
      
      public static const PLUS_USER:Number = 20;
      
      private static var _type:Number = -1;
      
      private static var _confirmPopUp:UpdateAccount;
      
      public static const ADMIN_USER:Number = 60;
      
      public static const BASIC_USER:Number = 10;
      
      public static const COMM_USER:Number = 30;
      
      private static var _loggedIn:Number = -1;
      
      public static const BETA2_USER:Number = 50;
      
      private static var _goBuck:Number = 0;
      
      private static var _eventDispatcher:EventDispatcher;
      
      public static const ACCOUNT_UPGRADED:String = "ACCOUNT_UPGRADED";
       
      
      public function UtilUser()
      {
         super();
      }
      
      public static function get isDeveloper() : Boolean
      {
         var _loc1_:String = Util.getFlashVar().getValueByKey("apiserver") as String;
         return _loc1_.search("staging") > 0 || _loc1_.search("alvin") > 0;
      }
      
      public static function get goBuck() : Number
      {
         return _goBuck;
      }
      
      public static function set goBuck(param1:Number) : void
      {
         _goBuck = param1;
      }
      
      public static function hasBetaFeatures() : Boolean
      {
         return userType >= BETA_USER;
      }
      
      public static function get goPoint() : Number
      {
         return _goPoint;
      }
      
      private static function onUpdateAccountFail(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,onUpdateAccountFail);
         CursorManager.removeBusyCursor();
      }
      
      public static function showUpdatePopUp() : void
      {
         if(_confirmPopUp == null)
         {
            _confirmPopUp = UpdateAccount(PopUpManager.createPopUp(Application.application as DisplayObject,UpdateAccount,true));
            PopUpManager.centerPopUp(_confirmPopUp);
            _confirmPopUp.y = 100;
            _confirmPopUp.addEventListener("okClick",onTransactionConfirm);
            _confirmPopUp.addEventListener("cancelClick",onTransactionConfirm);
         }
      }
      
      public static function get loggedIn() : Boolean
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:String = null;
         if(_loggedIn == -1)
         {
            _loc1_ = Util.getFlashVar();
            _loc2_ = _loc1_.getValueByKey("userId");
            if(_loc2_ == null || _loc2_ == "")
            {
               _loggedIn = 0;
            }
            else
            {
               _loggedIn = 1;
            }
         }
         return _loggedIn == 1;
      }
      
      public static function hasPlusFeatures() : Boolean
      {
         return userType >= PLUS_USER;
      }
      
      public static function set goPoint(param1:Number) : void
      {
         _goPoint = param1;
      }
      
      public static function get eventDispatcher() : IEventDispatcher
      {
         if(!_eventDispatcher)
         {
            _eventDispatcher = new EventDispatcher();
         }
         return _eventDispatcher;
      }
      
      private static function onTransactionConfirm(param1:Event) : void
      {
         _confirmPopUp = null;
         updateAccount();
      }
      
      public static function updateAccount() : void
      {
         CursorManager.setBusyCursor();
         var _loc1_:URLLoader = new URLLoader();
         var _loc2_:URLRequest = UtilNetwork.getPointStatus();
         _loc1_.addEventListener(Event.COMPLETE,onUpdateAccountComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,onUpdateAccountFail);
         _loc1_.load(_loc2_);
      }
      
      private static function onUpdateAccountComplete(param1:Event) : void
      {
         var data:String = null;
         var xml:XML = null;
         var e:Event = param1;
         (e.target as IEventDispatcher).removeEventListener(e.type,onUpdateAccountComplete);
         try
         {
            data = URLLoader(e.target).data as String;
            if(data.charAt(0) == "0")
            {
               xml = new XML(data.substring(1));
               if(xml.hasOwnProperty("@money"))
               {
                  _goBuck = xml.@money;
               }
               if(xml.hasOwnProperty("@sharing"))
               {
                  _goPoint = xml.@sharing;
               }
               if(xml.hasOwnProperty("@ut"))
               {
                  if(Number(xml.@ut) > userType)
                  {
                     eventDispatcher.dispatchEvent(new Event(ACCOUNT_UPGRADED));
                  }
               }
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("setNavGoBuckGoPoint",_goBuck,_goPoint);
                  ExternalInterface.call("refreshTop");
               }
            }
         }
         catch(e:Error)
         {
         }
         CursorManager.removeBusyCursor();
      }
      
      public static function get userType() : Number
      {
         var _loc1_:UtilHashArray = null;
         var _loc2_:String = null;
         if(_type == -1)
         {
            _loc1_ = Util.getFlashVar();
            _loc2_ = _loc1_.getValueByKey("ut");
            switch(_loc2_)
            {
               case "10":
                  _type = BASIC_USER;
                  break;
               case "20":
                  _type = PLUS_USER;
                  break;
               case "30":
                  _type = COMM_USER;
                  break;
               case "40":
                  _type = BETA_USER;
                  break;
               case "50":
                  _type = BETA2_USER;
                  break;
               case "60":
                  _type = ADMIN_USER;
                  break;
               default:
                  _type = BASIC_USER;
            }
         }
         return _type;
      }
      
      public static function get hasAdminFeatures() : Boolean
      {
         return userType >= ADMIN_USER;
      }
   }
}
