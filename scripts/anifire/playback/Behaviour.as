package anifire.playback
{
   import anifire.component.CustomCharacterMaker;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.util.Util;
   import anifire.util.UtilCommonLoader;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public class Behaviour implements IPlayable, IEventDispatcher
   {
      
      private static const CC_INITIALIZING:String = "1";
      
      public static const CHANGE_FACE:String = "0";
      
      private static const CC_NOT_YET_INITIALIZED:String = "0";
      
      private static const CC_ALREADY_FINISH_INITIALIZING:String = "2";
      
      public static const FACE_NEGATIVE:String = "-1";
      
      public static const FACE_POSITIVE:String = "1";
       
      
      private var _isLoop:Boolean;
      
      private var _firstBehavior:Behaviour = null;
      
      private var _loader:DisplayObjectContainer;
      
      private var _content:MovieClip;
      
      private var _face:String;
      
      private var _myChar:Character;
      
      private var _totalFrames:Number = 1;
      
      private var _nextBehavior:Behaviour;
      
      private var _currentFrame:Number;
      
      private var _file:String;
      
      private var _prevBehavior:Behaviour;
      
      private var _charObj:DisplayObjectContainer;
      
      private var _customHead:Prop = null;
      
      private var _charObjFlipped:DisplayObjectContainer;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _localStartFrame:Number = 0;
      
      private var _headProp:DisplayObject = null;
      
      private var _ccMakerInitHandlers:Boolean = false;
      
      private var _handProp:DisplayObject = null;
      
      private var _isContentSet:Boolean = false;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _isFirstBehavior:Boolean = false;
      
      private var _localEndFrame:Number = 1;
      
      private var _wearProp:DisplayObject = null;
      
      public function Behaviour()
      {
         this._eventDispatcher = new EventDispatcher();
         super();
      }
      
      public function setWear(param1:DisplayObject, param2:Prop) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         this._wearProp = param1;
         this._customHead = param2;
         this.removeWear();
         if(!UtilPlain.isObjectFlipped(this.getLoader()))
         {
            _loc3_ = this._charObj;
         }
         else
         {
            _loc3_ = this._charObjFlipped;
            if(_loc3_ == null)
            {
               _loc3_ = this._charObj;
            }
         }
         this.setWearForCharObj(param1,param2,_loc3_);
      }
      
      public function goToAndPause(param1:Number) : void
      {
         trace("----> behaviour: gotoAndpause: " + param1);
         var _loc2_:Number = param1 + this.getLocalStartFrame() - 1;
         if(this.getIsLoop())
         {
            PlayerConstant.goToAndStopFamily(this.getLoader(),_loc2_);
         }
         else
         {
            if(_loc2_ >= this.getTotalFrames())
            {
               PlayerConstant.goToAndStopFamily(this.getLoader(),this.getTotalFrames());
               this._currentFrame = this.getTotalFrames();
            }
            else
            {
               PlayerConstant.goToAndStopFamily(this.getLoader(),_loc2_);
               this._currentFrame = _loc2_;
            }
            this.getContent().removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      public function removeProp() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = null;
         _loc2_ = this._charObj;
         _loc1_ = UtilPlain.getProp(_loc2_);
         if(_loc1_ != null)
         {
            UtilPlain.removeAllSon(_loc1_);
         }
         _loc2_ = this._charObjFlipped;
         if(_loc2_ != null)
         {
            _loc1_ = UtilPlain.getProp(_loc2_);
            if(_loc1_ != null)
            {
               UtilPlain.removeAllSon(_loc1_);
            }
         }
      }
      
      public function getLoader() : DisplayObjectContainer
      {
         return this._loader;
      }
      
      protected function onInitRemoteDataCompleted(param1:Event) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Class = null;
         trace("onInitRemoteDataCompleted");
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitRemoteDataCompleted);
         }
         if(Util.getFlashVar().getValueByKey(ServerConstants.FLASHVAR_IS_IN_SPEEDY_MODE) == "1")
         {
            _loc2_ = Util.getCharacter(UtilCommonLoader(this.getLoader()).content as MovieClip);
            trace(_loc2_.name);
            if(_loc2_ != null)
            {
               _loc2_.filters = [];
            }
         }
         if(UtilCommonLoader(this.getLoader()).content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            _loc3_ = UtilCommonLoader(this.getLoader()).content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            if(this is Action)
            {
               this.dispatchEvent(new ExtraDataEvent("SoundRdy",this,_loc3_));
            }
            else if(this is Motion)
            {
               this.dispatchEvent(new ExtraDataEvent("MotionSoundRdy",this,_loc3_));
            }
         }
         this.setContent(MovieClip(UtilCommonLoader(this.getLoader()).content));
         this._isContentSet = true;
         this._charObj = UtilPlain.getCharacter(this.getContent());
         this._charObjFlipped = UtilPlain.getCharacterFlip(this.getContent());
         if(this._charObj == null)
         {
            this._charObj = this.getContent();
         }
         if(!this.getIsLoop())
         {
            this._currentFrame = 0;
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      private function setLoader(param1:DisplayObjectContainer) : void
      {
         this._loader = param1;
         if(param1 != null)
         {
            this._loader.name = AnimeConstants.LOADER_NAME;
         }
      }
      
      public function get isFirstBehavior() : Boolean
      {
         return this._isFirstBehavior;
      }
      
      public function get firstBehavior() : Behaviour
      {
         return this._firstBehavior;
      }
      
      public function getLocalEndFrame() : Number
      {
         return this._localEndFrame;
      }
      
      public function get myChar() : Character
      {
         return this._myChar;
      }
      
      public function updateStaticProperties() : void
      {
         this.flip(this.getFace());
      }
      
      public function resume() : void
      {
         if(this.getIsLoop())
         {
            PlayerConstant.playFamily(this.getLoader());
         }
         else if(this._currentFrame < this.getTotalFrames())
         {
            PlayerConstant.playFamily(this.getLoader());
            this.getContent().addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
         else
         {
            this.pause();
         }
      }
      
      public function set isFirstBehavior(param1:Boolean) : void
      {
         this._isFirstBehavior = param1;
      }
      
      protected function setLocalStartFrame(param1:Number) : void
      {
         this._localStartFrame = param1;
      }
      
      public function removeWear() : void
      {
         var _loc1_:DisplayObjectContainer = this._charObj;
         var _loc2_:DisplayObjectContainer = this._charObjFlipped;
         this.removeWearForCharObj(_loc1_);
         if(_loc2_ != null)
         {
            this.removeWearForCharObj(_loc2_);
         }
      }
      
      private function removeWearForCharObj(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObject = null;
         _loc2_ = UtilPlain.getHead(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_CUSTOM_WEAR);
            if(_loc3_ != null)
            {
               _loc2_.removeChild(_loc3_);
            }
         }
      }
      
      protected function initLoader(param1:Boolean) : void
      {
         if(this.isFirstBehavior)
         {
            if(param1)
            {
               this.setLoader(new CustomCharacterMaker());
            }
            else
            {
               this.setLoader(new UtilCommonLoader());
            }
         }
         else
         {
            this.setLoader(this.firstBehavior.getLoader());
         }
      }
      
      public function initRemoteData(param1:PlayerDataStock, param2:Boolean = false, param3:Number = 0, param4:Number = 0, param5:Boolean = false) : void
      {
         var ccMaker:CustomCharacterMaker = null;
         var xml:XML = null;
         var data:UtilHashArray = null;
         var skins:UtilHashArray = null;
         var libraryNode:XML = null;
         var i:int = 0;
         var lid:String = null;
         var iDataStock:PlayerDataStock = param1;
         var isCC:Boolean = param2;
         var startMilliSec:Number = param3;
         var endMilliSec:Number = param4;
         var isSpeech:Boolean = param5;
         if(!isCC)
         {
            UtilCommonLoader(this.getLoader()).shouldPauseOnLoadBytesComplete = true;
            UtilCommonLoader(this.getLoader()).addEventListener(Event.COMPLETE,this.onInitRemoteDataCompleted);
            try
            {
               UtilCommonLoader(this.getLoader()).loadBytes(iDataStock.getPlayerData(this.getFile()) as ByteArray);
            }
            catch(e:Error)
            {
               trace(e.message);
               trace("    key:" + this.file);
            }
         }
         else
         {
            ccMaker = CustomCharacterMaker(this.getLoader());
            ccMaker.shouldPauseOnLoadBytesComplete = true;
            ccMaker.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onInitCCRemoteDataCompleted);
            if(!this._ccMakerInitHandlers)
            {
               this._ccMakerInitHandlers = true;
               this.addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,function(param1:ExtraDataEvent):void
               {
                  var _loc2_:Boolean = Boolean(param1.getData());
                  ccMaker.lookAtCamera = _loc2_;
               });
               this.addEventListener(SpeechPitchEvent.PITCH,function(param1:SpeechPitchEvent):void
               {
                  var _loc2_:SpeechPitchEvent = null;
                  if(param1.value != -1)
                  {
                     ccMaker.switchToLipSyncMouth(true);
                     _loc2_ = new SpeechPitchEvent(SpeechPitchEvent.PITCH);
                     _loc2_.value = param1.value;
                     ccMaker.dispatchEvent(_loc2_);
                  }
                  else
                  {
                     ccMaker.switchToLipSyncMouth(false);
                  }
               });
            }
            data = new UtilHashArray();
            skins = new UtilHashArray();
            try
            {
               xml = iDataStock.getPlayerData(this.getFile())["xml"] as XML;
               i = 0;
               while(i < xml.library.length())
               {
                  libraryNode = xml.library[i];
                  lid = libraryNode.@theme_id + "." + libraryNode.@type + "." + libraryNode.@component_id + ".swf";
                  if(iDataStock.getPlayerData(lid) != null)
                  {
                     skins.push(lid,iDataStock.getPlayerData(lid));
                  }
                  i++;
               }
               data = iDataStock.getPlayerData(this.getFile())["imageData"];
            }
            catch(e:Error)
            {
               xml = XML(iDataStock.getPlayerData(this.getFile()));
            }
            ccMaker.init(xml,startMilliSec,endMilliSec,data,skins,isSpeech,true);
         }
      }
      
      private function setTotalFrames(param1:Number) : void
      {
         this._totalFrames = param1;
      }
      
      public function set prevBehavior(param1:Behaviour) : void
      {
         this._prevBehavior = param1;
      }
      
      public function set myChar(param1:Character) : void
      {
         this._myChar = param1;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      protected function pretendToBe(param1:Behaviour) : void
      {
         this.setFile(param1.getFile());
         this.setIsLoop(param1.getIsLoop());
         this.setTotalFrames(param1.getTotalFrames());
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      public function set firstBehavior(param1:Behaviour) : void
      {
         this._firstBehavior = param1;
      }
      
      public function setHead(param1:DisplayObject = null, param2:Boolean = false) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         this._headProp = param1;
         this.removeHead();
         if(!UtilPlain.isObjectFlipped(this.getLoader()))
         {
            _loc3_ = this._charObj;
         }
         else
         {
            _loc3_ = this._charObjFlipped;
            if(_loc3_ == null)
            {
               _loc3_ = this._charObj;
            }
         }
         this.setHeadForCharObj(param1,_loc3_,param2);
      }
      
      private function removeHeadForCharObj(param1:DisplayObjectContainer) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         _loc2_ = UtilPlain.getHead(param1);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_CUSTOM_HEAD);
            if(_loc3_ != null)
            {
               _loc2_.removeChild(_loc3_);
            }
            (_loc4_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD)).alpha = 1;
            _loc4_.visible = true;
         }
         _loc2_ = UtilPlain.getTail(param1);
         if(_loc2_ != null)
         {
            if((_loc5_ = _loc2_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL)) != null)
            {
               _loc5_.alpha = 1;
               _loc5_.visible = true;
            }
         }
      }
      
      public function get nextBehavior() : Behaviour
      {
         return this._nextBehavior;
      }
      
      protected function onInitCCRemoteDataCompleted(param1:Event) : void
      {
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitCCRemoteDataCompleted);
         }
         this.setContent(MovieClip(CustomCharacterMaker(this.getLoader())));
         this._isContentSet = true;
         this._charObj = UtilPlain.getCharacter(this.getContent());
         this._charObjFlipped = UtilPlain.getCharacterFlip(this.getContent());
         if(!this.getIsLoop())
         {
            this._currentFrame = 0;
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      public function flip(param1:String) : void
      {
         var _loc2_:DisplayObject = this._charObj;
         var _loc3_:DisplayObject = this._charObjFlipped;
         if(param1 == CHANGE_FACE)
         {
            if(UtilPlain.isObjectFlipped(this.getLoader()))
            {
               param1 = FACE_POSITIVE;
            }
            else
            {
               param1 = FACE_NEGATIVE;
            }
         }
         if(param1 == FACE_POSITIVE)
         {
            UtilPlain.flipObj(this.getLoader(),true,false);
            if(_loc3_ != null)
            {
               if(this._handProp != null)
               {
                  this.setProp(this._handProp);
               }
               if(this._headProp != null)
               {
                  this.setHead(this._headProp);
               }
               if(this._customHead != null || this._wearProp != null)
               {
                  this.setWear(this._wearProp,this._customHead);
               }
            }
         }
         else if(param1 == FACE_NEGATIVE)
         {
            UtilPlain.flipObj(this.getLoader(),false,true);
            if(_loc3_ != null)
            {
               if(this._handProp != null)
               {
                  this.setProp(this._handProp);
               }
               if(this._headProp != null)
               {
                  this.setHead(this._headProp);
               }
               if(this._customHead != null || this._wearProp != null)
               {
                  this.setWear(this._wearProp,this._customHead);
               }
            }
         }
      }
      
      protected function getContent() : MovieClip
      {
         return this._content;
      }
      
      public function goToAndPauseReset() : void
      {
         if(this.getIsLoop())
         {
            PlayerConstant.goToAndStopFamilyAt1(this.getLoader());
         }
         else
         {
            this._currentFrame = this.getLocalStartFrame();
            this.getContent().removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      public function setLookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
         this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,this._lookAtCamera));
      }
      
      public function getLookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      public function initBehaviour(param1:XML, param2:String, param3:UtilHashArray, param4:PlayerDataStock) : Boolean
      {
         this.setFile(UtilXmlInfo.getZipFileNameOfBehaviour(param1.toString(),true));
         var _loc5_:String;
         if((_loc5_ = UtilXmlInfo.getThemeIdFromFileName(this.getFile())) != "ugc")
         {
            param4.decryptPlayerData(this.getFile());
         }
         var _loc6_:Array;
         if((_loc6_ = String(param1.attribute("face")).split(","))[0] == FACE_POSITIVE)
         {
            this.setFace(FACE_POSITIVE);
         }
         else
         {
            this.setFace(FACE_NEGATIVE);
         }
         var _loc7_:XML;
         if((_loc7_ = PlayerConstant.getBehaviourXMLfromThemeXML(this.getFile(),param2,param3)) == null)
         {
            return false;
         }
         if(_loc7_.attribute("loop").length() <= 0)
         {
            this.setIsLoop(true);
         }
         else if(_loc7_.attribute("loop")[0].toString() == "Y")
         {
            this.setIsLoop(true);
         }
         else
         {
            this.setIsLoop(false);
         }
         if(_loc7_.attribute("totalframe").length() > 0)
         {
            this.setTotalFrames(Number(_loc7_.attribute("totalframe")[0].toString()));
         }
         else
         {
            this.setTotalFrames(1);
         }
         if(param4.getPlayerData(this.getFile()) == null)
         {
            trace("init Behaviour failure. Reason: failure getting file: " + this.getFile());
            return false;
         }
         return true;
      }
      
      public function removeHead() : void
      {
         var _loc1_:DisplayObjectContainer = this._charObj;
         var _loc2_:DisplayObjectContainer = this._charObjFlipped;
         this.removeHeadForCharObj(_loc1_);
         if(_loc2_ != null)
         {
            this.removeHeadForCharObj(_loc2_);
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function setWearForCharObj(param1:DisplayObject, param2:Prop, param3:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:Number = NaN;
         if((_loc4_ = UtilPlain.getHead(param3)) != null)
         {
            param1.name = AnimeConstants.MOVIECLIP_CUSTOM_WEAR;
            _loc4_.addChild(param1);
            param1.x = 0;
            param1.y = 0;
            param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEX));
            param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEY));
            _loc5_ = UtilPlain.getInstance(_loc4_,"theTop");
            if(_loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha != 0)
            {
               _loc6_ = _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).getBounds(_loc4_).y;
            }
            else
            {
               _loc6_ = param2 != null?Number(param2.getBundle().getBounds(param2.getBundle()).y):Number(0);
            }
            if(_loc5_ != null)
            {
               _loc5_.y = _loc6_;
            }
         }
      }
      
      protected function setLocalEndFrame(param1:Number) : void
      {
         this._localEndFrame = param1;
      }
      
      public function get prevBehavior() : Behaviour
      {
         return this._prevBehavior;
      }
      
      public function getEventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         ++this._currentFrame;
         if(this._currentFrame >= this.getTotalFrames())
         {
            this.pause();
         }
      }
      
      private function setHeadForCharObj(param1:DisplayObject, param2:DisplayObjectContainer, param3:Boolean = false) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         if((_loc4_ = UtilPlain.getHead(param2)) != null)
         {
            if(param1 != null)
            {
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 0;
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = false;
               param1.name = AnimeConstants.MOVIECLIP_CUSTOM_HEAD;
               _loc4_.addChild(param1);
               if(!param3)
               {
                  param1.x = 0;
                  param1.y = 0;
                  param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEX));
                  param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(_loc4_,this.getLoader(),UtilPlain.PROPERTY_SCALEY));
               }
               else
               {
                  CustomCharacterMaker(this.getLoader()).refreshScale();
               }
            }
         }
         if((_loc4_ = UtilPlain.getTail(param2)) != null)
         {
            if(param1 != null)
            {
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 0;
               _loc4_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = false;
            }
         }
      }
      
      private function setContent(param1:MovieClip) : void
      {
         this._content = param1;
      }
      
      public function getLocalStartFrame() : Number
      {
         return this._localStartFrame;
      }
      
      public function set nextBehavior(param1:Behaviour) : void
      {
         this._nextBehavior = param1;
      }
      
      public function getFace() : String
      {
         return this._face;
      }
      
      protected function getTotalFrames() : Number
      {
         return this._totalFrames;
      }
      
      public function setFace(param1:String) : void
      {
         this._face = param1;
      }
      
      private function getIsLoop() : Boolean
      {
         return this._isLoop;
      }
      
      public function setProp(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = null;
         this._handProp = param1;
         if(!UtilPlain.isObjectFlipped(this.getLoader()))
         {
            _loc3_ = this._charObj;
         }
         else
         {
            _loc3_ = this._charObjFlipped;
            if(_loc3_ == null)
            {
               _loc3_ = this._charObj;
            }
         }
         _loc2_ = UtilPlain.getProp(_loc3_);
         if(_loc2_ != null)
         {
            UtilPlain.removeAllSon(_loc2_);
            _loc2_.addChild(param1);
            param1.x = 0;
            param1.y = 0;
            param1.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(_loc2_,this.getLoader(),UtilPlain.PROPERTY_SCALEX));
            param1.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(_loc2_,this.getLoader(),UtilPlain.PROPERTY_SCALEY));
         }
      }
      
      private function setIsLoop(param1:Boolean) : void
      {
         this._isLoop = param1;
      }
      
      public function getFile() : String
      {
         return this._file;
      }
      
      public function isContentSet() : Boolean
      {
         return this._isContentSet;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         if(this.nextBehavior == null)
         {
            this.pause();
         }
         if(param1)
         {
            this.setLoader(null);
         }
      }
      
      public function pause() : void
      {
         if(this.getContent() != null)
         {
            PlayerConstant.stopFamily(this.getLoader());
            this.getContent().removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         }
      }
      
      protected function setFile(param1:String) : void
      {
         var _loc2_:RegExp = /.zip/gi;
         this._file = param1.replace(_loc2_,".xml");
      }
   }
}
