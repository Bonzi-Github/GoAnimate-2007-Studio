package anifire.core.sound
{
   import anifire.event.AVM1SoundEvent;
   import anifire.sound.AVM1Sound;
   import flash.display.AVM1Movie;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public class ImporterSoundAsset extends EventDispatcher
   {
       
      
      private var _isReadyToPlay:Boolean = false;
      
      private var _avm1Sound:AVM1Sound;
      
      private var _byteArray:ByteArray = null;
      
      public function ImporterSoundAsset()
      {
         super();
      }
      
      private function doInitAVMsound(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doInitAVMsound);
         this._avm1Sound = new AVM1Sound();
         this._avm1Sound.addEventListener(AVM1SoundEvent.SOUND_INIT_COMPLETE,this.doDispatchCompleteEvent);
         this._avm1Sound.init(LoaderInfo(param1.target).content as AVM1Movie);
      }
      
      public function stop() : void
      {
         if(this._avm1Sound != null)
         {
            this._avm1Sound.stop();
         }
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
      
      public function getDuration() : Number
      {
         return this._avm1Sound.getDuration();
      }
      
      private function doSayPlayComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doSayPlayComplete);
         this.dispatchEvent(new SoundEvent(SoundEvent.PLAY_COMPLETE,this));
      }
      
      public function get byteArray() : ByteArray
      {
         return this._byteArray;
      }
      
      public function play(param1:Number = 0) : void
      {
         this._avm1Sound.addEventListener(AVM1SoundEvent.SOUND_COMPLETE,this.doSayPlayComplete);
         this._avm1Sound.gotoAndPlay(param1);
      }
      
      private function doDispatchCompleteEvent(param1:AVM1SoundEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doDispatchCompleteEvent);
         var _loc2_:SoundEvent = new SoundEvent(SoundEvent.READY_TO_PLAY,this);
         this._isReadyToPlay = true;
         this.dispatchEvent(_loc2_);
      }
      
      public function getIsReadyToPlay() : Boolean
      {
         return this._isReadyToPlay;
      }
   }
}
