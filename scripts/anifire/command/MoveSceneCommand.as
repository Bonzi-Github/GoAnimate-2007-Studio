package anifire.command
{
   import anifire.core.Console;
   
   public class MoveSceneCommand extends SuperCommand
   {
       
      
      private var _destIndex:Number;
      
      private var _sourceIndex:Number;
      
      public function MoveSceneCommand(param1:Number, param2:Number)
      {
         super();
         _type = "MoveSceneCommand";
         this._sourceIndex = param1;
         this._destIndex = param2;
      }
      
      override public function undo() : void
      {
         if(this._destIndex > this._sourceIndex)
         {
            Console.getConsole().doMoveScene(this._destIndex - 1,this._sourceIndex);
         }
         else
         {
            Console.getConsole().doMoveScene(this._destIndex,this._sourceIndex + 1);
         }
      }
      
      override public function redo() : void
      {
         Console.getConsole().doMoveScene(this._sourceIndex,this._destIndex);
      }
   }
}
