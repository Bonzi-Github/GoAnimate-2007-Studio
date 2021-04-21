package anifire.bubble
{
   public class BubbleMgr
   {
      
      public static const BLANKTAIL:String = "BLANKTAIL";
      
      private static var _shapeName:String = null;
      
      public static const CLOUD:String = "CLOUD";
      
      public static const RECTANGULAR:String = "RECTANGULAR";
      
      public static const HEART:String = "HEART";
      
      public static const BOOM:String = "BOOM";
      
      public static const ROUNDRECTANGULAR:String = "ROUNDRECTANGULAR";
      
      private static var _name:String = "BubbleElement";
      
      private static var _bubble:Bubble = new Bubble();
      
      public static const BLANK:String = "BLANK";
      
      public static const IMAGE:String = "IMAGE";
      
      public static const ELLIPSE:String = "ELLIPSE";
       
      
      public function BubbleMgr()
      {
         super();
      }
      
      public static function getBubble(param1:String = "RECTANGULAR") : Bubble
      {
         return createBubble(param1);
      }
      
      public static function get name() : String
      {
         return _name;
      }
      
      public static function isSameBubble(param1:Bubble, param2:Bubble) : Boolean
      {
         if(param1.width == param2.width && param1.height == param2.height && param1.x == param2.x && param1.y == param2.y && param1.rotation == param2.rotation && param1.fillRgb == param2.fillRgb && param1.lineRgb == param2.lineRgb && param1.tailx == param2.tailx && param1.taily == param2.taily && param1.textRgb == param2.textRgb && param1.textFont == param2.textFont && param1.textSize == param2.textSize && param1.textAlign == param2.textAlign && param1.textBold == param2.textBold && param1.textItalic == param2.textBold && param1.text == param2.text)
         {
            return true;
         }
         return false;
      }
      
      public static function getBubbleByXML(param1:XML, param2:Number = -1) : Bubble
      {
         var _loc3_:String = param1.@type;
         var _loc4_:Bubble;
         (_loc4_ = createBubble(_loc3_)).deSerialize(param1,param2);
         return _loc4_;
      }
      
      public static function set name(param1:String) : void
      {
         _name = param1;
      }
      
      private static function createBubble(param1:String = "RECTANGULAR") : Bubble
      {
         switch(param1)
         {
            case RECTANGULAR:
               _bubble = new PlainRectangularBubble() as Bubble;
               _name = _name + ("_" + RECTANGULAR);
               return _bubble;
            case ROUNDRECTANGULAR:
               _bubble = new RoundedRectangularBubble() as Bubble;
               _name = _name + ("_" + ROUNDRECTANGULAR);
               return _bubble;
            case ELLIPSE:
               _bubble = new EllipseBubble() as Bubble;
               _name = _name + ("_" + ELLIPSE);
               return _bubble;
            case CLOUD:
               _bubble = new CloudBubble() as Bubble;
               _name = _name + ("_" + CLOUD);
               return _bubble;
            case HEART:
               _bubble = new HeartBubble() as Bubble;
               _name = _name + ("_" + HEART);
               return _bubble;
            case BOOM:
               _bubble = new BoomBubble() as Bubble;
               _name = _name + ("_" + BOOM);
               return _bubble;
            case BLANK:
               _bubble = new BlankBubble() as Bubble;
               _name = _name + ("_" + BLANK);
               return _bubble;
            case BLANKTAIL:
               _bubble = new BlankTailBubble() as Bubble;
               _name = _name + ("_" + BLANK);
               return _bubble;
            default:
               _bubble = new PlainRectangularBubble() as Bubble;
               _name = _name + ("_" + RECTANGULAR);
               return _bubble;
         }
      }
   }
}
