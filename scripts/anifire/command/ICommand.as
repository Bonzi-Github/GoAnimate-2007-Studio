package anifire.command
{
   public interface ICommand
   {
       
      
      function toString() : String;
      
      function undo() : void;
      
      function execute() : void;
      
      function redo() : void;
   }
}
