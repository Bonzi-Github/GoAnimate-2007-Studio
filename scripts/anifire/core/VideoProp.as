package anifire.core
{
   import anifire.component.VideoPlayback;
   import anifire.constant.AnimeConstants;
   import anifire.control.Control;
   import anifire.control.ControlMgr;
   import anifire.util.UtilUnitConvert;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   
   public class VideoProp extends Prop
   {
       
      
      private var videoPlayBack:VideoPlayback;
      
      private var _image:Canvas;
      
      public function VideoProp(param1:String = "")
      {
         super();
      }
      
      private function loadDefaultImage() : void
      {
         var _loc2_:Canvas = null;
         var _loc3_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.displayElement.numChildren)
         {
            if(this.displayElement.getChildAt(_loc1_) is Canvas)
            {
               _loc3_ = Object(this.displayElement.getChildAt(_loc1_));
               this.displayElement.removeChildAt(_loc1_);
               _loc3_ = null;
               break;
            }
            _loc1_++;
         }
         this.image = new Canvas();
         this.image.width = VideoPropThumb(this.thumb).videoWidth;
         this.image.height = VideoPropThumb(this.thumb).videoHeight;
         this.image.graphics.clear();
         this.image.graphics.beginFill(15658734,1);
         this.image.graphics.drawRect(-this.image.width / 2,-this.image.height / 2,this.image.width,this.image.height);
         this.image.graphics.endFill();
         this.image.clipContent = false;
         _loc2_ = new Canvas();
         _loc2_.x = -this.image.width / 2;
         _loc2_.y = -this.image.height / 2;
         _loc2_.styleName = "iconVideo";
         _loc2_.width = 48;
         _loc2_.height = 40;
         _loc2_.graphics.beginFill(16711680,0);
         _loc2_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc2_.graphics.endFill();
         this.image.addChild(_loc2_);
         this.image.name = AnimeConstants.IMAGE_OBJECT_NAME;
         this.image.addEventListener(Event.ADDED,this.loadDefaultImageComplete);
         trace("loadassetimage");
         this.displayElement.addChild(this.image);
      }
      
      public function pauseMovie() : void
      {
         if(this.videoPlayBack != null)
         {
            this.videoPlayBack.pause();
         }
      }
      
      override public function loadAssetImageComplete(param1:Event) : void
      {
         var _loc2_:Loader = null;
         _loc2_ = param1.target.loader;
         _loc2_.content.width = VideoPropThumb(this.thumb).videoWidth;
         _loc2_.content.height = VideoPropThumb(this.thumb).videoHeight;
         super.loadAssetImageComplete(param1);
      }
      
      override public function addControl() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:Rectangle = null;
         var _loc3_:Control = null;
         if(this.thumb.imageData)
         {
            _loc1_ = Loader(this.imageObject);
         }
         else
         {
            _loc1_ = Canvas(this.imageObject);
         }
         if(_loc1_ != null)
         {
            this.stopMusic(false,true);
            _loc2_ = _loc1_.getBounds(this.bundle);
            _loc3_ = ControlMgr.getControl(_loc1_,ControlMgr.NORMAL);
            _loc3_.target = this;
            _loc3_.rotatable = true;
            _loc3_.setPos(_loc2_.x,_loc2_.y);
            _loc3_.setSize(_loc2_.width,_loc2_.height);
            _loc3_.setOrigin(-_loc2_.x,-_loc2_.y);
            _loc3_.addEventListener("CtrlPointDown",onCtrlPointDownHandler);
            _loc3_.addEventListener("CtrlPointUp",onCtrlPointUpHandler);
            _loc3_.addEventListener("CtrlPointMove",onCtrlPointMoveHandler);
            _prevCharPosX = _loc2_.x;
            _prevCharPosY = _loc2_.y;
            _orgLoaderScaleX = Math.abs(displayElement.scaleX);
            _orgLoaderScaleY = Math.abs(displayElement.scaleY);
            _loc3_.hideControl();
            this.control = _loc3_;
         }
      }
      
      override public function stopProp() : void
      {
         if(this.videoPlayBack != null)
         {
            this.videoPlayBack.pause();
         }
      }
      
      override public function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         super.onStageMouseUpHandler(param1);
      }
      
      override public function set imageData(param1:Object) : void
      {
         super.imageData = param1;
         this.loadAssetImage();
      }
      
      public function playMovie() : void
      {
         var _loc3_:int = 0;
         var _loc4_:AnimeScene = null;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:Prop = null;
         trace("on click video");
         var _loc1_:Number = Console.getConsole().getSceneIndex(this.scene);
         var _loc2_:Number = 0;
         if(_loc1_ > 0)
         {
            trace("cIndex:" + _loc1_);
            _loc3_ = _loc1_ - 1;
            while(_loc3_ >= 0)
            {
               _loc5_ = (_loc4_ = Console.getConsole().getScene(_loc3_)).props.length;
               _loc6_ = false;
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  if((_loc8_ = _loc4_.props.getValueByIndex(_loc7_) as Prop).thumb == this.thumb)
                  {
                     _loc6_ = true;
                  }
                  _loc7_++;
               }
               if(!_loc6_)
               {
                  break;
               }
               _loc2_ = _loc2_ + _loc4_.getLength();
               trace("seekTime:" + _loc2_);
               _loc3_--;
            }
            _loc2_ = UtilUnitConvert.frameToSec(_loc2_);
            trace("seekTime:" + _loc2_);
         }
         if(this.videoPlayBack == null)
         {
            this.videoPlayBack = new VideoPlayback();
            this.videoPlayBack.loadAndSeekPlayVideoByAssetId(this.thumb.id,_loc2_);
            this.displayElement.addChild(this.videoPlayBack);
         }
         else
         {
            this.videoPlayBack.seekAndPlay(_loc2_);
         }
         setTimeout(this.pauseMovie,UtilUnitConvert.frameToSec(this.scene.getLength()) * 1000);
      }
      
      override public function unloadAssetImage(param1:Boolean) : void
      {
      }
      
      override protected function loadAssetImage() : void
      {
         var _loc1_:Canvas = null;
         if(this.thumb.imageData)
         {
            super.loadAssetImage();
            _loc1_ = new Canvas();
            _loc1_.graphics.clear();
            _loc1_.graphics.beginFill(16711680,0);
            _loc1_.graphics.drawRect(0,0,VideoPropThumb(this.thumb).videoWidth,VideoPropThumb(this.thumb).videoHeight);
            _loc1_.graphics.endFill();
            _loc1_.x = -VideoPropThumb(this.thumb).videoWidth / 2;
            _loc1_.y = -VideoPropThumb(this.thumb).videoHeight / 2;
            this.displayElement.addChildAt(_loc1_,0);
         }
         else
         {
            this.loadDefaultImage();
         }
      }
      
      override public function deleteAsset(param1:Boolean = true) : void
      {
         if(this.videoPlayBack != null)
         {
            this.videoPlayBack.pause();
            this.displayElement.removeChild(this.videoPlayBack);
         }
         super.deleteAsset(param1);
      }
      
      override public function set facing(param1:String) : void
      {
         var displayElement:DisplayObject = null;
         var image:Canvas = null;
         var facing:String = param1;
         if(facing != this.facing && (this.facing == AnimeConstants.FACING_LEFT || this.facing == AnimeConstants.FACING_RIGHT))
         {
            try
            {
               displayElement = bundle.getChildAt(0) as DisplayObject;
               image = this.displayElement.getChildByName(AnimeConstants.IMAGE_OBJECT_NAME) as Canvas;
               image.scaleX = image.scaleX * -1;
               scaleX = displayElement.scaleX;
            }
            catch(e:Error)
            {
            }
         }
         super.facing = facing;
      }
      
      public function set image(param1:Canvas) : void
      {
         this._image = param1;
      }
      
      override public function playProp() : void
      {
      }
      
      private function loadDefaultImageComplete(param1:Event) : void
      {
         (param1.target as IEventDispatcher).removeEventListener(param1.type,this.loadDefaultImageComplete);
         displayElement.scaleX = this.scaleX;
         displayElement.scaleY = this.scaleY;
         if(fromTray && Console.getConsole().stageScale > 1)
         {
            this.scaleX = displayElement.scaleX = 1 / Console.getConsole().stageScale;
            this.scaleY = displayElement.scaleY = 1 / Console.getConsole().stageScale;
         }
         this.fromTray = false;
         this.dispatchEvent(new CoreEvent(CoreEvent.LOAD_ASSET_COMPLETE,this));
      }
      
      override public function isColorable() : Boolean
      {
         return false;
      }
      
      public function get image() : Canvas
      {
         return this._image;
      }
      
      override function clone(param1:Boolean = false, param2:AnimeScene = null) : Asset
      {
         var _loc3_:VideoProp = new VideoProp();
         _loc3_.x = this.x;
         _loc3_.y = this.y;
         _loc3_.scaleX = this.scaleX;
         _loc3_.scaleY = this.scaleY;
         _loc3_.rotation = this.rotation;
         _loc3_.scene = this.scene;
         _loc3_.id = _loc3_.bundle.id = this.id;
         _loc3_.attachedBg = this.attachedBg;
         _loc3_.init(this.thumb,null);
         _loc3_.facing = this.facing;
         _loc3_.stateId = this.stateId;
         _loc3_.state = this.state;
         if(this.motionShadow != null)
         {
            _loc3_.x = this.motionShadow.x;
            _loc3_.y = this.motionShadow.y;
            _loc3_.facing = this.motionShadow.facing;
            _loc3_.scaleX = this.motionShadow.scaleX;
            _loc3_.scaleY = this.motionShadow.scaleY;
            _loc3_.rotation = this.motionShadow.rotation;
         }
         return _loc3_;
      }
      
      override protected function getOrigin() : Point
      {
         var _loc1_:Point = new Point();
         var _loc2_:Point = this.displayElement.localToGlobal(new Point());
         var _loc3_:Point = scene.canvas.globalToLocal(_loc2_);
         _loc1_.x = _loc3_.x;
         _loc1_.y = _loc3_.y;
         return _loc1_;
      }
   }
}
