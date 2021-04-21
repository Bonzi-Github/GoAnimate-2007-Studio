package anifire.core
{
   import anifire.bubble.BubbleMgr;
   import anifire.command.AddAssetCommand;
   import anifire.command.ICommand;
   import anifire.command.RemoveSpeechCommand;
   import anifire.component.*;
   import anifire.components.containers.*;
   import anifire.components.studio.ControlButtonBar;
   import anifire.components.studio.EffectTray;
   import anifire.components.studio.EffectTrayEvent;
   import anifire.constant.AnimeConstants;
   import anifire.core.sound.ProgressiveSound;
   import anifire.effect.EffectMgr;
   import anifire.effect.ZoomEffect;
   import anifire.event.LoadMgrEvent;
   import anifire.events.AssetEvent;
   import anifire.events.SceneEvent;
   import anifire.managers.*;
   import anifire.tutorial.*;
   import anifire.util.*;
   import caurina.transitions.*;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.media.SoundTransform;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import flexlib.controls.ScrollableArrowMenu;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.List;
   import mx.controls.Menu;
   import mx.core.ScrollPolicy;
   import mx.core.UIComponent;
   import mx.events.DragEvent;
   import mx.events.MenuEvent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import mx.managers.PopUpManager;
   import nochump.util.zip.ZipFile;
   
   public class AnimeScene extends EventDispatcher
   {
      
      private static var _existIDs:UtilHashArray = new UtilHashArray();
      
      public static var XML_NODE_NAME:String = "scene";
      
      private static var _sceneNum:int = 0;
      
      private static var _logger:ILogger = Log.getLogger("core.AnimeScene");
      
      private static const ASSET_CREATION_MODE_NULL:String = "nothing";
      
      private static const ASSET_CREATION_MODE_OLD_INSTANCE:String = "old instance";
      
      private static const ASSET_CREATION_MODE_NEW_INSTANCE:String = "new instance";
       
      
      private var _characters:UtilHashArray;
      
      private var _assetGroup:AssetGroup;
      
      private var _console:Console;
      
      private var _bubbles:UtilHashArray;
      
      private var _preselectAssetId:String = "";
      
      private const _DEFAULT_BUBBLE_DALEY:Number = 65;
      
      private var _asset_creation_mode:String = "old instance";
      
      private var _isDragEnter:Boolean;
      
      private var _userLockedTime:Number;
      
      private var _sceneXML:XML;
      
      private var _sizingAsset:Asset;
      
      private const BACKGROUND_INDEX:int = 0;
      
      private var _changed:Boolean;
      
      private var _canvas:Canvas;
      
      private var _props:UtilHashArray;
      
      private var _name:String;
      
      private var _oldMousePoint:Point;
      
      public var enableClickTimer:Timer;
      
      private var _asset_creation_thumb:Thumb;
      
      private var _assetStageOffset:int = -50;
      
      private var _bundle:UIComponent;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _asset_creation_dy:Number;
      
      private var _cloneableAssetsInfo:UtilHashArray;
      
      private const MULTI_SELECT_BORDER_COLOR:uint = 16492449;
      
      private var _afterComBgAsset:Array;
      
      private var _asset_creation_dx:Number;
      
      private const MOTION_TIME:Number = UtilUnitConvert.secToPixel(AnimeConstants.MOTION_DURATION);
      
      private var _id:String;
      
      private var _effects:UtilHashArray;
      
      private var _background:Background;
      
      private var _controlLayer:UIComponent;
      
      private var _dashline:UIComponent;
      
      public function AnimeScene(param1:String = "")
      {
         this._afterComBgAsset = new Array();
         this._eventDispatcher = new EventDispatcher();
         super();
         _logger.debug("AnimeScene initialized");
         ++_sceneNum;
         this._id = this.generateNewID(param1);
         this._name = param1;
         this._characters = new UtilHashArray();
         this._bubbles = new UtilHashArray();
         this._props = new UtilHashArray();
         this._effects = new UtilHashArray();
         this._cloneableAssetsInfo = new UtilHashArray();
         this._userLockedTime = -1;
         this.enableClickTimer = new Timer(AnimeConstants.DOUBLE_CLICK_DURATION,0);
         this.enableClickTimer.addEventListener(TimerEvent.TIMER,this.enableClickingAgain);
         this.initialCanvas();
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile, param3:UtilHashArray) : UtilHashArray
      {
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:UtilHashArray = new UtilHashArray();
         _loc4_ = 0;
         while(_loc4_ < param1.child(Background.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Background.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Background.getThemeTrees(_loc5_,param2));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(Character.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Character.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Character.getThemeTrees(_loc5_,param2,param3));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(Prop.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(Prop.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,Prop.getThemeTrees(_loc5_,param2,param3));
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.child(EffectAsset.XML_NODE_NAME).length())
         {
            _loc5_ = param1.child(EffectAsset.XML_NODE_NAME)[_loc4_];
            ThemeTree.mergeThemeTrees(_loc6_,EffectAsset.getThemeTrees(_loc5_,param2));
            _loc4_++;
         }
         return _loc6_;
      }
      
      public function freezeAssets() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.freeze();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).freeze();
            _loc1_++;
         }
      }
      
      public function get effects() : UtilHashArray
      {
         return this._effects;
      }
      
      private function doDeserialize(param1:LoadMgrEvent) : void
      {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc6_:Object;
         _loc3_ = (_loc6_ = _loc2_.getExtraData())["xml"];
         _loc5_ = (_loc4_ = _loc6_["removeAll"]) == "false"?false:true;
         this.deSerialize(_loc3_,_loc5_,true,false);
      }
      
      private function removeCharacter(param1:Character) : void
      {
         this._characters.remove(this._characters.getIndex(param1.id),1);
      }
      
      private function clearCanvas() : void
      {
         this._canvas.removeAllChildren();
         this._bundle = new UIComponent();
         this._canvas.addChild(this._bundle);
         this._dashline = new UIComponent();
         this._dashline.name = "DASHLINE";
         this._canvas.addChild(this._dashline);
      }
      
      public function set dragEnter(param1:Boolean) : void
      {
         this._isDragEnter = param1;
      }
      
      public function updateEffectTray(param1:Number, param2:Number) : void
      {
         var _loc4_:EffectAsset = null;
         var _loc5_:BubbleAsset = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this.bubbles.length)
         {
            (_loc5_ = this.bubbles.getValueByIndex(_loc3_) as BubbleAsset).updateTimeByScene(param1,param2);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.effects.length)
         {
            (_loc4_ = this.effects.getValueByIndex(_loc3_) as EffectAsset).updateTimeByScene(param1,param2);
            _loc3_++;
         }
      }
      
      public function get selectedAsset() : Asset
      {
         return this._assetGroup.selectedAsset;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function isCharacterTalkingWithLinkage(param1:Character) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         if(!(param1.isInDefaultTalkAction() || param1.isInDefaultTalkFacial()))
         {
            return false;
         }
         var _loc2_:String = Console.getConsole().linkageController.getSpeechIdOfAsset(param1);
         if(_loc2_ != "")
         {
            _loc3_ = "";
            if((_loc4_ = Console.getConsole().linkageController.isLinkageExist(_loc2_)) != null)
            {
               _loc8_ = _loc4_.concat();
               _loc8_.splice(_loc8_.indexOf(_loc2_),1);
               _loc3_ = _loc8_.join("");
            }
            _loc6_ = (_loc5_ = _loc3_.split(AssetLinkage.LINK))[0];
            _loc7_ = _loc5_[1];
            if(param1.scene.id == _loc6_ && param1.id == _loc7_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get sizingAsset() : Asset
      {
         return this._sizingAsset;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      private function doDragExit(param1:DragEvent) : void
      {
      }
      
      private function removeProp(param1:Prop) : void
      {
         var _loc2_:int = this._props.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._props.remove(_loc2_,1);
         }
      }
      
      public function deleteAllAssets() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.deleteAsset(false);
         }
         _loc1_ = this._characters.length - 1;
         while(_loc1_ >= 0)
         {
            Character(this._characters.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
         _loc1_ = this._props.length - 1;
         while(_loc1_ >= 0)
         {
            Prop(this._props.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
         _loc1_ = this._bubbles.length - 1;
         while(_loc1_ >= 0)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
         _loc1_ = this._effects.length - 1;
         while(_loc1_ >= 0)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).deleteAsset(false);
            _loc1_--;
         }
      }
      
      private function doStageMouseDown(param1:MouseEvent) : void
      {
         this._oldMousePoint = new Point(param1.stageX,param1.stageY);
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         var _loc3_:Boolean = true;
         _loc2_ = DisplayObject(param1.target);
         if(_loc2_ == Console.getConsole().thumbTray)
         {
            _loc3_ = false;
         }
         else
         {
            while(_loc2_.parent != null)
            {
               _loc2_ = _loc2_.parent;
               if(_loc2_ == Console.getConsole().thumbTray || _loc2_ is List)
               {
                  _loc3_ = false;
                  break;
               }
            }
         }
         if(DragManager.isDragging)
         {
            _loc3_ = true;
         }
         if(_loc3_)
         {
            this.console.thumbTray.hide(param1,_loc3_);
         }
      }
      
      public function get userLockedTime() : Number
      {
         return this._userLockedTime;
      }
      
      private function getCloneableAssetIndex(param1:String) : int
      {
         return this._cloneableAssetsInfo.getIndex(param1);
      }
      
      private function doDragOver(param1:DragEvent) : void
      {
      }
      
      public function getEffectAssetById(param1:String, param2:Number = 0) : EffectAsset
      {
         var _loc3_:int = this._console.getSceneIndex(this);
         var _loc4_:AnimeScene;
         if((_loc4_ = Console.getConsole().getScene(_loc3_ + param2)) == null)
         {
            return null;
         }
         return EffectAsset(_loc4_.effects.getValueByKey(param1));
      }
      
      public function getAssetById(param1:String) : Asset
      {
         if(param1.indexOf("BG") != -1)
         {
            return this._background;
         }
         if(param1.indexOf("AVATOR") != -1)
         {
            return this.getCharacterById(param1);
         }
         if(param1.indexOf("BUBBLE") != -1)
         {
            return this.getBubbleAssetById(param1);
         }
         if(param1.indexOf("EFFECT") != -1)
         {
            return this.getEffectAssetById(param1);
         }
         if(param1.indexOf("PROP") != -1)
         {
            return this.getPropById(param1);
         }
         return null;
      }
      
      public function get background() : Background
      {
         return this._background;
      }
      
      private function getCloeableAssetInfo(param1:String) : String
      {
         return this._cloneableAssetsInfo.getValueByKey(param1);
      }
      
      private function removeAllBubbles() : void
      {
         this._bubbles.removeAll();
      }
      
      private function bringUpAsset() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this._afterComBgAsset.length)
         {
            this.sendToFront(this._afterComBgAsset[_loc1_]);
            _loc1_++;
         }
         this._afterComBgAsset = new Array();
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
         _existIDs.push(param1,param1);
      }
      
      private function removeBubble(param1:BubbleAsset) : void
      {
         var _loc2_:int = this._bubbles.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._bubbles.remove(_loc2_,1);
            this.refreshEffectTray(Console.getConsole().effectTray);
            this.doUpdateTimelineLength();
         }
      }
      
      public function set selectedAsset(param1:Asset) : void
      {
         this._assetGroup.clearGroup();
         this._assetGroup.addAsset(param1);
         if(param1 == null)
         {
            Console.getConsole().showOverTray(false);
         }
      }
      
      private function getEffectAssetByType(param1:String) : EffectAsset
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getExactType() == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function removeEffect(param1:EffectAsset) : void
      {
         var _loc2_:int = this._effects.getIndex(param1.id);
         if(_loc2_ != -1)
         {
            this._effects.remove(_loc2_,1);
            this.refreshEffectTray(Console.getConsole().effectTray);
         }
         if(param1.getExactType() == EffectThumb.TYPE_ZOOM)
         {
            this._sizingAsset = null;
         }
      }
      
      public function showSpeechMenu(param1:Number, param2:Number) : void
      {
         var _loc4_:XML = null;
         var _loc5_:ScrollableArrowMenu = null;
         var _loc3_:* = "";
         var _loc6_:Boolean = true;
         _loc3_ = "<root><menuItem label=\"" + UtilDict.toDisplay("go","Play") + "\"value=\"" + "play" + "\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",EffectAsset.MENU_LABEL_EDIT) + "\"value=\"" + EffectAsset.MENU_LABEL_EDIT + "\"/>" + "<menuItem label=\"" + UtilDict.toDisplay("go",EffectAsset.MENU_LABEL_DELETE) + "\"value=\"" + EffectAsset.MENU_LABEL_DELETE + "\"/></root>";
         _loc4_ = new XML(_loc3_);
         (_loc5_ = ScrollableArrowMenu.createMenu(null,_loc4_,false)).labelField = "@label";
         _loc5_.addEventListener(MenuEvent.ITEM_CLICK,this.doSpeechMenuClick);
         _loc5_.show(param1 - 80,param2);
      }
      
      private function doCreateAssetAtSceneAgain(param1:LoadMgrEvent) : void
      {
         trace("doCreateCharAtSceneAgain");
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Array = _loc2_.getExtraData() as Array;
         var _loc4_:Thumb = _loc3_[0] as Thumb;
         var _loc5_:Number = _loc3_[1];
         var _loc6_:Number = _loc3_[2];
         var _loc7_:String = _loc3_[3];
         Util.gaTracking("/gostudio/assets/" + _loc4_.theme.id + "/complete/" + _loc4_.id,Console.getConsole().mainStage.stage);
         this.createAsset(_loc4_,_loc5_,_loc6_,_loc7_);
      }
      
      public function replaceBubbleText(param1:String, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < this._bubbles.length)
         {
            if(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.text.indexOf(param1) > -1)
            {
               if(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.backupText == "")
               {
                  BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.backupText = BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).text;
               }
               BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).text = UtilString.replace(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.text,param1,param2);
               this.canvas.callLater(BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.reUpdateTextHeight);
               this.canvas.callLater(this.canvas.callLater,[BubbleAsset(this._bubbles.getValueByIndex(_loc3_)).bubble.reUpdateTextHeight]);
            }
            _loc3_++;
         }
      }
      
      public function showEffects(param1:Boolean = false) : void
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._effects.length)
         {
            if(this._effects.getValueByIndex(_loc3_) is AnimeEffectAsset)
            {
               _loc2_ = AnimeEffectAsset(this._effects.getValueByIndex(_loc3_));
               if(_loc2_.status == EffectAsset.STATUS_SHOW)
               {
                  _loc2_.showEffect();
               }
            }
            if(param1)
            {
               if(this._effects.getValueByIndex(_loc3_) is ProgramEffectAsset)
               {
                  _loc2_ = ProgramEffectAsset(this._effects.getValueByIndex(_loc3_));
                  if(_loc2_.getExactType() == EffectThumb.TYPE_ZOOM)
                  {
                     _loc2_.status = EffectAsset.STATUS_SHOW;
                     _loc2_.showEffect();
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function onAssetRollOut(param1:AssetEvent) : void
      {
         var _loc2_:Asset = param1.asset;
         if(_loc2_ is Background)
         {
            Console.getConsole().mainStage.selectionTool.deactivate();
         }
      }
      
      public function onCloneAndAddComplete(param1:LoadMgrEvent) : void
      {
         var _loc2_:Object = UtilLoadMgr(param1.currentTarget).getExtraData();
         var _loc3_:AnimeScene = _loc2_["scene"];
         if(this.preselectAssetId != "")
         {
            _loc3_.selectedAsset = _loc3_.getAssetById(this.preselectAssetId);
            _loc3_.assetGroup.showControl();
            this.preselectAssetId = "";
         }
      }
      
      public function hideEffects(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:EffectAsset = null;
         var _loc4_:int = 0;
         while(_loc4_ < this._effects.length)
         {
            if(this._effects.getValueByIndex(_loc4_) is AnimeEffectAsset)
            {
               _loc3_ = AnimeEffectAsset(this._effects.getValueByIndex(_loc4_));
               if(param2)
               {
                  _loc3_.status = EffectAsset.STATUS_HIDE;
               }
               _loc3_.hideEffect();
            }
            if(param1)
            {
               if(this._effects.getValueByIndex(_loc4_) is ProgramEffectAsset)
               {
                  _loc3_ = ProgramEffectAsset(this._effects.getValueByIndex(_loc4_));
                  if(param2)
                  {
                     _loc3_.status = EffectAsset.STATUS_HIDE;
                  }
                  _loc3_.hideEffect();
               }
            }
            _loc4_++;
         }
      }
      
      private function replaceVideo(param1:Event) : void
      {
         this.deleteAllVideos();
         var _loc2_:Array = Button(param1.currentTarget).data as Array;
         this.createAsset(_loc2_[0],_loc2_[1],_loc2_[2]);
      }
      
      public function set userLockedTime(param1:Number) : void
      {
         this._userLockedTime = param1;
      }
      
      public function getPropInPrevSceneById(param1:String) : Prop
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ - 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getPropById(param1);
      }
      
      public function getPropById(param1:String) : Prop
      {
         return Prop(this._props.getValueByKey(param1));
      }
      
      public function createAsset(param1:Thumb, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Boolean = false) : void
      {
         var _loc6_:GoAlert = null;
         var _loc7_:Asset = null;
         var _loc8_:UtilLoadMgr = null;
         var _loc9_:Array = null;
         var _loc10_:CharThumb = null;
         var _loc11_:AssetLocation = null;
         var _loc12_:String = null;
         var _loc13_:BackgroundThumb = null;
         var _loc14_:BubbleThumb = null;
         var _loc15_:SoundThumb = null;
         var _loc16_:AnimeScene = null;
         var _loc17_:PropThumb = null;
         var _loc18_:AssetLocation = null;
         var _loc19_:String = null;
         var _loc20_:EffectThumb = null;
         var _loc21_:AssetLocation = null;
         var _loc22_:String = null;
         if(param1 is VideoPropThumb && this.isVideoTypeExist())
         {
            (_loc6_ = GoAlert(PopUpManager.createPopUp(this._canvas,GoAlert,true)))._lblConfirm.text = "";
            _loc6_._txtDelete.text = UtilDict.toDisplay("go","goalert_confirmreplacevideo");
            _loc6_._btnDelete.label = UtilDict.toDisplay("go","goalert_confirmreplacevideoyes");
            _loc6_._btnDelete.data = new Array(param1,param2,param3);
            _loc6_._btnDelete.addEventListener(MouseEvent.CLICK,this.replaceVideo);
            _loc6_._btnCancel.label = UtilDict.toDisplay("go","goalert_confirmreplacevideono");
            _loc6_._btnCancel.data = new Array(param1,param2,param3);
            _loc6_.x = (_loc6_.stage.width - _loc6_.width) / 2;
            _loc6_.y = 100;
            return;
         }
         if(Console.getConsole().initCreation == true)
         {
            Console.getConsole().initCreation = false;
            Util.gaTracking("/gostudio/sigAction",Console.getConsole().mainStage.stage);
         }
         if(param3 >= 0)
         {
            if(param1 is CharThumb)
            {
               if(!(_loc10_ = param1 as CharThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(_loc10_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  if(_loc10_.theme.id == "ugc" && CharThumb(param1).isSWFCharacter())
                  {
                     _loc10_.loadActionsAndMotions();
                  }
                  else
                  {
                     _loc10_.loadAction();
                  }
               }
               else
               {
                  if((_loc11_ = this.getAssetId(param1)) != null)
                  {
                     _loc12_ = _loc11_.assetId;
                  }
                  else
                  {
                     _loc12_ = "";
                  }
                  (_loc7_ = new Character(_loc12_)).x = param2;
                  _loc7_.y = param3;
                  Character(_loc7_).facing = CharThumb(param1).facing;
                  Character(_loc7_).fromTray = true;
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is BackgroundThumb)
            {
               if(!(_loc13_ = param1 as BackgroundThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(_loc13_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  _loc13_.loadImageData();
               }
               else
               {
                  (_loc7_ = new Background()).x = AnimeConstants.SCREEN_X;
                  _loc7_.y = AnimeConstants.SCREEN_Y;
                  _loc7_.width = AnimeConstants.SCREEN_WIDTH;
                  _loc7_.height = AnimeConstants.SCREEN_HEIGHT;
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is BubbleThumb)
            {
               (_loc7_ = new BubbleAsset()).x = param2;
               _loc7_.y = param3;
               BubbleAsset(_loc7_).fromTray = true;
               Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               _loc14_ = param1 as BubbleThumb;
               _loc7_.type = _loc14_.type;
               if(_loc14_.isShowMsg)
               {
                  Console.getConsole().showBubbleMsgWindow(_loc14_,BubbleAsset(_loc7_));
               }
            }
            else if(param1 is SoundThumb)
            {
               _loc15_ = param1 as SoundThumb;
               _loc16_ = this;
               if(_loc15_.isLoading == false)
               {
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loading/" + param1.id,Console.getConsole().mainStage.stage);
                  Console.getConsole().checkSoundSpaceAtScene(_loc16_,_loc15_);
               }
               else
               {
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is PropThumb)
            {
               if(!(_loc17_ = param1 as PropThumb).isThumbReady())
               {
                  _loc8_ = new UtilLoadMgr();
                  (_loc9_ = new Array()).push(param1);
                  _loc9_.push(param2);
                  _loc9_.push(param3);
                  _loc9_.push(param4);
                  _loc8_.setExtraData(_loc9_);
                  _loc8_.addEventDispatcher(param1.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                  _loc8_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doCreateAssetAtSceneAgain);
                  _loc8_.commit();
                  _loc17_.loadState();
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loading/" + param1.id,Console.getConsole().mainStage.stage);
               }
               else
               {
                  if(_loc17_.placeable != false)
                  {
                     if((_loc18_ = this.getAssetId(param1)) != null)
                     {
                        _loc19_ = _loc18_.assetId;
                     }
                     else
                     {
                        _loc19_ = "";
                     }
                     if(param1 is VideoPropThumb)
                     {
                        _loc7_ = new VideoProp();
                     }
                     else
                     {
                        _loc7_ = new Prop(_loc19_);
                     }
                     _loc7_.x = param2;
                     _loc7_.y = param3;
                     Prop(_loc7_).facing = PropThumb(param1).facing;
                     Prop(_loc7_).fromTray = true;
                  }
                  Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
               }
            }
            else if(param1 is EffectThumb)
            {
               if((_loc20_ = param1 as EffectThumb).getType() == EffectThumb.TYPE_ANIME)
               {
                  _loc7_ = new AnimeEffectAsset();
               }
               else if(_loc20_.getType() == EffectThumb.TYPE_PROGRAM)
               {
                  if((_loc21_ = this.getAssetId(param1)) != null)
                  {
                     _loc22_ = _loc21_.assetId;
                  }
                  else
                  {
                     _loc22_ = "";
                  }
                  _loc7_ = new ProgramEffectAsset(_loc22_);
               }
               _loc7_.x = param2;
               _loc7_.y = param3;
               _loc7_.resize = _loc20_.getResize() == "true"?true:false;
               if(!_loc7_.resize)
               {
                  _loc7_.x = AnimeConstants.SCREEN_WIDTH / 2 + AnimeConstants.SCREEN_X;
                  _loc7_.y = AnimeConstants.SCREEN_HEIGHT / 2 + AnimeConstants.SCREEN_Y;
               }
               EffectAsset(_loc7_).fromTray = true;
               EffectAsset(_loc7_).fromSpeech = param5;
               Util.gaTracking("/gostudio/assets/" + param1.theme.id + "/loaded/" + param1.id,Console.getConsole().mainStage.stage);
            }
            if(_loc7_ != null)
            {
               _loc7_.scene = this;
               _loc7_.thumb = param1;
               if(param4 != "")
               {
                  _loc7_.defaultColorSetId = param4;
                  _loc7_.defaultColorSet = param1.getColorSetById(param4);
               }
               trace("addAsset:" + _loc7_.defaultColorSetId);
               this.addAsset(_loc7_);
            }
         }
      }
      
      public function get console() : Console
      {
         return this._console;
      }
      
      public function getNumberOfAssests() : int
      {
         if(this._background == null)
         {
            return this._characters.length + this._bubbles.length + this._props.length + this._effects.length + 0;
         }
         return this._characters.length + this._bubbles.length + this._props.length + this._effects.length + 1;
      }
      
      public function set background(param1:Background) : void
      {
         this._background = param1;
      }
      
      function clone() : AnimeScene
      {
         var _loc2_:Asset = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Background = null;
         var _loc9_:Character = null;
         var _loc10_:Prop = null;
         var _loc11_:EffectAsset = null;
         var _loc12_:BubbleAsset = null;
         var _loc1_:AnimeScene = new AnimeScene();
         _loc1_.userLockedTime = this.getCloneSceneTime(this);
         _loc1_.console = this.console;
         var _loc3_:UtilLoadMgr = new UtilLoadMgr();
         var _loc4_:Object;
         (_loc4_ = new Object())["scene"] = _loc1_;
         _loc3_.setExtraData(_loc4_);
         _loc3_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onCloneAndAddComplete);
         var _loc5_:int = 0;
         while(_loc5_ < this._cloneableAssetsInfo.length)
         {
            _loc6_ = String(this._cloneableAssetsInfo.getValueByIndex(_loc5_));
            _loc7_ = String(this._cloneableAssetsInfo.getKey(_loc5_));
            if(_loc6_ == "background")
            {
               if(this._background != null)
               {
                  (_loc8_ = Background(this._background.clone(true))).capScreenLock = this.console.capScreenLock;
                  _loc8_.scene = _loc1_;
                  _loc3_.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  _loc3_.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
                  _loc1_.addAsset(_loc8_);
               }
            }
            else if(_loc6_ == "char")
            {
               (_loc9_ = Character(this._characters.getValueByKey(_loc7_))).capScreenLock = this.console.capScreenLock;
               if(_loc9_ != null)
               {
                  _loc2_ = _loc9_.clone(true,_loc1_);
                  trace("assetimageb:" + _loc2_.bundle.bytesTotal);
                  _loc2_.scene = _loc1_;
                  _loc2_.capScreenLock = this.console.capScreenLock;
                  if(Character(_loc2_).action.isMotion)
                  {
                     Character(_loc2_).setAction(!!Character(_loc2_).action.nextActionId?Character(_loc2_).action.nextActionId:Character(_loc2_).action.defaultActionId,true);
                     if(_loc9_.motionShadow != null)
                     {
                        _loc2_.x = _loc9_.motionShadow.x;
                        _loc2_.y = _loc9_.motionShadow.y;
                     }
                  }
                  if(this.isCharacterTalkingWithLinkage(_loc9_))
                  {
                     Character(_loc2_).restoreActionFromTalk();
                  }
                  trace("assetimage:" + _loc2_.bundle.bytesTotal);
                  Character(_loc2_).updateColor();
                  _loc3_.addEventDispatcher(_loc2_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  _loc3_.addEventDispatcher(_loc2_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
                  _loc1_.addAsset(_loc2_);
               }
            }
            else if(_loc6_ == "prop")
            {
               (_loc10_ = Prop(this._props.getValueByKey(_loc7_))).capScreenLock = this.console.capScreenLock;
               if(_loc10_ != null)
               {
                  if(_loc10_ is VideoProp)
                  {
                     _loc2_ = VideoProp(_loc10_).clone(true);
                  }
                  else
                  {
                     _loc2_ = _loc10_.clone(true);
                  }
                  _loc2_.scene = _loc1_;
                  _loc2_.capScreenLock = this.console.capScreenLock;
                  _loc3_.addEventDispatcher(_loc2_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  _loc3_.addEventDispatcher(_loc2_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
                  _loc1_.addAsset(_loc2_);
               }
            }
            else if(_loc6_ == "effect")
            {
               if((_loc11_ = EffectAsset(this._effects.getValueByKey(_loc7_))) != null)
               {
                  _loc2_ = _loc11_.clone(true);
                  _loc2_.scene = _loc1_;
                  if(_loc11_.motionShadow != null)
                  {
                     EffectAsset(_loc2_).fromTray = true;
                     _loc2_.x = _loc11_.motionShadow.x;
                     _loc2_.y = _loc11_.motionShadow.y;
                     EffectAsset(_loc2_).effect.width = _loc11_.motionShadow.effect.width;
                     EffectAsset(_loc2_).effect.height = _loc11_.motionShadow.effect.height;
                  }
                  _loc1_.addAsset(_loc2_);
               }
            }
            else if(_loc6_ == "bubble")
            {
               (_loc12_ = BubbleAsset(this._bubbles.getValueByKey(_loc7_))).capScreenLock = this.console.capScreenLock;
               if(_loc12_ != null)
               {
                  _loc2_ = _loc12_.clone(true);
                  _loc2_.scene = _loc1_;
                  _loc2_.capScreenLock = this.console.capScreenLock;
                  _loc1_.addAsset(_loc2_);
               }
            }
            _loc5_++;
         }
         _loc3_.commit();
         return _loc1_;
      }
      
      private function doEffectTrayOver(param1:EffectTrayEvent) : void
      {
         var _loc2_:Asset = this.getAssetById(param1.id);
         if(_loc2_ != null && Console.getConsole().currentScene == this)
         {
            this.selectedAsset = null;
            _loc2_.showControl();
         }
      }
      
      public function get canvas() : Canvas
      {
         return this._canvas;
      }
      
      public function removeAllAssets() : void
      {
         this.removeSound();
         this.removeBackground();
         this.removeAllCharacters();
         this.removeAllBubbles();
         this.removeAllProps();
         this.removeAllEffects();
      }
      
      private function onAssetRollOver(param1:AssetEvent) : void
      {
         var _loc2_:Asset = param1.asset;
         if(_loc2_ is Background)
         {
            Console.getConsole().mainStage.selectionTool.activate();
         }
      }
      
      private function enableClickingAgain(param1:TimerEvent) : void
      {
         Console.getConsole().stageViewStage.stage.addEventListener(MouseEvent.MOUSE_UP,this.doStageMouseUp);
         this.enableClickTimer.stop();
         this.enableClickTimer.reset();
      }
      
      private function doEffectTrayClick(param1:EffectTrayEvent) : void
      {
         var _loc2_:Asset = this.getAssetById(param1.id);
         if(_loc2_ is BubbleAsset)
         {
            (_loc2_ as BubbleAsset).showMenu(this._canvas.stage.mouseX,this._canvas.stage.mouseY);
         }
         else if(_loc2_ is EffectAsset)
         {
            (_loc2_ as EffectAsset).showMenu(this._canvas.stage.mouseX,this._canvas.stage.mouseY);
         }
         else
         {
            this.showSpeechMenu(this._canvas.stage.mouseX,this._canvas.stage.mouseY);
         }
      }
      
      public function meltAllAssets() : void
      {
         var _loc1_:int = 0;
         if(this._background != null)
         {
            this._background.melt();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).melt();
            _loc1_++;
         }
      }
      
      public function get bubbles() : UtilHashArray
      {
         return this._bubbles;
      }
      
      public function set changed(param1:Boolean) : void
      {
         this._changed = param1;
         if(param1 && !this.console.capScreenLock)
         {
            this.console.doUpdateTimelineByScene(this,true);
            this.doUpdateTimelineLength();
            this.dispatchEvent(new SceneEvent(Event.CHANGE));
         }
      }
      
      public function get characters() : UtilHashArray
      {
         return this._characters;
      }
      
      public function loadAllAssets() : void
      {
         var _loc1_:UtilLoadMgr = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Character = null;
         var _loc7_:String = null;
         var _loc8_:AnimeSound = null;
         var _loc9_:String = null;
         var _loc10_:BubbleAsset = null;
         var _loc11_:Prop = null;
         var _loc12_:EffectAsset = null;
         if(this.sceneXML != null)
         {
            this.deSerialize(this.sceneXML,true,true,false);
            this.sceneXML = null;
            return;
         }
         this.console.capScreenLock = true;
         _loc1_ = new UtilLoadMgr();
         _loc1_.setExtraData(new Date());
         _loc1_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onLoadAllAssetsComplete);
         if(this._background != null)
         {
            _loc1_.addEventDispatcher(this._background.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            this._background.imageData = this._background.thumb.imageData;
         }
         _loc2_ = 0;
         while(_loc2_ < this._characters.length)
         {
            _loc6_ = Character(this._characters.getValueByIndex(_loc2_));
            _loc1_.addEventDispatcher(_loc6_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            _loc7_ = Console.getConsole().linkageController.getSpeechIdByScene(this);
            if((_loc8_ = Console.getConsole().speechManager.getValueByKey(_loc7_)) is ProgressiveSound)
            {
               _loc9_ = Console.getConsole().linkageController.getCharIdOfSpeech(_loc7_);
               _loc6_.demoSpeech = AssetLinkage.getCharIdFromLinkage(_loc9_) == _loc6_.id?true:false;
            }
            _loc6_.imageData = _loc6_.action.imageData;
            if(_loc6_.prop)
            {
               if(_loc6_.prop.state != null)
               {
                  _loc6_.prop.imageData = _loc6_.prop.state.imageData;
               }
               else
               {
                  _loc6_.prop.imageData = _loc6_.prop.thumb.imageData;
               }
            }
            if(_loc6_.head)
            {
               if(_loc6_.head.state != null)
               {
                  _loc6_.head.imageData = _loc6_.head.state.imageData;
               }
               else
               {
                  _loc6_.head.imageData = _loc6_.head.thumb.imageData;
               }
            }
            if(_loc6_.wear)
            {
               if(_loc6_.wear.state != null)
               {
                  _loc6_.wear.imageData = _loc6_.wear.state.imageData;
               }
               else
               {
                  _loc6_.wear.imageData = _loc6_.wear.thumb.imageData;
               }
            }
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this._bubbles.length)
         {
            _loc10_ = BubbleAsset(this._bubbles.getValueByIndex(_loc3_));
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < this._props.length)
         {
            _loc11_ = Prop(this._props.getValueByIndex(_loc4_));
            _loc1_.addEventDispatcher(_loc11_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
            if(_loc11_.state != null)
            {
               _loc11_.imageData = _loc11_.state.imageData;
            }
            else
            {
               _loc11_.imageData = _loc11_.thumb.imageData;
            }
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < this._effects.length)
         {
            if((_loc12_ = this._effects.getValueByIndex(_loc5_) as EffectAsset) is AnimeEffectAsset)
            {
               _loc1_.addEventDispatcher(_loc12_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
               AnimeEffectAsset(_loc12_).imageData = AnimeEffectAsset(_loc12_).thumb.imageData;
            }
            _loc5_++;
         }
         _loc1_.commit();
      }
      
      private function doStageMouseUp(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:Thumb = null;
         var _loc5_:String = null;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:Boolean = Console.getConsole().getImporter() == null || Console.getConsole().getImporter() != null && Console.getConsole().swfloader.content.visible == false || Console.getConsole().getViewStackWindow() == null;
         if(_loc2_)
         {
            _loc3_ = DisplayObject(param1.target);
            if(this.console.currentScene)
            {
               if(!DragManager.isDragging)
               {
                  if(_loc3_ != this.console.currentScene.canvas)
                  {
                     while(_loc3_.parent != null)
                     {
                        _loc3_ = _loc3_.parent;
                        if(_loc3_ == this.console.stageViewStage || _loc3_ is Menu)
                        {
                           break;
                        }
                        if(_loc3_ == param1.currentTarget)
                        {
                           break;
                        }
                     }
                  }
               }
               else if(this._oldMousePoint && Math.abs(this._oldMousePoint.x - param1.stageX) < 5 && Math.abs(this._oldMousePoint.y - param1.stageY) < 5)
               {
                  if(!this._isDragEnter && Console.getConsole().currentScene == this && Console.getConsole().currDragSource != null)
                  {
                     _loc4_ = Thumb(Console.getConsole().currDragSource.dataForFormat("thumb"));
                     _loc5_ = "";
                     if(Console.getConsole().currDragSource.hasFormat("colorSetId"))
                     {
                        _loc5_ = String(Console.getConsole().currDragSource.dataForFormat("colorSetId"));
                     }
                     _loc6_ = Console.getConsole().mainStage.viewCenter;
                     _loc7_ = Console.getConsole().stageScale;
                     _loc8_ = _loc6_.x - AnimeConstants.STAGE_PADDING + this._assetStageOffset / _loc7_;
                     _loc9_ = _loc6_.y - AnimeConstants.STAGE_PADDING;
                     _loc8_ = Math.max(_loc8_,AnimeConstants.SCREEN_X);
                     _loc8_ = Math.min(_loc8_,AnimeConstants.STAGE_WIDTH - AnimeConstants.SCREEN_X);
                     _loc9_ = Math.max(_loc9_,AnimeConstants.SCREEN_Y);
                     _loc9_ = Math.min(_loc9_,AnimeConstants.STAGE_HEIGHT - AnimeConstants.SCREEN_Y);
                     this.doCreateAsset(_loc4_,_loc8_,_loc9_,_loc5_);
                     this._assetStageOffset = this._assetStageOffset + 10;
                     if(this._assetStageOffset > 10)
                     {
                        this._assetStageOffset = -10;
                     }
                     Console.getConsole().currDragSource = null;
                  }
                  this._isDragEnter = false;
               }
            }
            if(Console.getConsole().currentScene == this)
            {
            }
         }
      }
      
      public function deSerialize(param1:XML, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : void
      {
         var filename:String = null;
         var id:String = null;
         var theme:Theme = null;
         var themeId:String = null;
         var thumbId:String = null;
         var nodeXML:XML = null;
         var item:XML = null;
         var k:int = 0;
         var j:int = 0;
         var sceneNode:XML = param1;
         var removeAll:Boolean = param2;
         var doLoadBytes:Boolean = param3;
         var unloadAfterFinish:Boolean = param4;
         var sortedIndex:Array = UtilXmlInfo.getAndSortXMLattribute(sceneNode,"index");
         if(removeAll)
         {
            this._cloneableAssetsInfo = new UtilHashArray();
            this.deleteAllAssets();
            this.clearCanvas();
            this.removeAllAssets();
         }
         else
         {
            k = 1;
            j = sortedIndex.length;
            while(j > 0)
            {
               nodeXML = sceneNode.children().(@index == String(sortedIndex[j - 1]))[0];
               nodeXML.@newIndex = k;
               k++;
               j--;
            }
            nodeXML = sceneNode.children().(@index == "0")[0];
            nodeXML.@newIndex = 0;
            sortedIndex = UtilXmlInfo.getAndSortXMLattribute(sceneNode,"newIndex");
         }
         var loadMgr:UtilLoadMgr = new UtilLoadMgr();
         var exdata:Object = new Object();
         exdata["unloadAfterFinish"] = unloadAfterFinish;
         exdata["doLoadBytes"] = doLoadBytes;
         loadMgr.setExtraData(exdata);
         loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onDeserializeAndAddComplete);
         trace("###################################### Deserialize:" + this.id);
         var i:int = 0;
         while(i < sortedIndex.length)
         {
            if(removeAll)
            {
               nodeXML = sceneNode.children().(@index == String(sortedIndex[i]))[0];
            }
            else
            {
               nodeXML = sceneNode.children().(@newIndex == String(sortedIndex[i]))[0];
            }
            this.deserializeAsset(nodeXML,removeAll,true,doLoadBytes,loadMgr);
            i++;
         }
         loadMgr.commit();
         if(removeAll)
         {
            this.deserializeSceneLength(sceneNode);
         }
         trace("###################################### Deserialize Done:" + this.id);
      }
      
      public function get assetGroup() : AssetGroup
      {
         return this._assetGroup;
      }
      
      public function get props() : UtilHashArray
      {
         return this._props;
      }
      
      public function unloadAllAssets(param1:Boolean = true) : void
      {
         var _loc6_:Character = null;
         var _loc7_:BubbleAsset = null;
         var _loc8_:Prop = null;
         var _loc9_:EffectAsset = null;
         if(this._background != null)
         {
            this._background.stopBackground();
            this._background.unloadAssetImage(param1);
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._characters.length)
         {
            (_loc6_ = Character(this._characters.getValueByIndex(_loc2_))).stopCharacter();
            _loc6_.unloadAssetImage(param1);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._bubbles.length)
         {
            _loc7_ = BubbleAsset(this._bubbles.getValueByIndex(_loc3_));
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._props.length)
         {
            (_loc8_ = Prop(this._props.getValueByIndex(_loc4_))).stopProp();
            _loc8_.unloadAssetImage(param1);
            _loc4_++;
         }
         var _loc5_:int = 0;
         while(_loc5_ < this._effects.length)
         {
            if((_loc9_ = this._effects.getValueByIndex(_loc5_) as EffectAsset) is AnimeEffectAsset)
            {
               AnimeEffectAsset(_loc9_).stopEffect();
               AnimeEffectAsset(_loc9_).unloadAssetImage(param1);
            }
            _loc5_++;
         }
      }
      
      public function getCharacterInPrevSceneById(param1:String) : Character
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ - 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getCharacterById(param1);
      }
      
      private function isVideoTypeExist() : Boolean
      {
         var _loc1_:Prop = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.props.length)
         {
            _loc1_ = this.props.getValueByIndex(_loc2_) as Prop;
            if(_loc1_ is VideoProp)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function muteSound(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc2_)).muteSound(param1);
            _loc2_++;
         }
         if(this.background != null)
         {
            this.background.muteSound(param1);
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc3_)).muteSound(param1);
            if(Character(this._characters.getValueByIndex(_loc3_)).prop != null)
            {
               Character(this._characters.getValueByIndex(_loc3_)).prop.muteSound(param1);
            }
            if(Character(this._characters.getValueByIndex(_loc3_)).head != null)
            {
               Character(this._characters.getValueByIndex(_loc3_)).head.muteSound(param1);
            }
            if(Character(this._characters.getValueByIndex(_loc3_)).wear != null)
            {
               Character(this._characters.getValueByIndex(_loc3_)).wear.muteSound(param1);
            }
            _loc3_++;
         }
         var _loc4_:int = 0;
         while(_loc4_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc4_)).muteSound(param1);
            _loc4_++;
         }
      }
      
      private function generateNewID(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(param1 == null)
         {
            _loc4_ = true;
         }
         else if(param1 == "")
         {
            _loc4_ = true;
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            _loc3_ = _existIDs.length;
            do
            {
               _loc2_ = "SCENE" + _loc3_;
               _loc3_++;
            }
            while(_existIDs.containsKey(_loc2_));
            
         }
         else
         {
            _loc2_ = param1;
         }
         _existIDs.push(_loc2_,_loc2_);
         return _loc2_;
      }
      
      public function deleteAssetGroup() : void
      {
         this._assetGroup.deleteGroup();
      }
      
      private function addCharacter(param1:String, param2:Character) : void
      {
         this._characters.push(param1,param2);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function getPropInNextSceneById(param1:String) : Prop
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ + 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getPropById(param1);
      }
      
      public function getBubbleAssetById(param1:String) : BubbleAsset
      {
         return BubbleAsset(this._bubbles.getValueByKey(param1));
      }
      
      private function addEffect(param1:String, param2:EffectAsset) : void
      {
         this._effects.push(param1,param2);
         Console.getConsole().effectTray.addEffect(param1,param2.getType(),param2.thumb.name);
         this.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      public function deserializeSceneLength(param1:XML) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Number = UtilUnitConvert.frameToPixel(Number(param1.@adelay));
         var _loc3_:Number = _loc2_;
         if(this.userLockedTime == -1 && param1.@lock == "Y")
         {
            this.userLockedTime = _loc3_;
         }
         if(param1.toString() != "")
         {
            _loc4_ = Console.getConsole().getSceneIndex(this);
            Console.getConsole().timeline.sceneLengthController.doSystemUpdateSceneLength(_loc3_,this.userLockedTime,_loc4_,false);
         }
      }
      
      public function get dashline() : UIComponent
      {
         return this._dashline;
      }
      
      public function setFocus() : void
      {
         this._canvas.setFocus();
      }
      
      public function set preselectAssetId(param1:String) : void
      {
         this._preselectAssetId = param1;
      }
      
      private function getCloneSceneTime(param1:AnimeScene) : Number
      {
         return -1;
      }
      
      private function putDataBySceneXML(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Theme = null;
         var _loc8_:BackgroundThumb = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:CharThumb = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         var _loc15_:PropThumb = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:PropThumb = null;
         var _loc20_:EffectThumb = null;
         var _loc21_:int = 0;
         var _loc22_:String = null;
         for each(_loc2_ in param1.children())
         {
            _loc3_ = _loc2_.name();
            _loc4_ = _loc3_ == Character.XML_NODE_NAME?_loc2_.action:_loc2_.file;
            _loc5_ = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
            _loc6_ = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
            if((_loc7_ = Console.getConsole().getTheme(_loc5_)) == null)
            {
               continue;
            }
            switch(_loc3_)
            {
               case Background.XML_NODE_NAME:
                  _loc8_ = _loc7_.getBackgroundThumbById(_loc6_);
                  this.console.putData(_loc8_.theme.id + ".bg." + _loc8_.id,ByteArray(_loc8_.imageData));
                  continue;
               case Character.XML_NODE_NAME:
                  _loc9_ = UtilXmlInfo.getZipFileNameOfBehaviour(_loc2_.action,true);
                  _loc10_ = UtilXmlInfo.getThumbIdFromFileName(_loc9_);
                  _loc11_ = UtilXmlInfo.getCharIdFromFileName(_loc9_);
                  _loc12_ = _loc7_.getCharThumbById(_loc11_);
                  this.console.putData(_loc12_.theme.id + ".char." + _loc12_.id + "." + _loc10_,_loc12_.getActionById(_loc10_).imageData);
                  _loc21_ = 0;
                  while(_loc21_ < _loc12_.getLibraryNum())
                  {
                     _loc22_ = _loc12_.getLibraryIdByIndex(_loc21_);
                     this.console.putData(_loc22_,_loc12_.getLibraryById(_loc22_));
                     _loc21_++;
                  }
                  this.putDataBySceneXML(_loc2_);
                  continue;
               case Prop.XML_NODE_NAME:
               case Prop.XML_NODE_NAME_WEAR:
                  _loc13_ = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
                  _loc14_ = _loc4_.split(".").length == 3?_loc13_:UtilXmlInfo.getCharIdFromFileName(_loc4_);
                  if((_loc15_ = _loc7_.getPropThumbById(_loc14_)).getStateNum() == 0)
                  {
                     this.console.putData(_loc15_.theme.id + ".prop." + _loc15_.id,ByteArray(_loc15_.imageData));
                  }
                  else
                  {
                     this.console.putData(_loc15_.theme.id + ".prop." + _loc15_.id + "." + _loc15_.getStateById(_loc13_).id,ByteArray(_loc15_.getStateById(_loc13_).imageData));
                  }
                  continue;
               case Prop.XML_NODE_NAME_HEAD:
                  _loc16_ = UtilXmlInfo.getZipFileNameOfProp(_loc4_);
                  _loc17_ = UtilXmlInfo.getThumbIdFromFileName(_loc16_);
                  _loc18_ = UtilXmlInfo.getCharIdFromFileName(_loc16_);
                  if(_loc17_.indexOf(".head.") != -1)
                  {
                     _loc18_ = UtilXmlInfo.getFacialThumbIdFromFileName(_loc17_);
                     _loc17_ = UtilXmlInfo.getFacialIdFromFileName(_loc17_);
                  }
                  else
                  {
                     _loc18_ = _loc17_;
                  }
                  if((_loc19_ = _loc7_.getPropThumbById(_loc18_)).getStateNum() == 0)
                  {
                     this.console.putData(_loc19_.theme.id + ".prop." + _loc19_.id,_loc19_.imageData);
                  }
                  else
                  {
                     this.console.putData(_loc19_.theme.id + ".prop." + _loc19_.id + "." + _loc19_.getStateById(_loc17_).id,_loc19_.getStateById(_loc17_).imageData);
                  }
                  continue;
               case EffectAsset.XML_NODE_NAME:
                  _loc20_ = _loc7_.getEffectThumbById(_loc6_);
                  this.console.putData(_loc20_.theme.id + ".effect." + _loc20_.id,ByteArray(_loc20_.imageData));
                  continue;
               default:
                  continue;
            }
         }
      }
      
      private function addBubble(param1:String, param2:BubbleAsset) : void
      {
         this._bubbles.push(param1,param2);
         Console.getConsole().effectTray.addBubble(param1,param2.thumb.name);
         this.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      private function onAssetMouseDown(param1:AssetEvent) : void
      {
         var _loc2_:Asset = param1.asset;
         if(Console.getConsole().isTutorialOn && !(_loc2_ is Character))
         {
            return;
         }
         if(_loc2_)
         {
            if(param1.shiftKey)
            {
               if(this._assetGroup.isInGroup(_loc2_))
               {
                  this._assetGroup.removeAsset(_loc2_);
               }
               else
               {
                  this._assetGroup.addAsset(_loc2_);
               }
            }
            else
            {
               if(!this._assetGroup.isInGroup(_loc2_))
               {
                  this._assetGroup.clearGroup();
                  this._assetGroup.addAsset(_loc2_);
               }
               this._assetGroup.startDraggingGroup();
            }
         }
      }
      
      private function onAssetMouseUp(param1:AssetEvent) : void
      {
      }
      
      public function sendBackward(param1:Asset = null) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         if(param1 == null)
         {
            param1 = this.selectedAsset;
         }
         var _loc2_:int = this._characters.length + this._bubbles.length + this._props.length;
         if(param1 != null && _loc2_ > 1 && !(param1 is Background || param1 is EffectAsset))
         {
            _loc3_ = this.canvas.getChildIndex(param1.bundle);
            _loc5_ = _loc4_ = 1;
            _loc6_ = 0;
            _loc6_ = 0;
            while(_loc6_ < this.canvas.numChildren)
            {
               _loc7_ = this.canvas.getChildAt(_loc6_);
               _loc8_ = this.canvas.getChildIndex(_loc7_);
               if(param1.bundle.hitTestObject(_loc7_) && this.canvas.getChildIndex(param1.bundle) > _loc8_ && _loc7_ is Image)
               {
                  if(_loc8_ > _loc5_)
                  {
                     _loc5_ = _loc8_;
                     _loc9_ = this.getCloneableAssetIndex(Image(_loc7_).id);
                  }
               }
               _loc6_++;
            }
            if(_loc3_ > _loc5_)
            {
               this.canvas.removeChild(param1.bundle);
               this.canvas.addChildAt(param1.bundle,_loc5_);
               _loc10_ = this.getCloeableAssetInfo(param1.id);
               this.removeCloneableAssetInfo(param1.id);
               this.addCloneableAssetInfo(param1.id,_loc10_,_loc9_);
               return true;
            }
         }
         return false;
      }
      
      private function addProp(param1:String, param2:Prop) : void
      {
         this._props.push(param1,param2);
      }
      
      private function onCallLaterHandler() : void
      {
         trace("animescene calllater called:" + this);
         Console.getConsole().setCurrentScene(Console.getConsole().getSceneIndex(this));
         this.changed = true;
      }
      
      private function indentAsset(param1:XML) : XML
      {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc2_:Boolean = false;
         var _loc3_:Array = null;
         do
         {
            _loc5_ = param1.name();
            _loc2_ = false;
            if(_loc5_ == Character.XML_NODE_NAME)
            {
               _loc4_ = 0;
               while(_loc4_ < this._characters.length)
               {
                  _loc6_ = Character(this._characters.getValueByIndex(_loc4_));
                  if(param1.children() == XML(_loc6_.serialize()).children())
                  {
                     _loc2_ = true;
                  }
                  _loc4_++;
               }
            }
            else if(_loc5_ == BubbleAsset.XML_NODE_NAME)
            {
               _loc7_ = 0;
               while(_loc7_ < this._bubbles.length)
               {
                  if(param1.children() == XML(BubbleAsset(this._bubbles.getValueByIndex(_loc7_)).serialize()).children())
                  {
                     _loc2_ = true;
                  }
                  _loc7_++;
               }
            }
            else if(_loc5_ == Prop.XML_NODE_NAME)
            {
               _loc8_ = 0;
               while(_loc8_ < this._props.length)
               {
                  _loc9_ = Prop(this._props.getValueByIndex(_loc8_));
                  if(param1.children() == XML(_loc9_.serialize()).children())
                  {
                     _loc2_ = true;
                  }
                  _loc8_++;
               }
            }
            if(_loc2_)
            {
               _loc3_ = String(param1.child("x")[0]).split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc3_[_loc4_] = Number(_loc3_[_loc4_]) + 10;
                  _loc4_++;
               }
               param1.child("x")[0] = _loc3_.toString();
               _loc3_ = String(param1.child("y")[0]).split(",");
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc3_[_loc4_] = Number(_loc3_[_loc4_]) + 10;
                  _loc4_++;
               }
               param1.child("y")[0] = _loc3_.toString();
            }
         }
         while(_loc2_);
         
         return param1;
      }
      
      private function removeAllAttachedProps() : void
      {
         var _loc2_:Prop = null;
         var _loc1_:int = this._props.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = Prop(this._props.getValueByIndex(_loc1_));
            if(_loc2_.attachedBg)
            {
               this.removeAsset(_loc2_);
               _loc2_.deleteAsset(false);
            }
            _loc1_--;
         }
      }
      
      public function deserializeAsset(param1:XML, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true, param5:UtilLoadMgr = null) : void
      {
         var _loc7_:Background = null;
         var _loc8_:Character = null;
         var _loc9_:BubbleAsset = null;
         var _loc10_:Prop = null;
         var _loc11_:EffectAsset = null;
         var _loc6_:String = param1.name();
         switch(_loc6_)
         {
            case Background.XML_NODE_NAME:
               (_loc7_ = new Background(param1.@id)).capScreenLock = this.console.capScreenLock;
               if(param5 != null)
               {
                  param5.addEventDispatcher(_loc7_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  param5.addEventDispatcher(_loc7_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
               }
               _loc7_.deSerialize(param1,this,param4);
               if(_loc7_.thumb != null)
               {
                  this.addAsset(_loc7_);
               }
               break;
            case Character.XML_NODE_NAME:
               (_loc8_ = new Character(!!param3?param1.@id:"")).capScreenLock = this.console.capScreenLock;
               if(!param3)
               {
                  param1 = this.indentAsset(param1);
               }
               if(param5 != null)
               {
                  param5.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  param5.addEventDispatcher(_loc8_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
               }
               _loc8_.deSerialize(param1,this,param4);
               if(_loc8_.thumb != null)
               {
                  this.addAsset(_loc8_);
               }
               break;
            case BubbleAsset.XML_NODE_NAME:
               (_loc9_ = new BubbleAsset(!!param3?param1.@id:"")).capScreenLock = this.console.capScreenLock;
               if(!param3)
               {
                  param1 = this.indentAsset(param1);
               }
               _loc9_.deSerialize(param1,this);
               this.addAsset(_loc9_);
               break;
            case Prop.XML_NODE_NAME:
               if(param1.@subtype == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
               {
                  _loc10_ = new VideoProp();
               }
               else
               {
                  _loc10_ = new Prop();
               }
               _loc10_.capScreenLock = this.console.capScreenLock;
               if(!param3 && !(_loc10_ is VideoProp))
               {
                  param1 = this.indentAsset(param1);
               }
               if(param5 != null && !(_loc10_ is VideoProp))
               {
                  param5.addEventDispatcher(_loc10_.eventDispatcher,CoreEvent.LOAD_ASSET_COMPLETE);
                  param5.addEventDispatcher(_loc10_.eventDispatcher,CoreEvent.ADD_ASSET_COMPLETE);
               }
               _loc10_.deSerialize(param1,null,this,param3,param4);
               if(!param2)
               {
                  _loc10_.attachedBg = true;
               }
               if(_loc10_.thumb != null)
               {
                  this.addAsset(_loc10_,_loc10_.attachedBg);
               }
               break;
            case EffectAsset.XML_NODE_NAME:
               if(EffectAsset.getEffectType(param1) == EffectMgr.TYPE_ANIME)
               {
                  _loc11_ = new AnimeEffectAsset(!!param3?param1.@id:null);
               }
               else
               {
                  _loc11_ = new ProgramEffectAsset(!!param3?param1.@id:null);
               }
               _loc11_.capScreenLock = this.console.capScreenLock;
               _loc11_.deSerialize(param1,this,true);
               this.addAsset(_loc11_);
         }
      }
      
      function getSceneActionLength() : Number
      {
         var _loc1_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Character = null;
         var _loc9_:AnimeSound = null;
         var _loc10_:Number = NaN;
         var _loc2_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            _loc6_ = UtilString.countWord(BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).text);
            _loc7_ = Math.floor(_loc6_ / 5) * this._DEFAULT_BUBBLE_DALEY;
            _loc2_ = _loc2_ + _loc7_;
            _loc1_++;
         }
         var _loc3_:Number = 0;
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            if((_loc8_ = this._characters.getValueByIndex(_loc1_) as Character) && _loc8_.getActionDefaultTotalFrame() > _loc3_)
            {
               _loc3_ = Math.max(_loc8_.getActionDefaultTotalFrame(),AnimeConstants.SCENE_LENGTH_DEFAULT * AnimeConstants.FRAME_PER_PIXEL);
            }
            _loc1_++;
         }
         var _loc4_:Number = UtilUnitConvert.frameToPixel(_loc3_);
         if(_loc2_ < _loc4_)
         {
            _loc2_ = _loc4_;
         }
         var _loc5_:String;
         if(_loc5_ = Console.getConsole().linkageController.getSpeechIdByScene(this))
         {
            if((_loc9_ = Console.getConsole().speechManager.getValueByKey(_loc5_)) && _loc9_.soundThumb)
            {
               _loc2_ = _loc10_ = UtilUnitConvert.secToPixel(Util.roundNum(_loc9_.soundThumb.duration / 1000));
            }
         }
         return _loc2_;
      }
      
      public function getCharacterInNextSceneById(param1:String) : Character
      {
         var _loc2_:int = this._console.getSceneIndex(this);
         var _loc3_:AnimeScene = Console.getConsole().getScene(_loc2_ + 1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getCharacterById(param1);
      }
      
      public function get changed() : Boolean
      {
         return this._changed;
      }
      
      public function playScene() : void
      {
         var _loc1_:int = 0;
         this.selectedAsset = null;
         if(this._background)
         {
            this._background.playBackground();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).playCharacter();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).playProp();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).playBubble();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).playEffect();
            _loc1_++;
         }
      }
      
      private function doDragEnter(param1:DragEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Canvas = null;
         this._isDragEnter = true;
         if(param1.dragSource.hasFormat("thumb"))
         {
            _loc2_ = param1.dragSource.dataForFormat("thumb");
            if(!(_loc2_ is PropThumb && PropThumb(_loc2_).placeable == false))
            {
               _loc3_ = Canvas(param1.target);
               DragManager.acceptDragDrop(_loc3_);
            }
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         var _loc2_:int = !!param1.shiftKey?10:1;
         if(param1.keyCode == 46)
         {
            Console.getConsole().deleteAsset();
         }
         else if(param1.keyCode == 37)
         {
            this.assetGroup.moveGroup(-_loc2_,0);
         }
         else if(param1.keyCode == 38)
         {
            this.assetGroup.moveGroup(0,-_loc2_);
         }
         else if(param1.keyCode == 39)
         {
            this.assetGroup.moveGroup(_loc2_,0);
         }
         else if(param1.keyCode == 40)
         {
            this.assetGroup.moveGroup(0,_loc2_);
         }
      }
      
      private function initialCanvas() : void
      {
         this._canvas = new Canvas();
         this._canvas.name = "AnimeScene";
         this._canvas.graphics.clear();
         this._canvas.graphics.beginFill(16777215);
         this._canvas.graphics.drawRect(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this._canvas.graphics.endFill();
         this._canvas.width = AnimeConstants.STAGE_WIDTH;
         this._canvas.height = AnimeConstants.STAGE_HEIGHT;
         this._canvas.clipContent = false;
         this._canvas.horizontalScrollPolicy = ScrollPolicy.OFF;
         this._canvas.verticalScrollPolicy = ScrollPolicy.OFF;
         this._assetGroup = new AssetGroup(this._canvas);
         if(Console.getConsole().studioType == Console.FULL_STUDIO || Console.getConsole().studioType == Console.TINY_STUDIO)
         {
            this._canvas.addEventListener(DragEvent.DRAG_EXIT,this.doDragExit);
            this._canvas.addEventListener(DragEvent.DRAG_ENTER,this.doDragEnter);
            this._canvas.addEventListener(DragEvent.DRAG_DROP,this.doDragDrop);
            this._canvas.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this._canvas.addEventListener(Event.COPY,this.onCopy);
            this._canvas.addEventListener(Event.PASTE,this.onPaste);
            this._canvas.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            this._bundle = new UIComponent();
            this._canvas.addChild(this._bundle);
            this._dashline = new UIComponent();
            this._dashline.buttonMode = true;
            this._dashline.name = "DASHLINE";
            this._canvas.addChild(this._dashline);
            Console.getConsole().stageViewStage.stage.addEventListener(MouseEvent.MOUSE_UP,this.doStageMouseUp);
            Console.getConsole().stageViewStage.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.doStageMouseDown);
         }
      }
      
      public function set console(param1:Console) : void
      {
         this._console = param1;
      }
      
      public function refreshEffectTray(param1:EffectTray = null) : void
      {
         var _loc3_:EffectAsset = null;
         var _loc4_:BubbleAsset = null;
         if(param1 == null)
         {
            param1 = Console.getConsole().effectTray;
         }
         param1.removeEventListener(EffectTrayEvent.EFFECT_PRESS,this.doEffectTrayClick);
         param1.removeEventListener(EffectTrayEvent.EFFECT_OVER,this.doEffectTrayOver);
         param1.removeEventListener(EffectTrayEvent.EFFECT_OUT,this.doEffectTrayOut);
         var _loc2_:int = 0;
         param1.reset();
         var _loc5_:String;
         if((_loc5_ = Console.getConsole().linkageController.getSpeechIdByScene(this)) != "")
         {
            param1.addSpeech(_loc5_);
         }
         _loc2_ = 0;
         while(_loc2_ < this.bubbles.length)
         {
            _loc4_ = this.bubbles.getValueByIndex(_loc2_) as BubbleAsset;
            param1.addBubble(_loc4_.id,_loc4_.thumb.name);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.effects.length)
         {
            _loc3_ = this.effects.getValueByIndex(_loc2_) as EffectAsset;
            param1.addEffect(_loc3_.id,_loc3_.getType(),_loc3_.thumb.name);
            _loc2_++;
         }
         param1.addEventListener(EffectTrayEvent.EFFECT_PRESS,this.doEffectTrayClick);
         param1.addEventListener(EffectTrayEvent.EFFECT_OVER,this.doEffectTrayOver);
         param1.addEventListener(EffectTrayEvent.EFFECT_OUT,this.doEffectTrayOut);
      }
      
      private function removeAllEffects() : void
      {
         this._effects.removeAll();
      }
      
      public function sendToFront(param1:DisplayObject, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(this.effects.length > 0)
         {
            _loc3_ = this.get1stEffectAssetZorder() - 2;
         }
         else
         {
            _loc3_ = this.canvas.numChildren - 1;
         }
         if(this.canvas.getChildAt(_loc3_) is ControlButtonBar)
         {
            _loc3_--;
         }
         if(this.canvas.getChildAt(_loc3_).name.indexOf("motionShadow") > -1)
         {
         }
         if(_loc3_ > 1)
         {
            if(this.canvas.contains(param1))
            {
               if(this.canvas.getChildIndex(param1) < _loc3_)
               {
                  this.canvas.removeChild(param1);
                  this.canvas.addChildAt(param1,_loc3_);
                  if(param1.name != "DASHLINE" && !(param1 is ControlButtonBar))
                  {
                     if(param1 is Image && !param2)
                     {
                        _loc4_ = this.getCloeableAssetInfo(Image(param1).id);
                        this.removeCloneableAssetInfo(Image(param1).id);
                        this.addCloneableAssetInfo(Image(param1).id,_loc4_);
                     }
                  }
               }
            }
         }
      }
      
      private function removeAllCharacters() : void
      {
         this._characters.removeAll();
      }
      
      private function addCloneableAssetInfo(param1:String, param2:String, param3:int = -1) : void
      {
         var _loc4_:UtilHashArray = null;
         if(param3 == -1)
         {
            this._cloneableAssetsInfo.push(param1,param2);
         }
         else
         {
            (_loc4_ = new UtilHashArray()).push(param1,param2);
            this._cloneableAssetsInfo.insert(param3,_loc4_);
         }
      }
      
      public function set eventDispatcher(param1:EventDispatcher) : void
      {
         this._eventDispatcher = param1;
      }
      
      public function get preselectAssetId() : String
      {
         return this._preselectAssetId;
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this.setFocus();
      }
      
      private function doCreateAsset(param1:Thumb, param2:Number = 0, param3:Number = 0, param4:String = "", param5:Boolean = false) : void
      {
         var _loc6_:ICommand = null;
         if(param1 is CharThumb)
         {
            if(this._characters.length >= FeatureManager.maxCharacterPerScene)
            {
               Console.getConsole().alert(UtilDict.toDisplay("go","At this time, each scene may only have a maximum of 3 characters."));
               return;
            }
         }
         if(!(param1 is SoundThumb))
         {
            (_loc6_ = new AddAssetCommand()).execute();
         }
         this.createAsset(param1,param2,param3,param4,param5);
      }
      
      private function isEffectTypeExist(param1:String) : Boolean
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getType() == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function removeBackground() : void
      {
         if(this.background != null)
         {
            UtilPlain.stopFamily(this.background.bundle);
            this.background.stopMusic(true);
         }
         this._background = null;
      }
      
      public function doSpeechMenuClick(param1:MenuEvent) : void
      {
         var _loc5_:AnimeSound = null;
         var _loc6_:Asset = null;
         var _loc7_:RemoveSpeechCommand = null;
         var _loc8_:int = 0;
         var _loc9_:Character = null;
         var _loc10_:Boolean = false;
         var _loc11_:EffectAsset = null;
         var _loc2_:XML = XML(param1.item);
         var _loc3_:String = Console.getConsole().linkageController.getSpeechIdByScene(this);
         var _loc4_:String = Console.getConsole().linkageController.getCharIdOfSpeech(_loc3_);
         if(_loc2_.attribute("value").toString() == "play")
         {
            (_loc5_ = Console.getConsole().speechManager.getValueByKey(_loc3_)).playSound();
         }
         else if(_loc2_.attribute("value").toString() == EffectAsset.MENU_LABEL_EDIT)
         {
            _loc6_ = this.getCharacterById(_loc4_.split(AssetLinkage.LINK)[1]);
            this.selectedAsset = _loc6_;
            this.assetGroup.showControl();
            Console.getConsole().propertiesWindow.showSpeechPanel();
         }
         else if(_loc2_.attribute("value").toString() == EffectAsset.MENU_LABEL_DELETE)
         {
            (_loc7_ = new RemoveSpeechCommand(Console.getConsole().speechManager.getValueByKey(_loc3_) as AnimeSound,_loc4_)).execute();
            Console.getConsole().speechManager.removeSoundById(_loc3_);
            _loc8_ = this.effects.length - 1;
            while(_loc8_ >= 0)
            {
               if((_loc11_ = this.effects.getValueByIndex(_loc8_) as EffectAsset).fromSpeech)
               {
                  _loc11_.deleteAsset();
               }
               _loc8_--;
            }
            this.refreshEffectTray(Console.getConsole().effectTray);
            if(_loc10_ = (_loc9_ = this.getCharacterById(_loc4_.split(AssetLinkage.LINK)[1])).restoreActionFromTalk())
            {
               this.doUpdateTimelineLength(-1,true);
            }
            this.selectedAsset = null;
         }
      }
      
      public function set sceneXML(param1:XML) : void
      {
         this._sceneXML = param1;
      }
      
      public function stopScene() : void
      {
         var _loc1_:int = 0;
         this.selectedAsset = null;
         if(this._background != null)
         {
            this._background.stopBackground();
         }
         _loc1_ = 0;
         while(_loc1_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc1_)).stopCharacter();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).stopProp();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._bubbles.length)
         {
            BubbleAsset(this._bubbles.getValueByIndex(_loc1_)).stopBubble();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc1_)).stopEffect();
            _loc1_++;
         }
      }
      
      private function getFacingFromThemeXMLByThumbId(param1:XML, param2:String) : String
      {
         var charXML:XML = null;
         var themeXML:XML = param1;
         var thumbId:String = param2;
         try
         {
            charXML = themeXML.char.(@id == thumbId)[0];
            if(charXML != null)
            {
               return charXML.@facing;
            }
         }
         catch(e:Error)
         {
            trace(e.message);
         }
         return AnimeConstants.FACING_UNKNOW;
      }
      
      public function bringForward(param1:Asset = null) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         if(param1 == null)
         {
            param1 = this.selectedAsset;
         }
         var _loc2_:int = this._characters.length + this._bubbles.length + this._props.length + this._effects.length;
         if(param1 != null && _loc2_ > 1 && !(param1 is Background || param1 is EffectAsset))
         {
            _loc3_ = this.canvas.getChildIndex(param1.bundle);
            if(this.effects.length > 0)
            {
               _loc4_ = this.get1stEffectAssetZorder() - 1;
            }
            else
            {
               _loc4_ = this.canvas.numChildren - 1;
            }
            if(this.canvas.getChildIndex(this._dashline) > 2)
            {
               _loc4_ = Math.min(_loc4_,this.canvas.getChildIndex(this._dashline) - 1);
            }
            _loc5_ = _loc4_;
            _loc6_ = 0;
            _loc9_ = -1;
            _loc6_ = 0;
            while(_loc6_ < this.canvas.numChildren)
            {
               _loc7_ = this.canvas.getChildAt(_loc6_);
               _loc8_ = this.canvas.getChildIndex(_loc7_);
               if(param1.bundle.hitTestObject(_loc7_) && this.canvas.getChildIndex(param1.bundle) < _loc8_ && _loc7_ is Image)
               {
                  if(_loc8_ < _loc5_)
                  {
                     _loc5_ = _loc8_;
                     _loc9_ = this.getCloneableAssetIndex(Image(_loc7_).id);
                  }
               }
               _loc6_++;
            }
            if(_loc3_ < _loc5_)
            {
               this.canvas.removeChild(param1.bundle);
               this.canvas.addChildAt(param1.bundle,_loc5_);
               _loc10_ = this.getCloeableAssetInfo(param1.id);
               this.removeCloneableAssetInfo(param1.id);
               this.addCloneableAssetInfo(param1.id,_loc10_,_loc9_);
               return true;
            }
         }
         return false;
      }
      
      public function doUpdateTimelineLength(param1:Number = -1, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc3_:int = Console.getConsole().getSceneIndex(this);
         if(_loc3_ != -1)
         {
            _loc4_ = 0;
            _loc4_ = AnimeConstants.SCENE_LENGTH_DEFAULT;
            _loc5_ = this.getSceneActionLength();
            if(param1 == -1)
            {
               if(_loc5_ != 0)
               {
                  _loc4_ = _loc5_;
               }
            }
            else
            {
               _loc4_ = param1;
            }
            Console.getConsole().timeline.sceneLengthController.doSystemUpdateSceneLength(_loc4_,this.userLockedTime,_loc3_,param2);
         }
      }
      
      public function getLength(param1:int = -1, param2:Boolean = true) : Number
      {
         if(param1 < 0)
         {
            param1 = Console.getConsole().getSceneIndex(this);
         }
         return UtilUnitConvert.pixelToFrame(this._console.timeline.getSceneInfoByIndex(param1).actionPixel,param2);
      }
      
      public function addAsset(param1:Asset, param2:Boolean = false) : void
      {
         var onAddedHandler:Function = null;
         var onAddedBGSoundHandler:Function = null;
         var j:int = 0;
         var loadMgr:UtilLoadMgr = null;
         var needToLoad:Boolean = false;
         var extraData:Object = null;
         var assetThemeId:String = null;
         var assetTheme:Theme = null;
         var bgUsedThumbs:UtilHashArray = null;
         var curThumb:Thumb = null;
         var k:Number = NaN;
         var i:int = 0;
         var state:State = null;
         var onAddedCharSoundHandler:Function = null;
         var randomText:String = null;
         var _fontMgr:FontManager = null;
         var onAddedPropSoundHandler:Function = null;
         var onAddedPropHandler:Function = null;
         var onAddedEffectSoundHandler:Function = null;
         var needAdd:Boolean = false;
         var programEffAsset:ProgramEffectAsset = null;
         var onAddedZoomEffectHandler:Function = null;
         var asset:Asset = param1;
         var forceAtBottom:Boolean = param2;
         if(asset is Background)
         {
            onAddedBGSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute?Number(0):Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedBGSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedBGSoundHandler);
            if(asset.thumb.xml == null)
            {
               if(this._background != null)
               {
                  this._background.hideControl();
                  this._canvas.removeChild(this._background.bundle);
                  this.removeAsset(this._background);
               }
               this._afterComBgAsset = new Array();
               j = 0;
               while(j < this._canvas.numChildren)
               {
                  if(this._canvas.getChildAt(j).name != "DASHLINE" && !(this._canvas.getChildAt(j) is ControlButtonBar))
                  {
                     this._afterComBgAsset.push(this._canvas.getChildAt(j));
                  }
                  j++;
               }
               this._background = Background(asset);
               this.addCloneableAssetInfo(asset.id,"background");
               onAddedHandler = function(param1:Event):void
               {
                  if(Background(asset).customColor.length > 0)
                  {
                     Background(asset).updateColor();
                  }
                  else if(asset.defaultColorSet != null && asset.defaultColorSet.length > 0)
                  {
                     Background(asset).customColor = asset.defaultColorSet.clone();
                     Background(asset).updateColor();
                  }
                  Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.BG_ADDED,this));
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
                  param1.currentTarget.removeEventListener(Event.ADDED,onAddedHandler);
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
               this._canvas.addChildAt(this._background.bundle,this.BACKGROUND_INDEX);
            }
            else if(asset.thumb.xml != null)
            {
               loadMgr = new UtilLoadMgr();
               needToLoad = false;
               extraData = new Object();
               assetThemeId = asset.thumb.theme.id;
               assetTheme = Console.getConsole().getTheme(assetThemeId);
               extraData["xml"] = asset.thumb.xml;
               extraData["removeAll"] = "false";
               loadMgr.setExtraData(extraData);
               loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doDeserialize);
               bgUsedThumbs = new UtilHashArray();
               bgUsedThumbs = asset.thumb.theme.doOutputThumbs(asset.thumb.xml);
               k = 0;
               k = 0;
               while(k < bgUsedThumbs.length)
               {
                  curThumb = bgUsedThumbs.getValueByIndex(k);
                  if(curThumb is BackgroundThumb && !BackgroundThumb(curThumb).isThumbReady())
                  {
                     needToLoad = true;
                     loadMgr.addEventDispatcher(curThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                     curThumb.loadImageData();
                  }
                  else if(curThumb is PropThumb)
                  {
                     if(PropThumb(curThumb).states.length > 0)
                     {
                        i = 0;
                        while(i < PropThumb(curThumb).states.length)
                        {
                           state = PropThumb(curThumb).states[i];
                           if(state.imageData == null && asset.thumb.theme.isStateExists(asset.thumb.xml,state))
                           {
                              needToLoad = true;
                              loadMgr.addEventDispatcher(state,CoreEvent.LOAD_STATE_COMPLETE);
                              PropThumb(curThumb).loadState(state);
                           }
                           i++;
                        }
                     }
                     else if(curThumb.imageData == null)
                     {
                        needToLoad = true;
                        loadMgr.addEventDispatcher(curThumb.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
                        curThumb.loadImageData();
                     }
                  }
                  k++;
               }
               if(needToLoad)
               {
                  loadMgr.commit();
               }
               if(!needToLoad)
               {
                  this.deSerialize(asset.thumb.xml,false,true,false);
               }
            }
         }
         else if(asset is Character)
         {
            onAddedCharSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute?Number(0):Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedCharSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedCharSoundHandler);
            this.addCharacter(asset.id,Character(asset));
            this.addCloneableAssetInfo(asset.id,"char");
            asset.bundle.buttonMode = true;
            if(Character(asset).fromTray)
            {
               onAddedHandler = function(param1:Event):void
               {
                  trace("on added: thumb.isCC:" + asset.thumb.isCC);
                  if(asset.defaultColorSet != null && asset.defaultColorSet.length > 0 && !asset.thumb.isCC)
                  {
                     Character(asset).customColor = asset.defaultColorSet.clone();
                     trace("on Added, update color");
                     Character(asset).updateColor();
                  }
                  doUpdateTimelineLength();
                  Console.getConsole().dispatchTutorialEvent(new TutorialEvent(TutorialEvent.CHARACTER_ADDED,asset));
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
                  param1.currentTarget.removeEventListener(Event.ADDED,onAddedHandler);
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
            }
            else
            {
               onAddedHandler = function(param1:Event):void
               {
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
            }
            if(this.effects.length > 0)
            {
               this._canvas.addChildAt(asset.bundle,this.get1stEffectAssetZorder());
            }
            else
            {
               this._canvas.addChild(asset.bundle);
            }
         }
         else if(asset is BubbleAsset)
         {
            if((asset as BubbleAsset).fromTray)
            {
               randomText = PresetMsg.getInstance().getRandomMsg(Console.getConsole().thumbTray.getCurrentThemeId());
               if(randomText != "" && randomText != null)
               {
                  (asset as BubbleAsset).text = randomText;
                  (asset as BubbleAsset).bubble.backupText = randomText;
               }
               _fontMgr = FontManager.getFontManager();
               if(!_fontMgr.isFontLoaded((asset as BubbleAsset).bubble.textFont) && (asset as BubbleAsset).bubble.textEmbed == true)
               {
                  _fontMgr.loadFont((asset as BubbleAsset).bubble.textFont,(asset as BubbleAsset).bubble.addedToStageHandler);
               }
               if(Console.getConsole().stageScale > 1 && Console.getConsole().mainStage.isCameraMode)
               {
                  (asset as BubbleAsset).setSize(1 / Console.getConsole().stageScale);
               }
            }
            this.addBubble(asset.id,BubbleAsset(asset));
            if(BubbleAsset(asset).bubble.type == BubbleMgr.BLANK)
            {
               this.addCloneableAssetInfo(asset.id,"bubble");
            }
            if(this.effects.length > 0)
            {
               this._canvas.addChildAt(asset.bundle,this.get1stEffectAssetZorder());
            }
            else
            {
               this._canvas.addChild(asset.bundle);
            }
            asset.bundle.buttonMode = true;
            BubbleAsset(asset).bubble.buttonMode = true;
            if(asset.isLoadded)
            {
            }
            asset.isLoadded = false;
            if((asset as BubbleAsset).fromTray)
            {
               this.selectedAsset = asset;
               this.assetGroup.showControl();
            }
         }
         else if(asset is Prop)
         {
            if(asset is VideoProp && this.isVideoTypeExist())
            {
               this.deleteAllVideos();
            }
            onAddedPropSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute?Number(0):Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedPropSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedPropSoundHandler);
            asset.bundle.buttonMode = true;
            if(Prop(asset).fromTray)
            {
               onAddedPropHandler = function(param1:Event):void
               {
                  if(Console.getConsole().soundMute == false)
                  {
                     asset.playMusic();
                  }
                  if(asset.defaultColorSet != null && asset.defaultColorSet.length > 0)
                  {
                     Prop(asset).customColor = asset.defaultColorSet.clone();
                     Prop(asset).updateColor();
                  }
                  doUpdateTimelineLength();
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
                  param1.currentTarget.removeEventListener(Event.ADDED,onAddedPropHandler);
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedPropHandler);
            }
            else
            {
               onAddedHandler = function(param1:Event):void
               {
                  asset.dispatchEvent(new CoreEvent(CoreEvent.ADD_ASSET_COMPLETE,asset));
               };
               asset.bundle.addEventListener(Event.ADDED,onAddedHandler);
            }
            if(Prop(asset).attachedBg && forceAtBottom)
            {
               this.addProp(asset.id,Prop(asset));
               this.addCloneableAssetInfo(asset.id,"prop",0);
               this._canvas.addChildAt(asset.bundle,this.BACKGROUND_INDEX + 1);
            }
            else
            {
               this.addProp(asset.id,Prop(asset));
               this.addCloneableAssetInfo(asset.id,"prop");
               if(this.effects.length > 0)
               {
                  this._canvas.addChildAt(asset.bundle,this.get1stEffectAssetZorder());
               }
               else
               {
                  this._canvas.addChild(asset.bundle);
               }
            }
            if(asset.isLoadded)
            {
            }
            asset.isLoadded = false;
         }
         else if(asset is EffectAsset)
         {
            onAddedEffectSoundHandler = function(param1:Event):void
            {
               if(asset.isMusicPlaying)
               {
                  asset.muteSound(Console.getConsole().soundMute);
               }
               else
               {
                  asset.playMusic(0,0,new SoundTransform(!!Console.getConsole().soundMute?Number(0):Number(1)));
               }
               asset.removeEventListener("SoundAdded",onAddedEffectSoundHandler);
            };
            asset.addEventListener("SoundAdded",onAddedEffectSoundHandler);
            if(asset is AnimeEffectAsset)
            {
               needAdd = true;
            }
            else
            {
               programEffAsset = asset as ProgramEffectAsset;
               if(this.isProgramEffectTypeExist(programEffAsset.getExactType()))
               {
                  needAdd = false;
               }
               else
               {
                  needAdd = true;
               }
               if(programEffAsset.getExactType() == EffectThumb.TYPE_ZOOM)
               {
                  programEffAsset.needControl = true;
                  if(!needAdd)
                  {
                     if(!Console.getConsole().mainStage.isCameraMode)
                     {
                        EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)).deleteAsset(false);
                        needAdd = true;
                     }
                  }
               }
               if(programEffAsset.getExactType() == EffectThumb.TYPE_FADING)
               {
                  if(!needAdd)
                  {
                     EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_FADING)).deleteAsset(false);
                     needAdd = true;
                  }
               }
            }
            if(needAdd)
            {
               this.addEffect(asset.id,EffectAsset(asset));
               this._canvas.addChild(asset.bundle);
               if(EffectAsset(asset).effect is ZoomEffect)
               {
                  asset.bundle.buttonMode = true;
                  EffectAsset(asset).effect.buttonMode = true;
                  this._sizingAsset = asset;
                  if(EffectAsset(asset).fromTray)
                  {
                     onAddedZoomEffectHandler = function(param1:Event):void
                     {
                        EffectAsset(asset).refreshMotionShadow();
                        param1.currentTarget.removeEventListener(Event.ADDED,onAddedZoomEffectHandler);
                     };
                     asset.bundle.addEventListener(Event.ADDED,onAddedZoomEffectHandler);
                  }
               }
            }
            this.addCloneableAssetInfo(asset.id,"effect");
         }
         if(Console.getConsole().studioType == Console.FULL_STUDIO || Console.getConsole().studioType == Console.TINY_STUDIO || Console.getConsole().studioType == Console.MESSAGE_STUDIO)
         {
            if(asset != null)
            {
               asset.melt();
               if(Console.getConsole().studioType != Console.MESSAGE_STUDIO)
               {
                  asset.addEventListener(AssetEvent.MOUSE_DOWN_ASSET,this.onAssetMouseDown);
                  asset.addEventListener(AssetEvent.MOUSE_UP_ASSET,this.onAssetMouseUp);
                  asset.addEventListener(AssetEvent.ROLL_OVER_ASSET,this.onAssetRollOver);
                  asset.addEventListener(AssetEvent.ROLL_OUT_ASSET,this.onAssetRollOut);
               }
            }
         }
         if(!Console.getConsole().isTutorialOn)
         {
         }
         this.sendToFront(this.dashline);
         this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_ADDED));
      }
      
      public function serialize(param1:int = -1, param2:Boolean = true) : String
      {
         var adelay:Number = NaN;
         var i:int = 0;
         var j:int = 0;
         var k:int = 0;
         var effectAsset:EffectAsset = null;
         var m:int = 0;
         var char:Character = null;
         var charData:UtilHashArray = null;
         var char_i:int = 0;
         var prop:Prop = null;
         var propData:UtilHashArray = null;
         var prop_i:int = 0;
         var logger:UtilErrorLogger = null;
         var index:int = param1;
         var stockdata:Boolean = param2;
         var xmlStr:String = "";
         try
         {
            if(index < 0)
            {
               index = Console.getConsole().getSceneIndex(this);
            }
            adelay = this.getLength(index,false);
            if(this.sceneXML != null)
            {
               if(stockdata)
               {
                  this.putDataBySceneXML(this.sceneXML);
               }
               this.sceneXML.@index = index;
               return this.sceneXML.toString();
            }
            xmlStr = "<scene id=\"" + this._id + "\" adelay=\"" + Util.roundNum(adelay) + "\" lock=\"" + (this.userLockedTime >= 0?"Y":"N") + "\" index=\"" + index + "\" " + ">";
            if(this._background != null)
            {
               xmlStr = xmlStr + this._background.serialize();
               if(stockdata)
               {
                  this.console.putData(this._background.thumb.theme.id + ".bg." + this._background.thumb.id,ByteArray(this._background.thumb.imageData));
               }
            }
            i = 0;
            while(i < this._characters.length)
            {
               char = Character(this._characters.getValueByIndex(i));
               xmlStr = xmlStr + char.serialize();
               if(stockdata)
               {
                  charData = char.getDataAndKey();
                  char_i = 0;
                  while(char_i < charData.length)
                  {
                     this.console.putData(charData.getKey(char_i),charData.getValueByIndex(char_i));
                     char_i++;
                  }
               }
               i++;
            }
            j = 0;
            while(j < this._bubbles.length)
            {
               xmlStr = xmlStr + BubbleAsset(this._bubbles.getValueByIndex(j)).serialize();
               j++;
            }
            k = 0;
            while(k < this._props.length)
            {
               prop = Prop(this._props.getValueByIndex(k));
               xmlStr = xmlStr + prop.serialize();
               if(stockdata)
               {
                  if(PropThumb(prop.thumb).getStateNum() == 0)
                  {
                     this.console.putData(prop.thumb.theme.id + ".prop." + prop.thumb.id,ByteArray(prop.thumb.imageData));
                  }
                  else
                  {
                     propData = prop.getDataAndKey();
                     prop_i = 0;
                     while(prop_i < propData.length)
                     {
                        this.console.putData(propData.getKey(prop_i),propData.getValueByIndex(prop_i));
                        prop_i++;
                     }
                  }
               }
               k++;
            }
            m = 0;
            while(m < this._effects.length)
            {
               effectAsset = this._effects.getValueByIndex(m) as EffectAsset;
               xmlStr = xmlStr + effectAsset.serialize();
               if(stockdata)
               {
                  this.console.putData(effectAsset.thumb.theme.id + ".effect." + effectAsset.thumb.id,effectAsset.thumb.imageData as ByteArray);
               }
               m++;
            }
            xmlStr = xmlStr + "</scene>";
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("AnimeScene::serialize()",e);
            trace("Serialize " + _id + " failed: " + e);
         }
         return xmlStr;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function onDeserializeAndAddComplete(param1:LoadMgrEvent) : void
      {
         var _loc2_:Object = UtilLoadMgr(param1.currentTarget).getExtraData();
         var _loc3_:Boolean = _loc2_["unloadAfterFinish"];
         var _loc4_:Boolean = _loc2_["doLoadBytes"];
         this.bringUpAsset();
         setTimeout(this.dispatchDeserializeComplete,100,_loc3_,_loc4_);
         trace("###################################### Deserialize Complete:" + this.id);
      }
      
      public function removeAsset(param1:Asset) : void
      {
         if(param1 is Background)
         {
            this.removeAllAttachedProps();
            this.removeBackground();
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is Character)
         {
            this.removeCharacter(Character(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is BubbleAsset)
         {
            this.removeBubble(BubbleAsset(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is Prop)
         {
            this.removeProp(Prop(param1));
            this.removeCloneableAssetInfo(param1.id);
         }
         else if(param1 is EffectAsset)
         {
            this.removeEffect(EffectAsset(param1));
         }
         param1.removeEventListener(AssetEvent.MOUSE_DOWN_ASSET,this.onAssetMouseDown);
         param1.removeEventListener(AssetEvent.MOUSE_UP_ASSET,this.onAssetMouseUp);
         param1.removeEventListener(AssetEvent.ROLL_OVER_ASSET,this.onAssetRollOver);
         param1.removeEventListener(AssetEvent.ROLL_OUT_ASSET,this.onAssetRollOut);
         this.dispatchEvent(new SceneEvent(SceneEvent.ASSET_REMOVED));
      }
      
      public function getCharacterById(param1:String) : Character
      {
         return Character(this._characters.getValueByKey(param1));
      }
      
      public function get sceneXML() : XML
      {
         return this._sceneXML;
      }
      
      private function doEffectTrayOut(param1:EffectTrayEvent) : void
      {
         var _loc2_:Asset = this.getAssetById(param1.id);
         if(_loc2_)
         {
            _loc2_.hideControl();
         }
      }
      
      public function removeSound() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._props.length)
         {
            Prop(this._props.getValueByIndex(_loc1_)).stopMusic(true);
            _loc1_++;
         }
         if(this.background != null)
         {
            this.background.stopMusic(true);
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._characters.length)
         {
            Character(this._characters.getValueByIndex(_loc2_)).stopMusic(true);
            _loc2_++;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this._effects.length)
         {
            EffectAsset(this._effects.getValueByIndex(_loc3_)).stopMusic(true);
            _loc3_++;
         }
      }
      
      private function removeAllProps() : void
      {
         this._props.removeAll();
      }
      
      private function onCopy(param1:Event) : void
      {
         Console.getConsole().copyAsset();
      }
      
      private function deleteAllVideos() : void
      {
         var _loc1_:Prop = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.props.length)
         {
            _loc1_ = this.props.getValueByIndex(_loc2_) as Prop;
            if(_loc1_ is VideoProp)
            {
               _loc1_.deleteAsset();
               this.removeAsset(_loc1_);
            }
            _loc2_++;
         }
      }
      
      public function pasteAssets(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc2_:Number = 0;
         for each(_loc3_ in param1)
         {
            if(XML(_loc3_).name().toString() == "char")
            {
               _loc2_++;
            }
         }
         if(this._characters.length + _loc2_ > FeatureManager.maxCharacterPerScene)
         {
            Console.getConsole().alert(UtilDict.toDisplay("go","At this time, each scene may only have a maximum of 3 characters."));
            return;
         }
         var _loc4_:ICommand;
         (_loc4_ = new AddAssetCommand()).execute();
         for each(_loc5_ in param1)
         {
            this.deserializeAsset(XML(_loc5_),true,false);
         }
      }
      
      public function get1stEffectAssetZorder() : int
      {
         var _loc1_:EffectAsset = null;
         var _loc4_:int = 0;
         var _loc2_:int = int.MAX_VALUE;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc1_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if((_loc4_ = this._canvas.getChildIndex(_loc1_.bundle)) < _loc2_)
            {
               _loc2_ = _loc4_;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onLoadAllAssetsComplete(param1:Event) : void
      {
         this.console.capScreenLock = false;
         this.eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ALL_ASSETS_COMPLETE,this));
         var _loc2_:UtilLoadMgr = param1.target as UtilLoadMgr;
         var _loc3_:Date = _loc2_.getExtraData() as Date;
         var _loc4_:Date = new Date();
         this.refreshEffectTray(Console.getConsole().effectTray);
      }
      
      private function isProgramEffectTypeExist(param1:String) : Boolean
      {
         var _loc2_:EffectAsset = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.effects.length)
         {
            _loc2_ = this.effects.getValueByIndex(_loc3_) as EffectAsset;
            if(_loc2_.getExactType() == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      private function removeCloneableAssetInfo(param1:String) : void
      {
         var _loc2_:int = this._cloneableAssetsInfo.getIndex(param1);
         if(_loc2_ != -1)
         {
            this._cloneableAssetsInfo.remove(_loc2_,1);
         }
      }
      
      private function onPaste(param1:Event) : void
      {
         Console.getConsole().pasteAsset();
      }
      
      private function getAssetId(param1:Thumb) : AssetLocation
      {
         var _loc5_:int = 0;
         var _loc6_:UtilHashArray = null;
         var _loc7_:Asset = null;
         var _loc8_:UtilHashArray = null;
         var _loc9_:Asset = null;
         var _loc10_:UtilHashArray = null;
         var _loc11_:Prop = null;
         var _loc12_:UtilHashArray = null;
         var _loc13_:Prop = null;
         var _loc14_:UtilHashArray = null;
         var _loc15_:EffectAsset = null;
         var _loc2_:String = param1.id;
         var _loc3_:AnimeScene = Console.getConsole().movie.getPrevScene(this);
         var _loc4_:AnimeScene = Console.getConsole().movie.getNextScene(this);
         if(param1 is CharThumb)
         {
            if(_loc3_ != null)
            {
               _loc6_ = _loc3_.characters;
               _loc5_ = 0;
               while(_loc5_ < _loc6_.length)
               {
                  _loc7_ = _loc6_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc7_.thumb.id)
                  {
                     if(this.getAssetById(_loc7_.id) == null)
                     {
                        return new AssetLocation(_loc7_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
            if(_loc4_ != null)
            {
               _loc8_ = _loc4_.characters;
               _loc5_ = 0;
               while(_loc5_ < _loc8_.length)
               {
                  _loc9_ = _loc8_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc9_.thumb.id)
                  {
                     if(this.getAssetById(_loc9_.id) == null)
                     {
                        return new AssetLocation(_loc9_.id,_loc4_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         else if(param1 is PropThumb)
         {
            if(_loc3_ != null)
            {
               _loc10_ = _loc3_.props;
               _loc5_ = 0;
               while(_loc5_ < _loc10_.length)
               {
                  _loc11_ = _loc10_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc11_.thumb.id)
                  {
                     if(this.getAssetById(_loc11_.id) == null)
                     {
                        return new AssetLocation(_loc11_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
            if(_loc4_ != null)
            {
               _loc12_ = _loc4_.props;
               _loc5_ = 0;
               while(_loc5_ < _loc12_.length)
               {
                  _loc13_ = _loc12_.getValueByIndex(_loc5_);
                  if(_loc2_ == _loc13_.thumb.id)
                  {
                     if(this.getAssetById(_loc13_.id) == null)
                     {
                        return new AssetLocation(_loc13_.id,_loc4_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         else if(param1 is EffectThumb)
         {
            if(_loc3_ != null)
            {
               if(EffectThumb(param1).getExactType() == EffectThumb.TYPE_ZOOM && EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)) != null)
               {
                  EffectAsset(this.getEffectAssetByType(EffectThumb.TYPE_ZOOM)).deleteAsset(false);
               }
               _loc14_ = _loc3_.effects;
               _loc5_ = 0;
               while(_loc5_ < _loc14_.length)
               {
                  _loc15_ = _loc14_.getValueByIndex(_loc5_);
                  if(EffectThumb(param1).getExactType() == EffectThumb(_loc15_.thumb).getExactType())
                  {
                     if(this.getAssetById(_loc15_.id) == null)
                     {
                        return new AssetLocation(_loc15_.id,_loc3_.id);
                     }
                  }
                  _loc5_++;
               }
            }
         }
         return null;
      }
      
      private function doDragDrop(param1:DragEvent) : void
      {
         this._isDragEnter = true;
         var _loc2_:Thumb = Thumb(param1.dragSource.dataForFormat("thumb"));
         var _loc3_:String = "";
         if(param1.dragSource.hasFormat("colorSetId"))
         {
            _loc3_ = String(param1.dragSource.dataForFormat("colorSetId"));
         }
         var _loc4_:DisplayObject;
         if((_loc4_ = DisplayObject(param1.dragInitiator)).parent.parent != this._canvas)
         {
            this.doCreateAsset(_loc2_,param1.localX,param1.localY,_loc3_);
         }
      }
      
      public function dispatchDeserializeComplete(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            Console.getConsole().doUpdateTimelineByScene(this,true);
         }
         if(param1)
         {
            this.unloadAllAssets(false);
         }
         else
         {
            this.eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ALL_ASSETS_COMPLETE,this));
         }
         this.eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.DESERIALIZE_SCENE_COMPLETE,this));
      }
   }
}

class AssetLocation
{
    
   
   private var _assetId:String;
   
   private var _sceneId:String;
   
   function AssetLocation(param1:String, param2:String)
   {
      super();
      this._assetId = param1;
      this._sceneId = param2;
   }
   
   public function get sceneId() : String
   {
      return this._sceneId;
   }
   
   public function get assetId() : String
   {
      return this._assetId;
   }
}
