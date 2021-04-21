package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.Prop;
   
   public class FlipAssetCommand extends SuperCommand
   {
       
      
      private var _redoFlip:String;
      
      private var _undoFlip:String;
      
      private var _id:String;
      
      public function FlipAssetCommand(param1:String, param2:String)
      {
         super();
         this._id = param1;
         this._undoFlip = param2;
         _type = "FlipAssetCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = Asset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            if(_loc2_ is Character)
            {
               this._redoFlip = (_loc2_ as Character).facing;
               (_loc2_ as Character).facing = this._undoFlip;
            }
            else if(_loc2_ is Prop)
            {
               this._redoFlip = (_loc2_ as Prop).facing;
               (_loc2_ as Prop).facing = this._undoFlip;
            }
         }
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = Asset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            if(_loc2_ is Character)
            {
               (_loc2_ as Character).facing = this._redoFlip;
            }
            else if(_loc2_ is Prop)
            {
               (_loc2_ as Prop).facing = this._redoFlip;
            }
         }
      }
   }
}
