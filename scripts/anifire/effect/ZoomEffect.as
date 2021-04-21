package anifire.effect
{
   import anifire.util.Util;
   import anifire.util.UtilDraw;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ZoomEffect extends ProgramEffect
   {
       
      
      private var _isCut:Boolean = false;
      
      private var _myThumbnailSymbol_cut:Class;
      
      private const RGB:Number = 13421772;
      
      private var _isPan:Boolean = false;
      
      private const LINESIZE:Number = 5;
      
      private var _myThumbnailSymbol_pan:Class;
      
      private var _myThumbnailSymbol:Class;
      
      private const ALPHA:Number = 0.6;
      
      public function ZoomEffect(param1:String = "")
      {
         this._myThumbnailSymbol = ZoomEffect__myThumbnailSymbol;
         this._myThumbnailSymbol_cut = ZoomEffect__myThumbnailSymbol_cut;
         this._myThumbnailSymbol_pan = ZoomEffect__myThumbnailSymbol_pan;
         super();
         type = EffectMgr.TYPE_ZOOM;
         if(param1 == EffectMgr.TYPE_CUT)
         {
            this._isCut = true;
         }
         else if(param1 == EffectMgr.TYPE_PAN)
         {
            this._isPan = true;
         }
         if(this._isCut)
         {
            thumbnailSymbol = this._myThumbnailSymbol_cut;
         }
         else if(this._isPan)
         {
            thumbnailSymbol = this._myThumbnailSymbol_pan;
         }
         else
         {
            thumbnailSymbol = this._myThumbnailSymbol;
         }
         this.redraw();
      }
      
      public function set isPan(param1:Boolean) : void
      {
         this._isPan = param1;
      }
      
      override public function serialize() : XML
      {
         return <effect x="{x}" y="{y}" w="{Util.roundNum(width)}" h="{Util.roundNum(height)}" rotate='0' id="{id}" type="{type}" isCut="{this._isCut.toString()}" isPan="{this._isPan.toString()}">
											 </effect>;
      }
      
      override protected function drawBody() : void
      {
         if(super.body != null)
         {
            content.removeChild(super.body);
         }
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = "body";
         _loc1_.graphics.lineStyle(this.LINESIZE,this.ALPHA);
         UtilDraw.drawDashRect(_loc1_,x,y,width,height,6,8);
         _loc1_.graphics.lineStyle(20,16777215,0);
         _loc1_.graphics.drawRect(x,y,width,height);
         super.body = content.addChild(_loc1_) as Sprite;
      }
      
      override public function redraw() : void
      {
         this.drawBody();
         this.drawLabel();
      }
      
      override protected function drawLabel() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:TextField = null;
         super.drawLabel();
         if(super.label != null && this.contains(super.label))
         {
            this.removeChild(super.label);
         }
         if(this.width > 80)
         {
            _loc1_ = 70;
            if(this._isCut)
            {
               _loc2_ = returnLabel(EffectMgr.TYPE_CUT,this.width,this.height,false);
            }
            else if(this._isPan)
            {
               _loc2_ = returnLabel(EffectMgr.TYPE_PAN,this.width,this.height,false);
            }
            else
            {
               _loc2_ = returnLabel(EffectMgr.TYPE_ZOOM,this.width,this.height,false);
            }
            _loc2_.x = x;
            _loc2_.width = _loc1_;
            boundHeight = height;
            boundWidth = width;
            super.label = addChild(_loc2_) as TextField;
            updateVerticalAlign();
            _loc2_.y = y + height - _loc2_.height;
         }
      }
      
      public function get isPan() : Boolean
      {
         return this._isPan;
      }
      
      public function get isCut() : Boolean
      {
         return this._isCut;
      }
   }
}
