package anifire.core
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class State extends Behavior
   {
      
      public static const XML_NODE_NAME:String = "state";
       
      
      private var _logger:ILogger;
      
      public function State(param1:PropThumb, param2:String, param3:String, param4:int, param5:String, param6:String)
      {
         this._logger = Log.getLogger("core.Action");
         super(param1,param2,param3,param4,param5,param6);
         this._logger.debug("Action initialized");
      }
   }
}
