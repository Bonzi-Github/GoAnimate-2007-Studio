package anifire.core
{
   import anifire.color.SelectedColor;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlMgr;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilErrorLogger;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilPlain;
   import anifire.util.UtilXmlInfo;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import nochump.util.zip.ZipEntry;
   import nochump.util.zip.ZipFile;
   
   public class Background extends Asset
   {
      
      public static var XML_NODE_NAME:String = "bg";
      
      private static var _logger:ILogger = Log.getLogger("core.Background");
       
      
      public function Background(param1:String = "")
      {
         super();
         _logger.info("Background initialized");
         if(param1 == "")
         {
            param1 = "BG" + this.assetCount;
         }
         this.id = this.bundle.id = param1;
      }
      
      public static function getThemeTrees(param1:XML, param2:ZipFile) : UtilHashArray
      {
         var _loc7_:ByteArray = null;
         var _loc8_:ThemeTree = null;
         var _loc9_:UtilCrypto = null;
         var _loc3_:UtilHashArray = new UtilHashArray();
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBg(param1["file"].toString());
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc6_:ZipEntry;
         if((_loc6_ = param2.getEntry(_loc4_)) != null)
         {
            _loc7_ = param2.getInput(_loc6_);
            if(_loc5_ != "ugc")
            {
               (_loc9_ = new UtilCrypto()).decrypt(_loc7_);
            }
            (_loc8_ = new ThemeTree(_loc5_)).addBgThumb(UtilXmlInfo.getThumbIdFromFileName(_loc4_),_loc7_);
            _loc3_.push(_loc5_,_loc8_);
         }
         return _loc3_;
      }
      
      override public function showControl() : void
      {
         super.showControl();
         if(!Console.getConsole().isTutorialOn)
         {
            showButtonBar();
         }
      }
      
      override function onMouseUp(param1:MouseEvent) : void
      {
         super.onMouseUp(param1);
      }
      
      public function playBackground() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = Loader(this.imageObject);
            if(_loc1_ != null)
            {
               if(_loc1_.content is MovieClip)
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
      }
      
      public function toString() : String
      {
         return this.thumb.theme.id + "." + this.thumb.id;
      }
      
      override public function serialize() : String
      {
         var canvas:Canvas = null;
         var i:int = 0;
         var logger:UtilErrorLogger = null;
         var xmlStr:String = "";
         try
         {
            canvas = getSceneCanvas();
            xmlStr = xmlStr + ("<bg id=\"" + this.id + "\" index=\"" + canvas.getChildIndex(this.bundle) + "\">" + "<file>" + this.thumb.theme.id + "." + this.thumb.id + "</file>");
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
            xmlStr = xmlStr + "</bg>";
         }
         catch(e:Error)
         {
            logger = UtilErrorLogger.getInstance();
            logger.appendCustomError("Background::serialize()",e);
            trace("Error:" + e);
         }
         return xmlStr;
      }
      
      override function onMouseDown(param1:MouseEvent) : void
      {
         super.onMouseDown(param1);
         var _loc2_:UIComponent = UIComponent(param1.currentTarget);
         _loc2_.setFocus();
      }
      
      private function loadAssetImageComplete(param1:Event) : void
      {
         var _loc5_:Canvas = null;
         var _loc6_:Class = null;
         var _loc2_:Loader = param1.target.loader;
         var _loc3_:Rectangle = new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         _loc2_.scrollRect = _loc3_;
         var _loc4_:UIComponent;
         if((_loc4_ = UIComponent(_loc2_.parent)) != null)
         {
            _loc5_ = Canvas(_loc4_.parent.parent);
            if(!capScreenLock)
            {
               this.changed = true;
            }
            this.isLoadded = false;
         }
         if(_loc2_.content.loaderInfo.applicationDomain.hasDefinition("theSound"))
         {
            trace("with sound");
            _loc6_ = _loc2_.content.loaderInfo.applicationDomain.getDefinition("theSound") as Class;
            this.sound = new _loc6_();
            this.dispatchEvent(new Event("SoundAdded"));
         }
         updateColor();
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      override public function set thumb(param1:Thumb) : void
      {
         super.thumb = param1;
         if(param1.imageData != null)
         {
            this.imageData = param1.imageData;
         }
      }
      
      public function stopBackground() : void
      {
         var _loc1_:Loader = null;
         var _loc2_:DisplayObject = null;
         if(this.displayElement != null)
         {
            _loc1_ = Loader(this.imageObject);
            if(_loc1_ != null)
            {
               if(_loc1_.content is MovieClip)
               {
                  _loc2_ = DisplayObject(_loc1_.content);
                  UtilPlain.stopFamily(_loc2_);
                  this.stopMusic(false);
               }
            }
         }
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:Loader = new Loader();
         _loc1_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadAssetImageComplete);
         _loc1_.loadBytes(ByteArray(this.imageData));
         var _loc2_:int = 0;
         while(_loc2_ < this.displayElement.numChildren)
         {
            if(this.displayElement.getChildAt(_loc2_) is Loader)
            {
               this.displayElement.removeChildAt(_loc2_);
               break;
            }
            _loc2_++;
         }
         _loc1_.name = AnimeConstants.IMAGE_OBJECT_NAME;
         this.displayElement.addChild(_loc1_);
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
      
      override function hideControl() : void
      {
         super.hideControl();
         hideButtonBar();
      }
      
      override public function addControl() : void
      {
         var _loc1_:Control = ControlMgr.getControl(this.displayElement,ControlMgr.NORMAL);
         var _loc2_:Number = Console.getConsole().stageScale;
         _loc1_.target = this;
         _loc1_.x = _loc1_.lineSize / _loc2_;
         _loc1_.y = _loc1_.lineSize / _loc2_;
         _loc1_.setSize(AnimeConstants.PLAYER_WIDTH - _loc1_.lineSize / _loc2_ * 2,AnimeConstants.PLAYER_HEIGHT - _loc1_.lineSize / _loc2_ * 2);
         _loc1_.disableResize();
         _loc1_.hideControl();
         this.control = _loc1_;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:Background = new Background();
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.id = this.id;
         _loc3_.scene = this.scene;
         _loc3_.thumb = this.thumb;
         _loc3_.customColor = this.customColor.clone();
         return _loc3_;
      }
      
      public function deSerialize(param1:XML, param2:AnimeScene, param3:Boolean = true) : void
      {
         var _loc8_:BackgroundThumb = null;
         var _loc9_:XML = null;
         var _loc10_:int = 0;
         var _loc11_:SelectedColor = null;
         var _loc4_:String = UtilXmlInfo.getZipFileNameOfBg(param1.file);
         var _loc5_:String = UtilXmlInfo.getThemeIdFromFileName(_loc4_);
         var _loc6_:String = UtilXmlInfo.getThumbIdFromFileName(_loc4_);
         var _loc7_:Theme;
         if((_loc7_ = Console.getConsole().getTheme(_loc5_)) != null)
         {
            if((_loc8_ = _loc7_.getBackgroundThumbById(_loc6_)) != null && _loc8_.imageData != null)
            {
               this.x = AnimeConstants.SCREEN_X;
               this.y = AnimeConstants.SCREEN_Y;
               this.width = AnimeConstants.SCREEN_WIDTH;
               this.height = AnimeConstants.SCREEN_HEIGHT;
               this.scene = param2;
               if(param3)
               {
                  this.thumb = _loc8_;
               }
               else
               {
                  super.thumb = _loc8_;
               }
               this.isLoadded = true;
               if(param1.dcsn.length() > 0)
               {
                  this.defaultColorSetId = String(param1.dcsn);
                  this.defaultColorSet = this.thumb.getColorSetById(this.defaultColorSetId);
               }
               customColor = new UtilHashArray();
               _loc10_ = 0;
               while(_loc10_ < param1.child("color").length())
               {
                  _loc9_ = param1.child("color")[_loc10_];
                  _loc11_ = new SelectedColor(_loc9_.@r,_loc9_.attribute("oc").length() == 0?uint(uint.MAX_VALUE):uint(_loc9_.@oc),uint(_loc9_));
                  this.addCustomColor(_loc9_.@r,_loc11_);
                  _loc10_++;
               }
               updateColor();
            }
         }
      }
   }
}
