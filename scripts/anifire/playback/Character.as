package anifire.playback
{
   import Singularity.Geom.BezierSpline;
   import anifire.color.SelectedColor;
   import anifire.component.CustomCharacterMaker;
   import anifire.constant.AnimeConstants;
   import anifire.event.ByteLoaderEvent;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   
   public class Character extends Asset
   {
      
      public static const STATE_MOTION:int = 2;
      
      public static const STATE_ACTION:int = 1;
      
      public static const STATE_FADE:int = 3;
      
      public static const XML_TAG:String = "char";
      
      public static const STATE_NULL:int = 0;
       
      
      private var actionSound:Sound;
      
      private var _myLoadMgr:UtilLoadMgr;
      
      private var _isSpeech:Boolean = false;
      
      private var _yscale:Number = 1;
      
      private var _facings:Array;
      
      private var _xscales:Array;
      
      private var _motionface:String;
      
      private var _rotations:Array;
      
      private var _head:Prop;
      
      private var _prop:Prop;
      
      private var _face:String = null;
      
      private var _charInNextScene:Character;
      
      private var _motion:Motion = null;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _action:Action = null;
      
      private var _rotation:Number = 0;
      
      private var _wear:Prop;
      
      private var _yscales:Array;
      
      private var _isCC:Boolean = false;
      
      private var _spline:BezierSpline;
      
      private var _xscale:Number = 1;
      
      private var motionSound:Sound;
      
      private var _charInPrevScene:Character;
      
      public function Character()
      {
         this._spline = new BezierSpline();
         super();
      }
      
      public static function isChanged(param1:Character, param2:Character) : Boolean
      {
         if(param1._x != param2._x || param1._y != param2._y || param1._xscale != param2._xscale || param1._yscale != param2._yscale || param1._rotation != param2._rotation)
         {
            return true;
         }
         return false;
      }
      
      public static function connectCharacters(param1:UtilHashArray, param2:UtilHashArray) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Character = null;
         var _loc6_:Character = null;
         var _loc7_:Point = null;
         var _loc8_:Point = null;
         var _loc9_:UtilHashArray = null;
         var _loc10_:Character = null;
         if(param1 != null && param2 != null && param1.length > 0 && param2.length > 0)
         {
            _loc7_ = new Point();
            _loc8_ = new Point();
            _loc9_ = param2.clone();
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc5_ = param1.getValueByIndex(_loc3_) as Character;
               _loc7_.x = _loc5_._xs[_loc5_._xs.length - 1];
               _loc7_.y = _loc5_._ys[_loc5_._ys.length - 1];
               _loc4_ = 0;
               for(; _loc4_ < _loc9_.length; _loc4_++)
               {
                  _loc6_ = _loc9_.getValueByIndex(_loc4_) as Character;
                  if(UtilXmlInfo.getCharIdFromFileName(_loc5_.action.getFile()) != UtilXmlInfo.getCharIdFromFileName(_loc6_.action.getFile()))
                  {
                     continue;
                  }
                  _loc8_.x = _loc6_._xs[0];
                  _loc8_.y = _loc6_._ys[0];
                  if(Point.distance(_loc7_,_loc8_) > 1)
                  {
                     continue;
                  }
                  if(_loc5_.isSpeech || _loc6_.isSpeech)
                  {
                     if(_loc5_.action.getFile() == _loc6_.action.getFile())
                     {
                        _loc5_.isSpeech = _loc6_.isSpeech = true;
                     }
                  }
                  _loc5_._charInNextScene = _loc6_;
                  _loc6_._charInPrevScene = _loc5_;
                  if(_loc5_.isSpeech)
                  {
                     _loc10_ = _loc5_._charInPrevScene;
                     while(_loc10_)
                     {
                        if(_loc10_.action.getFile() == _loc5_.action.getFile())
                        {
                           _loc10_.isSpeech = true;
                           _loc10_ = _loc10_._charInPrevScene;
                        }
                        else
                        {
                           _loc10_ = null;
                        }
                     }
                  }
                  _loc9_.remove(_loc4_,1);
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      public function initDependency(param1:Number, param2:Number, param3:Number, param4:Number, param5:UtilHashArray) : void
      {
         this.initAssetDependency();
         var _loc6_:Action = this._charInPrevScene != null?this._charInPrevScene.action:null;
         var _loc7_:Motion = this._charInPrevScene != null?this._charInPrevScene.motion:null;
         this.action.initDependency(param1,_loc7_,param4,_loc6_,param3,param5,this.isCC);
         if(this._charInNextScene != null)
         {
            this.motion = this._charInNextScene.motion;
         }
         else
         {
            this.motion = null;
         }
         if(this.motion != null)
         {
            this.motion.initDependency(this.action,param1,param2,_loc7_,param4,_loc6_,param3,param5);
         }
         if(this.prop != null)
         {
            Prop.connectPropsIfNecessary(this.prop,this._charInNextScene != null?this._charInNextScene.prop:null);
            this.prop.initDependency(null,param5);
         }
         if(this.head != null)
         {
            Prop.connectPropsIfNecessary(this.head,this._charInNextScene != null?this._charInNextScene.head:null);
            this.head.initDependency(null,param5);
         }
         if(this.wear != null)
         {
            Prop.connectPropsIfNecessary(this.wear,this._charInNextScene != null?this._charInNextScene.wear:null);
            this.wear.initDependency(null,param5);
         }
      }
      
      public function get wear() : Prop
      {
         return this._wear;
      }
      
      private function detachAllProps(param1:Behaviour) : void
      {
         if(this.prop != null)
         {
            param1.removeProp();
         }
         if(this.head != null)
         {
            param1.removeHead();
         }
         if(this.wear != null)
         {
            param1.removeWear();
         }
      }
      
      public function get isCC() : Boolean
      {
         return this._isCC;
      }
      
      private function onInitRemoteDataCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitRemoteDataCompleted);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      override public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         trace("----> Character: gotoAndpause: " + param1);
         if(this._state == Character.STATE_MOTION)
         {
            this.motion.goToAndPause(param1 - param4 + 1);
         }
         else if(this._state == Character.STATE_FADE)
         {
            this.action.goToAndPause(param1);
         }
         else if(this._state == Character.STATE_ACTION)
         {
            this.action.goToAndPause(param1);
         }
      }
      
      private function onLoadThumbForCcComplete(param1:Event) : void
      {
         CustomCharacterMaker(this.action.getLoader()).insertColor(this.customColor);
         CustomCharacterMaker(this.action.getLoader()).addLibrary(AnimeConstants.CLASS_GOPROP,"","");
         CustomCharacterMaker(this.action.getLoader()).reloadSkin();
      }
      
      public function set isCC(param1:Boolean) : void
      {
         this._isCC = param1;
      }
      
      public function init(param1:XML, param2:AnimeScene, param3:UtilHashArray, param4:PlayerDataStock) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc10_:XML = null;
         var _loc11_:SelectedColor = null;
         super.initAsset(param1.@id,param1.@index,param2);
         this.isCC = param1.@isCC == "Y"?true:false;
         this._xs = String(param1["x"]).split(",");
         this._ys = String(param1["y"]).split(",");
         this._lookAtCamera = param1.@faceCamera == "true";
         var _loc6_:uint = 0;
         _loc6_ = 0;
         while(_loc6_ < this._xs.length)
         {
            this._spline.addControlPoint(this._xs[_loc6_],this._ys[_loc6_]);
            _loc6_++;
         }
         this._xscales = String(param1["xscale"]).split(",");
         this._yscales = String(param1["yscale"]).split(",");
         this._rotations = String(param1["rotation"]).split(",");
         this._facings = String(param1.action.@face).split(",");
         this._motionface = param1.action.@motionface;
         var _loc7_:XML;
         if((_loc7_ = param1.child(Prop.XML_TAG)[0]) != null)
         {
            this.prop = new Prop();
            if(!(_loc5_ = this.prop.init(_loc7_,null,param4)))
            {
               trace("init prop failure.");
               this.prop = null;
            }
         }
         else
         {
            this.prop = null;
         }
         var _loc8_:XML;
         if((_loc8_ = param1.child(Prop.XML_TAG_HEAD)[0]) != null)
         {
            this.head = new Prop();
            _loc5_ = this.head.init(_loc8_,null,param4);
            this.head.lookAtCamera = this._lookAtCamera;
            if(!_loc5_)
            {
               trace("init head failure.");
               this.head = null;
            }
         }
         else
         {
            this.head = null;
         }
         var _loc9_:XML;
         if((_loc9_ = param1.child(Prop.XML_TAG_WEAR)[0]) != null)
         {
            this.wear = new Prop();
            if(!(_loc5_ = this.wear.init(_loc9_,null,param4)))
            {
               trace("init wear failure.");
               this.wear = null;
            }
         }
         else
         {
            this.wear = null;
         }
         this.action = new Action();
         if(!(_loc5_ = this.action.init(param1.child(Action.XML_TAG)[0],param3,param4)))
         {
            trace("init action failure.");
            return false;
         }
         customColor = new UtilHashArray();
         _loc6_ = 0;
         while(_loc6_ < param1.child("color").length())
         {
            _loc10_ = param1.child("color")[_loc6_];
            _loc11_ = new SelectedColor(_loc10_.@r,_loc10_.attribute("oc").length() == 0?uint(uint.MAX_VALUE):uint(_loc10_.@oc),uint(_loc10_));
            addCustomColor(_loc10_.@r,_loc11_);
            _loc6_++;
         }
         return true;
      }
      
      private function updateActionStaticProperty() : void
      {
         this._bundle.x = this._xs[0];
         this._bundle.y = this._ys[0];
         this._bundle.scaleY = this._yscales[0];
         this._bundle.scaleX = this._xscales[0];
         this._bundle.rotation = this._rotations[0];
         this._bundle.alpha = 1;
         this.action.setLookAtCamera(this._lookAtCamera);
         this.action.updateStaticProperties();
         if(this.motion != null)
         {
            this.motion.updateStaticProperties();
         }
         if(this.prop != null)
         {
            this.prop.propagateCharState(Character.STATE_ACTION);
         }
         if(this.head != null)
         {
            this.head.propagateCharState(Character.STATE_ACTION);
         }
         if(this.wear != null)
         {
            this.wear.propagateCharState(Character.STATE_ACTION);
         }
      }
      
      public function set wear(param1:Prop) : void
      {
         this._wear = param1;
      }
      
      override public function resume() : void
      {
         if(this._state == Character.STATE_MOTION)
         {
            this.motion.resume();
         }
         else if(this._state == Character.STATE_FADE)
         {
            this.action.resume();
         }
         else if(this._state == Character.STATE_ACTION)
         {
            this.action.resume();
         }
      }
      
      public function get isSpeech() : Boolean
      {
         return this._isSpeech;
      }
      
      public function set face(param1:String) : void
      {
         this._face = param1;
      }
      
      private function attachAllProps(param1:Behaviour) : void
      {
         if(this.prop != null)
         {
            if(param1.getLoader() is CustomCharacterMaker && CustomCharacterMaker(param1.getLoader()).ver == 2)
            {
               CustomCharacterMaker(param1.getLoader()).CCM.addEventListener(ByteLoaderEvent.LOAD_BYTES_COMPLETE,this.onLoadThumbForCcComplete);
               CustomCharacterMaker(param1.getLoader()).CCM.loadPropThumbAsStyle(this.prop.imageData as ByteArray,this.prop.handStyle);
            }
            else
            {
               param1.setProp(this.prop.getBundle());
            }
         }
         else
         {
            param1.removeProp();
         }
         if(this.head != null)
         {
            param1.setHead(this.head.getBundle(),this.isCC);
         }
         else
         {
            param1.removeHead();
         }
         if(this.wear != null)
         {
            param1.setWear(this.wear.getBundle(),this.head);
         }
         else
         {
            param1.removeWear();
         }
      }
      
      public function get motion() : Motion
      {
         return this._motion;
      }
      
      public function get charInPrevScene() : Character
      {
         return this._charInPrevScene;
      }
      
      public function set head(param1:Prop) : void
      {
         this._head = param1;
      }
      
      public function get action() : Action
      {
         return this._action;
      }
      
      public function initRemoteData(param1:PlayerDataStock, param2:Number = 0, param3:Number = 0) : void
      {
         var _loc4_:UtilLoadMgr;
         (_loc4_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onInitRemoteDataCompleted);
         if(this.motion != null)
         {
            _loc4_.addEventDispatcher(this.motion.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
            this.motion.addEventListener("MotionSoundRdy",this.initSound);
            this.motion.initRemoteData(param1,this.isCC,param2,param3);
         }
         if(this.action != null)
         {
            _loc4_.addEventDispatcher(this.action.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
            this.action.addEventListener("SoundRdy",this.initSound);
            this.action.initRemoteData(param1,this.isCC,param2,param3,this.isSpeech);
         }
         if(this.prop != null)
         {
            _loc4_.addEventDispatcher(this.prop.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
            this.prop.initRemoteData(param1,this.prop.isCC);
         }
         if(this.head != null)
         {
            _loc4_.addEventDispatcher(this.head.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
            this.head.initRemoteData(param1,this.head.isCC,this.isSpeech);
         }
         if(this.wear != null)
         {
            _loc4_.addEventDispatcher(this.wear.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
            this.wear.initRemoteData(param1,this.wear.isCC);
         }
         _loc4_.commit();
         this.setState(Character.STATE_NULL);
      }
      
      public function getMotionSound() : Sound
      {
         return this.motionSound;
      }
      
      public function set prop(param1:Prop) : void
      {
         this._prop = param1;
      }
      
      override protected function setState(param1:int) : void
      {
         var _loc2_:Behaviour = null;
         var _loc3_:Behaviour = null;
         var _loc4_:SoundTransform = null;
         var _loc5_:Behaviour = null;
         if(param1 == Character.STATE_MOTION)
         {
            UtilPlain.removeAllSon(this._bundle);
            this._bundle.addChild(this.motion.getLoader());
            this.updateMotionStaticProperty();
            if(this.action.nextBehavior == null)
            {
               this.detachAllProps(this.action);
               this.action.pause();
            }
            if(this.motion.isFirstBehavior)
            {
               this.detachAllProps(this.motion);
               this.motion.resume();
            }
            this.attachAllProps(this.motion);
            if(this.prop != null && this.prop.isFirstProp)
            {
               this.prop.resume();
            }
            if(this.head != null && this.head.isFirstProp)
            {
               this.head.resume();
            }
            if(this.wear != null && this.wear.isFirstProp)
            {
               this.wear.resume();
            }
            _loc3_ = this.action;
            while(!_loc3_.isFirstBehavior)
            {
               _loc3_ = _loc3_.prevBehavior;
            }
            _loc2_ = this.motion;
            while(!_loc2_.isFirstBehavior)
            {
               _loc2_ = _loc2_.prevBehavior;
            }
            _loc2_.myChar.sound = _loc2_.myChar.motionSound;
            if(_loc3_.myChar.isPlaying)
            {
               _loc3_.myChar.stopMusic();
               _loc2_.myChar.playMusic(0,0,_loc3_.myChar.soundChannel.soundTransform);
            }
         }
         else if(param1 == Character.STATE_FADE)
         {
            if(this._state != Character.STATE_ACTION)
            {
               UtilPlain.removeAllSon(this._bundle);
               this._bundle.addChild(this.action.getLoader());
               this.updateActionStaticProperty();
               if(this.motion != null)
               {
                  this.motion.pause();
               }
               if(this.action.isFirstBehavior)
               {
                  this.action.resume();
               }
            }
         }
         else if(param1 == Character.STATE_ACTION)
         {
            if(this._state != Character.STATE_ACTION)
            {
               UtilPlain.removeAllSon(this._bundle);
               this._bundle.addChild(this.action.getLoader());
               this.updateActionStaticProperty();
               if(this.motion != null)
               {
                  this.detachAllProps(this.motion);
                  this.motion.pause();
               }
               if(this.action.isFirstBehavior)
               {
                  this.detachAllProps(this.action);
                  this.action.resume();
               }
               this.attachAllProps(this.action);
               if(this.prop != null && this.prop.isFirstProp)
               {
                  this.prop.resume();
               }
               if(this.head != null && this.head.isFirstProp)
               {
                  this.head.resume();
               }
               if(this.wear != null && this.wear.isFirstProp)
               {
                  this.wear.resume();
               }
               _loc2_ = this.action;
               while(!_loc2_.isFirstBehavior)
               {
                  _loc2_ = _loc2_.prevBehavior;
               }
               if(this.motion != null)
               {
                  _loc3_ = this.motion;
                  while(!_loc3_.isFirstBehavior)
                  {
                     _loc3_ = _loc3_.prevBehavior;
                  }
               }
               _loc2_.myChar.sound = _loc2_.myChar.actionSound;
               if(this.motion != null && _loc3_.myChar.isPlaying)
               {
                  _loc3_.myChar.stopMusic();
                  _loc2_.myChar.playMusic(0,0,_loc3_.myChar.soundChannel.soundTransform);
               }
            }
         }
         super.setState(param1);
      }
      
      public function set isSpeech(param1:Boolean) : void
      {
         this._isSpeech = param1;
      }
      
      public function getActionSound() : Sound
      {
         return this.motionSound;
      }
      
      private function initSound(param1:ExtraDataEvent) : void
      {
         var _loc2_:Class = null;
         if(param1.type == "SoundRdy")
         {
            if(this.action.hasEventListener("SoundRdy"))
            {
               this.action.removeEventListener("SoundRdy",this.initSound);
            }
            _loc2_ = param1.getData() as Class;
            this.actionSound = new _loc2_();
            this.sound = this.actionSound;
         }
         else if(param1.type == "MotionSoundRdy")
         {
            if(this.action.hasEventListener("MotionSoundRdy"))
            {
               this.action.removeEventListener("MotionSoundRdy",this.initSound);
            }
            _loc2_ = param1.getData() as Class;
            this.motionSound = new _loc2_();
         }
      }
      
      public function get head() : Prop
      {
         return this._head;
      }
      
      private function updateMotionStaticProperty() : void
      {
         if(this.motion != null)
         {
            if(this.prop != null)
            {
               this.prop.propagateCharState(Character.STATE_MOTION);
            }
            if(this.head != null)
            {
               this.head.propagateCharState(Character.STATE_MOTION);
            }
            if(this.wear != null)
            {
               this.wear.propagateCharState(AnimeScene.STATE_MOTION);
            }
         }
      }
      
      public function get prop() : Prop
      {
         return this._prop;
      }
      
      public function updateProperties(param1:Number = 0, param2:Number = 0) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:SpeechPitchEvent = null;
         if(!(this._state == Character.STATE_MOTION && !this.motion.getIsBlink()))
         {
            if(this._state == Character.STATE_FADE)
            {
               this._bundle.alpha = 1 - param1;
            }
            else if(this._state == Character.STATE_ACTION)
            {
               if(this._xs.length > 2 && this._ys.length > 2)
               {
                  if(param1 != 0 && param1 != 1)
                  {
                     _loc7_ = 0;
                     this.action.flip(this._facings[0]);
                     do
                     {
                        _loc10_ = _loc7_ - param2;
                        _loc11_ = _loc7_ + param2;
                        _loc8_ = this._spline.getX(_loc7_) - this._spline.getX(_loc10_);
                        _loc9_ = this._spline.getX(_loc11_) - this._spline.getX(_loc7_);
                        if(_loc8_ * _loc9_ < 0 && _loc8_ + _loc9_ != 0)
                        {
                           this.action.flip(Behaviour.CHANGE_FACE);
                        }
                     }
                     while((_loc7_ = _loc7_ + param2) < param1);
                     
                  }
                  this._bundle.x = this._spline.getX(param1);
                  this._bundle.y = this._spline.getY(param1);
               }
               else if(this._xs.length > 1 && this._ys.length > 1)
               {
                  _loc6_ = (_loc5_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._xs.length)) - 1;
                  _loc3_ = 1 / (this._xs.length - 1) * _loc6_;
                  _loc4_ = 1 / (this._xs.length - 1) * _loc5_;
                  this._bundle.x = Number(this._xs[_loc6_]) + (this._xs[_loc5_] - this._xs[_loc6_]) * ((param1 - _loc3_) / (_loc4_ - _loc3_));
                  _loc6_ = (_loc5_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._ys.length)) - 1;
                  _loc3_ = 1 / (this._ys.length - 1) * _loc6_;
                  _loc4_ = 1 / (this._ys.length - 1) * _loc5_;
                  this._bundle.y = Number(this._ys[_loc6_]) + (this._ys[_loc5_] - this._ys[_loc6_]) * ((param1 - _loc3_) / (_loc4_ - _loc3_));
               }
               if(this._xscales.length > 1)
               {
                  _loc6_ = (_loc5_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._xscales.length)) - 1;
                  _loc3_ = 1 / (this._xscales.length - 1) * _loc6_;
                  _loc4_ = 1 / (this._xscales.length - 1) * _loc5_;
                  this._bundle.scaleX = Number(this._xscales[_loc6_]) + (this._xscales[_loc5_] - this._xscales[_loc6_]) * ((param1 - _loc3_) / (_loc4_ - _loc3_));
               }
               if(this._yscales.length > 1)
               {
                  _loc6_ = (_loc5_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._yscales.length)) - 1;
                  _loc3_ = 1 / (this._yscales.length - 1) * _loc6_;
                  _loc4_ = 1 / (this._yscales.length - 1) * _loc5_;
                  this._bundle.scaleY = Number(this._yscales[_loc6_]) + (this._yscales[_loc5_] - this._yscales[_loc6_]) * ((param1 - _loc3_) / (_loc4_ - _loc3_));
               }
               if(this._rotations.length > 1)
               {
                  _loc6_ = (_loc5_ = UtilUnitConvert.getTargetPoint(0,1,param1,this._rotations.length)) - 1;
                  _loc3_ = 1 / (this._rotations.length - 1) * _loc6_;
                  _loc4_ = 1 / (this._rotations.length - 1) * _loc5_;
                  this._bundle.rotation = Number(this._rotations[_loc6_]) + (this._rotations[_loc5_] - this._rotations[_loc6_]) * ((param1 - _loc3_) / (_loc4_ - _loc3_));
               }
               if(this.isCC && param1 == 1)
               {
                  (_loc12_ = new SpeechPitchEvent(SpeechPitchEvent.PITCH)).value = -1;
                  this.currPitch = _loc12_;
               }
            }
         }
      }
      
      public function set motion(param1:Motion) : void
      {
         this._motion = param1;
         if(this._motion != null)
         {
            this._motion.myChar = this;
         }
      }
      
      override public function goToAndPauseReset() : void
      {
         if(this._state == Character.STATE_MOTION)
         {
            this.motion.goToAndPauseReset();
         }
         else if(this._state == Character.STATE_FADE)
         {
            this.action.goToAndPauseReset();
         }
         else if(this._state == Character.STATE_ACTION)
         {
            this.action.goToAndPauseReset();
         }
      }
      
      override public function propagateSceneState(param1:int) : void
      {
         if(param1 == AnimeScene.STATE_ACTION)
         {
            this.setState(Character.STATE_ACTION);
         }
         else if(param1 == AnimeScene.STATE_MOTION)
         {
            if(this._charInNextScene == null)
            {
               this.setState(Character.STATE_FADE);
            }
            else if(this.motion == null)
            {
               this.setState(Character.STATE_ACTION);
            }
            else if(Character.isChanged(this,this._charInNextScene))
            {
               this.setState(Character.STATE_MOTION);
            }
            else
            {
               this.setState(Character.STATE_ACTION);
            }
         }
         else if(param1 == AnimeScene.STATE_NULL)
         {
            this.setState(Character.STATE_NULL);
         }
      }
      
      public function set currPitch(param1:SpeechPitchEvent) : void
      {
         var _loc2_:SpeechPitchEvent = null;
         var _loc3_:SpeechPitchEvent = null;
         if(this.head != null)
         {
            _loc2_ = new SpeechPitchEvent(SpeechPitchEvent.PITCH);
            _loc2_.value = param1.value;
            this.head.dispatchEvent(_loc2_);
         }
         else if(this.action != null)
         {
            _loc3_ = new SpeechPitchEvent(SpeechPitchEvent.PITCH);
            _loc3_.value = param1.value;
            this.action.dispatchEvent(_loc3_);
         }
      }
      
      public function get face() : String
      {
         return this._face;
      }
      
      override public function pause() : void
      {
         var _loc1_:Behaviour = null;
         if(this._state == Character.STATE_MOTION)
         {
            this.motion.pause();
         }
         else if(this._state == Character.STATE_FADE)
         {
            this.action.pause();
         }
         else if(this._state == Character.STATE_ACTION)
         {
            this.action.pause();
         }
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
         if(this.action != null)
         {
            this.detachAllProps(this.action);
            this.action.destroy(param1);
         }
         if(this.motion != null)
         {
            this.detachAllProps(this.motion);
            this.motion.destroy(param1);
         }
         if(this.prop != null)
         {
            this.prop.destroy(param1);
         }
         if(this.wear != null)
         {
            this.wear.destroy(param1);
         }
         if(this.head != null)
         {
            this.head.destroy(param1);
         }
         if(param1)
         {
            this.action = null;
            this.motion = null;
            this.prop = null;
            this.wear = null;
            this.head = null;
         }
      }
      
      public function set action(param1:Action) : void
      {
         this._action = param1;
         if(this._action != null)
         {
            this._action.myChar = this;
         }
      }
   }
}
