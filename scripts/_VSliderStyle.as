package
{
   import mx.core.IFlexModuleFactory;
   import mx.skins.halo.SliderHighlightSkin;
   import mx.skins.halo.SliderThumbSkin;
   import mx.skins.halo.SliderTrackSkin;
   import mx.styles.CSSStyleDeclaration;
   import mx.styles.StyleManager;
   
   public class _VSliderStyle
   {
       
      
      public function _VSliderStyle()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var fbs:IFlexModuleFactory = param1;
         var style:CSSStyleDeclaration = StyleManager.getStyleDeclaration("VSlider");
         if(!style)
         {
            style = new CSSStyleDeclaration();
            StyleManager.setStyleDeclaration("VSlider",style,false);
         }
         if(style.defaultFactory == null)
         {
            style.defaultFactory = function():void
            {
               this.thumbDownSkin = null;
               this.borderColor = 9542041;
               this.thumbOverSkin = null;
               this.tickColor = 7305079;
               this.trackHighlightSkin = SliderHighlightSkin;
               this.thumbDisabledSkin = null;
               this.thumbUpSkin = null;
               this.tickThickness = 1;
               this.showTrackHighlight = false;
               this.thumbSkin = SliderThumbSkin;
               this.tickLength = 3;
               this.thumbOffset = 0;
               this.slideDuration = 300;
               this.trackColors = [15198183,15198183];
               this.labelOffset = -10;
               this.dataTipOffset = 16;
               this.trackSkin = SliderTrackSkin;
               this.dataTipPrecision = 2;
               this.dataTipPlacement = "left";
               this.tickOffset = -6;
            };
         }
      }
   }
}
