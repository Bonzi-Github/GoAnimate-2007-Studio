package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _TabNavigatorStyle
   {
       
      
      public function _TabNavigatorStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("TabNavigator");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("TabNavigator",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderStyle = "solid";
               this.paddingTop = 10;
               this.borderColor = 11187123;
               this.backgroundColor = 16777215;
               this.horizontalAlign = "left";
               this.horizontalGap = -1;
               this.tabOffset = 0;
            };
         }
      }
   }
}
