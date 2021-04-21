package caurina.transitions
{
   public class SpecialPropertyModifier
   {
       
      
      public var getValue:Function;
      
      public var modifyValues:Function;
      
      public function SpecialPropertyModifier(param1:Function, param2:Function)
      {
         super();
         this.modifyValues = param1;
         this.getValue = param2;
      }
      
      public function toString() : String
      {
         var _loc1_:* = "";
         _loc1_ = _loc1_ + "[SpecialPropertyModifier ";
         _loc1_ = _loc1_ + ("modifyValues:" + String(this.modifyValues));
         _loc1_ = _loc1_ + ", ";
         _loc1_ = _loc1_ + ("getValue:" + String(this.getValue));
         return _loc1_ + "]";
      }
   }
}
