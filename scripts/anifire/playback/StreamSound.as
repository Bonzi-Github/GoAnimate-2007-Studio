package anifire.playback
{
   import anifire.component.DownloadManager;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.AVM2SoundEvent;
   import anifire.sound.NetStreamController;
   import anifire.sound.SoundHelper;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
   public class StreamSound extends AnimeSound
   {
      
      private static var STATE_PLAYING:int = 1;
      
      private static var STATE_NULL:int = 0;
      
      private static var STATE_PAUSED:int = 2;
       
      
      private var _state:int;
      
      private var _isSoundCompletelyDownload:Boolean;
      
      private var _soundChannel:SoundChannel;
      
      private var _alreadyRepeatedAtMilliSec:Number = 0;
      
      private var _currentPlayingMilliSecond:Number;
      
      private var _netStreamController:NetStreamController;
      
      private var _soundTransform:SoundTransform;
      
      public function StreamSound()
      {
         super();
      }
      
      private function set soundTransform(param1:SoundTransform) : void
      {
         this._soundTransform = param1;
      }
      
      override public function goToAndPause(param1:Number) : void
      {
         this._currentPlayingMilliSecond = param1;
         this.netStreamController.pause();
         var _loc2_:Number = (param1 - this.startMilliSec) % (this.netStreamController.duration_in_second * 1000) / 1000;
         this.netStreamController.seek(_loc2_);
         this.state = STATE_PAUSED;
      }
      
      override public function getBufferProgress() : Number
      {
         return 100;
      }
      
      override public function resume() : void
      {
         if(SoundHelper.isStreamSoundBufferReadyAtTime(this.netStreamController,this._currentPlayingMilliSecond - this.startMilliSec))
         {
            this.netStreamController.resume();
            this.state = STATE_PLAYING;
         }
         else
         {
            this.dispatchBufferExhaustEvent(this._currentPlayingMilliSecond);
         }
      }
      
      private function dispatchBufferExhaustEvent(param1:Number) : void
      {
         this._currentPlayingMilliSecond = param1;
         this.dispatchEvent(new AVM2SoundEvent(PlayerEvent.BUFFER_EXHAUST,this));
      }
      
      override public function play(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this._state != STATE_PLAYING)
         {
            if(SoundHelper.isStreamSoundBufferReadyAtTime(this.netStreamController,param1 - this.startMilliSec))
            {
               this.netStreamController.seek((param1 - this.startMilliSec) % (this.netStreamController.duration_in_second * 1000) / 1000);
               this.netStreamController.resume();
               this.state = STATE_PLAYING;
            }
            else
            {
               this._currentPlayingMilliSecond = param1;
               this.dispatchBufferExhaustEvent(param1);
            }
         }
         else
         {
            _loc2_ = (param1 - this.startMilliSec) / 1000 % this.netStreamController.duration_in_second;
            if(_loc2_ < this.netStreamController.duration_in_second && this.netStreamController.duration_in_second - _loc2_ < 0.2)
            {
               if(Math.abs(this._alreadyRepeatedAtMilliSec - param1) > 1000)
               {
                  this._alreadyRepeatedAtMilliSec = param1;
                  this.netStreamController.seek(0);
               }
            }
            else
            {
               this._alreadyRepeatedAtMilliSec = 0;
            }
            this.fadeVolumeBySubtype(param1);
         }
      }
      
      override public function init(param1:XML, param2:UtilHashArray, param3:String, param4:PlayerDataStock) : Boolean
      {
         if(!super.init(param1,param2,param3,param4))
         {
            return false;
         }
         this.state = STATE_NULL;
         return true;
      }
      
      private function get state() : Number
      {
         return this._state;
      }
      
      private function get isSoundCompletelyDownload() : Boolean
      {
         return this._isSoundCompletelyDownload;
      }
      
      override public function setVolume(param1:Number) : void
      {
         this.volume = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         this.netStreamController.soundTransform = this.soundTransform;
      }
      
      private function onSoundCompletelyDownloaded(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundCompletelyDownloaded);
         this.isSoundCompletelyDownload = true;
      }
      
      private function set state(param1:Number) : void
      {
         this._state = param1;
      }
      
      public function get position() : Number
      {
         return this.netStreamController.position;
      }
      
      private function get soundTransform() : SoundTransform
      {
         return this._soundTransform;
      }
      
      private function set netStreamController(param1:NetStreamController) : void
      {
         this._netStreamController = param1;
      }
      
      private function set isSoundCompletelyDownload(param1:Boolean) : void
      {
         this._isSoundCompletelyDownload = param1;
      }
      
      override public function fadeVolume(param1:Number) : void
      {
         this.fadeFactor = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         this.netStreamController.soundTransform = this.soundTransform;
      }
      
      private function get netStreamController() : NetStreamController
      {
         return this._netStreamController;
      }
      
      override public function initDependency(param1:Number, param2:Number, param3:DownloadManager) : void
      {
         var _loc4_:URLRequest = null;
         super.initDependency(param1,param2,param3);
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(this.file);
         var _loc6_:String = UtilXmlInfo.getThumbIdFromFileName(this.file);
         _loc4_ = UtilNetwork.getGetSoundAssetRequest(_loc5_,_loc6_,AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE);
         this.netStreamController = param3.registerNetStream(ServerConstants.ACTION_GET_STREAM_SOUND,_loc6_,this.startMilliSec,this.endMilliSec,this.durationInMillisec / 1000);
         this.soundTransform = new SoundTransform(this.volume * this.fadeFactor * this.inner_volume);
         this.fadeVolumeBySubtype(this.startMilliSec);
      }
      
      override public function pause(param1:Number) : void
      {
         this._currentPlayingMilliSecond = param1;
         this.netStreamController.pause();
         this.state = STATE_PAUSED;
      }
   }
}
