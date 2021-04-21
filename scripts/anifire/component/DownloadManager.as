package anifire.component
{
   import anifire.constant.AnimeConstants;
   import anifire.event.ExtraDataEvent;
   import anifire.event.PlayerEvent;
   import anifire.sound.NetStreamController;
   import anifire.sound.VideoNetStreamController;
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   import flash.utils.Timer;
   
   public class DownloadManager extends EventDispatcher
   {
      
      private static var singleton:DownloadManager;
       
      
      private var _urlArray:UtilHashArray;
      
      private var _scenePreviewNum:Number;
      
      private var _timer:Timer;
      
      private var _curMilliSecond:Number;
      
      private var _sounds:UtilHashArray;
      
      private var _movieDuration:Number;
      
      private var _sound_download_queue:Array;
      
      private var _graphContainer:DisplayObjectContainer;
      
      private var _downloadServiceProviders:Array;
      
      public function DownloadManager()
      {
         this._urlArray = new UtilHashArray();
         super();
      }
      
      public static function getInstance() : DownloadManager
      {
         if(DownloadManager.singleton == null)
         {
            DownloadManager.singleton = new DownloadManager();
         }
         return DownloadManager.singleton;
      }
      
      private function startTimer() : void
      {
         if(Util.isDebugMode)
         {
            this._timer.addEventListener(TimerEvent.TIMER,this.doDrawDownloadStatus);
         }
         this._timer.addEventListener(TimerEvent.TIMER,this.doManageDownloadStatus);
         this._timer.start();
      }
      
      private function stopTimer() : void
      {
         if(Capabilities.isDebugger)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.doDrawDownloadStatus);
         }
         this._timer.removeEventListener(TimerEvent.TIMER,this.doManageDownloadStatus);
      }
      
      public function init() : void
      {
         this._sounds = new UtilHashArray();
         this._timer = new Timer(500);
      }
      
      public function startDownload() : void
      {
         var _loc1_:int = 0;
         this._downloadServiceProviders = new Array();
         _loc1_ = 0;
         while(_loc1_ < AnimeConstants.MAX_CONCURRENT_NETWORK_CONNECTION)
         {
            this._downloadServiceProviders.push(new DownloadServiceProvider());
            _loc1_++;
         }
         this._sound_download_queue = new Array();
         _loc1_ = 0;
         while(_loc1_ < this._sounds.length)
         {
            this._sound_download_queue.push(this._sounds.getValueByIndex(_loc1_));
            _loc1_++;
         }
         this.reorganizeCustomerQueue(0);
         this.startTimer();
      }
      
      public function set urlArray(param1:UtilHashArray) : void
      {
         this._urlArray = param1;
      }
      
      public function registerCcComponent(param1:String, param2:Number, param3:Number, param4:String, param5:CcActionLoader) : CcComponentLoader
      {
         var _loc6_:String = null;
         _loc6_ = new Date().toString() + Math.random().toString();
         var _loc7_:CcComponentLoader = new CcComponentLoader(param4);
         var _loc8_:CcComponentItem;
         (_loc8_ = new CcComponentItem()).init(param1,_loc7_,param2,param3,param5);
         _loc7_.addEventListener("FULLY_DOWNLOADED",this.dispatchCompleteToBehaviour);
         this._sounds.push(_loc6_,_loc8_);
         return _loc7_;
      }
      
      private function getIsBufferReady(param1:Number) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:SoundItem = null;
         var _loc4_:DownloadServiceProvider = null;
         _loc2_ = 0;
         while(_loc2_ < this._sound_download_queue.length)
         {
            _loc3_ = this._sound_download_queue[_loc2_] as SoundItem;
            if(!this.checkBufferReady(_loc3_,param1,this._movieDuration))
            {
               return false;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._downloadServiceProviders.length)
         {
            _loc3_ = (_loc4_ = this._downloadServiceProviders[_loc2_] as DownloadServiceProvider).currentCustomer;
            if(_loc3_ != null && !this.checkBufferReady(_loc3_,param1,this._movieDuration))
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      private function onLoadError(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadError);
      }
      
      public function registerVideoNetStream(param1:String, param2:Number, param3:Number, param4:Number) : VideoNetStreamController
      {
         var _loc5_:String = null;
         _loc5_ = new Date().toString() + Math.random().toString();
         var _loc6_:VideoNetStreamController = new VideoNetStreamController(param4);
         var _loc7_:VideoStreamSoundItem;
         (_loc7_ = new VideoStreamSoundItem()).init(param1,_loc6_,param2,param3);
         this._sounds.push(_loc5_,_loc7_);
         return _loc6_;
      }
      
      public function registerNetStream(param1:String, param2:String, param3:Number, param4:Number, param5:Number) : NetStreamController
      {
         var _loc6_:String = null;
         _loc6_ = new Date().toString() + Math.random().toString();
         var _loc7_:NetStreamController = new NetStreamController(param5);
         var _loc8_:StreamSoundItem;
         (_loc8_ = new StreamSoundItem()).init(param1,param2,_loc7_,param3,param4);
         this._sounds.push(_loc6_,_loc8_);
         return _loc7_;
      }
      
      private function doManageDownloadStatus(param1:TimerEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doManageDownloadStatus);
         this.manageDownloadServiceProvider();
         if(this.hasEventListener(PlayerEvent.BUFFER_READY))
         {
            if(this._scenePreviewNum > 0)
            {
               if(this.getIsBufferReadyByTimeRange(this._scenePreviewNum,this._scenePreviewNum + 10000))
               {
                  trace("downloadmanager buffer ready");
                  this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_READY));
               }
            }
            else if(this.getIsBufferReady(this._curMilliSecond))
            {
               trace("downloadmanager buffer ready");
               this.dispatchEvent(new PlayerEvent(PlayerEvent.BUFFER_READY));
            }
         }
         if(this._sound_download_queue.length <= 0 && this._downloadServiceProviders.length <= 0)
         {
            this.stopTimer();
         }
         else
         {
            this._timer.addEventListener(TimerEvent.TIMER,this.doManageDownloadStatus);
         }
      }
      
      public function get urlArray() : UtilHashArray
      {
         return this._urlArray;
      }
      
      public function reorganizeCustomerQueue(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:StreamSoundItem = null;
         var _loc5_:VideoStreamSoundItem = null;
         this._curMilliSecond = param1;
         this._sound_download_queue.sort(this.sortCustomerInQueue);
         var _loc3_:int = 0;
         while(_loc3_ < this._sounds.length)
         {
            if(this._sounds.getValueByIndex(_loc3_) is StreamSoundItem)
            {
               if((_loc4_ = this._sounds.getValueByIndex(_loc3_)).isConnected)
               {
                  _loc2_ = Math.max(param1 - _loc4_.startTime,0) / 1000;
                  _loc4_.seek(_loc2_);
               }
            }
            else if(this._sounds.getValueByIndex(_loc3_) is VideoStreamSoundItem)
            {
               if((_loc5_ = this._sounds.getValueByIndex(_loc3_)).isConnected)
               {
                  _loc2_ = Math.max(param1 - _loc5_.startTime,0) / 1000;
                  _loc5_.seek(_loc2_);
               }
            }
            _loc3_++;
         }
      }
      
      public function getIsBufferReadyByTimeRange(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:SoundItem = null;
         if(param2 > this._movieDuration)
         {
            param2 = this._movieDuration;
         }
         _loc3_ = 0;
         while(_loc3_ < this._sounds.length)
         {
            _loc4_ = this._sounds.getValueByIndex(_loc3_);
            if(UtilPlain.isTimeRangesOverlap(param1,param2,_loc4_.startTime,_loc4_.endTime))
            {
               if(!_loc4_.isSoundBufferReadyAtTime(param2 - _loc4_.startTime))
               {
                  return false;
               }
            }
            _loc3_++;
         }
         return true;
      }
      
      private function dispatchCompleteToBehaviour(param1:ExtraDataEvent) : void
      {
         var _loc2_:CcComponentLoader = CcComponentLoader(param1.getData());
         param1.getEventCreater().dispatchEvent(new ExtraDataEvent("COMPLETE",param1.getEventCreater(),_loc2_));
      }
      
      private function sortCustomerInQueue(param1:SoundItem, param2:SoundItem) : Number
      {
         if(param1.startTime > this._curMilliSecond && this._curMilliSecond > param2.endTime)
         {
            return -1;
         }
         if(param2.startTime > this._curMilliSecond && this._curMilliSecond > param1.endTime)
         {
            return 1;
         }
         if(param1.startTime < param2.startTime)
         {
            return -1;
         }
         if(param2.startTime < param1.startTime)
         {
            return 1;
         }
         if(param1.endTime < param2.endTime)
         {
            return -1;
         }
         if(param2.endTime < param1.endTime)
         {
            return 1;
         }
         return 0;
      }
      
      public function registerSoundChannel(param1:URLRequest, param2:Number, param3:Number) : Sound
      {
         var _loc4_:String = null;
         _loc4_ = new Date().toString() + Math.random().toString();
         var _loc5_:Sound = new Sound();
         var _loc6_:ProgressiveSoundItem;
         (_loc6_ = new ProgressiveSoundItem()).init(param1,_loc5_,param2,param3);
         this._sounds.push(_loc4_,_loc6_);
         return _loc5_;
      }
      
      private function doDrawDownloadStatus(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doDrawDownloadStatus);
         this.drawDownloadStatus();
      }
      
      private function manageDownloadServiceProvider() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DownloadServiceProvider = null;
         var _loc3_:SoundItem = null;
         _loc1_ = 0;
         while(_loc1_ < this._downloadServiceProviders.length)
         {
            _loc2_ = this._downloadServiceProviders[_loc1_] as DownloadServiceProvider;
            if(_loc2_.hasCustomer && _loc2_.isCustomerBufferReady)
            {
               if(_loc2_.currentCustomer is StreamSoundItem)
               {
                  this._sound_download_queue.push(_loc2_.currentCustomer);
               }
               _loc2_.stopService();
            }
            if(!_loc2_.hasCustomer && this._sound_download_queue.length > 0)
            {
               _loc3_ = this._sound_download_queue.shift() as SoundItem;
               _loc2_.startService(_loc3_);
            }
            _loc1_++;
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:int = 0;
         var _loc2_:DownloadServiceProvider = null;
         if(this._downloadServiceProviders == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this._downloadServiceProviders.length)
         {
            _loc2_ = this._downloadServiceProviders[_loc1_] as DownloadServiceProvider;
            if(_loc2_.hasCustomer)
            {
               _loc2_.destroy();
            }
            _loc1_++;
         }
      }
      
      public function initDependency(param1:int, param2:DisplayObjectContainer, param3:Number = 0) : void
      {
         this._movieDuration = param1;
         this._graphContainer = param2;
         this._scenePreviewNum = param3;
      }
      
      private function checkBufferReady(param1:SoundItem, param2:Number, param3:Number) : Boolean
      {
         if(param1.endTime < param2)
         {
            return true;
         }
         if(param1.startTime > param2 + AnimeConstants.MIN_TIME_TO_BUFFER)
         {
            return true;
         }
         var _loc4_:Number;
         if((_loc4_ = AnimeConstants.MIN_TIME_TO_BUFFER + param2) > param3)
         {
            _loc4_ = param3;
         }
         if(param1.isSoundBufferReadyAtTime(_loc4_ - param1.startTime))
         {
            return true;
         }
         return false;
      }
      
      private function drawDownloadStatus() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Sprite = null;
         var _loc4_:Sprite = null;
         var _loc5_:Sprite = null;
         var _loc11_:SoundItem = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:ProgressiveSoundItem = null;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:StreamSoundItem = null;
         var _loc19_:VideoStreamSoundItem = null;
         var _loc1_:String = "paper";
         _loc2_ = this._graphContainer.getChildByName(_loc1_) as Sprite;
         if(_loc2_ != null)
         {
            this._graphContainer.removeChild(_loc2_);
         }
         _loc2_ = new Sprite();
         _loc2_.name = _loc1_;
         this._graphContainer.addChild(_loc2_);
         _loc3_ = new Sprite();
         _loc4_ = new Sprite();
         _loc5_ = new Sprite();
         _loc2_.addChild(_loc3_);
         _loc2_.addChild(_loc4_);
         _loc2_.addChild(_loc5_);
         var _loc6_:Number = 15;
         var _loc7_:Number = AnimeConstants.SCREEN_WIDTH;
         var _loc8_:Number = AnimeConstants.SCREEN_HEIGHT;
         var _loc9_:Number = _loc7_ / this._movieDuration;
         var _loc10_:int = 0;
         while(_loc10_ < this._sounds.length)
         {
            _loc12_ = (_loc11_ = this._sounds.getValueByIndex(_loc10_) as SoundItem).startTime * _loc9_;
            _loc13_ = _loc10_ * _loc6_ * 1.1;
            _loc3_.graphics.beginFill(5570560,0.5);
            _loc3_.graphics.drawRect(_loc12_,_loc13_,(_loc11_.endTime - _loc11_.startTime) * _loc9_,_loc6_);
            _loc3_.graphics.endFill();
            if(_loc11_ is ProgressiveSoundItem)
            {
               if((_loc15_ = _loc11_ as ProgressiveSoundItem).sound.bytesTotal <= 0 || _loc15_.sound.bytesLoaded <= 0 || _loc15_.sound.length <= 0)
               {
                  _loc14_ = 0;
               }
               else if(_loc15_.sound.bytesLoaded >= _loc15_.sound.bytesTotal)
               {
                  _loc14_ = 1;
               }
               else if(_loc15_.sound.length >= _loc15_.endTime - _loc15_.startTime)
               {
                  _loc14_ = 1;
               }
               else
               {
                  _loc16_ = _loc15_.sound.length * _loc15_.sound.bytesTotal / _loc15_.sound.bytesLoaded;
                  if((_loc17_ = _loc15_.endTime - _loc15_.startTime) < _loc16_)
                  {
                     _loc14_ = _loc15_.sound.length / _loc17_;
                  }
                  else
                  {
                     _loc14_ = _loc15_.sound.length / _loc16_;
                  }
               }
               _loc4_.graphics.beginFill(_loc14_ >= 1?uint(16711680):uint(13421772),_loc14_ >= 1?Number(1):Number(0.5));
               _loc4_.graphics.drawRect(_loc12_,_loc13_,(_loc11_.endTime - _loc11_.startTime) * _loc9_ * _loc14_,_loc6_);
               _loc4_.graphics.endFill();
            }
            else if(_loc11_ is StreamSoundItem)
            {
               _loc18_ = _loc11_ as StreamSoundItem;
               _loc4_.graphics.beginFill(13421772,0.5);
               _loc4_.graphics.drawRect(_loc12_ + _loc18_.netStreamController.position * 1000 * _loc9_,_loc13_,_loc18_.netStreamController.bufferLength * 1000 * _loc9_,_loc6_);
               _loc4_.graphics.endFill();
            }
            else if(_loc11_ is VideoStreamSoundItem)
            {
               _loc19_ = _loc11_ as VideoStreamSoundItem;
               _loc4_.graphics.beginFill(13421772,0.5);
               _loc4_.graphics.drawRect(_loc12_ + _loc19_.videoNetStreamController.position * 1000 * _loc9_,_loc13_,_loc19_.videoNetStreamController.bufferLength * 1000 * _loc9_,_loc6_);
               _loc4_.graphics.endFill();
            }
            _loc10_++;
         }
         _loc5_.graphics.beginFill(255,1);
         _loc5_.graphics.drawRect((this._curMilliSecond + AnimeConstants.MIN_TIME_TO_BUFFER) * _loc9_,0,2,_loc8_);
         _loc5_.graphics.drawRect(this._curMilliSecond * _loc9_,0,2,_loc8_);
         _loc5_.graphics.endFill();
         _loc5_.graphics.beginFill(65280,1);
         _loc5_.graphics.drawRect((this._curMilliSecond + AnimeConstants.MIN_TIME_TO_BUFFER) * _loc9_,0,2,_loc8_);
         _loc5_.graphics.drawRect(this._curMilliSecond * _loc9_,0,2,_loc8_);
         _loc5_.graphics.endFill();
         this._timer.addEventListener(TimerEvent.TIMER,this.doDrawDownloadStatus);
      }
   }
}

