package anifire.event
{
   public class LazyHelperEvent extends ExtraDataEvent
   {
      
      public static const CONTAINER_BEING_FIRST_SHOWN:String = "container_being_first_shown";
      
      public static const SCROLLED_TO_THE_END:String = "scrolled_to_the_end";
       
      
      public function LazyHelperEvent(param1:String, param2:Object, param3:Object = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param2,param3,param4,param5);
      }
   }
}
