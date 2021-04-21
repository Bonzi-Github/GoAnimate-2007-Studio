package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.BubbleAsset;
   import anifire.core.Console;
   
   public class ChangeBubbleCommand extends SuperCommand
   {
       
      
      private var _redoXML:XML;
      
      private var _id:String;
      
      private var _undoXML:XML;
      
      public function ChangeBubbleCommand(param1:String, param2:XML)
      {
         super();
         this._id = param1;
         this._undoXML = param2;
         _type = "ChangeBubbleCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:BubbleAsset = BubbleAsset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            this._redoXML = _loc2_.bubble.serialize();
            _loc2_.bubble.deSerialize(this._undoXML);
         }
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc2_:BubbleAsset = BubbleAsset(_loc1_.getAssetById(this._id));
         if(_loc2_ != null)
         {
            if(Console.getConsole().currentSceneId != sceneId)
            {
               Console.getConsole().setCurrentSceneById(sceneId);
            }
            Console.getConsole().setCurrentSceneVisible();
            _loc2_.bubble.deSerialize(this._redoXML);
         }
      }
   }
}
