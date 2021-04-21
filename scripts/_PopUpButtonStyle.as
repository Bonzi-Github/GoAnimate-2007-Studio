package
{
   import mx.core.IFlexModuleFactory;
   import mx.skins.halo.PopUpButtonSkin;
   import mx.skins.halo.PopUpIcon;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _PopUpButtonStyle
   {
       
      
      public function _PopUpButtonStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("PopUpButton");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("PopUpButton",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.popUpGap = 0;
               this.arrowButtonWidth = 18;
               this.popUpIcon = PopUpIcon;
               this.skin = PopUpButtonSkin;
               this.paddingLeft = 3;
               this.paddingRight = 3;
            };
         }
      }
   }
}
