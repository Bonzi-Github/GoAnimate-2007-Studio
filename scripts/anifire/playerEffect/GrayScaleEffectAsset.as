package anifire.playerEffect
{
   import anifire.constant.AnimeConstants;
   import anifire.effect.EffectMgr;
   import anifire.playback.AnimeScene;
   import com.gskinner.geom.ColorMatrix;
   import flash.display.BlendMode;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shader;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GrayScaleEffectAsset extends ProgramEffectAsset
   {
       
      
      private var _originalPos:Point;
      
      private var _active:Boolean;
      
      private var _effectImage:Sprite;
      
      private var GrayScaleShaderClass:Class;
      
      private var _shader:Shader;
      
      public function GrayScaleEffectAsset()
      {
         this.GrayScaleShaderClass = GrayScaleEffectAsset_GrayScaleShaderClass;
         super();
      }
      
      override public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         this.play(param2);
      }
      
      private function get originalPos() : Point
      {
         return this._originalPos;
      }
      
      private function set originalPos(param1:Point) : void
      {
         this._originalPos = param1;
      }
      
      override public function resume() : void
      {
      }
      
      override public function propagateSceneState(param1:int) : void
      {
         if(param1 == AnimeScene.STATE_ACTION)
         {
            this.setState(STATE_ACTION);
         }
         else if(param1 == AnimeScene.STATE_NULL)
         {
            this.setState(STATE_NULL);
         }
      }
      
      public function init(param1:XML, param2:AnimeScene, param3:DisplayObjectContainer) : void
      {
         trace("grayscale init");
         this._shader = new Shader();
         this._shader.byteCode = new this.GrayScaleShaderClass();
         initAsset(param1.@id,param1.@index,param2);
         var _loc4_:XML = param1.child(EffectMgr.XML_NODE_TAG)[0];
         initEffectAsset(EffectMgr.getType(_loc4_));
         this.effectee = param3;
         this.originalPos = new Point(this.effectee.x,this.effectee.y);
         this._sttime = param1["st"];
         this._edtime = param1["et"];
         this._active = false;
      }
      
      override public function play(param1:Number) : void
      {
         var _loc2_:Boolean = true;
         var _loc3_:ColorMatrix = new ColorMatrix();
         var _loc4_:Number = param1 - this.startFrame;
         if(!(this._sttime == 0 && this._edtime == 0 || _loc4_ >= this._sttime && _loc4_ <= this._edtime))
         {
            _loc2_ = false;
         }
         if(param1 <= this.startFrame + this.length && _loc2_)
         {
            if(!this._active)
            {
               this.effectee.addChild(this._effectImage);
               this._active = true;
               trace("apply gray scale");
            }
         }
         else if(this._active)
         {
            this.effectee.removeChild(this._effectImage);
            this._active = false;
            trace("remove gray scale");
         }
      }
      
      public function restore() : void
      {
         this.effectee.removeChild(this._effectImage);
         this._active = false;
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
      }
      
      public function initDependency(param1:Number, param2:Number) : void
      {
         trace("grayscale initdependency");
         this.startFrame = param1;
         this.length = param2;
         this._effectImage = new Sprite();
         this._effectImage.graphics.clear();
         this._effectImage.graphics.beginFill(16777215);
         this._effectImage.graphics.drawRect(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
         this._effectImage.graphics.endFill();
         this._effectImage.blendShader = this._shader;
         this._effectImage.blendMode = BlendMode.SHADER;
         this._effectImage.mouseChildren = false;
         this._effectImage.mouseEnabled = false;
      }
      
      override public function pause() : void
      {
      }
      
      override protected function setState(param1:int) : void
      {
         if(param1 == STATE_ACTION || param1 == STATE_MOTION)
         {
         }
         super.setState(param1);
      }
   }
}
