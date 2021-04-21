package anifire.core.sound
{
   import anifire.timeline.SoundContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.URLRequest;
   
   public class ProgressiveSound extends EventDispatcher implements ISoundable
   {
       
      
      private var _sound:Sound;
      
      private var _soundContainer:SoundContainer;
      
      private var _soundChannel:SoundChannel;
      
      private var _duration:Number;
      
      private var _urlRequest:URLRequest;
      
      public function ProgressiveSound(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function stop() : void
      {
         if(this._soundChannel != null)
         {
            this._soundChannel.stop();
            this.stopIndicator();
            if(this._sound.bytesLoaded < this._sound.bytesTotal)
            {
               this._sound.close();
            }
            this._soundChannel = null;
         }
      }
      
      public function getDuration() : Number
      {
         return this._duration;
      }
      
      private function doSayPlayComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doSayPlayComplete);
         this.dispatchEvent(new SoundEvent(SoundEvent.PLAY_COMPLETE,this));
      }
      
      public function getIsReadyToPlay() : Boolean
      {
         return true;
      }
      
      private function startIndicator(param1:Number = 0) : void
      {
         if(this.soundContainer != null)
         {
            this.soundContainer.startIndicator(param1);
         }
      }
      
      public function init(param1:URLRequest, param2:Number) : void
      {
         this._urlRequest = param1;
         this._duration = param2;
         var _loc3_:Sound = new Sound();
         this.dispatchEvent(new SoundEvent(SoundEvent.READY_TO_PLAY,this));
      }
      
      private function onInitProgress(param1:ProgressEvent) : void
      {
         var _loc2_:Sound = param1.target as Sound;
         if(_loc2_.bytesLoaded >= _loc2_.bytesTotal)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitProgress);
            this.dispatchEvent(new SoundEvent(SoundEvent.READY_TO_PLAY,this));
         }
         else if(_loc2_.bytesLoaded >= 15 * 1024)
         {
            _loc2_.close();
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitProgress);
            this.dispatchEvent(new SoundEvent(SoundEvent.READY_TO_PLAY,this));
         }
      }
      
      public function set soundContainer(param1:SoundContainer) : void
      {
         this._soundContainer = param1;
      }
      
      private function onLoadSoundFail(param1:IOErrorEvent) : void
      {
      }
      
      public function clone() : ISoundable
      {
         var _loc1_:ProgressiveSound = new ProgressiveSound();
         _loc1_._urlRequest = this._urlRequest;
         _loc1_._duration = this._duration;
         return _loc1_;
      }
      
      public function get soundContainer() : SoundContainer
      {
         return this._soundContainer;
      }
      
      public function play(param1:Number = 0, param2:SoundContainer = null) : void
      {
         this._sound = new Sound();
         this._sound.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadSoundFail);
         this._sound.load(this._urlRequest);
         this._soundChannel = this._sound.play(param1);
         this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.doSayPlayComplete);
         this.soundContainer = param2;
         this.startIndicator(param1);
      }
      
      private function stopIndicator() : void
      {
         if(this.soundContainer != null)
         {
            this.soundContainer.stopIndicator();
         }
      }
   }
}
