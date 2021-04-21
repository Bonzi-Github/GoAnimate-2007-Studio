package anifire.iterators
{
   import anifire.interfaces.IIterator;
   
   public class ArrayIterator implements IIterator
   {
       
      
      private var _index:uint = 0;
      
      private var _collection:Array;
      
      public function ArrayIterator(param1:Array)
      {
         super();
         this._collection = param1;
         this._index = 0;
      }
      
      public function get next() : Object
      {
         return this._collection[this._index++];
      }
      
      public function get hasNext() : Boolean
      {
         return this._index < this._collection.length;
      }
      
      public function reset() : void
      {
         this._index = 0;
      }
   }
}
