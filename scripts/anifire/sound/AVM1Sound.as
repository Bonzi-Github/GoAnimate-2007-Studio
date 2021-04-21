package anifire.sound
{
   import anifire.event.AVM1ServerEvent;
   import anifire.event.AVM1SoundEvent;
   import anifire.util.UtilAVM1server;
   import flash.display.AVM1Movie;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class AVM1Sound implements IEventDispatcher
   {
      
      private static const COMMAND_SET_VOLUME:Number = 9;
      
      private static const COMMAND_GOTOANDPLAY_SOUND:Number = 5;
      
      private static const COMMAND_GOTOANDPAUSE_SOUND:Number = 4;
      
      private static const COMMAND_STOP_SOUND:Number = 8;
      
      private static const COMMAND_RESUME_SOUND:Number = 7;
      
      private static const COMMAND_PAUSE_SOUND:Number = 6;
      
      private static const COMMAND_GET_DURATION_READY:Number = 3;
      
      private static const COMMAND_GET_DURATION:Number = 2;
      
      private static const COMMAND_GET_CURRENT_POSITION:Number = 11;
      
      private static const COMMAND_NOTIFY_SOUND_COMPLETE:Number = 10;
       
      
      private var _volume:Number = 0.5;
      
      private var _prevPlayMilliSec:Number;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _prevPauseMilliSec:Number;
      
      private var _duration:Number;
      
      private var _avm1movie:AVM1Movie;
      
      private var _playHeadTimer:Timer;
      
      private var _avm1server:UtilAVM1server;
      
      public function AVM1Sound()
      {
         this._eventDispatcher = new EventDispatcher();
         super();
      }
      
      public function stop() : void
      {
         this.prevPauseMilliSec = new Date().time;
         this.prevPlayMilliSec = this.prevPauseMilliSec;
         this.playHeadTimer.reset();
         this.avm1server.sendCommand(COMMAND_STOP_SOUND,0);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function gotoAndPlay(param1:Number) : void
      {
         this.prevPlayMilliSec = new Date().time - param1;
         this.playHeadTimer.reset();
         this.playHeadTimer.delay = this.getDuration() - param1;
         this.playHeadTimer.start();
         this.avm1server.sendCommand(COMMAND_GOTOANDPLAY_SOUND,param1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      private function set prevPauseMilliSec(param1:Number) : void
      {
         this._prevPauseMilliSec = param1;
      }
      
      public function gotoAndPause(param1:Number) : void
      {
         this.prevPauseMilliSec = new Date().time;
         this.prevPlayMilliSec = this.prevPauseMilliSec - param1;
         this.playHeadTimer.reset();
         this.avm1server.sendCommand(COMMAND_GOTOANDPAUSE_SOUND,param1);
      }
      
      public function getDuration() : Number
      {
         return this._duration;
      }
      
      private function requestGetDuration() : void
      {
         this.avm1server.sendCommand(COMMAND_GET_DURATION,0);
      }
      
      private function setDuration(param1:Number) : void
      {
         this._duration = param1;
      }
      
      public function init(param1:AVM1Movie) : void
      {
         this.avm1movie = param1;
         this.avm1movie.visible = false;
         this.playHeadTimer = new Timer(1000);
         this.playHeadTimer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this.avm1server = new UtilAVM1server();
         this.avm1server.addEventListener(AVM1ServerEvent.EVENT_COMMAND_RECEIVED,this.onServerCommandReceived);
         this.avm1server.openConnection(this.avm1movie);
         this.addEventListener(AVM1SoundEvent.SOUND_DURATION_GOT,this.doDispatchInitComplete);
         this.requestGetDuration();
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      private function get avm1server() : UtilAVM1server
      {
         return this._avm1server;
      }
      
      private function set prevPlayMilliSec(param1:Number) : void
      {
         this._prevPlayMilliSec = param1;
      }
      
      public function getVolume() : Number
      {
         return this._volume;
      }
      
      public function setVolume(param1:Number) : void
      {
         this._volume = param1;
         this.avm1server.sendCommand(COMMAND_SET_VOLUME,param1);
      }
      
      private function get prevPauseMilliSec() : Number
      {
         return this._prevPauseMilliSec;
      }
      
      private function set playHeadTimer(param1:Timer) : void
      {
         this._playHeadTimer = param1;
      }
      
      private function onServerCommandReceived(param1:AVM1ServerEvent) : void
      {
         var _loc2_:AVM1SoundEvent = null;
         if(param1.command == COMMAND_GET_DURATION_READY)
         {
            this.setDuration(param1.param);
            if(this.getDuration() <= 0)
            {
               throw new Error("Duration got but is 0");
            }
            _loc2_ = new AVM1SoundEvent(AVM1SoundEvent.SOUND_DURATION_GOT,this);
            this.dispatchEvent(_loc2_);
         }
      }
      
      private function get prevPlayMilliSec() : Number
      {
         return this._prevPlayMilliSec;
      }
      
      public function resume() : void
      {
         this.prevPlayMilliSec = new Date().time;
         this.playHeadTimer.reset();
         this.playHeadTimer.delay = this.getDuration() - (this.prevPauseMilliSec - this.prevPlayMilliSec);
         this.playHeadTimer.start();
         this.avm1server.sendCommand(COMMAND_RESUME_SOUND,0);
      }
      
      private function set avm1movie(param1:AVM1Movie) : void
      {
         this._avm1movie = param1;
      }
      
      private function get playHeadTimer() : Timer
      {
         return this._playHeadTimer;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      private function doDispatchInitComplete(param1:AVM1SoundEvent) : void
      {
         this.removeEventListener(AVM1SoundEvent.SOUND_DURATION_GOT,this.doDispatchInitComplete);
         this.setVolume(this.getVolume());
         var _loc2_:AVM1SoundEvent = new AVM1SoundEvent(AVM1SoundEvent.SOUND_INIT_COMPLETE,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function get avm1movie() : AVM1Movie
      {
         return this._avm1movie;
      }
      
      public function pause() : void
      {
         this.prevPauseMilliSec = new Date().time;
         this.playHeadTimer.reset();
         this.avm1server.sendCommand(COMMAND_PAUSE_SOUND,0);
      }
      
      private function onTimer(param1:Event) : void
      {
         var _loc2_:AVM1SoundEvent = null;
         this.prevPauseMilliSec = new Date().time;
         this.prevPlayMilliSec = this.prevPauseMilliSec;
         this.playHeadTimer.reset();
         _loc2_ = new AVM1SoundEvent(AVM1SoundEvent.SOUND_COMPLETE,this);
         this.dispatchEvent(_loc2_);
      }
      
      private function set avm1server(param1:UtilAVM1server) : void
      {
         this._avm1server = param1;
      }
   }
}
