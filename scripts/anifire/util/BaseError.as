package anifire.util
{
   public class BaseError extends Error
   {
       
      
      private var data:Object;
      
      public function BaseError(param1:String = "", param2:int = 0)
      {
         this.data = {};
         super(param1,param2);
      }
      
      public function set userData(param1:Object) : void
      {
         this.data = param1;
      }
      
      public function get userData() : Object
      {
         return this.data;
      }
   }
}
