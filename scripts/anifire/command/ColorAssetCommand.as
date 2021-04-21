package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Asset;
   import anifire.core.Console;
   import anifire.util.UtilHashArray;
   
   public class ColorAssetCommand extends SuperCommand
   {
       
      
      private var _orginalRedoPart:String;
      
      private var _orginalUndoColor:uint;
      
      private var _orginalRedoColor:uint;
      
      private var _orginalUndoPart:String;
      
      private var _orginalUndoCustomColor:UtilHashArray;
      
      private var _id:String;
      
      private var _orginalRedoCustomColor:UtilHashArray;
      
      public function ColorAssetCommand(param1:String, param2:String = "")
      {
         super();
         this._id = param1;
         var _loc3_:AnimeScene = Console.getConsole().getScenebyId(sceneId);
         var _loc4_:Asset = _loc3_.getAssetById(this._id);
         this._orginalUndoPart = param2;
         if(param2 != "")
         {
            if(_loc4_.customColor.containsKey(this._orginalUndoPart))
            {
               this._orginalUndoColor = _loc4_.customColor.getValueByKey(this._orginalUndoPart);
            }
            else
            {
               this._orginalUndoColor = uint.MAX_VALUE;
            }
         }
         else
         {
            this._orginalUndoCustomColor = _loc4_.customColor.clone();
         }
         _type = "ColorAssetCommand";
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
            this._orginalRedoPart = this._orginalUndoPart;
            if(this._orginalUndoPart != "")
            {
               if(_loc2_.customColor.containsKey(this._orginalRedoPart))
               {
                  this._orginalRedoColor = _loc2_.customColor.getValueByKey(this._orginalRedoPart);
               }
               else
               {
                  this._orginalRedoColor = uint.MAX_VALUE;
               }
               _loc2_.doChangeColor(this._orginalUndoPart,this._orginalUndoColor);
            }
            else
            {
               this._orginalRedoCustomColor = _loc2_.customColor.clone();
               _loc2_.customColor = this._orginalUndoCustomColor.clone();
               _loc2_.updateColor();
            }
            Console.getConsole().changed = true;
            Console.getConsole().pptPanel.refresh();
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
            if(this._orginalRedoPart != "")
            {
               _loc2_.doChangeColor(this._orginalRedoPart,this._orginalRedoColor);
            }
            else
            {
               _loc2_.customColor = this._orginalRedoCustomColor.clone();
               _loc2_.updateColor();
            }
            Console.getConsole().changed = true;
            Console.getConsole().pptPanel.refresh();
         }
      }
      
      override public function execute() : void
      {
         super.execute();
      }
   }
}
