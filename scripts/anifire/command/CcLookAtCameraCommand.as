package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Character;
   import anifire.core.Console;
   
   public class CcLookAtCameraCommand extends SuperCommand
   {
       
      
      private var _redoState:Boolean = false;
      
      private var _id:String = null;
      
      private var _undoState:Boolean = false;
      
      public function CcLookAtCameraCommand(param1:String, param2:Boolean)
      {
         super();
         this._id = param1;
         this._undoState = param2;
         _type = "CcLookAtCameraCommand";
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = Asset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null && _loc2_ is Character)
         {
            (_loc2_ as Character).lookAtCamera = this._redoState;
         }
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:Asset = Asset(_loc1_.getAssetById(this._id));
         var _loc3_:Boolean = false;
         if(_loc2_ != null && _loc2_ is Character)
         {
            _loc3_ = (_loc2_ as Character).lookAtCamera;
            (_loc2_ as Character).lookAtCamera = this._undoState;
            this._redoState = _loc3_;
         }
      }
   }
}
