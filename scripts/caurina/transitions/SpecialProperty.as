package caurina.transitions
{
   public class SpecialProperty
   {
       
      
      public var parameters:Array;
      
      public var getValue:Function;
      
      public var setValue:Function;
      
      public function SpecialProperty(param1:Function, param2:Function, param3:Array = null)
      {
         super();
         this.getValue = param1;
         this.setValue = param2;
         this.parameters = param3;
      }
      
      public function toString() : String
      {
         var _loc1_:* = "";
         _loc1_ = _loc1_ + "[SpecialProperty ";
         _loc1_ = _loc1_ + ("getValue:" + String(this.getValue));
         _loc1_ = _loc1_ + ", ";
         _loc1_ = _loc1_ + ("setValue:" + String(this.setValue));
         _loc1_ = _loc1_ + ", ";
         _loc1_ = _loc1_ + ("parameters:" + String(this.parameters));
         return _loc1_ + "]";
      }
   }
}
