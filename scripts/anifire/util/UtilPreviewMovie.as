package anifire.util
{
   import flash.utils.ByteArray;
   import mx.utils.Base64Decoder;
   import mx.utils.Base64Encoder;
   
   public class UtilPreviewMovie
   {
      
      private static const ITEM_TYPE_ARRAY:String = "2";
      
      private static const SPLIT_LENGTH:int = 300;
      
      private static const ITEM_TYPE_NULL:String = "0";
      
      private static const ITEM_TYPE_HASHARRAY:String = "3";
      
      private static const ITEM_TYPE_OBJECT:String = "4";
      
      private static const ITEM_TYPE_BYTE_ARRAY:String = "1";
      
      private static const ITEM_TYPE_XML:String = "5";
      
      private static const DELIMITER:String = "DELIMITERoooooooooDELIMITER\n";
       
      
      public function UtilPreviewMovie()
      {
         super();
      }
      
      public static function combineStr(param1:String) : String
      {
         return param1.replace(new RegExp(DELIMITER,"g"),"");
      }
      
      public static function deserializeSingleImageData(param1:XML) : Object
      {
         var _loc3_:XML = null;
         var _loc4_:Base64Decoder = null;
         var _loc5_:Array = null;
         var _loc6_:UtilHashArray = null;
         var _loc7_:Object = null;
         var _loc2_:String = param1.@type;
         if(_loc2_ == ITEM_TYPE_BYTE_ARRAY)
         {
            (_loc4_ = new Base64Decoder()).reset();
            _loc4_.decode(xmlUnescape(param1.toString()));
            return _loc4_.toByteArray();
         }
         if(_loc2_ == ITEM_TYPE_ARRAY)
         {
            _loc5_ = new Array();
            for each(_loc3_ in param1.child("item"))
            {
               _loc5_.push(deserializeSingleImageData(_loc3_));
            }
            return _loc5_;
         }
         if(_loc2_ == ITEM_TYPE_HASHARRAY)
         {
            _loc6_ = new UtilHashArray();
            for each(_loc3_ in param1.child("item"))
            {
               _loc6_.push(xmlUnescape(_loc3_.@id),deserializeSingleImageData(_loc3_));
            }
            return _loc6_;
         }
         if(_loc2_ == ITEM_TYPE_XML)
         {
            return new XML(xmlUnescape(param1.toString()));
         }
         if(_loc2_ == ITEM_TYPE_OBJECT)
         {
            _loc7_ = new Object();
            for each(_loc3_ in param1.child("item"))
            {
               _loc7_[xmlUnescape(_loc3_.@id)] = deserializeSingleImageData(_loc3_);
            }
            return _loc7_;
         }
         return null;
      }
      
      private static function xmlUnescape(param1:String) : String
      {
         return unescape(param1);
      }
      
      public static function deserializePreviewMovieData(param1:String, param2:Array, param3:UtilHashArray, param4:UtilHashArray) : void
      {
         var _loc9_:ByteArray = null;
         var _loc10_:XML = null;
         var _loc11_:XMLList = null;
         var _loc12_:XML = null;
         var _loc5_:XML;
         var _loc6_:String = (_loc5_ = new XML(param1)).child("filmxml")[0].toString();
         var _loc7_:XML = new XML(xmlUnescape(_loc6_));
         param2.push(_loc7_);
         var _loc8_:XMLList = _loc5_.child("imagedata") as XMLList;
         for each(_loc10_ in _loc8_.child("item"))
         {
            param3.push(xmlUnescape(_loc10_.attribute("id")[0].toString()),deserializeSingleImageData(_loc10_));
         }
         _loc11_ = _loc5_.child("themexml");
         for each(_loc12_ in _loc11_.child("item"))
         {
            param4.push(xmlUnescape(_loc12_.attribute("id")[0]),new XML(xmlUnescape(_loc12_.toString())));
         }
      }
      
      public static function splitStr(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = _loc2_ + param1.substr(_loc3_,SPLIT_LENGTH);
            _loc2_ = _loc2_ + DELIMITER;
            _loc3_ = _loc3_ + SPLIT_LENGTH;
         }
         return _loc2_;
      }
      
      public static function serializePreviewMovieData(param1:XML, param2:UtilHashArray, param3:UtilHashArray) : String
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:XML = null;
         var _loc7_:String = null;
         var _loc8_:Base64Encoder = new Base64Encoder();
         var _loc9_:* = "<filmxml>" + xmlEscape(param1.toXMLString()) + "</filmxml>";
         var _loc10_:* = "<imagedata>";
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc7_ = param2.getKey(_loc4_);
            _loc5_ = param2.getValueByIndex(_loc4_);
            _loc10_ = _loc10_ + serializeSingleImageData(_loc7_,_loc5_);
            _loc4_++;
         }
         _loc10_ = _loc10_ + "</imagedata>";
         var _loc11_:* = "<themexml>";
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            _loc7_ = param3.getKey(_loc4_);
            if((_loc6_ = param3.getValueByIndex(_loc4_) as XML) != null)
            {
               _loc11_ = _loc11_ + "<item id=\"" + xmlEscape(_loc7_) + "\">" + xmlEscape(_loc6_.toXMLString()) + "</item>";
            }
            _loc4_++;
         }
         _loc11_ = _loc11_ + "</themexml>";
         return "<?xml version=\"1.0\" encoding=\"utf-8\"?><data>" + _loc9_ + _loc10_ + _loc11_ + "</data>";
      }
      
      private static function xmlEscape(param1:String) : String
      {
         return escape(param1);
      }
      
      public static function serializeSingleImageData(param1:String, param2:Object) : String
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:ByteArray = null;
         var _loc7_:Base64Encoder = null;
         var _loc8_:Array = null;
         var _loc9_:UtilHashArray = null;
         var _loc10_:XML = null;
         var _loc11_:* = null;
         var _loc3_:* = "";
         if(param2 == null)
         {
            _loc3_ = _loc3_ + "<item type=\"" + ITEM_TYPE_NULL + "\" id=\"" + xmlEscape(param1) + "\" />";
         }
         else if(param2 is ByteArray)
         {
            _loc6_ = param2 as ByteArray;
            (_loc7_ = new Base64Encoder()).reset();
            _loc7_.encodeBytes(_loc6_);
            _loc3_ = _loc3_ + "<item type=\"" + ITEM_TYPE_BYTE_ARRAY + "\" id=\"" + xmlEscape(param1) + "\">" + xmlEscape(_loc7_.toString()) + "</item>";
         }
         else if(param2 is Array)
         {
            _loc8_ = param2 as Array;
            _loc3_ = _loc3_ + "<item type=\"" + ITEM_TYPE_ARRAY + "\" id=\"" + xmlEscape(param1) + "\">";
            _loc5_ = 0;
            while(_loc5_ < _loc8_.length)
            {
               _loc4_ = _loc8_[_loc5_];
               _loc3_ = _loc3_ + serializeSingleImageData("",_loc4_);
               _loc5_++;
            }
            _loc3_ = _loc3_ + "</item>";
         }
         else if(param2 is UtilHashArray)
         {
            _loc9_ = param2 as UtilHashArray;
            _loc3_ = _loc3_ + "<item type=\"" + ITEM_TYPE_HASHARRAY + "\" id=\"" + xmlEscape(param1) + "\">";
            _loc5_ = 0;
            while(_loc5_ < _loc9_.length)
            {
               _loc4_ = _loc9_.getValueByIndex(_loc5_);
               _loc3_ = _loc3_ + serializeSingleImageData(_loc9_.getKey(_loc5_),_loc4_);
               _loc5_++;
            }
            _loc3_ = _loc3_ + "</item>";
         }
         else if(param2 is XML)
         {
            _loc10_ = param2 as XML;
            _loc3_ = _loc3_ + "<item type=\"" + ITEM_TYPE_XML + "\" id=\"" + xmlEscape(param1) + "\">" + xmlEscape(_loc10_.toXMLString()) + "</item>";
         }
         else if(param2 is Object)
         {
            _loc3_ = _loc3_ + "<item type=\"" + ITEM_TYPE_OBJECT + "\" id=\"" + xmlEscape(param1) + "\">";
            for(_loc11_ in param2)
            {
               _loc3_ = _loc3_ + serializeSingleImageData(_loc11_,param2[_loc11_]);
            }
            _loc3_ = _loc3_ + "</item>";
         }
         return _loc3_;
      }
   }
}
