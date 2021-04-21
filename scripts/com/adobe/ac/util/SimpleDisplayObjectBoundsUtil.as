package com.adobe.ac.util
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class SimpleDisplayObjectBoundsUtil
   {
       
      
      public var offsetHeight:Number = 200;
      
      public var offsetWidth:Number = 200;
      
      public function SimpleDisplayObjectBoundsUtil()
      {
         offsetWidth = 200;
         offsetHeight = 200;
         super();
      }
      
      protected function computeFilterBounds(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BitmapData = null;
         var _loc9_:Matrix = null;
         var _loc10_:Rectangle = null;
         _loc2_ = 0;
         _loc3_ = 0;
         _loc4_ = param1.width;
         _loc5_ = param1.height;
         _loc6_ = offsetWidth / 2;
         _loc7_ = offsetHeight / 2;
         _loc8_ = new BitmapData(_loc4_ + offsetWidth,_loc5_ + offsetHeight,true,0);
         (_loc9_ = new Matrix()).translate(_loc6_,_loc7_);
         _loc8_.draw(param1,_loc9_);
         _loc10_ = _loc8_.getColorBoundsRect(4278190080,0,false);
         _loc10_.x = _loc10_.x - _loc6_;
         _loc10_.y = _loc10_.y - _loc7_;
         _loc8_.dispose();
         return _loc10_;
      }
      
      public function getBounds(param1:DisplayObject) : Rectangle
      {
         return computeFilterBounds(param1);
      }
      
      public function getBoundsForOffsetRect(param1:DisplayObject, param2:Rectangle) : Rectangle
      {
         var _loc3_:Rectangle = null;
         _loc3_ = computeFilterBounds(param1);
         if(param2 == null)
         {
            return _loc3_;
         }
         return addToExistingOffsetRect(_loc3_,param2);
      }
      
      protected function addToExistingOffsetRect(param1:Rectangle, param2:Rectangle) : Rectangle
      {
         if(isNaN(param2.x))
         {
            param2.x = param1.x;
         }
         if(isNaN(param2.y))
         {
            param2.y = param1.y;
         }
         if(isNaN(param2.width))
         {
            param2.width = param1.width;
         }
         if(isNaN(param2.height))
         {
            param2.height = param1.height;
         }
         return param2;
      }
   }
}
