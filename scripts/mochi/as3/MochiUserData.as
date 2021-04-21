package mochi.as3
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.ObjectEncoding;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class MochiUserData extends EventDispatcher
   {
       
      
      public var callback:Function = null;
      
      public var operation:String = null;
      
      public var error:Event = null;
      
      public var data = null;
      
      public var _loader:URLLoader;
      
      public var key:String = null;
      
      public function MochiUserData(param1:String = "", param2:Function = null)
      {
         super();
         this.key = param1;
         this.callback = param2;
      }
      
      public static function get(param1:String, param2:Function) : void
      {
         var _loc3_:MochiUserData = new MochiUserData(param1,param2);
         _loc3_.getEvent();
      }
      
      public static function put(param1:String, param2:*, param3:Function) : void
      {
         var _loc4_:MochiUserData;
         (_loc4_ = new MochiUserData(param1,param3)).putEvent(param2);
      }
      
      public function serialize(param1:*) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.objectEncoding = ObjectEncoding.AMF3;
         _loc2_.writeObject(param1);
         _loc2_.compress();
         return _loc2_;
      }
      
      public function errorHandler(param1:IOErrorEvent) : void
      {
         this.data = null;
         this.error = param1;
         if(this.callback != null)
         {
            this.performCallback();
         }
         else
         {
            dispatchEvent(param1);
         }
         this.close();
      }
      
      public function putEvent(param1:*) : void
      {
         this.request("put",this.serialize(param1));
      }
      
      public function deserialize(param1:ByteArray) : *
      {
         param1.objectEncoding = ObjectEncoding.AMF3;
         param1.uncompress();
         return param1.readObject();
      }
      
      public function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         this.errorHandler(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,"security error: " + param1.toString()));
      }
      
      public function getEvent() : void
      {
         this.request("get",this.serialize(null));
      }
      
      override public function toString() : String
      {
         return "[MochiUserData operation=" + this.operation + " key=\"" + this.key + "\" data=" + this.data + " error=\"" + this.error + "\"]";
      }
      
      public function performCallback() : void
      {
         try
         {
            this.callback(this);
         }
         catch(e:Error)
         {
            trace("[MochiUserData] exception during callback: " + e);
         }
      }
      
      public function request(param1:String, param2:ByteArray) : void
      {
         var _operation:String = param1;
         var _data:ByteArray = param2;
         this.operation = _operation;
         var api_url:String = MochiSocial.getAPIURL();
         var api_token:String = MochiSocial.getAPIToken();
         if(api_url == null || api_token == null)
         {
            this.errorHandler(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,"not logged in"));
            return;
         }
         this._loader = new URLLoader();
         var args:URLVariables = new URLVariables();
         args.op = _operation;
         args.key = this.key;
         var req:URLRequest = new URLRequest(MochiSocial.getAPIURL() + "/" + "MochiUserData?" + args.toString());
         req.method = URLRequestMethod.POST;
         req.contentType = "application/x-mochi-userdata";
         req.requestHeaders = [new URLRequestHeader("x-mochi-services-version",MochiServices.getVersion()),new URLRequestHeader("x-mochi-api-token",api_token)];
         req.data = _data;
         this._loader.dataFormat = URLLoaderDataFormat.BINARY;
         this._loader.addEventListener(Event.COMPLETE,this.completeHandler);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
         try
         {
            this._loader.load(req);
         }
         catch(e:SecurityError)
         {
            errorHandler(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,"security error: " + e.toString()));
         }
      }
      
      public function completeHandler(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            if(this._loader.data.length)
            {
               this.data = this.deserialize(this._loader.data);
            }
            else
            {
               this.data = null;
            }
         }
         catch(e:Error)
         {
            errorHandler(new IOErrorEvent(IOErrorEvent.IO_ERROR,false,false,"deserialize error: " + e.toString()));
            return;
         }
         if(this.callback != null)
         {
            this.performCallback();
         }
         else
         {
            dispatchEvent(event);
         }
         this.close();
      }
      
      public function close() : void
      {
         if(this._loader)
         {
            this._loader.removeEventListener(Event.COMPLETE,this.completeHandler);
            this._loader.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
            this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.securityErrorHandler);
            this._loader.close();
            this._loader = null;
         }
         this.error = null;
         this.callback = null;
      }
   }
}
