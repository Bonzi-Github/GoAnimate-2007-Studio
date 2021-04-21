package anifire.command
{
   public class AddPropCommand extends SuperCommand
   {
       
      
      public function AddPropCommand()
      {
         super();
         _type = "AddPropCommand";
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
   }
}
