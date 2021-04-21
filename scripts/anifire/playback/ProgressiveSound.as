package anifire.playback
{
   import anifire.component.DownloadManager;
   import anifire.constant.AnimeConstants;
   import anifire.core.AssetLinkage;
   import anifire.event.AVM2SoundEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.sound.SoundHelper;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class ProgressiveSound extends AnimeSound
   {
      
      private static var STATE_PLAYING:int = 1;
      
      private static var STATE_NULL:int = 0;
      
      private static var STATE_PAUSED:int = 2;
       
      
      private var _sound:Sound;
      
      private var _state:int;
      
      private var _isSoundCompletelyDownload:Boolean;
      
      private var _soundChannel:SoundChannel;
      
      private var _currentPlayingMilliSecond:Number;
      
      private var _skipSpeechDispatch:Boolean = false;
      
      private var _soundTransform:SoundTransform;
      
      public function ProgressiveSound()
      {
         super();
      }
      
      private function set soundTransform(param1:SoundTransform) : void
      {
         this._soundTransform = param1;
      }
      
      override public function initDependency(param1:Number, param2:Number, param3:DownloadManager) : void
      {
         var _loc4_:URLRequest = null;
         super.initDependency(param1,param2,param3);
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(this.file);
         var _loc6_:String = UtilXmlInfo.getThumbIdFromFileName(this.file);
         _loc4_ = UtilNetwork.getGetSoundAssetRequest(_loc5_,_loc6_,AnimeConstants.DOWNLOAD_TYPE_PROGRESSIVE);
         this.sound = param3.registerSoundChannel(_loc4_,this.startMilliSec,this.endMilliSec);
         this.soundTransform = new SoundTransform(this.volume * this.fadeFactor * this.inner_volume);
         this.fadeVolumeBySubtype(this.startMilliSec);
      }
      
      override public function getBufferProgress() : Number
      {
         return 100;
      }
      
      override public function resume() : void
      {
         if(SoundHelper.isSoundBufferReadyAtTime(this.sound,this._currentPlayingMilliSecond - this.startMilliSec,this.isSoundCompletelyDownload))
         {
            this.soundChannel = this.sound.play((this._currentPlayingMilliSecond - this.startMilliSec) % this.sound.length,int.MAX_VALUE,this.soundTransform);
            if(!this.isSoundCompletelyDownload)
            {
               SoundHelper.addBufferExhaustEventListenerToSoundChannel(this.soundChannel,this.sound,this.startMilliSec,this.endMilliSec,this.onBufferExhaust);
            }
            this.state = STATE_PLAYING;
         }
         else
         {
            this.dispatchEvent(new AVM2SoundEvent(AVM2SoundEvent.BUFFER_EXHAUST,this));
         }
      }
      
      override public function goToAndPause(param1:Number) : void
      {
         this._currentPlayingMilliSecond = param1;
         if(this.soundChannel != null)
         {
            this.soundChannel.removeEventListener(AVM2SoundEvent.BUFFER_EXHAUST,this.onBufferExhaust);
            this.soundChannel.stop();
            this.soundChannel = null;
         }
         this.state = STATE_PAUSED;
      }
      
      private function dispatchBufferExhaustEvent(param1:Number) : void
      {
         this._currentPlayingMilliSecond = param1;
         this.dispatchEvent(new AVM2SoundEvent(PlayerEvent.BUFFER_EXHAUST,this));
      }
      
      override public function play(param1:Number) : void
      {
         var samples:ByteArray = null;
         var extract:Number = NaN;
         var lng:Number = NaN;
         var step:Number = NaN;
         var left:Number = NaN;
         var right:Number = NaN;
         var total:Number = NaN;
         var c:int = 0;
         var event:SpeechPitchEvent = null;
         var curMilliSec:Number = param1;
         var loopSound:int = !!speechData?0:int(int.MAX_VALUE);
         if(this._state != STATE_PLAYING)
         {
            if(SoundHelper.isSoundBufferReadyAtTime(this.sound,curMilliSec - this.startMilliSec,this.isSoundCompletelyDownload))
            {
               this.soundChannel = this.sound.play((curMilliSec - this.startMilliSec) % this.sound.length,loopSound,this.soundTransform);
               if(!this.isSoundCompletelyDownload)
               {
                  SoundHelper.addBufferExhaustEventListenerToSoundChannel(this.soundChannel,this.sound,this.startMilliSec,this.endMilliSec,this.onBufferExhaust);
               }
               this.state = STATE_PLAYING;
            }
            else
            {
               this._currentPlayingMilliSecond = curMilliSec;
               this.dispatchBufferExhaustEvent(curMilliSec);
            }
         }
         else
         {
            this.fadeVolumeBySubtype(curMilliSec);
         }
         if(speechData)
         {
            samples = new ByteArray();
            extract = Math.floor(1 / AnimeConstants.FRAME_PER_SEC * 44100);
            lng = this.sound.extract(samples,extract);
            samples.position = 0;
            step = 64;
            total = 0;
            try
            {
               c = 0;
               while(c < 56)
               {
                  left = samples.readFloat() * 128;
                  right = samples.readFloat() * 128;
                  left = Math.abs(left);
                  right = Math.abs(right);
                  total = total + (left + right);
                  samples.position = c * step;
                  c++;
               }
            }
            catch(e:Error)
            {
            }
            if(!this._skipSpeechDispatch)
            {
               event = new SpeechPitchEvent(SpeechPitchEvent.PITCH);
               event.sceneId = AssetLinkage.getSceneIdFromLinkage(speechData);
               event.charId = AssetLinkage.getCharIdFromLinkage(speechData);
               event.soundId = this.id;
               event.value = total;
               this.dispatchEvent(event);
            }
            this._skipSpeechDispatch = !this._skipSpeechDispatch;
            if(samples.bytesAvailable == 0)
            {
               this.sound.extract(samples,1,0);
            }
         }
      }
      
      private function get sound() : Sound
      {
         return this._sound;
      }
      
      private function get state() : Number
      {
         return this._state;
      }
      
      private function get isSoundCompletelyDownload() : Boolean
      {
         return this._isSoundCompletelyDownload;
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
      
      override public function setVolume(param1:Number) : void
      {
         this.volume = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         if(this.soundChannel !== null)
         {
            this.soundChannel.soundTransform = this.soundTransform;
         }
      }
      
      private function get soundTransform() : SoundTransform
      {
         return this._soundTransform;
      }
      
      private function set sound(param1:Sound) : void
      {
         if(this.sound != null)
         {
            this.sound.removeEventListener(Event.COMPLETE,this.onSoundCompletelyDownloaded);
         }
         this.isSoundCompletelyDownload = false;
         this._sound = param1;
         this.sound.addEventListener(Event.COMPLETE,this.onSoundCompletelyDownloaded);
      }
      
      private function set state(param1:Number) : void
      {
         this._state = param1;
      }
      
      private function processSound(param1:Event) : void
      {
         trace("event:" + param1);
      }
      
      private function onBufferExhaust(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onBufferExhaust);
         this.dispatchBufferExhaustEvent(this.soundChannel.position);
      }
      
      private function onSoundCompletelyDownloaded(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onSoundCompletelyDownloaded);
         this.isSoundCompletelyDownload = true;
      }
      
      private function set soundChannel(param1:SoundChannel) : void
      {
         this._soundChannel = param1;
      }
      
      private function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      private function set isSoundCompletelyDownload(param1:Boolean) : void
      {
         this._isSoundCompletelyDownload = param1;
      }
      
      override public function fadeVolume(param1:Number) : void
      {
         this.fadeFactor = param1;
         this.soundTransform.volume = this.fadeFactor * this.volume * this.inner_volume;
         if(this.soundChannel !== null)
         {
            this.soundChannel.soundTransform = this.soundTransform;
         }
      }
      
      override public function pause(param1:Number) : void
      {
         if(this.soundChannel != null)
         {
            this._currentPlayingMilliSecond = this.soundChannel.position + this.startMilliSec;
            this.soundChannel.removeEventListener(AVM2SoundEvent.BUFFER_EXHAUST,this.onBufferExhaust);
            this.soundChannel.stop();
            this.soundChannel = null;
         }
         this.state = STATE_PAUSED;
      }
   }
}
