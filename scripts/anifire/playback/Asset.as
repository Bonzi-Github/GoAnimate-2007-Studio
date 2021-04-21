package anifire.playback
{
   import anifire.color.SelectedColor;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public class Asset implements IEventDispatcher
   {
       
      
      private var _data:ByteArray;
      
      protected var _edtime:Number;
      
      private var _sound:Sound;
      
      protected var _edzoom:Number;
      
      protected var _state:int;
      
      private var _zOrder:int;
      
      protected var _bundle:DisplayObjectContainer;
      
      protected var _xs:Array;
      
      public var isPlaying:Boolean = false;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _customColor:UtilHashArray;
      
      protected var _ys:Array;
      
      private var _id:String;
      
      private var _parentScene:AnimeScene;
      
      protected var _sttime:Number;
      
      protected var _stzoom:Number;
      
      private var _soundChannel:SoundChannel;
      
      private var _currSoundPos:Number = 0;
      
      protected var _x:Number = 47;
      
      protected var _y:Number = 24;
      
      public function Asset()
      {
         this._xs = new Array();
         this._ys = new Array();
         this._eventDispatcher = new EventDispatcher();
         super();
      }
      
      public static function reArrangeZorder(param1:Array) : void
      {
         var curAsset:Asset = null;
         var assets:Array = param1;
         var compareZorder:Function = function(param1:Asset, param2:Asset):int
         {
            if(param1.getZorder() < param2.getZorder())
            {
               return -1;
            }
            if(param1.getZorder() > param2.getZorder())
            {
               return 1;
            }
            return 0;
         };
         assets.sort(compareZorder);
         var i:int = 0;
         while(i < assets.length)
         {
            curAsset = assets[i] as Asset;
            curAsset.setZorder(i);
            i++;
         }
      }
      
      public function get customColor() : UtilHashArray
      {
         return this._customColor;
      }
      
      public function get parentScene() : AnimeScene
      {
         return this._parentScene;
      }
      
      public function set parentScene(param1:AnimeScene) : void
      {
         this._parentScene = param1;
      }
      
      public function get edzoom() : Number
      {
         return this._edzoom;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      public function get currSoundPos() : Number
      {
         return this._currSoundPos;
      }
      
      public function addCustomColor(param1:String, param2:SelectedColor) : void
      {
         this._customColor.push(param1,param2);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      protected function setBundle(param1:DisplayObjectContainer) : void
      {
         this._bundle = param1;
      }
      
      private function setZorder(param1:int) : void
      {
         this._zOrder = param1;
      }
      
      public function set sound(param1:Sound) : void
      {
         this._sound = param1;
      }
      
      public function setVolume(param1:Number) : void
      {
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         this.pause();
         if(param1)
         {
            this.setBundle(null);
         }
      }
      
      public function get data() : ByteArray
      {
         return this._data;
      }
      
      public function getZorder() : int
      {
         return this._zOrder;
      }
      
      public function get sttime() : Number
      {
         return this._sttime;
      }
      
      public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         PlayerConstant.goToAndStopFamily(this.getBundle(),param1);
      }
      
      public function getEventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get stzoom() : Number
      {
         return this._stzoom;
      }
      
      public function resume() : void
      {
         PlayerConstant.playFamily(this.getBundle());
      }
      
      public function set currSoundPos(param1:Number) : void
      {
         this._currSoundPos = param1;
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      protected function initAsset(param1:String, param2:int, param3:AnimeScene) : void
      {
         this.id = param1;
         this.setZorder(param2);
         this.parentScene = param3;
         this._bundle = new Sprite();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      private function repeatMusic(param1:Event) : void
      {
         if(this.soundChannel.hasEventListener(Event.SOUND_COMPLETE))
         {
            trace("******Repeat Music");
            this.isPlaying = false;
            this.soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
            this.playMusic(0,0,this.soundChannel.soundTransform);
         }
      }
      
      protected function setState(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:UtilHashArray = null;
         var _loc4_:SelectedColor = null;
         this._state = param1;
         if(this.customColor != null && param1 != Character.STATE_NULL && param1 != Background.STATE_NULL)
         {
            _loc3_ = new UtilHashArray();
            _loc2_ = 0;
            while(_loc2_ < this.customColor.length)
            {
               _loc4_ = SelectedColor(this.customColor.getValueByIndex(_loc2_));
               UtilColor.setAssetPartColor(this._bundle,_loc4_.areaName,_loc4_.dstColor);
               _loc2_++;
            }
         }
      }
      
      public function playMusic(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : void
      {
         var _loc4_:String = null;
         if(this.isPlaying == false)
         {
            if(this.sound != null)
            {
               if(param1 == this.sound.length || param1 < 0)
               {
                  param1 = 0;
               }
               if(this is Character)
               {
                  if((this as Character).state == 1)
                  {
                     _loc4_ = "action";
                  }
                  else if((this as Character).state == 2)
                  {
                     _loc4_ = "motion";
                  }
                  trace("**********************************************************");
                  trace("%%%%%%%% Playing sound for " + this.id + " State: " + _loc4_ + " Start scene frame at: " + (this as Character).parentScene.getStartFrame());
                  trace("**********************************************************");
               }
               this.isPlaying = true;
               this.soundChannel = this.sound.play(param1,param2,param3);
               trace("sndTransform volume: " + this.soundChannel.soundTransform.volume);
               if(!this.soundChannel.hasEventListener(Event.SOUND_COMPLETE))
               {
                  this.soundChannel.addEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
               }
            }
         }
      }
      
      public function stopMusic(param1:Boolean = false) : void
      {
         var _loc2_:String = null;
         if(this.soundChannel != null)
         {
            if(this.soundChannel.hasEventListener(Event.SOUND_COMPLETE))
            {
               this.soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
            }
            this.soundChannel.stop();
            if(this is Character)
            {
               if((this as Character).state == 1)
               {
                  _loc2_ = "action";
               }
               else if((this as Character).state == 2)
               {
                  _loc2_ = "motion";
               }
               trace("**********************************************************");
               trace("%%%%%%%% Stopping sound for " + this.id + " State: " + _loc2_ + " Start scene frame at: " + (this as Character).parentScene.getStartFrame());
               trace("**********************************************************");
            }
            this.isPlaying = false;
         }
         if(param1)
         {
            this.currSoundPos = 0;
            this.sound = null;
            this.soundChannel = null;
         }
      }
      
      public function set data(param1:ByteArray) : void
      {
         this._data = param1;
      }
      
      public function set edtime(param1:Number) : void
      {
         this._edtime = param1;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set sttime(param1:Number) : void
      {
         this._sttime = param1;
      }
      
      public function set edzoom(param1:Number) : void
      {
         this._edzoom = param1;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set stzoom(param1:Number) : void
      {
         this._stzoom = param1;
      }
      
      public function set customColor(param1:UtilHashArray) : void
      {
         this._customColor = param1;
      }
      
      public function get edtime() : Number
      {
         return this._edtime;
      }
      
      public function goToAndPauseReset() : void
      {
         PlayerConstant.goToAndStopFamilyAt1(this.getBundle());
      }
      
      public function propagateSceneState(param1:int) : void
      {
      }
      
      public function set soundChannel(param1:SoundChannel) : void
      {
         this._soundChannel = param1;
      }
      
      protected function initAssetDependency() : void
      {
         this._bundle.x = this._xs[0];
         this._bundle.y = this._ys[0];
      }
      
      public function getBundle() : DisplayObjectContainer
      {
         return this._bundle;
      }
      
      public function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      public function pause() : void
      {
         PlayerConstant.stopFamily(this.getBundle());
      }
   }
}
