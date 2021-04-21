package
{
   import mx.core.IFlexModuleFactory;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _ApplicationControlBarStyle
   {
       
      
      public function _ApplicationControlBarStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("ApplicationControlBar");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("ApplicationControlBar",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.borderStyle = "applicationControlBar";
               this.paddingTop = 5;
               this.docked = false;
               this.dropShadowEnabled = true;
               this.shadowDistance = 5;
               this.cornerRadius = 5;
               this.fillColors = [16777215,16777215];
               this.fillAlphas = [0,0];
               this.paddingLeft = 8;
               this.paddingBottom = 4;
               this.paddingRight = 8;
            };
         }
      }
   }
}
