package anifire.command
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.timeline.ElementInfo;
   import anifire.util.UtilUnitConvert;
   
   public class ChangeSoundLengthCommand extends SuperCommand
   {
       
      
      private var _redoInfo:ElementInfo;
      
      private var _undoInfo:ElementInfo;
      
      private var _id:String;
      
      public function ChangeSoundLengthCommand(param1:String, param2:ElementInfo)
      {
         super();
         this._id = param1;
         this._undoInfo = param2;
         _type = "ChangeSoundLengthCommand";
      }
      
      override public function undo() : void
      {
         this._redoInfo = Console.getConsole().timeline.getSoundInfoById(this._id);
         Console.getConsole().timeline.setSoundInfoById(this._id,this._undoInfo.startPixel,this._undoInfo.totalPixel,null,this._undoInfo.y);
         var _loc1_:AnimeSound = Console.getConsole().sounds.getValueByKey(this._id) as AnimeSound;
         _loc1_.startFrame = UtilUnitConvert.pixelToFrame(this._undoInfo.startPixel);
         _loc1_.endFrame = UtilUnitConvert.pixelToFrame(this._undoInfo.startPixel + this._undoInfo.totalPixel);
         _loc1_.trackNum = UtilUnitConvert.pixelToTrack(this._redoInfo.y);
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function redo() : void
      {
         Console.getConsole().timeline.setSoundInfoById(this._id,this._redoInfo.startPixel,this._redoInfo.totalPixel,null,this._redoInfo.y);
         var _loc1_:AnimeSound = Console.getConsole().sounds.getValueByKey(this._id) as AnimeSound;
         _loc1_.startFrame = UtilUnitConvert.pixelToFrame(this._redoInfo.startPixel);
         _loc1_.endFrame = UtilUnitConvert.pixelToFrame(this._redoInfo.startPixel + this._redoInfo.totalPixel);
         _loc1_.trackNum = UtilUnitConvert.pixelToTrack(this._redoInfo.y);
      }
   }
}
