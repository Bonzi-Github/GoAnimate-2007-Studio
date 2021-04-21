package mx.utils
{
   import flash.display.LoaderInfo;
   
   public class LoaderUtil
   {
       
      
      public function LoaderUtil()
      {
         super();
      }
      
      public static function normalizeURL(param1:LoaderInfo) : String
      {
         var _loc2_:String = param1.url;
         var _loc3_:Array = _loc2_.split("/[[DYNAMIC]]/");
         return _loc3_[0];
      }
      
      public static function createAbsoluteURL(param1:String, param2:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:String = param2;
         if(param1 && !(param2.indexOf(":") > -1 || param2.indexOf("/") == 0 || param2.indexOf("\\") == 0))
         {
            _loc4_ = Math.max(param1.lastIndexOf("\\"),param1.lastIndexOf("/"));
            if(param2.indexOf("./") == 0)
            {
               param2 = param2.substring(2);
            }
            else
            {
               while(param2.indexOf("../") == 0)
               {
                  param2 = param2.substring(3);
                  _loc4_ = Math.max(param1.lastIndexOf("\\",_loc4_ - 1),param1.lastIndexOf("/",_loc4_ - 1));
               }
            }
            if(_loc4_ != -1)
            {
               _loc3_ = param1.substr(0,_loc4_ + 1) + param2;
            }
         }
         return _loc3_;
      }
   }
}
