package Singularity.Geom
{
   public interface IPoly
   {
       
      
      function getX(param1:Number) : Number;
      
      function getCoef(param1:uint) : Object;
      
      function getDeriv(param1:Number) : Number;
      
      function getY(param1:Number) : Number;
      
      function toString() : String;
      
      function getYPrime(param1:Number) : Number;
      
      function getXPrime(param1:Number) : Number;
      
      function addCoef(param1:Number, param2:Number) : void;
      
      function reset() : void;
   }
}
