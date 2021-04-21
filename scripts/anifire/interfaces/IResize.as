package anifire.interfaces
{
   import anifire.control.Control;
   
   public interface IResize
   {
       
      
      function resizing(param1:Control) : void;
      
      function startResize() : void;
      
      function endResize() : void;
   }
}
