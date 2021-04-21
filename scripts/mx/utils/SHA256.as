package mx.utils
{
   import flash.utils.ByteArray;
   
   public class SHA256
   {
      
      public static const TYPE_ID:String = "SHA-256";
      
      private static var k:Array = [1116352408,1899447441,3049323471,3921009573,961987163,1508970993,2453635748,2870763221,3624381080,310598401,607225278,1426881987,1925078388,2162078206,2614888103,3248222580,3835390401,4022224774,264347078,604807628,770255983,1249150122,1555081692,1996064986,2554220882,2821834349,2952996808,3210313671,3336571891,3584528711,113926993,338241895,666307205,773529912,1294757372,1396182291,1695183700,1986661051,2177026350,2456956037,2730485921,2820302411,3259730800,3345764771,3516065817,3600352804,4094571909,275423344,430227734,506948616,659060556,883997877,958139571,1322822218,1537002063,1747873779,1955562222,2024104815,2227730452,2361852424,2428436474,2756734187,3204031479,3329325298];
       
      
      public function SHA256()
      {
         super();
      }
      
      public static function computeDigest(param1:ByteArray) : String
      {
         var _loc6_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc28_:uint = 0;
         var _loc29_:int = 0;
         var _loc30_:int = 0;
         var _loc31_:uint = 0;
         var _loc32_:uint = 0;
         var _loc33_:int = 0;
         var _loc34_:int = 0;
         var _loc35_:int = 0;
         var _loc2_:int = param1.length % 64;
         _loc2_ = 64 - _loc2_;
         if(_loc2_ < 1 + 8)
         {
            _loc2_ = _loc2_ + 64;
         }
         var _loc3_:Array = new Array(_loc2_);
         var _loc4_:int = (param1.length + _loc2_) / 64;
         var _loc5_:uint = param1.length * 8;
         _loc3_[0] = 128;
         _loc6_ = 1;
         while(_loc6_ < _loc2_ - 8)
         {
            _loc3_[_loc6_] = 0;
            _loc6_++;
         }
         var _loc7_:int = _loc3_.length - 1;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc3_[_loc7_ - _loc6_] = _loc5_ >> (_loc6_ << 3) & 255;
            _loc6_++;
         }
         var _loc8_:int = 1779033703;
         var _loc9_:int = 3144134277;
         var _loc10_:int = 1013904242;
         var _loc11_:int = 2773480762;
         var _loc12_:int = 1359893119;
         var _loc13_:int = 2600822924;
         var _loc14_:int = 528734635;
         var _loc15_:int = 1541459225;
         var _loc24_:ByteArray = new ByteArray();
         var _loc25_:Array = new Array(64);
         var _loc26_:uint = 0;
         var _loc27_:uint = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            getMessageBlock(param1,_loc24_);
            if(_loc6_ == _loc4_ - 2 && _loc3_.length > 64)
            {
               _loc26_ = 64 - _loc3_.length % 64;
               _loc27_ = 64 - _loc26_;
               _loc28_ = 0;
               while(_loc28_ < _loc27_)
               {
                  _loc24_[_loc28_ + _loc26_] = _loc3_[_loc28_];
                  _loc28_++;
               }
            }
            else if(_loc6_ == _loc4_ - 1)
            {
               _loc35_ = _loc27_;
               if(_loc3_.length > 64)
               {
                  _loc26_ = 0;
                  _loc27_ = 64;
               }
               else
               {
                  _loc26_ = 64 - _loc3_.length;
                  _loc27_ = _loc3_.length;
               }
               _loc28_ = 0;
               while(_loc28_ < _loc27_)
               {
                  _loc24_[_loc28_ + _loc26_] = _loc3_[_loc28_ + _loc35_];
                  _loc28_++;
               }
            }
            _loc31_ = 0;
            while(_loc31_ < 64)
            {
               if(_loc31_ < 16)
               {
                  _loc32_ = _loc31_ << 2;
                  _loc25_[_loc31_] = int(_loc24_[_loc32_] << 24 | _loc24_[_loc32_ + 1] << 16 | _loc24_[_loc32_ + 2] << 8 | _loc24_[_loc32_ + 3]);
               }
               else
               {
                  _loc33_ = _loc25_[_loc31_ - 2];
                  _loc34_ = _loc25_[_loc31_ - 15];
                  _loc25_[_loc31_] = int(int((_loc33_ >>> 17 | _loc33_ << 15) ^ (_loc33_ >>> 19 | _loc33_ << 13) ^ _loc33_ >>> 10) + int(_loc25_[_loc31_ - 7]) + int((_loc34_ >>> 7 | _loc34_ << 25) ^ (_loc34_ >>> 18 | _loc34_ << 14) ^ _loc34_ >>> 3) + int(_loc25_[_loc31_ - 16]));
               }
               _loc31_++;
            }
            _loc16_ = _loc8_;
            _loc17_ = _loc9_;
            _loc18_ = _loc10_;
            _loc19_ = _loc11_;
            _loc20_ = _loc12_;
            _loc21_ = _loc13_;
            _loc22_ = _loc14_;
            _loc23_ = _loc15_;
            _loc31_ = 0;
            while(_loc31_ < 64)
            {
               _loc29_ = _loc23_ + int((_loc20_ >>> 6 | _loc20_ << 26) ^ (_loc20_ >>> 11 | _loc20_ << 21) ^ (_loc20_ >>> 25 | _loc20_ << 7)) + int(_loc20_ & _loc21_ ^ ~_loc20_ & _loc22_) + int(k[_loc31_]) + int(_loc25_[_loc31_]);
               _loc30_ = int((_loc16_ >>> 2 | _loc16_ << 30) ^ (_loc16_ >>> 13 | _loc16_ << 19) ^ (_loc16_ >>> 22 | _loc16_ << 10)) + int(_loc16_ & _loc17_ ^ _loc16_ & _loc18_ ^ _loc17_ & _loc18_);
               _loc23_ = _loc22_;
               _loc22_ = _loc21_;
               _loc21_ = _loc20_;
               _loc20_ = _loc19_ + _loc29_;
               _loc19_ = _loc18_;
               _loc18_ = _loc17_;
               _loc17_ = _loc16_;
               _loc16_ = _loc29_ + _loc30_;
               _loc31_++;
            }
            _loc8_ = _loc8_ + _loc16_;
            _loc9_ = _loc9_ + _loc17_;
            _loc10_ = _loc10_ + _loc18_;
            _loc11_ = _loc11_ + _loc19_;
            _loc12_ = _loc12_ + _loc20_;
            _loc13_ = _loc13_ + _loc21_;
            _loc14_ = _loc14_ + _loc22_;
            _loc15_ = _loc15_ + _loc23_;
            _loc6_++;
         }
         return toHex(_loc8_) + toHex(_loc9_) + toHex(_loc10_) + toHex(_loc11_) + toHex(_loc12_) + toHex(_loc13_) + toHex(_loc14_) + toHex(_loc15_);
      }
      
      private static function getMessageBlock(param1:ByteArray, param2:ByteArray) : void
      {
         param1.readBytes(param2,0,Math.min(param1.bytesAvailable,64));
      }
      
      private static function toHex(param1:uint) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = param1.toString(16);
         if(_loc2_.length < 8)
         {
            _loc3_ = "0";
            _loc4_ = 8 - _loc2_.length;
            _loc5_ = 1;
            while(_loc5_ < _loc4_)
            {
               _loc3_ = _loc3_.concat("0");
               _loc5_++;
            }
            return _loc3_ + _loc2_;
         }
         return _loc2_;
      }
   }
}
