package anifire.util
{
   import flash.utils.ByteArray;
   
   public class UtilFileFormat
   {
       
      
      public function UtilFileFormat()
      {
         super();
      }
      
      public static function checkByteArrayMatchItsExt(param1:String, param2:ByteArray) : Boolean
      {
         var _loc4_:String = null;
         var _loc3_:String = String(param1.substring(param1.lastIndexOf(".") + 1)).toLowerCase();
         param2.position = 0;
         if(matchType(_loc3_,["jpg","jpeg"]))
         {
            if((_loc4_ = param2.readUTFBytes(3)) == "ÿØÿ")
            {
               return true;
            }
         }
         else if(matchType(_loc3_,["gif"]))
         {
            if((_loc4_ = param2.readUTFBytes(4)) == "GIF8")
            {
               return true;
            }
         }
         else if(matchType(_loc3_,["png"]))
         {
            if((_loc4_ = param2.readUTFBytes(8)) == "PNG\r\n\x1a\n")
            {
               return true;
            }
         }
         else if(matchType(_loc3_,["bmp"]))
         {
            if((_loc4_ = param2.readUTFBytes(2)) == "BM")
            {
               return true;
            }
         }
         else if(matchType(_loc3_,["swf"]))
         {
            if((_loc4_ = param2.readUTFBytes(3)) == "CWS" || _loc4_ == "FWS")
            {
               return true;
            }
         }
         else if(matchType(_loc3_,["flv"]))
         {
            return true;
         }
         return false;
      }
      
      public static function matchType(param1:String, param2:Array) : Boolean
      {
         if(param2.indexOf(param1) > -1)
         {
            return true;
         }
         return false;
      }
   }
}
