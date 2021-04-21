package anifire.command
{
   public class MoveAssetGroupCommand extends SuperCommand
   {
       
      
      public function MoveAssetGroupCommand()
      {
         super();
         backupSceneData();
         _type = "MoveAssetGroupCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
   }
}
