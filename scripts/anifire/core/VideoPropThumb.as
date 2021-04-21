package anifire.core
{
   import anifire.components.containers.ThumbnailCanvas;
   import anifire.constant.AnimeConstants;
   import anifire.constant.ThemeEmbedConstant;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import mx.controls.Image;
   import mx.core.DragSource;
   import mx.managers.DragManager;
   
   public class VideoPropThumb extends PropThumb
   {
       
      
      private var _videoHeight:Number;
      
      private var _videoWidth:Number;
      
      public function VideoPropThumb()
      {
         super();
      }
      
      public static function renameExtensionToPNG(param1:String) : String
      {
         return param1.substring(0,param1.length - 4).concat(".png");
      }
      
      public function get videoHeight() : Number
      {
         return this._videoHeight;
      }
      
      public function set videoHeight(param1:Number) : void
      {
         this._videoHeight = param1;
      }
      
      public function get videoWidth() : Number
      {
         return this._videoWidth;
      }
      
      override function loadProxyImageComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadProxyImageComplete);
         var _loc2_:Loader = Loader(param1.target.loader);
         var _loc3_:Number = _loc2_.content.width;
         var _loc4_:Number = _loc2_.content.height;
         var _loc5_:Number = 1;
         var _loc6_:Number = AnimeConstants.TILE_BACKGROUND_WIDTH - AnimeConstants.TILE_INSETS * 2;
         var _loc7_:Number = AnimeConstants.TILE_BACKGROUND_HEIGHT - AnimeConstants.TILE_INSETS * 2;
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
         _loc2_.x = (AnimeConstants.TILE_BACKGROUND_WIDTH - _loc2_.content.width) / 2;
         _loc2_.y = (AnimeConstants.TILE_BACKGROUND_HEIGHT - _loc2_.content.height) / 2;
         _loc2_.x = _loc2_.x - _loc8_.left;
         _loc2_.y = _loc2_.y - _loc8_.top;
      }
      
      public function loadThumbnail() : DisplayObject
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:Class = null;
         if(this.videoWidth == 0 || this.videoHeight == 0)
         {
            _loc2_ = ThemeEmbedConstant.DEFAULT_LOADING_THUMBNAIL;
         }
         else
         {
            _loc2_ = ThemeEmbedConstant.DEFAULT_VIDEO_THUMBNAIL;
         }
         _loc1_ = new _loc2_();
         _loc1_.x = AnimeConstants.TILE_BACKGROUND_WIDTH / 2;
         _loc1_.y = AnimeConstants.TILE_BACKGROUND_HEIGHT / 2 - 2;
         return _loc1_;
      }
      
      override public function deSerialize(param1:XML, param2:Theme, param3:Boolean = false) : void
      {
         super.deSerialize(param1,param2,param3);
         this.setFileName(renameExtensionToPNG(this.getFileName()));
         this.videoWidth = Number(param1.@width);
         this.videoHeight = Number(param1.@height);
      }
      
      public function set videoWidth(param1:Number) : void
      {
         this._videoWidth = param1;
      }
      
      override public function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Image = null;
         var _loc3_:DragSource = null;
         var _loc4_:Image = null;
         var _loc5_:Loader = null;
         if(Console.getConsole().currentScene.enableClickTimer.running)
         {
            return;
         }
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
            if(this.imageData != null)
            {
               (_loc5_ = new Loader()).contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadProxyImageComplete);
               _loc5_.loadBytes(ByteArray(this.imageData));
               _loc4_.addChild(_loc5_);
            }
            DragManager.doDrag(_loc2_,_loc3_,param1,_loc4_);
            Console.getConsole().currentScene.hideEffects();
            Console.getConsole().currDragSource = _loc3_;
         }
      }
   }
}
