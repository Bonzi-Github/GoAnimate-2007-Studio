package sandy.util
{
   import flash.geom.Point;
   
   public class SandyPoint extends Point
   {
       
      
      public var sx:Number;
      
      public var sy:Number;
      
      public function SandyPoint(param1:Number, param2:Number, param3:Number, param4:Number)
      {
         super(param1,param2);
         this.sx = param3;
         this.sy = param4;
      }
   }
}
