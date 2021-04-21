package anifire.component
{
   import anifire.color.SelectedColor;
   import anifire.constant.AnimeConstants;
   import anifire.constant.CcLibConstant;
   import anifire.core.CCLipSyncController;
   import anifire.core.CCManager;
   import anifire.core.GoBaseWorkerImp;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.interfaces.ICustomCharacterMaker;
   import anifire.util.ExtraDataLoader;
   import anifire.util.UtilColor;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Shader;
   import flash.display.Sprite;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class CustomCharacterMaker extends MovieClip implements ICustomCharacterMaker
   {
      
      public static const CC2_INIT_DELAY:Number = 200;
      
      public static const STATE_FINISH_LOAD:String = "finish_load";
      
      public static const LOOK_AT_CAMERA_CHANGED:String = "CcLookAtCamera";
      
      public static const STATE_LOADING:String = "loading";
      
      public static const STATE_NULL:String = "null";
      
      public static const SPEECH_PITCH_CHANGED:String = "CcPitchChanged";
       
      
      private var should_decrypt:Boolean = true;
      
      private const LOWERBODY:String = "lower_body";
      
      private var _charSwfs:UtilHashArray;
      
      private var _waiting:Array;
      
      private var _libraries:UtilHashArray;
      
      private var _useSpeechMouth:Boolean = false;
      
      private const BODYSHAPE:String = "bodyshape";
      
      private const UPPERBODY:String = "upper_body";
      
      private var _decoArray:Array;
      
      private const CLIPUPPER:String = "theUpper";
      
      private var _componentQueue:Array;
      
      private var _headRect:Rectangle;
      
      private var _prop:DisplayObjectContainer = null;
      
      private const SKELETON:String = "skeleton";
      
      private var _ccm:CCManager;
      
      private var _lipMouth:Boolean = false;
      
      private var _componentOrder:Array;
      
      private var _demoSpeech:Boolean = false;
      
      private var _lookAtCameraSupported:Boolean = false;
      
      private var _initCameraHandlers:Boolean = false;
      
      private const DEFAULTHEAD:String = "defaultHead";
      
      private const CLIPLOWER:String = "theLower";
      
      private var _state:String;
      
      private const MC:String = "MC";
      
      private const LIB_LEFT:String = "Left";
      
      private const LIB_RIGHT:String = "Right";
      
      private const SWF_EXT:String = ".swf";
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _charZip:ZipFile;
      
      private var _charXML:XML;
      
      private var GoColorMapShaderClass:Class;
      
      private var _customColor:UtilHashArray;
      
      private var _shouldPauseOnLoadByteComplete:Boolean;
      
      private const XML_DESC:String = "desc.xml";
      
      private var _lookAtCamera:Boolean = false;
      
      private var _hasProp:Boolean = false;
      
      private const NODE_COMPONENT:String = "component";
      
      private var _tempworker:GoBaseWorkerImp;
      
      private var _ver:Number;
      
      public function CustomCharacterMaker()
      {
         this.GoColorMapShaderClass = CustomCharacterMaker_GoColorMapShaderClass;
         this._charXML = ;
         this._componentOrder = CcLibConstant.ALL_BODY_COMPONENT_TYPES.concat(CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD);
         this._componentQueue = new Array();
         this._waiting = new Array();
         this._decoArray = new Array();
         this._headRect = new Rectangle();
         this._libraries = new UtilHashArray();
         super();
         this._customColor = new UtilHashArray();
         this._ccm = new CCManager();
         this.state = STATE_NULL;
         this._eventDispatcher = new EventDispatcher();
         this._ver = 1;
      }
      
      private function addDefinitionFromParent(param1:String, param2:LoaderInfo, param3:String, param4:Object, param5:DisplayObjectContainer, param6:Array) : void
      {
         var tmp:Class = null;
         var mytemp:DisplayObjectContainer = null;
         var mytempchild:DisplayObject = null;
         var index:int = 0;
         var i:int = 0;
         var k:int = 0;
         var componentContainer:DisplayObjectContainer = null;
         var colorItems:Array = null;
         var color:Object = null;
         var mytempparent:DisplayObjectContainer = null;
         var className:String = param1;
         var loaderinfo:LoaderInfo = param2;
         var name:String = param3;
         var properties:Object = param4;
         var container:DisplayObjectContainer = param5;
         var colors:Array = param6;
         componentContainer = UtilPlain.getInstance(container,className + this.MC);
         k = componentContainer.numChildren;
         loop0:
         while(true)
         {
            if(k > 0)
            {
               componentContainer.removeChildAt(k - 1);
               k--;
               continue;
            }
            try
            {
               tmp = loaderinfo.applicationDomain.getDefinition(className) as Class;
               if(tmp != null)
               {
                  mytemp = new tmp();
                  mytemp.name = className;
                  index = this._componentOrder.indexOf(mytemp.name);
                  componentContainer.addChild(mytemp);
                  mytempparent = mytemp.parent;
                  mytempparent.x = Number(properties["x"]);
                  mytempparent.y = Number(properties["y"]);
                  mytempparent.rotation = Number(properties["rotation"]);
                  mytempparent.scaleX = Number(properties["xscale"]);
                  mytempparent.scaleY = Number(properties["yscale"]);
                  if(colors != null)
                  {
                     i = 0;
                     while(true)
                     {
                        if(i >= colors.length)
                        {
                           break loop0;
                        }
                        color = colors[i];
                        this.updateColor(color);
                        i++;
                     }
                  }
                  break;
               }
               break;
            }
            catch(e:Error)
            {
               addr235:
               return;
            }
         }
         §§goto(addr235);
      }
      
      public function onReady(param1:Event = null) : void
      {
         var _loc2_:XML = null;
         var _loc4_:SelectedColor = null;
         if(param1 != null)
         {
            (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onReady);
         }
         var _loc3_:UtilHashArray = new UtilHashArray();
         for each(_loc2_ in this.charXML.child(CcLibConstant.NODE_COLOR))
         {
            _loc4_ = new SelectedColor(_loc2_.@r,String(_loc2_.@oc).length == 0?uint(uint.MAX_VALUE):uint(_loc2_.@oc),uint(_loc2_));
            this.changeColor(_loc4_,_loc2_.@targetComponent == null?"":_loc2_.@targetComponent);
            if(_loc4_.orgColor != uint.MAX_VALUE)
            {
               this._customColor.push(_loc4_.areaName,_loc4_);
               _loc3_.push("0x" + _loc4_.orgColor.toString(16),"0x" + _loc4_.dstColor.toString(16));
            }
         }
         if(_loc3_.length > 0)
         {
            this.changeColorForShader(_loc3_);
         }
         this.refreshScale();
         UtilPlain.gotoAndStopFamilyAt1(this);
         if(!this.shouldPauseOnLoadBytesComplete)
         {
            UtilPlain.playFamily(this);
         }
         this.state = STATE_FINISH_LOAD;
         this.updateHeadRect();
         if(this.ver == 2)
         {
            this.dispatchComplete();
         }
         else
         {
            this.dispatchComplete();
         }
      }
      
      public function resetHeadPos() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this,AnimeConstants.MOVIECLIP_THE_HEAD);
         if(_loc1_ != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.numChildren)
            {
               _loc3_ = _loc1_.getChildAt(_loc2_);
               _loc3_.x = 0;
               _loc3_.y = 0;
               _loc2_++;
            }
         }
      }
      
      private function addPropClipToPropContainer(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(param2,UtilPlain.THE_CHAR);
         if(_loc3_ != null)
         {
            if((_loc4_ = UtilPlain.getProp(_loc3_)) != null)
            {
               UtilPlain.removeAllSon(_loc4_);
               _loc4_.addChild(param1);
               this.updatePropSize(param1,_loc4_);
            }
         }
      }
      
      public function switchToLipSyncMouth(param1:Boolean) : void
      {
         var properties:Object = null;
         var node:XML = null;
         var colorArray:Array = null;
         var loadMgr:UtilLoadMgr = null;
         var colorNames:Object = null;
         var swfkey:String = null;
         var bytes:ByteArray = null;
         var on:Boolean = param1;
         if(this._lipMouth != on)
         {
            if(this.state != STATE_LOADING)
            {
               this.state = STATE_LOADING;
            }
            else if(this.state == STATE_LOADING)
            {
               return;
            }
            loadMgr = new UtilLoadMgr();
            loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doUpdateState);
            for each(node in this.charXML.child(this.NODE_COMPONENT))
            {
               if(node.@type == CcLibConstant.COMPONENT_TYPE_MOUTH)
               {
                  colorNames = CcLibConstant.COLORS_BY_COMPONENT(node.@type);
                  if(colorNames)
                  {
                     colorArray = (colorNames as Array).map(function(param1:String, param2:int, param3:Array):Object
                     {
                        var colorXMLNode:* = undefined;
                        var colorObj:* = undefined;
                        var item:String = param1;
                        var index:int = param2;
                        var array:Array = param3;
                        colorXMLNode = charXML.color.(@r == item);
                        colorObj = {
                           "colorReference":String(colorXMLNode.@r),
                           "originalColor":(String(colorXMLNode.@oc).length == 0?uint.MAX_VALUE:uint(colorXMLNode.@oc)),
                           "colorValue":uint(colorXMLNode.text()),
                           "targetComponentId":""
                        };
                        return colorObj;
                     });
                  }
                  properties = {
                     "x":String(node.@x),
                     "y":String(node.@y),
                     "xscale":String(node.@xscale),
                     "yscale":String(node.@yscale),
                     "offset":String(node.@offset),
                     "rotation":String(node.@rotation)
                  };
                  if(on)
                  {
                     swfkey = node.@theme_id + "." + node.@type + "." + CCLipSyncController.LIPSYNC_LIB_ID;
                  }
                  else
                  {
                     swfkey = node.@theme_id + "." + node.@type + "." + node.@component_id + this.SWF_EXT;
                  }
                  bytes = this.charSwfs.getValueByKey(swfkey);
                  if(bytes)
                  {
                     this.updateComponentImageData(node.@type,bytes,properties,loadMgr,colorArray,node.@id);
                  }
               }
            }
            loadMgr.commit();
         }
         this._lipMouth = on;
      }
      
      public function updateByZip(param1:ByteArray) : void
      {
         var _loc2_:ZipFile = new ZipFile(param1);
         this.charZip = _loc2_;
         this.initByZip(_loc2_);
      }
      
      public function destroy(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = UtilPlain.getLoaderItemExcludeTheHead(this);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            Loader(_loc3_[_loc2_]).unloadAndStop(param1);
            _loc2_++;
         }
         _loc2_ = this.numChildren;
         while(_loc2_ > 0)
         {
            this.removeChildAt(_loc2_ - 1);
            _loc2_--;
         }
         this._ccm = new CCManager();
         this._libraries.removeAll();
         this._componentQueue = new Array();
         this._decoArray = new Array();
         this.eventDispatcher.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.MOVIE_FINISH_EVENT));
      }
      
      public function init(param1:XML, param2:Number = 0, param3:Number = 0, param4:UtilHashArray = null, param5:UtilHashArray = null, param6:Boolean = false, param7:Boolean = false) : void
      {
         this._useSpeechMouth = param6;
         this.prepareXML(param1);
         var _loc8_:CcActionLoader;
         (_loc8_ = new CcActionLoader()).addEventListener(Event.COMPLETE,this.onCcActionLoaded);
         _loc8_.addEventListener(IOErrorEvent.IO_ERROR,this.onCcActionFailed);
         _loc8_.loadCcComponents(param1,param2,param3,param4,param5,this.ver,param7);
      }
      
      private function dispatchComplete() : void
      {
         this.visible = true;
         this.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
         this.eventDispatcher.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
      }
      
      public function initByZip(param1:ZipFile) : void
      {
         this.destroy();
         this.charXML = new XML(param1.getInput(param1.getEntry(this.XML_DESC)));
         this.prepareXML(this.charXML);
         this.prepareSkin();
      }
      
      public function deleteColorByArea(param1:String) : void
      {
         this._customColor.removeByKey(param1);
         this.CCM.deleteColor(param1);
      }
      
      public function getHeadBitmap() : BitmapData
      {
         var _loc1_:BitmapData = null;
         var _loc2_:Matrix = new Matrix();
         var _loc3_:Number = this.headRect.width;
         var _loc4_:Number = this.headRect.height;
         _loc1_ = new BitmapData(_loc3_,_loc4_,true,0);
         _loc2_.translate(-this.headRect.x,-this.headRect.y);
         _loc2_.scale(1,1);
         _loc1_.draw(this,_loc2_);
         return _loc1_;
      }
      
      public function initByXml(param1:XML, param2:Number = 0, param3:Number = 0, param4:Boolean = false) : void
      {
         this._useSpeechMouth = param4;
         this.prepareXML(param1);
         var _loc5_:CcActionLoader;
         (_loc5_ = new CcActionLoader()).addEventListener(Event.COMPLETE,this.onCcActionLoaded);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.onCcActionFailed);
         _loc5_.loadCcComponents(param1,param2,param3,null,null,this.ver);
      }
      
      private function set state(param1:String) : void
      {
         this._state = param1;
      }
      
      public function insertColor(param1:UtilHashArray) : void
      {
         this._customColor.insert(0,param1);
         this.CCM.colors.insert(0,param1);
      }
      
      public function refreshScale() : void
      {
         if(this.charXML.@xscale > 0 && this.charXML.@yscale > 0)
         {
            this.updateBodyScale(Number(this.charXML.@xscale),Number(this.charXML.@yscale));
         }
         if(this.charXML.@hxscale > 0 && this.charXML.@hyscale > 0)
         {
            this.updateHeadScale(Number(this.charXML.@hxscale),Number(this.charXML.@hyscale));
         }
         if(this.charXML.@headdx.length() > 0 && this.charXML.@headdy.length() > 0 && (this.charXML.@headdx as Number != 0 || this.charXML.@headdy as Number != 0))
         {
            this.resetHeadPos();
            this.updateHeadPos(Number(this.charXML.@headdx),Number(this.charXML.@headdy));
         }
      }
      
      public function updateBodyScale(param1:Number, param2:Number) : void
      {
         var _loc3_:DisplayObjectContainer = this.getSkeletonContainer(this.ver);
         if(_loc3_ != null)
         {
            _loc3_.scaleX = param1;
            _loc3_.scaleY = param2;
         }
      }
      
      public function initByLoaders(param1:UtilHashArray) : void
      {
         var _loc4_:ExtraDataLoader = null;
         var _loc2_:UtilLoadMgr = new UtilLoadMgr();
         _loc2_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReady);
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.getValueByIndex(_loc3_) as ExtraDataLoader;
            _loc2_.addEventDispatcher(_loc4_,Event.INIT);
            this.doLoadImageData(_loc4_);
            _loc3_++;
         }
         _loc2_.commit();
      }
      
      private function prepareSkin(param1:UtilHashArray = null) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc5_:ByteArray = null;
         var _loc6_:ZipEntry = null;
         var _loc7_:ExtraDataLoader = null;
         var _loc8_:Object = null;
         var _loc4_:UtilLoadMgr;
         (_loc4_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doPrepareFinished);
         for each(_loc2_ in this.charXML.child(CcLibConstant.NODE_LIBRARY))
         {
            _loc3_ = _loc2_.@theme_id + "." + _loc2_.@type + "." + _loc2_.@component_id + this.SWF_EXT;
            if(param1 == null || param1.length == 0)
            {
               if(this.charZip != null)
               {
                  if((_loc6_ = this.charZip.getEntry(_loc3_)) != null)
                  {
                     _loc5_ = this.charZip.getInput(_loc6_);
                  }
               }
               else if(this.charSwfs != null)
               {
                  _loc5_ = this.charSwfs.getValueByKey(_loc3_);
               }
            }
            else
            {
               _loc5_ = param1.getValueByKey(_loc3_);
            }
            if(_loc5_ != null)
            {
               _loc7_ = new ExtraDataLoader();
               (_loc8_ = new Object())["part"] = String(_loc2_.@type);
               _loc7_.extraData = _loc8_;
               _loc4_.addEventDispatcher(_loc7_.contentLoaderInfo,Event.COMPLETE);
               _loc7_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadStyleDone);
               _loc7_.loadBytes(_loc5_);
            }
         }
         _loc4_.commit();
      }
      
      public function getBitmap() : BitmapData
      {
         var _loc1_:BitmapData = null;
         var _loc2_:Matrix = new Matrix();
         var _loc3_:Rectangle = this.parent.getBounds(this);
         var _loc4_:Number = _loc3_.width;
         var _loc5_:Number = _loc3_.height;
         _loc1_ = new BitmapData(_loc4_,_loc5_,true,0);
         _loc2_.translate(-_loc3_.x,-_loc3_.y);
         _loc2_.scale(1,1);
         _loc1_.draw(this,_loc2_);
         return _loc1_;
      }
      
      public function set ver(param1:Number) : void
      {
         this._ver = param1;
      }
      
      private function onCcActionLoaded(param1:Event) : void
      {
         var loader:CcActionLoader = null;
         var e:Event = param1;
         try
         {
            loader = CcActionLoader(e.target);
            loader.removeEventListener(e.type,this.onCcActionLoaded);
            if(loader.imageData)
            {
               this.initBySwfs(loader.imageData["xml"] as XML,loader.imageData["imageData"] as UtilHashArray);
            }
            loader = null;
         }
         catch(e:Error)
         {
         }
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
         var _loc2_:* = this._demoSpeech != param1;
         this._demoSpeech = param1;
      }
      
      public function addColor(param1:String, param2:uint, param3:uint) : void
      {
         var _loc4_:SelectedColor = new SelectedColor(param1,param2,param3);
         this._customColor.push(_loc4_.areaName,_loc4_);
         this.CCM.addColor(_loc4_.areaName,_loc4_);
      }
      
      private function onCcActionFailed(param1:IOErrorEvent) : void
      {
         trace("init cc failed!");
      }
      
      private function get waiting() : Array
      {
         return this._waiting;
      }
      
      private function set charSwfs(param1:UtilHashArray) : void
      {
         this._charSwfs = param1;
      }
      
      private function updateEyesRect() : void
      {
         var _loc2_:DisplayObjectContainer = null;
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:Rectangle = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Point = null;
         var _loc7_:DisplayObject = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         if(_loc1_ != null)
         {
            _loc2_ = UtilPlain.getInstance(_loc1_,CcLibConstant.COMPONENT_TYPE_EYE + CcLibConstant.LEFT + this.MC);
            _loc3_ = UtilPlain.getInstance(_loc1_,CcLibConstant.COMPONENT_TYPE_EYE + CcLibConstant.RIGHT + this.MC);
            _loc4_ = _loc2_.getBounds(_loc1_);
            _loc5_ = _loc3_.getBounds(_loc1_);
            if(!(_loc4_.width == 0 || _loc5_.width == 0))
            {
               _loc6_ = new Point((_loc4_.x + _loc5_.x + _loc4_.width) / 2,(_loc4_.y + _loc5_.y) / 2);
               _loc7_ = _loc1_.parent;
               while(_loc7_ != this)
               {
                  _loc6_.offset(_loc7_.x,_loc7_.y);
                  _loc7_ = _loc7_.parent;
               }
               _loc8_ = 100;
               _loc9_ = 100;
               _loc10_ = 2 / 5;
               _loc11_ = 2 / 5;
               this._headRect = new Rectangle(_loc6_.x - _loc8_ * _loc10_,_loc6_.y - _loc9_ * _loc11_,_loc8_,_loc9_);
            }
         }
      }
      
      public function loadZip(param1:String, param2:String, param3:String = "") : void
      {
         this.initByActionId(param1,param2,param3);
      }
      
      public function get shouldPauseOnLoadBytesComplete() : Boolean
      {
         return this._shouldPauseOnLoadByteComplete;
      }
      
      public function initBySwfs(param1:XML, param2:UtilHashArray, param3:UtilHashArray = null) : void
      {
         if(this.state == STATE_NULL)
         {
            this.state = STATE_LOADING;
         }
         else
         {
            if(this.state == STATE_LOADING)
            {
               return;
            }
            if(this.state == STATE_FINISH_LOAD)
            {
               setTimeout(this.dispatchComplete,100);
               return;
            }
         }
         this.should_decrypt = false;
         this.charXML = param1;
         this.charSwfs = param2;
         this._waiting = new Array();
         this.visible = false;
         this.prepareXML(this.charXML);
         this.prepareSkin(param3);
      }
      
      public function get prop() : DisplayObjectContainer
      {
         return this._prop;
      }
      
      private function loadAllComponents(param1:Event) : void
      {
         var swfkey:String = null;
         var properties:Object = null;
         var node:XML = null;
         var colorNames:Object = null;
         var bytes:ByteArray = null;
         var event:Event = param1;
         this._decoArray = new Array();
         var loadMgr:UtilLoadMgr = new UtilLoadMgr();
         var colorArray:Array = null;
         loadMgr.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReady);
         for each(node in this.charXML.child(this.NODE_COMPONENT))
         {
            if(node.@type != this.BODYSHAPE)
            {
               colorNames = CcLibConstant.COLORS_BY_COMPONENT(node.@type);
               if(colorNames)
               {
                  colorArray = (colorNames as Array).map(function(param1:String, param2:int, param3:Array):Object
                  {
                     var colorXMLNode:* = undefined;
                     var colorObj:* = undefined;
                     var item:String = param1;
                     var index:int = param2;
                     var array:Array = param3;
                     colorXMLNode = charXML.color.(@r == item);
                     colorObj = {
                        "colorReference":String(colorXMLNode.@r),
                        "originalColor":(String(colorXMLNode.@oc).length == 0?uint.MAX_VALUE:uint(colorXMLNode.@oc)),
                        "colorValue":uint(colorXMLNode.text()),
                        "targetComponentId":""
                     };
                     return colorObj;
                  });
               }
               if(node.@type == CcLibConstant.COMPONENT_TYPE_MOUTH && (this._useSpeechMouth || this.demoSpeech))
               {
                  if(this._useSpeechMouth)
                  {
                     swfkey = node.@theme_id + "." + node.@type + "." + CCLipSyncController.LIPSYNC_LIB_ID;
                  }
                  else if(this.demoSpeech)
                  {
                     swfkey = node.@theme_id + "." + node.@type + "." + CCLipSyncController.DEMO_LIPSYNC_LIB_ID;
                  }
               }
               else
               {
                  swfkey = node.@theme_id + "." + node.@type + "." + node.@component_id + this.SWF_EXT;
               }
               properties = {
                  "x":String(node.@x),
                  "y":String(node.@y),
                  "xscale":String(node.@xscale),
                  "yscale":String(node.@yscale),
                  "offset":String(node.@offset),
                  "rotation":String(node.@rotation)
               };
               if(this.charZip != null)
               {
                  bytes = this.charZip.getInput(this.charZip.getEntry(swfkey));
               }
               else if(this.charSwfs != null)
               {
                  bytes = this.charSwfs.getValueByKey(swfkey);
               }
               this.updateComponentImageData(node.@type,bytes,properties,loadMgr,colorArray,node.@id);
            }
         }
         loadMgr.commit();
      }
      
      public function get headPos() : Point
      {
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this,AnimeConstants.MOVIECLIP_DEFAULT_HEAD);
         return new Point(_loc1_.x,_loc1_.y);
      }
      
      public function updateColor(param1:Object) : void
      {
         var _loc2_:UtilHashArray = new UtilHashArray();
         var _loc3_:SelectedColor = new SelectedColor(param1["colorReference"],param1["originalColor"],param1["colorValue"]);
         this.changeColor(_loc3_,param1["targetComponentId"]);
         if(param1["originalColor"] != uint.MAX_VALUE)
         {
            this._customColor.push(_loc3_.areaName,_loc3_);
            _loc2_.push("0x" + _loc3_.orgColor.toString(16),"0x" + _loc3_.dstColor.toString(16));
         }
         if(_loc2_.length > 0)
         {
            this.changeColorForShader(_loc2_);
         }
         this.addColor(_loc3_.areaName,_loc3_.orgColor,_loc3_.dstColor);
      }
      
      private function doLoadedComponent(param1:ExtraDataLoader) : void
      {
         var embedContainer:DisplayObjectContainer = null;
         var componentType:String = null;
         var properties:Object = null;
         var colors:Array = null;
         var mytemp:DisplayObject = null;
         var mytempparent:DisplayObjectContainer = null;
         var i:int = 0;
         var color:Object = null;
         var loader:ExtraDataLoader = param1;
         embedContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         var exdata:Object = loader.extraData;
         componentType = exdata["componentType"];
         properties = exdata["properties"];
         colors = exdata["colors"];
         if(this._componentOrder.indexOf(componentType) == -1)
         {
            if(componentType == CcLibConstant.COMPONENT_TYPE_EYE && (loader.contentLoaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_RIGHT + "_Cam") || loader.contentLoaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_LEFT + "_Cam")))
            {
               this._lookAtCameraSupported = true;
               addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,function(param1:ExtraDataEvent):void
               {
                  addDefinition(loader.contentLoaderInfo,componentType,properties,embedContainer,colors);
               });
            }
            this.addDefinition(loader.contentLoaderInfo,componentType,properties,embedContainer,colors);
         }
         else
         {
            if(CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD.indexOf(componentType) > -1)
            {
               if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(componentType) == -1)
               {
                  this.updateLocation(componentType,properties);
               }
               else
               {
                  mytemp = loader;
                  mytempparent = loader.parent;
                  mytempparent.x = Number(properties["x"]);
                  mytempparent.y = Number(properties["y"]);
                  mytempparent.rotation = Number(properties["rotation"]);
                  mytempparent.scaleX = Number(properties["xscale"]);
                  mytempparent.scaleY = Number(properties["yscale"]);
               }
            }
            if(colors != null)
            {
               i = 0;
               while(i < colors.length)
               {
                  color = colors[i] as Object;
                  this.updateColor(color);
                  i++;
               }
            }
            loader.dispatchEvent(new Event(Event.INIT));
            if(componentType == CcLibConstant.COMPONENT_TYPE_HAIR)
            {
               this.addDefinition(loader.contentLoaderInfo,componentType,properties,embedContainer,colors);
            }
         }
      }
      
      public function get lookAtCameraSupported() : Boolean
      {
         return this._lookAtCameraSupported;
      }
      
      private function loadedComponent(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadedComponent);
         var _loc2_:ExtraDataLoader = ExtraDataLoader(param1.currentTarget);
         this.doLoadedComponent(_loc2_);
      }
      
      private function shiftHead() : void
      {
         if(this.charXML.@headdx != 0 || this.charXML.@headdy != 0)
         {
            this.updateHeadPos(Number(this.charXML.@headdx),Number(this.charXML.@headdy));
         }
      }
      
      private function doPrepareFinished(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doPrepareFinished);
         this.loadAllComponents(null);
      }
      
      public function getColorByName(param1:String) : uint
      {
         return SelectedColor(this._customColor.getValueByKey(param1)).dstColor;
      }
      
      private function prepareXML(param1:XML) : void
      {
         var _loc2_:XMLList = null;
         var _loc3_:int = 0;
         _loc2_ = param1.library;
         this._ver = String(param1.@version).length > 0?Number(Number(param1.@version)):Number(1);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length())
         {
            this.addLibrary(_loc2_[_loc3_].@type,_loc2_[_loc3_].@component_id,_loc2_[_loc3_].@theme_id);
            _loc3_++;
         }
         _loc2_ = param1.color;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length())
         {
            this.addColor(_loc2_[_loc3_].@r,uint(_loc2_[_loc3_].@oc.length() > 0?_loc2_[_loc3_].@oc:uint.MAX_VALUE),uint(_loc2_[_loc3_].text()));
            _loc3_++;
         }
      }
      
      public function changeColor(param1:SelectedColor, param2:String = "") : Number
      {
         var _loc3_:DisplayObject = null;
         if(param2 == "")
         {
            _loc3_ = this;
         }
         else
         {
            _loc3_ = UtilPlain.getInstance(this,param2);
         }
         return uint(UtilColor.setAssetPartColor(_loc3_,param1.areaName,param1.dstColor));
      }
      
      public function removeLibrary(param1:String) : void
      {
         this._libraries.removeByKey(param1);
      }
      
      private function get state() : String
      {
         return this._state;
      }
      
      public function updateHeadScale(param1:Number, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(this,AnimeConstants.MOVIECLIP_THE_HEAD);
         if(_loc3_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numChildren)
            {
               (_loc5_ = _loc3_.getChildAt(_loc4_)).scaleX = param1;
               _loc5_.scaleY = param2;
               _loc4_++;
            }
         }
      }
      
      private function doLoadImageData(param1:ExtraDataLoader) : void
      {
         var _loc8_:DisplayObjectContainer = null;
         var _loc9_:DisplayObjectContainer = null;
         var _loc10_:int = 0;
         var _loc11_:DisplayObjectContainer = null;
         var _loc12_:int = 0;
         var _loc2_:Object = param1.extraData;
         var _loc3_:String = _loc2_["componentType"];
         var _loc4_:Object = _loc2_["properties"];
         var _loc5_:Array = _loc2_["colors"];
         var _loc6_:String = _loc2_["clipName"];
         var _loc7_:Number = Number(_loc2_["index"]);
         if(_loc6_ != "")
         {
            _loc8_ = UtilPlain.getInstance(this,_loc6_);
         }
         else
         {
            _loc8_ = this;
         }
         if(_loc8_ != null)
         {
            if(this._componentOrder.indexOf(_loc3_) == -1)
            {
               this.doLoadedComponent(param1);
            }
            else if(_loc6_ == this.DEFAULTHEAD)
            {
               _loc9_ = UtilPlain.getInstance(_loc8_,_loc3_ + this.MC);
               if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(_loc3_) == -1)
               {
                  _loc10_ = _loc9_.numChildren;
                  while(_loc10_ > 0)
                  {
                     _loc9_.removeChildAt(_loc10_ - 1);
                     _loc10_--;
                  }
               }
               param1.addEventListener(Event.ADDED,this.loadedComponent);
               if(_loc7_ != -1)
               {
                  (_loc11_ = _loc9_.getChildAt(_loc7_) as DisplayObjectContainer).name = param1.name;
                  _loc11_.addChild(param1);
               }
               else
               {
                  _loc9_.addChild(param1);
               }
            }
            else
            {
               _loc12_ = _loc8_.numChildren;
               while(_loc12_ > 0)
               {
                  _loc8_.removeChildAt(_loc12_ - 1);
                  _loc12_--;
               }
               param1.addEventListener(Event.ADDED,this.loadedComponent);
               _loc8_.addChild(param1);
               if(_loc8_ == this)
               {
                  this.redoWaitingImageData();
               }
               if(this.ver == 2)
               {
                  this.reloadSkin();
               }
            }
         }
         else
         {
            this.waiting.push(param1);
         }
      }
      
      public function initByActionId(param1:String, param2:String, param3:String = "") : void
      {
         var loader:CcActionLoader = null;
         var aid:String = param1;
         var actionId:String = param2;
         var facialId:String = param3;
         try
         {
            if(aid && actionId)
            {
               loader = new CcActionLoader();
               loader.addEventListener(Event.COMPLETE,this.onCcActionLoaded);
               loader.addEventListener(IOErrorEvent.IO_ERROR,this.onCcActionFailed);
               loader.load(aid,actionId,facialId);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function get ver() : Number
      {
         return this._ver;
      }
      
      public function get demoSpeech() : Boolean
      {
         return this._demoSpeech;
      }
      
      private function get charSwfs() : UtilHashArray
      {
         return this._charSwfs;
      }
      
      public function removeHighlight(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         _loc3_ = UtilPlain.getInstance(_loc2_,param1);
         if(_loc3_ != null)
         {
            _loc3_.filters = new Array();
         }
      }
      
      public function unloadAssetImage(param1:Boolean) : void
      {
         this.destroy(param1);
      }
      
      public function updateLocation(param1:String, param2:Object, param3:String = "") : void
      {
         var _loc5_:DisplayObjectContainer = null;
         var _loc6_:DisplayObjectContainer = null;
         var _loc4_:DisplayObjectContainer;
         if((_loc4_ = UtilPlain.getInstance(this,this.DEFAULTHEAD)) != null)
         {
            if(this._componentOrder.indexOf(param1) == -1)
            {
               _loc6_ = (_loc5_ = UtilPlain.getInstance(_loc4_,param1 + this.LIB_RIGHT)).getChildAt(0) as DisplayObjectContainer;
               _loc5_.x = Number(param2["x"]);
               _loc5_.y = Number(param2["y"]);
               _loc6_.scaleX = Number(param2["xscale"]);
               _loc6_.scaleY = Number(param2["yscale"]);
               _loc5_.x = _loc5_.x - Number(param2["offset"]) / 2;
               _loc6_.rotation = Number(param2["rotation"]);
               _loc6_ = (_loc5_ = UtilPlain.getInstance(_loc4_,param1 + this.LIB_LEFT)).getChildAt(0) as DisplayObjectContainer;
               _loc5_.x = Number(param2["x"]);
               _loc5_.y = Number(param2["y"]);
               _loc6_.scaleX = Number(param2["xscale"]);
               _loc6_.scaleY = Number(param2["yscale"]);
               _loc5_.x = _loc5_.x + Number(param2["offset"]) / 2;
               _loc6_.rotation = -Number(param2["rotation"]);
            }
            else
            {
               _loc5_ = UtilPlain.getInstance(_loc4_,param1 + this.MC);
               if(param3 != "")
               {
                  _loc6_ = _loc5_.getChildByName(param3) as DisplayObjectContainer;
               }
               else if(_loc5_.numChildren > 0)
               {
                  _loc6_ = _loc5_.getChildAt(0) as DisplayObjectContainer;
               }
               if(_loc6_ != null)
               {
                  if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(param1) > -1)
                  {
                     _loc6_.x = Number(param2["x"]);
                     _loc6_.y = Number(param2["y"]);
                  }
                  else
                  {
                     _loc5_.x = Number(param2["x"]);
                     _loc5_.y = Number(param2["y"]);
                  }
                  _loc6_.scaleX = Number(param2["xscale"]);
                  _loc6_.scaleY = Number(param2["yscale"]);
                  _loc6_.rotation = Number(param2["rotation"]);
               }
            }
         }
         this.updateHeadRect();
      }
      
      public function removeComponentById(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:int = 0;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         _loc3_ = UtilPlain.getInstance(_loc2_,param1);
         if(_loc3_)
         {
            _loc5_ = (_loc4_ = _loc3_.parent).numChildren - 1;
            while(_loc5_ >= 0)
            {
               if(_loc4_.getChildAt(_loc5_).name == param1)
               {
                  _loc4_.removeChildAt(_loc5_);
               }
               _loc5_--;
            }
         }
      }
      
      private function doLoadZipComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadZipComplete);
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         var _loc4_:ZipFile = new ZipFile(_loc3_);
         this.charZip = _loc4_;
         this.initByZip(_loc4_);
      }
      
      public function reloadSkin() : void
      {
         this.eventDispatcher.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.RELOAD_MOVIE_EVENT));
      }
      
      public function set shouldPauseOnLoadBytesComplete(param1:Boolean) : void
      {
         this._shouldPauseOnLoadByteComplete = param1;
      }
      
      private function doUpdateState(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doUpdateState);
         this.state = STATE_FINISH_LOAD;
      }
      
      public function updateHeadPos(param1:Number, param2:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DisplayObject = null;
         var _loc3_:DisplayObjectContainer = UtilPlain.getInstance(this,AnimeConstants.MOVIECLIP_THE_HEAD);
         if(_loc3_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numChildren)
            {
               _loc5_ = _loc3_.getChildAt(_loc4_);
               _loc5_.x = _loc5_.x + param1;
               _loc5_.y = _loc5_.y + param2;
               _loc4_++;
            }
         }
      }
      
      public function highlightComponent(param1:String) : void
      {
         var _loc3_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         _loc3_ = UtilPlain.getInstance(_loc2_,param1);
         var _loc4_:GlowFilter = new GlowFilter(16777215);
         var _loc5_:Array;
         (_loc5_ = new Array()).push(_loc4_);
         _loc3_.filters = _loc5_;
      }
      
      private function set charXML(param1:XML) : void
      {
         this._charXML = param1;
      }
      
      public function set prop(param1:DisplayObjectContainer) : void
      {
         this._prop = param1;
      }
      
      private function onLoadImageData(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadImageData);
         var _loc2_:ExtraDataLoader = ExtraDataLoader(LoaderInfo(param1.currentTarget).loader);
         this.doLoadImageData(_loc2_);
      }
      
      private function updateHeadRect() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         if(_loc1_ != null)
         {
            this._headRect = _loc1_.parent.getBounds(_loc1_);
            _loc2_ = _loc1_.parent;
            while(_loc2_ != this)
            {
               this._headRect.offset(_loc2_.x,_loc2_.y);
               _loc2_ = _loc2_.parent;
            }
         }
         this.updateEyesRect();
      }
      
      public function get bodyScale() : Number
      {
         var _loc1_:DisplayObjectContainer = this.getSkeletonContainer(this.ver);
         if(_loc1_ == null)
         {
            return 1;
         }
         return _loc1_.scaleX;
      }
      
      public function updateComponentImageData(param1:String, param2:ByteArray, param3:Object, param4:UtilLoadMgr, param5:Array = null, param6:String = "") : void
      {
         var clipName:String = null;
         var loader:ExtraDataLoader = null;
         var tmpByteArray:ByteArray = null;
         var decryptEngine:UtilCrypto = null;
         var componentType:String = param1;
         var swfByteArray:ByteArray = param2;
         var properties:Object = param3;
         var loadMgr:UtilLoadMgr = param4;
         var colors:Array = param5;
         var id:String = param6;
         switch(componentType)
         {
            case this.SKELETON:
            case CcLibConstant.COMPONENT_TYPE_FREEACTION:
               clipName = "";
               properties = {
                  "x":0,
                  "y":0,
                  "xscale":1,
                  "yscale":1,
                  "offset":0
               };
               break;
            case this.UPPERBODY:
               clipName = this.CLIPUPPER;
               break;
            case this.LOWERBODY:
               clipName = this.CLIPLOWER;
               break;
            default:
               clipName = this.DEFAULTHEAD;
         }
         loader = new ExtraDataLoader();
         var decoIndex:Number = -1;
         if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(componentType) == -1)
         {
            loader.name = componentType;
         }
         else
         {
            loader.name = id;
            decoIndex = this._decoArray.push(id) - 1;
         }
         loadMgr.addEventDispatcher(loader,Event.INIT);
         loader.extraData = {
            "componentType":componentType,
            "properties":properties,
            "colors":colors,
            "clipName":clipName,
            "index":decoIndex
         };
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadImageData);
         if(swfByteArray)
         {
            if(this.should_decrypt)
            {
               tmpByteArray = new ByteArray();
               swfByteArray.readBytes(tmpByteArray);
               tmpByteArray.position = 0;
               swfByteArray.position = 0;
               decryptEngine = new UtilCrypto();
               decryptEngine.decrypt(tmpByteArray);
               loader.loadBytes(tmpByteArray);
            }
            else
            {
               swfByteArray.position = 0;
               loader.loadBytes(swfByteArray);
            }
            if(componentType == CcLibConstant.COMPONENT_TYPE_MOUTH)
            {
               addEventListener(SpeechPitchEvent.PITCH,function(param1:SpeechPitchEvent):void
               {
                  var _loc2_:SpeechPitchEvent = new SpeechPitchEvent(SpeechPitchEvent.PITCH);
                  _loc2_.value = param1.value;
                  if(MovieClip(loader.content))
                  {
                     MovieClip(loader.content).dispatchEvent(_loc2_);
                  }
               });
            }
         }
      }
      
      public function changeColorForShader(param1:UtilHashArray) : Number
      {
         var _loc2_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc3_:Shader = new Shader();
         _loc3_.byteCode = new this.GoColorMapShaderClass();
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         var _loc6_:Array = new Array();
         var _loc7_:UtilHashArray = new UtilHashArray();
         _loc8_ = 0;
         while(_loc8_ < this._customColor.length)
         {
            if(SelectedColor(this._customColor.getValueByIndex(_loc8_)).orgColor != uint.MAX_VALUE)
            {
               _loc7_.push("0x" + SelectedColor(this._customColor.getValueByIndex(_loc8_)).orgColor.toString(16),SelectedColor(this._customColor.getValueByIndex(_loc8_)).dstColor);
            }
            _loc8_++;
         }
         _loc7_.insert(0,param1,true);
         _loc9_ = 0;
         while(_loc9_ < _loc7_.length)
         {
            if(uint(_loc7_.getKey(_loc9_)) == 0)
            {
               _loc7_.remove(_loc9_,1);
            }
            _loc9_++;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc7_.length)
         {
            _loc6_.push(uint(_loc7_.getKey(_loc9_)));
            _loc12_ = uint(_loc7_.getValueByIndex(_loc9_)) >> 16 & 255;
            _loc13_ = uint(_loc7_.getValueByIndex(_loc9_)) >> 8 & 255;
            _loc14_ = uint(_loc7_.getValueByIndex(_loc9_)) & 255;
            if(_loc9_ / 4 < 1)
            {
               _loc4_[_loc9_ * 4 + 0] = _loc12_ / 255;
               _loc4_[_loc9_ * 4 + 1] = _loc13_ / 255;
               _loc4_[_loc9_ * 4 + 2] = _loc14_ / 255;
            }
            else
            {
               _loc5_[_loc9_ % 4 * 4 + 0] = _loc12_ / 255;
               _loc5_[_loc9_ % 4 * 4 + 1] = _loc13_ / 255;
               _loc5_[_loc9_ % 4 * 4 + 2] = _loc14_ / 255;
            }
            _loc9_++;
         }
         _loc3_.data["colorValue0"].value = _loc4_;
         _loc3_.data["colorValue1"].value = _loc5_;
         _loc3_.data["colorKey"].value = _loc6_;
         var _loc10_:Array = UtilPlain.getAllShaderObj(this);
         var _loc11_:int = 0;
         while(_loc11_ < _loc10_.length)
         {
            DisplayObject(_loc10_[_loc11_]).blendMode = BlendMode.NORMAL;
            DisplayObject(_loc10_[_loc11_]).blendMode = BlendMode.SHADER;
            DisplayObject(_loc10_[_loc11_]).blendShader = _loc3_;
            _loc11_++;
         }
         return _loc2_;
      }
      
      private function addDefinition(param1:LoaderInfo, param2:String, param3:Object, param4:DisplayObjectContainer, param5:Array) : void
      {
         var tmp:Class = null;
         var mytemp:DisplayObjectContainer = null;
         var mytempchild:DisplayObject = null;
         var i:int = 0;
         var k:int = 0;
         var componentContainer:DisplayObjectContainer = null;
         var colorItems:Array = null;
         var color:Object = null;
         var loaderinfo:LoaderInfo = param1;
         var name:String = param2;
         var properties:Object = param3;
         var container:DisplayObjectContainer = param4;
         var colors:Array = param5;
         var COMPONENT_RIGHT_NAME:String = name + this.LIB_RIGHT;
         var COMPONENT_LEFT_NAME:String = name + this.LIB_LEFT;
         var COMPONENT_RIGHT_SYMBOL_NAME:String = COMPONENT_RIGHT_NAME;
         var COMPONENT_LEFT_SYMBOL_NAME:String = COMPONENT_LEFT_NAME;
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this._lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_RIGHT_SYMBOL_NAME + "_Cam"))
         {
            COMPONENT_RIGHT_SYMBOL_NAME = COMPONENT_RIGHT_SYMBOL_NAME + "_Cam";
         }
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this._lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_LEFT_SYMBOL_NAME + "_Cam"))
         {
            COMPONENT_LEFT_SYMBOL_NAME = COMPONENT_LEFT_SYMBOL_NAME + "_Cam";
         }
         try
         {
            tmp = loaderinfo.applicationDomain.getDefinition(COMPONENT_RIGHT_SYMBOL_NAME) as Class;
            if(tmp != null)
            {
               mytemp = new tmp();
               mytemp.name = COMPONENT_RIGHT_NAME;
               mytempchild = mytemp.getChildAt(0);
               mytemp.x = Number(properties["x"]);
               mytemp.y = Number(properties["y"]);
               mytempchild.scaleX = Number(properties["xscale"]);
               mytempchild.scaleY = Number(properties["yscale"]);
               mytemp.x = mytemp.x - Number(properties["offset"]) / 2;
               mytempchild.rotation = Number(properties["rotation"]);
               componentContainer = UtilPlain.getInstance(container,mytemp.name + this.MC);
               k = componentContainer.numChildren;
               while(k > 0)
               {
                  componentContainer.removeChildAt(k - 1);
                  k--;
               }
               componentContainer.addChild(mytemp);
               if(colors != null)
               {
                  i = 0;
                  while(i < colors.length)
                  {
                     color = colors[i];
                     this.updateColor(color);
                     i++;
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
         try
         {
            tmp = loaderinfo.applicationDomain.getDefinition(COMPONENT_LEFT_SYMBOL_NAME) as Class;
            if(tmp != null)
            {
               mytemp = new tmp();
               mytemp.name = COMPONENT_LEFT_NAME;
               mytempchild = mytemp.getChildAt(0);
               mytemp.x = Number(properties["x"]);
               mytemp.y = Number(properties["y"]);
               mytempchild.scaleX = Number(properties["xscale"]);
               mytempchild.scaleY = Number(properties["yscale"]);
               mytemp.x = mytemp.x + Number(properties["offset"]) / 2;
               mytempchild.rotation = -Number(properties["rotation"]);
               componentContainer = UtilPlain.getInstance(container,mytemp.name + this.MC);
               k = componentContainer.numChildren;
               while(k > 0)
               {
                  componentContainer.removeChildAt(k - 1);
                  k--;
               }
               componentContainer.addChild(mytemp);
               if(colors != null)
               {
                  i = 0;
                  while(i < colors.length)
                  {
                     color = colors[i];
                     this.updateColor(color);
                     i++;
                  }
               }
            }
         }
         catch(e:Error)
         {
         }
         if(name == CcLibConstant.COMPONENT_TYPE_HAIR)
         {
            this.addDefinitionFromParent(CcLibConstant.COMPONENT_TYPE_BACK_HAIR,loaderinfo,name,properties,container,colors);
            this.addDefinitionFromParent(CcLibConstant.COMPONENT_TYPE_FRONT_HAIR,loaderinfo,name,properties,container,colors);
         }
         loaderinfo.loader.dispatchEvent(new Event(Event.INIT));
      }
      
      private function coNumber() : Number
      {
         return this._decoArray.length > 0?Number(this._decoArray.length):Number(100);
      }
      
      private function set charZip(param1:ZipFile) : void
      {
         this._charZip = param1;
      }
      
      public function addLibrary(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:Library;
         (_loc4_ = new Library()).type = param1;
         _loc4_.component_id = param2;
         _loc4_.theme_id = param3;
         this._libraries.push(_loc4_.type,_loc4_);
      }
      
      private function get charXML() : XML
      {
         return this._charXML;
      }
      
      public function get headRect() : Rectangle
      {
         return this._headRect;
      }
      
      public function refreshProp() : void
      {
         var _loc1_:DisplayObjectContainer = null;
         var _loc2_:DisplayObjectContainer = null;
         if(this._hasProp)
         {
            _loc1_ = UtilPlain.getInstance(this,UtilPlain.THE_CHAR);
            _loc2_ = UtilPlain.getProp(_loc1_);
            UtilPlain.removeAllSon(_loc2_);
            this._hasProp = false;
         }
         if(this._prop)
         {
            this.addPropClipToPropContainer(this._prop,this);
            this._hasProp = true;
         }
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function get charZip() : ZipFile
      {
         return this._charZip;
      }
      
      private function onLoadStyleDone(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadStyleDone);
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         var _loc3_:Object = ExtraDataLoader(_loc2_.loader).extraData;
         this.CCM.addStyle(_loc3_["part"],_loc2_);
      }
      
      public function get head() : DisplayObjectContainer
      {
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         if(_loc1_ != null)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function get CCM() : CCManager
      {
         return this._ccm;
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         var _loc2_:* = this._lookAtCamera != param1;
         this._lookAtCamera = param1;
         if(_loc2_)
         {
            this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,this._lookAtCamera));
         }
      }
      
      private function redoWaitingImageData() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         var _loc6_:Sprite = null;
         var _loc7_:ExtraDataLoader = null;
         var _loc1_:DisplayObjectContainer = UtilPlain.getInstance(this,this.DEFAULTHEAD);
         if(_loc1_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD.length)
            {
               (_loc4_ = new Sprite()).name = CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD[_loc3_] + this.MC;
               if(CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD[_loc3_] == CcLibConstant.COMPONENT_TYPE_FACIAL_DECORATION)
               {
                  _loc5_ = this.coNumber();
                  _loc2_ = 0;
                  while(_loc2_ < _loc5_)
                  {
                     _loc6_ = new Sprite();
                     _loc4_.addChild(_loc6_);
                     _loc2_++;
                  }
               }
               _loc1_.addChild(_loc4_);
               _loc3_++;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < this.waiting.length)
         {
            _loc7_ = this.waiting[_loc2_] as ExtraDataLoader;
            this.doLoadImageData(_loc7_);
            _loc2_++;
         }
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      private function updatePropSize(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : void
      {
         var prop:DisplayObjectContainer = param1;
         var propContainer:DisplayObjectContainer = param2;
         if(prop != null)
         {
            try
            {
               prop.scaleX = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,prop,UtilPlain.PROPERTY_SCALEX));
               prop.scaleY = Math.abs(1 / UtilPlain.getRelativeProperty(propContainer,prop,UtilPlain.PROPERTY_SCALEY));
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function getSkeletonContainer(param1:Number = 0) : DisplayObjectContainer
      {
         var _loc2_:DisplayObjectContainer = null;
         switch(param1)
         {
            case 2:
               _loc2_ = UtilPlain.getInstance(this,CcLibConstant.COMPONENT_TYPE_FREEACTION);
               break;
            default:
               _loc2_ = UtilPlain.getInstance(this,CcLibConstant.COMPONENT_TYPE_SKELETON);
         }
         return _loc2_;
      }
      
      private function hideColorItems(param1:Array) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            DisplayObject(param1[_loc2_]).alpha = 0;
            _loc2_++;
         }
      }
   }
}

class Library
{
    
   
   private var _theme_id:String;
   
   private var _type:String;
   
   private var _component_id:String;
   
   function Library()
   {
      super();
   }
   
   public function get type() : String
   {
      return this._type;
   }
   
   public function set theme_id(param1:String) : void
   {
      this._theme_id = param1;
   }
   
   public function get theme_id() : String
   {
      return this._theme_id;
   }
   
   public function set type(param1:String) : void
   {
      this._type = param1;
   }
   
   public function set component_id(param1:String) : void
   {
      this._component_id = param1;
   }
   
   public function get component_id() : String
   {
      return this._component_id;
   }
}
