package anifire.core
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class Facial extends Behavior
   {
      
      public static const XML_NODE_NAME:String = "facial";
      
      private static var _logger:ILogger = Log.getLogger("core.Facial");
       
      
      public function Facial(param1:CharThumb, param2:String, param3:String, param4:int, param5:String, param6:String)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
   }
}
