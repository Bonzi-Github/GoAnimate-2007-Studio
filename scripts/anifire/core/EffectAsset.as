package anifire.core
{
   import anifire.components.containers.AssetInfoWindow;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlMgr;
   import anifire.control.FixedControl;
   import anifire.effect.AnimeEffect;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.effect.ZoomEffect;
   import anifire.event.EffectEvt;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IResize;
   import anifire.interfaces.ISlidable;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import anifire.util.UtilUnitConvert;
   import anifire.util.UtilXmlInfo;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.controls.Image;
   import mx.controls.TextArea;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class EffectAsset extends Asset implements ISlidable, IResize, IDraggable
   {
      
      public static const XML_NODE_NAME:String = "effectAsset";
      
      public static const MENU_LABEL_SHOW:String = "effecttray_show";
      
      public static const MENU_LABEL_HIDE:String = "effecttray_hide";
      
      private static var _logger:ILogger = Log.getLogger("core.EffectAsset");
      
      public static const STATUS_SHOW:String = "Show";
      
      public static const MENU_LABEL_EDIT:String = "effecttray_edit";
      
      public static const MENU_LABEL_DELETE:String = "effecttray_delete";
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
      
      public static const STATUS_HIDE:String = "Hide";
       
      
      private var _edtime:Number = -1;
      
      private var _status:String = "Show";
      
      private var _readyToDrag:Boolean = false;
      
      private var _edzoom:Number = 0.5;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      private var _motionShadow:EffectAsset;
      
      private var _editing:Boolean;
      
      private var _originalAssetXML:XML;
      
      private var _originalEffectWidth:Number;
      
      protected var _fromTray:Boolean = false;
      
      private var _originalEffectHeight:Number;
      
      private var _effect:SuperEffect;
      
      protected var _myEffectXML:XML = null;
      
      private var _fromSpeech:Boolean = false;
      
      private var _sttime:Number = -1;
      
      private var _stzoom:Number = 0.5;
      
      private var _backupSceneXML:XML;
      
      public function EffectAsset(param1:String = "")
      {
         var _loc3_:int = 0;
         super();
         if(param1 == null)
         {
            param1 = "";
         }
         _logger.debug("EffectAsset initialized");
         var _loc2_:String = param1 != ""?param1:"EFFECT" + _existIDs.length;
         if(param1 == "")
         {
            _loc3_ = _existIDs.length + 1;
            while(_existIDs.containsKey(_loc2_))
            {
               _loc2_ = "EFFECT" + _loc3_;
               _loc3_++;
            }
         }
         this.id = this.bundle.id = _loc2_;
         _existIDs.push(_loc2_,_loc2_);
      }
      
      static function getEffectType(param1:XML) : String
      {
         return EffectMgr.getType(param1.child(EffectMgr.XML_NODE_TAG)[0]);
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc4_:String = null;
         var _loc5_:ThemeTree = null;
         var _loc6_:String = null;
         var _loc7_:ZipEntry = null;
         var _loc8_:ByteArray = null;
         var _loc9_:UtilCrypto = null;
         var _loc10_:String = null;
         var _loc3_:UtilHashArray = new UtilHashArray();
         if(param1.child("file").length() > 0)
         {
            _loc6_ = UtilXmlInfo.getZipFileNameOfEffect(param1.child("file")[0].toString());
            _loc4_ = UtilXmlInfo.getThemeIdFromFileName(_loc6_);
            if((_loc7_ = param2.getEntry(_loc6_)) != null)
            {
               _loc8_ = param2.getInput(_loc7_);
               if(_loc4_ != "ugc")
               {
                  (_loc9_ = new UtilCrypto()).decrypt(_loc8_);
               }
               (_loc5_ = new ThemeTree(_loc4_)).addEffectThumbId(UtilXmlInfo.getThumbIdFromFileName(_loc6_),_loc8_);
               _loc3_.push(_loc4_,_loc5_);
            }
         }
         else
         {
            _loc4_ = getThemeIdFromAssetXml(param1);
            _loc10_ = EffectMgr.getId(param1.child(EffectMgr.XML_NODE_TAG)[0]);
            (_loc5_ = new ThemeTree(_loc4_)).addEffectThumbId(_loc10_,null);
            _loc3_.push(_loc4_,_loc5_);
         }
         return _loc3_;
      }
      
      public static function getThemeIdFromAssetXml(param1:XML) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1.child("file").length() > 0)
         {
            _loc3_ = UtilXmlInfo.getZipFileNameOfEffect(param1.child("file")[0].toString());
            _loc2_ = UtilXmlInfo.getThemeIdFromFileName(_loc3_);
         }
         else
         {
            _loc2_ = param1.@themecode;
            if(_loc2_ == "")
            {
               _loc2_ = "common";
            }
         }
         return _loc2_;
      }
      
      function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      public function startSlideMotion() : void
      {
      }
      
      function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      public function set motionData(param1:MotionData) : void
      {
         this.motionShadow = null;
         this.refreshMotionShadow();
         if(this.motionShadow)
         {
            this.motionShadow.x = this.x + param1.displacement.x;
            this.motionShadow.y = this.y + param1.displacement.y;
         }
         this.hideControl();
      }
      
      function showMotionShadow() : void
      {
         if(this.motionShadow != null)
         {
            this.motionShadow.showControl();
            this.motionShadow.bundle.visible = this.bundle.visible;
            this.scene.sendToFront(this.motionShadow.bundle);
            this.drawMotionLine();
         }
      }
      
      public function showInfoWindow() : void
      {
         var _loc1_:Boolean = this.effect is ZoomEffect && (ZoomEffect(this.effect).isPan || ZoomEffect(this.effect).isCut);
         var _loc2_:AssetInfoWindow = AssetInfoWindow(PopUpManager.createPopUp(Console.getConsole().currentScene.canvas,AssetInfoWindow,true));
         _loc2_.mode = _loc2_.LEN_MODE;
         _loc2_.type = !!_loc1_?"Cut/Pan":this.effect.type;
         _loc2_.thumb = thumb;
         _loc2_.x = (_loc2_.stage.width - _loc2_.width) / 2;
         _loc2_.y = 100;
         _loc2_.durscene = this.scene.getLength();
         _loc2_.assetId = this.id;
         if(this.sttime > -1 && this.edtime > -1)
         {
            _loc2_.sttime = this.sttime;
            _loc2_.edtime = this.edtime;
         }
         if((this.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase() && !_loc1_)
         {
            _loc2_.stzoom = this.stzoom;
            _loc2_.edzoom = this.edzoom;
         }
      }
      
      protected function getOrigin() : Point
      {
         var _loc1_:Point = new Point();
         var _loc2_:Point = this.bundle.localToGlobal(new Point());
         var _loc3_:Point = scene.canvas.globalToLocal(_loc2_);
         _loc1_.x = _loc3_.x + this.effect.x + this.width / 2;
         _loc1_.y = _loc3_.y + this.effect.y + this.height / 2;
         return _loc1_;
      }
      
      public function doMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:XML = XML(param1.item);
         if(_loc2_.attribute("value").toString() == MENU_LABEL_SHOW)
         {
            this.showEffect();
            this.status = STATUS_SHOW;
         }
         else if(_loc2_.attribute("value").toString() == MENU_LABEL_HIDE)
         {
            this.hideEffect();
            this.status = STATUS_HIDE;
         }
         else if(_loc2_.attribute("value").toString() == MENU_LABEL_DELETE)
         {
            if((this.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase() && Console.getConsole().stageScale != 1)
            {
               Console.getConsole().lookOut();
            }
            this.deleteAsset();
            this.scene.selectedAsset = null;
         }
         else if(_loc2_.attribute("value").toString() == MENU_LABEL_EDIT || param1.currentTarget is Console)
         {
            this.scene.selectedAsset = this;
            this.scene.assetGroup.showControl();
         }
      }
      
      private function fillBackground() : void
      {
         var _loc1_:Rectangle = this._effect.getRect(this.bundle);
         this.bundle.graphics.clear();
         this.bundle.graphics.beginFill(13421772,0.6);
         this.bundle.graphics.drawRect(_loc1_.x,_loc1_.y,_loc1_.width,_loc1_.height);
         this.bundle.graphics.endFill();
      }
      
      public function getExactType() : String
      {
         return (this.thumb as EffectThumb).getExactType();
      }
      
      override public function get height() : Number
      {
         return this._effect != null?Number(this._effect.height):Number(-1);
      }
      
      protected function loadAssetImageComplete(param1:EffectEvt) : void
      {
         var _loc5_:Class = null;
         var _loc2_:Loader = param1.getData() as Loader;
         if(this is AnimeEffectAsset && _loc2_.content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            _loc5_ = _loc2_.content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            this.sound = new _loc5_();
            this.dispatchEvent(new Event("SoundAdded"));
         }
         var _loc3_:SuperEffect = param1.getEventCreater() as SuperEffect;
         var _loc4_:int = 0;
         while(_loc4_ < this.displayElement.numChildren)
         {
            if(this.displayElement.getChildAt(_loc4_) is SuperEffect)
            {
               this.displayElement.removeChildAt(_loc4_);
               break;
            }
            _loc4_++;
         }
         _loc3_.name = AnimeConstants.IMAGE_OBJECT_NAME;
         this.displayElement.addChild(_loc3_);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      public function get fromSpeech() : Boolean
      {
         return this._fromSpeech;
      }
      
      protected function drawMotionLine(param1:Event = null) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         var _loc5_:TextArea = null;
         scene.dashline.visible = true;
         if(scene.dashline.contains(motionDistTip))
         {
            scene.dashline.removeChild(motionDistTip);
         }
         if(this.motionShadow != null)
         {
            scene.dashline.graphics.clear();
            _loc2_ = this.getOrigin();
            _loc3_ = new Point(this.motionShadow.x + this.motionShadow.effect.x + this.motionShadow.width / 2,this.motionShadow.y + this.motionShadow.effect.y + this.motionShadow.height / 2);
            scene.dashline.graphics.lineStyle(4 / Console.getConsole().stageScale,13421772);
            UtilDraw.drawDashLineWithArrow(scene.dashline,_loc2_,_loc3_,10 / Console.getConsole().stageScale,5 / Console.getConsole().stageScale,15 / Console.getConsole().stageScale);
            scene.sendToFront(scene.dashline);
            if((_loc4_ = Point.distance(_loc2_,_loc3_)) > AnimeConstants.ASSET_MOVE_TOLERANCE)
            {
               scene.dashline.addChildAt(motionDistTip,0);
               _loc4_ = Util.roundNum(_loc4_,0);
               (_loc5_ = motionDistTip).setStyle("textAlign","center");
               _loc5_.width = 40;
               _loc5_.height = 18;
               _loc5_.selectable = false;
               _loc5_.text = String(_loc4_) + "px";
               _loc5_.x = this.x + this.width / 2 - _loc5_.width / 2;
               _loc5_.y = this.y + this.height / 2 - 28;
            }
         }
      }
      
      override public function set id(param1:String) : void
      {
         _existIDs.push(param1,param1);
         super.id = param1;
      }
      
      public function stopEffect() : void
      {
         if(this.displayElement != null)
         {
            if(this.effect != null)
            {
               UtilPlain.stopFamily(this.effect);
               this.stopMusic(false);
            }
         }
      }
      
      public function set effect(param1:SuperEffect) : void
      {
         this._effect = param1;
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc9_:Object = null;
         var _loc2_:Number = getSceneCanvas().mouseX;
         var _loc3_:Number = getSceneCanvas().mouseY;
         var _loc4_:Point = new Point(_loc2_,_loc3_);
         var _loc5_:Point = new Point(this._originalX,this._originalY);
         var _loc6_:Number = _loc4_.x - _loc5_.x;
         var _loc7_:Number = _loc4_.y - _loc5_.y;
         var _loc8_:Number = Math.sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_);
         if(this == this.scene.selectedAsset)
         {
            this._readyToDrag = false;
            this.showControl();
            if(this.motionShadow != null)
            {
               this.motionShadow.showControl();
            }
         }
         (_loc9_ = this.bundle as Image).stopDrag();
         if(this.isMotionShadow())
         {
            this.updateObjectPosition(_loc9_);
            Console.getConsole().currDragObject = null;
         }
         else if(scene.selectedAsset != null)
         {
            this.updateObjectPosition(_loc9_);
            Console.getConsole().currDragObject = null;
         }
         if(scene.selectedAsset != null && scene.selectedAsset is EffectAsset)
         {
            EffectAsset(scene.selectedAsset).refreshMotionShadow();
         }
         this.changed = true;
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().thumbTrayActive = true;
      }
      
      override public function set imageData(param1:Object) : void
      {
         if(super.imageData != param1 || super.imageData == null)
         {
            super.imageData = param1;
            this.loadAssetImage();
         }
      }
      
      public function get slideEnabled() : Boolean
      {
         if(this.effect is ZoomEffect && ZoomEffect(this.effect).isPan)
         {
            return true;
         }
         return false;
      }
      
      public function checkEffectAssetSize() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = this.effect.width;
         var _loc2_:Number = this.effect.height;
         if(_loc1_ > AnimeConstants.SCREEN_WIDTH)
         {
            _loc3_ = AnimeConstants.SCREEN_WIDTH / _loc1_;
            _loc1_ = _loc1_ * _loc3_;
            _loc2_ = _loc2_ * _loc3_;
         }
         if(_loc2_ > AnimeConstants.SCREEN_HEIGHT)
         {
            _loc3_ = AnimeConstants.SCREEN_HEIGHT / _loc2_;
            _loc1_ = _loc1_ * _loc3_;
            _loc2_ = _loc2_ * _loc3_;
         }
         this.updateObjectPosition(this);
         this.effect.setSize(_loc1_,_loc2_);
      }
      
      public function set sttime(param1:Number) : void
      {
         this._sttime = param1;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:EffectAsset = new EffectAsset();
         _loc3_.id = _loc3_.bundle.id = this.id;
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.effect = this.effect;
         _loc3_.scene = this.scene;
         _loc3_.thumb = this.thumb;
         return _loc3_;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Theme = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         this._myEffectXML = param1.child(EffectMgr.XML_NODE_TAG)[0];
         if(param1.child("file").length() > 0)
         {
            _loc9_ = UtilXmlInfo.getZipFileNameOfEffect(param1.file);
            _loc6_ = UtilXmlInfo.getThemeIdFromFileName(_loc9_);
            _loc10_ = UtilXmlInfo.getThumbIdFromFileName(_loc9_);
         }
         else
         {
            _loc6_ = getThemeIdFromAssetXml(param1);
         }
         _loc7_ = Console.getConsole().getTheme(_loc6_);
         _loc5_ = EffectMgr.getId(this._myEffectXML);
         var _loc8_:EffectThumb = _loc7_.getEffectThumbById(_loc5_);
         this.scene = param2;
         this.x = param1.@x;
         this.y = param1.@y;
         if(param1.child("st").length() > 0 && param1.child("et").length() > 0)
         {
            this.sttime = UtilUnitConvert.frameToSec(param1.st,false);
            this.edtime = UtilUnitConvert.frameToSec(param1.et,false);
            if(param1.child("st").@dur > -1 && param1.child("et").@dur > -1)
            {
               this.stzoom = UtilUnitConvert.frameToSec(param1.st.@dur,false);
               this.edzoom = UtilUnitConvert.frameToSec(param1.et.@dur,false);
            }
         }
         else
         {
            this.sttime = -1;
            this.edtime = -1;
         }
         if(param4)
         {
            this.thumb = _loc8_;
         }
         else
         {
            super.thumb = _loc8_;
         }
         this.isLoadded = true;
      }
      
      private function getShadowIndex(param1:AnimeScene) : int
      {
         return param1.background == null?0:1;
      }
      
      public function set stzoom(param1:Number) : void
      {
         this._stzoom = param1;
      }
      
      public function updateTimeByScene(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 / param2;
         if(this.sttime != -1 && this.edtime != -1)
         {
            this.sttime = this.sttime * _loc3_;
            this.edtime = this.edtime * _loc3_;
            this.sttime = Util.roundNum(this.sttime);
            this.edtime = Util.roundNum(this.edtime);
         }
         if(this.stzoom != AnimeConstants.ZOOM_DURATION)
         {
            this.stzoom = this.stzoom * _loc3_;
            this.stzoom = Util.roundNum(this.stzoom);
         }
         if(this.edzoom != AnimeConstants.ZOOM_DURATION)
         {
            this.edzoom = this.edzoom * _loc3_;
            this.edzoom = Util.roundNum(this.edzoom);
         }
      }
      
      public function set fromSpeech(param1:Boolean) : void
      {
         this._fromSpeech = param1;
      }
      
      public function resizing(param1:Control) : void
      {
         var _loc2_:SuperEffect = SuperEffect(param1.asset);
         var _loc3_:Object = param1.getStuff(this._prevDisplayElementPosX,this._prevDisplayElementPosY);
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         _loc2_.setSize(_loc3_.w,_loc3_.h);
      }
      
      public function hideEffect() : Boolean
      {
         var _loc1_:Boolean = this.bundle.visible;
         this.bundle.visible = false;
         this.stopMusic(false);
         this.hideControl();
         if(this.motionShadow != null)
         {
            this.motionShadow.bundle.visible = false;
            this.motionShadow.hideControl();
         }
         return _loc1_;
      }
      
      public function get motionShadow() : EffectAsset
      {
         return this._motionShadow;
      }
      
      override public function addControl() : void
      {
         var _loc1_:FixedControl = null;
         if(this._effect != null)
         {
            if(this.isMotionShadow())
            {
               _loc1_ = ControlMgr.getControl(this._effect,ControlMgr.FIXED_SHADOW) as FixedControl;
            }
            else
            {
               _loc1_ = ControlMgr.getControl(this._effect,ControlMgr.FIXED) as FixedControl;
            }
            _loc1_.target = this;
            _loc1_.asset = this._effect;
            _loc1_.aspectRatio = 550 / 354;
            _loc1_.setPos(this._effect.x,this._effect.y);
            _loc1_.setOrigin(this._effect.width / 2,this._effect.height / 2);
            _loc1_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
            _loc1_.addEventListener("CtrlPointUp",onCtrlPointUpHandler);
            _loc1_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
            _loc1_.hideControl();
            this.control = _loc1_;
         }
      }
      
      public function endResize() : void
      {
         var _loc1_:Control = this.control;
         var _loc2_:SuperEffect = SuperEffect(_loc1_.asset);
         var _loc3_:Object = _loc1_.getStuff(this._prevDisplayElementPosX,this._prevDisplayElementPosY);
         this.x = this.x + _loc2_.x;
         this.y = this.y + _loc2_.y;
         _loc2_.x = 0;
         _loc2_.y = 0;
         this.checkEffectAssetSize();
         this.control = null;
         this.showControl();
         this.changed = true;
         if(this._originalAssetXML != this.serialize())
         {
         }
      }
      
      public function updateOriginalEffectSize() : void
      {
         this._originalEffectWidth = this.effect.width;
         this._originalEffectHeight = this.effect.height;
      }
      
      public function get effect() : SuperEffect
      {
         return this._effect;
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(!this.isMotionShadow())
         {
            this.showMotionShadow();
            if(this.bundle.visible)
            {
               if(!Console.getConsole().isTutorialOn)
               {
                  showButtonBar();
               }
            }
         }
      }
      
      public function removeSlideMotion() : void
      {
      }
      
      public function get isSliding() : Boolean
      {
         if(this.effect is ZoomEffect && ZoomEffect(this.effect).isPan)
         {
            return true;
         }
         return false;
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         super.thumb = param1;
         this.imageData = param1.imageData;
      }
      
      protected function updateObjectPosition(param1:Object) : void
      {
         this.x = Math.min(this.x,AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH - this.width);
         this.x = Math.max(this.x,AnimeConstants.SCREEN_X);
         this.y = Math.min(this.y,AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT - this.height);
         this.y = Math.max(this.y,AnimeConstants.SCREEN_Y);
         if(this.motionShadow)
         {
            this.motionShadow.x = Math.min(this.motionShadow.x,AnimeConstants.SCREEN_X + AnimeConstants.SCREEN_WIDTH - this.motionShadow.width);
            this.motionShadow.x = Math.max(this.motionShadow.x,AnimeConstants.SCREEN_X);
            this.motionShadow.y = Math.min(this.motionShadow.y,AnimeConstants.SCREEN_Y + AnimeConstants.SCREEN_HEIGHT - this.motionShadow.height);
            this.motionShadow.y = Math.max(this.motionShadow.y,AnimeConstants.SCREEN_Y);
         }
      }
      
      public function get stzoom() : Number
      {
         return this._stzoom;
      }
      
      public function get sttime() : Number
      {
         return this._sttime;
      }
      
      public function getType() : String
      {
         return (this.thumb as EffectThumb).getType();
      }
      
      override function doDragComplete(param1:DragEvent) : void
      {
         this._readyToDrag = false;
         var _loc2_:Image = Image(param1.dragInitiator);
         _loc2_.alpha = 1;
         _loc2_.setFocus();
         if(this == this.scene.selectedAsset)
         {
            this.showControl();
         }
      }
      
      override public function unloadAssetImage(param1:Boolean) : void
      {
         if(this.effect is AnimeEffect)
         {
            AnimeEffect(this.effect).unloadEffectImage(param1);
            this.imageData = null;
         }
      }
      
      override public function set control(param1:Control) : void
      {
         super.control = param1;
         if(this.motionShadow != null && param1 == null)
         {
            this.motionShadow.control = param1;
         }
      }
      
      override public function startResize() : void
      {
         super.startResize();
         this._originalAssetXML = new XML(this.serialize());
         this._prevDisplayElementPosX = this.effect.x;
         this._prevDisplayElementPosY = this.effect.y;
      }
      
      public function isMotionShadow() : Boolean
      {
         if(this.bundle.name.substr(0,12) == "motionShadow")
         {
            return true;
         }
         return false;
      }
      
      override function hideControl() : void
      {
         super.hideControl();
         hideButtonBar();
         if(!this.isMotionShadow())
         {
            this.hideMotionShadow();
         }
      }
      
      override public function get width() : Number
      {
         return this._effect != null?Number(this._effect.width):Number(-1);
      }
      
      override function onMouseDown(param1:MouseEvent) : void
      {
         super.onMouseDown(param1);
         if(this.scene.selectedAsset is EffectAsset)
         {
            if(!EffectAsset(this.scene.selectedAsset)._editing)
            {
               this.scene.selectedAsset.hideControl();
            }
         }
         this._readyToDrag = true;
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         this._backupSceneXML = new XML(this.scene.serialize(-1,false));
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler,false,1,true);
         Console.getConsole().currDragObject = this;
         Console.getConsole().thumbTrayActive = false;
      }
      
      public function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null) : void
      {
         var _loc5_:EffectAsset = null;
         if(!this.isMotionShadow())
         {
            if(this.motionShadow == null || !scene.canvas.contains(this.motionShadow.bundle))
            {
               _loc5_ = EffectAsset(this.clone());
               if(!(param1 == null && param2 == null && param3 == null && param4 == null))
               {
                  _loc5_.x = param1[param1.length - 1];
                  _loc5_.y = param2[param2.length - 1];
                  _loc5_.effect.width = param3[param3.length - 1];
                  _loc5_.effect.height = param4[param4.length - 1];
               }
               this.motionShadow = EffectAsset(_loc5_.clone());
               this.motionShadow.fromTray = false;
               this.motionShadow.bundle.alpha = 0.7;
               this.motionShadow.bundle.name = this.motionShadow.id = "motionShadow_" + id;
               this.motionShadow.bundle.buttonMode = true;
               if(this.motionShadow is ProgramEffectAsset)
               {
                  ProgramEffectAsset(this.motionShadow).needControl = true;
               }
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.onShadowMouseDown);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
               this.motionShadow.displayElement.addEventListener(MouseEvent.ROLL_OVER,this.motionShadow.onRollOut);
               scene.canvas.addChild(this.motionShadow.bundle);
            }
            this.showMotionShadow();
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:SuperEffect = null;
         if(this._myEffectXML == null)
         {
            _loc1_ = (this.thumb as EffectThumb).getNewEffect();
         }
         else
         {
            _loc1_ = (this.thumb as EffectThumb).getNewEffect(this._myEffectXML);
         }
         this.effect = _loc1_;
         _loc1_.addEventListener(EffectEvt.LOAD_EFFECT_COMPLETE,this.loadAssetImageComplete);
         _loc1_.loadEffectImage((this.thumb as EffectThumb).imageData as ByteArray);
      }
      
      private function onShadowMouseDown(param1:MouseEvent) : void
      {
         trace("onShadowMouseDown");
         var _loc2_:Image = Image(this.motionShadow.bundle);
         _loc2_.startDrag();
         if(this.scene.selectedAsset is EffectAsset)
         {
            if(!EffectAsset(this.scene.selectedAsset)._editing)
            {
               this.scene.selectedAsset.hideControl();
            }
         }
         else if(this.scene.selectedAsset != null)
         {
            this.scene.selectedAsset.hideControl();
         }
         if(this.scene.selectedAsset == null || this.scene.selectedAsset != null && this.scene.selectedAsset != this)
         {
            this.scene.selectedAsset = this;
         }
         this._readyToDrag = true;
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         this._backupSceneXML = new XML(this.scene.serialize(-1,false));
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler,false,1,true);
         Console.getConsole().currDragObject = this;
         Console.getConsole().thumbTrayActive = false;
      }
      
      public function getOriginalEffectSize() : Point
      {
         return new Point(this._originalEffectWidth,this._originalEffectHeight);
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
         if(this.motionShadow != null || this.isMotionShadow())
         {
            if(param1.buttonDown && this == Console.getConsole().currentScene.selectedAsset)
            {
               this.refreshMotionShadow();
            }
         }
      }
      
      public function set edtime(param1:Number) : void
      {
         this._edtime = param1;
      }
      
      override public function serialize() : String
      {
         return "";
      }
      
      public function set edzoom(param1:Number) : void
      {
         this._edzoom = param1;
      }
      
      public function playEffect() : void
      {
         if(this.displayElement != null)
         {
            if(this.effect != null)
            {
               UtilPlain.playFamily(this.effect);
               if(this.soundChannel != null)
               {
                  this.playMusic(this.soundPos,0,this.soundChannel.soundTransform);
               }
            }
         }
      }
      
      public function hideMotionShadow() : void
      {
         if(this.motionShadow != null)
         {
            this.motionShadow.hideControl();
            this.motionShadow.bundle.visible = false;
         }
         this.clearMotionLine();
      }
      
      public function startDragging() : void
      {
         this.hideControl();
         var _loc1_:Image = Image(this.bundle);
         _loc1_.startDrag();
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
      }
      
      public function set status(param1:String) : void
      {
         if(param1 == STATUS_SHOW || param1 == STATUS_HIDE)
         {
            this._status = param1;
         }
      }
      
      public function set motionShadow(param1:EffectAsset) : void
      {
         this._motionShadow = param1;
         if(this._motionShadow != null)
         {
         }
      }
      
      public function showEffect() : void
      {
         this.bundle.visible = true;
         this.playEffect();
         if(this.motionShadow != null)
         {
            this.motionShadow.bundle.visible = true;
         }
      }
      
      public function get isCamera() : Boolean
      {
         if(this.effect is ZoomEffect)
         {
            return true;
         }
         return false;
      }
      
      public function refreshMotionShadow() : void
      {
         if(this.effect is ZoomEffect)
         {
            if(ZoomEffect(this.effect).isPan)
            {
               this.drawMotionLine();
               if(this.motionShadow != null)
               {
                  this.motionShadow.bundle.visible = this.bundle.visible;
                  this.scene.sendToFront(this.motionShadow.bundle);
               }
               else if(!this.isMotionShadow())
               {
                  this.addMotionShadow();
               }
            }
         }
      }
      
      public function get edzoom() : Number
      {
         return this._edzoom;
      }
      
      function clearMotionLine() : void
      {
         scene.dashline.graphics.clear();
         scene.dashline.visible = false;
         if(scene.dashline.contains(motionDistTip))
         {
            scene.dashline.removeChild(motionDistTip);
         }
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function get edtime() : Number
      {
         return this._edtime;
      }
      
      public function showMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         var _loc6_:Boolean = true;
         if(Console.getConsole().stageScale > 1 && (this.thumb as EffectThumb).getExactType() == EffectMgr.TYPE_ZOOM.toLowerCase())
         {
            _loc6_ = false;
         }
         _loc3_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_SHOW) + "\"value=\"" + MENU_LABEL_SHOW + "\"enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_HIDE) + "\"value=\"" + MENU_LABEL_HIDE + "\" enabled=\"" + _loc6_ + "\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_EDIT) + "\"value=\"" + MENU_LABEL_EDIT + "\" />" + "<menuItem label=\"\" type=\"separator\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",MENU_LABEL_DELETE) + "\"value=\"" + MENU_LABEL_DELETE + "\"/></root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doMenuClick);
         _loc5_.show(param1 - 80,param2);
      }
      
      public function redraw() : void
      {
         this._effect.redraw();
      }
   }
}
