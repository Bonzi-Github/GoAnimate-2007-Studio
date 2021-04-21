package anifire.core
{
   import anifire.constant.AnimeConstants;
   import anifire.constant.ServerConstants;
   import anifire.effect.EffectMgr;
   import anifire.effect.SuperEffect;
   import anifire.event.EffectEvt;
   import anifire.managers.FeatureManager;
   import anifire.util.UtilCrypto;
   import anifire.util.UtilDict;
   import anifire.util.UtilNetwork;
   import anifire.util.UtilURLStream;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import mx.managers.DragManager;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class EffectThumb extends Thumb
   {
      
      public static const TYPE_EARTHQUAKE:String = "earthquake";
      
      public static const TYPE_HOVERING:String = "hovering";
      
      public static const TYPE_ANIME:String = "anime";
      
      public static const TYPE_SEPIA:String = "sepia";
      
      public static const TYPE_BUMPYRIDE:String = "bumpyride";
      
      public static const TYPE_PROGRAM:String = "program";
      
      public static const XML_NODE_NAME:String = "effect";
      
      public static const TYPE_FADING:String = "fading";
      
      public static const TYPE_FIRESPRING:String = "firespring";
      
      public static const TYPE_DRALERT:String = "dra";
      
      private static var _logger:ILogger = Log.getLogger("core.EffectThumb");
      
      public static const TYPE_GRAYSCALE:String = "grayscale";
      
      public static const TYPE_FIREWORK:String = "firework";
      
      public static const TYPE_ZOOM:String = "zoom";
      
      public static const TYPE_UPSIDEDOWN:String = "upsidedown";
       
      
      private var _effectXML:XML;
      
      private var CSSClassDec:CSSStyleDeclaration;
      
      private var iconEffect:Class;
      
      public function EffectThumb()
      {
         this.CSSClassDec = StyleManager.getStyleDeclaration(".thumbTrayIcon");
         this.iconEffect = this.CSSClassDec.getStyle("iconEffect") as Class;
         super();
         _logger.debug("EffectThumb initialize");
         this.imageObject = new Image();
         Image(this.imageObject).source = this.iconEffect;
      }
      
      public function getExactType() : String
      {
         switch(EffectMgr.getType(this._effectXML))
         {
            case EffectMgr.TYPE_ANIME:
               return TYPE_ANIME;
            case EffectMgr.TYPE_ZOOM:
               return TYPE_ZOOM;
            case EffectMgr.TYPE_EARTHQUAKE:
               return TYPE_EARTHQUAKE;
            case EffectMgr.TYPE_UPSIDEDOWN:
               return TYPE_UPSIDEDOWN;
            case EffectMgr.TYPE_FIREWORK:
               return TYPE_FIREWORK;
            case EffectMgr.TYPE_FIRESPRING:
               return TYPE_FIRESPRING;
            case EffectMgr.TYPE_HOVERING:
               return TYPE_HOVERING;
            case EffectMgr.TYPE_BUMPYRIDE:
               return TYPE_BUMPYRIDE;
            case EffectMgr.TYPE_DRALERT:
               return TYPE_DRALERT;
            case EffectMgr.TYPE_GRAYSCALE:
               return TYPE_GRAYSCALE;
            case EffectMgr.TYPE_SEPIA:
               return TYPE_SEPIA;
            case EffectMgr.TYPE_FADING:
               return TYPE_FADING;
            default:
               return null;
         }
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = null;
         var _loc3_:DragSource = null;
         var _loc4_:SuperEffect = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Image = null;
         if(purchased)
         {
            _loc2_ = Image(param1.currentTarget);
            _loc3_ = new DragSource();
            _loc3_.addData(this,"thumb");
            (_loc4_ = this.getNewEffect()).addEventListener(EffectEvt.LOAD_EFFECT_THUMBNAIL_COMPLETE,this.loadProxyImageComplete);
            _loc5_ = _loc4_.loadThumbnail(this.imageData as ByteArray);
            (_loc6_ = new Image()).addChild(_loc5_);
            DragManager.doDrag(_loc2_,_loc3_,param1,_loc6_);
            Console.getConsole().currDragSource = _loc3_;
         }
      }
      
      public function getResize() : String
      {
         return EffectMgr.getResize(this._effectXML);
      }
      
      override function loadProxyImageComplete(param1:Event) : void
      {
         var _loc2_:DisplayObject = (param1 as EffectEvt).thumbnail;
         var _loc3_:Rectangle = _loc2_.getBounds(_loc2_);
         var _loc4_:Number = 1;
         var _loc5_:Number = AnimeConstants.TILE_BUBBLE_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc6_:Number = AnimeConstants.TILE_BUBBLE_HEIGHT - AnimeConstants.TILE_INSETS * 2;
         if(!(_loc3_.width <= _loc5_ && _loc3_.height <= _loc6_))
         {
            if(_loc3_.width > _loc5_ && _loc3_.height <= _loc6_)
            {
               _loc4_ = _loc5_ / _loc3_.width;
            }
            else if(_loc3_.width <= _loc5_ && _loc3_.height > _loc6_)
            {
               _loc4_ = _loc6_ / _loc3_.height;
            }
            else
            {
               _loc4_ = _loc5_ / _loc3_.width;
               if(_loc3_.height * _loc4_ > _loc6_)
               {
                  _loc4_ = _loc6_ / _loc3_.height;
               }
            }
         }
         _loc2_.scaleX = _loc4_;
         _loc2_.scaleY = _loc4_;
         _loc2_.x = -1 * (_loc3_.left + _loc3_.right) / 2 * _loc4_ + AnimeConstants.TILE_BUBBLE_WIDTH / 2;
         _loc2_.y = -1 * (_loc3_.top + _loc3_.bottom) / 2 * _loc4_ + AnimeConstants.TILE_BUBBLE_HEIGHT / 2;
      }
      
      public function getType() : String
      {
         if(EffectMgr.getType(this._effectXML) == EffectMgr.TYPE_ANIME)
         {
            return TYPE_ANIME;
         }
         return TYPE_PROGRAM;
      }
      
      override public function loadImageData() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:UtilURLStream = null;
         if(this.getType() == TYPE_ANIME)
         {
            _loc1_ = UtilNetwork.getGetThemeAssetRequest(this.theme.id,this.id,ServerConstants.PARAM_EFFECT);
            _loc2_ = new UtilURLStream();
            _loc2_.addEventListener(Event.COMPLETE,this.loadImageDataComplete);
            _loc2_.addEventListener(UtilURLStream.TIME_OUT,this.onLoadImageDataFail);
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadImageDataFail);
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onLoadImageDataFail);
            _loc2_.load(_loc1_);
         }
      }
      
      override public function loadImageDataComplete(param1:Event) : void
      {
         var _loc4_:UtilCrypto = null;
         var _loc2_:URLStream = URLStream(param1.target);
         var _loc3_:ByteArray = new ByteArray();
         _loc2_.readBytes(_loc3_,0,_loc2_.bytesAvailable);
         this.imageData = _loc3_;
         if(this.theme.id != "ugc")
         {
            (_loc4_ = new UtilCrypto()).decrypt(ByteArray(this.imageData));
         }
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_THUMB_COMPLETE,this));
      }
      
      public function getNewEffect(param1:XML = null) : SuperEffect
      {
         var _loc2_:SuperEffect = null;
         if(param1 == null)
         {
            _loc2_ = EffectMgr.getEffectByXML(this._effectXML);
         }
         else
         {
            _loc2_ = EffectMgr.getEffectByXML(param1);
         }
         return _loc2_;
      }
      
      private function onLoadImageDataFail(param1:Event) : void
      {
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         this._effectXML = param1;
         this.id = param1.@id;
         this.aid = param1.@aid;
         this.name = UtilDict.toDisplay("store",param1.@name);
         this.premium = param1.@is_premium == "Y"?true:false;
         this.cost = [param1.@money,param1.@sharing];
         this.setFileName(EffectMgr.getFileNameInThemeZip(param1));
         this.theme = param2;
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
            if(this.id.split(".").length <= 1)
            {
               this.setFileName(this.id + ".swf");
            }
            this.tags = param1.tags;
            this.isPublished = param1.@published == "1"?true:false;
         }
      }
   }
}