import anifire.sound.NetStreamController;
import anifire.sound.SoundHelper;

class StreamSoundItem extends SoundItem
{
    
   
   private var _filename:String;
   
   private var _url:String;
   
   private var _netStreamController:NetStreamController = null;
   
   function StreamSoundItem()
   {
      super();
   }
   
   public function get filename() : String
   {
      return this._filename;
   }
   
   public function get url() : String
   {
      return this._url;
   }
   
   public function init(param1:String, param2:String, param3:NetStreamController, param4:Number, param5:Number) : void
   {
      this.startTime = param4;
      this.endTime = param5;
      this._netStreamController = param3;
      this._url = param1;
      this._filename = param2;
   }
   
   public function seek(param1:Number) : void
   {
      this._netStreamController.seek(param1);
   }
   
   public function get netStreamController() : NetStreamController
   {
      return this._netStreamController;
   }
   
   override public function isSoundBufferReadyAtTime(param1:Number) : Boolean
   {
      return SoundHelper.isStreamSoundBufferReadyAtTime(this._netStreamController,param1);
   }
   
   public function get isConnected() : Boolean
   {
      return this._netStreamController.netConnectionStatus == NetStreamController.CONNECT_STATE__CONNECTED?true:false;
   }
}

import anifire.component.CcActionLoader;
import anifire.component.CcComponentLoader;
import anifire.event.ExtraDataEvent;
import flash.events.Event;
import flash.events.IEventDispatcher;

