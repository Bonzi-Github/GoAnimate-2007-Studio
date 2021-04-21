package flexlib.controls
{
   import flexlib.controls.sliderClasses.ExtendedSlider;
   import mx.controls.sliderClasses.SliderDirection;
   
   public class HSlider extends ExtendedSlider
   {
       
      
      public function HSlider()
      {
         super();
         direction = SliderDirection.HORIZONTAL;
      }
   }
}
