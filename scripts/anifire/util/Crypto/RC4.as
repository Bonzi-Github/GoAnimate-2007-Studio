package anifire.util.Crypto
{
   import flash.utils.ByteArray;
   
   public class RC4
   {
       
      
      private var i:int = 0;
      
      private var j:int = 0;
      
      private const psize:uint = 256;
      
      private var S:ByteArray;
      
      public function RC4(param1:ByteArray = null)
      {
         super();
         this.S = new ByteArray();
         if(param1)
         {
            this.init(param1);
         }
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            var _loc3_:* = _loc2_++;
            param1[_loc3_] = param1[_loc3_] ^ this.next();
         }
      }
      
      public function next() : uint
      {
         var _loc1_:int = 0;
         this.i = this.i + 1 & 255;
         this.j = this.j + this.S[this.i] & 255;
         _loc1_ = this.S[this.i];
         this.S[this.i] = this.S[this.j];
         this.S[this.j] = _loc1_;
         return this.S[_loc1_ + this.S[this.i] & 255];
      }
      
      public function toString() : String
      {
         return "rc4";
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         this.encrypt(param1);
         param1.position = 0;
      }
      
      public function init(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 256)
         {
            this.S[_loc2_] = _loc2_;
            _loc2_++;
         }
         _loc3_ = 0;
         _loc2_ = 0;
         while(_loc2_ < 256)
         {
            _loc3_ = _loc3_ + this.S[_loc2_] + param1[_loc2_ % param1.length] & 255;
            _loc4_ = this.S[_loc2_];
            this.S[_loc2_] = this.S[_loc3_];
            this.S[_loc3_] = _loc4_;
            _loc2_++;
         }
         this.i = 0;
         this.j = 0;
      }
      
      public function getBlockSize() : uint
      {
         return 1;
      }
      
      public function getPoolSize() : uint
      {
         return this.psize;
      }
   }
}
