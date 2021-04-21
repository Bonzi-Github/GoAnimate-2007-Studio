package anifire.util
{
   import anifire.util.Crypto.RC4;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   import mx.utils.ObjectUtil;
   
   public class UtilErrorLogger extends EventDispatcher
   {
      
      private static var _instance:UtilErrorLogger = null;
       
      
      private var _errors:Array;
      
      public function UtilErrorLogger()
      {
         this._errors = [];
         super();
      }
      
      public static function getInstance() : UtilErrorLogger
      {
         if(!_instance)
         {
            _instance = new UtilErrorLogger();
         }
         return _instance;
      }
      
      private function prepareModel() : Object
      {
         return {
            "env":this.getFlashVars(),
            "err":this._errors
         };
      }
      
      public function get hasErrors() : Boolean
      {
         return this._errors.length > 0;
      }
      
      private function getFlashVars() : String
      {
         var _loc1_:URLVariables = new URLVariables();
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_[_loc2_.getKey(_loc3_)] = _loc2_.getValueByIndex(_loc3_);
            _loc3_++;
         }
         return _loc1_.toString();
      }
      
      public function flush() : void
      {
         var rc4:RC4 = null;
         var loader:URLLoader = null;
         var out_ba:ByteArray = new ByteArray();
         var b64Encoder:Base64Encoder = new Base64Encoder();
         loader = new URLLoader();
         if(!this.hasErrors)
         {
            return;
         }
         var encryptionKey:ByteArray = new ByteArray();
         encryptionKey.writeUTFBytes("i32b7!2qM*s82@pT");
         rc4 = new RC4(encryptionKey);
         out_ba.writeUTFBytes(ObjectUtil.toString(this.prepareModel()));
         rc4.encrypt(out_ba);
         b64Encoder.encodeBytes(out_ba);
         var request:URLRequest = UtilNetwork.getSendBugReportRequest();
         request.data["rpt"] = b64Encoder.toString();
         var okHandler:Function = function(param1:Event):void
         {
            removeEventListener(Event.COMPLETE,arguments.callee);
            var _loc3_:String = "1";
            if(loader.bytesTotal >= 1)
            {
               _loc3_ = String(loader.data).charAt(0);
            }
            if(_loc3_ == "0")
            {
               _errors.splice(0,_errors.length);
            }
         };
         var errHandler:Function = function(param1:Event):void
         {
            removeEventListener(SecurityErrorEvent.SECURITY_ERROR,arguments.callee);
            removeEventListener(IOErrorEvent.IO_ERROR,arguments.callee);
         };
         var _loc2_:*;
         with(_loc2_ = loader)
         {
            
            addEventListener(Event.COMPLETE,okHandler);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR,errHandler);
            addEventListener(IOErrorEvent.IO_ERROR,errHandler);
            load(request);
         }
      }
      
      public function appendCustomError(param1:String, param2:Error, param3:Object = null) : void
      {
         var _loc4_:NestedError;
         (_loc4_ = new NestedError(param1,param2)).userData = param3 || {};
         this.appendError(_loc4_);
      }
      
      public function appendError(param1:Error) : void
      {
         this._errors.push(param1);
      }
   }
}
