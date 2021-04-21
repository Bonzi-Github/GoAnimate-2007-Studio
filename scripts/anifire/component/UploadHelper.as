package anifire.component
{
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class UploadHelper extends EventDispatcher
   {
       
      
      private const MAX_POLL_NUM:int = 3;
      
      private const TIMEOUT_INTERVAL:Number = 15000;
      
      private var latest_asset_id_before_upload:String;
      
      private var max_file_size:Number;
      
      private var request:URLRequest;
      
      private var fileReference:FileReference;
      
      private var timeout_interval_id:int = -1;
      
      private var poll_asset_num_times:int = 0;
      
      public function UploadHelper()
      {
         super();
      }
      
      private function onFileReferenceUploadProgress(param1:ProgressEvent) : void
      {
         this.dispatchEvent(param1);
      }
      
      private function onLatestAssetIdGot(param1:Event) : void
      {
         var _loc5_:IOErrorEvent = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLatestAssetIdGot);
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:String = _loc2_.data as String;
         var _loc4_:String;
         if((_loc4_ = _loc3_.charAt(0)) != "0")
         {
            _loc5_ = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            this.destroyMe();
            this.dispatchEvent(_loc5_);
            return;
         }
         this.latest_asset_id_before_upload = _loc3_.slice(1);
         this.fileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,this.onFileReferenceUploadCompleteData);
         this.fileReference.addEventListener(ProgressEvent.PROGRESS,this.onUploadProgress);
         this.fileReference.addEventListener(IOErrorEvent.IO_ERROR,this.onFileReferenceIoError);
         this.fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFileReferenceSecurityError);
         this.fileReference.upload(this.request);
      }
      
      private function onUploadProgress(param1:ProgressEvent) : void
      {
         if(param1.bytesLoaded > 0 && param1.bytesLoaded >= param1.bytesTotal)
         {
            this.timeout_interval_id = setTimeout(this.getNewAsset,this.TIMEOUT_INTERVAL);
         }
         this.dispatchEvent(param1);
      }
      
      public function init(param1:FileReference, param2:URLRequest) : void
      {
         this.fileReference = param1;
         this.request = param2;
      }
      
      private function onFileReferenceIoError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onFileReferenceIoError);
         this.destroyMe();
         this.dispatchEvent(param1);
      }
      
      private function onFileReferenceUploadCompleteData(param1:DataEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onFileReferenceUploadCompleteData);
         this.destroyMe();
         this.dispatchEvent(param1);
      }
      
      public function upload() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:URLVariables = null;
         var _loc3_:URLLoader = null;
         if(Capabilities.playerType != "ActiveX" && this.fileReference.size > 1 * 1024 * 1024)
         {
            _loc1_ = new URLRequest(ServerConstants.ACTION_GET_LATEST_ASSET_ID);
            _loc1_.method = URLRequestMethod.POST;
            _loc2_ = new URLVariables();
            Util.addFlashVarsToURLvar(_loc2_);
            _loc1_.data = _loc2_;
            _loc3_ = new URLLoader();
            _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onFileReferenceIoError);
            _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFileReferenceSecurityError);
            _loc3_.addEventListener(Event.COMPLETE,this.onLatestAssetIdGot);
            _loc3_.load(_loc1_);
         }
         else
         {
            this.fileReference.addEventListener(ProgressEvent.PROGRESS,this.onFileReferenceUploadProgress);
            this.fileReference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,this.onFileReferenceUploadCompleteData);
            this.fileReference.addEventListener(IOErrorEvent.IO_ERROR,this.onFileReferenceIoError);
            this.fileReference.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFileReferenceSecurityError);
            this.fileReference.upload(this.request);
         }
      }
      
      private function getNewAsset() : void
      {
         var _loc1_:URLRequest = new URLRequest(ServerConstants.ACTION_GET_LATEST_ASSET);
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:URLVariables = new URLVariables();
         Util.addFlashVarsToURLvar(_loc2_);
         _loc2_[ServerConstants.PARAM_PREVIOUS_ASSET_ID] = this.latest_asset_id_before_upload;
         _loc1_.data = _loc2_;
         ++this.poll_asset_num_times;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.onFileReferenceIoError);
         _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFileReferenceSecurityError);
         _loc3_.addEventListener(Event.COMPLETE,this.onNewAssetReceived);
         _loc3_.load(_loc1_);
      }
      
      private function onNewAssetReceived(param1:Event) : void
      {
         var _loc6_:IOErrorEvent = null;
         var _loc7_:DataEvent = null;
         var _loc8_:IOErrorEvent = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onNewAssetReceived);
         var _loc2_:URLLoader = param1.target as URLLoader;
         var _loc3_:String = _loc2_.data as String;
         var _loc4_:String;
         if((_loc4_ = _loc3_.charAt(0)) != "0")
         {
            _loc6_ = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            this.destroyMe();
            this.dispatchEvent(_loc6_);
            return;
         }
         var _loc5_:String;
         if((_loc5_ = _loc3_.slice(1)).length > 0)
         {
            (_loc7_ = new DataEvent(DataEvent.UPLOAD_COMPLETE_DATA)).data = _loc2_.data as String;
            this.dispatchEvent(_loc7_);
            this.destroyMe();
         }
         else if(this.poll_asset_num_times >= this.MAX_POLL_NUM)
         {
            _loc8_ = new IOErrorEvent(IOErrorEvent.IO_ERROR);
            this.destroyMe();
            this.dispatchEvent(_loc8_);
         }
         else
         {
            this.timeout_interval_id = setTimeout(this.getNewAsset,this.TIMEOUT_INTERVAL);
         }
      }
      
      private function destroyMe() : void
      {
         this.fileReference.removeEventListener(ProgressEvent.PROGRESS,this.onFileReferenceUploadProgress);
         this.fileReference.removeEventListener(ProgressEvent.PROGRESS,this.onUploadProgress);
         this.fileReference.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA,this.onFileReferenceUploadCompleteData);
         this.fileReference.removeEventListener(IOErrorEvent.IO_ERROR,this.onFileReferenceIoError);
         this.fileReference.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFileReferenceSecurityError);
         if(this.timeout_interval_id >= 0)
         {
            clearTimeout(this.timeout_interval_id);
         }
      }
      
      private function onFileReferenceSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onFileReferenceSecurityError);
         this.destroyMe();
         this.dispatchEvent(param1);
      }
   }
}
