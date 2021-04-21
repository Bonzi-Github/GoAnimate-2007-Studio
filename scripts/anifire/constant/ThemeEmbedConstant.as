package anifire.constant
{
   import flash.utils.ByteArray;
   
   public class ThemeEmbedConstant
   {
      
      public static var defaultThemeId:String = "";
      
      public static var _commonThemeZip:ByteArray;
      
      public static const DEFAULT_VIDEO_THUMBNAIL:Class = ThemeEmbedConstant_DEFAULT_VIDEO_THUMBNAIL;
      
      public static const DEFAULT_LOADING_THUMBNAIL:Class = ThemeEmbedConstant_DEFAULT_LOADING_THUMBNAIL;
      
      public static var _defaultThemeZip:ByteArray;
      
      public static const DEFAULT_EFFECT_THUMBNAIL:Class = ThemeEmbedConstant_DEFAULT_EFFECT_THUMBNAIL;
       
      
      public function ThemeEmbedConstant()
      {
         super();
      }
      
      public static function set commonThemeZip(param1:ByteArray) : void
      {
         _commonThemeZip = param1;
      }
      
      public static function set defaultThemeZip(param1:ByteArray) : void
      {
         _defaultThemeZip = param1;
      }
      
      public static function get defaultThemeZip() : ByteArray
      {
         if(_defaultThemeZip != null)
         {
            _defaultThemeZip.position = 0;
         }
         return _defaultThemeZip;
      }
      
      public static function get commonThemeZip() : ByteArray
      {
         if(_commonThemeZip != null)
         {
            _commonThemeZip.position = 0;
         }
         return _commonThemeZip;
      }
   }
}
