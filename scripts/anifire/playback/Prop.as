package anifire.playback
{
   import Singularity.Geom.BezierSpline;
   import anifire.color.SelectedColor;
   import anifire.component.CustomCharacterMaker;
   import anifire.component.CustomHeadMaker;
   import anifire.component.DownloadManager;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.sound.VideoNetStreamController;
   import anifire.util.UtilCommonLoader;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class Prop extends Asset
   {
      
      private static const STATE_MOTION:int = 2;
      
      private static const STATE_FADE:int = 3;
      
      private static const STATE_ACTION:int = 1;
      
      public static const XML_TAG_WEAR:String = "wear";
      
      public static const XML_TAG_HEAD:String = "head";
      
      public static const XML_TAG:String = "prop";
      
      private static const STATE_NULL:int = 0;
      
      private static const FACE_NEGATIVE:String = "-1";
      
      private static const FACE_POSITIVE:String = "1";
       
      
      private var _handStyle:String = "";
      
      private var _isSpeech:Boolean = false;
      
      private var _yscale:Number = 1;
      
      private var _propInNextScene:Prop;
      
      public var _facings:Array;
      
      private var _imageData:ByteArray;
      
      public var _xscales:Array;
      
      private var _loader:DisplayObjectContainer;
      
      private var _firstProp:Prop = null;
      
      public var _rotations:Array;
      
      private var _ccMakerInitHandlers:Boolean = false;
      
      private var _propInPrevScene:Prop;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _file:String;
      
      private var _rotation:Number;
      
      public var _isContentSet:Boolean = false;
      
      public var _yscales:Array;
      
      private var _isCC:Boolean = false;
      
      private var _isFirstProp:Boolean = false;
      
      private var _spline:BezierSpline;
      
      private var _xscale:Number = 1;
      
      private var _videoNetStreamController:VideoNetStreamController;
      
      private var _facing:String;
      
      public function Prop()
      {
         this._spline = new BezierSpline();
         super();
      }
      
      public static function connectPropsIfNecessary(param1:Prop, param2:Prop) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1.file != param2.file)
         {
            return false;
         }
         var _loc3_:Point = new Point(param1._xs[param1._xs.length - 1],param1._ys[param1._ys.length - 1]);
         var _loc4_:Point = new Point(param2._xs[0],param2._ys[0]);
         if(Point.distance(_loc3_,_loc4_) > 1)
         {
            return false;
         }
         param1._propInNextScene = param2;
         param2._propInPrevScene = param1;
         return true;
      }
      
      public static function connectPropsBetweenScenes(param1:UtilHashArray, param2:UtilHashArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Prop = null;
         var _loc6_:Prop = null;
         var _loc7_:Boolean = false;
         var _loc8_:UtilHashArray = null;
         if(param1 != null && param2 != null && param1.length > 0 && param2.length > 0)
         {
            _loc8_ = param2.clone();
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc5_ = param1.getValueByIndex(_loc3_) as Prop;
               _loc4_ = 0;
               while(_loc4_ < _loc8_.length)
               {
                  _loc6_ = _loc8_.getValueByIndex(_loc4_) as Prop;
                  if(_loc7_ = connectPropsIfNecessary(_loc5_,_loc6_))
                  {
                     _loc8_.remove(_loc4_,1);
                     break;
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
         }
      }
      
      public static function isChanged(param1:Prop, param2:Prop) : Boolean
      {
         if(param1._x != param2._x || param1._y != param2._y || param1._xscale != param2._xscale || param1._yscale != param2._yscale || param1._rotation != param2._rotation)
         {
            return true;
         }
         return false;
      }
      
      public function get handStyle() : String
      {
         return this._handStyle;
      }
      
      public function set handStyle(param1:String) : void
      {
         this._handStyle = param1;
      }
      
      private function flip() : void
      {
         if(this.facing == Prop.FACE_POSITIVE)
         {
            if(this.getIsVideo())
            {
               this.videoNetStreamController.flipVideo(false);
            }
            else
            {
               UtilPlain.flipObj(this.objInsideBundle,true,false);
            }
         }
         else if(this.getIsVideo())
         {
            this.videoNetStreamController.flipVideo(true);
         }
         else
         {
            UtilPlain.flipObj(this.objInsideBundle,false,true);
         }
      }
      
      private function getLoader() : DisplayObjectContainer
      {
         return this._loader;
      }
      
      public function get isCC() : Boolean
      {
         return this._isCC;
      }
      
      protected function onInitRemoteDataCompleted(param1:Event) : void
      {
         var _loc3_:Class = null;
         var _loc4_:Rectangle = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitRemoteDataCompleted);
         var _loc2_:Loader = UtilCommonLoader(this.getLoader());
         if(_loc2_.content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            _loc3_ = _loc2_.content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            this.sound = new _loc3_();
            this.dispatchEvent(new Event("SoundAdded"));
         }
         if(this.parentScene != null)
         {
            _loc4_ = this.getLoader().getBounds(this.getLoader());
            UtilCommonLoader(this.getLoader()).content.x = UtilCommonLoader(this.getLoader()).content.x - (_loc4_.left + _loc4_.right) / 2;
            UtilCommonLoader(this.getLoader()).content.y = UtilCommonLoader(this.getLoader()).content.y - (_loc4_.top + _loc4_.bottom) / 2;
         }
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      private function onInitCCRemoteDataCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitCCRemoteDataCompleted);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      override public function goToAndPauseReset() : void
      {
         if(this.getIsVideo())
         {
            this.videoNetStreamController.pause();
            this.videoNetStreamController.seek(0);
         }
         else
         {
            super.goToAndPauseReset();
         }
      }
      
      override public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         var _loc5_:Number = NaN;
         if(this.getIsVideo())
         {
            _loc5_ = UtilUnitConvert.frameToSec(param2 - this.firstProp.parentScene.getStartFrame());
            this.videoNetStreamController.pause();
            this.videoNetStreamController.seek(_loc5_);
         }
         else
         {
            PlayerConstant.goToAndStopFamily(this.getBundle(),param1);
         }
      }
      
      public function set isCC(param1:Boolean) : void
      {
         this._isCC = param1;
      }
      
      private function setLoader(param1:DisplayObjectContainer) : void
      {
         this._loader = param1;
      }
      
      public function init(param1:XML, param2:AnimeScene, param3:PlayerDataStock) : Boolean
      {
         var colorXML:XML = null;
         var themeId:String = null;
         var i:uint = 0;
         var selectedColor:SelectedColor = null;
         var propXML:XML = param1;
         var iParentScene:AnimeScene = param2;
         var dataStock:PlayerDataStock = param3;
         var isInitSuccessful:Boolean = true;
         this.isCC = propXML.@isCC == "Y"?true:false;
         this.handStyle = propXML.@isCC == null?"":propXML.@handstyle;
         try
         {
            if(iParentScene == null)
            {
               this.file = UtilXmlInfo.getZipFileNameOfProp(propXML.child("file")[0].toString());
               this.setBundle(new Sprite());
            }
            else
            {
               super.initAsset(propXML.@id,propXML.@index,iParentScene);
               this.file = UtilXmlInfo.getZipFileNameOfProp(propXML.child("file")[0].toString());
               this._xs = String(propXML["x"]).split(",");
               this._ys = String(propXML["y"]).split(",");
               i = 0;
               i = 0;
               while(i < this._xs.length)
               {
                  this._spline.addControlPoint(this._xs[i],this._ys[i]);
                  i++;
               }
               this._xscales = String(propXML["xscale"]).split(",");
               this._yscales = String(propXML["yscale"]).split(",");
               this._rotations = String(propXML["rotation"]).split(",");
               this._facings = String(propXML["face"]).split(",");
               this.facing = this._facings[0];
               this._bundle.scaleX = this._xscales[0];
               this._bundle.scaleY = this._yscales[0];
               this._bundle.rotation = this._rotations[0];
            }
            themeId = UtilXmlInfo.getThemeIdFromFileName(this.file);
            if(themeId != "ugc")
            {
               dataStock.decryptPlayerData(this.file);
            }
         }
         catch(e:Error)
         {
            trace("########## WARNING ! ##########");
            trace("init prop failure (id: " + this.id + " | file: " + this.file + "). Error description: " + e.message);
            isInitSuccessful = false;
         }
         if(!this.getIsVideo() && dataStock.getPlayerData(this.file) == null)
         {
            trace("########## WARNING ! ##########");
            trace("init prop failure. Reason: failure getting file: " + this.file);
            isInitSuccessful = false;
         }
         var j:uint = 0;
         customColor = new UtilHashArray();
         j = 0;
         while(j < propXML.child("color").length())
         {
            colorXML = propXML.child("color")[j];
            selectedColor = new SelectedColor(colorXML.@r,colorXML.attribute("oc").length() == 0?uint(uint.MAX_VALUE):uint(colorXML.@oc),uint(colorXML));
            addCustomColor(colorXML.@r,selectedColor);
            j++;
         }
         if(isInitSuccessful)
         {
            return true;
         }
         return false;
      }
      
      override public function setVolume(param1:Number) : void
      {
         if(this.getIsVideo())
         {
            this.videoNetStreamController.setVolume(param1);
         }
      }
      
      private function set videoNetStreamController(param1:VideoNetStreamController) : void
      {
         this._videoNetStreamController = param1;
      }
      
      public function set spline(param1:BezierSpline) : void
      {
         this._spline = param1;
      }
      
      public function get imageData() : ByteArray
      {
         return this._imageData;
      }
      
      public function get isSpeech() : Boolean
      {
         return this._isSpeech;
      }
      
      override public function resume() : void
      {
         if(this.getIsVideo())
         {
            this.videoNetStreamController.resume();
         }
         else
         {
            super.resume();
         }
      }
      
      public function get isFirstProp() : Boolean
      {
         return this._isFirstProp;
      }
      
      private function get objInsideBundle() : DisplayObject
      {
         if(this.getIsVideo())
         {
            return this.videoNetStreamController.getVideoContainer();
         }
         return this.getLoader();
      }
      
      public function propagateCharState(param1:int) : void
      {
         if(param1 == Character.STATE_ACTION || param1 == Character.STATE_FADE || param1 == Character.STATE_MOTION)
         {
            if(this.isCC)
            {
               dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,this.lookAtCamera));
            }
            this.getBundle().addChild(this.objInsideBundle);
            if(this.isFirstProp)
            {
               this.resume();
            }
         }
      }
      
      public function initRemoteData(param1:PlayerDataStock, param2:Boolean = false, param3:Boolean = false) : void
      {
         var tmpArray:ByteArray = null;
         var ccMaker:CustomHeadMaker = null;
         var xml:XML = null;
         var data:UtilHashArray = null;
         var iDataStock:PlayerDataStock = param1;
         var isCC:Boolean = param2;
         var isSpeech:Boolean = param3;
         if(this.getIsVideo())
         {
            if(this.parentScene != null)
            {
               this.videoNetStreamController.getVideoContainer().x = -1 * this.videoNetStreamController.width / 2;
               this.videoNetStreamController.getVideoContainer().y = -1 * this.videoNetStreamController.height / 2;
            }
            this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
         }
         else if(!isCC)
         {
            tmpArray = new ByteArray();
            ByteArray(iDataStock.getPlayerData(this.file)).position = 0;
            ByteArray(iDataStock.getPlayerData(this.file)).readBytes(tmpArray);
            this.imageData = tmpArray;
            UtilCommonLoader(this.getLoader()).shouldPauseOnLoadBytesComplete = true;
            UtilCommonLoader(this.getLoader()).addEventListener(Event.COMPLETE,this.onInitRemoteDataCompleted);
            try
            {
               UtilCommonLoader(this.getLoader()).loadBytes(iDataStock.getPlayerData(this.file) as ByteArray);
            }
            catch(e:Error)
            {
               trace(e.message);
               trace("    key:" + this.file);
            }
         }
         else
         {
            ccMaker = CustomHeadMaker(this.getLoader());
            ccMaker.shouldPauseOnLoadBytesComplete = true;
            ccMaker.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.onInitCCRemoteDataCompleted);
            if(!this._ccMakerInitHandlers)
            {
               this._ccMakerInitHandlers = true;
               addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,function(param1:ExtraDataEvent):void
               {
                  var _loc2_:Boolean = Boolean(param1.getData());
                  ccMaker.lookAtCamera = _loc2_;
               });
               addEventListener(SpeechPitchEvent.PITCH,function(param1:SpeechPitchEvent):void
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
            try
            {
               xml = iDataStock.getPlayerData(this.file)["xml"] as XML;
               data = iDataStock.getPlayerData(this.file)["imageData"];
            }
            catch(e:Error)
            {
               xml = XML(iDataStock.getPlayerData(this.file));
            }
            ccMaker.init(xml,0,0,data,null,isSpeech,true);
         }
      }
      
      private function get firstProp() : Prop
      {
         return this._firstProp;
      }
      
      public function set facing(param1:String) : void
      {
         this._facing = param1;
      }
      
      public function set imageData(param1:ByteArray) : void
      {
         this._imageData = param1;
      }
      
      override protected function setState(param1:int) : void
      {
         if(param1 == Prop.STATE_ACTION)
         {
            this._bundle.x = this._xs[0];
            this._bundle.y = this._ys[0];
            this._bundle.scaleX = this._xscales[0];
            this._bundle.scaleY = this._yscales[0];
            this._bundle.rotation = this._rotations[0];
            this.getBundle().addChild(this.objInsideBundle);
            this.flip();
            if(this.isFirstProp)
            {
               this.resume();
            }
         }
         else if(param1 == Prop.STATE_MOTION)
         {
            this.getBundle().addChild(this.objInsideBundle);
            this.flip();
            if(this.isFirstProp)
            {
               this.resume();
            }
         }
         super.setState(param1);
      }
      
      public function get spline() : BezierSpline
      {
         return this._spline;
      }
      
      private function getIsVideo() : Boolean
      {
         var _loc1_:Array = this.file.split(".");
         if(_loc1_[_loc1_.length - 1] == "flv")
         {
            return true;
         }
         return false;
      }
      
      public function set isSpeech(param1:Boolean) : void
      {
         this._isSpeech = param1;
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      public function updateProperties(param1:Number = 0) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._state != STATE_MOTION)
         {
            if(this._state == STATE_ACTION)
            {
               if(this._xs.length > 2 && this._ys.length > 2)
               {
                  this._bundle.x = this._spline.getX(param1);
                  this._bundle.y = this._spline.getY(param1);
               }
               else if(this._xs.length > 1 && this._ys.length > 1)
               {
                  _loc5_ = (_loc4_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._xs.length)) - 1;
                  _loc2_ = 1 / (this._xs.length - 1) * _loc5_;
                  _loc3_ = 1 / (this._xs.length - 1) * _loc4_;
                  this._bundle.x = Number(this._xs[_loc5_]) + (this._xs[_loc4_] - this._xs[_loc5_]) * ((param1 - _loc2_) / (_loc3_ - _loc2_));
                  _loc5_ = (_loc4_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._ys.length)) - 1;
                  _loc2_ = 1 / (this._ys.length - 1) * _loc5_;
                  _loc3_ = 1 / (this._ys.length - 1) * _loc4_;
                  this._bundle.y = Number(this._ys[_loc5_]) + (this._ys[_loc4_] - this._ys[_loc5_]) * ((param1 - _loc2_) / (_loc3_ - _loc2_));
               }
               if(this._xscales.length > 1)
               {
                  _loc5_ = (_loc4_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._xscales.length)) - 1;
                  _loc2_ = 1 / (this._xscales.length - 1) * _loc5_;
                  _loc3_ = 1 / (this._xscales.length - 1) * _loc4_;
                  this._bundle.scaleX = Number(this._xscales[_loc5_]) + (this._xscales[_loc4_] - this._xscales[_loc5_]) * ((param1 - _loc2_) / (_loc3_ - _loc2_));
               }
               if(this._yscales.length > 1)
               {
                  _loc5_ = (_loc4_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._yscales.length)) - 1;
                  _loc2_ = 1 / (this._yscales.length - 1) * _loc5_;
                  _loc3_ = 1 / (this._yscales.length - 1) * _loc4_;
                  this._bundle.scaleY = Number(this._yscales[_loc5_]) + (this._yscales[_loc4_] - this._yscales[_loc5_]) * ((param1 - _loc2_) / (_loc3_ - _loc2_));
               }
               if(this._facings.length > 1)
               {
                  if(param1 == 1)
                  {
                     if(this._facings[this._facings.length - 1] != this.facing)
                     {
                        this.facing = this._facings[this._facings.length - 1];
                        UtilPlain.flipObj(this.objInsideBundle);
                     }
                  }
               }
               if(this._rotations.length > 1)
               {
                  _loc5_ = (_loc4_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._rotations.length)) - 1;
                  _loc2_ = 1 / (this._rotations.length - 1) * _loc5_;
                  _loc3_ = 1 / (this._rotations.length - 1) * _loc4_;
                  this._bundle.rotation = Number(this._rotations[_loc5_]) + (this._rotations[_loc4_] - this._rotations[_loc5_]) * ((param1 - _loc2_) / (_loc3_ - _loc2_));
               }
            }
         }
      }
      
      private function set firstProp(param1:Prop) : void
      {
         this._firstProp = param1;
      }
      
      public function set isContentSet(param1:Boolean) : void
      {
         this._isContentSet = param1;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
      }
      
      public function get isContentSet() : Boolean
      {
         return this._isContentSet;
      }
      
      public function set isFirstProp(param1:Boolean) : void
      {
         this._isFirstProp = param1;
      }
      
      override public function pause() : void
      {
         if(this.getIsVideo())
         {
            this.videoNetStreamController.pause();
         }
         else
         {
            super.pause();
         }
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      public function set file(param1:String) : void
      {
         var _loc2_:RegExp = /.zip/gi;
         this._file = param1.replace(_loc2_,".xml");
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         if(this._propInNextScene == null)
         {
            super.destroy();
         }
         if(param1)
         {
            this.setLoader(null);
         }
      }
      
      public function initDependency(param1:DownloadManager, param2:UtilHashArray) : void
      {
         var _loc3_:Prop = null;
         var _loc4_:Number = NaN;
         var _loc5_:XML = null;
         this.initAssetDependency();
         if(this._propInPrevScene != null && this._propInPrevScene.file == this.file)
         {
            this.isFirstProp = false;
            this.firstProp = this._propInPrevScene.firstProp;
            if(this.getIsVideo())
            {
               this.videoNetStreamController = this.firstProp.videoNetStreamController;
            }
            else
            {
               this.setLoader(this.firstProp.getLoader());
            }
         }
         else
         {
            this.isFirstProp = true;
            this.firstProp = this;
            if(this.getIsVideo())
            {
               _loc3_ = this;
               _loc4_ = 0;
               while(_loc3_._propInNextScene != null)
               {
                  _loc4_ = _loc4_ + _loc3_.parentScene.getDuration();
                  _loc3_ = _loc3_._propInNextScene;
               }
               this.videoNetStreamController = param1.registerVideoNetStream(UtilNetwork.getGetUserUploadVideoUrl(this.file),UtilUnitConvert.frameToSec(this.parentScene.getStartFrame()) * 1000,UtilUnitConvert.frameToSec(_loc4_) * 1000,0);
               if(this.getIsVideo())
               {
                  _loc5_ = UtilXmlInfo.getPropXMLfromThemeXML(this.file,param2);
                  this.videoNetStreamController.updateDimension(_loc5_.@width,_loc5_.@height);
               }
            }
            else if(this.isCC)
            {
               this.setLoader(new CustomHeadMaker());
            }
            else
            {
               this.setLoader(new UtilCommonLoader());
            }
         }
         this.getBundle().addChild(this.objInsideBundle);
      }
      
      public function get file() : String
      {
         return this._file;
      }
      
      override public function propagateSceneState(param1:int) : void
      {
         if(param1 == AnimeScene.STATE_ACTION)
         {
            this.setState(Prop.STATE_ACTION);
         }
         else if(param1 == AnimeScene.STATE_MOTION)
         {
            if(this._propInNextScene == null)
            {
               this.setState(STATE_FADE);
            }
            else if(isChanged(this,this._propInNextScene))
            {
               this.setState(STATE_MOTION);
            }
            else
            {
               this.setState(STATE_ACTION);
            }
         }
         else if(param1 == AnimeScene.STATE_NULL)
         {
            this.setState(Prop.STATE_NULL);
         }
      }
      
      private function get videoNetStreamController() : VideoNetStreamController
      {
         return this._videoNetStreamController;
      }
   }
}
