package anifire.util
{
   public class MovieBodyError extends BaseError
   {
       
      
      private var _body:String;
      
      public function MovieBodyError(param1:String = "", param2:String = "", param3:int = 0)
      {
         super(param1,param3);
         this._body = param2;
      }
      
      public function get body() : String
      {
         return this._body;
      }
   }
}
