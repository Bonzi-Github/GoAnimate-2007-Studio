package anifire.playback
{
   import anifire.component.DownloadManager;
   import anifire.constant.AnimeConstants;
   import anifire.effect.EffectMgr;
   import anifire.event.LoadMgrEvent;
   import anifire.playerEffect.AnimeEffectAsset;
   import anifire.playerEffect.BumpyrideEffectAsset;
   import anifire.playerEffect.DRAlertEffectAsset;
   import anifire.playerEffect.EarthquakeEffectAsset;
   import anifire.playerEffect.EffectAsset;
   import anifire.playerEffect.FadingEffectAsset;
   import anifire.playerEffect.FireSpringEffectAsset;
   import anifire.playerEffect.FireworkEffectAsset;
   import anifire.playerEffect.GrayScaleEffectAsset;
   import anifire.playerEffect.HoveringEffectAsset;
   import anifire.playerEffect.ProgramEffectAsset;
   import anifire.playerEffect.SepiaEffectAsset;
   import anifire.playerEffect.UpsideDownEffectAsset;
   import anifire.playerEffect.ZoomEffectAsset;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUnitConvert;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.system.System;
   
   public class AnimeScene extends EventDispatcher implements IPlayable
   {
      
      public static const STATE_MOTION:int = 3;
      
      public static const STATE_NULL:int = 0;
      
      public static const XML_TAG:String = "scene";
      
      public static const STATE_ACTION:int = 2;
      
      public static const STATE_BUFFER_INITIALIZING:int = 1;
       
      
      private var _segments:UtilHashArray;
      
      private var _characters:UtilHashArray;
      
      private var _bgs:UtilHashArray;
      
      private var _zOrder:int;
      
      private var _actionDuration:Number;
      
      private var _bubbles:UtilHashArray;
      
      private var _parentAnime:Anime;
      
      private var _movieId:String;
      
      private var _props:UtilHashArray;
      
      private var _sceneContainer:DisplayObjectContainer;
      
      private var _motionDuration:Number;
      
      private var _state:int;
      
      private var _visibleAssets:Array;
      
      private var _prevScene:AnimeScene;
      
      private var _bufferProgress:Number = 0;
      
      private var _endFrame:Number;
      
      private var _id:String;
      
      private var _isPreview:Boolean = false;
      
      private var _effects:UtilHashArray;
      
      private var _startFrame:Number;
      
      private var _effectsByType:UtilHashArray;
      
      private var _isRemoteDataIniting:Boolean = false;
      
      private var _nextScene:AnimeScene;
      
      private var extraData:Object;
      
      private var _sceneMasterContainer:DisplayObjectContainer;
      
      private var _duration:Number;
      
      public function AnimeScene()
      {
         this._visibleAssets = new Array();
         this._characters = new UtilHashArray();
         this._bubbles = new UtilHashArray();
         this._bgs = new UtilHashArray();
         this._segments = new UtilHashArray();
         this._props = new UtilHashArray();
         this._effects = new UtilHashArray();
         this._effectsByType = new UtilHashArray();
         super();
      }
      
      public static function compareSceneXmlZorder(param1:XML, param2:XML) : int
      {
         var _loc3_:String = "index";
         var _loc4_:Number = Number(param1.attribute(_loc3_));
         var _loc5_:Number = Number(param2.attribute(_loc3_));
         if(_loc4_ < _loc5_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return 1;
         }
         return 0;
      }
      
      public function getBgByIndex(param1:int) : Background
      {
         return this._bgs.getValueByIndex(param1);
      }
      
      public function getNumEffect() : int
      {
         return this._effects.length;
      }
      
      public function goToAndPause(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc3_:Number = param1 - this.getStartFrame() + 1;
         this.play(param1);
         if(this.getState() == AnimeScene.STATE_ACTION)
         {
            _loc4_ = 1;
         }
         if(this.getState() == AnimeScene.STATE_MOTION)
         {
            _loc4_ = this.getActionDuration();
         }
         else
         {
            _loc4_ = 1;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumChar())
         {
            this.getCharByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBg())
         {
            this.getBgByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBub())
         {
            this.getBubByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumProp())
         {
            this.getPropByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc2_).goToAndPause(_loc3_,param1,this.getState(),_loc4_);
            _loc2_++;
         }
      }
      
      public function get movieInfo() : Object
      {
         return this.parentAnime.movieInfo;
      }
      
      private function getVisibleAssetByIndex(param1:int) : Asset
      {
         return this._visibleAssets[param1] as Asset;
      }
      
      public function getDuration() : Number
      {
         return this._duration;
      }
      
      private function onInitRemoteDataCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onInitRemoteDataCompleted);
         this.setBufferProgress(100);
         this.refreshSceneContainer();
         this.setState(AnimeScene.STATE_NULL);
         this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
      }
      
      public function getSegmentByIndex(param1:int) : Segment
      {
         return this._segments.getValueByIndex(param1);
      }
      
      private function getNumVisibleAsset() : int
      {
         return this._visibleAssets.length;
      }
      
      private function refreshSceneContainer(... rest) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Asset = null;
         UtilPlain.removeAllSon(this.getSceneContainer());
         _loc3_ = this.getNumVisibleAsset();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.getVisibleAssetByIndex(_loc2_);
            this.getSceneContainer().addChild(_loc4_.getBundle());
            _loc2_++;
         }
      }
      
      private function getZorder() : int
      {
         return this._zOrder;
      }
      
      private function setDuration(param1:Number) : void
      {
         this._duration = param1;
      }
      
      public function init(param1:XML, param2:Anime, param3:UtilHashArray, param4:PlayerDataStock, param5:Number, param6:String, param7:Boolean) : void
      {
         var _loc8_:int = 0;
         var _loc9_:Background = null;
         var _loc10_:XML = null;
         var _loc11_:Segment = null;
         var _loc12_:XML = null;
         var _loc13_:Character = null;
         var _loc14_:XML = null;
         var _loc15_:BubbleAsset = null;
         var _loc16_:XML = null;
         var _loc17_:Prop = null;
         var _loc18_:XML = null;
         var _loc19_:XML = null;
         var _loc20_:Sprite = null;
         var _loc21_:String = null;
         var _loc22_:EffectAsset = null;
         var _loc23_:Boolean = false;
         var _loc24_:ZoomEffectAsset = null;
         var _loc25_:EarthquakeEffectAsset = null;
         var _loc26_:HoveringEffectAsset = null;
         var _loc27_:BumpyrideEffectAsset = null;
         var _loc28_:UpsideDownEffectAsset = null;
         var _loc29_:FireworkEffectAsset = null;
         var _loc30_:FireSpringEffectAsset = null;
         var _loc31_:AnimeEffectAsset = null;
         var _loc32_:GrayScaleEffectAsset = null;
         var _loc33_:DRAlertEffectAsset = null;
         var _loc34_:SepiaEffectAsset = null;
         var _loc35_:FadingEffectAsset = null;
         this.id = param1.attribute("id").toString();
         this.setZorder(param1.attribute("index"));
         this.setActionDuration(param1.attribute("adelay"));
         this.setMotionDuration(param1.attribute("mdelay"));
         this.parentAnime = param2;
         this.setSceneMasterContainer(new Sprite());
         this.setSceneContainer(new Sprite());
         this.getSceneMasterContainer().addChild(this.getSceneContainer());
         this.movieId = param6;
         this._isPreview = param7;
         for each(_loc10_ in param1.child(Background.XML_TAG))
         {
            if((_loc9_ = new Background()).init(_loc10_,this,param4))
            {
               this.addBg(_loc9_);
            }
            else
            {
               trace("init Bg failure.");
            }
         }
         for each(_loc12_ in param1.child(Segment.XML_TAG))
         {
            if((_loc11_ = new Segment()).init(_loc12_,this,param4))
            {
               this.addSegment(_loc11_);
            }
            else
            {
               trace("init Segment failure.");
            }
         }
         for each(_loc14_ in param1.child(Character.XML_TAG))
         {
            if((_loc13_ = new Character()).init(_loc14_,this,param3,param4))
            {
               this.addChar(_loc13_);
            }
            else
            {
               trace("init char failure.");
            }
         }
         for each(_loc16_ in param1.child(BubbleAsset.XML_TAG))
         {
            if((_loc15_ = new BubbleAsset()).init(_loc16_,this,param5,param7))
            {
               this.addBubble(_loc15_);
            }
            else
            {
               trace("init Bubble failure.");
            }
         }
         for each(_loc18_ in param1.child(Prop.XML_TAG))
         {
            if((_loc17_ = new Prop()).init(_loc18_,this,param4))
            {
               this.addProp(_loc17_);
            }
            else
            {
               trace("init prop failure.");
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            if(param5 <= 2)
            {
               continue;
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  _loc20_ = new Sprite();
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  this.getSceneMasterContainer().addChild(_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
                  (_loc22_ = new ZoomEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_EARTHQUAKE:
                  (_loc22_ = new EarthquakeEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_HOVERING:
                  (_loc22_ = new HoveringEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_BUMPYRIDE:
                  (_loc22_ = new BumpyrideEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_UPSIDEDOWN:
                  (_loc22_ = new UpsideDownEffectAsset()).init(_loc19_,this,_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  this.addEffect(_loc22_);
                  continue;
               default:
                  continue;
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            _loc23_ = false;
            _loc20_ = new Sprite();
            switch(_loc21_)
            {
               case EffectMgr.TYPE_FIREWORK:
               case EffectMgr.TYPE_FIRESPRING:
               case EffectMgr.TYPE_ANIME:
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  this.getSceneMasterContainer().addChild(_loc20_);
            }
            if(_loc21_ == EffectMgr.TYPE_FIREWORK)
            {
               (_loc22_ = new FireworkEffectAsset()).init(_loc19_,this,_loc20_);
               _loc23_ = true;
            }
            else if(_loc21_ == EffectMgr.TYPE_FIRESPRING)
            {
               (_loc22_ = new FireSpringEffectAsset()).init(_loc19_,this,_loc20_);
               _loc23_ = true;
            }
            else if(_loc21_ == EffectMgr.TYPE_ANIME)
            {
               _loc23_ = (_loc22_ = new AnimeEffectAsset()).init(_loc19_,this,param4,_loc20_);
            }
            if(_loc23_)
            {
               trace("add effect:" + _loc22_.id);
               this.addEffect(_loc22_);
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            if(param5 > 2)
            {
               continue;
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  _loc20_ = new Sprite();
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  this.getSceneMasterContainer().addChild(_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
                  (_loc22_ = new ZoomEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_EARTHQUAKE:
                  (_loc22_ = new EarthquakeEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_HOVERING:
                  (_loc22_ = new HoveringEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_BUMPYRIDE:
                  (_loc22_ = new BumpyrideEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_UPSIDEDOWN:
                  (_loc22_ = new UpsideDownEffectAsset()).init(_loc19_,this,_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_ZOOM:
               case EffectMgr.TYPE_EARTHQUAKE:
               case EffectMgr.TYPE_HOVERING:
               case EffectMgr.TYPE_BUMPYRIDE:
               case EffectMgr.TYPE_UPSIDEDOWN:
                  this.addEffect(_loc22_);
                  continue;
               default:
                  continue;
            }
         }
         for each(_loc19_ in param1.child(EffectAsset.XML_TAG))
         {
            _loc21_ = EffectAsset.getEffectType(_loc19_);
            switch(_loc21_)
            {
               case EffectMgr.TYPE_GRAYSCALE:
               case EffectMgr.TYPE_DRALERT:
               case EffectMgr.TYPE_SEPIA:
               case EffectMgr.TYPE_FADING:
                  _loc20_ = new Sprite();
                  UtilPlain.switchParent(this.getSceneMasterContainer(),_loc20_);
                  this.getSceneMasterContainer().addChild(_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_GRAYSCALE:
                  (_loc22_ = new GrayScaleEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_DRALERT:
                  (_loc22_ = new DRAlertEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_SEPIA:
                  (_loc22_ = new SepiaEffectAsset()).init(_loc19_,this,_loc20_);
                  break;
               case EffectMgr.TYPE_FADING:
                  (_loc22_ = new FadingEffectAsset()).init(_loc19_,this,_loc20_);
            }
            switch(_loc21_)
            {
               case EffectMgr.TYPE_GRAYSCALE:
               case EffectMgr.TYPE_DRALERT:
               case EffectMgr.TYPE_SEPIA:
               case EffectMgr.TYPE_FADING:
                  this.addEffect(_loc22_);
                  continue;
               default:
                  continue;
            }
         }
         this.setDuration(this.getActionDuration() + this.getMotionDuration());
         this.setState(AnimeScene.STATE_NULL);
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function setVolume(param1:Number) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.getNumProp())
         {
            this.getPropByIndex(_loc2_).setVolume(param1);
            _loc2_++;
         }
      }
      
      private function setZorder(param1:int) : void
      {
         this._zOrder = param1;
      }
      
      public function get prevScene() : AnimeScene
      {
         return this._prevScene;
      }
      
      private function isBubExist(param1:String) : Boolean
      {
         return this._bubbles.containsKey(param1);
      }
      
      private function setStartFrame(param1:Number) : void
      {
         this._startFrame = param1;
      }
      
      private function isBgExist(param1:String) : Boolean
      {
         return this._bgs.containsKey(param1);
      }
      
      public function getStartFrame() : Number
      {
         return this._startFrame;
      }
      
      public function getLastActionFrame() : Number
      {
         return this.getStartFrame() + this.getActionDuration();
      }
      
      private function getEffectsByType(param1:String) : UtilHashArray
      {
         return this._effectsByType.getValueByKey(param1);
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      private function reArrangeVisibleAsset() : void
      {
         Asset.reArrangeZorder(this._visibleAssets);
      }
      
      public function getEffectByIndex(param1:int) : EffectAsset
      {
         return this._effects.getValueByIndex(param1);
      }
      
      public function resume() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.getNumChar())
         {
            this.getCharByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBg())
         {
            this.getBgByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBub())
         {
            this.getBubByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumProp())
         {
            this.getPropByIndex(_loc1_).resume();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc1_).resume();
            _loc1_++;
         }
      }
      
      private function isCharExist(param1:String) : Boolean
      {
         return this._characters.containsKey(param1);
      }
      
      public function set setExtraData(param1:Object) : void
      {
         this.extraData = param1;
      }
      
      public function initRemoteData(param1:PlayerDataStock) : void
      {
         var _loc2_:UtilLoadMgr = null;
         var _loc3_:int = 0;
         var _loc4_:Background = null;
         var _loc5_:Segment = null;
         var _loc6_:Character = null;
         var _loc7_:BubbleAsset = null;
         var _loc8_:Prop = null;
         var _loc9_:EffectAsset = null;
         if(this.getBufferProgress() >= 100)
         {
            this.dispatchEvent(new PlayerEvent(PlayerEvent.INIT_REMOTE_DATA_COMPLETE));
            return;
         }
         if(this.getState() != AnimeScene.STATE_BUFFER_INITIALIZING)
         {
            _loc2_ = new UtilLoadMgr();
            _loc2_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onInitRemoteDataCompleted,false,0,true);
            _loc3_ = 0;
            _loc3_ = 0;
            while(_loc3_ < this.getNumBg())
            {
               _loc4_ = this.getBgByIndex(_loc3_);
               _loc2_.addEventDispatcher(_loc4_.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc4_.initRemoteData(param1);
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.getNumSegment())
            {
               _loc5_ = this.getSegmentByIndex(_loc3_);
               _loc2_.addEventDispatcher(_loc5_.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc5_.initRemoteData(param1);
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.getNumChar())
            {
               _loc6_ = this.getCharByIndex(_loc3_);
               _loc2_.addEventDispatcher(_loc6_.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc6_.initRemoteData(param1);
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.getNumBub())
            {
               _loc7_ = this.getBubByIndex(_loc3_);
               _loc2_.addEventDispatcher(_loc7_.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc7_.initRemoteData();
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.getNumProp())
            {
               _loc8_ = this.getPropByIndex(_loc3_);
               _loc2_.addEventDispatcher(_loc8_.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc8_.initRemoteData(param1);
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.getNumEffect())
            {
               _loc9_ = this.getEffectByIndex(_loc3_);
               _loc2_.addEventDispatcher(_loc9_.getEventDispatcher(),PlayerEvent.INIT_REMOTE_DATA_COMPLETE);
               _loc9_.initRemoteData(param1);
               _loc3_++;
            }
            this.setState(AnimeScene.STATE_BUFFER_INITIALIZING);
            _loc2_.commit();
         }
      }
      
      private function getBubByIndex(param1:int) : BubbleAsset
      {
         return this._bubbles.getValueByIndex(param1);
      }
      
      public function play(param1:Number, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Array = this._characters.getArray();
         var _loc8_:Array = this._bubbles.getArray();
         var _loc9_:Array = this._bgs.getArray();
         var _loc10_:Array = this._props.getArray();
         var _loc11_:Array = this._effects.getArray();
         if(param1 < this.getLastActionFrame() || this._nextScene == null)
         {
            if(this.getState() != AnimeScene.STATE_ACTION)
            {
               this.setState(AnimeScene.STATE_ACTION);
            }
            _loc5_ = param1 - this._startFrame;
            _loc4_ = this.getNumBub();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc8_[_loc3_].updateProperties(_loc5_);
               _loc3_++;
            }
            _loc5_ = (param1 - this._startFrame) / (this._actionDuration - 1);
            _loc6_ = 1 / (this._actionDuration - 1);
            _loc4_ = this.getNumChar();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc7_[_loc3_].updateProperties(_loc5_,_loc6_);
               _loc3_++;
            }
            _loc4_ = this.getNumProp();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc10_[_loc3_].updateProperties(_loc5_);
               _loc3_++;
            }
         }
         else
         {
            _loc5_ = (param1 - this._startFrame - this._actionDuration + 1) / (this._endFrame - this._startFrame - this._actionDuration + 1);
            if(this.getState() != AnimeScene.STATE_MOTION)
            {
               this.setState(AnimeScene.STATE_MOTION);
            }
            _loc4_ = this.getNumChar();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc7_[_loc3_].updateProperties(_loc5_);
               _loc3_++;
            }
            _loc4_ = this.getNumBub();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc8_[_loc3_].updateProperties(_loc5_);
               _loc3_++;
            }
            _loc4_ = this.getNumBg();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc9_[_loc3_].updateProperties(_loc5_);
               _loc3_++;
            }
            _loc4_ = this.getNumProp();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc10_[_loc3_].updateProperties(_loc5_);
               _loc3_++;
            }
         }
         _loc4_ = this.getNumEffect();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc11_[_loc3_].play(param1);
            _loc3_++;
         }
      }
      
      public function get getExtraData() : Object
      {
         return this.extraData;
      }
      
      private function isPropExist(param1:String) : Boolean
      {
         return this._props.containsKey(param1);
      }
      
      private function getSceneContainer() : DisplayObjectContainer
      {
         return this._sceneContainer;
      }
      
      public function getCharByIndex(param1:int) : Character
      {
         return this._characters.getValueByIndex(param1);
      }
      
      private function addSegment(param1:Segment) : void
      {
         this._segments.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      private function setSceneContainer(param1:DisplayObjectContainer) : void
      {
         this._sceneContainer = param1;
      }
      
      public function get nextScene() : AnimeScene
      {
         return this._nextScene;
      }
      
      public function getPropById(param1:String) : Prop
      {
         return this._props.getValueByKey(param1);
      }
      
      private function isEffectExist(param1:String) : Boolean
      {
         return this._effects.containsKey(param1);
      }
      
      public function getSegmentByID(param1:String) : Segment
      {
         return this._segments.getValueByKey(param1);
      }
      
      private function getMotionDuration() : Number
      {
         return this._motionDuration;
      }
      
      private function setState(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.getNumChar();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getCharByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumBg();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getBgByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumBub();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getBubByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumProp();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getPropByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumEffect();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getEffectByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         _loc2_ = this.getNumSegment();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this.getSegmentByIndex(_loc3_).propagateSceneState(param1);
            _loc3_++;
         }
         this.refreshSceneContainer();
         this._state = param1;
      }
      
      public function get movieId() : String
      {
         return this._movieId;
      }
      
      private function setMotionDuration(param1:Number) : void
      {
         this._motionDuration = 0;
      }
      
      public function goToAndPauseReset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = this.getStartFrame();
         this.play(_loc2_,true);
         _loc1_ = 0;
         while(_loc1_ < this.getNumChar())
         {
            this.getCharByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBg())
         {
            this.getBgByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBub())
         {
            this.getBubByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumProp())
         {
            this.getPropByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc1_).goToAndPauseReset();
            _loc1_++;
         }
         this.setState(STATE_NULL);
      }
      
      public function initDependency(param1:AnimeScene, param2:AnimeScene, param3:Number, param4:DownloadManager, param5:UtilHashArray) : void
      {
         var _loc6_:int = 0;
         var _loc10_:UtilHashArray = null;
         var _loc14_:Character = null;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:BubbleAsset = null;
         var _loc18_:Segment = null;
         var _loc19_:Background = null;
         var _loc20_:Background = null;
         var _loc21_:Number = NaN;
         var _loc22_:Prop = null;
         var _loc23_:EffectAsset = null;
         var _loc24_:ZoomEffectAsset = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:ZoomEffectAsset = null;
         var _loc29_:UtilHashArray = null;
         var _loc30_:EarthquakeEffectAsset = null;
         var _loc31_:BumpyrideEffectAsset = null;
         var _loc32_:HoveringEffectAsset = null;
         var _loc33_:DRAlertEffectAsset = null;
         var _loc34_:GrayScaleEffectAsset = null;
         var _loc35_:SepiaEffectAsset = null;
         var _loc36_:FadingEffectAsset = null;
         var _loc37_:UpsideDownEffectAsset = null;
         var _loc38_:FireworkEffectAsset = null;
         var _loc39_:FireSpringEffectAsset = null;
         var _loc40_:AnimeEffectAsset = null;
         this._prevScene = param2;
         this._nextScene = param1;
         this.setStartFrame(param3);
         this.setEndFrame(this.getStartFrame() + this.getDuration());
         Character.connectCharacters(this._characters,param1 != null?param1._characters:null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumChar())
         {
            _loc14_ = this.getCharByIndex(_loc6_);
            _loc15_ = param2 != null?Number(param2.getActionDuration()):Number(0);
            _loc16_ = param2 != null?Number(param2.getMotionDuration()):Number(0);
            _loc14_.initDependency(this.getActionDuration(),this.getMotionDuration(),_loc15_,_loc16_,param5);
            _loc6_++;
         }
         BubbleAsset.connectBubblesBetweenScenes(this._bubbles,param1 != null?param1._bubbles:null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumBub())
         {
            (_loc17_ = this.getBubByIndex(_loc6_)).initDependency();
            _loc6_++;
         }
         Segment.connectSegment(this._segments,param1 != null?param1._segments:null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumSegment())
         {
            (_loc18_ = this.getSegmentByIndex(_loc6_)).initDependency();
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < this.getNumBg())
         {
            _loc19_ = this.getBgByIndex(_loc6_);
            _loc21_ = 0;
            if(this._prevScene != null)
            {
               _loc20_ = !!this._prevScene.isBgExist(_loc19_.id)?this._prevScene.getBgByID(_loc19_.id):null;
               _loc21_ = this._prevScene.getDuration();
            }
            else
            {
               _loc20_ = null;
            }
            _loc19_.initDependency(_loc20_,_loc21_);
            _loc6_++;
         }
         Prop.connectPropsBetweenScenes(this._props,param1 != null?param1._props:null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumProp())
         {
            (_loc22_ = this.getPropByIndex(_loc6_) as Prop).initDependency(param4,param5);
            _loc6_++;
         }
         var _loc7_:ZoomEffectAsset = null;
         var _loc8_:ZoomEffectAsset = null;
         var _loc9_:ZoomEffectAsset = null;
         _loc10_ = this.getEffectsByType(EffectMgr.TYPE_ZOOM);
         var _loc11_:int = 0;
         if(_loc10_ != null && _loc10_.length > 0)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc10_.length)
            {
               if(((_loc9_ = _loc10_.getValueByIndex(_loc11_) as ZoomEffectAsset).id as String).indexOf("dummy") == -1)
               {
                  _loc7_ = _loc9_;
               }
               _loc11_++;
            }
         }
         if(param2 != null)
         {
            if((_loc10_ = param2.getEffectsByType(EffectMgr.TYPE_ZOOM)) != null && _loc10_.length > 0)
            {
               _loc11_ = 0;
               while(_loc11_ < _loc10_.length)
               {
                  if(((_loc9_ = _loc10_.getValueByIndex(_loc11_) as ZoomEffectAsset).id as String).indexOf("dummy") == -1)
                  {
                     _loc8_ = _loc9_;
                  }
                  _loc11_++;
               }
            }
         }
         var _loc12_:Sprite = new Sprite();
         var _loc13_:ZoomEffectAsset = new ZoomEffectAsset();
         if(ZoomEffectAsset.isDummyZoomNeededForCurrentZoom(_loc7_))
         {
            (_loc13_ = new ZoomEffectAsset()).initDummyZoom(this,_loc7_.effectee,null,_loc7_,_loc13_.MODE_EXT);
            this.addEffect(_loc13_);
         }
         AnimeEffectAsset.connectEffectsBetweenScenes(this.getEffectsByType(EffectMgr.TYPE_ANIME),param1 != null?param1.getEffectsByType(EffectMgr.TYPE_ANIME):null);
         _loc6_ = 0;
         while(_loc6_ < this.getNumEffect())
         {
            if((_loc23_ = this.getEffectByIndex(_loc6_)).getType() == EffectMgr.TYPE_ZOOM)
            {
               if((_loc24_ = _loc23_ as ZoomEffectAsset).mode == _loc24_.MODE_NOR)
               {
                  if(_loc24_.sttime == 0 && _loc24_.edtime == 0)
                  {
                     _loc25_ = this.getStartFrame();
                     _loc27_ = UtilUnitConvert.secToFrame(AnimeConstants.ZOOM_DURATION);
                     if(this.getDuration() < _loc27_)
                     {
                        _loc27_ = this.getDuration() - 1;
                     }
                     _loc26_ = _loc25_ + _loc27_;
                     if(_loc24_.pan)
                     {
                        _loc27_ = this.getDuration() - 1;
                        _loc26_ = _loc25_ + _loc27_;
                     }
                  }
                  else
                  {
                     _loc25_ = _loc24_.sttime + this.getStartFrame() - 1;
                     _loc27_ = UtilUnitConvert.secToFrame(_loc24_.stzoom);
                     if(_loc25_ + _loc27_ > this.getDuration() + this.getStartFrame())
                     {
                        _loc27_ = this.getDuration() + this.getStartFrame() - _loc25_ - 1;
                     }
                     if(_loc24_.pan)
                     {
                        _loc27_ = _loc24_.edtime - _loc24_.sttime - 1;
                     }
                     _loc26_ = _loc25_ + _loc27_;
                  }
               }
               else if(_loc24_.mode == _loc24_.MODE_EXT)
               {
                  if(_loc24_.refZoom.sttime == 0 && _loc24_.refZoom.edtime == 0)
                  {
                     _loc27_ = UtilUnitConvert.secToFrame(AnimeConstants.ZOOM_DURATION);
                     _loc25_ = this.getDuration() + this.getStartFrame() - _loc27_;
                  }
                  else
                  {
                     _loc25_ = _loc24_.refZoom.edtime + this.getStartFrame();
                     _loc27_ = UtilUnitConvert.secToFrame(_loc24_.edzoom);
                     if(_loc25_ + _loc27_ > this.getDuration() + this.getStartFrame())
                     {
                        _loc27_ = this.getDuration() + this.getStartFrame() - _loc25_;
                     }
                  }
                  _loc26_ = _loc25_ + _loc27_;
               }
               else if(_loc24_.mode == _loc24_.MODE_PRE)
               {
               }
               if(param2 != null)
               {
                  if((_loc29_ = param2.getEffectsByType(_loc24_.getType())) != null && _loc29_.length > 0)
                  {
                     _loc11_ = 0;
                     while(_loc11_ < _loc29_.length)
                     {
                        if(((_loc9_ = _loc29_.getValueByIndex(_loc11_) as ZoomEffectAsset).id as String).indexOf("dummy") == -1)
                        {
                           _loc28_ = _loc9_;
                        }
                        _loc11_++;
                     }
                  }
               }
               _loc24_.initDependency(_loc25_,_loc26_,_loc28_);
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_EARTHQUAKE)
            {
               (_loc30_ = _loc23_ as EarthquakeEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_BUMPYRIDE)
            {
               (_loc31_ = _loc23_ as BumpyrideEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_HOVERING)
            {
               (_loc32_ = _loc23_ as HoveringEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_DRALERT)
            {
               (_loc33_ = _loc23_ as DRAlertEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_GRAYSCALE)
            {
               (_loc34_ = _loc23_ as GrayScaleEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_SEPIA)
            {
               (_loc35_ = _loc23_ as SepiaEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_FADING)
            {
               (_loc36_ = _loc23_ as FadingEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_UPSIDEDOWN)
            {
               (_loc37_ = _loc23_ as UpsideDownEffectAsset).initDependency(this.getStartFrame(),this.getEndFrame());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_FIREWORK)
            {
               (_loc38_ = _loc23_ as FireworkEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_FIRESPRING)
            {
               (_loc39_ = _loc23_ as FireSpringEffectAsset).initDependency(this.getStartFrame(),this.getActionDuration() + this.getMotionDuration());
            }
            else if(_loc23_.getType() == EffectMgr.TYPE_ANIME)
            {
               (_loc40_ = _loc23_ as AnimeEffectAsset).initDependency(this.getStartFrame(),this.getEndFrame());
            }
            _loc6_++;
         }
         this.reArrangeVisibleAsset();
      }
      
      public function getBufferProgress() : Number
      {
         return this._bufferProgress;
      }
      
      private function getBubByID(param1:String) : BubbleAsset
      {
         return this._bubbles.getValueByKey(param1);
      }
      
      private function addBubble(param1:BubbleAsset) : void
      {
         this._bubbles.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      private function setBufferProgress(param1:Number) : void
      {
         this._bufferProgress = param1;
      }
      
      public function getSceneMasterContainer() : DisplayObjectContainer
      {
         return this._sceneMasterContainer;
      }
      
      private function setSceneMasterContainer(param1:DisplayObjectContainer) : void
      {
         this._sceneMasterContainer = param1;
      }
      
      private function addChar(param1:Character) : void
      {
         this._characters.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      private function addEffect(param1:EffectAsset) : void
      {
         var _loc3_:UtilHashArray = null;
         this._effects.push(param1.id,param1);
         if(!(param1 is ProgramEffectAsset))
         {
            this.addVisibleAsset(param1);
         }
         var _loc2_:String = param1.getType();
         if(!this._effectsByType.containsKey(_loc2_))
         {
            this._effectsByType.push(_loc2_,new UtilHashArray());
         }
         _loc3_ = this._effectsByType.getValueByKey(_loc2_) as UtilHashArray;
         _loc3_.push(param1.id,param1);
      }
      
      public function restoreEffects() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = this._effects.getArray();
         _loc2_ = this.getNumEffect();
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc3_[_loc1_] is ZoomEffectAsset)
            {
               ZoomEffectAsset(_loc3_[_loc1_]).restore();
            }
            else if(_loc3_[_loc1_] is GrayScaleEffectAsset)
            {
               GrayScaleEffectAsset(_loc3_[_loc1_]).restore();
            }
            _loc1_++;
         }
         System.gc();
      }
      
      public function getBgByID(param1:String) : Background
      {
         return this._bgs.getValueByKey(param1);
      }
      
      public function getCharByID(param1:String) : Character
      {
         return this._characters.getValueByKey(param1);
      }
      
      public function getPropByIndex(param1:int) : Prop
      {
         return this._props.getValueByIndex(param1);
      }
      
      private function addProp(param1:Prop) : void
      {
         this._props.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      public function getNumBg() : int
      {
         return this._bgs.length;
      }
      
      public function startPlay() : void
      {
         this.setState(AnimeScene.STATE_NULL);
         PlayerConstant.goToAndStopFamilyAt1(this.getSceneContainer());
         PlayerConstant.playFamily(this.getSceneContainer());
      }
      
      public function getNumChar() : int
      {
         return this._characters.length;
      }
      
      public function getEndFrame() : Number
      {
         return this._endFrame;
      }
      
      private function addBg(param1:Background) : void
      {
         this._bgs.push(param1.id,param1);
         this.addVisibleAsset(param1);
      }
      
      private function isSegmentExist(param1:String) : Boolean
      {
         return this._segments.containsKey(param1);
      }
      
      public function getNumSegment() : int
      {
         return this._segments.length;
      }
      
      public function getNumProp() : int
      {
         return this._props.length;
      }
      
      public function set movieId(param1:String) : void
      {
         this._movieId = param1;
      }
      
      private function set parentAnime(param1:Anime) : void
      {
         this._parentAnime = param1;
      }
      
      private function addVisibleAsset(param1:Asset) : void
      {
         this._visibleAssets.push(param1);
      }
      
      private function getActionDuration() : Number
      {
         return this._actionDuration;
      }
      
      private function setEndFrame(param1:Number) : void
      {
         this._endFrame = param1;
      }
      
      private function get parentAnime() : Anime
      {
         return this._parentAnime;
      }
      
      private function setActionDuration(param1:Number) : void
      {
         this._actionDuration = param1;
      }
      
      public function pause() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.getNumChar())
         {
            this.getCharByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBg())
         {
            this.getBgByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumBub())
         {
            this.getBubByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumProp())
         {
            this.getPropByIndex(_loc1_).pause();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc1_).pause();
            _loc1_++;
         }
      }
      
      public function getEffectById(param1:String) : EffectAsset
      {
         return this._effects.getValueByKey(param1);
      }
      
      public function destroy(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         this.setState(AnimeScene.STATE_NULL);
         _loc2_ = 0;
         while(_loc2_ < this.getNumChar())
         {
            this.getCharByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBg())
         {
            this.getBgByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumBub())
         {
            this.getBubByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumProp())
         {
            this.getPropByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumSegment())
         {
            this.getSegmentByIndex(_loc2_).destroy(param1);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.getNumEffect())
         {
            this.getEffectByIndex(_loc2_).destroy();
            _loc2_++;
         }
      }
      
      private function getState() : int
      {
         return this._state;
      }
      
      private function getNumBub() : int
      {
         return this._bubbles.length;
      }
   }
}
