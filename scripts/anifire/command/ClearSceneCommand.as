package anifire.command
{
   import anifire.core.AnimeScene;
   import anifire.core.Console;
   
   public class ClearSceneCommand extends SuperCommand
   {
       
      
      private var _numOfTotalScene:int;
      
      private var _redoSoundInfos:Array;
      
      private var _undoXML:XML;
      
      private var _prevSceneId:String = "";
      
      private var _currSceneId:String;
      
      private var _undoSoundInfos:Array;
      
      public function ClearSceneCommand()
      {
         super();
         this._currSceneId = Console.getConsole().currentSceneId;
         _type = "ClearSceneCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:AnimeScene = null;
         _loc1_ = Console.getConsole().getScenebyId(this._currSceneId);
         _loc1_.deSerialize(this._undoXML,true,true,false);
         Console.getConsole().setCurrentSceneById(_loc1_.id);
      }
      
      override public function execute() : void
      {
         this._undoXML = backupSceneData();
         super.execute();
      }
      
      override public function redo() : void
      {
         var _loc1_:AnimeScene = null;
         _loc1_ = Console.getConsole().getScenebyId(this._currSceneId);
         _loc1_.deSerialize(,true);
         Console.getConsole().setCurrentSceneById(_loc1_.id);
      }
   }
}
