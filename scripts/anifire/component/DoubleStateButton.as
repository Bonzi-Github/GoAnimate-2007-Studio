package anifire.component
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   import mx.binding.Binding;
   import mx.binding.IBindingClient;
   import mx.binding.IWatcherSetupUtil;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   
   use namespace mx_internal;
   
   public class DoubleStateButton extends Canvas implements IBindingClient
   {
      
      public static const STATE_BUT1:int = 0;
      
      public static const EVENT_BUT2_CLICK:String = "But2Click";
      
      private static const BUT2_ID:int = 1;
      
      private static const BUT1_ID:int = 0;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static const EVENT_BUT1_CLICK:String = "But1Click";
      
      public static const STATE_BUT2:int = 1;
       
      
      private var _but1Label:String = "";
      
      private var _but2StyleName:String = "btnStop";
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _but2Label:String = "";
      
      private var _3035600but1:Button;
      
      private var _3035601but2:Button;
      
      private var _but1StyleName:String = "btnPlay";
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindings:Array;
      
      public function DoubleStateButton()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"but1",
                  "events":{"click":"__but1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "buttonMode":true,
                        "x":0,
                        "y":0
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"but2",
                  "events":{"click":"__but2_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "buttonMode":true,
                        "visible":false,
                        "x":0,
                        "y":0
                     };
                  }
               })]};
            }
         });
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         DoubleStateButton._watcherSetupUtil = param1;
      }
      
      private function set _1910655069but2Label(param1:String) : void
      {
         this._but2Label = param1;
      }
      
      public function __but2_click(param1:MouseEvent) : void
      {
         this.but2ClickHandler(param1);
      }
      
      public function enableBut1(param1:Boolean) : void
      {
         this.but1.enabled = param1;
      }
      
      private function _DoubleStateButton_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = but1Label;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            but1.label = param1;
         },"but1.label");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return this.but1StyleName;
         },function(param1:Object):void
         {
            but1.styleName = param1;
         },"but1.styleName");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = but2Label;
            return _loc1_ == undefined?null:String(_loc1_);
         },function(param1:String):void
         {
            but2.label = param1;
         },"but2.label");
         result[2] = binding;
         binding = new Binding(this,function():Object
         {
            return this.but2StyleName;
         },function(param1:Object):void
         {
            but2.styleName = param1;
         },"but2.styleName");
         result[3] = binding;
         return result;
      }
      
      public function get but1Label() : String
      {
         return this._but1Label;
      }
      
      private function set _480504565but2StyleName(param1:String) : void
      {
         this._but2StyleName = param1;
      }
      
      private function set _283991060but1StyleName(param1:String) : void
      {
         this._but1StyleName = param1;
      }
      
      public function get but2StyleName() : String
      {
         return this._but2StyleName;
      }
      
      [Bindable(event="propertyChange")]
      public function set but2Label(param1:String) : void
      {
         var _loc2_:Object = this.but2Label;
         if(_loc2_ !== param1)
         {
            this._1910655069but2Label = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"but2Label",_loc2_,param1));
         }
      }
      
      public function setState(param1:int) : void
      {
         if(param1 == DoubleStateButton.STATE_BUT1)
         {
            this.but1.visible = true;
            this.but2.visible = false;
         }
         else if(param1 == DoubleStateButton.STATE_BUT2)
         {
            this.but1.visible = false;
            this.but2.visible = true;
         }
      }
      
      private function but1ClickHandler(param1:Event) : void
      {
         this.setState(DoubleStateButton.STATE_BUT2);
         this.dispatchEvent(new Event(DoubleStateButton.EVENT_BUT1_CLICK));
      }
      
      private function but2ClickHandler(param1:Event) : void
      {
         this.setState(DoubleStateButton.STATE_BUT1);
         this.dispatchEvent(new Event(DoubleStateButton.EVENT_BUT2_CLICK));
      }
      
      override public function initialize() : void
      {
         var target:DoubleStateButton = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._DoubleStateButton_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_anifire_component_DoubleStateButtonWatcherSetupUtil");
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
      
      [Bindable(event="propertyChange")]
      public function set but2StyleName(param1:String) : void
      {
         var _loc2_:Object = this.but2StyleName;
         if(_loc2_ !== param1)
         {
            this._480504565but2StyleName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"but2StyleName",_loc2_,param1));
         }
      }
      
      public function set but1(param1:Button) : void
      {
         var _loc2_:Object = this._3035600but1;
         if(_loc2_ !== param1)
         {
            this._3035600but1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"but1",_loc2_,param1));
         }
      }
      
      public function set but2(param1:Button) : void
      {
         var _loc2_:Object = this._3035601but2;
         if(_loc2_ !== param1)
         {
            this._3035601but2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"but2",_loc2_,param1));
         }
      }
      
      public function get but2Label() : String
      {
         return this._but2Label;
      }
      
      private function _DoubleStateButton_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.but1Label;
         _loc1_ = this.but1StyleName;
         _loc1_ = this.but2Label;
         _loc1_ = this.but2StyleName;
      }
      
      [Bindable(event="propertyChange")]
      public function get but2() : Button
      {
         return this._3035601but2;
      }
      
      [Bindable(event="propertyChange")]
      public function set but1StyleName(param1:String) : void
      {
         var _loc2_:Object = this.but1StyleName;
         if(_loc2_ !== param1)
         {
            this._283991060but1StyleName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"but1StyleName",_loc2_,param1));
         }
      }
      
      private function set _1939284220but1Label(param1:String) : void
      {
         this._but1Label = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get but1() : Button
      {
         return this._3035600but1;
      }
      
      public function get but1StyleName() : String
      {
         return this._but1StyleName;
      }
      
      public function enableBut2(param1:Boolean) : void
      {
         this.but2.enabled = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function set but1Label(param1:String) : void
      {
         var _loc2_:Object = this.but1Label;
         if(_loc2_ !== param1)
         {
            this._1939284220but1Label = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"but1Label",_loc2_,param1));
         }
      }
      
      public function __but1_click(param1:MouseEvent) : void
      {
         this.but1ClickHandler(param1);
      }
   }
}
