package anifire.tutorial
{
   import anifire.component.CustomCharacterMaker;
   import anifire.event.LoadEmbedMovieEvent;
   import anifire.util.UtilURLStream;
   import caurina.transitions.Tweener;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   import mx.containers.Canvas;
   import mx.containers.ViewStack;
   import mx.core.UIComponent;
   
   public class WalkerGuide extends UIComponent
   {
       
      
      private var _myCCVS:ViewStack;
      
      private var _currActionName:String;
      
      private var _myTar:Point;
      
      public function WalkerGuide()
      {
         super();
         var _loc1_:ViewStack = new ViewStack();
         _loc1_.creationPolicy = "all";
         this.myCC = _loc1_;
      }
      
      private function onMoveFinish() : void
      {
         var _loc1_:LoadEmbedMovieEvent = new LoadEmbedMovieEvent(LoadEmbedMovieEvent.MOVIE_FINISH_EVENT);
         this.dispatchEvent(_loc1_);
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         this.dispatchEvent(param1);
         if(this._myTar != null)
         {
            _loc2_ = Math.abs(this._myTar.x - this.myCC.x) / 100;
            this.moveTo(this._myTar.x,this._myTar.y,_loc2_);
         }
      }
      
      public function load(param1:String, param2:String, param3:String, param4:Point, param5:Point = null, param6:Number = 1, param7:Boolean = false, param8:Number = 100) : void
      {
         var _loc9_:DisplayObject = null;
         if(this.myCC != null)
         {
            if((_loc9_ = this.myCC.getChildByName(param2 + "+" + param3)) != null)
            {
               this.myCC.selectedIndex = this.myCC.getChildIndex(_loc9_);
               trace("myCC.selectedIndex:" + this.myCC.selectedIndex);
               setTimeout(this.switchChild,param8,this.myCC,_loc9_);
            }
            else
            {
               trace("need:" + param2 + "+" + param3);
            }
         }
         trace("myCC.num:" + this.myCC.numChildren);
         if(param4 != null)
         {
            this.myCC.x = param4.x;
            this.myCC.y = param4.y;
         }
         this.myCC.scaleX = this.myCC.scaleY = param6;
         this.myCC.scaleX = !!param7?Number(-1 * this.myCC.scaleX):Number(this.myCC.scaleX);
         this._myTar = param5;
      }
      
      private function switchChild(param1:ViewStack, param2:DisplayObject) : void
      {
         var _loc3_:LoadEmbedMovieEvent = new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT);
         this.onLoadComplete(_loc3_);
      }
      
      private function get myCC() : ViewStack
      {
         return this._myCCVS;
      }
      
      public function isFlip() : Boolean
      {
         return this.myCC.scaleX > 0?false:true;
      }
      
      private function set myCC(param1:ViewStack) : void
      {
         this._myCCVS = param1;
         this.addChild(this._myCCVS);
      }
      
      public function moveTo(param1:Number, param2:Number, param3:Number) : void
      {
         Tweener.addTween(this.myCC,{
            "x":param1,
            "y":param2,
            "time":param3,
            "transition":"linear",
            "onComplete":this.onMoveFinish
         });
      }
      
      public function addAction(param1:String, param2:ByteArray = null, param3:UtilURLStream = null) : void
      {
         var name:String = param1;
         var bytes:ByteArray = param2;
         var stream:UtilURLStream = param3;
         var ccm:CustomCharacterMaker = new CustomCharacterMaker();
         bytes.position = 0;
         ccm.addEventListener(LoadEmbedMovieEvent.COMPLETE_EVENT,function():void
         {
            stream.dispatchEvent(new LoadEmbedMovieEvent(LoadEmbedMovieEvent.COMPLETE_EVENT));
         });
         ccm.updateByZip(bytes);
         var ui:UIComponent = new UIComponent();
         ui.addChild(ccm);
         var can:Canvas = new Canvas();
         can.name = name;
         can.addChild(ui);
         this.myCC.addChild(can);
         trace("myCC.num:" + this.myCC.numChildren);
      }
   }
}
