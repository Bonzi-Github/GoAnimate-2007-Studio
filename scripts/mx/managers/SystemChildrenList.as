package mx.managers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import mx.core.IChildList;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class SystemChildrenList implements IChildList
   {
      
      mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      private var lowerBoundReference:QName;
      
      private var upperBoundReference:QName;
      
      private var owner:SystemManager;
      
      public function SystemChildrenList(param1:SystemManager, param2:QName, param3:QName)
      {
         super();
         this.owner = param1;
         this.lowerBoundReference = param2;
         this.upperBoundReference = param3;
      }
      
      public function getChildAt(param1:int) : DisplayObject
      {
         return owner.mx_internal::rawChildren_getChildAt(owner[lowerBoundReference] + param1);
      }
      
      public function getChildByName(param1:String) : DisplayObject
      {
         return owner.mx_internal::rawChildren_getChildByName(param1);
      }
      
      public function removeChildAt(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = owner.mx_internal::rawChildren_removeChildAt(param1 + owner[lowerBoundReference]);
         --owner[upperBoundReference];
         return _loc2_;
      }
      
      public function getChildIndex(param1:DisplayObject) : int
      {
         var _loc2_:int = owner.mx_internal::rawChildren_getChildIndex(param1);
         return int(_loc2_ - owner[lowerBoundReference]);
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         owner.mx_internal::rawChildren_addChildAt(param1,owner[lowerBoundReference] + param2);
         ++owner[upperBoundReference];
         return param1;
      }
      
      public function getObjectsUnderPoint(param1:Point) : Array
      {
         return owner.mx_internal::rawChildren_getObjectsUnderPoint(param1);
      }
      
      public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
         owner.mx_internal::rawChildren_setChildIndex(param1,owner[lowerBoundReference] + param2);
      }
      
      public function get numChildren() : int
      {
         return owner[upperBoundReference] - owner[lowerBoundReference];
      }
      
      public function contains(param1:DisplayObject) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 != owner && owner.mx_internal::rawChildren_contains(param1))
         {
            while(param1.parent != owner)
            {
               param1 = param1.parent;
            }
            _loc2_ = owner.mx_internal::rawChildren_getChildIndex(param1);
            if(_loc2_ >= owner[lowerBoundReference] && _loc2_ < owner[upperBoundReference])
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:int = owner.mx_internal::rawChildren_getChildIndex(param1);
         if(owner[lowerBoundReference] <= _loc2_ && _loc2_ < owner[upperBoundReference])
         {
            owner.mx_internal::rawChildren_removeChild(param1);
            --owner[upperBoundReference];
         }
         return param1;
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject
      {
         owner.mx_internal::rawChildren_addChildAt(param1,owner[upperBoundReference]);
         ++owner[upperBoundReference];
         return param1;
      }
   }
}
