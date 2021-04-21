package anifire.util
{
   import mx.managers.CursorManager;
   import mx.managers.CursorManagerPriority;
   
   public class UtilCursor
   {
      
      private static var currentType:Class = null;
       
      
      public function UtilCursor()
      {
         super();
      }
      
      public static function changeCursor(param1:Class, param2:Number = 0, param3:Number = 0) : void
      {
         if(currentType != param1)
         {
            currentType = param1;
            CursorManager.removeCursor(CursorManager.currentCursorID);
            if(param1 != null)
            {
               CursorManager.setCursor(param1,CursorManagerPriority.MEDIUM,param2,param3);
            }
         }
      }
   }
}
