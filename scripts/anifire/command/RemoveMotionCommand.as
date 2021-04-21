package anifire.command
{
   public class RemoveMotionCommand extends SuperCommand
   {
       
      
      public function RemoveMotionCommand()
      {
         super();
         _type = "RemoveMotionCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
