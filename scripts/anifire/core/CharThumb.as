package anifire.core
{
   import anifire.component.CcActionLoader;
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.CcLibConstant;
   import anifire.constant.ServerConstants;
   import anifire.managers.*;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilPlain;
   import anifire.util.UtilString;
   import anifire.util.UtilURLStream;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.errors.*;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import mx.controls.Alert;
   import mx.controls.Image;
   import mx.core.Container;
   import mx.core.DragSource;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class CharThumb extends Thumb
   {
      
      public static const XML_NODE_NAME:String = "char";
      
      private static var _logger:ILogger = Log.getLogger("core.CharThumb");
       
      
      private var _actionGroups:Array;
      
      private var _numTotalCcAction:int = 0;
      
      private var _libraries:UtilHashArray;
      
      private var _numCcAction:int = 0;
      
      private var _defaultTalkAction:Action;
      
      private var _isZipLoaded:Boolean = false;
      
      private var _motions:Array;
      
      private var _actionMenuItems:Array;
      
      private var _actions:Array;
      
      private var _ccThemeId:String;
      
      private var _defaultMotion:Motion;
      
      private var _isLoadingActionMotion:Boolean = false;
      
      private var _defaultAction:Action;
      
      private var _facials:Array;
      
      private var _tileContainer:Container = null;
      
      private var _facialMenuItems:Array;
      
      private var _facing:String = "unknown";
      
      public function CharThumb()
      {
         super();
         _logger.debug("CharThumb initialized");
         this._actions = new Array();
         this._actionGroups = new Array();
         this._motions = new Array();
         this._facials = new Array();
         this._libraries = new UtilHashArray();
         this._actionMenuItems = new Array();
         this._facialMenuItems = new Array();
      }
      
      public function getMotionNum() : int
      {
         return this.motions.length;
      }
      
      override public function loadImageData() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = new UtilURLStream();
         if(this.isCC)
         {
            _loc1_ = UtilNetwork.getGetCcActionRequest(this.id,this.defaultAction.id);
         }
         else
         {
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_CHAR_ACTION,this.defaultAction.id);
         }
         _loc2_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadImageDataFail);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadImageDataFail);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadImageDataFail);
         _loc2_.load(_loc1_);
      }
      
      public function initImageData(param1:ZipFile, param2:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:ZipEntry = null;
         var _loc7_:UtilCrypto = null;
         var _loc8_:ByteArray = null;
         var _loc9_:ZipFile = null;
         var _loc10_:ZipEntry = null;
         var _loc11_:ByteArray = null;
         var _loc12_:UtilHashArray = null;
         var _loc13_:Action = null;
         var _loc14_:Object = null;
         var _loc18_:XML = null;
         var _loc19_:Motion = null;
         var _loc20_:ByteArray = null;
         var _loc21_:ZipEntry = null;
         var _loc22_:ZipFile = null;
         var _loc23_:int = 0;
         var _loc24_:State = null;
         var _loc15_:Boolean = this.theme.id != "ugc"?true:false;
         this.deSerializeAction();
         this._numCcAction = 0;
         this._numTotalCcAction = 0;
         _loc3_ = 0;
         while(_loc3_ < this.getActionNum())
         {
            _loc13_ = this.getActionAt(_loc3_);
            _loc5_ = param2 + _loc13_.id;
            if((_loc6_ = param1.getEntry(_loc5_)) && isCC)
            {
               ++this._numTotalCcAction;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.getActionNum())
         {
            _loc13_ = this.getActionAt(_loc3_);
            _loc5_ = param2 + _loc13_.id;
            if(_loc6_ = param1.getEntry(_loc5_))
            {
               if(!isCC)
               {
                  _loc13_.imageData = param1.getInput(_loc6_);
                  if(_loc15_)
                  {
                     (_loc7_ = new UtilCrypto()).decrypt(_loc13_.imageData as ByteArray);
                  }
               }
               else if(_loc13_.id.indexOf(".zip") >= 0)
               {
                  _loc8_ = param1.getInput(_loc6_);
                  _loc9_ = new ZipFile(_loc8_);
                  _loc13_.imageData = UtilPlain.convertZipAsImagedataObject(_loc9_);
               }
               else
               {
                  _loc18_ = XML(param1.getInput(_loc6_));
                  ++this._numCcAction;
                  _loc13_.addEventListener(CoreEvent.LOAD_STATE_COMPLETE,this.onCcActionReady);
                  _loc13_.loadImageDataByXml(_loc18_);
               }
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < this.getMotionNum())
         {
            _loc19_ = this.getMotionAt(_loc3_);
            _loc5_ = param2 + _loc19_.id;
            if(_loc6_ = param1.getEntry(_loc5_))
            {
               _loc19_.imageData = param1.getInput(_loc6_);
               if(_loc15_)
               {
                  (_loc7_ = new UtilCrypto()).decrypt(_loc19_.imageData as ByteArray);
               }
            }
            _loc3_++;
         }
         var _loc16_:ZipEntry;
         if((_loc16_ = param1.getEntry(param2 + CcLibConstant.NODE_LIBRARY + ".zip")) != null)
         {
            _loc20_ = param1.getInput(_loc16_) as ByteArray;
            _loc22_ = new ZipFile(_loc20_);
            _loc23_ = 0;
            while(_loc23_ < _loc22_.size)
            {
               _loc21_ = _loc22_.entries[_loc23_];
               this.addLibrary(_loc21_.name,_loc22_.getInput(_loc21_));
               _loc23_++;
            }
         }
         var _loc17_:PropThumb;
         if((_loc17_ = theme.getPropThumbById(id + ".head")) != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc17_.states.length)
            {
               _loc24_ = _loc17_.getStateAt(_loc3_);
               _loc5_ = param2 + "head/" + _loc24_.id;
               _loc6_ = param1.getEntry(_loc5_);
               if(!isCC)
               {
                  if(_loc6_ != null)
                  {
                     _loc24_.imageData = param1.getInput(param1.getEntry(_loc5_));
                     if(_loc15_)
                     {
                        (_loc7_ = new UtilCrypto()).decrypt(_loc24_.imageData as ByteArray);
                     }
                  }
               }
               else if(_loc6_ != null)
               {
                  _loc8_ = param1.getInput(_loc6_);
                  _loc9_ = new ZipFile(_loc8_);
                  _loc24_.imageData = UtilPlain.convertZipAsImagedataObject(_loc9_);
               }
               _loc3_++;
            }
         }
         if(!isCC || this._numCcAction == 0)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
         }
      }
      
      private function onLoadImageDataFail(param1:Event) : void
      {
      }
      
      public function getMotionAt(param1:int) : Motion
      {
         return this._motions[param1];
      }
      
      private function doLoadActionsAndMotionsTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsTimeOut);
         Console.getConsole().requestLoadStatus(false);
         this._isLoadingActionMotion = false;
         Alert.show("Opeation Timeout");
      }
      
      public function set ccThemeId(param1:String) : void
      {
         this._ccThemeId = param1;
      }
      
      public function get actionMenuItems() : Array
      {
         return this._actionMenuItems;
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = null;
         var _loc3_:DragSource = null;
         var _loc4_:Image = null;
         var _loc5_:Loader = null;
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         if(purchased)
         {
            _loc2_ = Image(param1.currentTarget);
            _loc3_ = new DragSource();
            _loc3_.addData(this,"thumb");
            _loc3_.addData(param1.localX,"x");
            _loc3_.addData(param1.localY,"y");
            if(_loc2_.parent is ThumbnailCanvas)
            {
               if(ThumbnailCanvas(_loc2_.parent).colorSetId != "")
               {
                  _loc3_.addData(ThumbnailCanvas(_loc2_.parent).colorSetId,"colorSetId");
               }
            }
            _loc4_ = new Image();
            if(!this.isCC)
            {
               (_loc5_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadProxyImageComplete);
               _loc5_.loadBytes(ByteArray(this.imageData));
               _loc4_.addChild(_loc5_);
            }
            else
            {
               _loc6_ = Util.capturePicture(ThumbnailCanvas(_loc2_.parent).displayObj);
               _loc7_ = new Bitmap(_loc6_);
               _loc4_.addChild(_loc7_);
            }
            DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
            Console.getConsole().currDragSource = _loc3_;
         }
      }
      
      private function addFacialMenuItem(param1:Object) : void
      {
         if(param1 is Facial)
         {
            this._facialMenuItems.push(param1);
            this._facialMenuItems.sortOn("name",Array.CASEINSENSITIVE);
         }
      }
      
      public function onCcActionReady(param1:Event) : void
      {
         if(this._numTotalCcAction == this._numCcAction)
         {
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
         }
      }
      
      public function isSWFCharacter() : Boolean
      {
         return UtilString.hasSWFextension(this.defaultAction.id);
      }
      
      public function getFacialAt(param1:int) : Facial
      {
         return this.facials[param1] as Facial;
      }
      
      private function doLoadActionsAndMotionsIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsIOError);
         Console.getConsole().requestLoadStatus(false);
         this._isLoadingActionMotion = false;
         Alert.show("Error in loading character action",param1.type);
      }
      
      override function loadProxyImageComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadProxyImageComplete);
         var _loc2_:Loader = Loader(param1.target.loader);
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_ <= _loc6_ && _loc4_ <= _loc7_))
         {
            if(_loc3_ > _loc6_ && _loc4_ <= _loc7_)
            {
               _loc5_ = _loc6_ / _loc3_;
               _loc2_.content.width = _loc6_;
               _loc2_.content.height = _loc2_.content.height * _loc5_;
            }
            else if(_loc3_ <= _loc6_ && _loc4_ > _loc7_)
            {
               _loc5_ = _loc7_ / _loc4_;
               _loc2_.content.width = _loc2_.content.width * _loc5_;
               _loc2_.content.height = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_ / _loc3_;
               if(_loc4_ * _loc5_ > _loc7_)
               {
                  _loc5_ = _loc7_ / _loc4_;
                  _loc2_.content.width = _loc2_.content.width * _loc5_;
                  _loc2_.content.height = _loc7_;
               }
               else
               {
                  _loc2_.content.width = _loc6_;
                  _loc2_.content.height = _loc2_.content.height * _loc5_;
               }
            }
         }
         var _loc8_:Rectangle = _loc2_.getBounds(_loc2_);
         _loc2_.x = AnimeConstants.TILE_CHAR_WIDTH / 2;
         _loc2_.y = (AnimeConstants.TILE_CHAR_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.y = _loc2_.y - _loc8_.top;
         var _loc9_:DisplayObject = DisplayObject(_loc2_.content);
         UtilPlain.stopFamily(_loc9_);
      }
      
      public function getLibraryIdByIndex(param1:Number) : String
      {
         return this._libraries.getKey(param1);
      }
      
      public function getActionById(param1:String) : Action
      {
         var _loc2_:Action = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._actions.length)
         {
            if(Action(this._actions[_loc3_]).id == param1)
            {
               _loc2_ = Action(this._actions[_loc3_]);
               break;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            _loc2_ = this.createAction(param1);
         }
         return _loc2_;
      }
      
      private function onCcActionLoaded(param1:Event) : void
      {
         var _loc2_:CcActionLoader = CcActionLoader(param1.target);
         if(_loc2_.imageData)
         {
            this.imageData = _loc2_.imageData;
            this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
         }
      }
      
      public function get defaultTalkAction() : Action
      {
         var action:XML = null;
         if(!this._defaultTalkAction)
         {
            if(this.xml)
            {
               action = this.xml..action.(@id.toString().search("talk") > -1 && @id.toString().search("phone") == -1)[0];
               if(action)
               {
                  this._defaultTalkAction = this.getActionById(action.@id);
               }
            }
         }
         return this._defaultTalkAction;
      }
      
      private function getActionGroupById(param1:String) : ActionGroup
      {
         var _loc2_:ActionGroup = null;
         var _loc3_:ActionGroup = null;
         for each(_loc3_ in this._actionGroups)
         {
            if(_loc3_.name == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         if(!_loc2_)
         {
            _loc2_ = new ActionGroup(param1);
            this._actionGroups.push(_loc2_);
         }
         return _loc2_;
      }
      
      public function get facials() : Array
      {
         return this._facials;
      }
      
      public function BitmapDataToByteArray(param1:DisplayObject) : ByteArray
      {
         var _loc2_:uint = param1.width;
         var _loc3_:uint = param1.height;
         var _loc4_:BitmapData;
         (_loc4_ = new BitmapData(_loc2_,_loc3_)).draw(param1);
         var _loc5_:ByteArray;
         (_loc5_ = _loc4_.getPixels(new Rectangle(0,0,_loc2_,_loc3_))).writeShort(_loc3_);
         _loc5_.writeShort(_loc2_);
         return _loc5_;
      }
      
      public function getMotionById(param1:String) : Motion
      {
         var _loc2_:Motion = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._motions.length)
         {
            if(Motion(this._motions[_loc3_]).id == param1)
            {
               _loc2_ = Motion(this._motions[_loc3_]);
               break;
            }
            _loc3_++;
         }
         if(!_loc2_)
         {
            this.getActionById(param1);
            _loc3_ = 0;
            while(_loc3_ < this._motions.length)
            {
               if(Motion(this._motions[_loc3_]).id == param1)
               {
                  _loc2_ = Motion(this._motions[_loc3_]);
                  break;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function set defaultAction(param1:Action) : void
      {
         this._defaultAction = param1;
      }
      
      private function doLoadActionsAndMotionsCompleted(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsCompleted);
         var _loc2_:URLStream = URLStream(param1.target);
         Console.getConsole().requestLoadStatus(false);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         var _loc4_:ZipFile = new ZipFile(_loc3_);
         this.initImageData(_loc4_,this.getFolderPathInCharZip());
         this._isLoadingActionMotion = false;
         this.setIsZipLoaded(true);
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      public function get facialMenuItems() : Array
      {
         return this._facialMenuItems;
      }
      
      public function addAction(param1:Action) : void
      {
         this._actions.push(param1);
         this._actions.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      override public function loadImageDataComplete(param1:Event) : void
      {
         var _loc2_:UtilCrypto = null;
         var _loc5_:ZipFile = null;
         var _loc6_:CcActionLoader = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadImageDataComplete);
         trace("char thumb load image complete:" + this.id);
         var _loc3_:URLStream = URLStream(param1.target);
         var _loc4_:ByteArray = new ByteArray();
         _loc3_.readBytes(_loc4_,0,_loc3_.bytesAvailable);
         if(this.isCC)
         {
            if(this.id.indexOf("zip") < 0)
            {
               (_loc6_ = new CcActionLoader()).addEventListener(Event.COMPLETE,this.onCcActionLoaded);
               _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.onCcActionFailed);
               _loc6_.loadCcComponents(XML(_loc4_),0,0,null,null,this._ccThemeId == "cc2"?Number(2):Number(1));
               return;
            }
            _loc5_ = new ZipFile(_loc4_);
            this.imageData = UtilPlain.convertZipAsImagedataObject(_loc5_);
         }
         else
         {
            this.imageData = _loc4_;
            if(this.theme.id != "ugc" && !this.isCC)
            {
               _loc2_ = new UtilCrypto();
               _loc2_.decrypt(ByteArray(this.imageData));
            }
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      private function setIsZipLoaded(param1:Boolean) : void
      {
         this._isZipLoaded = param1;
      }
      
      public function getFacialById(param1:String) : Facial
      {
         var _loc2_:Facial = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._facials.length)
         {
            if(Facial(this._facials[_loc3_]).id == param1)
            {
               _loc2_ = Facial(this._facials[_loc3_]);
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function loadAction(param1:Behavior = null, param2:Boolean = false) : void
      {
         if(param1 == null)
         {
            param1 = this.defaultAction;
         }
         if(param1.imageData == null || param1.withSpeech != param2)
         {
            if(param1 is Action)
            {
               param1.loadImageData(ServerConstants.PARAM_CHAR_ACTION,param2);
            }
            else if(param1 is Facial)
            {
               param1.loadImageData(ServerConstants.PARAM_CHAR_FACIAL,param2);
            }
         }
      }
      
      public function getActionNum() : int
      {
         return this._actions.length;
      }
      
      public function set facing(param1:String) : void
      {
         this._facing = param1;
      }
      
      public function get ccThemeId() : String
      {
         return this._ccThemeId;
      }
      
      public function getIsZipLoaded() : Boolean
      {
         return this._isZipLoaded;
      }
      
      public function addMotion(param1:Motion) : void
      {
         this._motions.push(param1);
         this._motions.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      private function createAction(param1:String) : Action
      {
         var action:Action = null;
         var motion:Motion = null;
         var actionNode:XML = null;
         var propNode:XML = null;
         var parentNode:XML = null;
         var groupNode:XML = null;
         var catNode:XML = null;
         var standingNode:XML = null;
         var actionGroup:ActionGroup = null;
         var node:XML = null;
         var id:String = param1;
         if(!id)
         {
            return null;
         }
         var isMotion:Boolean = false;
         if(this.xml)
         {
            actionNode = this.xml..action.(@id == id)[0];
            if(!actionNode)
            {
               actionNode = this.xml..motion.(@id == id)[0];
               if(actionNode)
               {
                  isMotion = true;
               }
            }
            if(actionNode)
            {
               if(isMotion)
               {
                  motion = new Motion(this,actionNode.@id,actionNode.@name,actionNode.@totalframe,actionNode.@enable,actionNode.@aid);
                  motion.defaultActionId = this.xml.@§default§;
                  this.addMotion(motion);
               }
               if(actionNode.prop.length() > 0)
               {
                  propNode = actionNode.prop[0];
               }
               action = new Action(this,actionNode.@id,actionNode.@name,actionNode.@totalframe,actionNode.@enable,actionNode.@aid,propNode);
               action.defaultActionId = this.xml.@§default§;
               if(actionNode.@id == this.xml.@§default§)
               {
                  this.defaultAction = action;
               }
               if(actionNode.@next.length() > 0)
               {
                  action.nextActionId = actionNode.@next;
               }
               action.isMotion = isMotion;
               this.addAction(action);
               if(actionNode.@enable != "N")
               {
                  Console.getConsole().addStoreCollection(actionNode.@name);
                  this.addActionMenuItem(action);
               }
               parentNode = actionNode.parent();
               if(parentNode)
               {
                  if(parentNode.name().toString() == "group")
                  {
                     groupNode = parentNode;
                  }
                  else if(parentNode.name().toString() == "category")
                  {
                     catNode = parentNode;
                  }
               }
               parentNode = parentNode.parent();
               if(parentNode)
               {
                  if(parentNode.name().toString() == "group")
                  {
                     groupNode = parentNode;
                  }
                  else if(parentNode.name().toString() == "category")
                  {
                     catNode = parentNode;
                  }
               }
               if(catNode)
               {
                  standingNode = catNode.children().(@name == "Standing")[0];
                  if(standingNode)
                  {
                     action.defaultActionId = standingNode.@id;
                     if(motion)
                     {
                        motion.defaultActionId = standingNode.@id;
                     }
                  }
               }
               if(groupNode)
               {
                  actionGroup = this.getActionGroupById(groupNode.@name);
                  if(actionGroup)
                  {
                     actionGroup.addAction(action);
                  }
                  for each(node in groupNode.children())
                  {
                     if(node.@id != actionNode.@id && this.getActionById(node.@id).actionGroup == null)
                     {
                        this.createAction(node.@id);
                     }
                  }
               }
            }
         }
         return action;
      }
      
      public function set defaultTalkAction(param1:Action) : void
      {
         this._defaultTalkAction = param1;
      }
      
      private function doLoadActionsAndMotionsSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadActionsAndMotionsSecurityError);
         Console.getConsole().requestLoadStatus(false);
         this._isLoadingActionMotion = false;
         Alert.show("Error in loading character action",param1.type);
      }
      
      public function get defaultAction() : Action
      {
         if(!this._defaultAction)
         {
            if(this.xml)
            {
               this._defaultAction = this.getActionById(this.xml.@§default§);
            }
         }
         return this._defaultAction;
      }
      
      public function getLibraryNum() : Number
      {
         return this._libraries.length;
      }
      
      public function addLibrary(param1:String, param2:Object) : void
      {
         this._libraries.push(param1,param2);
      }
      
      public function set defaultMotion(param1:Motion) : void
      {
         this._defaultMotion = param1;
      }
      
      public function addFacial(param1:Facial) : void
      {
         this._facials.push(param1);
         this._facials.sortOn("name",Array.CASEINSENSITIVE);
      }
      
      public function getFolderPathInCharZip() : String
      {
         return "char/" + this.id + "/";
      }
      
      public function get defaultMotion() : Motion
      {
         if(!this._defaultMotion)
         {
            if(this.xml)
            {
               this._defaultMotion = this.getMotionById(this.xml.@motion);
            }
         }
         return this._defaultMotion;
      }
      
      public function get facing() : String
      {
         return this._facing;
      }
      
      public function getLibraries() : UtilHashArray
      {
         return this._libraries;
      }
      
      public function isThumbReady(param1:String = "") : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Action = null;
         var _loc5_:Motion = null;
         var _loc2_:XML = this.theme.getThumbNodeFromThemeXML(this.theme.getThemeXML(),this);
         if(this.getIsZipLoaded())
         {
            return true;
         }
         if(this.theme.id == "ugc" && this.isSWFCharacter())
         {
            _loc3_ = 0;
            while(_loc3_ < this._actions.length)
            {
               if((_loc4_ = this._actions[_loc3_] as Action).imageData == null)
               {
                  return false;
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.motions.length)
            {
               if((_loc5_ = this.motions[_loc3_] as Motion).imageData == null)
               {
                  return false;
               }
               _loc3_++;
            }
         }
         if(param1 == "")
         {
            param1 = this.defaultAction.id;
         }
         if(this.getActionById(param1).imageData != null)
         {
            return true;
         }
         return false;
      }
      
      public function set tileContainer(param1:Container) : void
      {
         this._tileContainer = param1;
      }
      
      private function addActionMenuItem(param1:Object) : void
      {
         if(param1 is BehaviorCategory || param1 is Action)
         {
            this._actionMenuItems.push(param1);
            this._actionMenuItems.sortOn("name",Array.CASEINSENSITIVE);
         }
      }
      
      public function loadActionsAndMotions() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingActionMotion)
         {
            this._isLoadingActionMotion = true;
            Console.getConsole().requestLoadStatus(true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_CHAR);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.doLoadActionsAndMotionsCompleted);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.doLoadActionsAndMotionsTimeOut);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.doLoadActionsAndMotionsIOError);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doLoadActionsAndMotionsSecurityError);
            _loc2_.load(_loc1_);
         }
      }
      
      private function doLoadActionCompleted(param1:Event) : void
      {
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         var _loc4_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:Facial = null;
         var _loc13_:XML = null;
         var _loc14_:XML = null;
         var _loc15_:* = null;
         var _loc16_:String = null;
         this.xml = param1;
         this.setFileName("char/" + param1.@id + "/" + param1.@thumb);
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.name = param1.@name;
         this.premium = param1.@is_premium == "Y"?true:false;
         this.cost = [param1.@money,param1.@sharing];
         this.theme = param2;
         this.enable = param1.@enable != "N"?true:false;
         this.isCC = param1.@isCC == "Y"?true:false;
         this.encryptId = param1.@encryptId;
         this._ccThemeId = param1.attribute("cc_theme_id");
         if(Console.getConsole().excludedIds.containsKey(this.aid))
         {
            this.enable = false;
         }
         if(!FeatureManager.isPremiumStuffVisible && this.premium && Number(param1.@sharing) > 0)
         {
            this.enable = false;
         }
         if(param1.@facing == AnimeConstants.FACING_LEFT || param1.@facing == AnimeConstants.FACING_RIGHT)
         {
            this.facing = param1.@facing;
         }
         else
         {
            this.facing = AnimeConstants.FACING_UNKNOW;
         }
         if(param1.child("tags").length() > 0)
         {
            this.tags = param1.tags;
         }
         if(this.theme.id == "ugc")
         {
            this.isPublished = param1.@published == "1"?true:false;
         }
         var _loc9_:int = param1.category.length();
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         this._actions = new Array();
         this._actionGroups = new Array();
         this._motions = new Array();
         this._facials = new Array();
         this._actionMenuItems = new Array();
         this._facialMenuItems = new Array();
         _loc10_ = 0;
         while(_loc10_ < param1.library.length())
         {
            _loc15_ = (_loc5_ = param1.library[_loc10_]).@theme_id + "." + _loc5_.@type + "." + _loc5_.@component_id + ".swf";
            this.addLibrary(_loc15_,null);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < param1.colorset.length())
         {
            _loc16_ = (_loc13_ = param1.colorset[_loc10_]).attribute("aid").length() == 0?"0":_loc13_.@aid;
            colorRef.push(_loc16_,_loc13_);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < param1.c_parts.c_area.length())
         {
            _loc14_ = param1.c_parts.c_area[_loc10_];
            if(param1.c_parts.@enable != "N")
            {
               colorParts.push(_loc14_,_loc14_.attribute("oc").length() == 0?uint.MAX_VALUE:_loc14_.@oc);
            }
            _loc10_++;
         }
      }
      
      public function removeActionAndMenuItem(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1 is BehaviorCategory || param1 is Action)
         {
            _loc2_ = this._actionMenuItems.indexOf(param1);
            if(_loc2_ >= 0)
            {
               if(_loc2_ + 1 < this._actionMenuItems.length)
               {
                  this._actionMenuItems[_loc2_] = this._actionMenuItems.pop();
               }
               else
               {
                  this._actionMenuItems.pop();
               }
            }
            _loc2_ = this._actions.indexOf(param1);
            if(_loc2_ >= 0)
            {
               if(_loc2_ + 1 < this._actions.length)
               {
                  this._actions[_loc2_] = this._actions.pop();
               }
               else
               {
                  this._actions.pop();
               }
            }
         }
      }
      
      public function get tileContainer() : Container
      {
         return this._tileContainer;
      }
      
      private function deSerializeAction() : void
      {
         var _loc1_:XML = null;
         if(!this.xml)
         {
            return;
         }
         this._actions = new Array();
         this._actionGroups = new Array();
         this._motions = new Array();
         for each(_loc1_ in this.xml..action)
         {
            this.getActionById(_loc1_.@id);
         }
         for each(_loc1_ in this.xml..motion)
         {
            this.getActionById(_loc1_.@id);
         }
      }
      
      public function getLibraryById(param1:String) : Object
      {
         return this._libraries.getValueByKey(param1);
      }
      
      private function onCcActionFailed(param1:IOErrorEvent) : void
      {
         trace("load image data failed!");
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      public function get motions() : Array
      {
         return this._motions;
      }
      
      public function mergeThumb(param1:CharThumb) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Behavior = null;
         var _loc5_:Behavior = null;
         if(param1.theme.id == this.theme.id && param1.id == this.id)
         {
            this.xml = param1.xml;
            _loc3_ = 0;
            while(_loc3_ < param1.getActionNum())
            {
               _loc5_ = param1.getActionAt(_loc3_);
               if((_loc4_ = this.getActionById(_loc5_.id)) && !_loc4_.imageData)
               {
                  _loc4_.imageData = _loc5_.imageData;
               }
               _loc3_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.motions.length)
            {
               if((_loc4_ = this.motions[_loc2_] as Behavior).imageData == null)
               {
                  _loc3_ = 0;
                  while(_loc3_ < param1.motions.length)
                  {
                     _loc5_ = this.motions[_loc3_] as Behavior;
                     if(_loc4_.id == _loc5_.id)
                     {
                        _loc4_.imageData = _loc5_.imageData;
                        break;
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < param1.motions.length)
            {
               _loc5_ = param1.motions[_loc3_] as Behavior;
               if(!this.getMotionById(_loc5_.id))
               {
                  _loc5_.thumb = this;
                  this.addMotion(_loc5_ as Motion);
               }
               _loc3_++;
            }
            _loc2_ = 0;
            while(_loc2_ < this.facials.length)
            {
               if((_loc4_ = this.facials[_loc2_] as Behavior).imageData == null)
               {
                  _loc3_ = 0;
                  while(_loc3_ < param1.facials.length)
                  {
                     _loc5_ = param1.facials[_loc3_] as Behavior;
                     if(_loc4_.id == _loc5_.id)
                     {
                        _loc4_.imageData = _loc5_.imageData;
                        break;
                     }
                     _loc3_++;
                  }
               }
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < param1.facials.length)
            {
               _loc5_ = param1.facials[_loc3_] as Behavior;
               if(!this.getFacialById(_loc5_.id))
               {
                  _loc5_.thumb = this;
                  this.addFacial(_loc5_ as Facial);
               }
               _loc3_++;
            }
            this._actionMenuItems = param1.actionMenuItems.concat();
            this._facialMenuItems = param1.facialMenuItems.concat();
            this.xml = param1.xml;
         }
      }
      
      public function getActionAt(param1:int) : Action
      {
         return this._actions[param1] as Action;
      }
   }
}
