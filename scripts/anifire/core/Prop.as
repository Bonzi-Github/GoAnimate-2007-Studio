package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.command.ChangeActionCommand;
   import anifire.command.FlipAssetCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.component.CustomCharacterMaker;
   import anifire.component.CustomHeadMaker;
   import anifire.components.studio.MaskPoint;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlMgr;
   import anifire.control.myBezierSpline;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IResize;
   import anifire.interfaces.IRotatable;
   import anifire.interfaces.ISlidable;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilDraw;
   import anifire.util.UtilErrorLogger;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import caurina.transitions.Tweener;
   import flash.display.AVM1Movie;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.controls.TextArea;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Prop extends Asset implements ISlidable, IResize, IDraggable, IRotatable
   {
      
      private static const MENU_ITEM_TYPE_TAG:String = "itemType";
      
      private static const MENU_ITEM_TYPE_MOVEMENT_TAG:String = "movement";
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
      
      private static const MENU_ITEM_MOVEMENT_REMOVE:String = "actionmenu_removeMove";
      
      private static const MENU_ITEM_TYPE_ACTION_TAG:String = "action";
      
      private static const MENU_ITEM_SLIDE:String = "actionmenu_slide";
      
      private static const MENU_ITEM_STATES:String = "actionmenu_states";
      
      private static const REMOVE_MOTION:String = "removeMotion";
      
      private static const MENU_ITEM_TYPE_WEAR_TAG:String = "wear";
      
      public static const XML_NODE_NAME_HEAD:String = "head";
      
      public static const XML_NODE_NAME:String = "prop";
      
      private static const MENU_ITEM_POINT_ADD:String = "motionmenu_addpoint";
      
      private static var _logger:ILogger = Log.getLogger("core.Prop");
      
      private static const ADD_CONTROL_POINT:String = "addControlPoint";
      
      private static const MENU_ITEM_TYPE_STATE_TAG:String = "state";
      
      private static const MENU_ITEM_TYPE_HEAD_TAG:String = "head";
      
      private static const MENU_ITEM_TYPE_PROP_TAG:String = "prop";
      
      private static const REMOVE_CONTROL_POINT:String = "removeControlPoint";
      
      private static const MENU_ITEM_MOVEMENT:String = "actionmenu_movement";
      
      public static const XML_NODE_NAME_WEAR:String = "wear";
      
      private static const MENU_ITEM_POINT_REMOVE:String = "motionmenu_removepoint";
       
      
      private var _motionShadow_facing:String;
      
      public var _orgLoaderScaleX:Number = 1;
      
      public var _orgLoaderScaleY:Number = 1;
      
      private var speechHandler:Function = null;
      
      private var _readyToDrag:Boolean = false;
      
      private var _actionMenuXML:XML;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      public var _prevCharPosX:Number = 0;
      
      public var _prevCharPosY:Number = 0;
      
      private var _mouseClickPoint:Point;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      public var _char:Character = null;
      
      private var initCameraHandler:Function = null;
      
      private var _demoSpeech:Boolean = false;
      
      private var _stateId:String;
      
      private var _actionMenu:ScrollableArrowMenu;
      
      private var _fromTray:Boolean = false;
      
      private var _motionShadowProp:Prop;
      
      private var _currControlPointName:String;
      
      private var _state:State;
      
      private var _controlPoints:Array;
      
      private var _insertingPoint:Number;
      
      private var _attachedBg:Boolean;
      
      private var _graphic:Sprite;
      
      private var _posBeforeChangeState:Point;
      
      private var _checkedStateItem:Object;
      
      private var _shadowParent:Prop;
      
      private var _originalRotation:Number = 0;
      
      private var _motionMenu:ScrollableArrowMenu;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _curve:UIComponent;
      
      private var _backupSceneXML:XML;
      
      private var _facingMenu:ScrollableArrowMenu;
      
      private var _facing:String = "unknown";
      
      private var _knots:Array;
      
      private var _spline:myBezierSpline;
      
      public function Prop(param1:String = "")
      {
         var _loc3_:int = 0;
         this._spline = new myBezierSpline();
         this._graphic = new Sprite();
         this._knots = new Array();
         this._controlPoints = new Array();
         this._mouseClickPoint = new Point();
         this._curve = new UIComponent();
         super();
         _logger.debug("Prop initialized");
         var _loc2_:String = "PROP" + Prop._existIDs.length;
         if(param1 == "")
         {
            _loc3_ = Prop._existIDs.length;
            while(Prop._existIDs.containsKey(_loc2_))
            {
               _loc2_ = "PROP" + _loc3_;
               _loc3_++;
            }
         }
         else
         {
            _loc2_ = param1;
         }
         Prop._existIDs.push(_loc2_,_loc2_);
         this.id = this.bundle.id = _loc2_;
         this._insertingPoint = -1;
         this._spline.container = this._graphic;
         this._spline.thickness = 4;
         this._spline.containAsset = Asset(this);
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:ZipEntry = null;
         var _loc9_:ThemeTree = null;
         var _loc10_:Boolean = false;
         var _loc11_:ByteArray = null;
         var _loc12_:RegExp = null;
         var _loc13_:UtilCrypto = null;
         var _loc14_:XML = null;
         var _loc15_:XML = null;
         var _loc4_:UtilHashArray = new UtilHashArray();
         if(param1.child("file")[0].toString().split(".").length <= 3 || param1.child("file")[0].toString().indexOf(".head.") != -1)
         {
            _loc5_ = UtilXmlInfo.getZipFileNameOfProp(param1.child("file")[0].toString());
            _loc6_ = UtilXmlInfo.getThemeIdFromFileName(_loc5_);
            _loc7_ = UtilXmlInfo.getThumbIdFromFileName(_loc5_);
            if(!(_loc8_ = param2.getEntry(_loc5_)))
            {
               _loc12_ = /zip/gi;
               _loc8_ = param2.getEntry(_loc5_.replace(_loc12_,"xml"));
            }
            _loc10_ = true;
            if(_loc8_ == null)
            {
               _loc10_ = false;
            }
            else if(param3.containsKey(_loc6_) && (param3.getValueByKey(_loc6_) as ThemeTree).isPropThumbExist(_loc7_))
            {
               _loc10_ = false;
            }
            if(_loc8_ != null)
            {
               _loc11_ = param2.getInput(_loc8_);
               if(_loc6_ != "ugc")
               {
                  (_loc13_ = new UtilCrypto()).decrypt(_loc11_);
               }
               (_loc9_ = new ThemeTree(_loc6_)).addPropThumbId(_loc7_,_loc11_);
               _loc4_.push(_loc6_,_loc9_);
            }
            else if(param1.@subtype == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
            {
               _loc5_ = VideoPropThumb.renameExtensionToPNG(_loc5_);
               if((_loc8_ = param2.getEntry(_loc5_)) != null)
               {
                  _loc11_ = param2.getInput(_loc8_);
                  (_loc9_ = new ThemeTree(_loc6_)).addPropThumbId(_loc7_,_loc11_);
                  _loc4_.push(_loc6_,_loc9_);
               }
            }
         }
         else if((_loc14_ = param1.child("file")[0]) != null)
         {
            ThemeTree.mergeThemeTrees(_loc4_,Behavior.getThemeTrees(_loc14_,param2,param3,false));
            _loc15_ = _loc14_;
         }
         return _loc4_;
      }
      
      public function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      private function enableMouseChildren(param1:Boolean) : void
      {
         this.bundle.mouseChildren = param1;
         this.bundle.mouseEnabled = param1;
      }
      
      private function refreshControl(... rest) : void
      {
         if(control != null && controlVisible)
         {
            this.control = null;
         }
      }
      
      public function startSlideMotion() : void
      {
         if(this.motionShadow == null)
         {
            this._originalX = this.getSceneCanvas().mouseX;
            this._originalY = this.getSceneCanvas().mouseY;
            _originalAssetX = this.x;
            _originalAssetY = this.y;
            this.refreshMotionShadow();
            this.snapAsset(this.motionShadow);
            this.refreshMotionShadow();
         }
      }
      
      public function get attachedBg() : Boolean
      {
         return this._attachedBg;
      }
      
      private function onDashlineOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:GlowFilter = new GlowFilter(16737792,1,5,5,150,1,true);
         var _loc3_:Array = new Array();
         _loc3_.push(_loc2_);
         _loc2_ = new GlowFilter(0,1,3,3,250);
         _loc3_.push(_loc2_);
         scene.dashline.filters = _loc3_;
      }
      
      public function set attachedBg(param1:Boolean) : void
      {
         this._attachedBg = param1;
      }
      
      public function init(param1:Thumb, param2:Character) : void
      {
         this.thumb = param1;
         if(param2 != null)
         {
            this.char = param2;
            this.scene = param2.scene;
            this.addDisplayElementListener();
         }
      }
      
      public function set stateId(param1:String) : void
      {
         this._stateId = param1;
      }
      
      function getMotionShadow() : Prop
      {
         if(this.motionShadow != null)
         {
            return this.motionShadow;
         }
         return null;
      }
      
      private function removeMotionShadow() : void
      {
         if(this.motionShadow != null)
         {
            try
            {
               scene.dashline.graphics.clear();
               if(scene.dashline.contains(this._curve))
               {
                  scene.dashline.removeChild(this._curve);
               }
               scene.canvas.removeChild(this.motionShadow.bundle);
               this.motionShadow = null;
            }
            catch(e:Error)
            {
            }
         }
      }
      
      protected function getOrigin() : Point
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc1_:Point = new Point();
         var _loc2_:Loader = Loader(this.imageObject);
         if(_loc2_ != null)
         {
            _loc3_ = this.bundle.localToGlobal(new Point());
            _loc4_ = scene.canvas.globalToLocal(_loc3_);
            _loc1_.x = _loc4_.x;
            _loc1_.y = _loc4_.y;
         }
         return _loc1_;
      }
      
      public function hasMotion() : Boolean
      {
         if(this.motionShadow == null)
         {
            return false;
         }
         return true;
      }
      
      public function showMotionMenu(param1:MouseEvent = null) : void
      {
         var _loc2_:Object = param1.currentTarget;
         if(_loc2_.name != "theCurve")
         {
            this._insertingPoint = Number(_loc2_.name);
         }
         this._motionMenu = this.buildMotionMenu(_loc2_ is MaskPoint);
         if(_loc2_ is MaskPoint)
         {
            this._currControlPointName = _loc2_.name;
         }
         var _loc3_:Number = 150;
         this._mouseClickPoint = new Point(scene.dashline.mouseX,scene.dashline.mouseY);
         var _loc4_:Canvas;
         var _loc5_:Point = (_loc4_ = Console.getConsole().mainStage._stageArea).localToGlobal(new Point(0,0));
         if(Console.getConsole().stageScale > 1)
         {
            _loc5_ = new Point(0,68);
         }
         var _loc6_:Number = _loc4_.stage.mouseX;
         var _loc7_:Number = _loc4_.stage.mouseY;
         if(_loc6_ + _loc3_ > _loc5_.x + _loc4_.width)
         {
            _loc6_ = _loc5_.x + _loc4_.width - _loc3_;
         }
         if(!(_loc2_ is MaskPoint && MaskPoint(_loc2_).oPos.equals(new Point(MaskPoint(_loc2_).x,MaskPoint(_loc2_).y)) == false))
         {
            this._motionMenu.show(_loc6_,_loc7_);
         }
      }
      
      public function set state(param1:State) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            this.stateId = param1.id;
            this.imageData = param1.imageData;
         }
      }
      
      private function updateStateAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:State = _loc3_[0] as State;
         this.updateState(_loc4_);
      }
      
      private function onMaskPointDown(param1:MouseEvent) : void
      {
         var _loc2_:MaskPoint = MaskPoint(param1.currentTarget);
         _loc2_.oPos = new Point(_loc2_.x,_loc2_.y);
         _loc2_.doDrag(param1);
      }
      
      public function loadAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:Rectangle = null;
         var _loc4_:Prop = null;
         var _loc5_:Canvas = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Class = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadAssetImageComplete);
         this.displayElement.visible = true;
         if(param1 is LoadEmbedMovieEvent)
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = param1.target.loader;
         }
         if(_loc2_ != null)
         {
            if(this.char == null)
            {
               _loc3_ = _loc2_.getBounds(_loc2_);
               if(this.facing != PropThumb(this.thumb).facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
               {
                  UtilPlain.flipObj(_loc2_);
               }
               if(this.posBeforeChangeState == null)
               {
                  if(this is VideoProp)
                  {
                     if((_loc5_ = this.displayElement.getChildAt(0) as Canvas) != null)
                     {
                        _loc2_.content.x = _loc5_.x;
                        _loc2_.content.y = _loc5_.y;
                     }
                  }
                  else
                  {
                     _loc2_.content.x = -(_loc3_.x + _loc3_.width / 2);
                     _loc2_.content.y = -(_loc3_.y + _loc3_.height / 2);
                  }
               }
               else
               {
                  _loc2_.content.x = -(_loc3_.x + _loc3_.width / 2);
                  _loc2_.content.y = -(_loc3_.y + _loc3_.height / 2);
                  _loc6_ = this.posBeforeChangeState.x - _loc2_.content.x;
                  _loc7_ = this.posBeforeChangeState.y - _loc2_.content.y;
                  this.x = this.x + _loc6_ * _loc2_.scaleX * this.scaleX;
                  this.y = this.y + _loc7_ * this.scaleY;
                  this.posBeforeChangeState = new Point(_loc2_.content.x,_loc2_.content.y);
               }
               displayElement.scaleX = this.scaleX;
               displayElement.scaleY = this.scaleY;
               if((_loc4_ = this.scene.getPropInPrevSceneById(this.id)) != null && this._fromTray)
               {
                  this.x = _loc4_.x;
                  this.y = _loc4_.y;
                  this.scaleX = _loc4_.scaleX;
                  this.scaleY = _loc4_.scaleY;
                  this.displayElement.scaleX = _loc4_.displayElement.scaleX;
                  this.displayElement.scaleY = _loc4_.displayElement.scaleY;
                  if(_loc4_.motionShadow != null && !this.isMotionShadow())
                  {
                     this.x = _loc4_.motionShadow.x;
                     this.y = _loc4_.motionShadow.y;
                     this.facing = _loc4_.motionShadow.facing;
                     this.scaleX = _loc4_.motionShadow.scaleX;
                     this.scaleY = _loc4_.motionShadow.scaleY;
                     this.rotation = _loc4_.motionShadow.rotation;
                     displayElement.scaleX = _loc4_.motionShadow.displayElement.scaleX;
                     displayElement.scaleY = _loc4_.motionShadow.displayElement.scaleY;
                  }
               }
               if(this.fromTray && Console.getConsole().stageScale > 1 && _loc4_ == null && Console.getConsole().mainStage.isCameraMode)
               {
                  this.scaleX = 1 / Console.getConsole().stageScale;
                  this.scaleY = 1 / Console.getConsole().stageScale;
                  this.scaleX = this.scaleY = displayElement.scaleX = displayElement.scaleY = Math.max(this.scaleX,this.scaleY);
               }
               if(this.isMotionShadow())
               {
                  if(_loc2_.content is DisplayObject)
                  {
                     UtilPlain.stopFamily(DisplayObject(_loc2_.content));
                     this.stopMusic(false);
                  }
               }
               this.fromTray = false;
            }
            else
            {
               if(_loc2_.content is AVM1Movie)
               {
                  _loc3_ = _loc2_.getBounds(this.bundle);
                  if(_loc3_.x < 0 && _loc3_.y < 0)
                  {
                     this.displayElement.graphics.beginFill(0,0);
                     this.displayElement.graphics.drawRect(_loc3_.x,_loc3_.y,_loc3_.width,_loc3_.height);
                     this.displayElement.graphics.endFill();
                  }
               }
               trace("prop load asset image complete, on char");
            }
            if(_loc2_.content.loaderInfo.applicationDomain.hasDefinition("theSound"))
            {
               _loc8_ = _loc2_.content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
               this.sound = new _loc8_();
               this.dispatchEvent(new Event("SoundAdded"));
            }
         }
         if(!this.isLoadded)
         {
            if(!capScreenLock)
            {
               this.bundle.callLater(this.setChange,[true]);
            }
         }
         updateColor();
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      function showMotionShadow() : void
      {
         var _loc1_:Prop = this.getMotionShadow();
         if(_loc1_ != null)
         {
            _loc1_.bundle.visible = true;
            this.scene.sendToFront(_loc1_.bundle,true);
            this.drawMotionLine();
         }
      }
      
      override public function getOriginalAssetPosition() : Point
      {
         return new Point(_originalAssetX,_originalAssetY);
      }
      
      public function doChangeState(param1:MenuEvent) : void
      {
         var _loc9_:State = null;
         var _loc10_:UtilLoadMgr = null;
         var _loc11_:Array = null;
         hideButtonBar();
         this.control = null;
         var _loc2_:ICommand = new ChangeActionCommand();
         _loc2_.execute();
         var _loc3_:String = param1.item.@label;
         var _loc4_:String = param1.item.@itemType;
         var _loc5_:String = param1.item.@stateId;
         var _loc6_:PropThumb;
         var _loc7_:Array = (_loc6_ = PropThumb(this.thumb)).states;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_.length)
         {
            _loc9_ = _loc7_[_loc8_];
            if(_loc5_ == _loc9_.id && this.imageData != null && this.imageData != _loc9_.imageData)
            {
               if(this._checkedStateItem != null)
               {
                  this._checkedStateItem.@toggled = "false";
               }
               if(_loc9_.imageData != null)
               {
                  this.updateState(_loc9_);
               }
               else
               {
                  _loc10_ = new UtilLoadMgr();
                  (_loc11_ = new Array()).push(_loc9_);
                  _loc10_.setExtraData(_loc11_);
                  _loc10_.addEventDispatcher(_loc6_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc10_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateStateAgain);
                  _loc10_.commit();
                  _loc6_.loadState(_loc9_);
               }
               this._checkedStateItem = param1.item;
               break;
            }
            _loc8_++;
         }
         param1.item.@toggled = "true";
      }
      
      public function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      protected function drawMotionLine(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc5_:int = 0;
         var _loc6_:TextArea = null;
         scene.dashline.visible = true;
         this._graphic.graphics.clear();
         UtilPlain.removeAllSon(this._graphic);
         this._curve.graphics.clear();
         if(scene.dashline.contains(this._curve))
         {
            scene.dashline.removeChild(this._curve);
         }
         if(scene.dashline.contains(motionDistTip))
         {
            scene.dashline.removeChild(motionDistTip);
         }
         this._curve.addChild(this._graphic);
         scene.dashline.addChildAt(this._curve,0);
         if(this.motionShadow != null)
         {
            this._spline.reset();
            if(this._knots.length == 0)
            {
               _loc3_ = this.getOrigin();
               _loc4_ = new Point(this.motionShadow.x,this.motionShadow.y);
               this._curve.graphics.lineStyle(4 / Console.getConsole().stageScale,13421772);
               UtilDraw.drawDashLineWithArrow(this._curve,_loc3_,_loc4_,10 / Console.getConsole().stageScale,5 / Console.getConsole().stageScale,15 / Console.getConsole().stageScale);
               this._curve.name = "theCurve";
               this._curve.addEventListener(MouseEvent.CLICK,this.onDashlineClickHandler);
               _loc2_ = Point.distance(_loc3_,_loc4_);
            }
            else
            {
               this._curve.removeEventListener(MouseEvent.CLICK,this.onDashlineClickHandler);
               this._spline.addControlPoint(this.x,this.y);
               _loc5_ = 0;
               while(_loc5_ < this._knots.length)
               {
                  this._spline.addControlPoint(MaskPoint(this._knots[_loc5_]).x,MaskPoint(this._knots[_loc5_]).y);
                  _loc5_++;
               }
               this._spline.addControlPoint(this.motionShadow.x,this.motionShadow.y);
               this._spline.draw(4 / Console.getConsole().stageScale,10 / Console.getConsole().stageScale,5 / Console.getConsole().stageScale,15 / Console.getConsole().stageScale);
               _loc2_ = this._spline.arcLength() * 2;
            }
            if(_loc2_ > AnimeConstants.ASSET_MOVE_TOLERANCE)
            {
               scene.dashline.addChildAt(motionDistTip,1);
               _loc2_ = Util.roundNum(_loc2_,0);
               (_loc6_ = motionDistTip).visible = true;
               _loc6_.setStyle("textAlign","center");
               _loc6_.width = 40;
               _loc6_.height = 18;
               _loc6_.selectable = false;
               _loc6_.text = String(_loc2_) + "px";
               _loc6_.x = this.x - _loc6_.width / 2;
               _loc6_.y = this.y - 18;
            }
            this.onDashlineOutHandler();
            scene.sendToFront(scene.dashline);
         }
      }
      
      private function buildMotionMenu(param1:Boolean = false) : ScrollableArrowMenu
      {
         var _loc2_:String = "<root>";
         if(param1)
         {
            _loc2_ = _loc2_ + ("<menu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_POINT_REMOVE) + "\" id=\"" + REMOVE_CONTROL_POINT + "\" type=\"check\" toggled=\"false\"/>");
         }
         else
         {
            _loc2_ = _loc2_ + ("<menu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_POINT_ADD) + "\" id=\"" + ADD_CONTROL_POINT + "\" type=\"check\" toggled=\"false\"/>");
         }
         _loc2_ = _loc2_ + ("<menu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT_REMOVE) + "\" id=\"" + REMOVE_MOTION + "\" toggled=\"false\"/></root>");
         var _loc3_:XML = new XML(_loc2_);
         var _loc4_:ScrollableArrowMenu;
         (_loc4_ = ScrollableArrowMenu.createMenu(null,_loc3_,false)).labelField = "@label";
         _loc4_.addEventListener(MenuEvent.ITEM_CLICK,this.doMotionMenuClick);
         return _loc4_;
      }
      
      public function getDataAndKey() : UtilHashArray
      {
         var _loc1_:UtilHashArray = new UtilHashArray();
         if(this.state == null)
         {
            this.state = PropThumb(this.thumb).defaultState;
         }
         _loc1_.push(this.thumb.theme.id + ".prop." + this.thumb.id + "." + this.state.id,this.state.imageData,true);
         return _loc1_;
      }
      
      public function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc4_:Image = null;
         this.enableMouseChildren(true);
         if(this.getSceneCanvas() != null)
         {
            _loc2_ = new Point(this.getSceneCanvas().mouseX,this.getSceneCanvas().mouseY);
            _loc3_ = new Point(this._originalX,this._originalY);
            if(this == this.scene.selectedAsset)
            {
               this._readyToDrag = false;
            }
            if(Console.getConsole().currDragObject != null)
            {
               (_loc4_ = Console.getConsole().currDragObject.bundle as Image).stopDrag();
               Console.getConsole().currDragObject = null;
               if(this.motionShadow != null && !this.isRegardAsMoved(new Point(this.bundle.x,this.bundle.y),new Point(this.motionShadow.x,this.motionShadow.y)) && !this.isRegardAsMoved(new Point(this.scaleX * 100,this.scaleY * 100),new Point(this.motionShadow.scaleX * 100,this.motionShadow.scaleY * 100)))
               {
                  scene.dashline.graphics.clear();
                  this.removeMotion();
                  this.updateTimelineMotion();
               }
            }
            if(this.motionShadow && this.motionShadow.bundle)
            {
               this.motionShadow.bundle.stopDrag();
            }
            changed = true;
            displayElement.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
            displayElement.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
            Console.getConsole().thumbTrayActive = true;
         }
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
         this._demoSpeech = param1;
         if(param1)
         {
            this.dispatchEvent(new SpeechPitchEvent(SpeechPitchEvent.DEMO_START));
         }
         else
         {
            this.dispatchEvent(new SpeechPitchEvent(SpeechPitchEvent.DEMO_END));
         }
      }
      
      public function loadState(param1:CoreEvent) : void
      {
         if(this._fromTray)
         {
            this.state = PropThumb(this.thumb).defaultState;
         }
         else
         {
            this.state = PropThumb(this.thumb).getStateById(this.stateId);
         }
      }
      
      private function updateState(param1:State) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Loader = this.displayElement.getChildByName(AnimeConstants.IMAGE_OBJECT_NAME) as Loader;
         if(_loc2_)
         {
            _loc3_ = _loc2_.content.x;
            _loc4_ = _loc2_.content.y;
            this.posBeforeChangeState = new Point(_loc3_,_loc4_);
         }
         this.state = param1;
         if(this._motionShadowProp != null)
         {
            this._motionShadowProp.state = param1;
         }
         this.hideControl();
         if(this.char != null && this.char.thumb.isCC && CustomCharacterMaker(this.char.imageObject).ver == 2)
         {
            this.char.updatePropState(this.thumb,this.state);
         }
      }
      
      override public function set imageData(param1:Object) : void
      {
         super.imageData = param1;
      }
      
      private function snapAsset(param1:Asset) : void
      {
         var _loc2_:int = 75;
         param1.x = param1.x + (param1.x > AnimeConstants.STAGE_WIDTH / 2?-_loc2_:_loc2_);
      }
      
      private function get char() : Character
      {
         return this._char;
      }
      
      public function rotate(param1:Control) : void
      {
         var _loc2_:Number = this.getSceneCanvas().mouseX - this.bundle.x;
         var _loc3_:Number = this.getSceneCanvas().mouseY - this.bundle.y;
         var _loc4_:Number = Math.atan2(_loc3_,_loc2_);
         var _loc6_:Rectangle;
         var _loc5_:Sprite;
         var _loc7_:Number = (_loc6_ = (_loc5_ = param1.currController).getRect(this.bundle)).x + _loc6_.width / 2;
         var _loc8_:Number = _loc6_.y + _loc6_.height / 2;
         var _loc9_:Number = Math.atan2(_loc8_,_loc7_);
         this.rotation = (_loc4_ - _loc9_) * 180 / Math.PI;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:Prop = new Prop();
         if(this.char == null)
         {
            _loc3_.x = this.x;
            _loc3_.y = this.y;
            _loc3_.scaleX = this.scaleX;
            _loc3_.scaleY = this.scaleY;
            _loc3_.rotation = this.rotation;
            _loc3_.scene = this.scene;
         }
         _loc3_.id = _loc3_.bundle.id = this.id;
         _loc3_.attachedBg = this.attachedBg;
         _loc3_.init(this.thumb,this.char);
         _loc3_.facing = this.facing;
         _loc3_.stateId = this.stateId;
         _loc3_.state = this.state;
         _loc3_.lookAtCamera = this.lookAtCamera;
         if(this.motionShadow != null && !this.isMotionShadow())
         {
            _loc3_.x = this.motionShadow.x;
            _loc3_.y = this.motionShadow.y;
            _loc3_.facing = this.motionShadow.facing;
            _loc3_.scaleX = this.motionShadow.scaleX;
            _loc3_.scaleY = this.motionShadow.scaleY;
            _loc3_.rotation = this.motionShadow.rotation;
         }
         _loc3_.customColor = this.customColor.clone();
         _loc3_.defaultColorSet = this.defaultColorSet.clone();
         return _loc3_;
      }
      
      private function getShadowIndex(param1:AnimeScene) : int
      {
         return param1.background == null?0:1;
      }
      
      public function deSerialize(param1:XML, param2:Character, param3:AnimeScene = null, param4:Boolean = true, param5:Boolean = true) : void
      {
         var _loc11_:RegExp = null;
         var _loc12_:PropThumb = null;
         var _loc13_:XML = null;
         var _loc14_:int = 0;
         var _loc15_:SelectedColor = null;
         var _loc6_:String = UtilXmlInfo.getZipFileNameOfProp(param1.child("file")[0].toString());
         var _loc7_:String = UtilXmlInfo.getThumbIdFromFileName(_loc6_);
         var _loc8_:String = _loc6_.split(".").length == 4?_loc7_:UtilXmlInfo.getCharIdFromFileName(_loc6_);
         if(_loc7_.indexOf(".head.") != -1)
         {
            _loc8_ = UtilXmlInfo.getFacialThumbIdFromFileName(_loc7_);
            _loc7_ = UtilXmlInfo.getFacialIdFromFileName(_loc7_);
            _loc11_ = /zip/gi;
            _loc7_ = _loc7_.replace(_loc11_,"xml");
         }
         var _loc9_:String = UtilXmlInfo.getThemeIdFromFileName(_loc6_);
         var _loc10_:Theme;
         if((_loc10_ = Console.getConsole().getTheme(_loc9_)) != null)
         {
            _loc12_ = _loc10_.getPropThumbById(_loc8_);
            if(param4 && !Prop._existIDs.containsKey(param1.attribute("id")))
            {
               this.id = this.bundle.id = param1.attribute("id");
               Prop._existIDs.push(this.id,this.id);
            }
            if(_loc12_ != null)
            {
               if(param5)
               {
                  this.init(_loc12_,param2);
               }
               else
               {
                  super.thumb = _loc12_;
               }
               if(param2 == null && param3 != null)
               {
                  this.scene = param3;
                  this._xs = String(param1.x).split(",");
                  this._ys = String(param1.y).split(",");
                  this._scaleXs = String(param1.xscale).split(",");
                  this._scaleYs = String(param1.yscale).split(",");
                  this._rotations = String(param1.rotation).split(",");
                  this._facings = String(param1.face).split(",");
                  this.x = this._xs[0];
                  this.y = this._ys[0];
                  this.scaleX = this._scaleXs[0];
                  this.scaleY = this._scaleYs[0];
                  this.rotation = this._rotations[0];
                  if(this._facings[0] == "1")
                  {
                     this.facing = this.defaultFacing;
                  }
                  else if(this._facings[0] == "-1")
                  {
                     if(this.defaultFacing == AnimeConstants.FACING_LEFT)
                     {
                        this.facing = AnimeConstants.FACING_RIGHT;
                     }
                     else if(this.defaultFacing == AnimeConstants.FACING_RIGHT)
                     {
                        this.facing = AnimeConstants.FACING_LEFT;
                     }
                  }
                  if(this.shouldHasMotion())
                  {
                     this.fillMaskPoint();
                     this.bundle.callLater(this.addMotionShadow,[this._xs,this._ys,this._scaleXs,this._scaleYs,this._facings,this._rotations]);
                     this.bundle.callLater(this.hideMotionShadow);
                  }
               }
               if(param5)
               {
                  this.state = _loc12_.getStateById(_loc7_);
               }
               else
               {
                  this._state = _loc12_.getStateById(_loc7_);
                  this._stateId = _loc7_;
               }
               if(this.state != null && this.state.imageData != null)
               {
                  this.isLoadded = true;
               }
               if(param1.dcsn.length() > 0)
               {
                  this.defaultColorSetId = String(param1.dcsn);
                  this.defaultColorSet = this.thumb.getColorSetById(this.defaultColorSetId);
               }
               customColor = new UtilHashArray();
               _loc14_ = 0;
               while(_loc14_ < param1.child("color").length())
               {
                  _loc13_ = param1.child("color")[_loc14_];
                  _loc15_ = new SelectedColor(_loc13_.@r,_loc13_.attribute("oc").length() == 0?uint(uint.MAX_VALUE):uint(_loc13_.@oc),uint(_loc13_));
                  this.addCustomColor(_loc13_.@r,_loc15_);
                  _loc14_++;
               }
               if(!this is VideoProp)
               {
                  updateColor();
               }
            }
         }
      }
      
      public function get slideEnabled() : Boolean
      {
         return true;
      }
      
      private function removeMotion() : void
      {
         this.removeMotionShadow();
         this.changed = true;
      }
      
      public function endResize() : void
      {
         this.scaleX = displayElement.scaleX;
         this.scaleY = displayElement.scaleY;
         this._originalRotation = this.bundle.rotation;
         this.changed = true;
      }
      
      private function isRegardAsMoved(param1:Point, param2:Point) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         if(param2.subtract(param1).length > AnimeConstants.ASSET_MOVE_TOLERANCE)
         {
            return true;
         }
         return false;
      }
      
      public function serializeColor() : String
      {
         var _loc2_:int = 0;
         var _loc1_:* = "";
         if(customColor.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < customColor.length)
            {
               _loc1_ = _loc1_ + ("<color r=\"" + customColor.getKey(_loc2_) + "\"");
               _loc1_ = _loc1_ + (SelectedColor(customColor.getValueByIndex(_loc2_)).orgColor == uint.MAX_VALUE?"":" oc=\"0x" + SelectedColor(customColor.getValueByIndex(_loc2_)).orgColor.toString(16) + "\"");
               _loc1_ = _loc1_ + ">";
               _loc1_ = _loc1_ + SelectedColor(customColor.getValueByIndex(_loc2_)).dstColor;
               _loc1_ = _loc1_ + "</color>";
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function removeDisplayElementListener() : void
      {
         trace("removeDisplayElementListener");
         if(this.char != null)
         {
            this.displayElement.removeEventListener(DragEvent.DRAG_ENTER,this.char.doDragEnter);
            this.displayElement.removeEventListener(DragEvent.DRAG_DROP,this.char.doDragDrop);
            this.displayElement.removeEventListener(DragEvent.DRAG_EXIT,this.char.doDragExit);
            this.displayElement.removeEventListener(DragEvent.DRAG_COMPLETE,this.char.doDragComplete);
         }
      }
      
      private function doMotionMenuClick(param1:MenuEvent) : void
      {
         this.doChangeMotion(param1);
      }
      
      public function get motionShadow() : Prop
      {
         return this._motionShadowProp;
      }
      
      private function get defaultFacing() : String
      {
         return PropThumb(this.thumb).facing;
      }
      
      override public function addControl() : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:Control = null;
         var _loc1_:Loader = Loader(this.imageObject);
         if(_loc1_ != null && _loc1_.content != null)
         {
            UtilPlain.gotoAndStopFamilyAt1(_loc1_.content);
            this.stopMusic(false,true);
            _loc2_ = _loc1_.getBounds(this.bundle);
            if(this.isMotionShadow())
            {
               _loc3_ = ControlMgr.getControl(_loc1_,ControlMgr.SHADOW);
            }
            else
            {
               _loc3_ = ControlMgr.getControl(_loc1_,ControlMgr.NORMAL);
            }
            _loc3_.target = this;
            _loc3_.asset = _loc1_;
            _loc3_.minHeight = 3;
            _loc3_.minWidth = 3;
            _loc3_.rotatable = true;
            _loc3_.setPos(_loc2_.x,_loc2_.y);
            _loc3_.setSize(_loc2_.width,_loc2_.height);
            _loc3_.setOrigin(-_loc2_.x,-_loc2_.y);
            _loc3_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
            _loc3_.addEventListener("CtrlPointUp",onCtrlPointUpHandler);
            _loc3_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
            this._prevCharPosX = _loc2_.x;
            this._prevCharPosY = _loc2_.y;
            this._orgLoaderScaleX = Math.abs(displayElement.scaleX);
            this._orgLoaderScaleY = Math.abs(displayElement.scaleY);
            _loc3_.hideControl();
            this.control = _loc3_;
         }
      }
      
      public function shouldHasMotion() : Boolean
      {
         if(Math.max(this._xs.length,this._ys.length,this._scaleXs.length,this._scaleYs.length,this._rotations.length) > 1)
         {
            return true;
         }
         return false;
      }
      
      override public function flipIt() : void
      {
         var _loc1_:ICommand = null;
         var _loc2_:String = this.facing;
         this.facing = this.facing == AnimeConstants.FACING_LEFT?AnimeConstants.FACING_RIGHT:AnimeConstants.FACING_LEFT;
         _loc1_ = new FlipAssetCommand(id,_loc2_);
         _loc1_.execute();
      }
      
      public function resizing(param1:Control) : void
      {
         this.bundle.graphics.clear();
         var _loc2_:Object = param1.getStuff(this._prevDisplayElementPosX,this._prevDisplayElementPosY);
         displayElement.scaleX = _loc2_.scaleX * this._orgLoaderScaleX;
         displayElement.scaleY = _loc2_.scaleY * this._orgLoaderScaleY;
      }
      
      private function onDashlineOutHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:GlowFilter = new GlowFilter(0,1,3,3,250);
         var _loc3_:Array = new Array();
         _loc3_.push(_loc2_);
         scene.dashline.filters = _loc3_;
      }
      
      private function deleteMaskPointByName(param1:String) : void
      {
         var _loc2_:DisplayObject = scene.dashline.getChildByName(param1);
         scene.dashline.removeChild(_loc2_);
         var _loc3_:Number = -1;
         var _loc4_:int = 0;
         while(_loc4_ < this._knots.length)
         {
            if(this._knots[_loc4_] == _loc2_)
            {
               _loc3_ = _loc4_;
            }
            _loc4_++;
         }
         this._knots.splice(_loc3_,1);
         this.drawMotionLine();
      }
      
      private function addControlPoint(param1:Point) : void
      {
         var _loc2_:MaskPoint = new MaskPoint();
         _loc2_.scaleX = _loc2_.scaleY = 1 / Console.getConsole().stageScale;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.doubleClickEnabled = true;
         _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,this.onMaskPointDown);
         _loc2_.addEventListener(MouseEvent.MOUSE_MOVE,this.drawMotionLine);
         _loc2_.addEventListener(MouseEvent.MOUSE_UP,_loc2_.doMouseUp);
         _loc2_.addEventListener(MouseEvent.CLICK,this.showMotionMenu);
         _loc2_.addEventListener(MouseEvent.DOUBLE_CLICK,this.deleteMaskPoint);
         scene.dashline.addChild(_loc2_);
         if(this._insertingPoint > -1)
         {
            this._knots.splice(this._insertingPoint,0,_loc2_);
         }
         else
         {
            this._knots.push(_loc2_);
         }
         this.drawMotionLine();
      }
      
      public function set motionData(param1:MotionData) : void
      {
         this._knots.splice(0,this._knots.length);
         this.motionShadow = null;
         this._originalX = this.getSceneCanvas().mouseX;
         this._originalY = this.getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         this.refreshMotionShadow();
         this.motionShadow.x = this.x + param1.displacement.x;
         this.motionShadow.y = this.y + param1.displacement.y;
         this.hideControl();
      }
      
      public function stopProp() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = Loader(this.imageObject);
            if(_loc1_ != null)
            {
               _loc2_ = DisplayObject(_loc1_.content);
               if(_loc2_ != null)
               {
                  UtilPlain.stopFamily(_loc2_);
                  this.stopMusic(false);
               }
            }
         }
      }
      
      public function clearDisplayElement() : void
      {
         var _loc2_:Loader = null;
         var _loc3_:CustomHeadMaker = null;
         var _loc1_:int = this.displayElement.numChildren - 1;
         while(_loc1_ >= 0)
         {
            if(this.displayElement.getChildAt(_loc1_) is Loader)
            {
               _loc2_ = Loader(this.displayElement.getChildAt(_loc1_));
               _loc2_.unloadAndStop();
            }
            else if(this.displayElement.getChildAt(_loc1_) is CustomHeadMaker)
            {
               _loc3_ = CustomHeadMaker(this.displayElement.getChildAt(_loc1_));
               _loc3_.unloadAssetImage(true);
            }
            this.displayElement.removeChildAt(_loc1_);
            _loc1_--;
         }
      }
      
      private function addMotionMenuListener() : void
      {
         scene.dashline.addEventListener(MouseEvent.MOUSE_OVER,this.onDashlineOverHandler);
         scene.dashline.addEventListener(MouseEvent.MOUSE_OUT,this.onDashlineOutHandler);
      }
      
      public function get stateId() : String
      {
         return this._stateId;
      }
      
      function clearMotionLine() : void
      {
         scene.dashline.graphics.clear();
         if(scene.dashline.contains(this._curve))
         {
            scene.dashline.removeChild(this._curve);
         }
         if(scene.dashline.contains(motionDistTip))
         {
            scene.dashline.removeChild(motionDistTip);
         }
         scene.dashline.visible = false;
      }
      
      public function get stateMenu() : ScrollableArrowMenu
      {
         var _loc1_:ScrollableArrowMenu = null;
         var _loc2_:String = "";
         _loc2_ = this.buildStateMenu(_loc2_);
         this._actionMenuXML = new XML(_loc2_);
         _loc1_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),this._actionMenuXML,false);
         _loc1_.labelField = "@label";
         _loc1_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc1_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc1_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc1_.maxHeight = 300;
         _loc1_.minWidth = 150;
         return _loc1_;
      }
      
      public function get state() : State
      {
         return this._state;
      }
      
      override public function updateOriginalAssetScale() : void
      {
         _originalAssetScaleX = this.displayElement.scaleX;
         _originalAssetScaleY = this.displayElement.scaleY;
      }
      
      private function hideControlPoint() : void
      {
         var _loc1_:Number = scene.dashline.numChildren;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(scene.dashline.getChildAt(_loc2_) is MaskPoint)
            {
               scene.dashline.getChildAt(_loc2_).visible = false;
            }
            _loc2_++;
         }
      }
      
      override public function freeze(param1:Boolean = true) : void
      {
         super.freeze(param1);
         if(!param1)
         {
            this.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
         else
         {
            this.displayElement.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         }
      }
      
      private function updateTimelineMotion() : void
      {
         if(this.char == null)
         {
            scene.doUpdateTimelineLength(-1,true);
         }
      }
      
      private function doRemoveMotion() : void
      {
         var _loc1_:ICommand = new RemoveMotionCommand();
         _loc1_.execute();
         this.removeMotion();
         this.updateTimelineMotion();
      }
      
      override public function updateOriginalAssetPosition() : void
      {
         _originalAssetX = this.x;
         _originalAssetY = this.y;
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(!this.isMotionShadow())
         {
            this.hideControlPoint();
            this.showControlPoint();
            this.showMotionShadow();
            this.addMotionMenuListener();
            if(!Console.getConsole().isTutorialOn)
            {
               showButtonBar();
            }
         }
         if(this.motionShadow != null)
         {
            this.motionShadow.showControl();
         }
      }
      
      private function set posBeforeChangeState(param1:Point) : void
      {
         this._posBeforeChangeState = param1;
      }
      
      public function get demoSpeech() : Boolean
      {
         return this._demoSpeech;
      }
      
      public function showActionMenu(param1:Number, param2:Number) : void
      {
         this._actionMenu = this.buildActionMenu();
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc3_ = 105;
         _loc4_ = 25;
         var _loc5_:Canvas;
         var _loc6_:Point = (_loc5_ = Console.getConsole().mainStage._stageArea).localToGlobal(new Point(0,0));
         if(Console.getConsole().stageScale > 1)
         {
            _loc6_ = new Point(0,68);
         }
         var _loc7_:Number = _loc5_.stage.mouseX;
         var _loc8_:Number = _loc5_.stage.mouseY;
         if(_loc7_ + _loc3_ > _loc6_.x + _loc5_.width)
         {
            _loc7_ = _loc6_.x + _loc5_.width - _loc3_;
         }
         if(_loc8_ + _loc4_ > _loc6_.y + _loc5_.height)
         {
            _loc8_ = _loc6_.y + _loc5_.height - _loc4_;
         }
         this._actionMenu.show(param1,param2);
      }
      
      public function get isSliding() : Boolean
      {
         return this.motionShadow != null;
      }
      
      private function doChangeMotion(param1:MenuEvent) : void
      {
         var _loc7_:ICommand = null;
         var _loc2_:String = param1.item.@id;
         var _loc3_:String = param1.item.@label;
         var _loc4_:String = param1.item.@data;
         var _loc5_:String = param1.item.@direction;
         var _loc6_:String = param1.item.@itemType;
         if(_loc2_ == REMOVE_MOTION)
         {
            (_loc7_ = new RemoveMotionCommand()).execute();
            this.startRemoveMotion();
            this.updateTimelineMotion();
            return;
         }
         if(_loc2_ == ADD_CONTROL_POINT)
         {
            this.addControlPoint(this._mouseClickPoint);
            return;
         }
         if(_loc2_ == REMOVE_CONTROL_POINT)
         {
            this.deleteMaskPointByName(this._currControlPointName);
         }
      }
      
      private function setChange(param1:Boolean) : void
      {
         this.changed = param1;
      }
      
      private function set char(param1:Character) : void
      {
         this._char = param1;
      }
      
      public function set facing(param1:String) : void
      {
         var displayElement:DisplayObject = null;
         var loader:Loader = null;
         var facing:String = param1;
         if(facing != this.facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
         {
            try
            {
               displayElement = bundle.getChildAt(0) as DisplayObject;
               loader = Loader(this.imageObject);
               UtilPlain.flipObj(loader);
               scaleX = displayElement.scaleX;
               scaleY = displayElement.scaleY;
            }
            catch(e:Error)
            {
            }
         }
         this._facing = facing;
      }
      
      override function doDragEnter(param1:DragEvent) : void
      {
         if(this.char != null)
         {
            this.char.doDragEnter(param1);
         }
      }
      
      override public function set control(param1:Control) : void
      {
         var _loc2_:Loader = null;
         super.control = param1;
         if(param1 == null && !(this is VideoProp))
         {
            _loc2_ = Loader(this.imageObject);
            if(_loc2_.content != null && _loc2_.content is MovieClip)
            {
               UtilPlain.playFamily(MovieClip(_loc2_.content));
               if(this.soundChannel != null)
               {
                  this.playMusic(this.soundPos,0,this.soundChannel.soundTransform);
               }
            }
         }
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         var _loc2_:PropThumb = param1 as PropThumb;
         super.thumb = param1;
         if(_loc2_ is VideoPropThumb)
         {
            this.imageData = param1.imageData;
         }
         else if(PropThumb(param1).states.length > 0)
         {
            if(this._fromTray)
            {
               this.state = _loc2_.defaultState;
            }
            else
            {
               this.state = _loc2_.getStateById(this.stateId);
            }
         }
         else
         {
            this.imageData = param1.imageData;
         }
      }
      
      public function serializeMotion(param1:String, param2:Prop) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = new Array();
         switch(param1)
         {
            case "x":
               _loc3_.push(Util.roundNum(this.x));
               break;
            case "y":
               _loc3_.push(Util.roundNum(this.y));
               break;
            case "xscale":
               _loc3_.push(Util.roundNum(this.scaleX,AnimeConstants.MATH_DOT_NUM + 1));
               break;
            case "yscale":
               _loc3_.push(Util.roundNum(this.scaleY,AnimeConstants.MATH_DOT_NUM + 1));
               break;
            case "facing":
               _loc3_.push(this.facing == this.defaultFacing?1:-1);
               break;
            case "rotation":
               _loc3_.push(Util.roundNum(this.bundle.rotation));
         }
         if(this._knots.length != 0)
         {
            _loc4_ = 0;
            switch(param1)
            {
               case "x":
                  _loc4_ = 0;
                  while(_loc4_ < this._knots.length)
                  {
                     _loc3_.push(Util.roundNum(MaskPoint(this._knots[_loc4_]).x));
                     _loc4_++;
                  }
                  break;
               case "y":
                  _loc4_ = 0;
                  while(_loc4_ < this._knots.length)
                  {
                     _loc3_.push(Util.roundNum(MaskPoint(this._knots[_loc4_]).y));
                     _loc4_++;
                  }
            }
         }
         if(param2 != null)
         {
            switch(param1)
            {
               case "x":
                  _loc3_.push(Util.roundNum(param2.x));
                  break;
               case "y":
                  _loc3_.push(Util.roundNum(param2.y));
                  break;
               case "xscale":
                  _loc3_.push(Util.roundNum(param2.scaleX,AnimeConstants.MATH_DOT_NUM + 1));
                  break;
               case "yscale":
                  _loc3_.push(Util.roundNum(param2.scaleY,AnimeConstants.MATH_DOT_NUM + 1));
                  break;
               case "facing":
                  _loc3_.push(this._motionShadow_facing == this.defaultFacing?1:-1);
                  break;
               case "rotation":
                  _loc3_.push(Util.roundNum(param2.rotation));
            }
         }
         return _loc3_;
      }
      
      public function isMotionShadow() : Boolean
      {
         if(this.bundle.name.substr(0,12) == "motionShadow")
         {
            return true;
         }
         return false;
      }
      
      private function fillMaskPoint() : void
      {
         var _loc1_:int = 0;
         if(this._xs.length > 2 && this._xs.length == this._ys.length)
         {
            _loc1_ = 1;
            while(_loc1_ < this._xs.length - 1)
            {
               this.addControlPoint(new Point(this._xs[_loc1_],this._ys[_loc1_]));
               _loc1_++;
            }
         }
      }
      
      override function hideControl() : void
      {
         super.hideControl();
         if(!this.isMotionShadow())
         {
            this.hideControlPoint();
            this.hideMotionShadow();
            this.removeMotionMenuListener();
            hideButtonBar();
         }
         if(this.motionShadow != null)
         {
            this.motionShadow.hideControl();
         }
      }
      
      private function buildActionMenu() : ScrollableArrowMenu
      {
         var _loc1_:ScrollableArrowMenu = null;
         var _loc2_:* = "<menuRoot>";
         _loc2_ = this.buildStateMenu(_loc2_);
         _loc2_ = _loc2_ + ("<mainMenu label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT)) + "\" toggled=\"false\">");
         _loc2_ = _loc2_ + ("<menuItem label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_SLIDE)) + "\" value=\"" + AnimeConstants.MOVEMENT_SLIDE + "\" type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + MENU_ITEM_TYPE_MOVEMENT_TAG + "\" toggled=\"" + false + "\"/>");
         _loc2_ = _loc2_ + "</mainMenu>";
         _loc2_ = _loc2_ + "</menuRoot>";
         this._actionMenuXML = new XML(_loc2_);
         _loc1_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),this._actionMenuXML,false);
         _loc1_.labelField = "@label";
         _loc1_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc1_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc1_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc1_.maxHeight = Console.getConsole().mainStage._stageArea.height;
         return _loc1_;
      }
      
      public function reloadAssetImage() : void
      {
         this.loadAssetImage();
      }
      
      override public function startResize() : void
      {
         super.startResize();
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetScaleX = this.scaleX = displayElement.scaleX;
         _originalAssetScaleY = this.scaleY = displayElement.scaleY;
         this._prevDisplayElementPosX = displayElement.x;
         this._prevDisplayElementPosY = displayElement.y;
      }
      
      public function playProp() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = Loader(this.imageObject);
            if(_loc1_ != null)
            {
               _loc2_ = DisplayObject(_loc1_.content);
               UtilPlain.playFamily(_loc2_);
               if(this.soundChannel != null)
               {
                  this.playMusic(this.soundPos,0,this.soundChannel.soundTransform);
               }
            }
         }
      }
      
      private function addDisplayElementListener() : void
      {
         trace("addDisplayElementListener");
         if(this.char != null)
         {
            this.displayElement.addEventListener(DragEvent.DRAG_ENTER,this.char.doDragEnter);
            this.displayElement.addEventListener(DragEvent.DRAG_DROP,this.char.doDragDrop);
            this.displayElement.addEventListener(DragEvent.DRAG_EXIT,this.char.doDragExit);
            this.displayElement.addEventListener(DragEvent.DRAG_COMPLETE,this.char.doDragComplete);
         }
      }
      
      private function onShadowMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Image = Image(this.motionShadow.bundle);
         _loc2_.startDrag();
         this.hideControl();
         this._originalX = this.getSceneCanvas().mouseX;
         this._originalY = this.getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetFacing = this.facing;
         this._originalRotation = this.bundle.rotation;
         this._readyToDrag = true;
         this._backupSceneXML = new XML(this.scene.serialize(-1,false));
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
         this.enableMouseChildren(false);
      }
      
      public function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null, param5:Array = null, param6:Array = null) : void
      {
         var _loc7_:int = 0;
         var _loc8_:AnimeScene = null;
         var _loc9_:Prop = null;
         if(!this.isMotionShadow())
         {
            _loc7_ = Console.getConsole().getSceneIndex(scene);
            _loc8_ = Console.getConsole().getScene(_loc7_);
            if(this.motionShadow == null || !_loc8_.canvas.contains(this.motionShadow.bundle))
            {
               _loc9_ = Prop(this.clone());
               if(!(param1 == null && param2 == null && param3 == null && param4 == null && param5 == null && param6 == null))
               {
                  _loc9_.x = param1[param1.length - 1];
                  _loc9_.y = param2[param2.length - 1];
                  _loc9_.rotation = param6[param6.length - 1];
                  _loc9_.scaleX = param3[param3.length - 1];
                  _loc9_.scaleY = param4[param4.length - 1];
               }
               this._motionShadow_facing = _loc9_.facing;
               this.motionShadow = Prop(_loc9_.clone());
               this.motionShadow.bundle.name = this.motionShadow.id = "motionShadow_" + id;
               this.motionShadow.bundle.alpha = 0.7;
               this.motionShadow.bundle.buttonMode = true;
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.onShadowMouseDown);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
               _loc8_.canvas.addChildAt(this.motionShadow.bundle,this.getShadowIndex(_loc8_));
            }
            this.showMotionShadow();
         }
      }
      
      private function showControlPoint() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:Number = this._knots.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = scene.dashline.getChildIndex(this._knots[_loc2_]);
            if(_loc3_ >= 0)
            {
               MaskPoint(scene.dashline.getChildAt(_loc3_)).visible = true;
            }
            _loc2_++;
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var loader:Loader = null;
         var self:Prop = null;
         var ccHead:CustomHeadMaker = null;
         var args:Object = null;
         trace("loadAssetImage:" + this.id);
         this.clearDisplayElement();
         if(!PropThumb(this.thumb).isCC)
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadAssetImageComplete);
            loader.loadBytes(ByteArray(this.imageData));
            loader.name = AnimeConstants.IMAGE_OBJECT_NAME;
            this.displayElement.addChild(loader);
         }
         else
         {
            self = this;
            ccHead = new CustomHeadMaker();
            args = this.imageData;
            ccHead.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.loadAssetImageComplete);
            if(this.initCameraHandler != null)
            {
               removeEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this.initCameraHandler);
            }
            this.initCameraHandler = function(param1:ExtraDataEvent):void
            {
               var _loc2_:Boolean = Boolean(param1.getData());
               ccHead.lookAtCamera = _loc2_;
            };
            this.speechHandler = function(param1:SpeechPitchEvent):void
            {
               var _loc2_:Boolean = param1.type == SpeechPitchEvent.DEMO_START?true:false;
               ccHead.demoSpeech = _loc2_;
            };
            addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this.initCameraHandler);
            addEventListener(SpeechPitchEvent.DEMO_START,this.speechHandler);
            addEventListener(SpeechPitchEvent.DEMO_END,this.speechHandler);
            ccHead.lookAtCamera = this.lookAtCamera;
            ccHead.demoSpeech = this.demoSpeech = this.char.demoSpeech;
            ccHead.init(args["xml"] as XML,0,0,args["imageData"] as UtilHashArray,null);
            ccHead.name = AnimeConstants.IMAGE_OBJECT_NAME;
            this.displayElement.addChild(ccHead);
            this.displayElement.visible = false;
         }
      }
      
      private function deleteMaskPoint(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.currentTarget);
         scene.dashline.removeChild(_loc2_);
         var _loc3_:Number = -1;
         var _loc4_:int = 0;
         while(_loc4_ < this._knots.length)
         {
            if(this._knots[_loc4_] == _loc2_)
            {
               _loc3_ = _loc4_;
            }
            _loc4_++;
         }
         this._knots.splice(_loc3_,1);
         this.drawMotionLine();
      }
      
      public function onStageMouseMoveHandler(param1:MouseEvent) : void
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
      
      private function get posBeforeChangeState() : Point
      {
         return this._posBeforeChangeState;
      }
      
      override function onMouseDown(param1:MouseEvent) : void
      {
         super.onMouseDown(param1);
         this._originalX = this.getSceneCanvas().mouseX;
         this._originalY = this.getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetFacing = this.facing;
         this._originalRotation = this.bundle.rotation;
         this._readyToDrag = true;
         this._backupSceneXML = new XML(this.scene.serialize(-1,false));
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
         this.enableMouseChildren(false);
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      public function removeSlideMotion() : void
      {
         this.startRemoveMotion();
         this.updateTimelineMotion();
      }
      
      override protected function getSceneCanvas() : Canvas
      {
         if(this.char == null)
         {
            return super.getSceneCanvas();
         }
         return null;
      }
      
      override public function getOriginalAssetScale() : Point
      {
         return new Point(_originalAssetScaleX,_originalAssetScaleY);
      }
      
      private function startRemoveMotion(param1:MenuEvent = null) : void
      {
         var _loc2_:TextArea = motionDistTip;
         _loc2_.visible = false;
         scene.dashline.graphics.clear();
         var _loc3_:Number = scene.dashline.numChildren;
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= 0)
         {
            if(scene.dashline.getChildAt(_loc4_) is MaskPoint && this._knots.indexOf(scene.dashline.getChildAt(_loc4_)) > -1)
            {
               scene.dashline.removeChildAt(_loc4_);
            }
            this._knots.splice(0,this._knots.length);
            _loc4_--;
         }
         if(this.motionShadow != null)
         {
            Tweener.addTween(this.motionShadow.bundle,{
               "x":this.x,
               "y":this.y,
               "alpha":0.25,
               "time":0.7,
               "onComplete":this.removeMotion
            });
         }
      }
      
      public function buildStateMenu(param1:String, param2:Boolean = true) : String
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Object = null;
         var _loc9_:State = null;
         var _loc10_:Boolean = false;
         var _loc3_:PropThumb = PropThumb(this.thumb);
         var _loc4_:Array = _loc3_.states;
         var _loc5_:Array = _loc3_.stateMenuItems;
         if(_loc3_.holdable)
         {
            _loc6_ = MENU_ITEM_TYPE_PROP_TAG;
         }
         else if(_loc3_.headable)
         {
            _loc6_ = MENU_ITEM_TYPE_HEAD_TAG;
         }
         else if(_loc3_.wearable)
         {
            _loc6_ = MENU_ITEM_TYPE_WEAR_TAG;
         }
         else
         {
            _loc6_ = MENU_ITEM_TYPE_STATE_TAG;
         }
         if(_loc5_.length > 0)
         {
            param1 = param1 + (!!param2?"<mainMenu label=\"" + UtilDict.toDisplay("go",MENU_ITEM_STATES) + "\" toggled=\"false\">":"");
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if((_loc8_ = _loc5_[_loc7_]) is State)
               {
                  if((_loc9_ = State(_loc8_)).imageData != null && (_loc9_.imageData == this.imageData || _loc9_.imageData.bytesAvailable == ByteArray(this.imageData).bytesAvailable))
                  {
                     _loc10_ = true;
                  }
                  else
                  {
                     _loc10_ = false;
                  }
                  param1 = param1 + ("<menuItem " + "label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("store",_loc9_.name).toLowerCase()) + "\" " + "type=\"check\" " + MENU_ITEM_TYPE_TAG + "=\"" + _loc6_ + "\" " + "stateId=\"" + _loc9_.id + "\" " + "toggled=\"" + _loc10_ + "\"/>");
               }
               _loc7_++;
            }
            param1 = param1 + (!!param2?"</mainMenu>":"");
         }
         return param1;
      }
      
      private function removeMotionMenuListener() : void
      {
         scene.dashline.removeEventListener(MouseEvent.MOUSE_OVER,this.onDashlineOverHandler);
         scene.dashline.removeEventListener(MouseEvent.MOUSE_OUT,this.onDashlineOutHandler);
      }
      
      public function startDragging() : void
      {
         this.hideControl();
         this._originalX = this.getSceneCanvas().mouseX;
         this._originalY = this.getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         this._readyToDrag = true;
         var _loc1_:Image = Image(this.bundle);
         _loc1_.startDrag();
         if(!this.isMotionShadow())
         {
            displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
            displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         }
         else
         {
            displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this._shadowParent.onStageMouseMoveHandler);
            displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this._shadowParent.onStageMouseUpHandler);
         }
         Console.getConsole().currDragObject = this;
      }
      
      private function doActionMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:ICommand = null;
         var _loc3_:String = param1.item.@itemType;
         var _loc4_:XML;
         var _loc5_:String = (_loc4_ = XML(param1.item)).attribute(MENU_ITEM_TYPE_TAG);
         switch(_loc5_)
         {
            case MENU_ITEM_TYPE_STATE_TAG:
            case MENU_ITEM_TYPE_PROP_TAG:
            case MENU_ITEM_TYPE_HEAD_TAG:
            case MENU_ITEM_TYPE_WEAR_TAG:
               this.doChangeState(param1);
               break;
            case MENU_ITEM_TYPE_MOVEMENT_TAG:
               this.startSlideMotion();
         }
      }
      
      public function set motionShadow(param1:Prop) : void
      {
         this._motionShadowProp = param1;
         if(this._motionShadowProp != null)
         {
            this._motionShadowProp._shadowParent = this;
         }
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
         if(this.thumb != null && PropThumb(this.thumb).isCC)
         {
            this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,param1));
         }
      }
      
      override public function serialize() : String
      {
         var filepath:String = null;
         var isVideo:String = null;
         var logger:UtilErrorLogger = null;
         var xmlStr:String = "";
         try
         {
            if(PropThumb(this.thumb).getStateNum() > 0)
            {
               if(this.state == null)
               {
                  filepath = PropThumb(this.thumb).defaultState.getKey();
               }
               else
               {
                  filepath = this.state.getKey();
               }
            }
            else
            {
               filepath = this.thumb.theme.id + "." + this.thumb.id;
            }
            if(this.char != null)
            {
               if(this.char.prop != null)
               {
                  if(this.char.prop.id == this.id)
                  {
                     xmlStr = "<prop id=\"" + this.id + "\"" + (!!PropThumb(this.thumb).isCC?" isCC=\"Y\"":"") + (PropThumb(this.thumb).handStyle == ""?"":" handstyle=\"" + PropThumb(this.thumb).handStyle + "\"") + "><file>" + filepath + "</file></prop>";
                  }
               }
               if(this.char.head != null)
               {
                  if(this.char.head.id == this.id)
                  {
                     xmlStr = "<head id=\"" + this.id + "\"" + (!!PropThumb(this.thumb).isCC?" isCC=\"Y\"":"") + "><file>" + filepath + "</file></head>";
                  }
               }
               if(this.char.wear != null)
               {
                  if(this.char.wear.id == this.id)
                  {
                     xmlStr = "<wear id=\"" + this.id + "\"" + (!!PropThumb(this.thumb).isCC?" isCC=\"Y\"":"") + "><file>" + filepath + "</file></wear>";
                  }
               }
            }
            else
            {
               isVideo = PropThumb(this.thumb).subType == AnimeConstants.ASSET_TYPE_PROP_VIDEO?" subtype=\"video\"":"";
               xmlStr = "<prop id=\"" + this.id + "\" index=\"" + this.getSceneCanvas().getChildIndex(this.bundle) + "\"" + (!!PropThumb(this.thumb).isCC?" isCC=\"Y\"":"") + isVideo + ">";
               xmlStr = xmlStr + ("<file>" + filepath + "</file>" + "<x>" + this.serializeMotion("x",this.motionShadow) + "</x>" + "<y>" + this.serializeMotion("y",this.motionShadow) + "</y>" + "<xscale>" + this.serializeMotion("xscale",this.motionShadow) + "</xscale>" + "<yscale>" + this.serializeMotion("yscale",this.motionShadow) + "</yscale>" + "<face>" + this.serializeMotion("facing",this.motionShadow) + "</face>" + "<rotation>" + this.serializeMotion("rotation",this.motionShadow) + "</rotation>");
               if(defaultColorSetId != "")
               {
                  xmlStr = xmlStr + ("<dcsn>" + defaultColorSetId + "</dcsn>");
               }
               xmlStr = xmlStr + this.serializeColor();
               xmlStr = xmlStr + "</prop>";
            }
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("Prop::serialize()",e);
            trace("Error:" + e);
         }
         return xmlStr;
      }
      
      public function refreshMotionShadow() : void
      {
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = this.hasMotion();
         if(_loc1_)
         {
            this.drawMotionLine();
            if(_loc2_)
            {
               this.showMotionShadow();
            }
            else
            {
               this.addMotionShadow();
            }
         }
         else if(!_loc1_ && _loc2_)
         {
            this.removeMotionShadow();
         }
      }
      
      private function onDashlineClickHandler(param1:MouseEvent) : void
      {
         this.showMotionMenu(param1);
      }
      
      override function doDragDrop(param1:DragEvent) : void
      {
         if(this.char != null)
         {
            this.char.doDragDrop(param1);
         }
      }
      
      public function hideMotionShadow() : void
      {
         var _loc1_:Prop = this.getMotionShadow();
         if(_loc1_ != null)
         {
            _loc1_.bundle.visible = false;
         }
         this.clearMotionLine();
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
   }
}
