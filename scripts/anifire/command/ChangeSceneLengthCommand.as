package anifire.command
{
   import anifire.core.Console;
   import anifire.timeline.ElementInfo;
   
   public class ChangeSceneLengthCommand extends SuperCommand
   {
       
      
      private var _redoLength:Number;
      
      private var _sceneIndex:int;
      
      private var _undoLength:Number;
      
      private var _redoSoundInfos:Array;
      
      private var _undoSoundInfos:Array;
      
      public function ChangeSceneLengthCommand(param1:int, param2:Number, param3:Array)
      {
         super();
         this._sceneIndex = param1;
         this._undoLength = param2;
         this._undoSoundInfos = param3;
         _type = "ChangeSceneLengthCommand";
      }
      
      override public function undo() : void
      {
         var _loc1_:ElementInfo = Console.getConsole().timeline.getSceneInfoByIndex(this._sceneIndex);
         this._redoLength = _loc1_.totalPixel;
         var _loc2_:Array = Console.getConsole().timeline.getAllSoundInfo();
         this._redoSoundInfos = _loc2_;
         Console.getConsole().timeline.sceneLengthController.doChangeSceneLength(this._undoLength,this._sceneIndex);
         Console.getConsole().timeline.setAllSoundInfo(this._undoSoundInfos);
         Console.getConsole().setCurrentSceneVisible();
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function redo() : void
      {
         Console.getConsole().timeline.sceneLengthController.doChangeSceneLength(this._redoLength,this._sceneIndex);
         Console.getConsole().timeline.setAllSoundInfo(this._redoSoundInfos);
         Console.getConsole().setCurrentSceneVisible();
      }
   }
}
