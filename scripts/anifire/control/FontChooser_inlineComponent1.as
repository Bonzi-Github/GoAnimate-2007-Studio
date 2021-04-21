package anifire.control
{
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.controls.Label;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class FontChooser_inlineComponent1 extends Label implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
       
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _88844982outerDocument:FontChooser;
      
      public function FontChooser_inlineComponent1()
      {
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         this.buttonMode = true;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         FontChooser_inlineComponent1._watcherSetupUtil = param1;
      }
      
      public function set outerDocument(param1:FontChooser) : void
      {
         var _loc2_:Object = this._88844982outerDocument;
         if(_loc2_ !== param1)
         {
            this._88844982outerDocument = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"outerDocument",_loc2_,param1));
         }
      }
      
      private function _FontChooser_inlineComponent1_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = data.data;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            this.setStyle("fontFamily",param1);
         },"this.fontFamily");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = data.data;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            this.toolTip = param1;
         },"this.toolTip");
         result[1] = binding;
         return result;
      }
      
      override public function initialize() : void
      {
         var target:FontChooser_inlineComponent1 = null;
         var watcherSetupUtilClass:Object = null;
         var bindings:Array = this._FontChooser_inlineComponent1_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_control_FontChooser_inlineComponent1WatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      private function _FontChooser_inlineComponent1_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = data.data;
         _loc1_ = data.data;
      }
      
      [Bindable(event="propertyChange")]
      public function get outerDocument() : FontChooser
      {
         return this._88844982outerDocument;
      }
   }
}
