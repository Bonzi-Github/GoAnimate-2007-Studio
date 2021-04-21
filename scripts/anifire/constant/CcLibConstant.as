package anifire.constant
{
   import anifire.util.Util;
   import anifire.util.UtilHashArray;
   import anifire.util.UtilLicense;
   import flash.geom.Point;
   
   public class CcLibConstant
   {
      
      public static const PROBABILITY_RANDOM_FROM_PRE_MADE_CHAR:Number = 1;
      
      public static const COMPONENT_TYPE_UPPER_BODY:String = "upper_body";
      
      public static const COMPONENT_TYPE_LOWER_BODY:String = "lower_body";
      
      public static const COMPONENT_TYPE_MOUTH:String = "mouth";
      
      public static const LIBRARY_TYPE_GOBEHINDBODY:String = "GoBehindBody";
      
      public static const LEFT:String = "Left";
      
      public static const COMPONENT_THUMB_CHOOSER_TILE_GAP_SIZE:Number = 2;
      
      public static const MODE_ADDPOINTS:int = 3;
      
      public static const COUPON_VALUE:Number = 100;
      
      public static const RIGHT:String = "Right";
      
      public static const USER_LEVEL_NORMAL:int = 0;
      
      public static const COMPONENT_TYPE_BACK_HAIR:String = "backhair";
      
      public static const LIBRARY_TYPE_GOLOWER:String = "GoLower";
      
      public static const COMPONENT_TYPE_FRONT_HAIR:String = "fronthair";
      
      public static const COMPONENT_TYPE_FACESHAPE:String = "faceshape";
      
      public static const COMPONENT_GROUP_UPPER_LOWER:String = "componentGroupClothes";
      
      public static const COMPONENT_SCALE_FEMALE:Number = 0.9;
      
      public static const MODE_REFRESH:int = 2;
      
      public static const COMPONENT_TYPE_GLASSES:String = "glasses";
      
      public static const CLIPUPPER:String = "theUpper";
      
      public static const LIBRARY_TYPE_GOPROP:String = "GoProp";
      
      public static var COMPONENT_SCALE:Number = 1;
      
      public static const USER_LEVEL_SUPER:int = 999;
      
      public static const NODE_LIBRARY:String = "library";
      
      public static const COMPONENT_TYPE_FACIAL_DECORATION:String = "facedecoration";
      
      public static const COMPONENT_TYPE_FREEACTION:String = "freeaction";
      
      public static const COMPONENT_TYPE_BEARD:String = "beard";
      
      public static const MONEY_MODE_SCHOOL:int = 3;
      
      public static const TEMPLATE_CCTHUMB_WIDTH:int = 120;
      
      public static const CLIPLOWER:String = "theLower";
      
      public static const MODE_SAVE:int = 0;
      
      public static const LIB_LEFT:String = "Left";
      
      public static const LIB_RIGHT:String = "Right";
      
      public static const SWF_EXT:String = ".swf";
      
      public static const TEMPLATE_CHAR_THUMB_WIDTH:int = 130;
      
      public static const COMPONENT_THUMB_CHOOSER_THUMBNAIL_HEIGHT:Number = 60;
      
      public static const COMPONENT_TYPE_MUSTACHE:String = "mustache";
      
      public static const COMPONENT_CAT_BODY:String = "body";
      
      public static const COMPONENT_TYPE_EYE:String = "eye";
      
      public static const MONEY_MODE_FREE:int = 1;
      
      public static const COMPONENT_THUMB_CHOOSER_TILE_PADDING_SIZE:Number = 0;
      
      public static const LIBRARY_TYPE_GOUPPER:String = "GoUpper";
      
      public static const NODE_COLOR:String = "color";
      
      public static const COMPONENT_TYPE_SKELETON:String = "skeleton";
      
      public static const COMPONENT_TYPE_EAR:String = "ear";
      
      public static const MC_NAME_EXT:String = "MC";
      
      public static const MONEY_MODE_DONT_NEED_MONEY:int = 2;
      
      public static const XML_DESC:String = "desc.xml";
      
      public static const COMPONENT_TYPE_NOSE:String = "nose";
      
      public static const COMPONENT_THUMB_CHOOSER_BIGGER_THUMBNAIL_ENLARGE_RATIO:Number = 1.2;
      
      public static const NODE_COMPONENT:String = "component";
      
      public static const SHOULD_DECRYPT:Boolean = true;
      
      public static const MONEY_MODE_NORMAL:int = 0;
      
      public static const COMPONENT_TYPE_HAIR:String = "hair";
      
      public static const COMPONENT_TYPE_EYEBROW:String = "eyebrow";
      
      public static const COMPONENT_SCALE_MALE:Number = 1;
      
      public static const COMPONENT_CAT_HEAD:String = "head";
      
      public static const PROBABILITY_OPTIONAL_COMPONENT_APPEAR_IN_RANDOMIZE:Number = 0.3;
      
      public static const MODE_NEEDLOGIN:int = 4;
      
      public static const COMPONENT_THUMB_CHOOSER_THUMBNAIL_WIDTH:Number = 60;
      
      public static const COMPONENT_THUMB_CHOOSER_DETAIL_PART_HEIGHT:Number = 25;
      
      public static const MODE_ADDBUCKS:int = 1;
      
      public static const LIBRARY_TYPE_GOHANDS:String = "GoHands";
      
      public static const COMPONENT_TYPE_BODYSHAPE:String = "bodyshape";
       
      
      public function CcLibConstant()
      {
         super();
      }
      
      public static function get ALL_COLOR_CODE_USED() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push("ccSkinColor");
         _loc1_.push("ccFaceHairColor");
         _loc1_.push("ccUpperMain");
         _loc1_.push("ccUpperMinor");
         _loc1_.push("ccLowerMain");
         _loc1_.push("ccLowerMinor");
         _loc1_.push("ccDecMajor");
         _loc1_.push("ccDecMinor");
         _loc1_.push("ccEyeLib");
         _loc1_.push("ccEyeIris");
         _loc1_.push("ccMouthLip");
         _loc1_.push("ccGlassesFrame");
         _loc1_.push("ccGlassesLens");
         _loc1_.push("ccHairMajor");
         _loc1_.push("ccHairMinor");
         _loc1_.push("ccEyebrow");
         _loc1_.push("ccHandMain");
         _loc1_.push("ccHandMinor");
         _loc1_.push("ccBackMajor");
         _loc1_.push("ccBackMinor");
         _loc1_.push("ccBeard");
         _loc1_.push("ccMustache");
         return _loc1_;
      }
      
      public static function get ALL_HEAD_COMPONENT_TYPES() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_EYE);
         _loc1_.push(COMPONENT_TYPE_GLASSES);
         _loc1_.push(COMPONENT_TYPE_EAR);
         _loc1_.push(COMPONENT_TYPE_MOUTH);
         _loc1_.push(COMPONENT_TYPE_NOSE);
         _loc1_.push(COMPONENT_TYPE_MUSTACHE);
         _loc1_.push(COMPONENT_TYPE_BEARD);
         _loc1_.push(COMPONENT_TYPE_EYEBROW);
         _loc1_.push(COMPONENT_TYPE_FACESHAPE);
         _loc1_.push(COMPONENT_TYPE_HAIR);
         _loc1_.push(COMPONENT_TYPE_FACIAL_DECORATION);
         return _loc1_;
      }
      
      public static function get ALL_OFFSETABLE_COMPONENT_TYPES() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_EYE);
         _loc1_.push(COMPONENT_TYPE_GLASSES);
         _loc1_.push(COMPONENT_TYPE_EYEBROW);
         return _loc1_;
      }
      
      public static function get DEFAULT_HEADPOS() : Array
      {
         var _loc1_:Array = new Array();
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_THEME_ID) == "cc2")
         {
            _loc1_.push(new Point(0,4));
            _loc1_.push(new Point(0,0));
            _loc1_.push(new Point(0,-6));
            _loc1_.push(new Point(-13,20));
         }
         else
         {
            _loc1_.push(new Point(0,0));
            _loc1_.push(new Point(0,0));
            _loc1_.push(new Point(0,0));
            _loc1_.push(new Point(0,0));
         }
         return _loc1_;
      }
      
      public static function get DEFAULT_HEADSCALES() : Array
      {
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_THEME_ID) == "cc2")
         {
            return [0.83,1,1.49,1.18];
         }
         return [0.8,1,1.2,1.6];
      }
      
      public static function get ALL_MULTIPLE_COMPONENT_TYPES() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_FACIAL_DECORATION);
         return _loc1_;
      }
      
      public static function get OPTIONAL_COMPONENTS() : UtilHashArray
      {
         var _loc1_:UtilHashArray = new UtilHashArray();
         _loc1_.push(COMPONENT_TYPE_GLASSES,COMPONENT_TYPE_GLASSES);
         _loc1_.push(COMPONENT_TYPE_MUSTACHE,COMPONENT_TYPE_MUSTACHE);
         _loc1_.push(COMPONENT_TYPE_BEARD,COMPONENT_TYPE_BEARD);
         _loc1_.push(COMPONENT_TYPE_EYEBROW,COMPONENT_TYPE_EYEBROW);
         _loc1_.push(COMPONENT_TYPE_HAIR,COMPONENT_TYPE_HAIR);
         _loc1_.push(COMPONENT_TYPE_EYE,COMPONENT_TYPE_EYE);
         _loc1_.push(COMPONENT_TYPE_EAR,COMPONENT_TYPE_EAR);
         _loc1_.push(COMPONENT_TYPE_MOUTH,COMPONENT_TYPE_MOUTH);
         _loc1_.push(COMPONENT_TYPE_NOSE,COMPONENT_TYPE_NOSE);
         _loc1_.push(COMPONENT_TYPE_FACESHAPE,COMPONENT_TYPE_FACESHAPE);
         _loc1_.push(LIBRARY_TYPE_GOBEHINDBODY,LIBRARY_TYPE_GOBEHINDBODY);
         return _loc1_;
      }
      
      public static function get DEFAULT_BODYSCALES() : Array
      {
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_THEME_ID) == "cc2")
         {
            return [1.35,1,0.74,1];
         }
         return [1.2,1,0.8,0.8];
      }
      
      public static function get USER_CHOOSE_ABLE_BODY_COMPONENT_TYPES() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_BODYSHAPE);
         _loc1_.push(COMPONENT_TYPE_UPPER_BODY);
         _loc1_.push(COMPONENT_TYPE_LOWER_BODY);
         _loc1_.push(LIBRARY_TYPE_GOUPPER);
         _loc1_.push(LIBRARY_TYPE_GOLOWER);
         _loc1_.push(LIBRARY_TYPE_GOHANDS);
         _loc1_.push(LIBRARY_TYPE_GOBEHINDBODY);
         return _loc1_;
      }
      
      public static function COLORS_BY_COMPONENT(param1:String) : Array
      {
         if(param1 == COMPONENT_TYPE_EYE)
         {
            return ["ccEyeLib","ccEyeIris","ccSkinColor"];
         }
         if(param1 == COMPONENT_TYPE_MOUTH)
         {
            return ["ccMouthLip","ccSkinColor"];
         }
         return null;
      }
      
      public static function get COMPONENT_TYPE_CHOOSER_COMPONENT_GROUP() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_GROUP_UPPER_LOWER);
         return _loc1_;
      }
      
      public static function get ALL_LIBRARY_TYPES() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(LIBRARY_TYPE_GOUPPER);
         _loc1_.push(LIBRARY_TYPE_GOLOWER);
         _loc1_.push(LIBRARY_TYPE_GOHANDS);
         _loc1_.push(LIBRARY_TYPE_GOBEHINDBODY);
         return _loc1_;
      }
      
      public static function IS_TAKE_ORIGINAL_COLOR(param1:String) : Boolean
      {
         if(ALL_LIBRARY_TYPES.indexOf(param1) > -1)
         {
            return true;
         }
         if(param1 == COMPONENT_TYPE_HAIR)
         {
            return true;
         }
         return false;
      }
      
      public static function GET_COMPONENT_TYPE_OCCURANCE_PROBABILITY(param1:String) : Number
      {
         var _loc2_:UtilHashArray = new UtilHashArray();
         _loc2_.push(COMPONENT_TYPE_EYE,1);
         _loc2_.push(COMPONENT_TYPE_GLASSES,0.3);
         _loc2_.push(COMPONENT_TYPE_EAR,1);
         _loc2_.push(COMPONENT_TYPE_MOUTH,1);
         _loc2_.push(COMPONENT_TYPE_NOSE,1);
         _loc2_.push(COMPONENT_TYPE_MUSTACHE,0.1);
         _loc2_.push(COMPONENT_TYPE_BEARD,0.1);
         _loc2_.push(COMPONENT_TYPE_EYEBROW,1);
         _loc2_.push(COMPONENT_TYPE_FACESHAPE,1);
         _loc2_.push(COMPONENT_TYPE_HAIR,0.95);
         _loc2_.push(COMPONENT_TYPE_FACIAL_DECORATION,0);
         _loc2_.push(COMPONENT_TYPE_UPPER_BODY,1);
         _loc2_.push(COMPONENT_TYPE_LOWER_BODY,1);
         _loc2_.push(COMPONENT_TYPE_SKELETON,1);
         _loc2_.push(LIBRARY_TYPE_GOBEHINDBODY,0.3);
         _loc2_.push(LIBRARY_TYPE_GOHANDS,1);
         _loc2_.push(LIBRARY_TYPE_GOLOWER,1);
         _loc2_.push(LIBRARY_TYPE_GOPROP,0);
         _loc2_.push(LIBRARY_TYPE_GOUPPER,1);
         var _loc3_:Array = ALL_MULTIPLE_COMPONENT_TYPES;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_.push(_loc3_[_loc4_],0);
            _loc4_++;
         }
         if(_loc2_.containsKey(param1))
         {
            return _loc2_.getValueByKey(param1) as Number;
         }
         return 1;
      }
      
      public static function get USER_CHOOSE_ABLE_HEAD_COMPONENT_TYPES() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_EYE);
         _loc1_.push(COMPONENT_TYPE_GLASSES);
         _loc1_.push(COMPONENT_TYPE_EAR);
         _loc1_.push(COMPONENT_TYPE_MOUTH);
         _loc1_.push(COMPONENT_TYPE_NOSE);
         _loc1_.push(COMPONENT_TYPE_MUSTACHE);
         _loc1_.push(COMPONENT_TYPE_BEARD);
         _loc1_.push(COMPONENT_TYPE_EYEBROW);
         _loc1_.push(COMPONENT_TYPE_FACESHAPE);
         _loc1_.push(COMPONENT_TYPE_HAIR);
         _loc1_.push(COMPONENT_TYPE_FACIAL_DECORATION);
         return _loc1_;
      }
      
      public static function get GET_COMPONENT_ORDER_IN_HEAD() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_BACK_HAIR);
         _loc1_.push(COMPONENT_TYPE_FACESHAPE);
         _loc1_.push(COMPONENT_TYPE_MOUTH);
         _loc1_.push(COMPONENT_TYPE_BEARD);
         _loc1_.push(COMPONENT_TYPE_MUSTACHE);
         _loc1_.push(COMPONENT_TYPE_HAIR);
         _loc1_.push(COMPONENT_TYPE_EYE + RIGHT);
         _loc1_.push(COMPONENT_TYPE_GLASSES + RIGHT);
         _loc1_.push(COMPONENT_TYPE_EYEBROW + RIGHT);
         _loc1_.push(COMPONENT_TYPE_NOSE);
         _loc1_.push(COMPONENT_TYPE_EYE + LEFT);
         _loc1_.push(COMPONENT_TYPE_GLASSES + LEFT);
         _loc1_.push(COMPONENT_TYPE_EYEBROW + LEFT);
         _loc1_.push(COMPONENT_TYPE_EAR);
         _loc1_.push(COMPONENT_TYPE_FRONT_HAIR);
         _loc1_.push(COMPONENT_TYPE_FACIAL_DECORATION);
         return _loc1_;
      }
      
      public static function get COMPONENT_TYPE_CHOOSER_ORDERING_VER1() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_BODYSHAPE);
         if(UtilLicense.getCurrentLicenseId() == "8")
         {
            _loc1_.push(COMPONENT_GROUP_UPPER_LOWER);
         }
         else
         {
            _loc1_.push(COMPONENT_TYPE_UPPER_BODY);
            _loc1_.push(COMPONENT_TYPE_LOWER_BODY);
         }
         _loc1_.push(COMPONENT_TYPE_FACESHAPE);
         _loc1_.push(COMPONENT_TYPE_HAIR);
         _loc1_.push(COMPONENT_TYPE_EYE);
         _loc1_.push(COMPONENT_TYPE_EYEBROW);
         _loc1_.push(COMPONENT_TYPE_NOSE);
         _loc1_.push(COMPONENT_TYPE_MUSTACHE);
         _loc1_.push(COMPONENT_TYPE_BEARD);
         _loc1_.push(COMPONENT_TYPE_MOUTH);
         _loc1_.push(COMPONENT_TYPE_EAR);
         _loc1_.push(COMPONENT_TYPE_GLASSES);
         _loc1_.push(COMPONENT_TYPE_FACIAL_DECORATION);
         return _loc1_;
      }
      
      public static function get ALL_BODY_COMPONENT_TYPES() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_UPPER_BODY);
         _loc1_.push(COMPONENT_TYPE_LOWER_BODY);
         _loc1_.push(COMPONENT_TYPE_SKELETON);
         _loc1_.push(COMPONENT_TYPE_FREEACTION);
         _loc1_.push(LIBRARY_TYPE_GOUPPER);
         _loc1_.push(LIBRARY_TYPE_GOLOWER);
         _loc1_.push(LIBRARY_TYPE_GOHANDS);
         _loc1_.push(LIBRARY_TYPE_GOBEHINDBODY);
         return _loc1_;
      }
      
      public static function get ALL_COMPONENT_TYPES() : Array
      {
         return ALL_HEAD_COMPONENT_TYPES.concat(ALL_BODY_COMPONENT_TYPES);
      }
      
      public static function get COMPONENT_TYPE_CHOOSER_ORDERING_VER2() : Array
      {
         var _loc1_:Array = new Array();
         _loc1_.push(COMPONENT_TYPE_BODYSHAPE);
         _loc1_.push(LIBRARY_TYPE_GOUPPER);
         _loc1_.push(LIBRARY_TYPE_GOLOWER);
         _loc1_.push(LIBRARY_TYPE_GOHANDS);
         _loc1_.push(LIBRARY_TYPE_GOBEHINDBODY);
         _loc1_.push(COMPONENT_TYPE_FACESHAPE);
         _loc1_.push(COMPONENT_TYPE_HAIR);
         _loc1_.push(COMPONENT_TYPE_EYE);
         _loc1_.push(COMPONENT_TYPE_EYEBROW);
         _loc1_.push(COMPONENT_TYPE_NOSE);
         _loc1_.push(COMPONENT_TYPE_MOUTH);
         _loc1_.push(COMPONENT_TYPE_EAR);
         _loc1_.push(COMPONENT_TYPE_GLASSES);
         _loc1_.push(COMPONENT_TYPE_FACIAL_DECORATION);
         return _loc1_;
      }
   }
}
