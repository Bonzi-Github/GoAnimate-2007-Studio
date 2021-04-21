package anifire.component
{
   import anifire.constant.CcLibConstant;
   import anifire.util.UtilCrypto;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   
   public class CcComponentLoader extends EventDispatcher
   {
       
      
      private var _path:String;
      
      private var _swfBytes:ByteArray;
      
      private var _decryptEngine:UtilCrypto;
      
      private var _id:String;
      
      private var _numTry:int;
      
      private var _stream:URLStream;
      
      public function CcComponentLoader(param1:String)
      {
         super();
         this._id = param1;
      }
      
      private function removeListeners() : void
      {
         if(this._stream)
         {
            this._stream.removeEventListener(Event.COMPLETE,this.onSwfLoaded);
            this._stream.removeEventListener(ProgressEvent.PROGRESS,this.onProgress);
            this._stream.removeEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         }
      }
      
      public function set url(param1:String) : void
      {
         this._path = param1;
      }
      
      public function load(param1:String) : void
      {
         this._numTry = 0;
         this._path = param1;
         this.reload(this._path);
      }
      
      public function get swfBytes() : ByteArray
      {
         return this._swfBytes;
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         ++this._numTry;
         if(this._numTry < 3 && this._path)
         {
            this.reload(this._path);
         }
         else
         {
            trace("load cc component failed: " + this._path);
            this.removeListeners();
            this.dispatchEvent(param1);
         }
      }
      
      private function onProgress(param1:ProgressEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function onSwfLoaded(param1:Event) : void
      {
         var cType:String = null;
         var e:Event = param1;
         try
         {
            this.removeListeners();
            this._swfBytes = new ByteArray();
            this._stream.readBytes(this._swfBytes);
            this._stream = null;
            cType = this._id.split(".")[1];
            if(CcLibConstant.ALL_LIBRARY_TYPES.indexOf(cType) == -1)
            {
               this._decryptEngine = new UtilCrypto();
               this._decryptEngine.decrypt(this._swfBytes);
               this._decryptEngine = null;
            }
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
         catch(e:Error)
         {
         }
      }
      
      public function get url() : String
      {
         return this._path;
      }
      
      public function get componentId() : String
      {
         return this._id;
      }
      
      public function reload(param1:String) : void
      {
         var path:String = param1;
         try
         {
            if(path)
            {
               this.removeListeners();
               this._stream = new URLStream();
               this._stream.addEventListener(Event.COMPLETE,this.onSwfLoaded);
               this._stream.addEventListener(ProgressEvent.PROGRESS,this.onProgress);
               this._stream.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
               this._stream.load(new URLRequest(path));
               trace("cc component streaming ... " + path);
            }
         }
         catch(e:Error)
         {
         }
      }
   }
}
