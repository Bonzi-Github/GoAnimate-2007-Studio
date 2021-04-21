package anifire.core
{
   public class Group
   {
       
      
      private var _id:String;
      
      private var _name:String;
      
      public function Group(param1:String = "0", param2:String = "none")
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get name() : String
      {
         return this._name;
      }
   }
}
