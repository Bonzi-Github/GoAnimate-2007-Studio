package anifire.command
{
   public class RemoveAssetsCommand extends SuperCommand
   {
       
      
      public function RemoveAssetsCommand()
      {
         super();
         _type = "RemoveAssetsCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
