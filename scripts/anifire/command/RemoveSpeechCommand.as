package anifire.command
{
   import anifire.core.AnimeSound;
   import anifire.core.AssetLinkage;
   import anifire.core.Console;
   
   public class RemoveSpeechCommand extends SuperCommand
   {
       
      
      private var _charId:String;
      
      private var _sound:AnimeSound;
      
      public function RemoveSpeechCommand(param1:AnimeSound = null, param2:String = "")
      {
         super();
         this._charId = param2;
         this._sound = param1;
         _type = "RemoveSpeechCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AssetLinkage = null;
         super.undo();
         if(this._sound != null)
         {
            _loc1_ = new AssetLinkage();
            _loc1_.addLinkage(this._sound.getID());
            _loc1_.addLinkage(this._charId);
            Console.getConsole().linkageController.addLinkage(_loc1_);
            Console.getConsole().speechManager.addSoundBySound(this._sound);
            Console.getConsole().currentScene.refreshEffectTray();
         }
      }
      
      override public function execute() : void
      {
         backupSceneData();
         super.execute();
      }
      
      override public function redo() : void
      {
         super.redo();
         if(this._sound != null)
         {
            Console.getConsole().linkageController.deleteLinkageById(this._charId);
            Console.getConsole().speechManager.removeSoundById(this._sound.getID());
            Console.getConsole().currentScene.refreshEffectTray();
         }
      }
   }
}
