package anifire.command
{
   public class ChangeActionCommand extends SuperCommand
   {
       
      
      public function ChangeActionCommand()
      {
         super();
         _type = "ChangeActionCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
