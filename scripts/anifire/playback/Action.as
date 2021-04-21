package anifire.playback
{
   import anifire.util.UtilHashArray;
   
   public class Action extends Behaviour
   {
      
      public static const XML_TAG:String = "action";
       
      
      public function Action()
      {
         super();
      }
      
      public function init(param1:XML, param2:UtilHashArray, param3:PlayerDataStock) : Boolean
      {
         var _loc4_:Boolean = false;
         if(!(_loc4_ = super.initBehaviour(param1,XML_TAG,param2,param3)))
         {
            trace("init behaviour failure.");
            return false;
         }
         return true;
      }
      
      public function initDependency(param1:Number, param2:Motion, param3:Number, param4:Action, param5:Number, param6:UtilHashArray, param7:Boolean) : void
      {
         prevBehavior = param2 == null?param4:param2;
         if(param2 != null && param3 > 0)
         {
            if(param2.getFile() == this.getFile())
            {
               this.setLocalStartFrame(param2.getLocalEndFrame() + 1);
               this.firstBehavior = param2.firstBehavior;
               param2.nextBehavior = this;
            }
            else
            {
               this.setLocalStartFrame(1);
               this.isFirstBehavior = true;
               this.firstBehavior = this;
            }
         }
         else if(param4 != null && param5 > 0)
         {
            if(param4.getFile() == this.getFile())
            {
               this.setLocalStartFrame(param4.getLocalEndFrame() + 1);
               this.firstBehavior = param4.firstBehavior;
               param4.nextBehavior = this;
            }
            else
            {
               this.setLocalStartFrame(1);
               this.isFirstBehavior = true;
               this.firstBehavior = this;
            }
         }
         else
         {
            this.setLocalStartFrame(1);
            this.isFirstBehavior = true;
            this.firstBehavior = this;
         }
         this.setLocalEndFrame(this.getLocalStartFrame() + param1 - 1);
         this.initLoader(param7);
      }
   }
}
