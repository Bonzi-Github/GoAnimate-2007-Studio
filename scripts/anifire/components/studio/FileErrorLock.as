package anifire.components.studio
{
   import anifire.util.UtilDict;
   
   public class FileErrorLock implements ILock
   {
      
      public static const LOCK_TYPE:String = "file_error";
       
      
      public function FileErrorLock()
      {
         super();
      }
      
      public function get type() : String
      {
         return FileErrorLock.LOCK_TYPE;
      }
      
      public function get hint() : String
      {
         return UtilDict.toDisplay("go","Invalid File");
      }
   }
}
