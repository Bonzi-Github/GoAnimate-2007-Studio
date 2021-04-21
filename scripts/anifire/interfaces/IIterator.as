package anifire.interfaces
{
   public interface IIterator
   {
       
      
      function get next() : Object;
      
      function get hasNext() : Boolean;
      
      function reset() : void;
   }
}
