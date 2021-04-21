package anifire.util
{
   public class UtilDict
   {
       
      
      public function UtilDict()
      {
         super();
      }
      
      public static function toDisplay(param1:String, param2:String) : String
      {
         var _loc4_:String = null;
         var _loc3_:String = param2.replace(/\W/g,"_");
         if((_loc4_ = UtilGettext.translateAggregate(param1,param2)) == null)
         {
            trace("*******************:" + _loc3_);
            if(_loc4_ == null)
            {
               return param2;
            }
            return _loc4_;
         }
         return _loc4_;
      }
   }
}
