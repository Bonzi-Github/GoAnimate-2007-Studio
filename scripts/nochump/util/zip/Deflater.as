package nochump.util.zip
{
   import flash.utils.ByteArray;
   
   public class Deflater
   {
       
      
      private var compressed:Boolean;
      
      private var totalIn:uint;
      
      private var totalOut:uint;
      
      private var buf:ByteArray;
      
      public function Deflater()
      {
         super();
         reset();
      }
      
      public function getBytesRead() : uint
      {
         return totalIn;
      }
      
      public function setInput(param1:ByteArray) : void
      {
         buf.writeBytes(param1);
         totalIn = buf.length;
      }
      
      public function deflate(param1:ByteArray) : uint
      {
         if(!compressed)
         {
            buf.compress();
            compressed = true;
         }
         param1.writeBytes(buf,2,buf.length - 6);
         totalOut = param1.length;
         return 0;
      }
      
      public function reset() : void
      {
         buf = new ByteArray();
         compressed = false;
         totalOut = totalIn = 0;
      }
      
      public function getBytesWritten() : uint
      {
         return totalOut;
      }
   }
}
