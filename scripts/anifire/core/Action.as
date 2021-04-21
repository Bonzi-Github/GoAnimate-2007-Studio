package anifire.core
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class Action extends Behavior
   {
      
      public static const XML_NODE_NAME:String = "action";
       
      
      private var _nextActionId:String;
      
      private var _logger:ILogger;
      
      private var _actionGroup:ActionGroup;
      
      private var _defaultActionId:String;
      
      private var _propXML:XML;
      
      private var _isMotion:Boolean = false;
      
      public function Action(param1:CharThumb, param2:String, param3:String, param4:int, param5:String, param6:String, param7:XML = null)
      {
         this._logger = Log.getLogger("core.Action");
         this.propXML = param7;
         super(param1,param2,param3,param4,param5,param6);
         this._logger.debug("Action initialized");
      }
      
      public function get isMotion() : Boolean
      {
         return this._isMotion;
      }
      
      public function get nextActionId() : String
      {
         return this._nextActionId;
      }
      
      public function set isMotion(param1:Boolean) : void
      {
         this._isMotion = param1;
      }
      
      public function set nextActionId(param1:String) : void
      {
         this._nextActionId = param1;
      }
      
      public function get actionGroup() : ActionGroup
      {
         return this._actionGroup;
      }
      
      public function set defaultActionId(param1:String) : void
      {
         this._defaultActionId = param1;
      }
      
      public function get defaultActionId() : String
      {
         return this._defaultActionId;
      }
      
      public function set propXML(param1:XML) : void
      {
         this._propXML = param1;
      }
      
      public function set actionGroup(param1:ActionGroup) : void
      {
         this._actionGroup = param1;
      }
      
      public function get propXML() : XML
      {
         return this._propXML;
      }
   }
}
