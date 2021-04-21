package anifire.effect
{
   public class EffectMgr
   {
      
      public static const TYPE_UPSIDEDOWN:String = "UPSIDEDOWN";
      
      public static const XML_NODE_TAG:String = "effect";
      
      private static var _effect:SuperEffect = new SuperEffect();
      
      public static const TYPE_HOVERING:String = "HOVERING";
      
      public static const TYPE_FADING_OUT:String = "FADING_OUT";
      
      public static const TYPE_SEPIA:String = "SEPIA";
      
      public static const TYPE_BUMPYRIDE:String = "BUMPYRIDE";
      
      private static var _effectName:String = null;
      
      public static const TYPE_FADING:String = "FADING";
      
      public static const TYPE_FADING_IN:String = "FADING_IN";
      
      public static const TYPE_ANIME:String = "ANIME";
      
      public static const TYPE_FIRESPRING:String = "FIRESPRING";
      
      public static const TYPE_DRALERT:String = "DRA";
      
      private static var _name:String = "Effect";
      
      public static const TYPE_FIREWORK:String = "FIREWORK";
      
      public static const TYPE_GRAYSCALE:String = "GRAYSCALE";
      
      public static const TYPE_CUT:String = "CUT";
      
      public static const TYPE_ZOOM:String = "ZOOM";
      
      public static const TYPE_EARTHQUAKE:String = "EARTHQUAKE";
      
      public static const TYPE_PAN:String = "PAN";
       
      
      public function EffectMgr()
      {
         super();
      }
      
      public static function getResize(param1:XML) : String
      {
         return param1.@resize;
      }
      
      public static function getType(param1:XML) : String
      {
         return param1.@type;
      }
      
      public static function getEffectByXML(param1:XML) : SuperEffect
      {
         var _loc2_:String = param1.@type;
         var _loc3_:String = param1.@isCut;
         var _loc4_:String = param1.@isPan;
         var _loc5_:String = param1.@isIn;
         var _loc6_:String = param1.@isOut;
         var _loc7_:String = "";
         if(_loc3_ != null && _loc3_ == "true")
         {
            _loc7_ = TYPE_CUT;
         }
         if(_loc4_ != null && _loc4_ == "true")
         {
            _loc7_ = TYPE_PAN;
         }
         if(_loc5_ != null && _loc5_ == "true")
         {
            _loc7_ = TYPE_FADING_IN;
         }
         if(_loc6_ != null && _loc6_ == "true")
         {
            _loc7_ = TYPE_FADING_OUT;
         }
         var _loc8_:SuperEffect;
         (_loc8_ = createEffect(_loc2_,_loc7_)).deSerialize(param1);
         _loc8_.mouseChildren = false;
         _loc8_.mouseEnabled = false;
         return _loc8_;
      }
      
      public static function getFileNameInThemeZip(param1:XML) : String
      {
         var _loc2_:String = param1.@type;
         var _loc3_:String = param1.@isCut;
         var _loc4_:String = param1.@isPan;
         var _loc5_:String = param1.@isIn;
         var _loc6_:String = param1.@isOut;
         var _loc7_:String = "";
         if(_loc3_ != null && _loc3_ == "true")
         {
            _loc7_ = TYPE_CUT;
         }
         if(_loc4_ != null && _loc4_ == "true")
         {
            _loc7_ = TYPE_PAN;
         }
         if(_loc5_ != null && _loc5_ == "true")
         {
            _loc7_ = TYPE_FADING_IN;
         }
         if(_loc6_ != null && _loc6_ == "true")
         {
            _loc7_ = TYPE_FADING_OUT;
         }
         return createEffect(_loc2_,_loc7_).getFileName(param1);
      }
      
      public static function get name() : String
      {
         return _name;
      }
      
      private static function createEffect(param1:String = "ZOOM", param2:String = "") : SuperEffect
      {
         switch(param1)
         {
            case TYPE_ZOOM:
               _effect = new ZoomEffect(param2);
               _name = _name + ("_" + TYPE_ZOOM);
               return _effect;
            case TYPE_FADING:
               _effect = new FadingEffect(param2);
               _name = _name + ("_" + TYPE_FADING);
               return _effect;
            case TYPE_EARTHQUAKE:
               _effect = new EarthquakeEffect();
               _name = _name + ("_" + TYPE_EARTHQUAKE);
               return _effect;
            case TYPE_UPSIDEDOWN:
               _effect = new UpsideDownEffect();
               _name = _name + ("_" + TYPE_UPSIDEDOWN);
               return _effect;
            case TYPE_FIREWORK:
               _effect = new FireworkEffect();
               _name = _name + ("_" + TYPE_FIREWORK);
               return _effect;
            case TYPE_FIRESPRING:
               _effect = new FireSpringEffect();
               _name = _name + ("_" + TYPE_FIRESPRING);
               return _effect;
            case TYPE_HOVERING:
               _effect = new HoveringEffect();
               _name = _name + ("_" + TYPE_HOVERING);
               return _effect;
            case TYPE_DRALERT:
               _effect = new DRAlertEffect();
               _name = _name + ("_" + TYPE_DRALERT);
               return _effect;
            case TYPE_GRAYSCALE:
               _effect = new GrayScaleEffect();
               _name = _name + ("_" + TYPE_GRAYSCALE);
               return _effect;
            case TYPE_SEPIA:
               _effect = new SepiaEffect();
               _name = _name + ("_" + TYPE_SEPIA);
               return _effect;
            case TYPE_BUMPYRIDE:
               _effect = new BumpyrideEffect();
               _name = _name + ("_" + TYPE_BUMPYRIDE);
               return _effect;
            case TYPE_ANIME:
               _effect = new AnimeEffect() as AnimeEffect;
               _name = _name + ("_" + TYPE_ANIME);
               return _effect;
            default:
               _effect = new ZoomEffect() as ProgramEffect;
               _name = _name + ("_" + TYPE_ZOOM);
               return _effect;
         }
      }
      
      public static function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public static function getId(param1:XML) : String
      {
         return param1.@id;
      }
   }
}
