package anifire.command
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.timeline.ElementInfo;
   import anifire.util.UtilUnitConvert;
   
   public class AddSoundCommand extends SuperCommand
   {
       
      
      private var _snd:AnimeSound;
      
      private var _redoInfo:ElementInfo;
      
      private var _undoInfo:ElementInfo;
      
      private var _id:String;
      
      public function AddSoundCommand(param1:AnimeSound)
      {
         super();
         this._snd = param1;
         this._id = this._snd.getID();
         this._undoInfo = Console.getConsole().timeline.getSoundInfoById(this._id);
         _type = "AddSoundCommand";
      }
      
      override public function undo() : void
      {
         this._redoInfo = Console.getConsole().timeline.getSoundInfoById(this._id);
         Console.getConsole().removeSound(this._snd.getID());
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function redo() : void
      {
         Console.getConsole().addSound(this._snd,UtilUnitConvert.frameToPixel(this._snd.startFrame),UtilUnitConvert.trackToPixel(this._snd.trackNum));
         Console.getConsole().timeline.setSoundInfoById(this._id,this._redoInfo.startPixel,this._redoInfo.totalPixel,null,this._redoInfo.y);
         var _loc1_:AnimeSound = Console.getConsole().sounds.getValueByKey(this._id) as AnimeSound;
         _loc1_.startFrame = UtilUnitConvert.pixelToFrame(this._redoInfo.startPixel);
         _loc1_.endFrame = UtilUnitConvert.pixelToFrame(this._redoInfo.startPixel + this._redoInfo.totalPixel);
         _loc1_.trackNum = UtilUnitConvert.pixelToTrack(this._redoInfo.y);
      }
   }
}
