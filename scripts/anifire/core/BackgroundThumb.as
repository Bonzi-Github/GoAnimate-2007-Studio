package anifire.core
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.managers.FeatureManager;
   import anifire.util.Util;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   
   public class BackgroundThumb extends Thumb
   {
      
      public static const XML_NODE_NAME:String = "background";
      
      public static const XML_NODE_NAME_CBG:String = "compositebg";
      
      private static var _logger:ILogger = Log.getLogger("core.BackgroundThumb");
       
      
      private var _background:Asset;
      
      private var _isDefault:Boolean;
      
      private var _isComposite:Boolean;
      
      public function BackgroundThumb()
      {
         super();
         _logger.debug("BackgroundThumb initialized");
      }
      
      public function set background(param1:Asset) : void
      {
         this._background = param1;
      }
      
      override public function loadImageData() : void
      {
         var _loc1_:URLRequest = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.thumbId,ServerConstants.PARAM_BG);
         var _loc2_:UtilURLStream = new UtilURLStream();
         _loc2_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.ioErrorHandler);
         _loc2_.load(_loc1_);
      }
      
      public function isThumbReady() : Boolean
      {
         if(this.imageData != null)
         {
            return true;
         }
         return false;
      }
      
      override public function loadImageDataComplete(param1:Event) : void
      {
         var _loc5_:UtilCrypto = null;
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         var _loc4_:ByteArray = _loc3_;
         if(this.theme.id != "ugc" && !this.isComposite)
         {
            (_loc5_ = new UtilCrypto()).decrypt(_loc4_);
         }
         this.thumbImageData = this.imageData = _loc4_;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         trace("load image data failed!");
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = null;
         var _loc3_:DragSource = null;
         var _loc4_:Image = null;
         var _loc5_:Loader = null;
         if(purchased)
         {
            _loc2_ = Image(param1.currentTarget);
            _loc3_ = new DragSource();
            _loc3_.addData(this,"thumb");
            if(_loc2_.parent is ThumbnailCanvas)
            {
               if(ThumbnailCanvas(_loc2_.parent).colorSetId != "")
               {
                  _loc3_.addData(ThumbnailCanvas(_loc2_.parent).colorSetId,"colorSetId");
               }
            }
            _loc4_ = new Image();
            (_loc5_ = new Loader()).name = "proxyImageLoader";
            _loc5_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadProxyImageComplete);
            _loc5_.loadBytes(ByteArray(this.thumbImageData));
            _loc4_.addChild(_loc5_);
            DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
            Console.getConsole().currDragSource = _loc3_;
         }
      }
      
      public function get background() : Asset
      {
         return this._background;
      }
      
      public function set isDefault(param1:Boolean) : void
      {
         this._isDefault = param1;
      }
      
      public function get isDefault() : Boolean
      {
         return this._isDefault;
      }
      
      public function set isComposite(param1:Boolean) : void
      {
         this._isComposite = param1;
      }
      
      override function loadProxyImageComplete(param1:Event) : void
      {
         var _loc3_:BitmapData = null;
         var _loc2_:Loader = Loader(param1.target.loader);
         if(this.isComposite)
         {
            _loc3_ = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2,AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2));
         }
         else
         {
            _loc3_ = Util.capturePicture(_loc2_,new Rectangle(0,0,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT));
         }
         var _loc4_:Bitmap;
         (_loc4_ = new Bitmap(_loc3_)).width = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
         _loc4_.height = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         var _loc5_:Image = Image(_loc2_.parent);
         _loc5_.removeChild(_loc5_.getChildByName("proxyImageLoader"));
         _loc5_.addChild(_loc4_);
         _loc4_.x = AnimeConstants.TILE_INSETS;
         _loc4_.y = AnimeConstants.TILE_INSETS;
      }
      
      public function get isComposite() : Boolean
      {
         return this._isComposite;
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         var _loc4_:String = null;
         var _loc5_:XML = null;
         var _loc6_:int = 0;
         var _loc7_:XML = null;
         if(param3)
         {
            this.isComposite = param3;
            this.xml = param1;
         }
         else
         {
            _loc4_ = param1.@thumb != undefined?param1.@thumb:param1.@id;
            this.setFileName("bg/" + _loc4_);
         }
         this.thumbId = param1.@thumb != undefined?param1.@thumb:param1.@id;
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.name = UtilDict.toDisplay("store",param1.@name);
         this.theme = param2;
         this.premium = param1.@is_premium == "Y"?true:false;
         this.cost = [param1.@money,param1.@sharing];
         this.enable = param1.@enable == "N"?false:true;
         if(Console.getConsole().excludedIds.containsKey(this.aid))
         {
            this.enable = false;
         }
         if(!FeatureManager.isPremiumStuffVisible && this.premium && Number(param1.@sharing) > 0)
         {
            this.enable = false;
         }
         if(this.theme.id == "ugc")
         {
            this.tags = param1.tags;
            this.isPublished = param1.@published == "1"?true:false;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.colorset.length())
         {
            _loc5_ = param1.colorset[_loc6_];
            colorRef.push(_loc5_.@aid,_loc5_);
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < param1.c_parts.c_area.length())
         {
            _loc7_ = param1.c_parts.c_area[_loc6_];
            if(param1.c_parts.@enable != "N")
            {
               colorParts.push(_loc7_,_loc7_.attribute("oc").length() == 0?uint.MAX_VALUE:_loc7_.@oc);
            }
            _loc6_++;
         }
      }
   }
}
