package anifire.core
{
   import anifire.util.UtilXmlInfo;
   
   public class SpeechData
   {
       
      
      private var _pitch:Number;
      
      private var _speed:Number;
      
      private var _text:String;
      
      private var _hasZoom:Boolean;
      
      private var _type:String;
      
      private var _voice:String;
      
      public function SpeechData()
      {
         super();
      }
      
      public function get pitch() : Number
      {
         return this._pitch;
      }
      
      public function get speed() : Number
      {
         return this._speed;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get hasZoom() : Boolean
      {
         return this._hasZoom;
      }
      
      public function set pitch(param1:Number) : void
      {
         this._pitch = param1;
      }
      
      public function set speed(param1:Number) : void
      {
         this._speed = param1;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
      }
      
      public function serialize() : String
      {
         var _loc1_:* = "";
         _loc1_ = _loc1_ + "<ttsdata>";
         _loc1_ = _loc1_ + ("<type>" + UtilXmlInfo.cdata(this._type) + "</type>");
         if(this._text != null)
         {
            _loc1_ = _loc1_ + ("<text>" + UtilXmlInfo.cdata(this._text) + "</text>");
         }
         if(this._voice != null)
         {
            _loc1_ = _loc1_ + ("<voice>" + UtilXmlInfo.cdata(this._voice) + "</voice>");
         }
         return _loc1_ + "</ttsdata>";
      }
      
      public function set hasZoom(param1:Boolean) : void
      {
         this._hasZoom = param1;
      }
      
      public function set voice(param1:String) : void
      {
         this._voice = param1;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get voice() : String
      {
         return this._voice;
      }
      
      public function set type(param1:String) : void
      {
         this._type = param1;
      }
      
      public function deserialize(param1:XML) : void
      {
         this._type = param1.type.length() > 0?param1.type[0]:"tts";
         this._text = param1.text.length() > 0?param1.text[0]:"";
         this._voice = param1.voice.length() > 0?param1.voice[0]:"";
      }
   }
}
