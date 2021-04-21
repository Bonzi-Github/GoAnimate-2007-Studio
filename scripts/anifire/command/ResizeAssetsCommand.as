package anifire.command
{
   public class ResizeAssetsCommand extends SuperCommand
   {
       
      
      public function ResizeAssetsCommand()
      {
         super();
         _type = "ResizeAssetsCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
