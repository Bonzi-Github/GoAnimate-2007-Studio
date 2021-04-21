package anifire.core
{
   import anifire.events.MicLevelEvent;
   import com.adobe.audio.format.WAVWriter;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.SampleDataEvent;
   import flash.events.TimerEvent;
   import flash.media.Microphone;
   import flash.media.Sound;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import mx.events.PropertyChangeEvent;
   
   public class MicRecordingHelper extends EventDispatcher
   {
      
      public static const BYTES_PER_CALLBACK:uint = 4096;
       
      
      private var CHANNEL_LENGTH:uint = 256;
      
      private var _timer:Timer;
      
      private var _soundByte:ByteArray;
      
      private var _microphone:Microphone;
      
      private var _1293667902currentPosition:uint;
      
      private var _1381423772bytesSpeed:uint;
      
      private var _recordByte:ByteArray;
      
      private var _930295060playbackSpeed:Number = 1;
      
      public var isRecording:Boolean = false;
      
      private var _soundChart:Array;
      
      private var _phase:Number;
      
      private var _pitchShiftFactor:Number = 0;
      
      public function MicRecordingHelper()
      {
         this._timer = new Timer(1000,20);
         this._soundChart = new Array();
         this._1381423772bytesSpeed = this.playbackSpeed * BYTES_PER_CALLBACK;
         super();
         this._soundByte = new ByteArray();
         this._microphone = Microphone.getMicrophone();
         if(this._microphone)
         {
            this._timer.addEventListener(TimerEvent.TIMER,function(param1:TimerEvent):void
            {
               dispatchEvent(param1);
            });
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,function(param1:TimerEvent):void
            {
               dispatchEvent(param1);
            });
            this._microphone.rate = 44;
            this._microphone.setLoopBack(false);
         }
      }
      
      public function get timer() : Timer
      {
         return this._timer;
      }
      
      private function shiftBytes(param1:ByteArray) : ByteArray
      {
         var _loc3_:Number = NaN;
         this.pitchShiftFactor = Math.floor(this.pitchShiftFactor);
         var _loc2_:Number = 0;
         if(this.pitchShiftFactor < 0)
         {
            _loc3_ = -8;
         }
         else
         {
            _loc3_ = 8;
         }
         var _loc4_:Number;
         if((_loc4_ = this.pitchShiftFactor + 10) > 10)
         {
            _loc4_ = 20 - _loc4_;
         }
         var _loc5_:ByteArray = new ByteArray();
         param1.position = 0;
         if(this.pitchShiftFactor > 0 && _loc4_ <= 8)
         {
            _loc4_--;
         }
         if(this.pitchShiftFactor > 0 && _loc4_ <= 5)
         {
            _loc4_--;
         }
         while(param1.bytesAvailable > 0)
         {
            if(_loc4_ == 10)
            {
               _loc5_.writeFloat(param1.readFloat());
               _loc5_.writeFloat(param1.readFloat());
            }
            else
            {
               _loc2_++;
               if(_loc2_ <= _loc4_)
               {
                  _loc5_.writeFloat(param1.readFloat());
                  _loc5_.writeFloat(param1.readFloat());
               }
               else
               {
                  param1.position = param1.position + _loc3_;
                  if(_loc3_ < 0)
                  {
                     _loc5_.writeFloat(param1.readFloat());
                     _loc5_.writeFloat(param1.readFloat());
                  }
                  _loc2_ = _loc2_ - _loc4_;
               }
            }
         }
         return _loc5_;
      }
      
      public function get pitchShiftFactor() : Number
      {
         return this._pitchShiftFactor;
      }
      
      public function endRecording() : void
      {
         if(!this._microphone)
         {
         }
      }
      
      public function stopRecordHandler(param1:Event = null) : void
      {
         trace("stopRec");
         this._timer.stop();
         this.isRecording = false;
         this._microphone.removeEventListener(SampleDataEvent.SAMPLE_DATA,this._microphoneSampleDataHandler);
      }
      
      private function _playSoundSampleDataHandler(param1:SampleDataEvent) : void
      {
         var _loc3_:Number = NaN;
         if(!this._recordByte.bytesAvailable > 0)
         {
            return;
         }
         var _loc2_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         while(_loc2_ < 8192)
         {
            _loc3_ = 0;
            if(this._recordByte.bytesAvailable > 0)
            {
               _loc3_ = this._recordByte.readFloat();
            }
            _loc4_.writeFloat(_loc3_);
            _loc4_.writeFloat(_loc3_);
            _loc2_++;
         }
         _loc4_ = this.shiftBytes(_loc4_);
         var _loc5_:int = 0;
         _loc4_.position = 0;
         while(_loc5_ < _loc4_.bytesAvailable)
         {
            param1.data.writeFloat(_loc4_.readFloat());
            _loc5_++;
         }
      }
      
      private function set playbackSpeed(param1:Number) : void
      {
         var _loc2_:Object = this._930295060playbackSpeed;
         if(_loc2_ !== param1)
         {
            this._930295060playbackSpeed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playbackSpeed",_loc2_,param1));
         }
      }
      
      public function set pitchShiftFactor(param1:Number) : void
      {
         this._pitchShiftFactor = param1;
      }
      
      public function startRecHandler() : void
      {
         trace("startRec");
         this.isRecording = true;
         this._recordByte = new ByteArray();
         this._microphone.addEventListener(SampleDataEvent.SAMPLE_DATA,this._microphoneSampleDataHandler);
         this._timer.reset();
         this._timer.start();
      }
      
      public function getWaveByteArray() : ByteArray
      {
         var _loc1_:WAVWriter = null;
         var _loc2_:ByteArray = null;
         if(this._recordByte != null && this._recordByte.length > 0)
         {
            _loc1_ = new WAVWriter();
            _loc1_.numOfChannels = 1;
            this._recordByte = this.shiftBytes(this._recordByte);
            this._recordByte.position = 0;
            _loc2_ = new ByteArray();
            _loc1_.processSamples(_loc2_,this._recordByte,_loc1_.samplingRate,1);
            return _loc2_;
         }
         return null;
      }
      
      public function playRecordHandler() : void
      {
         var _loc1_:Sound = null;
         if(this._recordByte)
         {
            this._recordByte.position = 0;
            _loc1_ = new Sound();
            _loc1_.addEventListener(SampleDataEvent.SAMPLE_DATA,this._playSoundSampleDataHandler);
            _loc1_.play();
         }
      }
      
      public function microphone() : Microphone
      {
         return this._microphone;
      }
      
      [Bindable(event="propertyChange")]
      private function get bytesSpeed() : uint
      {
         return this._1381423772bytesSpeed;
      }
      
      [Bindable(event="propertyChange")]
      private function get playbackSpeed() : Number
      {
         return this._930295060playbackSpeed;
      }
      
      private function _microphoneSampleDataHandler(param1:SampleDataEvent) : void
      {
         this._recordByte.writeBytes(param1.data);
         this.dispatchMicSampleEvent(this._microphone.activityLevel);
      }
      
      [Bindable(event="propertyChange")]
      private function get currentPosition() : uint
      {
         return this._1293667902currentPosition;
      }
      
      private function set currentPosition(param1:uint) : void
      {
         var _loc2_:Object = this._1293667902currentPosition;
         if(_loc2_ !== param1)
         {
            this._1293667902currentPosition = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentPosition",_loc2_,param1));
         }
      }
      
      private function dispatchMicSampleEvent(param1:Number) : void
      {
         var _loc2_:MicLevelEvent = new MicLevelEvent(MicLevelEvent.ACTIVITY_LEVEL,this);
         _loc2_.level = param1;
         dispatchEvent(_loc2_);
      }
      
      private function set bytesSpeed(param1:uint) : void
      {
         var _loc2_:Object = this._1381423772bytesSpeed;
         if(_loc2_ !== param1)
         {
            this._1381423772bytesSpeed = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bytesSpeed",_loc2_,param1));
         }
      }
   }
}
