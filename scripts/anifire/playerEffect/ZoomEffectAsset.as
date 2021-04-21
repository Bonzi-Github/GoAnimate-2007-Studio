package anifire.playerEffect
{
   import anifire.constant.AnimeConstants;
   import anifire.effect.EffectMgr;
   import anifire.effect.ZoomEffect;
   import anifire.playback.AnimeScene;
   import anifire.util.UtilUnitConvert;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public class ZoomEffectAsset extends ProgramEffectAsset
   {
      
      private static const ERR_RANGE:Number = 0.2;
      
      private static const RASTERIZED_IMG_NAME:String = "zoom_rasterized_img";
       
      
      private var _targetScale:Point;
      
      private var _mode:String = "mode_normal";
      
      private var _cut:Boolean = false;
      
      private var _targetPos:Point;
      
      private var _prevZoom:ZoomEffectAsset;
      
      private var _originalPos:Point;
      
      public const MODE_NOR:String = "mode_normal";
      
      private var _active:Boolean;
      
      private var _effectX:Number;
      
      private var _effectY:Number;
      
      private var _isRasterized:Boolean;
      
      private var _refZoom:ZoomEffectAsset;
      
      private var _pan:Boolean = false;
      
      public const MODE_EXT:String = "mode_extend_currzoom";
      
      public const MODE_PRE:String = "mode_previous_zoom";
      
      private var _effectWidth:Number;
      
      private var _effectHeight:Number;
      
      private var _originalScale:Point;
      
      public function ZoomEffectAsset()
      {
         super();
      }
      
      public static function isDummyZoomNeededForCurrentZoom(param1:ZoomEffectAsset) : Boolean
      {
         if(param1 != null)
         {
            if(param1.sttime != 0 && param1.edtime != 0)
            {
               if(getDiffSec(param1.edtime,param1.parentScene.getDuration()) >= ERR_RANGE || param1.edzoom >= 0.1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private static function getDiffSec(param1:Number, param2:Number) : Number
      {
         return Math.abs(UtilUnitConvert.frameToSec(param1) - UtilUnitConvert.frameToSec(param2));
      }
      
      public static function isDummyZoomNeededForPreviousZoom(param1:ZoomEffectAsset, param2:ZoomEffectAsset) : Boolean
      {
         if(param1 != null)
         {
            if(param1.sttime == 0 && param1.edtime == 0 || getDiffSec(param1.edtime,param1.parentScene.getDuration()) < ERR_RANGE)
            {
               if(param2 == null || param2.sttime > 1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      override public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         this.play(param2);
      }
      
      private function get targetPos() : Point
      {
         return this._targetPos;
      }
      
      public function set refZoom(param1:ZoomEffectAsset) : void
      {
         this._refZoom = param1;
      }
      
      public function get refZoom() : ZoomEffectAsset
      {
         return this._refZoom;
      }
      
      public function init(param1:XML, param2:AnimeScene, param3:DisplayObjectContainer) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc16_:Number = NaN;
         trace("init zoom");
         initAsset(param1.@id,param1.@index,param2);
         var _loc4_:XML = param1.child(EffectMgr.XML_NODE_TAG)[0];
         initEffectAsset(EffectMgr.getType(_loc4_));
         var _loc5_:ZoomEffect = EffectMgr.getEffectByXML(_loc4_) as ZoomEffect;
         var _loc10_:Array = String(param1.x).split(",");
         var _loc11_:Array = String(param1.y).split(",");
         var _loc12_:Array = String(param1.width).split(",");
         var _loc13_:Array = String(param1.height).split(",");
         this._effectX = _loc6_ = param1.x;
         this._effectY = _loc7_ = param1.y;
         this._effectWidth = _loc8_ = _loc5_.width;
         this._effectHeight = _loc9_ = _loc5_.height;
         this.sttime = param1["st"];
         this.edtime = param1["et"];
         if(param1["st"].@dur > -1)
         {
            this.stzoom = UtilUnitConvert.frameToSec(param1["st"].@dur,false);
         }
         else
         {
            this.stzoom = AnimeConstants.ZOOM_DURATION;
         }
         if(param1["et"].@dur > -1)
         {
            this.edzoom = UtilUnitConvert.frameToSec(param1["et"].@dur,false);
         }
         else
         {
            this.edzoom = AnimeConstants.ZOOM_DURATION;
         }
         this.mode = this.MODE_NOR;
         var _loc14_:String;
         if((_loc14_ = _loc4_.@isCut) == "true")
         {
            this.cut = true;
         }
         var _loc15_:String;
         if((_loc15_ = _loc4_.@isPan) == "true")
         {
            this.pan = true;
         }
         this.effectee = param3;
         this.isRasterized = false;
         if(_loc10_.length == 1)
         {
            this.originalPos = new Point(this.effectee.x,this.effectee.y);
            this.originalScale = new Point(this.effectee.scaleX,this.effectee.scaleY);
            _loc16_ = AnimeConstants.SCREEN_WIDTH / _loc8_;
            this.targetPos = new Point(this.originalPos.x - _loc6_ * _loc16_ + AnimeConstants.SCREEN_X,this.originalPos.y - _loc7_ * _loc16_ + AnimeConstants.SCREEN_Y);
            this.targetScale = new Point(this.originalScale.x * _loc16_,this.originalScale.y * _loc16_);
         }
         else
         {
            this.stzoom = param2.getDuration();
            _loc16_ = AnimeConstants.SCREEN_WIDTH / _loc12_[0];
            this.originalPos = new Point(-_loc10_[0] * _loc16_ + AnimeConstants.SCREEN_X,-_loc11_[0] * _loc16_ + AnimeConstants.SCREEN_Y);
            this.originalScale = new Point(_loc16_,_loc16_);
            _loc16_ = AnimeConstants.SCREEN_WIDTH / _loc12_[1];
            this.targetPos = new Point(-_loc10_[1] * _loc16_ + AnimeConstants.SCREEN_X,-_loc11_[1] * _loc16_ + AnimeConstants.SCREEN_Y);
            this.targetScale = new Point(_loc16_,_loc16_);
         }
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
      }
      
      private function set targetScale(param1:Point) : void
      {
         this._targetScale = param1;
      }
      
      public function set cut(param1:Boolean) : void
      {
         this._cut = param1;
      }
      
      public function get pan() : Boolean
      {
         return this._pan;
      }
      
      private function set originalPos(param1:Point) : void
      {
         this._originalPos = param1;
      }
      
      public function get mode() : String
      {
         return this._mode;
      }
      
      public function get prevZoom() : ZoomEffectAsset
      {
         return this._prevZoom;
      }
      
      override public function resume() : void
      {
      }
      
      private function set isRasterized(param1:Boolean) : void
      {
         this._isRasterized = param1;
      }
      
      public function restore() : void
      {
         if(this.effectee != null)
         {
            this.effectee.x = 0;
            this.effectee.y = 0;
            this.effectee.scaleX = 1;
            this.effectee.scaleY = 1;
         }
      }
      
      private function set targetPos(param1:Point) : void
      {
         this._targetPos = param1;
      }
      
      public function initDependency(param1:Number, param2:Number, param3:ZoomEffectAsset) : void
      {
         this.startFrame = param1;
         this.endFrame = param2;
         var _loc4_:Boolean = false;
         if(param3 != null && this.mode == this.MODE_PRE)
         {
            this.originalPos = param3.targetPos.clone();
            this.originalScale = param3.targetScale.clone();
            _loc4_ = true;
         }
         else if(this.mode == this.MODE_EXT)
         {
            this.originalPos = this.refZoom.targetPos.clone();
            this.originalScale = this.refZoom.targetScale.clone();
         }
         else if(this.mode == this.MODE_NOR && param3 != null && !this.pan)
         {
            if((getDiffSec(param3.parentScene.getDuration(),param3.edtime) < ERR_RANGE || param3.edtime == 0) && getDiffSec(this.startFrame,this.parentScene.getStartFrame()) < ERR_RANGE)
            {
               this.originalPos = param3.targetPos.clone();
               this.originalScale = param3.targetScale.clone();
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            this.effectee.x = this.originalPos.x;
            this.effectee.y = this.originalPos.y;
            this.effectee.scaleX = this.originalScale.x;
            this.effectee.scaleY = this.originalScale.y;
         }
      }
      
      private function get targetScale() : Point
      {
         return this._targetScale;
      }
      
      public function set pan(param1:Boolean) : void
      {
         this._pan = param1;
      }
      
      override public function play(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc2_ = (param1 - this.startFrame) / (this.endFrame - this.startFrame);
         _loc3_ = (param1 - 1 - this.startFrame) / (this.endFrame - this.startFrame);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         else if(_loc2_ > 1 || this.endFrame - this.startFrame == 1)
         {
            _loc2_ = 1;
         }
         if(param1 >= this.startFrame && param1 <= this.endFrame)
         {
            if(this.cut == true)
            {
               _loc2_ = 1;
            }
            _loc4_ = Math.round(this.originalPos.x + (this.targetPos.x - this.originalPos.x) * _loc2_);
            if(this.effectee.x != _loc4_)
            {
               this.effectee.x = _loc4_;
            }
            _loc4_ = Math.round(this.originalPos.y + (this.targetPos.y - this.originalPos.y) * _loc2_);
            if(this.effectee.y != _loc4_)
            {
               this.effectee.y = _loc4_;
            }
            _loc4_ = this.originalScale.x + (this.targetScale.x - this.originalScale.x) * _loc2_;
            if(this.effectee.scaleX != _loc4_)
            {
               this.effectee.scaleX = _loc4_;
            }
            _loc4_ = this.originalScale.y + (this.targetScale.y - this.originalScale.y) * _loc2_;
            if(this.effectee.scaleY != _loc4_)
            {
               this.effectee.scaleY = _loc4_;
            }
            this._active = true;
         }
      }
      
      public function get cut() : Boolean
      {
         return this._cut;
      }
      
      private function get originalPos() : Point
      {
         return this._originalPos;
      }
      
      public function set mode(param1:String) : void
      {
         this._mode = param1;
      }
      
      public function set prevZoom(param1:ZoomEffectAsset) : void
      {
         this._prevZoom = param1;
      }
      
      private function get isRasterized() : Boolean
      {
         return this._isRasterized;
      }
      
      public function returnString() : String
      {
         return this.id + "," + this.mode + "," + this.startFrame + "," + this.endFrame;
      }
      
      public function initDummyZoom(param1:AnimeScene, param2:DisplayObjectContainer, param3:ZoomEffectAsset, param4:ZoomEffectAsset, param5:String = "mode_normal") : void
      {
         trace("initDummyZoom");
         var _loc6_:Number = new Date().valueOf() * Math.random();
         initAsset("dummy_zoom_" + _loc6_.toString(),-1,param1);
         initEffectAsset(EffectMgr.TYPE_ZOOM);
         this.mode = param5;
         this.prevZoom = param3;
         this.refZoom = param4;
         if(param3 != null && this.mode == this.MODE_PRE)
         {
            if(param3.cut)
            {
               this.cut = true;
            }
         }
         if(param4 != null)
         {
            if(param4.cut && this.mode == this.MODE_EXT)
            {
               if(param4.cut)
               {
                  this.cut = true;
               }
            }
            if(param4.edzoom > -1)
            {
               this.edzoom = param4.edzoom;
            }
         }
         this._effectX = AnimeConstants.SCREEN_X;
         this._effectY = AnimeConstants.SCREEN_Y;
         this._effectWidth = AnimeConstants.SCREEN_WIDTH;
         this._effectHeight = AnimeConstants.SCREEN_HEIGHT;
         this.effectee = param2;
         this.originalPos = new Point(param2.x,param2.y);
         this.originalScale = new Point(1,1);
         this.targetPos = this.originalPos.clone();
         this.targetScale = this.originalScale.clone();
      }
      
      private function set originalScale(param1:Point) : void
      {
         this._originalScale = param1;
      }
      
      private function get originalScale() : Point
      {
         return this._originalScale;
      }
      
      override public function pause() : void
      {
      }
   }
}
