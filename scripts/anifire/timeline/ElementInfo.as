package anifire.timeline
{
   public class ElementInfo
   {
      
      public static const SCENE:String = "scene";
      
      public static const SOUND:String = "sound";
       
      
      private var _stime:Number;
      
      private var _inner_volume:Number;
      
      private var _actionTime:Number;
      
      private var _id:String;
      
      private var _type:String;
      
      private var _y:Number;
      
      public function ElementInfo(param1:String, param2:String, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Number = 1)
      {
         super();
         this._id = param2;
         this._type = param1;
         this._stime = param3;
         this._actionTime = param4;
         this._y = param5;
         this._inner_volume = param6;
      }
      
      public function set inner_volume(param1:Number) : void
      {
         this._inner_volume = param1;
      }
      
      public function set startPixel(param1:Number) : void
      {
         this._stime = param1;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
      }
      
      public function get startPixel() : Number
      {
         return this._stime;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get totalPixel() : Number
      {
         return this._actionTime;
      }
      
      public function get inner_volume() : Number
      {
         return this._inner_volume;
      }
      
      public function set totalPixel(param1:Number) : void
      {
         this._actionTime = param1;
      }
      
      public function get actionPixel() : Number
      {
         return this._actionTime;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
   }
}
