package anifire.util
{
   public class UtilString
   {
       
      
      public function UtilString()
      {
         super();
      }
      
      public static function firstLetterToUpperCase(param1:String) : String
      {
         if(param1 && param1.length > 0)
         {
            if(param1.length == 1)
            {
               return param1.charAt().toLocaleUpperCase();
            }
            return param1.charAt().toLocaleUpperCase() + param1.substr(1).toLocaleLowerCase();
         }
         return "";
      }
      
      public static function rightPad(param1:String, param2:String, param3:int) : String
      {
         var _loc4_:String = param1;
         while(_loc4_.length < param3)
         {
            _loc4_ = _loc4_ + param2;
         }
         return _loc4_;
      }
      
      public static function trimFront(param1:String, param2:String) : String
      {
         param2 = stringToCharacter(param2);
         if(param1.charAt(0) == param2)
         {
            param1 = trimFront(param1.substring(1),param2);
         }
         return param1;
      }
      
      public static function trim(param1:String, param2:String) : String
      {
         return trimBack(trimFront(param1,param2),param2);
      }
      
      public static function leftPad(param1:String, param2:String, param3:int) : String
      {
         var _loc4_:String = param1;
         while(_loc4_.length < param3)
         {
            _loc4_ = param2 + _loc4_;
         }
         return _loc4_;
      }
      
      public static function mb_countWord(param1:String) : Number
      {
         var _loc2_:String = escape(param1);
         var _loc3_:RegExp = /%u..../g;
         var _loc4_:Object;
         return (_loc4_ = _loc2_.match(_loc3_)).length;
      }
      
      public static function trimBack(param1:String, param2:String) : String
      {
         param2 = stringToCharacter(param2);
         if(param1.charAt(param1.length - 1) == param2)
         {
            param1 = trimBack(param1.substring(0,param1.length - 1),param2);
         }
         return param1;
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function convertSecToTimeString(param1:Number) : String
      {
         var _loc2_:Number = int(Math.floor(param1 % 60));
         var _loc3_:Number = int(Math.floor(param1 / 60));
         var _loc4_:String = UtilString.leftPad(_loc2_.toString(),"0",2);
         var _loc5_:String;
         return (_loc5_ = UtilString.leftPad(_loc3_.toString(),"0",2)) + ":" + _loc4_;
      }
      
      public static function countWord(param1:String) : Number
      {
         var _loc2_:RegExp = /\w+/g;
         var _loc3_:Object = param1.match(_loc2_);
         return _loc3_.length;
      }
      
      public static function stringToCharacter(param1:String) : String
      {
         if(param1.length == 1)
         {
            return param1;
         }
         return param1.slice(0,1);
      }
      
      public static function hasSWFextension(param1:String) : Boolean
      {
         var _loc2_:String = param1.substr(param1.length - 4);
         return _loc2_ == ".swf";
      }
   }
}
