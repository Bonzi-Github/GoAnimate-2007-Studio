package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.command.AddPropCommand;
   import anifire.command.CcLookAtCameraCommand;
   import anifire.command.ChangeActionCommand;
   import anifire.command.FlipAssetCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveMotionCommand;
   import anifire.command.RemovePropCommand;
   import anifire.component.CustomCharacterMaker;
   import anifire.component.GoAlert;
   import anifire.components.studio.MaskPoint;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlMgr;
   import anifire.control.myBezierSpline;
   import anifire.core.sound.ProgressiveSound;
   import anifire.event.ByteLoaderEvent;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.events.AssetEvent;
   import anifire.interfaces.IDraggable;
   import anifire.interfaces.IResize;
   import anifire.interfaces.IRotatable;
   import anifire.interfaces.ISlidable;
   import anifire.managers.*;
   import anifire.tutorial.*;
   import anifire.util.*;
   import caurina.transitions.Tweener;
   import com.senocular.display.duplicateDisplayObject;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.collections.Sort;
   import mx.collections.SortField;
   import mx.collections.XMLListCollection;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.TextArea;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Character extends Asset implements ISlidable, IResize, IDraggable, IRotatable
   {
      
      private static const MENU_ITEM_TYPE_MOVEMENT_TAG:String = "movement";
      
      private static const MENU_ITEM_TYPE_COLOR_TAG:String = "color";
      
      private static const MENU_ITEM_POINT_ADD:String = "motionmenu_addpoint";
      
      private static const MENU_ITEM_ACTION:String = "actionmenu_action";
      
      private static const MENU_ITEM_POINT_REMOVE:String = "motionmenu_removepoint";
      
      private static const MENU_ITEM_FACIAL:String = "actionmenu_facial";
      
      private static const MENU_ITEM_PROP_REMOVE:String = "actionmenu_restoreprop";
      
      private static const MENU_ITEM_HEAD:String = "actionmenu_head";
      
      private static const MENU_ITEM_PROP:String = "actionmenu_handheld";
      
      private static const ADD_CONTROL_POINT:String = "addControlPoint";
      
      private static const MENU_ITEM_TYPE_STATE_TAG:String = "state";
      
      private static const MENU_ITEM_TYPE_HEAD_TAG:String = "head";
      
      private static var _logger:ILogger = Log.getLogger("core.Character");
      
      private static const MENU_ITEM_TYPE_PROP_TAG:String = "prop";
      
      private static const BLINK:String = "blink";
      
      private static const MENU_ITEM_TYPE_TAG:String = "itemType";
      
      private static const MENU_ITEM_SLIDE:String = "actionmenu_slide";
      
      private static const MENU_ITEM_MOVEMENT_REMOVE:String = "actionmenu_removeMove";
      
      private static const MENU_ITEM_TYPE_ACTION_TAG:String = "action";
      
      private static const MENU_ITEM_WEAR:String = "actionmenu_headgear";
      
      private static const REMOVE_MOTION:String = "removeMotion";
      
      private static const MENU_ITEM_TYPE_WEAR_TAG:String = "wear";
      
      private static const MENU_ITEM_DEFAULT:String = "actionmenu_default";
      
      public static const XML_NODE_NAME:String = "char";
      
      private static const SLIDE_BACKWARD:String = "slideBackward";
      
      private static const MENU_ITEM_TYPE_FACIAL_TAG:String = "facial";
      
      private static const REMOVE_CONTROL_POINT:String = "removeControlPoint";
      
      private static const SLIDE_FORWARD:String = "slideForward";
      
      private static const MENU_ITEM_MOVEMENT:String = "actionmenu_movement";
      
      private static const MENU_ITEM_HEAD_REMOVE:String = "actionmenu_restorehead";
      
      private static const MENU_ITEM_WEAR_REMOVE:String = "actionmenu_restoremask";
       
      
      private var speechHandler:Function = null;
      
      private var _readyToDrag:Boolean = false;
      
      private var _motionDirection:String = "";
      
      private var _prevCharPosX:Number = 0;
      
      private var _prevCharPosY:Number = 0;
      
      private var _prevDisplayElementPosX:Number = 0;
      
      private var _prevDisplayElementPosY:Number = 0;
      
      private var _prop:Prop;
      
      private var _demoSpeech:Boolean = false;
      
      private var _loadCount:Number = 0;
      
      private var _actionMenu:ScrollableArrowMenu;
      
      private var _wear:Prop;
      
      private var _checkedMotionItem:Object;
      
      private var _lookAtCameraSupported:Boolean = false;
      
      private var _loadTotal:Number = 0;
      
      private var _colorTrasformOld:ColorTransform;
      
      private var _currControlPointName:String;
      
      private var _controlPoints:Array;
      
      private var _insertingPoint:Number;
      
      private var _head:Prop;
      
      private var _originalRotation:Number = 0;
      
      private var _motionId:String;
      
      private var _motion:Motion;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _checkedActionItem:Object;
      
      private var _facing:String = "left";
      
      private var _orgLoaderScaleX:Number = 1;
      
      private var _orgLoaderScaleY:Number = 1;
      
      private var _spline:myBezierSpline;
      
      private var _isBlink:Boolean = false;
      
      private var _actionMenuXML:XML;
      
      private var _originalX:Number;
      
      private var _originalY:Number;
      
      private var _mouseClickPoint:Point;
      
      private var initCameraHandler:Function = null;
      
      private var _motionShadowChar:Character;
      
      private var _actionId:String;
      
      private var _action:Action;
      
      private var _fromTray:Boolean = false;
      
      private var _isSlide:Boolean = false;
      
      private var _facial:Facial;
      
      private var _byMenu:Boolean = false;
      
      private var _motionMenuXML:XML;
      
      private var _graphic:Sprite;
      
      private var _speechVoice:String;
      
      private var _byMovement:Boolean = false;
      
      private var _shadowParent:Character = null;
      
      private var _motionMenu:ScrollableArrowMenu;
      
      private var _backupSceneXML:XML;
      
      private var _knots:Array;
      
      private var _curve:UIComponent;
      
      private var _hasFacialExpression:Boolean = false;
      
      public function Character(param1:String = "")
      {
         this._spline = new myBezierSpline();
         this._graphic = new Sprite();
         this._knots = new Array();
         this._controlPoints = new Array();
         this._mouseClickPoint = new Point();
         this._curve = new UIComponent();
         super();
         _logger.debug("Character initialized");
         if(param1 == "")
         {
            param1 = "AVATOR" + this.assetCount;
         }
         this.id = this.bundle.id = param1;
         this._colorTrasformOld = this.displayElement.transform.colorTransform;
         this._insertingPoint = -1;
         this._spline.container = this._graphic;
         this._spline.thickness = 4;
         this._spline.containAsset = Asset(this);
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var themeTrees:UtilHashArray = null;
         var curBehaviourXML:XML = null;
         var charBehaviourXML:XML = null;
         var entry:ZipEntry = null;
         var themeID:String = null;
         var charID:String = null;
         var themeXml:XML = null;
         var defaultActionId:String = null;
         var fileName:String = null;
         var shouldExtractEntryToThemeTree:Boolean = false;
         var byteArray:ByteArray = null;
         var newThemeTree:ThemeTree = null;
         var decryptEngine:UtilCrypto = null;
         var assetXML:XML = param1;
         var zipFile:ZipFile = param2;
         var existingThemeTrees:UtilHashArray = param3;
         themeTrees = new UtilHashArray();
         curBehaviourXML = assetXML.child(Action.XML_NODE_NAME)[0];
         if(curBehaviourXML != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Behavior.getThemeTrees(curBehaviourXML,zipFile,existingThemeTrees,true));
            charBehaviourXML = curBehaviourXML;
         }
         curBehaviourXML = assetXML.child(Motion.XML_NODE_NAME)[0];
         if(curBehaviourXML != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Behavior.getThemeTrees(curBehaviourXML,zipFile,existingThemeTrees,true));
            charBehaviourXML = curBehaviourXML;
         }
         themeID = Behavior.getThemeIdFromBehaviourXML(charBehaviourXML);
         charID = Behavior.getCharIdFromBehaviourXML(charBehaviourXML);
         var themeTree:ThemeTree = existingThemeTrees.getValueByKey(themeID) as ThemeTree;
         if(themeTree != null)
         {
            themeXml = themeTree.getThemeXml();
         }
         if(themeXml == null)
         {
            themeXml = new XML(zipFile.getInput(zipFile.getEntry(themeID + ".xml")).toString());
            if(themeTree != null)
            {
               themeTree.addThemeXml(themeXml);
            }
         }
         var charNode:XML = themeXml["char"].(@id == charID)[0];
         defaultActionId = charNode.attribute("default");
         fileName = UtilXmlInfo.generateBehaviourFileName(themeID,charID,charID);
         entry = zipFile.getEntry(fileName);
         shouldExtractEntryToThemeTree = true;
         if(entry == null)
         {
            shouldExtractEntryToThemeTree = false;
         }
         else if(existingThemeTrees.containsKey(themeID) && (existingThemeTrees.getValueByKey(themeID) as ThemeTree).isCharBehaviourExist(charID,defaultActionId,true))
         {
            shouldExtractEntryToThemeTree = false;
         }
         if(shouldExtractEntryToThemeTree)
         {
            byteArray = zipFile.getInput(entry);
            if(themeID != "ugc")
            {
               decryptEngine = new UtilCrypto();
               decryptEngine.decrypt(byteArray);
            }
            newThemeTree = new ThemeTree(themeID);
            newThemeTree.addCharBehaviour(charID,defaultActionId,byteArray,true);
            ThemeTree.mergeThemeTreeToThemeTrees(themeTrees,newThemeTree);
         }
         if(assetXML.child(Prop.XML_NODE_NAME)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Prop.getThemeTrees(assetXML.child(Prop.XML_NODE_NAME)[0] as XML,zipFile,existingThemeTrees));
         }
         if(assetXML.child(Prop.XML_NODE_NAME_HEAD)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Prop.getThemeTrees(assetXML.child(Prop.XML_NODE_NAME_HEAD)[0] as XML,zipFile,existingThemeTrees));
         }
         if(assetXML.child(Prop.XML_NODE_NAME_WEAR)[0] != null)
         {
            ThemeTree.mergeThemeTrees(themeTrees,Prop.getThemeTrees(assetXML.child(Prop.XML_NODE_NAME_WEAR)[0] as XML,zipFile,existingThemeTrees));
         }
         return themeTrees;
      }
      
      function set fromTray(param1:Boolean) : void
      {
         this._fromTray = param1;
      }
      
      private function addProptoAll(param1:MouseEvent) : void
      {
         var _loc2_:Array = Button(param1.target).data[0] as Array;
         var _loc3_:Object = Button(param1.target).data[1] as Object;
         var _loc4_:State = Button(param1.target).data[2] as State;
         var _loc5_:String = Button(param1.target).data[3] as String;
         this.addProptoAllByPara(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      private function getMotionConstants(param1:String, param2:String, param3:int) : String
      {
         if(param1 == param2)
         {
            if(param3 == 1)
            {
               return AnimeConstants.MOTION_FORWARD;
            }
            return AnimeConstants.MOTION_BACKWARD;
         }
         if(param3 == -1)
         {
            return AnimeConstants.MOTION_FORWARD;
         }
         return AnimeConstants.MOTION_BACKWARD;
      }
      
      private function changeAction(param1:Action) : void
      {
         var _loc3_:UtilLoadMgr = null;
         var _loc4_:Array = null;
         this.dropDefaultActionProp();
         if(this._motionShadowChar)
         {
            this._motionShadowChar.dropDefaultActionProp();
         }
         var _loc2_:CharThumb = CharThumb(this.thumb);
         if(param1.imageData != null)
         {
            this.updateAction(param1);
         }
         else
         {
            _loc3_ = new UtilLoadMgr();
            (_loc4_ = new Array()).push(param1);
            _loc3_.setExtraData(_loc4_);
            _loc3_.addEventDispatcher(_loc2_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc3_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.updateActionAgain);
            _loc3_.commit();
            _loc2_.loadAction(param1);
         }
      }
      
      private function removeProp() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = null;
         if(this.prop == null)
         {
            return;
         }
         if(this.imageObject is CustomCharacterMaker && CustomCharacterMaker(this.imageObject).ver == 2)
         {
            CustomCharacterMaker(this.imageObject).removeLibrary(AnimeConstants.CLASS_GOPROP);
            CustomCharacterMaker(this.imageObject).CCM.removeStyle(AnimeConstants.CLASS_GOPROP);
            CustomCharacterMaker(this.imageObject).reloadSkin();
         }
         else
         {
            UtilPlain.stopFamily(this.prop.bundle);
            _loc1_ = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
            _loc2_ = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
            if(_loc1_ != null)
            {
               _loc3_ = UtilPlain.getProp(_loc1_);
               if(_loc3_ != null)
               {
                  UtilPlain.removeAllSon(_loc3_);
               }
            }
            if(_loc2_ != null)
            {
               _loc3_ = UtilPlain.getProp(_loc2_);
               if(_loc3_ != null)
               {
                  UtilPlain.removeAllSon(_loc3_);
               }
            }
         }
         this.prop.removeDisplayElementListener();
         this.prop = null;
      }
      
      function updateWearSize(param1:DisplayObjectContainer) : void
      {
         var propContainer:DisplayObjectContainer = param1;
         if(this.wear != null)
         {
            try
            {
               this.wear.displayElement.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEX));
               this.wear.displayElement.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function updateFacing(param1:Character = null) : void
      {
         if(this.motionShadow != null || this.isMotionShadow())
         {
            if(this.getFacingDirection(param1) == AnimeConstants.FACING_LEFT)
            {
               this.facing = AnimeConstants.FACING_LEFT;
            }
            else if(this.getFacingDirection(param1) == AnimeConstants.FACING_RIGHT)
            {
               this.facing = AnimeConstants.FACING_RIGHT;
            }
            if(this.motionShadow != null)
            {
               this.motionShadow.updateFacing(this);
            }
         }
      }
      
      private function setMotionProperties(param1:XML) : void
      {
         if(this.shouldHasMotion())
         {
            this.fillMaskPoint();
            this.setMotionFacing(param1.action.@motionface);
            this.addMotionShadow(this._xs,this._ys,this._scaleXs,this._scaleYs,this._facings,this._rotations);
            this.hideMotionShadow();
         }
      }
      
      function get fromTray() : Boolean
      {
         return this._fromTray;
      }
      
      private function refreshControl(... rest) : void
      {
         if(control != null && controlVisible)
         {
            this.control = null;
         }
      }
      
      override public function doChangeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc3_:Number = super.doChangeColor(param1,param2);
         if(_loc3_ > 0)
         {
            if(this.motionShadow != null)
            {
               this.motionShadow.doChangeColor(param1,param2);
            }
         }
         return _loc3_;
      }
      
      override protected function onCtrlPointUpHandler(param1:Event) : void
      {
         super.onCtrlPointUpHandler(param1);
         if(!this.isMotionShadow())
         {
            showButtonBar();
         }
      }
      
      function showMotionShadow() : void
      {
         var _loc1_:Character = this.getMotionShadow();
         if(_loc1_ != null)
         {
            this.hideControlPoint();
            this.showControlPoint();
            _loc1_.bundle.visible = true;
            this.scene.sendToFront(_loc1_.bundle,true);
            this.drawMotionLine();
            this.updateFacing();
         }
      }
      
      protected function getOrigin() : Point
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc1_:Point = new Point();
         var _loc2_:DisplayObject = DisplayObject(this.imageObject);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.localToGlobal(new Point());
            _loc4_ = scene.canvas.globalToLocal(_loc3_);
            _loc1_.x = _loc4_.x;
            _loc1_.y = _loc4_.y;
         }
         return _loc1_;
      }
      
      override function doDragExit(param1:DragEvent) : void
      {
         if(!this.displayElement.hitTestPoint(param1.stageX,param1.stageY,true))
         {
            if(this.displayElement != null)
            {
               this.displayElement.filters = [];
            }
         }
      }
      
      private function removeWear() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         trace("remove wear:" + this.wear);
         if(this.wear == null)
         {
            return;
         }
         UtilPlain.stopFamily(this.wear.bundle);
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
         if(_loc1_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc1_);
            if(_loc3_ != null)
            {
               if(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR))
               {
                  _loc3_.removeChild(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR));
               }
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc2_);
            if(_loc3_ != null)
            {
               if(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR))
               {
                  _loc3_.removeChild(_loc3_.getChildByName(AnimeConstants.MOVIECLIP_THE_WEAR));
               }
            }
         }
         this.wear.removeDisplayElementListener();
         this.wear = null;
      }
      
      public function updatePropState(param1:Thumb, param2:State) : void
      {
         this.addPropByThumb(param1,param2,"");
      }
      
      public function getCharMovieClip() : MovieClip
      {
         if(this.displayElement != null)
         {
            if(movieObject != null)
            {
               return Util.getCharacter(MovieClip(movieObject));
            }
         }
         return null;
      }
      
      public function get action() : Action
      {
         return this._action;
      }
      
      private function loadAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:UIComponent = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Character = null;
         var _loc7_:Boolean = false;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:XML = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:PropThumb = null;
         var _loc16_:State = null;
         var _loc17_:UtilLoadMgr = null;
         var _loc18_:Array = null;
         var _loc19_:* = false;
         var _loc20_:PropThumb = null;
         var _loc21_:Theme = null;
         var _loc22_:XML = null;
         var _loc23_:XML = null;
         var _loc24_:String = null;
         var _loc25_:State = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadAssetImageComplete);
         if(this.thumb.isCC)
         {
            this._lookAtCameraSupported = (param1.target as CustomCharacterMaker).lookAtCameraSupported;
         }
         if(this.thumb.isCC)
         {
            _loc2_ = null;
            _loc3_ = this.imageObject;
            _loc4_ = UIComponent(_loc3_.parent);
         }
         else
         {
            _loc2_ = param1.target.loader;
            _loc3_ = _loc2_.content;
            _loc4_ = UIComponent(_loc2_.parent);
         }
         if(_loc4_ != null && _loc3_ != null)
         {
            if((_loc5_ = UtilPlain.getCharacterFlip(MovieClip(_loc3_))) != null)
            {
               _loc5_.visible = false;
            }
            if(this._fromTray)
            {
               this.bundle.width = _loc3_.width;
               this.bundle.height = _loc3_.height;
               this.width = _loc4_.width;
               this.height = _loc4_.height;
               this.scaleX = 1;
               this.scaleY = 1;
               if(Console.getConsole().mainStage.isCameraMode && Console.getConsole().stageScale > 1)
               {
                  this.scaleX = 1 / Console.getConsole().stageScale;
                  this.scaleY = 1 / Console.getConsole().stageScale;
                  this.scaleX = this.scaleY = displayElement.scaleX = displayElement.scaleY = Math.max(this.scaleX,this.scaleY);
               }
            }
            else
            {
               displayElement.width = this.width;
               displayElement.height = this.height;
               displayElement.scaleX = this.scaleX;
               displayElement.scaleY = this.scaleY;
            }
            if(this.scene != null)
            {
               this.scene.doUpdateTimelineLength(-1,true);
            }
            if(!this.isLoadded)
            {
               if(capScreenLock)
               {
               }
            }
            this.isLoadded = false;
            if(this.facing == CharThumb(this.thumb).facing)
            {
               UtilPlain.flipObj(imageObject,true);
            }
            else if(this.facing != CharThumb(this.thumb).facing)
            {
               UtilPlain.flipObj(imageObject,false,true);
            }
            if((_loc6_ = !!this.scene?this.scene.getCharacterInPrevSceneById(this.id):null) != null && this._fromTray)
            {
               this.action = _loc6_.action;
               this.bundle.x = _loc6_.bundle.x;
               this.bundle.y = _loc6_.bundle.y;
               this.bundle.width = _loc6_.width;
               this.bundle.height = _loc6_.height;
               this.facing = _loc6_.facing;
               this.motionDirection = _loc6_.motionDirection;
               this.width = _loc6_.width;
               this.height = _loc6_.height;
               this.scaleX = _loc6_.scaleX;
               this.scaleY = _loc6_.scaleY;
               this.rotation = _loc6_.rotation;
               displayElement.width = this.width;
               displayElement.height = this.height;
               displayElement.scaleX = this.scaleX;
               displayElement.scaleY = this.scaleY;
               _loc8_ = CharThumb(_loc6_.thumb).motions;
               _loc9_ = 0;
               while(_loc9_ < _loc8_.length)
               {
                  if(_loc8_[_loc9_].id == this.action.id)
                  {
                     this.action = CharThumb(this.thumb).defaultAction;
                     break;
                  }
                  _loc9_++;
               }
               if(_loc6_.motionShadow != null && !this.isMotionShadow())
               {
                  this.bundle.x = _loc6_.motionShadow.bundle.x;
                  this.bundle.y = _loc6_.motionShadow.bundle.y;
                  this.bundle.width = _loc6_.motionShadow.bundle.width;
                  this.bundle.height = _loc6_.motionShadow.bundle.height;
                  this.facing = _loc6_.motionShadow.facing;
                  this.width = _loc6_.motionShadow.width;
                  this.height = _loc6_.motionShadow.height;
                  this.scaleX = _loc6_.motionShadow.scaleX;
                  this.scaleY = _loc6_.motionShadow.scaleY;
                  this.rotation = _loc6_.motionShadow.rotation;
                  displayElement.width = this.width;
                  displayElement.height = this.height;
                  displayElement.scaleX = this.scaleX;
                  displayElement.scaleY = this.scaleY;
               }
            }
            _loc7_ = false;
            if(this.action.propXML != null && (this._byMenu || this._fromTray || this._byMovement))
            {
               _loc12_ = (_loc11_ = (_loc10_ = this.action.propXML).@theme.length() > 0?_loc10_.@theme:this.thumb.theme.id) + "." + this.action.propXML.@id;
               _loc13_ = UtilXmlInfo.getThumbIdFromFileName(_loc12_);
               _loc14_ = _loc12_.split(".").length != 4?_loc13_:UtilXmlInfo.getCharIdFromFileName(_loc12_);
               if(!(_loc15_ = Console.getConsole().getTheme(_loc11_).getPropThumbById(_loc14_)))
               {
                  _loc20_ = new PropThumb();
                  _loc22_ = (_loc21_ = Console.getConsole().getTheme(_loc11_)).getThemeXML();
                  for each(_loc23_ in _loc22_.child(PropThumb.XML_NODE_NAME))
                  {
                     if(_loc23_.@aid == this.action.propXML.@aid)
                     {
                        _loc20_.deSerialize(_loc23_,_loc21_);
                        _loc20_.xml = _loc23_;
                     }
                  }
                  if(_loc13_ != _loc14_)
                  {
                     _loc20_.thumbId = _loc13_;
                  }
                  this.thumb.theme.addThumb(_loc20_);
                  _loc15_ = this.thumb.theme.getPropThumbById(_loc14_);
               }
               _loc19_ = this.prop != null;
               if(_loc15_)
               {
                  if(_loc13_ != _loc14_)
                  {
                     _loc16_ = _loc15_.getStateById(_loc13_);
                  }
                  if(_loc16_ != null)
                  {
                     if(_loc19_)
                     {
                        _loc24_ = UtilXmlInfo.getSuffixFromStateIdByThumbId(_loc15_.id,_loc16_.id);
                        if(_loc25_ = this.getAutoState(_loc15_,this.prop.thumb,_loc24_))
                        {
                           this.doAddPropByState(_loc2_,PropThumb(this.prop.thumb),_loc25_);
                           _loc7_ = true;
                        }
                     }
                     else
                     {
                        this.doAddPropByState(_loc2_,_loc15_,_loc16_);
                        _loc7_ = true;
                     }
                  }
                  else if(!_loc19_)
                  {
                     if(_loc15_.isThumbReady())
                     {
                        this.addPropByThumb(_loc15_,_loc16_);
                     }
                     else
                     {
                        _loc17_ = new UtilLoadMgr();
                        (_loc18_ = new Array()).push(_loc2_);
                        _loc18_.push(_loc15_);
                        _loc17_.setExtraData(_loc18_);
                        _loc17_.addEventDispatcher(_loc15_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                        _loc17_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedActionPropAgain);
                        _loc17_.commit();
                        this.bundle.callLater(_loc15_.loadImageData);
                     }
                     _loc7_ = true;
                  }
               }
            }
            this._byMovement = false;
            this._byMenu = false;
            this._fromTray = false;
            if(this.prop != null && !_loc7_)
            {
               this.addPropByThumb(this.prop.thumb,this.prop.state);
            }
            if(this.head != null)
            {
               this.addHeadClipToHeadContainer(this.head.displayElement,this.displayElement);
            }
            if(this.wear != null)
            {
               this.addWearClipToHeadContainer(this.wear.displayElement,this.displayElement);
            }
            this.refreshProp();
            if(!this.isMotionShadow())
            {
               UtilPlain.playFamily(DisplayObject(_loc3_));
            }
            else
            {
               UtilPlain.stopFamily(DisplayObject(_loc3_));
            }
         }
         if(_loc3_ != null)
         {
         }
         if(!this.thumb.isCC)
         {
            updateColor();
         }
         this.refreshControl();
         this.displayElement.visible = true;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      public function removeHeadGear() : void
      {
         var _loc1_:ICommand = new RemovePropCommand();
         _loc1_.execute();
         this.removeWear();
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.removeWear();
         }
         this.refreshControl();
         this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
      }
      
      public function hasTalkAction() : Boolean
      {
         return CharThumb(this.thumb).defaultTalkAction != null;
      }
      
      private function exchangeProp() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc2_:Prop = null;
         if(this.imageObject != null)
         {
            _loc1_ = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
            if(_loc1_ != null)
            {
               if(this.prop != null)
               {
                  _loc2_ = Prop(this.prop.clone());
                  this.addPropDataAndClip(_loc2_);
               }
               if(this.head != null)
               {
                  _loc2_ = Prop(this.head.clone());
                  this.addHeadDataAndClip(_loc2_);
               }
               if(this.wear != null)
               {
                  _loc2_ = Prop(this.wear.clone());
                  this.addWearDataAndClip(_loc2_);
                  _loc2_.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
               }
            }
         }
      }
      
      private function updateActionAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Action = _loc3_[0] as Action;
         this.updateAction(_loc4_);
      }
      
      private function doMotionMenuClick(param1:MenuEvent) : void
      {
         this.doChangeMotion(param1);
      }
      
      public function playCharacter() : void
      {
         var _loc1_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = movieObject;
            if(_loc1_ != null)
            {
               UtilPlain.playFamily(_loc1_);
               if(this.soundChannel != null)
               {
                  this.playMusic(this.soundPos,0,this.soundChannel.soundTransform);
               }
            }
         }
      }
      
      public function get slideEnabled() : Boolean
      {
         return true;
      }
      
      public function get isBlink() : Boolean
      {
         return this._isBlink;
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
      
      public function hasTalkFacial() : Boolean
      {
         var _loc1_:PropThumb = this.thumb.theme.getPropThumbById(this.thumb.id + ".head");
         if(_loc1_ != null)
         {
            return _loc1_.defaultTalkState != null;
         }
         return false;
      }
      
      private function getShadowIndex(param1:AnimeScene) : int
      {
         return param1.background == null?0:1;
      }
      
      private function getFacingConstants(param1:String, param2:int) : String
      {
         if(param1 == AnimeConstants.FACING_LEFT)
         {
            return param2 == 1?AnimeConstants.FACING_LEFT:AnimeConstants.FACING_RIGHT;
         }
         return param2 == 1?AnimeConstants.FACING_RIGHT:AnimeConstants.FACING_LEFT;
      }
      
      public function startDragging() : void
      {
         var _loc1_:Image = null;
         this.hideControl();
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetFacing = this.facing;
         this._readyToDrag = true;
         _loc1_ = Image(this.bundle);
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
      
      public function get motionDirection() : String
      {
         return this._motionDirection;
      }
      
      public function toggleLookAtCamera() : void
      {
         var _loc1_:Boolean = this.lookAtCamera;
         this.lookAtCamera = !this.lookAtCamera;
         var _loc2_:ICommand = new CcLookAtCameraCommand(id,_loc1_);
         _loc2_.execute();
      }
      
      public function set action(param1:Action) : void
      {
         trace("set action");
         if(this._action != param1)
         {
            this.addTalkHeadForSpeech();
            this._action = param1;
            this.actionId = param1.id;
            this.imageData = param1.imageData;
         }
      }
      
      private function updateAction(param1:Action) : void
      {
         this.action = param1;
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.action = param1;
         }
         this.hideControl();
         this.playCharacter();
         this.dispatchEvent(new AssetEvent(AssetEvent.ACTION_CHANGE));
      }
      
      private function addHeadClipToHeadContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getHead(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getHead(_loc4_);
            }
            if(_loc5_ != null)
            {
               _loc5_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 0;
               _loc5_.addChildAt(param1,0);
               this.updateHeadSize(_loc5_);
            }
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getTail(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getTail(_loc4_);
            }
            if(_loc5_ != null)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc5_.numChildren)
               {
                  if(_loc5_.getChildAt(_loc6_).name == AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc5_.getChildAt(_loc6_).alpha = 0;
                  }
                  _loc6_++;
               }
            }
         }
      }
      
      public function get motionShadow() : Character
      {
         return this._motionShadowChar;
      }
      
      function addPropDataAndClip(param1:Prop) : void
      {
         if(this.prop != null)
         {
            this.prop.stopMusic(true);
            this.removeProp();
         }
         this.prop = param1;
         this.addPropClipToPropContainer(this.prop.displayElement,this.displayElement);
      }
      
      public function shouldHasMotion() : Boolean
      {
         if(Math.max(this._xs.length,this._ys.length,this._scaleXs.length,this._scaleYs.length,this._rotations.length) > 1)
         {
            return true;
         }
         return false;
      }
      
      public function resizing(param1:Control) : void
      {
         this.bundle.graphics.clear();
         var _loc2_:Object = param1.getStuff(this._prevDisplayElementPosX,this._prevDisplayElementPosY);
         var _loc3_:int = this.facing == this.defaultFacing?1:-1;
         displayElement.scaleX = _loc2_.scaleX * this._orgLoaderScaleX;
         displayElement.scaleY = _loc2_.scaleY * this._orgLoaderScaleY;
      }
      
      private function addWearClipToHeadContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getHead(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getHead(_loc4_);
            }
            if(_loc5_ != null)
            {
               param1.name = AnimeConstants.MOVIECLIP_THE_WEAR;
               _loc5_.addChild(param1);
               this.updateWearSize(_loc5_);
               this.refreshProp();
            }
         }
      }
      
      override public function flipIt() : void
      {
         var _loc1_:ICommand = null;
         var _loc2_:String = this.facing;
         this.facing = this.facing == AnimeConstants.FACING_LEFT?AnimeConstants.FACING_RIGHT:AnimeConstants.FACING_LEFT;
         if(this.motionShadow != null)
         {
            this.motionShadow.facing = this.motionShadow.facing == AnimeConstants.FACING_LEFT?AnimeConstants.FACING_RIGHT:AnimeConstants.FACING_LEFT;
            this.motionDirection = this.motionDirection == AnimeConstants.MOTION_BACKWARD?AnimeConstants.MOTION_FORWARD:AnimeConstants.MOTION_BACKWARD;
         }
         this.refreshControl();
         _loc1_ = new FlipAssetCommand(id,_loc2_);
         _loc1_.execute();
      }
      
      private function addMotionMenuListener() : void
      {
         this._curve.addEventListener(MouseEvent.MOUSE_OVER,this.onDashlineOverHandler);
         this._curve.addEventListener(MouseEvent.MOUSE_OUT,this.onDashlineOutHandler);
      }
      
      private function removeHead() : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         if(this.head == null)
         {
            return;
         }
         UtilPlain.stopFamily(this.head.bundle);
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
         if(_loc1_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc1_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
            _loc3_ = UtilPlain.getTail(_loc1_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
         }
         if(_loc2_ != null)
         {
            _loc3_ = UtilPlain.getHead(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_HEAD && _loc4_.name != AnimeConstants.MOVIECLIP_THE_WEAR)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
            _loc3_ = UtilPlain.getTail(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).alpha = 1;
               _loc3_.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_TAIL).visible = true;
               _loc5_ = _loc3_.numChildren - 1;
               while(_loc5_ >= 0)
               {
                  if((_loc4_ = _loc3_.getChildAt(_loc5_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc3_.removeChildAt(_loc5_);
                  }
                  _loc5_--;
               }
            }
         }
         this.head.removeDisplayElementListener();
         this.head = null;
         if(this.wear != null)
         {
            this.refreshProp();
         }
      }
      
      private function getHeadPropThumb() : PropThumb
      {
         var _loc1_:* = this.thumb.id + ".head";
         return this.thumb.theme.getPropThumbById(_loc1_);
      }
      
      private function getFacingDirection(param1:Character = null) : String
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:int = Console.getConsole().getSceneIndex(scene);
         var _loc3_:Number = this.x;
         if(this.motionShadow != null)
         {
            _loc4_ = this.motionShadow.x;
            if(this._knots.length != 0)
            {
               _loc4_ = this._spline.getX(0.01);
            }
            if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
            {
               if(_loc3_ < _loc4_)
               {
                  return AnimeConstants.FACING_RIGHT;
               }
               if(_loc3_ > _loc4_)
               {
                  return AnimeConstants.FACING_LEFT;
               }
               return AnimeConstants.FACING_UNKNOW;
            }
            if(_loc4_ < _loc3_)
            {
               return AnimeConstants.FACING_RIGHT;
            }
            if(_loc4_ > _loc3_)
            {
               return AnimeConstants.FACING_LEFT;
            }
            return AnimeConstants.FACING_UNKNOW;
         }
         if(this.isMotionShadow() && param1 != null)
         {
            _loc5_ = param1.x;
            if(param1.knots.length != 0)
            {
               _loc5_ = param1.spline.getX(0.99);
            }
            if(param1.motionDirection == AnimeConstants.MOTION_FORWARD)
            {
               return _loc3_ < _loc5_?AnimeConstants.FACING_LEFT:AnimeConstants.FACING_RIGHT;
            }
            return _loc5_ < _loc3_?AnimeConstants.FACING_LEFT:AnimeConstants.FACING_RIGHT;
         }
         return AnimeConstants.FACING_UNKNOW;
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
         this.displayElement.removeEventListener(DragEvent.DRAG_COMPLETE,this.doDragComplete);
         this.displayElement.removeEventListener(DragEvent.DRAG_ENTER,this.doDragEnter);
         this.displayElement.removeEventListener(DragEvent.DRAG_DROP,this.doDragDrop);
         this.displayElement.removeEventListener(DragEvent.DRAG_EXIT,this.doDragExit);
      }
      
      private function updateTimelineMotion() : void
      {
         scene.doUpdateTimelineLength(-1,true);
      }
      
      private function deleteMaskPoint(param1:MouseEvent) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         _loc2_ = DisplayObject(param1.currentTarget);
         scene.dashline.removeChild(_loc2_);
         _loc3_ = -1;
         _loc4_ = 0;
         while(_loc4_ < this._knots.length)
         {
            if(this._knots[_loc4_] == _loc2_)
            {
               _loc3_ = _loc4_;
            }
            _loc4_++;
         }
         this._knots.splice(_loc3_,1);
         this.drawMotionLine(param1);
      }
      
      private function prepareAddProp(param1:PropThumb, param2:State = null, param3:String = "") : void
      {
         var _loc4_:Array = null;
         var _loc5_:UtilLoadMgr = new UtilLoadMgr();
         (_loc4_ = new Array()).push(null);
         _loc4_.push(param1);
         _loc4_.push(param2);
         _loc4_.push(param3);
         _loc5_.setExtraData(_loc4_);
         if(param1.states.length == 0)
         {
            if(PropThumb(param1).isThumbReady())
            {
               this.doCheckBeforeAddProp(param1,null,param3);
            }
            else
            {
               _loc5_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
               _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.prepareAddPropAgain);
               _loc5_.commit();
               param1.loadImageData();
            }
         }
         else
         {
            if(param2 == null)
            {
               param2 = PropThumb(param1).defaultState;
            }
            if(PropThumb(param1).isStateReady(param2))
            {
               this.doCheckBeforeAddProp(param1,param2,param3);
            }
            else
            {
               _loc5_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
               _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.prepareAddPropAgain);
               _loc5_.commit();
               param1.loadState(param2);
            }
         }
      }
      
      public function get demoSpeech() : Boolean
      {
         return this._demoSpeech;
      }
      
      public function get isSlide() : Boolean
      {
         return this._isSlide;
      }
      
      private function feedActionPropAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:PropThumb = _loc3_[1] as PropThumb;
         var _loc6_:State = _loc3_[2] as State;
         this.addPropByThumb(_loc5_,_loc6_);
      }
      
      public function set isBlink(param1:Boolean) : void
      {
         this._isBlink = param1;
      }
      
      override public function unloadAssetImage(param1:Boolean) : void
      {
         super.unloadAssetImage(param1);
         if(this.prop)
         {
            this.prop.unloadAssetImage(param1);
         }
         if(this.head)
         {
            this.head.unloadAssetImage(param1);
         }
         if(this.wear)
         {
            this.wear.unloadAssetImage(param1);
         }
      }
      
      private function setMotionFacing(param1:int) : void
      {
         var _loc2_:String = this.facing;
         var _loc3_:int = _loc2_ == this.defaultFacing?1:-1;
         if(_loc3_ != param1)
         {
            this.motionDirection = AnimeConstants.MOTION_BACKWARD;
         }
         else
         {
            this.motionDirection = AnimeConstants.MOTION_FORWARD;
         }
      }
      
      public function get actionMenu() : ScrollableArrowMenu
      {
         var node:XML = null;
         var xmlMenu:XML = null;
         var actionNode:XML = null;
         var motionNode:XML = null;
         var groupNode:XML = null;
         var menuNode:XML = null;
         var menuParentNode:XML = null;
         var menuParentNode2:XML = null;
         var label:String = null;
         var id:String = null;
         var toggled:String = null;
         var type:String = null;
         var itemType:String = null;
         var useLowerCase:Boolean = false;
         var menu:ScrollableArrowMenu = null;
         var xmlChar:XML = CharThumb(this.thumb).xml;
         var xmlc:XMLListCollection = new XMLListCollection(xmlChar.children());
         var nameSort:Sort = new Sort();
         nameSort.fields = [new SortField("@name",true)];
         xmlc.sort = nameSort;
         xmlc.refresh();
         xmlChar.setChildren(xmlc.copy());
         for each(node in xmlChar.category)
         {
            xmlc = new XMLListCollection(node.children());
            xmlc.sort = nameSort;
            xmlc.refresh();
            node.setChildren(xmlc.copy());
         }
         xmlMenu = <menu></menu>;
         actionNode = new XML();
         motionNode = new XML();
         groupNode = new XML();
         menuNode = new XML();
         menuParentNode = new XML();
         menuParentNode2 = new XML();
         useLowerCase = UtilLicense.isActionNameNeedLowerCase();
         if(xmlChar.motion.(@enable != "N").length() > 0)
         {
            menuParentNode = <item label="{UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT)}"></item>;
            for each(node in xmlChar.motion)
            {
               if(node.@enable != "N")
               {
                  label = node.@name;
                  label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                  label = !!useLowerCase?label.toLocaleLowerCase():label;
                  id = node.@id;
                  toggled = id == this.action.id?"true":"false";
                  itemType = "motion";
                  menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                  menuParentNode.appendChild(menuNode);
               }
            }
            xmlMenu.appendChild(menuParentNode);
         }
         for each(node in xmlChar.category)
         {
            if(node..action.(@enable != "N").length() > 0 || node..motion.(@enable != "N").length() > 0)
            {
               menuParentNode = <item label="{UtilString.firstLetterToUpperCase(UtilDict.toDisplay("go",node.@name))}"></item>;
               xmlMenu.appendChild(menuParentNode);
               for each(actionNode in node.action)
               {
                  if(actionNode.@enable != "N")
                  {
                     label = actionNode.@name;
                     label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                     label = !!useLowerCase?label.toLocaleLowerCase():label;
                     id = actionNode.@id;
                     toggled = id == this.action.id?"true":"false";
                     itemType = "action";
                     menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                     menuParentNode.appendChild(menuNode);
                  }
               }
               for each(groupNode in node.group)
               {
                  itemType = XML(groupNode.children()[0]).name().toString();
                  if(itemType == "action" && groupNode.action.(@enable != "N").length() > 0)
                  {
                     label = groupNode.@name;
                     label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                     label = !!useLowerCase?label.toLocaleLowerCase():label;
                     id = groupNode.children().(@name == "1").@id;
                     toggled = "false";
                     for each(actionNode in groupNode.children())
                     {
                        if(actionNode.@id == this.action.id)
                        {
                           toggled = "true";
                        }
                     }
                     menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                     menuParentNode.appendChild(menuNode);
                  }
               }
               xmlc = new XMLListCollection(menuParentNode.children());
               nameSort.fields = [new SortField("@label",true)];
               xmlc.sort = nameSort;
               xmlc.refresh();
               menuParentNode.setChildren(xmlc.copy());
               if(node..motion.(@enable != "N").length() > 0)
               {
                  menuParentNode2 = <item label="{UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT)}"></item>;
                  menuParentNode.prependChild(menuParentNode2);
                  for each(motionNode in node.motion)
                  {
                     if(motionNode.@enable == "Y")
                     {
                        label = motionNode.@name;
                        label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                        label = !!useLowerCase?label.toLocaleLowerCase():label;
                        id = motionNode.@id;
                        toggled = id == this.action.id?"true":"false";
                        itemType = "motion";
                        menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                        menuParentNode2.appendChild(menuNode);
                     }
                  }
                  for each(groupNode in node.group)
                  {
                     itemType = XML(groupNode.children()[0]).name().toString();
                     if(itemType == "motion" && groupNode.motion.(@enable != "N").length() > 0)
                     {
                        label = groupNode.@name;
                        label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
                        label = !!useLowerCase?label.toLocaleLowerCase():label;
                        id = groupNode.children().(@name == "1").@id;
                        toggled = "false";
                        for each(actionNode in groupNode.children())
                        {
                           if(actionNode.@id == this.action.id)
                           {
                              toggled = "true";
                           }
                        }
                        menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
                        menuParentNode2.appendChild(menuNode);
                     }
                  }
                  xmlc = new XMLListCollection(menuParentNode2.children());
                  nameSort.fields = [new SortField("@label",true)];
                  xmlc.sort = nameSort;
                  xmlc.refresh();
                  menuParentNode2.setChildren(xmlc.copy());
               }
            }
         }
         if(FeatureManager.shouldActionPackBeShown && CharThumb(this.thumb).ccThemeId == "cc2" && !Console.getConsole().isTutorialOn)
         {
            xmlMenu.appendChild(<item label="{"+ " + UtilString.firstLetterToUpperCase(UtilDict.toDisplay("go","Learn New Actions"))}" itemType='learn'></item>);
         }
         if(xmlMenu.children().length() > 0)
         {
            xmlMenu.appendChild(<item type='separator'></item>);
         }
         for each(node in xmlChar.action)
         {
            if(node.@enable != "N")
            {
               label = node.@name;
               label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
               label = !!useLowerCase?label.toLocaleLowerCase():label;
               id = node.@id;
               toggled = id == this.action.id?"true":"false";
               itemType = "action";
               menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
               xmlMenu.appendChild(menuNode);
            }
         }
         for each(node in xmlChar.group)
         {
            itemType = XML(node.children()[0]).name().toString();
            if(itemType == "action" && node.action.(@enable != "N").length() > 0)
            {
               label = node.@name;
               label = UtilString.firstLetterToUpperCase(UtilDict.toDisplay("store",label));
               label = !!useLowerCase?label.toLocaleLowerCase():label;
               id = node.children().(@name == "1").@id;
               toggled = "false";
               for each(actionNode in node.children())
               {
                  if(actionNode.@id == this.action.id)
                  {
                     toggled = "true";
                  }
               }
               itemType = XML(node.children()[0]).name().toString();
               menuNode = <item label="{label}" id="{id}" toggled="{toggled}" itemType="{itemType}" type='check'></item>;
               xmlMenu.appendChild(menuNode);
            }
         }
         menu = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),xmlMenu,false);
         menu.labelField = "@label";
         menu.addEventListener(MenuEvent.ITEM_CLICK,this.onActionMenuClick);
         menu.verticalScrollPolicy = ScrollPolicy.OFF;
         menu.arrowScrollPolicy = ScrollPolicy.AUTO;
         menu.maxHeight = 300;
         menu.minWidth = 200;
         menu.showRoot = false;
         return menu;
      }
      
      public function serializeMotion(param1:String, param2:Character) : Array
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
                  _loc3_.push(this.motionShadow.facing == this.defaultFacing?1:-1);
                  break;
               case "rotation":
                  _loc3_.push(Util.roundNum(param2.rotation));
            }
         }
         return _loc3_;
      }
      
      override function doDragComplete(param1:DragEvent) : void
      {
         this._readyToDrag = false;
         var _loc2_:Image = Image(param1.dragInitiator);
         _loc2_.alpha = 1;
         if(this == this.scene.selectedAsset)
         {
         }
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         if(Console.getConsole().currDragObject is Prop && param1.buttonDown)
         {
            if(this.displayElement != null)
            {
               this.displayElement.filters = [];
            }
         }
         else
         {
            super.onRollOut(param1);
         }
      }
      
      override public function set control(param1:Control) : void
      {
         super.control = param1;
      }
      
      public function isMotionShadow() : Boolean
      {
         if(this.bundle.name.substr(0,12) == "motionShadow")
         {
            return true;
         }
         return false;
      }
      
      private function changeHeadByState(param1:State) : void
      {
         var doAddFacialAgain:Function = null;
         var extraData:Object = null;
         var loadMgr:UtilLoadMgr = null;
         var state:State = param1;
         var propThumb:PropThumb = this.getHeadPropThumb();
         if(state.imageData != null)
         {
            this.addPropByThumb(propThumb,state);
         }
         else
         {
            doAddFacialAgain = function(param1:LoadMgrEvent):void
            {
               var _loc3_:Thumb = null;
               var _loc4_:State = null;
               var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
               var _loc5_:Object;
               _loc3_ = (_loc5_ = _loc2_.getExtraData())["thumb"];
               _loc4_ = _loc5_["state"];
               addPropByThumb(_loc3_,_loc4_);
            };
            extraData = new Object();
            extraData["thumb"] = propThumb;
            extraData["state"] = state;
            loadMgr = new UtilLoadMgr();
            loadMgr.setExtraData(extraData);
            loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,doAddFacialAgain);
            loadMgr.addEventDispatcher(propThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            propThumb.loadState(state);
            loadMgr.commit();
         }
      }
      
      private function prepareAddPropAgain(param1:LoadMgrEvent) : void
      {
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Loader = _loc3_[0] as Loader;
         var _loc5_:PropThumb = _loc3_[1] as PropThumb;
         var _loc6_:State = _loc3_[2] as State;
         var _loc7_:String = _loc3_[3] as String;
         this.prepareAddProp(_loc5_,_loc6_,_loc7_);
      }
      
      public function reloadAssetImage() : void
      {
         this.loadAssetImage();
         if(this.head)
         {
            this.head.reloadAssetImage();
         }
      }
      
      public function set prop(param1:Prop) : void
      {
         if(this._prop)
         {
            this._prop.clearDisplayElement();
         }
         this._prop = param1;
      }
      
      private function onDashlineClickHandler(param1:MouseEvent) : void
      {
         this.showMotionMenu(param1);
      }
      
      public function dropDefaultActionProp() : void
      {
         var _loc1_:XML = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:PropThumb = null;
         if(this.action != null)
         {
            if(this.action.propXML != null)
            {
               _loc1_ = this.action.propXML;
               _loc2_ = _loc1_.@theme.length() > 0?_loc1_.@theme:this.thumb.theme.id;
               _loc3_ = _loc2_ + "." + this.action.propXML.@id;
               _loc4_ = UtilXmlInfo.getThumbIdFromFileName(_loc3_);
               _loc5_ = _loc3_.split(".").length != 4?_loc4_:UtilXmlInfo.getCharIdFromFileName(_loc3_);
               _loc6_ = Console.getConsole().getTheme(_loc2_).getPropThumbById(_loc5_);
               if(this.prop != null && _loc6_ == this.prop.thumb)
               {
                  if(this.prop.stateId == null || _loc4_ == this.prop.stateId)
                  {
                     this.removeProp();
                  }
               }
               else if(this.head != null && _loc6_ == this.head.thumb)
               {
                  if(this.head.stateId == null || _loc4_ == this.head.stateId)
                  {
                     this.removeHead();
                  }
               }
               else if(this.wear != null && _loc6_ == this.wear.thumb)
               {
                  if(this.wear.stateId == null || _loc4_ == this.wear.stateId)
                  {
                     this.removeWear();
                  }
               }
            }
         }
      }
      
      public function set motionDirection(param1:String) : void
      {
         this._motionDirection = param1;
      }
      
      private function onStageMouseMoveHandler(param1:MouseEvent) : void
      {
         param1.updateAfterEvent();
         if(this.motionShadow != null || this.isMotionShadow())
         {
            if(param1.buttonDown && this == Console.getConsole().currentScene.selectedAsset)
            {
               if(!param1.ctrlKey)
               {
                  this.updateFacing();
               }
               this.refreshMotionShadow();
            }
         }
      }
      
      public function hideMotionShadow() : void
      {
         var _loc1_:Character = this.getMotionShadow();
         if(_loc1_ != null)
         {
            this.hideControlPoint();
            _loc1_.hideControl();
            _loc1_.bundle.visible = false;
         }
         this.clearMotionLine();
      }
      
      private function startRemoveMotion() : void
      {
         var _loc1_:TextArea = motionDistTip;
         _loc1_.visible = false;
         scene.dashline.graphics.clear();
         if(scene.dashline.contains(this._curve))
         {
            scene.dashline.removeChild(this._curve);
         }
         var _loc2_:Number = scene.dashline.numChildren;
         var _loc3_:int = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            if(scene.dashline.getChildAt(_loc3_) is MaskPoint && this._knots.indexOf(scene.dashline.getChildAt(_loc3_)) > -1)
            {
               scene.dashline.removeChildAt(_loc3_);
            }
            _loc3_--;
         }
         this._knots.splice(0,this._knots.length);
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
      
      private function getCharToBundleBounds() : Rectangle
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Rectangle = null;
         if(movieObject != null)
         {
            _loc1_ = Util.getCharacter(MovieClip(movieObject));
            return _loc1_.getBounds(this.bundle);
         }
         return new Rectangle();
      }
      
      private function addProptoOne(param1:MouseEvent) : void
      {
         var _loc2_:Object = Button(param1.target).data[0] as Object;
         var _loc3_:State = Button(param1.target).data[1] as State;
         var _loc4_:String = Button(param1.target).data[2] as String;
         this.addPropByThumb(_loc2_,_loc3_,_loc4_);
      }
      
      public function set speechVoice(param1:String) : void
      {
         this._speechVoice = param1;
      }
      
      public function set motionId(param1:String) : void
      {
         this._motionId = param1;
      }
      
      function addWearDataAndClip(param1:Prop) : void
      {
         if(this.wear != null)
         {
            this.wear.stopMusic(true);
            this.removeWear();
         }
         this.wear = param1;
         this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
         this.addWearClipToHeadContainer(this.wear.displayElement,this.displayElement);
      }
      
      private function refreshProp(... rest) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:DisplayObject = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR);
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(this.displayElement,UtilPlain.THE_CHAR_FLIP);
         if(this.head)
         {
            if(_loc2_ != null && UtilPlain.getHead(_loc2_) != null)
            {
               if(_loc3_ != null && UtilPlain.isObjectFlipped(Loader(this.imageObject)))
               {
                  _loc4_ = UtilPlain.getTail(_loc3_);
                  _loc5_ = UtilPlain.getTail(UtilPlain.getHead(_loc3_));
               }
               else
               {
                  _loc4_ = UtilPlain.getTail(_loc2_);
                  _loc5_ = UtilPlain.getTail(UtilPlain.getHead(_loc2_));
               }
               if(_loc5_ != null && _loc4_ != null)
               {
                  if(_loc5_ == _loc4_)
                  {
                     _loc5_.visible = false;
                  }
                  else
                  {
                     _loc5_.visible = true;
                     _loc6_ = duplicateDisplayObject(DisplayObject(_loc5_));
                     this.addTailClipToTailContainer(_loc6_,this.displayElement);
                  }
               }
            }
         }
         if(this.wear != null)
         {
            if(_loc2_ != null)
            {
               if(_loc3_ != null && UtilPlain.isObjectFlipped(Loader(this.imageObject)))
               {
                  _loc4_ = UtilPlain.getHead(_loc3_);
               }
               else
               {
                  _loc4_ = UtilPlain.getHead(_loc2_);
               }
               if(_loc4_ != null)
               {
                  this.updateWearPosition(_loc4_);
               }
            }
         }
         updateColor();
         this.refreshControl();
      }
      
      override public function serialize() : String
      {
         var canvas:Canvas = null;
         var motionFacing:int = 0;
         var _xml:XML = null;
         var i:int = 0;
         var logger:UtilErrorLogger = null;
         var xmlStr:String = "";
         try
         {
            canvas = getSceneCanvas();
            motionFacing = this.getMotionFacing();
            xmlStr = "<char id=\"" + this.id + "\" index=\"" + canvas.getChildIndex(this.bundle) + "\"" + (!!CharThumb(this.thumb).isCC?" isCC=\"Y\"":"") + ">";
            xmlStr = xmlStr + ("<action face=\"" + this.serializeMotion("facing",this.motionShadow) + "\" motionface=\"" + motionFacing + "\" >" + this.action.getKey() + "</action>" + (this.prop == null?"":this.prop.serialize()) + (this.head == null?"":this.head.serialize()) + (this.wear == null?"":this.wear.serialize()) + "<x>" + this.serializeMotion("x",this.motionShadow) + "</x>" + "<y>" + this.serializeMotion("y",this.motionShadow) + "</y>" + "<xscale>" + this.serializeMotion("xscale",this.motionShadow) + "</xscale>" + "<yscale>" + this.serializeMotion("yscale",this.motionShadow) + "</yscale>" + "<rotation>" + this.serializeMotion("rotation",this.motionShadow) + "</rotation>");
            if(defaultColorSetId != "")
            {
               xmlStr = xmlStr + ("<dcsn>" + defaultColorSetId + "</dcsn>");
            }
            if(customColor.length > 0)
            {
               i = 0;
               while(i < customColor.length)
               {
                  xmlStr = xmlStr + ("<color r=\"" + customColor.getKey(i) + "\"");
                  xmlStr = xmlStr + (SelectedColor(customColor.getValueByIndex(i)).orgColor == uint.MAX_VALUE?"":" oc=\"0x" + SelectedColor(customColor.getValueByIndex(i)).orgColor.toString(16) + "\"");
                  xmlStr = xmlStr + ">";
                  xmlStr = xmlStr + SelectedColor(customColor.getValueByIndex(i)).dstColor;
                  xmlStr = xmlStr + "</color>";
                  i++;
               }
            }
            xmlStr = xmlStr + "</char>";
            _xml = new XML(xmlStr);
            if(this.lookAtCamera)
            {
               _xml.@faceCamera = "true";
               xmlStr = _xml.toString();
            }
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("Character::serialize()",e);
            trace("Serialize " + this.id + " failed: " + e);
         }
         return xmlStr;
      }
      
      private function doCheckBeforeAddProp(param1:Object, param2:State = null, param3:String = "") : void
      {
         var _loc6_:AnimeScene = null;
         var _loc7_:int = 0;
         var _loc8_:Character = null;
         var _loc9_:GoAlert = null;
         var _loc4_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < Console.getConsole().scenes.length)
         {
            _loc6_ = Console.getConsole().getScene(_loc5_);
            _loc7_ = 0;
            while(_loc7_ < _loc6_.characters.length)
            {
               if((_loc8_ = Character(_loc6_.characters.getValueByIndex(_loc7_))).thumb.id == this.thumb.id)
               {
                  if(_loc8_.customColor.isIdentical(this.customColor))
                  {
                     _loc4_.push(_loc8_);
                  }
               }
               _loc7_++;
            }
            _loc5_++;
         }
         if(Console.getConsole().studioType == Console.FULL_STUDIO || Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            if(_loc4_.length > 1)
            {
               if(this.displayElement != null)
               {
                  this.displayElement.filters = [];
               }
               (_loc9_ = GoAlert(PopUpManager.createPopUp(getSceneCanvas(),GoAlert,true)))._lblConfirm.text = "";
               _loc9_._txtDelete.text = UtilDict.toDisplay("go","goalert_foundsamechar");
               _loc9_._btnDelete.label = UtilDict.toDisplay("go","goalert_addtoall");
               _loc9_._btnDelete.data = new Array(_loc4_,param1,param2,param3);
               _loc9_._btnDelete.addEventListener(MouseEvent.CLICK,this.addProptoAll);
               _loc9_._btnCancel.label = UtilDict.toDisplay("go","goalert_thisoneonly");
               _loc9_._btnCancel.data = new Array(param1,param2,param3);
               _loc9_._btnCancel.addEventListener(MouseEvent.CLICK,this.addProptoOne);
               _loc9_.x = (_loc9_.stage.width - _loc9_.width) / 2;
               _loc9_.y = 100;
            }
            else
            {
               this.addPropByThumb(param1,param2,param3);
            }
         }
         else
         {
            this.addProptoAllByPara(_loc4_,param1,param2,param3);
         }
      }
      
      public function get knots() : Array
      {
         return this._knots;
      }
      
      public function set motionShadow(param1:Character) : void
      {
         this._motionShadowChar = param1;
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar._shadowParent = this;
         }
      }
      
      public function restoreColorById(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            CustomCharacterMaker(this.imageObject).CCM.deleteColor(param1[_loc2_]);
            _loc2_++;
         }
         CustomCharacterMaker(this.imageObject).reloadSkin();
      }
      
      public function removeHandHeld() : void
      {
         var _loc1_:ICommand = null;
         if(this.prop)
         {
            _loc1_ = new RemovePropCommand();
            _loc1_.execute();
            this.removeProp();
            if(this._motionShadowChar != null)
            {
               this._motionShadowChar.removeProp();
            }
            this.refreshControl();
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
      }
      
      public function hasMotion() : Boolean
      {
         if(this.motionShadow == null)
         {
            return false;
         }
         return true;
      }
      
      function getMotionShadow() : Character
      {
         if(this.motionShadow != null)
         {
            return this.motionShadow;
         }
         return null;
      }
      
      public function onVariationClick(param1:String) : void
      {
         this._byMenu = true;
         this.setAction(param1);
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
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
      
      public function isInDefaultTalkAction() : Boolean
      {
         return this.action == CharThumb(this.thumb).defaultTalkAction;
      }
      
      public function set wear(param1:Prop) : void
      {
         if(this._wear)
         {
            this._wear.clearDisplayElement();
         }
         this._wear = param1;
      }
      
      public function set motionData(param1:MotionData) : void
      {
         this.motionDirection = AnimeConstants.MOTION_FORWARD;
         this._knots.splice(0,this._knots.length);
         this.motionShadow = null;
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         this.refreshMotionShadow();
         this.motionShadow.x = this.x + param1.displacement.x;
         this.motionShadow.y = this.y + param1.displacement.y;
         this.refreshMotionShadow();
         this.updateFacing();
         this.hideControl();
      }
      
      public function isInDefaultTalkFacial() : Boolean
      {
         var _loc1_:PropThumb = null;
         if(this.head != null)
         {
            _loc1_ = this.thumb.theme.getPropThumbById(this.thumb.id + ".head");
            if(_loc1_)
            {
               return this.head.state == _loc1_.defaultTalkState;
            }
         }
         return false;
      }
      
      public function startSlideMotion() : void
      {
         if(!this.isSliding)
         {
            this.isSlide = true;
            if(this.motionDirection == "")
            {
               this.motionDirection = AnimeConstants.MOTION_FORWARD;
            }
            if(this.motionShadow == null)
            {
               this._originalX = getSceneCanvas().mouseX;
               this._originalY = getSceneCanvas().mouseY;
               _originalAssetX = this.x;
               _originalAssetY = this.y;
               this.refreshMotionShadow();
               this.snapAsset(this.motionShadow);
               this.refreshMotionShadow();
            }
            this.updateFacing();
         }
      }
      
      public function loadActionAndMotion(param1:CoreEvent) : void
      {
         this.motion = (this.thumb as CharThumb).defaultMotion;
         if(this._fromTray)
         {
            this.action = CharThumb(this.thumb).defaultAction;
         }
         else
         {
            this.action = CharThumb(this.thumb).getActionById(this.actionId);
         }
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
      
      private function onDashlineOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:GlowFilter = new GlowFilter(16737792,1,5,5,150,1,true);
         var _loc3_:Array = new Array();
         _loc3_.push(_loc2_);
         _loc2_ = new GlowFilter(0,1,3,3,250);
         _loc3_.push(_loc2_);
         this._curve.filters = _loc3_;
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
      
      public function removeMotionShadow() : void
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
               this.motionDirection = "";
            }
            catch(e:Error)
            {
               trace("error:" + e);
            }
         }
      }
      
      override public function melt() : void
      {
         super.melt();
         this.displayElement.addEventListener(DragEvent.DRAG_COMPLETE,this.doDragComplete);
         this.displayElement.addEventListener(DragEvent.DRAG_ENTER,this.doDragEnter);
         this.displayElement.addEventListener(DragEvent.DRAG_DROP,this.doDragDrop);
         this.displayElement.addEventListener(DragEvent.DRAG_EXIT,this.doDragExit);
      }
      
      private function onMaskPointDown(param1:MouseEvent) : void
      {
         var _loc2_:MaskPoint = null;
         _loc2_ = MaskPoint(param1.currentTarget);
         _loc2_.oPos = new Point(_loc2_.x,_loc2_.y);
         _loc2_.doDrag(param1);
      }
      
      private function addTalkHeadForSpeech() : void
      {
         var _loc1_:PropThumb = null;
         if(this.head == null)
         {
            if(Console.getConsole().linkageController.getSpeechIdOfAsset(this) != "")
            {
               if(this.action != null && this.action.isTalkRelated())
               {
                  _loc1_ = this.getHeadPropThumb();
                  if(_loc1_ != null && _loc1_.defaultTalkState != null)
                  {
                     this.doAddPropByState(null,_loc1_,_loc1_.defaultTalkState);
                  }
               }
            }
         }
      }
      
      private function updateWearPosition(param1:DisplayObjectContainer) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(param1,"theTop");
         if(_loc2_ != null)
         {
            _loc3_ = 0;
            if(param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).alpha != 0)
            {
               _loc3_ = param1.getChildByName(AnimeConstants.MOVIECLIP_DEFAULT_HEAD).getBounds(param1).y;
            }
            else if(this.head != null && this.head.imageObject != null)
            {
               _loc3_ = this.head.imageObject.getBounds(param1).y;
            }
            _loc2_.y = _loc3_;
         }
      }
      
      public function setAction(param1:String, param2:Boolean = false) : void
      {
         hideButtonBar();
         var _loc3_:CharThumb = CharThumb(this.thumb);
         var _loc4_:Action;
         if((_loc4_ = _loc3_.getActionById(param1)) && this.imageData != null && this.imageData != _loc4_.imageData)
         {
            this._byMovement = param2;
            this.changeAction(_loc4_);
            this.control = null;
         }
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
         UtilPlain.removeAllSon(this._curve);
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
         if(param1 != null)
         {
            this.updateFacing();
         }
      }
      
      override function onMouseUp(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:State = null;
         var _loc4_:int = 0;
         var _loc5_:UtilHashArray = null;
         var _loc6_:ICommand = null;
         super.onMouseUp(param1);
         if(Console.getConsole().currDragObject is Prop)
         {
            _loc2_ = Console.getConsole().currDragObject.thumb;
            if(!(PropThumb(_loc2_).headable && this.thumb.isCC))
            {
               if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable || PropThumb(_loc2_).headable || PropThumb(_loc2_).wearable))
               {
                  if(!this.isMotionShadow())
                  {
                     (_loc6_ = new AddPropCommand()).execute();
                  }
                  if(PropThumb(_loc2_).getStateNum() > 0)
                  {
                     _loc3_ = Prop(Console.getConsole().currDragObject).state;
                  }
                  _loc5_ = Prop(Console.getConsole().currDragObject).customColor;
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.length)
                  {
                     addCustomColor(_loc5_.getKey(_loc4_),_loc5_.getValueByIndex(_loc4_));
                     _loc4_++;
                  }
                  this.autoStateModify(_loc2_ as PropThumb,_loc3_);
                  Console.getConsole().currDragObject.deleteAsset(false);
                  Console.getConsole().currDragObject = null;
                  this.scene.selectedAsset = null;
               }
            }
         }
      }
      
      private function buildMotionMenu(param1:Boolean = false) : ScrollableArrowMenu
      {
         var _loc2_:ScrollableArrowMenu = null;
         var _loc3_:CharThumb = CharThumb(this.thumb);
         var _loc4_:Array = _loc3_.motions;
         var _loc5_:* = "<menuRoot>";
         if(param1)
         {
            _loc5_ = _loc5_ + ("<menu label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_POINT_REMOVE)) + "\" id=\"" + REMOVE_CONTROL_POINT + "\" type=\"check\" toggled=\"false\"/>");
         }
         else
         {
            _loc5_ = _loc5_ + ("<menu label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_POINT_ADD)) + "\" id=\"" + ADD_CONTROL_POINT + "\" type=\"check\" toggled=\"false\"/>");
         }
         _loc5_ = (_loc5_ = _loc5_ + ("<menuItem label=\"" + UtilXmlInfo.xmlEscape(UtilDict.toDisplay("go",MENU_ITEM_MOVEMENT_REMOVE)) + "\" id=\"" + REMOVE_MOTION + "\" type=\"check\" toggled=\"false\"/>")) + "</menuRoot>";
         this._motionMenuXML = new XML(_loc5_);
         _loc2_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),this._motionMenuXML,false);
         _loc2_.labelField = "@label";
         _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doMotionMenuClick);
         _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc2_.maxHeight = this.getSceneCanvas().height;
         return _loc2_;
      }
      
      public function stopCharacter() : void
      {
         var _loc1_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = movieObject;
            if(_loc1_ != null)
            {
               UtilPlain.stopFamily(_loc1_);
               this.stopMusic(false);
            }
         }
      }
      
      public function getDataAndKey() : UtilHashArray
      {
         var _loc3_:UtilHashArray = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc1_:UtilHashArray = new UtilHashArray();
         _loc1_.push(this.thumb.theme.id + ".char." + this.thumb.id + "." + this.action.id,this.action.imageData,true);
         var _loc2_:int = 0;
         while(_loc2_ < CharThumb(this.thumb).getLibraryNum())
         {
            _loc5_ = CharThumb(this.thumb).getLibraryIdByIndex(_loc2_);
            _loc1_.push(_loc5_,CharThumb(this.thumb).getLibraryById(_loc5_));
            _loc2_++;
         }
         if(this.prop != null)
         {
            if(PropThumb(this.prop.thumb).getStateNum() == 0)
            {
               _loc1_.push(this.prop.thumb.theme.id + ".prop." + this.prop.thumb.id,this.prop.thumb.imageData,true);
            }
            else
            {
               _loc3_ = this.prop.getDataAndKey();
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc1_.push(_loc3_.getKey(_loc4_),_loc3_.getValueByIndex(_loc4_),true);
                  _loc4_++;
               }
            }
         }
         if(this.head != null)
         {
            if(PropThumb(this.head.thumb).getStateNum() == 0)
            {
               _loc1_.push(this.head.thumb.theme.id + ".prop." + this.head.thumb.id,this.head.thumb.imageData,true);
            }
            else
            {
               _loc3_ = this.head.getDataAndKey();
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc1_.push(_loc3_.getKey(_loc4_),_loc3_.getValueByIndex(_loc4_),true);
                  _loc4_++;
               }
            }
         }
         if(this.wear != null)
         {
            if(PropThumb(this.wear.thumb).getStateNum() == 0)
            {
               _loc1_.push(this.wear.thumb.theme.id + ".prop." + this.wear.thumb.id,this.wear.thumb.imageData,true);
            }
            else
            {
               _loc3_ = this.wear.getDataAndKey();
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc1_.push(_loc3_.getKey(_loc4_),_loc3_.getValueByIndex(_loc4_),true);
                  _loc4_++;
               }
            }
            _loc1_.push(this.wear.thumb.theme.id + ".prop." + this.wear.thumb.id,this.wear.thumb.imageData,true);
         }
         return _loc1_;
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc6_:Image = null;
         var _loc2_:CharThumb = this.thumb as CharThumb;
         var _loc3_:Point = new Point(getSceneCanvas().mouseX,getSceneCanvas().mouseY);
         var _loc4_:Point = new Point(this._originalX,this._originalY);
         var _loc5_:Boolean = true;
         if(this == this.scene.selectedAsset)
         {
            if(_loc3_.equals(_loc4_))
            {
               if(this.isCharacterThumbsReady() && !this.isMotionShadow() && this.bundle.hitTestPoint(param1.stageX,param1.stageY,true))
               {
                  _loc5_ = false;
               }
            }
            this._readyToDrag = false;
         }
         else
         {
            _loc5_ = false;
         }
         if(Image(param1.currentTarget.parent) != null)
         {
            (_loc6_ = Image(param1.currentTarget.parent)).stopDrag();
         }
         if(Console.getConsole().currDragObject != null)
         {
            (_loc6_ = Console.getConsole().currDragObject.bundle as Image).stopDrag();
            Console.getConsole().currDragObject = null;
            if(this.motionShadow != null && !this.isRegardAsMoved(new Point(this.bundle.x,this.bundle.y),new Point(this.motionShadow.x,this.motionShadow.y)) && !this.isRegardAsMoved(new Point(this.scaleX * 100,this.scaleY * 100),new Point(this.motionShadow.scaleX * 100,this.motionShadow.scaleY * 100)))
            {
               this.removeSlideMotion();
            }
         }
         if(!param1.ctrlKey && this.isRegardAsMoved(_loc4_,_loc3_))
         {
            this.updateFacing();
         }
         if(control != null && controlVisible)
         {
         }
         if(Console.getConsole().isTutorialOn)
         {
         }
         if(this.motionShadow != null)
         {
            if(this.motionShadow.control != null && this.motionShadow.controlVisible)
            {
               this.motionShadow.control = null;
               this.motionShadow.showControl();
            }
         }
         if(_loc5_)
         {
            changed = true;
         }
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().thumbTrayActive = true;
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
         if(this.imageObject is CustomCharacterMaker)
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
      }
      
      private function snapAsset(param1:Asset) : void
      {
         var _loc2_:int = this.facing == AnimeConstants.FACING_LEFT?75:-75;
         param1.x = param1.x + -_loc2_;
         if(param1.x < 0)
         {
            param1.x = 0;
         }
      }
      
      public function set isSlide(param1:Boolean) : void
      {
         this._isSlide = param1;
      }
      
      private function removeMotion() : void
      {
         this.removeMotionShadow();
         this.changed = true;
      }
      
      public function rotate(param1:Control) : void
      {
         var _loc2_:Number = getSceneCanvas().mouseX - this.bundle.x;
         var _loc3_:Number = getSceneCanvas().mouseY - this.bundle.y;
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
         var newProp:Prop = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedHeadSoundHandler:Function = null;
         var onAddedWearSoundHandler:Function = null;
         var addSceneFlag:Boolean = param1;
         var targetScene:AnimeScene = param2;
         var char:Character = new Character();
         char.id = char.bundle.id = this.id;
         char.scene = !!targetScene?targetScene:this.scene;
         char.thumb = this.thumb;
         if(this.motionShadow == null)
         {
            char.x = this.x;
            char.y = this.y;
            char.width = this.width;
            char.height = this.height;
            char.facing = this.facing;
            char.bundle.width = this.bundle.width;
            char.bundle.height = this.bundle.height;
            char.scaleX = this.scaleX;
            char.scaleY = this.scaleY;
            char.displayElement.scaleX = this.displayElement.scaleX;
            char.displayElement.scaleY = this.displayElement.scaleY;
            char.rotation = this.rotation;
         }
         char.customColor = this.customColor.clone();
         char.defaultColorSet = this.defaultColorSet.clone();
         if(this.motionShadow != null && !this.isMotionShadow())
         {
            char.x = this.motionShadow.x;
            char.y = this.motionShadow.y;
            char.facing = this.motionShadow.facing;
            char.scaleX = this.motionShadow.scaleX;
            char.scaleY = this.motionShadow.scaleY;
            char.rotation = this.motionShadow.rotation;
         }
         char.actionId = this.actionId;
         char.action = this.action;
         char.motion = this.motion;
         char.lookAtCamera = this.lookAtCamera;
         if(this.prop != null)
         {
            newProp = new Prop();
            if(addSceneFlag)
            {
               onAddedPropSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedPropSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedPropSoundHandler);
            }
            newProp.init(PropThumb(this.prop.thumb),char);
            newProp.state = this.prop.state;
            newProp.capScreenLock = this.capScreenLock;
            char.addPropDataAndClip(newProp);
         }
         else
         {
            char.prop = null;
         }
         char._loadCount = 0;
         if(this.head != null)
         {
            newProp = new Prop();
            if(addSceneFlag)
            {
               onAddedHeadSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedHeadSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedHeadSoundHandler);
            }
            newProp.init(PropThumb(this.head.thumb),char);
            newProp.state = this.head.state;
            newProp.capScreenLock = this.capScreenLock;
            ++char._loadTotal;
            char.addHeadDataAndClip(newProp);
            newProp.lookAtCamera = this.lookAtCamera;
            newProp.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,char.refreshProp);
         }
         else
         {
            char.head = null;
         }
         if(this.wear != null)
         {
            newProp = new Prop();
            if(addSceneFlag)
            {
               onAddedWearSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedWearSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedWearSoundHandler);
            }
            newProp.init(PropThumb(this.wear.thumb),char);
            newProp.state = this.wear.state;
            newProp.capScreenLock = this.capScreenLock;
            ++char._loadTotal;
            char.addWearDataAndClip(newProp);
            newProp.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,char.refreshProp);
         }
         else
         {
            char.wear = null;
         }
         char.speechVoice = this.speechVoice;
         return char;
      }
      
      public function get prop() : Prop
      {
         return this._prop;
      }
      
      private function changeHeadByStateId(param1:String) : void
      {
         var _loc3_:State = null;
         var _loc2_:PropThumb = this.getHeadPropThumb();
         if(_loc2_.getStateNum() > 0)
         {
            _loc3_ = _loc2_.getStateById(param1);
         }
         this.changeHeadByState(_loc3_);
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true) : void
      {
         var _loc10_:int = 0;
         var _loc13_:String = null;
         var _loc14_:AnimeSound = null;
         var _loc15_:XML = null;
         var _loc16_:int = 0;
         var _loc17_:String = null;
         var _loc18_:SelectedColor = null;
         var _loc19_:XML = null;
         var _loc20_:Prop = null;
         var _loc21_:XML = null;
         var _loc22_:XML = null;
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBehaviour(param1.action,true);
         var _loc5_:RegExp = /zip/gi;
         _loc4_ = _loc4_.replace(_loc5_,"xml");
         var _loc6_:String = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
         var _loc7_:String = UtilXmlInfo.getCharIdFromFileName(_loc4_);
         var _loc8_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc9_:CharThumb;
         if((_loc9_ = Console.getConsole().getTheme(_loc8_).getCharThumbById(_loc7_)) != null)
         {
            this.scene = param2;
            this.thumb = _loc9_;
            this.actionId = _loc6_;
            this._xs = String(param1.x).split(",");
            this._ys = String(param1.y).split(",");
            this._scaleXs = String(param1.xscale).split(",");
            this._scaleYs = String(param1.yscale).split(",");
            this._rotations = String(param1.rotation).split(",");
            this._facings = String(param1.action.@face).split(",");
            this.lookAtCamera = String(param1.@faceCamera) == "true";
            _loc13_ = Console.getConsole().linkageController.getSpeechIdByScene(this.scene);
            if((_loc14_ = Console.getConsole().speechManager.getValueByKey(_loc13_)) is ProgressiveSound)
            {
               _loc17_ = Console.getConsole().linkageController.getCharIdOfSpeech(_loc13_);
               this.demoSpeech = AssetLinkage.getCharIdFromLinkage(_loc17_) == this.id?true:false;
            }
            this.x = this._xs[0];
            this.y = this._ys[0];
            this.scaleX = this._scaleXs[0];
            this.scaleY = this._scaleYs[0];
            this.rotation = this._rotations[0];
            this.facing = this.getFacingConstants(_loc9_.facing,this._facings[0]);
            displayElement.width = this.width;
            displayElement.height = this.height;
            displayElement.scaleX = this.scaleX;
            displayElement.scaleY = this.scaleY;
            if(param3)
            {
               this.action = _loc9_.getActionById(_loc6_);
            }
            else
            {
               this._action = _loc9_.getActionById(_loc6_);
            }
            if(param1.dcsn.length() > 0)
            {
               this.defaultColorSetId = String(param1.dcsn);
               this.defaultColorSet = this.thumb.getColorSetById(this.defaultColorSetId);
            }
            customColor = new UtilHashArray();
            _loc16_ = 0;
            while(_loc16_ < param1.child("color").length())
            {
               _loc15_ = param1.child("color")[_loc16_];
               _loc18_ = new SelectedColor(_loc15_.@r,_loc15_.attribute("oc").length() == 0?uint(uint.MAX_VALUE):uint(_loc15_.@oc),uint(_loc15_));
               this.addCustomColor(_loc15_.@r,_loc18_);
               _loc16_++;
            }
            if(this.action != null && this.action.imageData != null)
            {
               this.isLoadded = true;
               _loc19_ = new XML();
               _loc20_ = new Prop();
               _loc10_ = 0;
               while(_loc10_ < param1.prop.length())
               {
                  _loc19_ = param1.prop[_loc10_];
                  (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
                  _loc20_.deSerialize(_loc19_,this);
                  this.addPropDataAndClip(_loc20_);
                  this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
                  _loc10_++;
               }
            }
         }
         _loc10_ = 0;
         while(_loc10_ < param1.prop.length())
         {
            _loc19_ = param1.prop[_loc10_];
            (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
            _loc20_.deSerialize(_loc19_,this);
            this.addPropDataAndClip(_loc20_);
            this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc10_++;
         }
         var _loc11_:int = 0;
         while(_loc11_ < param1.head.length())
         {
            _loc21_ = param1.head[_loc11_];
            (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
            _loc20_.lookAtCamera = this._lookAtCamera;
            _loc20_.deSerialize(_loc21_,this);
            this.addHeadDataAndClip(_loc20_);
            this.head.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            this.head.demoSpeech = this.demoSpeech;
            _loc11_++;
         }
         var _loc12_:int = 0;
         while(_loc12_ < param1.wear.length())
         {
            _loc22_ = param1.wear[_loc12_];
            (_loc20_ = new Prop()).capScreenLock = this.capScreenLock;
            _loc20_.deSerialize(_loc22_,this);
            this.addWearDataAndClip(_loc20_);
            this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            _loc12_++;
         }
         this.bundle.callLater(this.setMotionProperties,[param1]);
      }
      
      public function set motion(param1:Motion) : void
      {
         this._motion = param1;
         if(this._motion == null)
         {
            this.motionId = "";
         }
         else
         {
            this.motionId = this._motion.id;
         }
      }
      
      public function get headMenu() : ScrollableArrowMenu
      {
         var _loc1_:* = "<menuRoot>";
         if(this.head != null && this.head.thumb.id != this.thumb.id + ".head")
         {
            _loc1_ = this.head.buildStateMenu(_loc1_,false);
         }
         _loc1_ = _loc1_ + "</menuRoot>";
         var _loc2_:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),new XML(_loc1_),false);
         _loc2_.labelField = "@label";
         _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc2_.minWidth = 150;
         _loc2_.maxHeight = 300;
         _loc2_.showRoot = false;
         return _loc2_;
      }
      
      public function endResize() : void
      {
         this.scaleX = displayElement.scaleX;
         this.scaleY = displayElement.scaleY;
         this._originalRotation = this.bundle.rotation;
         this.changed = true;
      }
      
      public function get speechVoice() : String
      {
         return this._speechVoice;
      }
      
      public function get motionId() : String
      {
         return this._motionId;
      }
      
      private function getAutoState(param1:Thumb, param2:Thumb, param3:String) : State
      {
         var _loc4_:State = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         if(UtilArray.hasMatchingElement(PropThumb(param1).sysTags,PropThumb(param2).sysTags))
         {
            _loc5_ = 0;
            while(_loc5_ < PropThumb(param2).states.length)
            {
               if((_loc6_ = UtilXmlInfo.getSuffixFromStateIdByThumbId(param2.id,State(PropThumb(param2).states[_loc5_]).id)) == param3)
               {
                  _loc4_ = State(PropThumb(param2).states[_loc5_]);
                  break;
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
      
      private function addControlPoint(param1:Point) : void
      {
         var _loc2_:MaskPoint = null;
         _loc2_ = new MaskPoint();
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
      
      public function get lookAtCameraSupported() : Boolean
      {
         return this._lookAtCameraSupported;
      }
      
      private function onLoadThumbForCcComplete(param1:Event) : void
      {
         CustomCharacterMaker(this.imageObject).insertColor(this.customColor);
         CustomCharacterMaker(this.imageObject).addLibrary(AnimeConstants.CLASS_GOPROP,"","");
         CustomCharacterMaker(this.imageObject).reloadSkin();
      }
      
      private function addProptoAllByPara(param1:Array, param2:Object, param3:State, param4:String) : void
      {
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            Character(param1[_loc5_]).addPropByThumb(param2,param3,param4);
            _loc5_++;
         }
      }
      
      private function get defaultFacing() : String
      {
         return CharThumb(this.thumb).facing;
      }
      
      private function autoStateModify(param1:PropThumb, param2:State = null, param3:String = "") : void
      {
         var _loc6_:State = null;
         var _loc7_:String = null;
         var _loc4_:PropThumb = param1;
         var _loc5_:State = param2;
         if(this.prop != null && PropThumb(this.prop.thumb).states.length > 0 && PropThumb(param1).states.length > 0)
         {
            _loc7_ = UtilXmlInfo.getSuffixFromStateIdByThumbId(this.prop.thumb.id,this.prop.state.id);
            if(this.prop.state != null && this.prop.state.id != "")
            {
               _loc6_ = this.getAutoState(this.prop.thumb,param1,_loc7_);
            }
         }
         this.prepareAddProp(_loc4_,!!_loc6_?_loc6_:_loc5_,param3);
      }
      
      public function get wear() : Prop
      {
         return this._wear;
      }
      
      private function onDashlineOutHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:GlowFilter = new GlowFilter(0,1,3,3,250);
         var _loc3_:Array = new Array();
         _loc3_.push(_loc2_);
         this._curve.filters = _loc3_;
      }
      
      private function addPropByThumb(param1:Object, param2:State, param3:String = "") : void
      {
         var newProp:Prop = null;
         var i:int = 0;
         var customColor:UtilHashArray = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedHeadSoundHandler:Function = null;
         var onAddedWearSoundHandler:Function = null;
         var thumb:Object = param1;
         var state:State = param2;
         var colorSetId:String = param3;
         trace("addPropByThumb:" + [thumb,state]);
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.addPropByThumb(thumb,state,colorSetId);
         }
         newProp = new Prop();
         if(thumb is PropThumb)
         {
            if(PropThumb(thumb).holdable == true)
            {
               if(this.imageObject is CustomCharacterMaker && CustomCharacterMaker(this.imageObject).ver == 2)
               {
                  if(PropThumb(thumb).handStyle != "")
                  {
                     newProp.init(PropThumb(thumb),this);
                     this.prop = newProp;
                     if(state != null)
                     {
                        newProp.state = state;
                     }
                     else if(PropThumb(thumb).states.length > 0)
                     {
                        newProp.state = PropThumb(thumb).defaultState;
                     }
                     CustomCharacterMaker(this.imageObject).CCM.addEventListener(ByteLoaderEvent.LOAD_BYTES_COMPLETE,this.onLoadThumbForCcComplete);
                     CustomCharacterMaker(this.imageObject).CCM.loadPropThumbAsStyle(newProp.state == null?newProp.imageData:newProp.state.imageData,PropThumb(thumb).handStyle);
                  }
               }
               else
               {
                  onAddedPropSoundHandler = function(param1:Event):void
                  {
                     if(Console.getConsole().soundMute == false)
                     {
                        newProp.playMusic();
                     }
                     newProp.removeEventListener("SoundAdded",onAddedPropSoundHandler);
                  };
                  newProp.addEventListener("SoundAdded",onAddedPropSoundHandler);
                  newProp.init(PropThumb(thumb),this);
                  if(state != null)
                  {
                     newProp.state = state;
                  }
                  else if(PropThumb(thumb).states.length > 0)
                  {
                     newProp.state = PropThumb(thumb).defaultState;
                  }
                  if(colorSetId != "")
                  {
                     newProp.defaultColorSetId = colorSetId;
                     newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                     customColor = newProp.defaultColorSet;
                     i = 0;
                     while(i < customColor.length)
                     {
                        addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                        i++;
                     }
                  }
                  this.addPropDataAndClip(newProp);
                  this.prop.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
               }
            }
            else if(PropThumb(thumb).headable == true)
            {
               newProp = new Prop();
               onAddedHeadSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedHeadSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedHeadSoundHandler);
               newProp.init(PropThumb(thumb),this);
               newProp.lookAtCamera = this.lookAtCamera;
               if(state != null)
               {
                  newProp.state = state;
               }
               else if(PropThumb(thumb).states.length > 0)
               {
                  newProp.state = PropThumb(thumb).defaultState;
               }
               if(colorSetId != "")
               {
                  newProp.defaultColorSetId = colorSetId;
                  newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                  customColor = newProp.defaultColorSet;
                  i = 0;
                  while(i < customColor.length)
                  {
                     addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                     i++;
                  }
               }
               trace("addPropByThumb add head:" + [newProp,newProp.state]);
               this.addHeadDataAndClip(newProp);
               this.head.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            }
            else if(PropThumb(thumb).wearable == true)
            {
               newProp = new Prop();
               onAddedWearSoundHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     newProp.playMusic();
                  }
                  newProp.removeEventListener("SoundAdded",onAddedWearSoundHandler);
               };
               newProp.addEventListener("SoundAdded",onAddedWearSoundHandler);
               newProp.init(PropThumb(thumb),this);
               if(state != null)
               {
                  newProp.state = state;
               }
               else if(PropThumb(thumb).states.length > 0)
               {
                  newProp.state = PropThumb(thumb).defaultState;
               }
               if(colorSetId != "")
               {
                  newProp.defaultColorSetId = colorSetId;
                  newProp.defaultColorSet = PropThumb(thumb).getColorSetById(colorSetId);
                  customColor = newProp.defaultColorSet;
                  i = 0;
                  while(i < customColor.length)
                  {
                     addCustomColor(customColor.getKey(i),customColor.getValueByIndex(i));
                     i++;
                  }
               }
               this.addWearDataAndClip(newProp);
               this.wear.addEventListener(CoreEvent.LOAD_ASSET_COMPLETE,this.refreshProp);
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.ACTION_CHANGE));
         }
      }
      
      override public function addControl() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:Rectangle = null;
         var _loc3_:Boolean = false;
         var _loc4_:Control = null;
         if(movieObject != null)
         {
            UtilPlain.gotoAndStopFamilyAt1(movieObject);
            this.stopMusic(false,true);
            _loc1_ = Util.getCharacter(MovieClip(movieObject));
            if(_loc1_)
            {
               _loc2_ = _loc1_.getBounds(this.bundle);
               _loc3_ = false;
               if(_loc3_)
               {
                  _loc2_.width = _loc2_.height = 100;
               }
               if(this.isMotionShadow())
               {
                  _loc4_ = ControlMgr.getControl(movieObject,ControlMgr.SHADOW);
               }
               else
               {
                  _loc4_ = ControlMgr.getControl(movieObject,ControlMgr.NORMAL);
               }
               _loc4_.target = this;
               _loc4_.asset = movieObject;
               _loc4_.minHeight = 3;
               _loc4_.minWidth = 3;
               _loc4_.rotatable = true;
               _loc4_.setPos(_loc2_.x,_loc2_.y);
               _loc4_.setSize(_loc2_.width,_loc2_.height);
               _loc4_.setOrigin(-_loc2_.x,-_loc2_.y);
               _loc4_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
               _loc4_.addEventListener("CtrlPointUp",this.onCtrlPointUpHandler);
               _loc4_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
               this._prevCharPosX = _loc2_.x;
               this._prevCharPosY = _loc2_.y;
               this._orgLoaderScaleX = Math.abs(displayElement.scaleX);
               this._orgLoaderScaleY = Math.abs(displayElement.scaleY);
               _loc4_.hideControl();
               this.control = _loc4_;
            }
         }
         this.dispatchEvent(new Event("ControlRdy"));
      }
      
      private function loadProxyImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.target.loader;
         _loc2_.scaleX = getSceneCanvas().parent.scaleX;
         _loc2_.scaleY = getSceneCanvas().parent.scaleY;
         var _loc3_:Image = Image(_loc2_.parent);
         _loc2_.content.width = this.width;
         _loc2_.content.height = this.height;
         var _loc4_:Rectangle = _loc2_.getBounds(this.bundle);
         _loc2_.x = _loc2_.x - _loc4_.x * _loc2_.scaleX;
         _loc2_.y = _loc2_.y - _loc4_.y * _loc2_.scaleY;
         if(this.prop != null)
         {
            this.addPropClipToPropContainer(this.prop.movieObject,_loc2_);
         }
      }
      
      override public function restoreColor() : void
      {
         super.restoreColor();
         if(this.prop)
         {
            this.prop.restoreColor();
         }
         if(this.wear)
         {
            this.wear.restoreColor();
         }
         if(this.head)
         {
            this.head.restoreColor();
         }
      }
      
      public function get headGearMenu() : ScrollableArrowMenu
      {
         var _loc1_:* = null;
         var _loc2_:ScrollableArrowMenu = null;
         if(this.wear)
         {
            _loc1_ = "";
            _loc1_ = this.wear.buildStateMenu(_loc1_,false);
            if(_loc1_)
            {
               _loc1_ = "<menuRoot>" + _loc1_ + "</menuRoot>";
               _loc2_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),new XML(_loc1_),false);
               _loc2_.labelField = "@label";
               _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
               _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
               _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
               _loc2_.minWidth = 150;
               _loc2_.maxHeight = 300;
               _loc2_.showRoot = false;
            }
            return _loc2_;
         }
         return null;
      }
      
      private function deleteMaskPointByName(param1:String) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         _loc2_ = scene.dashline.getChildByName(param1);
         scene.dashline.removeChild(_loc2_);
         _loc3_ = -1;
         _loc4_ = 0;
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
         this.updateFacing();
      }
      
      private function addTailClipToTailContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:int = 0;
         var _loc7_:DisplayObject = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getTail(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getTail(_loc4_);
            }
            if(_loc5_ != null)
            {
               _loc6_ = _loc5_.numChildren - 1;
               while(_loc6_ >= 0)
               {
                  if((_loc7_ = _loc5_.getChildAt(_loc6_)).name != AnimeConstants.MOVIECLIP_DEFAULT_TAIL)
                  {
                     _loc5_.removeChildAt(_loc6_);
                  }
                  _loc6_--;
               }
               _loc5_.addChild(param1);
               this.updateHeadSize(_loc5_);
            }
         }
      }
      
      override public function changeColor(param1:String, param2:uint = 4.294967295E9) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:SelectedColor = null;
         _loc3_ = super.changeColor(param1,param2);
         if(this.thumb.isCC)
         {
            _loc4_ = uint.MAX_VALUE;
            _loc5_ = new SelectedColor(param1,_loc4_,param2);
            CustomCharacterMaker(this.imageObject).CCM.addColor(param1,_loc5_);
         }
         return _loc3_;
      }
      
      public function restoreHead() : void
      {
         var _loc1_:ICommand = new RemovePropCommand();
         _loc1_.execute();
         this.removeHead();
         if(this._motionShadowChar != null)
         {
            this._motionShadowChar.removeHead();
         }
         this.refreshControl();
         this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
      }
      
      private function doAddPropByState(param1:Loader, param2:PropThumb, param3:State) : void
      {
         var _loc4_:Array = null;
         var _loc5_:UtilLoadMgr = null;
         if(param2.isStateReady(param3))
         {
            this.addPropByThumb(param2,param3);
         }
         else
         {
            _loc5_ = new UtilLoadMgr();
            (_loc4_ = new Array()).push(param1);
            _loc4_.push(param2);
            _loc4_.push(param3);
            _loc5_.setExtraData(_loc4_);
            _loc5_.addEventDispatcher(param2.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc5_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.feedActionPropAgain);
            _loc5_.commit();
            this.bundle.callLater(param2.loadState,[param3]);
         }
      }
      
      public function changeActionAsTalk() : Boolean
      {
         var _loc2_:PropThumb = null;
         var _loc1_:Boolean = false;
         if(this.action == CharThumb(this.thumb).defaultAction && this.hasTalkAction())
         {
            this.changeAction(CharThumb(this.thumb).defaultTalkAction);
            _loc1_ = true;
         }
         else if(this.head == null && this.hasTalkFacial())
         {
            _loc2_ = this.thumb.theme.getPropThumbById(this.thumb.id + ".head");
            this.changeHeadByState(_loc2_.defaultTalkState);
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function getMotionFacing() : int
      {
         var _loc1_:String = this.getFacingDirection();
         var _loc2_:int = _loc1_ == this.defaultFacing?1:-1;
         if(this.motionDirection == AnimeConstants.MOTION_FORWARD)
         {
            return _loc2_;
         }
         return _loc2_ * -1;
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(!this.isMotionShadow() && this.control != null)
         {
            this.showMotionShadow();
            this.addMotionMenuListener();
            showButtonBar();
         }
         if(this.motionShadow != null)
         {
            this.motionShadow.showControl();
         }
         this.stopCharacter();
      }
      
      public function get isSliding() : Boolean
      {
         return this.motionShadow != null;
      }
      
      private function removeMotionMenuListener() : void
      {
         this._curve.removeEventListener(MouseEvent.MOUSE_OVER,this.onDashlineOverHandler);
         this._curve.removeEventListener(MouseEvent.MOUSE_OUT,this.onDashlineOutHandler);
      }
      
      private function isCharacterThumbsReady() : Boolean
      {
         var _loc1_:CharThumb = this.thumb as CharThumb;
         if(!_loc1_.isThumbReady(this.actionId))
         {
            return false;
         }
         return true;
      }
      
      public function removeSlideMotion() : void
      {
         if(this.isSliding)
         {
            this.startRemoveMotion();
            this.updateTimelineMotion();
            if(this.isSlide)
            {
            }
            this.isSlide = false;
         }
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         var _loc2_:CharThumb = param1 as CharThumb;
         super.thumb = _loc2_;
         if(this._fromTray)
         {
            this.action = _loc2_.defaultAction;
            this.motion = _loc2_.defaultMotion;
         }
         else
         {
            this.action = _loc2_.getActionById(this.actionId);
            this.motion = _loc2_.getMotionById(this.motionId);
         }
      }
      
      public function set facing(param1:String) : void
      {
         var displayElement:DisplayObject = null;
         var loader:DisplayObject = null;
         var facing:String = param1;
         var doFlip:Boolean = false;
         var newface:Number = 0;
         if(facing != this.facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
         {
            try
            {
               displayElement = bundle.getChildAt(0) as DisplayObject;
               loader = DisplayObject(this.imageObject);
               if(loader != null)
               {
                  newface = UtilPlain.flipObj(loader);
                  doFlip = true;
                  if(displayElement != null)
                  {
                     scaleX = displayElement.scaleX;
                     scaleY = displayElement.scaleY;
                  }
               }
               if(newface < 0)
               {
                  this._facing = this.defaultFacing == AnimeConstants.FACING_LEFT?AnimeConstants.FACING_RIGHT:AnimeConstants.FACING_LEFT;
               }
               else
               {
                  this._facing = this.defaultFacing;
               }
            }
            catch(e:Error)
            {
               trace("E:" + e);
            }
         }
         if(newface == 0)
         {
            this._facing = facing;
         }
         if(doFlip)
         {
            this.exchangeProp();
         }
      }
      
      public function addMotionShadow(param1:Array = null, param2:Array = null, param3:Array = null, param4:Array = null, param5:Array = null, param6:Array = null) : void
      {
         var _loc7_:int = 0;
         var _loc8_:AnimeScene = null;
         var _loc9_:Character = null;
         if(!this.isMotionShadow())
         {
            _loc7_ = Console.getConsole().getSceneIndex(scene);
            _loc8_ = Console.getConsole().getScene(_loc7_);
            if(this.motionShadow == null || !_loc8_.canvas.contains(this.motionShadow.bundle))
            {
               _loc9_ = Character(this.clone());
               if(!(param1 == null && param2 == null && param3 == null && param4 == null && param5 == null && param6 == null))
               {
                  _loc9_.x = param1[param1.length - 1];
                  _loc9_.y = param2[param2.length - 1];
                  _loc9_.rotation = param6[param6.length - 1];
                  _loc9_.facing = this.getFacingConstants(CharThumb(this.thumb).facing,param5[param5.length - 1]);
                  _loc9_.scaleX = param3[param3.length - 1];
                  _loc9_.scaleY = param4[param4.length - 1];
                  _loc9_.displayElement.scaleX = param3[param3.length - 1];
                  _loc9_.displayElement.scaleY = param4[param4.length - 1];
               }
               this.motionShadow = Character(_loc9_.clone());
               this.motionShadow.fromTray = false;
               this.motionShadow.bundle.alpha = 0.7;
               this.motionShadow.bundle.name = this.motionShadow.id = "motionShadow_" + id;
               this.motionShadow.bundle.buttonMode = true;
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_DOWN,this.onShadowMouseDown);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
               this.motionShadow.displayElement.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
               _loc8_.canvas.addChildAt(this.motionShadow.bundle,this.getShadowIndex(_loc8_));
            }
            this.showMotionShadow();
         }
      }
      
      private function doChangeMotion(param1:MenuEvent) : void
      {
         var _loc2_:String = null;
         var _loc9_:ICommand = null;
         _loc2_ = param1.item.@id;
         var _loc3_:String = param1.item.@label;
         var _loc4_:String = param1.item.@data;
         var _loc5_:String = param1.item.@direction;
         var _loc6_:String = param1.item.@itemType;
         var _loc7_:CharThumb;
         var _loc8_:Array = (_loc7_ = CharThumb(this.thumb)).motions;
         if(_loc2_ == REMOVE_MOTION)
         {
            (_loc9_ = new RemoveMotionCommand()).execute();
            this.startRemoveMotion();
            this.updateTimelineMotion();
            if(!this.isSlide)
            {
               this.action = CharThumb(this.thumb).defaultAction;
            }
            this.isSlide = false;
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
      
      override function doDragEnter(param1:DragEvent) : void
      {
         var _loc3_:GlowFilter = null;
         var _loc2_:Object = param1.dragSource.dataForFormat("thumb");
         if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable == true || PropThumb(_loc2_).headable == true || PropThumb(_loc2_).wearable == true))
         {
            DragManager.acceptDragDrop(UIComponent(param1.currentTarget));
            if(this.displayElement != null)
            {
               _loc3_ = new GlowFilter(16742400,1,6,6,5);
               this.displayElement.filters = [_loc3_];
            }
         }
      }
      
      override function hideControl() : void
      {
         super.hideControl();
         if(this.motionShadow != null)
         {
            this.motionShadow.hideControl();
         }
         if(!this.isMotionShadow())
         {
            this.hideMotionShadow();
            this.removeMotionMenuListener();
            hideButtonBar();
         }
      }
      
      public function get motion() : Motion
      {
         return this._motion;
      }
      
      public function set head(param1:Prop) : void
      {
         if(this._head)
         {
            this._head.clearDisplayElement();
         }
         this._head = param1;
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
      
      public function get handHeldMenu() : ScrollableArrowMenu
      {
         var _loc1_:* = null;
         var _loc2_:ScrollableArrowMenu = null;
         if(this.prop)
         {
            _loc1_ = "";
            _loc1_ = this.prop.buildStateMenu(_loc1_,false);
            if(_loc1_)
            {
               _loc1_ = "<menuRoot>" + _loc1_ + "</menuRoot>";
               _loc2_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),new XML(_loc1_),false);
               _loc2_.labelField = "@label";
               _loc2_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
               _loc2_.verticalScrollPolicy = ScrollPolicy.OFF;
               _loc2_.arrowScrollPolicy = ScrollPolicy.AUTO;
               _loc2_.minWidth = 150;
               _loc2_.maxHeight = 300;
               _loc2_.showRoot = false;
               return _loc2_;
            }
         }
         return null;
      }
      
      override function onMouseDown(param1:MouseEvent) : void
      {
         super.onMouseDown(param1);
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetFacing = this.facing;
         this._originalRotation = this.bundle.rotation;
         this._backupSceneXML = new XML(this.scene.serialize(-1,false));
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
         Console.getConsole().thumbTrayActive = false;
         this._readyToDrag = true;
      }
      
      public function get facialMenu() : ScrollableArrowMenu
      {
         var _loc3_:ScrollableArrowMenu = null;
         var _loc8_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:State = null;
         var _loc1_:Boolean = true;
         var _loc2_:Boolean = true;
         var _loc4_:CharThumb;
         var _loc5_:Array = (_loc4_ = CharThumb(this.thumb)).actionMenuItems;
         var _loc6_:* = "<menuRoot>";
         var _loc7_:Boolean = UtilLicense.isActionNameNeedLowerCase();
         var _loc9_:PropThumb;
         if((_loc9_ = this.thumb.theme.getPropThumbById(this.thumb.id + ".head")) != null && (this.head == null || this.head != null && this.head.thumb.id == _loc9_.id))
         {
            this._hasFacialExpression = true;
            _loc10_ = 0;
            while(_loc10_ < _loc9_.states.length)
            {
               if((_loc11_ = _loc9_.getStateAt(_loc10_)).isEnable)
               {
                  if(this.head != null && _loc11_.id == this.head.stateId)
                  {
                     _loc8_ = true;
                  }
                  else
                  {
                     _loc8_ = false;
                  }
                  _loc6_ = _loc6_ + ("<menuItem " + "label=\'" + UtilString.firstLetterToUpperCase(UtilXmlInfo.xmlEscape(UtilDict.toDisplay("store",!!_loc7_?_loc11_.name.toLowerCase():_loc11_.name))) + "\' " + "value=\'" + _loc11_.id + "\' " + "type=\'check\' " + "itemType=\'" + MENU_ITEM_TYPE_FACIAL_TAG + "\' " + "toggled=\'" + _loc8_ + "\' " + "enabled=\'" + _loc2_ + "\'/>");
               }
               _loc10_++;
            }
            _loc6_ = _loc6_ + ("<menuItem label=\'" + UtilString.firstLetterToUpperCase(UtilDict.toDisplay("go",MENU_ITEM_DEFAULT)) + "\' value=\'" + MENU_ITEM_DEFAULT + "\' type=\'check\' itemType=\'" + MENU_ITEM_TYPE_FACIAL_TAG + "\' toogled=\'false\'/>");
         }
         _loc6_ = _loc6_ + "</menuRoot>";
         this._actionMenuXML = new XML(_loc6_);
         _loc3_ = ScrollableArrowMenu.createMenu(this.getSceneCanvas(),this._actionMenuXML,false);
         _loc3_.labelField = "@label";
         _loc3_.addEventListener(MenuEvent.ITEM_CLICK,this.doActionMenuClick);
         _loc3_.verticalScrollPolicy = ScrollPolicy.OFF;
         _loc3_.arrowScrollPolicy = ScrollPolicy.AUTO;
         _loc3_.minWidth = 150;
         _loc3_.maxHeight = 300;
         _loc3_.showRoot = false;
         return _loc3_;
      }
      
      override public function startResize() : void
      {
         super.startResize();
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetScaleX = displayElement.scaleX;
         _originalAssetScaleY = displayElement.scaleY;
         this._prevDisplayElementPosX = displayElement.x;
         this._prevDisplayElementPosY = displayElement.y;
      }
      
      private function doActionMenuClick(param1:MenuEvent) : void
      {
         var _loc2_:ICommand = null;
         var _loc7_:String = null;
         var _loc3_:String = param1.item.@itemType;
         var _loc4_:String = param1.item.@direction;
         var _loc5_:String = param1.item.@id;
         var _loc6_:XML;
         if((_loc6_ = XML(param1.item)).attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_PROP_TAG)
         {
            if(_loc6_.attribute("value") == MENU_ITEM_PROP_REMOVE)
            {
               this.removeHandHeld();
            }
            else
            {
               this.prop.doChangeState(param1);
               if(this._motionShadowChar != null)
               {
                  this._motionShadowChar.prop.doChangeState(param1);
               }
            }
            this.control = null;
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_HEAD_TAG)
         {
            if(_loc6_.attribute("value") == MENU_ITEM_HEAD_REMOVE)
            {
               this.restoreHead();
            }
            else
            {
               this.head.doChangeState(param1);
               if(this._motionShadowChar != null)
               {
                  this._motionShadowChar.head.doChangeState(param1);
               }
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_WEAR_TAG)
         {
            if(_loc6_.attribute("value") == MENU_ITEM_WEAR_REMOVE)
            {
               this.removeHeadGear();
            }
            else
            {
               this.wear.doChangeState(param1);
               if(this._motionShadowChar != null)
               {
                  this._motionShadowChar.wear.doChangeState(param1);
               }
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == MENU_ITEM_TYPE_FACIAL_TAG)
         {
            if(_loc6_.@value == MENU_ITEM_DEFAULT)
            {
               _loc2_ = new RemovePropCommand();
               _loc2_.execute();
               this.removeHead();
            }
            else
            {
               _loc2_ = new ChangeActionCommand();
               _loc2_.execute();
               _loc7_ = _loc6_.@value;
               this.changeHeadByStateId(_loc7_);
               this.hideControl();
            }
            this.dispatchEvent(new AssetEvent(AssetEvent.STATE_CHANGE));
         }
         else if(_loc6_.attribute(MENU_ITEM_TYPE_TAG) == UtilString.firstLetterToUpperCase("+ learn New Actions"))
         {
            Console.getConsole().showActionShopWindow(this.thumb.id,this.thumb);
         }
         Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_ACTION_CHANGED,this));
      }
      
      public function get spline() : myBezierSpline
      {
         return this._spline;
      }
      
      private function onShadowMouseDown(param1:MouseEvent) : void
      {
         trace("onShadowMouseDown");
         var _loc2_:Image = Image(this.motionShadow.bundle);
         _loc2_.startDrag();
         if(this.scene.selectedAsset != null)
         {
            this.scene.selectedAsset.hideControl();
            if(this.scene.selectedAsset is Character && Character(this.scene.selectedAsset).motionShadow != null)
            {
               Character(this.scene.selectedAsset).motionShadow.hideControl();
            }
         }
         if(this.scene.selectedAsset == null || this.scene.selectedAsset != null && this.scene.selectedAsset != this)
         {
            this.scene.selectedAsset = this;
         }
         this._originalX = getSceneCanvas().mouseX;
         this._originalY = getSceneCanvas().mouseY;
         _originalAssetX = this.x;
         _originalAssetY = this.y;
         _originalAssetFacing = this.facing;
         this._originalRotation = this.bundle.rotation;
         this._backupSceneXML = new XML(this.scene.serialize(-1,false));
         displayElement.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMoveHandler);
         displayElement.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         Console.getConsole().currDragObject = this;
         Console.getConsole().thumbTrayActive = false;
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      function addHeadDataAndClip(param1:Prop) : void
      {
         if(this.head != null)
         {
            this.head.stopMusic(true);
            this.removeHead();
         }
         this.head = param1;
         this.addHeadClipToHeadContainer(this.head.displayElement,this.displayElement);
      }
      
      public function getActionDefaultTotalFrame() : int
      {
         var _loc1_:CharThumb = null;
         if(this.action != null)
         {
            _loc1_ = this.thumb as CharThumb;
            if(_loc1_ != null && _loc1_.defaultAction != null && this.action.id == _loc1_.defaultAction.id)
            {
               return UtilUnitConvert.pixelToFrame(AnimeConstants.SCENE_LENGTH_DEFAULT);
            }
            return this.action.totalFrame;
         }
         return 1;
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
      
      public function set actionId(param1:String) : void
      {
         this._actionId = param1;
      }
      
      public function get shadowParent() : Character
      {
         return this._shadowParent;
      }
      
      function updatePropSize(param1:DisplayObjectContainer) : void
      {
         var propContainer:DisplayObjectContainer = param1;
         if(this.prop != null)
         {
            try
            {
               this.prop.displayElement.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEX));
               this.prop.displayElement.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
         this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,this._lookAtCamera));
      }
      
      public function get head() : Prop
      {
         return this._head;
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:GlowFilter = null;
         if(Console.getConsole().currDragObject is Prop && param1.buttonDown)
         {
            _loc2_ = Console.getConsole().currDragObject.thumb;
            if(_loc2_ is PropThumb && (PropThumb(_loc2_).holdable == true || PropThumb(_loc2_).headable == true || PropThumb(_loc2_).wearable == true))
            {
               if(this.displayElement != null)
               {
                  _loc3_ = new GlowFilter(16742400,1,6,6,5);
                  this.displayElement.filters = [_loc3_];
               }
            }
         }
         else
         {
            super.onRollOver(param1);
         }
      }
      
      public function get actionId() : String
      {
         return this._actionId;
      }
      
      private function onActionMenuClick(param1:MenuEvent) : void
      {
         this._byMenu = true;
         var _loc2_:ICommand = new ChangeActionCommand();
         if(param1.item.@itemType == "action")
         {
            _loc2_.execute();
            this.removeSlideMotion();
            this.setAction(param1.item.@id);
         }
         else if(param1.item.@itemType == "motion")
         {
            _loc2_.execute();
            this.startSlideMotion();
            this.setAction(param1.item.@id);
         }
         else if(param1.item.@itemType == "learn")
         {
            Console.getConsole().showActionShopWindow(this.thumb.id,this.thumb);
         }
         Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_ACTION_CHANGED,this));
      }
      
      override function doDragDrop(param1:DragEvent) : void
      {
         var _loc4_:ICommand = null;
         var _loc2_:Object = param1.dragSource.dataForFormat("thumb");
         var _loc3_:String = "";
         if(param1.dragSource.hasFormat("colorSetId"))
         {
            _loc3_ = String(param1.dragSource.dataForFormat("colorSetId"));
         }
         if(PropThumb(_loc2_).id.split(".")[0] == this.thumb.id)
         {
            this.removeHead();
            if(this._motionShadowChar != null)
            {
               this._motionShadowChar.removeHead();
            }
         }
         else if(!(PropThumb(_loc2_).headable && this.thumb.isCC))
         {
            if(!this.isMotionShadow())
            {
               (_loc4_ = new AddPropCommand()).execute();
            }
            this.autoStateModify(_loc2_ as PropThumb,null,_loc3_);
         }
      }
      
      private function addPropClipToPropContainer(param1:DisplayObject, param2:DisplayObjectContainer) : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR_FLIP);
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR)) != null)
         {
            if(_loc3_ != null && this.facing != this.defaultFacing)
            {
               _loc5_ = UtilPlain.getProp(_loc3_);
            }
            else
            {
               _loc5_ = UtilPlain.getProp(_loc4_);
            }
            if(_loc5_ != null)
            {
               UtilPlain.removeAllSon(_loc5_);
               _loc5_.addChild(param1);
               this.updatePropSize(_loc5_);
            }
         }
      }
      
      function updateHeadSize(param1:DisplayObjectContainer) : void
      {
         var propContainer:DisplayObjectContainer = param1;
         if(this.head != null)
         {
            try
            {
               if(!this.thumb.isCC)
               {
                  this.head.displayElement.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEX));
                  this.head.displayElement.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,this.displayElement,UtilPlain.PROPERTY_SCALEY));
               }
               else
               {
                  CustomCharacterMaker(this.imageObject).refreshScale();
               }
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function restoreActionFromTalk() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.action == CharThumb(this.thumb).defaultTalkAction)
         {
            this.changeAction(CharThumb(this.thumb).defaultAction);
            _loc1_ = true;
         }
         if(this.head != null && this.head.state.isTalkRelated())
         {
            this.removeHead();
            _loc1_ = true;
         }
         if(!_loc1_)
         {
            if(this.demoSpeech)
            {
               this.demoSpeech = false;
               _loc1_ = true;
               this.loadAssetImage();
               if(this.head)
               {
                  this.head.reloadAssetImage();
               }
            }
         }
         return _loc1_;
      }
      
      override protected function loadAssetImage() : void
      {
         var oloader:Loader = null;
         var oCcChar:CustomCharacterMaker = null;
         var loader:Loader = null;
         var self:Asset = null;
         var ccChar:CustomCharacterMaker = null;
         var args:Object = null;
         var i:int = this.displayElement.numChildren - 1;
         while(i >= 0)
         {
            if(this.displayElement.getChildAt(i) is Loader)
            {
               oloader = Loader(this.displayElement.getChildAt(i));
               oloader.unloadAndStop();
            }
            else if(this.displayElement.getChildAt(i) is CustomCharacterMaker)
            {
               oCcChar = CustomCharacterMaker(this.displayElement.getChildAt(i));
               oCcChar.unloadAssetImage(true);
            }
            this.displayElement.removeChildAt(i);
            i--;
         }
         if(!CharThumb(this.thumb).isCC)
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
            ccChar = new CustomCharacterMaker();
            ccChar.name = AnimeConstants.IMAGE_OBJECT_NAME;
            this.displayElement.addChild(ccChar);
            this.displayElement.visible = false;
            args = this.imageData;
            ccChar.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.loadAssetImageComplete);
            ccChar.lookAtCamera = this.lookAtCamera;
            ccChar.demoSpeech = this.demoSpeech = Console.getConsole().linkageController.isDemoSpeechNeeded(this);
            ccChar.init(args["xml"] as XML,0,0,args["imageData"] as UtilHashArray,CharThumb(this.thumb).getLibraries());
            if(this.initCameraHandler != null)
            {
               removeEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this.initCameraHandler);
            }
            this.initCameraHandler = function(param1:ExtraDataEvent):void
            {
               var _loc2_:Boolean = Boolean(param1.getData());
               trace("CcLookAtCamera: " + (!!_loc2_?"ON":"OFF"));
               head != null && (head.lookAtCamera = _loc2_);
               ccChar.lookAtCamera = _loc2_;
            };
            this.speechHandler = function(param1:SpeechPitchEvent):void
            {
               var _loc2_:Boolean = param1.type == SpeechPitchEvent.DEMO_START?true:false;
               head != null && (head.demoSpeech = _loc2_);
               ccChar.demoSpeech = _loc2_;
            };
            this.addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this.initCameraHandler);
            this.addEventListener(SpeechPitchEvent.DEMO_START,this.speechHandler);
            this.addEventListener(SpeechPitchEvent.DEMO_END,this.speechHandler);
            displayElement.width = this.width;
            displayElement.height = this.height;
            displayElement.scaleX = this.scaleX;
            displayElement.scaleY = this.scaleY;
         }
      }
   }
}
