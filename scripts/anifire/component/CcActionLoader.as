package anifire.component
{
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.core.CCLipSyncController;
   import anifire.event.ExtraDataEvent;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class CcActionLoader extends EventDispatcher
   {
       
      
      private var _imageData:Object;
      
      private var _downloadManager:DownloadManager;
      
      private var _numTotalSwfs:int = 0;
      
      private var _numSwfs:int = 0;
      
      public function CcActionLoader()
      {
         this._downloadManager = DownloadManager.getInstance();
         super();
      }
      
      public static function getStoreUrl(param1:String) : String
      {
         var _loc4_:RegExp = null;
         var _loc2_:UtilHashArray = Util.getFlashVar();
         var _loc3_:String = _loc2_.getValueByKey(ServerConstants.FLASHVAR_STORE_PATH) as String;
         if(_loc3_ == "" || _loc3_ == null)
         {
            _loc3_ = _loc2_.getValueByKey(ServerConstants.FLASHVAR_APISERVER) as String;
            _loc3_ = _loc3_ + ("static/store/cc_store/" + param1);
         }
         else
         {
            _loc4_ = new RegExp(ServerConstants.FLASHVAR_STORE_PLACEHOLDER,"g");
            _loc3_ = _loc3_.replace(_loc4_,"cc_store/" + param1);
         }
         return _loc3_;
      }
      
      private function onCcComponentFailed(param1:IOErrorEvent) : void
      {
         ++this._numSwfs;
         if(this._numTotalSwfs == this._numSwfs)
         {
            this.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      public function loadCcComponents(param1:XML, param2:Number = 0, param3:Number = 0, param4:UtilHashArray = null, param5:UtilHashArray = null, param6:Number = 1, param7:Boolean = false) : void
      {
         var stream:URLStream = null;
         var url:String = null;
         var node:XML = null;
         var loader:CcComponentLoader = null;
         var isVideoRecord:String = null;
         var componentId:String = null;
         var xml:XML = param1;
         var startMilliSec:Number = param2;
         var endMilliSec:Number = param3;
         var data:UtilHashArray = param4;
         var skins:UtilHashArray = param5;
         var ver:Number = param6;
         var isPlayer:Boolean = param7;
         try
         {
            if(xml)
            {
               isVideoRecord = Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_VIDEO_RECORD_MODE) as String;
               this._numSwfs = 0;
               this._numTotalSwfs = 0;
               this._imageData = new Object();
               this._imageData["imageData"] = !!data?data:new UtilHashArray();
               this._imageData["xml"] = xml;
               for each(node in xml..library)
               {
                  url = getStoreUrl(node.@theme_id + "/" + node.@type + "/" + node.@path + ".swf");
                  componentId = node.@theme_id + "." + node.@type + "." + node.@path + ".swf";
                  if(!UtilHashArray(this._imageData["imageData"]).getValueByKey(componentId))
                  {
                     if(isPlayer == true)
                     {
                        if(this.downloadManager.urlArray.containsKey(url) == false)
                        {
                           loader = new CcComponentLoader(node.@theme_id + "." + node.@type + "." + node.@path + ".swf");
                           loader.addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
                           loader.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
                           loader.load(url);
                           this.downloadManager.urlArray.push(url,null);
                        }
                        else
                        {
                           loader = new CcComponentLoader(node.@theme_id + "." + node.@type + "." + node.@path + ".swf");
                           loader.url = url;
                           this.onCcComponentLoadedCache(loader);
                        }
                     }
                     else
                     {
                        loader = new CcComponentLoader(node.@theme_id + "." + node.@type + "." + node.@path + ".swf");
                        loader.addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
                        loader.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
                        loader.load(url);
                     }
                     ++this._numTotalSwfs;
                  }
               }
               for each(node in xml..component)
               {
                  if(node.hasOwnProperty("@file"))
                  {
                     url = getStoreUrl(node.@theme_id + "/" + node.@type + "/" + node.@path + "/" + node.@file);
                  }
                  else
                  {
                     if(!(node.@type == "freeaction" && node.@path != "default"))
                     {
                        continue;
                     }
                     url = getStoreUrl(node.@theme_id + "/" + node.@type + "/default/" + node.@path + ".swf");
                  }
                  componentId = node.@theme_id + "." + node.@type + "." + node.@path + ".swf";
                  if(!UtilHashArray(this._imageData["imageData"]).getValueByKey(componentId))
                  {
                     if(isPlayer == true)
                     {
                        if(this.downloadManager.urlArray.containsKey(url) == false)
                        {
                           loader = new CcComponentLoader(node.@theme_id + "." + node.@type + "." + node.@path + ".swf");
                           loader.addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
                           loader.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
                           loader.load(url);
                           this.downloadManager.urlArray.push(url,null);
                        }
                        else
                        {
                           loader = new CcComponentLoader(node.@theme_id + "." + node.@type + "." + node.@path + ".swf");
                           loader.url = url;
                           this.onCcComponentLoadedCache(loader);
                        }
                     }
                     else
                     {
                        loader = new CcComponentLoader(node.@theme_id + "." + node.@type + "." + node.@path + ".swf");
                        loader.addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
                        loader.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
                        loader.load(url);
                     }
                     ++this._numTotalSwfs;
                  }
                  this._numTotalSwfs = this.doLoadExtraComponent(node,this._numTotalSwfs);
               }
               if(this._numTotalSwfs == 0)
               {
                  this.dispatchEvent(new Event(Event.COMPLETE));
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function get imageData() : Object
      {
         return this._imageData;
      }
      
      public function clearImageData() : void
      {
         this._imageData = null;
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function timeoutHandler(param1:Event) : void
      {
         this.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onCcComponentLoaded(param1:Event) : void
      {
         var loader:CcComponentLoader = null;
         var componentId:String = null;
         var eProgress:ProgressEvent = null;
         var e:Event = param1;
         try
         {
            loader = CcComponentLoader(e.target);
            componentId = loader.componentId.toString();
            if(loader)
            {
               loader.removeEventListener(e.type,this.onCcComponentLoaded);
               UtilHashArray(this._imageData["imageData"]).push(loader.componentId,loader.swfBytes);
               this.downloadManager.urlArray.push(loader.url,loader.swfBytes);
               ++this._numSwfs;
               eProgress = new ProgressEvent(ProgressEvent.PROGRESS);
               eProgress.bytesLoaded = this._numSwfs;
               eProgress.bytesTotal = this._numTotalSwfs;
               this.dispatchEvent(eProgress);
               loader = null;
               if(this._numTotalSwfs == this._numSwfs)
               {
                  this.dispatchEvent(new Event(Event.COMPLETE));
               }
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function get downloadManager() : DownloadManager
      {
         return this._downloadManager;
      }
      
      public function load(param1:String, param2:String, param3:String = "") : void
      {
         var request:URLRequest = null;
         var stream:UtilURLStream = null;
         var aid:String = param1;
         var actionId:String = param2;
         var facialId:String = param3;
         try
         {
            if(aid && actionId)
            {
               stream = new UtilURLStream();
               request = UtilNetwork.getGetCcActionRequest(aid,actionId);
               stream.addEventListener(Event.COMPLETE,this.onXmlLoaded);
               stream.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
               stream.addEventListener(UtilURLStream.TIME_OUT,this.timeoutHandler);
               stream.load(request);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function onCcComponentLoadedCache(param1:CcComponentLoader) : void
      {
         var loader:CcComponentLoader = null;
         var local:CcActionLoader = null;
         var loopFunction:Function = null;
         var interval:uint = 0;
         var componentLoader:CcComponentLoader = param1;
         loader = componentLoader;
         var componentId:String = loader.componentId.toString();
         var isByteSet:Boolean = false;
         local = this;
         if(loader)
         {
            loopFunction = function():void
            {
               var _loc1_:ProgressEvent = null;
               if(downloadManager.urlArray.containsKey(loader.url) && downloadManager.urlArray.getValueByKey(loader.url) != null)
               {
                  UtilHashArray(_imageData["imageData"]).push(loader.componentId,downloadManager.urlArray.getValueByKey(loader.url));
                  isByteSet = true;
                  clearInterval(interval);
                  ++_numSwfs;
                  _loc1_ = new ProgressEvent(ProgressEvent.PROGRESS);
                  _loc1_.bytesLoaded = _numSwfs;
                  _loc1_.bytesTotal = _numTotalSwfs;
                  local.dispatchEvent(_loc1_);
                  loader = null;
                  if(_numTotalSwfs == _numSwfs)
                  {
                     local.dispatchEvent(new Event(Event.COMPLETE));
                  }
               }
            };
            interval = setInterval(loopFunction,500);
         }
      }
      
      private function onXmlLoaded(param1:Event) : void
      {
         var stream:URLStream = null;
         var bytes:ByteArray = null;
         var xmlCC:XML = null;
         var e:Event = param1;
         try
         {
            IEventDispatcher(e.target).removeEventListener(e.type,this.onXmlLoaded);
            stream = URLStream(e.target);
            bytes = new ByteArray();
            stream.readBytes(bytes);
            xmlCC = XML(bytes);
            this.loadCcComponents(xmlCC);
         }
         catch(e:Error)
         {
         }
      }
      
      private function doLoadExtraComponent(param1:XML, param2:Number) : Number
      {
         var _loc3_:CcComponentLoader = null;
         var _loc6_:UtilHashArray = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc4_:UtilHashArray = new UtilHashArray();
         if(param1.@type == CcLibConstant.COMPONENT_TYPE_MOUTH)
         {
            _loc6_ = CCLipSyncController.getLipSyncComponentItems(param1);
            _loc4_.insert(0,_loc6_);
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc7_ = _loc4_.getKey(_loc5_);
            _loc8_ = _loc4_.getValueByIndex(_loc5_);
            if(!UtilHashArray(this._imageData["imageData"]).getValueByKey(_loc8_))
            {
               if(this.downloadManager.urlArray.containsKey(_loc7_) == false)
               {
                  _loc3_ = new CcComponentLoader(_loc8_);
                  _loc3_.addEventListener(Event.COMPLETE,this.onCcComponentLoaded);
                  _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onCcComponentFailed);
                  _loc3_.load(_loc7_);
                  this.downloadManager.urlArray.push(_loc7_,null);
               }
               else
               {
                  _loc3_ = new CcComponentLoader(_loc8_);
                  _loc3_.url = _loc7_;
                  this.onCcComponentLoadedCache(_loc3_);
               }
               param2++;
            }
            _loc5_++;
         }
         return param2;
      }
      
      private function onCcComponentLoadedStreaming(param1:ExtraDataEvent) : void
      {
         var loader:CcComponentLoader = null;
         var componentId:String = null;
         var eProgress:ProgressEvent = null;
         var e:ExtraDataEvent = param1;
         try
         {
            loader = CcComponentLoader(e.getData());
            componentId = loader.componentId.toString();
            if(loader)
            {
               loader.removeEventListener(e.type,this.onCcComponentLoadedStreaming);
               UtilHashArray(this._imageData["imageData"]).push(loader.componentId,loader.swfBytes);
               this.downloadManager.urlArray.push(loader.url,loader.swfBytes);
               ++this._numSwfs;
               eProgress = new ProgressEvent(ProgressEvent.PROGRESS);
               eProgress.bytesLoaded = this._numSwfs;
               eProgress.bytesTotal = this._numTotalSwfs;
               this.dispatchEvent(eProgress);
               loader = null;
               if(this._numTotalSwfs == this._numSwfs)
               {
                  this.dispatchEvent(new Event(Event.COMPLETE));
               }
            }
         }
         catch(e:Error)
         {
         }
      }
   }
}
