package anifire.core.sound
{
   import anifire.event.AVM1SoundEvent;
   import anifire.sound.AVM1Sound;
   import anifire.timeline.SoundContainer;
   import anifire.util.UtilCrypto;
   import flash.display.AVM1Movie;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   
   public class EmbedSound extends EventDispatcher implements ISoundable
   {
       
      
      private var _isReadyToPlay:Boolean = false;
      
      private var _soundContainer:SoundContainer;
      
      private var _isNeedErrorByteCheck:Boolean;
      
      private var _avm1Sound:AVM1Sound;
      
      private var _byteArray:ByteArray = null;
      
      private var _isNeedDecryption:Boolean = false;
      
      public function EmbedSound()
      {
         super();
      }
      
      public function stop() : void
      {
         if(this._avm1Sound != null)
         {
            this._avm1Sound.stop();
            this.stopIndicator();
         }
      }
      
      public function play(param1:Number = 0, param2:SoundContainer = null) : void
      {
         this._avm1Sound.addEventListener(AVM1SoundEvent.SOUND_COMPLETE,this.doSayPlayComplete);
         this._avm1Sound.gotoAndPlay(param1);
         this.soundContainer = param2;
         this.startIndicator(param1);
      }
      
      public function getDuration() : Number
      {
         return this._avm1Sound.getDuration();
      }
      
      private function doSayPlayComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doSayPlayComplete);
         this.dispatchEvent(new SoundEvent(SoundEvent.PLAY_COMPLETE,this));
      }
      
      private function doInitAVMsound(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doInitAVMsound);
         this._avm1Sound = new AVM1Sound();
         this._avm1Sound.addEventListener(AVM1SoundEvent.SOUND_INIT_COMPLETE,this.doDispatchCompleteEvent);
         this._avm1Sound.init(LoaderInfo(param1.target).content as AVM1Movie);
      }
      
      private function startIndicator(param1:Number = 0) : void
      {
         if(this.soundContainer != null)
         {
            this.soundContainer.startIndicator(param1);
         }
      }
      
      private function doReplicateEvent(param1:Event) : void
      {
         this.dispatchEvent(param1.clone());
      }
      
      private function doInitByByteArray(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:ByteArray = null;
         var _loc5_:UtilCrypto = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doInitByByteArray);
         var _loc2_:URLStream = URLStream(param1.target);
         if(this._isNeedErrorByteCheck)
         {
            _loc3_ = _loc2_.readByte();
            if(_loc3_ != 0)
            {
               _loc4_ = new ByteArray();
               _loc2_.readBytes(_loc4_);
            }
         }
         this._byteArray = new ByteArray();
         _loc2_.readBytes(this._byteArray);
         if(this._isNeedDecryption)
         {
            (_loc5_ = new UtilCrypto()).decrypt(this._byteArray);
         }
         this.initByByteArray(this._byteArray);
      }
      
      public function getIsReadyToPlay() : Boolean
      {
         return this._isReadyToPlay;
      }
      
      public function initByUrl(param1:URLRequest, param2:Boolean, param3:Boolean) : void
      {
         if(this._byteArray != null)
         {
            this.initByByteArray(this._byteArray);
            return;
         }
         this._isNeedErrorByteCheck = param2;
         this._isNeedDecryption = param3;
         var _loc4_:URLStream;
         (_loc4_ = new URLStream()).addEventListener(Event.COMPLETE,this.doInitByByteArray);
         _loc4_.addEventListener(ProgressEvent.PROGRESS,this.doReplicateEvent);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.doReplicateEvent);
         _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doReplicateEvent);
         _loc4_.load(param1);
      }
      
      public function initByByteArray(param1:ByteArray) : void
      {
         var loader:Loader = null;
         var byteArray:ByteArray = param1;
         try
         {
            this._byteArray = byteArray;
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.doInitAVMsound);
            loader.loadBytes(byteArray as ByteArray);
         }
         catch(e:Error)
         {
            trace(e.message);
         }
      }
      
      public function set soundContainer(param1:SoundContainer) : void
      {
         this._soundContainer = param1;
      }
      
      public function clone() : ISoundable
      {
         var _loc1_:EmbedSound = new EmbedSound();
         _loc1_._isNeedErrorByteCheck = this._isNeedErrorByteCheck;
         _loc1_._isNeedDecryption = this._isNeedDecryption;
         _loc1_._byteArray = this._byteArray;
         return _loc1_;
      }
      
      private function stopIndicator() : void
      {
         if(this.soundContainer != null)
         {
            this.soundContainer.stopIndicator();
         }
      }
      
      public function get byteArray() : ByteArray
      {
         return this._byteArray;
      }
      
      public function get soundContainer() : SoundContainer
      {
         return this._soundContainer;
      }
      
      private function doDispatchCompleteEvent(param1:AVM1SoundEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doDispatchCompleteEvent);
         var _loc2_:SoundEvent = new SoundEvent(SoundEvent.READY_TO_PLAY,this);
         this._isReadyToPlay = true;
         this.dispatchEvent(_loc2_);
      }
   }
}
