package
{
   import mx.core.IFlexModuleFactory;
   import mx.skins.halo.ListDropIndicator;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _MenuStyle
   {
      
      private static var _embed_css_Assets_swf_MenuRadioDisabled_938260160:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioDisabled_938260160;
      
      private static var _embed_css_Assets_swf_MenuBranchDisabled_493104267:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchDisabled_493104267;
      
      private static var _embed_css_Assets_swf_MenuCheckDisabled_199808381:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckDisabled_199808381;
      
      private static var _embed_css_Assets_swf_MenuBranchEnabled_1999998216:Class = _MenuStyle__embed_css_Assets_swf_MenuBranchEnabled_1999998216;
      
      private static var _embed_css_Assets_swf_MenuSeparator_1398512322:Class = _MenuStyle__embed_css_Assets_swf_MenuSeparator_1398512322;
      
      private static var _embed_css_Assets_swf_MenuCheckEnabled_369819360:Class = _MenuStyle__embed_css_Assets_swf_MenuCheckEnabled_369819360;
      
      private static var _embed_css_Assets_swf_MenuRadioEnabled_1779161853:Class = _MenuStyle__embed_css_Assets_swf_MenuRadioEnabled_1779161853;
       
      
      public function _MenuStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("Menu");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("Menu",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.radioIcon = _embed_css_Assets_swf_MenuRadioEnabled_1779161853;
               this.borderStyle = "menuBorder";
               this.paddingTop = 1;
               this.rightIconGap = 15;
               this.branchIcon = _embed_css_Assets_swf_MenuBranchEnabled_1999998216;
               this.checkDisabledIcon = _embed_css_Assets_swf_MenuCheckDisabled_199808381;
               this.verticalAlign = "middle";
               this.paddingLeft = 1;
               this.paddingRight = 0;
               this.checkIcon = _embed_css_Assets_swf_MenuCheckEnabled_369819360;
               this.radioDisabledIcon = _embed_css_Assets_swf_MenuRadioDisabled_938260160;
               this.dropShadowEnabled = true;
               this.branchDisabledIcon = _embed_css_Assets_swf_MenuBranchDisabled_493104267;
               this.dropIndicatorSkin = ListDropIndicator;
               this.separatorSkin = _embed_css_Assets_swf_MenuSeparator_1398512322;
               this.horizontalGap = 6;
               this.leftIconGap = 18;
               this.paddingBottom = 1;
            };
         }
      }
   }
}
