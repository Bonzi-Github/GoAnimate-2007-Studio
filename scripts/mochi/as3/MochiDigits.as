package mochi.as3
{
   public final class MochiDigits
   {
       
      
      private var Sibling:MochiDigits;
      
      private var Fragment:Number;
      
      private var Encoder:Number;
      
      public function MochiDigits(param1:Number = 0, param2:uint = 0)
      {
         super();
         this.Encoder = 0;
         this.setValue(param1,param2);
      }
      
      public function reencode() : void
      {
         var _loc1_:uint = int(2147483647 * Math.random());
         this.Fragment = this.Fragment ^ (_loc1_ ^ this.Encoder);
         this.Encoder = _loc1_;
      }
      
      public function set value(param1:Number) : void
      {
         this.setValue(param1);
      }
      
      public function toString() : String
      {
         var _loc1_:String = String.fromCharCode(this.Fragment ^ this.Encoder);
         if(this.Sibling != null)
         {
            _loc1_ = _loc1_ + this.Sibling.toString();
         }
         return _loc1_;
      }
      
      public function setValue(param1:Number = 0, param2:uint = 0) : void
      {
         var _loc3_:String = param1.toString();
         this.Fragment = _loc3_.charCodeAt(param2++) ^ this.Encoder;
         if(param2 < _loc3_.length)
         {
            this.Sibling = new MochiDigits(param1,param2);
         }
         else
         {
            this.Sibling = null;
         }
         this.reencode();
      }
      
      public function get value() : Number
      {
         return Number(this.toString());
      }
      
      public function addValue(param1:Number) : void
      {
         this.value = this.value + param1;
      }
   }
}
