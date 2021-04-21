package caurina.transitions
{
   public class PropertyInfoObj
   {
       
      
      public var modifierParameters:Array;
      
      public var valueComplete:Number;
      
      public var modifierFunction:Function;
      
      public var hasModifier:Boolean;
      
      public var valueStart:Number;
      
      public function PropertyInfoObj(param1:Number, param2:Number, param3:Function, param4:Array)
      {
         super();
         this.valueStart = param1;
         this.valueComplete = param2;
         this.hasModifier = Boolean(param3);
         this.modifierFunction = param3;
         this.modifierParameters = param4;
      }
      
      public function toString() : String
      {
         var _loc1_:* = "\n[PropertyInfoObj ";
         _loc1_ = _loc1_ + ("valueStart:" + String(this.valueStart));
         _loc1_ = _loc1_ + ", ";
         _loc1_ = _loc1_ + ("valueComplete:" + String(this.valueComplete));
         _loc1_ = _loc1_ + ", ";
         _loc1_ = _loc1_ + ("modifierFunction:" + String(this.modifierFunction));
         _loc1_ = _loc1_ + ", ";
         _loc1_ = _loc1_ + ("modifierParameters:" + String(this.modifierParameters));
         return _loc1_ + "]\n";
      }
      
      public function clone() : PropertyInfoObj
      {
         return new PropertyInfoObj(this.valueStart,this.valueComplete,this.modifierFunction,this.modifierParameters);
      }
   }
}
