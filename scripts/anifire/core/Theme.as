package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.constant.ThemeEmbedConstant;
   import anifire.event.LoadMgrEvent;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLoadMgr;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import anifire.util.UtilXmlInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import mx.controls.Alert;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Theme
   {
      
      private static var _logger:ILogger = Log.getLogger("core.Theme");
       
      
      private var _console:Console;
      
      private var _isPropZipLoaded:Boolean = false;
      
      private var _isLoadingChar:Boolean = false;
      
      private var _effectThumbs:UtilHashArray;
      
      private var _defaultBgThumb:BackgroundThumb;
      
      private var _isLoadingProp:Boolean = false;
      
      private var _isBgZipLoaded:Boolean = false;
      
      private var _defaultCharThumb:CharThumb;
      
      private var _propThumbs:UtilHashArray;
      
      private var _defaultPropThumb:PropThumb;
      
      private var _name:String;
      
      private var _isCharZipLoaded:Boolean = false;
      
      private var _backgroundThumbs:UtilHashArray;
      
      private var _soundThumbs:UtilHashArray;
      
      private var _cc_theme_id:String;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _id:String;
      
      private var _purchasedContent:XMLList;
      
      private var _isLoadingBg:Boolean = false;
      
      private var _isThemeZipLoaded:Boolean = false;
      
      private var _bubbleThumbs:UtilHashArray;
      
      private var _themeXML:XML;
      
      private var _charThumbs:UtilHashArray;
      
      public function Theme()
      {
         super();
         _logger.debug("Theme initialized");
         this._backgroundThumbs = new UtilHashArray();
         this._charThumbs = new UtilHashArray();
         this._bubbleThumbs = new UtilHashArray();
         this._propThumbs = new UtilHashArray();
         this._soundThumbs = new UtilHashArray();
         this._effectThumbs = new UtilHashArray();
         this._themeXML = null;
         this._eventDispatcher = new EventDispatcher();
         this._purchasedContent = new XMLList();
      }
      
      public static function merge2ThemeXml(param1:XML, param2:XML, param3:String, param4:String, param5:Boolean = false) : XML
      {
         return UtilXmlInfo.merge2ThemeXml(param1,param2,param3,param4,param5);
      }
      
      public function getEffectThumbById(param1:String) : EffectThumb
      {
         return EffectThumb(this._effectThumbs.getValueByKey(param1));
      }
      
      public function getThemeXML() : XML
      {
         return this._themeXML;
      }
      
      public function get bubbleThumbs() : UtilHashArray
      {
         return this._bubbleThumbs;
      }
      
      public function getBackgroundThumbById(param1:String) : BackgroundThumb
      {
         return this._backgroundThumbs.getValueByKey(param1) as BackgroundThumb;
      }
      
      private function onLoadCharSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCharSecurityError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingChar = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading chars",param1.type);
      }
      
      private function setThemeXML(param1:XML) : void
      {
         if(this._themeXML == null)
         {
            this._themeXML = param1;
         }
         else
         {
            this.mergeThemeXML(param1);
         }
      }
      
      private function doLoadThemeByThemeTreeCompleted(param1:Event) : void
      {
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEMETREE_COMPLETE,this));
      }
      
      public function get defaultBgThumb() : BackgroundThumb
      {
         return this._defaultBgThumb;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function initThemeByThemeTree(param1:ThemeTree, param2:XML, param3:ZipFile, param4:Console) : void
      {
         var _loc5_:int = 0;
         var _loc6_:UtilHashArray = null;
         var _loc7_:String = null;
         var _loc8_:ByteArray = null;
         var _loc10_:* = null;
         var _loc11_:BackgroundThumb = null;
         var _loc12_:PropThumb = null;
         var _loc13_:SoundThumb = null;
         var _loc14_:EffectThumb = null;
         var _loc15_:CharThumb = null;
         this.console = param4;
         this.id = param1.getThemeID();
         this.deSerialize(param2);
         var _loc9_:UtilLoadMgr = new UtilLoadMgr();
         _loc6_ = param1.getBgThumbs();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc7_ = _loc6_.getKey(_loc5_);
            _loc8_ = _loc6_.getValueByIndex(_loc5_);
            if((_loc11_ = this.getBackgroundThumbById(_loc7_)) != null)
            {
               _loc11_.imageData = _loc8_;
            }
            _loc5_++;
         }
         _loc6_ = param1.getPropThumbs();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            if((_loc7_ = _loc6_.getKey(_loc5_)).indexOf(".head.") != -1)
            {
               _loc7_ = UtilXmlInfo.getFacialThumbIdFromFileName(_loc7_);
            }
            if((_loc12_ = this.getPropThumbById(_loc7_)) != null)
            {
               if(_loc12_.getStateNum() > 0)
               {
                  _loc10_ = this.id + ".prop." + _loc7_ + ".";
                  _loc12_.initImageData(param3,_loc10_);
               }
               else
               {
                  _loc8_ = _loc6_.getValueByIndex(_loc5_);
                  _loc12_.imageData = _loc8_;
               }
            }
            _loc5_++;
         }
         _loc6_ = param1.getSoundThumbs();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc7_ = _loc6_.getKey(_loc5_);
            _loc8_ = _loc6_.getValueByIndex(_loc5_);
            _loc9_.addEventDispatcher(this.getSoundThumbById(_loc7_).eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            if((_loc13_ = this.getSoundThumbById(_loc7_)) != null)
            {
               _loc13_.initSoundByByteArray(_loc8_);
            }
            _loc5_++;
         }
         _loc6_ = param1.getEffectThumbs();
         _loc5_ = 0;
         while(_loc5_ < this._effectThumbs.length)
         {
            _loc7_ = _loc6_.getKey(_loc5_);
            _loc8_ = _loc6_.getValueByIndex(_loc5_);
            if((_loc14_ = this.getEffectThumbById(_loc7_)) != null && _loc14_.getType() == EffectThumb.TYPE_ANIME)
            {
               _loc14_.imageData = _loc8_;
            }
            _loc5_++;
         }
         _loc6_ = param1.getCharThumbs();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc7_ = _loc6_.getKey(_loc5_);
            _loc15_ = this.getCharThumbById(_loc7_);
            _loc9_.addEventDispatcher(_loc15_.eventDispatcher,CoreEvent.LOAD_THUMB_COMPLETE);
            _loc10_ = this.id + ".char." + _loc7_ + ".";
            if(_loc15_ != null)
            {
               _loc15_.initImageData(param3,_loc10_);
            }
            _loc5_++;
         }
         _loc9_.addEventListener(LoadMgrEvent.ALL_COMPLETE,this.doLoadThemeByThemeTreeCompleted);
         _loc9_.commit();
      }
      
      private function onLoadPropSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadPropSecurityError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingProp = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading props",param1.type);
      }
      
      private function doLoadXMLBytesComplete(param1:IDataInput) : void
      {
         var _loc2_:ZipFile = new ZipFile(param1);
         this.deSerialize(new XML(_loc2_.getInput(_loc2_.getEntry("theme.xml"))));
         this._eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this));
      }
      
      public function get backgroundThumbs() : UtilHashArray
      {
         return this._backgroundThumbs;
      }
      
      private function onLoadPropIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadPropIOError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingProp = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading props",param1.type);
      }
      
      public function isBgZipLoaded() : Boolean
      {
         return this._isBgZipLoaded;
      }
      
      private function doLoadThumbTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbTimeOut);
         Console.getConsole().requestLoadStatus(false,true);
         Console.getConsole().loadProgressVisible = false;
         Alert.show("Operation timeout");
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(param1);
      }
      
      private function onLoadBgSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadBgSecurityError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingBg = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading backgrounds",param1.type);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         return this._eventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function get soundThumbs() : UtilHashArray
      {
         return this._soundThumbs;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get effectThumbs() : UtilHashArray
      {
         return this._effectThumbs;
      }
      
      public function get cc_theme_id() : String
      {
         return this._cc_theme_id;
      }
      
      public function get charThumbs() : UtilHashArray
      {
         return this._charThumbs;
      }
      
      public function get console() : Console
      {
         return this._console;
      }
      
      private function loadXML() : void
      {
         var _loc1_:URLRequest = UtilNetwork.getGetThemeRequest(this.id,!Console.getConsole().isThemeCcRelated(this.id));
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
         _loc2_.addEventListener(Event.COMPLETE,this.doLoadXMLComplete);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.doLoadThumbIOError);
         _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doLoadThumbSecurityError);
         _loc2_.dataFormat = URLLoaderDataFormat.BINARY;
         _loc2_.load(_loc1_);
      }
      
      public function isPropZipLoaded() : Boolean
      {
         return this._isPropZipLoaded;
      }
      
      public function loadChar() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingChar)
         {
            if(this.isCharZipLoaded())
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_CHAR_COMPLETE,this));
            }
            this._isLoadingChar = true;
            Console.getConsole().requestLoadStatus(true,true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.id,null,ServerConstants.PARAM_CHAR);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.onLoadCharComplete);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadCharTimeOut);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadCharSecurityError);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadCharIOError);
            _loc2_.load(_loc1_);
         }
      }
      
      public function deSerialize(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:CharThumb = null;
         var _loc5_:PropThumb = null;
         var _loc6_:BackgroundThumb = null;
         var _loc7_:BackgroundThumb = null;
         var _loc8_:PropThumb = null;
         var _loc9_:SoundThumb = null;
         var _loc10_:BubbleThumb = null;
         var _loc11_:EffectThumb = null;
         var _loc12_:String = null;
         this.setThemeXML(param1);
         this.id = param1.@id;
         this.cc_theme_id = param1.@cc_theme_id;
         for each(_loc2_ in param1.child(CharThumb.XML_NODE_NAME))
         {
            if(this.getCharThumbById(_loc2_.@id) == null)
            {
               (_loc4_ = new CharThumb()).deSerialize(_loc2_,this);
               _loc4_.xml = _loc2_;
               this.addThumb(_loc4_);
            }
            if(_loc2_.facial.length() > 0)
            {
               (_loc5_ = new PropThumb()).deSerializeFacial(_loc2_,this);
               this.addThumb(_loc5_);
            }
         }
         for each(_loc2_ in param1.child(BackgroundThumb.XML_NODE_NAME_CBG))
         {
            if(this.getBackgroundThumbById(_loc2_.@id) == null)
            {
               _loc6_ = new BackgroundThumb();
               Console.getConsole().addStoreCollection(_loc2_.@name);
               _loc6_.deSerialize(_loc2_,this,true);
               this.addThumb(_loc6_);
               if(_loc2_.attribute("default") == "Y")
               {
                  _loc6_.isDefault = true;
                  this._defaultBgThumb = _loc6_;
               }
            }
         }
         for each(_loc2_ in param1.child(BackgroundThumb.XML_NODE_NAME))
         {
            if(this.getBackgroundThumbById(_loc2_.@id) == null)
            {
               _loc7_ = new BackgroundThumb();
               Console.getConsole().addStoreCollection(_loc2_.@name);
               _loc7_.deSerialize(_loc2_,this);
               this.addThumb(_loc7_);
               if(_loc2_.attribute("default") == "Y")
               {
                  _loc7_.isDefault = true;
                  this._defaultBgThumb = _loc7_;
               }
            }
         }
         for each(_loc2_ in param1.child(PropThumb.XML_NODE_NAME))
         {
            if(this.getPropThumbById(_loc2_.@id) == null)
            {
               if(_loc2_.@subtype == AnimeConstants.ASSET_TYPE_PROP_VIDEO)
               {
                  _loc8_ = new VideoPropThumb();
               }
               else
               {
                  _loc8_ = new PropThumb();
               }
               Console.getConsole().addStoreCollection(_loc2_.@name);
               _loc8_.deSerialize(_loc2_,this);
               _loc8_.xml = _loc2_;
               this.addThumb(_loc8_);
               if(_loc2_.attribute("default") == "Y")
               {
                  this._defaultPropThumb = _loc8_;
               }
            }
         }
         for each(_loc2_ in param1.child(SoundThumb.XML_NODE_NAME))
         {
            if(this.getSoundThumbById(_loc2_.@id) == null)
            {
               (_loc9_ = new SoundThumb()).deSerialize(_loc2_,this);
               _loc9_.xml = _loc2_;
               this.addThumb(_loc9_);
            }
         }
         for each(_loc2_ in param1.child(BubbleThumb.XML_NODE_NAME))
         {
            if(this.getBubbleThumbById(_loc2_.@id) == null)
            {
               (_loc10_ = new BubbleThumb()).deSerialize(_loc2_,this);
               _loc10_.xml = _loc2_;
               this.addThumb(_loc10_);
            }
         }
         for each(_loc2_ in param1.child(EffectThumb.XML_NODE_NAME))
         {
            if(this.getEffectThumbById(_loc2_.@id) == null)
            {
               _loc11_ = new EffectThumb();
               Console.getConsole().addStoreCollection(_loc2_.@name);
               _loc11_.deSerialize(_loc2_,this);
               _loc11_.xml = _loc2_;
               this.addThumb(_loc11_);
            }
         }
         for each(_loc2_ in param1.child("presetMsg"))
         {
            _loc12_ = _loc2_.@quote;
            PresetMsg.getInstance().insertMsg(this.id,_loc12_);
         }
      }
      
      private function doLoadThumbSecurityError(param1:SecurityErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbSecurityError);
         Console.getConsole().requestLoadStatus(false,true);
         Console.getConsole().loadProgressVisible = false;
         Alert.show("Error in loading thumbs",param1.type);
      }
      
      private function onLoadBgTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadBgTimeOut);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingBg = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Operation timeout");
      }
      
      public function loadProp() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingProp)
         {
            if(this.isPropZipLoaded())
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_PROP_COMPLETE,this));
            }
            this._isLoadingProp = true;
            Console.getConsole().requestLoadStatus(true,true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.id,null,ServerConstants.PARAM_PROP);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.onLoadPropComplete);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadPropTimeOut);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadPropSecurityError);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadPropIOError);
            _loc2_.load(_loc1_);
         }
      }
      
      public function getCharThumbById(param1:String) : CharThumb
      {
         return this._charThumbs.getValueByKey(param1) as CharThumb;
      }
      
      private function onLoadCharTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCharTimeOut);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingChar = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Operation timeout");
      }
      
      public function getSoundThumbById(param1:String) : SoundThumb
      {
         return this._soundThumbs.getValueByKey(param1) as SoundThumb;
      }
      
      public function mergeTheme(param1:Theme) : void
      {
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = 0;
            _loc2_ = 0;
            while(_loc2_ < param1.charThumbs.length)
            {
               param1.getCharThumbById(param1.charThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getCharThumbById(param1.charThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.backgroundThumbs.length)
            {
               param1.getBackgroundThumbById(param1.backgroundThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getBackgroundThumbById(param1.backgroundThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.bubbleThumbs.length)
            {
               param1.getBubbleThumbById(param1.bubbleThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getBubbleThumbById(param1.bubbleThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.effectThumbs.length)
            {
               param1.getEffectThumbById(param1.effectThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getEffectThumbById(param1.effectThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.propThumbs.length)
            {
               param1.getPropThumbById(param1.propThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getPropThumbById(param1.propThumbs.getKey(_loc2_)));
               _loc2_++;
            }
            _loc2_ = 0;
            while(_loc2_ < param1.soundThumbs.length)
            {
               param1.getSoundThumbById(param1.soundThumbs.getKey(_loc2_)).theme = this;
               this.addThumb(param1.getSoundThumbById(param1.soundThumbs.getKey(_loc2_)));
               _loc2_++;
            }
         }
      }
      
      public function assetPurchased(param1:String) : Boolean
      {
         var aiid:String = param1;
         if(Console.getConsole().premiumEnabled())
         {
            if(this._purchasedContent.(@aid == aiid).length() > 0)
            {
               if(this._purchasedContent.(@aid == aiid)[0].@expired == "N")
               {
                  return true;
               }
            }
            return false;
         }
         return true;
      }
      
      public function getBubbleThumbById(param1:String) : BubbleThumb
      {
         return this._bubbleThumbs.getValueByKey(param1) as BubbleThumb;
      }
      
      public function setThumbNodeFromXML(param1:XML, param2:String) : XML
      {
         var cxml:XML = param1;
         var idd:String = param2;
         if(this._themeXML != null)
         {
            this._themeXML.children().(@id == idd)[0] = cxml;
            return this._themeXML.children().(@id == idd)[0];
         }
         return null;
      }
      
      public function modifyPremiumContent(param1:XMLList) : void
      {
         if(this._purchasedContent == null)
         {
            this._purchasedContent = param1;
         }
         else
         {
            this._purchasedContent = this._purchasedContent + param1;
         }
      }
      
      private function doLoadThumbBytesComplete(param1:IDataInput) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Thumb = null;
         var _loc5_:ZipEntry = null;
         var _loc6_:UtilCrypto = null;
         var _loc8_:ByteArray = null;
         var _loc9_:UtilHashArray = null;
         var _loc10_:Number = NaN;
         var _loc2_:ZipFile = new ZipFile(param1);
         this.deSerialize(new XML(_loc2_.getInput(_loc2_.getEntry("theme.xml"))));
         var _loc7_:Boolean = this.id != "ugc"?true:false;
         _loc3_ = 0;
         while(_loc3_ < this._charThumbs.length)
         {
            _loc4_ = this._charThumbs.getValueByIndex(_loc3_) as Thumb;
            if((_loc5_ = _loc2_.getEntry(_loc4_.getFileName())) == null)
            {
               _logger.error("An entry \'" + _loc4_.getFileName() + "\' is not found, probably due to un-Matching between theme.xml and the [theme].zip");
            }
            else
            {
               _loc4_.imageData = _loc2_.getInput(_loc5_);
               if(_loc7_)
               {
                  (_loc6_ = new UtilCrypto()).decrypt(_loc4_.imageData as ByteArray);
               }
            }
            _loc3_++;
         }
         if(this.id != "common")
         {
            if((_loc4_ = this._defaultBgThumb as Thumb) != null)
            {
               if(BackgroundThumb(_loc4_).isComposite)
               {
                  _loc9_ = new UtilHashArray();
                  _loc9_ = this.doOutputThumbs(BackgroundThumb(_loc4_).xml);
                  _loc10_ = 0;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_.length)
                  {
                     if((_loc4_ = _loc9_.getValueByIndex(_loc10_)) is BackgroundThumb)
                     {
                        if((_loc5_ = _loc2_.getEntry("bg/" + _loc4_.id)) == null)
                        {
                           _logger.error("An entry \'" + _loc4_.id + "\' is not found, probably due to un-Matching between theme.xml and the [theme].zip");
                        }
                        else
                        {
                           _loc8_ = _loc2_.getInput(_loc5_);
                           if(_loc7_)
                           {
                              (_loc6_ = new UtilCrypto()).decrypt(_loc8_);
                           }
                           _loc4_.thumbImageData = _loc8_;
                           _loc4_.imageData = _loc8_;
                        }
                     }
                     else if(_loc4_ is PropThumb)
                     {
                        if((_loc5_ = _loc2_.getEntry("prop/" + _loc4_.id)) == null)
                        {
                           _logger.error("An entry \'" + _loc4_.id + "\' is not found, probably due to un-Matching between theme.xml and the [theme].zip");
                        }
                        else
                        {
                           _loc8_ = _loc2_.getInput(_loc5_);
                           if(_loc7_)
                           {
                              (_loc6_ = new UtilCrypto()).decrypt(_loc8_);
                           }
                           _loc4_.thumbImageData = _loc8_;
                           _loc4_.imageData = _loc8_;
                        }
                     }
                     _loc10_++;
                  }
               }
               else if((_loc5_ = _loc2_.getEntry(_loc4_.getFileName())) == null)
               {
                  _logger.error("An entry \'" + _loc4_.getFileName() + "\' is not found, probably due to un-Matching between theme.xml and the [theme].zip");
               }
               else
               {
                  _loc8_ = _loc2_.getInput(_loc5_);
                  if(_loc7_)
                  {
                     (_loc6_ = new UtilCrypto()).decrypt(_loc8_);
                  }
                  _loc4_.thumbImageData = _loc8_;
                  _loc4_.imageData = _loc8_;
               }
            }
         }
         if((_loc4_ = this._defaultPropThumb as Thumb) != null)
         {
            if(_loc5_ == null)
            {
               _logger.error("An entry \'" + _loc4_.getFileName() + "\' is not found, probably due to un-Matching between theme.xml and the [theme].zip");
            }
            else
            {
               _loc4_.imageData = _loc2_.getInput(_loc5_);
               if(_loc7_)
               {
                  (_loc6_ = new UtilCrypto()).decrypt(_loc4_.imageData as ByteArray);
               }
            }
         }
         _loc3_ = 0;
         while(_loc3_ < this._effectThumbs.length)
         {
            if((_loc4_ = this._effectThumbs.getValueByIndex(_loc3_) as Thumb).getFileName() != null)
            {
               if((_loc5_ = _loc2_.getEntry(_loc4_.getFileName())) == null)
               {
                  _logger.error("An entry \'" + _loc4_.getFileName() + "\' is not found, probably due to un-Matching between theme.xml and the [theme].zip");
               }
               else
               {
                  _loc4_.imageData = _loc2_.getInput(_loc5_);
                  if(_loc7_)
                  {
                     (_loc6_ = new UtilCrypto()).decrypt(_loc4_.imageData as ByteArray);
                  }
               }
            }
            _loc3_++;
         }
         this._eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this));
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(param1);
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      private function isThemeZipLoaded() : Boolean
      {
         var _loc1_:Thumb = null;
         var _loc2_:int = 0;
         if(this._isThemeZipLoaded)
         {
            return true;
         }
         return false;
      }
      
      public function clearAllThumbs() : void
      {
         this._charThumbs.removeAll();
         this._backgroundThumbs.removeAll();
         this._propThumbs.removeAll();
         this._effectThumbs.removeAll();
         this._soundThumbs.removeAll();
         this._bubbleThumbs.removeAll();
      }
      
      private function doLoadThumbIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbIOError);
         Console.getConsole().requestLoadStatus(false,true);
         Console.getConsole().loadProgressVisible = false;
         Alert.show("Sorry, connection error occurs, please try again later.\n\n" + param1.toString());
      }
      
      private function doLoadThumbComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadThumbComplete);
         var _loc2_:URLStream = URLStream(param1.target);
         this._isThemeZipLoaded = true;
         this.doLoadThumbBytesComplete(_loc2_);
      }
      
      private function doLoadXMLComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.doLoadXMLComplete);
         var _loc2_:URLLoader = param1.target as URLLoader;
         this.doLoadXMLBytesComplete(_loc2_.data as ByteArray);
      }
      
      public function set cc_theme_id(param1:String) : void
      {
         this._cc_theme_id = param1;
      }
      
      public function get propThumbs() : UtilHashArray
      {
         return this._propThumbs;
      }
      
      public function set console(param1:Console) : void
      {
         this._console = param1;
      }
      
      public function initThemeByLoadThemeFile(param1:Console, param2:String) : void
      {
         if(param2 != "common")
         {
            Console.getConsole().thumbTray.clearTheme();
         }
         if(this.isThemeZipLoaded() || Console.getConsole().studioType == Console.MESSAGE_STUDIO)
         {
            this._eventDispatcher.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_COMPLETE,this));
         }
         else
         {
            this.console = param1;
            this.id = param2;
            this.loadXML();
         }
      }
      
      private function onLoadCharComplete(param1:Event) : void
      {
         var charThumb:CharThumb = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.onLoadCharComplete);
         this._isLoadingChar = false;
         this._isCharZipLoaded = true;
         Console.getConsole().requestLoadStatus(false,true);
         var stream:URLStream = URLStream(event.target);
         var zip:ZipFile = new ZipFile(stream);
         var i:int = 0;
         while(i < this._charThumbs.length)
         {
            charThumb = this._charThumbs.getValueByIndex(i) as CharThumb;
            try
            {
               charThumb.imageData = zip.getInput(zip.getEntry(charThumb.id));
            }
            catch(e:Error)
            {
               trace("############ Warning !!!!!!!!!!!!!! ##########");
               trace("Error occur when unzipping \'" + charThumb.id + "\' in char.zip. This is probably due to the mis-matching between the files in char.zip, and that stated in theme.xml");
            }
            i++;
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_CHAR_COMPLETE,this));
      }
      
      public function addThumb(param1:Thumb, param2:XML = null) : void
      {
         var _loc3_:CharThumb = null;
         var _loc4_:PropThumb = null;
         if(this._themeXML == null)
         {
            this._themeXML = UtilXmlInfo.createThemeXml(this.id,this.name);
         }
         if(param2 != null)
         {
            this._themeXML.appendChild(param2);
         }
         if(param1 is CharThumb)
         {
            _loc3_ = this._charThumbs.getValueByKey(param1.id);
            if(_loc3_ != null)
            {
               if(_loc3_.isThumbReady() == false)
               {
                  (param1 as CharThumb).mergeThumb(_loc3_);
                  this._charThumbs.push(param1.id,param1);
               }
            }
            else
            {
               this._charThumbs.push(param1.id,param1);
            }
         }
         else if(param1 is BackgroundThumb)
         {
            this._backgroundThumbs.push(param1.id,param1);
         }
         else if(param1 is BubbleThumb)
         {
            this._bubbleThumbs.push(param1.id,param1);
         }
         else if(param1 is VideoPropThumb)
         {
            this._propThumbs.push(param1.id,param1);
         }
         else if(param1 is PropThumb)
         {
            if((_loc4_ = this.propThumbs.getValueByKey(param1.id)) != null)
            {
               if(_loc4_.isThumbReady() == false)
               {
                  (param1 as PropThumb).mergeThumb(_loc4_);
                  this.propThumbs.push(param1.id,param1);
               }
            }
            else
            {
               this._propThumbs.push(param1.id,param1);
            }
         }
         else if(param1 is SoundThumb)
         {
            this._soundThumbs.push(param1.id,param1);
         }
         else if(param1 is EffectThumb)
         {
            this._effectThumbs.push(param1.id,param1);
         }
      }
      
      private function onLoadBgIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadBgIOError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingBg = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading backgrounds",param1.type);
      }
      
      private function onLoadPropTimeOut(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadPropTimeOut);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingProp = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Operation timeout");
      }
      
      public function getThumbNodeFromThemeXML(param1:XML, param2:Thumb) : XML
      {
         var themeXML:XML = param1;
         var thumb:Thumb = param2;
         var nodeName:String = "";
         if(thumb is CharThumb)
         {
            nodeName = CharThumb.XML_NODE_NAME;
         }
         else if(thumb is BackgroundThumb)
         {
            nodeName = BackgroundThumb.XML_NODE_NAME;
         }
         else if(thumb is PropThumb)
         {
            nodeName = PropThumb.XML_NODE_NAME;
         }
         else if(thumb is SoundThumb)
         {
            nodeName = SoundThumb.XML_NODE_NAME;
         }
         else if(thumb is BubbleThumb)
         {
            nodeName = BubbleThumb.XML_NODE_NAME;
         }
         else if(thumb is EffectThumb)
         {
            nodeName = EffectThumb.XML_NODE_NAME;
         }
         return themeXML.child(nodeName).(@id == thumb.id)[0];
      }
      
      public function isStateExists(param1:XML, param2:State) : Boolean
      {
         var filename:String = null;
         var id:String = null;
         var theme:Theme = null;
         var themeId:String = null;
         var thumbId:String = null;
         var stateId:String = null;
         var nodeXML:XML = null;
         var nodeName:String = null;
         var propFile:String = null;
         var xml:XML = param1;
         var state:State = param2;
         var result:Boolean = false;
         var sortedIndex:Array = UtilXmlInfo.getAndSortXMLattribute(xml,"index");
         var i:int = 0;
         for(; i < sortedIndex.length; i++)
         {
            nodeXML = xml.children().(@index == String(sortedIndex[i]))[0];
            nodeName = nodeXML.name();
            switch(nodeName)
            {
               case Prop.XML_NODE_NAME:
                  propFile = nodeXML.child("file")[0].toString();
                  thumbId = UtilXmlInfo.getPropIdFromFileName(propFile);
                  stateId = UtilXmlInfo.getPropStateIdFromFileName(propFile);
                  if(state.thumb.id == thumbId && state.id == stateId)
                  {
                     result = true;
                  }
                  continue;
               default:
                  continue;
            }
         }
         return result;
      }
      
      public function isCharZipLoaded() : Boolean
      {
         return this._isCharZipLoaded;
      }
      
      private function onLoadCharIOError(param1:IOErrorEvent) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.onLoadCharIOError);
         Console.getConsole().loadProgressVisible = false;
         this._isLoadingChar = false;
         Console.getConsole().requestLoadStatus(false,true);
         Alert.show("Error in loading chars",param1.type);
      }
      
      private function onLoadPropComplete(param1:Event) : void
      {
         var propThumb:PropThumb = null;
         var fileBytes:ByteArray = null;
         var zipEntry:ZipEntry = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.onLoadPropComplete);
         this._isLoadingProp = false;
         this._isPropZipLoaded = true;
         Console.getConsole().requestLoadStatus(false,true);
         var stream:URLStream = URLStream(event.target);
         var bytes:ByteArray = new ByteArray();
         stream.readBytes(bytes,0,stream.bytesAvailable);
         var zip:ZipFile = new ZipFile(bytes);
         var decryptEngine:UtilCrypto = new UtilCrypto();
         var i:int = 0;
         while(i < this._propThumbs.length)
         {
            propThumb = this._propThumbs.getValueByIndex(i) as PropThumb;
            try
            {
               if(propThumb.states.length > 0)
               {
                  zipEntry = zip.getEntry(propThumb.getFileName());
                  fileBytes = zip.getInput(zipEntry);
               }
               else
               {
                  fileBytes = zip.getInput(zip.getEntry(propThumb.id));
               }
               if(this.id != "ugc")
               {
                  decryptEngine.decrypt(fileBytes);
               }
               propThumb.imageData = fileBytes;
            }
            catch(e:Error)
            {
               trace("############ Warning !!!!!!!!!!!!!! ##########");
               trace("Error occur when unzipping \'" + propThumb.id + "\' in prop.zip. This is probably due to the mis-matching between the files in prop.zip, and that stated in theme.xml");
            }
            i++;
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_PROP_COMPLETE,this));
      }
      
      public function loadBg() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(!this._isLoadingBg)
         {
            if(this.isBgZipLoaded())
            {
               this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this));
            }
            this._isLoadingBg = true;
            Console.getConsole().requestLoadStatus(true,true);
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.id,null,ServerConstants.PARAM_BG);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
            _loc2_.addEventListener(Event.COMPLETE,this.onLoadBgComplete);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadBgTimeOut);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadBgSecurityError);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadBgIOError);
            _loc2_.load(_loc1_);
         }
      }
      
      public function changePurchase(param1:String, param2:String, param3:Boolean) : void
      {
         var aiid:String = param1;
         var name:String = param2;
         var p:Boolean = param3;
         if(this._purchasedContent == null)
         {
            this._purchasedContent = new XMLList();
         }
         if(p)
         {
            this._purchasedContent = this._purchasedContent + new XML("<premium theme=\"" + this._name + "\" aid=\"" + aiid + "\" expired=\"N\"/>");
         }
         else
         {
            try
            {
               this._purchasedContent.(@aid == aiid)[0].@expired = "Y";
            }
            catch(err:Error)
            {
            }
         }
      }
      
      public function get defaultCharThumb() : CharThumb
      {
         return this._defaultCharThumb;
      }
      
      public function get eventDispatcher() : EventDispatcher
      {
         return this._eventDispatcher;
      }
      
      private function onLoadBgComplete(param1:Event) : void
      {
         var bgThumb:BackgroundThumb = null;
         var fileBytes:ByteArray = null;
         var event:Event = param1;
         (event.target as IEventDispatcher).removeEventListener(event.type,this.onLoadBgComplete);
         this._isLoadingBg = false;
         this._isBgZipLoaded = true;
         Console.getConsole().requestLoadStatus(false,true);
         var stream:URLStream = URLStream(event.target);
         var bytes:ByteArray = new ByteArray();
         stream.readBytes(bytes,0,stream.bytesAvailable);
         var zip:ZipFile = new ZipFile(bytes);
         var decryptEngine:UtilCrypto = new UtilCrypto();
         var i:int = 0;
         while(i < this._backgroundThumbs.length)
         {
            bgThumb = this._backgroundThumbs.getValueByIndex(i) as BackgroundThumb;
            try
            {
               fileBytes = zip.getInput(zip.getEntry(bgThumb.thumbId));
               if(this.id != "ugc" && !bgThumb.isComposite)
               {
                  decryptEngine.decrypt(fileBytes);
               }
               bgThumb.thumbImageData = fileBytes;
               bgThumb.imageData = fileBytes;
            }
            catch(e:Error)
            {
               trace("############ Warning !!!!!!!!!!!!!! ##########");
               trace("Error occur when unzipping \'" + bgThumb.id + "\' in bg.zip. This is probably due to the mis-matching between the files in bg.zip, and that stated in theme.xml");
            }
            i++;
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THEME_BACKGROUND_COMPLETE,this));
      }
      
      public function doOutputThumbs(param1:XML) : UtilHashArray
      {
         var filename:String = null;
         var id:String = null;
         var theme:Theme = null;
         var themeId:String = null;
         var thumbId:String = null;
         var nodeXML:XML = null;
         var nodeName:String = null;
         var bgThumb:BackgroundThumb = null;
         var propFile:String = null;
         var propThumb:PropThumb = null;
         var charFile:String = null;
         var charThumb:CharThumb = null;
         var xml:XML = param1;
         var tempArray:UtilHashArray = new UtilHashArray();
         var sortedIndex:Array = UtilXmlInfo.getAndSortXMLattribute(xml,"index");
         var i:int = 0;
         for(; i < sortedIndex.length; i++)
         {
            nodeXML = xml.children().(@index == String(sortedIndex[i]))[0];
            nodeName = nodeXML.name();
            switch(nodeName)
            {
               case Background.XML_NODE_NAME:
                  filename = UtilXmlInfo.getZipFileNameOfBg(nodeXML.file);
                  thumbId = UtilXmlInfo.getThumbIdFromFileName(filename);
                  bgThumb = this.getBackgroundThumbById(thumbId);
                  tempArray.push(bgThumb.id,bgThumb);
                  continue;
               case Prop.XML_NODE_NAME:
                  propFile = nodeXML.child("file")[0].toString();
                  thumbId = UtilXmlInfo.getPropIdFromFileName(propFile);
                  propThumb = this.getPropThumbById(thumbId);
                  trace("[propFile,thumbId,propThumb.id]:" + [propFile,thumbId,propThumb.id]);
                  tempArray.push(propThumb.id,propThumb);
                  continue;
               case Character.XML_NODE_NAME:
                  charFile = UtilXmlInfo.getZipFileNameOfBehaviour(nodeXML.child("file")[0].toString(),true);
                  thumbId = UtilXmlInfo.getCharIdFromFileName(charFile);
                  charThumb = this.getCharThumbById(thumbId);
                  tempArray.push(charThumb.id,charThumb);
                  continue;
               default:
                  continue;
            }
         }
         return tempArray;
      }
      
      private function loadThumbs(param1:int) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:UtilURLStream = null;
         if(this.id == ThemeEmbedConstant.defaultThemeId && ThemeEmbedConstant._defaultThemeZip != null)
         {
            Console.getConsole().mainStage.callLater(this.doLoadThumbBytesComplete,new Array(ThemeEmbedConstant.defaultThemeZip));
         }
         else if(this.id == "common" && ThemeEmbedConstant.commonThemeZip != null)
         {
            Console.getConsole().mainStage.callLater(this.doLoadThumbBytesComplete,new Array(ThemeEmbedConstant.commonThemeZip));
         }
         else
         {
            _loc2_ = UtilNetwork.getGetThemeRequest(this.id,!Console.getConsole().isThemeCcRelated(this.id));
            _loc3_ = new UtilURLStream();
            if(param1 == AnimeConstants.THEME_SEGMENT_ONE)
            {
               _loc3_.addEventListener(ProgressEvent.PROGRESS,Console.getConsole().showProgress);
               _loc3_.addEventListener(Event.COMPLETE,this.doLoadThumbComplete);
               _loc3_.addEventListener(UtilURLStream.TIME_OUT,this.doLoadThumbTimeOut);
               _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.doLoadThumbIOError);
               _loc3_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.doLoadThumbSecurityError);
            }
            _loc3_.load(_loc2_);
         }
      }
      
      public function getPropThumbById(param1:String) : PropThumb
      {
         return this._propThumbs.getValueByKey(param1) as PropThumb;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(param1);
      }
      
      public function mergeThemeXML(param1:XML) : void
      {
         var _loc2_:int = 0;
         var _loc3_:XML = null;
         if(this._themeXML == null)
         {
            this._themeXML = param1;
            return;
         }
         this._themeXML = merge2ThemeXml(this._themeXML,param1,this.id,this.name,true);
      }
      
      public function get defaultPropThumb() : PropThumb
      {
         return this._defaultPropThumb;
      }
   }
}