class CcComponentItem extends SoundItem
{
    
   
   public var urlRequest:String;
   
   private var _ccActionLoader:CcActionLoader;
   
   private var _ccComponentLoader:CcComponentLoader;
   
   public var isCcComponentFullyDownloaded:Boolean;
   
   function CcComponentItem()
   {
      super();
   }
   
   override public function isSoundBufferReadyAtTime(param1:Number) : Boolean
   {
      if(this.isCcComponentFullyDownloaded)
      {
         return true;
      }
      return false;
   }
   
   public function set ccComponentLoader(param1:CcComponentLoader) : void
   {
      if(this._ccComponentLoader != null)
      {
         this._ccComponentLoader.removeEventListener(Event.COMPLETE,this.onCcComponentFullyDownloaded);
      }
      this._ccComponentLoader = param1;
      this.isCcComponentFullyDownloaded = false;
      this._ccComponentLoader.addEventListener(Event.COMPLETE,this.onCcComponentFullyDownloaded);
   }
   
   public function get ccActionLoader() : CcActionLoader
   {
      return this._ccActionLoader;
   }
   
   public function set ccActionLoader(param1:CcActionLoader) : void
   {
      this._ccActionLoader = param1;
   }
   
   private function onCcComponentFullyDownloaded(param1:Event) : void
   {
      (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onCcComponentFullyDownloaded);
      this.isCcComponentFullyDownloaded = true;
      this._ccComponentLoader.dispatchEvent(new ExtraDataEvent("FULLY_DOWNLOADED",this.ccActionLoader,this._ccComponentLoader));
   }
   
