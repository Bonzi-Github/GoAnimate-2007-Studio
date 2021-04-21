package anifire.util
{
   public class NestedError extends BaseError
   {
       
      
      private var st:String;
      
      private var err:Error;
      
      public function NestedError(param1:String = "", param2:Error = null, param3:int = 0)
      {
         super(param1,param3);
         this.err = param2;
         this.st = param2.getStackTrace();
      }
      
      public function get error() : Error
      {
         return this.err;
      }
      
      public function get stacktrace() : String
      {
         return this.st;
      }
   }
}
