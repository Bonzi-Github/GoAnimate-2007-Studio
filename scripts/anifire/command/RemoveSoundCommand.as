package anifire.command
{
   import anifire.core.AnimeSound;
   import anifire.core.Console;
   import anifire.util.UtilUnitConvert;
   
   public class RemoveSoundCommand extends SuperCommand
   {
       
      
      private var _soundIndex:int;
      
      private var _snd:AnimeSound;
      
      public function RemoveSoundCommand(param1:AnimeSound)
      {
         super();
         this._snd = param1;
         this._soundIndex = Console.getConsole().timeline.getSoundIndexById(param1.getID());
         _type = "RemoveSoundCommand";
      }
      
      override public function execute() : void
      {
         super.execute();
      }
      
      override public function undo() : void
      {
         Console.getConsole().addSound(this._snd,UtilUnitConvert.frameToPixel(this._snd.startFrame),UtilUnitConvert.trackToPixel(this._snd.trackNum),this._soundIndex);
      }
      
      override public function redo() : void
      {
         Console.getConsole().removeSound(this._snd.getID());
      }
   }
}