   public function get ccComponentLoader() : CcComponentLoader
   {
      return this._ccComponentLoader;
   }
   
   public function init(param1:String, param2:CcComponentLoader, param3:Number, param4:Number, param5:CcActionLoader) : void
   {
      this.startTime = param3;
      this.endTime = param4;
      this.ccComponentLoader = param2;
      this.ccActionLoader = param5;
      this.ccComponentLoader.addEventListener(Event.COMPLETE,this.onCcComponentFullyDownloaded);
      this.urlRequest = param1;
   }
}

import anifire.sound.SoundHelper;
import anifire.sound.VideoNetStreamController;

class VideoStreamSoundItem extends SoundItem
{
    
   
   private var _url:String;
   
   private var _videoNetStreamController:VideoNetStreamController = null;
   
   function VideoStreamSoundItem()
   {
      super();
   }
   
   public function init(param1:String, param2:VideoNetStreamController, param3:Number, param4:Number) : void
   {
      this.startTime = param3;
      this.endTime = param4;
      this._videoNetStreamController = param2;
      this._url = param1;
   }
   
   override public function isSoundBufferReadyAtTime(param1:Number) : Boolean
   {
      return SoundHelper.isVideoBufferReadyAtTime(this.videoNetStreamController,param1);
   }
   
   public function get isConnected() : Boolean
   {
      return this._videoNetStreamController.netConnectionStatus == VideoNetStreamController.CONNECT_STATE__CONNECTED?true:false;
   }
   
