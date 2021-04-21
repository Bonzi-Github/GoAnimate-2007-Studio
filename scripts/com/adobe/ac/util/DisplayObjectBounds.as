package com.adobe.ac.util
{
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DisplayObjectBounds
   {
       
      
      public var width:Number;
      
      public var topRight:Point;
      
      public var left:Number;
      
      public var bottomLeft:Point;
      
      public var top:Number;
      
      public var height:Number;
      
      private var concatenatedMatrix:Matrix;
      
      public var bottomRight:Point;
      
      public var topLeft:Point;
      
      public function DisplayObjectBounds()
      {
         super();
      }
      
      public function getActualBounds(param1:DisplayObject, param2:Rectangle = null, param3:Matrix = null) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         param2 = getSimpleBounds(param1,param2);
         _loc4_ = left = param2.left;
         _loc5_ = top = param2.top;
         if(param3 == null)
         {
            width = param2.width;
            height = param2.height;
         }
         else
         {
            width = param2.width * param3.a;
            height = param2.height * param3.d;
         }
         computePoints(_loc4_,_loc5_);
      }
      
      public function getBounds(param1:DisplayObject, param2:Rectangle = null) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         param2 = getSimpleBounds(param1,param2);
         _loc3_ = left = param2.left;
         _loc4_ = top = param2.top;
         width = param2.width;
         height = param2.height;
         computePoints(_loc3_,_loc4_);
      }
      
      private function computePoints(param1:Number, param2:Number) : void
      {
         topLeft = new Point(param1,param2);
         topRight = new Point(param1 + width,param2);
         bottomRight = new Point(param1 + width,param2 + height);
         bottomLeft = new Point(param1,param2 + height);
      }
      
      private function getSimpleBounds(param1:DisplayObject, param2:Rectangle) : Rectangle
      {
         if(param2 == null)
         {
            param2 = param1.getBounds(param1);
         }
         return param2;
      }
   }
}
