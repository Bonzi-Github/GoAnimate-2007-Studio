package flexlib.containers
{
   import flexlib.containers.utilityClasses.FlowLayout;
   import mx.containers.Box;
   import mx.containers.BoxDirection;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class FlowBox extends Box
   {
       
      
      public function FlowBox()
      {
         super();
         direction = BoxDirection.HORIZONTAL;
         layoutObject = new FlowLayout();
         mx_internal::layoutObject.target = this;
      }
      
      override public function set direction(param1:String) : void
      {
         super.direction = BoxDirection.HORIZONTAL;
      }
   }
}