   public function seek(param1:Number) : void
   {
      this._videoNetStreamController.seek(param1);
   }
   
   public function get videoNetStreamController() : VideoNetStreamController
   {
      return this._videoNetStreamController;
   }
   
   public function get url() : String
   {
      return this._url;
   }
}

import anifire.sound.SoundHelper;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.media.Sound;
import flash.net.URLRequest;

class ProgressiveSoundItem extends SoundItem
{
    
   
   public var urlRequest:URLRequest;
   
   public var isSoundFullyDownloaded:Boolean;
   
   private var _sound:Sound = null;
   
   function ProgressiveSoundItem()
   {
      super();
   }
   
   private function onSoundFullyDownloaded(param1:Event) : void
   {
      (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundFullyDownloaded);
      this.isSoundFullyDownloaded = true;
   }
   
   public function set sound(param1:Sound) : void
   {
      if(this._sound != null)
      {
         this._sound.removeEventListener(Event.COMPLETE,this.onSoundFullyDownloaded);
      }
      this._sound = param1;
      this.isSoundFullyDownloaded = false;
      this._sound.addEventListener(Event.COMPLETE,this.onSoundFullyDownloaded);
   }
   
   public function get sound() : Sound
   {
      return this._sound;
   }
   
   public function init(param1:URLRequest, param2:Sound, param3:Number, param4:Number) : void
   {
      this.startTime = param3;
      this.endTime = param4;
      this.sound = param2;
      this.sound.addEventListener(Event.COMPLETE,this.onSoundFullyDownloaded);
      this.urlRequest = param1;
   }
   
