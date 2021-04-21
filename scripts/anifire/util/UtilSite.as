package anifire.util
{
   public class UtilSite
   {
      
      private static var _id:Number = -1;
      
      public static const YOUTUBE:Number = 4;
      
      public static const CN:Number = 1;
      
      public static const DOMO:Number = 2;
      
      public static const SCHOOL:Number = 3;
      
      public static const GOANIMATE:Number = 0;
       
      
      public function UtilSite()
      {
         super();
      }
      
      public static function get siteId() : uint
      {
         if(_id == -1)
         {
            if(String(Util.getFlashVar().getValueByKey("apiserver")).search("youtube") > 0)
            {
               _id = YOUTUBE;
            }
            else
            {
               switch(Util.getFlashVar().getValueByKey("siteId"))
               {
                  case "8":
                     _id = CN;
                     break;
                  case "7":
                     _id = DOMO;
                     break;
                  case "11":
                  case "school":
                     _id = SCHOOL;
                     break;
                  default:
                     _id = GOANIMATE;
               }
            }
         }
         return _id;
      }
   }
}
