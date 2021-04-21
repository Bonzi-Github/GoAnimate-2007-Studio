package anifire.core
{
   public class ActionGroup
   {
       
      
      private var _name:String;
      
      private var _actions:Array;
      
      public function ActionGroup(param1:String)
      {
         this._actions = new Array();
         super();
         this._name = param1;
      }
      
      public function addAction(param1:Action) : void
      {
         this._actions.push(param1);
         param1.actionGroup = this;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get actions() : Array
      {
         return this._actions.concat();
      }
   }
}
