package com.adobe.ac.util
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import mx.core.Container;
   import mx.core.UIComponent;
   
   public class DisplayObjectBoundsUtil extends SimpleDisplayObjectBoundsUtil
   {
       
      
      public function DisplayObjectBoundsUtil()
      {
         super();
      }
      
      private function computeFlexBounds(param1:DisplayObject) : Rectangle
      {
         var _loc2_:Rectangle = null;
         if(param1 is Container)
         {
            if(UIComponent(param1).getStyle("dropShadowEnabled"))
            {
               _loc2_ = new Rectangle(-1,0,param1.width + 2,param1.height + 6);
            }
            else
            {
               _loc2_ = new Rectangle(0,0,param1.width,param1.height);
            }
         }
         else
         {
            _loc2_ = computeFilterBounds(param1);
         }
         return _loc2_;
      }
      
      public function getFlexBounds(param1:DisplayObject) : Rectangle
      {
         return computeFlexBounds(param1);
      }
      
      public function getFlexBoundsForOffsetRect(param1:DisplayObject, param2:Rectangle) : Rectangle
      {
         var _loc3_:Rectangle = null;
         _loc3_ = computeFlexBounds(param1);
         if(param2 == null)
         {
            return _loc3_;
         }
         return addToExistingOffsetRect(_loc3_,param2);
      }
   }
}
