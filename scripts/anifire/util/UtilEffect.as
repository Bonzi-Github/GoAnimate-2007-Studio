package anifire.util
{
   import caurina.transitions.Equations;
   
   public class UtilEffect
   {
      
      private static var fxArray:UtilHashArray;
       
      
      public function UtilEffect()
      {
         super();
         fxArray = new UtilHashArray();
         insertEffects(fxArray);
      }
      
      private static function insertEffects(param1:UtilHashArray) : void
      {
         param1.push("easeInBack",Equations.easeInBack);
         param1.push("easeInBounce",Equations.easeInBounce);
         param1.push("easeInCirc",Equations.easeInCirc);
         param1.push("easeInCubic",Equations.easeInCubic);
         param1.push("easeInElastic",Equations.easeInElastic);
         param1.push("easeInExpo",Equations.easeInExpo);
         param1.push("easeInOutBack",Equations.easeInOutBack);
         param1.push("easeInOutBounce",Equations.easeInOutBounce);
         param1.push("easeInOutCirc",Equations.easeInOutCirc);
         param1.push("easeInOutCubic",Equations.easeInOutCubic);
         param1.push("easeInOutElastic",Equations.easeInOutElastic);
         param1.push("easeInOutExpo",Equations.easeInOutExpo);
         param1.push("easeInOutQuad",Equations.easeInOutQuad);
         param1.push("easeInOutQuart",Equations.easeInOutQuart);
         param1.push("easeInOutQuint",Equations.easeInOutQuint);
         param1.push("easeInOutSine",Equations.easeInOutSine);
         param1.push("easeInQuad",Equations.easeInQuad);
         param1.push("easeInQuart",Equations.easeInQuart);
         param1.push("easeInQuint",Equations.easeInQuint);
         param1.push("easeInSine",Equations.easeInSine);
         param1.push("easeOutBack",Equations.easeOutBack);
         param1.push("easeOutBounce",Equations.easeOutBounce);
         param1.push("easeOutCirc",Equations.easeOutCirc);
         param1.push("easeOutCubic",Equations.easeOutCubic);
         param1.push("easeOutElastic",Equations.easeOutElastic);
         param1.push("easeOutExpo",Equations.easeOutExpo);
         param1.push("easeOutInBack",Equations.easeOutInBack);
         param1.push("easeOutInBounce",Equations.easeOutInBounce);
         param1.push("easeOutInCirc",Equations.easeOutInCirc);
         param1.push("easeOutInCubic",Equations.easeOutInCubic);
         param1.push("easeOutInElastic",Equations.easeOutInElastic);
         param1.push("easeOutInExpo",Equations.easeOutInExpo);
         param1.push("easeOutInQuad",Equations.easeOutInQuad);
         param1.push("easeOutInQuart",Equations.easeOutInQuart);
         param1.push("easeOutInQuint",Equations.easeOutInQuint);
         param1.push("easeOutInSine",Equations.easeOutInSine);
      }
      
      public static function getEffectByName(param1:String) : Function
      {
         var _loc2_:UtilHashArray = new UtilHashArray();
         insertEffects(_loc2_);
         if(_loc2_.getValueByKey(param1))
         {
            return _loc2_.getValueByKey(param1);
         }
         return Equations.easeOutBack;
      }
      
      public static function getEffects() : Array
      {
         var _loc1_:UtilHashArray = new UtilHashArray();
         insertEffects(_loc1_);
         return _loc1_.getKeys();
      }
   }
}
