package anifire.util
{
   public interface IUtilMap
   {
       
      
      function containsKey(param1:String) : Boolean;
      
      function size() : int;
      
      function containsValue(param1:*) : Boolean;
      
      function isEmpty() : Boolean;
      
      function remove(param1:String) : void;
      
      function getKey(param1:*) : String;
      
      function getValue(param1:String) : *;
      
      function clear() : void;
      
      function put(param1:String, param2:*) : void;
   }
}
