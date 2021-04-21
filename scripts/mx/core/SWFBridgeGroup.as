package mx.core
{
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import mx.managers.ISystemManager;
   
   use namespace mx_internal;
   
   public class SWFBridgeGroup implements ISWFBridgeGroup
   {
      
      mx_internal static const VERSION:String = "3.3.0.4852";
       
      
      private var _parentBridge:IEventDispatcher;
      
      private var _childBridges:Dictionary;
      
      private var _groupOwner:ISystemManager;
      
      public function SWFBridgeGroup(param1:ISystemManager)
      {
         super();
         _groupOwner = param1;
      }
      
      public function getChildBridgeProvider(param1:IEventDispatcher) : ISWFBridgeProvider
      {
         if(!_childBridges)
         {
            return null;
         }
         return ISWFBridgeProvider(_childBridges[param1]);
      }
      
      public function removeChildBridge(param1:IEventDispatcher) : void
      {
         var _loc2_:* = null;
         if(!_childBridges || !param1)
         {
            return;
         }
         for(_loc2_ in _childBridges)
         {
            if(_loc2_ == param1)
            {
               delete _childBridges[_loc2_];
            }
         }
      }
      
      public function get parentBridge() : IEventDispatcher
      {
         return _parentBridge;
      }
      
      public function containsBridge(param1:IEventDispatcher) : Boolean
      {
         var _loc2_:* = null;
         if(parentBridge && parentBridge == param1)
         {
            return true;
         }
         for(_loc2_ in _childBridges)
         {
            if(param1 == _loc2_)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set parentBridge(param1:IEventDispatcher) : void
      {
         _parentBridge = param1;
      }
      
      public function addChildBridge(param1:IEventDispatcher, param2:ISWFBridgeProvider) : void
      {
         if(!_childBridges)
         {
            _childBridges = new Dictionary();
         }
         _childBridges[param1] = param2;
      }
      
      public function getChildBridges() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = [];
         for(_loc2_ in _childBridges)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
   }
}
