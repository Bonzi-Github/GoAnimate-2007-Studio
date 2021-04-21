package anifire.component
{
   import anifire.constant.AnimeConstants;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.util.UtilHashArray;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class CCThumb extends Sprite
   {
       
      
      private var _cellWidth:int;
      
      private var _height:int;
      
      private var _width:int;
      
      private var _cellHeight:int;
      
      public function CCThumb()
      {
         super();
         this.cellWidth = AnimeConstants.TILE_CHAR_WIDTH - AnimeConstants.TILE_INSETS * 2;
         this.cellHeight = AnimeConstants.TILE_CHAR_HEIGHT - AnimeConstants.TILE_INSETS * 2;
      }
      
      private function photoCap(param1:LoadEmbedMovieEvent) : void
      {
         var _loc2_:CustomCharacterMaker = CustomCharacterMaker(param1.currentTarget);
         var _loc3_:Number = _loc2_.width;
         var _loc4_:Number = _loc2_.height;
         var _loc5_:Number = 1;
         _loc5_ = this.cellWidth / _loc3_;
         if(_loc4_ * _loc5_ > this.cellHeight)
         {
            _loc5_ = this.cellHeight / _loc4_;
         }
         var _loc6_:BitmapData = new BitmapData(_loc2_.width * _loc5_,_loc2_.height * _loc5_,true,16711680);
         var _loc7_:Matrix = new Matrix();
         _loc2_.x = _loc2_.y = 0;
         this.addChild(_loc2_);
         var _loc8_:Rectangle = _loc2_.getBounds(this);
         _loc7_.translate(-_loc8_.x,-_loc8_.y);
         _loc7_.scale(_loc5_,_loc5_);
         _loc6_.draw(_loc2_,_loc7_,null,null,null,true);
         var _loc9_:Bitmap;
         (_loc9_ = new Bitmap()).bitmapData = _loc6_;
         _loc9_.x = _loc9_.y = 0;
         this._width = _loc9_.width;
         this._height = _loc9_.height;
         this.addChild(_loc9_);
         _loc2_.destroy();
         this.removeChild(_loc2_);
         this.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
      }
      
      public function get cellWidth() : int
      {
         return this._cellWidth;
      }
      
      public function get cellHeight() : int
      {
         return this._cellHeight;
      }
      
      private function initCCMakerComplete(param1:Event) : void
      {
         var _loc2_:CustomCharacterMaker = CustomCharacterMaker(param1.currentTarget);
         _loc2_.reloadSkin();
         setTimeout(this.photoCap,1000,param1);
      }
      
      public function set cellWidth(param1:int) : void
      {
         this._cellWidth = param1;
      }
      
      public function set cellHeight(param1:int) : void
      {
         this._cellHeight = param1;
      }
      
      public function initByXml(param1:XML) : void
      {
         var _loc2_:CustomCharacterMaker = null;
         if(param1)
         {
            _loc2_ = new CustomCharacterMaker();
            _loc2_.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.initCCMakerComplete);
            _loc2_.initByXml(param1);
         }
      }
      
      public function get thumbWidth() : int
      {
         return this._width;
      }
      
      public function get thumbHeight() : int
      {
         return this._height;
      }
      
      public function init(param1:XML, param2:UtilHashArray, param3:UtilHashArray = null) : void
      {
         trace("ccthumb:: init");
         var _loc4_:CustomCharacterMaker;
         (_loc4_ = new CustomCharacterMaker()).addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,this.initCCMakerComplete);
         _loc4_.initBySwfs(param1,param2,param3);
      }
   }
}
