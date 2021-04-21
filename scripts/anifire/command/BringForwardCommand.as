package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Console;
   
   public class BringForwardCommand extends SuperCommand
   {
       
      
      private var _id:String;
      
      public function BringForwardCommand(param1:String)
      {
         super();
         this._id = param1;
         _type = "BringForwardCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = _loc1_.getAssetById(this._id);
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            _loc1_.sendBackward(_loc2_);
         }
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = _loc1_.getAssetById(this._id);
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            _loc1_.bringForward(_loc2_);
         }
      }
   }
}
