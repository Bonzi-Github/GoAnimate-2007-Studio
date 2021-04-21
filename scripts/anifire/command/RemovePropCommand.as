package anifire.command
{
   public class RemovePropCommand extends SuperCommand
   {
       
      
      public function RemovePropCommand()
      {
         super();
         _type = "RemovePropCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