   override public function isSoundBufferReadyAtTime(param1:Number) : Boolean
   {
      return SoundHelper.isSoundBufferReadyAtTime(this.sound,param1,this.isSoundFullyDownloaded);
   }
}

import flash.media.Sound;
import flash.net.URLRequest;

class SoundItem
{
    
   
   public var endTime:Number;
   
   public var startTime:Number;
   
   function SoundItem()
   {
      super();
   }
   
   public function createProgressiveSoundItem(param1:URLRequest, param2:Sound, param3:Number, param4:Number) : ProgressiveSoundItem
   {
      var _loc5_:ProgressiveSoundItem;
      (_loc5_ = new ProgressiveSoundItem()).init(param1,param2,param3,param4);
      return _loc5_;
   }
   
   public function isSoundBufferReadyAtTime(param1:Number) : Boolean
   {
      return false;
   }
}

import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.media.SoundLoaderContext;

class DownloadServiceProvider
{
    
   
   private var _soundItem:SoundItem = null;
   
   function DownloadServiceProvider()
   {
      super();
   }
   
   public function stopService() : void
   {
      var _loc1_:ProgressiveSoundItem = null;
      var _loc2_:VideoStreamSoundItem = null;
      if(this._soundItem is ProgressiveSoundItem)
      {
         _loc1_ = this._soundItem as ProgressiveSoundItem;
         if(_loc1_ != null)
         {
            if(_loc1_.sound != null)
            {
               if(_loc1_.sound.bytesLoaded < _loc1_.sound.bytesTotal)
               {
                  _loc1_.sound.close();
               }
            }
         }
      }
      else if(this._soundItem is VideoStreamSoundItem)
      {
         _loc2_ = this._soundItem as VideoStreamSoundItem;
         if(_loc2_.videoNetStreamController.bytesLoaded < _loc2_.videoNetStreamController.bytesTotal)
         {
            _loc2_.videoNetStreamController.close();
         }
      }
      this._soundItem = null;
   }
   
   public function destroy() : void
   {
      var _loc1_:ProgressiveSoundItem = null;
      if(this._soundItem is ProgressiveSoundItem)
      {
         _loc1_ = this._soundItem as ProgressiveSoundItem;
         if(_loc1_.sound.isBuffering)
         {
            _loc1_.sound.close();
         }
      }
   }
   
   public function startService(param1:SoundItem) : void
   {
      var _loc2_:SoundLoaderContext = null;
      var _loc3_:ProgressiveSoundItem = null;
      var _loc4_:StreamSoundItem = null;
      var _loc5_:VideoStreamSoundItem = null;
      var _loc6_:CcComponentItem = null;
      this._soundItem = param1;
      if(param1 is ProgressiveSoundItem)
      {
         _loc2_ = new SoundLoaderContext();
         _loc2_.bufferTime = 0;
         _loc3_ = this._soundItem as ProgressiveSoundItem;
         _loc3_.sound.addEventListener(IOErrorEvent.IO_ERROR,this.onSoundLoadedError);
         _loc3_.sound.load(_loc3_.urlRequest,_loc2_);
      }
      else if(param1 is StreamSoundItem)
      {
         (_loc4_ = param1 as StreamSoundItem).netStreamController.load(_loc4_.url,_loc4_.filename);
      }
      else if(param1 is VideoStreamSoundItem)
      {
         (_loc5_ = param1 as VideoStreamSoundItem).videoNetStreamController.load(_loc5_.url);
      }
      else if(param1 is CcComponentItem)
      {
         (_loc6_ = this._soundItem as CcComponentItem).ccComponentLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onSoundLoadedError);
         _loc6_.ccComponentLoader.load(_loc6_.urlRequest);
      }
   }
   
   private function onSoundLoadedError(param1:Event) : void
   {
      (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundLoadedError);
   }
   
   public function get currentCustomer() : SoundItem
   {
      return this._soundItem;
   }
   
   public function get hasCustomer() : Boolean
   {
      return this._soundItem == null?false:true;
   }
   
   public function get isCustomerBufferReady() : Boolean
   {
      return this._soundItem.isSoundBufferReadyAtTime(this._soundItem.endTime - this._soundItem.startTime);
   }
}
