package sandy.util
{
   import flash.geom.Matrix;
   
   public class Triangle
   {
       
      
      public var p0:SandyPoint;
      
      public var p1:SandyPoint;
      
      public var p2:SandyPoint;
      
      public var tMat:Matrix;
      
      public function Triangle(param1:SandyPoint, param2:SandyPoint, param3:SandyPoint, param4:Matrix)
      {
         super();
         this.p0 = param1;
         this.p1 = param2;
         this.p2 = param3;
         this.tMat = param4;
      }
   }
}
