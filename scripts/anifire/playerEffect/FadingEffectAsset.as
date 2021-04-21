package anifire.playerEffect
{
   import anifire.constant.AnimeConstants;
   import anifire.effect.EffectMgr;
   import anifire.playback.AnimeScene;
   import anifire.util.Util;
   import anifire.util.UtilPlain;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class FadingEffectAsset extends ProgramEffectAsset
   {
       
      
      private var _isOut:Boolean = false;
      
      private var _isIn:Boolean = false;
      
      private var _effectContainer:Sprite;
      
      public function FadingEffectAsset()
      {
         super();
      }
      
      override public function goToAndPause(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
         this.play(param2);
      }
      
      override public function resume() : void
      {
      }
      
      public function init(param1:XML, param2:AnimeScene, param3:DisplayObjectContainer) : void
      {
         initAsset(param1.@id,param1.@index,param2);
         var _loc4_:XML = param1.child(EffectMgr.XML_NODE_TAG)[0];
         initEffectAsset(EffectMgr.getType(_loc4_));
         var _loc5_:String;
         if((_loc5_ = _loc4_.@isIn) == "true")
         {
            this._isIn = true;
         }
         var _loc6_:String;
         if((_loc6_ = _loc4_.@isOut) == "true")
         {
            this._isOut = true;
         }
         this.effectee = param3;
         this._sttime = param1["st"];
         this._edtime = param1["et"];
         this._effectContainer = new Sprite();
         this.effectee.addChild(this._effectContainer);
      }
      
      override public function play(param1:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Sprite = null;
         var _loc2_:Boolean = true;
         var _loc3_:Number = param1 - this.startFrame + 1;
         if(!(this._sttime == 0 && this._edtime == 0 || _loc3_ >= this._sttime && _loc3_ <= this._edtime))
         {
            _loc2_ = false;
         }
         UtilPlain.removeAllSon(this._effectContainer);
         if(this._sttime != 0 || this._edtime != 0)
         {
            _loc4_ = Util.roundNum((_loc3_ - this._sttime) / (this._edtime - this._sttime),2);
         }
         else
         {
            _loc4_ = Util.roundNum((_loc3_ + 1) / (this.length - 1),2);
         }
         if(this._isIn)
         {
            _loc4_ = 1 - _loc4_;
         }
         if(_loc2_)
         {
            (_loc5_ = new Sprite()).graphics.beginFill(0,_loc4_);
            _loc5_.graphics.drawRect(AnimeConstants.SCREEN_X,AnimeConstants.SCREEN_Y,AnimeConstants.SCREEN_WIDTH,AnimeConstants.SCREEN_HEIGHT);
            _loc5_.graphics.endFill();
            this._effectContainer.mouseEnabled = false;
            this._effectContainer.mouseChildren = false;
            this._effectContainer.addChild(_loc5_);
         }
      }
      
      override public function pause() : void
      {
      }
      
      override public function destroy(param1:Boolean = false) : void
      {
      }
      
      public function initDependency(param1:Number, param2:Number) : void
      {
         this.startFrame = param1;
         this.length = param2;
      }
   }
}
