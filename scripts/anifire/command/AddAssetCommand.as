package anifire.command
{
   public class AddAssetCommand extends SuperCommand
   {
       
      
      public function AddAssetCommand()
      {
         super();
         _type = "AddAssetCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
