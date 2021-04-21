package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TitleWindowStyle
   {
      
      private static var _embed_css_Assets_swf_CloseButtonDown_2077549540:Class = _TitleWindowStyle__embed_css_Assets_swf_CloseButtonDown_2077549540;
      
      private static var _embed_css_Assets_swf_CloseButtonOver_1907217654:Class = _TitleWindowStyle__embed_css_Assets_swf_CloseButtonOver_1907217654;
      
      private static var _embed_css_Assets_swf_CloseButtonDisabled_2139910946:Class = _TitleWindowStyle__embed_css_Assets_swf_CloseButtonDisabled_2139910946;
      
      private static var _embed_css_Assets_swf_CloseButtonUp_831584381:Class = _TitleWindowStyle__embed_css_Assets_swf_CloseButtonUp_831584381;
       
      
      public function _TitleWindowStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TitleWindow");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("TitleWindow",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.closeButtonDisabledSkin = _embed_css_Assets_swf_CloseButtonDisabled_2139910946;
               this.paddingTop = 4;
               this.dropShadowEnabled = true;
               this.backgroundColor = 16777215;
               this.closeButtonOverSkin = _embed_css_Assets_swf_CloseButtonOver_1907217654;
               this.closeButtonUpSkin = _embed_css_Assets_swf_CloseButtonUp_831584381;
               this.closeButtonDownSkin = _embed_css_Assets_swf_CloseButtonDown_2077549540;
               this.cornerRadius = 8;
               this.paddingLeft = 4;
               this.paddingBottom = 4;
               this.paddingRight = 4;
            };
         }
      }
   }
}
