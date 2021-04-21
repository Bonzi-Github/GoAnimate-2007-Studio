package anifire.components.studio.cn
{
   import anifire.components.studio.ILock;
   
   public class SchoolSpecialLock implements ILock
   {
      
      public static const LOCK_TYPE:String = "cn_school_special";
       
      
      public function SchoolSpecialLock()
      {
         super();
      }
      
      public function get type() : String
      {
         return SchoolSpecialLock.LOCK_TYPE;
      }
      
      public function get hint() : String
      {
         return "Special item unlocked by promotional code.";
      }
   }
}
