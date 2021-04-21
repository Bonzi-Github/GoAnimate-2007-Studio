package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.command.ICommand;
   import anifire.command.RemoveAssetCommand;
   import anifire.command.ResizeAssetsCommand;
   import anifire.component.CustomCharacterMaker;
   import anifire.component.CustomHeadMaker;
   import anifire.components.studio.AssetToolTip;
   import anifire.constant.AnimeConstants;
   import anifire.constant.CcLibConstant;
   import anifire.control.Control;
   import anifire.event.ExtraDataEvent;
   import anifire.events.AssetEvent;
   import anifire.util.ExtraDataTimer;
   import anifire.util.UtilArray;
   import anifire.util.UtilColor;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.controls.TextArea;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class Asset implements IEventDispatcher
   {
      
      private static var _assetCount:int = 0;
      
      private static var _logger:ILogger = Log.getLogger("core.Asset");
       
      
      protected var _originalAssetScaleX:Number;
      
      protected var _originalAssetScaleY:Number;
      
      private var _sound:Sound;
      
      private var _type:String = "";
      
      private var _defaultColorSetId:String = "";
      
      private var _soundPos:Number = 0;
      
      private var _control:Control;
      
      private var _imageData:Object;
      
      private var _height:Number;
      
      private var _controlVisible:Boolean;
      
      private var _motionDistTip:TextArea;
      
      protected var _widths:Array;
      
      protected var _minHeight:Number = 3;
      
      protected var _facings:Array;
      
      protected var _scaleXs:Array;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _isMusicPlaying:Boolean = false;
      
      private var _customColor:UtilHashArray;
      
      protected var _originalAssetX:Number;
      
      protected var _originalAssetY:Number;
      
      protected var _scaleYs:Array;
      
      private var _width:Number;
      
      private var _soundChannel:SoundChannel;
      
      private var _thumb:Thumb;
      
      private var _sizeToolTip:AssetToolTip = null;
      
      protected var _heights:Array;
      
      private var _defaultColorSet:UtilHashArray;
      
      private var _capScreenLock:Boolean = false;
      
      protected var _rotations:Array;
      
      private var _isMovingByKey:Boolean = false;
      
      private var _isLoadded:Boolean;
      
      private var _scaleX:Number = 1;
      
      private var _scaleY:Number = 1;
      
      private var _changed:Boolean;
      
      private var _scene:AnimeScene;
      
      protected var _xs:Array;
      
      private var _bundle:Image;
      
      protected var _originalAssetFacing:String;
      
      protected var _ys:Array;
      
      private var _id:String;
      
      private var _isFreeze:Boolean = false;
      
      private var _resize:Boolean;
      
      protected var _minWidth:Number = 3;
      
      private var _displayElement:UIComponent;
      
      public function Asset()
      {
         this._eventDispatcher = new EventDispatcher();
         this._motionDistTip = new TextArea();
         super();
         _logger.debug("Asset initialized");
         ++_assetCount;
         this._bundle = new Image();
         this.displayElement = new UIComponent();
         this.customColor = new UtilHashArray();
         this.defaultColorSet = new UtilHashArray();
      }
      
      public function deleteAsset(param1:Boolean = true) : void
      {
         var command:ICommand = null;
         var sound:AnimeSound = null;
         var charId:String = null;
         var undoable:Boolean = param1;
         trace("delete asset: " + this.id);
         var soundId:String = Console.getConsole().linkageController.deleteLinkage(this);
         if(undoable)
         {
            if(soundId != "")
            {
               sound = Console.getConsole().speechManager.ttsManager.sounds.getValueByKey(soundId) as AnimeSound;
               charId = this.scene.id + AssetLinkage.LINK + this.id;
               command = new RemoveAssetCommand(sound,charId);
            }
            else
            {
               command = new RemoveAssetCommand();
            }
            command.execute();
         }
         this.stopMusic(true);
         if(this.imageObject is Loader)
         {
            Loader(this.imageObject).unloadAndStop();
         }
         try
         {
            this._scene.canvas.removeChild(this.bundle);
         }
         catch(e:ArgumentError)
         {
            trace(e);
         }
         if(this is ProgramEffectAsset && ProgramEffectAsset(this).motionShadow != null)
         {
            this._scene.canvas.removeChild(ProgramEffectAsset(this).motionShadow.bundle);
         }
         this._scene.removeAsset(this);
         this.changed = true;
         if(soundId != "")
         {
            Console.getConsole().speechManager.removeSoundById(soundId);
         }
      }
      
      public function doChangeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc3_:Number = 0;
         var _loc4_:UtilHashArray = new UtilHashArray();
         return Number(this.changeColor(param1,param2));
      }
      
      protected function onCtrlPointUpHandler(param1:Event) : void
      {
         this.sizeToolTip.visible = false;
      }
      
      public function setToolTipContent(param1:Number, param2:Number) : void
      {
         this.sizeToolTip.setToolTipContent(param1,param2,1 / Console.getConsole().stageScale);
      }
      
      public function updateColor() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SelectedColor = null;
         if(this.customColor.length == 0)
         {
            if(!this.thumb.isCC && this.imageObject != null)
            {
               UtilColor.resetAssetPartsColor(this.movieObject);
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < this.customColor.length)
            {
               _loc2_ = SelectedColor(this.customColor.getValueByIndex(_loc1_));
               this.changeColor(_loc2_.areaName,_loc2_.dstColor);
               _loc1_++;
            }
         }
      }
      
      function doDragExit(param1:DragEvent) : void
      {
      }
      
      private function removeCCUsedColor(param1:Array) : Array
      {
         var _loc2_:Array = null;
         return param1.filter(this.isNotInsideCC);
      }
      
      public function set sound(param1:Sound) : void
      {
         this._sound = param1;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
         var _loc2_:RegExp = /\d/;
         var _loc3_:int = int(param1.substr(param1.search(_loc2_)));
         _assetCount = _loc3_ > _assetCount?int(_loc3_):int(_assetCount);
      }
      
      public function getOriginalAssetPosition() : Point
      {
         return new Point(this._originalAssetX,this._originalAssetY);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      private function re_playMusic(param1:TimerEvent) : void
      {
         (param1.currentTarget as ExtraDataTimer).removeEventListener(TimerEvent.TIMER,this.re_playMusic);
         var _loc2_:Object = (param1.currentTarget as ExtraDataTimer).getData();
         var _loc3_:Number = _loc2_.startTime;
         var _loc4_:int = _loc2_.loops;
         var _loc5_:SoundTransform = _loc2_.sndTransform;
         this.playMusic(_loc3_,_loc4_,_loc5_);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set height(param1:Number) : void
      {
         this._height = param1;
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function set capScreenLock(param1:Boolean) : void
      {
         this._capScreenLock = param1;
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function get controlVisible() : Boolean
      {
         return this._controlVisible;
      }
      
      public function hideButtonBar() : void
      {
         Console.getConsole().mainStage.hideAssetButtonBar();
      }
      
      public function get customColor() : UtilHashArray
      {
         return this._customColor;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function muteSound(param1:Boolean) : void
      {
         if(this.soundChannel != null)
         {
            if(param1)
            {
               this.soundChannel.soundTransform = new SoundTransform(0);
            }
            else
            {
               this.soundChannel.soundTransform = new SoundTransform(1);
            }
         }
      }
      
      public function flipIt() : void
      {
      }
      
      public function get y() : Number
      {
         return this._bundle.y;
      }
      
      public function get imageObject() : DisplayObject
      {
         if(this.displayElement != null)
         {
            return this.displayElement.getChildByName(AnimeConstants.IMAGE_OBJECT_NAME);
         }
         return null;
      }
      
      public function get motionDistTip() : TextArea
      {
         return this._motionDistTip;
      }
      
      public function get bundle() : Image
      {
         return this._bundle;
      }
      
      public function get x() : Number
      {
         return this._bundle.x;
      }
      
      public function get movieObject() : DisplayObject
      {
         if(this.imageObject is Loader)
         {
            if(this.imageObject != null)
            {
               return Loader(this.imageObject).content;
            }
         }
         else if(this.imageObject is CustomCharacterMaker || this.imageObject is CustomHeadMaker)
         {
            return this.imageObject;
         }
         return null;
      }
      
      public function doKeyDown(param1:KeyboardEvent) : void
      {
      }
      
      public function freeze(param1:Boolean = true) : void
      {
         this.displayElement.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.displayElement.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.displayElement.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.displayElement.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.displayElement.removeEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this._isFreeze = true;
      }
      
      public function get scene() : AnimeScene
      {
         return this._scene;
      }
      
      public function set scaleX(param1:Number) : void
      {
         if(this.imageObject && this.imageObject.width > 0 && this.imageObject.width * param1 < this._minWidth)
         {
            this._scaleX = this._minWidth / this.imageObject.width;
         }
         else
         {
            this._scaleX = param1;
         }
      }
      
      private function unhightlight() : void
      {
         if(this.displayElement)
         {
            this.displayElement.filters = [];
         }
      }
      
      public function set scaleY(param1:Number) : void
      {
         if(this.imageObject && this.imageObject.height > 0 && this.imageObject.height * param1 < this._minHeight)
         {
            this._scaleY = this._minHeight / this.imageObject.height;
         }
         else
         {
            this._scaleY = param1;
         }
      }
      
      public function updateOriginalAssetPosition() : void
      {
         this._originalAssetX = this.x;
         this._originalAssetY = this.y;
      }
      
      public function get sizeToolTip() : AssetToolTip
      {
         return AssetToolTip.getInstance();
      }
      
      public function unloadAssetImage(param1:Boolean) : void
      {
         var _loc2_:CustomCharacterMaker = null;
         var _loc3_:Loader = null;
         if(this.imageObject is Loader)
         {
            Loader(this.imageObject).unloadAndStop(param1);
         }
         else if(this.imageObject is CustomCharacterMaker)
         {
            CustomCharacterMaker(this.imageObject).unloadAssetImage(param1);
         }
         this.displayElement = new UIComponent();
         this.melt();
         if(this.thumb.isCC)
         {
            if(this is Character)
            {
               _loc2_ = new CustomCharacterMaker();
               _loc2_.name = AnimeConstants.IMAGE_OBJECT_NAME;
               this.displayElement.addChild(_loc2_);
            }
         }
         else
         {
            _loc3_ = new Loader();
            _loc3_.name = AnimeConstants.IMAGE_OBJECT_NAME;
            this.displayElement.addChild(_loc3_);
         }
         this.imageData = null;
      }
      
      public function get isMusicPlaying() : Boolean
      {
         return this._isMusicPlaying;
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function set control(param1:Control) : void
      {
         var _loc3_:int = 0;
         if(this._control != null && this._control != param1)
         {
            _loc3_ = 0;
            while(_loc3_ < this._bundle.numChildren)
            {
               if(this._bundle.getChildAt(_loc3_) == this._control)
               {
                  this._bundle.removeChildAt(_loc3_);
                  break;
               }
               _loc3_++;
            }
         }
         if(!this._isFreeze)
         {
            this._control = param1;
         }
         var _loc2_:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT);
         _loc2_.buttonDown = false;
         if(this._control != null)
         {
            this._bundle.addChild(this._control);
         }
      }
      
      public function get resize() : Boolean
      {
         return this._resize;
      }
      
      public function get defaultColorSetId() : String
      {
         return this._defaultColorSetId;
      }
      
      function doDragComplete(param1:DragEvent) : void
      {
      }
      
      public function set defaultColorSet(param1:UtilHashArray) : void
      {
         this._defaultColorSet = param1;
      }
      
      protected function onRollOut(param1:MouseEvent) : void
      {
         this.unhightlight();
         this.dispatchEvent(new AssetEvent(AssetEvent.ROLL_OUT_ASSET,this));
      }
      
      public function get soundPos() : Number
      {
         return this._soundPos;
      }
      
      public function serialize() : String
      {
         return null;
      }
      
      public function getOriginalAssetScale() : Point
      {
         return new Point(this._originalAssetScaleX,this._originalAssetScaleY);
      }
      
      public function get isLoadded() : Boolean
      {
         return this._isLoadded;
      }
      
      public function set customColor(param1:UtilHashArray) : void
      {
         this._customColor = param1;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      public function set y(param1:Number) : void
      {
         this._bundle.y = param1;
      }
      
      function onMouseMove(param1:MouseEvent) : void
      {
      }
      
      public function get soundChannel() : SoundChannel
      {
         return this._soundChannel;
      }
      
      public function set rotation(param1:Number) : void
      {
         this.bundle.rotation = param1;
      }
      
      public function set motionDistTip(param1:TextArea) : void
      {
         this._motionDistTip = param1;
      }
      
      public function set x(param1:Number) : void
      {
         this._bundle.x = param1;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function showButtonBar() : void
      {
         Console.getConsole().mainStage.showAssetButtonBar();
      }
      
      public function get sound() : Sound
      {
         return this._sound;
      }
      
      protected function addCustomColor(param1:String, param2:SelectedColor) : void
      {
         this._customColor.push(param1,param2);
      }
      
      protected function initListeners() : void
      {
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set scene(param1:AnimeScene) : void
      {
         this._scene = param1;
      }
      
      public function melt() : void
      {
         this.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.displayElement.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.displayElement.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.displayElement.addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         this.displayElement.addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
         this._isFreeze = false;
      }
      
      public function get height() : Number
      {
         return this._height;
      }
      
      public function get capScreenLock() : Boolean
      {
         return this._capScreenLock;
      }
      
      public function getKey() : String
      {
         return this.thumb.theme.id + "." + this.thumb.id + "." + this.id;
      }
      
      public function isColorable() : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc1_:Boolean = false;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         _loc2_ = UtilPlain.getColorItem(this.movieObject);
         if(_loc2_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc6_ = (_loc5_ = DisplayObject(_loc2_[_loc4_]).name.split("_"))[1];
               _loc3_.push(_loc6_);
               _loc4_++;
            }
         }
         if(this is Character && Character(this).thumb.isCC)
         {
            _loc3_ = this.removeCCUsedColor(_loc3_);
         }
         else if(this.thumb.colorParts.length > 0)
         {
            _loc1_ = true;
         }
         if(_loc3_.length > 0)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set defaultColorSetId(param1:String) : void
      {
         this._defaultColorSetId = param1;
      }
      
      function onMouseUp(param1:MouseEvent) : void
      {
         this.dispatchEvent(new AssetEvent(AssetEvent.MOUSE_UP_ASSET,this,param1.shiftKey));
      }
      
      private function repeatMusic(param1:Event) : void
      {
         this._isMusicPlaying = false;
         this.playMusic(0,0,this.soundChannel.soundTransform);
      }
      
      private function hightlight() : void
      {
         var _loc1_:GlowFilter = null;
         if(this.displayElement)
         {
            _loc1_ = new GlowFilter(16742400,1,6,6,5);
            this.displayElement.filters = [_loc1_];
         }
      }
      
      public function stopMusic(param1:Boolean, param2:Boolean = false) : void
      {
         if(this is Character)
         {
            if(Character(this).prop != null)
            {
               Character(this).prop.stopMusic(param1,param2);
            }
            if(Character(this).wear != null)
            {
               Character(this).wear.stopMusic(param1,param2);
            }
            if(Character(this).head != null)
            {
               Character(this).head.stopMusic(param1,param2);
            }
         }
         if(this.sound != null)
         {
            if(this._soundChannel != null)
            {
               if(this._soundChannel.hasEventListener(Event.SOUND_COMPLETE))
               {
                  this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.repeatMusic);
               }
               if(param2)
               {
                  this.soundPos = 0;
               }
               else
               {
                  this.soundPos = this._soundChannel.position;
               }
               this._soundChannel.stop();
               this._isMusicPlaying = false;
            }
            if(param1)
            {
               this.sound = null;
               this._soundChannel = null;
            }
         }
      }
      
      public function playMusic(param1:Number = 0, param2:int = 0, param3:SoundTransform = null) : void
      {
      }
      
      public function set imageData(param1:Object) : void
      {
         if(this._imageData != param1 || this._imageData == null)
         {
            this._imageData = param1;
            if(param1 != null)
            {
               this.loadAssetImage();
            }
         }
      }
      
      public function get control() : Control
      {
         return this._control;
      }
      
      public function get defaultColorSet() : UtilHashArray
      {
         return this._defaultColorSet;
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         if(this.scene)
         {
            this.scene.changed = param1;
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set resize(param1:Boolean) : void
      {
         this._resize = param1;
         this._bundle.mouseEnabled = param1;
         this._bundle.mouseChildren = param1;
      }
      
      public function addControl() : void
      {
      }
      
      public function get rotation() : Number
      {
         return this.bundle.rotation;
      }
      
      function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         return null;
      }
      
      public function restoreColor() : void
      {
         if(this.defaultColorSet != null && this.defaultColorSet.length > 0)
         {
            this.customColor = this.defaultColorSet.clone();
            this.updateColor();
         }
         else
         {
            this.customColor.removeAll();
            UtilColor.resetAssetPartsColor(this.movieObject);
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.COLOR_CHANGE,this));
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function set width(param1:Number) : void
      {
         this._width = param1;
      }
      
      public function set soundPos(param1:Number) : void
      {
         this._soundPos = param1;
      }
      
      public function changeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc4_:uint = 0;
         var _loc5_:SelectedColor = null;
         var _loc3_:uint = UtilColor.setAssetPartColor(this.movieObject,param1,param2);
         if(param2 == uint.MAX_VALUE)
         {
            this.customColor.removeByKey(param1);
         }
         else
         {
            _loc4_ = this.thumb.colorParts.getValueByKey(param1) == null?uint(uint.MAX_VALUE):uint(this.thumb.colorParts.getValueByKey(param1));
            _loc5_ = new SelectedColor(param1,_loc4_,param2);
            this.addCustomColor(param1,_loc5_);
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.COLOR_CHANGE,this));
         return _loc3_;
      }
      
      public function updateOriginalAssetScale() : void
      {
         this._originalAssetScaleX = this.displayElement.scaleX;
         this._originalAssetScaleY = this.displayElement.scaleY;
      }
      
      public function get isCopyable() : Boolean
      {
         return true;
      }
      
      public function showControl() : void
      {
         if(this.control == null)
         {
            this.addControl();
         }
         if(this.control != null)
         {
            this._control.visible = true;
            this._control.showControl(Console.getConsole().stageScale);
            this._controlVisible = true;
         }
      }
      
      protected function onCtrlPointDownHandler(param1:ExtraDataEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this.sizeToolTip != null)
         {
            this.setToolTipContent(param1.getData().assetWidth,param1.getData().assetHeight);
            this.sizeToolTip.x = this.scene.canvas.globalToLocal(param1.getData().globalPt).x;
            this.sizeToolTip.y = this.scene.canvas.globalToLocal(param1.getData().globalPt).y;
            _loc2_ = 10 / Console.getConsole().stageScale;
            switch(param1.getData().controlName)
            {
               case "leftTop":
                  this.sizeToolTip.x = this.sizeToolTip.x - this.sizeToolTip.width;
                  this.sizeToolTip.y = this.sizeToolTip.y - this.sizeToolTip.height;
                  break;
               case "middleTop":
                  this.sizeToolTip.x = this.sizeToolTip.x - (this.sizeToolTip.width - _loc2_) / 2;
                  this.sizeToolTip.y = this.sizeToolTip.y - this.sizeToolTip.height;
                  break;
               case "rightTop":
                  this.sizeToolTip.x = this.sizeToolTip.x + _loc2_;
                  this.sizeToolTip.y = this.sizeToolTip.y - this.sizeToolTip.height;
                  break;
               case "leftMiddle":
                  this.sizeToolTip.x = this.sizeToolTip.x - this.sizeToolTip.width;
                  this.sizeToolTip.y = this.sizeToolTip.y - (this.sizeToolTip.height - _loc2_) / 2;
                  break;
               case "rightMiddle":
                  this.sizeToolTip.x = this.sizeToolTip.x + _loc2_;
                  this.sizeToolTip.y = this.sizeToolTip.y - (this.sizeToolTip.height - _loc2_) / 2;
                  break;
               case "leftBottom":
                  this.sizeToolTip.x = this.sizeToolTip.x - this.sizeToolTip.width;
                  this.sizeToolTip.y = this.sizeToolTip.y + _loc2_;
                  break;
               case "middleBottom":
                  this.sizeToolTip.x = this.sizeToolTip.x - (this.sizeToolTip.width - _loc2_) / 2;
                  this.sizeToolTip.y = this.sizeToolTip.y + _loc2_;
                  break;
               case "rightBottom":
                  this.sizeToolTip.x = this.sizeToolTip.x + _loc2_;
                  this.sizeToolTip.y = this.sizeToolTip.y + _loc2_;
            }
            this.scene.canvas.addChild(this.sizeToolTip);
            this.sizeToolTip.visible = true;
         }
         this.hideButtonBar();
      }
      
      public function get imageData() : Object
      {
         return this._imageData;
      }
      
      protected function onCtrlPointMoveHandler(param1:ExtraDataEvent) : void
      {
         var _loc2_:Number = NaN;
         if(this.sizeToolTip != null)
         {
            this.setToolTipContent(param1.getData().assetWidth,param1.getData().assetHeight);
            this.sizeToolTip.x = this.scene.canvas.globalToLocal(param1.getData().globalPt).x;
            this.sizeToolTip.y = this.scene.canvas.globalToLocal(param1.getData().globalPt).y;
            _loc2_ = 10 / Console.getConsole().stageScale;
            switch(param1.getData().controlName)
            {
               case "leftTop":
                  this.sizeToolTip.x = this.sizeToolTip.x - this.sizeToolTip.width;
                  this.sizeToolTip.y = this.sizeToolTip.y - this.sizeToolTip.height;
                  break;
               case "middleTop":
                  this.sizeToolTip.x = this.sizeToolTip.x - (this.sizeToolTip.width - _loc2_) / 2;
                  this.sizeToolTip.y = this.sizeToolTip.y - this.sizeToolTip.height;
                  break;
               case "rightTop":
                  this.sizeToolTip.x = this.sizeToolTip.x + _loc2_;
                  this.sizeToolTip.y = this.sizeToolTip.y - this.sizeToolTip.height;
                  break;
               case "leftMiddle":
                  this.sizeToolTip.x = this.sizeToolTip.x - this.sizeToolTip.width;
                  this.sizeToolTip.y = this.sizeToolTip.y - (this.sizeToolTip.height - _loc2_) / 2;
                  break;
               case "rightMiddle":
                  this.sizeToolTip.x = this.sizeToolTip.x + _loc2_;
                  this.sizeToolTip.y = this.sizeToolTip.y - (this.sizeToolTip.height - _loc2_) / 2;
                  break;
               case "leftBottom":
                  this.sizeToolTip.x = this.sizeToolTip.x - this.sizeToolTip.width;
                  this.sizeToolTip.y = this.sizeToolTip.y + _loc2_;
                  break;
               case "middleBottom":
                  this.sizeToolTip.x = this.sizeToolTip.x - (this.sizeToolTip.width - _loc2_) / 2;
                  this.sizeToolTip.y = this.sizeToolTip.y + _loc2_;
                  break;
               case "rightBottom":
                  this.sizeToolTip.x = this.sizeToolTip.x + _loc2_;
                  this.sizeToolTip.y = this.sizeToolTip.y + _loc2_;
            }
         }
      }
      
      public function set thumb(param1:Thumb) : void
      {
         this._thumb = param1;
      }
      
      public function getBounds(param1:DisplayObject) : Rectangle
      {
         if(this.displayElement && param1)
         {
            return this.displayElement.getBounds(param1);
         }
         return null;
      }
      
      public function set displayElement(param1:UIComponent) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._bundle.numChildren)
         {
            if(this._bundle.getChildAt(_loc2_) == this._displayElement)
            {
               this._bundle.removeChild(this._displayElement);
               break;
            }
            _loc2_++;
         }
         this._displayElement = param1;
         this._bundle.addChild(this._displayElement);
      }
      
      public function set isLoadded(param1:Boolean) : void
      {
         this._isLoadded = param1;
      }
      
      public function startResize() : void
      {
         var _loc1_:ICommand = new ResizeAssetsCommand();
         _loc1_.execute();
      }
      
      function hideControl() : void
      {
         if(this._control != null)
         {
            this._control.hideControl();
            this._control = null;
            this._controlVisible = false;
         }
      }
      
      public function set eventDispatcher(param1:EventDispatcher) : void
      {
         this._eventDispatcher = param1;
      }
      
      private function isNotInsideCC(param1:Object, param2:int, param3:Array) : Boolean
      {
         if(CcLibConstant.ALL_COLOR_CODE_USED.indexOf(param1 as String) > -1)
         {
            return false;
         }
         return true;
      }
      
      function onMouseDown(param1:MouseEvent) : void
      {
         if(this.displayElement)
         {
            this.displayElement.setFocus();
         }
         this.unhightlight();
         this.dispatchEvent(new AssetEvent(AssetEvent.MOUSE_DOWN_ASSET,this,param1.shiftKey));
      }
      
      public function get width() : Number
      {
         return this._width;
      }
      
      protected function getSceneCanvas() : Canvas
      {
         if(this.bundle == null || this.bundle.parent == null)
         {
            return null;
         }
         return Canvas(this.bundle.parent);
      }
      
      function doDragEnter(param1:DragEvent) : void
      {
      }
      
      public function get thumb() : Thumb
      {
         return this._thumb;
      }
      
      protected function loadAssetImage() : void
      {
      }
      
      public function getColorArea() : Array
      {
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         var _loc4_:Array = new Array();
         _loc1_ = UtilPlain.getColorItem(this.movieObject);
         if(_loc1_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc1_.length)
            {
               _loc8_ = (_loc7_ = DisplayObject(_loc1_[_loc6_]).name.split("_"))[1];
               _loc2_.push(_loc8_);
               _loc6_++;
            }
            _loc3_ = UtilArray.removeDuplicates(_loc2_,true);
         }
         var _loc5_:Array = new Array();
         _loc6_ = 0;
         while(_loc6_ < this.thumb.colorParts.length)
         {
            _loc5_.push(this.thumb.colorParts.getKey(_loc6_));
            _loc6_++;
         }
         _loc4_ = _loc3_.concat(_loc5_);
         _loc4_ = UtilArray.removeDuplicates(_loc4_,true);
         if(this is Character && Character(this).thumb.isCC)
         {
            _loc4_ = this.removeCCUsedColor(_loc4_);
         }
         return _loc4_;
      }
      
      public function get displayElement() : UIComponent
      {
         return this._displayElement;
      }
      
      function doDragDrop(param1:DragEvent) : void
      {
      }
      
      protected function onRollOver(param1:MouseEvent) : void
      {
         if(!param1.buttonDown)
         {
            this.hightlight();
         }
         this.dispatchEvent(new AssetEvent(AssetEvent.ROLL_OVER_ASSET,this));
      }
      
      protected function get assetCount() : int
      {
         return _assetCount;
      }
   }
}
