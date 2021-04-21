package anifire.control
{
   import Singularity.Geom.BezierSpline;
   import anifire.core.Asset;
   import anifire.core.Character;
   import anifire.core.Prop;
   import anifire.util.UtilPlain;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class myBezierSpline extends BezierSpline
   {
       
      
      private var __containAsset:Asset;
      
      public function myBezierSpline()
      {
         super();
      }
      
      override public function draw(param1:Number = 3.0, param2:Number = 3, param3:Number = 3, param4:Number = 15) : void
      {
         var _loc6_:Sprite = null;
         if(__invalidate)
         {
            __assignControlPoints();
         }
         if(__container.numChildren > 0)
         {
            UtilPlain.removeAllSon(__container);
         }
         var _loc5_:uint = 0;
         while(_loc5_ < __bezier.length)
         {
            _loc6_ = new Sprite();
            __container.addChild(_loc6_);
            _loc6_.name = _loc5_.toString();
            if(this.__containAsset is Character)
            {
               _loc6_.addEventListener(MouseEvent.CLICK,Character(this.__containAsset).showMotionMenu);
            }
            else if(this.__containAsset is Prop)
            {
               _loc6_.addEventListener(MouseEvent.CLICK,Prop(this.__containAsset).showMotionMenu);
            }
            __bezier[_loc5_].draw(_loc6_,param1,__color,__closed,param2,param3,param4);
            _loc5_++;
         }
      }
      
      public function set containAsset(param1:Asset) : void
      {
         this.__containAsset = param1;
      }
   }
}
