package anifire.components.studio.cn
{
   import anifire.components.studio.ILock;
   
   public class GameAchievementLock implements ILock
   {
      
      public static const LOCK_TYPE:String = "cn_game_achievement";
       
      
      public function GameAchievementLock()
      {
         super();
      }
      
      public function get type() : String
      {
         return GameAchievementLock.LOCK_TYPE;
      }
      
      public function get hint() : String
      {
         return "You have to complete the related game at Toon Adventure in order to unlock this item.";
      }
   }
}
