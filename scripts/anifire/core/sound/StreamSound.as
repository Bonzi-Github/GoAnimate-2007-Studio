package anifire.core.sound
{
   import anifire.constant.ServerConstants;
   import anifire.event.NetStreamClientEvent;
   import anifire.sound.NetStreamClient;
   import anifire.timeline.SoundContainer;
   import anifire.util.UtilCrypto;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.NetStatusEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.NetConnection;
   import flash.net.NetStream;
   
   public class StreamSound extends EventDispatcher implements ISoundable
   {
       
      
      private var _duration:Number;
      
      private var _netStream:NetStream;
      
      private var _sound:Sound;
      
      private var _soundContainer:SoundContainer;
      
      private var _soundChannel:SoundChannel;
      
      private var _netConnect:NetConnection;
      
      private var _url:String;
      
      private var _playhead:Number;
      
      private var _filename:String;
      
      public function StreamSound(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function stop() : void
      {
         if(this._netStream != null)
         {
            this._netStream.pause();
            this._netStream.close();
            this._netStream = null;
         }
         if(this._netConnect != null)
         {
            this._netConnect.close();
            this._netConnect = null;
         }
         this.stopIndicator();
      }
      
      public function getDuration() : Number
      {
         return this._duration;
      }
      
      private function doSayPlayComplete(param1:NetStreamClientEvent) : void
      {
         if(param1.infoObject.code == "NetStream.Play.Complete")
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doSayPlayComplete);
            this.dispatchEvent(new SoundEvent(SoundEvent.PLAY_COMPLETE,this));
         }
      }
      
      private function stopIndicator() : void
      {
         if(this.soundContainer != null)
         {
            this.soundContainer.stopIndicator();
         }
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
      
      public function init(param1:String, param2:String, param3:Number) : void
      {
         this._url = param1;
         this._filename = param2;
         this._duration = param3;
         this.dispatchEvent(new SoundEvent(SoundEvent.READY_TO_PLAY,this));
      }
      
      private function netStatusHandler(param1:NetStatusEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:NetStreamClient = null;
         var _loc4_:UtilCrypto = null;
         var _loc5_:String = null;
         if(param1.info.code == "NetConnection.Connect.Success")
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.netStatusHandler);
            _loc2_ = param1.info.secureToken;
            if(_loc2_ != null)
            {
               _loc5_ = (_loc4_ = new UtilCrypto(UtilCrypto.MODE_DECRYPT_RTMPE_TOKEN)).decryptString(_loc2_);
               this._netConnect.call("secureTokenResponse",null,_loc5_);
            }
            this._netStream = new NetStream(this._netConnect);
            this._netStream.bufferTime = 1;
            _loc3_ = new NetStreamClient();
            _loc3_.addEventListener(NetStreamClientEvent.PLAY_STATUS_READY,this.doSayPlayComplete);
            this._netStream.client = _loc3_;
            this._netStream.play("mp3:" + this._filename);
            this._netStream.seek(this._playhead / 1000);
            this.startIndicator(this._playhead);
         }
      }
      
      public function set soundContainer(param1:SoundContainer) : void
      {
         this._soundContainer = param1;
      }
      
      public function get soundContainer() : SoundContainer
      {
         return this._soundContainer;
      }
      
      public function play(param1:Number = 0, param2:SoundContainer = null) : void
      {
         this._netConnect = new NetConnection();
         this._netConnect.addEventListener(NetStatusEvent.NET_STATUS,this.netStatusHandler);
         this._netConnect.connect(ServerConstants.ACTION_GET_STREAM_SOUND);
         this._playhead = param1;
         this.soundContainer = param2;
      }
      
      public function clone() : ISoundable
      {
         var _loc1_:StreamSound = new StreamSound();
         _loc1_._url = this._url;
         _loc1_._filename = this._filename;
         _loc1_._duration = this._duration;
         return _loc1_;
      }
   }
}
