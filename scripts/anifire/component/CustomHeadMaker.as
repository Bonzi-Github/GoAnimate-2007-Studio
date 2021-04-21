package anifire.component
{
   import anifire.color.SelectedColor;
   import anifire.constant.CcLibConstant;
   import anifire.core.CCLipSyncController;
   import anifire.event.ExtraDataEvent;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.event.LoadMgrEvent;
   import anifire.event.SpeechPitchEvent;
   import anifire.util.ExtraDataLoader;
   import anifire.util.UtilColor;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.errors.*;
   import flash.events.*;
   import flash.utils.ByteArray;
   
   public class CustomHeadMaker extends MovieClip
   {
      
      public static const COMPONENT_NEEDS_REPLACE:String = "event_replace_comp";
      
      public static const STATE_FINISH_LOAD:String = "finish_load";
      
      public static const STATE_NULL:String = "null";
      
      public static const STATE_LOADING:String = "loading";
       
      
      private const DEFAULTHEAD:String = "defaultHead";
      
      private const LOWERBODY:String = "lower_body";
      
      private var should_decrypt:Boolean = true;
      
      private var _headSwfs:UtilHashArray;
      
      private const CLIPLOWER:String = "theLower";
      
      private var _state:String;
      
      private var _useSpeechMouth:Boolean = false;
      
      private const BODYSHAPE:String = "bodyshape";
      
      private const LIB_LEFT:String = "Left";
      
      private const SWF_EXT:String = ".swf";
      
      private const LIB_RIGHT:String = "Right";
      
      private const UPPERBODY:String = "upper_body";
      
      private var _decorationQueue:Array;
      
      private const CLIPUPPER:String = "theUpper";
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _shouldPauseOnLoadByteComplete:Boolean;
      
      private const SKELETON:String = "skeleton";
      
      private var _lipMouth:Boolean = false;
      
      private var _lookAtCamera:Boolean = false;
      
      private var _headXML:XML;
      
      private const XML_DESC:String = "desc.xml";
      
      private const NODE_COMPONENT:String = "component";
      
      private var _demoSpeech:Boolean = false;
      
      private var _componentOrder:Array;
      
      public function CustomHeadMaker()
      {
         this._componentOrder = CcLibConstant.GET_COMPONENT_ORDER_IN_HEAD;
         this._decorationQueue = new Array();
         super();
         this.state = STATE_NULL;
         this._eventDispatcher = new EventDispatcher();
      }
      
      private function onReady(param1:Event) : void
      {
         var _loc2_:XML = null;
         var _loc3_:SelectedColor = null;
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onReady);
         for each(_loc2_ in this.headXML.child(CcLibConstant.NODE_COLOR))
         {
            _loc3_ = new SelectedColor(_loc2_.@r,String(_loc2_.@oc).length == 0?uint(uint.MAX_VALUE):uint(_loc2_.@oc),uint(_loc2_));
            this.changeColor(_loc3_,_loc2_.@targetComponent == null?"":_loc2_.@targetComponent);
         }
         UtilPlain.gotoAndStopFamilyAt1(this);
         if(!this.shouldPauseOnLoadBytesComplete)
         {
            UtilPlain.playFamily(this);
         }
         this.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
         this.eventDispatcher.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
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
      
      private function get headXML() : XML
      {
         return this._headXML;
      }
      
      private function get state() : String
      {
         return this._state;
      }
      
      public function get demoSpeech() : Boolean
      {
         return this._demoSpeech;
      }
      
      public function init(param1:XML, param2:Number = 0, param3:Number = 0, param4:UtilHashArray = null, param5:UtilHashArray = null, param6:Boolean = false, param7:Boolean = false) : void
      {
         this.useSpeechMouth = param6;
         var _loc8_:CcActionLoader;
         (_loc8_ = new CcActionLoader()).addEventListener(IOErrorEvent.IO_ERROR,this.onCcActionFailed);
         _loc8_.addEventListener(Event.COMPLETE,this.onCcActionLoaded);
         _loc8_.loadCcComponents(param1,param2,param3,param4,param5,1,param7);
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
            for each(node in this.headXML.child(this.NODE_COMPONENT))
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
                        colorXMLNode = headXML.color.(@r == item);
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
                  bytes = this.headSwfs.getValueByKey(swfkey);
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
      
      private function set headXML(param1:XML) : void
      {
         this._headXML = param1;
      }
      
      private function get headSwfs() : UtilHashArray
      {
         return this._headSwfs;
      }
      
      public function set shouldPauseOnLoadBytesComplete(param1:Boolean) : void
      {
         this._shouldPauseOnLoadByteComplete = param1;
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
         }
         catch(e:Error)
         {
         }
      }
      
      private function doUpdateState(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doUpdateState);
         this.state = STATE_FINISH_LOAD;
      }
      
      private function updateColor(param1:Object) : void
      {
         var _loc2_:SelectedColor = new SelectedColor(param1["colorReference"],param1["originalColor"],param1["colorValue"]);
         this.changeColor(_loc2_,param1["targetComponentId"]);
      }
      
      public function initByXml(param1:XML) : void
      {
         var _loc2_:CcActionLoader = new CcActionLoader();
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onCcActionFailed);
         _loc2_.addEventListener(Event.COMPLETE,this.onCcActionLoaded);
         _loc2_.loadCcComponents(param1);
      }
      
      public function unloadAssetImage(param1:Boolean) : void
      {
         this.destroy(param1);
      }
      
      public function set demoSpeech(param1:Boolean) : void
      {
         var _loc2_:* = this._demoSpeech != param1;
         this._demoSpeech = param1;
      }
      
      private function onCcActionFailed(param1:IOErrorEvent) : void
      {
         trace("init cc failed!");
      }
      
      private function addDefinition(param1:LoaderInfo, param2:String, param3:Object) : void
      {
         var tmp:Class = null;
         var mytemp:DisplayObjectContainer = null;
         var mytempchild:DisplayObject = null;
         var k:int = 0;
         var componentContainer:DisplayObjectContainer = null;
         var index:int = 0;
         var loaderinfo:LoaderInfo = param1;
         var name:String = param2;
         var properties:Object = param3;
         var COMPONENT_RIGHT_NAME:String = name + this.LIB_RIGHT;
         var COMPONENT_LEFT_NAME:String = name + this.LIB_LEFT;
         var COMPONENT_RIGHT_SYMBOL_NAME:String = COMPONENT_RIGHT_NAME;
         var COMPONENT_LEFT_SYMBOL_NAME:String = COMPONENT_LEFT_NAME;
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this.lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_RIGHT_SYMBOL_NAME + "_Cam"))
         {
            COMPONENT_RIGHT_SYMBOL_NAME = COMPONENT_RIGHT_SYMBOL_NAME + "_Cam";
         }
         if(name == CcLibConstant.COMPONENT_TYPE_EYE && this.lookAtCamera && loaderinfo.applicationDomain.hasDefinition(COMPONENT_LEFT_SYMBOL_NAME + "_Cam"))
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
               mytemp.x = mytemp.x + Number(properties["x"]);
               mytemp.y = mytemp.y + Number(properties["y"]);
               mytempchild.scaleX = Number(properties["xscale"]);
               mytempchild.scaleY = Number(properties["yscale"]);
               mytemp.x = mytemp.x - Number(properties["offset"]) / 2;
               mytempchild.rotation = Number(properties["rotation"]);
               index = this._componentOrder.indexOf(mytemp.name);
               if(mytemp != null)
               {
                  componentContainer = UtilPlain.getInstance(this,mytemp.name + CcLibConstant.MC_NAME_EXT);
                  k = componentContainer.numChildren;
                  while(k > 0)
                  {
                     componentContainer.removeChildAt(k - 1);
                     k--;
                  }
                  componentContainer.addChild(mytemp);
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
               mytemp.x = mytemp.x + Number(properties["x"]);
               mytemp.y = mytemp.y + Number(properties["y"]);
               mytempchild.scaleX = Number(properties["xscale"]);
               mytempchild.scaleY = Number(properties["yscale"]);
               mytemp.x = mytemp.x + Number(properties["offset"]) / 2;
               mytempchild.rotation = -Number(properties["rotation"]);
               index = this._componentOrder.indexOf(mytemp.name);
               if(mytemp != null)
               {
                  componentContainer = UtilPlain.getInstance(this,mytemp.name + CcLibConstant.MC_NAME_EXT);
                  k = componentContainer.numChildren;
                  while(k > 0)
                  {
                     componentContainer.removeChildAt(k - 1);
                     k--;
                  }
                  componentContainer.addChild(mytemp);
               }
            }
         }
         catch(e:Error)
         {
         }
         if(name == CcLibConstant.COMPONENT_TYPE_HAIR)
         {
            this.addDefinitionFromParent(CcLibConstant.COMPONENT_TYPE_BACK_HAIR,loaderinfo,name,properties,this);
            this.addDefinitionFromParent(CcLibConstant.COMPONENT_TYPE_FRONT_HAIR,loaderinfo,name,properties,this);
         }
      }
      
      private function replaceChild(param1:ExtraDataEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.replaceChild);
         removeChild(param1.getData().old);
         addChild(param1.getData().replacement);
      }
      
      public function removeComponentById(param1:String) : void
      {
         var _loc2_:DisplayObjectContainer = null;
         _loc2_ = UtilPlain.getInstance(this,param1);
         var _loc3_:DisplayObjectContainer = _loc2_.parent;
         var _loc4_:int = _loc3_.numChildren - 1;
         while(_loc4_ >= 0)
         {
            if(_loc3_.getChildAt(_loc4_).name == param1)
            {
               _loc3_.removeChildAt(_loc4_);
            }
            _loc4_--;
         }
      }
      
      private function set state(param1:String) : void
      {
         this._state = param1;
      }
      
      public function get shouldPauseOnLoadBytesComplete() : Boolean
      {
         return this._shouldPauseOnLoadByteComplete;
      }
      
      public function initBySwfs(param1:XML, param2:UtilHashArray) : void
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:XML = null;
         var _loc8_:Sprite = null;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Sprite = null;
         this.destroy();
         this.should_decrypt = false;
         this._decorationQueue = new Array();
         this.headXML = param1;
         this.headSwfs = param2;
         var _loc3_:int = 0;
         while(_loc3_ < this._componentOrder.length)
         {
            (_loc8_ = new Sprite()).name = this._componentOrder[_loc3_] + CcLibConstant.MC_NAME_EXT;
            if(this._componentOrder[_loc3_] == CcLibConstant.COMPONENT_TYPE_FACIAL_DECORATION)
            {
               _loc9_ = this.coNumber();
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  _loc11_ = new Sprite();
                  _loc8_.addChild(_loc11_);
                  _loc10_++;
               }
            }
            this.addChild(_loc8_);
            _loc3_++;
         }
         var _loc7_:UtilLoadMgr;
         (_loc7_ = new UtilLoadMgr()).addEventListener(LoadMgrEvent.ALL_COMPLETE,this.onReady);
         for each(_loc6_ in this.headXML.child(this.NODE_COMPONENT))
         {
            if(_loc6_.@type != this.SKELETON && _loc6_.@type != CcLibConstant.COMPONENT_TYPE_FREEACTION && _loc6_.@type != this.BODYSHAPE && _loc6_.@type != this.UPPERBODY && _loc6_.@type != this.LOWERBODY)
            {
               if(_loc6_.@type == CcLibConstant.COMPONENT_TYPE_MOUTH && (this.demoSpeech || this.useSpeechMouth))
               {
                  if(this._useSpeechMouth)
                  {
                     _loc4_ = _loc6_.@theme_id + "." + _loc6_.@type + "." + CCLipSyncController.LIPSYNC_LIB_ID;
                  }
                  else if(this.demoSpeech)
                  {
                     _loc4_ = _loc6_.@theme_id + "." + _loc6_.@type + "." + CCLipSyncController.DEMO_LIPSYNC_LIB_ID;
                  }
               }
               else
               {
                  _loc4_ = _loc6_.@theme_id + "." + _loc6_.@type + "." + _loc6_.@component_id + this.SWF_EXT;
               }
               _loc5_ = {
                  "x":_loc6_.@x,
                  "y":_loc6_.@y,
                  "xscale":_loc6_.@xscale,
                  "yscale":_loc6_.@yscale,
                  "offset":_loc6_.@offset,
                  "rotation":_loc6_.@rotation
               };
               this.updateComponentImageData(_loc6_.@type,this.headSwfs.getValueByKey(_loc4_),_loc5_,_loc7_,null,_loc6_.@id);
            }
         }
         _loc7_.commit();
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function set headSwfs(param1:UtilHashArray) : void
      {
         this._headSwfs = param1;
      }
      
      private function addDefinitionFromParent(param1:String, param2:LoaderInfo, param3:String, param4:Object, param5:DisplayObjectContainer) : void
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
         componentContainer = UtilPlain.getInstance(container,className + CcLibConstant.MC_NAME_EXT);
         k = componentContainer.numChildren;
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
                  break;
               }
               break;
            }
            catch(e:Error)
            {
               addr199:
               return;
            }
         }
         §§goto(addr199);
      }
      
      private function updateComponentImageData(param1:String, param2:ByteArray, param3:Object, param4:UtilLoadMgr, param5:Array = null, param6:String = "") : void
      {
         var loader:ExtraDataLoader = null;
         var decryptEngine:UtilCrypto = null;
         var index:int = 0;
         var componentContainer:DisplayObjectContainer = null;
         var componentType:String = param1;
         var swfByteArray:ByteArray = param2;
         var properties:Object = param3;
         var loadMgr:UtilLoadMgr = param4;
         var colors:Array = param5;
         var id:String = param6;
         if(this.should_decrypt)
         {
            decryptEngine = new UtilCrypto();
            decryptEngine.decrypt(swfByteArray);
         }
         loader = new ExtraDataLoader();
         loadMgr.addEventDispatcher(loader,Event.INIT);
         loader.extraData = {
            "componentType":componentType,
            "properties":properties,
            "colors":colors
         };
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadedComponent);
         if(id.length == 0)
         {
            loader.name = componentType;
         }
         else
         {
            loader.name = id;
         }
         loader.loadBytes(swfByteArray);
         if(this._componentOrder.indexOf(componentType) != -1)
         {
            index = this._componentOrder.indexOf(componentType);
            componentContainer = UtilPlain.getInstance(this,componentType + CcLibConstant.MC_NAME_EXT);
            if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(componentType) > -1)
            {
               this._decorationQueue.push(loader);
               DisplayObjectContainer(componentContainer.getChildAt(this._decorationQueue.length - 1)).addChild(loader);
            }
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
      
      private function coNumber() : Number
      {
         return this.headXML.component.(@type == CcLibConstant.COMPONENT_TYPE_FACIAL_DECORATION).length();
      }
      
      public function set lookAtCamera(param1:Boolean) : void
      {
         this._lookAtCamera = param1;
         this.dispatchEvent(new ExtraDataEvent(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,this,param1));
      }
      
      public function get lookAtCamera() : Boolean
      {
         return this._lookAtCamera;
      }
      
      private function loadedComponent(param1:Event) : void
      {
         var componentType:String = null;
         var properties:Object = null;
         var loaderInfo:LoaderInfo = null;
         var index:int = 0;
         var componentContainer:DisplayObjectContainer = null;
         var k:int = 0;
         var mytemp:DisplayObject = null;
         var mytempchild:DisplayObject = null;
         var color:Object = null;
         var i:int = 0;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.loadedComponent);
         var loader:ExtraDataLoader = ExtraDataLoader(LoaderInfo(event.currentTarget).loader);
         var exdata:Object = ExtraDataLoader(LoaderInfo(event.currentTarget).loader).extraData;
         componentType = exdata["componentType"];
         properties = exdata["properties"];
         var colors:Array = exdata["colors"];
         loaderInfo = LoaderInfo(event.currentTarget);
         if(this._componentOrder.indexOf(componentType) != -1)
         {
            index = this._componentOrder.indexOf(componentType);
            componentContainer = UtilPlain.getInstance(this,componentType + CcLibConstant.MC_NAME_EXT);
            if(CcLibConstant.ALL_MULTIPLE_COMPONENT_TYPES.indexOf(componentType) <= -1)
            {
               k = componentContainer.numChildren;
               while(k > 0)
               {
                  componentContainer.removeChildAt(k - 1);
                  k--;
               }
               componentContainer.addChild(loader);
            }
         }
         loader.dispatchEvent(new Event(Event.INIT));
         if(this._componentOrder.indexOf(componentType) == -1)
         {
            if(componentType == CcLibConstant.COMPONENT_TYPE_EYE && (loaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_RIGHT + "_Cam") || loaderInfo.applicationDomain.hasDefinition(componentType + this.LIB_LEFT + "_Cam")))
            {
               addEventListener(CustomCharacterMaker.LOOK_AT_CAMERA_CHANGED,function(param1:ExtraDataEvent):void
               {
                  var node:XML = null;
                  var color:SelectedColor = null;
                  var e:ExtraDataEvent = param1;
                  addEventListener(COMPONENT_NEEDS_REPLACE,replaceChild);
                  addDefinition(loaderInfo,componentType,properties);
                  var colorNames:Array = CcLibConstant.COLORS_BY_COMPONENT(componentType);
                  if(colorNames)
                  {
                     var _loc3_:int = 0;
                     for each(node in headXML.child(CcLibConstant.NODE_COLOR).(colorNames.indexOf(String(@r)) >= 0))
                     {
                        color = new SelectedColor(node.@r,String(node.@oc).length == 0?uint(uint.MAX_VALUE):uint(node.@oc),uint(node));
                        changeColor(color,node.@targetComponent == null?"":node.@targetComponent);
                     }
                  }
                  removeEventListener(COMPONENT_NEEDS_REPLACE,replaceChild);
               });
            }
            this.addDefinition(loaderInfo,componentType,properties);
         }
         else
         {
            mytemp = ExtraDataLoader(LoaderInfo(event.currentTarget).loader);
            mytempchild = ExtraDataLoader(LoaderInfo(event.currentTarget).loader).getChildAt(0);
            mytemp.x = mytemp.x + Number(properties["x"]);
            mytemp.y = mytemp.y + Number(properties["y"]);
            mytempchild.scaleX = Number(properties["xscale"]);
            mytempchild.scaleY = Number(properties["yscale"]);
            mytempchild.rotation = Number(properties["rotation"]);
            if(componentType == CcLibConstant.COMPONENT_TYPE_HAIR)
            {
               this.addDefinition(loaderInfo,componentType,properties);
            }
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
      
      public function destroy(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = UtilPlain.getLoaderItem(this);
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
         this._decorationQueue = new Array();
      }
      
      private function set useSpeechMouth(param1:Boolean) : void
      {
         this._useSpeechMouth = param1;
      }
      
      private function get useSpeechMouth() : Boolean
      {
         return this._useSpeechMouth;
      }
   }
}
